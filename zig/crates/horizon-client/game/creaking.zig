//! Transpiled from Horizon Rust crate
//! Module: horizon-client_creaking
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The creaking heart block entity in the game: `mobs::creaking_heart`
//! ticks each heart (spawning, letting go of and bleeding for its creaking)
//! and this applies what it reports to the world, the mobs and the speakers.
// use super::{Game, creatures::seen};
// use horizon_client::{
    // rust: Result,
    // rust: chunk_map::{ChunkMap, ChunkMembershipDelta},
    // rust: containers::{BlockEntity, CreakingHeart},
    // rust: mobs::{
    // rust: Mob, MobType,
    // rust: creaking_heart::{self, HeartEvent, HeartHost},
    // rust: },
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::registry::BlockStateId;
// use std::{collections::HashMap, sync::Arc};

    // rust: type Pos = (i32, i32, i32);

/// Comparator input of a heart (`getAnalogOutputSignal`).
    // rust: pub(super) fn heart_signal(world: &horizon_client::world::World, pos: BlockPos) -> Option<i32> {
    // rust: match world.block_entities.get(&(pos.x, pos.y, pos.z))? {
    // rust: BlockEntity::CreakingHeart(h) => Some(h.output_signal),
    // rust: _ => None,
}
}

/// The game's mobs as a heart sees them, taken out of the game for the tick.
pub const Host = struct {
    mobs: *'a mut std.ArrayList(Mob),
    added: std.ArrayList(Mob),
    uuids: *'a mut HashMap<u32,
    creaking: ?*MobType,
    next_entity: *'a mut u32,
    spawning: bool,
};
    // rust: impl HeartHost for Host<'_> {
pub fn mob(self: *Self, id: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mobs
    // rust: .iter()
    // rust: .chain(self.added.iter())
    // rust: .find(|m| m.id == id && !m.removed)
}
pub fn mob_mut(self: *Self, id: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mobs
    // rust: .iter_mut()
    // rust: .chain(self.added.iter_mut())
    // rust: .find(|m| m.id == id && !m.removed)
}
pub fn mob_for_uuid(self: *Self, uuid: [i32; 4]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.uuids
    // rust: .iter()
    // rust: .find(|(id, u)| **u == uuid && self.mob(**id).is_some())
    // rust: .map(|(id, _)| *id)
}
pub fn uuid_for(self: *Self, id: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self
    // rust: .uuids
    // rust: .entry(id)
    // rust: .or_insert_with(horizon_client::save::random_uuid)
}
pub fn creaking_type(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.creaking.clone()
}
pub fn create_mob(self: *Self, kind: *MobType, at: Vec3) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.next_entity += 1;
        // A new entity's random is its own (Mob::new seeds it).
    // rust: let mut m = Mob::new(*self.next_entity, kind, at, 0.0);
    // rust: let seed = i64::from(m.id);
    // rust: horizon_client::mobs::monster_brain::init(&mut m, seed);
    // rust: m
}
pub fn add_mob(self: *Self, m: Mob) void {
}
    // rust: self.added.push(m);
}
pub fn spawning_monsters(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.spawning
}
}

    // rust: impl Game<'_> {
pub fn heart_state_name(self: *Self, state: BlockStateId) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("creaking_heart_state").cloned())
    // rust: .unwrap_or_default()
}
    /// Runs `f` on the heart at `key` with the game's mobs and level random,
    /// then applies what the heart reported. `others`: whether `f` reads the
    /// other mobs through the mob world (without, it holds none: building them
    /// costs a pass over every mob).
    // rust: fn with_heart(
    // rust: &mut self,
    // rust: key: Pos,
    // rust: heart: &mut CreakingHeart,
    // rust: others: bool,
    // rust: f: impl FnOnce(
    // rust: &mut CreakingHeart,
    // rust: &horizon_client::mobs::MobWorld,
    // rust: &mut LegacyRandom,
    // rust: &mut Host,
    // rust: &mut Vec<HeartEvent>,
    // rust: ),
    // rust: ) -> Result<()> {
    // rust: let mut mobs = std::mem::take(&mut self.mobs);
    // rust: let mut uuids = std::mem::take(&mut self.persist.uuids);
    // rust: let mut next_entity = self.next_entity;
    // rust: let mut random = self.world.random.clone();
    // rust: let spawning = self.spawning_monsters();
    // rust: let creaking = self.res.mob_types().get("minecraft:creaking").cloned();
    // rust: let player_uuid = self.level.player_uuid;
    // rust: let snapshot: Vec<_> = if others {
    // rust: mobs.iter().map(|m| seen(m, player_uuid)).collect()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let mut events = Vec::new();
    // rust: let added = {
    // rust: let w = self.mob_world_base(&snapshot);
    // rust: let mut host = Host {
    // rust: mobs: &mut mobs,
    // rust: added: Vec::new(),
    // rust: uuids: &mut uuids,
    // rust: creaking,
    // rust: next_entity: &mut next_entity,
    // rust: spawning,
}
    // rust: f(heart, &w, &mut random, &mut host, &mut events);
    // rust: host.added
}
    // rust: mobs.extend(added);
    // rust: self.mobs = mobs;
    // rust: self.persist.uuids = uuids;
    // rust: self.next_entity = next_entity;
    // rust: self.world.random = random;
    // rust: let mut mob_events = Vec::new();
    // rust: for e in events {
    // rust: match e {
    // rust: HeartEvent::SetBlock(at, state) => self.level_set(at, state)?,
    // rust: HeartEvent::Sound(name, at, volume, pitch) => {
    // rust: self.audio
    // rust: .play(&format!("minecraft:{name}"), Some(at), volume, pitch)
}
    // rust: HeartEvent::Trail {
    // rust: at,
    // rust: target,
    // rust: color,
    // rust: duration,
    // rust: } => self.particles.add(
    // rust: &ParticleOptions::trail(target, color, duration),
    // rust: at,
    // rust: [0.0; 3],
    // rust: ),
    // rust: HeartEvent::OutputChanged(at) => self.container_changed((at[0], at[1], at[2])),
    // rust: HeartEvent::Mob(event) => mob_events.push(event),
}
}
    // rust: self.handle_mob_events(mob_events)?;
    // rust: let _ = key;
    // rust: Ok(())
}
    /// A creaking bound to the heart at `home` was hurt (`creakingHurt`).
    // rust: pub(super) fn creaking_hurt(&mut self, home: [i32; 3], _id: u32, by_player: bool) {
    // rust: if !by_player {
    // rust: return;
}
    // rust: let key = (home[0], home[1], home[2]);
    // rust: let Some(BlockEntity::CreakingHeart(mut heart)) = self.world.block_entities.take(&key)
    // rust: else {
    // rust: return;
}
    // rust: let _ = self.with_heart(key, &mut heart, true, |h, w, lr, host, out| {
    // rust: creaking_heart::creaking_hurt(h, home, w, lr, host, out);
    // rust: });
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::CreakingHeart(heart));
}
    /// `Creaking.tearDown`: the crumble particles.
    // rust: pub(super) fn creaking_tear_down(&mut self, center: [f64; 3], spread: [f64; 3]) {
    // rust: let registry = self.pack.assets.registry;
    // rust: let crumble = |this: &mut Self, name: &str, props: &[(&str, &str)], count: i32| {
    // rust: let Some(mut state) = registry
    // rust: .default_state(name)
    // rust: .and_then(|s| registry.state(s).cloned())
    // rust: else {
    // rust: return;
}
    // rust: for (k, v) in props {
    // rust: state.properties.insert((*k).to_owned(), (*v).to_owned());
}
    // rust: let Ok(id) = registry.resolve(&state) else {
    // rust: return;
}
    // rust: let Some((sprite, tint)) = this.particle_sprite(id, center.map(|c| c.floor() as i32))
    // rust: else {
    // rust: return;
}
    // rust: for _ in 0..count {
    // rust: let r = &mut this.world.random;
    // rust: let p = [
    // rust: center[0] + r.next_gaussian() * spread[0],
    // rust: center[1] + r.next_gaussian() * spread[1],
    // rust: center[2] + r.next_gaussian() * spread[2],
    // rust: ];
    // rust: this.particles.add(
    // rust: &ParticleOptions::block(ParticleType::BlockCrumble, sprite.clone(), tint),
    // rust: p,
    // rust: [0.0; 3],
    // rust: );
}
}
    // rust: crumble(self, "minecraft:pale_oak_wood", &[], 100);
    // rust: crumble(
    // rust: self,
    // rust: "minecraft:creaking_heart",
    // rust: &[("creaking_heart_state", "awake")],
    // rust: 10,
    // rust: );
}
    /// `CreakingHeartBlock.playerWillDestroy`: the heart's creaking twitches to
    /// death and a natural heart drops experience. `onExplosionHit` does the
    /// same for the creaking (`by_player` false), without the experience.
    // rust: pub(super) fn creaking_heart_broken(&mut self, pos: [i32; 3], by_player: bool) {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: if !matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::CreakingHeart(_))
    // rust: ) {
    // rust: return;
}
    // rust: let Some(BlockEntity::CreakingHeart(mut heart)) = self.world.block_entities.take(&key)
    // rust: else {
    // rust: return;
}
    // rust: let _ = self.with_heart(key, &mut heart, false, |h, _, _, host, out| {
    // rust: creaking_heart::remove_protector(h, host, true, out);
    // rust: });
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: let natural = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get("natural").cloned())
    // rust: .is_some_and(|v| v == "true");
    // rust: if by_player && natural && !self.creative && !self.spectator() {
    // rust: let xp = 20 + self.world.random.next_int_bound(5).unwrap_or(0) as u32;
    // rust: self.spawn_orbs(
    // rust: [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ],
    // rust: xp,
    // rust: );
}
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::CreakingHeart(heart));
}
    /// `CreakingHeartBlockEntity.serverTick` of the heart at `key`. Its slot
    /// stays while uprooted, so that a heart whose block went away is still
    /// found here and lets go of its protector.
    // rust: pub(super) fn tick_creaking_heart(&mut self, key: Pos) -> Result<()> {
    // rust: let Some(BlockEntity::CreakingHeart(mut heart)) = self.world.block_entities.take(&key)
    // rust: else {
    // rust: return Ok(());
}
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: if &*self.res.facts().get(state).name != "minecraft:creaking_heart" {
            // The block is gone: preRemoveSideEffects.
    // rust: self.world.block_entities.forget(&key);
    // rust: self.with_heart(key, &mut heart, false, |h, _, _, host, out| {
    // rust: creaking_heart::remove_protector(h, host, false, out);
    // rust: })?;
    // rust: return Ok(());
}
        // getTicker: none once uprooted.
    // rust: if self.heart_state_name(state) != "uprooted" {
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let others = creaking_heart::tick_updates(&heart);
    // rust: self.with_heart(key, &mut heart, others, |h, w, lr, host, out| {
    // rust: creaking_heart::server_tick(h, pos, w, lr, host, out);
    // rust: })?;
}
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::CreakingHeart(heart));
    // rust: Ok(())
}
    /// `ServerLevel.isSpawningMonsters`.
pub fn spawning_monsters(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ui.difficulty != 0
    // rust: && self.ui.rules.bool("spawn_mobs")
    // rust: && self.ui.rules.bool("spawn_monsters")
}
    /// Hearts that came with generated or loaded chunks get their block
    /// entity (`newBlockEntity`) the first time their chunk is seen lit.
    /// Only the chunks that arrived since are looked at: a server holds tens
    /// of thousands, and reading each one every tick cost milliseconds.
    // rust: pub(super) fn scan_for_hearts(&mut self) {
    // rust: if self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:creaking_heart")
    // rust: .is_none()
    // rust: {
    // rust: return;
}
    // rust: self.creaking.follow_chunks(&self.world.chunks);
    // rust: let mut keys: Vec<(i32, i32)> = self
    // rust: .creaking
    // rust: .unscanned
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|k| self.world.chunks.get(k).is_some_and(|c| c.lit))
    // rust: .collect();
    // rust: keys.sort_unstable();
    // rust: for key in keys {
    // rust: self.creaking.unscanned.remove(&key);
    // rust: self.creaking.scanned.insert(key);
    // rust: let Some(chunk) = self.world.chunks.get(&key).cloned() else {
    // rust: continue;
}
    // rust: if self.creaking.hearts.is_empty() {
    // rust: self.creaking.hearts = self
    // rust: .res
    // rust: .facts()
    // rust: .states
    // rust: .iter()
    // rust: .map(|f| &*f.name == "minecraft:creaking_heart")
    // rust: .collect();
}
    // rust: let hearts = &self.creaking.hearts;
    // rust: let is_heart = |id: u32| hearts.get(id as usize).copied().unwrap_or(false);
    // rust: for (si, section) in chunk.sections.iter().enumerate() {
                // Only a section whose palette holds a heart state can have
                // one: the others are skipped without reading their 4,096 blocks.
    // rust: if !section.blocks.maybe_has(is_heart) {
    // rust: continue;
}
    // rust: for i in 0..4096 {
    // rust: let id = section.get(i);
    // rust: if !is_heart(id) {
    // rust: continue;
}
    // rust: let (lx, lz, ly) = ((i & 15) as i32, ((i >> 4) & 15) as i32, (i >> 8) as i32);
    // rust: let pos = (
    // rust: key.0 * 16 + lx,
    // rust: self.world.bottom_y() + si as i32 * 16 + ly,
    // rust: key.1 * 16 + lz,
    // rust: );
    // rust: self.world
    // rust: .block_entities
    // rust: .get_or_insert_with(pos, || BlockEntity::CreakingHeart(Box::default()));
}
}
}
}
}

/// What the creaking code remembers between ticks.
    // rust: pub(super) struct CreakingState {
    /// Chunks already scanned for heart blocks.
    // rust: scanned: horizon_client::fast_hash::FxHashSet<(i32, i32)>,
    /// Resident chunks not scanned yet (not lit yet, or just arrived).
    // rust: unscanned: horizon_client::fast_hash::FxHashSet<(i32, i32)>,
    /// The chunk map's membership revision the two sets follow.
    // rust: revision: Option<u64>,
    /// Which block states are creaking hearts, by state id.
    // rust: hearts: Vec<bool>,
}

    // rust: impl CreakingState {
    /// Exchange the chunks scanned for creaking hearts with another level's
    /// (game/levels.rs).
    // rust: pub(super) fn swap_level(&mut self, other: &mut Self) {
    // rust: std::mem::swap(&mut self.scanned, &mut other.scanned);
    // rust: std::mem::swap(&mut self.unscanned, &mut other.unscanned);
    // rust: std::mem::swap(&mut self.revision, &mut other.revision);
}
    /// Bring `scanned` and `unscanned` up to the chunks resident now: a
    /// chunk that left is forgotten (it is scanned again if it comes back
    /// later), one that arrived waits to be scanned. From the map's
    /// membership changes, or from all its keys when they can't be replayed.
pub fn follow_chunks(self: *Self, chunks: *ChunkMap) void {
}
    // rust: let revision = chunks.membership_revision();
    // rust: if self.revision == Some(revision) {
    // rust: return;
}
    // rust: let deltas = self.revision.and_then(|r| chunks.deltas_since(r));
    // rust: match deltas {
    // rust: Some(deltas) => {
    // rust: for (_, delta) in deltas {
    // rust: match delta {
    // rust: ChunkMembershipDelta::Added(key) => {
    // rust: if chunks.contains_key(&key) && !self.scanned.contains(&key) {
    // rust: self.unscanned.insert(key);
}
}
    // rust: ChunkMembershipDelta::Removed(key) => {
    // rust: if !chunks.contains_key(&key) {
    // rust: self.scanned.remove(&key);
    // rust: self.unscanned.remove(&key);
}
}
    // rust: ChunkMembershipDelta::Reset => {}
}
}
}
    // rust: None => {
    // rust: self.scanned.retain(|k| chunks.contains_key(k));
    // rust: self.unscanned = chunks
    // rust: .keys()
    // rust: .filter(|k| !self.scanned.contains(k))
    // rust: .copied()
    // rust: .collect();
}
}
    // rust: self.revision = Some(revision);
}
}

    // rust: mod tests {
//     use super::CreakingState;
//     use horizon_client::{chunk::Chunk, chunk_map::ChunkMap};
//     use std::sync::Arc;

pub fn add(chunks: *mut ChunkMap, key: (i32) void {
}
    // rust: chunks.insert(key, Arc::new(Chunk::empty(key.0, key.1)));
}
pub fn sorted(set: *horizon_client::fast_hash::FxHashSet<(i32) void {
}
    // rust: let mut keys: Vec<_> = set.iter().copied().collect();
    // rust: keys.sort_unstable();
    // rust: keys
}

    /// The heart scan follows the chunks that come and go, as the scan of
    /// every resident chunk each tick did: an arrival waits, a scanned chunk
    /// that stayed is not scanned again, and one that left is forgotten.
pub fn the_heart_scan_follows_arrivals_and_departures() void {
}
    // rust: let mut chunks = ChunkMap::default();
    // rust: let mut state = CreakingState::default();
    // rust: add(&mut chunks, (0, 0));
    // rust: add(&mut chunks, (1, 0));
    // rust: state.follow_chunks(&chunks);
    // rust: assert_eq!(sorted(&state.unscanned), [(0, 0), (1, 0)]);
        // Scanned, as scan_for_hearts does once a chunk is lit.
    // rust: state.unscanned.remove(&(0, 0));
    // rust: state.scanned.insert((0, 0));
    // rust: add(&mut chunks, (2, 0));
    // rust: chunks.remove(&(1, 0));
        // Gone and back between two ticks: still scanned, as before.
    // rust: chunks.remove(&(0, 0));
    // rust: add(&mut chunks, (0, 0));
    // rust: state.follow_chunks(&chunks);
    // rust: assert_eq!(sorted(&state.scanned), [(0, 0)]);
    // rust: assert_eq!(sorted(&state.unscanned), [(2, 0)]);
        // Gone over a tick: forgotten, and scanned again when it returns.
    // rust: chunks.remove(&(0, 0));
    // rust: state.follow_chunks(&chunks);
    // rust: assert!(state.scanned.is_empty());
    // rust: add(&mut chunks, (0, 0));
    // rust: state.follow_chunks(&chunks);
    // rust: assert_eq!(sorted(&state.unscanned), [(0, 0), (2, 0)]);
        // A cleared map can't be replayed: rebuilt from its keys.
    // rust: chunks.clear();
    // rust: add(&mut chunks, (5, 5));
    // rust: state.follow_chunks(&chunks);
    // rust: assert_eq!(sorted(&state.unscanned), [(5, 5)]);
    // rust: assert!(state.scanned.is_empty());
}
}
