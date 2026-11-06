//! Transpiled from Horizon Rust crate
package horizon_world_server_player_damage

import "core:fmt"
import "core:mem"
import "core:math"

// Compose ordinary server-player inner damage with registered attributes,
// synchronized health/absorption and stored hunger. Outer hurt gates stay with
// the caller; equipment, effect, statistic and combat services stay explicit.
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
ServerDamageError :: enum {
    Attribute(A),
    Data(DataError<E>),
    Environment(E),
}
    // rust: impl<E: fmt::Display, A: fmt::Debug> fmt::Display for ServerDamageError<E, A> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
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
invulnerable :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
bypasses :: proc(self: ^Self, kind: Bypass) -> R {
    // Ported from Horizon
    return {}
}
    // Equipment breakage may update the live attribute map before armor and
    // toughness are queried by the rest of this hit.
hurt_armor :: proc(self: ^Self, attributes: ^A, damage: f32) -> R {
    // Ported from Horizon
    return {}
}
has_resistance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
resistance_amplifier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
award_resisted :: proc(self: ^Self, amount: i32) -> R {
    // Ported from Horizon
    return {}
}
attacker :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
award_dealt_resisted :: proc(self: ^Self, amount: i32) -> R {
    // Ported from Horizon
    return {}
}
damage_protection :: proc(self: ^Self, level: Self::ServerLevel) -> R {
    // Ported from Horizon
    return {}
}
award_self :: proc(self: ^Self, stat: DamageStat, amount: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn award_attacker(
    // rust: &mut self,
    // rust: attacker: Self::Attacker,
    // rust: stat: DamageStat,
    // rust: amount: i32,
    // rust: ) -> Result<(), EnvError<Self>>;
source_food_exhaustion :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
ability_invulnerable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
level_is_client :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
record_damage :: proc(self: ^Self, amount: f32) -> R {
    // Ported from Horizon
    return {}
}
damage_event :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}
ServerPlayerDamage :: struct {
    attributes: ^'a mut A,
    data: ^'a mut SyncedFloats,
    food: ^'a mut FoodData,
    ids: PlayerFloatIds,
    armor: A::Key,
    toughness: A::Key,
    environment: ^'a mut E,
}
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
health_binding :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
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
apply :: proc(self: ^Self, damage: f32) -> R {
    // Ported from Horizon
    return {}
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
weapon :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .weapon()
    // rust: .map_err(ServerDamageError::Environment)
}
server_level :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
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
bypasses :: proc(self: ^Self, b: Bypass) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .bypasses(b)
    // rust: .map_err(ServerDamageError::Environment)
}
hurt_armor :: proc(self: ^Self, v: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .hurt_armor(self.attributes, v)
    // rust: .map_err(ServerDamageError::Environment)
}
armor_value :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.armor.clone())
    // rust: .map(damage_reduction::armor_from_attribute)
    // rust: .map_err(ServerDamageError::Attribute)
}
toughness_attribute :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.attributes
    // rust: .health_attribute_value(self.toughness.clone())
    // rust: .map_err(ServerDamageError::Attribute)
}
has_resistance :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .has_resistance()
    // rust: .map_err(ServerDamageError::Environment)
}
resistance_amplifier :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .resistance_amplifier()
    // rust: .map_err(ServerDamageError::Environment)
}
victim_is_server_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
award_resisted :: proc(self: ^Self, v: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .award_resisted(v)
    // rust: .map_err(ServerDamageError::Environment)
}
attacker_is_server_player :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .attacker()
    // rust: .map(|v| v.is_some())
    // rust: .map_err(ServerDamageError::Environment)
}
award_dealt_resisted :: proc(self: ^Self, v: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .award_dealt_resisted(v)
    // rust: .map_err(ServerDamageError::Environment)
}
damage_protection :: proc(self: ^Self, l: Self::ServerLevel) -> R {
    // Ported from Horizon
    return {}
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
invulnerable :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .invulnerable()
    // rust: .map_err(ServerDamageError::Environment)
}
after_armor :: proc(self: ^Self, v: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: damage_reduction::after_armor(self, v)
}
after_magic :: proc(self: ^Self, v: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: damage_reduction::after_magic(self, v)
}
absorption :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.health_binding().absorption().map_err(health_error)
}
set_absorption :: proc(self: ^Self, v: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.health_binding()
    // rust: .set_absorption(v)
    // rust: .map_err(health_error)
}
server_player_attacker :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
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
award_self :: proc(self: ^Self, s: DamageStat, v: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .award_self(s, v)
    // rust: .map_err(ServerDamageError::Environment)
}
source_food_exhaustion :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .source_food_exhaustion()
    // rust: .map_err(ServerDamageError::Environment)
}
cause_food_exhaustion :: proc(self: ^Self, v: f32) -> R {
    // Ported from Horizon
    return {}
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
record_damage :: proc(self: ^Self, v: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .record_damage(v)
    // rust: .map_err(ServerDamageError::Environment)
}
health :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.data
    // rust: .get(self.ids.health)
    // rust: .map_err(|id| ServerDamageError::Data(DataError::UnknownId(id)))
}
set_health :: proc(self: ^Self, v: f32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.health_binding().set_health(v).map_err(health_error)
}
damage_event :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.environment
    // rust: .damage_event()
    // rust: .map_err(ServerDamageError::Environment)
}
}
