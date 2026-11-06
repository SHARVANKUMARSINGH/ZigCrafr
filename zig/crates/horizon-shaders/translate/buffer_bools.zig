//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_buffer_bools
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `bool` members of a storage buffer. GLSL gives a `bool` in a `layout(std430)` buffer a size and
//! an alignment of 4; naga does not let one into a buffer at all ("not host-shareable"). Such a
//! member becomes a `uint` of the same size and every use of it is rewritten: a read is
//! `(flag != 0u)`, a plain assignment `flag = uint(...)`. The source keeps its lines.
//!
//! What the rewrite cannot make sure of is refused with the member's name and its line, rather
//! than left for naga's unnamed "Global variable [6] '' is invalid": a compound assignment
//! (`flag |= x`), an assignment used as a value, a local or parameter of the same name, a `bool`
//! vector, and an instance array of such a buffer.

// use std::collections::BTreeMap;

// use super::Error;
// use super::scan::{is_ident, significant};
// use crate::Preprocessed;
// use crate::macros::lex;

/// A `bool` member: where its type is, and its name.
pub const Member = struct {
    type_at: usize,
    name: *'a str,
};

/// One buffer block with `bool` members.
pub const Block = struct {
    /// The `{` and the `}` of the block.
    open: usize,
    close: usize,
    /// The instance name after the `}`, if the block has one.
    instance: ?*'a str,
    members: std.ArrayList(Member<'a)>,
};

/// `pp` with its buffers' `bool` members rewritten, and what could not be.
    // rust: pub(super) fn rewrite(pp: &Preprocessed) -> (Option<Preprocessed>, Vec<Error>) {
    // rust: if !pp.code.contains("buffer") || !(pp.code.contains("bool") || pp.code.contains("bvec")) {
    // rust: return (None, Vec::new());
}
    // rust: let tokens = lex(&pp.code);
    // rust: let next = |i: usize| (i + 1..tokens.len()).find(|&j| significant(tokens[j]));
    // rust: let prev = |i: usize| (0..i).rev().find(|&j| significant(tokens[j]));
    // rust: let line_of = |at: usize| -> Error {
    // rust: let line: usize = tokens[..at.min(tokens.len())]
    // rust: .iter()
    // rust: .map(|t| t.matches('\n').count())
    // rust: .sum();
    // rust: let o = pp.lines.get(line).copied().unwrap_or_default();
    // rust: Error {
    // rust: file: pp.files.get(o.file as usize).cloned().unwrap_or_default(),
    // rust: line: o.line,
    // rust: message: String::new(),
}
}
    // rust: let mut errors = Vec::new();
    // rust: let mut fail = |at: usize, message: String| {
    // rust: let mut e = line_of(at);
    // rust: e.message = message;
    // rust: errors.push(e);
}
    // The matching close of the bracket at `open`.
    // rust: let matching = |open: usize| -> Option<usize> {
    // rust: let (up, down) = match tokens[open] {
    // rust: "{" => ("{", "}"),
    // rust: "[" => ("[", "]"),
    // rust: _ => ("(", ")"),
}
    // rust: let mut depth = 0;
    // rust: for (j, &t) in tokens.iter().enumerate().skip(open) {
    // rust: if t == up {
    // rust: depth += 1;
    // rust: } else if t == down {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: return Some(j);
}
}
}
    // rust: None
}

    // The buffer blocks that have `bool` members.
    // rust: let mut blocks: Vec<Block> = Vec::new();
    // rust: for (i, &t) in tokens.iter().enumerate() {
    // rust: if t != "buffer" {
    // rust: continue;
}
    // rust: let Some(open) = (i + 1..tokens.len())
    // rust: .take_while(|&j| !matches!(tokens[j], ";" | "(" | "}" | "="))
    // rust: .find(|&j| tokens[j] == "{")
    // rust: else {
    // rust: continue;
}
    // rust: let Some(close) = matching(open) else {
    // rust: continue;
}
    // rust: let instance = next(close).filter(|&j| is_ident(tokens[j]));
    // rust: let mut members = Vec::new();
        // Statements of the block, split at their `;`.
    // rust: let mut start = open + 1;
    // rust: while start < close {
    // rust: let end = (start..close).find(|&j| tokens[j] == ";").unwrap_or(close);
    // rust: let words: Vec<usize> = (start..end).filter(|&j| significant(tokens[j])).collect();
    // rust: start = end + 1;
    // rust: let mut k = 0;
            // Qualifiers: `layout(...)`, `readonly`...
    // rust: while let Some(&w) = words.get(k) {
    // rust: if tokens[w] == "layout" {
    // rust: k = words
    // rust: .iter()
    // rust: .position(|&x| Some(x) == matching(words[k + 1]))
    // rust: .map_or(words.len(), |p| p + 1);
    // rust: } else if matches!(
    // rust: tokens[w],
    // rust: "readonly" | "writeonly" | "coherent" | "volatile" | "restrict"
    // rust: ) || tokens[w].starts_with("highp")
    // rust: {
    // rust: k += 1;
    // rust: } else {
    // rust: break;
}
}
    // rust: let Some(&ty) = words.get(k) else { continue };
    // rust: let vector = matches!(tokens[ty], "bvec2" | "bvec3" | "bvec4");
    // rust: if tokens[ty] != "bool" && !vector {
    // rust: continue;
}
            // Declarators: `name[N]`, separated by commas; `bool[N] name` puts the size first.
    // rust: let mut at = k + 1;
    // rust: if words.get(at).is_some_and(|&j| tokens[j] == "[")
    // rust: && let Some(p) = words.iter().position(|&x| Some(x) == matching(words[at]))
    // rust: {
    // rust: at = p + 1;
}
    // rust: let mut names = Vec::new();
    // rust: let mut depth = 0;
    // rust: let mut expect_name = true;
    // rust: for &j in &words[at.min(words.len())..] {
    // rust: match tokens[j] {
    // rust: "[" | "(" => depth += 1,
    // rust: "]" | ")" => depth -= 1,
    // rust: "," if depth == 0 => expect_name = true,
    // rust: t if depth == 0 && expect_name && is_ident(t) => {
    // rust: names.push((j, t));
    // rust: expect_name = false;
}
    // rust: _ => {}
}
}
    // rust: for &(j, name) in &names {
    // rust: if vector {
    // rust: fail(
    // rust: j,
    // rust: format!(
    // rust: "buffer member `{name}`: a `{}` is not supported in a storage buffer",
    // rust: tokens[ty]
    // rust: ),
    // rust: );
    // rust: } else {
    // rust: members.push(Member { type_at: ty, name });
}
}
}
    // rust: if members.is_empty() {
    // rust: continue;
}
    // rust: if instance.is_some_and(|j| next(j).is_some_and(|n| tokens[n] == "[")) {
    // rust: for m in &members {
    // rust: fail(
    // rust: m.type_at,
    // rust: format!(
    // rust: "buffer member `{}`: an instance array of a buffer with `bool` members is not supported",
    // rust: m.name
    // rust: ),
    // rust: );
}
    // rust: continue;
}
    // rust: blocks.push(Block {
    // rust: open,
    // rust: close,
    // rust: instance: instance.map(|j| tokens[j]),
    // rust: members,
    // rust: });
}
    // rust: if blocks.is_empty() {
    // rust: return (None, errors);
}

    // Texts put before and after tokens.
    // rust: let mut before: BTreeMap<usize, String> = BTreeMap::new();
    // rust: let mut after: BTreeMap<usize, String> = BTreeMap::new();
    // rust: let mut retyped: Vec<usize> = Vec::new();
    // rust: for block in &blocks {
    // rust: retyped.extend(block.members.iter().map(|m| m.type_at));
}
    // The uses of each member.
    // rust: let kind = |i: usize| tokens[i];
    // rust: for block in &blocks {
    // rust: for member in &block.members {
    // rust: for (i, &t) in tokens.iter().enumerate() {
    // rust: if t != member.name || (i > block.open && i < block.close) {
    // rust: continue;
}
                // `instance . name`, or the bare name for a block without an instance.
    // rust: let (start, name_at) = match block.instance {
    // rust: Some(instance) => {
    // rust: let dot = prev(i).filter(|&d| kind(d) == ".");
    // rust: let owner = dot.and_then(prev).filter(|&o| kind(o) == instance);
    // rust: match owner {
    // rust: Some(o) => (o, i),
    // rust: None => continue,
}
}
    // rust: None => {
    // rust: if prev(i).is_some_and(|d| kind(d) == ".") {
    // rust: continue; // Another value's member of the same name.
}
                        // A declaration of the same name (a local, a parameter) hides it.
    // rust: if prev(i).is_some_and(|d| {
    // rust: is_ident(kind(d))
    // rust: && !matches!(
    // rust: kind(d),
    // rust: "return" | "else" | "case" | "do" | "discard" | "in" | "out"
    // rust: )
    // rust: }) {
    // rust: fail(
    // rust: i,
    // rust: format!(
    // rust: "buffer member `{}` is also declared as a local or parameter; \
    // rust: rename one of them",
    // rust: member.name
    // rust: ),
    // rust: );
    // rust: continue;
}
    // rust: (i, i)
}
}
                // The reference ends after its `[...]` groups.
    // rust: let mut last = name_at;
    // rust: let mut following = next(last);
    // rust: while let Some(open) = following.filter(|&j| kind(j) == "[") {
    // rust: match matching(open) {
    // rust: Some(close) => {
    // rust: last = close;
    // rust: following = next(close);
}
    // rust: None => break,
}
}
    // rust: let op = following.map(kind);
    // rust: let adjacent = |j: usize| tokens.get(j + 1).copied();
    // rust: match (following, op) {
                    // `ref = value;` as a statement.
    // rust: (Some(eq), Some("=")) if adjacent(eq) != Some("=") => {
    // rust: let statement = prev(start)
    // rust: .is_none_or(|p| matches!(kind(p), ";" | "{" | "}" | ")" | "else"));
    // rust: let mut depth = 0i32;
    // rust: let end = (eq + 1..tokens.len()).find(|&j| {
    // rust: match tokens[j] {
    // rust: "(" | "[" | "{" => depth += 1,
    // rust: ")" | "]" | "}" => depth -= 1,
    // rust: _ => {}
}
    // rust: depth < 0 || (depth == 0 && tokens[j] == ";")
    // rust: });
    // rust: match (statement, end) {
    // rust: (true, Some(end)) => {
    // rust: let first = next(eq).unwrap_or(eq + 1);
    // rust: before.entry(first).or_default().push_str("uint(");
    // rust: before.entry(end).or_default().insert(0, ')');
}
    // rust: _ => fail(
    // rust: i,
    // rust: format!(
    // rust: "buffer member `{}` is assigned inside an expression; \
    // rust: assign it in a statement of its own",
    // rust: member.name
    // rust: ),
    // rust: ),
}
}
                    // `ref |= value;` and the like.
    // rust: (Some(op_at), Some("|" | "&" | "^" | "+" | "-" | "*" | "/" | "%"))
    // rust: if adjacent(op_at) == Some("=") =>
    // rust: {
    // rust: fail(
    // rust: i,
    // rust: format!(
    // rust: "buffer member `{}`: `{}=` on a `bool` in a storage buffer is not \
    // rust: supported; write `{} = {} {} ...;`",
    // rust: member.name,
    // rust: kind(op_at),
    // rust: member.name,
    // rust: member.name,
    // rust: match kind(op_at) {
    // rust: "|" => "||",
    // rust: "&" => "&&",
    // rust: other => other,
}
    // rust: ),
    // rust: );
}
                    // A read.
    // rust: _ => {
    // rust: before.entry(start).or_default().push('(');
    // rust: after.entry(last).or_default().push_str(" != 0u)");
}
}
}
}
}
    // rust: if !errors.is_empty() {
    // rust: return (None, errors);
}
    // rust: let mut code = String::with_capacity(pp.code.len() + 32);
    // rust: for (i, &t) in tokens.iter().enumerate() {
    // rust: if let Some(text) = before.get(&i) {
    // rust: code.push_str(text);
}
    // rust: if retyped.contains(&i) {
    // rust: code.push_str("uint");
    // rust: } else {
    // rust: code.push_str(t);
}
    // rust: if let Some(text) = after.get(&i) {
    // rust: code.push_str(text);
}
}
    // rust: (Some(Preprocessed { code, ..pp.clone() }), errors)
}

    // rust: mod tests {
//     use super::rewrite;
//     use crate::pack::tests::zip;
//     use crate::{Macros, Pack, preprocess};

    /// The rewritten code of a fragment stage, `None` when nothing changes.
pub fn code(source: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pack =
    // rust: Pack::from_zip_bytes("P.zip", zip(&[("shaders/composite.fsh", source)])).unwrap();
    // rust: let stage = preprocess(&pack, "composite.fsh", &Macros::standard());
    // rust: let (rewritten, errors) = rewrite(&stage);
    // rust: assert!(errors.is_empty(), "{errors:?}");
    // rust: rewritten.map(|p| p.code)
}

pub fn reads_become_comparisons_and_plain_assignments_convert_back() void {
}
pub const SOURCE: []const u8 = "#version 430\nlayout(std430, binding = 4) buffer State { mat4 matrix; bool flag; };
    // rust: void main() {\n    if (flag) { }\n    flag = !flag && true;\n    bool seen = flag;\n}\n";
    // rust: let out = code(SOURCE).unwrap();
    // rust: assert!(out.contains("mat4 matrix; uint flag;"), "{out}");
    // rust: assert!(out.contains("if ((flag != 0u))"), "{out}");
    // rust: assert!(out.contains("flag = uint(!(flag != 0u) && true);"), "{out}");
    // rust: assert!(out.contains("bool seen = (flag != 0u);"), "{out}");
        // The rewrite adds no line and takes none: the pack's line numbers stay right.
    // rust: let pack =
    // rust: Pack::from_zip_bytes("P.zip", zip(&[("shaders/composite.fsh", SOURCE)])).unwrap();
    // rust: let before = preprocess(&pack, "composite.fsh", &Macros::standard());
    // rust: assert_eq!(out.lines().count(), before.code.lines().count());
}

pub fn instances_and_arrays_are_rewritten_where_they_are_read() void {
}
    // rust: let out = code(
    // rust: "#version 430\nlayout(std430, binding = 4) buffer State { int n; bool flags[4]; bool on; } s;\n\
    // rust: void main() {\n    float a = s.on ? 1.0 : 0.0;\n    bool b = s.flags[2] && !s.flags[s.n];\n}\n",
    // rust: )
    // rust: .unwrap();
    // rust: assert!(out.contains("uint flags[4]; uint on;"), "{out}");
    // rust: assert!(out.contains("(s.on != 0u) ? 1.0"), "{out}");
    // rust: assert!(
    // rust: out.contains("(s.flags[2] != 0u) && !(s.flags[s.n] != 0u)"),
    // rust: "{out}"
    // rust: );
}

pub fn nothing_to_do_without_a_bool_member_and_a_same_named_field_is_refused() void {
}
        // No bool in a buffer: nothing to do.
    // rust: assert!(
    // rust: code(
    // rust: "#version 430
    // rust: layout(std430, binding = 4) buffer B { int n; };
    // rust: bool flag;
    // rust: void main() { }
    // rust: "
    // rust: )
    // rust: .is_none()
    // rust: );
        // Another value's member of the same name cannot be told from the buffer's by tokens
        // alone, so it is refused with the name, not rewritten wrongly.
    // rust: let pack = Pack::from_zip_bytes(
    // rust: "P.zip",
    // rust: zip(&[(
    // rust: "shaders/composite.fsh",
    // rust: "#version 430
pub const Light = struct {
    // rust: layout(std430, binding = 4) buffer B { bool flag; };
    // rust: void main() {
    // rust: Light light;
    // rust: bool a = light.flag;
};
    // rust: ",
    // rust: )]),
    // rust: )
    // rust: .unwrap();
    // rust: let (rewritten, errors) = rewrite(&preprocess(&pack, "composite.fsh", &Macros::standard()));
    // rust: assert!(rewritten.is_none());
    // rust: assert_eq!(errors.len(), 1, "{errors:?}");
    // rust: assert!(errors[0].message.contains("`flag` is also declared"));
    // rust: assert_eq!(errors[0].line, 2);
}
}
