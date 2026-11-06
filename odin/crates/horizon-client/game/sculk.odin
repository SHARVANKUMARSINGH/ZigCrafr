//! Transpiled from Horizon Rust crate
package horizon_client_sculk

import "core:fmt"
import "core:mem"
import "core:math"

// Game events and sculk on the game side: dispatching events to sculk
// sensors, shriekers and wardens (`GameEventDispatcher`), the vibration
// ticker, redstone output, resonance, shrieks and warden summoning
// (`SculkShriekerBlockEntity`, `SpawnUtil`), catalysts feeding the sculk
// spreader from deaths, and the darkness wardens and shriekers cast.
// use super::{Game, Result};
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: effects::{EffectInstance, PlayerEffects},
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: mobs::{Mob, Species, Who, allay, warden},
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: sculk::{self, Context, Info, SculkEntity, SculkKind, WardenSpawnTracker},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use horizon_protocol::entity_data::PositionSource;
// use horizon_world::registry::BlockStateId;
// use std::collections::HashSet;

    // rust: pub const HELP: &[&str] = &[
    // rust: "sculk                          sculk listeners, the warning level and the darkness blend",
    // rust: "sculk charge X Y Z AMOUNT      a mob dying there with that much experience (the nearest catalyst takes it)",
    // rust: "sculk warn LEVEL               set the player's warden warning level",
    // rust: "sculk dig                      end the minute of calm of every warden",
    // rust: ];

// The sculk block kinds by state id, built once.
Tables :: struct {
    built: bool,
    // 0 none, 1 sensor, 2 calibrated sensor, 3 shrieker, 4 catalyst.
    kinds: [dynamic]u8,
    occludes: [dynamic]bool,
    dampens: [dynamic]bool,
    resonator: [dynamic]bool,
    // The `minecraft:climbable` tag, and the two redstone ores: read for
    // every mob on every tick.
    climbable: [dynamic]bool,
    redstone_ore: [dynamic]bool,
}
// `SculkSensorBlock.getAnalogOutputSignal`: the last vibration's frequency
// while the sensor is active.
    // rust: pub(super) fn sensor_signal(
    // rust: world: &horizon_client::world::World,
    // rust: behaviours: &horizon_world::level::Behaviours,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: ) -> Option<i32> {
    // rust: match world.block_entities.get(&(pos.x, pos.y, pos.z)) {
    // rust: Some(BlockEntity::Sculk(e))
    // rust: if matches!(e.kind, SculkKind::Sensor | SculkKind::Calibrated) =>
    // rust: {
    // rust: Some(if behaviours.sculk_sensor_active(state) {
    // rust: e.last_frequency
    // rust: } else {
    // rust: 0
    // rust: })
}
    // rust: _ => None,
}
}
// `Entity.moveDist` / `nextStep` and the last state, per entity.
Steps :: struct {
    move_dist: f32,
    next_step: f32,
    last: [f64,
    on_ground: bool,
    in_water: bool,
}
    // rust: pub(super) struct PlayerEvents {
    // rust: steps: Option<Steps>,
    // rust: last_health: Option<f32>,
    // rust: mount: Option<(u32, [f64; 3])>,
}

    // rust: pub(super) struct SculkState {
    // The player's warning level toward a warden.
    // rust: pub tracker: WardenSpawnTracker,
    // rust: tables: Tables,
    // The sculk block entities in the order they were added.
    // rust: index: Index,
    // rust: pub known: HashSet<(i32, i32)>,
    // The chunk map's membership revision `known` was taken at.
    // rust: pub known_revision: Option<u64>,
    // Keyed by mob ids the server gives out: the fast hasher is safe.
    // rust: steps: FxHashMap<Who, Steps>,
    // Items that have fallen since last touching the ground or water.
    // rust: falling_items: HashSet<u32>,
    // The vehicle each rider had last tick and where it stood.
    // rust: mounts: FxHashMap<Who, (u32, [f64; 3])>,
    // rust: damaged: FxHashMap<u32, i64>,
    // Set while the mobs' events are posted (`tick_mob_sculk_events`).
    // rust: mob_slots: Option<MobSlots>,
    // rust: last_health: Option<f32>,
    // The darkness effect's blend factor, previous and current tick.
    // rust: pub darkness: (f32, f32),
    // Who causes the block changes being processed (the player's actions).
    // rust: pub actor: Option<Who>,
    // rust: ticks: u32,
    // rust: pub tracker_loaded: bool,
}

// How far from a warden's or an allay's feet an event may be heard: their
// listeners reach 16 blocks from the eye's block (`warden::listen`,
// `allay::listen`), the eye stands under 3 blocks up, and flooring to blocks
// adds under 2. Past this they do nothing with it.
LISTENING_MOB_REACH :: 24.0

dist_sqr_f :: proc(a: [f64; 3], b: [f64; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (0..3).map(|i| (a[i] - b[i]) * (a[i] - b[i])).sum()
}

// Where each mob is in `Game::mobs` while the mobs' events are posted, for
// the thousands of lookups by id they make, and whether any mob listens.
MobSlots :: struct {
    // The first slot of each id, as a scan would find.
    by_id: FxHashMap<u32,
    // The wardens and allays (the mobs that listen): slot, id and position.
    listeners: Vec<(uint,
    // `Game::next_entity` when they were taken: unchanged, no mob joined.
    next_entity: u32,
}

    // rust: impl SculkState {
    // rust: pub(super) fn swap_player(&mut self, other: &mut PlayerEvents) {
    // rust: let steps = self.steps.remove(&Who::Player);
    // rust: if let Some(guest) = other.steps.take() {
    // rust: self.steps.insert(Who::Player, guest);
}
    // rust: other.steps = steps;
    // rust: let mount = self.mounts.remove(&Who::Player);
    // rust: if let Some(guest) = other.mount.take() {
    // rust: self.mounts.insert(Who::Player, guest);
}
    // rust: other.mount = mount;
    // rust: std::mem::swap(&mut self.last_health, &mut other.last_health);
}

    // Exchange the level-held parts (its sculk block entities and the
    // chunks scanned for them) with another level's (game/levels.rs).
    // rust: pub(super) fn swap_level(&mut self, other: &mut Self) {
    // rust: std::mem::swap(&mut self.index, &mut other.index);
    // rust: std::mem::swap(&mut self.known, &mut other.known);
}
}
// An insertion-ordered set of block positions (`Level.blockEntityTickers`
// keeps the order block entities were added in).
Index :: struct {
    order: Vec<(i32,
    set: HashSet<(i32,
    // The positions by 32-block cell, each with its rank: ranks only grow,
    // so sorting by them gives `order`'s order. Every mob's step posts a
    // game event, and the listeners near it are read from at most eight
    // cells instead of the whole level's.
    cells: FxHashMap<(i32,
    next: u64,
}
index_cell :: proc(key: (i32) {
}
    // rust: (key.0 >> 5, key.1 >> 5, key.2 >> 5)
}
    // rust: impl Index {
insert :: proc(self: ^Self, key: (i32) {
}
    // rust: if self.set.insert(key) {
    // rust: self.order.push(key);
    // rust: self.cells
    // rust: .entry(index_cell(key))
    // rust: .or_default()
    // rust: .push((self.next, key));
    // rust: self.next += 1;
}
}
remove :: proc(self: ^Self, key: ^(i32) {
}
    // rust: if self.set.remove(key) {
    // rust: self.order.retain(|k| k != key);
    // rust: let cell = index_cell(*key);
    // rust: if let Some(list) = self.cells.get_mut(&cell) {
    // rust: list.retain(|(_, k)| k != key);
    // rust: if list.is_empty() {
    // rust: self.cells.remove(&cell);
}
}
}
}
    // The positions whose `dist_sqr` to `at` is at most `radius` squared,
    // in `order`'s order: what filtering `iter` gives.
within :: proc(self: ^Self, at: [i32; 3], radius: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let limit = i64::from(radius * radius);
    // rust: let span = |v: i32| {
    // rust: let cell = |w: i64| (w >> 5).clamp(i64::from(i32::MIN), i64::from(i32::MAX)) as i32;
    // rust: cell(i64::from(v) - i64::from(radius))..=cell(i64::from(v) + i64::from(radius))
}
    // rust: let mut found: Vec<(u64, (i32, i32, i32))> = Vec::new();
    // rust: for x in span(at[0]) {
    // rust: for y in span(at[1]) {
    // rust: for z in span(at[2]) {
    // rust: if let Some(list) = self.cells.get(&(x, y, z)) {
    // rust: found.extend(list.iter().filter(|(_, k)| dist_sqr(at, *k) <= limit));
}
}
}
}
    // rust: found.sort_unstable_by_key(|(rank, _)| *rank);
    // rust: found.into_iter().map(|(_, k)| k).collect()
}
contains :: proc(self: ^Self, key: ^(i32) {
}
    // rust: self.set.contains(key)
}
iter :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.order.iter()
}
retain :: proc(self: ^Self, mut keep: impl FnMut(^(i32) {
}
    // rust: self.order.retain(|k| keep(k));
    // rust: self.set.retain(|k| keep(k));
    // rust: self.cells.retain(|_, list| {
    // rust: list.retain(|(_, k)| keep(k));
    // rust: !list.is_empty()
    // rust: });
}
}
KIND_SENSOR :: 1
KIND_CALIBRATED :: 2
KIND_SHRIEKER :: 3
KIND_CATALYST :: 4

center :: proc(p: (i32) {
}
    // rust: [
    // rust: f64::from(p.0) + 0.5,
    // rust: f64::from(p.1) + 0.5,
    // rust: f64::from(p.2) + 0.5,
    // rust: ]
}
block_of :: proc(p: [f64; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ]
}
dist_sqr :: proc(a: [i32; 3], b: (i32) {
}
    // rust: let d = |x: i32, y: i32| i64::from(x) - i64::from(y);
    // rust: d(a[0], b.0).pow(2) + d(a[1], b.1).pow(2) + d(a[2], b.2).pow(2)
}

    // rust: impl Game<'_> {
    // Run `f` with the player as the cause of the block changes it makes.
    // rust: pub(super) fn with_player_actor<T>(&mut self, f: impl FnOnce(&mut Self) -> T) -> T {
    // rust: let prior = self.sculk.actor.replace(Who::Player);
    // rust: let out = f(self);
    // rust: self.sculk.actor = prior;
    // rust: out
}

    // The `sculk` control command: listeners and their vibrations, or a
    // test charge for the nearest catalyst.
    // rust: pub(super) fn sculk_command(&mut self, words: &[&str]) -> Result<serde_json::Value> {
    // rust: match words.get(1).copied() {
    // rust: Some("charge") => {
    // rust: let num = |i: usize| -> Result<f64> {
    // rust: Ok(words.get(i).ok_or("missing argument")?.parse::<f64>()?)
}
    // rust: let at = [num(2)?, num(3)?, num(4)?];
    // rust: let amount = num(5)? as u32;
    // rust: let taken = self.catalyst_takes_experience(at, |_| amount);
    // rust: Ok(serde_json::json!({ "ok": true, "taken": taken }))
}
    // rust: Some("dig") => {
                // Let every warden's minute of calm run out.
    // rust: for m in self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .filter(|m| m.species() == Species::Warden)
    // rust: {
    // rust: warden::expire_dig_cooldown(m);
}
    // rust: Ok(serde_json::json!({ "ok": true }))
}
    // rust: Some("warn") => {
    // rust: let level = words.get(2).ok_or("missing level")?.parse::<i32>()?;
    // rust: self.sculk.tracker.set_warning_level(level);
    // rust: Ok(serde_json::json!({ "ok": true }))
}
    // rust: _ => Ok(self.sculk_status()),
}
}
    // The `sculk` control command's listing.
    // rust: pub(super) fn sculk_status(&self) -> serde_json::Value {
    // rust: let listeners: Vec<serde_json::Value> = self
    // rust: .sculk
    // rust: .index
    // rust: .iter()
    // rust: .filter_map(|key| match self.world.block_entities.get(key) {
    // rust: Some(BlockEntity::Sculk(e)) => Some(serde_json::json!({
    // rust: "pos": [key.0, key.1, key.2],
    // rust: "kind": e.id(),
    // rust: "current": e.vibration.current.map(|i| i.event),
    // rust: "travel": e.vibration.travel,
    // rust: "last_frequency": e.last_frequency,
    // rust: "warning_level": e.warning_level,
    // rust: "cursors": e.spreader.cursors.len(),
    // rust: })),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: serde_json::json!({
    // rust: "listeners": listeners,
    // rust: "warning_level": self.sculk.tracker.warning_level,
    // rust: "cooldown": self.sculk.tracker.cooldown_ticks,
    // rust: "darkness": self.sculk.darkness.1,
    // rust: "chunks_known": self.sculk.known.len(),
    // rust: })
}
    // `WardenSpawnTrackerCommand`: clear the player's tracker or set its
    // warning level.
    // rust: pub(super) fn cmd_warden_spawn_tracker(&mut self, level: Option<i32>) {
//         use horizon_client::text::Text;
    // rust: let key = match level {
    // rust: Some(level) => {
    // rust: self.sculk.tracker.set_warning_level(level);
    // rust: "commands.warden_spawn_tracker.set.success.single"
}
    // rust: None => {
    // rust: self.sculk.tracker.reset();
    // rust: "commands.warden_spawn_tracker.clear.success.single"
}
}
    // rust: if self.ui.rules.bool("send_command_feedback") {
    // rust: self.system_message(Text::translate(
    // rust: key,
    // rust: &[Text::literal(super::chat::PLAYER_NAME)],
    // rust: ));
}
}
    // `ServerPlayer`'s `warden_spawn_tracker` from the player data.
load_warden_tracker :: proc(self: ^Self) {
}
    // rust: if self.sculk.tracker_loaded {
    // rust: return;
}
    // rust: self.sculk.tracker_loaded = true;
    // rust: if let Some(tag) = self
    // rust: .level
    // rust: .player_extra
    // rust: .as_ref()
    // rust: .and_then(|p| p.get("warden_spawn_tracker"))
    // rust: {
    // rust: self.sculk.tracker = WardenSpawnTracker::from_nbt(tag);
}
}
    // Write the tracker into the player data being saved.
    // rust: pub(super) fn save_warden_tracker(&mut self) {
    // rust: if !self.sculk.tracker_loaded {
    // rust: return;
}
    // rust: let tag = self.sculk.tracker.to_nbt();
    // rust: let extra = self
    // rust: .level
    // rust: .player_extra
    // rust: .get_or_insert_with(|| horizon_world::nbt::Tag::Compound(Default::default()));
    // rust: if let horizon_world::nbt::Tag::Compound(map) = extra {
    // rust: map.insert("warden_spawn_tracker".into(), tag);
}
}
    // Who is causing the block changes being processed.
    // rust: pub(super) fn sculk_actor(&self) -> Option<Who> {
    // rust: self.sculk.actor
}

    // ---- setup and the block entity index ----

    // rust: pub(super) fn sculk_prepare(&mut self) {
    // rust: if self.sculk.tables.built {
    // rust: return;
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let n = registry.len();
    // rust: let tag = |name: &str| {
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get(name)
    // rust: .cloned()
    // rust: .unwrap_or_default()
}
    // rust: let (wool, dampening, resonators, climbable) = (
    // rust: tag("minecraft:occludes_vibration_signals"),
    // rust: tag("minecraft:dampens_vibrations"),
    // rust: tag("minecraft:vibration_resonators"),
    // rust: tag("minecraft:climbable"),
    // rust: );
    // rust: let mut t = Tables {
    // rust: built: true,
    // rust: kinds: vec![0; n],
    // rust: occludes: vec![false; n],
    // rust: dampens: vec![false; n],
    // rust: resonator: vec![false; n],
    // rust: climbable: vec![false; n],
    // rust: redstone_ore: vec![false; n],
}
    // rust: for i in 0..n {
    // rust: let facts = self.res.facts().get(BlockStateId(i as u32));
    // rust: let name: &str = &facts.name;
    // rust: t.kinds[i] = match name {
    // rust: "minecraft:sculk_sensor" => KIND_SENSOR,
    // rust: "minecraft:calibrated_sculk_sensor" => KIND_CALIBRATED,
    // rust: "minecraft:sculk_shrieker" => KIND_SHRIEKER,
    // rust: "minecraft:sculk_catalyst" => KIND_CATALYST,
    // rust: _ => 0,
}
    // rust: t.occludes[i] = wool.contains(name);
    // rust: t.dampens[i] = dampening.contains(name);
    // rust: t.resonator[i] = resonators.contains(name);
    // rust: t.climbable[i] = climbable.contains(name);
    // rust: t.redstone_ore[i] = matches!(
    // rust: name,
    // rust: "minecraft:redstone_ore" | "minecraft:deepslate_redstone_ore"
    // rust: );
}
    // rust: self.world.watched = t.kinds.iter().map(|k| *k != 0).collect();
    // rust: self.sculk.tables = t;
}
kind_of_state :: proc(self: ^Self, state: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.sculk
    // rust: .tables
    // rust: .kinds
    // rust: .get(state as usize)
    // rust: .copied()
    // rust: .unwrap_or(0)
}
state_is :: proc(self: ^Self, table: ^[bool], state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: table.get(state.0 as usize).copied().unwrap_or(false)
}
entity_for_kind :: proc(kind: u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(SculkEntity::new(match kind {
    // rust: KIND_SENSOR => SculkKind::Sensor,
    // rust: KIND_CALIBRATED => SculkKind::Calibrated,
    // rust: KIND_SHRIEKER => SculkKind::Shrieker,
    // rust: KIND_CATALYST => SculkKind::Catalyst,
    // rust: _ => return None,
    // rust: }))
}
    // Find the sculk blocks of chunks that just became resident, and apply
    // the block writes recorded since the last tick.
    // rust: pub(super) fn sculk_sync_index(&mut self) {
        // Chunks that arrived or left (every half second is plenty).
        // Nothing to do while no chunk came or went.
    // rust: let revision = self.world.chunks.membership_revision();
    // rust: if self.sculk.ticks.is_multiple_of(10) && self.sculk.known_revision != Some(revision) {
    // rust: self.sculk.known_revision = Some(revision);
    // rust: let loaded: HashSet<(i32, i32)> = self.world.chunks.keys().copied().collect();
    // rust: let arrived: Vec<(i32, i32)> = loaded.difference(&self.sculk.known).copied().collect();
    // rust: for key in arrived {
    // rust: self.sculk_scan_chunk(key);
}
            // The blocks of every chunk that left, in one pass: a player
            // leaving unloads thousands of chunks at once.
    // rust: let gone: HashSet<(i32, i32)> = self.sculk.known.difference(&loaded).copied().collect();
    // rust: if !gone.is_empty() {
    // rust: self.sculk
    // rust: .index
    // rust: .retain(|p| !gone.contains(&(p.0 >> 4, p.2 >> 4)));
}
    // rust: self.sculk.known = loaded;
}
    // rust: let writes = std::mem::take(&mut self.world.watched_writes);
    // rust: for (key, old, new) in writes {
    // rust: let (old_kind, new_kind) = (self.kind_of_state(old), self.kind_of_state(new));
    // rust: if old_kind == new_kind {
    // rust: continue;
}
            // SculkShriekerBlockEntity.preRemoveSideEffects.
    // rust: if old_kind == KIND_SHRIEKER
    // rust: && let Some(BlockEntity::Sculk(e)) = self.world.block_entities.get(&key)
    // rust: && self.shrieker_shrieking(BlockStateId(old))
    // rust: {
    // rust: let warning = e.warning_level;
    // rust: self.shrieker_respond(key, BlockStateId(old), warning);
}
    // rust: if matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Sculk(_))
    // rust: ) {
    // rust: self.world.block_entities.remove(&key);
}
    // rust: self.sculk.index.remove(&key);
    // rust: if let Some(e) = Self::entity_for_kind(new_kind) {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert(key, BlockEntity::Sculk(Box::new(e)));
    // rust: self.sculk.index.insert(key);
}
}
}
sculk_scan_chunk :: proc(self: ^Self, key: (i32) {
}
    // rust: let Some(chunk) = self.world.chunks.get(&key).cloned() else {
    // rust: return;
}
    // rust: let mut found = Vec::new();
    // rust: for (s, section) in chunk.sections.iter().enumerate() {
    // rust: let y0 = self.world.bottom_y() + s as i32 * 16;
            // Without a sculk state in its palette, no block of the section
            // is one: most sections are passed over without reading a block.
    // rust: if !section.blocks.maybe_has(|v| self.kind_of_state(v) != 0) {
    // rust: continue;
}
    // rust: if section.blocks.uniform().is_some() {
                // A uniform section of sculk blocks does not exist.
    // rust: continue;
}
    // rust: let mut a = [0u32; 4096];
    // rust: section.unpack(&mut a);
    // rust: for (i, v) in a.iter().enumerate() {
    // rust: if self.kind_of_state(*v) != 0 {
    // rust: let (x, z, y) = (i & 15, (i >> 4) & 15, i >> 8);
    // rust: found.push((
    // rust: key.0 * 16 + x as i32,
    // rust: y0 + y as i32,
    // rust: key.1 * 16 + z as i32,
    // rust: *v,
    // rust: ));
}
}
}
    // rust: for (x, y, z, state) in found {
    // rust: let pos = (x, y, z);
    // rust: if !matches!(
    // rust: self.world.block_entities.get(&pos),
    // rust: Some(BlockEntity::Sculk(_))
    // rust: ) && let Some(e) = Self::entity_for_kind(self.kind_of_state(state))
    // rust: {
    // rust: self.world
    // rust: .block_entities
    // rust: .insert(pos, BlockEntity::Sculk(Box::new(e)));
}
    // rust: self.sculk.index.insert(pos);
}
}
sculk_entity :: proc(self: ^Self, key: (i32) {
}
    // rust: match self.world.block_entities.get_mut(&key) {
    // rust: Some(BlockEntity::Sculk(e)) => Some(e),
    // rust: _ => None,
}
}

    // ---- contexts ----

state_dampens :: proc(self: ^Self, state: Maybe(BlockStateId)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state.is_some_and(|s| self.state_is(&self.sculk.tables.dampens, s))
}
    // `GameEvent.Context.of(player, state)`.
    // rust: pub(super) fn player_context(&self, state: Option<BlockStateId>) -> Context {
    // rust: let (dead, creative) = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map_or((true, true), |p| (p.health.dead_or_dying(), self.creative));
    // rust: Context {
    // rust: source: Some(Who::Player),
    // rust: owner: None,
    // rust: dampening_state: self.state_dampens(state),
    // rust: spectator: self.spectator(),
    // rust: stepping_carefully: self.keys.held(Action::Sneak),
    // rust: dampens: false,
    // rust: targetable: !dead && !creative && !self.spectator(),
    // rust: living: true,
    // rust: player: true,
}
}
    // `GameEvent.Context.of(mob, state)`.
    // rust: pub(super) fn mob_context(&self, id: u32, state: Option<BlockStateId>) -> Context {
    // rust: self.context_of_mob(self.mob_by_id(id), id, state)
}
    // The first mob with this id, from the slots taken for the mobs' events
    // while the mob is still there (mobs are only appended meanwhile), else
    // by a scan.
mob_by_id :: proc(self: ^Self, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(slots) = &self.sculk.mob_slots
    // rust: && let Some(&i) = slots.by_id.get(&id)
    // rust: && self.mobs.get(i).is_some_and(|m| m.id == id)
    // rust: {
    // rust: return self.mobs.get(i);
}
    // rust: self.mobs.iter().find(|m| m.id == id)
}
context_of_mob :: proc(self: ^Self, mob: Maybe(^Mob), id: u32, state: Maybe(BlockStateId)) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Context {
    // rust: source: Some(Who::Mob(id)),
    // rust: owner: None,
    // rust: dampening_state: self.state_dampens(state),
    // rust: spectator: false,
    // rust: stepping_carefully: false,
    // rust: dampens: mob.is_some_and(|m| m.species() == Species::Warden),
    // rust: targetable: mob.is_some_and(|m| m.alive() && m.species() != Species::Warden),
    // rust: living: true,
    // rust: player: mob.is_some_and(|m| m.rider.is_some()),
}
}
    // rust: pub(super) fn who_context(&self, who: Option<Who>, state: Option<BlockStateId>) -> Context {
    // rust: match who {
    // rust: Some(Who::Player) => self.player_context(state),
    // rust: Some(Who::Mob(id)) => self.mob_context(id, state),
    // rust: None => Context {
    // rust: dampening_state: self.state_dampens(state),
    // rust: ..Context::default()
    // rust: },
}
}

    // ---- posting ----

    // `Level.gameEvent`: tell the listeners within reach.
    // rust: pub(super) fn post_game_event(&mut self, event: &'static str, pos: [f64; 3], ctx: Context) {
    // rust: self.post_game_event_with(event, pos, |_| ctx);
}
    // [`Self::post_game_event`] with the context worked out only when some
    // listener may hear the event (`GameEventDispatcher.post` visits only the
    // listeners registered in the sections around it): most of a server's
    // mobs are near none.
    // rust: fn post_game_event_with(
    // rust: &mut self,
    // rust: event: &'static str,
    // rust: pos: [f64; 3],
    // rust: ctx: impl FnOnce(&Self) -> Context,
    // rust: ) {
    // rust: self.native_game_event(event, pos);
    // rust: super::dispense_fixture::record(|| {
    // rust: format!(
    // rust: "G {},{},{} {event}",
    // rust: pos[0].floor() as i32,
    // rust: pos[1].floor() as i32,
    // rust: pos[2].floor() as i32
    // rust: )
    // rust: });
    // rust: if self.remote.is_some() || !self.sculk.tables.built {
    // rust: return;
}
    // rust: let at = block_of(pos);
    // rust: let radius = sculk::notification_radius(event).min(16);
    // rust: let near = self.sculk.index.within(at, radius);
        // The wardens and allays that may hear it, in the mobs' order, while
        // the slots taken for the mobs' events hold; else every mob is asked.
    // rust: let mobs = self.sculk.mob_slots.as_ref().and_then(|s| {
    // rust: let mut near = Vec::new();
    // rust: for &(i, id, from) in &s.listeners {
    // rust: if self.mobs.get(i).is_none_or(|m| m.id != id) {
    // rust: return None;
}
    // rust: let d = dist_sqr_f(from, pos);
    // rust: if d.is_nan() || d <= LISTENING_MOB_REACH * LISTENING_MOB_REACH {
    // rust: near.push(i);
}
}
    // rust: (s.next_entity == self.next_entity).then_some(near)
    // rust: });
    // rust: if near.is_empty() && mobs.as_ref().is_some_and(Vec::is_empty) {
    // rust: return;
}
    // rust: let ctx = ctx(self);
    // rust: for key in near {
    // rust: self.sculk_listen(key, event, pos, &ctx);
}
    // rust: match mobs {
    // rust: Some(mobs) => {
    // rust: for i in mobs {
    // rust: self.mob_listen(i, event, pos, &ctx);
}
}
    // rust: None => {
    // rust: for i in 0..self.mobs.len() {
    // rust: self.mob_listen(i, event, pos, &ctx);
}
}
}
}
    // The mob at `index` hears a game event, if it is a warden or an allay.
mob_listen :: proc(self: ^Self, index: uint, event: ^'static str, pos: [f64; 3], ctx: ^Context) {
}
    // rust: if self.mobs[index].species() == Species::Warden && self.mobs[index].alive() {
    // rust: self.warden_listen(index, event, pos, ctx);
}
    // rust: if self.mobs[index].species() == Species::Allay && self.mobs[index].alive() {
    // rust: self.allay_listen(index, event, pos, ctx);
}
}
    // A game event at a block (`Level.gameEvent(source, event, pos)`).
    // rust: pub(super) fn post_block_game_event(
    // rust: &mut self,
    // rust: event: &'static str,
    // rust: pos: [i32; 3],
    // rust: who: Option<Who>,
    // rust: state: Option<BlockStateId>,
    // rust: ) {
    // rust: let ctx = self.who_context(who, state);
    // rust: self.post_game_event(event, center((pos[0], pos[1], pos[2])), ctx);
}
    // `LivingEntity.actuallyHurt`'s damage vibration, heard as the hit lands;
    // the end-of-tick scan then knows this damage.
    // rust: pub(super) fn mob_damage_event(&mut self, id: u32) {
    // rust: if let Some(t) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .and_then(|m| m.last_damage.map(|(_, t)| t))
    // rust: {
    // rust: self.sculk.damaged.insert(id, t);
}
    // rust: self.post_entity_event("minecraft:entity_damage", Who::Mob(id));
}
    // A game event of an entity at its position.
    // rust: pub(super) fn post_entity_event(&mut self, event: &'static str, who: Who) {
    // rust: let at = match who {
    // rust: Who::Player => self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]),
    // rust: Who::Mob(id) => self
    // rust: .mob_by_id(id)
    // rust: .map(|m| [m.position.x, m.position.y, m.position.z]),
}
    // rust: if let Some(at) = at {
    // rust: self.post_game_event_with(event, at, |g| g.who_context(Some(who), None));
}
}
    // `LevelEvent::GameEvent` from the block behaviour library.
    // rust: pub(super) fn sculk_level_event(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: event: &'static str,
    // rust: state: Option<BlockStateId>,
    // rust: ) {
    // rust: let who = self.sculk.actor;
    // rust: self.post_block_game_event(event, [pos.x, pos.y, pos.z], who, state);
}

occluded :: proc(self: ^Self, origin: [f64; 3], dest: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: sculk::is_occluded(origin, dest, |p| {
    // rust: self.state_is(&self.sculk.tables.occludes, self.world.block(p.x, p.y, p.z))
    // rust: })
}
    // `VibrationSystem.Listener.handleGameEvent` for a sculk block.
    // rust: fn sculk_listen(
    // rust: &mut self,
    // rust: key: (i32, i32, i32),
    // rust: event: &'static str,
    // rust: pos: [f64; 3],
    // rust: ctx: &Context,
    // rust: ) {
    // rust: let Some(entity) = self.sculk_entity(key) else {
    // rust: self.sculk.index.remove(&key);
    // rust: return;
}
    // rust: let (kind, radius, busy) = (
    // rust: entity.kind,
    // rust: entity.listener_radius(),
    // rust: entity.vibration.current.is_some(),
    // rust: );
    // rust: if kind == SculkKind::Catalyst || busy {
    // rust: return;
}
    // rust: let source_block = block_of(pos);
    // rust: if dist_sqr(source_block, key) > i64::from(radius * radius) {
    // rust: return;
}
    // rust: let listens = match kind {
    // rust: SculkKind::Shrieker => sculk::shrieker_can_listen(event),
    // rust: _ => sculk::is_vibration(event),
}
        // VibrationSystem.User.isValidVibration: a player sneaking past a
        // sensor, whose step it ignores, is AVOID_VIBRATION (sensors only;
        // a shrieker cannot trigger it).
    // rust: if listens
    // rust: && matches!(kind, SculkKind::Sensor | SculkKind::Calibrated)
    // rust: && ctx.source == Some(Who::Player)
    // rust: && !ctx.spectator
    // rust: && ctx.stepping_carefully
    // rust: && sculk::ignored_when_sneaking(event)
    // rust: {
    // rust: self.trigger_player("minecraft:avoid_vibration");
}
    // rust: if !sculk::valid_vibration(listens, event, ctx) {
    // rust: return;
}
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: let can_receive = match kind {
    // rust: SculkKind::Sensor | SculkKind::Calibrated => {
                // The sensor does not hear its own placement or removal.
    // rust: let own = source_block == [key.0, key.1, key.2]
    // rust: && matches!(event, "minecraft:block_destroy" | "minecraft:block_place");
    // rust: let frequency = sculk::frequency(event);
    // rust: let calibrated_out = kind == SculkKind::Calibrated && {
    // rust: let back = self.calibrated_signal(key);
    // rust: back != 0 && frequency != back
}
    // rust: !own && !calibrated_out
    // rust: && frequency != 0
    // rust: && self.res.behaviours().sculk_sensor_can_activate(state)
}
    // rust: SculkKind::Shrieker => !self.shrieker_shrieking(state) && ctx.player,
    // rust: SculkKind::Catalyst => false,
}
    // rust: if !can_receive {
    // rust: return;
}
    // rust: let dest = center(key);
    // rust: if self.occluded(pos, dest) {
    // rust: return;
}
    // rust: let distance = {
    // rust: let d = [pos[0] - dest[0], pos[1] - dest[1], pos[2] - dest[2]];
    // rust: (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt() as f32
}
    // rust: let time = self.world.game_time;
    // rust: if let Some(entity) = self.sculk_entity(key) {
    // rust: entity.vibration.schedule(
    // rust: Info {
    // rust: event,
    // rust: distance,
    // rust: pos,
    // rust: source: ctx.source,
    // rust: owner: ctx.owner,
    // rust: },
    // rust: time,
    // rust: );
}
}
calibrated_signal :: proc(self: ^Self, key: (i32) {
}
    // rust: let pos = BlockPos::new(key.0, key.1, key.2);
    // rust: let mut value = 0;
    // rust: self.with_level(|b, level, ticks| {
    // rust: value = b.calibrated_back_signal(level, ticks, pos);
    // rust: });
    // rust: value
}
shrieker_shrieking :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.state_property(state, "shrieking") == Some("true")
}
state_property :: proc(self: ^Self, state: BlockStateId, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get(key))
    // rust: .map(String::as_str)
}

    // `Warden.VibrationUser`: accept a vibration for the warden at `index`.
warden_listen :: proc(self: ^Self, index: uint, event: ^'static str, pos: [f64; 3], ctx: ^Context) {
}
    // rust: let now = self.world.game_time;
    // rust: let (occludes, world) = (&self.sculk.tables.occludes, &self.world);
    // rust: let avoided = warden::listen(&mut self.mobs[index], now, event, pos, ctx, |a, b| {
    // rust: sculk::is_occluded(a, b, |p| {
    // rust: let state = world.block(p.x, p.y, p.z);
    // rust: occludes.get(state.0 as usize).copied().unwrap_or(false)
    // rust: })
    // rust: });
    // rust: if avoided {
    // rust: self.trigger_player("minecraft:avoid_vibration");
}
}

    // `VibrationSystem.Listener.handleGameEvent` for the allay at `index`
    // (`Allay.VibrationUser`).
allay_listen :: proc(self: ^Self, index: uint, event: ^'static str, pos: [f64; 3], ctx: ^Context) {
}
    // rust: let now = self.world.game_time;
    // rust: let (occludes, world) = (&self.sculk.tables.occludes, &self.world);
    // rust: let dimension = self.dim.id();
    // rust: allay::listen(
    // rust: &mut self.mobs[index],
    // rust: now,
    // rust: event,
    // rust: pos,
    // rust: ctx,
    // rust: dimension,
    // rust: |a, b| {
    // rust: sculk::is_occluded(a, b, |p| {
    // rust: let state = world.block(p.x, p.y, p.z);
    // rust: occludes.get(state.0 as usize).copied().unwrap_or(false)
    // rust: })
    // rust: },
    // rust: );
}

    // ---- ticking ----

    // The entity phase of a tick for sculk: the player's warden spawn
    // tracker (`ServerPlayer.tick`), and the events of entities standing on
    // and moving over blocks.
    // rust: pub(super) fn tick_sculk_entities(&mut self) {
    // rust: self.sculk.ticks = self.sculk.ticks.wrapping_add(1);
        // Its steps as spans for `horizon-report` (nothing is read while spans are off).
    // rust: let mut laps = horizon_client::spans::laps();
    // rust: self.sculk_prepare();
    // rust: laps.lap("sculk_prepare");
    // rust: self.load_warden_tracker();
    // rust: self.sculk.tracker.tick();
    // rust: self.tick_darkness_blend();
    // rust: laps.lap("sculk_wardens");
    // rust: self.sculk_step_on();
    // rust: laps.lap("sculk_step_on");
    // rust: self.tick_entity_events();
    // rust: laps.lap("sculk_entity_events");
}
    // The block entity phase for sculk: vibration tickers and catalysts, in
    // the order the block entities were added (`Level.tickBlockEntities`).
    // rust: pub(super) fn tick_sculk_blocks(&mut self) -> Result<()> {
    // rust: self.sculk_prepare();
    // rust: self.sculk_sync_index();
        // `ServerLevel.shouldTickBlocksAt` in a block-ticking chunk, from
        // every player's tickets (`update_chunk_tickets`), once the chunk is
        // lit: asked once per chunk, as the sensors share few chunks. Nothing
        // a sculk tick does loads, unloads or lights a chunk or moves a ticket.
    // rust: let levels = self.tickets.levels();
    // rust: let chunks = &self.world.chunks;
    // rust: let mut ticking = FxHashMap::<(i32, i32), bool>::default();
    // rust: let mut ticks = |cx: i32, cz: i32| {
    // rust: *ticking.entry((cx, cz)).or_insert_with(|| {
    // rust: levels.block_ticking(cx, cz) && chunks.get(&(cx, cz)).is_some_and(|c| c.lit)
    // rust: })
}
        // The ticking ones in the index's order, with whether the chunks
        // around them tick too. Most sensors and catalysts wait for a
        // vibration or a death: their tick would change nothing, so they
        // are passed over here (a vibration scheduled during these ticks is
        // chosen on the next tick at the earliest, as in vanilla).
    // rust: let entities = &self.world.block_entities;
    // rust: let due: Vec<((i32, i32, i32), bool)> = self
    // rust: .sculk
    // rust: .index
    // rust: .iter()
    // rust: .filter_map(|&key| {
    // rust: let (cx, cz) = (key.0 >> 4, key.2 >> 4);
    // rust: if !ticks(cx, cz)
    // rust: || matches!(entities.get(&key), Some(BlockEntity::Sculk(e)) if e.idle())
    // rust: {
    // rust: return None;
}
    // rust: let adjacent = (-1..=1).all(|dx| (-1..=1).all(|dz| ticks(cx + dx, cz + dz)));
    // rust: Some((key, adjacent))
    // rust: })
    // rust: .collect();
    // rust: for (key, adjacent) in due {
    // rust: self.tick_sculk_block(key, adjacent)?;
}
    // rust: Ok(())
}
tick_sculk_block :: proc(self: ^Self, key: (i32) {
}
    // rust: let time = self.world.game_time;
    // rust: let Some(entity) = self.sculk_entity(key) else {
    // rust: self.sculk.index.remove(&key);
    // rust: return Ok(());
}
    // rust: match entity.kind {
    // rust: SculkKind::Catalyst => {
                // SculkCatalystBlockEntity.serverTick.
    // rust: let mut spreader = std::mem::take(&mut entity.spreader);
    // rust: if !spreader.cursors.is_empty() {
    // rust: let origin = BlockPos::new(key.0, key.1, key.2);
    // rust: self.with_level(|b, level, ticks| {
    // rust: b.sculk_update_cursors(level, ticks, &mut spreader, origin, true);
    // rust: });
    // rust: self.process_level_events()?;
}
    // rust: if let Some(e) = self.sculk_entity(key) {
                    // Cursors added while spreading keep their place.
    // rust: let added = std::mem::take(&mut e.spreader);
    // rust: e.spreader = spreader;
    // rust: for c in added.cursors {
    // rust: e.spreader.add_cursor(c);
}
}
}
    // rust: SculkKind::Sensor | SculkKind::Calibrated | SculkKind::Shrieker => {
    // rust: let tick = entity
    // rust: .vibration
    // rust: .tick(time, adjacent, true, |d| d.floor() as i32);
    // rust: if let Some((info, travel)) = tick.started {
    // rust: let source = PositionSource::Block([key.0, key.1, key.2]);
    // rust: self.vibration_particle(source, info.pos, center(key), travel);
}
    // rust: if let Some(info) = tick.received {
    // rust: self.sculk_receive(key, info)?;
}
}
}
    // rust: Ok(())
}

    // ---- sensors ----

    // `onReceiveVibration` of a sensor or a shrieker.
sculk_receive :: proc(self: ^Self, key: (i32) {
}
    // rust: let Some(entity) = self.sculk_entity(key) else {
    // rust: return Ok(());
}
    // rust: let (kind, radius) = (entity.kind, entity.listener_radius());
    // rust: let origin = block_of(info.pos);
    // rust: let distance = (dist_sqr(origin, key) as f64).sqrt() as f32;
    // rust: let block = match kind {
    // rust: SculkKind::Sensor => "minecraft:sculk_sensor",
    // rust: SculkKind::Calibrated => "minecraft:calibrated_sculk_sensor",
    // rust: SculkKind::Shrieker => "minecraft:sculk_shrieker",
    // rust: SculkKind::Catalyst => "minecraft:sculk_catalyst",
}
    // rust: let mut cancel = false;
    // rust: self.native_block_receive_game(
    // rust: self.dim.id(),
    // rust: [key.0, key.1, key.2],
    // rust: block,
    // rust: info.event,
    // rust: &mut cancel,
    // rust: );
    // rust: if cancel {
    // rust: return Ok(());
}
    // rust: match kind {
    // rust: SculkKind::Sensor | SculkKind::Calibrated => {
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: if self.res.behaviours().sculk_sensor_can_activate(state) {
    // rust: let frequency = sculk::frequency(info.event);
    // rust: if let Some(e) = self.sculk_entity(key) {
    // rust: e.last_frequency = frequency;
}
    // rust: let power = sculk::redstone_strength(distance, radius);
    // rust: self.activate_sensor(key, info.source, power, frequency)?;
}
}
    // rust: SculkKind::Shrieker => {
    // rust: let by_player = info.owner.or(info.source);
    // rust: self.try_shriek(
    // rust: key,
    // rust: by_player == Some(Who::Player) || self.rides_player(by_player),
    // rust: )?;
}
    // rust: SculkKind::Catalyst => {}
}
    // rust: Ok(())
}
rides_player :: proc(self: ^Self, who: Maybe(Who)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(who, Some(Who::Mob(id)) if self.mobs.iter().any(|m| m.id == id && m.rider.is_some()))
}
    // `SculkSensorBlock.activate`.
    // rust: fn activate_sensor(
    // rust: &mut self,
    // rust: key: (i32, i32, i32),
    // rust: source: Option<Who>,
    // rust: power: i32,
    // rust: frequency: i32,
    // rust: ) -> Result<()> {
    // rust: let pos = BlockPos::new(key.0, key.1, key.2);
    // rust: self.with_level(|b, level, ticks| b.sculk_sensor_activate(level, ticks, pos, power));
    // rust: self.process_level_events()?;
        // tryResonateVibration.
    // rust: if (1..=15).contains(&frequency) {
    // rust: for direction in Direction::ALL {
    // rust: let n = direction.normal();
    // rust: let relative = (key.0 + n[0], key.1 + n[1], key.2 + n[2]);
    // rust: let state = self.world.block(relative.0, relative.1, relative.2);
    // rust: if self.state_is(&self.sculk.tables.resonator, state) {
    // rust: let ctx = self.who_context(source, Some(state));
    // rust: self.post_game_event(
    // rust: sculk::RESONANCE[frequency as usize - 1],
    // rust: center(relative),
    // rust: ctx,
    // rust: );
    // rust: self.audio.play(
    // rust: "minecraft:block.amethyst_block.resonate",
    // rust: Some(center(relative)),
    // rust: 1.0,
    // rust: sculk::resonance_pitch(frequency),
    // rust: );
}
}
}
    // rust: let ctx = self.who_context(source, None);
    // rust: self.post_game_event(sculk::TENDRILS_CLICKING, center(key), ctx);
    // rust: self.with_level(|b, level, ticks| b.sculk_sensor_click(level, ticks, pos));
    // rust: self.process_level_events()
}
    // `SculkSensorBlock.stepOn` and `SculkShriekerBlock.stepOn`: standing on
    // them is heard (or seen) every tick.
sculk_step_on :: proc(self: ^Self) {
}
    // rust: self.sculk_step_on_player();
    // rust: let mut standing: Vec<(Who, [f64; 3])> = Vec::new();
    // rust: for m in &self.mobs {
    // rust: if m.alive() && m.on_ground {
    // rust: standing.push((Who::Mob(m.id), [m.position.x, m.position.y, m.position.z]));
}
}
    // rust: self.sculk_stand_on(standing);
}
    // `stepOn` for the player in place: the host, or a guest swapped in
    // (`guest_server_tick`), as a server has no player of its own.
    // rust: pub(super) fn sculk_step_on_player(&mut self) {
    // rust: if let Some(p) = self.player.as_ref()
    // rust: && p.ground.on_ground
    // rust: {
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: self.sculk_stand_on(vec![(Who::Player, at)]);
}
}
sculk_stand_on :: proc(self: ^Self, standing: Vec<(Who) {
}
    // rust: for (who, at) in standing {
            // getOnPosLegacy: 0.2 below the feet.
    // rust: let key = (
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 0.2).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: if !self.sculk.index.contains(&key) {
    // rust: continue;
}
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: let is_warden = matches!(who, Who::Mob(id)
    // rust: if self.mobs.iter().any(|m| m.id == id && m.species() == Species::Warden));
    // rust: match self.kind_of_state(state.0) {
    // rust: KIND_SENSOR | KIND_CALIBRATED => {
    // rust: if is_warden || !self.res.behaviours().sculk_sensor_can_activate(state) {
    // rust: continue;
}
    // rust: let calibrated = self.kind_of_state(state.0) == KIND_CALIBRATED;
    // rust: if calibrated {
    // rust: let back = self.calibrated_signal(key);
    // rust: if back != 0 && back != 1 {
    // rust: continue;
}
}
    // rust: let dest = center(key);
    // rust: let d = [at[0] - dest[0], at[1] - dest[1], at[2] - dest[2]];
    // rust: let distance = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt() as f32;
    // rust: let time = self.world.game_time;
    // rust: if let Some(e) = self.sculk_entity(key) {
    // rust: e.vibration.schedule(
    // rust: Info {
    // rust: event: "minecraft:step",
    // rust: distance,
    // rust: pos: at,
    // rust: source: Some(who),
    // rust: owner: None,
    // rust: },
    // rust: time,
    // rust: );
}
}
    // rust: KIND_SHRIEKER => {
    // rust: let by_player = who == Who::Player || self.rides_player(Some(who));
    // rust: if by_player {
    // rust: let _ = self.try_shriek(key, true);
}
}
    // rust: _ => {}
}
}
}

    // ---- shriekers ----

can_respond :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
//         use horizon_world::food::Difficulty;
    // rust: self.state_property(state, "can_summon") == Some("true")
    // rust: && self.world.health_rules.difficulty != Difficulty::Peaceful
    // rust: && self.ui.rules.bool("spawn_wardens")
}
    // `SculkShriekerBlockEntity.tryShriek`.
try_shriek :: proc(self: ^Self, key: (i32) {
}
    // rust: if !by_player {
    // rust: return Ok(());
}
    // rust: let state = self.world.block(key.0, key.1, key.2);
    // rust: if self.shrieker_shrieking(state) {
    // rust: return Ok(());
}
    // rust: if let Some(e) = self.sculk_entity(key) {
    // rust: e.warning_level = 0;
}
    // rust: if !self.can_respond(state) || self.try_to_warn(key) {
    // rust: self.shriek(key)?;
}
    // rust: Ok(())
}
    // `WardenSpawnTracker.tryWarn` for the one player.
try_to_warn :: proc(self: ^Self, key: (i32) {
}
    // rust: let c = center(key);
    // rust: let warden_nearby = self.mobs.iter().any(|m| {
    // rust: m.species() == Species::Warden
    // rust: && m.alive()
    // rust: && (m.position.x - c[0]).abs() < 24.0
    // rust: && (m.position.y + f64::from(m.height()) / 2.0 - c[1]).abs() < 24.0
    // rust: && (m.position.z - c[2]).abs() < 24.0
    // rust: });
        // The only player is the one who set it off.
    // rust: let mut trackers = [self.sculk.tracker];
    // rust: let level = WardenSpawnTracker::try_warn(&mut trackers, warden_nearby);
    // rust: self.sculk.tracker = trackers[0];
    // rust: match level {
    // rust: Some(level) => {
    // rust: if let Some(e) = self.sculk_entity(key) {
    // rust: e.warning_level = level;
}
    // rust: true
}
    // rust: None => false,
}
}
    // `SculkShriekerBlockEntity.shriek`.
shriek :: proc(self: ^Self, key: (i32) {
}
    // rust: let pos = BlockPos::new(key.0, key.1, key.2);
    // rust: self.with_level(|b, level, ticks| b.sculk_shrieker_shriek(level, ticks, pos));
    // rust: self.process_level_events()?;
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event(sculk::SHRIEK, center(key), ctx);
    // rust: Ok(())
}
    // The shriek ended (or the block went away while shrieking).
    // rust: pub(super) fn shrieker_respond(
    // rust: &mut self,
    // rust: key: (i32, i32, i32),
    // rust: state: BlockStateId,
    // rust: warning: i32,
    // rust: ) {
    // rust: if !(self.can_respond(state) && warning > 0) {
    // rust: return;
}
    // rust: if !self.try_summon_warden(key, warning) {
    // rust: self.warden_reply_sound(key, warning);
}
    // rust: self.apply_darkness(center(key), 40.0);
}
    // A `shrieker_respond` block event.
    // rust: pub(super) fn shrieker_block_event(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let key = (pos.x, pos.y, pos.z);
    // rust: let warning = self.sculk_entity(key).map_or(0, |e| e.warning_level);
    // rust: self.shrieker_respond(key, state, warning);
}
warden_reply_sound :: proc(self: ^Self, key: (i32) {
}
    // rust: let sound = match warning {
    // rust: 1 => "minecraft:entity.warden.nearby_close",
    // rust: 2 => "minecraft:entity.warden.nearby_closer",
    // rust: 3 => "minecraft:entity.warden.nearby_closest",
    // rust: 4 => "minecraft:entity.warden.listening_angry",
    // rust: _ => return,
}
    // rust: let r = &mut self.world.random;
    // rust: let mut offset = |v: i32| v + r.next_int_bound(21).unwrap_or(0) - 10;
    // rust: let at = [
    // rust: f64::from(offset(key.0)),
    // rust: f64::from(offset(key.1)),
    // rust: f64::from(offset(key.2)),
    // rust: ];
    // rust: self.audio.play(sound, Some(at), 5.0, 1.0);
}
    // `SpawnUtil.trySpawnMob(WARDEN, TRIGGERED, level, pos, 20, 5, 6,
    // ON_TOP_OF_COLLIDER, false)`: every candidate spot creates a warden
    // (`EntityType.create` draws its yaw from the level random and
    // `finalizeSpawn` plays its agitated sound), which is discarded when
    // `checkSpawnObstruction` fails.
try_summon_warden :: proc(self: ^Self, key: (i32) {
}
    // rust: if warning < 4 {
    // rust: return false;
}
    // rust: let Some(kind) = self.res.mob_types().get("minecraft:warden").cloned() else {
    // rust: return false;
}
    // rust: for _ in 0..20 {
    // rust: let r = &mut self.world.random;
    // rust: let dx = r.next_int_bound(11).unwrap_or(0) - 5;
    // rust: let dz = r.next_int_bound(11).unwrap_or(0) - 5;
    // rust: let Some(at) = self.spawn_position(key.0 + dx, key.1 + 6, key.2 + dz, 6) else {
    // rust: continue;
}
    // rust: let spot = [
    // rust: f64::from(at.0) + 0.5,
    // rust: f64::from(at.1),
    // rust: f64::from(at.2) + 0.5,
    // rust: ];
    // rust: let yaw = horizon_client::camera::wrap_degrees(self.world.random.next_float() * 360.0);
    // rust: self.next_entity += 1;
    // rust: let mut mob = Mob::new(
    // rust: self.next_entity,
    // rust: kind.clone(),
    // rust: horizon_core::geometry::Vec3::new(spot[0], spot[1], spot[2]),
    // rust: yaw,
    // rust: );
            // Warden.finalizeSpawn, then Mob.finalizeSpawn's draws from the
            // level random: the follow range bonus and left-handedness.
    // rust: let mut events = Vec::new();
    // rust: warden::finalize(&mut mob, true, &mut events);
    // rust: let _ = self.handle_mob_events(events);
    // rust: let r = &mut self.world.random;
    // rust: let bonus = r.triangle(0.0, 0.11485000000000001);
    // rust: mob.attrs.follow_range += mob.kind.follow_range * bonus;
    // rust: mob.update_max_visited_nodes();
    // rust: let _left_handed = r.next_float() < 0.05;
    // rust: if !self.warden_fits(&mob) {
    // rust: continue;
}
    // rust: self.mobs.push(mob);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
    // rust: return true;
}
    // rust: false
}
    // `SpawnUtil.moveToPossibleSpawnPosition` with `ON_TOP_OF_COLLIDER`.
spawn_position :: proc(self: ^Self, x: i32, y: i32, z: i32, range: i32) -> O {
    // Ported from Horizon
    return {}
}
//         use horizon_client::mobs::data;
    // rust: let flags = |b: BlockStateId| self.res.mob_data().state(b);
    // rust: let mut search = y;
    // rust: let mut above = self.world.block(x, search, z);
    // rust: for _ in (-range..=range).rev() {
    // rust: search -= 1;
    // rust: let current = self.world.block(x, search, z);
    // rust: let empty_above = flags(above).top == 0.0;
    // rust: let full_top = flags(current).flags & data::STURDY_TOP != 0;
    // rust: if empty_above && full_top {
    // rust: return Some((x, search + 1, z));
}
    // rust: above = current;
}
    // rust: None
}
    // `Warden.checkSpawnObstruction`: no liquid in its box, no living entity
    // in the way (`isUnobstructed`), and no block collision.
warden_fits :: proc(self: ^Self, mob: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bounds = mob.bounds();
    // rust: let player_blocks = self
    // rust: .level_players()
    // rust: .iter()
    // rust: .any(|p| p.alive && !p.spectator && p.bounds.intersects(bounds));
    // rust: if player_blocks
    // rust: || self
    // rust: .mobs
    // rust: .iter()
    // rust: .any(|m| !m.removed && m.alive() && m.bounds().intersects(bounds))
    // rust: {
    // rust: return false;
}
    // rust: let others: Vec<horizon_client::mobs::Seen> = Vec::new();
    // rust: let w = self.mob_world_base(&others);
    // rust: let min = bounds.min_position();
    // rust: let max = bounds.max_position();
        // Level.containsAnyLiquid: floor(min) up to ceil(max), exclusive.
    // rust: for x in min.x.floor() as i32..max.x.ceil() as i32 {
    // rust: for y in min.y.floor() as i32..max.y.ceil() as i32 {
    // rust: for z in min.z.floor() as i32..max.z.ceil() as i32 {
    // rust: if w.fluid(x, y, z) != horizon_client::blocks::Fluid::None {
    // rust: return false;
}
}
}
}
    // rust: w.no_collision(bounds)
}

    // ---- darkness ----

    // The darkness effect's blend, where this game ticks the player in its
    // own level (a server's client ticks it in `tick_client_effects`).
tick_darkness_blend :: proc(self: ^Self) {
}
    // rust: self.sculk.darkness = darkness_blend_tick(&self.potions.effects, self.sculk.darkness);
}
    // The darkness effect's blend factor at the partial tick.
darkness_blend :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (previous, current) = self.sculk.darkness;
    // rust: previous + (current - previous) * partial
}
    // The fog's view of the darkness effect, while it is on.
    // rust: pub(super) fn darkness_fog(&self) -> Option<f32> {
    // rust: self.potions
    // rust: .effects
    // rust: .get("darkness")
    // rust: .map(|_| self.darkness_blend(self.clock.fraction() as f32))
}
    // `LightmapRenderStateExtractor`: (brightness taken off the gamma
    // option, the pulsing light scale).
    // rust: pub(super) fn darkness_lighting(&self, partial: f32) -> (f32, f32) {
    // rust: let scale = self.settings.file.double("darknessEffectScale") as f32;
    // rust: let modifier = self.darkness_blend(partial) * scale;
    // rust: let pulse = ((self.visual_ticks() as f32 - partial) * std::f32::consts::PI * 0.025).cos()
    // rust: * 0.45
    // rust: * modifier;
    // rust: (modifier, pulse.max(0.0) * scale)
}

    // `LightmapRenderStateExtractor`: the night vision effect's intensity
    // (`GameRenderer.nightVisionScale`), or conduit power's water vision.
    // rust: pub(super) fn night_vision_intensity(&self, partial: f32) -> f32 {
//         use horizon_client::fog::FogType;
    // rust: if let Some(e) = self.potions.effects.get("night_vision") {
            // MobEffectInstance.endsWithin(200); -1 is infinite.
    // rust: return if e.duration < 0 || e.duration > 200 {
    // rust: 1.0
    // rust: } else {
    // rust: 0.7 + ((e.duration as f32 - partial) * std::f32::consts::PI * 0.2).sin() * 0.3
}
}
    // rust: if self.potions.effects.get("conduit_power").is_some()
    // rust: && let Some(eye) = self.eye_position()
    // rust: {
    // rust: let in_water = horizon_client::fog::fog_type(
    // rust: &self.world,
    // rust: self.res.facts(),
    // rust: eye,
    // rust: &self.near_plane(),
    // rust: ) == FogType::Water;
    // rust: return self.fog.water_vision(in_water);
}
    // rust: 0.0
}

    // `Warden.applyDarknessAround` / `MobEffectUtil.addEffectToPlayersAround`.
    // rust: pub(super) fn apply_darkness(&mut self, at: [f64; 3], radius: f64) {
    // rust: self.for_each_player(|g| g.darkness_on_player(at, radius));
}
darkness_on_player :: proc(self: ^Self, at: [f64; 3], radius: f64) {
}
    // rust: if self.creative || self.spectator() {
    // rust: return;
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let d = [
    // rust: p.position.x - at[0],
    // rust: p.position.y - at[1],
    // rust: p.position.z - at[2],
    // rust: ];
    // rust: if d[0] * d[0] + d[1] * d[1] + d[2] * d[2] >= radius * radius {
    // rust: return;
}
    // rust: if let Some(active) = self.potions.effects.get("darkness")
    // rust: && active.duration > warden::DARKNESS_REAPPLY - 1
    // rust: {
    // rust: return;
}
    // rust: let mut effect =
    // rust: horizon_client::effects::EffectInstance::new("darkness", warden::DARKNESS_DURATION, 0);
    // rust: effect.visible = false;
    // rust: self.potions.effects.add(effect);
}

    // ---- catalysts ----

    // `SculkCatalystBlockEntity.CatalystListener.handleGameEvent` for the
    // death of a mob: the nearest catalyst within 8 blocks takes its
    // experience. Returns whether it was consumed.
    // rust: pub(super) fn catalyst_takes_experience(
    // rust: &mut self,
    // rust: at: [f64; 3],
    // rust: experience: impl FnOnce(&mut Self) -> u32,
    // rust: ) -> bool {
        // GameEventDispatcher: catalysts are BY_DISTANCE listeners, handled
        // nearest first (exact distance to the block centre); a tie keeps the
        // order they were visited in: chunk x, chunk z, section y, then the
        // order they registered in. The first one takes the experience.
    // rust: let source = block_of(at);
    // rust: let mut candidates: Vec<(f64, (i32, i32, i32), usize, (i32, i32, i32))> = Vec::new();
    // rust: for (order, key) in self.sculk.index.iter().copied().enumerate() {
    // rust: if dist_sqr(source, key) > 64 {
    // rust: continue;
}
    // rust: let is_catalyst = matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Sculk(e)) if e.kind == SculkKind::Catalyst
    // rust: );
    // rust: if is_catalyst {
    // rust: let c = center(key);
    // rust: let d = (at[0] - c[0]).powi(2) + (at[1] - c[1]).powi(2) + (at[2] - c[2]).powi(2);
    // rust: candidates.push((d, (key.0 >> 4, key.2 >> 4, key.1 >> 4), order, key));
}
}
    // rust: candidates.sort_by(|a, b| a.0.total_cmp(&b.0).then(a.1.cmp(&b.1)).then(a.2.cmp(&b.2)));
    // rust: let nearest = candidates.first().map(|c| (c.3, ()));
    // rust: let Some((key, _)) = nearest else {
    // rust: return false;
}
    // rust: let xp = experience(self);
    // rust: if xp > 0 {
            // sourcePosition.relative(UP, 0.5)
    // rust: let start = BlockPos::new(source[0], (at[1] + 0.5).floor() as i32, source[2]);
    // rust: if let Some(e) = self.sculk_entity(key) {
    // rust: e.spreader.add_cursors(start, xp as i32);
}
}
    // rust: self.catalyst_bloom(key);
    // rust: true
}
catalyst_bloom :: proc(self: ^Self, key: (i32) {
}
    // rust: let pos = BlockPos::new(key.0, key.1, key.2);
    // rust: self.with_level(|b, level, ticks| b.sculk_catalyst_bloom(level, ticks, pos));
    // rust: self.native_sculk_bloom(self.dim.id(), [key.0, key.1, key.2]);
    // rust: let _ = self.process_level_events();
    // rust: let c = center(key);
    // rust: let options = ParticleOptions::simple(ParticleType::SculkSoul);
    // rust: for _ in 0..2 {
            // Client-side (LevelEventHandler / particles): the client random.
    // rust: let r = self.particles.random();
    // rust: let p = [
    // rust: c[0] + r.next_gaussian() * 0.2,
    // rust: c[1] + 0.65,
    // rust: c[2] + r.next_gaussian() * 0.2,
    // rust: ];
    // rust: self.particles.add(&options, p, [0.0; 3]);
}
    // rust: let pitch = 0.6 + self.world.random.next_float() * 0.4;
    // rust: self.audio
    // rust: .play("minecraft:block.sculk_catalyst.bloom", Some(c), 2.0, pitch);
}

    // ---- particles ----

    // `LevelEvent` 3006: charge cursors moving over sculk, or popping.
    // rust: pub(super) fn sculk_charge_event(&mut self, pos: BlockPos, data: i32) {
    // rust: let c = center((pos.x, pos.y, pos.z));
    // rust: let count = data >> 6;
    // rust: if count > 0 {
            // Client-side (LevelEventHandler / particles): the client random.
    // rust: let r = self.particles.random();
    // rust: if r.next_float() < 0.3 + count as f32 * 0.1 {
    // rust: let volume = 0.15 + 0.02 * (count * count) as f32 * r.next_float();
    // rust: let pitch = 0.4 + 0.3 * count as f32 * r.next_float();
    // rust: self.audio
    // rust: .play("minecraft:block.sculk.charge", Some(c), volume, pitch);
}
    // rust: let face_data = data & 63;
    // rust: let faces: Vec<(Direction, f32, f64)> = if face_data == 0 {
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .map(|d| {
    // rust: let roll = if d == Direction::Down {
    // rust: std::f32::consts::PI
    // rust: } else {
    // rust: 0.0
}
    // rust: let factor = if matches!(d, Direction::Up | Direction::Down) {
    // rust: 0.65
    // rust: } else {
    // rust: 0.57
}
    // rust: (d, roll, factor)
    // rust: })
    // rust: .collect()
    // rust: } else {
    // rust: horizon_world::level::sculk::unpack_faces(face_data)
    // rust: .into_iter()
    // rust: .map(|d| {
    // rust: let roll = if d == Direction::Up {
    // rust: std::f32::consts::PI
    // rust: } else {
    // rust: 0.0
}
    // rust: (d, roll, 0.35)
    // rust: })
    // rust: .collect()
}
    // rust: for (direction, roll, factor) in faces {
    // rust: let repetitions = self
    // rust: .particles
    // rust: .random()
    // rust: .next_int_bound(count + 1)
    // rust: .unwrap_or(0);
    // rust: for _ in 0..repetitions {
    // rust: self.spawn_particle_on_face(pos, direction, roll, factor);
}
}
    // rust: } else {
    // rust: self.audio
    // rust: .play("minecraft:block.sculk.charge", Some(c), 1.0, 1.0);
    // rust: let solid = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos.x, pos.y, pos.z))
    // rust: .full_collision;
    // rust: let (particles, spread) = if solid { (40, 0.45f32) } else { (20, 0.25f32) };
    // rust: let options = ParticleOptions::simple(ParticleType::SculkChargePop);
    // rust: for _ in 0..particles {
                // Client-side (LevelEventHandler / particles): the client random.
    // rust: let r = self.particles.random();
    // rust: let v = [
    // rust: 2.0 * r.next_float() - 1.0,
    // rust: 2.0 * r.next_float() - 1.0,
    // rust: 2.0 * r.next_float() - 1.0,
    // rust: ];
    // rust: let at = [
    // rust: c[0] + f64::from(v[0] * spread),
    // rust: c[1] + f64::from(v[1] * spread),
    // rust: c[2] + f64::from(v[2] * spread),
    // rust: ];
    // rust: let speed = [
    // rust: f64::from(v[0] * 0.07),
    // rust: f64::from(v[1] * 0.07),
    // rust: f64::from(v[2] * 0.07),
    // rust: ];
    // rust: self.particles.add(&options, at, speed);
}
}
}
    // `ParticleUtils.spawnParticleOnFace` for a sculk charge.
spawn_particle_on_face :: proc(self: ^Self, pos: BlockPos, face: Direction, roll: f32, factor: f64) {
}
    // rust: let c = center((pos.x, pos.y, pos.z));
    // rust: let step = face.normal();
        // Client-side (LevelEventHandler / particles): the client random.
    // rust: let r = self.particles.random();
    // rust: let mut jitter = || r.next_double() - 0.5;
    // rust: let mut at = [0.0; 3];
    // rust: for i in 0..3 {
    // rust: at[i] = c[i]
    // rust: + if step[i] == 0 {
    // rust: jitter()
    // rust: } else {
    // rust: f64::from(step[i]) * factor
}
}
    // rust: let mut speed = [0.0; 3];
    // rust: for i in 0..3 {
    // rust: let s = (r.next_double() * 2.0 - 1.0) * f64::from(0.005f32);
    // rust: speed[i] = if step[i] == 0 { s } else { 0.0 };
}
    // rust: self.particles
    // rust: .add(&ParticleOptions::sculk_charge(roll), at, speed);
}
    // `LevelEvent` 3007: ten shrieks rising from the shrieker, and the shriek.
    // rust: pub(super) fn shriek_event(&mut self, pos: BlockPos) {
    // rust: let top = f64::from(pos.y) + 0.5;
    // rust: for i in 0..10 {
    // rust: self.particles.add(
    // rust: &ParticleOptions::shriek(i * 5),
    // rust: [f64::from(pos.x) + 0.5, top, f64::from(pos.z) + 0.5],
    // rust: [0.0; 3],
    // rust: );
}
    // rust: let state = self.world.block(pos.x, pos.y, pos.z);
    // rust: if self.state_property(state, "waterlogged") != Some("true") {
    // rust: let pitch = 0.6 + self.particles.random().next_float() * 0.4;
    // rust: self.audio.play(
    // rust: "minecraft:block.sculk_shrieker.shriek",
    // rust: Some([f64::from(pos.x) + 0.5, top, f64::from(pos.z) + 0.5]),
    // rust: 2.0,
    // rust: pitch,
    // rust: );
}
}

    // `ServerLevel.sendParticles(new VibrationParticleOption(...), origin,
    // 1, 0, 0, 0, 0)` from `VibrationSystem.Ticker.trySelectAndScheduleVibration`:
    // the window draws it when it is a client, and every player within 32
    // blocks is sent it.
    // rust: fn vibration_particle(
    // rust: &mut self,
    // rust: source: PositionSource,
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: ticks: i32,
    // rust: ) {
    // rust: let options = ParticleOptions::vibration(source, to, ticks);
    // rust: if self.options.execution_role.is_client() {
    // rust: self.particles.vibration(from, to, ticks);
}
    // rust: self.lan_send_particles(super::lan_particles::QueuedParticle {
    // rust: dimension: self.dim.id(),
    // rust: options,
    // rust: state: None,
    // rust: at: from,
    // rust: spread: [0.0; 3],
    // rust: speed: [0.0; 3],
    // rust: count: 1,
    // rust: randomization: 0,
    // rust: });
}
    // A vibration travelling to a warden (`MobEvent::Vibration`).
    // rust: pub(super) fn mob_vibration_particle(
    // rust: &mut self,
    // rust: source: PositionSource,
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: ticks: i32,
    // rust: ) {
    // rust: self.vibration_particle(source, from, to, ticks);
}
    // `Warden.clientDiggingParticles`: thirty crumbs of the block underfoot.
    // rust: pub(super) fn warden_dig_particles(&mut self, at: [f64; 3]) {
    // rust: let below = (
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 0.2).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: let state = self.world.block(below.0, below.1, below.2);
    // rust: let Some((sprite, tint)) = self.particle_sprite(state, [below.0, below.1, below.2]) else {
    // rust: return;
}
    // rust: for _ in 0..30 {
            // Client-side (LevelEventHandler / particles): the client random.
    // rust: let r = self.particles.random();
    // rust: let off = |v: f32| f64::from(v * 1.4 - 0.7);
    // rust: let p = [
    // rust: at[0] + off(r.next_float()),
    // rust: at[1],
    // rust: at[2] + off(r.next_float()),
    // rust: ];
    // rust: let particle =
    // rust: horizon_client::particles::Particle::terrain(r, p, [0.0; 3], sprite.clone(), tint);
    // rust: self.particles.push(particle);
}
}

    // ---- entity events ----

    // `Projectile.shoot` / `onHit`: a projectile of `owner` at a position.
    // rust: pub(super) fn projectile_event(
    // rust: &mut self,
    // rust: event: &'static str,
    // rust: owner: Option<Who>,
    // rust: at: [f64; 3],
    // rust: ) {
    // rust: let mut ctx = Context::default();
    // rust: if event == "minecraft:projectile_shoot" {
            // The shooter is the source of the shot.
    // rust: ctx = self.who_context(owner, None);
    // rust: } else {
    // rust: ctx.owner = owner;
    // rust: ctx.player = owner == Some(Who::Player) || self.rides_player(owner);
}
    // rust: self.post_game_event(event, at, ctx);
}
    // The player shot or threw something.
    // rust: pub(super) fn player_projectile_shot(&mut self) {
    // rust: if let Some(p) = self.player.as_ref() {
    // rust: let at = [
    // rust: p.position.x,
    // rust: p.position.y + f64::from(self.eye),
    // rust: p.position.z,
    // rust: ];
    // rust: self.projectile_event("minecraft:projectile_shoot", Some(Who::Player), at);
}
}

    // Events from entities moving, getting hurt and dying, derived from what
    // changed this tick.
tick_entity_events :: proc(self: ^Self) {
}
    // rust: self.tick_player_sculk_events();
    // rust: self.tick_mob_sculk_events();
    // rust: if !self.sculk.falling_items.is_empty() {
    // rust: let present: HashSet<u32> = self.dropped.iter().map(|item| item.id).collect();
    // rust: self.sculk.falling_items.retain(|id| present.contains(id));
}
        // Dropped items are entities too: Entity.applyEffectsFromBlocks, from
        // ItemEntity.tick, so only for the items in entity-ticking chunks.
    // rust: let ticking = self.entity_ticking_area();
    // rust: let items: Vec<[f64; 3]> = self
    // rust: .dropped
    // rust: .iter()
    // rust: .filter(|i| {
    // rust: i.on_ground && ticking(i.position.x.floor() as i32, i.position.z.floor() as i32)
    // rust: })
    // rust: .map(|i| [i.position.x, i.position.y, i.position.z])
    // rust: .collect();
    // rust: for at in items {
    // rust: self.step_on_redstone_ore(at, false, false);
}
}

    // `Entity.checkFallDamage` for item movement: retain a fall across an
    // exact-height contact, without changing the saved fall-distance getter.
    // rust: pub(super) fn item_landing_event(
    // rust: &mut self,
    // rust: id: u32,
    // rust: previous: Vec3,
    // rust: position: Vec3,
    // rust: on_ground: bool,
    // rust: ) {
    // rust: let at = [position.x, position.y, position.z];
    // rust: if self.in_water_at(at) {
    // rust: self.sculk.falling_items.remove(&id);
    // rust: return;
}
    // rust: if position.y < previous.y {
    // rust: self.sculk.falling_items.insert(id);
}
    // rust: if on_ground && self.sculk.falling_items.remove(&id) {
            // EntityType.ITEM: 0.25 by 0.25.
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(position.x - 0.125, position.y, position.z - 0.125),
    // rust: Vec3::new(position.x + 0.125, position.y + 0.25, position.z + 0.125),
    // rust: );
    // rust: self.post_landing_event(position, bounds, false);
}
}

    // `Entity.checkFallDamage` emits HIT_GROUND after the block's fallOn.
    // rust: pub(super) fn post_landing_event(&mut self, position: Vec3, bounds: Aabb, living: bool) {
    // rust: if self.remote.is_some() || self.options.execution_role.is_client() {
    // rust: return;
}
    // rust: self.sculk_prepare();
        // mainSupportingBlockPos, or the block's state at getOnPosLegacy.
    // rust: let state = match self.supporting_block(position, bounds) {
    // rust: Some(support) => self.world.block(support.x, support.y, support.z),
    // rust: None => self.world.block(
    // rust: position.x.floor() as i32,
    // rust: (position.y - 0.2).floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ),
}
    // rust: let mut context = self.who_context(None, Some(state));
    // rust: context.living = living;
    // rust: self.post_game_event(
    // rust: "minecraft:hit_ground",
    // rust: [position.x, position.y, position.z],
    // rust: context,
    // rust: );
}

    // Entity.move emits on the authoritative server too, for each ServerPlayer.
    // rust: pub(super) fn tick_player_sculk_events(&mut self) {
        // The player.
    // rust: let player = self.player.as_ref().map(|p| {
    // rust: (
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: p.ground.on_ground,
    // rust: p.health.health(),
    // rust: p.flying,
    // rust: )
    // rust: });
    // rust: if let Some((at, on_ground, health, flying)) = player {
    // rust: let crouch = self.keys.held(Action::Sneak);
    // rust: if on_ground && !self.spectator() {
    // rust: self.step_on_redstone_ore(at, crouch, true);
}
    // rust: self.mount_events(Who::Player, self.riding, true);
    // rust: let in_water = self.in_water_at(at);
    // rust: self.entity_motion_events(
    // rust: Who::Player,
    // rust: at,
    // rust: on_ground,
    // rust: in_water,
    // rust: crouch && on_ground,
    // rust: flying,
    // rust: false,
    // rust: );
    // rust: if let Some(last) = self.sculk.last_health
    // rust: && health < last
    // rust: {
    // rust: self.post_entity_event("minecraft:entity_damage", Who::Player);
}
    // rust: self.sculk.last_health = Some(health);
}
}

    // `RedStoneOreBlock.spawnParticles`: a red dust puff for each face of the
    // ore that is not against a solid block. Non-axis coordinates draw from
    // the client level random, x then y then z. It is `level.addParticle`, so
    // only the local player's own click or step draws it, not a guest's turn.
    // rust: pub(super) fn redstone_ore_particles(&mut self, pos: [i32; 3]) {
    // rust: if self.lan_acting.is_some()
    // rust: || !matches!(
    // rust: &*self.block_name(pos),
    // rust: "minecraft:redstone_ore" | "minecraft:deepslate_redstone_ore"
    // rust: )
    // rust: {
    // rust: return;
}
        // Direction.values(): down, up, north, south, west, east.
    // rust: const FACES: [[i32; 3]; 6] = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ];
    // rust: for step in FACES {
    // rust: let next = [pos[0] + step[0], pos[1] + step[1], pos[2] + step[2]];
    // rust: let state = self.world.block(next[0], next[1], next[2]);
    // rust: if self.res.facts().get(state).solid_render {
    // rust: continue;
}
    // rust: let mut at = [0.0f64; 3];
    // rust: for axis in 0..3 {
    // rust: at[axis] = if step[axis] != 0 {
    // rust: 0.5 + 0.5625 * f64::from(step[axis])
    // rust: } else {
    // rust: f64::from(self.particles.level_random().next_float())
}
}
    // rust: self.particles.add(
    // rust: &horizon_client::particles::ParticleOptions::dust([1.0, 0.0, 0.0], 1.0),
    // rust: [
    // rust: f64::from(pos[0]) + at[0],
    // rust: f64::from(pos[1]) + at[1],
    // rust: f64::from(pos[2]) + at[2],
    // rust: ],
    // rust: [0.0; 3],
    // rust: );
}
}

    // `RedStoneOreBlock.stepOn`: standing on the ore lights it, unless the
    // entity is stepping carefully (`attack_block` only lights an unlit ore).
step_on_redstone_ore :: proc(self: ^Self, at: [f64; 3], carefully: bool, burst: bool) {
}
    // rust: if carefully {
    // rust: return;
}
        // getOnPosLegacy: 0.2 below the feet.
    // rust: let pos = [
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 0.2).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: self.sculk_prepare();
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if self.state_is(&self.sculk.tables.redstone_ore, state) {
            // The dust is the local player's client effect, not a mob's or an item's.
    // rust: if burst {
    // rust: self.redstone_ore_particles(pos);
}
    // rust: let _ = self.attack_block(pos);
}
}

    // `RedStoneOreBlock.useItemOn`: a right-click lights the ore whatever the
    // hand holds. False (PASS) when the hand holds a block item, which goes on
    // to be placed; true (SUCCESS) otherwise.
    // rust: pub(super) fn use_redstone_ore(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: held: Option<&horizon_client::items::ItemStack>,
    // rust: ) -> Result<bool> {
    // rust: if !matches!(
    // rust: &*self.block_name(pos),
    // rust: "minecraft:redstone_ore" | "minecraft:deepslate_redstone_ore"
    // rust: ) {
    // rust: return Ok(false);
}
    // rust: self.redstone_ore_particles(pos);
    // rust: self.attack_block(pos)?;
    // rust: let block_item = held.is_some_and(|s| {
    // rust: self.res
    // rust: .items()
    // rust: .get(&s.item)
    // rust: .is_some_and(|i| i.block.is_some())
    // rust: });
    // rust: Ok(!block_item)
}

tick_mob_sculk_events :: proc(self: ^Self) {
}
    // rust: let snapshot: Vec<(
    // rust: u32,
    // rust: [f64; 3],
    // rust: bool,
    // rust: bool,
    // rust: Species,
    // rust: Option<i64>,
    // rust: Option<u32>,
    // rust: u32,
    // rust: bool,
    // rust: )> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .map(|m| {
    // rust: (
    // rust: m.id,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: m.on_ground,
    // rust: m.fluids.in_water,
    // rust: m.species(),
    // rust: m.last_damage.map(|(_, t)| t),
    // rust: m.extra.mount,
    // rust: m.age,
    // rust: m.species() == Species::Bat && horizon_client::mobs::bat::resting(m),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let mut by_id = FxHashMap::default();
    // rust: for (i, m) in self.mobs.iter().enumerate() {
    // rust: by_id.entry(m.id).or_insert(i);
}
    // rust: let listeners = self
    // rust: .mobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, m)| matches!(m.species(), Species::Warden | Species::Allay))
    // rust: .map(|(i, m)| (i, m.id, [m.position.x, m.position.y, m.position.z]))
    // rust: .collect();
    // rust: self.sculk.mob_slots = Some(MobSlots {
    // rust: by_id,
    // rust: listeners,
    // rust: next_entity: self.next_entity,
    // rust: });
        // Steps, landings, splashes, flaps and stepping on redstone ore come
        // from the mob's own tick (Entity.move, LivingEntity.aiStep's
        // applyEffectsFromBlocks), which ServerLevel.tick runs only in
        // entity-ticking chunks: for the mobs `tick_creature_entities` ticked,
        // and those standing in that area (the sculk fixture posts before the
        // mobs tick). Damage and mounting are raised by `hurt` and
        // `startRiding`, ticking or not.
    // rust: let ticking = self.entity_ticking_area();
    // rust: for (id, at, on_ground, in_water, species, damaged, vehicle, age, resting) in snapshot {
    // rust: let ticked = self.creatures.ticked.contains(&id)
    // rust: || ticking(at[0].floor() as i32, at[2].floor() as i32);
    // rust: if on_ground && ticked {
    // rust: self.step_on_redstone_ore(at, false, false);
}
            // A mob first seen already riding raised its event when it spawned.
    // rust: let seen = self.sculk.steps.contains_key(&Who::Mob(id));
    // rust: self.mount_events(Who::Mob(id), vehicle, seen);
    // rust: let emits = !matches!(species, Species::Shulker);
    // rust: if emits && !ticked {
                // Where it is now, without a move: a mob put elsewhere while
                // it did not tick (a command) walked nowhere.
    // rust: let entry = self.sculk.steps.entry(Who::Mob(id)).or_insert(Steps {
    // rust: move_dist: 0.0,
    // rust: next_step: 1.0,
    // rust: last: at,
    // rust: on_ground,
    // rust: in_water,
    // rust: });
    // rust: entry.last = at;
    // rust: entry.on_ground = on_ground;
    // rust: entry.in_water = in_water;
    // rust: } else if emits {
    // rust: let warden = species == Species::Warden;
    // rust: self.entity_motion_events(
    // rust: Who::Mob(id),
    // rust: at,
    // rust: on_ground,
    // rust: in_water,
    // rust: false,
    // rust: false,
    // rust: warden,
    // rust: );
                // Entity.processFlappingMovement: what flaps this move flaps
                // over air only (the mob's own `MobEvent::GameEvent` is not
                // read here).
    // rust: if flaps(species, resting, on_ground, age) {
    // rust: let below = self.world.block(
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 1.0e-5).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: if self.res.facts().is_air(below) {
    // rust: self.post_entity_event("minecraft:flap", Who::Mob(id));
}
}
}
    // rust: if let Some(t) = damaged
    // rust: && self.sculk.damaged.get(&id) != Some(&t)
    // rust: {
    // rust: self.sculk.damaged.insert(id, t);
    // rust: self.post_entity_event("minecraft:entity_damage", Who::Mob(id));
}
}
    // rust: self.sculk.mob_slots = None;
    // rust: let alive: FxHashSet<u32> = self.mobs.iter().map(|m| m.id).collect();
    // rust: self.sculk.damaged.retain(|id, _| alive.contains(id));
    // rust: self.sculk.steps.retain(|who, _| match who {
    // rust: Who::Player => true,
    // rust: Who::Mob(id) => alive.contains(id),
    // rust: });
    // rust: self.sculk.mounts.retain(|who, _| match who {
    // rust: Who::Player => true,
    // rust: Who::Mob(id) => alive.contains(id),
    // rust: });
}
    // Where the vehicle `id` stands: a mob, boat, minecart or cushion.
vehicle_position :: proc(self: ^Self, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let p = if let Some(m) = self.mob_by_id(id) {
    // rust: m.position
    // rust: } else if let Some(b) = self.boats.iter().find(|b| b.id == id) {
    // rust: b.position
    // rust: } else if let Some(c) = self.carts.iter().find(|c| c.id == id) {
    // rust: c.position
    // rust: } else {
    // rust: self.cushions.iter().find(|c| c.id == id)?.position
}
    // rust: Some([p.x, p.y, p.z])
}
    // `Entity.startRiding` and `removeVehicle`: `entity_mount` at the new
    // vehicle and `entity_dismount` at the old one, derived from the vehicle
    // the rider has now and the one it had last tick. `announce` is false
    // for a rider first seen riding.
mount_events :: proc(self: ^Self, who: Who, vehicle: Maybe(u32), announce: bool) {
}
    // rust: let last = self.sculk.mounts.get(&who).copied();
        // Riding nothing, as last tick: nothing to tell or keep.
    // rust: if vehicle.is_none() && last.is_none() {
    // rust: return;
}
    // rust: let now = vehicle.and_then(|id| self.vehicle_position(id));
    // rust: if last.map(|l| l.0) != vehicle {
    // rust: if let Some((_, at)) = last {
    // rust: let ctx = self.who_context(Some(who), None);
    // rust: self.post_game_event("minecraft:entity_dismount", at, ctx);
}
    // rust: if let (true, Some(at)) = (announce, now) {
    // rust: let ctx = self.who_context(Some(who), None);
    // rust: self.post_game_event("minecraft:entity_mount", at, ctx);
}
}
        // A vehicle that is gone keeps the spot it was last seen at.
    // rust: let kept = last.filter(|l| Some(l.0) == vehicle).map(|l| l.1);
    // rust: match (vehicle, now.or(kept)) {
    // rust: (Some(id), Some(at)) => {
    // rust: self.sculk.mounts.insert(who, (id, at));
}
    // rust: _ => {
    // rust: self.sculk.mounts.remove(&who);
}
}
}
in_water_at :: proc(self: ^Self, at: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (x, y, z) = (
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: self.res.facts().get(self.world.block(x, y, z)).fluid
    // rust: == horizon_client::blocks::Fluid::Water
}
    // `Entity.checkSupportingBlock`: the block under this box closest to the
    // entity. Everything but the player works it out when it asks.
supporting_block :: proc(self: ^Self, position: Vec3, bounds: Aabb) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (min, max) = (bounds.min_position(), bounds.max_position());
    // rust: let foot = Aabb::new(
    // rust: Vec3::new(min.x, min.y - 1.0e-6, min.z),
    // rust: Vec3::new(max.x, min.y, max.z),
    // rust: );
    // rust: let mut scene = horizon_client::collisions::SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: horizon_world::ground_support::find_supporting_block(
    // rust: &mut scene,
    // rust: horizon_world::collision_context::CollisionContext::position(position.y),
    // rust: position,
    // rust: foot,
    // rust: 1_000_000,
    // rust: )
    // rust: .ok()
    // rust: .flatten()
}
    // `Entity.mainSupportingBlockPos` of a player or mob on the ground.
main_support :: proc(self: ^Self, who: Who) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match who {
    // rust: Who::Player => self.player.as_ref()?.ground.supporting_block,
    // rust: Who::Mob(id) => {
    // rust: let mob = self.mob_by_id(id)?;
    // rust: self.supporting_block(mob.position, mob.bounds())
}
}
}
    // `Entity.move`'s emission: footsteps, swimming, landing and splashes.
    // rust: fn entity_motion_events(
    // rust: &mut self,
    // rust: who: Who,
    // rust: at: [f64; 3],
    // rust: on_ground: bool,
    // rust: in_water: bool,
    // rust: discrete: bool,
    // rust: flying: bool,
    // rust: warden: bool,
    // rust: ) {
    // rust: self.sculk_prepare();
        // Standing as it stood with no step due (a mob outside the simulation
        // distance, or one at rest): nothing below would change or be heard.
    // rust: if let Some(e) = self.sculk.steps.get(&who)
    // rust: && e.last == at
    // rust: && e.on_ground == on_ground
    // rust: && e.in_water == in_water
    // rust: && e.move_dist <= e.next_step
    // rust: {
    // rust: return;
}
    // rust: let entry = self.sculk.steps.entry(who).or_insert(Steps {
    // rust: move_dist: 0.0,
    // rust: next_step: 1.0,
    // rust: last: at,
    // rust: on_ground,
    // rust: in_water,
    // rust: });
    // rust: let previous = *entry;
    // rust: entry.last = at;
    // rust: entry.on_ground = on_ground;
    // rust: entry.in_water = in_water;
    // rust: let (dx, dy, dz) = (
    // rust: at[0] - previous.last[0],
    // rust: at[1] - previous.last[1],
    // rust: at[2] - previous.last[2],
    // rust: );
        // Entity.checkFallDamage: touching down after falling, with the state
        // of mainSupportingBlockPos (the block's state at getOnPosLegacy without one).
    // rust: if on_ground && (!previous.on_ground || dy < -1.0e-6) && dy < 0.0 && !in_water {
    // rust: let state = match self.main_support(who) {
    // rust: Some(support) => self.world.block(support.x, support.y, support.z),
    // rust: None => self.world.block(
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 0.2).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ),
}
    // rust: self.post_game_event_with("minecraft:hit_ground", at, |g| {
    // rust: g.who_context(Some(who), Some(state))
    // rust: });
}
        // Entity.updateInWaterStateAndDoFluidPushing: entering water splashes.
    // rust: if in_water && !previous.in_water {
    // rust: self.post_entity_event("minecraft:splash", who);
}
        // Player.getMovementEmission.
    // rust: if flying || discrete {
    // rust: return;
}
    // rust: let horizontal = ((dx * dx + dz * dz).sqrt() * f64::from(0.6f32)) as f32;
        // Entity.getOnPos without a supporting block. Finding a mob's support
        // waits for a step that is due: this runs for every mob on every tick.
    // rust: let unsupported = self.world.block(
    // rust: at[0].floor() as i32,
    // rust: (at[1] - 1.0e-5).floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: let climbable = self.state_is(&self.sculk.tables.climbable, unsupported);
    // rust: let travelled = if climbable {
    // rust: ((dx * dx + dy * dy + dz * dz).sqrt() * f64::from(0.6f32)) as f32
    // rust: } else {
    // rust: horizontal
}
    // rust: let Some(entry) = self.sculk.steps.get_mut(&who) else {
    // rust: return;
}
    // rust: entry.move_dist += travelled;
    // rust: let move_dist = entry.move_dist;
    // rust: if move_dist <= entry.next_step {
    // rust: return;
}
        // Entity.applyMovementEmissionAndPlaySound: the state at getOnPos, so a
        // carpet and not the block under it.
    // rust: let state = match on_ground.then(|| self.main_support(who)).flatten() {
    // rust: Some(support) => self.world.block(support.x, support.y, support.z),
    // rust: None => unsupported,
}
    // rust: let air = self.res.facts().is_air(state);
    // rust: let Some(entry) = self.sculk.steps.get_mut(&who) else {
    // rust: return;
}
    // rust: if !air {
    // rust: let steps_on_block = on_ground || climbable;
    // rust: if steps_on_block {
    // rust: entry.next_step = if warden {
                    // Warden.nextStep
    // rust: move_dist + 0.55
    // rust: } else {
    // rust: (move_dist as i32).wrapping_add(1) as f32
}
    // rust: self.post_game_event_with("minecraft:step", at, |g| {
    // rust: g.who_context(Some(who), Some(state))
    // rust: });
    // rust: } else if in_water {
    // rust: entry.next_step = (move_dist as i32).wrapping_add(1) as f32;
    // rust: self.post_entity_event("minecraft:swim", who);
}
}
}
    // `LivingEntity.die` with the catalyst's reach: a death event at the
    // mob's position.
    // rust: pub(super) fn sculk_mob_died(&mut self, m: &Mob) {
    // rust: let ctx = self.context_of_mob(Some(m), m.id, None);
    // rust: self.post_game_event(
    // rust: "minecraft:entity_die",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: ctx,
    // rust: );
}
}

// `MobEffects.DARKNESS`'s `setBlendDuration(22)`: its fade in, its fade out,
// and how long before the end the fade out starts.
DARKNESS_BLEND :: 22

// `MobEffectInstance.BlendState.hasEffect` for the darkness effect.
darkness_target :: proc(e: ^EffectInstance) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if e.ends_within(DARKNESS_BLEND) {
    // rust: 0.0
    // rust: } else {
    // rust: 1.0
}
}

// `MobEffectInstance.BlendState.tick` for the darkness effect: from the
// (previous, current) factors, the next ones. It fades in and out over 22
// ticks; with no darkness it is gone.
    // rust: pub(super) fn darkness_blend_tick(effects: &PlayerEffects, (_, current): (f32, f32)) -> (f32, f32) {
    // rust: let next = match effects.get("darkness") {
    // rust: Some(e) => {
    // rust: let step = 1.0 / DARKNESS_BLEND as f32;
    // rust: current + (darkness_target(e) - current).clamp(-step, step)
}
    // rust: None => 0.0,
}
    // rust: (current, next)
}

// A new darkness instance's `BlendState`: from nothing, or, when the server
// asked for no blending, at once (`MobEffectInstance.skipBlending`'s
// `BlendState.setImmediate`).
    // rust: pub(super) fn darkness_blend_added(e: &EffectInstance, blend: bool) -> (f32, f32) {
    // rust: let factor = if blend { 0.0 } else { darkness_target(e) };
    // rust: (factor, factor)
}

// `Bee.isFlapping` (flying, every other tick) and `Bat.isFlapping`
// (awake, every tenth tick). Bird distance thresholds run in mob movement.
flaps :: proc(species: Species, resting: bool, on_ground: bool, age: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match species {
    // rust: Species::Bee => !on_ground && age.is_multiple_of(2),
    // rust: Species::Bat => !resting && age.is_multiple_of(10),
    // rust: _ => false,
}
}

    // rust: mod tests {
//     use super::*;

    // Retaining keeps the insertion order and the membership in step.
the_index_retains_in_order :: proc() {
}
    // rust: let mut index = Index::default();
    // rust: for key in [(5, 0, 0), (40, 1, 0), (6, 2, 17), (-3, 3, 0), (41, 4, 0)] {
    // rust: index.insert(key);
}
    // rust: index.retain(|p| p.0 >> 4 != 2 && p.2 >> 4 != 1);
    // rust: assert_eq!(index.order, [(5, 0, 0), (-3, 3, 0)]);
    // rust: assert!(index.contains(&(5, 0, 0)) && !index.contains(&(41, 4, 0)));
    // rust: assert_eq!(index.set.len(), 2);
    // rust: index.insert((41, 4, 0));
    // rust: assert_eq!(index.iter().last(), Some(&(41, 4, 0)));
}

    // The listeners near a point come out as filtering the whole index in
    // order would give them, through inserts, removals and retains.
listeners_within_a_radius_are_the_filtered_index_in_order :: proc() {
}
    // rust: let mut index = Index::default();
    // rust: let mut seed = 0x2545_f491_4f6c_dd1du64;
    // rust: let mut next = move |n: i32| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: (seed % (2 * n as u64 + 1)) as i32 - n
}
    // rust: for step in 0..3000 {
    // rust: let key = (next(70), next(40), next(70));
    // rust: match step % 7 {
    // rust: 0..=3 => index.insert(key),
    // rust: 4..=5 => {
    // rust: let picked = index
    // rust: .order
    // rust: .get(next(1000).unsigned_abs() as usize % index.order.len().max(1))
    // rust: .copied();
    // rust: if let Some(k) = picked {
    // rust: index.remove(&k);
}
}
    // rust: _ if step % 500 == 6 => index.retain(|p| (p.0 ^ p.2) & 3 != 0),
    // rust: _ => {}
}
    // rust: let at = [next(80), next(50), next(80)];
    // rust: let radius = next(16).abs();
    // rust: let expected: Vec<_> = index
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|p| dist_sqr(at, *p) <= i64::from(radius * radius))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: index.within(at, radius),
    // rust: expected,
    // rust: "step {step} at {at:?} r {radius}"
    // rust: );
}
    // rust: assert!(index.cells.values().map(Vec::len).sum::<usize>() == index.order.len());
}

    // A bat flaps every tenth tick while it is not resting, whether it is on
    // the ground or not; a resting bat never flaps and nothing else does.
a_bat_flaps_every_tenth_tick_unless_it_is_resting :: proc() {
}
    // rust: assert!(flaps(Species::Bat, false, false, 0));
    // rust: assert!(flaps(Species::Bat, false, true, 10));
    // rust: assert!(!flaps(Species::Bat, false, false, 11));
    // rust: assert!(!flaps(Species::Bat, true, false, 20), "resting");
    // rust: assert!(flaps(Species::Bee, false, false, 4));
    // rust: assert!(!flaps(Species::Bee, false, true, 4), "a bee on the ground");
    // rust: assert!(!flaps(Species::Bat, false, false, 5));
    // rust: assert!(!flaps(Species::Cow, false, false, 0));
}

centres_and_blocks_agree :: proc() {
}
    // rust: assert_eq!(center((1, 2, 3)), [1.5, 2.5, 3.5]);
    // rust: assert_eq!(block_of([1.5, 2.5, -0.5]), [1, 2, -1]);
    // rust: assert_eq!(dist_sqr([0, 0, 0], (3, 4, 0)), 25);
}
}
