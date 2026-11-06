//! Transpiled from Horizon Rust crate
//! Module: horizon-client_chunks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Encoding resident chunks for the wire: ClientboundLevelChunkWithLightPacket
//! (sections with their paletted containers, block entities and the sky and
//! block DataLayers) and the section block-change batches.
// use crate::{
    // rust: chunk::{Chunk, ColumnLayout, LevelShape, Light, Section},
    // rust: containers::{BlockEntity, ModBlockEntity},
    // rust: fast_hash::FxHashMap,
    // rust: mobs::spawner::{SpawnDataExt, SpawnerExt},
    // rust: section_mask::SectionMask,
}
// use horizon_protocol::{
    // rust: buf::{BitSet, Codec, List, Writer, set_bit},
    // rust: chunk::{
    // rust: BIOMES, BLOCKS, BlockEntityInfo, ChunkData, Heightmaps, LightData, Paletted, Strategy,
    // rust: },
    // rust: packets::play::{ChunkBiomeData, LevelChunkWithLight},
    // rust: registry::{Builtin, ceil_log2},
}
// use horizon_world::nbt::{Compound, Tag};
// use std::{
    // rust: collections::HashMap,
    // rust: sync::{
    // rust: Arc, OnceLock,
    // rust: atomic::{AtomicUsize, Ordering},
    // rust: },
}

pub const NON_AIR: u8 = 1;
pub const FLUID: u8 = 2;
pub const ENTITY: u8 = 4;

/// A mod block entity's update tag (`BlockEntity.getUpdateTag`), what
/// clients get of it; none sends no tag.
    // rust: pub type ModUpdateTag = fn([i32; 3], &ModBlockEntity) -> Option<Compound>;

/// The vanilla block entity type of a block (BlockEntityType.validBlocks).
pub fn block_entity_type(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = name.strip_prefix("minecraft:")?;
    // rust: Some(match n {
    // rust: "chest" => "minecraft:chest",
    // rust: "trapped_chest" => "minecraft:trapped_chest",
    // rust: "ender_chest" => "minecraft:ender_chest",
    // rust: "barrel" => "minecraft:barrel",
    // rust: "furnace" => "minecraft:furnace",
    // rust: "blast_furnace" => "minecraft:blast_furnace",
    // rust: "smoker" => "minecraft:smoker",
    // rust: "hopper" => "minecraft:hopper",
    // rust: "dispenser" => "minecraft:dispenser",
    // rust: "dropper" => "minecraft:dropper",
    // rust: "brewing_stand" => "minecraft:brewing_stand",
    // rust: "beacon" => "minecraft:beacon",
    // rust: "bell" => "minecraft:bell",
    // rust: "campfire" | "soul_campfire" => "minecraft:campfire",
    // rust: "enchanting_table" => "minecraft:enchanting_table",
    // rust: "jukebox" => "minecraft:jukebox",
    // rust: "lectern" => "minecraft:lectern",
    // rust: "spawner" => "minecraft:mob_spawner",
    // rust: "comparator" => "minecraft:comparator",
    // rust: "daylight_detector" => "minecraft:daylight_detector",
    // rust: "conduit" => "minecraft:conduit",
    // rust: "decorated_pot" => "minecraft:decorated_pot",
    // rust: "moving_piston" => "minecraft:piston",
    // rust: "structure_block" => "minecraft:structure_block",
    // rust: "jigsaw" => "minecraft:jigsaw",
    // rust: "command_block" | "chain_command_block" | "repeating_command_block" => {
    // rust: "minecraft:command_block"
}
    // rust: "end_portal" => "minecraft:end_portal",
    // rust: "end_gateway" => "minecraft:end_gateway",
    // rust: "sculk_sensor" => "minecraft:sculk_sensor",
    // rust: "calibrated_sculk_sensor" => "minecraft:calibrated_sculk_sensor",
    // rust: "sculk_catalyst" => "minecraft:sculk_catalyst",
    // rust: "sculk_shrieker" => "minecraft:sculk_shrieker",
    // rust: "crafter" => "minecraft:crafter",
    // rust: "potent_sulfur" => "minecraft:potent_sulfur",
    // rust: "chiseled_bookshelf" => "minecraft:chiseled_bookshelf",
    // rust: "trial_spawner" => "minecraft:trial_spawner",
    // rust: "vault" => "minecraft:vault",
    // rust: "beehive" | "bee_nest" => "minecraft:beehive",
    // rust: "suspicious_sand" | "suspicious_gravel" => "minecraft:brushable_block",
    // rust: "creaking_heart" => "minecraft:creaking_heart",
    // rust: "test_block" => "minecraft:test_block",
    // rust: "test_instance_block" => "minecraft:test_instance_block",
    // rust: n if n.ends_with("shulker_box") => "minecraft:shulker_box",
    // rust: n if n.ends_with("_wall_hanging_sign") || n.ends_with("_hanging_sign") => {
    // rust: "minecraft:hanging_sign"
}
    // rust: n if n.ends_with("_sign") => "minecraft:sign",
    // rust: n if n.ends_with("_banner") => "minecraft:banner",
    // rust: n if n.ends_with("_head") || n.ends_with("_skull") => "minecraft:skull",
    // rust: n if n.ends_with("_shelf") => "minecraft:shelf",
    // rust: n if n.ends_with("copper_golem_statue") => "minecraft:copper_golem_statue",
    // rust: _ => return None,
    // rust: })
}

/// Per-state facts and registry ids for encoding chunks.
pub const ChunkEncoder = struct {
    /// What encoding a section needs, shared with the warm-up threads.
    coder: *SectionCoder,
    /// Block entity type id per state (-1 for none).
    entity_types: std.ArrayList(i32),
    /// Whether the state is a mod block's: its type is the block's own, and
    /// it has a block entity only when the mod made one.
    mod_entities: std.ArrayList(bool),
    /// The mods' update tags (`native_block_entity_update_tag`).
    mod_update_tag: ?ModUpdateTag,
    /// The block registry id of each state's block, for BlockEvent.
    block_ids: std.ArrayList(i32),
    /// The save's tables, for the heightmaps.
    tables: ?*crate::save::SaveTables,
    /// Sections already looked at, by address (see `Encoded`).
    cache: std::sync::Mutex<FxHashMap<usize,
    /// Each column's heightmaps, with the sections they were made from.
    heights: std::sync::Mutex<HashMap<(i32,
    /// The level's sections among a column's: all of them in the Overworld,
    /// y 0 to 255 in the Nether and the End (`DimensionType` min_y and height).
    sections: std::ops::Range<usize>,
    /// The column of the level's chunks, which `sections` counts in.
    column: ColumnLayout,
    /// Whether the level has sky light (`DimensionType.hasSkyLight`).
    sky: bool,
};

/// Per-state flags and biome ids: all a section's encoding reads.
pub const SectionCoder = struct {
    flags: std.ArrayList(u8),
    /// Network biome id per internal biome index.
    biome_ids: std.ArrayList(i32),
    biome_bits: u8,
};

/// A column's client heightmaps, valid while it holds the same sections.
pub const Heights = struct {
    sections: std.ArrayList(std::sync::Weak<Section)>,
    maps: ColumnHeightmaps,
};

/// Heightmap type ids with their packed long arrays.
    // rust: type ColumnHeightmaps = Arc<Vec<(i32, Vec<i64>)>>;

/// A column's cached heightmaps, while it holds the sections they were made
/// from.
    // rust: fn cached_heights(
    // rust: heights: &HashMap<(i32, i32), Heights>,
    // rust: chunk: &Chunk,
    // rust: ) -> Option<ColumnHeightmaps> {
    // rust: let h = heights.get(&(chunk.x, chunk.z))?;
    // rust: let same = h.sections.len() == chunk.sections.len()
    // rust: && h.sections
    // rust: .iter()
    // rust: .zip(&chunk.sections)
    // rust: .all(|(w, s)| std::ptr::eq(w.as_ptr(), Arc::as_ptr(s)));
    // rust: same.then(|| h.maps.clone())
}

/// Cache a column's heightmaps with the sections they were made from,
/// dropping the columns whose sections are gone once there are many.
    // rust: fn keep_heights(
    // rust: heights: &mut HashMap<(i32, i32), Heights>,
    // rust: key: (i32, i32),
    // rust: sections: &[Arc<Section>],
    // rust: maps: &ColumnHeightmaps,
    // rust: ) {
    // rust: if heights.len() >= CACHE_SWEEP / 4 {
    // rust: heights.retain(|_, h| h.sections.iter().all(|w| w.strong_count() > 0));
    // rust: if heights.len() >= CACHE_SWEEP / 8 {
    // rust: heights.clear();
}
}
    // rust: heights.insert(
    // rust: key,
    // rust: Heights {
    // rust: sections: sections.iter().map(Arc::downgrade).collect(),
    // rust: maps: maps.clone(),
    // rust: },
    // rust: );
}

/// What a resident section gives the wire, kept while the section is
/// unchanged. Resident sections are immutable behind `Arc` (edits go through
/// `Arc::make_mut`, which moves an edited section to a new address while a
/// `Weak` points at the old one), and the `Weak` keeps the old address from
/// being reused: the same address is the same, unchanged section.
pub const Encoded = struct {
    section: std::sync::Weak<Section>,
    non_air: bool,
    /// LevelChunkSection.write, and its block entity blocks.
    wire: ?(Arc<[u8],
};

/// A section's blocks that have a block entity type, as (index, state) in
/// index order (y, then z, then x).
    // rust: type Entities = Arc<[(u16, u32)]>;

/// `Paletted::from_values`' palette (distinct values in first-seen order)
/// and each entry's index in it, from a list palette's stored ids (`raw`
/// indexes `list`), with how many entries use each stored id. A value the
/// stored palette holds twice still gets one network index.
pub fn network_palette(list: *[u32], raw: *[u16]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut map = vec![u32::MAX; list.len()];
    // rust: let mut uses = vec![0i16; list.len()];
    // rust: let mut palette: Vec<i32> = Vec::with_capacity(list.len());
    // rust: let mut ids = Vec::with_capacity(raw.len());
    // rust: for &r in raw {
    // rust: let r = usize::from(r);
    // rust: uses[r] += 1;
    // rust: if map[r] == u32::MAX {
    // rust: let v = list[r] as i32;
    // rust: map[r] = match palette.iter().position(|&p| p == v) {
    // rust: Some(i) => i as u32,
    // rust: None => {
    // rust: palette.push(v);
    // rust: palette.len() as u32 - 1
}
}
}
    // rust: ids.push(map[r]);
}
    // rust: (palette, ids, uses)
}

    // rust: impl SectionCoder {
    /// LevelChunkSection.write, and its block entity blocks.
pub fn wire(self: *Self, section: *Section) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (encoded, entities) = self.section(section);
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: encoded.write(&mut w);
    // rust: (w.data.into(), entities.into())
}

pub fn section(self: *Self, section: *Section) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut non_empty, mut fluids, mut entities) = (0i16, 0i16, Vec::new());
    // rust: let mut count = |state: u32, n: i16| {
    // rust: let f = self.flags.get(state as usize).copied().unwrap_or(0);
    // rust: if f & NON_AIR != 0 {
    // rust: non_empty += n;
    // rust: if f & FLUID != 0 {
    // rust: fluids += n;
}
}
    // rust: f & ENTITY != 0
}
    // rust: let global_bits = crate::chunk::block_strategy().global_bits;
        // One block everywhere (all air, mostly): what from_values would give.
    // rust: let uniform = section.blocks.uniform();
    // rust: let mut raw = [0u16; BLOCKS];
    // rust: let states = if let Some(v) = uniform {
    // rust: if count(v, BLOCKS as i16) {
    // rust: entities = (0..BLOCKS as u16).map(|i| (i, v)).collect();
}
    // rust: Paletted {
    // rust: bits: 0,
    // rust: palette: vec![v as i32],
    // rust: data: Vec::new(),
}
    // rust: } else if let Some(list) = section.blocks.unpack_ids(&mut raw) {
            // The stored palette's ids, renumbered in first-seen order: the
            // palette from_values would find in the values, without them.
    // rust: let (palette, ids, uses) = network_palette(list, &raw);
    // rust: let mut any_entity = false;
    // rust: for (&v, &n) in list.iter().zip(&uses) {
    // rust: if n > 0 {
    // rust: any_entity |= count(v, n);
}
}
    // rust: if any_entity {
    // rust: for (i, &r) in raw.iter().enumerate() {
    // rust: let v = list[usize::from(r)];
    // rust: if self.flags.get(v as usize).copied().unwrap_or(0) & ENTITY != 0 {
    // rust: entities.push((i as u16, v));
}
}
}
    // rust: Paletted::from_palette(palette, &ids, Strategy::Blocks, global_bits)
    // rust: } else {
    // rust: let mut unpacked = [0u32; BLOCKS];
    // rust: section.unpack(&mut unpacked);
    // rust: let mut values = Vec::with_capacity(BLOCKS);
    // rust: for (i, &v) in unpacked.iter().enumerate() {
    // rust: if count(v, 1) {
    // rust: entities.push((i as u16, v));
}
    // rust: values.push(v as i32);
}
    // rust: Paletted::from_values(&values, Strategy::Blocks, global_bits)
}
    // rust: (
    // rust: horizon_protocol::chunk::Section {
    // rust: non_empty,
    // rust: fluids,
    // rust: states,
    // rust: biomes: self.biomes(section),
    // rust: },
    // rust: entities,
    // rust: )
}

    /// The section's biome container (`PalettedContainerRO.write`'s), in
    /// network biome ids.
pub fn biomes(self: *Self, section: *Section) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let net = |v: u32| {
    // rust: self.biome_ids
    // rust: .get(usize::from(v as u16))
    // rust: .copied()
    // rust: .unwrap_or(0)
}
    // rust: if let Some(v) = section.biomes.uniform() {
    // rust: return Paletted {
    // rust: bits: 0,
    // rust: palette: vec![net(v)],
    // rust: data: Vec::new(),
}
}
    // rust: let values: Vec<i32> = (0..BIOMES).map(|j| net(section.biomes.get(j))).collect();
    // rust: Paletted::from_values(&values, Strategy::Biomes, self.biome_bits)
}
}

/// Sections kept before the ones no longer resident are dropped.
pub const CACHE_SWEEP: usize = 1 << 15;

/// Listed uncached section occurrences below which a batch is encoded on the tick's thread
/// alone: waking the warm-up threads costs more than a few sections.
pub const WARM_MIN: usize = 16;

/// The work a batch needs, each piece taken by whichever thread is free
/// first: the heightmaps of its columns not cached yet, then its sections
/// not cached yet, and what each gave (a section: its wire bytes and, with
/// varying light, its layers).
pub const Warm = struct {
    coder: *SectionCoder,
    /// The heightmaps' tables, the column's min_y and the level's (min_y,
    /// height).
    heightmaps: ?(Arc<crate::save::SaveTables,
    columns: Vec<((i32,
    heights: std.ArrayList(OnceLock<ColumnHeightmaps)>,
    sections: std.ArrayList(*Section),
    next: AtomicUsize,
    done: std.ArrayList(OnceLock<Warmed)>,
};
    // rust: type Warmed = (Arc<[u8]>, Entities);
    // rust: impl Warm {
    /// Take work until none is left.
pub fn run(self: *Self) void {
}
    // rust: loop {
    // rust: let i = self.next.fetch_add(1, Ordering::Relaxed);
    // rust: if let Some((_, sections)) = self.columns.get(i) {
    // rust: if let Some((tables, column_min_y, min_y, height)) = &self.heightmaps {
    // rust: let maps = crate::save::client_heightmaps_in(
    // rust: sections,
    // rust: *column_min_y,
    // rust: tables,
    // rust: *min_y,
    // rust: *height,
    // rust: );
    // rust: let _ = self.heights[i].set(Arc::new(maps));
}
    // rust: continue;
}
    // rust: let i = i - self.columns.len();
    // rust: let Some(s) = self.sections.get(i) else {
    // rust: return;
}
    // rust: let _ = self.done[i].set(self.coder.wire(s));
}
}
}

/// Columns below which their bodies are written on the tick's thread alone.
pub const BODIES_MIN: usize = 4;

/// A column's body with what reads the level done: its sections' bytes, its
/// heightmaps and its block entities. What is left, the light layers and the
/// writing, reads only its own sections, so any thread can finish it.
pub const Prepared = struct {
    x: i32,
    z: i32,
    heightmaps: ColumnHeightmaps,
    wires: std.ArrayList(*[u8]),
    /// The block entities as `List<BlockEntityInfo>` writes them.
    tags: std.ArrayList(u8),
    /// The level's sections of the column.
    sections: std.ArrayList(*Section),
    around: SectionMask,
    sky: bool,
};
    // rust: impl Prepared {
    /// The body as `Clientbound::encode` gives it for LevelChunkWithLight,
    /// written once into a buffer of its final size.
pub fn write(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lights = light_sections(&self.sections, self.around, SectionLight::of);
    // rust: let buffer: usize = self.wires.iter().map(|w| w.len()).sum();
        // The masks, counts and lengths fit the 64 bytes.
    // rust: let size = 64
    // rust: + self
    // rust: .heightmaps
    // rust: .iter()
    // rust: .map(|(_, h)| 10 + 8 * h.len())
    // rust: .sum::<usize>()
    // rust: + buffer
    // rust: + self.tags.len()
    // rust: + lights.len() * 2 * (2048 + 3);
    // rust: let mut w = Writer {
    // rust: data: Vec::with_capacity(size),
}
    // rust: w.varint(horizon_protocol::ids::play::clientbound::LEVEL_CHUNK_WITH_LIGHT);
    // rust: w.i32(self.x);
    // rust: w.i32(self.z);
    // rust: Heightmaps::write(&*self.heightmaps, &mut w);
    // rust: w.varint(buffer as i32);
    // rust: for wire in &self.wires {
    // rust: w.bytes(wire);
}
    // rust: w.bytes(&self.tags);
    // rust: write_light(&lights, self.sky, &mut w);
    // rust: w.data
}
}

/// Bodies to finish, each taken by whichever thread is free first. A body
/// another thread is still writing is waited for (`OnceLock::get_or_init`).
pub const Bodies = struct {
    columns: std.ArrayList(Prepared),
    next: AtomicUsize,
    done: std.ArrayList(OnceLock<std::sync::Mutex<Vec<u8)>>>,
};
    // rust: impl Bodies {
    /// Take work until none is left.
pub fn run(self: *Self) void {
}
    // rust: loop {
    // rust: let i = self.next.fetch_add(1, Ordering::Relaxed);
    // rust: let Some(column) = self.columns.get(i) else {
    // rust: return;
}
    // rust: self.done[i].get_or_init(|| std::sync::Mutex::new(column.write()));
}
}
}

/// What the warm-up threads take.
pub const Job = enum {
    Warm(Arc<Warm>),
    Bodies(Arc<Bodies>),
};
    // rust: impl Job {
pub fn run(self: *Self) void {
}
    // rust: match self {
    // rust: Self::Warm(job) => job.run(),
    // rust: Self::Bodies(job) => job.run(),
}
}
    /// Whether this is the job behind `ptr`.
pub fn is(self: *Self, ptr: *const () void {
}
    // rust: match self {
    // rust: Self::Warm(job) => Arc::as_ptr(job).cast::<()>() == ptr,
    // rust: Self::Bodies(job) => Arc::as_ptr(job).cast::<()>() == ptr,
}
}
}

/// The warm-up threads (one per core besides the tick's) and the job they
/// take: its number, and the job while it has work left to take.
pub const WarmPool = struct {
    job: std::sync::Mutex<(u64,
    ready: std::sync::Condvar,
};
    // rust: impl WarmPool {
    /// Hand `job` to the threads.
pub fn post(self: *Self, job: Job) void {
}
    // rust: {
    // rust: let mut slot = self.job.lock().unwrap();
    // rust: slot.0 += 1;
    // rust: slot.1 = Some(job);
}
    // rust: self.ready.notify_all();
}
    /// Everything of the job behind `ptr` is claimed: it leaves the slot.
pub fn clear(self: *Self, ptr: *const () void {
}
    // rust: let mut slot = self.job.lock().unwrap();
    // rust: if slot.1.as_ref().is_some_and(|j| j.is(ptr)) {
    // rust: slot.1 = None;
}
}
}

/// The warm-up threads, started the first time; none on a single core or
/// when no thread could start.
pub fn warm_pool() O {
    // Implementation ported from Horizon
    return undefined;
}
pub const POOL: OnceLock<?*WarmPool> = OnceLock::new();
    // rust: POOL.get_or_init(|| {
    // rust: let threads = horizon_threads::worker_count() - 1;
    // rust: let pool = Arc::new(WarmPool {
    // rust: job: Default::default(),
    // rust: ready: Default::default(),
    // rust: });
    // rust: let started = (0..threads)
    // rust: .filter(|i| {
    // rust: let pool = pool.clone();
    // rust: std::thread::Builder::new()
    // rust: .name(format!("horizon-chunk-encode-{i}"))
    // rust: .spawn(move || {
    // rust: let mut done = 0;
    // rust: loop {
    // rust: let job = {
    // rust: let mut slot = pool.job.lock().unwrap();
    // rust: while slot.0 == done {
    // rust: slot = pool.ready.wait(slot).unwrap();
}
    // rust: done = slot.0;
    // rust: slot.1.clone()
}
    // rust: if let Some(job) = job {
    // rust: job.run();
}
}
    // rust: })
    // rust: .is_ok()
    // rust: })
    // rust: .count();
    // rust: (started > 0).then_some(pool)
    // rust: })
    // rust: .as_deref()
}
    // rust: impl ChunkEncoder {
    /// `biome_names`: the internal biome list in order; `biome_registry`:
    /// the synchronized biome entries in network order.
    // rust: pub fn new(
    // rust: states: impl IntoIterator<Item = (Arc<str>, bool)>,
    // rust: builtin: &Builtin,
    // rust: biome_names: &[String],
    // rust: biome_registry: &[String],
    // rust: ) -> Self {
    // rust: Self::with_signs(
    // rust: states.into_iter().map(|(name, fluid)| (name, fluid, None)),
    // rust: builtin,
    // rust: biome_names,
    // rust: biome_registry,
    // rust: )
}

    /// The encoder with each state's sign form from its template's class: mod
    /// signs reuse vanilla's sign block entity types.
    // rust: pub fn with_signs(
    // rust: states: impl IntoIterator<Item = (Arc<str>, bool, Option<crate::blocks::SignForm>)>,
    // rust: builtin: &Builtin,
    // rust: biome_names: &[String],
    // rust: biome_registry: &[String],
    // rust: ) -> Self {
    // rust: let types = builtin.get("minecraft:block_entity_type");
    // rust: let blocks = builtin.get("minecraft:block");
    // rust: let mut flags = Vec::new();
    // rust: let mut entity_types = Vec::new();
    // rust: let mut mod_entities = Vec::new();
    // rust: let mut block_ids = Vec::new();
    // rust: for (name, has_fluid, sign) in states {
    // rust: let air = matches!(
    // rust: &*name,
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: );
    // rust: let mut f = 0u8;
    // rust: if !air {
    // rust: f |= NON_AIR;
    // rust: if has_fluid {
    // rust: f |= FLUID;
}
}
            // A mod block's block entity type is named after the block
            // (`mod_content`: registries.json), unless it is one of vanilla's.
    // rust: let vanilla = sign.map(crate::blocks::SignForm::block_entity_type);
    // rust: let modded = !name.starts_with("minecraft:") && vanilla.is_none();
    // rust: let t = if modded {
    // rust: Some(&*name)
    // rust: } else {
    // rust: vanilla.or_else(|| block_entity_type(&name))
}
    // rust: .and_then(|t| types.and_then(|ids| ids.id(t)))
    // rust: .unwrap_or(-1);
    // rust: if t >= 0 {
    // rust: f |= ENTITY;
}
    // rust: flags.push(f);
    // rust: entity_types.push(t);
    // rust: mod_entities.push(modded && t >= 0);
    // rust: block_ids.push(blocks.and_then(|b| b.id(&name)).unwrap_or(0));
}
    // rust: let biome_ids = biome_names
    // rust: .iter()
    // rust: .map(|n| {
    // rust: biome_registry
    // rust: .iter()
    // rust: .position(|b| b == n)
    // rust: .map_or(0, |i| i as i32)
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: coder: Arc::new(SectionCoder {
    // rust: flags,
    // rust: biome_ids,
    // rust: biome_bits: ceil_log2(biome_registry.len()),
    // rust: }),
    // rust: entity_types,
    // rust: mod_entities,
    // rust: mod_update_tag: None,
    // rust: block_ids,
    // rust: tables: None,
    // rust: cache: Default::default(),
    // rust: heights: Default::default(),
    // rust: sections: 0..ColumnLayout::VANILLA.sections(),
    // rust: column: ColumnLayout::VANILLA,
    // rust: sky: true,
}
}

    /// `ClientboundChunksBiomesPacket.ChunkBiomeData`: the column's biome
    /// containers, one per section of the level (`extractChunkData`).
pub fn biome_data(self: *Self, chunk: *Chunk) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let biomes: Vec<Paletted> = chunk.sections[self.sections.clone()]
    // rust: .iter()
    // rust: .map(|s| self.coder.biomes(s))
    // rust: .collect();
    // rust: ChunkBiomeData::from_biomes([chunk.x, chunk.z], &biomes)
}

    /// The client heightmaps (Heightmap.prime over the column), from the
    /// cache while the column's sections are unchanged.
pub fn heightmaps(self: *Self, chunk: *Chunk, tables: *crate::save::SaveTables) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut heights = self.heights.lock().unwrap();
    // rust: if let Some(maps) = cached_heights(&heights, chunk) {
    // rust: return maps;
}
    // rust: let (min_y, height) = self.level();
    // rust: let maps = Arc::new(crate::save::client_heightmaps_in(
    // rust: &chunk.sections,
    // rust: chunk.min_y(),
    // rust: tables,
    // rust: min_y,
    // rust: height,
    // rust: ));
    // rust: keep_heights(&mut heights, (chunk.x, chunk.z), &chunk.sections, &maps);
    // rust: maps
}

    /// The level's min_y and height (`DimensionType`), the heightmaps' range.
pub fn level(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: self.column.section_y(self.sections.start),
    // rust: 16 * self.sections.len() as i32,
    // rust: )
}

    /// The cached entry for a section, made with `non_air` when missing.
    // rust: fn cached<T>(&self, section: &Arc<Section>, read: impl FnOnce(&mut Encoded) -> T) -> T {
    // rust: read(self.entry(&mut self.cache.lock().unwrap(), section))
}

    /// A section's entry in the locked cache, made with `non_air` when missing.
    // rust: fn entry<'a>(
    // rust: &self,
    // rust: cache: &'a mut FxHashMap<usize, Encoded>,
    // rust: section: &Arc<Section>,
    // rust: ) -> &'a mut Encoded {
    // rust: if cache.len() >= CACHE_SWEEP {
    // rust: cache.retain(|_, e| e.section.strong_count() > 0);
    // rust: if cache.len() >= CACHE_SWEEP / 2 {
    // rust: cache.clear();
}
}
    // rust: cache
    // rust: .entry(Arc::as_ptr(section) as usize)
    // rust: .or_insert_with(|| Encoded {
    // rust: section: Arc::downgrade(section),
    // rust: non_air: self.non_air(section),
    // rust: wire: None,
    // rust: })
}

    /// LevelChunkSection.hasOnlyAir, negated.
pub fn non_air(self: *Self, section: *Section) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let non_air =
    // rust: |v: u32| self.coder.flags.get(v as usize).copied().unwrap_or(0) & NON_AIR != 0;
        // The palette first: most sections are all air, or one block.
    // rust: if !section.blocks.maybe_has(non_air) {
    // rust: false
    // rust: } else if let Some(v) = section.blocks.uniform() {
    // rust: non_air(v)
    // rust: } else {
            // Stops at the first block, usually near the bottom.
    // rust: (0..BLOCKS).any(|i| non_air(section.blocks.get(i)))
}
}

    /// A section on the wire, from the cache or encoded now.
pub fn section_wire(self: *Self, section: **Section) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(wire) = self.cached(section, |e| e.wire.clone()) {
    // rust: return wire;
}
    // rust: let wire = self.coder.wire(section);
    // rust: self.cached(section, |e| e.wire = Some(wire.clone()));
    // rust: wire
}
    /// Encode for a level of `shape`: its chunks hold `shape.column()`, of
    /// which the level's own sections go on the wire.
pub fn set_dimension(self: *Self, shape: LevelShape) void {
}
    // rust: let column = shape.column();
    // rust: let lo = usize::try_from((shape.min_y - column.min_y()) >> 4).unwrap_or(0);
    // rust: let n = usize::try_from(shape.height >> 4).unwrap_or(0);
    // rust: self.column = column;
    // rust: self.sections = lo.min(column.sections())..(lo + n).min(column.sections());
    // rust: self.sky = shape.sky_light;
        // The heightmaps depend on the level's height.
    // rust: self.heights.get_mut().unwrap().clear();
}
pub fn entity_type(self: *Self, state: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entity_types
    // rust: .get(state as usize)
    // rust: .filter(|t| **t >= 0)
    // rust: .copied()
}
    /// The update tag of the block entity at `pos` (`getUpdateTag`): a
    /// mod's from its hook, a vanilla one's from [`entity_tag`].
pub fn update_tag(self: *Self, pos: (i32) void {
}
    // rust: match entity {
    // rust: BlockEntity::Mod(m) => self
    // rust: .mod_update_tag
    // rust: .and_then(|tag| tag([pos.0, pos.1, pos.2], m))
    // rust: .map(Tag::Compound),
    // rust: _ => entity_tag(entity),
}
}
    /// Whether the state holds a fluid (water, lava, or a waterlogged block).
pub fn has_fluid(self: *Self, state: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.coder
    // rust: .flags
    // rust: .get(state as usize)
    // rust: .is_some_and(|f| f & FLUID != 0)
}
pub fn is_air(self: *Self, state: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.coder
    // rust: .flags
    // rust: .get(state as usize)
    // rust: .is_none_or(|f| f & NON_AIR == 0)
}

    /// The chunk column with its light and block entities.
    /// The non-air sections of a column as bits (LevelChunkSection.hasOnlyAir).
pub fn occupied(self: *Self, chunk: *Chunk) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bits = SectionMask::EMPTY;
        // One lock for the column: body_in asks for nine columns' sections.
    // rust: let mut cache = self.cache.lock().unwrap();
    // rust: for (i, s) in chunk.sections[self.sections.clone()].iter().enumerate() {
    // rust: let non_air = if s.blocks.bits() == 0 {
    // rust: !self.is_air(s.blocks.get(0))
    // rust: } else {
    // rust: self.entry(&mut cache, s).non_air
}
    // rust: if non_air {
    // rust: bits.insert(i);
}
}
    // rust: bits
}

    /// The non-air sections of the column and its neighbours, as bits. A
    /// neighbour still a proto chunk counts too, as vanilla's light storage
    /// counts a neighbour at INITIALIZE_LIGHT (#4294).
    // rust: fn around(
    // rust: &self,
    // rust: chunk: &Chunk,
    // rust: world: &crate::world::World,
    // rust: protos: &dyn Fn(i32, i32) -> Option<SectionMask>,
    // rust: ) -> SectionMask {
    // rust: let mut around = SectionMask::EMPTY;
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: let (x, z) = (chunk.x + dx, chunk.z + dz);
    // rust: if let Some(c) = world.chunks.get(&(x, z)) {
    // rust: around |= self.occupied(c);
    // rust: } else if let Some(sections) = protos(x, z) {
                    // Column sections: this level's range from 0.
    // rust: for i in sections.iter() {
    // rust: if self.sections.contains(&i) {
    // rust: around.insert(i - self.sections.start);
}
}
}
}
}
    // rust: around
}

    /// The chunk column with its light and block entities, as the body
    /// `Clientbound::encode` gives for its LevelChunkWithLight. `world` gives
    /// the neighbouring columns, whose sections decide which light layers
    /// exist. It is written once into a buffer of its final size: the cached
    /// sections and light layers go straight to it, with no packet built and
    /// copied again first.
pub fn body_in(self: *Self, chunk: *Chunk, world: *crate::world::World) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.body_with(chunk, world, &|_, _| None)
}
    /// [`Self::body_in`], with `protos` giving the non-air sections of a
    /// neighbour that is still a proto chunk.
    // rust: pub fn body_with(
    // rust: &self,
    // rust: chunk: &Chunk,
    // rust: world: &crate::world::World,
    // rust: protos: &dyn Fn(i32, i32) -> Option<SectionMask>,
    // rust: ) -> Vec<u8> {
    // rust: self.body(
    // rust: chunk,
    // rust: &world.block_entities,
    // rust: self.around(chunk, world, protos),
    // rust: )
}

    /// An encoder of the same level with caches of its own, for threads that encode saved chunks no
    /// level holds (`lan::far`).
pub fn detached(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: coder: self.coder.clone(),
    // rust: entity_types: self.entity_types.clone(),
    // rust: mod_entities: self.mod_entities.clone(),
    // rust: mod_update_tag: self.mod_update_tag,
    // rust: block_ids: self.block_ids.clone(),
    // rust: tables: self.tables.clone(),
    // rust: cache: Default::default(),
    // rust: heights: Default::default(),
    // rust: sections: self.sections.clone(),
    // rust: column: self.column,
    // rust: sky: self.sky,
}
}
    /// The body of a column read from the save that no level holds: its own block entities, and every
    /// light section (as `light_update`; no neighbour is at hand to tell which exist). Nothing of it
    /// stays cached: the column is dropped once sent.
pub fn body_alone(self: *Self, chunk: *Chunk) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let entities: HashMap<_, _> = chunk.block_entities.iter().cloned().collect();
    // rust: let body = self.body(chunk, &entities, SectionMask::ALL);
    // rust: let mut cache = self.cache.lock().unwrap();
    // rust: for s in &chunk.sections {
    // rust: cache.remove(&(Arc::as_ptr(s) as usize));
}
    // rust: drop(cache);
    // rust: self.heights.lock().unwrap().remove(&(chunk.x, chunk.z));
    // rust: body
}

    /// Make what these columns need and is not cached yet (their heightmaps
    /// and sections) before their bodies are made, shared out to the warm-up
    /// threads: a batch of new terrain costs mostly its sections' first
    /// encoding. This thread takes work too until none is left, then caches
    /// what is done; it never waits for the other threads (they keep their
    /// results to themselves until then), and what one of them is still on
    /// is made again by `body_in`, the same.
pub fn warm(self: *Self, columns: *[*Chunk]) void {
}
    // rust: let Some(job) = self.job(columns) else {
    // rust: return;
}
    // rust: let Some(pool) = warm_pool() else {
    // rust: return;
}
    // rust: let job = Arc::new(job);
    // rust: pool.post(Job::Warm(job.clone()));
    // rust: job.run();
    // rust: pool.clear(Arc::as_ptr(&job).cast());
    // rust: self.keep(&job);
}

    /// The work `warm` shares out: the heightmaps of the columns and the
    /// distinct sections not cached yet; none when there is too little to wake the
    /// warm-up threads for.
pub fn job(self: *Self, columns: *[*Chunk]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stale: Vec<((i32, i32), Vec<Arc<Section>>)> = match &self.tables {
    // rust: Some(_) => {
    // rust: let heights = self.heights.lock().unwrap();
    // rust: let mut seen = crate::fast_hash::FxHashSet::default();
    // rust: columns
    // rust: .iter()
    // rust: .filter(|c| seen.insert((c.x, c.z)) && cached_heights(&heights, c).is_none())
    // rust: .map(|c| ((c.x, c.z), c.sections.clone()))
    // rust: .collect()
}
    // rust: None => Vec::new(),
}
    // rust: let mut sections: Vec<Arc<Section>> = {
    // rust: let cache = self.cache.lock().unwrap();
    // rust: columns
    // rust: .iter()
    // rust: .flat_map(|c| &c.sections[self.sections.clone()])
    // rust: .filter(|s| {
    // rust: cache
    // rust: .get(&(Arc::as_ptr(s) as usize))
    // rust: .is_none_or(|e| e.wire.is_none())
    // rust: })
    // rust: .cloned()
    // rust: .collect()
}
    // rust: if sections.len() + stale.len() < WARM_MIN {
    // rust: return None;
}
    // rust: let mut seen = crate::fast_hash::FxHashSet::default();
    // rust: sections.retain(|s| seen.insert(Arc::as_ptr(s)));
    // rust: let (min_y, height) = self.level();
    // rust: Some(Warm {
    // rust: coder: self.coder.clone(),
    // rust: heightmaps: self
    // rust: .tables
    // rust: .clone()
    // rust: .map(|t| (t, self.column.min_y(), min_y, height)),
    // rust: heights: stale.iter().map(|_| OnceLock::new()).collect(),
    // rust: columns: stale,
    // rust: done: sections.iter().map(|_| OnceLock::new()).collect(),
    // rust: sections,
    // rust: next: AtomicUsize::new(0),
    // rust: })
}

    /// Cache what a job's threads have finished.
pub fn keep(self: *Self, job: *Warm) void {
}
    // rust: {
    // rust: let mut heights = self.heights.lock().unwrap();
    // rust: for ((key, sections), done) in job.columns.iter().zip(&job.heights) {
    // rust: if let Some(maps) = done.get() {
    // rust: keep_heights(&mut heights, *key, sections, maps);
}
}
}
    // rust: let mut cache = self.cache.lock().unwrap();
    // rust: for (s, done) in job.sections.iter().zip(&job.done) {
    // rust: if let Some(wire) = done.get() {
    // rust: self.entry(&mut cache, s).wire = Some(wire.clone());
}
}
}

    // rust: fn body(
    // rust: &self,
    // rust: chunk: &Chunk,
    // rust: block_entities: &HashMap<(i32, i32, i32), BlockEntity>,
    // rust: around: SectionMask,
    // rust: ) -> Vec<u8> {
    // rust: self.prepare(chunk, block_entities, around).write()
}

    /// What of a column's body reads the level or the caches.
    // rust: fn prepare(
    // rust: &self,
    // rust: chunk: &Chunk,
    // rust: block_entities: &HashMap<(i32, i32, i32), BlockEntity>,
    // rust: around: SectionMask,
    // rust: ) -> Prepared {
    // rust: let (wires, entities) = self.blocks(chunk, block_entities);
    // rust: let heightmaps = self.heightmaps_of(chunk);
        // Before the light: their tags' size is only known once written.
    // rust: let mut tags = Writer::new();
    // rust: List::<BlockEntityInfo>::write(&entities, &mut tags);
    // rust: Prepared {
    // rust: x: chunk.x,
    // rust: z: chunk.z,
    // rust: heightmaps,
    // rust: wires,
    // rust: tags: tags.data,
    // rust: sections: chunk.sections[self.sections.clone()].to_vec(),
    // rust: around,
    // rust: sky: self.sky,
}
}

    /// [`Self::body_with`] for each of `chunks`, in their order. What reads
    /// the level is done here, column by column as `body_with` does; the
    /// light layers and the writing, most of a body's cost, go to the warm-up
    /// threads too when there are enough columns. This thread takes bodies
    /// as well and waits only for the ones still being written.
    // rust: pub fn bodies_with(
    // rust: &self,
    // rust: chunks: &[&Chunk],
    // rust: world: &crate::world::World,
    // rust: protos: &dyn Fn(i32, i32) -> Option<SectionMask>,
    // rust: ) -> Vec<Vec<u8>> {
    // rust: let columns: Vec<Prepared> = chunks
    // rust: .iter()
    // rust: .map(|c| self.prepare(c, &world.block_entities, self.around(c, world, protos)))
    // rust: .collect();
    // rust: let pool = if columns.len() >= BODIES_MIN {
    // rust: warm_pool()
    // rust: } else {
    // rust: None
}
    // rust: let Some(pool) = pool else {
    // rust: return columns.iter().map(Prepared::write).collect();
}
    // rust: let job = Arc::new(Bodies {
    // rust: done: columns.iter().map(|_| OnceLock::new()).collect(),
    // rust: columns,
    // rust: next: AtomicUsize::new(0),
    // rust: });
    // rust: pool.post(Job::Bodies(job.clone()));
    // rust: job.run();
    // rust: pool.clear(Arc::as_ptr(&job).cast());
    // rust: job.columns
    // rust: .iter()
    // rust: .zip(&job.done)
    // rust: .map(|(c, done)| {
    // rust: let body = done.get_or_init(|| std::sync::Mutex::new(c.write()));
    // rust: std::mem::take(&mut *body.lock().unwrap())
    // rust: })
    // rust: .collect()
}

    /// ClientboundLightUpdatePacket for the light sections over `changed` (a
    /// bit per section of the column, `sectionLightChanged`), as vanilla's
    /// `ClientboundLightUpdatePacketData` writes them, with both kinds of
    /// each section (Horizon's light engine doesn't tell them apart; the
    /// client keeps the same light either way). A section changed as its
    /// last block went (light dimming around a removed block) is sent too:
    /// a client not tracking the block would otherwise keep its old light.
pub fn light_update(self: *Self, chunk: *Chunk, changed: SectionMask) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let first = self.sections.start;
        // Light section b holds the column's section first + b - 1.
    // rust: let lights: Vec<(usize, SectionLight)> = (1..=self.sections.len())
    // rust: .filter(|&b| changed.contains(first + b - 1))
    // rust: .map(|b| (b, SectionLight::of(&chunk.sections[first + b - 1])))
    // rust: .collect();
    // rust: horizon_protocol::packets::play::Clientbound::LightUpdate(
    // rust: horizon_protocol::packets::play::LightUpdate {
    // rust: x: chunk.x,
    // rust: z: chunk.z,
    // rust: light: light_data_of(&lights, self.sky),
    // rust: },
    // rust: )
    // rust: .encode()
}

    // rust: pub fn encode(
    // rust: &self,
    // rust: chunk: &Chunk,
    // rust: block_entities: &HashMap<(i32, i32, i32), BlockEntity>,
    // rust: ) -> LevelChunkWithLight {
    // rust: let mut packet = self.encode_blocks(chunk, block_entities);
    // rust: packet.light = self.light_data(chunk, SectionMask::ALL);
    // rust: packet
}

    /// The packet without its light.
    // rust: fn encode_blocks(
    // rust: &self,
    // rust: chunk: &Chunk,
    // rust: block_entities: &HashMap<(i32, i32, i32), BlockEntity>,
    // rust: ) -> LevelChunkWithLight {
    // rust: let (wires, block_entities) = self.blocks(chunk, block_entities);
    // rust: LevelChunkWithLight {
    // rust: x: chunk.x,
    // rust: z: chunk.z,
    // rust: chunk: ChunkData {
    // rust: heightmaps: self.heightmaps_of(chunk).to_vec(),
    // rust: buffer: wires.concat(),
    // rust: block_entities,
    // rust: },
    // rust: light: LightData {
    // rust: sky_mask: Vec::new(),
    // rust: block_mask: Vec::new(),
    // rust: empty_sky_mask: Vec::new(),
    // rust: empty_block_mask: Vec::new(),
    // rust: sky: Vec::new(),
    // rust: block: Vec::new(),
    // rust: },
}
}

pub fn heightmaps_of(self: *Self, chunk: *Chunk) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tables
    // rust: .as_ref()
    // rust: .map(|t| self.heightmaps(chunk, t))
    // rust: .unwrap_or_default()
}

    /// The level's sections on the wire, and the column's block entities in
    /// the packet's order.
    // rust: fn blocks(
    // rust: &self,
    // rust: chunk: &Chunk,
    // rust: block_entities: &HashMap<(i32, i32, i32), BlockEntity>,
    // rust: ) -> (Vec<Arc<[u8]>>, Vec<BlockEntityInfo>) {
    // rust: let mut wires = Vec::with_capacity(self.sections.len());
    // rust: let mut entity_infos = Vec::new();
    // rust: for (i, s) in chunk
    // rust: .sections
    // rust: .iter()
    // rust: .enumerate()
    // rust: .skip(self.sections.start)
    // rust: .take(self.sections.len())
    // rust: {
    // rust: let (encoded, entities) = self.section_wire(s);
            // The section's block entity blocks, kept with its bytes, in the
            // order a scan of every block would find them.
    // rust: for &(index, state) in entities.iter() {
    // rust: let Some(kind) = self.entity_type(state) else {
    // rust: continue;
}
    // rust: let (x, y, z) = (
    // rust: i32::from(index & 15),
    // rust: i32::from(index >> 8),
    // rust: i32::from(index >> 4 & 15),
    // rust: );
    // rust: let wy = chunk.min_y() + (i as i32) * 16 + y;
    // rust: let pos = (chunk.x * 16 + x, wy, chunk.z * 16 + z);
    // rust: let entity = block_entities.get(&pos);
                // A mod block whose mod made no block entity has none to send.
    // rust: if self.mod_entities[state as usize] && !matches!(entity, Some(BlockEntity::Mod(_)))
    // rust: {
    // rust: continue;
}
    // rust: entity_infos.push(BlockEntityInfo {
    // rust: packed_xz: ((x << 4) | z) as i8,
    // rust: y: wy as i16,
    // rust: kind,
                    // BlockEntityInfo.create: an empty update tag is not sent.
    // rust: tag: entity
    // rust: .and_then(|e| self.update_tag(pos, e))
    // rust: .or_else(|| pot_tag(chunk, pos))
    // rust: .filter(|t| !matches!(t, Tag::Compound(c) if c.is_empty()))
    // rust: .unwrap_or(Tag::End),
    // rust: });
}
    // rust: wires.push(encoded);
}
        // A loaded chunk's block entities enter its maps in the save's order
        // (ChunkAccess.pendingBlockEntities, then LevelChunk.blockEntities):
        // keys that share a bucket keep that order. Others follow in scan order.
    // rust: if let Some(order) = chunk.saved.as_ref().map(|s| &s.block_entity_order)
    // rust: && !order.is_empty()
    // rust: {
    // rust: let at = |e: &BlockEntityInfo| {
    // rust: let pos = (
    // rust: chunk.x * 16 + i32::from(e.packed_xz as u8 >> 4),
    // rust: i32::from(e.y),
    // rust: chunk.z * 16 + i32::from(e.packed_xz as u8 & 15),
    // rust: );
    // rust: order.iter().position(|p| *p == pos).unwrap_or(usize::MAX)
}
    // rust: entity_infos.sort_by_key(at);
}
    // rust: java_hash_order(&mut entity_infos, |e| {
    // rust: (
    // rust: chunk.x * 16 + i32::from(e.packed_xz as u8 >> 4),
    // rust: i32::from(e.y),
    // rust: chunk.z * 16 + i32::from(e.packed_xz as u8 & 15),
    // rust: )
    // rust: });
    // rust: (wires, entity_infos)
}

    /// ClientboundLightUpdatePacketData: the light layers of the sections
    /// that exist around the column (`around`: the non-air sections of it
    /// and its neighbours), written from the sections' own light.
pub fn light_data(self: *Self, chunk: *Chunk, around: SectionMask) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: light_data_of(&self.light_sections(chunk, around), self.sky)
}

pub fn light_sections(self: *Self, chunk: *Chunk, around: SectionMask) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: light_sections(
    // rust: &chunk.sections[self.sections.clone()],
    // rust: around,
    // rust: SectionLight::of,
    // rust: )
}
}

/// The order LevelChunk.getBlockEntities() iterates in: a fastutil
/// Object2ObjectOpenHashMap keyed by BlockPos (linear probing from
/// HashCommon.mix(hashCode), grown at 3/4 by reinserting from the top of
/// the table, iterated from the top down), filled in the order of the
/// java.util.HashMap of pending block entities that the loaded chunk's list
/// (`items` in section order) went through.
    // rust: fn java_hash_order<T>(items: &mut Vec<T>, pos: impl Fn(&T) -> (i32, i32, i32)) {
    // Vec3i.hashCode.
    // rust: let hash = |&(x, y, z): &(i32, i32, i32)| {
    // rust: y.wrapping_add(z.wrapping_mul(31))
    // rust: .wrapping_mul(31)
    // rust: .wrapping_add(x)
}
    // rust: let keys: Vec<i32> = items.iter().map(|i| hash(&pos(i))).collect();
    // java.util.HashMap: buckets in index order, insertion order within one.
    // rust: let mut capacity = 16usize;
    // rust: while keys.len() * 4 > capacity * 3 {
    // rust: capacity *= 2;
}
    // rust: let mut order: Vec<usize> = (0..keys.len()).collect();
    // rust: order.sort_by_key(|&i| {
    // rust: ((keys[i] ^ ((keys[i] as u32) >> 16) as i32) as u32 as usize) & (capacity - 1)
    // rust: });
    // Object2ObjectOpenHashMap.
    // rust: let mix = |h: i32| {
    // rust: let h = h.wrapping_mul(0x9E37_79B9_u32 as i32) as u32;
    // rust: (h ^ (h >> 16)) as usize
}
    // rust: let put = |table: &mut Vec<Option<usize>>, i: usize| {
    // rust: let mask = table.len() - 1;
    // rust: let mut at = mix(keys[i]) & mask;
    // rust: while table[at].is_some() {
    // rust: at = (at + 1) & mask;
}
    // rust: table[at] = Some(i);
}
    // Default expected size 16: HashCommon.arraySize(16, 0.75) = 32 slots.
    // rust: let mut table: Vec<Option<usize>> = vec![None; 32];
    // rust: for (size, &i) in order.iter().enumerate() {
    // rust: put(&mut table, i);
        // insert: `if (size++ >= maxFill) rehash(arraySize(size + 1, f))`.
    // rust: let max_fill = (table.len() * 3).div_ceil(4).min(table.len() - 1);
    // rust: if size >= max_fill {
    // rust: let grown = ((size + 2) * 4).div_ceil(3).next_power_of_two().max(2);
    // rust: let old = std::mem::replace(&mut table, vec![None; grown]);
    // rust: for &j in old.iter().rev().flatten() {
    // rust: put(&mut table, j);
}
}
}
    // rust: let iteration: Vec<usize> = table.iter().rev().flatten().copied().collect();
    // rust: let mut slots: Vec<Option<T>> = items.drain(..).map(Some).collect();
    // rust: items.extend(iteration.into_iter().filter_map(|i| slots[i].take()));
}

/// The update tag of a block entity (getUpdateTag) for what the client shows.
pub fn entity_tag(entity: *BlockEntity) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match entity {
    // rust: BlockEntity::Sign(sign) => Some(Tag::compound(sign.encode())),
    // rust: BlockEntity::Spawner(s) => Some(s.update_tag()),
    // rust: BlockEntity::Brushable(b) => {
    // rust: let mut entries = Vec::new();
    // rust: if let Some(face) = b.hit_direction {
    // rust: entries.push(("hit_direction", Tag::Byte(face as i8)));
}
    // rust: if let Some(item) = &b.item {
    // rust: entries.push(("item", crate::save::item_to_nbt(item)));
}
    // rust: Some(Tag::compound(entries))
}
        // StructureBlockEntity.getUpdateTag: saveCustomOnly.
    // rust: BlockEntity::StructureBlock(b) => Some(Tag::compound(b.save())),
        // JigsawBlockEntity.getUpdateTag: saveCustomOnly.
    // rust: BlockEntity::JigsawBlock(b) => Some(Tag::compound(b.save())),
        // TestBlockEntity.getUpdateTag: saveCustomOnly.
    // rust: BlockEntity::TestBlock(b) => Some(Tag::compound(b.save())),
        // TestInstanceBlockEntity.getUpdateTag: saveCustomOnly.
    // rust: BlockEntity::TestInstanceBlock(b) => Some(Tag::compound(b.save())),
    // rust: BlockEntity::Shelf(s) => Some(Tag::compound([
    // rust: ("Items", crate::save::encode_items(&s.items)),
    // rust: (
    // rust: "align_items_to_bottom",
    // rust: Tag::Byte(i8::from(s.align_to_bottom)),
    // rust: ),
    // rust: ])),
        // BannerBlockEntity.getUpdateTag: saveWithoutMetadata, so the patterns,
        // the custom name and the components.
    // rust: BlockEntity::Banner(b) => {
    // rust: let mut entries = Vec::new();
    // rust: if !b.layers.is_empty() {
    // rust: entries.push(("patterns", crate::banner::layers_to_nbt(&b.layers)));
}
    // rust: if let Some(name) = &b.name {
    // rust: entries.push(("CustomName", Tag::String(name.as_str().into())));
}
    // rust: entries.push(("components", Tag::Compound(b.components.clone())));
    // rust: Some(Tag::compound(entries))
}
        // VaultBlockEntity.getUpdateTag: the shared data, which holds the display item.
    // rust: BlockEntity::Vault(v) => Some(v.update_tag()),
        // TrialSpawnerStateData.getUpdateTag: the spawn data the mob is drawn from.
        // next_mob_spawns_at (ACTIVE only) is left out: nothing in the client
        // reads it, and the block state it depends on is not known here.
    // rust: BlockEntity::TrialSpawner(t) => t
    // rust: .next_spawn_data
    // rust: .as_ref()
    // rust: .map(|d| Tag::compound([("spawn_data", d.encode())])),
        // SkullBlockEntity: the profile is the whole reason a head differs.
    // rust: BlockEntity::Skull(s) => {
    // rust: let mut entries = Vec::new();
    // rust: if let Some(profile) = &s.profile {
    // rust: entries.push(("profile", profile.clone()));
}
    // rust: if let Some(sound) = &s.note_block_sound {
    // rust: entries.push(("note_block_sound", Tag::String(sound.as_str().into())));
}
    // rust: if let Some(name) = &s.custom_name {
    // rust: entries.push(("custom_name", name.clone()));
}
    // rust: Some(Tag::compound(entries))
}
        // BeaconBlockEntity.getUpdateTag: saveCustomOnly, the effects and the
        // levels (no name or lock is kept here).
    // rust: BlockEntity::Beacon(b) => {
    // rust: let mut entries = Vec::new();
    // rust: if let Some(effect) = &b.primary {
    // rust: entries.push(("primary_effect", Tag::String(effect.as_str().into())));
}
    // rust: if let Some(effect) = &b.secondary {
    // rust: entries.push(("secondary_effect", Tag::String(effect.as_str().into())));
}
    // rust: entries.push(("Levels", Tag::Int(b.levels)));
    // rust: Some(Tag::compound(entries))
}
        // TheEndGatewayBlockEntity.getUpdateTag: saveCustomOnly, so the age the
        // client's beam counts from, the exit and ExactTeleport when set.
    // rust: BlockEntity::EndGateway(g) => {
    // rust: let mut entries = vec![("Age", Tag::Long(g.age))];
    // rust: if let Some(exit) = g.exit_portal {
    // rust: entries.push(("exit_portal", Tag::IntArray(exit.to_vec())));
}
    // rust: if g.exact_teleport {
    // rust: entries.push(("ExactTeleport", Tag::Byte(1)));
}
    // rust: Some(Tag::compound(entries))
}
        // CreakingHeartBlockEntity.getUpdateTag: saveCustomOnly, the protector.
    // rust: BlockEntity::CreakingHeart(h) => Some(Tag::compound(
    // rust: h.creaking
    // rust: .map(|(_, uuid)| ("creaking", crate::save::uuid_tag(uuid))),
    // rust: )),
        // No getUpdatePacket: these, chests, hives, command blocks and the rest.
    // rust: BlockEntity::Jukebox(_) | BlockEntity::Lectern(_) => None,
        // CampfireBlockEntity.getUpdateTag: the items alone.
    // rust: BlockEntity::Campfire(c) => Some(Tag::compound([(
    // rust: "Items",
    // rust: crate::save::encode_items(&c.items),
    // rust: )])),
    // rust: _ => None,
}
}

/// The update tag of the decorated pot at `pos` (DecoratedPotBlockEntity.getUpdateTag,
/// saveCustomOnly). A pot is not a block entity here: its tag is the chunk's saved one.
pub fn pot_tag(chunk: *Chunk, pos: (i32) void {
}
    // rust: let at = chunk.saved.as_ref()?.block_entities.iter().find(|t| {
    // rust: t.get("id") == Some(&Tag::String("minecraft:decorated_pot".into()))
    // rust: && t.get("x") == Some(&Tag::Int(pos.0))
    // rust: && t.get("y") == Some(&Tag::Int(pos.1))
    // rust: && t.get("z") == Some(&Tag::Int(pos.2))
    // rust: })?;
    // rust: let entries: Vec<_> = ["sherds", "LootTable", "LootTableSeed", "item"]
    // rust: .into_iter()
    // rust: .filter_map(|k| Some((k, at.get(k)?.clone())))
    // rust: .collect();
    // rust: (!entries.is_empty()).then(|| Tag::compound(entries))
}

/// Light sections run from one below the world to one above it. A layer
/// exists where vanilla's light storage keeps one: within one section of a
/// non-air section of this column or a neighbouring one (`around`, index i
/// for section i; LayerLightSectionStorage.updateSectionStatus). An existing
/// layer is sent, or marked empty when all dark; the others are left out.
pub fn light_data(sections: *[*Section], around: SectionMask) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let lights = light_sections(sections, around, SectionLight::of);
    // rust: light_data_of(&lights, true)
}

/// A light section's two DataLayers, written from a resident section's own
/// light (a layer it keeps is already a DataLayer), or one value everywhere.
pub const SectionLight = enum {
    /// A section, and whether its sky and its block layer hold any light.
    Of(Arc<Section>, bool, bool),
    /// Sky light in the high nibble, block light in the low one.
    Uniform(u8),
};
    // rust: impl SectionLight {
pub fn of(section: **Section) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match section.light {
    // rust: Light::Uniform(v) => Self::Uniform(v),
    // rust: ref light => Self::Of(section.clone(), light.any(0xF0), light.any(15)),
}
}
    /// Whether the sky and the block layer hold any light.
pub fn any(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Of(_, sky, block) => (*sky, *block),
    // rust: Self::Uniform(v) => (v >> 4 != 0, v & 15 != 0),
}
}
    /// Append the sky or the block layer's 2048 bytes.
pub fn put(self: *Self, sky: bool, out: *mut std.ArrayList(u8)) void {
}
    // rust: let fill = |out: &mut Vec<u8>, n: u8| out.resize(out.len() + 2048, n | n << 4);
    // rust: match self {
    // rust: Self::Uniform(v) => fill(out, if sky { v >> 4 } else { v & 15 }),
    // rust: Self::Of(section, ..) => match &section.light {
    // rust: Light::Uniform(v) => fill(out, if sky { v >> 4 } else { v & 15 }),
    // rust: Light::Sky(layer, _) if sky => out.extend_from_slice(&layer[..]),
    // rust: Light::Sky(_, block) => fill(out, *block),
    // rust: Light::Block(layer, _) if !sky => out.extend_from_slice(&layer[..]),
    // rust: Light::Block(_, sky_light) => fill(out, *sky_light),
    // rust: Light::Full(a) => out.extend(a.as_chunks::<2>().0.iter().map(|&[even, odd]| {
    // rust: if sky {
    // rust: even >> 4 | (odd & 0xF0)
    // rust: } else {
    // rust: (even & 15) | odd << 4
}
    // rust: })),
    // rust: },
}
}
}

/// The existing light sections, by index from below the world, with their
/// layers (`section` giving a section of the world's).
    // rust: fn light_sections(
    // rust: sections: &[Arc<Section>],
    // rust: around: SectionMask,
    // rust: section: impl Fn(&Arc<Section>) -> SectionLight,
    // rust: ) -> Vec<(usize, SectionLight)> {
    // rust: let n = sections.len();
    // Light section b holds chunk section b - 1.
    // rust: let exists =
    // rust: |b: usize| (b.saturating_sub(2)..=b.min(n - 1)).any(|s| s + 2 >= b && around.contains(s));
    // rust: (0..n + 2)
    // rust: .filter(|&b| exists(b))
    // rust: .map(|b| {
    // rust: let light = match b {
                // Below the world nothing is lit; above it the sky is full.
    // rust: 0 => SectionLight::Uniform(0),
    // rust: _ if b == n + 1 => SectionLight::Uniform(0xF0),
    // rust: _ => section(&sections[b - 1]),
}
    // rust: (b, light)
    // rust: })
    // rust: .collect()
}

/// The four masks of ClientboundLightUpdatePacketData (sky, block, empty
/// sky, empty block); a level without sky light has no sky storage at all.
pub fn light_masks(lights: *[(usize) void {
}
    // rust: let mut masks: [Vec<u8>; 4] = Default::default();
    // rust: for (b, light) in lights {
    // rust: let (sky_any, block_any) = light.any();
    // rust: if sky {
    // rust: set_bit(&mut masks[if sky_any { 0 } else { 2 }], *b);
}
    // rust: set_bit(&mut masks[if block_any { 1 } else { 3 }], *b);
}
    // rust: masks
}

/// The layers sent of one kind: those with any light.
    // rust: fn sent_layers(
    // rust: lights: &[(usize, SectionLight)],
    // rust: sky: bool,
    // rust: ) -> impl Iterator<Item = &SectionLight> + Clone {
    // rust: lights.iter().map(|(_, l)| l).filter(move |l| {
    // rust: let (sky_any, block_any) = l.any();
    // rust: if sky { sky_any } else { block_any }
    // rust: })
}

pub fn light_data_of(lights: *[(usize) void {
}
    // rust: let [sky_mask, block_mask, empty_sky_mask, empty_block_mask] = light_masks(lights, sky);
    // rust: let layers = |kind: bool| -> Vec<Vec<u8>> {
    // rust: sent_layers(lights, kind)
    // rust: .map(|l| {
    // rust: let mut layer = Vec::with_capacity(2048);
    // rust: l.put(kind, &mut layer);
    // rust: layer
    // rust: })
    // rust: .collect()
}
    // rust: LightData {
    // rust: sky_mask,
    // rust: block_mask,
    // rust: empty_sky_mask,
    // rust: empty_block_mask,
    // rust: sky: if sky { layers(true) } else { Vec::new() },
    // rust: block: layers(false),
}
}

/// LightData.write, from the layers themselves.
pub fn write_light(lights: *[(usize) void {
}
    // rust: for mask in light_masks(lights, sky) {
    // rust: BitSet::write(&mask, w);
}
    // rust: for kind in [true, false] {
    // rust: let layers = sent_layers(lights, kind).filter(|_| sky || !kind);
    // rust: w.varint(layers.clone().count() as i32);
    // rust: for l in layers {
    // rust: w.varint(2048);
    // rust: l.put(kind, &mut w.data);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::chunk::{MIN_Y, SECTIONS};
//     use horizon_protocol::packets::play;
//     use horizon_world::nbt::JavaString;

pub fn block_entity_blocks_are_recognised() void {
}
    // rust: assert_eq!(
    // rust: block_entity_type("minecraft:oak_sign"),
    // rust: Some("minecraft:sign")
    // rust: );
    // rust: assert_eq!(
    // rust: block_entity_type("minecraft:oak_wall_hanging_sign"),
    // rust: Some("minecraft:hanging_sign")
    // rust: );
    // rust: assert_eq!(
    // rust: block_entity_type("minecraft:red_shulker_box"),
    // rust: Some("minecraft:shulker_box")
    // rust: );
    // rust: assert_eq!(block_entity_type("minecraft:stone"), None);
}

pub fn block_entities_come_from_the_cached_section_in_scan_order() void {
}
    // rust: let builtin = Builtin::parse(
    // rust: r#"{"minecraft:block_entity_type": {"entries": {
    // rust: "minecraft:chest": {"protocol_id": 1},
    // rust: "minecraft:sign": {"protocol_id": 7}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let states = [
    // rust: "minecraft:air",
    // rust: "minecraft:stone",
    // rust: "minecraft:chest",
    // rust: "minecraft:oak_sign",
    // rust: ]
    // rust: .map(|n| (Arc::<str>::from(n), false));
    // rust: let encoder = ChunkEncoder::new(states, &builtin, &[], &[]);
    // rust: let mut chunk = Chunk::empty(2, -3);
    // rust: for (x, y, z, state) in [(15, 3, 0, 2), (0, 3, 15, 3), (4, 3, 4, 1), (7, 40, 2, 2)] {
    // rust: chunk.set(x, MIN_Y + y, z, state);
}
        // Every block of a section looked at, as the scan did before the cache.
    // rust: let scan = |chunk: &Chunk| {
    // rust: let mut found = Vec::new();
    // rust: for (i, s) in chunk.sections.iter().enumerate() {
    // rust: for y in 0..16 {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let state = s.get(crate::chunk::index(x, y, z));
    // rust: if let Some(kind) = encoder.entity_type(state) {
    // rust: found.push((x, MIN_Y + i as i32 * 16 + y, z, kind));
}
}
}
}
}
            // Then the order the packet gives them, as encode_blocks does.
    // rust: java_hash_order(&mut found, |e| {
    // rust: (chunk.x * 16 + e.0, e.1, chunk.z * 16 + e.2)
    // rust: });
    // rust: found
}
    // rust: let sent = |chunk: &Chunk| {
    // rust: let packet = encoder.encode(chunk, &HashMap::new());
    // rust: let infos = packet.chunk.block_entities;
    // rust: infos
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let xz = e.packed_xz as u8;
    // rust: (
    // rust: i32::from(xz >> 4),
    // rust: i32::from(e.y),
    // rust: i32::from(xz & 15),
    // rust: e.kind,
    // rust: )
    // rust: })
    // rust: .collect::<Vec<_>>()
}
    // rust: let expected = scan(&chunk);
    // rust: assert_eq!(expected.len(), 3);
    // rust: assert_eq!(sent(&chunk), expected);
        // From the cache the second time, and after an edit.
    // rust: assert_eq!(sent(&chunk), expected);
    // rust: chunk.set(15, MIN_Y + 3, 0, 0);
    // rust: chunk.set(9, MIN_Y + 3, 9, 3);
    // rust: assert_eq!(sent(&chunk), scan(&chunk));
}

    /// A mod block's block entity goes out with its block's own type and the
    /// tag its mod gives; a mod block whose mod made none is left out.
pub fn mod_block_entities_carry_their_blocks_type_and_the_mods_tag() void {
}
    // rust: let builtin = Builtin::parse(
    // rust: r#"{"minecraft:block_entity_type": {"entries": {
    // rust: "minecraft:chest": {"protocol_id": 1},
    // rust: "test:machine": {"protocol_id": 49},
    // rust: "test:casing": {"protocol_id": 50}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let states =
    // rust: ["minecraft:air", "test:machine", "test:casing"].map(|n| (Arc::<str>::from(n), false));
    // rust: let mut encoder = ChunkEncoder::new(states, &builtin, &[], &[]);
    // rust: encoder.mod_update_tag = Some(|pos, entity| {
    // rust: let mut tag = Compound::new();
    // rust: tag.insert(
    // rust: "active".into(),
    // rust: entity.nbt.get(&JavaString::from("active"))?.clone(),
    // rust: );
    // rust: tag.insert("x".into(), Tag::Int(pos[0]));
    // rust: Some(tag)
    // rust: });
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(1, MIN_Y + 2, 3, 1);
    // rust: chunk.set(5, MIN_Y + 2, 5, 2);
    // rust: let mut machine = ModBlockEntity::new(crate::containers::ModBlockEntityFields {
    // rust: id: "test:machine".into(),
    // rust: ..Default::default()
    // rust: });
    // rust: machine.nbt.insert("active".into(), Tag::Byte(1));
    // rust: machine.nbt.insert("recipe".into(), Tag::Int(7));
    // rust: let block_entities =
    // rust: HashMap::from([((1, MIN_Y + 2, 3), BlockEntity::Mod(Box::new(machine)))]);
    // rust: let infos = encoder.encode(&chunk, &block_entities).chunk.block_entities;
    // rust: assert_eq!(infos.len(), 1, "the casing has no block entity");
    // rust: assert_eq!((infos[0].kind, infos[0].y), (49, (MIN_Y + 2) as i16));
    // rust: let mut expected = Compound::new();
    // rust: expected.insert("active".into(), Tag::Byte(1));
    // rust: expected.insert("x".into(), Tag::Int(1));
    // rust: assert_eq!(infos[0].tag, Tag::Compound(expected));
        // As does an encoder for saved chunks past the view distance (`lan::far`).
    // rust: let far = encoder.detached().encode(&chunk, &block_entities);
    // rust: assert_eq!(far.chunk.block_entities[0].tag, infos[0].tag);
        // An empty tag is not sent either (BlockEntityInfo.create).
    // rust: encoder.mod_update_tag = Some(|_, _| Some(Compound::new()));
    // rust: let infos = encoder.encode(&chunk, &block_entities).chunk.block_entities;
    // rust: assert_eq!(infos[0].tag, Tag::End);
        // Without the hook, nothing of it is sent.
    // rust: encoder.mod_update_tag = None;
    // rust: let infos = encoder.encode(&chunk, &block_entities).chunk.block_entities;
    // rust: assert_eq!(infos[0].tag, Tag::End);
}

    /// A mod's sign is of vanilla's block entity type, as its block is on
    /// `BlockEntityType.SIGN`'s list, and goes out with its text. Another mod
    /// block's type stays its own, and a sign block entity on it stays out.
pub fn a_mods_sign_goes_out_with_vanillas_type_and_its_text() void {
}
//         use crate::blocks::SignForm;

    // rust: let builtin = Builtin::parse(
    // rust: r#"{"minecraft:block_entity_type": {"entries": {
    // rust: "minecraft:sign": {"protocol_id": 7},
    // rust: "minecraft:hanging_sign": {"protocol_id": 8},
    // rust: "test:notice": {"protocol_id": 49},
    // rust: "test:lantern": {"protocol_id": 50},
    // rust: "test:casing": {"protocol_id": 51}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let states = [
    // rust: "minecraft:air",
    // rust: "test:notice",
    // rust: "test:lantern",
    // rust: "test:casing",
    // rust: ]
    // rust: .map(|n| (Arc::<str>::from(n), false));
    // rust: let states = states.map(|(name, fluid)| {
    // rust: let form = match &*name {
    // rust: "test:notice" => Some(SignForm {
    // rust: hanging: false,
    // rust: wall: false,
    // rust: }),
    // rust: "test:lantern" => Some(SignForm {
    // rust: hanging: true,
    // rust: wall: true,
    // rust: }),
    // rust: _ => None,
}
    // rust: (name, fluid, form)
    // rust: });
    // rust: let encoder = ChunkEncoder::with_signs(states, &builtin, &[], &[]);
    // rust: let (notice, lantern, casing) = ((1, MIN_Y + 2, 3), (5, MIN_Y + 2, 5), (9, MIN_Y + 2, 9));
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(notice.0, notice.1, notice.2, 1);
    // rust: chunk.set(lantern.0, lantern.1, lantern.2, 2);
    // rust: chunk.set(casing.0, casing.1, casing.2, 3);
    // rust: let mut sign = crate::signs::SignData::default();
    // rust: sign.front.lines[0] = "Hello".into();
    // rust: let hanging = crate::signs::SignData {
    // rust: hanging: true,
    // rust: ..Default::default()
}
    // rust: let block_entities = HashMap::from([
    // rust: (notice, BlockEntity::Sign(sign.clone())),
    // rust: (lantern, BlockEntity::Sign(hanging.clone())),
    // rust: (casing, BlockEntity::Sign(sign.clone())),
    // rust: ]);
    // rust: let infos = encoder.encode(&chunk, &block_entities).chunk.block_entities;
    // rust: let sent = |kind: i32| infos.iter().find(|i| i.kind == kind).map(|i| &i.tag);
    // rust: assert_eq!(sent(7), Some(&Tag::compound(sign.encode())));
    // rust: assert_eq!(sent(8), Some(&Tag::compound(hanging.encode())));
    // rust: assert_eq!(infos.len(), 2, "the casing is no sign: {infos:?}");
        // The same encoder supplies the type and fresh tag for incremental
        // BlockEntityData packets, even after the chunk's section was cached.
    // rust: sign.back.lines[0] = "Back".into();
    // rust: sign.front.color = 9;
    // rust: sign.back.glowing = true;
    // rust: sign.waxed = true;
    // rust: let entity = BlockEntity::Sign(sign);
    // rust: assert_eq!(encoder.entity_type(1), Some(7));
    // rust: assert_eq!(encoder.entity_type(2), Some(8));
    // rust: let tag = encoder.update_tag(notice, &entity).unwrap();
    // rust: let mut nbt = match tag {
    // rust: Tag::Compound(fields) => fields,
    // rust: _ => panic!("sign update is not a compound"),
}
    // rust: nbt.insert("id".into(), Tag::String("minecraft:sign".into()));
    // rust: for (axis, value) in ["x", "y", "z"]
    // rust: .into_iter()
    // rust: .zip([notice.0, notice.1, notice.2])
    // rust: {
    // rust: nbt.insert(axis.into(), Tag::Int(value));
}
    // rust: let (_, loaded) = crate::save::decode_block_entity(&Tag::Compound(nbt)).unwrap();
    // rust: assert!(
    // rust: matches!((&loaded, &entity), (BlockEntity::Sign(a), BlockEntity::Sign(b)) if a == b)
    // rust: );
    // rust: let changed = HashMap::from([(notice, entity)]);
    // rust: for encoder in [encoder.detached(), encoder] {
    // rust: let sent = encoder.encode(&chunk, &changed).chunk.block_entities;
    // rust: assert_eq!(
    // rust: sent.iter().find(|i| i.kind == 7).unwrap().tag,
    // rust: encoder.update_tag(notice, &changed[&notice]).unwrap()
    // rust: );
}
}

pub fn encoder() C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let states = ["minecraft:air", "minecraft:stone", "minecraft:water"]
    // rust: .map(|n| (Arc::<str>::from(n), n.ends_with("water")));
    // rust: ChunkEncoder::new(states, &Builtin::default(), &[], &[])
}

    /// The bytes on the wire for a section, encoded afresh.
pub fn fresh(encoder: *ChunkEncoder, section: *Section) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: encoder.coder.section(section).0.write(&mut w);
    // rust: w.data
}

pub fn uniform_and_mixed_biomes_keep_the_network_palette() void {
}
    // rust: let names = ["minecraft:plains".to_owned(), "minecraft:desert".to_owned()];
    // rust: let encoder = ChunkEncoder::new(
    // rust: [(Arc::<str>::from("minecraft:air"), false)],
    // rust: &Builtin::default(),
    // rust: &names,
    // rust: &[names[1].clone(), names[0].clone()],
    // rust: );
    // rust: let mut section = Section::default();
    // rust: assert_eq!(
    // rust: encoder.coder.biomes(&section),
    // rust: Paletted {
    // rust: bits: 0,
    // rust: palette: vec![1],
    // rust: data: Vec::new()
}
    // rust: );
    // rust: section.biomes.set(13, 1);
    // rust: let mut expected = [1; BIOMES];
    // rust: expected[13] = 0;
    // rust: assert_eq!(
    // rust: encoder.coder.biomes(&section),
    // rust: Paletted::from_values(&expected, Strategy::Biomes, 1)
    // rust: );
    // rust: section.biomes.set(13, 0);
    // rust: assert_eq!(
    // rust: encoder.coder.biomes(&section),
    // rust: Paletted {
    // rust: bits: 0,
    // rust: palette: vec![1],
    // rust: data: Vec::new()
}
    // rust: );
    // rust: section.biomes =
    // rust: horizon_core::paletted::PalettedContainer::new(section.biomes.strategy(), 99);
    // rust: assert_eq!(
    // rust: encoder.coder.biomes(&section),
    // rust: Paletted {
    // rust: bits: 0,
    // rust: palette: vec![0],
    // rust: data: Vec::new()
}
    // rust: );
}

pub fn a_batch_encodes_each_shared_section_once() void {
}
    // rust: let encoder = encoder();
    // rust: let air = Arc::new(Section::default());
    // rust: let mut stone = Section::default();
    // rust: stone.blocks = horizon_core::paletted::PalettedContainer::new(stone.blocks.strategy(), 1);
    // rust: let stone = Arc::new(stone);
    // rust: let mut edited = Chunk::empty(9, 9);
    // rust: edited.set(3, MIN_Y + 40, 5, 2);
    // rust: let mixed = edited.sections[2].clone();
    // rust: let (mut a, mut b) = (Chunk::empty(0, 0), Chunk::empty(1, 0));
    // rust: for (i, s) in a.sections.iter_mut().enumerate() {
    // rust: *s = if i % 2 == 0 {
    // rust: air.clone()
    // rust: } else {
    // rust: stone.clone()
}
}
    // rust: for (i, s) in b.sections.iter_mut().enumerate() {
    // rust: *s = if i % 3 == 0 {
    // rust: stone.clone()
    // rust: } else {
    // rust: air.clone()
}
}
    // rust: a.sections[7] = mixed.clone();
    // rust: b.sections[5] = mixed.clone();
    // rust: let job = encoder.job(&[&a, &b]).unwrap();
    // rust: assert_eq!(job.sections.len(), 3);
    // rust: job.run();
    // rust: encoder.keep(&job);
    // rust: for s in [&air, &stone, &mixed] {
    // rust: let kept = encoder
    // rust: .cached(s, |e| e.wire.clone())
    // rust: .expect("kept by the job");
    // rust: assert_eq!(&*kept.0, fresh(&encoder, s));
}
    // rust: for c in [&a, &b] {
    // rust: let expected: Vec<u8> = c.sections.iter().flat_map(|s| fresh(&encoder, s)).collect();
    // rust: assert_eq!(encoder.encode(c, &HashMap::new()).chunk.buffer, expected);
}
}

pub fn uniform_and_mixed_sections_report_the_same_occupancy() void {
}
    // rust: let encoder = encoder();
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for (i, state) in [(1, 1), (4, 2), (10, 99)] {
    // rust: let section = Arc::make_mut(&mut chunk.sections[i]);
    // rust: section.blocks =
    // rust: horizon_core::paletted::PalettedContainer::new(section.blocks.strategy(), state);
}
    // rust: chunk.set(1, MIN_Y + 7 * 16, 1, 1);
    // rust: assert_eq!(encoder.occupied(&chunk), SectionMask::from_iter([1, 4, 7]));
    // rust: chunk.set(1, MIN_Y + 7 * 16, 1, 0);
    // rust: assert_eq!(encoder.occupied(&chunk), SectionMask::from_iter([1, 4]));
}

pub fn cached_sections_follow_edits() void {
}
    // rust: let encoder = encoder();
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(1, MIN_Y + 2, 3, 1);
    // rust: let before = encoder.encode(&chunk, &HashMap::new());
    // rust: assert_eq!(encoder.occupied(&chunk), SectionMask::single(0));
    // rust: assert_eq!(
    // rust: &*encoder.section_wire(&chunk.sections[0]).0,
    // rust: fresh(&encoder, &chunk.sections[0])
    // rust: );
        // An edit moves the section: the cache sees a new one.
    // rust: chunk.set(4, MIN_Y + 20, 4, 2);
    // rust: chunk.set(1, MIN_Y + 2, 3, 0);
    // rust: assert_eq!(encoder.occupied(&chunk), SectionMask::single(1));
    // rust: let after = encoder.encode(&chunk, &HashMap::new());
    // rust: assert_ne!(before.chunk.buffer, after.chunk.buffer);
    // rust: let mut expected = Vec::new();
    // rust: for s in &chunk.sections {
    // rust: expected.extend(fresh(&encoder, s));
}
    // rust: assert_eq!(after.chunk.buffer, expected);
}

pub fn light_layers_pack_two_blocks_per_byte() void {
}
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: let mut light = Box::new([0u8; 4096]);
    // rust: for (i, v) in light.iter_mut().enumerate() {
    // rust: *v = (i * 37 % 251) as u8;
}
    // rust: Arc::make_mut(&mut chunk.sections[3]).light = Light::Full(light.clone());
    // rust: let data = light_data(&chunk.sections, SectionMask::ALL);
        // Layer 4 holds section 3. Below the world (layer 0) there is no sky
        // light, so the sky layers listed start at layer 1; section 3 has the
        // only block light.
    // rust: let (sky, block) = (&data.sky[3], &data.block[0]);
    // rust: for j in 0..4096 {
    // rust: let (s, b) = if j & 1 == 0 {
    // rust: (sky[j >> 1] & 15, block[j >> 1] & 15)
    // rust: } else {
    // rust: (sky[j >> 1] >> 4, block[j >> 1] >> 4)
}
    // rust: assert_eq!((s, b), (light[j] >> 4, light[j] & 15), "block {j}");
}
}

pub fn cached_light_follows_edits() void {
}
    // rust: let encoder = encoder();
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: let mut light = Box::new([0x5Au8; 4096]);
    // rust: Arc::make_mut(&mut chunk.sections[2]).light = Light::Full(light.clone());
    // rust: let first = encoder.encode(&chunk, &HashMap::new()).light;
    // rust: assert_eq!(first, light_data(&chunk.sections, SectionMask::ALL));
        // Relighting moves the section, so the cached layers aren't reused.
    // rust: light[7] = 0xF3;
    // rust: Arc::make_mut(&mut chunk.sections[2]).light = Light::Full(light);
    // rust: let second = encoder.encode(&chunk, &HashMap::new()).light;
    // rust: assert_ne!(first, second);
    // rust: assert_eq!(second, light_data(&chunk.sections, SectionMask::ALL));
        // Sent again unchanged (a player coming back in range), the same light.
    // rust: assert_eq!(encoder.encode(&chunk, &HashMap::new()).light, second);
}

    /// A light update carries the layers of the sections that changed, and
    /// only those.
pub fn light_updates_carry_the_changed_sections() void {
}
    // rust: let encoder = encoder();
    // rust: let mut chunk = Chunk::empty(0, 0);
        // Sky light 5 and block light 10 in section 2, others in section 5.
    // rust: Arc::make_mut(&mut chunk.sections[2]).light = Light::Full(Box::new([0x5A; 4096]));
    // rust: Arc::make_mut(&mut chunk.sections[5]).light = Light::Full(Box::new([0x21; 4096]));
    // rust: let mut changed = SectionMask::EMPTY;
    // rust: changed.insert(2);
    // rust: let bytes = encoder.light_update(&chunk, changed);
    // rust: let mut r = horizon_protocol::buf::Reader::new(&bytes);
    // rust: let id = r.varint().unwrap();
    // rust: let Ok(play::Clientbound::LightUpdate(update)) = play::Clientbound::decode(id, r.rest())
    // rust: else {
    // rust: panic!("not a light update");
}
    // rust: let light = update.light;
        // Light section 3 holds section 2, the only one sent.
    // rust: let bit = horizon_protocol::buf::bit;
    // rust: let sent = |mask: &[u8]| {
    // rust: (0..SECTIONS + 2)
    // rust: .filter(|&b| bit(mask, b))
    // rust: .collect::<Vec<_>>()
}
    // rust: assert_eq!(sent(&light.sky_mask), [3]);
    // rust: assert_eq!(sent(&light.block_mask), [3]);
    // rust: assert_eq!(light.sky, [vec![0x55; 2048]]);
    // rust: assert_eq!(light.block, [vec![0xAA; 2048]]);
}

    /// A neighbour still a proto chunk counts for the light layers as it
    /// will once loaded (#4294: vanilla counts a neighbour at
    /// INITIALIZE_LIGHT).
pub fn a_proto_neighbour_counts_for_the_light_layers() void {
}
    // rust: let encoder = encoder();
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: for x in -1..=1 {
    // rust: for z in -1..=1 {
    // rust: let mut chunk = Chunk::empty(x, z);
    // rust: chunk.set(0, MIN_Y, 0, 1);
    // rust: world.chunks.insert((x, z), Arc::new(chunk));
}
}
        // The neighbour east has a block ten sections up.
    // rust: let mut tall = Chunk::empty(1, 0);
    // rust: tall.set(0, MIN_Y, 0, 1);
    // rust: tall.set(0, MIN_Y + 16 * 10, 0, 1);
    // rust: world.chunks.insert((1, 0), Arc::new(tall));
    // rust: let centre = world.chunks[&(0, 0)].clone();
    // rust: let loaded = encoder.body_in(&centre, &world);
    // rust: world.chunks.remove(&(1, 0));
    // rust: assert_ne!(encoder.body_in(&centre, &world), loaded);
    // rust: let mut sections = SectionMask::EMPTY;
    // rust: sections.insert(0);
    // rust: sections.insert(10);
    // rust: let proto = |x, z| ((x, z) == (1, 0)).then_some(sections);
    // rust: assert_eq!(encoder.body_with(&centre, &world, &proto), loaded);
}

pub fn light_masks_cover_the_world_plus_borders() void {
}
    // rust: let chunk = Chunk::empty(0, 0);
        // A column with nothing around it has no light layers at all.
    // rust: assert!(
    // rust: light_data(&chunk.sections, SectionMask::EMPTY)
    // rust: .sky
    // rust: .is_empty()
    // rust: );
    // rust: let data = light_data(&chunk.sections, SectionMask::ALL);
        // Default sections are full sky light and no block light.
    // rust: assert_eq!(data.sky.len(), SECTIONS + 1);
    // rust: assert_eq!(data.block.len(), 0);
    // rust: assert_eq!(data.sky[0][0], 0xFF);
    // rust: assert!(horizon_protocol::buf::bit(&data.empty_block_mask, 5));
}

pub fn the_body_is_the_packet_encoded() void {
}
    // rust: let builtin = Builtin::parse(
    // rust: r#"{"minecraft:block_entity_type": {"entries": {
    // rust: "minecraft:chest": {"protocol_id": 1},
    // rust: "minecraft:sign": {"protocol_id": 7}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let states = [
    // rust: "minecraft:air",
    // rust: "minecraft:stone",
    // rust: "minecraft:chest",
    // rust: "minecraft:oak_sign",
    // rust: ]
    // rust: .map(|n| (Arc::<str>::from(n), false));
    // rust: let mut encoder = ChunkEncoder::new(states, &builtin, &[], &[]);
    // rust: let mut chunk = Chunk::empty(-7, 12);
        // Every kind of light section: uniform dark, uniform lit, sky and
        // block light varying, none at all.
    // rust: let mut light = Box::new([0u8; 4096]);
    // rust: for (i, v) in light.iter_mut().enumerate() {
    // rust: *v = (i * 53 % 256) as u8;
}
    // rust: Arc::make_mut(&mut chunk.sections[4]).light = Light::Full(light);
    // rust: Arc::make_mut(&mut chunk.sections[5]).light = Light::Uniform(0x07);
    // rust: Arc::make_mut(&mut chunk.sections[6]).light = Light::Uniform(0);
    // rust: Arc::make_mut(&mut chunk.sections[7]).light = Light::Full(Box::new([0x30; 4096]));
    // rust: for (x, y, z, state) in [
    // rust: (3, 70, 9, 1),
    // rust: (5, 70, 5, 2),
    // rust: (0, -60, 15, 2),
    // rust: (15, 300, 0, 1),
    // rust: (8, 64, 1, 3),
    // rust: ] {
    // rust: chunk.set(x, y, z, state);
}
        // A sign's update tag goes with the column.
    // rust: let mut entities = HashMap::new();
    // rust: entities.insert(
    // rust: (-7 * 16 + 8, 64, 12 * 16 + 1),
    // rust: BlockEntity::Sign(crate::signs::SignData::default()),
    // rust: );
    // rust: let packet = |encoder: &ChunkEncoder, around: SectionMask| {
    // rust: let mut packet = encoder.encode_blocks(&chunk, &entities);
    // rust: packet.light = encoder.light_data(&chunk, around);
    // rust: horizon_protocol::packets::play::Clientbound::LevelChunkWithLight(packet).encode()
}
    // rust: let sent = encoder
    // rust: .encode_blocks(&chunk, &entities)
    // rust: .chunk
    // rust: .block_entities;
    // rust: assert_eq!(sent.len(), 3);
    // rust: assert!(sent.iter().any(|e| e.tag != Tag::End));
    // rust: for around in [
    // rust: SectionMask::EMPTY,
    // rust: SectionMask::single(0),
    // rust: SectionMask::from_iter([5, 7]),
    // rust: SectionMask::single(23),
    // rust: SectionMask::ALL,
    // rust: ] {
    // rust: assert_eq!(
    // rust: encoder.body(&chunk, &entities, around),
    // rust: packet(&encoder, around),
    // rust: "around {around:?}"
    // rust: );
}
    // rust: encoder.set_dimension(LevelShape::NETHER);
    // rust: assert_eq!(
    // rust: encoder.body(&chunk, &entities, SectionMask::ALL),
    // rust: packet(&encoder, SectionMask::ALL)
    // rust: );
}

    /// Columns whose sections and heightmaps the warm-up threads made give
    /// the bytes each gives on its own, also with a column twice and its
    /// neighbours' sections deciding the light layers.
pub fn stored_palette_ids_pack_as_the_values_do() void {
}
        // Lists with values held twice and ids no entry uses, as `set` can
        // leave them, at every list width blocks use.
    // rust: let mut seed = 0x2545_f491_4f6c_dd1du64;
    // rust: let mut next = |n: u64| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: seed % n
}
    // rust: for len in [2usize, 3, 15, 16, 17, 40, 200, 256] {
    // rust: let list: Vec<u32> = (0..len).map(|_| next(30_000) as u32).collect();
    // rust: let mut list = list;
    // rust: list[len - 1] = list[0];
    // rust: let used = (len - 1).max(1) as u64;
    // rust: let raw: Vec<u16> = (0..BLOCKS).map(|_| next(used) as u16).collect();
    // rust: let values: Vec<i32> = raw.iter().map(|&r| list[usize::from(r)] as i32).collect();
    // rust: let (palette, ids, uses) = network_palette(&list, &raw);
    // rust: assert_eq!(
    // rust: Paletted::from_palette(palette, &ids, Strategy::Blocks, 15),
    // rust: Paletted::from_values(&values, Strategy::Blocks, 15),
    // rust: "{len} stored ids"
    // rust: );
    // rust: assert_eq!(
    // rust: uses.iter().map(|&n| i32::from(n)).sum::<i32>(),
    // rust: BLOCKS as i32
    // rust: );
}
}

pub fn warmed_columns_give_the_same_bodies() void {
}
    // rust: let builtin = Builtin::parse(
    // rust: r#"{"minecraft:block_entity_type": {"entries": {
    // rust: "minecraft:sign": {"protocol_id": 7}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let states = [
    // rust: "minecraft:air",
    // rust: "minecraft:stone",
    // rust: "minecraft:water",
    // rust: "minecraft:oak_sign",
    // rust: ]
    // rust: .map(|n| (Arc::<str>::from(n), n.ends_with("water")));
    // rust: let mut world = crate::world::World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: for x in -2..2 {
    // rust: for z in -2..2 {
    // rust: let mut chunk = Chunk::empty(x, z);
    // rust: let n = (x * 7 + z * 13).rem_euclid(17);
    // rust: for i in 0..40 + n * 30 {
    // rust: let (bx, bz) = ((i * 5 + n) % 16, (i * 11) % 16);
    // rust: chunk.set(bx, MIN_Y + (i * 37 + n * 50) % 384, bz, 1 + (i % 3) as u32);
}
    // rust: let mut light = Box::new([0u8; 4096]);
    // rust: for (i, v) in light.iter_mut().enumerate() {
    // rust: *v = (i * 31 + n as usize) as u8;
}
    // rust: Arc::make_mut(&mut chunk.sections[(n % 24) as usize]).light = Light::Full(light);
    // rust: world.block_entities.insert(
    // rust: (x * 16 + 2, 70, z * 16 + 3),
    // rust: BlockEntity::Sign(crate::signs::SignData::default()),
    // rust: );
    // rust: chunk.set(2, 70, 3, 3);
    // rust: world.chunks.insert((x, z), Arc::new(chunk));
}
}
    // rust: let mut keys: Vec<(i32, i32)> =
    // rust: (-2..2).flat_map(|x| (-2..2).map(move |z| (x, z))).collect();
    // rust: keys.push(keys[5]);
    // rust: let chunks: Vec<&Chunk> = keys
    // rust: .iter()
    // rust: .map(|k| &**world.chunks.get(k).unwrap())
    // rust: .collect();
        // (air, fluid, blocks motion, blocks motion and is not leaves) per state.
    // rust: let tables = Arc::new(crate::save::SaveTables::for_heightmaps(
    // rust: crate::assets::Properties::for_tests(&[
    // rust: (true, false, false, false),
    // rust: (false, false, true, true),
    // rust: (false, true, true, true),
    // rust: (false, false, false, false),
    // rust: ]),
    // rust: ));
    // rust: let mut alone = ChunkEncoder::new(states.clone(), &builtin, &[], &[]);
    // rust: alone.tables = Some(tables.clone());
    // rust: let expected: Vec<Vec<u8>> = chunks.iter().map(|c| alone.body_in(c, &world)).collect();
    // rust: let mut warmed = ChunkEncoder::new(states.clone(), &builtin, &[], &[]);
    // rust: warmed.tables = Some(tables);
    // rust: let bodies = |encoder: &ChunkEncoder| -> Vec<Vec<u8>> {
    // rust: chunks.iter().map(|c| encoder.body_in(c, &world)).collect()
}
    // rust: assert!(chunks.len() * SECTIONS >= WARM_MIN);
    // rust: warmed.warm(&chunks);
    // rust: assert_eq!(bodies(&warmed), expected);
        // Run on this thread alone, the job makes every column's heightmaps
        // (once for the column there twice) and sections.
    // rust: let mut cold = ChunkEncoder::new(states, &builtin, &[], &[]);
    // rust: cold.tables = alone.tables.clone();
    // rust: let job = cold.job(&chunks).unwrap();
    // rust: assert_eq!((job.columns.len(), job.sections.len()), (16, 16 * SECTIONS));
    // rust: job.run();
    // rust: cold.keep(&job);
    // rust: assert_eq!(cold.heights.lock().unwrap().len(), 16);
    // rust: assert_eq!(bodies(&cold), expected);
        // Again, from the cache, with nothing left to warm.
    // rust: warmed.warm(&chunks);
    // rust: assert_eq!(bodies(&warmed), expected);
    // rust: warmed.warm(&[]);
}

    /// A far chunk's body (`lan::far`) leaves nothing of it cached, and is the same each time.
pub fn a_body_alone_leaves_nothing_cached() void {
}
    // rust: let encoder = encoder();
    // rust: let mut chunk = Chunk::empty(3, -1);
    // rust: chunk.set(1, 64, 1, 1);
    // rust: let body = encoder.body_alone(&chunk);
    // rust: assert!(encoder.cache.lock().unwrap().is_empty());
    // rust: assert!(encoder.heights.lock().unwrap().is_empty());
    // rust: assert_eq!(encoder.detached().body_alone(&chunk), body);
    // rust: assert_eq!(encoder.body_alone(&chunk), body);
}

pub fn a_nether_column_sends_its_sixteen_sections_without_sky_light() void {
}
    // rust: let chunk = Chunk::empty(0, 0);
    // rust: let mut encoder = ChunkEncoder::new(
    // rust: [("minecraft:air".into(), false)],
    // rust: &Builtin::default(),
    // rust: &[],
    // rust: &[],
    // rust: );
    // rust: let overworld = encoder.encode(&chunk, &HashMap::new());
    // rust: encoder.set_dimension(LevelShape::NETHER);
    // rust: let nether = encoder.encode(&chunk, &HashMap::new());
        // An all-air section is the same bytes wherever it is.
    // rust: let per_section = overworld.chunk.buffer.len() / SECTIONS;
    // rust: assert_eq!(nether.chunk.buffer.len(), per_section * 16);
    // rust: assert!(nether.light.sky.is_empty() && nether.light.sky_mask.is_empty());
        // Block light layers: one below and one above the sixteen sections.
    // rust: assert!(horizon_protocol::buf::bit(
    // rust: &nether.light.empty_block_mask,
    // rust: 17
    // rust: ));
    // rust: assert!(!horizon_protocol::buf::bit(
    // rust: &nether.light.empty_block_mask,
    // rust: 18
    // rust: ));
}

pub fn a_tall_column_sends_its_whole_height() void {
}
    // rust: let shape = LevelShape::new(-64, 2096, 2096, true, false).unwrap();
    // rust: let mut chunk = Chunk::with_layout(0, 0, shape.column());
    // rust: chunk.set(3, 2000, 4, 1);
    // rust: let mut encoder = encoder();
    // rust: let vanilla = encoder.encode(&Chunk::empty(0, 0), &HashMap::new());
    // rust: encoder.set_dimension(shape);
    // rust: let tall = encoder.encode(&chunk, &HashMap::new());
        // 131 sections, one of them holding stone instead of air: longer than
        // 131 air sections, and the sky light layers reach one above the top.
    // rust: let per_section = vanilla.chunk.buffer.len() / SECTIONS;
    // rust: assert!(tall.chunk.buffer.len() > per_section * 131);
    // rust: assert_eq!(tall.light.sky.len(), 132);
}

pub fn beacon_gateway_and_heart_update_tags_load_on_the_client() void {
}
//         use crate::containers::{Beacon, CreakingHeart, EndGateway};
        // What a client loads from the tag (handleBlockEntityData).
    // rust: let load = |id: &str, entity: BlockEntity| {
    // rust: let Some(Tag::Compound(mut tag)) = entity_tag(&entity) else {
    // rust: panic!("no update tag for {id}");
}
    // rust: tag.insert("id".into(), Tag::String(id.into()));
    // rust: for k in ["x", "y", "z"] {
    // rust: tag.insert(k.into(), Tag::Int(0));
}
    // rust: crate::save::decode_block_entity(&Tag::Compound(tag))
    // rust: .expect("loads")
    // rust: .1
}
    // rust: let beacon = Beacon {
    // rust: levels: 4,
    // rust: primary: Some("minecraft:speed".into()),
    // rust: secondary: Some("minecraft:regeneration".into()),
    // rust: ..Default::default()
}
    // rust: let BlockEntity::Beacon(b) =
    // rust: load("minecraft:beacon", BlockEntity::Beacon(Box::new(beacon)))
    // rust: else {
    // rust: panic!("not a beacon");
}
    // rust: assert_eq!(b.levels, 4);
    // rust: assert_eq!(b.primary.as_deref(), Some("minecraft:speed"));
    // rust: assert_eq!(b.secondary.as_deref(), Some("minecraft:regeneration"));
    // rust: let gateway = EndGateway {
    // rust: age: 150,
    // rust: exit_portal: Some([8, 100, 0]),
    // rust: exact_teleport: false,
}
    // rust: let tag = entity_tag(&BlockEntity::EndGateway(gateway.clone())).unwrap();
    // rust: assert_eq!(tag.get("ExactTeleport"), None);
    // rust: let BlockEntity::EndGateway(g) = load(
    // rust: "minecraft:end_gateway",
    // rust: BlockEntity::EndGateway(gateway.clone()),
    // rust: ) else {
    // rust: panic!("not a gateway");
}
    // rust: assert_eq!(g, gateway);
    // rust: let exact = EndGateway {
    // rust: exact_teleport: true,
    // rust: ..gateway
}
    // rust: let tag = entity_tag(&BlockEntity::EndGateway(exact.clone())).unwrap();
    // rust: assert_eq!(tag.get("ExactTeleport"), Some(&Tag::Byte(1)));
    // rust: let BlockEntity::EndGateway(g) = load(
    // rust: "minecraft:end_gateway",
    // rust: BlockEntity::EndGateway(exact.clone()),
    // rust: ) else {
    // rust: panic!("not a gateway");
}
    // rust: assert_eq!(g, exact);
    // rust: let heart = CreakingHeart {
    // rust: creaking: Some((Some(7), [1, 2, 3, 4])),
    // rust: ..Default::default()
}
    // rust: let BlockEntity::CreakingHeart(h) = load(
    // rust: "minecraft:creaking_heart",
    // rust: BlockEntity::CreakingHeart(Box::new(heart)),
    // rust: ) else {
    // rust: panic!("not a creaking heart");
}
    // rust: assert_eq!(h.creaking, Some((None, [1, 2, 3, 4])));
        // Without a protector the tag is empty.
    // rust: let lone = entity_tag(&BlockEntity::CreakingHeart(Box::default()));
    // rust: assert_eq!(
    // rust: lone,
    // rust: Some(Tag::Compound(horizon_world::nbt::Compound::new()))
    // rust: );
}
}
