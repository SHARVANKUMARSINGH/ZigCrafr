//! Transpiled from Horizon Rust crate
//! Module: horizon-world_server_player_damage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Compose ordinary server-player inner damage with registered attributes,
//! synchronized health/absorption and stored hunger. Outer hurt gates stay with
//! the caller; equipment, effect, statistic and combat services stay explicit.
// use crate::{
    // rust: attribute_health::HealthAttributes,
    // rust: attributes::entity::{EntityAttributes, LookupError},
    // rust: combat_rules::ArmorWorld,
    // rust: compression::invalid,
    // rust: damage_reduction::{self, Bypass, DamageReductionWorld},
    // rust: food::FoodData,
    // rust: living_damage::{self, DamageStat, DamageWorld},
    // rust: player_health::{PlayerAttributeHealth, PlayerFloatIds, PlayerHealthError},
    // rust: synced_floats::{DataError, Observer, SyncedFloats},
}
// use std::{fmt, io};
    // rust: type EnvError<E> = <E as ArmorWorld>::Error;
pub const ServerDamageError = enum {
    Attribute(A),
    Data(DataError<E>),
    Environment(E),
};
    // rust: impl<E: fmt::Display, A: fmt::Debug> fmt::Display for ServerDamageError<E, A> {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Attribute(e) => write!(f, "damage attribute lookup: {e:?}"),
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::Environment(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static, A: fmt::Debug> std::error::Error for ServerDamageError<E, A> {}
    // rust: fn health_error<E, A>(e: PlayerHealthError<E, A>) -> ServerDamageError<E, A> {
    // rust: match e {
    // rust: PlayerHealthError::Attribute(e) => ServerDamageError::Attribute(e),
    // rust: PlayerHealthError::Data(e) => ServerDamageError::Data(e),
}
}
    // rust: pub trait ServerDamageEnvironment<A: HealthAttributes = EntityAttributes>:
    // rust: ArmorWorld + Observer<Error = <Self as ArmorWorld>::Error>
    // rust: {
    // rust: type Attacker: Copy;
pub fn invulnerable(self: *Self) R;
pub fn bypasses(self: *Self, kind: Bypass) R;
    /// Equipment breakage may update the live attribute map before armor and
    /// toughness are queried by the rest of this hit.
pub fn hurt_armor(self: *Self, attributes: *mut A, damage: f32) R;
pub fn has_resistance(self: *Self) R;
pub fn resistance_amplifier(self: *Self) R;
pub fn award_resisted(self: *Self, amount: i32) R;
pub fn attacker(self: *Self) R;
pub fn award_dealt_resisted(self: *Self, amount: i32) R;
pub fn damage_protection(self: *Self, level: Self::ServerLevel) R;
pub fn award_self(self: *Self, stat: DamageStat, amount: i32) R;
    // rust: fn award_attacker(
    // rust: &mut self,
    // rust: attacker: Self::Attacker,
    // rust: stat: DamageStat,
    // rust: amount: i32,
    // rust: ) -> Result<(), EnvError<Self>>;
pub fn source_food_exhaustion(self: *Self) R;
pub fn ability_invulnerable(self: *Self) b;
pub fn level_is_client(self: *Self) R;
pub fn record_damage(self: *Self, amount: f32) R;
pub fn damage_event(self: *Self) R;
}
pub const ServerPlayerDamage = struct {
    attributes: *'a mut A,
    data: *'a mut SyncedFloats,
    food: *'a mut FoodData,
    ids: PlayerFloatIds,
    armor: A::Key,
    toughness: A::Key,
    environment: *'a mut E,
};
    // rust: impl<'a, A: HealthAttributes, E: ServerDamageEnvironment<A>> ServerPlayerDamage<'a, E, A> {
    // rust: pub fn new(
    // rust: attributes: &'a mut A,
    // rust: data: &'a mut SyncedFloats,
    // rust: food: &'a mut FoodData,
    // rust: ids: PlayerFloatIds,
    // rust: environment: &'a mut E,
    // rust: ) -> io::Result<Self> {
    // rust: let armor = attributes
    // rust: .health_attribute_key("minecraft:armor")
    // rust: .ok_or_else(|| invalid("missing ARMOR definition"))?;
    // rust: let toughness = attributes
    // rust: .health_attribute_key("minecraft:armor_toughness")
    // rust: .ok_or_else(|| invalid("missing ARMOR_TOUGHNESS definition"))?;
    // rust: PlayerAttributeHealth::new(attributes, data, ids, false, environment)?;
    // rust: Ok(Self {
    // rust: attributes,
    // rust: data,
    // rust: food,
    // rust: ids,
    // rust: armor,
    // rust: toughness,
    // rust: environment,
    // rust: })
}
pub fn health_binding(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PlayerAttributeHealth::new(
    // rust: self.attributes,
    // rust: self.data,
    // rust: self.ids,
    // rust: false,
    // rust: self.environment,
    // rust: )
    // rust: .expect("validated immutable player float schema")
}
pub fn apply(self: *Self, damage: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: living_damage::actually_hurt(self, damage, true)
}
    // rust: pub(crate) fn apply_after_immunity_check(
    // rust: &mut self,
    // rust: damage: f32,
    // rust: ) -> Result<(), ServerDamageError<EnvError<E>, A::Error>> {
    // rust: living_damage::actually_hurt_after_immunity_check(self, damage, true)
}
}
    // rust: impl<A: HealthAttributes, E: ServerDamageEnvironment<A>> ArmorWorld
    // rust: for ServerPlayerDamage<'_, E, A>
    // rust: {
    // rust: type Error = ServerDamageError<EnvError<E>, A::Error>;
    // rust: type Weapon = E::Weapon;
    // rust: type ServerLevel = E::ServerLevel;
pub fn weapon(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .weapon()
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn server_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .server_level()
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn modify_armor_effectiveness(
    // rust: &mut self,
    // rust: l: Self::ServerLevel,
    // rust: w: Self::Weapon,
    // rust: v: f32,
    // rust: ) -> Result<f32, Self::Error> {
    // rust: self.environment
    // rust: .modify_armor_effectiveness(l, w, v)
    // rust: .map_err(ServerDamageError::Environment)
}
}
    // rust: impl<A: HealthAttributes, E: ServerDamageEnvironment<A>> DamageReductionWorld
    // rust: for ServerPlayerDamage<'_, E, A>
    // rust: {
pub fn bypasses(self: *Self, b: Bypass) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .bypasses(b)
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn hurt_armor(self: *Self, v: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .hurt_armor(self.attributes, v)
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn armor_value(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.armor.clone())
    // rust: .map(damage_reduction::armor_from_attribute)
    // rust: .map_err(ServerDamageError::Attribute)
}
pub fn toughness_attribute(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.toughness.clone())
    // rust: .map_err(ServerDamageError::Attribute)
}
pub fn has_resistance(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .has_resistance()
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn resistance_amplifier(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .resistance_amplifier()
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn victim_is_server_player(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn award_resisted(self: *Self, v: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .award_resisted(v)
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn attacker_is_server_player(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .attacker()
    // rust: .map(|v| v.is_some())
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn award_dealt_resisted(self: *Self, v: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .award_dealt_resisted(v)
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn damage_protection(self: *Self, l: Self::ServerLevel) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .damage_protection(l)
    // rust: .map_err(ServerDamageError::Environment)
}
}
    // rust: impl<A: HealthAttributes, E: ServerDamageEnvironment<A>> DamageWorld
    // rust: for ServerPlayerDamage<'_, E, A>
    // rust: {
    // rust: type Error = ServerDamageError<EnvError<E>, A::Error>;
    // rust: type Attacker = E::Attacker;
pub fn invulnerable(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .invulnerable()
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn after_armor(self: *Self, v: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: damage_reduction::after_armor(self, v)
}
pub fn after_magic(self: *Self, v: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: damage_reduction::after_magic(self, v)
}
pub fn absorption(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.health_binding().absorption().map_err(health_error)
}
pub fn set_absorption(self: *Self, v: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.health_binding()
    // rust: .set_absorption(v)
    // rust: .map_err(health_error)
}
pub fn server_player_attacker(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .attacker()
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn award_attacker(
    // rust: &mut self,
    // rust: a: Self::Attacker,
    // rust: s: DamageStat,
    // rust: v: i32,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.environment
    // rust: .award_attacker(a, s, v)
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn award_self(self: *Self, s: DamageStat, v: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .award_self(s, v)
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn source_food_exhaustion(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .source_food_exhaustion()
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn cause_food_exhaustion(self: *Self, v: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.environment.ability_invulnerable()
    // rust: && !self
    // rust: .environment
    // rust: .level_is_client()
    // rust: .map_err(ServerDamageError::Environment)?
    // rust: {
    // rust: self.food.add_exhaustion(v);
}
    // rust: Ok(())
}
pub fn record_damage(self: *Self, v: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .record_damage(v)
    // rust: .map_err(ServerDamageError::Environment)
}
pub fn health(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .get(self.ids.health)
    // rust: .map_err(|id| ServerDamageError::Data(DataError::UnknownId(id)))
}
pub fn set_health(self: *Self, v: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.health_binding().set_health(v).map_err(health_error)
}
pub fn damage_event(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.environment
    // rust: .damage_event()
    // rust: .map_err(ServerDamageError::Environment)
}
}
