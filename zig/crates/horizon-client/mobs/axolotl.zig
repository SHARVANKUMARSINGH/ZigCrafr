//! Transpiled from Horizon Rust crate
//! Module: horizon-client_axolotl
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Axolotl-specific damage, animation and prey rules; activities live in animal_brain.
// use super::{Mob, MobEvent, MobWorld, Species, Who, animal_brain, keyframes::AnimationState};
// use horizon_core::random::RandomSource;
pub const PLAY_DEAD_TICKS: i32 = 200;
pub const HUNTING_COOLDOWN: i64 = 2400;
/// `Axolotl.getMaxAirSupply`.
pub const MAX_AIR: i32 = 6000;

/// AxolotlAttackablesSensor: always-hostile targets bypass the hunting cooldown.
    // rust: pub fn prey_eligible(
    // rust: distance: f64,
    // rust: water: bool,
    // rust: hostile: bool,
    // rust: hunt: bool,
    // rust: cooldown: bool,
    // rust: attackable: bool,
    // rust: ) -> bool {
    // rust: distance <= 64.0 && water && (hostile || hunt && !cooldown) && attackable
}
/// Preserve the ordered random draws in Axolotl.hurtServer, even out of water.
    // rust: fn roll_play_dead(
    // rust: random: &mut impl RandomSource,
    // rust: no_ai: bool,
    // rust: health: f32,
    // rust: max: f32,
    // rust: damage: f32,
    // rust: water: bool,
    // rust: entity_source: bool,
    // rust: already: bool,
    // rust: ) -> bool {
    // rust: !no_ai
    // rust: && random.next_int_bound(3).unwrap_or(0) == 0
    // rust: && ((random.next_int_bound(3).unwrap_or(0) as f32) < damage || health / max < 0.5)
    // rust: && damage < health
    // rust: && water
    // rust: && entity_source
    // rust: && !already
}
pub fn before_damage(m: *mut Mob, damage: f32, source: *super::Damage) void {
}
    // rust: if m.species() != Species::Axolotl {
    // rust: return;
}
    // rust: let playing = m.extra.axolotl.playing_dead;
    // rust: if roll_play_dead(
    // rust: &mut m.random,
    // rust: m.no_ai,
    // rust: m.health,
    // rust: m.attrs.max_health,
    // rust: damage,
    // rust: m.fluids.in_water,
    // rust: source.attacker.is_some() || source.is_projectile(),
    // rust: playing,
    // rust: ) {
    // rust: animal_brain::set_play_dead(m);
}
}
pub fn is_playing_dead(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.species() == Species::Axolotl && m.extra.axolotl.playing_dead
}
/// Axolotl.onStopAttacking: help the player whose last damage killed the target.
pub fn on_stop_attacking(m: *Mob, w: *MobWorld, target: Who, events: *mut std.ArrayList(MobEvent)) void {
}
    // rust: if let Who::Mob(id) = target
    // rust: && let Some(s) = w.seen(id)
    // rust: && !s.alive
    // rust: && s.last_damage
    // rust: .is_some_and(|d| d.attacker == Some(Who::Player))
    // rust: && w.player.as_ref().is_some_and(|p| {
    // rust: m.bounds()
    // rust: .inflate(horizon_core::geometry::Vec3::new(20.0, 20.0, 20.0))
    // rust: .intersects(p.bounds)
    // rust: })
    // rust: {
    // rust: events.push(MobEvent::AxolotlSupportPlayer { mob: m.id });
}
}
/// BinaryAnimator(10, IN_OUT_SINE), plus the seven exclusive baby animation states.
pub const Animation = struct {
    playing_dead: bool,
    old: [u8,
    value: [u8,
    states: [AnimationState,
};
    // rust: impl Animation {
pub fn tick(self: *Self, baby: bool, water: bool, ground: bool, moving: bool, age: f32) void {
}
    // rust: self.old = self.value;
    // rust: let flags = [
    // rust: self.playing_dead,
    // rust: !self.playing_dead && water,
    // rust: !self.playing_dead && !water && ground,
    // rust: moving,
    // rust: ];
    // rust: for (v, on) in self.value.iter_mut().zip(flags) {
    // rust: *v = if on {
    // rust: (*v + 1).min(10)
    // rust: } else {
    // rust: v.saturating_sub(1)
}
}
    // rust: if baby {
    // rust: let selected = if self.playing_dead {
    // rust: 6
    // rust: } else if moving {
    // rust: if water && !ground {
    // rust: 1
    // rust: } else if !water && ground {
    // rust: 0
    // rust: } else {
    // rust: 2
}
    // rust: } else if water && !ground {
    // rust: 4
    // rust: } else if water && ground {
    // rust: 5
    // rust: } else {
    // rust: 3
}
    // rust: for (i, state) in self.states.iter_mut().enumerate() {
    // rust: if i == selected {
    // rust: state.start_if_stopped(age);
    // rust: } else {
    // rust: state.stop();
}
}
}
}
pub fn factor(self: *Self, i: usize, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = (f32::from(self.old[i])
    // rust: + (f32::from(self.value[i]) - f32::from(self.old[i])) * partial)
    // rust: / 10.0;
    // rust: ((1.0 - horizon_core::jmath::cos(f64::from(x) * std::f64::consts::PI)) / 2.0) as f32
}
}
pub fn tick_animation(m: *mut Mob) void {
}
    // rust: if m.species() != Species::Axolotl {
    // rust: return;
}
    // rust: let moving =
    // rust: m.limb_speed > 1.0e-5 || m.yaw != m.previous_yaw || m.head_pitch != m.previous_head_pitch;
    // rust: let baby = m.is_baby();
    // rust: m.extra
    // rust: .axolotl
    // rust: .tick(baby, m.fluids.in_water, m.on_ground, moving, m.age as f32);
}
    // rust: mod axolotl_parity_tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;
pub fn prey_water_range_and_cooldown_match_native() void {
}
    // rust: assert!(prey_eligible(64.0, true, false, true, false, true));
    // rust: assert!(!prey_eligible(64.01, true, false, true, false, true));
    // rust: assert!(!prey_eligible(4.0, false, true, true, false, true));
    // rust: assert!(!prey_eligible(4.0, true, false, true, true, true));
    // rust: assert!(prey_eligible(4.0, true, true, false, true, true));
    // rust: assert!(!prey_eligible(4.0, true, false, false, false, true));
    // rust: assert!(!prey_eligible(4.0, true, true, true, false, false));
}
pub fn damage_roll_matches_native_draw_order_and_gates() void {
}
    // rust: for seed in 0..100 {
    // rust: for (water, entity, already, no_ai) in [
    // rust: (true, true, false, false),
    // rust: (false, true, false, false),
    // rust: (true, false, false, false),
    // rust: (true, true, true, false),
    // rust: (true, true, false, true),
    // rust: ] {
    // rust: let mut expected = LegacyRandom::new(seed);
    // rust: let mut actual = LegacyRandom::new(seed);
    // rust: let result = !no_ai
    // rust: && expected.next_int_bound(3).unwrap() == 0
    // rust: && ((expected.next_int_bound(3).unwrap() as f32) < 2.0 || 4.0f32 / 14.0 < 0.5)
    // rust: && 2.0 < 4.0
    // rust: && water
    // rust: && entity
    // rust: && !already;
    // rust: assert_eq!(
    // rust: roll_play_dead(&mut actual, no_ai, 4.0, 14.0, 2.0, water, entity, already),
    // rust: result
    // rust: );
    // rust: assert_eq!(actual.next_int(), expected.next_int());
}
}
}
pub fn playing_dead_eases_and_selects_exclusive_baby_pose() void {
}
    // rust: let mut x = Animation {
    // rust: playing_dead: true,
    // rust: ..Animation::default()
}
    // rust: for _ in 0..10 {
    // rust: x.tick(true, true, true, true, 20.0);
}
    // rust: assert_eq!(x.factor(0, 1.0), 1.0);
    // rust: assert_eq!(x.factor(1, 1.0), 0.0);
    // rust: assert_eq!(x.states.iter().filter(|s| s.started.is_some()).count(), 1);
    // rust: assert!(x.states[6].started.is_some());
    // rust: x.playing_dead = false;
    // rust: for _ in 0..10 {
    // rust: x.tick(true, true, false, true, 30.0);
}
    // rust: assert_eq!(x.factor(0, 1.0), 0.0);
    // rust: assert_eq!(x.factor(1, 1.0), 1.0);
    // rust: assert!(x.states[1].started.is_some());
}
}
