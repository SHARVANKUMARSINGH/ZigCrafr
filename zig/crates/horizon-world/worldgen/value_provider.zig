//! Transpiled from Horizon Rust crate
//! Module: horizon-world_value_provider
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Scalar distributions used by cave/canyon definitions. Gaussian providers
//! remain separate work; this module does not yet cover every provider.
// use super::weighted::WeightedList;
// use super::{DecodeError, Object, density::identifier, integer, number_text, required};
// use horizon_core::random::{InvalidBound, RandomSource};
// use serde_json::value::RawValue;

pub const FloatProvider = enum {
    Constant(f32),
    Uniform {,
    min: f32,
    max: f32,
    // rust: },
    Trapezoid {,
    min: f32,
    max: f32,
    plateau: f32,
    // rust: },
    ClampedNormal {,
    mean: f32,
    deviation: f32,
    min: f32,
    max: f32,
    // rust: },
};
    // rust: impl FloatProvider {
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: if let Ok(value) = float(&raw) {
    // rust: return Ok(Self::Constant(if value == 0. { 0. } else { value }));
}
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let field = |name| required(&object, name).and_then(float);
    // rust: match kind(&object)?.as_str() {
    // rust: "minecraft:constant" => {
    // rust: let value = field("value")?;
    // rust: Ok(Self::Constant(if value == 0. { 0. } else { value }))
}
    // rust: "minecraft:uniform" => {
    // rust: let (min, max) = (field("min_inclusive")?, field("max_exclusive")?);
    // rust: if max <= min {
    // rust: return Err(DecodeError::Field("uniform float bounds"));
}
    // rust: Ok(Self::Uniform { min, max })
}
    // rust: "minecraft:trapezoid" => {
    // rust: let (min, max, plateau) = (field("min")?, field("max")?, field("plateau")?);
    // rust: if max < min || plateau > max - min {
    // rust: return Err(DecodeError::Field("trapezoid float bounds"));
}
    // rust: Ok(Self::Trapezoid { min, max, plateau })
}
    // rust: "minecraft:clamped_normal" => {
    // rust: let (min, max) = (field("min")?, field("max")?);
    // rust: if max < min {
    // rust: return Err(DecodeError::Field("clamped normal float bounds"));
}
    // rust: Ok(Self::ClampedNormal {
    // rust: mean: field("mean")?,
    // rust: deviation: field("deviation")?,
    // rust: min,
    // rust: max,
    // rust: })
}
    // rust: _ => Err(DecodeError::Field("float provider type")),
}
}
pub fn bounds(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match *self {
    // rust: Self::Constant(value) => [value; 2],
    // rust: Self::Uniform { min, max }
    // rust: | Self::Trapezoid { min, max, .. }
    // rust: | Self::ClampedNormal { min, max, .. } => [min, max],
}
}
pub fn sample(self: *Self, random: *mut impl RandomSource) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match *self {
    // rust: Self::Constant(value) => value,
    // rust: Self::Uniform { min, max } => random.next_float() * (max - min) + min,
    // rust: Self::Trapezoid { min, max, plateau } => {
    // rust: let range = max - min;
    // rust: let slope = (range - plateau) / 2.;
    // rust: let middle = range - slope;
    // rust: (min + random.next_float() * middle) + random.next_float() * slope
}
    // rust: Self::ClampedNormal {
    // rust: mean,
    // rust: deviation,
    // rust: min,
    // rust: max,
    // rust: } => {
    // rust: let value = mean + random.next_gaussian() as f32 * deviation;
    // rust: if value < min { min } else { value.min(max) }
}
}
}
}

pub const IntProvider = enum {
    Weighted(WeightedList<Self>),
    Constant(i32),
    Uniform {,
    min: i32,
    max: i32,
    // rust: },
    BiasedToBottom {,
    min: i32,
    max: i32,
    // rust: },
    VeryBiasedToBottom {,
    min: i32,
    max: i32,
    // rust: },
    Trapezoid {,
    min: i32,
    max: i32,
    plateau: i32,
    // rust: },
    Clamped {,
    source: Box<Self>,
    min: i32,
    max: i32,
    // rust: },
    ClampedNormal {,
    mean: f32,
    deviation: f32,
    min: i32,
    max: i32,
    // rust: },
};
    // rust: impl IntProvider {
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: Self::decode(&raw, 0, &mut 65536)
}
    // rust: pub(crate) fn decode(
    // rust: raw: &RawValue,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth > 256 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("integer provider depth"));
}
    // rust: *remaining -= 1;
    // rust: if let Ok(value) = integer(raw) {
    // rust: return Ok(Self::Constant(value));
}
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let kind = kind(&object)?;
    // rust: let field = |name| required(&object, name).and_then(integer);
    // rust: if kind == "minecraft:constant" {
    // rust: return Ok(Self::Constant(field("value")?));
}
    // rust: if kind == "minecraft:weighted_list" {
    // rust: return Ok(Self::Weighted(WeightedList::decode(
    // rust: required(&object, "distribution")?,
    // rust: |raw| Self::decode(raw, depth + 1, remaining),
    // rust: )?));
}
    // rust: let trapezoid = kind == "minecraft:trapezoid";
    // rust: let min = field(if trapezoid { "min" } else { "min_inclusive" })?;
    // rust: let max = field(if trapezoid { "max" } else { "max_inclusive" })?;
    // rust: if max < min {
    // rust: return Err(DecodeError::Field("integer provider bounds"));
}
    // rust: match kind.as_str() {
    // rust: "minecraft:uniform" => Ok(Self::Uniform { min, max }),
    // rust: "minecraft:biased_to_bottom" => Ok(Self::BiasedToBottom { min, max }),
    // rust: "minecraft:very_biased_to_bottom" => Ok(Self::VeryBiasedToBottom { min, max }),
    // rust: "minecraft:trapezoid" => {
    // rust: let plateau = field("plateau")?;
    // rust: if plateau > max.wrapping_sub(min) {
    // rust: return Err(DecodeError::Field("integer provider plateau"));
}
    // rust: Ok(Self::Trapezoid { min, max, plateau })
}
    // rust: "minecraft:clamped_normal" => Ok(Self::ClampedNormal {
    // rust: mean: required(&object, "mean").and_then(float)?,
    // rust: deviation: required(&object, "deviation").and_then(float)?,
    // rust: min,
    // rust: max,
    // rust: }),
    // rust: "minecraft:clamped" => Ok(Self::Clamped {
    // rust: source: Box::new(Self::decode(
    // rust: required(&object, "source")?,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )?),
    // rust: min,
    // rust: max,
    // rust: }),
    // rust: _ => Err(DecodeError::Field("integer provider type")),
}
}
pub fn bounds(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Weighted(list) => {
    // rust: list.entries()
    // rust: .iter()
    // rust: .fold([i32::MAX, i32::MIN], |bounds, (provider, _)| {
    // rust: let next = provider.bounds();
    // rust: [bounds[0].min(next[0]), bounds[1].max(next[1])]
    // rust: })
}
    // rust: Self::Constant(value) => [*value; 2],
    // rust: Self::Uniform { min, max }
    // rust: | Self::BiasedToBottom { min, max }
    // rust: | Self::VeryBiasedToBottom { min, max }
    // rust: | Self::Trapezoid { min, max, .. }
    // rust: | Self::ClampedNormal { min, max, .. } => [*min, *max],
    // rust: Self::Clamped { source, min, max } => {
    // rust: let bounds = source.bounds();
    // rust: [(*min).max(bounds[0]), (*max).min(bounds[1])]
}
}
}
pub fn sample(self: *Self, random: *mut impl RandomSource) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Weighted(list) => list.sample(random)?.sample(random),
    // rust: Self::Constant(value) => Ok(*value),
    // rust: Self::Uniform { min, max } => random.next_int_between_inclusive(*min, *max),
    // rust: Self::BiasedToBottom { min, max } | Self::VeryBiasedToBottom { min, max } => {
    // rust: let mut value = random.next_int_bound(max.wrapping_sub(*min).wrapping_add(1))?;
    // rust: value = random.next_int_bound(value.wrapping_add(1))?;
    // rust: if matches!(self, Self::VeryBiasedToBottom { .. }) {
    // rust: value = random.next_int_bound(value.wrapping_add(1))?;
}
    // rust: Ok(min.wrapping_add(value))
}
    // rust: Self::Trapezoid { min, max, plateau } => {
    // rust: if *plateau == 0 && *max == min.wrapping_neg() {
    // rust: let left = random.next_int_bound(max.wrapping_add(1))?;
    // rust: let right = random.next_int_bound(max.wrapping_add(1))?;
    // rust: return Ok(left.wrapping_sub(right));
}
    // rust: let range = max.wrapping_sub(*min);
    // rust: if *plateau == range {
    // rust: return random.next_int_between_inclusive(*min, *max);
}
    // rust: let slope = range.wrapping_sub(*plateau) / 2;
    // rust: let middle = range.wrapping_sub(slope);
    // rust: let left = random.next_int_between_inclusive(0, middle)?;
    // rust: let right = random.next_int_between_inclusive(0, slope)?;
    // rust: Ok(min.wrapping_add(left).wrapping_add(right))
}
    // rust: Self::Clamped { source, min, max } => {
    // rust: let value = source.sample(random)?;
    // rust: Ok(if value < *min { *min } else { value.min(*max) })
}
            // Mth.normal, then float Mth.clamp and a saturating int cast.
    // rust: Self::ClampedNormal {
    // rust: mean,
    // rust: deviation,
    // rust: min,
    // rust: max,
    // rust: } => {
    // rust: let value = mean + random.next_gaussian() as f32 * deviation;
    // rust: let (min, max) = (*min as f32, *max as f32);
    // rust: Ok((if value < min { min } else { value.min(max) }) as i32)
}
}
}
}
pub fn float(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: number_text(raw)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("float provider number"))
}
pub fn kind(object: *Object) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: identifier(&serde_json::from_str::<String>(
    // rust: required(object, "type")?.get(),
    // rust: )?)
}
