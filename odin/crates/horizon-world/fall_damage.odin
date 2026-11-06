//! Transpiled from Horizon Rust crate
package horizon_world_fall_damage

import "core:fmt"
import "core:mem"
import "core:math"

// Base Entity fall-distance accumulation and landing callback ordering.
// use horizon_core::{geometry::Vec3, position::BlockPos};

    // rust: pub trait FallDamageWorld {
    // rust: type Error;
    // rust: type State: Copy;
is_in_water :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
fall_distance :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
set_fall_distance :: proc(self: ^Self, distance: f64) {
}
    // rust: fn fall_on(
    // rust: &mut self,
    // rust: state: Self::State,
    // rust: position: BlockPos,
    // rust: distance: f64,
    // rust: ) -> Result<(), Self::Error>;
position :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
supporting_block :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
block_state :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
hit_ground :: proc(self: ^Self, position: Vec3, state: Self::State) -> R {
    // Ported from Horizon
    return {}
}
reset_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}
// LivingEntity's fluid update, landing particles and other overrides wrap this
// base method separately. Errors preserve prior field changes and callbacks.
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
