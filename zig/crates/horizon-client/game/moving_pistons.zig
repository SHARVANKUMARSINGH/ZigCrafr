//! Transpiled from Horizon Rust crate
//! Module: horizon-client_moving_pistons
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `PistonHeadRenderer`: while a piston moves them, blocks are
//! `minecraft:moving_piston` block entities (drawn as nothing by the chunk
//! mesher); this draws each moved block at its interpolated offset.
// use super::Game;
// use horizon_client::mesher::Vertex;
// use horizon_world::{piston_shape::MovingPistonState, registry::BlockStateId};

    // rust: impl Game<'_> {
    /// `PistonHeadRenderer.extractRenderState` and `submit`.
    // rust: pub(super) fn moving_piston_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let partial = alpha as f32;
    // rust: let live = self
    // rust: .world
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .map(|&(p, s)| (p, s, false));
        // A piston that just finished bridges the frames until the chunk mesh
        // shows the block it placed; drawn over that mesh, it z-fights (#3002).
    // rust: let finished = self
    // rust: .world
    // rust: .moving_piston_fallback
    // rust: .iter()
    // rust: .filter(|(p, _)| self.section_mesh_pending(*p))
    // rust: .map(|&(p, s)| (p, s, true));
    // rust: let states: Vec<_> = live.chain(finished).collect();
    // rust: for (p, piston, placed) in states {
    // rust: let Some((block, base)) = self.moving_piston_blocks(piston, partial) else {
    // rust: continue;
}
    // rust: let step = piston.movement_direction().normal();
    // rust: let at = horizon_core::position::BlockPos::new(p[0], p[1], p[2]);
            // `createMovingBlock`'s block position (seed, tint and light): the
            // cell the block moves from. A finished one stands in for the
            // chunk mesh's block at `p`, so it is drawn as that block.
    // rust: let from = if placed {
    // rust: at
    // rust: } else {
    // rust: horizon_core::position::BlockPos::new(
    // rust: p[0] - step[0],
    // rust: p[1] - step[1],
    // rust: p[2] - step[2],
    // rust: )
}
    // rust: let offset = piston.interpolated_offset(partial);
    // rust: let corner = glam::DVec3::new(f64::from(p[0]), f64::from(p[1]), f64::from(p[2]));
    // rust: let moved = corner + glam::Vec3::from_array(offset).as_dvec3();
    // rust: self.moving_block_vertices(block, from, moved - camera, out);
    // rust: if let Some(base) = base {
    // rust: self.moving_block_vertices(base, at, corner - camera, out);
}
}
}
    /// The section holding the block at `p` (`SectionPos.blockToSection`).
    // rust: pub(super) fn section_of(&self, p: [i32; 3]) -> Option<(i32, i32, i32)> {
    // rust: let y = p[1].checked_sub(self.world.layout().min_y())?;
    // rust: Some((p[0] >> 4, y.div_euclid(16), p[2] >> 4))
}
    /// Whether the chunk mesh doesn't show the blocks at `p` yet (edited,
    /// meshing, or waiting for its upload).
    // rust: pub(super) fn section_mesh_pending(&self, p: [i32; 3]) -> bool {
    // rust: let Some(section) = self.section_of(p) else {
    // rust: return false;
}
    // rust: self.world.dirty_sections.contains(&section)
    // rust: || self.streaming.is_meshing(section)
    // rust: || self.section_upload_pending(section)
}
    /// Whether a mesh of the section waits for its upload.
    // rust: pub(super) fn section_upload_pending(&self, section: (i32, i32, i32)) -> bool {
    // rust: self.pending_uploads.iter().any(|(key, _)| *key == section)
}
    /// The moved block and, for a retracting piston, its extended base.
    // rust: fn moving_piston_blocks(
    // rust: &self,
    // rust: piston: MovingPistonState,
    // rust: partial: f32,
    // rust: ) -> Option<(BlockStateId, Option<BlockStateId>)> {
    // rust: let facts = self.res.facts();
    // rust: if facts.is_air(piston.moved_state) {
    // rust: return None;
}
    // rust: let progress = piston.interpolated_progress(partial);
    // rust: let name = &*facts.get(piston.moved_state).name;
        // Vanilla tests `progress <= 4.0`: a moving head is always drawn so.
    // rust: if name == "minecraft:piston_head" {
    // rust: let short = if progress <= 0.5 { "true" } else { "false" };
    // rust: return Some((
    // rust: self.with_props(piston.moved_state, &[("short", short)])?,
    // rust: None,
    // rust: ));
}
    // rust: if piston.source && !piston.extending {
    // rust: let registry = &self.pack.assets.registry;
    // rust: let facing = registry
    // rust: .state(piston.moved_state)?
    // rust: .properties
    // rust: .get("facing")?
    // rust: .clone();
    // rust: let kind = if name == "minecraft:sticky_piston" {
    // rust: "sticky"
    // rust: } else {
    // rust: "normal"
}
    // rust: let short = if progress >= 0.5 { "true" } else { "false" };
    // rust: let head = self.with_props(
    // rust: registry.default_state("minecraft:piston_head")?,
    // rust: &[("type", kind), ("facing", &facing), ("short", short)],
    // rust: )?;
    // rust: let base = self.with_props(piston.moved_state, &[("extended", "true")])?;
    // rust: return Some((head, Some(base)));
}
    // rust: Some((piston.moved_state, None))
}
    /// One `MovingBlockRenderState`: the baked model at `at` (camera-relative),
    /// seeded by its block position `seed`, tinted per face with the block
    /// colours there and lit as `ModelBlockRenderer.tesselateFlat` lights a
    /// lone block at `seed`: each face from the cell it looks at. Not from
    /// the moving piston's own cell, which is dark once the block it placed
    /// stands there (#3002).
    // rust: pub(super) fn moving_block_vertices(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: seed: horizon_core::position::BlockPos,
    // rust: at: glam::DVec3,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let chunks = &self.world.chunks;
    // rust: let (cx, cz) = (seed.x >> 4, seed.z >> 4);
    // rust: let region: [[Option<&horizon_client::chunk::Chunk>; 3]; 3] = std::array::from_fn(|dz| {
    // rust: std::array::from_fn(|dx| {
    // rust: chunks
    // rust: .get(&(cx + dx as i32 - 1, cz + dz as i32 - 1))
    // rust: .map(|c| &**c)
    // rust: })
    // rust: });
    // rust: let tint = self.pack.context.tables.block_tints(
    // rust: state,
    // rust: [seed.x, seed.y, seed.z],
    // rust: &region,
    // rust: world_biomes!(self),
    // rust: self.streaming.biome_zoom,
    // rust: self.streaming.biome_blend,
    // rust: );
    // rust: let tables = &self.pack.context.tables;
    // rust: let light = |quad: &horizon_assets::bake::ModelQuad| {
    // rust: let coords = tables.flat_light(state, [seed.x, seed.y, seed.z], quad, |p| {
    // rust: self.world.light(p[0], p[1], p[2])
    // rust: });
            // Light coords (block << 4 | sky << 20) as the vertex packs them.
    // rust: (coords >> 16 & 0xF0) | ((coords & 0xF0) << 8)
}
    // rust: self.tinted_block_model_vertices(
    // rust: state,
    // rust: horizon_core::random::position_seed(seed),
    // rust: glam::Mat4::from_translation(at.as_vec3()),
    // rust: light,
    // rust: false,
    // rust: tint,
    // rust: out,
    // rust: );
}
}
