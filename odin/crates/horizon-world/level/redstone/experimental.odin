//! Transpiled from Horizon Rust crate
package horizon_world_experimental

import "core:fmt"
import "core:mem"
import "core:math"

// `ExperimentalRedstoneWireEvaluator`: calculate first, then write and notify in
// first-discovery order. A wire retains the orientation with which it was found.
// use super::*;
// use crate::level::orientation::{Orientation, SideBias};
// use std::collections::{HashMap, VecDeque};

Evaluator :: struct {
    off: VecDeque<BlockPos>,
    on: VecDeque<BlockPos>,
    indices: HashMap<BlockPos,
    wires: Vec<(BlockPos,
}
    // rust: impl Evaluator {
set_power :: proc(self: ^Self, pos: BlockPos, power: i32, orientation: Orientation) {
}
    // rust: if let Some(&index) = self.indices.get(&pos) {
    // rust: self.wires[index].1 = power;
    // rust: } else {
    // rust: self.indices.insert(pos, self.wires.len());
    // rust: self.wires.push((pos, power, orientation));
}
}
    // rust: fn power<L: LevelAccess + ?Sized>(&self, sim: &Sim<'_, L>, pos: BlockPos) -> i32 {
    // rust: self.indices
    // rust: .get(&pos)
    // rust: .map_or_else(|| sim.wire_power_of(sim.state(pos)), |&i| self.wires[i].1)
}
    // rust: fn incoming<L: LevelAccess + ?Sized>(&self, sim: &Sim<'_, L>, pos: BlockPos) -> i32 {
    // rust: let mut signal = 0;
    // rust: for direction in HORIZONTAL {
    // rust: let neighbor_pos = rel(pos, direction);
    // rust: let neighbor = sim.state(neighbor_pos);
    // rust: signal = signal.max(self.power(sim, neighbor_pos));
    // rust: let above_pos = above(pos);
    // rust: if sim.is_redstone_conductor(neighbor, neighbor_pos)
    // rust: && !sim.is_redstone_conductor(sim.state(above_pos), above_pos)
    // rust: {
    // rust: signal = signal.max(self.power(sim, above(neighbor_pos)));
    // rust: } else if !sim.is_redstone_conductor(neighbor, neighbor_pos) {
    // rust: signal = signal.max(self.power(sim, below(neighbor_pos)));
}
}
    // rust: (signal - 1).max(0)
}
    // rust: fn enqueue<L: LevelAccess + ?Sized>(
    // rust: &mut self,
    // rust: sim: &Sim<'_, L>,
    // rust: pos: BlockPos,
    // rust: from_power: i32,
    // rust: orientation: Orientation,
    // rust: turn_off: bool,
    // rust: ) {
    // rust: if !sim.b.is_block(sim.state(pos), sim.b.named.redstone_wire) {
    // rust: return;
}
    // rust: let power = self.power(sim, pos);
    // rust: if power < from_power - 1 && !self.on.contains(&pos) {
    // rust: self.on.push_back(pos);
    // rust: self.set_power(pos, power, orientation);
}
    // rust: if turn_off && power > from_power && !self.off.contains(&pos) {
    // rust: self.off.push_back(pos);
    // rust: self.set_power(pos, power, orientation);
}
}
    // rust: fn propagate<L: LevelAccess + ?Sized>(
    // rust: &mut self,
    // rust: sim: &Sim<'_, L>,
    // rust: pos: BlockPos,
    // rust: power: i32,
    // rust: orientation: Orientation,
    // rust: turn_off: bool,
    // rust: ) {
    // rust: for direction in orientation.horizontal_directions() {
    // rust: self.enqueue(
    // rust: sim,
    // rust: rel(pos, direction),
    // rust: power,
    // rust: orientation.with_front(direction),
    // rust: turn_off,
    // rust: );
}
    // rust: for vertical in orientation.vertical_directions() {
    // rust: let offset = rel(pos, vertical);
    // rust: let solid = sim.is_redstone_conductor(sim.state(offset), offset);
    // rust: for direction in orientation.horizontal_directions() {
    // rust: let neighbor = rel(pos, direction);
    // rust: if (vertical == Direction::Up && !solid)
    // rust: || (vertical == Direction::Down
    // rust: && !sim.is_redstone_conductor(sim.state(neighbor), neighbor))
    // rust: {
    // rust: self.enqueue(
    // rust: sim,
    // rust: rel(offset, direction),
    // rust: power,
    // rust: orientation.with_front(direction),
    // rust: turn_off,
    // rust: );
}
}
}
}
    // rust: fn calculate<L: LevelAccess + ?Sized>(
    // rust: &mut self,
    // rust: sim: &Sim<'_, L>,
    // rust: initial: BlockPos,
    // rust: orientation: Orientation,
    // rust: ) {
    // rust: let state = sim.state(initial);
    // rust: if sim.b.is_block(state, sim.b.named.redstone_wire) {
    // rust: self.set_power(initial, sim.wire_power_of(state), orientation);
    // rust: self.off.push_back(initial);
    // rust: } else {
    // rust: self.propagate(sim, initial, 0, orientation, true);
}
    // rust: while let Some(pos) = self.off.pop_front() {
    // rust: let (_, old, orientation) = self.wires[self.indices[&pos]];
    // rust: let block = sim.wire_block_signal(pos);
    // rust: let new = block.max(self.incoming(sim, pos));
    // rust: let power = if new < old {
    // rust: if block > 0 && !self.on.contains(&pos) {
    // rust: self.on.push_back(pos);
}
    // rust: 0
    // rust: } else {
    // rust: new
}
    // rust: if power != old {
    // rust: self.set_power(pos, power, orientation);
}
    // rust: self.propagate(sim, pos, power, orientation, old > new);
}
    // rust: while let Some(pos) = self.on.pop_front() {
    // rust: let (_, old, orientation) = self.wires[self.indices[&pos]];
    // rust: let new = sim.wire_block_signal(pos).max(self.incoming(sim, pos));
    // rust: if new > old {
    // rust: self.set_power(pos, new, orientation);
    // rust: } else {
    // rust: assert_eq!(new, old, "Turning off wire while trying to turn it on");
}
    // rust: self.propagate(sim, pos, new, orientation, false);
}
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    // rust: pub(super) fn experimental_wire_update(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: incoming: Option<Orientation>,
    // rust: update_shape: bool,
    // rust: ) {
    // rust: let orientation = incoming
    // rust: .unwrap_or_else(|| Orientation::random(self.random()))
    // rust: .with_up(Direction::Up)
    // rust: .with_side_bias(SideBias::Left);
    // rust: let mut evaluator = Evaluator::default();
    // rust: evaluator.calculate(self, pos, orientation);
    // rust: let mut changed = Vec::new();
    // rust: for (index, (pos, power, orientation)) in evaluator.wires.into_iter().enumerate() {
    // rust: let state = self.state(pos);
    // rust: if self.b.is_block(state, self.b.named.redstone_wire)
    // rust: && self.wire_power_of(state) != power
    // rust: {
    // rust: let flags = if update_shape && index == 0 {
    // rust: 2
    // rust: } else {
    // rust: 2 | 128
}
    // rust: self.set_block(
    // rust: pos,
    // rust: self.b.table.set_int(state, self.b.props.power, power),
    // rust: flags,
    // rust: );
    // rust: changed.push((pos, orientation));
}
}
    // rust: let wire = self.b.named.redstone_wire;
    // rust: for (pos, orientation) in changed {
    // rust: let state = self.state(pos);
    // rust: for direction in orientation.directions() {
    // rust: let connected = if axis_of(direction) == Axis::Y {
    // rust: direction == Direction::Down
    // rust: } else {
    // rust: self.wire_connected(state, direction)
}
    // rust: if !connected {
    // rust: continue;
}
    // rust: let neighbor = rel(pos, direction);
    // rust: let neighbor_state = self.state(neighbor);
    // rust: let next = orientation.with_front_preserve_up(direction);
    // rust: self.neighbor_changed_full_oriented(
    // rust: neighbor_state,
    // rust: neighbor,
    // rust: wire,
    // rust: Some(next),
    // rust: false,
    // rust: );
    // rust: if self.is_redstone_conductor(neighbor_state, neighbor) {
    // rust: for other in next.directions() {
    // rust: if other != direction.opposite() {
    // rust: self.neighbor_changed_at_oriented(
    // rust: rel(neighbor, other),
    // rust: wire,
    // rust: Some(next.with_front_preserve_up(other)),
    // rust: );
}
}
}
}
}
}
}
