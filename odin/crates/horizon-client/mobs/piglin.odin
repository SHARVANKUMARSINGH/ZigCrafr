//! Transpiled from Horizon Rust crate
package horizon_client_piglin

import "core:fmt"
import "core:mem"
import "core:math"

// Piglins, piglin brutes, hoglins and zoglins: gold-wearing players are
// left alone, gold is admired and bartered, piglins and hoglins zombify
// outside the Nether, hoglins headbutt their targets into the air.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Seen, Species, Who,
    // rust: anim::{Poses, State},
    // rust: brain::{Ttl, living_near},
    // rust: goals::{
    // rust: Cx, Float, Goal, HurtByTarget, LOOK, LookAtPlayer, MOVE, MeleeAttack, NearestTarget, Prey,
    // rust: RandomLookAround, Stroll, TARGET, TargetState, goal_clone, target_continue,
    // rust: },
}
// use horizon_core::geometry::{Vec3, trig::Mth};
// use horizon_core::random::{LegacyRandom, RandomSource};
// use std::f32::consts::PI;

// `PiglinAi.ADMIRE_DURATION`.
ADMIRE :: 119
// `PiglinAi.eat`: the `ATE_RECENTLY` memory lasts 200 ticks (kept in
// `extra.ints[0]` of a piglin).
ATE_RECENTLY :: 200
// `AbstractPiglin.CONVERSION_TIME` (and the hoglin's).
CONVERSION :: 300
// `PiglinAi.CELEBRATION_TIME`: how long the `CELEBRATE_LOCATION` and
// `DANCING` memories last.
CELEBRATION :: 300

// `Activity`: what a piglin's or hoglin's brain is busy with. `Admire`,
// `Celebrate` and `Ride` are a piglin's only; the others are both.
Activity :: enum {
    Idle,
    Fight,
    Avoid,
    Admire,
    Celebrate,
    Ride,
}
// `MemoryModuleType.AVOID_TARGET`: who to keep away from, where it was last
// seen (a target that is gone leaves its spot behind) and when the memory
// expires.
AvoidTarget :: struct {
    who: Who,
    at: Vec3,
    ttl: Ttl,
}
// `MemoryModuleType.RIDE_TARGET`: the mob a baby piglin means to ride, when
// the memory expires and the block the walk to it was last aimed at.
RideTarget :: struct {
    vehicle: u32,
    ttl: Ttl,
    aimed: Option<[i32,
}
// What a piglin's or hoglin's brain remembers of its surroundings and of
// what it retreats from. Most have no codec; live guarded anger below is saved.
Memories :: struct {
    // The guarded-block event owns the saved ANGRY_AT entry once set.
    // Outer None leaves unmodeled loaded memory alone; Some(None) has no
    // authoritative actor identity and clears stale raw data instead of inventing one.
    // Its remaining TTL is the existing `Extra::anger` counter.
    guarded_angry_at: Option<Option<[i32,
    // `AVOID_TARGET`.
    avoid: Maybe(AvoidTarget),
    // `RIDE_TARGET`.
    ride: Maybe(RideTarget),
    // A piglin's `HURT_BY` is set: the `HurtBySensor` saw damage taken
    // within the last 40 ticks.
    hurt: bool,
    // A piglin's `NEAREST_VISIBLE_BABY_HOGLIN`.
    baby_hoglin: Maybe(u32),
    // `SetEntityLookTargetSometimes.Ticker.ticksUntilNextStart` of
    // `babySometimesRideBabyHoglin`.
    ride_wait: i32,
    // `Brain.getActiveNonCoreActivity` as `updateActivity` last left it.
    activity: Activity,
    // The `last_hurt_by_time` of the hit `wasHurtBy` last reacted to.
    hurt_seen: i32,
    // `VISIBLE_ADULT_PIGLIN_COUNT`: a piglin's counts its brutes too, a
    // hoglin's only the piglins.
    piglins: i32,
    // `VISIBLE_ADULT_HOGLIN_COUNT`.
    hoglins: i32,
    // A hoglin's `NEAREST_VISIBLE_ADULT_PIGLIN`.
    nearest_piglin: Maybe(u32),
    // A hoglin's `NEAREST_VISIBLE_ADULT_HOGLINS` and a piglin's
    // `NEAREST_VISIBLE_ADULT_PIGLINS` (brutes too), nearest first.
    adults: [dynamic]u32,
    // A piglin's `NEAREST_VISIBLE_ZOMBIFIED`.
    zombified: Maybe(Who),
    // A piglin's `NEAREST_VISIBLE_NEMESIS`: a wither skeleton or a wither.
    nemesis: Maybe(Who),
    // A piglin's `NEAREST_PLAYER_HOLDING_WANTED_ITEM` is set.
    sees_loved: bool,
    // Retreats other mobs' `broadcastRetreat` asked of this one, which its
    // next tick starts with: who to retreat from and where it stands.
    retreats: Vec<(Who,
    // The spear behaviours' memories (`SPEAR_STATUS`...).
    spear: super::spear_use::Memories,
    // `ADMIRING_ITEM` set by `StartAdmiringItemIfSeen` (nothing in the off
    // hand yet): the ticks left before it expires.
    seen_admire: i32,
    // `TIME_TRYING_TO_REACH_ADMIRE_ITEM`, when present.
    reach_time: Maybe(i32),
    // `DISABLE_WALK_TO_ADMIRE_ITEM`: the ticks left.
    walk_off: i32,
    // `ADMIRING_DISABLED`: the ticks left.
    admire_disabled: i32,
}
// Existing guarded-block anger, with the causal player's authoritative UUID.
// This adds identity only; targeting and countdown keep their existing policy.
set_guarded_anger_target :: proc(m: ^Mob, player: Maybe([i32; 4])) {
}
    // rust: m.extra.anger = 600;
    // rust: m.ai.target = Some(Who::Player);
    // rust: m.extra.piglin.guarded_angry_at = Some(player);
}

    // rust: impl Memories {
    // `StartAdmiringItemIfSeen.create(119)` (core activity) and the admire
    // activity's `StopAdmiringIfItemTooFarAway(9)` and
    // `StopAdmiringIfTiredOfTryingToReachItem(200, 200)`, from the distance
    // squared to `NEAREST_VISIBLE_WANTED_ITEM` and whether that item is loved.
    // `holding`: the off hand is not empty, which both stop behaviours check.
admire_seen :: proc(self: ^Self, holding: bool, nearest: Maybe(f64), loved: bool) {
}
    // rust: let absent = self.seen_admire == 0;
    // rust: if !absent && !holding {
    // rust: match nearest {
    // rust: Some(d) if d < 81.0 => match self.reach_time {
    // rust: None => self.reach_time = Some(0),
    // rust: Some(t) if t > 200 => {
    // rust: self.seen_admire = 0;
    // rust: self.reach_time = None;
    // rust: self.walk_off = 200;
}
    // rust: Some(t) => self.reach_time = Some(t + 1),
    // rust: },
    // rust: _ => self.seen_admire = 0,
}
}
    // rust: if absent && loved && self.admire_disabled == 0 && self.walk_off == 0 {
    // rust: self.seen_admire = ADMIRE;
}
}
}
// `Sensor.isEntityTargetable`: `TargetingConditions.forNonCombat()` within
// the follow range and in sight, which a `NearestVisibleLivingEntities`
// applies to every entity it lists.
visible :: proc(m: ^Mob, w: ^MobWorld, who: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let range = m.attrs.follow_range;
    // rust: match who {
    // rust: Who::Player => {
    // rust: let Some(p) = &w.player else { return false };
    // rust: let r = (range * p.visibility_percent(Some(m.kind.id.as_str()), w.items)).max(2.0);
    // rust: p.alive && !p.spectator && m.distance_sqr(p.position) <= r * r && m.sees(w, who)
}
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: s.alive && m.distance_sqr(s.position) <= range * range && m.sees(w, who)
}
}
}
// `PiglinAi.isPlayerHoldingLovedItem`: gold or anything else in
// `#piglin_loved`, in either hand.
holds_loved :: proc(w: ^MobWorld, p: ^super::PlayerView) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(tag) = w
    // rust: .items
    // rust: .and_then(|i| i.item_tags.get("minecraft:piglin_loved"))
    // rust: else {
    // rust: return false;
}
    // rust: [&p.main_hand, &p.off_hand]
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .any(|item| tag.contains(&**item))
}
// `HoglinSpecificSensor.doTick`: the adult piglins and hoglins in sight,
// counted, with the nearest piglin and the hoglins themselves. (The sensor
// also looks up the nearest repellent; `hoglin_repellent` does that.)
hoglin_sense :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let mut piglins = 0;
    // rust: let mut nearest = None;
    // rust: let mut hoglins = Vec::new();
    // rust: for who in living_near(m, w) {
    // rust: let Who::Mob(id) = who else { continue };
    // rust: let Some(s) = w.seen(id) else { continue };
    // rust: if s.baby || !matches!(s.species, Species::Piglin | Species::Hoglin) || !visible(m, w, who)
    // rust: {
    // rust: continue;
}
    // rust: if s.species == Species::Piglin {
    // rust: piglins += 1;
    // rust: nearest = nearest.or(Some(id));
    // rust: } else {
    // rust: hoglins.push(id);
}
}
    // rust: let b = &mut m.extra.piglin;
    // rust: b.piglins = piglins;
    // rust: b.hoglins = hoglins.len() as i32;
    // rust: b.nearest_piglin = nearest;
    // rust: b.adults = hoglins;
}
// `PiglinSpecificSensor.doTick`: what a piglin sees: adult piglins (brutes
// too) and hoglins counted, the nearest baby hoglin, the nearest zombified
// piglin or zoglin, the nearest wither skeleton or wither, and a player
// holding gold.
piglin_sense :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let mut adults = Vec::new();
    // rust: let mut hoglins = 0;
    // rust: let mut baby_hoglin = None;
    // rust: let mut zombified = None;
    // rust: let mut nemesis = None;
    // rust: let mut loved = false;
    // rust: for who in living_near(m, w) {
    // rust: match who {
    // rust: Who::Player => {
    // rust: if !loved
    // rust: && w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| !p.spectator && holds_loved(w, p))
    // rust: && visible(m, w, who)
    // rust: {
    // rust: loved = true;
}
}
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { continue };
    // rust: let (species, baby) = (s.species, s.baby);
    // rust: match species {
    // rust: Species::Hoglin if baby && baby_hoglin.is_none() && visible(m, w, who) => {
    // rust: baby_hoglin = Some(id);
}
    // rust: Species::Hoglin if !baby && visible(m, w, who) => {
    // rust: hoglins += 1;
}
    // rust: Species::Piglin | Species::PiglinBrute if !baby && visible(m, w, who) => {
    // rust: adults.push(id);
}
    // rust: Species::WitherSkeleton | Species::Wither
    // rust: if nemesis.is_none() && visible(m, w, who) =>
    // rust: {
    // rust: nemesis = Some(who);
}
    // rust: Species::ZombifiedPiglin | Species::Zoglin
    // rust: if zombified.is_none() && visible(m, w, who) =>
    // rust: {
    // rust: zombified = Some(who);
}
    // rust: _ => {}
}
}
}
}
    // `HurtBySensor.doTick`, on the piglin sensor's schedule: damage is
    // forgotten 40 ticks after it was taken.
    // rust: let age = i64::from(m.age);
    // rust: let hurt = m.last_damage.as_ref().is_some_and(|(_, at)| age - at <= 40);
    // rust: let b = &mut m.extra.piglin;
    // rust: b.hurt = hurt;
    // rust: b.piglins = adults.len() as i32;
    // rust: b.adults = adults;
    // rust: b.hoglins = hoglins;
    // rust: b.baby_hoglin = baby_hoglin;
    // rust: b.zombified = zombified;
    // rust: b.nemesis = nemesis;
    // rust: b.sees_loved = loved;
}
// `Brain.setActiveActivityToFirstValid`: the first valid activity of a
// piglin's list (admiring, fighting, avoiding, celebrating, riding, idle), of
// a brute's (fighting, idle) or of a hoglin's (fighting, avoiding, idle). An
// activity is valid while the memory it requires is there.
activity :: proc(m: ^Mob) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let b = &m.extra.piglin;
    // rust: let piglin = m.species() == Species::Piglin;
    // `ADMIRING_ITEM`: a gold item in the off hand being admired (a charging
    // crossbow counts `using_item` up too), or one `StartAdmiringItemIfSeen`
    // saw lying around.
    // rust: if piglin && ((m.extra.off_hand.is_some() && m.extra.using_item > 0) || b.seen_admire > 0) {
    // rust: Activity::Admire
    // rust: } else if m.ai.target.is_some() {
    // rust: Activity::Fight
    // rust: } else if b.avoid.is_some() {
    // rust: Activity::Avoid
    // rust: } else if piglin && m.extra.scratch[1] > 0 && m.extra.home.is_some() {
    // rust: Activity::Celebrate
    // rust: } else if piglin && b.ride.is_some() {
    // rust: Activity::Ride
    // rust: } else {
    // rust: Activity::Idle
}
}
// `Brain.forgetOutdatedMemories`: the avoid and ride targets expire (the
// avoid target keeps track of where it stands), then come the core
// activity's copies into the avoid target, the retreat activity's
// `EraseMemoryIf` and `updateActivity`, at the end of `customServerAiStep`'s
// brain.
brain_step :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let expired = match m.extra.piglin.avoid.as_mut() {
    // rust: Some(a) => {
    // rust: a.ttl.tick();
    // rust: !a.ttl.present()
}
    // rust: None => false,
}
    // rust: if expired {
    // rust: m.extra.piglin.avoid = None;
}
    // `RIDE_TARGET` expires the same way.
    // rust: let ride_expired = match m.extra.piglin.ride.as_mut() {
    // rust: Some(r) => {
    // rust: r.ttl.tick();
    // rust: !r.ttl.present()
}
    // rust: None => false,
}
    // rust: if ride_expired {
    // rust: m.extra.piglin.ride = None;
}
    // rust: if let Some(a) = m.extra.piglin.avoid.as_mut()
    // rust: && let Some(p) = cx.w.target_info(a.who)
    // rust: {
    // rust: a.at = p.position;
}
    // rust: if m.species() == Species::Piglin {
    // rust: copy_to_avoid(m, cx);
        // The idle activity's behaviours: `babySometimesRideBabyHoglin`.
    // rust: if m.extra.piglin.activity == Activity::Idle {
    // rust: baby_sometimes_ride_baby_hoglin(m, cx);
}
}
    // rust: if m.extra.piglin.activity == Activity::Avoid && wants_to_stop_fleeing(m, cx.w) {
    // rust: m.extra.piglin.avoid = None;
}
    // The ride activity's behaviours.
    // rust: if m.species() == Species::Piglin && m.extra.piglin.activity == Activity::Ride {
    // rust: mount(m, cx);
    // rust: dismount_or_skip_mounting(m, cx.w);
}
    // rust: update_activity(m, cx.w, cx.events);
}
// `Zoglin.customServerAiStep` after the brain: `Zoglin.updateActivity` plays
// the angry grunt when the fight activity starts.
zoglin_step :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let now = if m.ai.target.is_some() {
    // rust: Activity::Fight
    // rust: } else {
    // rust: Activity::Idle
}
    // rust: let before = std::mem::replace(&mut m.extra.piglin.activity, now);
    // rust: if now == Activity::Fight && before != Activity::Fight {
    // rust: m.voice("entity.zoglin.angry", cx.events);
}
}
// `HoglinAi.updateActivity`, `PiglinAi.updateActivity` and
// `PiglinBruteAi.updateActivity`: take the first valid activity and, when it
// is not the one it was in, make the sound that goes with the new one; a
// piglin then gets off a baby it rides once it has no ride target
// (`isBabyRidingBaby`).
update_activity :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: let now = activity(m);
    // rust: let before = std::mem::replace(&mut m.extra.piglin.activity, now);
    // rust: if before != now {
    // rust: match m.species() {
    // rust: Species::PiglinBrute => play_brute_sound(m, events),
    // rust: Species::Hoglin => m.voice(hoglin_sound(m, w, now), events),
    // rust: _ => m.voice(piglin_sound(m, w, now), events),
}
}
    // A baby that rides a baby but has no ride target (any more) gets off.
    // rust: if m.species() == Species::Piglin && m.extra.piglin.ride.is_none() && is_baby_riding_baby(m, w)
    // rust: {
    // rust: dismount(m, w);
}
}
// `PiglinAi.isBabyRidingBaby`: a baby piglin on a baby piglin or a baby
// hoglin.
is_baby_riding_baby :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !m.is_baby() {
    // rust: return false;
}
    // rust: m.extra
    // rust: .mount
    // rust: .and_then(|id| w.seen(id))
    // rust: .is_some_and(|v| v.baby && matches!(v.species, Species::Piglin | Species::Hoglin))
}
// `Hoglin.isConverting` and `AbstractPiglin.isConverting`: in a dimension
// that is not piglin safe, a mob that is not immune and has AI.
converting :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !w.nether && !m.extra.flag2 && !m.no_ai
}
// `Hoglin.getAmbientSound`: the sound of the activity it is in
// (`HoglinAi.getSoundForCurrentActivity`).
hoglin_ambient :: proc(m: ^Mob, w: ^MobWorld) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: hoglin_sound(m, w, m.extra.piglin.activity)
}
// `Piglin.getAmbientSound`: the sound of the activity it is in
// (`PiglinAi.getSoundForCurrentActivity`).
piglin_ambient :: proc(m: ^Mob, w: ^MobWorld) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: piglin_sound(m, w, m.extra.piglin.activity)
}
// `HoglinAi.getSoundForActivity`: a retreat grunt while retreating,
// converting or near a repellent, an angry one while fighting.
hoglin_sound :: proc(m: ^Mob, w: ^MobWorld, activity: Activity) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if activity == Activity::Avoid || converting(m, w) {
    // rust: "entity.hoglin.retreat"
    // rust: } else if activity == Activity::Fight {
    // rust: "entity.hoglin.angry"
    // rust: } else if m.extra.repellent.is_some() {
    // rust: "entity.hoglin.retreat"
    // rust: } else {
    // rust: "entity.hoglin.ambient"
}
}
// `PiglinAi.getSoundForActivity`: angry while fighting, a retreat grunt
// while converting, retreating from something within 12 blocks or near a
// repellent, then admiring, celebrating, jealous of a player holding gold,
// or the plain grunt.
piglin_sound :: proc(m: ^Mob, w: ^MobWorld, activity: Activity) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let b = &m.extra.piglin;
    // rust: if activity == Activity::Fight {
    // rust: "entity.piglin.angry"
    // rust: } else if converting(m, w)
    // rust: || (activity == Activity::Avoid && b.avoid.is_some_and(|a| m.distance_sqr(a.at) < 144.0))
    // rust: {
    // rust: "entity.piglin.retreat"
    // rust: } else if activity == Activity::Admire {
    // rust: "entity.piglin.admiring_item"
    // rust: } else if activity == Activity::Celebrate {
    // rust: "entity.piglin.celebrate"
    // rust: } else if b.sees_loved {
    // rust: "entity.piglin.jealous"
    // rust: } else if m.extra.repellent.is_some() {
    // rust: "entity.piglin.retreat"
    // rust: } else {
    // rust: "entity.piglin.ambient"
}
}
// `PiglinBruteAi.playActivitySound`: a brute's `PiglinBrute.playAngrySound`
// while the fight activity is the active one; its other activity (idle) says
// nothing.
play_brute_sound :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if m.extra.piglin.activity == Activity::Fight {
    // rust: m.voice("entity.piglin_brute.angry", events);
}
}
// `PiglinBruteAi.maybePlayActivitySound`: the level random is drawn on every
// tick, fighting or not; a hit only growls in a fight.
maybe_play_brute_sound :: proc(m: ^Mob, lr: ^LegacyRandom, events: ^[dynamic]MobEvent) {
}
    // rust: if lr.next_float() < 0.0125 {
    // rust: play_brute_sound(m, events);
}
}
// `PiglinAi.getAvoidTarget`: the avoid target while the memory is there.
avoid_target :: proc(m: ^Mob) -> O {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.piglin.avoid.map(|a| a.who)
}
// `Brain.setMemoryWithExpiry`: `AVOID_TARGET` for `ticks` more ticks.
remember_avoid :: proc(m: ^Mob, who: Who, at: Vec3, ticks: i32) {
}
    // rust: let mut ttl = Ttl::default();
    // rust: ttl.set(ticks);
    // rust: m.extra.piglin.avoid = Some(AvoidTarget { who, at, ttl });
}
// `TimeUtil.rangeOfSeconds(5, 7)` of `PiglinAi.AVOID_ZOMBIFIED_DURATION` and
// `BABY_AVOID_NEMESIS_DURATION`, sampled from the level random.
avoid_duration :: proc(lr: ^LegacyRandom) -> i {
    // Ported from Horizon
    return {}
}
    // rust: lr.next_int_between_inclusive(100, 140).unwrap_or(100)
}
// `PiglinAi.isNearZombified`: the nearest visible zombified piglin or zoglin
// when it is closer than 6 blocks, and where it stands.
near_zombified :: proc(m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let who = m.extra.piglin.zombified?;
    // rust: let at = w.target_info(who)?.position;
    // rust: (m.distance_sqr(at) < 36.0).then_some((who, at))
}
// `PiglinAi.babyAvoidNemesis` and `PiglinAi.avoidZombified`: the core
// activity's `CopyMemoryWithExpiry` into `AVOID_TARGET`. A baby avoids a
// wither skeleton or wither it sees, anyone a zombified piglin or zoglin
// that is near. Each tick it applies draws its expiry from the level random.
copy_to_avoid :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: if m.is_baby()
    // rust: && let Some(who) = m.extra.piglin.nemesis
    // rust: && let Some(p) = cx.w.target_info(who)
    // rust: {
    // rust: let ticks = avoid_duration(cx.lr);
    // rust: remember_avoid(m, who, p.position, ticks);
}
    // rust: if let Some((who, at)) = near_zombified(m, cx.w) {
    // rust: let ticks = avoid_duration(cx.lr);
    // rust: remember_avoid(m, who, at, ticks);
}
}
// `SetEntityLookTargetSometimes.Ticker.tickDownAndCheck`: with nothing left
// to wait for, draw the next wait from `interval` and say no; otherwise
// count down and say yes when it reaches nothing.
tick_down_and_check :: proc(wait: ^i32, lr: ^LegacyRandom, interval: (i32) {
}
    // rust: if *wait == 0 {
    // rust: *wait = lr
    // rust: .next_int_between_inclusive(interval.0, interval.1)
    // rust: .unwrap_or(interval.0)
    // rust: - 1;
    // rust: false
    // rust: } else {
    // rust: *wait -= 1;
    // rust: *wait == 0
}
}
// `PiglinAi.babySometimesRideBabyHoglin`: the idle activity's
// `CopyMemoryWithExpiry` of the nearest baby hoglin it sees into
// `RIDE_TARGET` for 10 to 30 seconds. It asks only while the target is
// empty, and a baby's ticker lets it through once every 10 to 40 seconds
// of asking (`RIDE_START_INTERVAL`, `RIDE_DURATION`, both drawn from the
// level random).
baby_sometimes_ride_baby_hoglin :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let b = &m.extra.piglin;
    // rust: let Some(hoglin) = b.baby_hoglin else { return };
    // rust: if b.ride.is_some() || !m.is_baby() {
    // rust: return;
}
    // rust: if !tick_down_and_check(&mut m.extra.piglin.ride_wait, cx.lr, (200, 800)) {
    // rust: return;
}
    // rust: let ticks = cx.lr.next_int_between_inclusive(200, 600).unwrap_or(200);
    // rust: let mut ttl = Ttl::default();
    // rust: ttl.set(ticks);
    // rust: m.extra.piglin.ride = Some(RideTarget {
    // rust: vehicle: hoglin,
    // rust: ttl,
    // rust: aimed: None,
    // rust: });
}
// `PiglinAi.SPEED_MULTIPLIER_WHEN_MOUNTING`.
MOUNTING_SPEED :: 0.8
// The block under `at` (`BlockPos.containing`).
block_of :: proc(at: Vec3) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: ]
}
// `Mount.create`: with no walk under way and a `RIDE_TARGET`, a piglin that
// is not a passenger already boards the ride target once it is closer than a
// block (`startRiding`), and otherwise looks at it and walks to it at 0.8
// (`WalkTarget` on an `EntityTracker`). `MoveToTargetSink` carries the walk:
// it ends once the target's block is a block away (`reachedTarget`) and aims
// again when that block has moved more than 2 blocks.
mount :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: if m.extra.mount.is_some() {
    // rust: return;
}
    // rust: let Some(ride) = m.extra.piglin.ride else {
    // rust: return;
}
    // rust: let Some((at, eye_y)) = cx.w.seen(ride.vehicle).map(|s| (s.position, s.eye_y)) else {
    // rust: return;
}
    // rust: let target = block_of(at);
    // rust: let here = block_of(m.position);
    // rust: let reached = (0..3).map(|i| (target[i] - here[i]).abs()).sum::<i32>() <= 1;
    // rust: if !m.ai.nav.is_done() {
    // rust: let moved = ride.aimed.is_none_or(|a| {
    // rust: (0..3)
    // rust: .map(|i| i64::from(target[i] - a[i]).pow(2))
    // rust: .sum::<i64>()
    // rust: > 4
    // rust: });
    // rust: if reached {
    // rust: m.nav_stop();
    // rust: } else if moved {
    // rust: aim_at_ride_target(m, cx, at);
}
    // rust: return;
}
    // rust: if m.distance_sqr(at) < 1.0 {
    // rust: cx.events.push(MobEvent::StartRiding {
    // rust: rider: m.id,
    // rust: vehicle: ride.vehicle,
    // rust: });
    // rust: return;
}
    // rust: m.look_at([at.x, eye_y, at.z]);
    // rust: if !reached {
    // rust: aim_at_ride_target(m, cx, at);
}
}
// `MoveToTargetSink.tryComputePath` to the block the ride target stands in:
// a path there at `SPEED_MULTIPLIER_WHEN_MOUNTING`, remembering where it was
// aimed.
aim_at_ride_target :: proc(m: ^Mob, cx: ^Cx, at: Vec3) {
}
    // rust: if m.nav_move_to_entity(cx.w, [at.x, at.y, at.z], 0, MOUNTING_SPEED)
    // rust: && let Some(r) = m.extra.piglin.ride.as_mut()
    // rust: {
    // rust: r.aimed = Some(block_of(at));
}
}
// `PiglinAi.wantsToStopRiding`: a piglin wants off a mob that is not a baby
// or not alive any more, when it was hurt recently, or when it is a piglin
// that is not riding anything itself. (`wasHurtRecently` of the mob it rides
// is `HURT_BY` in that mob's brain, which a hoglin's does not have.)
wants_to_stop_riding :: proc(m: ^Mob, vehicle: ^Seen) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !vehicle.baby
    // rust: || !vehicle.alive
    // rust: || m.extra.piglin.hurt
    // rust: || vehicle.hurt_recently
    // rust: || (vehicle.species == Species::Piglin && !vehicle.passenger)
}
// `DismountOrSkipMounting.create(8, wantsToStopRiding)`: the vehicle it sits
// on, or else the ride target, stays only while it is alive, closer than 8
// blocks and the piglin does not want off it; if not, the piglin gets off
// and forgets the ride target. A vehicle gone from the level counts as dead.
dismount_or_skip_mounting :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let Some(vehicle) = m.extra.mount.or(m.extra.piglin.ride.map(|r| r.vehicle)) else {
    // rust: return;
}
    // rust: let keep = match w.seen(vehicle) {
    // rust: Some(s) => s.alive && m.distance_sqr(s.position) < 64.0 && !wants_to_stop_riding(m, s),
    // rust: None => false,
}
    // rust: if keep {
    // rust: return;
}
    // rust: dismount(m, w);
    // rust: m.extra.piglin.ride = None;
}
// `LivingEntity.stopRiding`: get off the vehicle, onto the spot
// `Animal.getDismountLocationForPassenger` finds beside it.
dismount :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: let Some(vehicle) = m.extra.mount else { return };
    // rust: let at = w
    // rust: .seen(vehicle)
    // rust: .map(|s| super::riders::dismount_location(w, s, m.width(), m.height()));
    // rust: super::riders::stop_riding(m, at);
}
// `HoglinAi.piglinsOutnumberHoglins`: an adult hoglin counts itself and
// sees more adult piglins than hoglins.
piglins_outnumber_hoglins :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.is_baby() && m.extra.piglin.piglins > m.extra.piglin.hoglins + 1
}
// `PiglinAi.hoglinsOutnumberPiglins`: a piglin counts itself and sees more
// adult hoglins than adult piglins.
hoglins_outnumber_piglins :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.piglin.hoglins > m.extra.piglin.piglins + 1
}
// `HoglinAi.wantsToStopFleeing` and `PiglinAi.wantsToStopFleeing`: the
// retreat activity's `EraseMemoryIf`. A hoglin stops once it is an adult
// and piglins no longer outnumber hoglins; a piglin once the hoglins it
// avoids no longer outnumber piglins, or the zombified mob it avoids is not
// the nearest one it sees any more. Any other avoid target waits out its
// expiry.
wants_to_stop_fleeing :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let b = &m.extra.piglin;
    // rust: let Some(a) = b.avoid else { return true };
    // rust: if m.species() == Species::Hoglin {
    // rust: return !m.is_baby() && !piglins_outnumber_hoglins(m);
}
    // rust: match species_of(w, a.who) {
    // rust: Some(Species::Hoglin) => !hoglins_outnumber_piglins(m),
    // rust: Some(Species::ZombifiedPiglin | Species::Zoglin) => b.zombified != Some(a.who),
    // rust: _ => false,
}
}
// `PiglinAi.RETREAT_DURATION` and `HoglinAi.RETREAT_DURATION`:
// `TimeUtil.rangeOfSeconds(5, 20)`, sampled from the level random.
retreat_duration :: proc(lr: ^LegacyRandom) -> i {
    // Ported from Horizon
    return {}
}
    // rust: lr.next_int_between_inclusive(100, 400).unwrap_or(100)
}
// `PiglinAi.TIME_BETWEEN_HUNTS` (30 to 120 seconds) sampled from the level
// random.
hunt_wait :: proc(lr: ^LegacyRandom) -> i {
    // Ported from Horizon
    return {}
}
    // rust: lr.next_int_between_inclusive(600, 2400).unwrap_or(600)
}
// `HoglinAi.setAvoidTarget`: forget the attack target and the walk, and
// avoid `who`, standing at `at`, for a while.
set_avoid_target :: proc(m: ^Mob, lr: ^LegacyRandom, who: Who, at: Vec3) {
}
    // rust: m.ai.target = None;
    // rust: m.nav_stop();
    // rust: let ticks = retreat_duration(lr);
    // rust: remember_avoid(m, who, at, ticks);
}
// `PiglinAi.setAvoidTargetAndDontHuntForAWhile`: forget the anger, the
// attack target and the walk, avoid `who` for a while and start the
// `HUNTED_RECENTLY` wait (`dontKillAnyMoreHoglinsForAWhile`).
set_avoid_target_and_dont_hunt :: proc(m: ^Mob, lr: ^LegacyRandom, who: Who, at: Vec3) {
}
    // rust: m.extra.anger = 0;
    // rust: set_avoid_target(m, lr, who, at);
    // rust: m.extra.ints[0] = hunt_wait(lr);
}
// `HoglinAi.retreatFromNearestTarget` and `PiglinAi.retreatFromNearestTarget`:
// retreat from the nearest of the new target, the avoid target and the
// attack target (`BehaviorUtils.getNearestTarget`: the first one only when
// it is strictly closer).
retreat_from_nearest :: proc(m: ^Mob, w: ^MobWorld, lr: ^LegacyRandom, who: Who, at: Vec3) {
}
    // rust: let mut nearest = (who, at);
    // rust: let avoid = m.extra.piglin.avoid.map(|a| (a.who, a.at));
    // rust: let attack =
    // rust: m.ai.target
    // rust: .and_then(|t| w.target_info(t).map(|i| (t, i.position)));
    // rust: for other in [avoid, attack].into_iter().flatten() {
    // rust: if m.distance_sqr(other.1) < m.distance_sqr(nearest.1) {
    // rust: nearest = other;
}
}
    // rust: if m.species() == Species::Hoglin {
    // rust: set_avoid_target(m, lr, nearest.0, nearest.1);
    // rust: } else {
    // rust: set_avoid_target_and_dont_hunt(m, lr, nearest.0, nearest.1);
}
}
// `HoglinAi.broadcastRetreat` and `PiglinAi.broadcastRetreat`: every adult
// hoglin (for a piglin, every adult piglin but the brutes) this one sees
// retreats from `who` too, once its tick starts.
broadcast_retreat :: proc(m: ^Mob, w: ^MobWorld, who: Who, at: Vec3, events: ^[dynamic]MobEvent) {
}
    // rust: for &id in &m.extra.piglin.adults {
    // rust: if m.species() == Species::Piglin
    // rust: && !w.seen(id).is_some_and(|s| s.species == Species::Piglin)
    // rust: {
    // rust: continue;
}
    // rust: events.push(MobEvent::Retreat {
    // rust: mob: id,
    // rust: from: who,
    // rust: at: [at.x, at.y, at.z],
    // rust: });
}
}
// What `broadcastRetreat` asks of a mob: it handles the retreat when its
// next tick starts.
receive_retreat :: proc(m: ^Mob, from: Who, at: [f64; 3]) {
}
    // rust: m.extra
    // rust: .piglin
    // rust: .retreats
    // rust: .push((from, Vec3::new(at[0], at[1], at[2])));
}
// `BehaviorUtils.isOtherTargetMuchFurtherAwayThanCurrentAttackTarget` with
// 4 blocks: `other` is more than 4 blocks further away than the attack
// target.
much_further_than_target :: proc(m: ^Mob, w: ^MobWorld, other: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(current) =
    // rust: m.ai.target
    // rust: .and_then(|t| w.target_info(t).map(|i| i.position))
    // rust: else {
    // rust: return false;
}
    // rust: m.distance_sqr(other) > m.distance_sqr(current) + 16.0
}
// `Sensor.isEntityAttackable`, or `isEntityAttackableIgnoringLineOfSight`
// without `check_sight`: `TargetingConditions.forCombat()` within the
// follow range.
attackable :: proc(m: ^Mob, w: ^MobWorld, who: Who, check_sight: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let range = m.attrs.follow_range;
    // rust: match who {
    // rust: Who::Player => m.can_target_player(w, range, check_sight),
    // rust: Who::Mob(id) => {
    // rust: let Some(s) = w.seen(id) else { return false };
    // rust: s.alive
    // rust: && !s.playing_dead
    // rust: && m.distance_sqr(s.position) <= range * range
    // rust: && (!check_sight || m.sees(w, who))
}
}
}
// `HoglinAi.maybeRetaliate`: the tests for an adult. It does not take on a
// piglin while it retreats, nor a hoglin, nor an attacker more than 4
// blocks further away than its target, nor one it cannot attack.
hoglin_retaliates :: proc(m: ^Mob, w: ^MobWorld, by: Who, at: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let species = species_of(w, by);
    // rust: if m.extra.piglin.activity == Activity::Avoid && species == Some(Species::Piglin) {
    // rust: return false;
}
    // rust: species != Some(Species::Hoglin)
    // rust: && !much_further_than_target(m, w, at)
    // rust: && attackable(m, w, by, true)
}
// `HoglinAi.wasHurtBy`, which `Hoglin.hurtServer` calls: a hit ends the
// pacified state; a baby retreats from the attacker, an adult retaliates
// when `maybeRetaliate` allows. The hurt-by goal does the retaliating, so a
// hit that does not get it is used up.
hoglin_hurt :: proc(m: ^Mob, w: ^MobWorld, lr: ^LegacyRandom, by: Who) {
}
    // rust: m.extra.ints[0] = 0;
    // rust: let Some(at) = w.target_info(by).map(|t| t.position) else {
    // rust: return;
}
    // rust: if m.is_baby() {
    // rust: retreat_from_nearest(m, w, lr, by, at);
    // rust: m.ai.last_hurt_by = None;
    // rust: } else if !hoglin_retaliates(m, w, by, at) {
    // rust: m.ai.last_hurt_by = None;
}
}
// `PiglinAi.stopHoldingOffHandItem` without bartering (`wasHurtBy`): a gold
// ingot is not bartered and is gone; anything else ends its admiring next
// tick, as if the time ran out, and the game side puts it away.
stop_admiring :: proc(m: ^Mob) {
}
    // rust: if m.extra.off_hand.as_deref() == Some("minecraft:gold_ingot") {
    // rust: m.extra.off_hand = None;
    // rust: m.extra.using_item = 0;
    // rust: } else {
    // rust: m.extra.using_item = i32::from(m.extra.off_hand.is_some() && m.extra.using_item > 0);
}
}
// Whether two entities are of one type: both the player, or both mobs of
// one species.
same_type :: proc(w: ^MobWorld, a: Who, b: Who) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (a, b) {
    // rust: (Who::Player, Who::Player) => true,
    // rust: (Who::Mob(_), Who::Mob(_)) => {
    // rust: species_of(w, a).is_some() && species_of(w, a) == species_of(w, b)
}
    // rust: _ => false,
}
}
// `PiglinAi.broadcastAngerTarget`: as a hit on a baby, or on an adult that
// retaliates, calls it, the adult piglins around it that have no target
// (brutes too, unless the attacker is a hoglin, which they cannot hunt) take
// the attacker as theirs.
broadcast_anger :: proc(m: ^Mob, w: ^MobWorld, by: Who, at: Vec3, events: ^[dynamic]MobEvent) {
}
    // rust: let range = m.attrs.follow_range;
    // rust: let hoglin = species_of(w, by) == Some(Species::Hoglin);
    // rust: let huntable = matches!(by, Who::Mob(id) if w.seen(id).is_some_and(|s| s.huntable));
    // rust: if hoglin && !huntable {
    // rust: return;
}
    // rust: let id = m.id;
    // rust: let others: Vec<u32> = w
    // rust: .nearby(m.position, range, move |s| {
    // rust: s.id != id
    // rust: && !s.baby
    // rust: && s.target.is_none()
    // rust: && (s.species == Species::Piglin || (s.species == Species::PiglinBrute && !hoglin))
    // rust: && s.position.distance_squared(at) <= range * range
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .collect();
    // rust: for mob in others {
    // rust: events.push(MobEvent::SetTarget { mob, target: by });
}
}
// `PiglinAi.maybeRetaliate`: the tests. Not while retreating, only against
// an attacker it can attack and that is not more than 4 blocks further away
// than its target.
piglin_retaliates :: proc(m: ^Mob, w: ^MobWorld, by: Who, at: Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.piglin.activity != Activity::Avoid
    // rust: && attackable(m, w, by, false)
    // rust: && !much_further_than_target(m, w, at)
}
// `PiglinAi.wasHurtBy`, which `Piglin.hurtServer` calls: another piglin's
// hit changes nothing. Any other ends the admiring, the celebration and the
// dance, and an avoid target of another kind. A baby flees the attacker for 5 seconds
// and calls the adults around it; an adult retreats from a hoglin when
// hoglins outnumber piglins and otherwise retaliates when `maybeRetaliate`
// allows. The hurt-by goal does the retaliating, so a hit that does not get
// it is used up.
    // rust: fn piglin_hurt(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: lr: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: by: Who,
    // rust: ) {
    // rust: let species = species_of(w, by);
    // `PiglinBruteAi.wasHurtBy` too: an `AbstractPiglin`'s hit is no one's to answer.
    // rust: if species == Some(Species::Piglin)
    // rust: || (m.species() == Species::PiglinBrute && species == Some(Species::PiglinBrute))
    // rust: {
    // rust: return;
}
    // rust: stop_admiring(m);
    // `brain.eraseMemory(ADMIRING_ITEM)`, and a player's blow disables
    // admiring for 400 ticks.
    // rust: m.extra.piglin.seen_admire = 0;
    // rust: if by == Who::Player {
    // rust: m.extra.piglin.admire_disabled = 400;
}
    // rust: m.extra.scratch[0] = 0;
    // rust: m.extra.scratch[1] = 0;
    // `PiglinAi.wasHurtBy` erases CELEBRATE_LOCATION, which `extra.home` is
    // for a piglin; `PiglinBruteAi.wasHurtBy` erases nothing, and the brute's
    // home there is the memory it walks back to.
    // rust: if m.species() == Species::Piglin {
    // rust: m.extra.home = None;
}
    // rust: if let Some(avoided) = avoid_target(m)
    // rust: && !same_type(w, avoided, by)
    // rust: {
    // rust: m.extra.piglin.avoid = None;
}
    // rust: let Some(at) = w.target_info(by).map(|t| t.position) else {
    // rust: return;
}
    // rust: if m.is_baby() {
    // rust: remember_avoid(m, by, at, 100);
    // rust: if attackable(m, w, by, false) {
    // rust: broadcast_anger(m, w, by, at, events);
}
    // rust: m.ai.last_hurt_by = None;
    // rust: } else if species == Some(Species::Hoglin) && hoglins_outnumber_piglins(m) {
    // rust: set_avoid_target_and_dont_hunt(m, lr, by, at);
    // rust: broadcast_retreat(m, w, by, at, events);
    // rust: m.ai.last_hurt_by = None;
    // rust: } else if piglin_retaliates(m, w, by, at) {
        // `maybeRetaliate`: `broadcastAngerTarget` calls the adult piglins around it
        // to the attacker, a brute's as a piglin's: the piglins and the brutes.
    // rust: broadcast_anger(m, w, by, at, events);
    // rust: } else {
    // rust: m.ai.last_hurt_by = None;
}
}
// What a piglin or hoglin handles before its goals run: the retreats other
// mobs broadcast to it, the hit `wasHurtBy` reacts to and, for a piglin,
// its celebration.
before_goals :: proc(m: ^Mob, w: ^MobWorld, lr: ^LegacyRandom, events: ^[dynamic]MobEvent) {
}
    // rust: for (from, at) in std::mem::take(&mut m.extra.piglin.retreats) {
    // rust: retreat_from_nearest(m, w, lr, from, at);
}
    // rust: if let Some(by) = m.ai.last_hurt_by
    // rust: && m.ai.last_hurt_by_time != m.extra.piglin.hurt_seen
    // rust: {
    // rust: m.extra.piglin.hurt_seen = m.ai.last_hurt_by_time;
    // rust: if m.species() == Species::Hoglin {
    // rust: hoglin_hurt(m, w, lr, by);
    // rust: } else {
    // rust: piglin_hurt(m, w, lr, events, by);
}
}
    // rust: if m.species() == Species::Piglin {
    // rust: celebrate(m, w);
}
}
// What kind of mob `who` is: none for the player.
species_of :: proc(w: ^MobWorld, who: Who) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match who {
    // rust: Who::Player => None,
    // rust: Who::Mob(id) => w.seen(id).map(|s| s.species),
}
}
// What `SetWalkTargetAwayFrom.entity` walks away from.
AwayFrom :: enum {
    // The retreat activity's `AVOID_TARGET`.
    AvoidTarget,
    // The idle activity's `NEAREST_VISIBLE_ADULT_PIGLIN` (a hoglin's).
    AdultPiglin,
}
// `SetWalkTargetAwayFrom.entity(memory, speed, desiredDistance, interruptCurrentWalk)`:
// closer than the desired distance to what it avoids, pick a spot away
// from it and walk there, unless a walk is on and may not be interrupted.
// A walk at the same speed whose spot lies away from it is left alone.
WalkAway :: struct {
    from: AwayFrom,
    speed: f64,
    desired: f64,
    interrupt: bool,
}
    // rust: impl WalkAway {
retreat :: proc(speed: f64, desired: f64, interrupt: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: from: AwayFrom::AvoidTarget,
    // rust: speed,
    // rust: desired,
    // rust: interrupt,
}
}
adult_piglin :: proc(speed: f64, desired: f64, interrupt: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: from: AwayFrom::AdultPiglin,
    // rust: speed,
    // rust: desired,
    // rust: interrupt,
}
}
    // Where the avoided entity stands, while the activity this behaviour
    // belongs to is the active one.
source :: proc(self: ^Self, m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let b = &m.extra.piglin;
    // rust: match self.from {
    // rust: AwayFrom::AvoidTarget if b.activity == Activity::Avoid => b.avoid.map(|a| a.at),
    // rust: AwayFrom::AdultPiglin if b.activity == Activity::Idle && !m.is_baby() => b
    // rust: .nearest_piglin
    // rust: .and_then(|id| w.seen(id))
    // rust: .map(|s| s.position),
    // rust: _ => None,
}
}
    // One run of the behaviour: whether it sets a new walk target, which
    // it leaves as the path in `pending_path`.
step :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(from) = self.source(m, cx.w) else {
    // rust: return false;
}
    // rust: let walking = !m.ai.nav.is_done();
    // rust: if walking && !self.interrupt {
    // rust: return false;
}
    // rust: if m.distance_sqr(from) >= self.desired * self.desired {
    // rust: return false;
}
    // rust: if walking
    // rust: && m.ai.nav.speed_modifier == self.speed
    // rust: && let Some(end) = m.ai.nav.path.as_ref().and_then(|p| p.end())
    // rust: {
    // rust: let (cx0, cy0, cz0) = (
    // rust: f64::from(end.x) + 0.5 - m.position.x,
    // rust: f64::from(end.y) - m.position.y,
    // rust: f64::from(end.z) + 0.5 - m.position.z,
    // rust: );
    // rust: let (ax, ay, az) = (
    // rust: from.x - m.position.x,
    // rust: from.y - m.position.y,
    // rust: from.z - m.position.z,
    // rust: );
    // rust: if cx0 * ax + cy0 * ay + cz0 * az < 0.0 {
    // rust: return false;
}
}
    // rust: let away = [from.x, from.y, from.z];
    // rust: for _ in 0..10 {
    // rust: if let Some(p) = m.land_random_pos_away(cx.w, 16, 7, away) {
    // rust: let at = [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ];
    // rust: m.ai.pending_path = m.create_path_to(cx.w, at, 0);
    // rust: return m.ai.pending_path.is_some();
}
}
    // rust: false
}
}
    // rust: impl Goal for WalkAway {
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
    // rust: self.step(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.source(m, cx.w).is_some() && !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let path = m.ai.pending_path.take();
    // rust: m.nav_move_to_path(cx.w, path, self.speed);
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if self.step(m, cx) {
    // rust: let path = m.ai.pending_path.take();
    // rust: m.nav_move_to_path(cx.w, path, self.speed);
}
}
}
// A goal of the idle and fight activities: it waits while the brain is in
// the retreat activity.
NotRetreating :: struct {
    // rust: impl<G: Goal + Clone + 'static> Goal for NotRetreating<G> {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.0.name()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.piglin.activity != Activity::Avoid && self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.piglin.activity != Activity::Avoid && self.0.can_continue(m, cx)
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.interruptable()
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.every_tick()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx)
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.tick(m, cx)
}
}

// A goal of the idle and avoid activities' movement: the ride activity has
// none of it (`PiglinAi.initRideHoglinActivity`), so it waits while the
// brain is in the ride activity.
NotRiding :: struct {
    // rust: impl<G: Goal + Clone + 'static> Goal for NotRiding<G> {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0.flags()
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.0.name()
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.piglin.activity != Activity::Ride && self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.piglin.activity != Activity::Ride && self.0.can_continue(m, cx)
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.interruptable()
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.every_tick()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.start(m, cx)
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx)
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.tick(m, cx)
}
}

hostile_to_player :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // `StartAttacking` is in the idle and celebrate activities, not in the retreat.
    // rust: if m.is_baby() || m.extra.piglin.activity == Activity::Avoid {
    // rust: return false;
}
    // rust: match m.species() {
    // rust: Species::Piglin => m.extra.anger > 0 || w.player.as_ref().is_some_and(|p| !p.gold_armor),
    // rust: _ => true,
}
}
// `BackUpIfTooClose.create(5, 0.75)` of `PiglinAi.initFightActivity`, behind
// `hasCrossbow`: with no walk target and the attack target in sight within 5
// blocks, look at it and strafe backwards every tick. It takes no flags so the
// crossbow goal keeps aiming meanwhile.
BackUpIfTooClose :: struct {
    // rust: impl BackUpIfTooClose {
too_close :: proc(m: ^Mob, cx: ^Cx) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.main_hand.as_deref() != Some("minecraft:crossbow") || !m.ai.nav.is_done() {
    // rust: return None;
}
    // rust: let who = m.ai.target?;
    // rust: let t = cx.w.target_info(who)?;
    // rust: if !t.position.closer_than(m.position, 5.0) || !m.sees(cx.w, who) {
    // rust: return None;
}
    // rust: Some([t.position.x, t.eye_y, t.position.z])
}
}
    // rust: impl Goal for BackUpIfTooClose {
    // rust: goal_clone!();
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
    // rust: Self::too_close(m, cx).is_some()
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.can_use(m, cx)
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(eye) = Self::too_close(m, cx) else {
    // rust: return;
}
    // rust: m.look_at(eye);
    // rust: m.ai.mov.strafe(-0.75, 0.0);
    // rust: m.yaw = super::control::rotate_if_necessary(m.yaw, m.head_yaw, 0.0);
}
}
register_piglin :: proc(m: ^Mob) {
}
    // `AbstractPiglin.<init>`: a piglin's navigation opens doors.
    // rust: m.ai.nav.can_open_doors = true;
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // `PiglinAi.initCoreActivity`: `InteractWithDoor.create()`.
    // rust: g.add(0, super::doors::InteractWithDoor::default());
    // rust: g.add(1, Admire);
    // rust: g.add(1, AdmireSeen);
    // `PiglinAi.initRetreatActivity`: `SetWalkTargetAwayFrom.entity(AVOID_TARGET, 1.0, 12, true)`.
    // rust: g.add(2, WalkAway::retreat(1.0, 12.0, true));
    // Registered before the spawn weapon is equipped, so the goal checks the
    // held item itself (it only starts while a crossbow is in the main hand).
    // rust: g.add(3, super::illager::crossbow_goal(1.0, 8.0));
    // rust: g.add(3, BackUpIfTooClose);
    // `PiglinAi.initFightActivity`: the spear behaviours come before the melee one.
    // rust: g.add(3, super::spear_use::PiglinSpear::new());
    // rust: g.add(
    // rust: 3,
    // rust: super::spear_use::NoMeleeWithSpear(MeleeAttack::new(1.0, true)),
    // rust: );
    // rust: g.add(4, NotRiding(PiglinAvoidRepellent));
    // rust: g.add(4, GoToWantedItem);
    // rust: g.add(4, Celebrate);
    // rust: g.add(5, NotRiding(Stroll::avoiding_water(0.6)));
    // rust: g.add(5, LookAtLoved);
    // rust: g.add(6, LookAtPlayer::new(8.0));
    // rust: g.add(7, RandomLookAround::default());
    // rust: let mut hurt = HurtByTarget::new().alert();
    // rust: hurt.ignore = vec![Species::Piglin, Species::PiglinBrute];
    // rust: m.ai.targets.add(1, hurt);
    // rust: m.ai.targets
    // rust: .add(2, NearestTarget::player(true).when(hostile_to_player));
    // rust: m.ai.targets.add(3, HuntHoglin::default());
    // `PiglinAi.initMemories`: the first hunt waits too.
    // rust: m.extra.ints[0] = time_between_hunts(m);
}
// `PiglinAi.TIME_BETWEEN_HUNTS`: 30 to 120 seconds.
time_between_hunts :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: m.random
    // rust: .next_int_between_inclusive(600, 2400)
    // rust: .unwrap_or(600)
}
// `StartHuntingHoglin`: an adult piglin that is not angry, has not hunted
// recently and sees no adult piglin that has, goes for the nearest adult
// hoglin it sees; then it and the adult piglins near it wait before the next
// hunt, and the others join in (`broadcastAngerTarget`).
HuntHoglin :: struct {
    found: Maybe(u32),
    st: TargetState,
}
    // rust: impl Default for HuntHoglin {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut st = TargetState::default();
    // rust: st.unseen_memory = 60;
    // rust: Self { found: None, st }
}
}
    // rust: impl Goal for HuntHoglin {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: TARGET
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.is_baby()
    // rust: || m.extra.ints[0] > 0
    // rust: || m.extra.anger > 0
    // rust: || m.ai.target.is_some()
    // rust: || m.extra.piglin.activity == Activity::Avoid
    // rust: {
    // rust: return false;
}
    // rust: let range = m.attrs.follow_range;
    // rust: let pos = Vec3::new(m.position.x, m.eye_y(), m.position.z);
    // rust: let id = m.id;
    // rust: if cx
    // rust: .w
    // rust: .nearby(pos, range, |s| {
    // rust: s.id != id && s.species == Species::Piglin && !s.baby && s.hunted_recently
    // rust: })
    // rust: .next()
    // rust: .is_some()
    // rust: {
    // rust: return false;
}
    // rust: let hoglins: Vec<(u32, Vec3)> =
            // PiglinSpecificSensor: only a hoglin that `canBeHunted`.
    // rust: cx.w.nearby(pos, range, |s| s.huntable)
    // rust: .map(|s| (s.id, s.position))
    // rust: .collect();
    // rust: self.found = hoglins
    // rust: .into_iter()
    // rust: .find(|&(hoglin, at)| {
    // rust: m.distance_sqr(at) <= range * range && m.sees(cx.w, Who::Mob(hoglin))
    // rust: })
    // rust: .map(|(hoglin, _)| hoglin);
    // rust: self.found.is_some()
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: target_continue(&mut self.st, true, m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(hoglin) = self.found else { return };
    // rust: m.ai.target = Some(Who::Mob(hoglin));
    // rust: m.extra.ints[0] = time_between_hunts(m);
    // rust: let range = m.attrs.follow_range;
    // rust: let pos = Vec3::new(m.position.x, m.eye_y(), m.position.z);
    // rust: let id = m.id;
    // rust: let others: Vec<u32> =
    // rust: cx.w.nearby(pos, range, |s| {
    // rust: s.id != id && s.species == Species::Piglin && !s.baby
    // rust: })
    // rust: .map(|s| s.id)
    // rust: .collect();
    // rust: for mob in others {
    // rust: let ticks = time_between_hunts(m);
    // rust: cx.events.push(MobEvent::HuntHoglin {
    // rust: mob,
    // rust: target: hoglin,
    // rust: ticks,
    // rust: });
}
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.ai.target = None;
}
}
register_brute :: proc(m: ^Mob) {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(2, MeleeAttack::new(1.0, true));
    // `PiglinBruteAi.createIdleMovementBehaviors`: `StrollToPoi(HOME, 0.6, 2,
    // 100)` ahead of the plain stroll, so a brute that drifts off walks back to
    // the spot `PiglinBruteAi.initMemories` remembered for it.
    // rust: g.add(5, BruteStrollHome { next_ok: 0 });
    // rust: g.add(5, Stroll::avoiding_water(0.6));
    // rust: g.add(6, LookAtPlayer::new(8.0));
    // rust: let mut hurt = HurtByTarget::new().alert();
    // rust: hurt.ignore = vec![Species::Piglin, Species::PiglinBrute];
    // rust: m.ai.targets.add(1, hurt);
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
    // rust: m.ai.targets
    // rust: .add(3, NearestTarget::species(&[Species::WitherSkeleton], true));
}
// `PiglinBruteAi.HOME_CLOSE_ENOUGH_DISTANCE`: how near home the walk target
// counts as arrived.
HOME_CLOSE_ENOUGH :: 2
// `PiglinBruteAi.HOME_TOO_FAR_DISTANCE`: past this the memory is no help.
HOME_TOO_FAR :: 100.0
// `StrollToPoi(HOME, 0.6F, 2, 100)` of `PiglinBruteAi.createIdleMovementBehaviors`:
// a brute more than a hundred blocks from the spot it was spawned at gives up
// on it, and one that has wandered off walks back to within two blocks of it.
//
// The vanilla behaviour sets the walk target home every 80 ticks; this goal
// instead keeps it only while the brute is outside the reach of the plain
// stroll that shares its priority (`RandomStroll`, ten blocks), which is the
// wandering `StrollAroundPoi(HOME, 0.6F, 5)` of the same activity does around
// the memory. A goal selector here starts the first goal that may run, where
// vanilla draws a weighted one each time, so a home target that outranked the
// stroll inside its own reach would leave the brute standing at home. As in
// vanilla, a try is followed by 80 ticks without one (`nextOkStartTime`), so a
// home it cannot path to costs one search every four seconds, not every tick.
BruteStrollHome :: struct {
    // `StrollToPoi.nextOkStartTime`: the game time before which it does not try.
    next_ok: i64,
}
    // rust: impl Goal for BruteStrollHome {
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
    // rust: let Some(home) = m.extra.home else {
    // rust: return false;
}
        // Vec3.atBottomCenterOf, the point `closerToCenterThan` measures from.
    // rust: let center = Vec3::new(
    // rust: f64::from(home[0]) + 0.5,
    // rust: f64::from(home[1]),
    // rust: f64::from(home[2]) + 0.5,
    // rust: );
    // rust: let distance = m.distance_sqr(center);
    // rust: if distance >= HOME_TOO_FAR * HOME_TOO_FAR
    // rust: || distance <= 10.0 * 10.0
    // rust: || cx.w.game_time < self.next_ok
    // rust: {
    // rust: return false;
}
    // rust: self.next_ok = cx.w.game_time + 80;
    // rust: m.ai.pending_path = m.create_path_to(cx.w, home, HOME_CLOSE_ENOUGH);
    // rust: m.ai.pending_path.is_some()
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let path = m.ai.pending_path.take();
    // rust: m.nav_move_to_path(cx.w, path, 0.6);
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.nav_stop();
}
}
register_hoglin :: proc(m: ^Mob) {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // `HoglinAi.initRetreatActivity`: `SetWalkTargetAwayFrom.entity(AVOID_TARGET, 1.3, 15, false)`.
    // rust: g.add(1, WalkAway::retreat(1.3, 15.0, false));
    // HoglinAi: MeleeAttack.create(40) for adults, 15 for babies.
    // rust: g.add(2, MeleeAttack::new(1.0, true).intervals(40, 15));
    // rust: g.add(3, NotRetreating(super::goals::Breed::new(1.0)));
    // rust: g.add(3, HoglinAvoidRepellent);
    // `HoglinAi.initIdleActivity`: an adult keeps away from the nearest adult
    // piglin it sees, `SetWalkTargetAwayFrom.entity(NEAREST_VISIBLE_ADULT_PIGLIN, 0.4, 8, false)`.
    // rust: g.add(3, WalkAway::adult_piglin(0.4, 8.0, false));
    // rust: g.add(4, NotRetreating(super::goals::FollowParent::new(1.1)));
    // rust: g.add(5, Stroll::avoiding_water(0.4));
    // rust: g.add(6, LookAtPlayer::new(8.0));
    // rust: m.ai.targets.add(1, HurtByTarget::new().alert());
    // `HoglinAi.findNearestValidAttackTarget`: nothing while pacified, and
    // `StartAttacking` is not in the retreat activity.
    // rust: m.ai.targets.add(
    // rust: 2,
    // rust: NearestTarget::player(true).when(|m, _| {
    // rust: !m.is_baby() && m.extra.ints[0] <= 0 && m.extra.piglin.activity != Activity::Avoid
    // rust: }),
    // rust: );
}
register_zoglin :: proc(m: ^Mob) {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // Zoglin.initMemories: MeleeAttack.create(40) for adults, 15 for babies.
    // rust: g.add(2, MeleeAttack::new(1.0, true).intervals(40, 15));
    // rust: g.add(5, Stroll::avoiding_water(0.4));
    // rust: g.add(6, LookAtPlayer::new(8.0));
    // rust: m.ai.targets.add(1, HurtByTarget::new());
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
    // Zoglin.isTargetable: anything but creepers and other zoglins.
    // rust: m.ai.targets.add(
    // rust: 3,
    // rust: NearestTarget::new(
    // rust: Prey::Filter(|s| !matches!(s.species, Species::Creeper | Species::Zoglin)),
    // rust: true,
    // rust: )
    // rust: .interval(10),
    // rust: );
}
// `SetWalkTargetAwayFrom.pos(NEAREST_REPELLENT, 1.0, 8, true)` of the hoglin's
// idle activity: closer than 8 blocks to a repellent, walk away from it.
HoglinAvoidRepellent :: struct {
    // rust: impl Goal for HoglinAvoidRepellent {
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
    // rust: let Some(r) = m.extra.repellent else {
    // rust: return false;
}
        // The idle activity's behaviour: not in the retreat.
    // rust: if m.extra.piglin.activity == Activity::Avoid {
    // rust: return false;
}
        // Vec3.atBottomCenterOf.
    // rust: let avoid = [
    // rust: f64::from(r[0]) + 0.5,
    // rust: f64::from(r[1]),
    // rust: f64::from(r[2]) + 0.5,
    // rust: ];
    // rust: if m.distance_sqr(Vec3::new(avoid[0], avoid[1], avoid[2])) >= 64.0 {
    // rust: return false;
}
    // rust: for _ in 0..10 {
    // rust: if let Some(p) = m.land_random_pos_away(cx.w, 16, 7, avoid) {
    // rust: let at = [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ];
    // rust: m.ai.pending_path = m.create_path_to(cx.w, at, 0);
    // rust: return m.ai.pending_path.is_some();
}
}
    // rust: false
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let path = m.ai.pending_path.take();
    // rust: m.nav_move_to_path(cx.w, path, 1.0);
}
}
// `PiglinAi.avoidRepellent`: `SetWalkTargetAwayFrom.pos(NEAREST_REPELLENT, 1.0, 8, false)`
// of the idle activity. Closer than 8 blocks to a repellent and not walking
// anywhere, walk away from it.
PiglinAvoidRepellent :: struct {
    // rust: impl Goal for PiglinAvoidRepellent {
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
    // rust: let Some(r) = m.extra.repellent else {
    // rust: return false;
}
        // The idle and celebrate activities: not fighting, admiring or
        // retreating, and no walk target yet.
    // rust: if m.ai.target.is_some()
    // rust: || m.extra.using_item > 0
    // rust: || m.extra.piglin.activity == Activity::Avoid
    // rust: || !m.ai.nav.is_done()
    // rust: {
    // rust: return false;
}
        // Vec3.atBottomCenterOf.
    // rust: let avoid = [
    // rust: f64::from(r[0]) + 0.5,
    // rust: f64::from(r[1]),
    // rust: f64::from(r[2]) + 0.5,
    // rust: ];
    // rust: if m.distance_sqr(Vec3::new(avoid[0], avoid[1], avoid[2])) >= 64.0 {
    // rust: return false;
}
    // rust: for _ in 0..10 {
    // rust: if let Some(p) = m.land_random_pos_away(cx.w, 16, 7, avoid) {
    // rust: let at = [
    // rust: p[0].floor() as i32,
    // rust: p[1].floor() as i32,
    // rust: p[2].floor() as i32,
    // rust: ];
    // rust: m.ai.pending_path = m.create_path_to(cx.w, at, 0);
    // rust: return m.ai.pending_path.is_some();
}
}
    // rust: false
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !m.ai.nav.is_done()
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let path = m.ai.pending_path.take();
    // rust: m.nav_move_to_path(cx.w, path, 1.0);
}
}
// `PiglinAi.isPlayerHoldingLovedItem`: the idle and celebrate activities'
// `SetEntityLookTarget.create(.., 14.0)` and the ride activity's, with 8.0,
// turn to look at the player in sight within that many blocks who holds gold.
LookAtLoved :: struct {
    // rust: impl LookAtLoved {
    // The eye of the player to watch, if there is one.
watched :: proc(m: ^Mob, cx: ^Cx) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let range_sqr = match m.extra.piglin.activity {
    Activity: :Idle | Activity::Celebrate => 196.0,
    Activity: :Ride => 64.0,
    // rust: _ => return None,
}
    // rust: let p = cx.w.player.as_ref()?;
    // rust: if !holds_loved(cx.w, p) || m.distance_sqr(p.position) > range_sqr {
    // rust: return None;
}
    // rust: let eye = p.eye;
    // rust: let range = m.attrs.follow_range;
    // rust: m.can_see_player(cx.w, range).then_some(eye)
}
}
    // rust: impl Goal for LookAtLoved {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Self::watched(m, cx).is_some()
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(eye) = Self::watched(m, cx) {
    // rust: m.look_at(eye);
}
}
}
// Admiring a gold item held in the off hand: stand and look at it.
Admire :: struct {
// `initAdmireItemActivity` for an item only seen: the idle and fight behaviours
// stand by while `GoToWantedItem` (the game sets the point) walks to it.
AdmireSeen :: struct {
    // rust: impl Goal for AdmireSeen {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.piglin.seen_admire > 0 && m.extra.off_hand.is_none()
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(p) = m.extra.point
    // rust: && m.ai.nav.is_done()
    // rust: {
    // rust: m.nav_move_to(cx.w, p, 1.0);
}
}
}
    // rust: impl Goal for Admire {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.using_item > 0 && m.extra.off_hand.is_some()
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.nav_stop();
}
}
// The celebrate activity: `GoToTargetLocation` on the spot a killed target
// fell (within 2 blocks, or 4 and slower while dancing).
Celebrate :: struct {
    // rust: impl Celebrate {
walk :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(at) = m.extra.home else { return };
    // rust: let (close, speed) = if m.extra.scratch[0] > 0 {
    // rust: (4.0, 0.6)
    // rust: } else {
    // rust: (2.0, 1.0)
}
    // rust: let center = Vec3::new(
    // rust: f64::from(at[0]) + 0.5,
    // rust: f64::from(at[1]),
    // rust: f64::from(at[2]) + 0.5,
    // rust: );
    // rust: if m.distance_sqr(center) >= close * close {
    // rust: m.nav_move_to(cx.w, [center.x, center.y, center.z], speed);
}
}
}
    // rust: impl Goal for Celebrate {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.scratch[1] > 0 && m.extra.home.is_some() && m.extra.using_item == 0
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: Self::walk(m, cx);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if m.ai.nav.is_done() {
    // rust: Self::walk(m, cx);
}
}
}
// `GoToWantedItem`: walk to the gold the game spotted.
GoToWantedItem :: struct {
    // rust: impl Goal for GoToWantedItem {
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
    // rust: let Some(p) = m.extra.point else {
    // rust: return false;
}
    // rust: m.extra.using_item == 0 && m.nav_move_to(cx.w, p, 1.0)
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.point.is_some() && !m.ai.nav.is_done()
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.extra.point = None;
}
}
// `HoglinSpecificSensor.findNearestRepellent`: the nearest `#hoglin_repellents`
// block within 8 blocks sideways and 4 up or down.
find_hoglin_repellent :: proc(m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let tag = w.block_tags.get("minecraft:hoglin_repellents")?;
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: w.nearest_block(at, 8, 4, |_, name| tag.contains(name))
}
// The hoglin's repellent memories: the sensors (every 20 ticks), the end of
// `PACIFIED` (`ints[0]`) and `BecomePassiveIfMemoryPresent(NEAREST_REPELLENT, 200)`.
hoglin_repellent :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: if m.extra.ints[0] > 0 {
    // rust: m.extra.ints[0] -= 1;
}
    // rust: if m.age.wrapping_add(m.id).is_multiple_of(20) {
    // rust: m.extra.repellent = find_hoglin_repellent(m, w);
    // rust: hoglin_sense(m, w);
}
    // `BecomePassiveIfMemoryPresent` is in the idle and fight activities.
    // rust: if m.extra.ints[0] <= 0
    // rust: && m.extra.repellent.is_some()
    // rust: && m.extra.piglin.activity != Activity::Avoid
    // rust: {
    // rust: m.extra.ints[0] = 200;
    // rust: m.ai.target = None;
}
}
// `StartCelebratingIfTargetDead` for a piglin (`scratch[0]` dancing,
// `scratch[1]` ticks of celebration left, `home` the `CELEBRATE_LOCATION`):
// a killed target starts a celebration at its spot, and a hoglin's death
// makes the piglin dance one time in ten. `piglin_hurt` ends both. Runs
// before the target goals drop the dead target.
celebrate :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: if m.extra.scratch[1] > 0 {
    // rust: m.extra.scratch[1] -= 1;
    // rust: if m.extra.scratch[1] == 0 {
    // rust: m.extra.scratch[0] = 0;
    // rust: m.extra.home = None;
}
}
    // rust: if m.extra.scratch[1] > 0 {
    // rust: return;
}
    // rust: let Some(target) = m.ai.target else { return };
    // rust: let Some(t) = w.target_info(target).filter(|t| !t.alive) else {
    // rust: return;
}
    // rust: let hoglin =
    // rust: matches!(target, Who::Mob(id) if w.seen(id).is_some_and(|s| s.species == Species::Hoglin));
    // PiglinAi.wantsToDance: a fresh random seeded with the game time, not
    // the piglin's own.
    // rust: if hoglin && LegacyRandom::new(w.game_time).next_float() < 0.1 {
    // rust: m.extra.scratch[0] = 1;
}
    // rust: m.extra.scratch[1] = CELEBRATION;
    // rust: m.extra.home = Some([
    // rust: t.position.x.floor() as i32,
    // rust: t.position.y.floor() as i32,
    // rust: t.position.z.floor() as i32,
    // rust: ]);
}
// `Hoglin.isConverting` and `AbstractPiglin.isConverting` on a client: in a
// dimension that is not piglin safe (`nether` is false), a mob that is not
// immune (`flag2`) and has AI shakes. `counter2 > 0` draws the shake, as it
// does on the server while the zombification counts up.
client_converting :: proc(m: ^Mob, nether: bool) {
}
    // rust: m.extra.counter2 = i32::from(!nether && !m.extra.flag2 && !m.no_ai);
}
// Per-tick piglin, piglin brute and hoglin state: the brute's activity and
// growl, a piglin's admiring, anger and zombification, and the hoglin attack
// animation.
    // rust: pub fn ai_step(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
}
    // rust: if m.species() == Species::Hoglin && m.alive() {
    // rust: hoglin_repellent(m, w);
}
    // rust: if m.species() == Species::Piglin {
    // rust: if m.extra.ints[0] > 0 {
    // rust: m.extra.ints[0] -= 1;
}
        // `StopAttackingIfTargetInvalid`: a hoglin handed over by a hunt
        // broadcast has no target goal of its own to drop it when it dies.
    // rust: if let Some(who @ Who::Mob(_)) = m.ai.target
    // rust: && w.target_info(who)
    // rust: .is_none_or(|t| !t.alive || !t.can_be_seen_as_enemy)
    // rust: {
    // rust: m.ai.target = None;
}
}
    // `PiglinBrute.customServerAiStep`: `updateActivity`, then
    // `maybePlayActivitySound`, after the goals that pick the brute's target.
    // rust: if m.alive() && m.species() == Species::PiglinBrute {
    // rust: update_activity(m, w, events);
    // rust: maybe_play_brute_sound(m, level_random, events);
}
    // rust: if m.extra.anger > 0 {
    // rust: m.extra.anger -= 1;
    // rust: if m.extra.anger == 0 && m.ai.target == Some(Who::Player) && !hostile_to_player(m, w) {
    // rust: m.ai.target = None;
}
}
    // `Brain.forgetOutdatedMemories`: `ADMIRING_DISABLED`, `DISABLE_WALK_TO_ADMIRE_ITEM`
    // and an `ADMIRING_ITEM` nothing is held for run out.
    // rust: let b = &mut m.extra.piglin;
    // rust: b.admire_disabled = (b.admire_disabled - 1).max(0);
    // rust: b.walk_off = (b.walk_off - 1).max(0);
    // rust: b.seen_admire = (b.seen_admire - 1).max(0);
    // The admired item is in the off hand; a spear in use counts up instead.
    // rust: if m.extra.using_item > 0 && m.extra.off_hand.is_some() {
    // rust: m.extra.using_item -= 1;
    // rust: if m.extra.using_item == 0 {
    // rust: events.push(MobEvent::FinishAdmiring { mob: m.id });
}
}
    // Zombification outside the Nether (piglins without immunity, hoglins).
    // rust: if !w.nether && !m.extra.flag2 && m.alive() {
    // rust: m.extra.counter2 += 1;
    // rust: if m.extra.counter2 > CONVERSION {
            // `Piglin.finishConversion` runs `PiglinAi.cancelAdmiring` first:
            // the item the piglin is admiring leaves the off hand and lands
            // where it stands, so the zombified piglin never carries it.
    // rust: if m.species() == Species::Piglin {
    // rust: let admiring = (m.extra.off_hand.is_some() && m.extra.using_item > 0)
    // rust: || m.extra.piglin.seen_admire > 0;
    // rust: if admiring && let Some(item) = m.extra.off_hand.take() {
    // rust: events.push(MobEvent::DropItem {
    // rust: mob: m.id,
    // rust: item,
    // rust: count: 1,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
    // rust: m.extra.using_item = 0;
}
}
            // `Hoglin.finishConversion` is `ConversionParams.single(this, true,
            // false)`, `AbstractPiglin.finishConversion` `(this, true, true)`;
            // both leave the new mob nauseous (the game adds it).
    // rust: let (kind, sound, params) = match m.species() {
    // rust: Species::Hoglin => (
    // rust: "minecraft:zoglin",
    // rust: "entity.hoglin.converted_to_zombified",
    // rust: super::conversion::Params {
    // rust: keep_equipment: true,
    // rust: preserve_can_pick_up_loot: false,
    // rust: },
    // rust: ),
    // rust: Species::PiglinBrute => (
    // rust: "minecraft:zombified_piglin",
    // rust: "entity.piglin_brute.converted_to_zombified",
    // rust: super::conversion::Params::KEEP_ALL,
    // rust: ),
    // rust: _ => (
    // rust: "minecraft:zombified_piglin",
    // rust: "entity.piglin.converted_to_zombified",
    // rust: super::conversion::Params::KEEP_ALL,
    // rust: ),
}
    // rust: events.push(MobEvent::Sound(sound, m.center(), 1.0, 1.0));
    // rust: events.push(MobEvent::Convert {
    // rust: from: Box::new(m.clone()),
    // rust: kind,
    // rust: params,
    // rust: });
    // rust: m.removed = true;
}
    // rust: } else {
    // rust: m.extra.counter2 = 0;
}
    // PiglinSpecificSensor (every 20 ticks): the nearest repelling block.
    // rust: if m.species() == Species::Piglin && m.alive() && m.age.wrapping_add(m.id).is_multiple_of(20) {
    // rust: m.extra.repellent = find_piglin_repellent(m, w);
    // rust: piglin_sense(m, w);
}
}
// `PiglinSpecificSensor.findNearestRepellent`: the nearest `#piglin_repellents`
// block within 8 blocks sideways and 4 up or down; a soul campfire only
// counts while lit.
find_piglin_repellent :: proc(m: ^Mob, w: ^MobWorld) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let tag = w.block_tags.get("minecraft:piglin_repellents")?;
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: w.nearest_block(at, 8, 4, |p, name| {
    // rust: tag.contains(name)
    // rust: && (name != "minecraft:soul_campfire"
    // rust: || w.prop(p[0], p[1], p[2], "lit") == Some("true"))
    // rust: })
}
// `HoglinBase.throwTarget`: a shove away and up of the attack knockback less
// the target's knockback resistance (none at all when that is used up).
throw_target :: proc(m: ^Mob, who: Who, cx: ^Cx) {
}
    // rust: let resistance = match who {
    // rust: Who::Mob(id) => cx.w.seen(id).map_or(0.0, |s| s.knockback_resistance),
    // rust: Who::Player => 0.0,
}
    // rust: let power = m.kind.attack_knockback - resistance;
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: if power <= 0.0 {
    // rust: return;
}
    // rust: let away = Vec3::new(
    // rust: t.position.x - m.position.x,
    // rust: 0.0,
    // rust: t.position.z - m.position.z,
    // rust: );
    // `yRot` takes the random whole number of degrees as radians, as vanilla does.
    // rust: let angle = (m.random.next_int_bound(21).unwrap_or(10) - 10) as f32;
    // rust: let scale = power * f64::from(m.random.next_float() * 0.5 + 0.2);
    // rust: let push = away.normalize().scale(scale).rotate_y(angle);
    // rust: let up = power * f64::from(m.random.next_float()) * 0.5;
    // rust: cx.events.push(MobEvent::Push {
    // rust: target: who,
    // rust: velocity: [push.x, up, push.z],
    // rust: });
}
// `HoglinAi.onHitTarget`: an adult that hits a piglin while piglins
// outnumber the hoglins around it retreats from that piglin and tells the
// hoglins it sees to. (The broadcast of the attack target otherwise is not
// ported.)
on_hit_target :: proc(m: ^Mob, who: Who, cx: ^Cx) {
}
    // rust: if m.is_baby() {
    // rust: return;
}
    // rust: let Some(at) = cx.w.target_info(who).map(|t| t.position) else {
    // rust: return;
}
    // rust: if species_of(cx.w, who) == Some(Species::Piglin) && piglins_outnumber_hoglins(m) {
    // rust: set_avoid_target(m, cx.lr, who, at);
    // rust: broadcast_retreat(m, cx.w, who, at, cx.events);
}
}
// `HoglinBase.hurtAndThrowTarget`.
hoglin_hurt_target :: proc(m: ^Mob, who: Who, cx: ^Cx) {
}
    // rust: m.extra.anim_ticks = 10;
    // Entity event 4: clients start the headbutt.
    // rust: cx.events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 4,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
    // rust: if m.species() == Species::Hoglin {
    // rust: on_hit_target(m, who, cx);
}
    // rust: let attack = m.attrs.attack_damage;
    // rust: let amount = if !m.is_baby() && attack as i32 > 0 {
    // rust: attack / 2.0 + m.random.next_int_bound(attack as i32).unwrap_or(0) as f32
    // rust: } else {
    // rust: attack
}
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: match who {
    // rust: Who::Player => cx.events.push(MobEvent::AttackPlayer(amount, from)),
    // rust: Who::Mob(id) => cx.events.push(MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount,
    // rust: source: super::Damage::mob(m.id, from),
    // rust: }),
}
    // rust: if !m.is_baby() {
    // rust: throw_target(m, who, cx);
}
    // rust: let sound = if m.species() == Species::Zoglin {
    // rust: "entity.zoglin.attack"
    // rust: } else {
    // rust: "entity.hoglin.attack"
}
    // rust: cx.events.push(MobEvent::Sound(sound, m.center(), 1.0, 1.0));
}
// `AbstractPiglinModel.setupAnim`: the ears flap around their default angle
// (30 degrees for adults, 5 for babies).
ears :: proc(p: ^Poses, s: ^State) {
}
//     use horizon_core::geometry::trig::DEG_TO_RAD;
    // rust: let default = if s.baby { 5.0 } else { 30.0 } * DEG_TO_RAD;
    // rust: let freq = s.age * 0.1 + s.pos * 0.5;
    // rust: let amp = 0.08 + s.speed * 0.4;
    // rust: p.zrot("left_ear", -default - (freq * 1.2).mcos() * amp);
    // rust: p.zrot("right_ear", default + freq.mcos() * amp);
}
// Piglins' and brutes' ears flap (`AbstractPiglinModel`), arms follow the
// arm pose (`PiglinModel`).
piglin_anim :: proc(m: ^Mob, s: ^State, p: ^Poses) {
}
    // HumanoidMobRenderer.getArmPose: the main arm holding a spear (at rest
    // too), which charges while a spear is in use (an admired item is not).
    // rust: let spear = m
    // rust: .extra
    // rust: .main_hand
    // rust: .as_deref()
    // rust: .and_then(crate::spear::Kinetic::of)
    // rust: .map(|kinetic| {
    // rust: let using = m.extra.using_item > 0 && m.extra.off_hand.is_none();
    // rust: (
    // rust: kinetic,
    // rust: if using {
    // rust: m.extra.using_item as f32 + s.partial
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: )
    // rust: });
    // Piglin.getArmPose: dancing comes first.
    // rust: let pose = if m.extra.scratch[0] > 0 {
    // rust: PiglinPose::Dancing
    // rust: } else if m.extra.using_item > 0 && m.extra.off_hand.is_some() {
    // rust: PiglinPose::AdmiringItem
    // rust: } else if m.extra.flag {
    // rust: PiglinPose::CrossbowCharge
    // rust: } else if m.extra.main_hand.as_deref() == Some("minecraft:crossbow") && m.ai.aggressive {
    // rust: PiglinPose::CrossbowHold
    // rust: } else if m.ai.aggressive && m.extra.main_hand.is_some() && spear.is_none() {
    // rust: PiglinPose::MeleeWeapon
    // rust: } else {
    // rust: PiglinPose::Default
}
    // rust: piglin_pose_holding(
    // rust: p,
    // rust: s,
    // rust: pose,
    // rust: (25.0, m.extra.using_item as f32),
    // rust: m.main_arm_left(),
    // rust: m.extra.passenger,
    // rust: spear,
    // rust: );
}
// `PiglinArmPose`.
PiglinPose :: enum {
    Default,
    Dancing,
    MeleeWeapon,
    CrossbowHold,
    CrossbowCharge,
    AdmiringItem,
}
// `PiglinModel.setupAnim`; `left` when the piglin's main arm is the left one
// and `passenger` when it rides something (`HumanoidModel`'s riding pose).
    // rust: pub fn piglin_pose(
    // rust: p: &mut Poses,
    // rust: s: &State,
    // rust: pose: PiglinPose,
    // rust: max_charge: f32,
    // rust: ticks: f32,
    // rust: left: bool,
    // rust: passenger: bool,
    // rust: ) {
    // rust: piglin_pose_holding(p, s, pose, (max_charge, ticks), left, passenger, None);
}
// `piglin_pose` for a piglin whose main arm holds a spear (`spear`: the
// spear and the ticks the arm has used it, 0 at rest).
    // rust: pub fn piglin_pose_holding(
    // rust: p: &mut Poses,
    // rust: s: &State,
    // rust: pose: PiglinPose,
    // rust: (max_charge, ticks): (f32, f32),
    // rust: left: bool,
    // rust: passenger: bool,
    // rust: spear: Option<(crate::spear::Kinetic, f32)>,
    // rust: ) {
//     use super::anim::{ArmPose, Hum, crossbow_charge, crossbow_hold, humanoid};
    // rust: let mut h = Hum::new(ArmPose::Empty, ArmPose::Empty);
    // rust: if let Some((kinetic, ticks_using)) = spear {
    // rust: let side = usize::from(left);
    // rust: if left {
    // rust: h.left = ArmPose::Spear;
    // rust: } else {
    // rust: h.right = ArmPose::Spear;
}
    // rust: h.spear[side] = Some(kinetic);
    // rust: h.spear_ticks[side] = ticks_using;
}
    // rust: h.weapon_swing = pose == PiglinPose::MeleeWeapon;
    // rust: h.left_main = left;
    // rust: h.passenger = passenger;
    // rust: h.charge = (max_charge, ticks);
    // rust: humanoid(p, s, &h);
    // rust: ears(p, s);
    // rust: let (hy, hx) = (s.y_rot.to_radians(), s.x_rot.to_radians());
    // rust: let rad = |v: f64| v as f32;
    // rust: let deg = horizon_core::geometry::trig::DEG_TO_RAD;
    // rust: match pose {
    // rust: PiglinPose::Dancing => {
    // rust: let dance = s.age / 60.0;
    // rust: p.zrot(
    // rust: "right_ear",
    // rust: rad(std::f64::consts::PI / 6.0) + deg * (dance * 30.0).msin() * 10.0,
    // rust: );
    // rust: p.zrot(
    // rust: "left_ear",
    // rust: rad(-std::f64::consts::PI / 6.0) - deg * (dance * 30.0).mcos() * 10.0,
    // rust: );
    // rust: p.get("head")[0] += (dance * 10.0).msin();
    // rust: p.get("head")[1] += (dance * 40.0).msin() + 0.4;
    // rust: let z = deg * (70.0 + (dance * 40.0).mcos() * 10.0);
    // rust: p.zrot("right_arm", z);
    // rust: p.zrot("left_arm", -z);
    // rust: p.get("right_arm")[1] += (dance * 40.0).msin() * 0.5 - 0.5;
    // rust: p.get("left_arm")[1] += (dance * 40.0).msin() * 0.5 + 0.5;
    // rust: p.get("body")[1] += (dance * 40.0).msin() * 0.35;
}
        // holdWeaponHigh
    // rust: PiglinPose::MeleeWeapon if s.swing == 0.0 => {
    // rust: p.xrot(if left { "left_arm" } else { "right_arm" }, -1.8)
}
    // rust: PiglinPose::CrossbowHold => crossbow_hold(p, hx, hy, !left),
    // rust: PiglinPose::CrossbowCharge => crossbow_charge(p, max_charge, ticks, !left),
    // rust: PiglinPose::AdmiringItem => {
    // rust: p.xrot("head", 0.5);
    // rust: p.yrot("head", 0.0);
    // rust: if left {
    // rust: p.yrot("right_arm", -0.5);
    // rust: p.xrot("right_arm", -0.9);
    // rust: } else {
    // rust: p.yrot("left_arm", 0.5);
    // rust: p.xrot("left_arm", -0.9);
}
}
    // rust: _ => {}
}
}
// `Hoglin.handleEntityEvent` and `Zoglin`'s event 4 on a client: the
// headbutt, which `aiStep` then counts down.
client_event :: proc(m: ^Mob, event: u8) {
}
    // rust: if event == 4 {
    // rust: m.extra.anim_ticks = 10;
}
}
// The headbutt's countdown (`Hoglin.aiStep`, `Zoglin.aiStep`) on a client.
client_tick :: proc(m: ^Mob) {
}
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
}
}
// `HoglinModel.setupAnim`.
hoglin_anim :: proc(m: ^Mob, s: ^State, p: ^Poses) {
}
    // rust: let (pos, sp) = (s.pos, s.speed);
    // rust: p.zrot("right_ear", -PI * 2.0 / 9.0 - sp * pos.msin());
    // rust: p.zrot("left_ear", PI * 2.0 / 9.0 + sp * pos.msin());
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: let remaining = m.extra.anim_ticks as f32;
    // rust: let f = 1.0 - (10.0 - 2.0 * remaining).abs() / 10.0;
    // rust: p.xrot("head", 0.872_664_63 + (-PI / 9.0 - 0.872_664_63) * f);
    // rust: if s.baby {
    // rust: p.get("head")[1] += f * 2.5;
}
    // rust: p.xrot("right_front_leg", pos.mcos() * 1.2 * sp);
    // rust: p.xrot("left_front_leg", (pos + PI).mcos() * 1.2 * sp);
    // rust: p.xrot("right_hind_leg", (pos + PI).mcos() * 1.2 * sp);
    // rust: p.xrot("left_hind_leg", pos.mcos() * 1.2 * sp);
}

    // rust: mod brute_sound_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use crate::mobs::world::with_test_world;
//     use std::sync::Arc;

mob :: proc(species: Species) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: Arc::make_mut(&mut kind).species = species;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}
sounds :: proc(events: ^[MobEvent]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Sound(sound, ..) => Some(*sound),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}

    // `PiglinBruteAi.updateActivity`: a brute with an attack target enters
    // the fight activity and growls `entity.piglin_brute.angry`, losing the
    // target is silent, and a piglin keeps `entity.piglin.angry`.
a_brute_names_the_brute_growl :: proc() {
}
    // rust: let mut brute = mob(Species::PiglinBrute);
    // rust: brute.ai.target = Some(Who::Player);
    // rust: assert_eq!(activity(&brute), Activity::Fight);
        // The switch itself takes a level; it runs where the vanilla data is.
    // rust: with_test_world(&[], |w, _| {
    // rust: let mut events = Vec::new();
    // rust: update_activity(&mut brute, w, &mut events);
    // rust: assert_eq!(sounds(&events), ["entity.piglin_brute.angry"]);
    // rust: brute.ai.target = None;
    // rust: let mut events = Vec::new();
    // rust: update_activity(&mut brute, w, &mut events);
    // rust: assert!(sounds(&events).is_empty());
    // rust: let mut piglin = mob(Species::Piglin);
    // rust: piglin.ai.target = Some(Who::Player);
    // rust: let mut events = Vec::new();
    // rust: update_activity(&mut piglin, w, &mut events);
    // rust: assert_eq!(sounds(&events), ["entity.piglin.angry"]);
    // rust: });
}

    // `PiglinBruteAi.maybePlayActivitySound`: the level random is drawn on
    // every tick, fighting or not, and a hit only sounds in a fight.
the_growl_roll_draws_every_tick_and_only_sounds_in_a_fight :: proc() {
}
    // rust: let mut brute = mob(Species::PiglinBrute);
    // rust: let mut lr = LegacyRandom::new(7);
    // rust: let mut control = LegacyRandom::new(7);
    // rust: let mut events = Vec::new();
    // rust: let mut growls = 0;
    // rust: for tick in 0..2000 {
    // rust: let fight = tick % 2 == 0;
    // rust: brute.extra.piglin.activity = if fight {
    // rust: Activity::Fight
    // rust: } else {
    // rust: Activity::Idle
}
            // The same draw on a stream of its own says when the roll hit.
    // rust: let hit = control.next_float() < 0.0125;
    // rust: maybe_play_brute_sound(&mut brute, &mut lr, &mut events);
    // rust: if hit && fight {
    // rust: growls += 1;
}
    // rust: assert_eq!(sounds(&events).len(), growls, "tick {tick}");
}
    // rust: assert!(growls > 0, "the roll never hit");
}
}

    // rust: mod hurt_broadcast_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use crate::mobs::world::{test_player, with_test_world};
//     use std::sync::Arc;

mob :: proc(id: u32, species: Species, at: Vec3) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: Arc::make_mut(&mut kind).species = species;
    // rust: Mob::new(id, kind, at, 0.0)
}

    // `PiglinBruteAi.wasHurtBy` is `PiglinAi.maybeRetaliate`, which calls the adult piglins
    // around it, the regular ones too (#7790).
a_brute_hit_by_the_player_calls_the_piglins_around_it :: proc() {
}
    // rust: let mut events = Vec::new();
    // rust: let ran = with_test_world(&[], |w, _| {
    // rust: let mut w = w.clone();
    // rust: w.player = Some(test_player(Vec3::new(2.0, 64.0, 0.0)));
    // rust: let mut brute = mob(1, Species::PiglinBrute, Vec3::new(0.0, 64.0, 0.0));
    // rust: brute.ai.last_hurt_by = Some(Who::Player);
    // rust: brute.ai.last_hurt_by_time = 5;
    // rust: let piglin = mob(2, Species::Piglin, Vec3::new(3.0, 64.0, 0.0));
    // rust: let others = [piglin.seen(None)];
    // rust: w.others = &others;
    // rust: let mut lr = LegacyRandom::new(1);
    // rust: before_goals(&mut brute, &w, &mut lr, &mut events);
    // rust: });
    // rust: if !ran {
    // rust: return;
}
    // rust: assert!(
    // rust: events.iter().any(|e| matches!(
    // rust: e,
    // rust: MobEvent::SetTarget {
    // rust: mob: 2,
    // rust: target: Who::Player
}
    // rust: )),
    // rust: "the piglin takes the player as its target: {events:?}"
    // rust: );
}
}

    // rust: mod crossbow_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use horizon_core::geometry::Vec3;
//     use std::sync::Arc;

piglin :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:piglin".into();
    // rust: k.species = Species::Piglin;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // The spawn weapon is equipped after the goals are registered, so the
    // crossbow goal must exist on a piglin that holds nothing yet, and the
    // melee goal must be off once a crossbow is held.
a_piglin_with_a_crossbow_shoots_instead_of_meleeing :: proc() {
}
    // rust: let mut m = piglin();
    // rust: assert!(format!("{:?}", m.ai.goals).contains("CrossbowAttack"));
    // rust: assert!(!super::super::spear_use::holds_non_melee_weapon(&m));
    // rust: m.extra.set_main_hand(Some("minecraft:crossbow".into()));
    // rust: assert!(super::super::spear_use::holds_non_melee_weapon(&m));
    // rust: m.extra.set_main_hand(Some("minecraft:golden_sword".into()));
    // rust: assert!(!super::super::spear_use::holds_non_melee_weapon(&m));
}

a_loved_item_in_sight_is_admired_until_too_far_or_too_long :: proc() {
}
    // rust: let mut b = Memories::default();
        // Seen: the memory is set at once, and not again while it is there.
    // rust: b.admire_seen(false, Some(25.0), true);
    // rust: assert_eq!(b.seen_admire, ADMIRE);
    // rust: b.seen_admire = 50;
    // rust: b.admire_seen(false, Some(25.0), true);
    // rust: assert_eq!(b.seen_admire, 50);
        // An item that is not loved starts nothing.
    // rust: let mut c = Memories::default();
    // rust: c.admire_seen(false, Some(25.0), false);
    // rust: assert_eq!(c.seen_admire, 0);
        // 9 blocks away or gone (`closerThan(9)`) ends it.
    // rust: b.admire_seen(false, Some(81.0), true);
    // rust: assert_eq!(b.seen_admire, 0);
    // rust: b.seen_admire = 50;
    // rust: b.admire_seen(false, None, true);
    // rust: assert_eq!(b.seen_admire, 0);
        // Admiring disabled by a player's blow: never starts.
    // rust: let mut d = Memories {
    // rust: admire_disabled: 3,
    // rust: ..Memories::default()
}
    // rust: d.admire_seen(false, Some(1.0), true);
    // rust: assert_eq!(d.seen_admire, 0);
        // Tired of trying: 201 ticks near the item stop it and disable the walk
        // for 200 ticks, in which it does not start again.
    // rust: let mut e = Memories::default();
    // rust: e.admire_seen(false, Some(4.0), true);
    // rust: for _ in 0..203 {
    // rust: e.seen_admire = 50;
    // rust: e.admire_seen(false, Some(4.0), true);
}
    // rust: assert_eq!((e.seen_admire, e.walk_off, e.reach_time), (0, 200, None));
    // rust: e.admire_seen(false, Some(4.0), true);
    // rust: assert_eq!(e.seen_admire, 0);
        // An item in the off hand leaves the memory alone.
    // rust: let mut f = Memories {
    // rust: seen_admire: 40,
    // rust: ..Memories::default()
}
    // rust: f.admire_seen(true, None, false);
    // rust: assert_eq!(f.seen_admire, 40);
}
}

    // rust: mod conversion_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;

    // `Piglin.finishConversion` cancels the admire before it converts: the
    // item in the off hand is dropped at the piglin's feet and the zombified
    // piglin does not carry it, where Horizon used to hand it over.
a_converted_piglin_drops_the_item_it_was_admiring :: proc() {
}
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: std::sync::Arc::new(types.types["minecraft:piglin"].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: m.extra.off_hand = Some("minecraft:gold_ingot".into());
    // rust: m.extra.using_item = 60;
    // rust: m.extra.counter2 = CONVERSION + 1;
    // rust: let mut lr = LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: ai_step(&mut m, w, &mut lr, &mut events);
    // rust: assert!(
    // rust: events.iter().any(|e| matches!(
    // rust: e,
    // rust: MobEvent::DropItem { item, count, .. }
    // rust: if &**item == "minecraft:gold_ingot" && *count == 1
    // rust: )),
    // rust: "the admired item is dropped"
    // rust: );
    // rust: let from = events
    // rust: .iter()
    // rust: .find_map(|e| match e {
    // rust: MobEvent::Convert { from, .. } => Some(from),
    // rust: _ => None,
    // rust: })
    // rust: .expect("the piglin converts");
    // rust: assert_eq!(from.extra.off_hand, None, "the new mob carries nothing");
    // rust: });
    // rust: let _ = ran;
}
}

    // rust: mod brute_home_tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use crate::mobs::world::with_built_test_world;
//     use horizon_world::registry::BlockRegistry;
//     use std::sync::Arc;

brute :: proc(at: Vec3, home: Maybe([i32; 3])) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: Arc::make_mut(&mut kind).species = Species::PiglinBrute;
    // rust: let mut m = Mob::new(1, kind, at, 0.0);
    // rust: m.extra.home = home;
    // rust: m.on_ground = true;
    // rust: m
}
    // A stone floor under the brute, and the chunks the pathfinder reads.
build :: proc(world: ^crate::world::World, registry: ^BlockRegistry) {
}
    // rust: let stone = registry.default_state("minecraft:stone").unwrap();
    // rust: for cx in -4..4 {
    // rust: for cz in -4..4 {
    // rust: world
    // rust: .chunks
    // rust: .insert((cx, cz), Arc::new(crate::chunk::Chunk::empty(cx, cz)));
}
}
    // rust: for x in -64..64 {
    // rust: for z in -64..64 {
    // rust: world.set(x, -1, z, stone).unwrap();
}
}
}
    // The brute's goals ticked as the AI ticks them (`ai_step` takes the
    // selector out, ticks it and puts it back). Answers whether the walk home
    // started and where its path ends.
tick_goals :: proc(m: ^Mob, cx: ^Cx) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut goals = std::mem::take(&mut m.ai.goals);
    // rust: goals.tick(m, cx);
    // rust: let running = goals.is_running("BruteStrollHome");
    // rust: m.ai.goals = goals;
    // rust: (running, m.ai.nav.path.as_ref().map(|p| p.target))
}
    // `StrollToPoi(HOME, 0.6F, 2, 100)` of the brute's idle movement
    // behaviours, through the goal `register_brute` gives it: a brute more
    // than ten blocks from the spot it spawned at walks back to it, and one
    // that is near home, past a hundred blocks, or without the memory does
    // not.
a_brute_that_wanders_off_walks_back_home :: proc() {
}
    // rust: with_built_test_world(&[], build, |w, _| {
    // rust: let mut lr = LegacyRandom::new(3);
    // rust: let mut events = Vec::new();
    // rust: for (label, home, walks) in [
    // rust: ("far enough to walk back", Some([24, 0, 0]), true),
    // rust: ("near home", Some([5, 0, 0]), false),
    // rust: ("past the memory's reach", Some([120, 0, 0]), false),
    // rust: ("no home", None, false),
    // rust: ] {
    // rust: let mut m = brute(Vec3::new(0.5, 0.0, 0.5), home);
    // rust: register_brute(&mut m);
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: let (running, target) = tick_goals(&mut m, &mut cx);
    // rust: if walks {
    // rust: assert!(running, "{label}: the brute sets off home");
    // rust: assert_eq!(target, home, "{label}: and the walk ends at home");
    // rust: } else {
    // rust: assert!(!running, "{label}: no walk home");
    // rust: assert_eq!(target, None, "{label}: and no path");
}
}
    // rust: });
}
    // `StrollToPoi.nextOkStartTime`: after a try the brute waits 80 ticks before the
    // next one, so a home out of reach is not searched for on every tick.
a_brute_tries_the_way_home_once_every_80_ticks :: proc() {
}
    // rust: with_built_test_world(&[], build, |w, _| {
    // rust: let mut lr = LegacyRandom::new(3);
    // rust: let mut events = Vec::new();
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: let mut m = brute(Vec3::new(0.5, 0.0, 0.5), Some([24, 0, 0]));
    // rust: let mut goal = BruteStrollHome { next_ok: 0 };
    // rust: assert!(goal.can_use(&mut m, &mut cx), "the first try finds a path");
    // rust: m.ai.pending_path = None;
    // rust: assert!(
    // rust: !goal.can_use(&mut m, &mut cx),
    // rust: "no second search in the same 80 ticks"
    // rust: );
    // rust: assert_eq!(goal.next_ok, w.game_time + 80);
    // rust: });
}
    // `PiglinBruteAi.wasHurtBy` erases nothing: a hit does not cost the brute
    // the home it walks back to. `PiglinAi.wasHurtBy` erases
    // CELEBRATE_LOCATION, which is the same field for a piglin.
a_hit_leaves_the_brutes_home_alone :: proc() {
}
    // rust: with_built_test_world(&[], build, |w, _| {
    // rust: let mut lr = LegacyRandom::new(5);
    // rust: let mut events = Vec::new();
    // rust: let mut m = brute(Vec3::new(0.5, 0.0, 0.5), Some([24, 0, 0]));
    // rust: piglin_hurt(&mut m, w, &mut lr, &mut events, Who::Mob(999));
    // rust: assert_eq!(m.extra.home, Some([24, 0, 0]), "the brute keeps it");
    // rust: let mut kind = kind();
    // rust: Arc::make_mut(&mut kind).species = Species::Piglin;
    // rust: let mut piglin = Mob::new(2, kind, Vec3::new(0.5, 0.0, 0.5), 0.0);
    // rust: piglin.extra.home = Some([24, 0, 0]);
    // rust: piglin_hurt(&mut piglin, w, &mut lr, &mut events, Who::Mob(999));
    // rust: assert_eq!(piglin.extra.home, None, "the piglin drops its celebration");
    // rust: });
}
}
