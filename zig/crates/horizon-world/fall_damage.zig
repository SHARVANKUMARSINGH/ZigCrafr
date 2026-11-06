//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fall_damage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Base Entity fall-distance accumulation and landing callback ordering.
// use horizon_core::{geometry::Vec3, position::BlockPos};

    // rust: pub trait FallDamageWorld {
    // rust: type Error;
    // rust: type State: Copy;
pub fn is_in_water(self: *Self) R;
pub fn fall_distance(self: *Self) f;
pub fn set_fall_distance(self: *Self, distance: f64) void;
    // rust: fn fall_on(
    // rust: &mut self,
    // rust: state: Self::State,
    // rust: position: BlockPos,
    // rust: distance: f64,
    // rust: ) -> Result<(), Self::Error>;
pub fn position(self: *Self) V;
pub fn supporting_block(self: *Self) O;
pub fn block_state(self: *Self, position: BlockPos) R;
pub fn hit_ground(self: *Self, position: Vec3, state: Self::State) R;
pub fn reset_fall_distance(self: *Self) R;
}
/// LivingEntity's fluid update, landing particles and other overrides wrap this
/// base method separately. Errors preserve prior field changes and callbacks.
    // rust: pub fn check_fall_damage<W: FallDamageWorld>(
    // rust: world: &mut W,
    // rust: dy: f64,
    // rust: on_ground: bool,
    // rust: state: W::State,
    // rust: position: BlockPos,
    // rust: ) -> Result<(), W::Error> {
    // rust: if !world.is_in_water()? && dy < 0.0 {
    // rust: world.set_fall_distance(world.fall_distance() - f64::from(dy as f32));
}
    // rust: if on_ground {
    // rust: if world.fall_distance() > 0.0 {
    // rust: world.fall_on(state, position, world.fall_distance())?;
            // Landing callbacks may move the entity or replace its support.
    // rust: let position = world.position();
    // rust: let state = if let Some(support) = world.supporting_block() {
    // rust: world.block_state(support)?
    // rust: } else {
    // rust: state
}
    // rust: world.hit_ground(position, state)?;
}
    // rust: world.reset_fall_distance()?;
}
    // rust: Ok(())
}
