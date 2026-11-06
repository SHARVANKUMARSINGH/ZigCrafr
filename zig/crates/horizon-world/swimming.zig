//! Transpiled from Horizon Rust crate
//! Module: horizon-world_swimming
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity swimming state transitions and the player's flying-ability guard.
// use horizon_core::position::BlockPos;
    // rust: pub trait SwimmingWorld {
    // rust: type Error;
pub fn is_swimming(self: *Self) R;
pub fn is_sprinting(self: *Self) R;
pub fn is_in_water(self: *Self) R;
pub fn is_under_water(self: *Self) R;
pub fn is_passenger(self: *Self) R;
pub fn was_eye_in_water(self: *Self) b;
    /// Direct blockPosition field, captured after preceding virtual queries.
pub fn block_position(self: *Self) B;
pub fn water_at(self: *Self, position: BlockPos) R;
pub fn set_swimming(self: *Self, value: bool) R;
}
    // rust: pub trait PlayerSwimmingWorld: SwimmingWorld {
    /// Direct abilities.flying field; do not dispatch getAbilities here.
pub fn flying_ability(self: *Self) b;
}
    // rust: pub fn under_water<W: SwimmingWorld>(world: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(world.was_eye_in_water() && world.is_in_water()?)
}
    // rust: pub fn shallow_water<W: SwimmingWorld>(world: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(world.is_in_water()? && !world.is_under_water()?)
}
    // rust: pub fn update<W: SwimmingWorld>(world: &mut W) -> Result<(), W::Error> {
    // rust: let next = if world.is_swimming()? {
    // rust: world.is_sprinting()? && world.is_in_water()? && !world.is_passenger()?
    // rust: } else {
    // rust: world.is_sprinting()?
    // rust: && world.is_under_water()?
    // rust: && !world.is_passenger()?
    // rust: && world.water_at(world.block_position())?
}
    // rust: world.set_swimming(next)
}
    // rust: pub fn update_player<W: PlayerSwimmingWorld>(world: &mut W) -> Result<(), W::Error> {
    // rust: if world.flying_ability() {
    // rust: world.set_swimming(false)
    // rust: } else {
    // rust: update(world)
}
}
pub fn fluid_jump_threshold(eye_height: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if f64::from(eye_height) < 0.4 {
    // rust: 0.0
    // rust: } else {
    // rust: 0.4
}
}
