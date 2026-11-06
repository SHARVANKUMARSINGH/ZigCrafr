//! Transpiled from Horizon Rust crate
//! Module: horizon-client_stats
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player statistics (`ServerStatsCounter`): the custom counters, blocks
//! mined, items used/crafted/broken/picked up/dropped and mobs killed or
//! killed by, saved to `players/stats/<uuid>.json`, plus the phantom
//! spawner that reads the time since rest (`PhantomSpawner`).
// use super::{Dim, Game};
// use horizon_core::geometry::Vec3;
// use horizon_core::random::RandomSource;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: path::{Path, PathBuf},
}

/// `stats[type][key]`, with `type` and `key` namespaced ids.
    // rust: pub(super) struct Stats {
    // rust: pub(super) values: BTreeMap<String, BTreeMap<String, i32>>,
    // rust: pub(super) loaded: bool,
    /// Ticks until the phantom spawner runs again.
    // rust: phantom_tick: i32,
    /// Statistic changes (type, key, amount; `None` = reset) for the
    /// scoreboard criteria to follow.
    // rust: pub(super) events: Vec<(String, String, Option<i32>)>,
    /// Changed since the client was last sent them (`StatsCounter`'s dirty
    /// set), by type.
    // rust: dirty: BTreeMap<String, BTreeSet<String>>,
}

/// `minecraft:` and `name`, given to `f` from the stack when short: some
/// counters go up every tick for every player, and they are found without
/// a string made for each.
    // rust: fn namespaced<T>(name: &str, f: impl FnOnce(&str) -> T) -> T {
pub const NAMESPACE: []const u8 = "minecraft:";
    // rust: let mut buf = [0u8; 96];
    // rust: let len = NAMESPACE.len() + name.len();
    // rust: if len > buf.len() {
    // rust: return f(&format!("{NAMESPACE}{name}"));
}
    // rust: buf[..NAMESPACE.len()].copy_from_slice(NAMESPACE.as_bytes());
    // rust: buf[NAMESPACE.len()..len].copy_from_slice(name.as_bytes());
    // Two strings one after the other are one.
    // rust: f(std::str::from_utf8(&buf[..len]).unwrap_or_default())
}

/// The map under `key`, made when missing, found without an owned key
/// when there.
    // rust: fn entry<'a, V: Default>(map: &'a mut BTreeMap<String, V>, key: &str) -> &'a mut V {
    // rust: if !map.contains_key(key) {
    // rust: map.insert(key.to_owned(), V::default());
}
    // rust: map.get_mut(key).expect("just inserted")
}

    // rust: impl Stats {
    // rust: pub(super) fn add(&mut self, ty: &str, key: &str, n: i32) {
    // rust: namespaced(ty, |ty| {
    // rust: let v = entry(entry(&mut self.values, ty), key);
    // rust: *v = v.saturating_add(n);
    // rust: self.events.push((ty.to_owned(), key.to_owned(), Some(n)));
    // rust: self.mark_dirty(ty, key);
    // rust: });
}
pub fn mark_dirty(self: *Self, ty: []const u8, key: []const u8) void {
}
    // rust: let keys = entry(&mut self.dirty, ty);
    // rust: if !keys.contains(key) {
    // rust: keys.insert(key.to_owned());
}
}
    // rust: pub(super) fn get(&self, ty: &str, key: &str) -> i32 {
    // rust: self.values
    // rust: .get(&format!("minecraft:{ty}"))
    // rust: .and_then(|m| m.get(key))
    // rust: .copied()
    // rust: .unwrap_or(0)
}
    // rust: pub(super) fn reset(&mut self, ty: &str, key: &str) {
    // rust: if let Some(m) = self.values.get_mut(&format!("minecraft:{ty}")) {
    // rust: m.insert(key.to_owned(), 0);
}
    // rust: self.mark_dirty(&format!("minecraft:{ty}"), key);
    // rust: self.events
    // rust: .push((format!("minecraft:{ty}"), key.to_owned(), None));
}
    /// `ServerPlayer.die`'s `resetStat` of `TIME_SINCE_DEATH` and `TIME_SINCE_REST`.
    // rust: pub(super) fn reset_death_timers(&mut self) {
    // rust: self.reset("custom", "minecraft:time_since_death");
    // rust: self.reset("custom", "minecraft:time_since_rest");
}
    // rust: pub(super) fn custom(&mut self, key: &str, n: i32) {
    // rust: namespaced(key, |key| self.add("custom", key, n));
}
    /// `ServerStatsCounter.markAllDirty`: everything goes out on the next request.
    // rust: pub(super) fn mark_all_dirty(&mut self) {
    // rust: self.dirty = self
    // rust: .values
    // rust: .iter()
    // rust: .map(|(ty, m)| (ty.clone(), m.keys().cloned().collect()))
    // rust: .collect();
}
    /// `ServerStatsCounter.sendStats`' entries: the dirty statistics and
    /// their values, the set cleared.
    // rust: pub(super) fn take_dirty(&mut self) -> Vec<(String, String, i32)> {
    // rust: std::mem::take(&mut self.dirty)
    // rust: .into_iter()
    // rust: .flat_map(|(ty, keys)| keys.into_iter().map(move |key| (ty.clone(), key)))
    // rust: .map(|(ty, key)| {
    // rust: let v = self.values.get(&ty).and_then(|m| m.get(&key)).copied();
    // rust: (ty, key, v.unwrap_or(0))
    // rust: })
    // rust: .collect()
}
    /// `ServerStatsCounter.parseLocal`: the counters of a stats file.
    // rust: pub(super) fn read(path: &Path) -> Self {
    // rust: let json = std::fs::read_to_string(path)
    // rust: .ok()
    // rust: .and_then(|t| serde_json::from_str::<serde_json::Value>(&t).ok())
    // rust: .unwrap_or_default();
    // rust: Self::from_json(&json)
}
    /// The counters of a stats file's JSON, or of a hand-over's record (`player-import`).
    // rust: pub(super) fn from_json(json: &serde_json::Value) -> Self {
    // rust: let mut stats = Self {
    // rust: loaded: true,
    // rust: ..Self::default()
}
    // rust: if let Some(all) = json.get("stats").and_then(|s| s.as_object()) {
    // rust: for (ty, entries) in all {
    // rust: let Some(entries) = entries.as_object() else {
    // rust: continue;
}
    // rust: let map = stats.values.entry(ty.clone()).or_default();
    // rust: for (key, v) in entries {
    // rust: if let Some(n) = v.as_i64() {
    // rust: map.insert(key.clone(), n as i32);
}
}
}
}
    // rust: stats
}
    /// `ServerStatsCounter.toJson`: what `write` puts in the file, and what a
    /// hand-over's record carries (`player-export`).
    // rust: pub(super) fn to_json(&self) -> serde_json::Value {
    // rust: let stats: serde_json::Map<String, serde_json::Value> = self
    // rust: .values
    // rust: .iter()
    // rust: .filter(|(_, m)| !m.is_empty())
    // rust: .map(|(ty, m)| {
    // rust: let entries: serde_json::Map<String, serde_json::Value> =
    // rust: m.iter().map(|(k, v)| (k.clone(), (*v).into())).collect();
    // rust: (ty.clone(), serde_json::Value::Object(entries))
    // rust: })
    // rust: .collect();
    // rust: serde_json::json!({
    // rust: "stats": stats,
    // rust: "DataVersion": horizon_world::DATA_VERSION,
    // rust: })
}
    /// `ServerStatsCounter.save`.
    // rust: pub(super) fn write(&self, path: &Path) {
    // rust: let json = self.to_json();
    // rust: if let Some(dir) = path.parent() {
    // rust: let _ = std::fs::create_dir_all(dir);
}
    // rust: if let Ok(text) = serde_json::to_string_pretty(&json) {
    // rust: let _ = std::fs::write(path, text);
}
}
}
/// `players/<dir>/<uuid>.json` of a world (advancements, stats).
    // rust: pub(super) fn player_json(world: &Path, dir: &str, uuid: [i32; 4]) -> PathBuf {
    // rust: let hex: String = uuid.iter().map(|v| format!("{:08x}", *v as u32)).collect();
    // rust: let text = format!(
    // rust: "{}-{}-{}-{}-{}",
    // rust: &hex[0..8],
    // rust: &hex[8..12],
    // rust: &hex[12..16],
    // rust: &hex[16..20],
    // rust: &hex[20..32]
    // rust: );
    // rust: world.join("players").join(dir).join(format!("{text}.json"))
}
    // rust: impl Game<'_> {
pub fn stats_path(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(player_json(
    // rust: &self.world_root,
    // rust: "stats",
    // rust: self.level.player_uuid?,
    // rust: ))
}
    /// `ServerStatsCounter.parseLocal`.
    // rust: pub(super) fn load_stats(&mut self) {
    // rust: if self.stats.loaded || self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: self.stats.loaded = true;
    // rust: if let Some(path) = self.stats_path() {
    // rust: self.stats.values = Stats::read(&path).values;
}
}
    /// `ServerStatsCounter.save`.
    // rust: pub(super) fn save_stats(&self) {
    // rust: if !self.stats.loaded || self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: if let Some(path) = self.stats_path() {
    // rust: self.stats.write(&path);
}
}
    /// `ServerPlayer.awardStat`: `n` more of the statistic `ty` (a bare type
    /// such as `used`) and `key`, unless a native mod cancels the award.
    // rust: pub(super) fn award_stat(&mut self, ty: &str, key: &str, n: i32) {
        // No mod, no name copied: the per-tick counters come through here.
    // rust: let acting = if horizon_client::mod_api::mods().is_empty() {
    // rust: None
    // rust: } else {
    // rust: self.lan_acting_uuid.zip(self.lan_acting_name.clone())
}
    // rust: if let Some((player, name)) = acting {
    // rust: let mut cancel = false;
    // rust: namespaced(ty, |stat_type| {
    // rust: self.native_player_stat_award(player, &name, stat_type, key, n, &mut cancel)
    // rust: });
    // rust: if cancel {
    // rust: return;
}
}
    // rust: self.stats.add(ty, key, n);
}
    /// `Player.awardStat(Identifier)`: `n` more of the custom statistic `key`.
    // rust: pub(super) fn award_custom_stat(&mut self, key: &str, n: i32) {
    // rust: namespaced(key, |key| self.award_stat("custom", key, n));
}
    /// The per-tick counters (`Player.tick`/`ServerPlayer.tick` awardStat).
    // rust: pub(super) fn tick_stats(&mut self) {
    // rust: self.load_stats();
    // rust: self.count_tick_stats(self.sleeping.is_some());
    // rust: self.tick_movement_stats();
}
    /// `Player.tick`'s counters for the player in `self.player`.
    // rust: pub(super) fn count_tick_stats(&mut self, sleeping: bool) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let alive = !p.health.dead_or_dying();
    // rust: let crouching = p.pose == horizon_client::pose::Pose::Crouching;
    // rust: self.award_custom_stat("play_time", 1);
    // rust: self.award_custom_stat("total_world_time", 1);
    // rust: if alive {
    // rust: self.award_custom_stat("time_since_death", 1);
    // rust: if !sleeping {
    // rust: self.award_custom_stat("time_since_rest", 1);
}
}
    // rust: if crouching {
    // rust: self.award_custom_stat("sneak_time", 1);
}
}
pub fn tick_movement_stats(self: *Self) void {
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let d = p.position.subtract(self.previous_position);
    // rust: self.movement_stats(d);
}
    /// `Player.checkMovementStatistics` / `checkRidingStatistics` for one move.
    // rust: pub(super) fn movement_stats(&mut self, d: Vec3) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let horizontal = ((d.x * d.x + d.z * d.z).sqrt() * 100.0).round() as i32;
    // rust: let total = ((d.x * d.x + d.y * d.y + d.z * d.z).sqrt() * 100.0).round() as i32;
        // Teleports are not travel.
    // rust: if total <= 0 || total > 1000 {
    // rust: return;
}
    // rust: let crouching = p.pose == horizon_client::pose::Pose::Crouching;
    // rust: let feet = [
    // rust: p.position.x.floor() as i32,
    // rust: p.position.y.floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: ];
    // rust: let eye_in_water = self.res.facts().get(self.world.block(
    // rust: feet[0],
    // rust: (p.position.y + f64::from(p.dimensions.eye_height)).floor() as i32,
    // rust: feet[2],
    // rust: ));
    // rust: let in_water = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(feet[0], feet[1], feet[2]))
    // rust: .fluid
    // rust: == horizon_client::blocks::Fluid::Water;
    // rust: let on_ground = p.ground.on_ground;
    // rust: let (sprinting, gliding, swimming) = (
    // rust: p.sprinting,
    // rust: p.fall_flying,
    // rust: p.pose == horizon_client::pose::Pose::Swimming,
    // rust: );
    // rust: let climbing = p.last_climbable.is_some() && d.y > 0.0;
    // rust: let riding = self.riding.map(|id| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| m.species())
    // rust: .ok_or(())
    // rust: });
    // rust: match riding {
    // rust: Some(Ok(sp)) => {
//                 use horizon_client::mobs::Species;
                // `checkRidingStatistics`: only these mounts count, the horse
                // family by the full 3D distance; any other mount nothing.
    // rust: match sp {
    // rust: Species::Pig => self.award_custom_stat("pig_one_cm", total),
    // rust: Species::Strider => self.award_custom_stat("strider_one_cm", total),
    // rust: Species::HappyGhast => self.award_custom_stat("happy_ghast_one_cm", total),
    // rust: Species::Nautilus | Species::ZombieNautilus => {
    // rust: self.award_custom_stat("nautilus_one_cm", total)
}
    // rust: sp if horizon_client::mobs::equine::is_equine(sp) => {
    // rust: self.award_custom_stat("horse_one_cm", total)
}
    // rust: _ => {}
}
}
    // rust: Some(Err(())) => {
    // rust: if self.boats.iter().any(|b| Some(b.id) == self.riding) {
    // rust: self.award_custom_stat("boat_one_cm", total)
    // rust: } else if self.carts.iter().any(|c| Some(c.id) == self.riding) {
    // rust: self.award_custom_stat("minecart_one_cm", total)
}
}
    // rust: None if swimming => self.award_custom_stat("swim_one_cm", total),
    // rust: None if eye_in_water.fluid == horizon_client::blocks::Fluid::Water => {
    // rust: self.award_custom_stat("walk_under_water_one_cm", total)
}
    // rust: None if in_water => {
    // rust: if horizontal > 0 {
    // rust: self.award_custom_stat("walk_on_water_one_cm", horizontal)
}
}
    // rust: None if climbing => {
    // rust: self.award_custom_stat("climb_one_cm", (d.y * 100.0).round() as i32)
}
    // rust: None if on_ground => {
    // rust: if horizontal > 0 {
    // rust: if sprinting {
    // rust: self.award_custom_stat("sprint_one_cm", horizontal)
    // rust: } else if crouching {
    // rust: self.award_custom_stat("crouch_one_cm", horizontal)
    // rust: } else {
    // rust: self.award_custom_stat("walk_one_cm", horizontal)
}
}
}
    // rust: None if gliding => self.award_custom_stat("aviate_one_cm", total),
            // Airborne and not gliding: more than 25 cm sideways per move
            // (creative flight, or a long jump), not only flying.
    // rust: None if horizontal > 25 => self.award_custom_stat("fly_one_cm", horizontal),
    // rust: None => {}
}
}
    /// `PhantomSpawner.tick`: tired players under an open night sky draw
    /// phantoms. A custom spawner ticks only while `spawn_mobs` is on
    /// (`ServerChunkCache.tickChunks`), and this one only spawns enemies
    /// (`ServerLevel.isSpawningMonsters`: `spawn_monsters` too). Every
    /// player of the level counts: the game's own and the hosted ones (a
    /// server thread's players are all hosted).
    // rust: pub(super) fn spawn_phantoms(&mut self) {
    // rust: let rules = &self.ui.rules;
    // rust: if !rules.bool("spawn_mobs")
    // rust: || !rules.bool("spawn_monsters")
    // rust: || !rules.bool("spawn_phantoms")
    // rust: || self.dim != Dim::Overworld
    // rust: {
    // rust: return;
}
    // rust: self.stats.phantom_tick -= 1;
    // rust: if self.stats.phantom_tick > 0 {
    // rust: return;
}
    // rust: let r = &mut self.world.random;
    // rust: self.stats.phantom_tick += (60 + r.next_int_bound(60).unwrap_or(0)) * 20;
    // rust: if self.sky_darken() < 5 {
    // rust: return;
}
    // rust: let rest = |s: &Stats| s.get("custom", "minecraft:time_since_rest");
        // `level.players()`: (block position, time since rest) of each player
        // who isn't a spectator.
    // rust: let mut players = Vec::new();
    // rust: if let Some(p) = self.player.as_ref()
    // rust: && !self.spectator()
    // rust: {
    // rust: players.push((p.position, rest(&self.stats)));
}
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: let level = self.dim.id();
    // rust: for g in host.hub.guests.iter().filter(|g| {
    // rust: g.placed
    // rust: && g.dimension == level
    // rust: && g.game_mode != horizon_client::lan::guest::SPECTATOR
    // rust: }) {
    // rust: let since = host.play.get(&g.conn).map_or(0, |p| rest(&p.stats));
    // rust: players.push((
    // rust: Vec3::new(g.position[0], g.position[1], g.position[2]),
    // rust: since,
    // rust: ));
}
}
    // rust: for (position, since) in players {
    // rust: self.spawn_phantoms_near(position, since);
}
}
    /// One player's turn of `PhantomSpawner.tick`.
pub fn spawn_phantoms_near(self: *Self, position: Vec3, since_rest: i32) void {
}
    // rust: let pos = [
    // rust: position.x.floor() as i32,
    // rust: position.y.floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ];
    // rust: if pos[1] < 63 || !self.can_see_sky(pos) {
    // rust: return;
}
        // `getCurrentDifficultyAt(playerPos).isHarderThan(random * 3)`.
    // rust: let difficulty = self.local_difficulty([position.x, position.y, position.z]);
    // rust: let r = &mut self.world.random;
    // rust: if difficulty.effective <= r.next_float() * 3.0 {
    // rust: return;
}
    // rust: if r.next_int_bound(since_rest.max(1)).unwrap_or(0) < 72000 {
    // rust: return;
}
        // `playerPos.above(20 + nextInt(15)).east(-10 + nextInt(21)).south(...)`:
        // the height is drawn first.
    // rust: let up = 20 + r.next_int_bound(15).unwrap_or(0);
    // rust: let east = -10 + r.next_int_bound(21).unwrap_or(10);
    // rust: let south = -10 + r.next_int_bound(21).unwrap_or(10);
    // rust: let at = [pos[0] + east, pos[1] + up, pos[2] + south];
    // rust: if !self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(at[0], at[1], at[2]))
    // rust: {
    // rust: return;
}
    // rust: let difficulty_id = self.difficulty_id();
    // rust: let group = phantom_group_size(&mut self.world.random, difficulty_id);
    // rust: for _ in 0..group {
    // rust: let _ = self.spawn_mob(
    // rust: "minecraft:phantom",
    // rust: [
    // rust: f64::from(at[0]) + 0.5,
    // rust: f64::from(at[1]),
    // rust: f64::from(at[2]) + 0.5,
    // rust: ],
    // rust: false,
    // rust: );
}
}
pub fn can_see_sky(self: *Self, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (pos[1] + 1..pos[1] + 256).all(|y| {
    // rust: let f = self.res.facts().get(self.world.block(pos[0], y, pos[2]));
    // rust: !f.full_collision && f.fluid == horizon_client::blocks::Fluid::None
    // rust: })
}
}

/// `1 + random.nextInt(difficulty.getId() + 1)` of `PhantomSpawner.tick`: Peaceful still draws.
pub fn phantom_group_size(random: *mut impl RandomSource, difficulty_id: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 1 + random.next_int_bound(difficulty_id + 1).unwrap_or(0)
}

    // rust: mod tests {
//     use super::*;

    /// ServerPlayer.die zeroes the two timers (and only them) and sends the new zero.
pub fn death_resets_the_timers_since_death_and_rest() void {
}
    // rust: let mut s = Stats::default();
    // rust: s.custom("time_since_death", 700);
    // rust: s.custom("time_since_rest", 900);
    // rust: s.custom("deaths", 2);
    // rust: s.events.clear();
    // rust: s.reset_death_timers();
    // rust: assert_eq!(s.get("custom", "minecraft:time_since_death"), 0);
    // rust: assert_eq!(s.get("custom", "minecraft:time_since_rest"), 0);
    // rust: assert_eq!(s.get("custom", "minecraft:deaths"), 2);
    // rust: assert_eq!(s.events.len(), 2);
}

pub fn phantom_group_size_follows_difficulty() void {
}
        // Expected from java.util.Random(12345): 1 + nextInt(id + 1), six draws each.
    // rust: let expected: [(i32, [i32; 6]); 4] = [
    // rust: (0, [1, 1, 1, 1, 1, 1]),
    // rust: (1, [1, 2, 2, 2, 2, 1]),
    // rust: (2, [2, 2, 1, 1, 2, 2]),
    // rust: (3, [2, 3, 4, 4, 4, 1]),
    // rust: ];
    // rust: for (id, sizes) in expected {
    // rust: let mut r = horizon_core::random::LegacyRandom::new(12345);
    // rust: let got: Vec<i32> = (0..6).map(|_| phantom_group_size(&mut r, id)).collect();
    // rust: assert_eq!(got, sizes, "difficulty {id}");
}
}

pub fn counters_events_and_dirty_entries() void {
}
    // rust: let mut s = Stats::default();
    // rust: s.custom("play_time", 1);
    // rust: s.custom("play_time", 1);
    // rust: s.add("mined", "minecraft:stone", 2);
    // rust: s.custom(&"x".repeat(100), 3);
    // rust: assert_eq!(s.get("custom", "minecraft:play_time"), 2);
    // rust: assert_eq!(s.get("mined", "minecraft:stone"), 2);
    // rust: assert_eq!(
    // rust: s.get("custom", &format!("minecraft:{}", "x".repeat(100))),
    // rust: 3
    // rust: );
    // rust: assert_eq!(s.events.len(), 4);
    // rust: assert_eq!(
    // rust: s.events[1],
    // rust: (
    // rust: "minecraft:custom".into(),
    // rust: "minecraft:play_time".into(),
    // rust: Some(1)
    // rust: )
    // rust: );
    // rust: let long = format!("minecraft:{}", "x".repeat(100));
    // rust: let sent = |v: &[(&str, &str, i32)]| -> Vec<(String, String, i32)> {
    // rust: v.iter()
    // rust: .map(|&(t, k, n)| (t.to_owned(), k.to_owned(), n))
    // rust: .collect()
}
    // rust: assert_eq!(
    // rust: s.take_dirty(),
    // rust: sent(&[
    // rust: ("minecraft:custom", "minecraft:play_time", 2),
    // rust: ("minecraft:custom", &long, 3),
    // rust: ("minecraft:mined", "minecraft:stone", 2),
    // rust: ])
    // rust: );
    // rust: assert!(s.take_dirty().is_empty());
    // rust: s.reset("mined", "minecraft:stone");
    // rust: assert_eq!(
    // rust: s.take_dirty(),
    // rust: sent(&[("minecraft:mined", "minecraft:stone", 0)])
    // rust: );
    // rust: s.mark_all_dirty();
    // rust: assert_eq!(s.take_dirty().len(), 3);
}
}
