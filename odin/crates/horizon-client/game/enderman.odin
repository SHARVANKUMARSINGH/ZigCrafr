//! Transpiled from Horizon Rust crate
package horizon_client_enderman

import "core:fmt"
import "core:mem"
import "core:math"

// Enderman leave-block attempts need the authoritative block simulation.
// use super::Game;
// use horizon_client::{Result, mobs::Species};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
}
// use horizon_world::{
    // rust: level::{LevelAccess, flags},
    // rust: registry::BlockStateId,
}

    // rust: impl Game<'_> {
    // `EndermanLeaveBlockGoal.tick`: normalize, check, place, then clear.
    // rust: pub(super) fn enderman_place_block(
    // rust: &mut self,
    // rust: mob: u32,
    // rust: pos: [i32; 3],
    // rust: carried: BlockStateId,
    // rust: occupants: &[Aabb],
    // rust: ) -> Result<()> {
        // Runtime ids identify the actual mob in this level. An obsolete attempt
        // must not clear another mob's hand or a subsequently changed stack.
    // rust: if !self.mobs.iter().any(|m| {
    // rust: m.id == mob
    // rust: && m.alive()
    // rust: && m.species() == Species::Enderman
    // rust: && m.extra.carried == Some(carried)
    // rust: }) {
    // rust: return Ok(());
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: let area = Aabb::new(
    // rust: Vec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])),
    // rust: Vec3::new(
    // rust: f64::from(pos[0] + 1),
    // rust: f64::from(pos[1] + 1),
    // rust: f64::from(pos[2] + 1),
    // rust: ),
    // rust: );
    // rust: let placed = self.with_level(|b, level, ticks| {
    // rust: let target = level.block_state(at);
    // rust: let below = level.block_state(at.offset(0, -1, 0));
            // Must run even when eligibility fails: updateShape can schedule
            // ticks and invoke native hooks on the real level.
    // rust: let state = b.update_from_neighbour_shapes(level, ticks, at, carried);
    // rust: let support = level.facts.get(below);
    // rust: if !level.facts.is_air(target)
    // rust: || level.facts.is_air(below)
    // rust: || &*support.name == "minecraft:bedrock"
    // rust: || !support.full_collision
    // rust: || occupants.iter().any(|bounds| bounds.intersects(area))
    // rust: {
    // rust: return false;
}
            // AIR is a legitimate normalized state. setBlock may report no
            // change for it; the eligible operation still empties the hand.
    // rust: b.set_block(level, ticks, at, state, flags::UPDATE_ALL);
    // rust: true
    // rust: });
    // rust: if placed
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| {
    // rust: m.id == mob && m.species() == Species::Enderman && m.extra.carried == Some(carried)
    // rust: })
    // rust: {
    // rust: m.extra.carried = None;
}
    // rust: self.process_level_events()
}
}
