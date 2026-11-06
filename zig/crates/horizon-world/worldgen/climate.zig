//! Transpiled from Horizon Rust crate
//! Module: horizon-world_climate
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Climate coordinates derived from the six terrain-router climate fields.
// use horizon_core::density::{DensitySampler, SampleError, SamplerContext};
// use horizon_core::noise::DensityVolume;
// use std::sync::Arc;
    // rust: mod codec;
    // rust: mod index;
    // rust: pub use codec::{decode_parameter, decode_parameter_point};
    // rust: pub use index::{ClimateIndex, ClimateSearch, IndexError, Parameter, ParameterPoint};

/// Vanilla multiplies in float precision before the saturating Java long cast.
pub fn quantize(value: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (value * 10_000.0) as i64
}
pub fn unquantize(value: i64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: value as f32 / 10_000.0
}
pub const TargetPoint = struct {
    temperature: i64,
    humidity: i64,
    continentalness: i64,
    erosion: i64,
    depth: i64,
    weirdness: i64,
};
    // rust: impl TargetPoint {
pub fn from_values(values: [f32; 6]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [
    // rust: temperature,
    // rust: humidity,
    // rust: continentalness,
    // rust: erosion,
    // rust: depth,
    // rust: weirdness,
    // rust: ] = values.map(quantize);
    // rust: Self {
    // rust: temperature,
    // rust: humidity,
    // rust: continentalness,
    // rust: erosion,
    // rust: depth,
    // rust: weirdness,
}
}
    /// The seventh parameter is the zero offset used by biome nearest searches.
    // rust: pub const fn parameters(self) -> [i64; 7] {
    // rust: [
    // rust: self.temperature,
    // rust: self.humidity,
    // rust: self.continentalness,
    // rust: self.erosion,
    // rust: self.depth,
    // rust: self.weirdness,
    // rust: 0,
    // rust: ]
}
}
pub const ClimateSampler = struct {
    samplers: [*dyn DensitySampler,
};
    // rust: impl ClimateSampler {
    /// Temperature, humidity, continentalness, erosion, depth, weirdness.
pub fn new(samplers: [*dyn DensitySampler; 6]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { samplers }
}
    /// Coordinates are biome quart positions, converted with wrapped << 2.
    /// Every child uses the same context and runs in field declaration order.
    // rust: pub fn sample(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: quart: [i32; 3],
    // rust: ) -> Result<TargetPoint, SampleError> {
    // rust: let position = quart.map(|coordinate| coordinate.wrapping_shl(2));
    // rust: let mut values = [0.; 6];
    // rust: for (sampler, value) in self.samplers.iter().zip(&mut values) {
    // rust: *value = sampler.sample_value(context, position)?;
}
    // rust: Ok(TargetPoint::from_values(values))
}
    /// Prepare all six field buffers in declaration order on the quart lattice.
    /// Lookup quantizes the retained bulk values rather than resampling scalars.
    // rust: pub fn sample_volume(
    // rust: &self,
    // rust: context: &mut SamplerContext,
    // rust: quart_minimum: [i32; 3],
    // rust: extents: [i32; 3],
    // rust: ) -> Result<ClimateVolume, SampleError> {
    // rust: let volume = DensityVolume::new(extents, quart_minimum.map(|v| v.wrapping_shl(2)), [4; 3])?;
    // rust: let mut fields = std::array::from_fn(|_| vec![0.; volume.size()]);
    // rust: for (sampler, field) in self.samplers.iter().zip(&mut fields) {
    // rust: sampler.sample_volume(context, field, volume)?;
}
    // rust: Ok(ClimateVolume {
    // rust: quart_minimum,
    // rust: volume,
    // rust: fields,
    // rust: })
}
}
pub const ClimateVolume = struct {
    quart_minimum: [i32,
    volume: DensityVolume,
    fields: [std.ArrayList(f32),
};
    // rust: impl ClimateVolume {
    /// Coordinates must be inside the prepared quart volume. The bounded Rust
    /// API rejects invalid coordinates instead of Java's unchecked buffer alias.
pub fn target(self: *Self, quart: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let relative =
    // rust: std::array::from_fn(|i| quart[i].wrapping_sub(self.quart_minimum[i]) as usize);
    // rust: let index = self.volume.index(relative)?;
    // rust: Some(TargetPoint::from_values(std::array::from_fn(|i| {
    // rust: self.fields[i][index]
    // rust: })))
}
}
