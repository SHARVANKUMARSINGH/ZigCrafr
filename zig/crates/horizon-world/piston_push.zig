//! Transpiled from Horizon Rust crate
//! Module: horizon-world_piston_push
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `PistonMovingBlockEntity.moveCollidedEntities`, `moveStuckEntities` and
//! `fixEntityWithinPistonBase` over immutable geometry.
//!
//! Entity storage, the moving entities themselves and the blocks they collide
//! with belong to the caller: these functions decide *how far* an entity is
//! pushed, which is the part that must match vanilla to the bit. The movement
//! they describe is an `Entity.move(MoverType.PISTON, …)`, so the caller still
//! applies it through its own collision resolution and per-tick piston limit.
// use crate::{level::data::PushReaction, piston_shape::MovingPistonState};
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3},
    // rust: position::BlockPos,
}

/// `PistonMovingBlockEntity.PUSH_OFFSET`.
pub const PUSH_OFFSET: f64 = 0.01;

/// `PistonMovingBlockEntity.getExtendedProgress`: where along its travel the
/// moved block is, in blocks (negative before it starts, 0 when it arrives).
pub fn extended_progress(piston: MovingPistonState, progress: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if piston.extending {
    // rust: progress - 1.0
    // rust: } else {
    // rust: 1.0 - progress
}
}

/// `Direction.getAxisDirection().getStep()`.
pub fn step_along(direction: Direction) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match direction {
    // rust: Direction::East | Direction::Up | Direction::South => 1,
    // rust: Direction::West | Direction::Down | Direction::North => -1,
}
}

/// `Direction.getStepX/Y/Z` as a vector.
pub fn step_vector(direction: Direction) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = direction.normal();
    // rust: Vec3::new(f64::from(x), f64::from(y), f64::from(z))
}

/// `PistonMath.getMovementArea`: the slab an entity's box must reach into to be
/// run over by `amount` of further travel along `direction`.
pub fn movement_area(aabb: Aabb, direction: Direction, amount: f64) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let delta = amount * f64::from(step_along(direction));
    // rust: let low = delta.min(0.0);
    // rust: let high = delta.max(0.0);
    // rust: let (min, max) = (aabb.min_position(), aabb.max_position());
    // rust: match direction {
    // rust: Direction::West => Aabb::new(
    // rust: Vec3::new(min.x + low, min.y, min.z),
    // rust: Vec3::new(min.x + high, max.y, max.z),
    // rust: ),
    // rust: Direction::East => Aabb::new(
    // rust: Vec3::new(max.x + low, min.y, min.z),
    // rust: Vec3::new(max.x + high, max.y, max.z),
    // rust: ),
    // rust: Direction::Down => Aabb::new(
    // rust: Vec3::new(min.x, min.y + low, min.z),
    // rust: Vec3::new(max.x, min.y + high, max.z),
    // rust: ),
    // rust: Direction::Up => Aabb::new(
    // rust: Vec3::new(min.x, max.y + low, min.z),
    // rust: Vec3::new(max.x, max.y + high, max.z),
    // rust: ),
    // rust: Direction::North => Aabb::new(
    // rust: Vec3::new(min.x, min.y, min.z + low),
    // rust: Vec3::new(max.x, max.y, min.z + high),
    // rust: ),
    // rust: Direction::South => Aabb::new(
    // rust: Vec3::new(min.x, min.y, max.z + low),
    // rust: Vec3::new(max.x, max.y, max.z + high),
    // rust: ),
}
}

/// `PistonMovingBlockEntity.moveByPositionAndProgress`: a box moved to the
/// block position and on to where the moved block currently is.
pub fn move_by_position_and_progress(pos: BlockPos, aabb: Aabb, piston: MovingPistonState) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let current = f64::from(extended_progress(piston, piston.progress));
    // rust: let step = step_vector(piston.direction);
    // rust: aabb.move_by(Vec3::new(
    // rust: f64::from(pos.x) + current * step.x,
    // rust: f64::from(pos.y) + current * step.y,
    // rust: f64::from(pos.z) + current * step.z,
    // rust: ))
}

/// `PistonMovingBlockEntity.getMovement`: how far `entity` stands inside the
/// block it must be pushed out of, measured along `movement`'s axis.
pub fn get_movement(block: Aabb, movement: Direction, entity: Aabb) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (bmin, bmax) = (block.min_position(), block.max_position());
    // rust: let (emin, emax) = (entity.min_position(), entity.max_position());
    // rust: match movement {
    // rust: Direction::East => bmax.x - emin.x,
    // rust: Direction::West => emax.x - bmin.x,
    // rust: Direction::Up => bmax.y - emin.y,
    // rust: Direction::Down => emax.y - bmin.y,
    // rust: Direction::South => bmax.z - emin.z,
    // rust: Direction::North => emax.z - bmin.z,
}
}

/// `moveCollidedEntities`' inner loop: the furthest any of the moved block's
/// boxes reaches into `entity`, capped at the progress delta, plus
/// [`PUSH_OFFSET`]. `0.0` when the block does not touch the entity.
    // rust: pub fn collided_amount(
    // rust: boxes: &[Aabb],
    // rust: pos: BlockPos,
    // rust: piston: MovingPistonState,
    // rust: new_progress: f32,
    // rust: movement: Direction,
    // rust: entity: Aabb,
    // rust: ) -> f64 {
    // rust: let delta_progress = f64::from(new_progress - piston.progress);
    // rust: let mut delta: f64 = 0.0;
    // rust: for block in boxes {
    // rust: let moving = movement_area(
    // rust: move_by_position_and_progress(pos, *block, piston),
    // rust: movement,
    // rust: delta_progress,
    // rust: );
    // rust: if moving.intersects(entity) {
    // rust: delta = delta.max(get_movement(moving, movement, entity));
    // rust: if delta >= delta_progress {
    // rust: break;
}
}
}
    // rust: if delta <= 0.0 {
    // rust: return 0.0;
}
    // rust: delta.min(delta_progress) + PUSH_OFFSET
}

/// The box `level.getEntities` searches for a push: the moved block's own box
/// widened by the slab it is about to sweep.
pub fn movement_search_area(block_box: Aabb, movement: Direction, delta_progress: f64) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: movement_area(block_box, movement, delta_progress).union_bounds(block_box)
}

/// `moveStuckEntities`: the box of standing entities a moving honey block drags
/// with it. `sticky_top` is the moved state's top collision height.
pub fn sticky_area(pos: BlockPos, piston: MovingPistonState, sticky_top: f64) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let area = Aabb::new(
    // rust: Vec3::new(0.0, sticky_top, 0.0),
    // rust: Vec3::new(1.0, 1.500_001_000_000_000_1, 1.0),
    // rust: );
    // rust: move_by_position_and_progress(pos, area, piston)
}

/// `PistonMovingBlockEntity.matchesStickyCritera`.
    // rust: pub fn matches_sticky_criteria(
    // rust: area: Aabb,
    // rust: reaction: PushReaction,
    // rust: on_ground: bool,
    // rust: supported_by_piston: bool,
    // rust: entity_position: Vec3,
    // rust: ) -> bool {
    // rust: if reaction != PushReaction::PushPull || !on_ground {
    // rust: return false;
}
    // rust: if supported_by_piston {
    // rust: return true;
}
    // rust: let (min, max) = (area.min_position(), area.max_position());
    // rust: entity_position.x >= min.x
    // rust: && entity_position.x <= max.x
    // rust: && entity_position.z >= min.z
    // rust: && entity_position.z <= max.z
}

/// The level query intersects the sticky box before applying the predicate.
    // rust: pub fn sticky_entity_selected(
    // rust: area: Aabb,
    // rust: bounds: Aabb,
    // rust: reaction: PushReaction,
    // rust: on_ground: bool,
    // rust: supported_by_piston: bool,
    // rust: position: Vec3,
    // rust: ) -> bool {
    // rust: area.intersects(bounds)
    // rust: && matches_sticky_criteria(area, reaction, on_ground, supported_by_piston, position)
}

/// `fixEntityWithinPistonBase`: a retracting source piston drags an entity that
/// is still inside the piston's own block out along the opposite of `movement`.
/// The returned distance is measured along that opposite direction.
    // rust: pub fn fix_within_piston_base(
    // rust: pos: BlockPos,
    // rust: entity: Aabb,
    // rust: movement: Direction,
    // rust: delta_progress: f64,
    // rust: ) -> Option<f64> {
    // rust: let block = Aabb::unit_cube(Vec3::from_block(pos));
    // rust: if !entity.intersects(block) {
    // rust: return None;
}
    // rust: let opposite = movement.opposite();
    // rust: let delta = get_movement(block, opposite, entity) + PUSH_OFFSET;
    // rust: let intersected = entity.intersect(block);
    // rust: let delta_intersected = get_movement(block, opposite, intersected) + PUSH_OFFSET;
    // As deep inside as the block allows: it is stuck in the base itself, so it
    // leaves along with the retraction.
    // rust: if (delta - delta_intersected).abs() < PUSH_OFFSET {
    // rust: Some(delta.min(delta_progress) + PUSH_OFFSET)
    // rust: } else {
    // rust: None
}
}

/// `PistonMovingBlockEntity.getCollisionRelatedBlockState` uses the moved state
/// unless a source piston is retracting, where it shows a piston head instead.
/// The state itself comes from [`PistonBlockBindings::collision_related_state`].
///
/// [`PistonBlockBindings::collision_related_state`]:
///     crate::piston_shape::PistonBlockBindings::collision_related_state
pub fn uses_moved_state(piston: MovingPistonState) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: piston.extending || !piston.source
}

/// `moveCollidedEntities`' slime bounce: a slime block sets the velocity along
/// the movement axis to that direction's step, leaving the other axes.
pub fn bounce_velocity(movement: Direction, velocity: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut velocity = velocity;
    // rust: match movement {
    // rust: Direction::East => velocity.x = 1.0,
    // rust: Direction::West => velocity.x = -1.0,
    // rust: Direction::Up => velocity.y = 1.0,
    // rust: Direction::Down => velocity.y = -1.0,
    // rust: Direction::South => velocity.z = 1.0,
    // rust: Direction::North => velocity.z = -1.0,
}
    // rust: velocity
}

/// `Entity.getPistonPushReaction() == PushReaction.IGNORE_ENTITY`.
///
/// `Marker`, `Interaction`, `Display`, `AreaEffectCloud` and
/// `OminousItemSpawner` return `IGNORE_ENTITY`, and an armor stand does when it
/// is a marker. Horizon gives those kinds no pushed body, so a caller that has
/// no box to push never reaches the maths above; this names the predicate for
/// the kinds that do have one.
pub fn ignores_push(marker: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: marker
}

    // rust: mod tests {
//     use super::*;

pub fn unit() A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Aabb::new(Vec3::new(0.0, 0.0, 0.0), Vec3::new(1.0, 1.0, 1.0))
}

pub fn moving(direction: Direction, extending: bool, progress: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MovingPistonState {
    // rust: moved_state: crate::registry::BlockStateId(0),
    // rust: direction,
    // rust: extending,
    // rust: source: false,
    // rust: progress,
    // rust: previous_progress: progress,
}
}

    /// `getMovementArea` puts the slab on the leading face and widens it by the
    /// travel in that direction only.
pub fn movement_area_sits_on_the_leading_face() void {
}
    // rust: let east = movement_area(unit(), Direction::East, 0.5);
    // rust: assert_eq!(east.min_position(), Vec3::new(1.0, 0.0, 0.0));
    // rust: assert_eq!(east.max_position(), Vec3::new(1.5, 1.0, 1.0));

    // rust: let west = movement_area(unit(), Direction::West, 0.5);
    // rust: assert_eq!(west.min_position(), Vec3::new(-0.5, 0.0, 0.0));
    // rust: assert_eq!(west.max_position(), Vec3::new(0.0, 1.0, 1.0));

    // rust: let up = movement_area(unit(), Direction::Up, 0.5);
    // rust: assert_eq!(up.min_position(), Vec3::new(0.0, 1.0, 0.0));
    // rust: assert_eq!(up.max_position(), Vec3::new(1.0, 1.5, 1.0));

    // rust: let north = movement_area(unit(), Direction::North, 0.5);
    // rust: assert_eq!(north.min_position(), Vec3::new(0.0, 0.0, -0.5));
    // rust: assert_eq!(north.max_position(), Vec3::new(1.0, 1.0, 0.0));
}

    /// A negative amount sweeps behind the leading face.
pub fn movement_area_follows_a_negative_amount() void {
}
    // rust: let area = movement_area(unit(), Direction::East, -0.5);
    // rust: assert_eq!(area.min_position(), Vec3::new(0.5, 0.0, 0.0));
    // rust: assert_eq!(area.max_position(), Vec3::new(1.0, 1.0, 1.0));
}

    /// The arm of a piston at the origin: the block entity sits in the block it
    /// pushes into, and at progress 0 its shape is still a block back.
pub const ARM: BlockPos = BlockPos::new(1, 0, 0);

    /// An entity in the way is pushed the progress delta, plus the push offset;
    /// here it hangs 0.6 into the slab and the delta caps it at 0.5.
pub fn a_collided_entity_moves_the_progress_delta() void {
}
    // rust: let piston = moving(Direction::East, true, 0.0);
    // rust: let entity = Aabb::new(Vec3::new(0.9, 0.0, 0.2), Vec3::new(1.5, 1.8, 0.8));
    // rust: let amount = collided_amount(&[unit()], ARM, piston, 0.5, Direction::East, entity);
    // rust: assert!((amount - (0.5 + PUSH_OFFSET)).abs() < 1.0e-12, "{amount}");
}

    /// The delta is not a floor: an entity barely nicking the slab moves by only
    /// what it is owed, plus the offset.
pub fn a_grazed_entity_moves_only_what_it_overlaps() void {
}
    // rust: let piston = moving(Direction::East, true, 0.0);
    // rust: let entity = Aabb::new(Vec3::new(1.4, 0.0, 0.2), Vec3::new(2.0, 1.8, 0.8));
    // rust: let amount = collided_amount(&[unit()], ARM, piston, 0.5, Direction::East, entity);
    // rust: assert!((amount - (0.1 + PUSH_OFFSET)).abs() < 1.0e-12, "{amount}");
}

    /// Clear of the block, nothing moves.
pub fn an_entity_out_of_the_way_is_left_alone() void {
}
    // rust: let piston = moving(Direction::East, true, 0.0);
    // rust: let entity = Aabb::new(Vec3::new(3.0, 0.0, 0.2), Vec3::new(3.6, 1.8, 0.8));
    // rust: let amount = collided_amount(&[unit()], ARM, piston, 0.5, Direction::East, entity);
    // rust: assert_eq!(amount, 0.0);
}

    /// A retracting base drags an entity stuck inside its own block, limited by
    /// the progress delta.
pub fn a_retracting_base_drags_a_stuck_entity() void {
}
    // rust: let entity = Aabb::new(Vec3::new(0.75, 0.0, 0.2), Vec3::new(1.35, 1.8, 0.8));
    // rust: let amount = fix_within_piston_base(BlockPos::new(0, 0, 0), entity, Direction::West, 0.5)
    // rust: .expect("stuck in the base");
    // rust: assert!(amount > 0.0 && amount <= 0.5 + PUSH_OFFSET, "{amount}");
}

    /// An entity outside the base's block is not dragged by it.
pub fn a_free_entity_is_not_dragged_by_the_base() void {
}
    // rust: let entity = Aabb::new(Vec3::new(2.0, 0.0, 0.2), Vec3::new(2.6, 1.8, 0.8));
    // rust: assert_eq!(
    // rust: fix_within_piston_base(BlockPos::new(0, 0, 0), entity, Direction::West, 0.5),
    // rust: None
    // rust: );
}

    /// Honey drags only entities that stand on it and that blocks may push.
pub fn honey_drags_standing_entities() void {
}
    // rust: let area = Aabb::new(Vec3::new(0.0, 0.0, 0.0), Vec3::new(1.0, 1.5, 1.0));
    // rust: let on_top = Vec3::new(0.5, 0.0, 0.5);
    // rust: assert!(matches_sticky_criteria(
    // rust: area,
    // rust: PushReaction::PushPull,
    // rust: true,
    // rust: false,
    // rust: on_top
    // rust: ));
    // rust: assert!(!matches_sticky_criteria(
    // rust: area,
    // rust: PushReaction::PushPull,
    // rust: false,
    // rust: false,
    // rust: on_top
    // rust: ));
    // rust: assert!(!matches_sticky_criteria(
    // rust: area,
    // rust: PushReaction::Immoveable,
    // rust: true,
    // rust: false,
    // rust: on_top
    // rust: ));
        // Beside it: only standing on the piston's own block holds it.
    // rust: let beside = Vec3::new(2.0, 0.0, 0.5);
    // rust: assert!(!matches_sticky_criteria(
    // rust: area,
    // rust: PushReaction::PushPull,
    // rust: true,
    // rust: false,
    // rust: beside
    // rust: ));
    // rust: assert!(matches_sticky_criteria(
    // rust: area,
    // rust: PushReaction::PushPull,
    // rust: true,
    // rust: true,
    // rust: beside
    // rust: ));
}

pub fn honey_selection_uses_entity_position_and_intersection() void {
}
    // rust: let area = Aabb::new(Vec3::new(0.0, 1.0, 0.0), Vec3::new(1.0, 1.5, 1.0));
    // rust: let position = Vec3::new(0.1, 1.0, 0.5);
    // rust: let bounds = Aabb::new(Vec3::new(-0.2, 1.0, 0.2), Vec3::new(0.4, 2.8, 0.8));
    // rust: assert!(sticky_entity_selected(
    // rust: area,
    // rust: bounds,
    // rust: PushReaction::PushPull,
    // rust: true,
    // rust: false,
    // rust: position
    // rust: ));
    // rust: let above = bounds.move_by(Vec3::new(0.0, 3.0, 0.0));
    // rust: assert!(!sticky_entity_selected(
    // rust: area,
    // rust: above,
    // rust: PushReaction::PushPull,
    // rust: true,
    // rust: true,
    // rust: position
    // rust: ));
}

    /// The slime bounce rewrites only the movement axis.
pub fn a_slime_block_bounces_along_its_axis() void {
}
    // rust: let v = Vec3::new(0.2, -0.5, 0.3);
    // rust: assert_eq!(
    // rust: bounce_velocity(Direction::East, v),
    // rust: Vec3::new(1.0, -0.5, 0.3)
    // rust: );
    // rust: assert_eq!(bounce_velocity(Direction::Up, v), Vec3::new(0.2, 1.0, 0.3));
    // rust: assert_eq!(
    // rust: bounce_velocity(Direction::North, v),
    // rust: Vec3::new(0.2, -0.5, -1.0)
    // rust: );
}

    /// An item sitting on a slime block that a piston is pushing up is inside
    /// the bounce search area and is pushed (`moveCollidedEntities`).
pub fn an_item_on_slime_is_caught_by_an_upward_piston() void {
}
    // rust: let piston = moving(Direction::Up, true, 0.0);
    // rust: let dest = BlockPos::new(0, 2, 0);
    // rust: let visual = move_by_position_and_progress(dest, unit(), piston);
    // rust: assert_eq!(visual.min_position(), Vec3::new(0.0, 1.0, 0.0));
    // rust: let search = movement_search_area(visual, Direction::Up, 0.5);
    // rust: let item = Aabb::new(Vec3::new(0.375, 2.0, 0.375), Vec3::new(0.625, 2.25, 0.625));
    // rust: assert!(
    // rust: search.intersects(item),
    // rust: "item sitting on slime must be in the bounce search"
    // rust: );
    // rust: let amount = collided_amount(&[unit()], dest, piston, 0.5, Direction::Up, item);
    // rust: assert!(
    // rust: amount > 0.0,
    // rust: "item sitting on slime must be pushed, got {amount}"
    // rust: );
    // rust: assert_eq!(bounce_velocity(Direction::Up, Vec3::ZERO).y, 1.0);
}

    /// The moved block sits along the piston's own direction, half a block short
    /// at mid-travel and in place once landed.
pub fn the_moved_block_sits_along_the_piston_direction() void {
}
    // rust: let half = moving(Direction::East, true, 0.5);
    // rust: let moved = move_by_position_and_progress(BlockPos::new(2, 3, 4), unit(), half);
    // rust: assert_eq!(moved.min_position(), Vec3::new(1.5, 3.0, 4.0));

    // rust: let landed = moving(Direction::East, true, 1.0);
    // rust: assert_eq!(
    // rust: move_by_position_and_progress(BlockPos::new(2, 3, 4), unit(), landed).min_position(),
    // rust: Vec3::new(2.0, 3.0, 4.0)
    // rust: );

        // Retracting runs the other way: two thirds out at progress 1/3.
    // rust: let pulling = moving(Direction::East, false, 0.5);
    // rust: assert_eq!(
    // rust: move_by_position_and_progress(BlockPos::new(2, 3, 4), unit(), pulling).min_position(),
    // rust: Vec3::new(2.5, 3.0, 4.0)
    // rust: );
}

    /// The search area covers the block and the slab in front of it.
pub fn the_search_area_covers_block_and_sweep() void {
}
    // rust: let area = movement_search_area(unit(), Direction::East, 0.5);
    // rust: assert_eq!(area.min_position(), Vec3::new(0.0, 0.0, 0.0));
    // rust: assert_eq!(area.max_position(), Vec3::new(1.5, 1.0, 1.0));
}
}
