//! Transpiled from Horizon Rust crate
package horizon_world_active_effects

import "core:fmt"
import "core:mem"
import "core:math"

// Living entity status storage and add/replace/remove lifecycle ordering.
// use crate::{
    // rust: java_hash_map::{JavaHashMap, JavaKey},
    // rust: status_effect::EffectInstance,
}

ActiveEffects :: struct {
    // LivingEntity schedules effect synchronization from construction.
    dirty: bool,
    // Native activeEffects is exposed by getActiveEffectsMap. Direct mutations
    // bypass lifecycle notifications, but retain the map's iterator semantics.
    entries: JavaHashMap<H,
}
    // rust: impl<H: JavaKey> Default for ActiveEffects<H> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: entries: JavaHashMap::default(),
    // rust: dirty: true,
}
}
}
    // rust: pub trait EffectHooks<H: JavaKey + Clone> {
    // rust: type Error;
    // rust: type Source: Clone;
    // rust: type Level: Copy;
    // rust: fn can_be_affected(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: incoming: EffectInstance<H>,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn on_added(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: incoming: EffectInstance<H>,
    // rust: source: Option<Self::Source>,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn on_updated(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: existing: EffectInstance<H>,
    // rust: reapply: bool,
    // rust: source: Option<Self::Source>,
    // rust: ) -> Result<(), Self::Error>;
    // Concrete MobEffect.onEffectAdded dispatch, after the actor callback.
    // rust: fn effect_added(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: effect: H,
    // rust: amplifier: i32,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn effect_started(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: effect: H,
    // rust: amplifier: i32,
    // rust: ) -> Result<(), Self::Error>;
level :: proc(self: ^Self, storage: ^ActiveEffects<H>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn is_client(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: level: Self::Level,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn on_removed(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: effects: Vec<EffectInstance<H>>,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn get_effect(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: effect: H,
    // rust: ) -> Result<Option<EffectInstance<H>>, Self::Error> {
    // rust: Ok(storage.get(&effect))
}
    // Entity.isRemoved is a final field-based query.
actor_removed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
}
    // rust: impl<H: JavaKey + Clone> ActiveEffects<H> {
get :: proc(self: ^Self, effect: ^H) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.get(effect).cloned()
}
has :: proc(self: ^Self, effect: ^H) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.get(effect).is_some()
}
    // rust: pub fn add<W: EffectHooks<H>>(
    // rust: &mut self,
    // rust: incoming: EffectInstance<H>,
    // rust: source: Option<W::Source>,
    // rust: world: &mut W,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if !world.can_be_affected(self, incoming.clone())? {
    // rust: return Ok(false);
}
    // rust: let key = incoming.read().effect.clone();
    // rust: let existing = self.get(&key);
    // rust: let mut changed = false;
    // rust: if let Some(existing) = existing {
    // rust: if existing.update(&incoming) {
    // rust: world.on_updated(self, existing, true, source)?;
    // rust: changed = true;
}
    // rust: } else {
    // rust: self.entries.put(key, incoming.clone());
    // rust: world.on_added(self, incoming.clone(), source)?;
    // rust: changed = true;
    // rust: let data = incoming.read();
    // rust: let effect = data.effect.clone();
    // rust: let amplifier = data.details.amplifier;
    // rust: drop(data);
    // rust: world.effect_added(self, effect, amplifier)?;
}
    // rust: let data = incoming.read();
    // rust: let effect = data.effect.clone();
    // rust: let amplifier = data.details.amplifier;
    // rust: drop(data);
    // rust: world.effect_started(self, effect, amplifier)?;
    // rust: Ok(changed)
}
    // rust: pub fn force_add<W: EffectHooks<H>>(
    // rust: &mut self,
    // rust: incoming: EffectInstance<H>,
    // rust: source: Option<W::Source>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: if !world.can_be_affected(self, incoming.clone())? {
    // rust: return Ok(());
}
    // rust: let key = incoming.read().effect.clone();
    // rust: let previous = self.entries.put(key, incoming.clone());
    // rust: if let Some(previous) = previous {
    // rust: incoming.copy_blend_from(&previous);
    // rust: world.on_updated(self, incoming, true, source)?;
    // rust: } else {
    // rust: world.on_added(self, incoming, source)?;
}
    // rust: Ok(())
}
remove_no_update :: proc(self: ^Self, effect: ^H) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.remove(effect)
}
    // rust: pub fn remove<W: EffectHooks<H>>(
    // rust: &mut self,
    // rust: effect: &H,
    // rust: world: &mut W,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if let Some(instance) = self.remove_no_update(effect) {
    // rust: world.on_removed(self, vec![instance])?;
    // rust: Ok(true)
    // rust: } else {
    // rust: Ok(false)
}
}
    // rust: pub fn remove_all<W: EffectHooks<H>>(&mut self, world: &mut W) -> Result<bool, W::Error> {
    // rust: let level = world.level(self)?;
    // rust: if world.is_client(self, level)? || self.entries.is_empty() {
    // rust: return Ok(false);
}
    // rust: let previous = self.entries.copied();
    // rust: self.entries.clear();
    // rust: let values = previous.entries().map(|(_, v)| v.clone()).collect();
    // rust: world.on_removed(self, values)?;
    // rust: Ok(true)
}
    // rust: pub fn blend_factor<W: EffectHooks<H>>(
    // rust: &mut self,
    // rust: effect: H,
    // rust: partial: f32,
    // rust: world: &mut W,
    // rust: ) -> Result<f32, W::Error> {
    // rust: let effect = world.get_effect(self, effect)?;
    // rust: Ok(effect.map_or(0.0, |e| e.blend_factor(partial, world.actor_removed())))
}
}
