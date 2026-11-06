//! Transpiled from Horizon Rust crate
package horizon_world_living_landing

import "core:fmt"
import "core:mem"
import "core:math"

// LivingEntity's fluid refresh and landing effects around base fall handling.
// use crate::fall_damage::{FallDamageWorld, check_fall_damage};
// use horizon_core::{geometry::Vec3, position::BlockPos};

    // rust: pub trait LivingLandingWorld: FallDamageWorld {
update_fluid_interaction :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Native level type identity, independent of its client-side flag.
is_server_level :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
on_changed_block :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
safe_fall_distance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
state_is_air :: proc(self: ^Self, state: Self::State) -> R {
    // Ported from Horizon
    return {}
}
block_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Dispatch BLOCK particles with zero axis spread and the supplied speed.
    // rust: fn landing_particles(
    // rust: &mut self,
    // rust: state: Self::State,
    // rust: position: Vec3,
    // rust: count: i32,
    // rust: speed: f64,
    // rust: ) -> Result<(), Self::Error>;
clear_last_climbable_position :: proc(self: ^Self) {
}
}

// Preserve callbacks' field mutations and partial state on failure. The
// landing position and state are the original movement phase's arguments.
    // rust: pub fn check_living_fall_damage<W: LivingLandingWorld>(
    // rust: world: &mut W,
    // rust: dy: f64,
    // rust: on_ground: bool,
    // rust: state: W::State,
    // rust: landing: BlockPos,
    // rust: ) -> Result<(), W::Error> {
    // rust: if !world.is_in_water()? {
    // rust: world.update_fluid_interaction()?;
}
    // rust: if world.is_server_level() && on_ground && world.fall_distance() > 0.0 {
    // rust: world.on_changed_block(landing)?;
    // rust: let power = world.fall_distance() + 1.0e-6 - world.safe_fall_distance()?;
    // rust: let power = f64::from((power.floor() as i32).max(0));
    // rust: if power > 0.0 && !world.state_is_air(state)? {
    // rust: let mut position = world.position();
    // rust: let current = world.block_position()?;
    // rust: if landing.x != current.x || landing.z != current.z {
    // rust: let dx = position.x - f64::from(landing.x) - 0.5;
    // rust: let dz = position.z - f64::from(landing.z) - 0.5;
                // Math.max propagates NaN; Rust's max selects the other operand.
    // rust: let scale = if dx.is_nan() || dz.is_nan() {
    // rust: f64::NAN
    // rust: } else {
    // rust: dx.abs().max(dz.abs())
}
    // rust: position.x = f64::from(landing.x) + 0.5 + dx / scale * 0.5;
    // rust: position.z = f64::from(landing.z) + 0.5 + dz / scale * 0.5;
}
    // rust: let magnitude = (f64::from(0.2f32) + power / 15.0).min(2.5);
    // rust: world.landing_particles(
    // rust: state,
    // rust: position,
    // rust: (150.0 * magnitude) as i32,
    // rust: f64::from(0.15f32),
    // rust: )?;
}
}
    // rust: check_fall_damage(world, dy, on_ground, state, landing)?;
    // rust: if on_ground {
    // rust: world.clear_last_climbable_position();
}
    // rust: Ok(())
}
