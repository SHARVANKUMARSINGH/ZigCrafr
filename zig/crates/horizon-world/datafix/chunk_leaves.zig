//! Transpiled from Horizon Rust crate
//! Module: horizon-world_chunk_leaves
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `LeavesFix` (key 1496) and `TrappedChestBlockEntityFix` (key 1624): fixes that
//! read the packed block states of the sections of a chunk.
//!
//! `LeavesFix` visits blocks in the iteration order of fastutil hash sets, and the
//! order decides in which order its new palette entries appear: the sets are
//! emulated here (`IntOpenHashSet` and the key order of an `Int2ObjectOpenHashMap`).
// use std::collections::{HashMap, HashSet};

// use super::chunk_flatten::side_mask;
// use super::dynamic::{as_int, as_long_stream, as_str, ceillog2, set};
// use crate::nbt::Tag;

/// `PackedBitStorage`.
pub const Packed = struct {
    data: std.ArrayList(i64),
    bits: usize,
    mask: i64,
};

    // rust: impl Packed {
pub fn new(bits: usize, data: std.ArrayList(i64)) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (data.len() == (4096 * bits).div_ceil(64)).then(|| Self {
    // rust: data,
    // rust: bits,
    // rust: mask: (1i64 << bits) - 1,
    // rust: })
}
pub fn zeroed(bits: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new(bits, vec![0; (4096 * bits).div_ceil(64)]).expect("length")
}
pub fn set(self: *Self, index: usize, value: i32) void {
}
    // rust: let position = index * self.bits;
    // rust: let start = position >> 6;
    // rust: let end = ((index + 1) * self.bits - 1) >> 6;
    // rust: let start_bit = position ^ (start << 6);
    // rust: let value = i64::from(value);
    // rust: self.data[start] =
    // rust: self.data[start] & !(self.mask << start_bit) | (value & self.mask) << start_bit;
    // rust: if start != end {
    // rust: let shift = 64 - start_bit;
    // rust: let wanted = self.bits - shift;
    // rust: self.data[end] =
    // rust: ((self.data[end] as u64) >> wanted << wanted) as i64 | (value & self.mask) >> shift;
}
}
pub fn get(self: *Self, index: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = index * self.bits;
    // rust: let start = position >> 6;
    // rust: let end = ((index + 1) * self.bits - 1) >> 6;
    // rust: let start_bit = position ^ (start << 6);
    // rust: if start == end {
    // rust: return (((self.data[start] as u64) >> start_bit) as i64 & self.mask) as i32;
}
    // rust: let shift = 64 - start_bit;
    // rust: ((((self.data[start] as u64) >> start_bit) as i64 | self.data[end] << shift) & self.mask)
    // rust: as i32
}
}

// ------------------------------------------------------------------ fastutil

pub fn array_size(expected: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // arraySize(expected, 0.75f): nextPowerOfTwo(ceil(expected / f)), at least 2
    // rust: let need = (expected as f64 / 0.75f32 as f64).ceil() as usize;
    // rust: need.next_power_of_two().max(2)
}

pub fn max_fill(n: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((n as f64 * 0.75f32 as f64).ceil() as usize).min(n - 1)
}

pub fn mix(x: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = x.wrapping_mul(0x9E37_79B9u32 as i32);
    // rust: (h ^ ((h as u32) >> 16) as i32) as u32 as usize
}

/// `IntOpenHashSet`: add and iteration order.
pub const IntSet = struct {
    key: std.ArrayList(i32),
    n: usize,
    max_fill: usize,
    size: usize,
    contains_null: bool,
};

    // rust: impl IntSet {
    /// `new IntOpenHashSet()`.
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::sized(16)
}
pub fn sized(expected: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = array_size(expected);
    // rust: Self {
    // rust: key: vec![0; n + 1],
    // rust: n,
    // rust: max_fill: max_fill(n),
    // rust: size: 0,
    // rust: contains_null: false,
}
}
pub fn add(self: *Self, k: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if k == 0 {
    // rust: if self.contains_null {
    // rust: return false;
}
    // rust: self.contains_null = true;
    // rust: } else {
    // rust: let mask = self.n - 1;
    // rust: let mut pos = mix(k) & mask;
    // rust: while self.key[pos] != 0 {
    // rust: if self.key[pos] == k {
    // rust: return false;
}
    // rust: pos = (pos + 1) & mask;
}
    // rust: self.key[pos] = k;
}
    // rust: let grow = self.size >= self.max_fill;
    // rust: self.size += 1;
    // rust: if grow {
    // rust: self.rehash(array_size(self.size + 1));
}
    // rust: true
}
pub fn rehash(self: *Self, new_n: usize) void {
}
    // rust: let mask = new_n - 1;
    // rust: let mut new_key = vec![0; new_n + 1];
    // rust: let real = if self.contains_null {
    // rust: self.size - 1
    // rust: } else {
    // rust: self.size
}
    // rust: let mut i = self.n;
    // rust: for _ in 0..real {
    // rust: loop {
    // rust: i -= 1;
    // rust: if self.key[i] != 0 {
    // rust: break;
}
}
    // rust: let mut pos = mix(self.key[i]) & mask;
    // rust: while new_key[pos] != 0 {
    // rust: pos = (pos + 1) & mask;
}
    // rust: new_key[pos] = self.key[i];
}
    // rust: self.n = new_n;
    // rust: self.max_fill = max_fill(new_n);
    // rust: self.key = new_key;
}
    /// The elements in iteration order: the null key first, then the table from its end.
pub fn order(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::with_capacity(self.size);
    // rust: if self.contains_null {
    // rust: out.push(0);
}
    // rust: for pos in (0..self.n).rev() {
    // rust: if self.key[pos] != 0 {
    // rust: out.push(self.key[pos]);
}
}
    // rust: out
}
}

/// The section indices in the iteration order of
/// `new Int2ObjectOpenHashMap<>(hashMapOfTheSections)`.
pub fn section_order(indices: *[i32]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sorted = indices.to_vec();
    // rust: sorted.sort_unstable();
    // rust: let mut set = IntSet::sized(sorted.len());
    // rust: for i in sorted {
    // rust: set.add(i);
}
    // rust: set.order()
}

// ------------------------------------------------------------------ sections

pub fn leaf_index(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match name {
    // rust: "minecraft:acacia_leaves" => 0,
    // rust: "minecraft:birch_leaves" => 1,
    // rust: "minecraft:dark_oak_leaves" => 2,
    // rust: "minecraft:jungle_leaves" => 3,
    // rust: "minecraft:oak_leaves" => 4,
    // rust: "minecraft:spruce_leaves" => 5,
    // rust: _ => return None,
    // rust: })
}

    // rust: const LOGS: [&str; 18] = [
    // rust: "minecraft:acacia_bark",
    // rust: "minecraft:birch_bark",
    // rust: "minecraft:dark_oak_bark",
    // rust: "minecraft:jungle_bark",
    // rust: "minecraft:oak_bark",
    // rust: "minecraft:spruce_bark",
    // rust: "minecraft:acacia_log",
    // rust: "minecraft:birch_log",
    // rust: "minecraft:dark_oak_log",
    // rust: "minecraft:jungle_log",
    // rust: "minecraft:oak_log",
    // rust: "minecraft:spruce_log",
    // rust: "minecraft:stripped_acacia_log",
    // rust: "minecraft:stripped_birch_log",
    // rust: "minecraft:stripped_dark_oak_log",
    // rust: "minecraft:stripped_jungle_log",
    // rust: "minecraft:stripped_oak_log",
    // rust: "minecraft:stripped_spruce_log",
    // rust: ];

/// A section as `LeavesFix.Section` reads it.
pub const Section = struct {
    index: i32,
    palette: std.ArrayList(Tag),
    storage: ?Packed,
    leaf_ids: std.AutoHashMap(i32, void),
    log_ids: std.AutoHashMap(i32, void),
    state_to_id: HashMap<i32,
};

pub fn name_of(state: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: as_str(state.get("Name")).unwrap_or_default()
}

pub fn state_id(name: []const u8, persistent: bool, distance: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: leaf_index(name).unwrap_or(0) << 5 | if persistent { 16 } else { 0 } | distance
}

pub fn leaf_tag(name: []const u8, persistent: bool, distance: i32) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([
    // rust: (
    // rust: "Properties",
    // rust: Tag::compound([
    // rust: (
    // rust: "persistent",
    // rust: super::dynamic::string(if persistent { "true" } else { "false" }),
    // rust: ),
    // rust: ("distance", super::dynamic::string(&distance.to_string())),
    // rust: ]),
    // rust: ),
    // rust: ("Name", super::dynamic::string(name)),
    // rust: ])
}

    // rust: impl Section {
    /// `LeavesSection` constructor: reads the palette, and rewrites its leaf states.
pub fn read_leaves(section: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Self::read(section);
        // skippable()
    // rust: for i in 0..s.palette.len() {
    // rust: let name = name_of(&s.palette[i]);
    // rust: if leaf_index(&name).is_some() {
    // rust: let persistent = as_str(
    // rust: s.palette[i]
    // rust: .get("Properties")
    // rust: .and_then(|p| p.get("decayable")),
    // rust: )
    // rust: .is_some_and(|d| d == "false");
    // rust: s.leaf_ids.insert(i as i32);
    // rust: s.state_to_id
    // rust: .insert(state_id(&name, persistent, 7), i as i32);
    // rust: s.palette[i] = leaf_tag(&name, persistent, 7);
}
    // rust: if LOGS.contains(&name.as_str()) {
    // rust: s.log_ids.insert(i as i32);
}
}
    // rust: s.finish_read(section, s.leaf_ids.is_empty() && s.log_ids.is_empty());
    // rust: s
}

pub fn read(section: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let palette = match section.get("Palette") {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: Self {
    // rust: index: as_int(section.get("Y"), 0),
    // rust: palette,
    // rust: storage: None,
    // rust: leaf_ids: HashSet::new(),
    // rust: log_ids: HashSet::new(),
    // rust: state_to_id: HashMap::new(),
}
}

pub fn finish_read(self: *Self, section: *Tag, skippable: bool) void {
}
    // rust: if skippable {
    // rust: self.storage = None;
    // rust: } else {
    // rust: let states = as_long_stream(section.get("BlockStates")).unwrap_or_default();
    // rust: let size = ceillog2(self.palette.len()).max(4) as usize;
    // rust: self.storage = Packed::new(size, states);
}
}

pub fn is_skippable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.storage.is_none()
}
pub fn block(self: *Self, pos: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.storage.as_ref().map_or(0, |s| s.get(pos))
}
pub fn is_leaf(self: *Self, block: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.leaf_ids.contains(&block)
}
pub fn is_log(self: *Self, block: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.log_ids.contains(&block)
}
pub fn distance(self: *Self, block: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_log(block) {
    // rust: return 0;
}
    // rust: self.palette
    // rust: .get(block as usize)
    // rust: .and_then(|p| p.get("Properties"))
    // rust: .and_then(|p| as_str(p.get("distance")))
    // rust: .and_then(|d| d.parse().ok())
    // rust: .unwrap_or(0)
}
pub fn set_distance(self: *Self, pos: usize, block: i32, distance: i32) void {
}
    // rust: let base = self.palette[block as usize].clone();
    // rust: let name = name_of(&base);
    // rust: let persistent = as_str(base.get("Properties").and_then(|p| p.get("persistent")))
    // rust: .is_some_and(|p| p == "true");
    // rust: let id_key = state_id(&name, persistent, distance);
    // rust: if !self.state_to_id.contains_key(&id_key) {
    // rust: let id = self.palette.len() as i32;
    // rust: self.leaf_ids.insert(id);
    // rust: self.state_to_id.insert(id_key, id);
    // rust: self.palette.push(leaf_tag(&name, persistent, distance));
}
    // rust: let id = self.state_to_id[&id_key];
    // rust: let storage = self.storage.as_mut().expect("storage");
    // rust: if 1i64 << storage.bits <= i64::from(id) {
    // rust: let mut grown = Packed::zeroed(storage.bits + 1);
    // rust: for i in 0..4096 {
    // rust: grown.set(i, storage.get(i));
}
    // rust: *storage = grown;
}
    // rust: storage.set(pos, id);
}
pub fn write(self: *Self, section: *mut Tag) void {
}
    // rust: let Some(storage) = &self.storage else {
    // rust: return;
}
    // rust: set(section, "BlockStates", Tag::LongArray(storage.data.clone()));
    // rust: set(section, "Palette", Tag::List(self.palette.clone()));
}
}

pub fn get_index(x: i32, y: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: y << 8 | z << 4 | x
}

/// `LeavesFix` over a chunk (`{Level: ...}`).
    // rust: pub(super) fn leaves_fix(chunk: &mut Tag) {
    // rust: let Some(level) = chunk.get_mut("Level") else {
    // rust: return;
}
    // rust: let Some(Tag::List(raw_sections)) = level.get("Sections").cloned() else {
    // rust: return;
}
    // rust: let mut sections: Vec<Section> = raw_sections.iter().map(Section::read_leaves).collect();
    // rust: if sections.iter().all(Section::is_skippable) {
    // rust: return;
}
    // rust: let mut sides = 0;
    // rust: let mut queue: Vec<IntSet> = (0..7).map(|_| IntSet::new()).collect();
    // rust: let indices: Vec<i32> = sections.iter().map(|s| s.index).collect();
    // rust: for index in section_order(&indices) {
    // rust: let Some(section) = sections.iter().find(|s| s.index == index) else {
    // rust: continue;
}
    // rust: if section.is_skippable() {
    // rust: continue;
}
    // rust: for i in 0..4096usize {
    // rust: let block = section.block(i);
    // rust: if section.is_log(block) {
    // rust: queue[0].add(section.index << 12 | i as i32);
    // rust: } else if section.is_leaf(block) {
    // rust: let x = (i & 15) as i32;
    // rust: let z = (i >> 4 & 15) as i32;
    // rust: sides |= side_mask(x == 0, x == 15, z == 0, z == 15);
}
}
}
    // rust: const DIRECTIONS: [[i32; 3]; 6] = [
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: ];
    // rust: for i in 1..7 {
    // rust: let current = queue[i - 1].order();
    // rust: for pos_chunk in current {
    // rust: let x = pos_chunk & 15;
    // rust: let y = pos_chunk >> 8 & 0xFF;
    // rust: let z = pos_chunk >> 4 & 15;
    // rust: for d in DIRECTIONS {
    // rust: let (nx, ny, nz) = (x + d[0], y + d[1], z + d[2]);
    // rust: if !(0..=15).contains(&nx) || !(0..=15).contains(&nz) || !(0..=255).contains(&ny) {
    // rust: continue;
}
    // rust: let Some(section) = sections.iter_mut().find(|s| s.index == ny >> 4) else {
    // rust: continue;
}
    // rust: if section.is_skippable() {
    // rust: continue;
}
    // rust: let pos_section = get_index(nx, ny & 15, nz) as usize;
    // rust: let block = section.block(pos_section);
    // rust: if section.is_leaf(block) && section.distance(block) > i as i32 {
    // rust: section.set_distance(pos_section, block, i as i32);
    // rust: queue[i].add(get_index(nx, ny, nz));
}
}
}
}
    // rust: if let Some(Tag::List(list)) = level.get_mut("Sections") {
    // rust: for raw in list.iter_mut() {
    // rust: let y = as_int(raw.get("Y"), 0);
    // rust: if let Some(section) = sections.iter().find(|s| s.index == y) {
    // rust: section.write(raw);
}
}
}
    // rust: if sides != 0 {
    // rust: let mut upgrade = level
    // rust: .get("UpgradeData")
    // rust: .cloned()
    // rust: .unwrap_or_else(super::dynamic::empty_map);
    // rust: let old = as_int(upgrade.get("Sides"), 0) as i8;
    // rust: set(&mut upgrade, "Sides", Tag::Byte(old | sides as i8));
    // rust: set(level, "UpgradeData", upgrade);
}
}

/// `TrappedChestBlockEntityFix` over a chunk (`{Level: ...}`).
    // rust: pub(super) fn trapped_chest_fix(chunk: &mut Tag) {
    // rust: let Some(level) = chunk.get_mut("Level") else {
    // rust: return;
}
    // rust: let Some(Tag::List(raw_sections)) = level.get("Sections").cloned() else {
    // rust: return;
}
    // rust: let mut chests: HashSet<i32> = HashSet::new();
    // rust: for raw in &raw_sections {
    // rust: let mut section = Section::read(raw);
    // rust: let ids: HashSet<i32> = section
    // rust: .palette
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, p)| name_of(p) == "minecraft:trapped_chest")
    // rust: .map(|(i, _)| i as i32)
    // rust: .collect();
    // rust: section.finish_read(raw, ids.is_empty());
    // rust: if section.is_skippable() {
    // rust: continue;
}
    // rust: for i in 0..4096usize {
    // rust: if ids.contains(&section.block(i)) {
    // rust: chests.insert(section.index << 12 | i as i32);
}
}
}
    // rust: let chunk_x = as_int(level.get("xPos"), 0);
    // rust: let chunk_z = as_int(level.get("zPos"), 0);
    // rust: if let Some(Tag::List(entities)) = level.get_mut("TileEntities") {
    // rust: for be in entities {
    // rust: if !super::schema::block_entity_known(be, super::schema::key(1624, 0) - 1) {
    // rust: continue;
}
    // rust: let x = as_int(be.get("x"), 0).wrapping_sub(chunk_x << 4);
    // rust: let y = as_int(be.get("y"), 0);
    // rust: let z = as_int(be.get("z"), 0).wrapping_sub(chunk_z << 4);
    // rust: if chests.contains(&get_index(x, y, z)) {
    // rust: set(be, "id", super::dynamic::string("minecraft:trapped_chest"));
}
}
}
}
