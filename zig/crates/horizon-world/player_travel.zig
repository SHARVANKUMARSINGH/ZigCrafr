//! Transpiled from Horizon Rust crate
//! Module: horizon-world_player_travel
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player-specific swimming and ability-flight behavior around living travel.
// use horizon_core::{geometry::Vec3, position::BlockPos};
    // rust: pub trait PlayerTravelWorld {
    // rust: type Error;
pub fn is_passenger(self: *Self) R;
pub fn is_swimming(self: *Self) R;
pub fn look_angle(self: *Self) R;
pub fn jumping(self: *Self) b;
pub fn position(self: *Self) V;
pub fn fluid_is_empty(self: *Self, position: BlockPos) R;
pub fn velocity(self: *Self) V;
pub fn set_velocity(self: *Self, velocity: Vec3) R;
    /// Virtual getAbilities(), as distinct from direct abilities-field reads.
pub fn query_flying_ability(self: *Self) R;
pub fn flying_ability(self: *Self) b;
pub fn ability_flying_speed(self: *Self) R;
pub fn sprinting(self: *Self) R;
pub fn living_travel(self: *Self, input: Vec3) R;
}
    // rust: pub fn travel<W: PlayerTravelWorld>(world: &mut W, input: Vec3) -> Result<(), W::Error> {
    // rust: if world.is_passenger()? {
    // rust: return world.living_travel(input);
}
    // rust: if world.is_swimming()? {
    // rust: let look_y = world.look_angle()?.y;
    // rust: let scale = if look_y < -0.2 { 0.085 } else { 0.06 };
    // rust: let apply = if look_y <= 0.0 || world.jumping() {
    // rust: true
    // rust: } else {
    // rust: let p = world.position();
    // rust: !world.fluid_is_empty(BlockPos::new(
    // rust: p.x.floor() as i32,
    // rust: (p.y + 1.0 - 0.1).floor() as i32,
    // rust: p.z.floor() as i32,
    // rust: ))?
}
    // rust: if apply {
    // rust: let v = world.velocity();
    // rust: world.set_velocity(Vec3::new(
    // rust: v.x + 0.0,
    // rust: v.y + (look_y - v.y) * scale,
    // rust: v.z + 0.0,
    // rust: ))?;
}
}
    // rust: if world.query_flying_ability()? {
    // rust: let y = world.velocity().y;
    // rust: world.living_travel(input)?;
    // rust: let v = world.velocity();
    // rust: world.set_velocity(Vec3::new(v.x, y * 0.6, v.z))?;
    // rust: } else {
    // rust: world.living_travel(input)?;
}
    // rust: Ok(())
}
    // rust: pub fn flying_speed<W: PlayerTravelWorld>(world: &mut W) -> Result<f32, W::Error> {
    // rust: if world.flying_ability() && !world.is_passenger()? {
    // rust: let sprinting = world.sprinting()?;
    // rust: let speed = world.ability_flying_speed()?;
    // rust: Ok(if sprinting { speed * 2.0 } else { speed })
    // rust: } else {
    // rust: Ok(if world.sprinting()? {
    // rust: 0.025999999f32
    // rust: } else {
    // rust: 0.02
    // rust: })
}
}
    // rust: pub fn affected_by_fluids<W: PlayerTravelWorld>(world: &W) -> bool {
    // rust: !world.flying_ability()
}
