//! Transpiled from Horizon Rust crate
//! Module: horizon-world_terrain
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Noise-stage chunk filling. Material rules, structures and chunk lifecycle are
//! separate stages; this module does not produce a complete generated chunk.
// use super::aquifer::{
    // rust: AquiferBlockStates, AquiferError, DisabledAquifer, FluidPicker, NoiseBasedAquifer,
}
// use crate::{
    // rust: chunk::BlockSection,
    // rust: heightmap::{Heightmap, HeightmapChunk, HeightmapError, HeightmapState, HeightmapType},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::{
    // rust: density::{DensitySampler, SampleError, SamplerContext},
    // rust: noise::DensityVolume,
    // rust: position::ChunkPos,
    // rust: random::PositionalRandom,
    // rust: ticks::ProtoChunkTicks,
}
// use std::{cell::RefCell, io};

    // rust: thread_local! {
pub const SCRATCH_DENSITY: RefCell<std.ArrayList(f32)> = const { RefCell::new(Vec::new()) };
}

/// Behavior and resolved tags for every state in the chunk's immutable registry.
    // rust: pub trait TerrainBlockStates {
    // rust: type State: HeightmapState;
pub fn heightmap_state(self: *Self, id: BlockStateId) S;
}

    // rust: pub trait TerrainAquifer {
    // rust: fn compute_substance(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: density: f64,
    // rust: ) -> Result<Option<BlockStateId>, AquiferError>;
pub fn should_schedule_fluid_update(self: *Self) b;
    /// The y above which every non-positive density is the aquifer's air. The
    /// fill skips those blocks without asking the aquifer; `None` keeps the
    /// per-block call for aquifers whose global fluid can vary with x/z.
pub fn air_above_y(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
    /// The fill decided this block without the aquifer (positive density or air
    /// above its skip height). Both old paths cleared the pending fluid update.
pub fn note_skipped(self: *Self) void {
}
}
    // rust: impl<P: FluidPicker> TerrainAquifer for DisabledAquifer<P> {
    // rust: fn compute_substance(
    // rust: &mut self,
    // rust: _: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: density: f64,
    // rust: ) -> Result<Option<BlockStateId>, AquiferError> {
    // rust: Ok(DisabledAquifer::compute_substance(self, position, density))
}
pub fn should_schedule_fluid_update(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
}
    // rust: impl<P: FluidPicker, F: PositionalRandom, B: AquiferBlockStates> TerrainAquifer
    // rust: for NoiseBasedAquifer<P, F, B>
    // rust: {
    // rust: fn compute_substance(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: density: f64,
    // rust: ) -> Result<Option<BlockStateId>, AquiferError> {
    // rust: NoiseBasedAquifer::compute_substance(self, context, position, density)
}
pub fn should_schedule_fluid_update(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NoiseBasedAquifer::should_schedule_fluid_update(self)
}
pub fn air_above_y(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NoiseBasedAquifer::air_above_y(self)
}
pub fn note_skipped(self: *Self) void {
}
    // rust: NoiseBasedAquifer::note_skipped(self);
}
}

pub const TerrainError = enum {
    Storage(io::Error),
    Heightmap(HeightmapError),
    Sample(SampleError),
    Aquifer(AquiferError),
    MissingAir,
    InvalidState,
    InvalidVolume,
    OutsideBuildHeight,
};
    // rust: impl std::fmt::Display for TerrainError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "{self:?}")
}
}
    // rust: impl std::error::Error for TerrainError {}
    // rust: impl From<io::Error> for TerrainError {
pub fn from(value: io::Error) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Storage(value)
}
}
    // rust: impl From<HeightmapError> for TerrainError {
pub fn from(value: HeightmapError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Heightmap(value)
}
}
    // rust: impl From<SampleError> for TerrainError {
pub fn from(value: SampleError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Sample(value)
}
}
    // rust: impl From<AquiferError> for TerrainError {
pub fn from(value: AquiferError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Aquifer(value)
}
}

/// Resident registry-backed sections, optional heightmaps and ordered per-section
/// fluid postprocessing offsets for the noise and surface generation stages.
pub const TerrainChunk = struct {
    stage: PreLightChunkStage,
    below_zero_retrogen: ?crate::retrogen::BelowZeroRetrogen,
    position: ChunkPos,
    blocks: TerrainBlocks<'r,
    heightmaps: [?Heightmap,
    postprocessing: std.ArrayList(Vec<u16)>,
    block_ticks: ProtoChunkTicks,
    fluid_ticks: ProtoChunkTicks,
};
/// The persisted generation statuses before lighting initialization. This models
/// status-dependent storage and upgrade cleanup, not scheduling, lighting or
/// save-dirty notifications.
pub const PreLightChunkStage = enum {
    Empty,
    StructureStarts,
    StructureReferences,
    Biomes,
    Terrain,
    Features,
};
    // rust: impl PreLightChunkStage {
    // rust: pub const ALL: [Self; 6] = [
    // rust: Self::Empty,
    // rust: Self::StructureStarts,
    // rust: Self::StructureReferences,
    // rust: Self::Biomes,
    // rust: Self::Terrain,
    // rust: Self::Features,
    // rust: ];
pub fn status(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::chunk_status::ChunkStatus::ALL[self as usize]
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.status().name().strip_prefix("minecraft:").unwrap()
}
pub fn heightmaps(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.status().heightmaps()
}
}
pub const TerrainBlocks = struct {
    min_y: i32,
    height: i32,
    sections: std.ArrayList(BlockSection<'r)>,
    non_air: std.ArrayList(u16),
    registry: *'r BlockRegistry,
    properties: B,
    air: BlockStateId,
    void_air: BlockStateId,
};
    // rust: impl<B: TerrainBlockStates> HeightmapChunk for TerrainBlocks<'_, B> {
    // rust: type State = B::State;
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y
}
pub fn height(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.height
}
pub fn highest_section_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.non_air
    // rust: .iter()
    // rust: .rposition(|&count| count != 0)
    // rust: .map_or(self.min_y, |i| self.min_y + i as i32 * 16)
}
pub fn block_state(self: *Self, x: i32, y: i32, z: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.properties.heightmap_state(self.block(x, y, z))
}
}
    // rust: impl<B: TerrainBlockStates> TerrainBlocks<'_, B> {
pub fn section_index(self: *Self, y: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dy = i64::from(y) - i64::from(self.min_y);
    // rust: (dy >= 0 && dy < i64::from(self.height)).then_some((dy >> 4) as usize)
}
pub fn block(self: *Self, x: i32, y: i32, z: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(section) = self.section_index(y) else {
    // rust: return self.void_air;
}
    // rust: if self.non_air[section] == 0 {
    // rust: return self.air;
}
    // rust: self.sections[section].state(local_index(x, y, z))
}
    /// Every state of section `index` in `local_index` order, as `block`
    /// reads them one by one.
pub fn section_states(self: *Self, index: usize, out: *mut [u32; 4096]) void {
}
    // rust: if self.non_air[index] == 0 {
    // rust: out.fill(self.air.0);
    // rust: } else {
    // rust: self.sections[index].fill_states(out);
}
}
}
pub fn local_index(x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (((y & 15) << 8) | ((z & 15) << 4) | (x & 15)) as usize
}

/// `TerrainChunk::worldgen_column_bounds`, indexed by `HeightmapType`.
    // rust: pub(crate) type ColumnBounds = [i32; HeightmapType::ALL.len()];

    // rust: impl<'r, B: TerrainBlockStates> TerrainChunk<'r, B> {
    /// Its heap bytes by part (`horizon-ctl memory`; scheduled ticks not
    /// counted): packed block storage, the sections' palettes and lists,
    /// heightmaps, and the rest (post-processing marks, non-air counts).
pub fn heap_bytes(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let blocks = &self.blocks;
    // rust: let [mut storage, mut lists] = [
    // rust: 0,
    // rust: blocks.sections.capacity() * std::mem::size_of::<BlockSection<'_>>(),
    // rust: ];
    // rust: for section in &blocks.sections {
    // rust: let [s, l] = section.heap_bytes();
    // rust: storage += s;
    // rust: lists += l;
}
    // rust: [
    // rust: storage,
    // rust: lists,
    // rust: self.heightmaps
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(Heightmap::heap_bytes)
    // rust: .sum(),
    // rust: blocks.non_air.capacity() * std::mem::size_of::<u16>()
    // rust: + self.postprocessing.capacity() * std::mem::size_of::<Vec<u16>>()
    // rust: + self
    // rust: .postprocessing
    // rust: .iter()
    // rust: .map(|p| p.capacity() * std::mem::size_of::<u16>())
    // rust: .sum::<usize>(),
    // rust: ]
}
    /// How many of its sections pack their blocks at each bit width (index
    /// = bits, 0 = a single state).
pub fn storage_bits(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bits = [0; 16];
    // rust: for section in &self.blocks.sections {
    // rust: bits[usize::from(section.storage_bits()).min(15)] += 1;
}
    // rust: bits
}
    // rust: pub fn new(
    // rust: position: ChunkPos,
    // rust: min_y: i32,
    // rust: height: i32,
    // rust: registry: &'r BlockRegistry,
    // rust: properties: B,
    // rust: ) -> Result<Self, TerrainError> {
        // Share the heightmap's supported range and fail before allocating sections.
    // rust: Heightmap::new(HeightmapType::WorldSurfaceWg, min_y, height)?;
    // rust: let air = registry
    // rust: .default_state("minecraft:air")
    // rust: .ok_or(TerrainError::MissingAir)?;
    // rust: let void_air = registry
    // rust: .default_state("minecraft:void_air")
    // rust: .ok_or(TerrainError::MissingAir)?;
    // rust: let section_count = (height / 16) as usize;
    // rust: let sections = (0..section_count)
    // rust: .map(|_| BlockSection::uniform(air, registry))
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: Ok(Self {
    // rust: stage: PreLightChunkStage::Empty,
    // rust: below_zero_retrogen: None,
    // rust: position,
    // rust: blocks: TerrainBlocks {
    // rust: min_y,
    // rust: height,
    // rust: sections,
    // rust: non_air: vec![0; section_count],
    // rust: registry,
    // rust: properties,
    // rust: air,
    // rust: void_air,
    // rust: },
    // rust: heightmaps: std::array::from_fn(|_| None),
    // rust: postprocessing: vec![Vec::new(); section_count],
    // rust: block_ticks: ProtoChunkTicks::default(),
    // rust: fluid_ticks: ProtoChunkTicks::default(),
    // rust: })
}
    // rust: pub(crate) fn registry(&self) -> &BlockRegistry {
    // rust: self.blocks.registry
}
    /// The indexes of the sections holding a block other than air
    /// (`LevelChunkSection.hasOnlyAir`, negated).
pub fn filled_sections(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..self.blocks.non_air.len()).filter(|&i| self.blocks.non_air[i] != 0)
}
pub fn highest_filled_section_index(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.non_air.iter().rposition(|&count| count != 0)
}
pub fn block_properties(self: *Self, state: BlockStateId) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.properties.heightmap_state(state)
}
pub fn same_block(self: *Self, left: BlockStateId, right: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks
    // rust: .registry
    // rust: .state(left)
    // rust: .zip(self.blocks.registry.state(right))
    // rust: .is_some_and(|(left, right)| left.name == right.name)
}
pub fn generation_stage(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stage
}
    /// Retained old terrain may already have completed stages that the new
    /// below-zero generation has not reached. Biome reads use this status.
pub fn highest_generated_status(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.below_zero_retrogen
    // rust: .as_ref()
    // rust: .map_or(self.stage.status(), |data| {
    // rust: self.stage.status().max(data.target_status())
    // rust: })
}
    /// Changing status alone does not prime or clear any heightmaps. Native
    /// persisted-status assignment also permits earlier statuses. Reaching an
    /// installed upgrade target clears its metadata; save-dirty tracking is separate.
pub fn set_generation_stage(self: *Self, stage: PreLightChunkStage) void {
}
    // rust: self.stage = stage;
    // rust: if self
    // rust: .below_zero_retrogen
    // rust: .as_ref()
    // rust: .is_some_and(|data| stage.status() >= data.target_status())
    // rust: {
    // rust: self.below_zero_retrogen = None;
}
}
pub fn below_zero_retrogen(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.below_zero_retrogen.as_ref()
}
    /// Installation alone does not compare the target with the current status.
    /// A subsequent persisted-stage assignment performs completion cleanup.
pub fn set_below_zero_retrogen(self: *Self, data: ?crate::retrogen::BelowZeroRetrogen) void {
}
    // rust: self.below_zero_retrogen = data;
}
pub fn is_upgrading(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.below_zero_retrogen.is_some()
}
    /// Generation minimum Y and height. Storage bounds remain unchanged.
pub fn height_for_generation(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_upgrading() {
    // rust: (-64, 64)
    // rust: } else {
    // rust: (self.min_y(), self.height())
}
}
    /// ProtoChunk writes before lighting. The current stage selects heightmaps;
    /// missing maps are primed after existing maps are updated.
    // rust: pub fn set_block_worldgen(
    // rust: &mut self,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: state: BlockStateId,
    // rust: ) -> Result<BlockStateId, TerrainError> {
    // rust: let Some(section) = self.blocks.section_index(y) else {
    // rust: return Ok(self.blocks.void_air);
}
    // rust: if self.blocks.non_air[section] == 0 && state == self.blocks.air {
    // rust: return Ok(state);
}
    // rust: let previous = self.set_block_raw(x, y, z, state)?;
    // rust: let mut missing = Vec::new();
    // rust: for &kind in self.stage.heightmaps() {
    // rust: match self.heightmap(kind) {
                // `Heightmap::update` would return at once: no state is read.
    // rust: Some(map) if map.below_update(&self.blocks, x & 15, y, z & 15) => {
    // rust: if self.blocks.registry.state(state).is_none() {
    // rust: return Err(TerrainError::InvalidState);
}
}
    // rust: Some(_) => {
    // rust: self.update_heightmap(kind, x & 15, y, z & 15, state)?;
}
    // rust: None => missing.push(kind),
}
}
    // rust: if !missing.is_empty() {
    // rust: self.prime_heightmaps(&missing)?;
}
    // rust: Ok(previous)
}
    /// Per stage heightmap (indexed by `HeightmapType`), the highest y at
    /// which a write cannot change it in column `x`, `z`: its first available
    /// y - 2 (`Heightmap::update`). `None` when a stage map is missing.
    // rust: pub(crate) fn worldgen_column_bounds(&self, x: i32, z: i32) -> Option<ColumnBounds> {
    // rust: let mut bounds = [i32::MAX; HeightmapType::ALL.len()];
    // rust: for &kind in self.stage.heightmaps() {
    // rust: bounds[kind as usize] = self
    // rust: .heightmap(kind)?
    // rust: .first_available(x & 15, z & 15)
    // rust: .ok()?
    // rust: .wrapping_sub(2);
}
    // rust: Some(bounds)
}
    /// `set_block_worldgen` for writes in one column, with that column's
    /// `worldgen_column_bounds`: updates at or below a map's bound, which
    /// change nothing, are not made. Refreshes `bounds` when a map changes.
    // rust: pub(crate) fn set_block_worldgen_column(
    // rust: &mut self,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: state: BlockStateId,
    // rust: bounds: &mut Option<ColumnBounds>,
    // rust: ) -> Result<BlockStateId, TerrainError> {
    // rust: let Some(limits) = bounds else {
            // A missing map is primed by the general path.
    // rust: let previous = self.set_block_worldgen(x, y, z, state)?;
    // rust: *bounds = self.worldgen_column_bounds(x, z);
    // rust: return Ok(previous);
}
    // rust: let Some(section) = self.blocks.section_index(y) else {
    // rust: return Ok(self.blocks.void_air);
}
    // rust: if self.blocks.non_air[section] == 0 && state == self.blocks.air {
    // rust: return Ok(state);
}
        // `BlockSection::set` rejects a state outside the registry first.
    // rust: let previous = self.set_block_raw(x, y, z, state)?;
    // rust: let (x, z) = (x & 15, z & 15);
    // rust: let properties = self.blocks.properties.heightmap_state(state);
    // rust: for &kind in self.stage.heightmaps() {
    // rust: if y <= limits[kind as usize] {
    // rust: continue;
}
    // rust: let map = self.heightmaps[kind as usize]
    // rust: .as_mut()
    // rust: .expect("bounds are taken from present maps");
    // rust: if map.update(&self.blocks, x, y, z, properties)? {
    // rust: limits[kind as usize] = map.first_available(x, z)?.wrapping_sub(2);
}
}
    // rust: Ok(previous)
}
pub fn position(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.position
}
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.min_y
}
pub fn height(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.height
}
pub fn highest_section_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.highest_section_y()
}
    /// ProtoChunk reads collapse an all-air section to its default AIR state.
pub fn block(self: *Self, x: i32, y: i32, z: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.block(x, y, z)
}
    /// The states of the 16-block section starting at block `y` (a multiple
    /// of 16 inside this chunk), in `(y << 8) | (z << 4) | x` order, read in
    /// one pass; false (and `out` untouched) when `y` is not such a start.
pub fn section_states(self: *Self, y: i32, out: *mut [u32; 4096]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.blocks.section_index(y) {
    // rust: Some(index) if y & 15 == 0 => {
    // rust: self.blocks.section_states(index, out);
    // rust: true
}
    // rust: _ => false,
}
}
    /// `FeatureWorld::scan_column` in this chunk: an all-air section is
    /// tested once, a mixed one read without looking the section up per block.
    // rust: pub fn scan_column(
    // rust: &self,
    // rust: [x, mut y, z]: [i32; 3],
    // rust: step: i32,
    // rust: mut limit: i32,
    // rust: mut keep: impl FnMut(BlockStateId) -> bool,
    // rust: ) -> i32 {
    // rust: debug_assert!(step == 1 || step == -1);
    // rust: let blocks = &self.blocks;
    // rust: while limit > 0 {
    // rust: let Some(section) = blocks.section_index(y) else {
    // rust: if !keep(blocks.void_air) {
    // rust: return y;
}
    // rust: y = y.wrapping_add(step);
    // rust: limit -= 1;
    // rust: continue;
}
            // Blocks from y to this section's end in the walk's direction.
    // rust: let within = (y - blocks.min_y) & 15;
    // rust: let run = if step > 0 { 16 - within } else { within + 1 }.min(limit);
    // rust: limit -= run;
    // rust: if blocks.non_air[section] == 0 {
    // rust: if !keep(blocks.air) {
    // rust: return y;
}
    // rust: y = y.wrapping_add(step * run);
    // rust: continue;
}
    // rust: let storage = &blocks.sections[section];
    // rust: for _ in 0..run {
    // rust: if !keep(storage.state(local_index(x, y, z))) {
    // rust: return y;
}
    // rust: y = y.wrapping_add(step);
}
}
    // rust: y
}
    /// The blocks of column `x`, `z` from `low` up to `high`, as
    /// `visit(state, count)` runs: an all-air or one-state section's part at
    /// once, a mixed section's blocks one by one from its storage. The same
    /// states `block` reads.
    // rust: pub(crate) fn column_runs(
    // rust: &self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: low: i32,
    // rust: high: i32,
    // rust: mut visit: impl FnMut(BlockStateId, usize),
    // rust: ) {
    // rust: let blocks = &self.blocks;
    // rust: let mut y = low;
    // rust: while y <= high {
    // rust: let Some(section) = blocks.section_index(y) else {
    // rust: visit(blocks.void_air, 1);
    // rust: if y == high {
    // rust: break;
}
    // rust: y += 1;
    // rust: continue;
}
            // To this section's top, or `high`.
    // rust: let end = y.wrapping_add(15 - ((y - blocks.min_y) & 15)).min(high);
    // rust: let run = (end - y + 1) as usize;
    // rust: if blocks.non_air[section] == 0 {
    // rust: visit(blocks.air, run);
    // rust: } else if let Some(state) = blocks.sections[section].uniform_state() {
    // rust: visit(state, run);
    // rust: } else {
    // rust: let storage = &blocks.sections[section];
    // rust: for y in y..=end {
    // rust: visit(storage.state(local_index(x, y, z)), 1);
}
}
    // rust: if end == i32::MAX {
    // rust: break;
}
    // rust: y = end + 1;
}
}
pub fn section(self: *Self, index: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.sections.get(index)
}
pub fn heightmap(self: *Self, kind: HeightmapType) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.heightmaps[kind as usize].as_ref()
}
pub fn block_ticks(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.block_ticks
}
pub fn block_ticks_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.block_ticks
}
pub fn fluid_ticks(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.fluid_ticks
}
pub fn fluid_ticks_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.fluid_ticks
}
pub fn postprocessing(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.postprocessing
}

pub fn ensure_heightmap(self: *Self, kind: HeightmapType) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.heightmaps[kind as usize].get_or_insert_with(|| {
    // rust: Heightmap::new(kind, self.blocks.min_y, self.blocks.height)
    // rust: .expect("validated chunk range")
    // rust: })
}
    /// Section write only. The caller chooses which generation-stage maps to update.
    // rust: pub fn set_block_raw(
    // rust: &mut self,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: state: BlockStateId,
    // rust: ) -> Result<BlockStateId, TerrainError> {
    // rust: let section = self
    // rust: .blocks
    // rust: .section_index(y)
    // rust: .ok_or(TerrainError::OutsideBuildHeight)?;
    // rust: let old = self.blocks.sections[section].set(local_index(x, y, z), state)?;
    // rust: let old_air = self.blocks.properties.heightmap_state(old).is_air();
    // rust: let new_air = self.blocks.properties.heightmap_state(state).is_air();
    // rust: if old_air && !new_air {
    // rust: self.blocks.non_air[section] += 1;
    // rust: } else if !old_air && new_air {
    // rust: self.blocks.non_air[section] -= 1;
}
    // rust: Ok(old)
}
    /// Write a vertical run of one non-air state from `y_top` downward, all
    /// inside the chunk. Returns how many blocks changed from air; section
    /// non-air counts are updated here and the caller owns the heightmaps.
    // rust: pub fn fill_solid_run(
    // rust: &mut self,
    // rust: x: i32,
    // rust: y_top: i32,
    // rust: z: i32,
    // rust: len: i32,
    // rust: state: BlockStateId,
    // rust: ) -> Result<u16, TerrainError> {
    // rust: let air = self.blocks.air;
    // rust: let mut added = 0u16;
    // rust: let mut top = y_top;
    // rust: let mut left = len;
    // rust: while left > 0 {
    // rust: let section = self
    // rust: .blocks
    // rust: .section_index(top)
    // rust: .ok_or(TerrainError::OutsideBuildHeight)?;
    // rust: let local_top = top & 15;
    // rust: let take = (local_top + 1).min(left);
    // rust: let local_start = local_top - take + 1;
    // rust: let now = self.blocks.sections[section].fill_run(
    // rust: x & 15,
    // rust: local_start,
    // rust: z & 15,
    // rust: take,
    // rust: state,
    // rust: air,
    // rust: )?;
    // rust: self.blocks.non_air[section] = self.blocks.non_air[section].saturating_add(now);
    // rust: added = added.saturating_add(now);
    // rust: top -= take;
    // rust: left -= take;
}
    // rust: Ok(added)
}
    // rust: pub fn update_heightmap(
    // rust: &mut self,
    // rust: kind: HeightmapType,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: state: BlockStateId,
    // rust: ) -> Result<bool, TerrainError> {
    // rust: if self.blocks.registry.state(state).is_none() {
    // rust: return Err(TerrainError::InvalidState);
}
    // rust: self.ensure_heightmap(kind);
    // rust: let state = self.blocks.properties.heightmap_state(state);
    // rust: Ok(self.heightmaps[kind as usize]
    // rust: .as_mut()
    // rust: .unwrap()
    // rust: .update(&self.blocks, x, y, z, state)?)
}
pub fn prime_heightmaps(self: *Self, kinds: *[HeightmapType]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut order = Vec::new();
    // rust: for &kind in kinds {
    // rust: self.ensure_heightmap(kind);
    // rust: if !order.contains(&(kind as usize)) {
    // rust: order.push(kind as usize);
}
}
        // Split references preserve the supplied set's iteration order.
    // rust: let mut maps: Vec<_> = self
    // rust: .heightmaps
    // rust: .iter_mut()
    // rust: .enumerate()
    // rust: .filter_map(|(i, map)| {
    // rust: order
    // rust: .iter()
    // rust: .position(|&key| key == i)
    // rust: .map(|position| (position, map.as_mut().unwrap()))
    // rust: })
    // rust: .collect();
    // rust: maps.sort_by_key(|(position, _)| *position);
    // rust: Heightmap::prime(
    // rust: &self.blocks,
    // rust: &mut maps.into_iter().map(|(_, map)| map).collect::<Vec<_>>(),
    // rust: )?;
    // rust: Ok(())
}
    /// Before replaying a saved chunk's `PostProcessing` lists.
pub fn clear_postprocessing(self: *Self) void {
}
    // rust: self.postprocessing.iter_mut().for_each(Vec::clear);
}
    /// Preserves duplicates and insertion order, as ProtoChunk does.
pub fn mark_postprocessing(self: *Self, x: i32, y: i32, z: i32) void {
}
    // rust: if let Some(section) = self.blocks.section_index(y) {
    // rust: self.postprocessing[section]
    // rust: .push(((x & 15) | ((y & 15) << 4) | ((z & 15) << 8)) as u16);
}
}
}

/// Evaluate final density in bulk before writes, then visit Z/X/descending Y.
/// The aquifer and final density must share this already prepared sampler context.
/// Failures retain earlier writes and aquifer/cache state; there is no rollback.
/// Regular gameplay only: developer preliminary-surface markers are not applied.
    // rust: pub fn fill_noise<B: TerrainBlockStates>(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: volume: DensityVolume,
    // rust: final_density: &dyn DensitySampler,
    // rust: context: &mut SamplerContext,
    // rust: aquifer: &mut (impl TerrainAquifer + ?Sized),
    // rust: default_block: BlockStateId,
    // rust: ) -> Result<(), TerrainError> {
    // rust: let size = volume.size();
    // rust: SCRATCH_DENSITY.with_borrow_mut(|scratch| {
    // rust: if scratch.len() < size {
    // rust: scratch.resize(size, 0.0);
}
    // rust: scratch[..size].fill(0.0);
    // rust: fill_noise_inner(
    // rust: chunk,
    // rust: volume,
    // rust: final_density,
    // rust: context,
    // rust: aquifer,
    // rust: default_block,
    // rust: &mut scratch[..size],
    // rust: )
    // rust: })
}

    // rust: fn fill_noise_inner<B: TerrainBlockStates>(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: volume: DensityVolume,
    // rust: final_density: &dyn DensitySampler,
    // rust: context: &mut SamplerContext,
    // rust: aquifer: &mut (impl TerrainAquifer + ?Sized),
    // rust: default_block: BlockStateId,
    // rust: density: &mut [f32],
    // rust: ) -> Result<(), TerrainError> {
    // rust: let [sx, sy, sz] = volume.sizes();
    // rust: let [bx, by, bz] = volume.minimum();
    // rust: if sx != 16
    // rust: || sz != 16
    // rust: || volume.steps() != [1; 3]
    // rust: || bx != chunk.position.x.wrapping_shl(4)
    // rust: || bz != chunk.position.z.wrapping_shl(4)
    // rust: || by < chunk.min_y()
    // rust: || i64::from(by) + sy as i64 > i64::from(chunk.min_y()) + i64::from(chunk.height())
    // rust: || chunk.blocks.registry.state(default_block).is_none()
    // rust: {
    // rust: return Err(TerrainError::InvalidVolume);
}
    // rust: chunk.ensure_heightmap(HeightmapType::OceanFloorWg);
    // rust: chunk.ensure_heightmap(HeightmapType::WorldSurfaceWg);
    // rust: final_density.sample_volume(context, density, volume)?;
    // rust: let air_above = aquifer.air_above_y();
    // A non-air, non-fluid default block may be written as a run without asking
    // the aquifer or touching the heightmap below the run's top.
    // rust: let solid_runs = default_block != chunk.blocks.air
    // rust: && !chunk
    // rust: .blocks
    // rust: .properties
    // rust: .heightmap_state(default_block)
    // rust: .has_fluid();
pub const MAPS: [HeightmapType; 2] = [HeightmapType::OceanFloorWg, HeightmapType::WorldSurfaceWg];
    // rust: for z in 0..sz {
    // rust: let world_z = bz.wrapping_add(z as i32);
    // rust: for x in 0..sx {
    // rust: let world_x = bx.wrapping_add(x as i32);
    // rust: let col_base = (x + z * sx) * sy;
    // rust: let col_density = &density[col_base..col_base + sy];
            // Heightmap updates at or below first-available - 2 are no-ops. In a
            // top-down vertical sweep, once an opaque block updates first-available
            // to world_y + 1, all lower blocks have world_y <= bound and can be
            // skipped entirely.
    // rust: let mut bounds = MAPS.map(|kind| {
    // rust: chunk.heightmaps[kind as usize]
    // rust: .as_ref()
    // rust: .expect("ensured heightmap")
    // rust: .first_available(x as i32, z as i32)
    // rust: .map(|first| first.wrapping_sub(2))
    // rust: });
    // rust: let mut y = sy;
    // rust: while y > 0 {
    // rust: y -= 1;
    // rust: let world_y = by.wrapping_add(y as i32);
    // rust: let value = col_density[y];
                // A positive-density run is entirely the default block. Write it
                // through the section once instead of per block; the heightmap
                // only changes at the run's top.
    // rust: if solid_runs && value > 0.0 {
    // rust: let mut run = 1usize;
    // rust: while run <= y && col_density[y - run] > 0.0 {
    // rust: run += 1;
}
    // rust: aquifer.note_skipped();
    // rust: chunk.fill_solid_run(x as i32, world_y, z as i32, run as i32, default_block)?;
    // rust: for (kind, bound) in MAPS.into_iter().zip(&mut bounds) {
    // rust: if matches!(bound, Ok(current) if world_y <= *current) {
    // rust: continue;
}
    // rust: chunk.update_heightmap(kind, x as i32, world_y, z as i32, default_block)?;
    // rust: *bound = chunk.heightmaps[kind as usize]
    // rust: .as_ref()
    // rust: .expect("ensured heightmap")
    // rust: .first_available(x as i32, z as i32)
    // rust: .map(|first| first.wrapping_sub(2));
}
    // rust: y -= run - 1;
    // rust: continue;
}
                // The aquifer answers `None` for positive density, which the fill
                // writes as the default block, and air above its skip/fluid level.
                // Both are decided here so the per-block call is not made at all,
                // with the same pending-update side effect the call had.
    // rust: let solid = value > 0.0;
    // rust: if solid {
    // rust: aquifer.note_skipped();
}
    // rust: let state = if solid {
    // rust: default_block
    // rust: } else if air_above.is_some_and(|limit| world_y > limit) {
    // rust: aquifer.note_skipped();
    // rust: continue;
    // rust: } else {
    // rust: aquifer
    // rust: .compute_substance(context, [world_x, world_y, world_z], f64::from(value))?
    // rust: .unwrap_or(default_block)
}
    // rust: if state == chunk.blocks.air {
    // rust: continue;
}
    // rust: chunk.set_block_raw(x as i32, world_y, z as i32, state)?;
    // rust: for (kind, bound) in MAPS.into_iter().zip(&mut bounds) {
    // rust: if matches!(bound, Ok(current) if world_y <= *current) {
    // rust: continue;
}
    // rust: chunk.update_heightmap(kind, x as i32, world_y, z as i32, state)?;
    // rust: *bound = chunk.heightmaps[kind as usize]
    // rust: .as_ref()
    // rust: .expect("ensured heightmap")
    // rust: .first_available(x as i32, z as i32)
    // rust: .map(|first| first.wrapping_sub(2));
}
    // rust: if aquifer.should_schedule_fluid_update()
    // rust: && chunk.blocks.properties.heightmap_state(state).has_fluid()
    // rust: {
    // rust: chunk.mark_postprocessing(world_x, world_y, world_z);
}
}
}
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use crate::nbt::Tag;
//     use crate::worldgen::aquifer::FluidPicker;
//     use horizon_core::density::ConstantSampler;

pub const State = struct {};
    // rust: impl HeightmapState for State {
pub fn is_air(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 < 2
}
pub fn is_air_block(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 == 0
}
pub fn has_fluid(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 == 3
}
pub fn blocks_motion_in_heightmap(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 == 2
}
pub fn blocks_motion_in_heightmap_no_leaves(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 == 2
}
}
pub const Properties = struct {};
    // rust: impl TerrainBlockStates for Properties {
    // rust: type State = State;
pub fn heightmap_state(self: *Self, id: BlockStateId) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: State(id.0)
}
}
pub const TestPicker = struct {};
    // rust: impl FluidPicker for TestPicker {
pub fn compute(self: *Self, _: [i32; 3]) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::worldgen::aquifer::FluidStatus {
    // rust: level: -64,
    // rust: state: BlockStateId(3),
}
}
}

pub fn test_registry() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(crate::DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![
    // rust: Tag::compound([("id", Tag::String("minecraft:air".into()))]),
    // rust: Tag::compound([("id", Tag::String("minecraft:void_air".into()))]),
    // rust: Tag::compound([("id", Tag::String("minecraft:stone".into()))]),
    // rust: Tag::compound([("id", Tag::String("minecraft:water".into()))]),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound([
    // rust: ("minecraft:air", Tag::Int(0)),
    // rust: ("minecraft:void_air", Tag::Int(1)),
    // rust: ("minecraft:stone", Tag::Int(2)),
    // rust: ("minecraft:water", Tag::Int(3)),
    // rust: ]),
    // rust: ),
    // rust: ]))
    // rust: .unwrap()
}

pub fn fill_noise_poisoned_scratch_does_not_leak() void {
}
    // rust: let registry = test_registry();
    // rust: let volume = DensityVolume::new([16, 384, 16], [0, -64, 0], [1, 1, 1]).unwrap();
    // rust: let sampler = ConstantSampler(1.0);
    // rust: let mut context = SamplerContext::sparse();

    // rust: let mut chunk_clean =
    // rust: TerrainChunk::new(ChunkPos::new(0, 0), -64, 384, &registry, Properties).unwrap();
    // rust: let mut aquifer_clean = DisabledAquifer::new(TestPicker, BlockStateId(0));
    // rust: fill_noise(
    // rust: &mut chunk_clean,
    // rust: volume,
    // rust: &sampler,
    // rust: &mut context,
    // rust: &mut aquifer_clean,
    // rust: BlockStateId(2),
    // rust: )
    // rust: .unwrap();

        // Deliberately poison the thread-local scratch buffer with NaN
    // rust: SCRATCH_DENSITY.with_borrow_mut(|scratch| {
    // rust: scratch.fill(f32::NAN);
    // rust: });

    // rust: let mut chunk_poisoned =
    // rust: TerrainChunk::new(ChunkPos::new(0, 0), -64, 384, &registry, Properties).unwrap();
    // rust: let mut aquifer_poisoned = DisabledAquifer::new(TestPicker, BlockStateId(0));
    // rust: fill_noise(
    // rust: &mut chunk_poisoned,
    // rust: volume,
    // rust: &sampler,
    // rust: &mut context,
    // rust: &mut aquifer_poisoned,
    // rust: BlockStateId(2),
    // rust: )
    // rust: .unwrap();

    // rust: for (sec1, sec2) in chunk_clean
    // rust: .blocks
    // rust: .sections
    // rust: .iter()
    // rust: .zip(&chunk_poisoned.blocks.sections)
    // rust: {
    // rust: for idx in 0..4096 {
    // rust: assert_eq!(sec1.get(idx).unwrap(), sec2.get(idx).unwrap());
}
}
    // rust: for (h1, h2) in chunk_clean
    // rust: .heightmaps
    // rust: .iter()
    // rust: .zip(&chunk_poisoned.heightmaps)
    // rust: {
    // rust: assert_eq!(
    // rust: h1.as_ref().map(|m| m.raw_data()),
    // rust: h2.as_ref().map(|m| m.raw_data())
    // rust: );
}
}

pub fn fill_noise_heightmap_matches_top_down_surface() void {
}
    // rust: let registry = test_registry();
    // rust: let volume = DensityVolume::new([16, 384, 16], [0, -64, 0], [1, 1, 1]).unwrap();
    // rust: let sampler = ConstantSampler(1.0);
    // rust: let mut context = SamplerContext::sparse();

    // rust: let mut chunk =
    // rust: TerrainChunk::new(ChunkPos::new(0, 0), -64, 384, &registry, Properties).unwrap();
    // rust: let mut aquifer = DisabledAquifer::new(TestPicker, BlockStateId(0));
    // rust: fill_noise(
    // rust: &mut chunk,
    // rust: volume,
    // rust: &sampler,
    // rust: &mut context,
    // rust: &mut aquifer,
    // rust: BlockStateId(2),
    // rust: )
    // rust: .unwrap();

    // rust: let ocean_floor = chunk.heightmaps[HeightmapType::OceanFloorWg as usize]
    // rust: .as_ref()
    // rust: .unwrap();
    // rust: let world_surface = chunk.heightmaps[HeightmapType::WorldSurfaceWg as usize]
    // rust: .as_ref()
    // rust: .unwrap();
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: assert_eq!(ocean_floor.first_available(x, z).unwrap(), 320);
    // rust: assert_eq!(world_surface.first_available(x, z).unwrap(), 320);
}
}
}

pub fn benchmark_fill_noise() void {
}
//         use std::time::Instant;
    // rust: let registry = test_registry();

    // rust: let volume = DensityVolume::new([16, 384, 16], [0, -64, 0], [1, 1, 1]).unwrap();
    // rust: let sampler = ConstantSampler(1.0);
    // rust: let mut context = SamplerContext::sparse();

    // rust: let iters = 50;
    // rust: let start = Instant::now();
    // rust: for _ in 0..iters {
    // rust: let mut chunk =
    // rust: TerrainChunk::new(ChunkPos::new(0, 0), -64, 384, &registry, Properties).unwrap();
    // rust: let mut aquifer = DisabledAquifer::new(TestPicker, BlockStateId(0));
    // rust: fill_noise(
    // rust: &mut chunk,
    // rust: volume,
    // rust: &sampler,
    // rust: &mut context,
    // rust: &mut aquifer,
    // rust: BlockStateId(2),
    // rust: )
    // rust: .unwrap();
}
    // rust: let elapsed = start.elapsed();
    // rust: println!(
    // rust: "benchmark_fill_noise ({} chunks, 384 height): {:?} total, {:.2} ms/chunk",
    // rust: iters,
    // rust: elapsed,
    // rust: elapsed.as_secs_f64() * 1000.0 / iters as f64
    // rust: );
}
}
