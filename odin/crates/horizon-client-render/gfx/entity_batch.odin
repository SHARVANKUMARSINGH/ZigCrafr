//! Transpiled from Horizon Rust crate
package horizon_client_render_entity_batch

import "core:fmt"
import "core:mem"
import "core:math"

// Stable entity material grouping with renderer-owned, reusable CPU scratch.
// use super::Vertex;

// Entity materials by a quad's overlay (`Vertex::layer`), in draw order:
// ordinary entities, world text drawn with a depth bias (35,
// `RenderPipelines.TEXT_POLYGON_OFFSET`), breaking cracks (11), translucent
// breaking cracks (12), the boat water mask (13, `RenderPipelines.WATER_MASK`),
// energy swirls (34, `RenderPipelines.ENERGY_SWIRL`), entity shadows (14,
// `RenderPipelines.ENTITY_SHADOW`), translucent-layer particles (15, drawn
// after translucent terrain: `SubmitNodeCollection.submitQuadParticleGroup`)
// and translucent item quads (32, drawn without depth writes).
//
// With improved transparency on, quads tagged `OIT_ENTITY` are a tenth
// material at the end: the render types vanilla gives an `OitPipelineSet`
// (translucent, emissive, eyes and breeze wind entity models). Off, the tag is
// ignored and they stay in the first one, in their order.
// Two native world-canvas text materials follow it, NORMAL then POLYGON_OFFSET.
MATERIALS :: 12
// A bit of `Vertex::layer`, above the overlay (low 16 bits) and the HDR tier
// (bits 16 to 23): the quad's render type has an `OitPipelineSet`
// (`RenderTypes.entityTranslucent`, `entityTranslucentEmissive`, `eyes`,
// `breezeWind`). Only the improved transparency path reads it.
OIT_ENTITY :: 1 << 24
// `RenderPipelines.DRAGON_RAYS`: untextured colour, additive with depth writes.
DRAGON_RAYS_OVERLAY :: 37
// `RenderPipelines.ENTITY_CUTOUT_DISSOLVE` (the dying dragon): a pixel is dropped where the
// vertex alpha is below the mask's, whose atlas UV rides in `Vertex::glint_uv`; the rest is
// drawn opaque. No overlay.
DISSOLVE_OVERLAY :: 38
// Tags quads as drawn by a render type vanilla gives an `OitPipelineSet`
// (`OIT_ENTITY`): improved transparency draws them in its stages.
mark_oit :: proc(quads: ^[Vertex]) {
}
    // rust: for vertex in quads {
    // rust: vertex.layer |= OIT_ENTITY;
}
}
// The overlay of depth-only quads that hide water (`RenderTypes.waterMask`).
WATER_MASK_OVERLAY :: 13
// The overlay of energy swirl quads (`RenderTypes.energySwirl`: the charged creeper's and the
// powered wither's armour). The light bytes carry the sprite's origin and the colour bytes its
// size (`breaking::stage_light`), the UV the scrolled position in the sprite.
ENERGY_SWIRL_OVERLAY :: 34
// The overlay of entity shadow quads (`RenderTypes.entityShadow`).
SHADOW_OVERLAY :: 14
// The overlay of translucent-layer particles (`SingleQuadParticle.Layer.translucent`).
TRANSLUCENT_PARTICLE_OVERLAY :: 15
// The overlay of item quads with translucent pixels (`Sheets.translucentItemSheet`,
// `RenderPipelines.ITEM_TRANSLUCENT`); past the creeper swell range (16 to 31).
TRANSLUCENT_ITEM_OVERLAY :: 32
// A translucent item with an enchantment glint.
TRANSLUCENT_GLINT_ITEM_OVERLAY :: 33
// The overlay of text in `Font.DisplayMode.POLYGON_OFFSET` (text displays):
// drawn like an ordinary entity, pulled toward the camera.
TEXT_POLYGON_OFFSET_OVERLAY :: 35
// A native world canvas, drawn after particles with normal text depth/culling.
WORLD_TEXT_OVERLAY :: 39
// The front of its eight-offset outlined text, using POLYGON_OFFSET.
WORLD_TEXT_POLYGON_OFFSET_OVERLAY :: 40

// The material of a quad by its overlay (`MATERIALS` order): the overlay is the layer's low 16
// bits, as entity.wgsl reads it; HDR output's tier rides in the high ones.
material :: proc(layer: u32, oit: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if oit && layer & OIT_ENTITY != 0 {
    // rust: return 9;
}
    // rust: match layer & 0xffff {
    // rust: WORLD_TEXT_OVERLAY => 10,
    // rust: WORLD_TEXT_POLYGON_OFFSET_OVERLAY => 11,
    // rust: TEXT_POLYGON_OFFSET_OVERLAY => 1,
    // rust: 11 => 2,
    // rust: 12 => 3,
    // rust: WATER_MASK_OVERLAY => 4,
    // rust: ENERGY_SWIRL_OVERLAY => 5,
    // rust: SHADOW_OVERLAY => 6,
    // rust: TRANSLUCENT_PARTICLE_OVERLAY => 7,
    // rust: TRANSLUCENT_ITEM_OVERLAY | TRANSLUCENT_GLINT_ITEM_OVERLAY => 8,
    // rust: _ => 0,
}
}

    // rust: pub(super) struct EntityBatch {
    // Runs of consecutive quads of one material (first quad, quad count): a
    // model's quads share one, so whole runs are copied at once. Cleared each
    // frame, keeping their storage.
    // rust: runs: [Vec<(usize, usize)>; MATERIALS],
    // rust: pub(super) combined: Vec<Vertex>,
    // Additive quads tagged `OIT_ENTITY` that the last `update` moved into the
    // last material (improved transparency on): the dragon's eyes, which share
    // the additive buffer with its rays.
    // rust: pub(super) moved_additive: u32,
}

    // rust: impl EntityBatch {
    // After `update`: quads only a native pack's shadow pass draws, at the buffer's end.
    // rust: pub(super) fn append_shadow_only(&mut self, shadow_only: &[Vertex]) {
    // rust: self.combined.extend_from_slice(shadow_only);
}

    // rust: pub(super) fn update(
    // rust: &mut self,
    // rust: entities: &[Vertex],
    // rust: additive: &[Vertex],
    // rust: hand: &[Vertex],
    // rust: see_through: &[Vertex],
    // rust: oit: bool,
    // rust: ) -> [u32; MATERIALS] {
    // rust: let quads = entities.as_chunks::<4>().0;
    // rust: for runs in &mut self.runs {
    // rust: runs.clear();
}
    // rust: let mut counts = [0usize; MATERIALS];
    // rust: let mut start = 0;
    // rust: while start < quads.len() {
    // rust: let kind = material(quads[start][0].layer, oit);
    // rust: let end = quads[start + 1..]
    // rust: .iter()
    // rust: .position(|quad| material(quad[0].layer, oit) != kind)
    // rust: .map_or(quads.len(), |n| start + 1 + n);
    // rust: self.runs[kind].push((start, end - start));
    // rust: counts[kind] += end - start;
    // rust: start = end;
}
    // rust: let entity_vertices = quads.len() * 4;
    // rust: self.combined.clear();
    // rust: self.combined
    // rust: .reserve(entity_vertices + additive.len() + hand.len() + see_through.len());
    // rust: for runs in &self.runs[..10] {
    // rust: for &(first, count) in runs {
    // rust: self.combined
    // rust: .extend_from_slice(&entities[first * 4..(first + count) * 4]);
}
}
        // `RenderTypes.eyes` is blended like the other entities, not added: with
        // improved transparency on, tagged additive quads join the last
        // material, drawn without the additive overlay and the baked shading.
    // rust: self.moved_additive = 0;
    // rust: if oit {
    // rust: for quad in additive.as_chunks::<4>().0 {
    // rust: if quad[0].layer & OIT_ENTITY != 0 {
    // rust: self.combined.extend(quad.iter().map(|v| Vertex {
    // rust: layer: v.layer & !0xffff,
    // rust: normal: [0; 4],
    // rust: ..*v
    // rust: }));
    // rust: counts[9] += 1;
    // rust: self.moved_additive += 1;
}
}
}
        // RenderType.text sorts alpha-blended quads from far to near. Keep
        // both world-canvas layers after existing materials (including eyes
        // moved out of additive); front text uses polygon offset.
    // rust: for runs in &self.runs[10..] {
    // rust: let start = self.combined.len();
    // rust: for &(first, count) in runs {
    // rust: self.combined
    // rust: .extend_from_slice(&entities[first * 4..(first + count) * 4]);
}
    // rust: self.combined[start..]
    // rust: .as_chunks_mut::<4>()
    // rust: .0
    // rust: .sort_by(|a, b| {
    // rust: let distance = |q: &[Vertex; 4]| {
    // rust: (0..3)
    // rust: .map(|i| ((q[0].pos[i] + q[2].pos[i]) * 0.5).powi(2))
    // rust: .sum::<f32>()
}
    // rust: distance(b).total_cmp(&distance(a))
    // rust: });
}
    // rust: if self.moved_additive == 0 {
    // rust: self.combined.extend_from_slice(additive);
    // rust: } else {
    // rust: for quad in additive.as_chunks::<4>().0 {
    // rust: if quad[0].layer & OIT_ENTITY == 0 {
    // rust: self.combined.extend_from_slice(quad);
}
}
}
    // rust: self.combined.extend_from_slice(hand);
    // rust: self.combined.extend_from_slice(see_through);
    // rust: counts.map(|count| count as u32)
}
}

    // rust: mod tests {
//     use super::*;
//     use std::{hint::black_box, time::Instant};
world_canvas_sorts_after_oit_eyes_before_frame_tails :: proc() {
}
    // rust: let quad = |layer, x| {
    // rust: [Vertex {
    // rust: layer,
    // rust: pos: [x, 0.0, 0.0],
    // rust: ..geometry(1, false)[0]
    // rust: }; 4]
}
    // rust: let entities: Vec<_> = [
    // rust: (0, 1.0),
    // rust: (35, 2.0),
    // rust: (OIT_ENTITY, 3.0),
    // rust: (WORLD_TEXT_OVERLAY, 4.0),
    // rust: (WORLD_TEXT_OVERLAY, 5.0),
    // rust: (WORLD_TEXT_POLYGON_OFFSET_OVERLAY, 6.0),
    // rust: ]
    // rust: .into_iter()
    // rust: .flat_map(|(layer, x)| quad(layer, x))
    // rust: .collect();
    // rust: let additive: Vec<_> = [(OIT_ENTITY | 2, 7.0), (2, 8.0)]
    // rust: .into_iter()
    // rust: .flat_map(|(layer, x)| quad(layer, x))
    // rust: .collect();
    // rust: let mut batch = EntityBatch::default();
    // rust: assert_eq!(
    // rust: batch.update(&entities, &additive, &quad(0, 9.0), &quad(0, 10.0), true),
    // rust: [1, 1, 0, 0, 0, 0, 0, 0, 0, 2, 2, 1]
    // rust: );
    // rust: let positions: Vec<_> = batch.combined.iter().step_by(4).map(|v| v.pos[0]).collect();
    // rust: assert_eq!(
    // rust: positions,
    // rust: [1.0, 2.0, 3.0, 7.0, 5.0, 4.0, 6.0, 8.0, 9.0, 10.0]
    // rust: );
}

    // Retain the original implementation as the equivalence/benchmark oracle.
    // rust: fn baseline(
    // rust: entities: &[Vertex],
    // rust: additive: &[Vertex],
    // rust: hand: &[Vertex],
    // rust: ) -> (Vec<Vertex>, [u32; MATERIALS]) {
    // rust: let mut combined = Vec::with_capacity(entities.len() + additive.len() + hand.len());
    // rust: let mut counts = [0; MATERIALS];
    // rust: for (i, layer) in [0, 35, 11, 12, 13, 34, 14, 15].into_iter().enumerate() {
    // rust: for quad in entities.as_chunks::<4>().0 {
    // rust: let material = match quad[0].layer {
    // rust: 35 => 35,
    // rust: 11 => 11,
    // rust: 12 => 12,
    // rust: 13 => 13,
    // rust: 34 => 34,
    // rust: 14 => 14,
    // rust: 15 => 15,
    // rust: _ => 0,
}
    // rust: if material == layer {
    // rust: combined.extend_from_slice(quad);
    // rust: counts[i] += 1;
}
}
}
    // rust: combined.extend_from_slice(additive);
    // rust: combined.extend_from_slice(hand);
    // rust: (combined, counts)
}

geometry :: proc(quads: uint, mixed: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..quads * 4)
    // rust: .map(|index| Vertex {
    // rust: pos: [index as f32, 2.0, 3.0],
    // rust: uv: [index as f32, 5.0],
    // rust: layer: if mixed {
    // rust: [7, 11, 14, 35, 12, 4, 13, 15, 0][index / 4 % 9]
    // rust: } else {
    // rust: 0
    // rust: },
    // rust: color: index as u32,
    // rust: light: (index * 3) as u32,
    // rust: normal: [1, 2, 3, 4],

    // rust: glint_uv: [0.0, 0.0],
    // rust: })
    // rust: .collect()
}

    // rust: fn equivalent(
    // rust: batch: &mut EntityBatch,
    // rust: entities: &[Vertex],
    // rust: additive: &[Vertex],
    // rust: hand: &[Vertex],
    // rust: ) {
    // rust: let (expected, counts) = baseline(entities, additive, hand);
    // rust: assert_eq!(batch.update(entities, additive, hand, &[], false), counts);
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&batch.combined),
    // rust: bytemuck::cast_slice::<_, u8>(&expected)
    // rust: );
}

a_tier_in_the_high_bits_keeps_the_material :: proc() {
}
    // rust: for layer in [0u32, 11, 12, 15, 32, 33, 35, OIT_ENTITY] {
    // rust: for oit in [false, true] {
    // rust: assert_eq!(material(layer | 4 << 16, oit), material(layer, oit));
}
}
}

oit_entity_quads_are_a_last_material_only_when_on :: proc() {
}
    // rust: let quad = |layer: u32, x: f32| {
    // rust: (0..4).map(move |_| Vertex {
    // rust: pos: [x, 0.0, 0.0],
    // rust: layer,
    // rust: ..geometry(1, false)[0]
    // rust: })
}
        // Plain, tagged, plain, shadow, tagged with a hurt overlay.
    // rust: let entities: Vec<Vertex> = [
    // rust: (0, 0.0),
    // rust: (OIT_ENTITY | 3 << 16, 1.0),
    // rust: (1, 2.0),
    // rust: (SHADOW_OVERLAY, 3.0),
    // rust: (OIT_ENTITY | 1, 4.0),
    // rust: ]
    // rust: .into_iter()
    // rust: .flat_map(|(layer, x)| quad(layer, x))
    // rust: .collect();
    // rust: let mut batch = EntityBatch::default();
        // Off: the tag changes nothing, the quads keep their place.
    // rust: let counts = batch.update(&entities, &[], &[], &[], false);
    // rust: assert_eq!(counts, [4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0]);
    // rust: let xs: Vec<f32> = batch.combined.iter().step_by(4).map(|v| v.pos[0]).collect();
    // rust: assert_eq!(xs, [0.0, 1.0, 2.0, 4.0, 3.0]);
        // On: the tagged quads come last, in order.
    // rust: let counts = batch.update(&entities, &[], &[], &[], true);
    // rust: assert_eq!(counts, [2, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 0]);
    // rust: let xs: Vec<f32> = batch.combined.iter().step_by(4).map(|v| v.pos[0]).collect();
    // rust: assert_eq!(xs, [0.0, 2.0, 3.0, 1.0, 4.0]);
}

tagged_additive_quads_join_the_last_material_only_when_on :: proc() {
}
    // rust: let quad = |layer: u32, x: f32| {
    // rust: (0..4).map(move |_| Vertex {
    // rust: pos: [x, 0.0, 0.0],
    // rust: layer,
    // rust: normal: [1, 2, 3, 4],
    // rust: ..geometry(1, false)[0]
    // rust: })
}
        // The dragon's eyes (tagged, overlay 2) and a ray (plain).
    // rust: let additive: Vec<Vertex> = [(2 | OIT_ENTITY | 3 << 16, 1.0), (2, 2.0)]
    // rust: .into_iter()
    // rust: .flat_map(|(layer, x)| quad(layer, x))
    // rust: .collect();
    // rust: let entities: Vec<Vertex> = quad(0, 0.0).collect();
    // rust: let mut batch = EntityBatch::default();
        // Off: untouched.
    // rust: let counts = batch.update(&entities, &additive, &[], &[], false);
    // rust: assert_eq!((counts[9], batch.moved_additive), (0, 0));
    // rust: assert_eq!(batch.combined.len(), 12);
    // rust: assert_eq!(batch.combined[4].layer, 2 | OIT_ENTITY | 3 << 16);
        // On: the eyes are an entity quad without the additive overlay, the ray stays.
    // rust: let counts = batch.update(&entities, &additive, &[], &[], true);
    // rust: assert_eq!((counts[0], counts[9], batch.moved_additive), (1, 1, 1));
    // rust: let xs: Vec<f32> = batch.combined.iter().step_by(4).map(|v| v.pos[0]).collect();
    // rust: assert_eq!(xs, [0.0, 1.0, 2.0]);
    // rust: assert_eq!(batch.combined[4].layer, OIT_ENTITY | 3 << 16);
    // rust: assert_eq!(batch.combined[4].normal, [0; 4]);
    // rust: assert_eq!(batch.combined[8].layer, 2);
}

stable_material_order_tails_and_reuse :: proc() {
}
    // rust: let mut batch = EntityBatch::default();
    // rust: let mut entities = geometry(4096, true);
        // Only the first vertex determines a quad's material.
    // rust: entities[1].layer = 12;
    // rust: let additive = geometry(3, true);
    // rust: let hand = geometry(2, false);
        // Warm every bucket and the combined buffer to their maximum sizes.
    // rust: equivalent(&mut batch, &entities, &additive, &hand);
    // rust: let capacities = batch.runs.each_ref().map(|b| b.capacity());
    // rust: let capacity = batch.combined.capacity();
    // rust: let pointer = batch.combined.as_ptr();
    // rust: for length in [0, 1, 3, 4, 511, entities.len(), 17, 0, entities.len()] {
    // rust: equivalent(&mut batch, &entities[..length], &additive[..5], &hand[..3]);
    // rust: assert_eq!(batch.runs.each_ref().map(|b| b.capacity()), capacities);
    // rust: assert_eq!(batch.combined.capacity(), capacity);
    // rust: assert_eq!(batch.combined.as_ptr(), pointer);
}
    // rust: equivalent(&mut batch, &[], &[], &[]);
    // rust: assert!(batch.combined.is_empty());
        // Grow again, then confirm empty/small frames retain the new storage.
    // rust: let larger = geometry(8192, true);
    // rust: equivalent(&mut batch, &larger, &additive, &hand);
    // rust: let capacities = batch.runs.each_ref().map(|b| b.capacity());
    // rust: let capacity = batch.combined.capacity();
    // rust: for entities in [&larger[..7], &larger[..], &[]] {
    // rust: equivalent(&mut batch, entities, &[], &[]);
    // rust: assert_eq!(batch.runs.each_ref().map(|b| b.capacity()), capacities);
    // rust: assert_eq!(batch.combined.capacity(), capacity);
}
}

benchmark_entity_batch :: proc() {
}
    // rust: let additive = geometry(16, false);
    // rust: let hand = geometry(8, false);
    // rust: for (name, mixed, quads) in [
    // rust: ("mixed", true, 65_536),
    // rust: ("single", false, 65_536),
    // rust: ("runs", true, 65_536),
    // rust: ("mixed", true, 262_144),
    // rust: ("single", false, 262_144),
    // rust: ] {
    // rust: let mut entities = geometry(quads, mixed);
    // rust: if name == "runs" {
                // Model/material runs: normal 16, glint 4, overlay 4, shadow 2.
    // rust: for (index, quad) in entities.as_chunks_mut::<4>().0.iter_mut().enumerate() {
    // rust: let layer = match index % 26 {
    // rust: 0..16 => 0,
    // rust: 16..20 => 11,
    // rust: 20..24 => 12,
    // rust: _ => 4,
}
    // rust: for vertex in quad {
    // rust: vertex.layer = layer;
}
}
}
    // rust: let mut batch = EntityBatch::default();
    // rust: equivalent(&mut batch, &entities, &additive, &hand);
    // rust: for _ in 0..50 {
    // rust: black_box(baseline(black_box(&entities), &additive, &hand));
    // rust: black_box(batch.update(black_box(&entities), &additive, &hand, &[], false));
    // rust: black_box(&batch.combined);
}
    // rust: let mut before = Vec::new();
    // rust: let mut after = Vec::new();
    // rust: for _ in 0..15 {
    // rust: let start = Instant::now();
    // rust: for _ in 0..100 {
    // rust: black_box(baseline(black_box(&entities), &additive, &hand));
}
    // rust: before.push(start.elapsed().as_nanos() / 100);
    // rust: let start = Instant::now();
    // rust: for _ in 0..100 {
    // rust: black_box(batch.update(black_box(&entities), &additive, &hand, &[], false));
    // rust: black_box(&batch.combined);
}
    // rust: after.push(start.elapsed().as_nanos() / 100);
}
    // rust: before.sort_unstable();
    // rust: after.sort_unstable();
    // rust: println!(
    // rust: "{name}: {quads} quads, baseline={} ns/frame optimized={} ns/frame speedup={:.2}x scratch={} bytes",
    // rust: before[7],
    // rust: after[7],
    // rust: before[7] as f64 / after[7] as f64,
    // rust: batch.combined.capacity() * std::mem::size_of::<Vertex>()
    // rust: + batch
    // rust: .runs
    // rust: .iter()
    // rust: .map(|b| b.capacity() * std::mem::size_of::<(usize, usize)>())
    // rust: .sum::<usize>()
    // rust: );
}
}
}
