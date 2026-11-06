//! Transpiled from Horizon Rust crate
//! Module: horizon-core_mod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Base noise samplers for the pinned 26.3 target.
//!
//! Coordinates use double precision; Perlin interpolation and its derivatives
//! use single precision. Keep operation order: algebraic rearrangement changes
//! world generation. Complete density graphs and terrain generation remain absent.
    // rust: mod normal;
    // rust: mod perlin;
    // rust: mod simplex;
    // rust: mod stack;
    // rust: mod volume;

    // rust: pub use normal::{
    // rust: NoiseBuildError, NormalNoise, NormalNoiseBuilder, Normalization, OctaveInfo, create_legacy_fbm,
}
    // rust: pub use perlin::{PerlinNoise, SmearedPerlinNoise};
    // rust: pub use simplex::SimplexNoise;
    // rust: pub use stack::{Noise, NoiseLayer, NoiseStack, NoiseStackBuilder};
    // rust: pub use volume::{DensityError, DensityVolume};

// use crate::random::RandomSource;

pub const NanRange = struct {};
    // rust: impl std::fmt::Display for NanRange {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("noise interval bounds cannot include NaN")
}
}
    // rust: impl std::error::Error for NanRange {}

/// The immutable offsets and permutation table shared by gradient samplers.
pub const GradientTable = struct {
    offsets: [f64,
    permutations: [u8,
};

    // rust: impl GradientTable {
pub fn new(random: *mut impl RandomSource, offset_scale: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
        // Zero scale still consumes all three draws.
    // rust: let offsets = std::array::from_fn(|_| random.next_double() * offset_scale);
    // rust: let mut permutations = std::array::from_fn(|i| i as u8);
    // rust: for i in 0..256 {
    // rust: let other = i + random.next_int_bound((256 - i) as i32).unwrap() as usize;
    // rust: permutations.swap(i, other);
}
    // rust: Self {
    // rust: offsets,
    // rust: permutations,
}
}

pub fn offsets(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.offsets
}
pub fn permutations(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.permutations
}

pub fn permute(self: *Self, index: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: i32::from(self.permutations[(index & 255) as usize])
}
}

// Perlin's 16-direction table includes four repeated directions. Simplex uses
// the first twelve directions, selecting them with remainder instead of masking.
    // rust: const GRADIENTS: [[i32; 3]; 16] = [
    // rust: [1, 1, 0],
    // rust: [-1, 1, 0],
    // rust: [1, -1, 0],
    // rust: [-1, -1, 0],
    // rust: [1, 0, 1],
    // rust: [-1, 0, 1],
    // rust: [1, 0, -1],
    // rust: [-1, 0, -1],
    // rust: [0, 1, 1],
    // rust: [0, -1, 1],
    // rust: [0, 1, -1],
    // rust: [0, -1, -1],
    // rust: [1, 1, 0],
    // rust: [0, -1, 1],
    // rust: [-1, 1, 0],
    // rust: [0, -1, -1],
    // rust: ];

/// [`GRADIENTS`] as floats, so a dot product needs no conversions: every
/// component is -1, 0 or 1, which a float holds exactly.
    // rust: const PERLIN_GRADIENTS: [[f32; 3]; 16] = {
    // rust: let mut out = [[0.0; 3]; 16];
    // rust: let mut i = 0;
    // rust: while i < 16 {
    // rust: out[i] = [
    // rust: GRADIENTS[i][0] as f32,
    // rust: GRADIENTS[i][1] as f32,
    // rust: GRADIENTS[i][2] as f32,
    // rust: ];
    // rust: i += 1;
}
    // rust: out
}

pub fn dot(gradient: [f32; 3], point: [f32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: gradient[0] * point[0] + gradient[1] * point[1] + gradient[2] * point[2]
}

/// Vanilla's periodic coordinate reduction with the normal Far Lands flag off.
/// The fast-path boundary is the double immediately below 2^24.
pub fn wrap(value: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = f64::from_bits(16_777_216.0_f64.to_bits() - 1);
    // rust: if value >= -half && value < half {
    // rust: value
    // rust: } else {
    // rust: value - (value / 33_554_432.0 + 0.5).floor() * 33_554_432.0
}
}

pub fn smoothstep(value: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value * value * value * (value * (value * 6.0 - 15.0) + 10.0)
}
pub fn smoothstep_derivative(value: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 30.0 * value * value * (value - 1.0) * (value - 1.0)
}
pub fn lerp(delta: f32, start: f32, end: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: start + delta * (end - start)
}
pub fn lerp2(a: f32, b: f32, values: [f32; 4]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lerp(
    // rust: b,
    // rust: lerp(a, values[0], values[1]),
    // rust: lerp(a, values[2], values[3]),
    // rust: )
}
pub fn lerp3(fade: [f32; 3], values: [f32; 8]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lerp(
    // rust: fade[2],
    // rust: lerp2(fade[0], fade[1], values[..4].try_into().unwrap()),
    // rust: lerp2(fade[0], fade[1], values[4..].try_into().unwrap()),
    // rust: )
}

    // rust: mod tests {
//     use super::*;
//     use crate::{geometry::Axis, random::LegacyRandom};

pub fn vanilla_seed_zero_samples_and_derivatives() void {
}
        // Values captured by the original adapter from the pinned server JAR.
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let noise = PerlinNoise::new(&mut random);
    // rust: assert_eq!(random.next_long(), -6_819_959_017_335_327_829);
    // rust: let mut derivative = [0.0; 3];
    // rust: assert_eq!(
    // rust: noise
    // rust: .noise_with_derivative(0.0, 0.0, 0.0, &mut derivative)
    // rust: .to_bits(),
    // rust: 3_183_733_582
    // rust: );
    // rust: assert_eq!(
    // rust: derivative.map(f32::to_bits),
    // rust: [3_189_117_465, 3_214_556_526, 1_017_326_887]
    // rust: );
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let simplex = SimplexNoise::with_skipped_offsets(&mut random, true);
    // rust: assert_eq!(simplex.table().offsets(), &[0.0; 3]);
    // rust: assert_eq!(simplex.table().permutations(), noise.table().permutations());
    // rust: assert_eq!(random.next_long(), -6_819_959_017_335_327_829);
    // rust: assert_eq!(simplex.get2(0.25, 0.75).to_bits(), 3_146_180_247);
    // rust: assert_eq!(simplex.get3(0.25, 0.5, 0.75).to_bits(), 1_062_011_824);
    // rust: assert!(simplex.get3(f64::NAN, 0.0, 0.0).is_nan());
    // rust: assert_eq!(
    // rust: SmearedPerlinNoise::new(&mut random, f64::NAN).range(),
    // rust: Err(NanRange)
    // rust: );
}

pub fn bulk_accumulation_preserves_tail_and_rejects_short_buffers_before_writes() void {
}
    // rust: let noise = PerlinNoise::new(&mut LegacyRandom::new(0));
    // rust: let volume = DensityVolume::new([1; 3], [0; 3], [1; 3]).unwrap();
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let mut values =
    // rust: std::array::from_fn::<_, 5, _>(|_| f32::from_bits(random.next_int() as u32));
    // rust: let tail = values[1..].iter().map(|v| v.to_bits()).collect::<Vec<_>>();
    // rust: noise
    // rust: .add_to_volume(&mut values, volume, 1.0, 1.0, 1.0)
    // rust: .unwrap();
    // rust: assert_eq!(values[0].to_bits(), 3_184_062_705);
    // rust: assert_eq!(
    // rust: values[1..].iter().map(|v| v.to_bits()).collect::<Vec<_>>(),
    // rust: tail
    // rust: );
    // rust: let before = values.map(f32::to_bits);
    // rust: let too_large = DensityVolume::new([2; 3], [0; 3], [1; 3]).unwrap();
    // rust: assert_eq!(
    // rust: noise.add_to_volume(&mut values, too_large, 1.0, 1.0, 1.0),
    // rust: Err(DensityError::BufferTooShort)
    // rust: );
    // rust: assert_eq!(values.map(f32::to_bits), before);
}

pub fn density_dimensions_are_bounded_and_coordinates_wrap() void {
}
    // rust: assert_eq!(
    // rust: DensityVolume::new([0, 1, 1], [0; 3], [1; 3]),
    // rust: Err(DensityError::NonpositiveDimensions)
    // rust: );
    // rust: assert_eq!(
    // rust: DensityVolume::new([1; 3], [0; 3], [1, 0, 1]),
    // rust: Err(DensityError::NonpositiveSteps)
    // rust: );
    // rust: assert_eq!(
    // rust: DensityVolume::new([i32::MAX; 3], [0; 3], [1; 3]),
    // rust: Err(DensityError::VolumeTooLarge)
    // rust: );
    // rust: let volume = DensityVolume::new([2, 3, 4], [i32::MAX, 0, -1], [2, 4, 8]).unwrap();
    // rust: assert_eq!(volume.block(Axis::X, 1), Some(i32::MIN + 1));
    // rust: assert_eq!(volume.block(Axis::X, 2), None);
    // rust: assert_eq!(volume.index([1, 2, 3]), Some(23));
    // rust: assert_eq!(volume.index([1, 3, 3]), None);
}

pub fn normal_noise_reference_values_and_legacy_failure_draws() void {
}
    // rust: let mut builder = NormalNoise::builder();
    // rust: builder.set_base_octave(-3);
    // rust: assert_eq!(
    // rust: builder.set_amplitude_modifier(-1, 0.0).unwrap_err(),
    // rust: NoiseBuildError::ModifierIndex
    // rust: );
    // rust: builder.set_octave_count(3).unwrap();
    // rust: builder.set_amplitude_modifier(1, 0.0).unwrap();
    // rust: assert_eq!(
    // rust: builder.set_octave_count(4).unwrap_err(),
    // rust: NoiseBuildError::CountAfterModifiers
    // rust: );
    // rust: let definition = builder.build().unwrap();
    // rust: assert_eq!(
    // rust: definition.normalization_factor().to_bits(),
    // rust: 4_607_442_513_526_237_848
    // rust: );
    // rust: assert_eq!(
    // rust: definition
    // rust: .octaves()
    // rust: .iter()
    // rust: .map(|o| o.octave_index)
    // rust: .collect::<Vec<_>>(),
    // rust: [-3, -1]
    // rust: );
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let modern = definition.create(&mut random).unwrap();
    // rust: assert_eq!(modern.get3(0.0, 0.0, 0.0).to_bits(), 1_042_650_710);
    // rust: assert_eq!(random.next_long(), -6_688_467_811_848_818_630);
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let legacy = definition
    // rust: .create_for_legacy_nether_biome(&mut random)
    // rust: .unwrap();
    // rust: assert_eq!(legacy.get3(0.0, 0.0, 0.0).to_bits(), 3_199_632_936);
    // rust: assert_eq!(random.next_long(), 4_966_550_093_728_345_520);
    // rust: let mut empty = NormalNoise::builder();
    // rust: empty.set_base_octave(2).set_octave_count(0).unwrap();
    // rust: let mut random = LegacyRandom::new(0);
    // rust: assert_eq!(
    // rust: empty
    // rust: .build()
    // rust: .unwrap()
    // rust: .create_for_legacy_nether_biome(&mut random)
    // rust: .unwrap_err(),
    // rust: NoiseBuildError::PositiveLegacyOctaves
    // rust: );
    // rust: assert_eq!(random.next_long(), -6_819_959_017_335_327_829);
    // rust: let mut random = LegacyRandom::new(0);
    // rust: assert_eq!(
    // rust: create_legacy_fbm(&mut random, i32::MIN, &[1.0]).unwrap_err(),
    // rust: NoiseBuildError::LegacyWorkLimit
    // rust: );
    // rust: assert_eq!(random.next_long(), LegacyRandom::new(0).next_long());
}

pub fn stack_snapshots_share_layers_and_preserve_zero_amplitude_semantics() void {
}
//         use std::sync::Arc;
    // rust: let sampler: Arc<dyn Noise> = Arc::new(PerlinNoise::new(&mut LegacyRandom::new(0)));
    // rust: let mut builder = NoiseStack::builder();
    // rust: builder.add(Arc::clone(&sampler), 1.0, 0.0);
    // rust: let zero = builder.build().unwrap();
    // rust: builder.add(Arc::clone(&sampler), 2.0, 1.0);
    // rust: assert_eq!(zero.layers().len(), 1);
    // rust: assert!(Arc::ptr_eq(zero.get_layer(0).unwrap(), &sampler));
    // rust: assert!(zero.get_layer(1).is_none());
    // rust: let mut flattened = NoiseStack::builder();
    // rust: flattened.add_stack(&zero, 1.0, f32::INFINITY);
    // rust: assert_eq!(flattened.build().unwrap_err(), NanRange);
    // rust: let nested = NoiseStack::builder()
    // rust: .add(Arc::new(zero), 1.0, f32::INFINITY)
    // rust: .build()
    // rust: .unwrap();
    // rust: assert_eq!(nested.range().unwrap(), [0.0; 2]);
    // rust: assert!(nested.get3(1.0, 2.0, 3.0).is_nan());
}
}
