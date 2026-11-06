//! Transpiled from Horizon Rust crate
package horizon_client_camel

import "core:fmt"
import "core:mem"
import "core:math"

// Camels (`Camel`): ridden by two, sitting down and standing up now and
// then, dashing instead of jumping, eating cactus, always "tame".
// use super::{
    // rust: Mob, MobEvent, MobWorld,
    // rust: anim::{Poses, State},
    // rust: goals::{
    // rust: Breed, Cx, Float, FollowParent, Goal, LookAtPlayer, MOVE, Panic, RandomLookAround, Stroll,
    // rust: Tempt, goal_clone,
    // rust: },
}
// use horizon_core::geometry::trig::Mth;
// use horizon_core::geometry::{Aabb, Vec3};
// use horizon_core::random::RandomSource;
// use std::collections::HashMap;

// Camel state: `egg_time` the mob age of the last pose change (it may be
// negative: a camel finalized at age 0 stood up 53 ticks "ago"),
// `camel_sitting` whether it sits, `anim_ticks` the dash cooldown, `flag2` dashing, `ints[0]` the
// idle animation timeout. AnimState states: sit, sit pose, stand up, idle,
// dash.
SIT_DOWN :: 40
STAND_UP :: 52
DASH_COOLDOWN :: 55

register :: proc(m: ^Mob) {
}
    // rust: m.extra.tame = true;
    // rust: let tempt = m.kind.tempt.clone();
    // rust: let g = &mut m.ai.goals;
    // CamelAi speed modifiers (times the 0.09 movement speed attribute).
    // rust: g.add(0, Float);
    // rust: g.add(1, CamelPanic(Panic::new(4.0)));
    // rust: g.add(2, Breed::new(1.0));
    // rust: g.add(3, Tempt::new(2.5, tempt, false));
    // rust: g.add(4, FollowParent::new(2.5));
    // rust: g.add(5, Stroll::new(2.0));
    // rust: g.add(5, RandomSitting);
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(7, RandomLookAround::default());
    // finalizeSpawn: fully standing.
    // rust: stand_up_instantly(m);
}
pose_time :: proc(m: ^Mob) -> i {
    // Ported from Horizon
    return {}
}
    // rust: i64::from(m.age) - i64::from(m.extra.egg_time)
}
sitting :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.camel_sitting
}
// `Camel.getDefaultDimensions` for `Pose.SITTING`: the adult camel's box
// 1.43 lower with its eyes at 0.845, or a baby's 0.425 tall box with its
// eyes at 0.41. Standing, an adult has the type's box and a baby
// `BABY_STANDING_DIMENSIONS` (the species' baby size).
sitting_dims :: proc(baby: bool) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if baby {
    // rust: (0.95, 0.425, 0.41)
    // rust: } else {
    // rust: (1.7, 2.375 - 1.43, 0.845)
}
}
in_transition :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: pose_time(m) < if sitting(m) { SIT_DOWN } else { STAND_UP }
}
// `Camel.getPoseTime` of a client mob from the `LAST_POSE_CHANGE_TICK` it
// was sent and the client's game time, and whether that value says it sits.
client_pose :: proc(m: ^Mob, game_time: i64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let tick = m.extra.pose_change_tick;
    // rust: (game_time - tick.abs(), tick < 0)
}
// The camel's `LAST_POSE_CHANGE_TICK` as the server sends it: in game time
// (a mob counts its own age), negative while sitting.
synced_pose_tick :: proc(m: ^Mob, game_time: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let tick = (game_time - pose_time(m)).max(0);
    // rust: if sitting(m) { -tick.max(1) } else { tick }
}
// `Entity.onSyncedDataUpdated` for the pose tick of a client mob: its sign
// is whether it sits. `client_tick` keeps `egg_time` (in the mob's age, for
// `refuse_to_move`) with it.
set_synced_pose_tick :: proc(m: ^Mob, tick: i64) {
}
    // rust: m.extra.pose_change_tick = tick;
    // rust: m.extra.camel_sitting = tick < 0;
}
// Put a camel loaded from `LastPoseTick` (kept in `pose_change_tick`) on
// the mob's own clock: the pose changed `game_time - |tick|` ticks ago. A
// save without the tag leaves it standing for good.
finish_load :: proc(m: ^Mob, game_time: i64) {
}
    // rust: let tick = m.extra.pose_change_tick;
    // rust: if tick == 0 {
    // rust: return stand_up_instantly(m);
}
    // rust: let since = (game_time - tick.abs()).clamp(0, i64::from(i32::MAX / 2));
    // rust: m.extra.egg_time = (i64::from(m.age) - since) as i32;
}
// `Camel.getDefaultDimensions`: the standing box, the type's or a baby's
// `BABY_STANDING_DIMENSIONS` (width and height).
standing_dims :: proc(m: ^Mob) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if m.is_baby() {
    // rust: (0.95, 1.4)
    // rust: } else {
    // rust: (m.kind.width as f32, m.kind.height as f32)
}
}
// `Camel.canCamelChangePose`: the box of the other pose fits where the camel
// is (`wouldNotSuffocateAtTargetPose`: no block in the way).
can_change_pose :: proc(m: ^Mob, w: ^MobWorld) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (width, height) = if sitting(m) {
    // rust: standing_dims(m)
    // rust: } else {
    // rust: let (width, height, _) = sitting_dims(m.is_baby());
    // rust: (width, height)
}
    // rust: let half = f64::from(width) / 2.0;
    // rust: let at = m.position;
    // rust: w.no_collision(Aabb::new(
    // rust: Vec3::new(at.x - half, at.y, at.z - half),
    // rust: Vec3::new(at.x + half, at.y + f64::from(height), at.z + half),
    // rust: ))
}
// `Camel.onElasticLeashPull`: a taut lead stands a sitting camel up, once it
// is not changing pose and has room to stand.
on_elastic_leash_pull :: proc(m: ^Mob, w: ^MobWorld, events: ^[dynamic]MobEvent) {
}
    // rust: if sitting(m) && !in_transition(m) && can_change_pose(m, w) {
    // rust: stand_up(m, events);
}
}
// `Camel.getBodyAnchorAnimationYOffset` at the partial tick 0: how high the
// seat of the front (`front`) or back rider is on a camel of `height` at
// `scale`, following it down and up through the sit and stand animations.
body_anchor_y :: proc(m: ^Mob, front: bool, height: f32, scale: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let age_sit_y_offset = if m.is_baby() { 0.09375 } else { 0.375 };
    // rust: let mut base_sit_offset = f64::from(height) - age_sit_y_offset;
    // rust: let sitting_height_difference = scale * 1.43;
    // rust: let vertical_drop = sitting_height_difference - scale * 0.2;
    // rust: let bottom_point = sitting_height_difference - vertical_drop;
    // rust: let transition = in_transition(m);
    // rust: let sits = sitting(m);
    // rust: if transition {
    // rust: let duration: i32 = if sits {
    // rust: SIT_DOWN as i32
    // rust: } else {
    // rust: STAND_UP as i32
}
    // rust: let (half_point, flex_point_offset): (i32, f32) = if sits {
    // rust: (28, if front { 0.5 } else { 0.1 })
    // rust: } else {
    // rust: (if front { 24 } else { 32 }, if front { 0.6 } else { 0.35 })
}
    // rust: let time = (pose_time(m) as f32).clamp(0.0, duration as f32);
    // rust: let first_part = time < half_point as f32;
    // rust: let part = if first_part {
    // rust: time / half_point as f32
    // rust: } else {
    // rust: (time - half_point as f32) / (duration - half_point) as f32
}
    // rust: let flex_point = sitting_height_difference - flex_point_offset * vertical_drop;
        // Mth.lerp.
    // rust: let lerp = |delta: f32, a: f32, b: f32| a + delta * (b - a);
    // rust: base_sit_offset += f64::from(if sits {
    // rust: lerp(
    // rust: part,
    // rust: if first_part {
    // rust: sitting_height_difference
    // rust: } else {
    // rust: flex_point
    // rust: },
    // rust: if first_part { flex_point } else { bottom_point },
    // rust: )
    // rust: } else {
    // rust: lerp(
    // rust: part,
    // rust: if first_part {
    // rust: bottom_point - sitting_height_difference
    // rust: } else {
    // rust: bottom_point - flex_point
    // rust: },
    // rust: if first_part {
    // rust: bottom_point - flex_point
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: )
    // rust: });
}
    // rust: if sits && !transition {
    // rust: base_sit_offset += f64::from(bottom_point);
}
    // rust: base_sit_offset
}
// `Camel.getLeashOffset` at the partial tick 0: the lead hangs from the
// front body anchor (sinking while the camel sits) less 0.2 scaled, and
// 0.56 of the width ahead.
leash_offset :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let scale = if m.is_baby() { 0.6 } else { 1.0 };
    // rust: [
    // rust: 0.0,
    // rust: body_anchor_y(m, true, m.height(), scale) - f64::from(0.2_f32 * scale),
    // rust: f64::from(m.width() * 0.56),
    // rust: ]
}
// `Camel.getPassengerAttachmentPoint` of the first (driver) seat, before
// the camel's yaw turns it: half a block ahead (scaled by `getAgeScale`, 0.6
// for a baby) at the body anchor, which sinks while the camel sits.
passenger_attachment :: proc(m: ^Mob) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: passenger_attachment_at(m, 0, 1, false)
}
// `Camel.getPassengerAttachmentPoint` for the passenger at `index` of `count`
// (`getPassengers().indexOf`): with more than one aboard the second seat is
// 0.7 behind the middle, and an `Animal` sits 0.2 further ahead.
passenger_attachment_at :: proc(m: ^Mob, index: uint, count: uint, animal: bool) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let scale = if m.is_baby() { 0.6 } else { 1.0 };
    // rust: let driver = index == 0;
    // rust: let height = body_anchor_y(m, driver, m.height(), scale) as f32;
    // rust: let mut offset = 0.5_f32;
    // rust: if count > 1 {
    // rust: if !driver {
    // rust: offset = -0.7;
}
    // rust: if animal {
    // rust: offset += 0.2;
}
}
    // rust: [0.0, f64::from(height), f64::from(offset * scale)]
}
// `Camel.updateWalkAnimation`: the speed the legs go toward and how fast
// they get there (`WalkAnimationState.update`) for `distance` blocks moved.
// A camel walks only while it stands and is not dashing, six times the
// distance up to 1, and eases there at 0.2 (not the default 0.4).
walk_target :: proc(m: ^Mob, distance: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let dashing = m.anim.states[4].started.is_some();
    // rust: let target = if !sitting(m) && !dashing {
    // rust: (distance * 6.0).min(1.0)
    // rust: } else {
    // rust: 0.0
}
    // rust: (target, 0.2)
}
// `Camel.refuseToMove`: sitting or getting up or down.
refuse_to_move :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: sitting(m) || in_transition(m)
}
sit_down :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if !sitting(m) {
    // rust: sound(m, voice(m, 0), events);
    // rust: m.extra.camel_sitting = true;
    // rust: m.extra.egg_time = m.age as i32;
}
}
stand_up :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if sitting(m) {
    // rust: sound(m, voice(m, 1), events);
    // rust: m.extra.camel_sitting = false;
    // rust: m.extra.egg_time = m.age as i32;
}
}
// `standUpInstantly`.
stand_up_instantly :: proc(m: ^Mob) {
}
    // rust: m.extra.camel_sitting = false;
    // rust: m.extra.egg_time = (i64::from(m.age) - STAND_UP - 1) as i32;
}
// `is_camel`: camels and camel husks (`CamelHusk extends Camel`).
is_camel :: proc(s: super::Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(s, super::Species::Camel | super::Species::CamelHusk)
}
// The sit, stand, dash ready, dash and eat sounds (`CamelHusk` overrides each).
voice :: proc(m: ^Mob, which: uint) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let husk = m.species() == super::Species::CamelHusk;
    // rust: match (which, husk) {
    // rust: (0, false) => "entity.camel.sit",
    // rust: (0, true) => "entity.camel_husk.sit",
    // rust: (1, false) => "entity.camel.stand",
    // rust: (1, true) => "entity.camel_husk.stand",
    // rust: (2, false) => "entity.camel.dash_ready",
    // rust: (2, true) => "entity.camel_husk.dash_ready",
    // rust: (3, false) => "entity.camel.dash",
    // rust: (3, true) => "entity.camel_husk.dash",
    // rust: (_, false) => "entity.camel.eat",
    // rust: (_, true) => "entity.camel_husk.eat",
}
}
sound :: proc(m: ^Mob, name: ^'static str, events: ^[dynamic]MobEvent) {
}
    // rust: events.push(MobEvent::Sound(
    // rust: name,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
// `CamelAi.CamelPanic`: standing up at once to flee.
CamelPanic :: struct {
    // rust: impl Goal for CamelPanic {
    // rust: goal_clone!();
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
        // CamelHusk.isMobControlled: not with a mob on its back either.
    // rust: m.rider.is_none()
    // rust: && !(m.species() == super::Species::CamelHusk && m.extra.rider.is_some())
    // rust: && self.0.can_use(m, cx)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0.can_continue(m, cx)
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: stand_up_instantly(m);
    // rust: self.0.start(m, cx);
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.0.stop(m, cx);
}
}
// `CamelAi.RandomSitting`: after 20 seconds in a pose, sit or stand.
RandomSitting :: struct {
    // rust: impl Goal for RandomSitting {
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
        // checkExtraStartConditions: not leashed, and no controlling
        // passenger, a player's or a mob's (a husk on its back).
    // rust: !m.fluids.in_water
    // rust: && pose_time(m) >= 400
    // rust: && m.extra.leash.is_none()
    // rust: && m.on_ground
    // rust: && m.rider.is_none()
    // rust: && !super::riders::mob_controlled(m, cx.w)
    // rust: && m.random.next_int_bound(4).unwrap_or(1) == 0
}
can_continue :: proc(self: ^Self, _m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if sitting(m) {
    // rust: stand_up(m, cx.events);
    // rust: } else if !super::goals::should_panic(m) {
    // rust: sit_down(m, cx.events);
    // rust: m.ai.nav.stop();
}
}
}
// `Camel.tick`: the dash clock, water stands it up; keyframe states.
ai_step :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if m.extra.flag2 && m.extra.anim_ticks < 50 && (m.on_ground || m.fluids.in_water) {
    // rust: m.extra.flag2 = false;
}
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
    // rust: if m.extra.anim_ticks == 0 {
    // rust: sound(m, voice(m, 2), events);
}
}
    // rust: if sitting(m) && m.fluids.in_water {
    // rust: stand_up_instantly(m);
}
    // rust: if refuse_to_move(m) {
    // rust: m.velocity.x = 0.0;
    // rust: m.velocity.z = 0.0;
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.zza = 0.0;
    // rust: m.ai.nav.stop();
}
    // rust: animation_states(m, pose_time(m), sitting(m));
}
// `Camel.tick` on a client that is not the server: the dash cooldown, which
// the dash flag starts, and the keyframe states from the synced pose tick.
client_tick :: proc(m: ^Mob, game_time: i64) {
}
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
}
    // rust: let (pose_time, sitting) = client_pose(m, game_time);
    // rust: m.extra.camel_sitting = sitting;
    // rust: m.extra.egg_time = (i64::from(m.age) - pose_time) as i32;
    // rust: animation_states(m, pose_time, sitting);
}
// `Camel.onSyncedDataUpdated(DASH)`: a dash starts the cooldown unless it
// runs. Not on the first tick.
set_dashing :: proc(m: ^Mob, dashing: bool) {
}
    // rust: if m.age > 0 && m.extra.anim_ticks == 0 {
    // rust: m.extra.anim_ticks = DASH_COOLDOWN;
}
    // rust: m.extra.flag2 = dashing;
}
// `Camel.setupAnimationStates` for a pose time and whether it sits.
animation_states :: proc(m: ^Mob, pose_time: i64, sitting: bool) {
}
    // rust: let age = m.age as f32;
    // rust: if m.extra.ints[0] <= 0 {
    // rust: m.extra.ints[0] = m.random.next_int_bound(40).unwrap_or(0) + 80;
    // rust: m.anim.states[3].start(age);
    // rust: } else {
    // rust: m.extra.ints[0] -= 1;
}
    // isCamelVisuallySitting: (poseTime < 0) != sitting.
    // rust: let visually_sitting = (pose_time < 0) != sitting;
    // rust: let sitting_down = sitting && (0..SIT_DOWN).contains(&pose_time);
    // rust: let transition = (0..if sitting { SIT_DOWN } else { STAND_UP }).contains(&pose_time);
    // rust: let dashing = m.extra.flag2;
    // rust: let st = &mut m.anim.states;
    // rust: if visually_sitting {
    // rust: st[2].stop();
    // rust: st[4].stop();
    // rust: if sitting_down {
    // rust: st[0].start_if_stopped(age);
    // rust: st[1].stop();
    // rust: } else {
    // rust: st[0].stop();
    // rust: st[1].start_if_stopped(age);
}
    // rust: } else {
    // rust: st[0].stop();
    // rust: st[1].stop();
    // rust: st[4].animate_when(dashing, age);
    // rust: st[2].animate_when(transition, age);
}
}
// `Camel.executeRidersJump`: the dash along the look, once cooled down. Returns whether the
// jump is used up: it is, by a dash or when the camel cannot dash at all (cooling down,
// refusing to move: `onPlayerJump` would not have taken it); it waits while the camel is off
// the ground (`AbstractHorse.tickRidden` runs a pending jump when it lands).
dash :: proc(m: ^Mob, amount: f32, events: ^[dynamic]MobEvent) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.extra.anim_ticks > 0 || refuse_to_move(m) {
    // rust: return true;
}
    // rust: if !m.on_ground {
    // rust: return false;
}
    // rust: let yaw = m.yaw.to_radians();
    // rust: let (dx, dz) = (f64::from(-yaw.msin()), f64::from(yaw.mcos()));
    // rust: let speed = m.movement_speed();
    // rust: let a = f64::from(amount);
    // rust: m.velocity.x += dx * 22.2222 * a * speed;
    // rust: m.velocity.z += dz * 22.2222 * a * speed;
    // rust: m.velocity.y += 1.4285 * a * 0.42;
    // rust: m.extra.anim_ticks = DASH_COOLDOWN;
    // rust: m.extra.flag2 = true;
    // rust: crate::motion::native_living_jump(m.id, &m.kind.id);
    // rust: sound(m, voice(m, 3), events);
    // rust: true
}
// `CamelModel.setupAnim`.
    // rust: pub fn anim(
    // rust: m: &Mob,
    // rust: s: &State,
    // rust: p: &mut Poses,
    // rust: animations: &HashMap<String, super::keyframes::Animation>,
    // rust: ) {
    // rust: let mut y = s.y_rot.clamp(-30.0, 30.0);
    // rust: let mut x = s.x_rot.clamp(-25.0, 45.0);
    // rust: let cooldown = (m.extra.anim_ticks as f32 - s.partial).max(0.0);
    // rust: if cooldown > 0.0 {
    // rust: x = (x + 45.0 * cooldown / 55.0).clamp(-25.0, 70.0);
}
    // rust: y = y.to_radians();
    // rust: p.yrot("head", y);
    // rust: p.xrot("head", x.to_radians());
    // rust: let prefix = if m.is_baby() {
    // rust: "CamelBabyAnimation.CAMEL_BABY_"
    // rust: } else {
    // rust: "CamelAnimation.CAMEL_"
}
    // rust: let get = |n: &str| animations.get(&format!("{prefix}{n}"));
    // rust: if let Some(walk) = get("WALK") {
    // rust: walk.apply_walk(s.pos, s.speed, 2.0, 2.5, p);
}
    // rust: let age = s.age;
    // rust: for (state, name) in [
    // rust: (&m.anim.states[0], "SIT"),
    // rust: (&m.anim.states[1], "SIT_POSE"),
    // rust: (&m.anim.states[2], "STANDUP"),
    // rust: (&m.anim.states[3], "IDLE"),
    // rust: (&m.anim.states[4], "DASH"),
    // rust: ] {
    // rust: if let (Some(ms), Some(a)) = (state.millis(age), get(name)) {
    // rust: a.apply(ms, 1.0, p);
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::{Anim, Brain, Flags, MobType, Part, Species};
//     use crate::mobs::{leash::Holder, world::with_test_world};
//     use horizon_core::geometry::Vec3;
//     use serde_json::json;
//     use std::sync::Arc;

    // `Camel.getPassengerAttachmentPoint`: the second of two passengers sits
    // 0.7 behind the middle, 0.5 ahead for the driver, 0.2 more for an animal.
the_second_passenger_sits_behind :: proc() {
}
    // rust: with_test_world(&[], |_, types| {
    // rust: let kind = std::sync::Arc::new(types.types["minecraft:camel_husk"].clone());
    // rust: let m = Mob::new(1, kind, Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: assert_eq!(passenger_attachment_at(&m, 0, 2, false)[2], 0.5);
    // rust: assert!((passenger_attachment_at(&m, 1, 2, false)[2] + 0.7).abs() < 1e-6);
    // rust: assert!((passenger_attachment_at(&m, 1, 2, true)[2] + 0.5).abs() < 1e-6);
    // rust: assert!((passenger_attachment_at(&m, 0, 2, true)[2] - 0.7).abs() < 1e-6);
    // rust: assert_eq!(passenger_attachment_at(&m, 0, 1, true)[2], 0.5);
    // rust: });
}

    // `CamelAi.RandomSitting.checkExtraStartConditions`: a camel sits down
    // only with no controlling passenger and no lead. A husk on its back
    // controls it (`Mob.getControllingPassenger`), a slime does not
    // (`#non_controlling_rider`), so a camel carrying a husk never sits
    // with it floating above (#3199).
a_camel_with_a_husk_on_its_back_never_sits_down :: proc() {
}
        // Whether the goal starts in 64 tries (each passes 1 in 4).
    // rust: let sits = |rider: Option<&str>, leashed: bool| {
    // rust: let mut seen = Vec::new();
    // rust: let mut camel = None;
    // rust: with_test_world(&[], |_, types| {
    // rust: let mob = |id: u32, name: &str| {
    // rust: let kind = std::sync::Arc::new(types.types[name].clone());
    // rust: Mob::new(id, kind, Vec3::new(0.5, 64.0, 0.5), 0.0)
}
    // rust: let mut m = mob(1, "minecraft:camel");
    // rust: if let Some(name) = rider {
    // rust: let mut r = mob(2, name);
    // rust: r.extra.mount = Some(m.id);
    // rust: m.extra.rider = Some(r.id);
    // rust: seen.push(r.seen(None));
}
    // rust: if leashed {
    // rust: m.extra.leash = Some(Holder::Mob(3));
}
    // rust: camel = Some(m);
    // rust: });
    // rust: let mut m = camel?;
    // rust: m.age = 1000;
    // rust: m.extra.egg_time = 0;
    // rust: m.on_ground = true;
    // rust: let mut started = false;
    // rust: with_test_world(&seen, |w, _| {
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: let mut cx = Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: started = (0..64).any(|_| RandomSitting.can_use(&mut m, &mut cx));
    // rust: });
    // rust: Some(started)
}
    // rust: let Some(alone) = sits(None, false) else {
    // rust: return;
}
    // rust: assert!(alone, "a camel with nothing on its back sits down");
    // rust: assert_eq!(sits(Some("minecraft:husk"), false), Some(false));
    // rust: assert_eq!(sits(Some("minecraft:slime"), false), Some(true));
    // rust: assert_eq!(sits(None, true), Some(false), "a leashed camel");
}

camel :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let model = Arc::new(Part::parse("root", &json!({"children": {"head": {}}})));
    // rust: let kind = Arc::new(MobType {
    // rust: id: "minecraft:camel".into(),
    // rust: species: Species::Camel,
    // rust: width: 1.7,
    // rust: height: 2.375,
    // rust: eye_height: 2.275,
    // rust: category: "creature".into(),
    // rust: max_health: 32.0,
    // rust: speed: 0.09,
    // rust: flying_speed: 0.4,
    // rust: attack_damage: 0.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 16.0,
    // rust: step_height: 1.5,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Arc::default(),
    // rust: item_stack_limits: Default::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.45,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 120,
    // rust: flags: Flags {
    // rust: animal: true,
    // rust: ..Default::default()
    // rust: },
    // rust: model,
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Camel,
    // rust: sounds: [""; 3],
    // rust: step_sound: None,
    // rust: food: Arc::default(),
    // rust: tempt: Arc::default(),
    // rust: });
    // rust: Mob::new(1, kind, horizon_core::geometry::Vec3::ZERO, 0.0)
}
types :: proc(m: ^Mob) -> H {
    // Ported from Horizon
    return {}
}
    // rust: HashMap::from([(m.kind.id.clone(), m.kind.clone())])
}

a_fresh_camel_can_move_at_once :: proc() {
}
        // Camel.finalizeSpawn: standUpInstantly, also at age 0.
    // rust: let mut m = camel();
    // rust: register(&mut m);
    // rust: assert_eq!(m.age, 0);
    // rust: assert!(!sitting(&m));
    // rust: assert!(!refuse_to_move(&m));
    // rust: stand_up_instantly(&mut m);
    // rust: assert!(!refuse_to_move(&m));
}

sitting_and_standing_up_take_their_transition_time :: proc() {
}
    // rust: let mut m = camel();
    // rust: register(&mut m);
    // rust: m.age = 100;
    // rust: let mut events = Vec::new();
    // rust: sit_down(&mut m, &mut events);
    // rust: assert!(sitting(&m) && refuse_to_move(&m));
    // rust: assert_eq!(pose_time(&m), 0);
    // rust: m.age += 40;
    // rust: assert!(sitting(&m) && refuse_to_move(&m));
    // rust: stand_up(&mut m, &mut events);
    // rust: assert!(!sitting(&m) && refuse_to_move(&m));
    // rust: m.age += 52;
    // rust: assert!(!refuse_to_move(&m));
}

last_pose_tick_is_a_time_not_a_sign :: proc() {
}
    // rust: let mut m = camel();
    // rust: register(&mut m);
    // rust: m.age = 30;
        // Stood up at game time 1000; now 1030.
    // rust: m.extra.egg_time = 0;
    // rust: assert_eq!(synced_pose_tick(&m, 1030), 1000);
    // rust: m.extra.camel_sitting = true;
    // rust: assert_eq!(synced_pose_tick(&m, 1030), -1000);
}

a_loaded_camel_keeps_its_pose_time :: proc() {
}
    // rust: let mut m = camel();
    // rust: register(&mut m);
    // rust: let types = types(&m);
    // rust: let load = |tick: i64, now: i64| {
    // rust: let (tag, _) = horizon_world::nbt::parse_snbt(&format!(
    // rust: "{{id:\"minecraft:camel\",Pos:[0.0d,0.0d,0.0d],LastPoseTick:{tick}L}}"
    // rust: ))
    // rust: .unwrap();
    // rust: let mut m = crate::entity_nbt::mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: finish_load(&mut m, now);
    // rust: m
}
        // Standing for a long time: free to move at once.
    // rust: let m = load(1000, 5000);
    // rust: assert!(!sitting(&m) && !refuse_to_move(&m));
        // Stood up 5 ticks ago: still getting up.
    // rust: let m = load(1000, 1005);
    // rust: assert!(!sitting(&m) && refuse_to_move(&m));
    // rust: assert_eq!(pose_time(&m), 5);
        // Sat 5 ticks ago: pose time 5, not 401.
    // rust: let m = load(-1000, 1005);
    // rust: assert!(sitting(&m));
    // rust: assert_eq!(pose_time(&m), 5);
        // No tag: standing.
    // rust: let (tag, _) =
    // rust: horizon_world::nbt::parse_snbt("{id:\"minecraft:camel\",Pos:[0.0d,0.0d,0.0d]}")
    // rust: .unwrap();
    // rust: let mut m = crate::entity_nbt::mob_from_nbt(&tag, &types, 2, None).unwrap();
    // rust: finish_load(&mut m, 5000);
    // rust: assert!(!refuse_to_move(&m));
}
}
