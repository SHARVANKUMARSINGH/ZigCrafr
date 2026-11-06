//! Transpiled from Horizon Rust crate
package horizon_client_dolphin

import "core:fmt"
import "core:mem"
import "core:math"

// Dolphin goals: `DolphinSwimToTreasureGoal`, `DolphinSwimWithPlayerGoal`
// and `DolphinJumpGoal`. `extra.flag` is `gotFish` and `extra.home` the
// `treasurePos` the game found for it (`MobEvent::DolphinTreasure`). `extra.point` is where the
// game saw the first item floating within 8 blocks (`Dolphin.ALLOWED_ITEMS`).
// use super::{
    // rust: Mob, MobEvent, Who,
    // rust: goals::{Cx, Goal, JUMP, LOOK, MOVE, goal_clone, reduced},
}
// use crate::blocks::Fluid;
// use horizon_core::geometry::trig::Mth;
// use horizon_core::random::RandomSource;

// `Entity.getMotionDirection`: the horizontal step of the yaw
// (`Direction.fromYRot`: south, west, north, east).
motion_step :: proc(yaw: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match (yaw / 90.0 + 0.5).floor() as i32 & 3 {
    // rust: 0 => [0, 1],
    // rust: 1 => [-1, 0],
    // rust: 2 => [0, -1],
    // rust: _ => [1, 0],
}
}

// `DolphinSwimToTreasureGoal`: a dolphin that was fed a fish leads the way to
// a shipwreck or an ocean ruin within 50 sectors.
SwimToTreasure :: struct {
    stuck: bool,
}
    // rust: impl SwimToTreasure {
    // `BlockPos.containing(x, dolphin.getY(), z).closerToCenterThan(position, 4)`.
arrived :: proc(m: ^Mob) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(t) = m.extra.home else { return false };
    // rust: let d = [
    // rust: f64::from(t[0]) + 0.5 - m.position.x,
    // rust: m.position.y.floor() + 0.5 - m.position.y,
    // rust: f64::from(t[2]) + 0.5 - m.position.z,
    // rust: ];
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] < 16.0
}
}
    // rust: impl Goal for SwimToTreasure {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.flag && m.air >= 100
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.home.is_some() && !Self::arrived(m) && !self.stuck && m.air >= 100
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.stuck = false;
    // rust: m.nav_stop();
        // The game looks for the structure and sets the position, or none.
    // rust: m.extra.home = None;
    // rust: cx.events.push(MobEvent::DolphinTreasure { mob: m.id });
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: if m.extra.home.is_none() || Self::arrived(m) || self.stuck {
    // rust: m.extra.flag = false;
}
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(t) = m.extra.home else { return };
    // rust: let close = m.ai.nav.target_pos.is_some_and(|p| {
    // rust: let d = [
    // rust: f64::from(p[0]) + 0.5 - m.position.x,
    // rust: f64::from(p[1]) + 0.5 - m.position.y,
    // rust: f64::from(p[2]) + 0.5 - m.position.z,
    // rust: ];
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] < 144.0
    // rust: });
    // rust: if !close && !m.ai.nav.is_done() {
    // rust: return;
}
    // rust: let treasure = [
    // rust: f64::from(t[0]) + 0.5,
    // rust: f64::from(t[1]) + 0.5,
    // rust: f64::from(t[2]) + 0.5,
    // rust: ];
    // rust: let eighth = f64::from(std::f32::consts::FRAC_PI_8);
    // rust: let half = f64::from(std::f32::consts::FRAC_PI_2);
    // rust: let mut next = m.default_random_pos_towards(cx.w, 16, 1, treasure, eighth);
    // rust: if next.is_none() {
    // rust: next = m.default_random_pos_towards(cx.w, 8, 4, treasure, half);
}
        // isPathfindable(WATER) is a water fluid state.
    // rust: if let Some(n) = next
    // rust: && cx.w.fluid(
    // rust: n[0].floor() as i32,
    // rust: n[1].floor() as i32,
    // rust: n[2].floor() as i32,
    // rust: ) != Fluid::Water
    // rust: {
    // rust: next = m.default_random_pos_towards(cx.w, 8, 5, treasure, half);
}
    // rust: let Some(next) = next else {
    // rust: self.stuck = true;
    // rust: return;
}
    // rust: let (y, x) = (m.kind.max_head_y_rot + 20.0, m.kind.max_head_x_rot);
    // rust: m.look_at_speed(next, y, x);
    // rust: m.nav_move_to(cx.w, next, 1.3);
    // rust: if m.random.next_int_bound(80).unwrap_or(1) == 0 {
            // Entity event 38: happy villager particles about the dolphin.
    // rust: cx.events.push(MobEvent::AroundSelf {
    // rust: mob: m.id,
    // rust: event: 38,
    // rust: kind: "happy_villager",
    // rust: feet: [m.position.x, m.position.y, m.position.z],
    // rust: width: f64::from(m.width()),
    // rust: height: f64::from(m.height()),
    // rust: burst: crate::particles::Burst::DOLPHIN,
    // rust: });
}
}
}

// `DolphinSwimWithPlayerGoal`: swim up to a swimming player and give them
// Dolphin's Grace.
SwimWithPlayer :: struct {
    speed: f64,
}
    // rust: impl SwimWithPlayer {
new :: proc(speed: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self { speed }
}
}
    // rust: impl Goal for SwimWithPlayer {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: MOVE | LOOK
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
        // getNearestPlayer(forNonCombat().range(10).ignoreLineOfSight()).
    // rust: m.can_see_player_through_walls(cx.w, 10.0)
    // rust: && cx.w.player.as_ref().is_some_and(|p| p.swimming)
    // rust: && m.ai.target != Some(Who::Player)
}
can_continue :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: cx.w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.swimming && m.distance_sqr(p.position) < 256.0)
}
start :: proc(self: ^Self, _: ^Mob, cx: ^Cx) {
}
    // rust: cx.events.push(grace());
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.nav_stop();
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(p) = cx.w.player.clone() else { return };
    // rust: let (y, x) = (m.kind.max_head_y_rot + 20.0, m.kind.max_head_x_rot);
    // rust: m.look_at_speed(p.eye, y, x);
    // rust: if m.distance_sqr(p.position) < 6.25 {
    // rust: m.nav_stop();
    // rust: } else {
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [p.position.x, p.position.y, p.position.z],
    // rust: 1,
    // rust: self.speed,
    // rust: );
}
    // rust: if p.swimming && m.random.next_int_bound(6).unwrap_or(1) == 0 {
    // rust: cx.events.push(grace());
}
}
}
// `MobEffectInstance(DOLPHINS_GRACE, 100)`.
grace :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: MobEvent::EffectPlayer {
    // rust: effect: "minecraft:dolphins_grace",
    // rust: ticks: 100,
    // rust: amplifier: 0,
    // rust: ambient: false,
}
}

// `DolphinJumpGoal`: leap out of clear water and arc back in.
Jump :: struct {
    interval: i32,
    breached: bool,
}
    // rust: impl Jump {
new :: proc(interval: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: interval: reduced(interval),
    // rust: breached: false,
}
}
}
    // rust: impl Goal for Jump {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: JUMP | MOVE
}
interruptable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if m.random.next_int_bound(self.interval).unwrap_or(1) != 0 {
    // rust: return false;
}
    // rust: let [sx, sz] = motion_step(m.yaw);
    // rust: let (bx, by, bz) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let w = cx.w;
    // rust: [0, 1, 4, 5, 6, 7].into_iter().all(|i| {
    // rust: let (x, z) = (bx + sx * i, bz + sz * i);
            // waterIsClear, then surfaceIsClear.
    // rust: w.fluid(x, by, z) == Fluid::Water
    // rust: && !w.has_tag("minecraft:blocks_dolphin_jump", w.block_name(x, by, z))
    // rust: && w.facts.is_air(w.world.block(x, by + 1, z))
    // rust: && w.facts.is_air(w.world.block(x, by + 2, z))
    // rust: })
}
can_continue :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let yd = m.velocity.y;
    // rust: (yd * yd >= f64::from(0.03f32)
    // rust: || m.head_pitch == 0.0
    // rust: || m.head_pitch.abs() >= 10.0
    // rust: || !m.fluids.in_water)
    // rust: && !m.on_ground
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: let [sx, sz] = motion_step(m.yaw);
    // rust: m.velocity.x += f64::from(sx) * 0.6;
    // rust: m.velocity.y += 0.7;
    // rust: m.velocity.z += f64::from(sz) * 0.6;
    // rust: m.nav_stop();
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.head_pitch = 0.0;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let already = self.breached;
    // rust: if !already {
    // rust: self.breached = cx.w.fluid(
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ) == Fluid::Water;
}
    // rust: if self.breached && !already {
    // rust: m.sound("entity.dolphin.jump", cx.events);
}
    // rust: let v = m.velocity;
    // rust: if v.y * v.y < f64::from(0.03f32) && m.head_pitch != 0.0 {
            // Mth.rotLerp(0.2, xRot, 0).
    // rust: m.head_pitch += 0.2 * super::living::wrap(0.0 - m.head_pitch);
    // rust: } else if v.length() > f64::from(1.0e-5f32) {
    // rust: let horizontal = v.x.hypot(v.z);
    // rust: m.head_pitch = ((-v.y).atan2(horizontal) * f64::from(180.0f32)
    // rust: / f64::from(std::f32::consts::PI)) as f32;
}
}
}

// `FollowPlayerRiddenEntityGoal(mob, AbstractBoat / AbstractNautilus)`: a
// dolphin swims to the back of a boat or nautilus a player steers within 5
// blocks of it, then ahead of it in the direction it moves, and goes back
// when it is more than 12 blocks off.
//
// Only the player the mob sees (the nearest) is considered.
FollowPlayerRidden :: struct {
    nautilus: bool,
    following: bool,
    recalc: i32,
    leading: bool,
}
    // rust: impl FollowPlayerRidden {
new :: proc(nautilus: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: nautilus,
    // rust: following: false,
    // rust: recalc: 0,
    // rust: leading: false,
}
}
    // `Entity.hasMovedHorizontallyRecently` of the rider, and the player's
    // own position (its yaw gives the directions).
    // rust: fn rider<'a>(&self, cx: &'a Cx) -> Option<&'a super::PlayerView> {
    // rust: cx.w.player.as_ref().filter(|p| {
    // rust: p.vehicle
    // rust: .as_ref()
    // rust: .is_some_and(|v| v.nautilus == self.nautilus)
    // rust: })
}
moved :: proc(p: ^super::PlayerView) -> b {
    // Ported from Horizon
    return {}
}
    // rust: p.vehicle.as_ref().is_some_and(|v| {
    // rust: (v.velocity.x * v.velocity.x + v.velocity.z * v.velocity.z).sqrt() > 1.0e-5
    // rust: })
}
}
    // rust: impl Goal for FollowPlayerRidden {
    // rust: goal_clone!();
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "FollowPlayerRiddenEntityGoal"
}
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
    // `FollowPlayerRiddenEntityGoal.canUse`.
can_use :: proc(self: ^Self, m: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = self.rider(cx) else {
    // rust: return false;
}
    // rust: if self.following && Self::moved(p) {
    // rust: return true;
}
    // rust: let area = m
    // rust: .bounds()
    // rust: .inflate(horizon_core::geometry::Vec3::new(5.0, 5.0, 5.0));
    // rust: p.vehicle
    // rust: .as_ref()
    // rust: .is_some_and(|v| v.bounds.intersects(area))
    // rust: && Self::moved(p)
}
    // `FollowPlayerRiddenEntityGoal.canContinueToUse`.
can_continue :: proc(self: ^Self, _: ^Mob, cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.following
    // rust: && self
    // rust: .rider(cx)
    // rust: .is_some_and(|p| p.passenger && Self::moved(p))
}
    // `FollowPlayerRiddenEntityGoal.start`.
start :: proc(self: ^Self, _: ^Mob, cx: ^Cx) {
}
    // rust: self.following = self.rider(cx).is_some();
    // rust: self.recalc = 0;
    // rust: self.leading = false;
}
    // `FollowPlayerRiddenEntityGoal.stop`.
stop :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.following = false;
}
    // `FollowPlayerRiddenEntityGoal.tick`.
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(p) = self.rider(cx) else { return };
    // rust: let (position, yaw) = (p.position, p.yaw);
    // rust: let speed = if self.leading { 0.01 } else { 0.015 };
    // rust: let input = horizon_core::geometry::Vec3::new(
    // rust: f64::from(m.ai.xxa),
    // rust: f64::from(m.ai.yya),
    // rust: f64::from(m.ai.zza),
    // rust: );
    // rust: m.move_relative(speed, input);
    // rust: m.do_move(cx.w, cx.events);
    // rust: self.recalc -= 1;
    // rust: if self.recalc > 0 {
    // rust: return;
}
    // rust: self.recalc = reduced(10);
    // rust: let [dx, dz] = motion_step(yaw);
    // rust: let block = [
    // rust: position.x.floor() as i32,
    // rust: position.y.floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ];
    // rust: if !self.leading {
            // The block behind the player, one lower.
    // rust: let behind = [block[0] - dx, block[1] - 1, block[2] - dz];
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [
    // rust: f64::from(behind[0]),
    // rust: f64::from(behind[1]),
    // rust: f64::from(behind[2]),
    // rust: ],
    // rust: 1.0,
    // rust: );
    // rust: if m.distance_sqr(position) < 16.0 {
    // rust: self.recalc = 0;
    // rust: self.leading = true;
}
    // rust: } else {
    // rust: let ahead = [block[0] + dx * 10, block[1] - 1, block[2] + dz * 10];
    // rust: m.nav_move_to(
    // rust: cx.w,
    // rust: [
    // rust: f64::from(ahead[0]),
    // rust: f64::from(ahead[1]),
    // rust: f64::from(ahead[2]),
    // rust: ],
    // rust: 1.0,
    // rust: );
    // rust: if m.distance_sqr(position) > 144.0 {
    // rust: self.recalc = 0;
    // rust: self.leading = false;
}
}
}
}

// Where the first item floating in the water within 8 blocks lies (`Dolphin.ALLOWED_ITEMS`:
// no pickup delay, alive, in water), found by the game each tick.
set_item_at :: proc(m: ^Mob, at: Maybe([f64; 3])) {
}
    // rust: m.extra.point = at;
}
// `Dolphin.ItemGoal.drop` of the item in the mouth (`dropItem`): thrown from the eye, in
// the direction it faces, with a pickup delay of 40. False when the mouth is empty.
drop_item :: proc(m: ^Mob, events: ^[dynamic]MobEvent) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(stack) = super::finalize::item_stack(m, super::equip::Slot::MainHand.index()) else {
    // rust: return false;
}
    // rust: let y_hand = m.eye_y() - f64::from(0.3_f32);
    // rust: let pow = 0.3_f32;
    // rust: let dir = m.random.next_float() * (std::f32::consts::PI * 2.0);
    // rust: let pow2 = 0.02_f32 * m.random.next_float();
    // rust: let to_rad = std::f32::consts::PI / 180.0;
    // rust: let (yaw, pitch) = (m.yaw * to_rad, m.head_pitch * to_rad);
    // rust: let motion = [
    // rust: f64::from(pow * -yaw.msin() * pitch.mcos() + dir.mcos() * pow2),
    // rust: f64::from(pow * pitch.msin() * 1.5),
    // rust: f64::from(pow * yaw.mcos() * pitch.mcos() + dir.msin() * pow2),
    // rust: ];
    // rust: events.push(MobEvent::ThrowItem {
    // rust: mob: m.id,
    // rust: stack,
    // rust: at: [m.position.x, y_hand, m.position.z],
    // rust: motion,
    // rust: pickup_delay: 40,
    // rust: });
    // rust: m.extra.set_main_hand_stack(None);
    // rust: true
}
// `Dolphin.MoveToItemGoal`: swim to a floating item, playing a sound; drops what it holds
// when it stops and rests for up to 100 ticks.
MoveToItem :: struct {
    cooldown: i64,
}
    // rust: impl Goal for MoveToItem {
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
    // rust: if self.cooldown > cx.w.game_time {
    // rust: return false;
}
    // rust: m.extra.point.is_some()
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if drop_item(m, cx.events) {
    // rust: self.cooldown = cx.w.game_time + i64::from(m.random.next_int_bound(100).unwrap_or(0));
}
}
start :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(at) = m.extra.point {
    // rust: m.nav_move_to_entity(cx.w, at, 0, f64::from(1.2_f32));
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.dolphin.play",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
    // rust: self.cooldown = 0;
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: if let Some(at) = m.extra.point {
    // rust: m.nav_move_to_entity(cx.w, at, 0, f64::from(1.2_f32));
}
}
}
// `Dolphin.PlayWithItemsGoal`: a dolphin that holds something throws it away.
PlayWithItems :: struct {
    // rust: impl Goal for PlayWithItems {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, _cx: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.extra.main_hand.is_some()
}
stop :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: drop_item(m, cx.events);
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: drop_item(m, cx.events);
}
}

    // rust: mod item_tests {
//     use super::*;
//     use crate::items::ItemStack;
//     use crate::mobs::{Species, sensor_scan_tests::kind};
//     use horizon_core::geometry::Vec3;

dolphin :: proc() -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:dolphin".into();
    // rust: k.species = Species::Dolphin;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

    // `Dolphin.ItemGoal.dropItem`: a dolphin facing south (yaw 0, level) throws the item
    // forward (+Z) at 0.3, off by at most 0.02 sideways, with a pickup delay of 40, and
    // its mouth is empty after. An empty mouth throws nothing.
a_dolphin_throws_its_item_ahead_and_empties_its_mouth :: proc() {
}
    // rust: let mut m = dolphin();
    // rust: let mut events = Vec::new();
    // rust: assert!(!drop_item(&mut m, &mut events), "nothing to throw");
    // rust: assert!(events.is_empty());
    // rust: let stack = ItemStack {
    // rust: item: "minecraft:cod".into(),
    // rust: count: 3,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: crate::mobs::finalize::set_item_stack(
    // rust: &mut m,
    // rust: crate::mobs::equip::Slot::MainHand.index(),
    // rust: stack,
    // rust: );
    // rust: assert!(drop_item(&mut m, &mut events));
    // rust: let [
    // rust: MobEvent::ThrowItem {
    // rust: stack,
    // rust: motion,
    // rust: pickup_delay,
    // rust: ..
    // rust: },
    // rust: ] = events.as_slice()
    // rust: else {
    // rust: panic!("one thrown item, got {events:?}");
}
    // rust: assert_eq!(
    // rust: (&*stack.item, stack.count, *pickup_delay),
    // rust: ("minecraft:cod", 3, 40)
    // rust: );
    // rust: assert!(
    // rust: motion[0].abs() <= 0.02 + 1e-6,
    // rust: "sideways at most 0.02: {motion:?}"
    // rust: );
    // rust: assert!(
    // rust: (motion[2] - 0.3).abs() <= 0.02 + 1e-6,
    // rust: "ahead at 0.3: {motion:?}"
    // rust: );
    // rust: assert_eq!(motion[1], 0.0, "level, so no climb");
    // rust: assert!(m.extra.main_hand.is_none(), "the mouth is empty");
}
}

    // rust: mod target_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;
//     use crate::mobs::{Species, sensor_scan_tests::kind};
//     use horizon_core::geometry::Vec3;

dolphin :: proc(baby: bool) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let mut kind = kind();
    // rust: let k = std::sync::Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:dolphin".into();
    // rust: k.species = Species::Dolphin;
    // rust: let mut m = Mob::new(1, kind, Vec3::ZERO, 0.0);
    // rust: m.extra.age = if baby { -24000 } else { 0 };
    // rust: m
}

    // `Dolphin.canAttack`: a baby takes nobody as its target, so a hit on it
    // is not answered; an adult does take the one that hurt it.
a_baby_dolphin_spares_whatever_hurt_it :: proc() {
}
    // rust: let ran = with_test_world(&[], |w, _| {
    // rust: assert!(
    // rust: dolphin(true).spares_target(w, Who::Mob(7)),
    // rust: "a baby dolphin fights nobody"
    // rust: );
    // rust: assert!(
    // rust: !dolphin(false).spares_target(w, Who::Mob(7)),
    // rust: "an adult dolphin takes its attacker"
    // rust: );
    // rust: });
    // rust: let _ = ran;
}
}
