//! Transpiled from Horizon Rust crate
//! Module: horizon-world_codec
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Registry-bound biome-source definitions. Inline full biome objects are separate.
// use crate::worldgen::{
    // rust: DecodeError, Object, RawValue,
    // rust: climate::{ParameterPoint, decode_parameter_point, unquantize},
    // rust: density::identifier,
    // rust: int_range, optional, required,
}
// use std::collections::{BTreeMap, BTreeSet};

pub const BiomeSet = enum {
    Direct(Vec<String>),
    Tag { name: String, members: Vec<String> },
};
    // rust: impl BiomeSet {
pub fn members(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Direct(values) => values,
    // rust: Self::Tag { members, .. } => members,
}
}
}
pub const BiomeSourceDefinition = enum {
    Fixed(String),
    Checkerboard { biomes: BiomeSet, scale: i32 },
    End,
    MultiNoise(Vec<(ParameterPoint, String)>),
    Preset { name: String, inline: bool },
};
pub const BiomeSourceCatalog = struct {
    biomes: BTreeSet<[]const u8>,
    tags: BTreeMap<[]const u8,
    presets: BTreeSet<[]const u8>,
};
    // rust: impl BiomeSourceCatalog {
    // rust: pub fn new(
    // rust: biomes: &BTreeSet<String>,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: presets: &BTreeSet<String>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if biomes.len() > 8192
    // rust: || tags.len() > 8192
    // rust: || presets.len() > 8192
    // rust: || tags.values().map(Vec::len).sum::<usize>() > 65536
    // rust: {
    // rust: return Err(DecodeError::Field("biome source catalog size"));
}
    // rust: let biomes = biomes
    // rust: .iter()
    // rust: .map(|v| identifier(v))
    // rust: .collect::<Result<BTreeSet<_>, _>>()?;
    // rust: let presets = presets
    // rust: .iter()
    // rust: .map(|v| identifier(v))
    // rust: .collect::<Result<BTreeSet<_>, _>>()?;
    // rust: let mut resolved = BTreeMap::new();
    // rust: for (name, members) in tags {
    // rust: let members = members
    // rust: .iter()
    // rust: .map(|v| identifier(v))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: if members.iter().any(|v| !biomes.contains(v)) {
    // rust: return Err(DecodeError::Field("unknown biome tag member"));
}
    // rust: if resolved.insert(identifier(name)?, members).is_some() {
    // rust: return Err(DecodeError::Field("duplicate biome tag"));
}
}
    // rust: Ok(Self {
    // rust: biomes,
    // rust: tags: resolved,
    // rust: presets,
    // rust: })
}
pub fn biome(self: *Self, raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = identifier(&serde_json::from_str::<String>(raw.get())?)?;
    // rust: if !self.biomes.contains(&name) {
    // rust: return Err(DecodeError::Field("unknown biome"));
}
    // rust: Ok(name)
}
pub fn set(self: *Self, raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if raw.get().starts_with('"') {
    // rust: let name: String = serde_json::from_str(raw.get())?;
    // rust: if let Some(name) = name.strip_prefix('#') {
    // rust: let name = identifier(name)?;
    // rust: let members = self
    // rust: .tags
    // rust: .get(&name)
    // rust: .ok_or(DecodeError::Field("unknown biome tag"))?
    // rust: .clone();
    // rust: return Ok(BiomeSet::Tag { name, members });
}
    // rust: return Ok(BiomeSet::Direct(vec![self.biome(raw)?]));
}
    // rust: let values: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if values.len() > 8192 {
    // rust: return Err(DecodeError::Field("biome holder set size"));
}
    // rust: Ok(BiomeSet::Direct(
    // rust: values
    // rust: .iter()
    // rust: .map(|v| self.biome(v))
    // rust: .collect::<Result<_, _>>()?,
    // rust: ))
}
pub fn inline(self: *Self, raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entries: Vec<Object> = serde_json::from_str(raw.get())?;
    // rust: if entries.is_empty() || entries.len() > 65536 {
    // rust: return Err(DecodeError::Field("multi-noise entry count"));
}
    // rust: let mut result = Vec::with_capacity(entries.len());
    // rust: for entry in entries {
    // rust: result.push((
    // rust: decode_parameter_point(required(&entry, "parameters")?.get())?,
    // rust: self.biome(required(&entry, "biome")?)?,
    // rust: ));
}
    // rust: Ok(BiomeSourceDefinition::MultiNoise(result))
}
pub fn decode(self: *Self, json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: Ok(match kind.as_str() {
    // rust: "minecraft:fixed" => {
    // rust: BiomeSourceDefinition::Fixed(self.biome(required(&object, "biome")?)?)
}
    // rust: "minecraft:checkerboard" => BiomeSourceDefinition::Checkerboard {
    // rust: biomes: self.set(required(&object, "biomes")?)?,
    // rust: scale: optional(&object, "scale")
    // rust: .map_or(Ok(2), |v| int_range(v, "biome scale", 0, 62))?,
    // rust: },
    // rust: "minecraft:the_end" => {
    // rust: for name in [
    // rust: "the_end",
    // rust: "end_highlands",
    // rust: "end_midlands",
    // rust: "small_end_islands",
    // rust: "end_barrens",
    // rust: ] {
    // rust: if !self.biomes.contains(&format!("minecraft:{name}")) {
    // rust: return Err(DecodeError::Field("missing End biome"));
}
}
    // rust: BiomeSourceDefinition::End
}
    // rust: "minecraft:multi_noise" => {
                // mapEither prefers a successful inline list, then tries preset.
    // rust: if let Some(raw) = optional(&object, "biomes") {
    // rust: if let Ok(value) = self.inline(raw) {
    // rust: return Ok(value);
}
}
    // rust: let raw = required(&object, "preset")?;
    // rust: if raw.get().starts_with('"') {
    // rust: let name = identifier(&serde_json::from_str::<String>(raw.get())?)?;
    // rust: if !self.presets.contains(&name) {
    // rust: return Err(DecodeError::Field("unknown biome preset holder"));
}
    // rust: BiomeSourceDefinition::Preset {
    // rust: name,
    // rust: inline: false,
}
    // rust: } else {
    // rust: let preset: Object = serde_json::from_str(raw.get())?;
    // rust: let name = identifier(&serde_json::from_str::<String>(
    // rust: required(&preset, "preset")?.get(),
    // rust: )?)?;
    // rust: if !matches!(name.as_str(), "minecraft:overworld" | "minecraft:nether") {
    // rust: return Err(DecodeError::Field("unknown built-in biome preset"));
}
    // rust: BiomeSourceDefinition::Preset { name, inline: true }
}
}
    // rust: _ => return Err(DecodeError::Field("unknown biome source")),
    // rust: })
}
    /// Encode definitions in the vanilla canonical shape; decoding the result
    /// validates registry references and bounds before publishing JSON.
pub fn encode(self: *Self, definition: *BiomeSourceDefinition) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (kind, fields) = match definition {
    // rust: BiomeSourceDefinition::Fixed(name) => ("fixed", format!(",\"biome\":{}", quoted(name))),
    // rust: BiomeSourceDefinition::End => ("the_end", String::new()),
    // rust: BiomeSourceDefinition::Checkerboard { biomes, scale } => {
    // rust: let values = match biomes {
    // rust: BiomeSet::Tag { name, .. } => quoted(&format!("#{name}")),
    // rust: BiomeSet::Direct(values) if values.len() == 1 => quoted(&values[0]),
    // rust: BiomeSet::Direct(values) => serde_json::to_string(values)?,
}
    // rust: (
    // rust: "checkerboard",
    // rust: format!(
    // rust: ",\"biomes\":{values}{}",
    // rust: if *scale == 2 {
    // rust: String::new()
    // rust: } else {
    // rust: format!(",\"scale\":{scale}")
}
    // rust: ),
    // rust: )
}
    // rust: BiomeSourceDefinition::MultiNoise(entries) => {
    // rust: let values = entries
    // rust: .iter()
    // rust: .map(|(point, name)| {
    // rust: format!(
    // rust: "{{\"parameters\":{},\"biome\":{}}}",
    // rust: point_json(point),
    // rust: quoted(name)
    // rust: )
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .join(",");
    // rust: ("multi_noise", format!(",\"biomes\":[{values}]"))
}
    // rust: BiomeSourceDefinition::Preset { name, inline } => {
    // rust: let value = if *inline {
    // rust: format!("{{\"preset\":{}}}", quoted(name))
    // rust: } else {
    // rust: quoted(name)
}
    // rust: ("multi_noise", format!(",\"preset\":{value}"))
}
}
    // rust: let json = format!("{{\"type\":\"minecraft:{kind}\"{fields}}}");
    // rust: self.decode(&json)?;
    // rust: Ok(json)
}
}
pub fn quoted(value: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: serde_json::to_string(value).expect("string serializes")
}
pub fn point_json(point: *ParameterPoint) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names = [
    // rust: "temperature",
    // rust: "humidity",
    // rust: "continentalness",
    // rust: "erosion",
    // rust: "depth",
    // rust: "weirdness",
    // rust: ];
    // rust: let mut fields = Vec::with_capacity(7);
    // rust: for (name, p) in names.into_iter().zip(point.coordinates) {
    // rust: let min = serde_json::to_string(&unquantize(p.min)).expect("finite coordinate");
    // rust: let max = serde_json::to_string(&unquantize(p.max)).expect("finite coordinate");
    // rust: let value = if min == max {
    // rust: min
    // rust: } else {
    // rust: format!("[{min},{max}]")
}
    // rust: fields.push(format!("{}:{value}", quoted(name)));
}
    // rust: fields.push(format!(
    // rust: "\"offset\":{}",
    // rust: serde_json::to_string(&unquantize(point.offset)).expect("finite offset")
    // rust: ));
    // rust: format!("{{{}}}", fields.join(","))
}
