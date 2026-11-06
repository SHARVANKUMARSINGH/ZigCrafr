//! Transpiled from Horizon Rust crate
//! Module: horizon-core_iter
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Inclusive block boxes in vanilla's fixed and movement-dependent visit orders.
// use super::BlockPos;
// use crate::geometry::{Aabb, Axis, Vec3, floor_i32};

pub const BlockIterationTooLarge = struct {};
    // rust: impl std::fmt::Display for BlockIterationTooLarge {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("block box exceeds the positive Java-int iteration domain")
}
}
    // rust: impl std::error::Error for BlockIterationTooLarge {}

/// Value iterator; each position is independent of later cursor updates.
///
/// Bounds are inclusive, including an AABB's floored maximum face. Boxes whose
/// true volume exceeds i32::MAX are rejected instead of reproducing Java's
/// overflowed counts. A caller can lazily limit a supported box with `take`.
pub const BlockBoxIter = struct {
    start: [i32,
    steps: [i32,
    sizes: [usize,
    // Innermost axis first.
    axes: [Axis,
    index: usize,
    count: usize,
};
    // rust: impl BlockBoxIter {
    // rust: fn new(
    // rust: a: BlockPos,
    // rust: b: BlockPos,
    // rust: direction: Option<Vec3>,
    // rust: ) -> Result<Self, BlockIterationTooLarge> {
    // rust: let a = [a.x, a.y, a.z];
    // rust: let b = [b.x, b.y, b.z];
    // rust: let min = std::array::from_fn::<_, 3, _>(|i| a[i].min(b[i]));
    // rust: let max = std::array::from_fn::<_, 3, _>(|i| a[i].max(b[i]));
    // rust: let sizes = std::array::from_fn::<_, 3, _>(|i| (max[i] as i64 - min[i] as i64 + 1) as u64);
    // rust: let count = sizes
    // rust: .into_iter()
    // rust: .try_fold(1u64, |total, size| {
    // rust: total.checked_mul(size).filter(|v| *v <= i32::MAX as u64)
    // rust: })
    // rust: .ok_or(BlockIterationTooLarge)?;
    // rust: let mut start = min;
    // rust: let mut steps = [1; 3];
    // rust: let axes = if let Some(direction) = direction {
    // rust: for axis in Axis::ALL {
    // rust: let i = axis as usize;
                // NaN takes the negative direction in Java's dcmpl branch.
    // rust: let forward = direction.component(axis) >= 0.0;
    // rust: if !forward {
    // rust: start[i] = max[i];
    // rust: steps[i] = -1;
}
}
    // rust: let [first, second, third] = Axis::step_order(direction);
    // rust: [third, second, first]
    // rust: } else {
    // rust: [Axis::X, Axis::Y, Axis::Z]
}
    // rust: Ok(Self {
    // rust: start,
    // rust: steps,
    // rust: sizes: sizes.map(|v| v as usize),
    // rust: axes,
    // rust: index: 0,
    // rust: count: count as usize,
    // rust: })
}
}
    // rust: impl Iterator for BlockBoxIter {
    // rust: type Item = BlockPos;
pub fn next(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.index == self.count {
    // rust: return None;
}
    // rust: let mut index = self.index;
    // rust: let mut point = self.start;
    // rust: for axis in self.axes {
    // rust: let i = axis as usize;
    // rust: let offset = index % self.sizes[i];
    // rust: index /= self.sizes[i];
    // rust: point[i] = point[i].wrapping_add(self.steps[i].wrapping_mul(offset as i32));
}
    // rust: self.index += 1;
    // rust: Some(BlockPos::new(point[0], point[1], point[2]))
}
pub fn size_hint(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let remaining = self.count - self.index;
    // rust: (remaining, Some(remaining))
}
}
    // rust: impl ExactSizeIterator for BlockBoxIter {}
    // rust: impl std::iter::FusedIterator for BlockBoxIter {}

    // rust: impl BlockPos {
pub fn containing(point: Vec3) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(floor_i32(point.x), floor_i32(point.y), floor_i32(point.z))
}
pub fn between_closed(a: Self, b: Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockBoxIter::new(a, b, None)
}
pub fn between_closed_box(b: Aabb) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::between_closed(
    // rust: Self::containing(b.min_position()),
    // rust: Self::containing(b.max_position()),
    // rust: )
}
    // rust: pub fn between_corners_in_direction(
    // rust: a: Self,
    // rust: b: Self,
    // rust: direction: Vec3,
    // rust: ) -> Result<BlockBoxIter, BlockIterationTooLarge> {
    // rust: BlockBoxIter::new(a, b, Some(direction))
}
    // rust: pub fn between_box_corners_in_direction(
    // rust: b: Aabb,
    // rust: direction: Vec3,
    // rust: ) -> Result<BlockBoxIter, BlockIterationTooLarge> {
    // rust: Self::between_corners_in_direction(
    // rust: Self::containing(b.min_position()),
    // rust: Self::containing(b.max_position()),
    // rust: direction,
    // rust: )
}
}

    // rust: mod tests {
//     use super::*;
pub fn ordering_inclusive_faces_and_value_independence() void {
}
    // rust: let a = BlockPos::new(-1, 0, 0);
    // rust: let b = BlockPos::new(0, 1, 0);
    // rust: assert_eq!(
    // rust: BlockPos::between_closed(b, a).unwrap().collect::<Vec<_>>(),
    // rust: vec![a, BlockPos::new(0, 0, 0), BlockPos::new(-1, 1, 0), b]
    // rust: );
    // rust: assert_eq!(
    // rust: BlockPos::between_corners_in_direction(a, b, Vec3::new(-1.0, 0.0, 0.0))
    // rust: .unwrap()
    // rust: .collect::<Vec<_>>(),
    // rust: vec![BlockPos::new(0, 0, 0), a, b, BlockPos::new(-1, 1, 0)]
    // rust: );
    // rust: assert_eq!(
    // rust: BlockPos::between_closed_box(Aabb::unit_cube(Vec3::ZERO))
    // rust: .unwrap()
    // rust: .len(),
    // rust: 8
    // rust: );
    // rust: assert_eq!(
    // rust: BlockPos::between_closed(BlockPos::new(i32::MIN, 0, 0), BlockPos::new(i32::MAX, 0, 0))
    // rust: .unwrap_err(),
    // rust: BlockIterationTooLarge
    // rust: );
}
}
