//! Transpiled from Horizon Rust crate
//! Module: horizon-world_height_provider
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Anchored scalar height distributions used by cave and canyon generation.
//! Codec encoding remains separate work.
// use super::{
    // rust: DecodeError, Object,
    // rust: anchor::{VerticalAnchor, WorldGenerationContext},
    // rust: density::identifier,
    // rust: int_range, integer, optional, required,
    // rust: weighted::WeightedList,
}
// use horizon_core::random::{InvalidBound, RandomSource};

pub const HeightProvider = enum {
    Weighted(WeightedList<Self>),
    Constant(VerticalAnchor),
    Uniform {,
    min: VerticalAnchor,
    max: VerticalAnchor,
    // rust: },
    BiasedToBottom {,
    min: VerticalAnchor,
    max: VerticalAnchor,
    inner: i32,
    // rust: },
    VeryBiasedToBottom {,
    min: VerticalAnchor,
    max: VerticalAnchor,
    inner: i32,
    // rust: },
    Trapezoid {,
    min: VerticalAnchor,
    max: VerticalAnchor,
    plateau: i32,
    // rust: },
};
    // rust: impl HeightProvider {
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::decode(json, 0, &mut 65536)
}
pub fn decode(json: []const u8, depth: usize, remaining: *mut usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if depth > 256 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("height provider depth or node count"));
}
    // rust: *remaining -= 1;
    // rust: if let Ok(anchor) = VerticalAnchor::from_json(json) {
    // rust: return Ok(Self::Constant(anchor));
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: let anchor = |name| VerticalAnchor::from_json(required(&object, name)?.get());
    // rust: if kind == "minecraft:constant" {
    // rust: return Ok(Self::Constant(anchor("value")?));
}
    // rust: if kind == "minecraft:weighted_list" {
    // rust: return Ok(Self::Weighted(WeightedList::decode(
    // rust: required(&object, "distribution")?,
    // rust: |raw| Self::decode(raw.get(), depth + 1, remaining),
    // rust: )?));
}
    // rust: let min = anchor("min_inclusive")?;
    // rust: let max = anchor("max_inclusive")?;
    // rust: match kind.as_str() {
    // rust: "minecraft:uniform" => Ok(Self::Uniform { min, max }),
    // rust: "minecraft:biased_to_bottom" | "minecraft:very_biased_to_bottom" => {
    // rust: let inner = optional(&object, "inner")
    // rust: .map(|raw| int_range(raw, "inner", 1, i32::MAX))
    // rust: .transpose()?
    // rust: .unwrap_or(1);
    // rust: Ok(if kind == "minecraft:biased_to_bottom" {
    // rust: Self::BiasedToBottom { min, max, inner }
    // rust: } else {
    // rust: Self::VeryBiasedToBottom { min, max, inner }
    // rust: })
}
    // rust: "minecraft:trapezoid" => Ok(Self::Trapezoid {
    // rust: min,
    // rust: max,
    // rust: plateau: optional(&object, "plateau")
    // rust: .map(integer)
    // rust: .transpose()?
    // rust: .unwrap_or(0),
    // rust: }),
    // rust: _ => Err(DecodeError::Field("height provider type")),
}
}
    // rust: pub fn sample(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: context: WorldGenerationContext,
    // rust: ) -> Result<i32, InvalidBound> {
    // rust: let (min, max) = match self {
    // rust: Self::Weighted(list) => return list.sample(random)?.sample(random, context),
    // rust: Self::Constant(anchor) => return Ok(anchor.resolve(context)),
    // rust: Self::Uniform { min, max }
    // rust: | Self::BiasedToBottom { min, max, .. }
    // rust: | Self::VeryBiasedToBottom { min, max, .. }
    // rust: | Self::Trapezoid { min, max, .. } => (min.resolve(context), max.resolve(context)),
}
    // rust: match self {
    // rust: Self::Constant(_) | Self::Weighted(_) => unreachable!(),
    // rust: Self::Uniform { .. } => {
    // rust: if min > max {
    // rust: Ok(min)
    // rust: } else {
    // rust: random.next_int_between_inclusive(min, max)
}
}
    // rust: Self::BiasedToBottom { inner, .. } | Self::VeryBiasedToBottom { inner, .. } => {
    // rust: let range = max.wrapping_sub(min).wrapping_sub(*inner).wrapping_add(1);
    // rust: if range <= 0 {
    // rust: return Ok(min);
}
    // rust: if matches!(self, Self::BiasedToBottom { .. }) {
    // rust: let first = random.next_int_bound(range)?;
    // rust: Ok(random
    // rust: .next_int_bound(first.wrapping_add(*inner))?
    // rust: .wrapping_add(min))
    // rust: } else {
    // rust: let first = next_int(random, min.wrapping_add(*inner), max)?;
    // rust: let second = next_int(random, min, first.wrapping_sub(1))?;
    // rust: next_int(random, min, second.wrapping_sub(1).wrapping_add(*inner))
}
}
    // rust: Self::Trapezoid { plateau, .. } => {
    // rust: if min > max {
    // rust: return Ok(min);
}
    // rust: let range = max.wrapping_sub(min);
    // rust: if *plateau >= range {
    // rust: return random.next_int_between_inclusive(min, max);
}
    // rust: let slope = range.wrapping_sub(*plateau) / 2;
    // rust: let middle = range.wrapping_sub(slope);
    // rust: let left = random.next_int_between_inclusive(0, middle)?;
    // rust: let right = random.next_int_between_inclusive(0, slope)?;
    // rust: Ok(min.wrapping_add(left).wrapping_add(right))
}
}
}
}
pub fn next_int(random: *mut impl RandomSource, min: i32, max: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min >= max {
    // rust: Ok(min)
    // rust: } else {
    // rust: random.next_int_between_inclusive(min, max)
}
}
