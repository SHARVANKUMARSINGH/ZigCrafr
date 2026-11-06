//! Transpiled from Horizon Rust crate
//! Module: horizon-core_worldgen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Legacy bit-sampling adapter used by vanilla's world-generation random stream.
// use super::{InvalidBound, LegacyRandom, PositionalRandom, RandomSource, XoroshiroRandom};
// use crate::position::BlockPos;

    // rust: mod sealed {
    // rust: pub trait Sealed {}
}
    // rust: pub trait WorldgenSource: RandomSource + sealed::Sealed {
pub fn worldgen_bits(self: *Self, count: i32) i;
}
    // rust: impl sealed::Sealed for LegacyRandom {}
    // rust: impl WorldgenSource for LegacyRandom {
pub fn worldgen_bits(self: *Self, count: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state = self.state.wrapping_mul(Self::MULTIPLIER).wrapping_add(11) & Self::MASK;
    // rust: self.state.wrapping_shr(48_i32.wrapping_sub(count) as u32) as i32
}
}
    // rust: impl sealed::Sealed for XoroshiroRandom {}
    // rust: impl WorldgenSource for XoroshiroRandom {
pub fn worldgen_bits(self: *Self, count: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.next_long() as u64).wrapping_shr(64_i32.wrapping_sub(count) as u32) as i32
}
}

pub const WorldgenRandom = struct {
    source: R,
    count: i32,
    wrapped: bool,
    /// The adapter's own Gaussian cache; native setSeed does not reset it.
    gaussian: ?f64,
};
    // rust: impl<R: WorldgenSource> WorldgenRandom<R> {
pub fn new(source: R) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: source,
    // rust: count: 0,
    // rust: wrapped: true,
    // rust: gaussian: None,
}
}
pub fn plain(source: R) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: source,
    // rust: count: 0,
    // rust: wrapped: false,
    // rust: gaussian: None,
}
}
pub fn count(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.count
}
pub fn next_bits(self: *Self, bits: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.wrapped {
    // rust: self.count = self.count.wrapping_add(1);
}
    // rust: self.source.worldgen_bits(bits)
}
pub fn set_decoration_seed(self: *Self, seed: i64, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.set_seed(seed);
    // rust: let a = self.next_long() | 1;
    // rust: let b = self.next_long() | 1;
    // rust: let mixed = (x as i64)
    // rust: .wrapping_mul(a)
    // rust: .wrapping_add((z as i64).wrapping_mul(b))
    // rust: ^ seed;
    // rust: self.set_seed(mixed);
    // rust: mixed
}
pub fn set_feature_seed(self: *Self, seed: i64, index: i32, step: i32) void {
}
    // rust: self.set_seed(
    // rust: seed.wrapping_add(index as i64)
    // rust: .wrapping_add(step.wrapping_mul(10000) as i64),
    // rust: );
}
pub fn set_large_feature_seed(self: *Self, seed: i64, x: i32, z: i32) void {
}
    // rust: self.set_seed(seed);
    // rust: let a = self.next_long();
    // rust: let b = self.next_long();
    // rust: self.set_seed((x as i64).wrapping_mul(a) ^ (z as i64).wrapping_mul(b) ^ seed);
}
pub fn set_large_feature_with_salt(self: *Self, seed: i64, x: i32, z: i32, salt: i32) void {
}
    // rust: self.set_seed(
    // rust: (x as i64)
    // rust: .wrapping_mul(341873128712)
    // rust: .wrapping_add((z as i64).wrapping_mul(132897987541))
    // rust: .wrapping_add(seed)
    // rust: .wrapping_add(salt as i64),
    // rust: );
}
}
    // rust: impl<R: WorldgenSource> sealed::Sealed for WorldgenRandom<R> {}
    // rust: impl<R: WorldgenSource> WorldgenSource for WorldgenRandom<R> {
pub fn worldgen_bits(self: *Self, count: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_bits(count)
}
}
    // rust: impl<R: WorldgenSource> RandomSource for WorldgenRandom<R> {
    // rust: type Positional = WorldgenPositional<R::Positional>;
pub fn set_seed(self: *Self, seed: i64) void {
}
    // rust: self.source.set_seed(seed);
}
pub fn next_int(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.wrapped {
    // rust: self.next_bits(32)
    // rust: } else {
    // rust: self.source.next_int()
}
}
pub fn next_int_bound(self: *Self, bound: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.wrapped {
    // rust: return self.source.next_int_bound(bound);
}
    // rust: if bound <= 0 {
    // rust: return Err(InvalidBound);
}
    // rust: if bound & (bound - 1) == 0 {
    // rust: return Ok(((bound as i64 * self.next_bits(31) as i64) >> 31) as i32);
}
    // rust: loop {
    // rust: let bits = self.next_bits(31);
    // rust: let value = bits % bound;
    // rust: if bits.wrapping_sub(value).wrapping_add(bound - 1) >= 0 {
    // rust: return Ok(value);
}
}
}
pub fn next_long(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.wrapped {
    // rust: return self.source.next_long();
}
    // rust: let high = (self.next_bits(32) as i64) << 32;
    // rust: high.wrapping_add(self.next_bits(32) as i64)
}
pub fn next_boolean(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.wrapped {
    // rust: self.next_bits(1) != 0
    // rust: } else {
    // rust: self.source.next_boolean()
}
}
pub fn next_float(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.wrapped {
    // rust: self.next_bits(24) as f32 * (1.0 / 16777216.0)
    // rust: } else {
    // rust: self.source.next_float()
}
}
pub fn next_double(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.wrapped {
    // rust: return self.source.next_double();
}
    // rust: let bits = ((self.next_bits(26) as i64) << 27) + self.next_bits(27) as i64;
    // rust: bits as f64 * (1.0 / 9007199254740992.0)
}
pub fn next_gaussian(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.wrapped {
    // rust: return self.source.next_gaussian();
}
    // rust: let mut cache = self.gaussian.take();
    // rust: let value = super::marsaglia_polar(&mut cache, || self.next_double());
    // rust: self.gaussian = cache;
    // rust: value
}
    /// Native forks return the underlying source, not another bit adapter.
    /// The returned value keeps that behavior through a transparent variant.
pub fn fork(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::plain(self.source.fork())
}
pub fn fork_positional(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WorldgenPositional(self.source.fork_positional())
}
}
pub const WorldgenPositional = struct {};
    // rust: impl<P: PositionalRandom> PositionalRandom for WorldgenPositional<P>
    // rust: where
    // rust: P::Source: WorldgenSource,
    // rust: {
    // rust: type Source = WorldgenRandom<P::Source>;
pub fn at(self: *Self, position: BlockPos) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WorldgenRandom::plain(self.0.at(position))
}
pub fn from_seed(self: *Self, seed: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WorldgenRandom::plain(self.0.from_seed(seed))
}
pub fn from_hash_of(self: *Self, name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WorldgenRandom::plain(self.0.from_hash_of(name))
}
pub fn from_hash_of_utf16(self: *Self, name: *[u16]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WorldgenRandom::plain(self.0.from_hash_of_utf16(name))
}
}
pub fn slime_chunk_random(x: i32, z: i32, seed: i64, salt: i64) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mixed = seed
    // rust: .wrapping_add(x.wrapping_mul(x).wrapping_mul(4987142) as i64)
    // rust: .wrapping_add(x.wrapping_mul(5947611) as i64)
    // rust: .wrapping_add((z.wrapping_mul(z) as i64).wrapping_mul(4392871))
    // rust: .wrapping_add(z.wrapping_mul(389711) as i64)
    // rust: ^ salt;
    // rust: LegacyRandom::new(mixed)
}
