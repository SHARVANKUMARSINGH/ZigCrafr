//! Transpiled from Horizon Rust crate
package horizon_world_server_player_combat

import "core:fmt"
import "core:mem"
import "core:math"

// Server-player outer hurt composed with registered attributes and player storage.
// use crate::{
    // rust: attribute_health::HealthAttributes,
    // rust: attributes::entity::EntityAttributes,
    // rust: combat_rules::ArmorWorld,
    // rust: damage_immunity::{self, ImmunityWorld},
    // rust: food::{Difficulty, FoodData},
    // rust: living_hurt::{HurtState, HurtTag, HurtWorld},
    // rust: player_health::PlayerFloatIds,
    // rust: player_hurt::{
    // rust: CausingEntity, PlayerHurtWorld, ServerPlayerHurtWorld, server_player_hurt_server,
    // rust: },
    // rust: server_player_damage::{ServerDamageEnvironment, ServerDamageError, ServerPlayerDamage},
    // rust: synced_floats::{DataError, SyncedFloats},
}
// use std::io;
    // rust: type Error<E> = <E as ArmorWorld>::Error;
    // rust: pub trait CombatEnvironment<A: HealthAttributes = EntityAttributes>:
    // rust: ServerDamageEnvironment<A>
    // rust: + ServerPlayerHurtWorld<Error = <Self as ArmorWorld>::Error>
    // rust: + ImmunityWorld<Error = <Self as ArmorWorld>::Error>
    // rust: {
    // Direct death flag, read only after health fails the native <= zero test.
dead_flag :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
}
ServerPlayerCombat :: struct {
    attributes: ^'a mut A,
    data: ^'a mut SyncedFloats,
    food: ^'a mut FoodData,
    ids: PlayerFloatIds,
    environment: ^'a mut E,
}
    // rust: impl<'a, A: HealthAttributes, E: CombatEnvironment<A>> ServerPlayerCombat<'a, E, A> {
    // rust: pub fn new(
    // rust: attributes: &'a mut A,
    // rust: data: &'a mut SyncedFloats,
    // rust: food: &'a mut FoodData,
    // rust: ids: PlayerFloatIds,
    // rust: environment: &'a mut E,
    // rust: ) -> io::Result<Self> {
    // rust: ServerPlayerDamage::new(attributes, data, food, ids, environment)?;
    // rust: Ok(Self {
    // rust: attributes,
    // rust: data,
    // rust: food,
    // rust: ids,
    // rust: environment,
    // rust: })
}
    // rust: pub fn hurt(
    // rust: &mut self,
    // rust: state: &mut HurtState<E::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<bool, ServerDamageError<Error<E>, A::Error>> {
    // rust: server_player_hurt_server(state, self, damage)
}
}
    // rust: impl<A: HealthAttributes, E: CombatEnvironment<A>> HurtWorld for ServerPlayerCombat<'_, E, A> {
    // rust: type Error = ServerDamageError<Error<E>, A::Error>;
    // rust: type Source = E::Source;
    // rust: type UseItem = E::UseItem;
    // rust: type Blocking = E::Blocking;
    // rust: type Sound = E::Sound;
source :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.environment.source()
}
is_server_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
dead_or_dying :: proc(self: ^Self, _: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let health = self
    // rust: .data
    // rust: .get(self.ids.health)
    // rust: .map_err(|id| ServerDamageError::Data(DataError::UnknownId(id)))?;
    // rust: Ok(health <= 0.0 || self.environment.dead_flag())
}
    // rust: fn actually_hurt(
    // rust: &mut self,
    // rust: _: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<(), Self::Error> {
    // rust: if damage_immunity::server_player_immunity(self.environment)
    // rust: .map_err(ServerDamageError::Environment)?
    // rust: {
    // rust: return Ok(());
}
    // rust: ServerPlayerDamage::new(
    // rust: self.attributes,
    // rust: self.data,
    // rust: self.food,
    // rust: self.ids,
    // rust: self.environment,
    // rust: )
    // rust: .expect("validated immutable player schema")
    // rust: .apply_after_immunity_check(damage)
}
blocking_component :: proc(self: ^Self, item: Self::UseItem) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.environment.blocking_component(item)
}
invulnerable :: proc(self: ^Self, _: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: damage_immunity::server_player_immunity(self.environment)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn tag(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: tag: HurtTag,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: HurtWorld::tag(self.environment, state, tag).map_err(ServerDamageError::Environment)
}
    // rust: fn fire_resistance(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: HurtWorld::fire_resistance(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn hurt_start(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: damage: &mut f32,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: HurtWorld::hurt_start(self.environment, state, damage)
    // rust: .map_err(ServerDamageError::Environment)
}
sleeping :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::sleeping(self.environment, state).map_err(ServerDamageError::Environment)
}
stop_sleeping :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::stop_sleeping(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn use_item(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<Self::UseItem, Self::Error> {
    // rust: HurtWorld::use_item(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn apply_blocking(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<f32, Self::Error> {
    // rust: HurtWorld::apply_blocking(self.environment, state, damage)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn freeze_hurts_extra(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: HurtWorld::freeze_hurts_extra(self.environment, state)
    // rust: .map_err(ServerDamageError::Environment)
}
helmet_empty :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::helmet_empty(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn hurt_helmet(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<(), Self::Error> {
    // rust: HurtWorld::hurt_helmet(self.environment, state, damage)
    // rust: .map_err(ServerDamageError::Environment)
}
resolve_mob :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::resolve_mob(self.environment, state).map_err(ServerDamageError::Environment)
}
resolve_player :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::resolve_player(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn on_blocked(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: block: Self::Blocking,
    // rust: ) -> Result<(), Self::Error> {
    // rust: HurtWorld::on_blocked(self.environment, state, block)
    // rust: .map_err(ServerDamageError::Environment)
}
broadcast_damage :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::broadcast_damage(self.environment, state).map_err(ServerDamageError::Environment)
}
mark_hurt :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::mark_hurt(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn knockback(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: blocked: bool,
    // rust: ) -> Result<(), Self::Error> {
    // rust: HurtWorld::knockback(self.environment, state, damage, blocked)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn death_protection(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: HurtWorld::death_protection(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn death_sound(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<Self::Sound, Self::Error> {
    // rust: HurtWorld::death_sound(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn make_sound(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: sound: Self::Sound,
    // rust: ) -> Result<(), Self::Error> {
    // rust: HurtWorld::make_sound(self.environment, state, sound)
    // rust: .map_err(ServerDamageError::Environment)
}
secondary_sound :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::secondary_sound(self.environment, state).map_err(ServerDamageError::Environment)
}
die :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::die(self.environment, state).map_err(ServerDamageError::Environment)
}
hurt_sound :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::hurt_sound(self.environment, state).map_err(ServerDamageError::Environment)
}
game_time :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: HurtWorld::game_time(self.environment, state).map_err(ServerDamageError::Environment)
}
    // rust: fn effects_on_hurt(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: damage: f32,
    // rust: ) -> Result<(), Self::Error> {
    // rust: HurtWorld::effects_on_hurt(self.environment, state, damage)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn player_hurt_criterion(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: original: f32,
    // rust: damage: f32,
    // rust: blocked: bool,
    // rust: ) -> Result<(), Self::Error> {
    // rust: HurtWorld::player_hurt_criterion(self.environment, state, original, damage, blocked)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn award_blocked(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: amount: i32,
    // rust: ) -> Result<(), Self::Error> {
    // rust: HurtWorld::award_blocked(self.environment, state, amount)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn attacker_criterion(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: original: f32,
    // rust: damage: f32,
    // rust: blocked: bool,
    // rust: ) -> Result<(), Self::Error> {
    // rust: HurtWorld::attacker_criterion(self.environment, state, original, damage, blocked)
    // rust: .map_err(ServerDamageError::Environment)
}
}
    // rust: impl<A: HealthAttributes, E: CombatEnvironment<A>> PlayerHurtWorld
    // rust: for ServerPlayerCombat<'_, E, A>
    // rust: {
ability_invulnerable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: ServerDamageEnvironment::ability_invulnerable(self.environment)
}
    // rust: fn bypasses_invulnerability(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: PlayerHurtWorld::bypasses_invulnerability(self.environment, state)
    // rust: .map_err(ServerDamageError::Environment)
}
remove_shoulders :: proc(self: ^Self, state: ^HurtState<Self::Source>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: PlayerHurtWorld::remove_shoulders(self.environment, state)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn scales_with_difficulty(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: PlayerHurtWorld::scales_with_difficulty(self.environment, state)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn difficulty(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<Difficulty, Self::Error> {
    // rust: PlayerHurtWorld::difficulty(self.environment, state).map_err(ServerDamageError::Environment)
}
}
    // rust: impl<A: HealthAttributes, E: CombatEnvironment<A>> ServerPlayerHurtWorld
    // rust: for ServerPlayerCombat<'_, E, A>
    // rust: {
    // rust: type Player = E::Player;
    // rust: type Arrow = E::Arrow;
    // rust: fn causing_entity(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: ) -> Result<CausingEntity<Self::Player, Self::Arrow>, Self::Error> {
    // rust: self.environment
    // rust: .causing_entity(state)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn arrow_player_owner(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: arrow: Self::Arrow,
    // rust: ) -> Result<Option<Self::Player>, Self::Error> {
    // rust: self.environment
    // rust: .arrow_player_owner(state, arrow)
    // rust: .map_err(ServerDamageError::Environment)
}
    // rust: fn can_harm_player(
    // rust: &mut self,
    // rust: state: &mut HurtState<Self::Source>,
    // rust: player: Self::Player,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: self.environment
    // rust: .can_harm_player(state, player)
    // rust: .map_err(ServerDamageError::Environment)
}
}
