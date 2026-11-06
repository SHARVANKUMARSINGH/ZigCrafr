//! Transpiled from Horizon Rust crate
//! Module: horizon-world_liquid_collision
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Contextual water/lava collision selection. Fluid simulation and entity-specific
//! standing shapes are supplied by the caller; no-context caches are not used.
// use crate::{
    // rust: chunk::BlockState, collision_context::CollisionContext, entity_obstruction::EntityIdentity,
    // rust: fluid::FluidState,
}
// use horizon_core::{geometry::VoxelShape, position::BlockPos};
// use std::io;

    // rust: pub trait LiquidCollisionWorld {
    // rust: type Error;
pub fn entity_liquid_shape(self: *Self, entity: EntityIdentity) R;
pub fn fluid(self: *Self, position: BlockPos) R;
    // rust: fn entity_can_stand(
    // rust: &mut self,
    // rust: entity: EntityIdentity,
    // rust: fluid: FluidState,
    // rust: ) -> Result<bool, Self::Error>;
}

pub const LiquidCollision = struct {
    fluid: FluidState,
};
    // rust: impl LiquidCollision {
pub fn from_state(state: *BlockState) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !matches!(state.name.as_str(), "minecraft:water" | "minecraft:lava") {
    // rust: return Ok(None);
}
    // rust: Ok(Some(Self {
    // rust: fluid: FluidState::from_block(state)?,
    // rust: }))
}

    // rust: pub fn shape<W: LiquidCollisionWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: BlockPos,
    // rust: context: &CollisionContext<'_>,
    // rust: ) -> Result<VoxelShape, W::Error> {
    // rust: if context.always_collide_with_fluid() {
    // rust: return Ok(VoxelShape::block());
}
    // rust: if !self.fluid.is_source() {
    // rust: return Ok(VoxelShape::empty());
}
    // rust: let Some(entity) = context.living_entity() else {
    // rust: return Ok(VoxelShape::empty());
}
    // rust: let shape = world.entity_liquid_shape(entity)?;
    // rust: if context.is_above(&shape, position, true) {
            // The above-block query precedes the entity callback, even if the
            // candidate shape is empty or the two fluid types are equivalent.
    // rust: let above = world.fluid(position.offset(0, 1, 0))?;
    // rust: if context.can_stand_on_fluid(above, self.fluid, |entity, fluid| {
    // rust: world.entity_can_stand(entity, fluid)
    // rust: })? {
    // rust: return Ok(shape);
}
}
    // rust: Ok(VoxelShape::empty())
}
}
