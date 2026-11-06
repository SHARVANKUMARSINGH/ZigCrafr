//! Transpiled from Horizon Rust crate
//! Module: horizon-world_density
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Preliminary surface density sampling scoped to one material context.
// use super::{MaterialRuleError, MaterialSurfaceQueries};
// use crate::{registry::BlockStateId, worldgen::DecodeError};
// use horizon_core::{
    // rust: density::{DensitySampler, SamplerContext},
    // rust: noise::{DensityVolume, Noise},
    // rust: position::BlockPos,
}
// use std::{collections::BTreeSet, sync::Arc};

/// A lazy unit-spaced XZ plane and scalar fallback for preliminary heights.
/// Construct a fresh provider for each material context, with that world's
/// compiled preliminary-surface density root and bound sampler context.
pub const MaterialDensitySources = struct {
    surface: S,
    expected: DensityVolume,
    densities: std.ArrayList(BoundDensity),
    /// Eagerly sampled volumes, shared by bindings of the same density root.
    buffers: std.ArrayList(Vec<f32)>,
    retained_samples: usize,
    plane: DensityVolume,
    sampler: *dyn DensitySampler,
    context: SamplerContext,
    buffer: ?std.ArrayList(f32),
};
pub const BoundDensity = struct {
    sampler: *dyn DensitySampler,
    buffer: ?usize,
};
    // rust: impl<S: MaterialSurfaceQueries> MaterialDensitySources<S> {
pub fn sampler_context_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.context
}
    /// Re-target the per-cell bindings to one block. A carver reuses one worker
    /// across every restored dirt block, so the 1×1×1 volumes the bindings and
    /// the preliminary plane sample must follow the cell; the compiled rule is
    /// kept.
pub fn retarget(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let volume = DensityVolume::new([1; 3], position, [1; 3])
    // rust: .map_err(|_| DecodeError::Field("material density volume"))?;
    // rust: let plane = DensityVolume::new([1; 3], [position[0], 0, position[2]], [1; 3])
    // rust: .map_err(|_| DecodeError::Field("material preliminary plane"))?;
    // rust: self.expected = volume;
    // rust: self.plane = plane;
        // The plane is sampled lazily at the new x/z.
    // rust: self.buffer = None;
    // rust: let mut sampled = vec![false; self.buffers.len()];
    // rust: let mut pending = Vec::new();
    // rust: for bound in &self.densities {
    // rust: let Some(buffer) = bound.buffer else { continue };
    // rust: if sampled.get(buffer).copied().unwrap_or(true) {
    // rust: continue;
}
    // rust: sampled[buffer] = true;
    // rust: pending.push((bound.sampler.clone(), buffer));
}
    // rust: for (sampler, buffer) in pending {
    // rust: let out = &mut self.buffers[buffer];
    // rust: out.resize(volume.size(), 0.0);
    // rust: sampler.sample_volume(&mut self.context, out, volume)?;
}
    // rust: Ok(())
}
pub fn into_parts(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.surface, self.context)
}
    // rust: pub fn new(
    // rust: surface: S,
    // rust: expected: DensityVolume,
    // rust: sampler: Arc<dyn DensitySampler>,
    // rust: context: SamplerContext,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let [sx, _, sz] = expected.sizes();
        // Bound retained allocation. Normal chunk planes contain 256 samples.
    // rust: if sx * sz > 1 << 20 {
    // rust: return Err(DecodeError::Field("material preliminary plane size"));
}
    // rust: let [x, _, z] = expected.minimum();
    // rust: let plane = DensityVolume::new([sx as i32, 1, sz as i32], [x, 0, z], [1; 3])
    // rust: .map_err(|_| DecodeError::Field("material preliminary plane"))?;
    // rust: Ok(Self {
    // rust: surface,
    // rust: expected,
    // rust: densities: Vec::new(),
    // rust: buffers: Vec::new(),
    // rust: retained_samples: 0,
    // rust: plane,
    // rust: sampler,
    // rust: context,
    // rust: buffer: None,
    // rust: })
}
}
    // rust: impl<S: MaterialSurfaceQueries> MaterialSurfaceQueries for MaterialDensitySources<S> {
    // rust: fn bind_density(
    // rust: &mut self,
    // rust: sampler: Arc<dyn DensitySampler>,
    // rust: eager: bool,
    // rust: ) -> Result<usize, DecodeError> {
    // rust: if self.densities.len() >= 32768
    // rust: || (eager
    // rust: && (self.expected.size() > 1 << 20
    // rust: || self.retained_samples + self.expected.size() > 1 << 24))
    // rust: {
    // rust: return Err(DecodeError::Field("material density storage bound"));
}
    // rust: let shared = self
    // rust: .densities
    // rust: .iter()
    // rust: .find(|bound| bound.buffer.is_some() && Arc::ptr_eq(&bound.sampler, &sampler))
    // rust: .and_then(|bound| bound.buffer);
    // rust: let buffer = match (eager, shared) {
    // rust: (false, _) => None,
            // Sampling a root over the same volume and context is deterministic,
            // so a second binding (iron and copper veins' richness) reuses it.
    // rust: (true, Some(buffer)) => Some(buffer),
    // rust: (true, None) => {
    // rust: let mut buffer = vec![0.0; self.expected.size()];
    // rust: sampler.sample_volume(&mut self.context, &mut buffer, self.expected)?;
    // rust: self.retained_samples += buffer.len();
    // rust: self.buffers.push(buffer);
    // rust: Some(self.buffers.len() - 1)
}
}
    // rust: let index = self.densities.len();
    // rust: self.densities.push(BoundDensity { sampler, buffer });
    // rust: Ok(index)
}
pub fn density(self: *Self, index: usize, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let source = self
    // rust: .densities
    // rust: .get(index)
    // rust: .ok_or(MaterialRuleError::MissingDensityProvider)?;
    // rust: let position = [position.x, position.y, position.z];
    // rust: if let Some(buffer) = source.buffer {
    // rust: if let Some(index) = block_index(self.expected, position) {
    // rust: return Ok(self.buffers[buffer][index]);
}
}
    // rust: Ok(source.sampler.sample_value(&mut self.context, position)?)
}
pub fn preliminary_surface(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = [position.x, 0, position.z];
    // rust: if let Some(index) = self.plane.index_of_block(position) {
    // rust: if self.buffer.is_none() {
                // Retain the allocation and partial writes if sampling fails.
    // rust: let buffer = self.buffer.insert(vec![0.0; self.plane.size()]);
    // rust: self.sampler
    // rust: .sample_volume(&mut self.context, buffer, self.plane)?;
}
    // rust: Ok(self.buffer.as_ref().unwrap()[index])
    // rust: } else {
    // rust: Ok(self.sampler.sample_value(&mut self.context, position)?)
}
}
pub fn possible_biomes(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.possible_biomes()
}
pub fn biome(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.biome(position)
}
pub fn biome_id(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.biome_id(position)
}
pub fn biome_index(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.biome_index(name)
}
    // rust: fn melts_frozen_ocean(
    // rust: &mut self,
    // rust: biome: &str,
    // rust: position: BlockPos,
    // rust: sea_level: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: self.surface.melts_frozen_ocean(biome, position, sea_level)
}
    // rust: fn cold_enough_to_snow(
    // rust: &mut self,
    // rust: biome: &str,
    // rust: position: BlockPos,
    // rust: sea_level: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: self.surface.cold_enough_to_snow(biome, position, sea_level)
}
pub fn bind_noise(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.bind_noise(name)
}
pub fn surface_depth(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.surface_depth(x, z)
}
pub fn surface_secondary(self: *Self, x: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.surface_secondary(x, z)
}
pub fn band(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.band(position)
}
}

/// `DensityVolume::index_of_block` without its per-axis divisions for the
/// unit-step volumes the material stage samples (one or two lookups per block).
pub fn block_index(volume: DensityVolume, position: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if volume.steps() != [1; 3] {
    // rust: return volume.index_of_block(position);
}
    // rust: let [mx, my, mz] = volume.minimum();
    // rust: let [sx, sy, sz] = volume.sizes();
    // rust: let x = position[0].wrapping_sub(mx) as u32 as usize;
    // rust: let y = position[1].wrapping_sub(my) as u32 as usize;
    // rust: let z = position[2].wrapping_sub(mz) as u32 as usize;
    // rust: (x < sx && y < sy && z < sz).then(|| y + (x + z * sx) * sy)
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::density::SampleError;
//     use std::sync::atomic::{AtomicUsize, Ordering};

pub const Surface = struct {};
    // rust: impl MaterialSurfaceQueries for Surface {
pub fn surface_depth(self: *Self, _: i32, _: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn surface_secondary(self: *Self, _: i32, _: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0.0
}
}
    /// Position-dependent values; counts bulk samples.
pub const Counted = struct {};
    // rust: impl DensitySampler for Counted {
pub fn sample_value(self: *Self, _: *mut SamplerContext, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok((p[0] * 10_000 + p[1] * 100 + p[2]) as f32)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: self.0.fetch_add(1, Ordering::Relaxed);
    // rust: for z in 0..volume.sizes()[2] {
    // rust: for x in 0..volume.sizes()[0] {
    // rust: for y in 0..volume.sizes()[1] {
    // rust: let [mx, my, mz] = volume.minimum();
    // rust: let p = [mx + x as i32, my + y as i32, mz + z as i32];
    // rust: buffer[volume.index([x, y, z]).unwrap()] = self.sample_value(context, p)?;
}
}
}
    // rust: Ok(())
}
}
pub fn sources() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let volume = DensityVolume::new([16, 24, 16], [32, -64, -16], [1; 3]).unwrap();
    // rust: MaterialDensitySources::new(
    // rust: Surface,
    // rust: volume,
    // rust: Arc::new(Counted::default()),
    // rust: SamplerContext::default(),
    // rust: )
    // rust: .unwrap()
}

pub fn eager_bindings_of_one_root_share_a_single_sample() void {
}
    // rust: let mut sources = sources();
    // rust: let shared = Arc::new(Counted::default());
    // rust: let other = Arc::new(Counted::default());
    // rust: let a = sources.bind_density(shared.clone(), true).unwrap();
    // rust: let lazy = sources.bind_density(shared.clone(), false).unwrap();
    // rust: let b = sources.bind_density(shared.clone(), true).unwrap();
    // rust: let c = sources.bind_density(other.clone(), true).unwrap();
    // rust: assert_eq!(shared.0.load(Ordering::Relaxed), 1);
    // rust: assert_eq!(other.0.load(Ordering::Relaxed), 1);
    // rust: assert_eq!([a, lazy, b, c], [0, 1, 2, 3]);
    // rust: for p in [[32, -64, -16], [47, -41, -1], [40, -50, -9], [48, 0, 0]] {
    // rust: let position = BlockPos::new(p[0], p[1], p[2]);
    // rust: let expected = (p[0] * 10_000 + p[1] * 100 + p[2]) as f32;
    // rust: for index in [a, lazy, b, c] {
    // rust: assert_eq!(sources.density(index, position).unwrap(), expected);
}
}
    // rust: assert_eq!(shared.0.load(Ordering::Relaxed), 1);
}

pub fn block_index_matches_index_of_block() void {
}
    // rust: let unit = DensityVolume::new([16, 24, 16], [i32::MAX - 7, -64, -16], [1; 3]).unwrap();
    // rust: let strided = DensityVolume::new([5, 3, 5], [-8, -64, 0], [4, 8, 4]).unwrap();
    // rust: for volume in [unit, strided] {
    // rust: let [mx, my, mz] = volume.minimum();
    // rust: for dx in [-1, 0, 1, 4, 7, 8, 15, 16, 17, 20] {
    // rust: for dy in [-9, -1, 0, 8, 16, 23, 24] {
    // rust: for dz in [-1, 0, 3, 15, 16, 20] {
    // rust: let p = [
    // rust: mx.wrapping_add(dx),
    // rust: my.wrapping_add(dy),
    // rust: mz.wrapping_add(dz),
    // rust: ];
    // rust: assert_eq!(block_index(volume, p), volume.index_of_block(p), "{p:?}");
}
}
}
    // rust: for p in [
    // rust: [i32::MIN, 0, 0],
    // rust: [i32::MAX, i32::MAX, i32::MAX],
    // rust: [0, i32::MIN, 0],
    // rust: ] {
    // rust: assert_eq!(block_index(volume, p), volume.index_of_block(p), "{p:?}");
}
}
}
}
