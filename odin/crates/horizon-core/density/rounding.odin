//! Transpiled from Horizon Rust crate
package horizon_core_rounding

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

RoundMode :: enum {
    Floor,
    Round,
    Ceil,
    Truncate,
}
    // rust: impl RoundMode {
    // rust: pub(super) fn integer(self, value: f32) -> f32 {
    // rust: match self {
    // rust: Self::Floor => (value as f64).floor() as f32,
    // rust: Self::Ceil => (value as f64).ceil() as f32,
    // rust: Self::Truncate => {
    // rust: if value > 0.0 {
    // rust: (value as f64).floor() as f32
    // rust: } else {
    // rust: (value as f64).ceil() as f32
}
}
    // rust: Self::Round => {
                // Math.round(float): ties go toward positive infinity, NaNs
                // become zero, and the result saturates to Java's int domain.
    // rust: let bits = value.to_bits() as i32;
    // rust: let shift = 149 - ((bits >> 23) & 0xff);
    // rust: let rounded = if (0..32).contains(&shift) {
    // rust: let mut significand = (bits & 0x7f_ffff) | 0x80_0000;
    // rust: if bits < 0 {
    // rust: significand = -significand;
}
    // rust: ((significand >> shift) + 1) >> 1
    // rust: } else {
    // rust: value as i32
}
    // rust: rounded as f32
}
}
}
apply :: proc(self: ^Self, input: f32, multiple: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if multiple == 0.0 {
    // rust: input
    // rust: } else {
    // rust: self.integer(input / multiple) * multiple
}
}
}

// A missing multiple selects vanilla's literal-one specialization. A supplied
// sampler is evaluated even when its value is zero or always one.
RoundSampler :: struct {
    mode: RoundMode,
    input: ^dyn DensitySampler,
    multiple: Maybe(^dyn DensitySampler),
}
    // rust: impl DensitySampler for RoundSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: let input = self.input.sample_value(context, position)?;
    // rust: Ok(if let Some(multiple) = &self.multiple {
    // rust: self.mode
    // rust: .apply(input, multiple.sample_value(context, position)?)
    // rust: } else {
    // rust: self.mode.integer(input)
    // rust: })
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: if self.multiple.is_some() {
    // rust: check_exact_buffer(buffer, volume)?;
    // rust: } else {
    // rust: check_buffer(buffer, volume)?;
}
    // rust: self.input.sample_volume(context, buffer, volume)?;
    // rust: if let Some(multiple) = &self.multiple {
    // rust: context.with_buffer(volume.size(), |context, scratch| {
    // rust: multiple.sample_volume(context, scratch, volume)?;
    // rust: for (input, multiple) in buffer.iter_mut().zip(scratch) {
    // rust: *input = self.mode.apply(*input, *multiple);
}
    // rust: Ok(())
    // rust: })
    // rust: } else {
    // rust: for value in buffer {
    // rust: *value = self.mode.integer(*value);
}
    // rust: Ok(())
}
}
}
