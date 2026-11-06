//! Transpiled from Horizon Rust crate
//! Module: horizon-client_witch
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Witches (potion drinking and splash potion attacks) and the shared
//! `RangedAttackGoal` (also used by snow golems).
// use super::{
    // rust: Mob, MobEvent, Species, Who,
    // rust: anim::{Poses, State},
    // rust: goals::{
    // rust: Cx, Float, Goal, HurtByTarget, LOOK, LookAtPlayer, MOVE, NearestTarget, RandomLookAround,
    // rust: Stroll, goal_clone,
    // rust: },
}
// use crate::projectiles::{Projectile, ProjectileKind};
// use horizon_core::geometry::trig::Mth;
// use horizon_core::{geometry::Vec3, random::RandomSource};

pub fn register(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(1, Float);
    // rust: g.add(2, RangedAttack::new(1.0, 60, 60, 10.0, witch_attack));
    // rust: g.add(2, Stroll::avoiding_water(1.0));
    // rust: g.add(3, LookAtPlayer::new(8.0));
    // rust: g.add(3, RandomLookAround::default());
    // HurtByTargetGoal(this, Raider.class): a witch ignores the raider that
    // hit it, so raid friendly fire never turns the raid on itself.
    // rust: m.ai.targets.add(1, hurt_by());
    // rust: m.ai.targets.add(2, HealRaiders::default());
    // NearestAttackableWitchTargetGoal: only while not healing raiders.
    // rust: m.ai.targets.add(
    // rust: 3,
    // rust: NearestTarget::player(true)
    // rust: .interval(10)
    // rust: .gate(|m, _| m.extra.counter2 <= 0)
    // rust: .named("NearestAttackableWitchTargetGoal"),
    // rust: );
}
/// `Witch.registerGoals`' `HurtByTargetGoal(this, Raider.class)`.
pub fn hurt_by() H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HurtByTarget::new().ignoring(&super::raider::RAIDERS)
}
/// `NearestHealableRaiderTargetGoal`: in a raid, target another raider to
/// heal, then wait 10 seconds (the cooldown lives in `extra.counter2`).
pub const HealRaiders = struct {};
    // rust: impl Default for HealRaiders {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(
    // rust: NearestTarget::new(
    // rust: super::goals::Prey::Filter(|s| {
    // rust: super::raider::is_raider(s.species) && s.species != Species::Witch
    // rust: }),
    // rust: true,
    // rust: )
    // rust: .interval(0),
    // rust: )
}
}
    // rust: impl Goal for HealRaiders {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.flags()
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.extra.counter2 > 0 || !m.random.next_boolean() {
    // rust: return false;
}
    // rust: if !super::raider::has_active_raid(m) {
    // rust: return false;
}
    // rust: self.0.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.can_continue(m, cx)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.extra.counter2 = super::goals::reduced(200);
    // rust: self.0.start(m, cx);
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx);
}
}
/// The callback a ranged mob uses to fire (`RangedAttackMob.performRangedAttack`).
    // rust: pub type Fire = fn(&mut Mob, Who, f32, &mut Cx);

/// RangedAttackGoal(speed, intervalMin, intervalMax, radius).
pub const RangedAttack = struct {
    speed: f64,
    min: i32,
    max: i32,
    radius: f32,
    fire: Fire,
    attack_time: i32,
    see_time: i32,
};
    // rust: impl RangedAttack {
pub fn new(speed: f64, min: i32, max: i32, radius: f32, fire: Fire) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: speed,
    // rust: min,
    // rust: max,
    // rust: radius,
    // rust: fire,
    // rust: attack_time: -1,
    // rust: see_time: 0,
}
}
}
    // rust: impl Goal for RangedAttack {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE | LOOK
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
    // rust: self.can_use(m, cx) || m.target_info(cx.w).is_some_and(|t| t.alive) && !m.ai.nav.is_done()
}
pub fn stop(self: *Self, _: *mut Mob, _: *mut Cx) void {
}
    // rust: self.see_time = 0;
    // rust: self.attack_time = -1;
}
pub fn every_tick(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn tick(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: let Some(who) = m.ai.target else { return };
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let d2 = m.distance_sqr(t.position);
    // rust: let sees = m.sees(cx.w, who);
    // rust: if sees {
    // rust: self.see_time += 1;
    // rust: } else {
    // rust: self.see_time = 0;
}
    // rust: if d2 <= f64::from(self.radius * self.radius) && self.see_time >= 5 {
    // rust: m.nav_stop();
    // rust: } else {
    // rust: m.nav_move_to_entity(
    // rust: cx.w,
    // rust: [t.position.x, t.position.y, t.position.z],
    // rust: 1,
    // rust: self.speed,
    // rust: );
}
    // rust: m.look_at_speed([t.position.x, t.eye_y, t.position.z], 30.0, 30.0);
    // rust: self.attack_time -= 1;
    // rust: if self.attack_time == 0 {
    // rust: if !sees {
    // rust: return;
}
    // rust: let dist = (d2.sqrt() as f32) / self.radius;
    // rust: let power = dist.clamp(0.1, 1.0);
    // rust: (self.fire)(m, who, power, cx);
    // rust: self.attack_time =
    // rust: (dist * (self.max - self.min) as f32 + self.min as f32).floor() as i32;
    // rust: } else if self.attack_time < 0 {
    // rust: let f = d2.sqrt() / f64::from(self.radius);
    // rust: self.attack_time =
    // rust: (f64::from(self.min) + f * f64::from(self.max - self.min)).floor() as i32;
}
}
}
/// Witch.performRangedAttack: harming by default, slowness at range, poison
/// on healthy targets, weakness up close.
pub fn witch_attack(m: *mut Mob, who: Who, _power: f32, cx: *mut Cx) void {
}
    // isDrinkingPotion
    // rust: if m.extra.flag {
    // rust: return;
}
    // rust: let Some(t) = cx.w.target_info(who) else {
    // rust: return;
}
    // rust: let motion = match who {
    // rust: Who::Player => cx.w.player.as_ref().map_or(Vec3::ZERO, |p| p.velocity),
    // rust: Who::Mob(id) => cx.w.seen(id).map_or(Vec3::ZERO, |s| s.velocity),
}
    // rust: let xd = t.position.x + motion.x - m.position.x;
    // rust: let yd = t.eye_y - f64::from(1.1_f32) - m.position.y;
    // rust: let zd = t.position.z + motion.z - m.position.z;
    // rust: let dist = (xd * xd + zd * zd).sqrt();
    // rust: let health = if t.is_player {
    // rust: 20.0
    // rust: } else {
    // rust: cx.w.seen(match who {
    // rust: Who::Mob(id) => id,
    // rust: Who::Player => 0,
    // rust: })
    // rust: .map_or(20.0, |s| s.health)
}
    // A raider target is healed instead: Healing when nearly dead, else
    // Regeneration, and the witch drops the target afterwards.
    // rust: let heals = match who {
    // rust: Who::Mob(id) => {
    // rust: cx.w.seen(id)
    // rust: .is_some_and(|s| super::raider::is_raider(s.species))
}
    // rust: Who::Player => false,
}
    // `target.hasEffect`: a target that already has the effect gets the next one.
    // rust: let has = |effect: &str| match who {
    // rust: Who::Player => cx.w.player.as_ref().is_some_and(|p| p.has_effect(effect)),
    // rust: Who::Mob(id) => cx.w.seen(id).is_some_and(|s| s.has_effect(effect)),
}
    // The potion it throws: `PotionContents.createItemStack(Items.SPLASH_POTION,
    // potion)` for the one `Witch.performRangedAttack` picks.
    // rust: let potion = if heals {
    // rust: m.ai.target = None;
    // rust: if health <= 4.0 {
    // rust: "minecraft:healing"
    // rust: } else {
    // rust: "minecraft:regeneration"
}
    // rust: } else if dist >= 8.0 && !has("slowness") {
    // rust: "minecraft:slowness"
    // rust: } else if health >= 8.0 && !has("poison") {
    // rust: "minecraft:poison"
    // rust: } else if dist <= 3.0 && !has("weakness") && m.random.next_float() < 0.25 {
    // rust: "minecraft:weakness"
    // rust: } else {
    // rust: "minecraft:harming"
}
    // rust: let start = Vec3::new(m.position.x, m.eye_y() - 0.1, m.position.z);
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::potion(
    // rust: crate::items::ItemStack::new("minecraft:splash_potion", 1).with_potion(potion),
    // rust: ),
    // rust: start,
    // rust: Some(Who::Mob(m.id)),
    // rust: );
    // Splash potions throw with gravity 0.05.
    // rust: p.shoot(
    // rust: &mut crate::projectiles::own_random(m),
    // rust: [xd, yd + dist * 0.2, zd],
    // rust: if dist <= 2.0 { 0.45 } else { 0.75 },
    // rust: 8.0,
    // rust: );
    // rust: cx.events.push(MobEvent::Projectile(p));
    // Witch.performRangedAttack: the throw sound, and its pitch draw, only
    // when the witch is not silent.
    // rust: witch_sound(m, cx.events, "entity.witch.throw");
}
/// The movement speed of a witch with `SPEED_MODIFIER_DRINKING` (-0.25,
/// `ADD_VALUE`) while it drinks: it stands still for the 32 ticks.
pub fn speed(m: *Mob, base: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if m.species() == Species::Witch && m.extra.flag {
    // rust: (base - 0.25).max(0.0)
    // rust: } else {
    // rust: base
}
}
/// Witch.aiStep before `super.aiStep()`: the healing cooldown, then drink
/// water breathing, fire resistance, healing or swiftness.
pub fn ai_step(m: *mut Mob, cx_events: *mut std.ArrayList(MobEvent), target_far: bool) void {
}
    // rust: if !m.alive() {
    // rust: return;
}
    // healRaidersGoal.decrementCooldown (the attack goal's canAttack reads it).
    // rust: m.extra.counter2 -= 1;
    // rust: drink(m, cx_events, target_far);
    // `broadcastEntityEvent(this, 15)`: the magic puffs over its hat on every client.
    // rust: if m.random.next_float() < 7.5E-4 {
    // rust: cx_events.push(MobEvent::EntityEvent {
    // rust: mob: m.id,
    // rust: event: 15,
    // rust: at: [m.position.x, m.position.y, m.position.z],
    // rust: });
}
}
pub fn drink(m: *mut Mob, cx_events: *mut std.ArrayList(MobEvent), target_far: bool) void {
}
    // rust: if m.extra.flag {
        // `usingTime-- <= 0`
    // rust: m.extra.using_item -= 1;
    // rust: if m.extra.using_item < 0 {
    // rust: m.extra.using_item = 0;
    // rust: if let Some(potion) = m.extra.take_main_hand() {
    // rust: match potion.as_ref() {
    // rust: "minecraft:water_breathing" => {
    // rust: m.add_effect("minecraft:water_breathing", 3600, 0)
}
    // rust: "minecraft:fire_resistance" => {
    // rust: m.add_effect("minecraft:fire_resistance", 3600, 0)
}
    // rust: "minecraft:healing" => m.heal(4.0),
    // rust: "minecraft:swiftness" => m.add_effect("minecraft:speed", 3600, 0),
    // rust: _ => {}
}
}
    // rust: m.extra.flag = false;
}
    // rust: return;
}
    // rust: let potion = if m.random.next_float() < 0.15
    // rust: && m.fluids.eye_in_water
    // rust: && !m.has_effect("minecraft:water_breathing")
    // rust: {
    // rust: Some("minecraft:water_breathing")
    // rust: } else if m.random.next_float() < 0.15
    // rust: && (m.fire_ticks > 0 || m.last_damage.is_some_and(|(d, _)| d.is_fire()))
    // rust: && !m.has_effect("minecraft:fire_resistance")
    // rust: {
    // rust: Some("minecraft:fire_resistance")
    // rust: } else if m.random.next_float() < 0.05 && m.health < m.attrs.max_health {
    // rust: Some("minecraft:healing")
    // rust: } else if m.random.next_float() < 0.5
    // rust: && m.ai.target.is_some()
    // rust: && !m.has_effect("minecraft:speed")
    // rust: && target_far
    // rust: {
    // rust: Some("minecraft:swiftness")
    // rust: } else {
    // rust: None
}
    // rust: if let Some(p) = potion {
    // rust: m.extra.set_main_hand(Some(p.into()));
        // PotionItem use duration 32 ticks.
    // rust: m.extra.using_item = 32;
    // rust: m.extra.flag = true;
        // Witch.aiStep: the drink sound, and its pitch draw, only when the
        // witch is not silent.
    // rust: witch_sound(m, cx_events, "entity.witch.drink");
}
}
/// `Witch` drink and throw sounds: volume 1, pitch `0.8 + nextFloat * 0.4`,
/// skipped entirely (including the pitch draw) when `isSilent()`.
pub fn witch_sound(m: *mut Mob, events: *mut std.ArrayList(MobEvent), name: *'static str) void {
}
    // rust: if m.silent {
    // rust: return;
}
    // rust: let pitch = 0.8 + m.random.next_float() * 0.4;
    // rust: events.push(MobEvent::Sound(name, m.center(), 1.0, pitch));
}
/// `WitchRenderer.extractRenderState`'s `isHoldingPotion`: the main hand holds
/// a potion, either a drunk one (kept by the potion's name, `drink`) or a
/// plain potion item.
pub fn holds_potion(item: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: item,
    // rust: "minecraft:potion"
    // rust: | "minecraft:water_breathing"
    // rust: | "minecraft:fire_resistance"
    // rust: | "minecraft:healing"
    // rust: | "minecraft:swiftness"
    // rust: )
}
/// WitchModel.setupAnim (VillagerModel base with a wobbling nose).
pub fn anim(m: *Mob, s: *State, p: *mut Poses) void {
}
    // rust: p.yrot("head", s.y_rot.to_radians());
    // rust: p.xrot("head", s.x_rot.to_radians());
    // rust: p.xrot("right_leg", (s.pos * 0.6662).mcos() * 1.4 * s.speed * 0.5);
    // rust: p.xrot(
    // rust: "left_leg",
    // rust: (s.pos * 0.6662 + std::f32::consts::PI).mcos() * 1.4 * s.speed * 0.5,
    // rust: );
    // rust: let speed = 0.01 * (m.id % 10) as f32;
    // rust: let deg = horizon_core::geometry::trig::DEG_TO_RAD;
    // rust: p.xrot("nose", (s.age * speed).msin() * 4.5 * deg);
    // rust: p.zrot("nose", (s.age * speed).mcos() * 2.5 * deg);
    // rust: if m.extra.main_hand.is_some() {
    // rust: let n = p.get("nose");
    // rust: n[0] = 0.0;
    // rust: n[1] = 1.0;
    // rust: n[2] = -1.5;
    // rust: n[3] = -0.9;
}
    // rust: let _ = Species::Witch;
}

    // rust: mod tests {
//     use super::*;

    /// `Witch.registerGoals` passes `Raider.class` to `HurtByTargetGoal`, so a
    /// raider that hits a witch is not taken as its target. The list is the
    /// `Raider` class and nothing else: a vex is not a raider.
pub fn a_witch_ignores_the_raider_that_hit_it() void {
}
    // rust: let goal = hurt_by();
    // rust: assert_eq!(
    // rust: goal.ignore,
    // rust: vec![
    // rust: Species::Pillager,
    // rust: Species::Vindicator,
    // rust: Species::Evoker,
    // rust: Species::Illusioner,
    // rust: Species::Witch,
    // rust: Species::Ravager,
    // rust: ]
    // rust: );
    // rust: assert!(!goal.ignore.contains(&Species::Vex));
    // rust: assert!(!goal.ignore.contains(&Species::Zombie));
}

pub fn witch() M {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::sync::Arc;
    // rust: let mut kind = (*crate::mobs::sensor_scan_tests::kind()).clone();
    // rust: kind.id = "minecraft:witch".into();
    // rust: kind.species = Species::Witch;
    // rust: kind.max_health = 26.0;
    // rust: Mob::new(1, Arc::new(kind), Vec3::ZERO, 0.0)
}

    /// How many drink sounds forty attempts produce. Vanilla plays
    /// `entity.witch.drink` at volume 1, and skips it when the witch is silent.
pub fn drink_sounds(silent: bool) u {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_core::random::LegacyRandom;
    // rust: let mut m = witch();
    // rust: m.silent = silent;
    // rust: m.random = LegacyRandom::new(1);
    // rust: m.fluids.eye_in_water = true;
    // rust: m.fire_ticks = 20;
    // rust: m.health = 1.0;
    // rust: m.ai.target = Some(Who::Player);
    // rust: let mut events = Vec::new();
    // rust: for _ in 0..40 {
    // rust: m.extra.flag = false;
    // rust: drink(&mut m, &mut events, true);
}
    // rust: events
    // rust: .iter()
    // rust: .filter(|e| {
    // rust: matches!(e, MobEvent::Sound(s, _, volume, _) if *s == "entity.witch.drink" && *volume == 1.0)
    // rust: })
    // rust: .count()
}

    /// `Witch.aiStep` and `performRangedAttack` play at volume 1 only when
    /// the witch is not silent. The pitch draw stays inside that check.
pub fn a_silent_witch_does_not_play_its_drink_or_throw_sound() void {
}
//         use horizon_core::random::LegacyRandom;
    // rust: assert!(drink_sounds(false) > 0);
    // rust: assert_eq!(drink_sounds(true), 0);

    // rust: let mut loud = witch();
    // rust: loud.random = LegacyRandom::new(11);
    // rust: let mut quiet = witch();
    // rust: quiet.silent = true;
    // rust: quiet.random = LegacyRandom::new(11);
    // rust: let mut oracle = LegacyRandom::new(11);
        // Vanilla: 0.8F + nextFloat() * 0.4F, volume 1.
    // rust: let pitch = 0.8 + oracle.next_float() * 0.4;
    // rust: let mut events = Vec::new();
    // rust: witch_sound(&mut loud, &mut events, "entity.witch.throw");
    // rust: match &events[0] {
    // rust: MobEvent::Sound(name, _, volume, got) => {
    // rust: assert_eq!(*name, "entity.witch.throw");
    // rust: assert_eq!(*volume, 1.0);
    // rust: assert!((got - pitch).abs() < 1.0e-5);
}
    // rust: other => panic!("throw sound, got {other:?}"),
}
    // rust: events.clear();
    // rust: witch_sound(&mut quiet, &mut events, "entity.witch.throw");
    // rust: assert!(events.is_empty());
    // rust: let mut untouched = LegacyRandom::new(11);
    // rust: assert_eq!(quiet.random.next_float(), untouched.next_float());
}

    /// The hoisted list is exactly the set `is_raider` answers yes for.
pub fn the_raider_list_is_the_raider_class() void {
}
    // rust: for def in crate::mobs::species::ALL {
    // rust: assert_eq!(
    // rust: crate::mobs::raider::is_raider(def.species),
    // rust: super::super::raider::RAIDERS.contains(&def.species),
    // rust: "{:?}",
    // rust: def.species
    // rust: );
}
}
}
