//! Transpiled from Horizon Rust crate
//! Module: horizon-world_pistons
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Pistons: `PistonBaseBlock` (signal checks, block events, `moveBlocks`),
//! `PistonStructureResolver`, `PistonHeadBlock`, and the
//! `PistonMovingBlockEntity` progress ticking, plus the level's block-event
//! queue (`ServerLevel.blockEvent` / `runBlockEvents`).
//!
//! Entity pushing by moving blocks is the caller's (see `piston_movement`).
// use super::{
    // rust: Behaviours, LevelAccess, LevelEvent, Sim, Ticks,
    // rust: data::PushReaction,
    // rust: states::BlockId,
    // rust: update::{above, rel},
}
// use crate::{
    // rust: java_hash_map::{JavaHashMap, JavaKey},
    // rust: registry::BlockStateId,
}
// use horizon_core::{geometry::Direction, position::BlockPos, random::RandomSource};
// use std::cmp::Ordering;

/// `PistonMovingBlockEntity` state, owned by [`Ticks::moving_pistons`].
pub const MovingPiston = struct {
    moved_state: BlockStateId,
    direction: Direction,
    extending: bool,
    source: bool,
    progress: f32,
    progress_o: f32,
    last_ticked: i64,
    /// `PistonMovingBlockEntity.deathTicks`: on a client the entity waits
    /// five ticks past progress 1.0 before placing the block itself.
    death_ticks: i32,
    /// Identity of this block entity (a replaced entity is a new ticker).
    id: u64,
};
    // rust: impl MovingPiston {
    /// What collision and rendering need from this block entity.
pub fn shape_state(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::piston_shape::MovingPistonState {
    // rust: moved_state: self.moved_state,
    // rust: direction: self.direction,
    // rust: extending: self.extending,
    // rust: source: self.source,
    // rust: progress: self.progress,
    // rust: previous_progress: self.progress_o,
}
}
pub fn movement_direction(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.extending {
    // rust: self.direction
    // rust: } else {
    // rust: self.direction.opposite()
}
}
}

/// `MovingPistonBlock.getDrops`: a broken moving piston drops as the block its
/// block entity is moving, and drops nothing when that block entity is gone
/// (vanilla returns `Collections.emptyList()`). Every other block drops as
/// itself.
    // rust: pub(crate) fn dropped_state(
    // rust: b: &Behaviours,
    // rust: moving: &[(BlockPos, MovingPiston)],
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: ) -> Option<BlockStateId> {
    // rust: if !b.is_block(state, b.named.moving_piston) {
    // rust: return Some(state);
}
    // rust: moving
    // rust: .iter()
    // rust: .find(|(p, _)| *p == pos)
    // rust: .map(|(_, piston)| piston.moved_state)
}

/// `BlockEventData`.
pub const BlockEventData = struct {
    pos: BlockPos,
    block: BlockId,
    param_a: i32,
    param_b: i32,
};

pub const PosKey = struct {};
    // rust: impl JavaKey for PosKey {
pub fn java_hash(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.0.y.wrapping_add(self.0.z.wrapping_mul(31)))
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(self.0.x)
}
pub fn comparable_compare(self: *Self, other: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
        // Vec3i implements Comparable: y, then z, then x.
    // rust: Some(
    // rust: self.0
    // rust: .y
    // rust: .cmp(&other.0.y)
    // rust: .then(self.0.z.cmp(&other.0.z))
    // rust: .then(self.0.x.cmp(&other.0.x)),
    // rust: )
}
pub fn tie_break(self: *Self, _other: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ordering::Less
}
}

pub const Resolver = struct {
    piston_pos: BlockPos,
    extending: bool,
    start: BlockPos,
    push_direction: Direction,
    piston_direction: Direction,
    to_push: std.ArrayList(BlockPos),
    to_destroy: std.ArrayList(BlockPos),
};

pub fn rel_n(pos: BlockPos, direction: Direction, n: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = direction.normal();
    // rust: pos.offset(x * n, y * n, z * n)
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    // ---- block events ----
    // rust: pub(crate) fn block_event(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: param_a: i32,
    // rust: param_b: i32,
    // rust: ) {
    // rust: let event = BlockEventData {
    // rust: pos,
    // rust: block,
    // rust: param_a,
    // rust: param_b,
}
    // rust: if !self.ticks.block_events.contains(&event) {
    // rust: self.ticks.block_events.push(event);
}
}
    /// `BlockState.triggerEvent`.
pub fn trigger_event(self: *Self, state: BlockStateId, pos: BlockPos, a: i32, b: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = self.b.data(state);
    // rust: if data.is(super::classes::Class::PistonBase) {
    // rust: self.piston_trigger_event(pos, state, a, b)
    // rust: } else if data.is(super::classes::Class::Note) {
    // rust: self.note_trigger_event(pos, state);
    // rust: true
    // rust: } else if data.is(super::classes::Class::Bell) {
            // BellBlockEntity.triggerEvent handles event 1; the caller
            // reports handled events (`runBlockEvents` broadcasts them).
    // rust: a == 1
    // rust: } else if data.is(super::classes::Class::PotentSulfur) {
            // PotentSulfurBlock.triggerEvent: the block entity notes the
            // eruption's game time (the caller's), and the event is handled.
    // rust: true
    // rust: } else {
    // rust: false
}
}

    // ---- moving piston block entities ----
    // rust: pub(crate) fn moving_piston(&self, pos: BlockPos) -> Option<MovingPiston> {
    // rust: self.ticks
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .find(|(p, _)| *p == pos)
    // rust: .map(|(_, m)| *m)
}
pub fn set_moving_piston(self: *Self, pos: BlockPos, mut piston: MovingPiston) void {
}
    // rust: self.ticks.moving_pistons.retain(|(p, _)| *p != pos);
    // rust: self.ticks.next_block_entity_id += 1;
    // rust: piston.id = self.ticks.next_block_entity_id;
    // rust: self.ticks.moving_pistons.push((pos, piston));
}
    // rust: pub(crate) fn remove_moving_piston(&mut self, pos: BlockPos) -> Option<MovingPiston> {
    // rust: let index = self
    // rust: .ticks
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .position(|(p, _)| *p == pos)?;
    // rust: Some(self.ticks.moving_pistons.remove(index).1)
}
    /// `PistonMovingBlockEntity.finalTick`.
pub fn moving_piston_final_tick(self: *Self, pos: BlockPos) void {
}
    // rust: let Some(piston) = self.moving_piston(pos) else {
    // rust: return;
}
        // finalTick: `progressO < 1.0 || level.isClientSide` — a client
        // finishes its copy even at full progress.
    // rust: if piston.progress_o >= 1.0 && !self.level.is_client_side() {
    // rust: return;
}
    // rust: self.remove_moving_piston(pos);
    // rust: let b = self.b;
    // rust: if b.is_block(self.state(pos), b.named.moving_piston) {
    // rust: let new = if piston.source {
    // rust: b.air()
    // rust: } else {
    // rust: self.update_from_neighbour_shapes(piston.moved_state, pos)
}
    // rust: self.set_block_and_update(pos, new);
    // rust: let block = b.block(new);
    // rust: let orientation = self.initial_orientation(Some(piston.movement_direction()), None);
    // rust: self.neighbor_changed_at_oriented(pos, block, orientation);
}
}
    /// `PistonMovingBlockEntity.tick`. A piston that is still moving reports
    /// the push `moveCollidedEntities` would do at its new progress; the caller
    /// moves the entities, because `Ticks` has none (`piston_pushes`).
pub fn moving_piston_tick(self: *Self, pos: BlockPos) void {
}
    // rust: let Some(mut piston) = self.moving_piston(pos) else {
    // rust: return;
}
    // rust: let b = self.b;
    // rust: piston.last_ticked = self.level.game_time();
    // rust: piston.progress_o = piston.progress;
    // rust: if piston.progress_o >= 1.0 {
    // rust: if self.level.is_client_side() && piston.death_ticks < 5 {
                // The client's copy waits for the server's state before
                // placing the block itself (deathTicks < 5).
    // rust: piston.death_ticks += 1;
    // rust: if let Some(entry) = self
    // rust: .ticks
    // rust: .moving_pistons
    // rust: .iter_mut()
    // rust: .find(|(p, _)| *p == pos)
    // rust: {
    // rust: entry.1 = piston;
}
    // rust: return;
}
    // rust: self.remove_moving_piston(pos);
    // rust: if b.is_block(self.state(pos), b.named.moving_piston) {
    // rust: let mut new = self.update_from_neighbour_shapes(piston.moved_state, pos);
    // rust: if b.is_air(new) {
    // rust: self.set_block(pos, piston.moved_state, 340);
    // rust: self.update_or_destroy(
    // rust: piston.moved_state,
    // rust: new,
    // rust: pos,
    // rust: 3,
    // rust: super::flags::UPDATE_LIMIT,
    // rust: );
    // rust: } else {
    // rust: if b.is_waterlogged(new) {
    // rust: new = b.table.set_bool(new, b.props.waterlogged, false);
}
    // rust: self.set_block(pos, new, 67);
    // rust: let block = b.block(new);
    // rust: let orientation =
    // rust: self.initial_orientation(Some(piston.movement_direction()), None);
    // rust: self.neighbor_changed_at_oriented(pos, block, orientation);
}
}
    // rust: } else {
            // moveCollidedEntities and moveStuckEntities run with the new
            // progress but read the old one off the entity (their delta),
            // so the push carries the piston as it was before the advance.
    // rust: let old = piston;
    // rust: let new_progress = (old.progress + 0.5).min(1.0);
    // rust: let current = self
    // rust: .ticks
    // rust: .moving_pistons
    // rust: .iter_mut()
    // rust: .find(|(p, _)| *p == pos);
    // rust: if let Some(entry) = current {
    // rust: piston.progress = new_progress;
    // rust: entry.1 = piston;
    // rust: self.ticks.piston_pushes.push((pos, old, new_progress));
}
}
}

    // ---- PistonBaseBlock ----
pub fn is_sticky_piston(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.b.is_block(state, self.b.named.sticky_piston)
}
pub fn piston_neighbor_signal(self: *Self, pos: BlockPos, push: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for direction in Direction::ALL {
    // rust: if direction != push && self.has_signal(rel(pos, direction), direction) {
    // rust: return true;
}
}
    // rust: if self.has_signal(pos, Direction::Down) {
    // rust: return true;
}
    // rust: let up = above(pos);
    // rust: Direction::ALL.into_iter().any(|direction| {
    // rust: direction != Direction::Down && self.has_signal(rel(up, direction), direction)
    // rust: })
}
    /// `PistonBaseBlock.checkIfExtend`, which `neighborChanged`, `onPlace`
    /// and `setPlacedBy` call only server-side: a client moves its pistons on
    /// the server's block events alone.
    // rust: pub(crate) fn piston_check_if_extend(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: if self.level.is_client_side() {
    // rust: return;
}
    // rust: let b = self.b;
    // rust: let direction = b.facing(state);
    // rust: let extend = self.piston_neighbor_signal(pos, direction);
    // rust: let extended = b.table.bool(state, b.props.extended);
    // rust: let block = b.block(state);
    // rust: if extend && !extended {
    // rust: if self.piston_resolve(pos, direction, true).is_some() {
    // rust: self.block_event(pos, block, 0, direction as i32);
}
    // rust: } else if !extend && extended {
    // rust: let pushed_pos = rel_n(pos, direction, 2);
    // rust: let pushed = self.state(pushed_pos);
    // rust: let mut event = 1;
    // rust: if b.is_block(pushed, b.named.moving_piston) && b.facing(pushed) == direction {
    // rust: if let Some(piston) = self.moving_piston(pushed_pos) {
    // rust: if piston.extending
    // rust: && (piston.progress_o < 0.5
    // rust: || self.level.game_time() == piston.last_ticked
    // rust: || self.ticks.handling_tick)
    // rust: {
    // rust: event = 2;
}
}
}
    // rust: self.block_event(pos, block, event, direction as i32);
}
}
    /// `PistonBaseBlock.isPushable`.
    // rust: fn is_pushable(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: allow_destroyable: bool,
    // rust: connection: Direction,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let (min_y, max_y) = (self.level.min_y(), self.level.max_y() - 1);
    // rust: if pos.y < min_y || pos.y > max_y {
    // rust: return false;
}
    // rust: if b.is_air(state) {
    // rust: return true;
}
    // rust: if direction == Direction::Down && pos.y == min_y {
    // rust: return false;
}
    // rust: if direction == Direction::Up && pos.y == max_y {
    // rust: return false;
}
    // rust: let is_piston =
    // rust: b.is_block(state, b.named.piston) || b.is_block(state, b.named.sticky_piston);
    // rust: if !is_piston {
    // rust: if b.facts(state).hardness == -1.0 {
    // rust: return false;
}
    // rust: match b.facts(state).push {
    // rust: PushReaction::Immoveable => return false,
    // rust: PushReaction::Popped => return allow_destroyable,
    // rust: PushReaction::Push => return direction == connection,
    // rust: _ => {}
}
    // rust: } else if b.table.bool(state, b.props.extended) {
    // rust: return false;
}
    // rust: !b.has_flag(state, super::data::state_flags::BLOCK_ENTITY)
    // rust: && !self.level.has_mod_block_entity(pos)
}
pub fn is_slime_or_honey(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.b.is_block(state, self.b.named.slime_block)
    // rust: || self.b.is_block(state, self.b.named.honey_block)
}
pub fn can_stick(self: *Self, first: BlockStateId, second: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = self.b.named;
    // rust: let (honey1, slime1) = (
    // rust: self.b.is_block(first, n.honey_block),
    // rust: self.b.is_block(first, n.slime_block),
    // rust: );
    // rust: let (honey2, slime2) = (
    // rust: self.b.is_block(second, n.honey_block),
    // rust: self.b.is_block(second, n.slime_block),
    // rust: );
    // rust: if (honey1 && slime2) || (slime1 && honey2) {
    // rust: return false;
}
    // rust: self.is_slime_or_honey(first) || self.is_slime_or_honey(second)
}
    /// `PistonStructureResolver.resolve`; None when the structure cannot move.
    // rust: fn piston_resolve(
    // rust: &self,
    // rust: piston_pos: BlockPos,
    // rust: direction: Direction,
    // rust: extending: bool,
    // rust: ) -> Option<(Vec<BlockPos>, Vec<BlockPos>, Direction)> {
    // rust: let mut r = Resolver {
    // rust: piston_pos,
    // rust: extending,
    // rust: start: if extending {
    // rust: rel(piston_pos, direction)
    // rust: } else {
    // rust: rel_n(piston_pos, direction, 2)
    // rust: },
    // rust: push_direction: if extending {
    // rust: direction
    // rust: } else {
    // rust: direction.opposite()
    // rust: },
    // rust: piston_direction: direction,
    // rust: to_push: Vec::new(),
    // rust: to_destroy: Vec::new(),
}
    // rust: let next = self.state(r.start);
    // rust: if !self.is_pushable(next, r.start, r.push_direction, false, r.piston_direction) {
    // rust: if r.extending && self.b.facts(next).push == PushReaction::Popped {
    // rust: r.to_destroy.push(r.start);
    // rust: return Some((r.to_push, r.to_destroy, r.push_direction));
}
    // rust: return None;
}
    // rust: let start = r.start;
    // rust: let push = r.push_direction;
    // rust: if !self.add_block_line(&mut r, start, push) {
    // rust: return None;
}
    // rust: let mut i = 0;
    // rust: while i < r.to_push.len() {
    // rust: let pos = r.to_push[i];
    // rust: if self.is_slime_or_honey(self.state(pos)) && !self.add_branching_blocks(&mut r, pos) {
    // rust: return None;
}
    // rust: i += 1;
}
    // rust: Some((r.to_push, r.to_destroy, r.push_direction))
}
pub fn add_block_line(self: *Self, r: *mut Resolver, start: BlockPos, direction: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut next = self.state(start);
    // rust: if self.b.is_air(next) {
    // rust: return true;
}
    // rust: if !self.is_pushable(next, start, r.push_direction, false, direction)
    // rust: || start == r.piston_pos
    // rust: || r.to_push.contains(&start)
    // rust: {
    // rust: return true;
}
    // rust: let mut count = 1;
    // rust: if count + r.to_push.len() > 12 {
    // rust: return false;
}
    // rust: while self.is_slime_or_honey(next) {
    // rust: let pos = rel_n(start, r.push_direction.opposite(), count as i32);
    // rust: let previous = next;
    // rust: next = self.state(pos);
    // rust: if self.b.is_air(next)
    // rust: || !self.can_stick(previous, next)
    // rust: || !self.is_pushable(
    // rust: next,
    // rust: pos,
    // rust: r.push_direction,
    // rust: false,
    // rust: r.push_direction.opposite(),
    // rust: )
    // rust: || pos == r.piston_pos
    // rust: {
    // rust: break;
}
    // rust: count += 1;
    // rust: if count + r.to_push.len() > 12 {
    // rust: return false;
}
}
    // rust: let mut added = 0;
    // rust: for i in (0..count).rev() {
    // rust: r.to_push
    // rust: .push(rel_n(start, r.push_direction.opposite(), i as i32));
    // rust: added += 1;
}
    // rust: let mut i = 1;
    // rust: loop {
    // rust: let pos = rel_n(start, r.push_direction, i);
    // rust: if let Some(collision) = r.to_push.iter().position(|p| *p == pos) {
    // rust: self.reorder_at_collision(r, added, collision);
    // rust: for j in 0..=collision + added {
    // rust: let block_pos = r.to_push[j];
    // rust: if self.is_slime_or_honey(self.state(block_pos))
    // rust: && !self.add_branching_blocks(r, block_pos)
    // rust: {
    // rust: return false;
}
}
    // rust: return true;
}
    // rust: next = self.state(pos);
    // rust: if self.b.is_air(next) {
    // rust: return true;
}
    // rust: if !self.is_pushable(next, pos, r.push_direction, true, r.push_direction)
    // rust: || pos == r.piston_pos
    // rust: {
    // rust: return false;
}
    // rust: if self.b.facts(next).push == PushReaction::Popped {
    // rust: r.to_destroy.push(pos);
    // rust: return true;
}
    // rust: if r.to_push.len() >= 12 {
    // rust: return false;
}
    // rust: r.to_push.push(pos);
    // rust: added += 1;
    // rust: i += 1;
}
}
pub fn reorder_at_collision(self: *Self, r: *mut Resolver, added: usize, collision: usize) void {
}
    // rust: let len = r.to_push.len();
    // rust: let head: Vec<BlockPos> = r.to_push[..collision].to_vec();
    // rust: let last_line: Vec<BlockPos> = r.to_push[len - added..].to_vec();
    // rust: let middle: Vec<BlockPos> = r.to_push[collision..len - added].to_vec();
    // rust: r.to_push.clear();
    // rust: r.to_push.extend(head);
    // rust: r.to_push.extend(last_line);
    // rust: r.to_push.extend(middle);
}
pub fn add_branching_blocks(self: *Self, r: *mut Resolver, from: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let from_state = self.state(from);
    // rust: for direction in Direction::ALL {
    // rust: if super::query::axis_of(direction) != super::query::axis_of(r.push_direction) {
    // rust: let neighbour = rel(from, direction);
    // rust: let neighbour_state = self.state(neighbour);
    // rust: if self.can_stick(neighbour_state, from_state)
    // rust: && !self.add_block_line(r, neighbour, direction)
    // rust: {
    // rust: return false;
}
}
}
    // rust: true
}
pub fn moving_piston_state(self: *Self, direction: Direction, sticky: bool) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let state = b.table.set_dir(
    // rust: b.default_of(b.named.moving_piston),
    // rust: b.props.facing,
    // rust: direction,
    // rust: );
    // rust: b.table.set_text(
    // rust: state,
    // rust: b.props.kind,
    // rust: if sticky { "sticky" } else { "normal" },
    // rust: )
}
    /// `PistonBaseBlock.moveBlocks`: whether the blocks moved, or None when
    /// the level refused the move (`LevelAccess::allow_piston_move`).
    // rust: fn piston_move_blocks(
    // rust: &mut self,
    // rust: piston_pos: BlockPos,
    // rust: direction: Direction,
    // rust: extending: bool,
    // rust: sticky: bool,
    // rust: ) -> Option<bool> {
    // rust: let b = self.b;
    // rust: let arm = rel(piston_pos, direction);
    // rust: if !extending && b.is_block(self.state(arm), b.named.piston_head) {
    // rust: self.set_block(arm, b.air(), 276);
}
    // rust: let Some((to_push, to_destroy, push_direction)) =
    // rust: self.piston_resolve(piston_pos, direction, extending)
    // rust: else {
    // rust: return Some(false);
}
    // rust: if !self
    // rust: .level
    // rust: .allow_piston_move(piston_pos, push_direction, &to_push, &to_destroy)
    // rust: {
    // rust: return None;
}
    // rust: let mut delete_after: JavaHashMap<PosKey, BlockStateId> = JavaHashMap::default();
    // rust: let mut shapes = Vec::with_capacity(to_push.len());
    // rust: for pos in &to_push {
    // rust: let state = self.state(*pos);
    // rust: shapes.push(state);
    // rust: delete_after.put(PosKey(*pos), state);
}
    // rust: let mut to_update = Vec::with_capacity(to_push.len() + to_destroy.len());
    // rust: let move_direction = if extending {
    // rust: direction
    // rust: } else {
    // rust: direction.opposite()
}
    // rust: for pos in to_destroy.iter().rev() {
    // rust: let state = self.state(*pos);
    // rust: self.drop_resources(state, *pos);
            // The client's copy plays the destroy effect itself (the
            // server sends no 2001 for piston moves).
    // rust: let fire = b.is_block(state, b.named.fire) || b.is_block(state, b.named.soul_fire);
    // rust: if !fire && self.level.is_client_side() {
    // rust: self.level_event(2001, *pos, state.0 as i32);
}
    // rust: self.set_block(*pos, b.air(), 18);
    // rust: self.game_event(*pos, "minecraft:block_destroy");
    // rust: to_update.push(state);
}
    // rust: for (i, pos) in to_push.iter().enumerate().rev() {
    // rust: let state = self.state(*pos);
    // rust: let target = rel(*pos, move_direction);
    // rust: delete_after.remove(&PosKey(target));
    // rust: let moving = b.table.set_dir(
    // rust: b.default_of(b.named.moving_piston),
    // rust: b.props.facing,
    // rust: direction,
    // rust: );
    // rust: self.set_block(target, moving, 324);
    // rust: self.set_moving_piston(
    // rust: target,
    // rust: MovingPiston {
    // rust: moved_state: shapes[i],
    // rust: direction,
    // rust: extending,
    // rust: source: false,
    // rust: progress: 0.0,
    // rust: progress_o: 0.0,
    // rust: last_ticked: 0,
    // rust: death_ticks: 0,
    // rust: id: 0,
    // rust: },
    // rust: );
    // rust: to_update.push(state);
}
    // rust: if extending {
    // rust: let head = b.table.set_text(
    // rust: b.table
    // rust: .set_dir(b.default_of(b.named.piston_head), b.props.facing, direction),
    // rust: b.props.kind,
    // rust: if sticky { "sticky" } else { "normal" },
    // rust: );
    // rust: let moving = self.moving_piston_state(direction, sticky);
    // rust: delete_after.remove(&PosKey(arm));
    // rust: self.set_block(arm, moving, 324);
    // rust: self.set_moving_piston(
    // rust: arm,
    // rust: MovingPiston {
    // rust: moved_state: head,
    // rust: direction,
    // rust: extending: true,
    // rust: source: true,
    // rust: progress: 0.0,
    // rust: progress_o: 0.0,
    // rust: last_ticked: 0,
    // rust: death_ticks: 0,
    // rust: id: 0,
    // rust: },
    // rust: );
}
    // rust: let air = b.air();
    // rust: let entries: Vec<(BlockPos, BlockStateId)> =
    // rust: delete_after.entries().map(|(k, v)| (k.0, *v)).collect();
    // rust: for (pos, _) in &entries {
    // rust: self.set_block(*pos, air, 82);
}
    // rust: for (pos, old) in &entries {
    // rust: self.update_indirect_neighbour_shapes(*old, *pos, 2, super::flags::UPDATE_LIMIT);
    // rust: self.update_neighbour_shapes(air, *pos, 2, super::flags::UPDATE_LIMIT);
    // rust: self.update_indirect_neighbour_shapes(air, *pos, 2, super::flags::UPDATE_LIMIT);
}
    // rust: let orientation = self.initial_orientation(Some(push_direction), None);
    // rust: let mut index = 0;
    // rust: for pos in to_destroy.iter().rev() {
    // rust: let state = to_update[index];
    // rust: index += 1;
    // rust: self.affect_neighbors_after_removal(state, *pos, false);
    // rust: self.update_indirect_neighbour_shapes(state, *pos, 2, super::flags::UPDATE_LIMIT);
    // rust: let block = b.block(state);
    // rust: self.update_neighbors_at_oriented(*pos, block, orientation);
}
    // rust: for pos in to_push.iter().rev() {
    // rust: let block = b.block(to_update[index]);
    // rust: index += 1;
    // rust: self.update_neighbors_at_oriented(*pos, block, orientation);
}
    // rust: if extending {
    // rust: self.update_neighbors_at_oriented(arm, b.named.piston_head, orientation);
}
    // rust: Some(true)
}
    /// `PistonBaseBlock.triggerEvent`.
    // rust: fn piston_trigger_event(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: a: i32,
    // rust: param_b: i32,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let direction = b.facing(state);
    // rust: let extended_state = b.table.set_bool(state, p.extended, true);
    // rust: let sticky = self.is_sticky_piston(state);
        // A pull the level refused isn't sent: clients, who aren't asked,
        // would replay it, so they get the blocks' changes instead.
    // rust: let mut refused = false;
        // The signal re-check is server-only (`!level.isClientSide`): a
        // client trusts the event as sent.
    // rust: if !self.level.is_client_side() {
    // rust: let extend = self.piston_neighbor_signal(pos, direction);
    // rust: if extend && (a == 1 || a == 2) {
    // rust: self.set_block(pos, extended_state, 2);
    // rust: return false;
}
    // rust: if !extend && a == 0 {
    // rust: return false;
}
}
    // rust: if a == 0 {
    // rust: if self.piston_move_blocks(pos, direction, true, sticky) != Some(true) {
    // rust: return false;
}
    // rust: self.set_block(pos, extended_state, 67);
    // rust: let pitch = self.random().next_float() * 0.25 + 0.6;
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.piston.extend".into(),
    // rust: volume: 0.5,
    // rust: pitch,
    // rust: });
    // rust: self.game_event(pos, "minecraft:block_activate");
    // rust: } else if a == 1 || a == 2 {
    // rust: self.moving_piston_final_tick(rel(pos, direction));
    // rust: let moving = self.moving_piston_state(direction, sticky);
    // rust: self.set_block(pos, moving, 276);
    // rust: let piston_default = b.table.set_dir(
    // rust: b.default_of(b.block(state)),
    // rust: p.facing,
    // rust: Direction::ALL[(param_b & 7).min(5) as usize],
    // rust: );
    // rust: self.set_moving_piston(
    // rust: pos,
    // rust: MovingPiston {
    // rust: moved_state: piston_default,
    // rust: direction,
    // rust: extending: false,
    // rust: source: true,
    // rust: progress: 0.0,
    // rust: progress_o: 0.0,
    // rust: last_ticked: 0,
    // rust: death_ticks: 0,
    // rust: id: 0,
    // rust: },
    // rust: );
    // rust: self.update_neighbors_at(pos, b.named.moving_piston);
    // rust: self.update_neighbour_shapes(moving, pos, 2, super::flags::UPDATE_LIMIT);
    // rust: if sticky {
    // rust: let two = rel_n(pos, direction, 2);
    // rust: let moving_state = self.state(two);
    // rust: let mut piston_piece = false;
    // rust: if b.is_block(moving_state, b.named.moving_piston) {
    // rust: if let Some(entity) = self.moving_piston(two) {
    // rust: if entity.direction == direction && entity.extending {
    // rust: self.moving_piston_final_tick(two);
    // rust: piston_piece = true;
}
}
}
    // rust: if !piston_piece {
    // rust: let is_piston = b.is_block(moving_state, b.named.piston)
    // rust: || b.is_block(moving_state, b.named.sticky_piston);
    // rust: if a != 1
    // rust: || b.is_air(moving_state)
    // rust: || !self.is_pushable(
    // rust: moving_state,
    // rust: two,
    // rust: direction.opposite(),
    // rust: false,
    // rust: direction,
    // rust: )
    // rust: || (b.facts(moving_state).push != PushReaction::PushPull && !is_piston)
    // rust: {
    // rust: self.remove_block(rel(pos, direction), false);
    // rust: } else {
    // rust: refused = self
    // rust: .piston_move_blocks(pos, direction, false, sticky)
    // rust: .is_none();
}
}
    // rust: } else {
    // rust: self.remove_block(rel(pos, direction), false);
}
    // rust: let pitch = self.random().next_float() * 0.15 + 0.6;
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.piston.contract".into(),
    // rust: volume: 0.5,
    // rust: pitch,
    // rust: });
    // rust: self.game_event(pos, "minecraft:block_deactivate");
}
    // rust: !refused
}

    // ---- PistonHeadBlock ----
    // rust: pub(crate) fn piston_head_fitting_base(&self, head: BlockStateId, base: BlockStateId) -> bool {
    // rust: let b = self.b;
    // rust: let expected = if b.table.text(head, b.props.kind) == "sticky" {
    // rust: b.named.sticky_piston
    // rust: } else {
    // rust: b.named.piston
}
    // rust: b.is_block(base, expected)
    // rust: && b.table.bool(base, b.props.extended)
    // rust: && b.facing(base) == b.facing(head)
}
    // rust: pub(crate) fn piston_head_can_survive(&self, head: BlockStateId, pos: BlockPos) -> bool {
    // rust: let b = self.b;
    // rust: let base = self.rel_state(pos, b.facing(head).opposite());
    // rust: self.piston_head_fitting_base(head, base)
    // rust: || (b.is_block(base, b.named.moving_piston) && b.facing(base) == b.facing(head))
}
}

    // rust: impl Behaviours {
    /// `ServerLevel.runBlockEvents`: run queued block events (piston moves).
    /// Call once per tick after scheduled and random ticks.
    // rust: pub fn run_block_events<L: LevelAccess + ?Sized>(&self, level: &mut L, ticks: &mut Ticks) {
    // rust: let mut reschedule = Vec::new();
    // rust: while !ticks.block_events.is_empty() {
    // rust: let event = ticks.block_events.remove(0);
    // rust: if !level.is_ticking_chunk(event.pos.chunk()) {
    // rust: reschedule.push(event);
    // rust: continue;
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(event.pos);
    // rust: if self.block(state) == event.block
    // rust: && sim.trigger_event(state, event.pos, event.param_a, event.param_b)
    // rust: {
                // ServerLevel.runBlockEvents broadcasts a handled event to
                // the clients (`ClientboundBlockEventPacket`); their copy of
                // the block re-runs `triggerEvent` (a piston's `moveBlocks`).
    // rust: sim.emit(LevelEvent::BlockEntityEvent {
    // rust: pos: event.pos,
    // rust: state,
    // rust: a: event.param_a,
    // rust: b: event.param_b,
    // rust: });
}
}
    // rust: for event in reschedule {
    // rust: if !ticks.block_events.contains(&event) {
    // rust: ticks.block_events.push(event);
}
}
}
    /// `Level.tickBlockEntities` for moving pistons (the only block entities
    /// whose ticking changes blocks). Entries added during the pass wait for
    /// the next tick, as vanilla's pending tickers do.
    // rust: pub fn tick_block_entities<L: LevelAccess + ?Sized>(&self, level: &mut L, ticks: &mut Ticks) {
    // rust: let tickers: Vec<(BlockPos, u64)> = ticks
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .map(|(p, m)| (*p, m.id))
    // rust: .collect();
    // rust: for (pos, id) in tickers {
    // rust: if !level.is_ticking_chunk(pos.chunk())
    // rust: || !ticks
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .any(|(p, m)| *p == pos && m.id == id)
    // rust: {
    // rust: continue;
}
    // rust: self.sim(level, ticks).moving_piston_tick(pos);
}
}
    /// `ClientLevel.blockEvent`: the client re-runs the block's
    /// `triggerEvent` on its own level (a piston's `moveBlocks` builds the
    /// moving block entities it then animates) instead of waiting for the
    /// server's states. No queue and no ticking-chunk gate: a client runs
    /// the event where the packet lands.
    // rust: pub fn client_block_event<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: a: i32,
    // rust: b: i32,
    // rust: ) -> bool {
    // rust: let triggered = {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: let triggered = sim.trigger_event(state, pos, a, b);
    // rust: if triggered {
                // The client's copy of a handled event reaches the client
                // copy of the block entity (a bell's ring).
    // rust: sim.emit(LevelEvent::BlockEntityEvent { pos, state, a, b });
}
    // rust: triggered
}
    // rust: self.client_drain_block_events(level, ticks);
    // rust: triggered
}
    /// `ClientLevel.tickBlockEntities` for moving pistons: the client copy of
    /// [`Behaviours::tick_block_entities`], without the server's
    /// ticking-chunk gate (a client ticks every loaded block entity). One
    /// whose block was replaced is dropped (`TickingBlockEntity.isRemoved`).
    // rust: pub fn client_tick_block_entities<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: ) {
    // rust: let tickers: Vec<(BlockPos, u64)> = ticks
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .map(|(p, m)| (*p, m.id))
    // rust: .collect();
    // rust: for (pos, id) in tickers {
    // rust: if !ticks
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .any(|(p, m)| *p == pos && m.id == id)
    // rust: {
    // rust: continue;
}
    // rust: {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: if sim.b.is_block(state, sim.b.named.moving_piston) {
    // rust: sim.moving_piston_tick(pos);
    // rust: } else {
    // rust: sim.remove_moving_piston(pos);
}
}
    // rust: self.client_drain_block_events(level, ticks);
}
}
    /// Block events a client-side `triggerEvent` queued
    /// (`PistonBaseBlock.checkIfExtend` in a neighbour update): a client
    /// runs them as they come (`ClientLevel.blockEvent`), not in a tick pass.
    // rust: fn client_drain_block_events<L: LevelAccess + ?Sized>(&self, level: &mut L, ticks: &mut Ticks) {
    // rust: while let Some(event) = ticks.block_events.first().copied() {
    // rust: ticks.block_events.remove(0);
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(event.pos);
    // rust: if self.block(state) == event.block
    // rust: && sim.trigger_event(state, event.pos, event.param_a, event.param_b)
    // rust: {
    // rust: sim.emit(LevelEvent::BlockEntityEvent {
    // rust: pos: event.pos,
    // rust: state,
    // rust: a: event.param_a,
    // rust: b: event.param_b,
    // rust: });
}
}
}
}
