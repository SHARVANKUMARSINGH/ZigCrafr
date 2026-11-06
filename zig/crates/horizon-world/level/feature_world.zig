//! Transpiled from Horizon Rust crate
//! Module: horizon-world_feature_world
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The live level as a feature-placement world (`ServerLevel` passed to
//! `Feature.place`): reads and writes go through the behaviour library, so
//! features placed by saplings, fungi and bone meal get vanilla's
//! `Level.setBlock` update semantics for the flags they request.
// use super::{LevelAccess, Sim, data::state_flags, update::rel};
// use crate::{
    // rust: fluid::{FluidKind, FluidState},
    // rust: heightmap::HeightmapType,
    // rust: registry::BlockStateId,
    // rust: worldgen::{
    // rust: anchor::WorldGenerationContext,
    // rust: biome::BiomeId,
    // rust: feature::FeatureWorld,
    // rust: live::LiveFeatures,
    // rust: placement::{LayerBlock, PlacementContext, PlacementQueryError},
    // rust: },
}
// use horizon_core::{geometry::Direction, position::BlockPos, random::RandomSource};

    // rust: pub(crate) struct LevelFeatureWorld<'s, 'a, L: LevelAccess + ?Sized> {
    // rust: pub sim: &'s mut Sim<'a, L>,
    // rust: pub features: &'s LiveFeatures,
    /// The entities a structure template placed (`add_entity`), for the caller
    /// to spawn.
    // rust: pub entities: Vec<crate::nbt::Compound>,
}

pub fn pos(z]: [i32; 3]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockPos::new(x, y, z)
}

    // rust: impl<L: LevelAccess + ?Sized> LevelFeatureWorld<'_, '_, L> {
pub fn sea(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.sim.level.dimension() {
    // rust: super::Dimension::Nether => 32,
    // rust: super::Dimension::End => 0,
    // rust: super::Dimension::Overworld => 63,
}
}
pub fn in_tag(self: *Self, state: BlockStateId, tag: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = tag.trim_start_matches('#');
    // rust: self.sim
    // rust: .b
    // rust: .tag(name)
    // rust: .is_some_and(|set| set.contains(self.sim.b.block(state)))
}
}

    // rust: impl<L: LevelAccess + ?Sized> FeatureWorld for LevelFeatureWorld<'_, '_, L> {
    // rust: type Error = PlacementQueryError;
pub fn block(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.state(pos(position)))
}
    // rust: fn set_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: flags: i32,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: Ok(self.sim.set_block(pos(position), state, flags))
}
}

    // rust: impl<L: LevelAccess + ?Sized> PlacementContext for LevelFeatureWorld<'_, '_, L> {
    /// `BlockEntity.loadWithComponents` on the block a template just placed.
    // rust: fn set_block_entity(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: nbt: crate::nbt::Compound,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.sim.level.load_block_entity(pos(position), nbt);
    // rust: Ok(())
}
pub fn add_entity(self: *Self, nbt: crate::nbt::Compound) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entities.push(nbt);
    // rust: Ok(())
}
    /// `StructureTemplate.updateShapeAtEdge` for one face.
    // rust: fn update_shape_at_face(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: flags: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let place = pos(position);
    // rust: let neighbour_pos = rel(place, direction);
    // rust: let state = self.sim.state(place);
    // rust: let neighbour = self.sim.state(neighbour_pos);
    // rust: let new_state = self
    // rust: .sim
    // rust: .update_shape(state, place, direction, neighbour_pos, neighbour);
    // rust: if new_state != state {
    // rust: self.sim.set_block(place, new_state, flags & !1);
}
    // rust: let new_neighbour = self.sim.update_shape(
    // rust: neighbour,
    // rust: neighbour_pos,
    // rust: direction.opposite(),
    // rust: place,
    // rust: new_state,
    // rust: );
    // rust: if new_neighbour != neighbour {
    // rust: self.sim.set_block(neighbour_pos, new_neighbour, flags & !1);
}
    // rust: Ok(())
}
    /// `StructureTemplate.placeInWorld`'s pass over a placed block:
    /// `Block.updateFromNeighbourShapes`, written with `flags` when it
    /// changes, then `ServerLevel.updateNeighborsAt` for the new block.
    // rust: fn update_from_neighbour_shapes(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: flags: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let place = pos(position);
    // rust: let state = self.sim.state(place);
    // rust: let new_state = self.sim.update_from_neighbour_shapes(state, place);
    // rust: if new_state != state {
    // rust: self.sim.set_block(place, new_state, flags);
}
    // rust: let block = self.sim.b.block(new_state);
    // rust: self.sim.update_neighbors_at(place, block);
    // rust: Ok(())
}
    // rust: fn set_section_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.sim.level.set_raw(pos(position), state);
    // rust: Ok(())
}
    /// LevelChunk.setBlockState without neighbour or shape updates.
    // rust: fn set_chunk_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.sim.set_block(pos(position), state, 2 | 16);
    // rust: Ok(())
}
    // rust: fn collision_full_block(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Ok(self.sim.b.full_collision(state))
}
pub fn world_seed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.level.world_seed())
}
    // rust: fn state_collision_empty(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Ok(self.sim.b.has_flag(state, state_flags::COLLISION_EMPTY))
}
pub fn can_occlude(self: *Self, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.b.has_flag(state, state_flags::CAN_OCCLUDE))
}
    /// BeehiveDecorator's bees go into the nest's block entity (the tree
    /// checked the nest is there).
    // rust: fn store_beehive_occupants(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: ticks_in_hive: &[i32],
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let nbt = crate::worldgen::tree::beehive_occupants(ticks_in_hive);
    // rust: self.sim.level.load_block_entity(pos(position), nbt);
    // rust: Ok(())
}
    /// Live levels hold no loot-table containers placed by these features.
    // rust: fn set_block_entity_loot_table(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: _table: &str,
    // rust: _random: &mut impl RandomSource,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: Ok(())
}
pub fn block_brightness(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.level.block_light(pos(position)))
}
pub fn fluid_state(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.fluid_at(pos(position)))
}
    // rust: fn destroy_block_without_entity(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: drop_resources: bool,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Ok(self
    // rust: .sim
    // rust: .destroy_block(pos(position), drop_resources, super::flags::UPDATE_LIMIT))
}
pub fn sea_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sea())
}
    // rust: fn schedule_fluid_tick(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: fluid: FluidKind,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.sim.schedule_fluid_tick(pos(position), fluid, delay);
    // rust: Ok(())
}
    /// Live chunks are already post-processed.
pub fn mark_postprocessing(self: *Self, _position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn water_at(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = self.sim.fluid_at(pos(position)).kind();
    // rust: Ok(self.sim.b.is_water_fluid(kind))
}
    // rust: fn attachment_at(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let neighbour = self.sim.state(rel(pos(position), direction));
    // rust: Ok(self.sim.b.multiface_can_attach(neighbour, direction))
}
pub fn next_world_boolean(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.random().next_boolean())
}
pub fn next_world_float(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.random().next_float())
}
pub fn next_world_int(self: *Self, bound: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sim
    // rust: .random()
    // rust: .next_int_bound(bound)
    // rust: .map_err(|e| PlacementQueryError::Failed(e.to_string()))
}
    // rust: fn schedule_block_tick(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: block: BlockStateId,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let block = self.sim.b.block(block);
    // rust: self.sim.schedule_tick(pos(position), block, delay);
    // rust: Ok(())
}
    // rust: fn block_survives(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Ok(self.sim.can_survive(state, pos(position)))
}
    // rust: fn state_face_sturdy(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: _position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Ok(self.sim.b.is_face_sturdy(state, direction))
}
    // rust: fn face_sturdy(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let state = self.sim.state(pos(position));
    // rust: Ok(self.sim.b.is_face_sturdy(state, direction))
}
    // rust: fn center_sturdy(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let state = self.sim.state(pos(position));
    // rust: Ok(self.sim.b.is_face_sturdy_center(state, direction))
}
pub fn unobstructed_block(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stone = self.sim.b.default_of(self.sim.b.named.stone);
    // rust: Ok(self.sim.level.is_unobstructed(pos(position), stone))
}
pub fn biome_identity(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sim
    // rust: .level
    // rust: .biome_name(pos(position))
    // rust: .and_then(|name| self.features.biome_id(name))
    // rust: .ok_or(PlacementQueryError::Unavailable)
}
pub fn block_state(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.state(pos(position)))
}
    // rust: fn block_matches_tag(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: tag: &str,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let state = self.sim.state(pos(position));
    // rust: Ok(self.in_tag(state, tag))
}
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.level.max_y() - 1)
}
pub fn layer_block(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.sim.state(pos(position));
    // rust: let b = self.sim.b;
    // rust: let block = b.block(state);
    // rust: Ok(
    // rust: if b.is_air(state) || block == b.named.water || block == b.named.lava {
    // rust: LayerBlock::Empty
    // rust: } else if b.table.name(state) == "minecraft:bedrock" {
    // rust: LayerBlock::Bedrock
    // rust: } else {
    // rust: LayerBlock::Ground
    // rust: },
    // rust: )
}
pub fn generation(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let min_y = self.sim.level.min_y();
    // rust: WorldGenerationContext::new(min_y, self.sim.level.max_y() - min_y, self.sea())
}
pub fn min_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sim.level.min_y())
}
    /// `Level.getHeight(type, x, z)`: one above the highest matching block.
pub fn height(self: *Self, kind: HeightmapType, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (min, max) = (self.sim.level.min_y(), self.sim.level.max_y());
    // rust: for y in (min..max).rev() {
    // rust: let state = self.sim.state(BlockPos::new(x, y, z));
    // rust: let fluid = self.sim.b.fluid(state).kind() != FluidKind::Empty;
    // rust: let matches = match kind {
    // rust: HeightmapType::WorldSurface | HeightmapType::WorldSurfaceWg => {
    // rust: !self.sim.b.is_air(state)
}
    // rust: HeightmapType::OceanFloor | HeightmapType::OceanFloorWg => {
    // rust: self.in_tag(state, "minecraft:blocks_motion_in_heightmap")
}
    // rust: HeightmapType::MotionBlocking => {
    // rust: fluid || self.in_tag(state, "minecraft:blocks_motion_in_heightmap")
}
    // rust: HeightmapType::MotionBlockingNoLeaves => {
    // rust: fluid || self.in_tag(state, "minecraft:blocks_motion_in_heightmap_no_leaves")
}
}
    // rust: if matches {
    // rust: return Ok(y + 1);
}
}
    // rust: Ok(min)
}
}
