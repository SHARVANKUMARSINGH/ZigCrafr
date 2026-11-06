//! Transpiled from Horizon Rust crate
package horizon_shaders_preprocess

import "core:fmt"
import "core:mem"
import "core:math"

// The GLSL preprocessor a program's stage file goes through before translation (spec 1.4,
// 1.5, 1.6): comments removed, `#include` expanded, conditionals evaluated, macros expanded.
// Every output line remembers the pack file and line it came from, so errors found later point
// at the pack's own code.
//
// `#include` is expanded where it stands in live code only: an include inside a false `#if`
// is not read, so it can't fail (OQ-14). Ten levels deep at most, which also stops a file that
// includes itself. `#version` and `#extension` are taken out of the code and kept apart: the
// translation writes its own header.

// use std::collections::HashMap;

// use crate::Macros;
// use crate::Pack;
// use crate::condition::{Conditionals, split_directive};
// use crate::pack::normalize;

MAX_DEPTH :: 10
// How many lines one macro call may span.
MAX_CALL_LINES :: 64

// Where a line came from: an index into [`Preprocessed::files`] and a line number from 1.
Origin :: struct {
    file: u16,
    line: u32,
}

Diagnostic :: struct {
    origin: Origin,
    message: string,
}

Preprocessed :: struct {
    // The code, one line per entry of `lines`.
    code: string,
    lines: [dynamic]Origin,
    // The pack paths of the files read, the stage file first.
    files: [dynamic]string,
    // The stage's `#version`, the first one read (an included file's too): the number and the
    // profile word, if any.
    version: Option<(u32,
    // `#extension` lines of live code, as written after `#extension`.
    extensions: [dynamic]string,
    // The text of every block comment in live code (`DRAWBUFFERS:`, buffer formats).
    comments: Vec<(Origin,
    diagnostics: [dynamic]Diagnostic,
    // Conditions that could not be evaluated and read as false: noted, the program still runs.
    warnings: [dynamic]Diagnostic,
}

    // rust: impl Preprocessed {
    // `file:line` of an output line (from 0), for messages.
locate :: proc(self: ^Self, line: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let o = self.lines.get(line).copied().unwrap_or_default();
    // rust: let file = self.files.get(o.file as usize).map_or("?", String::as_str);
    // rust: format!("{file}:{}", o.line)
}
}

// Runs the preprocessor on the stage file `path` of `pack` with `macros` defined.
preprocess :: proc(pack: ^Pack, path: string, macros: ^Macros) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut run = Run {
    // rust: pack,
    // rust: macros: macros.clone(),
    // rust: conditionals: Conditionals::default(),
    // rust: out: Preprocessed::default(),
    // rust: code: Vec::new(),
    // rust: texts: HashMap::new(),
}
    // rust: run.file(path, 0, Origin::default());
    // Iris 1.11.7 draws a program whose `#if` stays open to its end: a warning, as there.
    // rust: if run.conditionals.open() {
    // rust: run.out.warnings.push(Diagnostic {
    // rust: origin: Origin::default(),
    // rust: message: "`#if` without `#endif`: read to the end of the file".into(),
    // rust: });
}
    // rust: run.out.code = run.code.join("\n");
    // rust: run.out
}

Run :: struct {
    pack: ^'p Pack,
    macros: Macros,
    conditionals: Conditionals,
    out: Preprocessed,
    code: [dynamic]string,
    // Files already read: a guarded header is included many times.
    texts: HashMap<string,
}

    // rust: impl Run<'_> {
file :: proc(self: ^Self, path: string, depth: uint, from: Origin) {
}
    // rust: let cached = self
    // rust: .texts
    // rust: .entry(path.to_owned())
    // rust: .or_insert_with(|| self.pack.read_text(path));
    // rust: let Some(text) = cached.clone() else {
    // rust: return self.diagnose(from, &format!("can't find `{path}`"));
}
    // rust: let file = match self.out.files.iter().position(|f| f == path) {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: self.out.files.push(path.to_owned());
    // rust: self.out.files.len() - 1
}
    // rust: } as u16;
    // rust: let (text, comments) = strip_comments(&text);
    // rust: let lines: Vec<&str> = text.split('\n').map(|l| l.trim_end_matches('\r')).collect();
    // rust: let mut comments = comments.into_iter().peekable();
    // rust: let mut n = 0;
    // rust: while n < lines.len() {
    // rust: let first = n;
    // rust: let mut line = lines[n].to_owned();
    // rust: while line.ends_with('\\') && n + 1 < lines.len() {
    // rust: line.pop();
    // rust: n += 1;
    // rust: line.push_str(lines[n]);
}
    // rust: n += 1;
            // A macro call's arguments may span lines: they join the line the call starts on.
    // rust: if !line.trim_start().starts_with('#') && self.conditionals.active() {
    // rust: while n < lines.len()
    // rust: && n - first < MAX_CALL_LINES
    // rust: && !lines[n].trim_start().starts_with('#')
    // rust: && self.macros.unfinished_call(&line, &lines[n..])
    // rust: {
    // rust: line.push(' ');
    // rust: line.push_str(lines[n]);
    // rust: n += 1;
}
}
    // rust: let origin = Origin {
    // rust: file,
    // rust: line: first as u32 + 1,
}
    // rust: self.line(&line, origin, path, depth);
    // rust: for k in first + 1..n {
    // rust: self.emit(
    // rust: String::new(),
    // rust: Origin {
    // rust: file,
    // rust: line: k as u32 + 1,
    // rust: },
    // rust: );
}
    // rust: while let Some((_, comment)) = comments.next_if(|(at, _)| *at < n) {
    // rust: if self.conditionals.active() {
    // rust: self.out.comments.push((origin, comment));
}
}
}
}

line :: proc(self: ^Self, line: string, origin: Origin, path: string, depth: uint) {
}
    // rust: let Some(after) = line.trim_start().strip_prefix('#') else {
    // rust: let code = if self.conditionals.active() {
    // rust: self.macros.define("__LINE__", origin.line.to_string());
    // rust: self.macros.expand(line)
    // rust: } else {
    // rust: String::new()
}
    // rust: return self.emit(code, origin);
}
    // rust: self.emit(String::new(), origin);
    // rust: let Some((word, rest)) = split_directive(after) else {
    // rust: return self.diagnose(origin, &format!("unknown directive `#{}`", after.trim()));
}
    // rust: match self.conditionals.apply(word, rest, &self.macros) {
            // As Iris loads such a pack: the branch is skipped, the program kept.
    // rust: Err(e) if e.ends_with("read as false") => {
    // rust: return self.out.warnings.push(Diagnostic { origin, message: e });
}
            // Iris 1.11.7 logs a stray `#endif` and draws the program: it is ignored.
    // rust: Err(e) if word == "endif" => {
    // rust: let message = format!("{e}: ignored");
    // rust: return self.out.warnings.push(Diagnostic { origin, message });
}
    // rust: Err(e) => return self.diagnose(origin, &e),
    // rust: Ok(true) => return,
    // rust: Ok(false) if !self.conditionals.active() => return,
    // rust: Ok(false) => {}
}
    // rust: match word {
    // rust: "define" => self.define(rest, origin),
    // rust: "undef" => self.macros.undef(rest),
    // rust: "include" => {
    // rust: let target = rest.trim_matches(|c| c == '"' || c == '<' || c == '>');
    // rust: match resolve(path, target) {
    // rust: _ if depth + 1 >= MAX_DEPTH => self.diagnose(
    // rust: origin,
    // rust: &format!("`{target}`: includes nest more than {MAX_DEPTH} deep"),
    // rust: ),
    // rust: Some(file) => {
                        // The include line's own (empty) output line stays; the file follows.
    // rust: self.file(&file, depth + 1, origin);
}
    // rust: None => self.diagnose(origin, &format!("`{target}` is outside the pack")),
}
}
            // The first `#version`, also from an included file (a pack's common header).
    // rust: "version" if self.out.version.is_none() => {
    // rust: let mut words = rest.split_whitespace();
    // rust: let number = words.next().and_then(|v| v.parse().ok()).unwrap_or(110);
    // rust: self.out.version = Some((number, words.next().map(str::to_owned)));
    // rust: self.macros.define("__VERSION__", number.to_string());
}
    // rust: "extension" => self.out.extensions.push(rest.to_owned()),
    // rust: "error" => self.diagnose(origin, &format!("#error {rest}")),
    // rust: "version" | "pragma" | "line" | "" => {}
    // rust: _ => self.diagnose(origin, &format!("unknown directive `#{word}`")),
}
}

define :: proc(self: ^Self, rest: string, origin: Origin) {
}
    // rust: if let Err(e) = self.macros.define_line(rest) {
    // rust: self.diagnose(origin, &e);
}
}

emit :: proc(self: ^Self, code: string, origin: Origin) {
}
    // rust: self.code.push(code);
    // rust: self.out.lines.push(origin);
}

diagnose :: proc(self: ^Self, origin: Origin, message: string) {
}
    // rust: self.out.diagnostics.push(Diagnostic {
    // rust: origin,
    // rust: message: message.to_owned(),
    // rust: });
}
}

// An `#include` path: from the `shaders` folder with a leading `/`, else from the including
// file's folder (spec 1.4). `None` when it climbs out of the pack.
resolve :: proc(from_file: string, target: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match target.strip_prefix('/') {
    // rust: Some(absolute) => normalize(absolute),
    // rust: None => {
    // rust: let dir = from_file.rsplit_once('/').map_or("", |(dir, _)| dir);
    // rust: normalize(&format!("{dir}/{target}"))
}
}
}

// `text` with comments replaced by spaces (new lines kept, so line numbers hold), and the body of
// each block comment with the index of the line it starts on.
strip_comments :: proc(text: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(text.len());
    // rust: let mut comments = Vec::new();
    // rust: let (mut rest, mut line) = (text, 0);
    // rust: while let Some(at) = rest.find('/') {
    // rust: let (before, from) = rest.split_at(at);
    // rust: out.push_str(before);
    // rust: line += before.matches('\n').count();
    // rust: if let Some(body) = from.strip_prefix("//") {
            // A line comment ending in a backslash includes the next line (GLSL 4.60, 3.4; Iris
            // does so too): such a comment runs on. Its line breaks stay.
    // rust: let mut end = body.len();
    // rust: for (at, _) in body.match_indices('\n') {
    // rust: if !body[..at].trim_end_matches('\r').ends_with('\\') {
    // rust: end = at;
    // rust: break;
}
}
    // rust: let joined = body[..end].matches('\n').count();
    // rust: line += joined;
    // rust: out.extend(std::iter::repeat_n('\n', joined));
    // rust: rest = &body[end..];
    // rust: } else if let Some(body) = from.strip_prefix("/*") {
    // rust: let end = body.find("*/").unwrap_or(body.len());
    // rust: let comment = &body[..end];
    // rust: comments.push((line, comment.to_owned()));
    // rust: let newlines = comment.matches('\n').count();
    // rust: line += newlines;
    // rust: out.push(' ');
    // rust: out.extend(std::iter::repeat_n('\n', newlines));
    // rust: rest = body.get(end + 2..).unwrap_or("");
    // rust: } else {
    // rust: out.push('/');
    // rust: rest = &from[1..];
}
}
    // rust: out.push_str(rest);
    // rust: (out, comments)
}

    // rust: mod tests {
//     use super::*;
//     use crate::pack::tests::zip;

run :: proc(files: ^[(string) {
}
    // rust: let files: Vec<(String, &str)> = files
    // rust: .iter()
    // rust: .map(|(p, t)| (format!("shaders/{p}"), *t))
    // rust: .collect();
    // rust: let files: Vec<(&str, &str)> = files.iter().map(|(p, t)| (p.as_str(), *t)).collect();
    // rust: let pack = Pack::from_zip_bytes("P.zip", zip(&files)).unwrap();
    // rust: preprocess(&pack, "program/final.fsh", &Macros::standard())
}

code_lines :: proc(p: ^Preprocessed) -> V {
    // Ported from Horizon
    return {}
}
    // rust: p.code
    // rust: .lines()
    // rust: .enumerate()
    // rust: .filter(|(_, l)| !l.trim().is_empty())
    // rust: .map(|(i, l)| (l.trim(), p.locate(i)))
    // rust: .collect()
}

includes_resolve_and_lines_map_back :: proc() {
}
    // rust: let p = run(&[
    // rust: (
    // rust: "program/final.fsh",
    // rust: "#version 330 compatibility\n#include \"/lib/a.glsl\"\nvoid main() {}\n",
    // rust: ),
    // rust: (
    // rust: "lib/a.glsl",
    // rust: "#ifndef A\n#define A\n#include \"b.glsl\"\nfloat a;\n#endif\n",
    // rust: ),
    // rust: ("lib/b.glsl", "// b\nfloat b;\n#include \"a.glsl\"\n"),
    // rust: ]);
    // rust: assert_eq!(p.version, Some((330, Some("compatibility".into()))));
    // rust: assert_eq!(
    // rust: code_lines(&p),
    // rust: [
    // rust: ("float b;", "lib/b.glsl:2".into()),
    // rust: ("float a;", "lib/a.glsl:4".into()),
    // rust: ("void main() {}", "program/final.fsh:3".into()),
    // rust: ]
    // rust: );
    // rust: assert!(p.diagnostics.is_empty(), "{:?}", p.diagnostics);
}

missing_and_runaway_includes_are_diagnosed_where_they_stand :: proc() {
}
    // rust: let p = run(&[(
    // rust: "program/final.fsh",
    // rust: "#ifdef NOPE\n#include \"gone.glsl\"\n#endif\n#include \"gone.glsl\"\n#include \"final.fsh\"\n",
    // rust: )]);
    // rust: let messages: Vec<String> = p
    // rust: .diagnostics
    // rust: .iter()
    // rust: .map(|d| format!("{}: {}", d.origin.line, d.message))
    // rust: .collect();
    // rust: assert_eq!(messages[0], "4: can't find `program/gone.glsl`");
    // rust: assert!(
    // rust: messages
    // rust: .last()
    // rust: .unwrap()
    // rust: .ends_with("includes nest more than 10 deep")
    // rust: );
    // rust: assert!(
    // rust: run(&[("program/final.fsh", "#include \"../../x\"")]).diagnostics[0]
    // rust: .message
    // rust: .contains("outside")
    // rust: );
}

macros_expand_like_the_glsl_preprocessor :: proc() {
}
    // rust: let p = run(&[(
    // rust: "program/final.fsh",
    // rust: "#define SQ(x) ((x) * (x))\n#define CAT(a, b) a ## b\n#define N 4\n#define \\\n  LONG 1\n\
    // rust: float v = SQ(N + 1) + CAT(N, 2) + LONG;\nint l = __LINE__;\n#if MC_VERSION > 12100 && defined MC_RENDER_STAGE_SKY\nint ok;\n#else\nint bad;\n#endif\n",
    // rust: )]);
    // rust: let lines: Vec<&str> = code_lines(&p).into_iter().map(|(l, _)| l).collect();
    // rust: assert_eq!(
    // rust: lines,
    // rust: [
    // rust: "float v = ((4 + 1) * (4 + 1)) + N2 + 1;",
    // rust: "int l = 7;",
    // rust: "int ok;"
    // rust: ]
    // rust: );
    // rust: assert_eq!(p.lines.len(), p.code.split('\n').count());
}

macro_arguments_span_lines :: proc() {
}
    // rust: let p = run(&[(
    // rust: "program/final.fsh",
    // rust: "#define CLAMP01(x) clamp(x, 0.0, 1.0)\nfloat v = CLAMP01(\n    a * (b\n    + c)\n);\nfloat w;\n",
    // rust: )]);
    // rust: assert_eq!(
    // rust: code_lines(&p),
    // rust: [
    // rust: (
    // rust: "float v = clamp(a * (b     + c), 0.0, 1.0);",
    // rust: "program/final.fsh:2".into()
    // rust: ),
    // rust: ("float w;", "program/final.fsh:6".into())
    // rust: ]
    // rust: );
    // rust: assert_eq!(p.lines.len(), p.code.split('\n').count());
}

comments_extensions_and_errors :: proc() {
}
    // rust: let p = run(&[(
    // rust: "program/final.fsh",
    // rust: "#version 120\n#extension GL_ARB_shader_texture_lod : enable\n/* DRAWBUFFERS:04 */\n#if 0\n/* RENDERTARGETS: 1 */\n#error dead\n#endif\n\
    // rust: /* multi\nline */ float x; // gone\n#error live\n#bogus\n",
    // rust: )]);
    // rust: assert_eq!(p.extensions, ["GL_ARB_shader_texture_lod : enable"]);
    // rust: let comments: Vec<&str> = p.comments.iter().map(|(_, c)| c.trim()).collect();
    // rust: assert_eq!(comments, ["DRAWBUFFERS:04", "multi\nline"]);
    // rust: assert_eq!(code_lines(&p), [("float x;", "program/final.fsh:9".into())]);
    // rust: let messages: Vec<&str> = p.diagnostics.iter().map(|d| d.message.as_str()).collect();
    // rust: assert_eq!(messages, ["#error live", "unknown directive `#bogus`"]);
}

    // A line comment ending in a backslash runs on to the next line, as in Iris: the line it
    // takes is not code and not a directive, and later lines keep their numbers.
a_line_comment_runs_on_after_a_backslash :: proc() {
}
    // rust: let p = run(&[(
    // rust: "program/final.fsh",
    // rust: "#version 330\n#if 1\nfloat a; // ends in a backslash \\\n#endif\n\
             // alone \\\r\n#define HIDDEN\n#ifdef HIDDEN\nfloat b;\n#endif\nfloat c;\n#endif\n",
    // rust: )]);
    // rust: assert!(p.diagnostics.is_empty(), "{:?}", p.diagnostics);
    // rust: assert_eq!(
    // rust: code_lines(&p),
    // rust: [
    // rust: ("float a;", "program/final.fsh:3".into()),
    // rust: ("float c;", "program/final.fsh:10".into()),
    // rust: ]
    // rust: );
}

    // A stray `#endif` and an `#if` left open are warnings, as in Iris 1.11.7 (which draws such
    // a program): the `#endif` is ignored, the open `#if` reads on to the end of the file.
unbalanced_conditionals_warn_and_the_code_goes_on :: proc() {
}
    // rust: let p = run(&[(
    // rust: "program/final.fsh",
    // rust: "#version 330\n#ifdef NEVER\nfloat a;\n#else\nfloat b;\n#endif\n#endif\n\
    // rust: #if 1\nfloat c;\n",
    // rust: )]);
    // rust: assert!(p.diagnostics.is_empty(), "{:?}", p.diagnostics);
    // rust: let warnings: Vec<&str> = p.warnings.iter().map(|w| w.message.as_str()).collect();
    // rust: assert_eq!(
    // rust: warnings,
    // rust: [
    // rust: "`#endif` without `#if`: ignored",
    // rust: "`#if` without `#endif`: read to the end of the file"
    // rust: ]
    // rust: );
    // rust: let code: Vec<&str> = code_lines(&p).iter().map(|(c, _)| *c).collect();
    // rust: assert_eq!(code, ["float b;", "float c;"]);
}

    // A condition that can't be evaluated is a warning and reads as false; the code goes on.
bad_conditions_warn_and_read_false :: proc() {
}
    // rust: let p = run(&[(
    // rust: "program/final.fsh",
    // rust: "#if (in(biome, BIOME_SOUL_SAND_VALLEY)\nfloat a;\n#else\nfloat b;\n#endif\nfloat c;\n",
    // rust: )]);
    // rust: assert!(p.diagnostics.is_empty(), "{:?}", p.diagnostics);
    // rust: assert_eq!(p.warnings.len(), 1);
    // rust: let code: Vec<&str> = code_lines(&p).iter().map(|(c, _)| *c).collect();
    // rust: assert_eq!(code, ["float b;", "float c;"]);
}
}
