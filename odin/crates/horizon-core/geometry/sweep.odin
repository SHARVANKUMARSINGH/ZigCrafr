//! Transpiled from Horizon Rust crate
package horizon_core_sweep

import "core:fmt"
import "core:mem"
import "core:math"

// BlockGetter.forEachBlockIntersectedBetween's ordered movement-path visits.
// use super::{Aabb, TraversalError, Vec3, clamp, floor_i32};
// use crate::{fast_hash::FxHashSet, position::BlockPos};

Sweep :: struct {
    visitor: ^'v mut V,
    visited: FxHashSet<i64>,
    work: uint,
    limit: uint,
}
    // rust: impl<V: FnMut(BlockPos, i32) -> bool> Sweep<'_, V> {
spend :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.work == self.limit {
    // rust: return Err(TraversalError::VisitLimit);
}
    // rust: self.work += 1;
    // rust: Ok(())
}
    // rust: fn visit(
    // rust: &mut self,
    // rust: positions: impl Iterator<Item = BlockPos>,
    // rust: step: i32,
    // rust: deduplicate: bool,
    // rust: ) -> Result<bool, TraversalError> {
    // rust: for pos in positions {
    // rust: self.spend()?;
    // rust: if deduplicate && !self.visited.insert(pos.pack()) {
    // rust: continue;
}
    // rust: if !(self.visitor)(pos, step) {
    // rust: return Ok(false);
}
    // rust: if !deduplicate {
    // rust: self.visited.insert(pos.pack());
}
}
    // rust: Ok(true)
}
}

// Visit blocks and step indices for a moving box, stopping if the callback
// returns false. `final_box` is the box at `end`, not at `start`.
//
// Only finite inputs/computed geometry and positive Java-int-sized block boxes
// are supported. `max_work` limits iterator candidates and ray steps, including
// suppressed duplicate visits. Prior callbacks remain applied on an error.
// Block/entity effects and their state transitions are separate from visitation.
    // rust: pub fn sweep_intersected_blocks(
    // rust: start: Vec3,
    // rust: end: Vec3,
    // rust: final_box: Aabb,
    // rust: max_work: usize,
    // rust: mut visitor: impl FnMut(BlockPos, i32) -> bool,
    // rust: ) -> Result<bool, TraversalError> {
    // rust: if !start.is_finite()
    // rust: || !end.is_finite()
    // rust: || !final_box.min_position().is_finite()
    // rust: || !final_box.max_position().is_finite()
    // rust: {
    // rust: return Err(TraversalError::NonFinite);
}
    // rust: let movement = end.subtract(start);
    // rust: if !movement.is_finite() {
    // rust: return Err(TraversalError::NonFinite);
}
    // rust: if movement.length_squared() < (1.0e-5_f32 * 1.0e-5_f32) as f64 {
    // rust: let blocks =
    // rust: BlockPos::between_closed_box(final_box).map_err(|_| TraversalError::InvalidBounds)?;
        // This branch has no deduplication in vanilla. Avoid allocating a set
        // or copying visited positions for stationary/tiny movements.
    // rust: for (work, pos) in blocks.enumerate() {
    // rust: if work == max_work {
    // rust: return Err(TraversalError::VisitLimit);
}
    // rust: if !visitor(pos, 0) {
    // rust: return Ok(false);
}
}
    // rust: return Ok(true);
}
    // rust: let mut sweep = Sweep {
    // rust: visitor: &mut visitor,
        // Only asked whether it holds a position: the fast hash, sized for a
        // short move's boxes.
    // rust: visited: FxHashSet::with_capacity_and_hasher(32, Default::default()),
    // rust: work: 0,
    // rust: limit: max_work,
}
    // rust: let initial_box = final_box.move_by(movement.scale(-1.0));
    // rust: if !initial_box.min_position().is_finite() || !initial_box.max_position().is_finite() {
    // rust: return Err(TraversalError::NonFinite);
}
    // rust: let initial = BlockPos::between_box_corners_in_direction(initial_box, movement)
    // rust: .map_err(|_| TraversalError::InvalidBounds)?;
    // rust: if !sweep.visit(initial, 0, false)? {
    // rust: return Ok(false);
}
    // rust: let size = final_box.size().components();
    // rust: let corner = furthest_corner(movement);
    // rust: let center = final_box.center().components();
    // rust: let finish = Vec3::new(
    // rust: center[0] + size[0] * 0.5 * corner[0] as f64,
    // rust: center[1] + size[1] * 0.5 * corner[1] as f64,
    // rust: center[2] + size[2] * 0.5 * corner[2] as f64,
    // rust: );
    // rust: let origin = finish.subtract(movement);
    // rust: if !origin.is_finite() || !finish.is_finite() || size.iter().any(|v| !v.is_finite()) {
    // rust: return Err(TraversalError::NonFinite);
}
    // rust: let mut position = origin.components().map(floor_i32);
    // rust: let delta = movement.components();
    // rust: let sign = delta.map(|v| {
    // rust: if v == 0.0 {
    // rust: 0i32
    // rust: } else if v > 0.0 {
    // rust: 1
    // rust: } else {
    // rust: -1
}
    // rust: });
    // rust: let increment = std::array::from_fn::<_, 3, _>(|i| {
    // rust: if sign[i] == 0 {
    // rust: f64::MAX
    // rust: } else {
    // rust: sign[i] as f64 / delta[i]
}
    // rust: });
    // rust: let mut boundary = std::array::from_fn::<_, 3, _>(|i| {
    // rust: let value = origin.components()[i];
    // rust: let fraction = value - (value.floor() as i64) as f64;
    // rust: increment[i]
    // rust: * if sign[i] > 0 {
    // rust: 1.0 - fraction
    // rust: } else {
    // rust: fraction
}
    // rust: });
    // rust: let mut step = 0i32;
    // rust: while boundary.iter().any(|v| *v <= 1.0) {
    // rust: sweep.spend()?;
    // rust: let axis = if boundary[0] < boundary[1] {
    // rust: if boundary[0] < boundary[2] { 0 } else { 2 }
    // rust: } else if boundary[1] < boundary[2] {
    // rust: 1
    // rust: } else {
    // rust: 2
}
    // rust: position[axis] = position[axis].wrapping_add(sign[axis]);
    // rust: boundary[axis] += increment[axis];
    // rust: let pos = BlockPos::new(position[0], position[1], position[2]);
        // The static Java clip takes raw endpoints, including wrapped +1 ints.
    // rust: let block_box = Aabb {
    // rust: min: Vec3::from_block(pos),
    // rust: max: Vec3::from_block(pos.offset(1, 1, 1)),
}
    // rust: let Some(point) = block_box.clip(origin, finish) else {
    // rust: continue;
}
    // rust: step = step.wrapping_add(1);
    // rust: let clamped = std::array::from_fn::<_, 3, _>(|i| {
    // rust: clamp(
    // rust: point.components()[i],
    // rust: position[i] as f64 + 1.0e-5_f32 as f64,
    // rust: (position[i] as f64 + 1.0) - 1.0e-5_f32 as f64,
    // rust: )
    // rust: });
    // rust: let opposite =
    // rust: std::array::from_fn::<_, 3, _>(|i| floor_i32(clamped[i] - size[i] * corner[i] as f64));
    // rust: let blocks = BlockPos::between_corners_in_direction(
    // rust: pos,
    // rust: BlockPos::new(opposite[0], opposite[1], opposite[2]),
    // rust: movement,
    // rust: )
    // rust: .map_err(|_| TraversalError::InvalidBounds)?;
    // rust: if !sweep.visit(blocks, step, true)? {
    // rust: return Ok(false);
}
}
    // rust: let final_blocks = BlockPos::between_box_corners_in_direction(final_box, movement)
    // rust: .map_err(|_| TraversalError::InvalidBounds)?;
    // rust: sweep.visit(final_blocks, step.wrapping_add(1), true)
}

furthest_corner :: proc(movement: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let abs = [
    // rust: Vec3::new(1.0, 0.0, 0.0).dot(movement).abs(),
    // rust: Vec3::new(0.0, 1.0, 0.0).dot(movement).abs(),
    // rust: Vec3::new(0.0, 0.0, 1.0).dot(movement).abs(),
    // rust: ];
    // rust: let [x, y, z] = movement.components().map(|v| if v >= 0.0 { 1 } else { -1 });
    // rust: if abs[0] <= abs[1] && abs[0] <= abs[2] {
    // rust: [-x, -z, y]
    // rust: } else if abs[1] <= abs[2] {
    // rust: [z, -y, -x]
    // rust: } else {
    // rust: [-y, x, -z]
}
}

    // rust: mod tests {
//     use super::*;
tiny_movement_includes_maximum_faces_and_stops_immediately :: proc() {
}
    // rust: let box_ = Aabb::unit_cube(Vec3::ZERO);
    // rust: let mut visits = Vec::new();
    // rust: assert_eq!(
    // rust: sweep_intersected_blocks(Vec3::ZERO, Vec3::ZERO, box_, 20, |p, step| {
    // rust: visits.push((p, step));
    // rust: true
    // rust: }),
    // rust: Ok(true)
    // rust: );
    // rust: assert_eq!(visits.len(), 8);
    // rust: assert!(visits.iter().all(|(_, step)| *step == 0));
    // rust: assert_eq!(
    // rust: sweep_intersected_blocks(Vec3::ZERO, Vec3::ZERO, box_, 20, |_, _| false),
    // rust: Ok(false)
    // rust: );
    // rust: assert_eq!(
    // rust: sweep_intersected_blocks(Vec3::ZERO, Vec3::ZERO, box_, 1, |_, _| true),
    // rust: Err(TraversalError::VisitLimit)
    // rust: );
}
}
