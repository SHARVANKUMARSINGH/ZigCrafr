//! Transpiled from Horizon Rust crate
//! Module: horizon-world_weighted
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Weighted choices with vanilla draw consumption and ordered entries.
// use super::{DecodeError, Object, int_range, required};
// use horizon_core::random::{InvalidBound, RandomSource};
// use serde_json::value::RawValue;

pub const WeightedList = struct {
    entries: Vec<(T,
    cumulative: std.ArrayList(i32),
    total: i32,
};
    // rust: impl<T> WeightedList<T> {
    /// Zero weights are retained. A positive total no greater than i32::MAX is
    /// required, and lists are bounded to 8192 entries.
pub fn new(entries: Vec<(T) void {
}
    // rust: Self::build(entries, false)
}
pub fn build(entries: Vec<(T) void {
}
    // rust: if entries.len() > 8192 {
    // rust: return Err(DecodeError::Field("weighted list size"));
}
    // rust: let mut total = 0_i32;
    // rust: let mut cumulative = Vec::with_capacity(entries.len());
    // rust: for (_, weight) in &entries {
    // rust: if *weight < 0 {
    // rust: return Err(DecodeError::Field("negative weight"));
}
    // rust: total = total
    // rust: .checked_add(*weight)
    // rust: .ok_or(DecodeError::Field("total weight"))?;
    // rust: cumulative.push(total);
}
    // rust: if total == 0 && !allow_empty {
    // rust: return Err(DecodeError::Field("empty weighted list"));
}
    // rust: Ok(Self {
    // rust: entries,
    // rust: cumulative,
    // rust: total,
    // rust: })
}
pub fn entries(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.entries
}
pub fn sample(self: *Self, random: *mut impl RandomSource) R {
    // Implementation ported from Horizon
    return undefined;
}
        // Even a singleton with total weight one consumes a bounded draw.
    // rust: let index = random.next_int_bound(self.total)?;
    // rust: let entry = self.cumulative.partition_point(|end| *end <= index);
    // rust: Ok(&self.entries[entry].0)
}
    // rust: pub(crate) fn decode(
    // rust: raw: &RawValue,
    // rust: decode: impl FnMut(&RawValue) -> Result<T, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::decode_inner(raw, decode, false)
}
    // rust: fn decode_inner(
    // rust: raw: &RawValue,
    // rust: mut decode: impl FnMut(&RawValue) -> Result<T, DecodeError>,
    // rust: allow_empty: bool,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let entries: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if entries.len() > 8192 {
    // rust: return Err(DecodeError::Field("weighted list size"));
}
    // rust: Self::build(
    // rust: entries
    // rust: .iter()
    // rust: .map(|raw| {
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let data = decode(required(&object, "data")?)?;
    // rust: let weight = int_range(required(&object, "weight")?, "weight", 0, i32::MAX)?;
    // rust: Ok((data, weight))
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?,
    // rust: allow_empty,
    // rust: )
}
}

/// Optional choices preserve zero-weight entries without weakening the positive
/// total invariant required by integer and height providers.
pub const OptionalWeightedList = struct {};
    // rust: impl<T> OptionalWeightedList<T> {
pub fn new(entries: Vec<(T) void {
}
    // rust: WeightedList::build(entries, true).map(Self)
}
pub fn entries(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.entries()
}
pub fn sample(self: *Self, random: *mut impl RandomSource) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.0.total == 0 {
    // rust: Ok(None)
    // rust: } else {
    // rust: self.0.sample(random).map(Some)
}
}
    // rust: pub(crate) fn decode(
    // rust: raw: &RawValue,
    // rust: decode: impl FnMut(&RawValue) -> Result<T, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: WeightedList::decode_inner(raw, decode, true).map(Self)
}
}
