//! Transpiled from Horizon Rust crate
//! Module: horizon-core_biome
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Block-to-quart biome lookup for Java Edition 26.3.
//! Selection is independent of the provider that stores or generates quart biomes.
    // rust: mod seed_hash;
// use crate::position::BlockPos;

/// The seed sent to clients: SHA-256 of the little-endian world seed, with the
/// first eight digest bytes interpreted as a little-endian signed long.
pub fn obfuscate_seed(world_seed: i64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: seed_hash::hash(world_seed)
}

pub const BiomeZoom = struct {
    seed: i64,
};
    // rust: impl BiomeZoom {
    /// Accepts the obfuscated biome seed, not the original world seed.
    // rust: pub const fn new(obfuscated_seed: i64) -> Self {
    // rust: Self {
    // rust: seed: obfuscated_seed,
}
}
    /// Choose the closest of eight jittered quart corners, preserving vanilla's
    /// corner order, strict tie comparison and signed coordinate wrapping.
    ///
    /// Each corner re-derives its distance from a fresh six-step mix driven by
    /// the quart coordinate. The first two steps depend only on the X and Y
    /// offsets, so those shared prefixes are mixed once (two X states, then four
    /// XY states) instead of eight times, and the six-step tail is evaluated for
    /// all eight corners. Since `next(m, salt + offset) == next(m, salt) +
    /// offset`, each coordinate is folded into its step with one addition.
pub fn quart_at_block(self: *Self, block: BlockPos) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shifted = [block.x, block.y, block.z].map(|v| v.wrapping_sub(2));
    // rust: let base = shifted.map(|v| v >> 2);
    // rust: let fractions = shifted.map(|v| f64::from(v & 3) / 4.);
    // rust: let coordinate = base.map(i64::from);
    // rust: let seed = self.seed;
pub const A: i64 = 6364136223846793005;
pub const B: i64 = 1442695040888963407;
    // rust: let g = |m: i64| m.wrapping_mul(m.wrapping_mul(A).wrapping_add(B));
    // rust: let root = g(seed);
    // rust: let m0: [i64; 2] =
    // rust: std::array::from_fn(|x: usize| root.wrapping_add(coordinate[0].wrapping_add(x as i64)));
    // rust: let m1: [[i64; 2]; 2] = std::array::from_fn(|x: usize| {
    // rust: std::array::from_fn(|y: usize| {
    // rust: g(m0[x]).wrapping_add(coordinate[1].wrapping_add(y as i64))
    // rust: })
    // rust: });
    // rust: let m2: [[[i64; 2]; 2]; 2] = std::array::from_fn(|x: usize| {
    // rust: std::array::from_fn(|y: usize| {
    // rust: std::array::from_fn(|z: usize| {
    // rust: g(m1[x][y]).wrapping_add(coordinate[2].wrapping_add(z as i64))
    // rust: })
    // rust: })
    // rust: });
    // rust: let m3: [[[i64; 2]; 2]; 2] = std::array::from_fn(|x: usize| {
    // rust: std::array::from_fn(|y: usize| {
    // rust: std::array::from_fn(|z: usize| {
    // rust: g(m2[x][y][z]).wrapping_add(coordinate[0].wrapping_add(x as i64))
    // rust: })
    // rust: })
    // rust: });
    // rust: let m4: [[[i64; 2]; 2]; 2] = std::array::from_fn(|x: usize| {
    // rust: std::array::from_fn(|y: usize| {
    // rust: std::array::from_fn(|z: usize| {
    // rust: g(m3[x][y][z]).wrapping_add(coordinate[1].wrapping_add(y as i64))
    // rust: })
    // rust: })
    // rust: });
    // rust: let m5: [[[i64; 2]; 2]; 2] = std::array::from_fn(|x: usize| {
    // rust: std::array::from_fn(|y: usize| {
    // rust: std::array::from_fn(|z: usize| {
    // rust: g(m4[x][y][z]).wrapping_add(coordinate[2].wrapping_add(z as i64))
    // rust: })
    // rust: })
    // rust: });
    // rust: let m6: [[[i64; 2]; 2]; 2] = std::array::from_fn(|x: usize| {
    // rust: std::array::from_fn(|y: usize| {
    // rust: std::array::from_fn(|z: usize| g(m5[x][y][z]).wrapping_add(seed))
    // rust: })
    // rust: });
    // rust: let m7: [[[i64; 2]; 2]; 2] = std::array::from_fn(|x: usize| {
    // rust: std::array::from_fn(|y: usize| {
    // rust: std::array::from_fn(|z: usize| g(m6[x][y][z]).wrapping_add(seed))
    // rust: })
    // rust: });
    // rust: let mut selected = base;
    // rust: let mut best = f64::INFINITY;
    // rust: for x in 0..2 {
    // rust: for y in 0..2 {
    // rust: for z in 0..2 {
    // rust: let dx = fractions[0] - x as f64 + fiddle(m5[x][y][z]);
    // rust: let dy = fractions[1] - y as f64 + fiddle(m6[x][y][z]);
    // rust: let dz = fractions[2] - z as f64 + fiddle(m7[x][y][z]);
    // rust: let distance = dz * dz + dy * dy + dx * dx;
    // rust: if best > distance {
    // rust: best = distance;
    // rust: selected = [
    // rust: base[0].wrapping_add(x as i32),
    // rust: base[1].wrapping_add(y as i32),
    // rust: base[2].wrapping_add(z as i32),
    // rust: ];
}
}
}
}
    // rust: selected
}
    /// The jitter `quart_at_block` adds to each of the eight corners of the
    /// quart cell `base` (the block position minus 2, shifted right by 2), as
    /// `[x, y, z]` per corner in its corner order (x, then y, then z offset).
    /// With `select_corner` this gives `quart_at_block`'s choice for every
    /// block of the cell from one mix.
pub fn corner_jitter(self: *Self, base: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let coordinate = base.map(i64::from);
    // rust: let seed = self.seed;
pub const A: i64 = 6364136223846793005;
pub const B: i64 = 1442695040888963407;
    // rust: let g = |m: i64| m.wrapping_mul(m.wrapping_mul(A).wrapping_add(B));
    // rust: let root = g(seed);
    // rust: std::array::from_fn(|corner| {
    // rust: let [x, y, z] = [(corner >> 2) & 1, (corner >> 1) & 1, corner & 1].map(|v| v as i64);
    // rust: let m0 = root.wrapping_add(coordinate[0].wrapping_add(x));
    // rust: let m1 = g(m0).wrapping_add(coordinate[1].wrapping_add(y));
    // rust: let m2 = g(m1).wrapping_add(coordinate[2].wrapping_add(z));
    // rust: let m3 = g(m2).wrapping_add(coordinate[0].wrapping_add(x));
    // rust: let m4 = g(m3).wrapping_add(coordinate[1].wrapping_add(y));
    // rust: let m5 = g(m4).wrapping_add(coordinate[2].wrapping_add(z));
    // rust: let m6 = g(m5).wrapping_add(seed);
    // rust: let m7 = g(m6).wrapping_add(seed);
    // rust: [fiddle(m5), fiddle(m6), fiddle(m7)]
    // rust: })
}
    /// The corner (index into `corner_jitter`) `quart_at_block` picks for
    /// `block` inside the cell whose jitter is `jitter`.
pub fn select_corner(block: BlockPos, jitter: *[[f64; 3]; 8]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fractions = [block.x, block.y, block.z].map(|v| f64::from(v.wrapping_sub(2) & 3) / 4.);
    // rust: let mut selected = 0;
    // rust: let mut best = f64::INFINITY;
    // rust: for (corner, jitter) in jitter.iter().enumerate() {
    // rust: let dx = fractions[0] - ((corner >> 2) & 1) as f64 + jitter[0];
    // rust: let dy = fractions[1] - ((corner >> 1) & 1) as f64 + jitter[1];
    // rust: let dz = fractions[2] - (corner & 1) as f64 + jitter[2];
    // rust: let distance = dz * dz + dy * dy + dx * dx;
    // rust: if best > distance {
    // rust: best = distance;
    // rust: selected = corner;
}
}
    // rust: selected
}
}

/// Direct noise-biome lookup bypasses the eight-corner zoom.
pub fn noise_quart_at_block(block: BlockPos) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [block.x, block.y, block.z].map(|v| v >> 2)
}
/// Java floors each double to a saturating int (NaN becomes zero) before shifting.
pub fn noise_quart_at_position(position: [f64; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: position.map(|v| (v.floor() as i32) >> 2)
}
pub fn fiddle(seed: i64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (((seed >> 24) & 1023) as f64 / 1024. - 0.5) * 0.9
}

    // rust: mod tests {
//     use super::*;

    /// The straightforward per-corner formulation, kept as the parity oracle
    /// for the prefix-shared implementation.
pub fn reference(seed: i64, block: BlockPos) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shifted = [block.x, block.y, block.z].map(|v| v.wrapping_sub(2));
    // rust: let base = shifted.map(|v| v >> 2);
    // rust: let fractions = shifted.map(|v| f64::from(v & 3) / 4.);
    // rust: let mut selected = base;
    // rust: let mut best = f64::INFINITY;
    // rust: for corner in 0..8 {
    // rust: let offsets = [(corner >> 2) & 1, (corner >> 1) & 1, corner & 1];
    // rust: let quart: [i32; 3] = std::array::from_fn(|i| base[i].wrapping_add(offsets[i]));
    // rust: let delta: [f64; 3] = std::array::from_fn(|i| fractions[i] - f64::from(offsets[i]));
    // rust: let mut mixed = seed;
    // rust: for coordinate in quart.into_iter().cycle().take(6) {
    // rust: mixed = mixed
    // rust: .wrapping_mul(
    // rust: mixed
    // rust: .wrapping_mul(6364136223846793005)
    // rust: .wrapping_add(1442695040888963407),
    // rust: )
    // rust: .wrapping_add(i64::from(coordinate));
}
    // rust: let x = delta[0] + fiddle(mixed);
    // rust: mixed = mixed
    // rust: .wrapping_mul(
    // rust: mixed
    // rust: .wrapping_mul(6364136223846793005)
    // rust: .wrapping_add(1442695040888963407),
    // rust: )
    // rust: .wrapping_add(seed);
    // rust: let y = delta[1] + fiddle(mixed);
    // rust: mixed = mixed
    // rust: .wrapping_mul(
    // rust: mixed
    // rust: .wrapping_mul(6364136223846793005)
    // rust: .wrapping_add(1442695040888963407),
    // rust: )
    // rust: .wrapping_add(seed);
    // rust: let z = delta[2] + fiddle(mixed);
    // rust: let distance = z * z + y * y + x * x;
    // rust: if best > distance {
    // rust: best = distance;
    // rust: selected = quart;
}
}
    // rust: selected
}

pub fn quart_at_block_matches_reference() void {
}
    // rust: let seeds = [
    // rust: 0i64,
    // rust: 1,
    // rust: -1,
    // rust: i64::MIN,
    // rust: i64::MAX,
    // rust: 0x0123_4567_89ab_cdef,
    // rust: -0x0123_4567_89ab_cdef,
    // rust: ];
    // rust: let extremes = [
    // rust: i32::MIN,
    // rust: i32::MIN + 1,
    // rust: -1,
    // rust: 0,
    // rust: 1,
    // rust: 2,
    // rust: 3,
    // rust: 4,
    // rust: -2,
    // rust: i32::MAX - 1,
    // rust: i32::MAX,
    // rust: ];
    // rust: for &seed in &seeds {
    // rust: let zoom = BiomeZoom::new(seed);
    // rust: for x in -34..34 {
    // rust: for y in -34..34 {
    // rust: for z in -34..34 {
    // rust: let block = BlockPos::new(x, y, z);
    // rust: assert_eq!(
    // rust: zoom.quart_at_block(block),
    // rust: reference(seed, block),
    // rust: "seed {seed} at {x} {y} {z}"
    // rust: );
}
}
}
    // rust: for &x in &extremes {
    // rust: for &y in &extremes {
    // rust: for &z in &extremes {
    // rust: let block = BlockPos::new(x, y, z);
    // rust: assert_eq!(
    // rust: zoom.quart_at_block(block),
    // rust: reference(seed, block),
    // rust: "seed {seed} at {x} {y} {z}"
    // rust: );
}
}
}
}
}

pub fn corner_jitter_matches_quart_at_block() void {
}
    // rust: for seed in [0i64, -1, i64::MIN, 0x0123_4567_89ab_cdef] {
    // rust: let zoom = BiomeZoom::new(seed);
    // rust: let check = |block: BlockPos| {
    // rust: let base = [block.x, block.y, block.z].map(|v| v.wrapping_sub(2) >> 2);
    // rust: let corner = BiomeZoom::select_corner(block, &zoom.corner_jitter(base));
    // rust: let offsets = [(corner >> 2) & 1, (corner >> 1) & 1, corner & 1];
    // rust: let quart: [i32; 3] =
    // rust: std::array::from_fn(|i| base[i].wrapping_add(offsets[i] as i32));
    // rust: assert_eq!(
    // rust: quart,
    // rust: zoom.quart_at_block(block),
    // rust: "seed {seed} at {block:?}"
    // rust: );
}
    // rust: for x in -20..20 {
    // rust: for y in -20..20 {
    // rust: for z in -20..20 {
    // rust: check(BlockPos::new(x, y, z));
}
}
}
    // rust: for v in [i32::MIN, i32::MIN + 1, -1, 0, i32::MAX - 1, i32::MAX] {
    // rust: check(BlockPos::new(v, v, v));
    // rust: check(BlockPos::new(v, v.wrapping_neg(), 3));
}
}
}
}
