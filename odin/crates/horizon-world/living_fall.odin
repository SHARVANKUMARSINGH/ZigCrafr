//! Transpiled from Horizon Rust crate
package horizon_world_living_fall

import "core:fmt"
import "core:mem"
import "core:math"

// Living-entity fall damage calculation, impulse exemption and callback order.
// use horizon_core::geometry::Vec3;

ImpulseContext :: struct {
    reset_grace_time: i32,
    impact_position: Maybe(Vec3),
}
    // rust: impl ImpulseContext {
set_ignore_fall_damage :: proc(self: ^Self, ignore: bool, position: Maybe(Vec3)) {
}
    // rust: if ignore {
    // rust: self.apply_grace_time(40);
    // rust: self.impact_position = position;
    // rust: } else {
    // rust: self.reset_grace_time = 0;
}
}
apply_grace_time :: proc(self: ^Self, ticks: i32) {
}
    // rust: self.reset_grace_time = self.reset_grace_time.max(ticks);
}
reset :: proc(self: ^Self) {
}
    // rust: self.reset_grace_time = 0;
    // rust: self.impact_position = None;
}
try_reset :: proc(self: ^Self) {
}
    // rust: if self.reset_grace_time == 0 {
    // rust: self.reset();
}
}
    // `LivingEntity.hasLandedInLiquid`: a move into a liquid with no upward
    // movement ends the impulse context, still deferred by the grace time.
landed_in_liquid :: proc(self: ^Self, delta_y: f64, in_liquid: bool) {
}
    // rust: if in_liquid && delta_y < 9.9999997e-6 {
    // rust: self.try_reset();
}
}
is_in_grace_time :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.reset_grace_time > 0
}
ignores_fall_damage :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.impact_position.is_some()
}
}
    // rust: pub trait LivingFallWorld {
    // rust: type Error;
    // rust: type Sound: Copy;
impact_position :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
reset_impulse :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
try_reset_impulse :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
immune_to_fall_damage :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn propagate_fall_to_passengers(
    // rust: &mut self,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: ) -> Result<(), Self::Error>;
safe_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
fall_damage_multiplier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // A host may adjust a mod block's landing damage before sounds and hurt.
modify_fall_damage :: proc(self: ^Self, _distance: f64, damage: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(damage)
}
    // Select the entity type's small/big fall sound. Big applies above four.
fall_sound :: proc(self: ^Self, big: bool) -> R {
    // Ported from Horizon
    return {}
}
play_fall_sound :: proc(self: ^Self, sound: Self::Sound) -> R {
    // Ported from Horizon
    return {}
}
play_block_fall_sound :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Dispatch native Entity.hurt semantics (server-only), preserving its source.
hurt :: proc(self: ^Self, damage: f32) -> R {
    // Ported from Horizon
    return {}
}
}
    // rust: pub fn calculate_fall_damage<W: LivingFallWorld>(
    // rust: world: &mut W,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: ) -> Result<i32, W::Error> {
    // rust: if world.immune_to_fall_damage()? {
    // rust: return Ok(0);
}
    // rust: let power = distance + 1.0e-6 - world.safe_fall_distance()?;
    // rust: Ok((power * f64::from(multiplier) * world.fall_damage_multiplier()?).floor() as i32)
}
java_min :: proc(a: f64, b: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if b.is_nan() {
    // rust: b
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f64::from_bits(a.to_bits() | b.to_bits())
    // rust: } else {
    // rust: a.min(b)
}
}
// Default LivingEntity and Entity fall behavior. Entity-type overrides of the
// calculation/parent method are a separate dispatch layer. The same damage
// source must be retained by the provider for riders and the final hurt call.
    // rust: pub fn cause_living_fall_damage<W: LivingFallWorld>(
    // rust: world: &mut W,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: ) -> Result<bool, W::Error> {
    // rust: let distance = if let Some(impact) = world.impact_position() {
    // rust: let distance = java_min(distance, impact.y - world.y());
    // rust: if distance <= 0.0 {
    // rust: world.reset_impulse()?;
    // rust: } else {
    // rust: world.try_reset_impulse()?;
}
    // rust: distance
    // rust: } else {
    // rust: distance
}
    // Base Entity.causeFallDamage returns false, even after notifying riders.
    // rust: if !world.immune_to_fall_damage()? {
    // rust: world.propagate_fall_to_passengers(distance, multiplier)?;
}
    // rust: let damage = calculate_fall_damage(world, distance, multiplier)?;
    // rust: let damage = world.modify_fall_damage(distance, damage as f32)?;
    // rust: if damage > 0.0 {
    // rust: world.reset_impulse()?;
    // rust: let sound = world.fall_sound(damage > 4.0)?;
    // rust: world.play_fall_sound(sound)?;
    // rust: world.play_block_fall_sound()?;
    // rust: world.hurt(damage)?;
    // rust: Ok(true)
    // rust: } else {
    // rust: Ok(false)
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;

Landing :: struct {
    replacement: Maybe(f32),
    damage: f32,
    sounds: uint,
}
    // rust: impl LivingFallWorld for Landing {
    // rust: type Error = ();
    // rust: type Sound = bool;
impact_position :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.0
}
reset_impulse :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
try_reset_impulse :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
immune_to_fall_damage :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
propagate_fall_to_passengers :: proc(self: ^Self, _: f64, _: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
safe_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(3.0)
}
fall_damage_multiplier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(1.0)
}
modify_fall_damage :: proc(self: ^Self, distance: f64, damage: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: assert_eq!((distance, damage), (13.0, 10.0));
    // rust: assert_eq!((self.sounds, self.damage), (0, 0.0));
    // rust: Ok(self.replacement.unwrap_or(damage))
}
fall_sound :: proc(self: ^Self, big: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(big)
}
play_fall_sound :: proc(self: ^Self, _: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.sounds += 1;
    // rust: Ok(())
}
play_block_fall_sound :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.sounds += 1;
    // rust: Ok(())
}
hurt :: proc(self: ^Self, damage: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.damage = damage;
    // rust: Ok(())
}
}
landing_damage_is_changed_before_sounds_and_hurt :: proc() {
}
    // rust: for (replacement, expected) in [(None, 10.0), (Some(2.0), 2.0), (Some(0.0), 0.0)] {
    // rust: let mut w = Landing {
    // rust: replacement,
    // rust: damage: 0.0,
    // rust: sounds: 0,
}
    // rust: assert_eq!(
    // rust: cause_living_fall_damage(&mut w, 13.0, 1.0),
    // rust: Ok(expected > 0.0)
    // rust: );
    // rust: assert_eq!(w.damage, expected);
    // rust: assert_eq!(w.sounds, if expected > 0.0 { 2 } else { 0 });
}
}

    // A wind charge's or mace's impact position with no grace time left.
impact :: proc() -> I {
    // Ported from Horizon
    return {}
}
    // rust: ImpulseContext {
    // rust: reset_grace_time: 0,
    // rust: impact_position: Some(Vec3::new(0.5, 64.0, 0.5)),
}
}

a_move_that_lands_in_a_liquid_ends_the_impulse_context :: proc() {
}
    // rust: let mut impulse = impact();
    // rust: impulse.landed_in_liquid(-0.08, true);
    // rust: assert!(impulse.impact_position.is_none());
}

a_move_that_lands_on_dry_ground_keeps_it :: proc() {
}
    // rust: let mut impulse = impact();
    // rust: impulse.landed_in_liquid(-0.08, false);
    // rust: assert_eq!(impulse.impact_position, Some(Vec3::new(0.5, 64.0, 0.5)));
}

a_rise_through_a_liquid_keeps_it :: proc() {
}
    // rust: let mut impulse = impact();
    // rust: impulse.landed_in_liquid(0.2, true);
    // rust: assert!(impulse.ignores_fall_damage());
}

the_grace_time_defers_the_liquid_reset :: proc() {
}
    // rust: let mut impulse = ImpulseContext::default();
    // rust: impulse.set_ignore_fall_damage(true, Some(Vec3::new(0.5, 64.0, 0.5)));
    // rust: impulse.landed_in_liquid(-0.08, true);
    // rust: assert!(impulse.ignores_fall_damage());
}
}
