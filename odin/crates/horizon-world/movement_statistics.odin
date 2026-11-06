//! Transpiled from Horizon Rust crate
package horizon_world_movement_statistics

import "core:fmt"
import "core:mem"
import "core:math"

// ServerPlayer.checkMovementStatistics. Called for accepted movement, separately
// from Entity.move/travel: the packet listener owns that boundary in vanilla.
// use horizon_core::geometry::Vec3;

MovementStat :: enum {
    Swim,
    WalkUnderWater,
    WalkOnWater,
    Climb,
    Sprint,
    Crouch,
    Walk,
    Aviate,
    Fly,
}
    // rust: impl MovementStat {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Swim => "swim_one_cm",
    // rust: Self::WalkUnderWater => "walk_under_water_one_cm",
    // rust: Self::WalkOnWater => "walk_on_water_one_cm",
    // rust: Self::Climb => "climb_one_cm",
    // rust: Self::Sprint => "sprint_one_cm",
    // rust: Self::Crouch => "crouch_one_cm",
    // rust: Self::Walk => "walk_one_cm",
    // rust: Self::Aviate => "aviate_one_cm",
    // rust: Self::Fly => "fly_one_cm",
}
}
}
    // rust: pub trait MovementStatisticsWorld {
    // rust: type Error;
passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
swimming :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
eyes_in_water :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
in_water :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
on_climbable :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
on_ground :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
sprinting :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
crouching :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
fall_flying :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
award :: proc(self: ^Self, stat: MovementStat, amount: i32) -> R {
    // Ported from Horizon
    return {}
}
exhaust :: proc(self: ^Self, amount: f32) -> R {
    // Ported from Horizon
    return {}
}
}
round_float :: proc(value: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let bits = value.to_bits() as i32;
    // rust: let shift = 149 - ((bits >> 23) & 0xff);
    // rust: if (0..32).contains(&shift) {
    // rust: let mut significand = (bits & 0x7f_ffff) | 0x80_0000;
    // rust: if bits < 0 {
    // rust: significand = -significand;
}
    // rust: ((significand >> shift) + 1) >> 1
    // rust: } else {
    // rust: value as i32
}
}
round_double :: proc(value: f64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let bits = value.to_bits() as i64;
    // rust: let shift = 1074 - ((bits >> 52) & 0x7ff);
    // rust: if (0..64).contains(&shift) {
    // rust: let mut significand = (bits & 0xf_ffff_ffff_ffff) | 0x10_0000_0000_0000;
    // rust: if bits < 0 {
    // rust: significand = -significand;
}
    // rust: ((significand >> shift) + 1) >> 1
    // rust: } else {
    // rust: value as i64
}
}
centimeters :: proc(squared: f64) -> i {
    // Ported from Horizon
    return {}
}
    // Java narrows the square root BEFORE multiplying by 100f and rounding.
    // rust: round_float(squared.sqrt() as f32 * 100.0)
}
    // rust: fn distance_with_exhaustion<W: MovementStatisticsWorld>(
    // rust: world: &mut W,
    // rust: stat: MovementStat,
    // rust: cm: i32,
    // rust: rate: f32,
    // rust: ) -> Result<(), W::Error> {
    // rust: if cm > 0 {
    // rust: world.award(stat, cm)?;
    // rust: world.exhaust(rate * cm as f32 * 0.01)?;
}
    // rust: Ok(())
}
    // rust: pub fn check<W: MovementStatisticsWorld>(world: &mut W, delta: Vec3) -> Result<(), W::Error> {
    // rust: if world.passenger()? || (delta.x == 0.0 && delta.y == 0.0 && delta.z == 0.0) {
    // rust: return Ok(());
}
    // rust: let distance_3d = || centimeters(delta.x * delta.x + delta.y * delta.y + delta.z * delta.z);
    // rust: let horizontal = || centimeters(delta.x * delta.x + delta.z * delta.z);
    // rust: if world.swimming()? {
    // rust: distance_with_exhaustion(world, MovementStat::Swim, distance_3d(), 0.01)
    // rust: } else if world.eyes_in_water()? {
    // rust: distance_with_exhaustion(world, MovementStat::WalkUnderWater, distance_3d(), 0.01)
    // rust: } else if world.in_water()? {
    // rust: distance_with_exhaustion(world, MovementStat::WalkOnWater, horizontal(), 0.01)
    // rust: } else if world.on_climbable()? {
    // rust: if delta.y > 0.0 {
            // The native double round returns long; l2i then wraps, not saturates.
    // rust: world.award(MovementStat::Climb, round_double(delta.y * 100.0) as i32)?;
}
    // rust: Ok(())
    // rust: } else if world.on_ground()? {
    // rust: let cm = horizontal();
    // rust: if cm > 0 {
    // rust: let (stat, rate) = if world.sprinting()? {
    // rust: (MovementStat::Sprint, 0.1)
    // rust: } else if world.crouching()? {
    // rust: (MovementStat::Crouch, 0.0)
    // rust: } else {
    // rust: (MovementStat::Walk, 0.0)
}
    // rust: distance_with_exhaustion(world, stat, cm, rate)?;
}
    // rust: Ok(())
    // rust: } else if world.fall_flying()? {
    // rust: world.award(MovementStat::Aviate, distance_3d())
    // rust: } else {
    // rust: let cm = horizontal();
    // rust: if cm > 25 {
    // rust: world.award(MovementStat::Fly, cm)?;
}
    // rust: Ok(())
}
}
