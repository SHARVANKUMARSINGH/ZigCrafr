//! Transpiled from Horizon Rust crate
//! Module: horizon-world_context
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Query interface for placement against a generated world.
// use crate::worldgen::feature_sort::FeatureIdentity;
// use crate::{heightmap::HeightmapType, worldgen::anchor::WorldGenerationContext};
pub const PlacementQueryError = enum {
    Unavailable,
    WorkLimit,
    Failed(String),
};
    // rust: impl std::fmt::Display for PlacementQueryError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::WorkLimit => f.write_str("predicate work limit exceeded"),
    // rust: Self::Unavailable => f.write_str("placement world query is unavailable"),
    // rust: Self::Failed(message) => f.write_str(message),
}
}
}
    // rust: impl std::error::Error for PlacementQueryError {}
/// Classification for layered placement: air states and exact WATER/LAVA blocks
/// are empty; exact BEDROCK is excluded from ground; every other block is ground.
pub const LayerBlock = enum {
    Empty,
    Bedrock,
    Ground,
};
    // rust: pub trait PlacementContext {
    /// StructureTemplate.updateShapeAtEdge for one outer face of a placed
    /// voxel shape: update the state at `position` against its neighbor in
    /// `direction`, then the neighbor against the (possibly new) state, writing
    /// changes with `flags & !1`. Worlds without block shape-update behavior
    /// accept this as a no-op.
    // rust: fn update_shape_at_face(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _direction: horizon_core::geometry::Direction,
    // rust: _flags: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Ok(())
}
    /// Block.updateFromNeighbourShapes for the state at `position`, written
    /// with `flags` when it changes, then LevelAccessor.updateNeighborsAt for
    /// the new block (a no-op outside a live level). Worlds without block
    /// shape-update behavior accept this as a no-op.
    // rust: fn update_from_neighbour_shapes(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _flags: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Ok(())
}
    /// WorldGenRegion.ensureCanWrite: horizontal write radius and upgrade height.
pub fn ensure_can_write(self: *Self, _position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(true)
}
    /// BulkSectionAccess read: None outside the world's section range.
    // rust: fn section_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: ) -> Result<Option<crate::registry::BlockStateId>, PlacementQueryError> {
    // rust: if self.outside_build_height(position[1])? {
    // rust: return Ok(None);
}
    // rust: self.block_state(position).map(Some)
}
    /// Raw LevelChunkSection write: no heightmap, light, POI or neighbor effects.
    // rust: fn set_section_block(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _state: crate::registry::BlockStateId,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// ChunkAccess.setBlockState(pos, state, false) in generation (a
    /// ProtoChunk write with its heightmaps, no neighbour or block-entity
    /// effects), as mods' structure processors write past their template.
    /// Worlds without generation chunks write the section.
    // rust: fn set_chunk_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: crate::registry::BlockStateId,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.set_section_block(position, state)
}
    /// BlockState.isCollisionShapeFullBlock for an already-read state.
    // rust: fn collision_full_block(
    // rust: &mut self,
    // rust: _state: crate::registry::BlockStateId,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Add an End crystal entity (structure spawn) at an entity position.
    // rust: fn spawn_end_crystal(
    // rust: &mut self,
    // rust: _position: [f64; 3],
    // rust: _yaw: f32,
    // rust: _beam_target: Option<[i32; 3]>,
    // rust: _invulnerable: bool,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Ok(())
}
    /// WorldGenLevel.getSeed: the world seed for seed-derived feature noise.
pub fn world_seed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Set the entity type of the spawner block entity at `position`, when one
    /// exists. The caller has already drawn the native entity choice.
    // rust: fn configure_spawner(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _entity: &str,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Ok(())
}
    /// Store worldgen beehive occupants (ticks in hive per bee) in the nest
    /// block entity at `position`. Worlds without block-entity storage drop them.
    // rust: fn store_beehive_occupants(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _ticks_in_hive: &[i32],
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Ok(())
}
    /// Test the already-read state's collision shape in an empty entity context.
    // rust: fn state_collision_empty(
    // rust: &mut self,
    // rust: _state: crate::registry::BlockStateId,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Look up a randomizable container, then consume a loot seed only when one
    /// exists. Missing or unrelated block entities are successful no-ops.
    // rust: fn set_block_entity_loot_table(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _table: &str,
    // rust: _random: &mut impl horizon_core::random::RandomSource,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}

    /// Look up the block entity at this position and set its exit only if it is
    /// an End gateway. Missing or other entities are successful no-ops. The
    /// owning world applies the gateway's dirty notification after the update.
    // rust: fn configure_end_gateway(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _exit: [i32; 3],
    // rust: _exact: bool,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}

    /// Use the previously resolved biome, retaining its temperature cache.
    // rust: fn biome_should_freeze(
    // rust: &mut self,
    // rust: _biome: crate::worldgen::biome::BiomeId,
    // rust: _position: [i32; 3],
    // rust: _require_edge: bool,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    // rust: fn biome_should_snow(
    // rust: &mut self,
    // rust: _biome: crate::worldgen::biome::BiomeId,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}

    /// Block light only, independently of sky light and sky darkening.
pub fn block_brightness(self: *Self, _position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    // rust: fn fluid_state(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<crate::fluid::FluidState, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}

    /// Request destruction with no responsible entity. The world adapter owns
    /// replacement, drops, block entities and updates; false is a rejected request.
    // rust: fn destroy_block_without_entity(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _drop_resources: bool,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}

    /// World sea level, independently of the generator's placement context.
pub fn sea_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    // rust: fn schedule_fluid_tick(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _fluid: crate::fluid::FluidKind,
    // rust: _delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Resolve the containing chunk and mark this position for postprocessing.
pub fn mark_postprocessing(self: *Self, _position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Test the current fluid at this position against the world's water tag.
pub fn water_at(self: *Self, _position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// `BlockState.canOcclude()` of a state.
    // rust: fn can_occlude(
    // rust: &mut self,
    // rust: _state: crate::registry::BlockStateId,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Multiface attachment: neighbor support, then empty-context collision.
    // rust: fn attachment_at(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _direction: horizon_core::geometry::Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Draw from the world's random stream, independently of the feature RNG.
pub fn next_world_boolean(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
pub fn next_world_float(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
pub fn next_world_int(self: *Self, _bound: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Schedule the block type identified by its registry default state.
    // rust: fn schedule_block_tick(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _block: crate::registry::BlockStateId,
    // rust: _delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}

    /// Evaluate this candidate state's survival without placing it.
    // rust: fn block_survives(
    // rust: &mut self,
    // rust: _state: crate::registry::BlockStateId,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Evaluate FULL support using an already-read state, without reading it again.
    // rust: fn state_face_sturdy(
    // rust: &mut self,
    // rust: _state: crate::registry::BlockStateId,
    // rust: _position: [i32; 3],
    // rust: _direction: horizon_core::geometry::Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Read the block state and evaluate FULL support on the requested face.
    // rust: fn face_sturdy(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _direction: horizon_core::geometry::Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Block.canSupportCenter: CENTER support on the requested face.
    // rust: fn center_sturdy(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _direction: horizon_core::geometry::Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Test entity obstruction of a unit-block shape with no excluded entity.
pub fn unobstructed_block(self: *Self, _position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    // rust: fn biome_identity(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<crate::worldgen::biome::BiomeId, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
pub fn top_feature(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
    /// Resolve the biome at this position and test its generation settings for
    /// the supplied placed feature. Registry equality/ownership belongs here.
    // rust: fn biome_allows_feature(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _feature: FeatureIdentity,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    // rust: fn block_state(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<crate::registry::BlockStateId, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Read the state at the requested position and test its block-tag identity.
    // rust: fn block_matches_tag(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _tag: &str,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Err(PlacementQueryError::Unavailable)
}
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
pub fn inside_build_height(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(position[1] >= self.min_y()? && position[1] <= self.max_y()?)
}
pub fn outside_build_height(self: *Self, y: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(y < self.min_y()? || y > self.max_y()?)
}
pub fn layer_block(self: *Self, _position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    /// Add an entity from its NBT (structure templates and pieces; `Pos` is
    /// absolute). Worlds without entity storage drop it.
pub fn add_entity(self: *Self, _nbt: crate::nbt::Compound) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
    /// Store block-entity data loaded at a just-placed block (structure
    /// templates). Worlds without block-entity storage drop it.
    // rust: fn set_block_entity(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _nbt: crate::nbt::Compound,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Ok(())
}
pub fn generation(self: *Self) W;
    /// Recreate the generation bounds for a block-predicate invocation. World
    /// adapters may perform fallible level/generator queries here; ordinary
    /// placement retains its already-created immutable generation context.
pub fn predicate_generation(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.generation())
}
    /// World minimum, which can differ from the generator's minimum.
pub fn min_y(self: *Self) R;
pub fn height(self: *Self, kind: HeightmapType, x: i32, z: i32) R;
    /// Whether any column of the square `x..=x + size`, `z..=z + size` has
    /// `height(kind)` at least `y`, read faster than column by column; `None`
    /// when the world can't (callers then ask `height` for each column).
    // rust: fn any_height_at_least(
    // rust: &mut self,
    // rust: _kind: HeightmapType,
    // rust: _corner: [i32; 2],
    // rust: _size: i32,
    // rust: _y: i32,
    // rust: ) -> Result<Option<bool>, PlacementQueryError> {
    // rust: Ok(None)
}
}
    // rust: impl PlacementContext for WorldGenerationContext {
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.min_y.wrapping_add(self.height).wrapping_sub(1))
}
pub fn generation(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self
}
pub fn min_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.min_y)
}
pub fn height(self: *Self, _: HeightmapType, _: i32, _: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
}
