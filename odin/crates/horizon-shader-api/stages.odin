//! Transpiled from Horizon Rust crate
package horizon_shader_api_stages

import "core:fmt"
import "core:mem"
import "core:math"

// The stages a pack can fill, each a WGSL function with a fixed signature
// that Horizon calls inside its own passes, and the WGSL put around a
// pack's files to build a stage: the prelude before (the inputs and the
// resources), the entry points after.
// use crate::inputs::{
    // rust: DISPLACEMENT_INPUT, Frame, MATERIAL_INPUT, POST_INPUT, SKY_INPUT, SURFACE, Struct,
    // rust: TONEMAP_INPUT, VERTEX_INPUT, WEATHER_INPUT,
}
// use crate::manifest::Api;
// use crate::package::Pack;

// The bind group of a pack's resources; groups 0 to 2 are the renderer's.
GROUP :: 3

StageKind :: enum {
    // The sky's colour along each view ray, before the sun, moon and stars.
    Sky,
    // The colour of block surfaces (terrain), before the alpha test and fog.
    Material,
    // Where each corner of a block's surface is drawn (waving plants, rolling water), for
    // the world and the shadow map.
    Vertex,
    // The colour of rain and snow streaks.
    Weather,
    // A full-screen pass over the world's picture, under the hand and HUD.
    Post,
    // 0.2: the picture for the display, once per pixel of the window after the post chain,
    // before the camera overlays and the HUD.
    Tonemap,
}

// A resource a stage reads, declared by its prelude.
Resource :: struct {
    binding: u32,
    name: ^'static str,
    ty: ^'static str,
    doc: ^'static str,
}

    // rust: const FRAME: Resource = Resource {
    // rust: binding: 0,
    // rust: name: "frame",
    // rust: ty: "var<uniform> frame: Frame",
    // rust: doc: "The frame (`Frame`).",
}

// The shadow map at `binding`.
    // rust: const fn shadow_map(binding: u32) -> Resource {
    // rust: Resource {
    // rust: binding,
    // rust: name: "shadow_map",
    // rust: ty: "var shadow_map: texture_depth_2d",
    // rust: doc: "This frame's shadow map: the depth of the solid terrain and entities the light sees, 0 at the light, 1 away from it (and where nothing is), stored at `shadow_position`'s mapping. Valid while `frame.has_shadow` is 1 (the pack asks for it with `[shadow]`), else a 1×1 map that lights everything.",
}
}

// The shadow map's comparison sampler at `binding`.
    // rust: const fn shadow_sampler(binding: u32) -> Resource {
    // rust: Resource {
    // rust: binding,
    // rust: name: "shadow_sampler",
    // rust: ty: "var shadow_sampler: sampler_comparison",
    // rust: doc: "Depth comparison, bilinear (2×2 percentage-closer filtering): `textureSampleCompareLevel(shadow_map, shadow_sampler, p.xy, p.z)` is 1 where the point is lit, 0 in shadow.",
}
}

// The shadow map with translucent terrain at `binding`.
    // rust: const fn shadow_map_translucent(binding: u32) -> Resource {
    // rust: Resource {
    // rust: binding,
    // rust: name: "shadow_map_translucent",
    // rust: ty: "var shadow_map_translucent: texture_depth_2d",
    // rust: doc: "`shadow_map` with the translucent terrain (water, stained glass, ice) the light passes through drawn in too, read with `shadow_sampler` the same way: a point lit in `shadow_map` but not here lies under such a surface, which `shadow_color` gives the colour of.",
}
}

// The colour of the translucent terrain in the shadow map at `binding`.
    // rust: const fn shadow_color(binding: u32) -> Resource {
    // rust: Resource {
    // rust: binding,
    // rust: name: "shadow_color",
    // rust: ty: "var shadow_color: texture_2d<f32>",
    // rust: doc: "The texture colour times the vertex colour (rgb: the tint, the face's directional shade and ambient occlusion) of the nearest translucent surface the light passes through at each texel of `shadow_map_translucent`, white where there is none; alpha is 1 on a fluid (water) and the texture's alpha, at most 0.99, on anything else. Read it with `textureLoad` at `shadow_position`'s xy times `textureDimensions(shadow_color)`.",
}
}

// A function the material and post preludes give packs.
    // rust: pub const SHADOW_HELPERS: &str = "\
// The shadow map's distortion toward its centre, of a point at shadow clip `xy`.
shadow_distort :: proc(xy: vec2<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let k = frame.shadow_distortion;
    // rust: return xy / (length(xy) * k + 1.0 - k);
}
// Where the camera-relative point `position` is stored in the shadow map: xy its 0..1 texture
// coordinate (from the top left), z its depth from the light, for `textureSampleCompareLevel`.
shadow_position :: proc(position: vec3<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let clip = frame.shadow_view_proj * vec4<f32>(position, 1.0);
    // rust: let xy = shadow_distort(clip.xy);
    // At most 1, the depth where nothing is: past the map's far end a point stays lit.
    // rust: return vec3<f32>(xy.x * 0.5 + 0.5, 0.5 - xy.y * 0.5, min(clip.z, 1.0));
}
    // rust: ";

    // rust: const LINEAR_SAMPLER: Resource = Resource {
    // rust: binding: 4,
    // rust: name: "linear_sampler",
    // rust: ty: "var linear_sampler: sampler",
    // rust: doc: "Bilinear filtering, clamped to the edges.",
}

    // rust: const NEAREST_SAMPLER: Resource = Resource {
    // rust: binding: 5,
    // rust: name: "nearest_sampler",
    // rust: ty: "var nearest_sampler: sampler",
    // rust: doc: "Nearest texel, clamped to the edges.",
}

// The tonemap stage's resources, at the post stage's bindings for the same names.
    // rust: const TONEMAP_RESOURCES: [Resource; 4] = [
    // rust: FRAME,
    // rust: Resource {
    // rust: binding: 3,
    // rust: name: "previous",
    // rust: ty: "var previous: texture_2d<f32>",
    // rust: doc: "The post chain's picture at the window's size (without a post chain, the world's at the world's size), linear light: what `input.color` samples, for a curve that reads around the pixel.",
    // rust: },
    // rust: LINEAR_SAMPLER,
    // rust: NEAREST_SAMPLER,
    // rust: ];

// 0.2's colour boundary, in every 0.2 prelude: vanilla's 2.2 power both ways.
    // rust: const COLOR_HELPERS: &str = "\
// Negatives and NaN made 0 (a comparison with NaN is false), so no `pow` sees them.
horizon_sanitize :: proc(c: vec3<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return select(vec3<f32>(0.0), c, c > vec3<f32>(0.0));
}
horizon_decode :: proc(c: vec3<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return pow(horizon_sanitize(c), vec3<f32>(2.2));
}
horizon_encode :: proc(c: vec3<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return pow(horizon_sanitize(c), vec3<f32>(1.0 / 2.2));
}
// Alpha is coverage: it stays as it is.
horizon_decode_rgba :: proc(c: vec4<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return vec4<f32>(horizon_decode(c.rgb), c.a);
}
horizon_encode_rgba :: proc(c: vec4<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return vec4<f32>(horizon_encode(c.rgb), c.a);
}
    // rust: ";

    // rust: const POST_RESOURCES: [Resource; 12] = [
    // rust: FRAME,
    // rust: Resource {
    // rust: binding: 1,
    // rust: name: "scene_color",
    // rust: ty: "var scene_color: texture_2d<f32>",
    // rust: doc: "The world's picture before any pass.",
    // rust: },
    // rust: Resource {
    // rust: binding: 2,
    // rust: name: "scene_depth",
    // rust: ty: "var scene_depth: texture_depth_2d",
    // rust: doc: "The world's depth, reversed (1 near, 0 far and sky).",
    // rust: },
    // rust: Resource {
    // rust: binding: 3,
    // rust: name: "previous",
    // rust: ty: "var previous: texture_2d<f32>",
    // rust: doc: "The previous pass's output (`scene_color` for the first pass).",
    // rust: },
    // rust: LINEAR_SAMPLER,
    // rust: NEAREST_SAMPLER,
    // rust: shadow_map(6),
    // rust: shadow_sampler(7),
    // rust: Resource {
    // rust: binding: 8,
    // rust: name: "history",
    // rust: ty: "var history: texture_2d<f32>",
    // rust: doc: "Last frame's input to the last pass (what the pass before it wrote), for temporal passes (TAA, denoising): put such a pass second to last and it reads its own previous output; reproject with `frame.previous_view_projection`. Black on the first frame, after a gap of over half a second, and with a single pass.",
    // rust: },
    // rust: shadow_map_translucent(9),
    // rust: shadow_color(10),
    // rust: Resource {
    // rust: binding: 11,
    // rust: name: "scene_surface",
    // rust: ty: "var scene_surface: texture_2d<u32>",
    // rust: doc: "What the material stage's `set_surface` stored for the solid terrain at each pixel, unfiltered (`textureLoad`; its texels are the bits of floats, so `bitcast<vec4<f32>>` them): read it through the prelude's `surface_at`, which knows its layout and where it no longer shows. Blank without a material stage that calls `set_surface`.",
    // rust: },
    // rust: ];

// The material stage's resources: the frame, and the world as it was before translucent
// terrain drew (for water and glass to see what lies behind them).
    // rust: const MATERIAL_RESOURCES: [Resource; 11] = [
    // rust: FRAME,
    // rust: Resource {
    // rust: binding: 1,
    // rust: name: "reflection",
    // rust: ty: "var reflection: texture_2d<f32>",
    // rust: doc: "The water mirror: the world as a camera mirrored about the horizontal water plane around the camera (`frame.water_plane`) sees it, at half resolution, mapped like the world's picture, so water samples it at `input.screen`. Solid terrain, cut away below the plane, over the vanilla sky gradient: not the pack's `sky` stage, nor the sun, moon and stars. Drawn only for a pack whose material reads it, while `frame.has_reflection` is 1; else a 1×1 blank.",
    // rust: },
    // rust: Resource {
    // rust: binding: 2,
    // rust: name: "reflection_sampler",
    // rust: ty: "var reflection_sampler: sampler",
    // rust: doc: "Bilinear filtering, clamped to the edges.",
    // rust: },
    // rust: shadow_map(3),
    // rust: shadow_sampler(4),
    // rust: shadow_map_translucent(7),
    // rust: shadow_color(8),
    // rust: Resource {
    // rust: binding: 6,
    // rust: name: "opaque_depth",
    // rust: ty: "var opaque_depth: texture_depth_2d",
    // rust: doc: "The world's depth before translucent terrain (reversed, like `scene_depth`), for the translucent pass: `textureLoad(opaque_depth, vec2<i32>(input.screen * frame.resolution), 0)` is what lies behind water or glass. Stale while solid terrain draws.",
    // rust: },
    // rust: Resource {
    // rust: binding: 9,
    // rust: name: "block_light_colors",
    // rust: ty: "var block_light_colors: texture_3d<f32>",
    // rust: doc: "The colour of the block light around the camera, from the `[[lights]]` of the light sources nearby: rgb their colours averaged by how near each is, over 4; a how strongly they reach the cell. Read it through `block_light_color`.",
    // rust: },
    // rust: Resource {
    // rust: binding: 10,
    // rust: name: "block_light_grid",
    // rust: ty: "var<uniform> block_light_grid: vec4<f32>",
    // rust: doc: "Where `block_light_colors` lies: xyz its corner, camera-relative, w the side of one of its cells in blocks.",
    // rust: },
    // rust: Resource {
    // rust: binding: 11,
    // rust: name: "opaque_color",
    // rust: ty: "var opaque_color: texture_2d<f32>",
    // rust: doc: "The world's picture before translucent terrain (sky, solid terrain, entities), the size of `opaque_depth`, for the translucent pass: what a surface refracts. Read it with `textureLoad`. Stale while solid terrain draws; black when the world draws straight to the window (a pack without `[[post]]` passes, at full resolution).",
    // rust: },
    // rust: ];

// Functions the post prelude gives packs.
    // rust: const POST_HELPERS: &str = "\
// The world's depth at `uv` (reversed: 0 is the sky).
depth_at :: proc(uv: vec2<f32>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let size = vec2<f32>(textureDimensions(scene_depth));
    // rust: let texel = vec2<i32>(clamp(uv * size, vec2<f32>(0.0), size - 1.0));
    // rust: return textureLoad(scene_depth, texel, 0);
}
// The camera-relative world position, in blocks, of the point at `uv` and `depth`.
view_position :: proc(uv: vec2<f32>, depth: f32) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let clip = vec4<f32>(uv.x * 2.0 - 1.0, 1.0 - uv.y * 2.0, depth, 1.0);
    // rust: let view = frame.projection_inverse * clip;
    // rust: return (frame.view_inverse * vec4<f32>(view.xyz / view.w, 0.0)).xyz;
}
    // rust: ";

// What the material entries (the checker's below and the renderer's) share: the
// surface's normal and tangent from the derivatives of its position and uv. The arguments are
// the line's return statements of `block_light_color`, `block_texture` and
// `block_texture_level`, the helpers that read colour.
    // rust: macro_rules! material_helpers {
    // rust: ($light:literal, $texture:literal, $texture_level:literal) => {
    // rust: concat!(
    // rust: "\
// The colour of the block light at the camera-relative `position` (rgb, from the `[[lights]]`
// of the sources nearby) and how strongly they reach it (a, 0 where none does). Block light
// keeps its own brightness (`input.light.x`): this is its colour only.
block_light_color :: proc(position: vec3<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let size = vec3<f32>(textureDimensions(block_light_colors));
    // rust: let uvw = (position - block_light_grid.xyz) / (block_light_grid.w * size);
    // rust: if any(uvw < vec3<f32>(0.0)) || any(uvw > vec3<f32>(1.0)) {
    // rust: return vec4<f32>(0.0);
}
    // rust: let c = textureSampleLevel(block_light_colors, reflection_sampler, uvw, 0.0);
    // rust: ",
    // rust: $light,
    // rust: "}
// What the post stage's `surface_at` reads for this point of solid terrain: its `normal` (a
// unit vector in world axes), `smoothness` (0..1, say for reflections) and `data`, a value of
// the pack's own passed through. Unset, the point keeps the face's own normal and 0 for both;
// translucent terrain stores none.
    // rust: var<private> horizon_surface: vec4<f32>;
set_surface :: proc(normal: vec3<f32>, smoothness: f32, data: f32) {
}
    // Octahedral, y up: the upper half folds onto xz, the lower half unfolds around it.
    // rust: let n = normal / (abs(normal.x) + abs(normal.y) + abs(normal.z));
    // rust: var e = n.xz;
    // rust: if n.y < 0.0 {
    // rust: e = (1.0 - abs(n.zx)) * select(vec2<f32>(-1.0), vec2<f32>(1.0), n.xz >= vec2<f32>(0.0));
}
    // rust: horizon_surface = vec4<f32>(bitcast<f32>(pack2x16snorm(e)), smoothness, data, 1.0);
}
// The point being shaded: its sprite's layer and mip level (the entries set them).
    // rust: var<private> horizon_block_layer: u32;
    // rust: var<private> horizon_block_lod: f32;
// The surface's block texture at `uv` (the sprite's space, as `input.uv`), without the tint:
// what `input.albedo` holds at the point itself, readable anywhere on the sprite, for normals
// or detail generated from the texture.
block_texture :: proc(uv: vec2<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: ",
    // rust: $texture,
    // rust: "}
// `block_texture` at mip level `lod` (0 the full-size texture).
block_texture_level :: proc(uv: vec2<f32>, lod: f32) -> v {
    // Ported from Horizon
    return {}
}
    // rust: ",
    // rust: $texture_level,
    // rust: "}
// The block texture's size, in texels (16 x 16 for vanilla's).
block_texture_size :: proc() -> v {
    // Ported from Horizon
    return {}
}
    // rust: return horizon_block_size();
}
// The mip level `block_texture` reads at this point (0 up close, more far away).
block_texture_lod :: proc() -> f {
    // Ported from Horizon
    return {}
}
    // rust: return horizon_block_lod;
}
// LabPBR: whether the resource packs ship normal (`_n`) or specular (`_s`) maps beside their
// block textures. Without them `block_normal_map` and `block_specular_map` give the defaults
// below.
block_pbr_maps :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: return horizon_block_pbr_present();
}
// The surface's LabPBR normal map at `uv` (the sprite's space, as `input.uv`): rg the normal's
// x and y in the texture's space (x along `input.tangent`, y down the texture; 0..1 for
// -1..1), b ambient occlusion (1 none), a height (1 the top). (0.5, 0.5, 1, 1) where a texture
// has none.
block_normal_map :: proc(uv: vec2<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return horizon_block_pbr(uv, horizon_block_layer, horizon_block_lod, 0u);
}
// `block_normal_map` at the block texture's mip level `lod` (the same footprint on the surface,
// where the map is smaller than the texture).
block_normal_map_level :: proc(uv: vec2<f32>, lod: f32) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return horizon_block_pbr(uv, horizon_block_layer, lod, 0u);
}
// The surface's LabPBR specular map at `uv`: r perceptual smoothness, g F0 up to 229/255 and
// a metal's id above, b porosity or subsurface scattering, a emission (up to 254/255; 1
// none). (0, 0, 0, 0) where a texture has none.
block_specular_map :: proc(uv: vec2<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return horizon_block_pbr(uv, horizon_block_layer, horizon_block_lod, 1u);
}
// `block_specular_map` at the block texture's mip level `lod`.
block_specular_map_level :: proc(uv: vec2<f32>, lod: f32) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return horizon_block_pbr(uv, horizon_block_layer, lod, 1u);
}
// The LabPBR maps' size, in texels (they may be smaller than the block's texture).
block_pbr_size :: proc() -> v {
    // Ported from Horizon
    return {}
}
    // rust: return horizon_block_pbr_size();
}
// Block faces are flat: the derivatives of the position give the face's normal, turned
// toward the camera. Far away they lose precision, so a normal within about 3.6 degrees of
// an axis (every full block face) is that axis exactly: no shimmer on distant faces. The
// gentlest slope of flowing water, one level over a block, tilts about 6 degrees.
horizon_material_normal :: proc(position: vec3<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let n = normalize(cross(dpdx(position), dpdy(position)));
    // rust: let a = abs(n);
    // rust: let m = max(a.x, max(a.y, a.z));
    // rust: let axis = select(select(vec3(0.0, 0.0, sign(n.z)), vec3(0.0, sign(n.y), 0.0), a.y == m),
    // rust: vec3(sign(n.x), 0.0, 0.0), a.x == m);
    // rust: let flat_n = select(n, axis, m > 0.998);
    // rust: return select(flat_n, -flat_n, dot(flat_n, position) > 0.0);
}
// The direction `uv.x` grows along on the surface, and the sign of the one `uv.y` grows
// along against `cross(normal, tangent)`.
horizon_material_tangent :: proc(position: vec3<f32>, uv: vec2<f32>, normal: vec3<f32>) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let dp1 = dpdx(position);
    // rust: let dp2 = dpdy(position);
    // rust: let duv1 = dpdx(uv);
    // rust: let duv2 = dpdy(uv);
    // rust: let dp2perp = cross(dp2, normal);
    // rust: let dp1perp = cross(normal, dp1);
    // rust: let t = dp2perp * duv1.x + dp1perp * duv2.x;
    // rust: let b = dp2perp * duv1.y + dp1perp * duv2.y;
    // rust: if length(t) < 1e-12 {
    // rust: return vec4<f32>(1.0, 0.0, 0.0, 1.0);
}
    // rust: let tangent = normalize(t - normal * dot(normal, t));
    // rust: return vec4<f32>(tangent, select(-1.0, 1.0, dot(cross(normal, tangent), b) >= 0.0));
}
    // rust: "
    // rust: )
}
}

    // rust: const MATERIAL_HELPERS: &str = material_helpers!(
    // rust: "    return vec4<f32>(c.rgb * 4.0, c.a);\n",
    // rust: "    return horizon_block_sample(uv, horizon_block_layer, horizon_block_lod);\n",
    // rust: "    return horizon_block_sample(uv, horizon_block_layer, lod);\n"
    // rust: );

// 0.2's: the `[[lights]]` colours and the block texture decoded (the LabPBR maps are data).
    // rust: const MATERIAL_HELPERS_0_2: &str = material_helpers!(
    // rust: "    return vec4<f32>(horizon_decode(c.rgb * 4.0), c.a);\n",
    // rust: "    return horizon_decode_rgba(horizon_block_sample(uv, horizon_block_layer, horizon_block_lod));\n",
    // rust: "    return horizon_decode_rgba(horizon_block_sample(uv, horizon_block_layer, lod));\n"
    // rust: );

// The post prelude's `surface_at`, for the post helpers' end.
    // rust: const POST_SURFACE: &str = "\
// The solid terrain's surface at a pixel, as the material stage's `set_surface` left it.
SurfaceData :: struct {
    // False where the sky, an entity, water, glass or a particle shows instead.
    present: bool,
    // A unit vector in world axes.
    normal: vec3<f32>,
    smoothness: f32,
    // The pack's own value, passed through.
    data: f32,
}
surface_at :: proc(texel: vec2<i32>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let size = vec2<i32>(textureDimensions(scene_surface));
    // rust: let t = clamp(texel, vec2<i32>(0), size - 1);
    // rust: let s = bitcast<vec4<f32>>(textureLoad(scene_surface, t, 0));
    // rust: let depth_size = vec2<i32>(textureDimensions(scene_depth));
    // rust: let depth = textureLoad(scene_depth, clamp(texel, vec2<i32>(0), depth_size - 1), 0);
    // The terrain's own depth is stored with it: anything drawn nearer since hides it.
    // rust: let present = s.w > 0.0 && abs(s.w - depth) <= s.w * 1e-5;
    // rust: let e = unpack2x16snorm(bitcast<u32>(s.x));
    // rust: var n = vec3<f32>(e.x, 1.0 - abs(e.x) - abs(e.y), e.y);
    // rust: if n.y < 0.0 {
    // rust: n = vec3<f32>((1.0 - abs(n.z)) * sign(n.x), n.y, (1.0 - abs(n.x)) * sign(n.z));
}
    // rust: return SurfaceData(present, select(vec3<f32>(0.0), normalize(n), present),
    // rust: select(0.0, s.y, present), select(0.0, s.z, present));
}
    // rust: ";

// The post stage's entry points, as the renderer builds them: a full-screen
// triangle, and a fragment that calls the pack's `post` for each pixel.
    // rust: const POST_ENTRIES: &str = "\
HorizonPostOut :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) uv: vec2<f32>,
}
    // rust: @vertex fn horizon_vs_post(@builtin(vertex_index) i: u32) -> HorizonPostOut {
    // rust: let p = vec2<f32>(f32((i << 1u) & 2u), f32(i & 2u));
    // rust: var out: HorizonPostOut;
    // rust: out.position = vec4<f32>(p * 2.0 - 1.0, 0.0, 1.0);
    // rust: out.uv = vec2<f32>(p.x, 1.0 - p.y);
    // rust: return out;
}
    // rust: @fragment fn horizon_fs_post(in: HorizonPostOut) -> @location(0) vec4<f32> {
    // rust: let color = textureSampleLevel(previous, linear_sampler, in.uv, 0.0);
    // rust: return post(PostInput(in.uv, in.position.xy, color, depth_at(in.uv)));
}
    // rust: ";

// What the renderer gives the material prelude's LabPBR functions (`native_material.rs`); the
// check and the entries below put a stand-in in its place.
    // rust: macro_rules! pbr_stub {
    // rust: () => {
    // rust: "fn horizon_block_sample(uv: vec2<f32>, layer: u32, lod: f32) -> vec4<f32> {
    // rust: return vec4<f32>(1.0);
}
horizon_block_size :: proc() -> v {
    // Ported from Horizon
    return {}
}
    // rust: return vec2<f32>(16.0);
}
horizon_block_pbr :: proc(uv: vec2<f32>, layer: u32, lod: f32, map: u32) -> v {
    // Ported from Horizon
    return {}
}
    // rust: return select(vec4<f32>(0.5, 0.5, 1.0, 1.0), vec4<f32>(0.0), map == 1u);
}
horizon_block_pbr_present :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: return false;
}
horizon_block_pbr_size :: proc() -> v {
    // Ported from Horizon
    return {}
}
    // rust: return vec2<f32>(16.0);
}
    // rust: "
}
}
PBR_STUB :: pbr_stub!()

// Entry points with the material stage's inputs: the renderer calls
// `material` from its own terrain shader in the same way. The arguments are the line's
// `MaterialInput` and return statements.
    // rust: macro_rules! material_entries {
    // rust: ($input:literal, $result:literal) => {
    // rust: concat!(
    // rust: pbr_stub!(),
    // rust: "\
HorizonMaterialIn :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) albedo: vec4<f32>,
    // rust: @location(1) tint: vec4<f32>,
    // rust: @location(2) light: vec2<f32>,
    // rust: @location(3) lightmap: vec3<f32>,
    // rust: @location(4) world: vec3<f32>,
    // rust: @location(5) uv: vec2<f32>,
    // rust: @location(6) @interpolate(flat) translucent: u32,
    // rust: @location(7) @interpolate(flat) tags: u32,
    // rust: @location(8) @interpolate(flat) face: u32,
    // rust: @location(9) @interpolate(flat) fluid_quad: u32,
    // rust: @location(10) @interpolate(flat) emission: f32,
    // rust: @location(11) @interpolate(flat) material: u32,
}
    // rust: @fragment fn horizon_fs_material(in: HorizonMaterialIn) -> @location(0) vec4<f32> {
    // rust: let fluid = select(0u, select(2u, 1u, in.translucent != 0u), in.fluid_quad != 0u);
    // rust: let normal = horizon_material_normal(in.world);
    // rust: let tangent = horizon_material_tangent(in.world, in.uv, normal);
    // rust: ",
    // rust: $input,
    // rust: $result,
    // rust: "}
    // rust: "
    // rust: )
}
}

    // rust: const MATERIAL_ENTRIES: &str = material_entries!(
    // rust: "    let input = MaterialInput(in.albedo, in.tint, in.light, in.lightmap, in.world, in.uv, in.translucent != 0u, in.tags, in.material,
    // rust: in.position.xy / frame.resolution, in.face, fluid, in.emission, normal, tangent, vec3<f32>(0.0), 0.0);
    // rust: ",
    // rust: "    return material(input).color;\n"
    // rust: );

// 0.2's: the colours decoded on the way in, and the result encoded for the frame
// (`[frame] blend = "gamma"`; under `"linear"` the renderer stores it as it is).
    // rust: const MATERIAL_ENTRIES_0_2: &str = material_entries!(
    // rust: "    let input = MaterialInput(horizon_decode_rgba(in.albedo), horizon_decode_rgba(in.tint), in.light,
    // rust: horizon_decode(in.lightmap), in.world, in.uv, in.translucent != 0u, in.tags, in.material,
    // rust: in.position.xy / frame.resolution, in.face, fluid, in.emission, normal, tangent, vec3<f32>(0.0), 0.0);
    // rust: ",
    // rust: "    return horizon_encode_rgba(material(input).color);\n"
    // rust: );

// Entry points with the sky stage's inputs: the renderer calls `sky` from
// its own sky shader in the same way.
    // rust: const SKY_ENTRIES: &str = "\
HorizonSkyIn :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) direction: vec3<f32>,
    // rust: @location(1) color: vec4<f32>,
}
    // rust: @fragment fn horizon_fs_sky(in: HorizonSkyIn) -> @location(0) vec4<f32> {
    // rust: return sky(SkyInput(normalize(in.direction), in.color));
}
    // rust: ";

    // rust: const SKY_ENTRIES_0_2: &str = "\
HorizonSkyIn :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) direction: vec3<f32>,
    // rust: @location(1) color: vec4<f32>,
}
    // rust: @fragment fn horizon_fs_sky(in: HorizonSkyIn) -> @location(0) vec4<f32> {
    // rust: return horizon_encode_rgba(sky(SkyInput(normalize(in.direction), horizon_decode_rgba(in.color))));
}
    // rust: ";

// An entry point with the weather stage's inputs: the renderer calls `weather` from its own
// weather shader in the same way.
    // rust: const VERTEX_ENTRIES: &str = "\
    // rust: @vertex fn horizon_vs_vertex(
    // rust: @location(0) position: vec3<f32>, @location(1) uv: vec2<f32>, @location(2) light: vec2<f32>,
    // rust: @location(3) tint: vec4<f32>, @location(4) material: u32, @location(5) flags: u32,
    // rust: ) -> @builtin(position) vec4<f32> {
    // rust: let input = VertexInput(position, uv, material, light, tint, flags & 7u, flags >> 31u);
    // rust: return frame.projection * frame.view * vec4<f32>(vertex(input), 1.0);
}
    // rust: ";

// 0.2's: the tint is a colour, so it is decoded too.
    // rust: const VERTEX_ENTRIES_0_2: &str = "\
    // rust: @vertex fn horizon_vs_vertex(
    // rust: @location(0) position: vec3<f32>, @location(1) uv: vec2<f32>, @location(2) light: vec2<f32>,
    // rust: @location(3) tint: vec4<f32>, @location(4) material: u32, @location(5) flags: u32,
    // rust: ) -> @builtin(position) vec4<f32> {
    // rust: let input = VertexInput(position, uv, material, light, horizon_decode_rgba(tint), flags & 7u, flags >> 31u);
    // rust: return frame.projection * frame.view * vec4<f32>(vertex(input), 1.0);
}
    // rust: ";

// `fn displacement(input: DisplacementInput) -> f32`, the material stage's function
// under `[displacement]`.
DISPLACEMENT_SIGNATURE :: "fn displacement(input: DisplacementInput) -> f32"

// An entry point calling the material stage's `displacement`, after its entries under
// `[displacement]`: the renderer calls it from its own terrain vertex shader in the same way.
    // rust: const DISPLACEMENT_ENTRIES: &str = "@vertex fn horizon_vs_displacement(
    // rust: @location(0) position: vec3<f32>, @location(1) normal: vec3<f32>, @location(2) uv: vec2<f32>,
    // rust: @location(3) material: u32, @location(4) height: f32,
    // rust: ) -> @builtin(position) vec4<f32> {
    // rust: let depth = displacement(DisplacementInput(position, normal, uv, material, height));
    // rust: return frame.projection * frame.view * vec4<f32>(position - normal * depth, 1.0);
}
    // rust: ";

    // rust: const WEATHER_ENTRIES: &str = "\
HorizonWeatherIn :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) color: vec4<f32>,
    // rust: @location(1) light: vec2<f32>,
    // rust: @location(2) world: vec3<f32>,
    // rust: @location(3) @interpolate(flat) snow: u32,
}
    // rust: @fragment fn horizon_fs_weather(in: HorizonWeatherIn) -> @location(0) vec4<f32> {
    // rust: return weather(WeatherInput(in.color, in.light, in.world, in.snow != 0u));
}
    // rust: ";

    // rust: const WEATHER_ENTRIES_0_2: &str = "\
HorizonWeatherIn :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) color: vec4<f32>,
    // rust: @location(1) light: vec2<f32>,
    // rust: @location(2) world: vec3<f32>,
    // rust: @location(3) @interpolate(flat) snow: u32,
}
    // rust: @fragment fn horizon_fs_weather(in: HorizonWeatherIn) -> @location(0) vec4<f32> {
    // rust: let input = WeatherInput(horizon_decode_rgba(in.color), in.light, in.world, in.snow != 0u);
    // rust: return horizon_encode_rgba(weather(input));
}
    // rust: ";

// The post stage's entry points under 0.2: the chain's targets hold linear light, so nothing
// converts, and the pass's alpha is ignored.
    // rust: const POST_ENTRIES_0_2: &str = "\
HorizonPostOut :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) uv: vec2<f32>,
}
    // rust: @vertex fn horizon_vs_post(@builtin(vertex_index) i: u32) -> HorizonPostOut {
    // rust: let p = vec2<f32>(f32((i << 1u) & 2u), f32(i & 2u));
    // rust: var out: HorizonPostOut;
    // rust: out.position = vec4<f32>(p * 2.0 - 1.0, 0.0, 1.0);
    // rust: out.uv = vec2<f32>(p.x, 1.0 - p.y);
    // rust: return out;
}
    // rust: @fragment fn horizon_fs_post(in: HorizonPostOut) -> @location(0) vec4<f32> {
    // rust: let color = textureSampleLevel(previous, linear_sampler, in.uv, 0.0);
    // rust: return vec4<f32>(post(PostInput(in.uv, in.position.xy, color, depth_at(in.uv))).rgb, 1.0);
}
    // rust: ";

// The tonemap stage's entry points: a full-screen triangle at the window's size, and a fragment
// that holds the result to what the display pass takes.
    // rust: const TONEMAP_ENTRIES: &str = "\
HorizonTonemapOut :: struct {
    // rust: @builtin(position) position: vec4<f32>,
    // rust: @location(0) uv: vec2<f32>,
}
    // rust: @vertex fn horizon_vs_tonemap(@builtin(vertex_index) i: u32) -> HorizonTonemapOut {
    // rust: let p = vec2<f32>(f32((i << 1u) & 2u), f32(i & 2u));
    // rust: var out: HorizonTonemapOut;
    // rust: out.position = vec4<f32>(p * 2.0 - 1.0, 0.0, 1.0);
    // rust: out.uv = vec2<f32>(p.x, 1.0 - p.y);
    // rust: return out;
}
    // rust: @fragment fn horizon_fs_tonemap(in: HorizonTonemapOut) -> @location(0) vec4<f32> {
    // rust: let color = horizon_sanitize(textureSampleLevel(previous, linear_sampler, in.uv, 0.0).rgb);
    // rust: let out = tonemap(TonemapInput(in.uv, in.position.xy, color));
    // rust: return vec4<f32>(min(horizon_sanitize(out), vec3<f32>(frame.headroom)), 1.0);
}
    // rust: ";

    // rust: impl Api {
    // The stages the line has, in `StageKind::ALL`'s order.
stages :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Api::V0_1 => &StageKind::ALL[..5],
    // rust: Api::V0_2 => &StageKind::ALL,
}
}
}

    // rust: impl StageKind {
    // rust: pub const ALL: [StageKind; 6] = [
    // rust: StageKind::Sky,
    // rust: StageKind::Vertex,
    // rust: StageKind::Material,
    // rust: StageKind::Weather,
    // rust: StageKind::Post,
    // rust: StageKind::Tonemap,
    // rust: ];

    // The manifest's name for the stage (`[sky]`, `[vertex]`, `[material]`, `[weather]`,
    // `[[post]]`, `[tonemap]`).
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: StageKind::Sky => "sky",
    // rust: StageKind::Material => "material",
    // rust: StageKind::Vertex => "vertex",
    // rust: StageKind::Weather => "weather",
    // rust: StageKind::Post => "post",
    // rust: StageKind::Tonemap => "tonemap",
}
}

    // The function a pack defines: it has the stage's name.
function :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.name()
}

input :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: StageKind::Sky => &SKY_INPUT,
    // rust: StageKind::Material => &MATERIAL_INPUT,
    // rust: StageKind::Vertex => &VERTEX_INPUT,
    // rust: StageKind::Weather => &WEATHER_INPUT,
    // rust: StageKind::Post => &POST_INPUT,
    // rust: StageKind::Tonemap => &TONEMAP_INPUT,
}
}

    // The type the function returns.
output :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: StageKind::Material => SURFACE.name,
    // rust: StageKind::Vertex | StageKind::Tonemap => "vec3<f32>",
    // rust: StageKind::Sky | StageKind::Weather | StageKind::Post => "vec4<f32>",
}
}

    // `fn <name>(input: <Input>) -> <Output>`.
signature :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "fn {}(input: {}) -> {}",
    // rust: self.function(),
    // rust: self.input().name,
    // rust: self.output()
    // rust: )
}

resources :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: StageKind::Post => &POST_RESOURCES,
    // rust: StageKind::Sky | StageKind::Vertex | StageKind::Weather => std::slice::from_ref(&FRAME),
    // rust: StageKind::Material => &MATERIAL_RESOURCES,
    // rust: StageKind::Tonemap => &TONEMAP_RESOURCES,
}
}

    // Everything the pack's files may use under the line `api`, declared before them.
prelude :: proc(self: ^Self, api: Api) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = match api {
    // rust: Api::V0_1 => {
    // rust: String::from("// Horizon shader API prelude (docs/api/shaders-reference.md)\n")
}
    // rust: Api::V0_2 => String::from(
    // rust: "// Horizon shader API 0.2 prelude (docs/api/shaders-reference-0.2.md)\n",
    // rust: ),
}
    // rust: out += &Frame::line(api).wgsl();
    // rust: out += &self.input().wgsl();
    // rust: if self == StageKind::Material {
    // rust: out += &SURFACE.wgsl();
            // The vertex stage's file joins the material's module (`compose`).
    // rust: out += &VERTEX_INPUT.wgsl();
    // rust: out += &DISPLACEMENT_INPUT.wgsl();
}
    // rust: for r in self.resources() {
    // rust: out += &format!("@group({GROUP}) @binding({}) {};\n", r.binding, r.ty);
}
    // rust: if api == Api::V0_2 {
    // rust: out += COLOR_HELPERS;
}
    // rust: match self {
    // rust: StageKind::Post => {
    // rust: out += POST_HELPERS;
    // rust: out += POST_SURFACE;
    // rust: out += SHADOW_HELPERS;
}
    // rust: StageKind::Material => {
    // rust: out += match api {
    // rust: Api::V0_1 => MATERIAL_HELPERS,
    // rust: Api::V0_2 => MATERIAL_HELPERS_0_2,
}
    // rust: out += SHADOW_HELPERS;
}
    // rust: StageKind::Vertex => out += SHADOW_HELPERS,
    // rust: StageKind::Sky | StageKind::Weather | StageKind::Tonemap => {}
}
    // rust: out
}

    // The entry points put after the pack's files under the line `api`.
entries :: proc(self: ^Self, api: Api) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match (api, self) {
    // rust: (Api::V0_1, StageKind::Sky) => SKY_ENTRIES,
    // rust: (Api::V0_1, StageKind::Material) => MATERIAL_ENTRIES,
    // rust: (Api::V0_1, StageKind::Vertex) => VERTEX_ENTRIES,
    // rust: (Api::V0_1, StageKind::Weather) => WEATHER_ENTRIES,
    // rust: (Api::V0_1, StageKind::Post) => POST_ENTRIES,
    // rust: (Api::V0_2, StageKind::Sky) => SKY_ENTRIES_0_2,
    // rust: (Api::V0_2, StageKind::Material) => MATERIAL_ENTRIES_0_2,
    // rust: (Api::V0_2, StageKind::Vertex) => VERTEX_ENTRIES_0_2,
    // rust: (Api::V0_2, StageKind::Weather) => WEATHER_ENTRIES_0_2,
    // rust: (Api::V0_2, StageKind::Post) => POST_ENTRIES_0_2,
            // 0.1 has no tonemap stage: a manifest with one is refused before it is built.
    // rust: (_, StageKind::Tonemap) => TONEMAP_ENTRIES,
}
}
}

// The first binding of a pack's `[[textures]]` in group 3; their samplers follow at
// `TEXTURE_SAMPLER_BINDING`.
TEXTURE_BINDING :: 16
TEXTURE_SAMPLER_BINDING :: 24

// The declarations of a pack's `[[textures]]`, part of every stage's prelude.
texture_declarations :: proc(textures: ^[crate::manifest::PackTexture]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: for (i, t) in textures.iter().enumerate() {
    // rust: out += &format!(
    // rust: "@group({GROUP}) @binding({}) var {}: texture_2d<f32>;\n\
    // rust: @group({GROUP}) @binding({}) var {}_sampler: sampler;\n",
    // rust: TEXTURE_BINDING + i as u32,
    // rust: t.id,
    // rust: TEXTURE_SAMPLER_BINDING + i as u32,
    // rust: t.id
    // rust: );
}
    // rust: out
}

// A stage's WGSL, and where each part of it came from.
Composed :: struct {
    text: string,
    // (the file, or `<prelude>` / `<entries>`, its byte range in `text`).
    parts: Vec<(string,
}

    // rust: impl Composed {
    // The file, line and column (1-based) of a byte offset in `text`.
locate :: proc(self: ^Self, offset: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (file, range) = self
    // rust: .parts
    // rust: .iter()
    // rust: .find(|(_, r)| r.contains(&offset))
    // rust: .or(self.parts.last())
    // rust: .expect("a composed stage has parts");
    // rust: let before = &self.text[range.start..offset.clamp(range.start, range.end)];
    // rust: let line = before.matches('\n').count() + 1;
    // rust: let column = before.len() - before.rfind('\n').map_or(0, |i| i + 1) + 1;
    // rust: (file, line, column)
}
}

// The binding of a pack's first post target (`[[post]] output`) in group 3, the others after.
POST_TARGET_BINDING :: 32

// The declarations of a pack's post targets, part of the post stage's prelude.
post_target_declarations :: proc(manifest: ^crate::manifest::Manifest) -> S {
    // Ported from Horizon
    return {}
}
    // rust: manifest
    // rust: .post_targets()
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, (name, _))| {
    // rust: format!(
    // rust: "@group({GROUP}) @binding({}) var {name}: texture_2d<f32>;\n",
    // rust: POST_TARGET_BINDING + i as u32
    // rust: )
    // rust: })
    // rust: .collect()
}

// The WGSL of the stage `kind` whose own file is `file`: the prelude, the
// pack's shared files in order, the file, then the entry points, all of the pack's line.
compose :: proc(pack: ^Pack, kind: StageKind, file: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let api = pack.manifest.api;
    // rust: let mut composed = Composed {
    // rust: text: String::new(),
    // rust: parts: Vec::new(),
}
    // rust: let mut push = |name: &str, text: &str| {
    // rust: let start = composed.text.len();
    // rust: composed.text += text;
    // rust: if !text.ends_with('\n') {
    // rust: composed.text.push('\n');
}
    // rust: composed
    // rust: .parts
    // rust: .push((name.to_owned(), start..composed.text.len()));
}
    // rust: let mut prelude = kind.prelude(api) + &texture_declarations(&pack.manifest.textures);
    // rust: if kind == StageKind::Post {
    // rust: prelude += &post_target_declarations(&pack.manifest);
}
    // rust: push("<prelude>", &prelude);
    // rust: for shared in pack.manifest.shared.iter().filter(|s| *s != file) {
    // rust: push(shared, pack.source(shared).unwrap_or_default());
}
    // The stage's own extra files, between the shared ones and its file.
    // rust: let m = &pack.manifest;
    // rust: let stage = match kind {
    // rust: StageKind::Sky => m.sky.as_ref(),
    // rust: StageKind::Material => m.material.as_ref(),
    // rust: StageKind::Vertex => m.vertex.as_ref(),
    // rust: StageKind::Weather => m.weather.as_ref(),
    // rust: StageKind::Post => m.post.iter().find(|s| s.file == file),
    // rust: StageKind::Tonemap => m.tonemap.as_ref(),
}
    // rust: for extra in stage.into_iter().flat_map(|s| &s.files) {
    // rust: if extra != file && !m.shared.contains(extra) {
    // rust: push(extra, pack.source(extra).unwrap_or_default());
}
}
    // rust: push(file, pack.source(file).unwrap_or_default());
    // They draw terrain together: the vertex stage's function is in the material's module.
    // rust: if kind == StageKind::Material
    // rust: && let Some(vertex) = &m.vertex
    // rust: {
    // rust: for extra in vertex.files.iter().chain(std::iter::once(&vertex.file)) {
    // rust: let own = stage.is_some_and(|s| s.files.contains(extra));
    // rust: if !own && !m.shared.contains(extra) {
    // rust: push(extra, pack.source(extra).unwrap_or_default());
}
}
}
    // rust: if kind == StageKind::Material && m.displacement.is_some() {
    // rust: push(
    // rust: "<entries>",
    // rust: &(kind.entries(api).to_owned() + DISPLACEMENT_ENTRIES),
    // rust: );
    // rust: } else {
    // rust: push("<entries>", kind.entries(api));
}
    // rust: composed
}

// Whether a material stage's `source` (with its prelude) calls `set_surface` itself, and so
// needs the surface target, which a pack without it doesn't pay for.
calls_set_surface :: proc(source: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let call = "set_surface(";
    // rust: source.matches(call).count() > MATERIAL_HELPERS.matches(call).count()
}
