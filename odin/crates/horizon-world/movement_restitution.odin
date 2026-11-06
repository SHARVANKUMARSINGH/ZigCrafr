//! Transpiled from Horizon Rust crate
package horizon_world_movement_restitution

import "core:fmt"
import "core:mem"
import "core:math"

// Native post-collision restitution, including lazy bounce queries and effects.
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Vec3, position::BlockPos};

RestitutionInput :: struct {
    block: BlockStateId,
    collided_x: bool,
    collided_z: bool,
    vertical_collision: bool,
    collision_below: bool,
    living: bool,
    resolved_movement: Vec3,
    fall_distance: f64,
}
    // rust: pub trait RestitutionWorld {
    // rust: type Error;
suppressing_bounce :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
entity_bounciness :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
velocity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
effective_gravity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
block_suppresses_bounce :: proc(self: ^Self, block: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
block_bounce_restitution :: proc(self: ^Self, block: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
air_drag :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
movement_support_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn bounce_on(
    // rust: &mut self,
    // rust: block: BlockStateId,
    // rust: position: BlockPos,
    // rust: fall_distance: f64,
    // rust: ) -> Result<(), Self::Error>;
bounce_event :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // Native field write after bounce callbacks and before setting velocity.
mark_position_for_sync :: proc(self: ^Self) {
}
set_velocity :: proc(self: ^Self, velocity: Vec3) -> R {
    // Ported from Horizon
    return {}
}
}
java_max :: proc(a: f64, b: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if a.is_nan() {
    // rust: a
    // rust: } else if b.is_nan() {
    // rust: b
    // rust: } else if a == 0.0 && b == 0.0 {
    // rust: f64::from_bits(a.to_bits() & b.to_bits())
    // rust: } else {
    // rust: a.max(b)
}
}
// Provider errors preserve already performed effects; no rollback is attempted.
// Call only when Entity.move's simulation/collision guards request restitution.
    // rust: pub fn restitute_movement<W: RestitutionWorld>(
    // rust: world: &mut W,
    // rust: input: RestitutionInput,
    // rust: ) -> Result<(), W::Error> {
    // rust: let mut bounce = if world.suppressing_bounce()? {
    // rust: 0.0
    // rust: } else {
    // rust: world.entity_bounciness()?
}
    // rust: let old = world.velocity()?;
    // rust: let mut velocity = old;
    // rust: if input.collided_x {
    // rust: velocity.x = -old.x * bounce;
}
    // rust: if input.collided_z {
    // rust: velocity.z = -old.z * bounce;
}
    // rust: let mut emit = bounce > 0.0 && (input.collided_x || input.collided_z);
    // rust: if input.vertical_collision {
    // rust: if input.collision_below {
    // rust: if -old.y <= world.effective_gravity()?
    // rust: || world.suppressing_bounce()?
    // rust: || world.block_suppresses_bounce(input.block)?
    // rust: {
    // rust: bounce = 0.0;
    // rust: } else {
    // rust: let mut block = world.block_bounce_restitution(input.block)?;
    // rust: if !input.living {
    // rust: block *= 0.8f32;
}
    // rust: bounce = java_max(bounce, f64::from(block));
}
}
    // rust: let (gravity, drag) = if bounce > 0.0 {
    // rust: let fraction = input.resolved_movement.y / old.y;
    // rust: let gravity = fraction * world.effective_gravity()?;
    // rust: let drag = 1.0 + fraction * (f64::from(world.air_drag()?) - 1.0);
    // rust: emit = true;
    // rust: (gravity, drag)
    // rust: } else {
    // rust: (0.0, 1.0)
}
    // rust: velocity.y = (gravity - old.y) * drag * bounce;
}
    // rust: if emit {
    // rust: let position = world.movement_support_position()?;
    // rust: world.bounce_on(input.block, position, input.fall_distance)?;
    // rust: world.bounce_event()?;
    // rust: world.mark_position_for_sync();
}
    // rust: world.set_velocity(velocity)
}
