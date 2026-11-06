//! Transpiled from Horizon Rust crate
//! Module: horizon-core_power
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;

/// Both operands evaluate in base/exponent order, including zero and one bases.
pub const PowerSampler = struct {
    base: *dyn DensitySampler,
    exponent: *dyn DensitySampler,
};
    // rust: impl DensitySampler for PowerSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: let base = self.base.sample_value(context, position)?;
    // rust: let exponent = self.exponent.sample_value(context, position)?;
    // rust: Ok(super::arithmetic::java_power(base as f64, exponent as f64) as f32)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_exact_buffer(buffer, volume)?;
    // rust: self.base.sample_volume(context, buffer, volume)?;
    // rust: context.with_buffer(volume.size(), |context, scratch| {
    // rust: self.exponent.sample_volume(context, scratch, volume)?;
    // rust: for (base, exponent) in buffer.iter_mut().zip(scratch) {
    // rust: *base = super::arithmetic::java_power(*base as f64, *exponent as f64) as f32;
}
    // rust: Ok(())
    // rust: })
}
}

/// Only sqrt/identity/square/cube receive the negative-exponent reciprocal.
/// Other exponents return directly from vanilla's signed fallback sampler.
    // rust: pub fn compile_constant_exponent(
    // rust: base: Arc<dyn DensitySampler>,
    // rust: exponent: f32,
    // rust: ) -> Arc<dyn DensitySampler> {
    // rust: let positive: Arc<dyn DensitySampler> = match exponent.abs() {
    // rust: 0.5 => Arc::new(UnarySampler {
    // rust: input: base,
    // rust: operation: UnaryOp::Sqrt,
    // rust: }),
    // rust: 1.0 => base,
    // rust: 2.0 => Arc::new(UnarySampler {
    // rust: input: base,
    // rust: operation: UnaryOp::Square,
    // rust: }),
    // rust: 3.0 => Arc::new(UnarySampler {
    // rust: input: base,
    // rust: operation: UnaryOp::Cube,
    // rust: }),
    // rust: _ => {
    // rust: return Arc::new(UnarySampler {
    // rust: input: base,
    // rust: operation: UnaryOp::PowerExponent(exponent as f64),
    // rust: });
}
}
    // rust: if exponent < 0.0 {
    // rust: Arc::new(UnarySampler {
    // rust: input: positive,
    // rust: operation: UnaryOp::Reciprocal,
    // rust: })
    // rust: } else {
    // rust: positive
}
}
