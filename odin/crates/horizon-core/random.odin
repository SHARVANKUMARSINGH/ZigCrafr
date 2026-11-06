//! Transpiled from Horizon Rust crate
package horizon_core_random

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla's two seeded random streams. No platform/default Rust RNG is used.
    // rust: mod hash;
    // rust: mod positional;
    // rust: mod worldgen;
    // rust: pub use hash::{seed_from_hash, seed_from_hash_utf16};
    // rust: pub use positional::{
    // rust: LegacyPositionalRandom, PositionalRandom, XoroshiroPositionalRandom, java_string_hash,
    // rust: position_seed,
}
    // rust: pub use worldgen::{WorldgenPositional, WorldgenRandom, WorldgenSource, slime_chunk_random};

// Call sites of `LegacyRandom` draws, recorded while switched on (the
// counterpart of the mob AI oracle's `TracingRandom`).
    // rust: pub mod trace {
//     use std::cell::{Cell, RefCell};
    // rust: thread_local! {
ON :: const { Cell::new(false) }
LOG :: const { RefCell::new(Vec::new()) }
}
set :: proc(on: bool) {
}
    // rust: ON.with(|c| c.set(on));
}
    // The draws recorded since the last call, as `bits=value: frames`.
take :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: LOG.with(|l| std::mem::take(&mut *l.borrow_mut()))
}
    // rust: pub(super) fn record(bits: u32, value: i32) {
    // rust: if !ON.with(Cell::get) {
    // rust: return;
}
    // rust: let text = std::backtrace::Backtrace::force_capture().to_string();
    // rust: let mut line = format!("{bits}={value:x}:");
    // rust: let mut name = "";
    // rust: let mut n = 0;
    // rust: for raw in text.lines() {
    // rust: let raw = raw.trim();
    // rust: match raw.strip_prefix("at ") {
    // rust: Some(at) if at.contains("horizon-client/src/") && n < 7 => {
    // rust: let file = at.rsplit('/').next().unwrap_or(at);
    // rust: let file = file.rsplit_once(':').map_or(file, |(f, _)| f);
    // rust: let short = name.split('<').next().unwrap_or(name);
    // rust: let short = short.rsplit("::").next().unwrap_or(short);
    // rust: line.push_str(&format!(" {short}@{file}"));
    // rust: n += 1;
}
    // rust: Some(_) => {}
    // rust: None => name = raw.split_once(": ").map_or("", |(_, f)| f),
}
}
    // rust: LOG.with(|l| l.borrow_mut().push(line));
}
}

InvalidBound :: struct {

    // rust: impl std::fmt::Display for InvalidBound {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str("bound must be positive")
}
}

    // rust: impl std::error::Error for InvalidBound {}

    // rust: pub trait RandomSource: Sized {
    // rust: type Positional: PositionalRandom<Source = Self>;
set_seed :: proc(self: ^Self, seed: i64) {
}
next_int :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
next_int_bound :: proc(self: ^Self, bound: i32) -> R {
    // Ported from Horizon
    return {}
}
next_long :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
next_boolean :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
next_float :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
next_double :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // MarsagliaPolarGaussian over this source; the cached second value is
    // part of the source state (reset by `set_seed` where vanilla resets it).
next_gaussian :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
fork_positional :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
fork :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized;

consume_count :: proc(self: ^Self, count: i32) {
}
    // rust: for _ in 0..count {
    // rust: self.next_int();
}
}
next_int_between_inclusive :: proc(self: ^Self, min: i32, max: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.next_int_bound(max.wrapping_sub(min).wrapping_add(1))
    // rust: .map(|v| v.wrapping_add(min))
}
next_int_between :: proc(self: ^Self, origin: i32, bound: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if origin >= bound {
    // rust: return Err(InvalidBound);
}
    // rust: self.next_int_bound(bound.wrapping_sub(origin))
    // rust: .map(|v| v.wrapping_add(origin))
}
triangle :: proc(self: ^Self, mean: f64, deviation: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: mean + deviation * (self.next_double() - self.next_double())
}
triangle_float :: proc(self: ^Self, mean: f32, deviation: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: mean + deviation * (self.next_float() - self.next_float())
}
}

LegacyRandom :: struct {
    state: u64,
    gaussian: Maybe(f64),
}

    // rust: impl LegacyRandom {
MULTIPLIER :: 0x5_deec_e66d
MASK :: (1 << 48) - 1

new :: proc(seed: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: state: (seed as u64 ^ Self::MULTIPLIER) & Self::MASK,
    // rust: gaussian: None,
}
}

    // Construct from an already-masked 48-bit state.
    // rust: pub const fn from_state(state: u64) -> Self {
    // rust: Self {
    // rust: state,
    // rust: gaussian: None,
}
}

    // The 48-bit generator state (differential tests compare it).
state :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.state
}

bits :: proc(self: ^Self, count: u32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.state = self.state.wrapping_mul(Self::MULTIPLIER).wrapping_add(11) & Self::MASK;
    // rust: let value = (self.state >> (48 - count)) as i32;
    // rust: trace::record(count, value);
    // rust: value
}
}

    // rust: impl RandomSource for LegacyRandom {
    // rust: type Positional = LegacyPositionalRandom;
fork_positional :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: LegacyPositionalRandom::new(self.next_long())
}
set_seed :: proc(self: ^Self, seed: i64) {
}
    // rust: *self = Self::new(seed);
}

next_int :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.bits(32)
}

next_int_bound :: proc(self: ^Self, bound: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if bound <= 0 {
    // rust: return Err(InvalidBound);
}
    // rust: if bound & (bound - 1) == 0 {
    // rust: return Ok(((i64::from(bound) * i64::from(self.bits(31))) >> 31) as i32);
}
    // rust: loop {
    // rust: let bits = self.bits(31);
    // rust: let value = bits % bound;
            // Java's signed overflow is part of the rejection rule.
    // rust: if bits.wrapping_sub(value).wrapping_add(bound - 1) >= 0 {
    // rust: return Ok(value);
}
}
}

next_long :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let high = i64::from(self.bits(32)) << 32;
        // Java sign-extends the low int before addition; concatenation differs.
    // rust: high.wrapping_add(i64::from(self.bits(32)))
}

next_boolean :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.bits(1) != 0
}
next_float :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.bits(24) as f32 * (1.0 / 16_777_216.0)
}
next_double :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let value = (i64::from(self.bits(26)) << 27) + i64::from(self.bits(27));
    // rust: value as f64 * (1.0 / 9_007_199_254_740_992.0)
}
next_gaussian :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut cache = self.gaussian.take();
    // rust: let value = marsaglia_polar(&mut cache, || self.next_double());
    // rust: self.gaussian = cache;
    // rust: value
}

fork :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(self.next_long())
}
}

XoroshiroRandom :: struct {
    lo: u64,
    hi: u64,
    gaussian: Maybe(f64),
}

    // rust: impl XoroshiroRandom {
GOLDEN_RATIO :: 0x9e37_79b9_7f4a_7c15
SILVER_RATIO :: 0x6a09_e667_f3bc_c909

new :: proc(seed: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let lo = seed as u64 ^ Self::SILVER_RATIO;
    // rust: Self::from_state(
    // rust: mix_stafford13(lo),
    // rust: mix_stafford13(lo.wrapping_add(Self::GOLDEN_RATIO)),
    // rust: )
}

    // The generator's two state words (`Xoroshiro128PlusPlus.CODEC`).
state_words :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (self.lo, self.hi)
}

from_state :: proc(lo: u64, hi: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if lo | hi == 0 {
    // rust: Self {
    // rust: lo: Self::GOLDEN_RATIO,
    // rust: hi: Self::SILVER_RATIO,
    // rust: gaussian: None,
}
    // rust: } else {
    // rust: Self {
    // rust: lo,
    // rust: hi,
    // rust: gaussian: None,
}
}
}
}

    // rust: impl RandomSource for XoroshiroRandom {
    // rust: type Positional = XoroshiroPositionalRandom;
fork_positional :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let lo = self.next_long() as u64;
    // rust: let hi = self.next_long() as u64;
    // rust: XoroshiroPositionalRandom::new(lo, hi)
}
set_seed :: proc(self: ^Self, seed: i64) {
}
    // rust: *self = Self::new(seed);
}
next_int :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.next_long() as i32
}

next_int_bound :: proc(self: ^Self, bound: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if bound <= 0 {
    // rust: return Err(InvalidBound);
}
    // rust: let bound = bound as u32;
    // rust: let threshold = bound.wrapping_neg() % bound;
    // rust: loop {
    // rust: let product = u64::from(self.next_int() as u32) * u64::from(bound);
    // rust: if product as u32 >= threshold {
    // rust: return Ok((product >> 32) as i32);
}
}
}

next_long :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let lo = self.lo;
    // rust: let hi = self.hi ^ lo;
    // rust: let result = lo.wrapping_add(self.hi).rotate_left(17).wrapping_add(lo);
    // rust: self.lo = lo.rotate_left(49) ^ hi ^ (hi << 21);
    // rust: self.hi = hi.rotate_left(28);
    // rust: result as i64
}

next_boolean :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.next_long() & 1 != 0
}
next_float :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((self.next_long() as u64) >> 40) as f32 * (1.0 / 16_777_216.0)
}
next_double :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((self.next_long() as u64) >> 11) as f64 * (1.0 / 9_007_199_254_740_992.0)
}
next_gaussian :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut cache = self.gaussian.take();
    // rust: let value = marsaglia_polar(&mut cache, || self.next_double());
    // rust: self.gaussian = cache;
    // rust: value
}
fork :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let lo = self.next_long() as u64;
    // rust: let hi = self.next_long() as u64;
    // rust: Self::from_state(lo, hi)
}
}

// MarsagliaPolarGaussian.nextGaussian with an external second-value cache.
marsaglia_polar :: proc(cache: ^Maybe(f64), mut next_double: impl FnMut() -> f {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(value) = cache.take() {
    // rust: return value;
}
    // rust: loop {
    // rust: let x = 2.0 * next_double() - 1.0;
    // rust: let y = 2.0 * next_double() - 1.0;
    // rust: let radius = x * x + y * y;
    // rust: if radius >= 1.0 || radius == 0.0 {
    // rust: continue;
}
    // rust: let multiplier = (-2.0 * crate::jmath::log(radius) / radius).sqrt();
    // rust: *cache = Some(y * multiplier);
    // rust: return x * multiplier;
}
}

    // rust: pub const fn mix_stafford13(mut value: u64) -> u64 {
    // rust: value = (value ^ (value >> 30)).wrapping_mul(0xbf58_476d_1ce4_e5b9);
    // rust: value = (value ^ (value >> 27)).wrapping_mul(0x94d0_49bb_1331_11eb);
    // rust: value ^ (value >> 31)
}

    // rust: mod tests {
//     use super::*;

legacy_jdk_sequence_and_sign_extended_low_word :: proc() {
}
    // rust: let mut rng = LegacyRandom::new(0);
    // rust: assert_eq!(rng.next_int(), -1_155_484_576);
    // rust: assert_eq!(rng.next_int(), -723_955_400);
    // rust: assert_eq!(LegacyRandom::new(0).next_long(), -4_962_768_465_676_381_896);
}

    // rust: fn invalid_bounds_do_not_consume_state<R: RandomSource + Clone>(mut rng: R) {
    // rust: let mut reference = rng.clone();
    // rust: for bound in [0, -1, i32::MIN] {
    // rust: assert_eq!(rng.next_int_bound(bound), Err(InvalidBound));
}
    // rust: rng.consume_count(-1);
    // rust: assert_eq!(rng.next_long(), reference.next_long());
}

invalid_inputs_preserve_both_streams :: proc() {
}
    // rust: invalid_bounds_do_not_consume_state(LegacyRandom::new(0));
    // rust: invalid_bounds_do_not_consume_state(XoroshiroRandom::new(0));
}

zero_state_fallback_and_reseed :: proc() {
}
    // rust: let mut a = XoroshiroRandom::from_state(0, 0);
    // rust: let mut b = XoroshiroRandom::from_state(
    // rust: XoroshiroRandom::GOLDEN_RATIO,
    // rust: XoroshiroRandom::SILVER_RATIO,
    // rust: );
    // rust: for _ in 0..100 {
    // rust: assert_eq!(a.next_long(), b.next_long());
}
    // rust: a.set_seed(-1);
    // rust: assert_eq!(a.next_long(), XoroshiroRandom::new(-1).next_long());
}
}
