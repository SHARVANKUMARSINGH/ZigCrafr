//! Transpiled from Horizon Rust crate
//! Module: horizon-world_edge_backoff
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player crouching edge backoff and its lazy collision-free probes.
// use horizon_core::geometry::{Aabb, Vec3};

    // rust: pub trait EdgeBackoffWorld {
    // rust: type Error;
pub fn max_up_step(self: *Self) R;
pub fn staying_on_ground_surface(self: *Self) R;
pub fn on_ground(self: *Self) R;
pub fn no_collision(self: *Self, bounds: Aabb) R;
}
pub const EdgeBackoffInput = struct {
    movement: Vec3,
    bounds: Aabb,
    flying: bool,
    /// True only for native SELF and PLAYER mover types.
    self_or_player: bool,
    fall_distance: f64,
    query_budget: usize,
};
pub const EdgeBackoffError = enum {
    World(E),
    QueryBudget,
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for EdgeBackoffError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::QueryBudget => f.write_str("edge backoff collision query budget exhausted"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for EdgeBackoffError<E> {}
pub fn signum(v: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v == 0.0 || v.is_nan() {
    // rust: v
    // rust: } else {
    // rust: v.signum()
}
}
pub fn decrease(v: f64, step: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if v.abs() <= 0.05 { 0.0 } else { v - step }
}
/// The budget bounds pathological/nonconverging motion. Exhaustion is an error,
/// never a successful clamped displacement; earlier provider effects remain.
    // rust: pub fn back_off_from_edge<W: EdgeBackoffWorld>(
    // rust: world: &mut W,
    // rust: input: EdgeBackoffInput,
    // rust: ) -> Result<Vec3, EdgeBackoffError<W::Error>> {
    // rust: let step = f64::from(world.max_up_step().map_err(EdgeBackoffError::World)?);
    // rust: if input.flying
    // rust: || input.movement.y > 0.0
    // rust: || !input.self_or_player
    // rust: || !world
    // rust: .staying_on_ground_surface()
    // rust: .map_err(EdgeBackoffError::World)?
    // rust: {
    // rust: return Ok(input.movement);
}
    // rust: let grounded = world.on_ground().map_err(EdgeBackoffError::World)?;
    // rust: let mut queries = 0usize;
    // rust: let mut can_fall =
    // rust: |dx: f64, dz: f64, amount: f64| -> Result<bool, EdgeBackoffError<W::Error>> {
    // rust: if queries == input.query_budget {
    // rust: return Err(EdgeBackoffError::QueryBudget);
}
    // rust: queries += 1;
    // rust: let min = input.bounds.min_position();
    // rust: let max = input.bounds.max_position();
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(
    // rust: min.x + 1.0e-7 + dx,
    // rust: min.y - amount - 1.0e-7,
    // rust: min.z + 1.0e-7 + dz,
    // rust: ),
    // rust: Vec3::new(max.x - 1.0e-7 + dx, min.y, max.z - 1.0e-7 + dz),
    // rust: );
    // rust: world.no_collision(bounds).map_err(EdgeBackoffError::World)
}
    // rust: let should_back_off = grounded
    // rust: || (input.fall_distance < step && !can_fall(0.0, 0.0, step - input.fall_distance)?);
    // rust: if !should_back_off {
    // rust: return Ok(input.movement);
}
    // rust: let mut x = input.movement.x;
    // rust: let mut z = input.movement.z;
    // rust: let dx = signum(x) * 0.05;
    // rust: let dz = signum(z) * 0.05;
    // rust: while x != 0.0 && can_fall(x, 0.0, step)? {
    // rust: if x.abs() <= 0.05 {
    // rust: x = 0.0;
    // rust: break;
}
    // rust: x -= dx;
}
    // rust: while z != 0.0 && can_fall(0.0, z, step)? {
    // rust: if z.abs() <= 0.05 {
    // rust: z = 0.0;
    // rust: break;
}
    // rust: z -= dz;
}
    // rust: while x != 0.0 && z != 0.0 && can_fall(x, z, step)? {
    // rust: x = decrease(x, dx);
    // rust: z = decrease(z, dz);
}
    // rust: Ok(Vec3::new(x, input.movement.y, z))
}
