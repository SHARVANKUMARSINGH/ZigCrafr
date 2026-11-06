//! Transpiled from Horizon Rust crate
package horizon_core_shape

import "core:fmt"
import "core:mem"
import "core:math"

// use super::{
    // rust: Aabb, Axis, BlockHit, COLLISION_EPSILON, Direction, Vec3, clamp, floor_i32, java_max, java_min,
}
// use crate::position::BlockPos;
// use std::fmt;
// use std::sync::{Arc, OnceLock};
    // rust: mod create;
    // rust: mod face;
    // rust: mod join;
    // rust: pub use join::ShapeOp;

ShapeError :: enum {
    InvalidCoordinates,
    InvalidOccupancy,
    TooLarge,
    UnboundedBoolean,
    InvalidBounds,
}
    // rust: impl fmt::Display for ShapeError {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: write!(f, "invalid voxel shape: {self:?}")
}
}
    // rust: impl std::error::Error for ShapeError {}

// Immutable discrete occupancy with exact double coordinate boundaries.
//
// Greedy boxes are calculated once and reused for ray and proximity queries.
// Cube shapes retain vanilla's arithmetic cell lookup instead of replacing it
// with a binary search over coordinates (which differs at rounding boundaries).
VoxelShape :: struct {
    identity: ^ShapeIdentity,
    coords: Coords,
    sizes: [uint,
    occupancy: ^[u64],
    cube: bool,
    coordinate_cubes: [bool,
    boxes: ^[Aabb],
    bounds: Maybe(Aabb),
    discrete_min: [i32,
    discrete_max: [i32,
}

// The three axes' boundaries in one allocation: axis `i` is
// `values[starts[i]..starts[i + 1]]`. A moved shape (one per block an
// entity's movement meets) then allocates its coordinates once, not four
// times.
Coords :: struct {
    values: ^[f64],
    starts: [uint,
}
    // rust: impl Coords {
new :: proc(axes: [[dynamic]f64; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut starts = [0; 4];
    // rust: for i in 0..3 {
    // rust: starts[i + 1] = starts[i] + axes[i].len();
}
    // rust: let mut values = Vec::with_capacity(starts[3]);
    // rust: for axis in axes {
    // rust: values.extend(axis);
}
    // rust: Self {
    // rust: values: values.into(),
    // rust: starts,
}
}
to_vecs :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|i| self[i].to_vec())
}
    // Every boundary plus its axis's offset, the same addition as moving
    // each axis on its own.
moved :: proc(self: ^Self, offset: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let [_, y, z, _] = self.starts;
    // rust: let [dx, dy, dz] = offset.components();
    // rust: let values = self
    // rust: .values
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, value)| {
    // rust: *value
    // rust: + if i < y {
    // rust: dx
    // rust: } else if i < z {
    // rust: dy
    // rust: } else {
    // rust: dz
}
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: values,
    // rust: starts: self.starts,
}
}
}
    // rust: impl std::ops::Index<usize> for Coords {
    // rust: type Output = [f64];
index :: proc(self: ^Self, axis: uint) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.values[self.starts[axis]..self.starts[axis + 1]]
}
}

    // rust: type FaceCache = [OnceLock<Result<VoxelShape, ShapeError>>; 6];
ShapeIdentity :: struct {
    faces: OnceLock<^FaceCache>,
}

    // rust: impl VoxelShape {
from_grid :: proc(coords: [[dynamic]f64; 3], occupied: ^[bool]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::build(coords, occupied, false, [false; 3])
}
from_cube :: proc(sizes: [uint; 3], occupied: ^[bool]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if sizes.contains(&0) {
    // rust: return Err(ShapeError::InvalidCoordinates);
}
    // rust: let volume = volume(sizes)?;
    // rust: if occupied.len() != volume {
    // rust: return Err(ShapeError::InvalidOccupancy);
}
    // rust: let coords = sizes.map(|size| (0..=size).map(|i| i as f64 / size as f64).collect());
    // rust: Self::build(coords, occupied, true, [true; 3])
}
    // rust: fn build(
    // rust: coords: [Vec<f64>; 3],
    // rust: occupied: &[bool],
    // rust: cube: bool,
    // rust: coordinate_cubes: [bool; 3],
    // rust: ) -> Result<Self, ShapeError> {
    // rust: if coords.iter().any(|c| {
    // rust: c.is_empty()
    // rust: || c.len() > 1_048_577
    // rust: || c.iter().any(|v| v.is_nan())
    // rust: || c.windows(2).any(|p| p[0] >= p[1])
    // rust: }) {
    // rust: return Err(ShapeError::InvalidCoordinates);
}
    // rust: let sizes = std::array::from_fn(|i| coords[i].len() - 1);
    // rust: let count = volume(sizes)?;
    // rust: if count != occupied.len() {
    // rust: return Err(ShapeError::InvalidOccupancy);
}
    // rust: let mut occupancy = vec![0; count.div_ceil(64)];
    // rust: let mut discrete_min = sizes.map(|v| v as i32);
    // rust: let mut discrete_max = [0; 3];
    // rust: for (i, full) in occupied.iter().enumerate() {
    // rust: if *full {
    // rust: occupancy[i / 64] |= 1 << (i % 64);
    // rust: let position = [
    // rust: (i / (sizes[1] * sizes[2])) as i32,
    // rust: (i / sizes[2] % sizes[1]) as i32,
    // rust: (i % sizes[2]) as i32,
    // rust: ];
    // rust: for axis in 0..3 {
    // rust: discrete_min[axis] = discrete_min[axis].min(position[axis]);
    // rust: discrete_max[axis] = discrete_max[axis].max(position[axis] + 1);
}
}
}
    // rust: let mut shape = Self {
    // rust: identity: Arc::new(ShapeIdentity::default()),
    // rust: coords: Coords::new(coords),
    // rust: sizes,
    // rust: occupancy: occupancy.into(),
    // rust: cube,
    // rust: coordinate_cubes,
    // rust: boxes: Vec::new().into(),
    // rust: bounds: None,
    // rust: discrete_min,
    // rust: discrete_max,
}
    // rust: shape.boxes = shape.decompose().into();
    // rust: shape.bounds = shape.boxes.iter().copied().reduce(Aabb::union_bounds);
    // rust: Ok(shape)
}
empty :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::empty_ref().clone()
}
    // The shared empty shape, without cloning it.
empty_ref :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
EMPTY :: OnceLock::new()
    // rust: EMPTY.get_or_init(|| {
    // rust: Self::from_grid([vec![0.0], vec![0.0], vec![0.0]], &[]).expect("valid empty grid")
    // rust: })
}
    // `shape == Shapes.empty()`: the same as `same_identity(&empty())`
    // without cloning the shared empty shape.
is_empty_identity :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.same_identity(Self::empty_ref())
}
block :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::block_ref().clone()
}
block_ref :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
BLOCK :: OnceLock::new()
    // rust: BLOCK.get_or_init(|| Self::from_cube([1, 1, 1], &[true]).expect("valid unit cube"))
}
    // `shape == Shapes.block()`: the same as `same_identity(&block())`
    // without cloning the shared unit cube.
is_block :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.same_identity(Self::block_ref())
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.bounds.is_none()
}
bounds :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.bounds
}
boxes :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.boxes
}
coordinates :: proc(self: ^Self, axis: Axis) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.coords[axis as usize]
}
sizes :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.sizes
}
is_cube :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.cube
}
    // Clones and operations returning an existing immutable shape preserve its
    // identity. Separately constructed grids remain distinct even if equal.
same_identity :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Arc::ptr_eq(&self.identity, &other.identity)
}
    // A separately constructed shape with the same immutable grid. Storage is
    // shared, while identity-sensitive vanilla join shortcuts remain distinct.
fresh_identity :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut shape = self.clone();
    // rust: shape.identity = Arc::new(ShapeIdentity::default());
    // rust: shape
}
cube_coordinate_axes :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.coordinate_cubes
}
    // An array shape can contain CubePointRange axes after a partial cube
    // merge. Preserve that metadata for subsequent Boolean operations.
    // rust: pub fn from_mixed_grid(
    // rust: coords: [Vec<f64>; 3],
    // rust: occupied: &[bool],
    // rust: coordinate_cubes: [bool; 3],
    // rust: ) -> Result<Self, ShapeError> {
    // rust: for i in 0..3 {
    // rust: if coordinate_cubes[i] {
    // rust: let size = coords[i].len().saturating_sub(1);
    // rust: if size == 0
    // rust: || coords[i]
    // rust: .iter()
    // rust: .enumerate()
    // rust: .any(|(j, v)| v.to_bits() != (j as f64 / size as f64).to_bits())
    // rust: {
    // rust: return Err(ShapeError::InvalidCoordinates);
}
}
}
    // rust: Self::build(coords, occupied, false, coordinate_cubes)
}
min :: proc(self: ^Self, axis: Axis) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let i = axis as usize;
    // rust: let index = self.discrete_min[i];
    // rust: if index >= self.sizes[i] as i32 {
    // rust: f64::INFINITY
    // rust: } else {
    // rust: self.coords[i][index as usize]
}
}
max :: proc(self: ^Self, axis: Axis) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let i = axis as usize;
    // rust: let index = self.discrete_max[i];
    // rust: if index <= 0 {
    // rust: f64::NEG_INFINITY
    // rust: } else {
    // rust: self.coords[i][index as usize]
}
}
    // Discrete extrema are separate from occupancy: a quantized empty shape
    // can retain nonempty axis ranges, and empty joins retain Java sentinels.
discrete_bounds :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (self.discrete_min, self.discrete_max)
}
    // Import reference extrema. Nonempty shapes must match their occupancy;
    // empty shapes admit bounded ranges or the empty-join sentinel triple.
    // rust: pub fn with_discrete_bounds(
    // rust: mut self,
    // rust: min: [i32; 3],
    // rust: max: [i32; 3],
    // rust: ) -> Result<Self, ShapeError> {
    // rust: let in_range = (0..3).all(|i| {
    // rust: min[i] >= 0
    // rust: && min[i] <= self.sizes[i] as i32
    // rust: && max[i] >= 0
    // rust: && max[i] <= self.sizes[i] as i32
    // rust: });
    // rust: let join_sentinel = min == [i32::MAX; 3] && max == [i32::MIN + 1; 3];
    // rust: if (!in_range && !join_sentinel)
    // rust: || (!self.is_empty() && (min != self.discrete_min || max != self.discrete_max))
    // rust: {
    // rust: return Err(ShapeError::InvalidBounds);
}
    // rust: if min != self.discrete_min || max != self.discrete_max {
    // rust: self.identity = Arc::new(ShapeIdentity::default());
}
    // rust: self.discrete_min = min;
    // rust: self.discrete_max = max;
    // rust: Ok(self)
}
    // Minimum occupied coordinate along an axis at the two cyclic
    // perpendicular coordinates; an empty/outside column yields +infinity.
min_at :: proc(self: ^Self, axis: Axis, first: f64, second: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut position = self.column_position(axis, first, second);
    // rust: for i in 0..self.sizes[axis as usize] {
    // rust: position[axis as usize] = i as i32;
    // rust: if self.is_full(position[0], position[1], position[2]) {
    // rust: return self.coords[axis as usize][i];
}
}
    // rust: f64::INFINITY
}
    // Maximum occupied coordinate at the same cyclic column; an empty/outside
    // column yields -infinity. The maximum is the cell's upper face.
max_at :: proc(self: ^Self, axis: Axis, first: f64, second: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut position = self.column_position(axis, first, second);
    // rust: for i in (0..self.sizes[axis as usize]).rev() {
    // rust: position[axis as usize] = i as i32;
    // rust: if self.is_full(position[0], position[1], position[2]) {
    // rust: return self.coords[axis as usize][i + 1];
}
}
    // rust: f64::NEG_INFINITY
}
column_position :: proc(self: ^Self, axis: Axis, first: f64, second: f64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let a = (axis as usize + 1) % 3;
    // rust: let b = (axis as usize + 2) % 3;
    // rust: let mut position = [0; 3];
    // rust: position[a] = self.find_index(Axis::ALL[a], first);
    // rust: position[b] = self.find_index(Axis::ALL[b], second);
    // rust: position
}
    // Vanilla movement converts cube coordinates to an array shape, even for
    // a zero offset. Keep this distinction for subsequent cell lookups.
moved :: proc(self: ^Self, offset: Vec3) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: return Self::empty();
}
    // rust: let mut result = self.clone();
    // rust: result.identity = Arc::new(ShapeIdentity::default());
    // rust: result.cube = false;
    // rust: result.coordinate_cubes = [false; 3];
    // rust: result.coords = self.coords.moved(offset);
        // The same occupancy decomposes into the same boxes, over coordinates
        // moved by the same additions.
    // rust: result.boxes = self.boxes.iter().map(|b| b.move_by(offset)).collect();
    // rust: result.bounds = self.bounds.map(|bounds| bounds.move_by(offset));
    // rust: result
}
is_full :: proc(self: ^Self, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if x < 0
    // rust: || y < 0
    // rust: || z < 0
    // rust: || x as usize >= self.sizes[0]
    // rust: || y as usize >= self.sizes[1]
    // rust: || z as usize >= self.sizes[2]
    // rust: {
    // rust: return false;
}
    // rust: full(
    // rust: &self.occupancy,
    // rust: index(self.sizes, x as usize, y as usize, z as usize),
    // rust: )
}
find_index :: proc(self: ^Self, axis: Axis, value: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let i = axis as usize;
    // rust: if self.cube {
    // rust: return floor_i32(clamp(
    // rust: value * self.sizes[i] as f64,
    // rust: -1.0,
    // rust: self.sizes[i] as f64,
    // rust: ));
}
        // Upper-bound search, including the final outside cell index.
    // rust: let coords = &self.coords[i];
    // rust: let mut start = 0;
    // rust: let mut end = coords.len();
    // rust: while start < end {
    // rust: let middle = (start + end) / 2;
    // rust: if value < coords[middle] {
    // rust: end = middle;
    // rust: } else {
    // rust: start = middle + 1;
}
}
    // rust: start as i32 - 1
}
collide :: proc(self: ^Self, axis: Axis, aabb: Aabb, amount: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: return amount;
}
    // rust: if amount.abs() < COLLISION_EPSILON {
    // rust: return 0.0;
}
    // rust: let i = axis as usize;
    // rust: let p = Axis::ALL[(i + 1) % 3];
    // rust: let q = Axis::ALL[(i + 2) % 3];
    // rust: let p_start = self.find_index(p, aabb.min(p) + COLLISION_EPSILON).max(0);
    // rust: let p_end = (self.find_index(p, aabb.max(p) - COLLISION_EPSILON) + 1)
    // rust: .min(self.sizes[p as usize] as i32);
    // rust: let q_start = self.find_index(q, aabb.min(q) + COLLISION_EPSILON).max(0);
    // rust: let q_end = (self.find_index(q, aabb.max(q) - COLLISION_EPSILON) + 1)
    // rust: .min(self.sizes[q as usize] as i32);
    // rust: let occupied_layer = |layer| {
    // rust: (p_start..p_end).any(|u| {
    // rust: (q_start..q_end).any(|v| {
    // rust: let mut cell = [0; 3];
    // rust: cell[i] = layer;
    // rust: cell[p as usize] = u;
    // rust: cell[q as usize] = v;
    // rust: self.is_full(cell[0], cell[1], cell[2])
    // rust: })
    // rust: })
}
    // rust: if amount > 0.0 {
    // rust: let start = self.find_index(axis, aabb.max(axis) - COLLISION_EPSILON) + 1;
    // rust: for layer in start..self.sizes[i] as i32 {
    // rust: if occupied_layer(layer) {
    // rust: let distance = self.coords[i][layer as usize] - aabb.max(axis);
    // rust: return if distance >= -COLLISION_EPSILON {
    // rust: java_min(amount, distance)
    // rust: } else {
    // rust: amount
}
}
}
    // rust: } else if amount < 0.0 {
    // rust: let start = self.find_index(axis, aabb.min(axis) + COLLISION_EPSILON);
    // rust: for layer in (0..start).rev() {
    // rust: if occupied_layer(layer) {
    // rust: let distance = self.coords[i][layer as usize + 1] - aabb.min(axis);
    // rust: return if distance <= COLLISION_EPSILON {
    // rust: java_max(amount, distance)
    // rust: } else {
    // rust: amount
}
}
}
}
    // rust: amount
}
    // rust: pub fn collide_all<'a>(
    // rust: axis: Axis,
    // rust: aabb: Aabb,
    // rust: shapes: impl IntoIterator<Item = &'a Self>,
    // rust: mut amount: f64,
    // rust: ) -> f64 {
    // rust: for shape in shapes {
    // rust: if amount.abs() < COLLISION_EPSILON {
    // rust: return 0.0;
}
    // rust: amount = shape.collide(axis, aabb, amount);
}
    // rust: amount
}
clip :: proc(self: ^Self, start: Vec3, end: Vec3, block: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: return None;
}
    // rust: let delta = end.subtract(start);
    // rust: if delta.length_squared() < COLLISION_EPSILON {
    // rust: return None;
}
    // rust: let nudged = start.add_vector(delta.scale(0.001));
    // rust: let x = self.find_index(Axis::X, nudged.x - block.x as f64);
    // rust: let y = self.find_index(Axis::Y, nudged.y - block.y as f64);
    // rust: let z = self.find_index(Axis::Z, nudged.z - block.z as f64);
    // rust: if self.is_full(x, y, z) {
    // rust: Some(BlockHit {
    // rust: location: nudged,
    // rust: direction: Direction::approximate_nearest(delta).opposite(),
    // rust: block,
    // rust: inside: true,
    // rust: })
    // rust: } else {
    // rust: Aabb::clip_boxes(self.boxes.iter().copied(), start, end, block)
}
}
closest_point :: proc(self: ^Self, point: Vec3) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut best = None;
    // rust: for aabb in self.boxes.iter() {
    // rust: let candidate = Vec3::new(
    // rust: clamp(point.x, aabb.min(Axis::X), aabb.max(Axis::X)),
    // rust: clamp(point.y, aabb.min(Axis::Y), aabb.max(Axis::Y)),
    // rust: clamp(point.z, aabb.min(Axis::Z), aabb.max(Axis::Z)),
    // rust: );
    // rust: if best
    // rust: .is_none_or(|old| point.distance_squared(candidate) < point.distance_squared(old))
    // rust: {
    // rust: best = Some(candidate);
}
}
    // rust: best
}
decompose :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut remaining = self.occupancy.to_vec();
    // rust: let mut boxes = Vec::new();
    // rust: let [nx, ny, nz] = self.sizes;
    // rust: for y in 0..ny {
    // rust: for x in 0..nx {
    // rust: let mut run = None;
    // rust: for z in 0..=nz {
    // rust: if z < nz && full(&remaining, index(self.sizes, x, y, z)) {
    // rust: if run.is_none() {
    // rust: run = Some(z);
}
    // rust: continue;
}
    // rust: let Some(z_start) = run.take() else { continue };
    // rust: clear_strip(&mut remaining, self.sizes, x, y, z_start, z);
    // rust: let mut x_end = x + 1;
    // rust: while x_end < nx && strip_full(&remaining, self.sizes, x_end, y, z_start, z) {
    // rust: clear_strip(&mut remaining, self.sizes, x_end, y, z_start, z);
    // rust: x_end += 1;
}
    // rust: let mut y_end = y + 1;
    // rust: while y_end < ny
    // rust: && (x..x_end)
    // rust: .all(|u| strip_full(&remaining, self.sizes, u, y_end, z_start, z))
    // rust: {
    // rust: for u in x..x_end {
    // rust: clear_strip(&mut remaining, self.sizes, u, y_end, z_start, z);
}
    // rust: y_end += 1;
}
    // rust: boxes.push(Aabb::new(
    // rust: Vec3::new(
    // rust: self.coords[0][x],
    // rust: self.coords[1][y],
    // rust: self.coords[2][z_start],
    // rust: ),
    // rust: Vec3::new(
    // rust: self.coords[0][x_end],
    // rust: self.coords[1][y_end],
    // rust: self.coords[2][z],
    // rust: ),
    // rust: ));
}
}
}
    // rust: boxes
}
}

volume :: proc(sizes: [uint; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let count = sizes
    // rust: .into_iter()
    // rust: .try_fold(1usize, usize::checked_mul)
    // rust: .ok_or(ShapeError::TooLarge)?;
    // rust: if count > 1_048_576 {
    // rust: Err(ShapeError::TooLarge)
    // rust: } else {
    // rust: Ok(count)
}
}
index :: proc(sizes: [uint; 3], x: uint, y: uint, z: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (x * sizes[1] + y) * sizes[2] + z
}
full :: proc(bits: ^[u64], i: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: bits[i / 64] & (1 << (i % 64)) != 0
}
strip_full :: proc(bits: ^[u64], sizes: [uint; 3], x: uint, y: uint, min: uint, max: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (min..max).all(|z| full(bits, index(sizes, x, y, z)))
}
clear_strip :: proc(bits: ^[u64], sizes: [uint; 3], x: uint, y: uint, min: uint, max: uint) {
}
    // rust: for z in min..max {
    // rust: let i = index(sizes, x, y, z);
    // rust: bits[i / 64] &= !(1 << (i % 64));
}
}

    // rust: mod tests {
//     use super::*;
stop_at_obstacle_and_reuse_boxes :: proc() {
}
    // rust: let shape = VoxelShape::block();
    // rust: let player = Aabb::new(Vec3::new(-0.6, 0.0, 0.2), Vec3::new(-0.2, 1.8, 0.8));
    // rust: assert_eq!(shape.collide(Axis::X, player, 1.0), 0.2);
    // rust: assert_eq!(shape.collide(Axis::Z, player, 1.0), 1.0);
    // rust: assert_eq!(shape.boxes().len(), 1);
    // rust: assert!(
    // rust: shape
    // rust: .clip(
    // rust: Vec3::new(0.5, 0.5, 0.5),
    // rust: Vec3::new(2.0, 0.5, 0.5),
    // rust: BlockPos::default()
    // rust: )
    // rust: .unwrap()
    // rust: .inside
    // rust: );
    // rust: assert_eq!(
    // rust: VoxelShape::empty().collide(Axis::X, player, -0.0).to_bits(),
    // rust: (-0.0f64).to_bits()
    // rust: );
}
sparse_stair_decomposition :: proc() {
}
    // rust: let shape = VoxelShape::from_cube(
    // rust: [2, 2, 2],
    // rust: &[true, true, false, false, true, true, true, true],
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(shape.boxes().len(), 2);
    // rust: assert_eq!(
    // rust: shape.closest_point(Vec3::new(0.1, 0.9, 0.5)),
    // rust: Some(Vec3::new(0.1, 0.5, 0.5))
    // rust: );
    // rust: assert!(VoxelShape::from_grid(std::array::from_fn(|_| vec![0.0, 1.0]), &[]).is_err());
}
moved_boxes_are_the_moved_shapes_decomposition :: proc() {
}
    // rust: let stair = VoxelShape::from_cube(
    // rust: [2, 2, 2],
    // rust: &[true, true, false, false, true, true, true, true],
    // rust: )
    // rust: .unwrap();
    // rust: let slab = VoxelShape::from_grid([vec![0.0, 1.0], vec![0.0, 0.5], vec![0.0, 1.0]], &[true])
    // rust: .unwrap();
    // rust: let offsets = [
    // rust: Vec3::new(3.0, -64.0, -7.0),
    // rust: Vec3::new(-0.0, 0.0, -0.0),
    // rust: Vec3::new(1.0e-9, 319.999, -30_000_000.0),
    // rust: Vec3::new(f64::from(i32::MAX), f64::from(i32::MIN), 0.1),
    // rust: ];
    // rust: for shape in [VoxelShape::block(), stair, slab] {
    // rust: for offset in offsets {
    // rust: let moved = shape.moved(offset);
    // rust: let [nx, ny, nz] = shape.sizes();
    // rust: let occupied: Vec<bool> = (0..nx * ny * nz)
    // rust: .map(|i| {
    // rust: shape.is_full(
    // rust: (i / (ny * nz)) as i32,
    // rust: (i / nz % ny) as i32,
    // rust: (i % nz) as i32,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let rebuilt = VoxelShape::from_grid(
    // rust: Axis::ALL.map(|axis| moved.coordinates(axis).to_vec()),
    // rust: &occupied,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(moved.boxes(), rebuilt.boxes());
    // rust: assert_eq!(moved.bounds(), rebuilt.bounds());
}
}
    // rust: assert!(VoxelShape::block().is_block());
    // rust: assert!(!VoxelShape::block().moved(Vec3::ZERO).is_block());
    // rust: assert!(!VoxelShape::block().fresh_identity().is_block());
}
each_moved_axis_takes_only_its_own_offset :: proc() {
}
        // Three axes of different lengths, so a boundary given another
        // axis's offset would show.
    // rust: let coords = [
    // rust: vec![0.0, 0.25, 1.0],
    // rust: vec![0.0, 0.5],
    // rust: vec![0.0, 0.125, 0.75, 1.0],
    // rust: ];
    // rust: let shape = VoxelShape::from_grid(coords.clone(), &[true; 6]).unwrap();
    // rust: let offset = Vec3::new(3.0, -64.0, 0.1);
    // rust: let moved = shape.moved(offset);
    // rust: for (axis, (values, by)) in Axis::ALL
    // rust: .into_iter()
    // rust: .zip(coords.iter().zip([3.0, -64.0, 0.1]))
    // rust: {
    // rust: let expected: Vec<u64> = values.iter().map(|v| (v + by).to_bits()).collect();
    // rust: let got: Vec<u64> = moved
    // rust: .coordinates(axis)
    // rust: .iter()
    // rust: .map(|v| v.to_bits())
    // rust: .collect();
    // rust: assert_eq!(got, expected, "{axis:?}");
    // rust: assert_eq!(
    // rust: shape.coordinates(axis),
    // rust: &values[..],
    // rust: "{axis:?} of the original"
    // rust: );
}
}
}
