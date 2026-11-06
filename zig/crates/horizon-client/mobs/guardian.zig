//! Transpiled from Horizon Rust crate
//! Module: horizon-client_guardian
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Guardians and elder guardians (`Guardian`, `ElderGuardian`): the laser
//! charging for 80 (60) ticks before it strikes, spikes that hurt melee
//! attackers while still, flopping on land, the swimming move control, and
//! the elder's mining fatigue curse every minute.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: control::{MoveKind, Operation, rotlerp},
    // rust: goals::{
    // rust: Cx, Goal, LOOK, LookAtPlayer, MOVE, NearestTarget, RandomLookAround, Stroll, goal_clone,
    // rust: },
    // rust: nav::NavKind,
    // rust: path::PathType,
}
// use horizon_core::geometry::trig::Mth;
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use std::f32::consts::PI;

// Guardian state: `flag` an active beam target (DATA_ID_ATTACK_TARGET),
// `flag2` moving (DATA_ID_MOVING), `counter2` the client attack time.
// AnimState slots: tail animation, its speed, spikes animation.
pub const TAIL: usize = 0;
pub const TAIL_SPEED: usize = 1;
pub const SPIKES: usize = 2;
pub const EYE_X: usize = 3;
pub const EYE_Y: usize = 4;

pub fn is_elder(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.species() == Species::ElderGuardian
}
pub fn attack_duration(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if is_elder(m) { 60 } else { 80 }
}
pub fn register(m: *mut Mob) void {
}
    // rust: m.ai.mov.kind = MoveKind::Custom;
    // rust: m.ai.nav.kind = NavKind::Water { breach: false };
    // rust: m.set_malus(PathType::Water, 0.0);
    // rust: let t = m.random.next_float();
    // rust: m.anim.v[TAIL] = t;
    // rust: m.anim.vo[TAIL] = t;
    // rust: let elder = is_elder(m);
    // rust: if elder {
    // rust: m.persistent = true;
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(4, GuardianAttack { attack_time: 0 });
    // rust: g.add(7, Stroll::new(1.0).interval(if elder { 400 } else { 80 }));
    // rust: g.add(8, LookAtPlayer::new(8.0));
    // rust: g.add(9, RandomLookAround::default());
    // GuardianAttackSelector: players, squid and axolotls beyond 3 blocks.
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: NearestTarget::player(true).when(|m, w| {
    // rust: w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.position.distance_squared(m.position) > 9.0)
    // rust: }),
    // rust: );
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: NearestTarget::species(
    // rust: &[Species::Squid, Species::GlowSquid, Species::Axolotl],
    // rust: true,
    // rust: )
    // rust: .beyond(9.0),
    // rust: );
}
/// `GuardianAttackGoal`.
pub const GuardianAttack = struct {
    attack_time: i32,
};
    // rust: impl Goal for GuardianAttack {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
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
    // rust: m.target_info(cx.w).is_some_and(|t| t.alive)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.can_use(m, cx)
    // rust: && (is_elder(m)
    // rust: || m.target_info(cx.w)
    // rust: .is_some_and(|t| t.position.distance_squared(m.position) > 9.0))
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.attack_time = -10;
    // rust: m.ai.nav.stop();
    // rust: if let Some(t) = m.target_info(cx.w) {
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 90.0, 90.0);
}
}
pub fn stop(self: *Self, m: *mut Mob, _cx: *mut Cx) void {
}
    // rust: m.extra.flag = false;
    // rust: m.ai.target = None;
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let (Some(who), Some(t)) = (m.ai.target, m.target_info(cx.w)) else {
    // rust: return;
}
    // rust: m.ai.nav.stop();
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 90.0, 90.0);
    // rust: if !m.sees(cx.w, who) {
    // rust: m.ai.target = None;
    // rust: return;
}
    // rust: self.attack_time += 1;
    // rust: if self.attack_time == 0 {
    // rust: m.extra.flag = true;
    // rust: m.extra.counter2 = 0;
            // Entity event 21: the attack sound loop starts on the clients.
    // rust: if !m.silent {
    // rust: cx.events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 21,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
    // rust: } else if self.attack_time >= attack_duration(m) {
            // Indirect magic (1, +2 on Hard, +2 for the elder), then
            // doHurtTarget.
    // rust: let magic = 1.0
    // rust: + if cx.w.difficulty.hard { 2.0 } else { 0.0 }
    // rust: + if is_elder(m) { 2.0 } else { 0.0 };
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: match who {
    // rust: Who::Player => cx.events.push(MobEvent::DamagePlayer {
    // rust: amount: magic,
    // rust: from,
    // rust: kind: "minecraft:indirect_magic",
    // rust: }),
    // rust: Who::Mob(id) => cx.events.push(MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount: magic,
    // rust: source: Damage {
    // rust: kind: DamageKind::Magic,
    // rust: attacker: Some(Who::Mob(m.id)),
    // rust: from: Some(from),
    // rust: attacker_species: Some(m.species()),
    // rust: },
    // rust: }),
}
    // rust: super::ai::do_hurt_target(m, who, cx);
    // rust: m.ai.target = None;
}
}
}
/// `GuardianMoveControl`: swim straight at the wanted point with a wobble,
/// looking ahead.
pub fn move_control(m: *mut Mob) void {
}
    // rust: let moving = m.ai.mov.operation == Operation::MoveTo && !m.ai.nav.is_done();
    // rust: if !moving {
    // rust: m.set_speed(0.0);
    // rust: m.extra.flag2 = false;
    // rust: return;
}
    // rust: let [wx, wy, wz] = m.ai.mov.wanted;
    // rust: let d = Vec3::new(wx - m.position.x, wy - m.position.y, wz - m.position.z);
    // rust: let length = (d.x * d.x + d.y * d.y + d.z * d.z).sqrt();
    // rust: let (xd, yd, zd) = (d.x / length, d.y / length, d.z / length);
    // rust: let y_rot = (d.z.atan2(d.x).to_degrees() as f32) - 90.0;
    // rust: m.yaw = rotlerp(m.yaw, y_rot, 90.0);
    // rust: m.body_yaw = m.yaw;
    // rust: let target = (m.ai.mov.speed_modifier * m.movement_speed()) as f32;
    // rust: let speed = m.ai.speed + (target - m.ai.speed) * 0.125;
    // rust: m.set_speed(speed);
    // rust: let t = f64::from(m.age as i32 + m.id as i32);
    // rust: let push = (t * 0.5).sin() * 0.05;
    // rust: let (cos, sin) = (
    // rust: f64::from(m.yaw.to_radians().mcos()),
    // rust: f64::from(m.yaw.to_radians().msin()),
    // rust: );
    // rust: let y_push = (t * 0.75).sin() * 0.05;
    // rust: m.velocity = m.velocity.add_vector(Vec3::new(
    // rust: push * cos,
    // rust: y_push * (sin + cos) * 0.25 + f64::from(speed) * yd * 0.1,
    // rust: push * sin,
    // rust: ));
    // rust: let new_look = [
    // rust: m.position.x + xd * 2.0,
    // rust: m.eye_y() + yd / length,
    // rust: m.position.z + zd * 2.0,
    // rust: ];
    // rust: let old = if m.ai.look.cooldown > 0 {
    // rust: m.ai.look.wanted
    // rust: } else {
    // rust: new_look
}
    // rust: let lerp = |a: f64, b: f64| a + (b - a) * 0.125;
    // rust: m.look_at_speed(
    // rust: [
    // rust: lerp(old[0], new_look[0]),
    // rust: lerp(old[1], new_look[1]),
    // rust: lerp(old[2], new_look[2]),
    // rust: ],
    // rust: 10.0,
    // rust: 40.0,
    // rust: );
    // rust: m.extra.flag2 = true;
}
/// `Guardian.travelInWater`; on land the usual travel.
pub fn travel(m: *mut Mob, w: *MobWorld, input: Vec3, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.fluids.in_water {
    // rust: return false;
}
    // rust: m.move_relative(0.1, input);
    // rust: m.do_move(w, events);
    // rust: m.velocity = m.velocity.scale(0.9);
    // rust: if !m.extra.flag2 && m.ai.target.is_none() {
    // rust: m.velocity.y -= 0.005;
}
    // rust: true
}
/// `Guardian.aiStep`'s `clientSideTailAnimation` and
/// `clientSideSpikesAnimation` (the server's and a client's).
pub fn tail_and_spikes(m: *mut Mob) void {
}
    // rust: let moving = m.extra.flag2;
    // rust: let in_water = m.fluids.in_water;
    // Tail and spikes (clientSideTailAnimation / clientSideSpikesAnimation).
    // rust: let a = &mut m.anim;
    // rust: let speed = &mut a.v[TAIL_SPEED];
    // rust: if !in_water {
    // rust: *speed = 2.0;
    // rust: } else if moving {
    // rust: if *speed < 0.5 {
    // rust: *speed = 4.0;
    // rust: } else {
    // rust: *speed += (0.5 - *speed) * 0.1;
}
    // rust: } else {
    // rust: *speed += (0.125 - *speed) * 0.2;
}
    // rust: a.v[TAIL] += a.v[TAIL_SPEED];
    // rust: if !in_water {
    // rust: a.v[SPIKES] = m.random.next_float();
    // rust: } else if moving {
    // rust: a.v[SPIKES] += (0.0 - a.v[SPIKES]) * 0.25;
    // rust: } else {
    // rust: a.v[SPIKES] += (1.0 - a.v[SPIKES]) * 0.06;
}
}
/// `Guardian.aiStep`: the client animations, air, flopping on land, the
/// beam's clock, and the spikes' thorns.
pub fn ai_step(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: let moving = m.extra.flag2;
    // rust: let in_water = m.fluids.in_water;
    // rust: tail_and_spikes(m);
    // rust: client_tick(m);
    // rust: if in_water {
    // rust: m.air = 300;
    // rust: } else if m.on_ground {
    // rust: let r = &mut m.random;
    // rust: let (x, z) = (r.next_float() * 2.0 - 1.0, r.next_float() * 2.0 - 1.0);
    // rust: m.velocity = m
    // rust: .velocity
    // rust: .add_vector(Vec3::new(f64::from(x) * 0.4, 0.5, f64::from(z) * 0.4));
    // rust: m.yaw = m.random.next_float() * 360.0;
    // rust: m.on_ground = false;
    // rust: if !m.silent {
    // rust: let flop = if is_elder(m) {
    // rust: "entity.elder_guardian.flop"
    // rust: } else {
    // rust: "entity.guardian.flop"
}
    // rust: events.push(MobEvent::Sound(
    // rust: flop,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: 1.0,
    // rust: 1.0,
    // rust: ));
}
}
    // rust: if m.extra.flag {
    // rust: m.yaw = m.head_yaw;
}
    // The eye follows the active target, else the player (the camera).
    // rust: let look = match m.target_info(w).filter(|_| m.extra.flag) {
    // rust: Some(t) => Some([t.position.x, t.eye_y, t.position.z]),
    // rust: None => w.player.as_ref().map(|p| p.eye),
}
    // rust: if let Some(look) = look {
    // rust: look_at(m, look);
}
    // Guardian.hurtServer: a still guardian's spikes hurt a melee attacker.
    // rust: if m.hurt_time == 10
    // rust: && !moving
    // rust: && let Some((d, _)) = m.last_damage
    // rust: && matches!(
    // rust: d.kind,
    // rust: DamageKind::PlayerAttack
    // rust: | DamageKind::MaceSmash
    // rust: | DamageKind::Spear
    // rust: | DamageKind::MobAttack
    // rust: )
    // rust: {
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: match d.attacker {
    // rust: Some(Who::Player) => events.push(MobEvent::DamagePlayer {
    // rust: amount: 2.0,
    // rust: from,
    // rust: kind: "minecraft:thorns",
    // rust: }),
    // rust: Some(Who::Mob(id)) => events.push(MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount: 2.0,
    // rust: source: Damage {
    // rust: kind: DamageKind::Thorns,
    // rust: attacker: Some(Who::Mob(m.id)),
    // rust: from: Some(from),
    // rust: attacker_species: Some(m.species()),
    // rust: },
    // rust: }),
    // rust: None => {}
}
}
}
/// `GuardianModel.setupAnim`'s eye: it follows `look` (the attack target's
/// eye, else the camera's), from where the guardian faces.
pub fn look_at(m: *mut Mob, look: [f64; 3]) void {
}
    // rust: m.anim.v[EYE_Y] = if look[1] - m.eye_y() > 0.0 { 0.0 } else { 1.0 };
    // rust: let yaw = m.head_yaw.to_radians();
    // rust: let pitch = m.head_pitch.to_radians();
    // rust: let view = [-yaw.msin() * pitch.mcos(), yaw.mcos() * pitch.mcos()];
    // rust: let d = [m.position.x - look[0], m.position.z - look[2]];
    // rust: let len = (d[0] * d[0] + d[1] * d[1]).sqrt().max(1e-9);
    // rust: let (dx, dz) = ((d[0] / len) as f32, (d[1] / len) as f32);
    // Vec3.yRot(pi / 2) of the direction from the target.
    // rust: let side = [dz, -dx];
    // rust: let dot = view[0] * side[0] + view[1] * side[1];
    // rust: m.anim.v[EYE_X] = dot.abs().sqrt() * 2.0 * dot.signum();
}
/// The GUARDIAN_ELDER_EFFECT parameter of an elder's curse
/// (`isSilent() ? 0.0F : 1.0F`); the client plays the curse sound only for 1.
pub fn elder_curse_param(silent: bool) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if silent { 0.0 } else { 1.0 }
}
/// `ElderGuardian.customServerAiStep`: every minute, mining fatigue III for
/// players within 50 blocks; a home within 16 blocks.
pub fn elder_server_ai_step(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if (m.age as i64 + i64::from(m.id)) % 1200 == 0 {
    // rust: cx.events.push(MobEvent::ElderCurse {
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: silent: m.silent,
    // rust: });
}
    // rust: if m.ai.home.is_none() {
    // rust: m.ai.home = Some((
    // rust: [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ],
    // rust: 16,
    // rust: ));
}
}
    // rust: mod elder_home_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;
//     use horizon_core::random::LegacyRandom;
//     use std::sync::Arc;

    /// `ElderGuardian.customServerAiStep`: with no home yet, `setHomeTo(blockPosition(), 16)`,
    /// the restriction its wandering goals read (`Mob::restricted`); a home it has is kept.
pub fn an_elder_guardian_homes_where_it_stands() void {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: let kind = Arc::new(types.types["minecraft:elder_guardian"].clone());
    // rust: let mut lr = LegacyRandom::new(0);
    // rust: let mut events = Vec::new();
    // rust: let mut m = Mob::new(1, kind.clone(), Vec3::new(10.7, 64.2, -20.9), 0.0);
    // rust: elder_server_ai_step(
    // rust: &mut m,
    // rust: &mut Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: },
    // rust: );
    // rust: assert_eq!(m.ai.home, Some(([10, 64, -21], 16)));
    // rust: assert!(!m.restricted(0.0, [20, 64, -21]));
    // rust: assert!(m.restricted(0.0, [27, 64, -21]));

    // rust: let mut kept = Mob::new(2, kind, Vec3::new(10.0, 64.0, 20.0), 0.0);
    // rust: kept.ai.home = Some(([100, 50, 100], 24));
    // rust: elder_server_ai_step(
    // rust: &mut kept,
    // rust: &mut Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: },
    // rust: );
    // rust: assert_eq!(kept.ai.home, Some(([100, 50, 100], 24)));
    // rust: });
}

    /// `ElderGuardian.customServerAiStep`: on its minute (`(tickCount + getId()) % 1200 == 0`)
    /// the curse goes out with `isSilent() ? 0.0F : 1.0F`, and
    /// `ClientPacketListener.handleGameEvent` plays the curse sound only for 1.
pub fn a_silent_elder_guardian_curses_without_the_sound() void {
}
    // rust: with_test_world(&[], |w, types| {
    // rust: let kind = Arc::new(types.types["minecraft:elder_guardian"].clone());
    // rust: let mut lr = LegacyRandom::new(0);
    // rust: for silent in [false, true] {
    // rust: let mut events = Vec::new();
    // rust: let mut m = Mob::new(1200, kind.clone(), Vec3::new(0.5, 64.0, 0.5), 0.0);
    // rust: m.silent = silent;
    // rust: elder_server_ai_step(
    // rust: &mut m,
    // rust: &mut Cx {
    // rust: w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
    // rust: },
    // rust: );
    // rust: let curses: Vec<_> = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::ElderCurse { silent, .. } => Some(*silent),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(curses, [silent]);
}
    // rust: });
    // rust: assert_eq!(elder_curse_param(false), 1.0);
    // rust: assert_eq!(elder_curse_param(true), 0.0);
}
}
/// Guardian.aiStep's visual attack clock, also used by server clients.
/// Does not run attack goals, movement, damage or random draws.
pub fn client_tick(m: *mut Mob) void {
}
    // rust: if m.extra.flag && m.extra.counter2 < attack_duration(m) {
    // rust: m.extra.counter2 += 1;
}
}
/// The beam's clock for rendering: (attack time with the partial tick,
/// attack scale), while a target is locked.
pub fn beam(m: *Mob, partial: f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let guardian = matches!(m.species(), Species::Guardian | Species::ElderGuardian);
    // rust: if !guardian || !m.extra.flag || m.ai.target.is_none() {
    // rust: return None;
}
    // rust: let time = m.extra.counter2 as f32 + partial;
    // rust: Some((time, time / attack_duration(m) as f32))
}
/// `GuardianRenderer.renderBeam` from `eye` to `target` (world minus
/// camera): the four rotating sides and the end cap. The texture's V
/// repeats along the beam, so the sides are cut at each repeat.
    // rust: pub fn beam_geometry(
    // rust: eye: glam::Vec3,
    // rust: target: glam::Vec3,
    // rust: time: f32,
    // rust: scale: f32,
    // rust: uv: [f32; 4],
    // rust: out: &mut Vec<crate::mesher::Vertex>,
    // rust: ) {
    // rust: let v = target - eye;
    // rust: let length = v.length() + 1.0;
    // rust: let dir = v.normalize_or_zero();
    // rust: let x_rot = dir.y.clamp(-1.0, 1.0).acos();
    // rust: let y_rot = std::f32::consts::FRAC_PI_2 - dir.z.atan2(dir.x);
    // rust: let pose = glam::Mat4::from_translation(eye)
    // rust: * glam::Mat4::from_rotation_y(y_rot)
    // rust: * glam::Mat4::from_rotation_x(x_rot);
    // rust: let rot = time * 0.05 * -1.5;
    // rust: let cs = scale * scale;
    // rust: let (r, g, b) = (
    // rust: 64 + (cs * 191.0) as u32,
    // rust: 32 + (cs * 191.0) as u32,
    // rust: 128u32.saturating_sub((cs * 64.0) as u32),
    // rust: );
    // rust: let color = 0xFF00_0000 | (b.min(255) << 16) | (g.min(255) << 8) | r.min(255);
    // rust: let at = |a: f32, radius: f32| (a.mcos() * radius, a.msin() * radius);
    // rust: let quarter = std::f32::consts::FRAC_PI_4;
    // rust: let (wx, wz) = at(rot + PI, 0.2);
    // rust: let (ex, ez) = at(rot, 0.2);
    // rust: let (nx, nz) = at(rot + PI / 2.0, 0.2);
    // rust: let (sx, sz) = at(rot + PI * 1.5, 0.2);
    // rust: let (wnx, wnz) = at(rot + quarter * 3.0, 0.282);
    // rust: let (enx, enz) = at(rot + quarter, 0.282);
    // rust: let (wsx, wsz) = at(rot + quarter * 5.0, 0.282);
    // rust: let (esx, esz) = at(rot + quarter * 7.0, 0.282);
    // rust: let tex_off = (time * 0.5) % 1.0;
    // rust: let min_v = -1.0 + tex_off;
    // rust: let max_v = min_v + length * 2.5;
    // rust: let atlas = |u: f32, v: f32| [uv[0] + (uv[2] - uv[0]) * u, uv[1] + (uv[3] - uv[1]) * v];
    // rust: let mut push = |p: [f32; 3], t: [f32; 2]| {
    // rust: out.push(crate::mesher::Vertex {
    // rust: normal: [0; 4],
    // rust: pos: pose.transform_point3(glam::Vec3::from(p)).to_array(),
    // rust: uv: t,
    // rust: layer: 0,
    // rust: color,
    // rust: light: 240 | 240 << 8,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
    // Sides: one quad per texture repeat.
    // rust: let mut k = min_v.floor();
    // rust: while k < max_v {
    // rust: let (v0, v1) = (min_v.max(k), max_v.min(k + 1.0));
    // rust: let (y0, y1) = (
    // rust: (v0 - min_v) / (max_v - min_v) * length,
    // rust: (v1 - min_v) / (max_v - min_v) * length,
    // rust: );
    // rust: let (t0, t1) = (v0 - k, v1 - k);
    // rust: for (a, c) in [((wx, wz), (ex, ez)), ((nx, nz), (sx, sz))] {
    // rust: push([a.0, y1, a.1], atlas(0.4999, t1));
    // rust: push([a.0, y0, a.1], atlas(0.4999, t0));
    // rust: push([c.0, y0, c.1], atlas(0.0, t0));
    // rust: push([c.0, y1, c.1], atlas(0.0, t1));
}
    // rust: k += 1.0;
}
    // rust: let base = if (time.floor() as i32) % 2 == 0 {
    // rust: 0.5
    // rust: } else {
    // rust: 0.0
}
    // rust: push([wnx, length, wnz], atlas(0.5, base + 0.5));
    // rust: push([enx, length, enz], atlas(1.0, base + 0.5));
    // rust: push([esx, length, esz], atlas(1.0, base));
    // rust: push([wsx, length, wsz], atlas(0.5, base));
}
/// `GuardianModel.setupAnim`: head, spikes by withdrawal, the eye toward
/// what it looks at, and the tail.
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: let spikes = m.anim.lerp(SPIKES, s.partial);
    // rust: let withdrawal = (1.0 - spikes) * 0.55;
    // rust: const X: [f32; 12] = [
    // rust: 0.0, 0.0, 8.0, -8.0, -8.0, 8.0, 8.0, -8.0, 0.0, 0.0, 8.0, -8.0,
    // rust: ];
    // rust: const Y: [f32; 12] = [
    // rust: -8.0, -8.0, -8.0, -8.0, 0.0, 0.0, 0.0, 0.0, 8.0, 8.0, 8.0, 8.0,
    // rust: ];
    // rust: const Z: [f32; 12] = [
    // rust: 8.0, -8.0, 0.0, 0.0, -8.0, -8.0, 8.0, 8.0, 8.0, -8.0, 0.0, 0.0,
    // rust: ];
    // rust: for i in 0..12 {
    // rust: let offset = 1.0 + (s.age * 1.5 + i as f32).mcos() * 0.01 - withdrawal;
    // rust: let part = p.get(&format!("spike{i}"));
    // rust: part[0] = X[i] * offset;
    // rust: part[1] = 16.0 + Y[i] * offset;
    // rust: part[2] = Z[i] * offset;
}
    // rust: let e = p.get("eye");
    // rust: e[0] = m.anim.v[EYE_X];
    // rust: e[1] = m.anim.v[EYE_Y];
    // rust: let tail = m.anim.lerp(TAIL, s.partial);
    // rust: p.yrot("tail0", tail.msin() * PI * 0.05);
    // rust: p.yrot("tail1", tail.msin() * PI * 0.1);
    // rust: p.yrot("tail2", tail.msin() * PI * 0.15);
}
/// `Guardian.getAttackAnimationScale(0)`: how far the beam has charged. A
/// beam that ended counts from zero again.
pub fn attack_scale(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.extra.flag {
    // rust: m.extra.counter2 as f32 / attack_duration(m) as f32
    // rust: } else {
    // rust: 0.0
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;
//     use std::sync::Arc;

pub fn flop(kind: []const u8, silent: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut result = None;
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut mob = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types[kind].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: register(&mut mob);
    // rust: mob.on_ground = true;
    // rust: mob.fluids.in_water = false;
    // rust: mob.silent = silent;
    // rust: let mut events = Vec::new();
    // rust: ai_step(&mut mob, w, &mut events);
    // rust: result = Some((mob, events));
    // rust: });
    // rust: if !ran {
    // rust: return None;
}
    // rust: result
}

    /// `Guardian.aiStep`: a guardian out of water flops, and the flop is heard
    /// (the elder's own sound) unless the guardian is silent (`!isSilent()`).
pub fn a_silent_guardian_flops_without_a_sound() void {
}
    // rust: for (kind, sound) in [
    // rust: ("minecraft:guardian", "entity.guardian.flop"),
    // rust: ("minecraft:elder_guardian", "entity.elder_guardian.flop"),
    // rust: ] {
    // rust: for silent in [false, true] {
    // rust: let Some((mob, events)) = flop(kind, silent) else {
    // rust: return;
}
    // rust: assert!(!mob.on_ground && mob.velocity.y > 0.0, "{kind} flops");
    // rust: let sounds: Vec<_> = events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::Sound(s, ..) => Some(*s),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let heard: &[&str] = if silent { &[] } else { &[sound] };
    // rust: assert_eq!(sounds, heard, "{kind} silent={silent}");
}
}
}
}
