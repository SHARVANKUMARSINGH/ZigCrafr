//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_chunk
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Resident client chunk storage. Sections are reference-counted so worker
//! threads can mesh and light immutable snapshots while the game thread edits
//! (copy-on-write through `Arc::make_mut`).
// use horizon_core::paletted::{PalettedContainer, Strategy};
// use horizon_world::nbt::{Compound, Tag};
// use horizon_world::registry::BlockStateId;
// use std::sync::{Arc, OnceLock};

    // rust: pub mod block_entity;

/// The vanilla Overworld's column, which every dimension's chunks hold for
/// now (`LevelShape::column`).
pub const MIN_Y: i32 = -64;
pub const HEIGHT: i32 = 384;
pub const SECTIONS: usize = (HEIGHT / 16) ;

/// A level's build range, skylight and ceiling, from its dimension type
/// (`min_y`, `height`, `logical_height`, `has_skylight`, `has_ceiling`), as
/// `LevelHeightAccessor` and `SerializableChunkData.write` read them.
pub const LevelShape = struct {
    sky_light: bool,
    /// `DimensionType.hasCeiling`: weather, spawning and maps read it.
    has_ceiling: bool,
    min_y: i32,
    height: i32,
    /// `DimensionType.logicalHeight`: how high portals and chorus fruit reach.
    logical_height: i32,
};
    // rust: impl LevelShape {
    // rust: pub const OVERWORLD: Self = Self {
    // rust: sky_light: true,
    // rust: has_ceiling: false,
    // rust: min_y: MIN_Y,
    // rust: height: HEIGHT,
    // rust: logical_height: HEIGHT,
}
    // rust: pub const NETHER: Self = Self {
    // rust: sky_light: false,
    // rust: has_ceiling: true,
    // rust: min_y: 0,
    // rust: height: 256,
    // rust: logical_height: 128,
}
    // rust: pub const END: Self = Self {
    // rust: sky_light: true,
    // rust: has_ceiling: false,
    // rust: min_y: 0,
    // rust: height: 256,
    // rust: logical_height: 256,
}
    /// A dimension type's shape, checked as its codec checks it.
    // rust: pub fn new(
    // rust: min_y: i32,
    // rust: height: i32,
    // rust: logical_height: i32,
    // rust: sky_light: bool,
    // rust: has_ceiling: bool,
    // rust: ) -> Result<Self, String> {
    // rust: ColumnLayout::new(min_y, height)?;
    // rust: if !(0..=height).contains(&logical_height) {
    // rust: return Err(format!(
    // rust: "logical_height {logical_height} is outside 0..={height}"
    // rust: ));
}
    // rust: Ok(Self {
    // rust: sky_light,
    // rust: has_ceiling,
    // rust: min_y,
    // rust: height,
    // rust: logical_height,
    // rust: })
}
    /// One above the highest block (`getMaxY() + 1`).
pub fn max_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y + self.height
}
pub fn min_section(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y >> 4
}
pub fn section_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.height >> 4) as usize
}
    /// Whether section `y` (a section coordinate) is inside the level.
pub fn has_section(self: *Self, y: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.min_section()..self.min_section() + self.section_count() as i32).contains(&y)
}
    /// The sections a chunk of this level holds: the level's, widened to the
    /// vanilla Overworld's `-64..320` so that vanilla's Nether and End keep
    /// the 24 sections they have always had.
pub fn column(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ColumnLayout::of_level(self.min_y, self.height)
}
}

/// The shapes of a world's three levels, from its dimension types.
pub const LevelShapes = struct {
    overworld: LevelShape,
    nether: LevelShape,
    end: LevelShape,
};
    // rust: impl LevelShapes {
    // rust: pub const VANILLA: Self = Self {
    // rust: overworld: LevelShape::OVERWORLD,
    // rust: nether: LevelShape::NETHER,
    // rust: end: LevelShape::END,
}
    /// The shape of the level `id` (`minecraft:overworld`,
    /// `minecraft:the_nether`, `minecraft:the_end`); others get the
    /// Overworld's.
pub fn get(self: *Self, id: []const u8) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "minecraft:the_nether" => self.nether,
    // rust: "minecraft:the_end" => self.end,
    // rust: _ => self.overworld,
}
}
pub fn get_mut(self: *Self, id: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: "minecraft:the_nether" => &mut self.nether,
    // rust: "minecraft:the_end" => &mut self.end,
    // rust: _ => &mut self.overworld,
}
}
}
    // rust: impl Default for LevelShapes {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::VANILLA
}
}

/// The span of block Y a chunk holds: from `min_y`, `sections` sections up
/// (`LevelShape::column`).
pub const ColumnLayout = struct {
    min_y: i32,
    sections: usize,
};
    // rust: impl ColumnLayout {
    // rust: pub const VANILLA: Self = Self {
    // rust: min_y: MIN_Y,
    // rust: sections: SECTIONS,
}
    /// The column of a level from `min_y`, `height` high
    /// (`LevelShape::column`).
pub fn of_level(min_y: i32, height: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let low = min_y.min(MIN_Y);
    // rust: let high = (min_y + height).max(MIN_Y + HEIGHT);
    // rust: Self {
    // rust: min_y: low,
    // rust: sections: ((high - low) / 16) as usize,
}
}
    /// `DimensionType.MIN_Y`, `MAX_Y`: 12 bits of `BlockPos` Y, less 32.
pub const LOWEST_Y: i32 = -2032;
pub const HIGHEST_Y: i32 = 2031;
    /// A dimension type's `min_y` and `height`, as its codec accepts them:
    /// multiples of 16, at least 16 high, within `LOWEST_Y..=HIGHEST_Y`.
pub fn new(min_y: i32, height: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min_y % 16 != 0 || height % 16 != 0 {
    // rust: return Err(format!(
    // rust: "min_y {min_y} and height {height} must be multiples of 16"
    // rust: ));
}
    // rust: if height < 16 {
    // rust: return Err(format!("height {height} is below 16"));
}
    // rust: if min_y < Self::LOWEST_Y
    // rust: || i64::from(min_y) + i64::from(height) > i64::from(Self::HIGHEST_Y) + 1
    // rust: {
    // rust: return Err(format!(
    // rust: "min_y {min_y} with height {height} leaves {}..={}",
    // rust: Self::LOWEST_Y,
    // rust: Self::HIGHEST_Y
    // rust: ));
}
    // rust: Ok(Self {
    // rust: min_y,
    // rust: sections: (height / 16) as usize,
    // rust: })
}
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y
}
    /// One above the highest block.
pub fn max_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y + self.height()
}
pub fn height(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections as i32 * 16
}
pub fn sections(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections
}
    /// The index of the section holding block `y`, if the column holds it.
pub fn section_index(self: *Self, y: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: usize::try_from((y - self.min_y) >> 4)
    // rust: .ok()
    // rust: .filter(|&s| s < self.sections)
}
    /// The minimum block Y of section `index`.
pub fn section_y(self: *Self, index: usize) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y + index as i32 * 16
}
}
/// `true` for each section of `layout`: what callers that keep no
/// per-section record (of fluids, say) pass as "every section may have it".
pub fn every_section(layout: ColumnLayout) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: static ALL: [bool; crate::section_mask::SectionMask::CAPACITY] =
    // rust: [true; crate::section_mask::SectionMask::CAPACITY];
    // rust: &ALL[..layout.sections()]
}
    // rust: impl Default for ColumnLayout {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::VANILLA
}
}

/// Biomes are 4x4x4 containers over the biome table (67 entries: a 7-bit
/// global palette).
pub const BIOME_STRATEGY: Strategy = Strategy::biomes(8);

/// Bits of the block states' global palette: 16 for vanilla's 35,723 states
/// (what vanilla servers and clients send), more when content mods add states
/// past 65,536 (docs/modpacks.md). Set once, before the first chunk.
pub const BLOCK_BITS: std::sync::atomic::AtomicU8 = std::sync::atomic::AtomicU8::new(16);
/// States in the registry, set with [`BLOCK_BITS`].
pub const BLOCK_STATES: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(u32::MAX);

/// Block states are `PalettedContainer`s over the registry: vanilla's 16-bit
/// global palette, wider with enough content mods.
pub fn block_strategy() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Strategy::blocks(BLOCK_BITS.load(std::sync::atomic::Ordering::Relaxed))
}

/// Whether the registry has this state. Every id is known until the registry is loaded.
pub fn known_block_state(id: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: id < BLOCK_STATES.load(std::sync::atomic::Ordering::Relaxed)
}

/// A server's block container in our palette width. Ids past our registry (a
/// server or host with mods we lack) read as air: every per-state table is
/// indexed by them, and a palette's unused entries are scanned too.
pub fn known_blocks_only(blocks: PalettedContainer) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ours = block_strategy();
    // rust: let unknown = |id: u32| !known_block_state(id) || u64::from(id) >> ours.global_bits != 0;
    // rust: let any_unknown = if blocks.is_global() {
    // rust: blocks.has(unknown)
    // rust: } else {
    // rust: blocks.maybe_has(unknown)
}
    // rust: if !any_unknown && blocks.strategy().global_bits == ours.global_bits {
    // rust: return blocks;
}
    // rust: let mut values = [0u32; 4096];
    // rust: blocks.unpack(&mut values);
    // rust: for value in &mut values {
    // rust: if unknown(*value) {
    // rust: *value = 0;
}
}
    // rust: PalettedContainer::from_values(ours, &values)
}

/// Frees `columns` (`count` of them) on a short-lived thread of its own
/// when there are many: a teleport or a dimension change drops a few
/// thousand columns at once, and freeing their sections took the frame
/// 15-20 ms. A few are freed here.
    // rust: pub fn free_columns<T: Send + 'static>(columns: T, count: usize) {
    // rust: if count < 64 {
    // rust: return;
}
    // Should the thread not start, the closure drops `columns` here.
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("Chunk freeing".into())
    // rust: .spawn(move || drop(columns));
}

/// Sizes the block states' global palette for a registry of `states`.
pub fn set_block_states(states: usize) void {
}
    // rust: let bits = horizon_core::paletted::ceil_log2(states).max(16);
    // rust: BLOCK_BITS.store(bits, std::sync::atomic::Ordering::Relaxed);
    // rust: BLOCK_STATES.store(
    // rust: u32::try_from(states).unwrap_or(u32::MAX),
    // rust: std::sync::atomic::Ordering::Relaxed,
    // rust: );
    // rust: forget_shared();
}

/// One allocation per kind of uniform section (a single block, a single
/// biome and one light value), shared by every column that has it, keyed by
/// (block, biome, light). A tall column is mostly such sections: air with
/// full sky light above the terrain. Edits copy them (`Arc::make_mut`).
    // rust: type SharedSections = std::collections::HashMap<(u32, u32, u8), Arc<Section>>;
pub const SHARED: std::sync::Mutex<?SharedSections> = std::sync::Mutex::new(None);

/// Replaces the uniform sections of `sections` with the shared ones.
pub fn share_uniform(sections: *mut [*Section]) void {
}
    // rust: let key = |s: &Section| -> Option<(u32, u32, u8)> {
    // rust: let Light::Uniform(light) = s.light else {
    // rust: return None;
}
    // rust: if s.blocks.bits() != 0 || s.biomes.bits() != 0 {
    // rust: return None;
}
    // rust: Some((s.blocks.uniform()?, s.biomes.uniform()?, light))
}
    // rust: let Ok(mut shared) = SHARED.lock() else {
    // rust: return;
}
    // rust: let shared = shared.get_or_insert_with(Default::default);
    // rust: for section in sections {
    // rust: let Some(k) = key(section) else {
    // rust: continue;
}
    // rust: let one = shared.entry(k).or_insert_with(|| section.clone());
    // rust: if !Arc::ptr_eq(one, section) {
    // rust: *section = one.clone();
}
}
}

/// Forgets the shared sections, when the palette changes.
pub fn forget_shared() void {
}
    // rust: if let Ok(mut shared) = SHARED.lock() {
    // rust: *shared = None;
}
}
/// Packed light per block: sky light in the high nibble, block light in the
/// low one. A section keeps only the kind of light that varies in it
/// (`Light::packed`): most sections have no block light and only sky light
/// that changes, or the reverse below ground.
pub const Light = enum {
    Uniform(u8),
    /// Sky light per block, as nibbles (block `i` in byte `i / 2`, the even
    /// one in the low nibble, as a vanilla DataLayer), and one block light.
    Sky(Box<[u8; 2048]>, u8),
    /// Block light per block, as nibbles, and one sky light.
    Block(Box<[u8; 2048]>, u8),
    Full(Box<[u8; 4096]>),
};
pub fn nibble(layer: *[u8; 2048], i: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: layer[i >> 1] >> ((i & 1) << 2) & 15
}
    // rust: impl Light {
pub fn get(self: *Self, i: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Uniform(v) => *v,
    // rust: Self::Sky(layer, block) => nibble(layer, i) << 4 | block,
    // rust: Self::Block(layer, sky) => sky << 4 | nibble(layer, i),
    // rust: Self::Full(a) => a[i],
}
}
    /// The smallest form of packed light per block.
pub fn packed(light: *[u8; 4096]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let first = light[0];
    // rust: let (mut sky_varies, mut block_varies) = (false, false);
    // rust: for &v in light.iter() {
    // rust: let d = v ^ first;
    // rust: sky_varies |= d & 0xF0 != 0;
    // rust: block_varies |= d & 15 != 0;
}
    // rust: let layer = |shift: u32| {
    // rust: let mut layer = Box::new([0u8; 2048]);
    // rust: for (out, pair) in layer.iter_mut().zip(light.as_chunks::<2>().0) {
    // rust: *out = (pair[0] >> shift & 15) | (pair[1] >> shift & 15) << 4;
}
    // rust: layer
}
    // rust: match (sky_varies, block_varies) {
    // rust: (false, false) => Self::Uniform(first),
    // rust: (true, false) => Self::Sky(layer(4), first & 15),
    // rust: (false, true) => Self::Block(layer(0), first >> 4),
    // rust: (true, true) => Self::Full(light),
}
}
    /// The packed light of blocks `at..at + out.len()`, into `out`.
pub fn copy_run(self: *Self, at: usize, out: []u8) void {
}
    // rust: match self {
    // rust: Self::Uniform(v) => out.fill(*v),
    // rust: Self::Full(a) => out.copy_from_slice(&a[at..at + out.len()]),
    // rust: Self::Sky(layer, block) => {
    // rust: for (k, o) in out.iter_mut().enumerate() {
    // rust: *o = nibble(layer, at + k) << 4 | block;
}
}
    // rust: Self::Block(layer, sky) => {
    // rust: for (k, o) in out.iter_mut().enumerate() {
    // rust: *o = sky << 4 | nibble(layer, at + k);
}
}
}
}
    /// The packed light of every block, in index order.
pub fn to_array(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Full(a) => a.clone(),
    // rust: Self::Uniform(v) => Box::new([*v; 4096]),
    // rust: _ => Box::new(std::array::from_fn(|i| self.get(i))),
}
}
    /// Whether any block's packed light has a bit of `mask` set.
pub fn any(self: *Self, mask: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let layer_any = |layer: &[u8; 2048]| layer.iter().any(|&v| v != 0);
    // rust: match self {
    // rust: Self::Uniform(v) => v & mask != 0,
    // rust: Self::Sky(layer, block) => block & mask != 0 || (mask & 0xF0 != 0 && layer_any(layer)),
    // rust: Self::Block(layer, sky) => {
    // rust: (sky << 4) & mask != 0 || (mask & 15 != 0 && layer_any(layer))
}
    // rust: Self::Full(a) => a.iter().any(|v| v & mask != 0),
}
}
    /// Whether any block's packed light differs from `v` in the bits of `mask`.
pub fn any_not(self: *Self, mask: u8, v: u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Uniform(u) => (u ^ v) & mask != 0,
    // rust: Self::Full(a) => a.iter().any(|u| (u ^ v) & mask != 0),
    // rust: _ => (0..4096).any(|i| (self.get(i) ^ v) & mask != 0),
}
}
    /// Heap bytes it holds.
pub fn heap_bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Uniform(_) => 0,
    // rust: Self::Sky(..) | Self::Block(..) => 2048,
    // rust: Self::Full(_) => 4096,
}
}
    /// Whether every block's light is the same as in `other`.
pub fn same_as(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (self, other) {
    // rust: (Self::Uniform(a), Self::Uniform(b)) => a == b,
    // rust: (Self::Full(a), Self::Full(b)) => a == b,
    // rust: (Self::Sky(a, x), Self::Sky(b, y)) | (Self::Block(a, x), Self::Block(b, y)) => {
    // rust: x == y && a == b
}
    // rust: _ => (0..4096).all(|i| self.get(i) == other.get(i)),
}
}
}
pub fn column(x: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((z & 15) << 4 | (x & 15)) as usize
}
pub fn index(x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((y & 15) << 8 | (z & 15) << 4 | (x & 15)) as usize
}
pub const Section = struct {
    blocks: PalettedContainer,
    /// Biome table index per 4x4x4 cell, `(y << 2 | z) << 2 | x`.
    biomes: PalettedContainer,
    light: Light,
};
    // rust: impl Default for Section {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: blocks: PalettedContainer::new(block_strategy(), 0),
    // rust: biomes: PalettedContainer::new(BIOME_STRATEGY, 0),
    // rust: light: Light::Uniform(0xF0),
}
}
}
    // rust: impl Section {
pub fn get(self: *Self, i: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.get(i)
}
pub fn set(self: *Self, i: usize, v: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.set(i, v)
}
    /// All 4,096 block states in index order.
pub fn unpack(self: *Self, out: *mut [u32; 4096]) void {
}
    // rust: self.blocks.unpack(out);
}
    /// The block states of a whole section at once.
pub fn from_blocks(values: *[u32; 4096]) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PalettedContainer::from_values(block_strategy(), values)
}
pub fn light(self: *Self, i: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.light.get(i)
}
pub fn is_uniform(self: *Self, v: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.is_uniform(v)
}
    /// Whether every block, biome and light value is the same as `other`'s.
pub fn same_as(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks == other.blocks
    // rust: && self.biomes == other.biomes
    // rust: && self.light.same_as(&other.light)
}
    /// Heap bytes held by the block, biome and light storage (benchmark accounting).
pub fn heap_bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.heap_bytes() + self.biomes.heap_bytes() + self.light.heap_bytes()
}
    /// Collapse storage that became uniform, and drop palette entries no
    /// block uses any more.
pub fn compact(self: *Self) void {
}
    // rust: for container in [&mut self.blocks, &mut self.biomes] {
    // rust: if container.bits() != 0
    // rust: && let Some(v) = container.uniform()
    // rust: {
    // rust: *container = PalettedContainer::new(container.strategy(), v);
}
}
        // Only the kind of light that varies is kept.
    // rust: if matches!(self.light, Light::Full(_)) {
    // rust: let Light::Full(a) = std::mem::replace(&mut self.light, Light::Uniform(0)) else {
    // rust: unreachable!()
}
    // rust: self.light = Light::packed(a);
}
}
}
/// The heap bytes of a set of columns by what holds them (`Chunk::census`,
/// `horizon-ctl memory`).
pub const ColumnCensus = struct {
    columns: usize,
    /// Section slots of every column, shared ones included.
    sections: usize,
    /// Distinct section allocations.
    unique_sections: usize,
    /// Distinct sections of a single block state (no data array).
    uniform_block_sections: usize,
    /// Distinct sections with light per block (not one value).
    light_arrays: usize,
    block_bytes: usize,
    biome_bytes: usize,
    light_bytes: usize,
    heightmap_bytes: usize,
    /// The section records themselves (`Arc<Section>`).
    section_record_bytes: usize,
    /// The column records and their lists of sections.
    column_bytes: usize,
};
    // rust: impl ColumnCensus {
pub fn total_bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_bytes
    // rust: + self.biome_bytes
    // rust: + self.light_bytes
    // rust: + self.heightmap_bytes
    // rust: + self.section_record_bytes
    // rust: + self.column_bytes
}
}
pub const Chunk = struct {
    x: i32,
    z: i32,
    /// The minimum block Y of `sections[0]` (the layout's when it was made).
    min_y: i32,
    sections: std.ArrayList(*Section),
    /// `Heightmap.Types.WORLD_SURFACE` per column (`z << 4 | x`): one above
    /// the highest non-air block, or the column's minimum Y. Built on the first read; a
    /// `set` that can move a column's surface drops it.
    surface: OnceLock<Box<[i16,
    /// `Heightmap.Types.MOTION_BLOCKING` per column, kept like `surface`.
    motion_blocking: OnceLock<Box<[i16,
    lit: bool,
    /// Light read from a save with `isLightOn`: no light job is needed.
    light_loaded: bool,
    /// Newly generated (not loaded from a save): eligible for generation-time spawns.
    fresh: bool,
    /// Finished from a proto chunk just now, in any kind of world, not read
    /// from a save (`ChunkEvent.Load`'s `isNewChunk`).
    generated: bool,
    /// Block entities read from a save, moved into the world on arrival.
    block_entities: Vec<((i32,
    /// `CustomName` of the container block entities (shown as the screen title).
    block_names: Vec<((i32,
    /// Generation postprocessing marks (ProtoChunk.postProcessing) as world
    /// positions, applied once by LevelChunk.postProcessGeneration.
    postprocess: Vec<[i32,
    /// Saved data Horizon keeps but does not simulate (save.rs).
    saved: ?*ChunkExtras,
    /// Entities read from a save (vanilla entity NBT), spawned on arrival.
    entities: std.ArrayList(horizon_world::nbt::Tag),
    /// Structure starts reaching into this chunk (`structures.References`):
    /// structure id and the start's chunk.
    structure_refs: std.ArrayList((Arc<str),
    /// The starts generation made in this chunk (`structures.starts`), saved
    /// with the state their placement has reached by then.
    structure_starts: std.ArrayList(*horizon_world::worldgen::structure::start::StructureStart),
};
    // rust: impl Chunk {
    /// An all-air chunk in the current `layout`.
pub fn empty(x: i32, z: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_layout(x, z, ColumnLayout::VANILLA)
}
pub fn with_layout(x: i32, z: i32, layout: ColumnLayout) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut one = [Arc::new(Section::default())];
    // rust: share_uniform(&mut one);
    // rust: let [empty] = one;
    // rust: Self {
    // rust: x,
    // rust: z,
    // rust: min_y: layout.min_y(),
    // rust: sections: (0..layout.sections()).map(|_| empty.clone()).collect(),
    // rust: surface: OnceLock::new(),
    // rust: motion_blocking: OnceLock::new(),
    // rust: lit: false,
    // rust: light_loaded: false,
    // rust: fresh: false,
    // rust: generated: false,
    // rust: block_entities: Vec::new(),
    // rust: block_names: Vec::new(),
    // rust: structure_refs: Vec::new(),
    // rust: structure_starts: Vec::new(),
    // rust: postprocess: Vec::new(),
    // rust: saved: None,
    // rust: entities: Vec::new(),
}
}
    /// The minimum block Y of the column.
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y
}
    /// The column the chunk holds.
pub fn layout(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ColumnLayout {
    // rust: min_y: self.min_y,
    // rust: sections: self.sections.len(),
}
}
    /// One above the column's highest block.
pub fn max_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y + self.sections.len() as i32 * 16
}
    /// The index of the section holding block `y`, if the column holds it.
pub fn section_index(self: *Self, y: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: usize::try_from((y - self.min_y) >> 4)
    // rust: .ok()
    // rust: .filter(|&s| s < self.sections.len())
}
pub fn get(self: *Self, x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.section_index(y) {
    // rust: Some(s) => self.sections[s].get(index(x, y, z)),
    // rust: None => 0,
}
}
pub fn block(self: *Self, x: i32, y: i32, z: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockStateId(self.get(x, y, z))
}
    /// The highest y where `matches`, scanning down. Sections holding only
    /// `skip` are passed over whole: `matches` must be false for it.
pub fn highest(self: *Self, skip: u32, mut matches: impl FnMut(i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections
    // rust: .iter()
    // rust: .enumerate()
    // rust: .rev()
    // rust: .filter(|(_, section)| !section.is_uniform(skip))
    // rust: .find_map(|(s, _)| {
    // rust: let base = self.min_y + s as i32 * 16;
    // rust: (base..base + 16).rev().find(|&y| matches(y))
    // rust: })
}
pub fn set(self: *Self, x: i32, y: i32, z: i32, v: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(s) = self.section_index(y) else {
    // rust: return v;
}
    // rust: let previous = Arc::make_mut(&mut self.sections[s]).set(index(x, y, z), v);
        // `Heightmap.update`: a write two or more below a map's height can't
        // move it. Any other change rebuilds that map on the next read.
    // rust: if previous != v {
    // rust: for map in [&mut self.surface, &mut self.motion_blocking] {
    // rust: if map
    // rust: .get()
    // rust: .is_some_and(|heights| y >= i32::from(heights[column(x, z)]) - 1)
    // rust: {
    // rust: *map = OnceLock::new();
}
}
}
    // rust: previous
}
    /// Section `s`'s block states replaced whole (a bulk edit): its storage
    /// compacted, and the heightmaps built again on their next read.
pub fn replace_blocks(self: *Self, s: usize, values: *[u32; 4096]) void {
}
    // rust: let section = Arc::make_mut(&mut self.sections[s]);
    // rust: section.blocks = Section::from_blocks(values);
    // rust: section.compact();
    // rust: self.surface = OnceLock::new();
    // rust: self.motion_blocking = OnceLock::new();
}
    /// `getHeight(Heightmap.Types.WORLD_SURFACE, x, z)` (`x`, `z` within the
    /// chunk): one above the highest block that isn't `air`, or the column's
    /// minimum Y.
    /// Sections must change only through `set` once this has been read.
pub fn world_surface(self: *Self, x: i32, z: i32, air: impl Fn(u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let surface = self.surface.get_or_init(|| self.prime(|v| !air(v)));
    // rust: i32::from(surface[column(x, z)])
}
    /// `getHeight(Heightmap.Types.MOTION_BLOCKING, x, z)` (`x`, `z` within
    /// the chunk): one above the highest state where `blocks` (a motion
    /// blocking block or a fluid), or the column's minimum Y. Kept as
    /// `world_surface` is.
pub fn motion_blocking(self: *Self, x: i32, z: i32, blocks: impl Fn(u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let heights = self.motion_blocking.get_or_init(|| self.prime(blocks));
    // rust: i32::from(heights[column(x, z)])
}
    /// `Heightmap.primeHeightmaps`: each section from the top, skipping
    /// those of one state that doesn't count, until every column is found.
pub fn prime(self: *Self, counts: impl Fn(u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut surface = Box::new([self.min_y as i16; 256]);
    // rust: let mut found = [false; 256];
    // rust: let mut left = 256;
    // rust: let mut values = [0u32; 4096];
    // rust: for (s, section) in self.sections.iter().enumerate().rev() {
    // rust: if left == 0 {
    // rust: break;
}
    // rust: if section.blocks.uniform().is_some_and(|v| !counts(v)) {
    // rust: continue;
}
    // rust: section.unpack(&mut values);
    // rust: let base = self.min_y + s as i32 * 16;
    // rust: for i in 0..256 {
    // rust: if found[i] {
    // rust: continue;
}
    // rust: if let Some(dy) = (0..16).rev().find(|&dy| counts(values[dy << 8 | i])) {
    // rust: surface[i] = (base + dy as i32 + 1) as i16;
    // rust: found[i] = true;
    // rust: left -= 1;
}
}
}
    // rust: surface
}
pub fn light(self: *Self, x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.section_at(y) {
    // rust: Ok(section) => section.light(index(x, y, z)),
    // rust: Err(light) => light,
}
}
    /// The section holding block height `y`, or the light of the air outside the
    /// column's sections there: none below them, full sky above.
pub fn section_at(self: *Self, y: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.section_index(y) {
    // rust: Some(s) => Ok(&self.sections[s]),
    // rust: None if y < self.min_y => Err(0),
    // rust: None => Err(0xF0),
}
}
    /// Heap bytes held by the sections (benchmark accounting).
pub fn heap_bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sections.iter().map(|s| s.heap_bytes()).sum::<usize>()
}
    /// Adds this column's heap bytes to `census` by what holds them. A
    /// section shared with another column (`share_uniform`, or a copy not yet
    /// written to) counts once: `seen` holds the sections counted so far.
    // rust: pub fn census(
    // rust: &self,
    // rust: census: &mut ColumnCensus,
    // rust: seen: &mut crate::fast_hash::FxHashSet<*const Section>,
    // rust: ) {
    // rust: census.columns += 1;
    // rust: census.sections += self.sections.len();
    // rust: census.column_bytes += std::mem::size_of::<Self>()
    // rust: + self.sections.capacity() * std::mem::size_of::<Arc<Section>>();
    // rust: census.heightmap_bytes += [&self.surface, &self.motion_blocking]
    // rust: .iter()
    // rust: .filter(|map| map.get().is_some())
    // rust: .count()
    // rust: * std::mem::size_of::<[i16; 256]>();
    // rust: for section in &self.sections {
    // rust: if !seen.insert(Arc::as_ptr(section)) {
    // rust: continue;
}
    // rust: census.unique_sections += 1;
            // The `Arc`'s two counts and the section record.
    // rust: census.section_record_bytes +=
    // rust: 2 * std::mem::size_of::<usize>() + std::mem::size_of::<Section>();
    // rust: if section.blocks.bits() == 0 {
    // rust: census.uniform_block_sections += 1;
}
    // rust: census.block_bytes += section.blocks.heap_bytes();
    // rust: census.biome_bytes += section.biomes.heap_bytes();
    // rust: if section.light.heap_bytes() != 0 {
    // rust: census.light_arrays += 1;
    // rust: census.light_bytes += section.light.heap_bytes();
}
}
}
    /// Biome table index at a block position (`ChunkAccess.getNoiseBiome` with
    /// the quart y clamped to the column).
pub fn biome(self: *Self, x: i32, y: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let qy = ((y - self.min_y) >> 2).clamp(0, self.sections.len() as i32 * 4 - 1);
    // rust: self.sections[(qy >> 2) as usize]
    // rust: .biomes
    // rust: .get(((qy & 3) << 4 | ((z & 15) >> 2) << 2 | (x & 15) >> 2) as usize) as u16
}
    /// Sets the biome of one quart cell (`qy` counts from the column's bottom).
pub fn set_biome_cell(self: *Self, qx: i32, qy: i32, qz: i32, biome: u16) void {
}
    // rust: let section = Arc::make_mut(&mut self.sections[(qy >> 2) as usize]);
    // rust: section.biomes.set(
    // rust: ((qy & 3) << 4 | (qz & 3) << 2 | (qx & 3)) as usize,
    // rust: u32::from(biome),
    // rust: );
}
}

/// A proto chunk saved before it became final. Decoration writes into a
/// chunk's neighbours, and decorated chunks wait for theirs, so the chunks
/// past the finished ones hold writes that generating them again would lose
/// (whole structure pieces, trees, ores). Vanilla saves its proto chunks too.
pub const SavedProto = struct {
    /// Blocks, scheduled ticks (in `saved`) and post-processing marks.
    column: Chunk,
    /// Decorated itself (`features`), not only written to by its neighbours
    /// (`terrain`).
    decorated: bool,
    /// Block entity data in placement order, with `x`, `y` and `z`.
    block_entities: std.ArrayList(Tag),
    /// Entities placed by structures, with absolute `Pos`.
    entities: std.ArrayList(Tag),
};

/// A container's loot table and what Horizon rolled from it. Vanilla keeps
/// `LootTable` and `LootTableSeed` until the container is first opened;
/// Horizon rolls when it generates or loads the chunk, and saves the table
/// again while the container still holds exactly the rolled items.
pub const RolledLoot = struct {
    pos: (i32,
    table: []const u8,
    /// The saved `LootTableSeed`, written back unless 0 (trySaveLootTable).
    seed: ?i64,
    /// The rolled `Items`.
    items: Tag,
};
    // rust: impl RolledLoot {
    /// Puts the loot table back in place of `Items` while they are still the
    /// roll; false once the container holds anything else.
pub fn restore(self: *Self, map: *mut Compound) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if map.get(&"Items".into()) != Some(&self.items) {
    // rust: return false;
}
    // rust: map.remove(&"Items".into());
    // rust: map.insert("LootTable".into(), Tag::String(self.table.as_str().into()));
    // rust: if let Some(seed) = self.seed.filter(|s| *s != 0) {
    // rust: map.insert("LootTableSeed".into(), Tag::Long(seed));
}
    // rust: true
}
}

/// Save data loaded with a chunk that Horizon keeps but does not simulate.
pub const ChunkExtras = struct {
    /// Server-owned mod data attached to this chunk.
    attachments: horizon_world::attachments::Attachments,
    /// Attachment maps of the chunk's block entities, on a save snapshot.
    block_entity_attachments: Vec<((i32,
    /// Chunk root keys written back as loaded (structures, PostProcessing,
    /// InhabitedTime, blending data, ...).
    root: Compound,
    /// Block entities Horizon does not model.
    block_entities: std.ArrayList(Tag),
    /// The NBT of the modelled block entities as loaded, to restore the fields and
    /// detail Horizon does not model when it saves them (`block_entity_nbt::overlay`).
    block_entity_sources: Vec<((i32,
    /// Every saved block entity's position in the order of the save's list,
    /// the order `SerializableChunkData` puts them in the chunk's maps.
    block_entity_order: Vec<(i32,
    /// Scheduled ticks (`block_ticks`/`fluid_ticks`): delays relative to the
    /// save time. Registered with the level's tick scheduler on arrival and
    /// replaced with the scheduler's pending ticks when saving.
    block_ticks: std.ArrayList(horizon_core::ticks::SavedTick),
    fluid_ticks: std.ArrayList(horizon_core::ticks::SavedTick),
    /// Game time written as `LastUpdate`.
    last_update: i64,
    /// Containers still holding their loot table's roll.
    rolled_loot: std.ArrayList(RolledLoot),
};

    // rust: mod tests {
//     use super::*;
pub fn each_light_form_keeps_every_value_and_run() void {
}
        // Sky varies alone, block varies alone, both, neither.
    // rust: let cases: [(fn(usize) -> u8, &str); 4] = [
    // rust: (|i| ((i % 16) as u8) << 4 | 3, "sky"),
    // rust: (|i| 0xA0 | (i / 256) as u8, "block"),
    // rust: (|i| (i % 251) as u8, "full"),
    // rust: (|_| 0x7C, "uniform"),
    // rust: ];
    // rust: for (value, name) in cases {
    // rust: let light = Light::packed(Box::new(std::array::from_fn(value)));
    // rust: let form = match light {
    // rust: Light::Sky(..) => "sky",
    // rust: Light::Block(..) => "block",
    // rust: Light::Full(_) => "full",
    // rust: Light::Uniform(_) => "uniform",
}
    // rust: assert_eq!(form, name);
    // rust: for at in [0, 17, 1000, 4078] {
    // rust: let mut run = [0u8; 18];
    // rust: light.copy_run(at, &mut run);
    // rust: let expected: Vec<u8> = (at..at + 18).map(value).collect();
    // rust: assert_eq!(run.as_slice(), expected, "{name} at {at}");
    // rust: assert_eq!(light.get(at + 5), value(at + 5), "{name}");
}
}
}
pub fn highest_skips_only_sections_that_cannot_match() void {
}
    // rust: let (air, cave_air, stone) = (0, 7, 1);
    // rust: let mut chunk = Chunk::empty(0, 0);
        // Stone low down, cave air (uniform in its section) above it, and a
        // section of air with one stone block higher up.
    // rust: for y in MIN_Y..MIN_Y + 40 {
    // rust: chunk.set(3, y, 4, stone);
}
    // rust: for i in 0..4096 {
    // rust: Arc::make_mut(&mut chunk.sections[5]).set(i, cave_air);
}
    // rust: chunk.set(3, 150, 4, stone);
    // rust: let full = |c: &Chunk, matches: &dyn Fn(u32) -> bool| {
    // rust: (MIN_Y..MIN_Y + HEIGHT)
    // rust: .rev()
    // rust: .find(|&y| matches(c.get(3, y, 4)))
}
    // rust: for matches in [
    // rust: &(|v: u32| v != air) as &dyn Fn(u32) -> bool,
    // rust: &|v: u32| v == stone,
    // rust: &|v: u32| v == cave_air,
    // rust: ] {
    // rust: let fast = chunk.highest(air, |y| matches(chunk.get(3, y, 4)));
    // rust: assert_eq!(fast, full(&chunk, matches));
}
    // rust: assert_eq!(
    // rust: chunk.highest(air, |y| chunk.get(3, y, 4) == stone),
    // rust: Some(150)
    // rust: );
    // rust: assert_eq!(Chunk::empty(0, 0).highest(air, |_| unreachable!()), None);
}
    /// The kept WORLD_SURFACE heights match a scan of every column after
    /// each of a few thousand writes (air, cave air, stone, whole sections).
pub fn world_surface_follows_writes() void {
}
    // rust: let (air, cave_air, stone) = (0, 7, 1);
    // rust: let is_air = |v: u32| v == air || v == cave_air;
    // rust: let scan = |c: &Chunk, x: i32, z: i32| {
    // rust: (MIN_Y..MIN_Y + HEIGHT)
    // rust: .rev()
    // rust: .find(|&y| !is_air(c.get(x, y, z)))
    // rust: .map_or(MIN_Y, |y| y + 1)
}
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: assert_eq!(chunk.world_surface(5, 5, is_air), MIN_Y);
    // rust: for y in MIN_Y..MIN_Y + 70 {
    // rust: for i in 0..256 {
    // rust: chunk.set(i & 15, y, i >> 4, stone);
}
}
    // rust: for i in 0..4096 {
    // rust: Arc::make_mut(&mut chunk.sections[8]).set(i, cave_air);
}
    // rust: let mut random = horizon_core::random::LegacyRandom::new(9);
//         use horizon_core::random::RandomSource;
    // rust: for step in 0..4000 {
    // rust: let x = random.next_int_bound(16).unwrap();
    // rust: let z = random.next_int_bound(16).unwrap();
    // rust: let y = MIN_Y + 40 + random.next_int_bound(120).unwrap();
    // rust: let v = [air, cave_air, stone][random.next_int_bound(3).unwrap() as usize];
    // rust: chunk.set(x, y, z, v);
    // rust: if step % 7 == 0 {
    // rust: for i in 0..256 {
    // rust: assert_eq!(
    // rust: chunk.world_surface(i & 15, i >> 4, is_air),
    // rust: scan(&chunk, i & 15, i >> 4)
    // rust: );
}
}
}
        // Out-of-range writes and unchanged states keep the map.
    // rust: let before = chunk.world_surface(3, 3, is_air);
    // rust: chunk.set(3, MIN_Y + HEIGHT, 3, stone);
    // rust: chunk.set(3, before - 1, 3, chunk.get(3, before - 1, 3));
    // rust: assert!(chunk.surface.get().is_some());
    // rust: assert_eq!(chunk.world_surface(3, 3, |_| unreachable!()), before);
}
    /// MOTION_BLOCKING ignores states that don't count (air, grass) and
    /// follows writes as the surface map does, both maps kept at once.
pub fn motion_blocking_follows_writes() void {
}
    // rust: let (air, grass, water, stone) = (0, 3, 5, 1);
    // rust: let blocks = |v: u32| v == water || v == stone;
    // rust: let scan = |c: &Chunk, x: i32, z: i32| {
    // rust: (MIN_Y..MIN_Y + HEIGHT)
    // rust: .rev()
    // rust: .find(|&y| blocks(c.get(x, y, z)))
    // rust: .map_or(MIN_Y, |y| y + 1)
}
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: assert_eq!(chunk.motion_blocking(5, 5, blocks), MIN_Y);
    // rust: for y in MIN_Y..MIN_Y + 70 {
    // rust: for i in 0..256 {
    // rust: chunk.set(i & 15, y, i >> 4, stone);
}
}
    // rust: for i in 0..4096 {
    // rust: Arc::make_mut(&mut chunk.sections[8]).set(i, grass);
}
    // rust: let mut random = horizon_core::random::LegacyRandom::new(11);
//         use horizon_core::random::RandomSource;
    // rust: for step in 0..4000 {
    // rust: let x = random.next_int_bound(16).unwrap();
    // rust: let z = random.next_int_bound(16).unwrap();
    // rust: let y = MIN_Y + 40 + random.next_int_bound(120).unwrap();
    // rust: let v = [air, grass, water, stone][random.next_int_bound(4).unwrap() as usize];
    // rust: chunk.set(x, y, z, v);
    // rust: if step % 7 == 0 {
    // rust: for i in 0..256 {
    // rust: assert_eq!(
    // rust: chunk.motion_blocking(i & 15, i >> 4, blocks),
    // rust: scan(&chunk, i & 15, i >> 4)
    // rust: );
    // rust: chunk.world_surface(i & 15, i >> 4, |v| v == air);
}
}
}
}

pub fn shapes_follow_the_dimension_type_codec() void {
}
    // rust: assert_eq!(ColumnLayout::new(-64, 384), Ok(ColumnLayout::VANILLA));
    // rust: assert_eq!(ColumnLayout::default(), ColumnLayout::VANILLA);
        // To The Max's Overworld: the highest top vanilla allows.
    // rust: let tall = ColumnLayout::new(-64, 2096).unwrap();
    // rust: assert_eq!((tall.sections(), tall.max_y()), (131, 2032));
    // rust: assert!(ColumnLayout::new(-2032, 4064).is_ok());
    // rust: for (min_y, height) in [(-64, 2112), (-2048, 64), (-60, 384), (0, 250), (0, 0)] {
    // rust: assert!(
    // rust: ColumnLayout::new(min_y, height).is_err(),
    // rust: "{min_y} {height}"
    // rust: );
}
    // rust: assert_eq!(tall.section_index(-65), None);
    // rust: assert_eq!(tall.section_index(-64), Some(0));
    // rust: assert_eq!(tall.section_index(2031), Some(130));
    // rust: assert_eq!(tall.section_index(2032), None);
    // rust: assert_eq!(tall.section_y(130), 2016);
    // rust: assert_eq!(
    // rust: LevelShape::new(-64, 384, 384, true, false),
    // rust: Ok(LevelShape::OVERWORLD)
    // rust: );
    // rust: assert_eq!(
    // rust: LevelShape::new(0, 256, 128, false, true),
    // rust: Ok(LevelShape::NETHER)
    // rust: );
    // rust: assert!(LevelShape::new(0, 256, 257, true, false).is_err());
    // rust: assert!(LevelShape::new(-60, 384, 384, true, false).is_err());
}

pub fn vanilla_levels_keep_the_overworld_column() void {
}
    // rust: for shape in [LevelShape::OVERWORLD, LevelShape::NETHER, LevelShape::END] {
    // rust: assert_eq!(shape.column(), ColumnLayout::VANILLA, "{shape:?}");
}
    // rust: let tall = LevelShape::new(-64, 2096, 2096, true, false).unwrap();
    // rust: assert_eq!(tall.column(), ColumnLayout::new(-64, 2096).unwrap());
    // rust: let deep = LevelShape::new(-512, 256, 256, false, true).unwrap();
    // rust: assert_eq!(deep.column(), ColumnLayout::new(-512, 832).unwrap());
    // rust: assert!(LevelShape::NETHER.has_section(15) && !LevelShape::NETHER.has_section(16));
    // rust: assert!(!LevelShape::NETHER.has_section(-1));
}

pub fn a_tall_column_stores_its_whole_height() void {
}
    // rust: let layout = ColumnLayout::new(-64, 2096).unwrap();
    // rust: let mut chunk = Chunk::with_layout(0, 0, layout);
    // rust: assert_eq!(
    // rust: (chunk.min_y(), chunk.max_y(), chunk.sections.len()),
    // rust: (-64, 2032, 131)
    // rust: );
    // rust: let stone = 1;
    // rust: assert_eq!(chunk.set(5, 2031, 6, stone), 0);
    // rust: assert_eq!(chunk.set(5, 2032, 6, stone), stone, "above the column");
    // rust: assert_eq!(chunk.get(5, 2031, 6), stone);
    // rust: assert_eq!(chunk.get(5, 2032, 6), 0);
    // rust: assert_eq!(chunk.world_surface(5, 6, |v| v == 0), 2032);
    // rust: assert_eq!(chunk.world_surface(0, 0, |v| v == 0), -64);
    // rust: assert_eq!(chunk.highest(0, |y| y < 1000), None);
    // rust: chunk.set(5, 999, 6, stone);
    // rust: assert_eq!(chunk.highest(0, |y| y < 1000), Some(999));
    // rust: assert_eq!(chunk.light(0, 2100, 0), 0xF0);
    // rust: assert_eq!(chunk.light(0, -65, 0), 0);
    // rust: chunk.set_biome_cell(0, 130 * 4 + 3, 0, 9);
    // rust: assert_eq!(chunk.biome(0, 5000, 0), 9);
}
}
