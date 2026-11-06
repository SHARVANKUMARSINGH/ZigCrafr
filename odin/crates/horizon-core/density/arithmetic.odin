//! Transpiled from Horizon Rust crate
package horizon_core_arithmetic

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

    // rust: pub(super) fn java_power(base: f64, exponent: f64) -> f64 {
    // Native libm can propagate a signaling NaN base even for exponent zero;
    // Java returns one for every base in this case.
    // rust: if exponent == 0.0 {
    // rust: 1.0
    // rust: } else if exponent.is_nan() || (base.abs() == 1.0 && exponent.is_infinite()) {
    // rust: f64::NAN
    // rust: } else {
    // rust: crate::jmath::pow(base, exponent)
}
}

    // rust: pub(super) fn java_min(a: f32, b: f32) -> f32 {
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f32::from_bits(a.to_bits() | b.to_bits())
    // rust: } else if a <= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
    // rust: pub(super) fn java_max(a: f32, b: f32) -> f32 {
    // rust: if a.is_nan() || b.is_nan() {
    // rust: f32::NAN
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f32::from_bits(a.to_bits() & b.to_bits())
    // rust: } else if a >= b {
    // rust: a
    // rust: } else {
    // rust: b
}
}
clamp :: proc(value: f32, min: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if value < min {
    // rust: min
    // rust: } else {
    // rust: java_min(value, max)
}
}

// Selected compiled unary samplers, including constant-operand specializations.
// Graph compilation is implemented separately.
UnaryOp :: enum {
    Abs,
    Negate,
    Square,
    Cube,
    Sqrt,
    Log,
    PowerBase(f64),
    PowerExponent(f64),
    Reciprocal,
    Sign,
    Squeeze,
    LeakyRelu(f32),
    Add(f32),
    SubtractFrom(f32),
    Multiply(f32),
    DivideInto(f32),
    Minimum(f32),
    Maximum(f32),
    ConstantRangeChoice {,
    min_inclusive: f32,
    max_exclusive: f32,
    inside: f32,
    outside: f32,
    // rust: },
    Clamp {,
    min: f32,
    max: f32,
    // rust: },
}
// One expression definition for scalar dispatch and specialized bulk loops.
    // rust: macro_rules! unary_apply {
    // rust: ($operation:expr, $value:expr, $bulk:expr) => {{
    // rust: let value = $value;
    // rust: let bulk = $bulk;
    // rust: match $operation {
    // rust: Self::Abs => value.abs(),
    // rust: Self::Negate => -value,
    // rust: Self::Square => value * value,
    // rust: Self::Cube => value * value * value,
    // rust: Self::Sqrt => (value as f64).sqrt() as f32,
    // rust: Self::Log => crate::jmath::log(value as f64) as f32,
    // rust: Self::PowerBase(base) => java_power(base, value as f64) as f32,
    // rust: Self::PowerExponent(exponent) => java_power(value as f64, exponent) as f32,
    // rust: Self::Reciprocal => 1.0 / value,
    // rust: Self::Sign => {
    // rust: if value == 0.0 || value.is_nan() {
    // rust: value
    // rust: } else {
    // rust: value.signum()
}
}
    // rust: Self::Squeeze => {
    // rust: let v = clamp(value, -1.0, 1.0);
    // rust: v / 2.0 - v * v * v / 24.0
}
    // rust: Self::LeakyRelu(factor) => {
    // rust: if value > 0.0 {
    // rust: value
    // rust: } else {
    // rust: value * factor
}
}
    // rust: Self::Add(right) => value + right,
    // rust: Self::SubtractFrom(left) => left - value,
    // rust: Self::Multiply(right) => value * right,
    // rust: Self::DivideInto(left) => left / value,
    // rust: Self::Minimum(right) => {
    // rust: if bulk {
    // rust: if right < value { right } else { value }
    // rust: } else {
    // rust: java_min(value, right)
}
}
    // rust: Self::Maximum(right) => {
    // rust: if bulk {
    // rust: if right > value { right } else { value }
    // rust: } else {
    // rust: java_max(value, right)
}
}
    // rust: Self::Clamp { min, max } => clamp(value, min, max),
    // rust: Self::ConstantRangeChoice {
    // rust: min_inclusive,
    // rust: max_exclusive,
    // rust: inside,
    // rust: outside,
    // rust: } => {
    // rust: if value >= min_inclusive && value < max_exclusive {
    // rust: inside
    // rust: } else {
    // rust: outside
}
}
}
    // rust: }};
}
    // rust: impl UnaryOp {
    // rust: pub(super) fn apply(self, value: f32, bulk: bool) -> f32 {
    // rust: unary_apply!(self, value, bulk)
}
    // Dispatch once per volume so each loop has one fixed arithmetic operation.
    // Keep the scalar expression shared, including the bulk min/max behavior.
apply_bulk :: proc(self: ^Self, buffer: ^[f32]) {
}
        // Specialization can reverse which NaN operand supplies the payload.
        // Retain the original dispatch for non-finite constant operands.
    // rust: let non_finite = match self {
    // rust: Self::PowerBase(value) | Self::PowerExponent(value) => !value.is_finite(),
    // rust: Self::LeakyRelu(value)
    // rust: | Self::Add(value)
    // rust: | Self::SubtractFrom(value)
    // rust: | Self::Multiply(value)
    // rust: | Self::DivideInto(value)
    // rust: | Self::Minimum(value)
    // rust: | Self::Maximum(value) => !value.is_finite(),
    // rust: Self::Clamp { min, max } => !min.is_finite() || !max.is_finite(),
    // rust: Self::ConstantRangeChoice {
    // rust: min_inclusive,
    // rust: max_exclusive,
    // rust: inside,
    // rust: outside,
    // rust: } => {
    // rust: !min_inclusive.is_finite()
    // rust: || !max_exclusive.is_finite()
    // rust: || !inside.is_finite()
    // rust: || !outside.is_finite()
}
    // rust: _ => false,
}
    // rust: if non_finite {
    // rust: for value in buffer {
    // rust: *value = self.apply(*value, true);
}
    // rust: return;
}
    // rust: macro_rules! apply {
    // rust: ($operation:expr) => {
    // rust: for value in buffer {
    // rust: *value = unary_apply!($operation, *value, true);
}
}
}
    // rust: match self {
    // rust: Self::Abs => apply!(Self::Abs),
    // rust: Self::Negate => apply!(Self::Negate),
    // rust: Self::Square => apply!(Self::Square),
    // rust: Self::Cube => apply!(Self::Cube),
    // rust: Self::Sqrt => apply!(Self::Sqrt),
    // rust: Self::Log => apply!(Self::Log),
    // rust: Self::PowerBase(base) => apply!(Self::PowerBase(base)),
    // rust: Self::PowerExponent(exponent) => apply!(Self::PowerExponent(exponent)),
    // rust: Self::Reciprocal => apply!(Self::Reciprocal),
    // rust: Self::Sign => apply!(Self::Sign),
    // rust: Self::Squeeze => apply!(Self::Squeeze),
    // rust: Self::LeakyRelu(factor) => apply!(Self::LeakyRelu(factor)),
    // rust: Self::Add(right) => apply!(Self::Add(right)),
    // rust: Self::SubtractFrom(left) => apply!(Self::SubtractFrom(left)),
    // rust: Self::Multiply(right) => apply!(Self::Multiply(right)),
    // rust: Self::DivideInto(left) => apply!(Self::DivideInto(left)),
    // rust: Self::Minimum(right) => apply!(Self::Minimum(right)),
    // rust: Self::Maximum(right) => apply!(Self::Maximum(right)),
    // rust: Self::ConstantRangeChoice {
    // rust: min_inclusive,
    // rust: max_exclusive,
    // rust: inside,
    // rust: outside,
    // rust: } => apply!(Self::ConstantRangeChoice {
    // rust: min_inclusive,
    // rust: max_exclusive,
    // rust: inside,
    // rust: outside
    // rust: }),
    // rust: Self::Clamp { min, max } => apply!(Self::Clamp { min, max }),
}
}
}
UnarySampler :: struct {
    input: ^dyn DensitySampler,
    operation: UnaryOp,
}
    // rust: impl DensitySampler for UnarySampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: Ok(self
    // rust: .operation
    // rust: .apply(self.input.sample_value(context, position)?, false))
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_buffer(buffer, volume)?;
    // rust: self.input.sample_volume(context, buffer, volume)?;
    // rust: self.operation.apply_bulk(buffer);
    // rust: Ok(())
}
}

// Range bounds are the values baked into vanilla's compiled min/max samplers.
// Computing those bounds from a density graph is a separate compiler step.
BinaryOp :: enum {
    Add,
    Subtract,
    Multiply,
    Divide,
    Minimum { right_min: f32 },
    Maximum { right_max: f32 },
}
    // rust: impl BinaryOp {
apply :: proc(self: ^Self, left: f32, right: f32, bulk: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Add => left + right,
    // rust: Self::Subtract => left - right,
    // rust: Self::Multiply => left * right,
    // rust: Self::Divide => left / right,
    // rust: Self::Minimum { .. } => {
    // rust: if bulk {
    // rust: if right < left { right } else { left }
    // rust: } else {
    // rust: java_min(left, right)
}
}
    // rust: Self::Maximum { .. } => {
    // rust: if bulk {
    // rust: if right > left { right } else { left }
    // rust: } else {
    // rust: java_max(left, right)
}
}
}
}
apply_bulk :: proc(self: ^Self, buffer: ^[f32], right: ^[f32]) {
}
    // rust: macro_rules! apply {
    // rust: ($operation:expr) => {
    // rust: for (left, &right) in buffer.iter_mut().zip(right) {
    // rust: *left = ($operation)(*left, right);
}
}
}
    // rust: match self {
    // rust: Self::Add => apply!(|left, right| left + right),
    // rust: Self::Subtract => apply!(|left, right| left - right),
    // rust: Self::Multiply => apply!(|left, right| left * right),
    // rust: Self::Divide => apply!(|left, right| left / right),
    // rust: Self::Minimum { .. } => apply!(|left, right| if right < left { right } else { left }),
    // rust: Self::Maximum { .. } => apply!(|left, right| if right > left { right } else { left }),
}
}
}
BinarySampler :: struct {
    left: ^dyn DensitySampler,
    right: ^dyn DensitySampler,
    operation: BinaryOp,
}
    // rust: impl DensitySampler for BinarySampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: let left = self.left.sample_value(context, position)?;
    // rust: match self.operation {
    // rust: BinaryOp::Multiply | BinaryOp::Divide if left == 0.0 => return Ok(0.0),
    // rust: BinaryOp::Minimum { right_min } if left <= right_min => return Ok(left),
    // rust: BinaryOp::Maximum { right_max } if left >= right_max => return Ok(left),
    // rust: _ => {}
}
    // rust: Ok(self
    // rust: .operation
    // rust: .apply(left, self.right.sample_value(context, position)?, false))
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_exact_buffer(buffer, volume)?;
        // Vanilla reads a volume-sized temporary through every output index.
        // Restrict this API to the valid equal-size case before invoking children.
    // rust: self.left.sample_volume(context, buffer, volume)?;
    // rust: context.with_buffer(volume.size(), |context, right| {
    // rust: self.right.sample_volume(context, right, volume)?;
    // rust: self.operation.apply_bulk(buffer, right);
    // rust: Ok(())
    // rust: })
}
}

    // rust: mod bulk_tests {
//     use super::*;

dispatched_reference :: proc(operation: UnaryOp, value: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: operation.apply(value, true)
}

fixed_operation_loops_preserve_float_bits :: proc() {
}
    // rust: let mut operations = vec![
    // rust: UnaryOp::Abs,
    // rust: UnaryOp::Negate,
    // rust: UnaryOp::Square,
    // rust: UnaryOp::Cube,
    // rust: UnaryOp::Sqrt,
    // rust: UnaryOp::Log,
    // rust: UnaryOp::Reciprocal,
    // rust: UnaryOp::Sign,
    // rust: UnaryOp::Squeeze,
    // rust: ];
    // rust: for factor in [0.0, -0.0, 0.5, -1.0, f32::INFINITY, f32::NAN] {
    // rust: operations.extend([
    // rust: UnaryOp::LeakyRelu(factor),
    // rust: UnaryOp::Add(factor),
    // rust: UnaryOp::SubtractFrom(factor),
    // rust: UnaryOp::Multiply(factor),
    // rust: UnaryOp::DivideInto(factor),
    // rust: UnaryOp::Minimum(factor),
    // rust: UnaryOp::Maximum(factor),
    // rust: UnaryOp::Clamp {
    // rust: min: -factor,
    // rust: max: factor,
    // rust: },
    // rust: UnaryOp::ConstantRangeChoice {
    // rust: min_inclusive: -factor,
    // rust: max_exclusive: factor,
    // rust: inside: -0.0,
    // rust: outside: 17.0,
    // rust: },
    // rust: ]);
}
    // rust: for exponent in [0.0, -0.0, 0.5, -1.0, 2.0, 3.0, f64::INFINITY, f64::NAN] {
    // rust: operations.extend([
    // rust: UnaryOp::PowerBase(exponent),
    // rust: UnaryOp::PowerExponent(exponent),
    // rust: ]);
}
    // rust: let mut values: Vec<f32> = [
    // rust: 0,
    // rust: 0x8000_0000,
    // rust: 1,
    // rust: 0x8000_0001,
    // rust: 0x007f_ffff,
    // rust: 0x0080_0000,
    // rust: 0x3f00_0000,
    // rust: 0xbf00_0000,
    // rust: 0x3f80_0000,
    // rust: 0xbf80_0000,
    // rust: 0x7f7f_ffff,
    // rust: 0xff7f_ffff,
    // rust: 0x7f80_0000,
    // rust: 0xff80_0000,
    // rust: 0x7fc0_0000,
    // rust: 0x7fa0_0001,
    // rust: 0xffc0_1234,
    // rust: ]
    // rust: .into_iter()
    // rust: .map(f32::from_bits)
    // rust: .collect();
    // rust: let mut bits = 0x484f_5249u32;
    // rust: for _ in 0..4096 {
    // rust: bits ^= bits << 13;
    // rust: bits ^= bits >> 17;
    // rust: bits ^= bits << 5;
    // rust: values.push(f32::from_bits(bits));
}
    // rust: for operation in operations {
    // rust: for length in [0, 1, 3, 16, 257, values.len()] {
    // rust: let mut actual = values[..length].to_vec();
    // rust: operation.apply_bulk(&mut actual);
    // rust: for (i, (&input, actual)) in values.iter().zip(actual).enumerate() {
    // rust: let expected = dispatched_reference(operation, input);
    // rust: assert_eq!(
    // rust: actual.to_bits(),
    // rust: expected.to_bits(),
    // rust: "{operation:?}, index {i}, input {input:?}"
    // rust: );
}
}
}
}

dispatched_binary_reference :: proc(operation: BinaryOp, left: f32, right: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: operation.apply(left, right, true)
}

fixed_binary_loops_preserve_float_bits :: proc() {
}
    // rust: let edges = [
    // rust: 0,
    // rust: 0x8000_0000,
    // rust: 1,
    // rust: 0x8000_0001,
    // rust: 0x007f_ffff,
    // rust: 0x0080_0000,
    // rust: 0x3f80_0000,
    // rust: 0xbf80_0000,
    // rust: 0x7f7f_ffff,
    // rust: 0xff7f_ffff,
    // rust: 0x7f80_0000,
    // rust: 0xff80_0000,
    // rust: 0x7fc0_0000,
    // rust: 0x7fa0_0001,
    // rust: 0xffc0_1234,
    // rust: ];
    // rust: let mut left = Vec::new();
    // rust: let mut right = Vec::new();
    // rust: for a in edges {
    // rust: for b in edges {
    // rust: left.push(f32::from_bits(a));
    // rust: right.push(f32::from_bits(b));
}
}
    // rust: let mut bits = 0x484f_5249u32;
    // rust: for _ in 0..8192 {
    // rust: bits ^= bits << 13;
    // rust: bits ^= bits >> 17;
    // rust: bits ^= bits << 5;
    // rust: left.push(f32::from_bits(bits));
    // rust: bits ^= bits << 13;
    // rust: bits ^= bits >> 17;
    // rust: bits ^= bits << 5;
    // rust: right.push(f32::from_bits(bits));
}
    // rust: for operation in [
    // rust: BinaryOp::Add,
    // rust: BinaryOp::Subtract,
    // rust: BinaryOp::Multiply,
    // rust: BinaryOp::Divide,
    // rust: BinaryOp::Minimum {
    // rust: right_min: f32::NEG_INFINITY,
    // rust: },
    // rust: BinaryOp::Maximum {
    // rust: right_max: f32::INFINITY,
    // rust: },
    // rust: ] {
    // rust: for length in [0, 1, 3, 16, 257, left.len()] {
    // rust: let mut actual = left[..length].to_vec();
    // rust: operation.apply_bulk(&mut actual, &right[..length]);
    // rust: for (i, actual) in actual.into_iter().enumerate() {
    // rust: let expected = dispatched_binary_reference(operation, left[i], right[i]);
    // rust: assert_eq!(
    // rust: actual.to_bits(),
    // rust: expected.to_bits(),
    // rust: "{operation:?}, index {i}"
    // rust: );
}
}
}
}
}
