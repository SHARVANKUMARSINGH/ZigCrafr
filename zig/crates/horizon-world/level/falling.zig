//! Transpiled from Horizon Rust crate
//! Module: horizon-world_falling
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Gravity blocks: `FallingBlock.tick`, `FallingBlockEntity.fall` and the
//! landing branch of `FallingBlockEntity.tick`. The falling entity itself
//! (motion, collision, entity damage) is simulated by the caller.
// use super::{Behaviours, LevelAccess, LevelEvent, Sim, Ticks, classes::Class, update::below};
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, position::BlockPos};

/// Outcome of [`Behaviours::falling_block_landed`].
pub const Landing = enum {
    /// The block was placed at the position (concrete powder may have
    /// solidified); discard the entity.
    Placed(BlockStateId),
    /// The block could not be placed: discard the entity and, if the entity
    /// drops items, run `Fallable.onBrokenAfterFall` (the anvil's level event
    /// 1029) and spawn the block's item from the entity's position (vanilla
    /// `spawnAtLocation`).
    Broken,
    /// The landing position holds a moving piston: keep falling.
    Continue,
};

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    /// `FallingBlockEntity.fall`.
    // rust: pub(crate) fn falling_block_fall(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: hurt_per_distance: Option<f32>,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let carried = b
    // rust: .table
    // rust: .with_bool(state, b.props.waterlogged, false)
    // rust: .unwrap_or(state);
    // rust: let legacy = b.legacy_block(b.fluid(state));
    // rust: self.set_block_and_update(pos, legacy);
    // rust: self.emit(LevelEvent::FallingBlock {
    // rust: pos,
    // rust: state: carried,
    // rust: hurt_per_distance,
    // rust: });
}
    /// `FallingBlock.tick` (and `SpeleothemBlock`'s falling stalactites).
    // rust: pub(crate) fn falling_block_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: if self.is_free(self.below_state(pos)) && pos.y >= self.level.min_y() {
    // rust: self.falling_block_fall(pos, state, None);
}
}
    /// `SpeleothemBlock.spawnFallingStalactite`.
    // rust: pub(crate) fn spawn_falling_stalactite(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let is_stalactite = |s: BlockStateId| {
    // rust: b.tag("minecraft:speleothems")
    // rust: .is_some_and(|tag| b.in_set(s, tag))
    // rust: && b.table.dir(s, p.vertical_direction) == Some(Direction::Down)
}
    // rust: let mut fall_pos = pos;
    // rust: let mut fall_state = state;
    // rust: while is_stalactite(fall_state) {
    // rust: let thickness = b.table.text(fall_state, p.thickness);
    // rust: let tip = thickness == "tip" || thickness == "tip_merge";
    // rust: let damage = tip.then_some((1 + pos.y - fall_pos.y).max(6) as f32);
    // rust: self.falling_block_fall(fall_pos, fall_state, damage);
    // rust: if tip {
    // rust: break;
}
    // rust: fall_pos = below(fall_pos);
    // rust: fall_state = self.state(fall_pos);
}
}
}

    // rust: impl Behaviours {
    /// The landing branch of `FallingBlockEntity.tick`, called by the caller's
    /// falling-block entity once it is on the ground (or stuck in water as
    /// concrete powder). `state` is the carried block state.
    // rust: pub fn falling_block_landed<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: stuck_in_water: bool,
    // rust: ) -> Landing {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let current = sim.state(pos);
    // rust: if self.is_block(current, self.named.moving_piston) {
    // rust: return Landing::Continue;
}
    // rust: let concrete = self.instance_of(state, Class::ConcretePowder);
        // DirectionalPlaceContext(level, pos, DOWN, ItemStack.EMPTY, UP).
    // rust: let ctx = super::place::PlacementContext {
    // rust: pos,
    // rust: hit_pos: pos,
    // rust: face: Direction::Up,
    // rust: hit: horizon_core::geometry::Vec3::new(
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y),
    // rust: f64::from(pos.z) + 0.5,
    // rust: ),
    // rust: inside: false,
    // rust: yaw: 0.0,
    // rust: pitch: 90.0,
    // rust: sneaking: false,
    // rust: item: String::new(),
    // rust: replace_clicked: true,
}
    // rust: let may_replace = sim.can_be_replaced(current, &ctx);
    // rust: let would_continue = sim.is_free(sim.below_state(pos)) && (!concrete || !stuck_in_water);
    // rust: let would_survive = sim.can_survive(state, pos) && !would_continue;
    // rust: if !(may_replace && would_survive) {
    // rust: return Landing::Broken;
}
    // rust: let mut placed = state;
    // rust: if self.table.has(placed, self.props.waterlogged)
    // rust: && self.is_water_fluid(sim.fluid_at(pos).kind())
    // rust: {
    // rust: placed = self.table.set_bool(placed, self.props.waterlogged, true);
}
    // rust: if !sim.set_block_and_update(pos, placed) {
    // rust: return Landing::Broken;
}
        // Fallable.onLand
    // rust: if concrete {
    // rust: if self.is_water_fluid(self.fluid(current).kind()) || sim.concrete_touches_liquid(pos) {
    // rust: if let Some(solid) = self.data(state).link {
    // rust: sim.set_block_and_update(pos, self.default_of(solid));
}
}
    // rust: } else if self.instance_of(state, Class::Anvil) {
    // rust: sim.level_event(1031, pos, 0);
}
    // rust: Landing::Placed(sim.state(pos))
}
}
