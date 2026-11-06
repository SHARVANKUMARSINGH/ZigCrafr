//! Transpiled from Horizon Rust crate
package horizon_world_redstone

import "core:fmt"
import "core:mem"
import "core:math"

// Redstone: `SignalGetter`, default and experimental wire evaluators, torches,
// diodes (repeaters, comparators), observers, lamps and the power-driven
// responses of doors, trapdoors, gates and other consumers.
// use super::{
    // rust: LevelAccess, LevelEvent, Sim,
    // rust: classes::Class,
    // rust: data::state_flags,
    // rust: query::{axis_of, clockwise, counter_clockwise},
    // rust: states::BlockId,
    // rust: update::{HORIZONTAL, above, below, rel},
}
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: geometry::{Axis, Direction, trig},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
    // rust: ticks::TickPriority,
}

    // rust: mod experimental;

    // rust: const SIGNAL_ORDER: [Direction; 6] = [
    // rust: Direction::Down,
    // rust: Direction::Up,
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: ];

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
nibble :: proc(word: u32, direction: Direction) -> i {
    // Ported from Horizon
    return {}
}
    // rust: ((word >> (4 * direction as u32)) & 15) as i32
}
    // rust: pub(crate) fn is_signal_source(&self, state: BlockStateId) -> bool {
    // rust: if self.b.is_block(state, self.b.named.redstone_wire) {
    // rust: return !self.wire_signal_off.get();
}
    // rust: self.level
    // rust: .adjust_signal_source(state, self.b.has_flag(state, state_flags::SIGNAL_SOURCE))
}
    // `BlockState.getSignal(level, pos, direction)`.
    // rust: pub(crate) fn state_signal(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> i32 {
    // rust: let vanilla = self.vanilla_signal(state, pos, direction);
    // rust: self.level
    // rust: .adjust_signal(pos, state, direction, false, vanilla)
}
vanilla_signal :: proc(self: ^Self, state: BlockStateId, pos: BlockPos, direction: Direction) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
        // BlockBehaviour.getSignal is `ownSignal` for a TestBlock, which is
        // not an `isSignalSource`.
    // rust: if b.data(state).class == Class::TestBlock {
    // rust: return self.level.block_entity_signal(pos, state, direction);
}
    // rust: if !b.has_flag(state, state_flags::SIGNAL_SOURCE) {
    // rust: return 0;
}
    // rust: let data = b.data(state);
    // rust: match data.class {
    // rust: Class::RedstoneWire => self.wire_signal(state, pos, direction),
    // rust: Class::Comparator => {
    // rust: if b.facing(state) == direction && b.table.bool(state, b.props.powered) {
    // rust: self.comparator_output(pos)
    // rust: } else {
    // rust: 0
}
}
    // rust: Class::TrappedChest | Class::Jukebox => {
    // rust: self.level.block_entity_signal(pos, state, direction)
}
    // rust: _ => Self::nibble(b.facts(state).weak, direction),
}
}
    // `BlockState.getDirectSignal(level, pos, direction)`.
    // rust: pub(crate) fn state_direct_signal(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> i32 {
    // rust: let vanilla = self.vanilla_direct_signal(state, pos, direction);
    // rust: self.level
    // rust: .adjust_signal(pos, state, direction, true, vanilla)
}
    // rust: fn vanilla_direct_signal(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> i32 {
    // rust: let b = self.b;
    // rust: if !b.has_flag(state, state_flags::SIGNAL_SOURCE) {
    // rust: return 0;
}
    // rust: match b.data(state).class {
    // rust: Class::RedstoneWire => {
    // rust: if self.wire_signal_off.get() {
    // rust: 0
    // rust: } else {
    // rust: self.wire_signal(state, pos, direction)
}
}
    // rust: Class::Comparator => self.vanilla_signal(state, pos, direction),
    // rust: Class::TrappedChest => {
    // rust: if direction == Direction::Up {
    // rust: self.level.block_entity_signal(pos, state, direction)
    // rust: } else {
    // rust: 0
}
}
    // rust: _ => Self::nibble(b.facts(state).strong, direction),
}
}
    // rust: pub(crate) fn comparator_output(&self, pos: BlockPos) -> i32 {
    // rust: self.ticks
    // rust: .comparator_outputs
    // rust: .get(&pos)
    // rust: .copied()
    // rust: .unwrap_or(0)
}
wire_signal :: proc(self: ^Self, state: BlockStateId, pos: BlockPos, direction: Direction) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.wire_signal_off.get() || direction == Direction::Down {
    // rust: return 0;
}
    // rust: let power = self.b.table.int(state, self.b.props.power);
    // rust: if power == 0 {
    // rust: return 0;
}
    // rust: if direction != Direction::Up {
    // rust: let connected = self.wire_connection_state(state, pos);
    // rust: if self
    // rust: .b
    // rust: .table
    // rust: .text(connected, self.direction_prop(direction.opposite()))
    // rust: == "none"
    // rust: {
    // rust: return 0;
}
}
    // rust: power
}
    // `SignalGetter.getDirectSignal(pos, direction)`.
direct_signal :: proc(self: ^Self, pos: BlockPos, direction: Direction) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.state_direct_signal(self.state(pos), pos, direction)
}
    // `SignalGetter.getDirectSignalTo`.
direct_signal_to :: proc(self: ^Self, pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut result = 0;
    // rust: for direction in SIGNAL_ORDER {
    // rust: result = result.max(self.direct_signal(rel(pos, direction), direction));
    // rust: if result >= 15 {
    // rust: return result;
}
}
    // rust: result
}
    // `SignalGetter.getSignal(pos, direction)`.
signal :: proc(self: ^Self, pos: BlockPos, direction: Direction) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.state(pos);
    // rust: let signal = self.state_signal(state, pos, direction);
    // rust: if self.is_redstone_conductor(state, pos) {
    // rust: signal.max(self.direct_signal_to(pos))
    // rust: } else {
    // rust: signal
}
}
has_signal :: proc(self: ^Self, pos: BlockPos, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.signal(pos, direction) > 0
}
    // `SignalGetter.hasNeighborSignal`.
has_neighbor_signal :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: SIGNAL_ORDER
    // rust: .into_iter()
    // rust: .any(|direction| self.signal(rel(pos, direction), direction) > 0)
}
    // `SignalGetter.getBestNeighborSignal`.
best_neighbor_signal :: proc(self: ^Self, pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut best = 0;
    // rust: for direction in SIGNAL_ORDER {
    // rust: let signal = self.signal(rel(pos, direction), direction);
    // rust: if signal >= 15 {
    // rust: return 15;
}
    // rust: best = best.max(signal);
}
    // rust: best
}
    // `SignalGetter.getControlInputSignal`.
control_input_signal :: proc(self: ^Self, pos: BlockPos, direction: Direction, only_diodes: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: if only_diodes {
    // rust: if b.instance_of(state, Class::Diode) {
    // rust: self.direct_signal(pos, direction)
    // rust: } else {
    // rust: 0
}
    // rust: } else if b.is_block(state, b.named.redstone_block) {
    // rust: 15
    // rust: } else if b.is_block(state, b.named.redstone_wire) {
    // rust: b.table.int(state, b.props.power)
    // rust: } else if self.is_signal_source(state) {
    // rust: self.direct_signal(pos, direction)
    // rust: } else {
    // rust: 0
}
}

    // ---- redstone wire ----

should_wire_connect_to :: proc(self: ^Self, state: BlockStateId, direction: Maybe(Direction)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: match b.data(state).class {
    // rust: Class::RedstoneWire => true,
    // rust: Class::Observer => direction == Some(b.facing(state)),
    // rust: Class::Repeater => {
    // rust: let facing = b.facing(state);
    // rust: direction == Some(facing) || direction == Some(facing.opposite())
}
    // rust: _ => self.is_signal_source(state) && direction.is_some(),
}
}
    // `RedstoneWireBlock.canSurvive` and `updateShape`'s down face: the block
    // below is read through `support_state`, since a retracting piston's
    // `moving_piston` block carries the extended base only through its block
    // entity and its exported facts call every face unsupported (#4728).
wire_can_survive_on :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.support_state(pos);
    // rust: self.sturdy(pos, Direction::Up) || self.b.is_block(state, self.b.named.hopper)
}
    // rust: fn wire_connecting_side(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: can_connect_up: bool,
    // rust: ) -> &'static str {
    // rust: let b = self.b;
    // rust: let relative_pos = rel(pos, direction);
    // rust: let relative = self.state(relative_pos);
    // rust: if can_connect_up {
    // rust: let placeable_above =
    // rust: b.instance_of(relative, Class::TrapDoor) || self.wire_can_survive_on(relative_pos);
    // rust: if placeable_above && self.should_wire_connect_to(self.state(above(relative_pos)), None)
    // rust: {
    // rust: return if b.is_face_sturdy(relative, direction.opposite()) {
    // rust: "up"
    // rust: } else {
    // rust: "side"
}
}
}
    // rust: if !self.should_wire_connect_to(relative, Some(direction))
    // rust: && (self.is_redstone_conductor(relative, relative_pos)
    // rust: || !self.should_wire_connect_to(self.state(below(relative_pos)), None))
    // rust: {
    // rust: "none"
    // rust: } else {
    // rust: "side"
}
}
wire_can_connect_up :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.is_redstone_conductor(self.above_state(pos), pos)
}
wire_connected :: proc(self: ^Self, state: BlockStateId, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b.table.text(state, self.direction_prop(direction)) != "none"
}
wire_is_cross :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: HORIZONTAL
    // rust: .into_iter()
    // rust: .all(|d| self.wire_connected(state, d))
}
wire_is_dot :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !HORIZONTAL
    // rust: .into_iter()
    // rust: .any(|d| self.wire_connected(state, d))
}
    // rust: pub(crate) fn wire_cross_state(&self, power: i32) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let mut state = b.default_of(b.named.redstone_wire);
    // rust: for direction in HORIZONTAL {
    // rust: state = b
    // rust: .table
    // rust: .set_text(state, self.direction_prop(direction), "side");
}
    // rust: b.table.set_int(state, b.props.power, power)
}
    // `RedstoneWireBlock.getConnectionState`.
    // rust: pub(crate) fn wire_connection_state(&self, state: BlockStateId, pos: BlockPos) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let table = &b.table;
    // rust: let was_dot = self.wire_is_dot(state);
    // rust: let mut result = table.set_int(
    // rust: b.default_of(b.named.redstone_wire),
    // rust: b.props.power,
    // rust: table.int(state, b.props.power),
    // rust: );
    // rust: let can_up = self.wire_can_connect_up(pos);
    // rust: for direction in HORIZONTAL {
    // rust: if !self.wire_connected(result, direction) {
    // rust: let side = self.wire_connecting_side(pos, direction, can_up);
    // rust: result = table.set_text(result, self.direction_prop(direction), side);
}
}
    // rust: if was_dot && self.wire_is_dot(result) {
    // rust: return result;
}
    // rust: let north = self.wire_connected(result, Direction::North);
    // rust: let south = self.wire_connected(result, Direction::South);
    // rust: let east = self.wire_connected(result, Direction::East);
    // rust: let west = self.wire_connected(result, Direction::West);
    // rust: let ns_empty = !north && !south;
    // rust: let ew_empty = !east && !west;
    // rust: if !west && ns_empty {
    // rust: result = table.set_text(result, b.props.west, "side");
}
    // rust: if !east && ns_empty {
    // rust: result = table.set_text(result, b.props.east, "side");
}
    // rust: if !north && ew_empty {
    // rust: result = table.set_text(result, b.props.north, "side");
}
    // rust: if !south && ew_empty {
    // rust: result = table.set_text(result, b.props.south, "side");
}
    // rust: result
}
    // rust: pub(crate) fn redstone_wire_update_shape(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: npos: BlockPos,
    // rust: _neighbour: BlockStateId,
    // rust: ) -> BlockStateId {
    // rust: let b = self.b;
    // rust: match direction {
    // rust: Direction::Down => {
    // rust: if self.wire_can_survive_on(npos) {
    // rust: state
    // rust: } else {
    // rust: b.air()
}
}
    // rust: Direction::Up => self.wire_connection_state(state, pos),
    // rust: _ => {
    // rust: let side = self.wire_connecting_side(pos, direction, self.wire_can_connect_up(pos));
    // rust: let key = self.direction_prop(direction);
    // rust: if (side != "none") == self.wire_connected(state, direction)
    // rust: && !self.wire_is_cross(state)
    // rust: {
    // rust: b.table.set_text(state, key, side)
    // rust: } else {
    // rust: let power = b.table.int(state, b.props.power);
    // rust: let cross = b.table.set_text(self.wire_cross_state(power), key, side);
    // rust: self.wire_connection_state(cross, pos)
}
}
}
}
    // `RedstoneWireBlock.updateIndirectNeighbourShapes`.
    // rust: pub(crate) fn wire_update_indirect(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: flags: i32,
    // rust: limit: i32,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let wire = b.named.redstone_wire;
    // rust: for direction in HORIZONTAL {
    // rust: if b.table.text(state, self.direction_prop(direction)) != "none"
    // rust: && !b.is_block(self.rel_state(pos, direction), wire)
    // rust: {
    // rust: let down = below(rel(pos, direction));
    // rust: if b.is_block(self.state(down), wire) {
    // rust: let neighbour = rel(down, direction.opposite());
    // rust: let neighbour_state = self.state(neighbour);
    // rust: self.neighbor_shape_changed(
    // rust: direction.opposite(),
    // rust: down,
    // rust: neighbour,
    // rust: neighbour_state,
    // rust: flags,
    // rust: limit,
    // rust: );
}
    // rust: let up = above(rel(pos, direction));
    // rust: if b.is_block(self.state(up), wire) {
    // rust: let neighbour = rel(up, direction.opposite());
    // rust: let neighbour_state = self.state(neighbour);
    // rust: self.neighbor_shape_changed(
    // rust: direction.opposite(),
    // rust: up,
    // rust: neighbour,
    // rust: neighbour_state,
    // rust: flags,
    // rust: limit,
    // rust: );
}
}
}
}
wire_block_signal :: proc(self: ^Self, pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.wire_signal_off.set(true);
    // rust: let signal = self.best_neighbor_signal(pos);
    // rust: self.wire_signal_off.set(false);
    // rust: signal
}
wire_power_of :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.b.is_block(state, self.b.named.redstone_wire) {
    // rust: self.b.table.int(state, self.b.props.power)
    // rust: } else {
    // rust: 0
}
}
wire_incoming_signal :: proc(self: ^Self, pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut signal = 0;
    // rust: for direction in HORIZONTAL {
    // rust: let neighbour_pos = rel(pos, direction);
    // rust: let neighbour = self.state(neighbour_pos);
    // rust: signal = signal.max(self.wire_power_of(neighbour));
    // rust: let above_pos = above(pos);
    // rust: if self.is_redstone_conductor(neighbour, neighbour_pos)
    // rust: && !self.is_redstone_conductor(self.state(above_pos), above_pos)
    // rust: {
    // rust: signal = signal.max(self.wire_power_of(self.state(above(neighbour_pos))));
    // rust: } else if !self.is_redstone_conductor(neighbour, neighbour_pos) {
    // rust: signal = signal.max(self.wire_power_of(self.state(below(neighbour_pos))));
}
}
    // rust: (signal - 1).max(0)
}
    // `DefaultRedstoneWireEvaluator.updatePowerStrength`.
    // rust: pub(crate) fn wire_update_power(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: orientation: Option<super::orientation::Orientation>,
    // rust: update_shape: bool,
    // rust: ) {
    // rust: if self.level.redstone_experiments() {
    // rust: self.experimental_wire_update(pos, orientation, update_shape);
    // rust: return;
}
    // rust: let block_signal = self.wire_block_signal(pos);
    // rust: let target = if block_signal == 15 {
    // rust: 15
    // rust: } else {
    // rust: block_signal.max(self.wire_incoming_signal(pos))
}
    // rust: if self.b.table.int(state, self.b.props.power) != target {
    // rust: if self.state(pos) == state {
    // rust: let next = self.b.table.set_int(state, self.b.props.power, target);
    // rust: self.set_block(pos, next, 2);
}
            // Vanilla iterates a HashSet of the position and its six
            // neighbours; BlockPos hash order is reproduced below.
    // rust: let wire = self.b.named.redstone_wire;
    // rust: let mut targets: Vec<BlockPos> = std::iter::once(pos)
    // rust: .chain(Direction::ALL.map(|d| rel(pos, d)))
    // rust: .collect();
    // rust: java_hash_set_order(&mut targets);
    // rust: for target_pos in targets {
    // rust: self.update_neighbors_at(target_pos, wire);
}
}
}
wire_check_corner :: proc(self: ^Self, pos: BlockPos) {
}
    // rust: let wire = self.b.named.redstone_wire;
    // rust: if self.b.is_block(self.state(pos), wire) {
    // rust: self.update_neighbors_at(pos, wire);
    // rust: for direction in Direction::ALL {
    // rust: self.update_neighbors_at(rel(pos, direction), wire);
}
}
}
    // rust: pub(crate) fn wire_update_neighbors_of_neighboring_wires(&mut self, pos: BlockPos) {
    // rust: for direction in HORIZONTAL {
    // rust: self.wire_check_corner(rel(pos, direction));
}
    // rust: for direction in HORIZONTAL {
    // rust: let target = rel(pos, direction);
    // rust: if self.is_redstone_conductor(self.state(target), target) {
    // rust: self.wire_check_corner(above(target));
    // rust: } else {
    // rust: self.wire_check_corner(below(target));
}
}
}

    // ---- diodes ----

    // rust: pub(crate) fn diode_delay(&self, state: BlockStateId) -> i32 {
    // rust: if self.b.instance_of(state, Class::Repeater) {
    // rust: self.b.table.int(state, self.b.props.delay) * 2
    // rust: } else {
    // rust: 2
}
}
    // rust: pub(crate) fn diode_is_locked(&self, pos: BlockPos, state: BlockStateId) -> bool {
    // rust: self.b.instance_of(state, Class::Repeater) && self.diode_alternate_signal(pos, state) > 0
}
diode_alternate_signal :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let facing = self.b.facing(state);
    // rust: let only_diodes = self.b.instance_of(state, Class::Repeater);
    // rust: let cw = clockwise(facing);
    // rust: let ccw = counter_clockwise(facing);
    // rust: self.control_input_signal(rel(pos, cw), cw, only_diodes)
    // rust: .max(self.control_input_signal(rel(pos, ccw), ccw, only_diodes))
}
diode_input_signal :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let facing = b.facing(state);
    // rust: let target = rel(pos, facing);
    // rust: let input = self.signal(target, facing);
    // rust: let mut result = if input >= 15 {
    // rust: input
    // rust: } else {
    // rust: let target_state = self.state(target);
    // rust: input.max(self.wire_power_of(target_state))
}
    // rust: if b.instance_of(state, Class::Comparator) {
    // rust: let target_state = self.state(target);
    // rust: if self.has_analog_output(target_state) {
    // rust: result = self.analog_output(target_state, target, facing.opposite());
    // rust: } else if result < 15 && self.is_redstone_conductor(target_state, target) {
    // rust: let further = rel(target, facing);
    // rust: let further_state = self.state(further);
    // rust: let block = self
    // rust: .has_analog_output(further_state)
    // rust: .then(|| self.analog_output(further_state, further, facing.opposite()));
                // ComparatorBlock.getInputSignal: an item frame behind the
                // conductor counts too, the larger signal winning.
    // rust: let frame = self.level.item_frame_analog_output(further, facing);
    // rust: if let Some(signal) = frame.into_iter().chain(block).max() {
    // rust: result = signal;
}
}
}
    // rust: result
}
    // rust: pub(crate) fn diode_should_turn_on(&self, pos: BlockPos, state: BlockStateId) -> bool {
    // rust: if self.b.instance_of(state, Class::Comparator) {
    // rust: let input = self.diode_input_signal(pos, state);
    // rust: if input == 0 {
    // rust: return false;
}
    // rust: let side = self.diode_alternate_signal(pos, state);
    // rust: input > side
    // rust: || (input == side && self.b.table.text(state, self.b.props.mode) == "compare")
    // rust: } else {
    // rust: self.diode_input_signal(pos, state) > 0
}
}
diode_should_prioritize :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let direction = self.b.facing(state).opposite();
    // rust: let opposite = self.rel_state(pos, direction);
    // rust: self.b.instance_of(opposite, Class::Diode) && self.b.facing(opposite) != direction
}
    // rust: pub(crate) fn diode_update_neighbors_in_front(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let direction = self.b.facing(state);
    // rust: let opposite_pos = rel(pos, direction.opposite());
    // rust: let block = self.b.block(state);
    // rust: let orientation = self.initial_orientation(Some(direction.opposite()), Some(Direction::Up));
    // rust: self.neighbor_changed_at_oriented(opposite_pos, block, orientation);
    // rust: self.update_neighbors_at_except_oriented(opposite_pos, block, direction, orientation);
}
comparator_calculate_output :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let input = self.diode_input_signal(pos, state);
    // rust: if input == 0 {
    // rust: return 0;
}
    // rust: let alternate = self.diode_alternate_signal(pos, state);
    // rust: if alternate > input {
    // rust: 0
    // rust: } else if self.b.table.text(state, self.b.props.mode) == "subtract" {
    // rust: input - alternate
    // rust: } else {
    // rust: input
}
}
    // `DiodeBlock.checkTickOnNeighbor` (and the comparator override).
    // rust: pub(crate) fn diode_check_tick_on_neighbor(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let block = self.b.block(state);
    // rust: if self.b.instance_of(state, Class::Comparator) {
    // rust: if !self.ticks.will_block_tick_this_tick(pos, block) {
    // rust: let output = self.comparator_calculate_output(pos, state);
    // rust: let old = self.comparator_output(pos);
    // rust: if output != old
    // rust: || self.b.table.bool(state, self.b.props.powered)
    // rust: != self.diode_should_turn_on(pos, state)
    // rust: {
    // rust: let priority = if self.diode_should_prioritize(pos, state) {
    // rust: TickPriority::High
    // rust: } else {
    // rust: TickPriority::Normal
}
    // rust: self.schedule_tick_priority(pos, block, 2, priority);
}
}
    // rust: return;
}
    // rust: if self.diode_is_locked(pos, state) {
    // rust: return;
}
    // rust: let on = self.b.table.bool(state, self.b.props.powered);
    // rust: let should = self.diode_should_turn_on(pos, state);
    // rust: if on != should && !self.ticks.will_block_tick_this_tick(pos, block) {
    // rust: let priority = if self.diode_should_prioritize(pos, state) {
    // rust: TickPriority::ExtremelyHigh
    // rust: } else if on {
    // rust: TickPriority::VeryHigh
    // rust: } else {
    // rust: TickPriority::High
}
    // rust: let delay = self.diode_delay(state);
    // rust: self.schedule_tick_priority(pos, block, delay, priority);
}
}
    // `DiodeBlock.tick` / `ComparatorBlock.tick`.
    // rust: pub(crate) fn diode_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::Comparator) {
    // rust: self.comparator_refresh(pos, state);
    // rust: return;
}
    // rust: if self.diode_is_locked(pos, state) {
    // rust: return;
}
    // rust: let on = b.table.bool(state, b.props.powered);
    // rust: let should = self.diode_should_turn_on(pos, state);
    // rust: if on && !should {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.powered, false), 2);
    // rust: } else if !on {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.powered, true), 2);
    // rust: if !should {
    // rust: let delay = self.diode_delay(state);
    // rust: self.schedule_tick_priority(pos, b.block(state), delay, TickPriority::VeryHigh);
}
}
}
    // rust: pub(crate) fn comparator_refresh(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let output = self.comparator_calculate_output(pos, state);
    // rust: let old = self
    // rust: .ticks
    // rust: .comparator_outputs
    // rust: .insert(pos, output)
    // rust: .unwrap_or(0);
    // rust: if old != output || b.table.text(state, b.props.mode) == "compare" {
    // rust: let should = self.diode_should_turn_on(pos, state);
    // rust: let on = b.table.bool(state, b.props.powered);
    // rust: if on && !should {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.powered, false), 2);
    // rust: } else if !on && should {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.powered, true), 2);
}
    // rust: self.diode_update_neighbors_in_front(pos, state);
}
}
    // `DiodeBlock.neighborChanged`.
    // rust: pub(crate) fn diode_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let block = self.b.block(state);
    // rust: if !self.b.is_block(self.state(pos), block) {
    // rust: return;
}
    // rust: if self.can_survive(state, pos) {
    // rust: self.diode_check_tick_on_neighbor(pos, state);
    // rust: } else {
    // rust: self.drop_resources(state, pos);
    // rust: self.remove_block(pos, false);
    // rust: for direction in Direction::ALL {
    // rust: self.update_neighbors_at(rel(pos, direction), block);
}
}
}

    // `BlockState.hasAnalogOutputSignal`, as the level answers it (a mod's block).
    // rust: pub(crate) fn has_analog_output(&self, state: BlockStateId) -> bool {
    // rust: let vanilla = self.b.has_flag(state, state_flags::ANALOG_OUTPUT);
    // rust: self.level.adjust_has_analog_output(state, vanilla)
}
    // `BlockState.getAnalogOutputSignal`, as the level answers it (a mod's block), 0 to 15.
    // rust: pub(crate) fn analog_output(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> i32 {
    // rust: let vanilla = self.vanilla_analog_output(state, pos, direction);
    // rust: self.level
    // rust: .adjust_analog_output(pos, state, direction, vanilla)
    // rust: .clamp(0, 15)
}
    // `getAnalogOutputSignal` for state-only sources; others ask the caller.
    // rust: fn vanilla_analog_output(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> i32 {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: match b.data(state).class {
    // rust: Class::Beehive => b.table.int(state, p.honey_level),
    // rust: Class::Cake => (7 - b.table.int(state, p.bites)) * 2,
    // rust: Class::CandleCake => 14,
    // rust: Class::Composter | Class::LayeredCauldron => b.table.int(state, p.level),
    // rust: Class::CopperBulb => {
    // rust: if b.table.bool(self.state(pos), p.lit) {
    // rust: 15
    // rust: } else {
    // rust: 0
}
}
    // rust: Class::EndPortalFrame => {
    // rust: if b.table.bool(state, p.eye) {
    // rust: 15
    // rust: } else {
    // rust: 0
}
}
    // rust: Class::LavaCauldron => 3,
    // rust: Class::RespawnAnchor => {
    // rust: let charges = b.table.int(state, p.charges);
    // rust: (charges as f32 / 4.0 * 15.0).floor() as i32
}
    // rust: Class::CopperGolemStatue => {
    // rust: let pose = b.table.text(state, p.copper_golem_pose);
    // rust: ["standing", "sitting", "running", "star"]
    // rust: .iter()
    // rust: .position(|p| *p == pose)
    // rust: .map_or(1, |i| i as i32 + 1)
}
    // rust: _ => self.level.block_entity_analog_signal(pos, state, direction),
}
}

    // ---- torches ----

torch_has_neighbor_signal :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.b.instance_of(state, Class::RedstoneWallTorch) {
    // rust: let opposite = self.b.facing(state).opposite();
    // rust: self.has_signal(rel(pos, opposite), opposite)
    // rust: } else {
    // rust: self.has_signal(below(pos), Direction::Down)
}
}
    // rust: pub(crate) fn torch_notify_neighbors(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let block = self.b.block(state);
    // rust: let front = self
    // rust: .b
    // rust: .instance_of(state, Class::RedstoneWallTorch)
    // rust: .then(|| self.b.facing(state).opposite());
    // rust: let orientation = self.initial_orientation(front, Some(Direction::Up));
    // rust: for direction in Direction::ALL {
    // rust: self.update_neighbors_at_oriented(
    // rust: rel(pos, direction),
    // rust: block,
    // rust: orientation.map(|o| o.with_front(direction)),
    // rust: );
}
}
    // rust: pub(crate) fn torch_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let block = self.b.block(state);
    // rust: if self.b.table.bool(state, self.b.props.lit) == self.torch_has_neighbor_signal(pos, state)
    // rust: && !self.ticks.will_block_tick_this_tick(pos, block)
    // rust: {
    // rust: self.schedule_tick(pos, block, 2);
}
}
torch_toggled_too_frequently :: proc(self: ^Self, pos: BlockPos, add: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if add {
    // rust: let time = self.level.game_time();
    // rust: self.ticks.torch_toggles.push((pos, time));
}
    // rust: self.ticks
    // rust: .torch_toggles
    // rust: .iter()
    // rust: .filter(|(p, _)| *p == pos)
    // rust: .take(8)
    // rust: .count()
    // rust: >= 8
}
    // rust: pub(crate) fn torch_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let signal = self.torch_has_neighbor_signal(pos, state);
    // rust: let time = self.level.game_time();
    // rust: while self
    // rust: .ticks
    // rust: .torch_toggles
    // rust: .first()
    // rust: .is_some_and(|(_, when)| time - when > 60)
    // rust: {
    // rust: self.ticks.torch_toggles.remove(0);
}
    // rust: if b.table.bool(state, b.props.lit) {
    // rust: if signal {
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, b.props.lit, false));
    // rust: if self.torch_toggled_too_frequently(pos, true) {
    // rust: self.level_event(1502, pos, 0);
    // rust: let block = b.block(self.state(pos));
    // rust: self.schedule_tick(pos, block, 160);
}
}
    // rust: } else if !signal && !self.torch_toggled_too_frequently(pos, false) {
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, b.props.lit, true));
}
}

    // ---- observers ----

    // rust: pub(crate) fn observer_start_signal(&mut self, pos: BlockPos, block: BlockId) {
    // rust: if !self.ticks.has_block_tick(pos, block) {
    // rust: self.schedule_tick(pos, block, 2);
}
}
    // rust: pub(crate) fn observer_update_in_front(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let direction = self.b.facing(state);
    // rust: let opposite = rel(pos, direction.opposite());
    // rust: let block = self.b.block(state);
    // rust: let orientation = self.initial_orientation(Some(direction.opposite()), None);
    // rust: self.neighbor_changed_at_oriented(opposite, block, orientation);
    // rust: self.update_neighbors_at_except_oriented(opposite, block, direction, orientation);
}
    // rust: pub(crate) fn observer_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: if b.table.bool(state, b.props.powered) {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.powered, false), 2);
    // rust: } else {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.powered, true), 2);
    // rust: self.schedule_tick(pos, b.block(state), 2);
}
    // rust: self.observer_update_in_front(pos, state);
}

    // `LecternBlock.updateBelow`.
lectern_update_below :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let orientation =
    // rust: self.initial_orientation(Some(self.b.facing(state).opposite()), Some(Direction::Up));
    // rust: self.update_neighbors_at_oriented(below(pos), self.b.block(state), orientation);
}
    // `LightningRodBlock.updateNeighbours`.
lightning_rod_update_neighbors :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let front = self.b.facing(state).opposite();
    // rust: let orientation = self.initial_orientation(Some(front), None);
    // rust: self.update_neighbors_at_oriented(rel(pos, front), self.b.block(state), orientation);
}
    // `TrappedChestBlockEntity.signalOpenCount`.
trapped_chest_update_neighbors :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let orientation =
    // rust: self.initial_orientation(Some(self.b.facing(state).opposite()), Some(Direction::Up));
    // rust: let block = self.b.block(state);
    // rust: self.update_neighbors_at_oriented(pos, block, orientation);
    // rust: self.update_neighbors_at_oriented(below(pos), block, orientation);
}

    // ---- buttons, levers, plates ----

    // `ButtonBlock/LeverBlock.updateNeighbours`.
    // rust: pub(crate) fn attached_update_neighbours(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let front = self.face_attached_connected(state).opposite();
    // rust: let block = self.b.block(state);
    // rust: let up = if axis_of(front) == Axis::Y {
    // rust: self.b.facing(state)
    // rust: } else {
    // rust: Direction::Up
}
    // rust: let orientation = self.initial_orientation(Some(front), Some(up));
    // rust: self.update_neighbors_at_oriented(pos, block, orientation);
    // rust: self.update_neighbors_at_oriented(rel(pos, front), block, orientation);
}
    // rust: pub(crate) fn plate_update_neighbours(&mut self, pos: BlockPos, block: BlockId) {
    // rust: self.update_neighbors_at(pos, block);
    // rust: self.update_neighbors_at(below(pos), block);
}
    // rust: pub(crate) fn plate_signal_for_state(&self, state: BlockStateId) -> i32 {
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::WeightedPressurePlate) {
    // rust: b.table.int(state, b.props.power)
    // rust: } else if b.table.bool(state, b.props.powered) {
    // rust: 15
    // rust: } else {
    // rust: 0
}
}
plate_signal_strength :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
//         use horizon_core::geometry::{Aabb, Vec3};
    // rust: let b = self.b;
    // rust: let area = Aabb::new(
    // rust: Vec3::new(
    // rust: f64::from(pos.x) + 0.0625,
    // rust: f64::from(pos.y),
    // rust: f64::from(pos.z) + 0.0625,
    // rust: ),
    // rust: Vec3::new(
    // rust: f64::from(pos.x) + 0.9375,
    // rust: f64::from(pos.y) + 0.25,
    // rust: f64::from(pos.z) + 0.9375,
    // rust: ),
    // rust: );
    // rust: let data = b.data(state);
    // rust: if data.is(Class::WeightedPressurePlate) {
    // rust: let max = data.max_weight.max(1);
    // rust: let count = (self
    // rust: .level
    // rust: .count_entities(area, super::EntityQuery::Everything)
    // rust: as i32)
    // rust: .min(max);
    // rust: if count > 0 {
    // rust: (count.min(max) as f32 / max as f32 * 15.0).ceil() as i32
    // rust: } else {
    // rust: 0
}
    // rust: } else {
    // rust: let query = if data.set_type.as_ref().is_some_and(|s| s.mobs_only) {
    // rust: super::EntityQuery::Mobs
    // rust: } else {
    // rust: super::EntityQuery::Everything
}
    // rust: if self.level.count_entities(area, query) > 0 {
    // rust: 15
    // rust: } else {
    // rust: 0
}
}
}
    // `BasePressurePlateBlock.checkPressed`.
    // rust: pub(crate) fn plate_check_pressed(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: old_signal: i32,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let signal = self.plate_signal_strength(pos, state);
    // rust: let was = old_signal > 0;
    // rust: let is = signal > 0;
    // rust: let block = b.block(state);
    // rust: if old_signal != signal {
    // rust: let new = if b.instance_of(state, Class::WeightedPressurePlate) {
    // rust: b.table.set_int(state, b.props.power, signal)
    // rust: } else {
    // rust: b.table.set_bool(state, b.props.powered, signal > 0)
}
    // rust: self.set_block(pos, new, 2);
    // rust: self.plate_update_neighbours(pos, block);
}
    // rust: if let Some(set) = b.data(state).set_type.clone() {
    // rust: if !is && was {
    // rust: self.sound(pos, &set.plate_off, 1.0, 1.0);
    // rust: self.game_event(pos, "minecraft:block_deactivate");
    // rust: } else if is && !was {
    // rust: self.sound(pos, &set.plate_on, 1.0, 1.0);
    // rust: self.game_event(pos, "minecraft:block_activate");
}
}
    // rust: if is {
    // rust: let delay = if b.instance_of(state, Class::WeightedPressurePlate) {
    // rust: 10
    // rust: } else {
    // rust: 20
}
    // rust: self.schedule_tick(pos, block, delay);
}
}
    // `ButtonBlock.press`.
    // rust: pub(crate) fn button_press(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, b.props.powered, true));
    // rust: self.attached_update_neighbours(pos, state);
    // rust: let data = b.data(state);
    // rust: self.schedule_tick(pos, b.block(state), data.ticks_to_stay_pressed);
    // rust: if let Some(set) = data.set_type.clone() {
    // rust: self.sound(pos, &set.button_on, 1.0, 1.0);
}
    // rust: self.game_event(pos, "minecraft:block_activate");
}
    // `ButtonBlock.tick`.
    // rust: pub(crate) fn button_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: if b.table.bool(state, b.props.powered) {
    // rust: self.button_check_pressed(pos, state);
}
}
    // `ButtonBlock.checkPressed`: a button whose type allows arrows is
    // pressed while an arrow is inside its shape, and stays pressed (the
    // release is scheduled again) as long as one is.
    // rust: pub(crate) fn button_check_pressed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let data = b.data(state);
    // rust: let should_be_pressed = data.set_type.as_ref().is_some_and(|s| s.arrows)
    // rust: && self
    // rust: .level
    // rust: .count_entities(self.button_bounds(pos, state), super::EntityQuery::Arrows)
    // rust: > 0;
    // rust: let was_pressed = b.table.bool(state, b.props.powered);
    // rust: if should_be_pressed != was_pressed {
    // rust: self.set_block_and_update(
    // rust: pos,
    // rust: b.table.set_bool(state, b.props.powered, should_be_pressed),
    // rust: );
    // rust: self.attached_update_neighbours(pos, state);
    // rust: if let Some(set) = data.set_type.clone() {
    // rust: let sound = if should_be_pressed {
    // rust: &set.button_on
    // rust: } else {
    // rust: &set.button_off
}
    // rust: self.sound(pos, sound, 1.0, 1.0);
}
    // rust: self.game_event(
    // rust: pos,
    // rust: if should_be_pressed {
    // rust: "minecraft:block_activate"
    // rust: } else {
    // rust: "minecraft:block_deactivate"
    // rust: },
    // rust: );
}
    // rust: if should_be_pressed {
    // rust: self.schedule_tick(pos, b.block(state), data.ticks_to_stay_pressed);
}
}
    // `ButtonBlock.getShape(...).bounds().move(pos)`: a 6 by 4 plate on the
    // face it is attached to, 2 pixels thick (1 when pressed).
button_bounds :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> h {
    // Ported from Horizon
    return {}
}
//         use horizon_core::geometry::{Aabb, Vec3};
    // rust: let b = self.b;
    // rust: let thickness = if b.table.bool(state, b.props.powered) {
    // rust: 1.0 / 16.0
    // rust: } else {
    // rust: 2.0 / 16.0
}
    // rust: let attached = self.face_attached_connected(state).opposite().normal();
    // rust: let thick = attached.iter().position(|&n| n != 0).unwrap_or(1);
        // The 6 pixel side lies across the button's facing.
    // rust: let wide = if b.facing(state).normal()[2] != 0 {
    // rust: 0
    // rust: } else {
    // rust: 2
}
    // rust: let tall = 3 - thick - wide;
    // rust: let (mut lo, mut hi) = ([0.0; 3], [1.0; 3]);
    // rust: if attached[thick] > 0 {
    // rust: lo[thick] = 1.0 - thickness;
    // rust: } else {
    // rust: hi[thick] = thickness;
}
    // rust: (lo[wide], hi[wide]) = (5.0 / 16.0, 11.0 / 16.0);
    // rust: (lo[tall], hi[tall]) = (6.0 / 16.0, 10.0 / 16.0);
    // rust: let origin = [f64::from(pos.x), f64::from(pos.y), f64::from(pos.z)];
    // rust: Aabb::new(
    // rust: Vec3::new(origin[0] + lo[0], origin[1] + lo[1], origin[2] + lo[2]),
    // rust: Vec3::new(origin[0] + hi[0], origin[1] + hi[1], origin[2] + hi[2]),
    // rust: )
}
    // `DaylightDetectorBlock.updateSignalStrength`: the effective sky light
    // at the detector, shaped by the sun's angle (or inverted), as its
    // power.
    // rust: pub(crate) fn daylight_detector_update_signal(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let mut target = (self.level.sky_light(pos) - self.level.sky_darken()).max(0);
    // rust: if b.table.bool(state, b.props.inverted) {
    // rust: target = 15 - target;
    // rust: } else if target > 0 {
    // rust: let mut sun_angle = self.level.sun_angle(pos) * trig::DEG_TO_RAD;
    // rust: let offset = if sun_angle < std::f32::consts::PI {
    // rust: 0.0
    // rust: } else {
    // rust: std::f32::consts::TAU
}
    // rust: sun_angle += (offset - sun_angle) * 0.2;
            // Math.round(float).
    // rust: let scaled = target as f32 * trig::cos(f64::from(sun_angle));
    // rust: target = (f64::from(scaled) + 0.5).floor() as i32;
}
    // rust: let target = target.clamp(0, 15);
    // rust: if b.table.int(state, b.props.power) != target {
    // rust: self.set_block_and_update(pos, b.table.set_int(state, b.props.power, target));
}
}
    // `LeverBlock.pull`.
    // rust: pub(crate) fn lever_pull(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let state = b.table.cycle(state, b.props.powered);
    // rust: self.set_block_and_update(pos, state);
    // rust: self.attached_update_neighbours(pos, state);
    // rust: let powered = b.table.bool(state, b.props.powered);
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.lever.click".into(),
    // rust: volume: 0.3,
    // rust: pitch: if powered { 0.6 } else { 0.5 },
    // rust: });
    // rust: self.game_event(
    // rust: pos,
    // rust: if powered {
    // rust: "minecraft:block_activate"
    // rust: } else {
    // rust: "minecraft:block_deactivate"
    // rust: },
    // rust: );
}

    // ---- consumers ----

    // rust: pub(crate) fn door_neighbor_changed(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: changed: BlockId,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let other = if b.table.text(state, p.half) == "lower" {
    // rust: Direction::Up
    // rust: } else {
    // rust: Direction::Down
}
    // rust: let signal = self.has_neighbor_signal(pos) || self.has_neighbor_signal(rel(pos, other));
    // rust: if b.block(state) != changed && signal != b.table.bool(state, p.powered) {
    // rust: if signal != b.table.bool(state, p.open) {
    // rust: self.door_sound(pos, state, signal);
    // rust: self.game_event(
    // rust: pos,
    // rust: if signal {
    // rust: "minecraft:block_open"
    // rust: } else {
    // rust: "minecraft:block_close"
    // rust: },
    // rust: );
}
    // rust: let next = b
    // rust: .table
    // rust: .set_bool(b.table.set_bool(state, p.powered, signal), p.open, signal);
    // rust: self.set_block(pos, next, 2);
}
}
    // rust: pub(crate) fn door_sound(&mut self, pos: BlockPos, state: BlockStateId, open: bool) {
    // rust: if let Some(set) = self.b.data(state).set_type.clone() {
    // rust: let pitch = self.random().next_float() * 0.1 + 0.9;
    // rust: let sound = if open {
    // rust: set.door_open.clone()
    // rust: } else {
    // rust: set.door_close.clone()
}
    // rust: self.sound(pos, &sound, 1.0, pitch);
}
}
    // rust: pub(crate) fn trapdoor_sound(&mut self, pos: BlockPos, state: BlockStateId, open: bool) {
    // rust: if let Some(set) = self.b.data(state).set_type.clone() {
    // rust: let pitch = self.random().next_float() * 0.1 + 0.9;
    // rust: let sound = if open {
    // rust: set.trapdoor_open.clone()
    // rust: } else {
    // rust: set.trapdoor_close.clone()
}
    // rust: self.sound(pos, &sound, 1.0, pitch);
    // rust: self.game_event(
    // rust: pos,
    // rust: if open {
    // rust: "minecraft:block_open"
    // rust: } else {
    // rust: "minecraft:block_close"
    // rust: },
    // rust: );
}
}
    // rust: pub(crate) fn trapdoor_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: if signal != b.table.bool(state, p.powered) {
    // rust: let mut state = state;
    // rust: if b.table.bool(state, p.open) != signal {
    // rust: state = b.table.set_bool(state, p.open, signal);
    // rust: self.trapdoor_sound(pos, state, signal);
}
    // rust: self.set_block(pos, b.table.set_bool(state, p.powered, signal), 2);
    // rust: if b.is_waterlogged(state) {
    // rust: self.schedule_water_tick(pos);
}
}
}
    // rust: pub(crate) fn gate_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let power = self.has_neighbor_signal(pos);
    // rust: if b.table.bool(state, p.powered) != power {
    // rust: let next = b
    // rust: .table
    // rust: .set_bool(b.table.set_bool(state, p.powered, power), p.open, power);
    // rust: self.set_block(pos, next, 2);
    // rust: if b.table.bool(state, p.open) != power {
    // rust: let data = b.data(state);
    // rust: let sound = if power {
    // rust: data.gate_open.clone()
    // rust: } else {
    // rust: data.gate_close.clone()
}
    // rust: let pitch = self.random().next_float() * 0.1 + 0.9;
    // rust: if let Some(sound) = sound {
    // rust: self.sound(pos, &sound, 1.0, pitch);
}
    // rust: self.game_event(
    // rust: pos,
    // rust: if power {
    // rust: "minecraft:block_open"
    // rust: } else {
    // rust: "minecraft:block_close"
    // rust: },
    // rust: );
}
}
}
    // rust: pub(crate) fn lamp_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let lit = b.table.bool(state, b.props.lit);
    // rust: if lit != self.has_neighbor_signal(pos) {
    // rust: if lit {
    // rust: self.schedule_tick(pos, b.block(state), 4);
    // rust: } else {
    // rust: self.set_block(pos, b.table.cycle(state, b.props.lit), 2);
}
}
}
    // rust: pub(crate) fn lamp_tick(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: if b.table.bool(state, b.props.lit) && !self.has_neighbor_signal(pos) {
    // rust: self.set_block(pos, b.table.cycle(state, b.props.lit), 2);
}
}
    // `CopperBulbBlock.checkAndFlip`.
    // rust: pub(crate) fn copper_bulb_check(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: if signal != b.table.bool(state, p.powered) {
    // rust: let mut next = state;
    // rust: if !b.table.bool(state, p.powered) {
    // rust: next = b.table.cycle(next, p.lit);
    // rust: let sound = if b.table.bool(next, p.lit) {
    // rust: "minecraft:block.copper_bulb.turn_on"
    // rust: } else {
    // rust: "minecraft:block.copper_bulb.turn_off"
}
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: sound.into(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
}
    // rust: self.set_block(pos, b.table.set_bool(next, p.powered, signal), 3);
}
}
    // `NoteBlock.playNote`: queues the block event and emits the game event.
    // rust: pub(crate) fn note_play(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: if !self.note_play_allowed(pos, state) {
    // rust: return;
}
    // rust: self.note_play_unchecked(pos, state);
}
    // rust: pub(crate) fn note_play_allowed(&self, pos: BlockPos, state: BlockStateId) -> bool {
    // rust: let b = self.b;
    // rust: let instrument = b.table.text(state, b.props.instrument);
    // rust: let note = b.table.int(state, b.props.note);
    // rust: self.level.allow_note_play(pos, instrument, note)
}
    // rust: pub(crate) fn note_play_unchecked(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let instrument = b.table.text(state, b.props.instrument);
    // rust: let mob_head = super::data::INSTRUMENTS
    // rust: .iter()
    // rust: .position(|n| *n == instrument)
    // rust: .is_some_and(|i| super::data::instrument_works_above(i as u8));
    // rust: if mob_head || b.is_air(self.above_state(pos)) {
    // rust: self.block_event(pos, b.block(state), 0, 0);
    // rust: self.game_event(pos, "minecraft:note_block_play");
}
}
    // `NoteBlock.triggerEvent`: the note's particle (tunable instruments)
    // and sound.
    // rust: pub(crate) fn note_trigger_event(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let instrument = b.table.text(state, b.props.instrument).to_owned();
    // rust: let mob_head = super::data::INSTRUMENTS
    // rust: .iter()
    // rust: .position(|n| *n == instrument)
    // rust: .is_some_and(|i| super::data::instrument_works_above(i as u8));
    // rust: let note = b.table.int(state, b.props.note);
    // rust: let pitch = if mob_head {
    // rust: 1.0
    // rust: } else {
            // `isTunable`: the client adds the NOTE particle above the block.
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "note_particle",
    // rust: });
    // rust: horizon_core::jmath::pow(2.0, f64::from(note - 12) / 12.0) as f32
}
        // NoteBlock.getCustomSoundId: the sound saved in the skull above is
        // read by the client; no skull or no sound means no sound.
    // rust: if instrument == "custom_head" {
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "note_custom_sound",
    // rust: });
    // rust: return;
}
    // rust: let sound = match instrument.as_str() {
    // rust: "dragon" => "minecraft:block.note_block.imitate.ender_dragon".to_owned(),
    // rust: name if mob_head => format!("minecraft:block.note_block.imitate.{name}"),
    // rust: name => format!("minecraft:block.note_block.{name}"),
}
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: sound.into(),
    // rust: volume: 3.0,
    // rust: pitch,
    // rust: });
}
    // rust: pub(crate) fn note_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: if signal != b.table.bool(state, b.props.powered) {
    // rust: if signal {
    // rust: self.note_play(pos, state);
}
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, b.props.powered, signal));
}
}
    // `TntBlock.prime` then `removeBlock`.
    // rust: pub(crate) fn tnt_check(&mut self, pos: BlockPos) {
        // TntBlock.prime succeeds only on a ServerLevel. A client's piston
        // replay must leave priming and block removal to the server.
    // rust: if !self.level.is_client_side() && self.has_neighbor_signal(pos) {
    // rust: self.prime_tnt(pos);
    // rust: self.remove_block(pos, false);
}
}
    // rust: pub(crate) fn dispenser_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let trigger = self.has_neighbor_signal(pos) || self.has_neighbor_signal(above(pos));
    // rust: let triggered = b.table.bool(state, b.props.triggered);
    // rust: if trigger && !triggered {
    // rust: self.schedule_tick(pos, b.block(state), 4);
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.triggered, true), 2);
    // rust: } else if !trigger && triggered {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.triggered, false), 2);
}
}
    // rust: pub(crate) fn hopper_check_powered(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let enabled = !self.has_neighbor_signal(pos);
    // rust: if enabled != b.table.bool(state, b.props.enabled) {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.enabled, enabled), 2);
}
}
    // rust: pub(crate) fn skull_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: if signal != b.table.bool(state, b.props.powered) {
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.powered, signal), 2);
}
}
    // rust: pub(crate) fn bell_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: if signal != b.table.bool(state, b.props.powered) {
    // rust: if signal {
    // rust: self.bell_ring(pos, state, b.facing(state));
}
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, b.props.powered, signal));
}
}
    // `BellBlock.onHit` with `requireHitFromCorrectSide`: a hit on `face` at
    // height `click_y` in the block rings the bell only when it struck the
    // bell proper. False when the hit missed it.
    // rust: pub(crate) fn bell_hit(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: face: Direction,
    // rust: click_y: f64,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let facing_axis = axis_of(b.facing(state));
    // rust: let proper = axis_of(face) != Axis::Y
    // rust: && click_y <= f64::from(0.8124f32)
    // rust: && match b.table.text(state, b.props.attachment) {
    // rust: "floor" => facing_axis == axis_of(face),
    // rust: "single_wall" | "double_wall" => facing_axis != axis_of(face),
    // rust: "ceiling" => true,
    // rust: _ => false,
}
    // rust: if proper {
    // rust: self.bell_ring(pos, state, face);
}
    // rust: proper
}
    // `BellBlock.attemptToRing`: `BellBlockEntity.onHit` queues block event 1
    // with the struck direction, then the sound and game event.
    // rust: pub(crate) fn bell_ring(&mut self, pos: BlockPos, state: BlockStateId, direction: Direction) {
    // rust: if !self.level.allow_bell_ring(pos) {
    // rust: return;
}
    // rust: self.block_event(pos, self.b.block(state), 1, direction as i32);
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.bell.use".into(),
    // rust: volume: 2.0,
    // rust: pitch: 1.0,
    // rust: });
    // rust: self.game_event(pos, "minecraft:block_change");
}
    // rust: pub(crate) fn crafter_neighbor_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let trigger = self.has_neighbor_signal(pos);
    // rust: let triggered = b.table.bool(state, b.props.triggered);
    // rust: if trigger && !triggered {
    // rust: self.schedule_tick(pos, b.block(state), 4);
    // rust: self.set_block(pos, b.table.set_bool(state, b.props.triggered, true), 2);
    // rust: } else if !trigger && triggered {
    // rust: let next = b.table.set_bool(
    // rust: b.table.set_bool(state, b.props.triggered, false),
    // rust: b.props.crafting,
    // rust: false,
    // rust: );
    // rust: self.set_block(pos, next, 2);
}
}
    // `TargetBlock.onProjectileHit` for a projectile that hit `face` of the
    // block at `pos` at `location`: the output power from how near the
    // face's centre it landed (1 to 15), reset after 20 ticks for an arrow
    // and 8 for anything else, unless a reset is already scheduled. None
    // when the block is not a target block, else the strength.
    // rust: pub(crate) fn target_projectile_hit(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: location: [f64; 3],
    // rust: face: [i32; 3],
    // rust: arrow: bool,
    // rust: ) -> Option<i32> {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: if !b.data(state).is(Class::Target) {
    // rust: return None;
}
        // `getRedstoneStrength`: the distance from the centre along the
        // face's two other axes (Mth.frac of the location, minus a half).
    // rust: let off = |v: f64| (v - v.floor() - 0.5).abs();
    // rust: let [dx, dy, dz] = [off(location[0]), off(location[1]), off(location[2])];
    // rust: let distance = if face[1] != 0 {
    // rust: dx.max(dz)
    // rust: } else if face[2] != 0 {
    // rust: dx.max(dy)
    // rust: } else {
    // rust: dy.max(dz)
}
    // rust: let strength = ((15.0 * ((0.5 - distance) / 0.5).clamp(0.0, 1.0)).ceil() as i32).max(1);
    // rust: let block = b.block(state);
    // rust: if !self.ticks.has_block_tick(pos, block) {
            // `setOutputPower`.
    // rust: self.set_block_and_update(pos, b.table.set_int(state, b.props.power, strength));
    // rust: self.schedule_tick(pos, block, if arrow { 20 } else { 8 });
}
    // rust: Some(strength)
}
}

// Order `positions` as a `java.util.HashSet<BlockPos>` of capacity 16 would
// iterate them (bucket index of the spread hash, then insertion order).
java_hash_set_order :: proc(positions: ^[dynamic]BlockPos) {
}
hash :: proc(pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
        // Vec3i.hashCode: (y + z * 31) * 31 + x
    // rust: (pos.y.wrapping_add(pos.z.wrapping_mul(31)))
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(pos.x)
}
    // rust: let mut unique: Vec<BlockPos> = Vec::new();
    // rust: for pos in positions.iter() {
    // rust: if !unique.contains(pos) {
    // rust: unique.push(*pos);
}
}
    // rust: let buckets = 16;
    // rust: let bucket = |pos: BlockPos| {
    // rust: let h = hash(pos);
    // rust: ((h ^ ((h as u32) >> 16) as i32) & (buckets - 1)) as usize
}
    // rust: let mut ordered: Vec<(usize, usize, BlockPos)> = unique
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, p)| (bucket(*p), i, *p))
    // rust: .collect();
    // rust: ordered.sort_by_key(|(b, i, _)| (*b, *i));
    // rust: *positions = ordered.into_iter().map(|(_, _, p)| p).collect();
}
