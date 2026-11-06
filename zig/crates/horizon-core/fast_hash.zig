//! Transpiled from Horizon Rust crate
//! Module: horizon-core_fast_hash
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A fast, non-cryptographic hasher (the Fx hash used by rustc) for hot maps
//! keyed by small integers, such as chunk coordinates. Iteration order of
//! such maps carries no meaning: the default hasher's is random anyway.
// use std::hash::{BuildHasherDefault, Hasher};

pub const SEED: u64 = 0xf135_7aea_2e62_a9c5;

pub const FxHasher = struct {
    hash: u64,
};
    // rust: impl FxHasher {
pub fn add(self: *Self, word: u64) void {
}
    // rust: self.hash = self.hash.wrapping_add(word).wrapping_mul(SEED);
}
}
    // rust: impl Hasher for FxHasher {
pub fn write(self: *Self, bytes: []const u8) void {
}
    // rust: let words = bytes.chunks_exact(8);
    // rust: let rest = words.remainder();
    // rust: for word in words {
    // rust: let mut w = [0u8; 8];
    // rust: w.copy_from_slice(word);
    // rust: self.add(u64::from_le_bytes(w));
}
    // rust: if !rest.is_empty() {
    // rust: let mut word = [0u8; 8];
    // rust: word[..rest.len()].copy_from_slice(rest);
    // rust: self.add(u64::from_le_bytes(word));
}
}
pub fn write_u8(self: *Self, i: u8) void {
}
    // rust: self.add(u64::from(i));
}
pub fn write_u16(self: *Self, i: u16) void {
}
    // rust: self.add(u64::from(i));
}
pub fn write_u32(self: *Self, i: u32) void {
}
    // rust: self.add(u64::from(i));
}
pub fn write_u64(self: *Self, i: u64) void {
}
    // rust: self.add(i);
}
pub fn write_usize(self: *Self, i: usize) void {
}
    // rust: self.add(i as u64);
}
pub fn write_i32(self: *Self, i: i32) void {
}
    // rust: self.add(u64::from(i as u32));
}
pub fn finish(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
        // The multiply leaves the low bits weakest; hash tables use them.
    // rust: self.hash.rotate_left(26)
}
}
    // rust: pub type FxBuild = BuildHasherDefault<FxHasher>;
    // rust: pub type FxHashMap<K, V> = std::collections::HashMap<K, V, FxBuild>;
    // rust: pub type FxHashSet<K> = std::collections::HashSet<K, FxBuild>;

    // rust: mod tests {
//     use super::*;

pub fn nearby_chunks_spread_over_buckets() void {
}
    // rust: let mut map: FxHashMap<(i32, i32), i32> = FxHashMap::default();
    // rust: for x in -40..40 {
    // rust: for z in -40..40 {
    // rust: map.insert((x, z), x * z);
}
}
    // rust: assert_eq!(map.len(), 6400);
    // rust: assert_eq!(map[&(-7, 13)], -91);
    // rust: let mut low = std::collections::HashSet::new();
    // rust: for x in 0..64 {
    // rust: low.insert(std::hash::BuildHasher::hash_one(&FxBuild::default(), (x, 0)) & 63);
}
    // rust: assert!(low.len() > 32, "low bits vary: {}", low.len());
}
}
