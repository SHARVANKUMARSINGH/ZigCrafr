//! Transpiled from Horizon Rust crate
//! Module: horizon-core_terrain_noise
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use crate::{
    // rust: noise::{NoiseBuildError, NoiseStack, SmearedPerlinNoise},
    // rust: random::RandomSource,
}

pub const ShiftNoiseKind = enum {
    Shift,
    ShiftA,
    ShiftB,
};

/// Compile the three offset-noise variants without changing their bulk paths.
pub fn compile_shift_noise(noise: *dyn Noise, kind: ShiftNoiseKind) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if kind == ShiftNoiseKind::ShiftB {
    // rust: return Arc::new(ShiftBSampler { noise });
}
    // rust: Arc::new(UnarySampler {
    // rust: input: Arc::new(NoiseSampler {
    // rust: noise,
    // rust: xz_scale: 0.25,
    // rust: y_scale: if kind == ShiftNoiseKind::ShiftA {
    // rust: 0.0
    // rust: } else {
    // rust: 0.25
    // rust: },
    // rust: }),
    // rust: operation: UnaryOp::Multiply(4.0),
    // rust: })
}
pub const ShiftBSampler = struct {
    noise: *dyn Noise,
};
    // rust: impl DensitySampler for ShiftBSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: [x, _, z]: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: Ok(self.noise.get3(z as f64 * 0.25, x as f64 * 0.25, 0.0) * 4.0)
}
    // rust: fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: ) -> Result<(), SampleError> {
    // rust: check_buffer(buffer, volume)?;
    // rust: let [sx, sy, sz] = volume.sizes();
    // rust: let [mx, _, mz] = volume.minimum();
    // rust: let [dx, _, dz] = volume.steps();
    // rust: let transposed = DensityVolume::new([sz as i32, sx as i32, 1], [mz, mx, 0], [dz, dx, 1])?;
    // rust: context.with_buffer(transposed.size(), |_, plane| {
    // rust: plane.fill(0.0);
    // rust: self.noise
    // rust: .add_to_volume(plane, transposed, 0.25, 0.25, 4.0)?;
    // rust: for z in 0..sz {
    // rust: for x in 0..sx {
    // rust: let start = (x + z * sx) * sy;
    // rust: buffer[start..start + sy].fill(plane[x + z * sx]);
}
}
    // rust: Ok(())
    // rust: })
}
}

/// Parameters for vanilla's old blended terrain density function. Serialized
/// codec limits and compile-context seed lookup are separate integration work.
pub const BlendedNoise = struct {
    xz_scale: f64,
    y_scale: f64,
    xz_factor: f64,
    y_factor: f64,
    smear_scale_multiplier: f64,
};
pub const BlendedFbmSet = struct {
    min_limit: NoiseStack,
    max_limit: NoiseStack,
    main: NoiseStack,
};
    // rust: impl BlendedNoise {
    // rust: pub fn create_fbm_set(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Result<BlendedFbmSet, NoiseBuildError> {
    // rust: let smear = (684.412 * self.y_scale) * self.smear_scale_multiplier;
    // rust: let main_smear = smear / self.y_factor;
    // rust: Ok(BlendedFbmSet {
    // rust: min_limit: create_blended_fbm(random, -15, smear, 0.9999847412109375)?,
    // rust: max_limit: create_blended_fbm(random, -15, smear, 0.9999847412109375)?,
    // rust: main: create_blended_fbm(random, -7, main_smear, 12.75)?,
    // rust: })
}
pub fn compile(self: *Self, random: *mut impl RandomSource) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let layers = self.create_fbm_set(random)?;
    // rust: let xz_scale = 684.412 * self.xz_scale;
    // rust: let y_scale = 684.412 * self.y_scale;
    // rust: let min_limit = Arc::new(NoiseSampler {
    // rust: noise: Arc::new(layers.min_limit),
    // rust: xz_scale,
    // rust: y_scale,
    // rust: });
    // rust: let max_limit = Arc::new(NoiseSampler {
    // rust: noise: Arc::new(layers.max_limit),
    // rust: xz_scale,
    // rust: y_scale,
    // rust: });
    // rust: let main = Arc::new(NoiseSampler {
    // rust: noise: Arc::new(layers.main),
    // rust: xz_scale: xz_scale / self.xz_factor,
    // rust: y_scale: y_scale / self.y_factor,
    // rust: });
    // rust: let shifted = Arc::new(UnarySampler {
    // rust: input: main,
    // rust: operation: UnaryOp::Add(0.5),
    // rust: });
    // rust: let alpha = Arc::new(UnarySampler {
    // rust: input: shifted,
    // rust: operation: UnaryOp::Clamp { min: 0.0, max: 1.0 },
    // rust: });
    // rust: Ok(LerpSampler {
    // rust: alpha,
    // rust: first: DensityValue::Sampler(min_limit),
    // rust: second: DensityValue::Sampler(max_limit),
    // rust: })
}
pub fn range(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let smear = (684.412 * self.y_scale) * self.smear_scale_multiplier;
    // rust: let mut range = Interval::exact(0.0)?;
    // rust: let mut frequency = 1.0;
    // rust: let mut amplitude = 0.9999847412109375 / 65535.0;
    // rust: for _ in 0..16 {
    // rust: let base = Interval::symmetric(((smear * frequency).abs() + 2.0) as f32)?;
    // rust: range = range.add_range(base.multiply_range(Interval::exact(amplitude as f32)?));
    // rust: frequency /= 2.0;
    // rust: amplitude *= 2.0;
}
    // rust: Ok(range)
}
}

/// Construct high-to-low frequency smeared octaves, consuming the caller's
/// stream directly. The public API caps work at 4096 layers before any draws.
    // rust: pub fn create_blended_fbm(
    // rust: random: &mut impl RandomSource,
    // rust: first_octave: i32,
    // rust: smear: f64,
    // rust: amplitude: f64,
    // rust: ) -> Result<NoiseStack, NoiseBuildError> {
    // rust: if first_octave > 0 {
    // rust: return Err(NoiseBuildError::PositiveLegacyOctaves);
}
    // rust: if first_octave < -4095 {
    // rust: return Err(NoiseBuildError::TooManyOctaves);
}
    // rust: let count = 1 - first_octave;
    // rust: let power = if count > 1023 {
    // rust: f64::INFINITY
    // rust: } else {
    // rust: f64::from_bits(((count + 1023) as u64) << 52)
}
    // rust: let mut amplitude = amplitude / (power - 1.0);
    // rust: let mut frequency = 1.0;
    // rust: let mut builder = NoiseStack::builder();
    // rust: for _ in 0..count {
    // rust: builder.add(
    // rust: Arc::new(SmearedPerlinNoise::new(random, smear * frequency)),
    // rust: frequency,
    // rust: amplitude as f32,
    // rust: );
    // rust: frequency /= 2.0;
    // rust: amplitude *= 2.0;
}
    // rust: Ok(builder.build()?)
}

pub const DistanceMetric = enum {
    Euclidean,
    EuclideanSquared,
    Manhattan,
    Chebyshev,
};
    // rust: impl DistanceMetric {
pub fn compute2(self: *Self, x: f32, y: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Euclidean => ((x * x + y * y) as f64).sqrt() as f32,
    // rust: Self::EuclideanSquared => x * x + y * y,
    // rust: Self::Manhattan => x.abs() + y.abs(),
    // rust: Self::Chebyshev => arithmetic::java_max(x.abs(), y.abs()),
}
}
pub fn compute3(self: *Self, x: f32, y: f32, z: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Euclidean => ((x * x + y * y + z * z) as f64).sqrt() as f32,
    // rust: Self::EuclideanSquared => x * x + y * y + z * z,
    // rust: Self::Manhattan => x.abs() + y.abs() + z.abs(),
    // rust: Self::Chebyshev => {
    // rust: arithmetic::java_max(arithmetic::java_max(x.abs(), y.abs()), z.abs())
}
}
}
}
pub const DistanceToPointSampler = struct {
    point: [i32,
    metric: DistanceMetric,
};
    // rust: impl DensitySampler for DistanceToPointSampler {
pub fn sample_value(self: *Self, _: *mut SamplerContext, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let delta: [f32; 3] =
    // rust: std::array::from_fn(|i| self.point[i].wrapping_sub(position[i]) as f32);
    // rust: Ok(self.metric.compute3(delta[0], delta[1], delta[2]))
}
}
