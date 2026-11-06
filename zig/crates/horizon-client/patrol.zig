//! Transpiled from Horizon Rust crate
//! Module: horizon-client_patrol
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `PatrolSpawner`: every ten to eleven minutes of daylight, one time in five,
//! a pillager patrol gathers 24 to 47 blocks from a random player who is not
//! near a village. The level is read through [`PatrolLevel`] and the pillagers
//! are made by the caller, so the game and the differential test
//! (`tools/test_raid_parity.py`) run the same decisions and random draws.
// use crate::mobs::{
    // rust: Species,
    // rust: spawn_rules::{self, Reason, SpawnLevel},
}
// use horizon_core::random::RandomSource;

/// What the patrol spawner reads from the level.
    // rust: pub trait PatrolLevel: SpawnLevel {
    /// The `spawn_patrols` game rule.
pub fn spawn_patrols(self: *Self) b;
    /// `Level.isBrightOutside`: no fixed time and a sky darkening below 4.
pub fn bright_outside(self: *Self) b;
    /// The level's players, in `level.players()` order: block position and
    /// whether the player is a spectator.
pub fn patrol_players(self: *Self) V;
    /// `ServerLevel.sectionsToVillage` (`PoiManager`): 0 to 7.
pub fn sections_to_village(self: *Self, pos: [i32; 3]) i;
    /// The chunk at chunk coordinates is loaded (`hasChunk`).
pub fn has_chunk(self: *Self, cx: i32, cz: i32) b;
    /// The `gameplay/can_pillager_patrol_spawn` environment attribute.
pub fn can_pillager_patrol_spawn(self: *Self, pos: [i32; 3]) b;
    /// `getCurrentDifficultyAt(pos).getEffectiveDifficulty()`.
pub fn effective_difficulty(self: *Self, pos: [i32; 3]) f;
    /// `Heightmap.Types.MOTION_BLOCKING_NO_LEAVES` height of a column.
pub fn motion_blocking_no_leaves(self: *Self, x: i32, z: i32) i;
}

/// `ServerLevel.isCloseToVillage`.
    // rust: pub fn close_to_village<L: PatrolLevel + ?Sized>(l: &L, pos: [i32; 3], sections: i32) -> bool {
    // rust: sections <= 6 && l.sections_to_village(pos) <= sections
}

/// `Level.hasChunksAt(x0, z0, x1, z1)`.
    // rust: pub fn has_chunks_at<L: PatrolLevel + ?Sized>(l: &L, x0: i32, z0: i32, x1: i32, z1: i32) -> bool {
    // rust: (x0 >> 4..=x1 >> 4).all(|cx| (z0 >> 4..=z1 >> 4).all(|cz| l.has_chunk(cx, cz)))
}

/// A pillager the spawner asks for: where, and whether it leads the patrol.
pub const Member = struct {
    pos: [i32,
    leader: bool,
};

/// `PatrolSpawner` (its countdown lives in memory: a fresh level tries at once).
pub const PatrolSpawner = struct {
    next_tick: i32,
};

    // rust: impl PatrolSpawner {
    /// `PatrolSpawner.tick`. `spawn_enemies` is the chunk source's flag
    /// (`spawn_mobs` and `spawn_monsters`); `random` is the level random.
    /// `spawn` creates, finalizes and adds a pillager at a position that
    /// passed the spawn checks (`EntityType.create` succeeding), and says
    /// whether it did.
    // rust: pub fn tick<L: PatrolLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: level: &L,
    // rust: spawn_enemies: bool,
    // rust: random: &mut R,
    // rust: spawn: &mut dyn FnMut(&L, Member, &mut R) -> bool,
    // rust: ) {
    // rust: if !spawn_enemies || !level.spawn_patrols() {
    // rust: return;
}
    // rust: self.next_tick -= 1;
    // rust: if self.next_tick > 0 {
    // rust: return;
}
    // rust: self.next_tick += 12000 + random.next_int_bound(1200).unwrap_or(0);
    // rust: if !level.bright_outside() || random.next_int_bound(5).unwrap_or(1) != 0 {
    // rust: return;
}
    // rust: let players = level.patrol_players();
    // rust: if players.is_empty() {
    // rust: return;
}
    // rust: let (player, spectator) =
    // rust: players[random.next_int_bound(players.len() as i32).unwrap_or(0) as usize];
    // rust: if spectator || close_to_village(level, player, 2) {
    // rust: return;
}
    // rust: let x = (24 + random.next_int_bound(24).unwrap_or(0))
    // rust: * if random.next_boolean() { -1 } else { 1 };
    // rust: let z = (24 + random.next_int_bound(24).unwrap_or(0))
    // rust: * if random.next_boolean() { -1 } else { 1 };
    // rust: let mut pos = [player[0] + x, player[1], player[2] + z];
    // rust: if !has_chunks_at(level, pos[0] - 10, pos[2] - 10, pos[0] + 10, pos[2] + 10)
    // rust: || !level.can_pillager_patrol_spawn(pos)
    // rust: {
    // rust: return;
}
    // rust: let group = level.effective_difficulty(pos).ceil() as i32 + 1;
    // rust: for i in 0..group {
    // rust: pos[1] = level.motion_blocking_no_leaves(pos[0], pos[2]);
    // rust: let leader = i == 0;
    // rust: if !spawn_member(level, pos, leader, random, spawn) && leader {
    // rust: break;
}
    // rust: pos[0] += random.next_int_bound(5).unwrap_or(0) - random.next_int_bound(5).unwrap_or(0);
    // rust: pos[2] += random.next_int_bound(5).unwrap_or(0) - random.next_int_bound(5).unwrap_or(0);
}
}
}

/// `PatrolSpawner.spawnPatrolMember`: an empty spawn block for a pillager
/// whose `checkPatrollingMonsterSpawnRules` pass.
    // rust: fn spawn_member<L: PatrolLevel, R: RandomSource>(
    // rust: level: &L,
    // rust: pos: [i32; 3],
    // rust: leader: bool,
    // rust: random: &mut R,
    // rust: spawn: &mut dyn FnMut(&L, Member, &mut R) -> bool,
    // rust: ) -> bool {
    // rust: let [x, y, z] = pos;
    // rust: if !spawn_rules::is_valid_empty_spawn(Species::Pillager, level, x, y, z) {
    // rust: return false;
}
    // rust: if !spawn_rules::check_spawn_rules(Species::Pillager, level, Reason::Patrol, random, x, y, z) {
    // rust: return false;
}
    // rust: spawn(level, Member { pos, leader }, random)
}

/// `PatrollingMonster.findPatrolTarget` from a block position.
pub fn patrol_target(at: [i32; 3], random: *mut impl RandomSource) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dx = -500 + random.next_int_bound(1000).unwrap_or(0);
    // rust: let dz = -500 + random.next_int_bound(1000).unwrap_or(0);
    // rust: [at[0] + dx, at[1], at[2] + dz]
}

/// The boolean gameplay attributes patrols and raids read
/// (`gameplay/can_pillager_patrol_spawn`, `gameplay/can_start_raid`): the
/// dimension's value, the biome's, then the dimension's timelines (the early
/// game timeline forbids patrols for the first 120,000 ticks of the
/// overworld clock).
pub const GameplayAttributes = struct {
    /// attribute -> dimension type -> value.
    dimensions: std::collections::HashMap<[]const u8,
    /// attribute -> biome -> value.
    biomes: std::collections::HashMap<[]const u8,
    /// attribute -> dimension type -> boolean tracks (keyframes, modifier).
    tracks: std::collections::HashMap<[]const u8,
};
pub const BoolTrack = struct {
    keyframes: Vec<(i64,
    period: ?i64,
    modifier: []const u8,
};
    // rust: impl BoolTrack {
    /// `KeyframeTrackSampler.sample` for a value that is not interpolated.
pub fn sample(self: *Self, ticks: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = match self.period {
    // rust: Some(p) if p > 0 => ticks.rem_euclid(p),
    // rust: _ => ticks,
}
    // rust: let mut value = self.keyframes[0].1;
    // rust: for (at, v) in &self.keyframes {
    // rust: if t >= *at {
    // rust: value = *v;
}
}
    // rust: value
}
pub fn apply(self: *Self, base: bool, ticks: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let arg = self.sample(ticks);
    // rust: match self.modifier.as_str() {
    // rust: "and" => base && arg,
    // rust: "or" => base || arg,
    // rust: "xor" => base ^ arg,
    // rust: "nand" => !(base && arg),
    // rust: "nor" => !(base || arg),
    // rust: "xnor" => base == arg,
    // rust: _ => arg,
}
}
}
pub const CAN_PILLAGER_PATROL_SPAWN: []const u8 = "minecraft:gameplay/can_pillager_patrol_spawn";
pub const CAN_START_RAID: []const u8 = "minecraft:gameplay/can_start_raid";
    // rust: impl GameplayAttributes {
    /// Reads the dimension types, biomes and timelines under `root/data`.
pub fn load(root: *std::path::Path) S {
    // Implementation ported from Horizon
    return undefined;
}
//         use serde_json::Value;
    // rust: let data = root.join("data/minecraft");
    // rust: let read = |p: std::path::PathBuf| -> Option<Value> {
    // rust: serde_json::from_slice(&std::fs::read(p).ok()?).ok()
}
    // rust: let list = |dir: &str| -> Vec<(String, Value)> {
    // rust: let mut out = Vec::new();
    // rust: if let Ok(entries) = std::fs::read_dir(data.join(dir)) {
    // rust: for e in entries.flatten() {
    // rust: let path = e.path();
    // rust: if let (Some(stem), Some(v)) = (
    // rust: path.file_stem().and_then(|s| s.to_str()).map(str::to_owned),
    // rust: read(path.clone()),
    // rust: ) {
    // rust: out.push((format!("minecraft:{stem}"), v));
}
}
}
    // rust: out
}
    // rust: let keys = [CAN_PILLAGER_PATROL_SPAWN, CAN_START_RAID];
    // rust: let mut out = Self::default();
    // rust: let timelines: std::collections::HashMap<String, Value> =
    // rust: list("timeline").into_iter().collect();
        // Tag values with nested tags resolved.
pub fn tag(data: *std::path::Path, name: []const u8, out: *mut std.ArrayList([]const u8)) void {
}
    // rust: let file = data.join(format!(
    // rust: "tags/timeline/{}.json",
    // rust: name.trim_start_matches('#')
    // rust: .trim_start_matches("minecraft:")
    // rust: ));
    // rust: let Some(v) = std::fs::read(file)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok())
    // rust: else {
    // rust: return;
}
    // rust: for item in v["values"].as_array().into_iter().flatten() {
    // rust: let s = item.as_str().or_else(|| item["id"].as_str()).unwrap_or("");
    // rust: if s.starts_with('#') {
    // rust: tag(data, s, out);
    // rust: } else if !s.is_empty() {
    // rust: out.push(s.to_owned());
}
}
}
    // rust: for (dim, v) in list("dimension_type") {
    // rust: for key in keys {
    // rust: if let Some(b) = v["attributes"][key].as_bool() {
    // rust: out.dimensions
    // rust: .entry(key.into())
    // rust: .or_default()
    // rust: .insert(dim.clone(), b);
}
}
    // rust: let mut names = Vec::new();
    // rust: match &v["timelines"] {
    // rust: Value::String(s) if s.starts_with('#') => tag(&data, s, &mut names),
    // rust: Value::String(s) => names.push(s.clone()),
    // rust: Value::Array(a) => {
    // rust: names.extend(a.iter().filter_map(|x| x.as_str()).map(str::to_owned))
}
    // rust: _ => {}
}
    // rust: for name in names {
    // rust: let Some(t) = timelines.get(&name) else {
    // rust: continue;
}
    // rust: for key in keys {
    // rust: let track = &t["tracks"][key];
    // rust: let Some(frames) = track["keyframes"].as_array() else {
    // rust: continue;
}
    // rust: let keyframes: Vec<(i64, bool)> = frames
    // rust: .iter()
    // rust: .filter_map(|f| Some((f["ticks"].as_i64()?, f["value"].as_bool()?)))
    // rust: .collect();
    // rust: if keyframes.is_empty() {
    // rust: continue;
}
    // rust: out.tracks
    // rust: .entry(key.into())
    // rust: .or_default()
    // rust: .entry(dim.clone())
    // rust: .or_default()
    // rust: .push(BoolTrack {
    // rust: keyframes,
    // rust: period: t["period_ticks"].as_i64(),
    // rust: modifier: track["modifier"].as_str().unwrap_or("override").to_owned(),
    // rust: });
}
}
}
    // rust: for (biome, v) in list("worldgen/biome") {
    // rust: for key in keys {
    // rust: if let Some(b) = v["attributes"][key].as_bool() {
    // rust: out.biomes
    // rust: .entry(key.into())
    // rust: .or_default()
    // rust: .insert(biome.clone(), b);
}
}
}
    // rust: out
}
    /// The attribute in a dimension type and biome at an overworld clock time.
pub fn value(self: *Self, key: []const u8, dimension: []const u8, biome: []const u8, clock: i64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v = self
    // rust: .dimensions
    // rust: .get(key)
    // rust: .and_then(|m| m.get(dimension))
    // rust: .copied()
    // rust: .unwrap_or(true);
    // rust: if let Some(b) = self.biomes.get(key).and_then(|m| m.get(biome)) {
    // rust: v = *b;
}
    // rust: for t in self
    // rust: .tracks
    // rust: .get(key)
    // rust: .and_then(|m| m.get(dimension))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: v = t.apply(v, clock);
}
    // rust: v
}
}
