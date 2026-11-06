//! Transpiled from Horizon Rust crate
package horizon_world_player_health

import "core:fmt"
import "core:mem"
import "core:math"

// Player absorption uses virtual synchronized-data access, unlike base living
// absorption field storage. Health keeps its direct synchronized-data access.
// use crate::{
    // rust: attribute_health::HealthAttributes,
    // rust: attributes::entity::{EntityAttributes, LookupError},
    // rust: compression::invalid,
    // rust: living_health::{self, HealthWorld},
    // rust: synced_floats::{DataError, Observer, SyncedFloats},
}
// use std::{fmt, io};
    // rust: pub trait PlayerHealthWorld: HealthWorld {
entity_data :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
read_absorption :: proc(self: ^Self, data: Self::Data) -> R {
    // Ported from Horizon
    return {}
}
write_absorption :: proc(self: ^Self, data: Self::Data, value: f32) -> R {
    // Ported from Horizon
    return {}
}
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
PlayerFloatIds :: struct {
    health: u8,
    absorption: u8,
}
PlayerHealthError :: enum {
    Attribute(A),
    Data(DataError<E>),
}
    // rust: impl<E: fmt::Display, A: fmt::Debug> fmt::Display for PlayerHealthError<E, A> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Attribute(e) => write!(f, "player health attribute lookup: {e:?}"),
    // rust: Self::Data(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static, A: fmt::Debug> std::error::Error for PlayerHealthError<E, A> {}
// Ordinary registered-player state, borrowing its actual float table. IDs come
// from the pinned entity-data schema; construction does not invent spawn state.
PlayerAttributeHealth :: struct {
    attributes: ^'a mut A,
    data: ^'a mut SyncedFloats,
    ids: PlayerFloatIds,
    max_health: A::Key,
    max_absorption: A::Key,
    dead: bool,
    observer: ^'a mut O,
}
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
heal :: proc(self: ^Self, amount: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: living_health::heal(self, amount)
}
set_health :: proc(self: ^Self, value: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: living_health::set_health(self, value)
}
    // rust: pub fn set_absorption(
    // rust: &mut self,
    // rust: value: f32,
    // rust: ) -> Result<(), PlayerHealthError<O::Error, A::Error>> {
    // rust: living_health::set_absorption(self, value)
}
absorption :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: absorption(self)
}
is_hurt :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: living_health::is_hurt(self)
}
is_dead_or_dying :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: living_health::is_dead_or_dying(self)
}
}
    // rust: impl<O: Observer, A: HealthAttributes> HealthWorld for PlayerAttributeHealth<'_, O, A> {
    // rust: type Error = PlayerHealthError<O::Error, A::Error>;
    // rust: type Data = ();
health :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.data
    // rust: .get(self.ids.health)
    // rust: .map_err(|id| PlayerHealthError::Data(DataError::UnknownId(id)))
}
health_data :: proc(self: ^Self) {
}
max_health_attribute :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.max_health.clone())
    // rust: .map_err(PlayerHealthError::Attribute)
}
max_absorption_attribute :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.max_absorption.clone())
    // rust: .map_err(PlayerHealthError::Attribute)
}
store_health :: proc(self: ^Self, _: () {
}
    // rust: self.data
    // rust: .set(self.ids.health, value, false, self.observer)
    // rust: .map_err(PlayerHealthError::Data)
}
store_absorption :: proc(self: ^Self, value: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: internal_set_absorption(self, value)
}
dead_flag :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.dead
}
dispatch_set_health :: proc(self: ^Self, value: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: living_health::set_health(self, value)
}
}
    // rust: impl<O: Observer, A: HealthAttributes> PlayerHealthWorld for PlayerAttributeHealth<'_, O, A> {
entity_data :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
read_absorption :: proc(self: ^Self, _: () {
}
    // rust: self.data
    // rust: .get(self.ids.absorption)
    // rust: .map_err(|id| PlayerHealthError::Data(DataError::UnknownId(id)))
}
write_absorption :: proc(self: ^Self, _: () {
}
    // rust: self.data
    // rust: .set(self.ids.absorption, value, false, self.observer)
    // rust: .map_err(PlayerHealthError::Data)
}
}
