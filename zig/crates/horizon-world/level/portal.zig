//! Transpiled from Horizon Rust crate
//! Module: horizon-world_portal
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `PortalShape`: the obsidian frame search used by nether portal blocks.
// use super::{LevelAccess, Sim, update::rel};
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, position::BlockPos, random::RandomSource};

pub const MIN_WIDTH: i32 = 2;
pub const MAX_WIDTH: i32 = 21;
pub const MIN_HEIGHT: i32 = 3;
pub const MAX_HEIGHT: i32 = 21;

/// The result of `PortalShape.findAnyShape`.
pub const PortalShape = struct {
    x_axis: bool,
    right: Direction,
    bottom_left: BlockPos,
    width: i32,
    height: i32,
    portal_blocks: i32,
};

    // rust: impl PortalShape {
    // rust: pub const fn is_valid(&self) -> bool {
    // rust: self.width >= MIN_WIDTH
    // rust: && self.width <= MAX_WIDTH
    // rust: && self.height >= MIN_HEIGHT
    // rust: && self.height <= MAX_HEIGHT
}
    // rust: pub const fn is_complete(&self) -> bool {
    // rust: self.is_valid() && self.portal_blocks == self.width * self.height
}
}

pub fn step(pos: BlockPos, dir: Direction, n: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [dx, dy, dz] = dir.normal();
    // rust: pos.offset(dx * n, dy * n, dz * n)
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
pub fn portal_frame(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: b.tag("minecraft:nether_portal_frame")
    // rust: .is_some_and(|tag| b.in_set(state, tag))
}
    /// `PortalShape.isEmpty`: air, fire or a portal block.
pub fn portal_empty(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: b.is_air(state)
    // rust: || b.tag("minecraft:fire")
    // rust: .is_some_and(|tag| b.in_set(state, tag))
    // rust: || b.is_block(state, b.named.nether_portal)
}
pub fn portal_distance_until_edge_above_frame(self: *Self, pos: BlockPos, dir: Direction) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for width in 0..=MAX_WIDTH {
    // rust: let at = step(pos, dir, width);
    // rust: let state = self.state(at);
    // rust: if !self.portal_empty(state) {
    // rust: return if self.portal_frame(state) { width } else { 0 };
}
    // rust: if !self.portal_frame(self.state(rel(at, Direction::Down))) {
    // rust: break;
}
}
    // rust: 0
}
    /// `PortalShape.findAnyShape`.
pub fn find_portal_shape(self: *Self, pos: BlockPos, x_axis: bool) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let right = if x_axis {
    // rust: Direction::West
    // rust: } else {
    // rust: Direction::South
}
    // rust: let mut shape = PortalShape {
    // rust: x_axis,
    // rust: right,
    // rust: bottom_left: pos,
    // rust: width: 0,
    // rust: height: 0,
    // rust: portal_blocks: 0,
}
        // calculateBottomLeft
    // rust: let min_y = self.level.min_y().max(pos.y - MAX_HEIGHT);
    // rust: let mut start = pos;
    // rust: while start.y > min_y && self.portal_empty(self.state(rel(start, Direction::Down))) {
    // rust: start = rel(start, Direction::Down);
}
    // rust: let left = right.opposite();
    // rust: let edge = self.portal_distance_until_edge_above_frame(start, left) - 1;
    // rust: if edge < 0 {
    // rust: return shape;
}
    // rust: shape.bottom_left = step(start, left, edge);
        // calculateWidth
    // rust: let width = self.portal_distance_until_edge_above_frame(shape.bottom_left, right);
    // rust: if !(MIN_WIDTH..=MAX_WIDTH).contains(&width) {
    // rust: return shape;
}
    // rust: shape.width = width;
        // calculateHeight: getDistanceUntilTop counts portal blocks as it goes.
    // rust: let mut height = MAX_HEIGHT;
    // rust: 'rows: for h in 0..MAX_HEIGHT {
    // rust: let row = step(shape.bottom_left, Direction::Up, h);
    // rust: if !self.portal_frame(self.state(step(row, right, -1)))
    // rust: || !self.portal_frame(self.state(step(row, right, width)))
    // rust: {
    // rust: height = h;
    // rust: break;
}
    // rust: for i in 0..width {
    // rust: let state = self.state(step(row, right, i));
    // rust: if !self.portal_empty(state) {
    // rust: height = h;
    // rust: break 'rows;
}
    // rust: if self.b.is_block(state, self.b.named.nether_portal) {
    // rust: shape.portal_blocks += 1;
}
}
}
    // rust: let top = step(shape.bottom_left, Direction::Up, height);
    // rust: let has_top = (0..width).all(|i| self.portal_frame(self.state(step(top, right, i))));
    // rust: shape.height = if (MIN_HEIGHT..=MAX_HEIGHT).contains(&height) && has_top {
    // rust: height
    // rust: } else {
    // rust: 0
}
    // rust: shape
}
    /// `PortalShape.findEmptyPortalShape`: a valid frame holding no portal
    /// block yet, on the preferred axis first.
pub fn find_empty_portal_shape(self: *Self, pos: BlockPos, x_axis: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [x_axis, !x_axis]
    // rust: .into_iter()
    // rust: .map(|axis| self.find_portal_shape(pos, axis))
    // rust: .find(|shape| shape.is_valid() && shape.portal_blocks == 0)
}
    /// `PortalShape.createPortalBlocks`: fill the frame (flags 18).
pub fn create_portal_blocks(self: *Self, shape: *PortalShape) void {
}
    // rust: let b = self.b;
    // rust: let base = b.default_of(b.named.nether_portal);
    // rust: let state = b
    // rust: .table
    // rust: .with_text(base, b.props.axis, if shape.x_axis { "x" } else { "z" })
    // rust: .unwrap_or(base);
    // rust: for h in 0..shape.height {
    // rust: for w in 0..shape.width {
    // rust: let at = step(step(shape.bottom_left, Direction::Up, h), shape.right, w);
    // rust: self.set_block(at, state, 18);
}
}
}
    /// `BaseFireBlock.canBePlacedAt(level, pos, forwardDirection)`: air where
    /// fire would survive, or the inside of an empty portal frame (vertical
    /// directions pick the frame axis with the level random).
pub fn fire_can_be_placed_at(self: *Self, pos: BlockPos, forward: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.b.is_air(self.state(pos)) {
    // rust: return false;
}
    // rust: if self.can_survive(self.fire_state_for(pos), pos) {
    // rust: return true;
}
        // isPortal
    // rust: if !matches!(
    // rust: self.level.dimension(),
    // rust: super::Dimension::Overworld | super::Dimension::Nether
    // rust: ) {
    // rust: return false;
}
    // rust: for face in Direction::ALL {
    // rust: if self.portal_frame(self.state(rel(pos, face))) {
                // getCounterClockWise().getAxis(): north/south turn to X.
    // rust: let x_axis = match forward {
    // rust: Direction::North | Direction::South => true,
    // rust: Direction::West | Direction::East => false,
    // rust: Direction::Up | Direction::Down => {
    // rust: self.random().next_int_bound(2).unwrap_or(0) == 0
}
}
    // rust: return self.find_empty_portal_shape(pos, x_axis).is_some();
}
}
    // rust: false
}
}
