//! Transpiled from Horizon Rust crate
package horizon_shaders_properties

import "core:fmt"
import "core:mem"
import "core:math"

// `.properties` files: `shaders.properties` (spec 3.1) and the id files `block.properties`,
// `item.properties`, `entity.properties` (4.1). `key=value` lines, `#` comments, a trailing `\`
// continuing a value on the next line, and conditional directives evaluated with the
// standard and option macros (1.5 item 2). `#define` and `#undef` work in every one of them:
// a public pack defines a macro in its `shaders.properties` and tests it further down. The
// lines of custom uniforms and variables (`uniform.*`, `variable.*`) have those macros expanded.
// No other escape is read: values are names, numbers and expressions. A later duplicate key
// replaces the earlier one, with a note.

// use crate::Macros;
// use crate::condition::{Conditionals, split_directive};

// One `key=value`, with the line it starts on (from 1).
Entry :: struct {
    key: string,
    value: string,
    line: u32,
}

// Something wrong with a line, for the pack's log.
Note :: struct {
    line: u32,
    message: string,
}

Properties :: struct {
    // In file order; a key appears once (a later duplicate replaces the earlier one).
    entries: [dynamic]Entry,
    notes: [dynamic]Note,
}

    // rust: impl Properties {
    // Reads `text`; `#define`/`#undef` change the macros for the lines after them only.
parse :: proc(text: string, macros: ^Macros) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Self::default();
    // rust: let mut macros = macros.clone();
    // rust: let mut conditionals = Conditionals::default();
    // rust: let mut lines = text.lines().zip(1u32..);
    // rust: while let Some((raw, number)) = lines.next() {
    // rust: let line = raw.trim();
    // rust: let on = conditionals.active();
    // rust: if let Some(directive) = line.strip_prefix('#') {
    // rust: if let Some((word, rest)) = split_directive(directive) {
    // rust: out.directive(word, rest, number, &mut conditionals, &mut macros);
}
    // rust: continue;
}
    // rust: if !on {
    // rust: continue;
}
            // A directive line ends a continued entry, as the empty line the preprocessor leaves
            // for it would.
    // rust: let mut logical = line.to_owned();
    // rust: while ends_with_continuation(&logical) {
    // rust: logical.pop();
    // rust: let Some((next, n)) = lines.next() else {
    // rust: break;
}
    // rust: let next = next.trim();
    // rust: if let Some(directive) = next.strip_prefix('#') {
    // rust: if let Some((word, rest)) = split_directive(directive) {
    // rust: out.directive(word, rest, n, &mut conditionals, &mut macros);
}
    // rust: break;
}
    // rust: logical.push_str(next);
}
    // rust: if logical.is_empty() {
    // rust: continue;
}
    // rust: match logical.split_once('=') {
    // rust: Some((key, value)) if !key.trim().is_empty() => {
    // rust: let (mut key, mut value) = (key.trim().to_owned(), value.trim().to_owned());
                    // A custom uniform's or variable's line is read with the macros expanded, as
                    // Iris 1.11.7 reads it (probe pack): options, standard macros and this
                    // file's own `#define`s, in the name too.
    // rust: if key.starts_with("uniform.") || key.starts_with("variable.") {
    // rust: key = macros.expand(&key).trim().to_owned();
    // rust: value = macros.expand(&value).trim().to_owned();
}
    // rust: out.insert(Entry {
    // rust: key,
    // rust: value,
    // rust: line: number,
    // rust: })
}
    // rust: _ => out.note(number, "not a key=value line"),
}
}
    // rust: if conditionals.open() {
    // rust: out.note(text.lines().count() as u32, "`#if` without `#endif`");
}
    // rust: out
}

get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entry(key).map(|e| e.value.as_str())
}

entry :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.iter().find(|e| e.key == key)
}

insert :: proc(self: ^Self, entry: Entry) {
}
    // rust: if let Some(at) = self.entries.iter().position(|e| e.key == entry.key) {
    // rust: let first = self.entries.remove(at).line;
    // rust: self.note(
    // rust: entry.line,
    // rust: &format!(
    // rust: "`{}` is set again (first on line {first}); this one counts",
    // rust: entry.key
    // rust: ),
    // rust: );
}
    // rust: self.entries.push(entry);
}

note :: proc(self: ^Self, line: u32, message: string) {
}
    // rust: self.notes.push(Note {
    // rust: line,
    // rust: message: message.to_owned(),
    // rust: });
}

    // A line starting with `#` whose first word may be a directive; any other word makes it a
    // comment.
    // rust: fn directive(
    // rust: &mut self,
    // rust: word: &str,
    // rust: rest: &str,
    // rust: number: u32,
    // rust: conditionals: &mut Conditionals,
    // rust: macros: &mut Macros,
    // rust: ) {
    // rust: match conditionals.apply(word, rest, macros) {
    // rust: Err(e) => self.note(number, &e),
    // rust: Ok(true) => {}
    // rust: Ok(false) if conditionals.active() => match word {
    // rust: "define" => {
    // rust: if let Err(e) = macros.define_line(rest) {
    // rust: self.note(number, &e);
}
}
    // rust: "undef" => macros.undef(rest),
    // rust: _ => {}
    // rust: },
    // rust: Ok(false) => {}
}
}
}

// An odd number of trailing backslashes: the last one joins the next line (`\\` is a literal).
ends_with_continuation :: proc(line: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: line.bytes().rev().take_while(|&b| b == b'\\').count() % 2 == 1
}

    // rust: mod tests {
//     use super::*;

read :: proc(text: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut m = Macros::standard();
    // rust: m.define("SHADOWS", "");
    // rust: m.define("QUALITY", "2");
    // rust: Properties::parse(text, &m)
}

pairs :: proc(p: ^Properties) -> V {
    // Ported from Horizon
    return {}
}
    // rust: p.entries
    // rust: .iter()
    // rust: .map(|e| (e.key.as_str(), e.value.as_str()))
    // rust: .collect()
}

keys_values_and_comments :: proc() {
}
    // rust: let p =
    // rust: read("# a comment\n\n  sun = false\n#commented.key=1\nscreen=A B [C]\r\nbad line\n");
    // rust: assert_eq!(pairs(&p), [("sun", "false"), ("screen", "A B [C]")]);
    // rust: assert_eq!(p.entry("screen").unwrap().line, 5);
    // rust: assert_eq!(
    // rust: p.notes,
    // rust: [Note {
    // rust: line: 6,
    // rust: message: "not a key=value line".into()
    // rust: }]
    // rust: );
}

continuation_lines_join :: proc() {
}
    // rust: let p = read("screen=A B \\\n    C D\\\n  E\nsliders=X\nliteral=a\\\\\nnext=1");
    // rust: assert_eq!(
    // rust: pairs(&p),
    // rust: [
    // rust: ("screen", "A B C DE"),
    // rust: ("sliders", "X"),
    // rust: ("literal", "a\\\\"),
    // rust: ("next", "1")
    // rust: ]
    // rust: );
    // rust: assert_eq!(p.entry("sliders").unwrap().line, 4);
}

    // A continued value ending before `#else` stops there, and the line after `#endif` is an
    // entry of its own.
continuations_stop_at_directives :: proc() {
}
    // rust: let text = "#define ON\n#ifdef ON\nu = if( \\\n  a, 1.0, \\\n  0.5) \\\n#else\nu = 1.0\n#endif\n\n\
    // rust: #ifdef OFF\nv = 1 \\\n  2\n#endif\nw = 3";
    // rust: assert_eq!(pairs(&read(text)), [("u", "if( a, 1.0, 0.5)"), ("w", "3")]);
    // rust: let text = "#define ON\n#ifdef ON\nu = 1 \\\n#else\nu = 2\n#endif\nw = 3";
    // rust: assert_eq!(pairs(&read(text)), [("u", "1"), ("w", "3")]);
}

conditionals_pick_one_branch :: proc() {
}
    // rust: let p = read(
    // rust: "#if MC_VERSION >= 11300\nnew=1\n#else\nold=1\n#endif\n\
    // rust: #ifdef SHADOWS\n#if QUALITY == 1\nq=1\n#elif QUALITY == 2\nq=2\n#elif QUALITY >= 2\nq=3\n#endif\n#endif\n\
    // rust: #ifndef SHADOWS\nnone=1\n#elif 0\nnever=1\n#else\nfallback=1\n#endif\n#   ifdef SHADOWS // trailing comment\nspaced=1\n#endif",
    // rust: );
    // rust: assert_eq!(
    // rust: pairs(&p),
    // rust: [("new", "1"), ("q", "2"), ("fallback", "1"), ("spaced", "1")]
    // rust: );
    // rust: assert!(p.notes.is_empty(), "{:?}", p.notes);
}

comment_lines_are_not_directives :: proc() {
}
    // rust: let p = read("#ifdefault=1\n#iffy\n#endiff\n#else-where\nkey=1");
    // rust: assert_eq!(pairs(&p), [("key", "1")]);
    // rust: assert!(p.notes.is_empty(), "{:?}", p.notes);
}

defines_apply_to_the_lines_after_them :: proc() {
}
    // rust: let text = "#ifdef MC_OS_NONE\n#define WATER 0\n#endif\n#define WATER 8\n\
    // rust: #if WATER == 8\nblock.8=minecraft:water\n#endif\n#undef WATER\n#ifdef WATER\nno=1\n#endif";
    // rust: let p = Properties::parse(text, &Macros::default());
    // rust: assert_eq!(pairs(&p), [("block.8", "minecraft:water")]);
    // rust: assert!(p.notes.is_empty(), "{:?}", p.notes);
}

duplicate_keys_keep_the_last :: proc() {
}
    // rust: let p = read("a=1\nb=2\na=3");
    // rust: assert_eq!(pairs(&p), [("b", "2"), ("a", "3")]);
    // rust: assert_eq!(p.notes[0].line, 3);
}

broken_conditionals_are_noted :: proc() {
}
    // rust: let p = read("#endif\n#else\n#if 1 +\nx=1\n#endif\n#if 1\n#else\n#else\n");
    // rust: let lines: Vec<u32> = p.notes.iter().map(|n| n.line).collect();
    // rust: assert_eq!(lines, [1, 2, 3, 8, 8]);
    // rust: assert!(p.entries.is_empty());
}
}
