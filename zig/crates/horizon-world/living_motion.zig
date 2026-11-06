//! Transpiled from Horizon Rust crate
//! Module: horizon-world_living_motion
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Default living jump, gravity, flight-speed and air-drag calculations.
// use crate::living_air::modified_friction;
// use horizon_core::geometry::{Vec3, trig};

    // rust: pub trait LivingMotionWorld {
    // rust: type Error;
pub fn velocity(self: *Self) V;
pub fn set_velocity(self: *Self, velocity: Vec3) R;
pub fn jump_strength(self: *Self) R;
pub fn block_jump_factor(self: *Self) R;
pub fn has_jump_boost(self: *Self) R;
pub fn jump_boost_amplifier(self: *Self) R;
pub fn sprinting(self: *Self) R;
pub fn yaw(self: *Self) R;
pub fn mark_needs_sync(self: *Self) void;
pub fn no_gravity(self: *Self) R;
pub fn gravity_attribute(self: *Self) R;
pub fn has_slow_falling(self: *Self) R;
pub fn controlling_passenger_is_player(self: *Self) R;
pub fn speed(self: *Self) R;
pub fn omnidirectional_air_mover(self: *Self) R;
pub fn air_drag_modifier(self: *Self) R;
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
/// Native addDeltaMovement ignores nonfinite additions, but does not reject
/// a nonfinite existing velocity or overflow in the resulting sum.
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

pub const Jumper = struct {
    velocity: Vec3,
    sprinting: bool,
    yaw: f32,
    synced: bool,
};
    // rust: impl LivingMotionWorld for Jumper {
    // rust: type Error = ();
pub fn velocity(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.velocity
}
pub fn set_velocity(self: *Self, velocity: Vec3) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.velocity = velocity;
    // rust: Ok(())
}
pub fn jump_strength(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0.42)
}
pub fn block_jump_factor(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(1.0)
}
pub fn has_jump_boost(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn jump_boost_amplifier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0)
}
pub fn sprinting(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.sprinting)
}
pub fn yaw(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.yaw)
}
pub fn mark_needs_sync(self: *Self) void {
}
    // rust: self.synced = true;
}
pub fn no_gravity(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn gravity_attribute(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0.08)
}
pub fn has_slow_falling(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn controlling_passenger_is_player(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn speed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0.1)
}
pub fn omnidirectional_air_mover(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn air_drag_modifier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0.0)
}
}

pub fn impulse(yaw: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let angle = f64::from(yaw * trig::DEG_TO_RAD);
    // rust: (
    // rust: f64::from(-trig::sin(angle)) * 0.2,
    // rust: f64::from(trig::cos(angle)) * 0.2,
    // rust: )
}

    /// LivingEntity.jumpFromGround: a sprint adds ~0.2 along look; a walk does not.
pub fn sprint_jump_adds_look_direction_impulse() void {
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
