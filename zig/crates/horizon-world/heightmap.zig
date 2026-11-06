//! Transpiled from Horizon Rust crate
//! Module: horizon-world_heightmap
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Packed column heights and the six Java 26.3 heightmap predicates.
//!
//! Block behavior supplies air/fluid facts and resolved block-tag membership.
//! Heightmaps do not infer those facts from collision shapes or block names.
// use horizon_core::storage::{PackedStorage, StorageError};

pub const HeightmapType = enum {
    WorldSurfaceWg,
    WorldSurface,
    OceanFloorWg,
    OceanFloor,
    MotionBlocking,
    MotionBlockingNoLeaves,
};

    // rust: impl HeightmapType {
    // rust: pub const ALL: [Self; 6] = [
    // rust: Self::WorldSurfaceWg,
    // rust: Self::WorldSurface,
    // rust: Self::OceanFloorWg,
    // rust: Self::OceanFloor,
    // rust: Self::MotionBlocking,
    // rust: Self::MotionBlockingNoLeaves,
    // rust: ];

pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::WorldSurfaceWg => "WORLD_SURFACE_WG",
    // rust: Self::WorldSurface => "WORLD_SURFACE",
    // rust: Self::OceanFloorWg => "OCEAN_FLOOR_WG",
    // rust: Self::OceanFloor => "OCEAN_FLOOR",
    // rust: Self::MotionBlocking => "MOTION_BLOCKING",
    // rust: Self::MotionBlockingNoLeaves => "MOTION_BLOCKING_NO_LEAVES",
}
}

pub fn send_to_client(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self,
    // rust: Self::WorldSurface | Self::MotionBlocking | Self::MotionBlockingNoLeaves
    // rust: )
}

pub fn keep_after_worldgen(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(self, Self::WorldSurfaceWg | Self::OceanFloorWg)
}

pub fn is_opaque(self: *Self, state: impl HeightmapState) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::WorldSurfaceWg | Self::WorldSurface => !state.is_air(),
    // rust: Self::OceanFloorWg | Self::OceanFloor => state.blocks_motion_in_heightmap(),
    // rust: Self::MotionBlocking => state.blocks_motion_in_heightmap() || state.has_fluid(),
    // rust: Self::MotionBlockingNoLeaves => {
    // rust: state.blocks_motion_in_heightmap_no_leaves() || state.has_fluid()
}
}
}
}

    // rust: pub trait HeightmapState: Copy {
pub fn is_air(self: *Self) b;
    /// Exact AIR block identity, distinct from cave/void air.
pub fn is_air_block(self: *Self) b;
pub fn has_fluid(self: *Self) b;
pub fn blocks_motion_in_heightmap(self: *Self) b;
pub fn blocks_motion_in_heightmap_no_leaves(self: *Self) b;
}

    // rust: pub trait HeightmapChunk {
    // rust: type State: HeightmapState;
pub fn min_y(self: *Self) i;
pub fn height(self: *Self) i;
pub fn highest_section_y(self: *Self) i;
pub fn block_state(self: *Self, x: i32, y: i32, z: i32) S;
}

pub const HeightmapError = enum {
    InvalidBounds,
    MismatchedChunk,
    Storage(StorageError),
};
    // rust: impl From<StorageError> for HeightmapError {
pub fn from(value: StorageError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Storage(value)
}
}
    // rust: impl std::fmt::Display for HeightmapError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "{self:?}")
}
}
    // rust: impl std::error::Error for HeightmapError {}

pub const Heightmap = struct {
    kind: HeightmapType,
    min_y: i32,
    height: i32,
    data: PackedStorage,
};

    // rust: impl Heightmap {
    /// The heap bytes of its packed heights.
pub fn heap_bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data.heap_bytes()
}
    /// Bounded to the vanilla codec's positive, aligned vertical ranges.
pub fn new(kind: HeightmapType, min_y: i32, height: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !(-2032..=2031).contains(&min_y)
    // rust: || !(16..=4064).contains(&height)
    // rust: || min_y % 16 != 0
    // rust: || height % 16 != 0
    // rust: || min_y + height > 2032
    // rust: {
    // rust: return Err(HeightmapError::InvalidBounds);
}
    // rust: let bits = (32 - (height as u32).leading_zeros()) as u8;
    // rust: Ok(Self {
    // rust: kind,
    // rust: min_y,
    // rust: height,
    // rust: data: PackedStorage::new(bits, 256)?,
    // rust: })
}

pub fn kind(self: *Self) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.kind
}
pub fn raw_data(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data.words()
}

pub fn index(x: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: x.wrapping_add(z.wrapping_mul(16)) as usize
}

    /// Whether `update` at (`x`, `y`, `z`) returns at once, whatever the
    /// state: the block is two or more below the first available one. `x`
    /// and `z` are within 0..16. Most generation writes are (the surface
    /// rule turns every stone under y 8 to deepslate), and this skips the
    /// checks `update` does first.
pub fn below_update(self: *Self, chunk: *impl HeightmapChunk, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: debug_assert!((0..16).contains(&x) && (0..16).contains(&z));
    // rust: let first = (self.data.read(Self::index(x, z)) as i32).wrapping_add(self.min_y);
    // rust: y <= first.wrapping_sub(2) && self.check_chunk(chunk).is_ok()
}

pub fn first_available(self: *Self, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok((self.data.get(Self::index(x, z))? as i32).wrapping_add(self.min_y))
}

    /// Whether any column of the local square `x0..=x1` by `z0..=z1` (each
    /// within 0..16) has its first available y at or above `y`.
    // rust: pub fn any_first_available_at_least(
    // rust: &self,
    // rust: [x0, x1]: [i32; 2],
    // rust: [z0, z1]: [i32; 2],
    // rust: y: i32,
    // rust: ) -> bool {
    // rust: debug_assert!(0 <= x0 && x1 < 16 && 0 <= z0 && z1 < 16);
    // rust: (z0..=z1).any(|z| {
    // rust: (x0..=x1)
    // rust: .any(|x| (self.data.read(Self::index(x, z)) as i32).wrapping_add(self.min_y) >= y)
    // rust: })
}

pub fn highest_taken(self: *Self, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.first_available(x, z)?.wrapping_sub(1))
}

pub fn set_height(self: *Self, x: i32, z: i32, y: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .set(Self::index(x, z), y.wrapping_sub(self.min_y) as u32)?;
    // rust: Ok(())
}

pub fn check_chunk(self: *Self, chunk: *impl HeightmapChunk) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if chunk.min_y() != self.min_y || chunk.height() != self.height {
    // rust: return Err(HeightmapError::MismatchedChunk);
}
    // rust: Ok(())
}

    /// The caller writes the new state to the chunk before updating its maps.
    // rust: pub fn update<C: HeightmapChunk>(
    // rust: &mut self,
    // rust: chunk: &C,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: state: C::State,
    // rust: ) -> Result<bool, HeightmapError> {
    // rust: self.check_chunk(chunk)?;
    // rust: let first = self.first_available(x, z)?;
    // rust: if y <= first.wrapping_sub(2) {
    // rust: return Ok(false);
}
    // rust: if self.kind.is_opaque(state) {
    // rust: if y >= first {
    // rust: self.set_height(x, z, y.wrapping_add(1))?;
    // rust: return Ok(true);
}
    // rust: } else if y == first.wrapping_sub(1) {
    // rust: let mut scan_y = y.wrapping_sub(1);
    // rust: while scan_y >= self.min_y {
    // rust: if self.kind.is_opaque(chunk.block_state(x, scan_y, z)) {
    // rust: self.set_height(x, z, scan_y.wrapping_add(1))?;
    // rust: return Ok(true);
}
    // rust: scan_y -= 1;
}
    // rust: self.set_height(x, z, self.min_y)?;
    // rust: return Ok(true);
}
    // rust: Ok(false)
}

    /// Matching lengths preserve all bits, including padding and unused slots.
    /// A length mismatch primes this registered map from the chunk instead.
    // rust: pub fn set_raw_data(
    // rust: &mut self,
    // rust: chunk: &impl HeightmapChunk,
    // rust: words: &[u64],
    // rust: ) -> Result<(), HeightmapError> {
    // rust: self.check_chunk(chunk)?;
    // rust: if words.len() == self.data.words().len() {
    // rust: self.data = PackedStorage::from_words(self.data.bits(), 256, words.to_vec())?;
    // rust: Ok(())
    // rust: } else {
    // rust: Self::prime(chunk, &mut [self])
}
}

    /// Preserves caller map order and scans X, then Z, then descending Y.
    /// An unfound column retains its previous value, including during re-priming.
    // rust: pub fn prime(
    // rust: chunk: &impl HeightmapChunk,
    // rust: maps: &mut [&mut Self],
    // rust: ) -> Result<(), HeightmapError> {
    // rust: if maps.is_empty() {
    // rust: return Ok(());
}
    // rust: for map in maps.iter() {
    // rust: map.check_chunk(chunk)?;
}
    // rust: let upper = chunk.highest_section_y().wrapping_add(16);
    // rust: let mut remaining = Vec::with_capacity(maps.len());
    // rust: for x in 0..16 {
    // rust: for z in 0..16 {
    // rust: remaining.clear();
    // rust: remaining.extend(0..maps.len());
    // rust: let mut y = upper.wrapping_sub(1);
    // rust: while y >= chunk.min_y() {
    // rust: let state = chunk.block_state(x, y, z);
    // rust: if !state.is_air_block() {
    // rust: let mut i = 0;
    // rust: while i < remaining.len() {
    // rust: let map = &mut maps[remaining[i]];
    // rust: if map.kind.is_opaque(state) {
    // rust: map.set_height(x, z, y.wrapping_add(1))?;
    // rust: remaining.remove(i);
    // rust: } else {
    // rust: i += 1;
}
}
    // rust: if remaining.is_empty() {
    // rust: break;
}
}
    // rust: y -= 1;
}
}
}
    // rust: Ok(())
}
}
