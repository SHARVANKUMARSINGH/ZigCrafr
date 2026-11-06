//! Transpiled from Horizon Rust crate
//! Module: horizon-core_movement
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity geometry helpers operating on an already selected collider list.
// use super::{Aabb, Axis, Vec3, VoxelShape};

/// BlockGetter's floor-height decision for caller-selected collision shapes.
/// The lower block is queried lazily only if the current shape is empty.
    // rust: pub fn block_floor_height<'s>(shape: &VoxelShape, below: impl FnOnce() -> &'s VoxelShape) -> f64 {
    // rust: if !shape.is_empty() {
    // rust: return shape.max(Axis::Y);
}
    // rust: let height = below().max(Axis::Y);
    // rust: if height >= 1.0 {
    // rust: height - 1.0
    // rust: } else {
    // rust: f64::NEG_INFINITY
}
}

/// Bounds used once by Entity.collide to select entity collisions. The same
/// entity list is reused for both subsequent block/world-border queries.
pub fn entity_collision_bounds(movement: Vec3, aabb: Aabb, max_step: f32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: aabb.expand_towards(movement)
    // rust: .expand_towards(Vec3::new(0.0, max_step as f64, 0.0))
}

/// Resolve Entity.collide's initial movement and complete step-up decision.
///
/// `collect` supplies vanilla-equivalent colliders for each requested bound,
/// including the previously selected entity shapes, applicable world border,
/// and context-dependent block shapes in vanilla order. It is called for the
/// initial movement (unless its squared length is zero), then at most once
/// more if stepping is eligible. Entity collision selection and movement's
/// grounding/velocity/inside-block side effects belong to the caller.
    // rust: pub fn resolve_step_movement<'s>(
    // rust: movement: Vec3,
    // rust: aabb: Aabb,
    // rust: max_step: f32,
    // rust: on_ground: bool,
    // rust: mut collect: impl FnMut(Aabb) -> Vec<&'s VoxelShape>,
    // rust: ) -> Vec3 {
    // rust: try_resolve_step_movement(movement, aabb, max_step, on_ground, |bounds| {
    // rust: Ok::<_, std::convert::Infallible>(collect(bounds))
    // rust: })
    // rust: .unwrap_or_else(|never| match never {})
}

/// The same movement/step decision with fallible, owned or borrowed collider
/// collections. A provider failure stops before the next query and returns no
/// movement result. Existing world-query side effects are not rolled back.
    // rust: pub fn try_resolve_step_movement<S: std::borrow::Borrow<VoxelShape>, E>(
    // rust: movement: Vec3,
    // rust: aabb: Aabb,
    // rust: max_step: f32,
    // rust: on_ground: bool,
    // rust: mut collect: impl FnMut(Aabb) -> Result<Vec<S>, E>,
    // rust: ) -> Result<Vec3, E> {
    // rust: let resolved = if movement.length_squared() == 0.0 {
    // rust: movement
    // rust: } else {
    // rust: let shapes = collect(aabb.expand_towards(movement))?;
    // rust: resolve_borrowed_shape_movement(movement, aabb, &shapes)
}
    // rust: let landed = movement.y != resolved.y && movement.y < 0.0;
    // rust: if max_step > 0.0
    // rust: && (landed || on_ground)
    // rust: && (movement.x != resolved.x || movement.z != resolved.z)
    // rust: {
    // rust: let step_box = if landed {
    // rust: aabb.move_by(Vec3::new(0.0, resolved.y, 0.0))
    // rust: } else {
    // rust: aabb
}
    // rust: let mut query = step_box.expand_towards(Vec3::new(movement.x, max_step as f64, movement.z));
    // rust: if !landed {
    // rust: query = query.expand_towards(Vec3::new(0.0, -(1.0e-5_f32 as f64), 0.0));
}
    // rust: let shapes = collect(query)?;
    // rust: for height in borrowed_step_heights(step_box, &shapes, max_step, resolved.y as f32) {
    // rust: let candidate = resolve_borrowed_shape_movement(
    // rust: Vec3::new(movement.x, height as f64, movement.z),
    // rust: step_box,
    // rust: &shapes,
    // rust: );
    // rust: if candidate.horizontal_distance_squared() > resolved.horizontal_distance_squared() {
    // rust: return Ok(candidate.subtract(Vec3::new(
    // rust: 0.0,
    // rust: aabb.min(Axis::Y) - step_box.min(Axis::Y),
    // rust: 0.0,
    // rust: )));
}
}
}
    // rust: Ok(resolved)
}

/// Resolve vanilla's Y-first, magnitude-dependent horizontal axis ordering.
///
/// The caller must supply vanilla-equivalent block/entity/world-border shapes.
/// This helper does not collect shapes, step up, set grounded flags, modify
/// velocity, or apply inside-block effects.
pub fn resolve_shape_movement(movement: Vec3, aabb: Aabb, shapes: *[*VoxelShape]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: resolve_borrowed_shape_movement(movement, aabb, shapes)
}
    // rust: fn resolve_borrowed_shape_movement<S: std::borrow::Borrow<VoxelShape>>(
    // rust: movement: Vec3,
    // rust: aabb: Aabb,
    // rust: shapes: &[S],
    // rust: ) -> Vec3 {
    // rust: if shapes.is_empty() {
    // rust: return movement;
}
    // rust: let mut result = [0.0; 3];
    // rust: for axis in Axis::step_order(movement) {
    // rust: let amount = movement.component(axis);
    // rust: if amount == 0.0 {
    // rust: continue;
}
    // rust: let moved = aabb.move_by(Vec3::new(result[0], result[1], result[2]));
    // rust: result[axis as usize] = VoxelShape::collide_all(
    // rust: axis,
    // rust: moved,
    // rust: shapes.iter().map(std::borrow::Borrow::borrow),
    // rust: amount,
    // rust: );
}
    // rust: Vec3::new(result[0], result[1], result[2])
}

/// Candidate heights from Entity.collectCandidateStepUpHeights, including its
/// float narrowing, signed-zero set identity, current-Y exclusion and sorting.
/// Used by the step-up decision after collecting the appropriate world shapes.
    // rust: pub fn candidate_step_heights(
    // rust: aabb: Aabb,
    // rust: shapes: &[&VoxelShape],
    // rust: max_step: f32,
    // rust: current_y: f32,
    // rust: ) -> Vec<f32> {
    // rust: borrowed_step_heights(aabb, shapes, max_step, current_y)
}

    // rust: fn borrowed_step_heights<S: std::borrow::Borrow<VoxelShape>>(
    // rust: aabb: Aabb,
    // rust: shapes: &[S],
    // rust: max_step: f32,
    // rust: current_y: f32,
    // rust: ) -> Vec<f32> {
    // rust: let mut heights = Vec::<f32>::with_capacity(4);
    // rust: for shape in shapes {
    // rust: let shape = shape.borrow();
    // rust: for coordinate in shape.coordinates(Axis::Y) {
    // rust: let height = (*coordinate - aabb.min(Axis::Y)) as f32;
    // rust: if height < 0.0 || height == current_y {
    // rust: continue;
}
    // rust: if height > max_step {
    // rust: break;
}
            // FloatArraySet uses Float.floatToIntBits, so NaNs compare equal
            // while positive and negative zero remain separate members.
    // rust: let height = if height.is_nan() { f32::NAN } else { height };
    // rust: if !heights.iter().any(|old| old.to_bits() == height.to_bits()) {
    // rust: heights.push(height);
}
}
}
    // rust: heights.sort_unstable_by(f32::total_cmp);
    // rust: heights
}

    // rust: mod tests {
//     use super::*;
//     use crate::position::BlockPos;
pub fn movement_slides_after_a_wall_collision() void {
}
    // rust: let wall = VoxelShape::block();
    // rust: let b = Aabb::new(Vec3::new(-0.6, 0.0, 0.2), Vec3::new(-0.2, 1.8, 0.8));
    // rust: let requested = Vec3::new(1.0, 0.0, 0.1);
    // rust: assert_eq!(
    // rust: resolve_shape_movement(requested, b, &[&wall]),
    // rust: Vec3::new(0.2, 0.0, 0.1)
    // rust: );
    // rust: assert_eq!(
    // rust: resolve_shape_movement(Vec3::new(-0.0, -0.0, -0.0), b, &[]),
    // rust: Vec3::new(-0.0, -0.0, -0.0)
    // rust: );
    // rust: assert_eq!(
    // rust: resolve_shape_movement(Vec3::new(-0.0, -0.0, -0.0), b, &[&wall]),
    // rust: Vec3::ZERO
    // rust: );
}
pub fn step_heights_deduplicate_and_exclude_current_y() void {
}
    // rust: let shape = VoxelShape::from_cube([1, 2, 1], &[true, true]).unwrap();
    // rust: let b = Aabb::block(BlockPos::default());
    // rust: assert_eq!(
    // rust: candidate_step_heights(b, &[&shape, &shape], 0.6, 0.0),
    // rust: vec![0.5]
    // rust: );
    // rust: assert_eq!(
    // rust: candidate_step_heights(b, &[&shape], 1.0, 0.5),
    // rust: vec![0.0, 1.0]
    // rust: );
}

pub fn stepping_requeries_and_clears_a_half_block() void {
}
    // rust: let ledge = VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, 0.5, 1.0))).unwrap();
    // rust: let b = Aabb::new(Vec3::new(-0.6, 0.0, 0.2), Vec3::new(-0.2, 1.8, 0.8));
    // rust: let requested = Vec3::new(1.0, 0.0, 0.0);
    // rust: let mut queries = Vec::new();
    // rust: let result = resolve_step_movement(requested, b, 0.6, true, |query| {
    // rust: queries.push(query);
    // rust: vec![&ledge]
    // rust: });
    // rust: assert_eq!(result, Vec3::new(1.0, 0.5, 0.0));
    // rust: assert_eq!(queries.len(), 2);
    // rust: assert_eq!(queries[0], b.expand_towards(requested));
    // rust: assert_eq!(queries[1].min(Axis::Y), -(1.0e-5_f32 as f64));
    // rust: assert_eq!(
    // rust: resolve_step_movement(requested, b, 0.6, false, |_| vec![&ledge]),
    // rust: Vec3::new(0.2, 0.0, 0.0)
    // rust: );
}

pub fn squared_length_underflow_skips_collection_and_keeps_signed_zero() void {
}
    // rust: let b = Aabb::block(BlockPos::default());
    // rust: let requested = Vec3::new(-0.0, 1e-200, -0.0);
    // rust: assert_eq!(
    // rust: resolve_step_movement(requested, b, 0.6, true, |_| panic!("unexpected query")),
    // rust: requested
    // rust: );
}
pub fn floor_height_defers_the_lower_lookup_until_empty() void {
}
    // rust: let empty = VoxelShape::empty();
    // rust: let block = VoxelShape::block();
    // rust: assert_eq!(
    // rust: block_floor_height(&block, || panic!("unnecessary lower lookup")),
    // rust: 1.0
    // rust: );
    // rust: assert_eq!(block_floor_height(&empty, || &block), 0.0);
    // rust: assert_eq!(block_floor_height(&empty, || &empty), f64::NEG_INFINITY);
}
}

    // rust: mod fallible_tests {
//     use super::*;
pub fn owned_collision_queries_stop_at_first_failure() void {
}
    // rust: let bounds = Aabb::new(Vec3::new(-0.6, 0.0, 0.2), Vec3::new(-0.2, 1.8, 0.8));
    // rust: let ledge = VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, 0.5, 1.0))).unwrap();
    // rust: for fail in [0, 1] {
    // rust: let mut queries = 0;
    // rust: let result =
    // rust: try_resolve_step_movement(Vec3::new(1.0, 0.0, 0.0), bounds, 0.6, true, |_| {
    // rust: let call = queries;
    // rust: queries += 1;
    // rust: if call == fail {
    // rust: Err(call)
    // rust: } else {
    // rust: Ok(vec![ledge.clone()])
}
    // rust: });
    // rust: assert_eq!(result, Err(fail));
    // rust: assert_eq!(queries, fail + 1);
}
    // rust: let result = try_resolve_step_movement(
    // rust: Vec3::new(-0.0, -0.0, -0.0),
    // rust: bounds,
    // rust: 0.6,
    // rust: true,
    // rust: |_| -> Result<Vec<VoxelShape>, ()> {
    // rust: panic!("zero movement must skip shape collection")
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: [result.x.to_bits(), result.y.to_bits(), result.z.to_bits()],
    // rust: [(-0.0f64).to_bits(); 3]
    // rust: );
}
}
