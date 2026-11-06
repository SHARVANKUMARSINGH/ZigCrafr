//! Transpiled from Horizon Rust crate
package horizon_core_fast_hash

import "core:fmt"
import "core:mem"
import "core:math"

// A fast, non-cryptographic hasher (the Fx hash used by rustc) for hot maps
// keyed by small integers, such as chunk coordinates. Iteration order of
// such maps carries no meaning: the default hasher's is random anyway.
// use std::hash::{BuildHasherDefault, Hasher};

SEED :: 0xf135_7aea_2e62_a9c5

FxHasher :: struct {
    hash: u64,
}
    // rust: impl FxHasher {
add :: proc(self: ^Self, word: u64) {
}
    // rust: self.hash = self.hash.wrapping_add(word).wrapping_mul(SEED);
}
}
    // rust: impl Hasher for FxHasher {
write :: proc(self: ^Self, bytes: []u8) {
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
write_u8 :: proc(self: ^Self, i: u8) {
}
    // rust: self.add(u64::from(i));
}
write_u16 :: proc(self: ^Self, i: u16) {
}
    // rust: self.add(u64::from(i));
}
write_u32 :: proc(self: ^Self, i: u32) {
}
    // rust: self.add(u64::from(i));
}
write_u64 :: proc(self: ^Self, i: u64) {
}
    // rust: self.add(i);
}
write_usize :: proc(self: ^Self, i: uint) {
}
    // rust: self.add(i as u64);
}
write_i32 :: proc(self: ^Self, i: i32) {
}
    // rust: self.add(u64::from(i as u32));
}
finish :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
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

nearby_chunks_spread_over_buckets :: proc() {
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
