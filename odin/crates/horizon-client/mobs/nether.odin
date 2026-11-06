//! Transpiled from Horizon Rust crate
package horizon_client_nether

import "core:fmt"
import "core:mem"
import "core:math"

// Nether flyers: blazes (hovering, three-fireball volleys, the spinning
// rods) and ghasts (floating about, charging and shooting large fireballs).
// use super::{
    // rust: Mob, MobEvent, MobWorld, Who,
    // rust: anim::{Poses, State},
    // rust: control::{MoveKind, Operation},
    // rust: goals::{
    // rust: Cx, Goal, HurtByTarget, LOOK, LookAtPlayer, MOVE, NearestTarget, RandomLookAround, Stroll,
    // rust: goal_clone,
    // rust: },
}
// use crate::projectiles::{Projectile, ProjectileKind};
// use horizon_core::geometry::trig::Mth;
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}
// use std::f32::consts::PI;

// `RandomSource.triangle(mode, deviation)`.
triangle :: proc(m: ^Mob, mode: f64, deviation: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: mode + deviation * (m.random.next_double() - m.random.next_double())
}

register_blaze :: proc(m: ^Mob) {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(4, BlazeAttack::default());
    // rust: g.add(7, Stroll::avoiding_water(1.0));
    // rust: g.add(8, LookAtPlayer::new(8.0));
    // rust: g.add(8, RandomLookAround::default());
    // rust: m.ai.targets.add(1, HurtByTarget::new().alert());
    // rust: m.ai.targets.add(2, NearestTarget::player(true));
}
// `Blaze.BlazeAttackGoal`: melee up close, otherwise a 3-second charge and
// three small fireballs, then a five-second rest.
BlazeAttack :: struct {
    step: i32,
    time: i32,
    last_seen: i32,
}
    // rust: impl Goal for BlazeAttack {
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
    // rust: m.ai.target
    // rust: .and_then(|t| cx.w.target_info(t))
    // rust: .is_some_and(|t| t.alive && !(t.is_player && t.creative))
}
start :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.step = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.extra.flag = false;
    // rust: self.last_seen = 0;
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: self.time -= 1;
    // rust: let Some(who) = m.ai.target else {
    // rust: return;
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let sees = m.sees(cx.w, who);
    // rust: if sees {
    // rust: self.last_seen = 0;
    // rust: } else {
    // rust: self.last_seen += 1;
}
    // rust: let d2 = m.distance_sqr(t.position);
    // rust: let follow = m.attrs.follow_range;
    // rust: let wanted = [t.position.x, t.position.y, t.position.z];
    // rust: if d2 < 4.0 {
    // rust: if !sees {
    // rust: return;
}
    // rust: if self.time <= 0 {
    // rust: self.time = 20;
    // rust: super::ai::do_hurt_target(m, who, cx);
}
    // rust: m.ai.mov.set_wanted(wanted[0], wanted[1], wanted[2], 1.0);
    // rust: } else if d2 < follow * follow && sees {
    // rust: let half = f64::from(m.height()) * 0.5;
    // rust: let xd = t.position.x - m.position.x;
    // rust: let yd = (t.bounds.min_position().y + t.bounds.max_position().y) * 0.5
    // rust: - (m.position.y + half);
    // rust: let zd = t.position.z - m.position.z;
    // rust: if self.time <= 0 {
    // rust: self.step += 1;
    // rust: if self.step == 1 {
    // rust: self.time = 60;
    // rust: m.extra.flag = true;
    // rust: } else if self.step <= 4 {
    // rust: self.time = 6;
    // rust: } else {
    // rust: self.time = 100;
    // rust: self.step = 0;
    // rust: m.extra.flag = false;
}
    // rust: if self.step > 1 {
    // rust: let sqd = d2.sqrt().sqrt() * 0.5;
    // rust: cx.events.push(MobEvent::Sound(
    // rust: "entity.blaze.shoot",
    // rust: m.center(),
    // rust: 1.0,
    // rust: (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0,
    // rust: ));
    // rust: let dir = [
    // rust: triangle(m, xd, 2.297 * sqd),
    // rust: yd,
    // rust: triangle(m, zd, 2.297 * sqd),
    // rust: ];
    // rust: let start = Vec3::new(m.position.x, m.position.y + half + 0.5, m.position.z);
    // rust: cx.events.push(MobEvent::Projectile(Projectile::fireball(
    // rust: ProjectileKind::SmallFireball,
    // rust: start,
    // rust: Some(Who::Mob(m.id)),
    // rust: dir,
    // rust: )));
}
}
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 10.0, 10.0);
    // rust: } else if self.last_seen < 5 {
    // rust: m.ai.mov.set_wanted(wanted[0], wanted[1], wanted[2], 1.0);
}
}
}
// `Blaze.aiStep`: slow falling, the burning sound and smoke.
blaze_ai_step :: proc(m: ^Mob, events: ^[dynamic]MobEvent) {
}
    // rust: if !m.on_ground && m.velocity.y < 0.0 {
    // rust: m.velocity.y *= 0.6;
}
    // rust: if m.random.next_int_bound(24).unwrap_or(1) == 0 {
    // rust: let volume = 1.0 + m.random.next_float();
    // rust: let pitch = m.random.next_float() * 0.7 + 0.3;
    // rust: events.push(MobEvent::Sound(
    // rust: "entity.blaze.burn",
    // rust: m.center(),
    // rust: volume,
    // rust: pitch,
    // rust: ));
}
    // getRandomX(0.5), getRandomY(), getRandomZ(0.5), at rest.
    // rust: let (w, h) = (f64::from(m.width()), f64::from(m.height()));
    // rust: for _ in 0..2 {
    // rust: let at = [
    // rust: m.position.x + w * (2.0 * m.random.next_double() - 1.0) * 0.5,
    // rust: m.position.y + h * m.random.next_double(),
    // rust: m.position.z + w * (2.0 * m.random.next_double() - 1.0) * 0.5,
    // rust: ];
    // rust: events.push(MobEvent::Particles {
    // rust: kind: "large_smoke",
    // rust: at,
    // rust: count: 0,
    // rust: });
}
}
// `Blaze.customServerAiStep`: rise toward a target above the allowed offset.
blaze_server_ai_step :: proc(m: ^Mob, cx: ^Cx) {
}
    // rust: m.extra.counter -= 1;
    // rust: if m.extra.counter <= 0 {
    // rust: m.extra.counter = 100;
    // rust: m.extra.vector[0] = triangle(m, 0.5, 6.891);
}
    // rust: if let Some(t) = m.ai.target.and_then(|t| cx.w.target_info(t))
    // rust: && t.alive
    // rust: && !(t.is_player && t.creative)
    // rust: && t.eye_y > m.eye_y() + m.extra.vector[0]
    // rust: {
    // rust: m.velocity.y += (0.3 - m.velocity.y) * 0.3;
}
}
// `BlazeModel.setupAnim`: three rings of rods circling and bobbing.
blaze_anim :: proc(s: ^State, p: ^Poses) {
}
    // rust: let age = s.age;
    // rust: let mut angle = age * PI * -0.1;
    // rust: for i in 0..4 {
    // rust: let part = p.get(&format!("part{i}"));
    // rust: part[1] = -2.0 + ((i * 2) as f32 + age).mul_add(0.25, 0.0).mcos();
    // rust: part[0] = angle.mcos() * 9.0;
    // rust: part[2] = angle.msin() * 9.0;
    // rust: angle += PI / 2.0;
}
    // rust: angle = PI / 4.0 + age * PI * 0.03;
    // rust: for i in 4..8 {
    // rust: let part = p.get(&format!("part{i}"));
    // rust: part[1] = 2.0 + (((i * 2) as f32 + age) * 0.25).mcos();
    // rust: part[0] = angle.mcos() * 7.0;
    // rust: part[2] = angle.msin() * 7.0;
    // rust: angle += PI / 2.0;
}
    // rust: angle = 0.471_238_94 + age * PI * -0.05;
    // rust: for i in 8..12 {
    // rust: let part = p.get(&format!("part{i}"));
    // rust: part[1] = 11.0 + ((i as f32 * 1.5 + age) * 0.5).mcos();
    // rust: part[0] = angle.mcos() * 5.0;
    // rust: part[2] = angle.msin() * 5.0;
    // rust: angle += PI / 2.0;
}
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: p.xrot("head", s.x_rot.to_radians());
}

register_ghast :: proc(m: ^Mob) {
}
    // rust: m.ai.mov.kind = MoveKind::Custom;
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(5, RandomFloatAround);
    // rust: g.add(7, GhastLook);
    // rust: g.add(7, GhastShoot { charge: 0 });
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: NearestTarget::player(true).when(|m, w| {
    // rust: w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| (p.position.y - m.position.y).abs() <= 4.0)
    // rust: }),
    // rust: );
}
// `Ghast.GhastMoveControl`: a push toward the wanted point every few ticks.
ghast_move_control :: proc(m: ^Mob, w: ^MobWorld) {
}
    // rust: if m.ai.mov.operation != Operation::MoveTo {
    // rust: return;
}
    // `floatDuration-- <= 0`: the test is on the value before the decrement.
    // rust: let before = m.extra.counter2;
    // rust: m.extra.counter2 -= 1;
    // rust: if before > 0 {
    // rust: return;
}
    // rust: m.extra.counter2 += m.random.next_int_bound(5).unwrap_or(0) + 2;
    // rust: let [wx, wy, wz] = m.ai.mov.wanted;
    // rust: let travel = Vec3::new(wx - m.position.x, wy - m.position.y, wz - m.position.z);
    // rust: let len = travel.length();
    // rust: if len < 1.0e-6 {
    // rust: return;
}
    // canReach: the swept box stays clear along the way.
    // rust: let b = m.bounds();
    // rust: let steps = len.ceil() as i32;
    // rust: let clear = (1..=steps).all(|i| {
    // rust: let f = f64::from(i) / f64::from(steps);
    // rust: let d = Vec3::new(travel.x * f, travel.y * f, travel.z * f);
    // rust: w.no_collision(Aabb::new(
    // rust: b.min_position().add_vector(d),
    // rust: b.max_position().add_vector(d),
    // rust: ))
    // rust: });
    // rust: if clear {
        // FLYING_SPEED 0.06 * 5 / 3.
    // rust: let speed = 0.06 * 5.0 / 3.0;
    // rust: m.velocity = m.velocity.add_vector(Vec3::new(
    // rust: travel.x / len * speed,
    // rust: travel.y / len * speed,
    // rust: travel.z / len * speed,
    // rust: ));
    // rust: } else {
    // rust: m.ai.mov.operation = Operation::Wait;
}
}
// `(180.0F / (float)Math.PI)` of `GhastLookGoal.tick`.
ghast_deg :: proc() -> f {
    // Ported from Horizon
    return {}
}
    // rust: 180.0_f32 / std::f32::consts::PI
}
// `Ghast.RandomFloatAroundGoal`.
RandomFloatAround :: struct {
    // rust: impl Goal for RandomFloatAround {
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
    // rust: if !m.ai.mov.has_wanted() {
    // rust: return true;
}
    // rust: let [x, y, z] = m.ai.mov.wanted;
    // rust: let d =
    // rust: (x - m.position.x).powi(2) + (y - m.position.y).powi(2) + (z - m.position.z).powi(2);
    // rust: !(1.0..=3600.0).contains(&d)
}
can_continue :: proc(self: ^Self, _: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
start :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: let c = m.position;
    // rust: let mut r = || f64::from(m.random.next_float() * 2.0 - 1.0) * 16.0;
        // `getSuitableFlyToPosition` with distanceToBlocks 0: the first random
        // position is the target (the mirror under the heightmap only follows
        // 64 rejected tries, which a ghast without a home never has).
    // rust: let t = [c.x + r(), c.y + r(), c.z + r()];
    // rust: m.ai.mov.set_wanted(t[0], t[1], t[2], 1.0);
}
}
// `Ghast.GhastLookGoal`: face the motion, or the target within 64 blocks.
GhastLook :: struct {
    // rust: impl Goal for GhastLook {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: LOOK
}
can_use :: proc(self: ^Self, _: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: match m.ai.target.and_then(|t| cx.w.target_info(t)) {
    // rust: None => {
    // rust: let v = m.velocity;
    // rust: m.yaw = -(horizon_core::geometry::trig::atan2(v.x, v.z) as f32) * ghast_deg();
    // rust: m.body_yaw = m.yaw;
}
    // rust: Some(t) => {
    // rust: if m.distance_sqr(t.position) < 4096.0 {
    // rust: let (dx, dz) = (t.position.x - m.position.x, t.position.z - m.position.z);
    // rust: m.yaw = -(horizon_core::geometry::trig::atan2(dx, dz) as f32) * ghast_deg();
    // rust: m.body_yaw = m.yaw;
}
}
}
}
}
// `Ghast.GhastShootFireballGoal`: a second of charging, then a fireball.
GhastShoot :: struct {
    charge: i32,
}
    // rust: impl Goal for GhastShoot {
    // rust: goal_clone!();
flags :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
can_use :: proc(self: ^Self, m: ^Mob, _: ^Cx) -> b {
    // Ported from Horizon
    return {}
}
    // rust: m.ai.target.is_some()
}
start :: proc(self: ^Self, _: ^Mob, _: ^Cx) {
}
    // rust: self.charge = 0;
}
stop :: proc(self: ^Self, m: ^Mob, _: ^Cx) {
}
    // rust: m.extra.flag = false;
}
every_tick :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
tick :: proc(self: ^Self, m: ^Mob, cx: ^Cx) {
}
    // rust: let Some(who) = m.ai.target else {
    // rust: return;
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: if m.distance_sqr(t.position) < 4096.0 && m.sees(cx.w, who) {
    // rust: self.charge += 1;
    // rust: if self.charge == 10 {
                // LevelEvent 1015: the warning cry, its pitch the client's.
    // rust: if !m.silent {
    // rust: cx.events.push(MobEvent::LevelEventSound {
    // rust: sound: "entity.ghast.warn",
    // rust: at: m.center(),
    // rust: volume: 10.0,
    // rust: spread: 0.2,
    // rust: });
}
}
    // rust: if self.charge == 20 {
    // rust: let yaw = m.yaw.to_radians();
    // rust: let view = [-f64::from(yaw.msin()), f64::from(yaw.mcos())];
    // rust: let half = f64::from(m.height()) * 0.5;
    // rust: let ty = (t.bounds.min_position().y + t.bounds.max_position().y) * 0.5;
    // rust: let dir = [
    // rust: t.position.x - (m.position.x + view[0] * 4.0),
    // rust: ty - (0.5 + m.position.y + half),
    // rust: t.position.z - (m.position.z + view[1] * 4.0),
    // rust: ];
                // LevelEvent 1016: the shot, its pitch the client's.
    // rust: if !m.silent {
    // rust: cx.events.push(MobEvent::LevelEventSound {
    // rust: sound: "entity.ghast.shoot",
    // rust: at: m.center(),
    // rust: volume: 10.0,
    // rust: spread: 0.2,
    // rust: });
}
    // rust: let start = Vec3::new(
    // rust: m.position.x + view[0] * 4.0,
    // rust: m.position.y + half + 0.5,
    // rust: m.position.z + view[1] * 4.0,
    // rust: );
    // rust: cx.events.push(MobEvent::Projectile(Projectile::fireball(
    // rust: ProjectileKind::LargeFireball { power: 1 },
    // rust: start,
    // rust: Some(Who::Mob(m.id)),
    // rust: dir,
    // rust: )));
    // rust: self.charge = -40;
}
    // rust: } else if self.charge > 0 {
    // rust: self.charge -= 1;
}
    // rust: m.extra.flag = self.charge > 10;
}
}
// `GhastModel.animateTentacles`.
ghast_anim :: proc(s: ^State, p: ^Poses) {
}
    // rust: for i in 0..9 {
    // rust: let name = format!("tentacle{i}");
    // rust: if p.has(&name) {
    // rust: p.xrot(&name, 0.2 * (s.age * 0.3 + i as f32).msin() + 0.4);
}
}
}
