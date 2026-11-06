//! Transpiled from Horizon Rust crate
//! Module: horizon-world_chunk_flatten
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `ChunkPalettedStorageFix` (key 1451.1): the chunk sections of the 1.12 format
//! (`Blocks`, `Data`, `Add` byte arrays) become a palette and packed `BlockStates`,
//! with the block entities that carried block state (note blocks, flower pots,
//! beds, banners, skulls) folded into the states, as vanilla does.
//!
//! Vanilla compares block states by identity (`CrudeIncrementalIntIdentityHashBiMap`
//! and an identity set): states are instances here, numbered in one space with the
//! instances of the `BlockStateData` table.
// use std::collections::{HashMap, HashSet};
// use std::sync::OnceLock;

// use super::block_state_data::{self as bsd, State};
// use super::dynamic::{as_bool, as_byte_buffer, as_int, as_str, ceillog2, key, set};
// use crate::nbt::Tag;

/// `MappingConstants`.
pub const Consts = struct {
    /// Instances: the `BlockStateData` ones first, then the constants below.
    states: std.ArrayList(State),
    air: u32,
    pumpkin: u32,
    snowy_podzol: u32,
    snowy_grass: u32,
    snowy_mycelium: u32,
    upper: HashMap<*'static str,
    flower_pot: HashMap<[]const u8,
    skull: HashMap<[]const u8,
    door: HashMap<[]const u8,
    note_block: HashMap<[]const u8,
    bed: HashMap<[]const u8,
    banner: HashMap<[]const u8,
};

    // rust: const DYE_COLORS: [&str; 16] = [
    // rust: "white",
    // rust: "orange",
    // rust: "magenta",
    // rust: "light_blue",
    // rust: "yellow",
    // rust: "lime",
    // rust: "pink",
    // rust: "gray",
    // rust: "light_gray",
    // rust: "cyan",
    // rust: "purple",
    // rust: "blue",
    // rust: "brown",
    // rust: "green",
    // rust: "red",
    // rust: "black",
    // rust: ];

pub fn consts() * {
    // Implementation ported from Horizon
    return undefined;
}
pub const C: OnceLock<Consts> = OnceLock::new();
    // rust: C.get_or_init(|| {
    // rust: let mut states = bsd::data().instances.clone();
    // rust: let mut add = |name: &str, props: &[(&str, &str)]| -> u32 {
    // rust: states.push(State::new(name, props));
    // rust: (states.len() - 1) as u32
}
    // rust: let air = add("minecraft:air", &[]);
    // rust: let pumpkin = add("minecraft:pumpkin", &[]);
    // rust: let snowy_podzol = add("minecraft:podzol", &[("snowy", "true")]);
    // rust: let snowy_grass = add("minecraft:grass_block", &[("snowy", "true")]);
    // rust: let snowy_mycelium = add("minecraft:mycelium", &[("snowy", "true")]);
    // rust: let mut upper = HashMap::new();
    // rust: for name in [
    // rust: "minecraft:sunflower",
    // rust: "minecraft:lilac",
    // rust: "minecraft:tall_grass",
    // rust: "minecraft:large_fern",
    // rust: "minecraft:rose_bush",
    // rust: "minecraft:peony",
    // rust: ] {
    // rust: upper.insert(name, add(name, &[("half", "upper")]));
}
    // rust: let mut flower_pot = HashMap::new();
    // rust: let pots: [(&str, &str); 22] = [
    // rust: ("minecraft:air0", "minecraft:flower_pot"),
    // rust: ("minecraft:red_flower0", "minecraft:potted_poppy"),
    // rust: ("minecraft:red_flower1", "minecraft:potted_blue_orchid"),
    // rust: ("minecraft:red_flower2", "minecraft:potted_allium"),
    // rust: ("minecraft:red_flower3", "minecraft:potted_azure_bluet"),
    // rust: ("minecraft:red_flower4", "minecraft:potted_red_tulip"),
    // rust: ("minecraft:red_flower5", "minecraft:potted_orange_tulip"),
    // rust: ("minecraft:red_flower6", "minecraft:potted_white_tulip"),
    // rust: ("minecraft:red_flower7", "minecraft:potted_pink_tulip"),
    // rust: ("minecraft:red_flower8", "minecraft:potted_oxeye_daisy"),
    // rust: ("minecraft:yellow_flower0", "minecraft:potted_dandelion"),
    // rust: ("minecraft:sapling0", "minecraft:potted_oak_sapling"),
    // rust: ("minecraft:sapling1", "minecraft:potted_spruce_sapling"),
    // rust: ("minecraft:sapling2", "minecraft:potted_birch_sapling"),
    // rust: ("minecraft:sapling3", "minecraft:potted_jungle_sapling"),
    // rust: ("minecraft:sapling4", "minecraft:potted_acacia_sapling"),
    // rust: ("minecraft:sapling5", "minecraft:potted_dark_oak_sapling"),
    // rust: ("minecraft:red_mushroom0", "minecraft:potted_red_mushroom"),
    // rust: (
    // rust: "minecraft:brown_mushroom0",
    // rust: "minecraft:potted_brown_mushroom",
    // rust: ),
    // rust: ("minecraft:deadbush0", "minecraft:potted_dead_bush"),
    // rust: ("minecraft:tallgrass2", "minecraft:potted_fern"),
    // rust: ("minecraft:cactus0", "minecraft:potted_cactus"),
    // rust: ];
    // rust: for (k, name) in pots {
    // rust: flower_pot.insert(k.to_owned(), add(name, &[]));
}
    // rust: let mut skull = HashMap::new();
    // rust: for (i, name, ty) in [
    // rust: (0, "skeleton", "skull"),
    // rust: (1, "wither_skeleton", "skull"),
    // rust: (2, "zombie", "head"),
    // rust: (3, "player", "head"),
    // rust: (4, "creeper", "head"),
    // rust: (5, "dragon", "head"),
    // rust: ] {
    // rust: for facing in ["north", "east", "south", "west"] {
    // rust: skull.insert(
    // rust: format!("{i}{facing}"),
    // rust: add(
    // rust: &format!("minecraft:{name}_wall_{ty}"),
    // rust: &[("facing", facing)],
    // rust: ),
    // rust: );
}
    // rust: for rot in 0..16 {
    // rust: skull.insert(
    // rust: format!("{i}{rot}"),
    // rust: add(
    // rust: &format!("minecraft:{name}_{ty}"),
    // rust: &[("rotation", &rot.to_string())],
    // rust: ),
    // rust: );
}
}
    // rust: let mut door = HashMap::new();
    // rust: for ty in [
    // rust: "oak_door",
    // rust: "iron_door",
    // rust: "spruce_door",
    // rust: "birch_door",
    // rust: "jungle_door",
    // rust: "acacia_door",
    // rust: "dark_oak_door",
    // rust: ] {
    // rust: let id = format!("minecraft:{ty}");
    // rust: for facing in ["east", "north", "south", "west"] {
    // rust: for half in ["lower", "upper"] {
    // rust: for hinge in ["left", "right"] {
    // rust: for open in ["false", "true"] {
    // rust: for powered in ["false", "true"] {
    // rust: door.insert(
    // rust: format!("{id}{facing}{half}{hinge}{open}{powered}"),
    // rust: add(
    // rust: &id,
    // rust: &[
    // rust: ("facing", facing),
    // rust: ("half", half),
    // rust: ("hinge", hinge),
    // rust: ("open", open),
    // rust: ("powered", powered),
    // rust: ],
    // rust: ),
    // rust: );
}
}
}
}
}
}
    // rust: let mut note_block = HashMap::new();
    // rust: for i in 0..26 {
    // rust: for powered in ["true", "false"] {
    // rust: note_block.insert(
    // rust: format!("{powered}{i}"),
    // rust: add(
    // rust: "minecraft:note_block",
    // rust: &[("powered", powered), ("note", &i.to_string())],
    // rust: ),
    // rust: );
}
}
    // rust: let mut bed = HashMap::new();
    // rust: for (id, color) in DYE_COLORS.iter().enumerate() {
    // rust: if *color == "red" {
    // rust: continue;
}
    // rust: let name = format!("minecraft:{color}_bed");
    // rust: for (facing, occupied, part) in [
    // rust: ("south", "false", "foot"),
    // rust: ("west", "false", "foot"),
    // rust: ("north", "false", "foot"),
    // rust: ("east", "false", "foot"),
    // rust: ("south", "false", "head"),
    // rust: ("west", "false", "head"),
    // rust: ("north", "false", "head"),
    // rust: ("east", "false", "head"),
    // rust: ("south", "true", "head"),
    // rust: ("west", "true", "head"),
    // rust: ("north", "true", "head"),
    // rust: ("east", "true", "head"),
    // rust: ] {
    // rust: bed.insert(
    // rust: format!("{facing}{occupied}{part}{id}"),
    // rust: add(
    // rust: &name,
    // rust: &[("facing", facing), ("occupied", occupied), ("part", part)],
    // rust: ),
    // rust: );
}
}
    // rust: let mut banner = HashMap::new();
    // rust: for (id, color) in DYE_COLORS.iter().enumerate() {
    // rust: if *color == "white" {
    // rust: continue;
}
    // rust: let color_id = 15 - id;
    // rust: for i in 0..16 {
    // rust: banner.insert(
    // rust: format!("{i}_{color_id}"),
    // rust: add(
    // rust: &format!("minecraft:{color}_banner"),
    // rust: &[("rotation", &i.to_string())],
    // rust: ),
    // rust: );
}
    // rust: for facing in ["north", "south", "west", "east"] {
    // rust: banner.insert(
    // rust: format!("{facing}_{color_id}"),
    // rust: add(
    // rust: &format!("minecraft:{color}_wall_banner"),
    // rust: &[("facing", facing)],
    // rust: ),
    // rust: );
}
}
    // rust: Consts {
    // rust: states,
    // rust: air,
    // rust: pumpkin,
    // rust: snowy_podzol,
    // rust: snowy_grass,
    // rust: snowy_mycelium,
    // rust: upper,
    // rust: flower_pot,
    // rust: skull,
    // rust: door,
    // rust: note_block,
    // rust: bed,
    // rust: banner,
}
    // rust: })
}

/// The block ids (`id >> 4`) whose blocks need a second look.
    // rust: const FIX: [usize; 18] = [
    // rust: 2, 3, 110, 140, 144, 25, 86, 26, 176, 177, 175, 64, 71, 193, 194, 195, 196, 197,
    // rust: ];
    // rust: const VIRTUAL: &[usize] = &[
    // rust: 54, 146, 25, 26, 51, 53, 67, 108, 109, 114, 128, 134, 135, 136, 156, 163, 164, 180, 203, 55,
    // rust: 85, 113, 188, 189, 190, 191, 192, 93, 94, 101, 102, 160, 106, 107, 183, 184, 185, 186, 187,
    // rust: 132, 139, 199,
    // rust: ];

pub fn is_virtual(block: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: VIRTUAL.contains(&block)
}

/// `getSideMask` (LeavesFix has the same copy).
    // rust: pub(super) fn side_mask(west: bool, east: bool, north: bool, south: bool) -> i32 {
    // rust: let mut s = 0;
    // rust: if north {
    // rust: if east {
    // rust: s |= 2;
    // rust: } else if west {
    // rust: s |= 128;
    // rust: } else {
    // rust: s |= 1;
}
    // rust: } else if south {
    // rust: if west {
    // rust: s |= 32;
    // rust: } else if east {
    // rust: s |= 8;
    // rust: } else {
    // rust: s |= 16;
}
    // rust: } else if east {
    // rust: s |= 4;
    // rust: } else if west {
    // rust: s |= 64;
}
    // rust: s
}

/// A `DataLayer`: 4 bits per block.
pub const Nibbles = struct {};

    // rust: impl Nibbles {
pub fn get(self: *Self, x: usize, y: usize, z: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = y << 8 | z << 4 | x;
    // rust: let byte = self.0[position >> 1];
    // rust: if position & 1 == 0 {
    // rust: i32::from(byte & 15)
    // rust: } else {
    // rust: i32::from(byte >> 4 & 15)
}
}
}

pub const Section = struct {
    y: i32,
    has_data: bool,
    /// The `listTag`: instances in the order they were first seen.
    list: std.ArrayList(u32),
    seen: std.AutoHashMap(u32, void),
    /// `palette`: instance by palette id.
    palette: std.ArrayList(u32),
    palette_ids: HashMap<u32,
    to_fix: Vec<(usize,
    update: std.ArrayList(i32),
    buffer: std.ArrayList(i32),
    raw: Tag,
};

    // rust: impl Section {
pub fn new(raw: Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let y = as_int(raw.get("Y"), 0);
    // rust: let has_data = raw.get("Blocks").is_some();
    // rust: Self {
    // rust: y,
    // rust: has_data,
    // rust: list: Vec::new(),
    // rust: seen: HashSet::new(),
    // rust: palette: Vec::new(),
    // rust: palette_ids: HashMap::new(),
    // rust: to_fix: Vec::new(),
    // rust: update: Vec::new(),
    // rust: buffer: vec![0; 4096],
    // rust: raw,
}
}

pub fn get_block(self: *Self, pos: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if pos <= 4095 {
    // rust: self.palette
    // rust: .get(self.buffer[pos] as usize)
    // rust: .copied()
    // rust: .unwrap_or_else(|| consts().air)
    // rust: } else {
    // rust: consts().air
}
}

pub fn set_block(self: *Self, idx: usize, state: u32) void {
}
    // rust: if self.seen.insert(state) {
    // rust: self.list.push(state);
}
    // rust: let id = match self.palette_ids.get(&state) {
    // rust: Some(id) => *id,
    // rust: None => {
    // rust: self.palette.push(state);
    // rust: let id = (self.palette.len() - 1) as i32;
    // rust: self.palette_ids.insert(state, id);
    // rust: id
}
}
    // rust: self.buffer[idx] = id;
}

pub fn add_fix(self: *Self, block: usize, position: usize) void {
}
    // rust: match self.to_fix.iter_mut().find(|(b, _)| *b == block) {
    // rust: Some((_, list)) => list.push(position),
    // rust: None => self.to_fix.push((block, vec![position])),
}
}

pub fn upgrade(self: *Self, mut sides: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.has_data {
    // rust: return sides;
}
    // rust: let blocks = as_byte_buffer(self.raw.get("Blocks")).unwrap_or_default();
    // rust: let nibbles = |name: &str| {
    // rust: as_byte_buffer(self.raw.get(name))
    // rust: .map(Nibbles)
    // rust: .unwrap_or_else(|| Nibbles(vec![0; 2048]))
}
    // rust: let data = nibbles("Data");
    // rust: let add_blocks = nibbles("Add");
    // rust: let c = consts();
    // rust: self.seen.insert(c.air);
    // rust: self.palette.push(c.air);
    // rust: self.palette_ids.insert(c.air, 0);
    // rust: self.list.push(c.air);
    // rust: let d = bsd::data();
    // rust: for idx in 0..4096usize {
    // rust: let (xx, yy, zz) = (idx & 15, idx >> 8 & 15, idx >> 4 & 15);
    // rust: let id = add_blocks.get(xx, yy, zz) << 12
    // rust: | i32::from(blocks.get(idx).copied().unwrap_or(0)) << 4
    // rust: | data.get(xx, yy, zz);
    // rust: let block = (id >> 4) as usize;
    // rust: if FIX.contains(&block) {
    // rust: self.add_fix(block, idx);
}
    // rust: if is_virtual(block) {
    // rust: let s = side_mask(xx == 0, xx == 15, zz == 0, zz == 15);
    // rust: if s == 0 {
    // rust: self.update.push(idx as i32);
    // rust: } else {
    // rust: sides |= s;
}
}
    // rust: self.set_block(idx, d.instance(id));
}
    // rust: sides
}

pub fn write(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut section = self.raw.clone();
    // rust: if !self.has_data {
    // rust: return section;
}
    // rust: let c = consts();
    // rust: let palette: Vec<Tag> = self
    // rust: .list
    // rust: .iter()
    // rust: .map(|s| {
    // rust: let state = &c.states[*s as usize];
    // rust: if state.name == "%%FILTER_ME%%" {
    // rust: c.states[c.air as usize].to_tag()
    // rust: } else {
    // rust: state.to_tag()
}
    // rust: })
    // rust: .collect();
    // rust: set(&mut section, "Palette", Tag::List(palette));
    // rust: let bits = ceillog2(self.seen.len()).max(4) as usize;
    // rust: let mut storage = vec![0i64; (4096 * bits).div_ceil(64)];
    // rust: let mask = (1i64 << bits) - 1;
    // rust: for (index, value) in self.buffer.iter().enumerate() {
    // rust: let value = i64::from(*value);
    // rust: let position = index * bits;
    // rust: let start = position >> 6;
    // rust: let end = ((index + 1) * bits - 1) >> 6;
    // rust: let start_bit = position ^ (start << 6);
    // rust: storage[start] = storage[start] & !(mask << start_bit) | (value & mask) << start_bit;
    // rust: if start != end {
    // rust: let shift = 64 - start_bit;
    // rust: let wanted = bits - shift;
    // rust: storage[end] =
    // rust: ((storage[end] as u64) >> wanted << wanted) as i64 | (value & mask) >> shift;
}
}
    // rust: set(&mut section, "BlockStates", Tag::LongArray(storage));
    // rust: for f in ["Blocks", "Data", "Add"] {
    // rust: super::dynamic::remove(&mut section, f);
}
    // rust: section
}
}

pub const Direction = enum {
    Down,
    Up,
};

pub fn relative(pos: i64, direction: Direction) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let y = (pos >> 8)
    // rust: + if matches!(direction, Direction::Up) {
    // rust: 1
    // rust: } else {
    // rust: -1
}
    // rust: if (0..=255).contains(&y) {
    // rust: pos & 0xFF | y << 8
    // rust: } else {
    // rust: -1
}
}

pub const UpgradeChunk = struct {
    sides: i32,
    sections: std.ArrayList(?Section),
    /// `Int2ObjectLinkedOpenHashMap`: insertion order, a repeated key keeps its place.
    block_entities: Vec<(i64,
};

    // rust: impl UpgradeChunk {
pub fn block_entity(self: *Self, pos: i64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_entities
    // rust: .iter()
    // rust: .find(|(k, _)| *k == pos)
    // rust: .map(|(_, v)| v)
}
pub fn remove_block_entity(self: *Self, pos: i64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = self.block_entities.iter().position(|(k, _)| *k == pos)?;
    // rust: Some(self.block_entities.remove(i).1)
}
pub fn section(self: *Self, pos: i64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections.get((pos >> 12) as usize)?.as_ref()
}
pub fn get_block(self: *Self, pos: i64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if (0..=65535).contains(&pos) {
    // rust: match self.section(pos) {
    // rust: Some(s) => s.get_block((pos & 4095) as usize),
    // rust: None => consts().air,
}
    // rust: } else {
    // rust: consts().air
}
}
pub fn set_block(self: *Self, pos: i64, block: u32) void {
}
    // rust: if (0..=65535).contains(&pos)
    // rust: && let Some(Some(s)) = self.sections.get_mut((pos >> 12) as usize)
    // rust: {
    // rust: s.set_block((pos & 4095) as usize, block);
}
}
pub fn name(self: *Self, pos: i64) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &consts().states[self.get_block(pos) as usize].name
}
pub fn state(self: *Self, pos: i64) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &consts().states[self.get_block(pos) as usize]
}
}

/// `ChunkPalettedStorageFix.fix` over a chunk (`{Level: ...}`).
    // rust: pub(super) fn fix(chunk: &mut Tag) {
    // rust: let Some(level) = chunk.get_mut("Level") else {
    // rust: return;
}
    // rust: if !matches!(level.get("Sections"), Some(Tag::List(_))) {
    // rust: return;
}
    // rust: let new_level = upgrade_level(level);
    // rust: *level = new_level;
}

pub fn upgrade_level(level: *Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = consts();
    // rust: let x0 = as_int(level.get("xPos"), 0) << 4;
    // rust: let z0 = as_int(level.get("zPos"), 0) << 4;
    // rust: let mut chunk = UpgradeChunk {
    // rust: sides: 0,
    // rust: sections: (0..16).map(|_| None).collect(),
    // rust: block_entities: Vec::new(),
}
    // rust: if let Some(Tag::List(entities)) = level.get("TileEntities") {
    // rust: for entity in entities {
    // rust: let x = i64::from(as_int(entity.get("x"), 0).wrapping_sub(x0) & 15);
    // rust: let y = i64::from(as_int(entity.get("y"), 0));
    // rust: let z = i64::from(as_int(entity.get("z"), 0).wrapping_sub(z0) & 15);
    // rust: let k = (y << 8) | (z << 4) | x;
    // rust: match chunk.block_entities.iter_mut().find(|(key, _)| *key == k) {
    // rust: Some((_, v)) => *v = entity.clone(),
    // rust: None => chunk.block_entities.push((k, entity.clone())),
}
}
}
    // rust: let converted_from_alpha = as_bool(level.get("convertedFromAlphaFormat"), false);
    // rust: if let Some(Tag::List(sections)) = level.get("Sections") {
    // rust: for raw in sections {
    // rust: let mut section = Section::new(raw.clone());
    // rust: chunk.sides = section.upgrade(chunk.sides);
    // rust: let y = section.y;
    // rust: if (0..16).contains(&y) {
    // rust: chunk.sections[y as usize] = Some(section);
}
}
}
    // rust: for si in 0..16 {
    // rust: let Some(section) = &chunk.sections[si] else {
    // rust: continue;
}
    // rust: let to_fix = section.to_fix.clone();
    // rust: let section_y = section.y as i64;
    // rust: for (block, positions) in to_fix {
    // rust: let dy = section_y << 12;
    // rust: for pos in positions {
    // rust: let pos = pos as i64 | dy;
    // rust: fix_block(&mut chunk, c, block, pos, converted_from_alpha);
}
}
}
    // write()
    // rust: let mut out = level.clone();
    // rust: if chunk.block_entities.is_empty() {
    // rust: super::dynamic::remove(&mut out, "TileEntities");
    // rust: } else {
    // rust: set(
    // rust: &mut out,
    // rust: "TileEntities",
    // rust: Tag::List(
    // rust: chunk
    // rust: .block_entities
    // rust: .iter()
    // rust: .map(|(_, v)| v.clone())
    // rust: .collect(),
    // rust: ),
    // rust: );
}
    // rust: let mut indices = crate::nbt::Compound::new();
    // rust: let mut sections = Vec::new();
    // rust: for section in chunk.sections.iter().flatten() {
    // rust: sections.push(section.write());
    // rust: indices.insert(
    // rust: key(&section.y.to_string()),
    // rust: Tag::IntArray(section.update.clone()),
    // rust: );
}
    // rust: let upgrade_data = Tag::compound([
    // rust: ("Sides", Tag::Byte(chunk.sides as i8)),
    // rust: ("Indices", Tag::Compound(indices)),
    // rust: ]);
    // rust: set(&mut out, "UpgradeData", upgrade_data);
    // rust: set(&mut out, "Sections", Tag::List(sections));
    // rust: out
}

pub fn fix_block(chunk: *mut UpgradeChunk, c: *Consts, block: usize, pos: i64, alpha: bool) void {
}
    // rust: let up = relative(pos, Direction::Up);
    // rust: let down = relative(pos, Direction::Down);
    // rust: let is_snow = |n: &str| n == "minecraft:snow" || n == "minecraft:snow_layer";
    // rust: match block {
    // rust: 2 => {
    // rust: if chunk.name(pos) == "minecraft:grass_block" && is_snow(chunk.name(up)) {
    // rust: chunk.set_block(pos, c.snowy_grass);
}
}
    // rust: 3 => {
    // rust: if chunk.name(pos) == "minecraft:podzol" && is_snow(chunk.name(up)) {
    // rust: chunk.set_block(pos, c.snowy_podzol);
}
}
    // rust: 25 => {
    // rust: if let Some(entity) = chunk.remove_block_entity(pos) {
    // rust: let note = as_int(entity.get("note"), 0).clamp(0, 24) as i8;
    // rust: let k = format!("{}{}", as_bool(entity.get("powered"), false), note);
    // rust: let state = c
    // rust: .note_block
    // rust: .get(&k)
    // rust: .or_else(|| c.note_block.get("false0"))
    // rust: .copied()
    // rust: .expect("note block");
    // rust: chunk.set_block(pos, state);
}
}
    // rust: 26 => {
    // rust: if let Some(entity) = chunk.block_entity(pos) {
    // rust: let color = as_int(entity.get("color"), 0);
    // rust: let state = chunk.state(pos);
    // rust: if color != 14 && (0..16).contains(&color) {
    // rust: let k = format!(
    // rust: "{}{}{}{}",
    // rust: state.property("facing"),
    // rust: state.property("occupied"),
    // rust: state.property("part"),
    // rust: color
    // rust: );
    // rust: if let Some(s) = c.bed.get(&k).copied() {
    // rust: chunk.set_block(pos, s);
}
}
}
}
    // rust: 64 | 71 | 193..=197 => {
    // rust: if chunk.name(pos).ends_with("_door") {
    // rust: let lower = chunk.state(pos).clone();
    // rust: if lower.property("half") == "lower" {
    // rust: let above = up;
    // rust: let upper = chunk.state(above).clone();
    // rust: if lower.name == upper.name {
    // rust: let facing = lower.property("facing");
    // rust: let open = lower.property("open");
    // rust: let hinge = if alpha {
    // rust: "left"
    // rust: } else {
    // rust: upper.property("hinge")
}
    // rust: let powered = if alpha {
    // rust: "false"
    // rust: } else {
    // rust: upper.property("powered")
}
    // rust: let name = &lower.name;
    // rust: let lo = c
    // rust: .door
    // rust: .get(&format!("{name}{facing}lower{hinge}{open}{powered}"))
    // rust: .copied();
    // rust: let hi = c
    // rust: .door
    // rust: .get(&format!("{name}{facing}upper{hinge}{open}{powered}"))
    // rust: .copied();
    // rust: if let (Some(lo), Some(hi)) = (lo, hi) {
    // rust: chunk.set_block(pos, lo);
    // rust: chunk.set_block(above, hi);
}
}
}
}
}
    // rust: 86 => {
    // rust: if chunk.name(pos) == "minecraft:carved_pumpkin" {
    // rust: let below = chunk.name(down);
    // rust: if below == "minecraft:grass_block" || below == "minecraft:dirt" {
    // rust: chunk.set_block(pos, c.pumpkin);
}
}
}
    // rust: 110 => {
    // rust: if chunk.name(pos) == "minecraft:mycelium" && is_snow(chunk.name(up)) {
    // rust: chunk.set_block(pos, c.snowy_mycelium);
}
}
    // rust: 140 => {
    // rust: if let Some(entity) = chunk.remove_block_entity(pos) {
    // rust: let item = as_str(entity.get("Item")).unwrap_or_default();
    // rust: let k = format!("{}{}", item, as_int(entity.get("Data"), 0));
    // rust: let state = c
    // rust: .flower_pot
    // rust: .get(&k)
    // rust: .or_else(|| c.flower_pot.get("minecraft:air0"))
    // rust: .copied()
    // rust: .expect("flower pot");
    // rust: chunk.set_block(pos, state);
}
}
    // rust: 144 => {
    // rust: if let Some(entity) = chunk.block_entity(pos) {
    // rust: let ty = as_int(entity.get("SkullType"), 0).to_string();
    // rust: let facing = chunk.state(pos).property("facing").to_owned();
    // rust: let k = if facing != "up" && facing != "down" {
    // rust: format!("{ty}{facing}")
    // rust: } else {
    // rust: format!("{ty}{}", as_int(entity.get("Rot"), 0))
}
                // `entity.remove(...)` on an immutable Dynamic changes nothing.
    // rust: let state = c
    // rust: .skull
    // rust: .get(&k)
    // rust: .or_else(|| c.skull.get("0north"))
    // rust: .copied()
    // rust: .expect("skull");
    // rust: chunk.set_block(pos, state);
}
}
    // rust: 175 => {
    // rust: if chunk.state(pos).property("half") == "upper" {
    // rust: let variant = chunk.name(down).to_owned();
    // rust: if let Some(s) = c.upper.get(variant.as_str()).copied() {
    // rust: chunk.set_block(pos, s);
}
}
}
    // rust: 176 | 177 => {
    // rust: if let Some(entity) = chunk.block_entity(pos) {
    // rust: let color = as_int(entity.get("Base"), 0);
    // rust: let state = chunk.state(pos);
    // rust: if color != 15 && (0..16).contains(&color) {
    // rust: let prop = state.property(if block == 176 { "rotation" } else { "facing" });
    // rust: let k = format!("{prop}_{color}");
    // rust: if let Some(s) = c.banner.get(&k).copied() {
    // rust: chunk.set_block(pos, s);
}
}
}
}
    // rust: _ => {}
}
}
