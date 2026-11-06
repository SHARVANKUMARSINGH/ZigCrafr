//! Transpiled from Horizon Rust crate
//! Module: horizon-client_nautilus
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Nautili and zombie nautili (`AbstractNautilus`, `Nautilus`,
//! `ZombieNautilus`, `NautilusAi`, `ZombieNautilusAi`): smooth swimming,
//! drying out on land, taming with pufferfish, the saddle and armour, the
//! ridden swim with its dash, charging at pufferfish and at whoever hurt
//! them, the zombie's temperate and coral variants, and `NautilusModel`.
// use super::{
    // rust: Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: control::{LookKind, MoveKind, Operation},
    // rust: goals::{Breed, Cx, Goal, LOOK, LookAtPlayer, MOVE, Panic, Stroll, Tempt, goal_clone},
    // rust: keyframes::Animation,
    // rust: nav::NavKind,
}
// use crate::blocks::Fluid;
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use std::collections::HashMap;

// Nautilus state: `tame`/`owner`, the saddle, `head` the body armour,
// `variant` the zombie's variant (0 temperate, 1 warm), `anim_ticks` the
// dash cooldown and `flag2` dashing, `counter` the attack target cooldown,
// `counter2` the charge cooldown, `anger` the ticks left of `ANGRY_AT`
// (at `ai.last_hurt_by`), `ints[1]` the rider's breath effect given,
// `scratch[1]` a dash whose sound is still to play.
pub const DASH_COOLDOWN: i32 = 40;
pub const TIME_BETWEEN_ATTACKS: i32 = 80;
pub const ANGER_DURATION: i32 = 400;
/// `ZombieNautilusVariants`: the variant keys in index order.
pub const VARIANTS: [[]const u8; 2] = ["temperate", "warm"];

pub fn is_nautilus(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(s, Species::Nautilus | Species::ZombieNautilus)
}
pub fn zombie(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.species() == Species::ZombieNautilus
}
pub fn register(m: *mut Mob) void {
}
    // SmoothSwimmingMoveControl(85, 10, 0.011, 0, true), SmoothSwimmingLookControl(10).
    // rust: m.ai.mov.kind = MoveKind::SmoothSwimming {
    // rust: max_turn_x: 85.0,
    // rust: max_turn_y: 10.0,
    // rust: in_water: 0.011,
    // rust: outside: 0.0,
    // rust: gravity: true,
}
    // rust: m.ai.look.kind = LookKind::SmoothSwimming(10.0);
    // rust: m.ai.nav.kind = NavKind::Water { breach: false };
    // rust: m.set_malus(super::path::PathType::Water, 0.0);
    // rust: let tempt = m.kind.tempt.clone();
    // rust: let stop = if m.is_baby() { 2.5 } else { 3.5 };
    // rust: let is_zombie = zombie(m);
    // rust: let g = &mut m.ai.goals;
    // rust: if is_zombie {
        // ZombieNautilusAi: no panic, no love, slower temptation and charge.
    // rust: let mut t = Tempt::new(0.9, tempt, false);
    // rust: t.stop_distance = stop;
    // rust: g.add(1, t);
    // rust: g.add(2, Charge::new(0.5));
    // rust: g.add(3, Stroll::swimming(1.0, 1));
    // rust: g.add(3, LookAtPlayer::new(6.0));
    // rust: } else {
    // rust: g.add(0, Panic::new(1.6));
    // rust: g.add(1, Breed::new(0.4));
    // rust: let mut t = Tempt::new(1.3, tempt, false);
    // rust: t.stop_distance = stop;
    // rust: g.add(2, t);
    // rust: g.add(3, Charge::new(0.6));
    // rust: g.add(4, Stroll::swimming(1.0, 1));
    // rust: g.add(4, LookAtPlayer::new(6.0));
}
}
/// `finalizeSpawn`: `NautilusAi.initMemories` (2400 to 3600 ticks before it
/// first looks for prey) and the zombie's variant by biome.
pub fn finalize(m: *mut Mob, warm_ocean: bool) void {
}
    // rust: m.extra.counter = 2400 + m.random.next_int_bound(1201).unwrap_or(0);
    // rust: if zombie(m) {
    // rust: m.extra.variant = u8::from(warm_ocean);
}
}
/// `getControllingPassenger`: a player on a saddled nautilus.
pub fn controlled(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.rider.is_some() && m.extra.saddled
}
/// `AbstractNautilus.isFood`: taming items while wild, food otherwise.
pub fn is_food(m: *Mob, item: []const u8, taming: *[[]const u8]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.extra.tame && !m.is_baby() {
    // rust: taming.iter().any(|t| t == item)
    // rust: } else {
    // rust: m.kind.food.iter().any(|t| t == item)
}
}
/// The ambient, hurt and death sounds by age and whether it is under water.
pub fn sounds(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let under = m.fluids.eye_in_water;
    // rust: match (zombie(m), m.is_baby(), under) {
    // rust: (true, _, true) => [
    // rust: "entity.zombie_nautilus.ambient",
    // rust: "entity.zombie_nautilus.hurt",
    // rust: "entity.zombie_nautilus.death",
    // rust: ],
    // rust: (true, _, false) => [
    // rust: "entity.zombie_nautilus.ambient_land",
    // rust: "entity.zombie_nautilus.hurt_land",
    // rust: "entity.zombie_nautilus.death_land",
    // rust: ],
    // rust: (false, true, true) => [
    // rust: "entity.baby_nautilus.ambient",
    // rust: "entity.baby_nautilus.hurt",
    // rust: "entity.baby_nautilus.death",
    // rust: ],
    // rust: (false, true, false) => [
    // rust: "entity.baby_nautilus.ambient_land",
    // rust: "entity.baby_nautilus.hurt_land",
    // rust: "entity.baby_nautilus.death_land",
    // rust: ],
    // rust: (false, false, true) => [
    // rust: "entity.nautilus.ambient",
    // rust: "entity.nautilus.hurt",
    // rust: "entity.nautilus.death",
    // rust: ],
    // rust: (false, false, false) => [
    // rust: "entity.nautilus.ambient_land",
    // rust: "entity.nautilus.hurt_land",
    // rust: "entity.nautilus.death_land",
    // rust: ],
}
}
pub fn dash_sound(m: *Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (zombie(m), m.fluids.eye_in_water) {
    // rust: (true, true) => "entity.zombie_nautilus.dash",
    // rust: (true, false) => "entity.zombie_nautilus.dash_land",
    // rust: (false, true) => "entity.nautilus.dash",
    // rust: (false, false) => "entity.nautilus.dash_land",
}
}
pub fn dash_ready_sound(m: *Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (zombie(m), m.fluids.eye_in_water) {
    // rust: (true, true) => "entity.zombie_nautilus.dash_ready",
    // rust: (true, false) => "entity.zombie_nautilus.dash_ready_land",
    // rust: (false, true) => "entity.nautilus.dash_ready",
    // rust: (false, false) => "entity.nautilus.dash_ready_land",
}
}
/// `playEatingSound`.
pub fn eat_sound(m: *Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (zombie(m), m.is_baby()) {
    // rust: (true, _) => "entity.zombie_nautilus.eat",
    // rust: (false, true) => "entity.baby_nautilus.eat",
    // rust: (false, false) => "entity.nautilus.eat",
}
}
/// `getEquipSound(SADDLE)`.
pub fn saddle_sound(m: *Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.fluids.eye_in_water {
    // rust: "item.nautilus_saddle_underwater_equip"
    // rust: } else {
    // rust: "item.nautilus_saddle_equip"
}
}
pub fn sound(m: *Mob, name: *'static str, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: events.push(MobEvent::Sound(name, m.center(), 1.0, 1.0));
}
/// `AbstractNautilus.travelInWater`: its own speed, no fluid drag but 0.9.
pub fn travel(m: *mut Mob, w: *MobWorld, input: Vec3, events: *mut std.ArrayList(MobEvent)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.fluids.in_water {
    // rust: return false;
}
    // rust: let speed = m.ai.speed;
    // rust: m.move_relative(speed, input);
    // rust: m.do_move(w, events);
    // rust: m.velocity = Vec3::new(m.velocity.x * 0.9, m.velocity.y * 0.9, m.velocity.z * 0.9);
    // rust: true
}
/// `tickRidden` and `getRiddenInput`: turn half way to the rider, swim along
/// their look, faster in water (`getRiddenSpeed`), and dash on the jump.
pub fn ridden(m: *mut Mob) void {
}
    // rust: let Some(r) = m.rider else { return };
    // rust: let diff = super::living::wrap(r.yaw - m.yaw);
    // rust: m.yaw += diff * 0.5;
    // rust: m.head_pitch = r.pitch * 0.5;
    // rust: m.body_yaw = m.yaw;
    // rust: m.head_yaw = m.yaw;
    // rust: m.ai.nav.stop();
    // rust: m.ai.mov.operation = Operation::Wait;
    // rust: let (mut forward, mut up) = (0.0, 0.0);
    // rust: if r.forward != 0.0 {
    // rust: let mut f = r.pitch.to_radians().cos();
    // rust: let mut u = -r.pitch.to_radians().sin();
    // rust: if r.forward < 0.0 {
    // rust: f *= -0.5;
    // rust: u *= -0.5;
}
    // rust: forward = f;
    // rust: up = u;
}
    // rust: let factor = if m.fluids.in_water { 0.0325 } else { 0.02 };
    // rust: m.ai.speed = factor * m.movement_speed() as f32;
    // rust: m.ai.xxa = r.strafe;
    // rust: m.ai.yya = up;
    // rust: m.ai.zza = forward;
    // rust: if r.jump > 0.0 {
    // rust: if m.extra.anim_ticks <= 0 && !m.extra.flag2 {
    // rust: dash(m, r.jump);
}
    // rust: if let Some(rider) = m.rider.as_mut() {
    // rust: rider.jump = 0.0;
}
}
}
/// `AbstractNautilus.onPlayerJump` and the momentum `handleStartJump` starts:
/// a saddled nautilus that is not in its dash cooldown keeps the released
/// jump bar's scale on the rider, and its next `tickRidden` dashes with it
/// (`executeRidersJump`). Returns whether the jump was taken.
pub fn on_player_jump(m: *mut Mob, data: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // `if (isSaddled() && dashCooldown <= 0) playerJumpPendingScale = ...`
    // rust: if !m.extra.saddled || m.extra.anim_ticks > 0 {
    // rust: return false;
}
    // rust: let Some(rider) = m.rider.as_mut() else {
    // rust: return false;
}
    // rust: rider.jump = super::equine::jump_pending_scale(data);
    // rust: true
}
/// `executeRidersJump` (with `handleStartJump`'s sound): along the rider's
/// look, 1.2 in water and 0.5 on land.
pub fn dash(m: *mut Mob, amount: f32) void {
}
    // rust: let Some(r) = m.rider else { return };
    // rust: let (yaw, pitch) = (r.yaw.to_radians(), r.pitch.to_radians());
    // rust: let look = Vec3::new(
    // rust: f64::from(-yaw.sin() * pitch.cos()),
    // rust: f64::from(-pitch.sin()),
    // rust: f64::from(yaw.cos() * pitch.cos()),
    // rust: );
    // rust: let power = if m.fluids.in_water { 1.2 } else { 0.5 };
    // rust: let k = f64::from(power * amount) * m.movement_speed();
    // rust: m.velocity = Vec3::new(
    // rust: m.velocity.x + look.x * k,
    // rust: m.velocity.y + look.y * k,
    // rust: m.velocity.z + look.z * k,
    // rust: );
    // rust: m.extra.anim_ticks = DASH_COOLDOWN;
    // rust: m.extra.flag2 = true;
    // The sound plays on its next tick.
    // rust: m.extra.scratch[1] = 1;
}
/// `AbstractNautilus.getNautilusRestrictionRadius`: 32 blocks, or 16 for a
/// baby or a saddled one.
pub fn restriction_radius(m: *Mob) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !m.is_baby() && !m.extra.saddled {
    // rust: 32
    // rust: } else {
    // rust: 16
}
}
/// `AbstractNautilus.checkRestriction`: a tame nautilus that is neither
/// leashed nor ridden keeps its home where it is, within its radius.
pub fn check_restriction(m: *mut Mob) void {
}
    // rust: if m.extra.leash.is_some() || m.rider.is_some() || !m.extra.tame {
    // rust: return;
}
    // rust: let radius = restriction_radius(m);
    // rust: let at = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let kept = m.ai.home.is_some_and(|(c, r)| {
    // rust: let d = [c[0] - at[0], c[1] - at[1], c[2] - at[2]];
    // rust: let sq = f64::from(d[0] * d[0] + d[1] * d[1] + d[2] * d[2]);
    // rust: sq < f64::from(radius + 8).powi(2) && r == radius
    // rust: });
    // rust: if !kept {
    // rust: m.ai.home = Some((at, radius));
}
}
/// `AbstractNautilus.tick` and the brains' memories: the rider's breath, the
/// dash clock, bubbles, and choosing whom to charge at
/// (`NautilusAi.findNearestValidAttackTarget`).
pub fn ai_step(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // customServerAiStep: the home is kept before the rest of the step.
    // rust: check_restriction(m);
    // rust: if m.extra.scratch[1] != 0 {
    // rust: m.extra.scratch[1] = 0;
    // rust: sound(m, dash_sound(m), events);
}
    // applyEffects: the rider breathes under water.
    // rust: if m.rider.is_some() {
    // rust: if m.extra.ints[1] == 0 || w.game_time % 40 == 0 {
    // rust: m.extra.ints[1] = 1;
    // rust: events.push(MobEvent::EffectPlayer {
    // rust: effect: "minecraft:breath_of_the_nautilus",
    // rust: ticks: 60,
    // rust: amplifier: 0,
                // AbstractNautilus.applyEffects: ambient, visible, showIcon.
    // rust: ambient: true,
    // rust: });
}
    // rust: } else {
    // rust: m.extra.ints[1] = 0;
}
    // rust: if m.extra.flag2 && m.extra.anim_ticks < 35 {
    // rust: m.extra.flag2 = false;
}
    // rust: if m.extra.anim_ticks > 0 {
    // rust: m.extra.anim_ticks -= 1;
    // rust: if m.extra.anim_ticks == 0 {
    // rust: sound(m, dash_ready_sound(m), events);
}
}
    // rust: if m.fluids.in_water {
    // rust: bubbles(m, events);
}
    // CountDownCooldownTicks and the ANGRY_AT expiry.
    // rust: if m.extra.counter > 0 {
    // rust: m.extra.counter -= 1;
}
    // rust: if m.extra.counter2 > 0 {
    // rust: m.extra.counter2 -= 1;
}
    // rust: if m.extra.anger > 0 {
    // rust: m.extra.anger -= 1;
}
    // rust: if m.ai.target.is_none() && m.alive() && !m.no_ai {
    // rust: m.ai.target = find_target(m, w);
}
}
/// `spawnBubbles`: more as it swims faster, from behind its mouth.
pub fn bubbles(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let v = m.velocity;
    // rust: let speed = (v.x * v.x + v.y * v.y + v.z * v.z).sqrt();
    // rust: let chance = (speed * 2.0).clamp(f64::from(0.15f32), 1.0);
    // rust: if f64::from(m.random.next_float()) >= chance {
    // rust: return;
}
    // rust: let (yaw, pitch) = (
    // rust: m.yaw.to_radians(),
    // rust: m.head_pitch.clamp(-10.0, 10.0).to_radians(),
    // rust: );
    // rust: let dir = [
    // rust: f64::from(-yaw.sin() * pitch.cos()),
    // rust: f64::from(-pitch.sin()),
    // rust: f64::from(yaw.cos() * pitch.cos()),
    // rust: ];
    // rust: let spread = m.random.next_double() * 0.8 * (1.0 + speed);
    // rust: let velocity = [
    // rust: (f64::from(m.random.next_float()) - 0.5) * spread,
    // rust: (f64::from(m.random.next_float()) - 0.5) * spread,
    // rust: (f64::from(m.random.next_float()) - 0.5) * spread,
    // rust: ];
    // rust: events.push(MobEvent::ParticleAt {
    // rust: kind: "bubble",
    // rust: at: [
    // rust: m.position.x - dir[0] * 1.1,
    // rust: m.position.y - dir[1] + 0.25,
    // rust: m.position.z - dir[2] * 1.1,
    // rust: ],
    // rust: velocity,
    // rust: });
}
/// `AbstractNautilus.tick` on a client of a server: the bubbles of a nautilus
/// in the water, from the motion the server sent.
pub fn client_tick(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.fluids.in_water {
    // rust: bubbles(m, events);
}
}
pub fn in_water_at(w: *MobWorld, p: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.fluid(p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32) == Fluid::Water
}
/// `AbstractNautilus.isAggravated`: the brain holds an `ANGRY_AT` or an
/// `ATTACK_TARGET` memory. Horizon keeps those as the anger timer (whose
/// target is `last_hurt_by`) and the current attack target.
pub fn aggravated(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.anger > 0 || m.ai.target.is_some()
}
/// `NautilusAi.findNearestValidAttackTarget`: whoever it is angry at, else
/// now and then (a coin flip every 2400 to 3600 ticks) the nearest pufferfish.
pub fn find_target(m: *mut Mob, w: *MobWorld) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.extra.in_love > 0 || !m.fluids.in_water || m.is_baby() || m.extra.tame {
    // rust: return None;
}
    // rust: if m.extra.anger > 0
    // rust: && let Some(who) = m.ai.last_hurt_by
    // rust: && let Some(t) = w.target_info(who)
    // rust: && t.alive
    // rust: && !(t.is_player && t.creative)
    // rust: && in_water_at(w, t.position)
    // rust: {
    // rust: return Some(who);
}
    // rust: if m.extra.counter > 0 {
    // rust: return None;
}
    // rust: m.extra.counter = 2400 + m.random.next_int_bound(1201).unwrap_or(0);
    // rust: if m.random.next_float() < 0.5 {
    // rust: return None;
}
    // rust: w.nearby(m.position, 16.0, |s| {
    // rust: s.species == Species::Pufferfish && in_water_at(w, s.position)
    // rust: })
    // rust: .next()
    // rust: .map(|s| Who::Mob(s.id))
}
/// `hurtServer`: `NautilusAi.setAngerTarget` for 400 ticks.
pub fn after_hurt(m: *mut Mob, source: *super::Damage) void {
}
    // rust: if source.attacker.is_some() {
    // rust: m.extra.anger = ANGER_DURATION + 1;
}
}
/// `ChargeAttack(80, ..., speed, 2, 12, 11, dash)`: rush straight at the
/// target and ram it once.
pub const Charge = struct {
    speed: f64,
    start: Vec3,
    velocity: Vec3,
};
    // rust: impl Charge {
pub fn new(speed: f64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: speed,
    // rust: start: Vec3::ZERO,
    // rust: velocity: Vec3::ZERO,
}
}
pub fn still_ok(self: *Self, m: *Mob, cx: *Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(t) = m.ai.target.and_then(|who| cx.w.target_info(who)) else {
    // rust: return false;
}
    // rust: if !t.alive || t.is_player && t.creative || m.extra.tame || m.extra.counter2 > 0 {
    // rust: return false;
}
    // rust: if m.position.distance_squared(self.start) >= 12.0 * 12.0
    // rust: || t.position.distance_squared(m.position) >= 11.0 * 11.0
    // rust: {
    // rust: return false;
}
    // rust: cx.w.line_of_sight(
    // rust: Vec3::new(m.position.x, m.eye_y(), m.position.z),
    // rust: Vec3::new(t.position.x, t.eye_y, t.position.z),
    // rust: )
}
}
    // rust: impl Goal for Charge {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
}
pub fn can_use(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.ai.target.is_some() && m.extra.counter2 <= 0 && m.extra.in_love <= 0
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.still_ok(m, cx)
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.start = m.position;
    // rust: let Some(t) = m.ai.target.and_then(|who| cx.w.target_info(who)) else {
    // rust: return;
}
    // rust: let d = Vec3::new(
    // rust: t.position.x - m.position.x,
    // rust: t.position.y - m.position.y,
    // rust: t.position.z - m.position.z,
    // rust: );
    // rust: let len = d.length();
    // rust: self.velocity = if len < 1.0e-4 {
    // rust: Vec3::ZERO
    // rust: } else {
    // rust: Vec3::new(
    // rust: d.x / len * self.speed,
    // rust: d.y / len * self.speed,
    // rust: d.z / len * self.speed,
    // rust: )
}
    // rust: if self.still_ok(m, cx) {
    // rust: let name = if zombie(m) {
    // rust: "entity.zombie_nautilus.dash"
    // rust: } else {
    // rust: "entity.nautilus.dash"
}
    // rust: sound(m, name, cx.events);
}
}
pub fn stop(self: *Self, m: *mut Mob, _: *mut Cx) void {
}
    // rust: m.extra.counter2 = TIME_BETWEEN_ATTACKS;
    // rust: m.ai.target = None;
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(who) = m.ai.target else { return };
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: m.turn_to([t.position.x, t.eye_y, t.position.z], 360.0, 360.0);
    // rust: m.velocity = self.velocity;
    // rust: if !m.bounds().intersects(t.bounds) {
    // rust: return;
}
        // dealDamageToTarget and dealKnockBack (causeExtraKnockback along its facing).
    // rust: let from = [m.position.x, m.position.y, m.position.z];
    // rust: let amount = m.attrs.attack_damage;
    // rust: cx.events.push(match who {
    // rust: Who::Player => MobEvent::AttackPlayer(amount, from),
    // rust: Who::Mob(id) => MobEvent::AttackMob {
    // rust: target: id,
    // rust: amount,
    // rust: source: super::Damage::mob(m.id, from),
    // rust: },
    // rust: });
    // rust: let level = |e: &str| {
    // rust: m.extra
    // rust: .effects
    // rust: .iter()
    // rust: .find(|x| x.0 == e)
    // rust: .map_or(0, |x| x.2 + 1)
}
    // rust: let boost = 0.25 * (level("minecraft:speed") - level("minecraft:slowness")) as f32;
    // rust: let factor = (self.speed as f32 * m.movement_speed() as f32).clamp(0.2, 2.0) + boost;
    // rust: let power = f64::from(factor * 2.0);
    // rust: if power > 0.0 {
            // `causeExtraKnockback`: `LivingEntity.knockback` on the target, away
            // from (sin(yaw), -cos(yaw)): its resistance, the halving of its own
            // motion, the lift on the ground and the knockback hook all apply.
    // rust: let yaw = f64::from(m.yaw * (std::f32::consts::PI / 180.0));
    // rust: cx.events.push(MobEvent::Knockback {
    // rust: target: who,
    // rust: power,
    // rust: x: f64::from(horizon_core::geometry::trig::sin(yaw)),
    // rust: z: -f64::from(horizon_core::geometry::trig::cos(yaw)),
    // rust: source: super::Damage::mob(m.id, from),
    // rust: });
    // rust: m.velocity = Vec3::new(m.velocity.x * 0.6, m.velocity.y, m.velocity.z * 0.6);
}
    // rust: m.ai.target = None;
}
}
/// The body texture: the baby's, the adult's, or the zombie's variant.
pub fn texture(m: *Mob) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (zombie(m), m.is_baby(), m.extra.variant) {
    // rust: (true, _, 1) => "entity/nautilus/zombie_nautilus_coral".into(),
    // rust: (true, _, _) => "entity/nautilus/zombie_nautilus".into(),
    // rust: (false, true, _) => "entity/nautilus/nautilus_baby".into(),
    // rust: (false, false, _) => "entity/nautilus/nautilus".into(),
}
}
/// The body model: `ZombieNautilusRenderer` picks the coral model for the
/// warm variant.
pub fn model(m: *Mob) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (zombie(m), m.is_baby(), m.extra.variant) {
    // rust: (true, _, 1) => "zombie_nautilus_coral#main",
    // rust: (true, _, _) => "zombie_nautilus#main",
    // rust: (false, true, _) if m.kind.layer("nautilus_baby#main").is_some() => "nautilus_baby#main",
    // rust: _ => "nautilus#main",
}
}
/// The `NAUTILUS_BODY` equipment texture of a nautilus armour item.
pub fn armor_texture(item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let material = item
    // rust: .strip_prefix("minecraft:")?
    // rust: .strip_suffix("_nautilus_armor")?;
    // rust: let material = if material == "golden" {
    // rust: "gold"
    // rust: } else {
    // rust: material
}
    // rust: Some(format!("entity/equipment/nautilus_body/{material}"))
}
/// `NautilusModel.setupAnim` (and `ZombieNautilusCoralModel`'s corals,
/// hidden under armour).
pub fn anim(m: *Mob, s: *State, p: *mut Poses, animations: *HashMap<[]const u8) void {
}
    // rust: let deg = (std::f64::consts::PI / 180.0) as f32;
    // rust: let y = s.y_rot.clamp(-10.0, 10.0);
    // rust: let x = s.x_rot.clamp(-10.0, 10.0);
    // rust: p.yrot("body", y * deg);
    // rust: p.xrot("body", x * deg);
    // rust: if let Some(a) = animations.get("NautilusAnimation.SWIMMING") {
    // rust: a.apply_walk(s.pos + s.age / 5.0, s.speed + 0.2, 2.0, 3.0, p);
}
    // rust: if m.extra.body.is_some() {
    // rust: p.visible("corals", false);
}
}
/// `TamableAnimal.addAdditionalSaveData`: owner and ordered Sitting, plus
/// the saddle, the zombie's variant and the brain's attack cooldown.
pub fn to_nbt(m: *Mob, map: *mut horizon_world::nbt::Compound) void {
}
//     use horizon_world::nbt::Tag;
    // rust: if let Some(owner) = m.extra.owner {
    // rust: map.insert("Owner".into(), Tag::IntArray(owner.to_vec()));
    // rust: } else {
    // rust: map.remove(&"Owner".into());
}
    // rust: map.insert("Sitting".into(), Tag::Byte(i8::from(m.extra.sitting)));
    // rust: if zombie(m) {
    // rust: let v = VARIANTS[usize::from(m.extra.variant).min(1)];
    // rust: map.insert(
    // rust: "variant".into(),
    // rust: Tag::String(format!("minecraft:{v}").as_str().into()),
    // rust: );
}
    // rust: let mut equipment = match map.get(&"equipment".into()) {
    // rust: Some(Tag::Compound(c)) => c.clone(),
    // rust: _ => horizon_world::nbt::Compound::new(),
}
    // rust: match m.saddle_item() {
    // rust: Some(saddle) => {
    // rust: equipment.insert("saddle".into(), crate::save::item_to_nbt(&saddle));
}
    // rust: None => {
    // rust: equipment.remove(&"saddle".into());
}
}
    // rust: map.insert("equipment".into(), Tag::Compound(equipment));
    // rust: map.insert(
    // rust: "Brain".into(),
    // rust: Tag::compound([(
    // rust: "memories",
    // rust: Tag::compound([(
    // rust: "minecraft:attack_target_cooldown",
    // rust: Tag::compound([("value", Tag::Int(m.extra.counter))]),
    // rust: )]),
    // rust: )]),
    // rust: );
}
/// `TamableAnimal.readAdditionalSaveData`: Sitting is independent of Owner.
pub fn from_nbt(m: *mut Mob, tag: *horizon_world::nbt::Tag) void {
}
//     use horizon_world::nbt::Tag;
    // rust: m.extra.owner = crate::save::uuid_from_tag(tag.get("Owner"));
    // rust: m.extra.tame = m.extra.owner.is_some();
    // rust: m.extra.sitting = crate::entity_nbt::flag(tag, "Sitting");
    // rust: if let Some(Tag::String(v)) = tag.get("variant") {
    // rust: let v = v.to_string().unwrap_or_default();
    // rust: m.extra.variant = u8::from(v.trim_start_matches("minecraft:") == "warm");
}
    // rust: let saddle = tag
    // rust: .get("equipment")
    // rust: .and_then(|e| e.get("saddle"))
    // rust: .and_then(crate::save::item_from_nbt);
    // rust: m.set_saddle(saddle);
    // rust: if let Some(Tag::Int(v)) = tag
    // rust: .get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|b| b.get("minecraft:attack_target_cooldown"))
    // rust: .and_then(|b| b.get("value"))
    // rust: {
    // rust: m.extra.counter = *v;
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::world::with_test_world;
//     use std::sync::Arc;

pub fn saved_sitting_is_independent_of_owner_and_raw_nbt_for_both_species() void {
}
//         use horizon_world::nbt::Tag;
    // rust: for (id, species) in [
    // rust: ("minecraft:nautilus", Species::Nautilus),
    // rust: ("minecraft:zombie_nautilus", Species::ZombieNautilus),
    // rust: ] {
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = id.into();
    // rust: kind.species = species;
    // rust: let mut m = Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0);
    // rust: for owner in [None, Some([1, 2, 3, 4])] {
    // rust: for sitting in [None, Some(false), Some(true)] {
    // rust: let mut entries = Vec::new();
    // rust: if let Some(owner) = owner {
    // rust: entries.push(("Owner", Tag::IntArray(owner.to_vec())));
}
    // rust: if let Some(sitting) = sitting {
    // rust: entries.push(("Sitting", Tag::Byte(i8::from(sitting))));
}
    // rust: let raw = Tag::compound(entries);
    // rust: let expected = sitting.unwrap_or(false);
    // rust: m.extra.sitting = !expected;
    // rust: from_nbt(&mut m, &raw);
    // rust: assert_eq!(m.extra.owner, owner);
    // rust: assert_eq!(m.extra.sitting, expected, "{id} {owner:?} {sitting:?}");
                    // No raw compound: this must come from the modeled flag.
    // rust: let saved = crate::entity_nbt::mob_to_nbt(&m, [5, 6, 7, 8], None, None);
    // rust: assert_eq!(saved.get("Sitting"), Some(&Tag::Byte(i8::from(expected))));
                    // A stale raw flag must not override a later model change.
    // rust: m.extra.sitting = !expected;
    // rust: let saved = crate::entity_nbt::mob_to_nbt(&m, [5, 6, 7, 8], Some(&raw), None);
    // rust: assert_eq!(saved.get("Sitting"), Some(&Tag::Byte(i8::from(!expected))));
}
}
}
}

    /// `ChargeAttack.dealKnockBack` is `causeExtraKnockback`: `LivingEntity.knockback`
    /// on the target, away from (sin(yaw), -cos(yaw)), not a raw push of its motion.
pub fn a_charge_knocks_its_target_back_along_its_facing() void {
}
    // rust: let mut events = Vec::new();
    // rust: let ran = with_test_world(&[], |w, types| {
    // rust: let mut w = w.clone();
    // rust: let at = Vec3::new(0.5, 64.0, 0.5);
    // rust: w.player = Some(crate::mobs::world::test_player(at));
    // rust: let mut m = Mob::new(
    // rust: 1,
    // rust: Arc::new(types.types["minecraft:nautilus"].clone()),
    // rust: Vec3::new(0.5, 64.0, 0.2),
    // rust: 0.0,
    // rust: );
    // rust: m.ai.target = Some(Who::Player);
    // rust: let mut goal = Charge::new(0.5);
    // rust: let mut lr = horizon_core::random::LegacyRandom::new(1);
    // rust: let mut cx = Cx {
    // rust: w: &w,
    // rust: lr: &mut lr,
    // rust: events: &mut events,
}
    // rust: goal.tick(&mut m, &mut cx);
    // rust: });
    // rust: if !ran {
    // rust: return;
}
    // rust: let knock = events.iter().find_map(|e| match e {
    // rust: MobEvent::Knockback {
    // rust: target,
    // rust: power,
    // rust: x,
    // rust: z,
    // rust: ..
    // rust: } => Some((*target, *power, *x, *z)),
    // rust: _ => None,
    // rust: });
    // rust: let (target, power, x, z) = knock.expect("the charge knocks its target back");
    // rust: assert_eq!(target, Who::Player);
    // rust: assert!(power > 0.0);
        // It turns to the target, which is straight ahead at +z (yaw 0): sin = 0, -cos = -1.
    // rust: assert!(x.abs() < 1e-3 && (z + 1.0).abs() < 1e-3, "{x} {z}");
    // rust: assert!(!events.iter().any(|e| matches!(e, MobEvent::Push { .. })));
}

    /// A saddled nautilus with a rider looking south (`+z`), from the trip's
    /// own `MobType`, so no prepared resources are needed.
pub fn ridden() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = crate::mobs::sensor_scan_tests::kind();
    // rust: let k = Arc::make_mut(&mut kind);
    // rust: k.id = "minecraft:nautilus".into();
    // rust: k.species = Species::Nautilus;
    // rust: k.width = 0.9;
    // rust: k.height = 0.9;
    // rust: let mut m = Mob::new(7, kind, Vec3::new(1.5, 40.0, -2.5), 0.0);
    // rust: m.set_saddle(Some(crate::items::ItemStack::new("minecraft:saddle", 1)));
    // rust: m.rider = Some(super::super::equine::Rider {
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: ..Default::default()
    // rust: });
    // rust: m
}

    /// `AbstractNautilus.onPlayerJump` keeps the released bar's scale (0.4 to
    /// 1.0, none while the dash clock runs) and `tickRidden` spends it:
    /// `executeRidersJump` pushes along the rider's look at 0.5 on land,
    /// starts the 40-tick clock, raises DASH and queues the dash sound.
pub fn the_dash_runs_off_the_scale_the_released_bar_left() void {
}
    // rust: let mut m = ridden();
    // rust: assert!(on_player_jump(&mut m, 100));
    // rust: assert_eq!(m.rider.expect("the rider stays on").jump, 1.0);
    // rust: super::super::equine::ridden_step(&mut m);
    // rust: assert_eq!(
    // rust: m.rider.expect("the rider stays on").jump,
    // rust: 0.0,
    // rust: "the scale is spent"
    // rust: );
    // rust: assert_eq!(m.extra.anim_ticks, DASH_COOLDOWN);
    // rust: assert!(m.extra.flag2, "DASH");
    // rust: assert_eq!(m.extra.scratch[1], 1, "the dash sound plays next tick");
    // rust: let k = 0.5 * m.movement_speed();
    // rust: assert!(
    // rust: (m.velocity.z - k).abs() < 1.0e-9 && m.velocity.x.abs() < 1.0e-9,
    // rust: "a dash along +z: {:?} against {k}",
    // rust: m.velocity
    // rust: );
        // A dash still in its cooldown takes nothing (`dashCooldown > 0`), and
        // neither does an unsaddled nautilus.
    // rust: assert!(!on_player_jump(&mut m, 50));
    // rust: m.extra.anim_ticks = 0;
    // rust: m.extra.saddled = false;
    // rust: assert!(!on_player_jump(&mut m, 50));
    // rust: assert_eq!(m.rider.expect("the rider stays on").jump, 0.0);
}
}
