//! Transpiled from Horizon Rust crate
package horizon_client_render_world

import "core:fmt"
import "core:mem"
import "core:math"

// Resident client world: streamed chunk columns plus the bookkeeping the game
// loop needs to relight and remesh after edits.
// use crate::{
    // rust: chunk::{Chunk, ColumnLayout, LevelShape},
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: section_mask::SectionMask,
}
// use horizon_core::random::LegacyRandom;
// use horizon_world::registry::BlockStateId;
// use std::sync::Arc;

// Sections (x, section index, z) waiting to be remeshed, kept by column
// (a bit per section index), so the mesh scheduler looks at each column once
// rather than at every section of it.
DirtySections :: struct {
    columns: crate::fast_hash::FxHashMap<(i32,
}
    // rust: impl DirtySections {
insert :: proc(self: ^Self) {
}
    // rust: debug_assert!((0..SectionMask::CAPACITY as i32).contains(&sy));
    // rust: self.columns.entry((x, z)).or_default().insert(sy as usize);
}
contains :: proc(self: ^Self) {
}
    // rust: (0..SectionMask::CAPACITY as i32).contains(&sy)
    // rust: && self
    // rust: .columns
    // rust: .get(&(x, z))
    // rust: .is_some_and(|m| m.contains(sy as usize))
}
    // The dirty section indexes of column (x, z), removed.
take_column :: proc(self: ^Self, x: i32, z: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.remove(&(x, z)).unwrap_or_default()
}
    // Keep the columns `keep` accepts.
retain_columns :: proc(self: ^Self, mut keep: impl FnMut(i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.retain(|&(x, z), _| keep(x, z));
}
    // The columns holding dirty sections, with their section indexes.
columns :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.iter().map(|(&c, &m)| (c, m))
}
clear :: proc(self: ^Self) {
}
    // rust: self.columns.clear();
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.is_empty()
}
    // How many sections are dirty.
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.values().map(SectionMask::len).sum()
}
}
World :: struct {
    // Server-owned mod data attached to this dimension.
    attachments: horizon_world::attachments::Attachments,
    // The holders lent to mods since the last flush, whose synced changes
    // `flush_attachment_sync` sends.
    attachment_syncs: FxHashSet<horizon_world::attachments::Holder>,
    // The level's build range and skylight (its dimension type); its
    // chunks hold `shape.column()`.
    shape: LevelShape,
    fast_lava: bool,
    chunks: crate::chunk_map::ChunkMap,
    random: LegacyRandom,
    revision: u64,
    health_rules: HealthRules,
    air: BlockStateId,
    // Sections whose geometry changed and need remeshing.
    dirty_sections: DirtySections,
    // Chunks whose light must be recomputed.
    dirty_light: crate::fast_hash::FxHashSet<(i32,
    // Edits on lit chunks (position, old state, new state), relit
    // incrementally by streaming.
    light_edits: Vec<((i32,
    // Saved entities of chunks that just loaded, spawned by the game.
    loaded_entities: Vec<((i32,
    // Chunks that just came into this level from a worker, and whether each
    // was generated rather than read from the save: the game tells native mods.
    loaded_chunks: Vec<(i32,
    // Chunks changed since the last save.
    modified: FxHashSet<(i32,
    // Block entities, and the order they tick in.
    block_entities: crate::block_entities::BlockEntities,
    // Each chest's `ContainerOpenersCounter`: opener count and largest
    // interaction range.
    chest_openers: FxHashMap<(i32,
    // `BaseContainerBlockEntity.name`: custom names of container block entities.
    block_names: FxHashMap<(i32,
    // States (by id) whose writes are recorded in `watched_writes` (sculk
    // blocks, which need a block entity).
    watched: [dynamic]bool,
    // Writes of watched states: position, previous and new state.
    watched_writes: Vec<((i32,
    // `ChunkAccess.inhabitedTime` of resident chunks: ticks a player spent
    // within spawning range (local difficulty).
    inhabited: FxHashMap<(i32,
    game_time: i64,
    day_time: i64,
    weather: Weather,
    // Every block position written since the log was last drained, kept
    // only while the world is open to the network (see `lan`).
    block_log: Option<Vec<(i32,
    // Writes of this tick's block events and block entities, held out of
    // the log while it is sent: they go out with the next tick's.
    block_log_held: Vec<(i32,
    // Every write since the mobs last ticked (position, old and new state),
    // for `ServerLevel.sendBlockUpdated`'s path recomputing; kept only while
    // the mobs of this world tick (`game/creatures.rs`).
    path_writes: Option<Vec<((i32,
    // The chunks changed in bulk (`edit_runs`) since the log was last
    // drained, kept while `block_log` is: sent to the players whole.
    bulk_log: FxHashSet<(i32,
    // The sections whose light changed since the log was last drained, as
    // a bit per section of each column, kept while `block_log` is
    // (`ChunkHolder.sectionLightChanged`).
    light_log: Option<crate::fast_hash::FxHashMap<(i32,
    // The villager POIs of each section (`PoiManager`'s sections).
    pois: crate::poi_sections::PoiSections<crate::poi_sections::Poi>,
    // Moving-piston states removed during the last tick; retained until the
    // final block mesh is visible.
    moving_piston_fallback: Vec<([i32,
    // The moving-piston block entities of the level, by position, copied
    // from the block ticks after each tick: collision and rendering read them.
    moving_pistons: Vec<([i32,
    // The `ShulkerBoxBlockEntity` lid state of the level, by position, copied
    // from the block entities after each tick: the collision queries read it
    // (`ShulkerBoxBlockEntity.getBoundingBox`), as `moving_pistons` for pistons.
    shulkers: FxHashMap<[i32,
}
Weather :: struct {
    clear_time: i32,
    rain_time: i32,
    thunder_time: i32,
    raining: bool,
    thundering: bool,
    rain_level: (f32,
    thunder_level: (f32,
}
    // rust: impl Weather {
    // The timers of `advanceWeatherCycle`, which run only while
    // `advance_weather` is on.
tick_timers :: proc(self: ^Self, random: ^horizon_core::random::LegacyRandom) {
}
//         use horizon_core::random::RandomSource;
    // rust: let mut uniform =
    // rust: |min: i32, max: i32| min + random.next_int_bound(max - min + 1).unwrap_or(0);
    // rust: if self.clear_time > 0 {
    // rust: self.clear_time -= 1;
    // rust: self.thunder_time = if self.thundering { 0 } else { 1 };
    // rust: self.rain_time = if self.raining { 0 } else { 1 };
    // rust: self.thundering = false;
    // rust: self.raining = false;
    // rust: } else {
    // rust: if self.thunder_time > 0 {
    // rust: self.thunder_time -= 1;
    // rust: if self.thunder_time == 0 {
    // rust: self.thundering = !self.thundering;
}
    // rust: } else if self.thundering {
    // rust: self.thunder_time = uniform(3600, 15600);
    // rust: } else {
    // rust: self.thunder_time = uniform(12000, 180000);
}
    // rust: if self.rain_time > 0 {
    // rust: self.rain_time -= 1;
    // rust: if self.rain_time == 0 {
    // rust: self.raining = !self.raining;
}
    // rust: } else if self.raining {
    // rust: self.rain_time = uniform(12000, 24000);
    // rust: } else {
    // rust: self.rain_time = uniform(12000, 180000);
}
}
}
    // The rain and thunder level fade at the end of `advanceWeatherCycle`,
    // which runs whatever `advance_weather` says, so `/weather` still shows.
tick_levels :: proc(self: ^Self) {
}
    // rust: self.thunder_level.0 = self.thunder_level.1;
    // rust: self.thunder_level.1 =
    // rust: (self.thunder_level.1 + if self.thundering { 0.01 } else { -0.01 }).clamp(0.0, 1.0);
    // rust: self.rain_level.0 = self.rain_level.1;
    // rust: self.rain_level.1 =
    // rust: (self.rain_level.1 + if self.raining { 0.01 } else { -0.01 }).clamp(0.0, 1.0);
}
    // Level.getRainLevel / getThunderLevel (thunder scales with rain).
levels :: proc(self: ^Self, partial: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let rain = self.rain_level.0 + (self.rain_level.1 - self.rain_level.0) * partial;
    // rust: let thunder =
    // rust: self.thunder_level.0 + (self.thunder_level.1 - self.thunder_level.0) * partial;
    // rust: (rain, thunder * rain)
}
}
    // rust: impl World {
new :: proc(air: BlockStateId, seed: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: shape: LevelShape::OVERWORLD,
    // rust: chunks: Default::default(),
    // rust: random: LegacyRandom::new(seed),
    // rust: revision: 0,
    // rust: health_rules: HealthRules::default(),
    // rust: air,
    // rust: fast_lava: false,
    // rust: dirty_sections: Default::default(),
    // rust: dirty_light: Default::default(),
    // rust: light_edits: Vec::new(),
    // rust: loaded_entities: Vec::new(),
    // rust: loaded_chunks: Vec::new(),
    // rust: modified: FxHashSet::default(),
    // rust: attachments: Default::default(),
    // rust: attachment_syncs: FxHashSet::default(),
    // rust: block_entities: Default::default(),
    // rust: chest_openers: FxHashMap::default(),
    // rust: block_names: FxHashMap::default(),
    // rust: watched: Vec::new(),
    // rust: watched_writes: Vec::new(),
    // rust: inhabited: FxHashMap::default(),
    // rust: game_time: 0,
    // rust: day_time: 1000,
    // rust: weather: Weather::default(),
    // rust: block_log: None,
    // rust: block_log_held: Vec::new(),
    // rust: path_writes: None,
    // rust: bulk_log: Default::default(),
    // rust: light_log: None,
    // rust: moving_piston_fallback: Vec::new(),
    // rust: moving_pistons: Vec::new(),
    // rust: shulkers: FxHashMap::default(),
    // rust: pois: Default::default(),
}
}
    // A controlled blockstate scene for the native scene probes: material
    // layers, a stepped pyramid and the model gallery. Not generated terrain.
    // rust: pub fn test_scene(
    // rust: assets: &crate::assets::Assets,
    // rust: render: &crate::assets::RenderAssets,
    // rust: radius: i32,
    // rust: ) -> crate::Result<Self> {
    // rust: let air = assets
    // rust: .registry
    // rust: .default_state("minecraft:air")
    // rust: .ok_or("missing air state")?;
    // rust: let mut world = Self::new(air, 0);
    // rust: for cz in -radius..=radius {
    // rust: for cx in -radius..=radius {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(Chunk::empty(cx, cz)));
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: for y in 0..4 {
    // rust: let layer = match y {
    // rust: 0 => 0,
    // rust: 1 | 2 => 1,
    // rust: _ if (cx + cz) & 1 == 0 => 2,
    // rust: _ => 3,
}
    // rust: world.set(
    // rust: cx * 16 + x,
    // rust: y,
    // rust: cz * 16 + z,
    // rust: assets.material_states[layer],
    // rust: )?;
}
}
}
}
}
    // rust: for y in 4..11 {
    // rust: for z in -10_i32..=10 {
    // rust: for x in -10_i32..=10 {
    // rust: if x.abs().max(z.abs()) <= 10 - (y - 4) {
    // rust: world.set(
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: assets.material_states[if y & 1 == 0 { 4 } else { 5 }],
    // rust: )?;
}
}
}
}
    // rust: for (position, state) in &render.model_placements {
    // rust: world.set(position.x, position.y, position.z, *state)?;
}
    // rust: world.revision = 0;
    // rust: Ok(world)
}
    // The column the level's chunks hold.
layout :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.shape.column()
}
    // The lowest block Y the level's chunks hold.
bottom_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.layout().min_y()
}
    // One above the highest block Y the level's chunks hold.
top_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.layout().max_y()
}
    // Resident storage write; marks the touched sections (and neighbours on
    // section borders) for remeshing and the surrounding chunks for relighting.
    // Neighbour updates, drops and block entities belong to the gameplay layer.
set :: proc(self: ^Self, x: i32, y: i32, z: i32, state: BlockStateId) -> c {
    // Ported from Horizon
    return {}
}
    // rust: let Some(chunk) = self.chunks.get_mut(&(x >> 4, z >> 4)) else {
    // rust: return Err("write outside resident chunks".into());
}
    // rust: let (min_y, sections) = (chunk.min_y(), chunk.sections.len() as i32);
    // rust: if chunk.section_index(y).is_none() {
    // rust: return Err("write outside world height".into());
}
    // rust: let previous = Arc::make_mut(chunk).set(x & 15, y, z & 15, state.0);
    // rust: if previous != state.0 {
    // rust: self.block_entities
    // rust: .state_changed((x, y, z), previous, state.0);
    // rust: let watches = |id: u32| self.watched.get(id as usize).copied().unwrap_or(false);
    // rust: if watches(previous) || watches(state.0) {
    // rust: self.watched_writes.push(((x, y, z), previous, state.0));
}
    // rust: self.revision = self.revision.wrapping_add(1);
    // rust: if let Some(log) = &mut self.block_log {
    // rust: log.push((x, y, z));
}
    // rust: if let Some(writes) = &mut self.path_writes {
    // rust: writes.push(((x, y, z), previous, state.0));
}
    // rust: self.modified.insert((x >> 4, z >> 4));
            // The mesher reads a 3x3x3 neighbourhood for AO, so a write marks
            // the sections it can reach: this section, the one above/below
            // only on a section face, and a neighbour column only on a chunk
            // border (the diagonal only where both borders meet).
    // rust: let sy = (y - min_y) >> 4;
    // rust: let local_y = y & 15;
    // rust: let mark = |dirty: &mut DirtySections, bx: i32, bz: i32| {
    // rust: dirty.insert((bx >> 4, sy, bz >> 4));
    // rust: if local_y == 0 && sy > 0 {
    // rust: dirty.insert((bx >> 4, sy - 1, bz >> 4));
}
    // rust: if local_y == 15 && sy + 1 < sections {
    // rust: dirty.insert((bx >> 4, sy + 1, bz >> 4));
}
}
    // rust: let (bx, bz) = (x & 15, z & 15);
    // rust: mark(&mut self.dirty_sections, x, z);
    // rust: if bx == 0 {
    // rust: mark(&mut self.dirty_sections, x - 1, z);
    // rust: } else if bx == 15 {
    // rust: mark(&mut self.dirty_sections, x + 1, z);
}
    // rust: if bz == 0 {
    // rust: mark(&mut self.dirty_sections, x, z - 1);
    // rust: } else if bz == 15 {
    // rust: mark(&mut self.dirty_sections, x, z + 1);
}
    // rust: if (bx == 0 || bx == 15) && (bz == 0 || bz == 15) {
    // rust: mark(
    // rust: &mut self.dirty_sections,
    // rust: if bx == 0 { x - 1 } else { x + 1 },
    // rust: if bz == 0 { z - 1 } else { z + 1 },
    // rust: );
}
    // rust: if self.chunks.get(&(x >> 4, z >> 4)).is_some_and(|c| c.lit) {
    // rust: self.light_edits.push(((x, y, z), previous, state.0));
    // rust: } else {
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: self.dirty_light.insert(((x >> 4) + dx, (z >> 4) + dz));
}
}
}
}
    // rust: Ok(())
}
    // `getHeight(Heightmap.Types.WORLD_SURFACE, x, z)`: one above the highest
    // block that isn't `air`, or the column's minimum Y (also where the chunk
    // isn't loaded).
world_surface :: proc(self: ^Self, x: i32, z: i32, air: impl Fn(BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bottom = self.layout().min_y();
    // rust: self.chunks.get(&(x >> 4, z >> 4)).map_or(bottom, |chunk| {
    // rust: chunk.world_surface(x, z, |v| air(BlockStateId(v)))
    // rust: })
}
    // `getHeight(Heightmap.Types.MOTION_BLOCKING, x, z)`: one above the
    // highest block where `blocks` (motion blocking or holding a fluid),
    // or the column's minimum Y (also where the chunk isn't loaded).
motion_blocking :: proc(self: ^Self, x: i32, z: i32, blocks: impl Fn(BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bottom = self.layout().min_y();
    // rust: self.chunks.get(&(x >> 4, z >> 4)).map_or(bottom, |chunk| {
    // rust: chunk.motion_blocking(x & 15, z & 15, |v| blocks(BlockStateId(v)))
    // rust: })
}
block :: proc(self: ^Self, x: i32, y: i32, z: i32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map_or(self.air, |chunk| chunk.block(x & 15, y, z & 15))
}
    // Whether a block of the box `lo..=hi` may match, from the palettes of
    // the sections it reaches (a palette of the whole registry may hold
    // anything): `false` means [`Self::block`] matches in none of its cells,
    // so a scan over them can stop before reading one.
    // rust: pub fn may_hold(
    // rust: &self,
    // rust: lo: [i32; 3],
    // rust: hi: [i32; 3],
    // rust: mut matches: impl FnMut(BlockStateId) -> bool,
    // rust: ) -> bool {
    // rust: let layout = self.layout();
    // rust: let (bottom, top) = (layout.min_y(), layout.max_y() - 1);
        // Heights outside the sections read as state 0.
    // rust: if (lo[1] < bottom || hi[1] > top) && matches(BlockStateId(0)) {
    // rust: return true;
}
    // rust: let sections = (lo[1].max(bottom) - bottom) >> 4..=(hi[1].min(top) - bottom) >> 4;
    // rust: for cx in lo[0] >> 4..=hi[0] >> 4 {
    // rust: for cz in lo[2] >> 4..=hi[2] >> 4 {
    // rust: let Some(chunk) = self.chunks.get(&(cx, cz)) else {
    // rust: if matches(self.air) {
    // rust: return true;
}
    // rust: continue;
}
    // rust: for s in sections.clone() {
    // rust: let blocks = &chunk.sections[s as usize].blocks;
    // rust: if blocks.is_global() || blocks.maybe_has(|v| matches(BlockStateId(v))) {
    // rust: return true;
}
}
}
}
    // rust: false
}
    // The block entities to tick this tick, in order (`BlockEntities::tickers`).
    // rust: pub fn block_entity_tickers(
    // rust: &mut self,
    // rust: ) -> std::sync::Arc<Vec<(crate::block_entities::Pos, u32)>> {
    // rust: let (chunks, air) = (&self.chunks, self.air);
    // rust: self.block_entities.tickers(|(x, y, z)| {
    // rust: chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map_or(air, |chunk| chunk.block(x & 15, y, z & 15))
    // rust: .0
    // rust: })
}
light :: proc(self: ^Self, x: i32, y: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map_or(0xF0, |chunk| chunk.light(x & 15, y, z & 15))
}
is_air :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state == self.air
}
loaded :: proc(self: ^Self, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.chunks.contains_key(&(x >> 4, z >> 4))
}
    // `LockCode`: the `lock` a container block entity refuses to open
    // without, as the tag it was loaded or set with carries it (Horizon's
    // model holds no field for it).
block_lock :: proc(self: ^Self, key: (i32) {
}
    // rust: self.chunks
    // rust: .get(&(key.0 >> 4, key.2 >> 4))?
    // rust: .saved
    // rust: .as_ref()?
    // rust: .block_entity_sources
    // rust: .iter()
    // rust: .find(|(p, _)| *p == key)?
    // rust: .1
    // rust: .get("lock")
}
    // `LockCode.addToTag` for a tag a command gives a container (`setblock`,
    // `data merge`): the tag it was set with keeps the lock, so `data get`
    // shows it, a player's open checks it and the save writes it.
set_block_lock :: proc(self: ^Self, key: (i32) {
}
//         use horizon_world::nbt::Tag;
    // rust: let lock = tag.get("lock").and_then(|lock| match lock {
    // rust: Tag::Compound(_) => Some(lock.clone()),
    // rust: _ => None,
    // rust: });
    // rust: self.with_chunk_extras(key, |extras| {
    // rust: let at = extras
    // rust: .block_entity_sources
    // rust: .iter()
    // rust: .position(|(p, _)| *p == key);
    // rust: match at {
    // rust: Some(i) => {
    // rust: if let Tag::Compound(source) = &mut extras.block_entity_sources[i].1 {
    // rust: match lock {
    // rust: Some(lock) => {
    // rust: source.insert("lock".into(), lock);
}
    // rust: None => {
    // rust: source.remove(&"lock".into());
}
}
}
}
                // A container set at runtime has no source yet: the tag the
                // command gave is the one it was set with, `id` and position
                // included (the save checks the id before merging).
    // rust: None if lock.is_some() => extras.block_entity_sources.push((key, tag.clone())),
    // rust: None => {}
}
    // rust: });
}
    // `LevelChunk.removeBlockEntity`: the tag a block entity was loaded or set
    // with goes with it, so a container placed there later starts unlocked.
forget_block_entity_source :: proc(self: ^Self, key: (i32) {
}
    // rust: self.with_chunk_extras(key, |extras| {
    // rust: extras.block_entity_sources.retain(|(p, _)| *p != key);
    // rust: });
}
    // Run `f` on the keep-as-loaded data of the chunk holding `key`, put back
    // for the next save (`block_entity_sources` is where Horizon restores the
    // block entity fields its model does not hold).
    // rust: fn with_chunk_extras(
    // rust: &mut self,
    // rust: key: (i32, i32, i32),
    // rust: f: impl FnOnce(&mut crate::chunk::ChunkExtras),
    // rust: ) {
    // rust: let chunk_key = (key.0 >> 4, key.2 >> 4);
    // rust: let Some(chunk) = self.chunks.get_mut(&chunk_key) else {
    // rust: return;
}
    // rust: let chunk = Arc::make_mut(chunk);
    // rust: let mut extras = chunk
    // rust: .saved
    // rust: .take()
    // rust: .map(Arc::unwrap_or_clone)
    // rust: .unwrap_or_default();
    // rust: f(&mut extras);
    // rust: chunk.saved = Some(Arc::new(extras));
    // rust: self.modified.insert(chunk_key);
}
}

// The game rules and difficulty a player's health reads (`Player.isInvulnerableTo`,
// natural regeneration), kept with the world they belong to.
HealthRules :: struct {
    difficulty: horizon_world::food::Difficulty,
    natural_regeneration: bool,
    // The `drowning_damage`, `fall_damage`, `fire_damage` and
    // `freeze_damage` rules `Player.isInvulnerableTo` reads.
    drowning_damage: bool,
    fall_damage: bool,
    fire_damage: bool,
    freeze_damage: bool,
}
    // rust: impl Default for HealthRules {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: difficulty: horizon_world::food::Difficulty::Normal,
    // rust: natural_regeneration: true,
    // rust: drowning_damage: true,
    // rust: fall_damage: true,
    // rust: fire_damage: true,
    // rust: freeze_damage: true,
}
}
}

    // rust: mod tests {
//     use super::{DirtySections, World};
//     use crate::chunk::{Chunk, MIN_Y, SECTIONS};
//     use horizon_world::registry::BlockStateId;
//     use std::sync::Arc;

    // Every block write marks the same section set the 27-cell loop did, but
    // only the distinct keys: one in the interior, a neighbour section on a
    // section face, a neighbour column on a chunk border and the diagonal at
    // a corner (eight keys at a corner on a section face).
writes_mark_exactly_the_reachable_sections :: proc() {
}
    // rust: let mut world = World::new(BlockStateId(0), 0);
    // rust: world.chunks.insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: for (x, y, z) in [
    // rust: (3, 70, 3),
    // rust: (0, 70, 3),
    // rust: (15, 70, 3),
    // rust: (3, 70, 0),
    // rust: (0, 70, 0),
    // rust: (15, 70, 15),
    // rust: (0, MIN_Y, 0),
    // rust: (0, 80, 0),
    // rust: (15, MIN_Y + SECTIONS as i32 * 16 - 1, 15),
    // rust: ] {
    // rust: world.dirty_sections.clear();
    // rust: world.set(x, y, z, BlockStateId(1)).unwrap();
    // rust: let mut expected = DirtySections::default();
    // rust: for dz in -1..=1 {
    // rust: for dy in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: let (bx, by, bz) = (x + dx, y + dy, z + dz);
    // rust: let s = (by - MIN_Y) >> 4;
    // rust: if (0..SECTIONS as i32).contains(&s) {
    // rust: expected.insert((bx >> 4, s, bz >> 4));
}
}
}
}
    // rust: let mut got: Vec<_> = world.dirty_sections.columns().collect();
    // rust: let mut want: Vec<_> = expected.columns().collect();
    // rust: got.sort_unstable_by_key(|&(column, _)| column);
    // rust: want.sort_unstable_by_key(|&(column, _)| column);
    // rust: assert_eq!(got, want, "write at {x} {y} {z}");
    // rust: if (x & 15, z & 15) == (3, 3) {
    // rust: assert_eq!(world.dirty_sections.len(), 1);
}
    // rust: if (x & 15, z & 15, y & 15) == (0, 0, 0) && y > MIN_Y {
                // Four columns, each with the section below and this one.
    // rust: assert_eq!(world.dirty_sections.len(), 8);
}
}
}

    // A box misses a state only where no section it reaches lists it, and
    // unloaded columns or heights past the world count as their air.
may_hold_reads_the_palettes_of_the_reached_sections :: proc() {
}
    // rust: let mut world = World::new(BlockStateId(0), 0);
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: chunk.set(3, 70, 3, 9);
    // rust: world.chunks.insert((0, 0), Arc::new(chunk));
    // rust: let nine = |s: BlockStateId| s.0 == 9;
        // The section of y 64..80 holds 9, the one below does not.
    // rust: assert!(world.may_hold([0, 64, 0], [1, 65, 1], nine));
    // rust: assert!(world.may_hold([10, 79, 10], [12, 80, 12], nine));
    // rust: assert!(!world.may_hold([0, 50, 0], [15, 63, 15], nine));
        // A box over the unloaded column next door sees only air.
    // rust: assert!(!world.may_hold([16, 70, 0], [17, 71, 1], nine));
    // rust: assert!(world.may_hold([16, 70, 0], [17, 71, 1], |s| s.0 == 0));
        // Past the top, and the palette of air below it.
    // rust: assert!(!world.may_hold([0, 400, 0], [0, 401, 0], nine));
    // rust: assert!(world.may_hold([0, 400, 0], [0, 401, 0], |s| s.0 == 0));
}
}
