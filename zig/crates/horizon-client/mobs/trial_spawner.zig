//! Transpiled from Horizon Rust crate
//! Module: horizon-client_trial_spawner
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The trial spawner (`TrialSpawner` as `TrialSpawnerBlockEntity` runs it):
//! its configs, saved state (`TrialSpawnerStateData`) and the server tick that
//! walks `TrialSpawnerState`: waiting for players, spawning its waves while
//! they fight, ejecting a reward per player, then cooling down.
//!
//! The state lives in the block (`trial_spawner_state`); the tick reads it and
//! reports the next one. The level's random drives the tick in vanilla's draw
//! order; what the spawner asks of the level goes through
//! [`TrialSpawnerLevel`], so the game and a differential test world answer the
//! same questions.
// use super::{
    // rust: spawn_rules::{self, Reason},
    // rust: spawn_selection,
    // rust: spawner::{self, SpawnData, SpawnDataExt, SpawnerLevel, SpawnerSpawn},
}
    // rust: pub use crate::chunk::block_entity::{ConfigSlot, TrialConfig, TrialSpawner};
// use horizon_core::{position::BlockPos, random::RandomSource};
// use horizon_world::nbt::{Compound, JavaString, Tag};
// use std::{collections::HashMap, path::Path, sync::OnceLock};

/// An entity's UUID as its four ints (`UUIDUtil.CODEC`).
    // rust: pub type Uuid = [i32; 4];

/// `MAX_MOB_TRACKING_DISTANCE`: a spawned mob further than this stops
/// counting as one of the spawner's.
pub const MAX_MOB_TRACKING_DISTANCE: i64 = 47;
/// `DELAY_BEFORE_EJECT_AFTER_KILLING_LAST_MOB` and `TIME_BETWEEN_EACH_EJECTION`.
pub const DELAY_BEFORE_EJECT: f32 = 40.0;
pub const TIME_BETWEEN_EJECTIONS: f32 = 30.0;
/// `TrialSpawnerConfig.ticksBetweenItemSpawners`.
pub const TICKS_BETWEEN_ITEM_SPAWNERS: i64 = 160;
/// `transformBadOmenIntoTrialOmen`: Trial Omen lasts this long per level of
/// Bad Omen.
pub const TRIAL_OMEN_TICKS_PER_LEVEL: i32 = 18000;

/// `TrialSpawnerConfig`'s codec and targets, over the data in `chunk::block_entity`.
    // rust: pub trait TrialConfigExt: Sized {
    /// `TrialSpawnerConfig.DIRECT_CODEC`; None when the tag is not a
    /// compound. Read as `TagValueInput` does, keeping the partial result:
    /// a field that fails to decode takes its default, and the list entries
    /// that fail are dropped.
pub fn decode(tag: *Tag) O;
    /// `TrialSpawnerConfig.DIRECT_CODEC`'s encoding: the fields that differ
    /// from their defaults (`optionalFieldOf` with a default).
pub fn encode(self: *Self) T;
    /// `calculateTargetTotalMobs`.
pub fn target_total_mobs(self: *Self, additional_players: i32) i;
    /// `calculateTargetSimultaneousMobs`.
pub fn target_simultaneous_mobs(self: *Self, additional_players: i32) i;
}
    // rust: impl TrialConfigExt for TrialConfig {
pub fn decode(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Tag::Compound(_) = tag else {
    // rust: return None;
}
    // rust: let d = Self::default();
    // rust: let float = |k: &str, default: f32| {
    // rust: tag.get(k)
    // rust: .and_then(float)
    // rust: .filter(|v| *v >= 0.0)
    // rust: .unwrap_or(default)
}
    // rust: let int = |k: &str, default: i32, lo: i32, hi: i32| {
    // rust: spawner::number(tag.get(k))
    // rust: .filter(|v| (i64::from(lo)..=i64::from(hi)).contains(v))
    // rust: .map_or(default, |v| v as i32)
}
    // rust: let list = |k: &str| match tag.get(k) {
    // rust: Some(Tag::List(list)) => Some(list.iter()),
    // rust: _ => None,
}
    // rust: let spawn_potentials = list("spawn_potentials").map_or_else(Vec::new, |l| {
    // rust: l.filter_map(|e| Some((SpawnData::decode(e.get("data")?)?, weight(e.get("weight"))?)))
    // rust: .collect()
    // rust: });
    // rust: let loot_tables_to_eject =
    // rust: list("loot_tables_to_eject").map_or(d.loot_tables_to_eject, |l| {
    // rust: l.filter_map(|e| Some((identifier(e.get("data"))?, weight(e.get("weight"))?)))
    // rust: .collect()
    // rust: });
    // rust: Some(Self {
    // rust: spawn_range: int("spawn_range", d.spawn_range, 1, 128),
    // rust: total_mobs: float("total_mobs", d.total_mobs),
    // rust: simultaneous_mobs: float("simultaneous_mobs", d.simultaneous_mobs),
    // rust: total_mobs_added_per_player: float(
    // rust: "total_mobs_added_per_player",
    // rust: d.total_mobs_added_per_player,
    // rust: ),
    // rust: simultaneous_mobs_added_per_player: float(
    // rust: "simultaneous_mobs_added_per_player",
    // rust: d.simultaneous_mobs_added_per_player,
    // rust: ),
    // rust: ticks_between_spawn: int("ticks_between_spawn", d.ticks_between_spawn, 0, i32::MAX),
    // rust: spawn_potentials,
    // rust: loot_tables_to_eject,
    // rust: items_to_drop_when_ominous: identifier(tag.get("items_to_drop_when_ominous"))
    // rust: .unwrap_or(d.items_to_drop_when_ominous),
    // rust: })
}
pub fn encode(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = Self::default();
    // rust: let mut out = Vec::new();
    // rust: if self.spawn_range != d.spawn_range {
    // rust: out.push(("spawn_range", Tag::Int(self.spawn_range)));
}
    // rust: for (key, value, default) in [
    // rust: ("total_mobs", self.total_mobs, d.total_mobs),
    // rust: (
    // rust: "simultaneous_mobs",
    // rust: self.simultaneous_mobs,
    // rust: d.simultaneous_mobs,
    // rust: ),
    // rust: (
    // rust: "total_mobs_added_per_player",
    // rust: self.total_mobs_added_per_player,
    // rust: d.total_mobs_added_per_player,
    // rust: ),
    // rust: (
    // rust: "simultaneous_mobs_added_per_player",
    // rust: self.simultaneous_mobs_added_per_player,
    // rust: d.simultaneous_mobs_added_per_player,
    // rust: ),
    // rust: ] {
    // rust: if value != default {
    // rust: out.push((key, Tag::Float(value.to_bits())));
}
}
    // rust: if self.ticks_between_spawn != d.ticks_between_spawn {
    // rust: out.push(("ticks_between_spawn", Tag::Int(self.ticks_between_spawn)));
}
    // rust: let weighted = |data: Tag, weight: i32| {
    // rust: Tag::compound(vec![("data", data), ("weight", Tag::Int(weight))])
}
    // rust: if !self.spawn_potentials.is_empty() {
    // rust: let list = self.spawn_potentials.iter();
    // rust: out.push((
    // rust: "spawn_potentials",
    // rust: Tag::List(list.map(|(data, w)| weighted(data.encode(), *w)).collect()),
    // rust: ));
}
    // rust: if self.loot_tables_to_eject != d.loot_tables_to_eject {
    // rust: let list = self.loot_tables_to_eject.iter();
    // rust: out.push((
    // rust: "loot_tables_to_eject",
    // rust: Tag::List(
    // rust: list.map(|(id, w)| weighted(Tag::String(id.as_str().into()), *w))
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
    // rust: if self.items_to_drop_when_ominous != d.items_to_drop_when_ominous {
    // rust: out.push((
    // rust: "items_to_drop_when_ominous",
    // rust: Tag::String(self.items_to_drop_when_ominous.as_str().into()),
    // rust: ));
}
    // rust: Tag::compound(out)
}
pub fn target_total_mobs(self: *Self, additional_players: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.total_mobs + self.total_mobs_added_per_player * additional_players as f32).floor()
    // rust: as i32
}
pub fn target_simultaneous_mobs(self: *Self, additional_players: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.simultaneous_mobs
    // rust: + self.simultaneous_mobs_added_per_player * additional_players as f32)
    // rust: .floor() as i32
}
}

pub const REGISTRY: OnceLock<std.AutoHashMap([]const u8, TrialConfig)> = OnceLock::new();

/// `Registries.TRIAL_SPAWNER_CONFIG`: the configs under the resources'
/// `data/<namespace>/trial_spawner`, read once per process.
pub fn load_registry(root: *Path) void {
}
    // rust: REGISTRY.get_or_init(|| {
    // rust: let mut out = HashMap::new();
    // rust: let Ok(namespaces) = std::fs::read_dir(root.join("data")) else {
    // rust: return out;
}
    // rust: for ns in namespaces.flatten() {
    // rust: let base = ns.path().join("trial_spawner");
    // rust: let mut stack = vec![base.clone()];
    // rust: while let Some(dir) = stack.pop() {
    // rust: for entry in std::fs::read_dir(&dir).into_iter().flatten().flatten() {
    // rust: let path = entry.path();
    // rust: if path.is_dir() {
    // rust: stack.push(path);
    // rust: continue;
}
    // rust: let (Ok(rel), Some(ns)) = (
    // rust: path.with_extension("")
    // rust: .strip_prefix(&base)
    // rust: .map(Path::to_path_buf),
    // rust: ns.file_name().to_str().map(str::to_owned),
    // rust: ) else {
    // rust: continue;
}
    // rust: let config = std::fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: .and_then(|v| TrialConfig::decode(&crate::scoreboard::json_to_tag(&v)));
    // rust: match config {
    // rust: Some(c) => {
    // rust: let id = rel.to_string_lossy().replace('\\', "/");
    // rust: out.insert(format!("{ns}:{id}"), c);
}
    // rust: None => log::warn!("Horizon: bad trial spawner config {}", path.display()),
}
}
}
}
    // rust: out
    // rust: });
}
/// A config of the registry by id.
pub fn registry_config(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: REGISTRY.get()?.get(id).cloned()
}

pub fn float(t: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match t {
    // rust: Tag::Float(b) => f32::from_bits(*b),
    // rust: Tag::Double(b) => f64::from_bits(*b) as f32,
    // rust: t => spawner::number(Some(t))? as f32,
    // rust: })
}
/// `Weighted.CODEC`'s weight: a non-negative int.
pub fn weight(t: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: spawner::number(t)
    // rust: .filter(|w| (0..=i64::from(i32::MAX)).contains(w))
    // rust: .map(|w| w as i32)
}
/// An `Identifier` (`minecraft` when the namespace is left out).
pub fn identifier(t: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match t? {
    // rust: Tag::String(s) => spawner::normalize_id(&s.to_string_lossy()),
    // rust: _ => None,
}
}

/// `TrialSpawnerState`.
pub const TrialState = enum {
    Inactive,
    WaitingForPlayers,
    Active,
    WaitingForRewardEjection,
    EjectingReward,
    Cooldown,
};
    // rust: impl TrialState {
    // rust: pub const ALL: [Self; 6] = [
    // rust: Self::Inactive,
    // rust: Self::WaitingForPlayers,
    // rust: Self::Active,
    // rust: Self::WaitingForRewardEjection,
    // rust: Self::EjectingReward,
    // rust: Self::Cooldown,
    // rust: ];
    /// The `trial_spawner_state` block property.
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Inactive => "inactive",
    // rust: Self::WaitingForPlayers => "waiting_for_players",
    // rust: Self::Active => "active",
    // rust: Self::WaitingForRewardEjection => "waiting_for_reward_ejection",
    // rust: Self::EjectingReward => "ejecting_reward",
    // rust: Self::Cooldown => "cooldown",
}
}
pub fn from_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|s| s.name() == name)
}
    /// The spin speed of the mob shown inside, None when it shows none.
pub fn spinning_mob_speed(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::WaitingForPlayers => Some(200.0),
    // rust: Self::Active => Some(1000.0),
    // rust: _ => None,
}
}
pub fn capable_of_spawning(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Self::WaitingForPlayers | Self::Active)
}
}

/// A player the spawner can detect (`PlayerDetector.NO_CREATIVE_PLAYERS`).
pub const TrialPlayer = struct {
    uuid: Uuid,
    block: [i32,
    eye: [f64,
    creative: bool,
    spectator: bool,
    /// `position()` and the box's height.
    position: [f64,
    height: f32,
    alive: bool,
    omen: ?Omen,
};

/// The effect that turns a trial spawner ominous when its player is seen.
pub const Omen = enum {
    /// `MobEffects.TRIAL_OMEN`.
    Trial,
    /// `MobEffects.BAD_OMEN`, which becomes Trial Omen.
    Bad,
};

/// What a trial spawner did that the level shows or sends.
pub const TrialEvent = enum {
    /// `markUpdated`: `sendBlockUpdated` with the new update tag.
    BlockUpdated,
    /// `levelEvent(id, pos, data)`.
    LevelEvent(i32, [i32; 3], i32),
    /// `playSound(null, spawner, sound, BLOCKS)` at volume and pitch 1.
    Sound(&'static str),
    /// `gameEvent(entity, ENTITY_PLACE, block)` for the mob just added.
    EntityPlace(Uuid, [i32; 3]),
    /// `setBlockAndUpdate` of the `ominous` property alone, even when it
    /// does not change (`removeOminous`).
    OminousSet(bool),
    /// `transformBadOmenIntoTrialOmen`: the player's Bad Omen becomes Trial
    /// Omen for [`TRIAL_OMEN_TICKS_PER_LEVEL`] per level.
    TrialOmen(Uuid),
    /// `resetAfterBecomingOminous`: the mob is discarded (after its level
    /// event 3012).
    Discard(Uuid),
    /// `playSound(null, block, sound, BLOCKS, 1, pitch)`.
    SoundAt(&'static str, [i32; 3], f32),
    /// `OminousItemSpawner.create(level, item)` added at `position`, spawning
    /// its item after `delay` ticks.
    ItemSpawner {,
    item: crate::items::ItemStack,
    position: [f64; 3],
    delay: i32,
    // rust: },
};

/// What a trial spawner reads from the level besides the spawn rules.
    // rust: pub trait TrialSpawnerLevel: SpawnerLevel {
pub fn game_time(self: *Self) i;
    /// `canSpawnInLevel`'s `spawn_mobs` game rule.
pub fn mob_spawning(self: *Self) b;
    /// `level.getPlayers()`, in the server's order.
pub fn players(self: *Self) V;
    /// The block a VISUAL clip from `from` to `to` (no fluids) first hits.
pub fn visual_hit(self: *Self, from: [f64; 3], to: [f64; 3]) O;
    /// The block position of a living entity of this dimension, if any.
pub fn entity_block(self: *Self, uuid: Uuid) O;
    /// A living entity's position and box height, if it is in this dimension.
pub fn entity_box(self: *Self, uuid: Uuid) O;
    /// The block's collision shape is empty.
pub fn no_block_collision(self: *Self, block: [i32; 3]) b;
    /// `LootTable.getRandomItems` of `table` seeded with `seed` (an empty
    /// context, stacks split).
pub fn loot_items(self: *Self, table: []const u8, seed: i64) V;
    /// `getSeed`.
pub fn seed(self: *Self) i;
}

pub fn uuids(tag: ?*Tag) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::List(list)) = tag else {
    // rust: return Vec::new();
}
    // rust: let mut out: Vec<Uuid> = Vec::new();
    // rust: for t in list {
    // rust: if let Tag::IntArray(v) = t
    // rust: && let Ok(u) = <Uuid>::try_from(v.as_slice())
    // rust: && !out.contains(&u)
    // rust: {
    // rust: out.push(u);
}
}
    // rust: out
}
pub fn encode_uuids(list: *[Uuid]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::List(list.iter().map(|u| Tag::IntArray(u.to_vec())).collect())
}

/// `TrialSpawner`'s behaviour, over the data in `chunk::block_entity`.
    // rust: pub trait TrialSpawnerExt: Sized {
    /// `TrialSpawner.load`, with the configs of [`load_registry`].
pub fn load(tag: *Tag) S;
    /// `TrialSpawner.load`. `registry` resolves a config id.
pub fn load_with(tag: *Tag, registry: *dyn Fn([]const u8) O;
    /// `TrialSpawner.store`: the state data's fields that differ from their
    /// defaults, then the configs.
pub fn save(self: *Self) V;
    /// `TrialSpawnerStateData.getUpdateTag`.
pub fn update_tag(self: *Self, state: TrialState) T;
    /// `activeConfig`.
pub fn active_config(self: *Self) *;
    /// `overrideEntityToSpawn` (a spawn egg's `setEntityId`): the data resets
    /// and both configs spawn only `id` (`withSpawning`), saved inline as
    /// `Holder.direct`. The caller then sets the state to `inactive`.
pub fn override_entity(self: *Self, id: []const u8) void;
    /// `overrideEntityToSpawn(TypedEntityData)` (an op's spawn egg with entity
    /// data, `FullConfig.overrideEntityData`): as [`Self::override_entity`],
    /// but each config's spawn data is `id` with `data` merged over it
    /// (`TypedEntityData.loadInto`).
pub fn override_entity_data(self: *Self, id: []const u8, data: *Compound) void;
    /// `resetStatistics`.
pub fn reset_statistics(self: *Self) void;
    /// `reset`.
pub fn reset(self: *Self) void;
    /// `getOrCreateNextSpawnData`: a potential at random, else empty data.
    // rust: fn next_or_create(
    // rust: &mut self,
    // rust: random: &mut impl RandomSource,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> &SpawnData;
    /// `hasMobToSpawn`.
    // rust: fn has_mob_to_spawn(
    // rust: &mut self,
    // rust: random: &mut impl RandomSource,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> bool;
    /// `canSpawnInLevel`.
    // rust: fn can_spawn_in_level<L: TrialSpawnerLevel>(l: &L) -> bool;
    /// `PlayerDetector.NO_CREATIVE_PLAYERS.detect`.
    // rust: fn detect<L: TrialSpawnerLevel>(&self, l: &L, pos: [i32; 3], line_of_sight: bool) -> Vec<Uuid>;
    /// `tryDetectPlayers`, every 20 ticks: a player seen with Trial Omen or
    /// Bad Omen turns the spawner ominous.
    // rust: fn try_detect_players<L: TrialSpawnerLevel>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: pos: [i32; 3],
    // rust: state: TrialState,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: );
    /// `applyOminous`, then `resetAfterBecomingOminous`: the spawner's mobs
    /// vanish and the ominous config starts over.
    // rust: fn apply_ominous<L: TrialSpawnerLevel>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: pos: [i32; 3],
    // rust: events: &mut Vec<TrialEvent>,
    // rust: );
    /// `TrialSpawnerState.spawnOminousOminousItemSpawner`: every tick an item
    /// is drawn; once the item spawner cooldown is over, an ominous item
    /// spawner appears above a player or one of the spawner's mobs.
    // rust: fn spawn_ominous_item_spawner<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: events: &mut Vec<TrialEvent>,
    // rust: );
    /// `calculatePositionToSpawnSpawner`: above a player in range or one of
    /// the spawner's mobs (a coin decides which), under the first block in
    /// the way, unless that spot is solid.
    // rust: fn item_spawner_position<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: ) -> Option<[f64; 3]>;
    /// `TrialSpawner.tickServer`: the next state of the block.
    // rust: fn server_tick<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: state: TrialState,
    // rust: ominous: bool,
    // rust: spawn: &mut dyn FnMut(&L, &SpawnerSpawn) -> Option<Uuid>,
    // rust: eject: &mut dyn FnMut(&str, &mut R) -> bool,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> TrialState;
    /// `TrialSpawnerState.tickAndGetNext`.
    // rust: fn tick_and_get_next<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: state: TrialState,
    // rust: spawn: &mut dyn FnMut(&L, &SpawnerSpawn) -> Option<Uuid>,
    // rust: eject: &mut dyn FnMut(&str, &mut R) -> bool,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> TrialState;
    /// `TrialSpawner.spawnMob`: the UUID of the mob added, if one was.
    // rust: fn spawn_mob<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: spawn: &mut dyn FnMut(&L, &SpawnerSpawn) -> Option<Uuid>,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> Option<Uuid>;
}
    // rust: impl TrialSpawnerExt for TrialSpawner {
pub fn load(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::load_with(tag, &registry_config)
}
pub fn load_with(tag: *Tag, registry: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let long = |k: &str| match tag.get(k) {
    // rust: Some(Tag::Long(v)) => *v,
    // rust: t => spawner::number(t).unwrap_or(0),
}
    // rust: let mut s = Self {
    // rust: detected_players: uuids(tag.get("registered_players")),
    // rust: current_mobs: uuids(tag.get("current_mobs")),
    // rust: cooldown_ends_at: long("cooldown_ends_at"),
    // rust: next_mob_spawns_at: long("next_mob_spawns_at"),
    // rust: total_mobs_spawned: spawner::number(tag.get("total_mobs_spawned"))
    // rust: .filter(|v| (0..=i64::from(i32::MAX)).contains(v))
    // rust: .map_or(0, |v| v as i32),
    // rust: next_spawn_data: tag.get("spawn_data").and_then(SpawnData::decode),
    // rust: ejecting_loot_table: identifier(tag.get("ejecting_loot_table")),
    // rust: ..Self::default()
}
        // FullConfig.MAP_CODEC, partial result kept: a field that fails to
        // decode takes its default.
    // rust: let slot = |k: &str| -> ConfigSlot {
    // rust: let config = match tag.get(k) {
    // rust: Some(Tag::String(id)) => {
    // rust: spawner::normalize_id(&id.to_string_lossy()).and_then(|id| registry(&id))
}
    // rust: Some(t) => TrialConfig::decode(t),
    // rust: None => None,
}
    // rust: config.map_or_else(ConfigSlot::default, |config| ConfigSlot {
    // rust: saved: tag.get(k).cloned(),
    // rust: config,
    // rust: })
}
    // rust: let int = |k: &str, default: i32, lo: i32, hi: i32| {
    // rust: spawner::number(tag.get(k))
    // rust: .filter(|v| (i64::from(lo)..=i64::from(hi)).contains(v))
    // rust: .map_or(default, |v| v as i32)
}
    // rust: s.normal = slot("normal_config");
    // rust: s.ominous = slot("ominous_config");
    // rust: s.target_cooldown_length = int("target_cooldown_length", 36000, 0, i32::MAX);
    // rust: s.required_player_range = int("required_player_range", 14, 1, 128);
    // rust: s
}
pub fn save(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: if !self.detected_players.is_empty() {
    // rust: out.push(("registered_players", encode_uuids(&self.detected_players)));
}
    // rust: if !self.current_mobs.is_empty() {
    // rust: out.push(("current_mobs", encode_uuids(&self.current_mobs)));
}
    // rust: if self.cooldown_ends_at != 0 {
    // rust: out.push(("cooldown_ends_at", Tag::Long(self.cooldown_ends_at)));
}
    // rust: if self.next_mob_spawns_at != 0 {
    // rust: out.push(("next_mob_spawns_at", Tag::Long(self.next_mob_spawns_at)));
}
    // rust: if self.total_mobs_spawned != 0 {
    // rust: out.push(("total_mobs_spawned", Tag::Int(self.total_mobs_spawned)));
}
    // rust: if let Some(d) = &self.next_spawn_data {
    // rust: out.push(("spawn_data", d.encode()));
}
    // rust: if let Some(t) = &self.ejecting_loot_table {
    // rust: out.push(("ejecting_loot_table", Tag::String(t.as_str().into())));
}
    // rust: for (key, slot) in [
    // rust: ("normal_config", &self.normal),
    // rust: ("ominous_config", &self.ominous),
    // rust: ] {
    // rust: if let Some(t) = &slot.saved {
    // rust: out.push((key, t.clone()));
}
}
    // rust: if self.target_cooldown_length != 36000 {
    // rust: out.push((
    // rust: "target_cooldown_length",
    // rust: Tag::Int(self.target_cooldown_length),
    // rust: ));
}
    // rust: if self.required_player_range != 14 {
    // rust: out.push((
    // rust: "required_player_range",
    // rust: Tag::Int(self.required_player_range),
    // rust: ));
}
    // rust: out
}
pub fn update_tag(self: *Self, state: TrialState) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Compound::new();
    // rust: if state == TrialState::Active {
    // rust: out.insert(
    // rust: "next_mob_spawns_at".into(),
    // rust: Tag::Long(self.next_mob_spawns_at),
    // rust: );
}
    // rust: if let Some(d) = &self.next_spawn_data {
    // rust: out.insert("spawn_data".into(), d.encode());
}
    // rust: Tag::Compound(out)
}
pub fn active_config(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_ominous {
    // rust: &self.ominous.config
    // rust: } else {
    // rust: &self.normal.config
}
}
pub fn reset_statistics(self: *Self) void {
}
    // rust: self.detected_players.clear();
    // rust: self.total_mobs_spawned = 0;
    // rust: self.next_mob_spawns_at = 0;
    // rust: self.cooldown_ends_at = 0;
}
pub fn reset(self: *Self) void {
}
    // rust: self.current_mobs.clear();
    // rust: self.next_spawn_data = None;
    // rust: self.reset_statistics();
}
pub fn override_entity(self: *Self, id: []const u8) void {
}
    // rust: self.reset();
    // rust: for slot in [&mut self.normal, &mut self.ominous] {
    // rust: let mut entity = Compound::new();
    // rust: entity.insert("id".into(), Tag::String(id.into()));
    // rust: slot.config.spawn_potentials = vec![(SpawnData::new(entity, None, None), 1)];
    // rust: slot.saved = Some(slot.config.encode());
}
}
pub fn override_entity_data(self: *Self, id: []const u8, data: *Compound) void {
}
    // rust: self.reset();
    // rust: for slot in [&mut self.normal, &mut self.ominous] {
    // rust: let mut entity = Compound::new();
    // rust: entity.insert("id".into(), Tag::String(id.into()));
    // rust: crate::data_cmd::merge_compound(&mut entity, data);
    // rust: slot.config.spawn_potentials = vec![(SpawnData::new(entity, None, None), 1)];
    // rust: slot.saved = Some(slot.config.encode());
}
}
    // rust: fn next_or_create(
    // rust: &mut self,
    // rust: random: &mut impl RandomSource,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> &SpawnData {
    // rust: if self.next_spawn_data.is_none() {
    // rust: let potentials = &self.active_config().spawn_potentials;
    // rust: let picked = spawner::weighted_index(potentials.iter().map(|(_, w)| *w), random)
    // rust: .map(|i| potentials[i].0.clone());
    // rust: self.next_spawn_data = Some(picked.unwrap_or_default());
    // rust: events.push(TrialEvent::BlockUpdated);
}
    // rust: self.next_spawn_data.get_or_insert_default()
}
    // rust: fn has_mob_to_spawn(
    // rust: &mut self,
    // rust: random: &mut impl RandomSource,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> bool {
    // rust: self.next_or_create(random, events).id().is_some()
            // WeightedList.isEmpty: a total weight of 0.
    // rust: || self.active_config().spawn_potentials.iter().any(|(_, w)| *w > 0)
}
    // rust: fn can_spawn_in_level<L: TrialSpawnerLevel>(l: &L) -> bool {
    // rust: l.spawner_blocks_work() && !l.peaceful() && l.mob_spawning()
}
    // rust: fn detect<L: TrialSpawnerLevel>(&self, l: &L, pos: [i32; 3], line_of_sight: bool) -> Vec<Uuid> {
    // rust: let range = f64::from(self.required_player_range);
    // rust: l.players()
    // rust: .into_iter()
    // rust: .filter(|p| {
    // rust: let d = [0, 1, 2].map(|i| f64::from(p.block[i] - pos[i]));
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] < range * range
    // rust: && !p.creative
    // rust: && !p.spectator
    // rust: })
    // rust: .filter(|p| !line_of_sight || in_line_of_sight(l, center(pos), p.eye))
    // rust: .map(|p| p.uuid)
    // rust: .collect()
}
    // rust: fn try_detect_players<L: TrialSpawnerLevel>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: pos: [i32; 3],
    // rust: state: TrialState,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) {
    // rust: let packed = BlockPos::new(pos[0], pos[1], pos[2]).pack();
    // rust: if packed.wrapping_add(l.game_time()) % 20 != 0 {
    // rust: return;
}
    // rust: let cooldown = state == TrialState::Cooldown;
    // rust: if cooldown && self.is_ominous {
    // rust: return;
}
    // rust: let in_sight = self.detect(l, pos, true);
    // rust: let mut became_ominous = false;
    // rust: if !self.is_ominous && !in_sight.is_empty() {
            // findPlayerWithOminousEffect: the first with Trial Omen, else
            // the last with Bad Omen.
    // rust: let players = l.players();
    // rust: let mut found = None;
    // rust: for uuid in &in_sight {
    // rust: let Some(p) = players.iter().find(|p| p.uuid == *uuid) else {
    // rust: continue;
}
    // rust: match p.omen {
    // rust: Some(Omen::Trial) => {
    // rust: found = Some((*p, Omen::Trial));
    // rust: break;
}
    // rust: Some(Omen::Bad) => found = Some((*p, Omen::Bad)),
    // rust: None => {}
}
}
    // rust: if let Some((player, omen)) = found {
    // rust: if omen == Omen::Bad {
    // rust: events.push(TrialEvent::TrialOmen(player.uuid));
}
    // rust: let eye = player.eye.map(|v| v.floor() as i32);
    // rust: events.push(TrialEvent::LevelEvent(3020, eye, 0));
    // rust: self.apply_ominous(l, pos, events);
    // rust: became_ominous = true;
}
}
    // rust: if cooldown && !became_ominous {
    // rust: return;
}
    // rust: let found = if self.detected_players.is_empty() {
    // rust: in_sight
    // rust: } else {
    // rust: self.detect(l, pos, false)
}
    // rust: let mut added = false;
    // rust: for uuid in found {
    // rust: if !self.detected_players.contains(&uuid) {
    // rust: self.detected_players.push(uuid);
    // rust: added = true;
}
}
    // rust: if added {
    // rust: self.next_mob_spawns_at = (l.game_time() + 40).max(self.next_mob_spawns_at);
    // rust: if !became_ominous {
    // rust: let id = if self.is_ominous { 3019 } else { 3013 };
    // rust: events.push(TrialEvent::LevelEvent(
    // rust: id,
    // rust: pos,
    // rust: self.detected_players.len() as i32,
    // rust: ));
}
}
}
    // rust: fn apply_ominous<L: TrialSpawnerLevel>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: pos: [i32; 3],
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) {
    // rust: events.push(TrialEvent::OminousSet(true));
    // rust: events.push(TrialEvent::LevelEvent(3020, pos, 1));
    // rust: self.is_ominous = true;
    // rust: for uuid in hash_order(&self.current_mobs) {
    // rust: if let Some(block) = l.entity_block(uuid) {
                // FlameParticle.NORMAL.
    // rust: events.push(TrialEvent::LevelEvent(3012, block, 0));
    // rust: events.push(TrialEvent::Discard(uuid));
}
}
        // WeightedList.isEmpty: a total weight of 0.
    // rust: if self
    // rust: .ominous
    // rust: .config
    // rust: .spawn_potentials
    // rust: .iter()
    // rust: .any(|(_, w)| *w > 0)
    // rust: {
    // rust: self.next_spawn_data = None;
}
    // rust: self.total_mobs_spawned = 0;
    // rust: self.current_mobs.clear();
    // rust: let now = l.game_time();
    // rust: self.next_mob_spawns_at = now + i64::from(self.ominous.config.ticks_between_spawn);
    // rust: events.push(TrialEvent::BlockUpdated);
    // rust: self.cooldown_ends_at = now + TICKS_BETWEEN_ITEM_SPAWNERS;
}
    // rust: fn spawn_ominous_item_spawner<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) {
        // getDispensingItems: rolled once with a seed from the level seed and
        // the spawner's 30x20x30 cell; an empty roll is not kept.
    // rust: if self.dispensing.is_none() {
    // rust: let cell = BlockPos::new(
    // rust: (pos[0] as f32 / 30.0).floor() as i32,
    // rust: (pos[1] as f32 / 20.0).floor() as i32,
    // rust: (pos[2] as f32 / 30.0).floor() as i32,
    // rust: );
    // rust: let table = &self.active_config().items_to_drop_when_ominous;
    // rust: let drops = l.loot_items(table, l.seed().wrapping_add(cell.pack()));
    // rust: if !drops.is_empty() {
    // rust: self.dispensing = Some(drops);
}
}
    // rust: let items = self.dispensing.as_deref().unwrap_or_default();
        // WeightedList.getRandom: each stack weighs its count; one item spawns.
    // rust: let Some(index) = spawner::weighted_index(items.iter().map(|s| s.count as i32), random)
    // rust: else {
    // rust: return;
}
    // rust: let item = crate::items::ItemStack {
    // rust: count: 1,
    // rust: ..items[index].clone()
}
    // rust: if l.game_time() < self.cooldown_ends_at {
    // rust: return;
}
    // rust: let Some(position) = self.item_spawner_position(l, random, pos) else {
    // rust: return;
}
    // rust: let delay = random.next_int_between_inclusive(60, 120).unwrap_or(60);
    // rust: events.push(TrialEvent::ItemSpawner {
    // rust: item,
    // rust: position,
    // rust: delay,
    // rust: });
    // rust: let pitch = (random.next_float() - random.next_float()) * 0.2 + 1.0;
    // rust: events.push(TrialEvent::SoundAt(
    // rust: "block.trial_spawner.spawn_item_begin",
    // rust: position.map(|v| v.floor() as i32),
    // rust: pitch,
    // rust: ));
    // rust: self.cooldown_ends_at = l.game_time() + TICKS_BETWEEN_ITEM_SPAWNERS;
}
    // rust: fn item_spawner_position<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: ) -> Option<[f64; 3]> {
    // rust: let c = center(pos);
    // rust: let range = f64::from(self.required_player_range * self.required_player_range);
    // rust: let near = |p: [f64; 3]| {
    // rust: (p[0] - c[0]).powi(2) + (p[1] - c[1]).powi(2) + (p[2] - c[2]).powi(2) <= range
}
    // rust: let all = l.players();
    // rust: let players: Vec<([f64; 3], f32)> = hash_order(&self.detected_players)
    // rust: .into_iter()
    // rust: .filter_map(|uuid| all.iter().find(|p| p.uuid == uuid))
    // rust: .filter(|p| !p.creative && !p.spectator && p.alive && near(p.position))
    // rust: .map(|p| (p.position, p.height))
    // rust: .collect();
    // rust: if players.is_empty() {
    // rust: return None;
}
    // rust: let mobs: Vec<([f64; 3], f32)> = hash_order(&self.current_mobs)
    // rust: .into_iter()
    // rust: .filter_map(|uuid| l.entity_box(uuid))
    // rust: .filter(|(p, _)| near(*p))
    // rust: .collect();
    // rust: let eligible = if random.next_boolean() { mobs } else { players };
    // rust: let (at, height) = match eligible.len() {
    // rust: 0 => return None,
    // rust: 1 => eligible[0],
    // rust: n => eligible[random.next_int_bound(n as i32).unwrap_or(0) as usize],
}
        // calculatePositionAbove: a VISUAL clip up to 2 to 5 blocks over the
        // entity's head; a miss ends in the block holding the end point.
    // rust: let up = height + 2.0 + random.next_int_bound(4).unwrap_or(0) as f32;
    // rust: let to = [at[0], at[1] + f64::from(up), at[2]];
    // rust: let hit = l
    // rust: .visual_hit(at, to)
    // rust: .unwrap_or_else(|| to.map(|v| v.floor() as i32));
    // rust: let down = [
    // rust: f64::from(hit[0]) + 0.5,
    // rust: f64::from(hit[1]) + 0.5 - 1.0,
    // rust: f64::from(hit[2]) + 0.5,
    // rust: ];
    // rust: l.no_block_collision(down.map(|v| v.floor() as i32))
    // rust: .then_some(down)
}
    // rust: fn server_tick<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: state: TrialState,
    // rust: ominous: bool,
    // rust: spawn: &mut dyn FnMut(&L, &SpawnerSpawn) -> Option<Uuid>,
    // rust: eject: &mut dyn FnMut(&str, &mut R) -> bool,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> TrialState {
    // rust: self.is_ominous = ominous;
    // rust: let before = self.current_mobs.len();
    // rust: let max = MAX_MOB_TRACKING_DISTANCE * MAX_MOB_TRACKING_DISTANCE;
    // rust: self.current_mobs.retain(|id| {
    // rust: l.entity_block(*id).is_some_and(|b| {
    // rust: let d = [0, 1, 2].map(|i| i64::from(b[i] - pos[i]));
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] <= max
    // rust: })
    // rust: });
    // rust: if self.current_mobs.len() != before {
    // rust: self.next_mob_spawns_at =
    // rust: l.game_time() + i64::from(self.active_config().ticks_between_spawn);
}
    // rust: self.tick_and_get_next(l, random, pos, state, spawn, eject, events)
}
    // rust: fn tick_and_get_next<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: state: TrialState,
    // rust: spawn: &mut dyn FnMut(&L, &SpawnerSpawn) -> Option<Uuid>,
    // rust: eject: &mut dyn FnMut(&str, &mut R) -> bool,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> TrialState {
//         use TrialState as S;
    // rust: let now = l.game_time();
    // rust: match state {
    // rust: S::Inactive => {
                // getOrCreateDisplayEntity: made once, from the next data's id.
    // rust: if !self.has_display {
    // rust: let id = self.next_or_create(random, events).id();
    // rust: self.has_display = id.is_some_and(|id| l.entity_exists(&id));
}
    // rust: if self.has_display {
    // rust: S::WaitingForPlayers
    // rust: } else {
    // rust: state
}
}
    // rust: S::WaitingForPlayers => {
    // rust: if !Self::can_spawn_in_level(l) {
    // rust: self.reset_statistics();
    // rust: state
    // rust: } else if !self.has_mob_to_spawn(random, events) {
    // rust: S::Inactive
    // rust: } else {
    // rust: self.try_detect_players(l, pos, state, events);
    // rust: if self.detected_players.is_empty() {
    // rust: state
    // rust: } else {
    // rust: S::Active
}
}
}
    // rust: S::Active => {
    // rust: if !Self::can_spawn_in_level(l) {
    // rust: self.reset_statistics();
    // rust: return S::WaitingForPlayers;
}
    // rust: if !self.has_mob_to_spawn(random, events) {
    // rust: return S::Inactive;
}
    // rust: let config = self.active_config().clone();
    // rust: let additional = (self.detected_players.len() as i32 - 1).max(0);
    // rust: self.try_detect_players(l, pos, state, events);
    // rust: if self.is_ominous {
    // rust: self.spawn_ominous_item_spawner(l, random, pos, events);
}
    // rust: if self.total_mobs_spawned >= config.target_total_mobs(additional) {
    // rust: if self.current_mobs.is_empty() {
    // rust: self.cooldown_ends_at = now + i64::from(self.target_cooldown_length);
    // rust: self.total_mobs_spawned = 0;
    // rust: self.next_mob_spawns_at = 0;
    // rust: return S::WaitingForRewardEjection;
}
    // rust: } else if now >= self.next_mob_spawns_at
    // rust: && (self.current_mobs.len() as i32)
    // rust: < config.target_simultaneous_mobs(additional)
    // rust: && let Some(uuid) = self.spawn_mob(l, random, pos, spawn, events)
    // rust: {
    // rust: self.current_mobs.push(uuid);
    // rust: self.total_mobs_spawned += 1;
    // rust: self.next_mob_spawns_at = now + i64::from(config.ticks_between_spawn);
    // rust: let potentials = &config.spawn_potentials;
    // rust: if let Some(i) =
    // rust: spawner::weighted_index(potentials.iter().map(|(_, w)| *w), random)
    // rust: {
    // rust: self.next_spawn_data = Some(potentials[i].0.clone());
    // rust: events.push(TrialEvent::BlockUpdated);
}
}
    // rust: state
}
    // rust: S::WaitingForRewardEjection => {
    // rust: let started = self.cooldown_ends_at - i64::from(self.target_cooldown_length);
    // rust: if now as f32 >= started as f32 + DELAY_BEFORE_EJECT {
    // rust: events.push(TrialEvent::Sound("block.trial_spawner.open_shutter"));
    // rust: S::EjectingReward
    // rust: } else {
    // rust: state
}
}
    // rust: S::EjectingReward => {
    // rust: let started = self.cooldown_ends_at - i64::from(self.target_cooldown_length);
    // rust: if (now - started) as f32 % TIME_BETWEEN_EJECTIONS != 0.0 {
    // rust: return state;
}
    // rust: if self.detected_players.is_empty() {
    // rust: events.push(TrialEvent::Sound("block.trial_spawner.close_shutter"));
    // rust: self.ejecting_loot_table = None;
    // rust: return S::Cooldown;
}
    // rust: if self.ejecting_loot_table.is_none() {
    // rust: let tables = &self.active_config().loot_tables_to_eject;
    // rust: self.ejecting_loot_table =
    // rust: spawner::weighted_index(tables.iter().map(|(_, w)| *w), random)
    // rust: .map(|i| tables[i].0.clone());
}
    // rust: if let Some(table) = self.ejecting_loot_table.clone()
    // rust: && eject(&table, random)
    // rust: {
    // rust: events.push(TrialEvent::LevelEvent(3014, pos, 0));
}
                // detectedPlayers.remove(iterator().next()).
    // rust: if let Some(first) = hash_order(&self.detected_players).first() {
    // rust: self.detected_players.retain(|u| u != first);
}
    // rust: state
}
    // rust: S::Cooldown => {
    // rust: self.try_detect_players(l, pos, state, events);
    // rust: if !self.detected_players.is_empty() {
    // rust: self.total_mobs_spawned = 0;
    // rust: self.next_mob_spawns_at = 0;
    // rust: S::Active
    // rust: } else if now >= self.cooldown_ends_at {
    // rust: self.is_ominous = false;
    // rust: events.push(TrialEvent::OminousSet(false));
    // rust: self.reset();
    // rust: S::WaitingForPlayers
    // rust: } else {
    // rust: state
}
}
}
}
    // rust: fn spawn_mob<L: TrialSpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: spawn: &mut dyn FnMut(&L, &SpawnerSpawn) -> Option<Uuid>,
    // rust: events: &mut Vec<TrialEvent>,
    // rust: ) -> Option<Uuid> {
    // rust: let data = self.next_or_create(random, events).clone();
        // EntityType.by: an unknown type spawns nothing.
    // rust: let id = data.id().filter(|id| l.entity_exists(id))?;
    // rust: let at = match spawner::read_pos(data.entity.get(&JavaString::from("Pos"))) {
    // rust: Some(p) => p,
    // rust: None => {
    // rust: let range = f64::from(self.active_config().spawn_range);
    // rust: let x =
    // rust: f64::from(pos[0]) + (random.next_double() - random.next_double()) * range + 0.5;
    // rust: let y = f64::from(pos[1] + random.next_int_bound(3).unwrap_or(0) - 1);
    // rust: let z =
    // rust: f64::from(pos[2]) + (random.next_double() - random.next_double()) * range + 0.5;
    // rust: [x, y, z]
}
}
        // Entity types Horizon cannot create spawn nothing.
    // rust: let (species, width, height, _) = l.mob_type(&id)?;
    // rust: let spawn_box = spawn_selection::spawn_aabb(species, at[0], at[1], at[2], width, height);
    // rust: if !l.no_collision(spawn_box) || !in_line_of_sight(l, center(pos), at) {
    // rust: return None;
}
    // rust: let block = at.map(|v| v.floor() as i32);
    // rust: if !spawn_rules::check_spawn_rules(
    // rust: species,
    // rust: l,
    // rust: Reason::TrialSpawner,
    // rust: random,
    // rust: block[0],
    // rust: block[1],
    // rust: block[2],
    // rust: ) {
    // rust: return None;
}
    // rust: if let Some(rules) = data.custom_spawn_rules
    // rust: && !SpawnData::valid_position(rules, l, block[0], block[1], block[2])
    // rust: {
    // rust: return None;
}
    // rust: let yaw = random.next_float() * 360.0;
    // rust: let placed = spawner::entity_position(species, at);
    // rust: let own = placed.map(|v| v.floor() as i32);
    // rust: let scale = spawner::cube_scale(&id, &data.entity);
    // rust: let bounds = spawn_selection::spawn_box(
    // rust: placed[0],
    // rust: placed[1],
    // rust: placed[2],
    // rust: width * scale,
    // rust: height * scale,
    // rust: );
    // rust: if !spawn_selection::spawn_obstruction(
    // rust: species,
    // rust: l,
    // rust: bounds,
    // rust: Some(&[]),
    // rust: own[0],
    // rust: own[1],
    // rust: own[2],
    // rust: ) {
    // rust: return None;
}
    // rust: let request = SpawnerSpawn {
    // rust: entity: &data.entity,
    // rust: id: &id,
    // rust: position: placed,
    // rust: yaw,
    // rust: finalize: data.unconfigured(),
    // rust: equipment: data.equipment.as_ref(),
    // rust: trial: true,
}
    // rust: let uuid = spawn(l, &request)?;
    // rust: let flame = i32::from(self.is_ominous);
    // rust: events.push(TrialEvent::LevelEvent(3011, pos, flame));
    // rust: events.push(TrialEvent::LevelEvent(3012, block, flame));
    // rust: events.push(TrialEvent::EntityPlace(uuid, block));
    // rust: Some(uuid)
}
}

/// `Vec3.atCenterOf`.
/// The iteration order of a `HashSet<UUID>` holding `ids` (inserted in
/// order): `HashMap` buckets by the spread `UUID.hashCode`, in a table of 16
/// slots grown to keep it at most three quarters full; within a bucket,
/// insertion order.
pub fn hash_order(ids: *[Uuid]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut table = 16usize;
    // rust: while ids.len() > table * 3 / 4 {
    // rust: table *= 2;
}
    // rust: let bucket = |u: &Uuid| {
    // rust: let h = (u[0] ^ u[1] ^ u[2] ^ u[3]) as u32;
    // rust: ((h ^ (h >> 16)) as usize) & (table - 1)
}
    // rust: let mut out = ids.to_vec();
    // rust: out.sort_by_key(bucket);
    // rust: out
}
pub fn center(pos: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pos.map(|v| f64::from(v) + 0.5)
}
/// `TrialSpawner.inLineOfSight`: a VISUAL clip from `to` back to the spawner
/// hits nothing, or the spawner's own block.
    // rust: fn in_line_of_sight<L: TrialSpawnerLevel>(l: &L, origin: [f64; 3], to: [f64; 3]) -> bool {
    // rust: match l.visual_hit(to, origin) {
    // rust: None => true,
    // rust: Some(b) => b == origin.map(|v| v.floor() as i32),
}
}

    // rust: mod tests {
//     use super::*;

pub fn tag(snbt: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_world::nbt::parse_snbt(snbt).expect("snbt").0
}

pub fn defaults_load_and_save_to_nothing() void {
}
    // rust: let s = TrialSpawner::load_with(&tag("{}"), &|_| None);
    // rust: assert_eq!(s, TrialSpawner::default());
    // rust: assert!(s.save().is_empty());
}

pub fn a_spawn_egg_overrides_both_configs_inline() void {
}
    // rust: let breeze = TrialConfig {
    // rust: total_mobs: 2.0,
    // rust: ..TrialConfig::default()
}
    // rust: let registry = |_: &str| Some(breeze.clone());
    // rust: let mut s = TrialSpawner::load_with(
    // rust: &tag(
    // rust: r#"{normal_config:"minecraft:trial_chamber/breeze/normal",spawn_data:{entity:{}},total_mobs_spawned:3}"#,
    // rust: ),
    // rust: &registry,
    // rust: );
    // rust: s.override_entity("minecraft:zombie");
    // rust: assert_eq!(s.next_spawn_data, None);
    // rust: assert_eq!(s.total_mobs_spawned, 0);
    // rust: for slot in [&s.normal, &s.ominous] {
    // rust: assert_eq!(slot.config.spawn_potentials.len(), 1);
    // rust: assert_eq!(
    // rust: slot.config.spawn_potentials[0].0.id().as_deref(),
    // rust: Some("minecraft:zombie")
    // rust: );
    // rust: let saved = slot.saved.as_ref().expect("saved inline");
    // rust: assert_eq!(TrialConfig::decode(saved).as_ref(), Some(&slot.config));
}
    // rust: assert_eq!(
    // rust: s.normal.saved.as_ref().and_then(|t| t.get("total_mobs")),
    // rust: Some(&Tag::Float(2.0f32.to_bits()))
    // rust: );
}

pub fn registry_configs_resolve_and_are_saved_by_id() void {
}
    // rust: let breeze = TrialConfig {
    // rust: total_mobs: 2.0,
    // rust: ..TrialConfig::default()
}
    // rust: let registry =
    // rust: |id: &str| (id == "minecraft:trial_chamber/breeze/normal").then(|| breeze.clone());
    // rust: let s = TrialSpawner::load_with(
    // rust: &tag(
    // rust: r#"{normal_config:"minecraft:trial_chamber/breeze/normal",required_player_range:10}"#,
    // rust: ),
    // rust: &registry,
    // rust: );
    // rust: assert_eq!(s.normal.config.total_mobs, 2.0);
    // rust: assert_eq!(s.required_player_range, 10);
    // rust: let saved: Vec<_> = s.save().into_iter().map(|(k, _)| k).collect();
    // rust: assert_eq!(saved, ["normal_config", "required_player_range"]);
}

pub fn an_invalid_field_takes_its_default_alone() void {
}
    // rust: let s = TrialSpawner::load_with(
    // rust: &tag(
    // rust: r#"{normal_config:"minecraft:nope",required_player_range:200,target_cooldown_length:5}"#,
    // rust: ),
    // rust: &|_| None,
    // rust: );
    // rust: assert_eq!(s.normal, ConfigSlot::default());
    // rust: assert_eq!(s.required_player_range, 14);
    // rust: assert_eq!(s.target_cooldown_length, 5);
    // rust: let c = TrialConfig::decode(&tag(
    // rust: r#"{spawn_range:0,total_mobs:3.0f,spawn_potentials:[{data:{entity:{id:"minecraft:zombie"}},weight:-1},{data:{entity:{id:"minecraft:husk"}},weight:2}]}"#,
    // rust: ))
    // rust: .expect("config");
    // rust: assert_eq!(c.spawn_range, 4);
    // rust: assert_eq!(c.total_mobs, 3.0);
    // rust: assert_eq!(c.spawn_potentials.len(), 1);
}

pub fn targets_floor_the_per_player_additions() void {
}
    // rust: let c = TrialConfig {
    // rust: simultaneous_mobs: 1.0,
    // rust: simultaneous_mobs_added_per_player: 0.5,
    // rust: ..TrialConfig::default()
}
    // rust: assert_eq!(c.target_simultaneous_mobs(0), 1);
    // rust: assert_eq!(c.target_simultaneous_mobs(1), 1);
    // rust: assert_eq!(c.target_simultaneous_mobs(2), 2);
    // rust: assert_eq!(c.target_total_mobs(3), 12);
}
}
