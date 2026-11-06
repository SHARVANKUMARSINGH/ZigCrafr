//! Transpiled from Horizon Rust crate
package horizon_core_positional

import "core:fmt"
import "core:mem"
import "core:math"

// use super::{LegacyRandom, RandomSource, XoroshiroRandom, seed_from_hash, seed_from_hash_utf16};
// use crate::position::BlockPos;

    // rust: pub trait PositionalRandom {
    // rust: type Source: RandomSource;
at :: proc(self: ^Self, position: BlockPos) -> S {
    // Ported from Horizon
    return {}
}
from_seed :: proc(self: ^Self, seed: i64) -> S {
    // Ported from Horizon
    return {}
}
from_hash_of :: proc(self: ^Self, name: string) -> S {
    // Ported from Horizon
    return {}
}
from_hash_of_utf16 :: proc(self: ^Self, name: ^[u16]) -> S {
    // Ported from Horizon
    return {}
}
}

LegacyPositionalRandom :: struct {
    seed: i64,
    base: u64,
}
    // rust: impl LegacyPositionalRandom {
    // rust: pub const fn new(seed: i64) -> Self {
    // rust: let base = (seed as u64 ^ 0x5_deec_e66d) & ((1 << 48) - 1);
    // rust: Self { seed, base }
}
}
    // rust: impl PositionalRandom for LegacyPositionalRandom {
    // rust: type Source = LegacyRandom;
at :: proc(self: ^Self, position: BlockPos) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let p = (position_seed(position) as u64) & ((1 << 48) - 1);
    // rust: LegacyRandom::from_state(p ^ self.base)
}
from_seed :: proc(self: ^Self, seed: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: LegacyRandom::new(seed)
}
from_hash_of :: proc(self: ^Self, name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let h = (java_string_hash(name.encode_utf16()) as i64 as u64) & ((1 << 48) - 1);
    // rust: LegacyRandom::from_state(h ^ self.base)
}
from_hash_of_utf16 :: proc(self: ^Self, name: ^[u16]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let h = (java_string_hash(name.iter().copied()) as i64 as u64) & ((1 << 48) - 1);
    // rust: LegacyRandom::from_state(h ^ self.base)
}
}
XoroshiroPositionalRandom :: struct {
    lo: u64,
    hi: u64,
}
    // rust: impl XoroshiroPositionalRandom {
    // rust: pub const fn new(lo: u64, hi: u64) -> Self {
    // rust: Self { lo, hi }
}
}
    // rust: impl PositionalRandom for XoroshiroPositionalRandom {
    // rust: type Source = XoroshiroRandom;
at :: proc(self: ^Self, position: BlockPos) -> S {
    // Ported from Horizon
    return {}
}
    // rust: XoroshiroRandom::from_state(position_seed(position) as u64 ^ self.lo, self.hi)
}
from_seed :: proc(self: ^Self, seed: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: XoroshiroRandom::from_state(seed as u64 ^ self.lo, seed as u64 ^ self.hi)
}
from_hash_of :: proc(self: ^Self, name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let [lo, hi] = seed_from_hash(name);
    // rust: XoroshiroRandom::from_state(lo ^ self.lo, hi ^ self.hi)
}
from_hash_of_utf16 :: proc(self: ^Self, name: ^[u16]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let [lo, hi] = seed_from_hash_utf16(name);
    // rust: XoroshiroRandom::from_state(lo ^ self.lo, hi ^ self.hi)
}
}
java_string_hash :: proc(name: impl IntoIterator<Item = u16>) -> i {
    // Ported from Horizon
    return {}
}
    // rust: name.into_iter().fold(0i32, |hash, unit| {
    // rust: hash.wrapping_mul(31).wrapping_add(unit as i32)
    // rust: })
}
// Mth.getSeed's signed Java arithmetic, including the initial int product.
    // rust: pub const fn position_seed(position: BlockPos) -> i64 {
    // rust: let mixed = position.x.wrapping_mul(3_129_871) as i64
    // rust: ^ (position.z as i64).wrapping_mul(116_129_781)
    // rust: ^ position.y as i64;
    // rust: mixed
    // rust: .wrapping_mul(mixed)
    // rust: .wrapping_mul(42_317_861)
    // rust: .wrapping_add(mixed.wrapping_mul(11))
    // rust: >> 16
}

    // rust: mod tests {
//     use super::*;

legacy_positional_matches_direct_seeding :: proc() {
}
    // rust: let seeds = [0, 1, -1, 42, 123456789, -987654321, i64::MAX, i64::MIN];
    // rust: let positions = [
    // rust: BlockPos::new(0, 0, 0),
    // rust: BlockPos::new(10, 64, -20),
    // rust: BlockPos::new(-1000, 320, 5000),
    // rust: BlockPos::new(123456, -64, -654321),
    // rust: ];

    // rust: for &s in &seeds {
    // rust: let factory = LegacyPositionalRandom::new(s);
    // rust: for &pos in &positions {
    // rust: let mut direct = LegacyRandom::new(position_seed(pos) ^ s);
    // rust: let mut opt = factory.at(pos);
    // rust: for _ in 0..10 {
    // rust: assert_eq!(direct.next_int(), opt.next_int());
}
}

    // rust: for name in ["minecraft:ore", "minecraft:tree", "test", ""] {
    // rust: let mut direct =
    // rust: LegacyRandom::new(java_string_hash(name.encode_utf16()) as i64 ^ s);
    // rust: let mut opt = factory.from_hash_of(name);
    // rust: for _ in 0..10 {
    // rust: assert_eq!(direct.next_int(), opt.next_int());
}
}
}
}

benchmark_legacy_positional_at :: proc() {
}
//         use std::time::Instant;
    // rust: let s = 123456789i64;
    // rust: let factory = LegacyPositionalRandom::new(s);
    // rust: let positions: Vec<BlockPos> = (0..10_000)
    // rust: .map(|i| BlockPos::new((i * 17) % 1000, (i * 31) % 256, (i * 47) % 1000))
    // rust: .collect();

        // Baseline (recalculating seed ^ MULTIPLIER & MASK every call):
    // rust: let start = Instant::now();
    // rust: let iters = 200;
    // rust: let mut sum_base = 0i64;
    // rust: for _ in 0..iters {
    // rust: for &pos in &positions {
    // rust: let mut r = LegacyRandom::new(position_seed(pos) ^ s);
    // rust: sum_base = sum_base.wrapping_add(r.next_int() as i64);
}
}
    // rust: let elapsed_base = start.elapsed();

        // Optimized (precomputed 48-bit base):
    // rust: let start = Instant::now();
    // rust: let mut sum_opt = 0i64;
    // rust: for _ in 0..iters {
    // rust: for &pos in &positions {
    // rust: let mut r = factory.at(pos);
    // rust: sum_opt = sum_opt.wrapping_add(r.next_int() as i64);
}
}
    // rust: let elapsed_opt = start.elapsed();

    // rust: assert_eq!(sum_base, sum_opt);
    // rust: println!(
    // rust: "benchmark_legacy_positional_at ({} queries):\n  Baseline (origin/main): {:?} ({:.2} ns/query)\n  Optimized (48-bit precomputed): {:?} ({:.2} ns/query)\n  Speedup: {:.2}x ({:.1}% faster)",
    // rust: positions.len() * iters,
    // rust: elapsed_base,
    // rust: elapsed_base.as_nanos() as f64 / (positions.len() * iters) as f64,
    // rust: elapsed_opt,
    // rust: elapsed_opt.as_nanos() as f64 / (positions.len() * iters) as f64,
    // rust: elapsed_base.as_secs_f64() / elapsed_opt.as_secs_f64(),
    // rust: (1.0 - elapsed_opt.as_secs_f64() / elapsed_base.as_secs_f64()) * 100.0
    // rust: );
}
}
