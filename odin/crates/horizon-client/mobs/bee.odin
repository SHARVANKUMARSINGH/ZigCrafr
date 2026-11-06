//! Transpiled from Horizon Rust crate
package horizon_client_bee

import "core:fmt"
import "core:mem"
import "core:math"

// Bees (`Bee`): flying about (`FlyingMoveControl`, `BeeWanderGoal`), finding
// flowers and hovering over them until they carry nectar
// (`BeePollinateGoal`), `NeutralMob` anger at whoever hurts them, stinging
// once and dying of it, and the hive and flower bookkeeping: finding a hive
// with room nearby (`BeeLocateHiveGoal`), flying home at night, in the rain
// or with nectar (`BeeGoToHiveGoal`) and going in (`BeeEnterHiveGoal`, done
// by the host: [`MobEvent::EnterHive`]); the hive lets them out
// (`crate::beehive`).
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: control::{LookKind, MoveKind},
    // rust: goals::{
    // rust: Breed, Cx, Float, FollowParent, Goal, HurtByTarget, MOVE, MeleeAttack, NearestTarget,
    // rust: Tempt, goal_clone, reduced,
    // rust: },
    // rust: nav::NavKind,
    // rust: path::PathType,
}
// use crate::beehive::BeehiveExt;
// use horizon_core::random::{LegacyRandom, RandomSource};
// use std::collections::HashMap;

FLAG_ROLL :: 2
FLAG_HAS_STUNG :: 4
FLAG_HAS_NECTAR :: 8

// The bee's own fields (`Bee`'s instance state and its synced flags).
Bee :: struct {
    // `DATA_FLAGS_ID`: rolling, has stung, has nectar.
    flags: u8,
    // `DATA_ANGER_END_TIME`, -1 when calm.
    anger_end: i64,
    // `persistentAngerTarget`.
    angry_at: Maybe(Who),
    roll: f32,
    roll_o: f32,
    time_since_sting: i32,
    ticks_without_nectar: i32,
    stay_out_of_hive: i32,
    crops_grown: i32,
    // `remainingCooldownBeforeLocatingNewHive` and `...NewFlower`.
    hive_cooldown: i32,
    flower_cooldown: i32,
    flower: Option<[i32,
    hive: Option<[i32,
    under_water: i32,
    // `BeePollinateGoal.pollinating`, read by the navigation and look control.
    pollinating: bool,
    // The cooldowns `ValidateHiveGoal` and `ValidateFlowerGoal` draw when built.
    validate_hive_cooldown: i32,
    validate_flower_cooldown: i32,
    // `BeeGoToHiveGoal.blacklistedTargets`: the last three hives it gave up on.
    hive_blacklist: Vec<[i32,
}
    // rust: impl Default for Bee {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: flags: 0,
    // rust: anger_end: -1,
    // rust: angry_at: None,
    // rust: roll: 0.0,
    // rust: roll_o: 0.0,
    // rust: time_since_sting: 0,
    // rust: ticks_without_nectar: 0,
    // rust: stay_out_of_hive: 0,
    // rust: crops_grown: 0,
    // rust: hive_cooldown: 0,
    // rust: flower_cooldown: 0,
    // rust: flower: None,
    // rust: hive: None,
    // rust: under_water: 0,
    // rust: pollinating: false,
    // rust: validate_hive_cooldown: 0,
    // rust: validate_flower_cooldown: 0,
    // rust: hive_blacklist: Vec::new(),
}
}
}

st :: proc(m: ^Mob) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.bee.get_or_insert_with(Default::default)
}
get :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.bee.as_deref()
}
flag :: proc(m: ^Mob, f: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: get(m).is_some_and(|b| b.flags & f != 0)
}
set_flag :: proc(m: ^Mob, f: u8, value: bool) {
}
    // rust: let b = st(m);
    // rust: if value {
    // rust: b.flags |= f;
    // rust: } else {
    // rust: b.flags &= !f;
}
}
has_nectar :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: flag(m, FLAG_HAS_NECTAR)
}
has_stung :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: flag(m, FLAG_HAS_STUNG)
}
rolling :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: flag(m, FLAG_ROLL)
}
// A client's bee from the server's `DATA_FLAGS_ID` and `DATA_ANGER_END_TIME`
// (the texture and the roll read them).
set_synced :: proc(m: ^Mob, flags: Maybe(u8), anger_end: Maybe(i64)) {
}
    // rust: let b = st(m);
    // rust: if let Some(flags) = flags {
    // rust: b.flags = flags;
}
    // rust: if let Some(anger_end) = anger_end {
    // rust: b.anger_end = anger_end;
}
}
// `Bee.setHasNectar`: nectar resets the time without it.
set_has_nectar :: proc(m: ^Mob, value: bool) {
}
    // rust: if value {
    // rust: st(m).ticks_without_nectar = 0;
}
    // rust: set_flag(m, FLAG_HAS_NECTAR, value);
}
set_has_stung :: proc(m: ^Mob, value: bool) {
}
    // rust: set_flag(m, FLAG_HAS_STUNG, value);
}
pollinating :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.species() == Species::Bee && get(m).is_some_and(|b| b.pollinating)
}
// `BeeLookControl.resetXRotOnTick`: the pitch stays put while pollinating.
set_pollinating :: proc(m: ^Mob, value: bool) {
}
    // rust: st(m).pollinating = value;
    // rust: m.ai.look.kind = if value {
    // rust: LookKind::Fixed
    // rust: } else {
    // rust: LookKind::Default
}
}
// `Mth.nextInt(random, min, max)`.
next_int :: proc(m: ^Mob, min: i32, max: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.random.next_int_between_inclusive(min, max).unwrap_or(min)
}

// `Bee(EntityType, Level)` with `registerGoals` and `createNavigation`.
register :: proc(m: ^Mob) {
}
    // rust: m.ai.mov.kind = MoveKind::Flying {
    // rust: max_turn: 20.0,
    // rust: hovers: true,
}
    // rust: m.ai.nav.kind = NavKind::Flying;
    // rust: m.ai.nav.can_open_doors = false;
    // rust: m.set_required_path_length(48.0);
    // rust: m.set_malus(PathType::Fire, -1.0);
    // rust: m.set_malus(PathType::Water, -1.0);
    // rust: m.set_malus(PathType::WaterBorder, 16.0);
    // rust: m.set_malus(PathType::Cocoa, -1.0);
    // rust: m.set_malus(PathType::Fence, -1.0);
    // rust: let tempt = m.kind.tempt.clone();
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, BeeAttack(MeleeAttack::new(f64::from(1.4_f32), true)));
    // rust: g.add(1, EnterHive);
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(3, Tempt::new(1.25, tempt, false));
    // rust: g.add(3, ValidateHive { last: -1 });
    // rust: g.add(3, ValidateFlower { last: -1 });
    // rust: g.add(4, Pollinate::default());
    // rust: g.add(5, FollowParent::new(1.25));
    // rust: g.add(5, LocateHive);
    // rust: g.add(5, GoToHive::default());
    // rust: g.add(6, GoToKnownFlower::default());
    // rust: g.add(7, GrowCrop);
    // rust: g.add(8, Wander);
    // rust: g.add(9, Float);
    // FloatGoal's constructor lets the navigation float.
    // rust: m.ai.nav.can_float = true;
    // rust: let t = &mut m.ai.targets;
    // rust: t.add(1, HurtByTarget::new().alert().bee());
    // rust: t.add(2, BecomeAngryTarget::new());
    // ResetUniversalAngerTargetGoal only runs with the universalAnger rule.
    // rust: m.extra.bee = Some(Box::default());
    // rust: draw_cooldowns(m);
}
// The random draws of the constructor: the validate goals' cooldowns (built
// in `registerGoals`), then the field initialiser of the flower cooldown.
// The parity probe draws them again once the random is seeded.
draw_cooldowns :: proc(m: ^Mob) {
}
    // rust: let hive = next_int(m, 20, 40);
    // rust: let flower = next_int(m, 20, 40);
    // rust: let locate = next_int(m, 20, 60);
    // rust: let b = st(m);
    // rust: b.validate_hive_cooldown = hive;
    // rust: b.validate_flower_cooldown = flower;
    // rust: b.flower_cooldown = locate;
}

// --- NeutralMob -------------------------------------------------------------

// `NeutralMob.isAngry`.
angry :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: get(m).is_some_and(|b| b.anger_end > 0 && b.anger_end - w.game_time > 0)
}
// `NeutralMob.stopBeingAngry`.
stop_being_angry :: proc(m: ^Mob) {
}
    // rust: m.ai.last_hurt_by = None;
    // rust: m.ai.last_hurt_by_time = m.age as i32;
    // rust: m.ai.target = None;
    // rust: let b = st(m);
    // rust: b.angry_at = None;
    // rust: b.anger_end = -1;
}
// `NeutralMob.playerDied`: the anger at the player who died ends.
forgive_dead_player :: proc(m: ^Mob) {
}
    // rust: if get(m).and_then(|b| b.angry_at) == Some(Who::Player) {
    // rust: stop_being_angry(m);
}
}
// `Bee.startPersistentAngerTimer`: 20 to 39 seconds.
start_anger_timer :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let ticks = next_int(m, 400, 780);
    // rust: st(m).anger_end = w.game_time + i64::from(ticks);
}
valid_player_target :: proc(w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.creative && !p.spectator)
}
// `NeutralMob.updatePersistentAnger(level, false)`.
update_persistent_anger :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let previous = m.ai.target;
    // rust: let angry_at = get(m).and_then(|b| b.angry_at);
    // rust: let dead_mob = |who: Who| match who {
    // rust: Who::Mob(id) => w.seen(id).is_none_or(|s| !s.alive),
    // rust: Who::Player => false,
}
    // rust: if let Some(p) = previous
    // rust: && dead_mob(p)
    // rust: && angry_at == Some(p)
    // rust: {
    // rust: stop_being_angry(m);
    // rust: return;
}
    // rust: if let Some(target) = m.ai.target
    // rust: && angry_at != Some(target)
    // rust: {
    // rust: st(m).angry_at = Some(target);
    // rust: start_anger_timer(m, w);
}
    // rust: if angry_at.is_some() && !angry(m, w) {
    // rust: stop_being_angry(m);
}
    // rust: if angry_at == Some(Who::Player) && !valid_player_target(w) {
    // rust: stop_being_angry(m);
}
}
// `beeCanTarget`: angry and still armed.
can_target :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: angry(m, w) && !has_stung(m)
}

// --- the bee's ticks ----------------------------------------------------------

// `Bee.tick` after `super.tick()`: nectar drips (positions drawn from the
// level's random even on the server), then the roll.
tick :: proc(m: ^Mob, level_random: ^LegacyRandom) {
}
    // rust: if has_nectar(m) && get(m).is_some_and(|b| b.crops_grown < 10) && m.random.next_float() < 0.05 {
    // rust: let mut i = 0;
    // rust: while i < m.random.next_int_bound(2).unwrap_or(0) + 1 {
    // rust: let _ = (level_random.next_double(), level_random.next_double());
    // rust: i += 1;
}
}
    // rust: let roll = rolling(m);
    // rust: let b = st(m);
    // rust: b.roll_o = b.roll;
    // rust: b.roll = if roll {
    // rust: (b.roll + 0.2).min(1.0)
    // rust: } else {
    // rust: (b.roll - 0.24).max(0.0)
}
}
// `Bee.aiStep` after `super.aiStep()`.
ai_step :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let b = st(m);
    // rust: for c in [
    // rust: &mut b.stay_out_of_hive,
    // rust: &mut b.hive_cooldown,
    // rust: &mut b.flower_cooldown,
    // rust: ] {
    // rust: if *c > 0 {
    // rust: *c -= 1;
}
}
    // rust: let close = m
    // rust: .target_info(w)
    // rust: .is_some_and(|t| m.distance_sqr(t.position) < 4.0);
    // rust: let roll = angry(m, w) && !has_stung(m) && close;
    // rust: set_flag(m, FLAG_ROLL, roll);
    // rust: if m.age.is_multiple_of(20) && !hive_valid(m, w) {
    // rust: st(m).hive = None;
}
}
// `Bee.customServerAiStep`: drowning, the sting's slow death, the time
// without nectar and the anger.
server_ai_step :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let stung = has_stung(m);
    // rust: let in_water = m.fluids.in_water;
    // rust: let b = st(m);
    // rust: b.under_water = if in_water { b.under_water + 1 } else { 0 };
    // rust: if b.under_water > 20 {
    // rust: m.damage(1.0, Damage::of(DamageKind::Drown));
}
    // rust: if stung {
    // rust: let b = st(m);
    // rust: b.time_since_sting += 1;
    // rust: let t = b.time_since_sting;
    // rust: if t % 5 == 0
    // rust: && m.random
    // rust: .next_int_bound((1200 - t).clamp(1, 1200))
    // rust: .unwrap_or(1)
    // rust: == 0
    // rust: {
    // rust: let health = m.health;
    // rust: m.damage(health, Damage::of(DamageKind::Generic));
}
}
    // rust: if !has_nectar(m) {
    // rust: st(m).ticks_without_nectar += 1;
}
    // rust: update_persistent_anger(m, cx.w);
}
// `Bee.hurtServer`: a hit ends pollinating.
hurt :: proc(m: ^Mob) {
}
    // rust: set_pollinating(m, false);
}
// `Bee.doHurtTarget`: a sting for the attack damage, poison on normal (10 s)
// and hard (18 s), then the bee has stung and calms down.
sting :: proc(m: ^Mob, who: Who, cx: ^Cx) {
}
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: let amount = (m.attrs.attack_damage as i32) as f32;
    // `Bee.doHurtTarget`: any living target is poisoned when the hit lands,
    // 10 s on normal and 18 s on hard. Easy adds none.
    // rust: let seconds = match cx.w.difficulty.id {
    // rust: 2 => 10,
    // rust: 3 => 18,
    // rust: _ => 0,
}
    // rust: let source = Damage {
    // rust: kind: DamageKind::Sting,
    // rust: attacker: Some(Who::Mob(m.id)),
    // rust: from: Some(from),
    // rust: attacker_species: Some(Species::Bee),
}
    // rust: match who {
    // rust: Who::Player => {
    // rust: cx.events.push(MobEvent::StingPlayer {
    // rust: amount,
    // rust: from,
    // rust: poison_ticks: seconds * 20,
    // rust: });
}
    // rust: Who::Mob(id) if seconds > 0 => cx.events.push(MobEvent::AttackMobWithEffect {
    // rust: target: id,
    // rust: amount,
    // rust: source,
    // rust: effect: "minecraft:poison",
    // rust: ticks: seconds * 20,
    // rust: amplifier: 0,
    // rust: }),
    // rust: Who::Mob(id) => cx.events.push(MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount,
    // rust: source,
    // rust: }),
}
    // rust: set_has_stung(m, true);
    // rust: stop_being_angry(m);
    // rust: if !m.silent {
    // rust: cx.events
    // rust: .push(MobEvent::Sound("entity.bee.sting", from, 1.0, 1.0));
}
}

// --- places -------------------------------------------------------------------

block_pos :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]
}
// `Bee.closerThan`: `Vec3i.closerThan` from the bee's block.
closer_than :: proc(m: ^Mob, p: [i32; 3], dist: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = block_pos(m);
    // rust: let d = |i: usize| f64::from(p[i] - b[i]);
    // rust: d(0) * d(0) + d(1) * d(1) + d(2) * d(2) < f64::from(dist * dist)
}
too_far :: proc(m: ^Mob, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !closer_than(m, p, 48)
}
// `Bee.getBeehiveBlockEntity`: the hive's block entity, unless too far.
    // rust: fn hive_entity<'a>(m: &Mob, w: &'a MobWorld) -> Option<&'a crate::beehive::Beehive> {
    // rust: let h = get(m)?.hive?;
    // rust: if too_far(m, h) {
    // rust: return None;
}
    // rust: match w.world.block_entities.get(&(h[0], h[1], h[2])) {
    // rust: Some(crate::containers::BlockEntity::Beehive(hive)) => Some(hive),
    // rust: _ => None,
}
}
hive_valid :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: hive_entity(m, w).is_some()
}
// `BeehiveBlockEntity.isFireNearby`: fire (not soul fire) next to the hive.
hive_near_fire :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(h) = get(m).and_then(|b| b.hive).filter(|_| hive_valid(m, w)) else {
    // rust: return false;
}
    // rust: (-1..=1).any(|dx| {
    // rust: (-1..=1).any(|dy| {
    // rust: (-1..=1).any(|dz| w.block_name(h[0] + dx, h[1] + dy, h[2] + dz) == "minecraft:fire")
    // rust: })
    // rust: })
}
// `EnvironmentAttributes.BEES_STAY_IN_HIVE`: the overworld's night, or rain.
bees_stay_in_hive :: proc(w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let night = !w.nether && !w.end && (12542..23460).contains(&w.day_time.rem_euclid(24000));
    // rust: night || w.raining
}
tired_of_looking_for_nectar :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: get(m).is_some_and(|b| b.ticks_without_nectar > 3600)
}
// `Bee.wantsToEnterHive`.
wants_to_enter_hive :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(b) = get(m) else { return false };
    // rust: if b.stay_out_of_hive > 0 || b.pollinating || has_stung(m) || m.ai.target.is_some() {
    // rust: return false;
}
    // rust: (has_nectar(m) || tired_of_looking_for_nectar(m) || bees_stay_in_hive(w))
    // rust: && !hive_near_fire(m, w)
}
// `Bee.setHivePos`.
set_hive :: proc(m: ^Mob, hive: Maybe([i32; 3])) {
}
    // rust: st(m).hive = hive;
}
// `Bee.setSavedFlowerPos`.
set_flower :: proc(m: ^Mob, flower: Maybe([i32; 3])) {
}
    // rust: st(m).flower = flower;
}
// `Bee.dropOffNectar`.
drop_off_nectar :: proc(m: ^Mob) {
}
    // rust: set_has_nectar(m, false);
    // rust: st(m).crops_grown = 0;
}
// `Bee.setStayOutOfHiveCountdown`: the bee will not enter a hive for 400
// ticks (the hive passes that when a sedated hive lets its bees out).
set_stay_out_of_hive_countdown :: proc(m: ^Mob) {
}
    // rust: st(m).stay_out_of_hive = 400;
}
drop_hive :: proc(m: ^Mob) {
}
    // rust: let b = st(m);
    // rust: b.hive = None;
    // rust: b.hive_cooldown = 200;
}
drop_flower :: proc(m: ^Mob) {
}
    // rust: st(m).flower = None;
    // rust: let cooldown = next_int(m, 20, 60);
    // rust: st(m).flower_cooldown = cooldown;
}
// `Bee.attractsBees`.
attracts_bees :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let name = w.block_name(p[0], p[1], p[2]);
    // rust: if !w.has_tag("minecraft:bee_attractive", name) {
    // rust: return false;
}
    // rust: if w.prop(p[0], p[1], p[2], "waterlogged") == Some("true") {
    // rust: return false;
}
    // rust: name != "minecraft:sunflower" || w.prop(p[0], p[1], p[2], "half") == Some("upper")
}
// `BlockPos.withinBoxByManhattanDistance`: nearest first by Manhattan
// distance, then x, y, and +z before -z.
manhattan_box :: proc(o: [i32; 3], rx: i32, ry: i32, rz: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::new();
    // rust: for depth in 0..=rx + ry + rz {
    // rust: let max_x = rx.min(depth);
    // rust: for x in -max_x..=max_x {
    // rust: let max_y = ry.min(depth - x.abs());
    // rust: for y in -max_y..=max_y {
    // rust: let z = depth - x.abs() - y.abs();
    // rust: if z <= rz {
    // rust: out.push([o[0] + x, o[1] + y, o[2] + z]);
    // rust: if z != 0 {
    // rust: out.push([o[0] + x, o[1] + y, o[2] - z]);
}
}
}
}
}
    // rust: out
}
// `Bee.pathfindRandomlyTowards`.
pathfind_randomly_towards :: proc(m: ^Mob, w: ^MobWorld, p: [i32; 3]) {
}
    // rust: let target = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]),
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: let here = block_pos(m);
    // rust: let y_delta = target[1] as i32 - here[1];
    // rust: let y_adjust = if y_delta > 2 {
    // rust: 4
    // rust: } else if y_delta < -2 {
    // rust: -4
    // rust: } else {
    // rust: 0
}
    // rust: let dist = (p[0] - here[0]).abs() + (p[1] - here[1]).abs() + (p[2] - here[2]).abs();
    // rust: let (h, v) = if dist < 15 {
    // rust: (dist / 2, dist / 2)
    // rust: } else {
    // rust: (6, 8)
}
    // rust: let max_rad = f64::from((std::f64::consts::PI / 10.0) as f32);
    // rust: if let Some(at) = m.air_random_pos_towards(w, h, v, y_adjust, target, max_rad) {
    // rust: m.ai.nav.max_visited_multiplier = 0.5;
    // rust: m.nav_move_to(w, at, 1.0);
}
}

// --- goals ----------------------------------------------------------------------

// `BaseBeeGoal`: none of these run while the bee is angry.
calm :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !angry(m, w)
}

// `BeeAttackGoal`: a melee attack while angry and armed.
BeeAttack :: struct {
    // rust: impl Goal for BeeAttack {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeeAttackGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_use(m, cx) && can_target(m, cx.w)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(m, cx) && can_target(m, cx.w)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx);
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.every_tick()
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.tick(m, cx);
}
}

// `BeeBecomeAngryTargetGoal`: the player it is angry at, while armed.
BecomeAngryTarget :: struct {
    // rust: impl BecomeAngryTarget {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(
    NearestTarget: :player(true),
    // rust: .interval(10)
    // rust: .gate(can_target)
                // NeutralMob.isAngryAt: the persistent anger target.
    // rust: .when(|m, _| get(m).is_some_and(|b| b.angry_at == Some(Who::Player))),
    // rust: )
}
}
    // rust: impl Goal for BecomeAngryTarget {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeeBecomeAngryTargetGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: can_target(m, cx.w) && m.ai.target.is_some() && self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx);
}
}

// `BeeEnterHiveGoal`: into the hive beside it, or forget it when full.
EnterHive :: struct {
    // rust: impl Goal for EnterHive {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeeEnterHiveGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let close = get(m).and_then(|b| b.hive).is_some_and(|h| {
    // rust: let d = |i: usize, v: f64| f64::from(h[i]) + 0.5 - v;
    // rust: let (x, y, z) = (d(0, m.position.x), d(1, m.position.y), d(2, m.position.z));
    // rust: x * x + y * y + z * z < 4.0
    // rust: });
    // rust: let mut enter = false;
    // rust: if close && wants_to_enter_hive(m, cx.w) {
    // rust: match hive_entity(m, cx.w).map(|h| h.full()) {
    // rust: Some(false) => enter = true,
    // rust: Some(true) => st(m).hive = None,
    // rust: None => {}
}
}
    // rust: enter && calm(m, cx.w)
}
can_continue :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(hive) = get(m).and_then(|b| b.hive).filter(|_| hive_valid(m, cx.w)) {
    // rust: cx.events.push(MobEvent::EnterHive { mob: m.id, hive });
}
}
}

// `ValidateHiveGoal`: now and then, forget a hive that is gone.
ValidateHive :: struct {
    last: i64,
}
    // rust: impl Goal for ValidateHive {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "ValidateHiveGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let cooldown = get(m).map_or(0, |b| b.validate_hive_cooldown);
    // rust: cx.w.game_time > self.last + i64::from(cooldown) && calm(m, cx.w)
}
can_continue :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(h) = get(m).and_then(|b| b.hive)
    // rust: && cx.w.world.loaded(h[0], h[2])
    // rust: && !hive_valid(m, cx.w)
    // rust: {
    // rust: drop_hive(m);
}
    // rust: self.last = cx.w.game_time;
}
}

// `ValidateFlowerGoal`: now and then, forget a flower that is gone.
ValidateFlower :: struct {
    last: i64,
}
    // rust: impl Goal for ValidateFlower {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "ValidateFlowerGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let cooldown = get(m).map_or(0, |b| b.validate_flower_cooldown);
    // rust: cx.w.game_time > self.last + i64::from(cooldown) && calm(m, cx.w)
}
can_continue :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(f) = get(m).and_then(|b| b.flower)
    // rust: && cx.w.world.loaded(f[0], f[2])
    // rust: && !attracts_bees(cx.w, f)
    // rust: {
    // rust: drop_flower(m);
}
    // rust: self.last = cx.w.game_time;
}
}

// `BeePollinateGoal`: fly to a flower within five blocks and hover about
// over it; after 400 ticks there the bee carries nectar.
Pollinate :: struct {
    successful: i32,
    last_sound: i32,
    hover: Option<[f64,
    ticks: i32,
    // `unreachableFlowerCache`: flowers and the game time until which they
    // count as out of reach.
    unreachable: HashMap<[i32,
}
    // rust: impl Pollinate {
long_enough :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.successful > 400
}
    // `findNearbyFlower`: the first reachable flower, nearest first.
find_flower :: proc(self: ^Self, m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut cache = HashMap::new();
    // rust: let mut found = None;
    // rust: for p in manhattan_box(block_pos(m), 5, 5, 5) {
    // rust: if !attracts_bees(w, p) {
    // rust: continue;
}
    // rust: let until = self.unreachable.get(&p).copied().unwrap_or(i64::MIN);
    // rust: if w.game_time < until {
    // rust: cache.insert(p, until);
    // rust: continue;
}
    // rust: if m.create_path_to(w, p, 1).is_some_and(|path| path.reached) {
    // rust: found = Some(p);
    // rust: break;
}
    // rust: cache.insert(p, w.game_time + 600);
}
    // rust: self.unreachable = cache;
    // rust: found
}
set_wanted :: proc(self: ^Self, m: ^Mob) {
}
    // rust: if let Some(h) = self.hover {
    // rust: m.ai.mov.set_wanted(h[0], h[1], h[2], f64::from(0.35_f32));
}
}
offset :: proc(m: ^Mob) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from((m.random.next_float() * 2.0 - 1.0) * 0.333_333_34)
}
}
    // rust: impl Goal for Pollinate {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeePollinateGoal"
}
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
    // rust: let usable =
    // rust: if get(m).is_some_and(|b| b.flower_cooldown > 0) || has_nectar(m) || cx.w.raining {
    // rust: false
    // rust: } else if let Some(p) = self.find_flower(m, cx.w) {
    // rust: st(m).flower = Some(p);
    // rust: let at = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: m.nav_move_to(cx.w, at, f64::from(1.2_f32));
    // rust: true
    // rust: } else {
    // rust: let cooldown = next_int(m, 20, 60);
    // rust: st(m).flower_cooldown = cooldown;
    // rust: false
}
    // rust: usable && calm(m, cx.w)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let go = if !pollinating(m) || get(m).is_none_or(|b| b.flower.is_none()) || cx.w.raining {
    // rust: false
    // rust: } else if self.long_enough() {
    // rust: m.random.next_float() < 0.2
    // rust: } else {
    // rust: true
}
    // rust: go && calm(m, cx.w)
}
start :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: self.successful = 0;
    // rust: self.ticks = 0;
    // rust: self.last_sound = 0;
    // rust: set_pollinating(m, true);
    // rust: st(m).ticks_without_nectar = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: if self.long_enough() {
    // rust: set_has_nectar(m, true);
}
    // rust: set_pollinating(m, false);
    // rust: m.nav_stop();
    // rust: st(m).flower_cooldown = 200;
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: let Some(f) = get(m).and_then(|b| b.flower) else {
    // rust: return;
}
    // rust: self.ticks += 1;
    // rust: if self.ticks > 600 {
    // rust: drop_flower(m);
    // rust: set_pollinating(m, false);
    // rust: st(m).flower_cooldown = 200;
    // rust: return;
}
    // rust: let flower = [
    // rust: f64::from(f[0]) + 0.5,
    // rust: f64::from(f[1]) + f64::from(0.6_f32),
    // rust: f64::from(f[2]) + 0.5,
    // rust: ];
    // rust: if m.distance_to(flower) > 1.0 {
    // rust: self.hover = Some(flower);
    // rust: self.set_wanted(m);
    // rust: return;
}
    // rust: let hover = *self.hover.get_or_insert(flower);
    // rust: let arrived = m.distance_to(hover) <= 0.1;
    // rust: if !arrived && self.ticks > 600 {
    // rust: drop_flower(m);
    // rust: return;
}
    // rust: let mut set_wanted = true;
    // rust: if arrived {
    // rust: if m.random.next_int_bound(25).unwrap_or(1) == 0 {
    // rust: let x = flower[0] + Self::offset(m);
    // rust: let z = flower[2] + Self::offset(m);
    // rust: self.hover = Some([x, flower[1], z]);
    // rust: m.nav_stop();
    // rust: } else {
    // rust: set_wanted = false;
}
    // rust: m.look_at(flower);
}
    // rust: if set_wanted {
    // rust: self.set_wanted(m);
}
    // rust: self.successful += 1;
    // rust: if m.random.next_float() < 0.05 && self.successful > self.last_sound + 60 {
    // rust: self.last_sound = self.successful;
    // rust: if !m.silent {
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: m.outbox
    // rust: .push(MobEvent::Sound("entity.bee.pollinate", at, 1.0, 1.0));
}
}
}
}

// `BeeLocateHiveGoal`: the nearest bee home with room within 20 blocks,
// skipping the ones `BeeGoToHiveGoal` gave up on (unless that is all).
LocateHive :: struct {
    // rust: impl Goal for LocateHive {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeeLocateHiveGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = get(m);
    // rust: let usable = b.is_some_and(|b| b.hive_cooldown == 0 && b.hive.is_none())
    // rust: && wants_to_enter_hive(m, cx.w);
    // rust: usable && calm(m, cx.w)
}
can_continue :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: st(m).hive_cooldown = 200;
    // rust: let hives = hives_with_space(m, cx.w);
    // rust: let b = st(m);
    // rust: let pick = hives
    // rust: .iter()
    // rust: .find(|h| !b.hive_blacklist.contains(h))
    // rust: .copied();
    // rust: if pick.is_none() && !hives.is_empty() {
    // rust: b.hive_blacklist.clear();
}
    // rust: b.hive = pick.or_else(|| hives.first().copied()).or(b.hive);
}
}

// `findNearbyHivesWithSpace`: the bee homes (`PoiTypeTags.BEE_HOME`)
// within 20 blocks whose hive has room, nearest first.
hives_with_space :: proc(m: ^Mob, w: ^MobWorld) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let here = block_pos(m);
    // rust: let dist = |p: &[i32; 3]| {
    // rust: let d = |i: usize| i64::from(p[i] - here[i]);
    // rust: d(0) * d(0) + d(1) * d(1) + d(2) * d(2)
}
    // rust: let mut hives: Vec<[i32; 3]> = w
    // rust: .world
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter_map(|(&(x, y, z), e)| match e {
    // rust: crate::containers::BlockEntity::Beehive(h) if !h.full() => Some([x, y, z]),
    // rust: _ => None,
    // rust: })
    // rust: .filter(|p| {
    // rust: dist(p) <= 20 * 20 && w.has_tag("minecraft:beehives", w.block_name(p[0], p[1], p[2]))
    // rust: })
    // rust: .collect();
    // rust: hives.sort_by_key(|p| (dist(p), *p));
    // rust: hives
}

// `BeeGoToHiveGoal`: home when it wants to go in.
GoToHive :: struct {
    travelling: i32,
    last_path: Maybe(super::path::Path),
    stuck: i32,
}
    // rust: impl GoToHive {
reached :: proc(m: ^Mob, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: closer_than(m, p, 2)
    // rust: || m.ai
    // rust: .nav
    // rust: .path
    // rust: .as_ref()
    // rust: .is_some_and(|path| path.target == p && path.reached && path.is_done())
}
drop_and_blacklist :: proc(self: ^Self, m: ^Mob) {
}
    // rust: let b = st(m);
    // rust: if let Some(h) = b.hive {
    // rust: b.hive_blacklist.push(h);
    // rust: while b.hive_blacklist.len() > 3 {
    // rust: b.hive_blacklist.remove(0);
}
}
    // rust: drop_hive(m);
}
pathfind_directly :: proc(m: ^Mob, w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let close_enough = if closer_than(m, p, 3) { 1 } else { 2 };
    // rust: m.ai.nav.max_visited_multiplier = 10.0;
    // rust: let path = m.create_path_to(w, p, close_enough);
    // rust: m.nav_move_to_path(w, path, 1.0);
    // rust: m.ai.nav.path.as_ref().is_some_and(|path| path.reached)
}
}
    // rust: impl Goal for GoToHive {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeeGoToHiveGoal"
}
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
    // rust: let usable = get(m).and_then(|b| b.hive).is_some_and(|h| {
    // rust: !too_far(m, h)
    // rust: && m.ai.home.is_none()
    // rust: && wants_to_enter_hive(m, cx.w)
    // rust: && !Self::reached(m, h)
    // rust: && cx
    // rust: .w
    // rust: .has_tag("minecraft:beehives", cx.w.block_name(h[0], h[1], h[2]))
    // rust: });
    // rust: usable && calm(m, cx.w)
}
start :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) {
}
    // rust: self.travelling = 0;
    // rust: self.stuck = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: self.travelling = 0;
    // rust: self.stuck = 0;
    // rust: m.nav_stop();
    // rust: m.ai.nav.max_visited_multiplier = 1.0;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(h) = get(m).and_then(|b| b.hive) else {
    // rust: return;
}
    // rust: self.travelling += 1;
    // rust: if self.travelling > reduced(2400) {
    // rust: self.drop_and_blacklist(m);
    // rust: } else if !m.ai.nav.is_in_progress() {
    // rust: if !closer_than(m, h, 16) {
    // rust: if too_far(m, h) {
    // rust: drop_hive(m);
    // rust: } else {
    // rust: pathfind_randomly_towards(m, cx.w, h);
}
    // rust: } else if !Self::pathfind_directly(m, cx.w, h) {
    // rust: self.drop_and_blacklist(m);
    // rust: } else if let Some(last) = &self.last_path
    // rust: && m.ai
    // rust: .nav
    // rust: .path
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.same_as(Some(last)))
    // rust: {
    // rust: self.stuck += 1;
    // rust: if self.stuck > 60 {
    // rust: drop_hive(m);
    // rust: self.stuck = 0;
}
    // rust: } else {
    // rust: self.last_path = m.ai.nav.path.clone();
}
}
}
}

// `BeeGoToKnownFlowerGoal`: back to the remembered flower after 600 ticks
// without nectar.
GoToKnownFlower :: struct {
    travelling: i32,
}
    // rust: impl Goal for GoToKnownFlower {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeeGoToKnownFlowerGoal"
}
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
    // rust: let usable = get(m).is_some_and(|b| {
    // rust: b.flower.is_some_and(|f| {
    // rust: m.ai.home.is_none() && b.ticks_without_nectar > 600 && !closer_than(m, f, 2)
    // rust: })
    // rust: });
    // rust: usable && calm(m, cx.w)
}
start :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) {
}
    // rust: self.travelling = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) {
}
    // rust: self.travelling = 0;
    // rust: m.nav_stop();
    // rust: m.ai.nav.max_visited_multiplier = 1.0;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(f) = get(m).and_then(|b| b.flower) else {
    // rust: return;
}
    // rust: self.travelling += 1;
    // rust: if self.travelling > reduced(2400) {
    // rust: drop_flower(m);
    // rust: } else if !m.ai.nav.is_in_progress() {
    // rust: if too_far(m, f) {
    // rust: drop_flower(m);
    // rust: } else {
    // rust: pathfind_randomly_towards(m, cx.w, f);
}
}
}
}

// `BeeGrowCropGoal`: a bee with nectar and a hive grows crops below it.
GrowCrop :: struct {
    // rust: impl Goal for GrowCrop {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeeGrowCropGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // The 0.3 roll comes only after the crop count: it draws randomness.
    // rust: let usable = get(m).is_none_or(|b| b.crops_grown < 10)
    // rust: && m.random.next_float() >= 0.3
    // rust: && has_nectar(m)
    // rust: && hive_valid(m, cx.w);
    // rust: usable && calm(m, cx.w)
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if m.random.next_int_bound(reduced(30)).unwrap_or(1) != 0 {
    // rust: return;
}
    // rust: let here = block_pos(m);
    // rust: for i in 1..=2 {
    // rust: let p = [here[0], here[1] - i, here[2]];
    // rust: if let Some(state) = grown(cx.w, p) {
    // rust: cx.events.push(MobEvent::SetBlock { pos: p, state });
    // rust: st(m).crops_grown += 1;
}
}
}
}
// The state a bee grows a `bee_growables` block to, if it can grow.
grown :: proc(w: ^MobWorld, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = w.block_name(p[0], p[1], p[2]);
    // rust: if !w.has_tag("minecraft:bee_growables", name) {
    // rust: return None;
}
    // rust: let state = w.registry.state(w.world.block(p[0], p[1], p[2]))?;
    // rust: let (key, max) = match name {
    // rust: "minecraft:beetroots" => ("age", 3),
        // TorchflowerCropBlock.getStateForAge(2): the flower itself.
    // rust: "minecraft:torchflower_crop" => {
    // rust: let age: i32 = state.properties.get("age")?.parse().ok()?;
    // rust: return if age + 1 >= 2 {
    // rust: w.registry.default_state("minecraft:torchflower")
    // rust: } else {
    // rust: let mut s = state.clone();
    // rust: s.properties.insert("age".into(), (age + 1).to_string());
    // rust: w.registry.id(&s)
}
}
    // rust: "minecraft:wheat" | "minecraft:carrots" | "minecraft:potatoes" => ("age", 7),
    // rust: "minecraft:melon_stem" | "minecraft:pumpkin_stem" => ("age", 7),
    // rust: "minecraft:sweet_berry_bush" => ("age", 3),
        // CaveVinesBlock.performBonemeal: berries.
    // rust: "minecraft:cave_vines" | "minecraft:cave_vines_plant" => {
    // rust: if state.properties.get("berries").map(String::as_str) == Some("true") {
    // rust: return None;
}
    // rust: let mut s = state.clone();
    // rust: s.properties.insert("berries".into(), "true".into());
    // rust: return w.registry.id(&s);
}
    // rust: _ => return None,
}
    // rust: let age: i32 = state.properties.get(key)?.parse().ok()?;
    // rust: if age >= max {
    // rust: return None;
}
    // rust: let mut s = state.clone();
    // rust: s.properties.insert(key.into(), (age + 1).to_string());
    // rust: w.registry.id(&s)
}

// `BeeWanderGoal`: hover to a random spot ahead (or back towards a far hive).
Wander :: struct {
    // rust: impl Goal for Wander {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "BeeWanderGoal"
}
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
    // rust: m.ai.nav.is_done() && m.random.next_int_bound(10).unwrap_or(1) == 0
}
can_continue :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.nav.is_in_progress()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
        // Back towards a valid hive farther than 24 blocks, else ahead.
    // rust: let far_hive = get(m)
    // rust: .and_then(|b| b.hive)
    // rust: .filter(|&h| hive_valid(m, cx.w) && !closer_than(m, h, 24));
    // rust: let dir = match far_hive {
    // rust: Some(h) => {
    // rust: let v = [
    // rust: f64::from(h[0]) + 0.5 - m.position.x,
    // rust: f64::from(h[1]) + 0.5 - m.position.y,
    // rust: f64::from(h[2]) + 0.5 - m.position.z,
    // rust: ];
                // Vec3.normalize.
    // rust: let len = (v[0] * v[0] + v[1] * v[1] + v[2] * v[2]).sqrt();
    // rust: if len < 1.0E-5 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: v.map(|c| c / len)
}
}
    // rust: None => m.view_vector(),
}
    // rust: let max_rad = f64::from(std::f32::consts::FRAC_PI_2);
    // rust: let at = m
    // rust: .hover_random_pos(cx.w, 8, 7, dir[0], dir[2], max_rad, 3, 1)
    // rust: .or_else(|| m.air_and_water_random_pos(cx.w, 8, 4, -2, dir[0], dir[2]));
    // rust: if let Some(at) = at {
    // rust: let p = [
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: let path = m.create_path_to(cx.w, p, 1);
    // rust: m.nav_move_to_path(cx.w, path, 1.0);
}
}
}

// `FlyingPathNavigation.isStableDestination` for bees: anything above
// something not air.
stable_destination :: proc(w: ^MobWorld, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !w.facts.is_air(w.world.block(p[0], p[1] - 1, p[2]))
}
// `Bee.addAdditionalSaveData` (and NeutralMob's `anger_end_time`).
to_nbt :: proc(m: ^Mob, map: ^horizon_world::nbt::Compound) {
}
//     use horizon_world::nbt::Tag;
    // rust: let b = get(m).cloned().unwrap_or_default();
    // rust: for (key, pos) in [("hive_pos", b.hive), ("flower_pos", b.flower)] {
    // rust: match pos {
    // rust: Some(p) => {
    // rust: map.insert(key.into(), Tag::IntArray(p.to_vec()));
}
    // rust: None => {
    // rust: map.remove(&key.into());
}
}
}
    // rust: map.insert("HasNectar".into(), Tag::Byte(i8::from(has_nectar(m))));
    // rust: map.insert("HasStung".into(), Tag::Byte(i8::from(has_stung(m))));
    // rust: map.insert(
    // rust: "TicksSincePollination".into(),
    // rust: Tag::Int(b.ticks_without_nectar),
    // rust: );
    // rust: map.insert("CannotEnterHiveTicks".into(), Tag::Int(b.stay_out_of_hive));
    // rust: map.insert("CropsGrownSincePollination".into(), Tag::Int(b.crops_grown));
    // rust: map.insert("anger_end_time".into(), Tag::Long(b.anger_end));
}
// `Bee.readAdditionalSaveData`.
from_nbt :: proc(m: ^Mob, tag: ^horizon_world::nbt::Tag) {
}
//     use horizon_world::nbt::Tag;
    // rust: let int = |k: &str| match tag.get(k) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: Some(Tag::Byte(v)) => Some(i32::from(*v)),
    // rust: _ => None,
}
    // rust: let pos = |k: &str| match tag.get(k) {
    // rust: Some(Tag::IntArray(p)) if p.len() == 3 => Some([p[0], p[1], p[2]]),
    // rust: _ => None,
}
    // rust: set_has_nectar(m, int("HasNectar").unwrap_or(0) != 0);
    // rust: set_has_stung(m, int("HasStung").unwrap_or(0) != 0);
    // rust: let anger_end = match tag.get("anger_end_time") {
    // rust: Some(Tag::Long(v)) => *v,
    // rust: _ => -1,
}
    // rust: let b = st(m);
    // rust: b.ticks_without_nectar = int("TicksSincePollination").unwrap_or(0);
    // rust: b.stay_out_of_hive = int("CannotEnterHiveTicks").unwrap_or(0);
    // rust: b.crops_grown = int("CropsGrownSincePollination").unwrap_or(0);
    // rust: b.hive = pos("hive_pos");
    // rust: b.flower = pos("flower_pos");
    // rust: b.anger_end = anger_end;
}

    // rust: mod tests {
//     use super::sting;
//     use crate::mobs::goals::Cx;
//     use crate::mobs::world::with_test_world;
//     use crate::mobs::{Mob, MobEvent, Species, Who, sensor_scan_tests::kind};
//     use horizon_core::geometry::Vec3;
//     use horizon_core::random::LegacyRandom;

bee :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:bee".into();
    // rust: k.species = Species::Bee;
    // rust: k.attack_damage = 2.0;
    // rust: Mob::new(3, kind, Vec3::ZERO, 0.0)
}

    // `Bee.doHurtTarget` on Normal: a mob is poisoned for 10 seconds (200 ticks).
a_bee_sting_poisons_a_mob_for_ten_seconds_on_normal :: proc() {
}
    // rust: with_test_world(&[], |w, _| {
    // rust: let mut m = bee();
    // rust: let mut events = Vec::new();
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut random,
    // rust: events: &mut events,
}
    // rust: sting(&mut m, Who::Mob(9), &mut cx);
    // rust: assert!(events.iter().any(|e| matches!(
    // rust: e,
    // rust: MobEvent::AttackMobWithEffect {
    // rust: target: 9,
    // rust: effect: "minecraft:poison",
    // rust: ticks: 200,
    // rust: amplifier: 0,
    // rust: ..
}
    // rust: )));
    // rust: });
}
}
