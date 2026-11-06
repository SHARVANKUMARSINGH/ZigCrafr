//! Transpiled from Horizon Rust crate
//! Module: horizon-world_powder_snow_collision
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Powder snow collision over entity metadata and lazily queried walkability.
// use crate::{collision_context::CollisionContext, entity_obstruction::EntityIdentity};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, VoxelShape},
    // rust: position::BlockPos,
}
// use std::sync::OnceLock;

pub const PowderSnowEntity = struct {
    fall_distance: f64,
    falling_block: bool,
};

    // rust: pub trait PowderSnowWorld {
    // rust: type Error;
    /// Snapshot of the entity's fallDistance field and FallingBlockEntity type.
    // rust: fn powder_snow_entity(
    // rust: &mut self,
    // rust: entity: EntityIdentity,
    // rust: ) -> Result<PowderSnowEntity, Self::Error>;
pub fn powder_snow_walkable_tag(self: *Self, entity: EntityIdentity) R;
    /// Invoke only for a living entity; item identity follows ItemStack.is,
    /// including its empty-stack normalization.
pub fn feet_are_leather_boots(self: *Self, entity: EntityIdentity) R;
}

    // rust: pub fn can_walk_on_powder_snow<W: PowderSnowWorld>(
    // rust: world: &mut W,
    // rust: entity: EntityIdentity,
    // rust: living: bool,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if world.powder_snow_walkable_tag(entity)? {
    // rust: return Ok(true);
}
    // rust: if living {
    // rust: return world.feet_are_leather_boots(entity);
}
    // rust: Ok(false)
}

    // rust: pub fn powder_snow_collision_shape<W: PowderSnowWorld>(
    // rust: world: &mut W,
    // rust: position: BlockPos,
    // rust: context: &CollisionContext<'_>,
    // rust: ) -> Result<VoxelShape, W::Error> {
    // rust: if context.is_placement() {
    // rust: return Ok(VoxelShape::empty());
}
    // rust: let Some(entity) = context.entity() else {
    // rust: return Ok(VoxelShape::empty());
}
    // rust: let snapshot = world.powder_snow_entity(entity)?;
    // rust: if snapshot.fall_distance > 2.5 {
pub const FALLING: OnceLock<VoxelShape> = OnceLock::new();
    // rust: return Ok(FALLING
    // rust: .get_or_init(|| {
    // rust: VoxelShape::from_box(Aabb::new(
    // rust: Vec3::ZERO,
    // rust: Vec3::new(1.0, f64::from(0.9f32), 1.0),
    // rust: ))
    // rust: .expect("bounded falling powder snow shape")
    // rust: })
    // rust: .clone());
}
    // rust: if snapshot.falling_block
    // rust: || (can_walk_on_powder_snow(world, entity, context.living_entity().is_some())?
    // rust: && context.is_above(&VoxelShape::block(), position, false)
    // rust: && !context.is_descending())
    // rust: {
    // rust: return Ok(VoxelShape::block());
}
    // rust: Ok(VoxelShape::empty())
}
