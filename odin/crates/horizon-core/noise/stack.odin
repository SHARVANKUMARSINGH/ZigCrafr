//! Transpiled from Horizon Rust crate
package horizon_core_stack

import "core:fmt"
import "core:mem"
import "core:math"

// use super::{DensityError, DensityVolume, NanRange, PerlinNoise, SimplexNoise, SmearedPerlinNoise};
// use std::sync::Arc;

// Immutable noise sampling. Implementations may override the default scalar
// volume traversal when vanilla has a distinct bulk arithmetic path.
    // rust: pub trait Noise: std::fmt::Debug + Send + Sync {
range :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
get2 :: proc(self: ^Self, x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
get3 :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: fn add_to_volume(
    // rust: &self,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: xz_scale: f64,
    // rust: y_scale: f64,
    // rust: amplitude: f32,
    // rust: ) -> Result<(), DensityError> {
    // rust: if buffer.len() < volume.size() {
    // rust: return Err(DensityError::BufferTooShort);
}
    // rust: let [sx, sy, sz] = volume.sizes();
    // rust: let mut index = 0;
    // rust: for z in 0..sz {
    // rust: let z = f64::from(volume.coordinate(2, z)) * xz_scale;
    // rust: for x in 0..sx {
    // rust: let x = f64::from(volume.coordinate(0, x)) * xz_scale;
    // rust: for y in 0..sy {
    // rust: let y = f64::from(volume.coordinate(1, y)) * y_scale;
    // rust: buffer[index] += amplitude * self.get3(x, y, z);
    // rust: index += 1;
}
}
}
    // rust: Ok(())
}
}

    // rust: impl Noise for PerlinNoise {
range :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(PerlinNoise::range(self))
}
get2 :: proc(self: ^Self, x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: PerlinNoise::get2(self, x, z)
}
get3 :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: PerlinNoise::get3(self, x, y, z)
}
    // rust: fn add_to_volume(
    // rust: &self,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: xz_scale: f64,
    // rust: y_scale: f64,
    // rust: amplitude: f32,
    // rust: ) -> Result<(), DensityError> {
    // rust: PerlinNoise::add_to_volume(self, buffer, volume, xz_scale, y_scale, amplitude)
}
}
    // rust: impl Noise for SmearedPerlinNoise {
range :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: SmearedPerlinNoise::range(self)
}
get2 :: proc(self: ^Self, x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: SmearedPerlinNoise::get2(self, x, z)
}
get3 :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: SmearedPerlinNoise::get3(self, x, y, z)
}
    // rust: fn add_to_volume(
    // rust: &self,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: xz_scale: f64,
    // rust: y_scale: f64,
    // rust: amplitude: f32,
    // rust: ) -> Result<(), DensityError> {
    // rust: SmearedPerlinNoise::add_to_volume(self, buffer, volume, xz_scale, y_scale, amplitude)
}
}
    // rust: impl Noise for SimplexNoise {
range :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(SimplexNoise::range(self))
}
get2 :: proc(self: ^Self, x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: SimplexNoise::get2(self, x, z)
}
get3 :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: SimplexNoise::get3(self, x, y, z)
}
}

NoiseLayer :: struct {
    noise: ^dyn Noise,
    frequency: f64,
    amplitude: f32,
}

NoiseStack :: struct {
    layers: [dynamic]NoiseLayer,
    range: [f32,
}

    // rust: impl NoiseStack {
builder :: proc() -> N {
    // Ported from Horizon
    return {}
}
    // rust: NoiseStackBuilder::default()
}
layers :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.layers
}
get_layer :: proc(self: ^Self, index: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.layers.get(index).map(|layer| &layer.noise)
}
}
    // rust: impl Noise for NoiseStack {
range :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.range)
}
get2 :: proc(self: ^Self, x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut value = 0.0;
    // rust: for layer in &self.layers {
    // rust: value += layer.amplitude * layer.noise.get2(x * layer.frequency, z * layer.frequency);
}
    // rust: value
}
get3 :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut value = 0.0;
    // rust: for layer in &self.layers {
    // rust: value += layer.amplitude
    // rust: * layer.noise.get3(
    // rust: x * layer.frequency,
    // rust: y * layer.frequency,
    // rust: z * layer.frequency,
    // rust: );
}
    // rust: value
}
    // rust: fn add_to_volume(
    // rust: &self,
    // rust: buffer: &mut [f32],
    // rust: volume: DensityVolume,
    // rust: xz_scale: f64,
    // rust: y_scale: f64,
    // rust: amplitude: f32,
    // rust: ) -> Result<(), DensityError> {
    // rust: if buffer.len() < volume.size() {
    // rust: return Err(DensityError::BufferTooShort);
}
    // rust: for layer in &self.layers {
    // rust: layer.noise.add_to_volume(
    // rust: buffer,
    // rust: volume,
    // rust: xz_scale * layer.frequency,
    // rust: y_scale * layer.frequency,
    // rust: amplitude * layer.amplitude,
    // rust: )?;
}
    // rust: Ok(())
}
}

NoiseStackBuilder :: struct {
    layers: [dynamic]NoiseLayer,
}
    // rust: impl NoiseStackBuilder {
add :: proc(self: ^Self, noise: ^dyn Noise, frequency: f64, amplitude: f32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.layers.push(NoiseLayer {
    // rust: noise,
    // rust: frequency,
    // rust: amplitude,
    // rust: });
    // rust: self
}
    // Flattening rescales each existing layer before subsequent sampling.
add_stack :: proc(self: ^Self, stack: ^NoiseStack, frequency: f64, amplitude: f32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.layers
    // rust: .extend(stack.layers.iter().map(|layer| NoiseLayer {
    // rust: noise: Arc::clone(&layer.noise),
    // rust: frequency: layer.frequency * frequency,
    // rust: amplitude: layer.amplitude * amplitude,
    // rust: }));
    // rust: self
}
build :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut range = [0.0; 2];
    // rust: for layer in &self.layers {
    // rust: let bounds = layer.noise.range()?;
    // rust: if layer.amplitude.is_nan() {
    // rust: return Err(NanRange);
}
    // rust: let scaled = if bounds[0].is_nan() || bounds[1].is_nan() {
    // rust: [f32::NAN; 2]
    // rust: } else {
                // Interval.mulBound defines zero times infinity as positive zero.
    // rust: let product = |v: f32| {
    // rust: if v == 0.0 || layer.amplitude == 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: v * layer.amplitude
}
}
    // rust: let a = product(bounds[0]);
    // rust: let b = product(bounds[1]);
    // rust: if a < b {
    // rust: [a, b]
    // rust: } else if a > b {
    // rust: [b, a]
    // rust: } else if a == 0.0 {
    // rust: [
    // rust: f32::from_bits(a.to_bits() | b.to_bits()),
    // rust: f32::from_bits(a.to_bits() & b.to_bits()),
    // rust: ]
    // rust: } else {
    // rust: [a, b]
}
}
    // rust: range = [range[0] + scaled[0], range[1] + scaled[1]];
    // rust: if range[0].is_nan() || range[1].is_nan() {
    // rust: range = [f32::NAN; 2];
}
            // Interval.of interns [0,1], including a supplied negative zero.
    // rust: if range[0] == 0.0 && range[1] == 1.0 {
    // rust: range[0] = 0.0;
}
}
    // rust: Ok(NoiseStack {
    // rust: layers: self.layers.clone(),
    // rust: range,
    // rust: })
}
}
