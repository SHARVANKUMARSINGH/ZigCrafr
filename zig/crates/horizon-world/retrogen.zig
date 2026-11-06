//! Transpiled from Horizon Rust crate
//! Module: horizon-world_retrogen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Below-zero upgrade metadata and resident block transformations.
//! Generation scheduling remains owned by the caller.
// use crate::{chunk_status::ChunkStatus, compression::invalid, nbt::Tag};
// use std::io;

pub const BelowZeroRetrogen = struct {
    target: ChunkStatus,
    missing_bedrock: std.ArrayList(u64),
};
    // rust: impl BelowZeroRetrogen {
pub fn new(target: ChunkStatus, mut missing_bedrock: std.ArrayList(u64)) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if target == ChunkStatus::Empty {
    // rust: return Err(invalid("retrogen target status cannot be empty"));
}
    // rust: while missing_bedrock.last() == Some(&0) {
    // rust: missing_bedrock.pop();
}
    // rust: Ok(Self {
    // rust: target,
    // rust: missing_bedrock,
    // rust: })
}
pub fn target_status(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.target
}
pub fn has_bedrock_holes(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.missing_bedrock.is_empty()
}
pub fn has_bedrock_hole(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = ((z & 15) * 16 + (x & 15)) as usize;
    // rust: self.missing_bedrock
    // rust: .get(index / 64)
    // rust: .is_some_and(|word| word & (1_u64 << (index % 64)) != 0)
}
pub fn from_nbt(tag: *Tag) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !matches!(tag, Tag::Compound(_)) {
    // rust: return Err(invalid("retrogen is not a compound"));
}
    // rust: let target = ChunkStatus::from_nbt(
    // rust: tag.get("target_status")
    // rust: .ok_or_else(|| invalid("missing retrogen target status"))?,
    // rust: )?;
        // The native optional field is lenient: an invalid stream is absent.
    // rust: let words = tag
    // rust: .get("missing_bedrock")
    // rust: .and_then(long_stream)
    // rust: .unwrap_or_default();
    // rust: Self::new(target, words)
}
pub fn to_nbt(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut fields = vec![("target_status", self.target.to_nbt())];
    // rust: if self.has_bedrock_holes() {
    // rust: fields.push((
    // rust: "missing_bedrock",
    // rust: Tag::LongArray(
    // rust: self.missing_bedrock
    // rust: .iter()
    // rust: .map(|word| *word as i64)
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
    // rust: Tag::compound(fields)
}
}
pub fn long_stream(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::LongArray(words) => Some(words.iter().map(|v| *v as u64).collect()),
    // rust: Tag::IntArray(words) => Some(words.iter().map(|v| i64::from(*v) as u64).collect()),
    // rust: Tag::ByteArray(words) => Some(words.iter().map(|v| i64::from(*v as i8) as u64).collect()),
    // rust: Tag::List(words) => words
    // rust: .iter()
    // rust: .map(|word| {
    // rust: Some(match word {
    // rust: Tag::Byte(v) => i64::from(*v) as u64,
    // rust: Tag::Short(v) => i64::from(*v) as u64,
    // rust: Tag::Int(v) => i64::from(*v) as u64,
    // rust: Tag::Long(v) => *v as u64,
    // rust: Tag::Float(v) => (f32::from_bits(*v) as i64) as u64,
    // rust: Tag::Double(v) => (f64::from_bits(*v) as i64) as u64,
    // rust: _ => return None,
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: _ => None,
}
}

    // rust: impl BelowZeroRetrogen {
    /// Replace the legacy five-layer bedrock band in a resident proto-chunk.
    /// Local X/Z positions and native X-fastest traversal preserve write order.
    // rust: pub fn replace_old_bedrock<B: crate::worldgen::terrain::TerrainBlockStates>(
    // rust: chunk: &mut crate::worldgen::terrain::TerrainChunk<'_, B>,
    // rust: ) -> Result<(), crate::worldgen::terrain::TerrainError> {
//         use crate::worldgen::terrain::TerrainError;
    // rust: let bedrock = chunk
    // rust: .registry()
    // rust: .default_state("minecraft:bedrock")
    // rust: .ok_or(TerrainError::InvalidState)?;
    // rust: let deepslate = chunk
    // rust: .registry()
    // rust: .default_state("minecraft:deepslate")
    // rust: .ok_or(TerrainError::InvalidState)?;
    // rust: for z in 0..16 {
    // rust: for y in 0..5 {
    // rust: for x in 0..16 {
    // rust: if chunk.same_block(chunk.block(x, y, z), bedrock) {
    // rust: chunk.set_block_worldgen(x, y, z, deepslate)?;
}
}
}
}
    // rust: Ok(())
}
    /// Clear marked columns through the supplied chunk's current generation
    /// height. The installed upgrade and this mask need not be the same object.
    // rust: pub fn apply_bedrock_mask<B: crate::worldgen::terrain::TerrainBlockStates>(
    // rust: &self,
    // rust: chunk: &mut crate::worldgen::terrain::TerrainChunk<'_, B>,
    // rust: ) -> Result<(), crate::worldgen::terrain::TerrainError> {
//         use crate::worldgen::terrain::TerrainError;
    // rust: let air = chunk
    // rust: .registry()
    // rust: .default_state("minecraft:air")
    // rust: .ok_or(TerrainError::MissingAir)?;
    // rust: let (min_y, height) = chunk.height_for_generation();
    // rust: let max_y = min_y.wrapping_add(height).wrapping_sub(1);
    // rust: for x in 0..16 {
    // rust: for z in 0..16 {
    // rust: if self.has_bedrock_hole(x, z) {
    // rust: for y in min_y..=max_y {
    // rust: chunk.set_block_worldgen(x, y, z, air)?;
}
}
}
}
    // rust: Ok(())
}
}

/// The native decoration decision is captured when the resolver is created.
/// Removing upgrade metadata afterwards does not unwrap an existing resolver.
/// Candidate sampling runs before deciding whether to read an old column biome.
pub const RetrogenBiomeResolver = struct {
    upgrading: bool,
    resolve: F,
};
    // rust: impl<F> RetrogenBiomeResolver<F> {
    // rust: pub fn new<T, E>(upgrading: bool, resolve: F) -> Self
    // rust: where
    // rust: F: FnMut([i32; 3]) -> Result<T, E>,
    // rust: {
    // rust: Self { upgrading, resolve }
}
    // rust: pub fn sample<T, E>(
    // rust: &mut self,
    // rust: quart: [i32; 3],
    // rust: biome_key: impl FnOnce(&T) -> Option<&str>,
    // rust: old_biome: impl FnOnce([i32; 3]) -> Result<T, E>,
    // rust: ) -> Result<T, E>
    // rust: where
    // rust: F: FnMut([i32; 3]) -> Result<T, E>,
    // rust: {
    // rust: let candidate = (self.resolve)(quart)?;
    // rust: if !self.upgrading
    // rust: || matches!(
    // rust: biome_key(&candidate),
    // rust: Some("minecraft:lush_caves" | "minecraft:dripstone_caves" | "minecraft:deep_dark")
    // rust: )
    // rust: {
    // rust: Ok(candidate)
    // rust: } else {
    // rust: old_biome([quart[0], 0, quart[2]])
}
}
}
