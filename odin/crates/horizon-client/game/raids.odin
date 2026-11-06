//! Transpiled from Horizon Rust crate
package horizon_client_raids

import "core:fmt"
import "core:mem"
import "core:math"

// Pillager patrols (`PatrolSpawner`), the raid omen, and raids (`Raids`):
// their waves, boss bar, victory and the raiders' bookkeeping. The rules are
// `horizon_client::patrol` and `horizon_client::raid`; this is the game's
// side of them.
// use super::{Dim, Game};
// use horizon_client::mobs::villager as mobs_villager;
// use horizon_client::{
    // rust: effects::{EffectInstance, OmenTick},
    // rust: mobs::{
    // rust: Mob, Species, raider,
    // rust: spawn_rules::{self, SpawnLevel},
    // rust: spawn_selection::{Heightmap, NaturalLevel},
    // rust: spawning,
    // rust: },
    // rust: patrol::{GameplayAttributes, Member, PatrolLevel, PatrolSpawner},
    // rust: raid::{self, Action, BarName, RaidLevel, RaidPlayer, RaiderInfo, RaiderType, Raids, Spawn},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use horizon_world::nbt::Tag;
// use std::collections::{HashMap, HashSet};

// Patrol and raid state owned by the game.
    // rust: pub(super) struct Raiding {
    // rust: patrol: PatrolSpawner,
    // rust: siege: Siege,
    // The raids of the dimension the player is in, and that dimension.
    // rust: raids: Raids,
    // rust: loaded: Option<Dim>,
    // `ServerPlayer.raidOmenPosition` (`raid_omen_position`), read from the
    // player data on first use.
    // rust: omen_position: Option<[i32; 3]>,
    // rust: omen_loaded: bool,
    // The last raider hurt each raid's bar has seen (`Raider.hurtServer`).
    // rust: bar_hurts: HashMap<i32, u64>,
    // rust: attributes: Option<std::sync::Arc<GameplayAttributes>>,
    // Beds near each raid's centre, rescanned now and then (`HOME` points
    // of interest for `RaiderMoveThroughVillageGoal`).
    // rust: homes: HashMap<i32, (i64, std::sync::Arc<Vec<[i32; 3]>>)>,
}

// `VillageSiege`: whether tonight is a siege, whether the spot is chosen,
// and the zombies still to spawn there.
Siege :: struct {
    tonight: bool,
    set_up: bool,
    zombies_to_spawn: i32,
    next_spawn_time: i32,
    spot: [i32,
}

    // rust: impl Raiding {
    // Exchange the level-held parts (`ServerLevel.getRaids`) with another
    // level's (game/levels.rs).
    // rust: pub(super) fn swap_level(&mut self, other: &mut Self) {
    // rust: std::mem::swap(&mut self.raids, &mut other.raids);
    // rust: std::mem::swap(&mut self.loaded, &mut other.loaded);
    // rust: std::mem::swap(&mut self.bar_hurts, &mut other.bar_hurts);
    // rust: std::mem::swap(&mut self.homes, &mut other.homes);
}
}

// `SectionPos` of a block position.
    // rust: pub(super) fn section(p: [i32; 3]) -> (i32, i32, i32) {
    // rust: (p[0] >> 4, p[1] >> 4, p[2] >> 4)
}
// `PoiManager.DistanceTracker`: sections from the nearest village centre,
// 7 when farther than 6.
    // rust: pub(super) fn sections_to_village(centers: &HashSet<(i32, i32, i32)>, at: (i32, i32, i32)) -> i32 {
    // rust: centers
    // rust: .iter()
    // rust: .map(|c| {
    // rust: (c.0 - at.0)
    // rust: .abs()
    // rust: .max((c.1 - at.1).abs())
    // rust: .max((c.2 - at.2).abs())
    // rust: })
    // rust: .min()
    // rust: .map_or(7, |d| d.min(7))
}

// The level as a raid sees it, with this tick's village data.
Lvl :: struct {
    game: ^'a Game<'g>,
    difficulty: i32,
    centers: ^'a HashSet<(i32,
}
    // rust: impl RaidLevel for Lvl<'_, '_> {
difficulty :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.difficulty
}
has_chunk_at :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.game.world.chunks.contains_key(&(p[0] >> 4, p[2] >> 4))
}
has_chunks_at :: proc(self: ^Self, x0: i32, z0: i32, x1: i32, z1: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (x0 >> 4..=x1 >> 4)
    // rust: .all(|cx| (z0 >> 4..=z1 >> 4).all(|cz| self.game.world.chunks.contains_key(&(cx, cz))))
}
sections_to_village :: proc(self: ^Self, p: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: sections_to_village(self.centers, section(p))
}
surface_height :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.game.surface_height(x, z)
}
is_position_entity_ticking :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.has_chunk_at(p)
}
ravager_can_spawn :: proc(self: ^Self, z]: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let g = self.game;
    // rust: let w = g.mob_world_base(&[]);
    // rust: spawn_rules::is_spawn_position_ok(Species::Ravager, &w, x, y, z)
    // rust: || w.block_name(x, y - 1, z) == "minecraft:snow"
    // rust: && g.res.facts().is_air(g.world.block(x, y, z))
}
player :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
        // The first player in the level: a server has no player of its own.
    // rust: let p = self.game.level_players().into_iter().next()?;
    // rust: Some(RaidPlayer {
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: block: block_of(p.position),
    // rust: alive: p.alive,
    // rust: })
}
}

// The game level as the patrol spawner reads it.
PatrolCx :: struct {
    level: super::natural_spawning::GameLevel<'a,
    centers: HashSet<(i32,
    can_spawn: ^'h dyn Fn(^Game,
}
    // rust: impl SpawnLevel for PatrolCx<'_, '_, '_> {
state :: proc(self: ^Self, x: i32, y: i32, z: i32) -> h {
    // Ported from Horizon
    return {}
}
    // rust: self.level.state(x, y, z)
}
facts :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.level.facts()
}
mob_data :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.level.mob_data()
}
block_tag :: proc(self: ^Self, tag: string, block: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.level.block_tag(tag, block)
}
biome_tag :: proc(self: ^Self, tag: string, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.level.biome_tag(tag, x, y, z)
}
sky_light :: proc(self: ^Self, x: i32, y: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.level.sky_light(x, y, z)
}
block_light :: proc(self: ^Self, x: i32, y: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.level.block_light(x, y, z)
}
sky_darken :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: SpawnLevel::sky_darken(&self.level)
}
thundering :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.level.thundering()
}
sea_level :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.level.sea_level()
}
world_surface :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.level.world_surface(x, z)
}
peaceful :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.level.peaceful()
}
dimension :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.level.dimension()
}
surface_slime_chance :: proc(self: ^Self, x: i32, y: i32, z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.level.surface_slime_chance(x, y, z)
}
world_seed :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.level.world_seed()
}
player_near :: proc(self: ^Self, x: f64, y: f64, z: f64, distance: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.level.player_near(x, y, z, distance)
}
}
    // rust: impl PatrolLevel for PatrolCx<'_, '_, '_> {
spawn_patrols :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.level.game.ui.rules.bool("spawn_patrols")
}
bright_outside :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.level.game.dim == Dim::Overworld && self.level.game.sky_darken() < 4
}
    // `PatrolSpawner.tick` picks from `level.players()`: the local player
    // and every guest in the level.
patrol_players :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.level
    // rust: .players
    // rust: .iter()
    // rust: .map(|p| (block_of(p.position), p.spectator))
    // rust: .collect()
}
sections_to_village :: proc(self: ^Self, pos: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: sections_to_village(&self.centers, section(pos))
}
has_chunk :: proc(self: ^Self, cx: i32, cz: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.level.game.world.chunks.contains_key(&(cx, cz))
}
can_pillager_patrol_spawn :: proc(self: ^Self, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (self.can_spawn)(self.level.game, pos)
}
effective_difficulty :: proc(self: ^Self, pos: [i32; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.level
    // rust: .game
    // rust: .local_difficulty([f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])])
    // rust: .effective
}
motion_blocking_no_leaves :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.level
    // rust: .heightmap(Heightmap::MotionBlockingNoLeaves, x, z)
}
}

block_of :: proc(p: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32]
}

    // rust: impl Game<'_> {
    // `Heightmap.Types.WORLD_SURFACE`: the first free block above the
    // highest non-air one.
    // rust: pub(super) fn surface_height(&self, x: i32, z: i32) -> i32 {
    // rust: let top = if self.dim == Dim::Nether { 127 } else { 319 };
    // rust: (self.world.bottom_y()..=top)
    // rust: .rev()
    // rust: .find(|&y| !self.res.facts().is_air(self.world.block(x, y, z)))
    // rust: .map_or(self.world.bottom_y(), |y| y + 1)
}
    // Every claimed village point of interest (job sites, beds, bells).
village_pois :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: Vec<[i32; 3]> = Vec::new();
    // rust: for m in &self.mobs {
    // rust: if m.species() != Species::Villager || !m.alive() {
    // rust: continue;
}
    // rust: for p in [m.extra.home, m.extra.bed, m.extra.meeting]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: if !out.contains(&p) {
    // rust: out.push(p);
}
}
}
    // rust: out
}
    // rust: pub(super) fn difficulty_id(&self) -> i32 {
//         use horizon_world::food::Difficulty;
    // rust: match self.world.health_rules.difficulty {
    // rust: Difficulty::Peaceful => 0,
    // rust: Difficulty::Easy => 1,
    // rust: Difficulty::Normal => 2,
    // rust: Difficulty::Hard => 3,
}
}
player_block :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.player.as_ref().map(|p| block_of(p.position))
}
    // `dimensions/<dimension>/data/minecraft/raids.dat`: each dimension
    // keeps its own raids.
raids_path :: proc(self: ^Self, dim: Dim) -> s {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::save::dimension_dir(&self.world_root, dim.id())
    // rust: .join("data/minecraft/raids.dat")
}
    // The raids of the player's dimension (the previous one saved first).
load_raids :: proc(self: ^Self) {
}
    // rust: if self.raiding.loaded == Some(self.dim) {
    // rust: return;
}
    // rust: if self.raiding.loaded.is_some() {
    // rust: self.save_raids();
}
    // rust: self.raiding.loaded = Some(self.dim);
    // rust: self.raiding.bar_hurts.clear();
    // rust: self.raiding.homes.clear();
    // rust: let seed = self.world.random.next_long();
    // rust: self.raiding.raids = match horizon_client::save::read_dat(&self.raids_path(self.dim))
    // rust: .and_then(|tag| tag.get("data").cloned())
    // rust: {
    // rust: Some(data) => Raids::from_nbt(&data, seed),
    // rust: None => Raids::default(),
}
}
    // `Raids` as its dimension's `raids.dat`, when it changed.
    // rust: pub(super) fn save_raids(&mut self) {
    // rust: let Some(dim) = self.raiding.loaded else {
    // rust: return;
}
    // rust: if !self.raiding.raids.dirty || self.remote.is_some() {
    // rust: return;
}
    // rust: let tag = horizon_world::nbt::Tag::compound([
    // rust: ("data", self.raiding.raids.to_nbt()),
    // rust: (
    // rust: "DataVersion",
    // rust: horizon_world::nbt::Tag::Int(horizon_world::DATA_VERSION),
    // rust: ),
    // rust: ]);
    // rust: if horizon_client::save::write_dat(&self.raids_path(dim), tag).is_ok() {
    // rust: self.raiding.raids.dirty = false;
}
    // rust: self.save_raid_omen_position();
}
    // `ServerPlayer.raidOmenPosition` from the player data.
load_raid_omen_position :: proc(self: ^Self) {
}
    // rust: if self.raiding.omen_loaded {
    // rust: return;
}
    // rust: self.raiding.omen_loaded = true;
    // rust: self.raiding.omen_position = match self
    // rust: .level
    // rust: .player_extra
    // rust: .as_ref()
    // rust: .and_then(|p| p.get("raid_omen_position"))
    // rust: {
    // rust: Some(horizon_world::nbt::Tag::IntArray(v)) if v.len() == 3 => Some([v[0], v[1], v[2]]),
    // rust: _ => None,
}
}
    // Writes `raid_omen_position` into the player data being saved.
save_raid_omen_position :: proc(self: ^Self) {
}
    // rust: if !self.raiding.omen_loaded {
    // rust: return;
}
    // rust: let extra = self
    // rust: .level
    // rust: .player_extra
    // rust: .get_or_insert_with(|| horizon_world::nbt::Tag::Compound(Default::default()));
    // rust: if let horizon_world::nbt::Tag::Compound(map) = extra {
    // rust: match self.raiding.omen_position {
    // rust: Some(p) => {
    // rust: map.insert(
    // rust: "raid_omen_position".into(),
    // rust: horizon_world::nbt::Tag::IntArray(p.to_vec()),
    // rust: );
}
    // rust: None => {
    // rust: map.remove(&"raid_omen_position".into());
}
}
}
}
gameplay_attributes :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: if self.raiding.attributes.is_none() {
    // rust: self.raiding.attributes = Some(std::sync::Arc::new(GameplayAttributes::load(
    // rust: &self.options.resources,
    // rust: )));
}
    // rust: self.raiding.attributes.clone().unwrap_or_default()
}
    // A boolean gameplay attribute at a position (dimension, biome, then
    // the timelines at the overworld clock).
gameplay_attribute :: proc(self: ^Self, key: string, at: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let attributes = self.gameplay_attributes();
    // rust: let biome = self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(at[0] >> 4, at[2] >> 4))
    // rust: .map(|c| {
    // rust: self.res
    // rust: .biomes()
    // rust: .get(c.biome(at[0], at[1], at[2]))
    // rust: .name
    // rust: .clone()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: attributes.value(key, self.dim.id(), &biome, self.world.day_time)
}

    // `BadOmenMobEffect` and `RaidOmenMobEffect.applyEffectTick` for the
    // player's effect tick: Bad Omen inside a village becomes Raid Omen,
    // whose last tick starts or extends a raid where it began.
    // rust: pub(super) fn omen_tick(&mut self, e: &EffectInstance) -> OmenTick {
    // rust: if self.spectator() || self.player.is_none() {
    // rust: return OmenTick::Continue;
}
    // rust: let Some(pos) = self.player_block() else {
    // rust: return OmenTick::Continue;
}
    // rust: self.load_raids();
    // rust: self.load_raid_omen_position();
    // rust: match e.id {
    // rust: "bad_omen" => {
    // rust: if self.difficulty_id() != 0
    // rust: && sections_to_village(&self.village_centers(), section(pos)) <= 1
    // rust: && self
    // rust: .raiding
    // rust: .raids
    // rust: .nearby(pos)
    // rust: .is_none_or(|(_, r)| r.omen_level < raid::MAX_OMEN_LEVEL)
    // rust: {
    // rust: self.raiding.omen_position = Some(pos);
    // rust: return OmenTick::Add(EffectInstance::new("raid_omen", 600, e.amplifier));
}
    // rust: OmenTick::Continue
}
    // rust: "raid_omen" => match self.raiding.omen_position.take() {
    // rust: Some(at) => {
    // rust: self.create_or_extend_raid(at, Some(e.amplifier));
    // rust: OmenTick::Remove
}
    // rust: None => OmenTick::Continue,
    // rust: },
    // rust: _ => OmenTick::Continue,
}
}
    // The Raid Omen sound when the effect is first added.
    // rust: pub(super) fn raid_omen_added(&mut self) {
    // rust: let eye = self.eye_position().unwrap_or_default();
    // rust: self.audio
    // rust: .play("minecraft:event.mob_effect.raid_omen", Some(eye), 1.0, 1.0);
}
    // `Raids.createOrExtendRaid`: not for spectators, with the `raids` rule
    // and where raids may start; the raid centres on the occupied village
    // points of interest within 64 blocks.
create_or_extend_raid :: proc(self: ^Self, at: [i32; 3], amplifier: Maybe(i32)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.spectator()
    // rust: || !self.ui.rules.bool("raids")
    // rust: || !self.gameplay_attribute(horizon_client::patrol::CAN_START_RAID, at)
    // rust: {
    // rust: return None;
}
    // rust: self.load_raids();
    // rust: let center = raid::raid_center(at, &self.village_pois());
    // rust: let seed = self.world.random.next_long();
    // rust: let difficulty = self.difficulty_id();
    // rust: let (id, triggered) = self
    // rust: .raiding
    // rust: .raids
    // rust: .create_or_extend(center, difficulty, amplifier, seed);
    // rust: if triggered {
    // rust: self.award_custom_stat("raid_trigger", 1);
    // rust: self.trigger_player("minecraft:voluntary_exile");
    // rust: self.native_raid_state_change(id, center, "triggered");
}
    // rust: Some(id)
}
    // `ServerLevel.getRaidAt`.
    // rust: pub(super) fn raiding_nearby(&self, at: [i32; 3]) -> Option<i32> {
    // rust: self.raiding.raids.nearby(at).map(|(id, _)| id)
}
    // rust: pub(super) fn raid_started(&self, id: i32) -> bool {
    // rust: self.raiding.raids.get(id).is_some_and(|r| r.started)
}
    // `/raid start`: a raid in the local village at the given omen level.
    // rust: pub(super) fn raid_command_create(&mut self, at: [i32; 3], omen_level: i32) -> bool {
    // rust: self.load_raids();
    // rust: let Some(id) = self.create_or_extend_raid(at, None) else {
    // rust: return false;
}
    // rust: if let Some(r) = self.raiding.raids.get_mut(id) {
    // rust: r.omen_level = omen_level;
}
    // rust: self.raiding.raids.dirty = true;
    // rust: true
}
    // rust: pub(super) fn raid_command_stop(&mut self, id: i32) {
    // rust: if let Some(r) = self.raiding.raids.get_mut(id) {
    // rust: r.stop();
    // rust: let center = r.center;
    // rust: self.native_raid_state_change(id, center, "stopped");
}
}
    // rust: pub(super) fn raid_set_omen(&mut self, id: i32, level: i32) -> i32 {
    // rust: let Some(r) = self.raiding.raids.get_mut(id) else {
    // rust: return 0;
}
    // rust: std::mem::replace(&mut r.omen_level, level)
}
    // rust: pub(super) fn raid_glow(&mut self, id: i32) {
    // rust: for m in &mut self.mobs {
    // rust: if raider::state(m).is_some_and(|s| s.raid_id == Some(id)) {
    // rust: m.add_effect("glowing", 1000, 1);
}
}
}
    // The `/raid check` summary line.
    // rust: pub(super) fn raid_status_text(&self, id: i32) -> String {
    // rust: let Some(r) = self.raiding.raids.get(id) else {
    // rust: return String::new();
}
    // rust: let members: Vec<&Mob> = self.raid_members(id).collect();
    // rust: let health: f32 = members.iter().fold(0.0, |a, m| a + m.health);
    // rust: format!(
    // rust: "Num groups spawned: {} Raid omen level: {} Num mobs: {} Raid health: {} / {}",
    // rust: r.groups_spawned,
    // rust: r.omen_level,
    // rust: members.len(),
    // rust: health,
    // rust: r.total_health
    // rust: )
}
    // A raid's members (`groupRaiderMap`): the living raiders it counts.
raid_members :: proc(self: ^Self, id: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.mobs.iter().filter(move |m| {
    // rust: m.alive() && !m.removed && raider::state(m).is_some_and(|s| s.raid_id == Some(id))
    // rust: })
}
    // `getHealthOfLivingRaiders`, leaving out one raider.
raid_living_health :: proc(self: ^Self, id: i32, except: Maybe(u32)) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.raid_members(id)
    // rust: .filter(|m| Some(m.id) != except)
    // rust: .fold(0.0, |a, m| a + m.health)
}
    // The bar update the last hurt raider of a raid asked for
    // (`Raider.hurtServer` runs `updateBossbar` before the damage).
flush_raid_bar :: proc(self: ^Self, id: i32) {
}
    // rust: let seen = self.raiding.bar_hurts.get(&id).copied().unwrap_or(0);
    // rust: let last = self
    // rust: .raid_members(id)
    // rust: .filter_map(|m| raider::state(m).map(|s| (s.hurt_seq, m.id, s.pre_hurt_health)))
    // rust: .filter(|h| h.0 > seen)
    // rust: .max_by_key(|h| h.0);
    // rust: let Some((seq, mob, before)) = last else {
    // rust: return;
}
    // rust: let living = self.raid_living_health(id, Some(mob)) + before;
    // rust: if let Some(r) = self.raiding.raids.get_mut(id) {
    // rust: r.update_bossbar(living);
}
    // rust: self.raiding.bar_hurts.insert(id, seq);
}

    // The members of every raid, for `Raids.tick`.
raider_infos :: proc(self: ^Self) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: HashMap<i32, Vec<RaiderInfo>> = HashMap::new();
    // rust: for m in &self.mobs {
    // rust: if !m.alive() || m.removed {
    // rust: continue;
}
    // rust: let Some(s) = raider::state(m) else { continue };
    // rust: let Some(id) = s.raid_id else { continue };
    // rust: let position = block_of(m.position);
    // rust: out.entry(id).or_default().push(RaiderInfo {
    // rust: id: m.id,
    // rust: wave: s.wave,
    // rust: health: m.health,
    // rust: position,
    // rust: tick_count: m.age as i32,
    // rust: no_action_time: m.ai.no_action_time,
    // rust: ticks_outside: s.ticks_outside_raid,
    // rust: removed: false,
    // rust: other_dimension: false,
    // rust: in_level: true,
    // rust: patrol_leader: s.patrol_leader,
    // rust: });
}
    // rust: out
}
    // Raiders loaded with a `RaidId` join their raid
    // (`readAdditionalSaveData`: `addWaveMob` without counting health, and
    // the wave's leader).
register_loaded_raiders :: proc(self: ^Self) {
}
    // rust: let pending: Vec<(u32, i32, i32, f32, bool)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive() && !m.removed)
    // rust: .filter_map(|m| {
    // rust: let s = raider::state(m)?;
    // rust: (!s.registered).then_some(())?;
    // rust: Some((m.id, s.raid_id?, s.wave, m.health, s.patrol_leader))
    // rust: })
    // rust: .collect();
    // rust: for (mob, id, wave, health, leader) in pending {
    // rust: let living = self.raid_living_health(id, None);
    // rust: let known = match self.raiding.raids.get_mut(id) {
    // rust: Some(r) => {
    // rust: r.add_wave_mob(health, false, living);
    // rust: if leader {
    // rust: r.set_leader(wave, mob);
}
    // rust: self.raiding.raids.dirty = true;
    // rust: true
}
    // rust: None => false,
}
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: let s = raider::state_mut(m);
    // rust: s.registered = true;
    // rust: if !known {
    // rust: s.raid_id = None;
}
}
}
}
    // `ServerLevel.tick` for the raids and their raiders.
    // rust: pub(super) fn tick_raids(&mut self) {
    // rust: if self.remote.is_some() {
    // rust: return;
}
    // rust: self.load_raids();
    // rust: self.register_loaded_raiders();
    // rust: for id in self.raiding.raids.ids() {
    // rust: self.flush_raid_bar(id);
}
    // rust: let centers = self.village_centers();
    // rust: let infos = self.raider_infos();
    // rust: let old_states: HashMap<_, _> = self
    // rust: .raiding
    // rust: .raids
    // rust: .ids()
    // rust: .into_iter()
    // rust: .filter_map(|id| {
    // rust: self.raiding
    // rust: .raids
    // rust: .get(id)
    // rust: .map(|r| (id, (r.status, r.center)))
    // rust: })
    // rust: .collect();
    // rust: let mut raids = std::mem::take(&mut self.raiding.raids);
    // rust: let actions = {
    // rust: let lvl = Lvl {
    // rust: game: self,
    // rust: difficulty: self.difficulty_id(),
    // rust: centers: &centers,
}
    // rust: let members = |id: i32| infos.get(&id).cloned().unwrap_or_default();
    // rust: raids.tick(&lvl, self.ui.rules.bool("raids"), &members)
}
    // rust: self.raiding.raids = raids;
    // rust: for (id, (old, _)) in old_states {
    // rust: if let Some(r) = self.raiding.raids.get(id)
    // rust: && r.status != old
    // rust: {
    // rust: self.native_raid_state_change(id, r.center, r.status.name());
}
}
    // rust: for (id, action) in actions {
    // rust: self.apply_raid_action(id, action);
}
    // rust: self.sync_raiders(&centers);
    // rust: let infos = self.raider_infos();
    // rust: self.sync_villager_raids(&infos);
}
apply_raid_action :: proc(self: ^Self, id: i32, action: Action) {
}
    // rust: match action {
    // rust: Action::Spawn { pos, wave, spawns } => self.spawn_wave(id, pos, wave, &spawns),
    // rust: Action::Horn { pos, seed } => self.raid_horn(id, pos, seed),
    // rust: Action::Remove { id: mob } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: let s = raider::state_mut(m);
    // rust: s.raid_id = None;
    // rust: s.active_raid = false;
}
}
    // rust: Action::SetOutside { id: mob, ticks } => {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) {
    // rust: raider::state_mut(m).ticks_outside_raid = ticks;
}
}
            // Raid.tick on a victory: each hero who is still alive.
    // rust: Action::Victory { heroes, amplifier } => self.for_each_player(|g| {
    // rust: if heroes.contains(&g.acting_uuid()) && !g.spectator() {
    // rust: let mut effect =
    // rust: EffectInstance::new("hero_of_the_village", raid::HERO_DURATION, amplifier);
    // rust: effect.visible = false;
    // rust: g.potions.effects.add(effect);
    // rust: g.award_custom_stat("raid_win", 1);
    // rust: g.trigger_player("minecraft:hero_of_the_village");
}
    // rust: }),
}
}
    // `Raid.playSound`: the horn, 13 blocks from each player toward the wave,
    // for everyone within 64 blocks or in the raid. One seed for every packet
    // (`SoundSource.NEUTRAL`, volume 64, pitch 1).
raid_horn :: proc(self: ^Self, id: i32, pos: [i32; 3], seed: i64) {
}
    // rust: let in_raid = self.raiding.raids.get(id).is_some_and(|r| r.bar.player);
    // rust: let (rx, rz) = (f64::from(pos[0]) + 0.5, f64::from(pos[2]) + 0.5);
        // The raid tracks one participant (`bar.player`): the first player in
        // the level. Everyone else is heard by distance alone.
    // rust: let local_first = self.player.is_some();
    // rust: if let Some(p) = self.player.as_ref()
    // rust: && let Some(at) = raid::horn_at(
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: rx,
    // rust: rz,
    // rust: in_raid && local_first,
    // rust: )
    // rust: {
            // This window only. A positioned `play` would be broadcast to
            // every guest on top of the packet each of them is sent.
    // rust: let capture = self.audio.capture.take();
    // rust: let neutral = horizon_client::settings::SOUND_SOURCES
    // rust: .iter()
    // rust: .position(|s| *s == "neutral")
    // rust: .unwrap_or(0);
    // rust: self.audio
    // rust: .play_on(neutral, "minecraft:event.raid.horn", Some(at), 64.0, 1.0);
    // rust: self.audio.capture = capture;
}
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return;
}
    // rust: let dim = host.hub.config.dimension.clone();
    // rust: let spotted: Vec<(u32, [f64; 3], bool)> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .map(|g| (g.conn, g.position, g.placed && g.dimension == dim))
    // rust: .collect();
    // rust: let neutral = horizon_client::settings::SOUND_SOURCES
    // rust: .iter()
    // rust: .position(|s| *s == "neutral")
    // rust: .unwrap_or(0) as i32;
    // rust: let mut first_guest = !local_first;
    // rust: for (conn, position, here) in spotted {
    // rust: if !here {
    // rust: continue;
}
    // rust: let participating = std::mem::replace(&mut first_guest, false) && in_raid;
    // rust: let Some(at) = raid::horn_at(position, rx, rz, participating) else {
    // rust: continue;
}
    // rust: let packet =
    // rust: host.hub
    // rust: .sound_packet("minecraft:event.raid.horn", at, 64.0, 1.0, neutral, seed);
    // rust: host.hub.send_to(conn, &packet);
}
}
    // `Raid.spawnGroup`: a wave of raiders at `pos`, the leader wearing the
    // banner, ravagers carrying their riders.
spawn_wave :: proc(self: ^Self, raid_id: i32, pos: [i32; 3], wave: i32, spawns: ^[Spawn]) {
}
    // rust: let odds = self
    // rust: .raiding
    // rust: .raids
    // rust: .get(raid_id)
    // rust: .map_or(0.0, raid::Raid::enchant_odds);
    // rust: for sp in spawns {
    // rust: let Some(id) = self.spawn_raider(sp.kind, pos, raid_id, wave, sp.leader, odds) else {
    // rust: continue;
}
    // rust: if sp.leader
    // rust: && let Some(r) = self.raiding.raids.get_mut(raid_id)
    // rust: {
    // rust: r.set_leader(wave, id);
}
    // rust: if let Some(kind) = sp.rider
    // rust: && let Some(rider) = self.spawn_raider(kind, pos, raid_id, wave, false, odds)
    // rust: {
    // rust: self.mount_mob(rider, id);
}
}
    // rust: self.native_raid_spawn_wave(raid_id, pos, wave, spawns.len());
}
    // `Raid.joinRaid` for a new raider: placed at the block's centre one
    // above, finalized for an event, its raid buffs applied.
    // rust: fn spawn_raider(
    // rust: &mut self,
    // rust: kind: RaiderType,
    // rust: pos: [i32; 3],
    // rust: raid_id: i32,
    // rust: wave: i32,
    // rust: leader: bool,
    // rust: odds: f32,
    // rust: ) -> Option<u32> {
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 1.0,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: let id = self.spawn_event_mob(kind.entity(), at, leader, raider::Reason::Event)?;
    // rust: let m = self.mobs.iter_mut().find(|m| m.id == id)?;
    // rust: let s = raider::state_mut(m);
    // rust: s.raid_id = Some(raid_id);
    // rust: s.wave = wave;
    // rust: s.can_join_raid = true;
    // rust: s.ticks_outside_raid = 0;
    // rust: s.active_raid = true;
    // rust: s.registered = true;
    // rust: m.on_ground = true;
    // rust: self.apply_raid_buffs(id, kind, wave, odds);
    // rust: Some(id)
}
    // `EntityType.create` then `finalizeSpawn` for a patrol or a raid: the
    // mob keeps the default rotation; a leader is set before finalizing so
    // it wears the banner.
    // rust: fn spawn_event_mob(
    // rust: &mut self,
    // rust: kind: &str,
    // rust: at: [f64; 3],
    // rust: leader: bool,
    // rust: reason: raider::Reason,
    // rust: ) -> Option<u32> {
    // rust: let t = self.res.mob_types().get(kind).cloned()?;
    // rust: self.next_entity += 1;
    // rust: let mut mob = Mob::new(self.next_entity, t, Vec3::new(at[0], at[1], at[2]), 0.0);
    // rust: if leader {
    // rust: raider::set_patrol_leader(&mut mob, true);
    // rust: if reason == raider::Reason::Patrol {
                // findPatrolTarget runs before the mob is placed: the target
                // is around the world origin.
    // rust: raider::find_patrol_target_from(&mut mob, [0, 0, 0]);
}
}
    // rust: let facts = self.biome_facts(
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: );
    // rust: let difficulty = self.local_difficulty(at);
    // rust: spawning::finalize(&mut mob, &facts, &difficulty);
    // rust: raider::finalize(&mut mob, reason);
    // rust: let id = mob.id;
    // rust: self.mobs.push(mob);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
    // rust: self.enchant_spawn_equipment(id);
    // rust: self.halloween_spawn_head(id);
    // rust: Some(id)
}

    // Per-tick raid bookkeeping of every raider (and the ravagers they
    // ride): the raid's state for the goals, joining and recruiting,
    // the banner of a fallen captain, idle time.
sync_raiders :: proc(self: ^Self, centers: ^HashSet<(i32) {
}
    // rust: let now = self.world.game_time;
    // rust: let golems: HashSet<u32> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.species() == Species::IronGolem)
    // rust: .map(|m| m.id)
    // rust: .collect();
        // Living leaders and carried riders.
    // rust: let mut leaders: HashSet<(i32, i32)> = HashSet::new();
    // rust: let mut ridden: HashSet<u32> = HashSet::new();
    // rust: let mut positions: Vec<(u32, Vec3, bool)> = Vec::new();
    // rust: for m in &self.mobs {
    // rust: let Some(s) = raider::state(m) else { continue };
    // rust: if !m.alive() {
    // rust: continue;
}
    // rust: if let (Some(id), true) = (s.raid_id, s.patrol_leader) {
    // rust: leaders.insert((id, s.wave));
}
    // rust: if let Some(v) = m.extra.mount {
    // rust: ridden.insert(v);
}
    // rust: positions.push((m.id, m.position, s.active_raid));
}
    // rust: let banners: Vec<(usize, u32, Vec3)> = self
    // rust: .dropped
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, e)| {
    // rust: &*e.stack.item == raider::BANNER
    // rust: && e.stack.data().is_some_and(|d| d.ominous_banner)
    // rust: && e.pickup_delay == 0
    // rust: })
    // rust: .map(|(i, e)| (i, e.id, e.position))
    // rust: .collect();
    // rust: let mut taken: Vec<usize> = Vec::new();
    // rust: let mut collectors: Vec<(usize, u32)> = Vec::new();
    // rust: let mut recruit: Vec<(i32, Vec3)> = Vec::new();
    // rust: let mut joins: Vec<(u32, i32, f32)> = Vec::new();
    // rust: let mut new_leaders: Vec<(i32, i32, u32)> = Vec::new();
    // rust: let homes = self.raid_homes();
    // rust: for m in &mut self.mobs {
    // rust: let species = m.species();
    // rust: if !raider::is_raider(species) {
    // rust: continue;
}
    // rust: let alive = m.alive();
    // rust: let position = m.position;
    // rust: let block = block_of(position);
    // rust: let in_village = sections_to_village(centers, section(block)) <= 1;
    // rust: let has_rider = ridden.contains(&m.id);
    // rust: let target_golem = matches!(m.ai.target, Some(horizon_client::mobs::Who::Mob(t)) if golems.contains(&t));
    // rust: let target_player = m.ai.target == Some(horizon_client::mobs::Who::Player);
    // rust: let (health, range) = (m.health, m.attrs.follow_range);
    // rust: let raids = &mut self.raiding.raids;
    // rust: let s = m.extra.raider.get_or_insert_with(Box::default);
    // rust: s.rider = has_rider;
    // rust: s.in_village = in_village;
            // Vindicator.customServerAiStep: `ServerLevel.isRaided`.
    // rust: s.raided = species == Species::Vindicator && raids.nearby(block).is_some();
    // rust: if s.raid_id.is_some_and(|id| raids.get(id).is_none()) {
    // rust: s.raid_id = None;
    // rust: s.ticks_outside_raid = 0;
}
    // rust: match s.raid_id.and_then(|id| raids.get(id)) {
    // rust: Some(r) => {
    // rust: s.active_raid = r.active;
    // rust: s.raid_over = r.is_over();
    // rust: s.raid_loss = r.is_loss();
    // rust: s.raid_center = r.center;
    // rust: s.homes = s.raid_id.and_then(|id| homes.get(&id).cloned());
}
    // rust: None => {
    // rust: s.active_raid = false;
    // rust: s.raid_over = false;
    // rust: s.raid_loss = false;
    // rust: s.homes = None;
    // rust: s.banner_at = None;
}
}
    // rust: if !alive {
    // rust: continue;
}
            // Raider.aiStep: a raider fighting a player or golem in a raid is
            // never idle. The per-tick growth (+1 serverAiStep, +2
            // Raider.updateNoActionTime) is added by the mob's own step.
    // rust: if s.raid_id.is_some() && (target_player || target_golem) {
    // rust: m.ai.no_action_time = 0;
}
            // Raider.aiStep: join the raid the raider stands in.
    // rust: if s.raid_id.is_none()
    // rust: && s.can_join_raid
    // rust: && now % 20 == 0
    // rust: && m.ai.no_action_time <= 2400
    // rust: && let Some((id, _)) = raids.nearby(block)
    // rust: {
    // rust: joins.push((m.id, id, health));
}
            // PathfindToRaidGoal.tick: recruitNearby, only while the goal runs.
    // rust: if std::mem::take(&mut s.recruit_due)
    // rust: && s.active_raid
    // rust: && let Some(id) = s.raid_id
    // rust: {
    // rust: recruit.push((id, position));
}
            // ObtainRaidLeaderBannerGoal.
    // rust: s.banner_at = None;
    // rust: if let Some(id) = s.raid_id
    // rust: && s.active_raid
    // rust: && !s.raid_over
    // rust: && raider::can_be_leader(species)
    // rust: && m.extra.head.as_deref() != Some(raider::BANNER)
    // rust: && raids.get(id).is_some_and(|r| r.leader(s.wave).is_none())
    // rust: && !leaders.contains(&(id, s.wave))
    // rust: {
    // rust: let in_reach = |(i, _, p): &&(usize, u32, Vec3)| {
    // rust: !taken.contains(i)
    // rust: && (p.x - position.x).abs() <= range
    // rust: && (p.z - position.z).abs() <= range
    // rust: && (p.y - position.y).abs() <= 8.0
}
    // rust: let by_distance = |a: &&(usize, u32, Vec3), b: &&(usize, u32, Vec3)| {
    // rust: a.2.distance_squared(position)
    // rust: .total_cmp(&b.2.distance_squared(position))
}
                // The unreachable cache only picks the navigation target;
                // a banner next to the raider is still picked up.
    // rust: let near = banners
    // rust: .iter()
    // rust: .filter(in_reach)
    // rust: .filter(|(_, item, _)| {
    // rust: !s.unreachable_banners
    // rust: .iter()
    // rust: .any(|&(b, until)| b == *item && now < until)
    // rust: })
    // rust: .min_by(by_distance);
    // rust: let nearest = banners.iter().filter(in_reach).min_by(by_distance);
    // rust: let adjacent =
    // rust: nearest.filter(|(_, _, p)| p.distance_squared(position) < 1.414 * 1.414);
    // rust: if let Some((i, item, p)) = adjacent.or(near) {
    // rust: s.banner_at = Some([p.x, p.y, p.z]);
    // rust: s.banner_item = *item;
    // rust: if p.distance_squared(position) < 1.414 * 1.414 {
                        // pickUpItem: the banner becomes the wave's leader.
    // rust: taken.push(*i);
    // rust: collectors.push((*i, m.id));
    // rust: leaders.insert((id, s.wave));
    // rust: new_leaders.push((id, s.wave, m.id));
    // rust: s.banner_at = None;
    // rust: s.patrol_leader = true;
    // rust: s.patrolling = true;
                        // wear_banner: head id + ominous stack for SetEquipment (#4567).
    // rust: raider::wear_banner(m);
}
}
}
}
    // rust: for (i, mob) in collectors {
    // rust: let item = self.dropped[i].clone();
    // rust: self.add_pickup(
    // rust: super::pickups::Taken::Item(Box::new(item)),
    // rust: super::pickups::Collector::Mob(mob),
    // rust: );
}
    // rust: taken.sort_unstable();
    // rust: for i in taken.into_iter().rev() {
    // rust: self.remove_dropped(i);
}
    // rust: for (id, wave, mob) in new_leaders {
    // rust: if let Some(r) = self.raiding.raids.get_mut(id) {
    // rust: r.set_leader(wave, mob);
}
}
        // PathfindToRaidGoal.recruitNearby: raiders nearby in no active raid
        // join this one at its current wave.
    // rust: for (id, at) in recruit {
    // rust: for (mid, p, active) in &positions {
    // rust: if !active
    // rust: && (p.x - at.x).abs() <= 16.0
    // rust: && (p.y - at.y).abs() <= 16.0
    // rust: && (p.z - at.z).abs() <= 16.0
    // rust: && let Some(m) = self.mobs.iter().find(|m| m.id == *mid)
    // rust: && raider::state(m).is_some_and(|s| s.can_join_raid && s.raid_id != Some(id))
    // rust: && m.alive()
    // rust: && m.ai.no_action_time <= 2400
    // rust: {
    // rust: joins.push((*mid, id, m.health));
}
}
}
    // rust: for (mob, id, health) in joins {
    // rust: self.join_raid(mob, id, health);
}
}
    // `Raid.joinRaid` for a raider already in the world: it counts toward
    // the bar and takes the raid's current wave.
join_raid :: proc(self: ^Self, mob: u32, id: i32, health: f32) {
}
    // rust: let Some(wave) = self.raiding.raids.get(id).map(|r| r.groups_spawned) else {
    // rust: return;
}
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == mob) else {
    // rust: return;
}
    // rust: let s = raider::state_mut(m);
    // rust: if s.raid_id == Some(id) {
    // rust: return;
}
    // rust: s.raid_id = Some(id);
    // rust: s.wave = wave;
    // rust: s.can_join_raid = true;
    // rust: s.ticks_outside_raid = 0;
    // rust: s.registered = true;
    // rust: let living = self.raid_living_health(id, None);
    // rust: if let Some(r) = self.raiding.raids.get_mut(id) {
    // rust: r.add_wave_mob(health, true, living);
}
    // rust: self.raiding.raids.dirty = true;
}
    // Beds within 64 blocks of each raid's centre (the `HOME` points of
    // interest), rescanned every five seconds.
raid_homes :: proc(self: ^Self) -> H {
    // Ported from Horizon
    return {}
}
    // rust: let now = self.world.game_time;
    // rust: let ids: Vec<(i32, [i32; 3])> = self
    // rust: .raiding
    // rust: .raids
    // rust: .map
    // rust: .iter()
    // rust: .filter(|(_, r)| r.active && !r.is_over() && r.started)
    // rust: .map(|(id, r)| (*id, r.center))
    // rust: .collect();
    // rust: self.raiding
    // rust: .homes
    // rust: .retain(|id, _| ids.iter().any(|(i, _)| i == id));
    // rust: for (id, c) in ids {
    // rust: if self
    // rust: .raiding
    // rust: .homes
    // rust: .get(&id)
    // rust: .is_some_and(|(at, _)| now - at < 100)
    // rust: {
    // rust: continue;
}
    // rust: let mut beds = Vec::new();
    // rust: let mut known: HashMap<u32, bool> = HashMap::new();
    // rust: for y in c[1] - 32..=c[1] + 32 {
    // rust: for z in c[2] - 64..=c[2] + 64 {
    // rust: for x in c[0] - 64..=c[0] + 64 {
    // rust: let state = self.world.block(x, y, z);
    // rust: if self.res.facts().is_air(state) {
    // rust: continue;
}
    // rust: let bed = *known.entry(state.0).or_insert_with(|| {
    // rust: self.res.facts().get(state).name.ends_with("_bed")
    // rust: && self.pack.assets.registry.state(state).is_some_and(|s| {
    // rust: s.properties.get("part").map(String::as_str) == Some("head")
    // rust: })
    // rust: });
    // rust: if bed {
    // rust: beds.push([x, y, z]);
}
}
}
}
    // rust: self.raiding
    // rust: .homes
    // rust: .insert(id, (now, std::sync::Arc::new(beds)));
}
    // rust: self.raiding
    // rust: .homes
    // rust: .iter()
    // rust: .map(|(id, (_, v))| (*id, v.clone()))
    // rust: .collect()
}
    // `Raider.die`: the wave loses its leader, the killing player becomes
    // a hero of the village, and the raider leaves the raid (its health
    // stays in the bar's total).
    // rust: pub(super) fn raider_died(&mut self, m: &Mob, by_player: bool, killer: Option<u32>) {
    // rust: let Some(s) = raider::state(m) else {
    // rust: return;
}
    // rust: let Some(id) = s.raid_id else {
    // rust: return;
}
    // rust: let (leader, wave) = (s.patrol_leader, s.wave);
    // rust: self.flush_raid_bar(id);
    // rust: let living = self.raid_living_health(id, Some(m.id));
    // rust: let uuid = self.player_uuid_of(killer);
    // rust: if let Some(r) = self.raiding.raids.get_mut(id) {
    // rust: if leader {
    // rust: r.remove_leader(wave);
}
    // rust: if by_player && let Some(uuid) = uuid {
    // rust: r.add_hero(uuid);
}
    // rust: r.remove_from_raid(m.health, false, living);
    // rust: self.raiding.raids.dirty = true;
}
    // rust: if let Some(dead) = self.mobs.iter_mut().find(|x| x.id == m.id) {
    // rust: raider::state_mut(dead).raid_id = None;
}
}

    // What `getRaidAt` tells each villager where it stands (its brain's
    // `SetRaidStatus`, `ResetRaidStatus`, `ReactToBell` and raid packages
    // read it).
sync_villager_raids :: proc(self: ^Self, infos: ^HashMap<i32) {
}
    // rust: let raids = &self.raiding.raids;
    // rust: let mut ongoing = Vec::new();
    // rust: for m in &mut self.mobs {
    // rust: if m.species() != Species::Villager {
    // rust: continue;
}
    // rust: let at = block_of(m.position);
    // rust: let (status, wave) = match raids.nearby(at) {
    // rust: Some((id, r)) => {
    // rust: let alive = infos.get(&id).map_or(0, Vec::len);
    // rust: let wave = r.has_first_wave_spawned() && !r.is_between_waves(alive);
    // rust: let status = if r.is_victory() {
    // rust: mobs_villager::RAID_VICTORY
    // rust: } else if r.is_loss() {
    // rust: mobs_villager::RAID_LOSS
    // rust: } else if wave {
    // rust: mobs_villager::RAID
    // rust: } else {
    // rust: mobs_villager::PRE_RAID
}
    // rust: (status, wave)
}
    // rust: None => (mobs_villager::RAID_NONE, false),
}
    // rust: let ext = mobs_villager::ext_mut(m);
    // rust: ext.raid = status;
    // rust: ext.raid_wave = wave;
    // rust: if !m.no_ai && matches!(status, mobs_villager::PRE_RAID | mobs_villager::RAID) {
    // rust: ongoing.push(m.id);
}
}
        // Villager.customServerAiStep: a 1 in 100 chance each tick, in an
        // ongoing raid, of entity event 42 (`handleEntityEvent` splashes).
    // rust: for id in ongoing {
    // rust: if self.particles.random().next_int_bound(100) == Ok(0) {
    // rust: self.mob_raid_splash(id);
}
}
}
    // Entity event 42 for villager `id`: the guests get the byte, and this
    // game draws `AbstractVillager.addParticlesAroundSelf(SPLASH)` itself.
mob_raid_splash :: proc(self: ^Self, id: u32) {
}
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: self.lan_entity_event(id as i32, 42, at);
    // rust: self.particles_around_mob(id, "splash", horizon_client::particles::Burst::VILLAGER);
}

    // The raid bar a living player at `at` is in (`Raid.getPlayers`): red,
    // notched in tens. The name is the translate component the client draws.
    // rust: pub(super) fn raid_boss_at(&self, at: [f64; 3], alive: bool) -> Option<(i32, Tag, f32)> {
    // rust: if !alive || self.dim != Dim::Overworld {
    // rust: return None;
}
    // rust: let block = block_of(Vec3::new(at[0], at[1], at[2]));
    // rust: let (id, raid) = self.raiding.raids.nearby(block)?;
    // rust: if !raid.bar.visible || raid.is_stopped() {
    // rust: return None;
}
    // rust: Some((id, raid_name_tag(raid.bar.name), raid.bar.progress))
}
    // A firework a villager launches to celebrate (`CelebrateVillagersSurvivedRaid`).
    // rust: pub(super) fn villager_firework(&mut self, at: [f64; 3], color: usize, flight: u8) {
    // rust: let mut stack = horizon_client::items::ItemStack::new("minecraft:firework_rocket", 1);
    // rust: stack.data_mut().fireworks = Some((
    // rust: flight,
    // rust: vec![horizon_client::particles::FireworkExplosion {
    // rust: shape: horizon_client::particles::FireworkShape::Burst,
    // rust: colors: vec![horizon_client::particles::DYE_FIREWORK_COLORS[color & 15].1],
    // rust: fade: Vec::new(),
    // rust: trail: false,
    // rust: twinkle: false,
    // rust: }],
    // rust: ));
    // rust: let rocket = self.new_rocket(Vec3::new(at[0], at[1], at[2]), &stack, false);
    // rust: self.rockets.push(rocket);
}
    // `BehaviorUtils.throwItem`: a hero's gift tossed toward the player.
    // rust: pub(super) fn throw_gift(&mut self, table: &str, from: [f64; 3], to: [f64; 3]) {
    // rust: let drops = self
    // rust: .res
    // rust: .items()
    // rust: .loot_table(table, false, None, &mut self.world.random);
    // rust: let d = Vec3::new(to[0] - from[0], to[1] - from[1], to[2] - from[2]).normalize();
    // rust: for stack in drops {
    // rust: self.spawn_item(stack, from, [d.x * 0.3, d.y * 0.3, d.z * 0.3], 10);
}
}
}

    // rust: impl Game<'_> {
    // Sections holding a claimed village point of interest (a job site,
    // bed or bell a villager has taken): `PoiManager.isVillageCenter`.
    // rust: pub(super) fn village_centers(&self) -> HashSet<(i32, i32, i32)> {
    // rust: let mut out = HashSet::new();
    // rust: for m in &self.mobs {
    // rust: if m.species() != Species::Villager || !m.alive() {
    // rust: continue;
}
    // rust: for p in [m.extra.home, m.extra.bed, m.extra.meeting]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: out.insert(section(p));
}
}
    // rust: out
}
    // `PatrolSpawner.tick` (`horizon_client::patrol`) on the game level:
    // the pillagers it accepts are created after the pass, finalized for a
    // patrol.
    // rust: pub(super) fn tick_patrol_spawner(&mut self) {
    // rust: if self.dim != Dim::Overworld {
    // rust: return;
}
    // rust: let attributes = self.gameplay_attributes();
    // rust: let biome_ok = |game: &Game, at: [i32; 3]| {
    // rust: let biome = game
    // rust: .world
    // rust: .chunks
    // rust: .get(&(at[0] >> 4, at[2] >> 4))
    // rust: .map(|c| {
    // rust: game.res
    // rust: .biomes()
    // rust: .get(c.biome(at[0], at[1], at[2]))
    // rust: .name
    // rust: .clone()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: attributes.value(
    // rust: horizon_client::patrol::CAN_PILLAGER_PATROL_SPAWN,
    // rust: game.dim.id(),
    // rust: &biome,
    // rust: game.world.day_time,
    // rust: )
}
    // rust: let enemies = self.ui.rules.bool("spawn_mobs") && self.ui.rules.bool("spawn_monsters");
    // rust: let mut random = std::mem::replace(
    // rust: &mut self.world.random,
    // rust: horizon_core::random::LegacyRandom::new(0),
    // rust: );
    // rust: let mut members: Vec<Member> = Vec::new();
    // rust: let mut spawner = std::mem::take(&mut self.raiding.patrol);
    // rust: {
    // rust: let level = PatrolCx {
    // rust: level: self.natural_level(),
    // rust: centers: self.village_centers(),
    // rust: can_spawn: &biome_ok,
}
    // rust: let mut spawn =
    // rust: |l: &PatrolCx, m: Member, _: &mut horizon_core::random::LegacyRandom| {
                    // EntityType.create makes no monsters in peaceful.
    // rust: if l.level.game.difficulty_id() == 0 {
    // rust: return false;
}
    // rust: members.push(m);
    // rust: true
}
    // rust: spawner.tick(&level, enemies, &mut random, &mut spawn);
}
    // rust: self.raiding.patrol = spawner;
    // rust: self.world.random = random;
    // rust: for m in members {
    // rust: let at = [
    // rust: f64::from(m.pos[0]),
    // rust: f64::from(m.pos[1]),
    // rust: f64::from(m.pos[2]),
    // rust: ];
    // rust: self.spawn_event_mob("minecraft:pillager", at, m.leader, raider::Reason::Patrol);
}
}
    // `VillageSiege.tick`: at midnight one night in ten, 20 zombies spawn
    // two ticks apart near a village 32 blocks from a player standing in it.
    // rust: pub(super) fn tick_village_siege(&mut self) {
    // rust: if self.dim != Dim::Overworld {
    // rust: return;
}
    // rust: let enemies = self.ui.rules.bool("spawn_mobs") && self.ui.rules.bool("spawn_monsters");
    // rust: if self.sky_darken() < 4 || !enemies {
    // rust: self.raiding.siege.tonight = false;
    // rust: self.raiding.siege.set_up = false;
    // rust: return;
}
        // ClockTimeMarkers.ROLL_VILLAGE_SIEGE: tick 18000 of the 24000 tick day.
    // rust: if self.world.day_time.rem_euclid(24000) == 18000 {
    // rust: self.raiding.siege.tonight = self.world.random.next_int_bound(10).unwrap_or(1) == 0;
}
    // rust: if !self.raiding.siege.tonight {
    // rust: return;
}
    // rust: if !self.raiding.siege.set_up {
    // rust: if !self.try_to_setup_siege() {
    // rust: return;
}
    // rust: self.raiding.siege.set_up = true;
}
    // rust: if self.raiding.siege.next_spawn_time > 0 {
    // rust: self.raiding.siege.next_spawn_time -= 1;
    // rust: return;
}
    // rust: self.raiding.siege.next_spawn_time = 2;
    // rust: if self.raiding.siege.zombies_to_spawn > 0 {
    // rust: self.try_spawn_siege_zombie();
    // rust: self.raiding.siege.zombies_to_spawn -= 1;
    // rust: } else {
    // rust: self.raiding.siege.tonight = false;
}
}
    // `ServerLevel.isVillage`: within one section of a village.
is_village :: proc(centers: ^HashSet<(i32) {
}
    // rust: sections_to_village(centers, section(pos)) <= 1
}
    // `VillageSiege.tryToSetupSiege`: the first player standing in a village
    // picks a spot 32 blocks away (ten tries); true when one stood in a
    // village, even if no spot was found.
try_to_setup_siege :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let centers = self.village_centers();
    // rust: for player in self.level_players() {
    // rust: if player.spectator {
    // rust: continue;
}
    // rust: let center = block_of(player.position);
    // rust: if !Self::is_village(&centers, center)
    // rust: || self.natural_level().biome_tag(
    // rust: "minecraft:without_zombie_sieges",
    // rust: center[0],
    // rust: center[1],
    // rust: center[2],
    // rust: )
    // rust: {
    // rust: continue;
}
    // rust: for _ in 0..10 {
    // rust: let angle = self.world.random.next_float() * std::f32::consts::TAU;
    // rust: let spot = [
    // rust: center[0] + (angle.cos() * 32.0).floor() as i32,
    // rust: center[1],
    // rust: center[2] + (angle.sin() * 32.0).floor() as i32,
    // rust: ];
    // rust: if let Some(attempted_pos) = self.find_siege_spawn_pos(&centers, spot) {
    // rust: let mut canceled = false;
    // rust: self.native_village_siege(
    // rust: self.dim.id(),
    // rust: player.uuid,
    // rust: attempted_pos,
    // rust: &mut canceled,
    // rust: );
    // rust: if canceled {
    // rust: return false;
}
    // rust: self.raiding.siege.spot = spot;
    // rust: self.raiding.siege.next_spawn_time = 0;
    // rust: self.raiding.siege.zombies_to_spawn = 20;
    // rust: break;
}
}
    // rust: return true;
}
    // rust: false
}
    // `VillageSiege.trySpawn`: one zombie, in a random yaw.
try_spawn_siege_zombie :: proc(self: ^Self) {
}
    // rust: let centers = self.village_centers();
    // rust: let spot = self.raiding.siege.spot;
    // rust: let Some(at) = self.find_siege_spawn_pos(&centers, spot) else {
    // rust: return;
}
    // rust: let Some(id) = self.spawn_event_mob("minecraft:zombie", at, false, raider::Reason::Event)
    // rust: else {
    // rust: return;
}
    // rust: let yaw = self.world.random.next_float() * 360.0;
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) {
    // rust: (m.yaw, m.previous_yaw, m.body_yaw, m.previous_body_yaw) = (yaw, yaw, yaw, yaw);
    // rust: (m.head_yaw, m.previous_head_yaw) = (yaw, yaw);
}
    // rust: self.spawn_jockeys(id, false);
}
    // `VillageSiege.findRandomSpawnPos`: ten tries within 8 blocks of the
    // spot for a village column where a zombie may spawn.
    // rust: fn find_siege_spawn_pos(
    // rust: &mut self,
    // rust: centers: &HashSet<(i32, i32, i32)>,
    // rust: spot: [i32; 3],
    // rust: ) -> Option<[f64; 3]> {
    // rust: let mut random = std::mem::replace(
    // rust: &mut self.world.random,
    // rust: horizon_core::random::LegacyRandom::new(0),
    // rust: );
    // rust: let mut found = None;
    // rust: for _ in 0..10 {
    // rust: let x = spot[0] + random.next_int_bound(16).unwrap_or(0) - 8;
    // rust: let z = spot[2] + random.next_int_bound(16).unwrap_or(0) - 8;
    // rust: if !self.world.chunks.contains_key(&(x >> 4, z >> 4)) {
    // rust: continue;
}
    // rust: let y = self.surface_height(x, z);
    // rust: if Self::is_village(centers, [x, y, z])
    // rust: && spawn_rules::check_spawn_rules(
    // rust: Species::Zombie,
    // rust: &self.natural_level(),
    // rust: spawn_rules::Reason::Event,
    // rust: &mut random,
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: )
    // rust: {
    // rust: found = Some([f64::from(x) + 0.5, f64::from(y), f64::from(z) + 0.5]);
    // rust: break;
}
}
    // rust: self.world.random = random;
    // rust: found
}
    // A raider's ominous banner (drop chance 2.0: always dropped) and a
    // patrol captain's ominous bottle (`entities/pillager`).
    // `OminousBottleAmplifier.onConsume`: Bad Omen for 100 minutes at the
    // bottle's amplifier, then the dispose sound; the bottle is used up.
    // rust: pub(super) fn drink_ominous_bottle(
    // rust: &mut self,
    // rust: slot: usize,
    // rust: stack: &horizon_client::items::ItemStack,
    // rust: ) {
    // rust: let amplifier = stack.data().and_then(|d| d.ominous_amplifier).unwrap_or(0);
    // rust: let mut effect =
    // rust: horizon_client::effects::EffectInstance::new("bad_omen", 120_000, i32::from(amplifier));
    // rust: effect.visible = false;
    // rust: let new = self.potions.effects.get("bad_omen").is_none();
    // rust: self.potions.effects.add(effect);
    // rust: let eye = self.eye_position().unwrap_or_default();
        // MobEffect.onEffectAdded: Bad Omen's sound when it is new.
    // rust: if new {
    // rust: self.audio
    // rust: .play("minecraft:event.mob_effect.bad_omen", Some(eye), 1.0, 1.0);
}
    // rust: self.audio
    // rust: .play("minecraft:item.ominous_bottle.dispose", Some(eye), 1.0, 1.0);
    // rust: if !self.creative
    // rust: && let Some(s) = self.stack_in_mut(slot).as_mut()
    // rust: {
    // rust: s.count -= 1;
    // rust: if s.count == 0 {
    // rust: *self.stack_in_mut(slot) = None;
}
}
}
}

// `Raid.raidEvent`'s name: the raid title, the remaining-raiders line, or
// the victory and defeat lines.
raid_name_tag :: proc(name: BarName) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let key = |k: &str| Tag::compound([("translate", Tag::String(k.into()))]);
    // rust: match name {
    // rust: BarName::Raid => key("event.minecraft.raid"),
    // rust: BarName::Victory => key("event.minecraft.raid.victory.full"),
    // rust: BarName::Defeat => key("event.minecraft.raid.defeat.full"),
    // rust: BarName::Remaining(n) => Tag::compound([
    // rust: ("translate", Tag::String("event.minecraft.raid".into())),
    // rust: (
    // rust: "extra",
    // rust: Tag::List(vec![
    // rust: Tag::String(" - ".into()),
    // rust: Tag::compound([
    // rust: (
    // rust: "translate",
    // rust: Tag::String("event.minecraft.raid.raiders_remaining".into()),
    // rust: ),
    // rust: (
    // rust: "with",
    // rust: Tag::List(vec![Tag::String(n.to_string().as_str().into())]),
    // rust: ),
    // rust: ]),
    // rust: ]),
    // rust: ),
    // rust: ]),
}
}

    // rust: mod tests {
//     use super::*;

sections_to_village_is_a_chebyshev_distance_capped_at_seven :: proc() {
}
    // rust: let mut centers = HashSet::new();
    // rust: assert_eq!(sections_to_village(&centers, (0, 0, 0)), 7);
    // rust: centers.insert(section([40, 64, 40]));
    // rust: assert_eq!(sections_to_village(&centers, (2, 4, 2)), 0);
    // rust: assert_eq!(sections_to_village(&centers, (4, 4, 2)), 2);
    // rust: assert_eq!(sections_to_village(&centers, (-10, 4, 2)), 7);
    // rust: assert_eq!(section([-1, -17, 15]), (-1, -2, 0));
}
}
