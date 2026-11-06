//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_ordering
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Compute programs written against drivers that happen to run a dispatch in order. GL leaves
//! two things undefined that packs still lean on, and Apple GPUs schedule differently enough to
//! show it frame after frame:
//!
//! - An invocation reading texels of an image that other invocations of the same dispatch store
//!   (light lists read from the neighbouring work groups, reprojection or a shift in place). When
//!   every load of such an image comes before every store, no atomic function touches it and it
//!   is neither `coherent` nor `volatile`, its loads read a copy taken before the dispatch: the
//!   values the pack expects to find.
//! - Shared memory read after other invocations' atomic functions with no `barrier()` between.
//!   A barrier goes after each statement of `main` that applies one to a shared variable,
//!   directly or through a function, unless `main` returns early (a barrier then would not be
//!   reached by every invocation).
//!
//! Both only narrow what may happen to what the pack was written for, and keep the lines.

// use super::scan::{is_ident, significant};
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

/// The name the copy of image `name` is bound under.
    // rust: pub(super) fn before_name(name: &str) -> String {
    // rust: format!("hz_before_{name}")
}

/// The images of `code` (name, declared `coherent` or `volatile`) whose loads may read the copy
/// taken before the dispatch.
    // rust: pub(super) fn snapshots(code: &str, images: &[(String, bool)]) -> Vec<String> {
    // rust: let tokens = lex(code);
    // rust: let next = |i: usize| (i + 1..tokens.len()).find(|&j| significant(tokens[j]));
    // Positions of the calls taking each image as first argument.
    // rust: let calls = |name: &str, f: &dyn Fn(&str) -> bool| -> Vec<usize> {
    // rust: (0..tokens.len())
    // rust: .filter(|&i| {
    // rust: f(tokens[i])
    // rust: && next(i).is_some_and(|o| {
    // rust: tokens[o] == "(" && next(o).is_some_and(|n| tokens[n] == name)
    // rust: })
    // rust: })
    // rust: .collect()
}
    // rust: let repeats = Repeats::of(&tokens);
    // rust: images
    // rust: .iter()
    // rust: .filter(|(_, coherent)| !coherent)
    // rust: .filter(|(name, _)| {
    // rust: let loads = calls(name, &|t| t == "imageLoad");
    // rust: let stores = calls(name, &|t| t == "imageStore");
    // rust: let atomics = calls(name, &|t| t.starts_with("imageAtomic"));
            // A load repeated after a store of the same invocation (a loop around both, or a
            // function holding both run more than once) must see the store.
    // rust: let shared = loads.iter().any(|&l| {
    // rust: let around = repeats.around(l);
    // rust: stores
    // rust: .iter()
    // rust: .any(|&s| repeats.around(s).iter().any(|r| around.contains(r)))
    // rust: });
            // The text gives the order they run in only within one function.
    // rust: let function = loads.first().map(|&l| repeats.function(l));
    // rust: let together = loads
    // rust: .iter()
    // rust: .chain(&stores)
    // rust: .all(|&i| Some(repeats.function(i)) == function);
    // rust: !loads.is_empty()
    // rust: && !stores.is_empty()
    // rust: && atomics.is_empty()
    // rust: && !shared
    // rust: && together
    // rust: && loads.iter().max() < stores.iter().min()
    // rust: })
    // rust: .map(|(name, _)| name.clone())
    // rust: .collect()
}

/// What runs a token more than once: the loops around it, and for a token in a function, the
/// loops around its calls, or the function itself when it is called more than once.
pub const Repeats = struct {
    /// Loop bodies as token ranges, with their ids.
    loops: std.ArrayList((std::ops::Range<usize),
    /// Function bodies as token ranges, with what repeats each from its calls.
    functions: std.ArrayList((std::ops::Range<usize),
};

    // rust: impl Repeats {
pub fn of(tokens: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sig: Vec<usize> = (0..tokens.len())
    // rust: .filter(|&i| significant(tokens[i]))
    // rust: .collect();
    // rust: let t = |k: usize| sig.get(k).map_or("", |&i| tokens[i]);
        // `(` at sig index `k`: its `)`.
    // rust: let close = |k: usize| {
    // rust: let mut depth = 0;
    // rust: (k..sig.len()).find(|&j| {
    // rust: match t(j) {
    // rust: "(" => depth += 1,
    // rust: ")" => depth -= 1,
    // rust: _ => {}
}
    // rust: depth == 0
    // rust: })
}
        // A statement starting at sig index `k`: its last sig index.
    // rust: let statement = |k: usize| {
    // rust: if t(k) == "{" {
    // rust: Some(matching(&sig, tokens, k))
    // rust: } else {
    // rust: (k..sig.len()).find(|&j| t(j) == ";")
}
}
    // rust: let mut loops = Vec::new();
    // rust: for k in 0..sig.len() {
    // rust: let body = match t(k) {
    // rust: "for" | "while" if t(k + 1) == "(" => close(k + 1).map(|c| c + 1),
    // rust: "do" => Some(k + 1),
    // rust: _ => None,
}
    // rust: if let Some((from, to)) = body.and_then(|b| Some((b, statement(b)?))) {
    // rust: loops.push((sig[from]..sig[to] + 1, loops.len()));
}
}
    // rust: let mut bodies = Vec::new();
    // rust: let mut k = 0;
    // rust: while k < sig.len() {
    // rust: if t(k) == "{" && k > 1 && t(k - 1) == ")" {
    // rust: let mut open = k - 1;
    // rust: let mut depth = 0;
    // rust: while open > 0 {
    // rust: match t(open) {
    // rust: ")" => depth += 1,
    // rust: "(" => {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: break;
}
}
    // rust: _ => {}
}
    // rust: open -= 1;
}
    // rust: let end = matching(&sig, tokens, k);
    // rust: if open > 0
    // rust: && is_ident(t(open - 1))
    // rust: && !matches!(t(open - 1), "if" | "for" | "while" | "switch")
    // rust: {
    // rust: bodies.push((t(open - 1), sig[open - 1], sig[k]..sig[end] + 1));
    // rust: k = end + 1;
    // rust: continue;
}
}
    // rust: k += 1;
}
    // rust: let mut next_id = loops.len();
    // rust: let functions = bodies
    // rust: .iter()
    // rust: .map(|(name, defined, range)| {
    // rust: let calls: Vec<usize> = (0..sig.len())
    // rust: .filter(|&j| t(j) == *name && t(j + 1) == "(" && sig[j] != *defined)
    // rust: .filter(|&j| !range.contains(&sig[j]))
    // rust: .map(|j| sig[j])
    // rust: .collect();
    // rust: let mut repeats: Vec<usize> = calls
    // rust: .iter()
    // rust: .flat_map(|&c| {
    // rust: loops
    // rust: .iter()
    // rust: .filter(move |(r, _)| r.contains(&c))
    // rust: .map(|l| l.1)
    // rust: })
    // rust: .collect();
    // rust: if calls.len() > 1 {
    // rust: repeats.push(next_id);
    // rust: next_id += 1;
}
    // rust: (range.clone(), repeats)
    // rust: })
    // rust: .collect();
    // rust: Self { loops, functions }
}

    /// The function token `i` is in, by its place among the functions.
pub fn function(self: *Self, i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.functions.iter().position(|(r, _)| r.contains(&i))
}

    /// What repeats token `i`.
pub fn around(self: *Self, i: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out: Vec<usize> = self
    // rust: .loops
    // rust: .iter()
    // rust: .filter(|(r, _)| r.contains(&i))
    // rust: .map(|l| l.1)
    // rust: .collect();
    // rust: for (r, repeats) in &self.functions {
    // rust: if r.contains(&i) {
    // rust: out.extend(repeats);
}
}
    // rust: out
}
}

/// `code` with the loads of `images` reading their copies.
    // rust: pub(super) fn read_before(code: &str, images: &[String]) -> String {
    // rust: let tokens = lex(code);
    // rust: let next = |i: usize| (i + 1..tokens.len()).find(|&j| significant(tokens[j]));
    // rust: let mut out: Vec<String> = tokens.iter().map(|t| t.to_string()).collect();
    // rust: for i in 0..tokens.len() {
    // rust: if tokens[i] != "imageLoad" {
    // rust: continue;
}
    // rust: if let Some(n) = next(i)
    // rust: .filter(|&o| tokens[o] == "(")
    // rust: .and_then(next)
    // rust: .filter(|&n| images.iter().any(|m| m == tokens[n]))
    // rust: {
    // rust: out[n] = before_name(tokens[n]);
}
}
    // rust: out.concat()
}

/// `code` with a barrier after each statement of `hz_main` that applies an atomic function to
/// shared memory and is not followed by one; `None` when nothing changes.
    // rust: pub(super) fn barriers_after_atomics(code: &str) -> Option<String> {
    // rust: let tokens = lex(code);
    // rust: let sig: Vec<usize> = (0..tokens.len())
    // rust: .filter(|&i| significant(tokens[i]))
    // rust: .collect();
    // rust: let t = |k: usize| sig.get(k).map_or("", |&i| tokens[i]);
    // rust: let shared = shared_names(&tokens, &sig);
    // rust: if shared.is_empty() {
    // rust: return None;
}
    // Function bodies: (name, first, last) as indices into `sig`, braces included.
    // rust: let mut functions = Vec::new();
    // rust: let mut depth = 0;
    // rust: let mut k = 0;
    // rust: while k < sig.len() {
    // rust: match t(k) {
    // rust: "{" if depth == 0 && k > 0 && t(k - 1) == ")" => {
    // rust: let mut open = k - 1;
    // rust: let mut parens = 0;
    // rust: while open > 0 {
    // rust: match t(open) {
    // rust: ")" => parens += 1,
    // rust: "(" => {
    // rust: parens -= 1;
    // rust: if parens == 0 {
    // rust: break;
}
}
    // rust: _ => {}
}
    // rust: open -= 1;
}
    // rust: let end = matching(&sig, &tokens, k);
    // rust: if open > 0 && is_ident(t(open - 1)) {
    // rust: functions.push((t(open - 1), k, end));
}
    // rust: k = end + 1;
    // rust: continue;
}
    // rust: "{" => depth += 1,
    // rust: "}" => depth -= 1,
    // rust: _ => {}
}
    // rust: k += 1;
}
    // rust: let direct = |from: usize, to: usize| {
    // rust: (from..to).any(|k| ATOMICS.contains(&t(k)) && t(k + 1) == "(" && shared.contains(&t(k + 2)))
}
    // rust: let mut atomic: Vec<&str> = functions
    // rust: .iter()
    // rust: .filter(|f| f.0 != "hz_main" && direct(f.1, f.2))
    // rust: .map(|f| f.0)
    // rust: .collect();
    // Functions calling those, until no more are found.
    // rust: loop {
    // rust: let more: Vec<&str> = functions
    // rust: .iter()
    // rust: .filter(|f| f.0 != "hz_main" && !atomic.contains(&f.0))
    // rust: .filter(|f| (f.1..f.2).any(|k| atomic.contains(&t(k)) && t(k + 1) == "("))
    // rust: .map(|f| f.0)
    // rust: .collect();
    // rust: if more.is_empty() {
    // rust: break;
}
    // rust: atomic.extend(more);
}
    // rust: let &(_, open, close) = functions.iter().find(|f| f.0 == "hz_main")?;
    // rust: if (open..close).any(|k| t(k) == "return") {
    // rust: return None;
}
    // rust: let touches = |from: usize, to: usize| {
    // rust: direct(from, to) || (from..to).any(|k| atomic.contains(&t(k)) && t(k + 1) == "(")
}
    // Statements of the body: each ends at a `;` or a block's `}` at its top level (an `if`
    // continues into its `else`, a `do` into its `while`).
    // rust: let mut statements = Vec::new();
    // rust: let (mut start, mut braces, mut parens) = (open + 1, 0, 0);
    // rust: for k in open + 1..close {
    // rust: match t(k) {
    // rust: "(" => parens += 1,
    // rust: ")" => parens -= 1,
    // rust: "{" => braces += 1,
    // rust: "}" => {
    // rust: braces -= 1;
    // rust: if braces == 0 && parens == 0 && !matches!(t(k + 1), "else" | "while" | ";") {
    // rust: statements.push((start, k));
    // rust: start = k + 1;
}
}
    // rust: ";" if braces == 0 && parens == 0 && t(k + 1) != "else" => {
    // rust: statements.push((start, k));
    // rust: start = k + 1;
}
    // rust: _ => {}
}
}
    // rust: let mut out: Vec<String> = tokens.iter().map(|t| t.to_string()).collect();
    // rust: let mut changed = false;
    // rust: for (n, &(from, to)) in statements.iter().enumerate() {
    // rust: let followed = statements
    // rust: .get(n + 1)
    // rust: .is_some_and(|&(next, _)| t(next) == "barrier");
    // rust: if !followed && statements.get(n + 1).is_some() && touches(from, to) {
    // rust: out[sig[to]].push_str(" barrier();");
    // rust: changed = true;
}
}
    // rust: changed.then(|| out.concat())
}

/// The variables declared `shared`.
    // rust: fn shared_names<'t>(tokens: &[&'t str], sig: &[usize]) -> Vec<&'t str> {
    // rust: let t = |k: usize| sig.get(k).map_or("", |&i| tokens[i]);
    // rust: let mut names = Vec::new();
    // rust: for k in 0..sig.len() {
    // rust: if t(k) != "shared" {
    // rust: continue;
}
        // `shared T a, b[N];` or `shared T[N] a;`: the identifiers after the type, outside
        // brackets, before the `;`.
    // rust: let mut j = k + 2;
    // rust: let mut brackets = 0;
    // rust: while j < sig.len() && t(j) != ";" {
    // rust: match t(j) {
    // rust: "[" => brackets += 1,
    // rust: "]" => brackets -= 1,
    // rust: w if brackets == 0 && is_ident(w) => names.push(w),
    // rust: _ => {}
}
    // rust: j += 1;
}
}
    // rust: names
}

/// The `}` closing the `{` at `sig[open]`, as an index into `sig`.
pub fn matching(sig: *[usize], tokens: *[[]const u8], open: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut depth = 0;
    // rust: for (k, &i) in sig.iter().enumerate().skip(open) {
    // rust: match tokens[i] {
    // rust: "{" => depth += 1,
    // rust: "}" => {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: return k;
}
}
    // rust: _ => {}
}
}
    // rust: sig.len() - 1
}

    // rust: mod tests {
//     use super::*;

pub fn loads_before_stores_read_the_copy() void {
}
    // rust: let code = "void hz_main() { ivec4 a = imageLoad(lights, c + o); imageStore(lights, c, a); \
    // rust: vec4 g = imageLoad(gi, c); imageStore(gi, c, g); g = imageLoad(gi, c); }";
    // rust: let images = [("lights".to_owned(), false), ("gi".to_owned(), false)];
    // rust: assert_eq!(snapshots(code, &images), ["lights"]);
    // rust: let read = read_before(code, &["lights".into()]);
    // rust: assert!(read.contains("imageLoad(hz_before_lights, c + o)"));
    // rust: assert!(read.contains("imageStore(lights, c, a)"));
}

pub fn loads_repeated_after_stores_stay() void {
}
    // rust: let images = [("v".to_owned(), false)];
    // rust: let looped = "void hz_main() { for (int i = 0; i < 4; i++) { vec4 a = imageLoad(v, p); \
    // rust: imageStore(v, p, a + 1.0); } }";
    // rust: assert!(snapshots(looped, &images).is_empty());
    // rust: let unbraced = "void hz_main() { while (k < 4) step(k++); }\n\
    // rust: void step(int k) { vec4 a = imageLoad(v, p); imageStore(v, p, a); }";
    // rust: assert!(snapshots(unbraced, &images).is_empty());
    // rust: let twice = "void step() { vec4 a = imageLoad(v, p); imageStore(v, p, a); }\n\
    // rust: void hz_main() { step(); step(); }";
    // rust: assert!(snapshots(twice, &images).is_empty());
    // rust: let once = "void step() { vec4 a = imageLoad(v, p + o); imageStore(v, p, a); }\n\
    // rust: void hz_main() { for (int i = 0; i < 2; i++) { o += i; } step(); }";
    // rust: assert_eq!(snapshots(once, &images), ["v"]);
    // rust: let helper = "vec4 get(ivec2 p) { return imageLoad(v, p); }\n\
    // rust: void hz_main() { imageStore(v, c, x); vec4 y = get(c); }";
    // rust: assert!(snapshots(helper, &images).is_empty());
}

pub fn coherent_and_atomic_images_stay() void {
}
    // rust: let code = "void hz_main() { int a = imageLoad(v, c).r; imageStore(v, c, ivec4(a)); \
    // rust: int b = imageLoad(o, c).r; imageStore(o, c, ivec4(b)); imageAtomicAdd(o, c, 1); }";
    // rust: let images = [("v".to_owned(), true), ("o".to_owned(), false)];
    // rust: assert!(snapshots(code, &images).is_empty());
}

pub fn a_barrier_follows_shared_atomics() void {
}
    // rust: let code = "shared int counts[4]; shared int total;\n\
    // rust: void add(int k) { atomicAdd(total, k); }\n\
    // rust: void hz_main() {\n\
    // rust: if (a) { for (int k = 0; k < 4; k++) atomicMax(counts[k], 1); }\n\
    // rust: int x = counts[0];\n\
    // rust: add(x);\n\
    // rust: barrier();\n\
    // rust: int y = total;\n\
    // rust: }";
    // rust: let out = barriers_after_atomics(code).unwrap();
    // rust: assert_eq!(out.lines().count(), code.lines().count());
    // rust: assert!(out.contains("atomicMax(counts[k], 1); } barrier();"));
    // rust: assert!(!out.contains("add(x); barrier();"));
}

pub fn a_barrier_does_not_split_if_from_else() void {
}
    // rust: let code = "shared int total;\nvoid hz_main() {\n if (x) atomicAdd(total, 1); else y = 1;\n int z = total;\n}";
    // rust: let out = barriers_after_atomics(code).unwrap();
    // rust: assert!(out.contains("else y = 1; barrier();"), "{out}");
    // rust: assert!(!out.contains("1); barrier(); else"), "{out}");
}

pub fn no_barrier_when_main_returns_early() void {
}
    // rust: let code = "shared int total;\nvoid hz_main() { if (a) return; atomicAdd(total, 1); int y = total; }";
    // rust: assert!(barriers_after_atomics(code).is_none());
}
}
