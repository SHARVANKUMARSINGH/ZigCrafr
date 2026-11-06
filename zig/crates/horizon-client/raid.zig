//! Transpiled from Horizon Rust crate
//! Module: horizon-client_raid
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Raids (`Raid` and `Raids`): the waves of raiders each difficulty sends,
//! where they gather around the village, the boss bar, victory, loss and the
//! celebration, the raid omen a player brings, and the per-dimension
//! `data/minecraft/raids.dat` saved data with vanilla's codec rules.
//!
//! The raid's members live in the game (each raider knows its raid and
//! wave); a raid reads them and the world through [`RaidLevel`] and asks the
//! game for its side effects with [`Action`]s, so the game and the
//! differential test (`tools/test_raid_parity.py`) run the same rules.
// use horizon_core::{
    // rust: geometry::trig,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::nbt::{JavaString, Tag};
// use std::collections::BTreeMap;

pub const MAX_OMEN_LEVEL: i32 = 5;
/// `Raid.RAID_TIMEOUT_TICKS`.
pub const TIMEOUT: i64 = 48_000;
pub const PRE_RAID_TICKS: i32 = 300;
pub const POST_RAID_LIMIT: i32 = 40;
pub const CELEBRATION_TICKS: i32 = 600;
pub const MAX_NO_ACTION_TIME: i32 = 2400;
pub const OUTSIDE_RAID_BOUNDS_TIMEOUT: i32 = 30;
/// `Raids.getNearbyRaid(pos, 9216)`: within 96 blocks.
pub const VALID_RAID_RADIUS_SQR: f64 = 9216.0;
/// `RAID_REMOVAL_THRESHOLD_SQR`: a raider this far from the centre leaves.
pub const REMOVAL_THRESHOLD_SQR: f64 = 12544.0;
/// `HERO_OF_THE_VILLAGE_DURATION`.
pub const HERO_DURATION: i32 = 48_000;

/// `Mth.clamp(float)`: NaN passes through (`Math.min`).
pub fn clamp_f32(v: f32, lo: f32, hi: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v < lo {
    // rust: lo
    // rust: } else if v.is_nan() || v > hi {
    // rust: if v.is_nan() { v } else { hi }
    // rust: } else {
    // rust: v
}
}
/// `getHealthOfLivingRaiders`: a float sum from zero (Rust's empty float
/// sum is -0.0).
pub fn living_health(members: *[RaiderInfo]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: members.iter().fold(0.0, |a, m| a + m.health)
}
/// `Vec3i.distSqr`.
pub fn dist_sqr(a: [i32; 3], b: [i32; 3]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..3)
    // rust: .map(|i| f64::from(a[i]) - f64::from(b[i]))
    // rust: .map(|d| d * d)
    // rust: .sum()
}

pub const Status = enum {
    Ongoing,
    Victory,
    Loss,
    Stopped,
};
    // rust: impl Status {
pub const ALL: [Self; 4] = [Self::Ongoing, Self::Victory, Self::Loss, Self::Stopped];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Ongoing => "ongoing",
    // rust: Self::Victory => "victory",
    // rust: Self::Loss => "loss",
    // rust: Self::Stopped => "stopped",
}
}
pub fn from_name(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|v| v.name() == s)
}
}

/// `Raid.RaiderType`, in spawn order.
pub const RaiderType = enum {
    Vindicator,
    Evoker,
    Pillager,
    Witch,
    Ravager,
};
    // rust: impl RaiderType {
    // rust: pub const ALL: [Self; 5] = [
    // rust: Self::Vindicator,
    // rust: Self::Evoker,
    // rust: Self::Pillager,
    // rust: Self::Witch,
    // rust: Self::Ravager,
    // rust: ];
pub fn entity(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Vindicator => "minecraft:vindicator",
    // rust: Self::Evoker => "minecraft:evoker",
    // rust: Self::Pillager => "minecraft:pillager",
    // rust: Self::Witch => "minecraft:witch",
    // rust: Self::Ravager => "minecraft:ravager",
}
}
    /// A freshly created raider's health (its maximum).
pub fn health(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Witch => 26.0,
    // rust: Self::Ravager => 100.0,
    // rust: _ => 24.0,
}
}
pub fn can_be_leader(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !matches!(self, Self::Witch | Self::Ravager)
}
    /// `spawnsPerWaveBeforeBonus`, by wave number.
pub fn spawns(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Vindicator => [0, 0, 2, 0, 1, 4, 2, 5],
    // rust: Self::Evoker => [0, 0, 0, 0, 0, 1, 1, 2],
    // rust: Self::Pillager => [0, 4, 3, 3, 4, 4, 4, 2],
    // rust: Self::Witch => [0, 0, 0, 0, 3, 0, 0, 1],
    // rust: Self::Ravager => [0, 0, 0, 1, 0, 1, 0, 2],
}
}
}
/// `Raid.getNumGroups`: waves per difficulty (0 peaceful to 3 hard).
pub fn num_groups(difficulty: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match difficulty {
    // rust: 1 => 3,
    // rust: 2 => 5,
    // rust: 3 => 7,
    // rust: _ => 0,
}
}

/// One raider of a wave, with the raider riding it (ravagers only).
pub const Spawn = struct {
    kind: RaiderType,
    leader: bool,
    rider: ?RaiderType,
};

/// A member of a raid (`groupRaiderMap`), as the game reports it.
pub const RaiderInfo = struct {
    id: u32,
    wave: i32,
    health: f32,
    /// `blockPosition()`.
    position: [i32,
    tick_count: i32,
    no_action_time: i32,
    ticks_outside: i32,
    /// `isRemoved()` (killed, discarded or unloaded).
    removed: bool,
    /// The raider is in another dimension.
    other_dimension: bool,
    /// `level.getEntity(uuid)` finds it.
    in_level: bool,
    patrol_leader: bool,
};

/// `Raid.playSound` for one player. The horn is 13 blocks from them toward
/// the wave centre, heard when they are within 64 blocks or in the raid.
/// Standing on the centre leaves the horn there (`13 / 0` is not a point).
pub fn horn_at(player: [f64; 3], center_x: f64, center_z: f64, in_raid: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dx = center_x - player[0];
    // rust: let dz = center_z - player[2];
    // rust: let distance = (dx * dx + dz * dz).sqrt();
    // rust: if distance > 64.0 && !in_raid {
    // rust: return None;
}
    // rust: if distance == 0.0 {
    // rust: return Some(player);
}
    // rust: let k = 13.0 / distance;
    // rust: Some([player[0] + k * dx, player[1], player[2] + k * dz])
}

/// The single player a raid sees (`level.players()`).
pub const RaidPlayer = struct {
    position: [f64,
    block: [i32,
    alive: bool,
};

/// What a raid asks of the world.
    // rust: pub trait RaidLevel {
    /// The world difficulty, 0 (peaceful) to 3 (hard).
pub fn difficulty(self: *Self) i;
    /// `Level.hasChunkAt`.
pub fn has_chunk_at(self: *Self, pos: [i32; 3]) b;
    /// `Level.hasChunksAt(x0, z0, x1, z1)`.
pub fn has_chunks_at(self: *Self, x0: i32, z0: i32, x1: i32, z1: i32) b;
    /// `ServerLevel.sectionsToVillage` (0 to 7).
pub fn sections_to_village(self: *Self, pos: [i32; 3]) i;
    /// `Heightmap.Types.WORLD_SURFACE` height of a column.
pub fn surface_height(self: *Self, x: i32, z: i32) i;
    /// `ServerLevel.isPositionEntityTicking`.
pub fn is_position_entity_ticking(self: *Self, pos: [i32; 3]) b;
    /// The ravager's placement accepts the position, or it is air on snow.
pub fn ravager_can_spawn(self: *Self, pos: [i32; 3]) b;
pub fn player(self: *Self) O;
}
/// `ServerLevel.isVillage`.
pub fn is_village(level: *dyn RaidLevel, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: level.sections_to_village(pos) <= 1
}

/// What the game must do after a raid tick.
pub const Action = enum {
    /// Spawn the raiders of a wave at `pos` (`spawnGroup`), in order, each
    /// joining the raid at `wave`; the leader gets the banner first.
    Spawn {,
    pos: [i32; 3],
    wave: i32,
    spawns: Vec<Spawn>,
    // rust: },
    /// `playSound`: the raid horn with its seed, heard by the player when
    /// within 64 blocks or in the raid.
    Horn {,
    pos: [i32; 3],
    seed: i64,
    // rust: },
    /// A raider leaves the raid (`removeFromRaid`: `setCurrentRaid(null)`).
    Remove {,
    id: u32,
    // rust: },
    SetOutside {,
    id: u32,
    ticks: i32,
    // rust: },
    /// The raid was won: heroes (in set order) get Hero of the Village.
    Victory {,
    heroes: Vec<[i32; 4]>,
    amplifier: i32,
    // rust: },
};

/// The raid boss bar's title.
pub const BarName = enum {
    Raid,
    Remaining(i32),
    Victory,
    Defeat,
};
/// The raid's `ServerBossEvent` (red, ten notches).
pub const Bar = struct {
    name: BarName,
    progress: f32,
    visible: bool,
    /// The local player sees the bar (`getPlayers` holds them).
    player: bool,
};

pub const Raid = struct {
    started: bool,
    active: bool,
    ticks_active: i64,
    omen_level: i32,
    groups_spawned: i32,
    cooldown_ticks: i32,
    post_raid_ticks: i32,
    total_health: f32,
    num_groups: i32,
    status: Status,
    center: [i32,
    /// `heroesOfTheVillage`, in the order they joined the set.
    heroes: Vec<[i32,
    bar: Bar,
    celebration_ticks: i32,
    wave_spawn_pos: Option<[i32,
    /// `groupToLeaderMap`: wave to the leading raider's id.
    leaders: BTreeMap<i32,
    random: LegacyRandom,
};
    // rust: impl Raid {
    /// `new Raid(center, difficulty)`.
pub fn new(center: [i32; 3], difficulty: i32, seed: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: started: false,
    // rust: active: true,
    // rust: ticks_active: 0,
    // rust: omen_level: 0,
    // rust: groups_spawned: 0,
    // rust: cooldown_ticks: PRE_RAID_TICKS,
    // rust: post_raid_ticks: 0,
    // rust: total_health: 0.0,
    // rust: num_groups: num_groups(difficulty),
    // rust: status: Status::Ongoing,
    // rust: center,
    // rust: heroes: Vec::new(),
    // rust: bar: Bar {
    // rust: name: BarName::Raid,
    // rust: progress: 0.0,
    // rust: visible: true,
    // rust: player: false,
    // rust: },
    // rust: celebration_ticks: 0,
    // rust: wave_spawn_pos: None,
    // rust: leaders: BTreeMap::new(),
    // rust: random: LegacyRandom::new(seed),
}
}
    /// Replaces the raid's random (vanilla's is unseeded).
pub fn reseed(self: *Self, seed: i64) void {
}
    // rust: self.random = LegacyRandom::new(seed);
}
pub fn is_over(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_victory() || self.is_loss()
}
pub fn is_victory(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.status == Status::Victory
}
pub fn is_loss(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.status == Status::Loss
}
pub fn is_stopped(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.status == Status::Stopped
}
pub fn has_first_wave_spawned(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.groups_spawned > 0
}
    /// `isBetweenWaves`: the next wave is counting down.
pub fn is_between_waves(self: *Self, raiders_alive: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.has_first_wave_spawned() && raiders_alive == 0 && self.cooldown_ticks > 0
}
pub fn stop(self: *Self) void {
}
    // rust: self.active = false;
    // rust: self.bar.player = false;
    // rust: self.status = Status::Stopped;
}
pub fn has_bonus_wave(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.omen_level > 1
}
pub fn is_final_wave(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.groups_spawned == self.num_groups
}
pub fn has_spawned_bonus_wave(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.groups_spawned > self.num_groups
}
pub fn has_more_waves(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.has_bonus_wave() {
    // rust: !self.has_spawned_bonus_wave()
    // rust: } else {
    // rust: !self.is_final_wave()
}
}
pub fn should_spawn_bonus_group(self: *Self, alive: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_final_wave() && alive == 0 && self.has_bonus_wave()
}
pub fn should_spawn_group(self: *Self, alive: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.cooldown_ticks == 0
    // rust: && (self.groups_spawned < self.num_groups || self.should_spawn_bonus_group(alive))
    // rust: && alive == 0
}
    /// `Raid.absorbRaidOmen` for a player with Raid Omen at `amplifier`.
    /// True when this omen triggers the raid (no wave spawned yet: the
    /// `raid_trigger` stat and the `voluntary_exile` advancement).
pub fn absorb_omen(self: *Self, amplifier: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.omen_level = (self.omen_level + amplifier + 1).clamp(0, MAX_OMEN_LEVEL);
    // rust: !self.has_first_wave_spawned()
}
    /// `Raid.getEnchantOdds`.
pub fn enchant_odds(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.omen_level {
    // rust: 2 => 0.1,
    // rust: 3 => 0.25,
    // rust: 4 => 0.5,
    // rust: 5 => 0.75,
    // rust: _ => 0.0,
}
}
    /// `addHeroOfTheVillage`.
pub fn add_hero(self: *Self, uuid: [i32; 4]) void {
}
    // rust: if !self.heroes.contains(&uuid) {
    // rust: self.heroes.push(uuid);
}
}
    /// The heroes in the order vanilla's `HashSet` iterates them.
pub fn heroes(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: java_hash_set_order(&self.heroes, 16)
}
    /// `setLeader`: the raider leading a wave (it wears the banner).
pub fn set_leader(self: *Self, wave: i32, id: u32) void {
}
    // rust: self.leaders.insert(wave, id);
}
pub fn remove_leader(self: *Self, wave: i32) void {
}
    // rust: self.leaders.remove(&wave);
}
pub fn leader(self: *Self, wave: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.leaders.get(&wave).copied()
}
    /// `updateBossbar` with the health of the living raiders.
pub fn update_bossbar(self: *Self, living_health: f32) void {
}
    // rust: self.bar.progress = clamp_f32(living_health / self.total_health, 0.0, 1.0);
}
    /// `addWaveMob` (joining or loading): the raider's health counts toward
    /// the bar when `update_health`; `living_health` includes it.
pub fn add_wave_mob(self: *Self, health: f32, update_health: bool, living_health: f32) void {
}
    // rust: if update_health {
    // rust: self.total_health += health;
}
    // rust: self.update_bossbar(living_health);
}
    /// `removeFromRaid` of a member; `living_health` is without it.
pub fn remove_from_raid(self: *Self, health: f32, from_total: bool, living_health: f32) void {
}
    // rust: if from_total {
    // rust: self.total_health -= health;
}
    // rust: self.update_bossbar(living_health);
}

    /// `getDefaultNumSpawns` and `getPotentialBonusSpawns`.
pub fn wave_count(self: *Self, kind: RaiderType, wave: i32, difficulty: i32, bonus: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = if bonus { self.num_groups } else { wave } as usize;
    // rust: let base = kind.spawns()[index.min(7)];
    // rust: let easy = difficulty == 1;
    // rust: let normal = difficulty == 2;
    // rust: let extra = match kind {
    // rust: RaiderType::Vindicator | RaiderType::Pillager => {
    // rust: if easy {
    // rust: self.random.next_int_bound(2).unwrap_or(0)
    // rust: } else if normal {
    // rust: 1
    // rust: } else {
    // rust: 2
}
}
    // rust: RaiderType::Evoker => return base,
    // rust: RaiderType::Witch => {
    // rust: if easy || wave <= 2 || wave == 4 {
    // rust: return base;
}
    // rust: 1
}
    // rust: RaiderType::Ravager => i32::from(!easy && bonus),
}
    // rust: base + if extra > 0 {
    // rust: self.random.next_int_bound(extra + 1).unwrap_or(0)
    // rust: } else {
    // rust: 0
}
}
    /// The raiders of wave `wave` (`spawnGroup`): per type the counted
    /// spawns, the first able raider leading, and ravagers carrying a
    /// pillager (wave 5) or an evoker then vindicators (wave 7 and later).
pub fn compose_wave(self: *Self, wave: i32, difficulty: i32, bonus: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: let mut leader_set = false;
    // rust: for kind in RaiderType::ALL {
    // rust: let count = self.wave_count(kind, wave, difficulty, bonus);
    // rust: let mut ravagers = 0;
    // rust: for _ in 0..count {
    // rust: let leader = !leader_set && kind.can_be_leader();
    // rust: leader_set |= leader;
    // rust: let mut rider = None;
    // rust: if kind == RaiderType::Ravager {
    // rust: if wave == num_groups(2) {
    // rust: rider = Some(RaiderType::Pillager);
    // rust: } else if wave >= num_groups(3) {
    // rust: rider = Some(if ravagers == 0 {
    // rust: RaiderType::Evoker
    // rust: } else {
    // rust: RaiderType::Vindicator
    // rust: });
}
    // rust: ravagers += 1;
}
    // rust: out.push(Spawn {
    // rust: kind,
    // rust: leader,
    // rust: rider,
    // rust: });
}
}
    // rust: out
}
    /// `Raid.findRandomSpawnPos`: a ring around the centre that closes in as
    /// the countdown runs down.
pub fn find_spawn_pos(self: *Self, level: *dyn RaidLevel, max_tries: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let seconds = self.cooldown_ticks / 20;
    // rust: let how_far = 0.22 * seconds as f32 - 0.24;
    // rust: let start = self.random.next_float() * (std::f32::consts::PI * 2.0);
    // rust: let far = how_far.floor() as i32;
    // rust: for i in 0..max_tries {
    // rust: let angle = start + std::f32::consts::PI * i as f32 / 8.0;
    // rust: let x = self.center[0]
    // rust: + (trig::cos(f64::from(angle)) * 32.0 * how_far).floor() as i32
    // rust: + self.random.next_int_bound(3).unwrap_or(0) * far;
    // rust: let z = self.center[2]
    // rust: + (trig::sin(f64::from(angle)) * 32.0 * how_far).floor() as i32
    // rust: + self.random.next_int_bound(3).unwrap_or(0) * far;
    // rust: let y = level.surface_height(x, z);
    // rust: if (y - self.center[1]).abs() > 96 {
    // rust: continue;
}
    // rust: let pos = [x, y, z];
    // rust: if (!is_village(level, pos) || seconds <= 7)
    // rust: && level.has_chunks_at(x - 10, z - 10, x + 10, z + 10)
    // rust: && level.is_position_entity_ticking(pos)
    // rust: && level.ravager_can_spawn(pos)
    // rust: {
    // rust: return Some(pos);
}
}
    // rust: None
}
    /// `moveRaidCenterToNearbyVillageSection`: the closest village section
    /// centre within two sections (first of equals in `SectionPos.cube` order).
pub fn move_center_to_nearby_village(self: *Self, level: *dyn RaidLevel) void {
}
    // rust: let c = self.center;
    // rust: let (sx, sy, sz) = (c[0] >> 4, c[1] >> 4, c[2] >> 4);
    // rust: let mut best: Option<([i32; 3], f64)> = None;
        // SectionPos.cube: BetweenClosed over x fastest, then y, then z.
    // rust: for dz in -2..=2 {
    // rust: for dy in -2..=2 {
    // rust: for dx in -2..=2 {
    // rust: let s = [sx + dx, sy + dy, sz + dz];
    // rust: let center = [s[0] * 16 + 8, s[1] * 16 + 8, s[2] * 16 + 8];
    // rust: if !is_village(level, center) {
    // rust: continue;
}
    // rust: let d = dist_sqr(center, c);
    // rust: if best.is_none_or(|b| d < b.1) {
    // rust: best = Some((center, d));
}
}
}
}
    // rust: if let Some((center, _)) = best {
    // rust: self.center = center;
}
}
    /// The countdown's bar progress and the local player's membership
    /// (`updatePlayers`).
pub fn update_players(self: *Self, in_raid: bool) void {
}
    // rust: self.bar.player = in_raid;
}

    /// `Raid.tick`. `members` are the raid's raiders; `in_raid` answers
    /// whether the player stands in this raid (`getRaidAt(pos) == this`,
    /// with the raid's current centre and state).
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: level: &dyn RaidLevel,
    // rust: members: &[RaiderInfo],
    // rust: in_raid: &dyn Fn(&Raid, [i32; 3]) -> bool,
    // rust: ) -> Vec<Action> {
    // rust: let mut actions = Vec::new();
    // rust: if self.is_stopped() {
    // rust: return actions;
}
    // rust: let player_in = |raid: &Raid| {
    // rust: level
    // rust: .player()
    // rust: .is_some_and(|p| p.alive && in_raid(raid, p.block))
}
    // rust: if self.status == Status::Ongoing {
    // rust: let mut members: Vec<RaiderInfo> = members.to_vec();
    // rust: let was_active = self.active;
    // rust: self.active = level.has_chunk_at(self.center);
    // rust: if level.difficulty() == 0 {
    // rust: self.stop();
    // rust: return actions;
}
    // rust: if was_active != self.active {
    // rust: self.bar.visible = self.active;
}
    // rust: if !self.active {
    // rust: return actions;
}
    // rust: if !is_village(level, self.center) {
    // rust: self.move_center_to_nearby_village(level);
}
    // rust: if !is_village(level, self.center) {
    // rust: if self.groups_spawned > 0 {
    // rust: self.status = Status::Loss;
    // rust: } else {
    // rust: self.stop();
}
}
    // rust: self.ticks_active += 1;
    // rust: if self.ticks_active >= TIMEOUT {
    // rust: self.stop();
    // rust: return actions;
}
    // rust: let alive = members.len();
    // rust: if alive == 0 && self.has_more_waves() {
    // rust: if self.cooldown_ticks <= 0 {
    // rust: if self.cooldown_ticks == 0 && self.groups_spawned > 0 {
    // rust: self.cooldown_ticks = PRE_RAID_TICKS;
    // rust: self.bar.name = BarName::Raid;
    // rust: return actions;
}
    // rust: } else {
    // rust: let cached = self.wave_spawn_pos.is_some();
    // rust: let mut try_find = !cached && self.cooldown_ticks % 5 == 0;
    // rust: if let Some(p) = self.wave_spawn_pos
    // rust: && !level.is_position_entity_ticking(p)
    // rust: {
    // rust: try_find = true;
}
    // rust: if try_find {
    // rust: self.wave_spawn_pos = self.find_spawn_pos(level, 8);
}
    // rust: if self.cooldown_ticks == PRE_RAID_TICKS || self.cooldown_ticks % 20 == 0 {
    // rust: let p = player_in(self);
    // rust: self.update_players(p);
}
    // rust: self.cooldown_ticks -= 1;
    // rust: self.bar.progress = clamp_f32(
    // rust: (PRE_RAID_TICKS - self.cooldown_ticks) as f32 / 300.0,
    // rust: 0.0,
    // rust: 1.0,
    // rust: );
}
}
    // rust: if self.ticks_active % 20 == 0 {
    // rust: let p = player_in(self);
    // rust: self.update_players(p);
    // rust: self.update_raiders(level, &mut members, &mut actions);
    // rust: self.bar.name = if alive > 0 && alive <= 2 {
    // rust: BarName::Remaining(alive as i32)
    // rust: } else {
    // rust: BarName::Raid
}
}
    // rust: let mut sound = false;
    // rust: let mut attempt = 0;
    // rust: while self.should_spawn_group(members.len()) {
    // rust: let pos = match self.wave_spawn_pos {
    // rust: Some(p) => Some(p),
    // rust: None => self.find_spawn_pos(level, 20),
}
    // rust: if let Some(pos) = pos {
    // rust: self.started = true;
    // rust: let spawns = self.spawn_group(level, pos, &mut members);
    // rust: actions.push(Action::Spawn {
    // rust: pos,
    // rust: wave: self.groups_spawned,
    // rust: spawns,
    // rust: });
    // rust: if !sound {
    // rust: actions.push(Action::Horn {
    // rust: pos,
    // rust: seed: self.random.next_long(),
    // rust: });
    // rust: sound = true;
}
    // rust: } else {
    // rust: attempt += 1;
}
    // rust: if attempt > 5 {
    // rust: self.stop();
    // rust: break;
}
}
    // rust: if self.started && !self.has_more_waves() && alive == 0 {
    // rust: if self.post_raid_ticks < POST_RAID_LIMIT {
    // rust: self.post_raid_ticks += 1;
    // rust: } else {
    // rust: self.status = Status::Victory;
    // rust: actions.push(Action::Victory {
    // rust: heroes: self.heroes(),
    // rust: amplifier: self.omen_level - 1,
    // rust: });
}
}
    // rust: } else if self.is_over() {
    // rust: self.celebration_ticks += 1;
    // rust: if self.celebration_ticks >= CELEBRATION_TICKS {
    // rust: self.stop();
    // rust: return actions;
}
    // rust: if self.celebration_ticks % 20 == 0 {
    // rust: let p = player_in(self);
    // rust: self.update_players(p);
    // rust: self.bar.visible = true;
    // rust: if self.is_victory() {
    // rust: self.bar.progress = 0.0;
    // rust: self.bar.name = BarName::Victory;
    // rust: } else {
    // rust: self.bar.name = BarName::Defeat;
}
}
}
    // rust: actions
}
    /// `spawnGroup`: the wave's raiders join at `pos` (each `addWaveMob`
    /// counting its health), then the wave counter moves on.
    // rust: fn spawn_group(
    // rust: &mut self,
    // rust: level: &dyn RaidLevel,
    // rust: pos: [i32; 3],
    // rust: members: &mut Vec<RaiderInfo>,
    // rust: ) -> Vec<Spawn> {
    // rust: let wave = self.groups_spawned + 1;
    // rust: self.total_health = 0.0;
    // rust: let bonus = self.should_spawn_bonus_group(members.len());
    // rust: let spawns = self.compose_wave(wave, level.difficulty(), bonus);
    // rust: let mut join = |raid: &mut Self, kind: RaiderType| {
    // rust: members.push(RaiderInfo {
    // rust: wave,
    // rust: health: kind.health(),
    // rust: position: pos,
    // rust: in_level: true,
    // rust: ..RaiderInfo::default()
    // rust: });
    // rust: let living = living_health(members);
    // rust: raid.add_wave_mob(kind.health(), true, living);
}
    // rust: for s in &spawns {
    // rust: join(self, s.kind);
    // rust: if let Some(rider) = s.rider {
    // rust: join(self, rider);
}
}
    // rust: self.wave_spawn_pos = None;
    // rust: self.groups_spawned += 1;
    // rust: let living = living_health(members);
    // rust: self.update_bossbar(living);
    // rust: spawns
}
    /// `Raid.updateRaiders`: members that are gone, too far or idle outside
    /// the village too long leave the raid.
    // rust: fn update_raiders(
    // rust: &mut self,
    // rust: level: &dyn RaidLevel,
    // rust: members: &mut Vec<RaiderInfo>,
    // rust: actions: &mut Vec<Action>,
    // rust: ) {
    // rust: let mut leaving = Vec::new();
    // rust: for r in members.iter_mut() {
    // rust: if r.removed
    // rust: || r.other_dimension
    // rust: || dist_sqr(self.center, r.position) >= REMOVAL_THRESHOLD_SQR
    // rust: {
    // rust: leaving.push(r.id);
    // rust: } else if r.tick_count > 600 {
    // rust: if !r.in_level {
    // rust: leaving.push(r.id);
}
    // rust: if !is_village(level, r.position) && r.no_action_time > MAX_NO_ACTION_TIME {
    // rust: r.ticks_outside += 1;
    // rust: actions.push(Action::SetOutside {
    // rust: id: r.id,
    // rust: ticks: r.ticks_outside,
    // rust: });
}
    // rust: if r.ticks_outside >= OUTSIDE_RAID_BOUNDS_TIMEOUT && !leaving.contains(&r.id) {
    // rust: leaving.push(r.id);
}
}
}
    // rust: for id in leaving {
    // rust: let Some(i) = members.iter().position(|m| m.id == id) else {
    // rust: continue;
}
    // rust: let r = members.remove(i);
    // rust: let living = living_health(members);
    // rust: self.remove_from_raid(r.health, true, living);
    // rust: actions.push(Action::Remove { id });
    // rust: if r.patrol_leader {
    // rust: self.remove_leader(r.wave);
}
}
}
}

// ------------------------------------------------------------------ Raids

/// `Raids`: the raids of a dimension by id, in vanilla's
/// `Int2ObjectOpenHashMap` (its iteration order is the tick and save order).
pub const Raids = struct {
    map: BTreeMap<i32,
    order: IntOpenHashOrder,
    next_id: i32,
    tick: i32,
    /// Changed since the last save.
    dirty: bool,
};
    // rust: impl Default for Raids {
    /// `new Raids()` (dirty, so a fresh level writes its file).
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: map: BTreeMap::new(),
    // rust: order: IntOpenHashOrder::new(),
    // rust: next_id: 1,
    // rust: tick: 0,
    // rust: dirty: true,
}
}
}
    // rust: impl Raids {
pub fn get(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.get(&id)
}
pub fn get_mut(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.get_mut(&id)
}
    /// The raid ids in iteration order.
pub fn ids(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.order.iter()
}
pub fn insert(self: *Self, id: i32, raid: Raid) void {
}
    // rust: if self.map.insert(id, raid).is_none() {
    // rust: self.order.put(id);
}
}
    /// `Raids.getNearbyRaid(pos, 9216)`: the closest active raid.
pub fn nearby(self: *Self, pos: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: nearest(
    // rust: self.ids()
    // rust: .into_iter()
    // rust: .filter_map(|id| Some((id, self.map.get(&id)?))),
    // rust: pos,
    // rust: )
    // rust: .map(|id| (id, &self.map[&id]))
}
    /// `Raids.createOrExtendRaid` once the caller found the village centre
    /// (`raid_center`): the raid at that position or a new one, then the
    /// player's Raid Omen at `omen_amplifier` absorbed. Returns the raid id
    /// and whether the omen triggered it.
    // rust: pub fn create_or_extend(
    // rust: &mut self,
    // rust: raid_center: [i32; 3],
    // rust: difficulty: i32,
    // rust: omen_amplifier: Option<i32>,
    // rust: seed: i64,
    // rust: ) -> (i32, bool) {
    // rust: let id = match self.nearby(raid_center) {
    // rust: Some((id, _)) => id,
    // rust: None => {
    // rust: self.next_id += 1;
    // rust: let id = self.next_id;
    // rust: self.insert(id, Raid::new(raid_center, difficulty, seed));
    // rust: id
}
}
    // rust: let mut triggered = false;
    // rust: if let Some(raid) = self.map.get_mut(&id)
    // rust: && (!raid.started || raid.omen_level < MAX_OMEN_LEVEL)
    // rust: && let Some(amp) = omen_amplifier
    // rust: {
    // rust: triggered = raid.absorb_omen(amp);
}
    // rust: self.dirty = true;
    // rust: (id, triggered)
}
    /// `Raids.tick`: each raid in map order (stopped ones removed, every
    /// raid stopped when the `raids` rule is off). `members` gives a raid's
    /// raiders. Returns the raids' actions.
    // rust: pub fn tick(
    // rust: &mut self,
    // rust: level: &dyn RaidLevel,
    // rust: rules_raids: bool,
    // rust: members: &dyn Fn(i32) -> Vec<RaiderInfo>,
    // rust: ) -> Vec<(i32, Action)> {
    // rust: self.tick += 1;
    // rust: let mut out = Vec::new();
    // rust: let map = &mut self.map;
    // rust: let mut removed_any = false;
    // rust: let ids = self.order.iter();
    // rust: let mut visit = |id: i32| -> bool {
            // The raids in map order as they stand when this one ticks.
    // rust: let snapshot: Vec<(i32, [i32; 3], bool)> = ids
    // rust: .iter()
    // rust: .filter_map(|i| map.get(i).map(|r| (*i, r.center, r.active)))
    // rust: .collect();
    // rust: let Some(raid) = map.get_mut(&id) else {
    // rust: return false;
}
    // rust: if !rules_raids {
    // rust: raid.stop();
}
    // rust: if raid.is_stopped() {
    // rust: removed_any = true;
    // rust: return true;
}
    // rust: let order = &snapshot;
    // rust: let in_raid = |r: &Raid, pos: [i32; 3]| {
    // rust: let mut best: Option<(i32, f64)> = None;
    // rust: for (i, c, active) in order {
    // rust: let (c, active) = if *i == id {
    // rust: (r.center, r.active)
    // rust: } else {
    // rust: (*c, *active)
}
    // rust: let d = dist_sqr(c, pos);
    // rust: if active && d < best.map_or(VALID_RAID_RADIUS_SQR, |b| b.1) {
    // rust: best = Some((*i, d));
}
}
    // rust: best.is_some_and(|b| b.0 == id)
}
    // rust: for a in raid.tick(level, &members(id), &in_raid) {
    // rust: out.push((id, a));
}
    // rust: false
}
    // rust: let gone = self.order.iterate_removing(&mut visit);
    // rust: for id in gone {
    // rust: map.remove(&id);
}
    // rust: if removed_any || self.tick % 200 == 0 {
    // rust: self.dirty = true;
}
        // Raid.tick marks the data dirty while a raid runs.
    // rust: if self
    // rust: .map
    // rust: .values()
    // rust: .any(|r| r.status == Status::Ongoing && r.active)
    // rust: {
    // rust: self.dirty = true;
}
    // rust: out
}

    /// `Raids.CODEC`: `{raids: [...], next_id, tick}` in the entry set's
    /// stream order.
pub fn to_nbt(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raids: Vec<Tag> = self
    // rust: .order
    // rust: .stream()
    // rust: .into_iter()
    // rust: .map(|id| {
    // rust: let mut tag = self.map[&id].to_nbt();
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.insert("id".into(), Tag::Int(id));
}
    // rust: tag
    // rust: })
    // rust: .collect();
    // rust: let mut tag = Tag::compound([
    // rust: ("next_id", Tag::Int(self.next_id)),
    // rust: ("tick", Tag::Int(self.tick)),
    // rust: ]);
        // optionalFieldOf("raids", List.of()) leaves the default out.
    // rust: if !raids.is_empty()
    // rust: && let Tag::Compound(map) = &mut tag
    // rust: {
    // rust: map.insert("raids".into(), Tag::List(raids));
}
    // rust: tag
}
    /// `Raids.CODEC.parse(...).resultOrPartial()`, or a fresh `Raids` when
    /// nothing decodes. Raids that fail to decode are dropped; a raid whose
    /// heroes partly fail keeps the others.
pub fn from_nbt(tag: *Tag, seed: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(decoded) = decode_raids(tag) else {
    // rust: return Self::default();
}
    // rust: let mut out = Self {
    // rust: dirty: false,
    // rust: next_id: decoded.next_id,
    // rust: tick: decoded.tick,
    // rust: ..Self::default()
}
    // rust: for (i, (id, raid)) in decoded.raids.into_iter().enumerate() {
    // rust: let mut raid = raid;
    // rust: raid.random = LegacyRandom::new(seed.wrapping_add(i as i64));
            // Int2ObjectOpenHashMap.put: a repeated id replaces the raid.
    // rust: out.map.insert(id, raid);
    // rust: out.order.put(id);
}
    // rust: out
}
}
/// The id of the closest active raid within 96 blocks (`getNearbyRaid`).
    // rust: fn nearest<'a>(raids: impl Iterator<Item = (i32, &'a Raid)>, pos: [i32; 3]) -> Option<i32> {
    // rust: let mut best: Option<(i32, f64)> = None;
    // rust: for (id, r) in raids {
    // rust: let d = dist_sqr(r.center, pos);
    // rust: if r.active && d < best.map_or(VALID_RAID_RADIUS_SQR, |b| b.1) {
    // rust: best = Some((id, d));
}
}
    // rust: best.map(|b| b.0)
}

/// `Raids.createOrExtendRaid`'s centre: the mean of the occupied village
/// points of interest within 64 blocks (`BlockPos.containing`), else the
/// omen's position.
pub fn raid_center(omen_pos: [i32; 3], village_pois: *[[i32; 3]]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let near: Vec<&[i32; 3]> = village_pois
    // rust: .iter()
    // rust: .filter(|p| {
    // rust: (0..3).all(|i| i == 1 || (p[i] - omen_pos[i]).abs() <= 64)
    // rust: && dist_sqr(**p, omen_pos) <= 4096.0
    // rust: })
    // rust: .collect();
    // rust: if near.is_empty() {
    // rust: return omen_pos;
}
    // rust: let mut total = [0.0f64; 3];
    // rust: for p in &near {
    // rust: for i in 0..3 {
    // rust: total[i] += f64::from(p[i]);
}
}
    // rust: let scale = 1.0 / near.len() as f64;
    // rust: [
    // rust: (total[0] * scale).floor() as i32,
    // rust: (total[1] * scale).floor() as i32,
    // rust: (total[2] * scale).floor() as i32,
    // rust: ]
}

// ------------------------------------------------------------------ codec

    // rust: impl Raid {
    /// `Raid.MAP_CODEC` fields.
pub fn to_nbt(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([
    // rust: ("started", Tag::Byte(i8::from(self.started))),
    // rust: ("active", Tag::Byte(i8::from(self.active))),
    // rust: ("ticks_active", Tag::Long(self.ticks_active)),
    // rust: ("raid_omen_level", Tag::Int(self.omen_level)),
    // rust: ("groups_spawned", Tag::Int(self.groups_spawned)),
    // rust: ("cooldown_ticks", Tag::Int(self.cooldown_ticks)),
    // rust: ("post_raid_ticks", Tag::Int(self.post_raid_ticks)),
    // rust: ("total_health", Tag::Float(self.total_health.to_bits())),
    // rust: ("group_count", Tag::Int(self.num_groups)),
    // rust: ("status", Tag::String(self.status.name().into())),
    // rust: ("center", Tag::IntArray(self.center.to_vec())),
    // rust: (
    // rust: "heroes_of_the_village",
    // rust: Tag::List(
    // rust: self.heroes()
    // rust: .iter()
    // rust: .map(|u| Tag::IntArray(u.to_vec()))
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: ])
}
    /// The private codec constructor: a loaded raid's bar is visible with
    /// full progress until the raid updates it.
pub fn loaded(fields: RaidFields) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut raid = Self::new(fields.center, 0, 0);
    // rust: raid.started = fields.started;
    // rust: raid.active = fields.active;
    // rust: raid.ticks_active = fields.ticks_active;
    // rust: raid.omen_level = fields.omen_level;
    // rust: raid.groups_spawned = fields.groups_spawned;
    // rust: raid.cooldown_ticks = fields.cooldown_ticks;
    // rust: raid.post_raid_ticks = fields.post_raid_ticks;
    // rust: raid.total_health = fields.total_health;
    // rust: raid.num_groups = fields.num_groups;
    // rust: raid.status = fields.status;
        // Sets.newHashSet(list), then addAll into the raid's own set.
    // rust: let cap = java_table_size_for(java_hash_set_capacity(fields.heroes.len()));
    // rust: let mut unique: Vec<[i32; 4]> = Vec::new();
    // rust: for h in fields.heroes {
    // rust: if !unique.contains(&h) {
    // rust: unique.push(h);
}
}
    // rust: raid.heroes = java_hash_set_order(&unique, cap);
    // rust: raid.bar.progress = 1.0;
    // rust: raid
}
}

pub const RaidFields = struct {
    started: bool,
    active: bool,
    ticks_active: i64,
    omen_level: i32,
    groups_spawned: i32,
    cooldown_ticks: i32,
    post_raid_ticks: i32,
    total_health: f32,
    num_groups: i32,
    status: Status,
    center: [i32,
    heroes: Vec<[i32,
};

/// A DataFixerUpper result: a value, and whether an error was reported
/// (`Some` with an error is a partial result).
    // rust: type Decoded<T> = (Option<T>, bool);

/// `NbtOps.getNumberValue`: the numeric tags as Java numbers.
pub const Number = enum {
    Long(i64),
    Float(f32),
    Double(f64),
};
pub fn number(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match tag {
    // rust: Tag::Byte(v) => Number::Long(i64::from(*v)),
    // rust: Tag::Short(v) => Number::Long(i64::from(*v)),
    // rust: Tag::Int(v) => Number::Long(i64::from(*v)),
    // rust: Tag::Long(v) => Number::Long(*v),
    // rust: Tag::Float(b) => Number::Float(f32::from_bits(*b)),
    // rust: Tag::Double(b) => Number::Double(f64::from_bits(*b)),
    // rust: _ => return None,
    // rust: })
}
    // rust: impl Number {
    /// `Number.intValue`: integers truncate, floating values convert like
    /// Java's `(int)` cast.
pub fn int(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Long(v) => v as i32,
    // rust: Self::Float(v) => v as i32,
    // rust: Self::Double(v) => v as i32,
}
}
pub fn long(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Long(v) => v,
    // rust: Self::Float(v) => v as i64,
    // rust: Self::Double(v) => v as i64,
}
}
pub fn float(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Long(v) => v as f32,
    // rust: Self::Float(v) => v,
    // rust: Self::Double(v) => v as f32,
}
}
pub fn double(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Long(v) => v as f64,
    // rust: Self::Float(v) => f64::from(v),
    // rust: Self::Double(v) => v,
}
}
}
/// `DynamicOps.getIntStream` through `NbtOps`: an int array, or a list or
/// array whose elements are all numbers.
pub fn int_stream(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::IntArray(v) => Some(v.clone()),
    // rust: Tag::ByteArray(v) => Some(v.iter().map(|b| i32::from(*b as i8)).collect()),
    // rust: Tag::LongArray(v) => Some(v.iter().map(|l| *l as i32).collect()),
    // rust: Tag::List(items) => items.iter().map(|t| number(t).map(Number::int)).collect(),
    // rust: _ => None,
}
}
/// `ops.getList`: the elements of any collection tag.
pub fn collection(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::List(items) => Some(items.clone()),
    // rust: Tag::ByteArray(v) => Some(v.iter().map(|b| Tag::Byte(*b as i8)).collect()),
    // rust: Tag::IntArray(v) => Some(v.iter().map(|i| Tag::Int(*i)).collect()),
    // rust: Tag::LongArray(v) => Some(v.iter().map(|i| Tag::Long(*i)).collect()),
    // rust: _ => None,
}
}
    // rust: fn field<'a>(tag: &'a Tag, key: &str) -> Option<&'a Tag> {
    // rust: match tag {
    // rust: Tag::Compound(map) => map.get(&JavaString::from(key)),
    // rust: _ => None,
}
}
/// `Codec.list(UUIDUtil.CODEC)`: good entries kept, an error if any failed.
pub fn decode_uuids(tag: *Tag) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(items) = collection(tag) else {
    // rust: return (None, true);
}
    // rust: let mut out = Vec::new();
    // rust: let mut error = false;
    // rust: for item in &items {
        // Util.fixedSize: a longer stream is a partial result of its start.
    // rust: match int_stream(item) {
    // rust: Some(v) if v.len() >= 4 => {
    // rust: error |= v.len() > 4;
    // rust: out.push([v[0], v[1], v[2], v[3]]);
}
    // rust: _ => error = true,
}
}
    // rust: (Some(out), error)
}
/// `Raid.MAP_CODEC` over a compound (missing or mistyped fields fail with
/// no partial result; a partial heroes list leaves a partial raid).
pub fn decode_raid(tag: *Tag) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let num = |k: &str| field(tag, k).and_then(number);
    // rust: let (
    // rust: Some(started),
    // rust: Some(active),
    // rust: Some(ticks_active),
    // rust: Some(omen),
    // rust: Some(groups),
    // rust: Some(cooldown),
    // rust: Some(post),
    // rust: Some(health),
    // rust: Some(count),
    // rust: ) = (
    // rust: num("started"),
    // rust: num("active"),
    // rust: num("ticks_active"),
    // rust: num("raid_omen_level"),
    // rust: num("groups_spawned"),
    // rust: num("cooldown_ticks"),
    // rust: num("post_raid_ticks"),
    // rust: num("total_health"),
    // rust: num("group_count"),
    // rust: )
    // rust: else {
    // rust: return (None, true);
}
    // rust: let status = match field(tag, "status") {
    // rust: Some(Tag::String(s)) => Status::from_name(&s.to_string_lossy()),
    // rust: _ => None,
}
    // Util.fixedSize: a longer stream is a partial result of its start.
    // rust: let center = field(tag, "center")
    // rust: .and_then(int_stream)
    // rust: .filter(|v| v.len() >= 3);
    // rust: let (Some(status), Some(center)) = (status, center) else {
    // rust: return (None, true);
}
    // rust: let Some(heroes_tag) = field(tag, "heroes_of_the_village") else {
    // rust: return (None, true);
}
    // rust: let (heroes, error) = decode_uuids(heroes_tag);
    // rust: let Some(heroes) = heroes else {
    // rust: return (None, true);
}
    // rust: let fields = RaidFields {
    // rust: started: started.double() != 0.0,
    // rust: active: active.double() != 0.0,
    // rust: ticks_active: ticks_active.long(),
    // rust: omen_level: omen.int(),
    // rust: groups_spawned: groups.int(),
    // rust: cooldown_ticks: cooldown.int(),
    // rust: post_raid_ticks: post.int(),
    // rust: total_health: health.float(),
    // rust: num_groups: count.int(),
    // rust: status,
    // rust: center: [center[0], center[1], center[2]],
    // rust: heroes,
}
    // rust: (Some(fields), error)
}
pub const DecodedRaids = struct {
    raids: Vec<(i32,
    next_id: i32,
    tick: i32,
};
/// `Raids.CODEC` with `resultOrPartial`.
pub fn decode_raids(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !matches!(tag, Tag::Compound(_)) {
    // rust: return None;
}
    // rust: let mut raids = Vec::new();
    // rust: if let Some(list) = field(tag, "raids") {
        // optionalFieldOf: a value that is no list decodes partially, to none.
    // rust: let items = collection(list).unwrap_or_default();
    // rust: for item in &items {
    // rust: let id = field(item, "id").and_then(number);
    // rust: let (raid, _) = if matches!(item, Tag::Compound(_)) {
    // rust: decode_raid(item)
    // rust: } else {
    // rust: (None, true)
}
    // rust: if let (Some(id), Some(raid)) = (id, raid) {
    // rust: raids.push((id.int(), Raid::loaded(raid)));
}
}
}
    // rust: let next_id = field(tag, "next_id").and_then(number)?.int();
    // rust: let tick = field(tag, "tick").and_then(number)?.int();
    // rust: Some(DecodedRaids {
    // rust: raids,
    // rust: next_id,
    // rust: tick,
    // rust: })
}

// ------------------------------------------------------------------ Java collections

/// `HashMap.hash` of a `UUID` built from its four ints.
pub fn uuid_hash(u: [i32; 4]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let most = (i64::from(u[0]) << 32) | (i64::from(u[1]) & 0xffff_ffff);
    // rust: let least = (i64::from(u[2]) << 32) | (i64::from(u[3]) & 0xffff_ffff);
    // rust: let hilo = most ^ least;
    // rust: let h = ((hilo >> 32) as i32) ^ (hilo as i32);
    // rust: h ^ ((h as u32) >> 16) as i32
}
/// `HashSet(Collection)`'s requested capacity (JDK 19+: `newHashMap(max(n, 12))`).
pub fn java_hash_set_capacity(n: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (n.max(12) as f64 / 0.75).ceil() as usize
}
/// `HashMap.tableSizeFor`.
pub fn java_table_size_for(cap: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cap.max(1).next_power_of_two()
}
/// The iteration order of a `HashSet<UUID>` whose table started at
/// `capacity` (doubling past three quarters full), given insertion order.
pub fn java_hash_set_order(items: *[[i32; 4]], capacity: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cap = capacity.max(1);
    // rust: while items.len() as f64 > cap as f64 * 0.75 {
    // rust: cap *= 2;
}
    // rust: let mut keyed: Vec<(usize, usize)> = items
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, u)| ((uuid_hash(*u) as u32 as usize) & (cap - 1), i))
    // rust: .collect();
    // rust: keyed.sort();
    // rust: keyed.into_iter().map(|(_, i)| items[i]).collect()
}

/// `HashCommon.mix` for ints.
pub fn mix(x: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = x.wrapping_mul(0x9E37_79B9_u32 as i32);
    // rust: h ^ ((h as u32) >> 16) as i32
}
pub fn array_size(expected: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((expected as f64 / 0.75).ceil() as usize)
    // rust: .next_power_of_two()
    // rust: .max(2)
}
pub fn max_fill(n: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((n as f64 * 0.75).ceil() as usize).min(n - 1)
}
/// The key layout of a fastutil `Int2ObjectOpenHashMap` (default size and
/// load factor), for its iteration order.
pub const IntOpenHashOrder = struct {
    key: std.ArrayList(i32),
    null_key: bool,
    n: usize,
    min_n: usize,
    size: usize,
};
    // rust: impl IntOpenHashOrder {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = array_size(16);
    // rust: Self {
    // rust: key: vec![0; n],
    // rust: null_key: false,
    // rust: n,
    // rust: min_n: n,
    // rust: size: 0,
}
}
pub fn mask(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.n - 1
}
pub fn slot(self: *Self, k: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (mix(k) as u32 as usize) & self.mask()
}
pub fn find(self: *Self, k: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if k == 0 {
    // rust: return self.null_key.then_some(self.n);
}
    // rust: let mut pos = self.slot(k);
    // rust: loop {
    // rust: match self.key[pos] {
    // rust: 0 => return None,
    // rust: c if c == k => return Some(pos),
    // rust: _ => pos = (pos + 1) & self.mask(),
}
}
}
pub fn put(self: *Self, k: i32) void {
}
    // rust: if self.find(k).is_some() {
    // rust: return;
}
    // rust: if k == 0 {
    // rust: self.null_key = true;
    // rust: } else {
    // rust: let mut pos = self.slot(k);
    // rust: while self.key[pos] != 0 {
    // rust: pos = (pos + 1) & self.mask();
}
    // rust: self.key[pos] = k;
}
    // rust: let before = self.size;
    // rust: self.size += 1;
    // rust: if before >= max_fill(self.n) {
    // rust: self.rehash(array_size(self.size + 1));
}
}
pub fn rehash(self: *Self, new_n: usize) void {
}
    // rust: let mask = new_n - 1;
    // rust: let mut new_key = vec![0; new_n];
    // rust: let mut i = self.n;
    // rust: let real = self.size - usize::from(self.null_key);
    // rust: for _ in 0..real {
    // rust: loop {
    // rust: i -= 1;
    // rust: if self.key[i] != 0 {
    // rust: break;
}
}
    // rust: let k = self.key[i];
    // rust: let mut pos = (mix(k) as u32 as usize) & mask;
    // rust: while new_key[pos] != 0 {
    // rust: pos = (pos + 1) & mask;
}
    // rust: new_key[pos] = k;
}
    // rust: self.n = new_n;
    // rust: self.key = new_key;
}
    /// `shiftKeys` after the key at `pos` went; returns keys that wrapped
    /// from the start of the table to its end.
pub fn shift_keys(self: *Self, mut pos: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut wrapped = Vec::new();
    // rust: let mask = self.mask();
    // rust: loop {
    // rust: let last = pos;
    // rust: pos = (last + 1) & mask;
    // rust: let curr = loop {
    // rust: let curr = self.key[pos];
    // rust: if curr == 0 {
    // rust: self.key[last] = 0;
    // rust: return wrapped;
}
    // rust: let slot = (mix(curr) as u32 as usize) & mask;
    // rust: let moves = if last <= pos {
    // rust: last >= slot || slot > pos
    // rust: } else {
    // rust: last >= slot && slot > pos
}
    // rust: if moves {
    // rust: break curr;
}
    // rust: pos = (pos + 1) & mask;
}
    // rust: if pos < last {
    // rust: wrapped.push(curr);
}
    // rust: self.key[last] = curr;
}
}
    /// `remove(k)`, shrinking a sparse table.
pub fn remove(self: *Self, k: i32) void {
}
    // rust: if k == 0 {
    // rust: if self.null_key {
    // rust: self.null_key = false;
    // rust: self.size -= 1;
}
    // rust: return;
}
    // rust: let Some(pos) = self.find(k) else { return };
    // rust: self.size -= 1;
    // rust: self.shift_keys(pos);
    // rust: if self.n > self.min_n && self.size < max_fill(self.n) / 4 && self.n > 16 {
    // rust: self.rehash(self.n / 2);
}
}
    /// The entry set's stream (`MapSpliterator`): the null key, then the
    /// table upward. `Raids.CODEC` encodes in this order.
pub fn stream(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: if self.null_key {
    // rust: out.push(0);
}
    // rust: out.extend(self.key[..self.n].iter().copied().filter(|k| *k != 0));
    // rust: out
}
    /// The iterator (`MapIterator`): the null key, then the table downward.
pub fn iter(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: if self.null_key {
    // rust: out.push(0);
}
    // rust: for pos in (0..self.n).rev() {
    // rust: if self.key[pos] != 0 {
    // rust: out.push(self.key[pos]);
}
}
    // rust: out
}
    /// A `values().iterator()` pass that removes the keys `visit` says to
    /// (the iterator's own removal, with wrapped entries); returns them.
pub fn iterate_removing(self: *Self, visit: *mut dyn FnMut(i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut removed = Vec::new();
    // rust: let mut pos = self.n as isize;
    // rust: let mut c = self.size;
    // rust: let mut must_null = self.null_key;
    // rust: let mut wrapped: Vec<i32> = Vec::new();
    // rust: while c > 0 {
    // rust: c -= 1;
            // nextEntry
    // rust: let (k, last): (i32, Option<usize>) = if must_null {
    // rust: must_null = false;
    // rust: (0, Some(self.n))
    // rust: } else {
    // rust: loop {
    // rust: pos -= 1;
    // rust: if pos < 0 {
    // rust: let k = wrapped[(-pos - 1) as usize];
    // rust: break (k, None);
}
    // rust: if self.key[pos as usize] != 0 {
    // rust: break (self.key[pos as usize], Some(pos as usize));
}
}
}
    // rust: if visit(k) {
    // rust: removed.push(k);
    // rust: match last {
    // rust: Some(l) if l == self.n => {
    // rust: self.null_key = false;
    // rust: self.size -= 1;
}
    // rust: Some(l) => {
    // rust: wrapped.extend(self.shift_keys(l));
    // rust: self.size -= 1;
}
    // rust: None => self.remove(k),
}
}
}
    // rust: removed
}
}

    // rust: mod tests {
//     use super::*;

pub const Level = struct {
    difficulty: i32,
    village: bool,
    loaded: bool,
};
    // rust: impl RaidLevel for Level {
pub fn difficulty(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.difficulty
}
pub fn has_chunk_at(self: *Self, _: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.loaded
}
pub fn has_chunks_at(self: *Self, _: i32, _: i32, _: i32, _: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn sections_to_village(self: *Self, _: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.village { 0 } else { 7 }
}
pub fn surface_height(self: *Self, _: i32, _: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 64
}
pub fn is_position_entity_ticking(self: *Self, _: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn ravager_can_spawn(self: *Self, _: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn player(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
}
pub fn level(difficulty: i32) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Level {
    // rust: difficulty,
    // rust: village: true,
    // rust: loaded: true,
}
}
pub fn nobody(_: *Raid, _: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn count(spawns: *[Spawn], kind: RaiderType) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: spawns.iter().filter(|s| s.kind == kind).count()
}

pub fn waves_per_difficulty() void {
}
    // rust: assert_eq!(num_groups(0), 0);
    // rust: assert_eq!(num_groups(1), 3);
    // rust: assert_eq!(num_groups(2), 5);
    // rust: assert_eq!(num_groups(3), 7);
}
pub fn ravagers_carry_riders_by_wave() void {
}
    // rust: let mut raid = Raid::new([0, 64, 0], 3, 7);
    // rust: let w5 = raid.compose_wave(5, 3, false);
    // rust: assert!(
    // rust: w5.iter()
    // rust: .filter(|s| s.kind == RaiderType::Ravager)
    // rust: .all(|s| s.rider == Some(RaiderType::Pillager))
    // rust: );
    // rust: let w7 = raid.compose_wave(7, 3, false);
    // rust: let riders: Vec<_> = w7
    // rust: .iter()
    // rust: .filter(|s| s.kind == RaiderType::Ravager)
    // rust: .map(|s| s.rider)
    // rust: .collect();
    // rust: assert_eq!(riders[0], Some(RaiderType::Evoker));
    // rust: assert!(
    // rust: riders[1..]
    // rust: .iter()
    // rust: .all(|r| *r == Some(RaiderType::Vindicator))
    // rust: );
    // rust: assert_eq!(count(&w7, RaiderType::Evoker), 2);
}
pub fn only_able_raiders_lead() void {
}
    // rust: let mut raid = Raid::new([0, 64, 0], 2, 1);
    // rust: let w = raid.compose_wave(4, 2, false);
    // rust: assert_eq!(w.iter().filter(|s| s.leader).count(), 1);
    // rust: assert!(w.iter().find(|s| s.leader).unwrap().kind.can_be_leader());
}
pub fn omen_levels_stack_and_clamp() void {
}
    // rust: let mut raid = Raid::new([0, 64, 0], 2, 1);
    // rust: assert!(raid.absorb_omen(0));
    // rust: assert_eq!(raid.omen_level, 1);
    // rust: raid.absorb_omen(4);
    // rust: assert_eq!(raid.omen_level, 5);
    // rust: assert_eq!(raid.enchant_odds(), 0.75);
}
pub fn a_raid_counts_down_then_spawns_a_wave() void {
}
    // rust: let l = level(2);
    // rust: let mut raid = Raid::new([0, 64, 0], 2, 3);
    // rust: raid.absorb_omen(0);
    // rust: let mut spawned = None;
    // rust: for _ in 0..400 {
    // rust: for a in raid.tick(&l, &[], &nobody) {
    // rust: if let Action::Spawn { wave, spawns, .. } = a {
    // rust: spawned = Some((wave, spawns));
}
}
    // rust: if spawned.is_some() {
    // rust: break;
}
}
    // rust: let (wave, spawns) = spawned.expect("a wave");
    // rust: assert_eq!(wave, 1);
    // rust: assert!(count(&spawns, RaiderType::Pillager) >= 4);
    // rust: assert_eq!(raid.bar.progress, 1.0);
    // rust: assert!(raid.started);
}
pub fn losing_the_village_after_a_wave_loses_the_raid() void {
}
    // rust: let mut l = level(2);
    // rust: let mut raid = Raid::new([0, 64, 0], 2, 3);
    // rust: raid.groups_spawned = 1;
    // rust: l.village = false;
    // rust: raid.tick(&l, &[], &nobody);
    // rust: assert!(raid.is_loss());
    // rust: let mut fresh = Raid::new([0, 64, 0], 2, 3);
    // rust: fresh.tick(&l, &[], &nobody);
    // rust: assert!(fresh.is_stopped());
}
pub fn peaceful_stops_raids() void {
}
    // rust: let mut raid = Raid::new([0, 64, 0], 2, 3);
    // rust: raid.tick(&level(0), &[], &nobody);
    // rust: assert!(raid.is_stopped());
}
    /// 13/32 of the way from the origin to a centre 32 blocks east is 13.
    /// A player 32 blocks east of the centre hears it 13 blocks back, at 19.
    /// 80 blocks away is outside the 64 block reach.
pub fn the_raid_horn_sits_thirteen_blocks_toward_the_wave() void {
}
    // rust: assert_eq!(
    // rust: horn_at([0.0, 70.0, 0.0], 32.0, 0.0, false),
    // rust: Some([13.0, 70.0, 0.0])
    // rust: );
    // rust: assert_eq!(
    // rust: horn_at([32.0, 70.0, 0.0], 0.0, 0.0, false),
    // rust: Some([19.0, 70.0, 0.0])
    // rust: );
    // rust: assert_eq!(horn_at([80.0, 70.0, 0.0], 0.0, 0.0, false), None);
    // rust: assert_eq!(
    // rust: horn_at([80.0, 70.0, 0.0], 0.0, 0.0, true),
    // rust: Some([67.0, 70.0, 0.0])
    // rust: );
}
pub fn bar_progress_follows_java_clamp() void {
}
    // rust: let mut raid = Raid::new([0, 64, 0], 2, 3);
    // rust: raid.update_bossbar(0.0);
    // rust: assert!(raid.bar.progress.is_nan());
    // rust: raid.total_health = 48.0;
    // rust: raid.update_bossbar(24.0);
    // rust: assert_eq!(raid.bar.progress, 0.5);
}
pub fn raids_round_trip_through_nbt() void {
}
    // rust: let mut raids = Raids::default();
    // rust: let (id, triggered) = raids.create_or_extend([10, 64, 10], 2, Some(1), 5);
    // rust: assert!(triggered);
    // rust: assert_eq!(id, 2);
    // rust: raids.get_mut(id).unwrap().add_hero([1, 2, 3, 4]);
    // rust: let tag = raids.to_nbt();
    // rust: let back = Raids::from_nbt(&tag, 0);
    // rust: assert_eq!(back.next_id, 2);
    // rust: let r = back.get(id).unwrap();
    // rust: assert_eq!(r.omen_level, 2);
    // rust: assert_eq!(r.heroes(), vec![[1, 2, 3, 4]]);
    // rust: assert_eq!(back.to_nbt(), tag);
}
pub fn a_second_omen_extends_the_nearby_raid() void {
}
    // rust: let mut raids = Raids::default();
    // rust: let (a, _) = raids.create_or_extend([0, 64, 0], 2, Some(0), 1);
    // rust: let (b, triggered) = raids.create_or_extend([20, 64, 0], 2, Some(0), 2);
    // rust: assert_eq!(a, b);
    // rust: assert!(triggered);
    // rust: assert_eq!(raids.get(a).unwrap().omen_level, 2);
}
pub fn fastutil_order_iterates_from_the_top_of_the_table() void {
}
    // rust: let mut o = IntOpenHashOrder::new();
    // rust: for k in 2..40 {
    // rust: o.put(k);
}
    // rust: let it = o.iter();
    // rust: assert_eq!(it.len(), 38);
    // rust: let mut sorted = it.clone();
    // rust: sorted.sort();
    // rust: assert_eq!(sorted, (2..40).collect::<Vec<_>>());
    // rust: let mut seen = Vec::new();
    // rust: let removed = o.iterate_removing(&mut |k| {
    // rust: seen.push(k);
    // rust: k % 3 == 0
    // rust: });
    // rust: assert_eq!(seen.len(), 38);
    // rust: assert_eq!(o.iter().len(), 38 - removed.len());
}
pub fn the_centre_is_the_mean_of_nearby_points() void {
}
    // rust: assert_eq!(raid_center([0, 64, 0], &[]), [0, 64, 0]);
    // rust: assert_eq!(
    // rust: raid_center([0, 64, 0], &[[10, 64, 10], [11, 65, 10], [200, 64, 0]]),
    // rust: [10, 64, 10]
    // rust: );
}
}
