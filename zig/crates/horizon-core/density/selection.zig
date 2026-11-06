//! Transpiled from Horizon Rust crate
//! Module: horizon-core_selection
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;

pub const RangeChoiceSampler = struct {
    input: *dyn DensitySampler,
    min_inclusive: f32,
    max_exclusive: f32,
    when_in_range: *dyn DensitySampler,
    when_out_of_range: *dyn DensitySampler,
};
    // rust: impl RangeChoiceSampler {
pub fn contains(self: *Self, value: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value >= self.min_inclusive && value < self.max_exclusive
}
}
    // rust: impl DensitySampler for RangeChoiceSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: if self.contains(self.input.sample_value(context, position)?) {
    // rust: self.when_in_range.sample_value(context, position)
    // rust: } else {
    // rust: self.when_out_of_range.sample_value(context, position)
}
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_exact_buffer(buffer, volume)?;
        // Vanilla evaluates the in-range branch before the selector in bulk.
    // rust: self.when_in_range.sample_volume(context, buffer, volume)?;
    // rust: context.with_buffer(volume.size(), |context, input| {
    // rust: self.input.sample_volume(context, input, volume)?;
    // rust: context.with_buffer(volume.size(), |context, outside| {
    // rust: self.when_out_of_range
    // rust: .sample_volume(context, outside, volume)?;
                // A select rather than a conditional store, so the loop vectorizes.
    // rust: for ((value, &input), &outside) in buffer.iter_mut().zip(&*input).zip(&*outside) {
    // rust: *value = if self.contains(input) {
    // rust: *value
    // rust: } else {
    // rust: outside
}
}
    // rust: Ok(())
    // rust: })
    // rust: })
}
}

/// An explicitly compiled value. Distinguishing literal constants here avoids
/// scratch allocation in the constant-endpoint interpolation specializations.
pub const DensityValue = enum {
    Constant(f32),
    Sampler(Arc<dyn DensitySampler>),
};
    // rust: impl DensityValue {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: match self {
    // rust: Self::Constant(value) => Ok(*value),
    // rust: Self::Sampler(sampler) => sampler.sample_value(context, position),
}
}
    // rust: fn with_volume<T>(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: volume: DensityVolume,
    // rust: use_values: impl FnOnce(&mut SamplerContext, Values<'_>) -> Result<T, SampleError>,
    // rust: ) -> Result<T, SampleError> {
    // rust: match self {
    // rust: Self::Constant(value) => use_values(context, Values::Constant(*value)),
    // rust: Self::Sampler(sampler) => context.with_buffer(volume.size(), |context, buffer| {
    // rust: sampler.sample_volume(context, buffer, volume)?;
    // rust: use_values(context, Values::Buffer(buffer))
    // rust: }),
}
}
}
pub const Values = enum {
    Constant(f32),
    Buffer(&'a [f32]),
};
    // rust: impl Values<'_> {
pub fn get(self: *Self, index: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Constant(value) => value,
    // rust: Self::Buffer(buffer) => buffer[index],
}
}
}
pub const LerpSampler = struct {
    alpha: *dyn DensitySampler,
    first: DensityValue,
    second: DensityValue,
};
pub fn interpolate(alpha: f32, first: f32, second: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if alpha == 0.0 {
    // rust: first
    // rust: } else if alpha == 1.0 {
    // rust: second
    // rust: } else {
    // rust: first + alpha * (second - first)
}
}
    // rust: impl DensitySampler for LerpSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: let alpha = self.alpha.sample_value(context, position)?;
    // rust: if alpha == 0.0 {
    // rust: return self.first.sample_value(context, position);
}
    // rust: if alpha == 1.0 {
    // rust: return self.second.sample_value(context, position);
}
    // rust: let first = self.first.sample_value(context, position)?;
    // rust: let second = self.second.sample_value(context, position)?;
    // rust: Ok(interpolate(alpha, first, second))
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_exact_buffer(buffer, volume)?;
    // rust: self.alpha.sample_volume(context, buffer, volume)?;
    // rust: self.first.with_volume(context, volume, |context, first| {
    // rust: self.second.with_volume(context, volume, |_, second| {
    // rust: for (index, alpha) in buffer.iter_mut().enumerate() {
    // rust: *alpha = interpolate(*alpha, first.get(index), second.get(index));
}
    // rust: Ok(())
    // rust: })
    // rust: })
}
}

pub const InvalidIntervals = struct {};
    // rust: impl std::fmt::Display for InvalidIntervals {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("compiled interval selection requires one more branch than thresholds, at most 256 branches")
}
}
    // rust: impl std::error::Error for InvalidIntervals {}

/// Compiled interval selection. Threshold order is preserved, including NaNs
/// and equal thresholds; sorting and codec validation belong to the compiler.
pub const IntervalSelectSampler = struct {
    input: *dyn DensitySampler,
    thresholds: std.ArrayList(f32),
    branches: std.ArrayList(*dyn DensitySampler),
};
    // rust: impl IntervalSelectSampler {
    // rust: pub fn new(
    // rust: input: Arc<dyn DensitySampler>,
    // rust: thresholds: Vec<f32>,
    // rust: branches: Vec<Arc<dyn DensitySampler>>,
    // rust: ) -> Result<Self, InvalidIntervals> {
    // rust: if branches.len() > 256 || thresholds.len().checked_add(1) != Some(branches.len()) {
    // rust: return Err(InvalidIntervals);
}
    // rust: Ok(Self {
    // rust: input,
    // rust: thresholds,
    // rust: branches,
    // rust: })
}
pub fn select(self: *Self, value: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.thresholds
    // rust: .iter()
    // rust: .position(|threshold| value < *threshold)
    // rust: .unwrap_or(self.branches.len() - 1)
}
}
    // rust: impl DensitySampler for IntervalSelectSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: let value = self.input.sample_value(context, position)?;
    // rust: self.branches[self.select(value)].sample_value(context, position)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_exact_buffer(buffer, volume)?;
    // rust: let total = volume
    // rust: .size()
    // rust: .checked_mul(self.branches.len())
    // rust: .filter(|count| *count <= isize::MAX as usize / size_of::<f32>())
    // rust: .ok_or(DensityError::VolumeTooLarge)?;
    // rust: self.input.sample_volume(context, buffer, volume)?;
        // Contiguous retained storage replaces a separate allocation per branch.
        // Each child still receives a slice with exactly the logical volume size.
    // rust: context.with_buffer(total, |context, values| {
    // rust: for (branch, output) in self
    // rust: .branches
    // rust: .iter()
    // rust: .zip(values.chunks_exact_mut(volume.size()))
    // rust: {
    // rust: branch.sample_volume(context, output, volume)?;
}
            // Delay every output selection until all child volumes have returned.
    // rust: for (index, input) in buffer.iter_mut().enumerate() {
    // rust: *input = values[self.select(*input) * volume.size() + index];
}
    // rust: Ok(())
    // rust: })
}
}
