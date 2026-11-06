//! Transpiled from Horizon Rust crate
package horizon_core_paletted

import "core:fmt"
import "core:mem"
import "core:math"

// Resident `PalettedContainer` of Java Edition 26.3: single-value, linear and
// hash-map palettes with vanilla's bit-width thresholds, and the global
// palette beyond them, over `SimpleBitStorage` words (values never span
// longs). One container type serves blocks (16^3 entries) and biomes (4^3).
//
// Growth follows `PalettedContainer.onResize`: a full palette asks for one
// more bit, the new configuration is built by re-adding the distinct values
// in index order, and the value that did not fit is added last. Palettes
// never shrink while resident; `pack` writes the canonical saved form.

// use crate::storage::{locate, mask};

Kind :: enum {
    // `Strategy.createForBlockStates`: 4096 entries, linear palettes up to 4
    // bits and hash-map palettes from 5 to 8.
    Blocks,
    // `Strategy.createForBiomes`: 64 entries, linear palettes up to 3 bits.
    Biomes,
}
Strategy :: struct {
    kind: Kind,
    // `ceillog2` of the registry size: the width of the global palette.
    global_bits: u8,
}
// `getConfigurationForBitCount`.
Config :: enum {
    Single,
    // Palette of up to `1 << bits` entries, stored in `bits` bits.
    List(u8),
    Global,
}
    // rust: impl Strategy {
    // rust: pub const fn blocks(global_bits: u8) -> Self {
    // rust: Self {
    // rust: kind: Kind::Blocks,
    // rust: global_bits,
}
}
    // rust: pub const fn biomes(global_bits: u8) -> Self {
    // rust: Self {
    // rust: kind: Kind::Biomes,
    // rust: global_bits,
}
}
    // rust: pub const fn entries(self) -> usize {
    // rust: match self.kind {
    // rust: Kind::Blocks => 4096,
    // rust: Kind::Biomes => 64,
}
}
config :: proc(self: ^Self, bits: u8) -> C {
    // Ported from Horizon
    return {}
}
    // rust: match (self.kind, bits) {
    // rust: (_, 0) => Config::Single,
    // rust: (Kind::Blocks, 1..=4) => Config::List(4),
    // rust: (Kind::Blocks, 5..=8) => Config::List(bits),
    // rust: (Kind::Biomes, 1..=3) => Config::List(bits),
    // rust: _ => Config::Global,
}
}
    // Whether a container written with leading byte `bits` lists its palette
    // (all but the global one).
wire_has_palette :: proc(self: ^Self, bits: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.config(bits) != Config::Global
}
    // Bits of the storage a configuration keeps in memory.
storage_bits :: proc(self: ^Self, config: Config) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match config {
    // rust: Config::Single => 0,
    // rust: Config::List(bits) => bits,
    // rust: Config::Global => self.global_bits,
}
}
}
// `Mth.ceillog2`.
ceil_log2 :: proc(n: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if n <= 1 {
    // rust: 0
    // rust: } else {
    // rust: (usize::BITS - (n - 1).leading_zeros()) as u8
}
}

PaletteError :: enum {
    // A palette bigger than its configuration allows, or empty.
    BadPalette { len: usize },
    // Storage with the wrong number of longs.
    BadStorage { expected: usize, actual: usize },
    // A stored index past the palette.
    BadIndex { index: u32, palette: usize },
    // The declared bit count does not match the palette.
    BadBits { declared: u8, expected: u8 },
}
    // rust: impl std::fmt::Display for PaletteError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: write!(f, "{self:?}")
}
}
    // rust: impl std::error::Error for PaletteError {}

Palette :: enum {
    Single(u32),
    // Linear and hash-map palettes alike: ids in insertion order.
    List(Vec<u32>),
    Global,
}
// Words of `bits`-wide values: `entries.div_ceil(64 / bits)`.
storage_len :: proc(bits: u8, entries: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if bits == 0 {
    // rust: 0
    // rust: } else {
    // rust: entries.div_ceil(64 / usize::from(bits))
}
}
read :: proc(words: ^[u64], bits: u8, i: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let (word, shift) = locate(bits, i);
    // rust: ((words[word] >> shift) & mask(bits)) as u32
}
write :: proc(words: ^[u64], bits: u8, i: uint, value: u32) {
}
    // rust: let (word, shift) = locate(bits, i);
    // rust: words[word] = (words[word] & !(mask(bits) << shift)) | (u64::from(value) << shift);
}
// Values below this are looked up in a table indexed by value once a
// palette outgrows the scan: every block state and biome id of 26.3.
DENSE_VALUES :: 1 << 16
    // rust: thread_local! {
    // `palette_ids`' table: 1 + the id of each value seen, 0 for the others.
    // Only the entries of the palette being built are set, and they are
    // cleared again before it returns.
DENSE_IDS :: const { std::cell::RefCell::new(Vec::new()) }
}
// The distinct `values` in first-occurrence order and each value's index in
// them. A run of one value (most of a section) is matched once, a scan finds
// up to 16 distinct values faster than any lookup, and past that a table
// indexed by value finds them without hashing.
palette_ids :: proc(values: ^[u32]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut palette: Vec<u32> = Vec::new();
    // rust: let mut ids = Vec::with_capacity(values.len());
    // rust: let mut last: Option<(u32, u32)> = None;
    // rust: let mut rest = values;
    // rust: while let Some((&value, tail)) = rest.split_first() {
    // rust: let id = match last {
    // rust: Some((v, id)) if v == value => id,
    // rust: _ if palette.len() > 16 => break,
    // rust: _ => match palette.iter().position(|&v| v == value) {
    // rust: Some(id) => id as u32,
    // rust: None => {
    // rust: palette.push(value);
    // rust: palette.len() as u32 - 1
}
    // rust: },
}
    // rust: last = Some((value, id));
    // rust: ids.push(id);
    // rust: rest = tail;
}
    // rust: if rest.is_empty() {
    // rust: return (palette, ids);
}
    // rust: if palette.iter().chain(rest).all(|&v| v < DENSE_VALUES) {
    // rust: DENSE_IDS.with(|table| {
    // rust: let mut table = table.borrow_mut();
    // rust: for (id, &v) in palette.iter().enumerate() {
    // rust: let v = v as usize;
    // rust: if table.len() <= v {
    // rust: table.resize(v + 1, 0);
}
    // rust: table[v] = id as u32 + 1;
}
    // rust: for &value in rest {
    // rust: let v = value as usize;
    // rust: if table.len() <= v {
    // rust: table.resize(v + 1, 0);
}
    // rust: let id = match table[v] {
    // rust: 0 => {
    // rust: palette.push(value);
    // rust: table[v] = palette.len() as u32;
    // rust: palette.len() as u32 - 1
}
    // rust: slot => slot - 1,
}
    // rust: ids.push(id);
}
    // rust: for &v in &palette {
    // rust: table[v as usize] = 0;
}
    // rust: });
    // rust: } else {
    // rust: let mut lookup: std::collections::HashMap<u32, u32> = palette
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, &v)| (v, i as u32))
    // rust: .collect();
    // rust: for &value in rest {
    // rust: let id = *lookup.entry(value).or_insert_with(|| {
    // rust: palette.push(value);
    // rust: palette.len() as u32 - 1
    // rust: });
    // rust: ids.push(id);
}
}
    // rust: (palette, ids)
}
// Words holding `ids` in `bits`-wide slots.
pack_words :: proc(bits: u8, entries: uint, ids: impl Iterator<Item = u32>) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut words = vec![0u64; storage_len(bits, entries)];
    // rust: for (i, id) in ids.enumerate() {
    // rust: write(&mut words, bits, i, id);
}
    // rust: words
}
// The saved form: distinct values in index order, and the packed indices
// when there is more than one value.
Packed :: struct {
    palette: [dynamic]u32,
    // Bits per index in `data` (0 when `data` is absent).
    bits: u8,
    data: Maybe([dynamic]u64),
}

PalettedContainer :: struct {
    strategy: Strategy,
    bits: u8,
    palette: Palette,
    words: [dynamic]u64,
}
    // rust: impl PalettedContainer {
    // `new PalettedContainer(initialValue, strategy)`.
new :: proc(strategy: Strategy, value: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: strategy,
    // rust: bits: 0,
    // rust: palette: Palette::Single(value),
    // rust: words: Vec::new(),
}
}
strategy :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.strategy
}
    // Bits per stored index (`BitStorage.getBits`).
bits :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.bits
}
    // Entries in the palette (the global palette reports its bit capacity).
palette_len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match &self.palette {
    // rust: Palette::Single(_) => 1,
    // rust: Palette::List(list) => list.len(),
    // rust: Palette::Global => 1 << self.bits.min(31),
}
}
is_global :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.palette, Palette::Global)
}
raw :: proc(self: ^Self, i: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let (word, shift) = locate(self.bits, i);
    // rust: ((self.words[word] >> shift) & mask(self.bits)) as usize
}
get :: proc(self: ^Self, i: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match &self.palette {
    // rust: Palette::Single(value) => *value,
    // rust: Palette::List(list) => list[self.raw(i)],
    // rust: Palette::Global => self.raw(i) as u32,
}
}
    // `get` of the entries `start..start + out.len()`, the palette matched once.
get_run :: proc(self: ^Self, start: uint, out: ^[u32]) {
}
    // rust: match &self.palette {
    // rust: Palette::Single(value) => out.fill(*value),
    // rust: Palette::List(list) => {
    // rust: for (k, cell) in out.iter_mut().enumerate() {
    // rust: *cell = list[self.raw(start + k)];
}
}
    // rust: Palette::Global => {
    // rust: for (k, cell) in out.iter_mut().enumerate() {
    // rust: *cell = self.raw(start + k) as u32;
}
}
}
}
    // The value when every entry is equal, without the palette having to be
    // minimal.
uniform :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match &self.palette {
    // rust: Palette::Single(value) => Some(*value),
    // rust: Palette::List(list) if list.len() == 1 => Some(list[0]),
    // rust: Palette::Global => self.all_equal(self.get(0)).then(|| self.get(0)),
    // rust: Palette::List(list) => {
    // rust: let first = list[self.raw(0)];
    // rust: self.all_equal(first).then_some(first)
}
}
}
    // Whether `other` is stored the same way (bits, palette and words): then
    // it holds the same values, found without unpacking either. (Containers
    // stored differently can still hold the same values.)
same_storage :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.bits == other.bits && self.palette == other.palette && self.words == other.words
}
    // Whether all entries equal `value`.
is_uniform :: proc(self: ^Self, value: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match &self.palette {
    // rust: Palette::Single(v) => *v == value,
    // rust: Palette::List(list) => match list.iter().position(|&v| v == value) {
    // rust: None => false,
    // rust: Some(_) if list.len() == 1 => true,
    // rust: Some(_) => self.all_equal(value),
    // rust: },
    // rust: Palette::Global => self.all_equal(value),
}
}
all_equal :: proc(self: ^Self, value: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let id = match &self.palette {
    // rust: Palette::Single(v) => return *v == value,
    // rust: Palette::List(list) => match list.iter().position(|&v| v == value) {
    // rust: Some(id) => id as u64,
    // rust: None => return false,
    // rust: },
    // rust: Palette::Global => u64::from(value),
}
    // rust: let bits = usize::from(self.bits);
    // rust: let per = 64 / bits;
    // rust: let pattern = (0..per).fold(0u64, |word, slot| word | id << (slot * bits));
    // rust: let entries = self.strategy.entries();
    // rust: let full = entries / per;
    // rust: if self.words[..full].iter().any(|&w| w != pattern) {
    // rust: return false;
}
    // rust: let tail = entries - full * per;
    // rust: tail == 0 || {
    // rust: let used = (1u64 << (tail * bits)) - 1;
    // rust: self.words[full] & used == pattern & used
}
}
    // `getAndSet`: stores `value` and returns the previous one.
set :: proc(self: ^Self, i: uint, value: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let id = self.id_for(value);
    // rust: match &self.palette {
    // rust: Palette::Single(old) => *old,
    // rust: Palette::List(list) => {
    // rust: let old = read(&self.words, self.bits, i) as usize;
    // rust: write(&mut self.words, self.bits, i, id as u32);
    // rust: list[old]
}
    // rust: Palette::Global => {
    // rust: let old = read(&self.words, self.bits, i);
    // rust: write(&mut self.words, self.bits, i, id as u32);
    // rust: old
}
}
}
    // `Palette.idFor`, growing the container when the palette is full.
id_for :: proc(self: ^Self, value: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match &mut self.palette {
    // rust: Palette::Single(v) if *v == value => 0,
    // rust: Palette::Single(_) => self.resize(1, value),
    // rust: Palette::List(list) => {
    // rust: if let Some(id) = list.iter().position(|&v| v == value) {
    // rust: id
    // rust: } else if list.len() < 1 << self.bits {
    // rust: list.push(value);
    // rust: list.len() - 1
    // rust: } else {
    // rust: self.resize(self.bits + 1, value)
}
}
    // rust: Palette::Global => value as usize,
}
}
    // `PalettedContainer.onResize`: rebuild with the configuration for
    // `bits`, then add `last` and return its id.
resize :: proc(self: ^Self, bits: u8, last: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let strategy = self.strategy;
    // rust: let config = strategy.config(bits);
    // rust: let storage_bits = strategy.storage_bits(config);
    // rust: let entries = strategy.entries();
    // rust: let mut palette = match config {
    // rust: Config::Single => Palette::Single(last),
    // rust: Config::List(_) => Palette::List(Vec::new()),
    // rust: Config::Global => Palette::Global,
}
    // rust: let mut words = vec![0u64; storage_len(storage_bits, entries)];
    // rust: let id_in = |palette: &mut Palette, value: u32| -> u32 {
    // rust: match palette {
    // rust: Palette::Single(_) => 0,
    // rust: Palette::List(list) => match list.iter().position(|&v| v == value) {
    // rust: Some(id) => id as u32,
    // rust: None => {
    // rust: list.push(value);
    // rust: list.len() as u32 - 1
}
    // rust: },
    // rust: Palette::Global => value,
}
}
    // rust: if let Palette::Single(only) = self.palette {
    // rust: let id = id_in(&mut palette, only);
    // rust: if storage_bits > 0 && id != 0 {
    // rust: for i in 0..entries {
    // rust: write(&mut words, storage_bits, i, id);
}
}
    // rust: } else {
    // rust: let (mut last_old, mut new_id) = (u32::MAX, 0);
    // rust: for i in 0..entries {
    // rust: let old = read(&self.words, self.bits, i);
    // rust: if old != last_old {
    // rust: last_old = old;
    // rust: let value = match &self.palette {
    // rust: Palette::List(list) => list[old as usize],
    // rust: _ => old,
}
    // rust: new_id = id_in(&mut palette, value);
}
    // rust: if storage_bits > 0 {
    // rust: write(&mut words, storage_bits, i, new_id);
}
}
}
    // rust: let id = id_in(&mut palette, last);
    // rust: self.palette = palette;
    // rust: self.bits = storage_bits;
    // rust: self.words = words;
    // rust: id as usize
}
    // All values in index order.
unpack :: proc(self: ^Self, out: ^[u32]) {
}
    // rust: assert_eq!(out.len(), self.strategy.entries());
    // rust: match &self.palette {
    // rust: Palette::Single(value) => out.fill(*value),
    // rust: Palette::List(list) => {
    // rust: let bits = usize::from(self.bits);
    // rust: let per = 64 / bits;
    // rust: let m = mask(self.bits);
    // rust: for (chunk, &word) in out.chunks_mut(per).zip(&self.words) {
    // rust: for (slot, cell) in chunk.iter_mut().enumerate() {
    // rust: let id = ((word >> (slot * bits)) & m) as usize;
    // rust: *cell = list[id];
}
}
}
    // rust: Palette::Global => {
    // rust: let bits = usize::from(self.bits);
    // rust: let per = 64 / bits;
    // rust: let m = mask(self.bits);
    // rust: for (chunk, &word) in out.chunks_mut(per).zip(&self.words) {
    // rust: for (slot, cell) in chunk.iter_mut().enumerate() {
    // rust: *cell = ((word >> (slot * bits)) & m) as u32;
}
}
}
}
}
    // The palette id of every entry in index order, and the list palette
    // they index (`get(i)` is `list[ids[i]]`), without looking the values
    // up; `None` (and `ids` untouched) for a single-value or global palette.
unpack_ids :: proc(self: ^Self, ids: ^[u16]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Palette::List(list) = &self.palette else {
    // rust: return None;
}
    // rust: assert_eq!(ids.len(), self.strategy.entries());
    // rust: let bits = usize::from(self.bits);
    // rust: let per = 64 / bits;
    // rust: let m = mask(self.bits);
    // rust: for (chunk, &word) in ids.chunks_mut(per).zip(&self.words) {
    // rust: for (slot, cell) in chunk.iter_mut().enumerate() {
                // List palettes stay at a few bits (eight at most for blocks).
    // rust: *cell = ((word >> (slot * bits)) & m) as u16;
}
}
    // rust: Some(list)
}
    // A container holding `values` in the smallest configuration for their
    // distinct count, with palette ids in first-occurrence order, like a
    // container unpacked from disk.
from_values :: proc(strategy: Strategy, values: ^[u32]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: assert_eq!(values.len(), strategy.entries());
    // rust: let (palette, ids) = palette_ids(values);
    // rust: Self::build(strategy, palette, &ids)
}
    // A container over a distinct-value `palette` and an id per entry.
build :: proc(strategy: Strategy, palette: [dynamic]u32, ids: ^[u32]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let config = strategy.config(ceil_log2(palette.len()));
    // rust: match config {
    // rust: Config::Single => Self::new(strategy, palette[0]),
    // rust: Config::List(bits) => Self {
    // rust: strategy,
    // rust: bits,
    // rust: words: pack_words(bits, ids.len(), ids.iter().copied()),
    // rust: palette: Palette::List(palette),
    // rust: },
    // rust: Config::Global => {
    // rust: let bits = strategy.global_bits;
    // rust: Self {
    // rust: strategy,
    // rust: bits,
    // rust: words: pack_words(bits, ids.len(), ids.iter().map(|&id| palette[id as usize])),
    // rust: palette: Palette::Global,
}
}
}
}
    // `PalettedContainer.read`: the container as sent on the wire. `bits` is
    // the leading byte, `palette` the VarInt entries (a single one for
    // `bits == 0`, none for the global palette) and `words` the longs.
    // rust: pub fn from_wire(
    // rust: strategy: Strategy,
    // rust: bits: u8,
    // rust: palette: Vec<u32>,
    // rust: words: Vec<u64>,
    // rust: ) -> Result<Self, PaletteError> {
    // rust: let config = strategy.config(bits);
    // rust: let storage_bits = strategy.storage_bits(config);
    // rust: let expected = storage_len(storage_bits, strategy.entries());
    // rust: if words.len() != expected {
    // rust: return Err(PaletteError::BadStorage {
    // rust: expected,
    // rust: actual: words.len(),
    // rust: });
}
    // rust: match config {
    // rust: Config::Single => {
    // rust: if palette.len() != 1 {
    // rust: return Err(PaletteError::BadPalette { len: palette.len() });
}
    // rust: Ok(Self::new(strategy, palette[0]))
}
    // rust: Config::List(bits) => {
    // rust: if palette.is_empty() || palette.len() > 1 << bits {
    // rust: return Err(PaletteError::BadPalette { len: palette.len() });
}
    // rust: let container = Self {
    // rust: strategy,
    // rust: bits,
    // rust: palette: Palette::List(palette),
    // rust: words,
}
    // rust: container.check_indices()?;
    // rust: Ok(container)
}
    // rust: Config::Global => Ok(Self {
    // rust: strategy,
    // rust: bits: storage_bits,
    // rust: palette: Palette::Global,
    // rust: words,
    // rust: }),
}
}
check_indices :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Palette::List(list) = &self.palette else {
    // rust: return Ok(());
}
    // rust: if list.len() == 1 << self.bits {
    // rust: return Ok(());
}
    // rust: let per = 64 / usize::from(self.bits);
    // rust: let mut remaining = self.strategy.entries();
    // rust: let mask = mask(self.bits);
    // rust: for &word in &self.words {
    // rust: let count = remaining.min(per);
    // rust: for slot in 0..count {
    // rust: let index = ((word >> (slot * usize::from(self.bits))) & mask) as u32;
    // rust: if index as usize >= list.len() {
    // rust: return Err(PaletteError::BadIndex {
    // rust: index,
    // rust: palette: list.len(),
    // rust: });
}
}
    // rust: remaining -= count;
}
    // rust: Ok(())
}
    // `PalettedContainer.write`: the leading bits byte, the palette entries
    // (none for the global palette) and the raw longs, exactly as resident.
to_wire :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let palette = match &self.palette {
    // rust: Palette::Single(value) => vec![*value],
    // rust: Palette::List(list) => list.clone(),
    // rust: Palette::Global => Vec::new(),
}
    // rust: (self.bits, palette, &self.words)
}
    // `PalettedContainer.pack`: distinct values in index order, indices
    // re-encoded for the saved bit width.
pack :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let entries = self.strategy.entries();
    // rust: let mut values = vec![0u32; entries];
    // rust: self.unpack(&mut values);
    // rust: let (palette, ids) = palette_ids(&values);
    // rust: let bits = match self.strategy.config(ceil_log2(palette.len())) {
    // rust: Config::Single => 0,
    // rust: Config::List(bits) => bits,
    // rust: Config::Global => ceil_log2(palette.len()),
}
    // rust: let data = (bits != 0).then(|| pack_words(bits, entries, ids.iter().copied()));
    // rust: Packed {
    // rust: palette,
    // rust: bits,
    // rust: data,
}
}
    // `PalettedContainer.unpack`: a container from the saved form.
    // rust: pub fn from_packed(
    // rust: strategy: Strategy,
    // rust: palette: Vec<u32>,
    // rust: data: Option<&[u64]>,
    // rust: ) -> Result<Self, PaletteError> {
    // rust: if palette.is_empty() {
    // rust: return Err(PaletteError::BadPalette { len: 0 });
}
    // rust: let config = strategy.config(ceil_log2(palette.len()));
    // rust: let entries = strategy.entries();
    // rust: let disc_bits = match config {
    // rust: Config::Single => return Ok(Self::new(strategy, palette[0])),
    // rust: Config::List(bits) => bits,
    // rust: Config::Global => ceil_log2(palette.len()),
}
    // rust: let data = data.ok_or(PaletteError::BadStorage {
    // rust: expected: storage_len(disc_bits, entries),
    // rust: actual: 0,
    // rust: })?;
    // rust: let expected = storage_len(disc_bits, entries);
    // rust: if data.len() != expected {
    // rust: return Err(PaletteError::BadStorage {
    // rust: expected,
    // rust: actual: data.len(),
    // rust: });
}
    // rust: if let Config::List(bits) = config {
            // List palettes already use the saved indices as resident storage.
            // Validate them without allocating an unpacked copy that is unused.
    // rust: let container = Self {
    // rust: strategy,
    // rust: bits,
    // rust: words: data.to_vec(),
    // rust: palette: Palette::List(palette),
}
    // rust: container.check_indices()?;
    // rust: return Ok(container);
}
    // rust: let mut ids = Vec::with_capacity(entries);
    // rust: for i in 0..entries {
    // rust: let index = read(data, disc_bits, i);
    // rust: if index as usize >= palette.len() {
    // rust: return Err(PaletteError::BadIndex {
    // rust: index,
    // rust: palette: palette.len(),
    // rust: });
}
    // rust: ids.push(index);
}
    // rust: Ok(Self::build(strategy, palette, &ids))
}
    // Whether any palette entry satisfies `predicate` (`maybeHas`): entries
    // no longer used by any position still count.
maybe_has :: proc(self: ^Self, mut predicate: impl FnMut(u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match &self.palette {
    // rust: Palette::Single(value) => predicate(*value),
    // rust: Palette::List(list) => list.iter().any(|&v| predicate(v)),
    // rust: Palette::Global => (0..1u32 << self.bits.min(31)).any(predicate),
}
}
    // Whether any entry satisfies `predicate`. Unlike [`Self::maybe_has`],
    // palette entries no entry uses any more don't count.
has :: proc(self: ^Self, mut predicate: impl FnMut(u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let list = match &self.palette {
    // rust: Palette::Single(value) => return predicate(*value),
    // rust: Palette::List(list) => list,
    // rust: Palette::Global => {
    // rust: return (0..self.strategy.entries()).any(|i| predicate(self.raw(i) as u32));
}
}
    // rust: let matching: Vec<bool> = list.iter().map(|&v| predicate(v)).collect();
    // rust: let count = matching.iter().filter(|&&m| m).count();
    // rust: if count == 0 || count == list.len() {
    // rust: return count != 0;
}
    // rust: let (bits, entries) = (usize::from(self.bits), self.strategy.entries());
    // rust: let per = 64 / bits;
        // The words whose fields all hold entries; the last may be partial.
    // rust: let full = entries / per;
    // rust: if count <= 4 {
            // A field-wise zero test of each word XORed with the matching
            // index in every field: `(v - lo) & !v & hi` is non-zero exactly
            // when some field of `v` is zero.
    // rust: let lo = (0..per).fold(0u64, |a, f| a | 1 << (f * bits));
    // rust: let hi = lo << (bits - 1);
    // rust: let words = &self.words[..full];
    // rust: let found = matching
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| **m)
    // rust: .any(|(i, _)| {
    // rust: let pattern = lo * i as u64;
    // rust: words.iter().any(|&w| {
    // rust: let v = w ^ pattern;
    // rust: v.wrapping_sub(lo) & !v & hi != 0
    // rust: })
    // rust: });
    // rust: return found || (full * per..entries).any(|i| matching[self.raw(i)]);
}
    // rust: (0..entries).any(|i| matching[self.raw(i)])
}
    // Heap bytes held by the palette and the storage.
heap_bytes :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.words.capacity() * 8
    // rust: + match &self.palette {
    // rust: Palette::List(list) => list.capacity() * 4,
    // rust: _ => 0,
}
}
}
    // rust: impl PartialEq for PalettedContainer {
    // Equal when every entry is. The same width, palette and words are the
    // same entries, whatever they are: compared without reading each.
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let entries = self.strategy.entries();
    // rust: if entries != other.strategy.entries() {
    // rust: return false;
}
    // rust: let same_palette = match (&self.palette, &other.palette) {
    // rust: (Palette::Single(a), Palette::Single(b)) => a == b,
    // rust: (Palette::List(a), Palette::List(b)) => a == b,
    // rust: (Palette::Global, Palette::Global) => true,
    // rust: _ => false,
}
    // rust: if same_palette && self.bits == other.bits && self.words == other.words {
    // rust: return true;
}
    // rust: (0..entries).all(|i| self.get(i) == other.get(i))
}
}

    // rust: mod tests {
//     use super::*;
BLOCKS :: Strategy::blocks(16)
BIOMES :: Strategy::biomes(7)

locate_matches_division_for_every_width :: proc() {
}
    // rust: for bits in 1..=32u8 {
    // rust: let per = 64 / usize::from(bits);
    // rust: for i in 0..4096 {
    // rust: let expected = (i / per, ((i % per) * usize::from(bits)) as u32);
    // rust: assert_eq!(locate(bits, i), expected, "{bits} bits, entry {i}");
}
}
}
rng :: proc(state: ^u64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: *state ^= *state << 13;
    // rust: *state ^= *state >> 7;
    // rust: *state ^= *state << 17;
    // rust: *state
}
runs_read_the_stored_values :: proc() {
}
    // rust: let mut state = 0x9E37_79B9_7F4A_7C15;
        // One value, a list palette, and the global palette.
    // rust: for distinct in [1u64, 5, 3000] {
    // rust: let values: Vec<u32> = (0..4096)
    // rust: .map(|_| (rng(&mut state) % distinct) as u32)
    // rust: .collect();
    // rust: let container = PalettedContainer::from_values(BLOCKS, &values);
    // rust: for _ in 0..200 {
    // rust: let start = (rng(&mut state) % 4096) as usize;
    // rust: let len = (rng(&mut state) % 20) as usize;
    // rust: let len = len.min(4096 - start);
    // rust: let mut run = vec![u32::MAX; len];
    // rust: container.get_run(start, &mut run);
    // rust: assert_eq!(
    // rust: run,
    // rust: values[start..start + len],
    // rust: "{distinct} values, {start}+{len}"
    // rust: );
}
}
}
containers_stored_alike_are_the_same :: proc() {
}
    // rust: let values: Vec<u32> = (0..4096).map(|i| (i % 7) as u32).collect();
    // rust: let a = PalettedContainer::from_values(BLOCKS, &values);
    // rust: assert!(a.same_storage(&a.clone()));
    // rust: let mut b = a.clone();
    // rust: b.set(100, 3);
    // rust: assert!(!a.same_storage(&b));
        // the same values stored another way are not found alike (the caller unpacks those)
    // rust: let mut c = PalettedContainer::new(BLOCKS, 0);
    // rust: for (i, &v) in values.iter().enumerate() {
    // rust: c.set(i, v);
}
    // rust: assert!(PalettedContainer::new(BLOCKS, 5).same_storage(&PalettedContainer::new(BLOCKS, 5)));
    // rust: assert!(
    // rust: !PalettedContainer::new(BLOCKS, 5).same_storage(&PalettedContainer::new(BLOCKS, 6))
    // rust: );
    // rust: let mut out = vec![0; 4096];
    // rust: c.unpack(&mut out);
    // rust: assert_eq!(out, values);
}
grows_through_vanilla_widths :: proc() {
}
    // rust: let mut c = PalettedContainer::new(BLOCKS, 0);
    // rust: assert_eq!((c.bits(), c.palette_len()), (0, 1));
    // rust: let mut expected = Vec::new();
    // rust: for n in 1..=300u32 {
    // rust: c.set(n as usize, n);
    // rust: expected.push(match n + 1 {
    // rust: 2..=16 => 4,
    // rust: 17..=32 => 5,
    // rust: 33..=64 => 6,
    // rust: 65..=128 => 7,
    // rust: 129..=256 => 8,
    // rust: _ => 16,
    // rust: });
    // rust: assert_eq!(c.bits(), *expected.last().unwrap(), "after {n} values");
}
    // rust: assert!(c.is_global());
    // rust: for n in 1..=300u32 {
    // rust: assert_eq!(c.get(n as usize), n);
}
    // rust: let mut b = PalettedContainer::new(BIOMES, 3);
    // rust: for n in 1..=9u32 {
    // rust: b.set(n as usize, n + 3);
    // rust: let want = match n + 1 {
    // rust: 2 => 1,
    // rust: 3..=4 => 2,
    // rust: 5..=8 => 3,
    // rust: _ => 7,
}
    // rust: assert_eq!(b.bits(), want, "after {n} biomes");
}
}
matches_a_plain_array_under_random_edits :: proc() {
}
    // rust: for (strategy, distinct) in [(BLOCKS, 700u64), (BLOCKS, 12), (BIOMES, 9), (BIOMES, 3)] {
    // rust: let entries = strategy.entries();
    // rust: let mut state = 0x1234_5678_9ABC_DEF1u64;
    // rust: let mut c = PalettedContainer::new(strategy, 5);
    // rust: let mut plain = vec![5u32; entries];
    // rust: for _ in 0..20_000 {
    // rust: let r = rng(&mut state);
    // rust: let i = (r % entries as u64) as usize;
    // rust: let v = ((r >> 20) % distinct) as u32 * 7;
    // rust: assert_eq!(c.set(i, v), plain[i]);
    // rust: plain[i] = v;
}
    // rust: let mut out = vec![0; entries];
    // rust: c.unpack(&mut out);
    // rust: assert_eq!(out, plain);
    // rust: for (i, &v) in plain.iter().enumerate() {
    // rust: assert_eq!(c.get(i), v);
}
    // rust: let packed = c.pack();
    // rust: let loaded = PalettedContainer::from_packed(
    // rust: strategy,
    // rust: packed.palette.clone(),
    // rust: packed.data.as_deref(),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(loaded, c);
    // rust: assert_eq!(loaded.pack(), packed);
    // rust: let again = PalettedContainer::from_values(strategy, &plain);
    // rust: assert_eq!(again, c);
    // rust: assert_eq!(again.pack(), packed);
    // rust: let (bits, palette, words) = c.to_wire();
    // rust: let wire =
    // rust: PalettedContainer::from_wire(strategy, bits, palette, words.to_vec()).unwrap();
    // rust: assert_eq!(wire, c);
    // rust: for wanted in [0, 7, 14, 35, 7 * 699, 5] {
    // rust: assert_eq!(
    // rust: c.has(|v| v == wanted || v == wanted + 7),
    // rust: plain.iter().any(|&v| v == wanted || v == wanted + 7),
    // rust: "has {wanted} in {distinct} values"
    // rust: );
}
}
}
has_matches_a_scan_at_every_width :: proc() {
}
    // rust: let mut state = 0x9E37_79B9_7F4A_7C15u64;
    // rust: for (strategy, distinct) in [
    // rust: (BLOCKS, 2u32),
    // rust: (BLOCKS, 3),
    // rust: (BLOCKS, 17),
    // rust: (BLOCKS, 33),
    // rust: (BLOCKS, 65),
    // rust: (BLOCKS, 129),
    // rust: (BIOMES, 2),
    // rust: (BIOMES, 3),
    // rust: (BIOMES, 5),
    // rust: ] {
    // rust: let entries = strategy.entries();
    // rust: let mut c = PalettedContainer::new(strategy, 0);
    // rust: let mut plain = vec![0u32; entries];
    // rust: for i in 0..entries {
    // rust: let v = (rng(&mut state) % u64::from(distinct)) as u32;
    // rust: c.set(i, v);
    // rust: plain[i] = v;
}
            // Take some values away again (stale entries), the last index too.
    // rust: for gone in [0, 1, distinct - 1] {
    // rust: for i in 0..entries {
    // rust: if plain[i] == gone {
    // rust: c.set(i, distinct);
    // rust: plain[i] = distinct;
}
}
    // rust: for m in [3, 5, 7] {
    // rust: let hit = |v: u32| v % m == gone % m;
    // rust: assert_eq!(c.has(hit), plain.iter().any(|&v| hit(v)));
}
    // rust: for wanted in 0..=distinct {
    // rust: for other in [wanted, wanted + 1, wanted + 2, wanted + 3, wanted + 4] {
    // rust: let hit = |v: u32| v == wanted || v == other;
    // rust: assert_eq!(
    // rust: c.has(hit),
    // rust: plain.iter().any(|&v| hit(v)),
    // rust: "{distinct} values, {wanted}/{other}, without {gone}"
    // rust: );
}
}
}
}
}
has_ignores_stale_palette_entries :: proc() {
}
    // rust: let mut c = PalettedContainer::new(BLOCKS, 0);
    // rust: assert!(c.has(|v| v == 0) && !c.has(|v| v == 3));
    // rust: c.set(4095, 3);
    // rust: assert!(c.has(|v| v == 3));
    // rust: c.set(4095, 0);
    // rust: assert!(c.maybe_has(|v| v == 3) && !c.has(|v| v == 3));
    // rust: for v in 1..=300 {
    // rust: c.set(v as usize, v);
}
    // rust: assert!(c.is_global() && c.has(|v| v == 300));
    // rust: c.set(300, 0);
    // rust: assert!(c.maybe_has(|v| v == 300) && !c.has(|v| v == 300));
}
uniform_detection_ignores_stale_palette_entries :: proc() {
}
    // rust: let mut c = PalettedContainer::new(BLOCKS, 0);
    // rust: c.set(10, 3);
    // rust: assert!(!c.is_uniform(0));
    // rust: c.set(10, 0);
    // rust: assert!(c.palette_len() == 2 && c.is_uniform(0) && c.uniform() == Some(0));
    // rust: assert!(!c.is_uniform(3));
    // rust: for i in 0..4096 {
    // rust: c.set(i, 3);
}
    // rust: assert_eq!(c.uniform(), Some(3));
}
rejects_malformed_wire_data :: proc() {
}
    // rust: assert!(PalettedContainer::from_wire(BLOCKS, 4, vec![1, 2], vec![0; 255]).is_err());
    // rust: assert!(PalettedContainer::from_wire(BLOCKS, 4, vec![1, 2], vec![0x3333; 256]).is_err());
    // rust: assert!(PalettedContainer::from_wire(BLOCKS, 4, vec![], vec![0; 256]).is_err());
    // rust: assert!(PalettedContainer::from_wire(BLOCKS, 0, vec![1, 2], vec![]).is_err());
    // rust: assert!(PalettedContainer::from_wire(BIOMES, 2, vec![1, 2, 3, 4, 5], vec![0; 4]).is_err());
    // rust: assert!(PalettedContainer::from_wire(BLOCKS, 0, vec![9], vec![]).is_ok());
}
saved_validation_matches_entrywise_reference :: proc() {
}
        // Keep the previous loader as an independent entry-at-a-time reference:
        // errors, resident palette order and unused storage bits must all agree.
    // rust: fn reference(
    // rust: strategy: Strategy,
    // rust: palette: Vec<u32>,
    // rust: data: Option<&[u64]>,
    // rust: ) -> Result<PalettedContainer, PaletteError> {
    // rust: if palette.is_empty() {
    // rust: return Err(PaletteError::BadPalette { len: 0 });
}
    // rust: let config = strategy.config(ceil_log2(palette.len()));
    // rust: let entries = strategy.entries();
    // rust: let bits = match config {
    // rust: Config::Single => return Ok(PalettedContainer::new(strategy, palette[0])),
    // rust: Config::List(bits) => bits,
    // rust: Config::Global => ceil_log2(palette.len()),
}
    // rust: let expected = storage_len(bits, entries);
    // rust: let data = data.ok_or(PaletteError::BadStorage {
    // rust: expected,
    // rust: actual: 0,
    // rust: })?;
    // rust: if data.len() != expected {
    // rust: return Err(PaletteError::BadStorage {
    // rust: expected,
    // rust: actual: data.len(),
    // rust: });
}
    // rust: let mut ids = Vec::with_capacity(entries);
    // rust: for i in 0..entries {
    // rust: let index = read(data, bits, i);
    // rust: if index as usize >= palette.len() {
    // rust: return Err(PaletteError::BadIndex {
    // rust: index,
    // rust: palette: palette.len(),
    // rust: });
}
    // rust: ids.push(index);
}
    // rust: Ok(match config {
    // rust: Config::List(bits) => PalettedContainer {
    // rust: strategy,
    // rust: bits,
    // rust: palette: Palette::List(palette),
    // rust: words: data.to_vec(),
    // rust: },
    // rust: _ => PalettedContainer::build(strategy, palette, &ids),
    // rust: })
}
compare :: proc(strategy: Strategy, palette: ^[u32], data: Maybe(^[u64])) {
}
    // rust: let expected = reference(strategy, palette.to_vec(), data);
    // rust: let actual = PalettedContainer::from_packed(strategy, palette.to_vec(), data);
    // rust: match (actual, expected) {
    // rust: (Ok(a), Ok(b)) => {
    // rust: assert_eq!(a.strategy, b.strategy);
    // rust: assert_eq!(a.bits, b.bits);
    // rust: assert_eq!(a.palette, b.palette);
    // rust: assert_eq!(a.words, b.words);
}
    // rust: (Err(a), Err(b)) => assert_eq!(a, b),
    // rust: (a, b) => panic!("loader disagreement: {a:?} vs {b:?}"),
}
}
    // rust: for strategy in [BLOCKS, BIOMES] {
    // rust: for len in [
    // rust: 0, 1, 2, 3, 4, 5, 8, 9, 15, 16, 17, 31, 32, 33, 63, 64, 65, 127, 128, 129, 255,
    // rust: 256, 257, 511, 512, 513, 1023, 1024, 1025, 2047, 2048, 2049, 4096, 4097,
    // rust: ] {
    // rust: let palette: Vec<u32> = (0..len).map(|i| (i as u32 * 7) % 127).collect();
    // rust: compare(strategy, &palette, None);
    // rust: compare(strategy, &palette, Some(&[]));
    // rust: if len <= 1 {
    // rust: compare(strategy, &palette, Some(&[u64::MAX]));
    // rust: continue;
}
    // rust: let bits = match strategy.config(ceil_log2(len)) {
    // rust: Config::List(bits) => bits,
    // rust: _ => ceil_log2(len),
}
    // rust: let entries = strategy.entries();
    // rust: let mut words = pack_words(bits, entries, (0..entries).map(|i| (i % len) as u32));
    // rust: compare(strategy, &palette, Some(&words));
    // rust: compare(strategy, &palette, Some(&words[..words.len() - 1]));
                // Nonzero padding in every word and in the final partial word
                // is legal and must be preserved by resident list palettes.
    // rust: let per = 64 / usize::from(bits);
    // rust: for (word, positions) in words.iter_mut().zip((0..entries).step_by(per)) {
    // rust: let used = (entries - positions).min(per) * usize::from(bits);
    // rust: if used < 64 {
    // rust: *word |= u64::MAX << used;
}
}
    // rust: compare(strategy, &palette, Some(&words));
    // rust: if len < 1usize << bits {
    // rust: for i in [0, per - 1, per, entries / 2, entries - 1] {
    // rust: let mut invalid = words.clone();
    // rust: write(&mut invalid, bits, i, len as u32);
                        // A second invalid entry verifies first-error ordering.
    // rust: write(&mut invalid, bits, entries - 1, mask(bits) as u32);
    // rust: compare(strategy, &palette, Some(&invalid));
}
}
}
}
}
division_magic_is_exact :: proc() {
}
    // rust: for bits in 1..=32u8 {
    // rust: let per = 64 / usize::from(bits);
    // rust: for i in 0..4096usize {
    // rust: assert_eq!(locate(bits, i).0, i / per, "bits {bits} index {i}");
}
}
}

    // The pre-optimization `unpack`, kept to compare against in the benchmark.
baseline_unpack :: proc(c: ^PalettedContainer, out: ^[u32]) {
}
    // rust: match &c.palette {
    // rust: Palette::Single(value) => out.fill(*value),
    // rust: palette => {
    // rust: let bits = usize::from(c.bits);
    // rust: let per = 64 / bits;
    // rust: let m = mask(c.bits);
    // rust: for (chunk, &word) in out.chunks_mut(per).zip(&c.words) {
    // rust: for (slot, cell) in chunk.iter_mut().enumerate() {
    // rust: let id = ((word >> (slot * bits)) & m) as u32;
    // rust: *cell = match palette {
    // rust: Palette::List(list) => list[id as usize],
    // rust: _ => id,
}
}
}
}
}
}

    // `unpack` against the pre-optimization implementation, for a list palette
    // and the global palette. The result is checked before timing; 25 measured
    // rounds alternate order and report the median and best microsecond-per-call.
benchmark_unpack :: proc() {
}
//         use std::{hint::black_box, time::Instant};
    // rust: let values: Vec<u32> = (0..4096).map(|i| (i % 12) as u32).collect();
    // rust: let list = PalettedContainer::from_values(BLOCKS, &values);
    // rust: let global = PalettedContainer::from_values(
    // rust: BLOCKS,
    // rust: &(0..4096).map(|i| (i * 3) as u32).collect::<Vec<_>>(),
    // rust: );
    // rust: for (name, container) in [("list", &list), ("global", &global)] {
    // rust: let mut expected = vec![0u32; 4096];
    // rust: baseline_unpack(container, &mut expected);
    // rust: let mut out = vec![0u32; 4096];
    // rust: container.unpack(&mut out);
    // rust: assert_eq!(expected, out, "unpack {name} differs");
    // rust: let mut times = [Vec::new(), Vec::new()];
    // rust: for round in 0..25 {
    // rust: for optimized in [round % 2 == 0, round % 2 != 0] {
    // rust: let started = Instant::now();
    // rust: for _ in 0..2000 {
    // rust: if optimized {
    // rust: container.unpack(black_box(&mut out));
    // rust: } else {
    // rust: baseline_unpack(black_box(container), black_box(&mut out));
}
}
    // rust: if round > 0 {
    // rust: times[usize::from(optimized)]
    // rust: .push(started.elapsed().as_secs_f64() * 1e6 / 2000.0);
}
}
}
    // rust: for values in &mut times {
    // rust: values.sort_by(f64::total_cmp);
}
    // rust: let median = |v: &[f64]| v[v.len() / 2];
    // rust: println!(
    // rust: "unpack {name} median: baseline {:.3} us optimized {:.3} us speedup {:.3}x",
    // rust: median(&times[0]),
    // rust: median(&times[1]),
    // rust: median(&times[0]) / median(&times[1])
    // rust: );
    // rust: println!(
    // rust: "unpack {name} best:   baseline {:.3} us optimized {:.3} us speedup {:.3}x",
    // rust: times[0][0],
    // rust: times[1][0],
    // rust: times[0][0] / times[1][0]
    // rust: );
}
}

    // The pre-optimization `palette_ids` (scan, then a SipHash map), kept to
    // compare against.
baseline_palette_ids :: proc(values: ^[u32]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut palette: Vec<u32> = Vec::new();
    // rust: let mut small = true;
    // rust: let mut lookup: std::collections::HashMap<u32, u32> = std::collections::HashMap::new();
    // rust: let mut ids = Vec::with_capacity(values.len());
    // rust: for &value in values {
    // rust: let id = if small {
    // rust: match palette.iter().position(|&v| v == value) {
    // rust: Some(id) => id as u32,
    // rust: None => {
    // rust: palette.push(value);
    // rust: if palette.len() > 16 {
    // rust: small = false;
    // rust: lookup.extend(palette.iter().enumerate().map(|(i, &v)| (v, i as u32)));
}
    // rust: palette.len() as u32 - 1
}
}
    // rust: } else {
    // rust: *lookup.entry(value).or_insert_with(|| {
    // rust: palette.push(value);
    // rust: palette.len() as u32 - 1
    // rust: })
}
    // rust: ids.push(id);
}
    // rust: (palette, ids)
}
    // Sections like the ones saved: stone, ores and caves under dirt, grass
    // and air; a mixed surface (plants, leaves, logs) in short runs; a
    // global palette; ids past the table; and biomes.
palette_cases :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut state = 0x9E37_79B9_7F4A_7C15u64;
    // rust: let mut terrain = Vec::with_capacity(4096);
    // rust: for i in 0..4096u32 {
    // rust: let y = i >> 8;
    // rust: let r = rng(&mut state);
    // rust: terrain.push(match y {
    // rust: 0..=8 if r % 40 == 0 => 2000 + (r >> 8) as u32 % 6,
    // rust: 0..=8 if r % 13 == 0 => 0,
    // rust: 0..=8 => 1,
    // rust: 9..=10 => 10,
    // rust: 11 => 9,
    // rust: _ => 0,
    // rust: });
}
    // rust: let mut surface = Vec::with_capacity(4096);
    // rust: while surface.len() < 4096 {
    // rust: let r = rng(&mut state);
    // rust: let run = 1 + (r % 8) as usize;
    // rust: let v = 100 + ((r >> 8) % 24) as u32 * 37;
    // rust: surface.extend(std::iter::repeat_n(v, run.min(4096 - surface.len())));
}
    // rust: let global: Vec<u32> = (0..4096)
    // rust: .map(|_| (rng(&mut state) % 600) as u32 * 41)
    // rust: .collect();
    // rust: let large: Vec<u32> = (0..4096)
    // rust: .map(|i| {
    // rust: if i % 3 == 0 {
    // rust: 70_000 + (rng(&mut state) % 40) as u32
    // rust: } else {
    // rust: i as u32 % 20
}
    // rust: })
    // rust: .collect();
    // rust: let biomes: Vec<u32> = (0..64).map(|i| [3, 3, 3, 7, 7, 12][i % 6]).collect();
    // rust: vec![
    // rust: ("terrain", terrain),
    // rust: ("surface", surface),
    // rust: ("global", global),
    // rust: ("large ids", large),
    // rust: ("biomes", biomes),
    // rust: ("single", vec![5; 4096]),
    // rust: ("seventeen", (0..4096).map(|i| (i % 17) as u32).collect()),
    // rust: ]
}
palette_ids_match_first_occurrence_order :: proc() {
}
    // rust: for (name, values) in palette_cases() {
    // rust: assert_eq!(
    // rust: palette_ids(&values),
    // rust: baseline_palette_ids(&values),
    // rust: "{name}"
    // rust: );
            // The table is left clean for the next section.
    // rust: assert_eq!(
    // rust: palette_ids(&values),
    // rust: baseline_palette_ids(&values),
    // rust: "{name} again"
    // rust: );
}
    // rust: DENSE_IDS.with(|t| assert!(t.borrow().iter().all(|&slot| slot == 0)));
}
    // `palette_ids` against the pre-optimization implementation over the
    // cases above. 25 measured rounds alternate order and report the median
    // microseconds per call.
benchmark_palette_ids :: proc() {
}
//         use std::{hint::black_box, time::Instant};
    // rust: for (name, values) in palette_cases() {
    // rust: let mut times = [Vec::new(), Vec::new()];
    // rust: for round in 0..25 {
    // rust: for optimized in [round % 2 == 0, round % 2 != 0] {
    // rust: let started = Instant::now();
    // rust: for _ in 0..500 {
    // rust: if optimized {
    // rust: black_box(palette_ids(black_box(&values)));
    // rust: } else {
    // rust: black_box(baseline_palette_ids(black_box(&values)));
}
}
    // rust: if round > 0 {
    // rust: times[usize::from(optimized)]
    // rust: .push(started.elapsed().as_secs_f64() * 1e6 / 500.0);
}
}
}
    // rust: for t in &mut times {
    // rust: t.sort_by(f64::total_cmp);
}
    // rust: let (base, new) = (times[0][times[0].len() / 2], times[1][times[1].len() / 2]);
    // rust: println!(
    // rust: "palette_ids {name}: baseline {base:.2} us, new {new:.2} us, {:.2}x",
    // rust: base / new
    // rust: );
}
}
}
