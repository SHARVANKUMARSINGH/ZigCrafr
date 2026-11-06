//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_section_mask
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Sets of section indexes in a chunk column, a bit per section.
//!
//! Vanilla's tallest level has 254 sections (`DimensionType.Y_SIZE / 16`), and
//! light data adds a section below and above it: 256 bits hold every layout a
//! dimension type allows.

/// Section indexes of one column, 0 being the lowest.
pub const SectionMask = struct {};

    // rust: impl SectionMask {
pub const CAPACITY: usize = 256;
pub const EMPTY: Self = Self([0; 4]);
pub const ALL: Self = Self([u64::MAX; 4]);

    /// The indexes `0..n`.
    // rust: pub const fn below(n: usize) -> Self {
    // rust: let mut words = [0; 4];
    // rust: let mut w = 0;
    // rust: while w < 4 {
    // rust: let bits = n.saturating_sub(w * 64);
    // rust: words[w] = if bits >= 64 {
    // rust: u64::MAX
    // rust: } else {
    // rust: (1 << bits) - 1
}
    // rust: w += 1;
}
    // rust: Self(words)
}
pub fn single(i: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mask = Self::EMPTY;
    // rust: mask.insert(i);
    // rust: mask
}
pub fn contains(self: *Self, i: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: i < Self::CAPACITY && self.0[i >> 6] >> (i & 63) & 1 != 0
}
pub fn insert(self: *Self, i: usize) void {
}
    // rust: self.0[i >> 6] |= 1 << (i & 63);
}
pub fn remove(self: *Self, i: usize) void {
}
    // rust: self.0[i >> 6] &= !(1 << (i & 63));
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 == [0; 4]
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.iter().map(|w| w.count_ones() as usize).sum()
}
    /// The indexes from `i` up.
pub fn from(self: *Self, i: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self & !Self::below(i)
}
    /// The indexes, lowest first.
pub fn iter(self: *Self) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Indexes(self)
}
}

    // rust: impl std::ops::BitOr for SectionMask {
    // rust: type Output = Self;
pub fn bitor(self: *Self, other: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(std::array::from_fn(|w| self.0[w] | other.0[w]))
}
}
    // rust: impl std::ops::BitOrAssign for SectionMask {
pub fn bitor_assign(self: *Self, other: Self) void {
}
    // rust: *self = *self | other;
}
}
    // rust: impl std::ops::BitAnd for SectionMask {
    // rust: type Output = Self;
pub fn bitand(self: *Self, other: Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(std::array::from_fn(|w| self.0[w] & other.0[w]))
}
}
    // rust: impl std::ops::Not for SectionMask {
    // rust: type Output = Self;
pub fn not(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(self.0.map(|w| !w))
}
}
    // rust: impl std::fmt::Debug for SectionMask {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.debug_set().entries(self.iter()).finish()
}
}
    // rust: impl FromIterator<usize> for SectionMask {
    // rust: fn from_iter<I: IntoIterator<Item = usize>>(indexes: I) -> Self {
    // rust: let mut mask = Self::EMPTY;
    // rust: for i in indexes {
    // rust: mask.insert(i);
}
    // rust: mask
}
}

/// `SectionMask::iter`: the set's indexes in ascending order.
pub const Indexes = struct {};
    // rust: impl Iterator for Indexes {
    // rust: type Item = usize;
pub fn next(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let words = &mut (self.0).0;
    // rust: let w = words.iter().position(|&w| w != 0)?;
    // rust: let bit = words[w].trailing_zeros() as usize;
    // rust: words[w] &= words[w] - 1;
    // rust: Some(w * 64 + bit)
}
pub fn size_hint(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = self.0.len();
    // rust: (len, Some(len))
}
}
    // rust: impl ExactSizeIterator for Indexes {}

    // rust: mod tests {
//     use super::*;

pub fn sets_across_words() void {
}
    // rust: let mut mask = SectionMask::EMPTY;
    // rust: for i in [0, 23, 63, 64, 130, 255] {
    // rust: mask.insert(i);
}
    // rust: assert_eq!(mask.iter().collect::<Vec<_>>(), [0, 23, 63, 64, 130, 255]);
    // rust: assert_eq!(mask.len(), 6);
    // rust: assert!(mask.contains(130) && !mask.contains(131) && !mask.contains(300));
    // rust: mask.remove(64);
    // rust: assert_eq!(mask.from(24).iter().collect::<Vec<_>>(), [63, 130, 255]);
    // rust: assert_eq!(mask.from(256), SectionMask::EMPTY);
    // rust: assert_eq!(mask.from(0), mask);
    // rust: assert!(SectionMask::EMPTY.is_empty() && !mask.is_empty());
}

pub fn below_counts_whole_and_partial_words() void {
}
    // rust: for n in [0, 1, 24, 63, 64, 65, 131, 254, 256] {
    // rust: let mask = SectionMask::below(n);
    // rust: assert_eq!(mask.len(), n);
    // rust: assert_eq!(mask.iter().collect::<Vec<_>>(), (0..n).collect::<Vec<_>>());
}
    // rust: assert_eq!(SectionMask::below(1000), SectionMask::ALL);
}

pub fn operators() void {
}
    // rust: let a: SectionMask = [1, 70, 200].into_iter().collect();
    // rust: let b: SectionMask = [70, 3].into_iter().collect();
    // rust: assert_eq!((a | b).iter().collect::<Vec<_>>(), [1, 3, 70, 200]);
    // rust: assert_eq!((a & b).iter().collect::<Vec<_>>(), [70]);
    // rust: assert_eq!(
    // rust: (!a & SectionMask::below(4)).iter().collect::<Vec<_>>(),
    // rust: [0, 2, 3]
    // rust: );
    // rust: assert_eq!(format!("{a:?}"), "{1, 70, 200}");
}
}
