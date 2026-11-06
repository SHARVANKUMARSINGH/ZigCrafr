//! Transpiled from Horizon Rust crate
//! Module: horizon-world_timeline
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Blocks driven by the overworld day timeline's environment attributes
//! (`gameplay/eyeblossom_open`, `gameplay/turtle_egg_hatch_chance`) and the
//! dried ghast's hydration ticks.
// use super::{Dimension, LevelAccess, LevelEvent, Sim, update::below};
// use crate::registry::BlockStateId;
// use horizon_core::{position::BlockPos, random::RandomSource};
// use std::sync::Arc;

/// `BlockScanUtils.findBlocks` order: sections by x, z, y; blocks by y, z, x.
    // rust: pub(crate) fn box_scan_order(min: BlockPos, max: BlockPos) -> Vec<BlockPos> {
    // rust: let mut out = Vec::new();
    // rust: for sx in (min.x >> 4)..=(max.x >> 4) {
    // rust: for sz in (min.z >> 4)..=(max.z >> 4) {
    // rust: for sy in (min.y >> 4)..=(max.y >> 4) {
    // rust: for y in (sy * 16).max(min.y)..=(sy * 16 + 15).min(max.y) {
    // rust: for z in (sz * 16).max(min.z)..=(sz * 16 + 15).min(max.z) {
    // rust: for x in (sx * 16).max(min.x)..=(sx * 16 + 15).min(max.x) {
    // rust: out.push(BlockPos::new(x, y, z));
}
}
}
}
}
}
    // rust: out
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
pub fn day_ticks(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.level.dimension() == Dimension::Overworld)
    // rust: .then(|| self.level.day_time().rem_euclid(24000))
}
    /// `EnvironmentAttributes.EYEBLOSSOM_OPEN` (day timeline: open from 12600
    /// to 23400); None (TriState.DEFAULT) outside the overworld.
pub fn eyeblossom_open(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.day_ticks().map(|t| (12600..23401).contains(&t))
}
    /// `EnvironmentAttributes.TURTLE_EGG_HATCH_CHANCE`: 1.0 around dawn
    /// (21062..21905), otherwise the 0.002 default.
pub fn turtle_hatch_chance(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.day_ticks() {
    // rust: Some(t) if (21062..21905).contains(&t) => 1.0,
    // rust: _ => 0.002,
}
}
pub fn named_state(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.b
    // rust: .table
    // rust: .block_by_name(name)
    // rust: .map(|b| self.b.default_of(b))
}
pub fn play(self: *Self, pos: BlockPos, sound: []const u8, volume: f32, pitch: f32) void {
}
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: Arc::from(sound),
    // rust: volume,
    // rust: pitch,
    // rust: });
}
    /// `EyeblossomBlock.Type.spawnTransformParticle`: four random draws.
pub fn eyeblossom_particle_draws(self: *Self) void {
}
    // rust: for _ in 0..4 {
    // rust: self.random().next_double();
}
}
    /// `EyeblossomBlock.tryChangingState`; `long` picks the random-tick sound.
    // rust: pub(crate) fn eyeblossom_tick(&mut self, state: BlockStateId, pos: BlockPos, long: bool) {
    // rust: let b = self.b;
    // rust: let open = b.table.name(state) == "minecraft:open_eyeblossom";
    // rust: let Some(should_be_open) = self.eyeblossom_open() else {
    // rust: return;
}
    // rust: if should_be_open == open {
    // rust: return;
}
    // rust: let new_name = if open {
    // rust: "minecraft:closed_eyeblossom"
    // rust: } else {
    // rust: "minecraft:open_eyeblossom"
}
    // rust: let Some(next) = self.named_state(new_name) else {
    // rust: return;
}
    // rust: self.set_block_and_update(pos, next);
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: self.eyeblossom_particle_draws();
    // rust: let min = pos.offset(-3, -2, -3);
    // rust: let max = pos.offset(3, 2, 3);
    // rust: let block = b.block(state);
    // rust: for near in box_scan_order(min, max) {
    // rust: if self.state(near) != state {
    // rust: continue;
}
    // rust: let (dx, dy, dz) = (near.x - pos.x, near.y - pos.y, near.z - pos.z);
    // rust: let distance = f64::from(dx * dx + dy * dy + dz * dz).sqrt();
    // rust: let (lo, hi) = ((distance * 5.0) as i32, (distance * 10.0) as i32);
    // rust: let delay = self
    // rust: .random()
    // rust: .next_int_between_inclusive(lo, hi)
    // rust: .unwrap_or(lo);
    // rust: self.schedule_tick(near, block, delay);
}
    // rust: let sound = match (!open, long) {
    // rust: (true, true) => "minecraft:block.eyeblossom.open_long",
    // rust: (true, false) => "minecraft:block.eyeblossom.open",
    // rust: (false, true) => "minecraft:block.eyeblossom.close_long",
    // rust: (false, false) => "minecraft:block.eyeblossom.close",
}
    // rust: self.play(pos, sound, 1.0, 1.0);
}
    /// `FlowerPotBlock.randomTick` for potted eyeblossoms.
    // rust: pub(crate) fn potted_eyeblossom_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: let name = self.b.table.name(state);
    // rust: let open = match name {
    // rust: "minecraft:potted_open_eyeblossom" => true,
    // rust: "minecraft:potted_closed_eyeblossom" => false,
    // rust: _ => return,
}
    // rust: let Some(should_be_open) = self.eyeblossom_open() else {
    // rust: return;
}
    // rust: if open == should_be_open {
    // rust: return;
}
    // rust: let other = if open {
    // rust: "minecraft:potted_closed_eyeblossom"
    // rust: } else {
    // rust: "minecraft:potted_open_eyeblossom"
}
    // rust: let Some(next) = self.named_state(other) else {
    // rust: return;
}
    // rust: self.set_block_and_update(pos, next);
    // rust: self.eyeblossom_particle_draws();
    // rust: let sound = if open {
    // rust: "minecraft:block.eyeblossom.close_long"
    // rust: } else {
    // rust: "minecraft:block.eyeblossom.open_long"
}
    // rust: self.play(pos, sound, 1.0, 1.0);
}
    /// `TurtleEggBlock.randomTick`: crack, then hatch on sand.
    // rust: pub(crate) fn turtle_egg_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let chance = self.turtle_hatch_chance();
    // rust: if !(chance > 0.0 && self.random().next_float() < chance) {
    // rust: return;
}
    // rust: if !b
    // rust: .tag("minecraft:sand")
    // rust: .is_some_and(|t| b.in_set(self.state(below(pos)), t))
    // rust: {
    // rust: return;
}
    // rust: let hatch = b.table.int(state, b.props.hatch);
    // rust: let pitch = 0.9 + self.random().next_float() * 0.2;
    // rust: if hatch < 2 {
    // rust: self.play(pos, "minecraft:entity.turtle.egg_crack", 0.7, pitch);
    // rust: self.set_block(pos, b.table.set_int(state, b.props.hatch, hatch + 1), 2);
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: } else {
    // rust: self.play(pos, "minecraft:entity.turtle.egg_hatch", 0.7, pitch);
    // rust: self.remove_block(pos, false);
    // rust: self.game_event(pos, "minecraft:block_destroy");
    // rust: for _ in 0..b.table.int(state, b.props.eggs) {
    // rust: self.level_event(2001, pos, state.0 as i32);
}
            // Baby turtles are entities the caller spawns (one per egg).
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "hatch_turtles",
    // rust: });
}
}
    /// `SnifferEggBlock.tick`: crack twice, then hatch a snifflet.
    // rust: pub(crate) fn sniffer_egg_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let hatch = b.table.int(state, b.props.hatch);
    // rust: let pitch = 0.9 + self.random().next_float() * 0.2;
    // rust: if hatch < 2 {
    // rust: self.play(pos, "minecraft:block.sniffer_egg.crack", 0.7, pitch);
    // rust: self.set_block(pos, b.table.set_int(state, b.props.hatch, hatch + 1), 2);
    // rust: } else {
    // rust: self.play(pos, "minecraft:block.sniffer_egg.hatch", 0.7, pitch);
    // rust: self.destroy_block(pos, false, 512);
            // The snifflet is an entity the caller spawns.
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "hatch_sniffer",
    // rust: });
}
}
    /// `DriedGhastBlock.tick`: hydrate while waterlogged, dry out otherwise.
    // rust: pub(crate) fn dried_ghast_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let Some(key) = b.table.key_of("hydration") else {
    // rust: return;
}
    // rust: let hydration = b.table.int(state, key);
    // rust: if b.table.bool(state, b.props.waterlogged) {
    // rust: if hydration < 3 {
    // rust: self.play(pos, "minecraft:block.dried_ghast.transition", 1.0, 1.0);
    // rust: self.set_block(pos, b.table.set_int(state, key, hydration + 1), 2);
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: } else {
    // rust: self.remove_block(pos, false);
                // The happy ghastling is an entity the caller spawns.
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "spawn_ghastling",
    // rust: });
}
    // rust: } else if hydration > 0 {
    // rust: self.set_block(pos, b.table.set_int(state, key, hydration - 1), 2);
    // rust: self.game_event(pos, "minecraft:block_change");
}
}
    /// `DriedGhastBlock.randomTick`: keep a 5000-tick hydration tick scheduled.
    // rust: pub(crate) fn dried_ghast_random_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let hydration = b
    // rust: .table
    // rust: .key_of("hydration")
    // rust: .map_or(0, |k| b.table.int(state, k));
    // rust: let block = b.block(state);
    // rust: if (b.table.bool(state, b.props.waterlogged) || hydration > 0)
    // rust: && !self.ticks.has_block_tick(pos, block)
    // rust: {
    // rust: self.schedule_tick(pos, block, 5000);
}
}
}
