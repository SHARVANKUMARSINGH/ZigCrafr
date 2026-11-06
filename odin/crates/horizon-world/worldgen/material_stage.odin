//! Transpiled from Horizon Rust crate
package horizon_world_material_stage

import "core:fmt"
import "core:mem"
import "core:math"

// Surface-stage column traversal and pre-lighting chunk writes.
// use super::{
    // rust: DecodeError,
    // rust: anchor::WorldGenerationContext,
    // rust: material_condition::{
    // rust: CompiledSurfaceRule, MaterialConditions, MaterialDensitySources, MaterialRule,
    // rust: MaterialRuleError, MaterialSurfaceQueries,
    // rust: },
    // rust: material_extensions::{ExtensionError, MaterialColumn, MaterialExtensions},
    // rust: terrain::{ColumnBounds, TerrainBlockStates, TerrainChunk, TerrainError},
}
// use crate::{
    // rust: heightmap::{HeightmapState, HeightmapType},
    // rust: registry::BlockStateId,
}
// use horizon_core::{
    // rust: density::{DensitySampler, SamplerContext},
    // rust: noise::DensityVolume,
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use std::sync::Arc;

SurfaceInputs :: struct {
    generation: WorldGenerationContext,
    noise_volume: DensityVolume,
    root: R::Positional,
    surface: S,
    preliminary_surface: ^dyn DensitySampler,
    density_context: ^'a mut SamplerContext,
    // Inclusive generation write bounds, contained within the chunk.
    write_min_y: i32,
    write_max_y: i32,
}
TopMaterialInputs :: struct {
    generation: WorldGenerationContext,
    root: R::Positional,
    surface: S,
    preliminary_surface: ^dyn DensitySampler,
    density_context: ^'a mut SamplerContext,
}
SurfaceError :: enum {
    Terrain(TerrainError),
    Rule(MaterialRuleError),
    Decode(DecodeError),
    InvalidBounds,
    InvalidVolume,
    IterationLimit,
}
    // rust: impl std::fmt::Display for SurfaceError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: write!(f, "{self:?}")
}
}
    // rust: impl std::error::Error for SurfaceError {}
    // rust: impl From<TerrainError> for SurfaceError {
from :: proc(e: TerrainError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Terrain(e)
}
}
    // rust: impl From<MaterialRuleError> for SurfaceError {
from :: proc(e: MaterialRuleError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Rule(e)
}
}
    // rust: impl From<DecodeError> for SurfaceError {
from :: proc(e: DecodeError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Decode(e)
}
}
    // rust: impl From<ExtensionError<SurfaceError>> for SurfaceError {
from :: proc(e: ExtensionError<SurfaceError>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match e {
    // rust: ExtensionError::Column(e) => e,
    // rust: ExtensionError::IterationLimit => Self::IterationLimit,
}
}
}

// What the surface walk tells blocks apart by.
BlockKind :: enum {
    Air,
    Fluid,
    Solid,
}
    // rust: impl BlockKind {
    // rust: fn of<B: TerrainBlockStates>(chunk: &TerrainChunk<'_, B>, state: BlockStateId) -> Self {
    // rust: Self::from_properties(chunk.block_properties(state))
}
from_properties :: proc(properties: impl HeightmapState) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if properties.is_air() {
    // rust: Self::Air
    // rust: } else if properties.has_fluid() {
    // rust: Self::Fluid
    // rust: } else {
    // rust: Self::Solid
}
}
}
// One column's resolved blocks and their kinds, refilled per column and
// kept across columns.
ColumnCache :: struct {
    states: [dynamic]BlockStateId,
    kinds: [dynamic]BlockKind,
}
Column :: struct {
    chunk: ^'a mut TerrainChunk<'r,
    x: i32,
    z: i32,
    min: i32,
    max: i32,
    // Blocks `low..=high`, updated by `set_block`. The surface walk reads a
    // column twice (top to bottom, then the stone-depth look-behind); the
    // palette decode and property lookup are paid once per block.
    cache: ^'a mut ColumnCache,
    low: i32,
    high: i32,
    // This column's `TerrainChunk::worldgen_column_bounds`: most writes are
    // far below the heightmaps and need no update.
    bounds: Maybe(ColumnBounds),
}
    // rust: impl<'a, 'r, B: TerrainBlockStates> Column<'a, 'r, B> {
    // rust: fn new(
    // rust: chunk: &'a mut TerrainChunk<'r, B>,
    // rust: x: i32,
    // rust: z: i32,
    // rust: min: i32,
    // rust: max: i32,
    // rust: top: i32,
    // rust: cache: &'a mut ColumnCache,
    // rust: ) -> Self {
    // rust: let chunk_min = chunk.min_y();
    // rust: let chunk_max = chunk_min.wrapping_add(chunk.height()).wrapping_sub(1);
    // rust: let high = top.min(chunk_max);
    // rust: let low = min.max(chunk_min);
    // rust: cache.states.clear();
    // rust: cache.kinds.clear();
    // rust: if high >= low {
    // rust: let count = (high - low + 1) as usize;
    // rust: cache.states.reserve(count);
    // rust: cache.kinds.reserve(count);
            // An all-air or one-state section part comes as one run, and runs
            // of one state share a kind lookup.
    // rust: let blocks: &TerrainChunk<'r, B> = chunk;
    // rust: let mut last = None;
    // rust: blocks.column_runs(x, z, low, high, |state, run| {
    // rust: let kind = match last {
    // rust: Some((seen, kind)) if seen == state => kind,
    // rust: _ => {
    // rust: let kind = BlockKind::of(blocks, state);
    // rust: last = Some((state, kind));
    // rust: kind
}
}
    // rust: cache.states.extend(std::iter::repeat_n(state, run));
    // rust: cache.kinds.extend(std::iter::repeat_n(kind, run));
    // rust: });
}
    // rust: let bounds = chunk.worldgen_column_bounds(x, z);
    // rust: Self {
    // rust: chunk,
    // rust: x,
    // rust: z,
    // rust: min,
    // rust: max,
    // rust: cache,
    // rust: low,
    // rust: high,
    // rust: bounds,
}
}
cache_index :: proc(self: ^Self, y: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (y >= self.low && y <= self.high).then(|| (y - self.low) as usize)
}
kind :: proc(self: ^Self, y: i32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match self.cache_index(y) {
    // rust: Some(index) => self.cache.kinds[index],
    // rust: None => BlockKind::of(self.chunk, self.chunk.block(self.x, y, self.z)),
}
}
}
    // rust: impl<B: TerrainBlockStates> MaterialColumn for Column<'_, '_, B> {
    // rust: type Error = SurfaceError;
block :: proc(self: ^Self, y: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match self.cache_index(y) {
    // rust: Some(index) => self.cache.states[index],
    // rust: None => self.chunk.block(self.x, y, self.z),
    // rust: })
}
set_block :: proc(self: ^Self, y: i32, state: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if y >= self.min && y <= self.max {
    // rust: let properties = self.chunk.block_properties(state);
            // Most of the Nether's rule writes netherrack over netherrack.
    // rust: if self.block(y)? != state {
    // rust: self.chunk
    // rust: .set_block_worldgen_column(self.x, y, self.z, state, &mut self.bounds)?;
    // rust: if let Some(index) = self.cache_index(y) {
    // rust: self.cache.states[index] = state;
    // rust: self.cache.kinds[index] = BlockKind::from_properties(properties);
}
}
    // rust: if properties.has_fluid() {
    // rust: self.chunk.mark_postprocessing(self.x, y, self.z);
}
}
    // rust: Ok(())
}
is_air :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.chunk.block_properties(state).is_air()
}
same_block :: proc(self: ^Self, left: BlockStateId, right: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.chunk.same_block(left, right)
}
}
    // rust: fn first_available<B: TerrainBlockStates>(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Result<i32, SurfaceError> {
    // rust: if chunk.heightmap(HeightmapType::WorldSurfaceWg).is_none() {
    // rust: chunk.prime_heightmaps(&[HeightmapType::WorldSurfaceWg])?;
}
    // rust: chunk
    // rust: .heightmap(HeightmapType::WorldSurfaceWg)
    // rust: .unwrap()
    // rust: .first_available(x, z)
    // rust: .map_err(TerrainError::from)
    // rust: .map_err(SurfaceError::from)
}
tick :: proc(remaining: ^uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if *remaining == 0 {
    // rust: return Err(SurfaceError::IterationLimit);
}
    // rust: *remaining -= 1;
    // rust: Ok(())
}

// Apply a compiled top-material rule at one position with a worker the caller
// built once. Carvers restore many cells per pass, so the rule is compiled and
// the density bindings created once instead of per restored block.
    // rust: pub(crate) fn top_material_cell<
    // rust: R: RandomSource,
    // rust: S: MaterialSurfaceQueries,
    // rust: B: TerrainBlockStates,
    // rust: >(
    // rust: worker: &mut MaterialConditions<R, S>,
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: rule: usize,
    // rust: position: BlockPos,
    // rust: submerged: bool,
    // rust: ) -> Result<Option<BlockStateId>, SurfaceError> {
    // rust: let (lx, lz) = (position.x & 15, position.z & 15);
    // rust: let gx = first_available(chunk, (lx + 1).min(15), lz)?.wrapping_sub(first_available(
    // rust: chunk,
    // rust: (lx - 1).max(0),
    // rust: lz,
    // rust: )?);
    // rust: let gz = first_available(chunk, lx, (lz + 1).min(15))?.wrapping_sub(first_available(
    // rust: chunk,
    // rust: lx,
    // rust: (lz - 1).max(0),
    // rust: )?);
    // rust: worker.update_xz(position.x, position.z, gx, gz);
    // rust: worker.update_y(
    // rust: 1,
    // rust: 1,
    // rust: if submerged {
    // rust: position.y.wrapping_add(1)
    // rust: } else {
    // rust: i32::MIN
    // rust: },
    // rust: position.y,
    // rust: );
    // rust: worker.try_apply(rule, position).map_err(SurfaceError::from)
}

// Evaluate the replacement surface under a carved block. Each call binds a
// fresh one-cell material context, without restricting possible biomes, and
// uses one stone block above/below. The caller applies the returned state.
// Required heightmaps may be primed; block values are not changed here.
// The caller's density context is retained on successful and failed evaluation.
    // rust: pub fn top_material<R: RandomSource, S: MaterialSurfaceQueries, B: TerrainBlockStates>(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: rule: MaterialRule,
    // rust: inputs: TopMaterialInputs<'_, R, S>,
    // rust: position: BlockPos,
    // rust: submerged: bool,
    // rust: ) -> Result<Option<BlockStateId>, SurfaceError> {
    // rust: let volume = DensityVolume::new([1; 3], [position.x, position.y, position.z], [1; 3])
    // rust: .map_err(|_| SurfaceError::InvalidVolume)?;
    // rust: let mut sources = MaterialDensitySources::new(
    // rust: inputs.surface,
    // rust: volume,
    // rust: inputs.preliminary_surface,
    // rust: SamplerContext::default(),
    // rust: )?;
    // rust: std::mem::swap(sources.sampler_context_mut(), inputs.density_context);
    // rust: let mut worker = MaterialConditions::<R, _>::with_possible_biomes(
    // rust: inputs.generation,
    // rust: inputs.root,
    // rust: sources,
    // rust: None,
    // rust: );
    // rust: let result = (|| {
    // rust: let rule = worker.add_rule(rule)?;
    // rust: top_material_cell(&mut worker, chunk, rule, position, submerged)
    // rust: })();
    // rust: let (_, mut context) = worker.into_surface().into_parts();
    // rust: std::mem::swap(&mut context, inputs.density_context);
    // rust: result
}

// Build one chunk's surface in vanilla X/Z/descending-Y order. Required heightmaps
// are updated during writes, so later columns observe earlier modifications.
// Providers, rule roots, extensions and random settings must belong to one world.
// Failures retain prior chunk writes and fluid postprocessing entries.
    // rust: pub fn build_surface<R: RandomSource, S: MaterialSurfaceQueries, B: TerrainBlockStates>(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: rule: MaterialRule,
    // rust: inputs: SurfaceInputs<'_, R, S>,
    // rust: extensions: &MaterialExtensions<R::Positional>,
    // rust: ) -> Result<(), SurfaceError>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    // rust: build_surface_shared(chunk, &rule, &mut None, inputs, extensions)
}
// `build_surface` with the rule compiled once for the chunks `shared` serves
// (`MaterialConditions::add_shared_rule`): one world's, one worker's.
    // rust: pub fn build_surface_shared<R: RandomSource, S: MaterialSurfaceQueries, B: TerrainBlockStates>(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: rule: &MaterialRule,
    // rust: shared: &mut Option<CompiledSurfaceRule<R>>,
    // rust: inputs: SurfaceInputs<'_, R, S>,
    // rust: extensions: &MaterialExtensions<R::Positional>,
    // rust: ) -> Result<(), SurfaceError>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    // rust: let min = chunk.min_y();
    // rust: let max = min + chunk.height() - 1;
    // rust: if inputs.write_min_y < min
    // rust: || inputs.write_max_y > max
    // rust: || inputs.write_min_y > inputs.write_max_y
    // rust: {
    // rust: return Err(SurfaceError::InvalidBounds);
}
    // rust: let highest = chunk
    // rust: .highest_filled_section_index()
    // rust: .map_or(min - 1, |i| min + (i as i32) * 16 + 15);
    // The ore veins' densities are sampled up front, all over one volume so
    // that their shared nodes' caches hit. Above the highest y a vein can
    // place a block at, no density is asked for. Cutting the volume's top
    // keeps every value below it (interpolation steps up from each cell's
    // bottom).
    // rust: let top = highest.min(rule.ore_vein_top());
    // rust: let sizes = inputs.noise_volume.sizes();
    // rust: let origin = inputs.noise_volume.minimum();
    // rust: let height = top.wrapping_sub(origin[1]).wrapping_add(1).max(1);
    // rust: let expected = DensityVolume::new([sizes[0] as i32, height, sizes[2] as i32], origin, [1; 3])
    // rust: .map_err(|_| SurfaceError::InvalidVolume)?;
    // rust: let mut sources = MaterialDensitySources::new(
    // rust: inputs.surface,
    // rust: expected,
    // rust: inputs.preliminary_surface,
    // rust: SamplerContext::default(),
    // rust: )?;
    // rust: std::mem::swap(sources.sampler_context_mut(), inputs.density_context);
    // rust: let mut worker = MaterialConditions::<R, _>::new(inputs.generation, inputs.root, sources);
    // rust: let result = build_columns(
    // rust: chunk,
    // rust: rule,
    // rust: shared,
    // rust: &mut worker,
    // rust: extensions,
    // rust: inputs.write_min_y,
    // rust: inputs.write_max_y,
    // rust: );
    // rust: let (_, mut context) = worker.into_surface().into_parts();
    // rust: std::mem::swap(&mut context, inputs.density_context);
    // rust: result
}
    // rust: fn build_columns<R: RandomSource, S: MaterialSurfaceQueries, B: TerrainBlockStates>(
    // rust: chunk: &mut TerrainChunk<'_, B>,
    // rust: rule: &MaterialRule,
    // rust: shared: &mut Option<CompiledSurfaceRule<R>>,
    // rust: worker: &mut MaterialConditions<R, S>,
    // rust: extensions: &MaterialExtensions<R::Positional>,
    // rust: write_min_y: i32,
    // rust: write_max_y: i32,
    // rust: ) -> Result<(), SurfaceError>
    // rust: where
    // rust: R::Positional: Clone,
    // rust: {
    // rust: let min = chunk.min_y();
    // rust: let rule = worker.add_shared_rule(rule, shared)?;
    // rust: let mut variants = worker.surface_variants(rule)?;
    // rust: let cx = chunk.position().x.wrapping_shl(4);
    // rust: let cz = chunk.position().z.wrapping_shl(4);
    // One block buffer, refilled per column and kept across columns.
    // rust: let mut cache = ColumnCache::default();
    // rust: for lx in 0..16 {
    // rust: for lz in 0..16 {
    // rust: let x = cx.wrapping_add(lx);
    // rust: let z = cz.wrapping_add(lz);
    // rust: let original_top = first_available(chunk, lx, lz)?;
    // rust: let biome = worker
    // rust: .biome_at(BlockPos::new(x, original_top, z))?
    // rust: .ok_or(MaterialRuleError::MissingBiome)?;
    // rust: if biome.as_ref() == "minecraft:eroded_badlands" {
    // rust: extensions.eroded_badlands(
    // rust: &mut Column::new(
    // rust: chunk,
    // rust: x,
    // rust: z,
    // rust: write_min_y,
    // rust: write_max_y,
    // rust: original_top,
    // rust: &mut cache,
    // rust: ),
    // rust: x,
    // rust: z,
    // rust: original_top,
    // rust: min,
    // rust: )?;
}
    // rust: let top = first_available(chunk, lx, lz)?;
    // rust: let gx = first_available(chunk, (lx + 1).min(15), lz)?.wrapping_sub(first_available(
    // rust: chunk,
    // rust: (lx - 1).max(0),
    // rust: lz,
    // rust: )?);
    // rust: let gz = first_available(chunk, lx, (lz + 1).min(15))?.wrapping_sub(first_available(
    // rust: chunk,
    // rust: lx,
    // rust: (lz - 1).max(0),
    // rust: )?);
    // rust: worker.update_xz(x, z, gx, gz);
    // rust: let mut above = 0i32;
    // rust: let mut water = i32::MIN;
    // rust: let mut bottom = i32::MAX;
    // rust: let mut y = top;
    // rust: let mut budget = 1 << 20;
            // The walk descends, so the band only steps down.
    // rust: let mut band = variants.band(top);
    // rust: let mut band_low = variants.band_bounds(band)[0];
            // The column's minimum surface level, read once when first needed.
    // rust: let mut minimum = None;
    // rust: let mut column = Column::new(chunk, x, z, write_min_y, write_max_y, top, &mut cache);
    // rust: while y >= min {
    // rust: tick(&mut budget)?;
    // rust: match column.kind(y) {
    // rust: BlockKind::Air => {
    // rust: above = 0;
    // rust: water = i32::MIN;
}
    // rust: BlockKind::Fluid => {
    // rust: if water == i32::MIN {
    // rust: water = y.wrapping_add(1);
}
}
    // rust: BlockKind::Solid => {
    // rust: if bottom >= y {
    // rust: bottom = -32512; // DimensionType.MIN_Y << 4 for 26.3.
    // rust: let mut below = y.wrapping_sub(1);
    // rust: while below >= min - 1 {
    // rust: tick(&mut budget)?;
    // rust: if column.kind(below) != BlockKind::Solid {
    // rust: bottom = below.wrapping_add(1);
    // rust: break;
}
    // rust: below = below.wrapping_sub(1);
}
}
    // rust: above = above.wrapping_add(1);
    // rust: if y >= write_min_y && y <= write_max_y {
    // rust: let surface = variants.surface
    // rust: && y >= match minimum {
    // rust: Some(level) => level,
    // rust: None => *minimum.insert(worker.minimum_surface_level()?),
}
    // rust: while y < band_low {
    // rust: band -= 1;
    // rust: band_low = variants.band_bounds(band)[0];
}
                            // Where the rule gives no block, the block's context
                            // is not needed: each application sets its own first.
    // rust: if let Some(rule) = worker.surface_variant(&mut variants, band, surface)
    // rust: {
    // rust: worker.update_y(
    // rust: above,
    // rust: y.wrapping_sub(bottom).wrapping_add(1),
    // rust: water,
    // rust: y,
    // rust: );
    // rust: if let Some(state) =
    // rust: worker.try_apply(rule, BlockPos::new(x, y, z))?
    // rust: {
    // rust: column.set_block(y, state)?;
}
}
}
}
}
    // rust: y = y.wrapping_sub(1);
}
    // rust: if matches!(
    // rust: biome.as_ref(),
    // rust: "minecraft:frozen_ocean" | "minecraft:deep_frozen_ocean"
    // rust: ) {
    // rust: let minimum = worker.minimum_surface_level()?;
    // rust: extensions.frozen_ocean_with_melt(
    // rust: &mut column,
    // rust: [x, z],
    // rust: original_top,
    // rust: minimum,
    // rust: |position, sea| {
    // rust: worker
    // rust: .melts_frozen_ocean(&biome, position, sea)
    // rust: .map_err(SurfaceError::from)
    // rust: },
    // rust: )?;
}
}
}
    // rust: Ok(())
}
