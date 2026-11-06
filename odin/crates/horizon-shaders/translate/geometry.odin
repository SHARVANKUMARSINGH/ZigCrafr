//! Transpiled from Horizon Rust crate
package horizon_shaders_geometry

import "core:fmt"
import "core:mem"
import "core:math"

// A program with a geometry stage (`shadow.gsh`), which wgpu lacks: its vertex, geometry and
// fragment stages become one vertex stage and the fragment stage. The game draws its triangles
// without an index buffer, three vertices each, and one instance per triangle the geometry stage
// can emit: vertex invocation `v` of instance `t` stands for corner `v % 3` of the stage's
// triangle `t`. It reads its input triangle's three vertices itself (`GeometryInputs::index`,
// `pull`), runs the pack's vertex stage on each, then the geometry stage, keeping the corner it
// stands for; a corner the stage does not emit is degenerate.
//
// The geometry stage runs once per output corner; the image and buffer writes it makes as
// statements run in one of them only (`hz_primary`).

// use std::collections::BTreeSet;
// use std::fmt::Write;

// use super::scan::{QUALIFIERS, STORAGE, significant};
// use super::{Error, GbuffersInputs, Program, Target};
// use crate::Preprocessed;
// use crate::macros::lex;

// How a geometry program's vertex invocations reach their triangle's vertices.
GeometryInputs :: struct {
    // The game's vertex inputs, as `GbuffersInputs`; their `layout(location = n) in`
    // declarations become plain globals the pull sets.
    inputs: GbuffersInputs,
    // GLSL statements that set the vertex inputs from vertex `hz_vertex_index` (a `uint`).
    pull: string,
    // The vertex of the `@`th corner of the draw (a `uint` expression, `hz_indices[@]`).
    index: string,
}

// Translates `vertex`, `geometry` and `fragment` (a shadow program): the program, and how many
// triangles the geometry stage can emit (the instances to draw).
    // rust: pub fn translate_geometry(
    // rust: vertex: &Preprocessed,
    // rust: geometry: &Preprocessed,
    // rust: fragment: &Preprocessed,
    // rust: inputs: &GeometryInputs,
    // rust: ) -> Result<(Program, u32), Vec<Error>> {
    // rust: let (combined, triangles) = combine(vertex, geometry, inputs)?;
    // rust: let mut gbuffers = inputs.inputs.clone();
    // rust: gbuffers.declarations = gbuffers
    // rust: .declarations
    // rust: .lines()
    // rust: .map(|l| match l.find(") in ") {
    // rust: Some(at) if l.starts_with("layout(location") => &l[at + 5..],
    // rust: _ => l,
    // rust: })
    // rust: .fold(String::new(), |s, l| s + l + "\n");
    // The pack's vertex stage reads its inputs in our loop, not in `main`.
    // rust: gbuffers.body = String::new();
    // rust: gbuffers.attributes = Vec::new();
    // rust: let program = super::translate(&combined, fragment, Target::Buffers, Some(&gbuffers), true)?;
    // rust: Ok((program, triangles))
}

// A global statement's tokens and what it declares.
Statement :: struct {
    range: std::ops::Range<uint>,
    kind: Kind,
}

Kind :: enum {
    // `in`, `out`, `attribute`, `varying`: storage, names and types (with array suffixes).
    Interface(&'static str, Vec<(String, String)>),
    // `layout(...) in;` or `out;` without a variable.
    Layout(&'static str),
    Buffer(String),
    Uniform,
    // Functions, variables, structs: the names it defines.
    Defines(Vec<String>),
}

statements :: proc(tokens: ^[string]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let (mut start, mut parens) = (0, 0usize);
    // rust: let mut i = 0;
    // rust: while i < tokens.len() {
    // rust: match tokens[i] {
    // rust: "(" => parens += 1,
    // rust: ")" => parens = parens.saturating_sub(1),
    // rust: "{" if parens == 0 => {
                // A function body, a struct or a block: to its matching `}` (and `;`).
    // rust: let mut d = 0;
    // rust: let mut j = i;
    // rust: while j < tokens.len() {
    // rust: match tokens[j] {
    // rust: "{" => d += 1,
    // rust: "}" => {
    // rust: d -= 1;
    // rust: if d == 0 {
    // rust: break;
}
}
    // rust: _ => {}
}
    // rust: j += 1;
}
    // rust: let mut end = j + 1;
    // rust: let head: Vec<&str> = tokens[start..i]
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|t| significant(t))
    // rust: .collect();
                // `struct S { } ;`, `buffer B { } name;`: to the `;`.
    // rust: if !head.contains(&"(") || head.contains(&"buffer") {
    // rust: while end < tokens.len() && tokens[end] != ";" {
    // rust: end += 1;
}
    // rust: end += 1;
}
    // rust: out.push(classify(tokens, start..end.min(tokens.len())));
    // rust: start = end.min(tokens.len());
    // rust: i = start;
    // rust: continue;
}
    // rust: ";" if parens == 0 => {
    // rust: out.push(classify(tokens, start..i + 1));
    // rust: start = i + 1;
}
    // rust: _ => {}
}
    // rust: i += 1;
}
    // rust: out
}

classify :: proc(tokens: ^[string], range: std::ops::Range<uint>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let words: Vec<&str> = tokens[range.clone()]
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|t| significant(t))
    // rust: .collect();
    // A storage word before any `(` but a leading `layout(...)`'s: in a function's parameters
    // `in` and `out` are qualifiers.
    // rust: let skip = if words.first() == Some(&"layout") {
    // rust: words.iter().position(|w| *w == ")").map_or(0, |p| p + 1)
    // rust: } else {
    // rust: 0
}
    // rust: let head = match words[skip..].iter().position(|w| *w == "(") {
    // rust: Some(p) => &words[skip..skip + p],
    // rust: None => &words[skip..],
}
    // rust: let storage = ["in", "out", "attribute", "varying"]
    // rust: .into_iter()
    // rust: .find(|s| head.contains(s));
    // rust: let kind = if let Some(p) = words.iter().position(|w| *w == "buffer") {
    // rust: Kind::Buffer(words.get(p + 1).map_or(String::new(), |s| s.to_string()))
    // rust: } else if words.contains(&"uniform") {
    // rust: Kind::Uniform
    // rust: } else if let Some(storage) = storage {
        // Skip `layout(...)`, then qualifiers, then the type and the declarators.
    // rust: let mut k = 0;
    // rust: if words.first() == Some(&"layout") {
    // rust: while k < words.len() && words[k] != ")" {
    // rust: k += 1;
}
    // rust: k += 1;
}
        // Every qualifier the translator knows (`sample`, `precise`...), in any order (GLSL
        // 4.60, 4.12): one it missed would be taken for the type, and the type for a name.
    // rust: while k < words.len() && (STORAGE.contains(&words[k]) || QUALIFIERS.contains(&words[k])) {
    // rust: k += 1;
}
    // rust: match words.get(k) {
    // rust: None | Some(&";") => Kind::Layout(storage),
    // rust: Some(ty) => {
    // rust: let mut vars = Vec::new();
    // rust: let mut j = k + 1;
    // rust: while j < words.len() && words[j] != ";" {
    // rust: let name = words[j].to_owned();
    // rust: let mut array = String::new();
    // rust: j += 1;
    // rust: while j < words.len() && !matches!(words[j], "," | ";") {
    // rust: array.push_str(words[j]);
    // rust: j += 1;
}
    // rust: j += 1;
    // rust: vars.push((name, format!("{ty}{array}")));
}
    // rust: Kind::Interface(storage, vars)
}
}
    // rust: } else {
    // rust: let mut names = Vec::new();
    // rust: let first = words.iter().position(|w| matches!(*w, "(" | "="));
    // rust: if let Some(p) = words.iter().position(|w| *w == "struct") {
    // rust: names.extend(words.get(p + 1).map(|s| s.to_string()));
    // rust: } else if let Some(p) = first.filter(|&p| words[p] == "(") {
            // A function.
    // rust: names.extend(p.checked_sub(1).map(|n| words[n].to_owned()));
    // rust: } else {
            // Variables: the last identifier before each declarator's `=` or end.
    // rust: let (mut depth, mut last, mut init) = (0, None, false);
    // rust: for w in &words {
    // rust: match *w {
    // rust: "(" | "[" | "{" => depth += 1,
    // rust: ")" | "]" | "}" => depth -= 1,
    // rust: "=" if depth == 0 => {
    // rust: names.extend(last.take());
    // rust: init = true;
}
    // rust: "," | ";" if depth == 0 => {
    // rust: if !init {
    // rust: names.extend(last.take());
}
    // rust: (last, init) = (None, false);
}
    // rust: w if depth == 0 && !init && super::scan::is_ident(w) => {
    // rust: last = Some(w.to_owned())
}
    // rust: _ => {}
}
}
}
    // rust: names.dedup();
    // rust: Kind::Defines(names)
}
    // rust: Statement { range, kind }
}

// The combined vertex stage's source, and the triangles the geometry stage can emit.
    // rust: fn combine(
    // rust: vertex: &Preprocessed,
    // rust: geometry: &Preprocessed,
    // rust: inputs: &GeometryInputs,
    // rust: ) -> Result<(Preprocessed, u32), Vec<Error>> {
    // rust: let error = |message: String| {
    // rust: vec![Error {
    // rust: file: geometry.files.first().cloned().unwrap_or_default(),
    // rust: line: 0,
    // rust: message,
    // rust: }]
}
    // Interface blocks first become plain varyings (`interface_blocks`), the vertex stage's
    // `out` block and the geometry stage's `in` array alike: what follows reads declarations
    // of one type each. The geometry stage's input blocks read as `hz_in_<block>_<member>`,
    // apart from its output blocks, which may have the same names.
    // rust: let gs_code = super::interface_blocks::flatten_as(&geometry.code, "in_");
    // rust: let vs_code = super::interface_blocks::flatten(&vertex.code);
    // rust: let gs_tokens = lex(gs_code.as_deref().unwrap_or(&geometry.code));
    // rust: let vs_tokens = lex(vs_code.as_deref().unwrap_or(&vertex.code));
    // rust: let gs = statements(&gs_tokens);
    // rust: let vs = statements(&vs_tokens);

    // The geometry stage's interface.
    // rust: let mut gs_ins: Vec<(String, String)> = Vec::new();
    // rust: let mut gs_outs: Vec<(String, String)> = Vec::new();
    // rust: let mut gs_buffers = BTreeSet::new();
    // rust: let mut max_vertices = None;
    // rust: let mut gs_text: Vec<String> = gs_tokens.iter().map(|t| t.to_string()).collect();
    // rust: for s in &gs {
    // rust: match &s.kind {
    // rust: Kind::Interface("in", vars) => {
                // The input primitive is a triangle: `in vec3 v[]` has three elements.
    // rust: let vars: Vec<(String, String)> = vars
    // rust: .iter()
    // rust: .map(|(n, ty)| (n.clone(), ty.replace("[]", "[3]")))
    // rust: .collect();
    // rust: gs_ins.extend(vars.iter().cloned());
                // One declaration per name (naga types `T a[3], b[3]`'s second wrong).
    // rust: let decls: String = vars
    // rust: .iter()
    // rust: .map(|(n, ty)| {
    // rust: let (base, array) = split_type(ty);
    // rust: format!("{base} {n}{array}; ")
    // rust: })
    // rust: .collect();
    // rust: blank(&mut gs_text, s.range.clone());
    // rust: gs_text[s.range.start] = decls + &gs_text[s.range.start];
}
    // rust: Kind::Interface("out", vars) => gs_outs.extend(vars.iter().cloned()),
    // rust: Kind::Layout(storage) => {
    // rust: if *storage == "out" {
    // rust: let words: Vec<&str> = gs_tokens[s.range.clone()]
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|t| significant(t))
    // rust: .collect();
    // rust: if let Some(p) = words.iter().position(|w| *w == "max_vertices") {
    // rust: max_vertices = words.get(p + 2).and_then(|n| n.parse::<u32>().ok());
}
}
    // rust: blank(&mut gs_text, s.range.clone());
}
    // rust: Kind::Buffer(name) => _ = gs_buffers.insert(name.clone()),
    // rust: _ => {}
}
}
    // rust: let Some(max_vertices) = max_vertices else {
    // rust: return Err(error("the geometry stage has no `max_vertices`".into()));
}
    // rust: for (i, t) in gs_tokens.iter().enumerate() {
    // rust: let prev = (0..i).rev().find(|&j| significant(gs_tokens[j]));
    // rust: let next = (i + 1..gs_tokens.len()).find(|&j| significant(gs_tokens[j]));
    // rust: let called = next.is_some_and(|j| gs_tokens[j] == "(");
    // rust: match *t {
    // rust: "EmitVertex" if called => gs_text[i] = "hz_emit".into(),
    // rust: "EndPrimitive" if called => gs_text[i] = "hz_end".into(),
    // rust: "gl_in" => gs_text[i] = "hz_gl_in".into(),
    // rust: "gl_Position" if prev.is_some_and(|j| gs_tokens[j] == ".") => gs_text[i] = "p".into(),
    // rust: "main" if called => gs_text[i] = "hz_gs_main".into(),
    // rust: _ => {}
}
}

    // The vertex stage: its globals renamed, its outputs plain globals, its buffer blocks the
    // geometry stage's.
    // rust: let mut defined: BTreeSet<String> = BTreeSet::new();
    // rust: let mut vs_outs: Vec<(String, String)> = Vec::new();
    // rust: let mut vs_attributes: Vec<(String, String)> = Vec::new();
    // rust: let mut vs_text: Vec<String> = vs_tokens.iter().map(|t| t.to_string()).collect();
    // rust: for s in &vs {
    // rust: match &s.kind {
    // rust: Kind::Defines(names) => defined.extend(names.iter().cloned()),
    // rust: Kind::Interface("out" | "varying", vars) => {
                // Declared again, renamed, in our head.
    // rust: vs_outs.extend(vars.iter().cloned());
    // rust: blank(&mut vs_text, s.range.clone());
}
    // rust: Kind::Interface("in" | "attribute", vars) => {
    // rust: vs_attributes.extend(vars.iter().cloned());
    // rust: strip_storage(&mut vs_text, &vs_tokens, s.range.clone());
}
    // rust: Kind::Buffer(name) if gs_buffers.contains(name) => blank(&mut vs_text, s.range.clone()),
    // rust: Kind::Layout(_) => blank(&mut vs_text, s.range.clone()),
    // rust: _ => {}
}
}
    // Implicit terrain inputs must be set for each pulled source vertex, alongside
    // declared attributes. Keep the vertex stage's name separate from geometry globals.
    // rust: let chunk_fade = inputs
    // rust: .inputs
    // rust: .attributes
    // rust: .iter()
    // rust: .find(|(name, _)| name == "mc_chunkFade")
    // rust: .filter(|_| {
    // rust: super::uses_name(&vertex.code, "mc_chunkFade")
    // rust: && !super::scan::Stage::scan(vertex, naga::ShaderStage::Vertex)
    // rust: .globals
    // rust: .contains("mc_chunkFade")
    // rust: });
    // rust: if chunk_fade.is_some() {
    // rust: defined.insert("mc_chunkFade".to_owned());
}
    // rust: let renamed: BTreeSet<&str> = defined
    // rust: .iter()
    // rust: .map(String::as_str)
    // rust: .chain(vs_outs.iter().map(|(n, _)| n.as_str()))
    // rust: .collect();
    // rust: for (i, t) in vs_tokens.iter().enumerate() {
    // rust: if vs_text[i] != *t {
    // rust: continue;
}
    // rust: let prev = (0..i).rev().find(|&j| significant(vs_tokens[j]));
    // rust: if prev.is_some_and(|j| vs_tokens[j] == ".") {
    // rust: continue;
}
    // rust: if *t == "gl_Position" {
    // rust: vs_text[i] = "hz_vs_Position".into();
    // rust: } else if matches!(*t, "gl_VertexID" | "gl_VertexIndex") {
            // The vertex the pack's vertex stage runs for, not this invocation.
    // rust: vs_text[i] = "hz_vs_vertex".into();
    // rust: } else if matches!(*t, "gl_InstanceID" | "gl_InstanceIndex") {
            // The game draws terrain uninstanced; this invocation's instance is a triangle.
    // rust: vs_text[i] = "0".into();
    // rust: } else if renamed.contains(t) {
    // rust: vs_text[i] = format!("hz_vs_{t}");
}
}

    // rust: once(&mut gs_text, &gs_tokens);
    // rust: once(&mut vs_text, &vs_tokens);

    // Ours: before the geometry stage, its emission; after the vertex stage, `main`.
    // rust: let mut head = String::from(
    // rust: "void hz_emit(); void hz_end(); struct hz_PerVertex { vec4 p; }; hz_PerVertex hz_gl_in[3];\n\
    // rust: int hz_n; int hz_strip; int hz_tri; int hz_want_tri; int hz_want_corner; bool hz_found; bool hz_primary;\n\
    // rust: vec4 hz_ring_Position[3]; vec4 hz_res_Position; vec4 hz_vs_Position; int hz_vs_vertex;\n",
    // rust: );
    // rust: if chunk_fade.is_some() {
    // rust: head.push_str("float hz_vs_mc_chunkFade;\n");
}
    // rust: for (name, ty) in &vs_outs {
    // rust: let (base, array) = split_type(ty);
    // rust: writeln!(head, "{base} hz_vs_{name}{array};").unwrap();
}
    // rust: let mut emit = String::from(
    // rust: "void hz_emit() {\n    int hz_s = hz_n % 3;\n    hz_ring_Position[hz_s] = gl_Position;\n",
    // rust: );
    // rust: let mut take = String::from("        hz_res_Position = hz_ring_Position[hz_r];\n");
    // rust: let mut result = String::from("    gl_Position = hz_found ? hz_res_Position : vec4(0.0);\n");
    // rust: for (name, ty) in &gs_outs {
    // rust: let (base, array) = split_type(ty);
    // rust: if !array.is_empty() {
    // rust: return Err(error(format!(
    // rust: "`{name}`: array outputs of a geometry stage are not supported yet"
    // rust: )));
}
    // rust: writeln!(head, "{base} hz_ring_{name}[3]; {base} hz_res_{name};").unwrap();
    // rust: writeln!(emit, "    hz_ring_{name}[hz_s] = {name};").unwrap();
    // rust: writeln!(take, "        hz_res_{name} = hz_ring_{name}[hz_r];").unwrap();
    // rust: writeln!(result, "    {name} = hz_res_{name};").unwrap();
}
    // rust: write!(
    // rust: emit,
    // rust: "    hz_n++;\n    hz_strip++;\n    if (hz_strip >= 3) {{\n        if (hz_tri == hz_want_tri) {{\n            \
    // rust: int hz_k = hz_want_corner;\n            if (((hz_strip - 3) & 1) == 1 && hz_k < 2) {{ hz_k = 1 - hz_k; }}\n            \
    // rust: int hz_r = (hz_n - 3 + hz_k) % 3;\n{take}            hz_found = true;\n        }}\n        hz_tri++;\n    }}\n}}\n\
    // rust: void hz_end() {{ hz_strip = 0; }}\n"
    // rust: )
    // rust: .unwrap();
    // rust: let body = inputs
    // rust: .inputs
    // rust: .body
    // rust: .replace("gl_VertexIndex", "hz_vertex_index");
    // rust: let mut main = String::from(
    // rust: "void main() {\n    uint hz_v = uint(gl_VertexIndex);\n    uint hz_first = hz_v / 3u * 3u;\n    \
    // rust: hz_want_corner = int(hz_v % 3u);\n    hz_want_tri = int(gl_InstanceIndex);\n    \
    // rust: hz_primary = hz_want_tri == 0 && hz_want_corner == 0;\n    \
    // rust: for (int hz_i = 0; hz_i < 3; hz_i++) {\n",
    // rust: );
    // rust: writeln!(
    // rust: main,
    // rust: "        uint hz_vertex_index = {};",
    // rust: inputs.index.replace('@', "hz_first + uint(hz_i)")
    // rust: )
    // rust: .unwrap();
    // rust: main.push_str("        hz_vs_vertex = int(hz_vertex_index);\n");
    // rust: main.push_str(&inputs.pull);
    // rust: main.push_str(&body);
    // rust: if let Some((_, value)) = chunk_fade {
    // rust: writeln!(main, "        hz_vs_mc_chunkFade = {value};").unwrap();
}
    // rust: for (name, ty) in &vs_attributes {
    // rust: let value = inputs
    // rust: .inputs
    // rust: .attributes
    // rust: .iter()
    // rust: .find(|a| &a.0 == name)
    // rust: .map_or_else(|| format!("{ty}(0)"), |a| format!("{ty}({})", a.1));
    // rust: writeln!(main, "        {name} = {value};").unwrap();
}
    // rust: main.push_str("        hz_vs_main();\n");
    // rust: for (name, _) in &vs_outs {
    // rust: let block = name.strip_prefix("hz_").map(|m| format!("hz_in_{m}"));
    // rust: if let Some((input, _)) = gs_ins
    // rust: .iter()
    // rust: .find(|(n, _)| n == name || Some(n) == block.as_ref())
    // rust: {
    // rust: writeln!(main, "        {input}[hz_i] = hz_vs_{name};").unwrap();
}
}
    // rust: main.push_str("        hz_gl_in[hz_i].p = hz_vs_Position;\n    }\n    hz_gs_main();\n");
    // rust: main.push_str(&result);
    // rust: main.push_str("}\n");

    // The source, lines mapped: ours (no file), the geometry stage, ours, the vertex stage, ours.
    // rust: let mut out = Preprocessed {
    // rust: version: geometry.version.clone().or(vertex.version.clone()),
    // rust: files: geometry.files.clone(),
    // rust: ..Default::default()
}
    // rust: let offset = out.files.len() as u16;
    // rust: out.files.extend(vertex.files.iter().cloned());
    // rust: let mut code = String::new();
    // rust: let ours = |code: &mut String, lines: &mut Vec<crate::Origin>, text: &str| {
    // rust: for l in text.lines() {
    // rust: code.push_str(l);
    // rust: code.push('\n');
    // rust: lines.push(crate::Origin::default());
}
}
    // rust: ours(&mut code, &mut out.lines, &head);
    // rust: code.push_str(&gs_text.concat());
    // rust: code.push('\n');
    // rust: out.lines.extend(geometry.lines.iter().copied());
    // rust: ours(&mut code, &mut out.lines, &emit);
    // rust: code.push_str(&vs_text.concat());
    // rust: code.push('\n');
    // rust: out.lines.extend(vertex.lines.iter().map(|o| crate::Origin {
    // rust: file: o.file + offset,
    // rust: line: o.line,
    // rust: }));
    // rust: ours(&mut code, &mut out.lines, &main);
    // rust: out.code = code.trim_end_matches('\n').to_owned();
    // rust: out.lines.truncate(out.code.split('\n').count());
    // A strip of n vertices is n - 2 triangles: at most `max_vertices - 2`, whichever of the
    // stage's paths runs.
    // rust: let triangles = max_vertices.saturating_sub(2).max(1);
    // rust: Ok((out, triangles))
}

// Functions whose calls write memory other invocations see.
writes :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: name == "imageStore" || name.starts_with("imageAtomic") || name.starts_with("atomic")
}

// Calls that write images or buffers run for one invocation of a triangle only: as statements,
// `if (!hz_primary) {} else imageStore(...)`; in an expression the others read the value instead,
// `(hz_primary ? imageAtomicOr(i, p, v) : imageLoad(i, p).x)`, `(hz_primary ? atomicAdd(m, v) : m)`.
once :: proc(text: ^[string], tokens: ^[string]) {
}
    // rust: for (i, &t) in tokens.iter().enumerate() {
    // rust: let open = (i + 1..tokens.len()).find(|&j| significant(tokens[j]));
    // rust: let Some(open) = open.filter(|&j| tokens[j] == "(") else {
    // rust: continue;
}
    // rust: if !writes(t) || text[i] != t {
    // rust: continue;
}
    // rust: let prev = (0..i).rev().find(|&j| significant(tokens[j]));
    // rust: if prev.is_none_or(|j| matches!(tokens[j], ";" | "{" | "}" | ")" | "else")) {
            // A whole if/else, so that an `else` after the statement stays the pack's.
    // rust: text[i] = format!("if (!hz_primary) {{}} else {t}");
    // rust: continue;
}
        // The call's arguments, at its top-level commas.
    // rust: let (mut depth, mut args, mut from, mut close) = (0, Vec::new(), open + 1, None);
    // rust: for (j, &u) in tokens.iter().enumerate().skip(open) {
    // rust: match u {
    // rust: "(" | "[" => depth += 1,
    // rust: ")" | "]" if depth == 1 && u == ")" => {
    // rust: args.push(tokens[from..j].concat());
    // rust: close = Some(j);
    // rust: break;
}
    // rust: ")" | "]" => depth -= 1,
    // rust: "," if depth == 1 => {
    // rust: args.push(tokens[from..j].concat());
    // rust: from = j + 1;
}
    // rust: _ => {}
}
}
    // rust: let Some(close) = close else { continue };
    // rust: let read = if t.starts_with("imageAtomic") && args.len() >= 2 {
    // rust: format!("imageLoad({}, {}).x", args[0], args[1])
    // rust: } else if t.starts_with("atomic") && !args.is_empty() {
    // rust: format!("({})", args[0])
    // rust: } else {
    // rust: continue;
}
    // rust: text[i] = format!("(hz_primary ? {t}");
    // rust: text[close] = format!(") : {read})");
}
}

// `vec3[2]` or `vec3` → (`vec3`, `[2]`).
split_type :: proc(ty: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match ty.find('[') {
    // rust: Some(at) => (&ty[..at], &ty[at..]),
    // rust: None => (ty, ""),
}
}

// Blanks a statement, keeping its new lines.
blank :: proc(text: ^[string], range: std::ops::Range<uint>) {
}
    // rust: for t in &mut text[range] {
    // rust: *t = t.chars().filter(|&c| c == '\n').collect();
}
}

// Removes a declaration's `layout(...)`, storage and interpolation words: a plain global.
strip_storage :: proc(text: ^[string], tokens: ^[string], range: std::ops::Range<uint>) {
}
    // rust: let mut in_layout = false;
    // rust: for i in range {
    // rust: match tokens[i] {
    // rust: "layout" => in_layout = true,
    // rust: ")" if in_layout => {
    // rust: in_layout = false;
    // rust: text[i] = " ".into();
    // rust: continue;
}
    // rust: _ => {}
}
    // rust: if in_layout
    // rust: || matches!(
    // rust: tokens[i],
    // rust: "in" | "out"
    // rust: | "attribute"
    // rust: | "varying"
    // rust: | "flat"
    // rust: | "smooth"
    // rust: | "noperspective"
    // rust: | "centroid"
    // rust: | "invariant"
    // rust: )
    // rust: {
    // rust: text[i] = if tokens[i].contains('\n') {
    // rust: "\n".into()
    // rust: } else {
    // rust: " ".into()
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::pack::tests::zip;
//     use crate::{Macros, Pack, preprocess};

    // `vsh`, `gsh` and `fsh` (a pack's shadow program) folded and translated.
fold :: proc(vsh: string, gsh: string, fsh: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[
    // rust: ("shaders/shadow.vsh", vsh),
    // rust: ("shaders/shadow.gsh", gsh),
    // rust: ("shaders/shadow.fsh", fsh),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let pp = |file: &str| preprocess(&pack, file, &Macros::standard());
    // rust: let inputs = GeometryInputs {
    // rust: inputs: GbuffersInputs {
    // rust: declarations: "layout(set = 3, binding = 1) readonly buffer HzVertices { uint hz_vertices[]; };\n\
    // rust: layout(location = 0) in vec3 hz_v_pos;"
    // rust: .into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n    hz_Color = vec4(1.0);\n".into(),
    // rust: ..Default::default()
    // rust: },
    // rust: pull: "        hz_v_pos = uintBitsToFloat(uvec3(hz_vertices[hz_vertex_index * 3u], \
    // rust: hz_vertices[hz_vertex_index * 3u + 1u], hz_vertices[hz_vertex_index * 3u + 2u]));\n"
    // rust: .into(),
    // rust: index: "uint(@)".into(),
}
    // rust: translate_geometry(
    // rust: &pp("shadow.vsh"),
    // rust: &pp("shadow.gsh"),
    // rust: &pp("shadow.fsh"),
    // rust: &inputs,
    // rust: )
}

a_geometry_stage_folds_into_the_vertex_stage :: proc() {
}
    // rust: let vsh = "#version 430\nout vec3 vPos;\nout vec4 vColor;\nvoid main() {\n    \
    // rust: vPos = gl_Vertex.xyz;\n    vColor = gl_Color * float(gl_InstanceID + 1);\n    \
    // rust: gl_Position = ftransform();\n}\n";
    // rust: let gsh = "#version 430\nlayout(triangles) in;\nlayout(triangle_strip, max_vertices = 4) out;\n\
    // rust: in vec3 vPos[];\nin vec4 vColor[];\nout vec4 gColor;\nvoid main() {\n    \
    // rust: for (int i = 0; i < 3; i++) {\n        gColor = vColor[i];\n        \
    // rust: gl_Position = gl_in[i].gl_Position;\n        EmitVertex();\n    }\n    \
    // rust: gl_Position = vec4(vPos[0], 1.0);\n    EmitVertex();\n    EndPrimitive();\n}\n";
    // rust: let fsh = "#version 430\nin vec4 gColor;\nvoid main() {\n    gl_FragData[0] = gColor;\n}\n";
    // rust: let (program, triangles) = fold(vsh, gsh, fsh).unwrap_or_else(|e| panic!("{e:?}"));
        // A strip of four corners is two triangles.
    // rust: assert_eq!(triangles, 2);
    // rust: assert_eq!(program.vertex.entry_points.len(), 1);
    // rust: assert_eq!(program.fragment.entry_points.len(), 1);
}

    // Stages that pass their varyings in interface blocks (GLSL 4.60, 4.3.9), members with
    // their own qualifiers: the vertex stage's `out` block, the geometry stage's `in` block
    // array and `out` block, the fragment stage's `in` block. The geometry stage's two blocks
    // share a name, as an input and an output block may (4.3.9).
interface_blocks_pass_between_the_stages :: proc() {
}
    // rust: let vsh = "#version 430\nuniform float far;\n\
    // rust: out VertexData {\n    vec4 color;\n    flat float id;\n    vec2 uv;\n} vOut;\n\
    // rust: void main() {\n    vOut.color = gl_Color;\n    vOut.id = far;\n    \
    // rust: vOut.uv = gl_Vertex.xy;\n    gl_Position = ftransform();\n}\n";
    // rust: let gsh = "#version 430\nlayout(triangles) in;\nlayout(triangle_strip, max_vertices = 3) out;\n\
    // rust: in VertexData {\n    vec4 color;\n    flat float id;\n    vec2 uv;\n} vIn[];\n\
    // rust: out VertexData {\n    vec4 color;\n    flat float id;\n} gOut;\n\
    // rust: void main() {\n    for (int i = 0; i < 3; i++) {\n        \
    // rust: gOut.color = vIn[i].color * vIn[i].uv.x;\n        gOut.id = vIn[0].id;\n        \
    // rust: gl_Position = gl_in[i].gl_Position;\n        EmitVertex();\n    }\n    \
    // rust: EndPrimitive();\n}\n";
    // rust: let fsh = "#version 430\nuniform float far;\n\
    // rust: in VertexData {\n    vec4 color;\n    flat float id;\n} gIn;\n\
    // rust: void main() {\n    gl_FragData[0] = gIn.color * gIn.id / far;\n}\n";
    // rust: let (program, triangles) = fold(vsh, gsh, fsh).unwrap_or_else(|e| panic!("{e:?}"));
    // rust: assert_eq!(triangles, 1);
    // rust: assert_eq!(program.fragment.entry_points.len(), 1);
}

    // An output qualified `sample` declares no variable named after its type (GLSL 4.60, 4.3).
sample_outputs_rename_no_type :: proc() {
}
    // rust: let vsh = "#version 430\nuniform float far;\n\
    // rust: out sample float vDepth;\nvoid main() {\n    vDepth = far;\n    \
    // rust: gl_Position = ftransform();\n}\n";
    // rust: let gsh = "#version 430\nlayout(triangles) in;\nlayout(triangle_strip, max_vertices = 3) out;\n\
    // rust: in float vDepth[];\nout float gDepth;\nvoid main() {\n    \
    // rust: for (int i = 0; i < 3; i++) {\n        gDepth = vDepth[i];\n        \
    // rust: gl_Position = gl_in[i].gl_Position;\n        EmitVertex();\n    }\n    \
    // rust: EndPrimitive();\n}\n";
    // rust: let fsh = "#version 430\nuniform float far;\nin float gDepth;\n\
    // rust: void main() {\n    gl_FragData[0] = vec4(gDepth / far);\n}\n";
    // rust: fold(vsh, gsh, fsh).unwrap_or_else(|e| panic!("{e:?}"));
}

writes_run_once_and_keep_their_else :: proc() {
}
    // rust: let code =
    // rust: "if (c) imageStore(a, p, v); else imageStore(b, p, v);\nint n = atomicAdd(m, 1);\n";
    // rust: let tokens = lex(code);
    // rust: let mut text: Vec<String> = tokens.iter().map(|t| t.to_string()).collect();
    // rust: once(&mut text, &tokens);
    // rust: assert_eq!(
    // rust: text.concat(),
    // rust: "if (c) if (!hz_primary) {} else imageStore(a, p, v); else if (!hz_primary) {} else \
    // rust: imageStore(b, p, v);\nint n = (hz_primary ? atomicAdd(m, 1) : (m));\n"
    // rust: );
}
}
