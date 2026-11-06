//! Transpiled from Horizon Rust crate
//! Module: horizon-client_dragon
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The ender dragon fight (`EnderDragonFight`, `EnderDragon`, its phases,
//! `EndCrystal`, `DragonFireball`): the fight state saved in the End's
//! `ender_dragon_fight.dat`, the dragon spawned over the island, the
//! holding pattern over the 24-node path graph, strafing with fireballs,
//! landing on the podium to breathe and charge, healing from the crystals on
//! the spikes, its parts (head and neck take full damage, the rest a quarter
//! plus one), wing knockback, block breaking, the death flight and rays, the
//! exit portal, the egg and the next gateway; and its rendering and boss bar.
// use super::{
    // rust: Dim, Game,
    // rust: potions::{Victim, mob_can_be_affected},
}
// use horizon_client::{
    // rust: health::HurtSource,
    // rust: hud::HudBatch,
    // rust: hud_layout, hud_overlays,
    // rust: mesher::Vertex,
    // rust: mobs::{Damage, DamageKind, Who},
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: projectiles::ProjectileKind,
    // rust: text::Text,
}
// use horizon_core::position::BlockPos;
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_protocol::entity_data::Value;
// use horizon_world::nbt::Tag;

/// `HealOrHarmMobEffect.applyInstantaneousEffect` at an `AreaEffectCloud`'s
/// 0.5 scale: `(int) (scale * (6 << amplifier) + 0.5)`.
pub fn harm_amount(amplifier: u32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0.5 * f64::from(6u32 << amplifier) + 0.5) as i32 as f32
}

/// Whether a cloud at `at` (its floor) reaches a living entity: its box is
/// `radius * 2` wide and 0.5 tall, and the entity's position must lie within
/// the radius horizontally.
pub fn cloud_hits(at: [f64; 3], radius: f32, bounds: Aabb, pos: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = f64::from(radius);
    // rust: let area = Aabb::new(
    // rust: Vec3::new(at[0] - r, at[1], at[2] - r),
    // rust: Vec3::new(at[0] + r, at[1] + 0.5, at[2] + r),
    // rust: );
    // rust: let (dx, dz) = (pos.x - at[0], pos.z - at[2]);
    // rust: bounds.intersects(area) && dx * dx + dz * dz <= f64::from(radius * radius)
}

/// `AreaEffectCloud.WAIT_TIME` default: the cloud is inert for its first 20
/// ticks (no radius growth, no effects).
pub const BREATH_WAIT: i32 = 20;

/// `AreaEffectCloud.serverTick`: discarded once `tickCount - waitTime >=
/// duration`, so the wait does not count against the duration.
    // rust: pub(super) fn breath_expired(age: i32, duration: i32) -> bool {
    // rust: age - BREATH_WAIT >= duration
}

/// `AreaEffectCloud.serverTick` victims: every 5 ticks after the wait, drop
/// entries whose delay (`reapplicationDelay` 20) has passed, then return the
/// candidates not in the map, recording them until `age + 20`.
    // rust: fn breath_victims<T: Copy + PartialEq>(
    // rust: age: i32,
    // rust: victims: &mut Vec<(T, i32)>,
    // rust: candidates: impl IntoIterator<Item = T>,
    // rust: ) -> Vec<T> {
    // rust: if age < BREATH_WAIT || age % 5 != 0 {
    // rust: return Vec::new();
}
    // rust: victims.retain(|&(_, until)| age < until);
    // rust: let mut hit = Vec::new();
    // rust: for who in candidates {
    // rust: if !victims.iter().any(|&(v, _)| v == who) {
    // rust: victims.push((who, age + 20));
    // rust: hit.push(who);
}
}
    // rust: hit
}

/// `DragonFireball.onHit`: the cloud moves to the first living entity in the
/// fireball's box inflated by (4, 2, 4) that is within 4 blocks of it.
/// `feet` is the fireball's position (the bottom of its 1x1x1 box).
pub fn fireball_cloud_origin(feet: [f64; 3], targets: *[(Aabb) void {
}
    // rust: let area = Aabb::new(
    // rust: Vec3::new(feet[0] - 4.5, feet[1] - 2.0, feet[2] - 4.5),
    // rust: Vec3::new(feet[0] + 4.5, feet[1] + 3.0, feet[2] + 4.5),
    // rust: );
    // rust: for (bounds, pos) in targets {
    // rust: let (dx, dy, dz) = (pos.x - feet[0], pos.y - feet[1], pos.z - feet[2]);
    // rust: if bounds.intersects(area) && dx * dx + dy * dy + dz * dz < 16.0 {
    // rust: return [pos.x, pos.y, pos.z];
}
}
    // rust: feet
}

/// Mob ids from here on are dragon parts (`SPECIAL + part`) and crystals
/// (`SPECIAL + 16 + crystal`), so projectiles can target them.
    // rust: pub(super) const SPECIAL: u32 = u32::MAX - 4096;
    // rust: pub(super) const CRYSTAL_IDS: u32 = SPECIAL + 16;
pub const FIGHT_FILE: []const u8 = "data/minecraft/ender_dragon_fight.dat";
pub const MAX_HEALTH: f32 = 200.0;
/// `Mob.getAmbientSoundInterval`.
pub const AMBIENT_INTERVAL: i32 = 80;

    // rust: pub(super) struct Fight {
    // rust: loaded: bool,
    // rust: needs_scan: bool,
    // rust: pub killed: bool,
    // rust: pub previously_killed: bool,
    /// `dragonUUID`: the fight's own dragon. Only its death wins the fight
    /// (`setDragonKilled`); a dragon summoned after the fight is won is not it.
    // rust: dragon_uuid: Option<[i32; 4]>,
    /// `ticksSinceDragonSeen`: ticks since the fight's dragon last ticked
    /// (`updateDragon`); at 1200 the fight looks for another one.
    // rust: dragon_unseen: i32,
    // rust: gateways: Vec<i32>,
    // rust: exit_portal: Option<[i32; 3]>,
    // rust: alive_crystals: i32,
    // rust: crystal_scan: i32,
    /// `ticksSinceLastPlayerScan`, and whether the last scan found a player
    /// for the fight (`dragonEvent.getPlayers()` is not empty).
    // rust: player_scan: i32,
    // rust: players: bool,
    /// The spikes' crystals have been placed (worldgen does not place entities here).
    // rust: crystals_placed: bool,
    /// The respawn sequence (`DragonRespawnStage`) and its tick count.
    // rust: respawn: Option<(Respawn, i32)>,
    /// The four crystals on the exit portal driving the respawn.
    // rust: respawn_crystals: Vec<Vec3>,
    /// The player behind the blast under way, whose `explosion` damage
    /// source names them: a crystal's (`EndCrystal.hurtServer`) or a large
    /// fireball's (`Explosion.getIndirectSourceEntity`, its owner).
    // rust: blast_by: Option<FightWho>,
    /// The last hit the dragon took (`die(source)`'s source, for the
    /// `player_killed_entity` trigger's `killing_blow`): its damage type and
    /// whether a player was behind it.
    // rust: last_blow: Option<(DamageKind, bool)>,
    // rust: dirty: bool,
}
pub const Respawn = enum {
    Start,
    Preparing,
    Pillars,
    Summoning,
};
    // rust: impl Fight {
    /// `EnderDragonFight.tick`'s ticket condition: the fight's boss bar has a
    /// player (`dragonEvent.getPlayers()` is not empty), which holds the
    /// arena's `TicketType.DRAGON` ticket. The bar is scanned every 20 ticks,
    /// as `updatePlayers` is.
    // rust: pub(super) fn arena_watched(&self) -> bool {
    // rust: self.players
}
}
    // rust: impl Respawn {
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Respawn::Start => "start",
    // rust: Respawn::Preparing => "preparing_to_summon_pillars",
    // rust: Respawn::Pillars => "summoning_pillars",
    // rust: Respawn::Summoning => "summoning_dragon",
}
}
pub fn from_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: Respawn::Start,
    // rust: Respawn::Preparing,
    // rust: Respawn::Pillars,
    // rust: Respawn::Summoning,
    // rust: ]
    // rust: .into_iter()
    // rust: .find(|r| r.name() == name)
}
}
    // rust: pub(super) struct Crystal {
    /// The entity id a server tracks it by (0 until it is tracked).
    // rust: pub id: u32,
    // rust: pub position: Vec3,
    // rust: pub show_bottom: bool,
    /// EndCrystal.time (the bob and spin), starting random.
    // rust: pub time: i32,
    // rust: pub beam: Option<[i32; 3]>,
    /// `setPermanentlyInvulnerable` (respawned spike crystals).
    // rust: pub invulnerable: bool,
}
    // rust: impl Crystal {
    /// `EntityType.END_CRYSTAL`: 2 x 2.
    // rust: pub(super) fn bounds(&self) -> Aabb {
    // rust: let p = self.position;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - 1.0, p.y, p.z - 1.0),
    // rust: Vec3::new(p.x + 1.0, p.y + 2.0, p.z + 1.0),
    // rust: )
}
}
pub const Path = struct {
    nodes: Vec<[i32,
    next: usize,
};
    // rust: impl Path {
pub fn done(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next >= self.nodes.len()
}
pub fn advance(self: *Self) void {
}
    // rust: self.next += 1;
}
pub fn next_pos(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.nodes[self.next]
}
}
pub const Phase = enum {
    Holding {,
    path: Option<PathBox>,
    target: Option<Vec3>,
    clockwise: bool,
    // rust: },
    Strafe {,
    charge: i32,
    path: Option<PathBox>,
    target: Option<Vec3>,
    clockwise: bool,
        /// `attackTarget`: the player it strafes.
    player: Option<FightWho>,
    // rust: },
    LandingApproach {,
    path: Option<PathBox>,
    target: Option<Vec3>,
    // rust: },
    Landing {,
    target: Option<Vec3>,
    // rust: },
    Takeoff {,
    first: bool,
    path: Option<PathBox>,
    target: Option<Vec3>,
    // rust: },
    Scanning {,
    time: i32,
    // rust: },
    Attacking {,
    ticks: i32,
    // rust: },
    Flaming {,
    ticks: i32,
    // rust: },
    Charging {,
    target: Option<Vec3>,
    since: i32,
    // rust: },
    Dying {,
    target: Option<Vec3>,
    time: i32,
    // rust: },
    Hover {,
    target: Option<Vec3>,
    // rust: },
};
/// A path compared by identity only (phases compare by kind).
pub const PathBox = struct {};
    // rust: impl PartialEq for PathBox {
pub fn eq(self: *Self, _: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
}
    // rust: impl Phase {
    /// `EnderDragonPhase` ids.
pub fn id(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Holding { .. } => 0,
    // rust: Self::Strafe { .. } => 1,
    // rust: Self::LandingApproach { .. } => 2,
    // rust: Self::Landing { .. } => 3,
    // rust: Self::Takeoff { .. } => 4,
    // rust: Self::Flaming { .. } => 5,
    // rust: Self::Scanning { .. } => 6,
    // rust: Self::Attacking { .. } => 7,
    // rust: Self::Charging { .. } => 8,
    // rust: Self::Dying { .. } => 9,
    // rust: Self::Hover { .. } => 10,
}
}
pub fn from_id(id: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id {
    // rust: 1 => Self::Strafe {
    // rust: charge: 0,
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: player: None,
    // rust: },
    // rust: 2 => Self::LandingApproach {
    // rust: path: None,
    // rust: target: None,
    // rust: },
    // rust: 3 => Self::Landing { target: None },
    // rust: 4 => Self::Takeoff {
    // rust: first: true,
    // rust: path: None,
    // rust: target: None,
    // rust: },
    // rust: 5 => Self::Flaming { ticks: 0 },
    // rust: 6 => Self::Scanning { time: 0 },
    // rust: 7 => Self::Attacking { ticks: 0 },
    // rust: 8 => Self::Charging {
    // rust: target: None,
    // rust: since: 0,
    // rust: },
    // rust: 9 => Self::Dying {
    // rust: target: None,
    // rust: time: 0,
    // rust: },
    // rust: 10 => Self::Hover { target: None },
    // rust: _ => Self::Holding {
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: },
}
}
pub fn sitting(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self,
    // rust: Self::Scanning { .. }
    // rust: | Self::Attacking { .. }
    // rust: | Self::Flaming { .. }
    // rust: | Self::Hover { .. }
    // rust: )
}
pub fn target(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Holding { target, .. }
    // rust: | Self::Strafe { target, .. }
    // rust: | Self::LandingApproach { target, .. }
    // rust: | Self::Landing { target }
    // rust: | Self::Takeoff { target, .. }
    // rust: | Self::Charging { target, .. }
    // rust: | Self::Dying { target, .. }
    // rust: | Self::Hover { target } => *target,
    // rust: _ => None,
}
}
pub fn fly_speed(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Landing { .. } => 1.5,
    // rust: Self::Charging { .. } | Self::Dying { .. } => 3.0,
    // rust: _ => 0.6,
}
}
}
    // rust: pub(super) struct Dragon {
    /// `Entity.id` once tracked to guests (0 before); its parts take the
    /// eight ids after it (`EnderDragon`'s constructor reserves them).
    // rust: pub id: u32,
    // rust: pub position: Vec3,
    // rust: pub previous: Vec3,
    // rust: velocity: Vec3,
    // rust: pub yaw: f32,
    // rust: pub previous_yaw: f32,
    // rust: yaw_accel: f32,
    // rust: pub health: f32,
    // rust: pub hurt_time: i32,
    /// `LivingEntity.damageCooldownTime` and `lastHurt`: within the window
    /// only damage above the last hit lands, and only the excess.
    // rust: invulnerable: i32,
    // rust: last_hurt: f32,
    /// `lastHurtByPlayer` with its 100 tick memory: the player credited with
    /// the kill, and the dragon tick of their last hit.
    // rust: hurt_by_player: Option<(FightWho, i32)>,
    // rust: pub last_source: Option<(&'static str, Option<i32>, Option<i32>)>,
    // rust: pub death_time: i32,
    // rust: pub flap: f32,
    // rust: pub old_flap: f32,
    // rust: in_wall: bool,
    // rust: phase: Phase,
    // rust: flame_count: i32,
    // rust: sitting_damage: f32,
    // rust: growl: i32,
    /// `Mob.ambientSoundTime`.
    // rust: ambient_time: i32,
    // rust: ticks: i32,
    /// DragonFlightHistory: (y, yRot) samples, newest at `head`.
    // rust: history: [(f64, f32); 64],
    // rust: head: usize,
    /// head, neck, body, tail1-3, wing1-2.
    // rust: pub parts: [(Vec3, Vec3); 8],
    // rust: nodes: Option<[[i32; 3]; 24]>,
    // rust: nearest_crystal: Option<usize>,
    /// The player a crystal destroyed while it held its pattern sends it
    /// after (`strafe_after_crystal`), taken on its next tick.
    // rust: strafe_request: Option<FightWho>,
    /// `Mob.isNoAi` (`NoAI`): it flaps in place, with no phase or flight.
    // rust: no_ai: bool,
    // rust: random: LegacyRandom,
}
/// A player in the fight: the window's own player, or a guest by
/// connection (a LAN or server player).
    // rust: pub(super) enum FightWho {
    // rust: Host,
    // rust: Guest(u32),
}
/// A player in the End as the dragon sees it.
    // rust: pub(super) struct FightPlayer {
    // rust: pub(super) who: FightWho,
    // rust: pub(super) position: Vec3,
    // rust: pub(super) bounds: Aabb,
    // rust: pub(super) alive: bool,
    // rust: creative: bool,
    // rust: spectator: bool,
}
    // rust: impl FightPlayer {
    /// `Player.canBeSeenAsEnemy`: alive, neither creative nor spectator.
pub fn enemy(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.alive && !self.creative && !self.spectator
}
}
/// `TargetingConditions.forCombat` (visibility aside) in
/// `Level.getNearestPlayer`: the enemy nearest `at` among `players`, within
/// `range` of the dragon at `from` and passing `selector`; none on Peaceful.
    // rust: fn nearest_enemy(
    // rust: players: &[FightPlayer],
    // rust: peaceful: bool,
    // rust: at: Vec3,
    // rust: range: Option<(Vec3, f64)>,
    // rust: selector: impl Fn(&FightPlayer) -> bool,
    // rust: ) -> Option<FightPlayer> {
    // rust: if peaceful {
    // rust: return None;
}
    // rust: players
    // rust: .iter()
    // rust: .filter(|p| p.enemy() && selector(p))
    // rust: .filter(|p| range.is_none_or(|(from, r)| p.position.distance_squared(from) <= r * r))
    // rust: .min_by(|a, b| {
    // rust: a.position
    // rust: .distance_squared(at)
    // rust: .total_cmp(&b.position.distance_squared(at))
    // rust: })
    // rust: .copied()
}
/// Whether `EndCrystal.hurtServer` creates a blast before notifying the fight.
pub const CrystalDamage = enum {
    Direct,
    Explosion,
};
/// What `EnderDragon.hurt` made of a hit.
    // rust: pub(super) enum Hurt {
    /// It returned true; `full` when it was a new hit, not just the excess
    /// over the last one (the hurt sound and animation).
    // rust: Landed { full: bool },
    /// It returned false (dying, too little damage, fire on a part).
    // rust: Refused,
    /// A perched dragon's `onHurt` took a direct arrow's or wind charge's
    /// damage away (and set it alight for a second).
    // rust: Shrugged,
}
/// `#minecraft:is_fire`, which the dragon's parts and the crystals refuse
/// (`isInvulnerableToBase`: both types are fire immune).
pub fn is_fire(kind: DamageKind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let source = Damage {
    // rust: kind,
    // rust: attacker: None,
    // rust: from: None,
    // rust: attacker_species: None,
}
    // rust: source.is_fire()
}
    // rust: const PART_SIZES: [(f64, f64); 8] = [
    // rust: (1.0, 1.0),
    // rust: (3.0, 3.0),
    // rust: (5.0, 3.0),
    // rust: (2.0, 2.0),
    // rust: (2.0, 2.0),
    // rust: (2.0, 2.0),
    // rust: (4.0, 2.0),
    // rust: (4.0, 2.0),
    // rust: ];
    // rust: const ADJACENCY: [u32; 24] = [
    // rust: 6146, 8197, 8202, 16404, 32808, 32848, 65696, 131392, 131712, 263424, 526848, 525313, 1581057,
    // rust: 3166214, 2138120, 6373424, 4358208, 12910976, 9044480, 9706496, 15216640, 13688832, 11763712,
    // rust: 8257536,
    // rust: ];
    // rust: impl Dragon {
pub fn new(position: Vec3, yaw: f32, seed: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: id: 0,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw,
    // rust: previous_yaw: yaw,
    // rust: yaw_accel: 0.0,
    // rust: health: MAX_HEALTH,
    // rust: hurt_time: 0,
    // rust: invulnerable: 0,
    // rust: last_hurt: 0.0,
    // rust: hurt_by_player: None,
    // rust: last_source: None,
    // rust: death_time: 0,
    // rust: flap: 0.0,
    // rust: old_flap: 0.0,
    // rust: in_wall: false,
    // rust: phase: Phase::Holding {
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: },
    // rust: flame_count: 0,
    // rust: sitting_damage: 0.0,
    // rust: growl: 100,
    // rust: ambient_time: 0,
    // rust: ticks: 0,
    // rust: history: [(position.y, yaw); 64],
    // rust: head: 0,
    // rust: parts: [(position, position); 8],
    // rust: nodes: None,
    // rust: nearest_crystal: None,
    // rust: strafe_request: None,
    // rust: no_ai: false,
    // rust: random: LegacyRandom::new(seed),
}
}
    /// DragonFlightHistory.record.
pub fn record(self: *Self) void {
}
    // rust: self.head = (self.head + 1) & 63;
    // rust: self.history[self.head] = (self.position.y, self.yaw);
}
    /// DragonFlightHistory.get(delay).
pub fn sample(self: *Self, delay: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.history[(self.head + 64 - (delay & 63)) & 63]
}
    /// `DragonFlightHistory.get(delay, partial)`, with
    /// `EnderDragonRenderer.extractRenderState`'s frozen history on death.
pub fn sample_lerp(self: *Self, delay: usize, partial: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let partial = if self.alive() { partial } else { 0.0 };
    // rust: let a = self.sample(delay);
    // rust: let b = self.sample(delay + 1);
    // rust: let yaw = b.1 + wrap(a.1 - b.1) * partial;
    // rust: (b.0 + (a.0 - b.0) * f64::from(partial), yaw)
}
pub fn alive(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.health > 0.0
}
    /// `isDeadOrDying` for the killing blow: the dying flight, or no health.
pub fn down(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.phase, Phase::Dying { .. }) || !self.alive()
}
pub fn part_box(self: *Self, i: usize) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, h) = PART_SIZES[i];
    // rust: let p = self.parts[i].0;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - w / 2.0, p.y, p.z - w / 2.0),
    // rust: Vec3::new(p.x + w / 2.0, p.y + h, p.z + w / 2.0),
    // rust: )
}
    /// `EnderDragonPart.hurtServer`: `isInvulnerableToBase` refuses fire
    /// (the dragon's type is fire immune) before `EnderDragon.hurt`.
    /// `direct` is the projectile that hit: a direct `AbstractArrow` or a
    /// `WindCharge` is the arrow a perched dragon shrugs off, a breeze's
    /// `BreezeWindCharge` is neither. Gameplay calls `hurt_part_from`; this
    /// is the no-attacker form the tests use.
    // rust: fn hurt_part(
    // rust: &mut self,
    // rust: part: usize,
    // rust: damage: f32,
    // rust: counts: Option<HurtSource<'_>>,
    // rust: kind: DamageKind,
    // rust: direct: Option<&ProjectileKind>,
    // rust: ) -> Hurt {
    // rust: self.hurt_part_from(part, damage, counts, kind, direct, None)
}
    /// `hurt_part` with the melee attacker's position (`DamageSource.getSourcePosition`,
    /// the direct entity's feet). `None` for a hit that is not a player's melee.
    // rust: fn hurt_part_from(
    // rust: &mut self,
    // rust: part: usize,
    // rust: damage: f32,
    // rust: counts: Option<HurtSource<'_>>,
    // rust: kind: DamageKind,
    // rust: direct: Option<&ProjectileKind>,
    // rust: from: Option<Vec3>,
    // rust: ) -> Hurt {
    // rust: if is_fire(kind) {
    // rust: return Hurt::Refused;
}
    // rust: let arrow = matches!(
    // rust: direct,
    // rust: Some(
    // rust: ProjectileKind::Arrow { .. } | ProjectileKind::Trident | ProjectileKind::WindCharge
    // rust: )
    // rust: );
    // rust: self.hurt_from(part, damage, counts, arrow, from)
}
    /// `EnderDragon.hurt(part, source, damage)`: whether the hit landed
    /// (an arrow is spent, else it turns back). `counts` is the source
    /// `reallyHurt` takes when `source.getEntity() instanceof Player` or its
    /// type always hurts dragons (explosions), and none otherwise; `arrow` a
    /// direct arrow or wind charge, which a perched dragon shrugs off
    /// (`AbstractDragonSittingPhase.onHurt`). Gameplay calls `hurt_from`.
pub fn hurt(self: *Self, part: usize, damage: f32, counts: ?HurtSource, arrow: bool) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hurt_from(part, damage, counts, arrow, None)
}
    /// `hurt` with the position `dealDefaultKnockback` pushes away from.
    // rust: fn hurt_from(
    // rust: &mut self,
    // rust: part: usize,
    // rust: damage: f32,
    // rust: counts: Option<HurtSource>,
    // rust: arrow: bool,
    // rust: from: Option<Vec3>,
    // rust: ) -> Hurt {
    // rust: if matches!(self.phase, Phase::Dying { .. }) || !self.alive() {
    // rust: return Hurt::Refused;
}
    // rust: if arrow && self.phase.sitting() {
    // rust: return Hurt::Shrugged;
}
    // rust: let mut damage = damage;
    // rust: if part != 0 && part != 1 {
    // rust: damage = damage / 4.0 + damage.min(1.0);
}
    // rust: if damage < 0.01 {
    // rust: return Hurt::Refused;
}
    // rust: let Some(source) = counts else {
    // rust: return Hurt::Landed { full: false };
}
    // rust: let before = self.health;
        // reallyHurt: LivingEntity.hurtServer, past its guards: a native mod's
        // hook. A canceled hit still returns true.
    // rust: let hurting = horizon_client::health::Hurting::Dragon(self.id as i32, source);
    // rust: if horizon_client::health::hurt_server_canceled(hurting, &mut damage) {
    // rust: return Hurt::Landed { full: false };
}
    // rust: if damage < 0.0 {
    // rust: damage = 0.0;
}
    // rust: if !damage.is_finite() {
    // rust: damage = f32::MAX;
}
        // LivingEntity.hurtServer: within the cooldown only what exceeds the last hit.
    // rust: let full = if self.invulnerable > 10 {
    // rust: if damage <= self.last_hurt {
    // rust: return Hurt::Landed { full: false };
}
    // rust: self.health -= damage - self.last_hurt;
    // rust: self.last_hurt = damage;
    // rust: false
    // rust: } else {
    // rust: self.last_hurt = damage;
    // rust: self.invulnerable = 20;
    // rust: self.health -= damage;
    // rust: self.hurt_time = 10;
    // rust: true
}
    // rust: if self.health <= 0.0 {
    // rust: if self.phase.sitting() {
    // rust: self.health = 0.0;
    // rust: } else {
                // handleKillingBlow: dying flight first.
    // rust: self.health = 1.0;
    // rust: self.set_phase(Phase::Dying {
    // rust: target: None,
    // rust: time: 0,
    // rust: });
}
}
        // `LivingEntity.hurtServer` calls `dealDefaultKnockback` (strength
        // `0.4F`) on a full hit, before `EnderDragon.hurt` adds sitting damage
        // and maybe takes off. `from` is the attacker's feet for a player's
        // melee hit. Explosions are `#no_knockback`; their push is
        // `explosion_knockback`.
    // rust: if full && let Some(from) = from {
    // rust: self.knockback(
    // rust: f64::from(0.4_f32),
    // rust: from.x - self.position.x,
    // rust: from.z - self.position.z,
    // rust: source,
    // rust: );
}
    // rust: if self.phase.sitting() {
    // rust: self.sitting_damage += before - self.health.max(0.0);
    // rust: if self.sitting_damage > 0.25 * MAX_HEALTH {
    // rust: self.sitting_damage = 0.0;
    // rust: self.set_phase(Phase::Takeoff {
    // rust: first: true,
    // rust: path: None,
    // rust: target: None,
    // rust: });
}
}
    // rust: Hurt::Landed { full }
}
    /// `EnderDragon.knockback`: `LivingEntity.knockback` only when the phase
    /// is not sitting. `(xd, zd)` points at the hit (`dealDefaultKnockback`:
    /// the source position minus this position). Knockback resistance is the
    /// mob default, 0. `noPhysics` never sets `onGround`, so the vertical
    /// component stays.
pub fn knockback(self: *Self, power: f64, xd: f64, zd: f64, source: HurtSource<'_>) void {
}
    // rust: if self.phase.sitting() {
    // rust: return;
}
    // rust: let mut knock = horizon_client::health::Knock {
    // rust: strength: power,
    // rust: x: xd,
    // rust: z: zd,
}
    // rust: if horizon_client::health::knockback_canceled(
    // rust: horizon_client::health::Hurting::Dragon(self.id as i32, source),
    // rust: &mut knock,
    // rust: ) {
    // rust: return;
}
    // rust: let horizon_client::health::Knock {
    // rust: strength: power,
    // rust: x: mut xd,
    // rust: z: mut zd,
    // rust: } = knock;
    // rust: if power <= 0.0 {
    // rust: return;
}
    // rust: while xd * xd + zd * zd < f64::from(1.0e-5_f32) {
    // rust: xd = (self.random.next_double() - self.random.next_double()) * 0.01;
    // rust: zd = (self.random.next_double() - self.random.next_double()) * 0.01;
}
    // rust: let len = (xd * xd + zd * zd).sqrt();
    // rust: let (kx, kz) = (xd / len * power, zd / len * power);
    // rust: let v = self.velocity;
    // rust: self.velocity = Vec3::new(v.x / 2.0 - kx, v.y, v.z / 2.0 - kz);
}
    /// `ServerExplosion.hurtEntities` on the dragon: the dragon itself (its
    /// body takes it), then each part, in `Level.getEntities` order, each by
    /// its distance and how much of its box the blast sees (`exposure`).
    // rust: fn explosion_hits(
    // rust: &self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: exposure: impl Fn(Aabb) -> f32,
    // rust: ) -> Vec<(usize, f32)> {
    // rust: let diameter = f64::from(radius * 2.0);
    // rust: let dist = |p: Vec3| {
    // rust: ((p.x - center[0]).powi(2) + (p.y - center[1]).powi(2) + (p.z - center[2]).powi(2))
    // rust: .sqrt()
    // rust: / diameter
}
    // rust: let p = self.position;
    // rust: let whole = Aabb::new(
    // rust: Vec3::new(p.x - 8.0, p.y, p.z - 8.0),
    // rust: Vec3::new(p.x + 8.0, p.y + 8.0, p.z + 8.0),
    // rust: );
    // rust: std::iter::once((2, p, whole))
    // rust: .chain((0..8).map(|i| (i, self.parts[i].0, self.part_box(i))))
    // rust: .filter_map(|(part, at, b)| {
    // rust: let d = dist(at);
    // rust: (d <= 1.0).then(|| {
    // rust: let pow = (1.0 - d) * f64::from(exposure(b));
    // rust: (
    // rust: part,
    // rust: ((pow * pow + pow) / 2.0 * 7.0 * diameter + 1.0) as f32,
    // rust: )
    // rust: })
    // rust: })
    // rust: .collect()
}
    /// `ServerExplosion.hurtEntities` knockback on the dragon itself:
    /// `pushFromExplosion` adds `(1 - dist) * exposure` along the blast to
    /// its eye to the motion (`Entity.push`); the parts are not pushed.
pub fn whole_box(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = self.position;
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - 8.0, p.y, p.z - 8.0),
    // rust: Vec3::new(p.x + 8.0, p.y + 8.0, p.z + 8.0),
    // rust: )
}
    // rust: fn explosion_knockback(
    // rust: &self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: exposure: f32,
    // rust: ) -> Option<[f64; 3]> {
    // rust: let diameter = f64::from(radius * 2.0);
    // rust: let p = self.position;
    // rust: let at = |y: f64| [p.x - center[0], y - center[1], p.z - center[2]];
    // rust: let len = |v: [f64; 3]| (v[0] * v[0] + v[1] * v[1] + v[2] * v[2]).sqrt();
    // rust: let dist = len(at(p.y)) / diameter;
    // rust: if dist > 1.0 {
    // rust: return None;
}
        // The dragon's eye is 0.85 of its 8 block height, in floats.
    // rust: let away = at(p.y + f64::from(8.0f32 * 0.85f32));
    // rust: let l = len(away);
        // `Vec3.normalize` gives zero below 1.0E-5F, then `scale(power)`.
    // rust: if l < 9.999_999_747_378_752e-6 {
    // rust: return Some([0.0; 3]);
}
    // rust: let power = (1.0 - dist) * f64::from(exposure);
    // rust: Some(away.map(|d| d / l * power))
}
    /// `DragonHoldingPatternPhase.onCrystalDestroyed`: strafe `player` if
    /// the dragon can attack them (`EnderDragon.canAttack`, on Peaceful too).
    /// The first such crystal wins: the dragon strafes from then on, and
    /// `onCrystalDestroyed` does nothing in that phase.
pub fn strafe_after_crystal(self: *Self, player: ?*FightPlayer) void {
}
    // rust: if let Some(p) = player
    // rust: && p.enemy()
    // rust: && matches!(self.phase, Phase::Holding { .. })
    // rust: && self.strafe_request.is_none()
    // rust: {
    // rust: self.strafe_request = Some(p.who);
}
}
pub fn set_phase(self: *Self, phase: Phase) void {
}
    // rust: if self.phase.id() == phase.id() && phase.id() != 1 {
    // rust: return;
}
    // rust: if let Phase::Flaming { .. } = phase {
    // rust: self.flame_count += 1;
}
    // rust: self.phase = phase;
}
}
/// The source `reallyHurt` takes from a hit `by` the player of that entity
/// id: `DamageSources.explosion(crystal, player)` is `player_explosion` with
/// a player behind it, who is the causing entity, and the direct one of a
/// melee hit (a projectile's direct entity isn't known here).
    // rust: fn hurt_source(
    // rust: kind: DamageKind,
    // rust: by: Option<i32>,
    // rust: direct: Option<&ProjectileKind>,
    // rust: ) -> HurtSource<'static> {
    // rust: let causing = by.unwrap_or(0);
    // rust: let melee = direct.is_none() && super::creatures::melee(kind);
    // rust: HurtSource {
    // rust: damage_type: super::creatures::damage_type(kind, by.is_some()),
    // rust: causing,
    // rust: direct: if melee { causing } else { 0 },
}
}
pub fn wrap(d: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = d.rem_euclid(360.0);
    // rust: if r >= 180.0 { r - 360.0 } else { r }
}
pub fn wrap64(d: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = d.rem_euclid(360.0);
    // rust: if r >= 180.0 { r - 360.0 } else { r }
}
    // rust: impl Game<'_> {
pub fn fight_path(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_client::save::dimension_dir(&self.world_root, "minecraft:the_end").join(FIGHT_FILE)
}
    /// The saved fight, or `createDefault` with the gateways shuffled by the seed.
pub fn load_fight(self: *Self) void {
}
    // rust: if self.fight.loaded {
    // rust: return;
}
    // rust: let tag = horizon_client::save::read_dat(&self.fight_path());
    // rust: let data = tag.as_ref().and_then(|t| t.get("data"));
    // rust: let flag = |k: &str, default: bool| match data.and_then(|d| d.get(k)) {
    // rust: Some(Tag::Byte(v)) => *v != 0,
    // rust: _ => default,
}
    // rust: let mut fight = Fight {
    // rust: loaded: true,
    // rust: needs_scan: flag("needs_state_scanning", true),
    // rust: killed: flag("dragon_killed", false),
    // rust: previously_killed: flag("previously_killed", false),
    // rust: crystals_placed: flag("horizon_crystals_placed", false),
    // rust: gateways: match data.and_then(|d| d.get("gateways")) {
    // rust: Some(Tag::IntArray(v)) => v.clone(),
    // rust: Some(Tag::List(v)) => v
    // rust: .iter()
    // rust: .filter_map(|t| match t {
    // rust: Tag::Int(i) => Some(*i),
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: respawn: match data.and_then(|d| d.get("respawn_stage")) {
    // rust: Some(Tag::String(name)) => {
    // rust: Respawn::from_name(&name.to_string().unwrap_or_default()).map(|r| {
    // rust: let time = match data.and_then(|d| d.get("respawn_time")) {
    // rust: Some(Tag::Int(t)) => *t,
    // rust: _ => 0,
}
    // rust: (r, time)
    // rust: })
}
    // rust: _ => None,
    // rust: },
    // rust: respawn_crystals: match data.and_then(|d| d.get("horizon_respawn_crystals")) {
    // rust: Some(Tag::IntArray(v)) => v
    // rust: .as_chunks::<3>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|b| {
    // rust: Vec3::new(
    // rust: f64::from(b[0]) + 0.5,
    // rust: f64::from(b[1]),
    // rust: f64::from(b[2]) + 0.5,
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: _ => Vec::new(),
    // rust: },
    // rust: exit_portal: match data.and_then(|d| d.get("exit_portal_location")) {
    // rust: Some(Tag::IntArray(v)) if v.len() == 3 => Some([v[0], v[1], v[2]]),
    // rust: _ => None,
    // rust: },
    // rust: dragon_uuid: match data.and_then(|d| d.get("dragon_uuid")) {
    // rust: Some(Tag::IntArray(v)) if v.len() == 4 => Some([v[0], v[1], v[2], v[3]]),
    // rust: _ => None,
    // rust: },
            // The first tick scans for players.
    // rust: player_scan: 21,
    // rust: ..Default::default()
}
    // rust: if fight.gateways.is_empty() {
            // Util.shuffle(0..20, RandomSource.create(seed)).
    // rust: let mut gateways: Vec<i32> = (0..20).collect();
    // rust: let mut random = LegacyRandom::new(self.level.seed);
    // rust: for i in (2..=gateways.len()).rev() {
    // rust: let j = random.next_int_bound(i as i32).unwrap_or(0) as usize;
    // rust: gateways.swap(i - 1, j);
}
    // rust: fight.gateways = gateways;
    // rust: fight.dirty = true;
}
        // A world from before this fight existed: one with an active portal
        // already won it.
    // rust: if tag.is_none() && self.end_portal_active() {
    // rust: fight.killed = true;
    // rust: fight.previously_killed = true;
    // rust: fight.crystals_placed = true;
    // rust: fight.needs_scan = false;
}
    // rust: self.fight = fight;
}
pub fn end_portal_active(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..256).any(|y| {
    // rust: &*self.res.facts().get(self.world.block(0, y, 0)).name == "minecraft:bedrock"
    // rust: && (-3..=3).any(|d| {
    // rust: &*self.res.facts().get(self.world.block(d, y, 0)).name == "minecraft:end_portal"
    // rust: })
    // rust: })
}
    // rust: pub(super) fn save_fight(&mut self) {
    // rust: if !self.fight.loaded || !self.fight.dirty {
    // rust: return;
}

    // rust: let f = &self.fight;
    // rust: let b = |v: bool| Tag::Byte(i8::from(v));
    // rust: let mut data = vec![
    // rust: ("needs_state_scanning", b(f.needs_scan)),
    // rust: ("dragon_killed", b(f.killed)),
    // rust: ("previously_killed", b(f.previously_killed)),
    // rust: ("respawn_time", Tag::Int(f.respawn.map_or(0, |r| r.1))),
    // rust: ("gateways", Tag::IntArray(f.gateways.clone())),
    // rust: ("horizon_crystals_placed", b(f.crystals_placed)),
    // rust: ];
    // rust: if let Some(p) = f.exit_portal {
    // rust: data.push(("exit_portal_location", Tag::IntArray(p.to_vec())));
}
    // rust: if let Some(u) = f.dragon_uuid {
    // rust: data.push(("dragon_uuid", Tag::IntArray(u.to_vec())));
}
    // rust: if let Some((stage, _)) = f.respawn {
    // rust: data.push(("respawn_stage", Tag::String(stage.name().into())));
    // rust: data.push((
    // rust: "horizon_respawn_crystals",
    // rust: Tag::IntArray(
    // rust: f.respawn_crystals
    // rust: .iter()
    // rust: .flat_map(|p| [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32])
    // rust: .collect(),
    // rust: ),
    // rust: ));
}
    // rust: let tag = Tag::compound([
    // rust: ("data", Tag::compound(data)),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]);
    // rust: if horizon_client::save::write_dat(&self.fight_path(), tag).is_ok() {
    // rust: self.fight.dirty = false;
}
}
    /// The island's centre chunks are lit (the arena is "loaded").
pub fn arena_loaded(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (-2..=1).all(|cz| (-2..=1).all(|cx| self.streaming.is_lit(cx, cz)))
}
    /// A player's entity id: the acting player's body has it, another
    /// player's comes from the hub (0 when it is out on a guest's turn, and
    /// for no player).
pub fn fight_entity(self: *Self, who: FightWho) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if who == self.acting_player() {
    // rust: return self.player.as_ref().map_or(0, |p| p.entity_id);
}
    // rust: let host = self.lan.as_ref();
    // rust: match who {
    // rust: FightWho::Host => 0,
    // rust: FightWho::Guest(conn) => host
    // rust: .and_then(|h| h.hub.guest(conn))
    // rust: .map_or(0, |g| g.entity_id),
}
}
    /// The player acting now: the guest whose turn it is, else the host.
pub fn acting_player(self: *Self) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.lan_acting.map_or(FightWho::Host, FightWho::Guest)
}
    /// Names the acting player behind the blast about to go off (a large
    /// fireball they shot), or no one, for the dragon's kill credit.
    // rust: pub(super) fn set_blast_by_player(&mut self, by_player: bool) {
    // rust: self.fight.blast_by = by_player.then(|| self.acting_player());
}
    /// The players in the level the dragon sees (`level.players()`): the
    /// window's own, then every guest in the level.
    // rust: pub(super) fn fight_players(&self) -> Vec<FightPlayer> {
    // rust: let mut out = Vec::new();
    // rust: if let Some(p) = self.player.as_ref() {
    // rust: out.push(FightPlayer {
    // rust: who: FightWho::Host,
    // rust: position: p.position,
    // rust: bounds: p.bounds(),
    // rust: alive: !p.health.dead_or_dying(),
    // rust: creative: self.creative,
    // rust: spectator: self.spectator(),
    // rust: });
}
    // rust: if let Some(h) = self.lan.as_ref() {
    // rust: for g in h.hub.guests.iter().filter(|g| h.hub.here(g) && g.loaded) {
    // rust: let [x, y, z] = g.position;
    // rust: out.push(FightPlayer {
    // rust: who: FightWho::Guest(g.conn),
    // rust: position: Vec3::new(x, y, z),
    // rust: bounds: super::lan_mobs::guest_bounds(g),
    // rust: alive: !g.dead,
    // rust: creative: g.creative(),
    // rust: spectator: g.spectator(),
    // rust: });
}
}
    // rust: out
}
    /// Run `f` as the fight's player `who` (a guest's turn, its knockback
    /// sent to its client).
    // rust: pub(super) fn as_fight_player(&mut self, who: FightWho, f: impl FnOnce(&mut Self)) {
    // rust: match who {
    // rust: FightWho::Host => f(self),
    // rust: FightWho::Guest(conn) => {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return;
}
    // rust: self.guest_hit_by(&mut host, conn, f);
    // rust: self.lan = Some(host);
}
}
}
    /// `EnderDragonFight.validPlayer`: the players alive within 192 blocks of
    /// (0, 128, 0), the host and the guests in the level alike.
pub fn fight_has_players(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let near =
    // rust: |p: [f64; 3]| p[0].powi(2) + (p[1] - 128.0).powi(2) + p[2].powi(2) <= 192.0 * 192.0;
    // rust: let host = self.player.as_ref().is_some_and(|p| {
    // rust: !p.health.dead_or_dying() && near([p.position.x, p.position.y, p.position.z])
    // rust: });
    // rust: host || self.lan.as_ref().is_some_and(|h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .any(|g| h.hub.here(g) && g.loaded && !g.dead && near(g.position))
    // rust: })
}
    /// `EnderDragonFight.tick` and the fight's entities, while the End is
    /// ticked (in place for its player, or on a server with players in it).
    // rust: pub(super) fn tick_fight(&mut self) {
        // A dragon outside the End (`/summon`) has no fight: `ServerLevel.getDragonFight` is
        // null there, but `EnderDragon.aiStep` still flies it.
    // rust: if self.dim != Dim::End {
    // rust: self.tick_dragon();
    // rust: return;
}
    // rust: self.load_fight();
        // updatePlayers, every 20 ticks.
    // rust: self.fight.player_scan += 1;
    // rust: if self.fight.player_scan >= 20 {
    // rust: self.fight.player_scan = 0;
    // rust: self.fight.players = self.fight_has_players();
}
    // rust: if !self.arena_loaded() {
    // rust: return;
}
    // rust: if !self.fight.crystals_placed {
    // rust: self.place_spike_crystals();
    // rust: self.fight.crystals_placed = true;
    // rust: self.fight.dirty = true;
}
    // rust: if self.fight.players {
    // rust: if self.fight.needs_scan {
    // rust: self.scan_state();
    // rust: self.fight.needs_scan = false;
    // rust: self.fight.dirty = true;
}
    // rust: if self.fight.respawn.is_some() {
    // rust: self.tick_respawn();
}
    // rust: if !self.fight.killed {
                // Without a dragon of its own, or 1200 ticks after it last
                // ticked, the fight takes the End's dragon or makes one
                // (`findOrCreateDragon`).
    // rust: let look = match self.fight.dragon_uuid {
    // rust: None => true,
    // rust: Some(_) => {
    // rust: self.fight.dragon_unseen += 1;
    // rust: self.fight.dragon_unseen >= 1200
}
}
    // rust: if look {
    // rust: self.find_or_create_dragon();
    // rust: self.fight.dragon_unseen = 0;
}
    // rust: self.fight.crystal_scan += 1;
    // rust: if self.fight.crystal_scan >= 100 {
    // rust: self.count_crystals();
}
}
}
        // EnderDragon's constructor takes its id and its parts' from the
        // entity counter (a dragon loaded from the save gets them here too).
    // rust: if let Some(d) = self.dragon.as_mut()
    // rust: && d.id == 0
    // rust: {
    // rust: d.id = self.next_entity + 1;
    // rust: self.next_entity += 9;
}
        // The spikes' crystals too (EndCrystal's constructor): an id whether
        // or not a client has tracked them yet, to be aimed at by it.
    // rust: for c in self.crystals.iter_mut().filter(|c| c.id == 0) {
    // rust: self.next_entity += 1;
    // rust: c.id = self.next_entity;
}
        // updateDragon, from the fight's dragon's aiStep (not with NoAI) and
        // tickDeath: it has been seen.
    // rust: let ticks = self.dragon.as_ref().is_some_and(|d| !d.alive() || !d.no_ai);
    // rust: if ticks && self.is_fight_dragon() {
    // rust: self.fight.dragon_unseen = 0;
}
    // rust: self.tick_dragon();
}
    /// EndSpikeFeature's crystals (with fire under them on the bedrock).
pub fn place_spike_crystals(self: *Self) void {
}
    // rust: for spike in horizon_world::worldgen::end_spike::spikes_for_seed(self.level.seed) {
    // rust: let at = Vec3::new(
    // rust: f64::from(spike.center_x) + 0.5,
    // rust: f64::from(spike.height + 1),
    // rust: f64::from(spike.center_z) + 0.5,
    // rust: );
    // rust: if self
    // rust: .crystals
    // rust: .iter()
    // rust: .any(|c| (c.position.x - at.x).abs() < 1.0 && (c.position.z - at.z).abs() < 1.0)
    // rust: {
    // rust: continue;
}
    // rust: let time = self.world.random.next_int_bound(100_000).unwrap_or(0);
            // EndCrystal's constructor takes an id from the entity counter.
    // rust: self.next_entity += 1;
    // rust: self.crystals.push(Crystal {
    // rust: id: self.next_entity,
    // rust: position: at,
    // rust: show_bottom: true,
    // rust: time,
    // rust: beam: None,
    // rust: invulnerable: false,
    // rust: });
    // rust: self.world
    // rust: .modified
    // rust: .insert((at.x.floor() as i32 >> 4, at.z.floor() as i32 >> 4));
}
}
    /// `updateCrystalCount`: crystals on the spike tops.
pub fn count_crystals(self: *Self) void {
}
    // rust: self.fight.crystal_scan = 0;
    // rust: let spikes = horizon_world::worldgen::end_spike::spikes_for_seed(self.level.seed);
    // rust: self.fight.alive_crystals = self
    // rust: .crystals
    // rust: .iter()
    // rust: .filter(|c| {
    // rust: spikes.iter().any(|s| {
    // rust: (c.position.x - f64::from(s.center_x) - 0.5).abs() <= f64::from(s.radius)
    // rust: && (c.position.z - f64::from(s.center_z) - 0.5).abs() <= f64::from(s.radius)
    // rust: && c.position.y >= f64::from(s.height)
    // rust: })
    // rust: })
    // rust: .count() as i32;
}
    /// `EndCrystal.tick` in every dimension: the time (the spin and bob),
    /// and fire at its block where there is a dragon fight (the End).
    // rust: pub(super) fn tick_crystals(&mut self) {
    // rust: let fire = (self.dim == Dim::End)
    // rust: .then(|| self.pack.assets.registry.default_state("minecraft:fire"))
    // rust: .flatten();
    // rust: for i in 0..self.crystals.len() {
    // rust: self.crystals[i].time += 1;
    // rust: let p = self.crystals[i].position;
    // rust: let b = [p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32];
    // rust: if let Some(fire) = fire
    // rust: && self.res.facts().is_air(self.world.block(b[0], b[1], b[2]))
    // rust: && self.world.loaded(b[0], b[2])
    // rust: {
    // rust: let _ = self.level_set(b, fire);
}
}
}
    /// `EndCrystal.hurtServer`: remove it, blast only for non-explosion damage,
    /// then notify the dragon fight even when no blast was created.
pub fn destroy_crystal(self: *Self, index: usize, by: ?FightWho, damage: CrystalDamage) void {
}
    // rust: if index >= self.crystals.len() || self.crystals[index].invulnerable {
    // rust: return;
}
    // rust: let c = self.crystals.remove(index);
        // Read before the blast, which can take other respawn crystals.
    // rust: let respawn_crystal = self.fight.respawn.is_some()
    // rust: && self
    // rust: .fight
    // rust: .respawn_crystals
    // rust: .iter()
    // rust: .any(|p| p.distance_squared(c.position) < 0.01);
    // rust: if damage == CrystalDamage::Direct {
    // rust: let at = [c.position.x, c.position.y, c.position.z];
            // The blast's damage source carries the player, so the dragon
            // remembers them before the blast can kill it.
    // rust: self.fight.blast_by = by;
            // EndCrystal.hurtServer: ExplosionInteraction.BLOCK.
    // rust: let interaction = self.destroy_type("block_explosion_drop_decay");
            // EndCrystal is 2 by 2 blocks: its box decides `isInWater`.
    // rust: let (x, y, z) = (c.position.x, c.position.y, c.position.z);
    // rust: self.combat.explosion_in_water = self.bounds_in_water(Aabb::new(
    // rust: Vec3::new(x - 1.0, y, z - 1.0),
    // rust: Vec3::new(x + 1.0, y + 2.0, z + 1.0),
    // rust: ));
    // rust: let _ = self.server_explode(at, 6.0, interaction, false);
    // rust: self.combat.explosion_in_water = false;
    // rust: self.fight.blast_by = None;
}
    // rust: if respawn_crystal {
    // rust: self.abort_respawn();
    // rust: return;
}
        // EnderDragonFight.onCrystalDestroyed.
    // rust: self.count_crystals();
        // EnderDragon.onCrystalDestroyed: the player behind the damage, else
        // the one nearest the crystal's block (`CRYSTAL_DESTROY_TARGETING`,
        // whose range `TargetingConditions.test` skips without a targeter).
    // rust: let player = by.or_else(|| {
    // rust: let p = c.position;
    // rust: let at = Vec3::new(p.x.floor(), p.y.floor(), p.z.floor());
    // rust: let peaceful = self.ui.difficulty == 0;
    // rust: nearest_enemy(&self.fight_players(), peaceful, at, None, |_| true).map(|p| p.who)
    // rust: });
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return;
}
    // rust: if d.nearest_crystal == Some(index) {
    // rust: d.nearest_crystal = None;
    // rust: self.hurt_dragon(0, 10.0, true, player, DamageKind::Explosion);
    // rust: } else if let Some(n) = d.nearest_crystal.as_mut()
    // rust: && *n > index
    // rust: {
    // rust: *n -= 1;
}
    // rust: let target = player.and_then(|who| self.fight_players().into_iter().find(|p| p.who == who));
    // rust: if let Some(d) = self.dragon.as_mut() {
    // rust: d.strafe_after_crystal(target.as_ref());
}
}
    /// Targets for projectiles: dragon parts and crystals.
    // rust: pub(super) fn special_targets(&self) -> Vec<(u32, Aabb)> {
    // rust: let mut out = Vec::new();
    // rust: if let Some(d) = self.dragon.as_ref().filter(|d| d.alive()) {
    // rust: for i in 0..8 {
    // rust: out.push((SPECIAL + i as u32, d.part_box(i)));
}
}
    // rust: for (i, c) in self.crystals.iter().enumerate() {
    // rust: let p = c.position;
    // rust: out.push((
    // rust: CRYSTAL_IDS + i as u32,
    // rust: Aabb::new(
    // rust: Vec3::new(p.x - 1.0, p.y, p.z - 1.0),
    // rust: Vec3::new(p.x + 1.0, p.y + 2.0, p.z + 1.0),
    // rust: ),
    // rust: ));
}
    // rust: out
}
    /// The box of the dragon part or end crystal guests know as entity `id`
    /// (`EnderDragonPart`s follow the dragon's id).
    // rust: pub(super) fn tracked_special_box(&self, id: i32) -> Option<Aabb> {
    // rust: let id = u32::try_from(id).ok().filter(|&id| id != 0)?;
    // rust: if let Some(d) = self.dragon.as_ref().filter(|d| d.alive() && d.id != 0)
    // rust: && (d.id + 1..=d.id + 8).contains(&id)
    // rust: {
    // rust: return Some(d.part_box((id - d.id - 1) as usize));
}
    // rust: let i = self.crystals.iter().position(|c| c.id == id)?;
    // rust: self.special_targets()
    // rust: .into_iter()
    // rust: .find(|(s, _)| *s == CRYSTAL_IDS + i as u32)
    // rust: .map(|(_, b)| b)
}
    /// `ServerLevel.dragonParts`: where the part with that entity id is
    /// and its box.
    // rust: pub(super) fn dragon_part(&self, id: u32) -> Option<(Vec3, Aabb)> {
    // rust: let d = self.dragon.as_ref().filter(|d| d.alive() && d.id != 0)?;
    // rust: (d.id + 1..=d.id + 8).contains(&id).then(|| {
    // rust: let i = (id - d.id - 1) as usize;
    // rust: (d.parts[i].0, d.part_box(i))
    // rust: })
}
    /// Damage to a special id (from projectiles and melee): what the
    /// dragon part or crystal made of it. `direct` is the projectile that hit.
    // rust: pub(super) fn hit_special(
    // rust: &mut self,
    // rust: id: u32,
    // rust: amount: f32,
    // rust: by_player: bool,
    // rust: kind: DamageKind,
    // rust: direct: Option<&ProjectileKind>,
    // rust: ) -> Hurt {
    // rust: if id >= CRYSTAL_IDS {
            // EndCrystal.hurtServer: false while invulnerable and for fire
            // (its type is fire immune), else it blows up.
    // rust: let index = (id - CRYSTAL_IDS) as usize;
    // rust: if is_fire(kind) || self.crystals.get(index).is_none_or(|c| c.invulnerable) {
    // rust: return Hurt::Refused;
}
    // rust: let by = by_player.then(|| self.acting_player());
    // rust: self.destroy_crystal(index, by, CrystalDamage::Direct);
    // rust: Hurt::Landed { full: true }
    // rust: } else if id >= SPECIAL {
    // rust: let by = by_player.then(|| self.acting_player());
    // rust: let part = (id - SPECIAL) as usize;
    // rust: self.hurt_dragon_part(part, amount, by_player, by, kind, direct)
    // rust: } else {
    // rust: Hurt::Refused
}
}
    /// `hurt_dragon_part` with no projectile behind the hit.
    // rust: fn hurt_dragon(
    // rust: &mut self,
    // rust: part: usize,
    // rust: damage: f32,
    // rust: counts: bool,
    // rust: by: Option<FightWho>,
    // rust: kind: DamageKind,
    // rust: ) -> Hurt {
    // rust: self.hurt_dragon_part(part, damage, counts, by, kind, None)
}
    /// `EnderDragonPart.hurtServer` on the dragon in the level. `by` is the
    /// player behind the hit, remembered for the kill credit.
    // rust: fn hurt_dragon_part(
    // rust: &mut self,
    // rust: part: usize,
    // rust: damage: f32,
    // rust: counts: bool,
    // rust: by: Option<FightWho>,
    // rust: kind: DamageKind,
    // rust: direct: Option<&ProjectileKind>,
    // rust: ) -> Hurt {
    // rust: let by_id = by.map(|who| self.fight_entity(who));
    // rust: let source = counts.then(|| hurt_source(kind, by_id, direct));
        // `dealDefaultKnockback` for a player's melee: away from the attacker's
        // feet. The scope names that player to the knockback hook.
    // rust: let _attacker = (kind == DamageKind::PlayerAttack)
    // rust: .then(|| self.knockback_scope(self.player.as_ref().map_or(0, |p| p.entity_id)));
    // rust: let from = (kind == DamageKind::PlayerAttack)
    // rust: .then(|| self.player.as_ref().map(|p| p.position))
    // rust: .flatten();
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return Hurt::Refused;
}
    // rust: let was_down = d.down();
    // rust: let (cooldown, last_hurt) = (d.invulnerable, d.last_hurt);
    // rust: let hurt = d.hurt_part_from(part, damage, source, kind, direct, from);
        // LivingEntity.hurtServer: damage that is applied sets lastHurtByPlayer
        // (100 ticks); a hit the damage cooldown absorbs returns before that.
    // rust: if counts
    // rust: && matches!(hurt, Hurt::Landed { .. })
    // rust: && (d.invulnerable != cooldown || d.last_hurt != last_hurt)
    // rust: && let Some(who) = by
    // rust: {
    // rust: d.hurt_by_player = Some((who, d.ticks));
}
    // rust: if !was_down && d.down() {
    // rust: self.fight.last_blow = Some((kind, by.is_some()));
    // rust: self.credit_dragon_kill();
}
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return hurt;
}
    // rust: if hurt == (Hurt::Landed { full: true }) {
            // Mob.playHurtSound: the ambient sound clock starts again.
    // rust: d.ambient_time = -AMBIENT_INTERVAL;
    // rust: let at = [d.position.x, d.position.y, d.position.z];
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.3;
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_dragon.hurt", Some(at), 5.0, pitch);
    // rust: if let Some(s) = source {
    // rust: d.last_source = Some((
    // rust: s.damage_type,
    // rust: (s.causing != 0).then_some(s.causing),
    // rust: (s.direct != 0).then_some(s.direct),
    // rust: ));
    // rust: } else {
    // rust: d.last_source = Some(("minecraft:generic", None, None));
}
}
    // rust: hurt
}
    /// `LivingEntity.die`: `getKillCredit().awardKillScore`, for the player
    /// who hurt the dragon within the last 100 ticks. A guest's kill is
    /// theirs: their statistics, scores and advancements.
pub fn credit_dragon_kill(self: *Self) void {
}
    // rust: let Some(d) = self.dragon.as_ref() else {
    // rust: return;
}
    // rust: let Some((who, _)) = d.hurt_by_player.filter(|(_, hit)| d.ticks - hit <= 100) else {
    // rust: return;
}
    // rust: let view = horizon_client::advancements::EntityView {
    // rust: kind: "minecraft:ender_dragon".to_owned(),
    // rust: position: [d.position.x, d.position.y, d.position.z],
    // rust: ..Default::default()
}
    // rust: let id = d.id;
    // rust: let blow = self.fight.last_blow.take();
    // rust: let guest = match who {
    // rust: FightWho::Guest(conn) if self.lan_acting.is_none() => Some(conn),
    // rust: _ => None,
}
    // rust: let credited = guest.is_some_and(|conn| {
    // rust: let Some(mut host) = self.lan.take() else {
    // rust: return false;
}
    // rust: let done = self
    // rust: .as_guest(&mut host, conn, |g| g.award_dragon_kill(id, &view, blow))
    // rust: .is_some();
    // rust: self.lan = Some(host);
    // rust: done
    // rust: });
    // rust: if !credited {
    // rust: self.award_dragon_kill(id, &view, blow);
}
}
    /// `ServerPlayer.awardKillScore` for the dragon, on the killer's state.
    // rust: fn award_dragon_kill(
    // rust: &mut self,
    // rust: id: u32,
    // rust: view: &horizon_client::advancements::EntityView,
    // rust: blow: Option<(DamageKind, bool)>,
    // rust: ) {
    // rust: self.award_stat("killed", "minecraft:ender_dragon", 1);
    // rust: self.award_custom_stat("mob_kills", 1);
    // rust: self.score_player_killed(super::commands::Target::Mob(id));
        // KilledTrigger: the damage source `die` was given.
    // rust: let blow = blow.map(|(kind, by_player)| {
    // rust: let mut view = self.damage_view(Damage {
    // rust: kind,
    // rust: attacker: by_player.then_some(Who::Player),
    // rust: from: None,
    // rust: attacker_species: None,
    // rust: });
            // `damageSources().explosion(crystal, player)`: the crystal is the direct entity.
    // rust: if kind == DamageKind::Explosion {
    // rust: view.direct = Some(horizon_client::advancements::EntityView {
    // rust: kind: "minecraft:end_crystal".to_owned(),
    // rust: ..Default::default()
    // rust: });
    // rust: view.is_direct = false;
}
    // rust: view
    // rust: });
    // rust: self.trigger_killed(view, blow.as_ref());
}
    /// Player melee on the dragon's parts or a crystal under the crosshair.
    /// The dragon part under the crosshair within reach: its id and distance.
    // rust: pub(super) fn dragon_hit(&self) -> Option<(u32, f64)> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach: f64 = self.entity_reach;
    // rust: let mut best: Option<(u32, f64)> = None;
    // rust: for (id, b) in self.special_targets() {
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let (lo, hi) = ([lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z]);
    // rust: let (mut t0, mut t1) = (0.0f64, reach);
    // rust: let mut hit = true;
    // rust: for a in 0..3 {
    // rust: if dir[a].abs() < 1e-9 {
    // rust: hit &= eye[a] >= lo[a] && eye[a] <= hi[a];
    // rust: continue;
}
    // rust: let (mut ta, mut tb) = ((lo[a] - eye[a]) / dir[a], (hi[a] - eye[a]) / dir[a]);
    // rust: if ta > tb {
    // rust: std::mem::swap(&mut ta, &mut tb);
}
    // rust: t0 = t0.max(ta);
    // rust: t1 = t1.min(tb);
}
    // rust: if hit && t0 <= t1 && best.is_none_or(|b| t0 < b.1) {
    // rust: best = Some((id, t0));
}
}
    // rust: best
}
    // rust: pub(super) fn attack_dragon(&mut self) -> bool {
    // rust: let Some((id, d)) = self.dragon_hit() else {
    // rust: return false;
}
    // rust: if !self.before_block(d) || self.mob_hit().is_some_and(|m| m.1 < d) {
    // rust: return false;
}
        // A dragon part is no LivingEntity: `canCriticalAttack` is false.
    // rust: let (amount, _, _, _) = self.melee_damage("minecraft:ender_dragon", false);
    // rust: self.swing_arm();
        // The part's box.
    // rust: let area = self
    // rust: .special_targets()
    // rust: .into_iter()
    // rust: .find(|(part, _)| *part == id)
    // rust: .map(|(_, b)| b);
    // rust: let hurt = self.hit_special(id, amount, true, DamageKind::PlayerAttack, None);
        // The sweep and the sounds read the charge, which the hit then spends.
    // rust: if let (Some(area), Hurt::Landed { .. }) = (area, hurt) {
    // rust: self.attack_effects(area, None, false, super::mace::Spared::Nothing, None);
}
    // rust: self.attack_ticks = 0;
    // rust: true
}
    /// The 24 nodes (`findClosestNode` builds them on first use).
pub fn dragon_nodes(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(n) = self.dragon.as_ref().and_then(|d| d.nodes) {
    // rust: return n;
}
    // rust: let mut nodes = [[0; 3]; 24];
    // rust: for (i, node) in nodes.iter_mut().enumerate() {
    // rust: let (r, step, base, add) = if i < 12 {
    // rust: (60.0f32, std::f32::consts::PI / 12.0, i, 5)
    // rust: } else if i < 20 {
    // rust: (40.0, std::f32::consts::PI / 8.0, i - 12, 15)
    // rust: } else {
    // rust: (20.0, std::f32::consts::PI / 4.0, i - 20, 5)
}
    // rust: let a = 2.0 * (-std::f32::consts::PI + step * base as f32);
    // rust: let (x, z) = ((r * a.cos()).floor() as i32, (r * a.sin()).floor() as i32);
    // rust: let y = (self.motion_blocking_no_leaves(x, z) + add).max(73);
    // rust: *node = [x, y, z];
}
    // rust: if let Some(d) = self.dragon.as_mut() {
    // rust: d.nodes = Some(nodes);
}
    // rust: nodes
}
    /// `getHeightmapPos(MOTION_BLOCKING_NO_LEAVES)`.
pub fn motion_blocking_no_leaves(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..256)
    // rust: .rev()
    // rust: .find(|&y| {
    // rust: let f = self.res.facts().get(self.world.block(x, y, z));
    // rust: (f.full_collision
    // rust: || f.legacy_solid
    // rust: || f.fluid != horizon_client::blocks::Fluid::None)
    // rust: && !f.name.ends_with("_leaves")
    // rust: })
    // rust: .map_or(0, |y| y + 1)
}
pub fn podium_top(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vec3::new(0.5, f64::from(self.motion_blocking_no_leaves(0, 0)), 0.5)
}
pub fn closest_node(self: *Self, x: f64, y: f64, z: f64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let nodes = self.dragon_nodes();
    // rust: let start = if self.fight.alive_crystals == 0 {
    // rust: 12
    // rust: } else {
    // rust: 0
}
    // rust: let p = [x.floor() as i32, y.floor() as i32, z.floor() as i32];
    // rust: let mut best = (10_000.0f32, 0);
    // rust: for (i, n) in nodes.iter().enumerate().skip(start) {
    // rust: let d = ((n[0] - p[0]).pow(2) + (n[1] - p[1]).pow(2) + (n[2] - p[2]).pow(2)) as f32;
    // rust: if d < best.0 {
    // rust: best = (d, i);
}
}
    // rust: best.1
}
    /// `findPath` (A* over the adjacency masks), optionally ending at `last`.
pub fn dragon_path(self: *Self, from: usize, to: usize, last: ?[i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let nodes = self.dragon_nodes();
    // rust: let dist = |a: [i32; 3], b: [i32; 3]| {
    // rust: (((a[0] - b[0]).pow(2) + (a[1] - b[1]).pow(2) + (a[2] - b[2]).pow(2)) as f32).sqrt()
}
    // rust: let min = if self.fight.alive_crystals == 0 {
    // rust: 12
    // rust: } else {
    // rust: 0
}
    // rust: let mut g = [f32::MAX; 24];
    // rust: let mut came = [usize::MAX; 24];
    // rust: let mut closed = [false; 24];
    // rust: let mut open = vec![from];
    // rust: g[from] = 0.0;
    // rust: let mut closest = from;
    // rust: while !open.is_empty() {
    // rust: let (k, &cur) = open
    // rust: .iter()
    // rust: .enumerate()
    // rust: .min_by(|a, b| {
    // rust: (g[*a.1] + dist(nodes[*a.1], nodes[to]))
    // rust: .total_cmp(&(g[*b.1] + dist(nodes[*b.1], nodes[to])))
    // rust: })
    // rust: .expect("open set");
    // rust: open.swap_remove(k);
    // rust: if cur == to {
    // rust: closest = to;
    // rust: break;
}
    // rust: if dist(nodes[cur], nodes[to]) < dist(nodes[closest], nodes[to]) {
    // rust: closest = cur;
}
    // rust: closed[cur] = true;
    // rust: for i in min..24 {
    // rust: if ADJACENCY[cur] & (1 << i) != 0 && !closed[i] {
    // rust: let tentative = g[cur] + dist(nodes[cur], nodes[i]);
    // rust: if tentative < g[i] {
    // rust: g[i] = tentative;
    // rust: came[i] = cur;
    // rust: if !open.contains(&i) {
    // rust: open.push(i);
}
}
}
}
}
    // rust: if closest == from && from != to {
    // rust: return None;
}
    // rust: let mut list = vec![nodes[closest]];
    // rust: let mut n = closest;
    // rust: while came[n] != usize::MAX {
    // rust: n = came[n];
    // rust: list.insert(0, nodes[n]);
}
    // rust: if let Some(l) = last {
    // rust: list.push(l);
}
    // rust: Some(Path {
    // rust: nodes: list,
    // rust: next: 0,
    // rust: })
}
pub fn next_target(self: *Self, path: *mut ?PathBox) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = path.as_mut()?;
    // rust: if p.0.done() {
    // rust: return None;
}
    // rust: let c = p.0.next_pos();
    // rust: p.0.advance();
    // rust: let d = self.dragon.as_mut()?;
    // rust: let y = loop {
    // rust: let y = f64::from(c[1]) + f64::from(d.random.next_float() * 20.0);
    // rust: if y >= f64::from(c[1]) {
    // rust: break y;
}
}
    // rust: Some(Vec3::new(f64::from(c[0]), y, f64::from(c[2])))
}
    /// The holding-pattern style path step: around the outer or inner ring.
pub fn ring_path(self: *Self, clockwise: *mut bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = self.dragon.as_mut()?;
    // rust: let flip = d.random.next_int_bound(8).unwrap_or(1) == 0;
    // rust: let current = {
    // rust: let p = d.position;
    // rust: self.closest_node(p.x, p.y, p.z)
}
    // rust: let mut target = current as i32;
    // rust: if flip {
    // rust: *clockwise = !*clockwise;
    // rust: target += 6;
}
    // rust: target += if *clockwise { 1 } else { -1 };
    // rust: if self.fight.alive_crystals > 0 {
    // rust: target = target.rem_euclid(12);
    // rust: } else {
    // rust: target = ((target - 12) & 7) + 12;
}
    // rust: let mut path = self.dragon_path(current, target as usize, None)?;
    // rust: path.advance();
    // rust: Some(path)
}
    /// `DragonStrafePlayerPhase.setTarget`: a path to the player at `p`.
pub fn strafe_begin(self: *Self, p: Vec3) void {
}
    // rust: let Some(d) = self.dragon.as_ref() else {
    // rust: return;
}
    // rust: let dp = d.position;
    // rust: let current = self.closest_node(dp.x, dp.y, dp.z);
    // rust: let target = self.closest_node(p.x, p.y, p.z);
    // rust: let (fx, fz) = (p.x.floor() as i32, p.z.floor() as i32);
    // rust: let sd = (f64::from(fx) - dp.x).hypot(f64::from(fz) - dp.z);
    // rust: let ho = (0.4 + sd / 80.0 - 1.0).min(10.0);
    // rust: let last = [fx, (p.y + ho).floor() as i32, fz];
    // rust: let mut path = self.dragon_path(current, target, Some(last));
    // rust: if let Some(path) = path.as_mut() {
    // rust: path.advance();
}
    // rust: let mut boxed = path.map(PathBox);
    // rust: let target = self.next_target(&mut boxed);
    // rust: if let Some(Dragon {
    // rust: phase: Phase::Strafe {
    // rust: path, target: t, ..
    // rust: },
    // rust: ..
    // rust: }) = self.dragon.as_mut()
    // rust: {
    // rust: *path = boxed;
    // rust: *t = target;
}
}
    /// One phase server tick (`doServerTick`).
pub fn tick_phase(self: *Self) void {
}
    // rust: let players = self.fight_players();
    // rust: let peaceful = self.ui.difficulty == 0;
        // A crystal destroyed since: strafe the player it named.
    // rust: if let Some(d) = self.dragon.as_mut()
    // rust: && let Some(who) = d.strafe_request.take()
    // rust: && matches!(d.phase, Phase::Holding { .. })
    // rust: {
    // rust: let target = players.iter().find(|p| p.who == who).copied();
    // rust: if let Some(t) = target {
    // rust: d.set_phase(Phase::Strafe {
    // rust: charge: 0,
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: player: Some(t.who),
    // rust: });
    // rust: self.strafe_begin(t.position);
}
}
    // rust: let Some(d) = self.dragon.as_ref() else {
    // rust: return;
}
    // rust: let pos = d.position;
    // rust: let mut phase = d.phase.clone();
    // rust: let collided = false;
    // rust: let far = |t: Option<Vec3>| {
    // rust: t.map_or(0.0, |t| {
    // rust: (t.x - pos.x).powi(2) + (t.y - pos.y).powi(2) + (t.z - pos.z).powi(2)
    // rust: })
}
    // rust: let podium = self.podium_top();
        // The egg's place (`getHeightmapPos` at the podium) and its centre.
    // rust: let egg = Vec3::new(0.0, podium.y, 0.0);
    // rust: let egg_centre = Vec3::new(0.5, podium.y + 0.5, 0.5);
    // rust: let mut next: Option<Phase> = None;
        // Where the player a new strafe goes after stands.
    // rust: let mut strafe_at: Option<Vec3> = None;
    // rust: match &mut phase {
    // rust: Phase::Holding {
    // rust: path,
    // rust: target,
    // rust: clockwise,
    // rust: } => {
    // rust: let dt = far(*target);
    // rust: if dt < 100.0 || dt > 22500.0 || collided {
    // rust: let done = path.as_ref().is_some_and(|p| p.0.done());
    // rust: let mut chosen = false;
    // rust: if done {
    // rust: let crystals = self.fight.alive_crystals;
    // rust: let r = &mut self.dragon.as_mut().expect("dragon").random;
    // rust: if r.next_int_bound(crystals + 3).unwrap_or(1) == 0 {
    // rust: next = Some(Phase::LandingApproach {
    // rust: path: None,
    // rust: target: None,
    // rust: });
    // rust: chosen = true;
    // rust: } else if let Some(nearest) =
    // rust: nearest_enemy(&players, peaceful, egg, None, |_| true)
    // rust: {
    // rust: let dist = nearest.position.distance_squared(egg_centre) / 512.0;
    // rust: let r = &mut self.dragon.as_mut().expect("dragon").random;
    // rust: if r.next_int_bound((dist + 2.0) as i32).unwrap_or(1) == 0
    // rust: || r.next_int_bound(crystals + 2).unwrap_or(1) == 0
    // rust: {
    // rust: next = Some(Phase::Strafe {
    // rust: charge: 0,
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: player: Some(nearest.who),
    // rust: });
    // rust: strafe_at = Some(nearest.position);
    // rust: chosen = true;
}
}
}
    // rust: if !chosen {
    // rust: if path.as_ref().is_none_or(|p| p.0.done()) {
    // rust: *path = self.ring_path(clockwise).map(PathBox);
}
    // rust: if let Some(t) = self.next_target(path) {
    // rust: *target = Some(t);
}
}
}
}
    // rust: Phase::Strafe {
    // rust: charge,
    // rust: path,
    // rust: target,
    // rust: clockwise,
    // rust: player,
    // rust: } => {
                // Its target as it is now, whatever became of it; gone from
                // the level, or never found: back to the holding pattern.
    // rust: let tracked = player.and_then(|who| players.iter().find(|p| p.who == who));
    // rust: let Some(pp) = tracked.map(|p| p.position) else {
    // rust: next = Some(Phase::Holding {
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: });
    // rust: self.dragon.as_mut().expect("dragon").phase = phase;
    // rust: if let Some(n) = next {
    // rust: self.dragon.as_mut().expect("dragon").set_phase(n);
}
    // rust: return;
}
    // rust: if path.as_ref().is_some_and(|p| p.0.done()) {
    // rust: let dist = (pp.x - pos.x).hypot(pp.z - pos.z);
    // rust: let ho = (0.4 + dist / 80.0 - 1.0).min(10.0);
    // rust: *target = Some(Vec3::new(pp.x, pp.y + ho, pp.z));
}
    // rust: let dt = far(*target);
    // rust: if dt < 100.0 || dt > 22500.0 {
    // rust: if path.as_ref().is_none_or(|p| p.0.done()) {
    // rust: *path = self.ring_path(clockwise).map(PathBox);
}
    // rust: if let Some(t) = self.next_target(path) {
    // rust: *target = Some(t);
}
}
    // rust: let d2 = (pp.x - pos.x).powi(2) + (pp.y - pos.y).powi(2) + (pp.z - pos.z).powi(2);
                // Entity.hasLineOfSight: eye to eye (the dragon's eye is 0.85 of
                // its 8 block height), blocks only.
    // rust: let sees = d2 < 4096.0 && {
    // rust: let eye = Vec3::new(pos.x, pos.y + 6.8, pos.z);
    // rust: let target_eye =
    // rust: tracked.map_or(pp.y + 1.62, |p| p.bounds.max_position().y - 0.18);
    // rust: self.mob_world_base(&[])
    // rust: .line_of_sight(eye, Vec3::new(pp.x, target_eye, pp.z))
}
    // rust: if sees {
    // rust: *charge += 1;
    // rust: let d = self.dragon.as_ref().expect("dragon");
    // rust: let r = d.yaw.to_radians();
    // rust: let dir = glam::DVec2::new(f64::from(r.sin()), f64::from(-r.cos())).normalize();
    // rust: let aim = glam::DVec2::new(pp.x - pos.x, pp.z - pos.z).normalize_or_zero();
    // rust: let angle = dir.dot(aim).clamp(-1.0, 1.0).acos().to_degrees() + 0.5;
    // rust: if *charge >= 5 && (0.0..10.0).contains(&angle) {
                        // From the head, one block back along the view vector.
    // rust: let head = d.parts[0].0;
    // rust: let view = super::view_vector(d.yaw, 0.0);
    // rust: let start =
    // rust: Vec3::new(head.x - view[0], head.y + 0.5 + 0.5, head.z - view[2]);
    // rust: let to = Vec3::new(pp.x - start.x, pp.y + 0.9 - start.y, pp.z - start.z);
    // rust: self.spawn_dragon_fireball(start, to);
    // rust: *charge = 0;
    // rust: next = Some(Phase::Holding {
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: });
}
    // rust: } else if *charge > 0 {
    // rust: *charge -= 1;
}
}
    // rust: Phase::LandingApproach { path, target } => {
    // rust: let dt = far(*target);
    // rust: if dt < 100.0 || dt > 22500.0 || collided {
    // rust: if path.as_ref().is_none_or(|p| p.0.done()) {
    // rust: let current = self.closest_node(pos.x, pos.y, pos.z);
                        // NEAR_EGG_TARGETING: the enemy nearest the egg.
    // rust: let near_egg = nearest_enemy(&players, peaceful, egg, None, |_| true);
    // rust: let target_node = match near_egg.map(|p| p.position) {
    // rust: Some(pp) => {
    // rust: let aim = glam::DVec2::new(pp.x, pp.z).normalize_or_zero();
    // rust: self.closest_node(-aim.x * 40.0, 105.0, -aim.y * 40.0)
}
    // rust: None => self.closest_node(40.0, podium.y, 0.0),
}
    // rust: let last = [
    // rust: podium.x.floor() as i32,
    // rust: podium.y as i32,
    // rust: podium.z.floor() as i32,
    // rust: ];
    // rust: let mut p = self.dragon_path(current, target_node, Some(last));
    // rust: if let Some(p) = p.as_mut() {
    // rust: p.advance();
}
    // rust: *path = p.map(PathBox);
}
    // rust: if let Some(t) = self.next_target(path) {
    // rust: *target = Some(t);
}
    // rust: if path.as_ref().is_some_and(|p| p.0.done()) {
    // rust: next = Some(Phase::Landing { target: None });
}
}
}
    // rust: Phase::Landing { target } => {
    // rust: let t = *target.get_or_insert(podium);
    // rust: if (t.x - pos.x).powi(2) + (t.y - pos.y).powi(2) + (t.z - pos.z).powi(2) < 1.0 {
    // rust: self.dragon.as_mut().expect("dragon").flame_count = 0;
    // rust: next = Some(Phase::Scanning { time: 0 });
}
}
    // rust: Phase::Takeoff {
    // rust: first,
    // rust: path,
    // rust: target,
    // rust: } => {
    // rust: if !*first && path.is_some() {
    // rust: if (podium.x - pos.x).powi(2)
    // rust: + (podium.y - pos.y).powi(2)
    // rust: + (podium.z - pos.z).powi(2)
    // rust: >= 100.0
    // rust: {
    // rust: next = Some(Phase::Holding {
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: });
}
    // rust: } else {
    // rust: *first = false;
    // rust: let current = self.closest_node(pos.x, pos.y, pos.z);
    // rust: let look = self.dragon_look();
    // rust: let mut t = self.closest_node(-look[0] * 40.0, 105.0, -look[2] * 40.0) as i32;
    // rust: if self.fight.alive_crystals > 0 {
    // rust: t = t.rem_euclid(12);
    // rust: } else {
    // rust: t = ((t - 12) & 7) + 12;
}
    // rust: let mut p = self.dragon_path(current, t as usize, None).map(PathBox);
    // rust: if let Some(pb) = p.as_mut() {
    // rust: pb.0.advance();
}
    // rust: if let Some(t) = self.next_target(&mut p) {
    // rust: *target = Some(t);
}
    // rust: *path = p.or(Some(PathBox(Path::default())));
}
}
    // rust: Phase::Scanning { time } => {
    // rust: *time += 1;
                // scanTargeting: within 20 blocks, at most 10 above or below.
    // rust: let near = nearest_enemy(&players, peaceful, pos, Some((pos, 20.0)), |p| {
    // rust: (p.position.y - pos.y).abs() <= 10.0
    // rust: })
    // rust: .map(|p| p.position);
    // rust: if let Some(pp) = near {
    // rust: if *time > 25 {
    // rust: next = Some(Phase::Attacking { ticks: 0 });
    // rust: } else {
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: let head = d.parts[0].0;
    // rust: let (xd, zd) = (pp.x - head.x, pp.z - head.z);
    // rust: let delta = wrap64(180.0 - xd.atan2(zd).to_degrees() - f64::from(d.yaw))
    // rust: .clamp(-100.0, 100.0);
    // rust: d.yaw_accel *= 0.8;
    // rust: let dist = (xd.hypot(zd) as f32 + 1.0).min(40.0);
    // rust: let rot = xd.hypot(zd) as f32 + 1.0;
    // rust: d.yaw_accel += delta as f32 * (0.7 / dist / rot);
    // rust: d.yaw += d.yaw_accel;
}
    // rust: } else if *time >= 100 {
                    // CHARGE_TARGETING: within 150 blocks.
    // rust: let charge =
    // rust: nearest_enemy(&players, peaceful, pos, Some((pos, 150.0)), |_| true);
    // rust: next = Some(match charge {
    // rust: Some(p) => Phase::Charging {
    // rust: target: Some(p.position),
    // rust: since: 0,
    // rust: },
    // rust: None => Phase::Takeoff {
    // rust: first: true,
    // rust: path: None,
    // rust: target: None,
    // rust: },
    // rust: });
}
}
    // rust: Phase::Attacking { ticks } => {
                // The growl is `doClientTick`'s (`remote_dragon_phase_tick`).
    // rust: *ticks += 1;
    // rust: if *ticks > 40 {
    // rust: next = Some(Phase::Flaming { ticks: 0 });
}
}
    // rust: Phase::Flaming { ticks } => {
    // rust: *ticks += 1;
    // rust: if *ticks >= 200 {
    // rust: let count = self.dragon.as_ref().map_or(0, |d| d.flame_count);
    // rust: next = Some(if count >= 4 {
    // rust: Phase::Takeoff {
    // rust: first: true,
    // rust: path: None,
    // rust: target: None,
}
    // rust: } else {
    // rust: Phase::Scanning { time: 0 }
    // rust: });
    // rust: } else if *ticks == 10 {
    // rust: let d = self.dragon.as_ref().expect("dragon");
    // rust: let head = d.parts[0].0;
    // rust: let look = glam::DVec2::new(head.x - pos.x, head.z - pos.z).normalize_or_zero();
    // rust: let (x, z) = (head.x + look.x * 2.5, head.z + look.y * 2.5);
    // rust: let mut y = head.y + 0.5;
    // rust: while y > 0.0
    // rust: && self.res.facts().is_air(self.world.block(
    // rust: x.floor() as i32,
    // rust: y.floor() as i32,
    // rust: z.floor() as i32,
    // rust: ))
    // rust: {
    // rust: y -= 1.0;
}
    // rust: let id = self.take_entity_id();
    // rust: self.breath_clouds.push(Breath {
    // rust: id,
    // rust: at: [x, y.floor() + 1.0, z],
    // rust: radius: 5.0,
    // rust: age: 0,
    // rust: duration: 200,
    // rust: from_dragon: true,
    // rust: victims: Vec::new(),
    // rust: potion: None,
    // rust: });
}
}
    // rust: Phase::Charging { target, since } => {
    // rust: if target.is_none() {
    // rust: next = Some(Phase::Holding {
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: });
    // rust: } else if *since > 0 {
    // rust: *since += 1;
    // rust: if *since >= 10 {
    // rust: next = Some(Phase::Holding {
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
    // rust: });
}
    // rust: } else {
    // rust: let dt = far(*target);
    // rust: if dt < 100.0 || dt > 22500.0 {
    // rust: *since += 1;
}
}
}
    // rust: Phase::Dying { target, time } => {
    // rust: *time += 1;
    // rust: let t = *target.get_or_insert(Vec3::new(
    // rust: 0.5,
    // rust: f64::from(self.motion_blocking_no_leaves(0, 0)),
    // rust: 0.5,
    // rust: ));
    // rust: let dt = (t.x - pos.x).powi(2) + (t.y - pos.y).powi(2) + (t.z - pos.z).powi(2);
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: d.health = if !(100.0..=22500.0).contains(&dt) {
    // rust: 0.0
    // rust: } else {
    // rust: 1.0
}
}
    // rust: Phase::Hover { target } => {
    // rust: target.get_or_insert(pos);
}
}
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: d.phase = phase;
    // rust: if let Some(n) = next {
    // rust: d.set_phase(n);
    // rust: if let Some(at) = strafe_at {
    // rust: self.strafe_begin(at);
}
}
}
    /// `getHeadLookVector`.
pub fn dragon_look(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(d) = self.dragon.as_ref() else {
    // rust: return [0.0; 3];
}
    // rust: let pitch = match d.phase {
    // rust: Phase::Landing { .. } | Phase::Takeoff { .. } => {
    // rust: let p = self.podium_top();
    // rust: let dist = ((p.x - d.position.x).powi(2)
    // rust: + (p.y - d.position.y).powi(2)
    // rust: + (p.z - d.position.z).powi(2))
    // rust: .sqrt() as f32
    // rust: / 4.0;
    // rust: -6.0 / dist.max(1.0) * 1.5 * 5.0
}
    // rust: _ if d.phase.sitting() => -45.0,
    // rust: _ => 0.0,
}
    // rust: super::view_vector(d.yaw, pitch).map(|v| v)
}
    /// `getHeadLookVector(1).normalize()`, which the phases' `doClientTick`s
    /// take (a look the dragon has never turned from stays the zero vector).
pub fn dragon_look_normalised(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let look = self.dragon_look();
    // rust: let norm = (look[0] * look[0] + look[1] * look[1] + look[2] * look[2]).sqrt();
    // rust: if norm < 1.0e-5 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: [look[0] / norm, look[1] / norm, look[2] / norm]
}
}
    /// `EnderDragon.aiStep` (and `tickDeath`) for the dragon.
pub fn tick_dragon(self: *Self) void {
}
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return;
}
    // rust: d.previous = d.position;
    // rust: d.previous_yaw = d.yaw;
    // rust: d.old_flap = d.flap;
    // rust: d.ticks += 1;
    // rust: d.hurt_time = (d.hurt_time - 1).max(0);
    // rust: d.invulnerable = (d.invulnerable - 1).max(0);
    // rust: for part in &mut d.parts {
    // rust: part.1 = part.0;
}
    // rust: if !d.alive() {
    // rust: self.tick_dragon_death();
    // rust: return;
}
        // Mob.baseTick: the ambient sound, rarer right after one.
    // rust: let roll = d.random.next_int_bound(1000).unwrap_or(999);
    // rust: let waited = d.ambient_time;
    // rust: d.ambient_time += 1;
    // rust: if roll < waited {
    // rust: d.ambient_time = -AMBIENT_INTERVAL;
    // rust: let at = [d.position.x, d.position.y, d.position.z];
            // LivingEntity.getVoicePitch, from the dragon's own random.
    // rust: let r = &mut d.random;
    // rust: let pitch = (r.next_float() - r.next_float()) * 0.2 + 1.0;
    // rust: self.audio.play(
    // rust: "minecraft:entity.ender_dragon.ambient",
    // rust: Some(at),
    // rust: 5.0,
    // rust: pitch,
    // rust: );
}
    // rust: let d = self.dragon.as_mut().expect("dragon");
        // Flapping, growls and the flap sound.
    // rust: let flap_was = (d.old_flap * std::f32::consts::TAU).cos();
    // rust: let v = d.velocity;
    // rust: let mut flap_speed = 0.2 / ((v.x.hypot(v.z) as f32) * 10.0 + 1.0);
    // rust: flap_speed *= 2f32.powf(v.y as f32);
    // rust: d.flap += if d.phase.sitting() {
    // rust: 0.1
    // rust: } else if d.in_wall {
    // rust: flap_speed * 0.5
    // rust: } else {
    // rust: flap_speed
}
    // rust: let flap_now = (d.flap * std::f32::consts::TAU).cos();
    // rust: let at = [d.position.x, d.position.y, d.position.z];
    // rust: if flap_was <= -0.3 && flap_now >= -0.3 {
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.3;
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_dragon.flap", Some(at), 5.0, pitch);
}
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: if !d.phase.sitting() {
    // rust: d.growl -= 1;
    // rust: if d.growl < 0 {
    // rust: d.growl = 200 + d.random.next_int_bound(200).unwrap_or(0);
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.3;
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_dragon.growl", Some(at), 2.5, pitch);
}
}
        // checkCrystals: heal 1 every 10 ticks from the nearest crystal, found
        // among those touching the dragon's box grown by 32.
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: if d.nearest_crystal.is_some() && d.ticks % 10 == 0 && d.health < MAX_HEALTH {
            // LivingEntity.setHealth clamps to the maximum.
    // rust: d.health = (d.health + 1.0).min(MAX_HEALTH);
}
    // rust: if d.random.next_int_bound(10).unwrap_or(1) == 0 {
    // rust: let p = d.position;
    // rust: let nearest = self.nearest_crystal_to(p);
    // rust: self.dragon.as_mut().expect("dragon").nearest_crystal = nearest;
}
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: d.yaw = wrap(d.yaw);
        // EnderDragon.aiStep with isNoAi: the flap stops half way, and nothing
        // else moves it (no flight history, phase, steering or parts).
    // rust: if d.no_ai {
    // rust: d.flap = 0.5;
    // rust: return;
}
    // rust: d.record();
    // rust: self.tick_phase();
        // Steering towards the phase's fly target.
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return;
}
    // rust: if let Some(t) = d.phase.target() {
    // rust: let (xd, mut yd, zd) = (t.x - d.position.x, t.y - d.position.y, t.z - d.position.z);
    // rust: let dist2 = xd * xd + yd * yd + zd * zd;
    // rust: let max = f64::from(d.phase.fly_speed());
    // rust: let horizontal = xd.hypot(zd);
    // rust: if horizontal > 0.0 {
    // rust: yd = (yd / horizontal).clamp(-max, max);
}
    // rust: d.velocity.y += yd * 0.01;
    // rust: d.yaw = wrap(d.yaw);
    // rust: let aim = glam::DVec3::new(xd, t.y - d.position.y, zd).normalize_or_zero();
    // rust: let r = d.yaw.to_radians();
    // rust: let dir = glam::DVec3::new(f64::from(r.sin()), d.velocity.y, f64::from(-r.cos()))
    // rust: .normalize_or_zero();
    // rust: let dot = ((dir.dot(aim) as f32 + 0.5) / 1.5).max(0.0);
    // rust: if xd.abs() > 1.0e-5 || zd.abs() > 1.0e-5 {
    // rust: let turn = match d.phase {
    // rust: Phase::Landing { .. } => {
    // rust: let rot = d.velocity.x.hypot(d.velocity.z) as f32 + 1.0;
    // rust: rot.min(40.0) / rot
}
    // rust: _ => {
    // rust: let rot = d.velocity.x.hypot(d.velocity.z) as f32 + 1.0;
    // rust: 0.7 / rot.min(40.0) / rot
}
}
    // rust: let delta =
    // rust: wrap(180.0 - xd.atan2(zd).to_degrees() as f32 - d.yaw).clamp(-50.0, 50.0);
    // rust: d.yaw_accel *= 0.8;
    // rust: d.yaw_accel += delta * turn;
    // rust: d.yaw += d.yaw_accel * 0.1;
}
    // rust: let span = (2.0 / (dist2 + 1.0)) as f32;
    // rust: let speed = 0.06 * (dot * span + (1.0 - span));
            // moveRelative(speed, (0, 0, -1)).
    // rust: let r = d.yaw.to_radians();
    // rust: d.velocity.x += f64::from(speed * r.sin());
    // rust: d.velocity.z += f64::from(-speed * r.cos());
    // rust: let step = if d.in_wall { 0.8 } else { 1.0 };
    // rust: d.position = Vec3::new(
    // rust: d.position.x + d.velocity.x * step,
    // rust: d.position.y + d.velocity.y * step,
    // rust: d.position.z + d.velocity.z * step,
    // rust: );
    // rust: let actual =
    // rust: glam::DVec3::new(d.velocity.x, d.velocity.y, d.velocity.z).normalize_or_zero();
    // rust: let slide = 0.8 + 0.15 * (actual.dot(dir) + 1.0) / 2.0;
    // rust: d.velocity = Vec3::new(
    // rust: d.velocity.x * slide,
    // rust: d.velocity.y * 0.91,
    // rust: d.velocity.z * slide,
    // rust: );
}
    // rust: self.place_dragon_parts();
    // rust: self.dragon_contacts();
        // The chunks the dragon passes through re-save their entity lists.
    // rust: if let Some(d) = &self.dragon {
    // rust: for p in [d.previous, d.position] {
    // rust: self.world
    // rust: .modified
    // rust: .insert((p.x.floor() as i32 >> 4, p.z.floor() as i32 >> 4));
}
}
}
    /// The part positions from the yaw and the flight history.
pub fn place_dragon_parts(self: *Self) void {
}
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return;
}
    // rust: let tilt =
    // rust: ((d.sample(5).0 - d.sample(10).0) * 10.0) as f32 * (std::f32::consts::PI / 180.0);
    // rust: let (ct, st) = (tilt.cos(), tilt.sin());
    // rust: let r1 = d.yaw.to_radians();
    // rust: let (s1, c1) = (r1.sin(), r1.cos());
    // rust: let p = d.position;
    // rust: let set = |d: &mut Dragon, i: usize, x: f32, y: f64, z: f32| {
    // rust: d.parts[i].0 = Vec3::new(p.x + f64::from(x), p.y + y, p.z + f64::from(z));
}
    // rust: set(d, 2, s1 * 0.5, 0.0, -c1 * 0.5);
    // rust: set(d, 6, c1 * 4.5, 2.0, s1 * 4.5);
    // rust: set(d, 7, c1 * -4.5, 2.0, s1 * -4.5);
    // rust: let r2 = d.yaw.to_radians() - d.yaw_accel * 0.01;
    // rust: let (s2, c2) = (r2.sin(), r2.cos());
    // rust: let y_off = if d.phase.sitting() {
    // rust: -1.0
    // rust: } else {
    // rust: d.sample(5).0 - d.sample(0).0
    // rust: } as f32;
    // rust: set(
    // rust: d,
    // rust: 0,
    // rust: s2 * 6.5 * ct,
    // rust: f64::from(y_off + st * 6.5),
    // rust: -c2 * 6.5 * ct,
    // rust: );
    // rust: set(
    // rust: d,
    // rust: 1,
    // rust: s2 * 5.5 * ct,
    // rust: f64::from(y_off + st * 5.5),
    // rust: -c2 * 5.5 * ct,
    // rust: );
    // rust: let p1 = d.sample(5);
    // rust: for i in 0..3 {
    // rust: let p0 = d.sample(12 + i * 2);
    // rust: let rot = d.yaw.to_radians() + wrap(p0.1 - p1.1).to_radians();
    // rust: let (ss, cc) = (rot.sin(), rot.cos());
    // rust: let dd = (i as f32 + 1.0) * 2.0;
    // rust: let x = -(s1 * 1.5 + ss * dd) * ct;
    // rust: let y = p0.0 - p1.0 - f64::from((dd + 1.5) * st) + 1.5;
    // rust: let z = (c1 * 1.5 + cc * dd) * ct;
    // rust: set(d, 3 + i, x, y, z);
}
}
    /// `Level.getEntity`: revenge goals must resolve the dragon too.
    // rust: pub(super) fn dragon_target(&self) -> Option<(u32, horizon_client::mobs::TargetInfo)> {
    // rust: let d = self.dragon.as_ref().filter(|d| d.alive())?;
    // rust: let p = d.position;
    // rust: Some((
    // rust: d.id,
    // rust: horizon_client::mobs::TargetInfo {
    // rust: position: p,
    // rust: eye_y: p.y + 6.8,
    // rust: bounds: Aabb::new(
    // rust: Vec3::new(p.x - 8.0, p.y, p.z - 8.0),
    // rust: Vec3::new(p.x + 8.0, p.y + 8.0, p.z + 8.0),
    // rust: ),
    // rust: alive: true,
    // rust: can_be_seen_as_enemy: true,
    // rust: is_player: false,
    // rust: creative: false,
    // rust: passenger: false,
    // rust: },
    // rust: ))
}
    /// Wing knockback, head and neck damage, and breaking blocks in the way.
pub fn dragon_contacts(self: *Self) void {
}
    // rust: let Some(d) = self.dragon.as_ref() else {
    // rust: return;
}
    // rust: let sitting = d.phase.sitting();
    // rust: let recently_hurt = d.hurt_time > 0;
    // rust: let body = d.part_box(2);
    // rust: let (bc, bz) = (
    // rust: (body.min_position().x + body.max_position().x) / 2.0,
    // rust: (body.min_position().z + body.max_position().z) / 2.0,
    // rust: );
    // rust: let wings = [d.part_box(6), d.part_box(7)];
    // rust: let heads = [d.part_box(0), d.part_box(1)];
    // rust: if !recently_hurt {
            // EntitySelector.NO_CREATIVE_OR_SPECTATOR, every player alike.
    // rust: let players: Vec<FightPlayer> = self
    // rust: .fight_players()
    // rust: .into_iter()
    // rust: .filter(|p| p.alive && !p.creative && !p.spectator)
    // rust: .collect();
    // rust: for p in players {
                // knockBack, once for each wing whose zone holds them.
    // rust: for w in wings {
    // rust: let zone = w
    // rust: .inflate(Vec3::new(4.0, 2.0, 4.0))
    // rust: .move_by(Vec3::new(0.0, -2.0, 0.0));
    // rust: if zone.intersects(p.bounds) {
    // rust: let (xd, zd) = (p.position.x - bc, p.position.z - bz);
    // rust: let dd = (xd * xd + zd * zd).max(0.1);
    // rust: let push = Vec3::new(xd / dd * 4.0, f64::from(0.2_f32), zd / dd * 4.0);
    // rust: self.as_fight_player(p.who, |g| g.dragon_wing_knock_back(push, sitting));
}
}
                // hurt: the head and the neck.
    // rust: for h in heads {
    // rust: if h.inflate(Vec3::new(1.0, 1.0, 1.0)).intersects(p.bounds) {
    // rust: self.as_fight_player(p.who, |g| {
    // rust: g.dragon_hurts_player("minecraft:mob_attack", 10.0);
    // rust: });
}
}
}
}
        // EnderDragon.aiStep queries living entities, not only players.
    // rust: if let Some(d) = self.dragon.as_ref() {
    // rust: let frame = horizon_client::mobs::dragon_contacts::Frame {
    // rust: dragon_id: d.id,
    // rust: origin: d.position,
    // rust: center: (bc, bz),
    // rust: wings: wings.map(|w| {
    // rust: w.inflate(Vec3::new(4.0, 2.0, 4.0))
    // rust: .move_by(Vec3::new(0.0, -2.0, 0.0))
    // rust: }),
    // rust: heads: heads.map(|h| h.inflate(Vec3::new(1.0, 1.0, 1.0))),
    // rust: sitting,
    // rust: recently_hurt,
}
            // Keep team lookup in Game (including tamed pets' owner teams).
    // rust: let allowed: Vec<bool> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .map(|m| {
    // rust: horizon_client::scoreboard::teams_allow_damage(
    // rust: self.mob_team(d.id),
    // rust: self.mob_team_of(m),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: for (mob, allowed) in self.mobs.iter_mut().zip(allowed) {
    // rust: horizon_client::mobs::dragon_contacts::contact(mob, &frame, allowed);
}
}
        // checkWalls over head, neck and body.
    // rust: let griefing = self.ui.rules.bool("mob_griefing");
    // rust: let mut in_wall = false;
    // rust: let Some(d) = self.dragon.as_ref() else {
    // rust: return;
}
    // rust: let boxes = [d.part_box(0), d.part_box(1), d.part_box(2)];
    // rust: let tags = &self.items().block_tags;
    // rust: let transparent = tags
    // rust: .get("minecraft:dragon_transparent")
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: let immune = tags
    // rust: .get("minecraft:dragon_immune")
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: let mut removed = Vec::new();
    // rust: for b in boxes {
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: let state = self.world.block(x, y, z);
    // rust: let name = &self.res.facts().get(state).name;
    // rust: if self.res.facts().is_air(state) || transparent.contains(&**name) {
    // rust: continue;
}
    // rust: if griefing && !immune.contains(&**name) {
    // rust: removed.push([x, y, z]);
    // rust: } else {
    // rust: in_wall = true;
}
}
}
}
}
    // rust: let air = self.world.air;
    // rust: let broke = !removed.is_empty();
    // rust: for p in removed {
    // rust: let _ = self.level_set(p, air);
}
    // rust: if broke && let Some(d) = self.dragon.as_ref() {
    // rust: let p = d.parts[0].0;
            // Level event 2008: an explosion puff where a block broke.
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::Explosion),
    // rust: [p.x, p.y, p.z],
    // rust: [0.0; 3],
    // rust: );
}
    // rust: if let Some(d) = self.dragon.as_mut() {
    // rust: d.in_wall = in_wall;
}
}
    /// `Entity.isSilent` of the dragon: its `Silent`, kept with the fields
    /// Horizon models nowhere (`remember_tags`: `/summon`, a load).
pub fn dragon_silent(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let raw = self
    // rust: .dragon
    // rust: .as_ref()
    // rust: .filter(|d| d.id != 0)
    // rust: .and_then(|d| self.persist.raw.get(&d.id));
    // rust: saved_silent(raw)
}
    /// `tickDeath`: rising for 200 ticks, explosions, experience, then the
    /// exit portal, the egg and a gateway.
pub fn tick_dragon_death(self: *Self) void {
}
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return;
}
    // rust: d.death_time += 1;
    // rust: let t = d.death_time;
    // rust: let p = d.position;
    // rust: let r = &mut d.random;
    // rust: let mut off = || {
    // rust: [
    // rust: f64::from((r.next_float() - 0.5) * 8.0),
    // rust: f64::from((r.next_float() - 0.5) * 4.0),
    // rust: f64::from((r.next_float() - 0.5) * 8.0),
    // rust: ]
}
    // rust: if (180..=200).contains(&t) {
    // rust: let o = off();
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::ExplosionEmitter),
    // rust: [p.x + o[0], p.y + 2.0 + o[1], p.z + o[2]],
    // rust: [0.0; 3],
    // rust: );
}
        // Only the fight's own dragon has a fight (`dragonFight`): elsewhere
        // (`/summon`), or summoned in the End after the fight is won, a
        // dragon is worth 500 and its death ends nothing.
    // rust: let fight = self.is_fight_dragon();
    // rust: let first_kill = fight && !self.fight.previously_killed;
    // rust: let xp = if first_kill { 12000 } else { 500 };
    // rust: let drops = self.ui.rules.bool("mob_drops");
    // rust: if t > 150 && t % 5 == 0 && drops {
    // rust: self.spawn_orbs([p.x, p.y, p.z], (xp as f32 * 0.08) as u32);
}
    // rust: if t == 1 && !self.dragon_silent() {
            // EnderDragon.tickDeath: global level event 1028, the death
            // roar, heard everywhere, unless the dragon is silent.
    // rust: let at = [p.x, p.y, p.z].map(|v| v.floor() as i32);
    // rust: self.global_level_event(1028, at, 0);
}
    // rust: if let Some(d) = self.dragon.as_mut() {
    // rust: d.position.y += 0.1;
    // rust: for part in &mut d.parts {
    // rust: part.0.y += 0.1;
}
}
    // rust: if t >= 200 {
    // rust: if drops {
    // rust: self.spawn_orbs([p.x, p.y, p.z], (xp as f32 * 0.2) as u32);
}
    // rust: let (id, at) = self.dragon.as_ref().map_or((0, p), |d| (d.id, d.position));
    // rust: self.dragon = None;
    // rust: if fight {
    // rust: self.dragon_killed();
}
            // remove, then gameEvent(ENTITY_DIE): with no health left,
            // `Warden.canTargetEntity` refuses the dragon, so no warden hears it.
    // rust: self.dragon_died_event(id, at, false);
}
}
    /// `Entity.gameEvent(GameEvent.ENTITY_DIE)` for the removed dragon: sculk
    /// sensors (and, while it has health, wardens) hear it, and the nearest
    /// catalyst blooms (`CatalystListener`). It takes no experience: the
    /// dragon's `xpReward` is 0, its orbs come from `tickDeath`.
pub fn dragon_died_event(self: *Self, id: u32, at: Vec3, targetable: bool) void {
}
    // rust: let at = [at.x, at.y, at.z];
    // rust: let ctx = horizon_client::sculk::Context {
    // rust: source: Some(Who::Mob(id)),
    // rust: targetable,
    // rust: living: true,
    // rust: ..Default::default()
}
    // rust: self.post_game_event("minecraft:entity_die", at, ctx);
    // rust: self.catalyst_takes_experience(at, |_| 0);
}
    /// `EnderDragonFight.setDragonKilled`.
pub fn dragon_killed(self: *Self) void {
}
    // rust: let _ = self.activate_exit_portal();
    // rust: if let Some(g) = self.fight.gateways.pop() {
    // rust: let a = 2.0 * (-std::f64::consts::PI + std::f64::consts::PI / 20.0 * f64::from(g));
    // rust: let pos = [
    // rust: (96.0 * a.cos()).floor() as i32,
    // rust: 75,
    // rust: (96.0 * a.sin()).floor() as i32,
    // rust: ];
    // rust: self.level_event_at(3000, pos, 0);
    // rust: let _ = self.place_gateway_at(pos);
}
    // rust: if !self.fight.previously_killed
    // rust: && let Some(egg) = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:dragon_egg")
    // rust: {
    // rust: let y = (0..256)
    // rust: .rev()
    // rust: .find(|&y| {
    // rust: let f = self.res.facts().get(self.world.block(0, y, 0));
    // rust: f.full_collision || f.legacy_solid
    // rust: })
    // rust: .map_or(64, |y| y + 1);
    // rust: let pos = BlockPos::new(0, y, 0);
    // rust: let allowed = self.with_level(|_, level, _| {
    // rust: let mut cancel = false;
    // rust: if level.native_authoritative {
    // rust: level.native_dragon_egg_form(level.dimension, pos, &mut cancel);
}
    // rust: !cancel
    // rust: });
    // rust: if allowed {
    // rust: let _ = self.level_set([0, y, 0], egg);
}
}
    // rust: self.fight.previously_killed = true;
    // rust: self.fight.killed = true;
    // rust: self.fight.dirty = true;
    // rust: self.save_fight();
}
pub fn spawn_dragon_fireball(self: *Self, at: Vec3, dir: Vec3) void {
}
    // rust: let l = (dir.x * dir.x + dir.y * dir.y + dir.z * dir.z)
    // rust: .sqrt()
    // rust: .max(1.0e-6);
    // rust: let v = Vec3::new(dir.x / l, dir.y / l, dir.z / l);
    // rust: self.audio.play(
    // rust: "minecraft:entity.ender_dragon.shoot",
    // rust: Some([at.x, at.y, at.z]),
    // rust: 10.0,
    // rust: 1.0,
    // rust: );
        // assignDirectionalMovement: the direction times the acceleration power 0.1.
    // rust: let velocity = Vec3::new(v.x * 0.1, v.y * 0.1, v.z * 0.1);
    // rust: let id = self.take_entity_id();
    // rust: self.dragon_fireballs.push(DragonFireball {
    // rust: id,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity,
    // rust: age: 0,
    // rust: });
}
    /// `DragonFireball` (an AbstractHurtingProjectile): accelerating by its
    /// power, bursting into dragon's breath on impact.
    // rust: pub(super) fn tick_dragon_fireballs(&mut self) {
    // rust: let mut balls = std::mem::take(&mut self.dragon_fireballs);
        // Projectile.canHitEntity: any player but spectators.
    // rust: let players: Vec<Aabb> = self
    // rust: .fight_players()
    // rust: .iter()
    // rust: .filter(|p| p.alive && !p.spectator)
    // rust: .map(|p| p.bounds)
    // rust: .collect();
        // The mobs too: they stop it, and DragonFireball.onHit snaps to any
        // living entity (the players first here). Gathered only while a
        // fireball flies: this runs every tick in the End, among its endermen.
    // rust: let mobs: Vec<(Aabb, Vec3)> = if balls.is_empty() {
    // rust: Vec::new()
    // rust: } else {
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .map(|m| (m.bounds(), m.position))
    // rust: .collect()
}
    // rust: let snap_targets: Vec<(Aabb, Vec3)> = self
    // rust: .fight_players()
    // rust: .iter()
    // rust: .filter(|p| p.alive)
    // rust: .map(|p| (p.bounds, p.position))
    // rust: .chain(mobs.iter().copied())
    // rust: .collect();
    // rust: balls.retain_mut(|b| {
    // rust: b.previous = b.position;
    // rust: b.age += 1;
    // rust: let v = b.velocity;
    // rust: let next = Vec3::new(b.position.x + v.x, b.position.y + v.y, b.position.z + v.z);
            // AbstractHurtingProjectile: accelerate along the motion, inertia 0.95.
    // rust: let l = (v.x * v.x + v.y * v.y + v.z * v.z).sqrt().max(1.0e-9);
    // rust: b.velocity = Vec3::new(
    // rust: (v.x + v.x / l * 0.1) * 0.95,
    // rust: (v.y + v.y / l * 0.1) * 0.95,
    // rust: (v.z + v.z / l * 0.1) * 0.95,
    // rust: );
    // rust: let hit_block = {
    // rust: let p = [
    // rust: next.x.floor() as i32,
    // rust: next.y.floor() as i32,
    // rust: next.z.floor() as i32,
    // rust: ];
    // rust: let f = self.res.facts().get(self.world.block(p[0], p[1], p[2]));
    // rust: f.full_collision || f.legacy_solid
}
    // rust: let hit_entity = players.iter().chain(mobs.iter().map(|m| &m.0)).any(|pb| {
    // rust: pb.intersects(Aabb::new(
    // rust: Vec3::new(next.x - 0.5, next.y - 0.5, next.z - 0.5),
    // rust: Vec3::new(next.x + 0.5, next.y + 0.5, next.z + 0.5),
    // rust: ))
    // rust: });
    // rust: if hit_block || hit_entity || b.age > 600 {
    // rust: let id = self.take_entity_id();
                // The cloud starts at the fireball's feet; DragonFireball.onHit
                // then moves it to the first living entity within 4 blocks.
    // rust: let feet = [next.x, next.y - 0.5, next.z];
    // rust: let at = fireball_cloud_origin(feet, &snap_targets);
    // rust: self.breath_clouds.push(Breath {
    // rust: id,
    // rust: at,
    // rust: radius: 3.0,
    // rust: age: 0,
    // rust: duration: 600,
    // rust: from_dragon: false,
    // rust: victims: Vec::new(),
    // rust: potion: None,
    // rust: });
                // DragonFireball.onHit: level event 2006 (the burst of dragon
                // breath and the explosion sound) at its block position.
    // rust: self.level_event_at(
    // rust: 2006,
    // rust: [
    // rust: next.x.floor() as i32,
    // rust: next.y.floor() as i32,
    // rust: next.z.floor() as i32,
    // rust: ],
    // rust: 1,
    // rust: );
    // rust: return false;
}
    // rust: b.position = next;
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::DragonBreath),
    // rust: [next.x, next.y + 0.5, next.z],
    // rust: [0.0; 3],
    // rust: );
    // rust: true
    // rust: });
    // rust: self.dragon_fireballs.append(&mut balls);
    // rust: self.tick_breath();
}
    /// The dragon's breath clouds (`AreaEffectCloud` with instant damage at
    /// a quarter duration scale): shrinking, puffing particles, harming the
    /// players and mobs in it.
pub fn tick_breath(self: *Self) void {
}
        // What instant damage reaches: neither creative nor spectator players.
    // rust: let players: Vec<FightPlayer> = self
    // rust: .fight_players()
    // rust: .into_iter()
    // rust: .filter(|p| p.alive && !p.creative && !p.spectator)
    // rust: .collect();
        // AreaEffectCloud.serverTick: every living entity, the mobs that
        // instant damage can affect (`canBeAffected`) too; only while a
        // breath cloud is there (lingering potions' clouds tick elsewhere).
    // rust: let no_breath = self.breath_clouds.iter().all(|c| c.potion.is_some());
    // rust: let mobs: Vec<(u32, Aabb, Vec3)> = if no_breath {
    // rust: Vec::new()
    // rust: } else {
    // rust: let tags = &self.stations().enchantments.entity_tags;
    // rust: self.mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive() && mob_can_be_affected(tags, &m.kind.id, "instant_damage"))
    // rust: .map(|m| (m.id, m.bounds(), m.position))
    // rust: .collect()
}
    // rust: let mut harmed: Vec<(FightWho, f32)> = Vec::new();
    // rust: let mut harmed_mobs: Vec<(u32, i32, [f64; 3])> = Vec::new();
        // DragonSittingFlamingPhase.end discards the flame cloud.
    // rust: let flame_over = self
    // rust: .dragon
    // rust: .as_ref()
    // rust: .is_some_and(|d| !matches!(d.phase, Phase::Flaming { .. }));
    // rust: let mut clouds = std::mem::take(&mut self.breath_clouds);
    // rust: clouds.retain_mut(|c| {
            // Lingering potions' clouds tick with the potions.
    // rust: if c.potion.is_some() {
    // rust: return true;
}
    // rust: if c.from_dragon && flame_over {
    // rust: return false;
}
    // rust: c.age += 1;
    // rust: if breath_expired(c.age, c.duration) {
    // rust: return false;
}
    // rust: if !c.from_dragon && c.age >= BREATH_WAIT {
                // DragonFireball's cloud: radius per tick (7 - 3) / duration.
    // rust: c.radius += (7.0 - 3.0) / c.duration as f32;
}
    // rust: let r = c.radius;
    // rust: for _ in 0..((std::f32::consts::PI * r * r) as i32).min(40) {
    // rust: let a = self.world.random.next_float() * std::f32::consts::TAU;
    // rust: let d = self.world.random.next_float().sqrt() * r;
    // rust: let at = [
    // rust: c.at[0] + f64::from(a.cos() * d),
    // rust: c.at[1],
    // rust: c.at[2] + f64::from(a.sin() * d),
    // rust: ];
    // rust: self.particles.add_with(
    // rust: &ParticleOptions::simple(ParticleType::DragonBreath),
    // rust: at,
    // rust: [0.0, 0.0, 0.0],
    // rust: false,
    // rust: true,
    // rust: );
}
            // AreaEffectCloud: after its wait, each entity every 20 ticks.
            // Instant damage I from the flame cloud, II from a fireball's,
            // both at the cloud's 0.5 scale.
    // rust: let amount = harm_amount(u32::from(!c.from_dragon));
    // rust: let inside = players
    // rust: .iter()
    // rust: .filter(|p| cloud_hits(c.at, r, p.bounds, p.position))
    // rust: .map(|p| Victim::Player(p.who))
    // rust: .chain(
    // rust: mobs.iter()
    // rust: .filter(|m| cloud_hits(c.at, r, m.1, m.2))
    // rust: .map(|m| Victim::Mob(m.0)),
    // rust: );
    // rust: for victim in breath_victims(c.age, &mut c.victims, inside) {
    // rust: match victim {
    // rust: Victim::Player(who) => harmed.push((who, amount)),
    // rust: Victim::Mob(id) => harmed_mobs.push((id, i32::from(!c.from_dragon), c.at)),
}
}
    // rust: true
    // rust: });
    // rust: self.breath_clouds.append(&mut clouds);
    // rust: for (who, amount) in harmed {
    // rust: self.as_fight_player(who, |g| {
    // rust: g.dragon_hurts_player("minecraft:indirect_magic", amount);
    // rust: });
}
    // rust: for (id, amplifier, at) in harmed_mobs {
    // rust: self.breath_affect_mob(id, amplifier, at);
}
}
    /// `EnderDragon.knockBack` on the player in a wing's zone: pushed away
    /// from the body, and hurt for 5 unless the dragon is perched
    /// (`isSitting`) or a mob hurt the player within the last 2 ticks
    /// (`getLastHurtByMobTimestamp() < tickCount - 2`).
pub fn dragon_wing_knock_back(self: *Self, push: Vec3, sitting: bool) void {
}
    // rust: let now = self.world.game_time;
    // rust: let hurt_lately = self.player_hurt_by().is_some_and(|(_, at)| at >= now - 2);
    // rust: let hurts = !sitting && !hurt_lately && !self.creative;
    // rust: if hurts {
    // rust: self.note_dragon_attacker("minecraft:mob_attack");
}
    // rust: let (health, rules) = (&self.health_resources, self.world.health_rules);
    // rust: let id = health.damage.id("minecraft:mob_attack");
    // rust: let mut canceled = false;
    // rust: if let Some(p) = self.player.as_mut() {
    // rust: push_seen_with_hurt(p, push, |p| {
    // rust: if let Some(id) = id.filter(|_| hurts)
    // rust: && let Ok(o) = p.hurt_blocking(health, rules, id, 5.0, None)
    // rust: {
    // rust: canceled = o.canceled;
}
    // rust: });
}
    // rust: self.combat.forget_noted(canceled);
}
    /// Damage from the dragon, which is its causing entity
    /// (`DamageSources.mobAttack(dragon)`, `indirectMagic(cloud, dragon)`): the
    /// death message names it, or the cloud once the dragon is gone.
pub fn dragon_hurts_player(self: *Self, damage_type: []const u8, amount: f32) void {
}
    // rust: self.note_dragon_attacker(damage_type);
    // rust: self.hurt_player_by(damage_type, amount);
}
    /// The causing entity of the dragon's next `damage_type` damage, for the
    /// death message.
pub fn note_dragon_attacker(self: *Self, damage_type: []const u8) void {
}
    // rust: if let Some(id) = self.dragon.as_ref().map(|d| d.id) {
    // rust: let name = Text::translate("entity.minecraft.ender_dragon", &[]);
    // rust: self.note_named_attacker(damage_type, id, name);
    // rust: } else if damage_type == "minecraft:indirect_magic" {
    // rust: let name = Text::translate("entity.minecraft.area_effect_cloud", &[]);
    // rust: self.note_direct_entity(damage_type, name);
}
}
    /// `BossHealthOverlay.extractRenderState`: whatever `publish_boss_bars`
    /// (or a server's packets) put on this client's overlay.
    // rust: pub(super) fn draw_boss_bars(&self, batch: &mut HudBatch) {
    // rust: let bars = self
    // rust: .boss_overlay
    // rust: .bars(horizon_client::boss_overlay::now_millis());
    // rust: let draws = hud_overlays::boss_overlay(
    // rust: batch.width as i32,
    // rust: batch.height as i32,
    // rust: &bars,
    // rust: &self.gui.atlas.font,
    // rust: );
    // rust: hud_layout::paint(batch, &self.gui.atlas, &draws);
}
    /// The dragon fight's bar for a player at `at`
    /// (`EnderDragonFight.dragonEvent`, visible while the fight is not won
    /// and the player is alive within 192 blocks of (0, 128, 0)).
    // rust: pub(super) fn dragon_boss_progress(&self, at: [f64; 3], alive: bool) -> Option<f32> {
    // rust: if self.dim != Dim::End || !alive || !self.fight.loaded || self.fight.killed {
    // rust: return None;
}
    // rust: let near = at[0].powi(2) + (at[1] - 128.0).powi(2) + at[2].powi(2) <= 192.0 * 192.0;
    // rust: if !near {
    // rust: return None;
}
    // rust: Some(
    // rust: self.dragon
    // rust: .as_ref()
    // rust: .map_or(1.0, |d| (d.health / MAX_HEALTH).clamp(0.0, 1.0)),
    // rust: )
}
    /// `BossHealthOverlay.shouldPlayMusic`.
    // rust: pub(super) fn boss_music(&self) -> bool {
    // rust: self.boss_overlay.should_play_music()
}
}
    // rust: pub(super) struct DragonFireball {
    /// Its entity id once a server's players track it (0 until then).
    // rust: pub(super) id: u32,
    // rust: pub(super) position: Vec3,
    // rust: pub(super) previous: Vec3,
    // rust: pub(super) velocity: Vec3,
    // rust: age: i32,
}
    // rust: impl DragonFireball {
    /// One a server sent (`handleAddEntity`).
    // rust: pub(super) fn remote(id: u32, at: Vec3, velocity: Vec3) -> Self {
    // rust: Self {
    // rust: id,
    // rust: position: at,
    // rust: previous: at,
    // rust: velocity,
    // rust: age: 0,
}
}
    /// `AbstractHurtingProjectile.tick` on a server's client: `applyInertia`
    /// first (power 0.1, inertia 0.95 or 0.8 in water), then the move; only
    /// the server decides what it hits.
    // rust: pub(super) fn remote_step(&mut self, water: bool) {
    // rust: self.previous = self.position;
    // rust: self.age += 1;
    // rust: let v = self.velocity;
        // Vec3.normalize: a vector shorter than 1e-5 stays zero.
    // rust: let l = (v.x * v.x + v.y * v.y + v.z * v.z).sqrt();
    // rust: let n = if l < 1.0e-5 {
    // rust: Vec3::new(0.0, 0.0, 0.0)
    // rust: } else {
    // rust: Vec3::new(v.x / l, v.y / l, v.z / l)
}
    // rust: let inertia = f64::from(if water { 0.8f32 } else { 0.95f32 });
    // rust: let v = Vec3::new(
    // rust: (v.x + n.x * 0.1) * inertia,
    // rust: (v.y + n.y * 0.1) * inertia,
    // rust: (v.z + n.z * 0.1) * inertia,
    // rust: );
    // rust: self.velocity = v;
    // rust: self.position = Vec3::new(
    // rust: self.position.x + v.x,
    // rust: self.position.y + v.y,
    // rust: self.position.z + v.z,
    // rust: );
}
}
/// `DragonLandingPhase.doClientTick` and `DragonSittingFlamingPhase.doClientTick`:
/// the dragon-breath particles one tick of `doClientTick` spawns at the head, as
/// (position, velocity) pairs. `look` is `EnderDragon.getHeadLookVector(1)`
/// normalised, `head` the head part's centre (`getY(0.5)`), `motion` the
/// dragon's `getDeltaMovement`, and `random` the stream the jitter comes from.
/// Both phases rotate `look` by a quarter turn and throw the result away, so
/// every puff of a fan leaves along the same line; a flaming dragon walks down
/// that line in six steps.
    // rust: fn breath_puffs(
    // rust: phase: &Phase,
    // rust: look: [f64; 3],
    // rust: head: [f64; 3],
    // rust: motion: [f64; 3],
    // rust: random: &mut LegacyRandom,
    // rust: ) -> Vec<([f64; 3], [f64; 3])> {
    // A puff's start: the head's centre jittered by `nextGaussian() / 2`.
    // rust: let jitter = |random: &mut LegacyRandom| {
    // rust: [
    // rust: head[0] + random.next_gaussian() / 2.0,
    // rust: head[1] + random.next_gaussian() / 2.0,
    // rust: head[2] + random.next_gaussian() / 2.0,
    // rust: ]
}
    // rust: match phase {
        // Eight a tick, along `-look * 0.08F` (0.3 for the vertical part) plus
        // the dragon's own motion.
    // rust: Phase::Landing { .. } => (0..8)
    // rust: .map(|_| {
    // rust: (
    // rust: jitter(random),
    // rust: [
    // rust: -look[0] * f64::from(0.08_f32) + motion[0],
    // rust: -look[1] * f64::from(0.3_f32) + motion[1],
    // rust: -look[2] * f64::from(0.08_f32) + motion[2],
    // rust: ],
    // rust: )
    // rust: })
    // rust: .collect(),
        // Every second tick of the first ten: eight starts, each a fan of six
        // puffs down the look line, the vertical part of the speed once.
    // rust: Phase::Flaming { ticks } if ticks % 2 == 0 && *ticks < 10 => {
    // rust: let mut puffs = Vec::with_capacity(48);
    // rust: for _ in 0..8 {
    // rust: let at = jitter(random);
    // rust: for j in 0..6 {
    // rust: let j = f64::from(j);
    // rust: puffs.push((
    // rust: at,
    // rust: [
    // rust: -look[0] * f64::from(0.08_f32) * j,
    // rust: -look[1] * f64::from(0.6_f32),
    // rust: -look[2] * f64::from(0.08_f32) * j,
    // rust: ],
    // rust: ));
}
}
    // rust: puffs
}
    // rust: _ => Vec::new(),
}
}
    // rust: pub(super) struct Breath {
    /// Its entity id once a server's players track it (0 until then).
    // rust: pub(super) id: u32,
    // rust: pub(super) at: [f64; 3],
    // rust: pub(super) radius: f32,
    // rust: pub(super) age: i32,
    // rust: pub(super) duration: i32,
    // rust: pub(super) from_dragon: bool,
    /// Who it hit and until which age (`AreaEffectCloud.victims`).
    // rust: pub(super) victims: Vec<(Victim, i32)>,
    /// A lingering potion's cloud (`ThrownLingeringPotion`): what it applies.
    // rust: pub(super) potion: Option<super::potions::PotionCloud>,
}
    // rust: impl Breath {
    /// `AreaEffectCloud.isWaiting`: before its wait time (20 ticks, 10 for a
    /// lingering potion's).
    // rust: pub(super) fn waiting(&self) -> bool {
    // rust: self.age < self.potion.as_ref().map_or(20, |p| p.settings.wait_time)
}
}
    // rust: impl Game<'_> {
    /// `EnderDragonRenderer` and `EnderDragonModel.setupAnim`.
    // rust: pub(super) fn dragon_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: additive: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let (Some(d), Some(model)) = (self.dragon.as_ref(), self.dragon_model.as_ref()) else {
    // rust: return;
}
    // rust: let a = alpha as f32;
    // rust: let sprite = |n: &str| {
    // rust: self.gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get(n)
    // rust: .map(|r| [r.u0, r.v0, r.u1, r.v1])
}
    // rust: let (Some(skin), Some(eyes)) = (
    // rust: sprite("entity/enderdragon/dragon"),
    // rust: sprite("entity/enderdragon/dragon_eyes"),
    // rust: ) else {
    // rust: return;
}
    // rust: let pos = glam::DVec3::new(
    // rust: d.previous.x + (d.position.x - d.previous.x) * alpha,
    // rust: d.previous.y + (d.position.y - d.previous.y) * alpha,
    // rust: d.previous.z + (d.position.z - d.previous.z) * alpha,
    // rust: );
    // rust: let h = |delay: usize| d.sample_lerp(delay, a);
    // rust: let yr = h(7).1;
    // rust: let rot2 = (h(5).0 - h(10).0) as f32;
    // rust: let mut base = glam::Mat4::from_translation((pos - camera).as_vec3())
    // rust: * glam::Mat4::from_rotation_y((-yr).to_radians())
    // rust: * glam::Mat4::from_rotation_x((rot2 * 10.0).to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.0, 1.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(-1.0, -1.0, 1.0))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.501, 0.0));
    // rust: let rays_base = base * glam::Mat4::from_translation(glam::Vec3::new(0.0, -1.0, -2.0));
        // setupAnim.
    // rust: let flap = (d.old_flap + (d.flap - d.old_flap) * a) * std::f32::consts::TAU;
    // rust: let mut bounce = (flap - 1.0).sin() + 1.0;
    // rust: bounce = (bounce * bounce + bounce * 2.0) * 0.05;
    // rust: base *=
    // rust: glam::Mat4::from_translation(glam::Vec3::new(0.0, (bounce - 2.0) * 16.0, -48.0) / 16.0)
    // rust: * glam::Mat4::from_rotation_x((bounce * 2.0).to_radians());
    // rust: let mut poses = horizon_client::mobs::anim::Poses::new(model);
    // rust: poses.get("jaw")[3] = (flap.sin() + 1.0) * 0.2;
    // rust: let sitting = d.phase.sitting();
    // rust: let landing = matches!(d.phase, Phase::Landing { .. } | Phase::Takeoff { .. });
    // rust: let egg_dist = {
    // rust: let p = self.podium_top();
    // rust: ((p.x - d.position.x).powi(2)
    // rust: + (p.y - d.position.y).powi(2)
    // rust: + (p.z - d.position.z).powi(2))
    // rust: .sqrt()
}
    // rust: let head_offset = |part: usize, start: (f64, f32), point: (f64, f32)| -> f32 {
    // rust: if landing {
    // rust: part as f32 / (egg_dist / 4.0).max(1.0) as f32
    // rust: } else if sitting {
    // rust: part as f32
    // rust: } else if part == 6 {
    // rust: 0.0
    // rust: } else {
    // rust: (point.0 - start.0) as f32
}
}
    // rust: let start = h(6);
    // rust: let rot2y = wrap(h(5).1 - h(10).1);
    // rust: let rot = wrap(h(5).1 + rot2y / 2.0);
    // rust: let deg = std::f32::consts::PI / 180.0;
    // rust: let (mut xx, mut yy, mut zz) = (0.0f32, 20.0f32, -12.0f32);
    // rust: for i in 0..5 {
    // rust: let point = h(5 - i);
    // rust: let pose = poses.get(&format!("neck{i}"));
    // rust: let neck_x = (i as f32 * 0.45 + flap).cos() * 0.15;
    // rust: pose[4] = wrap(point.1 - start.1) * deg * 1.5;
    // rust: pose[3] = neck_x + head_offset(i, start, point) * deg * 1.5 * 5.0;
    // rust: pose[5] = -wrap(point.1 - rot) * deg * 1.5;
    // rust: pose[0] = xx;
    // rust: pose[1] = yy;
    // rust: pose[2] = zz;
    // rust: let (xr, yrr) = (pose[3], pose[4]);
    // rust: xx -= yrr.sin() * xr.cos() * 10.0;
    // rust: yy += xr.sin() * 10.0;
    // rust: zz -= yrr.cos() * xr.cos() * 10.0;
}
    // rust: let current = h(0);
    // rust: let head = poses.get("head");
    // rust: head[0] = xx;
    // rust: head[1] = yy;
    // rust: head[2] = zz;
    // rust: head[4] = wrap(current.1 - start.1) * deg;
    // rust: head[3] = wrap(head_offset(6, start, current)) * deg * 1.5 * 5.0;
    // rust: head[5] = -wrap(current.1 - rot) * deg;
    // rust: poses.get("body")[5] = -rot2y * 1.5 * deg;
    // rust: let lw = [0.125 - flap.cos() * 0.2, -0.25, -(flap.sin() + 0.125) * 0.8];
    // rust: let lt = ((flap + 2.0).sin() + 0.5) * 0.75;
    // rust: {
    // rust: let p = poses.get("left_wing");
    // rust: (p[3], p[4], p[5]) = (lw[0], lw[1], lw[2]);
}
    // rust: poses.get("left_wing_tip")[5] = lt;
    // rust: {
    // rust: let p = poses.get("right_wing");
    // rust: (p[3], p[4], p[5]) = (lw[0], -lw[1], -lw[2]);
}
    // rust: poses.get("right_wing_tip")[5] = -lt;
    // rust: for side in ["left", "right"] {
    // rust: poses.get(&format!("{side}_hind_leg"))[3] = 1.0 + bounce * 0.1;
    // rust: poses.get(&format!("{side}_hind_leg_tip"))[3] = 0.5 + bounce * 0.1;
    // rust: poses.get(&format!("{side}_hind_foot"))[3] = 0.75 + bounce * 0.1;
    // rust: poses.get(&format!("{side}_front_leg"))[3] = 1.3 + bounce * 0.1;
    // rust: poses.get(&format!("{side}_front_leg_tip"))[3] = -0.5 - bounce * 0.1;
    // rust: poses.get(&format!("{side}_front_foot"))[3] = 0.75 + bounce * 0.1;
}
    // rust: let mut tail_x = 0.0f32;
    // rust: let (mut xx, mut yy, mut zz) = (0.0f32, 10.0f32, 60.0f32);
    // rust: let start = h(11);
    // rust: for i in 0..12 {
    // rust: let point = h(12 + i);
    // rust: tail_x += (i as f32 * 0.45 + flap).sin() * 0.05;
    // rust: let p = poses.get(&format!("tail{i}"));
    // rust: p[4] = (wrap(point.1 - start.1) * 1.5 + 180.0) * deg;
    // rust: p[3] = tail_x + (point.0 - start.0) as f32 * deg * 1.5 * 5.0;
    // rust: p[5] = wrap(point.1 - rot) * deg * 1.5;
    // rust: p[0] = xx;
    // rust: p[1] = yy;
    // rust: p[2] = zz;
    // rust: let (xr, yrr) = (p[3], p[4]);
    // rust: yy += xr.sin() * 10.0;
    // rust: zz -= yrr.cos() * xr.cos() * 10.0;
    // rust: xx -= yrr.sin() * xr.cos() * 10.0;
}
    // rust: let l = self.world.light(
    // rust: d.position.x.floor() as i32,
    // rust: d.position.y.floor() as i32,
    // rust: d.position.z.floor() as i32,
    // rust: );
    // rust: let light = (u32::from(l >> 4) * 16) | ((u32::from(l & 15) * 16) << 8);
    // rust: let death = if d.death_time > 0 {
    // rust: d.death_time as f32 + a
    // rust: } else {
    // rust: 0.0
}
        // Dying: DYING_RENDER_TYPE, `entityCutoutDissolve` of the skin with dragon_exploding as
        // the mask, white at `ARGB.white(1 - deathTime / 200)` and no overlay.
    // rust: let mask = sprite("entity/enderdragon/dragon_exploding").filter(|_| death > 0.0);
    // rust: let (color, overlay) = if mask.is_some() {
    // rust: (dissolve_color(death), horizon_client::gfx::DISSOLVE_OVERLAY)
    // rust: } else {
    // rust: (0xFFFF_FFFF, u32::from(d.hurt_time > 0))
}
    // rust: let first = out.len();
    // rust: horizon_client::mobs::render::draw(model, base, &poses, skin, color, light, overlay, out);
    // rust: if let Some(mask) = mask {
    // rust: dissolve_mask(&mut out[first..], skin, mask);
}
        // The skin's OptiFine emissive overlay, full bright.
    // rust: let glow = self
    // rust: .res
    // rust: .mob_data()
    // rust: .emissive
    // rust: .read()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner)
    // rust: .overlay("entity/enderdragon/dragon")
    // rust: .and_then(sprite);
    // rust: if let Some(glow) = glow.filter(|_| mask.is_none()) {
    // rust: let full = horizon_client::mobs::render::FULL_BRIGHT;
    // rust: horizon_client::mobs::render::draw(model, base, &poses, glow, color, full, 0, out);
}
        // RenderTypes.eyes: the glowing eyes, added on top.
    // rust: let mut eye_quads = Vec::new();
    // rust: horizon_client::mobs::render::draw(
    // rust: model,
    // rust: base,
    // rust: &poses,
    // rust: eyes,
    // rust: 0xFFFF_FFFF,
    // rust: 240 | 240 << 8,
    // rust: 0,
    // rust: &mut eye_quads,
    // rust: );
        // `RenderTypes.eyes` has an `OitPipelineSet`: improved transparency
        // moves the tagged quads into its stages (the HDR tier is the eyes'
        // shine, `mobs::render::EYES_TIER`).
    // rust: for v in &mut eye_quads {
    // rust: v.layer = 2
    // rust: | horizon_client::gfx::OIT_ENTITY
    // rust: | u32::from(horizon_client::mesher::BRIGHT) << 16;
}
    // rust: additive.extend(eye_quads);
    // rust: if death > 0.0 {
    // rust: let rays = additive.len();
    // rust: self.dragon_rays(rays_base, death / 200.0, additive);
    // rust: for v in &mut additive[rays..] {
    // rust: v.layer |= u32::from(horizon_client::mesher::VERY_BRIGHT) << 16;
}
}
        // The healing beam to the nearest crystal.
    // rust: if let Some(c) = d.nearest_crystal.and_then(|i| self.crystals.get(i)) {
    // rust: let bob = f64::from(horizon_client::end_crystal::y(c.time as f32 + a));
    // rust: let to = glam::DVec3::new(c.position.x, c.position.y + bob, c.position.z);
    // rust: self.crystal_beam(pos, to - pos, self.visual_ticks() as f32 + a, camera, out);
}
}
    /// `EnderDragonRenderer.submitRays`: untextured, additive death rays.
pub fn dragon_rays(self: *Self, base: glam::Mat4, t: f32, out: *mut std.ArrayList(Vertex)) void {
}
    // rust: dragon_rays(base, t, self.gui.atlas.font.white(), out);
}
    /// `submitCrystalBeams`: an eight-sided tube from `from` (+2 up) along
    /// `delta`, the beam texture scrolling along it.
    // rust: pub(super) fn crystal_beam(
    // rust: &self,
    // rust: from: glam::DVec3,
    // rust: delta: glam::DVec3,
    // rust: time: f32,
    // rust: camera: glam::DVec3,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(s) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/end_crystal/end_crystal_beam")
    // rust: .copied()
    // rust: else {
    // rust: return;
}
    // rust: let q = |v: f32| (v * 65535.0).round().clamp(0.0, 65535.0) as u32;
    // rust: let wrap_light = q(s.v0) | q(s.v1 - s.v0) << 16;
    // rust: let (dx, dy, dz) = (delta.x as f32, delta.y as f32, delta.z as f32);
    // rust: let horizontal = (dx * dx + dz * dz).sqrt();
    // rust: let length = (dx * dx + dy * dy + dz * dz).sqrt();
    // rust: let m = glam::Mat4::from_translation(
    // rust: (from - camera).as_vec3() + glam::Vec3::new(0.0, 2.0, 0.0),
    // rust: ) * glam::Mat4::from_rotation_y(-dz.atan2(dx) - std::f32::consts::FRAC_PI_2)
    // rust: * glam::Mat4::from_rotation_x(-horizontal.atan2(dy) - std::f32::consts::FRAC_PI_2);
    // rust: let (v0, v1) = (-time * 0.01, length / 32.0 - time * 0.01);
    // rust: let (mut last_sin, mut last_cos, mut last_u) = (0.0f32, 0.75f32, 0.0f32);
    // rust: let u = |x: f32| s.u0 + (s.u1 - s.u0) * x;
    // rust: for i in 1..=8 {
    // rust: let a = i as f32 * std::f32::consts::TAU / 8.0;
    // rust: let (sin, cos) = (a.sin() * 0.75, a.cos() * 0.75);
    // rust: let uu = i as f32 / 8.0;
    // rust: for (p, uv, c) in [
    // rust: (
    // rust: glam::Vec3::new(last_sin * 0.2, last_cos * 0.2, 0.0),
    // rust: [u(last_u), v0],
    // rust: 0xFF00_0000,
    // rust: ),
    // rust: (
    // rust: glam::Vec3::new(last_sin, last_cos, length),
    // rust: [u(last_u), v1],
    // rust: 0xFFFF_FFFF,
    // rust: ),
    // rust: (glam::Vec3::new(sin, cos, length), [u(uu), v1], 0xFFFF_FFFF),
    // rust: (
    // rust: glam::Vec3::new(sin * 0.2, cos * 0.2, 0.0),
    // rust: [u(uu), v0],
    // rust: 0xFF00_0000,
    // rust: ),
    // rust: ] {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: m.transform_point3(p).to_array(),
    // rust: uv,
                    // HDR output: the healing beam shines (entity.wgsl fs_hdr_mark).
    // rust: layer: 6 | u32::from(horizon_client::mesher::BRIGHT) << 16,
    // rust: color: c,
    // rust: light: wrap_light,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
    // rust: (last_sin, last_cos, last_u) = (sin, cos, uu);
}
}
    /// Dragon fireballs as the dragon_fireball sprite facing the camera.
    // rust: pub(super) fn dragon_fireball_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let Some(s) = self
    // rust: .gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get("entity/enderdragon/dragon_fireball")
    // rust: .copied()
    // rust: else {
    // rust: return;
}
    // rust: let forward = glam::DVec3::from_array(super::view_vector(self.yaw, self.pitch));
    // rust: let right = forward.cross(glam::DVec3::Y).normalize_or_zero();
    // rust: let up = right.cross(forward).normalize_or_zero();
    // rust: for b in &self.dragon_fireballs {
    // rust: let p = glam::DVec3::new(
    // rust: b.previous.x + (b.position.x - b.previous.x) * alpha,
    // rust: b.previous.y + (b.position.y - b.previous.y) * alpha,
    // rust: b.previous.z + (b.position.z - b.previous.z) * alpha,
    // rust: ) - camera;
            // DragonFireballRenderer: scale 2, full bright.
    // rust: let h = 1.0;
    // rust: for (c, uv) in [
    // rust: (p - right * h - up * h, [s.u0, s.v1]),
    // rust: (p + right * h - up * h, [s.u1, s.v1]),
    // rust: (p + right * h + up * h, [s.u1, s.v0]),
    // rust: (p - right * h + up * h, [s.u0, s.v0]),
    // rust: ] {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: c.as_vec3().to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light: 240 | 240 << 8,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
    // rust: pub(super) fn fight_ready(&mut self) -> bool {
    // rust: self.load_fight();
        // spawnExitPortal runs from scanState and the dragon's death, both
        // only with players in the fight.
    // rust: self.fight.loaded && self.fight.players
}
    // rust: pub(super) fn exit_portal(&self) -> Option<[i32; 3]> {
    // rust: self.fight.exit_portal
}
    // rust: pub(super) fn set_exit_portal(&mut self, origin: [i32; 3]) {
    // rust: if self.fight.exit_portal.is_none() {
    // rust: self.fight.exit_portal = Some(origin);
    // rust: self.fight.dirty = true;
}
}
}
/// `Entity.isSilent` from an entity's saved compound: `Silent`, written only
/// when set.
pub fn saved_silent(raw: ?*Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(raw.and_then(|t| t.get("Silent")), Some(Tag::Byte(b)) if *b != 0)
}
/// Saving and loading the dragon and the crystals as chunk entities.
    // rust: impl Dragon {
    // rust: pub(super) fn to_nbt(&self, uuid: [i32; 4], raw: Option<&Tag>) -> Tag {
    // rust: let mut tag = horizon_client::entity_nbt::vehicle_to_nbt(
    // rust: "minecraft:ender_dragon",
    // rust: self.position,
    // rust: self.velocity,
    // rust: [self.yaw, 0.0],
    // rust: uuid,
    // rust: raw,
    // rust: );
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.insert("Health".into(), Tag::Float(self.health.to_bits()));
    // rust: map.insert("DragonPhase".into(), Tag::Int(self.phase.id()));
    // rust: map.insert("DragonDeathTime".into(), Tag::Int(self.death_time));
            // Mob.addAdditionalSaveData writes NoAI only when set.
    // rust: if self.no_ai {
    // rust: map.insert("NoAI".into(), Tag::Byte(1));
}
    // rust: map.insert(
    // rust: "sitting_damage_received".into(),
    // rust: Tag::Float(self.sitting_damage.to_bits()),
    // rust: );
}
    // rust: tag
}
    // rust: pub(super) fn from_nbt(tag: &Tag, seed: i64) -> Option<Self> {
    // rust: let (position, velocity, yaw) = horizon_client::entity_nbt::boat_from_nbt(tag)?;
    // rust: let mut d = Self::new(position, yaw, seed);
    // rust: d.velocity = velocity;
    // rust: if let Some(Tag::Float(h)) = tag.get("Health") {
    // rust: d.health = f32::from_bits(*h);
}
    // rust: if let Some(Tag::Int(p)) = tag.get("DragonPhase") {
    // rust: d.phase = Phase::from_id(*p);
}
    // rust: if let Some(Tag::Int(t)) = tag.get("DragonDeathTime") {
    // rust: d.death_time = *t;
}
    // rust: d.no_ai = matches!(tag.get("NoAI"), Some(Tag::Byte(b)) if *b != 0);
    // rust: Some(d)
}
}
    // rust: impl Crystal {
    // rust: pub(super) fn to_nbt(&self, uuid: [i32; 4], raw: Option<&Tag>) -> Tag {
    // rust: let mut tag = horizon_client::entity_nbt::vehicle_to_nbt(
    // rust: "minecraft:end_crystal",
    // rust: self.position,
    // rust: Vec3::ZERO,
    // rust: [0.0, 0.0],
    // rust: uuid,
    // rust: raw,
    // rust: );
    // rust: if let Tag::Compound(map) = &mut tag {
    // rust: map.insert("ShowBottom".into(), Tag::Byte(i8::from(self.show_bottom)));
    // rust: if let Some(b) = self.beam {
    // rust: map.insert("beam_target".into(), Tag::IntArray(b.to_vec()));
}
    // rust: map.insert(
    // rust: "Invulnerable".into(),
    // rust: Tag::Byte(i8::from(self.invulnerable)),
    // rust: );
}
    // rust: tag
}
    // rust: pub(super) fn from_nbt(tag: &Tag, time: i32) -> Option<Self> {
    // rust: let (position, _, _) = horizon_client::entity_nbt::boat_from_nbt(tag)?;
    // rust: Some(Self {
    // rust: id: 0,
    // rust: position,
    // rust: show_bottom: !matches!(tag.get("ShowBottom"), Some(Tag::Byte(0))),
    // rust: time,
    // rust: beam: match tag.get("beam_target") {
    // rust: Some(Tag::IntArray(v)) if v.len() == 3 => Some([v[0], v[1], v[2]]),
    // rust: _ => None,
    // rust: },
    // rust: invulnerable: matches!(tag.get("Invulnerable"), Some(Tag::Byte(1))),
    // rust: })
}
}
    // rust: impl Game<'_> {
    /// `ServerExplosion.hurtEntities`: crystals in reach are removed without
    /// another blast; explosions always hurt dragons.
    // rust: pub(super) fn explosion_hits_special(
    // rust: &mut self,
    // rust: center: [f64; 3],
    // rust: radius: f32,
    // rust: blocks: &[[i32; 3]],
    // rust: ) {
    // rust: let diameter = f64::from(radius * 2.0);
    // rust: let in_reach = |p: Vec3| {
    // rust: ((p.x - center[0]).powi(2) + (p.y - center[1]).powi(2) + (p.z - center[2]).powi(2))
    // rust: .sqrt()
    // rust: / diameter
    // rust: <= 1.0
}
    // rust: let crystals: Vec<Vec3> = self
    // rust: .crystals
    // rust: .iter()
    // rust: .filter(|c| !c.invulnerable && in_reach(c.position))
    // rust: .map(|c| c.position)
    // rust: .collect();
        // The blast's source carries the player who set it off, if any.
    // rust: let by = self.fight.blast_by;
    // rust: for at in crystals {
            // Look up the current index after each removal.
    // rust: if let Some(i) = self.crystals.iter().position(|c| c.position == at) {
    // rust: self.destroy_crystal(i, by, CrystalDamage::Explosion);
}
}
    // rust: let Some(d) = self.dragon.as_ref() else {
    // rust: return;
}
    // rust: let hits = d.explosion_hits(center, radius, |b| {
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: self.seen_percent(center, [lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z])
    // rust: });
    // rust: let whole = d.whole_box();
    // rust: let (lo, hi) = (whole.min_position(), whole.max_position());
    // rust: let exposure = self.seen_percent(center, [lo.x, lo.y, lo.z], [hi.x, hi.y, hi.z]);
    // rust: for (part, amount) in hits {
    // rust: self.hurt_dragon(part, amount, true, by, DamageKind::Explosion);
}
    // rust: let Some((id, mut push)) = self
    // rust: .dragon
    // rust: .as_ref()
    // rust: .and_then(|d| Some((d.id, d.explosion_knockback(center, radius, exposure)?)))
    // rust: else {
    // rust: return;
}
    // rust: self.native_explosion_knockback(self.dim.id(), center, blocks, Some(id), &mut push);
    // rust: if let Some(d) = self.dragon.as_mut() {
    // rust: d.velocity = Vec3::new(
    // rust: d.velocity.x + push[0],
    // rust: d.velocity.y + push[1],
    // rust: d.velocity.z + push[2],
    // rust: );
}
}
}
    // rust: impl Game<'_> {
    /// The dragon as guests track it (`EnderDragon.getAddEntityPacket` and
    /// the synched data that differs from the defaults: its health, defined
    /// as 1, and `DATA_PHASE`, defined as hovering). Vanilla pairs it with no
    /// attribute instances.
    // rust: pub(super) fn lan_dragon_state(&self) -> Option<horizon_client::lan::entity::EntityState> {
//         use horizon_protocol::entity_data::{Value, serializer};
    // rust: let d = self.dragon.as_ref().filter(|d| d.id != 0)?;
    // rust: let mut meta = Vec::new();
    // rust: let health = d.health.max(0.0);
    // rust: if health != 1.0 {
    // rust: meta.push((9, serializer::FLOAT, Value::Float(health)));
}
    // rust: let phase = d.phase.id();
    // rust: if phase != 10 {
    // rust: meta.push((16, serializer::INT, Value::Int(phase)));
}
        // Mob.DATA_MOB_FLAGS_ID: NoAI is its first bit.
    // rust: if d.no_ai {
    // rust: meta.push((15, serializer::BYTE, Value::Byte(1)));
}
    // rust: Some(horizon_client::lan::entity::EntityState {
    // rust: id: d.id as i32,
    // rust: uuid: super::lan::entity_uuid(d.id),
    // rust: kind: "minecraft:ender_dragon".to_owned(),
    // rust: position: [d.position.x, d.position.y, d.position.z],
    // rust: yaw: d.yaw,
    // rust: pitch: 0.0,
    // rust: head_yaw: d.yaw,
    // rust: on_ground: false,
    // rust: velocity: [d.velocity.x, d.velocity.y, d.velocity.z],
    // rust: minecart_steps: None,
    // rust: data: 0,
    // rust: meta,
    // rust: defaults: Vec::new(),
    // rust: equipment: Vec::new(),
    // rust: attributes: Vec::new(),
    // rust: precise: false,
    // rust: vertical_collision: false,
    // rust: horizontal_collision: false,
    // rust: needs_sync: false,
    // rust: idle: false,
    // rust: bare: false,
    // rust: leash: None,
    // rust: spectator: false,
    // rust: watching: false,
    // rust: hidden: None,
    // rust: })
}
}
    // rust: impl Game<'_> {
    /// The dragon and fight for `horizon-ctl status`.
    // rust: pub(super) fn dragon_status(&self) -> serde_json::Value {
    // rust: serde_json::json!({
    // rust: "dragon": self.dragon.as_ref().map(|d| serde_json::json!({
    // rust: "id": d.id,
    // rust: "position": [d.position.x, d.position.y, d.position.z],
    // rust: "health": d.health,
    // rust: "phase": d.phase.id(),
    // rust: "death_time": d.death_time,
                // The player it strafes: "host", or the guest's entity id.
    // rust: "strafing": match &d.phase {
    // rust: Phase::Strafe { player: Some(FightWho::Host), .. } => serde_json::json!("host"),
    // rust: Phase::Strafe { player: Some(FightWho::Guest(conn)), .. } => serde_json::json!(
    // rust: self.lan.as_ref().and_then(|h| h.hub.guest(*conn)).map(|g| g.entity_id)
    // rust: ),
    // rust: _ => serde_json::Value::Null,
    // rust: },
    // rust: })),
    // rust: "players": self.fight.players,
    // rust: "crystals": self.crystals.len(),
            // The tracked id (0 until tracked) and position of each crystal.
    // rust: "crystal_list": self.crystals.iter().map(|c| serde_json::json!({
    // rust: "id": c.id,
    // rust: "position": [c.position.x, c.position.y, c.position.z],
    // rust: })).collect::<Vec<_>>(),
    // rust: "alive_crystals": self.fight.alive_crystals,
    // rust: "killed": self.fight.killed,
    // rust: "exit_portal": self.fight.exit_portal,
    // rust: "respawn": self.fight.respawn.map(|(s, t)| format!("{} {t}", s.name())),
    // rust: })
}
}
/// Respawning the dragon with end crystals on the exit portal
/// (`EndCrystalItem.useOn`, `EnderDragonFight.tryRespawn`, `DragonRespawnStage`).
    // rust: impl Game<'_> {
    /// `EndCrystalItem.useOn`: on obsidian or bedrock with room above.
    // rust: pub(super) fn place_end_crystal(
    // rust: &mut self,
    // rust: hit: &super::Hit,
    // rust: stack: &horizon_client::items::ItemStack,
    // rust: ) -> bool {
    // rust: if &*stack.item != "minecraft:end_crystal" {
    // rust: return false;
}
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(hit.pos[0], hit.pos[1], hit.pos[2]))
    // rust: .name
    // rust: .clone();
    // rust: if !matches!(&*name, "minecraft:obsidian" | "minecraft:bedrock") {
    // rust: return false;
}
    // rust: let above = [hit.pos[0], hit.pos[1] + 1, hit.pos[2]];
    // rust: if !self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(above[0], above[1], above[2]))
    // rust: {
    // rust: return false;
}
    // rust: let (x, y, z) = (
    // rust: f64::from(above[0]),
    // rust: f64::from(above[1]),
    // rust: f64::from(above[2]),
    // rust: );
    // rust: let room = Aabb::new(Vec3::new(x, y, z), Vec3::new(x + 1.0, y + 2.0, z + 1.0));
    // rust: if self.entity_in(room) {
    // rust: return false;
}
        // EndCrystal's constructor: `this.random.nextInt(100000)`, the crystal's own random.
    // rust: let time = super::dispenser::entity_random()
    // rust: .next_int_bound(100_000)
    // rust: .unwrap_or(0);
        // EndCrystal's constructor takes an id from the entity counter, so
        // the crystal is an entity a command can name (`@e[type=end_crystal]`).
    // rust: self.next_entity += 1;
    // rust: self.crystals.push(Crystal {
    // rust: id: self.next_entity,
    // rust: position: Vec3::new(x + 0.5, y, z + 0.5),
    // rust: show_bottom: false,
    // rust: time,
    // rust: beam: None,
    // rust: invulnerable: false,
    // rust: });
        // EndCrystalItem.useOn: ENTITY_PLACE at the block above, by the player.
    // rust: self.post_block_game_event("minecraft:entity_place", above, self.sculk_actor(), None);
    // rust: self.world.modified.insert((above[0] >> 4, above[2] >> 4));
    // rust: if self.dim == Dim::End {
    // rust: self.try_respawn();
}
    // rust: if !self.creative {
    // rust: self.consume_held();
}
        // ItemStack.useOn counts the use.
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: true
}
    /// `EndCrystal.kill` (`/kill`): the crystal is removed, without a blast
    /// (`Entity.kill` does not hurt it).
    // rust: pub(super) fn kill_crystal(&mut self, id: u32) {
    // rust: if let Some(i) = self.crystals.iter().position(|c| c.id == id) {
    // rust: self.destroy_crystal(i, None, CrystalDamage::Explosion);
}
}
    /// `EnderDragon.kill` (`/kill`): `Entity.kill` removes the entity, it
    /// does not hurt it (the dragon flies its death flight when its health
    /// runs out). The fight's dragon ends the fight there and then
    /// (`dragonFight.setDragonKilled`): the exit portal, a gateway and the
    /// first dragon's egg, and no new dragon. No experience: `tickDeath`
    /// drops it, and a killed dragon never gets there.
    // rust: pub(super) fn kill_dragon(&mut self, id: u32) {
    // rust: if self.dragon.as_ref().is_some_and(|d| d.id == id) {
            // Only the fight's own dragon (`dragonFight`) ends it.
    // rust: let fight = self.is_fight_dragon();
    // rust: if let Some(d) = self.dragon.take() {
                // remove, then gameEvent(ENTITY_DIE), before the fight hears of it.
    // rust: self.dragon_died_event(d.id, d.position, d.alive());
}
    // rust: if fight {
    // rust: self.dragon_killed();
}
}
}
    /// Any entity touching `room` (`Level.getEntities(null, box)`).
pub fn entity_in(self: *Self, room: Aabb) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let touches = |lo: Vec3, hi: Vec3| {
    // rust: let (a, b) = (room.min_position(), room.max_position());
    // rust: lo.x < b.x && hi.x > a.x && lo.y < b.y && hi.y > a.y && lo.z < b.z && hi.z > a.z
}
        // Level.getEntities: the host's player and every guest in the level.
    // rust: let player = self
    // rust: .fight_players()
    // rust: .iter()
    // rust: .any(|p| !p.spectator && touches(p.bounds.min_position(), p.bounds.max_position()));
    // rust: player
    // rust: || self.crystals.iter().any(|c| {
    // rust: touches(
    // rust: Vec3::new(c.position.x - 1.0, c.position.y, c.position.z - 1.0),
    // rust: Vec3::new(c.position.x + 1.0, c.position.y + 2.0, c.position.z + 1.0),
    // rust: )
    // rust: })
    // rust: || self.mobs.iter().any(|m| {
    // rust: let w = f64::from(m.width()) / 2.0;
    // rust: let h = f64::from(m.height());
    // rust: touches(
    // rust: Vec3::new(m.position.x - w, m.position.y, m.position.z - w),
    // rust: Vec3::new(m.position.x + w, m.position.y + h, m.position.z + w),
    // rust: )
    // rust: })
}
    /// `EnderDragonFight.tryRespawn`: a crystal on each side of the portal.
pub fn try_respawn(self: *Self) void {
}
    // rust: self.load_fight();
    // rust: if !self.fight.killed || self.fight.respawn.is_some() {
    // rust: return;
}
    // rust: let origin = match self.fight.exit_portal {
    // rust: Some(o) => o,
    // rust: None => {
    // rust: let _ = self.activate_exit_portal();
    // rust: match self.fight.exit_portal {
    // rust: Some(o) => o,
    // rust: None => return,
}
}
}
    // rust: let mut found = Vec::new();
    // rust: for d in [[0, -1], [0, 1], [-1, 0], [1, 0]] {
            // new AABB(center.relative(direction, 3)): the block cube.
    // rust: let cell = [origin[0] + d[0] * 3, origin[1] + 1, origin[2] + d[1] * 3];
    // rust: let lo = Vec3::new(f64::from(cell[0]), f64::from(cell[1]), f64::from(cell[2]));
    // rust: let hits: Vec<Vec3> = self
    // rust: .crystals
    // rust: .iter()
    // rust: .filter(|c| {
    // rust: let p = c.position;
    // rust: p.x + 1.0 > lo.x
    // rust: && p.x - 1.0 < lo.x + 1.0
    // rust: && p.y + 2.0 > lo.y
    // rust: && p.y < lo.y + 1.0
    // rust: && p.z + 1.0 > lo.z
    // rust: && p.z - 1.0 < lo.z + 1.0
    // rust: })
    // rust: .map(|c| c.position)
    // rust: .collect();
    // rust: if hits.is_empty() {
    // rust: return;
}
    // rust: found.extend(hits);
}
        // respawnDragon: the podium goes back to end stone, then inactive.
    // rust: for y in origin[1] - 1..=origin[1] + 3 {
    // rust: for z in origin[2] - 3..=origin[2] + 3 {
    // rust: for x in origin[0] - 3..=origin[0] + 3 {
    // rust: let name = self.block_name_at([x, y, z]);
    // rust: if matches!(&*name, "minecraft:bedrock" | "minecraft:end_portal") {
    // rust: let _ = self.set_state_named([x, y, z], "minecraft:end_stone", &[]);
}
}
}
}
    // rust: let _ = self.place_podium(origin, false);
    // rust: self.fight.respawn = Some((Respawn::Start, 0));
    // rust: self.fight.respawn_crystals = found;
    // rust: self.fight.dirty = true;
}
pub fn block_name_at(self: *Self, p: [i32; 3]) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.res
    // rust: .facts()
    // rust: .get(self.world.block(p[0], p[1], p[2]))
    // rust: .name
    // rust: .clone()
}
pub fn respawn_beams(self: *Self, target: ?[i32; 3]) void {
}
    // rust: let list = self.fight.respawn_crystals.clone();
    // rust: for c in &mut self.crystals {
    // rust: if list.iter().any(|p| p.distance_squared(c.position) < 0.01) {
    // rust: c.beam = target;
}
}
}
    /// `LevelEvent 3001`: the dragon's growl over the island.
pub fn respawn_growl(self: *Self) void {
}
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.3;
    // rust: self.audio.play(
    // rust: "minecraft:entity.ender_dragon.growl",
    // rust: Some([0.5, 128.5, 0.5]),
    // rust: 64.0,
    // rust: pitch,
    // rust: );
}
pub fn set_respawn(self: *Self, stage: ?Respawn) void {
}
    // rust: self.fight.respawn = stage.map(|s| (s, 0));
    // rust: self.fight.dirty = true;
}
    /// `EnderDragonFight.tick` with a respawn in progress.
pub fn tick_respawn(self: *Self) void {
}
    // rust: let Some((stage, time)) = self.fight.respawn else {
    // rust: return;
}
    // rust: let alive = self.fight.respawn_crystals.iter().any(|p| {
    // rust: self.crystals
    // rust: .iter()
    // rust: .any(|c| p.distance_squared(c.position) < 0.01)
    // rust: });
    // rust: if !alive {
    // rust: self.abort_respawn();
    // rust: return;
}
    // rust: if let Some(r) = self.fight.respawn.as_mut() {
    // rust: r.1 += 1;
}
pub const CENTER: [i32; 3] = [0, 128, 0];
    // rust: match stage {
    // rust: Respawn::Start => {
    // rust: self.respawn_beams(Some(CENTER));
    // rust: self.set_respawn(Some(Respawn::Preparing));
}
    // rust: Respawn::Preparing => {
    // rust: if time < 100 {
    // rust: if matches!(time, 0 | 50..=52) || time >= 95 {
    // rust: self.respawn_growl();
}
    // rust: } else {
    // rust: self.set_respawn(Some(Respawn::Pillars));
}
}
    // rust: Respawn::Pillars => {
    // rust: let (start, end) = (time % 40 == 0, time % 40 == 39);
    // rust: if !(start || end) {
    // rust: return;
}
    // rust: let spikes = horizon_world::worldgen::end_spike::spikes_for_seed(self.level.seed);
    // rust: let index = (time / 40) as usize;
    // rust: if let Some(spike) = spikes.get(index) {
    // rust: if start {
    // rust: self.respawn_beams(Some([
    // rust: spike.center_x,
    // rust: spike.height + 1,
    // rust: spike.center_z,
    // rust: ]));
    // rust: } else {
    // rust: self.rebuild_spike(spike);
}
    // rust: } else if start {
    // rust: self.set_respawn(Some(Respawn::Summoning));
}
}
    // rust: Respawn::Summoning => {
    // rust: if time >= 100 {
    // rust: self.finish_respawn();
    // rust: } else if time >= 80 || (1..5).contains(&time) {
    // rust: self.respawn_growl();
    // rust: } else if time == 0 {
    // rust: self.respawn_beams(Some(CENTER));
}
}
}
}
    /// SUMMONING_PILLARS at the end of a beam: the spike is cleared, blown up
    /// and grown again with a guarded crystal.
pub fn rebuild_spike(self: *Self, spike: *horizon_world::worldgen::end_spike::EndSpike) void {
}
    // rust: let (cx, cz, h) = (spike.center_x, spike.center_z, spike.height);
    // rust: let air = self.pack.assets.registry.default_state("minecraft:air");
    // rust: let Some(air) = air else {
    // rust: return;
}
    // rust: for y in h - 10..=h + 10 {
    // rust: for z in cz - 10..=cz + 10 {
    // rust: for x in cx - 10..=cx + 10 {
    // rust: if !self.res.facts().is_air(self.world.block(x, y, z)) {
    // rust: let _ = self.level_set([x, y, z], air);
}
}
}
}
        // DragonRespawnStage.SUMMONING_PILLARS: ExplosionInteraction.BLOCK.
    // rust: let interaction = self.destroy_type("block_explosion_drop_decay");
    // rust: let _ = self.server_explode(
    // rust: [f64::from(cx) + 0.5, f64::from(h), f64::from(cz) + 0.5],
    // rust: 5.0,
    // rust: interaction,
    // rust: false,
    // rust: );
        // EndSpikeFeature.placeSpike with crystal_invulnerable and the beam.
    // rust: let r = spike.radius;
    // rust: for z in cz - r..=cz + r {
    // rust: for y in 0..=h + 10 {
    // rust: for x in cx - r..=cx + r {
    // rust: let (dx, dz) = (f64::from(x - cx), f64::from(z - cz));
    // rust: if dx * dx + dz * dz <= f64::from(r * r + 1) && y < h {
    // rust: if &*self.block_name_at([x, y, z]) != "minecraft:obsidian" {
    // rust: let _ = self.set_state_named([x, y, z], "minecraft:obsidian", &[]);
}
    // rust: } else if y > 65 && !self.res.facts().is_air(self.world.block(x, y, z)) {
    // rust: let _ = self.level_set([x, y, z], air);
}
}
}
}
    // rust: if spike.guarded {
    // rust: for dx in -2i32..=2 {
    // rust: for dz in -2i32..=2 {
    // rust: for dy in 0..=3 {
    // rust: let top = dy == 3;
    // rust: if !(dx.abs() == 2 || dz.abs() == 2 || top) {
    // rust: continue;
}
    // rust: let x_edge = dx.abs() == 2 || top;
    // rust: let z_edge = dz.abs() == 2 || top;
    // rust: self.set_bars(
    // rust: [cx + dx, h + dy, cz + dz],
    // rust: [
    // rust: x_edge && dz != -2,
    // rust: x_edge && dz != 2,
    // rust: z_edge && dx != -2,
    // rust: z_edge && dx != 2,
    // rust: ],
    // rust: );
}
}
}
}
    // rust: let at = Vec3::new(f64::from(cx) + 0.5, f64::from(h + 1), f64::from(cz) + 0.5);
    // rust: self.crystals
    // rust: .retain(|c| c.position.distance_squared(at) > 0.01);
    // rust: let time = self.world.random.next_int_bound(100_000).unwrap_or(0);
    // rust: self.crystals.push(Crystal {
    // rust: id: 0,
    // rust: position: at,
    // rust: show_bottom: true,
    // rust: time,
    // rust: beam: Some([0, 128, 0]),
    // rust: invulnerable: true,
    // rust: });
    // rust: let _ = self.set_state_named([cx, h, cz], "minecraft:bedrock", &[]);
    // rust: let _ = self.set_state_named([cx, h + 1, cz], "minecraft:fire", &[]);
    // rust: self.world.modified.insert((cx >> 4, cz >> 4));
}
    /// Iron bars connected north, south, west and east.
pub fn set_bars(self: *Self, pos: [i32; 3], sides: [bool; 4]) void {
}
    // rust: let registry = self.pack.assets.registry;
    // rust: let Some(mut state) = registry
    // rust: .default_state("minecraft:iron_bars")
    // rust: .and_then(|d| registry.state(d).cloned())
    // rust: else {
    // rust: return;
}
    // rust: for (name, on) in ["north", "south", "west", "east"].into_iter().zip(sides) {
    // rust: state
    // rust: .properties
    // rust: .insert(name.into(), if on { "true" } else { "false" }.into());
}
    // rust: if let Ok(id) = registry.resolve(&state) {
    // rust: let _ = self.level_set(pos, id);
}
}
    /// `resetSpikeCrystals`: spike crystals lose their beams and protection.
pub fn reset_spike_crystals(self: *Self) void {
}
    // rust: let spikes = horizon_world::worldgen::end_spike::spikes_for_seed(self.level.seed);
    // rust: for c in &mut self.crystals {
    // rust: let on_spike = spikes.iter().any(|s| {
    // rust: (c.position.x - f64::from(s.center_x) - 0.5).abs() <= f64::from(s.radius)
    // rust: && (c.position.z - f64::from(s.center_z) - 0.5).abs() <= f64::from(s.radius)
    // rust: && c.position.y >= f64::from(s.height)
    // rust: });
    // rust: if on_spike {
    // rust: c.invulnerable = false;
    // rust: c.beam = None;
}
}
}
    /// `EnderDragonFight.createNewDragon`: over the podium, holding pattern, a random yaw.
    /// It becomes the fight's dragon (`dragonUUID = dragon.getUUID()`).
pub fn create_new_dragon(self: *Self) void {
}
    // rust: let yaw = self.world.random.next_float() * 360.0;
    // rust: let seed = self.world.random.next_long();
    // rust: let mut d = Dragon::new(Vec3::new(0.0, 128.0, 0.0), yaw, seed);
        // EnderDragon's constructor takes its id and its parts' from the
        // entity counter.
    // rust: d.id = self.next_entity + 1;
    // rust: self.next_entity += 9;
    // rust: let id = d.id;
    // rust: self.dragon = Some(d);
    // rust: self.fight.dragon_uuid = Some(self.uuid_for(id));
    // rust: self.fight.dirty = true;
}
    /// `EnderDragonFight.findOrCreateDragon`: the End's dragon becomes the
    /// fight's, or a new one is made.
pub fn find_or_create_dragon(self: *Self) void {
}
    // rust: match self.dragon.as_ref().map(|d| (d.id, d.alive())) {
    // rust: None => self.create_new_dragon(),
    // rust: Some((id, true)) => {
    // rust: self.fight.dragon_uuid = Some(self.uuid_for(id));
    // rust: self.fight.dirty = true;
}
            // `ServerLevel.getDragons` takes only living dragons, so vanilla
            // makes a new one beside a dying one; with one dragon to a level,
            // the new one comes once the dying one is gone.
    // rust: Some((_, false)) => {}
}
}
    /// `EnderDragonFight.scanState`, for a world from before the fight was
    /// saved: an active exit portal means the dragon was killed before. A
    /// living dragon there is the fight's, unless there is no active portal:
    /// then it is removed for a new one.
pub fn scan_state(self: *Self) void {
}
    // rust: let active = self.end_portal_active();
    // rust: self.fight.previously_killed = active;
    // rust: match self.dragon.as_ref().filter(|d| d.alive()).map(|d| d.id) {
    // rust: None => self.fight.killed = true,
    // rust: Some(id) => {
    // rust: self.fight.dragon_uuid = Some(self.uuid_for(id));
    // rust: self.fight.killed = false;
    // rust: if !active {
    // rust: self.dragon = None;
    // rust: self.fight.dragon_uuid = None;
}
}
}
    // rust: if !self.fight.previously_killed && self.fight.killed {
    // rust: self.fight.killed = false;
}
}
    /// The dragon is the End fight's own (`EnderDragon.dragonFight`, set
    /// only for the dragon whose UUID is the fight's `dragonUUID`).
pub fn is_fight_dragon(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.dim != Dim::End {
    // rust: return false;
}
    // rust: match (self.dragon.as_ref().map(|d| d.id), self.fight.dragon_uuid) {
    // rust: (Some(id), Some(uuid)) if id != 0 => self.uuid_for(id) == uuid,
    // rust: _ => false,
}
}
    /// The END stage: the portal crystals blow up (no block damage) and a
    /// new dragon takes over.
pub fn finish_respawn(self: *Self) void {
}
        // Portal crystals are not on spikes; clear their revival beams before
        // the spike reset and before they are removed (vanilla resetEndCrystals).
    // rust: self.respawn_beams(None);
    // rust: self.reset_spike_crystals();
    // rust: self.fight.respawn = None;
    // rust: let list = std::mem::take(&mut self.fight.respawn_crystals);
    // rust: for p in list {
    // rust: if let Some(i) = self
    // rust: .crystals
    // rust: .iter()
    // rust: .position(|c| c.position.distance_squared(p) < 0.01)
    // rust: {
    // rust: let c = self.crystals.remove(i);
    // rust: self.world.modified.insert((
    // rust: c.position.x.floor() as i32 >> 4,
    // rust: c.position.z.floor() as i32 >> 4,
    // rust: ));
    // rust: let _ = self.server_explode(
    // rust: [c.position.x, c.position.y, c.position.z],
    // rust: 6.0,
    // rust: super::explosion::BlockInteraction::Keep,
    // rust: false,
    // rust: );
}
}
    // rust: self.fight.killed = false;
        // setRespawnStage(END): the new dragon is summoned for every player
        // of the fight (the boss bar's players: alive within 192 blocks).
    // rust: self.create_new_dragon();
    // rust: let view = self
    // rust: .dragon
    // rust: .as_ref()
    // rust: .map(|d| horizon_client::advancements::EntityView {
    // rust: kind: "minecraft:ender_dragon".to_owned(),
    // rust: position: [d.position.x, d.position.y, d.position.z],
    // rust: ..Default::default()
    // rust: });
    // rust: if let Some(view) = view {
    // rust: self.for_each_player(|g| {
    // rust: let near = g.player.as_ref().is_some_and(|p| {
    // rust: !p.health.dead_or_dying()
    // rust: && p.position.x.powi(2)
    // rust: + (p.position.y - 128.0).powi(2)
    // rust: + p.position.z.powi(2)
    // rust: <= 192.0 * 192.0
    // rust: });
    // rust: if near {
    // rust: g.trigger_entity("minecraft:summoned_entity", "entity", &view);
}
    // rust: });
}
    // rust: self.fight.dirty = true;
    // rust: self.count_crystals();
}
    /// `abortRespawnSequence`.
pub fn abort_respawn(self: *Self) void {
}
    // rust: self.fight.respawn = None;
    // rust: self.respawn_beams(None);
    // rust: self.fight.respawn_crystals.clear();
    // rust: self.reset_spike_crystals();
    // rust: let _ = self.activate_exit_portal();
    // rust: self.fight.dirty = true;
}
    /// `EnderDragon.checkCrystals`' search: the nearest crystal whose box
    /// meets the dragon's box grown by 32.
pub fn nearest_crystal_to(self: *Self, p: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
        // The dragon's 16 by 8 box.
    // rust: let reach = Aabb::new(
    // rust: Vec3::new(p.x - 8.0, p.y, p.z - 8.0),
    // rust: Vec3::new(p.x + 8.0, p.y + 8.0, p.z + 8.0),
    // rust: )
    // rust: .inflate(Vec3::new(32.0, 32.0, 32.0));
    // rust: self.crystals
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, c)| {
                // An end crystal's 2 by 2 box.
    // rust: reach.intersects(Aabb::new(
    // rust: Vec3::new(c.position.x - 1.0, c.position.y, c.position.z - 1.0),
    // rust: Vec3::new(c.position.x + 1.0, c.position.y + 2.0, c.position.z + 1.0),
    // rust: ))
    // rust: })
    // rust: .min_by(|a, b| {
    // rust: let da = (a.1.position.x - p.x).powi(2)
    // rust: + (a.1.position.y - p.y).powi(2)
    // rust: + (a.1.position.z - p.z).powi(2);
    // rust: let db = (b.1.position.x - p.x).powi(2)
    // rust: + (b.1.position.y - p.y).powi(2)
    // rust: + (b.1.position.z - p.z).powi(2);
    // rust: da.total_cmp(&db)
    // rust: })
    // rust: .map(|(i, _)| i)
}
}

/// The dragon on a server's client (`ClientPacketListener.handleAddEntity`
/// and the client side of `EnderDragon.aiStep`): the server flies it and
/// sends its moves, health and phase; the client flaps its wings, keeps
/// its flight history and places its parts, so it can be drawn and hit.
    // rust: impl Game<'_> {
    /// `Mob.playAmbientSound` when EntityType.spawn places a dragon.
    // rust: pub(super) fn dragon_spawn_ambient(&mut self, id: u32) -> bool {
    // rust: let Some(d) = self.dragon.as_mut().filter(|d| d.id == id) else {
    // rust: return false;
}
    // rust: let at = [d.position.x, d.position.y, d.position.z];
    // rust: let pitch = (d.random.next_float() - d.random.next_float()) * 0.2 + 1.0;
    // rust: self.audio.play(
    // rust: "minecraft:entity.ender_dragon.ambient",
    // rust: Some(at),
    // rust: 5.0,
    // rust: pitch,
    // rust: );
    // rust: true
}

    /// `EntityType.create` for an Ender Dragon from a spawn egg, by hand or from a dispenser
    /// (`SpawnEggItem.spawnMob`, `SpawnEggItemBehavior`). Unlike the End fight's dragon, this
    /// one is not the fight's (`EnderDragon.aiStep` adopts it only when its UUID is the fight's),
    /// so it can be spawned in any dimension. Horizon keeps one dragon per level, as `/summon`
    /// and loading do: with one already there, nothing spawns and the egg stays.
    // rust: pub(super) fn spawn_dragon_spawned(&mut self, at: [f64; 3]) -> Option<u32> {
    // rust: if self.dragon.is_some() {
    // rust: return None;
}
    // rust: let position = Vec3::new(at[0], at[1], at[2]);
        // EntityType.create: `snapTo(.., Mth.wrapDegrees(level.getRandom().nextFloat() * 360))`.
    // rust: let yaw = horizon_client::camera::wrap_degrees(self.world.random.next_float() * 360.0);
        // Mob.finalizeSpawn (EnderDragon keeps it): the follow range's
        // `random.triangle(0, 0.11485)`, then `setLeftHanded(nextFloat() < 0.05)`, from the
        // level's random. Neither changes how the dragon flies.
    // rust: let _ = self.world.random.triangle(0.0, 0.114_850_000_000_000_01);
    // rust: let _ = self.world.random.next_float();
        // The dragon's own random (`Entity.random`), not the level's.
    // rust: let seed = super::dispenser::entity_random().next_long();
    // rust: let mut dragon = Dragon::new(position, yaw, seed);
    // rust: dragon.id = self.next_entity + 1;
    // rust: self.next_entity += 9;
    // rust: let id = dragon.id;
    // rust: self.dragon = Some(dragon);
    // rust: self.place_dragon_parts();
    // rust: Some(id)
}

    /// `handleAddEntity` for `minecraft:ender_dragon`. Its constructor
    /// sets the full health and the hovering phase until the server's
    /// synched data says otherwise.
    // rust: pub(super) fn spawn_remote_dragon(&mut self, id: i32, position: [f64; 3], yaw: f32) {
    // rust: let at = Vec3::new(position[0], position[1], position[2]);
    // rust: let mut d = Dragon::new(at, yaw, i64::from(id));
    // rust: d.id = id as u32;
    // rust: d.phase = Phase::from_id(10);
    // rust: self.dragon = Some(d);
    // rust: self.place_dragon_parts();
    // rust: if let Some(d) = self.dragon.as_mut() {
    // rust: for part in &mut d.parts {
    // rust: part.1 = part.0;
}
}
}
    /// The remote dragon, if `id` is it or one of its parts.
pub fn remote_dragon_mut(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(uid) = u32::try_from(id) else {
    // rust: return None;
}
    // rust: self.dragon
    // rust: .as_mut()
    // rust: .filter(|d| d.id == uid || (d.id != 0 && (d.id + 1..=d.id + 8).contains(&uid)))
}
    /// `handleSetEntityData`: LivingEntity.DATA_HEALTH_ID and
    /// EnderDragon.DATA_PHASE (`onSyncedDataUpdated` sets the phase).
    // rust: pub(super) fn remote_dragon_data(&mut self, id: i32, values: &[(u8, i32, Value)]) {
    // rust: let Some(d) = self.remote_dragon_mut(id) else {
    // rust: return;
}
    // rust: for (index, _, value) in values {
    // rust: match (index, value) {
    // rust: (9, Value::Float(health)) => d.health = *health,
    // rust: (16, Value::Int(phase)) => d.set_phase(Phase::from_id(*phase)),
                // Mob.DATA_MOB_FLAGS_ID: isNoAi.
    // rust: (15, Value::Byte(flags)) => d.no_ai = flags & 1 != 0,
    // rust: _ => {}
}
}
}
    /// `handleSetEntityMotion`: the velocity its wings flap by.
    // rust: pub(super) fn remote_dragon_motion(&mut self, id: i32, velocity: [f64; 3]) {
    // rust: if let Some(d) = self.remote_dragon_mut(id) {
    // rust: d.velocity = Vec3::new(velocity[0], velocity[1], velocity[2]);
}
}
    /// `handleHurtAnimation` and `handleDamageEvent`: the red flash.
    // rust: pub(super) fn remote_dragon_hurt(&mut self, id: i32) {
    // rust: if let Some(d) = self.remote_dragon_mut(id) {
            // `LivingEntity.handleDamageEvent`: the red flash. Its sound is the
            // server's (`playHurtSound`); a client plays one only for its own player.
    // rust: d.hurt_time = 10;
}
}
    /// `handleRemoveEntities`, or a crystal removed: the healing beam
    /// keeps pointing at the same crystal.
    // rust: pub(super) fn remove_remote_dragon(&mut self, id: i32) {
    // rust: if self.dragon.as_ref().is_some_and(|d| d.id as i32 == id) {
    // rust: self.dragon = None;
    // rust: return;
}
    // rust: let Some(index) = self.crystals.iter().position(|c| c.id as i32 == id) else {
    // rust: return;
}
    // rust: if let Some(d) = self.dragon.as_mut() {
    // rust: match d.nearest_crystal {
    // rust: Some(n) if n == index => d.nearest_crystal = None,
    // rust: Some(n) if n > index => d.nearest_crystal = Some(n - 1),
    // rust: _ => {}
}
}
}
    /// One client tick of the dragon. `lerp`: the step toward its last
    /// sent position and yaw (LivingEntity's interpolation), and the
    /// steps left including this one.
    // rust: pub(super) fn tick_remote_dragon(&mut self, lerp: Option<([f64; 3], Option<f32>, u32)>) {
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return;
}
    // rust: d.previous = d.position;
    // rust: d.previous_yaw = d.yaw;
    // rust: d.old_flap = d.flap;
    // rust: d.ticks += 1;
    // rust: d.hurt_time = (d.hurt_time - 1).max(0);
    // rust: for part in &mut d.parts {
    // rust: part.1 = part.0;
}
    // rust: if let Some((target, yaw, steps)) = lerp {
    // rust: let n = f64::from(steps.max(1));
    // rust: d.position = Vec3::new(
    // rust: d.position.x + (target[0] - d.position.x) / n,
    // rust: d.position.y + (target[1] - d.position.y) / n,
    // rust: d.position.z + (target[2] - d.position.z) / n,
    // rust: );
    // rust: if let Some(yaw) = yaw {
    // rust: d.yaw += wrap(yaw - d.yaw) / steps.max(1) as f32;
}
}
    // rust: if !d.alive() {
            // EnderDragon.tickDeath on a client: it rises, and bursts
            // from tick 180 to 200; the server removes it.
    // rust: d.death_time += 1;
    // rust: let (t, p) = (d.death_time, d.position);
            // `EnderDragon.aiStep` still growls when the phase is not sitting.
    // rust: let sitting = d.phase.sitting();
    // rust: if (180..=200).contains(&t) {
    // rust: let r = &mut d.random;
    // rust: let o = [
    // rust: f64::from((r.next_float() - 0.5) * 8.0),
    // rust: f64::from((r.next_float() - 0.5) * 4.0),
    // rust: f64::from((r.next_float() - 0.5) * 8.0),
    // rust: ];
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::ExplosionEmitter),
    // rust: [p.x + o[0], p.y + 2.0 + o[1], p.z + o[2]],
    // rust: [0.0; 3],
    // rust: );
}
    // rust: if let Some(d) = self.dragon.as_mut() {
    // rust: d.position.y += 0.1;
    // rust: for part in &mut d.parts {
    // rust: part.0.y += 0.1;
}
}
            // `EnderDragon.aiStep` after `tickDeath`: the client growl is
            // before the `isDeadOrDying` branch, then a dead dragon adds
            // `ParticleTypes.EXPLOSION` every tick. Both use the risen spot.
    // rust: let mut growl = None;
    // rust: if let Some(d) = self.dragon.as_mut()
    // rust: && !sitting
    // rust: {
    // rust: d.growl -= 1;
    // rust: if d.growl < 0 {
                    // `this.random`: pitch, then `nextInt(200)`, before the puff.
    // rust: let pitch = 0.8 + d.random.next_float() * 0.3;
    // rust: d.growl = 200 + d.random.next_int_bound(200).unwrap_or(0);
    // rust: growl = Some(([d.position.x, d.position.y, d.position.z], pitch));
}
}
    // rust: if let Some((at, pitch)) = growl {
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_dragon.growl", Some(at), 2.5, pitch);
}
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return;
}
    // rust: let p = d.position;
    // rust: let r = &mut d.random;
    // rust: let o = [
    // rust: f64::from((r.next_float() - 0.5) * 8.0),
    // rust: f64::from((r.next_float() - 0.5) * 4.0),
    // rust: f64::from((r.next_float() - 0.5) * 8.0),
    // rust: ];
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::Explosion),
    // rust: [p.x + o[0], p.y + 2.0 + o[1], p.z + o[2]],
    // rust: [0.0; 3],
    // rust: );
    // rust: return;
}
        // processFlappingMovement and onFlap: its wing beats, and their sound.
    // rust: let flap_was = (d.old_flap * std::f32::consts::TAU).cos();
    // rust: let v = d.velocity;
    // rust: let mut flap_speed = 0.2 / ((v.x.hypot(v.z) as f32) * 10.0 + 1.0);
    // rust: flap_speed *= 2f32.powf(v.y as f32);
    // rust: d.flap += if d.phase.sitting() { 0.1 } else { flap_speed };
    // rust: let flap_now = (d.flap * std::f32::consts::TAU).cos();
    // rust: let at = [d.position.x, d.position.y, d.position.z];
    // rust: if flap_was <= -0.3 && flap_now >= -0.3 {
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.3;
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_dragon.flap", Some(at), 5.0, pitch);
}
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: if !d.phase.sitting() {
    // rust: d.growl -= 1;
    // rust: if d.growl < 0 {
    // rust: d.growl = 200 + d.random.next_int_bound(200).unwrap_or(0);
    // rust: let pitch = 0.8 + self.world.random.next_float() * 0.3;
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_dragon.growl", Some(at), 2.5, pitch);
}
}
        // checkCrystals' search runs on a client too (the healing beam).
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: if d.random.next_int_bound(10).unwrap_or(1) == 0 {
    // rust: let p = d.position;
    // rust: let nearest = self.nearest_crystal_to(p);
    // rust: self.dragon.as_mut().expect("dragon").nearest_crystal = nearest;
}
    // rust: let d = self.dragon.as_mut().expect("dragon");
    // rust: d.yaw = wrap(d.yaw);
        // EnderDragon.aiStep on a client with isNoAi, as on the server.
    // rust: if d.no_ai {
    // rust: d.flap = 0.5;
    // rust: return;
}
    // rust: d.record();
    // rust: self.remote_dragon_phase_tick();
    // rust: self.place_dragon_parts();
}
    /// `DragonLandingPhase.doClientTick`, `DragonSittingFlamingPhase.doClientTick`,
    /// `DragonDeathPhase.doClientTick` and `DragonSittingAttackingPhase.doClientTick`,
    /// which `EnderDragon.aiStep` runs on a client. The first two breathe
    /// dragon breath from the head (their `look.yRot(...)` results are thrown
    /// away in vanilla, so every puff leaves along the same line), the third
    /// puffs an explosion every 10 ticks and the last growls on every tick.
pub fn remote_dragon_phase_tick(self: *Self) void {
}
    // rust: let look = self.dragon_look_normalised();
    // rust: let Some(d) = self.dragon.as_mut() else {
    // rust: return;
}
    // rust: let head = d.parts[0].0;
    // rust: let head_y = head.y + PART_SIZES[0].1 * 0.5;
    // rust: let motion = d.velocity;
    // rust: let at = [d.position.x, d.position.y, d.position.z];
        // `flameTicks`: the client copy's own counter, advanced before it is read.
    // rust: if let Phase::Flaming { ticks } = &mut d.phase {
    // rust: *ticks += 1;
}
    // rust: let puffs = breath_puffs(
    // rust: &d.phase,
    // rust: look,
    // rust: [head.x, head_y, head.z],
    // rust: [motion.x, motion.y, motion.z],
    // rust: &mut d.random,
    // rust: );
    // rust: let mut emitter = None;
    // rust: let mut growl = None;
    // rust: match &mut d.phase {
    // rust: Phase::Dying { time, .. } => {
    // rust: if *time % 10 == 0 {
    // rust: let r = &mut d.random;
    // rust: let o = [
    // rust: f64::from((r.next_float() - 0.5) * 8.0),
    // rust: f64::from((r.next_float() - 0.5) * 4.0),
    // rust: f64::from((r.next_float() - 0.5) * 8.0),
    // rust: ];
    // rust: emitter = Some([at[0] + o[0], at[1] + 2.0 + o[1], at[2] + o[2]]);
}
    // rust: *time += 1;
}
    // rust: Phase::Attacking { .. } => {
    // rust: growl = Some(0.8 + d.random.next_float() * 0.3);
}
    // rust: _ => {}
}
    // rust: let breath = ParticleOptions::simple(ParticleType::DragonBreath);
    // rust: for (p, v) in puffs {
    // rust: self.particles.add(&breath, p, v);
}
    // rust: if let Some(p) = emitter {
    // rust: self.particles.add(
    // rust: &ParticleOptions::simple(ParticleType::ExplosionEmitter),
    // rust: p,
    // rust: [0.0; 3],
    // rust: );
}
    // rust: if let Some(pitch) = growl {
    // rust: self.audio
    // rust: .play("minecraft:entity.ender_dragon.growl", Some(at), 2.5, pitch);
}
}
    /// The dragon's parts as a server's client attacks them: the server's
    /// ids for `EnderDragonPart`s follow the dragon's.
    // rust: pub(super) fn remote_dragon_part_hit(
    // rust: &self,
    // rust: eye: [f64; 3],
    // rust: dir: [f64; 3],
    // rust: reach: f64,
    // rust: ) -> Option<(i32, f64, [f64; 3])> {
    // rust: let d = self.dragon.as_ref().filter(|d| d.alive() && d.id != 0)?;
    // rust: (0..8)
    // rust: .filter_map(|i| {
    // rust: let b = d.part_box(i);
    // rust: let p = d.parts[i].0;
    // rust: super::ray_box(eye, dir, reach, b)
    // rust: .map(|t| ((d.id + 1 + i as u32) as i32, t, [p.x, p.y, p.z]))
    // rust: })
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
}
}

/// The dying model's colour, `ARGB.white(1 - deathTime / 200)`: `Mth.floor` of the alpha
/// shifted as a Java int, so past 200 it wraps as vanilla's does.
pub fn dissolve_color(death: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let alpha = ((1.0 - death / 200.0) * 255.0).floor() as i32;
    // rust: (alpha << 24) as u32 | 0x00FF_FFFF
}
/// `DissolveMaskSampler` at the vertex's `UV0`: the same place in the mask's sprite as in the
/// skin's, as the dissolve overlay reads it from `glint_uv` (entity.wgsl).
pub fn dissolve_mask(quads: *mut [Vertex], skin: [f32; 4], mask: [f32; 4]) void {
}
    // rust: for v in quads {
    // rust: let u = (v.uv[0] - skin[0]) / (skin[2] - skin[0]);
    // rust: let w = (v.uv[1] - skin[1]) / (skin[3] - skin[1]);
    // rust: v.glint_uv = [
    // rust: mask[0] + (mask[2] - mask[0]) * u,
    // rust: mask[1] + (mask[3] - mask[1]) * w,
    // rust: ];
}
}
/// `submitRays`: the death rays from a fixed seed, fading in white to magenta.
pub fn dragon_rays(base: glam::Mat4, t: f32, white: horizon_client::hud::Rect, out: *mut std.ArrayList(Vertex)) void {
}
    // Vanilla's dragonRays has no texture. Sample inside the white sprite:
    // its border can round into transparent neighbours during interpolation.
    // rust: let uv = [(white.u0 + white.u1) / 2.0, (white.v0 + white.v1) / 2.0];
    // rust: let over = if t > 0.8 {
    // rust: ((t - 0.8) / 0.2).min(1.0)
    // rust: } else {
    // rust: 0.0
}
    // rust: let inner = (((1.0 - over) * 255.0) as u32) << 24 | 0x00FF_FFFF;
    // rust: let outer = 0x00FF_00FF;
    // rust: let mut random = LegacyRandom::new(432);
    // rust: let mut m = base;
    // rust: let count = ((t + t * t) / 2.0 * 60.0).floor() as i32;
    // rust: let half_sqrt3 = 3f32.sqrt() / 2.0;
    // rust: let tau = std::f32::consts::TAU;
    // rust: for _ in 0..count {
    // rust: let mut f = || random.next_float() * tau;
    // rust: let q1 = glam::Quat::from_rotation_x(f())
    // rust: * glam::Quat::from_rotation_y(f())
    // rust: * glam::Quat::from_rotation_z(f());
    // rust: let (a, b, c) = (f(), f(), f());
    // rust: let q2 = glam::Quat::from_rotation_x(a)
    // rust: * glam::Quat::from_rotation_y(b)
    // rust: * glam::Quat::from_rotation_z(c + t * std::f32::consts::FRAC_PI_2);
    // rust: m *= glam::Mat4::from_quat(q1 * q2);
    // rust: let length = random.next_float() * 20.0 + 5.0 + over * 10.0;
    // rust: let width = random.next_float() * 2.0 + 1.0 + over * 2.0;
    // rust: let o = glam::Vec3::ZERO;
    // rust: let left = glam::Vec3::new(-half_sqrt3 * width, length, -0.5 * width);
    // rust: let right = glam::Vec3::new(half_sqrt3 * width, length, -0.5 * width);
    // rust: let bottom = glam::Vec3::new(0.0, length, width);
    // rust: for (p1, p2) in [(left, right), (right, bottom), (bottom, left)] {
            // A triangle as a quad with its last corner repeated.
    // rust: for (p, c) in [(o, inner), (p1, outer), (p2, outer), (p2, outer)] {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: m.transform_point3(p).to_array(),
    // rust: uv,
    // rust: layer: horizon_client::gfx::DRAGON_RAYS_OVERLAY,
    // rust: color: c,
    // rust: light: 0,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}

/// `Entity.push` on the server's copy of a player, then `hurt`. A player's
/// own client hears of its velocity only when a hurt marks it
/// (`LivingEntity.hurtServer`'s `markHurt`, sent by
/// `ServerEntity.sendChanges`); `push` alone only sets `needsSync`, which
/// reaches the players tracking them, not them. So the push moves the player
/// only together with a hurt that lands outside the hurt cooldown, and is
/// dropped otherwise.
    // rust: fn push_seen_with_hurt(
    // rust: p: &mut horizon_client::motion::PlayerMotion,
    // rust: push: Vec3,
    // rust: hurt: impl FnOnce(&mut horizon_client::motion::PlayerMotion),
    // rust: ) {
    // rust: let before = p.velocity;
    // rust: let marked_before = std::mem::take(&mut p.health.sync_velocity);
    // rust: p.velocity = before.add_vector(push);
    // rust: hurt(p);
    // rust: if !p.health.sync_velocity {
    // rust: p.velocity = before;
}
    // rust: p.health.sync_velocity |= marked_before;
}

    // rust: mod tests {
//     use super::*;

pub fn player_box(feet: [f64; 3]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: Aabb::new(
    // rust: Vec3::new(feet[0] - 0.3, feet[1], feet[2] - 0.3),
    // rust: Vec3::new(feet[0] + 0.3, feet[1] + 1.8, feet[2] + 0.3),
    // rust: ),
    // rust: Vec3::new(feet[0], feet[1], feet[2]),
    // rust: )
}

    /// `EnderDragon.tickDeath` roars (`globalLevelEvent(1028)`) only when
    /// `!isSilent()`; `Silent` is saved only when set, as a byte.
pub fn a_dragon_is_silent_only_with_a_set_silent_byte() void {
}
//         use horizon_world::nbt::{Compound, Tag};
    // rust: let with = |v: Option<i8>| {
    // rust: let mut map = Compound::new();
    // rust: if let Some(b) = v {
    // rust: map.insert("Silent".into(), Tag::Byte(b));
}
    // rust: Tag::Compound(map)
}
    // rust: assert!(!super::saved_silent(None));
    // rust: assert!(!super::saved_silent(Some(&with(None))));
    // rust: assert!(!super::saved_silent(Some(&with(Some(0)))));
    // rust: assert!(super::saved_silent(Some(&with(Some(1)))));
}

pub fn breath_lifetime_excludes_the_wait() void {
}
    // rust: assert!(!breath_expired(219, 200));
    // rust: assert!(breath_expired(220, 200));
    // rust: assert!(!breath_expired(619, 600));
    // rust: assert!(breath_expired(620, 600));
}

pub fn breath_victims_cadence() void {
}
    // rust: let (a, b) = (FightWho::Host, FightWho::Guest(1));
    // rust: let mut v = Vec::new();
    // rust: assert!(breath_victims(15, &mut v, [a]).is_empty());
    // rust: assert_eq!(breath_victims(20, &mut v, [a]), vec![a]);
    // rust: assert!(breath_victims(25, &mut v, [a]).is_empty());
        // A newcomer is hit at the next 5-tick check, not the next 20.
    // rust: assert_eq!(breath_victims(30, &mut v, [a, b]), vec![b]);
    // rust: assert!(breath_victims(35, &mut v, [a, b]).is_empty());
    // rust: assert_eq!(breath_victims(40, &mut v, [a, b]), vec![a]);
    // rust: assert_eq!(breath_victims(50, &mut v, [a, b]), vec![b]);
}

pub fn instant_damage_at_cloud_scale() void {
}
    // rust: assert_eq!(harm_amount(0), 3.0);
    // rust: assert_eq!(harm_amount(1), 6.0);
}

pub fn cloud_box_is_half_a_block_tall_from_its_floor() void {
}
    // rust: let at = [0.0, 64.0, 0.0];
    // rust: let hit = |feet: [f64; 3], r: f32| {
    // rust: let (b, p) = player_box(feet);
    // rust: cloud_hits(at, r, b, p)
}
    // rust: assert!(hit([0.0, 64.0, 0.0], 3.0));
        // Feet above the 0.5 box: the old |dy| < 1 test hit here.
    // rust: assert!(!hit([0.0, 64.6, 0.0], 3.0));
        // Feet below, head reaching into the box.
    // rust: assert!(hit([0.0, 63.0, 0.0], 3.0));
        // Box overlaps but the centre is outside the radius.
    // rust: assert!(!hit([3.2, 64.0, 0.0], 3.0));
    // rust: assert!(hit([3.0, 64.0, 0.0], 3.0));
}

pub fn fireball_cloud_snaps_to_a_player_within_four() void {
}
    // rust: let (b, p) = player_box([2.0, 70.0, 1.0]);
    // rust: assert_eq!(
    // rust: fireball_cloud_origin([0.0, 70.0, 0.0], &[(b, p)]),
    // rust: [2.0, 70.0, 1.0]
    // rust: );
    // rust: let (b, p) = player_box([4.5, 70.0, 0.0]);
    // rust: assert_eq!(
    // rust: fireball_cloud_origin([0.0, 70.0, 0.0], &[(b, p)]),
    // rust: [0.0, 70.0, 0.0]
    // rust: );
}

pub fn dying_dragons_keep_their_flight_pose_between_frames() void {
}
    // rust: let mut dragon = Dragon::new(Vec3::new(0.0, 80.0, 0.0), 0.0, 432);
    // rust: dragon.history.fill((70.0, 170.0));
    // rust: dragon.position.y = 90.0;
    // rust: dragon.yaw = -170.0;
    // rust: dragon.record();
    // rust: assert_eq!(dragon.sample_lerp(0, 0.5), (80.0, 180.0));
    // rust: dragon.health = 0.0;
    // rust: for partial in [0.0, 0.25, 0.5, 0.75, 1.0] {
    // rust: assert_eq!(dragon.sample_lerp(0, partial), (70.0, 170.0));
}
}

    /// Driven by `tools/test_dragon_render_parity.py`; compares the actual
    /// ray vertices with EnderDragonRenderer's captured VertexConsumer output.
pub fn dragon_render_parity_fixture() void {
}
    // rust: let path = std::env::var("HORIZON_DRAGON_RENDER_OUTPUT").expect("harness output path");
    // rust: let mut cases = Vec::new();
    // rust: for t in [0.0, 0.05, 0.25, 0.5, 0.8, 0.9, 0.95, 1.0] {
    // rust: let mut vertices = Vec::new();
    // rust: dragon_rays(
    // rust: glam::Mat4::IDENTITY,
    // rust: t,
    // rust: horizon_client::hud::Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 1,
    // rust: h: 1,
    // rust: },
    // rust: &mut vertices,
    // rust: );
            // The fourth quad vertex only pads a triangle for our index buffer.
    // rust: let triangles: Vec<_> = vertices
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .flat_map(|q| &q[..3])
    // rust: .map(|v| serde_json::json!([v.pos[0], v.pos[1], v.pos[2], v.color]))
    // rust: .collect();
    // rust: cases.push(triangles);
}
    // rust: std::fs::write(path, serde_json::to_vec(&cases).unwrap()).unwrap();
}

pub fn the_dying_model_reads_the_mask_where_it_reads_the_skin() void {
}
        // The skin in the atlas's top-left quarter, the mask in its bottom-right one.
    // rust: let mut quad = [Vertex {
    // rust: pos: [0.0; 3],
    // rust: uv: [0.25, 0.125],
    // rust: layer: 0,
    // rust: color: 0,
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
    // rust: }];
    // rust: dissolve_mask(&mut quad, [0.0, 0.0, 0.5, 0.5], [0.5, 0.5, 1.0, 1.0]);
    // rust: assert_eq!(quad[0].glint_uv, [0.75, 0.625]);
        // ARGB.white(1 - deathTime / 200): floor(127.5), and past 200 the int shift wraps.
    // rust: assert_eq!(dissolve_color(100.0), 0x7FFF_FFFF);
    // rust: assert_eq!(dissolve_color(200.5), 0xFFFF_FFFF);
}

pub fn death_rays_sample_inside_the_white_sprite() void {
}
        // A four-texel white sprite surrounded by transparent atlas pixels.
        // A border UV can round outside it during perspective interpolation.
    // rust: let size = 1024.0;
    // rust: let white = horizon_client::hud::Rect {
    // rust: u0: 20.0 / size,
    // rust: v0: 60.0 / size,
    // rust: u1: 24.0 / size,
    // rust: v1: 64.0 / size,
    // rust: w: 4,
    // rust: h: 4,
}
    // rust: for t in [0.25, 0.8, 0.95, 1.0] {
    // rust: let mut vertices = Vec::new();
    // rust: dragon_rays(glam::Mat4::IDENTITY, t, white, &mut vertices);
    // rust: assert!(!vertices.is_empty());
    // rust: for v in &vertices {
    // rust: assert!(
    // rust: v.uv[0] > white.u0 + 0.5 / size && v.uv[0] < white.u1 - 0.5 / size,
    // rust: "death-ray U touches the atlas border: {}",
    // rust: v.uv[0]
    // rust: );
    // rust: assert!(
    // rust: v.uv[1] > white.v0 + 0.5 / size && v.uv[1] < white.v1 - 0.5 / size,
    // rust: "death-ray V touches the atlas border: {}",
    // rust: v.uv[1]
    // rust: );
}
}
}

    /// The damage type of the hits below, which count.
    // rust: const HIT: Option<HurtSource> = Some(HurtSource {
    // rust: damage_type: "minecraft:player_attack",
    // rust: causing: 0,
    // rust: direct: 0,
    // rust: });
pub fn dragon(phase: Phase) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut d = Dragon::new(Vec3::new(0.0, 70.0, 0.0), 0.0, 1);
    // rust: d.phase = phase;
    // rust: d
}
pub fn flying() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Phase::Holding {
    // rust: path: None,
    // rust: target: None,
    // rust: clockwise: false,
}
}

    /// `DragonLandingPhase.doClientTick`: eight puffs a tick from the head,
    /// along `getHeadLookVector(1)` (a quarter turn of it is thrown away in
    /// vanilla) plus the dragon's own motion.
pub fn a_landing_dragon_breathes_eight_puffs_from_its_head() void {
}
    // rust: let look = [0.0, -0.6, 0.8];
    // rust: let head = [10.0, 70.5, -3.0];
    // rust: let motion = [0.25, -0.05, 0.5];
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let puffs = breath_puffs(
    // rust: &Phase::Landing { target: None },
    // rust: look,
    // rust: head,
    // rust: motion,
    // rust: &mut random,
    // rust: );
    // rust: assert_eq!(puffs.len(), 8);
    // rust: let speed = [
    // rust: -look[0] * f64::from(0.08_f32) + motion[0],
    // rust: -look[1] * f64::from(0.3_f32) + motion[1],
    // rust: -look[2] * f64::from(0.08_f32) + motion[2],
    // rust: ];
    // rust: for (at, v) in puffs {
    // rust: assert_eq!(v, speed);
            // The head's centre, jittered by `nextGaussian() / 2`.
    // rust: for a in 0..3 {
    // rust: assert!(
    // rust: (at[a] - head[a]).abs() < 2.0,
    // rust: "puff {} off the head: {at:?}",
    // rust: a
    // rust: );
}
}
}

    /// `DragonSittingFlamingPhase.doClientTick`: on the even ticks of the first
    /// ten, eight starts each breathe a fan of six puffs down the look line.
pub fn a_flaming_dragon_breathes_a_fan_on_every_second_tick() void {
}
    // rust: let look = [0.6, -0.0, 0.8];
    // rust: let head = [0.0, 65.5, 4.0];
    // rust: for (tick, want) in [(1, 0), (2, 48), (3, 0), (4, 48), (8, 48), (9, 0), (10, 0)] {
    // rust: let mut random = LegacyRandom::new(11);
    // rust: let puffs = breath_puffs(
    // rust: &Phase::Flaming { ticks: tick },
    // rust: look,
    // rust: head,
    // rust: [0.0; 3],
    // rust: &mut random,
    // rust: );
    // rust: assert_eq!(puffs.len(), want, "flame tick {tick}");
}
    // rust: let mut random = LegacyRandom::new(11);
    // rust: let puffs = breath_puffs(
    // rust: &Phase::Flaming { ticks: 2 },
    // rust: look,
    // rust: head,
    // rust: [0.0; 3],
    // rust: &mut random,
    // rust: );
    // rust: for (i, (at, v)) in puffs.iter().enumerate() {
    // rust: let j = (i % 6) as f64;
            // Six puffs leave from each of the eight starts.
    // rust: assert_eq!(at, &puffs[i - i % 6].0);
    // rust: assert_eq!(
    // rust: *v,
    // rust: [
    // rust: -look[0] * f64::from(0.08_f32) * j,
    // rust: -look[1] * f64::from(0.6_f32),
    // rust: -look[2] * f64::from(0.08_f32) * j,
    // rust: ]
    // rust: );
}
}

    /// No other phase has a `doClientTick` that breathes.
pub fn only_the_landing_and_flaming_phases_breathe() void {
}
    // rust: let mut random = LegacyRandom::new(3);
    // rust: for phase in [
    // rust: flying(),
    // rust: Phase::Scanning { time: 5 },
    // rust: Phase::Hover { target: None },
    // rust: Phase::Takeoff {
    // rust: first: false,
    // rust: path: None,
    // rust: target: None,
    // rust: },
    // rust: Phase::Attacking { ticks: 3 },
    // rust: Phase::Dying {
    // rust: target: None,
    // rust: time: 0,
    // rust: },
    // rust: ] {
    // rust: assert!(
    // rust: breath_puffs(&phase, [0.0, -1.0, 0.0], [0.0; 3], [0.0; 3], &mut random).is_empty(),
    // rust: "{phase:?}"
    // rust: );
}
}

pub fn a_perched_dragon_shrugs_arrows_off() void {
}
        // AbstractDragonSittingPhase.onHurt: an arrow does nothing, melee does.
    // rust: let mut d = dragon(Phase::Scanning { time: 0 });
    // rust: assert_eq!(d.hurt(0, 9.0, HIT, true), Hurt::Shrugged);
    // rust: assert_eq!(d.health, MAX_HEALTH);
    // rust: assert_eq!(d.hurt(0, 9.0, HIT, false), Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, MAX_HEALTH - 9.0);
        // In flight an arrow lands.
    // rust: let mut d = dragon(flying());
    // rust: assert_eq!(d.hurt(0, 9.0, HIT, true), Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, MAX_HEALTH - 9.0);
}

    /// `EnderDragon.knockback` calls `LivingEntity.knockback` only when the
    /// phase is not sitting. `dealDefaultKnockback` uses `0.4F` away from the
    /// attacker's feet. Resistance is 0 and `onGround` stays false
    /// (`noPhysics`), so from velocity `(1, -0.3, 0.5)` and a source 3 by 4
    /// blocks away the push is `(0.5 - 0.6p, -0.3, 0.25 - 0.8p)` with
    /// `p = (double) 0.4F`. A perched hit, including one that makes it take
    /// off, leaves the velocity alone. A hit inside the damage cooldown is
    /// not a full hit, so it does not push either.
pub fn a_melee_hit_knocks_a_flying_dragon_and_not_a_perched_one() void {
}
    // rust: let from = Vec3::new(3.0, 70.0, 4.0);
    // rust: let velocity = Vec3::new(1.0, -0.3, 0.5);
    // rust: let power = f64::from(0.4_f32);
    // rust: let pushed = Vec3::new(0.5 - 0.6 * power, -0.3, 0.25 - 0.8 * power);

    // rust: let mut perched = dragon(Phase::Scanning { time: 0 });
    // rust: perched.velocity = velocity;
    // rust: assert_eq!(
    // rust: perched.hurt_from(0, 9.0, HIT, false, Some(from)),
    // rust: Hurt::Landed { full: true }
    // rust: );
    // rust: assert_eq!(perched.velocity, velocity);

    // rust: let mut taking_off = dragon(Phase::Flaming { ticks: 0 });
    // rust: taking_off.velocity = velocity;
    // rust: taking_off.hurt_from(0, 60.0, HIT, false, Some(from));
    // rust: assert!(matches!(taking_off.phase, Phase::Takeoff { .. }));
    // rust: assert_eq!(taking_off.velocity, velocity);

    // rust: let mut flying = dragon(flying());
    // rust: flying.velocity = velocity;
    // rust: assert_eq!(
    // rust: flying.hurt_from(0, 9.0, HIT, false, Some(from)),
    // rust: Hurt::Landed { full: true }
    // rust: );
    // rust: assert_eq!(flying.velocity, pushed);
    // rust: assert_eq!(
    // rust: flying.hurt_from(0, 20.0, HIT, false, Some(from)),
    // rust: Hurt::Landed { full: false }
    // rust: );
    // rust: assert_eq!(flying.velocity, pushed);
}

pub fn a_part_refuses_fire() void {
}
        // EnderDragonPart.hurtServer: the dragon is fire immune, so a
        // fireball's hit is refused on the head and on the other parts.
    // rust: let large = ProjectileKind::LargeFireball { power: 1 };
    // rust: for part in [0, 2] {
    // rust: let mut d = dragon(flying());
    // rust: let hurt = d.hurt_part(part, 6.0, HIT, DamageKind::Fireball, Some(&large));
    // rust: assert_eq!(hurt, Hurt::Refused);
    // rust: assert_eq!(d.health, MAX_HEALTH);
}
    // rust: let small = ProjectileKind::SmallFireball;
    // rust: let mut d = dragon(flying());
    // rust: let hurt = d.hurt_part(0, 5.0, HIT, DamageKind::Fireball, Some(&small));
    // rust: assert_eq!(hurt, Hurt::Refused);
    // rust: assert_eq!(d.health, MAX_HEALTH);
}

pub fn a_perched_dragon_shrugs_a_players_wind_charge_off() void {
}
        // AbstractDragonSittingPhase.onHurt: a direct WindCharge does
        // nothing, a breeze's BreezeWindCharge is not one.
    // rust: let charge = ProjectileKind::WindCharge;
    // rust: let mut d = dragon(Phase::Scanning { time: 0 });
    // rust: let hurt = d.hurt_part(0, 1.0, HIT, DamageKind::WindCharge, Some(&charge));
    // rust: assert_eq!(hurt, Hurt::Shrugged);
    // rust: assert_eq!(d.health, MAX_HEALTH);
    // rust: let breeze = ProjectileKind::BreezeWindCharge;
    // rust: let hurt = d.hurt_part(0, 1.0, HIT, DamageKind::WindCharge, Some(&breeze));
    // rust: assert_eq!(hurt, Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, MAX_HEALTH - 1.0);
        // In flight the player's charge lands too.
    // rust: let mut d = dragon(flying());
    // rust: let hurt = d.hurt_part(0, 1.0, HIT, DamageKind::WindCharge, Some(&charge));
    // rust: assert_eq!(hurt, Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, MAX_HEALTH - 1.0);
}

pub fn only_a_player_owned_wither_skull_takes_the_dragons_health() void {
}
        // WitherSkull.onHitEntity: EnderDragon.hurt takes the wither's skull
        // (not a player, not an explosion) but takes no health, even perched.
    // rust: let skull = ProjectileKind::WitherSkull { dangerous: false };
    // rust: let wither = super::super::wither::skull_source(Some(Who::Mob(7)), [0.0; 3]);
    // rust: assert_eq!((wither.amount, wither.kind), (8.0, DamageKind::WitherSkull));
    // rust: let mut d = dragon(Phase::Scanning { time: 0 });
    // rust: let hurt = d.hurt_part(2, wither.amount, None, wither.kind, Some(&skull));
    // rust: assert_eq!(hurt, Hurt::Landed { full: false });
    // rust: assert_eq!(d.health, MAX_HEALTH);
        // A player's skull: 8 on the head, 8 / 4 + 1 on the body.
    // rust: let player = super::super::wither::skull_source(Some(Who::Player), [0.0; 3]);
    // rust: let mut d = dragon(Phase::Scanning { time: 0 });
    // rust: let hurt = d.hurt_part(0, player.amount, HIT, player.kind, Some(&skull));
    // rust: assert_eq!(hurt, Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, MAX_HEALTH - 8.0);
    // rust: let mut d = dragon(flying());
    // rust: d.hurt_part(2, player.amount, HIT, player.kind, Some(&skull));
    // rust: assert_eq!(d.health, MAX_HEALTH - 3.0);
}

pub fn the_cooldown_lets_only_the_excess_through() void {
}
        // LivingEntity.hurtServer: damageCooldownTime > 10 keeps lastHurt.
    // rust: let mut d = dragon(flying());
    // rust: assert_eq!(d.hurt(0, 6.0, HIT, false), Hurt::Landed { full: true });
    // rust: assert_eq!(d.hurt(0, 4.0, HIT, false), Hurt::Landed { full: false });
    // rust: assert_eq!(d.health, MAX_HEALTH - 6.0);
    // rust: assert_eq!(d.hurt(0, 10.0, HIT, false), Hurt::Landed { full: false });
    // rust: assert_eq!(d.health, MAX_HEALTH - 10.0);
        // Ten ticks on, the window is over: a full hit again.
    // rust: d.invulnerable = 10;
    // rust: assert_eq!(d.hurt(0, 3.0, HIT, false), Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, MAX_HEALTH - 13.0);
}

pub fn parts_and_sources() void {
}
        // Neither head nor neck: a quarter plus one.
    // rust: let mut d = dragon(flying());
    // rust: assert_eq!(d.hurt(2, 20.0, HIT, false), Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, MAX_HEALTH - 6.0);
        // Not a player's and not an explosion: true, but no damage.
    // rust: let mut d = dragon(flying());
    // rust: assert_eq!(d.hurt(0, 20.0, None, false), Hurt::Landed { full: false });
    // rust: assert_eq!(d.health, MAX_HEALTH);
        // Too little after the part's cut, and nothing while dying.
    // rust: assert_eq!(d.hurt(3, 0.001, HIT, false), Hurt::Refused);
    // rust: d.phase = Phase::Dying {
    // rust: target: None,
    // rust: time: 0,
}
    // rust: assert_eq!(d.hurt(0, 20.0, HIT, false), Hurt::Refused);
}

    /// The dragon hits the hook of these tests saw: entity, damage type,
    /// causing and direct entities, amount.
    // rust: type Seen = (String, i32, i32, f32);
pub const SEEN: std::sync::Mutex<std.ArrayList((i32, Seen))> = std::sync::Mutex::new(Vec::new());
pub fn seen(entity: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let seen = SEEN.lock().unwrap();
    // rust: seen.iter()
    // rust: .filter(|s| s.0 == entity)
    // rust: .map(|s| s.1.clone())
    // rust: .collect()
}
    /// Sets the native damage hook of these tests: it records the dragon
    /// hits of entities 9001 to 9005, cancels 9001's, doubles 9002's, makes
    /// 9003's -5 and 9004's NaN. `HURT_SERVER` is global, so it stays set for
    /// every test of the process; the other tests' dragons are entity 0.
pub fn set_hook() void {
}
//         use horizon_client::health::{HURT_SERVER, Hurting};
pub fn hook(hurting: Hurting<'_>, amount: *mut f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Hurting::Dragon(entity @ 9001..=9005, s) = hurting else {
    // rust: return false;
}
    // rust: let hit = (s.damage_type.to_owned(), s.causing, s.direct, *amount);
    // rust: SEEN.lock().unwrap().push((entity, hit));
    // rust: match entity {
    // rust: 9002 => *amount *= 2.0,
    // rust: 9003 => *amount = -5.0,
    // rust: 9004 => *amount = f32::NAN,
    // rust: _ => {}
}
    // rust: entity == 9001
}
    // rust: let installed = *HURT_SERVER.get_or_init(|| hook);
    // rust: let ours: fn(Hurting<'_>, &mut f32) -> bool = hook;
    // rust: assert!(
    // rust: std::ptr::fn_addr_eq(installed, ours),
    // rust: "another native damage hook is set"
    // rust: );
}
pub fn dragon_as(entity: u32) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut d = dragon(flying());
    // rust: d.id = entity;
    // rust: d
}

pub fn the_native_damage_hook_changes_or_cancels_a_dragons_hit() void {
}
    // rust: set_hook();
        // EnderDragon.hurt returns true whatever reallyHurt did. A canceled
        // hit takes no health, starts no cooldown and isn't full: what
        // hurt_dragon_part reads to credit the player and play the hurt sound.
    // rust: let mut d = dragon_as(9001);
    // rust: let arrow = HurtSource {
    // rust: damage_type: "minecraft:arrow",
    // rust: causing: 12,
    // rust: direct: 0,
}
    // rust: let hurt = d.hurt(0, 9.0, Some(arrow), false);
    // rust: assert_eq!(hurt, Hurt::Landed { full: false });
    // rust: assert_eq!(seen(9001), [("minecraft:arrow".to_owned(), 12, 0, 9.0)]);
    // rust: assert_eq!(d.health, MAX_HEALTH);
    // rust: assert_eq!((d.invulnerable, d.last_hurt, d.hurt_time), (0, 0.0, 0));
        // The hook sees the amount after the part's cut (20 / 4 + 1).
    // rust: let mut d = dragon_as(9002);
    // rust: assert_eq!(d.hurt(2, 20.0, HIT, false), Hurt::Landed { full: true });
    // rust: assert_eq!(
    // rust: seen(9002),
    // rust: [("minecraft:player_attack".to_owned(), 0, 0, 6.0)]
    // rust: );
    // rust: assert_eq!(d.health, MAX_HEALTH - 12.0);
        // Neither a hit that doesn't count nor one cut below 0.01 reaches
        // reallyHurt.
    // rust: let mut d = dragon_as(9005);
    // rust: assert_eq!(d.hurt(0, 9.0, None, false), Hurt::Landed { full: false });
    // rust: assert_eq!(d.hurt(3, 0.001, HIT, false), Hurt::Refused);
    // rust: assert!(seen(9005).is_empty());
        // LivingEntity.hurtServer: a negative amount hurts by 0, a NaN by
        // Float.MAX_VALUE (the killing blow: the dying flight).
    // rust: let mut d = dragon_as(9003);
    // rust: assert_eq!(d.hurt(0, 9.0, HIT, false), Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, MAX_HEALTH);
    // rust: let mut d = dragon_as(9004);
    // rust: assert_eq!(d.hurt(0, 9.0, HIT, false), Hurt::Landed { full: true });
    // rust: assert_eq!(d.health, 1.0);
    // rust: assert!(matches!(d.phase, Phase::Dying { .. }));
}

pub fn a_hit_names_the_player_behind_it() void {
}
    // rust: let source = |kind, by, direct| {
    // rust: let s = super::hurt_source(kind, by, direct);
    // rust: (s.damage_type, s.causing, s.direct)
}
    // rust: let melee = source(DamageKind::PlayerAttack, Some(12), None);
    // rust: assert_eq!(melee, ("minecraft:player_attack", 12, 12));
    // rust: let arrow = ProjectileKind::Trident;
    // rust: let shot = source(DamageKind::Arrow, Some(12), Some(&arrow));
    // rust: assert_eq!(shot, ("minecraft:arrow", 12, 0));
    // rust: let blast = source(DamageKind::Explosion, Some(12), None);
    // rust: assert_eq!(blast, ("minecraft:player_explosion", 12, 0));
    // rust: let blast = source(DamageKind::Explosion, None, None);
    // rust: assert_eq!(blast, ("minecraft:explosion", 0, 0));
}

pub fn a_quarter_of_its_health_while_perched_makes_it_take_off() void {
}
    // rust: let mut d = dragon(Phase::Flaming { ticks: 0 });
    // rust: d.hurt(0, 30.0, HIT, false);
    // rust: assert!(d.phase.sitting());
    // rust: d.invulnerable = 0;
    // rust: d.hurt(0, 21.0, HIT, false);
    // rust: assert!(matches!(d.phase, Phase::Takeoff { .. }));
    // rust: assert_eq!(d.sitting_damage, 0.0);
}

pub fn an_explosion_pushes_the_dragon_along_the_blast() void {
}
    // rust: let mut d = dragon(flying());
    // rust: d.position = Vec3::new(0.0, 70.0, 0.0);
    // rust: d.velocity = Vec3::ZERO;
        // Power 5 right under the dragon: it is thrown up, away from the blast.
    // rust: let push = d.explosion_knockback([0.0, 66.0, 0.0], 5.0, 1.0).unwrap();
    // rust: assert!(push[1] > 0.0 && push[0] == 0.0 && push[2] == 0.0);
        // Out of reach or fully covered: no push.
    // rust: assert_eq!(d.explosion_knockback([0.0, 40.0, 0.0], 5.0, 1.0), None);
    // rust: assert_eq!(
    // rust: d.explosion_knockback([0.0, 66.0, 0.0], 5.0, 0.0),
    // rust: Some([0.0; 3])
    // rust: );
}

pub fn explosions_hit_each_part_by_its_exposure() void {
}
    // rust: let mut d = dragon(flying());
    // rust: for (i, part) in d.parts.iter_mut().enumerate() {
    // rust: part.0 = Vec3::new(i as f64 * 4.0, 70.0, 0.0);
}
        // A power-6 blast at the dragon's feet: diameter 12.
    // rust: let center = [0.0, 70.0, 0.0];
    // rust: let open = d.explosion_hits(center, 6.0, |_| 1.0);
        // The dragon itself (its body), then the parts within 12 blocks.
    // rust: let parts: Vec<usize> = open.iter().map(|h| h.0).collect();
    // rust: assert_eq!(parts, vec![2, 0, 1, 2, 3]);
        // At the centre: (1 + 1) / 2 * 7 * 12 + 1.
    // rust: assert_eq!(open[0].1, 85.0);
        // Behind cover (no ray reaches the box) only the 1 is left.
    // rust: let covered = d.explosion_hits(center, 6.0, |_| 0.0);
    // rust: assert!(covered.iter().all(|h| h.1 == 1.0));
        // Through the cooldown the strongest hit after the part's cut wins.
    // rust: for (part, amount) in open {
    // rust: d.hurt(part, amount, HIT, false);
}
    // rust: assert_eq!(d.health, MAX_HEALTH - 85.0);
}

pub fn player(who: FightWho, x: f64, creative: bool, spectator: bool) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let position = Vec3::new(x, 64.0, 0.0);
    // rust: FightPlayer {
    // rust: who,
    // rust: position,
    // rust: bounds: Aabb::new(position, Vec3::new(x + 0.6, 65.8, 0.6)),
    // rust: alive: true,
    // rust: creative,
    // rust: spectator,
}
}

pub fn the_first_crystal_destroyed_in_a_tick_names_the_strafed_player() void {
}
        // DragonHoldingPatternPhase.onCrystalDestroyed strafes at once, and
        // the strafing phase ignores the next crystal.
    // rust: let (host, guest) = (
    // rust: player(FightWho::Host, 1.0, false, false),
    // rust: player(FightWho::Guest(8), 2.0, false, false),
    // rust: );
    // rust: let mut d = dragon(flying());
    // rust: d.strafe_after_crystal(Some(&host));
    // rust: d.strafe_after_crystal(Some(&guest));
    // rust: assert_eq!(d.strafe_request, Some(FightWho::Host));
        // Nobody, or a player it can't attack, leaves the next crystal free.
    // rust: let creative = player(FightWho::Host, 1.0, true, false);
    // rust: let mut d = dragon(flying());
    // rust: d.strafe_after_crystal(None);
    // rust: d.strafe_after_crystal(Some(&creative));
    // rust: d.strafe_after_crystal(Some(&guest));
    // rust: assert_eq!(d.strafe_request, Some(FightWho::Guest(8)));
        // Only while it holds its pattern.
    // rust: let mut d = dragon(Phase::Scanning { time: 0 });
    // rust: d.strafe_after_crystal(Some(&guest));
    // rust: assert_eq!(d.strafe_request, None);
}

    /// #2893: a player under a wing is pushed only when the wing's hurt
    /// lands, not on every tick they stay there, and never under a perched
    /// dragon's wing.
pub fn a_wing_pushes_the_player_only_with_a_landed_hurt() void {
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("movement-properties.nbt").exists() {
    // rust: return;
}
    // rust: let assets = horizon_client::assets::Assets::load(&root).unwrap();
    // rust: let resources = horizon_client::motion::MotionResources::load(&root, &assets).unwrap();
    // rust: let (health, rules) = (&resources.health, Default::default());
    // rust: let id = health.damage.id("minecraft:mob_attack").unwrap();
    // rust: let push = Vec3::new(0.5, f64::from(0.2_f32), -0.25);
    // rust: let wing = |p: &mut horizon_client::motion::PlayerMotion, sitting: bool| {
    // rust: push_seen_with_hurt(p, push, |p| {
    // rust: if !sitting {
    // rust: let _ = p.hurt(health, rules, id, 5.0);
}
    // rust: });
}
        // In flight: the first tick's hurt lands and carries the push.
    // rust: let mut p = horizon_client::motion::PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: wing(&mut p, false);
    // rust: assert_eq!(p.velocity, push);
    // rust: assert_eq!(p.health.health(), 15.0);
        // The next 9 ticks are inside the hurt cooldown: no hurt, no push.
    // rust: for _ in 0..9 {
    // rust: p.health.advance_clock();
    // rust: wing(&mut p, false);
}
    // rust: assert_eq!(p.velocity, push, "pushed again with no hurt");
    // rust: assert_eq!(p.health.health(), 15.0);
        // Ten ticks on, the next hurt lands and pushes again.
    // rust: p.health.advance_clock();
    // rust: wing(&mut p, false);
    // rust: assert_eq!(p.velocity, push.add_vector(push));
    // rust: assert_eq!(p.health.health(), 10.0);
        // Under a perched dragon's wing nothing reaches the player.
    // rust: let mut p = horizon_client::motion::PlayerMotion::new(&resources, Vec3::ZERO).unwrap();
    // rust: for _ in 0..20 {
    // rust: wing(&mut p, true);
}
    // rust: assert_eq!(p.velocity, Vec3::ZERO, "pushed by a perched dragon");
    // rust: assert!(!p.health.sync_velocity);
}

pub fn the_dragon_targets_any_player_it_can_attack() void {
}
    // rust: let at = Vec3::new(0.0, 64.0, 0.0);
        // A spectating host and a creative guest are never targets: the
        // survival guest further away is.
    // rust: let players = [
    // rust: player(FightWho::Host, 1.0, false, true),
    // rust: player(FightWho::Guest(7), 2.0, true, false),
    // rust: player(FightWho::Guest(8), 30.0, false, false),
    // rust: ];
    // rust: let t = nearest_enemy(&players, false, at, None, |_| true);
    // rust: assert_eq!(t.map(|p| p.who), Some(FightWho::Guest(8)));
        // Out of a 20-block range, or filtered out, or on Peaceful: none.
    // rust: assert!(nearest_enemy(&players, false, at, Some((at, 20.0)), |_| true).is_none());
    // rust: assert!(nearest_enemy(&players, false, at, None, |p| p.position.x < 10.0).is_none());
    // rust: assert!(nearest_enemy(&players, true, at, None, |_| true).is_none());
        // The nearest of several, measured from where it looks (the egg).
    // rust: let players = [
    // rust: player(FightWho::Host, 5.0, false, false),
    // rust: player(FightWho::Guest(8), -3.0, false, false),
    // rust: ];
    // rust: let t = nearest_enemy(&players, false, at, None, |_| true);
    // rust: assert_eq!(t.map(|p| p.who), Some(FightWho::Guest(8)));
    // rust: let t = nearest_enemy(&players, false, Vec3::new(9.0, 64.0, 0.0), None, |_| true);
    // rust: assert_eq!(t.map(|p| p.who), Some(FightWho::Host));
}
pub fn a_landed_hurt_sets_the_dragon_hurt_flash_time() void {
}
    // rust: let mut d = dragon_as(42);
    // rust: assert_eq!(d.hurt_time, 0);
    // rust: let hurt = d.hurt(0, 5.0, HIT, false);
    // rust: assert_eq!(hurt, Hurt::Landed { full: true });
    // rust: assert_eq!(d.hurt_time, 10);
}
}
