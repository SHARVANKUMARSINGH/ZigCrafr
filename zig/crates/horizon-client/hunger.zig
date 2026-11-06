//! Transpiled from Horizon Rust crate
//! Module: horizon-client_hunger
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Hunger and regeneration over the resident player's actual health, damage,
//! attribute and exhaustion storage. Starvation borrows the same FoodData that
//! is mid-tick, preserving damage callbacks and the following timer reset.
// use crate::{
    // rust: Result,
    // rust: health::{Attributes, Environment, HealthEvent, HealthResources, HealthRules, State, Updates},
    // rust: motion::{MotionEvent, PlayerMotion},
}
// use horizon_world::{
    // rust: food::{Difficulty, FoodData, FoodWorld},
    // rust: player_health::{PlayerAttributeHealth, PlayerFloatIds},
    // rust: server_player_combat::ServerPlayerCombat,
    // rust: synced_floats::SyncedFloats,
}

/// A living entity is about to heal. Mods may change the amount or cancel.
/// `entity` identifies the affected entity. 358.
pub fn native_living_heal(entity: u32, amount: *mut f32, cancel: *mut bool) void {
}
    // rust: crate::native_client_hooks::living_heal(entity, amount, cancel);
}

    // rust: impl PlayerMotion {
    /// Player.causeFoodExhaustion: creative and spectator abilities suppress
    /// exhaustion from movement, attacks and effects.
pub fn cause_food_exhaustion(self: *Self, amount: f32) void {
}
    // rust: if !self.invulnerable && !self.spectator {
    // rust: self.health.food.add_exhaustion(amount);
}
}

    /// ServerPlayer.tickRegeneration, dispatched from Player.aiStep before
    /// inventory and living movement. The separately invoked food tick follows
    /// movement in ServerPlayer.doTick.
pub fn peaceful_regeneration(self: *Self, rules: HealthRules) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if rules.difficulty != Difficulty::Peaceful || !rules.natural_regeneration {
    // rust: return Ok(());
}
    // rust: if self.health.tick_count % 20 == 0 {
    // rust: let health = self.health.health();
    // rust: let maximum = self.attribute("minecraft:max_health")? as f32;
    // rust: if health < maximum {
    // rust: let mut amount = 1.0;
    // rust: let mut cancel = false;
    // rust: native_living_heal(self.entity_id as u32, &mut amount, &mut cancel);
    // rust: if !cancel {
    // rust: let h = &mut self.health;
    // rust: let mut observer = Updates(&mut self.events);
    // rust: PlayerAttributeHealth::new(
    // rust: &mut self.attributes,
    // rust: &mut h.data,
    // rust: h.ids,
    // rust: h.dead,
    // rust: &mut observer,
    // rust: )?
    // rust: .heal(amount)?;
}
}
    // rust: let saturation = self.health.food.saturation;
    // rust: if saturation < 20.0 {
    // rust: self.health.food.saturation = saturation + 1.0;
}
}
    // rust: if self.health.tick_count % 10 == 0 && self.health.food.needs_food() {
    // rust: self.health.food.food = self.health.food.food.wrapping_add(1);
}
    // rust: Ok(())
}
pub fn food_tick(self: *Self, resources: *HealthResources, rules: HealthRules) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.client_side {
    // rust: return Ok(());
}
    // rust: let h = &mut self.health;
    // rust: let mut world = TickWorld {
    // rust: entity: self.entity_id,
    // rust: resources,
    // rust: rules,
    // rust: invulnerable: self.invulnerable || self.spectator,
    // rust: client_loaded: self.client_loaded,
    // rust: attributes: &mut self.attributes,
    // rust: data: &mut h.data,
    // rust: ids: h.ids,
    // rust: hurt: &mut h.hurt,
    // rust: hurt_animation_time: &mut h.hurt_animation_time,
    // rust: dead: &mut h.dead,
    // rust: sync_velocity: &mut h.sync_velocity,
    // rust: game_time: h.game_time,
    // rust: events: &mut self.events,
}
    // rust: h.food.tick(&mut world)
}
}
pub const TickWorld = struct {
    entity: i32,
    resources: *'a HealthResources,
    rules: HealthRules,
    invulnerable: bool,
    client_loaded: bool,
    attributes: *'a mut Attributes,
    data: *'a mut SyncedFloats,
    ids: PlayerFloatIds,
    hurt: *'a mut State,
    hurt_animation_time: *'a mut i32,
    dead: *'a mut bool,
    sync_velocity: *'a mut bool,
    game_time: i64,
    events: *'a mut std.ArrayList(MotionEvent),
};
    // rust: impl FoodWorld for TickWorld<'_> {
    // rust: type Error = Box<dyn std::error::Error>;
    // rust: type Level = ();
pub fn level(self: *Self, _: *mut FoodData) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn difficulty(self: *Self, _: () void {
}
    // rust: Ok(self.rules.difficulty)
}
pub fn natural_regeneration(self: *Self, _: () void {
}
    // rust: Ok(self.rules.natural_regeneration)
}
pub fn is_hurt(self: *Self, _: *mut FoodData) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut observer = Updates(self.events);
    // rust: Ok(PlayerAttributeHealth::new(
    // rust: self.attributes,
    // rust: self.data,
    // rust: self.ids,
    // rust: *self.dead,
    // rust: &mut observer,
    // rust: )?
    // rust: .is_hurt()?)
}
pub fn heal(self: *Self, _: *mut FoodData, mut amount: f32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cancel = false;
    // rust: native_living_heal(self.entity as u32, &mut amount, &mut cancel);
    // rust: if cancel {
    // rust: return Ok(());
}
    // rust: let mut observer = Updates(self.events);
    // rust: Ok(PlayerAttributeHealth::new(
    // rust: self.attributes,
    // rust: self.data,
    // rust: self.ids,
    // rust: *self.dead,
    // rust: &mut observer,
    // rust: )?
    // rust: .heal(amount)?)
}
pub fn health(self: *Self, _: *mut FoodData) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .data
    // rust: .get(self.ids.health)
    // rust: .expect("validated health field"))
}
pub fn hurt_starvation(self: *Self, _: () void {
}
        // FoodData still ticks after a mode switch with an empty food bar, but
        // Player.hurtServer rejects starvation for invulnerable abilities.
    // rust: if self.invulnerable {
    // rust: return Ok(());
}
    // rust: let id = self
    // rust: .resources
    // rust: .damage
    // rust: .id("minecraft:starve")
    // rust: .expect("validated starvation source");
    // rust: self.events
    // rust: .push(MotionEvent::Health(HealthEvent::StarvationDamage(amount)));
    // rust: let mut environment = Environment {
    // rust: entity: self.entity,
    // rust: causing: 0,
    // rust: invulnerable: false,
    // rust: client_loaded: self.client_loaded,
    // rust: rules: self.rules,
    // rust: source: self
    // rust: .resources
    // rust: .damage
    // rust: .source::<()>(id, None, None, None)
    // rust: .expect("validated starvation source"),
    // rust: living_cause: false,
    // rust: events: self.events,
    // rust: dead: self.dead,
    // rust: sync_velocity: self.sync_velocity,
    // rust: game_time: self.game_time,
    // rust: status: Default::default(),
    // rust: blocking: None,
    // rust: blocked: 0.0,
    // rust: fully_blocked: false,
    // rust: block_sound: false,
    // rust: knocked: false,
    // rust: totem: false,
    // rust: totem_fired: false,
    // rust: canceled: false,
}
    // rust: if ServerPlayerCombat::new(self.attributes, self.data, food, self.ids, &mut environment)?
    // rust: .hurt(self.hurt, amount)?
    // rust: {
    // rust: *self.hurt_animation_time = self.hurt.hurt_time;
}
    // rust: Ok(())
}
}
