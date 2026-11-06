//! Transpiled from Horizon Rust crate
//! Module: horizon-client_postprocess
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! LevelChunk.postProcessGeneration: positions that worldgen marked for
//! postprocessing (aquifer fluids next to open air, features' shape-dependent
//! blocks) are updated once the chunk is live, which starts cave waterfalls
//! and lava falls, raises bubble columns over magma and soul sand and fixes
//! block shapes against their neighbours.
// use super::Game;
// use horizon_client::{Result, blocks::Fluid};
// use horizon_core::position::BlockPos;
// use std::sync::Arc;

/// Block.UPDATE_INVISIBLE | UPDATE_KNOWN_SHAPE | UPDATE_SKIP_BLOCK_ENTITY_SIDEEFFECTS.
pub const POSTPROCESS_FLAGS: i32 = 276;

    // rust: impl Game<'_> {
    // rust: pub(super) fn postprocess_chunks(&mut self) -> Result<()> {
    // rust: let ready: Vec<(i32, i32)> = self
    // rust: .world
    // rust: .chunks
    // rust: .iter()
    // rust: .filter(|(_, c)| c.lit && !c.postprocess.is_empty())
    // rust: .map(|(k, _)| *k)
    // rust: .filter(|&(x, z)| {
    // rust: (-1..=1)
    // rust: .all(|dz| (-1..=1).all(|dx| self.world.chunks.contains_key(&(x + dx, z + dz))))
    // rust: })
    // rust: .collect();
    // rust: if ready.is_empty() {
    // rust: return Ok(());
}
        // The ticks the marks schedule go to the chunks' containers, which a
        // chunk that arrived since the last tick doesn't have yet
        // (`LevelChunk.registerTickContainerInLevel` comes before
        // `postProcessGeneration`).
    // rust: self.sync_tick_chunks();
    // rust: for key in ready {
    // rust: let Some(chunk) = self.world.chunks.get_mut(&key) else {
    // rust: continue;
}
    // rust: let marks = std::mem::take(&mut Arc::make_mut(chunk).postprocess);
    // rust: self.with_level(|b, level, ticks| {
    // rust: for [x, y, z] in marks {
    // rust: let pos = BlockPos::new(x, y, z);
    // rust: let state = level.world.block(x, y, z);
    // rust: let facts = level.facts.get(state);
    // rust: let (fluid, liquid_block) = (
    // rust: facts.fluid != Fluid::None,
    // rust: matches!(&*facts.name, "minecraft:water" | "minecraft:lava"),
    // rust: );
    // rust: if fluid {
    // rust: b.scheduled_fluid_tick(level, ticks, pos);
}
    // rust: if liquid_block {
                        // LiquidBlock.tick: bubble columns over soul sand and magma.
    // rust: b.scheduled_block_tick(level, ticks, pos);
    // rust: } else {
    // rust: let updated = b.update_from_neighbour_shapes(level, ticks, pos, state);
    // rust: if updated != state {
    // rust: b.set_block(level, ticks, pos, updated, POSTPROCESS_FLAGS);
}
}
}
    // rust: });
}
    // rust: self.process_level_events()
}
}
