//! Transpiled from Horizon Rust crate
package horizon_world_worldgen

import "core:fmt"
import "core:mem"
import "core:math"

// Version-specific noise, density registry and terrain-router JSON decoding.
// Complete terrain generation remains pending.
    // rust: pub mod anchor;
    // rust: pub mod aquifer;
    // rust: pub mod bamboo;
    // rust: pub mod biome;
    // rust: pub mod biome_chunk;
    // rust: pub mod biome_predicate;
    // rust: pub mod biome_source;
    // rust: pub mod biome_temperature;
    // rust: pub mod biome_weather;
    // rust: pub mod blending;
    // rust: pub mod block_blob;
    // rust: pub mod block_column;
    // rust: pub mod block_feature;
    // rust: pub mod block_pile;
    // rust: pub mod block_predicate;
    // rust: pub mod blue_ice;
    // rust: pub mod bonus_chest;
    // rust: pub mod bulk_section;
    // rust: pub mod carver;
    // rust: pub mod carving;
    // rust: pub mod cave;
    // rust: pub mod chorus_plant;
    // rust: pub mod climate;
    // rust: pub mod decoration;
    // rust: pub mod decoration_order;
    // rust: pub mod delta;
    // rust: pub mod density;
    // rust: pub mod disk;
    // rust: pub mod dripstone;
    // rust: pub mod end_gateway;
    // rust: pub mod end_podium;
    // rust: pub mod end_spike;
    // rust: pub mod feature;
    // rust: pub mod feature_catalog;
    // rust: pub mod feature_graph;
    // rust: pub mod feature_region;
    // rust: pub mod feature_sort;
    // rust: pub mod fluid_predicate;
    // rust: pub mod fungus;
    // rust: pub mod generator;
    // rust: mod generator_blocks;
    // rust: mod generator_decoration;
    // rust: mod generator_structures;
    // rust: pub mod height_provider;
    // rust: pub mod iceberg;
    // rust: pub mod live;
    // rust: mod long_set;
    // rust: pub mod material_condition;
    // rust: pub mod material_extensions;
    // rust: pub mod material_stage;
    // rust: pub mod material_surface;
    // rust: pub mod ore_feature;
    // rust: pub mod overrides;
    // rust: pub mod placement;
    // rust: pub mod projected;
    // rust: pub mod replace_blobs;
    // rust: pub mod root_system;
    // rust: pub mod router;
    // rust: pub mod rule_test;
    // rust: pub mod sculk;
    // rust: pub mod settings;
    // rust: pub mod simple_block;
    // rust: pub mod snow_freeze;
    // rust: pub mod spawn_finder;
    // rust: pub mod speleothem;
    // rust: pub mod spike;
    // rust: pub mod spring;
    // rust: pub mod state_provider;
    // rust: pub mod structure;
    // rust: pub mod tags;
    // rust: pub mod terrain;
    // rust: pub mod tree;
    // rust: pub(crate) mod tree_blocks;
    // rust: pub mod underwater_magma;
    // rust: pub mod value_provider;
    // rust: pub mod vegetation;
    // rust: pub mod vines;
    // rust: pub mod weighted;
    // rust: pub mod write_zone;
// use horizon_core::noise::{NoiseBuildError, NormalNoise, Normalization};
// use serde_json::value::RawValue;
// use std::collections::BTreeMap;

DecodeError :: enum {
    Json(serde_json::Error),
    Field(&'static str),
    Noise(NoiseBuildError),
    Graph(horizon_core::density::graph::CompileError),
    Sample(horizon_core::density::SampleError),
    Registry(String),
}
    // rust: impl std::fmt::Display for DecodeError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Json(error) => error.fmt(f),
    // rust: Self::Field(field) => write!(f, "invalid world generation field: {field}"),
    // rust: Self::Noise(error) => error.fmt(f),
    // rust: Self::Graph(error) => error.fmt(f),
    // rust: Self::Sample(error) => error.fmt(f),
    // rust: Self::Registry(error) => f.write_str(error),
}
}
}
    // rust: impl std::error::Error for DecodeError {}
    // rust: impl From<serde_json::Error> for DecodeError {
from :: proc(value: serde_json::Error) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Json(value)
}
}
    // rust: impl From<NoiseBuildError> for DecodeError {
from :: proc(value: NoiseBuildError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Noise(value)
}
}

    // rust: impl From<horizon_core::density::graph::CompileError> for DecodeError {
from :: proc(value: horizon_core::density::graph::CompileError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Graph(value)
}
}

    // rust: impl From<horizon_core::density::SampleError> for DecodeError {
from :: proc(value: horizon_core::density::SampleError) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Sample(value)
}
}

    // rust: type Object = BTreeMap<String, Box<RawValue>>;
    // rust: fn optional<'a>(object: &'a Object, name: &str) -> Option<&'a RawValue> {
    // rust: object
    // rust: .get(name)
    // rust: .map(AsRef::as_ref)
    // rust: .filter(|raw| raw.get() != "null")
}
    // rust: fn required<'a>(object: &'a Object, name: &'static str) -> Result<&'a RawValue, DecodeError> {
    // rust: optional(object, name).ok_or(DecodeError::Field(name))
}
number_text :: proc(raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let text = raw.get();
    // rust: if text.starts_with('-') || text.starts_with(|c: char| c.is_ascii_digit()) {
    // rust: Ok(text)
    // rust: } else {
    // rust: Err(DecodeError::Field("number"))
}
}
double :: proc(raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: number_text(raw)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("number"))
}

// Gson's lazily parsed numbers use BigDecimal.intValue for decimal/exponent
// forms: truncate toward zero, then retain the low 32 bits. Converting through
// f64 would both round large integers and saturate rather than wrap.
integer :: proc(raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let text = number_text(raw)?;
    // rust: let negative = text.starts_with('-');
    // rust: let text = text.strip_prefix('-').unwrap_or(text);
    // rust: let (mantissa, exponent) = match text.split_once(['e', 'E']) {
    // rust: Some((mantissa, exponent)) => (
    // rust: mantissa,
    // rust: exponent
    // rust: .parse::<i32>()
    // rust: .map_err(|_| DecodeError::Field("integer exponent"))? as i64,
    // rust: ),
    // rust: None => (text, 0),
}
    // rust: let (whole, fraction) = mantissa.split_once('.').unwrap_or((mantissa, ""));
    // rust: let digits = whole.bytes().chain(fraction.bytes());
    // rust: let length = whole.len() as i64 + exponent;
    // rust: if length <= 0 {
    // rust: return Ok(0);
}
    // rust: let available = whole.len() as i64 + fraction.len() as i64;
    // rust: let zeroes = (length - available).max(0);
    // rust: if zeroes >= 32 {
    // rust: return Ok(0);
}
    // rust: let mut result = 0u32;
    // rust: for digit in digits.take(length as usize) {
    // rust: result = result
    // rust: .wrapping_mul(10)
    // rust: .wrapping_add(u32::from(digit - b'0'));
}
    // rust: for _ in 0..zeroes {
    // rust: result = result.wrapping_mul(10);
}
    // rust: Ok(if negative {
    // rust: result.wrapping_neg()
    // rust: } else {
    // rust: result
    // rust: } as i32)
}
int_range :: proc(raw: ^RawValue, name: ^'static str, low: i32, high: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let value = integer(raw)?;
    // rust: if (low..=high).contains(&value) {
    // rust: Ok(value)
    // rust: } else {
    // rust: Err(DecodeError::Field(name))
}
}
    // rust: fn double_range(
    // rust: raw: &RawValue,
    // rust: name: &'static str,
    // rust: low: f64,
    // rust: high: f64,
    // rust: ) -> Result<f64, DecodeError> {
    // rust: let value = double(raw)?;
    // rust: if value.total_cmp(&low).is_ge() && value.total_cmp(&high).is_le() {
    // rust: Ok(value)
    // rust: } else {
    // rust: Err(DecodeError::Field(name))
}
}

// Decode Java Edition 26.3's direct normal-noise parameters from strict JSON.
// Numeric tokens retain their decimal text; all rounding occurs at the target
// numeric width. Unknown object fields are ignored, as in vanilla's codec.
decode_noise :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let base = int_range(required(&object, "base_octave")?, "base_octave", -32, 32)?;
    // rust: let count = optional(&object, "octave_count")
    // rust: .map(|raw| int_range(raw, "octave_count", 1, 32))
    // rust: .transpose()?
    // rust: .unwrap_or(1);
    // rust: let amplitude = optional(&object, "base_amplitude")
    // rust: .map(|raw| double_range(raw, "base_amplitude", 1e-5f32 as f64, 1e6))
    // rust: .transpose()?
    // rust: .unwrap_or(1.0);
    // rust: let normalize = match optional(&object, "normalize") {
    // rust: None => Normalization::Enabled,
    // rust: Some(raw) => match raw.get() {
    // rust: "true" => Normalization::Enabled,
    // rust: "false" => Normalization::Disabled,
    // rust: text if text.starts_with('"') && serde_json::from_str::<String>(text)? == "legacy" => {
    // rust: Normalization::Legacy
}
    // rust: _ => return Err(DecodeError::Field("normalize")),
    // rust: },
}
    // rust: let modifiers: Vec<Box<RawValue>> = optional(&object, "amplitude_modifiers")
    // rust: .map(|raw| serde_json::from_str(raw.get()))
    // rust: .transpose()?
    // rust: .unwrap_or_default();
    // rust: if modifiers.len() > 32 || (!modifiers.is_empty() && modifiers.len() != count as usize) {
    // rust: return Err(DecodeError::Field("amplitude_modifiers"));
}
    // rust: let mut builder = NormalNoise::builder();
    // rust: builder
    // rust: .set_base_octave(base)
    // rust: .set_base_amplitude(amplitude)
    // rust: .set_normalization(normalize);
    // rust: builder.set_octave_count(count)?;
    // rust: for (index, modifier) in modifiers.iter().enumerate() {
    // rust: builder.set_amplitude_modifier(
    // rust: index as i32,
    // rust: double_range(modifier, "amplitude_modifiers", 0.0, 1e6)?,
    // rust: )?;
}
    // rust: Ok(builder.build()?)
}

    // rust: mod tests {
//     use super::*;
decimal_integers_wrap_without_floating_point_conversion :: proc() {
}
    // rust: for (text, expected) in [
    // rust: ("4294967295", -1),
    // rust: ("4294967296.5", 0),
    // rust: ("-4294967297.9", -1),
    // rust: ("1.9999999999999999999", 1),
    // rust: ("12e1", 120),
    // rust: ("123e-1", 12),
    // rust: ("-123e-3", 0),
    // rust: ("123e99", 0),
    // rust: ] {
    // rust: let raw: Box<RawValue> = serde_json::from_str(text).unwrap();
    // rust: assert_eq!(integer(&raw).unwrap(), expected, "{text}");
}
}
codec_defaults_and_empty_modifiers_match_explicit_parameters :: proc() {
}
    // rust: let a = decode_noise(r#"{"base_octave":-7}"#).unwrap();
    // rust: let b = decode_noise(r#"{"base_octave":-7,"base_amplitude":1,"octave_count":1,"normalize":true,"amplitude_modifiers":[],"unknown":42}"#).unwrap();
    // rust: assert_eq!(a.range(), b.range());
    // rust: assert_eq!(a.normalization_factor(), b.normalization_factor());
    // rust: assert_eq!(a.octaves().len(), b.octaves().len());
    // rust: assert!(decode_noise(r#"{"base_octave":-7,"octave_count":0}"#).is_err());
    // rust: assert!(decode_noise(r#"{"base_octave":-7,"normalize":0}"#).is_err());
    // rust: assert!(decode_noise(r#"{"base_octave":-7,"amplitude_modifiers":[-0]}"#).is_err());
    // rust: assert!(decode_noise(r#"{"base_octave":-7,"amplitude_modifiers":[-0.0]}"#).is_err());
    // rust: assert!(
    // rust: decode_noise(r#"{"base_octave":-7,"octave_count":2,"amplitude_modifiers":[1]}"#)
    // rust: .is_err()
    // rust: );
}
}
