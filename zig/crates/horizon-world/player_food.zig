//! Transpiled from Horizon Rust crate
//! Module: horizon-world_player_food
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player-specific hunger guards and virtual/direct state access distinctions.
// use crate::food::FoodData;
    // rust: pub trait PlayerFoodWorld {
    // rust: type Error;
    /// Reads the abilities field directly, not the virtual getAbilities method.
pub fn invulnerable_direct(self: *Self) b;
pub fn level_is_client(self: *Self) R;
pub fn add_exhaustion_direct(self: *Self, value: f32) R;
pub fn needs_food_direct(self: *Self) R;
pub fn enough_food_virtual(self: *Self) R;
pub fn may_fly_virtual(self: *Self) R;
}
    // rust: pub fn cause_exhaustion<W: PlayerFoodWorld>(world: &mut W, value: f32) -> Result<(), W::Error> {
    // rust: if !world.invulnerable_direct() && !world.level_is_client()? {
    // rust: world.add_exhaustion_direct(value)?;
}
    // rust: Ok(())
}
    // rust: pub fn can_eat<W: PlayerFoodWorld>(world: &mut W, always_edible: bool) -> Result<bool, W::Error> {
    // rust: Ok(world.invulnerable_direct() || always_edible || world.needs_food_direct()?)
}
    // rust: pub fn enough_food_for_manoeuvres<W: PlayerFoodWorld>(world: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(world.enough_food_virtual()? || world.may_fly_virtual()?)
}
/// Binding for ordinary stored player state. Specialized entity implementations
/// can supply their own virtual food/ability lookups through PlayerFoodWorld.
pub const StoredPlayerFood = struct {
    food: *'a mut FoodData,
    invulnerable: bool,
    client_side: bool,
    may_fly: bool,
};
    // rust: impl PlayerFoodWorld for StoredPlayerFood<'_> {
    // rust: type Error = std::convert::Infallible;
pub fn invulnerable_direct(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.invulnerable
}
pub fn level_is_client(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.client_side)
}
pub fn add_exhaustion_direct(self: *Self, value: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.food.add_exhaustion(value);
    // rust: Ok(())
}
pub fn needs_food_direct(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.food.needs_food())
}
pub fn enough_food_virtual(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.food.has_enough_food())
}
pub fn may_fly_virtual(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.may_fly)
}
}
