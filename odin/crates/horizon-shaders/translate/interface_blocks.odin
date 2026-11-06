//! Transpiled from Horizon Rust crate
package horizon_shaders_interface_blocks

import "core:fmt"
import "core:mem"
import "core:math"

// `in` and `out` interface blocks as plain varyings. GLSL lets a block's members carry their
// own interpolation and layout qualifiers (GLSL 4.60, 4.3.9: `out VertexData { flat int id;
// vec2 uv; } vOut;`); naga's frontend refuses a qualifier there ("Expected Void, Struct or a
// type, found Interpolation(Flat)"). Each member of such a block becomes a varying of its own,
// `hz_<block>_<member>` (the name the next stage's block gives it too: stages match blocks by
// block name and members by name), and `instance.member` reads it. A block without an instance
// name keeps its members' names. Of a block with an instance array (a geometry stage's input,
// `in VertexData { vec2 uv; } vIn[];`), each member becomes an array, `vIn[i].uv` reading
// `hz_VertexData_uv[i]`. Blocks whose instance is used whole are left as written. Lines stay
// where they were.

// use super::scan::significant;
// use crate::macros::lex;

// Qualifiers a member may carry before its type.
    // rust: const MEMBER_QUALIFIERS: [&str; 11] = [
    // rust: "flat",
    // rust: "smooth",
    // rust: "noperspective",
    // rust: "centroid",
    // rust: "sample",
    // rust: "invariant",
    // rust: "precise",
    // rust: "highp",
    // rust: "mediump",
    // rust: "lowp",
    // rust: "layout",
    // rust: ];

// A block found at global scope: tokens `start..=end` (its `;`), its storage, the members'
// declarations (token ranges, each without its `;`) with their names, and its instance name.
Block :: struct {
    start: uint,
    open: uint,
    close: uint,
    end: uint,
    storage: ^'static str,
    name: string,
    members: Vec<(uint,
    instance: Option<(uint,
    // The instance's array suffix (`[]`, `[3]`), empty when it is not an array.
    array: string,
}

// `code` with its plain `in`/`out` interface blocks as varyings, or `None` when it has none.
    // rust: pub(super) fn flatten(code: &str) -> Option<String> {
    // rust: flatten_as(code, "")
}

// `flatten`, the members of an `in` block with an instance named `hz_<inputs><block>_<member>`:
// a geometry stage's input and output blocks may share their name (GLSL 4.60, 4.3.9), and the
// geometry stage reads its inputs under names of its own.
    // rust: pub(super) fn flatten_as(code: &str, inputs: &str) -> Option<String> {
    // rust: let mut tokens: Vec<String> = lex(code).into_iter().map(str::to_owned).collect();
    // rust: let blocks = find_blocks(&tokens);
    // rust: if blocks.is_empty() {
    // rust: return None;
}
    // rust: let mut changed = false;
    // rust: for b in blocks {
        // A redeclared built-in block (GLSL 4.60, 7.5: `out gl_PerVertex { vec4 gl_Position;
        // };`) only restates built-ins: it goes, and they stay built-ins.
    // rust: if b.name == "gl_PerVertex" {
    // rust: for t in &mut tokens[b.start..=b.end] {
    // rust: blank(t);
}
    // rust: changed = true;
    // rust: continue;
}
    // rust: let inside = |i: usize| (b.start..=b.end).contains(&i);
    // rust: let prefix = if b.storage == "in" { inputs } else { "" };
    // rust: let renamed = |member: &str| match &b.instance {
    // rust: Some(_) => format!("hz_{prefix}{}_{member}", b.name),
    // rust: None => member.to_owned(),
}
        // Every use of the instance outside the block must be `instance.member`, or
        // `instance[i].member` for an instance array.
    // rust: let mut reads = Vec::new();
    // rust: if let Some((_, instance)) = &b.instance {
    // rust: let mut whole = false;
            // A local variable or parameter of the same name, or a member (`light.v`), is not
            // the instance.
    // rust: let hidden = hidden(&tokens, instance);
    // rust: let other = |i: usize| {
    // rust: hidden.iter().any(|h| h.contains(&i))
    // rust: || previous_significant(&tokens, i).is_some_and(|p| tokens[p] == ".")
}
    // rust: for i in
    // rust: (0..tokens.len()).filter(|&i| !inside(i) && tokens[i] == *instance && !other(i))
    // rust: {
    // rust: let index = match b.array.is_empty() {
    // rust: true => Some(i),
    // rust: false => next_significant(&tokens, i + 1)
    // rust: .filter(|&o| tokens[o] == "[")
    // rust: .and_then(|o| closing(&tokens, o)),
}
    // rust: let member = index
    // rust: .and_then(|x| next_significant(&tokens, x + 1))
    // rust: .filter(|&d| tokens[d] == ".")
    // rust: .and_then(|d| next_significant(&tokens, d + 1));
    // rust: let known = member.filter(|&m| {
    // rust: b.members
    // rust: .iter()
    // rust: .any(|(_, names)| names.iter().any(|(_, n)| *n == tokens[m]))
    // rust: });
    // rust: match (index, known) {
    // rust: (Some(x), Some(m)) => reads.push((i, x, m)),
    // rust: _ => whole = true,
}
}
    // rust: if whole {
    // rust: continue;
}
}
    // rust: for (i, index, member) in reads {
    // rust: tokens[i] = renamed(&tokens[member]);
            // `.member` goes, with the spaces around it but not its line breaks; an index stays
            // (`v[i].m` is `hz_B_m[i]`).
    // rust: for t in &mut tokens[index + 1..=member] {
    // rust: t.retain(|c| c == '\n');
}
}
    // rust: for t in &mut tokens[b.start..=b.open] {
    // rust: blank(t);
}
    // rust: for t in &mut tokens[b.close..=b.end] {
    // rust: blank(t);
}
    // rust: for (first, names) in &b.members {
    // rust: tokens[*first] = format!("{} {}", b.storage, tokens[*first]);
    // rust: for (at, name) in names {
                // Of an instance array, each member is an array of the instance's size, outermost.
    // rust: tokens[*at] = renamed(name) + &b.array;
}
}
    // rust: changed = true;
}
    // rust: changed.then(|| tokens.concat())
}

// Spaces for every character of `t` but its line breaks.
blank :: proc(t: ^string) {
}
    // rust: *t = t
    // rust: .chars()
    // rust: .map(|c| if c == '\n' { '\n' } else { ' ' })
    // rust: .collect();
}

next_significant :: proc(tokens: ^[string], from: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (from..tokens.len()).find(|&i| significant(&tokens[i]))
}

previous_significant :: proc(tokens: ^[string], before: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (0..before).rev().find(|&i| significant(&tokens[i]))
}

// Where a local variable or parameter named `name` hides a global of that name (GLSL 4.60,
// 4.2): from its declaration to the end of the block it is declared in, or of its function's
// body for a parameter.
hidden :: proc(tokens: ^[string], name: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut opens: Vec<usize> = Vec::new();
    // rust: let mut parens = 0usize;
    // rust: for i in 0..tokens.len() {
    // rust: match tokens[i].as_str() {
    // rust: "{" => opens.push(i),
    // rust: "}" => {
    // rust: opens.pop();
}
    // rust: "(" => parens += 1,
    // rust: ")" => parens = parens.saturating_sub(1),
    // rust: t if t == name => {
                // A declaration: a type before the name, and after it what ends a declarator.
    // rust: let typed = previous_significant(tokens, i).is_some_and(|p| {
    // rust: let w = tokens[p].as_str();
    // rust: w.chars().all(|c| c.is_ascii_alphanumeric() || c == '_')
    // rust: && !["return", "else", "case"].contains(&w)
    // rust: });
    // rust: let declares = next_significant(tokens, i + 1)
    // rust: .is_some_and(|n| matches!(tokens[n].as_str(), "," | ")" | ";" | "=" | "["));
    // rust: if !(typed && declares) {
    // rust: continue;
}
    // rust: let end = match opens.last() {
    // rust: Some(&open) => closing_brace(tokens, open),
                    // A parameter: its function's body follows its parameter list.
    // rust: None if parens > 0 => parameter_list_end(tokens, i)
    // rust: .and_then(|close| next_significant(tokens, close + 1))
    // rust: .filter(|&body| tokens[body] == "{")
    // rust: .and_then(|body| closing_brace(tokens, body)),
    // rust: None => None,
}
    // rust: if let Some(end) = end {
    // rust: out.push(i..end + 1);
}
}
    // rust: _ => {}
}
}
    // rust: out
}

// The `}` that closes the `{` at `open`.
closing_brace :: proc(tokens: ^[string], open: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut depth = 0usize;
    // rust: for (j, t) in tokens.iter().enumerate().skip(open) {
    // rust: match t.as_str() {
    // rust: "{" => depth += 1,
    // rust: "}" => {
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

// The `)` that closes the parameter list token `i` is in.
parameter_list_end :: proc(tokens: ^[string], i: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut depth = 0usize;
    // rust: for (j, t) in tokens.iter().enumerate().skip(i) {
    // rust: match t.as_str() {
    // rust: "(" => depth += 1,
    // rust: ")" if depth == 0 => return Some(j),
    // rust: ")" => depth -= 1,
    // rust: _ => {}
}
}
    // rust: None
}

// The `]` that closes the `[` at `open`.
closing :: proc(tokens: ^[string], open: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut depth = 0usize;
    // rust: for (j, t) in tokens.iter().enumerate().skip(open) {
    // rust: match t.as_str() {
    // rust: "[" => depth += 1,
    // rust: "]" => {
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

// The `in`/`out` interface blocks at global scope that can be flattened.
find_blocks :: proc(tokens: ^[string]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let (mut start, mut depth, mut parens) = (0, 0usize, 0usize);
    // rust: let mut i = 0;
    // rust: while i < tokens.len() {
    // rust: match tokens[i].as_str() {
    // rust: "(" => parens += 1,
    // rust: ")" => parens = parens.saturating_sub(1),
    // rust: "{" if depth == 0 && parens == 0 => match block(tokens, start, i) {
    // rust: Some(b) => {
    // rust: i = b.end;
    // rust: start = b.end + 1;
    // rust: out.push(b);
}
    // rust: None => depth = 1,
    // rust: },
    // rust: "{" => depth += 1,
    // rust: "}" if depth > 0 => {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: start = i + 1;
}
}
    // rust: ";" if depth == 0 && parens == 0 => start = i + 1,
    // rust: _ => {}
}
    // rust: i += 1;
}
    // rust: out
}

// The block whose declaration runs from token `start` to its `{` at `open`, if it is a plain
// `[layout(...)] in|out Name { members } [instance];`.
block :: proc(tokens: ^[string], start: uint, open: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let head: Vec<usize> = (start..open).filter(|&i| significant(&tokens[i])).collect();
    // rust: let (&name_at, rest) = head.split_last()?;
    // rust: let (&storage_at, prefix) = rest.split_last()?;
    // rust: let storage = match tokens[storage_at].as_str() {
    // rust: "in" => "in",
    // rust: "out" => "out",
    // rust: _ => return None,
}
    // Only a `layout(...)` may come before the storage.
    // rust: let prefix: Vec<&str> = prefix.iter().map(|&i| tokens[i].as_str()).collect();
    // rust: if !(prefix.is_empty() || prefix[0] == "layout" && prefix.last() == Some(&")")) {
    // rust: return None;
}
    // rust: let name = tokens[name_at].clone();
    // rust: if !super::scan::is_ident(&name) {
    // rust: return None;
}
    // Members to the matching `}`: `[qualifiers] type[...] name[...], name[...];`.
    // rust: let mut members = Vec::new();
    // rust: let mut i = open + 1;
    // rust: loop {
    // rust: let first = next_significant(tokens, i)?;
    // rust: if tokens[first] == "}" {
    // rust: i = first;
    // rust: break;
}
    // rust: let end = (first..tokens.len()).find(|&j| tokens[j] == ";")?;
    // rust: let words: Vec<usize> = (first..end).filter(|&j| significant(&tokens[j])).collect();
    // rust: if words
    // rust: .iter()
    // rust: .any(|&j| matches!(tokens[j].as_str(), "{" | "}"))
    // rust: {
    // rust: return None;
}
        // Past the qualifiers (and a layout's parentheses) to the type.
    // rust: let mut k = 0;
    // rust: while let Some(&w) = words.get(k) {
    // rust: if tokens[w] == "layout" {
    // rust: k += 1;
    // rust: let mut level = 0;
    // rust: while let Some(&p) = words.get(k) {
    // rust: k += 1;
    // rust: match tokens[p].as_str() {
    // rust: "(" => level += 1,
    // rust: ")" => {
    // rust: level -= 1;
    // rust: if level == 0 {
    // rust: break;
}
}
    // rust: _ => {}
}
}
    // rust: } else if MEMBER_QUALIFIERS.contains(&tokens[w].as_str()) {
    // rust: k += 1;
    // rust: } else {
    // rust: break;
}
}
        // The type, its array suffix, then the declarators.
    // rust: k += 1;
    // rust: let mut names = Vec::new();
    // rust: let mut brackets = 0;
    // rust: let mut expect_name = true;
    // rust: for &w in &words[k..] {
    // rust: match tokens[w].as_str() {
    // rust: "[" => brackets += 1,
    // rust: "]" => brackets -= 1,
    // rust: "," if brackets == 0 => expect_name = true,
    // rust: t if brackets == 0 && expect_name && super::scan::is_ident(t) => {
    // rust: names.push((w, t.to_owned()));
    // rust: expect_name = false;
}
    // rust: _ => {}
}
}
    // rust: if names.is_empty() {
    // rust: return None;
}
    // rust: members.push((first, names));
    // rust: i = end + 1;
}
    // rust: let close = i;
    // `} [instance [array]] ;`
    // rust: let after: Vec<usize> = (close + 1..tokens.len())
    // rust: .take_while(|&j| tokens[j] != ";")
    // rust: .filter(|&j| significant(&tokens[j]))
    // rust: .collect();
    // rust: let end = (close + 1..tokens.len()).find(|&j| tokens[j] == ";")?;
    // rust: let (instance, array) = match after.as_slice() {
    // rust: [] => (None, String::new()),
        // `vIn[]`, `vIn[3]`: a geometry stage's input (GLSL 4.60, 4.3.9).
    // rust: [n, rest @ ..]
    // rust: if super::scan::is_ident(&tokens[*n])
    // rust: && (rest.is_empty() || tokens[rest[0]] == "[" && tokens[*rest.last()?] == "]") =>
    // rust: {
    // rust: let array = rest.iter().map(|&j| tokens[j].as_str()).collect();
    // rust: (Some((*n, tokens[*n].clone())), array)
}
    // rust: _ => return None,
}
    // rust: if members.is_empty() {
    // rust: return None;
}
    // rust: Some(Block {
    // rust: start,
    // rust: open,
    // rust: close,
    // rust: end,
    // rust: storage,
    // rust: name,
    // rust: members,
    // rust: instance,
    // rust: array,
    // rust: })
}

    // rust: mod tests {
//     use super::*;

    // A local variable or parameter named like the instance hides it (GLSL 4.60, 4.2), and
    // `light.v` is another struct's member: the block is still flattened, those stay.
locals_named_like_the_instance_are_not_it :: proc() {
}
    // rust: let code = "out Data { vec2 uv; } v;\nstruct L { float v; };\n\
    // rust: float luma(vec3 v) { return dot(v, vec3(0.3)); }\n\
    // rust: void main() { L light; light.v = 1.0; v.uv = vec2(light.v);\n\
    // rust: { vec2 v = vec2(2.0); v.x += 1.0; } v.uv += vec2(1.0); }\n";
    // rust: let out = flatten(code).expect("flattened");
    // rust: assert!(
    // rust: out.contains("float luma(vec3 v) { return dot(v, vec3(0.3)); }"),
    // rust: "{out}"
    // rust: );
    // rust: assert!(
    // rust: out.contains("light.v = 1.0; hz_Data_uv = vec2(light.v);"),
    // rust: "{out}"
    // rust: );
    // rust: assert!(
    // rust: out.contains("{ vec2 v = vec2(2.0); v.x += 1.0; } hz_Data_uv += vec2(1.0);"),
    // rust: "{out}"
    // rust: );
}

    // A redeclared `gl_PerVertex` (GLSL 4.60, 7.5) goes: its members stay the built-ins.
a_redeclared_gl_per_vertex_goes :: proc() {
}
    // rust: let code =
    // rust: "out gl_PerVertex { vec4 gl_Position; };\nvoid main() { gl_Position = vec4(1.0); }\n";
    // rust: let out = flatten(code).expect("changed");
    // rust: assert_eq!(out.lines().next().map(str::trim), Some(""));
    // rust: assert!(out.contains("gl_Position = vec4(1.0);"));
}

members_become_varyings_on_their_lines :: proc() {
}
    // rust: let code = "out VertexData {\n    flat int id;\n    vec2 uv, st[2];\n} vOut;\n\
    // rust: void main() { vOut.id = 1; vOut . uv = vec2(0.0); vOut.st[1] = vOut.uv; }\n";
    // rust: let out = flatten(code).unwrap();
    // rust: assert_eq!(out.lines().count(), code.lines().count());
    // rust: let squash = |s: &str| s.split_whitespace().collect::<Vec<_>>().join(" ");
    // rust: assert_eq!(
    // rust: squash(&out),
    // rust: squash(
    // rust: "out flat int hz_VertexData_id; out vec2 hz_VertexData_uv, hz_VertexData_st[2]; \
    // rust: void main() { hz_VertexData_id = 1; hz_VertexData_uv = vec2(0.0); \
    // rust: hz_VertexData_st[1] = hz_VertexData_uv; }"
    // rust: )
    // rust: );
}

a_block_without_an_instance_keeps_its_member_names :: proc() {
}
    // rust: let code = "in VertexData { flat int id; };\nvoid main() { float x = float(id); }\n";
    // rust: let out = flatten(code).unwrap();
    // rust: assert_eq!(
    // rust: out.split_whitespace().collect::<Vec<_>>().join(" "),
    // rust: "in flat int id; void main() { float x = float(id); }"
    // rust: );
}

an_instance_array_makes_each_member_an_array :: proc() {
}
    // rust: let code = "in VertexData {\n    flat int id;\n    vec2 st[2];\n} vIn[];\n\
    // rust: void main() { int i = vIn[0].id; vec2 a = vIn[i + 1] . st[1]; }\n";
    // rust: let out = flatten(code).unwrap();
    // rust: assert_eq!(out.lines().count(), code.lines().count());
    // rust: assert_eq!(
    // rust: out.split_whitespace().collect::<Vec<_>>().join(" "),
    // rust: "in flat int hz_VertexData_id[]; in vec2 hz_VertexData_st[][2]; void main() { \
    // rust: int i = hz_VertexData_id[0]; vec2 a = hz_VertexData_st[i + 1][1]; }"
    // rust: );
}

other_blocks_stay_as_written :: proc() {
}
    // rust: for code in [
            // Uniform and storage blocks, an instance used whole.
    // rust: "uniform Frame { float t; } frame;\nvoid main() {}\n",
    // rust: "buffer Data { float v[]; } data;\nvoid main() {}\n",
    // rust: "in VertexData { flat int id; } vIn[];\nvoid f(VertexData d) {}\nvoid main() { f(vIn[0]); }\n",
    // rust: "out VertexData { flat int id; } vOut;\nvoid f(int x) {}\nvoid main() { vOut = vOut; }\n",
    // rust: ] {
    // rust: assert_eq!(flatten(code), None, "{code}");
}
}
}
