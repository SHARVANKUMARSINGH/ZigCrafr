//! Transpiled from Horizon Rust crate
package horizon_world_effect_sync

import "core:fmt"
import "core:mem"
import "core:math"

// Living effect particle, invisibility and glowing synchronization.
// use crate::{active_effects::ActiveEffects, effect_particles::Particle, java_hash_map::JavaKey};
// use std::sync::Arc;

Presence :: enum {
    Invisibility,
    Glowing,
}

    // rust: pub trait EffectSyncWorld<H: JavaKey + Clone> {
    // rust: type Error;
    // rust: type Data: Copy;
    // rust: type Level: Copy;
    // Direct entityData field access, retaining the selected object.
data :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: fn store_particles(
    // rust: &mut self,
    // rust: effects: &mut ActiveEffects<H>,
    // rust: data: Self::Data,
    // rust: particles: Arc<[Particle]>,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn store_ambient(
    // rust: &mut self,
    // rust: effects: &mut ActiveEffects<H>,
    // rust: data: Self::Data,
    // rust: ambient: bool,
    // rust: ) -> Result<(), Self::Error>;
    // Actual registered factories are pure and cannot mutate the active map.
particle :: proc(self: ^Self, effect: ^H, ambient: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn has_effect(
    // rust: &mut self,
    // rust: effects: &mut ActiveEffects<H>,
    // rust: kind: Presence,
    // rust: ) -> Result<bool, Self::Error>;
level :: proc(self: ^Self, effects: ^ActiveEffects<H>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn is_client(
    // rust: &mut self,
    // rust: effects: &mut ActiveEffects<H>,
    // rust: level: Self::Level,
    // rust: ) -> Result<bool, Self::Error>;
glowing_tag :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
write_glowing_tag :: proc(self: ^Self, value: bool) {
}
read_flags :: proc(self: ^Self, data: Self::Data) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn write_flags(
    // rust: &mut self,
    // rust: effects: &mut ActiveEffects<H>,
    // rust: data: Self::Data,
    // rust: flags: u8,
    // rust: ) -> Result<(), Self::Error>;
get_flag :: proc(self: ^Self, _: ^ActiveEffects<H>, bit: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: shared_flag(self, bit)
}
    // rust: fn set_flag(
    // rust: &mut self,
    // rust: effects: &mut ActiveEffects<H>,
    // rust: bit: i32,
    // rust: value: bool,
    // rust: ) -> Result<(), Self::Error>
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: set_shared_flag(effects, self, bit, value)
}
    // rust: fn set_invisible(
    // rust: &mut self,
    // rust: effects: &mut ActiveEffects<H>,
    // rust: value: bool,
    // rust: ) -> Result<(), Self::Error>
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: self.set_flag(effects, 5, value)
}
currently_glowing :: proc(self: ^Self, effects: ^ActiveEffects<H>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: currently_glowing(effects, self)
}
remove_particles :: proc(self: ^Self, effects: ^ActiveEffects<H>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: remove_particles(effects, self)
}
update_invisibility :: proc(self: ^Self, effects: ^ActiveEffects<H>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: update_invisibility(effects, self)
}
}
    // rust: pub fn all_ambient<H: JavaKey + Clone>(effects: &ActiveEffects<H>) -> bool {
    // rust: effects.entries.entries().all(|(_, e)| {
    // rust: let e = e.read();
    // rust: !e.details.visible || e.details.ambient
    // rust: })
}
    // rust: pub fn synchronize_particles<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: effects: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // Registered factories have no world/map access. Their native stream pass
    // therefore preserves this order without a structural mutation callback.
    // rust: let particles = effects
    // rust: .entries
    // rust: .entries()
    // rust: .filter_map(|(_, e)| {
    // rust: let e = e.read();
    // rust: e.details
    // rust: .visible
    // rust: .then(|| world.particle(&e.effect, e.details.ambient))
    // rust: })
    // rust: .collect::<Result<Arc<[_]>, _>>()?;
    // rust: let data = world.data();
    // rust: world.store_particles(effects, data, particles)?;
    // rust: let data = world.data();
    // rust: let ambient = all_ambient(effects);
    // rust: world.store_ambient(effects, data, ambient)
}
    // rust: pub fn remove_particles<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: effects: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: let data = world.data();
    // rust: world.store_particles(effects, data, Arc::from([]))
}
    // rust: pub fn update_invisibility<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: effects: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: if effects.entries.is_empty() {
    // rust: world.remove_particles(effects)?;
    // rust: return world.set_invisible(effects, false);
}
    // rust: let invisible = world.has_effect(effects, Presence::Invisibility)?;
    // rust: world.set_invisible(effects, invisible)?;
    // rust: synchronize_particles(effects, world)
}
    // rust: pub fn shared_flag<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: world: &W,
    // rust: bit: i32,
    // rust: ) -> Result<bool, W::Error> {
    // rust: let flags = i32::from(world.read_flags(world.data())? as i8);
    // rust: Ok(flags & 1i32.wrapping_shl(bit as u32) != 0)
}
    // rust: pub fn set_shared_flag<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: effects: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: bit: i32,
    // rust: value: bool,
    // rust: ) -> Result<(), W::Error> {
    // rust: let flags = i32::from(world.read_flags(world.data())? as i8);
    // rust: let mask = 1i32.wrapping_shl(bit as u32);
    // rust: let value = if value { flags | mask } else { flags & !mask } as u8;
    // rust: let data = world.data();
    // rust: world.write_flags(effects, data, value)
}
    // rust: pub fn currently_glowing<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: effects: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<bool, W::Error> {
    // rust: let level = world.level(effects)?;
    // rust: if !world.is_client(effects, level)? && world.has_effect(effects, Presence::Glowing)? {
    // rust: return Ok(true);
}
    // Entity's base body repeats the virtual level/client lookups.
    // rust: let level = world.level(effects)?;
    // rust: if world.is_client(effects, level)? {
    // rust: world.get_flag(effects, 6)
    // rust: } else {
    // rust: Ok(world.glowing_tag())
}
}
    // rust: pub fn set_glowing_tag<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: effects: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: value: bool,
    // rust: ) -> Result<(), W::Error> {
    // rust: world.write_glowing_tag(value);
    // rust: let glowing = world.currently_glowing(effects)?;
    // rust: world.set_flag(effects, 6, glowing)
}
    // rust: pub fn update_glowing<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: effects: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: let glowing = world.currently_glowing(effects)?;
    // rust: if world.get_flag(effects, 6)? != glowing {
    // rust: world.set_flag(effects, 6, glowing)?;
}
    // rust: Ok(())
}
    // rust: pub fn update_dirty<H: JavaKey + Clone, W: EffectSyncWorld<H>>(
    // rust: effects: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: if effects.dirty {
    // rust: world.update_invisibility(effects)?;
    // rust: update_glowing(effects, world)?;
    // rust: effects.dirty = false;
}
    // rust: Ok(())
}
