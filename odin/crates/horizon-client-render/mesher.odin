//! Transpiled from Horizon Rust crate
package horizon_client_render_mesher

import "core:fmt"
import "core:mem"
import "core:math"

// Section meshing on worker threads. Faces follow the baked blockstate models
// with vanilla's neighbour culling; vertex light and colour follow
// `ModelBlockRenderer`/`BlockModelLighter` (smooth light, ambient occlusion,
// cardinal shading, tint sources, block offsets; see `lighting`). Fluids
// follow `FluidRenderer` (see `fluid`).
    // rust: mod fluid;
    // rust: mod leaf_culling;
    // rust: mod lighting;
    // rust: pub mod packed;
    // rust: mod sides;
// use crate::connected::{Pick, TileLayer};
// use crate::{
    // rust: assets::{Assets, RenderAssets},
    // rust: biome::{Biomes, GrassModifier},
    // rust: blocks::{BlockFacts, RenderShape},
    // rust: chunk::{Chunk, MIN_Y},
    // rust: graphics::LeafCullingMode,
    // rust: models::catalog::BakedFace,
}
// use horizon_assets::model::Direction as ModelDirection;
// use horizon_core::{
    // rust: biome::BiomeZoom, geometry::Direction, position::BlockPos, random::position_seed,
}
// use horizon_optifine::ctm::connect::{Axes as CtmAxes, Face as CtmFace};
// use horizon_world::{
    // rust: block_render::FaceVisibility,
    // rust: fluid::{FluidKind, FluidState},
    // rust: registry::BlockStateId,
}
    // rust: pub(crate) use sides::sort_tinted;
    // rust: pub use sides::{Part, Sides, group_parts};
// use std::sync::Arc;

// An entity, item and effect vertex (the entity pipelines), with a face
// normal for `entity.wgsl`'s directional light.
Vertex :: struct {
    pos: [f32,
    uv: [f32,
    layer: u32,
    // RGBA8: tint multiplied by directional shade and ambient occlusion.
    color: u32,
    // Smooth light, 16x fixed point: sky in bits 0..8, block in bits 8..16.
    light: u32,
    // RGBA8_SNORM face normal; w = -127 for two-sided lighting, 0 to keep baked/unlit colour,
    // [`CULL_BACK`] to keep it and also drop back-facing pixels.
    normal: [i8,
    // The `GLINT_TEXTURING` atlas UV for a foil item quad; zero elsewhere.
    glint_uv: [f32,
}
// `Vertex::normal` of a baked-colour quad of an `entitySolid` model: the render type culls
// back faces, which the entity pipelines here do not, so `entity.wgsl` discards them.
CULL_BACK :: [0, 0, 0, 1]
// `Vertex::normal.w` of a shaded quad of an `entityCutoutCull` model (the bat): shaded by the
// normal like -127, and `entity.wgsl` also discards its back-facing pixels.
SHADED_CULL_W :: -126
// A section vertex: vanilla's `DefaultVertexFormat.BLOCK` (position, colour,
// UV0, UV2) with the sprite's array layer beside the light, in 24 bytes
// rather than vanilla's 28: the UV is fixed point, which holds model UVs
// (multiples of 1/16 and their halves) exactly. The position stays a float:
// fixed point would move the edges of offset plants and rotated elements by
// a fraction of a pixel. Terrain has no normal: `ModelBlockRenderer` bakes
// the face shade into the colour and `terrain.vsh` only multiplies it by the
// lightmap.
TerrainVertex :: struct {
    // Section-relative position.
    pos: [f32,
    // UV within the sprite, `UV_STEPS` per unit (`TerrainVertex::new`,
    // `terrain.wgsl`'s `terrain_uv`).
    // rust: pub(crate) uv: [u16; 2],
    // Sprite array layer, with `OPAQUE_LAYER` for opaque leaves and quads over opaque texels.
    layer: u16,
    // Smooth light, 16x fixed point: sky in the low byte, block in the high one.
    light: u16,
    // RGBA8: tint multiplied by directional shade and ambient occlusion.
    color: u32,
}
// `v.round().clamp(0.0, 65535.0) as u16`, without the `roundf` call x86-64's
// baseline instruction set makes of `f32::round`: clamped first (the same
// result), the fraction is exact below 2^23, and every float above is whole.
round_to_u16 :: proc(v: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let v = v.clamp(0.0, f32::from(u16::MAX));
    // rust: let whole = v as u32;
    // rust: (whole + u32::from(v - whole as f32 >= 0.5)) as u16
}
// Fixed-point steps per unit of `TerrainVertex` UVs, which span `[0, 2)`.
UV_STEPS :: 32768.0
// Fixed-point steps per block of distant-terrain UVs (`TerrainVertex::tiled`),
// which span `[0, 2048)`: merged faces repeat their sprite once per block.
TILED_UV_STEPS :: 32.0
    // rust: impl TerrainVertex {
new :: proc(pos: [f32; 3], uv: [f32; 2], layer: u16, color: u32, light: u16) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: pos,
    // rust: uv: uv.map(|v| round_to_u16(v * UV_STEPS)),
    // rust: layer,
    // rust: light,
    // rust: color,
}
}
    // A vertex of a merged distant-terrain face, its UV in blocks from the
    // face's corner. Drawn with an instance UV scale of `1 / TILED_UV_STEPS`.
tiled :: proc(pos: [f32; 3], uv: [f32; 2], layer: u16, color: u32, light: u16) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: pos,
    // rust: uv: uv.map(|v| round_to_u16(v * TILED_UV_STEPS)),
    // rust: layer,
    // rust: light,
    // rust: color,
}
}
    // The UV the GPU samples.
uv :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.uv.map(|v| f32::from(v) / UV_STEPS)
}
}
    // rust: mod vertex_tests {
//     use super::TerrainVertex;
model_uvs_pack_exactly :: proc() {
}
    // rust: for i in 0..=32 {
    // rust: let u = i as f32 / 32.0;
    // rust: let v = TerrainVertex::new([0.0; 3], [u, 1.0 - u], 0, 0, 0);
    // rust: assert_eq!(v.uv(), [u, 1.0 - u]);
}
}
uv_rounding_matches_f32_round :: proc() {
}
    // rust: let reference = |v: f32| v.round().clamp(0.0, f32::from(u16::MAX)) as u16;
    // rust: let mut values = vec![
    // rust: f32::NAN,
    // rust: f32::INFINITY,
    // rust: f32::NEG_INFINITY,
    // rust: -0.0,
    // rust: 0.5,
    // rust: 1.5,
    // rust: 65534.5,
    // rust: 1e9,
    // rust: ];
    // rust: for bits in (0..u32::MAX).step_by(9973) {
    // rust: values.push(f32::from_bits(bits));
}
    // rust: for i in 0..=140_000 {
    // rust: values.push(i as f32 * 0.5 - 2.0);
    // rust: values.push(i as f32 * 0.5 - 2.0 + f32::EPSILON);
}
    // rust: for v in values {
    // rust: assert_eq!(super::round_to_u16(v), reference(v), "{v:e}");
}
}
other_uvs_round_within_a_step :: proc() {
}
        // A flowing fluid's rotated UV.
    // rust: let uv = [0.5 + 0.25 * 0.3f32.sin(), 0.5 - 0.25 * 0.3f32.cos()];
    // rust: let packed = TerrainVertex::new([0.0; 3], uv, 0, 0, 0).uv();
    // rust: for (a, b) in packed.iter().zip(uv) {
    // rust: assert!((a - b).abs() <= 0.5 / 32768.0, "{a} {b}");
}
}
emission_keeps_the_colour_and_the_free_bits :: proc() {
}
    // rust: let rgb = super::pack_rgb([0x12, 0x34, 0x56]);
    // rust: assert_eq!(super::emitting(rgb, 0), rgb);
    // rust: assert_eq!(super::emitting(rgb, super::INCANDESCENT), 0xFD56_3412);
    // rust: assert_eq!(super::emitting(rgb, super::VERY_BRIGHT), 0xFB56_3412);
    // rust: assert_eq!(super::emitting(rgb, super::LOW | super::WHOLE), 0xFA56_3412);
    // rust: assert_eq!(super::emitting(rgb, super::WHOLE), rgb);
    // rust: assert_eq!(
    // rust: super::emitting(rgb, super::VERY_BRIGHT) | super::EMISSION_BITS,
    // rust: rgb
    // rust: );
}
light_sources_shine_by_kind_not_light_level :: proc() {
}
//         use super::{BRIGHT, INCANDESCENT, LOW, WHOLE, hdr_tier};
    // rust: assert_eq!(hdr_tier("glowstone", 15), BRIGHT);
        // A candle's flame is a particle: the block keeps only its wick.
    // rust: assert_eq!(hdr_tier("torch", 14), INCANDESCENT);
    // rust: assert_eq!(hdr_tier("red_candle", 3), LOW);
    // rust: assert_eq!(hdr_tier("glow_lichen", 7), 0);
    // rust: assert_eq!(hdr_tier("stone", 0), 0);
    // rust: assert_eq!(hdr_tier("ochre_froglight", 15), LOW | WHOLE);
    // rust: assert_eq!(hdr_tier("lava", 15), INCANDESCENT | WHOLE);
    // rust: assert_eq!(hdr_tier("red_candle_cake", 3), 0);
    // rust: assert_eq!(hdr_tier("respawn_anchor", 3), INCANDESCENT);
    // rust: assert_eq!(hdr_tier("waxed_copper_bulb", 15), LOW);
    // rust: assert_eq!(hdr_tier("sea_pickle", 15), 0);
        // Unlisted ones by their light level.
    // rust: assert_eq!(hdr_tier("vault", 12), INCANDESCENT);
    // rust: assert_eq!(hdr_tier("sculk_sensor", 1), LOW);
}
fluid_faces_keep_the_colour_and_the_emission :: proc() {
}
    // rust: let lit = super::emitting(super::pack_rgb([0x12, 0x34, 0x56]), super::INCANDESCENT);
    // rust: assert_eq!(super::fluid_face(lit, 0), 0x8D56_3412);
    // rust: assert_eq!(super::fluid_face(lit, 5), 0xDD56_3412);
        // Another face replaces the first.
    // rust: assert_eq!(super::fluid_face(super::fluid_face(lit, 5), 1), 0x9D56_3412);
}
    // What `gfx/native_material.rs` reads back from the colour's alpha byte: the face of a
    // fluid quad, and the HDR tier.
decoded :: proc(color: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let flags = color >> 24;
    // rust: let high = flags >> 4;
    // rust: let fluid = high >= 8 && (high & 7) < 6;
    // rust: (fluid.then_some(high & 7), 15 - (flags & 15))
}
the_material_stage_reads_back_what_the_mesher_encodes :: proc() {
}
    // rust: let rgb = super::pack_rgb([0x12, 0x34, 0x56]);
    // rust: for tier in 0..=super::VERY_BRIGHT {
    // rust: let lit = super::emitting(rgb, tier);
    // rust: assert_eq!(decoded(lit), (None, u32::from(tier)));
    // rust: for face in 0..6 {
    // rust: assert_eq!(
    // rust: decoded(super::fluid_face(lit, face)),
    // rust: (Some(face as u32), u32::from(tier))
    // rust: );
}
}
}
}

    // rust: mod section_mesh_tests {
//     use super::*;

compute_bounds_empty_solid_and_translucent :: proc() {
}
    // rust: let mut mesh = SectionMesh::default();
    // rust: assert_eq!(mesh.compute_bounds(), None);

    // rust: let v1 = TerrainVertex::new([1.0, 2.0, 3.0], [0.0, 0.0], 0, 0, 0);
    // rust: let v2 = TerrainVertex::new([4.0, 5.0, 6.0], [0.0, 0.0], 0, 0, 0);
    // rust: mesh.solid.push(v1);
    // rust: mesh.solid.push(v2);

    // rust: let pad = glam::Vec3::splat(SectionMesh::BOUNDS_PAD);
    // rust: assert_eq!(
    // rust: mesh.compute_bounds(),
    // rust: Some([
    // rust: glam::Vec3::new(1.0, 2.0, 3.0) - pad,
    // rust: glam::Vec3::new(4.0, 5.0, 6.0) + pad,
    // rust: ])
    // rust: );

    // rust: let v3 = TerrainVertex::new([0.5, 7.0, 8.0], [0.0, 0.0], 0, 0, 0);
    // rust: mesh.translucent.push(v3);
    // rust: assert_eq!(
    // rust: mesh.compute_bounds(),
    // rust: Some([
    // rust: glam::Vec3::new(0.5, 2.0, 3.0) - pad,
    // rust: glam::Vec3::new(4.0, 7.0, 8.0) + pad,
    // rust: ])
    // rust: );
}
}
SectionMesh :: struct {
    solid: [dynamic]TerrainVertex,
    // The buckets `solid` is sorted in by the side its quads face: empty
    // until `sort_solid`, which the meshing workers call; `solid` is in
    // model order before.
    sides: Sides,
    translucent: [dynamic]TerrainVertex,
    // `solid` in the compact layout (`packed`), when the renderer reads it and it is
    // smaller; empty otherwise. Made by `sort_solid`.
    packed: Vec<[u32,
    // The tint of each solid quad as the mesher multiplied it (`packed::UNKNOWN_TINT` where
    // it does not say), for `packed`; dropped once that is made.
    // rust: pub(crate) solid_tints: Vec<u32>,
    // VisGraph: bit `a * 6 + b` is set when faces `a` and `b` (Direction
    // order) are connected through non-opaque blocks.
    visibility: u64,
    // Blocks with a block-entity renderer (world position, state id), drawn
    // each frame by `block_entity_render` like vanilla's per-section
    // `SectionCompiler.Results.blockEntities`.
    block_entities: Vec<([i32,
    // Blocks that give off light (world position, state id), for the colour of block light
    // Horizon's shader packs read (`gfx::block_light`).
    lights: Vec<([i32,
    // Sprite layers emitted while building this mesh. Kept distinct before
    // upload so the renderer does not rescan every terrain vertex.
    sprite_layers: [dynamic]u16,
    // Axis-aligned bounding box [min, max] of actual terrain mesh vertices in section-local space [0, 16].
    bounds: Option<[glam::Vec3,
    // A far mesh was clipped around finer tiles or resident chunks. Keep
    // the previous GPU mesh while its replacements fade in.
    keep: bool,
}
    // rust: impl Default for SectionMesh {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: solid: Vec::new(),
    // rust: sides: Sides::default(),
    // rust: translucent: Vec::new(),
    // rust: packed: Vec::new(),
    // rust: solid_tints: Vec::new(),
    // rust: visibility: ALL_VISIBLE,
    // rust: block_entities: Vec::new(),
    // rust: lights: Vec::new(),
    // rust: sprite_layers: Vec::new(),
    // rust: bounds: None,
    // rust: keep: false,
}
}
}
    // rust: impl SectionMesh {
    // Record a sprite layer used by a quad. Opaque is a vertex-only flag and
    // is removed here so the renderer can compare the actual atlas layer.
note_sprite_layer :: proc(self: ^Self, layer: u16) {
}
    // rust: let layer = layer & !crate::mesher::OPAQUE_LAYER;
    // rust: if !self.sprite_layers.contains(&layer) {
    // rust: self.sprite_layers.push(layer);
}
}
    // Finish the compact layer list after meshing has emitted all faces.
finish_sprite_layers :: proc(self: ^Self) {
}
    // rust: self.sprite_layers.sort_unstable();
    // rust: self.sprite_layers.dedup();
}

    // Padding applied to mesh vertex bounds to prevent clipping at the frustum
    // boundary when shader packs with vertex displacement (e.g. waving foliage, water) are active.
BOUNDS_PAD :: 0.5

    // Retain geometry capacity after an upload, but none of its old contents.
clear :: proc(self: ^Self) {
}
    // rust: self.solid.clear();
    // rust: self.translucent.clear();
    // rust: self.packed.clear();
    // rust: self.solid_tints.clear();
    // rust: self.block_entities.clear();
    // rust: self.lights.clear();
    // rust: self.sprite_layers.clear();
    // rust: self.sides = Sides::default();
    // rust: self.visibility = ALL_VISIBLE;
    // rust: self.bounds = None;
    // rust: self.keep = false;
}
    // rust: pub(crate) fn capacity_bytes(&self) -> usize {
    // rust: self.solid.capacity() * std::mem::size_of::<TerrainVertex>()
    // rust: + self.translucent.capacity() * std::mem::size_of::<TerrainVertex>()
    // rust: + self.packed.capacity() * std::mem::size_of::<[u32; 6]>()
    // rust: + self.solid_tints.capacity() * std::mem::size_of::<u32>()
    // rust: + self.block_entities.capacity() * std::mem::size_of::<([i32; 3], u32)>()
    // rust: + self.lights.capacity() * std::mem::size_of::<([i32; 3], u32)>()
    // rust: + self.sprite_layers.capacity() * std::mem::size_of::<u16>()
}
    // Sorts the solid quads by the side they face, for the renderer to
    // leave out those facing away from the eye (`sides`).
    // Then lays them out compactly (`packed`) while the renderer reads that.
sort_solid :: proc(self: ^Self) {
}
    // rust: let quads = self.solid.len() / 4;
    // rust: if !self.solid_tints.is_empty() {
    // rust: self.solid_tints.resize(quads, packed::UNKNOWN_TINT);
}
    // rust: self.sides = sides::sort_tinted(&mut self.solid, &mut self.solid_tints);
    // rust: self.bounds = self.compute_bounds();
    // rust: self.packed.clear();
    // rust: if packed::packing() && quads > 0 && self.solid_tints.len() == quads {
    // rust: self.packed = packed::layout(&self.solid, &self.solid_tints);
}
    // rust: self.solid_tints.clear();
}

    // Computes the tight axis-aligned bounding box [min, max] of actual terrain geometry vertices.
compute_bounds :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.solid.is_empty() && self.translucent.is_empty() {
    // rust: return None;
}
    // rust: let mut min = glam::Vec3::splat(f32::INFINITY);
    // rust: let mut max = glam::Vec3::splat(f32::NEG_INFINITY);
    // rust: for v in &self.solid {
    // rust: let p = glam::Vec3::from(v.pos);
    // rust: min = min.min(p);
    // rust: max = max.max(p);
}
    // rust: for v in &self.translucent {
    // rust: let p = glam::Vec3::from(v.pos);
    // rust: min = min.min(p);
    // rust: max = max.max(p);
}
    // rust: let pad = glam::Vec3::splat(Self::BOUNDS_PAD);
    // rust: Some([min - pad, max + pad])
}
}
ALL_VISIBLE :: (1 << 36) - 1
// VisGraph.resolve: flood fill non-opaque cells and connect the faces each region touches.
visibility :: proc(pad: ^Padded, info: ^[Info]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let solid: Vec<bool> = info.iter().map(|i| i.solid).collect();
    // rust: let mut rows = Vec::new();
    // rust: solid_rows(pad, &solid, &mut rows);
    // rust: visibility_rows(&open_rows(&rows))
}
// The section's cells that are not `isSolidRender`, by row (`y << 4 | z`, bit
// x), from the padded rows of `MeshScratch::solid_rows`.
open_rows :: proc(solid: ^[u32]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|r| {
    // rust: let (y, z) = ((r >> 4) as i32, (r & 15) as i32);
    // rust: !(solid[((y + B) as usize) * P + (z + B) as usize] >> B) as u16
    // rust: })
}
// The cells of `open` connected to `seeds` (a subset) within the row: an
// occluded fill each way, doubling its reach at each step.
fill_row :: proc(seeds: u16, open: u16) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let (mut up, mut through_up) = (seeds, open);
    // rust: let (mut down, mut through_down) = (seeds, open);
    // rust: for step in [1, 2, 4, 8] {
    // rust: up |= through_up & up << step;
    // rust: through_up &= through_up << step;
    // rust: down |= through_down & down >> step;
    // rust: through_down &= through_down >> step;
}
    // rust: up | down
}
// `visibility` on bit rows, one region at a time: a region grows a row at
// a time (each row filled along its open runs at once) by sweeps over the
// rows it can reach, until a sweep adds nothing.
visibility_rows :: proc(open: ^[u16; 256]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let open_count: u32 = open.iter().map(|r| r.count_ones()).sum();
    // rust: if open_count == 4096 {
    // rust: return ALL_VISIBLE;
}
    // rust: if open_count == 0 {
    // rust: return 0;
}
    // rust: let mut unvisited = *open;
    // rust: let mut region = [0u16; 256];
    // rust: let mut result = 0u64;
    // rust: for start in 0..256 {
    // rust: while unvisited[start] != 0 {
    // rust: let seed = unvisited[start] & unvisited[start].wrapping_neg();
    // rust: region[start] = fill_row(seed, unvisited[start]);
    // rust: let (mut lo, mut hi) = (start, start);
    // rust: loop {
    // rust: let mut grown = false;
    // rust: let (first, last) = (lo.saturating_sub(16), (hi + 16).min(255));
    // rust: for r in (first..=last).chain((first..=last).rev()) {
    // rust: let mut near = region[r];
    // rust: if r >= 16 {
    // rust: near |= region[r - 16];
}
    // rust: if r + 16 < 256 {
    // rust: near |= region[r + 16];
}
    // rust: if r & 15 != 0 {
    // rust: near |= region[r - 1];
}
    // rust: if r & 15 != 15 {
    // rust: near |= region[r + 1];
}
    // rust: let reached = near & unvisited[r];
    // rust: if reached & !region[r] != 0 {
    // rust: region[r] = fill_row(reached, unvisited[r]);
    // rust: (lo, hi) = (lo.min(r), hi.max(r));
    // rust: grown = true;
}
}
    // rust: if !grown {
    // rust: break;
}
}
    // rust: let mut faces = 0u8;
    // rust: for r in lo..=hi {
    // rust: let row = std::mem::take(&mut region[r]);
    // rust: if row == 0 {
    // rust: continue;
}
    // rust: unvisited[r] &= !row;
    // rust: let (y, z) = (r >> 4, r & 15);
    // rust: faces |= u8::from(y == 0)
    // rust: | u8::from(y == 15) << 1
    // rust: | u8::from(z == 0) << 2
    // rust: | u8::from(z == 15) << 3
    // rust: | u8::from(row & 1 != 0) << 4
    // rust: | u8::from(row & 0x8000 != 0) << 5;
}
            // A single connected region touching all six faces sets every
            // pair (including the diagonal); unvisited cavities cannot add more.
    // rust: if faces == 0b11_1111 {
    // rust: return ALL_VISIBLE;
}
    // rust: for a in 0..6 {
    // rust: if faces & (1 << a) != 0 {
    // rust: for b in 0..6 {
    // rust: if faces & (1 << b) != 0 {
    // rust: result |= 1 << (a * 6 + b);
}
}
}
}
    // rust: if result == ALL_VISIBLE {
    // rust: return result;
}
}
}
    // rust: result
}
    // rust: mod particle_tests;
    // rust: mod visibility_tests;
// A face's tint source as the game colours it (`BlockColors.createDefault`), for drawing a block
// elsewhere ([`crate::block_sprites`]): the biome's grass, foliage, dry foliage or water colour
// where the block is, or a fixed colour (0xRRGGBB).
TintSource :: enum {
    Grass,
    Foliage,
    DryFoliage,
    Water,
    Fixed(u32),
}
Tint :: enum {
    None,
    Grass,
    // `BlockTintSources.grassBlock`: grass in the world, none on its particles.
    GrassBlock,
    TallGrassUpper,
    SugarCane,
    LilyPad,
    Foliage,
    DryFoliage,
    Water,
    Constant(u32),
    Redstone(u8),
    Stem(u8),
}
// Per-state data the mesher needs on every block, flattened for speed.
Info :: struct {
    // `isSolidRender`.
    solid: bool,
    // `isCollisionShapeFullBlock`: AO faces flush with a full block sample outside it.
    full: bool,
    // `isLightPermeable`: diagonal AO samples are taken through such side blocks.
    permeable: bool,
    // `getShadeBrightness` (ambient occlusion contribution).
    shade: f32,
    emission: u8,
    // `hdr_tier`.
    tier: u8,
    // `emissiveRendering`: drawn and sampled at full brightness.
    emissive: bool,
    fluid: FluidState,
    model: bool,
    // The state has a block entity (candidates for block-entity renderers).
    block_entity: bool,
    tints: [Tint,
    tint_count: u8,
    // `OffsetType` as (max horizontal, max vertical): vertical 0 for XZ.
    offset: Option<(f32,
    // `isSolid()` (legacy), for fluid corner heights.
    legacy_solid: bool,
    // `HalfTransparentBlock`/`LeavesBlock`: water sides show the overlay sprite.
    overlay: bool,
    // `LeavesBlock`: with opaque leaves the faces between two leaf blocks are skipped.
    leaves: bool,
    // A glass pane: connected-texture tiles take the cube's UVs on it (OptiFine's pane models
    // drop vanilla's mirrored faces).
    pane: bool,
    // A full opaque cube: `RenderShape::Model`, `can_occlude`, `solid_render`
    // and a full collision shape. The only block leaf culling treats as solid.
    opaque_cube: bool,
    blocks_flow: bool,
    ice: bool,
    sturdy: u8,
    // Occlusion face per direction: 0 empty, 1 the full-block singleton, 2 partial.
    face: [u8,
    // Height from the bottom over which face `d`, flush with the `d` side, covers
    // the full width (vertical faces: 1 when the whole square is covered).
    cover: [f32,
}
// Derived per-state facts, exposed for the section-mesh parity gate.
MeshFacts :: struct {
    shade: f32,
    emissive: bool,
    legacy_solid: bool,
    light_permeable: bool,
    solid_render: bool,
    full_collision: bool,
    emission: u8,
    overlay: bool,
    tint_sources: u8,
}
MeshTables :: struct {
    info: [dynamic]Info,
    // `Info::solid` by state, packed apart: the opacity mask of a section
    // reads 8,000 states, and a few bytes each stay in cache where `Info`
    // does not.
    solid: [dynamic]bool,
    // By state, bit `d` set where its occlusion face toward direction `d` is the
    // full block (`Info::face` 1): a face looking at it never shows.
    full_faces: [dynamic]u8,
    visibility: FaceVisibility,
    water_still: u16,
    water_flow: u16,
    water_overlay: u16,
    lava_still: u16,
    lava_flow: u16,
    animated_layers: [dynamic]bool,
}
stem_color :: proc(age: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let a = u32::from(age);
    // rust: (a * 32) << 16 | (255 - a * 8) << 8 | (a * 4)
}
redstone_color :: proc(power: u8) -> u {
    // Ported from Horizon
    return {}
}
    // RedstoneWireBlock.COLORS
    // rust: let f = f32::from(power) / 15.0;
    // rust: let r = f * 0.6 + if f > 0.0 { 0.4 } else { 0.3 };
    // rust: let g = (f * f * 0.7 - 0.5).clamp(0.0, 1.0);
    // rust: let b = (f * f * 0.6 - 0.7).clamp(0.0, 1.0);
    // rust: ((r * 255.0) as u32) << 16 | ((g * 255.0) as u32) << 8 | (b * 255.0) as u32
}
    // rust: impl MeshTables {
    // rust: pub fn new(
    // rust: assets: &Assets,
    // rust: render: &RenderAssets,
    // rust: facts: &BlockFacts,
    // rust: visibility: FaceVisibility,
    // rust: ) -> crate::Result<Self> {
        // Terrain vertices keep the sprite layer below `OPAQUE_LAYER`.
    // rust: let layers = render.sprite_layers.values().max().map_or(0, |l| l + 1);
    // rust: if layers > u32::from(OPAQUE_LAYER) {
    // rust: return Err(
    // rust: format!("{layers} block sprites, terrain vertices index {OPAQUE_LAYER}").into(),
    // rust: );
}
    // rust: let layer = |name: &str| -> crate::Result<u16> {
    // rust: render
    // rust: .sprite_layers
    // rust: .get(name)
    // rust: .map(|&l| l as u16)
    // rust: .ok_or_else(|| format!("missing fluid sprite {name}").into())
}
    // rust: let max_animated = render.animations.iter().map(|a| a.layer).max().unwrap_or(0);
    // rust: let mut animated_layers = vec![false; max_animated as usize + 1];
    // rust: for animation in &render.animations {
    // rust: animated_layers[animation.layer as usize] = true;
}
    // rust: let mut covers = std::collections::HashMap::new();
    // rust: let mut info = Vec::with_capacity(facts.states.len());
    // rust: for (id, s) in facts.states.iter().enumerate() {
    // rust: let state = assets
    // rust: .registry
    // rust: .state(BlockStateId(id as u32))
    // rust: .ok_or("missing registry state")?;
    // rust: let props = &state.properties;
    // rust: let prop = |k: &str| -> u8 { props.get(k).and_then(|v| v.parse().ok()).unwrap_or(0) };
    // rust: let name = s.name.strip_prefix("minecraft:").unwrap_or(&s.name);
            // BlockColors.createDefault: tint sources by block.
    // rust: let (tints, tint_count) = match name {
    // rust: "large_fern" | "tall_grass" => {
    // rust: if props.get("half").map(String::as_str) == Some("upper") {
    // rust: ([Tint::TallGrassUpper; 2], 1)
    // rust: } else {
    // rust: ([Tint::Grass; 2], 1)
}
}
    // rust: "fern" | "short_grass" | "potted_fern" | "bush" => ([Tint::Grass; 2], 1),
    // rust: "grass_block" => ([Tint::GrassBlock; 2], 1),
    // rust: "sugar_cane" => ([Tint::SugarCane; 2], 1),
    // rust: "pink_petals" | "wildflowers" => ([Tint::None, Tint::Grass], 2),
    // rust: "spruce_leaves" => ([Tint::Constant(0x61_9961); 2], 1),
    // rust: "birch_leaves" => ([Tint::Constant(0x80_A755); 2], 1),
    // rust: "oak_leaves" | "jungle_leaves" | "acacia_leaves" | "dark_oak_leaves" | "vine"
    // rust: | "mangrove_leaves" => ([Tint::Foliage; 2], 1),
    // rust: "leaf_litter" => ([Tint::DryFoliage; 2], 1),
    // rust: "water_cauldron" => ([Tint::Water; 2], 1),
                // Their in-world colour is the particle-only source's -1.
    // rust: "water" | "bubble_column" => ([Tint::None; 2], 1),
    // rust: "redstone_wire" => ([Tint::Redstone(prop("power")); 2], 1),
    // rust: "attached_melon_stem" | "attached_pumpkin_stem" => {
    // rust: ([Tint::Constant(0xE0_C71C); 2], 1)
}
    // rust: "melon_stem" | "pumpkin_stem" => ([Tint::Stem(prop("age")); 2], 1),
    // rust: "lily_pad" => ([Tint::LilyPad; 2], 1),
    // rust: _ => ([Tint::None; 2], 0),
}
            // getShadeBrightness overrides; the default is 0.2 for full collision shapes.
    // rust: let overrides = [
    // rust: "TransparentBlock",
    // rust: "BarrierBlock",
    // rust: "LightBlock",
    // rust: "StructureVoidBlock",
    // rust: ];
    // rust: let shade = if overrides.iter().any(|c| s.has_class(c)) {
    // rust: 1.0
    // rust: } else if s.has_class("SoulSandBlock") || s.has_class("MudBlock") {
    // rust: 0.2
    // rust: } else if s.has_class("SnowLayerBlock") {
    // rust: if prop("layers") == 8 { 0.2 } else { 1.0 }
    // rust: } else if s.full_collision {
    // rust: 0.2
    // rust: } else {
    // rust: 1.0
}
    // rust: let emissive = name == "magma_block"
    // rust: || (matches!(name, "sculk_sensor" | "calibrated_sculk_sensor")
    // rust: && props.get("sculk_sensor_phase").map(String::as_str) == Some("active"));
            // OffsetType.XZ/XYZ with getMaxHorizontalOffset/getMaxVerticalOffset.
    // rust: let offset = s.random_offset.then(|| {
    // rust: let horizontal = if s.has_class("SpeleothemBlock") {
    // rust: 0.125
    // rust: } else {
    // rust: 0.25
}
    // rust: let vertical = match name {
    // rust: "small_dripleaf" => 0.1,
    // rust: "short_grass" | "fern" | "short_dry_grass" | "tall_dry_grass" => 0.2,
    // rust: _ => 0.0,
}
    // rust: (horizontal, vertical)
    // rust: });
    // rust: let mut face = [0u8; 6];
    // rust: let mut cover = [0f32; 6];
            // A server's visibility knows no state (`FaceVisibility::empty`):
            // it meshes no fluid, so these stay unset.
    // rust: for d in Direction::ALL
    // rust: .into_iter()
    // rust: .filter(|_| !visibility.is_empty())
    // rust: {
    // rust: let (face_id, shape) = visibility
    // rust: .occlusion_face(BlockStateId(id as u32), d)
    // rust: .ok_or("missing occlusion face")?;
    // rust: face[d as usize] = face_id.min(2) as u8;
    // rust: cover[d as usize] = *covers
    // rust: .entry((face_id, d as u8))
    // rust: .or_insert_with(|| fluid::coverage(shape, d));
}
    // rust: info.push(Info {
    // rust: solid: s.solid_render,
    // rust: full: s.full_collision,
    // rust: permeable: !s.solid_render || s.dampening == 0,
    // rust: shade,
    // rust: emission: s.emission,
    // rust: tier: hdr_tier(name, s.emission),
    // rust: emissive,
    // rust: fluid: FluidState::from_block(state)?,
    // rust: model: s.render_shape == RenderShape::Model,
    // rust: block_entity: s.block_entity,
    // rust: tints,
    // rust: tint_count,
    // rust: offset,
    // rust: legacy_solid: s.legacy_solid,
    // rust: overlay: s.has_class("HalfTransparentBlock") || s.has_class("LeavesBlock"),
    // rust: leaves: s.has_class("LeavesBlock"),
    // rust: pane: s.has_class("IronBarsBlock") && name.ends_with("glass_pane"),
    // rust: opaque_cube: leaf_culling::opaque_cube(
    // rust: s.render_shape,
    // rust: s.can_occlude,
    // rust: s.solid_render,
    // rust: s.full_collision,
    // rust: ),
    // rust: blocks_flow: assets.blocks_fluid_flow.contains(&*s.name),
    // rust: ice: s.has_class("IceBlock"),
    // rust: sturdy: s.sturdy_full,
    // rust: face,
    // rust: cover,
    // rust: });
}
    // rust: Ok(Self {
    // rust: solid: info.iter().map(|i| i.solid).collect(),
    // rust: full_faces: info
    // rust: .iter()
    // rust: .map(|i| (0..6).fold(0, |bits, d| bits | u8::from(i.face[d] == 1) << d))
    // rust: .collect(),
    // rust: info,
    // rust: visibility,
    // rust: water_still: layer("minecraft:block/water_still")?,
    // rust: water_flow: layer("minecraft:block/water_flow")?,
    // rust: water_overlay: layer("minecraft:block/water_overlay")?,
    // rust: lava_still: layer("minecraft:block/lava_still")?,
    // rust: lava_flow: layer("minecraft:block/lava_flow")?,
    // rust: animated_layers,
    // rust: })
}
    // Whether a terrain sprite layer has an animated clip.
is_animated :: proc(self: ^Self, layer: u16) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.animated_layers
    // rust: .get(layer as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
    // HDR output's tier of a state (`hdr_tier`), for what meshes it elsewhere (the LOD tiles).
hdr_tier :: proc(self: ^Self, state: BlockStateId) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.info.get(state.0 as usize).map_or(0, |i| i.tier)
}
facts :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let i = self.info.get(state.0 as usize)?;
    // rust: Some(MeshFacts {
    // rust: shade: i.shade,
    // rust: emissive: i.emissive,
    // rust: legacy_solid: i.legacy_solid,
    // rust: light_permeable: i.permeable,
    // rust: solid_render: i.solid,
    // rust: full_collision: i.full,
    // rust: emission: i.emission,
    // rust: overlay: i.overlay,
    // rust: tint_sources: i.tint_count,
    // rust: })
}
    // Whether `state` is a full opaque cube: the only block leaf culling
    // treats as a solid neighbour. Glass, fluids, slabs, stairs and models
    // that only partly fill their block are not.
opaque_cube :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.info
    // rust: .get(state.0 as usize)
    // rust: .is_some_and(|i| i.opaque_cube)
}
    // `BlockTintSource.color(state)`: block-model colour without a level.
    // `grass` is `GrassColor.getDefaultColor()` from the active pack's colormap.
    // Untinted faces, blank sources and invalid tint indices return `None`.
default_tint :: proc(self: ^Self, state: BlockStateId, index: i32, grass: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let info = self.info.get(state.0 as usize)?;
    // rust: if index < 0 || index >= i32::from(info.tint_count) {
    // rust: return None;
}
    // rust: Some(match info.tints[index as usize] {
    // rust: Tint::None | Tint::SugarCane | Tint::Water => return None,
    // rust: Tint::Grass | Tint::GrassBlock | Tint::TallGrassUpper => grass & 0xFF_FFFF,
    // rust: Tint::Foliage => 0x48_B518,
    // rust: Tint::DryFoliage => 0x5C_3C32,
    // rust: Tint::LilyPad => 0x71_C35C,
    // rust: Tint::Constant(c) => c,
    // rust: Tint::Redstone(p) => redstone_color(p),
    // rust: Tint::Stem(age) => stem_color(age),
    // rust: })
}
    // What tint source `index` (a face's `tintindex`) of `state` colours a face with in the
    // world, for drawing the block elsewhere ([`crate::block_sprites`]): `None` for an untinted
    // face. Grass blocks, tall grass and sugar cane are `Grass`; redstone and stems are their
    // colour at the state's power and age.
tint_source :: proc(self: ^Self, state: BlockStateId, index: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let info = self.info.get(state.0 as usize)?;
    // rust: if index < 0 || index >= i32::from(info.tint_count) {
    // rust: return None;
}
    // rust: Some(match info.tints[index as usize] {
    // rust: Tint::None => return None,
    // rust: Tint::Grass | Tint::GrassBlock | Tint::TallGrassUpper | Tint::SugarCane => {
    // rust: TintSource::Grass
}
    // rust: Tint::Foliage => TintSource::Foliage,
    // rust: Tint::DryFoliage => TintSource::DryFoliage,
    // rust: Tint::Water => TintSource::Water,
    // rust: Tint::LilyPad => TintSource::Fixed(0x20_8030),
    // rust: Tint::Constant(c) => TintSource::Fixed(c),
    // rust: Tint::Redstone(p) => TintSource::Fixed(redstone_color(p)),
    // rust: Tint::Stem(age) => TintSource::Fixed(stem_color(age)),
    // rust: })
}
    // `TerrainParticle`'s colour: tint source 0's `colorAsTerrainParticle`,
    // which is the in-world (biome-blended) colour except on grass blocks,
    // whose dirt crumbs stay untinted. `None` when the state has no source.
    // `region[dz][dx]` are the chunks around `pos`'s chunk (centre 1,1).
    // rust: pub fn terrain_particle_tint(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: biomes: &Biomes,
    // rust: zoom: BiomeZoom,
    // rust: blend_radius: i32,
    // rust: ) -> Option<u32> {
    // rust: let info = self.info.get(state.0 as usize)?;
    // rust: if info.tints[0] == Tint::GrassBlock {
    // rust: return None;
}
    // rust: let [x, y, z] = pos;
    // rust: let origin = [x >> 4, z >> 4, y & !15];
    // rust: let mut tints = Tints::new(region, biomes, zoom, blend_radius, origin);
    // rust: Mesher::tint(info, 0, &mut tints, [x & 15, y & 15, z & 15])
}
    // `BlockColors` for each of the state's tint indices at `pos`, as the
    // chunk mesher tints them (grass blocks included): `None` for an
    // untinted (-1) layer. For block models drawn outside the chunk mesh.
    // rust: pub fn block_tints(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: biomes: &Biomes,
    // rust: zoom: BiomeZoom,
    // rust: blend_radius: i32,
    // rust: ) -> impl Fn(i32) -> Option<u32> + use<> {
    // rust: let sources = self.info.get(state.0 as usize).map(|info| {
    // rust: let [x, y, z] = pos;
    // rust: let origin = [x >> 4, z >> 4, y & !15];
    // rust: let mut tints = Tints::new(region, biomes, zoom, blend_radius, origin);
    // rust: let local = [x & 15, y & 15, z & 15];
    // rust: let colors = [0, 1].map(|i| Mesher::tint(info, i, &mut tints, local));
    // rust: (colors, i32::from(info.tint_count))
    // rust: });
    // rust: move |index| {
    // rust: let (colors, count) = sources?;
    // rust: if index < 0 || index >= count {
    // rust: return None;
}
    // rust: colors[(index as usize).min(1)]
}
}
    // `ModelBlockRenderer.tesselateFlat`'s light coords (`LightCoordsUtil`
    // packing, the quad's own emission included) for `quad` of `state`
    // drawn as the only block at `pos`, as `MovingBlockRenderState` gives
    // it: `light` is the world's stored light (sky << 4 | block) at a
    // position. For block models drawn outside the chunk mesh.
    // rust: pub fn flat_light(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: quad: &horizon_assets::bake::ModelQuad,
    // rust: light: impl Fn([i32; 3]) -> u8,
    // rust: ) -> u32 {
    // rust: let own = self.info.get(state.0 as usize);
    // rust: let full = own.is_some_and(|i| i.full);
    // rust: let at = lighting::flat_position(pos, &quad.positions, quad.facing, quad.cull, full);
    // rust: let packed = light(at);
    // rust: let coords = match own {
    // rust: Some(own) => lighting::packed_coords(own, packed),
    // rust: None => u32::from(packed & 15) << 4 | u32::from(packed >> 4) << 20,
}
    // rust: lighting::with_min(coords, quad.light)
}
    // `BlockState.getOffset` for blocks with a random model offset.
offset :: proc(self: ^Self, state: BlockStateId, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: offset(self.info.get(state.0 as usize)?, x, z)
}
}
// `OffsetType.XZ`/`XYZ`: a per-column jitter from `Mth.getSeed(x, 0, z)`.
offset :: proc(info: ^Info, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (horizontal, vertical) = info.offset?;
    // rust: let seed = position_seed(BlockPos::new(x, 0, z));
    // rust: let nibble = |shift: u32| ((seed >> shift) & 15) as f32 / 15.0;
    // rust: let h = f64::from(horizontal);
    // rust: Some([
    // rust: ((f64::from(nibble(0)) - 0.5) * 0.5).clamp(-h, h),
    // rust: (f64::from(nibble(4)) - 1.0) * f64::from(vertical),
    // rust: ((f64::from(nibble(8)) - 0.5) * 0.5).clamp(-h, h),
    // rust: ])
}
// Border width: smooth lighting samples up to two blocks out along a face normal.
B :: 2
P :: 16 + 2 * B 
pi :: proc(x: i32, y: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((y + B) as usize * P + (z + B) as usize) * P + (x + B) as usize
}
// Blocks and light of one section plus a `B`-block border.
Padded :: struct {
    blocks: [dynamic]u32,
    light: [dynamic]u8,
}
    // rust: impl Padded {
new :: proc(region: ^[[Maybe(^Chunk); 3]; 3], sy: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut pad = Self::default();
    // rust: pad.fill(region, sy, &mut Box::new([0; 4096]));
    // rust: pad
}
fill :: proc(self: ^Self, region: ^[[Maybe(^Chunk); 3]; 3], sy: i32, own: ^[u32; 4096]) {
}
    // rust: self.blocks.resize(P * P * P, 0);
    // rust: self.light.resize(P * P * P, 0);
    // rust: let (blocks, light) = (&mut self.blocks, &mut self.light);
    // rust: let base_y = region[1][1].map_or(MIN_Y, Chunk::min_y) + sy * 16;
        // The section itself is unpacked in one pass and copied row by row;
        // the border cells of the neighbouring sections are read in runs, from
        // sections found once per layer.
    // rust: own.fill(0);
    // rust: let center = region[1][1];
    // rust: if let Some(c) = center {
    // rust: c.sections[sy as usize].unpack(own);
}
    // rust: for y in -B..16 + B {
    // rust: let wy = base_y + y;
            // Where each chunk column's cells of this layer come from, found once.
    // rust: let sources: [[Source; 3]; 3] = std::array::from_fn(|rz| {
    // rust: std::array::from_fn(|rx| match region[rz][rx] {
    // rust: None => Source::Missing,
    // rust: Some(c) => match c.section_at(wy) {
    // rust: Ok(section) => Source::Section(section),
    // rust: Err(light) => Source::Outside(light),
    // rust: },
    // rust: })
    // rust: });
    // rust: for z in -B..16 + B {
    // rust: let row = pi(-B, y, z);
    // rust: let rz = ((z + 16) >> 4) as usize;
    // rust: let (west, rest) = blocks[row..row + P].split_at_mut(B as usize);
    // rust: let (middle, east) = rest.split_at_mut(16);
    // rust: let (west_light, rest) = light[row..row + P].split_at_mut(B as usize);
    // rust: let (middle_light, east_light) = rest.split_at_mut(16);
    // rust: let own_row = (rz == 1 && (0..16).contains(&y))
    // rust: .then(|| &own[(y << 8 | z << 4) as usize..][..16]);
    // rust: let at = |x: i32| crate::chunk::index(x, wy, z);
    // rust: let [w, m, e] = &sources[rz];
    // rust: let edge = (center, wy, z);
    // rust: fill_run(west, west_light, w, None, at(-B), -B, edge);
    // rust: fill_run(middle, middle_light, m, own_row, at(0), 0, edge);
    // rust: fill_run(east, east_light, e, None, at(16), 16, edge);
}
}
}
}
// Where the cells of one chunk column at one height come from (`Padded::fill`).
Source :: enum {
    // A neighbour not loaded.
    Missing,
    // Above or below the column's sections: air with this light.
    Outside(u8),
    Section(&'a crate::chunk::Section),
}
// Fills one run of a padded row, `blocks.len()` cells from x = `x0`, starting
// at section index `at`; `own` is the centre section's row, already unpacked.
    // rust: fn fill_run(
    // rust: blocks: &mut [u32],
    // rust: light: &mut [u8],
    // rust: source: &Source,
    // rust: own: Option<&[u32]>,
    // rust: at: usize,
    // rust: x0: i32,
    // rust: (center, wy, z): (Option<&Chunk>, i32, i32),
    // rust: ) {
    // rust: match source {
    // rust: Source::Section(section) => {
    // rust: match own {
    // rust: Some(own) => blocks.copy_from_slice(own),
    // rust: None => section.blocks.get_run(at, blocks),
}
    // rust: section.light.copy_run(at, light);
}
    // rust: Source::Outside(v) => {
    // rust: blocks.fill(0);
    // rust: light.fill(*v);
}
        // A neighbour not loaded continues this chunk's edge column. As lit
        // air, the outermost chunks' water drew a wall toward it (fluids show
        // both sides), a light sheet in the water where far terrain carries
        // on. Vanilla draws no chunk without its neighbours.
    // rust: Source::Missing => match center {
    // rust: Some(c) => {
    // rust: let ez = z.clamp(0, 15);
    // rust: for (k, (block, light)) in blocks.iter_mut().zip(light.iter_mut()).enumerate() {
    // rust: let ex = (x0 + k as i32).clamp(0, 15);
    // rust: *block = c.get(ex, wy, ez);
    // rust: *light = c.light(ex, wy, ez);
}
}
    // rust: None => {
    // rust: blocks.fill(0);
    // rust: light.fill(0xF0);
}
    // rust: },
}
}
// Per-worker temporary arrays. They never hold resource-pack references or
// geometry still owned by the renderer, and total about 150 KiB per worker
// (the leaf mask adds 8,000 cells, depths and a queue).
MeshScratch :: struct {
    padded: Padded,
    own: Option<Box<[u32,
    leaf: leaf_culling::LeafMask,
    // Per padded row (`pi(-B, y, z) / P`), bit `x + B` set where the block
    // is `isSolidRender` (`MeshTables::solid`).
    solid_rows: [dynamic]u32,
}
// Fills `rows` with the padded section's `isSolidRender` blocks, one bit each (`MeshScratch::solid_rows`).
solid_rows :: proc(pad: ^Padded, solid: ^[bool], rows: ^[dynamic]u32) {
}
    // rust: rows.clear();
    // rust: rows.extend(pad.blocks.as_chunks::<P>().0.iter().map(|row| {
    // rust: row.iter().enumerate().fold(0u32, |bits, (x, &id)| {
    // rust: bits | u32::from(solid[id as usize]) << x
    // rust: })
    // rust: }));
}
// Whether the block at `(x, y, z)` (section-local) and its six neighbours
// are all `isSolidRender`: none of its faces can show.
hidden :: proc(rows: ^[u32], x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let row = |y: i32, z: i32| rows[((y + B) as usize) * P + (z + B) as usize];
    // rust: let r = row(y, z);
    // rust: let around =
    // rust: r & r << 1 & r >> 1 & row(y - 1, z) & row(y + 1, z) & row(y, z - 1) & row(y, z + 1);
    // rust: around >> (x + B) & 1 != 0
}
    // rust: mod leaf_culling_tests;
    // rust: mod reuse_tests;
    // rust: mod tint_tests;
// Set on a terrain vertex's sprite layer when its texture alpha must be ignored.
OPAQUE_LAYER :: 1 << 15
// The bits of `TerrainVertex::color`'s alpha byte that hold how brightly its face shines
// in HDR output (`gfx/hdr.rs`): 15 minus the tier, plus 4 for one that shines all over
// (`WHOLE`), so the usual 0xFF means none. The byte's high nibble carries the fluid face
// flags (`fluid_face`); the shaders ignore the vertex alpha, so both travel to the
// material stage untouched.
EMISSION_BITS :: 0x0F00_0000
// HDR tiers, by the kind of light rather than its level: a candle's flame is as bright as
// a torch's, it only lights less around it. 0 stays as in SDR.
LOW :: 1
INCANDESCENT :: 2
BRIGHT :: 3
// The sun and lightning.
VERY_BRIGHT :: 4
// Added to a tier: the light source shines all over (a froglight), not only where its
// sprite is brightest (a torch's flame, not its handle). See `gfx/hdr.rs` `Masks`.
WHOLE :: 8
// `color` marked as shining at `tier` (0 to `VERY_BRIGHT`, plus `WHOLE`).
emitting :: proc(color: u32, tier: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let level = (tier & !WHOLE).min(VERY_BRIGHT);
    // rust: let code = if level > 0 && tier & WHOLE != 0 {
    // rust: level + 4
    // rust: } else {
    // rust: level
}
    // rust: color & !EMISSION_BITS | u32::from(15 - code) << 24
}
// The high nibble of `TerrainVertex::color`'s alpha byte: 8 plus the face (`Direction`
// as usize) on a fluid quad, 0xF on every other. `terrain.wgsl` reads only the low nibble
// (the emission), so only the material stage of Horizon's own packs reads it
// (`gfx/native_material.rs`); whether the fluid is water or lava follows from the pass
// that draws it.
FLUID_FACE_BITS :: 0xF000_0000
// `color` marked as a fluid quad of face `face` (`Direction` as usize, 0 to 5).
fluid_face :: proc(color: u32, face: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: debug_assert!(face < 6);
    // rust: color & !FLUID_FACE_BITS | 0x8000_0000 | (face as u32) << 28
}
// The HDR tier of block `name` (no namespace), which emits light `level`.
hdr_tier :: proc(name: string, level: u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: _ if level == 0 => 0,
    // rust: "glowstone"
    // rust: | "soul_lantern"
    // rust: | "soul_torch"
    // rust: | "soul_wall_torch"
    // rust: | "beacon"
    // rust: | "end_rod"
    // rust: | "furnace"
    // rust: | "redstone_lamp"
    // rust: | "brewing_stand"
    // rust: | "enchanting_table"
    // rust: | "medium_amethyst_bud"
    // rust: | "small_amethyst_bud" => BRIGHT,
    // rust: "campfire" | "soul_campfire" | "soul_fire" | "lava_cauldron" | "crying_obsidian"
    // rust: | "amethyst_cluster" | "large_amethyst_bud" => BRIGHT | WHOLE,
    // rust: "torch" | "wall_torch" | "lantern" | "sea_lantern" => INCANDESCENT,
    // rust: "fire" | "lava" => INCANDESCENT | WHOLE,
        // Glowing at every charge, not only the brighter ones.
    // rust: "respawn_anchor" => INCANDESCENT,
    // rust: "ochre_froglight" | "verdant_froglight" | "pearlescent_froglight" | "jack_o_lantern" => {
    // rust: LOW | WHOLE
}
    // rust: "redstone_torch" | "redstone_wall_torch" | "magma_block" | "shroomlight" => LOW,
        // Its flame is a particle; the cake's frosting must not shine in daylight.
    // rust: _ if name.ends_with("candle_cake") => 0,
    // rust: _ if name.ends_with("candle") => LOW,
        // One tier at every oxidation stage, waxed or not.
    // rust: _ if name.ends_with("copper_bulb") => LOW,
        // A faint glow in the dark, as in SDR.
    // rust: "glow_lichen" | "sea_pickle" | "brown_mushroom" | "dragon_egg" | "end_portal_frame"
    // rust: | "ender_chest" => 0,
    // rust: _ if level >= 10 => INCANDESCENT,
    // rust: _ => LOW,
}
}
UNSET :: u32::MAX
NO_BIOME :: u16::MAX
// The `ColorResolver`s `ClientLevel` caches block tints for.
Resolver :: enum {
    Grass,
    Foliage,
    Dry,
    Water,
}
// Biome tints of one block layer: the zoomed biome of every block of the
// layer plus the blend radius around it, and the blended colours per column.
Layer :: struct {
    zoomed: [dynamic]u16,
    // Each resolver's colour of every cell of `zoomed`, filled on first use:
    // a cell is in the blend square of up to `(2r+1)^2` columns.
    cells: [[dynamic]u32,
    // `BiomeZoom::corner_jitter` of the quart cells `zoomed` reaches, by
    // their offset from the first: each is shared by up to 16 cells of the layer.
    jitter: Vec<Option<[[f64,
    colors: [[u32,
}
// `ClientLevel.calculateBlockTint` behind a per-layer `BlockTintCache`: each
// block averages the colours of the biomes `BiomeManager.getBiome` picks (the
// eight-corner zoom) over a `(2r+1)^2` square at the block's own height.
// Layers and columns are only computed when a tinted block asks for them.
Tints :: struct {
    region: ^'a [[Maybe(^'a Chunk),
    biomes: ^'a Biomes,
    zoom: BiomeZoom,
    radius: i32,
    plains: u16,
    // Chunk x, chunk z and the section's lowest block y.
    origin: [i32,
    layers: [Maybe(^Layer),
    // `uniform_biome`, once computed.
    uniform: Maybe(Option<u16)>,
}
    // rust: impl<'a> Tints<'a> {
    // rust: fn new(
    // rust: region: &'a [[Option<&'a Chunk>; 3]; 3],
    // rust: biomes: &'a Biomes,
    // rust: zoom: BiomeZoom,
    // rust: radius: i32,
    // rust: origin: [i32; 3],
    // rust: ) -> Self {
    // rust: Self {
    // rust: region,
    // rust: biomes,
    // rust: zoom,
    // rust: radius: radius.clamp(0, 7),
    // rust: plains: biomes.id("minecraft:plains"),
    // rust: origin,
    // rust: layers: Default::default(),
    // rust: uniform: None,
}
}
    // The biome of block `(x, y, z)` (section-local x/z, y in 0..16), as `BiomeManager.getBiome`
    // picks it.
biome :: proc(self: ^Self, x: i32, y: i32, z: i32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let id = Self::biome_id(&self.zoom, self.region, self.plains, self.origin, [x, y, z]);
    // rust: &self.biomes.get(id).name
}
    // `BiomeManager.getBiome` over the loaded chunks (plains where there is none), for block
    // `(x, y, z)` of the section at `origin`. Takes the fields it reads, so `get` can call it
    // while it holds a layer.
    // rust: fn biome_id(
    // rust: zoom: &BiomeZoom,
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: plains: u16,
    // rust: [cx, cz, base_y]: [i32; 3],
    // rust: [x, y, z]: [i32; 3],
    // rust: ) -> u16 {
    // rust: let q = zoom.quart_at_block(BlockPos::new(cx * 16 + x, base_y + y, cz * 16 + z));
    // rust: Self::quart_biome(region, plains, [cx, cz], q)
}
    // The biome of quart cell `q` in the loaded chunks around chunk `(cx, cz)`, plains where
    // there is none.
    // rust: fn quart_biome(
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: plains: u16,
    // rust: [cx, cz]: [i32; 2],
    // rust: q: [i32; 3],
    // rust: ) -> u16 {
    // rust: let (rx, rz) = ((q[0] >> 2) - cx + 1, (q[2] >> 2) - cz + 1);
    // rust: if (0..3).contains(&rx) && (0..3).contains(&rz) {
    // rust: region[rz as usize][rx as usize].map_or(plains, |c| {
    // rust: c.biome((q[0] & 3) * 4, q[1] * 4, (q[2] & 3) * 4)
    // rust: })
    // rust: } else {
    // rust: plains
}
}
    // The biome every block of the section's blend squares zooms to, when they
    // all do: `quart_at_block` picks one of the eight quart cells at its base
    // cell plus 0 or 1 on each axis, so if every such cell the section reaches
    // holds one biome, every zoomed cell is that biome.
uniform_biome :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(uniform) = self.uniform {
    // rust: return uniform;
}
    // rust: let (r, [cx, cz, base_y]) = (self.radius, self.origin);
        // The base cells of blocks lo..=hi, and the cell past the last.
    // rust: let span = |lo: i32, hi: i32| (lo.wrapping_sub(2) >> 2)..=(hi.wrapping_sub(2) >> 2) + 1;
    // rust: let (xs, ys, zs) = (
    // rust: span(cx * 16 - r, cx * 16 + 15 + r),
    // rust: span(base_y, base_y + 15),
    // rust: span(cz * 16 - r, cz * 16 + 15 + r),
    // rust: );
    // rust: let first = Self::quart_biome(
    // rust: self.region,
    // rust: self.plains,
    // rust: [cx, cz],
    // rust: [*xs.start(), *ys.start(), *zs.start()],
    // rust: );
    // rust: let uniform = ys
    // rust: .flat_map(|y| zs.clone().map(move |z| (y, z)))
    // rust: .flat_map(|(y, z)| xs.clone().map(move |x| [x, y, z]))
    // rust: .all(|q| Self::quart_biome(self.region, self.plains, [cx, cz], q) == first)
    // rust: .then_some(first);
    // rust: self.uniform = Some(uniform);
    // rust: uniform
}
    // The blended tint of block `(x, y, z)` (section-local x/z, y in 0..16).
get :: proc(self: ^Self, resolver: Resolver, x: i32, y: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
        // One biome over every blend square: the mean of (2r+1)^2 equal
        // colours is that colour, unless it varies by position (swamp grass).
    // rust: if let Some(biome) = self.uniform_biome() {
    // rust: let info = self.biomes.get(biome);
    // rust: match resolver {
    // rust: Resolver::Grass if !matches!(info.modifier, GrassModifier::Swamp) => {
    // rust: return self.biomes.grass(biome, 0.0, 0.0) & 0xFF_FFFF;
}
    // rust: Resolver::Grass => {}
    // rust: Resolver::Foliage => return info.foliage & 0xFF_FFFF,
    // rust: Resolver::Dry => return info.dry_foliage & 0xFF_FFFF,
    // rust: Resolver::Water => return info.water & 0xFF_FFFF,
}
}
    // rust: let r = self.radius;
    // rust: let dim = (16 + 2 * r) as usize;
    // rust: let layer = self.layers[y as usize].get_or_insert_with(|| {
    // rust: Box::new(Layer {
    // rust: zoomed: vec![NO_BIOME; dim * dim],
    // rust: cells: Default::default(),
    // rust: jitter: Vec::new(),
    // rust: colors: [[UNSET; 256]; 4],
    // rust: })
    // rust: });
    // rust: let slot = (z * 16 + x) as usize;
    // rust: let cached = layer.colors[resolver as usize][slot];
    // rust: if cached != UNSET {
    // rust: return cached;
}
    // rust: let [cx, cz, base_y] = self.origin;
    // rust: let (bx, by, bz) = (cx * 16, base_y + y, cz * 16);
    // rust: let (mut red, mut green, mut blue) = (0, 0, 0);
    // rust: let cells = &mut layer.cells[resolver as usize];
    // rust: if cells.is_empty() {
    // rust: cells.resize(dim * dim, UNSET);
}
    // rust: for dz in -r..=r {
    // rust: for dx in -r..=r {
    // rust: let cell = ((z + dz + r) as usize) * dim + (x + dx + r) as usize;
    // rust: let known = cells[cell];
    // rust: if known != UNSET {
    // rust: red += known >> 16 & 255;
    // rust: green += known >> 8 & 255;
    // rust: blue += known & 255;
    // rust: continue;
}
    // rust: let mut biome = layer.zoomed[cell];
    // rust: if biome == NO_BIOME {
                    // BiomeManager.getBiome over the loaded chunks (plains
                    // where there is none): `quart_at_block`, its cell's
                    // corner jitter mixed once per layer.
    // rust: let block = BlockPos::new(bx + x + dx, by, bz + z + dz);
    // rust: let base = [block.x, block.y, block.z].map(|v| v.wrapping_sub(2) >> 2);
    // rust: let first = [bx - r, bz - r].map(|v| v.wrapping_sub(2) >> 2);
    // rust: let span = dim / 4 + 2;
    // rust: let at = (base[2] - first[1]) as usize * span + (base[0] - first[0]) as usize;
    // rust: if layer.jitter.is_empty() {
    // rust: layer.jitter.resize(span * span, None);
}
    // rust: let jitter =
    // rust: layer.jitter[at].get_or_insert_with(|| self.zoom.corner_jitter(base));
    // rust: let corner = BiomeZoom::select_corner(block, jitter);
    // rust: let q = [
    // rust: base[0].wrapping_add((corner >> 2 & 1) as i32),
    // rust: base[1].wrapping_add((corner >> 1 & 1) as i32),
    // rust: base[2].wrapping_add((corner & 1) as i32),
    // rust: ];
    // rust: biome = Self::quart_biome(self.region, self.plains, [cx, cz], q);
    // rust: layer.zoomed[cell] = biome;
}
    // rust: let c = match resolver {
    // rust: Resolver::Grass => {
    // rust: self.biomes
    // rust: .grass(biome, f64::from(bx + x + dx), f64::from(bz + z + dz))
}
    // rust: Resolver::Foliage => self.biomes.get(biome).foliage,
    // rust: Resolver::Dry => self.biomes.get(biome).dry_foliage,
    // rust: Resolver::Water => self.biomes.get(biome).water,
}
    // rust: cells[cell] = c;
    // rust: red += c >> 16 & 255;
    // rust: green += c >> 8 & 255;
    // rust: blue += c & 255;
}
}
    // rust: let n = ((2 * r + 1) * (2 * r + 1)) as u32;
    // rust: let color = (red / n) << 16 | (green / n) << 8 | (blue / n);
    // rust: layer.colors[resolver as usize][slot] = color;
    // rust: color
}
}
// Packs 8-bit RGB into the vertex's RGBA8 (red in the low byte), opaque.
pack_rgb :: proc(b]: [u32; 3]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0xFF00_0000 | b << 16 | g << 8 | r
}
// Vanilla light coords (block*16 in the low half, sky*16 in the high half) to
// the vertex layout (sky*16 in bits 0..8, block*16 in bits 8..16).
pack_coords :: proc(coords: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((coords >> 16 & 0xFF) | (coords & 0xFF) << 8) as u16
}
Mesher :: struct {
    // CardinalLighting.NETHER: brighter up/down faces.
    nether_shading: bool,
    // A shader pack lights the faces (its `oldLighting` off): no face shading in the colours,
    // only the dimension's up-face brightness (`lighting::pack_flat`).
    shader_pack_lighting: bool,
    // OptiFine/Iris separate ambient occlusion: vertex RGB does not include AO, and AO factor is passed in vertex alpha.
    separate_ao: bool,
    // A `shaders/` pack draws the terrain (with or without its `oldLighting`): fluid tops are
    // split into triangles as Iris splits them (`fluid::splits_north_east`).
    shader_pack: bool,
    assets: ^'a Assets,
    render: ^'a RenderAssets,
    tables: ^'a MeshTables,
    biomes: ^'a Biomes,
    visibility: FaceVisibility,
    // The client's biome zoom (the hashed world seed `BiomeManager` holds).
    zoom: BiomeZoom,
    // The `biomeBlendRadius` option, 0 to 7.
    blend_radius: i32,
    // The `ao` option: smooth lighting for models that allow it.
    smooth_lighting: bool,
    // The `cutoutLeaves` option (fancy graphics); off makes leaves opaque.
    cutout_leaves: bool,
    // Sprite layers a shader pack moves into the translucent pass, by layer.
    translucent_layers: ^'a [bool],
    // What the worker does with leaf faces inside a canopy.
    leaf_culling: LeafCullingMode,
}
    // rust: impl Mesher<'_> {
    // `region[dz][dx]` are the chunks around the meshed column (centre 1,1).
mesh :: proc(self: ^Self, region: ^[[Maybe(^Chunk); 3]; 3], sy: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.mesh_reusing(
    // rust: region,
    // rust: sy,
    // rust: SectionMesh::default(),
    // rust: &mut MeshScratch::default(),
    // rust: )
}
    // The meshing workers' path: `out`'s buffers and `scratch` are reused
    // rather than allocated per section.
    // rust: pub fn mesh_reusing(
    // rust: &mut self,
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: sy: i32,
    // rust: mut out: SectionMesh,
    // rust: scratch: &mut MeshScratch,
    // rust: ) -> SectionMesh {
    // rust: out.clear();
    // rust: let center = region[1][1].expect("centre chunk");
    // rust: let section = &center.sections[sy as usize];
    // rust: if section.is_uniform(0) {
    // rust: return out;
}
    // rust: let own = scratch.own.get_or_insert_with(|| Box::new([0; 4096]));
    // rust: scratch.padded.fill(region, sy, own);
    // rust: let pad = &scratch.padded;
    // rust: solid_rows(pad, &self.tables.solid, &mut scratch.solid_rows);
    // rust: let opaque = &scratch.solid_rows;
    // rust: out.visibility = visibility_rows(&open_rows(opaque));
    // rust: let base_y = center.min_y() + sy * 16;
    // rust: if self.leaf_culling.is_interior() {
    // rust: scratch
    // rust: .leaf
    // rust: .prepare(self.leaf_culling, pad, &self.tables.info, region, base_y);
}
    // rust: let mut tints = Tints::new(
    // rust: region,
    // rust: self.biomes,
    // rust: self.zoom,
    // rust: self.blend_radius,
    // rust: [center.x, center.z, base_y],
    // rust: );
    // rust: let info = &self.tables.info;
    // rust: let full_faces = &self.tables.full_faces;
    // rust: let catalog = &self.render.model_catalog;
    // rust: let mut models = Vec::new();
    // rust: for y in 0..16 {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let id = pad.blocks[pi(x, y, z)];
    // rust: if id == 0 {
    // rust: continue;
}
    // rust: let state = &info[id as usize];
    // rust: if state.block_entity {
    // rust: out.block_entities
    // rust: .push(([center.x * 16 + x, base_y + y, center.z * 16 + z], id));
}
    // rust: if state.emission > 0 {
    // rust: out.lights
    // rust: .push(([center.x * 16 + x, base_y + y, center.z * 16 + z], id));
}
    // rust: if hidden(opaque, x, y, z) {
    // rust: continue;
}
    // rust: if state.fluid.kind() != FluidKind::Empty {
    // rust: let water = tints.get(Resolver::Water, x, y, z);
    // rust: let shade = (
    // rust: self.nether_shading,
    // rust: self.shader_pack_lighting,
    // rust: self.separate_ao,
    // rust: self.shader_pack,
    // rust: );
    // rust: fluid::tesselate(self.tables, shade, pad, water, &mut out, [x, y, z]);
}
    // rust: if !state.model {
    // rust: continue;
}
    // rust: let world = BlockPos::new(center.x * 16 + x, base_y + y, center.z * 16 + z);
    // rust: if catalog
    // rust: .models_at(BlockStateId(id), world, &mut models)
    // rust: .is_err()
    // rust: {
    // rust: continue;
}
                    // ModelBlockRenderer: the first part decides smooth lighting
                    // for all; light-emitting blocks are always lit flat.
    // rust: let Some(first) = models.first() else {
    // rust: continue;
}
    // rust: let ao = self.smooth_lighting && state.emission == 0 && first.ambient_occlusion;
    // rust: let origin = match offset(state, world.x, world.z) {
    // rust: Some(o) => [
    // rust: x as f32 + o[0] as f32,
    // rust: y as f32 + o[1] as f32,
    // rust: z as f32 + o[2] as f32,
    // rust: ],
    // rust: None => [x as f32, y as f32, z as f32],
}
    // rust: let mut visible = [false; 6];
    // rust: let interior_leaf = state.leaves
    // rust: && self.leaf_culling.is_interior()
    // rust: && scratch.leaf.interior(self.leaf_culling, x, y, z);
    // rust: for d in Direction::ALL {
    // rust: let [dx, dy, dz] = d.normal();
    // rust: let neighbor = pad.blocks[pi(x + dx, y + dy, z + dz)];
                        // `should_render_face`'s first test, without its lookups: a
                        // full occlusion face toward this block hides the face.
    // rust: if full_faces[neighbor as usize] >> d.opposite() as u8 & 1 != 0 {
    // rust: continue;
}
    // rust: let other = &info[neighbor as usize];
                        // LeavesBlock.skipRendering with opaque leaves.
    // rust: let opaque_leaves = !self.cutout_leaves && state.leaves && other.leaves;
    // rust: let culled_leaf = match self.leaf_culling {
    // rust: LeafCullingMode::Hollow | LeafCullingMode::Hidden => {
    // rust: state.leaves
    // rust: && other.leaves
    // rust: && leaf_culling::in_section(x + dx, y + dy, z + dz)
    // rust: && (self.leaf_culling == LeafCullingMode::Hollow
    // rust: || leaf_culling::backed(
    // rust: pad,
    // rust: info,
    // rust: region,
    // rust: base_y,
    // rust: [x + 2 * dx, y + 2 * dy, z + 2 * dz],
    // rust: ))
}
    // rust: _ => false,
}
    // rust: visible[d as usize] = !opaque_leaves
    // rust: && !culled_leaf
    // rust: && self
    // rust: .visibility
    // rust: .should_render_face(
    // rust: BlockStateId(id),
    // rust: BlockStateId(neighbor),
    // rust: d,
    // rust: true,
    // rust: )
    // rust: .unwrap_or(true);
}
    // rust: let connected = &self.render.connected;
    // rust: for model in &models {
    // rust: for face in &model.faces {
    // rust: if face.quad.cull.is_some_and(|d| !visible[d as usize]) {
    // rust: continue;
}
                            // A pane's top and bottom strips between stacked panes, with
                            // connected textures.
    // rust: if state.pane
    // rust: && !connected.is_empty()
    // rust: && let Some(dy) = match face.quad.facing {
    // rust: ModelDirection::Up => Some(1),
    // rust: ModelDirection::Down => Some(-1),
    // rust: _ => None,
}
    // rust: {
    // rust: let p = &face.quad.positions;
                                // Only on the block's top or bottom plane: a pack's own pane
                                // model may have ledges between.
    // rust: let plane = if dy > 0 { 1.0 } else { 0.0 };
    // rust: let on_edge = p.iter().all(|v| (v[1] - plane).abs() < 1e-4);
    // rust: let centre =
    // rust: [0, 2].map(|k| p.iter().map(|v| v[k]).sum::<f32>() / 4.0);
    // rust: let other = pad.blocks[pi(x, y + dy, z)];
    // rust: if on_edge && connected.stacked_pane_hides(id, other, centre) {
    // rust: continue;
}
}
    // rust: self.face(
    // rust: pad,
    // rust: &mut tints,
    // rust: &mut out,
    // rust: [x, y, z],
    // rust: origin,
    // rust: face,
    // rust: ao,
    // rust: (id, state),
    // rust: world,
    // rust: interior_leaf,
    // rust: );
}
}
}
}
}
    // rust: out.finish_sprite_layers();
    // rust: out
}
    // `BlockColors` tint source `index`, or `None` for an untinted (-1) layer.
tint :: proc(state: ^Info, index: i32, tints: ^Tints, z]: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if index < 0 || index >= i32::from(state.tint_count) {
    // rust: return None;
}
    // rust: Some(match state.tints[(index as usize).min(1)] {
    // rust: Tint::None => return None,
    // rust: Tint::Grass | Tint::GrassBlock | Tint::SugarCane => tints.get(Resolver::Grass, x, y, z),
    // rust: Tint::TallGrassUpper => tints.get(Resolver::Grass, x, y, z),
    // rust: Tint::Foliage => tints.get(Resolver::Foliage, x, y, z),
    // rust: Tint::DryFoliage => tints.get(Resolver::Dry, x, y, z),
    // rust: Tint::Water => tints.get(Resolver::Water, x, y, z),
    // rust: Tint::Constant(c) => c,
    // rust: Tint::LilyPad => 0x20_8030,
    // rust: Tint::Redstone(p) => redstone_color(p),
    // rust: Tint::Stem(age) => stem_color(age),
    // rust: })
}
    // rust: fn face(
    // rust: &self,
    // rust: pad: &Padded,
    // rust: tints: &mut Tints,
    // rust: out: &mut SectionMesh,
    // rust: pos: [i32; 3],
    // rust: origin: [f32; 3],
    // rust: face: &BakedFace,
    // rust: ao: bool,
    // rust: (id, state): (u32, &Info),
    // rust: world: BlockPos,
    // rust: interior_leaf: bool,
    // rust: ) {
    // rust: let q = &face.quad;
        // A quad's own light (a model's glowing part) may raise the tier; whether it
        // shines all over stays the block's.
    // rust: let tier = (state.tier & !WHOLE).max(hdr_tier("", q.light[0])) | state.tier & WHOLE;
        // A quad's `neoforge_data` ambient occlusion replaces the model's; glowing blocks stay flat.
    // rust: let ao = match q.ambient_occlusion {
    // rust: Some(on) => on && self.smooth_lighting && state.emission == 0,
    // rust: None => ao,
}
    // rust: let shade_face = q.shade_direction_override.unwrap_or(q.facing);
    // rust: let directional = if !q.shade {
    // rust: 1.0
    // rust: } else if self.shader_pack_lighting {
    // rust: lighting::pack_flat(self.nether_shading)
    // rust: } else {
    // rust: lighting::cardinal(self.nether_shading, shade_face)
}
        // Grey level per vertex before tinting, vanilla light coords, and ambient occlusion factor.
    // rust: let (gray, coords, ao_factor) = if ao {
    // rust: let info = &self.tables.info;
    // rust: let (brightness, coords) =
    // rust: lighting::ambient_occlusion(pad, info, state, pos, &q.positions, q.facing);
    // rust: let gray = if self.separate_ao {
    // rust: [lighting::gray(directional); 4]
    // rust: } else {
    // rust: brightness.map(|b| lighting::scale(lighting::gray(b), directional))
}
    // rust: (gray, coords, brightness)
    // rust: } else {
    // rust: let coords = match q.cull {
    // rust: Some(d) => lighting::coords(pad, state, lighting::step(pos, d)),
    // rust: None => lighting::flat(pad, state, pos, &q.positions, q.facing),
}
    // rust: ([lighting::gray(directional); 4], [coords; 4], [1.0f32; 4])
}
    // rust: let tint = Self::tint(state, q.tint_index, tints, pos);
    // rust: let tint = match q.color {
    // rust: Some(c) => {
    // rust: let t = tint.unwrap_or(0xFF_FFFF);
    // rust: let channel = |s: u32| (t >> s & 255) * (c as u32 >> s & 255) / 255;
    // rust: Some(channel(16) << 16 | channel(8) << 8 | channel(0))
}
    // rust: None => tint,
}
        // Fusion's and then OptiFine's connected textures: another sprite, or one per quarter,
        // and the overlays drawn over it (a few per face at most; more are dropped).
    // rust: let (fusion, connected) = (&self.render.fusion, &self.render.connected);
    // rust: let mut overlays = [None; 8];
    // rust: let mut count = 0;
    // rust: let mut push = |overlay| {
    // rust: if let Some(slot) = overlays.get_mut(count) {
    // rust: *slot = Some(overlay);
    // rust: count += 1;
}
}
    // rust: let neighbour =
    // rust: |[dx, dy, dz]: [i32; 3]| pad.blocks[pi(pos[0] + dx, pos[1] + dy, pos[2] + dz)];
    // rust: let fused = face.fusion.and_then(|rule| {
    // rust: fusion.pick(
    // rust: rule,
    // rust: id,
    // rust: CtmFace::ALL[q.facing as usize],
    // rust: q.tint_index,
    // rust: neighbour,
    // rust: |s| {
    // rust: self.tables
    // rust: .info
    // rust: .get(s as usize)
    // rust: .is_some_and(|i| i.opaque_cube)
    // rust: },
    // rust: &mut push,
    // rust: )
    // rust: });
    // rust: let pick = if let Some(pick) = fused {
    // rust: pick
    // rust: } else if connected.is_empty() {
    // rust: Pick::Keep
    // rust: } else {
    // rust: let tints = &*tints;
    // rust: connected.pick(
    // rust: id,
    // rust: face.layer as u16,
    // rust: CtmFace::ALL[q.facing as usize],
    // rust: [world.x, world.y, world.z],
    // rust: neighbour,
    // rust: || Some(tints.biome(pos[0], pos[1], pos[2])),
                // A pane's tiles are drawn with the cube's UVs (below), so that is its texture.
    // rust: || {
    // rust: if state.pane {
    // rust: Some(CtmAxes::cube(CtmFace::ALL[q.facing as usize]))
    // rust: } else {
    // rust: CtmAxes::texture(&q.positions, &q.uv)
}
    // rust: },
    // rust: &mut push,
    // rust: )
}
    // rust: let vertices = |tint: Option<u32>, uv: [[f32; 2]; 4]| {
    // rust: std::array::from_fn::<_, 4, _>(|i| {
    // rust: let g = gray[i] as u32;
    // rust: let rgb = match tint {
    // rust: Some(t) => [16, 8, 0].map(|shift| g * (t >> shift & 255) / 255),
    // rust: None => [g; 3],
}
    // rust: let p = q.positions[i];
    // rust: let color = if self.separate_ao {
    // rust: let ao_byte = (ao_factor[i] * 255.0).round().clamp(0.0, 255.0) as u32;
    // rust: ao_byte << 24 | (pack_rgb(rgb) & 0x00FF_FFFF)
    // rust: } else {
    // rust: emitting(pack_rgb(rgb), tier)
}
    // rust: (
    // rust: TerrainVertex::new(
    // rust: [p[0] + origin[0], p[1] + origin[1], p[2] + origin[2]],
    // rust: uv[i],
    // rust: 0,
    // rust: color,
    // rust: pack_coords(lighting::with_min(coords[i], q.light)),
    // rust: ),
    // rust: uv[i],
    // rust: )
    // rust: })
}
        // Vanilla's pane models mirror some faces' textures; OptiFine's don't, so a tile's borders
        // land where the neighbours are: on a pane, tiles take the cube's own UVs.
    // rust: let standard = || q.positions.map(|p| standard_uv(q.facing, p));
    // rust: let tiled = !matches!(pick, Pick::Keep);
    // rust: let corners = vertices(
    // rust: tint,
    // rust: if state.pane && tiled {
    // rust: standard()
    // rust: } else {
    // rust: q.uv
    // rust: },
    // rust: );
        // Opaque leaves (forceOpaque) and leaves a leaf-culling mode proved internal draw in the
        // solid layer whatever their sprite.
    // rust: let solid_leaves = !self.cutout_leaves && state.leaves || interior_leaf;
    // rust: let own = TileLayer::Layer {
    // rust: layer: face.layer as u16,
    // rust: translucent: face.translucent,
    // rust: opaque: face.opaque,
}
        // A tile keeps the quad's forced translucency; `<skip>` and `<default>` are its own.
    // rust: let tile = |t: TileLayer| match t {
    // rust: TileLayer::Layer {
    // rust: layer,
    // rust: translucent,
    // rust: opaque,
    // rust: } => TileLayer::Layer {
    // rust: layer,
    // rust: translucent: translucent || q.render_type.is_none() && q.material.force_translucent,
    // rust: opaque,
    // rust: },
    // rust: TileLayer::Skip | TileLayer::Default => own,
}
    // rust: match pick {
    // rust: Pick::Keep => self.quad(out, solid_leaves, own, corners.map(|c| c.0), tint),
    // rust: Pick::Tile(t) => self.quad(out, solid_leaves, tile(t), corners.map(|c| c.0), tint),
    // rust: Pick::Quarters(tiles) => {
    // rust: let cuts = cuts(&corners);
    // rust: for s in cuts.windows(2) {
    // rust: for t in cuts.windows(2) {
    // rust: let piece = [(s[0], t[0]), (s[1], t[0]), (s[1], t[1]), (s[0], t[1])]
    // rust: .map(|(s, t)| bilinear(&corners, s, t));
    // rust: let quarter = quarter_of(&piece);
    // rust: let piece = piece.map(|c| c.0);
    // rust: self.quad(out, solid_leaves, tile(tiles[quarter]), piece, tint);
}
}
}
    // rust: Pick::Nothing => {}
}
        // Overlays: the face again, after it (equal depth passes), tinted as their rule says.
        // `layer=cutout` is an alpha cutout whatever the tile's alpha, but over a translucent
        // face it must be in the translucent pass too, or the face would draw over it.
        // Most faces have none: nothing below runs for them.
    // rust: if count == 0 {
    // rust: return;
}
    // rust: let face_translucent = match pick {
    // rust: Pick::Keep => self.translucent(own),
    // rust: Pick::Tile(t) => self.translucent(tile(t)),
    // rust: Pick::Quarters(tiles) => tiles.into_iter().any(|t| self.translucent(tile(t))),
    // rust: Pick::Nothing => false,
}
        // Overlay tiles face the standard way too (Continuity: "overlay textures always have the
        // standard orientation"), whatever turns the model's own UVs (dirt's and sand's random
        // rotations).
        // Over a `ctm_compact` face, the same pieces: the same depths and sort centres.
    // rust: let cuts = match pick {
    // rust: Pick::Quarters(_) => cuts(&corners),
    // rust: _ => Cuts([0.0, 1.0, 1.0, 1.0], 2),
}
    // rust: for overlay in overlays[..count].iter().flatten().copied() {
    // rust: let tint = overlay.tint.and_then(|(index, block)| {
    // rust: let info = block
    // rust: .and_then(|b| self.tables.info.get(b as usize))
    // rust: .unwrap_or(state);
    // rust: Self::tint(info, index, tints, pos)
    // rust: });
    // rust: let tile = TileLayer::Layer {
    // rust: layer: overlay.layer,
    // rust: translucent: overlay.translucent || face_translucent,
    // rust: opaque: false,
}
    // rust: let whole = vertices(tint, standard());
    // rust: for s in cuts.windows(2) {
    // rust: for t in cuts.windows(2) {
    // rust: let piece = [(s[0], t[0]), (s[1], t[0]), (s[1], t[1]), (s[0], t[1])]
    // rust: .map(|(s, t)| bilinear(&whole, s, t).0);
    // rust: self.quad_as(out, false, tile, piece, false, tint);
}
}
}
}
    // One terrain quad with sprite `tile`, in the pass its alpha needs (`solid_leaves`: no
    // alpha cutout whatever the sprite).
    // rust: fn quad(
    // rust: &self,
    // rust: out: &mut SectionMesh,
    // rust: solid_leaves: bool,
    // rust: tile: TileLayer,
    // rust: v: [TerrainVertex; 4],
    // rust: tint: Option<u32>,
    // rust: ) {
    // rust: self.quad_as(out, solid_leaves, tile, v, true, tint);
}
    // Whether [`Mesher::quad`] draws `tile` in the translucent pass.
translucent :: proc(self: ^Self, tile: TileLayer) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match tile {
    // rust: TileLayer::Layer {
    // rust: layer, translucent, ..
    // rust: } => {
    // rust: translucent
    // rust: || self
    // rust: .translucent_layers
    // rust: .get(usize::from(layer))
    // rust: .copied()
    // rust: .unwrap_or(false)
}
    // rust: TileLayer::Skip | TileLayer::Default => false,
}
}
    // [`Mesher::quad`], with the sprite's own translucency (`translucent_layers`) counted only
    // when `by_sprite`: an overlay's pass is its rule's. `tint`: what its grey levels were
    // multiplied by, for the compact layout (`packed`).
    // rust: fn quad_as(
    // rust: &self,
    // rust: out: &mut SectionMesh,
    // rust: solid_leaves: bool,
    // rust: tile: TileLayer,
    // rust: mut v: [TerrainVertex; 4],
    // rust: by_sprite: bool,
    // rust: tint: Option<u32>,
    // rust: ) {
    // rust: let TileLayer::Layer {
    // rust: layer,
    // rust: translucent,
    // rust: opaque,
    // rust: } = tile
    // rust: else {
    // rust: return;
}
    // rust: if self.tables.is_animated(layer) {
    // rust: out.note_sprite_layer(layer);
}
    // rust: let translucent = if by_sprite {
    // rust: self.translucent(tile)
    // rust: } else {
    // rust: translucent
}
        // Quads over opaque texels draw in the solid layer: no alpha cutout (a dirt path's side
        // skips its clear top row). All four vertices share the layer.
    // rust: let layer = if opaque && !translucent || solid_leaves {
    // rust: layer | OPAQUE_LAYER
    // rust: } else {
    // rust: layer
}
    // rust: let target = if translucent {
    // rust: &mut out.translucent
    // rust: } else {
    // rust: &mut out.solid
}
    // rust: for vertex in &mut v {
    // rust: vertex.layer = layer;
}
    // rust: target.extend(v);
    // rust: if !translucent {
            // Quads other code put in `solid` (lava) have no tint known.
    // rust: let quad = out.solid.len() / 4 - 1;
    // rust: out.solid_tints.resize(quad, packed::UNKNOWN_TINT);
    // rust: out.solid_tints.push(tint.unwrap_or(packed::WHITE));
}
}
}
// The cuts of a `ctm_compact` face, in quad parameters, without allocating: the first `.1`
// of `.0`.
Cuts :: struct {
    // rust: impl std::ops::Deref for Cuts {
    // rust: type Target = [f32];
deref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.0[..self.1]
}
}
// Where a quad's edge from corner 0 to corner `to` (1 for `s`, 3 for `t`) crosses the sprite's
// middle line, the line its quarters meet on; `None` for an edge that stays on one side (a
// slab's side).
crossing :: proc(c: ^[(TerrainVertex) {
}
    // rust: let (a, b) = (c[0].1, c[to].1);
    // The UV the edge runs along.
    // rust: let k = usize::from((b[1] - a[1]).abs() > (b[0] - a[0]).abs());
    // rust: let at = (0.5 - a[k]) / (b[k] - a[k]);
    // rust: (at > 0.0 && at < 1.0).then_some(at)
}
// The cuts of a `ctm_compact` face, the same along `s` and `t`: both edges' crossings. Pieces
// on the quad's 0-2 diagonal are then square, so their own triangles lie on the quad's and a
// split face shades exactly like the whole one; the others lie on one side of it.
cuts :: proc(c: ^[(TerrainVertex) {
}
    // rust: let mut out = Cuts([0.0; 4], 1);
    // rust: let (mut s, mut t) = (crossing(c, 1), crossing(c, 3));
    // rust: if s > t {
    // rust: std::mem::swap(&mut s, &mut t);
}
    // rust: for at in [s, t].into_iter().flatten().chain([1.0]) {
    // rust: if out.0[out.1 - 1] < at {
    // rust: out.0[out.1] = at;
    // rust: out.1 += 1;
}
}
    // rust: out
}
// The UV a vanilla cube's face gives the block-local point `p` (`BlockElement`'s default UVs),
// in sprite units: up is north on the top face, south on the bottom one, and up on the sides.
standard_uv :: proc(facing: horizon_assets::model::Direction, z]: [f32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
//     use horizon_assets::model::Direction as D;
    // rust: match facing {
    // rust: D::Down => [x, 1.0 - z],
    // rust: D::Up => [x, z],
    // rust: D::North => [1.0 - x, 1.0 - y],
    // rust: D::South => [x, 1.0 - y],
    // rust: D::West => [z, 1.0 - y],
    // rust: D::East => [1.0 - z, 1.0 - y],
}
}
// The quarter of the sprite (top-left, top-right, bottom-left, bottom-right) a piece of a
// quad lies in, by its UV centre (v grows downward).
quarter_of :: proc(piece: ^[(TerrainVertex) {
}
    // rust: let [u, v] = [0, 1].map(|k| piece.iter().map(|c| c.1[k]).sum::<f32>() / 4.0);
    // rust: usize::from(v >= 0.5) * 2 + usize::from(u >= 0.5)
}
// The vertex at `(s, t)` across a quad's corners (`s` from corner 0 to 1, `t` from 0 to 3),
// with its UV in sprite units: a quarter of a `ctm_compact` face. Blended within the quad's
// two triangles (0-1-2 and 0-2-3), as the GPU blends the whole quad, so a split face shades
// like an unsplit one.
bilinear :: proc(c: ^[(TerrainVertex) {
}
    // rust: let w = if s >= t {
    // rust: [1.0 - s, s - t, t, 0.0]
    // rust: } else {
    // rust: [1.0 - t, 0.0, s, t - s]
}
    // rust: let mix = |f: &dyn Fn(&(TerrainVertex, [f32; 2])) -> f32| {
    // rust: (0..4).map(|i| w[i] * f(&c[i])).sum::<f32>()
}
    // Packed bytes (colour, light) blend one by one.
    // rust: let bytes = |field: fn(&TerrainVertex) -> u32, count: u32| {
    // rust: (0..count)
    // rust: .map(|k| (mix(&|c| (field(&c.0) >> (8 * k) & 255) as f32).round() as u32) << (8 * k))
    // rust: .sum::<u32>()
}
    // rust: let color = bytes(|v| v.color, 4);
    // rust: let light = bytes(|v| u32::from(v.light), 2) as u16;
    // rust: let pos = [0, 1, 2].map(|k| mix(&|c| c.0.pos[k]));
    // rust: let uv = [0, 1].map(|k| mix(&|c| c.1[k]));
    // rust: (TerrainVertex::new(pos, uv, 0, color, light), uv)
}
// Snapshot of the 3x3 chunk neighbourhood used by a worker job.
    // rust: pub type Region = [[Option<Arc<Chunk>>; 3]; 3];
borrow :: proc(region: ^Region) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|z| std::array::from_fn(|x| region[z][x].as_deref()))
}
    // rust: mod quarter_tests {
//     use super::*;

corner :: proc(pos: [f32; 3], uv: [f32; 2], red: u32, light: u16) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (TerrainVertex::new(pos, uv, 0, 0xFF00_0000 | red, light), uv)
}

quarters_blend_the_corners_by_triangle :: proc() {
}
        // Only corner 2 is lit: the GPU's triangles (0-1-2, 0-2-3) put half of it in the
        // middle, where a bilinear blend would put a quarter and the other diagonal none.
    // rust: let c = [
    // rust: corner([0.0, 0.0, 0.0], [0.0, 0.0], 0, 0),
    // rust: corner([1.0, 0.0, 0.0], [1.0, 0.0], 0, 0),
    // rust: corner([1.0, 1.0, 0.0], [1.0, 1.0], 200, 0x2010),
    // rust: corner([0.0, 1.0, 0.0], [0.0, 1.0], 0, 0),
    // rust: ];
    // rust: let (centre, uv) = bilinear(&c, 0.5, 0.5);
    // rust: assert_eq!(centre.pos, [0.5, 0.5, 0.0]);
    // rust: assert_eq!(uv, [0.5, 0.5]);
    // rust: assert_eq!(centre.color, 0xFF00_0000 | 100);
    // rust: assert_eq!(centre.light, 0x1008, "sky and block light blend apart");
        // Off the diagonal, on the 0-1-2 triangle: corner 2 weighs t.
    // rust: assert_eq!(bilinear(&c, 0.75, 0.25).0.color & 255, 50);
    // rust: assert_eq!(bilinear(&c, 0.5, 0.0).0.pos, [0.5, 0.0, 0.0]);
}

compact_faces_cut_where_the_sprite_does :: proc() {
}
        // A full face: cut in the middle both ways.
    // rust: let full = [
    // rust: corner([0.0, 1.0, 0.0], [0.0, 0.0], 0, 0),
    // rust: corner([1.0, 1.0, 0.0], [1.0, 0.0], 0, 0),
    // rust: corner([1.0, 0.0, 0.0], [1.0, 1.0], 0, 0),
    // rust: corner([0.0, 0.0, 0.0], [0.0, 1.0], 0, 0),
    // rust: ];
    // rust: assert_eq!(*cuts(&full), [0.0, 0.5, 1.0]);
        // A dirt path's side, v from 1/16: the sprite's middle is 7/15 of the way down; both
        // directions are cut there and at the middle of u.
    // rust: let mut path = full;
    // rust: path[0].1 = [0.0, 1.0 / 16.0];
    // rust: path[1].1 = [1.0, 1.0 / 16.0];
    // rust: assert_eq!(
    // rust: *cuts(&path),
    // rust: [0.0, (0.5 - 1.0 / 16.0) / (15.0 / 16.0), 0.5, 1.0]
    // rust: );
        // A slab's lower side (v 0.5..1) crosses the middle only along u.
    // rust: let mut slab = full;
    // rust: slab[0].1 = [0.0, 0.5];
    // rust: slab[1].1 = [1.0, 0.5];
    // rust: assert_eq!(crossing(&slab, 3), None);
    // rust: assert_eq!(*cuts(&slab), [0.0, 0.5, 1.0]);
        // Quarters by UV centre: top-left, top-right, bottom-left, bottom-right.
    // rust: let piece = |s0: f32, t0: f32| {
    // rust: [
    // rust: (s0, t0),
    // rust: (s0 + 0.5, t0),
    // rust: (s0 + 0.5, t0 + 0.5),
    // rust: (s0, t0 + 0.5),
    // rust: ]
    // rust: .map(|(s, t)| bilinear(&full, s, t))
}
    // rust: assert_eq!(
    // rust: [
    // rust: piece(0.0, 0.0),
    // rust: piece(0.5, 0.0),
    // rust: piece(0.0, 0.5),
    // rust: piece(0.5, 0.5)
    // rust: ]
    // rust: .map(|p| quarter_of(&p)),
    // rust: [0, 1, 2, 3]
    // rust: );
}

overlays_take_the_cubes_own_uvs :: proc() {
}
//         use horizon_assets::model::Direction as D;
        // A top face: the north-west corner is the sprite's top-left, so a tile's top edge is
        // north whatever the model's turn.
    // rust: assert_eq!(standard_uv(D::Up, [0.0, 1.0, 0.0]), [0.0, 0.0]);
    // rust: assert_eq!(standard_uv(D::Up, [1.0, 1.0, 1.0]), [1.0, 1.0]);
        // A north face seen from the north: its top-left is the east top corner.
    // rust: assert_eq!(standard_uv(D::North, [1.0, 1.0, 0.0]), [0.0, 0.0]);
    // rust: assert_eq!(standard_uv(D::East, [1.0, 0.0, 1.0]), [0.0, 1.0]);
    // rust: assert_eq!(standard_uv(D::Down, [0.0, 0.0, 1.0]), [0.0, 0.0]);
}
}
