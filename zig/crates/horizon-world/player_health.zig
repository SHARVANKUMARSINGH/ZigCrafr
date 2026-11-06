//! Transpiled from Horizon Rust crate
//! Module: horizon-world_player_health
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Player absorption uses virtual synchronized-data access, unlike base living
//! absorption field storage. Health keeps its direct synchronized-data access.
// use crate::{
    // rust: attribute_health::HealthAttributes,
    // rust: attributes::entity::{EntityAttributes, LookupError},
    // rust: compression::invalid,
    // rust: living_health::{self, HealthWorld},
    // rust: synced_floats::{DataError, Observer, SyncedFloats},
}
// use std::{fmt, io};
    // rust: pub trait PlayerHealthWorld: HealthWorld {
pub fn entity_data(self: *Self) R;
pub fn read_absorption(self: *Self, data: Self::Data) R;
pub fn write_absorption(self: *Self, data: Self::Data, value: f32) R;
}
    // rust: pub fn absorption<W: PlayerHealthWorld>(world: &mut W) -> Result<f32, W::Error> {
    // rust: let data = world.entity_data()?;
    // rust: world.read_absorption(data)
}
    // rust: pub fn internal_set_absorption<W: PlayerHealthWorld>(
    // rust: world: &mut W,
    // rust: value: f32,
    // rust: ) -> Result<(), W::Error> {
    // rust: let data = world.entity_data()?;
    // rust: world.write_absorption(data, value)
}
pub const PlayerFloatIds = struct {
    health: u8,
    absorption: u8,
};
pub const PlayerHealthError = enum {
    Attribute(A),
    Data(DataError<E>),
};
    // rust: impl<E: fmt::Display, A: fmt::Debug> fmt::Display for PlayerHealthError<E, A> {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Attribute(e) => write!(f, "player health attribute lookup: {e:?}"),
    // rust: Self::Data(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static, A: fmt::Debug> std::error::Error for PlayerHealthError<E, A> {}
/// Ordinary registered-player state, borrowing its actual float table. IDs come
/// from the pinned entity-data schema; construction does not invent spawn state.
pub const PlayerAttributeHealth = struct {
    attributes: *'a mut A,
    data: *'a mut SyncedFloats,
    ids: PlayerFloatIds,
    max_health: A::Key,
    max_absorption: A::Key,
    dead: bool,
    observer: *'a mut O,
};
    // rust: impl<'a, O: Observer, A: HealthAttributes> PlayerAttributeHealth<'a, O, A> {
    // rust: pub fn new(
    // rust: attributes: &'a mut A,
    // rust: data: &'a mut SyncedFloats,
    // rust: ids: PlayerFloatIds,
    // rust: dead: bool,
    // rust: observer: &'a mut O,
    // rust: ) -> io::Result<Self> {
    // rust: if ids.health == ids.absorption
    // rust: || data.get(ids.health).is_err()
    // rust: || data.get(ids.absorption).is_err()
    // rust: {
    // rust: return Err(invalid("missing or aliased player float fields"));
}
    // rust: let max_health = attributes
    // rust: .health_attribute_key("minecraft:max_health")
    // rust: .ok_or_else(|| invalid("missing MAX_HEALTH definition"))?;
    // rust: let max_absorption = attributes
    // rust: .health_attribute_key("minecraft:max_absorption")
    // rust: .ok_or_else(|| invalid("missing MAX_ABSORPTION definition"))?;
    // rust: Ok(Self {
    // rust: attributes,
    // rust: data,
    // rust: ids,
    // rust: max_health,
    // rust: max_absorption,
    // rust: dead,
    // rust: observer,
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
    // rust: pub fn set_absorption(
    // rust: &mut self,
    // rust: value: f32,
    // rust: ) -> Result<(), PlayerHealthError<O::Error, A::Error>> {
    // rust: living_health::set_absorption(self, value)
}
pub fn absorption(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: absorption(self)
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
    // rust: impl<O: Observer, A: HealthAttributes> HealthWorld for PlayerAttributeHealth<'_, O, A> {
    // rust: type Error = PlayerHealthError<O::Error, A::Error>;
    // rust: type Data = ();
pub fn health(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .get(self.ids.health)
    // rust: .map_err(|id| PlayerHealthError::Data(DataError::UnknownId(id)))
}
pub fn health_data(self: *Self) void {
}
pub fn max_health_attribute(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.max_health.clone())
    // rust: .map_err(PlayerHealthError::Attribute)
}
pub fn max_absorption_attribute(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.max_absorption.clone())
    // rust: .map_err(PlayerHealthError::Attribute)
}
pub fn store_health(self: *Self, _: () void {
}
    // rust: self.data
    // rust: .set(self.ids.health, value, false, self.observer)
    // rust: .map_err(PlayerHealthError::Data)
}
pub fn store_absorption(self: *Self, value: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: internal_set_absorption(self, value)
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
    // rust: impl<O: Observer, A: HealthAttributes> PlayerHealthWorld for PlayerAttributeHealth<'_, O, A> {
pub fn entity_data(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn read_absorption(self: *Self, _: () void {
}
    // rust: self.data
    // rust: .get(self.ids.absorption)
    // rust: .map_err(|id| PlayerHealthError::Data(DataError::UnknownId(id)))
}
pub fn write_absorption(self: *Self, _: () void {
}
    // rust: self.data
    // rust: .set(self.ids.absorption, value, false, self.observer)
    // rust: .map_err(PlayerHealthError::Data)
}
}
