//! Transpiled from Horizon Rust crate
//! Module: horizon-core_create
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::{ShapeError, ShapeOp, VoxelShape};
// use crate::geometry::{Aabb, Axis, COLLISION_EPSILON};

    // rust: impl VoxelShape {
    /// Shapes.create(AABB): thin-box rejection and up to 1/8 cube quantization.
pub fn from_box(aabb: Aabb) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if aabb.has_nan() {
    // rust: return Err(ShapeError::InvalidCoordinates);
}
    // rust: if Axis::ALL
    // rust: .into_iter()
    // rust: .any(|axis| aabb.max(axis) - aabb.min(axis) < COLLISION_EPSILON)
    // rust: {
    // rust: return Ok(Self::empty());
}
    // rust: let bits = Axis::ALL.map(|axis| find_bits(aabb.min(axis), aabb.max(axis)));
    // rust: if bits.iter().any(Option::is_none) {
    // rust: return Self::from_grid(
    // rust: Axis::ALL.map(|axis| vec![aabb.min(axis), aabb.max(axis)]),
    // rust: &[true],
    // rust: );
}
    // rust: let bits = bits.map(Option::unwrap);
    // rust: if bits == [0, 0, 0] {
    // rust: return Ok(Self::block());
}
    // rust: let sizes = bits.map(|bits| 1usize << bits);
    // rust: let lo = std::array::from_fn::<_, 3, _>(|i| {
    // rust: round_small(aabb.min(Axis::ALL[i]) * sizes[i] as f64) as usize
    // rust: });
    // rust: let hi = std::array::from_fn::<_, 3, _>(|i| {
    // rust: round_small(aabb.max(Axis::ALL[i]) * sizes[i] as f64) as usize
    // rust: });
    // rust: let mut occupied = Vec::with_capacity(sizes[0] * sizes[1] * sizes[2]);
    // rust: for x in 0..sizes[0] {
    // rust: for y in 0..sizes[1] {
    // rust: for z in 0..sizes[2] {
    // rust: occupied.push(
    // rust: x >= lo[0]
    // rust: && x < hi[0]
    // rust: && y >= lo[1]
    // rust: && y < hi[1]
    // rust: && z >= lo[2]
    // rust: && z < hi[2],
    // rust: );
}
}
}
    // rust: Self::from_cube(sizes, &occupied)?
    // rust: .with_discrete_bounds(lo.map(|v| v as i32), hi.map(|v| v as i32))
}
    /// VoxelShape.optimize, reconstructing greedy boxes in vanilla order.
pub fn optimized(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut result = Self::empty();
    // rust: for aabb in self.boxes.iter() {
    // rust: let part = Self::from_box(*aabb)?;
    // rust: result = result.join_unoptimized(&part, ShapeOp::OR)?;
}
    // rust: Ok(result)
}
pub fn join(self: *Self, other: *Self, operation: ShapeOp) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.join_unoptimized(other, operation)?.optimized()
}
}
pub fn find_bits(min: f64, max: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min < -COLLISION_EPSILON || max > 1.0000001 {
    // rust: return None;
}
    // rust: for bits in 0..=3 {
    // rust: let size = (1usize << bits) as f64;
    // rust: let lo = min * size;
    // rust: let hi = max * size;
    // rust: if (lo - round_small(lo) as f64).abs() < COLLISION_EPSILON * size
    // rust: && (hi - round_small(hi) as f64).abs() < COLLISION_EPSILON * size
    // rust: {
    // rust: return Some(bits);
}
}
    // rust: None
}
// Values reach this helper only in the small range admitted by find_bits.
// Avoid floor(value + 0.5): addition can round a value just below a tie upward.
pub fn round_small(value: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lower = value.floor();
    // rust: (if value - lower >= 0.5 {
    // rust: lower + 1.0
    // rust: } else {
    // rust: lower
    // rust: }) as i64
}

    // rust: mod tests {
//     use super::*;
//     use crate::geometry::Vec3;
pub fn quantization_thin_boxes_and_shared_block_identity() void {
}
    // rust: let full = VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, 1.0, 1.0))).unwrap();
    // rust: assert!(full.same_identity(&VoxelShape::block()));
    // rust: let slab = VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, 0.5, 1.0))).unwrap();
    // rust: assert!(slab.is_cube());
    // rust: assert_eq!(slab.sizes(), [1, 2, 1]);
    // rust: assert_eq!(slab.max(Axis::Y), 0.5);
    // rust: let thin = VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1e-8, 1.0, 1.0))).unwrap();
    // rust: assert!(thin.same_identity(&VoxelShape::empty()));
    // rust: assert_eq!(round_small(f64::from_bits(0.5f64.to_bits() - 1)), 0);
}
pub fn optimization_restores_composite_shapes() void {
}
    // rust: let a = VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, 0.5, 1.0))).unwrap();
    // rust: let b = VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(0.5, 0.5, 0.0),
    // rust: Vec3::new(1.0, 1.0, 1.0),
    // rust: ))
    // rust: .unwrap();
    // rust: let combined = a.join(&b, ShapeOp::OR).unwrap();
    // rust: assert_eq!(combined.boxes().len(), 2);
    // rust: assert_eq!(combined.max(Axis::Y), 1.0);
    // rust: assert!(
    // rust: !combined
    // rust: .join_is_not_empty(&a.join_unoptimized(&b, ShapeOp::OR).unwrap(), ShapeOp::XOR)
    // rust: .unwrap()
    // rust: );
}
pub fn quantized_empty_boxes_keep_independent_axis_extrema() void {
}
    // rust: let shape = VoxelShape::from_box(Aabb::new(
    // rust: crate::geometry::Vec3::new(1e-8, 0.875, -1e-8),
    // rust: crate::geometry::Vec3::new(0.12500001, 1.0, 9e-8),
    // rust: ))
    // rust: .unwrap();
    // rust: assert!(shape.is_empty());
    // rust: assert_eq!(shape.min(Axis::Y), 0.875);
    // rust: assert_eq!(shape.max(Axis::Y), 1.0);
    // rust: assert_eq!(shape.max(Axis::Z), f64::NEG_INFINITY);
    // rust: assert_eq!(
    // rust: crate::geometry::block_floor_height(&VoxelShape::empty(), || &shape),
    // rust: 0.0
    // rust: );
    // rust: assert!(
    // rust: shape
    // rust: .optimized()
    // rust: .unwrap()
    // rust: .same_identity(&VoxelShape::empty())
    // rust: );
}
}
