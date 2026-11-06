//! Transpiled from Horizon Rust crate
package horizon_core_traversal

import "core:fmt"
import "core:mem"
import "core:math"

// Ordered block visits for a finite ray, as in BlockGetter.traverseBlocks.
// use super::{Vec3, floor_i32};
// use crate::position::BlockPos;
// use std::fmt;

TraversalError :: enum {
    NonFinite,
    VisitLimit,
    InvalidBounds,
}
    // rust: impl fmt::Display for TraversalError {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: write!(f, "block traversal failed: {self:?}")
}
}
    // rust: impl std::error::Error for TraversalError {}

// Visit blocks in vanilla ray order until the visitor returns Some, or the
// segment is exhausted. `None` corresponds to vanilla's miss callback.
//
// Non-finite geometry and exceeding the caller's visit budget return typed
// errors. Previously invoked callbacks are not rolled back on a budget error.
    // rust: pub fn traverse_blocks<T>(
    // rust: start: Vec3,
    // rust: end: Vec3,
    // rust: max_visits: usize,
    // rust: mut visitor: impl FnMut(BlockPos) -> Option<T>,
    // rust: ) -> Result<Option<T>, TraversalError> {
    // rust: if !start.is_finite() || !end.is_finite() {
    // rust: return Err(TraversalError::NonFinite);
}
    // rust: if start == end {
    // rust: return Ok(None);
}
    // rust: let finish = end.lerp(start, -1e-7);
    // rust: let origin = start.lerp(end, -1e-7);
    // rust: let delta = origin.vector_to(finish).components();
    // rust: if !origin.is_finite() || !finish.is_finite() || delta.iter().any(|v| !v.is_finite()) {
    // rust: return Err(TraversalError::NonFinite);
}
    // rust: let mut position = origin.components().map(floor_i32);
    // rust: let sign = delta.map(|v| {
    // rust: if v == 0.0 {
    // rust: 0i32
    // rust: } else if v > 0.0 {
    // rust: 1
    // rust: } else {
    // rust: -1
}
    // rust: });
    // rust: let step = std::array::from_fn::<_, 3, _>(|i| {
    // rust: if sign[i] == 0 {
    // rust: f64::MAX
    // rust: } else {
    // rust: sign[i] as f64 / delta[i]
}
    // rust: });
    // rust: let mut boundary = std::array::from_fn::<_, 3, _>(|i| {
    // rust: let value = origin.components()[i];
    // rust: let fraction = value - (value.floor() as i64) as f64;
    // rust: step[i]
    // rust: * if sign[i] > 0 {
    // rust: 1.0 - fraction
    // rust: } else {
    // rust: fraction
}
    // rust: });
    // rust: let mut visited = 0;
    // rust: loop {
    // rust: if visited == max_visits {
    // rust: return Err(TraversalError::VisitLimit);
}
    // rust: visited += 1;
    // rust: if let Some(result) = visitor(BlockPos::new(position[0], position[1], position[2])) {
    // rust: return Ok(Some(result));
}
    // rust: if !(boundary[0] <= 1.0 || boundary[1] <= 1.0 || boundary[2] <= 1.0) {
    // rust: return Ok(None);
}
        // Strict comparisons give Z priority on a three-way corner tie.
    // rust: let axis = if boundary[0] < boundary[1] {
    // rust: if boundary[0] < boundary[2] { 0 } else { 2 }
    // rust: } else if boundary[1] < boundary[2] {
    // rust: 1
    // rust: } else {
    // rust: 2
}
    // rust: position[axis] = position[axis].wrapping_add(sign[axis]);
    // rust: boundary[axis] += step[axis];
}
}

    // rust: mod tests {
//     use super::*;
corner_order_and_early_exit :: proc() {
}
    // rust: let mut visited = Vec::new();
    // rust: assert_eq!(
    // rust: traverse_blocks::<()>(
    // rust: Vec3::new(0.5, 0.5, 0.5),
    // rust: Vec3::new(1.5, 1.5, 1.5),
    // rust: 10,
    // rust: |pos| {
    // rust: visited.push(pos);
    // rust: None
}
    // rust: ),
    // rust: Ok(None)
    // rust: );
    // rust: assert_eq!(
    // rust: visited,
    // rust: vec![
    // rust: BlockPos::new(0, 0, 0),
    // rust: BlockPos::new(0, 0, 1),
    // rust: BlockPos::new(0, 1, 1),
    // rust: BlockPos::new(1, 1, 1)
    // rust: ]
    // rust: );
    // rust: let result = traverse_blocks(
    // rust: Vec3::new(0.5, 0.5, 0.5),
    // rust: Vec3::new(1.5, 1.5, 1.5),
    // rust: 10,
    // rust: |pos| (pos.z == 1).then_some(pos),
    // rust: );
    // rust: assert_eq!(result, Ok(Some(BlockPos::new(0, 0, 1))));
}
miss_zero_identity_and_budget_errors :: proc() {
}
    // rust: let mut count = 0;
    // rust: assert_eq!(
    // rust: traverse_blocks::<()>(Vec3::ZERO, Vec3::ZERO, 0, |_| panic!(
    // rust: "no visits for equal endpoints"
    // rust: )),
    // rust: Ok(None)
    // rust: );
    // rust: assert_eq!(
    // rust: traverse_blocks::<()>(Vec3::new(-0.0, 0.0, 0.0), Vec3::ZERO, 10, |_| {
    // rust: count += 1;
    // rust: None
    // rust: }),
    // rust: Ok(None)
    // rust: );
    // rust: assert_eq!(count, 4);
    // rust: assert_eq!(
    // rust: traverse_blocks::<()>(Vec3::ZERO, Vec3::new(1.0, 1.0, 1.0), 1, |_| None),
    // rust: Err(TraversalError::VisitLimit)
    // rust: );
    // rust: assert_eq!(
    // rust: traverse_blocks::<()>(Vec3::ZERO, Vec3::new(f64::NAN, 1.0, 1.0), 1, |_| None),
    // rust: Err(TraversalError::NonFinite)
    // rust: );
}
}
