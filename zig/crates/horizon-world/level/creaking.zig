//! Transpiled from Horizon Rust crate
//! Module: horizon-world_creaking
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The creaking heart block (`CreakingHeartBlock`): its state follows the
//! pale oak logs on both ends of its axis and the `creaking_active`
//! environment attribute. The block entity (protector, particles, resin)
//! lives with the entities in the client.
// use super::{Behaviours, Dimension, LevelAccess, Sim, Ticks, update::rel};
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, position::BlockPos};

/// `Direction.Axis.getDirections()`.
pub fn axis_directions(axis: []const u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match axis {
    // rust: "x" => [Direction::West, Direction::East],
    // rust: "z" => [Direction::North, Direction::South],
    // rust: _ => [Direction::Down, Direction::Up],
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    /// `EnvironmentAttributes.CREAKING_ACTIVE`: the overworld day timeline
    /// turns it on from 12600 to 23400.
    // rust: pub(crate) fn creaking_active(&self) -> bool {
    // rust: self.level.dimension() == Dimension::Overworld
    // rust: && (12600..23401).contains(&self.level.day_time().rem_euclid(24000))
}
    /// `CreakingHeartBlock.hasRequiredLogs`: pale oak logs along the axis.
    // rust: pub(crate) fn heart_has_required_logs(&self, state: BlockStateId, pos: BlockPos) -> bool {
    // rust: let b = self.b;
    // rust: let axis = b.table.text(state, b.props.axis);
    // rust: axis_directions(axis).into_iter().all(|d| {
    // rust: let neighbour = self.state(rel(pos, d));
    // rust: b.in_set(neighbour, &b.tags.pale_oak_logs)
    // rust: && b.table.text(neighbour, b.props.axis) == axis
    // rust: })
}
    /// `CreakingHeartBlock.updateState`: an uprooted heart with its logs wakes
    /// (at night) or goes dormant.
    // rust: pub(crate) fn heart_update_state(&self, state: BlockStateId, pos: BlockPos) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let uprooted = b.table.text(state, b.props.creaking_heart_state) == "uprooted";
    // rust: if uprooted && self.heart_has_required_logs(state, pos) {
    // rust: let next = if self.creaking_active() {
    // rust: "awake"
    // rust: } else {
    // rust: "dormant"
}
    // rust: b.table.set_text(state, b.props.creaking_heart_state, next)
    // rust: } else {
    // rust: state
}
}
    /// `CreakingHeartBlock.tick` (scheduled by `updateShape`).
    // rust: pub(crate) fn heart_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: let next = self.heart_update_state(state, pos);
    // rust: if next != state {
    // rust: self.set_block_and_update(pos, next);
}
}
    /// `CreakingHeartBlock.getStateForPlacement` after the axis is set.
    // rust: pub(crate) fn heart_placement(&self, state: BlockStateId, pos: BlockPos) -> BlockStateId {
    // rust: self.heart_update_state(state, pos)
}
}

    // rust: impl Behaviours {
    /// `EnvironmentAttributes.CREAKING_ACTIVE` at the level's time.
    // rust: pub fn creaking_active<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).creaking_active()
}
    /// `CreakingHeartBlock.hasRequiredLogs`.
    // rust: pub fn creaking_heart_has_logs<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).heart_has_required_logs(state, pos)
}
}
