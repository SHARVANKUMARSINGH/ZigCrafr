//! Transpiled from Horizon Rust crate
package horizon_client_raider

import "core:fmt"
import "core:mem"
import "core:math"

// Raiders (`PatrollingMonster` and `Raider`): the patrol state every
// pillager, vindicator, evoker, witch and ravager carries, the long
// distance patrol and hold-ground goals, the ominous banner a patrol leader
// wears, and the saved fields.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species, Who,
    // rust: goals::{Cx, Goal, LOOK, MOVE, goal_clone},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use horizon_world::nbt::Tag;

// The ominous banner is a white banner with the raid patterns; raiders wear
// it as their head item.
BANNER :: "minecraft:white_banner"

// `PatrollingMonster` and `Raider` state (saved as `patrol_target`,
// `PatrolLeader`, `Patrolling`, `Wave`, `CanJoinRaid`, `RaidId`).
State :: struct {
    patrol_leader: bool,
    patrolling: bool,
    patrol_target: Option<[i32,
    // Goal cooldown after a failed long distance path (game time).
    patrol_cooldown_until: i64,
    wave: i32,
    can_join_raid: bool,
    // The raid this raider belongs to.
    raid_id: Maybe(i32),
    ticks_outside_raid: i32,
    celebrating: bool,
    // The raid is active (`hasActiveRaid`); set by the game every tick.
    active_raid: bool,
    // A raid is active within 96 blocks (`ServerLevel.isRaided`); set by
    // the game every tick for vindicators.
    raided: bool,
    // The raid is won or lost (`Raid.isOver`), lost (`isLoss`).
    raid_over: bool,
    raid_loss: bool,
    raid_center: [i32,
    // Standing in or beside a village (`ServerLevel.isVillage`).
    in_village: bool,
    // A dropped ominous banner this raider may fetch.
    banner_at: Option<[f64,
    // The item entity of `banner_at`.
    banner_item: u32,
    // Banners with no path to them, and until when (game time):
    // `unreachableBannerCache`.
    unreachable_banners: Vec<(u32,
    // `PathfindToRaidGoal.tick` ran its 20 tick recruitment: the game
    // recruits the raiders around this one.
    recruit_due: bool,
    // Beds around the raid's centre.
    homes: Option<std::sync::Arc<Vec<[i32,
    // A ravager carrying a raider, set every tick from `Extra::rider`.
    rider: bool,
    // The raid counts this raider (`addWaveMob` ran since it joined or was
    // loaded with its `RaidId`).
    registered: bool,
    // `Raider.hurtServer` updates the raid's bar before the damage lands:
    // when it was last hurt (see [`next_hurt_seq`]) and its health then.
    hurt_seq: u64,
    pre_hurt_health: f32,
}

HURT_SEQ :: std::sync::atomic::AtomicU64::new(0)
// A counter ordering the hurts of raiders across the game.
next_hurt_seq :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: HURT_SEQ.fetch_add(1, std::sync::atomic::Ordering::Relaxed) + 1
}
// `Raider.hurtServer`: a raider in an active raid asks its raid to update
// the bar with the health it has before this hit.
note_hurt :: proc(m: ^Mob) {
}
    // rust: let health = m.health;
    // rust: if let Some(s) = m.extra.raider.as_deref_mut()
    // rust: && s.raid_id.is_some()
    // rust: && s.active_raid
    // rust: {
    // rust: s.hurt_seq = next_hurt_seq();
    // rust: s.pre_hurt_health = health;
}
}
    // rust: impl State {
    // A ravager carrying a raider (`hasControllingPassenger`).
has_rider :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.rider
}
}

// `Raider.class`: the species a goal that takes `Raider.class` filters out
// (`HurtByTargetGoal(this, Raider.class)`). A vex is not a raider.
    // rust: pub const RAIDERS: [Species; 6] = [
    // rust: Species::Pillager,
    // rust: Species::Vindicator,
    // rust: Species::Evoker,
    // rust: Species::Illusioner,
    // rust: Species::Witch,
    // rust: Species::Ravager,
    // rust: ];

// The raider species (`EntityTypeTags.RAIDERS`).
is_raider :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: RAIDERS.contains(&s)
}
// `canBeLeader`: witches and ravagers never lead.
can_be_leader :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: is_raider(s) && !matches!(s, Species::Witch | Species::Ravager)
}
state :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.raider.as_deref()
}
state_mut :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.raider.get_or_insert_with(Box::default)
}
// `Raider.getCurrentRaid() != null`.
in_raid :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state(m).is_some_and(|s| s.raid_id.is_some())
}
has_active_raid :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state(m).is_some_and(|s| s.active_raid)
}
// `Raider.isCaptain`: the banner on the head of a patrol leader.
//
// The worn stack (`extra.armor[0]`) carries the ominous components so a
// client that only got `SetEquipment` (no `PatrolLeader` NBT) still draws
// the patterned banner (#4567).
is_captain :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.head.as_deref() != Some(BANNER) {
    // rust: return false;
}
    // rust: state(m).is_some_and(|s| s.patrol_leader)
    // rust: || m.extra.armor[0]
    // rust: .as_ref()
    // rust: .and_then(|s| s.data())
    // rust: .is_some_and(|d| d.ominous_banner)
}

// `PatrollingMonster.registerGoals` then `Raider.registerGoals`: the goals
// every raider registers before its own.
register :: proc(m: ^Mob) {
}
    // rust: if !is_raider(m.species()) {
    // rust: return;
}
    // rust: m.extra.raider = Some(Box::default());
    // rust: m.ai.goals.add(4, LongDistancePatrol::new(0.7, 0.595));
    // rust: m.ai.goals.add(1, ObtainBanner::default());
    // rust: m.ai.goals.add(3, PathfindToRaid::default());
    // rust: m.ai.goals.add(4, MoveThroughVillage::new(1.05, 1.0));
    // rust: m.ai.goals.add(5, Celebration);
}

// `Raid.getOminousBannerInstance`.
ominous_banner :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: let mut stack = crate::items::ItemStack::new(BANNER, 1);
    // rust: stack.data_mut().ominous_banner = true;
    // rust: stack
}

// `PatrollingMonster.setPatrolLeader`.
set_patrol_leader :: proc(m: ^Mob, leader: bool) {
}
    // rust: let s = state_mut(m);
    // rust: s.patrol_leader = leader;
    // rust: s.patrolling = true;
}
// `PatrollingMonster.setPatrolTarget`.
set_patrol_target :: proc(m: ^Mob, target: [i32; 3]) {
}
    // rust: let s = state_mut(m);
    // rust: s.patrol_target = Some(target);
    // rust: s.patrolling = true;
}
// `PatrollingMonster.findPatrolTarget`: somewhere within 500 blocks.
find_patrol_target :: proc(m: ^Mob) {
}
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: find_patrol_target_from(m, at);
}
// `findPatrolTarget` from a given block position.
find_patrol_target_from :: proc(m: ^Mob, z]: [i32; 3]) {
}
    // rust: let dx = -500 + m.random.next_int_bound(1000).unwrap_or(0);
    // rust: let dz = -500 + m.random.next_int_bound(1000).unwrap_or(0);
    // rust: let s = state_mut(m);
    // rust: s.patrol_target = Some([x + dx, y, z + dz]);
    // rust: s.patrolling = true;
}
// The leader's ominous banner and saved head drop chance of 2.0.
//
// Also keeps the full ominous stack in `armor[0]` so `SetEquipment` sends
// the patterned banner to clients (`Raid.getOminousBannerInstance`).
wear_banner :: proc(m: ^Mob) {
}
    // rust: m.extra.head = Some(BANNER.into());
    // rust: m.extra.armor[0] = Some(ominous_banner());
    // Raid.setLeader and PatrollingMonster.finalizeSpawn: EquipmentSlot.HEAD.
    // rust: super::finalize::set_drop_chance(m, 5, 2.0);
}
// Why a mob was spawned (`EntitySpawnReason`), as far as raiders care.
Reason :: enum {
    // Natural spawning: one leader in 17, and witches stay out of raids.
    Natural,
    // Commands, eggs and other spawns: one leader in 17.
    Other,
    Patrol,
    Event,
}
// `PatrollingMonster.finalizeSpawn` and `Raider.finalizeSpawn`: a spawn
// other than a patrol, raid or structure leads one time in 17, a patrol
// leader wears the ominous banner, and every raider but a naturally spawned
// witch can join a raid.
finalize :: proc(m: ^Mob, reason: Reason) {
}
    // rust: if !is_raider(m.species()) {
    // rust: return;
}
    // rust: let roll = matches!(reason, Reason::Natural | Reason::Other);
    // rust: if roll && m.random.next_float() < 0.06 && can_be_leader(m.species()) {
    // rust: state_mut(m).patrol_leader = true;
}
    // rust: if state_mut(m).patrol_leader {
    // rust: wear_banner(m);
}
    // rust: let witch = m.species() == Species::Witch;
    // rust: let s = state_mut(m);
    // rust: if reason == Reason::Patrol {
    // rust: s.patrolling = true;
}
    // rust: s.can_join_raid = !witch || reason != Reason::Natural;
}

// `PatrollingMonster.removeWhenFarAway`: patrollers and raiders in a raid
// are only despawned beyond 128 blocks (never inside a raid).
keeps_alive :: proc(m: ^Mob, distance_squared: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match state(m) {
    // rust: Some(s) => s.raid_id.is_some() || s.patrolling && distance_squared <= 16384.0,
    // rust: None => false,
}
}

// `Heightmap.Types.MOTION_BLOCKING_NO_LEAVES` position above (x, z).
heightmap_pos :: proc(w: ^MobWorld, x: i32, z: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let top = w.world.top_y();
    // rust: let y = (w.world.bottom_y()..top)
    // rust: .rev()
    // rust: .find(|&y| {
    // rust: let f = w.facts.get(w.world.block(x, y, z));
    // rust: (f.full_collision || f.fluid != crate::blocks::Fluid::None)
    // rust: && !f.name.ends_with("leaves")
    // rust: })
    // rust: .map_or(w.world.bottom_y(), |y| y + 1);
    // rust: [x, y, z]
}

// `Vec3.yRot` (the angle is in radians, and the patrol goal passes 90).
y_rot :: proc(v: Vec3, angle: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let (cos, sin) = (f64::from(angle.cos()), f64::from(angle.sin()));
    // rust: Vec3::new(v.x * cos + v.z * sin, v.y, v.z * cos - v.x * sin)
}

// `PatrollingMonster.LongDistancePatrolGoal`: walk toward the patrol target
// in 10 block hops (curving around it), the leader dragging its companions.
LongDistancePatrol :: struct {
    speed: f64,
    leader_speed: f64,
}
    // rust: impl LongDistancePatrol {
new :: proc(speed: f64, leader_speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: leader_speed,
}
}
}
// Patrol companions within 16 blocks that are not in a raid.
companions :: proc(m: ^Mob, w: ^MobWorld) -> V {
    // Ported from Horizon
    return {}
}
    // rust: w.others
    // rust: .iter()
    // rust: .filter(|s| {
    // rust: s.id != m.id
    // rust: && s.alive
    // rust: && is_raider(s.species)
    // rust: && !s.active_raid
    // rust: && (s.position.x - m.position.x).abs() <= 16.0 + f64::from(m.width())
    // rust: && (s.position.y - m.position.y).abs() <= 16.0 + f64::from(m.height())
    // rust: && (s.position.z - m.position.z).abs() <= 16.0 + f64::from(m.width())
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .collect()
}
    // rust: impl Goal for LongDistancePatrol {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = state(m) else { return false };
    // rust: cx.w.game_time >= s.patrol_cooldown_until
    // rust: && s.patrolling
    // rust: && m.ai.target.is_none()
    // rust: && s.patrol_target.is_some()
    // rust: && !s.has_rider()
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if !m.ai.nav.is_done() {
    // rust: return;
}
    // rust: let leader = state(m).is_some_and(|s| s.patrol_leader);
    // rust: let friends = companions(m, cx.w);
    // rust: let Some(target) = state(m).and_then(|s| s.patrol_target) else {
    // rust: return;
}
    // rust: if state(m).is_some_and(|s| s.patrolling) && friends.is_empty() {
    // rust: state_mut(m).patrolling = false;
    // rust: } else if leader && close_to_center(target, m.position, 10.0) {
    // rust: find_patrol_target(m);
    // rust: } else {
    // rust: let to = Vec3::new(
    // rust: f64::from(target[0]) + 0.5,
    // rust: f64::from(target[1]),
    // rust: f64::from(target[2]) + 0.5,
    // rust: );
    // rust: let own = m.position;
    // rust: let distance = own.subtract(to);
    // rust: let to = y_rot(distance, 90.0).scale(0.4).add_vector(to);
    // rust: let hop = to.subtract(own).normalize().scale(10.0).add_vector(own);
    // rust: let at = heightmap_pos(cx.w, hop.x.floor() as i32, hop.z.floor() as i32);
    // rust: let speed = if leader {
    // rust: self.leader_speed
    // rust: } else {
    // rust: self.speed
}
    // rust: let to = [f64::from(at[0]), f64::from(at[1]), f64::from(at[2])];
    // rust: if !m.nav_move_to(cx.w, to, speed) {
    // rust: self.move_randomly(m, cx);
    // rust: state_mut(m).patrol_cooldown_until = cx.w.game_time + 200;
    // rust: } else if leader {
    // rust: for id in friends {
    // rust: cx.events.push(MobEvent::PatrolTarget {
    // rust: mob: id,
    // rust: target: at,
    // rust: });
}
}
}
}
}
    // rust: impl LongDistancePatrol {
move_randomly :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (x, z) = (
    // rust: m.position.x.floor() as i32 - 8 + m.random.next_int_bound(16).unwrap_or(0),
    // rust: m.position.z.floor() as i32 - 8 + m.random.next_int_bound(16).unwrap_or(0),
    // rust: );
    // rust: let at = heightmap_pos(cx.w, x, z);
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [f64::from(at[0]), f64::from(at[1]), f64::from(at[2])],
    // rust: self.speed,
    // rust: )
}
}
// `Vec3i.closerToCenterThan`.
close_to_center :: proc(p: [i32; 3], at: Vec3, distance: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::new(
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: )
    // rust: .distance_squared(at)
    // rust: < distance * distance
}

// `Raider.ObtainRaidLeaderBannerGoal`: walk to a fallen ominous banner when
// the wave has no living leader (the game finds the banner and picks it up).
ObtainBanner :: struct {
    path_to_banner: Maybe(super::path::Path),
}
    // rust: impl Goal for ObtainBanner {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some((at, item)) = state(m).and_then(|s| s.banner_at.map(|at| (at, s.banner_item)))
    // rust: else {
    // rust: return false;
}
        // A banner with no path to it is skipped for 600 ticks.
    // rust: let path = m.create_path_to_entity(cx.w, at, 1);
    // rust: if path.as_ref().is_some_and(|p| p.reached) {
    // rust: self.path_to_banner = path;
    // rust: return true;
}
    // rust: let now = cx.w.game_time;
    // rust: let s = state_mut(m);
    // rust: s.unreachable_banners.retain(|&(_, until)| now < until);
    // rust: s.unreachable_banners.push((item, now + 600));
    // rust: false
}
can_continue :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done() && state(m).is_some_and(|s| s.banner_at.is_some())
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.nav_move_to_path(cx.w, self.path_to_banner.take(), 1.15);
}
}

// `PathfindToRaidGoal`: outside the village, head for the raid's centre in
// hops of up to 15 blocks, recruiting nearby raiders every 20 ticks.
PathfindToRaid :: struct {
    recruitment_tick: i32,
}
    // rust: impl PathfindToRaid {
valid :: proc(s: ^State) -> b {
    // Ported from Horizon
    return {}
}
    // rust: s.active_raid && !s.raid_over && !s.in_village
}
}
    // rust: impl Goal for PathfindToRaid {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.target.is_none() && state(m).is_some_and(|s| !s.has_rider() && Self::valid(s))
}
can_continue :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: state(m).is_some_and(Self::valid)
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(c) = state(m).map(|s| s.raid_center) else {
    // rust: return;
}
    // rust: if m.age as i32 > self.recruitment_tick {
    // rust: self.recruitment_tick = m.age as i32 + 20;
    // rust: if let Some(s) = m.extra.raider.as_deref_mut() {
    // rust: s.recruit_due = true;
}
}
    // rust: if m.ai.nav.is_done() {
    // rust: let to = [
    // rust: f64::from(c[0]) + 0.5,
    // rust: f64::from(c[1]),
    // rust: f64::from(c[2]) + 0.5,
    // rust: ];
    // rust: if let Some(at) =
    // rust: m.default_random_pos_towards(cx.w, 15, 4, to, std::f64::consts::FRAC_PI_2)
    // rust: {
    // rust: m.nav_move_to(cx.w, at, 1.0);
}
}
}
}

// `Raider.RaiderMoveThroughVillageGoal`: walk to a bed of the village not
// visited lately, then onwards to the next one.
MoveThroughVillage :: struct {
    speed: f64,
    distance: f64,
    poi: Option<[i32,
    visited: Vec<[i32,
    stuck: bool,
}
    // rust: impl MoveThroughVillage {
new :: proc(speed: f64, distance: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: speed,
    // rust: distance,
    // rust: poi: None,
    // rust: visited: Vec::new(),
    // rust: stuck: false,
}
}
}
    // rust: impl Goal for MoveThroughVillage {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.visited.len() > 2 {
    // rust: self.visited.remove(0);
}
    // rust: let Some(s) = state(m) else { return false };
    // rust: if !s.active_raid || s.raid_over || m.ai.target.is_some() {
    // rust: return false;
}
    // rust: let Some(homes) = s.homes.clone() else {
    // rust: return false;
}
    // rust: let near: Vec<[i32; 3]> = homes
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|p| !self.visited.contains(p) && close_to_center(*p, m.position, 48.0))
    // rust: .collect();
    // rust: if near.is_empty() {
    // rust: return false;
}
    // rust: self.poi = Some(near[m.random.next_int_bound(near.len() as i32).unwrap_or(0) as usize]);
    // rust: true
}
can_continue :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = self.poi else { return false };
    // rust: !m.ai.nav.is_done()
    // rust: && m.ai.target.is_none()
    // rust: && !close_to_center(p, m.position, f64::from(m.width()) + self.distance)
    // rust: && !self.stuck
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.ai.no_action_time = 0;
    // rust: if let Some(p) = self.poi {
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [f64::from(p[0]), f64::from(p[1]), f64::from(p[2])],
    // rust: self.speed,
    // rust: );
}
    // rust: self.stuck = false;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: if let Some(p) = self.poi
    // rust: && close_to_center(p, m.position, self.distance)
    // rust: {
    // rust: self.visited.push(p);
}
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(p) = self.poi else { return };
    // rust: if !m.ai.nav.is_done() {
    // rust: return;
}
    // rust: let to = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: let next = m
    // rust: .default_random_pos_towards(cx.w, 16, 7, to, std::f64::consts::PI / 10.0)
    // rust: .or_else(|| m.default_random_pos_towards(cx.w, 8, 7, to, std::f64::consts::FRAC_PI_2));
    // rust: match next {
    // rust: Some(at) => {
    // rust: m.nav_move_to(cx.w, at, self.speed);
}
    // rust: None => self.stuck = true,
}
}
}

// `Raider.RaiderCelebration`: after a lost village, cheer and jump.
Celebration :: struct {
    // rust: impl Goal for Celebration {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.alive()
    // rust: && m.ai.target.is_none()
    // rust: && state(m).is_some_and(|s| s.raid_loss && s.raid_id.is_some())
}
start :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: state_mut(m).celebrating = true;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: state_mut(m).celebrating = false;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if m.random
    // rust: .next_int_bound(super::goals::reduced(100))
    // rust: .unwrap_or(1)
    // rust: == 0
    // rust: {
    // rust: let sound = match m.species() {
    // rust: Species::Pillager => "entity.pillager.celebrate",
    // rust: Species::Vindicator => "entity.vindicator.celebrate",
    // rust: Species::Evoker => "entity.evoker.celebrate",
    // rust: Species::Ravager => "entity.ravager.celebrate",
    // rust: _ => "entity.witch.celebrate",
}
    // rust: m.voice(sound, cx.events);
}
        // Raider.RaiderCelebration.tick: a raider riding a ravager (or any
        // vehicle) does not jump. The roll is skipped too, as in vanilla.
    // rust: if m.extra.mount.is_none()
    // rust: && m.random
    // rust: .next_int_bound(super::goals::reduced(50))
    // rust: .unwrap_or(1)
    // rust: == 0
    // rust: {
    // rust: m.ai.jumping = true;
}
}
}

// `Raider.HoldGroundAttackGoal`: while patrolling, stand still and let the
// patrol shout when something shows up; attack once it comes close.
HoldGroundAttack :: struct {
    hostile_radius_sqr: f64,
}
    // rust: impl HoldGroundAttack {
new :: proc(radius: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: hostile_radius_sqr: radius * radius,
}
}
}
// Raiders within 8 blocks, nearest first (`shoutTargeting`).
shout_range :: proc(m: ^Mob, w: ^MobWorld) -> V {
    // Ported from Horizon
    return {}
}
    // rust: w.others
    // rust: .iter()
    // rust: .filter(|s| {
    // rust: s.id != m.id
    // rust: && s.alive
    // rust: && is_raider(s.species)
    // rust: && (s.position.x - m.position.x).abs() <= 8.0 + f64::from(m.width())
    // rust: && (s.position.y - m.position.y).abs() <= 8.0 + f64::from(m.height())
    // rust: && (s.position.z - m.position.z).abs() <= 8.0 + f64::from(m.width())
    // rust: && s.position.distance_squared(m.position) <= 64.0
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .collect()
}
    // rust: impl Goal for HoldGroundAttack {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(s) = state(m) else { return false };
    // rust: s.raid_id.is_none()
    // rust: && s.patrolling
    // rust: && m.ai.target.is_some()
    // rust: && !m.ai.aggressive
    // rust: && m.ai.last_hurt_by != Some(Who::Player)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: m.ai.nav.stop();
    // rust: if let Some(target) = m.ai.target {
    // rust: for id in shout_range(m, cx.w) {
    // rust: cx.events.push(MobEvent::RaiderTarget {
    // rust: mob: id,
    // rust: target,
    // rust: aggressive: false,
    // rust: });
}
}
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(target) = m.ai.target {
    // rust: for id in shout_range(m, cx.w) {
    // rust: cx.events.push(MobEvent::RaiderTarget {
    // rust: mob: id,
    // rust: target,
    // rust: aggressive: true,
    // rust: });
}
    // rust: m.ai.aggressive = true;
}
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(t) = m.target_info(cx.w) else { return };
    // rust: if m.distance_sqr(t.position) > self.hostile_radius_sqr {
    // rust: m.look_at([t.position.x, t.eye_y, t.position.z]);
    // rust: if m.random.next_int_bound(50).unwrap_or(1) == 0 {
    // rust: let sound = m.kind.sounds[0];
    // rust: if !sound.is_empty() {
    // rust: m.voice(sound, cx.events);
}
}
    // rust: } else {
    // rust: m.ai.aggressive = true;
}
}
}

// The saved fields (`PatrollingMonster` and `Raider.addAdditionalSaveData`).
write_nbt :: proc(m: ^Mob, map: ^horizon_world::nbt::Compound) {
}
    // rust: let Some(s) = state(m) else { return };
    // rust: match s.patrol_target {
    // rust: Some(p) => {
    // rust: map.insert("patrol_target".into(), Tag::IntArray(p.to_vec()));
}
    // rust: None => {
    // rust: map.remove(&"patrol_target".into());
}
}
    // rust: map.insert("PatrolLeader".into(), Tag::Byte(i8::from(s.patrol_leader)));
    // rust: map.insert("Patrolling".into(), Tag::Byte(i8::from(s.patrolling)));
    // rust: map.insert("Wave".into(), Tag::Int(s.wave));
    // rust: map.insert("CanJoinRaid".into(), Tag::Byte(i8::from(s.can_join_raid)));
    // rust: match s.raid_id {
    // rust: Some(id) => {
    // rust: map.insert("RaidId".into(), Tag::Int(id));
}
    // rust: None => {
    // rust: map.remove(&"RaidId".into());
}
}
}
read_nbt :: proc(m: ^Mob, tag: ^Tag) {
}
    // rust: if !is_raider(m.species()) {
    // rust: return;
}
    // rust: let int = |t: Option<&Tag>| match t {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: Some(Tag::Byte(v)) => Some(i32::from(*v)),
    // rust: Some(Tag::Short(v)) => Some(i32::from(*v)),
    // rust: _ => None,
}
    // rust: let flag = |t: Option<&Tag>| int(t).unwrap_or(0) != 0;
    // rust: let s = state_mut(m);
    // rust: s.patrol_target = match tag.get("patrol_target") {
    // rust: Some(Tag::IntArray(v)) if v.len() == 3 => Some([v[0], v[1], v[2]]),
    // rust: _ => None,
}
    // rust: s.patrol_leader = flag(tag.get("PatrolLeader"));
    // rust: s.patrolling = flag(tag.get("Patrolling"));
    // rust: s.wave = int(tag.get("Wave")).unwrap_or(0);
    // rust: s.can_join_raid = flag(tag.get("CanJoinRaid"));
    // rust: s.raid_id = int(tag.get("RaidId"));
}

    // rust: mod tests {
//     use super::*;

raiders_and_leaders :: proc() {
}
    // rust: assert!(is_raider(Species::Ravager) && is_raider(Species::Witch));
    // rust: assert!(!is_raider(Species::Zombie));
    // rust: assert!(can_be_leader(Species::Pillager) && can_be_leader(Species::Evoker));
    // rust: assert!(!can_be_leader(Species::Witch) && !can_be_leader(Species::Ravager));
}
wear_banner_keeps_the_stack_and_head_drop_chance :: proc() {
}
//         use crate::mobs::sensor_scan_tests::kind;
//         use std::sync::Arc;
    // rust: let mut k = (*kind()).clone();
    // rust: k.id = "minecraft:pillager".into();
    // rust: k.species = Species::Pillager;
    // rust: let mut m = Mob::new(1, Arc::new(k), Vec3::ZERO, 0.0);
    // rust: m.extra.raider = Some(Box::default());
    // rust: state_mut(&mut m).patrol_leader = true;
    // rust: super::super::finalize::set_drop_chance(&mut m, 1, 0.65);
    // rust: wear_banner(&mut m);
    // rust: assert_eq!(m.extra.head.as_deref(), Some(BANNER));
    // rust: assert!(
    // rust: m.extra.armor[0]
    // rust: .as_ref()
    // rust: .and_then(|s| s.data())
    // rust: .is_some_and(|d| d.ominous_banner)
    // rust: );
    // rust: assert!(is_captain(&m));
    // rust: let saved = crate::entity_nbt::mob_to_nbt(&m, [0; 4], None, None);
    // rust: let chances = saved.get("drop_chances").unwrap();
    // rust: assert_eq!(
    // rust: chances.get("head"),
    // rust: Some(&horizon_world::nbt::Tag::Float(2.0_f32.to_bits()))
    // rust: );
    // rust: assert_eq!(
    // rust: chances.get("offhand"),
    // rust: Some(&horizon_world::nbt::Tag::Float(0.65_f32.to_bits())),
    // rust: "equipping the banner preserves other slots' explicit chances"
    // rust: );
        // Client that only saw SetEquipment: no PatrolLeader, still a captain.
    // rust: state_mut(&mut m).patrol_leader = false;
    // rust: assert!(is_captain(&m));
    // rust: m.extra.armor[0] = None;
    // rust: assert!(!is_captain(&m));
}
long_distance_patrol_turns_by_ninety_radians :: proc() {
}
        // PatrollingMonster passes 90.0F to Vec3.yRot (radians).
    // rust: let v = y_rot(Vec3::new(10.0, 3.0, 0.0), 90.0);
    // rust: let (c, s) = (90f64.cos(), 90f64.sin());
    // rust: assert!((v.x - 10.0 * c).abs() < 1e-4 && (v.z + 10.0 * s).abs() < 1e-4);
    // rust: assert_eq!(v.y, 3.0);
}
closer_to_center_uses_block_centres :: proc() {
}
    // rust: let at = Vec3::new(10.5, 64.5, 10.5);
    // rust: assert!(close_to_center([10, 64, 10], at, 1.0));
    // rust: assert!(!close_to_center([30, 64, 10], at, 10.0));
}

    // `RaiderCelebration.tick` jumps only when the raider is not a passenger.
a_celebrating_raider_does_not_jump_while_riding :: proc() {
}
//         use crate::mobs::world::with_test_world;
//         use horizon_core::random::LegacyRandom;
//         use std::sync::Arc;
    // rust: let _ = with_test_world(&[], |w, _| {
    // rust: let jumped = |seed: i64, riding: bool| {
    // rust: let mut k = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: k.id = "minecraft:pillager".into();
    // rust: k.species = Species::Pillager;
    // rust: let mut m = Mob::new(1, Arc::new(k), Vec3::ZERO, 0.0);
    // rust: m.random = LegacyRandom::new(seed);
    // rust: m.extra.raider = Some(Box::default());
    // rust: if riding {
    // rust: m.extra.mount = Some(9);
}
    // rust: let mut goal = Celebration;
    // rust: let mut lr = LegacyRandom::new(1);
    // rust: let mut events = Vec::new();
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: goal.tick(&mut m, &mut cx);
    // rust: m.ai.jumping
}
    // rust: let seed = (1..500)
    // rust: .find(|seed| jumped(*seed, false))
    // rust: .expect("some seed celebrates with a jump");
    // rust: assert!(jumped(seed, false));
    // rust: assert!(!jumped(seed, true));
    // rust: });
}
}
