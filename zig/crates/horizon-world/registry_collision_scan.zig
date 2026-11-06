//! Transpiled from Horizon Rust crate
//! Module: horizon-world_registry_collision_scan
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Bind the native cursor to actual registry behavior and chunk providers.
// use crate::{
    // rust: block_collision::{CollisionQueryError, DynamicCollisionWorld},
    // rust: block_collision_scan::{BlockCollisionWorld, CollisionBlock},
    // rust: collision_context::CollisionContext,
    // rust: liquid_collision::LiquidCollisionWorld,
    // rust: powder_snow_collision::PowderSnowWorld,
    // rust: registry::BlockStateId,
    // rust: suffocation::SuffocationRegistry,
}
// use horizon_core::{
    // rust: geometry::VoxelShape,
    // rust: position::{BlockPos, ChunkPos},
}

/// A collision world's resident chunk access. State IDs must belong to the
/// binding's registry. Handles remain valid for the
/// duration of a scan. The chunk-local block-entity provider is deliberately
/// distinct from the global world used for contextual collision shapes.
    // rust: pub trait CollisionChunks: DynamicCollisionWorld {
    // rust: type Chunk: Copy;
    // rust: type ChunkWorld: DynamicCollisionWorld<Error = Self::Error>;
pub fn collision_chunk(self: *Self, position: ChunkPos) R;
    // rust: fn block_state(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: position: BlockPos,
    // rust: ) -> Result<BlockStateId, Self::Error>;
    /// Borrowing the provider must not perform a world query. Constant
    /// suffocation predicates do not read any block entity.
pub fn chunk_world(self: *Self, chunk: Self::Chunk) *;
}

pub const RegistryCollisionWorld = struct {
    binding: *'a SuffocationRegistry<'r>,
    world: *'a mut W,
};
    // rust: impl<'a, 'r, W> RegistryCollisionWorld<'a, 'r, W> {
pub fn new(binding: *'a SuffocationRegistry<'r>, world: *'a mut W) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !binding
    // rust: .collisions()
    // rust: .cached_shapes()
    // rust: .has_canonical_identities()
    // rust: {
    // rust: return Err(crate::compression::invalid(
    // rust: "collision scanning requires canonical shape identities",
    // rust: ));
}
    // rust: Ok(Self { binding, world })
}
}
    // rust: impl<W, E> BlockCollisionWorld for RegistryCollisionWorld<'_, '_, W>
    // rust: where
    // rust: W: CollisionChunks<Error = E> + LiquidCollisionWorld<Error = E> + PowderSnowWorld<Error = E>,
    // rust: {
    // rust: type Error = CollisionQueryError<E>;
    // rust: type Chunk = W::Chunk;
pub fn collision_chunk(self: *Self, position: ChunkPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world
    // rust: .collision_chunk(position)
    // rust: .map_err(CollisionQueryError::Context)
}
    // rust: fn collision_block(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: position: BlockPos,
    // rust: ) -> Result<CollisionBlock, Self::Error> {
    // rust: let state = self
    // rust: .world
    // rust: .block_state(chunk, position)
    // rust: .map_err(CollisionQueryError::Context)?;
    // rust: self.binding
    // rust: .collisions()
    // rust: .collision_block(state)
    // rust: .map_err(CollisionQueryError::Data)
}
    // rust: fn is_suffocating(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: block: CollisionBlock,
    // rust: position: BlockPos,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: self.binding.is_suffocating(
    // rust: self.world.chunk_world(chunk),
    // rust: block.state,
    // rust: [position.x, position.y, position.z],
    // rust: )
}
    // rust: fn context_shape(
    // rust: &mut self,
    // rust: block: CollisionBlock,
    // rust: position: BlockPos,
    // rust: context: &CollisionContext<'_>,
    // rust: ) -> Result<VoxelShape, Self::Error> {
    // rust: self.binding.collisions().collision_shape_with_context(
    // rust: self.world,
    // rust: block.state,
    // rust: position,
    // rust: context,
    // rust: )
}
}

    // rust: impl<W: crate::world_movement::EntityMovementWorld> crate::world_movement::EntityMovementWorld
    // rust: for RegistryCollisionWorld<'_, '_, W>
    // rust: {
    // rust: type Error = CollisionQueryError<W::Error>;
    // rust: fn entity_collisions(
    // rust: &mut self,
    // rust: entity: crate::entity_obstruction::EntityIdentity,
    // rust: bounds: horizon_core::geometry::Aabb,
    // rust: ) -> Result<Vec<VoxelShape>, Self::Error> {
    // rust: self.world
    // rust: .entity_collisions(entity, bounds)
    // rust: .map_err(CollisionQueryError::Context)
}
    // rust: fn movement_border(
    // rust: &mut self,
    // rust: entity: crate::entity_obstruction::EntityIdentity,
    // rust: bounds: horizon_core::geometry::Aabb,
    // rust: ) -> Result<Option<VoxelShape>, Self::Error> {
    // rust: self.world
    // rust: .movement_border(entity, bounds)
    // rust: .map_err(CollisionQueryError::Context)
}
}

    // rust: impl<W: crate::fluid_occupancy::FluidOccupancyWorld> crate::fluid_occupancy::FluidOccupancyWorld
    // rust: for RegistryCollisionWorld<'_, '_, W>
    // rust: {
    // rust: type Error = CollisionQueryError<W::Error>;
    // rust: type Chunk = W::Chunk;
pub fn minimum_section_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world
    // rust: .minimum_section_y()
    // rust: .map_err(CollisionQueryError::Context)
}
pub fn maximum_section_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world
    // rust: .maximum_section_y()
    // rust: .map_err(CollisionQueryError::Context)
}
pub fn chunk(self: *Self, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.chunk(x, z).map_err(CollisionQueryError::Context)
}
    // rust: fn section(
    // rust: &mut self,
    // rust: chunk: Self::Chunk,
    // rust: y: i32,
    // rust: ) -> Result<&crate::chunk::BlockSection<'_>, Self::Error> {
    // rust: self.world
    // rust: .section(chunk, y)
    // rust: .map_err(CollisionQueryError::Context)
}
pub fn minimum_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.minimum_y().map_err(CollisionQueryError::Context)
}
pub fn maximum_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.maximum_y().map_err(CollisionQueryError::Context)
}
}
