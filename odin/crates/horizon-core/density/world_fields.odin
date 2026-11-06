//! Transpiled from Horizon Rust crate
package horizon_core_world_fields

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

// Vanilla's three density fields, resolved at evaluation time rather than
// during graph compilation. Their declared ranges do not inspect bindings.
WorldField :: enum {
    BlendAlpha,
    BlendOffset,
    Beardifier,
}
    // rust: impl WorldField {
domain_axes :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::BlendAlpha | Self::BlendOffset => 5,
    // rust: Self::Beardifier => 7,
}
}
range :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::BlendAlpha => Interval::new(0.0, 1.0).unwrap(),
    // rust: Self::BlendOffset | Self::Beardifier => Interval::INFINITE,
}
}
fallback :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::BlendAlpha => 1.0,
    // rust: Self::BlendOffset | Self::Beardifier => 0.0,
}
}
}

// Old-world blending provider. The full vanilla Blender data model and
// distance-weighting algorithm are a separate, still pending implementation.
    // rust: pub trait DensityBlender: std::fmt::Debug + Send + Sync {
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
blend_density :: proc(self: ^Self, position: [i32; 3], input: f32) -> f {
    // Ported from Horizon
    return {}
}
}

EmptyBlender :: struct {
    // rust: impl DensityBlender for EmptyBlender {
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
blend_density :: proc(self: ^Self, _: [i32; 3], input: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: input
}
}

// Bindings can be assembled and shared between workers. Attaching new
// bindings consumes the worker context and invalidates its cached densities.
WorldFields :: struct {
    samplers: [Maybe(^dyn DensitySampler),
    blender: Maybe(^dyn DensityBlender),
}
    // rust: impl WorldFields {
with_field :: proc(field: WorldField, sampler: ^dyn DensitySampler) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.samplers[field as usize] = Some(sampler);
    // rust: self
}
with_blender :: proc(blender: ^dyn DensityBlender) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.blender = Some(blender);
    // rust: self
}
}
    // rust: impl SamplerContext {
with_world_fields :: proc(fields: WorldFields) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.clear_caches();
    // rust: self.fields = fields;
    // rust: self
}
}

ContextBoundSampler :: struct {
    field: WorldField,
    fallback: ^dyn DensitySampler,
}
    // rust: impl ContextBoundSampler {
new :: proc(field: WorldField) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::with_fallback(field, Arc::new(ConstantSampler(field.fallback())))
}
    // The vanilla sampler also permits a fallback supplied by its caller.
with_fallback :: proc(field: WorldField, fallback: ^dyn DensitySampler) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { field, fallback }
}
resolve :: proc(self: ^Self, context: ^SamplerContext) -> A {
    // Ported from Horizon
    return {}
}
    // rust: context.fields.samplers[self.field as usize]
    // rust: .as_ref()
    // rust: .unwrap_or(&self.fallback)
    // rust: .clone()
}
}
    // rust: impl DensitySampler for ContextBoundSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: self.resolve(context).sample_value(context, position)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: self.resolve(context).sample_volume(context, buffer, volume)
}
}

BlendDensitySampler :: struct {
    input: ^dyn DensitySampler,
}
    // rust: impl DensitySampler for BlendDensitySampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: let input = self.input.sample_value(context, position)?;
    // rust: let Some(blender) = &context.fields.blender else {
    // rust: return Ok(input);
}
    // rust: Ok(if blender.is_empty() {
    // rust: input
    // rust: } else {
    // rust: blender.blend_density(position, input)
    // rust: })
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: self.input.sample_volume(context, buffer, volume)?;
    // rust: let Some(blender) = &context.fields.blender else {
    // rust: return Ok(());
}
    // rust: if blender.is_empty() {
    // rust: return Ok(());
}
    // rust: visit(volume, |index, position| {
    // rust: buffer[index] = blender.blend_density(position, buffer[index]);
    // rust: Ok(())
    // rust: })
}
}
