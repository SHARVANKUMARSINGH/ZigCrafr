//! Transpiled from Horizon Rust crate
//! Module: horizon-world_noise
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Named material-noise sources derived from the world's positional factory.
// use super::{MaterialRuleError, MaterialSurfaceQueries, codec::identifier};
// use crate::{
    // rust: registry::BlockStateId,
    // rust: worldgen::{DecodeError, decode_noise},
}
// use horizon_core::{
    // rust: noise::{Noise, NormalNoise},
    // rust: position::BlockPos,
    // rust: random::PositionalRandom,
}
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::Arc,
}

/// Add lazy, shared named noise sources to a material surface provider.
/// Both providers must be configured for the same world seed and random mode.
pub const MaterialNoiseSources = struct {
    root: P,
    surface: S,
    definitions: BTreeMap<[]const u8,
    samplers: BTreeMap<[]const u8,
};
    // rust: impl<P: PositionalRandom, S: MaterialSurfaceQueries> MaterialNoiseSources<P, S> {
    // rust: pub fn from_json(
    // rust: root: P,
    // rust: surface: S,
    // rust: definitions: &BTreeMap<String, String>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if definitions.len() > 8192 {
    // rust: return Err(DecodeError::Field("material noise registry size"));
}
    // rust: let mut noises = BTreeMap::new();
    // rust: for (name, json) in definitions {
    // rust: if noises
    // rust: .insert(identifier(name)?, decode_noise(json)?)
    // rust: .is_some()
    // rust: {
    // rust: return Err(DecodeError::Field("duplicate material noise"));
}
}
    // rust: Ok(Self {
    // rust: root,
    // rust: surface,
    // rust: definitions: noises,
    // rust: samplers: BTreeMap::new(),
    // rust: })
}
}
    // rust: impl<P: PositionalRandom, S: MaterialSurfaceQueries> MaterialSurfaceQueries
    // rust: for MaterialNoiseSources<P, S>
    // rust: {
    // rust: fn bind_density(
    // rust: &mut self,
    // rust: sampler: Arc<dyn horizon_core::density::DensitySampler>,
    // rust: eager: bool,
    // rust: ) -> Result<usize, DecodeError> {
    // rust: self.surface.bind_density(sampler, eager)
}
pub fn density(self: *Self, index: usize, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.density(index, position)
}
pub fn preliminary_surface(self: *Self, position: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.surface.preliminary_surface(position)
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
pub fn bind_noise(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = identifier(name)?;
    // rust: if let Some(noise) = self.samplers.get(&name) {
    // rust: return Ok(noise.clone());
}
    // rust: let definition = self
    // rust: .definitions
    // rust: .get(&name)
    // rust: .ok_or(DecodeError::Field("unknown material noise"))?;
    // rust: let noise: Arc<dyn Noise> =
    // rust: Arc::new(definition.create(&mut self.root.from_hash_of(&name))?);
    // rust: self.samplers.insert(name, noise.clone());
    // rust: Ok(noise)
}
}
