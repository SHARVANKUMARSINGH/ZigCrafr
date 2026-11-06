//! Transpiled from Horizon Rust crate
//! Module: horizon-world_living_health
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Living health/absorption limits and healing/query dispatch order.
    // rust: pub trait HealthWorld {
    // rust: type Error;
    // rust: type Data: Copy;
pub fn health(self: *Self) R;
    /// Captures the current synchronized-data object before attribute lookup.
pub fn health_data(self: *Self) S;
pub fn max_health_attribute(self: *Self) R;
pub fn max_absorption_attribute(self: *Self) R;
pub fn store_health(self: *Self, data: Self::Data, value: f32) R;
pub fn store_absorption(self: *Self, value: f32) R;
pub fn dead_flag(self: *Self) b;
pub fn dispatch_set_health(self: *Self, value: f32) R;
}
pub fn clamp(value: f32, max: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if value < 0.0 {
    // rust: 0.0
    // rust: } else if value.is_nan() || max.is_nan() {
    // rust: f32::NAN
    // rust: } else if value == 0.0 && max == 0.0 {
    // rust: f32::from_bits(value.to_bits() | max.to_bits())
    // rust: } else {
    // rust: value.min(max)
}
}
    // rust: pub fn set_health<W: HealthWorld>(world: &mut W, value: f32) -> Result<(), W::Error> {
    // rust: let data = world.health_data();
    // rust: let maximum = world.max_health_attribute()? as f32;
    // rust: world.store_health(data, clamp(value, maximum))
}
    // rust: pub fn set_absorption<W: HealthWorld>(world: &mut W, value: f32) -> Result<(), W::Error> {
    // rust: let maximum = world.max_absorption_attribute()? as f32;
    // rust: world.store_absorption(clamp(value, maximum))
}
    // rust: pub fn heal<W: HealthWorld>(world: &mut W, amount: f32) -> Result<(), W::Error> {
    // rust: let health = world.health()?;
    // rust: if health > 0.0 {
    // rust: world.dispatch_set_health(health + amount)?;
}
    // rust: Ok(())
}
    // rust: pub fn is_hurt<W: HealthWorld>(world: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(world.health()? > 0.0 && world.health()? < world.max_health_attribute()? as f32)
}
    // rust: pub fn is_dead_or_dying<W: HealthWorld>(world: &mut W) -> Result<bool, W::Error> {
    // rust: Ok(world.health()? <= 0.0 || world.dead_flag())
}
/// One synchronized Float data item, using Java boxed-float equality. The native
/// callback observes the new value before dirty flags are set. Exceptions leave
/// that value changed without newly marking it dirty.
pub const SyncedFloat = struct {
    initial: f32,
    value: f32,
    item_dirty: bool,
    dirty: bool,
};
pub fn equal(a: f32, b: f32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a.to_bits() == b.to_bits() || (a.is_nan() && b.is_nan())
}
    // rust: impl SyncedFloat {
pub fn new(value: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: initial: value,
    // rust: value,
    // rust: item_dirty: false,
    // rust: dirty: false,
}
}
pub fn value(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value
}
pub fn is_dirty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.dirty
}
pub fn item_dirty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.item_dirty
}
pub fn is_default(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: equal(self.initial, self.value)
}
    // rust: pub fn set<E>(
    // rust: &mut self,
    // rust: value: f32,
    // rust: force: bool,
    // rust: updated: impl FnOnce(&mut Self) -> Result<(), E>,
    // rust: ) -> Result<(), E> {
    // rust: if force || !equal(value, self.value) {
    // rust: self.value = value;
    // rust: updated(self)?;
    // rust: self.item_dirty = true;
    // rust: self.dirty = true;
}
    // rust: Ok(())
}
    /// Extracts this single item's update. Multi-item synchronized storage and
    /// network serialization are separate concerns.
pub fn take_dirty(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.dirty {
    // rust: return None;
}
    // rust: self.dirty = false;
    // rust: if self.item_dirty {
    // rust: self.item_dirty = false;
    // rust: Some(self.value)
    // rust: } else {
    // rust: None
}
}
}
