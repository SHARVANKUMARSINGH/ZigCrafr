//! Transpiled from Horizon Rust crate
//! Module: horizon-world_biome_chunk
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Quart-resolution biome storage and section-atomic noise-biome filling.
// use crate::heightmap::{Heightmap, HeightmapError, HeightmapType};
// use horizon_core::{
    // rust: biome::BiomeZoom,
    // rust: position::{BlockPos, ChunkPos},
}
// use std::collections::{BTreeMap, BTreeSet};

pub const BiomeChunk = struct {
    position: ChunkPos,
    min_y: i32,
    height: i32,
    sections: Vec<[T,
};
pub const BiomeFillError = enum {
    InvalidBounds,
    Resolve(E),
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for BiomeFillError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::InvalidBounds => f.write_str("biome generation bounds are outside the chunk"),
    // rust: Self::Resolve(error) => error.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for BiomeFillError<E> {}
    // rust: impl<T: Clone> BiomeChunk<T> {
    /// The heap bytes of its quart cells.
pub fn heap_bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections.capacity() * std::mem::size_of::<[T; 64]>()
}
    /// A chunk's biome values use the same supported vertical bounds as terrain.
    /// Each section stores a dense 4×4×4 array; palette/network codecs are separate.
    // rust: pub fn new(
    // rust: position: ChunkPos,
    // rust: min_y: i32,
    // rust: height: i32,
    // rust: default: T,
    // rust: ) -> Result<Self, HeightmapError> {
    // rust: Heightmap::new(HeightmapType::WorldSurfaceWg, min_y, height)?;
    // rust: Ok(Self {
    // rust: position,
    // rust: min_y,
    // rust: height,
    // rust: sections: (0..height / 16)
    // rust: .map(|_| std::array::from_fn(|_| default.clone()))
    // rust: .collect(),
    // rust: })
}
pub fn section(self: *Self, index: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections.get(index)
}
    /// Vanilla clamps quart Y to the chunk and wraps X/Z to the local 4×4 grid.
    /// The caller is responsible for selecting the chunk containing X/Z.
pub fn noise_biome(self: *Self, quart: [i32; 3]) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bottom = self.min_y >> 2;
    // rust: let y = quart[1].clamp(bottom, bottom + (self.height >> 2) - 1);
    // rust: let section = ((y - bottom) >> 2) as usize;
    // rust: &self.sections[section][index(quart[0], y, quart[2])]
}
    /// The quart Ys `noise_biome` clamps to: the lowest and the highest.
pub fn quart_range(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bottom = self.min_y >> 2;
    // rust: (bottom, bottom + (self.height >> 2) - 1)
}
    /// Fill the sections intersecting inclusive generation bounds. Sections are
    /// visited bottom to top; each resolver sees X/Y/Z loop order. A failed
    /// section retains its previous values while earlier sections stay committed.
    /// This does not decorate the resolver with blending or below-zero retrogen.
    // rust: pub fn fill<E>(
    // rust: &mut self,
    // rust: min_y: i32,
    // rust: max_y: i32,
    // rust: mut resolve: impl FnMut([i32; 3]) -> Result<T, E>,
    // rust: ) -> Result<(), BiomeFillError<E>> {
    // rust: self.fill_using_chunk(min_y, max_y, |quart, _| resolve(quart))
}
    /// Decorate candidate sampling with the pinned below-zero biome policy.
    /// `upgrading` is captured once for this fill, as at native resolver creation.
    /// Keys describe holder identity; unkeyed/direct values must return `None`.
    // rust: pub fn fill_with_retrogen<E>(
    // rust: &mut self,
    // rust: min_y: i32,
    // rust: max_y: i32,
    // rust: upgrading: bool,
    // rust: resolve: impl FnMut([i32; 3]) -> Result<T, E>,
    // rust: biome_key: impl Fn(&T) -> Option<&str>,
    // rust: ) -> Result<(), BiomeFillError<E>> {
    // rust: let mut resolver = crate::retrogen::RetrogenBiomeResolver::new(upgrading, resolve);
    // rust: self.fill_using_chunk(min_y, max_y, |quart, chunk| {
    // rust: resolver.sample(quart, &biome_key, |old| Ok(chunk.noise_biome(old).clone()))
    // rust: })
}
    // rust: fn fill_using_chunk<E>(
    // rust: &mut self,
    // rust: min_y: i32,
    // rust: max_y: i32,
    // rust: mut resolve: impl FnMut([i32; 3], &Self) -> Result<T, E>,
    // rust: ) -> Result<(), BiomeFillError<E>> {
    // rust: if min_y < self.min_y || max_y >= self.min_y + self.height || min_y > max_y {
    // rust: return Err(BiomeFillError::InvalidBounds);
}
    // rust: let x = self.position.x.wrapping_shl(4) >> 2;
    // rust: let z = self.position.z.wrapping_shl(4) >> 2;
    // rust: for section_y in (min_y >> 4)..=(max_y >> 4) {
    // rust: let section = (section_y - (self.min_y >> 4)) as usize;
    // rust: let mut values = self.sections[section].clone();
    // rust: for dx in 0..4 {
    // rust: for dy in 0..4 {
    // rust: for dz in 0..4 {
    // rust: let quart = [
    // rust: x.wrapping_add(dx),
    // rust: section_y.wrapping_shl(2).wrapping_add(dy),
    // rust: z.wrapping_add(dz),
    // rust: ];
    // rust: values[index(dx, dy, dz)] =
    // rust: resolve(quart, self).map_err(BiomeFillError::Resolve)?;
}
}
}
    // rust: self.sections[section] = values;
}
    // rust: Ok(())
}
}
pub fn index(x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (((y & 3) << 4) | ((z & 3) << 2) | (x & 3)) as usize
}

/// Resident biome sections shared by decoration selection and block biome zoom.
/// The seed is already obfuscated, as for `BiomeZoom` and the client protocol.
pub const BiomeRegion = struct {
    chunks: BTreeMap<(i32,
    zoom: BiomeZoom,
};
pub const BiomeRegionError = enum {
    InvalidChunks,
    MissingChunk(ChunkPos),
};
    // rust: impl std::fmt::Display for BiomeRegionError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "{self:?}")
}
}
    // rust: impl std::error::Error for BiomeRegionError {}
    // rust: impl<T: Clone> BiomeRegion<T> {
pub fn new(chunks: std.ArrayList(BiomeChunk<T)>, obfuscated_seed: i64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if chunks.is_empty() || chunks.len() > 4096 {
    // rust: return Err(BiomeRegionError::InvalidChunks);
}
    // rust: let min = chunks[0].min_y;
    // rust: let height = chunks[0].height;
    // rust: let mut stored = BTreeMap::new();
    // rust: for chunk in chunks {
    // rust: if chunk.min_y != min || chunk.height != height {
    // rust: return Err(BiomeRegionError::InvalidChunks);
}
    // rust: if stored
    // rust: .insert((chunk.position.x, chunk.position.z), chunk)
    // rust: .is_some()
    // rust: {
    // rust: return Err(BiomeRegionError::InvalidChunks);
}
}
    // rust: Ok(Self {
    // rust: chunks: stored,
    // rust: zoom: BiomeZoom::new(obfuscated_seed),
    // rust: })
}
pub fn chunk(self: *Self, p: ChunkPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks
    // rust: .get(&(p.x, p.z))
    // rust: .ok_or(BiomeRegionError::MissingChunk(p))
}
pub fn chunk_mut(self: *Self, p: ChunkPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks
    // rust: .get_mut(&(p.x, p.z))
    // rust: .ok_or(BiomeRegionError::MissingChunk(p))
}
pub fn noise_biome(self: *Self, quart: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .chunk(ChunkPos::new(quart[0] >> 2, quart[2] >> 2))?
    // rust: .noise_biome(quart))
}
pub fn biome(self: *Self, block: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.noise_biome(self.zoom.quart_at_block(block))
}
pub fn quart_at_block(self: *Self, block: BlockPos) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.zoom.quart_at_block(block)
}
pub fn zoom(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.zoom
}
    /// Distinct values currently stored anywhere in the chunk. The result is
    /// sorted by biome identity; callers must not use this order as registry order.
pub fn present_in_chunk(self: *Self, p: ChunkPos) R;
    // rust: where
    // rust: T: Ord,
    // rust: {
    // rust: Ok(self
    // rust: .chunk(p)?
    // rust: .sections
    // rust: .iter()
    // rust: .flatten()
    // rust: .cloned()
    // rust: .collect::<BTreeSet<_>>()
    // rust: .into_iter()
    // rust: .collect())
}
}
