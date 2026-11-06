//! Transpiled from Horizon Rust crate
//! Module: horizon-client_polar_bear
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Polar bears (`PolarBear`): a neutral animal that defends its cubs,
//! fights back when hurt, and rears up before each swing. A cub flees what
//! hurts it and calls the adults.
//!
//! `extra.flag` is `DATA_STANDING_ID`, `extra.counter` the warning sound's
//! delay, `extra.anger` the `NeutralMob` anger left and `extra.flag2` whether
//! the player is who it is angry at. `anim.v[STAND]` is
//! `clientSideStandAnimation`.
// use horizon_core::{geometry::Vec3, random::RandomSource};

// use super::{
    // rust: DamageKind, Mob, MobWorld, Species, Who,
    // rust: goals::{
    // rust: Cx, Float, FollowParent, Goal, HurtByTarget, LookAtPlayer, MOVE, MeleeAttack,
    // rust: NearestTarget, Panic, RandomLookAround, Stroll, goal_clone,
    // rust: },
    // rust: world::TargetInfo,
}

/// `anim.v` slot of `clientSideStandAnimation`.
pub const STAND: usize = 0;
/// `STAND_ANIMATION_TICKS`.
pub const STAND_TICKS: f32 = 6.0;

pub fn register(m: *mut Mob) void {
}
    // rust: let g = &mut m.ai.goals;
    // rust: g.add(0, Float);
    // rust: g.add(1, MeleeAttack::new(1.25, true).polar_bear());
    // rust: g.add(1, PolarBearPanic(Panic::new(2.0)));
    // rust: g.add(4, FollowParent::new(1.25));
    // rust: g.add(5, Stroll::new(1.0));
    // rust: g.add(6, LookAtPlayer::new(6.0));
    // rust: g.add(7, RandomLookAround::default());
    // rust: let t = &mut m.ai.targets;
    // rust: t.add(1, HurtByTarget::new().polar_bear());
    // PolarBearAttackPlayersGoal: players near a cub, within half the
    // follow range, never for a cub itself.
    // rust: t.add(
    // rust: 2,
    // rust: NearestTarget::player(true)
    // rust: .interval(20)
    // rust: .follow_scale(0.5)
    // rust: .reach()
    // rust: .gate(|m, _| !m.is_baby())
    // rust: .when(cub_nearby)
    // rust: .named("PolarBearAttackPlayersGoal"),
    // rust: );
    // rust: t.add(
    // rust: 3,
    // rust: NearestTarget::player(true).when(|m, _| m.extra.anger > 0 && m.extra.flag2),
    // rust: );
    // rust: t.add(
    // rust: 4,
    // rust: NearestTarget::species(&[Species::Fox], true)
    // rust: .interval(10)
    // rust: .reach()
    // rust: .when(|m, _| !m.is_baby()),
    // rust: );
}

/// `PolarBearAttackPlayersGoal.canUse`: a polar bear cub within 8 blocks
/// (4 up and down).
pub fn cub_nearby(m: *Mob, w: *MobWorld) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let area = m.bounds().inflate(Vec3::new(8.0, 4.0, 8.0));
    // rust: w.others_near(area)
    // rust: .any(|s| s.species == Species::PolarBear && s.baby && s.bounds.intersects(area))
}

/// `PanicGoal` with a function of the bear's age for the damage tag: a cub
/// panics at `PANIC_CAUSES`, an adult only at `PANIC_ENVIRONMENTAL_CAUSES`.
pub const PolarBearPanic = struct {};
    // rust: impl Goal for PolarBearPanic {
    // rust: goal_clone!();
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (m.is_baby() || environmental_panic(m)) && self.0.can_use(m, cx)
}
pub fn can_continue(self: *Self, m: *mut Mob, cx: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.can_continue(m, cx)
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.start(m, cx)
}
pub fn stop(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: self.0.stop(m, cx)
}
}
/// `DamageTypeTags.PANIC_ENVIRONMENTAL_CAUSES` (fire, lava, cactus), or
/// burning.
pub fn environmental_panic(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.fire_ticks > 0 && !m.kind.flags.fire_immune
    // rust: || m.last_damage.is_some_and(|(d, t)| {
    // rust: matches!(
    // rust: d.kind,
    // rust: DamageKind::OnFire
    // rust: | DamageKind::InFire
    // rust: | DamageKind::Lava
    // rust: | DamageKind::Cactus
    // rust: | DamageKind::LightningBolt
    // rust: | DamageKind::HotFloor
    // rust: ) && i64::from(m.age) - t <= 40
    // rust: })
}

/// `PolarBear.setStanding`.
pub fn set_standing(m: *mut Mob, standing: bool) void {
}
    // rust: m.extra.flag = standing;
}

/// `PolarBear.playWarningSound`.
pub fn play_warning_sound(m: *mut Mob, cx: *mut Cx) void {
}
    // rust: if m.extra.counter <= 0 {
    // rust: m.voice("entity.polar_bear.warning", cx.events);
    // rust: m.extra.counter = 40;
}
}

/// `PolarBearMeleeAttackGoal.checkAndPerformAttack`: strike when ready and
/// in reach, rear up and growl in the last 10 ticks while close.
    // rust: pub fn check_and_perform_attack(
    // rust: until_attack: &mut i32,
    // rust: cooldown: i32,
    // rust: m: &mut Mob,
    // rust: who: Who,
    // rust: t: &TargetInfo,
    // rust: cx: &mut Cx,
    // rust: ) {
    // rust: if *until_attack <= 0 && m.within_melee_range(t) && m.sees(cx.w, who) {
    // rust: *until_attack = cooldown;
    // rust: super::ai::do_hurt_target(m, who, cx);
    // rust: set_standing(m, false);
    // rust: return;
}
    // rust: let reach = t.bounds.size().x as f32 + 3.0;
    // rust: if m.distance_sqr(t.position) < f64::from(reach * reach) {
    // rust: if *until_attack <= 0 {
    // rust: set_standing(m, false);
    // rust: *until_attack = cooldown;
}
    // rust: if *until_attack <= 10 {
    // rust: set_standing(m, true);
    // rust: play_warning_sound(m, cx);
}
    // rust: } else {
    // rust: *until_attack = cooldown;
    // rust: set_standing(m, false);
}
}

/// `PolarBear.tick`'s client half: `clientSideStandAnimation` follows the
/// synched standing flag by one tick a tick. A client of a server runs it
/// too.
pub fn client_tick(m: *mut Mob) void {
}
    // rust: let v = m.anim.v[STAND];
    // rust: m.anim.vo[STAND] = v;
    // rust: let step = if m.extra.flag { 1.0 } else { -1.0 };
    // rust: m.anim.v[STAND] = (v + step).clamp(0.0, STAND_TICKS);
}
/// `PolarBear.getStandingAnimationScale`.
pub fn standing_scale(m: *Mob, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.anim.lerp(STAND, partial) / STAND_TICKS
}
/// The height factor of `PolarBear.getDefaultDimensions`: `1 +
/// clientSideStandAnimation / 6` while the bear is rearing up, so a bear at
/// full height has a box twice as tall as its resting one.
pub fn stand_box_scale(m: *Mob) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let animation = m.anim.v[STAND];
    // rust: if animation > 0.0 {
    // rust: 1.0 + animation / STAND_TICKS
    // rust: } else {
    // rust: 1.0
}
}

/// `PolarBear.tick`: the stand animation, the warning sound's delay and
/// `NeutralMob.updatePersistentAnger`.
pub fn ai_step(m: *mut Mob, w: *MobWorld) void {
}
    // rust: client_tick(m);
    // rust: if m.extra.counter > 0 {
    // rust: m.extra.counter -= 1;
}
    // rust: if m.ai.target.is_some() {
        // Anger follows the target and starts over every tick it is held:
        // 20 to 39 seconds (`PERSISTENT_ANGER_TIME`).
    // rust: m.extra.flag2 = m.ai.target == Some(Who::Player);
    // rust: m.extra.anger = 400 + m.random.next_int_bound(381).unwrap_or(0);
    // rust: } else if m.extra.anger > 0 {
    // rust: m.extra.anger -= 1;
    // rust: if m.extra.anger == 0 {
    // rust: stop_being_angry(m);
}
}
    // A player in creative or spectator mode is forgiven at once.
    // rust: if m.extra.flag2 && w.player.as_ref().is_some_and(|p| p.creative || p.spectator) {
    // rust: stop_being_angry(m);
}
}
/// `NeutralMob.playerDied`: a bear angry at the player (its target, kept in
/// `flag2` until the anger ends) stops.
pub fn forgive_dead_player(m: *mut Mob) void {
}
    // rust: if m.extra.flag2 {
    // rust: stop_being_angry(m);
}
}
/// `NeutralMob.stopBeingAngry`.
pub fn stop_being_angry(m: *mut Mob) void {
}
    // rust: m.ai.last_hurt_by = None;
    // rust: m.ai.target = None;
    // rust: m.extra.anger = 0;
    // rust: m.extra.flag2 = false;
}

    // rust: mod tests {
//     use super::*;
//     use crate::mobs::sensor_scan_tests::kind;
//     use std::sync::Arc;

pub fn bear() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut kind = kind();
    // rust: Arc::make_mut(&mut kind).species = Species::PolarBear;
    // rust: Mob::new(1, kind, Vec3::ZERO, 0.0)
}

pub fn rear(m: *mut Mob) void {
}
    // rust: set_standing(m, true);
    // rust: client_tick(m);
}

    /// `PolarBear.getDefaultDimensions`: the box of a bear that is not rearing
    /// is the type's, one that is rearing is `scale(1, 1 + animation / 6)`.
pub fn a_rearing_bears_box_grows_taller_but_not_wider() void {
}
    // rust: let mut m = bear();
    // rust: let (w0, h0, e0) = m.dims();
    // rust: let (base_h, base_e) = (h0 as f32, e0 as f32);
    // rust: assert_eq!(stand_box_scale(&m), 1.0, "no rearing, no extra height");
        // Three ticks: half the animation, so half again as tall.
    // rust: for _ in 0..3 {
    // rust: rear(&mut m);
}
    // rust: let (w1, h1, e1) = m.dims();
    // rust: assert_eq!(w1, w0, "the width never changes");
    // rust: assert_eq!(h1, f64::from(base_h * 1.5_f32));
    // rust: assert_eq!(e1, f64::from(base_e * 1.5_f32));
        // Six ticks: the full animation, twice as tall.
    // rust: for _ in 0..3 {
    // rust: rear(&mut m);
}
    // rust: assert_eq!(m.anim.v[STAND], STAND_TICKS);
    // rust: let (w2, h2, e2) = m.dims();
    // rust: assert_eq!(w2, w0);
    // rust: assert_eq!(h2, f64::from(base_h * 2.0));
    // rust: assert_eq!(e2, f64::from(base_e * 2.0));
        // Standing down runs the animation back and the box with it.
    // rust: for _ in 0..STAND_TICKS as i32 {
    // rust: set_standing(&mut m, false);
    // rust: client_tick(&mut m);
}
    // rust: assert_eq!(m.dims(), (w0, h0, e0));
}

    /// The box follows the animation, not the synched standing flag: a bear
    /// that has just started to rear is still its resting height.
pub fn the_box_follows_the_animation_and_not_the_flag() void {
}
    // rust: let mut m = bear();
    // rust: let (_, h0, _) = m.dims();
    // rust: let base_h = h0 as f32;
    // rust: set_standing(&mut m, true);
    // rust: assert_eq!(m.dims().1, h0, "the flag alone does not grow the box");
    // rust: client_tick(&mut m);
    // rust: assert_eq!(m.dims().1, f64::from(base_h * (1.0 + 1.0 / STAND_TICKS)));
}
}
