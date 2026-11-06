//! Transpiled from Horizon Rust crate
package horizon_world_world_movement

import "core:fmt"
import "core:mem"
import "core:math"

// Entity.collide collection order and step resolution over a collision world.
// Travel, velocity, grounded flags and inside-block effects remain caller work.
// use crate::{
    // rust: block_collision_scan::{
    // rust: BlockCollisionScan, BlockCollisionWorld, CollisionScanError, scan_cells,
    // rust: },
    // rust: collision_context::CollisionContext,
    // rust: entity_obstruction::EntityIdentity,
}
// use horizon_core::geometry::{
    // rust: Aabb, Axis, ShapeOp, Vec3, VoxelShape, entity_collision_bounds, try_resolve_step_movement,
}

// How far below the feet `Entity.getAvailableSpaceBelow` looks for ground.
GROUND_RANGE :: 1.0

    // rust: pub trait EntityMovementWorld {
    // rust: type Error;
    // Return native-selected entity shapes in query order. Selection occurs
    // once, even for zero movement, and the list is reused during stepping.
    // rust: fn entity_collisions(
    // rust: &mut self,
    // rust: entity: EntityIdentity,
    // rust: bounds: Aabb,
    // rust: ) -> Result<Vec<VoxelShape>, Self::Error>;
    // Obtain the border, check isInsideCloseToBorder and fetch its shape only
    // when applicable. Called before block iteration for each collision query.
    // rust: fn movement_border(
    // rust: &mut self,
    // rust: entity: EntityIdentity,
    // rust: bounds: Aabb,
    // rust: ) -> Result<Option<VoxelShape>, Self::Error>;
}

MovementRequest :: struct {
    entity: EntityIdentity,
    // Captured context for this entity. Experimental minecart exclusions need
    // their separate context layer; ordinary captured contexts are supported.
    context: CollisionContext<'a>,
    bounds: Aabb,
    movement: Vec3,
    max_step: f32,
    on_ground: bool,
    // Per block scan, including skipped cursor cells.
    candidate_budget: uint,
}

    // rust: pub fn resolve_world_movement<W, E>(
    // rust: world: &mut W,
    // rust: request: MovementRequest<'_>,
    // rust: ) -> Result<Vec3, CollisionScanError<E>>
    // rust: where
    // rust: W: BlockCollisionWorld<Error = E> + EntityMovementWorld<Error = E>,
    // rust: {
    // rust: let entities = world
    // rust: .entity_collisions(
    // rust: request.entity,
    // rust: entity_collision_bounds(request.movement, request.bounds, request.max_step),
    // rust: )
    // rust: .map_err(CollisionScanError::World)?;
    // Vanilla walks the whole box a movement expands to with no candidate
    // counter, so a movement big enough to pass the caller's budget is slow
    // there, never fatal (#6124: a legal movement_speed of 400 crossed more
    // than a million cells on a diagonal and aborted the game). The budget
    // only has to cover the cells both queries of a step can visit: the
    // sweep, and the step's own box raised by max_step.
    // rust: let sweep = request
    // rust: .bounds
    // rust: .expand_towards(request.movement)
    // rust: .expand_towards(Vec3::new(0.0, f64::from(request.max_step.max(0.0)), 0.0));
    // rust: let candidate_budget = scan_cells(sweep).map_or(request.candidate_budget, |cells| {
    // rust: cells.max(request.candidate_budget)
    // rust: });
    // rust: try_resolve_step_movement(
    // rust: request.movement,
    // rust: request.bounds,
    // rust: request.max_step,
    // rust: request.on_ground,
    // rust: |bounds| {
    // rust: let mut shapes = entities.clone();
    // rust: if let Some(border) = world
    // rust: .movement_border(request.entity, bounds)
    // rust: .map_err(CollisionScanError::World)?
    // rust: {
    // rust: shapes.push(border);
}
    // rust: for hit in
    // rust: BlockCollisionScan::new(world, request.context, bounds, false, candidate_budget)?
    // rust: {
    // rust: shapes.push(hit?.shape);
}
    // rust: Ok(shapes)
    // rust: },
    // rust: )
}

// Entity-bearing CollisionGetter.noCollision, with block/context selection
// supplied by the caller (including an always-fluid context when requested).
// Native short-circuits blocks, then entity selection, then border geometry.
CollisionCheckRequest :: struct {
    entity: EntityIdentity,
    context: CollisionContext<'a>,
    bounds: Aabb,
    candidate_budget: uint,
}
    // rust: pub fn no_world_collision<W, E>(
    // rust: world: &mut W,
    // rust: request: CollisionCheckRequest<'_>,
    // rust: ) -> Result<bool, CollisionScanError<E>>
    // rust: where
    // rust: W: BlockCollisionWorld<Error = E> + EntityMovementWorld<Error = E>,
    // rust: {
    // rust: for hit in BlockCollisionScan::new(
    // rust: world,
    // rust: request.context,
    // rust: request.bounds,
    // rust: false,
    // rust: request.candidate_budget,
    // rust: )? {
    // rust: if !hit?.shape.is_empty() {
    // rust: return Ok(false);
}
}
    // rust: if !world
    // rust: .entity_collisions(request.entity, request.bounds)
    // rust: .map_err(CollisionScanError::World)?
    // rust: .is_empty()
    // rust: {
    // rust: return Ok(false);
}
    // rust: if let Some(border) = world
    // rust: .movement_border(request.entity, request.bounds)
    // rust: .map_err(CollisionScanError::World)?
    // rust: {
    // rust: let entity = VoxelShape::from_box(request.bounds).map_err(CollisionScanError::Shape)?;
    // rust: return border
    // rust: .join_is_not_empty(&entity, ShapeOp::AND)
    // rust: .map(|overlap| !overlap)
    // rust: .map_err(CollisionScanError::Shape);
}
    // rust: Ok(true)
}

// `ServerPlayerGameMode.isInRangeOfGround`: nothing collides with the body and
// `Entity.getAvailableSpaceBelow(1.0)` is less than a block, so a player who
// keeps flying through a game mode change lands when standing on the ground.
//
// shortcut: entity colliders stay out, as in the rest of this collision world,
// so standing on a boat counts as air; upgrade when that must count as ground.
    // rust: pub fn in_range_of_ground<W, E>(world: &mut W, bounds: Aabb) -> bool
    // rust: where
    // rust: W: BlockCollisionWorld<Error = E> + EntityMovementWorld<Error = E>,
    // rust: {
    // getAvailableSpaceBelow collects the colliders of the box one block under
    // the feet up to them; the body's own colliders come with that box.
    // rust: let below = bounds.move_by(Vec3::new(0.0, -GROUND_RANGE, 0.0));
    // rust: let reach = Aabb::new(below.min_position(), bounds.max_position());
    // rust: let Ok(scan) = BlockCollisionScan::new(
    // rust: world,
        // collectAllColliders without the body's own context, as
        // no_collision_empty: it changes only powder snow and a strider's
        // fluids, neither of which holds a flying player up.
    // rust: CollisionContext::empty(false),
    // rust: reach,
    // rust: false,
    // rust: 1_000_000,
    // rust: ) else {
    // rust: return false;
}
    // rust: let mut colliders = Vec::new();
    // rust: for hit in scan {
    // rust: let Ok(hit) = hit else {
    // rust: return false;
}
    // rust: colliders.push(hit.shape);
}
    // rust: in_range_of_ground_among(bounds, &colliders)
}

// The collider half: `collectAllColliders(body).isEmpty()` and `Shapes.collide`
// one block down from the body.
in_range_of_ground_among :: proc(bounds: Aabb, colliders: ^[VoxelShape]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(body) = VoxelShape::from_box(bounds) else {
    // rust: return false;
}
    // rust: if colliders
    // rust: .iter()
    // rust: .any(|shape| shape.join_is_not_empty(&body, ShapeOp::AND).unwrap_or(true))
    // rust: {
    // rust: return false;
}
    // rust: -VoxelShape::collide_all(Axis::Y, bounds, colliders, -GROUND_RANGE) < GROUND_RANGE
}

    // rust: mod ground_range_tests {
//     use super::*;

    // A full block's collision shape, in world coordinates.
block :: proc(x: f64, y: f64, z: f64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let corner = |dx, dy, dz| Vec3::new(x + dx, y + dy, z + dz);
    // rust: VoxelShape::from_box(Aabb::new(corner(0.0, 0.0, 0.0), corner(1.0, 1.0, 1.0)))
    // rust: .expect("a unit cube")
}

    // A player's box, feet at `y`.
body :: proc(y: f64) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Aabb::new(Vec3::new(0.0, y, 0.0), Vec3::new(0.6, y + 1.8, 0.6))
}

    // The floor is within the block below the feet: in range, so a flying
    // player lands.
a_body_on_or_near_the_floor_is_in_range_of_ground :: proc() {
}
    // rust: assert!(in_range_of_ground_among(body(1.0), &[block(0.0, 0.0, 0.0)]));
        // Hovering half a block up: the ground is still within its reach.
    // rust: assert!(in_range_of_ground_among(body(1.5), &[block(0.0, 0.0, 0.0)]));
}

    // Nothing within a block below the feet: mid-air, so the player keeps
    // flying.
a_body_high_in_the_air_is_not_in_range_of_ground :: proc() {
}
    // rust: assert!(!in_range_of_ground_among(
    // rust: body(10.0),
    // rust: &[block(0.0, 0.0, 0.0)]
    // rust: ));
    // rust: assert!(!in_range_of_ground_among(body(10.0), &[]));
}

    // A body inside a block is not standing on ground.
a_body_inside_a_block_is_not_in_range_of_ground :: proc() {
}
    // rust: assert!(!in_range_of_ground_among(
    // rust: body(0.5),
    // rust: &[block(0.0, 0.0, 0.0)]
    // rust: ));
}
}
