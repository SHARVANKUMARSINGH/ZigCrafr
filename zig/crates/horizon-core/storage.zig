//! Transpiled from Horizon Rust crate
//! Module: horizon-core_storage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Palette indices packed into padded 64-bit words, not a continuous bitstream.

/// `n / per_word` for `n < MAGIC_LEN` by multiplication: `MAGIC[bits].0 =
/// ceil(2^20 / (64 / bits))` is exact while `n * (64 / bits) < 2^20`. `.1` is
/// the bits a word's entries fill (`64 / bits * bits`): looked up, not divided
/// for, as a division by a run-time value costs tens of cycles on x86.
    // rust: pub(crate) const MAGIC: [(u32, u32); 33] = {
    // rust: let mut table = [(0, 0); 33];
    // rust: let mut bits = 1;
    // rust: while bits <= 32 {
    // rust: let per = 64 / bits as u32;
    // rust: table[bits] = ((1u32 << 20).div_ceil(per), per * bits as u32);
    // rust: bits += 1;
}
    // rust: table
}
/// Entries `locate` handles exactly for every width: the smallest width (1 bit,
/// 64 per word) gives the bound `2^20 / 64`.
    // rust: pub(crate) const MAGIC_LEN: usize = 1 << 14;
/// The multiply-shift replaces a ~20-26 cycle x86 divide, but arm64's divider
/// is as cheap as the table lookup: measured on an Apple M-series CPU, 65k
/// reads took 1.5 ms with the division and 2.5 ms with the table (bits 4-16),
/// so only the x86 targets take the table.
pub const MAGIC_BEATS_DIVISION: bool = cfg!(any(target_arch = "x86", target_arch = "x86_64"));
/// The word and bit shift of entry `i`; exact for `i < MAGIC_LEN`.
    // rust: pub(crate) fn locate(bits: u8, i: usize) -> (usize, u32) {
    // rust: if bits.is_power_of_two() {
        // 64 / bits is a power of two: shifts instead of the multiplication.
    // rust: let log = bits.trailing_zeros();
    // rust: let word = i >> (6 - log);
    // rust: (word, ((i & ((64 >> log) - 1)) as u32) << log)
    // rust: } else {
    // rust: let (magic, filled) = MAGIC[usize::from(bits)];
    // rust: let word = (i as u32 * magic) >> 20;
    // rust: (word as usize, i as u32 * u32::from(bits) - word * filled)
}
}
    // rust: pub(crate) fn mask(bits: u8) -> u64 {
    // rust: (1u64 << bits) - 1
}

pub const StorageError = enum {
    InvalidBits(u8),
    InvalidLength { expected: usize, actual: usize },
    OutOfBounds { index: usize, len: usize },
    ValueTooLarge(u32),
};

    // rust: impl std::fmt::Display for StorageError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(f, "{self:?}")
}
}

    // rust: impl std::error::Error for StorageError {}

pub const PackedStorage = struct {
    bits: u8,
    len: usize,
    per_word: usize,
    mask: u64,
    /// Whether `len` is past what [`locate`] handles exactly; such a storage
    /// falls back to division.
    wide: bool,
    words: std.ArrayList(u64),
};

    // rust: impl PackedStorage {
    /// The heap bytes of the packed words (`horizon-ctl memory`).
pub fn heap_bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.words.capacity() * std::mem::size_of::<u64>()
}
pub fn new(bits: u8, len: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let per_word = Self::per_word(bits)?;
    // rust: Self::from_words(bits, len, vec![0; len.div_ceil(per_word)])
}

    /// Retains padding and unused tail bits from input, as the Java long[] does.
pub fn from_words(bits: u8, len: usize, words: std.ArrayList(u64)) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let per_word = Self::per_word(bits)?;
    // rust: let expected = len.div_ceil(per_word);
    // rust: if words.len() != expected {
    // rust: return Err(StorageError::InvalidLength {
    // rust: expected,
    // rust: actual: words.len(),
    // rust: });
}
    // rust: Ok(Self {
    // rust: bits,
    // rust: len,
    // rust: per_word,
    // rust: mask: (1_u64 << bits) - 1,
    // rust: wide: len > MAGIC_LEN,
    // rust: words,
    // rust: })
}

pub fn per_word(bits: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !(1..=32).contains(&bits) {
    // rust: return Err(StorageError::InvalidBits(bits));
}
    // rust: Ok(64 / usize::from(bits))
}

pub fn bits(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bits
}
pub fn len(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.len
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.len == 0
}
pub fn words(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.words
}

    /// The word and bit shift of an in-range index.
pub fn slot(self: *Self, index: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.wide || !MAGIC_BEATS_DIVISION {
    // rust: (
    // rust: index / self.per_word,
    // rust: ((index % self.per_word) * usize::from(self.bits)) as u32,
    // rust: )
    // rust: } else {
    // rust: locate(self.bits, index)
}
}

pub fn location(self: *Self, index: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if index >= self.len {
    // rust: return Err(StorageError::OutOfBounds {
    // rust: index,
    // rust: len: self.len,
    // rust: });
}
    // rust: Ok(self.slot(index))
}

pub fn get(self: *Self, index: usize) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (word, shift) = self.location(index)?;
    // rust: Ok(((self.words[word] >> shift) & self.mask) as u32)
}

    /// Reads `index` without a bounds check. Callers use this once they hold a
    /// slice length or a section index they have already validated.
    /// `index` must be less than `len`.
pub fn read(self: *Self, index: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: debug_assert!(index < self.len);
    // rust: let (word, shift) = self.slot(index);
    // rust: ((self.words[word] >> shift) & self.mask) as u32
}

    /// Writes `value` at `index` without revalidating either. `index` must be
    /// less than `len` and `value` must fit `bits`, which holds for a section
    /// palette index from the same container. Returns the previous value.
pub fn write(self: *Self, index: usize, value: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: debug_assert!(index < self.len && u64::from(value) <= self.mask);
    // rust: let (word, shift) = self.slot(index);
    // rust: let old = ((self.words[word] >> shift) & self.mask) as u32;
    // rust: self.words[word] = (self.words[word] & !(self.mask << shift)) | (u64::from(value) << shift);
    // rust: old
}

    /// Validation fails before mutation. Writes accept nonnegative Java ints;
    /// imported 32-bit words may still decode to any u32 bit pattern.
pub fn set(self: *Self, index: usize, value: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (word, shift) = self.location(index)?;
    // rust: if u64::from(value) > self.mask || value > i32::MAX as u32 {
    // rust: return Err(StorageError::ValueTooLarge(value));
}
    // rust: let old = ((self.words[word] >> shift) & self.mask) as u32;
    // rust: self.words[word] = (self.words[word] & !(self.mask << shift)) | (u64::from(value) << shift);
    // rust: Ok(old)
}

    /// Vanilla's doubling fill also writes padding and unused tail slots.
pub fn fill(self: *Self, value: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if u64::from(value) > self.mask || value > i32::MAX as u32 {
    // rust: return Err(StorageError::ValueTooLarge(value));
}
    // rust: let mut word = u64::from(value);
    // rust: let mut shift = u32::from(self.bits);
    // rust: while shift < 64 {
    // rust: word |= word << shift;
    // rust: shift *= 2;
}
    // rust: self.words.fill(word);
    // rust: Ok(())
}

    /// [`unpack`](Self::unpack) into `out` (the first `len` slots), without allocating.
pub fn unpack_into(self: *Self, out: *mut [u32]) void {
}
    // rust: let mut i = 0;
    // rust: for &word in &self.words {
    // rust: for slot in 0..self.per_word.min(self.len - i) {
    // rust: out[i] = ((word >> (slot * usize::from(self.bits))) & self.mask) as u32;
    // rust: i += 1;
}
}
}
pub fn unpack(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut values = Vec::with_capacity(self.len);
    // rust: for &word in &self.words {
    // rust: for slot in 0..self.per_word.min(self.len - values.len()) {
    // rust: values.push(((word >> (slot * usize::from(self.bits))) & self.mask) as u32);
}
}
    // rust: values
}
}

    // rust: mod tests {
//     use super::*;

pub fn padded_words_never_split_entries() void {
}
    // rust: let mut storage = PackedStorage::new(5, 13).unwrap();
    // rust: assert_eq!(storage.words().len(), 2);
    // rust: storage.set(11, 31).unwrap();
    // rust: storage.set(12, 7).unwrap();
    // rust: assert_eq!(storage.words(), &[31 << 55, 7]);
}

pub fn all_widths_survive_overwrites_and_unpack() void {
}
    // rust: for bits in 1..=32 {
    // rust: let mut storage = PackedStorage::new(bits, 4096).unwrap();
    // rust: let mut expected = vec![0; 4096];
    // rust: for pass in 0..3 {
    // rust: for (i, item) in expected.iter_mut().enumerate() {
    // rust: let value = ((i as u64 * 7 + pass) & storage.mask) as u32;
    // rust: assert_eq!(storage.set(i, value).unwrap(), *item);
    // rust: *item = value;
}
    // rust: assert_eq!(storage.unpack(), expected);
}
}
}

    /// The shared multiply-shift index equals division for every width at the
    /// sizes that use `PackedStorage`: 4,096-cell sections and 256-cell
    /// heightmaps. A storage past the exact bound keeps the division path.
pub fn multiply_shift_matches_division_at_section_and_heightmap_sizes() void {
}
    // rust: for bits in 1..=32u8 {
    // rust: for len in [256usize, 4096] {
    // rust: let per = 64 / usize::from(bits);
    // rust: let mut storage = PackedStorage::new(bits, len).unwrap();
    // rust: assert!(!storage.wide);
    // rust: let mask = storage.mask;
    // rust: for i in 0..len {
    // rust: assert_eq!(
    // rust: storage.slot(i),
    // rust: (i / per, ((i % per) * usize::from(bits)) as u32),
    // rust: "bits {bits} len {len} index {i}"
    // rust: );
    // rust: let value = (i as u64 & mask) as u32;
    // rust: assert_eq!(storage.write(i, value), 0);
    // rust: assert_eq!(storage.read(i), value);
    // rust: assert_eq!(storage.get(i).unwrap(), value);
}
}
}
    // rust: let mut wide = PackedStorage::new(1, MAGIC_LEN + 1).unwrap();
    // rust: assert!(wide.wide);
    // rust: wide.write(MAGIC_LEN, 1);
    // rust: assert_eq!(wide.read(MAGIC_LEN), 1);
    // rust: assert_eq!(wide.get(MAGIC_LEN).unwrap(), 1);
}

pub fn imported_padding_is_preserved_and_invalid_writes_are_atomic() void {
}
    // rust: let mut storage = PackedStorage::from_words(5, 1, vec![u64::MAX]).unwrap();
    // rust: assert_eq!(storage.set(0, 0).unwrap(), 31);
    // rust: assert_eq!(storage.words(), &[u64::MAX << 5]);
    // rust: let unchanged = storage.clone();
    // rust: assert!(storage.set(1, 0).is_err());
    // rust: assert!(storage.set(0, 32).is_err());
    // rust: assert_eq!(storage, unchanged);
    // rust: assert!(PackedStorage::new(0, 1).is_err());
    // rust: assert!(PackedStorage::new(33, 1).is_err());
    // rust: assert!(PackedStorage::from_words(5, 13, vec![0]).is_err());
    // rust: assert!(PackedStorage::new(1, 0).unwrap().unpack().is_empty());
}
}
