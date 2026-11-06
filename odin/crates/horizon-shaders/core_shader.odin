//! Transpiled from Horizon Rust crate
package horizon_shaders_core_shader

import "core:fmt"
import "core:mem"
import "core:math"

// Resource packs' core shaders (`shaders/core/*.vsh` and `.fsh`: the GLSL vanilla compiles for its
// pipelines) as naga modules, so a pack that reshapes text from `core/text` (a HUD its vertex
// shader moves to the screen's corners, effects in its fragment shader) draws as in vanilla.
//
// The pack's GLSL (26.3's `#include` or the older `#moj_import`, with explicit locations or
// without) is written again as the Vulkan-flavoured GLSL 450 naga reads:
// - includes are inlined, each file once (as `GlslPreprocessor` imported them), from `include`;
// - vanilla's uniform blocks get the bindings of [`BLOCKS`], and each of [`SAMPLERS`] is split
//   into a texture and a sampler object, combined again where the sampler is named;
// - the vertex inputs become globals the caller's [`Glue`] fills before the pack's `main`
//   (renamed `hz_main`) runs, and `gl_VertexID` reads the glue's expression;
// - varyings get locations by name across the stages, the fragment output location 0.

// use std::collections::HashSet;
// use std::fmt::Write;

// use naga::ShaderStage;
// use naga::front::glsl::{Frontend, Options};
// use naga::valid::{Capabilities, ValidationFlags, Validator};

// Vanilla's uniform blocks (`shaders/include/*.glsl`) and their bindings in set 0.
    // rust: pub const BLOCKS: [(&str, u32); 4] = [
    // rust: ("Globals", 0),
    // rust: ("Projection", 1),
    // rust: ("DynamicTransforms", 2),
    // rust: ("Fog", 3),
    // rust: ];

// Vanilla's samplers: the texture's binding in set 0, the sampler object's the next one.
SAMPLERS :: [("Sampler0", 4), ("Sampler1", 6), ("Sampler2", 8)]

// The first binding of the blocks and samplers vanilla has for other pipelines (OIT's behind
// `#ifdef OIT`): fine while the preprocessor drops them, an error when a stage uses one.
OTHER_BINDINGS :: 16

// What the caller's pipeline gives the pack's vertex shader.
Glue :: struct {
    // The inputs of the pipeline's vanilla vertex format: name and GLSL type.
    inputs: ^'a [(^'a str,
    // Declarations before the pack's code: the real attributes, helpers.
    prelude: ^'a str,
    // Statements before the pack's `main`: `inputs` filled from the attributes.
    setup: ^'a str,
    // Statements after it, on `gl_Position`.
    finish: ^'a str,
    // The expression `gl_VertexID` reads.
    vertex_id: ^'a str,
}

// A pipeline's two stages, validated.
CoreProgram :: struct {
    vertex: naga::Module,
    fragment: naga::Module,
}

// The shaders of one pipeline (`text.vsh`, `text.fsh`) with vanilla's `defines` for it.
// `include` answers a file id (`minecraft:shaders/include/fog.glsl`) with its text.
    // rust: pub fn translate_core(
    // rust: vertex: &str,
    // rust: fragment: &str,
    // rust: defines: &[&str],
    // rust: include: &dyn Fn(&str) -> Option<String>,
    // rust: glue: &Glue,
    // rust: ) -> Result<CoreProgram, String> {
CORE :: "minecraft:shaders/core/"
    // rust: let vertex_text = strip_comments(&expand(vertex, CORE, include)?);
    // rust: let fragment_text = strip_comments(&expand(fragment, CORE, include)?);
    // rust: let mut names = Names::default();
    // rust: let vertex_code = rewrite(&vertex_text, ShaderStage::Vertex, glue, &mut names)
    // rust: .map_err(|e| format!("vertex shader: {e}"))?;
    // rust: let fragment_code = rewrite(&fragment_text, ShaderStage::Fragment, glue, &mut names)
    // rust: .map_err(|e| format!("fragment shader: {e}"))?;
    // rust: let vertex = compile(ShaderStage::Vertex, &vertex_code, defines)
    // rust: .map_err(|e| format!("vertex shader: {e}"))?;
    // rust: let fragment = compile(ShaderStage::Fragment, &fragment_code, defines)
    // rust: .map_err(|e| format!("fragment shader: {e}"))?;
    // rust: let given = locations(&vertex, false);
    // rust: if let Some(missing) = locations(&fragment, true)
    // rust: .into_iter()
    // rust: .find(|l| !given.contains(l))
    // rust: {
    // rust: return Err(format!(
    // rust: "the fragment shader reads location {missing}, which the vertex shader doesn't write"
    // rust: ));
}
    // rust: Ok(CoreProgram { vertex, fragment })
}

// The file with its includes inlined (`#include <ns:path>`, `#include "relative"` and the same
// with `#moj_import`), each file once, `#version` and `#extension` lines dropped.
    // rust: fn expand(
    // rust: text: &str,
    // rust: dir: &str,
    // rust: include: &dyn Fn(&str) -> Option<String>,
    // rust: ) -> Result<String, String> {
    // rust: fn walk(
    // rust: text: &str,
    // rust: dir: &str,
    // rust: include: &dyn Fn(&str) -> Option<String>,
    // rust: seen: &mut HashSet<String>,
    // rust: depth: u32,
    // rust: out: &mut String,
    // rust: ) -> Result<(), String> {
    // rust: if depth > 16 {
    // rust: return Err("includes nest more than 16 deep".into());
}
    // rust: for line in text.lines() {
    // rust: let directive = line.trim_start().strip_prefix('#').map(str::trim_start);
    // rust: let target = directive.and_then(|d| {
    // rust: d.strip_prefix("include")
    // rust: .or_else(|| d.strip_prefix("moj_import"))
    // rust: .map(str::trim)
    // rust: });
    // rust: if let Some(target) = target {
    // rust: let id = include_id(target, dir).ok_or_else(|| format!("bad include {target}"))?;
    // rust: if seen.insert(id.clone()) {
    // rust: let file = include(&id).ok_or_else(|| format!("{id} not found"))?;
    // rust: let parent = &id[..id.rfind('/').map_or(id.len(), |i| i + 1)];
    // rust: walk(&file, parent, include, seen, depth + 1, out)?;
}
    // rust: out.push('\n');
    // rust: } else if directive
    // rust: .is_some_and(|d| d.starts_with("version") || d.starts_with("extension"))
    // rust: {
    // rust: out.push('\n');
    // rust: } else {
    // rust: out.push_str(line);
    // rust: out.push('\n');
}
}
    // rust: Ok(())
}
    // rust: let mut out = String::new();
    // rust: walk(text, dir, include, &mut HashSet::new(), 0, &mut out)?;
    // rust: Ok(out)
}

// `<ns:path>` under `shaders/include` (`minecraft` when there's no namespace), or `"path"` from
// the including file's folder.
include_id :: proc(target: string, dir: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(inner) = target.strip_prefix('<').and_then(|t| t.strip_suffix('>')) {
    // rust: let (ns, path) = inner.split_once(':').unwrap_or(("minecraft", inner));
    // rust: return Some(format!("{ns}:shaders/include/{path}"));
}
    // rust: let relative = target.strip_prefix('"')?.strip_suffix('"')?;
    // rust: let (ns, base) = dir.split_once(':')?;
    // rust: let mut parts: Vec<&str> = base.split('/').filter(|p| !p.is_empty()).collect();
    // rust: for part in relative.split('/') {
    // rust: match part {
    // rust: "." | "" => {}
    // rust: ".." => {
    // rust: parts.pop()?;
}
    // rust: _ => parts.push(part),
}
}
    // rust: Some(format!("{ns}:{}", parts.join("/")))
}

// Comments as spaces, line breaks kept.
strip_comments :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(text.len());
    // rust: let mut chars = text.chars().peekable();
    // rust: while let Some(c) = chars.next() {
    // rust: match (c, chars.peek()) {
    // rust: ('/', Some('/')) => {
    // rust: while chars.peek().is_some_and(|&c| c != '\n') {
    // rust: chars.next();
}
}
    // rust: ('/', Some('*')) => {
    // rust: chars.next();
    // rust: let mut last = ' ';
    // rust: for c in chars.by_ref() {
    // rust: if c == '\n' {
    // rust: out.push('\n');
}
    // rust: if last == '*' && c == '/' {
    // rust: break;
}
    // rust: last = c;
}
    // rust: out.push(' ');
}
    // rust: _ => out.push(c),
}
}
    // rust: out
}

is_ident :: proc(c: char) -> b {
    // Ported from Horizon
    return {}
}
    // rust: c.is_ascii_alphanumeric() || c == '_'
}

// `text` with each whole identifier `from` written as `to`.
replace_ident :: proc(text: string, from: string, to: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(text.len());
    // rust: let mut rest = text;
    // rust: while let Some(at) = rest.find(from) {
    // rust: let before = rest[..at].chars().next_back();
    // rust: let after = rest[at + from.len()..].chars().next();
    // rust: out.push_str(&rest[..at]);
    // rust: if before.is_some_and(is_ident) || after.is_some_and(is_ident) {
    // rust: out.push_str(from);
    // rust: } else {
    // rust: out.push_str(to);
}
    // rust: rest = &rest[at + from.len()..];
}
    // rust: out.push_str(rest);
    // rust: out
}

// A global declaration on one line: `layout(...) qualifiers storage type name;`.
Decl :: struct {
    // `layout(location = N)`'s N.
    location: Maybe(u32),
    qualifiers: [dynamic]^'a str,
    storage: ^'a str,
    ty: ^'a str,
    name: ^'a str,
}

declaration :: proc(line: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut rest = line.trim();
    // rust: let mut location = None;
    // rust: if let Some(after) = rest.strip_prefix("layout") {
    // rust: let after = after.trim_start().strip_prefix('(')?;
    // rust: let close = after.find(')')?;
    // rust: location = after[..close].split(',').find_map(|q| {
    // rust: let (key, value) = q.split_once('=')?;
    // rust: (key.trim() == "location").then(|| value.trim().parse().ok())?
    // rust: });
    // rust: rest = after[close + 1..].trim_start();
}
    // rust: let body = rest.strip_suffix(';')?.trim_end();
    // rust: let words: Vec<&str> = body.split_whitespace().collect();
    // rust: let storage_at = words
    // rust: .iter()
    // rust: .position(|w| matches!(*w, "in" | "out" | "uniform"))?;
    // rust: let [ty, name] = words[storage_at + 1..] else {
    // rust: return None;
}
    // rust: if !name.chars().all(is_ident) || !ty.chars().all(is_ident) {
    // rust: return None;
}
    // rust: Some(Decl {
    // rust: location,
    // rust: qualifiers: words[..storage_at].to_vec(),
    // rust: storage: words[storage_at],
    // rust: ty,
    // rust: name,
    // rust: })
}

// GLSL pack shaders are often minified, with several global declarations on one line.
// Keep the line-oriented rewriter simple by separating only declaration statements; ordinary
// statements and function bodies remain untouched.
declaration_lines :: proc(line: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut lines = Vec::new();
    // rust: let mut start = 0;
    // rust: while let Some(relative) = line[start..].find(';') {
    // rust: let end = start + relative + 1;
    // rust: if declaration(&line[start..end]).is_some() {
    // rust: lines.push(&line[start..end]);
    // rust: start = end;
    // rust: } else {
    // rust: break;
}
}
    // rust: if start == 0 {
    // rust: vec![line]
    // rust: } else {
    // rust: if start < line.len() {
    // rust: lines.push(&line[start..]);
}
    // rust: lines
}
}

// The block a `uniform Name {` line opens, with the line's text before `uniform`.
block_name :: proc(line: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let at = line.find("uniform")?;
    // rust: let head = line[..at].trim();
    // rust: if !(head.is_empty() || head.starts_with("layout")) {
    // rust: return None;
}
    // rust: let rest = line[at + "uniform".len()..].trim();
    // rust: let name_end = rest.find(|c: char| !is_ident(c)).unwrap_or(rest.len());
    // rust: let (name, tail) = rest.split_at(name_end);
    // rust: (!name.is_empty() && matches!(tail.trim(), "" | "{")).then_some(name)
}

// What the two stages share: the vertex stage's outputs in location order, and the names of
// the blocks and samplers of other pipelines in binding order.
Names :: struct {
    varyings: [dynamic]string,
    other: [dynamic]string,
}

    // rust: impl Names {
location :: proc(self: ^Self, varying: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.varyings
    // rust: .iter()
    // rust: .position(|v| v == varying)
    // rust: .map(|i| i as u32)
}

    // A block or sampler of another pipeline: its binding (two for a sampler).
other_binding :: proc(self: ^Self, name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let index = match self.other.iter().position(|n| n == name) {
    // rust: Some(index) => index,
    // rust: None => {
    // rust: self.other.push(name.to_owned());
    // rust: self.other.len() - 1
}
}
    // rust: OTHER_BINDINGS + 2 * index as u32
}
}

// One stage written again for naga (see the module's notes).
    // rust: fn rewrite(
    // rust: text: &str,
    // rust: stage: ShaderStage,
    // rust: glue: &Glue,
    // rust: names: &mut Names,
    // rust: ) -> Result<String, String> {
    // rust: let vertex = stage == ShaderStage::Vertex;
    // rust: let mut out = String::from("#version 450 core\n");
    // rust: if vertex {
    // rust: out.push_str(glue.prelude);
    // rust: out.push('\n');
    // rust: for (name, ty) in glue.inputs {
    // rust: writeln!(out, "{ty} {name};").unwrap();
}
}
    // rust: let mut outputs: Vec<&str> = Vec::new();
    // rust: for source_line in text.lines() {
    // rust: for line in declaration_lines(source_line) {
    // rust: if let Some(name) = block_name(line) {
    // rust: let binding = BLOCKS
    // rust: .iter()
    // rust: .find(|(block, _)| *block == name)
    // rust: .map_or_else(|| names.other_binding(name), |(_, b)| *b);
    // rust: let tail = line[line.find("uniform").unwrap_or(0)..].trim();
    // rust: writeln!(out, "layout(std140, set = 0, binding = {binding}) {tail}").unwrap();
    // rust: continue;
}
    // rust: let Some(decl) = declaration(line) else {
    // rust: out.push_str(line);
    // rust: out.push('\n');
    // rust: continue;
}
    // rust: let qualifiers = decl.qualifiers.join(" ");
    // rust: match decl.storage {
    // rust: "uniform" if decl.ty == "sampler2D" => {
    // rust: let binding = SAMPLERS
    // rust: .iter()
    // rust: .find(|(sampler, _)| *sampler == decl.name)
    // rust: .map_or_else(|| names.other_binding(decl.name), |(_, b)| *b);
    // rust: let name = decl.name;
    // rust: writeln!(
    // rust: out,
    // rust: "layout(set = 0, binding = {binding}) uniform texture2D hz_tex_{name};\n\
    // rust: layout(set = 0, binding = {}) uniform sampler hz_smp_{name};\n\
    // rust: #define {name} sampler2D(hz_tex_{name}, hz_smp_{name})",
    // rust: binding + 1
    // rust: )
    // rust: .unwrap();
}
    // rust: "uniform" => {
                    // Some packs keep the legacy standalone declarations in an `#else` branch
                    // alongside 26.x's uniform-block imports. The GLSL compiler selects the
                    // branch later, but the declaration pass sees both; the block already provides
                    // these names, so the legacy declarations must not be emitted or rejected.
    // rust: if matches!(
    // rust: decl.name,
    // rust: "CameraBlockPos"
    // rust: | "GlintAlpha"
    // rust: | "CameraOffset"
    // rust: | "GameTime"
    // rust: | "ScreenSize"
    // rust: | "MenuBlurRadius"
    // rust: | "UseRgss"
    // rust: | "ProjMat"
    // rust: | "TextureMat"
    // rust: | "ModelViewMat"
    // rust: | "ColorModulator"
    // rust: | "FogColor"
    // rust: | "FogEnvironmentalStart"
    // rust: | "FogRenderDistanceStart"
    // rust: | "FogRenderDistanceEnd"
    // rust: | "FogEnd"
    // rust: | "FogStart"
    // rust: | "FogShape"
    // rust: ) {
    // rust: out.push('\n');
    // rust: continue;
}
    // rust: return Err(format!(
    // rust: "uniform {} outside a block (26.x's shaders keep them in blocks)",
    // rust: decl.name
    // rust: ));
}
    // rust: "in" if vertex => {
    // rust: if glue.inputs.iter().any(|(name, _)| *name == decl.name) {
                        // Declared by the glue as a global.
    // rust: out.push('\n');
    // rust: } else {
                        // Another format's input (`UV2` behind `#if !defined(IS_GUI)`): the
                        // preprocessor drops it when it is for another pipeline, else it reads 0.
    // rust: writeln!(out, "{} {};", decl.ty, decl.name).unwrap();
}
}
    // rust: "out" if vertex => {
                    // One location each: naga takes scalars and vectors only.
    // rust: let location = names.location(decl.name).unwrap_or_else(|| {
    // rust: names.varyings.push(decl.name.to_owned());
    // rust: names.varyings.len() as u32 - 1
    // rust: });
    // rust: writeln!(
    // rust: out,
    // rust: "layout(location = {location}) {qualifiers} out {} {};",
    // rust: decl.ty, decl.name
    // rust: )
    // rust: .unwrap();
}
    // rust: "in" => {
    // rust: let location = names.location(decl.name).ok_or_else(|| {
    // rust: format!("input {} isn't written by the vertex shader", decl.name)
    // rust: })?;
    // rust: writeln!(
    // rust: out,
    // rust: "layout(location = {location}) {qualifiers} in {} {};",
    // rust: decl.ty, decl.name
    // rust: )
    // rust: .unwrap();
}
    // rust: _ => {
                    // Pipelines with more targets (OIT's, behind `#ifdef OIT`) name them; the
                    // colour this pipeline draws is the one at location 0.
    // rust: let location = decl.location.unwrap_or_else(|| {
    // rust: let at = outputs.iter().position(|o| *o == decl.name);
    // rust: at.unwrap_or_else(|| {
    // rust: outputs.push(decl.name);
    // rust: outputs.len() - 1
    // rust: }) as u32
    // rust: });
    // rust: writeln!(
    // rust: out,
    // rust: "layout(location = {location}) out {} {};",
    // rust: decl.ty, decl.name
    // rust: )
    // rust: .unwrap();
}
}
}
}
    // rust: if !vertex {
    // rust: return Ok(out);
}
    // rust: let mut code = replace_ident(
    // rust: &rename_main(&out),
    // rust: "gl_VertexID",
    // rust: &format!("({})", glue.vertex_id),
    // rust: );
    // rust: write!(
    // rust: code,
    // rust: "void main() {{\n{}\nhz_main();\n{}\n}}\n",
    // rust: glue.setup, glue.finish
    // rust: )
    // rust: .unwrap();
    // rust: Ok(code)
}

// `void main()` becomes `void hz_main()`.
rename_main :: proc(text: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(text.len());
    // rust: let mut rest = text;
    // rust: while let Some(at) = rest.find("main") {
    // rust: let before = rest[..at].trim_end();
    // rust: let after = rest[at + 4..].trim_start();
    // rust: let whole = !rest[..at].chars().next_back().is_some_and(is_ident)
    // rust: && !rest[at + 4..].chars().next().is_some_and(is_ident);
    // rust: out.push_str(&rest[..at]);
    // rust: if whole && after.starts_with('(') && before.ends_with("void") {
    // rust: out.push_str("hz_main");
    // rust: } else {
    // rust: out.push_str("main");
}
    // rust: rest = &rest[at + 4..];
}
    // rust: out.push_str(rest);
    // rust: out
}

// Parses and validates one stage; errors name the line of the rewritten code.
compile :: proc(stage: ShaderStage, code: string, defines: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut options = Options::from(stage);
    // rust: for define in defines {
    // rust: options.defines.insert((*define).to_owned(), String::new());
}
    // rust: let module = Frontend::default().parse(&options, code).map_err(|e| {
    // rust: e.errors
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let start = e.meta.to_range().map_or(0, |r| r.start);
    // rust: let line = code[..start.min(code.len())].matches('\n').count() + 1;
    // rust: let source = code.lines().nth(line - 1).unwrap_or("").trim();
    // rust: format!("line {line} ({source}): {}", e.kind)
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .join("; ")
    // rust: })?;
    // rust: let info = Validator::new(ValidationFlags::all(), Capabilities::all())
    // rust: .validate(&module)
    // rust: .map_err(|e| {
    // rust: let inner = e.into_inner();
    // rust: let mut message = inner.to_string();
    // rust: let mut source = std::error::Error::source(&inner);
    // rust: while let Some(s) = source {
    // rust: write!(message, ": {s}").unwrap();
    // rust: source = s.source();
}
    // rust: message
    // rust: })?;
    // rust: let entry = info.get_entry_point(0);
    // rust: for (handle, global) in module.global_variables.iter() {
    // rust: let other = global
    // rust: .binding
    // rust: .as_ref()
    // rust: .is_some_and(|b| b.binding >= OTHER_BINDINGS);
    // rust: if other && !entry[handle].is_empty() {
    // rust: let name = global.name.as_deref().unwrap_or("?");
    // rust: let name = name
    // rust: .strip_prefix("hz_tex_")
    // rust: .or_else(|| name.strip_prefix("hz_smp_"))
    // rust: .unwrap_or(name);
    // rust: return Err(format!("{name} is not a block or sampler of this pipeline"));
}
}
    // rust: Ok(module)
}

// The locations the entry point reads (`inputs`) or writes.
locations :: proc(module: ^naga::Module, inputs: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: let mut add = |ty: naga::Handle<naga::Type>, binding: Option<&naga::Binding>| {
    // rust: if let Some(naga::Binding::Location { location, .. }) = binding {
    // rust: out.push(*location);
    // rust: } else if let naga::TypeInner::Struct { members, .. } = &module.types[ty].inner {
    // rust: for m in members {
    // rust: if let Some(naga::Binding::Location { location, .. }) = &m.binding {
    // rust: out.push(*location);
}
}
}
}
    // rust: for entry in &module.entry_points {
    // rust: if inputs {
    // rust: for arg in &entry.function.arguments {
    // rust: add(arg.ty, arg.binding.as_ref());
}
    // rust: } else if let Some(result) = &entry.function.result {
    // rust: add(result.ty, result.binding.as_ref());
}
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;

    // rust: const INCLUDES: [(&str, &str); 4] = [
    // rust: (
    // rust: "minecraft:shaders/include/dynamictransforms.glsl",
    // rust: "#ifndef DT\n#define DT\nlayout(std140) uniform DynamicTransforms {\n    mat4 ModelViewMat;\n    mat4 TextureMat;\n    vec4 ColorModulator;\n    vec3 ModelOffset;\n};\n#endif\n",
    // rust: ),
    // rust: (
    // rust: "minecraft:shaders/include/projection.glsl",
    // rust: "layout(std140) uniform Projection {\n    mat4 ProjMat;\n};\n",
    // rust: ),
    // rust: (
    // rust: "minecraft:shaders/include/globals.glsl",
    // rust: "layout(std140) uniform Globals {\n    ivec3 CameraBlockPos;\n    float GlintAlpha;\n    vec3 CameraOffset;\n    float GameTime;\n    vec2 ScreenSize;\n    int MenuBlurRadius;\n    int UseRgss;\n};\n",
    // rust: ),
    // rust: (
    // rust: "minecraft:shaders/include/fog.glsl",
    // rust: "layout(std140) uniform Fog {\n    vec4 FogColor;\n    float FogEnvironmentalStart;\n};\nvec4 apply_fog(vec4 c) { return mix(c, FogColor, FogEnvironmentalStart); }\n",
    // rust: ),
    // rust: ];

include :: proc(id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: INCLUDES
    // rust: .iter()
    // rust: .find(|(path, _)| *path == id)
    // rust: .map(|(_, text)| (*text).to_owned())
}

    // rust: const GLUE: Glue = Glue {
    // rust: inputs: &[("Position", "vec3"), ("Color", "vec4"), ("UV0", "vec2")],
    // rust: prelude: "layout(location = 0) in vec2 hz_pos;\nlayout(location = 1) in vec2 hz_uv;\nlayout(location = 2) in vec4 hz_color;\n\
    // rust: const int hz_corner[6] = int[6](0, 3, 2, 0, 2, 1);\n\
    // rust: int hz_vertex_id() { int i = int(gl_VertexIndex) - int(gl_InstanceIndex); return i / 6 * 4 + hz_corner[i % 6]; }",
    // rust: setup: "Position = vec3(hz_pos, 0.0); Color = hz_color; UV0 = hz_uv;",
    // rust: finish: "gl_Position.z = 0.5 * gl_Position.w;",
    // rust: vertex_id: "hz_vertex_id()",
}

    // 26.3's `text.vsh` and `text.fsh` in shape: `#include`, explicit locations, an extension.
    // rust: const VANILLA_VSH: &str = "#version 330\n#extension GL_ARB_separate_shader_objects : require\n\
    // rust: #if !defined(IS_GUI)\n#include <minecraft:fog.glsl>\n#endif\n\
    // rust: #include <minecraft:dynamictransforms.glsl>\n#include <minecraft:projection.glsl>\n\
    // rust: layout(location = 0) in vec3 Position;\nlayout(location = 1) in vec4 Color;\nlayout(location = 2) in vec2 UV0;\n\
    // rust: layout(location = 2) out vec4 vertexColor;\nlayout(location = 3) out vec2 texCoord0;\n\
    // rust: void main() {\n    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);\n    vertexColor = Color;\n    texCoord0 = UV0;\n}\n";
    // rust: const VANILLA_FSH: &str = "#version 330\n#extension GL_ARB_separate_shader_objects : require\n\
    // rust: #include <minecraft:dynamictransforms.glsl>\n\
    // rust: uniform sampler2D Sampler0;\n\
    // rust: layout(location = 2) in vec4 vertexColor;\nlayout(location = 3) in vec2 texCoord0;\n\
    // rust: layout(location = 0) out vec4 fragColor;\n\
    // rust: void main() {\n    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;\n    if (color.a < 0.1) {\n        discard;\n    }\n    fragColor = color;\n}\n";

vanilla_26_3_text_shaders_translate :: proc() {
}
    // rust: let program =
    // rust: translate_core(VANILLA_VSH, VANILLA_FSH, &["IS_GUI"], &include, &GLUE).unwrap();
    // rust: assert_eq!(program.vertex.entry_points.len(), 1);
    // rust: assert_eq!(program.fragment.entry_points.len(), 1);
}

    // A 26.2-style pack shader as a HUD pack writes it: `#moj_import`, no locations, a flat
    // varying, `gl_VertexID`, `texelFetch` and `textureSize` on the glyph atlas, `GameTime`.
a_hud_pack_text_shader_translates :: proc() {
}
    // rust: let vsh = "#version 330\n\
    // rust: #moj_import <minecraft:dynamictransforms.glsl>\n#moj_import <minecraft:projection.glsl>\n\
    // rust: in vec3 Position;\nin vec4 Color;\nin vec2 UV0;\n\
    // rust: out vec4 vertexColor;\nout vec2 texCoord0;\n\
    // rust: #ifdef IS_GUI\n#moj_import <minecraft:globals.glsl>\nuniform sampler2D Sampler0; // the glyphs\nflat out vec4 effect;\n#endif\n\
    // rust: /* moved\n   glyphs */\n\
    // rust: void main() {\n    vec3 p = Position;\n#ifdef IS_GUI\n    int corner = gl_VertexID % 4;\n\
    // rust: ivec2 size = textureSize(Sampler0, 0);\n\
    // rust: if (ivec4(round(texelFetch(Sampler0, ivec2(UV0 * vec2(size)), 0) * 255.0)) == ivec4(177, 126, 91, 1)) {\n\
    // rust: p.x += float(corner) + ScreenSize.x * GameTime;\n    }\n    effect = vec4(float((ivec3(Color.rgb * 255.0) >> 4) == ivec3(3, 14, 10)));\n#endif\n\
    // rust: gl_Position = ProjMat * ModelViewMat * vec4(p, 1.0);\n    vertexColor = Color;\n    texCoord0 = UV0;\n}\n";
    // rust: let fsh = "#version 330\n#moj_import <minecraft:dynamictransforms.glsl>\n#moj_import <minecraft:globals.glsl>\n\
    // rust: uniform sampler2D Sampler0;\nin vec4 vertexColor;\nin vec2 texCoord0;\nflat in vec4 effect;\nout vec4 fragColor;\n\
    // rust: void main() {\n    vec4 color = texture(Sampler0, texCoord0) * vertexColor;\n    if (effect.x > 0.5) {\n        fragColor = vertexColor * ColorModulator;\n        return;\n    }\n\
    // rust: if (color.a < 0.1) {\n        discard;\n    }\n    fragColor = color * sin(GameTime);\n}\n";
    // rust: translate_core(vsh, fsh, &["IS_GUI"], &include, &GLUE).unwrap();
}

varyings_meet_at_the_same_locations :: proc() {
}
    // rust: let vsh = "#version 330\nin vec3 Position;\nout float b;\nout vec2 m;\nout vec4 a;\n\
    // rust: void main() { gl_Position = vec4(Position, 1.0); b = 1.0; m = vec2(1.0); a = vec4(b); }\n";
    // rust: let fsh = "#version 330\nin vec4 a;\nin float b;\nout vec4 fragColor;\nvoid main() { fragColor = a * b; }\n";
    // rust: let program = translate_core(vsh, fsh, &[], &include, &GLUE).unwrap();
    // rust: let mut read = locations(&program.fragment, true);
    // rust: read.sort_unstable();
    // rust: assert_eq!(read, [0, 2]);
}

minified_varying_declarations_are_rewritten :: proc() {
}
    // rust: let vsh = "#version 330\nout float sphericalVertexDistance;out float cylindricalVertexDistance;\
    // rust: void main() { sphericalVertexDistance = 0.0; cylindricalVertexDistance = 0.0; \
    // rust: gl_Position = vec4(0.0); }\n";
    // rust: let fsh = "#version 330\nin float sphericalVertexDistance;in float cylindricalVertexDistance;\
    // rust: out vec4 fragColor;void main() { fragColor = vec4(sphericalVertexDistance + cylindricalVertexDistance); }\n";
    // rust: translate_core(vsh, fsh, &[], &include, &GLUE).unwrap();
}

legacy_uniforms_next_to_modern_blocks_are_ignored :: proc() {
}
    // rust: let vsh = "#version 330\n#include <minecraft:projection.glsl>\n\
    // rust: uniform mat4 ProjMat;out vec4 vertexColor;\
    // rust: void main() { vertexColor = vec4(1.0); gl_Position = ProjMat[0]; }\n";
    // rust: let fsh = "#version 330\nin vec4 vertexColor;out vec4 fragColor;\
    // rust: void main() { fragColor = vertexColor; }\n";
    // rust: translate_core(vsh, fsh, &[], &include, &GLUE).unwrap();
}

what_horizon_does_not_provide_is_an_error :: proc() {
}
    // rust: let fsh = "#version 330\nin vec4 vertexColor;\nout vec4 fragColor;\nvoid main() { fragColor = vertexColor; }\n";
        // Another format's input is a global the shader may read: not an error.
    // rust: let normal = "#version 330\nin vec3 Normal;\nout vec4 vertexColor;\nvoid main() { vertexColor = vec4(Normal, 1.0); }\n";
    // rust: translate_core(normal, fsh, &[], &include, &GLUE).unwrap();
    // rust: let lightmap = "#version 330\nuniform sampler2D Lightmap;\nout vec4 vertexColor;\nvoid main() { vertexColor = texelFetch(Lightmap, ivec2(0), 0); }\n";
    // rust: let error = translate_core(lightmap, fsh, &[], &include, &GLUE).unwrap_err();
    // rust: assert!(
    // rust: error.contains("Lightmap is not a block or sampler"),
    // rust: "{error}"
    // rust: );
        // Behind a define the pipeline doesn't have, it is no error.
    // rust: let oit = "#version 330\n#ifdef OIT\nuniform sampler2D Coeff0;\n#endif\nout vec4 vertexColor;\n\
    // rust: void main() {\n#ifdef OIT\n    vertexColor = texelFetch(Coeff0, ivec2(0), 0);\n#endif\n}\n";
    // rust: translate_core(oit, fsh, &[], &include, &GLUE).unwrap();
    // rust: let missing = "#version 330\n#moj_import <minecraft:nothing.glsl>\nvoid main() {}\n";
    // rust: let error = translate_core(missing, fsh, &[], &include, &GLUE).unwrap_err();
    // rust: assert!(
    // rust: error.contains("minecraft:shaders/include/nothing.glsl not found"),
    // rust: "{error}"
    // rust: );
}

includes_resolve_by_id_or_from_the_including_folder :: proc() {
}
    // rust: assert_eq!(
    // rust: include_id("<fog.glsl>", "minecraft:shaders/core/").as_deref(),
    // rust: Some("minecraft:shaders/include/fog.glsl")
    // rust: );
    // rust: assert_eq!(
    // rust: include_id("<bitmade:hud/lanes.glsl>", "minecraft:shaders/core/").as_deref(),
    // rust: Some("bitmade:shaders/include/hud/lanes.glsl")
    // rust: );
    // rust: assert_eq!(
    // rust: include_id("\"../include/fog.glsl\"", "minecraft:shaders/core/").as_deref(),
    // rust: Some("minecraft:shaders/include/fog.glsl")
    // rust: );
}
}
