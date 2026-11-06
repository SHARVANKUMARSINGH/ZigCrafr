//! Transpiled from Horizon Rust crate
package horizon_core_carving

import "core:fmt"
import "core:mem"
import "core:math"

// Packed carving masks and vanilla's ordered inclusive column segments.
    // rust: mod ellipsoid;
    // rust: pub use ellipsoid::{
    // rust: CarveError, CarverOutput, can_reach, carve_ellipsoid, carve_ellipsoid_with_budget,
}

// A contiguous carved interval in a local chunk column.
CarvingColumn :: struct {
    x: i32,
    z: i32,
    min_y: i32,
    max_y: i32,
}

CarvingMaskError :: enum {
    InvalidBounds,
    NegativeIndex,
    Capacity,
}
    // rust: impl std::fmt::Display for CarvingMaskError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(match self {
    // rust: Self::InvalidBounds => "carving mask height must be between 1 and 4064",
    // rust: Self::NegativeIndex => "carving mask index is negative",
    // rust: Self::Capacity => "carving mask exceeds its bounded bit capacity",
    // rust: })
}
}
    // rust: impl std::error::Error for CarvingMaskError {}

// Bits are contiguous in Y, then Z, then X. Coordinates retain Java's wrapping
// index arithmetic and positive out-of-range aliases. Growth is capped at
// 2^24 bits; valid chunk coordinates use at most 256 * 4064 bits.
CarvingMask :: struct {
    min_y: i32,
    max_y: i32,
    height: i32,
    words: [dynamic]u64,
    used_words: uint,
}
    // rust: impl CarvingMask {
new :: proc(min_y: i32, max_y: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let height = i64::from(max_y) - i64::from(min_y) + 1;
    // rust: if !(1..=4064).contains(&height) {
    // rust: return Err(CarvingMaskError::InvalidBounds);
}
    // rust: Ok(Self {
    // rust: min_y,
    // rust: max_y,
    // rust: height: height as i32,
    // rust: words: vec![0; (height as usize * 256).div_ceil(64)],
    // rust: used_words: 0,
    // rust: })
}
min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.min_y
}
max_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.max_y
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.used_words == 0
}
carve :: proc(self: ^Self, x: i32, y: i32, z: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let index = y
    // rust: .wrapping_sub(self.min_y)
    // rust: .wrapping_add(z.wrapping_add(x.wrapping_shl(4)).wrapping_mul(self.height));
    // rust: if index < 0 {
    // rust: return Err(CarvingMaskError::NegativeIndex);
}
    // rust: if index >= 1 << 24 {
    // rust: return Err(CarvingMaskError::Capacity);
}
    // rust: let index = index as usize;
    // rust: let word = index / 64;
    // rust: if word >= self.words.len() {
    // rust: self.words.resize(word + 1, 0);
}
    // rust: self.words[word] |= 1 << (index & 63);
    // rust: self.used_words = self.used_words.max(word + 1);
    // rust: Ok(())
}
    // Traverse ascending packed runs, splitting each run at column boundaries.
    // No per-cell or per-column allocation is required.
columns :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut cursor = Cursor::default();
    // rust: std::iter::from_fn(move || cursor.next(self))
}
    // Like vanilla's callback traversal, changes made by the visitor affect the
    // next run search, but do not change the already selected run's boundaries.
    // An error stops traversal immediately and retains visitor mutations.
    // rust: pub fn try_visit_mut<E>(
    // rust: &mut self,
    // rust: mut visitor: impl FnMut(&mut Self, CarvingColumn) -> Result<(), E>,
    // rust: ) -> Result<(), E> {
    // rust: let mut cursor = Cursor::default();
    // rust: while let Some(column) = cursor.next(self) {
    // rust: visitor(self, column)?;
}
    // rust: Ok(())
}
next_set :: proc(self: ^Self, from: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut word = from / 64;
    // rust: if word >= self.used_words {
    // rust: return None;
}
    // rust: let mut bits = self.words[word] & (u64::MAX << (from & 63));
    // rust: loop {
    // rust: if bits != 0 {
    // rust: return Some(word * 64 + bits.trailing_zeros() as usize);
}
    // rust: word += 1;
    // rust: if word == self.used_words {
    // rust: return None;
}
    // rust: bits = self.words[word];
}
}
next_clear :: proc(self: ^Self, from: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut word = from / 64;
    // rust: let mut bits = !self.words[word] & (u64::MAX << (from & 63));
    // rust: loop {
    // rust: if bits != 0 {
    // rust: return word * 64 + bits.trailing_zeros() as usize;
}
    // rust: word += 1;
    // rust: if word == self.used_words {
    // rust: return word * 64;
}
    // rust: bits = !self.words[word];
}
}
}

Cursor :: struct {
    search: uint,
    run: Option<(uint,
}
    // rust: impl Cursor {
next :: proc(self: ^Self, mask: ^CarvingMask) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let height = mask.height as usize;
    // rust: let (start, end, column) = match self.run {
    // rust: Some(run) => run,
    // rust: None => {
    // rust: let start = mask.next_set(self.search)?;
    // rust: let end = mask.next_clear(start) - 1;
    // rust: self.search = end + 1;
    // rust: (start, end, start / height)
}
}
    // rust: self.run = (column < end / height).then_some((start, end, column + 1));
    // rust: let base = column * height;
    // rust: Some(CarvingColumn {
    // rust: x: ((column >> 4) & 15) as i32,
    // rust: z: (column & 15) as i32,
    // rust: min_y: mask.min_y.wrapping_add(start.saturating_sub(base) as i32),
    // rust: max_y: mask.min_y.wrapping_add((end - base).min(height - 1) as i32),
    // rust: })
}
}
