//! Transpiled from Horizon Rust crate
//! Module: horizon-shader-api_reference
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! docs/api/shaders-reference.md (0.1) and shaders-reference-0.2.md, generated from the stages
//! and inputs this crate defines (`tests/reference.rs` fails when a file drifts).
// use crate::check::{MAX_EXPRESSIONS, MAX_TEXTURE_READS};
// use crate::inputs::{DISPLACEMENT_INPUT, Frame, SURFACE, Struct};
// use crate::manifest::{Api, MAX_GPU_MS, MAX_OPTIONS, MAX_POST_PASSES};
// use crate::package::{MAX_TOTAL, MAX_WGSL};
// use crate::stages::{GROUP, StageKind};

pub fn table(s: *Struct, offsets: ?*[usize]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = format!("### `{}`\n\n{}\n\n", s.name, one_line(s.doc));
    // rust: out += if offsets.is_some() {
    // rust: "| Field | Type | Offset | Meaning |\n| --- | --- | --- | --- |\n"
    // rust: } else {
    // rust: "| Field | Type | Meaning |\n| --- | --- | --- |\n"
}
    // rust: for (i, f) in s.fields.iter().enumerate() {
    // rust: let offset = offsets.map_or(String::new(), |o| format!(" {} |", o[i]));
    // rust: out += &format!(
    // rust: "| `{}` | `{}` |{offset} {} |\n",
    // rust: f.name,
    // rust: f.ty,
    // rust: one_line(f.doc)
    // rust: );
}
    // rust: out + "\n"
}

pub fn one_line(doc: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: doc.split_whitespace().collect::<Vec<_>>().join(" ")
}

/// Where the line's reference lives, from the repository's root.
pub fn path(api: Api) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match api {
    // rust: Api::V0_1 => "docs/api/shaders-reference.md",
    // rust: Api::V0_2 => "docs/api/shaders-reference-0.2.md",
}
}

/// 0.2's rules, after the introduction.
    // rust: const RULES_0_2: &str = "\
    // rust: **Experimental** ([stability.md](stability.md)): `horizon-shader check` takes 0.2 packs, but the game refuses them
    // rust: for now and the registry doesn't list them, and anything here may change in any release. The design:
    // rust: [hdr-linear-light.md](../design/hdr-linear-light.md).

    // rust: ## Colour

    // rust: Every colour a 0.2 stage reads or returns is **linear light**: BT.709 (sRGB) primaries, scene-referred, 1.0 is
    // rust: vanilla's white at paper white, more is brighter. Horizon decodes vanilla's values with a 2.2 power (vanilla's, not
    // rust: the piecewise sRGB curve), replacing negatives and NaN with 0 first, and encodes a stage's result the same way where
    // rust: the frame stores gamma (`[frame] blend`, below).

    // rust: - **Linear:** `MaterialInput` `albedo`, `tint`, `lightmap` and `colored_light`; `VertexInput.tint`; `SkyInput.color`;
    // rust: `WeatherInput.color`; `Frame` `sky_color` and `fog_color`; `block_texture`, `block_texture_level` and
    // rust: `block_light_color`; every colour texture a stage samples (`scene_color`, `previous`, `history`, the pack's targets,
    // rust: `opaque_color`, `reflection`, `shadow_color`).
    // rust: - **Data, as in 0.1:** depth, normals, `light` levels, `emission`, every channel of the LabPBR maps, and the pack's
    // rust: `[[textures]]`.
    // rust: - **`[[lights]]` and `[[particle_lights]]` colours** are written as in 0.1, in vanilla's gamma, and Horizon decodes
    // rust: them: `block_light_color` and `colored_light` are linear. `block_light_colors` holds them as written; read it through
    // rust: `block_light_color`.
    // rust: - **Alpha is coverage only.** A post pass's alpha is ignored.

    // rust: ## The display

    // rust: `frame.hdr`, `headroom`, `paper_white`, `peak` and `black_level` describe the display. Until HDR output is served for
    // rust: 0.2 packs (a later step), a 0.2 pack sees SDR values with HDR on too: `hdr` 0, `headroom` 1, `paper_white` and `peak`
    // rust: 80, `black_level` 0, and its picture is shown at paper white with nothing lifted.

    // rust: ## `[frame] blend`

    // rust: `blend = \"gamma\"` (the default) keeps the frame in vanilla's gamma, values above 1 kept: Horizon encodes the material,
    // rust: sky and weather stages' results before they are stored and blended, so glass, water, clouds and particles blend as
    // rust: vanilla's. `blend = \"linear\"` stores linear light, so see-through draws blend as light does. A stage sees the same
    // rust: values either way. `\"linear\"` passes the check; the game doesn't serve it yet.

    // rust: ";

/// The line's reference.
pub fn markdown(api: Api) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = format!(
    // rust: "# Shader API reference ({api})\n\n\
    // rust: Generated from `crates/horizon-shader-api` (`HORIZON_WRITE_DOCS=1 cargo test -p horizon-shader-api --test reference`\n\
    // rust: rewrites it; the test fails when it drifts). The API's design and pack format: [shaders.md](shaders.md).\n\n"
    // rust: );
    // rust: if api == Api::V0_2 {
    // rust: out += RULES_0_2;
}
    // rust: out += "A stage is a function your WGSL defines, with the signature below; Horizon puts the prelude (these structs, the\n\
    // rust: resources and helpers) before your files and calls the function from its own pass. Your files declare no\n\
    // rust: bindings and no entry points, and no names starting with `horizon_`.\n\n\
    // rust: ## Stages\n\n\
    // rust: | Stage | In `horizon-shaders.toml` | Your function |\n| --- | --- | --- |\n";
    // rust: for &kind in api.stages() {
    // rust: let key = match kind {
    // rust: StageKind::Post => "[[post]]",
    // rust: StageKind::Sky => "[sky]",
    // rust: StageKind::Material => "[material]",
    // rust: StageKind::Vertex => "[vertex]",
    // rust: StageKind::Weather => "[weather]",
    // rust: StageKind::Tonemap => "[tonemap]",
}
    // rust: out += &format!("| {} | `{key}` | `{}` |\n", kind.name(), kind.signature());
}
    // rust: out += "\n";
    // rust: for &kind in api.stages() {
    // rust: out += &format!("## {}\n\n`{}`\n\n", kind.name(), kind.signature());
    // rust: out += &table(kind.input(), None);
    // rust: if kind == StageKind::Material {
    // rust: let surface = table(&SURFACE, None);
            // 0.2's lit colour is linear light and may pass white; 0.1's reference keeps its text.
    // rust: out += &match api {
    // rust: Api::V0_1 => surface,
    // rust: Api::V0_2 => surface.replace(
    // rust: "The lit colour, 0..1, with its alpha.",
    // rust: "The lit colour, linear light (more than 1 is brighter than white), with its alpha.",
    // rust: ),
}
    // rust: out += "Under `[displacement]` the stage also defines \
    // rust: `fn displacement(input: DisplacementInput) -> f32`, called for each corner of the grid the \
    // rust: faces near the camera are cut into; the corner moves along the face's normal by the depth it \
    // rust: gives at the point's height less the depth at the texture's mean height, pinned at the face's \
    // rust: edges and easing out over the last quarter of the distance.\n\n";
    // rust: out += &table(&DISPLACEMENT_INPUT, None);
}
    // rust: out += &format!(
    // rust: "Resources (bind group {GROUP}):\n\n| Binding | Declaration | Meaning |\n| --- | --- | --- |\n"
    // rust: );
    // rust: for r in kind.resources() {
    // rust: out += &format!("| {} | `{}` | {} |\n", r.binding, r.ty, r.doc);
}
    // rust: out += "\n";
    // rust: if kind == StageKind::Tonemap {
    // rust: out += "It runs once per pixel at the window's size, after the post chain and before the camera overlays and\n\
    // rust: the HUD. A pack without it gets Horizon's: a clip at white in SDR, a roll-off into the headroom in HDR.\n\
    // rust: Horizon holds the result to 0 to `frame.headroom`.\n\n";
    // rust: continue;
}
    // rust: if kind != StageKind::Sky {
    // rust: out += "Helpers:\n\n";
}
    // rust: if kind == StageKind::Post {
    // rust: out += "- `fn depth_at(uv: vec2<f32>) -> f32`: the world's depth at `uv`.\n\
    // rust: - `fn view_position(uv: vec2<f32>, depth: f32) -> vec3<f32>`: the camera-relative position, in blocks, of\n  \
    // rust: the point at `uv` and `depth`.\n\
    // rust: - `fn surface_at(texel: vec2<i32>) -> SurfaceData`: the solid terrain's surface at a pixel, as the \
    // rust: material stage's `set_surface` left it: `present` (false where the sky, an entity, water, glass or a \
    // rust: particle shows instead), `normal` (world axes), `smoothness` and `data`.\n";
}
    // rust: if kind == StageKind::Material {
    // rust: out += "- `fn block_texture(uv: vec2<f32>) -> vec4<f32>`: the surface's block texture at `uv`, anywhere on \
    // rust: the sprite, without the tint.\n\
    // rust: - `fn block_texture_level(uv: vec2<f32>, lod: f32) -> vec4<f32>`: the same at mip level `lod`.\n\
    // rust: - `fn block_texture_size() -> vec2<f32>`: its size in texels.\n\
    // rust: - `fn block_texture_lod() -> f32`: the mip level `block_texture` reads at this point.\n";
    // rust: out += "- `fn block_pbr_maps() -> bool`: whether the resource packs ship LabPBR maps (`_n`, `_s`).\n\
    // rust: - `fn block_normal_map(uv: vec2<f32>) -> vec4<f32>`: the surface's LabPBR normal map at `uv` (rg the \
    // rust: normal along `input.tangent` and down the texture, b ambient occlusion, a height); (0.5, 0.5, 1, 1) \
    // rust: without one.\n\
    // rust: - `fn block_specular_map(uv: vec2<f32>) -> vec4<f32>`: its LabPBR specular map (r smoothness, g F0 or a \
    // rust: metal, b porosity or subsurface, a emission, 1 none); (0, 0, 0, 0) without one.\n\
    // rust: - `fn block_normal_map_level(uv: vec2<f32>, lod: f32) -> vec4<f32>`, \
    // rust: `fn block_specular_map_level(uv: vec2<f32>, lod: f32) -> vec4<f32>`: the same at the block texture's mip level `lod`.\n\
    // rust: - `fn block_pbr_size() -> vec2<f32>`: the LabPBR maps' size in texels.\n\
    // rust: - `fn set_surface(normal: vec3<f32>, smoothness: f32, data: f32)`: what the post stage's \
    // rust: `surface_at` reads for this point of solid terrain (`data` the pack's own; the face's normal and 0, 0 unset).\n";
}
    // rust: if kind != StageKind::Sky {
    // rust: out += "- `fn shadow_position(position: vec3<f32>) -> vec3<f32>`: where the camera-relative point `position` is\n  \
    // rust: stored in the shadow map, for `textureSampleCompareLevel`.\n\
    // rust: - `fn shadow_distort(xy: vec2<f32>) -> vec2<f32>`: the map's distortion of a point at shadow clip `xy`.\n\n";
}
    // rust: if kind == StageKind::Post {
    // rust: out += "A `[[post]]` entry with `output = \"<name>\"` writes a target of the pack's own, at its `scale` of the\n\
    // rust: world's size (1, 0.5 or 0.25), instead of the next pass's `previous`; the prelude of every pass declares\n\
    // rust: `var <name>: texture_2d<f32>` (group 3 from binding 32), which holds last frame's until written again (a\n\
    // rust: pass reads a blank one in place of the target it writes).\n\n";
}
}
    // rust: out += "## The frame\n\n";
    // rust: let frame = Frame::line(api);
    // rust: out += &table(&frame, Some(&Frame::OFFSETS[..frame.fields.len()]));
    // rust: out += "## Anti-aliasing\n\n\
    // rust: While a pack's `[[post]]` chain draws the frame, the player's anti-aliasing settings do not run: `taa`, `fxaa`\n\
    // rust: and `upscaling` in `horizon-graphics.txt` have no effect, and the frame's projection is never jittered, because the\n\
    // rust: last post pass draws the picture itself and Horizon's own resolve, which does TAA, FXAA and TAA upscaling, is the\n\
    // rust: step it replaces. The world is still rendered at `resolutionScale` before the pack reads it.\n\n\
    // rust: A pack that wants smooth edges draws them itself, in a post pass: a spatial filter (FXAA, SMAA and the like) works on\n\
    // rust: `previous` as it is. A temporal pass cannot do what TAA does here, even though `history` and\n\
    // rust: `frame.previous_view_projection` give it the last frame: nothing moves the camera by a fraction of a texel from one\n\
    // rust: frame to the next, so a still camera gives it the same picture twice and there is no sub-pixel detail to gather.\n\n\
    // rust: Without a pack the settings apply as the player set them.\n\n";
    // rust: out += &format!(
    // rust: "## Options\n\n\
    // rust: Each `[[options]]` entry sets the WGSL `override` of the same name when the pipelines are built:\n\n\
    // rust: | `type` | Keys | The `override` |\n| --- | --- | --- |\n\
    // rust: | `bool` | `default` | `override <id>: bool` |\n\
    // rust: | `float` | `default`, `min`, `max`, `step` | `override <id>: f32` |\n\
    // rust: | `int` | `default`, `min`, `max` | `override <id>: i32` |\n\
    // rust: | `choice` | `values`, `default` (one of them) | `override <id>: u32`, the value's index |\n\n\
    // rust: ## Limits\n\n\
    // rust: - {MAX_POST_PASSES} post passes, {MAX_OPTIONS} options, `budget.gpu_ms` up to {MAX_GPU_MS}.\n\
    // rust: - {} KiB per WGSL file, {} MiB per pack.\n\
    // rust: - Per stage: {MAX_EXPRESSIONS} naga expressions over all its functions, {MAX_TEXTURE_READS} texture reads (samples,\n  \
    // rust: gathers and loads, the prelude's included).\n\n\
    // rust: ## The check\n\n\
    // rust: A pack runs only after it passes `horizon_shader_api::check` (the game when it loads a pack, the launcher before it\n\
    // rust: installs one, the registry's CI): each stage is parsed and validated by naga, checked against its signature and\n\
    // rust: the rules above, and translated for Vulkan (SPIR-V), Metal and DirectX 12 (HLSL) with its options at their\n\
    // rust: defaults, minimums and maximums. Every option must be an `override` of its type in some stage; an `override`\n\
    // rust: that is no option needs a default.\n",
    // rust: MAX_WGSL >> 10,
    // rust: MAX_TOTAL >> 20
    // rust: );
    // rust: out
}
