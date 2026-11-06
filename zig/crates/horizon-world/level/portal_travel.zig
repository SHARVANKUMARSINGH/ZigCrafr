//! Transpiled from Horizon Rust crate
//! Module: horizon-world_portal_travel
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Nether portal travel: `PortalForcer` (finding and building exit portals),
//! `BlockUtil.getLargestRectangleAround`, `PortalShape.getRelativePosition`
//! and `NetherPortalBlock.createDimensionTransition`.
// use super::{Behaviours, LevelAccess, Sim, Ticks};
// use crate::fluid::FluidKind;
// use crate::{
    // rust: java_hash_map::{JavaHashMap, JavaKey},
    // rust: registry::BlockStateId,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Direction, ShapeOp, Vec3, VoxelShape},
    // rust: position::BlockPos,
}
// use std::cmp::Ordering;

/// `BlockUtil.FoundRectangle`: the low corner and the sizes along the two axes.
pub const FoundRectangle = struct {
    min_corner: BlockPos,
    axis1_size: i32,
    axis2_size: i32,
};

/// The world border's extent (`getMinX` .. `getMaxX`, `getMinZ` .. `getMaxZ`).
pub const BorderBounds = struct {
    min_x: f64,
    min_z: f64,
    max_x: f64,
    max_z: f64,
};
    // rust: impl BorderBounds {
    /// `WorldBorder.isWithinBounds(x, z)`.
pub fn contains(self: *Self, x: f64, z: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: x >= self.min_x && x < self.max_x && z >= self.min_z && z < self.max_z
}
    /// `WorldBorder.isWithinBounds(BlockPos)`.
pub fn contains_block(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.contains(f64::from(pos.x), f64::from(pos.z))
}
    /// `WorldBorder.clampToBounds(x, y, z)`.
pub fn clamp(self: *Self, x: f64, y: f64, z: f64) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let margin = f64::from(1.0e-5_f32);
    // rust: let clamp = |v: f64, lo: f64, hi: f64| if v < lo { lo } else { v.min(hi) };
    // rust: BlockPos::new(
    // rust: clamp(x, self.min_x, self.max_x - margin).floor() as i32,
    // rust: y.floor() as i32,
    // rust: clamp(z, self.min_z, self.max_z - margin).floor() as i32,
    // rust: )
}
}

pub fn step(pos: BlockPos, direction: Direction, n: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [dx, dy, dz] = direction.normal();
    // rust: pos.offset(dx * n, dy * n, dz * n)
}
pub fn negative(axis: Axis) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match axis {
    // rust: Axis::X => Direction::West,
    // rust: Axis::Y => Direction::Down,
    // rust: Axis::Z => Direction::North,
}
}
pub fn component(pos: BlockPos, axis: Axis) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match axis {
    // rust: Axis::X => pos.x,
    // rust: Axis::Y => pos.y,
    // rust: Axis::Z => pos.z,
}
}
/// `Direction.getClockWise` for the horizontal directions.
pub fn clockwise(direction: Direction) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match direction {
    // rust: Direction::North => Direction::East,
    // rust: Direction::East => Direction::South,
    // rust: Direction::South => Direction::West,
    // rust: Direction::West => Direction::North,
    // rust: other => other,
}
}

/// `BlockUtil.getLimit`: how many steps from `start` along `direction` pass `test`.
    // rust: fn limit(
    // rust: test: &mut impl FnMut(BlockPos) -> bool,
    // rust: start: BlockPos,
    // rust: direction: Direction,
    // rust: limit: i32,
    // rust: ) -> i32 {
    // rust: let mut max = 0;
    // rust: let mut pos = start;
    // rust: while max < limit {
    // rust: pos = step(pos, direction, 1);
    // rust: if !test(pos) {
    // rust: break;
}
    // rust: max += 1;
}
    // rust: max
}

/// `BlockUtil.getMaxRectangleLocation`: the widest-area run of `columns`
/// (start, end inclusive) and its height.
pub fn max_rectangle_location(columns: *[i32]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut max_start, mut max_end, mut max_height) = (0usize, 0usize, 0i32);
    // rust: let mut stack: Vec<usize> = vec![0];
    // rust: for column in 1..=columns.len() {
    // rust: let height = if column == columns.len() {
    // rust: 0
    // rust: } else {
    // rust: columns[column]
}
    // rust: while let Some(&top) = stack.last() {
    // rust: let stack_height = columns[top];
    // rust: if height >= stack_height {
    // rust: stack.push(column);
    // rust: break;
}
    // rust: stack.pop();
    // rust: let start = stack.last().map_or(0, |t| t + 1);
    // rust: if i64::from(stack_height) * (column - start) as i64
    // rust: > i64::from(max_height) * (max_end - max_start) as i64
    // rust: {
    // rust: max_end = column;
    // rust: max_start = start;
    // rust: max_height = stack_height;
}
}
    // rust: if stack.is_empty() {
    // rust: stack.push(column);
}
}
    // rust: (max_start as i32, max_end as i32 - 1, max_height)
}

/// `BlockUtil.getLargestRectangleAround`: the largest rectangle of positions
/// passing `test` in the plane of `axis1` and `axis2` that contains `center`.
    // rust: pub fn largest_rectangle_around(
    // rust: center: BlockPos,
    // rust: axis1: Axis,
    // rust: limit1: i32,
    // rust: axis2: Axis,
    // rust: limit2: i32,
    // rust: mut test: impl FnMut(BlockPos) -> bool,
    // rust: ) -> FoundRectangle {
    // rust: let negative1 = negative(axis1);
    // rust: let positive1 = negative1.opposite();
    // rust: let negative2 = negative(axis2);
    // rust: let positive2 = negative2.opposite();
    // rust: let negative_delta1 = limit(&mut test, center, negative1, limit1);
    // rust: let positive_delta1 = limit(&mut test, center, positive1, limit1);
    // rust: let center_index1 = negative_delta1 as usize;
    // rust: let mut bounds = vec![(0, 0); center_index1 + 1 + positive_delta1 as usize];
    // rust: bounds[center_index1] = (
    // rust: limit(&mut test, center, negative2, limit2),
    // rust: limit(&mut test, center, positive2, limit2),
    // rust: );
    // rust: let center_index2 = bounds[center_index1].0;
    // rust: for i in 1..=negative_delta1 as usize {
    // rust: let last = bounds[center_index1 - (i - 1)];
    // rust: let at = step(center, negative1, i as i32);
    // rust: bounds[center_index1 - i] = (
    // rust: limit(&mut test, at, negative2, last.0),
    // rust: limit(&mut test, at, positive2, last.1),
    // rust: );
}
    // rust: for i in 1..=positive_delta1 as usize {
    // rust: let last = bounds[center_index1 + i - 1];
    // rust: let at = step(center, positive1, i as i32);
    // rust: bounds[center_index1 + i] = (
    // rust: limit(&mut test, at, negative2, last.0),
    // rust: limit(&mut test, at, positive2, last.1),
    // rust: );
}
    // rust: let (mut min_axis1, mut min_axis2, mut size_axis1, mut size_axis2) = (0, 0, 0, 0);
    // rust: let mut columns = vec![0; bounds.len()];
    // rust: for i2 in (0..=center_index2).rev() {
    // rust: for (i1, b) in bounds.iter().enumerate() {
    // rust: let min2 = center_index2 - b.0;
    // rust: let max2 = center_index2 + b.1;
    // rust: columns[i1] = if i2 >= min2 && i2 <= max2 {
    // rust: max2 + 1 - i2
    // rust: } else {
    // rust: 0
}
}
    // rust: let (start, end, height) = max_rectangle_location(&columns);
    // rust: let new_size1 = 1 + end - start;
    // rust: if new_size1 * height > size_axis1 * size_axis2 {
    // rust: min_axis1 = start;
    // rust: min_axis2 = i2;
    // rust: size_axis1 = new_size1;
    // rust: size_axis2 = height;
}
}
    // rust: let corner = step(
    // rust: center,
    // rust: negative1.opposite(),
    // rust: min_axis1 - center_index1 as i32,
    // rust: );
    // rust: let corner = step(corner, negative2.opposite(), min_axis2 - center_index2);
    // rust: FoundRectangle {
    // rust: min_corner: corner,
    // rust: axis1_size: size_axis1,
    // rust: axis2_size: size_axis2,
}
}

/// `PortalShape.getRelativePosition`: where in the portal rectangle an entity
/// of `width` by `height` at `position` stands (right and up as fractions,
/// forward in blocks; living entities, minecarts and boats then drop the
/// forward part, `LivingEntity.resetForwardDirectionOfRelativePortalPosition`).
    // rust: pub fn relative_position(
    // rust: rectangle: FoundRectangle,
    // rust: x_axis: bool,
    // rust: position: Vec3,
    // rust: width: f32,
    // rust: height: f32,
    // rust: ) -> Vec3 {
    // rust: let axis = if x_axis { Axis::X } else { Axis::Z };
    // rust: let room_width = f64::from(rectangle.axis1_size) - f64::from(width);
    // rust: let room_height = f64::from(rectangle.axis2_size) - f64::from(height);
    // rust: let bottom = rectangle.min_corner;
    // rust: let clamp = |v: f64| if v < 0.0 { 0.0 } else { v.min(1.0) };
    // rust: let right = if room_width > 0.0 {
    // rust: let start = f64::from(component(bottom, axis)) + f64::from(width) / 2.0;
    // rust: clamp((position.component(axis) - start) / room_width)
    // rust: } else {
    // rust: 0.5
}
    // rust: let up = if room_height > 0.0 {
    // rust: clamp((position.y - f64::from(bottom.y)) / room_height)
    // rust: } else {
    // rust: 0.0
}
    // rust: let forward_axis = if x_axis { Axis::Z } else { Axis::X };
    // rust: let forward =
    // rust: position.component(forward_axis) - (f64::from(component(bottom, forward_axis)) + 0.5);
    // rust: Vec3::new(right, up, forward)
}

/// `NetherPortalBlock.createDimensionTransition` before
/// `PortalShape.findCollisionFreePosition`: the bottom centre of the entity in
/// the exit portal and the yaw it turns by (0 or 90).
    // rust: pub fn exit_position(
    // rust: exit: FoundRectangle,
    // rust: exit_x_axis: bool,
    // rust: entry_x_axis: bool,
    // rust: offset: Vec3,
    // rust: width: f32,
    // rust: height: f32,
    // rust: ) -> (Vec3, f32) {
    // rust: let rotation = if entry_x_axis == exit_x_axis {
    // rust: 0.0
    // rust: } else {
    // rust: 90.0
}
    // rust: let right = f64::from(width) / 2.0 + (f64::from(exit.axis1_size) - f64::from(width)) * offset.x;
    // rust: let up = (f64::from(exit.axis2_size) - f64::from(height)) * offset.y;
    // rust: let forward = 0.5 + offset.z;
    // rust: let b = exit.min_corner;
    // rust: let target = Vec3::new(
    // rust: f64::from(b.x) + if exit_x_axis { right } else { forward },
    // rust: f64::from(b.y) + up,
    // rust: f64::from(b.z) + if exit_x_axis { forward } else { right },
    // rust: );
    // rust: (target, rotation)
}

    // rust: impl BorderBounds {
    /// `WorldBorder.isWithinBounds(AABB)`: both corners, the far one pulled
    /// in by 1.0E-5F.
pub fn contains_box(self: *Self, b: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let margin = f64::from(1.0e-5_f32);
    // rust: self.contains(b.min(Axis::X), b.min(Axis::Z))
    // rust: && self.contains(b.max(Axis::X) - margin, b.max(Axis::Z) - margin)
}
}

/// `CollisionGetter.findFreePosition` without an entity's collision context:
/// within `allowed`, the point nearest `preferred` where a box of the size
/// centred there meets no block collision inside the border. `shape(pos)`
/// is the block's collision shape there, in world coordinates.
    // rust: pub fn find_free_position(
    // rust: allowed: Aabb,
    // rust: preferred: Vec3,
    // rust: size: Vec3,
    // rust: border: &BorderBounds,
    // rust: mut shape: impl FnMut(BlockPos) -> Option<VoxelShape>,
    // rust: ) -> Option<Vec3> {
    // rust: let allowed_shape = VoxelShape::from_box(allowed).ok()?;
    // rust: if allowed_shape.is_empty() {
    // rust: return None;
}
    // rust: let search = allowed_shape.bounds()?.inflate(size);
    // rust: let half = size.scale(0.5);
    // rust: let mut expanded = VoxelShape::empty();
    // BlockCollisions over the search area: every block whose shape meets it.
    // rust: let lo = |v: f64| (v - 1.0e-7).floor() as i32 - 1;
    // rust: let hi = |v: f64| (v + 1.0e-7).floor() as i32 + 1;
    // rust: for z in lo(search.min(Axis::Z))..=hi(search.max(Axis::Z)) {
    // rust: for y in lo(search.min(Axis::Y))..=hi(search.max(Axis::Y)) {
    // rust: for x in lo(search.min(Axis::X))..=hi(search.max(Axis::X)) {
    // rust: let Some(block) = shape(BlockPos::new(x, y, z)) else {
    // rust: continue;
}
    // rust: if block.is_empty()
    // rust: || !block.boxes().iter().any(|b| b.intersects(search))
    // rust: || !block.bounds().is_some_and(|b| border.contains_box(b))
    // rust: {
    // rust: continue;
}
    // rust: for b in block.boxes() {
    // rust: let grown = VoxelShape::from_box(b.inflate(half)).ok()?;
    // rust: expanded = expanded.join(&grown, ShapeOp::OR).ok()?;
}
}
}
}
    // rust: let free = allowed_shape.join(&expanded, ShapeOp::ONLY_FIRST).ok()?;
    // rust: free.closest_point(preferred)
}

/// `PortalShape.findCollisionFreePosition`: `bottom_center` moved to the
/// nearest spot within its column of the entity's width (and a block up)
/// where it fits; entities over 4 blocks stay put.
    // rust: pub fn collision_free_position(
    // rust: bottom_center: Vec3,
    // rust: width: f32,
    // rust: height: f32,
    // rust: border: &BorderBounds,
    // rust: shape: impl FnMut(BlockPos) -> Option<VoxelShape>,
    // rust: ) -> Vec3 {
    // rust: if width > 4.0 || height > 4.0 {
    // rust: return bottom_center;
}
    // rust: let half_height = f64::from(height) / 2.0;
    // rust: let center = bottom_center.add_vector(Vec3::new(0.0, half_height, 0.0));
    // rust: let w = f64::from(width);
    // rust: let allowed = Aabb::of_size(center, Vec3::new(w, 0.0, w))
    // rust: .expand_towards(Vec3::new(0.0, 1.0, 0.0))
    // rust: .inflate(Vec3::new(1.0e-6, 1.0e-6, 1.0e-6));
    // rust: find_free_position(
    // rust: allowed,
    // rust: center,
    // rust: Vec3::new(w, f64::from(height), w),
    // rust: border,
    // rust: shape,
    // rust: )
    // rust: .map_or(bottom_center, |p| {
    // rust: p.subtract(Vec3::new(0.0, half_height, 0.0))
    // rust: })
}

/// A portal block position as a `PoiRecord` in a `PoiSection`'s hash set.
pub const Record = struct {};
    // rust: impl JavaKey for Record {
    /// `Vec3i.hashCode`.
pub fn java_hash(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.0;
    // rust: p.y.wrapping_add(p.z.wrapping_mul(31))
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(p.x)
}
pub fn tie_break(self: *Self, other: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.0.y, self.0.z, self.0.x)
    // rust: .cmp(&(other.0.y, other.0.z, other.0.x))
    // rust: .then(Ordering::Less)
}
}

/// `PortalForcer.findClosestPortalPosition` over the nether portal blocks
/// `portals` (the points of interest, in the order their sections hold
/// them): within 16 blocks of `approximate` going to the Nether, 128 out of
/// it, inside the border, nearest first, then lowest.
    // rust: pub fn closest_portal(
    // rust: portals: &[BlockPos],
    // rust: approximate: BlockPos,
    // rust: to_nether: bool,
    // rust: border: &BorderBounds,
    // rust: min_section: i32,
    // rust: max_section: i32,
    // rust: ) -> Option<BlockPos> {
    // rust: let radius: i32 = if to_nether { 16 } else { 128 };
    // PoiManager.getInSquare: the chunks of ChunkPos.rangeClosed (x fastest),
    // each section from the bottom, each section's records in hash set order.
    // rust: let chunk_radius = radius.div_euclid(16) + 1;
    // rust: let (cx, cz) = (approximate.x >> 4, approximate.z >> 4);
    // rust: let mut sections: std::collections::HashMap<(i32, i32, i32), JavaHashMap<Record, ()>> =
    // rust: std::collections::HashMap::new();
    // rust: for &p in portals {
    // rust: sections
    // rust: .entry((p.x >> 4, p.y >> 4, p.z >> 4))
    // rust: .or_default()
    // rust: .put(Record(p), ());
}
    // rust: let mut best: Option<(f64, BlockPos)> = None;
    // rust: for z in cz - chunk_radius..=cz + chunk_radius {
    // rust: for x in cx - chunk_radius..=cx + chunk_radius {
    // rust: for y in min_section..=max_section {
    // rust: let Some(set) = sections.get(&(x, y, z)) else {
    // rust: continue;
}
    // rust: for (record, _) in set.entries() {
    // rust: let p = record.0;
    // rust: if (p.x - approximate.x).abs() > radius
    // rust: || (p.z - approximate.z).abs() > radius
    // rust: || !border.contains_block(p)
    // rust: {
    // rust: continue;
}
    // rust: let (dx, dy, dz) = (
    // rust: f64::from(p.x) - f64::from(approximate.x),
    // rust: f64::from(p.y) - f64::from(approximate.y),
    // rust: f64::from(p.z) - f64::from(approximate.z),
    // rust: );
    // rust: let d = dx * dx + dy * dy + dz * dz;
    // rust: if best.is_none_or(|(bd, bp)| d < bd || (d == bd && p.y < bp.y)) {
    // rust: best = Some((d, p));
}
}
}
}
}
    // rust: best.map(|(_, p)| p)
}

/// `BlockPos.spiralAround(center, radius, first, second)`.
    // rust: fn spiral_around(
    // rust: center: BlockPos,
    // rust: radius: i32,
    // rust: first: Direction,
    // rust: second: Direction,
    // rust: ) -> Vec<BlockPos> {
    // rust: let directions = [first, second, first.opposite(), second.opposite()];
    // rust: let mut out = Vec::new();
    // rust: let mut last = step(center, second, 1);
    // rust: let legs = 4 * radius;
    // rust: let (mut leg, mut leg_size, mut leg_index) = (-1i32, 0, 0);
    // rust: loop {
    // rust: let cursor = step(last, directions[((leg + 4) % 4) as usize], 1);
    // rust: last = cursor;
    // rust: if leg_index >= leg_size {
    // rust: if leg >= legs {
    // rust: return out;
}
    // rust: leg += 1;
    // rust: leg_index = 0;
    // rust: leg_size = leg / 2 + 1;
}
    // rust: leg_index += 1;
    // rust: out.push(cursor);
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    /// `PortalForcer.canPortalReplaceBlock`.
pub fn portal_can_replace(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.state(pos);
    // rust: self.b.is_replaceable(state) && self.b.fluid(state).kind() == FluidKind::Empty
}
    /// `PortalForcer.canHostFrame`.
pub fn can_host_frame(self: *Self, origin: BlockPos, direction: Direction, offset: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let side = clockwise(direction);
    // rust: for width in -1..3 {
    // rust: for height in -1..4 {
    // rust: let at = step(step(origin, direction, width), side, offset).offset(0, height, 0);
    // rust: if height < 0 && !self.b.is_solid(self.state(at)) {
    // rust: return false;
}
    // rust: if height >= 0 && !self.portal_can_replace(at) {
    // rust: return false;
}
}
}
    // rust: true
}
    /// `PortalForcer.createPortal`: a 2 by 3 portal in an obsidian frame at the
    /// nearest column around `origin` with room for it (on a platform it
    /// carves out when none has), facing `x_axis`.
    // rust: pub fn create_portal(
    // rust: &mut self,
    // rust: origin: BlockPos,
    // rust: x_axis: bool,
    // rust: border: &BorderBounds,
    // rust: logical_height: i32,
    // rust: ) -> Option<FoundRectangle> {
    // rust: let direction = if x_axis {
    // rust: Direction::East
    // rust: } else {
    // rust: Direction::South
}
    // rust: let (min_y, max_y) = (self.level.min_y(), self.level.max_y() - 1);
    // rust: let max_placeable = max_y.min(min_y + logical_height - 1);
    // rust: let distance = |a: BlockPos, b: BlockPos| {
    // rust: let (dx, dy, dz) = (
    // rust: f64::from(a.x) - f64::from(b.x),
    // rust: f64::from(a.y) - f64::from(b.y),
    // rust: f64::from(a.z) - f64::from(b.z),
    // rust: );
    // rust: dx * dx + dy * dy + dz * dz
}
    // rust: let mut full: Option<(f64, BlockPos)> = None;
    // rust: let mut partial: Option<(f64, BlockPos)> = None;
    // rust: for column in spiral_around(origin, 16, Direction::East, Direction::South) {
    // rust: let top = self.b.motion_blocking_top(&*self.level, column).y;
    // rust: let height = max_placeable.min(top);
    // rust: if !border.contains_block(column) || !border.contains_block(step(column, direction, 1))
    // rust: {
    // rust: continue;
}
    // rust: let mut y = height;
    // rust: while y >= min_y {
    // rust: let at = BlockPos::new(column.x, y, column.z);
    // rust: if self.portal_can_replace(at) {
    // rust: let first_empty = y;
    // rust: while y > min_y
    // rust: && self.portal_can_replace(BlockPos::new(column.x, y - 1, column.z))
    // rust: {
    // rust: y -= 1;
}
    // rust: if y + 4 <= max_placeable {
    // rust: let delta = first_empty - y;
    // rust: if delta <= 0 || delta >= 3 {
    // rust: let at = BlockPos::new(column.x, y, column.z);
    // rust: if self.can_host_frame(at, direction, 0) {
    // rust: let d = distance(origin, at);
    // rust: if self.can_host_frame(at, direction, -1)
    // rust: && self.can_host_frame(at, direction, 1)
    // rust: && full.is_none_or(|(fd, _)| fd > d)
    // rust: {
    // rust: full = Some((d, at));
}
    // rust: if full.is_none() && partial.is_none_or(|(pd, _)| pd > d) {
    // rust: partial = Some((d, at));
}
}
}
}
}
    // rust: y -= 1;
}
}
    // rust: let b = self.b;
    // rust: let obsidian = b.default_of(b.named.obsidian);
    // rust: let spot = match full.or(partial) {
    // rust: Some((_, spot)) => spot,
    // rust: None => {
    // rust: let min_start = (min_y + 1).max(70);
    // rust: let max_start = max_placeable - 9;
    // rust: if max_start < min_start {
    // rust: return None;
}
    // rust: let [sx, _, sz] = direction.normal();
    // rust: let y = origin.y.clamp(min_start, max_start);
    // rust: let spot = border.clamp(
    // rust: f64::from(origin.x - sx),
    // rust: f64::from(y),
    // rust: f64::from(origin.z - sz),
    // rust: );
    // rust: let side = clockwise(direction);
    // rust: let air = b.default_of(b.named.air);
    // rust: for side_offset in -1..2 {
    // rust: for width in 0..2 {
    // rust: for height in -1..3 {
    // rust: let at = step(step(spot, direction, width), side, side_offset)
    // rust: .offset(0, height, 0);
    // rust: self.set_block(at, if height < 0 { obsidian } else { air }, 3);
}
}
}
    // rust: spot
}
}
    // rust: for width in -1..3 {
    // rust: for height in -1..4 {
    // rust: if width == -1 || width == 2 || height == -1 || height == 3 {
    // rust: self.set_block(
    // rust: step(spot, direction, width).offset(0, height, 0),
    // rust: obsidian,
    // rust: 3,
    // rust: );
}
}
}
    // rust: let base = b.default_of(b.named.nether_portal);
    // rust: let portal = b
    // rust: .table
    // rust: .with_text(base, b.props.axis, if x_axis { "x" } else { "z" })
    // rust: .unwrap_or(base);
    // rust: for width in 0..2 {
    // rust: for height in 0..3 {
    // rust: self.set_block(
    // rust: step(spot, direction, width).offset(0, height, 0),
    // rust: portal,
    // rust: 18,
    // rust: );
}
}
    // rust: Some(FoundRectangle {
    // rust: min_corner: spot,
    // rust: axis1_size: 2,
    // rust: axis2_size: 3,
    // rust: })
}
}

    // rust: impl Behaviours {
    /// `PortalForcer.createPortal` on `level` (see `Sim::create_portal`).
    // rust: pub fn create_portal<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: origin: BlockPos,
    // rust: x_axis: bool,
    // rust: border: &BorderBounds,
    // rust: logical_height: i32,
    // rust: ) -> Option<FoundRectangle> {
    // rust: self.sim(level, ticks)
    // rust: .create_portal(origin, x_axis, border, logical_height)
}
    /// The axis of a nether portal state: Some(true) for X, Some(false) for
    /// Z, None for other blocks.
pub fn portal_axis(self: *Self, state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_block(state, self.named.nether_portal)
    // rust: .then(|| self.table.text(state, self.props.axis) == "x")
}
}
