//! Transpiled from Horizon Rust crate
//! Module: horizon-client_cube
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Slimes and magma cubes (`AbstractCubeMob`): sized bodies, hopping
//! movement (`CubeMobMoveControl`), random directions, contact damage,
//! squish animation and splitting.
// use super::{
    // rust: Damage, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: control::{MoveKind, Operation, rotlerp},
    // rust: goals::{Cx, Goal, JUMP, LOOK, MOVE, NearestTarget, Prey, goal_clone, reduced},
}
// use horizon_core::{
    // rust: geometry::{Vec3, trig},
    // rust: random::RandomSource,
}

// AnimState slots.
pub const SQUISH: usize = 0;
pub const TARGET_SQUISH: usize = 1;

pub fn register(m: *mut Mob) void {
}
    // rust: if m.species() == Species::SulfurCube {
    // rust: return super::sulfur_cube::register(m);
}
    // rust: m.ai.goals.add(1, CubeFloat);
    // rust: m.ai.goals.add(2, CubeAttack { tired: 0 });
    // rust: m.ai.goals.add(
    // rust: 4,
    // rust: CubeRandomDirection {
    // rust: degrees: 0.0,
    // rust: next: 0,
    // rust: },
    // rust: );
    // rust: m.ai.goals.add(5, CubeKeepJumping);
    // rust: m.ai.targets.add(
    // rust: 1,
    // rust: NearestTarget::new(Prey::Player, true)
    // rust: .interval(10)
    // rust: .when(|m, w| {
    // rust: w.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| (p.position.y - m.position.y).abs() <= 4.0)
    // rust: }),
    // rust: );
    // rust: m.ai.targets
    // rust: .add(3, NearestTarget::species(&[Species::IronGolem], true));
    // rust: m.ai.mov.kind = MoveKind::Custom;
    // rust: m.ai.nav.can_float = true;
    // rust: m.extra.vector[0] = f64::from(180.0 * m.yaw / std::f32::consts::PI);
    // rust: set_size(m, 1);
}
/// AbstractCubeMob.setSize(size, true): the max health (size^2), movement
/// speed (0.2 + 0.1 * size, in floats) and attack damage (size) bases, a
/// magma cube's armor (size * 3), then the health back to the max.
pub fn set_size(m: *mut Mob, size: i32) void {
}
//     use super::finalize::{Attr, set_base};
    // rust: let size = size.clamp(1, 127);
    // rust: m.extra.size = size;
    // rust: set_base(m, Attr::MaxHealth, f64::from(size * size));
    // rust: set_base(
    // rust: m,
    // rust: Attr::MovementSpeed,
    // rust: f64::from(0.2f32 + 0.1f32 * size as f32),
    // rust: );
    // rust: set_base(m, Attr::AttackDamage, f64::from(size));
    // rust: if m.species() == super::Species::MagmaCube {
    // rust: set_base(m, Attr::Armor, f64::from(size * 3));
}
    // rust: m.health = super::finalize::max_health(m);
}
/// AbstractCubeMob.setSpawnSize: 1, 2 or 4 (normal difficulty special multiplier 0).
pub fn finalize(m: *mut Mob) void {
}
    // rust: let scale = m.random.next_int_bound(3).unwrap_or(0);
    // rust: set_size(m, 1 << scale);
}
pub fn tiny(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.size <= 1
}
pub fn can_deal_damage(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // SulfurCube.canDealDamage: never.
    // rust: m.species() == Species::MagmaCube || !tiny(m) && m.species() != Species::SulfurCube
}
pub fn jump_delay(m: *mut Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let base = m.random.next_int_bound(20).unwrap_or(0) + 10;
    // rust: if m.species() == Species::MagmaCube {
    // rust: base * 4
    // rust: } else {
    // rust: base
}
}
pub fn sound_pitch(m: *mut Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let adjust = if tiny(m) { 1.4 } else { 0.8 };
    // rust: ((m.random.next_float() - m.random.next_float()) * 0.2 + 1.0) * adjust
}
/// CubeMobMoveControl.tick
pub fn move_control(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // SulfurCubeMobMoveControl: still while holding a block.
    // rust: if m.species() == Species::SulfurCube && super::sulfur_cube::has_body(m) {
    // rust: return;
}
    // rust: let want = m.extra.vector[0] as f32;
    // rust: m.yaw = rotlerp(m.yaw, want, 90.0);
    // rust: m.head_yaw = m.yaw;
    // rust: m.body_yaw = m.yaw;
    // rust: if m.ai.mov.operation != Operation::MoveTo {
    // rust: m.ai.zza = 0.0;
    // rust: return;
}
    // rust: m.ai.mov.operation = Operation::Wait;
    // rust: let speed = (m.ai.mov.speed_modifier * m.movement_speed()) as f32;
    // rust: if m.on_ground {
    // rust: m.set_speed(speed);
    // rust: let delay = m.extra.counter;
    // rust: m.extra.counter -= 1;
    // rust: if delay <= 0 {
    // rust: m.extra.counter = jump_delay(m);
    // rust: if m.extra.flag {
    // rust: m.extra.counter /= 3;
}
    // rust: m.ai.jump = true;
    // rust: let jump = match (m.species(), tiny(m)) {
    // rust: (Species::MagmaCube, _) => "entity.magma_cube.jump",
    // rust: (Species::SulfurCube, _) => super::sulfur_cube::jump_sound(m),
    // rust: (_, true) => "entity.slime.jump_small",
    // rust: _ => "entity.slime.jump",
}
    // rust: let pitch = sound_pitch(m);
    // rust: let vol = super::ai::sound_volume(m);
    // rust: events.push(MobEvent::Sound(jump, m.center(), vol, pitch));
    // rust: } else {
    // rust: m.ai.xxa = 0.0;
    // rust: m.ai.zza = 0.0;
    // rust: m.set_speed(0.0);
}
    // rust: } else {
    // rust: m.set_speed(speed);
}
}
    // rust: pub(super) fn set_direction(m: &mut Mob, y_rot: f32, aggressive: bool) {
    // rust: m.extra.vector[0] = f64::from(y_rot);
    // rust: m.extra.flag = aggressive;
}
    // rust: pub(super) fn set_wanted(m: &mut Mob, speed: f64) {
    // rust: m.ai.mov.speed_modifier = speed;
    // rust: m.ai.mov.operation = Operation::MoveTo;
}
/// AbstractCubeMob.jumpFromGround (and MagmaCube's size boost).
pub fn jump(m: *mut Mob, w: *MobWorld) void {
}
    // rust: let boost = if m.species() == Species::MagmaCube {
    // rust: m.extra.size as f32 * 0.1
    // rust: } else {
    // rust: 0.0
}
    // rust: m.velocity.y = f64::from(m.jump_power(w) + boost);
}
/// `AbstractCubeMob.tick`'s landing splash: crumbs of goo (or flames) around
/// the cube's feet, drawn by the side that ticks the mob.
pub fn landing_splash(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let size = m.width() * 2.0;
    // rust: let radius = size / 2.0;
    // rust: let kind = match m.species() {
    // rust: Species::MagmaCube => "flame",
    // rust: Species::SulfurCube => "sulfur_cube_goo",
    // rust: _ => "item_slime",
}
    // rust: let mut i = 0;
    // rust: while (i as f32) < size * 16.0 {
    // rust: let dir = m.random.next_float() * std::f64::consts::TAU as f32;
    // rust: let d = m.random.next_float() * 0.5 + 0.5;
    // rust: let xd = trig::sin(f64::from(dir)) * radius * d;
    // rust: let zd = trig::cos(f64::from(dir)) * radius * d;
    // rust: events.push(MobEvent::Particles {
    // rust: kind,
    // rust: at: [
    // rust: m.position.x + f64::from(xd),
    // rust: m.position.y,
    // rust: m.position.z + f64::from(zd),
    // rust: ],
    // rust: count: 0,
    // rust: });
    // rust: i += 1;
}
}
/// `AbstractCubeMob.tick` on a client of a server: the squish scale (`oSquish`,
/// the step toward `targetSquish`, the land and takeoff targets, then
/// `decreaseSquish`) and the landing splash follow the on-ground flag the
/// server sends. The squish sound stays the server's broadcast.
pub fn client_tick(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.species() == Species::SulfurCube {
    // rust: super::sulfur_cube::client_tick(m);
}
    // `AbstractCubeMob.tick`: `oSquish = squish`, then squish toward the target.
    // rust: m.anim.vo[SQUISH] = m.anim.v[SQUISH];
    // rust: m.anim.v[SQUISH] += (m.anim.v[TARGET_SQUISH] - m.anim.v[SQUISH]) * 0.5;
    // rust: let was = m.extra.flag2;
    // rust: if m.on_ground && !was {
    // rust: landing_splash(m, events);
    // rust: m.anim.v[TARGET_SQUISH] = -0.5;
    // rust: } else if !m.on_ground && was {
    // rust: m.anim.v[TARGET_SQUISH] = 1.0;
}
    // rust: m.extra.flag2 = m.on_ground;
    // `AbstractCubeMob.decreaseSquish`; `MagmaCube` multiplies by 0.9.
    // rust: m.anim.v[TARGET_SQUISH] *= if m.species() == Species::MagmaCube {
    // rust: 0.9
    // rust: } else {
    // rust: 0.6
}
}
/// AbstractCubeMob.tick squish and landing sounds, plus contact damage.
pub fn ai_step(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let v = &mut m.anim.v;
    // rust: v[SQUISH] += (v[TARGET_SQUISH] - v[SQUISH]) * 0.5;
    // rust: let was = m.extra.flag2;
    // rust: if m.on_ground && !was {
    // rust: landing_splash(m, events);
    // rust: let squish = match (m.species(), tiny(m)) {
    // rust: (Species::SulfurCube, _) => super::sulfur_cube::squish_sound(m),
    // rust: (Species::MagmaCube, true) => "entity.magma_cube.squish_small",
    // rust: (Species::MagmaCube, false) => "entity.magma_cube.squish",
    // rust: (_, true) => "entity.slime.squish_small",
    // rust: _ => "entity.slime.squish",
}
    // rust: let pitch = ((m.random.next_float() - m.random.next_float()) * 0.2 + 1.0) / 0.8;
    // rust: let vol = super::ai::sound_volume(m);
    // rust: events.push(MobEvent::Sound(squish, m.center(), vol, pitch));
    // rust: m.anim.v[TARGET_SQUISH] = -0.5;
    // rust: } else if !m.on_ground && was {
    // rust: m.anim.v[TARGET_SQUISH] = 1.0;
}
    // rust: m.extra.flag2 = m.on_ground;
    // rust: m.anim.v[TARGET_SQUISH] *= if m.species() == Species::MagmaCube {
    // rust: 0.9
    // rust: } else {
    // rust: 0.6
}
    // playerTouch -> dealDamage
    // rust: if can_deal_damage(m)
    // rust: && !m.no_ai
    // rust: && m.alive()
    // rust: && let Some(p) = &w.player
    // rust: && p.alive
    // rust: && !p.creative
    // rust: && crate::scoreboard::teams_allow_damage(
    // rust: w.teams.of(Who::Mob(m.id)),
    // rust: w.teams.of(Who::Player),
    // rust: )
        // Player.touch: entities within the player's box grown by (1, 0.5, 1).
    // rust: && m.bounds().intersects(p.bounds.inflate(Vec3::new(1.0, 0.5, 1.0)))
    // rust: {
    // rust: let reach = 2.04f32.sqrt() as f64 - 0.6;
    // rust: if m.bounds()
    // rust: .inflate(Vec3::new(reach, 0.0, reach))
    // rust: .intersects(p.bounds)
    // rust: && m.sees(w, Who::Player)
    // rust: {
    // rust: events.push(MobEvent::CubeHurtPlayer {
    // rust: cube: m.id,
    // rust: amount: attack_damage(m),
    // rust: from: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
}
    // rust: hurt_touching_golems(m, w, events);
}
/// `AbstractCubeMob.getAttackDamage`: the attack damage attribute, plus 2 for
/// a magma cube (`MagmaCube.getAttackDamage`).
pub fn attack_damage(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.attrs.attack_damage
    // rust: + if m.species() == Species::MagmaCube {
    // rust: 2.0
    // rust: } else {
    // rust: 0.0
}
}
/// `AbstractCubeMob.push(entity)`: an iron golem whose `pushEntities` takes
/// this cube (its box overlaps the cube's, `EntitySelector.pushableBy`) gets
/// `dealDamage`: alive, `doTeamsAllowDamage`, `isWithinMeleeAttackRange`
/// (always true for overlapping boxes) and `hasLineOfSight`, then a
/// `mobAttack` hit for `getAttackDamage`.
pub fn hurt_touching_golems(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // canDealDamage also needs Mob.isEffectiveAi: a NoAI cube never hurts.
    // rust: if !can_deal_damage(m) || m.no_ai || !m.alive() {
    // rust: return;
}
    // rust: let bounds = m.bounds();
    // rust: let own = w.teams.of(Who::Mob(m.id));
    // rust: let pushable = m.pushable();
    // rust: let golems: Vec<u32> = w
    // rust: .others_near(bounds)
    // rust: .filter(|o| {
    // rust: let theirs = w.teams.of(Who::Mob(o.id));
    // rust: o.id != m.id
    // rust: && o.species == Species::IronGolem
    // rust: && o.alive
    // rust: && o.bounds.intersects(bounds)
    // rust: && crate::scoreboard::pushable_by(theirs, own, pushable)
    // rust: && crate::scoreboard::teams_allow_damage(own, theirs)
    // rust: })
    // rust: .map(|o| o.id)
    // rust: .collect();
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: for golem in golems {
    // rust: if m.sees(w, Who::Mob(golem)) {
    // rust: events.push(MobEvent::CubeHurtMob {
    // rust: cube: m.id,
    // rust: target: golem,
    // rust: amount: attack_damage(m),
    // rust: source: Damage::mob(m.id, from),
    // rust: });
}
}
}
/// MagmaCubeModel.setupAnim (slimes have no animation).
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: if m.species() == Species::MagmaCube {
    // rust: let squish = m.anim.lerp(SQUISH, s.partial).max(0.0);
    // rust: for i in 0..8 {
    // rust: p.get(&format!("cube{i}"))[1] = -((4 - i) as f32) * squish * 1.7;
}
}
}
/// AbstractCubeMobRenderer.scale: size with squash and stretch.
pub fn scale(m: *Mob, alpha: f32) g {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = m.extra.size.max(1) as f32;
    // rust: let squish = m.anim.lerp(SQUISH, alpha) / (size * 0.5 + 1.0);
    // rust: let w = 1.0 / (squish + 1.0);
    // rust: let mut t = glam::Mat4::IDENTITY;
    // rust: if m.species() == Species::Slime {
    // rust: t = glam::Mat4::from_scale(glam::Vec3::splat(0.999))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, 0.001, 0.0));
}
    // rust: t * glam::Mat4::from_scale(glam::Vec3::new(w * size, 1.0 / w * size, w * size))
}
/// CubeMobFloatGoal
    // rust: pub(super) struct CubeFloat;
    // rust: impl Goal for CubeFloat {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: JUMP | MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.is_in_liquid()
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: if m.random.next_float() < 0.8 {
    // rust: m.ai.jump = true;
}
    // rust: set_wanted(m, 1.2);
}
}
/// CubeMobAttackGoal: face the target and hop at it for up to 300 ticks.
pub const CubeAttack = struct {
    tired: i32,
};
    // rust: impl Goal for CubeAttack {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.target_info(cx.w)
    // rust: .is_some_and(|t| t.alive && !(t.is_player && t.creative))
}
pub fn start(self: *Self, _: *mut Mob, _: *mut Cx) void {
}
    // rust: self.tired = reduced(300);
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m
    // rust: .target_info(cx.w)
    // rust: .is_some_and(|t| t.alive && !(t.is_player && t.creative))
    // rust: {
    // rust: return false;
}
    // rust: self.tired -= 1;
    // rust: self.tired > 0
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if let Some(t) = m.target_info(cx.w) {
    // rust: m.turn_to([t.position.x, t.eye_y, t.position.z], 10.0, 10.0);
}
    // rust: let (yaw, aggressive) = (m.yaw, can_deal_damage(m));
    // rust: set_direction(m, yaw, aggressive);
}
}
/// CubeMobRandomDirectionGoal
    // rust: pub(super) struct CubeRandomDirection {
    // rust: degrees: f32,
    // rust: next: i32,
}
    // rust: impl Goal for CubeRandomDirection {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.target.is_none()
    // rust: && (m.on_ground || m.is_in_liquid() || m.has_effect("minecraft:levitation"))
}
pub fn tick(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: self.next -= 1;
    // rust: if self.next <= 0 {
    // rust: self.next = reduced(40 + m.random.next_int_bound(60).unwrap_or(0));
    // rust: self.degrees = m.random.next_int_bound(360).unwrap_or(0) as f32;
}
    // rust: set_direction(m, self.degrees, false);
}
}
/// CubeMobKeepOnJumpingGoal
    // rust: pub(super) struct CubeKeepJumping;
    // rust: impl Goal for CubeKeepJumping {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: JUMP | MOVE
}
pub fn can_use(self: *Self, _: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: set_wanted(m, 1.0);
}
}

    // rust: mod golem_touch_tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;
//     use std::sync::Arc;

    /// The golems a cube of this kind and size, `x` blocks east of an iron
    /// golem, hurts in one `ai_step`, and the damage.
pub fn hits(name: []const u8, size: i32, x: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: hits_with(name, size, x, false)
}
pub fn hits_with(name: []const u8, size: i32, x: f64, no_ai: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = None;
    // rust: with_test_world(&[], |_, types| {
    // rust: let mob = |id: u32, name: &str, at: Vec3| {
    // rust: Mob::new(id, Arc::new(types.types[name].clone()), at, 0.0)
}
    // rust: let golem = mob(2, "minecraft:iron_golem", Vec3::new(0.5, 64.0, 0.5));
    // rust: let mut cube = mob(1, name, Vec3::new(0.5 + x, 64.0, 0.5));
    // rust: set_size(&mut cube, size);
    // rust: cube.no_ai = no_ai;
    // rust: out = Some((cube, golem.seen(None)));
    // rust: });
    // rust: let (mut cube, golem) = out?;
    // rust: let mut events = Vec::new();
    // rust: with_test_world(&[golem], |w, _| ai_step(&mut cube, w, &mut events));
    // rust: Some(
    // rust: events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: MobEvent::CubeHurtMob {
    // rust: cube: 1,
    // rust: target,
    // rust: amount,
    // rust: source,
    // rust: } => {
    // rust: assert_eq!(source.attacker, Some(Who::Mob(1)));
    // rust: Some((*target, *amount))
}
    // rust: _ => None,
    // rust: })
    // rust: .collect(),
    // rust: )
}

    /// `AbstractCubeMob.push`: a slime or magma cube the iron golem bumps
    /// into hurts it like a touching player (#3513), for `getAttackDamage`;
    /// a tiny slime (`canDealDamage`) and a cube clear of the golem do not.
pub fn a_cube_touching_an_iron_golem_hurts_it() void {
}
    // rust: let Some(slime) = hits("minecraft:slime", 2, 1.0) else {
    // rust: return;
}
    // rust: assert_eq!(slime, vec![(2, 2.0)], "a size 2 slime hits the golem for 2");
    // rust: let magma = hits("minecraft:magma_cube", 4, 1.5).unwrap();
    // rust: assert_eq!(magma, vec![(2, 6.0)], "a size 4 magma cube hits for 4 + 2");
    // rust: let tiny = hits("minecraft:magma_cube", 1, 0.9).unwrap();
    // rust: assert_eq!(
    // rust: tiny,
    // rust: vec![(2, 3.0)],
    // rust: "a tiny magma cube still hits for 1 + 2"
    // rust: );
    // rust: assert!(
    // rust: hits("minecraft:slime", 1, 0.9).unwrap().is_empty(),
    // rust: "a tiny slime never hurts"
    // rust: );
    // rust: assert!(
    // rust: hits("minecraft:slime", 2, 3.0).unwrap().is_empty(),
    // rust: "the golem is out of touch"
    // rust: );
    // rust: assert!(
    // rust: hits_with("minecraft:slime", 2, 1.0, true)
    // rust: .unwrap()
    // rust: .is_empty(),
    // rust: "a NoAI cube is not isEffectiveAi, so it cannot deal damage"
    // rust: );
}

    /// #4569: `AbstractCubeMob.dealDamage` on a touching player emits
    /// `CubeHurtPlayer` without queueing `entity.slime.attack` in `ai_step`
    /// (the sound only follows a hit that `hurtServer` accepts).
pub fn a_cube_touching_a_player_defers_its_attack_sound_to_hurt_server() void {
}
//         use horizon_core::geometry::Aabb;
    // rust: let mut events = Vec::new();
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut w = w.clone();
    // rust: let at = Vec3::new(0.5, 64.0, 0.5);
    // rust: w.player = Some(crate::mobs::PlayerView {
    // rust: position: at,
    // rust: bounds: Aabb::new(
    // rust: Vec3::new(at.x - 0.3, at.y, at.z - 0.3),
    // rust: Vec3::new(at.x + 0.3, at.y + 1.8, at.z + 0.3),
    // rust: ),
    // rust: eye: [at.x, at.y + 1.62, at.z],
    // rust: alive: true,
    // rust: creative: false,
    // rust: sneaking: false,
    // rust: swimming: false,
    // rust: look: [0.0, 0.0, 1.0],
    // rust: main_hand: None,
    // rust: off_hand: None,
    // rust: head: None,
    // rust: chest: None,
    // rust: legs: None,
    // rust: feet: None,
    // rust: armor_cover: 0.0,
    // rust: invisible: false,
    // rust: spectator: false,
    // rust: gold_armor: false,
    // rust: hurt_by: None,
    // rust: last_hurt: None,
    // rust: velocity: Vec3::ZERO,
    // rust: yaw: 0.0,
    // rust: sprinting: false,
    // rust: riding: false,
    // rust: hero: false,
    // rust: effects: Vec::new(),
    // rust: uuid: [0; 4],
    // rust: allies: Default::default(),
    // rust: remote: false,
    // rust: sleeping: false,
    // rust: sleep_timer: 0,
    // rust: passenger: false,
    // rust: riding_vehicle: None,
    // rust: vehicle: None,
    // rust: });
    // rust: let mut slime = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:slime"].clone()),
    // rust: Vec3::new(1.2, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: set_size(&mut slime, 2);
    // rust: slime.on_ground = true;
    // rust: slime.extra.flag2 = true;
    // rust: ai_step(&mut slime, &w, &mut events);
    // rust: });
    // rust: if !ran {
    // rust: return;
}
    // rust: assert!(
    // rust: events.iter().any(|e| matches!(
    // rust: e,
    // rust: MobEvent::CubeHurtPlayer {
    // rust: cube: 1,
    // rust: amount,
    // rust: ..
    // rust: } if (*amount - 2.0).abs() < f32::EPSILON
    // rust: )),
    // rust: "expected CubeHurtPlayer for size-2 slime, got {events:?}"
    // rust: );
    // rust: assert!(
    // rust: !events
    // rust: .iter()
    // rust: .any(|e| matches!(e, MobEvent::Sound("entity.slime.attack", ..))),
    // rust: "ai_step must not emit entity.slime.attack before hurtServer: {events:?}"
    // rust: );
}
}
