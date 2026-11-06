//! Transpiled from Horizon Rust crate
//! Module: horizon-client_wandering_trader
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `WanderingTraderSpawner`: every 1200 ticks the spawn delay counts down;
//! when it runs out a trader may appear near the player (or the nearest
//! bell), bringing two llamas on leads, and wanders off after two days.
// use super::{Dim, Game, creatures::Creatures};
// use horizon_client::{
    // rust: mobs::{Species, leash::Holder, spawning, trader},
    // rust: save::{read_dat, write_dat},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use horizon_world::nbt::Tag;

pub const TICK_DELAY: i32 = 1200;
pub const SPAWN_DELAY: i32 = 24000;
pub const MIN_CHANCE: i32 = 25;
pub const MAX_CHANCE: i32 = 75;
pub const ATTEMPTS: i32 = 10;

/// The spawner's clock and the `WanderingTraderData` saved with the world.
    // rust: pub(super) struct Spawner {
    // rust: tick_delay: i32,
    // rust: spawn_delay: i32,
    // rust: chance: i32,
    // rust: loaded: bool,
    // rust: dirty: bool,
}
    // rust: impl Default for Spawner {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: tick_delay: TICK_DELAY,
    // rust: spawn_delay: SPAWN_DELAY,
    // rust: chance: MIN_CHANCE,
    // rust: loaded: false,
    // rust: dirty: false,
}
}
}
    // rust: impl Creatures {
    /// A fresh spawner for a newly opened world.
    // rust: pub(super) fn reset_trader(&mut self) {
    // rust: self.trader = Spawner::default();
}
}
    // rust: impl Game<'_> {
pub fn trader_path(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_root
    // rust: .join("data")
    // rust: .join("minecraft")
    // rust: .join("wandering_trader.dat")
}
pub fn load_trader_data(self: *Self) void {
}
    // rust: if self.creatures.trader.loaded {
    // rust: return;
}
    // rust: let tag = read_dat(&self.trader_path());
    // rust: let data = tag.as_ref().and_then(|t| t.get("data"));
    // rust: let get = |k: &str, d: i32| match data.and_then(|d| d.get(k)) {
    // rust: Some(Tag::Int(v)) => *v,
    // rust: _ => d,
}
    // rust: let t = &mut self.creatures.trader;
    // rust: t.spawn_delay = get("spawn_delay", SPAWN_DELAY);
    // rust: t.chance = get("spawn_chance", MIN_CHANCE);
    // rust: t.loaded = true;
}
    // rust: pub(super) fn save_wandering_trader(&mut self) {
    // rust: if !self.creatures.trader.loaded || !self.creatures.trader.dirty {
    // rust: return;
}
    // rust: let t = &self.creatures.trader;
    // rust: let tag = Tag::compound([
    // rust: (
    // rust: "data",
    // rust: Tag::compound([
    // rust: ("spawn_delay", Tag::Int(t.spawn_delay)),
    // rust: ("spawn_chance", Tag::Int(t.chance)),
    // rust: ]),
    // rust: ),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]);
    // rust: if write_dat(&self.trader_path(), tag).is_ok() {
    // rust: self.creatures.trader.dirty = false;
}
}
    /// `WanderingTraderSpawner.tick`.
    // rust: pub(super) fn tick_wandering_trader(&mut self) {
    // rust: if self.dim != Dim::Overworld || !self.ui.rules.bool("spawn_wandering_traders") {
    // rust: return;
}
    // rust: self.load_trader_data();
    // rust: self.creatures.trader.tick_delay -= 1;
    // rust: if self.creatures.trader.tick_delay > 0 {
    // rust: return;
}
    // rust: self.creatures.trader.tick_delay = TICK_DELAY;
    // rust: let t = &mut self.creatures.trader;
    // rust: t.spawn_delay -= TICK_DELAY;
    // rust: t.dirty = true;
    // rust: if t.spawn_delay > 0 {
    // rust: return;
}
    // rust: t.spawn_delay = SPAWN_DELAY;
    // rust: let chance = t.chance;
    // rust: t.chance = (chance + 25).clamp(MIN_CHANCE, MAX_CHANCE);
    // rust: if self.world.random.next_int_bound(100).unwrap_or(100) <= chance && self.spawn_trader() {
    // rust: self.creatures.trader.chance = MIN_CHANCE;
}
}
    /// `WanderingTraderSpawner.spawn`.
pub fn spawn_trader(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
        // ServerLevel.getRandomPlayer: one of the living players, drawn
        // from the level random.
    // rust: let alive: Vec<Vec3> = self
    // rust: .level_players()
    // rust: .into_iter()
    // rust: .filter(|p| p.alive)
    // rust: .map(|p| p.position)
    // rust: .collect();
    // rust: if alive.is_empty() {
    // rust: return true;
}
    // rust: let pick = self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(alive.len() as i32)
    // rust: .unwrap_or(0);
    // rust: let p = alive[pick as usize];
    // rust: if self.world.random.next_int_bound(10).unwrap_or(1) != 0 {
    // rust: return false;
}
    // rust: let player_pos = [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32];
    // rust: let reference = self.nearest_bell(player_pos, 48).unwrap_or(player_pos);
    // rust: let Some(pos) = self.find_trader_spawn_near(reference, 48) else {
    // rust: return false;
}
    // rust: if !self.trader_has_space(pos) {
    // rust: return false;
}
    // rust: let biome = self.world.chunks.get(&(pos[0] >> 4, pos[2] >> 4)).map(|c| {
    // rust: self.res
    // rust: .biomes()
    // rust: .get(c.biome(pos[0], pos[1], pos[2]))
    // rust: .name
    // rust: .clone()
    // rust: });
    // rust: if biome.is_some_and(|b| {
    // rust: self.res
    // rust: .mob_data()
    // rust: .biome_has("minecraft:without_wandering_trader_spawns", &b)
    // rust: }) {
    // rust: return false;
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let Some(id) = self.spawn_mob("minecraft:wandering_trader", at, true) else {
    // rust: return false;
}
    // rust: for _ in 0..2 {
    // rust: self.spawn_trader_llama(id, 4);
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: m.extra.ints[5] = trader::DESPAWN_DELAY;
    // rust: m.extra.point = Some([
    // rust: f64::from(reference[0]),
    // rust: f64::from(reference[1]),
    // rust: f64::from(reference[2]),
    // rust: ]);
    // rust: m.extra.home = Some(reference);
    // rust: m.extra.ints[4] = 16;
}
    // rust: true
}
    /// `tryToSpawnLlamaFor`: a trader llama near the trader, on its lead.
pub fn spawn_trader_llama(self: *Self, trader: u32, radius: i32) void {
}
    // rust: let Some(at) = self.mobs.iter().find(|m| m.id == trader).map(|m| {
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
    // rust: }) else {
    // rust: return;
}
    // rust: let Some(pos) = self.find_trader_spawn_near(at, radius) else {
    // rust: return;
}
    // rust: let spot = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: if let Some(id) = self.spawn_mob("minecraft:trader_llama", spot, false)
    // rust: && let Some(l) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
            // EntitySpawnReason.EVENT: grown up.
    // rust: l.extra.age = 0;
    // rust: l.extra.leash = Some(Holder::Mob(trader));
}
}
    /// `findSpawnPositionNear`: ten tries at a column near the reference
    /// where the trader could stand.
pub fn find_trader_spawn_near(self: *Self, reference: [i32; 3], radius: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for _ in 0..ATTEMPTS {
    // rust: let x =
    // rust: reference[0] + self.world.random.next_int_bound(radius * 2).unwrap_or(0) - radius;
    // rust: let z =
    // rust: reference[2] + self.world.random.next_int_bound(radius * 2).unwrap_or(0) - radius;
    // rust: if !self.world.loaded(x, z) {
    // rust: continue;
}
    // rust: let y = self.motion_top(x, z);
    // rust: let w = self.mob_world_base(&[]);
    // rust: if spawning::placement_ok(Species::WanderingTrader, &w, x, y, z) {
    // rust: return Some([x, y, z]);
}
}
    // rust: None
}
    /// `hasEnoughSpace`: no collision in the 2 by 3 by 2 box.
pub fn trader_has_space(self: *Self, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..=1).all(|dx| {
    // rust: (0..=2).all(|dy| {
    // rust: (0..=1).all(|dz| {
    // rust: !self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0] + dx, pos[1] + dy, pos[2] + dz))
    // rust: .full_collision
    // rust: })
    // rust: })
    // rust: })
}
    /// The closest bell (`PoiTypes.MEETING`) within `range` blocks.
pub fn nearest_bell(self: *Self, from: [i32; 3], range: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut best: Option<([i32; 3], i32)> = None;
    // rust: for x in from[0] - range..=from[0] + range {
    // rust: for z in from[2] - range..=from[2] + range {
    // rust: if !self.world.loaded(x, z) {
    // rust: continue;
}
    // rust: for y in (from[1] - range).max(self.world.bottom_y())..=from[1] + range {
    // rust: if &*self.res.facts().get(self.world.block(x, y, z)).name != "minecraft:bell" {
    // rust: continue;
}
    // rust: let d = (x - from[0]).pow(2) + (y - from[1]).pow(2) + (z - from[2]).pow(2);
    // rust: if best.is_none_or(|b| d < b.1) {
    // rust: best = Some(([x, y, z], d));
}
}
}
}
    // rust: best.map(|b| b.0)
}
}
