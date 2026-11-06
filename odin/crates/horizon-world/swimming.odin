//! Transpiled from Horizon Rust crate
package horizon_world_swimming

import "core:fmt"
import "core:mem"
import "core:math"

// Entity swimming state transitions and the player's flying-ability guard.
// use horizon_core::position::BlockPos;
    // rust: pub trait SwimmingWorld {
    // rust: type Error;
is_swimming :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_sprinting :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_in_water :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_under_water :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_passenger :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
was_eye_in_water :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // Direct blockPosition field, captured after preceding virtual queries.
block_position :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
water_at :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
set_swimming :: proc(self: ^Self, value: bool) -> R {
    // Ported from Horizon
    return {}
}
}
    // rust: pub trait PlayerSwimmingWorld: SwimmingWorld {
    // Direct abilities.flying field; do not dispatch getAbilities here.
flying_ability :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
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
fluid_jump_threshold :: proc(eye_height: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if f64::from(eye_height) < 0.4 {
    // rust: 0.0
    // rust: } else {
    // rust: 0.4
}
}
