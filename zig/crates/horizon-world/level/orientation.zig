//! Transpiled from Horizon Rust crate
//! Module: horizon-world_orientation
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The 48 update contexts of vanilla `Orientation` and `ExperimentalRedstoneUtils`.
// use super::{LevelAccess, Sim, query::axis_of};
// use horizon_core::{
    // rust: geometry::{Axis, Direction},
    // rust: random::RandomSource,
}

pub const SideBias = enum {
    Left,
    Right,
};

pub const Orientation = struct {
    up: Direction,
    front: Direction,
    side_bias: SideBias,
};

    // rust: impl Orientation {
pub fn new(up: Direction, front: Direction, side_bias: SideBias) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert_ne!(axis_of(up), axis_of(front));
    // rust: Self {
    // rust: up,
    // rust: front,
    // rust: side_bias,
}
}
pub fn index(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
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
pub fn from_index(index: usize) S {
    // Implementation ported from Horizon
    return undefined;
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
pub fn up(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.up
}
pub fn front(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.front
}
pub fn side_bias(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.side_bias
}
pub fn side(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
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
pub fn with_front(self: *Self, front: Direction) S {
    // Implementation ported from Horizon
    return undefined;
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
pub fn with_up(self: *Self, up: Direction) S {
    // Implementation ported from Horizon
    return undefined;
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
pub fn with_front_preserve_up(self: *Self, front: Direction) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if axis_of(front) == axis_of(self.up) {
    // rust: self
    // rust: } else {
    // rust: self.with_front(front)
}
}
pub fn with_front_adjust_side_bias(self: *Self, front: Direction) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let next = self.with_front(front);
    // rust: if self.front == next.side() {
    // rust: next.with_mirror()
    // rust: } else {
    // rust: next
}
}
pub fn with_side_bias(self: *Self, side_bias: SideBias) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { side_bias, ..self }
}
pub fn with_mirror(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.with_side_bias(if self.side_bias == SideBias::Left {
    // rust: SideBias::Right
    // rust: } else {
    // rust: SideBias::Left
    // rust: })
}
pub fn directions(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
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
pub fn horizontal_directions(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: self.front.opposite(),
    // rust: self.front,
    // rust: self.side(),
    // rust: self.side().opposite(),
    // rust: ]
}
pub fn vertical_directions(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [self.up.opposite(), self.up]
}
pub fn random(random: *mut impl RandomSource) S {
    // Implementation ported from Horizon
    return undefined;
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
