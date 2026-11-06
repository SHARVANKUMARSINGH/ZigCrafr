//! Transpiled from Horizon Rust crate
package horizon_world_orientation

import "core:fmt"
import "core:mem"
import "core:math"

// The 48 update contexts of vanilla `Orientation` and `ExperimentalRedstoneUtils`.
// use super::{LevelAccess, Sim, query::axis_of};
// use horizon_core::{
    // rust: geometry::{Axis, Direction},
    // rust: random::RandomSource,
}

SideBias :: enum {
    Left,
    Right,
}

Orientation :: struct {
    up: Direction,
    front: Direction,
    side_bias: SideBias,
}

    // rust: impl Orientation {
new :: proc(up: Direction, front: Direction, side_bias: SideBias) -> S {
    // Ported from Horizon
    return {}
}
    // rust: assert_ne!(axis_of(up), axis_of(front));
    // rust: Self {
    // rust: up,
    // rust: front,
    // rust: side_bias,
}
}
index :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let front_axis = if axis_of(self.up) == Axis::Y {
    // rust: usize::from(axis_of(self.front) == Axis::X)
    // rust: } else {
    // rust: usize::from(axis_of(self.front) == Axis::Y)
}
        // Direction.AxisDirection declares POSITIVE before NEGATIVE.
    // rust: let negative = usize::from(matches!(
    // rust: self.front,
    // rust: Direction::Down | Direction::North | Direction::West
    // rust: ));
    // rust: ((self.up as usize * 4 + ((front_axis * 2) | negative)) * 2)
    // rust: + usize::from(self.side_bias == SideBias::Right)
}
from_index :: proc(index: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: assert!(index < 48);
    // rust: let up = Direction::ALL[index / 8];
    // rust: let axis = match (axis_of(up), (index / 4) % 2) {
    // rust: (Axis::Y, 1) => Axis::X,
    // rust: (_, 1) => Axis::Y,
    // rust: (Axis::Z, _) => Axis::X,
    // rust: _ => Axis::Z,
}
    // rust: let negative = index & 2 != 0;
    // rust: let front = match (axis, negative) {
    // rust: (Axis::X, false) => Direction::East,
    // rust: (Axis::X, true) => Direction::West,
    // rust: (Axis::Y, false) => Direction::Up,
    // rust: (Axis::Y, true) => Direction::Down,
    // rust: (Axis::Z, false) => Direction::South,
    // rust: (Axis::Z, true) => Direction::North,
}
    // rust: Self::new(
    // rust: up,
    // rust: front,
    // rust: if index & 1 == 0 {
    // rust: SideBias::Left
    // rust: } else {
    // rust: SideBias::Right
    // rust: },
    // rust: )
}
up :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: self.up
}
front :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: self.front
}
side_bias :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.side_bias
}
side :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let [x, y, z] = self.front.normal();
    // rust: let [u, v, w] = self.up.normal();
    // rust: let cross = [y * w - z * v, z * u - x * w, x * v - y * u];
    // rust: let right = Direction::ALL
    // rust: .into_iter()
    // rust: .find(|d| d.normal() == cross)
    // rust: .unwrap();
    // rust: if self.side_bias == SideBias::Right {
    // rust: right
    // rust: } else {
    // rust: right.opposite()
}
}
with_front :: proc(self: ^Self, front: Direction) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let up = if front == self.up {
    // rust: self.front.opposite()
    // rust: } else if front == self.up.opposite() {
    // rust: self.front
    // rust: } else {
    // rust: self.up
}
    // rust: Self::new(up, front, self.side_bias)
}
with_up :: proc(self: ^Self, up: Direction) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let front = if up == self.front {
    // rust: self.up.opposite()
    // rust: } else if up == self.front.opposite() {
    // rust: self.up
    // rust: } else {
    // rust: self.front
}
    // rust: Self::new(up, front, self.side_bias)
}
with_front_preserve_up :: proc(self: ^Self, front: Direction) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if axis_of(front) == axis_of(self.up) {
    // rust: self
    // rust: } else {
    // rust: self.with_front(front)
}
}
with_front_adjust_side_bias :: proc(self: ^Self, front: Direction) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let next = self.with_front(front);
    // rust: if self.front == next.side() {
    // rust: next.with_mirror()
    // rust: } else {
    // rust: next
}
}
with_side_bias :: proc(self: ^Self, side_bias: SideBias) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { side_bias, ..self }
}
with_mirror :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.with_side_bias(if self.side_bias == SideBias::Left {
    // rust: SideBias::Right
    // rust: } else {
    // rust: SideBias::Left
    // rust: })
}
directions :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: self.front.opposite(),
    // rust: self.front,
    // rust: self.side(),
    // rust: self.side().opposite(),
    // rust: self.up.opposite(),
    // rust: self.up,
    // rust: ]
}
horizontal_directions :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: self.front.opposite(),
    // rust: self.front,
    // rust: self.side(),
    // rust: self.side().opposite(),
    // rust: ]
}
vertical_directions :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [self.up.opposite(), self.up]
}
random :: proc(random: ^impl RandomSource) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_index(random.next_int_bound(48).unwrap() as usize)
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    // rust: pub fn initial_orientation(
    // rust: &mut self,
    // rust: front: Option<Direction>,
    // rust: up: Option<Direction>,
    // rust: ) -> Option<Orientation> {
    // rust: if !self.level.redstone_experiments() {
    // rust: return None;
}
    // rust: let mut orientation = Orientation::random(self.random()).with_side_bias(SideBias::Left);
    // rust: if let Some(up) = up {
    // rust: orientation = orientation.with_up(up);
}
    // rust: if let Some(front) = front {
    // rust: orientation = orientation.with_front(front);
}
    // rust: Some(orientation)
}
}
