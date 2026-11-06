//! Transpiled from Horizon Rust crate
package horizon_world_free_space

import "core:fmt"
import "core:mem"
import "core:math"

// Entity.isFree: offset collision clearance followed by resident liquid checks.
// use crate::{
    // rust: block_collision_scan::{BlockCollisionWorld, CollisionScanError},
    // rust: fluid_occupancy::{
    // rust: FluidOccupancyError, FluidOccupancyWorld, FluidPresence, contains_any_liquid,
    // rust: },
    // rust: world_movement::{CollisionCheckRequest, EntityMovementWorld, no_world_collision},
}
// use horizon_core::geometry::Vec3;
// use std::fmt;
FreeSpaceError :: enum {
    Collision(CollisionScanError<E>),
    Fluid(FluidOccupancyError<E>),
}
    // rust: impl<E: fmt::Display> fmt::Display for FreeSpaceError<E> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Collision(e) => e.fmt(f),
    // rust: Self::Fluid(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for FreeSpaceError<E> {}
    // rust: pub fn offset_is_free<W, E>(
    // rust: world: &mut W,
    // rust: fluids: &FluidPresence<'_>,
    // rust: mut request: CollisionCheckRequest<'_>,
    // rust: offset: Vec3,
    // rust: fluid_budget: usize,
    // rust: ) -> Result<bool, FreeSpaceError<E>>
    // rust: where
    // rust: W: BlockCollisionWorld<Error = E>
    // rust: + EntityMovementWorld<Error = E>
    // rust: + FluidOccupancyWorld<Error = E>,
    // rust: {
    // rust: request.bounds = request.bounds.move_by(offset);
    // rust: let bounds = request.bounds;
    // rust: if !no_world_collision(world, request).map_err(FreeSpaceError::Collision)? {
    // rust: return Ok(false);
}
    // rust: Ok(!contains_any_liquid(world, fluids, bounds, fluid_budget).map_err(FreeSpaceError::Fluid)?)
}
