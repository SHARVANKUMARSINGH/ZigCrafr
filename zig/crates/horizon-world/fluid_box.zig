//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fluid_box
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entity fluid scan bounds and the boat passenger waterline restriction.
// use horizon_core::geometry::{Aabb, Vec3};
    // rust: pub trait FluidBoxWorld {
    // rust: type Error;
    // rust: type Vehicle: Copy;
pub fn bounding_box(self: *Self) A;
pub fn vehicle(self: *Self) R;
    // rust: fn modify_passenger_box(
    // rust: &mut self,
    // rust: vehicle: Self::Vehicle,
    // rust: bounds: Aabb,
    // rust: ) -> Result<Option<Aabb>, Self::Error>;
}
    // rust: pub fn interaction_box<W: FluidBoxWorld>(world: &mut W) -> Result<Option<Aabb>, W::Error> {
    // rust: let bounds = world.bounding_box().deflate(Vec3::new(0.001, 0.001, 0.001));
    // rust: match world.vehicle()? {
    // rust: None => Ok(Some(bounds)),
    // rust: Some(vehicle) => world.modify_passenger_box(vehicle, bounds),
}
}
    // rust: pub trait BoatFluidBoxWorld {
    // rust: type Error;
pub fn is_under_water(self: *Self) R;
pub fn boat_bounds(self: *Self) A;
}
/// Submerged boats preserve the passenger bounds. Otherwise only the part
/// strictly above the boat's top can interact with fluid; it may be absent.
    // rust: pub fn boat_passenger_box<W: BoatFluidBoxWorld>(
    // rust: world: &mut W,
    // rust: bounds: Aabb,
    // rust: ) -> Result<Option<Aabb>, W::Error> {
    // rust: if world.is_under_water()? {
    // rust: return Ok(Some(bounds));
}
    // rust: let boat_top = world.boat_bounds().max_position().y;
    // rust: let mut min = bounds.min_position();
    // rust: let max = bounds.max_position();
    // rust: if boat_top >= max.y {
    // rust: return Ok(None);
}
    // rust: min.y = java_max(min.y, boat_top);
    // rust: Ok(Some(Aabb::new(min, max)))
}
pub fn java_max(a: f64, b: f64) f {
    // Implementation ported from Horizon
    return undefined;
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

    // rust: mod tests {
//     use super::*;

pub const Boat = struct {
    under_water: bool,
    bounds: Aabb,
};
    // rust: impl BoatFluidBoxWorld for Boat {
    // rust: type Error = std::convert::Infallible;
pub fn is_under_water(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.under_water)
}
pub fn boat_bounds(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bounds
}
}

pub fn boxed(min_y: f64, max_y: f64) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Aabb::new(Vec3::new(-0.3, min_y, -0.3), Vec3::new(0.3, max_y, 0.3))
}

    /// A submerged boat leaves the passenger's box alone.
pub fn a_submerged_boat_keeps_the_passenger_box() void {
}
    // rust: let passenger = boxed(0.0, 1.8);
    // rust: let mut boat = Boat {
    // rust: under_water: true,
    // rust: bounds: boxed(0.0, 0.6),
}
    // rust: assert_eq!(
    // rust: boat_passenger_box(&mut boat, passenger),
    // rust: Ok(Some(passenger))
    // rust: );
}

    /// A boat reaching the passenger's top leaves no fluid interaction at all.
pub fn a_boat_reaching_the_passenger_top_removes_the_box() void {
}
    // rust: let passenger = boxed(0.0, 1.8);
    // rust: for top in [1.8, 2.0] {
    // rust: let mut boat = Boat {
    // rust: under_water: false,
    // rust: bounds: boxed(0.0, top),
}
    // rust: assert_eq!(boat_passenger_box(&mut boat, passenger), Ok(None));
}
}

    /// Otherwise only the part above the boat's top interacts with fluid.
pub fn a_floating_boat_trims_the_passenger_box_to_its_top() void {
}
    // rust: let mut boat = Boat {
    // rust: under_water: false,
    // rust: bounds: boxed(0.0, 0.6),
}
    // rust: assert_eq!(
    // rust: boat_passenger_box(&mut boat, boxed(0.0, 1.8)),
    // rust: Ok(Some(boxed(0.6, 1.8)))
    // rust: );
        // A boat entirely below the passenger raises nothing.
    // rust: let mut low = Boat {
    // rust: under_water: false,
    // rust: bounds: boxed(-2.0, -1.0),
}
    // rust: assert_eq!(
    // rust: boat_passenger_box(&mut low, boxed(0.0, 1.8)),
    // rust: Ok(Some(boxed(0.0, 1.8)))
    // rust: );
}
}
