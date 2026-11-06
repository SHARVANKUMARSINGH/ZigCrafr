//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_atomic_vectors
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Atomic functions on a component of an integer vector in shared memory or in a buffer block
//! (`atomicAdd(sums[i], n)`, `atomicMax(lights[k].w, w)`, `atomicAdd(buf.counts.x, 1u)`): GLSL
//! allows them (GLSL 4.60, 8.11), naga has no atomic vectors. Such a vector (or array of vectors)
//! becomes an array of its components, `shared int sums_hz[4]`, `uint counts_hz[2];` in the
//! block. A shared vector may share its declaration with other names (`shared ivec3 a, b;`), or
//! be a member of a shared struct whose type is defined in place (`shared struct { ivec3 lo; }
//! s;`, `int lo_hz[3];` in the struct). A component is an element, a whole vector is read
//! through `hz_get_sums()` and written through `hz_set_sums(v)`. A `std430` buffer block keeps
//! its layout: a padding member goes before the array when the vector's alignment would have
//! moved it, and an array of 3-component vectors keeps a fourth, unused element per vector (its
//! stride). Other layouts, runtime-sized arrays and blocks whose layout is not known up to the
//! vector stay as written. The source keeps its lines.

// use std::collections::BTreeMap;
// use std::fmt::Write;

// use super::scan::{is_ident, significant};
// use crate::Preprocessed;
// use crate::macros::lex;

    // rust: const ATOMICS: [&str; 8] = [
    // rust: "atomicAdd",
    // rust: "atomicMin",
    // rust: "atomicMax",
    // rust: "atomicAnd",
    // rust: "atomicOr",
    // rust: "atomicXor",
    // rust: "atomicExchange",
    // rust: "atomicCompSwap",
    // rust: ];

/// A vector rewritten: its type, size, array length if any, the elements'
/// name (`sums_hz`, `buf.counts_hz`) and the name of its getter and setter (`hz_get_<key>`).
pub const Split = struct {
    vector: []const u8,
    size: usize,
    array: ?[]const u8,
    base: []const u8,
    key: []const u8,
};

/// How a rewritten vector is named where it is used: a name of its own (a shared variable, a
/// member of a block without an instance name), or `instance.member`.
pub const Path = enum {
    Name(&'a str),
    Member(&'a str, &'a str),
};

/// `ivecN`/`uvecN`: the scalar type and N.
pub fn integer_vector(ty: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (scalar, n) = match ty {
    // rust: v if v.starts_with("ivec") => ("int", &v[4..]),
    // rust: v if v.starts_with("uvec") => ("uint", &v[4..]),
    // rust: _ => return None,
}
    // rust: n.parse()
    // rust: .ok()
    // rust: .filter(|n| (2..=4).contains(n))
    // rust: .map(|n| (scalar, n))
}

/// A member type's std430 base alignment and size in bytes (the rules Horizon's naga applies in
/// `front/glsl/offset.rs`), for the scalars, vectors and float matrices; `None` for any other
/// type.
pub fn std430(ty: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let vector = |n: u32| match n {
    // rust: 2 => Some((8, 8)),
    // rust: 3 => Some((16, 12)),
    // rust: 4 => Some((16, 16)),
    // rust: _ => None,
}
    // rust: match ty {
    // rust: "int" | "uint" | "float" | "bool" => Some((4, 4)),
    // rust: _ if ty.starts_with("mat") => {
    // rust: let dims = &ty[3..];
    // rust: let (columns, rows) = match dims.split_once('x') {
    // rust: Some((c, r)) => (c.parse().ok()?, r.parse().ok()?),
    // rust: None => (dims.parse().ok()?, dims.parse().ok()?),
}
    // rust: let (align, _) = vector(rows)?;
    // rust: vector(columns)?;
    // rust: Some((align, align * columns))
}
    // rust: _ => {
    // rust: let n = ty
    // rust: .strip_prefix(['i', 'u', 'b'])
    // rust: .unwrap_or(ty)
    // rust: .strip_prefix("vec")?;
    // rust: vector(n.parse().ok()?)
}
}
}

/// `pp` with its shared and buffer vectors that atomic functions use by component rewritten.
    // rust: pub(super) fn rewrite(pp: &Preprocessed) -> Option<Preprocessed> {
    // rust: if !ATOMICS.iter().any(|a| pp.code.contains(a)) {
    // rust: return None;
}
    // rust: let tokens = lex(&pp.code);
    // rust: let next = |i: usize| (i + 1..tokens.len()).find(|&j| significant(tokens[j]));
    // rust: let prev = |i: usize| (0..i).rev().find(|&j| significant(tokens[j]));
    // `[N]` at `open`: its size's text and the token after `]`.
    // rust: let bracket = |open: usize| -> Option<(String, Option<usize>)> {
    // rust: let close = (open..tokens.len()).find(|&j| tokens[j] == "]")?;
    // rust: let size: String = tokens[open + 1..close].concat();
    // rust: Some((size.trim().to_owned(), next(close)))
}
    // What an atomic function takes a component of: its first name, and the name after a `.`.
    // rust: let mut used: Vec<(&str, Option<&str>)> = Vec::new();
    // rust: for (i, &t) in tokens.iter().enumerate() {
    // rust: if ATOMICS.contains(&t)
    // rust: && let Some(open) = next(i).filter(|&j| tokens[j] == "(")
    // rust: && let Some(name) = next(open).filter(|&j| is_ident(tokens[j]))
    // rust: {
    // rust: let member = next(name)
    // rust: .filter(|&j| tokens[j] == ".")
    // rust: .and_then(next)
    // rust: .filter(|&j| is_ident(tokens[j]))
    // rust: .map(|j| tokens[j]);
    // rust: used.push((tokens[name], member));
}
}
    // rust: let mut splits: BTreeMap<Path, Split> = BTreeMap::new();
    // Declarations replaced (tokens `start..=end` by the text), and text after a token.
    // rust: let mut decls: Vec<(usize, usize, String)> = Vec::new();
    // rust: let mut after: Vec<(usize, String)> = Vec::new();
    // A declaration's names, from `from` (after its type) to its `;`: each with its own array
    // size, and the `;`. `None` for anything else (an initializer, an array of arrays).
    // rust: let declarators = |from: Option<usize>| -> Option<(Vec<(&str, Option<String>)>, usize)> {
    // rust: let mut names = Vec::new();
    // rust: let mut at = from;
    // rust: loop {
    // rust: let name = at.filter(|&j| is_ident(tokens[j]))?;
    // rust: let mut end = next(name);
    // rust: let mut array = None;
    // rust: if let Some((size, after)) = end.filter(|&e| tokens[e] == "[").and_then(bracket) {
    // rust: array = Some(size);
    // rust: end = after;
}
    // rust: names.push((tokens[name], array));
    // rust: let end = end?;
    // rust: match tokens[end] {
    // rust: ";" => return Some((names, end)),
    // rust: "," => at = next(end),
    // rust: _ => return None,
}
}
}
    // The elements a vector of `ty` becomes, `name_hz[N]` (`[len][N]` in an array), or the
    // vector as declared when no atomic function uses it.
    // rust: let declared = |ty: &str, name: &str, array: &Option<String>, split: bool| match (
    // rust: integer_vector(ty).filter(|_| split),
    // rust: array,
    // rust: ) {
    // rust: (Some((scalar, n)), None) => format!("{scalar} {name}_hz[{n}];"),
    // rust: (Some((scalar, n)), Some(len)) => format!("{scalar} {name}_hz[{len}][{n}];"),
    // rust: (None, None) => format!("{ty} {name};"),
    // rust: (None, Some(len)) => format!("{ty} {name}[{len}];"),
}
    // Shared declarations: `shared ivec4 name;`, `shared ivec4[N] name;`, `shared ivec4 name[N];`,
    // several names in one (`shared ivec4 a, b;`), and the members of a struct defined in place
    // (`shared struct { ivec4 a; uint n; } s;`).
    // rust: for (i, &t) in tokens.iter().enumerate() {
    // rust: if t != "shared" {
    // rust: continue;
}
    // rust: let Some(ty) = next(i) else { continue };
    // rust: if tokens[ty] == "struct" {
            // Its type has no name, or one used nowhere else, so its members change only here.
    // rust: let name = next(ty).filter(|&j| is_ident(tokens[j]));
    // rust: if name.is_some_and(|j| tokens.iter().filter(|&&t| t == tokens[j]).count() > 1) {
    // rust: continue;
}
    // rust: let Some(open) = next(name.unwrap_or(ty)).filter(|&j| tokens[j] == "{") else {
    // rust: continue;
}
    // rust: let Some(close) = (open..tokens.len()).find(|&j| tokens[j] == "}") else {
    // rust: continue;
}
    // rust: let Some(instance) = next(close).filter(|&j| is_ident(tokens[j])) else {
    // rust: continue;
}
    // rust: let Some(end) = next(instance).filter(|&j| tokens[j] == ";") else {
    // rust: continue;
}
    // rust: if tokens[open + 1..close].contains(&"{") {
    // rust: continue;
}
    // rust: let instance = tokens[instance];
    // rust: let mut from = open + 1;
    // rust: for semi in (open + 1..close).filter(|&j| tokens[j] == ";") {
    // rust: let first = (from..semi).find(|&j| significant(tokens[j]));
    // rust: from = semi + 1;
    // rust: let mut member_ty = first;
    // rust: while let Some(q) =
    // rust: member_ty.filter(|&j| matches!(tokens[j], "highp" | "mediump" | "lowp"))
    // rust: {
    // rust: member_ty = next(q);
}
    // rust: let (Some(first), Some(member_ty)) = (first, member_ty) else {
    // rust: continue;
}
    // rust: let Some((scalar_size, (names, _))) = integer_vector(tokens[member_ty])
    // rust: .zip(declarators(next(member_ty)).filter(|&(_, e)| e == semi))
    // rust: else {
    // rust: continue;
}
    // rust: let is_used = |name: &str| used.contains(&(instance, Some(name)));
    // rust: if !names.iter().any(|&(name, _)| is_used(name)) {
    // rust: continue;
}
    // rust: let mut decl = Vec::new();
    // rust: for (name, array) in names {
    // rust: decl.push(declared(tokens[member_ty], name, &array, is_used(name)));
    // rust: if !is_used(name) {
    // rust: continue;
}
    // rust: let split = Split {
    // rust: vector: tokens[member_ty].to_owned(),
    // rust: size: scalar_size.1,
    // rust: array,
    // rust: base: format!("{instance}.{name}_hz"),
    // rust: key: format!("{instance}_{name}"),
}
    // rust: after.push((end, format!(" {}", accessors(&split))));
    // rust: splits.insert(Path::Member(instance, name), split);
}
    // rust: decls.push((first, semi, decl.join(" ")));
}
    // rust: continue;
}
    // rust: let Some((_, size)) = integer_vector(tokens[ty]) else {
    // rust: continue;
}
    // rust: let mut j = next(ty);
    // rust: let mut of_type = None;
    // rust: if let Some((size, after)) = j.filter(|&j| tokens[j] == "[").and_then(bracket) {
    // rust: of_type = Some(size);
    // rust: j = after;
}
    // rust: let Some((names, end)) = declarators(j) else {
    // rust: continue;
}
    // rust: let is_used = |name: &str| used.iter().any(|u| u.0 == name);
    // rust: if !names.iter().any(|&(name, _)| is_used(name))
    // rust: || of_type.is_some() && names.iter().any(|(_, array)| array.is_some())
    // rust: {
    // rust: continue;
}
    // rust: let mut decl = Vec::new();
    // rust: for (name, array) in names {
    // rust: let array = array.or(of_type.clone());
    // rust: decl.push(format!(
    // rust: "shared {}",
    // rust: declared(tokens[ty], name, &array, is_used(name))
    // rust: ));
    // rust: if !is_used(name) {
    // rust: continue;
}
    // rust: let split = Split {
    // rust: vector: tokens[ty].to_owned(),
    // rust: size,
    // rust: array,
    // rust: base: format!("{name}_hz"),
    // rust: key: name.to_owned(),
}
    // rust: decl.push(accessors(&split));
    // rust: splits.insert(Path::Name(name), split);
}
    // rust: decls.push((i, end, decl.join(" ")));
}
    // Buffer blocks: `layout(std430, ...) buffer Name { members } instance;`.
    // rust: for (i, &t) in tokens.iter().enumerate() {
    // rust: if t != "buffer" {
    // rust: continue;
}
    // rust: let Some(open) = next(i)
    // rust: .filter(|&j| is_ident(tokens[j]))
    // rust: .and_then(next)
    // rust: .filter(|&j| tokens[j] == "{")
    // rust: else {
    // rust: continue;
}
        // The declaration's qualifiers, back to the previous declaration.
    // rust: let first = (0..i)
    // rust: .rev()
    // rust: .find(|&j| matches!(tokens[j], ";" | "}"))
    // rust: .map_or(0, |j| j + 1);
    // rust: if !tokens[first..i].contains(&"std430") {
    // rust: continue;
}
    // rust: let Some(close) = (open..tokens.len()).find(|&j| tokens[j] == "}") else {
    // rust: continue;
}
    // rust: let (instance, end) = match next(close) {
    // rust: Some(j) if tokens[j] == ";" => (None, j),
    // rust: Some(j) if is_ident(tokens[j]) && next(j).is_some_and(|k| tokens[k] == ";") => {
    // rust: (Some(tokens[j]), next(j).unwrap())
}
    // rust: _ => continue,
}
        // The members in order, with their std430 offsets while they are known.
    // rust: let mut offset = Some(0u32);
    // rust: let mut from = open + 1;
    // rust: for semi in (open + 1..close).filter(|&j| tokens[j] == ";") {
    // rust: let words: Vec<usize> = (from..semi).filter(|&j| significant(tokens[j])).collect();
    // rust: from = semi + 1;
    // rust: let words: Vec<usize> = words
    // rust: .into_iter()
    // rust: .skip_while(|&j| {
    // rust: matches!(
    // rust: tokens[j],
    // rust: "highp"
    // rust: | "mediump"
    // rust: | "lowp"
    // rust: | "coherent"
    // rust: | "volatile"
    // rust: | "restrict"
    // rust: | "readonly"
    // rust: | "writeonly"
    // rust: | "precise"
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let [ty, name_at, ref rest @ ..] = words[..] else {
    // rust: offset = None;
    // rust: continue;
}
    // rust: let (ty, name) = (tokens[ty], tokens[name_at]);
            // One declarator, with at most one array size. A runtime-sized array (`[]`, last)
            // stays as written: naga rejected the array of arrays it would become.
    // rust: let array = match rest.iter().map(|&j| tokens[j]).collect::<Vec<_>>()[..] {
    // rust: [] => None,
    // rust: ["[", ref len @ .., "]"]
    // rust: if !len.is_empty() && !len.contains(&"[") && !len.contains(&",") =>
    // rust: {
    // rust: Some(len.concat())
}
    // rust: _ => {
    // rust: offset = None;
    // rust: continue;
}
}
    // rust: let layout = std430(ty);
    // rust: let end_before = offset;
    // rust: let at = offset
    // rust: .zip(layout)
    // rust: .map(|(o, (align, _))| o.next_multiple_of(align));
    // rust: offset = at.zip(layout).and_then(|(at, (align, size))| match &array {
    // rust: None => Some(at + size),
    // rust: Some(len) => Some(at + len.parse::<u32>().ok()? * size.next_multiple_of(align)),
    // rust: });
    // rust: let Some((scalar, size)) = integer_vector(ty) else {
    // rust: continue;
}
    // rust: let path = match instance {
    // rust: Some(instance) => Path::Member(instance, name),
    // rust: None => Path::Name(name),
}
    // rust: let is_used = used.iter().any(|&u| match path {
    // rust: Path::Member(instance, member) => u == (instance, Some(member)),
    // rust: Path::Name(name) => u.0 == name,
    // rust: });
    // rust: let Some(at) = at.filter(|_| is_used) else {
    // rust: continue;
}
            // The bytes the vector's alignment skips, which the elements' does not.
    // rust: let pad = end_before.map_or(0, |e| (at - e) / 4);
    // rust: let mut decl = String::new();
    // rust: if pad > 0 {
    // rust: write!(decl, "uint hz_pad_{name}[{pad}]; ").unwrap();
}
            // In an array, a 3-component vector takes 16 bytes: four elements.
    // rust: let width = if array.is_some() && size == 3 {
    // rust: 4
    // rust: } else {
    // rust: size
}
    // rust: match &array {
    // rust: None => write!(decl, "{scalar} {name}_hz[{width}];"),
    // rust: Some(len) => write!(decl, "{scalar} {name}_hz[{len}][{width}];"),
}
    // rust: .unwrap();
    // rust: let base = match instance {
    // rust: Some(instance) => format!("{instance}.{name}_hz"),
    // rust: None => format!("{name}_hz"),
}
    // rust: let key = match instance {
    // rust: Some(instance) => format!("{instance}_{name}"),
    // rust: None => name.to_owned(),
}
    // rust: let split = Split {
    // rust: vector: ty.to_owned(),
    // rust: size,
    // rust: array,
    // rust: base,
    // rust: key,
}
    // rust: after.push((end, format!(" {}", accessors(&split))));
    // rust: decls.push((words[0], semi, decl));
    // rust: splits.insert(path, split);
}
}
    // rust: if splits.is_empty() {
    // rust: return None;
}
    // rust: let mut out: Vec<String> = tokens.iter().map(|t| t.to_string()).collect();
    // rust: for (start, end, decl) in &decls {
    // rust: for t in &mut out[*start..=*end] {
    // rust: *t = t.chars().filter(|&c| c == '\n').collect();
}
    // rust: out[*start] = decl.clone() + &out[*start];
}
    // rust: for (at, text) in &after {
    // rust: out[*at].push_str(text);
}
    // rust: let component = |s: &str| match s {
    // rust: "x" | "r" | "s" => Some(0),
    // rust: "y" | "g" | "t" => Some(1),
    // rust: "z" | "b" | "p" => Some(2),
    // rust: "w" | "a" | "q" => Some(3),
    // rust: _ => None,
}
    // Uses: from the name, past `[k]` for an array, then a component, a swizzle, an assignment
    // or the whole vector.
    // rust: let mut i = 0;
    // rust: while i < tokens.len() {
    // rust: let in_decl = decls.iter().any(|&(a, b, _)| (a..=b).contains(&i));
    // rust: let member = next(i)
    // rust: .filter(|&j| tokens[j] == ".")
    // rust: .and_then(next)
    // rust: .filter(|&j| is_ident(tokens[j]));
    // rust: let found = if in_decl || prev(i).is_some_and(|p| tokens[p] == ".") {
    // rust: None
    // rust: } else if let Some(m) = member
    // rust: && let Some(s) = splits.get(&Path::Member(tokens[i], tokens[m]))
    // rust: {
    // rust: Some((s, m))
    // rust: } else {
    // rust: splits.get(&Path::Name(tokens[i])).map(|s| (s, i))
}
    // rust: let Some((s, name_end)) = found else {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let key = &s.key;
    // rust: let mut base = s.base.clone();
    // rust: let mut getter_args = String::new();
    // rust: let mut last = name_end;
    // rust: if s.array.is_some() {
            // `name.length()`: the array's own.
    // rust: if next(name_end).is_some_and(|j| tokens[j] == ".") {
    // rust: out[i] = base;
    // rust: for t in &mut out[i + 1..=name_end] {
    // rust: *t = t.chars().filter(|&c| c == '\n').collect();
}
    // rust: i = name_end + 1;
    // rust: continue;
}
            // `name[k]`: the index's tokens, written back as they are.
    // rust: let Some(open) = next(name_end).filter(|&j| tokens[j] == "[") else {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let mut depth = 0;
    // rust: let mut close = open;
    // rust: for (j, &t) in tokens.iter().enumerate().skip(open) {
    // rust: match t {
    // rust: "[" => depth += 1,
    // rust: "]" => {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: close = j;
    // rust: break;
}
}
    // rust: _ => {}
}
}
    // rust: let index: String = tokens[open + 1..close].concat();
    // rust: base = format!("{base}[{index}]");
            // GLSL won't turn a `uint` index into the `int` the getter and setter take.
    // rust: getter_args = format!("int({index})");
    // rust: last = close;
}
    // rust: let after = next(last);
    // rust: let follows = |t: &str| after.is_some_and(|j| tokens[j] == t);
    // rust: let assigned = |at: Option<usize>| {
    // rust: at.is_some_and(|j| tokens[j] == "=" && next(j).is_none_or(|k| tokens[k] != "="))
}
        // `name op= value;`: the operator's tokens and the `=`.
    // rust: let compound = after.and_then(|op| {
    // rust: let first = tokens[op];
    // rust: let second = next(op)?;
    // rust: match (first, tokens[second]) {
    // rust: ("+" | "-" | "*" | "/" | "%" | "&" | "|" | "^", "=") => {
    // rust: Some((first.to_owned(), second))
}
    // rust: ("<" | ">", t) if t == first => {
    // rust: let eq = next(second).filter(|&k| tokens[k] == "=")?;
    // rust: Some((format!("{first}{first}"), eq))
}
    // rust: _ => None,
}
    // rust: });
    // rust: let replacement;
    // rust: let mut end = last;
    // rust: if let Some((op, eq)) = compound {
            // `name op= value;` → `hz_set_name(hz_get_name() op (value));`
    // rust: let semi = (eq..tokens.len()).find(|&j| tokens[j] == ";").unwrap_or(eq);
    // rust: let args = if getter_args.is_empty() {
    // rust: String::new()
    // rust: } else {
    // rust: format!("{getter_args}, ")
}
    // rust: out[i] = format!("hz_set_{key}({args}hz_get_{key}({getter_args}) {op} (");
    // rust: for t in &mut out[i + 1..=eq] {
    // rust: *t = t.chars().filter(|&c| c == '\n').collect();
}
    // rust: out[semi] = "));".into();
    // rust: i = eq + 1;
    // rust: continue;
    // rust: } else if follows(".") || (s.array.is_none() && follows("[")) {
    // rust: let at = after.and_then(next).unwrap();
    // rust: if follows("[") {
                // `name[c]`: an element already.
    // rust: replacement = base.clone();
    // rust: } else if let Some(c) = component(tokens[at]) {
    // rust: replacement = format!("{base}[{c}]");
    // rust: end = at;
    // rust: } else {
                // A swizzle of several components: read only.
    // rust: let get = format!("hz_get_{key}({getter_args})");
    // rust: replacement = format!("{get}.{}", tokens[at]);
    // rust: end = at;
}
    // rust: } else if assigned(after) {
            // `name = value;` → `hz_set_name(value);`
    // rust: let eq = after.unwrap();
    // rust: let semi = (eq..tokens.len()).find(|&j| tokens[j] == ";").unwrap_or(eq);
    // rust: let args = if getter_args.is_empty() {
    // rust: String::new()
    // rust: } else {
    // rust: format!("{getter_args}, ")
}
    // rust: out[i] = format!("hz_set_{key}({args}");
    // rust: for t in &mut out[i + 1..=eq] {
    // rust: *t = t.chars().filter(|&c| c == '\n').collect();
}
    // rust: out[semi] = ");".into();
    // rust: i = eq + 1;
    // rust: continue;
    // rust: } else {
    // rust: replacement = format!("hz_get_{key}({getter_args})");
}
    // rust: out[i] = replacement;
    // rust: for t in &mut out[i + 1..=end] {
    // rust: *t = t.chars().filter(|&c| c == '\n').collect();
}
    // rust: i = end + 1;
}
    // rust: Some(Preprocessed {
    // rust: code: out.concat(),
    // rust: lines: pp.lines.clone(),
    // rust: files: pp.files.clone(),
    // rust: version: pp.version.clone(),
    // rust: extensions: pp.extensions.clone(),
    // rust: comments: pp.comments.clone(),
    // rust: diagnostics: pp.diagnostics.clone(),
    // rust: warnings: pp.warnings.clone(),
    // rust: })
}

/// `hz_get_<key>` and `hz_set_<key>`: a whole vector of `split` (of an array: the `k`th),
/// read from and written to its elements.
pub fn accessors(split: *Split) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (v, base, key) = (&split.vector, &split.base, &split.key);
    // rust: let element = if split.array.is_some() {
    // rust: format!("{base}[k]")
    // rust: } else {
    // rust: base.clone()
}
    // rust: let comps = (0..split.size)
    // rust: .map(|c| format!("{element}[{c}]"))
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: let sets: String = (0..split.size)
    // rust: .map(|c| format!("{element}[{c}] = v[{c}];"))
    // rust: .collect();
    // rust: let (k, k_comma) = if split.array.is_some() {
    // rust: ("int k", "int k, ")
    // rust: } else {
    // rust: ("", "")
}
    // rust: format!(
    // rust: "{v} hz_get_{key}({k}) {{ return {v}({comps}); }} void hz_set_{key}({k_comma}{v} v) {{ {sets} }}"
    // rust: )
}

    // rust: mod tests {
//     use super::*;

pub fn rewritten(code: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pp = Preprocessed {
    // rust: code: code.to_owned(),
    // rust: lines: Vec::new(),
    // rust: files: Vec::new(),
    // rust: version: None,
    // rust: extensions: Vec::new(),
    // rust: comments: Vec::new(),
    // rust: diagnostics: Vec::new(),
    // rust: warnings: Vec::new(),
}
    // rust: let out = rewrite(&pp).expect("rewritten").code;
    // rust: assert_eq!(out.lines().count(), code.lines().count(), "{out}");
    // rust: out
}

pub fn components_whole_vectors_and_compound_assignments() void {
}
    // rust: let out = rewritten(
    // rust: "shared ivec4 sums;\nvoid f(ivec4 v) {\n atomicAdd(sums.y, 1);\n ivec4 a = sums;\n \
    // rust: sums = v;\n sums += v;\n sums <<= 1;\n int z = sums.z;\n ivec2 xy = sums.xy;\n}\n",
    // rust: );
    // rust: assert!(out.contains("shared int sums_hz[4];"));
    // rust: assert!(out.contains("atomicAdd(sums_hz[1], 1);"));
    // rust: assert!(out.contains("ivec4 a = hz_get_sums();"));
    // rust: assert!(out.contains("hz_set_sums( v);"));
    // rust: assert!(out.contains("hz_set_sums(hz_get_sums() + ( v));"));
    // rust: assert!(out.contains("hz_set_sums(hz_get_sums() << ( 1));"));
    // rust: assert!(out.contains("int z = sums_hz[2];"));
    // rust: assert!(out.contains("ivec2 xy = hz_get_sums().xy;"));
}

pub fn arrays_of_vectors_with_any_size() void {
}
    // rust: let out = rewritten(
    // rust: "#define N 4\nshared uvec2 lights[N * 2];\nvoid f(int k) {\n atomicMax(lights[k + 1].x, 3u);\n \
    // rust: lights[k] += uvec2(1u);\n uvec2 l = lights[k];\n}\n",
    // rust: );
    // rust: assert!(out.contains("shared uint lights_hz[N * 2][2];"), "{out}");
    // rust: assert!(out.contains("atomicMax(lights_hz[k + 1][0], 3u);"));
    // rust: assert!(out.contains("hz_set_lights(int(k), hz_get_lights(int(k)) + ( uvec2(1u)));"));
    // rust: assert!(out.contains("uvec2 l = hz_get_lights(int(k));"));
}

pub fn untouched_without_atomics_on_a_component() void {
}
    // rust: let pp = |code: &str| Preprocessed {
    // rust: code: code.to_owned(),
    // rust: lines: Vec::new(),
    // rust: files: Vec::new(),
    // rust: version: None,
    // rust: extensions: Vec::new(),
    // rust: comments: Vec::new(),
    // rust: diagnostics: Vec::new(),
    // rust: warnings: Vec::new(),
}
    // rust: assert!(rewrite(&pp("shared ivec4 v;\nvoid f() { v.x = 1; }\n")).is_none());
    // rust: assert!(rewrite(&pp("shared int n;\nvoid f() { atomicAdd(n, 1); }\n")).is_none());
}

pub fn each_name_of_a_declaration_on_its_own() void {
}
    // rust: let out = rewritten(
    // rust: "shared ivec3 a, b[2],\n c;\nshared uvec2[4] d, e;\n\
    // rust: void f(int k) {\n atomicMin(a.x, k);\n atomicMax(c.z, k);\n atomicAdd(e[k].y, 1u);\n \
    // rust: ivec3 m = a + b[1] + c;\n}\n",
    // rust: );
    // rust: assert!(out.contains("shared int a_hz[3];"), "{out}");
    // rust: assert!(out.contains("shared ivec3 b[2];"), "{out}");
    // rust: assert!(out.contains("shared int c_hz[3];"), "{out}");
    // rust: assert!(out.contains("shared uvec2 d[4];"), "{out}");
    // rust: assert!(out.contains("shared uint e_hz[4][2];"), "{out}");
    // rust: assert!(out.contains("atomicMin(a_hz[0], k);"));
    // rust: assert!(out.contains("atomicMax(c_hz[2], k);"));
    // rust: assert!(out.contains("atomicAdd(e_hz[k][1], 1u);"));
    // rust: assert!(out.contains("ivec3 m = hz_get_a() + b[1] + hz_get_c();"));
}

pub fn members_of_a_shared_struct_defined_in_place() void {
}
    // rust: let out = rewritten(
    // rust: "shared struct hz_struct0 {\n ivec3 lo, hi;\n uint n;\n uvec4 v[2];\n} sh;\n\
    // rust: void f(int k) {\n sh.lo = ivec3(9);\n atomicMin(sh.lo.x, k);\n \
    // rust: atomicOr(sh.v[k].w, 1u);\n ivec3 l = sh.lo;\n ivec3 h = sh.hi;\n sh.n += 1u;\n}\n",
    // rust: );
    // rust: assert!(out.contains("int lo_hz[3]; ivec3 hi;"), "{out}");
    // rust: assert!(out.contains("uint v_hz[2][4];"), "{out}");
    // rust: assert!(out.contains("hz_set_sh_lo( ivec3(9));"), "{out}");
    // rust: assert!(out.contains("atomicMin(sh.lo_hz[0], k);"));
    // rust: assert!(out.contains("atomicOr(sh.v_hz[k][3], 1u);"));
    // rust: assert!(out.contains("ivec3 l = hz_get_sh_lo();"));
    // rust: assert!(out.contains("ivec3 h = sh.hi;"));
    // rust: assert!(out.contains("sh.n += 1u;"));
}

pub fn a_struct_type_used_elsewhere_keeps_its_members() void {
}
    // rust: let pp = Preprocessed {
    // rust: code: "shared struct S { ivec3 lo; } sh;\nvoid f(S s) { atomicMin(sh.lo.x, 1); }\n"
    // rust: .to_owned(),
    // rust: lines: Vec::new(),
    // rust: files: Vec::new(),
    // rust: version: None,
    // rust: extensions: Vec::new(),
    // rust: comments: Vec::new(),
    // rust: diagnostics: Vec::new(),
    // rust: warnings: Vec::new(),
}
    // rust: assert!(rewrite(&pp).is_none());
}
}
