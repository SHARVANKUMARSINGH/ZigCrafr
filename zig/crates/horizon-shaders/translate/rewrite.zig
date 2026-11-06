//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_rewrite
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The second pass: the stage's code written again for naga, line for line, and the
//! declarations of ours it needs.

// use std::collections::{BTreeMap, HashMap};
// use std::fmt::Write;

// use naga::ShaderStage;

// use super::scan::{
    // rust: LATER_KEYWORDS, NOT_CONSTANT, Stage, UNIFORM_STATE, VERTEX_INPUTS, is_ident, is_sampler_type,
    // rust: significant,
}
// use super::{Sampler, split_sampler};

/// `inverse` for each square matrix: the adjugate over the determinant.
pub const INVERSE: []const u8 = "mat2 hz_inverse(mat2 m) { return mat2(m[1][1], -m[0][1], -m[1][0], m[0][0]) / determinant(m);
    // rust: mat3 hz_inverse(mat3 m) { vec3 r0 = cross(m[1], m[2]); vec3 r1 = cross(m[2], m[0]); vec3 r2 = cross(m[0], m[1]); \
    // rust: return transpose(mat3(r0, r1, r2)) / dot(m[0], r0); }\n\
    // rust: mat4 hz_inverse(mat4 m) {\
    // rust: float a00 = m[0][0], a01 = m[0][1], a02 = m[0][2], a03 = m[0][3], a10 = m[1][0], a11 = m[1][1], a12 = m[1][2], a13 = m[1][3];\
    // rust: float a20 = m[2][0], a21 = m[2][1], a22 = m[2][2], a23 = m[2][3], a30 = m[3][0], a31 = m[3][1], a32 = m[3][2], a33 = m[3][3];\
    // rust: float b00 = a00 * a11 - a01 * a10, b01 = a00 * a12 - a02 * a10, b02 = a00 * a13 - a03 * a10, b03 = a01 * a12 - a02 * a11;\
    // rust: float b04 = a01 * a13 - a03 * a11, b05 = a02 * a13 - a03 * a12, b06 = a20 * a31 - a21 * a30, b07 = a20 * a32 - a22 * a30;\
    // rust: float b08 = a20 * a33 - a23 * a30, b09 = a21 * a32 - a22 * a31, b10 = a21 * a33 - a23 * a31, b11 = a22 * a33 - a23 * a32;\
    // rust: float det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;\
    // rust: return mat4(a11 * b11 - a12 * b10 + a13 * b09, a02 * b10 - a01 * b11 - a03 * b09, a31 * b05 - a32 * b04 + a33 * b03, a22 * b04 - a21 * b05 - a23 * b03,\
    // rust: a12 * b08 - a10 * b11 - a13 * b07, a00 * b11 - a02 * b08 + a03 * b07, a32 * b02 - a30 * b05 - a33 * b01, a20 * b05 - a22 * b02 + a23 * b01,\
    // rust: a10 * b10 - a11 * b08 + a13 * b06, a01 * b08 - a00 * b10 - a03 * b06, a30 * b04 - a31 * b02 + a33 * b00, a21 * b02 - a20 * b04 - a23 * b00,\
    // rust: a11 * b07 - a10 * b09 - a12 * b06, a00 * b09 - a01 * b07 + a02 * b06, a31 * b01 - a30 * b03 - a32 * b00, a20 * b03 - a21 * b01 + a22 * b00) / det; }\n";

    // rust: impl Stage<'_> {
    /// Declarations of ours this stage uses (after the uniform block, samplers and varyings).
    // rust: pub(super) fn prelude(&self) -> String {
    // rust: let mut p = String::from(
    // rust: "float hz_modf(float x, out float i) { i = trunc(x); return x - i; }\n\
    // rust: vec2 hz_modf(vec2 x, out vec2 i) { i = trunc(x); return x - i; }\n\
    // rust: vec3 hz_modf(vec3 x, out vec3 i) { i = trunc(x); return x - i; }\n\
    // rust: vec4 hz_modf(vec4 x, out vec4 i) { i = trunc(x); return x - i; }\n\
    // rust: float hz_sqrt(float x) { return sqrt(max(x, 0.0)); }\n\
    // rust: vec2 hz_sqrt(vec2 x) { return sqrt(max(x, vec2(0.0))); }\n\
    // rust: vec3 hz_sqrt(vec3 x) { return sqrt(max(x, vec3(0.0))); }\n\
    // rust: vec4 hz_sqrt(vec4 x) { return sqrt(max(x, vec4(0.0))); }\n\
pub const hz_FogParameters = struct {
    // rust: hz_FogParameters hz_Fog;\n\
    // rust: float hz_zero = 0.0;\n",
    // rust: );
    // rust: if self.inverse {
    // rust: p.push_str(INVERSE);
};
    // rust: if self.gather_offsets {
    // rust: p.push_str(&gather_offsets());
}
    // rust: if self.tokens.iter().any(|t| DEPTH_NAMES.contains(t)) {
    // rust: p.push_str(DEPTH_FILTER);
}
    // rust: if self.query_lod {
    // rust: p.push_str(&query_lod());
}
        // GLSL's scalar `dot` and `normalize` (genType includes `float`); naga's are vector only.
    // rust: if self.scalar_dot {
    // rust: p.push_str("float dot(float a, float b) { return a * b; }\n");
}
    // rust: if self.scalar_normalize {
    // rust: p.push_str("float normalize(float x) { return sign(x); }\n");
}
    // rust: for name in &self.trinary {
    // rust: p.push_str(&trinary(name));
}
    // rust: if self.gbuffers {
            // Set by our `main` from the frame's matrices (gbuffers.rs).
    // rust: p.push_str(
    // rust: "mat4 hz_ModelViewMatrix; mat4 hz_ProjectionMatrix; mat4 hz_ModelViewProjectionMatrix;\n\
    // rust: mat4 hz_ModelViewMatrixInverse; mat4 hz_ProjectionMatrixInverse; mat3 hz_NormalMatrix; mat4 hz_TextureMatrix[8];\n",
    // rust: );
    // rust: } else {
    // rust: p.push_str(
    // rust: "const mat4 hz_ModelViewMatrix = mat4(1.0); const mat4 hz_ProjectionMatrix = mat4(2.0, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0, 0.0, -1.0, 0.0, -1.0, -1.0, 0.0, 1.0);\n\
    // rust: const mat4 hz_ModelViewProjectionMatrix = hz_ProjectionMatrix; const mat4 hz_ModelViewMatrixInverse = mat4(1.0); const mat3 hz_NormalMatrix = mat3(1.0);\n\
    // rust: const mat4 hz_ProjectionMatrixInverse = mat4(0.5, 0.0, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, -1.0, 0.0, 0.5, 0.5, 0.0, 1.0);\n\
    // rust: const mat4 hz_TextureMatrix[8] = mat4[8](mat4(1.0), mat4(1.0), mat4(1.0), mat4(1.0), mat4(1.0), mat4(1.0), mat4(1.0), mat4(1.0));\n",
    // rust: );
}
    // rust: if self.kind == ShaderStage::Vertex {
    // rust: p.push_str(
    // rust: "const vec2 hz_quad[6] = vec2[6](vec2(0.0, 0.0), vec2(1.0, 0.0), vec2(1.0, 1.0), vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(0.0, 1.0));\n\
    // rust: vec4 hz_Vertex; vec4 hz_Color; vec4 hz_SecondaryColor; vec3 hz_Normal; float hz_FogCoord;\n\
    // rust: vec4 hz_MultiTexCoord0; vec4 hz_MultiTexCoord1; vec4 hz_MultiTexCoord2; vec4 hz_MultiTexCoord3;\n\
    // rust: vec4 hz_MultiTexCoord4; vec4 hz_MultiTexCoord5; vec4 hz_MultiTexCoord6; vec4 hz_MultiTexCoord7;\n",
    // rust: );
    // rust: } else if self.kind == ShaderStage::Fragment {
    // rust: for n in &self.outputs {
    // rust: if !self.frag_outs.iter().any(|(at, _)| at == n) {
    // rust: writeln!(p, "layout(location = {n}) out vec4 hz_out{n};").unwrap();
}
}
    // rust: for (_, decl) in &self.frag_outs {
    // rust: writeln!(p, "{decl}").unwrap();
}
    // rust: p.push_str("vec4 hz_FragCoord;\n");
}
    // rust: p
}

    /// The pack's code with the rewrites above; the same number of lines.
    // rust: pub(super) fn rewrite(
    // rust: &self,
    // rust: samplers: &[Sampler],
    // rust: uniforms: &BTreeMap<String, String>,
    // rust: ) -> String {
    // rust: let removed = |i: usize| self.removed.iter().any(|r| r.contains(&i));
    // rust: let sampler_ty: HashMap<&str, &str> = samplers
    // rust: .iter()
    // rust: .map(|s| (s.name.as_str(), s.ty.as_str()))
    // rust: .collect();
    // rust: let old = self.pp.version.as_ref().is_none_or(|(v, _)| *v < 400);
    // rust: let fragment = self.kind == ShaderStage::Fragment;
    // rust: let mut out = String::with_capacity(self.pp.code.len() + 1024);
        // Per open bracket: the function called, and the closing text to add.
    // rust: let mut calls: Vec<(&str, &str, usize)> = Vec::new();
        // Sampler parameters of the function being written: name → type.
    // rust: let mut params: HashMap<String, String> = HashMap::new();
        // Names of samplers, bool uniforms and lowered arrays a local or parameter hides.
        // Each with where its scope starts and the block depth it ends with.
    // rust: let mut hidden: Vec<(&str, usize, i32)> = Vec::new();
        // Depths of the `for` loops whose body is a single statement, ending at its `;`.
    // rust: let mut unbraced_for: Vec<i32> = Vec::new();
    // rust: let mut depth = 0;
    // rust: let mut skip_until = 0;
        // The `;` that closes a statement we rewrite, and what is written in its place.
    // rust: let mut statement_close: Option<(usize, &str)> = None;
        // The type the function being written returns, when GLSL converts to it implicitly.
    // rust: let mut returns: Option<&str> = None;
    // rust: let next = |i: usize| (i + 1..self.tokens.len()).find(|&j| significant(self.tokens[j]));
    // rust: let prev = |i: usize| (0..i).rev().find(|&j| significant(self.tokens[j]));
    // rust: let structs: Vec<&str> = (self.tokens.iter().enumerate())
    // rust: .filter(|&(_, &t)| t == "struct")
    // rust: .filter_map(|(i, _)| next(i).map(|j| self.tokens[j]))
    // rust: .collect();
        // `shadowtex0`... (`DEPTH_NAMES`) as declared, read through a plain sampler: texture
        // calls on it go to our filtering helpers, the sampler followed by its flag: its
        // `hz_depth_linear` component, or for a parameter carrying one (`depth_scope`) its own.
    // rust: let depth_flag = |j: usize,
    // rust: params: &HashMap<String, String>,
    // rust: hidden: &[(&str, usize, i32)],
    // rust: scope: &[&str]|
    // rust: -> Option<String> {
    // rust: let name = self.tokens[j];
    // rust: if hidden.iter().any(|&(h, from, _)| h == name && j >= from) {
    // rust: return None;
}
    // rust: if scope.contains(&name) {
    // rust: return Some(format!("hz_l_{name}"));
}
    // rust: let k = DEPTH_NAMES.iter().position(|&n| n == name)?;
    // rust: (sampler_ty.get(name) == Some(&"sampler2D") && !params.contains_key(name))
    // rust: .then(|| format!("hz_depth_linear.{}", ['x', 'y', 'z', 'w'][k]))
}
        // The pack's functions given one of them as a whole sampler argument, and where: those
        // parameters carry its `hz_depth_linear` component too (`hz_l_`, -1 for other samplers).
    // rust: let mut depth_params: Vec<(&str, usize)> = Vec::new();
    // rust: {
    // rust: let mut open: Vec<(&str, usize)> = Vec::new();
    // rust: for (j, &tok) in self.tokens.iter().enumerate() {
    // rust: match tok {
    // rust: "(" => open.push((prev(j).map_or("", |k| self.tokens[k]), 0)),
    // rust: ")" => {
    // rust: open.pop();
}
    // rust: "," => {
    // rust: if let Some(c) = open.last_mut() {
    // rust: c.1 += 1;
}
}
    // rust: _ if DEPTH_NAMES.contains(&tok)
    // rust: && sampler_ty.get(tok) == Some(&"sampler2D")
    // rust: && prev(j).is_some_and(|k| matches!(self.tokens[k], "(" | ","))
    // rust: && next(j).is_some_and(|k| matches!(self.tokens[k], "," | ")")) =>
    // rust: {
    // rust: if let Some(&(callee, arg)) = open.last()
    // rust: && self
    // rust: .sampler_functions
    // rust: .get(callee)
    // rust: .is_some_and(|p| p.get(arg) == Some(&true))
    // rust: && !depth_params.contains(&(callee, arg))
    // rust: {
    // rust: depth_params.push((callee, arg));
}
}
    // rust: _ => {}
}
}
}
        // Sampler parameters of the function being written that carry `hz_l_`.
    // rust: let mut depth_scope: Vec<&str> = Vec::new();
        // GLSL 1.20's user functions hide all built-ins with the same name (8).
    // rust: let mut own_size = Vec::new();
    // rust: let mut declaration_depth = 0usize;
    // rust: for (i, &t) in self.tokens.iter().enumerate() {
    // rust: match t {
    // rust: "{" => declaration_depth += 1,
    // rust: "}" => declaration_depth = declaration_depth.saturating_sub(1),
    // rust: "textureSize1D" | "textureSize2D" | "textureSize3D"
    // rust: if declaration_depth == 0
    // rust: && next(i).is_some_and(|j| self.tokens[j] == "(")
    // rust: && prev(i)
    // rust: .is_some_and(|j| is_ident(self.tokens[j]) || self.tokens[j] == "]") =>
    // rust: {
    // rust: own_size.push(t);
}
    // rust: _ => {}
}
}
    // rust: for (i, &t) in self.tokens.iter().enumerate() {
    // rust: if i < skip_until {
    // rust: continue;
}
    // rust: if let Some((end, close)) = statement_close
    // rust: && end == i
    // rust: {
    // rust: out.push_str(close);
    // rust: statement_close = None;
                // This `;` may end the single-statement body of a `for`.
    // rust: if calls.is_empty() && unbraced_for.last() == Some(&depth) {
    // rust: while unbraced_for.last() == Some(&depth) {
    // rust: unbraced_for.pop();
}
    // rust: hidden.retain(|&(_, _, d)| d <= depth);
}
    // rust: continue;
}
    // rust: if let Some(text) = self.replaced.get(&i) {
    // rust: out.push_str(text);
    // rust: continue;
}
    // rust: if removed(i) {
    // rust: out.extend(t.chars().filter(|&c| c == '\n'));
    // rust: if t.contains(' ') && !t.contains('\n') {
    // rust: out.push(' ');
}
    // rust: continue;
}
    // rust: let array_length = |j| {
    // rust: self.runtime_array_length(j).filter(|_| {
    // rust: !hidden
    // rust: .iter()
    // rust: .any(|&(name, from, _)| name == self.tokens[j] && j >= from)
    // rust: })
}
    // rust: if let Some((length, close)) = array_length(i) {
    // rust: write!(out, "({length})").unwrap();
    // rust: for t in &self.tokens[i..=close] {
    // rust: out.extend(t.chars().filter(|&c| c == '\n'));
}
    // rust: skip_until = close + 1;
    // rust: continue;
}
            // Dimensions naga reads in reverse (`T x[A][B]`): written reversed, read as GL does.
    // rust: if t == "["
    // rust: && let Some(groups) = self.type_dimensions(i, &structs)
    // rust: {
    // rust: for &(open, close) in groups.iter().rev() {
    // rust: if (open + 1..close).all(|j| !significant(self.tokens[j])) {
                        // type_dimensions only accepts an unsized outer dimension with
                        // an initializer whose element count is known.
    // rust: write!(out, "[{}]", self.array_length(close).unwrap()).unwrap();
    // rust: } else {
    // rust: let mut j = open;
    // rust: while j <= close {
    // rust: if let Some((length, end)) = array_length(j) {
    // rust: write!(out, "({length})").unwrap();
    // rust: for t in &self.tokens[j..=end] {
    // rust: out.extend(t.chars().filter(|&c| c == '\n'));
}
    // rust: j = end + 1;
    // rust: } else {
    // rust: out.push_str(self.tokens[j]);
    // rust: j += 1;
}
}
}
}
    // rust: for pair in groups.windows(2) {
    // rust: for &gap in &self.tokens[pair[0].1 + 1..pair[1].0] {
    // rust: out.extend(gap.chars().filter(|&c| c == '\n'));
}
}
    // rust: skip_until = groups.last().map_or(i, |g| g.1) + 1;
    // rust: continue;
}
            // `sqrt(-1.0)`: GL's NaN at run time, which naga would fold and refuse.
    // rust: if t == "sqrt"
    // rust: && let Some(open) = next(i).filter(|&j| self.tokens[j] == "(")
    // rust: && let Some(minus) = next(open).filter(|&j| self.tokens[j] == "-")
    // rust: && let Some(n) = next(minus).filter(|&j| {
    // rust: self.tokens[j].starts_with(|c: char| c.is_ascii_digit() || c == '.')
    // rust: })
    // rust: && let Some(close) = next(n).filter(|&j| self.tokens[j] == ")")
    // rust: && !is_zero_literal(self.tokens[n])
    // rust: {
    // rust: out.push_str("(hz_zero / hz_zero)");
    // rust: skip_until = close + 1;
    // rust: continue;
}
            // `x / 0.0`: GL's infinity at run time, which naga would fold and refuse.
    // rust: if t == "/"
    // rust: && let Some(j) = next(i).filter(|&j| is_zero_literal(self.tokens[j]))
    // rust: {
    // rust: out.push_str("/ hz_zero");
    // rust: skip_until = j + 1;
    // rust: continue;
}
            // naga's frontend leaves the code after an unconditional `discard` or `return`
            // unreachable but half-built (a module that fails validation): behind an `if` it
            // stays reachable as far as naga knows. The braces keep a pack's `else` with the
            // pack's `if` (`if (c) discard; else ...`). A `return` with a value is guarded only
            // as a statement of its own with code after it in its block: as an `if`'s branch
            // the code after it is reachable already, and naga would end our guard's empty
            // `else` with a `return;` of its own where the function returns a value.
            // GLSL converts a returned value to the function's type (`return 1;` in a `float`
            // function); naga does not, so the conversion is written out: `return float(1);`.
    // rust: if matches!(t, "discard" | "return")
    // rust: && let Some(end) = self.statement_end(i)
    // rust: {
    // rust: let value = t == "return" && next(i) != Some(end);
    // rust: let guard = !value
    // rust: || (prev(i).is_none_or(|j| matches!(self.tokens[j], ";" | "{" | "}"))
    // rust: && next(end).is_some_and(|j| self.tokens[j] != "}"));
    // rust: let wrap = returns.filter(|_| value && !self.top_level_comma(i, end));
    // rust: if guard || wrap.is_some() {
    // rust: if guard {
    // rust: out.push_str("{ if (true) ");
}
    // rust: out.push_str(t);
    // rust: if let Some(ty) = wrap {
    // rust: write!(out, " {ty}(").unwrap();
}
    // rust: statement_close = Some((
    // rust: end,
    // rust: match (wrap.is_some(), guard) {
    // rust: (true, true) => "); }",
    // rust: (true, false) => ");",
    // rust: (false, _) => "; }",
    // rust: },
    // rust: ));
    // rust: continue;
}
}
    // rust: let called = next(i).is_some_and(|j| self.tokens[j] == "(");
    // rust: match t {
    // rust: "{" => {
    // rust: if depth == 0 {
    // rust: returns = self.converted_return(i);
}
    // rust: depth += 1;
}
    // rust: "}" => {
    // rust: depth -= 1;
    // rust: hidden.retain(|&(_, _, d)| d <= depth);
    // rust: if depth == 0 {
    // rust: params.clear();
    // rust: depth_scope.clear();
    // rust: hidden.clear();
    // rust: returns = None;
}
}
    // rust: ";" if calls.is_empty() && unbraced_for.last() == Some(&depth) => {
    // rust: while unbraced_for.last() == Some(&depth) {
    // rust: unbraced_for.pop();
}
    // rust: hidden.retain(|&(_, _, d)| d <= depth);
}
                // A prototype (`float h(bool x);`) ends its parameters' scope.
    // rust: ";" if depth == 0 && calls.is_empty() => {
    // rust: hidden.clear();
    // rust: params.clear();
    // rust: depth_scope.clear();
}
    // rust: "(" => {
    // rust: let callee = prev(i).map_or("", |j| self.tokens[j]);
    // rust: let close = if matches!(callee, "shadow2D" | "shadow2DLod" | "shadow2DProj") {
    // rust: ")"
    // rust: } else {
    // rust: ""
}
    // rust: calls.push((callee, close, 0));
}
    // rust: ")" => {
    // rust: if let Some((callee, close, _)) = calls.pop() {
    // rust: out.push_str(close);
    // rust: if callee == "for" && next(i).is_some_and(|j| self.tokens[j] != "{") {
    // rust: unbraced_for.push(depth);
}
}
}
    // rust: "," => {
    // rust: if let Some(c) = calls.last_mut() {
    // rust: c.2 += 1;
}
}
    // rust: _ => {}
}
            // `T x[] = T[](a, b)`: naga gives unsized arrays no size, so the count is written in.
    // rust: if t == "["
    // rust: && let Some(close) = next(i).filter(|&j| self.tokens[j] == "]")
    // rust: {
    // rust: if let Some(n) = self.array_length(close) {
    // rust: write!(out, "[{n}]").unwrap();
    // rust: skip_until = close + 1;
    // rust: continue;
}
}
    // rust: if !is_ident(t) {
    // rust: out.push_str(t);
    // rust: continue;
}
            // A local `const` that calls a built-in naga cannot evaluate: an ordinary local.
    // rust: if t == "const" && depth > 0 && self.calls_not_constant(i) {
    // rust: continue;
}
            // A parameter's `const` (`const in float x`, which naga's parser refuses): it only
            // promises the function does not write the parameter.
    // rust: if t == "const" && depth == 0 && !calls.is_empty() {
    // rust: continue;
}
            // A function definition's sampler parameters: `sampler2D s` → `texture2D s, sampler hz_s_s`.
    // rust: if depth == 0 && is_sampler_type(t) && calls.len() == 1 {
    // rust: if let Some(n) = next(i).filter(|&n| is_ident(self.tokens[n])) {
    // rust: let name = self.tokens[n];
    // rust: let (texture, sampler) = split_sampler(t);
    // rust: write!(out, "{texture} {name}, {sampler} hz_s_{name}").unwrap();
    // rust: if t == "sampler2D" && depth_params.contains(&(calls[0].0, calls[0].2)) {
    // rust: write!(out, ", float hz_l_{name}").unwrap();
    // rust: depth_scope.push(name);
}
    // rust: params.insert(name.to_owned(), t.to_owned());
    // rust: skip_until = n + 1;
    // rust: continue;
}
}
            // `float specular`: a variable of the same name as a sampler or a sampler parameter,
            // from the end of its initializer to the function's end; `.specular` a member.
    // rust: if sampler_ty.contains_key(t)
    // rust: || params.contains_key(t)
    // rust: || uniforms.get(t).is_some_and(|ty| ty == "bool")
    // rust: || self.core_matrix(t).is_some()
    // rust: || ((depth > 0 || !calls.is_empty()) && self.runtime_array_lengths.contains_key(t))
    // rust: {
    // rust: let before = prev(i).map(|j| self.tokens[j]);
    // rust: if before == Some(".") {
    // rust: out.push_str(t);
    // rust: continue;
}
    // rust: let declares = before
    // rust: .is_some_and(|b| is_ident(b) && !matches!(b, "return" | "case" | "else"))
    // rust: || (before == Some(",")
    // rust: && (calls.is_empty() || calls.last().is_some_and(|c| c.0 == "for"))
    // rust: && self.is_next_declarator(i));
    // rust: if declares {
                    // A `for` header's variable ends with the loop's block.
    // rust: let ends = if calls.last().is_some_and(|c| c.0 == "for") {
    // rust: depth + 1
    // rust: } else {
    // rust: depth.max(1)
}
    // rust: hidden.push((t, self.scope_start(i), ends));
    // rust: out.push_str(t);
    // rust: continue;
}
}
    // rust: if hidden.iter().any(|&(h, from, _)| h == t && i >= from) {
    // rust: out.push_str(t);
    // rust: continue;
}
    // rust: if let Some(matrix) = self.core_matrix(t) {
    // rust: out.push_str(matrix);
    // rust: continue;
}
            // A sampler named like a function (`texture(texture, uv)`) is the function when called.
    // rust: let sampler = params
    // rust: .get(t)
    // rust: .map(String::as_str)
    // rust: .or_else(|| sampler_ty.get(t).copied())
    // rust: .filter(|_| !called);
    // rust: if sampler.is_some()
    // rust: && calls.last().is_some_and(|&(callee, _, arg)| {
    // rust: arg == 0 && depth_call(callee, depth_scope.contains(&t)).is_some()
    // rust: })
    // rust: && prev(i).is_some_and(|j| self.tokens[j] == "(")
    // rust: && next(i).is_some_and(|j| self.tokens[j] == ",")
    // rust: && let Some(flag) = depth_flag(i, &params, &hidden, &depth_scope)
    // rust: {
    // rust: write!(out, "{t}, hz_s_{t}, {flag}").unwrap();
    // rust: continue;
}
    // rust: if let Some(ty) = sampler {
    // rust: let as_argument = calls.last().is_some_and(|(callee, _, arg)| {
    // rust: self.sampler_functions
    // rust: .get(*callee)
    // rust: .is_some_and(|p| p.get(*arg) == Some(&true))
    // rust: }) && prev(i)
    // rust: .is_some_and(|j| matches!(self.tokens[j], "(" | ","));
    // rust: if as_argument {
    // rust: write!(out, "{t}, hz_s_{t}").unwrap();
    // rust: if let Some(&(callee, _, arg)) = calls.last()
    // rust: && depth_params.contains(&(callee, arg))
    // rust: {
    // rust: let flag = depth_flag(i, &params, &hidden, &depth_scope)
    // rust: .unwrap_or_else(|| "-1.0".into());
    // rust: write!(out, ", {flag}").unwrap();
}
    // rust: } else {
    // rust: write!(out, "{ty}({t}, hz_s_{t})").unwrap();
}
    // rust: continue;
}
    // rust: if uniforms.get(t).is_some_and(|ty| ty == "bool") {
    // rust: write!(out, "(hz_bool_{t} != 0)").unwrap();
    // rust: continue;
}
            // EXT_gpu_shader4's size names keep their dimension-specific signatures. Resolve
            // only a known sampler, leaving user functions and mismatched dimensions to naga.
    // rust: let size_sampler = match t {
    // rust: "textureSize1D" => Some("sampler1D"),
    // rust: "textureSize2D" => Some("sampler2D"),
    // rust: "textureSize3D" => Some("sampler3D"),
    // rust: _ => None,
}
    // rust: let legacy_size_call = size_sampler.is_some_and(|expected| {
    // rust: if !called || own_size.contains(&t) {
    // rust: return false;
}
    // rust: let mut argument = next(i).and_then(next);
    // rust: while let Some(j) = argument.filter(|&j| self.tokens[j] == "(") {
    // rust: argument = next(j);
}
    // rust: let Some(argument) = argument else {
    // rust: return false;
}
    // rust: let name = self.tokens[argument];
    // rust: if hidden
    // rust: .iter()
    // rust: .any(|&(h, from, _)| h == name && argument >= from)
    // rust: {
    // rust: return false;
}
    // rust: params
    // rust: .get(name)
    // rust: .map(String::as_str)
    // rust: .or_else(|| sampler_ty.get(name).copied())
    // rust: .is_some_and(|ty| ty.strip_prefix(['i', 'u']).unwrap_or(ty) == expected)
    // rust: });
    // rust: if called
    // rust: && let Some(a) = next(i).and_then(next)
    // rust: && let Some(helper) = depth_call(t, depth_scope.contains(&self.tokens[a]))
    // rust: && next(a).is_some_and(|j| self.tokens[j] == ",")
    // rust: && depth_flag(a, &params, &hidden, &depth_scope).is_some()
    // rust: {
    // rust: out.push_str(helper);
    // rust: continue;
}
    // rust: let replaced: Option<String> = match t {
    // rust: "main" if depth == 0 && called => Some("hz_main".into()),
                // GLSL's `modf`, which naga's frontend lacks.
    // rust: "modf" if called => Some("hz_modf".into()),
                // `sqrt` of a negative is undefined in GLSL; GL drivers' rounding keeps packs'
                // `sqrt(1.0 - y * y)` at y = 1 from going below zero, SPIR-V's fused arithmetic
                // may not, and the NaN spreads (SEUS PTGI HRR: speckled water reflections).
                // Global initializers keep theirs: they are evaluated when compiling.
    // rust: "sqrt" if called && depth > 0 => Some("hz_sqrt".into()),
    // rust: "textureGatherOffsets" if called => Some("hz_textureGatherOffsets".into()),
    // rust: "textureQueryLod" if called => Some("hz_textureQueryLod".into()),
                // Matrix inverse, which naga writes for neither Metal nor WGSL.
    // rust: "inverse" if called && self.inverse => Some("hz_inverse".into()),
    // rust: "texture2D" | "texture1D" | "texture3D" | "textureCube" if called => {
    // rust: Some("texture".into())
}
    // rust: "texture2DLod" | "texture3DLod" | "texture2DLodARB" | "textureCubeLod"
    // rust: if called =>
    // rust: {
    // rust: Some("textureLod".into())
}
                // GL_EXT_gpu_shader4's names (Bliss).
    // rust: "texelFetch1D" | "texelFetch2D" | "texelFetch3D" if called => {
    // rust: Some("texelFetch".into())
}
    // rust: "textureSize1D" | "textureSize2D" | "textureSize3D" if legacy_size_call => {
    // rust: Some("textureSize".into())
}
    // rust: "texture2DProj" if called => Some("textureProj".into()),
    // rust: "texture2DGrad" | "texture2DGradARB" if called => Some("textureGrad".into()),
    // rust: "shadow2D" if called => Some("vec4(texture".into()),
    // rust: "shadow2DLod" if called => Some("vec4(textureLod".into()),
    // rust: "shadow2DProj" if called => Some("vec4(textureProj".into()),
    // rust: "ftransform" if called => {
                    // `ftransform()` → the transform it stands for; its `()` stays as a no-op call... so skip it.
                    // The vertex goes through the model-view matrix first, then the projection:
                    // read back with a probe pack of ours, Iris 1.11.7's `ftransform()` has the
                    // bits of `gl_ProjectionMatrix * (gl_ModelViewMatrix * gl_Vertex)` at every
                    // vertex our probes read, where the product matrix
                    // `hz_ModelViewProjectionMatrix` rounds differently in the last bits (#8464).
    // rust: let close = next(i).and_then(next);
    // rust: skip_until = close.map_or(i + 1, |c| c + 1);
    // rust: Some("(hz_ProjectionMatrix * (hz_ModelViewMatrix * hz_Vertex))".into())
}
    // rust: "gl_FragColor" => Some("hz_out0".into()),
    // rust: "gl_FragData" | "gl_TexCoord" => match self.index_after(i) {
    // rust: Some((n, close)) => {
    // rust: skip_until = close + 1;
    // rust: Some(match t {
    // rust: "gl_FragData" => format!("hz_out{n}"),
    // rust: _ => format!("hz_TexCoord{n}"),
    // rust: })
}
    // rust: None => None,
    // rust: },
    // rust: "gl_Color" if fragment => Some("hz_FrontColor".into()),
    // rust: "gl_FragCoord" if !fragment => None,
    // rust: "gl_FragCoord" => Some("hz_FragCoord".into()),
    // rust: "gl_FrontColor" => Some("hz_FrontColor".into()),
    // rust: "gl_FogFragCoord" => Some("hz_FogFragCoord".into()),
    // rust: "gl_Fog" => Some("hz_Fog".into()),
                // Before the compatibility inputs, of which `gl_Vertex` is a prefix.
    // rust: "gl_VertexID" => Some("gl_VertexIndex".into()),
    // rust: "gl_InstanceID" => Some("gl_InstanceIndex".into()),
    // rust: "gl_VertexIndex" | "gl_InstanceIndex" => None,
    // rust: _ if UNIFORM_STATE.iter().any(|b| t.starts_with(b)) => {
    // rust: Some(format!("hz_{}", &t[3..]))
}
    // rust: _ if !fragment && VERTEX_INPUTS.iter().any(|b| t.starts_with(b)) => {
    // rust: Some(format!("hz_{}", &t[3..]))
}
    // rust: _ if old && LATER_KEYWORDS.contains(&t) => Some(format!("hz_kw_{t}")),
    // rust: _ => None,
}
    // rust: out.push_str(replaced.as_deref().unwrap_or(t));
}
    // rust: out
}
}

    // rust: impl Stage<'_> {
    /// The length of a lowered global array is still a constant expression. Naga attempts a
    /// runtime load before resolving `.length()`, so retain the declared size explicitly.
pub fn runtime_array_length(self: *Self, i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (length, declared) = self.runtime_array_lengths.get(self.tokens[i])?;
    // rust: if i <= *declared
    // rust: || self.tokens[..i]
    // rust: .iter()
    // rust: .rfind(|t| significant(t))
    // rust: .is_some_and(|&t| t == ".")
    // rust: {
    // rust: return None;
}
    // rust: let mut at = i;
    // rust: for expected in [".", "length", "(", ")"] {
    // rust: at = (at + 1..self.tokens.len()).find(|&j| significant(self.tokens[j]))?;
    // rust: if self.tokens[at] != expected {
    // rust: return None;
}
}
    // rust: Some((length, at))
}

    /// Whether the declaration after token `i` calls a built-in in `NOT_CONSTANT` before its `;`.
    /// The return type of the function whose body opens at token `brace`, when it is one GLSL
    /// converts returned values to (a scalar or vector of `float`, `int` or `uint`).
    // rust: pub(super) fn converted_return(&self, brace: usize) -> Option<&str> {
    // rust: let prev = |i: usize| (0..i).rev().find(|&j| significant(self.tokens[j]));
    // rust: let close = prev(brace).filter(|&j| self.tokens[j] == ")")?;
    // rust: let mut depth = 0usize;
    // rust: let open = (0..=close).rev().find(|&j| match self.tokens[j] {
    // rust: ")" => {
    // rust: depth += 1;
    // rust: false
}
    // rust: "(" => {
    // rust: depth -= 1;
    // rust: depth == 0
}
    // rust: _ => false,
    // rust: })?;
    // rust: let ty = self.tokens[prev(prev(open)?)?];
    // rust: matches!(
    // rust: ty,
    // rust: "float"
    // rust: | "vec2"
    // rust: | "vec3"
    // rust: | "vec4"
    // rust: | "int"
    // rust: | "ivec2"
    // rust: | "ivec3"
    // rust: | "ivec4"
    // rust: | "uint"
    // rust: | "uvec2"
    // rust: | "uvec3"
    // rust: | "uvec4"
    // rust: )
    // rust: .then_some(ty)
}

    /// Whether tokens `i..end` hold a comma outside brackets (GLSL's comma operator).
    // rust: pub(super) fn top_level_comma(&self, i: usize, end: usize) -> bool {
    // rust: let mut depth = 0usize;
    // rust: self.tokens[i..end].iter().any(|&t| match t {
    // rust: "(" | "[" => {
    // rust: depth += 1;
    // rust: false
}
    // rust: ")" | "]" => {
    // rust: depth = depth.saturating_sub(1);
    // rust: false
}
    // rust: "," => depth == 0,
    // rust: _ => false,
    // rust: })
}

    /// The `;` that ends the statement starting at token `i` (outside brackets).
    // rust: pub(super) fn statement_end(&self, i: usize) -> Option<usize> {
    // rust: let mut depth = 0usize;
    // rust: for j in i + 1..self.tokens.len() {
    // rust: match self.tokens[j] {
    // rust: "(" | "[" => depth += 1,
    // rust: ")" | "]" => depth = depth.saturating_sub(1),
    // rust: ";" if depth == 0 => return Some(j),
    // rust: "{" | "}" => return None,
    // rust: _ => {}
}
}
    // rust: None
}

    // rust: pub(super) fn calls_not_constant(&self, i: usize) -> bool {
    // rust: for (j, &t) in self.tokens.iter().enumerate().skip(i + 1) {
    // rust: if matches!(t, ";" | "{" | "}") {
    // rust: return false;
}
    // rust: if NOT_CONSTANT.contains(&t)
    // rust: && self.tokens[j + 1..].iter().find(|t| significant(t)) == Some(&"(")
    // rust: {
    // rust: return true;
}
}
    // rust: false
}

    /// When the `[` at token `i` begins two or more array dimensions of a type (after a type
    /// name, `float[2][3]`, or after the name a type declares, `float x[2][3]`), each one's
    /// first and last token. naga's frontend nests such dimensions the other way round.
pub fn type_dimensions(self: *Self, i: usize, structs: *[[]const u8]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prev = |k: usize| (0..k).rev().find(|&j| significant(self.tokens[j]));
    // rust: let is_type = |t: &str| TYPE_NAMES.contains(&t) || structs.contains(&t);
    // rust: let p = prev(i)?;
    // rust: let declared = is_ident(self.tokens[p])
    // rust: && prev(p).is_some_and(|q| is_type(self.tokens[q]) || self.tokens[q] == "]");
    // rust: if !is_type(self.tokens[p]) && !declared {
    // rust: return None;
}
    // rust: let mut groups = Vec::new();
    // rust: let mut open = i;
    // rust: loop {
    // rust: let mut level = 0;
    // rust: let mut close = None;
    // rust: for j in open..self.tokens.len() {
    // rust: match self.tokens[j] {
    // rust: "[" => level += 1,
    // rust: "]" => {
    // rust: level -= 1;
    // rust: if level == 0 {
    // rust: close = Some(j);
    // rust: break;
}
}
    // rust: _ => {}
}
}
    // rust: let close = close?;
            // An initializer can size the outer dimension. Include it in the reversal
            // together with the explicit inner dimensions rather than reversing only them.
    // rust: if (open + 1..close).all(|j| !significant(self.tokens[j]))
    // rust: && !(groups.is_empty() && self.array_length(close).is_some())
    // rust: {
    // rust: return None;
}
    // rust: groups.push((open, close));
    // rust: match (close + 1..self.tokens.len()).find(|&j| significant(self.tokens[j])) {
    // rust: Some(j) if self.tokens[j] == "[" => open = j,
    // rust: _ => break,
}
}
    // rust: (groups.len() > 1).then_some(groups)
}

    /// Whether the name at `i`, after a `,`, is another declarator of the statement's type
    /// (`bool a = 1, x = 0;`): the statement starts with a type and a name.
pub fn is_next_declarator(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let follows = (i + 1..self.tokens.len())
    // rust: .find(|&j| significant(self.tokens[j]))
    // rust: .map(|j| self.tokens[j]);
    // rust: if !matches!(follows, Some("=" | "," | ";" | "[")) {
    // rust: return false;
}
    // rust: let mut level = 0i32;
    // rust: let mut start = i;
    // rust: let mut j = i;
    // rust: while j > 0 {
    // rust: j -= 1;
    // rust: let t = self.tokens[j];
    // rust: if !significant(t) {
    // rust: continue;
}
    // rust: match t {
    // rust: ")" | "]" => level += 1,
    // rust: "(" | "[" if level > 0 => level -= 1,
    // rust: "(" | "[" | "{" | "}" | ";" if level == 0 => break,
    // rust: _ => {}
}
    // rust: start = j;
}
    // rust: is_ident(self.tokens[start])
    // rust: && !matches!(self.tokens[start], "return" | "case" | "else" | "do")
    // rust: && (start + 1..i)
    // rust: .find(|&j| significant(self.tokens[j]))
    // rust: .is_some_and(|j| is_ident(self.tokens[j]))
}

    /// Where the scope of the name declared at token `i` begins: after its initializer (GLSL 4.60
    /// 4.2.2: `float depth = texture(depth, uv).x` still reads the outer `depth`), else after it.
pub fn scope_start(self: *Self, i: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let after = (i + 1..self.tokens.len()).find(|&j| significant(self.tokens[j]));
    // rust: if after.is_none_or(|j| self.tokens[j] != "=") {
    // rust: return i + 1;
}
    // rust: let mut level = 0i32;
    // rust: for j in i + 1..self.tokens.len() {
    // rust: match self.tokens[j] {
    // rust: "(" | "[" | "{" => level += 1,
    // rust: ")" | "]" | "}" => level -= 1,
    // rust: "," | ";" if level <= 0 => return j,
    // rust: _ => {}
}
}
    // rust: self.tokens.len()
}

    /// The element count of an unsized array whose `[]` ends at `close`: the arguments of the
    /// following constructor, or the top-level elements of its brace initializer (GLSL 4.40,
    /// 4.1.11). Nested aggregate elements and a trailing initializer comma do not add elements.
    // rust: pub(super) fn array_length(&self, close: usize) -> Option<usize> {
    // rust: let mut j = close + 1;
    // rust: let mut seen_eq = false;
    // rust: let end = loop {
    // rust: match self.tokens.get(j).copied()? {
    // rust: "(" => break ")",
    // rust: "{" if seen_eq => break "}",
    // rust: "=" if !seen_eq => seen_eq = true,
    // rust: ";" | "," | ")" | "{" => return None,
    // rust: _ => {}
}
    // rust: j += 1;
}
    // rust: let (mut depth, mut args, mut any) = (0, 0, false);
    // rust: for &t in &self.tokens[j + 1..] {
    // rust: match t {
    // rust: "(" | "[" | "{" => {
    // rust: depth += 1;
    // rust: any = true;
}
    // rust: t if t == end && depth == 0 => {
    // rust: let count = args + usize::from(any);
    // rust: return (count > 0).then_some(count);
}
    // rust: ")" | "]" | "}" => depth -= 1,
    // rust: "," if depth == 0 => {
    // rust: args += 1;
    // rust: any = false;
}
    // rust: _ if significant(t) => any = true,
    // rust: _ => {}
}
}
    // rust: None
}
}

/// What our vertex `main` gives a vertex input of a composite-style program.
/// GLSL's scalar, vector and matrix type names.
    // rust: const TYPE_NAMES: [&str; 35] = [
    // rust: "float", "int", "uint", "bool", "double", "vec2", "vec3", "vec4", "ivec2", "ivec3", "ivec4",
    // rust: "uvec2", "uvec3", "uvec4", "bvec2", "bvec3", "bvec4", "dvec2", "dvec3", "dvec4", "mat2",
    // rust: "mat3", "mat4", "mat2x2", "mat2x3", "mat2x4", "mat3x2", "mat3x3", "mat3x4", "mat4x2", "mat4x3",
    // rust: "mat4x4", "dmat2", "dmat3", "dmat4",
    // rust: ];

/// `0.0`, `0.`, `.0`, `0.0f`: a floating-point literal zero.
/// `textureGatherOffsets` (GLSL 4.60, 8.9.4), which naga's frontend lacks: texel `i` of the
/// result is texel `i` of the footprint `offsets[i]` texels away. WGSL takes only constant
/// offsets, so each footprint is gathered at `P` moved by its offset over the texture's size,
/// which picks the same four texels; the component, a constant in GLSL, picks one of four
/// gathers.
/// GL_AMD_shader_trinary_minmax's `min3`, `max3` or `mid3` (its additions to GLSL 4.30
/// Section 8.3: genType, genIType and genUType overloads): the per-component minimum, maximum
/// or median of x, y and z.
pub fn trinary(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let body = match name {
    // rust: "min3" => "min(x, min(y, z))",
    // rust: "max3" => "max(x, max(y, z))",
    // rust: _ => "max(min(x, y), min(max(x, y), z))",
}
    // rust: let mut p = String::new();
    // rust: for (scalar, vector) in [("float", "vec"), ("int", "ivec"), ("uint", "uvec")] {
    // rust: for n in 1..=4 {
    // rust: let ty = match n {
    // rust: 1 => scalar.to_owned(),
    // rust: _ => format!("{vector}{n}"),
}
    // rust: writeln!(
    // rust: p,
    // rust: "{ty} {name}({ty} x, {ty} y, {ty} z) {{ return {body}; }}"
    // rust: )
    // rust: .unwrap();
}
}
    // rust: p
}

/// The depth samplers a plain `sampler2D` can name: `hz_depth_linear`'s x, y, z and w.
pub const DEPTH_NAMES: [[]const u8; 4] = ["shadowtex0", "shadowtex1", "shadow", "watershadow"];

/// The helper standing for a texture call on one of `DEPTH_NAMES`, or on a parameter carrying
/// one (`parameter`: no offset helpers, see `DEPTH_FILTER`).
pub fn depth_call(callee: []const u8, parameter: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if parameter && callee.ends_with("Offset") {
    // rust: return None;
}
    // rust: Some(match callee {
    // rust: "texture2D" | "texture" => "hz_depthTexture",
    // rust: "texture2DLod" | "texture2DLodARB" | "textureLod" => "hz_depthTextureLod",
    // rust: "textureOffset" => "hz_depthTextureOffset",
    // rust: "textureLodOffset" => "hz_depthTextureLodOffset",
    // rust: "texture2DGrad" | "texture2DGradARB" | "textureGrad" => "hz_depthTextureGrad",
    // rust: "textureGradOffset" => "hz_depthTextureGradOffset",
    // rust: "texture2DProj" | "textureProj" => "hz_depthTextureProj",
    // rust: "texture2DProjLod" | "textureProjLod" => "hz_depthTextureProjLod",
    // rust: _ => return None,
    // rust: })
}

/// A shadow depth read through a plain sampler, filtered as a filtering sampler reads a colour
/// texture when `l` is 1 (0: the nearest texel): the four texels around the point gathered, at
/// the corner they share so the hardware's choice of texels can't differ from ours, and blended
/// bilinearly. wgpu filters a depth format only in a comparison. The weights are whole 256ths,
/// as Iris 1.11.7's reads on our NVIDIA GPU fit (#8464; a fit to our probe packs' readings, not
/// Iris's code): the point's place between texels rounded half up to a 256th on each axis, the
/// far corner's weight `wx × wy / 256` rounded half up, the others what is left of each axis.
/// The depth has one level, so a level, bias or gradients change nothing; offsets and projection
/// apply. `l` is -1 for any other texture passed to a parameter that also takes a depth: then the
/// built-in the pack called. A texel offset must be a constant, which a helper's parameter is
/// not, so the offset helpers serve only the samplers themselves (`depth_call`).
    // rust: const DEPTH_FILTER: &str = "vec4 hz_depthRead(texture2D t, sampler s, float l, vec2 p) {\n\
    // rust: \x20   if (l == 0.0) return textureLod(sampler2D(t, s), p, 0.0);\n\
    // rust: \x20   vec2 size = vec2(textureSize(sampler2D(t, s), 0));\n\
    // rust: \x20   vec2 x = p * size - 0.5;\n\
    // rust: \x20   vec2 i = floor(x);\n\
    // rust: \x20   vec2 f = floor((x - i) * 256.0 + 0.5);\n\
    // rust: \x20   float f11 = floor(f.x * f.y / 256.0 + 0.5);\n\
    // rust: \x20   vec4 g = textureGather(sampler2D(t, s), (i + 1.0) / size);\n\
    // rust: \x20   float d = (g.z - g.w) * (f.x - f11) + (g.x - g.w) * (f.y - f11) + (g.y - g.w) * f11;\n\
    // rust: \x20   return vec4(g.w + d / 256.0, 0.0, 0.0, 1.0);\n}\n\
    // rust: vec2 hz_depthOffset(texture2D t, sampler s, ivec2 o) { return vec2(o) / vec2(textureSize(sampler2D(t, s), 0)); }\n\
    // rust: vec4 hz_depthTexture(texture2D t, sampler s, float l, vec2 p) {\n\
    // rust: \x20   if (l < 0.0) return texture(sampler2D(t, s), p);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p);\n}\n\
    // rust: vec4 hz_depthTexture(texture2D t, sampler s, float l, vec2 p, float b) {\n\
    // rust: \x20   if (l < 0.0) return texture(sampler2D(t, s), p, b);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p);\n}\n\
    // rust: vec4 hz_depthTextureLod(texture2D t, sampler s, float l, vec2 p, float lod) {\n\
    // rust: \x20   if (l < 0.0) return textureLod(sampler2D(t, s), p, lod);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p);\n}\n\
    // rust: vec4 hz_depthTextureOffset(texture2D t, sampler s, float l, vec2 p, ivec2 o) {\n\
    // rust: \x20   return hz_depthRead(t, s, l, p + hz_depthOffset(t, s, o));\n}\n\
    // rust: vec4 hz_depthTextureOffset(texture2D t, sampler s, float l, vec2 p, ivec2 o, float b) {\n\
    // rust: \x20   return hz_depthRead(t, s, l, p + hz_depthOffset(t, s, o));\n}\n\
    // rust: vec4 hz_depthTextureLodOffset(texture2D t, sampler s, float l, vec2 p, float lod, ivec2 o) {\n\
    // rust: \x20   return hz_depthRead(t, s, l, p + hz_depthOffset(t, s, o));\n}\n\
    // rust: vec4 hz_depthTextureGrad(texture2D t, sampler s, float l, vec2 p, vec2 dx, vec2 dy) {\n\
    // rust: \x20   if (l < 0.0) return textureGrad(sampler2D(t, s), p, dx, dy);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p);\n}\n\
    // rust: vec4 hz_depthTextureGradOffset(texture2D t, sampler s, float l, vec2 p, vec2 dx, vec2 dy, ivec2 o) {\n\
    // rust: \x20   return hz_depthRead(t, s, l, p + hz_depthOffset(t, s, o));\n}\n\
    // rust: vec4 hz_depthTextureProj(texture2D t, sampler s, float l, vec3 p) {\n\
    // rust: \x20   if (l < 0.0) return textureProj(sampler2D(t, s), p);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p.xy / p.z);\n}\n\
    // rust: vec4 hz_depthTextureProj(texture2D t, sampler s, float l, vec4 p) {\n\
    // rust: \x20   if (l < 0.0) return textureProj(sampler2D(t, s), p);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p.xy / p.w);\n}\n\
    // rust: vec4 hz_depthTextureProj(texture2D t, sampler s, float l, vec3 p, float b) {\n\
    // rust: \x20   if (l < 0.0) return textureProj(sampler2D(t, s), p, b);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p.xy / p.z);\n}\n\
    // rust: vec4 hz_depthTextureProj(texture2D t, sampler s, float l, vec4 p, float b) {\n\
    // rust: \x20   if (l < 0.0) return textureProj(sampler2D(t, s), p, b);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p.xy / p.w);\n}\n\
    // rust: vec4 hz_depthTextureProjLod(texture2D t, sampler s, float l, vec3 p, float lod) {\n\
    // rust: \x20   if (l < 0.0) return textureProjLod(sampler2D(t, s), p, lod);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p.xy / p.z);\n}\n\
    // rust: vec4 hz_depthTextureProjLod(texture2D t, sampler s, float l, vec4 p, float lod) {\n\
    // rust: \x20   if (l < 0.0) return textureProjLod(sampler2D(t, s), p, lod);\n\
    // rust: \x20   return hz_depthRead(t, s, l, p.xy / p.w);\n}\n";

pub fn gather_offsets() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = String::new();
    // rust: for prefix in ["", "i", "u"] {
    // rust: let (tex, smp) = (format!("{prefix}texture2D"), format!("{prefix}sampler2D"));
    // rust: let vec = format!("{prefix}vec4");
    // rust: write!(
    // rust: p,
    // rust: "{vec} hz_gather({tex} t, sampler s, vec2 p, int c) {{\n\
    // rust: \x20   if (c == 1) return textureGather({smp}(t, s), p, 1);\n\
    // rust: \x20   if (c == 2) return textureGather({smp}(t, s), p, 2);\n\
    // rust: \x20   if (c == 3) return textureGather({smp}(t, s), p, 3);\n\
    // rust: \x20   return textureGather({smp}(t, s), p, 0);\n}}\n\
    // rust: {vec} hz_textureGatherOffsets({tex} t, sampler s, vec2 p, ivec2 o[4], int c) {{\n\
    // rust: \x20   vec2 px = 1.0 / vec2(textureSize({smp}(t, s), 0));\n\
    // rust: \x20   return {vec}(hz_gather(t, s, p + vec2(o[0]) * px, c).x, hz_gather(t, s, p + vec2(o[1]) * px, c).y,\n\
    // rust: \x20       hz_gather(t, s, p + vec2(o[2]) * px, c).z, hz_gather(t, s, p + vec2(o[3]) * px, c).w);\n}}\n\
    // rust: {vec} hz_textureGatherOffsets({tex} t, sampler s, vec2 p, ivec2 o[4]) {{\n\
    // rust: \x20   return hz_textureGatherOffsets(t, s, p, o, 0);\n}}\n"
    // rust: )
    // rust: .unwrap();
}
    // rust: p.push_str(
    // rust: "vec4 hz_textureGatherOffsets(texture2D t, samplerShadow s, vec2 p, float r, ivec2 o[4]) {\n\
    // rust: \x20   vec2 px = 1.0 / vec2(textureSize(sampler2DShadow(t, s), 0));\n\
    // rust: \x20   return vec4(textureGather(sampler2DShadow(t, s), p + vec2(o[0]) * px, r).x,\n\
    // rust: \x20       textureGather(sampler2DShadow(t, s), p + vec2(o[1]) * px, r).y,\n\
    // rust: \x20       textureGather(sampler2DShadow(t, s), p + vec2(o[2]) * px, r).z,\n\
    // rust: \x20       textureGather(sampler2DShadow(t, s), p + vec2(o[3]) * px, r).w);\n}\n",
    // rust: );
    // rust: p
}

/// `textureQueryLod` (GLSL 4.60, 8.9.1), which naga's frontend lacks: `y` is the level of
/// detail relative to the base level, worked out as texturing does (OpenGL 4.6, 8.14.1: the log2 of the
/// larger of the coordinates' texel-space changes from one pixel to the next), and `x` the level
/// that would be read, that clamped to the texture's levels. For a cube map the direction is
/// first taken to its face.
pub fn query_lod() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = String::new();
    // rust: for prefix in ["", "i", "u"] {
    // rust: for (dim, coord, texel) in [
    // rust: ("2D", "vec2", "p * vec2(textureSize({smp}(t, s), 0))"),
    // rust: (
    // rust: "2DArray",
    // rust: "vec2",
    // rust: "p * vec2(textureSize({smp}(t, s), 0).xy)",
    // rust: ),
    // rust: ("3D", "vec3", "p * vec3(textureSize({smp}(t, s), 0))"),
    // rust: (
    // rust: "Cube",
    // rust: "vec3",
    // rust: "p / max(max(abs(p.x), abs(p.y)), abs(p.z)) * 0.5 * float(textureSize({smp}(t, s), 0).x)",
    // rust: ),
    // rust: ] {
    // rust: let (tex, smp) = (
    // rust: format!("{prefix}texture{dim}"),
    // rust: format!("{prefix}sampler{dim}"),
    // rust: );
    // rust: let texel = texel.replace("{smp}", &smp);
    // rust: write!(
    // rust: p,
    // rust: "vec2 hz_textureQueryLod({tex} t, sampler s, {coord} p) {{\n\
    // rust: \x20   {coord} q = {texel};\n\
    // rust: \x20   {coord} dx = dFdx(q), dy = dFdy(q);\n\
    // rust: \x20   float lod = 0.5 * log2(max(dot(dx, dx), dot(dy, dy)));\n\
    // rust: \x20   float levels = float(textureQueryLevels({smp}(t, s)));\n\
    // rust: \x20   return vec2(clamp(lod, 0.0, levels - 1.0), lod);\n}}\n"
    // rust: )
    // rust: .unwrap();
}
}
    // rust: p
}

    // rust: pub(super) fn is_zero_literal(t: &str) -> bool {
    // rust: let t = t.trim_end_matches(['f', 'F']);
    // rust: t.contains('.') && !t.contains(['e', 'E']) && t.chars().all(|c| c == '0' || c == '.')
}

    // rust: pub(super) fn attribute_value(name: &str, ty: &str) -> String {
    // rust: match name {
    // rust: "vaPosition" => "vec3(hz_p, 0.0)".into(),
    // rust: "vaUV0" => "hz_p".into(),
    // rust: "vaColor" => "vec4(1.0)".into(),
    // rust: "vaNormal" => "vec3(0.0, 0.0, 1.0)".into(),
    // rust: _ => format!("{ty}(0)"),
}
}
