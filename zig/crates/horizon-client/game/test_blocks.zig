//! Transpiled from Horizon Rust crate
//! Module: horizon-client_test_blocks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Test blocks on the server: `handleSetTestBlock` and the mode a placed
//! test block starts with.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: test_block::{Effects, TestBlock, TestBlockMode},
}
// use horizon_core::position::BlockPos;
// use horizon_protocol::packets::play;

    // rust: type Pos = (i32, i32, i32);

    // rust: impl Game<'_> {
pub fn test_block_mut(self: *Self, pos: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.world.block_entities.get_mut(&pos)? {
    // rust: BlockEntity::TestBlock(b) => Some(b),
    // rust: _ => None,
}
}

    /// The `mode` of the block state at `pos`.
    // rust: pub(super) fn test_block_state_mode(&self, pos: Pos) -> Option<TestBlockMode> {
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: let mode = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)?
    // rust: .properties
    // rust: .get("mode")?;
    // rust: TestBlockMode::of_serialized_name(mode)
}

    /// `new TestBlockEntity(pos, state)`: the mode is the state's.
    // rust: pub(super) fn test_block_placed(&mut self, pos: Pos) {
    // rust: let Some(mode) = self.test_block_state_mode(pos) else {
    // rust: return;
}
    // rust: if let Some(b) = self.test_block_mut(pos) {
    // rust: b.mode = mode;
}
}

pub fn test_block_at(self: *Self, pos: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.world.block_entities.get(&pos)? {
    // rust: BlockEntity::TestBlock(b) => Some(b),
    // rust: _ => None,
}
}

    /// `TestBlockEntity.hasTriggered`.
    // rust: pub(super) fn test_block_triggered(&self, pos: Pos) -> bool {
    // rust: self.test_block_at(pos).is_some_and(|b| b.triggered)
}

    /// `TestBlockEntity.getMessage`.
    // rust: pub(super) fn test_block_message(&self, pos: Pos) -> String {
    // rust: self.test_block_at(pos)
    // rust: .map_or_else(String::new, |b| b.message.clone())
}

    /// What a `TestBlockEntity` call asked of the level: its neighbours
    /// update (`level.updateNeighborsAt`) and the log line.
pub fn apply_test_block_effects(self: *Self, pos: Pos, effects: Effects) void {
}
    // rust: if effects.update_neighbors {
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: let state = self.world.block(pos.0, pos.1, pos.2);
    // rust: self.with_level(|b, level, ticks| {
    // rust: let block = b.block(state);
    // rust: b.update_neighbors_at(level, ticks, at, block);
    // rust: });
}
    // rust: if effects.log
    // rust: && let Some(b) = self.test_block_at(pos)
    // rust: && !b.message.trim().is_empty()
    // rust: {
    // rust: log::info!(
    // rust: "Test {} (at {}, {}, {}): {}",
    // rust: b.mode.serialized_name(),
    // rust: pos.0,
    // rust: pos.1,
    // rust: pos.2,
    // rust: b.message
    // rust: );
}
}

    /// `TestBlockEntity.trigger`.
    // rust: pub(super) fn trigger_test_block(&mut self, pos: Pos) {
    // rust: let Some(effects) = self.test_block_mut(pos).map(TestBlock::trigger) else {
    // rust: return;
}
    // rust: self.apply_test_block_effects(pos, effects);
}

    /// `TestBlockEntity.reset`, which `TestBlock.tick` runs.
    // rust: pub(super) fn reset_test_block(&mut self, pos: Pos) {
    // rust: let Some(effects) = self.test_block_mut(pos).map(TestBlock::reset) else {
    // rust: return;
}
    // rust: self.apply_test_block_effects(pos, effects);
}

    /// `TestBlock.neighborChanged`: a rising signal triggers the block.
    // rust: pub(super) fn test_block_neighbor_changed(&mut self, pos: Pos) {
    // rust: if self.test_block_at(pos).is_none() {
    // rust: return;
}
    // rust: let at = BlockPos::new(pos.0, pos.1, pos.2);
    // rust: let signal = self.with_level(|b, level, ticks| b.has_neighbor_signal(level, ticks, at));
    // rust: let Some(effects) = self
    // rust: .test_block_mut(pos)
    // rust: .and_then(|b| b.neighbor_changed(signal))
    // rust: else {
    // rust: return;
}
    // rust: self.apply_test_block_effects(pos, effects);
}

    /// `handleSetTestBlock` for a guest: only a creative player with game
    /// master commands edits the block.
    // rust: pub(super) fn lan_set_test_block(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: play::SetTestBlock,
    // rust: ) {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return;
}
    // rust: let allowed = g.creative() && g.permission >= 2;
    // rust: self.as_guest(host, conn, |game| {
    // rust: if allowed {
    // rust: game.apply_set_test_block(&p);
}
    // rust: });
}

pub fn apply_set_test_block(self: *Self, p: *play::SetTestBlock) void {
}
    // rust: let pos = (p.pos[0], p.pos[1], p.pos[2]);
    // rust: if self.test_block_mut(pos).is_none() {
    // rust: return;
}
    // rust: let mode = TestBlockMode::by_id(p.mode);
        // TestBlockEntity.setMode: the entity's and the block state's.
    // rust: if let Some(b) = self.test_block_mut(pos) {
    // rust: b.mode = mode;
}
    // rust: self.set_mode_property(pos, "minecraft:test_block", mode.serialized_name());
    // rust: if let Some(b) = self.test_block_mut(pos) {
    // rust: b.message = p.message.clone();
}
    // rust: self.mark_block_entity_updated(pos);
}
}
