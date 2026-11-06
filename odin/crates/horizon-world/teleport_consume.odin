//! Transpiled from Horizon Rust crate
package horizon_world_teleport_consume

import "core:fmt"
import "core:mem"
import "core:math"

// Random teleport consumable: candidate draws, bounds and success effects.
// use horizon_core::{geometry::Vec3, position::BlockPos, random::RandomSource};
TeleportConsume :: struct {
    diameter: f32,
    directional_particles: bool,
}
    // rust: impl PartialEq for TeleportConsume {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bits = |v: f32| if v.is_nan() { 0x7fc00000 } else { v.to_bits() };
    // rust: bits(self.diameter) == bits(other.diameter)
    // rust: && self.directional_particles == other.directional_particles
}
}
    // rust: pub trait TeleportConsumeWorld {
    // rust: type Error;
    // rust: type Level: Copy;
    // rust: type Random: Copy;
    // rust: type Source: RandomSource;
position_field :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
get_random :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
random_source :: proc(self: ^Self, random: Self::Random) -> ^ {
    // Ported from Horizon
    return {}
}
min_y :: proc(self: ^Self, level: Self::Level) -> R {
    // Ported from Horizon
    return {}
}
    // Native execution casts the supplied level to ServerLevel here.
logical_height :: proc(self: ^Self, level: Self::Level) -> R {
    // Ported from Horizon
    return {}
}
is_passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
stop_riding :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Horizon's mods (NeoForge's `EntityTeleportEvent.ChorusFruit`): before
    // each attempt, after the user stopped riding. They may move `target`;
    // false stops the effect without teleporting and without more draws.
teleport_allowed :: proc(self: ^Self, target: ^Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let _ = target;
    // rust: Ok(true)
}
    // showParticles=true and forbidden tag=CONSUMABLE_DOES_NOT_TELEPORT_TO.
random_teleport :: proc(self: ^Self, position: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // Level TELEPORT event, old position, context containing this actor.
teleport_event :: proc(self: ^Self, level: Self::Level, old_position: Vec3) {
}
    // rust: -> Result<(), Self::Error>;
is_fox :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // Fox sound/NEUTRAL when fox=true; chorus-fruit sound/PLAYERS otherwise.
    // Native excluded entity is null and default volume/pitch are one.
    // rust: fn teleport_sound(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: position: Vec3,
    // rust: fox: bool,
    // rust: ) -> Result<(), Self::Error>;
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Native level event 2017, at the origin, carrying the packed offset.
    // rust: fn directional_particles(
    // rust: &mut self,
    // rust: level: Self::Level,
    // rust: origin: BlockPos,
    // rust: offset: i32,
    // rust: ) -> Result<(), Self::Error>;
reset_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
reset_impulse :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}
clamp :: proc(v: f64, low: f64, high: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if v < low {
    // rust: low
    // rust: } else if v.is_nan() || high.is_nan() {
    // rust: f64::NAN
    // rust: } else if v == 0.0 && high == 0.0 {
    // rust: f64::from_bits(v.to_bits() | high.to_bits())
    // rust: } else {
    // rust: v.min(high)
}
}
packed_offset :: proc(a: BlockPos, b: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let axis = |a: i32, b: i32| b.wrapping_sub(a).clamp(-127, 127) + 127;
    // rust: (axis(a.x, b.x) << 16) | (axis(a.y, b.y) << 8) | axis(a.z, b.z)
}
    // rust: impl TeleportConsume {
    // rust: pub fn apply<W: TeleportConsumeWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: level: W::Level,
    // rust: ) -> Result<bool, W::Error> {
    // rust: for _ in 0..16 {
    // rust: let x = world.position_field().x;
    // rust: let r = world.get_random()?;
    // rust: let x = x + (world.random_source(r).next_double() - 0.5) * f64::from(self.diameter);
    // rust: let y = world.position_field().y;
    // rust: let r = world.get_random()?;
    // rust: let y = y + (world.random_source(r).next_double() - 0.5) * f64::from(self.diameter);
    // rust: let low = world.min_y(level)?;
    // rust: let min = world.min_y(level)?;
    // rust: let height = world.logical_height(level)?;
    // rust: let high = min.wrapping_add(height).wrapping_sub(1);
    // rust: let y = clamp(y, f64::from(low), f64::from(high));
    // rust: let z = world.position_field().z;
    // rust: let r = world.get_random()?;
    // rust: let z = z + (world.random_source(r).next_double() - 0.5) * f64::from(self.diameter);
    // rust: if world.is_passenger()? {
    // rust: world.stop_riding()?;
}
    // rust: let old = world.position()?;
    // rust: let mut target = Vec3::new(x, y, z);
    // rust: if !world.teleport_allowed(&mut target)? {
    // rust: return Ok(false);
}
    // rust: if world.random_teleport(target)? {
    // rust: world.teleport_event(level, old)?;
    // rust: let fox = world.is_fox();
    // rust: world.teleport_sound(level, world.position_field(), fox)?;
    // rust: if self.directional_particles {
    // rust: let origin = BlockPos::new(
    // rust: old.x.floor() as i32,
    // rust: old.y.floor() as i32,
    // rust: old.z.floor() as i32,
    // rust: );
    // rust: let destination = world.block_position()?;
    // rust: world.directional_particles(
    // rust: level,
    // rust: origin,
    // rust: packed_offset(origin, destination),
    // rust: )?;
}
    // rust: world.reset_fall_distance()?;
    // rust: world.reset_impulse()?;
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;
//     use std::convert::Infallible;

    // A user at the origin whose every landing fails unless `lands`; it
    // records the targets tried and how the mods answer.
Stub :: struct {
    random: LegacyRandom,
    allow: fn(^Vec3) -> bool,
    lands: bool,
    asked: uint,
    tried: [dynamic]Vec3,
}
    // rust: impl TeleportConsumeWorld for Stub {
    // rust: type Error = Infallible;
    // rust: type Level = ();
    // rust: type Random = ();
    // rust: type Source = LegacyRandom;
position_field :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec3::ZERO
}
get_random :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
random_source :: proc(self: ^Self) {
}
    // rust: &mut self.random
}
min_y :: proc(self: ^Self) {
}
    // rust: Ok(-64)
}
logical_height :: proc(self: ^Self) {
}
    // rust: Ok(384)
}
is_passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
stop_riding :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Vec3::ZERO)
}
teleport_allowed :: proc(self: ^Self, target: ^Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.asked += 1;
    // rust: Ok((self.allow)(target))
}
random_teleport :: proc(self: ^Self, position: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.tried.push(position);
    // rust: Ok(self.lands)
}
teleport_event :: proc(self: ^Self) {
}
    // rust: Ok(())
}
is_fox :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
teleport_sound :: proc(self: ^Self) {
}
    // rust: Ok(())
}
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(BlockPos::new(0, 0, 0))
}
directional_particles :: proc(self: ^Self) {
}
    // rust: Ok(())
}
reset_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
reset_impulse :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
}
stub :: proc(allow: fn(^Vec3) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Stub {
    // rust: random: LegacyRandom::new(7),
    // rust: allow,
    // rust: lands,
    // rust: asked: 0,
    // rust: tried: Vec::new(),
}
}
    // rust: const CHORUS: TeleportConsume = TeleportConsume {
    // rust: diameter: 16.0,
    // rust: directional_particles: false,
}

a_refused_attempt_ends_the_effect_without_teleporting :: proc() {
}
    // rust: let mut w = stub(|_| false, true);
    // rust: assert_eq!(CHORUS.apply(&mut w, ()), Ok(false));
    // rust: assert_eq!((w.asked, w.tried.len()), (1, 0), "asked once, never tried");
}

the_mods_target_is_where_the_user_tries_to_land :: proc() {
}
    // rust: let mut w = stub(
    // rust: |t| {
    // rust: *t = Vec3::new(100.5, 70.0, -3.5);
    // rust: true
    // rust: },
    // rust: true,
    // rust: );
    // rust: assert_eq!(CHORUS.apply(&mut w, ()), Ok(true));
    // rust: assert_eq!(w.tried, [Vec3::new(100.5, 70.0, -3.5)]);
}

without_mods_all_sixteen_attempts_stay_vanillas :: proc() {
}
    // rust: let mut w = stub(|_| true, false);
    // rust: assert_eq!(CHORUS.apply(&mut w, ()), Ok(false));
    // rust: assert_eq!((w.asked, w.tried.len()), (16, 16));
        // Each target is within half the diameter of the user.
    // rust: assert!(w.tried.iter().all(|t| t.x.abs() <= 8.0 && t.z.abs() <= 8.0));
}
}
