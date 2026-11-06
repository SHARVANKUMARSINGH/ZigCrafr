//! Transpiled from Horizon Rust crate
//! Module: horizon-world_runtime
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! World-bound biome sources and per-worker resolver state.
// use super::{
    // rust: BiomeSourceDefinition, CheckerboardBiomeSource, CheckerboardError, EndBiomeSource,
    // rust: FixedBiomeSource,
}
// use crate::worldgen::{
    // rust: DecodeError,
    // rust: biome::{BiomeError, BiomeResolver, MultiNoiseBiomeSource},
    // rust: climate::{ClimateSampler, ClimateVolume},
}
// use horizon_core::density::{DensitySampler, SampleError, SamplerContext};
// use std::collections::{BTreeMap, BTreeSet};

pub const BiomeSourceError = enum {
    Decode(DecodeError),
    Biome(BiomeError),
    Checkerboard(CheckerboardError),
    Sample(SampleError),
    MissingPreset,
};
    // rust: impl std::fmt::Display for BiomeSourceError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "{self:?}")
}
}
    // rust: impl std::error::Error for BiomeSourceError {}
    // rust: impl From<DecodeError> for BiomeSourceError {
pub fn from(e: DecodeError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Decode(e)
}
}
    // rust: impl From<BiomeError> for BiomeSourceError {
pub fn from(e: BiomeError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Biome(e)
}
}
    // rust: impl From<CheckerboardError> for BiomeSourceError {
pub fn from(e: CheckerboardError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Checkerboard(e)
}
}
    // rust: impl From<SampleError> for BiomeSourceError {
pub fn from(e: SampleError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Sample(e)
}
}

pub const ResolvedBiomeSource = enum {
    Fixed(FixedBiomeSource<String>),
    Checkerboard(CheckerboardBiomeSource<String>),
    End(EndBiomeSource<String>),
    MultiNoise(MultiNoiseBiomeSource),
};
    // rust: impl BiomeSourceDefinition {
    /// Resolve a decoded definition using immutable, authenticated quantized
    /// preset tables. This does not execute vanilla's built-in preset builders.
    // rust: pub fn resolve(
    // rust: &self,
    // rust: presets: &BTreeMap<String, String>,
    // rust: ) -> Result<ResolvedBiomeSource, BiomeSourceError> {
    // rust: Ok(match self {
    // rust: Self::Fixed(biome) => ResolvedBiomeSource::Fixed(FixedBiomeSource {
    // rust: biome: biome.clone(),
    // rust: }),
    // rust: Self::Checkerboard { biomes, scale } => ResolvedBiomeSource::Checkerboard(
    // rust: CheckerboardBiomeSource::new(biomes.members().to_vec(), *scale)?,
    // rust: ),
    // rust: Self::End => ResolvedBiomeSource::End(EndBiomeSource {
    // rust: center: "minecraft:the_end".into(),
    // rust: highlands: "minecraft:end_highlands".into(),
    // rust: midlands: "minecraft:end_midlands".into(),
    // rust: islands: "minecraft:small_end_islands".into(),
    // rust: barrens: "minecraft:end_barrens".into(),
    // rust: }),
    // rust: Self::MultiNoise(entries) => {
    // rust: ResolvedBiomeSource::MultiNoise(MultiNoiseBiomeSource::new(entries.clone())?)
}
    // rust: Self::Preset { name, .. } => {
    // rust: ResolvedBiomeSource::MultiNoise(MultiNoiseBiomeSource::from_quantized_json(
    // rust: presets.get(name).ok_or(BiomeSourceError::MissingPreset)?,
    // rust: )?)
}
    // rust: })
}
}
    // rust: impl ResolvedBiomeSource {
pub fn possible_biomes(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Fixed(source) => [source.biome.as_str()].into(),
    // rust: Self::Checkerboard(source) => source.biomes.iter().map(String::as_str).collect(),
    // rust: Self::End(source) => [
    // rust: source.center.as_str(),
    // rust: source.highlands.as_str(),
    // rust: source.midlands.as_str(),
    // rust: source.islands.as_str(),
    // rust: source.barrens.as_str(),
    // rust: ]
    // rust: .into(),
    // rust: Self::MultiNoise(source) => source
    // rust: .parameters()
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|(_, name)| name.as_str())
    // rust: .collect(),
}
}
    /// Keep one resolver per worker to retain native previous-leaf tie behavior.
    /// Climate and erosion roots must share the worker's compiler/context namespace.
    // rust: pub fn resolver<'a>(
    // rust: &'a self,
    // rust: climate: &'a ClimateSampler,
    // rust: erosion: &'a dyn DensitySampler,
    // rust: ) -> BiomeSourceResolver<'a> {
    // rust: match self {
    // rust: Self::Fixed(source) => BiomeSourceResolver::Fixed(source),
    // rust: Self::Checkerboard(source) => BiomeSourceResolver::Checkerboard(source),
    // rust: Self::End(source) => BiomeSourceResolver::End(source, erosion),
    // rust: Self::MultiNoise(source) => BiomeSourceResolver::MultiNoise(source.resolver(climate)),
}
}
}
pub const BiomeSourceResolver = enum {
    Fixed(&'a FixedBiomeSource<String>),
    Checkerboard(&'a CheckerboardBiomeSource<String>),
    End(&'a EndBiomeSource<String>, &'a dyn DensitySampler),
    MultiNoise(BiomeResolver<'a>),
};
    // rust: impl<'a> BiomeSourceResolver<'a> {
    // rust: pub fn sample(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: quart: [i32; 3],
    // rust: ) -> Result<&'a str, BiomeSourceError> {
    // rust: Ok(match self {
    // rust: Self::Fixed(source) => source.biome.as_str(),
    // rust: Self::Checkerboard(source) => source.noise_biome(quart)?.as_str(),
    // rust: Self::End(source, erosion) => source.noise_biome(quart, *erosion, context)?.as_str(),
    // rust: Self::MultiNoise(source) => source.sample(context, quart)?,
    // rust: })
}
    /// Native fixed/checkerboard/End sources do not pre-sample a climate volume.
    /// Multi-noise preparation samples the full supplied quart extent once.
    // rust: pub fn prepare_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: minimum: [i32; 3],
    // rust: extents: [i32; 3],
    // rust: ) -> Result<Option<ClimateVolume>, BiomeSourceError> {
    // rust: match self {
    // rust: Self::MultiNoise(source) => Ok(Some(source.prepare_volume(context, minimum, extents)?)),
    // rust: _ => Ok(None),
}
}
    // rust: pub fn sample_prepared(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: volume: Option<&ClimateVolume>,
    // rust: quart: [i32; 3],
    // rust: ) -> Result<&'a str, BiomeSourceError> {
    // rust: if let Self::MultiNoise(source) = self {
    // rust: if let Some(volume) = volume {
    // rust: return Ok(source.sample_prepared(volume, quart)?);
}
}
    // rust: self.sample(context, quart)
}
}
