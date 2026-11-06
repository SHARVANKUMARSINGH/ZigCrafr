//! Transpiled from Horizon Rust crate
//! Module: horizon-shaders_scan
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The first pass over a stage's tokens: what it declares at global scope, which of its
//! functions take samplers, which outputs and built-ins it uses.

// use std::collections::{BTreeSet, HashMap};
// use std::fmt::Write;

// use naga::ShaderStage;

// use super::Error;
// use super::rewrite::{attribute_value, is_zero_literal};
// use crate::Preprocessed;
// use crate::macros::lex;

/// A varying: its name and its declaration with `@` where the name goes (`flat ivec2 @[2];`).
    // rust: pub(super) struct Var {
    // rust: pub(super) name: String,
    // rust: pub(super) decl: String,
    /// Of a struct type: the pack's declaration stays as a private global, and the members
    /// travel in varyings of ours (`struct_parts`).
    // rust: pub(super) structure: bool,
}

/// `layout(rgba16f) uniform writeonly image2D colorimg4;`
    // rust: pub(super) struct ImageDecl {
    // rust: pub(super) name: String,
    // rust: pub(super) ty: String,
    // rust: pub(super) format: String,
    /// `readonly`, `writeonly` or empty (both).
    // rust: pub(super) access: String,
    /// Declared `coherent` or `volatile`: invocations of a dispatch share it as it changes.
    // rust: pub(super) coherent: bool,
}

    // rust: pub(super) struct Stage<'p> {
    // rust: pub(super) kind: ShaderStage,
    // rust: pub(super) pp: &'p Preprocessed,
    // rust: pub(super) tokens: Vec<&'p str>,
    /// Token ranges to blank out (declarations moved into the header).
    // rust: pub(super) removed: Vec<std::ops::Range<usize>>,
    /// Name, type with its array suffix, token of the type.
    // rust: pub(super) uniforms: Vec<(String, String, usize)>,
    // rust: pub(super) samplers: Vec<(String, String)>,
    /// Uniform names with constant initializers retained as compiler constants.
    // rust: pub(super) defaults: Vec<(String, usize)>,
    // rust: pub(super) images: Vec<ImageDecl>,
    /// The bindings of the SSBOs (`buffer` blocks), in set 4.
    // rust: pub(super) buffers: BTreeSet<u32>,
    // rust: pub(super) ins: Vec<Var>,
    // rust: pub(super) outs: Vec<Var>,
    /// Vertex inputs, now private globals, and the value our `main` gives each.
    /// Vertex inputs: name, our composite value, type.
    // rust: pub(super) attributes: Vec<(String, String, String)>,
    /// A gbuffers-style program: the matrices are the frame's, not the quad's.
    // rust: pub(super) gbuffers: bool,
    /// The pack's fragment outputs, declared again with their locations.
    // rust: pub(super) frag_outs: Vec<(u32, String)>,
    /// Narrow outputs copied into their vec4 after the pack's `main`.
    // rust: pub(super) out_copies: Vec<String>,
    /// Locations whose `hz_outN` is ours, filled from the pack's outputs: its vector type and
    /// the components written so far (a bit each).
    // rust: pub(super) wide_outs: HashMap<u32, (&'static str, u8)>,
    /// The stage calls `inverse`, which ours replaces, and doesn't define its own.
    // rust: pub(super) inverse: bool,
    /// The stage calls `textureGatherOffsets`, which naga lacks: ours is in the prelude.
    // rust: pub(super) gather_offsets: bool,
    /// The stage calls `textureQueryLod`, which naga lacks: ours is in the prelude.
    // rust: pub(super) query_lod: bool,
    /// The stage calls `dot` / `normalize` and defines neither: the scalar overloads GLSL has
    /// (`dot(float, float)`, `normalize(float)`) and naga lacks go in the prelude.
    // rust: pub(super) scalar_dot: bool,
    // rust: pub(super) scalar_normalize: bool,
    /// `min3`, `max3` and `mid3` the stage calls with GL_AMD_shader_trinary_minmax enabled and
    /// doesn't define itself: naga lacks them, so ours are in the prelude.
    // rust: pub(super) trinary: Vec<&'p str>,
    /// The pack's functions that take samplers: which parameters are samplers.
    // rust: pub(super) sampler_functions: HashMap<String, Vec<bool>>,
    /// The pack's structs: each member's type and name with its array suffix.
    // rust: pub(super) structs: HashMap<String, Vec<(String, String)>>,
    // rust: pub(super) outputs: BTreeSet<u32>,
    // rust: pub(super) frag_coord: bool,
    /// Tokens written differently, by index.
    // rust: pub(super) replaced: HashMap<usize, String>,
    /// Globals whose initializer runs in our `main` (`g = hz_init_g();`), in order.
    // rust: pub(super) inits: Vec<String>,
    /// Authored global names; automatic core matrix inputs must not hide them.
    // rust: pub(super) globals: BTreeSet<String>,
    /// Their captured array size constants and declarator ends: `.length()` stays type-only.
    // rust: pub(super) runtime_array_lengths: HashMap<String, (String, usize)>,
    // rust: pub(super) errors: Vec<Error>,
}

/// The format qualifiers of images (GLSL 4.60, 4.4.6.2).
    // rust: const IMAGE_FORMATS: [&str; 39] = [
    // rust: "rgba32f",
    // rust: "rgba16f",
    // rust: "rg32f",
    // rust: "rg16f",
    // rust: "r11f_g11f_b10f",
    // rust: "r32f",
    // rust: "r16f",
    // rust: "rgba16",
    // rust: "rgb10_a2",
    // rust: "rgba8",
    // rust: "rg16",
    // rust: "rg8",
    // rust: "r16",
    // rust: "r8",
    // rust: "rgba16_snorm",
    // rust: "rgba8_snorm",
    // rust: "rg16_snorm",
    // rust: "rg8_snorm",
    // rust: "r16_snorm",
    // rust: "r8_snorm",
    // rust: "rgba32i",
    // rust: "rgba16i",
    // rust: "rgba8i",
    // rust: "rg32i",
    // rust: "rg16i",
    // rust: "rg8i",
    // rust: "r32i",
    // rust: "r16i",
    // rust: "r8i",
    // rust: "rgba32ui",
    // rust: "rgba16ui",
    // rust: "rgb10_a2ui",
    // rust: "rgba8ui",
    // rust: "rg32ui",
    // rust: "rg16ui",
    // rust: "rg8ui",
    // rust: "r32ui",
    // rust: "r16ui",
    // rust: "r8ui",
    // rust: ];

    // rust: pub(super) const STORAGE: [&str; 5] = ["uniform", "in", "out", "attribute", "varying"];
    // rust: pub(super) const QUALIFIERS: [&str; 11] = [
    // rust: "flat",
    // rust: "smooth",
    // rust: "noperspective",
    // rust: "centroid",
    // rust: "invariant",
    // rust: "highp",
    // rust: "mediump",
    // rust: "lowp",
    // rust: "precise",
    // rust: "sample",
    // rust: "const",
    // rust: ];
/// The compatibility profile's uniform state (with its `Inverse`/`Transpose` forms).
    // rust: pub(super) const UNIFORM_STATE: [&str; 5] = [
    // rust: "gl_ModelViewMatrix",
    // rust: "gl_ProjectionMatrix",
    // rust: "gl_ModelViewProjectionMatrix",
    // rust: "gl_NormalMatrix",
    // rust: "gl_TextureMatrix",
    // rust: ];
/// The compatibility profile's vertex inputs.
    // rust: pub(super) const VERTEX_INPUTS: [&str; 6] = [
    // rust: "gl_Vertex",
    // rust: "gl_Color",
    // rust: "gl_SecondaryColor",
    // rust: "gl_Normal",
    // rust: "gl_FogCoord",
    // rust: "gl_MultiTexCoord",
    // rust: ];
/// Built-in functions naga's constant evaluator lacks: a `const` that calls one is evaluated
/// where the program runs instead (GL drivers fold them; naga fails the program).
    // rust: pub(super) const NOT_CONSTANT: [&str; 25] = [
    // rust: "mix",
    // rust: "smoothstep",
    // rust: "reflect",
    // rust: "refract",
    // rust: "faceforward",
    // rust: "transpose",
    // rust: "determinant",
    // rust: "inverse",
    // rust: "outerProduct",
    // rust: "matrixCompMult",
    // rust: "modf",
    // rust: "frexp",
    // rust: "ldexp",
    // rust: "packUnorm2x16",
    // rust: "packSnorm2x16",
    // rust: "packUnorm4x8",
    // rust: "packSnorm4x8",
    // rust: "packHalf2x16",
    // rust: "unpackUnorm2x16",
    // rust: "unpackSnorm2x16",
    // rust: "unpackUnorm4x8",
    // rust: "unpackSnorm4x8",
    // rust: "unpackHalf2x16",
    // rust: "bitfieldExtract",
    // rust: "bitfieldInsert",
    // rust: ];
/// Words that became keywords after GLSL 1.x and that old packs use as names.
    // rust: pub(super) const LATER_KEYWORDS: [&str; 17] = [
    // rust: "sample",
    // rust: "buffer",
    // rust: "shared",
    // rust: "filter",
    // rust: "input",
    // rust: "output",
    // rust: "common",
    // rust: "partition",
    // rust: "active",
    // rust: "resource",
    // rust: "patch",
    // rust: "subroutine",
    // rust: "coherent",
    // rust: "volatile",
    // rust: "restrict",
    // rust: "readonly",
    // rust: "writeonly",
    // rust: ];

/// Vulkan GLSL's texture and sampler types, which naga's frontend reads as types, renamed.
    // rust: const VULKAN_TYPES: [(&str, &str); 9] = [
    // rust: ("sampler", "hz_kw_sampler"),
    // rust: ("samplerShadow", "hz_kw_samplerShadow"),
    // rust: ("texture1D", "hz_kw_texture1D"),
    // rust: ("texture2D", "hz_kw_texture2D"),
    // rust: ("texture3D", "hz_kw_texture3D"),
    // rust: ("textureCube", "hz_kw_textureCube"),
    // rust: ("texture2DArray", "hz_kw_texture2DArray"),
    // rust: ("texture2DMS", "hz_kw_texture2DMS"),
    // rust: ("textureCubeArray", "hz_kw_textureCubeArray"),
    // rust: ];

    // rust: pub(super) fn significant(t: &str) -> bool {
    // rust: !t.trim().is_empty()
}

/// A fragment output narrower than four components: the vec4 of its kind, and the components
/// that fill it (alpha 1).
pub fn widened(ty: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match ty {
    // rust: "float" => ("vec4", ", 0.0, 0.0, 1.0"),
    // rust: "vec2" => ("vec4", ", 0.0, 1.0"),
    // rust: "vec3" => ("vec4", ", 1.0"),
    // rust: "int" => ("ivec4", ", 0, 0, 1"),
    // rust: "ivec2" => ("ivec4", ", 0, 1"),
    // rust: "ivec3" => ("ivec4", ", 1"),
    // rust: "uint" => ("uvec4", ", 0u, 0u, 1u"),
    // rust: "uvec2" => ("uvec4", ", 0u, 1u"),
    // rust: "uvec3" => ("uvec4", ", 1u"),
    // rust: _ => return None,
    // rust: })
}

/// A scalar or vector fragment output's vec4 of its kind, its width, and the value the
/// components no output writes start from (alpha 1, as `widened` fills them).
pub fn output_kind(ty: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (wide, fill) = match ty.trim_end_matches(['2', '3', '4']) {
    // rust: "float" | "vec" => ("vec4", "vec4(0.0, 0.0, 0.0, 1.0)"),
    // rust: "int" | "ivec" => ("ivec4", "ivec4(0, 0, 0, 1)"),
    // rust: "uint" | "uvec" => ("uvec4", "uvec4(0u, 0u, 0u, 1u)"),
    // rust: _ => return None,
}
    // rust: let width = match ty.as_bytes().last() {
    // rust: Some(&n @ b'2'..=b'4') if ty.contains("vec") => (n - b'0') as usize,
    // rust: _ if ty.contains("vec") => return None,
    // rust: _ => 1,
}
    // rust: Some((wide, width, fill))
}

/// `sampler2D`, `isampler3D`, `usampler2D`, `sampler2DShadow`...
    // rust: pub(super) fn is_sampler_type(t: &str) -> bool {
    // rust: t.trim_start_matches(['i', 'u']).starts_with("sampler")
}

    // rust: pub(super) fn is_ident(t: &str) -> bool {
    // rust: t.starts_with(|c: char| c.is_ascii_alphabetic() || c == '_')
}

pub fn outer_array_length(ty: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let open = ty.find('[')?;
    // rust: let mut depth = 0;
    // rust: for (offset, c) in ty[open..].char_indices() {
    // rust: match c {
    // rust: '[' => depth += 1,
    // rust: ']' => {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: return Some(&ty[open + 1..open + offset]);
}
}
    // rust: _ => {}
}
}
    // rust: None
}

/// Synthesized return types need the same dimension reversal as source type tokens.
pub fn reversed_array_dimensions(ty: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(open) = ty.find('[') else {
    // rust: return ty.to_owned();
}
    // rust: let mut tail = &ty[open..];
    // rust: let mut dimensions = Vec::new();
    // rust: while !tail.is_empty() {
    // rust: let Some(length) = outer_array_length(tail).filter(|_| tail.starts_with('[')) else {
    // rust: return ty.to_owned();
}
    // rust: let end = length.len() + 2;
    // rust: dimensions.push(&tail[..end]);
    // rust: tail = &tail[end..];
}
    // rust: let mut result = ty[..open].to_owned();
    // rust: for dimension in dimensions.into_iter().rev() {
    // rust: result.push_str(dimension);
}
    // rust: result
}

    // rust: impl<'p> Stage<'p> {
    // rust: pub(super) fn scan(pp: &'p Preprocessed, kind: ShaderStage) -> Self {
    // rust: let mut s = Stage {
    // rust: kind,
    // rust: pp,
    // rust: tokens: lex(&pp.code),
    // rust: removed: Vec::new(),
    // rust: uniforms: Vec::new(),
    // rust: defaults: Vec::new(),
    // rust: samplers: Vec::new(),
    // rust: images: Vec::new(),
    // rust: buffers: BTreeSet::new(),
    // rust: ins: Vec::new(),
    // rust: outs: Vec::new(),
    // rust: attributes: Vec::new(),
    // rust: frag_outs: Vec::new(),
    // rust: out_copies: Vec::new(),
    // rust: wide_outs: HashMap::new(),
    // rust: inverse: false,
    // rust: gather_offsets: false,
    // rust: query_lod: false,
    // rust: scalar_dot: false,
    // rust: scalar_normalize: false,
    // rust: trinary: Vec::new(),
    // rust: sampler_functions: HashMap::new(),
    // rust: structs: HashMap::new(),
    // rust: outputs: BTreeSet::new(),
    // rust: frag_coord: false,
    // rust: gbuffers: false,
    // rust: replaced: HashMap::new(),
    // rust: inits: Vec::new(),
    // rust: globals: BTreeSet::new(),
    // rust: runtime_array_lengths: HashMap::new(),
    // rust: errors: Vec::new(),
}
    // rust: s.rename_vulkan_types();
    // rust: let (mut start, mut depth, mut parens) = (0, 0usize, 0usize);
    // rust: let mut own_inverse = false;
    // rust: let (mut own_dot, mut own_normalize) = (false, false);
    // rust: let mut own_trinary = Vec::new();
    // rust: let trinary_enabled = pp.extensions.iter().any(|e| {
    // rust: e.split_once(':').is_some_and(|(name, behavior)| {
    // rust: name.trim() == "GL_AMD_shader_trinary_minmax" && behavior.trim() != "disable"
    // rust: })
    // rust: });
    // rust: for i in 0..s.tokens.len() {
    // rust: match s.tokens[i] {
    // rust: "(" => parens += 1,
    // rust: ")" => parens = parens.saturating_sub(1),
    // rust: "{" if depth == 0 && parens == 0 => {
    // rust: s.global(start, i, true);
    // rust: s.structure(start, i);
    // rust: depth = 1;
}
    // rust: "{" => depth += 1,
    // rust: "}" if depth > 0 => {
    // rust: depth -= 1;
    // rust: if depth == 0 {
    // rust: start = i + 1;
}
}
    // rust: ";" if depth == 0 && parens == 0 => {
    // rust: s.global(start, i, false);
    // rust: start = i + 1;
}
    // rust: "gl_FragData" | "gl_FragColor" if kind == ShaderStage::Fragment => {
    // rust: let n = if s.tokens[i] == "gl_FragColor" {
    // rust: Some(0)
    // rust: } else {
    // rust: s.index_after(i).map(|(n, _)| n)
}
    // rust: match n {
    // rust: Some(n) => _ = s.outputs.insert(n),
    // rust: None => s
    // rust: .errors
    // rust: .push(s.error(i, "`gl_FragData` needs a constant index")),
}
}
    // rust: "gl_FragCoord" => s.frag_coord = true,
    // rust: "textureGatherOffsets" => s.gather_offsets = true,
    // rust: "textureQueryLod" => s.query_lod = true,
    // rust: "dot" | "normalize" => {
                    // A definition at the top level: `float dot(float a, ...)`.
    // rust: let defines = depth == 0
    // rust: && s.tokens[..i]
    // rust: .iter()
    // rust: .rfind(|t| significant(t))
    // rust: .is_some_and(|t| is_ident(t));
    // rust: if s.tokens[i] == "dot" {
    // rust: s.scalar_dot = true;
    // rust: own_dot |= defines;
    // rust: } else {
    // rust: s.scalar_normalize = true;
    // rust: own_normalize |= defines;
}
}
    // rust: name @ ("min3" | "max3" | "mid3") if trinary_enabled => {
    // rust: if !s.trinary.contains(&name) {
    // rust: s.trinary.push(name);
}
                    // A definition at the top level: `float max3(float a, ...)`.
    // rust: if depth == 0
    // rust: && s.tokens[..i]
    // rust: .iter()
    // rust: .rfind(|t| significant(t))
    // rust: .is_some_and(|t| is_ident(t))
    // rust: {
    // rust: own_trinary.push(name);
}
}
    // rust: "inverse" => {
    // rust: s.inverse = true;
                    // `mat4 inverse(mat4 m)`: a pack for GLSL 1.20, which has none, wrote its own.
    // rust: own_inverse |= depth == 0
    // rust: && s.tokens[..i]
    // rust: .iter()
    // rust: .rfind(|t| significant(t))
    // rust: .is_some_and(|t| is_ident(t));
}
    // rust: "gl_TexCoord" => {
    // rust: if let Some((n, _)) = s.index_after(i) {
    // rust: s.builtin_varying(format!("hz_TexCoord{n}"), "vec4");
}
}
    // rust: "gl_FrontColor" => s.builtin_varying("hz_FrontColor".into(), "vec4"),
    // rust: "gl_Color" if kind == ShaderStage::Fragment => {
    // rust: s.builtin_varying("hz_FrontColor".into(), "vec4")
}
    // rust: "gl_FogFragCoord" => s.builtin_varying("hz_FogFragCoord".into(), "float"),
    // rust: _ => {}
}
}
    // rust: s.inverse &= !own_inverse;
    // rust: s.scalar_dot &= !own_dot;
    // rust: s.scalar_normalize &= !own_normalize;
    // rust: s.trinary.retain(|name| !own_trinary.contains(name));
    // rust: if s.gather_offsets {
            // Its sampler is passed as a texture and a sampler, as to the pack's own functions.
    // rust: s.sampler_functions
    // rust: .entry("textureGatherOffsets".into())
    // rust: .or_insert_with(|| vec![true, false, false, false, false]);
}
    // rust: if s.query_lod {
    // rust: s.sampler_functions
    // rust: .entry("textureQueryLod".into())
    // rust: .or_insert_with(|| vec![true, false]);
}
    // rust: s
}

    /// Names that desktop GLSL leaves free but Vulkan GLSL takes for its separate texture and
    /// sampler types (`sampler2D sampler`): renamed, unless called (`texture2D(...)`).
pub fn rename_vulkan_types(self: *Self) void {
}
    // rust: for i in 0..self.tokens.len() {
    // rust: let Some(&(_, renamed)) = VULKAN_TYPES.iter().find(|(t, _)| *t == self.tokens[i])
    // rust: else {
    // rust: continue;
}
    // rust: let called = self.tokens[i + 1..]
    // rust: .iter()
    // rust: .find(|t| significant(t))
    // rust: .is_some_and(|&t| t == "(");
    // rust: if !called {
    // rust: self.tokens[i] = renamed;
}
}
}

    /// A built-in varying (`gl_TexCoord[n]`, `gl_FrontColor`, `gl_FogFragCoord`) of type `ty`: an
    /// output of a vertex stage, an input of a fragment stage.
    // rust: pub(super) fn builtin_varying(&mut self, name: String, ty: &str) {
    // rust: let list = if self.kind == ShaderStage::Vertex {
    // rust: &mut self.outs
    // rust: } else {
    // rust: &mut self.ins
}
    // rust: if !list.iter().any(|v| v.name == name) {
    // rust: list.push(Var {
    // rust: name,
    // rust: decl: format!("{ty} @;"),
    // rust: structure: false,
    // rust: });
}
}

    /// `[ n ]` right after token `i`: the number and the index of the `]`.
    // rust: pub(super) fn index_after(&self, i: usize) -> Option<(u32, usize)> {
    // rust: let mut it = (i + 1..self.tokens.len()).filter(|&j| significant(self.tokens[j]));
    // rust: let open = it.next()?;
    // rust: let n = it.next()?;
    // rust: let close = it.next()?;
    // rust: (self.tokens[open] == "[" && self.tokens[close] == "]")
    // rust: .then(|| self.tokens[n].parse().ok().map(|n| (n, close)))
    // rust: .flatten()
}

    // rust: pub(super) fn error(&self, token: usize, message: &str) -> Error {
    // rust: let line: usize = self.tokens[..token.min(self.tokens.len())]
    // rust: .iter()
    // rust: .map(|t| t.matches('\n').count())
    // rust: .sum();
    // rust: let o = self.pp.lines.get(line).copied().unwrap_or_default();
    // rust: Error {
    // rust: file: self
    // rust: .pp
    // rust: .files
    // rust: .get(o.file as usize)
    // rust: .cloned()
    // rust: .unwrap_or_default(),
    // rust: line: o.line,
    // rust: message: message.to_owned(),
}
}

    /// Core names share the compatibility state for geometry, including shadow transforms.
    /// Authored non-uniform globals (or uniforms of another type) keep their own meaning.
    /// `normalMatrix` is the core profile's only (ShaderDoc's `gl_NormalMatrix`, as #9136 quotes
    /// it): in a compatibility-profile stage it stays a uniform of the frame, read as zero.
    /// `textureMatrix` is `gl_TextureMatrix[0]` in the vertex stage only: our probes read the
    /// identity in Iris 1.11.7's terrain and shadow vertex stages, and zero in the terrain
    /// fragment stage (#9080).
    // rust: pub(super) fn core_matrix(&self, name: &str) -> Option<&'static str> {
    // rust: let (matrix, ty) = match name {
    // rust: "projectionMatrix" => ("hz_ProjectionMatrix", "mat4"),
    // rust: "modelViewMatrix" => ("hz_ModelViewMatrix", "mat4"),
    // rust: "normalMatrix" if self.core_profile() => ("hz_NormalMatrix", "mat3"),
    // rust: "textureMatrix" if self.kind == ShaderStage::Vertex => ("hz_TextureMatrix[0]", "mat4"),
    // rust: _ => return None,
}
    // rust: if !self.gbuffers
    // rust: || (self.globals.contains(name)
    // rust: && !self.uniforms.iter().any(|(n, t, _)| n == name && t == ty))
    // rust: {
    // rust: return None;
}
    // rust: Some(matrix)
}

    /// The stage is in the core profile: a `#version` of 150 or later that doesn't name the
    /// compatibility profile. A fit of our #9136 probe's Iris 1.11.7 pictures (`normalMatrix` set
    /// at `330 core`, `330` and `150`, zero at `330 compatibility`), not Iris's rule. Below 150 is
    /// unmeasured (Iris drew no geometry for the `140` probe) and stays as before.
pub fn core_profile(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(&self.pp.version, Some((version, profile))
    // rust: if *version >= 150 && profile.as_deref() != Some("compatibility"))
}

    /// Remember names without interpreting their values. Commas inside constructors and array
    /// suffixes do not introduce another declarator, nor do references in an initializer.
pub fn global_names(self: *Self, words: *[usize], mut type_at: usize) void {
}
    // rust: while words
    // rust: .get(type_at)
    // rust: .is_some_and(|&i| self.tokens[i] == "const" || QUALIFIERS.contains(&self.tokens[i]))
    // rust: {
    // rust: type_at += 1;
}
    // rust: let (mut depth, mut name) = (0i32, true);
    // rust: for &i in words.iter().skip(type_at + 1) {
    // rust: let token = self.tokens[i];
    // rust: if depth == 0 && name && is_ident(token) {
    // rust: self.globals.insert(token.to_owned());
    // rust: name = false;
}
    // rust: match token {
    // rust: "(" | "[" | "{" => depth += 1,
    // rust: ")" | "]" | "}" => depth -= 1,
    // rust: "," if depth == 0 => name = true,
    // rust: _ => {}
}
}
}

    /// A statement at global scope, tokens `from..to` (without its `;`, or before a `{`).
    // rust: pub(super) fn global(&mut self, from: usize, to: usize, body: bool) {
    // rust: let words: Vec<usize> = (from..to)
    // rust: .filter(|&i| significant(self.tokens[i]))
    // rust: .collect();
        // A prototype: a `(` before any `=`, and no storage qualifier.
    // rust: let paren = words
    // rust: .iter()
    // rust: .position(|&i| matches!(self.tokens[i], "(" | "="));
    // rust: let prototype = paren.is_some_and(|p| self.tokens[words[p]] == "(")
    // rust: && !words.iter().any(|&i| STORAGE.contains(&self.tokens[i]));
    // rust: if body && words.iter().any(|&i| self.tokens[i] == "buffer") {
    // rust: return self.buffer_block(&words);
}
    // rust: if body || prototype {
    // rust: return self.function(&words);
}
    // rust: let mut k = 0;
    // rust: let mut storage = None;
    // rust: let mut location = None;
    // rust: let mut component = None;
    // rust: let mut format = None;
    // rust: let mut access = "";
    // rust: let mut coherent = false;
    // rust: let mut interpolation = String::new();
    // rust: while let Some(&i) = words.get(k) {
    // rust: let w = self.tokens[i];
    // rust: if w == "layout" {
                // layout(location = n, ...), an image's layout(rgba16f)
    // rust: let mut j = k + 1;
    // rust: while let Some(&t) = words.get(j) {
    // rust: j += 1;
    // rust: match self.tokens[t] {
    // rust: "location" => {
    // rust: location = words
    // rust: .get(j + 1)
    // rust: .and_then(|&n| self.tokens[n].parse::<u32>().ok());
}
    // rust: "component" => {
    // rust: component = words
    // rust: .get(j + 1)
    // rust: .and_then(|&n| self.tokens[n].parse::<usize>().ok());
}
    // rust: f if IMAGE_FORMATS.contains(&f) => format = Some(f),
    // rust: ")" => break,
    // rust: _ => {}
}
}
    // rust: k = j;
    // rust: continue;
}
    // rust: if STORAGE.contains(&w) {
    // rust: storage = Some(w);
    // rust: } else if matches!(w, "readonly" | "writeonly") {
    // rust: access = w;
    // rust: } else if QUALIFIERS.contains(&w) || matches!(w, "coherent" | "volatile" | "restrict") {
    // rust: coherent |= matches!(w, "coherent" | "volatile");
    // rust: if matches!(
    // rust: w,
    // rust: "flat" | "smooth" | "noperspective" | "centroid" | "sample"
    // rust: ) {
    // rust: write!(interpolation, "{w} ").unwrap();
}
    // rust: } else {
    // rust: break;
}
    // rust: k += 1;
}
        // `centroid` and `sample` choose where a varying is interpolated; a `flat` one is not
        // interpolated, so GLSL (4.60, 4.5) lets them stand beside it and means nothing by
        // them. naga rejects the pair: `flat` alone says all there is.
    // rust: if interpolation.split_whitespace().any(|w| w == "flat") {
    // rust: interpolation = "flat ".to_owned();
}
    // rust: self.global_names(&words, k);
    // rust: let Some(storage) = storage else {
    // rust: return self.initializer(&words, to);
}
    // rust: let Some(&ty_at) = words.get(k) else { return };
    // rust: let ty = self.tokens[ty_at].to_owned();
    // rust: if words[k..].iter().any(|&i| self.tokens[i] == "{") {
    // rust: return; // An interface block: left as the pack wrote it.
}
        // Declarators: name [array] [= init], separated by commas.
    // rust: let mut declarators: Vec<(String, String)> = Vec::new();
    // rust: let mut defaults = String::new();
    // rust: let mut j = k + 1;
    // rust: while let Some(&n) = words.get(j) {
    // rust: let name = self.tokens[n].to_owned();
    // rust: let mut array = String::new();
    // rust: j += 1;
    // rust: let mut nesting = 0;
    // rust: while let Some(&t) = words.get(j) {
    // rust: match self.tokens[t] {
    // rust: "," if nesting == 0 => break,
    // rust: "(" | "[" => nesting += 1,
    // rust: ")" | "]" => nesting -= 1,
    // rust: _ => {}
}
    // rust: if self.tokens[t] == "=" && nesting == 0 {
    // rust: let start = j + 1;
    // rust: j += 1;
    // rust: let mut depth = 0;
    // rust: while let Some(&token) = words.get(j) {
    // rust: match self.tokens[token] {
    // rust: "," if depth == 0 => break,
    // rust: "(" | "[" => depth += 1,
    // rust: ")" | "]" => depth -= 1,
    // rust: _ => {}
}
    // rust: j += 1;
}
    // rust: if storage == "uniform" && !is_sampler_type(&ty) && !ty.contains("image") {
    // rust: let value = words[start..j]
    // rust: .iter()
    // rust: .map(|&i| self.tokens[i])
    // rust: .collect::<Vec<_>>()
    // rust: .join(" ");
    // rust: write!(defaults, "const {ty} hz_default_{name}{array} = {value}; ")
    // rust: .unwrap();
    // rust: self.defaults.push((name.clone(), n));
}
    // rust: break;
}
    // rust: array.push_str(self.tokens[t]);
    // rust: j += 1;
}
    // rust: j += 1;
    // rust: declarators.push((name, array));
}
    // rust: let fragment = self.kind == ShaderStage::Fragment;
    // rust: let input = matches!(storage, "in" | "attribute") || (storage == "varying" && fragment);
    // rust: self.removed.push(from..to + 1);
    // rust: if !defaults.is_empty() {
    // rust: self.replaced.insert(words[0], defaults);
}
    // rust: for (name, array) in declarators {
    // rust: let decl = format!("{interpolation}{ty} @{array};");
    // rust: match storage {
    // rust: "uniform" if is_sampler_type(&ty) => self.samplers.push((name, ty.clone())),
    // rust: "uniform" if ty.contains("image") => match format {
    // rust: Some(format) => self.images.push(ImageDecl {
    // rust: name,
    // rust: ty: ty.clone(),
    // rust: format: format.to_owned(),
    // rust: access: access.to_owned(),
    // rust: coherent,
    // rust: }),
    // rust: None => self
    // rust: .errors
    // rust: .push(self.error(ty_at, &format!("`{name}`: an image needs a format"))),
    // rust: },
    // rust: "uniform" => self.uniforms.push((name, format!("{ty}{array}"), ty_at)),
    // rust: _ if input && !fragment => {
    // rust: let value = attribute_value(&name, &ty);
    // rust: self.attributes.push((name, value, ty.clone()));
    // rust: self.removed.pop();
                    // A private global of ours now: `in`/`attribute` and qualifiers go.
    // rust: for &w in &words[..k] {
    // rust: self.removed.push(w..w + 1);
}
}
    // rust: _ if self.structs.contains_key(&ty) => {
    // rust: self.removed.pop();
    // rust: for &w in &words[..k] {
    // rust: self.removed.push(w..w + 1);
}
    // rust: let var = Var {
    // rust: name,
    // rust: decl,
    // rust: structure: true,
}
    // rust: if input {
    // rust: self.ins.push(var);
    // rust: } else {
    // rust: self.outs.push(var);
}
}
    // rust: _ if input => self.ins.push(Var {
    // rust: name,
    // rust: decl,
    // rust: structure: false,
    // rust: }),
    // rust: _ if fragment => {
    // rust: let n = location.unwrap_or(self.outputs.len() as u32);
    // rust: let shared = self.wide_outs.contains_key(&n);
    // rust: if component.is_some_and(|c| c > 0) || shared {
    // rust: self.output_part(n, component.unwrap_or(0), &ty, &name, &array, ty_at);
    // rust: continue;
}
    // rust: self.outputs.insert(n);
                    // wgpu wants every component of the target's format written; GL fills
                    // what a narrower output leaves out. Ours is a vec4, theirs a private global.
    // rust: match widened(&ty).filter(|_| array.is_empty()) {
    // rust: Some((wide, fill)) => {
    // rust: self.frag_outs.push((
    // rust: n,
    // rust: format!(
    // rust: "layout(location = {n}) out {wide} hz_out{n}; {ty} {name};"
    // rust: ),
    // rust: ));
    // rust: self.out_copies
    // rust: .push(format!("hz_out{n} = {wide}({name}{fill});"));
    // rust: let width = output_kind(&ty).map_or(4, |(_, width, _)| width);
    // rust: self.wide_outs.insert(n, (wide, (1 << width) - 1));
}
    // rust: None => self
    // rust: .frag_outs
    // rust: .push((n, format!("layout(location = {n}) out {ty} {name}{array};"))),
}
}
    // rust: _ => self.outs.push(Var {
    // rust: name,
    // rust: decl,
    // rust: structure: false,
    // rust: }),
}
}
}

    /// A fragment output with a `component` offset, or one sharing its location with another
    /// (GLSL 4.60, 4.4.2): it fills components `component..` of the location's vector. Ours is
    /// that vector, the pack's a private global copied into its components after `main`.
    // rust: fn output_part(
    // rust: &mut self,
    // rust: n: u32,
    // rust: component: usize,
    // rust: ty: &str,
    // rust: name: &str,
    // rust: array: &str,
    // rust: ty_at: usize,
    // rust: ) {
    // rust: let kind = output_kind(ty).filter(|_| array.is_empty());
    // rust: let Some((wide, width, fill)) = kind.filter(|&(_, width, _)| component + width <= 4) else {
    // rust: let message = format!(
    // rust: "`{name}`: a `{ty}{array}` output at component {component} is not supported"
    // rust: );
    // rust: return self.errors.push(self.error(ty_at, &message));
}
    // rust: let mask = ((1u8 << width) - 1) << component;
    // rust: match self.wide_outs.get_mut(&n) {
    // rust: Some((other, _)) if *other != wide => {
    // rust: let message =
    // rust: format!("`{name}`: a `{ty}` output beside a `{other}` at location {n}");
    // rust: return self.errors.push(self.error(ty_at, &message));
}
    // rust: Some((_, written)) if *written & mask != 0 => {
    // rust: let message = format!("`{name}`: components of location {n} written twice");
    // rust: return self.errors.push(self.error(ty_at, &message));
}
    // rust: Some((_, written)) => {
    // rust: *written |= mask;
    // rust: self.frag_outs.push((n, format!("{ty} {name};")));
}
    // rust: None => {
    // rust: self.wide_outs.insert(n, (wide, mask));
    // rust: self.outputs.insert(n);
    // rust: self.frag_outs.push((
    // rust: n,
    // rust: format!("layout(location = {n}) out {wide} hz_out{n}; {ty} {name};"),
    // rust: ));
    // rust: self.out_copies.push(format!("hz_out{n} = {fill};"));
}
}
    // rust: let swizzle = &"xyzw"[component..component + width];
    // rust: self.out_copies
    // rust: .push(format!("hz_out{n}.{swizzle} = {name};"));
}

    /// A global `T name = a ? b : c;` or, without `const`, any initialized global: naga only
    /// evaluates constant initializers at global scope (a conditional is not one; GL drivers
    /// also take uniforms and other globals there), so each initializer becomes a function of
    /// ours on the same line (`T a; T hz_init_a() { return T(...); } T b; ...`), called by our
    /// `main` before the pack's, in file order. The return converts as GLSL's initialization
    /// does (`vec2 v = ivec2(...)`).
    // rust: pub(super) fn initializer(&mut self, words: &[usize], to: usize) {
    // rust: let text = |i: usize| self.tokens[i];
    // rust: let Some(eq) = words.iter().position(|&i| text(i) == "=") else {
    // rust: return;
}
        // Declarators, split at top-level commas: (first word, `=` if any, end).
    // rust: let mut declarators = Vec::new();
    // rust: let (mut begin, mut nesting, mut assign) = (0, 0i32, None);
    // rust: for (n, &i) in words.iter().enumerate() {
    // rust: match text(i) {
    // rust: "(" | "[" | "{" => nesting += 1,
    // rust: ")" | "]" | "}" => nesting -= 1,
    // rust: "=" if nesting == 0 && assign.is_none() => assign = Some(n),
    // rust: "," if nesting == 0 => {
    // rust: declarators.push((begin, assign.take(), n));
    // rust: begin = n + 1;
}
    // rust: _ => {}
}
}
    // rust: declarators.push((begin, assign, words.len()));
    // rust: let constant = words[..eq].iter().any(|&i| text(i) == "const");
        // The first declarator's name ends the type.
    // rust: let first_end = declarators[0].1.unwrap_or(declarators[0].2);
    // rust: let mut brackets = 0usize;
    // rust: let Some(name_at) = words[..first_end].iter().rposition(|&i| match text(i) {
    // rust: "]" => {
    // rust: brackets += 1;
    // rust: false
}
    // rust: "[" => {
    // rust: brackets = brackets.saturating_sub(1);
    // rust: false
}
    // rust: t => brackets == 0 && is_ident(t),
    // rust: }) else {
    // rust: return;
}
        // The zero-division rewrite reads hz_zero, so even a literal-only expression must run
        // at invocation time. Its value is unspecified in GLSL; keep the existing arithmetic
        // policy rather than inventing a finite replacement. Later dependent constants must
        // run after it, while unrelated constants (including comma declarators) stay constant.
    // rust: let mut runtime_names: BTreeSet<&str> = self.inits.iter().map(String::as_str).collect();
    // rust: let runtime: Vec<bool> = declarators
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(n, &(begin, assign, end))| {
    // rust: let run = assign.is_some_and(|a| {
    // rust: !constant
    // rust: || (a + 1..end).any(|n| {
    // rust: let t = text(words[n]);
    // rust: let next = words.get(n + 1).map(|&i| text(i));
    // rust: t == "?"
    // rust: || (NOT_CONSTANT.contains(&t) && next == Some("("))
    // rust: || (t == "/" && next.is_some_and(is_zero_literal))
    // rust: || (runtime_names.contains(t)
    // rust: && text(words[n - 1]) != "."
    // rust: && next != Some("(")
                                    // A sized array's length depends on its type, not its values.
    // rust: && ![".", "length", "(", ")"].iter().enumerate().all(
    // rust: |(offset, &t)| {
    // rust: words.get(n + offset + 1).is_some_and(|&i| text(i) == t)
    // rust: },
    // rust: ))
    // rust: })
    // rust: });
    // rust: if run {
    // rust: runtime_names.insert(text(words[if n == 0 { name_at } else { begin }]));
}
    // rust: run
    // rust: })
    // rust: .collect();
    // rust: if !runtime.iter().any(|&run| run) {
    // rust: return;
}
        // The type, with a `vec3[]`'s count written in.
    // rust: let mut ty = String::new();
    // rust: for &i in &words[..name_at] {
    // rust: match text(i) {
    // rust: "const" => {}
    // rust: "]" if ty.ends_with('[') => match self.array_length(i) {
    // rust: Some(n) => write!(ty, "{n}]").unwrap(),
    // rust: None => return,
    // rust: },
                // `T[6]`: the size and its `]` belong to the type.
    // rust: t if ty.is_empty() || t == "[" || ty.contains('[') && !ty.ends_with(']') => {
    // rust: ty.push_str(t)
}
                // Qualifiers before the type (`highp`...): the type is the last word.
    // rust: t => ty = t.to_owned(),
}
}
    // rust: if ty.is_empty() {
    // rust: return;
}
    // rust: let mut replaced = Vec::new();
    // rust: let mut names = Vec::new();
    // rust: for (n, &(begin, assign, end)) in declarators.iter().enumerate() {
    // rust: let name_at = if n == 0 { name_at } else { begin };
    // rust: let name = text(words[name_at]).to_owned();
    // rust: if !is_ident(&name) {
    // rust: return;
}
    // rust: let stop = assign.unwrap_or(end);
    // rust: let mut array: String = words[name_at + 1..stop].iter().map(|&i| text(i)).collect();
    // rust: if array == "[]" {
                // `T x[] = T[](a, b)`: the count is written in, as the rewrite does for the name.
    // rust: match assign.and_then(|a| self.array_length(words[a - 1])) {
    // rust: Some(n) => array = format!("[{n}]"),
    // rust: None => return,
}
}
    // rust: let next = if n + 1 < declarators.len() {
    // rust: let qualifier = if constant && !runtime[n + 1] {
    // rust: "const "
    // rust: } else {
    // rust: ""
}
    // rust: format!(" {qualifier}{ty}")
    // rust: } else {
    // rust: String::new()
}
    // rust: let end_token = words.get(end).copied().unwrap_or(to);
    // rust: match assign {
    // rust: Some(a) if runtime[n] => {
    // rust: let dimensions = if array.is_empty() { &ty } else { &array };
    // rust: let capture = if let Some(length) = outer_array_length(dimensions) {
                        // Bind the size in declaration scope: a use site's local `count` must
                        // not change the length of a global declared with `[count]`.
    // rust: let mut bound = format!("hz_array_length_{name}");
    // rust: while self.tokens.contains(&bound.as_str())
    // rust: || self
    // rust: .runtime_array_lengths
    // rust: .values()
    // rust: .any(|(n, _)| n == &bound)
    // rust: {
    // rust: bound.push('_');
}
    // rust: self.runtime_array_lengths
    // rust: .insert(name.clone(), (bound.clone(), end_token));
    // rust: format!(" const int {bound} = int({length});")
    // rust: } else {
    // rust: String::new()
}
                    // Scalars, vectors and matrices convert; arrays and structs must match.
    // rust: let scalar = array.is_empty()
    // rust: && !ty.contains('[')
    // rust: && (matches!(ty.as_str(), "float" | "int" | "uint" | "bool")
    // rust: || ty.contains("vec")
    // rust: || ty.starts_with("mat"));
    // rust: let (open, close) = if scalar {
    // rust: (format!("{ty}("), ")")
    // rust: } else {
    // rust: (String::new(), "")
}
    // rust: let return_ty = format!(
    // rust: "{}{}",
    // rust: reversed_array_dimensions(&ty),
    // rust: reversed_array_dimensions(&array),
    // rust: );
    // rust: replaced.push((
    // rust: words[a],
    // rust: format!(";{capture} {return_ty} hz_init_{name}() {{ return {open}"),
    // rust: ));
    // rust: replaced.push((end_token, format!("{close}; }}{next}")));
    // rust: names.push(name);
}
    // rust: _ if n + 1 < declarators.len() => replaced.push((end_token, format!(";{next}"))),
    // rust: _ => {}
}
}
    // rust: for &i in &words[..name_at] {
    // rust: if runtime[0] && text(i) == "const" {
    // rust: self.removed.push(i..i + 1);
}
}
    // rust: self.replaced.extend(replaced);
    // rust: self.inits.extend(names);
}

    /// `layout(std430, binding = n) buffer Name {`: an SSBO, in set 4 at its binding. Its
    /// access qualifiers go, so that every stage binds it alike (read and write).
pub fn buffer_block(self: *Self, words: *[usize]) void {
}
    // rust: let mut binding = None;
    // rust: for (k, &i) in words.iter().enumerate() {
    // rust: match self.tokens[i] {
                // An extension adds real buffer syntax even in a GLSL 1.x stage.
                // It must not take the legacy identifier rename for `buffer`.
    // rust: "buffer" => {
    // rust: self.replaced.insert(i, "buffer".into());
}
    // rust: "binding" => {
    // rust: binding = words
    // rust: .get(k + 2)
    // rust: .and_then(|&n| self.tokens[n].parse::<u32>().ok());
    // rust: self.replaced.insert(i, "set = 4, binding".into());
}
    // rust: "readonly" | "writeonly" | "restrict" | "coherent" | "volatile" => {
    // rust: self.removed.push(i..i + 1)
}
    // rust: _ => {}
}
}
    // rust: match binding {
    // rust: Some(b) => _ = self.buffers.insert(b),
    // rust: None => {
    // rust: let at = words.first().copied().unwrap_or(0);
    // rust: self.errors
    // rust: .push(self.error(at, "a buffer block needs a binding"));
}
}
}

    /// `struct Name {` at token `open`, whose words start at `from`: its members, to `}`.
pub fn structure(self: *Self, from: usize, open: usize) void {
}
    // rust: let words: Vec<&str> = self.tokens[from..open]
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|t| significant(t))
    // rust: .collect();
    // rust: let [.., "struct", name] = words[..] else {
    // rust: return;
}
    // rust: let mut members = Vec::new();
    // rust: let mut decl: Vec<&str> = Vec::new();
    // rust: for &t in &self.tokens[open + 1..] {
    // rust: match t {
    // rust: "}" => break,
    // rust: ";" => {
                    // `T a, b[2]`, after any precision or other qualifier.
    // rust: let words: Vec<&str> =
    // rust: decl.drain(..).filter(|w| !QUALIFIERS.contains(w)).collect();
    // rust: let Some((ty, rest)) = words.split_first() else {
    // rust: continue;
}
    // rust: for d in rest.split(|w| *w == ",") {
    // rust: if let Some((n, array)) = d.split_first() {
    // rust: members.push((ty.to_string(), format!("{n}{}", array.concat())));
}
}
}
    // rust: t if significant(t) => decl.push(t),
    // rust: _ => {}
}
}
    // rust: self.structs.insert(name.to_owned(), members);
}

    /// A function definition or prototype: remember which parameters are samplers.
    // rust: pub(super) fn function(&mut self, words: &[usize]) {
    // rust: let Some(open) = words.iter().position(|&i| self.tokens[i] == "(") else {
    // rust: return;
}
    // rust: let Some(&name) = open.checked_sub(1).and_then(|n| words.get(n)) else {
    // rust: return;
}
    // rust: self.globals.insert(self.tokens[name].to_owned());
    // rust: let mut params = Vec::new();
    // rust: let mut is_sampler = false;
    // rust: for &i in &words[open + 1..] {
    // rust: match self.tokens[i] {
    // rust: "," | ")" => {
    // rust: params.push(is_sampler);
    // rust: is_sampler = false;
}
    // rust: t if is_sampler_type(t) => is_sampler = true,
    // rust: _ => {}
}
}
    // rust: if params.iter().any(|&p| p) {
    // rust: self.sampler_functions
    // rust: .insert(self.tokens[name].to_owned(), params);
}
}
}
