//! Transpiled from Horizon Rust crate
package horizon_world_noise

import "core:fmt"
import "core:mem"
import "core:math"

// Named material-noise sources derived from the world's positional factory.
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

// Add lazy, shared named noise sources to a material surface provider.
// Both providers must be configured for the same world seed and random mode.
MaterialNoiseSources :: struct {
    root: P,
    surface: S,
    definitions: BTreeMap<string,
    samplers: BTreeMap<string,
}
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
density :: proc(self: ^Self, index: uint, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.surface.density(index, position)
}
preliminary_surface :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.surface.preliminary_surface(position)
}
possible_biomes :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.surface.possible_biomes()
}
biome :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.surface.biome(position)
}
biome_id :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.surface.biome_id(position)
}
biome_index :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
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
surface_depth :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.surface.surface_depth(x, z)
}
surface_secondary :: proc(self: ^Self, x: i32, z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.surface.surface_secondary(x, z)
}
band :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.surface.band(position)
}
bind_noise :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
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
