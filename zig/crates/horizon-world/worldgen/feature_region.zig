//! Transpiled from Horizon Rust crate
//! Module: horizon-world_feature_region
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resident pre-light chunks shared by modifier queries and feature mutations.
//! The caller supplies world write policy/effects; storage alone cannot implement
//! neighbor updates, block entities, POIs or lighting.
// use super::{
    // rust: anchor::WorldGenerationContext,
    // rust: biome_chunk::{BiomeRegion, BiomeRegionError},
    // rust: feature::FeatureWorld,
    // rust: placement::{LayerBlock, PlacementContext, PlacementQueryError},
    // rust: terrain::{TerrainBlockStates, TerrainChunk, TerrainError},
}
// use crate::{
    // rust: fluid::FluidKind,
    // rust: heightmap::{HeightmapState, HeightmapType},
    // rust: registry::BlockStateId,
    // rust: tick_data::TickKind,
}
// use horizon_core::{
    // rust: position::BlockPos,
    // rust: ticks::{
    // rust: ProtoChunkTicks, ScheduledTick, TickPriority, TickTypeId, WorldGenTickAccess,
    // rust: WorldGenTickContainers,
    // rust: },
}
// use std::{collections::HashMap, sync::Arc};

pub const RegionBlockQueries = struct {
    fluids: super::fluid_predicate::FluidPredicateBindings,
    tags: *super::block_feature::BoundTags,
};

pub const RegionError = enum {
    InvalidChunks,
    InvalidBindings,
    InvalidTickState(BlockStateId),
    MissingChunk([i32; 2]),
    Terrain(TerrainError),
    Biome(BiomeRegionError),
    BiomesNotGenerated([i32; 2]),
};
    // rust: impl std::fmt::Display for RegionError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "{self:?}")
}
}
    // rust: impl std::error::Error for RegionError {}
    // rust: impl From<TerrainError> for RegionError {
pub fn from(error: TerrainError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Terrain(error)
}
}
    // rust: impl From<RegionError> for PlacementQueryError {
pub fn from(error: RegionError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Failed(error.to_string())
}
}
pub const TerrainRegion = struct {
    /// Ordered by X then Z.
    chunks: Vec<TerrainChunk<'r,
    /// Each chunk's index in `chunks`: every block access looks one up.
    index: ChunkIndex,
    min_y: i32,
    height: i32,
    generation: WorldGenerationContext,
    sea_level: i32,
    game_time: i64,
    next_tick_order: i64,
    block_queries: ?RegionBlockQueries,
    world_seed: ?i64,
};
/// Where each chunk of a region sits in its list: a grid over the chunks'
/// bounding box while it is small (the usual square of neighbours), else a
/// map (chunks spread far apart).
pub const ChunkIndex = enum {
    Grid {,
    origin: (i32, i32),
    columns: i64,
    rows: i64,
        /// Row by row from `origin`; `u32::MAX` where no chunk is.
    cells: Vec<u32>,
    // rust: },
    Sparse(HashMap<(i32, i32), u32>),
};
    // rust: impl ChunkIndex {
    /// The largest grid, in chunk columns.
pub const GRID_CELLS: i64 = 1 << 20;
    /// `None` when two chunks share a position.
pub fn new(positions: *[(i32) void {
}
    // rust: let x0 = positions.iter().map(|p| p.0).min()?;
    // rust: let z0 = positions.iter().map(|p| p.1).min()?;
    // rust: let columns = i64::from(positions.iter().map(|p| p.0).max()?) - i64::from(x0) + 1;
    // rust: let rows = i64::from(positions.iter().map(|p| p.1).max()?) - i64::from(z0) + 1;
    // rust: if columns * rows > Self::GRID_CELLS {
    // rust: let mut map = HashMap::with_capacity(positions.len());
    // rust: for (i, &p) in positions.iter().enumerate() {
    // rust: if map.insert(p, i as u32).is_some() {
    // rust: return None;
}
}
    // rust: return Some(Self::Sparse(map));
}
    // rust: let mut cells = vec![u32::MAX; (columns * rows) as usize];
    // rust: for (i, &(x, z)) in positions.iter().enumerate() {
    // rust: let cell = (i64::from(z) - i64::from(z0)) * columns + (i64::from(x) - i64::from(x0));
    // rust: let cell = &mut cells[cell as usize];
    // rust: if *cell != u32::MAX {
    // rust: return None;
}
    // rust: *cell = i as u32;
}
    // rust: Some(Self::Grid {
    // rust: origin: (x0, z0),
    // rust: columns,
    // rust: rows,
    // rust: cells,
    // rust: })
}
pub fn get(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Grid {
    // rust: origin,
    // rust: columns,
    // rust: rows,
    // rust: cells,
    // rust: } => {
    // rust: let (dx, dz) = (
    // rust: i64::from(x) - i64::from(origin.0),
    // rust: i64::from(z) - i64::from(origin.1),
    // rust: );
    // rust: if !(0..*columns).contains(&dx) || !(0..*rows).contains(&dz) {
    // rust: return None;
}
    // rust: match cells[(dz * columns + dx) as usize] {
    // rust: u32::MAX => None,
    // rust: i => Some(i as usize),
}
}
    // rust: Self::Sparse(map) => map.get(&(x, z)).map(|&i| i as usize),
}
}
}
    // rust: impl<'r, B: TerrainBlockStates> TerrainRegion<'r, B> {
    // rust: pub fn new(
    // rust: chunks: Vec<TerrainChunk<'r, B>>,
    // rust: generator: WorldGenerationContext,
    // rust: ) -> Result<Self, RegionError> {
    // rust: if chunks.is_empty() || chunks.len() > 4096 {
    // rust: return Err(RegionError::InvalidChunks);
}
    // rust: let first = &chunks[0];
    // rust: let (min_y, height, registry) = (first.min_y(), first.height(), first.registry());
    // rust: if chunks.iter().any(|c| {
    // rust: c.min_y() != min_y || c.height() != height || !std::ptr::eq(c.registry(), registry)
    // rust: }) {
    // rust: return Err(RegionError::InvalidChunks);
}
    // rust: let mut chunks = chunks;
    // rust: chunks.sort_by_key(|c| (c.position().x, c.position().z));
    // rust: let positions: Vec<(i32, i32)> = chunks
    // rust: .iter()
    // rust: .map(|c| (c.position().x, c.position().z))
    // rust: .collect();
    // rust: let index = ChunkIndex::new(&positions).ok_or(RegionError::InvalidChunks)?;
    // rust: Ok(Self {
    // rust: chunks,
    // rust: index,
    // rust: sea_level: generator.sea_level,
    // rust: game_time: 0,
    // rust: next_tick_order: 0,
    // rust: block_queries: None,
    // rust: world_seed: None,
    // rust: min_y,
    // rust: height,
    // rust: generation: WorldGenerationContext::with_generator(
    // rust: min_y,
    // rust: height,
    // rust: generator.min_y,
    // rust: generator.height,
    // rust: generator.sea_level,
    // rust: ),
    // rust: })
}
    /// Bind an immutable snapshot of fluid states and resolved block/fluid tags.
    /// Tables are shared with configured features; registry identities must match.
    // rust: pub fn with_block_bindings(
    // rust: mut self,
    // rust: bindings: &super::block_feature::FeatureBlockBindings<'r>,
    // rust: ) -> Result<Self, RegionError> {
    // rust: if !std::ptr::eq(self.chunks[0].registry(), bindings.registry()) {
    // rust: return Err(RegionError::InvalidBindings);
}
    // rust: self.block_queries = Some(RegionBlockQueries {
    // rust: fluids: bindings.fluids.clone(),
    // rust: tags: bindings.tags.clone(),
    // rust: });
    // rust: Ok(self)
}
    /// Supply the world seed (WorldGenLevel.getSeed) for seed-derived features.
pub fn with_world_seed(seed: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_seed = Some(seed);
    // rust: self
}
    /// Supply the owning world's current time and region-local next tick order.
pub fn with_tick_clock(game_time: i64, next_tick_order: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game_time = game_time;
    // rust: self.next_tick_order = next_tick_order;
    // rust: self
}
pub fn tick_clock(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.game_time, self.next_tick_order)
}
    /// Raw tick identities are default block-state IDs for block ticks and
    /// `FluidKind` discriminants for fluid ticks, in separate namespaces.
    // rust: pub fn schedule_tick(
    // rust: &mut self,
    // rust: kind: TickKind,
    // rust: tick: ScheduledTick,
    // rust: ) -> Result<bool, RegionError> {
    // rust: WorldGenTickAccess::new(RegionTickContainers { region: self, kind }).schedule(tick)
}
    // rust: fn request_tick(
    // rust: &mut self,
    // rust: kind: TickKind,
    // rust: position: [i32; 3],
    // rust: tick_type: TickTypeId,
    // rust: delay: i32,
    // rust: ) -> Result<(), RegionError> {
    // rust: let tick = ScheduledTick {
    // rust: kind: tick_type,
    // rust: pos: BlockPos::new(position[0], position[1], position[2]),
    // rust: trigger_tick: self.game_time.wrapping_add(i64::from(delay)),
    // rust: priority: TickPriority::Normal,
    // rust: sub_tick_order: self.next_tick_order,
}
    // rust: self.next_tick_order = self.next_tick_order.wrapping_add(1);
    // rust: self.schedule_tick(kind, tick)?;
    // rust: Ok(())
}
    /// Release the resident chunks, ordered by X then Z; match them by position.
pub fn into_chunks(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks
}
pub fn chunks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks.iter()
}
pub fn index(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.index.get(x, z)
}
pub fn chunk(self: *Self, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.index(x, z) {
    // rust: Some(i) => Ok(&self.chunks[i]),
    // rust: None => Err(RegionError::MissingChunk([x, z])),
}
}
pub fn chunk_mut(self: *Self, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.index(x, z) {
    // rust: Some(i) => Ok(&mut self.chunks[i]),
    // rust: None => Err(RegionError::MissingChunk([x, z])),
}
}
pub fn block(self: *Self, z]: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.chunk(x >> 4, z >> 4)?.block(x, y, z))
}
    /// `FeatureWorld::scan_column` within one chunk's column.
    // rust: pub fn scan_column(
    // rust: &self,
    // rust: [x, y, z]: [i32; 3],
    // rust: step: i32,
    // rust: limit: i32,
    // rust: keep: impl FnMut(BlockStateId) -> bool,
    // rust: ) -> Result<i32, RegionError> {
    // rust: Ok(self
    // rust: .chunk(x >> 4, z >> 4)?
    // rust: .scan_column([x, y, z], step, limit, keep))
}
    /// Level-style biome lookup checks the selected chunk's generation status
    /// before reading its palette. Raw biome storage remains independently
    /// accessible for generation itself. Retained upgrade status permits reading
    /// old biomes before the new generation reaches the biome stage.
    // rust: pub fn biome_at<'b, T: Clone>(
    // rust: &self,
    // rust: biomes: &'b BiomeRegion<T>,
    // rust: position: BlockPos,
    // rust: ) -> Result<&'b T, RegionError> {
    // rust: self.noise_biome(biomes, biomes.quart_at_block(position))
}
    // rust: pub fn noise_biome<'b, T: Clone>(
    // rust: &self,
    // rust: biomes: &'b BiomeRegion<T>,
    // rust: quart: [i32; 3],
    // rust: ) -> Result<&'b T, RegionError> {
    // rust: let chunk = self.chunk(quart[0] >> 2, quart[2] >> 2)?;
    // rust: if chunk.highest_generated_status() < crate::chunk_status::ChunkStatus::Biomes {
    // rust: return Err(RegionError::BiomesNotGenerated([
    // rust: quart[0] >> 2,
    // rust: quart[2] >> 2,
    // rust: ]));
}
    // rust: biomes.noise_biome(quart).map_err(RegionError::Biome)
}
    /// Storage mutation only. World code must apply its write permissions,
    /// block-entity/POI effects and postprocessing around this operation.
    // rust: pub fn set_block_worldgen(
    // rust: &mut self,
    // rust: [x, y, z]: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> Result<BlockStateId, RegionError> {
    // rust: Ok(self
    // rust: .chunk_mut(x >> 4, z >> 4)?
    // rust: .set_block_worldgen(x, y, z, state)?)
}
}
pub const RegionTickContainers = struct {
    region: *'a mut TerrainRegion<'r,
    kind: TickKind,
};
    // rust: impl<B: TerrainBlockStates> WorldGenTickContainers for RegionTickContainers<'_, '_, B> {
    // rust: type Container = ProtoChunkTicks;
    // rust: type Error = RegionError;
pub fn container_at(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chunk = self.region.chunk_mut(p.x >> 4, p.z >> 4)?;
    // rust: Ok(match self.kind {
    // rust: TickKind::Block => chunk.block_ticks_mut(),
    // rust: TickKind::Fluid => chunk.fluid_ticks_mut(),
    // rust: })
}
}
    // rust: impl<B: TerrainBlockStates> PlacementContext for TerrainRegion<'_, B> {
    // rust: fn fluid_state(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: ) -> Result<crate::fluid::FluidState, PlacementQueryError> {
    // rust: let queries = self
    // rust: .block_queries
    // rust: .as_ref()
    // rust: .ok_or(PlacementQueryError::Unavailable)?;
    // rust: let state = self.block(position)?;
    // rust: queries
    // rust: .fluids
    // rust: .state(state)
    // rust: .ok_or_else(|| PlacementQueryError::Failed("fluid state outside bound registry".into()))
}
pub fn water_at(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let queries = self
    // rust: .block_queries
    // rust: .as_ref()
    // rust: .ok_or(PlacementQueryError::Unavailable)?;
    // rust: Ok(queries
    // rust: .fluids
    // rust: .state_matches_tag(self.block(position)?, "minecraft:water"))
}
    // rust: fn block_matches_tag(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: tag: &str,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let queries = self
    // rust: .block_queries
    // rust: .as_ref()
    // rust: .ok_or(PlacementQueryError::Unavailable)?;
    // rust: let state = self.block(position)?;
    // rust: Ok(queries
    // rust: .tags
    // rust: .get(tag)
    // rust: .is_some_and(|states| states.contains(&state)))
}

    // rust: fn schedule_block_tick(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: block: BlockStateId,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let registry = self.chunks[0].registry();
    // rust: let state = registry
    // rust: .state(block)
    // rust: .ok_or(RegionError::InvalidTickState(block))?;
        // Default state IDs provide one identity per block, separate from fluids.
    // rust: let block = registry
    // rust: .default_state(&state.name)
    // rust: .ok_or(RegionError::InvalidTickState(block))?;
    // rust: self.request_tick(TickKind::Block, position, TickTypeId(block.0), delay)
    // rust: .map_err(Into::into)
}
    // rust: fn schedule_fluid_tick(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: fluid: FluidKind,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.request_tick(TickKind::Fluid, position, TickTypeId(fluid as u32), delay)
    // rust: .map_err(Into::into)
}

pub fn sea_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sea_level)
}
pub fn world_seed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_seed.ok_or(PlacementQueryError::Unavailable)
}

pub fn mark_postprocessing(self: *Self, z]: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunk_mut(x >> 4, z >> 4)?.mark_postprocessing(x, y, z);
    // rust: Ok(())
}
pub fn generation(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.generation
}
pub fn block_state(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block(position).map_err(Into::into)
}
pub fn min_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.min_y)
}
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.min_y.wrapping_add(self.height).wrapping_sub(1))
}
pub fn height(self: *Self, kind: HeightmapType, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chunk = self.chunk_mut(x >> 4, z >> 4)?;
    // rust: if chunk.heightmap(kind).is_none() {
    // rust: chunk.prime_heightmaps(&[kind]).map_err(RegionError::from)?;
}
    // rust: chunk
    // rust: .heightmap(kind)
    // rust: .unwrap()
    // rust: .first_available(x & 15, z & 15)
    // rust: .map_err(|e| RegionError::from(TerrainError::from(e)).into())
}
pub fn layer_block(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chunk = self.chunk(position[0] >> 4, position[2] >> 4)?;
    // rust: let state = chunk.block(position[0], position[1], position[2]);
    // rust: let name = &chunk
    // rust: .registry()
    // rust: .state(state)
    // rust: .expect("registered chunk state")
    // rust: .name;
    // rust: Ok(
    // rust: if chunk.block_properties(state).is_air()
    // rust: || name == "minecraft:water"
    // rust: || name == "minecraft:lava"
    // rust: {
    // rust: LayerBlock::Empty
    // rust: } else if name == "minecraft:bedrock" {
    // rust: LayerBlock::Bedrock
    // rust: } else {
    // rust: LayerBlock::Ground
    // rust: },
    // rust: )
}
}
/// Gives feature algorithms and placement queries one region. All update flags
/// reach the supplied write function, which owns world mutation policy/effects.
pub const TerrainFeatureAccess = struct {
    region: *'a mut TerrainRegion<'r,
    write: F,
    write_zone: ?super::write_zone::GenerationWriteZone,
    upgrade_height: UpgradeHeightPolicy,
};
pub const UpgradeHeightPolicy = enum {
    Unrestricted,
    Fixed(super::write_zone::UpgradeWriteHeight),
    Center(horizon_core::position::ChunkPos),
};
    // rust: impl<'a, 'r, B: TerrainBlockStates, F> TerrainFeatureAccess<'a, 'r, B, F> {
pub fn new(region: *'a mut TerrainRegion<'r, write: F) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: region,
    // rust: write,
    // rust: write_zone: None,
    // rust: upgrade_height: UpgradeHeightPolicy::Unrestricted,
}
}
    /// Apply the horizontal write radius before invoking mutation policy/effects.
pub fn with_write_zone(zone: super::write_zone::GenerationWriteZone) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.write_zone = Some(zone);
    // rust: self
}
    /// Use an explicit height interval. For live generation lifecycle state,
    /// prefer `with_upgrade_center`, which observes changes made by callbacks.
pub fn with_upgrade_height(height: super::write_zone::UpgradeWriteHeight) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.upgrade_height = UpgradeHeightPolicy::Fixed(height);
    // rust: self
}
    /// Read the resident center chunk's upgrade state before each write. The
    /// target chunk's upgrade state does not select the region's write height.
    /// Horizontal write radius is configured independently with `with_write_zone`.
    // rust: pub fn with_upgrade_center(
    // rust: mut self,
    // rust: center: horizon_core::position::ChunkPos,
    // rust: ) -> Result<Self, RegionError> {
    // rust: self.region.chunk(center.x, center.z)?;
    // rust: self.upgrade_height = UpgradeHeightPolicy::Center(center);
    // rust: Ok(self)
}
}
    // rust: impl<'r, B: TerrainBlockStates, F> TerrainFeatureAccess<'_, 'r, B, F>
    // rust: where
    // rust: F: FnMut(&mut TerrainRegion<'r, B>, [i32; 3], BlockStateId, i32) -> Result<bool, RegionError>,
    // rust: {
    // rust: fn write_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: flags: i32,
    // rust: ) -> Result<bool, RegionError> {
    // rust: if !self.can_write(position)? {
    // rust: return Ok(false);
}
    // rust: (self.write)(self.region, position, state, flags)
}
}
    // rust: impl<'r, B: TerrainBlockStates, F> TerrainFeatureAccess<'_, 'r, B, F> {
    /// WorldGenRegion.ensureCanWrite without its diagnostic logging.
pub fn can_write(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.write_zone.is_some_and(|zone| {
    // rust: !zone.contains_block(BlockPos::new(position[0], position[1], position[2]))
    // rust: }) {
    // rust: return Ok(false);
}
    // rust: let height = match self.upgrade_height {
    // rust: UpgradeHeightPolicy::Unrestricted => None,
    // rust: UpgradeHeightPolicy::Fixed(height) => Some(height),
    // rust: UpgradeHeightPolicy::Center(center) => {
    // rust: let chunk = self.region.chunk(center.x, center.z)?;
    // rust: chunk.is_upgrading().then(|| {
    // rust: let (min_y, height) = chunk.height_for_generation();
    // rust: super::write_zone::UpgradeWriteHeight::new(min_y, height)
    // rust: })
}
}
    // rust: Ok(height.is_none_or(|height| height.contains(position[1])))
}
}
    // rust: impl<'r, B: TerrainBlockStates, F> PlacementContext for TerrainFeatureAccess<'_, 'r, B, F>
    // rust: where
    // rust: F: FnMut(&mut TerrainRegion<'r, B>, [i32; 3], BlockStateId, i32) -> Result<bool, RegionError>,
    // rust: {
    // rust: fn destroy_block_without_entity(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: _drop_resources: bool,
    // rust: ) -> Result<bool, PlacementQueryError> {
        // WorldGenRegion destruction is an air replacement through its write
        // policy. It does not evaluate drops, unlike live-level destruction.
    // rust: let chunk = self.region.chunk(position[0] >> 4, position[2] >> 4)?;
    // rust: let state = chunk.block(position[0], position[1], position[2]);
    // rust: if chunk.block_properties(state).is_air() {
    // rust: return Ok(false);
}
    // rust: let air = chunk
    // rust: .registry()
    // rust: .default_state("minecraft:air")
    // rust: .expect("validated air state");
    // rust: self.write_block(position, air, 3).map_err(Into::into)
}

    // rust: fn fluid_state(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: ) -> Result<crate::fluid::FluidState, PlacementQueryError> {
    // rust: self.region.fluid_state(position)
}
pub fn ensure_can_write(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.can_write(position).map_err(Into::into)
}
    // rust: fn section_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: ) -> Result<Option<BlockStateId>, PlacementQueryError> {
    // rust: if position[1] < self.region.min_y
    // rust: || position[1] >= self.region.min_y.wrapping_add(self.region.height)
    // rust: {
    // rust: return Ok(None);
}
    // rust: self.region.block(position).map(Some).map_err(Into::into)
}
    // rust: fn set_section_block(
    // rust: &mut self,
    // rust: [x, y, z]: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.region
    // rust: .chunk_mut(x >> 4, z >> 4)?
    // rust: .set_block_raw(x, y, z, state)
    // rust: .map_err(RegionError::from)?;
    // rust: Ok(())
}
    /// ProtoChunk.setBlockState: the section and the stage's heightmaps.
    // rust: fn set_chunk_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.region.set_block_worldgen(position, state)?;
    // rust: Ok(())
}
pub fn water_at(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.water_at(position)
}
    // rust: fn block_matches_tag(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: tag: &str,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: self.region.block_matches_tag(position, tag)
}

    // rust: fn schedule_block_tick(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: block: BlockStateId,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.region.schedule_block_tick(position, block, delay)
}
    // rust: fn schedule_fluid_tick(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: fluid: FluidKind,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.region.schedule_fluid_tick(position, fluid, delay)
}

pub fn sea_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.sea_level()
}
pub fn world_seed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.world_seed()
}

pub fn mark_postprocessing(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.mark_postprocessing(position)
}
pub fn generation(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.generation()
}
pub fn block_state(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.block_state(position)
}
pub fn min_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.min_y()
}
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.max_y()
}
pub fn height(self: *Self, kind: HeightmapType, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.height(kind, x, z)
}
pub fn layer_block(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.layer_block(position)
}
}
    // rust: impl<'r, B: TerrainBlockStates, F> FeatureWorld for TerrainFeatureAccess<'_, 'r, B, F>
    // rust: where
    // rust: F: FnMut(&mut TerrainRegion<'r, B>, [i32; 3], BlockStateId, i32) -> Result<bool, RegionError>,
    // rust: {
    // rust: type Error = RegionError;
pub fn block(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.block(position)
}
    // rust: fn scan_column(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: step: i32,
    // rust: limit: i32,
    // rust: keep: impl FnMut(BlockStateId) -> bool,
    // rust: ) -> Result<i32, Self::Error> {
    // rust: self.region.scan_column(position, step, limit, keep)
}
    // rust: fn set_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: flags: i32,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: self.write_block(position, state, flags)
}
}
