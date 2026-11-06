//! Transpiled from Horizon Rust crate
package horizon_world_living_motion

import "core:fmt"
import "core:mem"
import "core:math"

// Default living jump, gravity, flight-speed and air-drag calculations.
// use crate::living_air::modified_friction;
// use horizon_core::geometry::{Vec3, trig};

    // rust: pub trait LivingMotionWorld {
    // rust: type Error;
velocity :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
set_velocity :: proc(self: ^Self, velocity: Vec3) -> R {
    // Ported from Horizon
    return {}
}
jump_strength :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
block_jump_factor :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
has_jump_boost :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
jump_boost_amplifier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
sprinting :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
yaw :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
mark_needs_sync :: proc(self: ^Self) {
}
no_gravity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
gravity_attribute :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
has_slow_falling :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
controlling_passenger_is_player :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
speed :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
omnidirectional_air_mover :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
air_drag_modifier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}
    // rust: pub fn jump_boost_power<W: LivingMotionWorld>(world: &mut W) -> Result<f32, W::Error> {
    // rust: Ok(if world.has_jump_boost()? {
    // rust: 0.1f32 * (world.jump_boost_amplifier()? as f32 + 1.0)
    // rust: } else {
    // rust: 0.0
    // rust: })
}
    // rust: pub fn jump_power<W: LivingMotionWorld>(world: &mut W, scale: f32) -> Result<f32, W::Error> {
    // rust: let strength = world.jump_strength()? as f32 * scale;
    // rust: let strength = strength * world.block_jump_factor()?;
    // rust: Ok(strength + jump_boost_power(world)?)
}
// Native addDeltaMovement ignores nonfinite additions, but does not reject
// a nonfinite existing velocity or overflow in the resulting sum.
    // rust: pub fn add_delta_movement<W: LivingMotionWorld>(
    // rust: world: &mut W,
    // rust: delta: Vec3,
    // rust: ) -> Result<(), W::Error> {
    // rust: if delta.x.is_finite() && delta.y.is_finite() && delta.z.is_finite() {
    // rust: let old = world.velocity();
    // rust: world.set_velocity(Vec3::new(old.x + delta.x, old.y + delta.y, old.z + delta.z))?;
}
    // rust: Ok(())
}
    // rust: pub fn jump_from_ground<W: LivingMotionWorld>(world: &mut W) -> Result<(), W::Error> {
    // rust: let power = jump_power(world, 1.0)?;
    // rust: if power <= 1.0e-5f32 {
    // rust: return Ok(());
}
    // rust: let mut velocity = world.velocity();
    // rust: velocity.y = if power.is_nan() || velocity.y.is_nan() {
    // rust: f64::NAN
    // rust: } else {
    // rust: f64::from(power).max(velocity.y)
}
    // rust: world.set_velocity(velocity)?;
    // rust: if world.sprinting()? {
    // rust: let angle = f64::from(world.yaw()? * trig::DEG_TO_RAD);
    // rust: add_delta_movement(
    // rust: world,
    // rust: Vec3::new(
    // rust: f64::from(-trig::sin(angle)) * 0.2,
    // rust: 0.0,
    // rust: f64::from(trig::cos(angle)) * 0.2,
    // rust: ),
    // rust: )?;
}
    // rust: world.mark_needs_sync();
    // rust: Ok(())
}
    // rust: pub fn gravity<W: LivingMotionWorld>(world: &mut W) -> Result<f64, W::Error> {
    // rust: if world.no_gravity()? {
    // rust: Ok(0.0)
    // rust: } else {
    // rust: world.gravity_attribute()
}
}
    // rust: pub fn effective_gravity<W: LivingMotionWorld>(world: &mut W) -> Result<f64, W::Error> {
    // rust: if world.velocity().y <= 0.0 && world.has_slow_falling()? {
    // rust: let gravity = gravity(world)?;
    // rust: Ok(if gravity.is_nan() {
    // rust: gravity
    // rust: } else {
    // rust: gravity.min(0.01)
    // rust: })
    // rust: } else {
    // rust: gravity(world)
}
}
    // rust: pub fn apply_gravity<W: LivingMotionWorld>(world: &mut W) -> Result<(), W::Error> {
    // rust: let gravity = gravity(world)?;
    // rust: if gravity != 0.0 {
    // rust: let old = world.velocity();
    // rust: world.set_velocity(Vec3::new(old.x + 0.0, old.y - gravity, old.z + 0.0))?;
}
    // rust: Ok(())
}
    // rust: pub fn swim_vertical<W: LivingMotionWorld>(world: &mut W, up: bool) -> Result<(), W::Error> {
    // rust: let old = world.velocity();
    // rust: let amount = f64::from(0.04f32);
    // rust: world.set_velocity(Vec3::new(
    // rust: old.x + 0.0,
    // rust: old.y + if up { amount } else { -amount },
    // rust: old.z + 0.0,
    // rust: ))
}
    // rust: pub fn default_flying_speed<W: LivingMotionWorld>(world: &mut W) -> Result<f32, W::Error> {
    // rust: if world.controlling_passenger_is_player()? {
    // rust: Ok(world.speed()? * 0.1f32)
    // rust: } else {
    // rust: Ok(0.02)
}
}
    // rust: pub fn air_drag<W: LivingMotionWorld>(world: &mut W) -> Result<f32, W::Error> {
    // rust: let drag = if world.omnidirectional_air_mover()? {
    // rust: 0.91
    // rust: } else {
    // rust: 0.98
}
    // rust: Ok(modified_friction(drag, world.air_drag_modifier()? as f32))
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::{Vec3, trig};

Jumper :: struct {
    velocity: Vec3,
    sprinting: bool,
    yaw: f32,
    synced: bool,
}
    // rust: impl LivingMotionWorld for Jumper {
    // rust: type Error = ();
velocity :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.velocity
}
set_velocity :: proc(self: ^Self, velocity: Vec3) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.velocity = velocity;
    // rust: Ok(())
}
jump_strength :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(0.42)
}
block_jump_factor :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(1.0)
}
has_jump_boost :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
jump_boost_amplifier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(0)
}
sprinting :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.sprinting)
}
yaw :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.yaw)
}
mark_needs_sync :: proc(self: ^Self) {
}
    // rust: self.synced = true;
}
no_gravity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
gravity_attribute :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(0.08)
}
has_slow_falling :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
controlling_passenger_is_player :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
speed :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(0.1)
}
omnidirectional_air_mover :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(false)
}
air_drag_modifier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(0.0)
}
}

impulse :: proc(yaw: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let angle = f64::from(yaw * trig::DEG_TO_RAD);
    // rust: (
    // rust: f64::from(-trig::sin(angle)) * 0.2,
    // rust: f64::from(trig::cos(angle)) * 0.2,
    // rust: )
}

    // LivingEntity.jumpFromGround: a sprint adds ~0.2 along look; a walk does not.
sprint_jump_adds_look_direction_impulse :: proc() {
}
    // rust: for yaw in [0.0, 45.0, 90.0, 180.0, 270.0, 300.0] {
    // rust: let before = Vec3::new(0.13, -0.08, -0.05);
    // rust: let mut sprinting = Jumper {
    // rust: velocity: before,
    // rust: sprinting: true,
    // rust: yaw,
    // rust: synced: false,
}
    // rust: jump_from_ground(&mut sprinting).unwrap();
    // rust: let (dx, dz) = impulse(yaw);
    // rust: let horizontal = ((dx * dx) + (dz * dz)).sqrt();
    // rust: assert!(
    // rust: (horizontal - 0.2).abs() < 1.0e-4,
    // rust: "yaw {yaw}: impulse length {horizontal}"
    // rust: );
    // rust: assert!(
    // rust: (sprinting.velocity.x - (before.x + dx)).abs() < 1.0e-9,
    // rust: "yaw {yaw}: x {:?} expected {}",
    // rust: sprinting.velocity,
    // rust: before.x + dx
    // rust: );
    // rust: assert!((sprinting.velocity.z - (before.z + dz)).abs() < 1.0e-9);
            // jump_power narrows the 0.42 strength through float, as vanilla does.
    // rust: let jump_y = f64::from(0.42_f32);
    // rust: assert!((sprinting.velocity.y - jump_y).abs() < 1.0e-9);
    // rust: assert!(sprinting.synced);

    // rust: let mut walking = Jumper {
    // rust: velocity: before,
    // rust: sprinting: false,
    // rust: yaw,
    // rust: synced: false,
}
    // rust: jump_from_ground(&mut walking).unwrap();
    // rust: assert_eq!(walking.velocity.x, before.x);
    // rust: assert_eq!(walking.velocity.z, before.z);
    // rust: assert!((walking.velocity.y - jump_y).abs() < 1.0e-9);
}
}
}
