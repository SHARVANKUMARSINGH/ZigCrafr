//! Transpiled from Horizon Rust crate
//! Module: horizon-world_noise
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::{StateProviderBindings, StateProviderError};
// use crate::registry::BlockStateId;
// use crate::worldgen::{
    // rust: DecodeError, Object, decode_noise, int_range, integer, number_text, required,
}
// use horizon_core::{
    // rust: noise::{Noise, NoiseStack},
    // rust: random::{LegacyRandom, RandomSource, WorldgenRandom},
}
// use serde_json::value::RawValue;
    // rust: pub(super) struct NoiseProvider {
    // rust: noise: NoiseStack,
    // rust: scale: f32,
    // rust: choice: Choice,
}
pub const Choice = enum {
    States(Vec<BlockStateId>),
    Threshold {,
    threshold: f32,
    chance: f32,
    default: BlockStateId,
    low: Vec<BlockStateId>,
    high: Vec<BlockStateId>,
    // rust: },
    Dual {,
    states: Vec<BlockStateId>,
    variety: [i32; 2],
    slow: NoiseStack,
    scale: f32,
    // rust: },
};
    // rust: impl NoiseProvider {
    // rust: pub fn decode(
    // rust: object: &Object,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: kind: &str,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let seed = long(required(object, "seed")?)?;
    // rust: let noise = decode_noise(required(object, "noise")?.get())?
    // rust: .create(&mut WorldgenRandom::new(LegacyRandom::new(seed)))?;
    // rust: let scale = positive(required(object, "scale")?)?;
    // rust: let choice = match kind {
    // rust: "minecraft:noise" => Choice::States(states(required(object, "states")?, bindings)?),
    // rust: "minecraft:noise_threshold" => Choice::Threshold {
    // rust: threshold: range(required(object, "threshold")?, -1., 1.)?,
    // rust: chance: range(required(object, "high_chance")?, 0., 1.)?,
    // rust: default: bindings.state(required(object, "default_state")?.get(), false)?,
    // rust: low: states(required(object, "low_states")?, bindings)?,
    // rust: high: states(required(object, "high_states")?, bindings)?,
    // rust: },
    // rust: "minecraft:dual_noise" => Choice::Dual {
    // rust: states: states(required(object, "states")?, bindings)?,
    // rust: variety: variety(required(object, "variety")?)?,
    // rust: slow: decode_noise(required(object, "slow_noise")?.get())?
    // rust: .create(&mut WorldgenRandom::new(LegacyRandom::new(seed)))?,
    // rust: scale: positive(required(object, "slow_scale")?)?,
    // rust: },
    // rust: _ => return Err(DecodeError::Field("noise state provider type")),
}
    // rust: Ok(Self {
    // rust: noise,
    // rust: scale,
    // rust: choice,
    // rust: })
}
    // rust: pub fn sample<E>(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: p: [i32; 3],
    // rust: ) -> Result<BlockStateId, StateProviderError<E>> {
    // rust: let fast = || {
    // rust: self.noise.get3(
    // rust: f64::from(p[0]) * f64::from(self.scale),
    // rust: f64::from(p[1]) * f64::from(self.scale),
    // rust: f64::from(p[2]) * f64::from(self.scale),
    // rust: )
}
    // rust: Ok(match &self.choice {
    // rust: Choice::States(states) => states[index(fast(), states.len())],
    // rust: Choice::Threshold {
    // rust: threshold,
    // rust: chance,
    // rust: default,
    // rust: low,
    // rust: high,
    // rust: } => {
    // rust: if fast() < *threshold {
    // rust: low[random.next_int_bound(low.len() as i32)? as usize]
    // rust: } else if random.next_float() < *chance {
    // rust: high[random.next_int_bound(high.len() as i32)? as usize]
    // rust: } else {
    // rust: *default
}
}
    // rust: Choice::Dual {
    // rust: states,
    // rust: variety,
    // rust: slow,
    // rust: scale,
    // rust: } => {
                // The slow path intentionally multiplies at float precision.
    // rust: let sample = |p: [i32; 3]| {
    // rust: slow.get3(
    // rust: f64::from(p[0] as f32 * *scale),
    // rust: f64::from(p[1] as f32 * *scale),
    // rust: f64::from(p[2] as f32 * *scale),
    // rust: )
}
    // rust: let fraction = (f64::from(sample(p)) - -1.) / 2.;
    // rust: let low = f64::from(variety[0]);
    // rust: let high = f64::from(variety[1] + 1);
    // rust: let count = (if fraction < 0. {
    // rust: low
    // rust: } else if fraction > 1. {
    // rust: high
    // rust: } else {
    // rust: low + fraction * (high - low)
    // rust: }) as i32;
    // rust: if count <= 0 {
    // rust: return Err(StateProviderError::EmptyNoiseSelection);
}
                // Every candidate is a pure noise query. Compute just the one
                // the final fast-noise lookup selects, avoiding a temporary list.
    // rust: let selected = index(fast(), count as usize) as i32;
    // rust: let offset = [
    // rust: p[0].wrapping_add(selected.wrapping_mul(54545)),
    // rust: p[1],
    // rust: p[2].wrapping_add(selected.wrapping_mul(34234)),
    // rust: ];
    // rust: states[index(sample(offset), states.len())]
}
    // rust: })
}
}
pub fn index(noise: f32, count: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (((1.0f32 + noise) / 2.0f32).clamp(0., 0.9999) * count as f32) as usize
}
    // rust: fn states(
    // rust: raw: &RawValue,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: ) -> Result<Vec<BlockStateId>, DecodeError> {
    // rust: let values: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if values.is_empty() || values.len() > 8192 {
    // rust: return Err(DecodeError::Field("noise provider states"));
}
    // rust: values
    // rust: .iter()
    // rust: .map(|v| bindings.state(v.get(), false))
    // rust: .collect()
}
pub fn float(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: number_text(raw)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("provider float"))
}
pub fn positive(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = float(raw)?;
    // rust: if value > 0. && value <= f32::MAX {
    // rust: Ok(value)
    // rust: } else {
    // rust: Err(DecodeError::Field("positive provider scale"))
}
}
pub fn range(raw: *RawValue, low: f32, high: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = float(raw)?;
    // rust: if value.total_cmp(&low).is_ge() && value.total_cmp(&high).is_le() {
    // rust: Ok(value)
    // rust: } else {
    // rust: Err(DecodeError::Field("provider float range"))
}
}
pub fn variety(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let range = if let Ok(value) = integer(raw) {
    // rust: [value, value]
    // rust: } else if let Ok(values) = serde_json::from_str::<Vec<Box<RawValue>>>(raw.get()) {
    // rust: if values.len() != 2 {
    // rust: return Err(DecodeError::Field("provider variety"));
}
    // rust: [integer(&values[0])?, integer(&values[1])?]
    // rust: } else {
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: [
    // rust: int_range(required(&object, "min_inclusive")?, "variety", 1, 64)?,
    // rust: int_range(required(&object, "max_inclusive")?, "variety", 1, 64)?,
    // rust: ]
}
    // rust: if range[0] < 1 || range[1] > 64 || range[0] > range[1] {
    // rust: Err(DecodeError::Field("provider variety"))
    // rust: } else {
    // rust: Ok(range)
}
}
// Gson's LONG codec truncates decimal tokens and retains the low 64 bits.
pub fn long(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = number_text(raw)?;
    // rust: let negative = text.starts_with('-');
    // rust: let text = text.strip_prefix('-').unwrap_or(text);
    // rust: let (mantissa, exponent) = match text.split_once(['e', 'E']) {
    // rust: Some((m, e)) => (
    // rust: m,
    // rust: e.parse::<i32>()
    // rust: .map_err(|_| DecodeError::Field("long exponent"))? as i64,
    // rust: ),
    // rust: None => (text, 0),
}
    // rust: let (whole, fraction) = mantissa.split_once('.').unwrap_or((mantissa, ""));
    // rust: let length = whole.len() as i64 + exponent;
    // rust: if length <= 0 {
    // rust: return Ok(0);
}
    // rust: let zeroes = (length - (whole.len() + fraction.len()) as i64).max(0);
    // rust: if zeroes >= 64 {
    // rust: return Ok(0);
}
    // rust: let mut result = 0u64;
    // rust: for digit in whole.bytes().chain(fraction.bytes()).take(length as usize) {
    // rust: result = result
    // rust: .wrapping_mul(10)
    // rust: .wrapping_add(u64::from(digit - b'0'));
}
    // rust: for _ in 0..zeroes {
    // rust: result = result.wrapping_mul(10);
}
    // rust: Ok(if negative {
    // rust: result.wrapping_neg()
    // rust: } else {
    // rust: result
    // rust: } as i64)
}
