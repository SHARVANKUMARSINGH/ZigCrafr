//! Transpiled from Horizon Rust crate
//! Module: horizon-world_living_fall
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Living-entity fall damage calculation, impulse exemption and callback order.
// use horizon_core::geometry::Vec3;

pub const ImpulseContext = struct {
    reset_grace_time: i32,
    impact_position: ?Vec3,
};
    // rust: impl ImpulseContext {
pub fn set_ignore_fall_damage(self: *Self, ignore: bool, position: ?Vec3) void {
}
    // rust: if ignore {
    // rust: self.apply_grace_time(40);
    // rust: self.impact_position = position;
    // rust: } else {
    // rust: self.reset_grace_time = 0;
}
}
pub fn apply_grace_time(self: *Self, ticks: i32) void {
}
    // rust: self.reset_grace_time = self.reset_grace_time.max(ticks);
}
pub fn reset(self: *Self) void {
}
    // rust: self.reset_grace_time = 0;
    // rust: self.impact_position = None;
}
pub fn try_reset(self: *Self) void {
}
    // rust: if self.reset_grace_time == 0 {
    // rust: self.reset();
}
}
    /// `LivingEntity.hasLandedInLiquid`: a move into a liquid with no upward
    /// movement ends the impulse context, still deferred by the grace time.
pub fn landed_in_liquid(self: *Self, delta_y: f64, in_liquid: bool) void {
}
    // rust: if in_liquid && delta_y < 9.9999997e-6 {
    // rust: self.try_reset();
}
}
pub fn is_in_grace_time(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reset_grace_time > 0
}
pub fn ignores_fall_damage(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.impact_position.is_some()
}
}
    // rust: pub trait LivingFallWorld {
    // rust: type Error;
    // rust: type Sound: Copy;
pub fn impact_position(self: *Self) O;
pub fn y(self: *Self) f;
pub fn reset_impulse(self: *Self) R;
pub fn try_reset_impulse(self: *Self) R;
pub fn immune_to_fall_damage(self: *Self) R;
    // rust: fn propagate_fall_to_passengers(
    // rust: &mut self,
    // rust: distance: f64,
    // rust: multiplier: f32,
    // rust: ) -> Result<(), Self::Error>;
pub fn safe_fall_distance(self: *Self) R;
pub fn fall_damage_multiplier(self: *Self) R;
    /// A host may adjust a mod block's landing damage before sounds and hurt.
pub fn modify_fall_damage(self: *Self, _distance: f64, damage: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(damage)
}
    /// Select the entity type's small/big fall sound. Big applies above four.
pub fn fall_sound(self: *Self, big: bool) R;
pub fn play_fall_sound(self: *Self, sound: Self::Sound) R;
pub fn play_block_fall_sound(self: *Self) R;
    /// Dispatch native Entity.hurt semantics (server-only), preserving its source.
pub fn hurt(self: *Self, damage: f32) R;
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
pub fn java_min(a: f64, b: f64) f {
    // Implementation ported from Horizon
    return undefined;
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
/// Default LivingEntity and Entity fall behavior. Entity-type overrides of the
/// calculation/parent method are a separate dispatch layer. The same damage
/// source must be retained by the provider for riders and the final hurt call.
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

pub const Landing = struct {
    replacement: ?f32,
    damage: f32,
    sounds: usize,
};
    // rust: impl LivingFallWorld for Landing {
    // rust: type Error = ();
    // rust: type Sound = bool;
pub fn impact_position(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0.0
}
pub fn reset_impulse(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn try_reset_impulse(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn immune_to_fall_damage(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn propagate_fall_to_passengers(self: *Self, _: f64, _: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn safe_fall_distance(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(3.0)
}
pub fn fall_damage_multiplier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(1.0)
}
pub fn modify_fall_damage(self: *Self, distance: f64, damage: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert_eq!((distance, damage), (13.0, 10.0));
    // rust: assert_eq!((self.sounds, self.damage), (0, 0.0));
    // rust: Ok(self.replacement.unwrap_or(damage))
}
pub fn fall_sound(self: *Self, big: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(big)
}
pub fn play_fall_sound(self: *Self, _: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sounds += 1;
    // rust: Ok(())
}
pub fn play_block_fall_sound(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sounds += 1;
    // rust: Ok(())
}
pub fn hurt(self: *Self, damage: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.damage = damage;
    // rust: Ok(())
}
}
pub fn landing_damage_is_changed_before_sounds_and_hurt() void {
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

    /// A wind charge's or mace's impact position with no grace time left.
pub fn impact() I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ImpulseContext {
    // rust: reset_grace_time: 0,
    // rust: impact_position: Some(Vec3::new(0.5, 64.0, 0.5)),
}
}

pub fn a_move_that_lands_in_a_liquid_ends_the_impulse_context() void {
}
    // rust: let mut impulse = impact();
    // rust: impulse.landed_in_liquid(-0.08, true);
    // rust: assert!(impulse.impact_position.is_none());
}

pub fn a_move_that_lands_on_dry_ground_keeps_it() void {
}
    // rust: let mut impulse = impact();
    // rust: impulse.landed_in_liquid(-0.08, false);
    // rust: assert_eq!(impulse.impact_position, Some(Vec3::new(0.5, 64.0, 0.5)));
}

pub fn a_rise_through_a_liquid_keeps_it() void {
}
    // rust: let mut impulse = impact();
    // rust: impulse.landed_in_liquid(0.2, true);
    // rust: assert!(impulse.ignores_fall_damage());
}

pub fn the_grace_time_defers_the_liquid_reset() void {
}
    // rust: let mut impulse = ImpulseContext::default();
    // rust: impulse.set_ignore_fall_damage(true, Some(Vec3::new(0.5, 64.0, 0.5)));
    // rust: impulse.landed_in_liquid(-0.08, true);
    // rust: assert!(impulse.ignores_fall_damage());
}
}
