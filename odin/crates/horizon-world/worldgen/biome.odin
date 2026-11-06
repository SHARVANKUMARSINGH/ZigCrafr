//! Transpiled from Horizon Rust crate
package horizon_world_biome

import "core:fmt"
import "core:mem"
import "core:math"

// Multi-noise biome resolution over an imported immutable parameter table.
// Vanilla biome JSON codecs and built-in preset builders remain separate work.
// use super::{
    // rust: DecodeError,
    // rust: climate::{
    // rust: ClimateIndex, ClimateSampler, ClimateSearch, ClimateVolume, IndexError, Parameter,
    // rust: ParameterPoint,
    // rust: },
    // rust: density::identifier,
}
// use horizon_core::density::{SampleError, SamplerContext};

// Identity within an immutable biome registry snapshot.
BiomeId :: struct {

BiomeError :: enum {
    Decode(DecodeError),
    Index(IndexError),
    Sample(SampleError),
    OutsideVolume,
}
    // rust: impl std::fmt::Display for BiomeError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Decode(e) => e.fmt(f),
    // rust: Self::Index(e) => e.fmt(f),
    // rust: Self::Sample(e) => e.fmt(f),
    // rust: Self::OutsideVolume => f.write_str("biome query is outside the prepared quart volume"),
}
}
}
    // rust: impl std::error::Error for BiomeError {}
    // rust: impl From<DecodeError> for BiomeError {
from :: proc(e: DecodeError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Decode(e)
}
}
    // rust: impl From<IndexError> for BiomeError {
from :: proc(e: IndexError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Index(e)
}
}
    // rust: impl From<SampleError> for BiomeError {
from :: proc(e: SampleError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Sample(e)
}
}

MultiNoiseBiomeSource :: struct {
    parameters: ClimateIndex<string>,
}
    // rust: impl MultiNoiseBiomeSource {
new :: proc(entries: Vec<(ParameterPoint) {
}
    // rust: let entries = entries
    // rust: .into_iter()
    // rust: .map(|(point, name)| Ok((point, identifier(&name)?)))
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: Ok(Self {
    // rust: parameters: ClimateIndex::new(entries)?,
    // rust: })
}
    // Horizon's quantized import format, not the vanilla biome definition
    // codec: [{"coordinates":[[min,max]; six],"offset":long,"biome":id}].
    // Built-in numeric tables stay private and are authenticated by the runner.
from_quantized_json :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let input: serde_json::Value = serde_json::from_str(json).map_err(DecodeError::from)?;
    // rust: let mut entries = Vec::new();
    // rust: for entry in input
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("biome parameter list"))?
    // rust: {
    // rust: let raw = entry["coordinates"]
    // rust: .as_array()
    // rust: .filter(|v| v.len() == 6)
    // rust: .ok_or(DecodeError::Field("climate coordinates"))?;
    // rust: let mut coordinates = [Parameter::new(0, 0); 6];
    // rust: for (coordinate, raw) in coordinates.iter_mut().zip(raw) {
    // rust: let raw = raw
    // rust: .as_array()
    // rust: .filter(|v| v.len() == 2)
    // rust: .ok_or(DecodeError::Field("climate interval"))?;
    // rust: *coordinate = Parameter::new(
    // rust: raw[0]
    // rust: .as_i64()
    // rust: .ok_or(DecodeError::Field("climate minimum"))?,
    // rust: raw[1]
    // rust: .as_i64()
    // rust: .ok_or(DecodeError::Field("climate maximum"))?,
    // rust: );
}
    // rust: let offset = entry["offset"]
    // rust: .as_i64()
    // rust: .ok_or(DecodeError::Field("climate offset"))?;
    // rust: let biome = entry["biome"]
    // rust: .as_str()
    // rust: .ok_or(DecodeError::Field("biome identifier"))?;
    // rust: entries.push((
    // rust: ParameterPoint {
    // rust: coordinates,
    // rust: offset,
    // rust: },
    // rust: biome.to_owned(),
    // rust: ));
}
    // rust: Self::new(entries)
}
parameters :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.parameters
}
    // rust: pub fn resolver<'a>(&'a self, climate: &'a ClimateSampler) -> BiomeResolver<'a> {
    // rust: BiomeResolver {
    // rust: climate,
    // rust: search: self.parameters.searcher(),
}
}
}
BiomeResolver :: struct {
    climate: ^'a ClimateSampler,
    search: ClimateSearch<'a,
}
    // rust: impl<'a> BiomeResolver<'a> {
    // rust: pub fn sample(
    // rust: &mut self,
    // rust: context: &mut SamplerContext,
    // rust: quart: [i32; 3],
    // rust: ) -> Result<&'a str, BiomeError> {
    // rust: Ok(self
    // rust: .search
    // rust: .find(self.climate.sample(context, quart)?)?
    // rust: .as_str())
}
    // rust: pub fn prepare_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: minimum: [i32; 3],
    // rust: extents: [i32; 3],
    // rust: ) -> Result<ClimateVolume, BiomeError> {
    // rust: Ok(self.climate.sample_volume(context, minimum, extents)?)
}
    // Query order shares the same previous-leaf state as scalar resolution.
    // rust: pub fn sample_prepared(
    // rust: &mut self,
    // rust: volume: &ClimateVolume,
    // rust: quart: [i32; 3],
    // rust: ) -> Result<&'a str, BiomeError> {
    // rust: let target = volume.target(quart).ok_or(BiomeError::OutsideVolume)?;
    // rust: Ok(self.search.find(target)?.as_str())
}
}
