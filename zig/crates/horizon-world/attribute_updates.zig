//! Transpiled from Horizon Rust crate
//! Module: horizon-world_attribute_updates
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Consequences of LivingEntity attribute changes, preserving virtual call order.
// use crate::living_health::{self, HealthWorld};
pub const UpdatedAttribute = enum {
    MaxHealth,
    MaxAbsorption,
    Scale,
    WaypointRange,
    Other,
};
    // rust: pub trait UpdateWorld<H>: HealthWorld {
    // rust: type Level: Copy;
    // rust: type Manager: Copy;
    // rust: type Attributes: Copy;
pub fn attribute_kind(self: *Self, attribute: *H) U;
pub fn absorption(self: *Self) R;
pub fn refresh_dimensions(self: *Self) R;
pub fn level(self: *Self) R;
pub fn is_server_level(self: *Self, level: Self::Level) b;
pub fn waypoint_manager(self: *Self, level: Self::Level) R;
    /// Direct attributes field, read after obtaining the waypoint manager.
pub fn attributes_field(self: *Self) S;
    // rust: fn attribute_value_in(
    // rust: &mut self,
    // rust: attributes: Self::Attributes,
    // rust: attribute: H,
    // rust: ) -> Result<f64, Self::Error>;
pub fn track_waypoint(self: *Self, manager: Self::Manager, track: bool) R;
}
    // rust: pub fn updated<H, W: UpdateWorld<H>>(world: &mut W, attribute: H) -> Result<(), W::Error> {
    // rust: match world.attribute_kind(&attribute) {
    // rust: UpdatedAttribute::MaxHealth => {
    // rust: let maximum = world.max_health_attribute()? as f32;
    // rust: if world.health()? > maximum {
    // rust: world.dispatch_set_health(maximum)?;
}
}
    // rust: UpdatedAttribute::MaxAbsorption => {
    // rust: let maximum = world.max_absorption_attribute()? as f32;
    // rust: if world.absorption()? > maximum {
    // rust: living_health::set_absorption(world, maximum)?;
}
}
    // rust: UpdatedAttribute::Scale => world.refresh_dimensions()?,
    // rust: UpdatedAttribute::WaypointRange => {
    // rust: let level = world.level()?;
    // rust: if world.is_server_level(level) {
    // rust: let manager = world.waypoint_manager(level)?;
    // rust: let attributes = world.attributes_field();
    // rust: let range = world.attribute_value_in(attributes, attribute)?;
    // rust: world.track_waypoint(manager, range > 0.0)?;
}
}
    // rust: UpdatedAttribute::Other => {}
}
    // rust: Ok(())
}
