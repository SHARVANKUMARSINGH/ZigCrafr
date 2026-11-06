//! Transpiled from Horizon Rust crate
//! Module: horizon-world_biome_source
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Fixed, checkerboard and End biome-source queries. Registry codecs are separate.
    // rust: mod codec;
    // rust: mod runtime;
    // rust: pub use codec::{BiomeSet, BiomeSourceCatalog, BiomeSourceDefinition};
// use horizon_core::density::{DensitySampler, SampleError, SamplerContext};
    // rust: pub use runtime::{BiomeSourceError, BiomeSourceResolver, ResolvedBiomeSource};

pub const FixedBiomeSource = struct {
    biome: T,
};
    // rust: impl<T> FixedBiomeSource<T> {
pub fn noise_biome(self: *Self, _quart: [i32; 3]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.biome
}
}
pub const CheckerboardError = enum {
    TooManyBiomes,
    EmptyBiomes,
};
    // rust: impl std::fmt::Display for CheckerboardError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "{self:?}")
}
}
    // rust: impl std::error::Error for CheckerboardError {}
pub const CheckerboardBiomeSource = struct {
    biomes: std.ArrayList(T),
    scale: i32,
};
    // rust: impl<T> CheckerboardBiomeSource<T> {
    /// Runtime scale is unrestricted, including Java's masked shift distances.
    /// The vanilla JSON codec separately limits scale to 0..=62.
pub fn new(biomes: std.ArrayList(T), scale: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if biomes.len() > 8192 {
    // rust: return Err(CheckerboardError::TooManyBiomes);
}
    // rust: Ok(Self { biomes, scale })
}
pub fn noise_biome(self: *Self, quart: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.biomes.is_empty() {
    // rust: return Err(CheckerboardError::EmptyBiomes);
}
    // rust: let shift = self.scale.wrapping_add(2) as u32;
    // rust: let cell = quart[0]
    // rust: .wrapping_shr(shift)
    // rust: .wrapping_add(quart[2].wrapping_shr(shift));
    // rust: Ok(&self.biomes[cell.rem_euclid(self.biomes.len() as i32) as usize])
}
}
pub const EndBiomeSource = struct {
    center: T,
    highlands: T,
    midlands: T,
    islands: T,
    barrens: T,
};
    // rust: impl<T> EndBiomeSource<T> {
    /// The central 64-chunk circle bypasses erosion. Outside it, sample erosion
    /// at the containing chunk's center with the original wrapped block Y.
    // rust: pub fn noise_biome(
    // rust: &self,
    // rust: quart: [i32; 3],
    // rust: erosion: &dyn DensitySampler,
    // rust: context: &mut SamplerContext,
    // rust: ) -> Result<&T, SampleError> {
    // rust: let block = quart.map(|v| v.wrapping_shl(2));
    // rust: let x = block[0] >> 4;
    // rust: let z = block[2] >> 4;
    // rust: if i64::from(x) * i64::from(x) + i64::from(z) * i64::from(z) <= 4096 {
    // rust: return Ok(&self.center);
}
    // rust: let position = [
    // rust: x.wrapping_mul(2).wrapping_add(1).wrapping_mul(8),
    // rust: block[1],
    // rust: z.wrapping_mul(2).wrapping_add(1).wrapping_mul(8),
    // rust: ];
    // rust: let value = erosion.sample_value(context, position)?;
    // rust: Ok(if value > 0.25 {
    // rust: &self.highlands
    // rust: } else if value >= -0.0625 {
    // rust: &self.midlands
    // rust: } else if value < -0.21875 {
    // rust: &self.islands
    // rust: } else {
    // rust: &self.barrens
    // rust: })
}
}
