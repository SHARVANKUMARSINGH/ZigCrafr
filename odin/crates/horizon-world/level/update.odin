//! Transpiled from Horizon Rust crate
package horizon_world_update

import "core:fmt"
import "core:mem"
import "core:math"

// `Level.setBlock`, `LevelChunk.setBlockState` and the
// `CollectingNeighborUpdater` that orders neighbour and shape updates.
// use super::{
    // rust: LevelAccess, LevelEvent, Sim, classes::Class, flags, orientation::Orientation, states::BlockId,
}
// use crate::{fluid::FluidState, registry::BlockStateId};
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
    // rust: ticks::{ScheduleResult, TickPriority},
}

// `NeighborUpdater.UPDATE_ORDER`.
    // rust: pub(crate) const UPDATE_ORDER: [Direction; 6] = [
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: Direction::Down,
    // rust: Direction::Up,
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: ];
// `BlockBehaviour.UPDATE_SHAPE_ORDER`.
    // rust: pub(crate) const UPDATE_SHAPE_ORDER: [Direction; 6] = [
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: Direction::Down,
    // rust: Direction::Up,
    // rust: ];
    // rust: pub(crate) const HORIZONTAL: [Direction; 4] = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ];

// `MinecraftServer.getMaxChainedNeighborUpdates` default.
MAX_CHAINED_NEIGHBOR_UPDATES :: 1_000_000

    // rust: pub(crate) fn rel(pos: BlockPos, direction: Direction) -> BlockPos {
    // rust: let [x, y, z] = direction.normal();
    // rust: pos.offset(x, y, z)
}
    // rust: pub(crate) fn above(pos: BlockPos) -> BlockPos {
    // rust: pos.offset(0, 1, 0)
}
    // rust: pub(crate) fn below(pos: BlockPos) -> BlockPos {
    // rust: pos.offset(0, -1, 0)
}

Update :: enum {
    Shape {,
    direction: Direction,
    neighbor_state: BlockStateId,
    pos: BlockPos,
    neighbor_pos: BlockPos,
    flags: i32,
    limit: i32,
    // rust: },
    Simple {,
    pos: BlockPos,
    block: BlockId,
    orientation: Option<Orientation>,
    // rust: },
    Full {,
    state: BlockStateId,
    pos: BlockPos,
    block: BlockId,
    orientation: Option<Orientation>,
    moved: bool,
    // rust: },
    Multi {,
    source: BlockPos,
    block: BlockId,
    orientation: Option<Orientation>,
    skip: Option<Direction>,
    index: usize,
    // rust: },
}

Step :: enum {
    Shape {,
    direction: Direction,
    neighbor_state: BlockStateId,
    pos: BlockPos,
    neighbor_pos: BlockPos,
    flags: i32,
    limit: i32,
    // rust: },
    Neighbor {,
    state: Option<BlockStateId>,
    pos: BlockPos,
    block: BlockId,
    orientation: Option<Orientation>,
    moved: bool,
    // rust: },
}

    // rust: pub(crate) struct NeighborUpdater {
    // rust: stack: Vec<Update>,
    // rust: added: Vec<Update>,
    // rust: count: i32,
}

    // rust: impl Update {
    // `runNext`: the update to execute now and whether more remain.
next :: proc(self: ^Self, level: ^(impl LevelAccess + ?Sized) {
}
    // rust: match *self {
    // rust: Self::Shape {
    // rust: direction,
    // rust: neighbor_state,
    // rust: pos,
    // rust: neighbor_pos,
    // rust: flags,
    // rust: limit,
    // rust: } => (
    // rust: Step::Shape {
    // rust: direction,
    // rust: neighbor_state,
    // rust: pos,
    // rust: neighbor_pos,
    // rust: flags,
    // rust: limit,
    // rust: },
    // rust: false,
    // rust: ),
    // rust: Self::Simple {
    // rust: pos,
    // rust: block,
    // rust: orientation,
    // rust: } => (
    // rust: Step::Neighbor {
    // rust: state: None,
    // rust: pos,
    // rust: block,
    // rust: orientation,
    // rust: moved: false,
    // rust: },
    // rust: false,
    // rust: ),
    // rust: Self::Full {
    // rust: state,
    // rust: pos,
    // rust: block,
    // rust: orientation,
    // rust: moved,
    // rust: } => (
    // rust: Step::Neighbor {
    // rust: state: Some(state),
    // rust: pos,
    // rust: block,
    // rust: orientation,
    // rust: moved,
    // rust: },
    // rust: false,
    // rust: ),
    // rust: Self::Multi {
    // rust: source,
    // rust: block,
    // rust: skip,
    // rust: ref mut orientation,
    // rust: ref mut index,
    // rust: } => {
    // rust: let direction = UPDATE_ORDER[*index];
    // rust: let state = level.block_state(rel(source, direction));
    // rust: let context = if level.redstone_experiments() {
    // rust: let initial = orientation.get_or_insert_with(|| {
    // rust: let initial = Orientation::random(level.random())
    // rust: .with_side_bias(super::orientation::SideBias::Left);
    // rust: skip.map_or(initial, |d| initial.with_front(d.opposite()))
    // rust: });
    // rust: Some(initial.with_front(direction))
    // rust: } else {
    // rust: None
}
    // rust: *index += 1;
    // rust: if *index < UPDATE_ORDER.len() && Some(UPDATE_ORDER[*index]) == skip {
    // rust: *index += 1;
}
    // rust: (
    // rust: Step::Neighbor {
    // rust: state: Some(state),
    // rust: pos: rel(source, direction),
    // rust: block,
    // rust: orientation: context,
    // rust: moved: false,
    // rust: },
    // rust: *index < UPDATE_ORDER.len(),
    // rust: )
}
}
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.level.block_state(pos)
}
fluid_at :: proc(self: ^Self, pos: BlockPos) -> F {
    // Ported from Horizon
    return {}
}
    // rust: self.b.fluid(self.state(pos))
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.level.random()
}
emit :: proc(self: ^Self, event: LevelEvent) {
}
    // rust: self.level.emit(event);
}
    // `TntBlock.prime` without a source: `new PrimedTnt` draws its push angle
    // from the level random, then the primed sound and `prime_fuse` event.
prime_tnt :: proc(self: ^Self, pos: BlockPos) {
}
    // rust: let rot = self.random().next_double() * f64::from(std::f32::consts::TAU);
    // rust: self.emit(LevelEvent::PrimeTnt { pos, rot });
    // rust: self.sound(
    // rust: pos,
    // rust: &std::sync::Arc::from("minecraft:entity.tnt.primed"),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: self.game_event(pos, "minecraft:prime_fuse");
}
level_event :: proc(self: ^Self, id: i32, pos: BlockPos, data: i32) {
}
    // rust: self.level.emit(LevelEvent::LevelEvent { id, pos, data });
}
sound :: proc(self: ^Self, pos: BlockPos, sound: ^std::sync::^str, volume: f32, pitch: f32) {
}
    // rust: self.level.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: sound.clone(),
    // rust: volume,
    // rust: pitch,
    // rust: });
}
game_event :: proc(self: ^Self, pos: BlockPos, event: ^'static str) {
}
    // rust: self.level.emit(LevelEvent::GameEvent {
    // rust: pos,
    // rust: event,
    // rust: state: None,
    // rust: });
}
    // `Level.gameEvent(event, pos, Context.of(state))`.
game_event_state :: proc(self: ^Self, pos: BlockPos, event: ^'static str, state: BlockStateId) {
}
    // rust: self.level.emit(LevelEvent::GameEvent {
    // rust: pos,
    // rust: event,
    // rust: state: Some(state),
    // rust: });
}
block_of :: proc(self: ^Self, state: BlockStateId) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.b.table.block(state)
}
is_in_valid_bounds :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: pos.y >= self.level.min_y()
    // rust: && pos.y < self.level.max_y()
    // rust: && (-30_000_000..30_000_000).contains(&pos.x)
    // rust: && (-30_000_000..30_000_000).contains(&pos.z)
}

    // ---- scheduled ticks ----
schedule_tick :: proc(self: ^Self, pos: BlockPos, block: BlockId, delay: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.schedule_tick_priority(pos, block, delay, TickPriority::Normal)
}
    // rust: pub fn schedule_tick_priority(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: delay: i32,
    // rust: priority: TickPriority,
    // rust: ) -> ScheduleResult {
    // rust: let time = self.level.game_time();
    // rust: self.ticks.schedule_block(time, pos, block, delay, priority)
}
    // rust: pub fn schedule_fluid_tick(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: fluid: crate::fluid::FluidKind,
    // rust: delay: i32,
    // rust: ) -> ScheduleResult {
    // rust: let time = self.level.game_time();
    // rust: self.ticks.schedule_fluid(time, pos, fluid, delay)
}

    // ---- Level.setBlock ----
set_block :: proc(self: ^Self, pos: BlockPos, state: BlockStateId, flags: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.set_block_limit(pos, state, flags, flags::UPDATE_LIMIT)
}
set_block_and_update :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.set_block(pos, state, flags::UPDATE_ALL)
}
    // rust: pub fn set_block_limit(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: update_flags: i32,
    // rust: limit: i32,
    // rust: ) -> bool {
    // rust: if !self.is_in_valid_bounds(pos) || !self.level.is_loaded(pos) {
    // rust: return false;
}
    // rust: let Some(old) = self.chunk_set_block_state(pos, state, update_flags) else {
    // rust: return false;
}
    // rust: let new = self.state(pos);
    // rust: if new == state {
    // rust: if update_flags & flags::UPDATE_NEIGHBORS != 0 {
    // rust: let old_block = self.block_of(old);
    // rust: self.update_neighbors_at(pos, old_block);
    // rust: if self.has_analog_output(state) {
    // rust: let block = self.block_of(state);
    // rust: self.update_neighbour_for_output_signal(pos, block);
}
}
    // rust: if update_flags & flags::UPDATE_KNOWN_SHAPE == 0 && limit > 0 {
    // rust: let neighbour_flags =
    // rust: update_flags & !(flags::UPDATE_NEIGHBORS | flags::UPDATE_SUPPRESS_DROPS);
    // rust: self.update_indirect_neighbour_shapes(old, pos, neighbour_flags, limit - 1);
    // rust: self.update_neighbour_shapes(state, pos, neighbour_flags, limit - 1);
    // rust: self.update_indirect_neighbour_shapes(state, pos, neighbour_flags, limit - 1);
}
}
    // rust: true
}
    // `LevelChunk.setBlockState`: the previous state when the write happened.
    // rust: fn chunk_set_block_state(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: update_flags: i32,
    // rust: ) -> Option<BlockStateId> {
    // rust: let current = self.state(pos);
    // rust: if current == state {
    // rust: return None;
}
    // rust: let old = self.level.set_raw(pos, state)?;
    // rust: if old == state {
    // rust: return None;
}
    // rust: self.level.observe_block_changed(pos, old, state);
    // rust: let new_block = self.block_of(state);
    // rust: let block_changed = self.block_of(old) != new_block;
    // rust: if block_changed && self.b.instance_of(old, super::classes::Class::Comparator) {
            // LevelChunk removes the old ComparatorBlockEntity with its output.
    // rust: self.ticks.comparator_outputs.remove(&pos);
}
    // rust: if block_changed && self.block_of(old) == self.b.named.moving_piston {
            // PistonMovingBlockEntity.preRemoveSideEffects -> finalTick; the
            // block is already replaced, so only the entity goes away. The
            // extended base is MovingPistonBlock.destroy's, which only the
            // player-break path calls (player_destroy).
    // rust: self.remove_moving_piston(pos);
    // rust: } else if block_changed
    // rust: && (self.b.has_flag(old, super::data::state_flags::BLOCK_ENTITY)
    // rust: || self.level.has_mod_block_entity(pos))
    // rust: && !self.keeps_block_entity(state, old)
    // rust: {
            // BlockEntity.preRemoveSideEffects (unless UPDATE_SKIP_BLOCK_ENTITY_SIDEEFFECTS)
            // and removeBlockEntity, before the neighbours hear of the removal.
    // rust: let side_effects = update_flags & flags::UPDATE_SKIP_BLOCK_ENTITY_SIDEEFFECTS == 0;
    // rust: let updates = self.level.remove_block_entity(pos, old, side_effects);
    // rust: for _ in 0..updates {
                // JukeboxBlockEntity.onSongChanged.
    // rust: let block = self.block_of(old);
    // rust: self.update_neighbors_at(pos, block);
}
}
    // rust: let moved = update_flags & flags::UPDATE_MOVE_BY_PISTON != 0;
    // rust: if (block_changed
    // rust: || self
    // rust: .b
    // rust: .block_data(new_block)
    // rust: .is(super::classes::Class::BaseRail))
    // rust: && (update_flags & flags::UPDATE_NEIGHBORS != 0 || moved)
    // rust: {
    // rust: self.affect_neighbors_after_removal(old, pos, moved);
}
    // rust: if self.block_of(self.state(pos)) != new_block {
    // rust: return None;
}
    // rust: if update_flags & flags::UPDATE_SKIP_ON_PLACE == 0 {
    // rust: self.on_place(state, pos, old, moved);
}
    // rust: Some(old)
}
    // `BlockState.shouldChangedStateKeepBlockEntity(oldState)`: copper chests
    // and copper golem statues keep theirs across their weathering states.
keeps_block_entity :: proc(self: ^Self, new: BlockStateId, old: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (new, old) = (self.block_of(new), self.block_of(old));
    // rust: let tags = &self.b.tags;
    // rust: (tags.copper_chests.contains(new) && tags.copper_chests.contains(old))
    // rust: || (tags.copper_golem_statues.contains(new) && tags.copper_golem_statues.contains(old))
}
    // `MovingPistonBlock.destroy`: a `moving_piston` that goes away takes the
    // piston base behind it with it when that base is extended (a head that was
    // still moving over a base that finished extending). An unextended base, or
    // no piston base at all, stays.
    // rust: pub(crate) fn destroy_moving_piston_base(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let Some(facing) = b.table.dir(state, b.props.facing) else {
    // rust: return;
}
    // rust: let base = rel(pos, facing.opposite());
    // rust: let base_state = self.state(base);
    // rust: if b.data(base_state).is(Class::PistonBase) && b.table.bool(base_state, b.props.extended) {
    // rust: self.remove_block(base, false);
}
}

    // `Level.removeBlock`.
remove_block :: proc(self: ^Self, pos: BlockPos, moved_by_piston: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let fluid = self.fluid_at(pos);
    // rust: let legacy = self.b.legacy_block(fluid);
    // rust: self.set_block(pos, legacy, 3 | if moved_by_piston { 64 } else { 0 })
}
    // `Level.destroyBlock(pos, dropResources, null, limit)`.
destroy_block :: proc(self: ^Self, pos: BlockPos, drop: bool, limit: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.state(pos);
    // rust: if self.b.is_air(state) {
    // rust: return false;
}
        // Block.spawnDestroyParticles: fire spawns none, straw beds their own.
    // rust: let data = self.b.data(state);
    // rust: if data.is(Class::StrawBed) {
    // rust: self.level_event(2014, pos, state.0 as i32);
    // rust: } else if !(data.is(Class::BaseFire) || data.is(Class::Fire) || data.is(Class::SoulFire)) {
    // rust: self.level_event(2001, pos, state.0 as i32);
}
    // rust: if drop {
    // rust: self.drop_resources(state, pos);
}
    // rust: let fluid = self.fluid_at(pos);
    // rust: let legacy = self.b.legacy_block(fluid);
    // rust: let destroyed = self.set_block_limit(pos, legacy, 3, limit);
    // rust: if destroyed {
    // rust: self.game_event_state(pos, "minecraft:block_destroy", state);
}
    // rust: destroyed
}
drop_resources :: proc(self: ^Self, state: BlockStateId, pos: BlockPos) {
}
        // `MovingPistonBlock.getDrops`: a moving piston's loot is the loot of
        // the block it carries.
        // shortcut: the carried block's `spawnAfterBreak` experience comes with
        // it (vanilla spawns it for the moving piston, which gives none);
        // upgrade when a drop harness covers a moving piston.
    // rust: let Some(state) =
    // rust: super::pistons::dropped_state(self.b, &self.ticks.moving_pistons, state, pos)
    // rust: else {
    // rust: return;
}
    // rust: if self.level.game_rules().block_drops {
    // rust: self.emit(LevelEvent::DropResources { pos, state });
}
}
    // `Block.updateOrDestroy`.
    // rust: pub fn update_or_destroy(
    // rust: &mut self,
    // rust: old: BlockStateId,
    // rust: new: BlockStateId,
    // rust: pos: BlockPos,
    // rust: update_flags: i32,
    // rust: limit: i32,
    // rust: ) {
    // rust: if new != old {
    // rust: if self.b.is_air(new) {
    // rust: self.destroy_block(pos, update_flags & flags::UPDATE_SUPPRESS_DROPS == 0, limit);
    // rust: } else {
    // rust: self.set_block_limit(
    // rust: pos,
    // rust: new,
    // rust: update_flags & !flags::UPDATE_SUPPRESS_DROPS,
    // rust: limit,
    // rust: );
}
}
}
    // `Block.updateFromNeighbourShapes`.
    // rust: pub fn update_from_neighbour_shapes(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: ) -> BlockStateId {
    // rust: let mut new = state;
    // rust: for direction in UPDATE_SHAPE_ORDER {
    // rust: let neighbour = rel(pos, direction);
    // rust: let neighbour_state = self.state(neighbour);
    // rust: new = self.update_shape(new, pos, direction, neighbour, neighbour_state);
}
    // rust: new
}
    // `BlockStateBase.updateNeighbourShapes`.
    // rust: pub fn update_neighbour_shapes(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: update_flags: i32,
    // rust: limit: i32,
    // rust: ) {
    // rust: for direction in UPDATE_SHAPE_ORDER {
    // rust: let neighbour = rel(pos, direction);
    // rust: self.neighbor_shape_changed(
    // rust: direction.opposite(),
    // rust: neighbour,
    // rust: pos,
    // rust: state,
    // rust: update_flags,
    // rust: limit,
    // rust: );
}
}

    // ---- neighbour updater ----
update_neighbors_at :: proc(self: ^Self, pos: BlockPos, block: BlockId) {
}
    // rust: let orientation = self.initial_orientation(None, None);
    // rust: self.update_neighbors_at_oriented(pos, block, orientation);
}
    // rust: pub fn update_neighbors_at_oriented(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: orientation: Option<Orientation>,
    // rust: ) {
    // rust: self.add_and_run(Update::Multi {
    // rust: source: pos,
    // rust: block,
    // rust: orientation,
    // rust: skip: None,
    // rust: index: 0,
    // rust: });
}
    // rust: pub fn update_neighbors_at_except_oriented(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: skip: Direction,
    // rust: orientation: Option<Orientation>,
    // rust: ) {
    // rust: let index = usize::from(UPDATE_ORDER[0] == skip);
    // rust: self.add_and_run(Update::Multi {
    // rust: source: pos,
    // rust: block,
    // rust: orientation,
    // rust: skip: Some(skip),
    // rust: index,
    // rust: });
}
neighbor_changed_at :: proc(self: ^Self, pos: BlockPos, block: BlockId) {
}
    // rust: self.neighbor_changed_at_oriented(pos, block, None);
}
    // rust: pub fn neighbor_changed_at_oriented(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: orientation: Option<Orientation>,
    // rust: ) {
    // rust: self.add_and_run(Update::Simple {
    // rust: pos,
    // rust: block,
    // rust: orientation,
    // rust: });
}
    // rust: pub fn neighbor_changed_full(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: moved: bool,
    // rust: ) {
    // rust: self.neighbor_changed_full_oriented(state, pos, block, None, moved);
}
    // rust: pub fn neighbor_changed_full_oriented(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: orientation: Option<Orientation>,
    // rust: moved: bool,
    // rust: ) {
    // rust: self.add_and_run(Update::Full {
    // rust: state,
    // rust: pos,
    // rust: block,
    // rust: orientation,
    // rust: moved,
    // rust: });
}
    // rust: pub fn neighbor_shape_changed(
    // rust: &mut self,
    // rust: direction: Direction,
    // rust: pos: BlockPos,
    // rust: neighbor_pos: BlockPos,
    // rust: neighbor_state: BlockStateId,
    // rust: update_flags: i32,
    // rust: limit: i32,
    // rust: ) {
    // rust: self.add_and_run(Update::Shape {
    // rust: direction,
    // rust: neighbor_state,
    // rust: pos,
    // rust: neighbor_pos,
    // rust: flags: update_flags,
    // rust: limit,
    // rust: });
}
add_and_run :: proc(self: ^Self, update: Update) {
}
    // rust: let updater = &mut self.ticks.updater;
    // rust: let running = updater.count > 0;
    // rust: let too_many = updater.count >= MAX_CHAINED_NEIGHBOR_UPDATES;
    // rust: updater.count += 1;
    // rust: if !too_many {
    // rust: if running {
    // rust: updater.added.push(update);
    // rust: } else {
    // rust: updater.stack.push(update);
}
}
    // rust: if !running {
    // rust: self.run_updates();
}
}
run_updates :: proc(self: ^Self) {
}
    // rust: loop {
    // rust: let updater = &mut self.ticks.updater;
    // rust: if updater.stack.is_empty() && updater.added.is_empty() {
    // rust: break;
}
    // rust: while let Some(update) = updater.added.pop() {
    // rust: updater.stack.push(update);
}
    // rust: while let Some(top) = self.ticks.updater.stack.last_mut() {
    // rust: let (step, more) = top.next(self.level);
    // rust: self.execute(step);
    // rust: if !more {
    // rust: self.ticks.updater.stack.pop();
    // rust: break;
}
    // rust: if !self.ticks.updater.added.is_empty() {
    // rust: break;
}
}
}
    // rust: let updater = &mut self.ticks.updater;
    // rust: updater.stack.clear();
    // rust: updater.added.clear();
    // rust: updater.count = 0;
}
execute :: proc(self: ^Self, step: Step) {
}
    // rust: match step {
    // rust: Step::Shape {
    // rust: direction,
    // rust: neighbor_state,
    // rust: pos,
    // rust: neighbor_pos,
    // rust: flags: update_flags,
    // rust: limit,
    // rust: } => {
    // rust: let current = self.state(pos);
    // rust: if update_flags & flags::UPDATE_SKIP_SHAPE_UPDATE_ON_WIRE == 0
    // rust: || !self.b.table.is(current, self.b.named.redstone_wire)
    // rust: {
    // rust: let new =
    // rust: self.update_shape(current, pos, direction, neighbor_pos, neighbor_state);
    // rust: self.update_or_destroy(current, new, pos, update_flags, limit);
}
}
    // rust: Step::Neighbor {
    // rust: state,
    // rust: pos,
    // rust: block,
    // rust: orientation,
    // rust: moved,
    // rust: } => {
    // rust: let state = state.unwrap_or_else(|| self.state(pos));
    // rust: self.neighbor_changed_oriented(state, pos, block, orientation, moved);
}
}
}
    // `Level.updateNeighbourForOutputSignal`.
update_neighbour_for_output_signal :: proc(self: ^Self, pos: BlockPos, block: BlockId) {
}
    // rust: for direction in super::update::HORIZONTAL {
    // rust: let mut relative = rel(pos, direction);
    // rust: if !self.level.is_loaded(relative) {
    // rust: continue;
}
    // rust: let mut state = self.state(relative);
    // rust: if self.b.table.is(state, self.b.named.comparator) {
    // rust: self.neighbor_changed_full(state, relative, block, false);
    // rust: } else if self.is_redstone_conductor(state, relative) {
    // rust: relative = rel(relative, direction);
    // rust: state = self.state(relative);
    // rust: if self.b.table.is(state, self.b.named.comparator) {
    // rust: self.neighbor_changed_full(state, relative, block, false);
}
}
}
}
}
