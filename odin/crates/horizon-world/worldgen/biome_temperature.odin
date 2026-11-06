//! Transpiled from Horizon Rust crate
package horizon_world_biome_temperature

import "core:fmt"
import "core:mem"
import "core:math"

// Biome temperature sampling and a worker-local vanilla temperature cache.
// use super::{DecodeError, Object, number_text, optional, required};
// use horizon_core::{
    // rust: noise::{Noise, NoiseStack, SimplexNoise},
    // rust: position::BlockPos,
    // rust: random::LegacyRandom,
}
// use std::{
    // rust: collections::{HashMap, VecDeque, hash_map::Entry},
    // rust: sync::{Arc, OnceLock},
}

TemperatureModifier :: enum {
    None,
    Frozen,
}
Precipitation :: enum {
    None,
    Rain,
    Snow,
}
BiomeTemperatureSettings :: struct {
    base_temperature: f32,
    modifier: TemperatureModifier,
    has_precipitation: bool,
    downfall: f32,
}
TemperatureNoises :: struct {
    height: SimplexNoise,
    frozen: NoiseStack,
    info: SimplexNoise,
}
noises :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
NOISES :: OnceLock::new()
    // rust: NOISES.get_or_init(|| {
    // rust: let mut random = LegacyRandom::new(3456);
    // rust: let mut frozen = NoiseStack::builder();
    // rust: for (frequency, amplitude) in [
    // rust: (1.0, 1.0f32 / 7.0),
    // rust: (0.5, 2.0f32 / 7.0),
    // rust: (0.25, 4.0f32 / 7.0),
    // rust: ] {
    // rust: frozen.add(
    // rust: Arc::new(SimplexNoise::with_skipped_offsets(&mut random, true)),
    // rust: frequency,
    // rust: amplitude,
    // rust: );
}
    // rust: TemperatureNoises {
    // rust: height: SimplexNoise::with_skipped_offsets(&mut LegacyRandom::new(1234), true),
    // rust: frozen: frozen.build().expect("fixed finite noise layers"),
    // rust: info: SimplexNoise::with_skipped_offsets(&mut LegacyRandom::new(2345), true),
}
    // rust: })
}
    // rust: impl TemperatureModifier {
modify :: proc(self: ^Self, position: BlockPos, base: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self == Self::Frozen {
    // rust: let sources = noises();
    // rust: let x = f64::from(position.x);
    // rust: let z = f64::from(position.z);
    // rust: let frozen = f64::from(sources.frozen.get2(x * 0.05, z * 0.05) * 7.0);
    // rust: let info = f64::from(sources.info.get2(x * 0.2, z * 0.2));
    // rust: if frozen + info < 0.3 && f64::from(sources.info.get2(x * 0.09, z * 0.09)) < 0.8 {
    // rust: return 0.2;
}
}
    // rust: base
}
}
    // rust: impl BiomeTemperatureSettings {
    // Decode the climate fields of a biome. Other biome fields are ignored,
    // matching the native ClimateSettings map codec rather than the full biome.
from_json :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let float = |name| {
    // rust: number_text(required(&object, name)?)?
    // rust: .parse::<f32>()
    // rust: .map_err(|_| DecodeError::Field(name))
}
    // rust: let modifier = match optional(&object, "temperature_modifier") {
    // rust: None => TemperatureModifier::None,
    // rust: Some(raw) => match serde_json::from_str::<String>(raw.get())?.as_str() {
    // rust: "none" => TemperatureModifier::None,
    // rust: "frozen" => TemperatureModifier::Frozen,
    // rust: _ => return Err(DecodeError::Field("temperature_modifier")),
    // rust: },
}
    // rust: Ok(Self {
    // rust: base_temperature: float("temperature")?,
    // rust: downfall: float("downfall")?,
    // rust: has_precipitation: serde_json::from_str(required(&object, "has_precipitation")?.get())?,
    // rust: modifier,
    // rust: })
}

height_adjusted :: proc(self: ^Self, position: BlockPos, sea_level: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let base = self.modifier.modify(position, self.base_temperature);
    // rust: let start = sea_level.wrapping_add(17);
    // rust: if position.y > start {
    // rust: let variation = noises().height.get2(
    // rust: f64::from(position.x as f32 / 8.0),
    // rust: f64::from(position.z as f32 / 8.0),
    // rust: ) * 8.0;
    // rust: base - ((variation + position.y as f32 - start as f32) * 0.05 / 40.0)
    // rust: } else {
    // rust: base
}
}
}

// Keep one instance per biome per worker, matching vanilla's thread-local map.
// Hits do not reorder entries. The packed-position key deliberately omits sea
// level, so a cached value survives queries with a different sea level.
BiomeTemperature :: struct {
    settings: BiomeTemperatureSettings,
    values: HashMap<i64,
    order: VecDeque<i64>,
}
    // rust: impl BiomeTemperature {
new :: proc(settings: BiomeTemperatureSettings) -> S {
    // Ported from Horizon
    return {}
}
        // Empty until used: a decoration region makes one per biome, and
        // most biomes never ask for a temperature.
    // rust: Self {
    // rust: settings,
    // rust: values: HashMap::new(),
    // rust: order: VecDeque::new(),
}
}
settings :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.settings
}
temperature :: proc(self: ^Self, position: BlockPos, sea_level: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let key = position.pack();
    // rust: if let Some(value) = self
    // rust: .values
    // rust: .get(&key)
    // rust: .copied()
    // rust: .filter(|value| !value.is_nan())
    // rust: {
    // rust: return value;
}
    // rust: let value = self.settings.height_adjusted(position, sea_level);
        // NaN is both the missing-value sentinel and a possible stored value.
        // Recomputing an existing NaN at capacity still evicts the oldest key.
    // rust: if self.values.len() == 1024 {
    // rust: let first = self.order.pop_front().expect("full cache has entries");
    // rust: self.values.remove(&first);
}
    // rust: match self.values.entry(key) {
    // rust: Entry::Occupied(mut entry) => {
    // rust: entry.insert(value);
}
    // rust: Entry::Vacant(entry) => {
    // rust: entry.insert(value);
    // rust: self.order.push_back(key);
}
}
    // rust: value
}
warm_enough_to_rain :: proc(self: ^Self, position: BlockPos, sea_level: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.temperature(position, sea_level) >= 0.15
}
cold_enough_to_snow :: proc(self: ^Self, position: BlockPos, sea_level: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.warm_enough_to_rain(position, sea_level)
}
    // rust: pub fn should_melt_frozen_ocean_iceberg_slightly(
    // rust: &mut self,
    // rust: position: BlockPos,
    // rust: sea_level: i32,
    // rust: ) -> bool {
    // rust: self.temperature(position, sea_level) > 0.1
}
precipitation_at :: proc(self: ^Self, position: BlockPos, sea_level: i32) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if !self.settings.has_precipitation {
    // rust: Precipitation::None
    // rust: } else if self.cold_enough_to_snow(position, sea_level) {
    // rust: Precipitation::Snow
    // rust: } else {
    // rust: Precipitation::Rain
}
}
cached_temperatures :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.order.iter().map(|key| (*key, self.values[key]))
}
}

// Fixed biome-information noise shared by temperature and placement rules.
biome_info_noise :: proc(x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: noises().info.get2(x, z)
}
