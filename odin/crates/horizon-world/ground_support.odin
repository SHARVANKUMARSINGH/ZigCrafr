//! Transpiled from Horizon Rust crate
package horizon_world_ground_support

import "core:fmt"
import "core:mem"
import "core:math"

// Supporting-block selection and Entity ground-state transitions.
// use crate::{
    // rust: block_collision_scan::{BlockCollisionScan, BlockCollisionWorld, CollisionScanError},
    // rust: collision_context::CollisionContext,
}
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, Vec3},
    // rust: position::BlockPos,
}

compare_positions :: proc(left: BlockPos, right: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // Vec3i.compareTo uses signed wrapping subtraction in Y/Z/X order.
    // rust: if left.y != right.y {
    // rust: left.y.wrapping_sub(right.y)
    // rust: } else if left.z != right.z {
    // rust: left.z.wrapping_sub(right.z)
    // rust: } else {
    // rust: left.x.wrapping_sub(right.x)
}
}
    // rust: pub fn find_supporting_block<W: BlockCollisionWorld>(
    // rust: world: &mut W,
    // rust: context: CollisionContext<'_>,
    // rust: entity_position: Vec3,
    // rust: bounds: Aabb,
    // rust: candidate_budget: usize,
    // rust: ) -> Result<Option<BlockPos>, CollisionScanError<W::Error>> {
    // rust: let mut selected = None;
    // rust: let mut closest = f64::MAX;
    // rust: for hit in BlockCollisionScan::new(world, context, bounds, false, candidate_budget)? {
    // rust: let p = hit?.position;
    // rust: let dx = f64::from(p.x) + 0.5 - entity_position.x;
    // rust: let dy = f64::from(p.y) + 0.5 - entity_position.y;
    // rust: let dz = f64::from(p.z) + 0.5 - entity_position.z;
    // rust: let distance = dx * dx + dy * dy + dz * dz;
    // rust: if distance < closest
    // rust: || distance == closest && selected.is_none_or(|old| compare_positions(old, p) < 0)
    // rust: {
    // rust: selected = Some(p);
    // rust: closest = distance;
}
}
    // rust: Ok(selected)
}
GroundState :: struct {
    on_ground: bool,
    horizontal_collision: bool,
    on_ground_no_blocks: bool,
    supporting_block: Maybe(BlockPos),
}
    // rust: impl GroundState {
    // Entity.setOnGroundWithMovement writes these flags before support queries.
    // A failed query preserves any earlier writes, as in the native method.
    // rust: pub fn set_with_movement<E>(
    // rust: &mut self,
    // rust: on_ground: bool,
    // rust: horizontal_collision: bool,
    // rust: bounds: Aabb,
    // rust: movement: Option<Vec3>,
    // rust: find: impl FnMut(Aabb) -> Result<Option<BlockPos>, E>,
    // rust: ) -> Result<(), E> {
    // rust: self.on_ground = on_ground;
    // rust: self.horizontal_collision = horizontal_collision;
    // rust: self.check_support(on_ground, bounds, movement, find)
}
    // The optional movement is native's nullable movement argument. When the
    // first query misses, it can retry at the pre-horizontal-movement footprint.
    // rust: pub fn check_support<E>(
    // rust: &mut self,
    // rust: on_ground: bool,
    // rust: bounds: Aabb,
    // rust: movement: Option<Vec3>,
    // rust: mut find: impl FnMut(Aabb) -> Result<Option<BlockPos>, E>,
    // rust: ) -> Result<(), E> {
    // rust: if on_ground {
    // rust: let min = bounds.min_position();
    // rust: let max = bounds.max_position();
    // rust: let foot = Aabb::new(
    // rust: Vec3::new(min.x, min.y - 1.0e-6, min.z),
    // rust: Vec3::new(max.x, bounds.min(Axis::Y), max.z),
    // rust: );
    // rust: let mut found = find(foot)?;
    // rust: if found.is_some() || self.on_ground_no_blocks {
    // rust: self.supporting_block = found;
    // rust: } else if let Some(movement) = movement {
    // rust: found = find(foot.move_by(Vec3::new(-movement.x, 0.0, -movement.z)))?;
    // rust: self.supporting_block = found;
}
    // rust: self.on_ground_no_blocks = found.is_none();
    // rust: } else {
    // rust: self.on_ground_no_blocks = false;
    // rust: self.supporting_block = None;
}
    // rust: Ok(())
}
}
