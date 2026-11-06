//! Transpiled from Horizon Rust crate
//! Module: horizon-world_living_fluid
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! LivingEntity water/lava travel and fluid escape/buoyancy velocity updates.
// use crate::living_air::{LivingAirWorld, move_relative};
// use horizon_core::geometry::Vec3;

pub const TravelFluidTag = enum {
    Lava,
    EntityFloatable,
};
    // rust: pub trait LivingFluidWorld: LivingAirWorld {
pub fn in_water(self: *Self) R;
pub fn sprinting(self: *Self) R;
pub fn water_slow_down(self: *Self) R;
pub fn water_movement_efficiency(self: *Self) R;
pub fn dolphins_grace(self: *Self) R;
pub fn fluid_height(self: *Self, tag: TravelFluidTag) R;
pub fn fluid_jump_threshold(self: *Self) R;
pub fn is_free(self: *Self, offset: Vec3) R;
pub fn is_vehicle(self: *Self) R;
pub fn can_float_while_ridden(self: *Self) R;
}

    // rust: pub fn fluid_falling_adjusted_movement<W: LivingFluidWorld>(
    // rust: world: &mut W,
    // rust: gravity: f64,
    // rust: falling: bool,
    // rust: mut velocity: Vec3,
    // rust: ) -> Result<Vec3, W::Error> {
    // rust: if gravity != 0.0 && !world.sprinting()? {
    // rust: velocity.y = if falling
    // rust: && (velocity.y - 0.005).abs() >= 0.003
    // rust: && (velocity.y - gravity / 16.0).abs() < 0.003
    // rust: {
    // rust: -0.003
    // rust: } else {
    // rust: velocity.y - gravity / 16.0
}
}
    // rust: Ok(velocity)
}
    // rust: pub fn jump_out_of_fluid<W: LivingFluidWorld>(world: &mut W, old_y: f64) -> Result<(), W::Error> {
    // rust: let mut velocity = world.velocity();
    // rust: if world.horizontal_collision() {
    // rust: let probe = Vec3::new(
    // rust: velocity.x,
    // rust: velocity.y + f64::from(0.6f32) - world.y() + old_y,
    // rust: velocity.z,
    // rust: );
    // rust: if world.is_free(probe)? {
    // rust: velocity.y = f64::from(0.3f32);
    // rust: world.set_velocity(velocity)?;
}
}
    // rust: Ok(())
}
    // rust: pub fn travel_in_water<W: LivingFluidWorld>(
    // rust: world: &mut W,
    // rust: input: Vec3,
    // rust: gravity: f64,
    // rust: falling: bool,
    // rust: old_y: f64,
    // rust: ) -> Result<(), W::Error> {
    // rust: let mut slowdown = if world.sprinting()? {
    // rust: 0.9f32
    // rust: } else {
    // rust: world.water_slow_down()?
}
    // rust: let mut speed = 0.02f32;
    // rust: let mut efficiency = world.water_movement_efficiency()? as f32;
    // rust: if !world.on_ground()? {
    // rust: efficiency *= 0.5;
}
    // rust: if efficiency > 0.0 {
    // rust: slowdown += (0.54600006f32 - slowdown) * efficiency;
    // rust: speed += (world.speed()? - speed) * efficiency;
}
    // rust: if world.dolphins_grace()? {
    // rust: slowdown = 0.96;
}
    // rust: move_relative(world, input, speed)?;
    // rust: world.move_self(world.velocity())?;
    // rust: let mut velocity = world.velocity();
    // rust: if world.horizontal_collision() && world.on_climbable()? {
    // rust: velocity.y = 0.2;
}
    // rust: velocity = Vec3::new(
    // rust: velocity.x * f64::from(slowdown),
    // rust: velocity.y * f64::from(0.8f32),
    // rust: velocity.z * f64::from(slowdown),
    // rust: );
    // rust: let velocity = fluid_falling_adjusted_movement(world, gravity, falling, velocity)?;
    // rust: world.set_velocity(velocity)?;
    // rust: jump_out_of_fluid(world, old_y)
}
    // rust: pub fn travel_in_lava<W: LivingFluidWorld>(
    // rust: world: &mut W,
    // rust: input: Vec3,
    // rust: gravity: f64,
    // rust: falling: bool,
    // rust: old_y: f64,
    // rust: ) -> Result<(), W::Error> {
    // rust: move_relative(world, input, 0.02)?;
    // rust: world.move_self(world.velocity())?;
    // rust: let height = world.fluid_height(TravelFluidTag::Lava)?;
    // rust: if height <= world.fluid_jump_threshold()? {
    // rust: let velocity = world.velocity();
    // rust: world.set_velocity(Vec3::new(
    // rust: velocity.x * 0.5,
    // rust: velocity.y * f64::from(0.8f32),
    // rust: velocity.z * 0.5,
    // rust: ))?;
    // rust: let velocity = fluid_falling_adjusted_movement(world, gravity, falling, world.velocity())?;
    // rust: world.set_velocity(velocity)?;
    // rust: } else {
    // rust: world.set_velocity(world.velocity().scale(0.5))?;
}
    // rust: if gravity != 0.0 {
    // rust: let velocity = world.velocity();
    // rust: world.set_velocity(Vec3::new(
    // rust: velocity.x + 0.0,
    // rust: velocity.y + -gravity / 4.0,
    // rust: velocity.z + 0.0,
    // rust: ))?;
}
    // rust: jump_out_of_fluid(world, old_y)
}
    // rust: pub fn float_in_liquid_while_ridden<W: LivingFluidWorld>(
    // rust: world: &mut W,
    // rust: tag: TravelFluidTag,
    // rust: ) -> Result<(), W::Error> {
    // rust: if world.is_vehicle()? && world.can_float_while_ridden()? {
    // rust: let threshold = world.fluid_jump_threshold()?;
    // rust: if world.fluid_height(tag)? > threshold {
    // rust: let velocity = world.velocity();
    // rust: world.set_velocity(Vec3::new(
    // rust: velocity.x + 0.0,
    // rust: velocity.y + f64::from(0.04f32),
    // rust: velocity.z + 0.0,
    // rust: ))?;
}
}
    // rust: Ok(())
}
    // rust: pub fn travel_in_fluid<W: LivingFluidWorld>(world: &mut W, input: Vec3) -> Result<(), W::Error> {
    // rust: let falling = world.velocity().y <= 0.0;
    // rust: let old_y = world.y();
    // rust: let gravity = world.effective_gravity()?;
    // rust: if world.in_water()? {
    // rust: travel_in_water(world, input, gravity, falling, old_y)?;
    // rust: } else {
    // rust: travel_in_lava(world, input, gravity, falling, old_y)?;
}
    // rust: float_in_liquid_while_ridden(world, TravelFluidTag::EntityFloatable)
}
