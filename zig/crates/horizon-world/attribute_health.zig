//! Transpiled from Horizon Rust crate
//! Module: horizon-world_attribute_health
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Bind health calculations to registered entity attributes and mutable data.
// use crate::{
    // rust: attribute_map::ValueKind,
    // rust: attributes::{
    // rust: entity::{AttributeId, EntityAttributes, LookupError},
    // rust: live::{self, Key, LiveAttributes},
    // rust: },
    // rust: living_health::{self, HealthWorld, SyncedFloat},
}
// use std::fmt;

pub const HealthError = enum {
    Attribute(A),
    Observer(E),
};
    // rust: impl<E: fmt::Display, A: fmt::Debug> fmt::Display for HealthError<E, A> {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Attribute(e) => write!(f, "health attribute lookup: {e:?}"),
    // rust: Self::Observer(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static, A: fmt::Debug> std::error::Error for HealthError<E, A> {}
/// Computed registered limits for a borrowed base LivingEntity health binding.
/// The borrow keeps the attribute map fixed. Virtual dispatch that can replace
/// the selected map belongs in a full HealthWorld implementation.
    // rust: pub trait HealthAttributes {
    // rust: type Key: Clone;
    // rust: type Error;
pub fn health_attribute_key(self: *Self, name: []const u8) O;
pub fn health_attribute_value(self: *Self, key: Self::Key) R;
}
    // rust: impl HealthAttributes for EntityAttributes {
    // rust: type Key = AttributeId;
    // rust: type Error = LookupError;
pub fn health_attribute_key(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.catalog().id(name)
}
pub fn health_attribute_value(self: *Self, key: AttributeId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value(key)
}
}
    // rust: impl<G: FnMut() -> i32> HealthAttributes for LiveAttributes<G> {
    // rust: type Key = Key;
    // rust: type Error = live::Error;
pub fn health_attribute_key(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.key(name)
}
pub fn health_attribute_value(self: *Self, key: Key) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value(Some(key), ValueKind::Computed)
}
}
    // rust: pub trait HealthObserver {
    // rust: type Error;
pub fn updated(self: *Self, health: *mut SyncedFloat) R;
}
/// A borrow of living state, without inventing spawn or save initialization.
/// Absorption here uses base LivingEntity field storage. Player-specific
/// synchronized absorption requires a different storage binding.
pub const AttributeHealth = struct {
    attributes: *'a mut A,
    health: *'a mut SyncedFloat,
    absorption: *'a mut f32,
    dead: bool,
    observer: *'a mut O,
    max_health: A::Key,
    max_absorption: A::Key,
};
    // rust: impl<'a, O: HealthObserver, A: HealthAttributes> AttributeHealth<'a, O, A> {
    // rust: pub fn new(
    // rust: attributes: &'a mut A,
    // rust: health: &'a mut SyncedFloat,
    // rust: absorption: &'a mut f32,
    // rust: dead: bool,
    // rust: observer: &'a mut O,
    // rust: ) -> Option<Self> {
    // rust: let max_health = attributes.health_attribute_key("minecraft:max_health")?;
    // rust: let max_absorption = attributes.health_attribute_key("minecraft:max_absorption")?;
    // rust: Some(Self {
    // rust: attributes,
    // rust: health,
    // rust: absorption,
    // rust: dead,
    // rust: observer,
    // rust: max_health,
    // rust: max_absorption,
    // rust: })
}
pub fn heal(self: *Self, amount: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_health::heal(self, amount)
}
pub fn set_health(self: *Self, value: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_health::set_health(self, value)
}
pub fn set_absorption(self: *Self, value: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_health::set_absorption(self, value)
}
pub fn is_hurt(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_health::is_hurt(self)
}
pub fn is_dead_or_dying(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_health::is_dead_or_dying(self)
}
}
    // rust: impl<O: HealthObserver, A: HealthAttributes> HealthWorld for AttributeHealth<'_, O, A> {
    // rust: type Error = HealthError<O::Error, A::Error>;
    // rust: type Data = ();
pub fn health(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.health.value())
}
pub fn health_data(self: *Self) void {
}
pub fn max_health_attribute(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.max_health.clone())
    // rust: .map_err(HealthError::Attribute)
}
pub fn max_absorption_attribute(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.max_absorption.clone())
    // rust: .map_err(HealthError::Attribute)
}
pub fn store_health(self: *Self, _: () void {
}
    // rust: self.health
    // rust: .set(value, false, |health| self.observer.updated(health))
    // rust: .map_err(HealthError::Observer)
}
pub fn store_absorption(self: *Self, value: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.absorption = value;
    // rust: Ok(())
}
pub fn dead_flag(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.dead
}
pub fn dispatch_set_health(self: *Self, value: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_health::set_health(self, value)
}
}
