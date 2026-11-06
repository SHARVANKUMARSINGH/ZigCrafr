//! Transpiled from Horizon Rust crate
package horizon_world_noise_based

import "core:fmt"
import "core:mem"
import "core:math"

// Stateful 26.3 underground fluid and pressure selection.
// use super::{AquiferField, AquiferSamplers, FluidPicker, FluidStatus};
// use crate::registry::{BlockRegistry, BlockStateId};
// use horizon_core::{
    // rust: density::{SampleError, SamplerContext},
    // rust: noise::{DensityError, DensityVolume},
    // rust: position::{BlockPos, ChunkPos},
    // rust: random::{PositionalRandom, RandomSource},
}
// use std::collections::HashMap;

WAY_BELOW_MIN_Y :: -32512
FLOWING_UPDATE_SIMILARITY :: 1.0 - 44.0 / 25.0
    // rust: const SURFACE_OFFSETS: [[i32; 2]; 13] = [
    // rust: [0, 0],
    // rust: [-2, -1],
    // rust: [-1, -1],
    // rust: [0, -1],
    // rust: [1, -1],
    // rust: [-3, 0],
    // rust: [-2, 0],
    // rust: [-1, 0],
    // rust: [1, 0],
    // rust: [-2, 1],
    // rust: [-1, 1],
    // rust: [0, 1],
    // rust: [1, 1],
    // rust: ];

// All IDs and block classifications must refer to the same immutable registry.
// Lava/water tests classify the block, whereas default-lava equality tests the
// exact state. Air tests include cave air and void air.
    // rust: pub trait AquiferBlockStates {
air :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
lava :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
is_air :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
is_lava :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
is_water :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
}
RegistryAquiferBlockStates :: struct {
    registry: ^'a BlockRegistry,
    air: BlockStateId,
    lava: BlockStateId,
}
    // rust: impl<'a> RegistryAquiferBlockStates<'a> {
new :: proc(registry: ^'a BlockRegistry) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: air: registry
    // rust: .default_state("minecraft:air")
    // rust: .ok_or(AquiferError::MissingBlock)?,
    // rust: lava: registry
    // rust: .default_state("minecraft:lava")
    // rust: .ok_or(AquiferError::MissingBlock)?,
    // rust: })
}
name :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.registry.state(state).map(|s| s.name.as_str())
}
}
    // rust: impl AquiferBlockStates for RegistryAquiferBlockStates<'_> {
air :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.air
}
lava :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.lava
}
is_air :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: self.name(state),
    // rust: Some("minecraft:air" | "minecraft:cave_air" | "minecraft:void_air")
    // rust: )
}
is_lava :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.name(state) == Some("minecraft:lava")
}
is_water :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.name(state) == Some("minecraft:water")
}
}
AquiferError :: enum {
    Sample(SampleError),
    InvalidGrid,
    OutsideGrid,
    Allocation,
    MissingBlock,
}
    // rust: impl From<SampleError> for AquiferError {
from :: proc(value: SampleError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Sample(value)
}
}
    // rust: impl From<DensityError> for AquiferError {
from :: proc(value: DensityError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Sample(value.into())
}
}
    // rust: impl std::fmt::Display for AquiferError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Sample(e) => e.fmt(f),
    // rust: Self::InvalidGrid => f.write_str("aquifer grid is invalid or exceeds 16777216 cells"),
    // rust: Self::OutsideGrid => f.write_str("aquifer query lies outside its grid"),
    // rust: Self::Allocation => f.write_str("aquifer allocation failed"),
    // rust: Self::MissingBlock => f.write_str("aquifer registry lacks default air or lava"),
}
}
}
    // rust: impl std::error::Error for AquiferError {}

NoiseBasedAquifer :: struct {
    samplers: AquiferSamplers,
    picker: P,
    random: F,
    blocks: B,
    minimum: [i32,
    size_x: i32,
    size_z: i32,
    statuses: [dynamic]Maybe(FluidStatus),
    locations: [dynamic]i64,
    surfaces: HashMap<i64,
    neighborhood: Option<([i32,
    skip_above_y: i32,
    schedule: bool,
    cached_col: [i32,
    cached_y_anchor: i32,
    cached_h: [i32,
    cached_py: [i32,
    cached_indices: [uint,
}
    // rust: impl<P: FluidPicker, F: PositionalRandom, B: AquiferBlockStates> NoiseBasedAquifer<P, F, B> {
    // The positional factory is the caller's aquifer factory, not the world's
    // unmodified factory. Every sampler uses the caller's shared context.
    // rust: pub fn new(
    // rust: samplers: AquiferSamplers,
    // rust: picker: P,
    // rust: random: F,
    // rust: blocks: B,
    // rust: volume: DensityVolume,
    // rust: context: &mut SamplerContext,
    // rust: ) -> Result<Self, AquiferError> {
    // rust: let low = volume.minimum();
    // rust: let high = volume.maximum();
    // rust: let minimum = [
    // rust: low[0].wrapping_sub(5) >> 4,
    // rust: low[1].wrapping_add(1).div_euclid(12).wrapping_sub(1),
    // rust: low[2].wrapping_sub(5) >> 4,
    // rust: ];
    // rust: let maximum = [
    // rust: (high[0].wrapping_sub(5) >> 4).wrapping_add(1),
    // rust: high[1].wrapping_add(1).div_euclid(12).wrapping_add(1),
    // rust: (high[2].wrapping_sub(5) >> 4).wrapping_add(1),
    // rust: ];
    // rust: let sizes: [i32; 3] =
    // rust: std::array::from_fn(|i| maximum[i].wrapping_sub(minimum[i]).wrapping_add(1));
    // rust: let count = sizes
    // rust: .into_iter()
    // rust: .try_fold(1usize, |n, s| {
    // rust: if s > 0 {
    // rust: n.checked_mul(s as usize)
    // rust: } else {
    // rust: None
}
    // rust: })
    // rust: .filter(|n| *n <= 16_777_216)
    // rust: .ok_or(AquiferError::InvalidGrid)?;
    // rust: let mut statuses = Vec::new();
    // rust: statuses
    // rust: .try_reserve_exact(count)
    // rust: .map_err(|_| AquiferError::Allocation)?;
    // rust: statuses.resize(count, None);
    // rust: let mut locations = Vec::new();
    // rust: locations
    // rust: .try_reserve_exact(count)
    // rust: .map_err(|_| AquiferError::Allocation)?;
    // rust: locations.resize(count, i64::MAX);
    // rust: let mut result = Self {
    // rust: samplers,
    // rust: picker,
    // rust: random,
    // rust: blocks,
    // rust: minimum,
    // rust: size_x: sizes[0],
    // rust: size_z: sizes[2],
    // rust: statuses,
    // rust: locations,
    // rust: surfaces: HashMap::new(),
    // rust: neighborhood: None,
    // rust: skip_above_y: 0,
    // rust: schedule: false,
    // rust: cached_col: [i32::MIN, i32::MIN],
    // rust: cached_y_anchor: i32::MIN,
    // rust: cached_h: [0; 12],
    // rust: cached_py: [0; 12],
    // rust: cached_indices: [0; 12],
}
    // rust: let max_surface = result
    // rust: .max_surface_level(
    // rust: context,
    // rust: [minimum[0].wrapping_shl(4), minimum[2].wrapping_shl(4)],
    // rust: [
    // rust: maximum[0].wrapping_shl(4).wrapping_add(9),
    // rust: maximum[2].wrapping_shl(4).wrapping_add(9),
    // rust: ],
    // rust: )?
    // rust: .wrapping_add(8);
    // rust: let skip_grid = max_surface.wrapping_add(12).div_euclid(12).wrapping_add(1);
    // rust: result.skip_above_y = skip_grid.wrapping_mul(12).wrapping_add(11).wrapping_sub(1);
    // rust: Ok(result)
}
    // Read-only diagnostic state; enumeration never populates a cache.
cached_cells :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.locations
    // rust: .iter()
    // rust: .copied()
    // rust: .zip(self.statuses.iter().copied())
}
cached_surfaces :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.surfaces.iter().map(|(key, value)| (*key, *value))
}
should_schedule_fluid_update :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.schedule
}
skip_sampling_above_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.skip_above_y
}
    // The fill decided a block without this aquifer. Both old decisions
    // (positive density and air above the skip height) cleared the pending
    // fluid update, so the caller reproduces that side effect.
note_skipped :: proc(self: ^Self) {
}
    // rust: self.schedule = false;
}
    // The y above which a non-positive density is the global fluid's air. The
    // vanilla fluid rules depend only on y; a picker that varies with x/z keeps
    // the per-block call by answering `None`.
air_above_y :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let center = self.picker.compute([0, i32::MAX, 0]);
    // rust: let east = self.picker.compute([i32::MAX, i32::MAX, i32::MAX]);
    // rust: let west = self.picker.compute([i32::MIN, i32::MAX, i32::MIN]);
    // rust: (center.level == east.level && center.level == west.level)
    // rust: .then(|| self.skip_above_y.max(center.level))
}
    // rust: fn sample(
    // rust: &self,
    // rust: field: AquiferField,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f64, AquiferError> {
    // rust: Ok(self.samplers.get(field).sample_value(context, position)? as f64)
}
    // rust: fn surface_level(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Result<i32, AquiferError> {
    // rust: let x = (x >> 2).wrapping_shl(2);
    // rust: let z = (z >> 2).wrapping_shl(2);
    // rust: let key = ChunkPos::new(x, z).pack();
    // rust: if let Some(level) = self.surfaces.get(&key) {
    // rust: return Ok(*level);
}
    // rust: let level = self
    // rust: .sample(AquiferField::SurfaceLevel, context, [x, 0, z])?
    // rust: .floor() as i32;
    // rust: self.surfaces.insert(key, level);
    // rust: Ok(level)
}
    // rust: fn max_surface_level(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: minimum: [i32; 2],
    // rust: maximum: [i32; 2],
    // rust: ) -> Result<i32, AquiferError> {
    // rust: let low = minimum.map(|v| v >> 2);
    // rust: let high = maximum.map(|v| v >> 2);
    // rust: let sizes: [i32; 2] = std::array::from_fn(|i| high[i].wrapping_sub(low[i]).wrapping_add(1));
    // rust: let volume = DensityVolume::new(
    // rust: [sizes[0], 1, sizes[1]],
    // rust: [low[0].wrapping_shl(2), 0, low[1].wrapping_shl(2)],
    // rust: [4, 1, 4],
    // rust: )?;
    // rust: if volume.size() > 2_097_152 {
    // rust: return Err(AquiferError::InvalidGrid);
}
    // rust: let mut buffer = Vec::new();
    // rust: buffer
    // rust: .try_reserve_exact(volume.size())
    // rust: .map_err(|_| AquiferError::Allocation)?;
    // rust: buffer.resize(volume.size(), 0.);
    // rust: self.samplers
    // rust: .get(AquiferField::SurfaceLevel)
    // rust: .sample_volume(context, &mut buffer, volume)?;
    // rust: self.surfaces
    // rust: .try_reserve(volume.size())
    // rust: .map_err(|_| AquiferError::Allocation)?;
    // rust: let mut maximum = i32::MIN;
    // rust: let mut index = 0;
    // rust: for z in 0..sizes[1] {
    // rust: for x in 0..sizes[0] {
    // rust: let value = (buffer[index] as f64).floor() as i32;
    // rust: index += 1;
    // rust: self.surfaces.insert(
    // rust: ChunkPos::new(
    // rust: low[0].wrapping_add(x).wrapping_shl(2),
    // rust: low[1].wrapping_add(z).wrapping_shl(2),
    // rust: )
    // rust: .pack(),
    // rust: value,
    // rust: );
    // rust: maximum = maximum.max(value);
}
}
    // rust: Ok(maximum)
}
grid_index :: proc(self: ^Self, position: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let relative: [i32; 3] = std::array::from_fn(|i| position[i].wrapping_sub(self.minimum[i]));
        // Vanilla checks the final array index, rather than each coordinate.
    // rust: let index = relative[1]
    // rust: .wrapping_mul(self.size_z)
    // rust: .wrapping_add(relative[2])
    // rust: .wrapping_mul(self.size_x)
    // rust: .wrapping_add(relative[0]);
    // rust: if index < 0 || index as usize >= self.locations.len() {
    // rust: return Err(AquiferError::OutsideGrid);
}
    // rust: Ok(index as usize)
}
    // rust: fn status(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: index: usize,
    // rust: ) -> Result<FluidStatus, AquiferError> {
    // rust: if let Some(status) = self.statuses[index] {
    // rust: return Ok(status);
}
    // rust: let pos = BlockPos::unpack(self.locations[index]);
    // rust: let status = self.compute_fluid(context, [pos.x, pos.y, pos.z])?;
    // rust: self.statuses[index] = Some(status);
    // rust: Ok(status)
}
    // rust: fn compute_fluid(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: [x, y, z]: [i32; 3],
    // rust: ) -> Result<FluidStatus, AquiferError> {
    // rust: let global = self.picker.compute([x, y, z]);
    // rust: let upper = y.wrapping_add(12);
    // rust: let lower = y.wrapping_sub(12);
    // rust: let mut minimum = i32::MAX;
    // rust: let mut center_fluid = false;
    // rust: for [dx, dz] in SURFACE_OFFSETS {
    // rust: let sx = x.wrapping_add(dx.wrapping_mul(16));
    // rust: let sz = z.wrapping_add(dz.wrapping_mul(16));
    // rust: let surface = self.surface_level(context, sx, sz)?;
    // rust: let adjusted = surface.wrapping_add(8);
    // rust: let center = dx == 0 && dz == 0;
    // rust: if center && lower > adjusted {
    // rust: return Ok(global);
}
    // rust: let above = upper > adjusted;
    // rust: if above || center {
    // rust: let status = self.picker.compute([sx, adjusted, sz]);
    // rust: if !self.blocks.is_air(status.at(adjusted, self.blocks.air())) {
    // rust: if center {
    // rust: center_fluid = true;
}
    // rust: if above {
    // rust: return Ok(status);
}
}
}
    // rust: minimum = minimum.min(surface);
}
    // rust: let level =
    // rust: self.compute_surface_level(context, [x, y, z], global, minimum, center_fluid)?;
    // rust: let mut state = global.state;
    // rust: if level <= -10
    // rust: && level != WAY_BELOW_MIN_Y
    // rust: && state != self.blocks.lava()
    // rust: && self
    // rust: .sample(
    // rust: AquiferField::Lava,
    // rust: context,
    // rust: [x.div_euclid(64), y.div_euclid(40), z.div_euclid(64)],
    // rust: )?
    // rust: .abs()
    // rust: > 0.3
    // rust: {
    // rust: state = self.blocks.lava();
}
    // rust: Ok(FluidStatus { level, state })
}
    // rust: fn compute_surface_level(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: global: FluidStatus,
    // rust: minimum: i32,
    // rust: center_fluid: bool,
    // rust: ) -> Result<i32, AquiferError> {
    // rust: let [x, y, z] = position;
    // rust: let (dry, flooded) = if self.sample(AquiferField::Exclusion, context, position)? > 0. {
    // rust: (-1., -1.)
    // rust: } else {
    // rust: let distance = minimum.wrapping_add(8).wrapping_sub(y);
    // rust: let factor = if center_fluid {
    // rust: let alpha = (distance as f64 - 0.) / (64. - 0.);
    // rust: if alpha < 0. {
    // rust: 1.
    // rust: } else if alpha > 1. {
    // rust: 0.
    // rust: } else {
    // rust: 1. + alpha * (0. - 1.)
}
    // rust: } else {
    // rust: 0.
}
    // rust: let value = self
    // rust: .sample(AquiferField::Floodedness, context, position)?
    // rust: .clamp(-1., 1.);
    // rust: let alpha = (factor - 1.) / (0. - 1.);
    // rust: let threshold_flooded = -0.3 + alpha * (0.8 - -0.3);
    // rust: let threshold_dry = -0.8 + alpha * (0.4 - -0.8);
    // rust: (value - threshold_dry, value - threshold_flooded)
}
    // rust: if flooded > 0. {
    // rust: return Ok(global.level);
}
    // rust: if dry > 0. {
    // rust: let spread = self.samplers.get(AquiferField::Spread).sample_value(
    // rust: context,
    // rust: [x.div_euclid(16), y.div_euclid(40), z.div_euclid(16)],
    // rust: )? * 10.;
    // rust: let offset = ((spread as f64 / 3.).floor() as i32).wrapping_mul(3);
    // rust: return Ok(minimum.min(
    // rust: y.div_euclid(40)
    // rust: .wrapping_mul(40)
    // rust: .wrapping_add(20)
    // rust: .wrapping_add(offset),
    // rust: ));
}
    // rust: Ok(WAY_BELOW_MIN_Y)
}
    // rust: fn pressure(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: memo: &mut f64,
    // rust: a: FluidStatus,
    // rust: b: FluidStatus,
    // rust: ) -> Result<f64, AquiferError> {
    // rust: let y = position[1];
    // rust: let sa = a.at(y, self.blocks.air());
    // rust: let sb = b.at(y, self.blocks.air());
    // rust: if (self.blocks.is_lava(sa) && self.blocks.is_water(sb))
    // rust: || (self.blocks.is_water(sa) && self.blocks.is_lava(sb))
    // rust: {
    // rust: return Ok(2.);
}
    // rust: let gap = a.level.wrapping_sub(b.level).wrapping_abs();
    // rust: if gap == 0 {
    // rust: return Ok(0.);
}
    // rust: let midpoint = 0.5 * a.level.wrapping_add(b.level) as f64;
    // rust: let dy = y as f64 + 0.5 - midpoint;
    // rust: let edge = gap as f64 / 2. - dy.abs();
    // rust: let q = if dy > 0. {
    // rust: let n = 0. + edge;
    // rust: if n > 0. { n / 1.5 } else { n / 2.5 }
    // rust: } else {
    // rust: let n = 3. + edge;
    // rust: if n > 0. { n / 3. } else { n / 10. }
}
    // rust: let barrier = if q < -2. || q > 2. {
    // rust: 0.
    // rust: } else {
    // rust: if memo.is_nan() {
    // rust: *memo = self.sample(AquiferField::Barrier, context, position)?;
}
    // rust: *memo
}
    // rust: Ok(2. * (barrier + q))
}
    // rust: pub fn compute_substance(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: [x, y, z]: [i32; 3],
    // rust: density: f64,
    // rust: ) -> Result<Option<BlockStateId>, AquiferError> {
    // rust: if density > 0. {
    // rust: self.schedule = false;
    // rust: return Ok(None);
}
    // rust: let global = self.picker.compute([x, y, z]);
    // rust: if y > self.skip_above_y {
    // rust: self.schedule = false;
    // rust: return Ok(Some(global.at(y, self.blocks.air())));
}
    // rust: if self.blocks.is_lava(global.at(y, self.blocks.air())) {
    // rust: self.schedule = false;
    // rust: return Ok(Some(self.blocks.lava()));
}
    // rust: let grid = [
    // rust: x.wrapping_sub(5) >> 4,
    // rust: y.wrapping_add(1).div_euclid(12),
    // rust: z.wrapping_sub(5) >> 4,
    // rust: ];
        // Fill in the original cell order, publishing only after checked traversal
        // succeeds. Failed traversal keeps the last complete neighborhood.
    // rust: if self.neighborhood.as_ref().map(|(key, _)| *key) != Some(grid) {
    // rust: let mut entries = [(0, BlockPos::default()); 12];
    // rust: let mut next = 0;
    // rust: for dx in 0..=1i32 {
    // rust: for dy in -1..=1i32 {
    // rust: for dz in 0..=1i32 {
    // rust: let cell = [
    // rust: grid[0].wrapping_add(dx),
    // rust: grid[1].wrapping_add(dy),
    // rust: grid[2].wrapping_add(dz),
    // rust: ];
    // rust: let index = self.grid_index(cell)?;
    // rust: if self.locations[index] == i64::MAX {
    // rust: let mut random =
    // rust: self.random.at(BlockPos::new(cell[0], cell[1], cell[2]));
    // rust: let px = cell[0]
    // rust: .wrapping_shl(4)
    // rust: .wrapping_add(random.next_int_bound(10).expect("positive bound"));
    // rust: let py = cell[1]
    // rust: .wrapping_mul(12)
    // rust: .wrapping_add(random.next_int_bound(9).expect("positive bound"));
    // rust: let pz = cell[2]
    // rust: .wrapping_shl(4)
    // rust: .wrapping_add(random.next_int_bound(10).expect("positive bound"));
    // rust: self.locations[index] = BlockPos::new(px, py, pz).pack();
}
    // rust: entries[next] = (index, BlockPos::unpack(self.locations[index]));
    // rust: next += 1;
}
}
}
    // rust: self.neighborhood = Some((grid, entries));
}
    // rust: if x != self.cached_col[0] || z != self.cached_col[1] || grid[1] != self.cached_y_anchor {
    // rust: self.cached_col = [x, z];
    // rust: self.cached_y_anchor = grid[1];
    // rust: let entries = &self
    // rust: .neighborhood
    // rust: .as_ref()
    // rust: .expect("populated neighborhood")
    // rust: .1;
    // rust: for i in 0..12 {
    // rust: let (index, point) = entries[i];
    // rust: let ax = point.x.wrapping_sub(x);
    // rust: let az = point.z.wrapping_sub(z);
    // rust: self.cached_indices[i] = index;
    // rust: self.cached_h[i] = ax.wrapping_mul(ax).wrapping_add(az.wrapping_mul(az));
    // rust: self.cached_py[i] = point.y;
}
}
    // rust: let mut distances = [i32::MAX; 4];
    // rust: let mut indices = [0usize; 4];
    // rust: for i in 0..12 {
    // rust: let ay = self.cached_py[i].wrapping_sub(y);
    // rust: let distance = self.cached_h[i].wrapping_add(ay.wrapping_mul(ay));
    // rust: let index = self.cached_indices[i];
            // Equal distances insert before existing entries, as in vanilla.
    // rust: if distance <= distances[0] {
    // rust: distances = [distance, distances[0], distances[1], distances[2]];
    // rust: indices = [index, indices[0], indices[1], indices[2]];
    // rust: } else if distance <= distances[1] {
    // rust: distances[3] = distances[2];
    // rust: distances[2] = distances[1];
    // rust: distances[1] = distance;
    // rust: indices[3] = indices[2];
    // rust: indices[2] = indices[1];
    // rust: indices[1] = index;
    // rust: } else if distance <= distances[2] {
    // rust: distances[3] = distances[2];
    // rust: distances[2] = distance;
    // rust: indices[3] = indices[2];
    // rust: indices[2] = index;
    // rust: } else if distance <= distances[3] {
    // rust: distances[3] = distance;
    // rust: indices[3] = index;
}
}
    // rust: let a = self.status(context, indices[0])?;
    // rust: let s01 = similarity(distances[0], distances[1]);
    // rust: let candidate = a.at(y, self.blocks.air());
    // rust: if s01 <= 0. {
    // rust: self.schedule = if s01 >= FLOWING_UPDATE_SIMILARITY {
    // rust: a != self.status(context, indices[1])?
    // rust: } else {
    // rust: false
}
    // rust: return Ok(Some(candidate));
}
    // rust: if self.blocks.is_water(candidate)
    // rust: && self.blocks.is_lava(
    // rust: self.picker
    // rust: .compute([x, y.wrapping_sub(1), z])
    // rust: .at(y.wrapping_sub(1), self.blocks.air()),
    // rust: )
    // rust: {
    // rust: self.schedule = true;
    // rust: return Ok(Some(candidate));
}
    // rust: let mut memo = f64::NAN;
    // rust: let b = self.status(context, indices[1])?;
    // rust: if density + s01 * self.pressure(context, [x, y, z], &mut memo, a, b)? > 0. {
    // rust: self.schedule = false;
    // rust: return Ok(None);
}
    // rust: let c = self.status(context, indices[2])?;
    // rust: let s02 = similarity(distances[0], distances[2]);
    // rust: if s02 > 0.
    // rust: && density + s01 * s02 * self.pressure(context, [x, y, z], &mut memo, a, c)? > 0.
    // rust: {
    // rust: self.schedule = false;
    // rust: return Ok(None);
}
    // rust: let s12 = similarity(distances[1], distances[2]);
    // rust: if s12 > 0.
    // rust: && density + s01 * s12 * self.pressure(context, [x, y, z], &mut memo, b, c)? > 0.
    // rust: {
    // rust: self.schedule = false;
    // rust: return Ok(None);
}
    // rust: self.schedule = a != b
    // rust: || (s12 >= FLOWING_UPDATE_SIMILARITY && b != c)
    // rust: || (s02 >= FLOWING_UPDATE_SIMILARITY && a != c)
    // rust: || (s02 >= FLOWING_UPDATE_SIMILARITY
    // rust: && similarity(distances[0], distances[3]) >= FLOWING_UPDATE_SIMILARITY
    // rust: && a != self.status(context, indices[3])?);
    // rust: Ok(Some(candidate))
}
}
similarity :: proc(a: i32, b: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 1. - b.wrapping_sub(a) as f64 / 25.
}
