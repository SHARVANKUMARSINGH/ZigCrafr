//! Transpiled from Horizon Rust crate
//! Module: horizon-client_vex
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vexes (`Vex`): summoned by evokers, flying through walls around their
//! bound origin, charging at their target, and wasting away after their
//! limited life.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, Species, Who,
    // rust: anim::{Poses, State},
    // rust: control::Operation,
    // rust: goals::{
    // rust: Cx, Float, Goal, HurtByTarget, LookAtPlayer, MOVE, NearestTarget, goal_clone, reduced,
    // rust: },
}
// use horizon_core::geometry::trig::Mth;
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use std::f32::consts::PI;

// Vex state: `flag` charging, `counter2` the owner's mob id (0 none),
// `home` the bound origin, `egg_time` the life left (-1 unlimited).

pub fn register(m: *mut Mob) void {
}
    // rust: m.no_gravity = true;
    // rust: m.ai.mov.kind = super::control::MoveKind::Custom;
    // rust: m.extra.set_main_hand(Some("minecraft:iron_sword".into()));
    // rust: if m.extra.egg_time == 0 {
    // rust: m.extra.egg_time = -1;
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(4, Charge);
    // rust: g.add(8, RandomMove);
    // rust: g.add(9, LookAtPlayer::new(3.0).probability(1.0));
    // rust: g.add(10, LookAtPlayer::mobs(8.0));
    // `HurtByTargetGoal(this, Raider.class)`: raiders are ignored, vexes are not.
    // rust: let mut hurt = HurtByTarget::new().alert();
    // rust: hurt.ignore = vec![
    // rust: Species::Pillager,
    // rust: Species::Vindicator,
    // rust: Species::Evoker,
    // rust: Species::Illusioner,
    // rust: Species::Witch,
    // rust: Species::Ravager,
    // rust: ];
    // rust: m.ai.targets.add(1, hurt);
    // rust: m.ai.targets.add(2, CopyOwnerTarget);
    // rust: m.ai.targets.add(3, NearestTarget::player(true));
}
pub fn has_wanted(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.mov.operation == Operation::MoveTo
}
pub fn set_wanted(m: *mut Mob, at: [f64; 3], speed: f64) void {
}
    // rust: m.ai.mov.wanted = at;
    // rust: m.ai.mov.speed_modifier = speed;
    // rust: m.ai.mov.operation = Operation::MoveTo;
}
/// `VexChargeAttackGoal`.
pub const Charge = struct {};
    // rust: impl Goal for Charge {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(t) = m.target_info(cx.w).filter(|t| t.alive) else {
    // rust: return false;
}
    // rust: !has_wanted(m)
    // rust: && m.random.next_int_bound(reduced(7)).unwrap_or(1) == 0
    // rust: && m.distance_sqr(t.position) > 4.0
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: has_wanted(m) && m.extra.flag && m.target_info(cx.w).is_some_and(|t| t.alive)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(t) = m.target_info(cx.w) {
    // rust: set_wanted(m, [t.position.x, t.eye_y, t.position.z], 1.0);
}
    // rust: m.extra.flag = true;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.vex.charge",
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
pub fn stop(self: *Self, m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: m.extra.flag = false;
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let (Some(who), Some(t)) = (m.ai.target, m.target_info(cx.w)) else {
    // rust: return;
}
    // rust: if m.bounds().intersects(t.bounds) {
    // rust: super::ai::do_hurt_target(m, who, cx);
    // rust: m.extra.flag = false;
    // rust: } else if m.distance_sqr(t.position) < 9.0 {
    // rust: set_wanted(m, [t.position.x, t.eye_y, t.position.z], 1.0);
}
}
}
/// `VexRandomMoveGoal`: drift to an empty block near the bound origin.
pub const RandomMove = struct {};
    // rust: impl Goal for RandomMove {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, _cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !has_wanted(m) && m.random.next_int_bound(reduced(7)).unwrap_or(1) == 0
}
pub fn can_continue(self: *Self, _m: *mut Mob, _cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
        // Ticked once: the goal never continues.
    // rust: let origin = m.extra.home.unwrap_or([
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ]);
    // rust: for _ in 0..3 {
    // rust: let r = &mut m.random;
    // rust: let p = [
    // rust: origin[0] + r.next_int_bound(15).unwrap_or(7) - 7,
    // rust: origin[1] + r.next_int_bound(11).unwrap_or(5) - 5,
    // rust: origin[2] + r.next_int_bound(15).unwrap_or(7) - 7,
    // rust: ];
    // rust: if cx.w.facts.is_air(cx.w.world.block(p[0], p[1], p[2])) {
    // rust: let at = [
    // rust: f64::from(p[0]) + 0.5,
    // rust: f64::from(p[1]) + 0.5,
    // rust: f64::from(p[2]) + 0.5,
    // rust: ];
    // rust: set_wanted(m, at, 0.25);
    // rust: if m.ai.target.is_none() {
    // rust: m.look_at_speed(at, 180.0, 20.0);
}
    // rust: break;
}
}
}
}
/// `VexCopyOwnerTargetGoal`: the evoker's target.
pub const CopyOwnerTarget = struct {};
    // rust: impl Goal for CopyOwnerTarget {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::goals::TARGET
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let owner = m.extra.counter2 as u32;
    // rust: owner != 0
    // rust: && cx
    // rust: .w
    // rust: .others
    // rust: .iter()
    // rust: .find(|s| s.id == owner)
    // rust: .and_then(|s| s.target)
    // rust: .is_some_and(|t| t != Who::Mob(m.id))
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.target_info(cx.w).is_some_and(|t| t.alive)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let owner = m.extra.counter2 as u32;
    // rust: m.ai.target =
    // rust: cx.w.others
    // rust: .iter()
    // rust: .find(|s| s.id == owner)
    // rust: .and_then(|s| s.target);
}
}
/// `VexMoveControl`: accelerate straight at the wanted point.
pub fn move_control(m: *mut Mob) void {
}
    // rust: if m.ai.mov.operation != Operation::MoveTo {
    // rust: return;
}
    // rust: let [wx, wy, wz] = m.ai.mov.wanted;
    // rust: let d = Vec3::new(wx - m.position.x, wy - m.position.y, wz - m.position.z);
    // rust: let len = (d.x * d.x + d.y * d.y + d.z * d.z).sqrt();
    // rust: let b = m.bounds();
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let size = ((hi.x - lo.x) + (hi.y - lo.y) + (hi.z - lo.z)) / 3.0;
    // rust: if len < size {
    // rust: m.ai.mov.operation = Operation::Wait;
    // rust: m.velocity = m.velocity.scale(0.5);
    // rust: return;
}
    // rust: m.velocity = m
    // rust: .velocity
    // rust: .add_vector(d.scale(m.ai.mov.speed_modifier * 0.05 / len));
    // rust: let yaw = match m.extra.point.filter(|_| m.ai.target.is_some()) {
    // rust: Some(t) => -((t[0] - m.position.x).atan2(t[2] - m.position.z) as f32).to_degrees(),
    // rust: None => -(m.velocity.x.atan2(m.velocity.z) as f32).to_degrees(),
}
    // rust: m.yaw = yaw;
    // rust: m.body_yaw = yaw;
}
/// `Vex` travel with `noPhysics`: straight through blocks, air friction.
pub fn travel(m: *mut Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.position = m.position.add_vector(m.velocity);
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x * 0.91,
    // rust: m.velocity.y * 0.98,
    // rust: m.velocity.z * 0.91,
    // rust: );
    // rust: m.on_ground = false;
    // rust: true
}
/// `Vex.tick`: the limited life costs a heart a second once spent.
pub fn ai_step(m: *mut Mob, w: *super::MobWorld) void {
}
    // rust: m.extra.point = m
    // rust: .target_info(w)
    // rust: .map(|t| [t.position.x, t.position.y, t.position.z]);
    // rust: if m.extra.egg_time > 0 {
    // rust: m.extra.egg_time -= 1;
    // rust: if m.extra.egg_time == 0 {
    // rust: m.extra.egg_time = 20;
    // rust: m.damage(1.0, Damage::of(DamageKind::Generic));
}
}
}
/// `VexModel.setupAnim`.
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: let bob = (s.age * 5.5 * horizon_core::geometry::trig::DEG_TO_RAD).mcos() * 0.1;
    // rust: p.zrot("right_arm", PI / 5.0 + bob);
    // rust: p.zrot("left_arm", -(PI / 5.0 + bob));
    // rust: if m.extra.flag {
    // rust: p.xrot("body", 0.0);
        // setArmsCharging
    // rust: let (right, left) = (m.extra.main_hand.is_some(), m.extra.off_hand.is_some());
    // rust: if !right && !left {
    // rust: p.xrot("right_arm", -1.221_730_5);
    // rust: p.yrot("right_arm", PI / 12.0);
    // rust: p.zrot("right_arm", -0.471_238_88 - bob);
    // rust: p.xrot("left_arm", -1.221_730_5);
    // rust: p.yrot("left_arm", -PI / 12.0);
    // rust: p.zrot("left_arm", 0.471_238_88 + bob);
    // rust: } else {
    // rust: let sword = (std::f64::consts::PI * 7.0 / 6.0) as f32;
    // rust: if right {
    // rust: p.xrot("right_arm", sword);
    // rust: p.yrot("right_arm", PI / 12.0);
    // rust: p.zrot("right_arm", -0.471_238_88 - bob);
}
    // rust: if left {
    // rust: p.xrot("left_arm", sword);
    // rust: p.yrot("left_arm", -PI / 12.0);
    // rust: p.zrot("left_arm", 0.471_238_88 + bob);
}
}
    // rust: } else {
    // rust: p.xrot("body", PI / 20.0);
}
    // rust: let deg = horizon_core::geometry::trig::DEG_TO_RAD;
    // rust: let wing = 1.099_557_4 + (s.age * 45.836_624 * deg).mcos() * deg * 16.2;
    // rust: p.yrot("left_wing", wing);
    // rust: p.yrot("right_wing", -wing);
    // rust: p.xrot("left_wing", 0.471_238_88);
    // rust: p.zrot("left_wing", -0.471_238_88);
    // rust: p.xrot("right_wing", 0.471_238_88);
    // rust: p.zrot("right_wing", 0.471_238_88);
}
/// The vex's texture: brighter while charging.
pub fn texture(m: *Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.extra.flag {
    // rust: "entity/illager/vex_charging"
    // rust: } else {
    // rust: "entity/illager/vex"
}
}
