//! Transpiled from Horizon Rust crate
//! Module: horizon-client_warden
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The warden (`Warden`, `AngerManagement`): anger kept per entity,
//! vibration listening, the sonic boom and melee attack, the heartbeat and
//! tendril animations, the model and its emissive layers. Its brain
//! (`WardenAi`) is in `warden_brain`.
// use super::{
    // rust: Damage, DamageKind, Mob, MobEvent, MobWorld, Species, Who,
    // rust: anim::{Poses, State},
    // rust: keyframes::Animation,
    // rust: path::PathType,
    // rust: warden_brain::{self, Brain},
}
// use crate::sculk::{self, Context, Info};
// use horizon_core::{
    // rust: geometry::{Vec3, trig::Mth},
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_protocol::entity_data::PositionSource;
// use std::{collections::HashMap, f32::consts::PI};

pub const EMERGE_DURATION: i64 = warden_brain::EMERGE_DURATION as i64;
pub const DIGGING_COOLDOWN: i64 = warden_brain::DIGGING_COOLDOWN;
pub const DEFAULT_ANGER: i32 = 35;
pub const PROJECTILE_ANGER: i32 = 10;
pub const ON_HURT_ANGER_BOOST: i32 = 20;
pub const MAX_ANGER: i32 = 150;
pub const DARKNESS_RADIUS: f64 = 20.0;
/// Darkness lasts 260 ticks and is renewed within the last 200.
pub const DARKNESS_DURATION: i32 = 260;
pub const DARKNESS_REAPPLY: i32 = 200;

// AnimState keyframe slots.
pub const ROAR: usize = 0;
pub const SNIFF: usize = 1;
pub const EMERGE: usize = 2;
pub const DIGGING: usize = 3;
pub const ATTACK: usize = 4;
pub const SONIC_BOOM: usize = 5;
// AnimState values: tendril and heart animation (ticks, 10 at the start).
pub const TENDRIL: usize = 0;
pub const HEART: usize = 1;

pub const Pose = enum {
    Standing,
    Emerging,
    Digging,
    Roaring,
    Sniffing,
};
    // rust: impl Pose {
pub fn code(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Standing => 0,
    // rust: Self::Emerging => 1,
    // rust: Self::Digging => 2,
    // rust: Self::Roaring => 3,
    // rust: Self::Sniffing => 4,
}
}
pub fn from_code(code: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match code {
    // rust: 1 => Self::Emerging,
    // rust: 2 => Self::Digging,
    // rust: 3 => Self::Roaring,
    // rust: 4 => Self::Sniffing,
    // rust: _ => Self::Standing,
}
}
}
/// `Pose.id` of the poses a warden takes (`sync::pose_id`).
pub fn pose_id(m: *Mob) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match pose(m) {
    // rust: Pose::Standing => 0,
    // rust: Pose::Roaring => 11,
    // rust: Pose::Sniffing => 12,
    // rust: Pose::Emerging => 13,
    // rust: Pose::Digging => 14,
}
}
/// `Entity.onSyncedDataUpdated(DATA_POSE)` on a client.
    // rust: pub(super) fn set_pose_id(m: &mut Mob, id: u8) {
    // rust: set_pose(
    // rust: m,
    // rust: match id {
    // rust: 11 => Pose::Roaring,
    // rust: 12 => Pose::Sniffing,
    // rust: 13 => Pose::Emerging,
    // rust: 14 => Pose::Digging,
    // rust: _ => Pose::Standing,
    // rust: },
    // rust: );
}
/// The warden's pose (kept in `Extra.counter` so it can be read while the
/// brain is being ticked).
pub fn pose(m: *Mob) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Pose::from_code(m.extra.counter)
}
pub fn digging_or_emerging(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(pose(m), Pose::Digging | Pose::Emerging)
}
/// `Entity.setPose`, with `onSyncedDataUpdated` starting the keyframes.
    // rust: pub(super) fn set_pose(m: &mut Mob, new: Pose) {
    // rust: if pose(m) == new {
    // rust: return;
}
    // rust: m.extra.counter = new.code();
    // rust: let age = m.age as f32;
    // rust: match new {
    // rust: Pose::Emerging => m.anim.states[EMERGE].start(age),
    // rust: Pose::Digging => m.anim.states[DIGGING].start(age),
    // rust: Pose::Roaring => m.anim.states[ROAR].start(age),
    // rust: Pose::Sniffing => m.anim.states[SNIFF].start(age),
    // rust: Pose::Standing => {}
}
}

pub const AngerLevel = enum {
    Calm,
    Agitated,
    Angry,
};
    // rust: impl AngerLevel {
pub fn by_anger(anger: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if anger >= 80 {
    // rust: Self::Angry
    // rust: } else if anger >= 40 {
    // rust: Self::Agitated
    // rust: } else {
    // rust: Self::Calm
}
}
pub fn minimum(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Calm => 0,
    // rust: Self::Agitated => 40,
    // rust: Self::Angry => 80,
}
}
pub fn is_angry(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self == Self::Angry
}
pub fn ambient_sound(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Calm => "entity.warden.ambient",
    // rust: Self::Agitated => "entity.warden.agitated",
    // rust: Self::Angry => "entity.warden.angry",
}
}
pub fn listening_sound(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Calm => "entity.warden.listening",
    // rust: _ => "entity.warden.listening_angry",
}
}
}

/// `AngerManagement`: anger per suspect, highest first.
pub const AngerManagement = struct {
    suspects: std.ArrayList(Who),
    anger: HashMap<Who,
    highest: i32,
};
    // rust: impl AngerManagement {
    /// One second: every suspect calms by one; the invalid are forgotten.
pub fn tick(self: *Self, valid: impl Fn(Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut dropped = Vec::new();
    // rust: for (who, anger) in self.anger.iter_mut() {
    // rust: if *anger > 1 && valid(*who) {
    // rust: *anger -= 1;
    // rust: } else {
    // rust: dropped.push(*who);
}
}
    // rust: for who in dropped {
    // rust: self.anger.remove(&who);
    // rust: self.suspects.retain(|s| *s != who);
}
    // rust: self.sort_and_update_highest();
}
pub fn sort_and_update_highest(self: *Self) void {
}
        // AngerManagement.Sorter: the angry first, then players, then the
        // angriest; a stable sort keeps the order of ties.
    // rust: let anger = self.anger.clone();
    // rust: let level = |w: &Who| anger.get(w).copied().unwrap_or(0);
    // rust: self.suspects.sort_by(|a, b| {
    // rust: let (aa, ab) = (level(a), level(b));
    // rust: let (angry_a, angry_b) = (
    // rust: AngerLevel::by_anger(aa).is_angry(),
    // rust: AngerLevel::by_anger(ab).is_angry(),
    // rust: );
    // rust: if angry_a != angry_b {
    // rust: return if angry_a {
    // rust: std::cmp::Ordering::Less
    // rust: } else {
    // rust: std::cmp::Ordering::Greater
}
}
    // rust: let (player_a, player_b) = (*a == Who::Player, *b == Who::Player);
    // rust: if player_a != player_b {
    // rust: return if player_a {
    // rust: std::cmp::Ordering::Less
    // rust: } else {
    // rust: std::cmp::Ordering::Greater
}
}
    // rust: ab.cmp(&aa)
    // rust: });
    // rust: self.highest = match self.suspects.len() {
    // rust: 0 => 0,
    // rust: 1 => level(&self.suspects[0]),
    // rust: _ => self.suspects.iter().map(&level).max().unwrap_or(0),
}
}
    /// `increaseAnger`: the entity's new anger (at most 150).
pub fn increase(self: *Self, who: Who, amount: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let new_suspect = !self.anger.contains_key(&who);
    // rust: let current = (self.anger.get(&who).copied().unwrap_or(0) + amount).min(MAX_ANGER);
    // rust: self.anger.insert(who, current);
    // rust: if new_suspect {
    // rust: self.suspects.push(who);
}
    // rust: self.sort_and_update_highest();
    // rust: current
}
pub fn clear(self: *Self, who: Who) void {
}
    // rust: self.anger.remove(&who);
    // rust: self.suspects.retain(|s| *s != who);
    // rust: self.sort_and_update_highest();
}
    /// `getActiveAnger`: the target's anger, or the highest when there is none.
pub fn active_anger(self: *Self, target: ?Who) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match target {
    // rust: None => self.highest,
    // rust: Some(t) => self.anger.get(&t).copied().unwrap_or(0),
}
}
    /// `getActiveEntity`: the first suspect that can still be targeted.
pub fn active_entity(self: *Self, can_target: impl Fn(Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.suspects.iter().copied().find(|w| can_target(*w))
}
pub fn anger_of(self: *Self, who: Who) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.anger.get(&who).copied().unwrap_or(0)
}
pub fn suspects(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.suspects
}
}

/// The warden's state: anger, its vibration listener and its brain.
pub const Warden = struct {
    anger: AngerManagement,
    vibration: sculk::Data,
    brain: Brain,
    /// `getClientAngerLevel`, synchronised once a second.
    client_anger: i32,
    /// Attackers noted by `hurtServer` and not yet reacted to.
    hurt_by: std.ArrayList((Option<Who),
};
    // rust: impl Warden {
pub fn target(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.brain.mem.attack_target.value()
}
}

pub fn register(m: *mut Mob) void {
}
    // rust: m.extra.warden = Some(Box::default());
    // rust: m.ai.nav.can_float = true;
    // rust: m.set_malus(PathType::UnpassableRail, 0.0);
    // rust: m.set_malus(PathType::Damaging, 8.0);
    // rust: m.set_malus(PathType::PowderSnow, 8.0);
    // rust: m.set_malus(PathType::Lava, 8.0);
    // rust: m.set_malus(PathType::Fire, 0.0);
    // rust: m.set_malus(PathType::FireInNeighbor, 0.0);
    // Brain.Provider.makeBrain: the sensors start on a random phase.
    // rust: delay_sensors(m);
}
/// `Sensor.randomlyDelayStart` for the warden's two sensors, from its random.
pub fn delay_sensors(m: *mut Mob) void {
}
    // rust: if let Some(mut st) = m.extra.warden.take() {
    // rust: st.brain.delay_sensors(&mut m.random);
    // rust: m.extra.warden = Some(st);
}
}
/// A brain whose `RunOne` shuffles with `seed` (vanilla seeds it from the
/// clock; harnesses seed both sides alike), its sensors delayed again.
pub fn init_brain(m: *mut Mob, seed: i64) void {
}
    // rust: if let Some(st) = m.extra.warden.as_mut() {
    // rust: let mem = std::mem::take(&mut st.brain.mem);
    // rust: st.brain = Brain::new(seed);
    // rust: st.brain.mem = mem;
}
    // rust: delay_sensors(m);
}
/// `Warden.finalizeSpawn`: a minute until it digs back down; a summoned
/// warden climbs out of the ground first.
pub fn finalize(m: *mut Mob, triggered: bool, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.extra.warden.is_none() {
    // rust: return;
}
    // rust: warden_brain::mem(m)
    // rust: .dig_cooldown
    // rust: .set_ttl((), DIGGING_COOLDOWN);
    // rust: if triggered {
    // rust: set_pose(m, Pose::Emerging);
    // rust: warden_brain::mem(m)
    // rust: .is_emerging
    // rust: .set_ttl((), EMERGE_DURATION);
    // rust: sound(m, "entity.warden.agitated", 5.0, 1.0, events);
}
}
pub fn at(m: *Mob) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [m.position.x, m.position.y, m.position.z]
}
pub fn sound(m: *Mob, name: *'static str, volume: f32, pitch: f32, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: events.push(MobEvent::Sound(name, at(m), volume, pitch));
}
/// `LivingEntity.getVoicePitch` for an adult.
pub fn voice_pitch(m: *mut Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (m.random.next_float() - m.random.next_float()) * 0.2 + 1.0
}
pub fn closer_than(m: *Mob, p: Vec3, horizontal: f64, vertical: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (dx, dy, dz) = (p.x - m.position.x, p.y - m.position.y, p.z - m.position.z);
    // rust: dx * dx + dz * dz < horizontal * horizontal && dy * dy < vertical * vertical
}

// ---- entity facts ----

/// `Warden.canTargetEntity`: living, neither creative nor spectator, not a
/// warden, alive.
pub fn can_target(w: *MobWorld, who: Who) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match who {
    // rust: Who::Player => w
    // rust: .player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.alive && !p.creative && !p.spectator),
    // rust: Who::Mob(id) => w
    // rust: .seen(id)
    // rust: .is_some_and(|s| s.alive && s.species != Species::Warden),
}
}
pub fn position_of(w: *MobWorld, who: Who) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: w.target_info(who).map(|t| t.position)
}

// ---- anger ----

/// `Warden.increaseAngerAt`.
    // rust: pub(super) fn increase_anger(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: who: Option<Who>,
    // rust: amount: i32,
    // rust: play_sound: bool,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: let Some(who) = who else { return };
    // rust: if m.no_ai || !can_target(w, who) {
    // rust: return;
}
    // rust: warden_brain::set_dig_cooldown(m);
    // rust: let Some(st) = m.extra.warden.as_mut() else {
    // rust: return;
}
    // rust: let maybe_switch = st.target() != Some(Who::Player);
    // rust: let new = st.anger.increase(who, amount);
    // rust: if who == Who::Player && maybe_switch && AngerLevel::by_anger(new).is_angry() {
    // rust: st.brain.mem.attack_target.clear();
}
    // rust: if play_sound && pose(m) != Pose::Roaring {
    // rust: let level = anger_level(m);
    // rust: let pitch = voice_pitch(m);
    // rust: sound(m, level.listening_sound(), 10.0, pitch, events);
}
}
/// `Warden.getEntityAngryAt`.
    // rust: pub(super) fn entity_angry_at(m: &Mob, w: &MobWorld) -> Option<Who> {
    // rust: let st = m.extra.warden.as_ref()?;
    // rust: if anger_level(m).is_angry() {
    // rust: st.anger.active_entity(|e| can_target(w, e))
    // rust: } else {
    // rust: None
}
}
/// `Warden.getAngerLevel`.
pub fn anger_level(m: *Mob) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.warden.as_ref().map_or(AngerLevel::Calm, |s| {
    // rust: AngerLevel::by_anger(s.anger.active_anger(s.target()))
    // rust: })
}

// ---- damage ----

/// `Warden.isInvulnerableTo`: while digging or emerging.
pub fn accepts_damage(m: *Mob, source: *Damage) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !(digging_or_emerging(m) && !source.kind.bypasses_invulnerability())
}
/// `Warden.hurtServer`'s reaction, handled at the warden's next tick.
pub fn hurt(m: *mut Mob, source: *Damage) void {
}
    // rust: if m.no_ai || digging_or_emerging(m) {
    // rust: return;
}
    // rust: let direct = !matches!(
    // rust: source.kind,
    // rust: DamageKind::Arrow | DamageKind::Thrown | DamageKind::Fireball | DamageKind::WitherSkull
    // rust: );
    // rust: if let Some(st) = m.extra.warden.as_mut() {
    // rust: st.hurt_by.push((source.attacker, direct));
}
}
/// The rest of `Warden.hurtServer`.
pub fn handle_hurt(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: let hurt = m
    // rust: .extra
    // rust: .warden
    // rust: .as_mut()
    // rust: .map(|st| std::mem::take(&mut st.hurt_by))
    // rust: .unwrap_or_default();
    // rust: for (attacker, direct) in hurt {
    // rust: increase_anger(
    // rust: m,
    // rust: w,
    // rust: attacker,
    // rust: AngerLevel::Angry.minimum() + ON_HURT_ANGER_BOOST,
    // rust: false,
    // rust: events,
    // rust: );
    // rust: if !warden_brain::mem(m).attack_target.present()
    // rust: && let Some(who) = attacker
    // rust: && let Some(p) = position_of(w, who)
    // rust: && (direct || m.distance_sqr(p) < 25.0)
    // rust: {
    // rust: warden_brain::set_attack_target(m, who);
}
}
}
/// `Warden.doPush`: touching something angers it (once a second).
pub fn do_push(m: *mut Mob, w: *MobWorld, who: Who, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.no_ai || m.extra.warden.is_none() || warden_brain::mem(m).touch_cooldown.present() {
    // rust: return;
}
    // rust: warden_brain::mem(m).touch_cooldown.set_ttl((), 20);
    // rust: increase_anger(m, w, Some(who), DEFAULT_ANGER, true, events);
    // rust: if let Some(t) = w.target_info(who) {
    // rust: let block = [
    // rust: t.position.x.floor() as i32,
    // rust: t.position.y.floor() as i32,
    // rust: t.position.z.floor() as i32,
    // rust: ];
    // rust: warden_brain::set_disturbance(m, w, block);
}
}
/// `Warden.doHurtTarget`: the attack keyframes (entity event 4), the impact
/// sound, a sonic boom cooldown, then `Mob.doHurtTarget`.
    // rust: pub(super) fn do_hurt_target(
    // rust: m: &mut Mob,
    // rust: target: Who,
    // rust: w: &MobWorld,
    // rust: lr: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: m.anim.states[ROAR].stop();
    // rust: m.anim.states[ATTACK].start(m.age as f32);
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 4,
    // rust: at: at(m),
    // rust: });
    // rust: let pitch = voice_pitch(m);
    // rust: sound(m, "entity.warden.attack_impact", 10.0, pitch, events);
    // rust: warden_brain::mem(m).sonic_boom_cooldown.set_ttl((), 40);
    // rust: let mut cx = warden_brain::cx(w, lr, events);
    // rust: super::ai::do_hurt_target(m, target, &mut cx);
}

/// The brain's attack target (`Warden.getTarget` before `asValidTarget`).
pub fn brain_target(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: warden_brain::mem_ref(m).and_then(|mem| mem.attack_target.value())
}

// ---- vibrations ----

/// `Warden.VibrationUser.canReceiveVibration`.
pub fn can_receive_vibration(m: *Mob, _now: i64, ctx: *Context) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(st) = m.extra.warden.as_ref() else {
    // rust: return false;
}
    // rust: !m.no_ai
    // rust: && m.alive()
    // rust: && !st.brain.mem.vibration_cooldown.present()
    // rust: && !digging_or_emerging(m)
    // rust: && (!ctx.living || ctx.targetable)
}
/// `VibrationSystem.Listener.handleGameEvent` for the warden: a free
/// listener within 16 blocks of its eyes schedules what it can hear.
/// `occluded` is `VibrationSystem.Listener.isOccluded`. Returns true when a
/// sneaking player's step was avoided (AVOID_VIBRATION) instead.
    // rust: pub fn listen(
    // rust: m: &mut Mob,
    // rust: now: i64,
    // rust: event: &'static str,
    // rust: pos: [f64; 3],
    // rust: ctx: &Context,
    // rust: occluded: impl Fn([f64; 3], [f64; 3]) -> bool,
    // rust: ) -> bool {
    // rust: let eye = [m.position.x, m.position.y + m.kind.eye_height, m.position.z];
    // rust: let Some(st) = m.extra.warden.as_ref() else {
    // rust: return false;
}
    // rust: if st.vibration.current.is_some() {
    // rust: return false;
}
    // rust: let block = |p: [f64; 3]| p.map(|v| i64::from(v.floor() as i32));
    // rust: let (source, listener) = (block(pos), block(eye));
    // rust: let d = [0, 1, 2].map(|i| source[i] - listener[i]);
    // rust: if d[0] * d[0] + d[1] * d[1] + d[2] * d[2] > 256 {
    // rust: return false;
}
    // isValidVibration: the warden can trigger avoid vibration.
    // rust: let listens = sculk::warden_can_listen(event);
    // rust: if listens
    // rust: && ctx.source == Some(Who::Player)
    // rust: && !ctx.spectator
    // rust: && ctx.stepping_carefully
    // rust: && sculk::ignored_when_sneaking(event)
    // rust: {
    // rust: return true;
}
    // rust: if !sculk::valid_vibration(listens, event, ctx)
    // rust: || !can_receive_vibration(m, i64::from(m.age), ctx)
    // rust: || occluded(pos, eye)
    // rust: {
    // rust: return false;
}
    // rust: let d = [pos[0] - eye[0], pos[1] - eye[1], pos[2] - eye[2]];
    // rust: let distance = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt() as f32;
    // rust: if let Some(st) = m.extra.warden.as_mut() {
    // rust: st.vibration.schedule(
    // rust: Info {
    // rust: event,
    // rust: distance,
    // rust: pos,
    // rust: source: ctx.source,
    // rust: owner: ctx.owner,
    // rust: },
    // rust: now,
    // rust: );
}
    // rust: false
}
/// `Level.gameEvent` for the mobs' own movement events from `from` on, as
/// the mob AI probe has no sculk layer: every warden's listener hears them.
pub fn hear_mob_events(mobs: *mut [Mob], events: *[MobEvent], from: usize, w: *MobWorld) void {
}
    // rust: for e in &events[from..] {
    // rust: let MobEvent::GameEvent {
    // rust: event,
    // rust: at,
    // rust: source,
    // rust: state,
    // rust: } = *e
    // rust: else {
    // rust: continue;
}
    // rust: let who = mobs.iter().find(|m| m.id == source);
    // rust: let name = &w.facts.get(state).name;
    // rust: let ctx = Context {
    // rust: source: Some(Who::Mob(source)),
    // rust: dampening_state: w.has_tag("minecraft:dampens_vibrations", name),
    // rust: dampens: who.is_some_and(|m| m.species() == Species::Warden),
    // rust: targetable: who.is_some_and(|m| m.alive() && m.species() != Species::Warden),
    // rust: living: true,
    // rust: ..Context::default()
}
    // rust: for m in mobs.iter_mut().filter(|m| m.extra.warden.is_some()) {
    // rust: listen(m, w.game_time, event, at, &ctx, |a, b| {
    // rust: sculk::is_occluded(a, b, |p| {
    // rust: let block = w.world.block(p.x, p.y, p.z);
    // rust: w.has_tag(
    // rust: "minecraft:occludes_vibration_signals",
    // rust: &w.facts.get(block).name,
    // rust: )
    // rust: })
    // rust: });
}
}
}
/// `Warden.VibrationUser.onReceiveVibration`.
pub fn receive_vibration(m: *mut Mob, w: *MobWorld, info: Info, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // rust: warden_brain::mem(m).vibration_cooldown.set_ttl((), 40);
    // Entity event 61: the tendrils twitch.
    // rust: m.anim.v[TENDRIL] = 10.0;
    // rust: events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 61,
    // rust: at: at(m),
    // rust: });
    // rust: let pitch = voice_pitch(m);
    // rust: sound(m, "entity.warden.tendril_clicks", 5.0, pitch, events);
    // rust: let origin = [
    // rust: info.pos[0].floor() as i32,
    // rust: info.pos[1].floor() as i32,
    // rust: info.pos[2].floor() as i32,
    // rust: ];
    // rust: let mut suspicious = origin;
    // rust: if let Some(owner) = info.owner {
    // rust: if let Some(p) = position_of(w, owner)
    // rust: && m.distance_sqr(p) < 900.0
    // rust: {
    // rust: if warden_brain::mem(m).recent_projectile.present() {
    // rust: if can_target(w, owner)
    // rust: && let Some(t) = w.target_info(owner)
    // rust: {
    // rust: suspicious = [
    // rust: t.position.x.floor() as i32,
    // rust: t.position.y.floor() as i32,
    // rust: t.position.z.floor() as i32,
    // rust: ];
}
    // rust: increase_anger(m, w, Some(owner), DEFAULT_ANGER, true, events);
    // rust: } else {
    // rust: increase_anger(m, w, Some(owner), PROJECTILE_ANGER, true, events);
}
}
    // rust: warden_brain::mem(m).recent_projectile.set_ttl((), 100);
    // rust: } else {
    // rust: increase_anger(m, w, info.source, DEFAULT_ANGER, true, events);
}
    // rust: if !anger_level(m).is_angry() {
    // rust: let active = m
    // rust: .extra
    // rust: .warden
    // rust: .as_ref()
    // rust: .and_then(|st| st.anger.active_entity(|e| can_target(w, e)));
    // rust: if info.owner.is_some() || active.is_none() || active == info.source {
    // rust: warden_brain::set_disturbance(m, w, suspicious);
}
}
}

// ---- the server tick ----

/// `Warden.tick` before `super.tick()`: the vibration ticker, and
/// persistence keeping the dig cooldown.
pub fn pre_tick(m: *mut Mob, w: *MobWorld, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if m.extra.warden.is_none() {
    // rust: return;
}
    // rust: let tick = m
    // rust: .extra
    // rust: .warden
    // rust: .as_mut()
    // rust: .map(|st| {
    // rust: st.vibration
    // rust: .tick(w.game_time, true, false, |d| d.floor() as i32)
    // rust: })
    // rust: .unwrap_or_default();
    // rust: if let Some((info, travel)) = tick.started {
    // rust: let eye = [m.position.x, m.position.y + m.kind.eye_height, m.position.z];
    // rust: events.push(MobEvent::Vibration {
    // rust: from: info.pos,
    // rust: to: eye,
    // rust: ticks: travel,
            // `Warden.VibrationUser`: `new EntityPositionSource(warden,
            // warden.getEyeHeight())`.
    // rust: source: PositionSource::Entity {
    // rust: id: m.id as i32,
    // rust: y_offset: m.kind.eye_height as f32,
    // rust: },
    // rust: });
}
    // rust: if let Some(info) = tick.received {
    // rust: receive_vibration(m, w, info, events);
}
    // rust: if m.persistent || m.custom_name.is_some() {
    // rust: warden_brain::set_dig_cooldown(m);
}
}
/// `Warden.customServerAiStep`: the brain, the darkness pulse, anger and
/// the activity.
    // rust: pub fn server_ai_step(
    // rust: m: &mut Mob,
    // rust: w: &MobWorld,
    // rust: level_random: &mut LegacyRandom,
    // rust: events: &mut Vec<MobEvent>,
    // rust: ) {
    // rust: if m.extra.warden.is_none() {
    // rust: return;
}
    // rust: handle_hurt(m, w, events);
    // rust: warden_brain::tick(m, w, level_random, events);
    // rust: if (i64::from(m.age) + i64::from(m.id)) % 120 == 0 {
    // rust: events.push(MobEvent::Darkness {
    // rust: at: at(m),
    // rust: radius: DARKNESS_RADIUS,
    // rust: });
}
    // rust: if m.age.is_multiple_of(20)
    // rust: && let Some(st) = m.extra.warden.as_mut()
    // rust: {
    // rust: st.anger.tick(|who| can_target(w, who));
    // rust: st.client_anger = st.anger.active_anger(st.target());
}
    // rust: if let Some(st) = m.extra.warden.as_mut() {
    // rust: st.brain.update_activity();
}
}
/// `SonicBoom.tick`: face the target; once the sound delay is over, the
/// beam, the sound, the damage and the knockback.
    // rust: pub(super) fn tick_sonic_boom(m: &mut Mob, w: &MobWorld, events: &mut Vec<MobEvent>) {
    // rust: let Some(target) = warden_brain::mem(m).attack_target.value() else {
    // rust: return;
}
    // rust: if let Some(t) = w.target_info(target) {
    // rust: m.look_at([t.position.x, t.position.y, t.position.z]);
}
    // rust: let mm = warden_brain::mem(m);
    // rust: if mm.sonic_boom_sound_delay.present() || mm.sonic_boom_sound_cooldown.present() {
    // rust: return;
}
    // rust: mm.sonic_boom_sound_cooldown.set_ttl((), 60 - 34);
    // rust: if !can_target(w, target) {
    // rust: return;
}
    // rust: let Some(t) = w.target_info(target) else {
    // rust: return;
}
    // rust: if !closer_than(m, t.position, 15.0, 20.0) {
    // rust: return;
}
    // The chest attachment: 1.6 up and 0.0 forward.
    // rust: let source = [m.position.x, m.position.y + 1.6, m.position.z];
    // rust: let eye = [t.position.x, t.eye_y, t.position.z];
    // rust: let delta = [eye[0] - source[0], eye[1] - source[1], eye[2] - source[2]];
    // rust: let length = (delta[0] * delta[0] + delta[1] * delta[1] + delta[2] * delta[2]).sqrt();
    // rust: let normal = if length < 1.0e-5 {
    // rust: [0.0; 3]
    // rust: } else {
    // rust: [delta[0] / length, delta[1] / length, delta[2] / length]
}
    // rust: let steps = length.floor() as i32 + 7;
    // rust: for i in 1..steps {
    // rust: let d = f64::from(i);
    // rust: events.push(MobEvent::Particles {
    // rust: kind: "sonic_boom",
    // rust: at: [
    // rust: source[0] + normal[0] * d,
    // rust: source[1] + normal[1] * d,
    // rust: source[2] + normal[2] * d,
    // rust: ],
    // rust: count: 0,
    // rust: });
}
    // rust: sound(m, "entity.warden.sonic_boom", 3.0, 1.0, events);
    // rust: events.push(MobEvent::SonicBoom {
    // rust: target,
    // rust: attacker: m.id,
    // rust: from: at(m),
    // rust: direction: normal,
    // rust: });
}
/// `Warden.tick` on the client: the heartbeat (pitched by the client's copy
/// of the warden: a level event sound here), the tendril and heart
/// animations, digging crumbs, and keyframes that ended.
pub fn ai_step(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if heartbeat(m) {
    // rust: events.push(MobEvent::LevelEventSound {
    // rust: sound: "entity.warden.heartbeat",
    // rust: at: at(m),
    // rust: volume: 5.0,
    // rust: spread: 0.2,
    // rust: });
}
    // rust: animate(m, events);
}
/// The heart's beat on its clock, from the client's anger level: whether
/// this tick has one (its sound is the caller's).
pub fn heartbeat(m: *mut Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(st) = m.extra.warden.as_ref() else {
    // rust: return false;
}
    // rust: let delay = heart_beat_delay(st.client_anger);
    // rust: let beat = i64::from(m.age) % i64::from(delay) == 0;
    // rust: if beat {
    // rust: m.anim.v[HEART] = 10.0;
}
    // rust: beat
}
/// `Warden.tick` on a client that is not the server: the heart and tendril
/// animations and the keyframes that ended. Its sounds come from the server,
/// but `Warden.clientDiggingParticles` is the client's own work, so the digging
/// events are handed back to the caller.
pub fn client_tick(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: m.anim.vo = m.anim.v;
    // rust: heartbeat(m);
    // rust: animate(m, events);
}
pub fn animate(m: *mut Mob, events: *mut std.ArrayList(MobEvent)) void {
}
    // The animation values count down after the sync of the last tick.
    // rust: for slot in [TENDRIL, HEART] {
    // rust: if m.anim.v[slot] > 0.0 {
    // rust: m.anim.v[slot] -= 1.0;
}
}
    // rust: let digging_clock = |m: &Mob, slot: usize| {
    // rust: m.anim.states[slot]
    // rust: .millis(m.age as f32)
    // rust: .is_some_and(|ms| (ms as f32) < 4500.0)
}
    // rust: match pose(m) {
    // rust: Pose::Emerging if digging_clock(m, EMERGE) => {
    // rust: events.push(MobEvent::DigParticles { at: at(m) })
}
    // rust: Pose::Digging if digging_clock(m, DIGGING) => {
    // rust: events.push(MobEvent::DigParticles { at: at(m) })
}
    // rust: _ => {}
}
    // Poses that ended stop their keyframes.
    // rust: let p = pose(m);
    // rust: if p != Pose::Roaring {
    // rust: m.anim.states[ROAR].stop();
}
    // rust: if p != Pose::Sniffing {
    // rust: m.anim.states[SNIFF].stop();
}
    // rust: if p != Pose::Emerging {
    // rust: m.anim.states[EMERGE].stop();
}
    // rust: if p != Pose::Digging {
    // rust: m.anim.states[DIGGING].stop();
}
    // rust: if m.anim.states[ATTACK]
    // rust: .millis(m.age as f32)
    // rust: .is_some_and(|ms| ms > 1000)
    // rust: {
    // rust: m.anim.states[ATTACK].stop();
}
    // rust: if m.anim.states[SONIC_BOOM]
    // rust: .millis(m.age as f32)
    // rust: .is_some_and(|ms| ms > 3500)
    // rust: {
    // rust: m.anim.states[SONIC_BOOM].stop();
}
}
/// Test aid: the minute of calm ran out.
pub fn expire_dig_cooldown(m: *mut Mob) void {
}
    // rust: if m.extra.warden.is_some() {
    // rust: let mm = warden_brain::mem(m);
    // rust: mm.dig_cooldown.clear();
    // rust: mm.attack_target.clear();
    // rust: mm.roar_target.clear();
}
}
/// The warden's state for the control socket.
pub fn describe(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let st = m.extra.warden.as_ref()?;
    // rust: let anger: Vec<String> = st
    // rust: .anger
    // rust: .suspects()
    // rust: .iter()
    // rust: .map(|w| format!("{w:?}={}", st.anger.anger_of(*w)))
    // rust: .collect();
    // rust: let (activities, memories) = warden_brain::describe(m).unwrap_or_default();
    // rust: Some(serde_json::json!({
    // rust: "pose": format!("{:?}", pose(m)),
    // rust: "activities": activities,
    // rust: "memories": memories,
    // rust: "anger_level": format!("{:?}", anger_level(m)),
    // rust: "anger": anger,
    // rust: "vibration": st.vibration.current.map(|i| i.event),
    // rust: }))
}
/// `Warden.getHeartBeatDelay`.
pub fn heart_beat_delay(client_anger: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let anger = client_anger as f32 / AngerLevel::Angry.minimum() as f32;
    // rust: 40 - (anger.clamp(0.0, 1.0) * 30.0).floor() as i32
}
/// `Warden.getAmbientSound`: none while roaring, digging or emerging.
pub fn ambient_sound(m: *Mob) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if pose(m) == Pose::Roaring || digging_or_emerging(m) {
    // rust: None
    // rust: } else {
    // rust: Some(anger_level(m).ambient_sound())
}
}
/// `getTendrilAnimation` / `getHeartAnimation` at the partial tick.
pub fn tendril_animation(m: *Mob, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.anim.lerp(TENDRIL, partial) / 10.0
}
pub fn heart_animation(m: *Mob, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.anim.lerp(HEART, partial) / 10.0
}

// ---- model ----

/// `WardenModel.setupAnim`.
pub fn anim(m: *Mob, s: *State, p: *mut Poses, animations: *HashMap<[]const u8) void {
}
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.yrot("head", s.y_rot.to_radians());
    // animateWalk
    // rust: let speed_modifier = (3.0 * s.speed).min(0.5);
    // rust: let adjusted = s.pos * 0.8662;
    // rust: let (cos, sin) = (adjusted.mcos(), adjusted.msin());
    // rust: let speed_min = speed_modifier.min(0.35);
    // rust: let head_z = p.get("head")[5] + 0.3 * sin * speed_modifier;
    // rust: p.zrot("head", head_z);
    // rust: let head_x = p.get("head")[3] + 1.2 * (adjusted + PI / 2.0).mcos() * speed_min;
    // rust: p.xrot("head", head_x);
    // rust: p.zrot("body", 0.1 * sin * speed_modifier);
    // rust: p.xrot("body", cos * speed_min);
    // rust: p.xrot("left_leg", cos * speed_modifier);
    // rust: p.xrot("right_leg", (adjusted + PI).mcos() * speed_modifier);
    // rust: p.xrot("left_arm", -(0.8 * cos * speed_modifier));
    // rust: p.zrot("left_arm", 0.0);
    // rust: p.xrot("right_arm", -(0.8 * sin * speed_modifier));
    // rust: p.zrot("right_arm", 0.0);
    // rust: for (arm, x) in [("left_arm", 13.0), ("right_arm", -13.0)] {
    // rust: let a = p.get(arm);
    // rust: a[4] = 0.0;
    // rust: a[2] = 1.0;
    // rust: a[0] = x;
    // rust: a[1] = -13.0;
}
    // animateIdlePose
    // rust: let scaled = s.age * 0.1;
    // rust: let (wobble_cos, wobble_sin) = (scaled.mcos(), scaled.msin());
    // rust: let head_z = p.get("head")[5] + 0.06 * wobble_cos;
    // rust: p.zrot("head", head_z);
    // rust: let head_x = p.get("head")[3] + 0.06 * wobble_sin;
    // rust: p.xrot("head", head_x);
    // rust: let body_z = p.get("body")[5] + 0.025 * wobble_sin;
    // rust: p.zrot("body", body_z);
    // rust: let body_x = p.get("body")[3] + 0.025 * wobble_cos;
    // rust: p.xrot("body", body_x);
    // animateTendrils
    // rust: let tendril = tendril_animation(m, s.partial)
    // rust: * ((f64::from(s.age) * 2.25).cos() * std::f64::consts::PI * f64::from(0.1f32)) as f32;
    // rust: p.xrot("left_tendril", tendril);
    // rust: p.xrot("right_tendril", -tendril);
    // rust: for (slot, name) in [
    // rust: (ATTACK, "WARDEN_ATTACK"),
    // rust: (SONIC_BOOM, "WARDEN_SONIC_BOOM"),
    // rust: (DIGGING, "WARDEN_DIG"),
    // rust: (EMERGE, "WARDEN_EMERGE"),
    // rust: (ROAR, "WARDEN_ROAR"),
    // rust: (SNIFF, "WARDEN_SNIFF"),
    // rust: ] {
    // rust: if let (Some(ms), Some(a)) = (
    // rust: m.anim.states[slot].millis(s.age),
    // rust: animations.get(&format!("WardenAnimation.{name}")),
    // rust: ) {
    // rust: a.apply(ms, 1.0, p);
}
}
}
/// The emissive layers of `WardenRenderer`: the bioluminescent skin, the
/// pulsating spots, the tendrils and the heart, as (model, texture, alpha).
pub fn emissive_layers(m: *Mob, partial: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let age = m.age as f32 + partial;
    // rust: [
    // rust: (
    // rust: "warden#bioluminescent",
    // rust: "entity/warden/warden_bioluminescent_layer",
    // rust: 1.0,
    // rust: ),
    // rust: (
    // rust: "warden#pulsating_spots",
    // rust: "entity/warden/warden_pulsating_spots_1",
    // rust: ((age * 0.045).mcos() * 0.25).max(0.0),
    // rust: ),
    // rust: (
    // rust: "warden#pulsating_spots",
    // rust: "entity/warden/warden_pulsating_spots_2",
    // rust: ((age * 0.045 + PI).mcos() * 0.25).max(0.0),
    // rust: ),
    // rust: (
    // rust: "warden#tendrils",
    // rust: "entity/warden/warden",
    // rust: tendril_animation(m, partial),
    // rust: ),
    // rust: (
    // rust: "warden#heart",
    // rust: "entity/warden/warden_heart",
    // rust: heart_animation(m, partial),
    // rust: ),
    // rust: ]
}

    // rust: mod tests {
//     use super::*;

pub fn anger_levels_follow_the_thresholds() void {
}
    // rust: assert_eq!(AngerLevel::by_anger(0), AngerLevel::Calm);
    // rust: assert_eq!(AngerLevel::by_anger(39), AngerLevel::Calm);
    // rust: assert_eq!(AngerLevel::by_anger(40), AngerLevel::Agitated);
    // rust: assert_eq!(AngerLevel::by_anger(79), AngerLevel::Agitated);
    // rust: assert_eq!(AngerLevel::by_anger(80), AngerLevel::Angry);
    // rust: assert!(AngerLevel::Angry.is_angry());
    // rust: assert_eq!(AngerLevel::Calm.ambient_sound(), "entity.warden.ambient");
    // rust: assert_eq!(
    // rust: AngerLevel::Agitated.listening_sound(),
    // rust: "entity.warden.listening_angry"
    // rust: );
}

pub fn anger_accumulates_to_a_cap_and_decays_each_second() void {
}
    // rust: let mut a = AngerManagement::default();
    // rust: assert_eq!(a.increase(Who::Player, 35), 35);
    // rust: assert_eq!(a.increase(Who::Player, 35), 70);
    // rust: assert_eq!(a.increase(Who::Player, 100), 150);
    // rust: assert_eq!(a.active_anger(None), 150);
    // rust: a.tick(|_| true);
    // rust: assert_eq!(a.anger_of(Who::Player), 149);
        // An invalid suspect is forgotten.
    // rust: a.increase(Who::Mob(3), 10);
    // rust: a.tick(|w| w == Who::Player);
    // rust: assert_eq!(a.anger_of(Who::Mob(3)), 0);
    // rust: assert_eq!(a.suspects(), &[Who::Player]);
        // Anger of one point is gone after the next second.
    // rust: let mut b = AngerManagement::default();
    // rust: b.increase(Who::Mob(1), 1);
    // rust: b.tick(|_| true);
    // rust: assert!(b.suspects().is_empty());
}

pub fn the_angriest_player_comes_first() void {
}
    // rust: let mut a = AngerManagement::default();
    // rust: a.increase(Who::Mob(1), 90);
    // rust: a.increase(Who::Player, 50);
    // rust: a.increase(Who::Mob(2), 120);
        // Angry suspects first, the angrier mob before the weaker one...
    // rust: assert_eq!(a.suspects(), &[Who::Mob(2), Who::Mob(1), Who::Player]);
        // ...until the player is angry as well: players lead ties of level.
    // rust: a.increase(Who::Player, 40);
    // rust: assert_eq!(a.suspects()[0], Who::Player);
    // rust: assert_eq!(a.active_entity(|w| w != Who::Player), Some(Who::Mob(2)));
    // rust: assert_eq!(a.active_anger(Some(Who::Mob(1))), 90);
    // rust: assert_eq!(a.active_anger(Some(Who::Mob(9))), 0);
    // rust: a.clear(Who::Player);
    // rust: assert_eq!(a.suspects(), &[Who::Mob(2), Who::Mob(1)]);
    // rust: assert_eq!(a.active_anger(None), 120);
}

pub fn a_single_suspect_sets_the_highest_anger() void {
}
    // rust: let mut a = AngerManagement::default();
    // rust: a.increase(Who::Mob(5), 44);
    // rust: assert_eq!(a.active_anger(None), 44);
    // rust: a.clear(Who::Mob(5));
    // rust: assert_eq!(a.active_anger(None), 0);
}

pub fn the_heart_beats_faster_when_angry() void {
}
    // rust: assert_eq!(heart_beat_delay(0), 40);
    // rust: assert_eq!(heart_beat_delay(40), 25);
    // rust: assert_eq!(heart_beat_delay(80), 10);
    // rust: assert_eq!(heart_beat_delay(150), 10);
}

pub fn the_pose_codes_round_trip() void {
}
    // rust: for p in [
    // rust: Pose::Standing,
    // rust: Pose::Emerging,
    // rust: Pose::Digging,
    // rust: Pose::Roaring,
    // rust: Pose::Sniffing,
    // rust: ] {
    // rust: assert_eq!(Pose::from_code(p.code()), p);
}
}
}

    // rust: mod digging_tests {
//     use super::*;
//     use crate::mobs::MobTypes;
//     use std::sync::Arc;

pub fn mob(kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("entity-types.json").exists() {
    // rust: return None;
}
    // rust: let data = MobTypes::load(&root).ok()?;
    // rust: let kind = Arc::new(data.types.get(kind)?.clone());
    // rust: Some(Mob::new(
    // rust: 1,
    // rust: kind,
    // rust: horizon_core::geometry::Vec3::new(0.0, 4.0, 0.0),
    // rust: 0.0,
    // rust: ))
}

    /// `Warden.clientDiggingParticles` (#8614): while the emerging or digging
    /// animation is under 4500 ms the client wants 30 block particles a tick,
    /// so `client_tick` has to hand the event to the caller instead of
    /// dropping it.
pub fn an_emerging_warden_hands_its_digging_particles_back() void {
}
    // rust: let Some(mut m) = mob("minecraft:warden") else {
    // rust: return;
}
    // rust: let mut out = Vec::new();
    // rust: client_tick(&mut m, &mut out);
    // rust: assert!(out.is_empty(), "a standing warden digs nothing: {out:?}");

    // rust: set_pose(&mut m, Pose::Emerging);
    // rust: client_tick(&mut m, &mut out);
    // rust: assert!(
    // rust: out.iter()
    // rust: .any(|e| matches!(e, MobEvent::DigParticles { .. })),
    // rust: "an emerging warden digs: {out:?}"
    // rust: );

        // Past 4500 ms the animation has played out.
    // rust: m.age += 20 * 5;
    // rust: out.clear();
    // rust: client_tick(&mut m, &mut out);
    // rust: assert!(
    // rust: !out.iter()
    // rust: .any(|e| matches!(e, MobEvent::DigParticles { .. })),
    // rust: "the animation is over: {out:?}"
    // rust: );
}
}
