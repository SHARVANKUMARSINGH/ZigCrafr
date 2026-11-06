//! Transpiled from Horizon Rust crate
//! Module: horizon-client_random_tick_sections
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Which sections of the game thread's chunks random-tick
//! (`LevelChunkSection.isRandomlyTicking`), memoized per section.
// use crate::{
    // rust: blocks::BlockFacts,
    // rust: chunk::{Chunk, MIN_Y, Section},
    // rust: fast_hash::FxHashMap,
    // rust: section_mask::SectionMask,
}
// use horizon_world::{level::RandomTickMask, registry::BlockStateId};
// use std::rc::Rc;
// use std::sync::{Arc, Weak};

/// A value snapshot, in ascending section order, with no per-chunk allocation.
pub const Sections = struct {
    mask: SectionMask,
    /// The minimum Y of section index 0 (the chunk's).
    base: i32,
};
    // rust: impl Default for Sections {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: mask: SectionMask::EMPTY,
    // rust: base: MIN_Y,
}
}
}
    // rust: impl Sections {
    /// The minimum Y of the lowest section in the set from block `min_y` up.
pub fn from(self: *Self, min_y: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = ((min_y - self.base) >> 4).max(0) as usize;
    // rust: Sections {
    // rust: mask: self.mask.from(index),
    // rust: ..self
}
    // rust: .next()
}
}
    // rust: impl Iterator for Sections {
    // rust: type Item = i32;
pub fn next(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = self.mask.iter().next()?;
    // rust: self.mask.remove(index);
    // rust: Some(self.base + index as i32 * 16)
}
pub fn size_hint(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = self.mask.len();
    // rust: (len, Some(len))
}
}
    // rust: impl ExactSizeIterator for Sections {}

pub const Cached = struct {
    chunk: Weak<Chunk>,
    /// The section each bit of `sections` was read from.
    read: std.ArrayList(Weak<Section)>,
    sections: Sections,
    /// Each ticking section's [`RandomTickMask`], built at its first draw
    /// and dropped when the section is read again. `Rc`, not `Arc`: the
    /// tick thread hands one out per ticking section per tick, and an atomic
    /// count on a mask out of cache stalled the whole random tick loop.
    masks: std.ArrayList(?*RandomTickMask),
};
/// Vanilla keeps a count of randomly ticking blocks and fluids per section,
/// updated by every `setBlockState`, and ticks the sections where it is above
/// zero. Here a section's answer is read from its blocks after any edit:
/// resident chunks and sections are immutable behind `Arc` and edited through
/// `Arc::make_mut`, so a weak reference tells an edited or replaced one from
/// the one read, without retaining block data or forcing a deep copy on the
/// next edit, and prevents address reuse. An unchanged chunk costs one
/// pointer comparison; a changed one, a comparison per section and a read of
/// the sections that changed. Clear this cache whenever the gameplay facts
/// change (including resource reload).
pub const RandomTickSections = struct {
    chunks: FxHashMap<(i32,
};
    // rust: impl RandomTickSections {
pub fn clear(self: *Self) void {
}
    // rust: self.chunks.clear();
}
pub fn remove(self: *Self, key: *(i32) void {
}
    // rust: self.chunks.remove(key);
}
    /// The sections of `chunk` holding a randomly ticking block or fluid.
pub fn get(self: *Self, key: (i32) void {
}
    // rust: self.get_with(key, chunk, |id| facts.get(BlockStateId(id)).random_ticks)
}
    // rust: fn get_with(
    // rust: &mut self,
    // rust: key: (i32, i32),
    // rust: chunk: &Arc<Chunk>,
    // rust: mut random: impl FnMut(u32) -> bool,
    // rust: ) -> Sections {
    // rust: Self::refresh(&mut self.chunks, key, chunk, &mut random).sections
}
    /// The lowest ticking section of `chunk` ([`Self::get`]) from block
    /// `from_y` up: its minimum Y and its mask of the blocks a random tick can
    /// do anything for (`candidate`: `Behaviours::random_tick_candidate`),
    /// built at the section's first tick and kept until it changes. Only the
    /// section asked for is built and shared.
    // rust: pub fn next_masked(
    // rust: &mut self,
    // rust: key: (i32, i32),
    // rust: chunk: &Arc<Chunk>,
    // rust: facts: &BlockFacts,
    // rust: mut candidate: impl FnMut(u32) -> bool,
    // rust: from_y: i32,
    // rust: ) -> Option<(i32, Rc<RandomTickMask>)> {
    // rust: let cached = Self::refresh(&mut self.chunks, key, chunk, &mut |id| {
    // rust: facts.get(BlockStateId(id)).random_ticks
    // rust: });
    // rust: let y = cached.sections.from(from_y)?;
    // rust: let index = ((y - cached.sections.base) >> 4) as usize;
    // rust: let mask = cached.masks[index].get_or_insert_with(|| {
    // rust: Rc::new(Self::candidate_mask(&chunk.sections[index], &mut candidate))
    // rust: });
    // rust: Some((y, mask.clone()))
}
pub fn candidate_mask(section: *Section, mut candidate: impl FnMut(u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let blocks = &section.blocks;
    // rust: let mut ids = [0u16; 4096];
    // rust: if let Some(palette) = blocks.unpack_ids(&mut ids) {
            // ServerLevel.tickChunk's per-state eligibility is constant
            // across a section: resolve it once per palette entry, not
            // once per block when an edited section rebuilds its mask.
    // rust: let mut candidates = [false; 256];
    // rust: for (i, &state) in palette.iter().enumerate() {
    // rust: candidates[i] = candidate(state);
}
    // rust: let mut bits = [0u64; 64];
    // rust: for (i, &id) in ids.iter().enumerate() {
    // rust: bits[i >> 6] |= u64::from(candidates[id as usize]) << (i & 63);
}
    // rust: RandomTickMask(bits)
    // rust: } else {
    // rust: let mut states = [0u32; 4096];
    // rust: blocks.unpack(&mut states);
    // rust: RandomTickMask::of(&states, candidate)
}
}
    // rust: fn refresh<'a>(
    // rust: chunks: &'a mut FxHashMap<(i32, i32), Cached>,
    // rust: key: (i32, i32),
    // rust: chunk: &Arc<Chunk>,
    // rust: random: &mut impl FnMut(u32) -> bool,
    // rust: ) -> &'a mut Cached {
    // rust: let cached = chunks.entry(key).or_insert_with(|| Cached {
    // rust: chunk: Weak::new(),
    // rust: read: Vec::new(),
    // rust: sections: Sections::default(),
    // rust: masks: Vec::new(),
    // rust: });
    // rust: if cached.chunk.as_ptr() != Arc::as_ptr(chunk) {
    // rust: if cached.read.len() != chunk.sections.len() || cached.sections.base != chunk.min_y() {
    // rust: cached.read = chunk.sections.iter().map(|_| Weak::new()).collect();
    // rust: cached.masks = vec![None; chunk.sections.len()];
    // rust: cached.sections = Sections {
    // rust: mask: SectionMask::EMPTY,
    // rust: base: chunk.min_y(),
}
}
    // rust: for (i, (section, read)) in chunk.sections.iter().zip(&mut cached.read).enumerate() {
    // rust: if read.as_ptr() == Arc::as_ptr(section) {
    // rust: continue;
}
                // `isRandomlyTicking`: the blocks themselves, not the palette,
                // which keeps the states no block uses any more.
    // rust: cached.masks[i] = None;
    // rust: if section.blocks.has(&mut *random) {
    // rust: cached.sections.mask.insert(i);
    // rust: } else {
    // rust: cached.sections.mask.remove(i);
}
    // rust: *read = Arc::downgrade(section);
}
    // rust: cached.chunk = Arc::downgrade(chunk);
}
    // rust: cached
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::chunk::SECTIONS;
//     use crate::chunk::Section;

pub fn palette_masks_preserve_positions_and_rng() void {
}
//         use horizon_core::position::BlockPos;
//         use horizon_world::level::Ticks;

        // Alternating states defeat the old mask builder's consecutive-state
        // shortcut. Include single, local and global palettes and unused IDs.
    // rust: for distinct in [1, 2, 256, 300] {
    // rust: let states = std::array::from_fn::<_, 4096, _>(|i| (i % distinct) as u32);
    // rust: let mut section = Section {
    // rust: blocks: Section::from_blocks(&states),
    // rust: ..Default::default()
}
    // rust: if distinct == 2 {
    // rust: section.set(0, 999);
    // rust: section.set(0, states[0]);
}
    // rust: let candidate = |id| id % 3 == 0;
    // rust: let reference = RandomTickMask::of(&states, candidate);
    // rust: let mut calls = 0;
    // rust: let optimized = RandomTickSections::candidate_mask(&section, |id| {
    // rust: calls += 1;
    // rust: candidate(id)
    // rust: });
    // rust: assert_eq!(reference, optimized);
    // rust: if distinct == 2 {
    // rust: assert_eq!(calls, 3); // two live states and one stale palette entry
}
    // rust: let (mut before, mut after) = (Ticks::new(12345), Ticks::new(12345));
    // rust: let mut expected = Vec::new();
    // rust: let mut actual = Vec::new();
            // Non-ticking sections consume no draws; each ticking section
            // gets three, even if none hits a candidate.
    // rust: for (y, ticking) in [(-64, false), (-48, true), (-32, false), (16, true)] {
    // rust: if !ticking {
    // rust: continue;
}
    // rust: for _ in 0..3 {
    // rust: let p = before.block_random_pos(-32, y, 48, 15);
    // rust: if reference.may_tick(p) {
    // rust: expected.push(p);
}
    // rust: let p = after.block_random_pos(-32, y, 48, 15);
    // rust: if optimized.may_tick(p) {
    // rust: actual.push(p);
}
}
}
    // rust: assert_eq!(expected, actual);
    // rust: assert_eq!(before.random_tick_value, after.random_tick_value);
            // Independent wrapping i32 LCG oracle, including coordinate bits.
    // rust: let mut value = 12345u32;
    // rust: let mut oracle = Vec::new();
    // rust: for y in [-48, 16] {
    // rust: for _ in 0..3 {
    // rust: value = value.wrapping_mul(3).wrapping_add(1_013_904_223);
    // rust: let p = BlockPos::new(
    // rust: -32 + ((value >> 2) & 15) as i32,
    // rust: y + ((value >> 18) & 15) as i32,
    // rust: 48 + ((value >> 10) & 15) as i32,
    // rust: );
    // rust: let i = ((p.y & 15) << 8 | (p.z & 15) << 4 | (p.x & 15)) as usize;
    // rust: if candidate(states[i]) {
    // rust: oracle.push(p);
}
}
}
    // rust: assert_eq!(actual, oracle);
    // rust: assert_eq!(after.random_tick_value as u32, value);
}
}

pub fn a_tall_chunk_ticks_its_sections_near_the_top() void {
}
    // rust: let layout = crate::chunk::ColumnLayout::new(-64, 2096).unwrap();
    // rust: let mut cache = RandomTickSections::default();
    // rust: let mut chunk = Arc::new(Chunk::with_layout(0, 0, layout));
    // rust: Arc::make_mut(&mut chunk).set(0, 2020, 0, 1);
    // rust: Arc::make_mut(&mut chunk).set(0, 100, 0, 1);
    // rust: let sections = cache.get_with((0, 0), &chunk, |id| id == 1);
    // rust: assert_eq!(sections.collect::<Vec<_>>(), [96, 2016]);
    // rust: assert_eq!(sections.from(200), Some(2016));
        // A vanilla chunk at the same key is read again.
    // rust: let short = Arc::new(Chunk::empty(0, 0));
    // rust: assert_eq!(cache.get_with((0, 0), &short, |id| id == 1).len(), 0);
}
pub fn edits_replacements_compaction_and_reload() void {
}
    // rust: let mut cache = RandomTickSections::default();
    // rust: let mut chunk = Arc::new(Chunk::empty(0, 0));
    // rust: assert_eq!(cache.get_with((0, 0), &chunk, |id| id == 1).len(), 0);
    // rust: cache.get_with((0, 0), &chunk, |_| panic!("unchanged chunk rescanned"));
    // rust: let worker = chunk.clone();
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y, 0, 1);
    // rust: assert_eq!(
    // rust: cache
    // rust: .get_with((0, 0), &chunk, |id| id == 1)
    // rust: .collect::<Vec<_>>(),
    // rust: [MIN_Y]
    // rust: );
    // rust: assert_eq!(worker.get(0, MIN_Y, 0), 0);
        // Once the last ticking block is gone the section stops ticking, as
        // vanilla's count drops to zero, though its palette still lists it.
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y, 0, 0);
    // rust: assert!(chunk.sections[0].blocks.maybe_has(|id| id == 1));
    // rust: assert_eq!(cache.get_with((0, 0), &chunk, |id| id == 1).len(), 0);
        // Only the edited section is read again (its palette: air, then 1).
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y + 16, 0, 1);
    // rust: let mut asked = Vec::new();
    // rust: let sections = cache.get_with((0, 0), &chunk, |id| {
    // rust: asked.push(id);
    // rust: id == 1
    // rust: });
    // rust: assert_eq!(
    // rust: (sections.collect::<Vec<_>>(), asked),
    // rust: (vec![MIN_Y + 16], vec![0, 1])
    // rust: );
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y + 16, 0, 0);
    // rust: Arc::make_mut(&mut Arc::make_mut(&mut chunk).sections[1]).compact();
    // rust: assert_eq!(cache.get_with((0, 0), &chunk, |id| id == 1).len(), 0);
    // rust: Arc::make_mut(&mut chunk).sections[SECTIONS - 1] = Arc::new(Section::default());
    // rust: cache.clear(); // resource reload, with changed facts for the same state IDs
    // rust: assert_eq!(cache.get_with((0, 0), &chunk, |id| id == 0).len(), SECTIONS);
    // rust: cache.remove(&(0, 0));
    // rust: assert!(cache.chunks.is_empty());
}

pub fn replacement_at_same_coordinates_and_early_snapshot() void {
}
    // rust: let mut cache = RandomTickSections::default();
    // rust: let mut chunk = Arc::new(Chunk::empty(-2, 3));
    // rust: let before_scheduled = cache.get_with((-2, 3), &chunk, |id| id == 1);
    // rust: Arc::make_mut(&mut chunk).set(0, MIN_Y + 16, 0, 1);
    // rust: assert_eq!(before_scheduled.len(), 0);
    // rust: assert_eq!(
    // rust: cache
    // rust: .get_with((-2, 3), &chunk, |id| id == 1)
    // rust: .collect::<Vec<_>>(),
    // rust: [MIN_Y + 16]
    // rust: );
    // rust: let weak = Arc::downgrade(&chunk);
    // rust: drop(chunk);
    // rust: assert!(weak.upgrade().is_none()); // cache does not retain unloaded block data
    // rust: let replacement = Arc::new(Chunk::empty(-2, 3));
    // rust: assert_eq!(cache.get_with((-2, 3), &replacement, |id| id == 1).len(), 0);
}

pub fn global_palette_and_ascending_order() void {
}
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for i in [0, 9, SECTIONS - 1] {
    // rust: Arc::make_mut(&mut chunk.sections[i]).blocks =
    // rust: Section::from_blocks(&std::array::from_fn(|j| (j % 300) as u32));
}
    // rust: let chunk = Arc::new(chunk);
    // rust: let mut cache = RandomTickSections::default();
        // Global palettes: the states the blocks hold, not the whole ID range.
    // rust: assert_eq!(cache.get_with((0, 0), &chunk, |id| id == 40000).len(), 0);
    // rust: cache.clear();
    // rust: assert_eq!(
    // rust: cache
    // rust: .get_with((0, 0), &chunk, |id| id == 299)
    // rust: .collect::<Vec<_>>(),
    // rust: [MIN_Y, MIN_Y + 9 * 16, MIN_Y + (SECTIONS as i32 - 1) * 16]
    // rust: );
    // rust: let sections = cache.get_with((0, 0), &chunk, |id| id == 299);
    // rust: let top = MIN_Y + (SECTIONS as i32 - 1) * 16;
    // rust: let from = |y| sections.from(y);
    // rust: assert_eq!(
    // rust: [
    // rust: from(MIN_Y - 16),
    // rust: from(MIN_Y),
    // rust: from(MIN_Y + 16),
    // rust: from(MIN_Y + 9 * 16)
    // rust: ],
    // rust: [
    // rust: Some(MIN_Y),
    // rust: Some(MIN_Y),
    // rust: Some(MIN_Y + 9 * 16),
    // rust: Some(MIN_Y + 9 * 16)
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: [from(top), from(top + 16), from(top + 1000)],
    // rust: [Some(top), None, None]
    // rust: );
}
}

    // rust: mod tick_parity {
//     use super::*;
//     use crate::chunk::SECTIONS;
//     use horizon_core::{
    // rust: position::{BlockPos, ChunkPos},
    // rust: random::{LegacyRandom, RandomSource},
}
//     use horizon_world::level::{LevelAccess, LevelEvent, Ticks, data};
//     use std::{cell::RefCell, path::PathBuf};

pub const Level = struct {
    chunks: FxHashMap<(i32,
    random: LegacyRandom,
    reads: RefCell<std.ArrayList(BlockPos)>,
    events: std.ArrayList(LevelEvent),
    time: i64,
    speed: i32,
};
    // rust: impl LevelAccess for Level {
pub fn block_state(self: *Self, pos: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reads.borrow_mut().push(pos);
    // rust: self.chunks
    // rust: .get(&(pos.x >> 4, pos.z >> 4))
    // rust: .map_or(BlockStateId(0), |c| c.block(pos.x, pos.y, pos.z))
}
pub fn set_raw(self: *Self, pos: BlockPos, state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chunk = self.chunks.get_mut(&(pos.x >> 4, pos.z >> 4))?;
    // rust: Some(BlockStateId(
    // rust: Arc::make_mut(chunk).set(pos.x, pos.y, pos.z, state.0),
    // rust: ))
}
pub fn is_loaded(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks.contains_key(&(pos.x >> 4, pos.z >> 4))
}
pub fn random(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.random
}
pub fn game_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.time
}
pub fn game_rules(self: *Self) h {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_world::level::GameRules {
    // rust: random_tick_speed: self.speed,
    // rust: ..Default::default()
}
}
pub fn emit(self: *Self, event: LevelEvent) void {
}
    // rust: self.events.push(event);
}
}

pub fn actual_random_ticks_match_a_block_scan() void {
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    // rust: let local = manifest
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if local.join("gameplay-facts.json").exists() {
    // rust: local
    // rust: } else {
                    // The branch worktree lives below the main checkout.
    // rust: manifest
    // rust: .join("../../../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
}
    // rust: });
    // rust: if !root.join("gameplay-facts.json").exists() {
    // rust: eprintln!(
    // rust: "skipping resource-backed random-tick parity: {}",
    // rust: root.display()
    // rust: );
    // rust: return;
}
    // rust: let registry = data::load_registry(&root).unwrap();
    // rust: let (mut facts, behaviours) = BlockFacts::load_pair(&root, &registry).unwrap();
    // rust: let grass = registry.default_state("minecraft:grass_block").unwrap();
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: let chunk = |x| {
    // rust: let mut c = Chunk::empty(x, 0);
    // rust: c.lit = true;
            // Every sampled block can run real behaviour and change to dirt.
    // rust: for i in [4, 7] {
    // rust: Arc::make_mut(&mut c.sections[i]).blocks =
    // rust: crate::chunk::Section::from_blocks(&[grass.0; 4096]);
}
    // rust: Arc::new(c)
}
    // rust: let mut original = Level {
    // rust: chunks: [
    // rust: ((-1, 0), chunk(-1)),
    // rust: ((0, 0), chunk(0)),
    // rust: ((1, 0), Arc::new(Chunk::empty(1, 0))),
    // rust: ]
    // rust: .into_iter()
    // rust: .collect(),
    // rust: random: LegacyRandom::new(42),
    // rust: reads: RefCell::default(),
    // rust: events: Vec::new(),
    // rust: time: 0,
    // rust: speed: 3,
}
    // rust: Arc::make_mut(original.chunks.get_mut(&(1, 0)).unwrap()).lit = true; // precipitation-only chunk
    // rust: let mut cached = original.clone();
        // The masked path reads only the drawn blocks that can tick.
    // rust: let mut masked = original.clone();
    // rust: let mut cache = RandomTickSections::default();
    // rust: let mut mask_cache = RandomTickSections::default();
    // rust: let (mut a, mut b, mut c) = (Ticks::new(12345), Ticks::new(12345), Ticks::new(12345));
    // rust: for x in -1..=1 {
    // rust: a.add_empty_chunk(ChunkPos::new(x, 0)).unwrap();
    // rust: b.add_empty_chunk(ChunkPos::new(x, 0)).unwrap();
    // rust: c.add_empty_chunk(ChunkPos::new(x, 0)).unwrap();
}
    // rust: for step in 0..128 {
    // rust: for level in [&mut original, &mut cached, &mut masked] {
    // rust: level.time = step;
    // rust: level.speed = [0, 1, 3, 9][step as usize % 4];
    // rust: level.reads.borrow_mut().clear();
    // rust: level.events.clear();
    // rust: match step {
    // rust: 12 => {
    // rust: level.chunks.remove(&(-1, 0));
}
    // rust: 13 => {
    // rust: level.chunks.insert((-1, 0), chunk(-1));
}
    // rust: 30 => {
    // rust: Arc::make_mut(level.chunks.get_mut(&(0, 0)).unwrap()).sections[7] =
    // rust: Arc::new(crate::chunk::Section::default());
}
    // rust: 40 | 41 => {
    // rust: Arc::make_mut(level.chunks.get_mut(&(0, 0)).unwrap()).lit = step == 41;
}
    // rust: 70 => {
                        // Every block of a ticking section replaced: its
                        // palette still lists grass, but nothing ticks there.
    // rust: let c = Arc::make_mut(level.chunks.get_mut(&(-1, 0)).unwrap());
    // rust: for i in 0..4096 {
    // rust: c.set(i & 15, MIN_Y + 4 * 16 + (i >> 8), i >> 4 & 15, stone.0);
}
    // rust: assert!(c.sections[4].blocks.maybe_has(|id| id == grass.0));
}
    // rust: _ => {}
}
}
    // rust: if step == 12 {
    // rust: cache.remove(&(-1, 0));
    // rust: mask_cache.remove(&(-1, 0));
}
    // rust: if step == 50 || step == 60 {
    // rust: facts.states[grass.0 as usize].random_ticks = step == 60;
    // rust: cache.clear();
    // rust: mask_cache.clear();
}
            // A write between ticks.
    // rust: if step == 20 {
    // rust: for level in [&mut original, &mut cached, &mut masked] {
    // rust: level.set_raw(BlockPos::new(0, MIN_Y + 16, 0), grass);
}
}
    // rust: let lit = |level: &Level| {
    // rust: let mut keys: Vec<_> = level
    // rust: .chunks
    // rust: .iter()
    // rust: .filter(|(_, c)| c.lit)
    // rust: .map(|(&key, _)| key)
    // rust: .collect();
    // rust: keys.sort();
    // rust: keys
}
    // rust: let random = |id| facts.get(BlockStateId(id)).random_ticks;
    // rust: for (x, z) in lit(&original) {
                // Vanilla's rule, asked as each section is reached: any of its
                // 4,096 blocks ticks randomly.
    // rust: let reference = |level: &mut Level, from: i32| {
    // rust: let chunk = &level.chunks[&(x, z)];
    // rust: (from..MIN_Y + SECTIONS as i32 * 16)
    // rust: .step_by(16)
    // rust: .find(|&min_y| {
    // rust: (0..16).any(|y| {
    // rust: (0..16).any(|z| (0..16).any(|x| random(chunk.get(x, min_y + y, z))))
    // rust: })
    // rust: })
}
    // rust: behaviours.tick_chunk_random(&mut original, &mut a, ChunkPos::new(x, z), reference);
}
    // rust: for (x, z) in lit(&cached) {
    // rust: let memoized = |level: &mut Level, from| {
    // rust: cache.get((x, z), &level.chunks[&(x, z)], &facts).from(from)
}
    // rust: behaviours.tick_chunk_random(&mut cached, &mut b, ChunkPos::new(x, z), memoized);
}
    // rust: for (x, z) in lit(&masked) {
    // rust: let next = |level: &mut Level, from| {
                    // Read at every ask, so an edit of the chunk reads its
                    // section again.
    // rust: let now = level.chunks[&(x, z)].clone();
    // rust: mask_cache
    // rust: .next_masked(
    // rust: (x, z),
    // rust: &now,
    // rust: &facts,
    // rust: |id| behaviours.random_tick_candidate(BlockStateId(id)),
    // rust: from,
    // rust: )
    // rust: .map(|(y, mask)| (y, Some(mask)))
}
    // rust: behaviours.tick_chunk_random_masked(&mut masked, &mut c, ChunkPos::new(x, z), next);
}
    // rust: assert_eq!(original.reads, cached.reads, "ordered reads at tick {step}");
    // rust: assert_eq!(
    // rust: original.events, masked.events,
    // rust: "masked events at tick {step}"
    // rust: );
    // rust: assert!(masked.reads.borrow().len() <= original.reads.borrow().len());
    // rust: assert_eq!(
    // rust: a.random_tick_value, c.random_tick_value,
    // rust: "masked position RNG at tick {step}"
    // rust: );
    // rust: assert_eq!(
    // rust: original.random.clone().next_long(),
    // rust: masked.random.next_long(),
    // rust: "masked level RNG at tick {step}"
    // rust: );
    // rust: assert_eq!(original.events, cached.events, "events at tick {step}");
    // rust: assert_eq!(
    // rust: a.random_tick_value, b.random_tick_value,
    // rust: "position RNG at tick {step}"
    // rust: );
    // rust: assert_eq!(
    // rust: original.random.next_long(),
    // rust: cached.random.next_long(),
    // rust: "level RNG at tick {step}"
    // rust: );
}
    // rust: let dirt = registry.default_state("minecraft:dirt").unwrap();
    // rust: assert!(
    // rust: original
    // rust: .chunks
    // rust: .values()
    // rust: .any(|c| c.sections[4].blocks.maybe_has(|id| id == dirt.0))
    // rust: );
    // rust: for (key, c) in &original.chunks {
    // rust: for (s, t) in c.sections.iter().zip(&cached.chunks[key].sections) {
    // rust: assert_eq!(s.blocks, t.blocks);
}
    // rust: for (s, t) in c.sections.iter().zip(&masked.chunks[key].sections) {
    // rust: assert_eq!(s.blocks, t.blocks);
}
}
}
}
