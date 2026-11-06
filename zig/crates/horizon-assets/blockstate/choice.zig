//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_choice
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Prepared model choices with vanilla random draw consumption.
// use super::{BlockStateDefinition, Variant, VariantSet, bind::SelectedModels};
// use crate::json::{Result, error};
// use horizon_core::random::RandomSource;

pub const Choice = enum {
    Single(T),
    Weighted {,
    variants: Vec<T>,
    ends: Vec<i32>,
    total: i32,
    // rust: },
};
    // rust: impl Choice<Variant> {
pub fn new(value: *VariantSet) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match value {
    // rust: VariantSet::Single(value) => Ok(Self::Single(value.clone())),
    // rust: VariantSet::Weighted(entries) => {
    // rust: let mut total = 0i32;
    // rust: let mut ends = Vec::with_capacity(entries.len());
    // rust: let mut variants = Vec::with_capacity(entries.len());
    // rust: for (variant, weight) in entries {
    // rust: if *weight <= 0 {
    // rust: return Err(error("nonpositive model weight"));
}
    // rust: total = total
    // rust: .checked_add(*weight)
    // rust: .ok_or_else(|| error("model weight overflow"))?;
    // rust: ends.push(total);
    // rust: variants.push(variant.clone());
}
    // rust: if total == 0 {
    // rust: return Err(error("empty weighted model"));
}
    // rust: Ok(Self::Weighted {
    // rust: variants,
    // rust: ends,
    // rust: total,
    // rust: })
}
}
}
}
    // rust: impl<T> Choice<T> {
    // rust: fn map<U>(&self, f: &mut impl FnMut(&T) -> U) -> Choice<U> {
    // rust: match self {
    // rust: Self::Single(value) => Choice::Single(f(value)),
    // rust: Self::Weighted {
    // rust: variants,
    // rust: ends,
    // rust: total,
    // rust: } => Choice::Weighted {
    // rust: variants: variants.iter().map(&mut *f).collect(),
    // rust: ends: ends.clone(),
    // rust: total: *total,
    // rust: },
}
}
pub fn select(self: *Self, random: *mut impl RandomSource) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Single(value) => value,
    // rust: Self::Weighted {
    // rust: variants,
    // rust: ends,
    // rust: total,
    // rust: } => {
                // A singleton weighted list still consumes the bounded draw.
    // rust: let index = random
    // rust: .next_int_bound(*total)
    // rust: .expect("validated positive model weight");
    // rust: &variants[ends.partition_point(|end| *end <= index)]
}
}
}
}
/// Compile once per definition and share across its bound block states. Prefix
/// sums avoid rebuilding weight totals or scanning all entries during selection.
/// `map` swaps each variant for what it stands for (its baked model).
pub const CompiledChoices = struct {
    variants: std.ArrayList(Choice<T)>,
    multipart: std.ArrayList(Choice<T)>,
};
    // rust: impl CompiledChoices {
pub fn new(definition: *BlockStateDefinition) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Self {
    // rust: variants: definition
    // rust: .variants
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|(_, v)| Choice::new(v))
    // rust: .collect::<Result<_>>()?,
    // rust: multipart: definition
    // rust: .multipart
    // rust: .iter()
    // rust: .flatten()
    // rust: .map(|s| Choice::new(&s.variant))
    // rust: .collect::<Result<_>>()?,
    // rust: })
}
}
    // rust: impl<T> CompiledChoices<T> {
    /// The same choices, with `f` of each variant in its place.
    // rust: pub fn map<U>(&self, mut f: impl FnMut(&T) -> U) -> CompiledChoices<U> {
    // rust: CompiledChoices {
    // rust: variants: self.variants.iter().map(|c| c.map(&mut f)).collect(),
    // rust: multipart: self.multipart.iter().map(|c| c.map(&mut f)).collect(),
}
}
    /// The variant `particleMaterial` comes from: the first entry of a weighted
    /// list (`WeightedVariants`) and, for a multipart root, of its first
    /// selector whether or not that selector applies (`MultiPartModel`).
pub fn particle_variant(self: *Self, selected: *SelectedModels) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let choice = match selected {
    // rust: SelectedModels::Variant(index) => self.variants.get(*index)?,
    // rust: SelectedModels::Multipart(_) => self.multipart.first()?,
}
    // rust: Some(match choice {
    // rust: Choice::Single(value) => value,
    // rust: Choice::Weighted { variants, .. } => variants.first()?,
    // rust: })
}
    /// Append selected variants without allocating intermediate part lists.
    // rust: pub fn collect<'a>(
    // rust: &'a self,
    // rust: selected: &SelectedModels,
    // rust: random: &mut impl RandomSource,
    // rust: output: &mut Vec<&'a T>,
    // rust: ) -> Result<()> {
    // rust: self.for_each(selected, random, |v| output.push(v))
}
    /// Each selected variant, in order. A multipart root consumes nextLong
    /// even for an empty selected subset, then resets the same random source
    /// to that seed before each selected part.
    // rust: pub fn for_each<'a>(
    // rust: &'a self,
    // rust: selected: &SelectedModels,
    // rust: random: &mut impl RandomSource,
    // rust: mut f: impl FnMut(&'a T),
    // rust: ) -> Result<()> {
    // rust: match selected {
    // rust: SelectedModels::Variant(index) => {
    // rust: let choice = self
    // rust: .variants
    // rust: .get(*index)
    // rust: .ok_or_else(|| error("invalid variant selection"))?;
    // rust: f(choice.select(random));
}
    // rust: SelectedModels::Multipart(indices) => {
    // rust: if indices.iter().any(|index| *index >= self.multipart.len()) {
    // rust: return Err(error("invalid multipart selection"));
}
    // rust: let seed = random.next_long();
    // rust: for index in indices {
    // rust: random.set_seed(seed);
    // rust: f(self.multipart[*index].select(random));
}
}
}
    // rust: Ok(())
}
}
