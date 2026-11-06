//! Transpiled from Horizon Rust crate
package horizon_world_player_food

import "core:fmt"
import "core:mem"
import "core:math"

// Player-specific hunger guards and virtual/direct state access distinctions.
// use crate::food::FoodData;
    // rust: pub trait PlayerFoodWorld {
    // rust: type Error;
    // Reads the abilities field directly, not the virtual getAbilities method.
invulnerable_direct :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
level_is_client :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
add_exhaustion_direct :: proc(self: ^Self, value: f32) -> R {
    // Ported from Horizon
    return {}
}
needs_food_direct :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
enough_food_virtual :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
may_fly_virtual :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
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
// Binding for ordinary stored player state. Specialized entity implementations
// can supply their own virtual food/ability lookups through PlayerFoodWorld.
StoredPlayerFood :: struct {
    food: ^'a mut FoodData,
    invulnerable: bool,
    client_side: bool,
    may_fly: bool,
}
    // rust: impl PlayerFoodWorld for StoredPlayerFood<'_> {
    // rust: type Error = std::convert::Infallible;
invulnerable_direct :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.invulnerable
}
level_is_client :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.client_side)
}
add_exhaustion_direct :: proc(self: ^Self, value: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.food.add_exhaustion(value);
    // rust: Ok(())
}
needs_food_direct :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.food.needs_food())
}
enough_food_virtual :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.food.has_enough_food())
}
may_fly_virtual :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.may_fly)
}
}
