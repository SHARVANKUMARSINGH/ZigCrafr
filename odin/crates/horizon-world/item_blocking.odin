//! Transpiled from Horizon Rust crate
package horizon_world_item_blocking

import "core:fmt"
import "core:mem"
import "core:math"

// Living item-blocking dispatch around direction and component reductions.
// use crate::view_direction;
// use horizon_core::geometry::Vec3;
    // rust: pub trait ItemBlockingWorld {
    // rust: type Error;
    // rust: type Item: Copy;
    // rust: type Component: Copy;
    // rust: type Entity: Copy;
    // rust: type Level: Copy;
    // rust: type Hand: Copy;
blocking_item :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
component :: proc(self: ^Self, item: Self::Item) -> O {
    // Ported from Horizon
    return {}
}
bypasses_component :: proc(self: ^Self, component: Self::Component) -> R {
    // Ported from Horizon
    return {}
}
direct_entity :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_arrow :: proc(self: ^Self, entity: Self::Entity) -> b {
    // Ported from Horizon
    return {}
}
pierce_level :: proc(self: ^Self, arrow: Self::Entity) -> R {
    // Ported from Horizon
    return {}
}
source_position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
head_yaw :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
position :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn resolve(
    // rust: &mut self,
    // rust: component: Self::Component,
    // rust: damage: f32,
    // rust: angle: f64,
    // rust: ) -> Result<f32, Self::Error>;
level :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
used_hand :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn hurt_blocking_item(
    // rust: &mut self,
    // rust: component: Self::Component,
    // rust: level: Self::Level,
    // rust: item: Self::Item,
    // rust: hand: Self::Hand,
    // rust: blocked: f32,
    // rust: ) -> Result<(), Self::Error>;
source_is_projectile :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
is_living :: proc(self: ^Self, entity: Self::Entity) -> b {
    // Ported from Horizon
    return {}
}
    // Uses the original server-level argument, not the later virtual level.
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
