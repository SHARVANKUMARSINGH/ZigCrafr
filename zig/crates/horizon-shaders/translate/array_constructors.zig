//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_array_constructors
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! PURPOSE: convert each argument of an array constructor, or a struct constructor, whose elements
//! or members are scalars or vectors, to the element or member type.
//! WHY: GLSL drivers take `int[2](1u, 2)`, `S(1u, 2.0)`; naga's frontend converts arguments
//! only upward and builds a `Compose` whose first component has another scalar type, which its
//! validator refuses ("Composing 0's component type is not expected", Horizon #7168).
//! `T(x)` of an `x` already a `T` is the identity, so correct sources do not change.
//! REFS: GLSL 4.60 sections 5.4.4 (array constructors) and 5.4.3 (structure constructors).
//! LOGS: none.
//! READS-BY: `compile` in `mod.rs`, before parsing.
//! ENDS-WHEN: naga's GLSL frontend converts array and struct constructor arguments itself.
// use crate::macros::lex;

    // rust: const ELEMENTS: [&str; 16] = [
    // rust: "float", "int", "uint", "bool", "vec2", "vec3", "vec4", "ivec2", "ivec3", "ivec4", "uvec2",
    // rust: "uvec3", "uvec4", "bvec2", "bvec3", "bvec4",
    // rust: ];

    // rust: pub(super) fn rewrite(text: &str) -> String {
    // rust: let tokens = lex(text);
    // rust: let structs = structs(&tokens);
    // rust: walk(&tokens, &structs)
}

    // rust: type Structs<'a> = Vec<(&'a str, Vec<&'a str>)>;

/// Each `struct S { ... };` whose members are all scalars or vectors: its name and member types.
    // rust: fn structs<'a>(tokens: &[&'a str]) -> Structs<'a> {
    // rust: let mut out = Vec::new();
    // rust: for i in 0..tokens.len() {
    // rust: if tokens[i] != "struct" {
    // rust: continue;
}
    // rust: let (Some(n), Some(o)) = (
    // rust: next(tokens, i + 1),
    // rust: next(tokens, i + 1).and_then(|n| next(tokens, n + 1)),
    // rust: ) else {
    // rust: continue;
}
    // rust: if tokens[o] != "{" {
    // rust: continue;
}
    // rust: let Some(end) = tokens[o..].iter().position(|t| *t == "}") else {
    // rust: continue;
}
    // rust: let mut members = Vec::new();
    // rust: let mut ok = true;
    // rust: for decl in tokens[o + 1..o + end].split(|t| *t == ";") {
    // rust: let words: Vec<&str> = decl.iter().copied().filter(|t| !is_ws(t)).collect();
    // rust: let Some((ty, names)) = words.split_first() else {
    // rust: continue;
}
    // rust: if !ELEMENTS.contains(ty) || names.contains(&"[") {
    // rust: ok = false;
    // rust: break;
}
    // rust: members.extend(names.split(|t| *t == ",").map(|_| *ty));
}
    // rust: if ok && !members.is_empty() {
    // rust: out.push((tokens[n], members));
}
}
    // rust: out
}

pub fn is_ws(t: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: t.trim().is_empty()
}

/// The next significant token at or after `i`.
pub fn next(tokens: *[[]const u8], mut i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: while i < tokens.len() && is_ws(tokens[i]) {
    // rust: i += 1;
}
    // rust: (i < tokens.len()).then_some(i)
}

pub fn walk(tokens: *[[]const u8], structs: *Structs) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = String::new();
    // rust: let mut i = 0;
    // rust: while i < tokens.len() {
    // rust: if let Some((close, types)) = constructor_end(tokens, i, structs) {
            // tokens[i] is the element or struct type; find the `(` after it (and its `]`).
    // rust: let open = (i..close)
    // rust: .find(|&k| tokens[k] == "(")
    // rust: .expect("constructor has a paren");
    // rust: for t in &tokens[i..=open] {
    // rust: out.push_str(t);
}
    // rust: let (mut depth, mut start, mut arg) = (0usize, open + 1, 0usize);
    // rust: for k in open + 1..=close {
    // rust: let t = tokens[k];
    // rust: match t {
    // rust: "(" | "[" | "{" => depth += 1,
    // rust: ")" | "]" | "}" if depth > 0 => depth -= 1,
    // rust: "," | ")" if depth == 0 => {
    // rust: let ty = types
    // rust: .get(arg)
    // rust: .or(types.last())
    // rust: .copied()
    // rust: .unwrap_or(tokens[i]);
    // rust: push_arg(&mut out, ty, &tokens[start..k], structs);
    // rust: out.push_str(t);
    // rust: start = k + 1;
    // rust: arg += 1;
}
    // rust: _ => {}
}
}
    // rust: i = close + 1;
    // rust: } else {
    // rust: out.push_str(tokens[i]);
    // rust: i += 1;
}
}
    // rust: out
}

/// `T(arg)` around one argument, its white space left outside; nested constructors rewritten.
pub fn push_arg(out: *mut []const u8, ty: []const u8, arg: *[[]const u8], structs: *Structs) void {
}
    // rust: let lead = arg.iter().take_while(|t| is_ws(t)).count();
    // rust: let trail = arg[lead..].iter().rev().take_while(|t| is_ws(t)).count();
    // rust: let body = &arg[lead..arg.len() - trail];
    // rust: arg[..lead].iter().for_each(|t| out.push_str(t));
    // rust: if !body.is_empty() {
    // rust: out.push_str(ty);
    // rust: out.push('(');
    // rust: out.push_str(&walk(body, structs));
    // rust: out.push(')');
}
    // rust: arg[arg.len() - trail..]
    // rust: .iter()
    // rust: .for_each(|t| out.push_str(t));
}

/// If an array constructor `T[N](...)` of a scalar or vector `T`, or a constructor of a struct
/// with that many scalar or vector members, starts at `i`: the index of its `)` and the type
/// each argument takes (one type for an array; a struct's, in order, when its count matches).
    // rust: fn constructor_end<'a>(
    // rust: tokens: &[&str],
    // rust: i: usize,
    // rust: structs: &Structs<'a>,
    // rust: ) -> Option<(usize, Vec<&'a str>)> {
    // rust: if let Some((_, members)) = structs.iter().find(|(n, _)| *n == tokens[i]) {
    // rust: let open = next(tokens, i + 1).filter(|&k| tokens[k] == "(")?;
    // rust: let close = matching(tokens, open)?;
    // rust: let args = 1 + tokens[open + 1..close]
    // rust: .iter()
    // rust: .scan(0i32, |d, t| {
    // rust: match *t {
    // rust: "(" | "[" | "{" => *d += 1,
    // rust: ")" | "]" | "}" => *d -= 1,
    // rust: _ => {}
}
    // rust: Some(if *d == 0 && *t == "," { 1 } else { 0 })
    // rust: })
    // rust: .sum::<usize>();
    // rust: return (args == members.len()).then(|| (close, members.clone()));
}
    // rust: let elem = ELEMENTS.iter().find(|e| **e == tokens[i])?;
    // rust: let mut k = next(tokens, i + 1)?;
    // rust: if tokens[k] != "[" {
    // rust: return None;
}
    // rust: k = next(tokens, k + 1)?;
    // rust: if tokens[k] != "]" {
    // rust: k = next(tokens, k + 1)?;
    // rust: if tokens[k] != "]" {
    // rust: return None;
}
}
    // rust: k = next(tokens, k + 1)?;
    // rust: if tokens[k] != "(" {
    // rust: return None;
}
    // rust: Some((matching(tokens, k)?, vec![*elem]))
}

/// The index of the bracket closing the one at `open`.
pub fn matching(tokens: *[[]const u8], open: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut depth = 0usize;
    // rust: for (j, t) in tokens.iter().enumerate().skip(open) {
    // rust: match *t {
    // rust: "(" | "[" | "{" => depth += 1,
    // rust: ")" | "]" | "}" => {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: return Some(j);
}
}
    // rust: _ => {}
}
}
    // rust: None
}

    // rust: mod tests {
//     use super::*;

pub fn arguments_take_the_element_type_and_lines_stay() void {
}
    // rust: let src = "int k[2] = int[2](1u,\n 2);\nvec2 v[] = vec2[](a, vec2(1, 2));\nfloat f(int x) { return float[](x, 1.0)[0]; }";
    // rust: assert_eq!(
    // rust: rewrite(src),
    // rust: "int k[2] = int[2](int(1u),\n int(2));\nvec2 v[] = vec2[](vec2(a), vec2(vec2(1, 2)));\nfloat f(int x) { return float[](float(x), float(1.0))[0]; }"
    // rust: );
    // rust: assert_eq!(
    // rust: rewrite("bvec4 b[] = bvec4[](t, u);"),
    // rust: "bvec4 b[] = bvec4[](bvec4(t), bvec4(u));"
    // rust: );
}

pub fn struct_arguments_take_the_member_types() void {
}
    // rust: let src = "struct S { int a; float b, c; };\nS s = S(1u, 2,\n x);";
    // rust: assert_eq!(
    // rust: rewrite(src),
    // rust: "struct S { int a; float b, c; };\nS s = S(int(1u), float(2),\n float(x));"
    // rust: );
}
}
