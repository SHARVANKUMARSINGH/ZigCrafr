//! Transpiled from Horizon Rust crate
package horizon_client_render_post_glsl

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla's post-processing GLSL (`#version 330` with `layout(std140)` uniform blocks
// and `uniform sampler2D`s, Vulkan-style `gl_VertexIndex`) turned into naga modules at
// run time, from whichever resource root is active, the way Horizon's shader packs turn
// their GLSL into naga (`horizon-shaders`' translator, which handles the compatibility
// dialect; the post shaders need only the block and sampler binding rewrite below).
//
// `ShaderManager`/`GlslPreprocessor` read `assets/<ns>/shaders/<path>.{vsh,fsh}` and
// resolve `#include <ns:path>` to `assets/<ns>/shaders/include/<path>`.
//
// The rewrite gives every uniform block a binding of bind group 0, shared by both
// stages, and splits each `uniform sampler2D NameSampler;` into a texture and a sampler
// object at the next two bindings, `NameSampler` becoming the combined
// `sampler2D(texture, sampler)` again where it is used. The vertex stage's `main` is
// wrapped so that clip y is negated: targets keep GL's rows (row 0 is the bottom edge),
// so `texCoord` reads the texel it would in vanilla.
// use naga::ShaderStage;
// use naga::front::glsl::{Frontend, Options};
// use naga::valid::{Capabilities, ValidationFlags, Validator};
// use std::path::Path;

// One program, ready for wgpu.
Program :: struct {
    vertex: naga::Module,
    fragment: naga::Module,
    // Every uniform block either stage declares, with its binding.
    blocks: Vec<(string,
    // Every sampler (`NameSampler`): the texture's binding; the sampler object is the next.
    samplers: Vec<(string,
}

is_ident :: proc(c: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: c.is_ascii_alphanumeric() || c == b'_'
}

// The source with its comments blanked (same length, so offsets stay valid).
blank_comments :: proc(src: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let b = src.as_bytes();
    // rust: let mut out = b.to_vec();
    // rust: let mut i = 0;
    // rust: while i < b.len() {
    // rust: if b[i] == b'/' && b.get(i + 1) == Some(&b'/') {
    // rust: while i < b.len() && b[i] != b'\n' {
    // rust: out[i] = b' ';
    // rust: i += 1;
}
    // rust: } else if b[i] == b'/' && b.get(i + 1) == Some(&b'*') {
    // rust: while i < b.len() && !(b[i] == b'*' && b.get(i + 1) == Some(&b'/')) {
    // rust: if b[i] != b'\n' {
    // rust: out[i] = b' ';
}
    // rust: i += 1;
}
    // rust: for slot in out.iter_mut().take((i + 2).min(b.len())).skip(i) {
    // rust: *slot = b' ';
}
    // rust: i += 2;
    // rust: } else {
    // rust: i += 1;
}
}
    // rust: String::from_utf8(out).unwrap_or_default()
}

// `GlslPreprocessor`'s `#include <ns:path>`.
read_source :: proc(root: ^Path, id: string, ext: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: let file = root
    // rust: .join("assets")
    // rust: .join(ns)
    // rust: .join("shaders")
    // rust: .join(format!("{path}.{ext}"));
    // rust: std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))
}

include :: proc(root: ^Path, src: string, depth: u32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if depth > 8 {
    // rust: return Err("#include nested too deep".into());
}
    // rust: let mut out = String::new();
    // rust: for line in src.lines() {
    // rust: let t = line.trim_start();
    // rust: if let Some(rest) = t.strip_prefix("#include") {
    // rust: let name = rest
    // rust: .trim()
    // rust: .trim_start_matches(['<', '"'])
    // rust: .trim_end_matches(['>', '"'])
    // rust: .trim();
    // rust: let (ns, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let file = root
    // rust: .join("assets")
    // rust: .join(ns)
    // rust: .join("shaders")
    // rust: .join("include")
    // rust: .join(path);
    // rust: let text = std::fs::read_to_string(&file)
    // rust: .map_err(|e| format!("#include <{name}>: {}: {e}", file.display()))?;
    // rust: out.push_str(&include(root, &text, depth + 1)?);
    // rust: } else if t.starts_with("#version") || t.starts_with("#extension") {
            // Re-added below, for the translator.
    // rust: out.push('\n');
    // rust: continue;
    // rust: } else {
    // rust: out.push_str(line);
}
    // rust: out.push('\n');
}
    // rust: Ok(out)
}

// Every `uniform` declaration of a source: (start of the declaration including a
// `layout(...)` before it, end of the type or of the whole `;`, type, name, is a sampler).
declarations :: proc(src: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let plain = blank_comments(src);
    // rust: let b = plain.as_bytes();
    // rust: let mut out = Vec::new();
    // rust: let mut at = 0;
    // rust: while let Some(found) = plain[at..].find("uniform") {
    // rust: let start = at + found;
    // rust: at = start + 7;
    // rust: if (start > 0 && is_ident(b[start - 1])) || b.get(start + 7).is_some_and(|c| is_ident(*c)) {
    // rust: continue;
}
    // rust: let word = |from: usize| -> Option<(usize, usize)> {
    // rust: let mut s = from;
    // rust: while s < b.len() && b[s].is_ascii_whitespace() {
    // rust: s += 1;
}
    // rust: let mut e = s;
    // rust: while e < b.len() && is_ident(b[e]) {
    // rust: e += 1;
}
    // rust: (e > s).then_some((s, e))
}
    // rust: let Some((ts, te)) = word(start + 7) else {
    // rust: continue;
}
    // rust: let ty = plain[ts..te].to_owned();
        // The `layout(...)` right before `uniform`, if any.
    // rust: let before = plain[..start].trim_end();
    // rust: let decl_start = before
    // rust: .ends_with(')')
    // rust: .then(|| before.rfind("layout"))
    // rust: .flatten()
    // rust: .filter(|l| {
    // rust: before[*l + 6..].trim_start().starts_with('(') && !before[*l..].contains(';')
    // rust: })
    // rust: .unwrap_or(start);
    // rust: if ty.starts_with("sampler") {
    // rust: let Some((ns, ne)) = word(te) else { continue };
    // rust: let end = plain[ne..].find(';').map_or(ne, |p| ne + p + 1);
    // rust: out.push((decl_start, end, ty, plain[ns..ne].to_owned(), true));
    // rust: } else {
    // rust: let mut s = te;
    // rust: while s < b.len() && b[s].is_ascii_whitespace() {
    // rust: s += 1;
}
    // rust: if b.get(s) == Some(&b'{') {
    // rust: out.push((decl_start, te, String::new(), ty, false));
}
}
}
    // rust: out
}

// The source with each declaration given its binding from the shared tables.
rewrite :: proc(src: string, blocks: ^[(string) {
}
    // rust: let mut out = String::new();
    // rust: let mut pos = 0;
    // rust: for (start, end, ty, name, sampler) in declarations(src) {
    // rust: out.push_str(&src[pos..start]);
    // rust: pos = end;
    // rust: if sampler {
    // rust: let tex = samplers.iter().find(|(n, _)| *n == name).map_or(0, |s| s.1);
    // rust: let kind = if ty == "sampler2D" { "texture2D" } else { &ty };
    // rust: out.push_str(&format!(
    // rust: "layout(set = 0, binding = {tex}) uniform {kind} {name}_hz_tex; \
    // rust: layout(set = 0, binding = {}) uniform sampler {name}_hz_smp;\n\
    // rust: #define {name} sampler2D({name}_hz_tex, {name}_hz_smp)\n",
    // rust: tex + 1
    // rust: ));
    // rust: } else {
    // rust: let binding = blocks.iter().find(|(n, _)| *n == name).map_or(0, |s| s.1);
    // rust: out.push_str(&format!(
    // rust: "layout(std140, set = 0, binding = {binding}) uniform {name}"
    // rust: ));
}
}
    // rust: out.push_str(&src[pos..]);
    // rust: out
}

// Replaces the word `main` of `void main(` with `hz_main`.
wrap_main :: proc(src: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let plain = blank_comments(src);
    // rust: let mut at = 0;
    // rust: while let Some(found) = plain[at..].find("main") {
    // rust: let p = at + found;
    // rust: at = p + 4;
    // rust: let b = plain.as_bytes();
    // rust: if (p > 0 && is_ident(b[p - 1])) || b.get(p + 4).is_some_and(|c| is_ident(*c)) {
    // rust: continue;
}
    // rust: if plain[..p].trim_end().ends_with("void") && plain[p + 4..].trim_start().starts_with('(') {
    // rust: let mut out = String::with_capacity(src.len() + 80);
    // rust: out.push_str(&src[..p]);
    // rust: out.push_str("hz_main");
    // rust: out.push_str(&src[p + 4..]);
    // rust: out.push_str("\nvoid main() { hz_main(); gl_Position.y = -gl_Position.y; }\n");
    // rust: return Ok(out);
}
}
    // rust: Err("no main".into())
}

parse :: proc(stage: ShaderStage, text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let module = Frontend::default()
    // rust: .parse(&Options::from(stage), text)
    // rust: .map_err(|e| {
    // rust: e.errors
    // rust: .iter()
    // rust: .map(|e| e.kind.to_string())
    // rust: .collect::<Vec<_>>()
    // rust: .join("; ")
    // rust: })?;
    // rust: Validator::new(ValidationFlags::all(), Capabilities::empty())
    // rust: .validate(&module)
    // rust: .map_err(|e| format!("{:?}", e.into_inner()))?;
    // rust: Ok(module)
}

// Translates the vertex and fragment shader a pass names (`minecraft:post/invert`).
translate :: proc(root: ^Path, vertex: string, fragment: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let vs = include(root, &read_source(root, vertex, "vsh")?, 0)?;
    // rust: let fs = include(root, &read_source(root, fragment, "fsh")?, 0)?;
    // Blocks and samplers are shared by name across the stages, so both agree on a binding.
    // rust: let mut blocks: Vec<(String, u32)> = Vec::new();
    // rust: let mut names: Vec<String> = Vec::new();
    // rust: for src in [&vs, &fs] {
    // rust: for (_, _, _, name, sampler) in declarations(src) {
    // rust: if sampler {
    // rust: if !names.contains(&name) {
    // rust: names.push(name);
}
    // rust: } else if !blocks.iter().any(|(n, _)| *n == name) {
    // rust: blocks.push((name, blocks.len() as u32));
}
}
}
    // rust: let first = blocks.len() as u32;
    // rust: let samplers: Vec<(String, u32)> = names.into_iter().zip((first..).step_by(2)).collect();
    // rust: let vs = wrap_main(&rewrite(&vs, &blocks, &samplers))?;
    // rust: let fs = rewrite(&fs, &blocks, &samplers);
    // rust: let vertex_module = parse(ShaderStage::Vertex, &format!("#version 450\n{vs}"))
    // rust: .map_err(|e| format!("{vertex}: {e}"))?;
    // rust: let fragment_module = parse(ShaderStage::Fragment, &format!("#version 450\n{fs}"))
    // rust: .map_err(|e| format!("{fragment}: {e}"))?;
    // rust: Ok(Program {
    // rust: vertex: vertex_module,
    // rust: fragment: fragment_module,
    // rust: blocks,
    // rust: samplers,
    // rust: })
}

    // rust: mod tests {
//     use super::*;

root :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let dir = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .ancestors()
    // rust: .nth(2)?
    // rust: .join(".local/horizon-client/26.3");
    // rust: dir.join("assets/minecraft/shaders/post/blit.fsh")
    // rust: .exists()
    // rust: .then_some(dir)
}

vanilla_post_shaders_translate :: proc() {
}
    // rust: let Some(root) = root() else { return };
    // rust: let vs = ["minecraft:core/screenquad", "minecraft:post/rotscale"];
    // rust: let fs = [
    // rust: "bits",
    // rust: "blit",
    // rust: "box_blur",
    // rust: "color_convolve",
    // rust: "entity_outline_box_blur",
    // rust: "entity_sobel",
    // rust: "invert",
    // rust: "spiderclip",
    // rust: ];
    // rust: for f in fs {
    // rust: for v in vs {
    // rust: let name = format!("minecraft:post/{f}");
    // rust: let p = translate(&root, v, &name);
                // rotscale's outputs only match spiderclip, but each stage translates alone.
    // rust: if let Err(e) = &p {
    // rust: panic!("{v} + {name}: {e}");
}
}
}
}

sampler_and_block_bindings :: proc() {
}
    // rust: let src = "layout(std140) uniform A {\n float x;\n};\nuniform sampler2D InSampler; // c\nvoid main(){}\n";
    // rust: let d = declarations(src);
    // rust: assert_eq!(d.len(), 2);
    // rust: let out = rewrite(src, &[("A".into(), 0)], &[("InSampler".into(), 1)]);
    // rust: assert!(out.contains("layout(std140, set = 0, binding = 0) uniform A {"));
    // rust: assert!(out.contains("binding = 1) uniform texture2D InSampler_hz_tex;"));
    // rust: assert!(out.contains("binding = 2) uniform sampler InSampler_hz_smp;"));
    // rust: assert!(wrap_main("void main() {}").unwrap().contains("hz_main"));
}
}
