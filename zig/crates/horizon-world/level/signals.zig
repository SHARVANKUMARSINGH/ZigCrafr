//! Transpiled from Horizon Rust crate
//! Module: horizon-world_signals
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Output-signal notifications for block entities the caller owns.
// use super::{Behaviours, LevelAccess, Ticks};
// use horizon_core::position::BlockPos;

    // rust: impl Behaviours {
    /// `BlockEntity.setChanged`: a container at `pos` changed its contents, so
    /// comparators reading it (`Level.updateNeighbourForOutputSignal`) update.
    // rust: pub fn container_changed<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: let state = level.block_state(pos);
    // rust: if !self.is_air(state) {
    // rust: let block = self.block(state);
    // rust: self.sim(level, ticks)
    // rust: .update_neighbour_for_output_signal(pos, block);
}
}
}

    // rust: impl Behaviours {
    /// The update half of `Level.setBlock` for a state the caller already
    /// wrote to storage (entity landing rules write blocks directly):
    /// neighbour updates, then neighbour shape updates, per `flags`.
    // rust: pub fn notify_written<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: flags: i32,
    // rust: ) {
//         use super::flags as f;
    // rust: let state = level.block_state(pos);
    // rust: let mut sim = self.sim(level, ticks);
    // rust: if flags & f::UPDATE_NEIGHBORS != 0 {
    // rust: sim.update_neighbors_at(pos, self.block(state));
}
    // rust: if flags & f::UPDATE_KNOWN_SHAPE == 0 {
    // rust: let neighbour_flags = flags & !(f::UPDATE_NEIGHBORS | f::UPDATE_SUPPRESS_DROPS);
    // rust: sim.update_neighbour_shapes(state, pos, neighbour_flags, f::UPDATE_LIMIT - 1);
}
}
}
