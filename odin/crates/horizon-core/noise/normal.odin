//! Transpiled from Horizon Rust crate
package horizon_core_normal

import "core:fmt"
import "core:mem"
import "core:math"

// use super::{NanRange, NoiseStack, PerlinNoise};
// use crate::random::{PositionalRandom, RandomSource};
// use std::sync::Arc;

// An allocation bound for the builder API (the vanilla data codec allows 32).
MAX_BUILDER_OCTAVES :: 4096

NoiseBuildError :: enum {
    NegativeOctaveCount,
    TooManyOctaves,
    CountAfterModifiers,
    ModifierIndex,
    EmptyAmplitudes,
    NanRange,
    InvertedRange,
    MissingNoiseLevels,
    PositiveLegacyOctaves,
    LegacyWorkLimit,
}
    // rust: impl std::fmt::Display for NoiseBuildError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(match self {
    // rust: Self::NegativeOctaveCount => "octave count cannot be negative",
    // rust: Self::TooManyOctaves => "octave count exceeds the 4096-layer allocation bound",
    // rust: Self::CountAfterModifiers => {
    // rust: "cannot change octave count after setting amplitude modifiers"
}
    // rust: Self::ModifierIndex => "amplitude modifier index is outside the octave range",
    // rust: Self::EmptyAmplitudes => "at least one amplitude is required",
    // rust: Self::NanRange => "noise interval bounds cannot include NaN",
    // rust: Self::InvertedRange => "noise interval lower bound exceeds its upper bound",
    // rust: Self::MissingNoiseLevels => "legacy initializer could not create all nonzero octaves",
    // rust: Self::PositiveLegacyOctaves => "positive legacy octaves are disabled",
    // rust: Self::LegacyWorkLimit => "legacy initializer exceeds the 4096-octave work bound",
    // rust: })
}
}
    // rust: impl std::error::Error for NoiseBuildError {}
    // rust: impl From<NanRange> for NoiseBuildError {
from :: proc(_: NanRange) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::NanRange
}
}

Normalization :: enum {
    Enabled,
    Disabled,
    Legacy,
}

OctaveInfo :: struct {
    octave_index: i32,
    frequency: f64,
    amplitude: f64,
}
    // rust: impl OctaveInfo {
seed :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("octave_{}", self.octave_index)
}
}

NormalNoise :: struct {
    parameters: NormalNoiseBuilder,
    octaves: [dynamic]OctaveInfo,
    normalization_factor: f64,
    range: [f32,
}
    // rust: impl NormalNoise {
builder :: proc() -> N {
    // Ported from Horizon
    return {}
}
    // rust: NormalNoiseBuilder::default()
}
octaves :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.octaves
}
normalization_factor :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.normalization_factor
}
range :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.range
}

create :: proc(self: ^Self, random: ^impl RandomSource) -> R {
    // Ported from Horizon
    return {}
}
        // Even an empty stack consumes both positional forks.
    // rust: let first = random.fork_positional();
    // rust: let second = random.fork_positional();
    // rust: let mut builder = NoiseStack::builder();
    // rust: for octave in &self.octaves {
    // rust: let name = octave.seed();
    // rust: let a = PerlinNoise::new(&mut first.from_hash_of(&name));
    // rust: let b = PerlinNoise::new(&mut second.from_hash_of(&name));
    // rust: let amplitude = (self.normalization_factor * octave.amplitude) as f32;
    // rust: builder.add(Arc::new(a), octave.frequency, amplitude);
    // rust: builder.add(
    // rust: Arc::new(b),
    // rust: octave.frequency * 1.018_126_888_217_522_7,
    // rust: amplitude,
    // rust: );
}
    // rust: Ok(builder.build()?)
}

    // rust: pub fn create_for_legacy_nether_biome(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Result<NoiseStack, NoiseBuildError> {
    // rust: let defaults;
    // rust: let modifiers = if self.parameters.modifiers.is_empty() {
    // rust: defaults = vec![1.0; self.parameters.octave_count as usize];
    // rust: &defaults
    // rust: } else {
    // rust: &self.parameters.modifiers
}
    // rust: let first = create_legacy_fbm(random, self.parameters.base_octave, modifiers)?;
    // rust: let second = create_legacy_fbm(random, self.parameters.base_octave, modifiers)?;
    // rust: let amplitude = (self.normalization_factor * self.parameters.base_amplitude) as f32;
    // rust: Ok(NoiseStack::builder()
    // rust: .add_stack(&first, 1.0, amplitude)
    // rust: .add_stack(&second, 1.018_126_888_217_522_7, amplitude)
    // rust: .build()?)
}

create_parity :: proc(base_octave: i32, amplitudes: ^[f64]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if amplitudes.is_empty() {
    // rust: return Err(NoiseBuildError::EmptyAmplitudes);
}
    // rust: if amplitudes.len() > MAX_BUILDER_OCTAVES as usize {
    // rust: return Err(NoiseBuildError::TooManyOctaves);
}
    // rust: let count = amplitudes.len() as i32;
    // rust: let octaves = build_octaves(base_octave, 1.0, count, true, amplitudes);
    // rust: let factor = normalization_factor(sum_abs(&octaves), &octaves);
    // rust: let base_amplitude = if factor == 0.0 {
    // rust: 1.0
    // rust: } else {
    // rust: parity_factor(1.0, count, amplitudes) / factor
}
    // rust: NormalNoiseBuilder {
    // rust: base_octave,
    // rust: base_amplitude,
    // rust: octave_count: count,
    // rust: normalization: Normalization::Enabled,
    // rust: modifiers: amplitudes.to_vec(),
}
    // rust: .build()
}
}

NormalNoiseBuilder :: struct {
    base_amplitude: f64,
    base_octave: i32,
    octave_count: i32,
    normalization: Normalization,
    modifiers: [dynamic]f64,
}
    // rust: impl Default for NormalNoiseBuilder {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: base_amplitude: 1.0,
    // rust: base_octave: 0,
    // rust: octave_count: 1,
    // rust: normalization: Normalization::Enabled,
    // rust: modifiers: Vec::new(),
}
}
}
    // rust: impl NormalNoiseBuilder {
set_base_amplitude :: proc(self: ^Self, amplitude: f64) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.base_amplitude = amplitude;
    // rust: self
}
set_base_octave :: proc(self: ^Self, octave: i32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.base_octave = octave;
    // rust: self
}
set_normalization :: proc(self: ^Self, normalization: Normalization) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.normalization = normalization;
    // rust: self
}
set_octave_count :: proc(self: ^Self, count: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !self.modifiers.is_empty() {
    // rust: return Err(NoiseBuildError::CountAfterModifiers);
}
    // rust: self.octave_count = count;
    // rust: Ok(self)
}
    // rust: pub fn set_amplitude_modifier(
    // rust: &mut self,
    // rust: index: i32,
    // rust: value: f64,
    // rust: ) -> Result<&mut Self, NoiseBuildError> {
    // rust: if index < 0 || index >= self.octave_count {
    // rust: return Err(NoiseBuildError::ModifierIndex);
}
    // rust: if self.octave_count > MAX_BUILDER_OCTAVES {
    // rust: return Err(NoiseBuildError::TooManyOctaves);
}
    // rust: if self.modifiers.is_empty() {
    // rust: self.modifiers.resize(self.octave_count as usize, 1.0);
}
    // rust: self.modifiers[index as usize] = value;
    // rust: Ok(self)
}
build :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.octave_count < 0 {
    // rust: return Err(NoiseBuildError::NegativeOctaveCount);
}
    // rust: if self.octave_count > MAX_BUILDER_OCTAVES {
    // rust: return Err(NoiseBuildError::TooManyOctaves);
}
    // rust: let octaves = build_octaves(
    // rust: self.base_octave,
    // rust: self.base_amplitude,
    // rust: self.octave_count,
    // rust: self.normalization != Normalization::Disabled,
    // rust: &self.modifiers,
    // rust: );
    // rust: let mut sum = sum_abs(&octaves);
    // rust: let mut factor = normalization_factor(sum, &octaves);
    // rust: if self.normalization == Normalization::Legacy && factor != 0.0 {
    // rust: let legacy = parity_factor(self.base_amplitude, self.octave_count, &self.modifiers);
    // rust: sum *= legacy / factor;
    // rust: factor = legacy;
}
    // rust: let bound = (sum * (1.0 / 3.0) * 6.0) as f32;
    // rust: if bound.is_nan() {
    // rust: return Err(NoiseBuildError::NanRange);
}
    // rust: if bound < 0.0 {
    // rust: return Err(NoiseBuildError::InvertedRange);
}
    // rust: Ok(NormalNoise {
    // rust: parameters: self.clone(),
    // rust: octaves,
    // rust: normalization_factor: factor,
    // rust: range: [-bound, bound],
    // rust: })
}
}

// The legacy initializer consumes the caller's stream in reverse octave order.
// Missing and zero-amplitude octaves consume exactly 262 integer draws.
// Requests outside the documented allocation/work bounds fail before drawing.
    // rust: pub fn create_legacy_fbm(
    // rust: random: &mut impl RandomSource,
    // rust: base_octave: i32,
    // rust: amplitudes: &[f64],
    // rust: ) -> Result<NoiseStack, NoiseBuildError> {
    // rust: if amplitudes.len() > MAX_BUILDER_OCTAVES as usize {
    // rust: return Err(NoiseBuildError::TooManyOctaves);
}
    // rust: let zero_index = base_octave.wrapping_neg();
    // rust: if zero_index.wrapping_sub(1) >= MAX_BUILDER_OCTAVES {
    // rust: return Err(NoiseBuildError::LegacyWorkLimit);
}
    // rust: let count = amplitudes.len() as i32;
    // rust: let mut levels = vec![None; amplitudes.len()];
    // rust: let zero_noise = PerlinNoise::new(random);
    // rust: if zero_index >= 0 && zero_index < count && amplitudes[zero_index as usize] != 0.0 {
    // rust: levels[zero_index as usize] = Some(zero_noise);
}
    // rust: for index in (0..zero_index).rev() {
    // rust: if index < count && amplitudes[index as usize] != 0.0 {
    // rust: levels[index as usize] = Some(PerlinNoise::new(random));
    // rust: } else {
    // rust: random.consume_count(262);
}
}
    // rust: if levels.iter().filter(|v| v.is_some()).count()
    // rust: != amplitudes.iter().filter(|v| **v != 0.0).count()
    // rust: {
    // rust: return Err(NoiseBuildError::MissingNoiseLevels);
}
    // rust: if zero_index < count - 1 {
    // rust: return Err(NoiseBuildError::PositiveLegacyOctaves);
}
    // rust: let mut frequency = power_of_two(zero_index.wrapping_neg());
    // rust: let mut amplitude = power_of_two(count - 1) / (power_of_two(count) - 1.0);
    // rust: let mut builder = NoiseStack::builder();
    // rust: for (index, noise) in levels.into_iter().enumerate() {
    // rust: if let Some(noise) = noise {
    // rust: builder.add(
    // rust: Arc::new(noise),
    // rust: frequency,
    // rust: (amplitude * amplitudes[index]) as f32,
    // rust: );
}
    // rust: frequency *= 2.0;
    // rust: amplitude /= 2.0;
}
    // rust: Ok(builder.build()?)
}

modifier :: proc(modifiers: ^[f64], index: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if modifiers.is_empty() {
    // rust: 1.0
    // rust: } else {
    // rust: modifiers[index]
}
}

    // rust: fn build_octaves(
    // rust: base: i32,
    // rust: amplitude: f64,
    // rust: count: i32,
    // rust: normalize: bool,
    // rust: modifiers: &[f64],
    // rust: ) -> Vec<OctaveInfo> {
    // rust: let mut frequency = power_of_two(base);
    // rust: let mut amplitude = amplitude;
    // rust: if normalize {
    // rust: amplitude *= power_of_two(count - 1) / (power_of_two(count) - 1.0);
}
    // rust: let mut result = Vec::with_capacity(count as usize);
    // rust: for index in 0..count {
    // rust: let multiplier = modifier(modifiers, index as usize);
    // rust: if multiplier != 0.0 {
    // rust: result.push(OctaveInfo {
    // rust: octave_index: base.wrapping_add(index),
    // rust: frequency,
    // rust: amplitude: amplitude * multiplier,
    // rust: });
}
    // rust: frequency *= 2.0;
    // rust: amplitude *= 0.5;
}
    // rust: result
}

// Math.pow(2, integer), including exact subnormal powers and saturation, without
// a platform libm approximation. Frequencies subsequently double iteratively.
power_of_two :: proc(exponent: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match exponent {
    // rust: ..=-1075 => 0.0,
    // rust: -1074..=-1023 => f64::from_bits(1_u64 << (exponent + 1074)),
    // rust: -1022..=1023 => f64::from_bits(((exponent + 1023) as u64) << 52),
    // rust: _ => f64::INFINITY,
}
}

sum_abs :: proc(octaves: ^[OctaveInfo]) -> f {
    // Ported from Horizon
    return {}
}
    // Sequential DoubleStream.sum uses compensated summation and an uncorrected
    // sum to recover infinity when compensation arithmetic produces NaN.
    // rust: let (mut sum, mut correction, mut simple) = (0.0, 0.0, 0.0);
    // rust: for octave in octaves {
    // rust: let value = octave.amplitude.abs();
    // rust: let adjusted = value - correction;
    // rust: let next = sum + adjusted;
    // rust: correction = (next - sum) - adjusted;
    // rust: sum = next;
    // rust: simple += value;
}
    // rust: let result = sum - correction;
    // rust: if result.is_nan() && simple.is_infinite() {
    // rust: simple
    // rust: } else {
    // rust: result
}
}
normalization_factor :: proc(sum: f64, octaves: ^[OctaveInfo]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut variance = 0.0;
    // rust: for octave in octaves {
    // rust: let deviation = 0.270_224_783_124_521_1 * octave.amplitude.abs();
    // rust: variance += deviation * deviation;
}
    // rust: let deviation = variance.sqrt();
    // rust: if deviation == 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: (sum * (1.0 / 3.0)) / (deviation * 2.0_f64.sqrt())
}
}
parity_factor :: proc(base_amplitude: f64, count: i32, modifiers: ^[f64]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (mut first, mut last) = (i32::MAX, i32::MIN);
    // rust: for index in 0..count {
    // rust: if modifier(modifiers, index as usize) != 0.0 {
    // rust: first = first.min(index);
    // rust: last = last.max(index);
}
}
    // rust: let distance = last.wrapping_sub(first).wrapping_add(1);
    // rust: base_amplitude * 0.5 * (1.0 / 3.0) / (0.1 * (1.0 + 1.0 / f64::from(distance)))
}
