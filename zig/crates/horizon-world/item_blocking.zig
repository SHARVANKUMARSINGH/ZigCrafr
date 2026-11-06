//! Transpiled from Horizon Rust crate
//! Module: horizon-world_item_blocking
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Living item-blocking dispatch around direction and component reductions.
// use crate::view_direction;
// use horizon_core::geometry::Vec3;
    // rust: pub trait ItemBlockingWorld {
    // rust: type Error;
    // rust: type Item: Copy;
    // rust: type Component: Copy;
    // rust: type Entity: Copy;
    // rust: type Level: Copy;
    // rust: type Hand: Copy;
pub fn blocking_item(self: *Self) R;
pub fn component(self: *Self, item: Self::Item) O;
pub fn bypasses_component(self: *Self, component: Self::Component) R;
pub fn direct_entity(self: *Self) R;
pub fn is_arrow(self: *Self, entity: Self::Entity) b;
pub fn pierce_level(self: *Self, arrow: Self::Entity) R;
pub fn source_position(self: *Self) R;
pub fn head_yaw(self: *Self) R;
pub fn position(self: *Self) R;
    // rust: fn resolve(
    // rust: &mut self,
    // rust: component: Self::Component,
    // rust: damage: f32,
    // rust: angle: f64,
    // rust: ) -> Result<f32, Self::Error>;
pub fn level(self: *Self) R;
pub fn used_hand(self: *Self) R;
    // rust: fn hurt_blocking_item(
    // rust: &mut self,
    // rust: component: Self::Component,
    // rust: level: Self::Level,
    // rust: item: Self::Item,
    // rust: hand: Self::Hand,
    // rust: blocked: f32,
    // rust: ) -> Result<(), Self::Error>;
pub fn source_is_projectile(self: *Self) R;
pub fn is_living(self: *Self, entity: Self::Entity) b;
    /// Uses the original server-level argument, not the later virtual level.
    // rust: fn block_using_item(
    // rust: &mut self,
    // rust: attacker: Self::Entity,
    // rust: damage: f32,
    // rust: fully_blocked: bool,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: pub fn apply<W: ItemBlockingWorld>(world: &mut W, damage: f32) -> Result<f32, W::Error> {
    // rust: if damage <= 0.0 {
    // rust: return Ok(0.0);
}
    // rust: let Some(item) = world.blocking_item()? else {
    // rust: return Ok(0.0);
}
    // rust: let Some(component) = world.component(item) else {
    // rust: return Ok(0.0);
}
    // rust: if world.bypasses_component(component)? {
    // rust: return Ok(0.0);
}
    // rust: if let Some(entity) = world.direct_entity()? {
    // rust: if world.is_arrow(entity) && world.pierce_level(entity)? > 0 {
    // rust: return Ok(0.0);
}
}
    // rust: let angle = if let Some(source) = world.source_position()? {
    // rust: let yaw = world.head_yaw()?;
    // rust: let position = world.position()?;
    // rust: view_direction::blocking_angle(source, position, yaw)
    // rust: } else {
    // rust: view_direction::BLOCKING_FALLBACK_ANGLE
}
    // rust: let blocked = world.resolve(component, damage, angle)?;
    // rust: let level = world.level()?;
    // rust: let hand = world.used_hand()?;
    // rust: world.hurt_blocking_item(component, level, item, hand, blocked)?;
    // rust: if blocked > 0.0 && !world.source_is_projectile()? {
    // rust: if let Some(entity) = world.direct_entity()? {
    // rust: if world.is_living(entity) {
    // rust: world.block_using_item(entity, damage, blocked >= damage)?;
}
}
}
    // rust: Ok(blocked)
}
