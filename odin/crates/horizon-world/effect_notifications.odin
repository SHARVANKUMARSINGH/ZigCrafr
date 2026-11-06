//! Transpiled from Horizon Rust crate
package horizon_world_effect_notifications

import "core:fmt"
import "core:mem"
import "core:math"

// Base LivingEntity effect eligibility, attribute refresh and passenger updates.
// use crate::{
    // rust: active_effects::{ActiveEffects, EffectHooks},
    // rust: java_hash_map::JavaKey,
    // rust: object_open_set::{CursorError, ObjectKey, ObjectOpenSet},
    // rust: status_effect::EffectInstance,
}
ImmunityTag :: enum {
    Infested,
    Oozing,
    PoisonAndRegeneration,
}
RestrictedEffect :: enum {
    Infested,
    Oozing,
    Regeneration,
    Poison,
}
    // rust: pub trait EligibilityWorld<H> {
    // rust: type Error;
    // rust: fn has_immunity_tag(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: tag: ImmunityTag,
    // rust: ) -> Result<bool, Self::Error>;
is_restricted_effect :: proc(self: ^Self, effect: ^H, kind: RestrictedEffect) -> b {
    // Ported from Horizon
    return {}
}
}
    // rust: pub fn can_be_affected<H, W: EligibilityWorld<H>>(
    // rust: storage: &mut ActiveEffects<H>,
    // rust: instance: &EffectInstance<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<bool, W::Error> {
    // These branches are exclusive, even when the actor belongs to several tags.
    // rust: if world.has_immunity_tag(storage, ImmunityTag::Infested)? {
    // rust: Ok(!world.is_restricted_effect(&instance.read().effect, RestrictedEffect::Infested))
    // rust: } else if world.has_immunity_tag(storage, ImmunityTag::Oozing)? {
    // rust: Ok(!world.is_restricted_effect(&instance.read().effect, RestrictedEffect::Oozing))
    // rust: } else if world.has_immunity_tag(storage, ImmunityTag::PoisonAndRegeneration)? {
    // rust: let data = instance.read();
    // rust: Ok(
    // rust: !world.is_restricted_effect(&data.effect, RestrictedEffect::Regeneration)
    // rust: && !world.is_restricted_effect(&data.effect, RestrictedEffect::Poison),
    // rust: )
    // rust: } else {
    // rust: Ok(true)
}
}

EffectPacket :: enum {
    Update {,
    entity: i32,
    effect: H,
    amplifier: i32,
    duration: i32,
    flags: u8,
    // rust: },
    Remove {,
    entity: i32,
    effect: H,
    // rust: },
}
    // rust: impl<H: Clone> EffectPacket<H> {
update :: proc(entity: i32, instance: ^EffectInstance<H>, blend: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let data = instance.read();
    // rust: Self::Update {
    // rust: entity,
    // rust: effect: data.effect.clone(),
    // rust: amplifier: data.details.amplifier,
    // rust: duration: data.details.duration,
    // rust: flags: u8::from(data.details.ambient)
    // rust: | (u8::from(data.details.visible) << 1)
    // rust: | (u8::from(data.details.show_icon) << 2)
    // rust: | (u8::from(blend) << 3),
}
}
}
// Attribute maps, pending-update sets and connections are stable handles. A
// callback may switch the actor's current handle without changing a captured one.
    // rust: pub trait NotificationWorld<H: JavaKey + Clone>: EffectHooks<H> {
    // rust: type Attributes: Copy;
    // rust: type UpdateSet: Copy;
    // rust: type AttributeInstance: ObjectKey + Clone;
    // rust: type Attribute;
    // rust: type Passenger: Copy;
    // rust: type Connection: Copy;
    // rust: fn attributes(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: ) -> Result<Self::Attributes, Self::Error>;
    // rust: fn add_modifiers(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: effect: H,
    // rust: attributes: Self::Attributes,
    // rust: amplifier: i32,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn remove_modifiers(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: effect: H,
    // rust: attributes: Self::Attributes,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn pending_updates(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: attributes: Self::Attributes,
    // rust: ) -> Result<Self::UpdateSet, Self::Error>;
update_set :: proc(self: ^Self, set: Self::UpdateSet) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: fn update_set_mut(
    // rust: &mut self,
    // rust: set: Self::UpdateSet,
    // rust: ) -> &mut ObjectOpenSet<Self::AttributeInstance>;
iterator_error :: proc(error: CursorError) -> S {
    // Ported from Horizon
    return {}
}
    // None preserves a native null member's failure at getAttribute.
    // rust: fn attribute_of(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: instance: Option<Self::AttributeInstance>,
    // rust: ) -> Result<Self::Attribute, Self::Error>;
    // rust: fn attribute_updated(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: attribute: Self::Attribute,
    // rust: ) -> Result<(), Self::Error>;
    // Entity.getPassengers is final and returns its current immutable list.
passengers :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
is_server_player :: proc(self: ^Self, passenger: Self::Passenger) -> b {
    // Ported from Horizon
    return {}
}
    // Direct ServerPlayer.connection field access before the virtual getId call.
connection :: proc(self: ^Self, passenger: Self::Passenger) -> S {
    // Ported from Horizon
    return {}
}
entity_id :: proc(self: ^Self, storage: ^ActiveEffects<H>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn send_packet(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: connection: Self::Connection,
    // rust: packet: EffectPacket<H>,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn send_effect_to_passengers(
    // rust: &mut self,
    // rust: storage: &mut ActiveEffects<H>,
    // rust: instance: &EffectInstance<H>,
    // rust: ) -> Result<(), Self::Error>
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: send_to_passengers(storage, instance, self)
}
}
    // rust: pub fn send_to_passengers<H: JavaKey + Clone, W: NotificationWorld<H>>(
    // rust: storage: &mut ActiveEffects<H>,
    // rust: instance: &EffectInstance<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: for passenger in world.passengers() {
    // rust: if world.is_server_player(passenger) {
    // rust: let connection = world.connection(passenger);
    // rust: let entity = world.entity_id(storage)?;
    // rust: let packet = EffectPacket::update(entity, instance, false);
    // rust: world.send_packet(storage, connection, packet)?;
}
}
    // rust: Ok(())
}
    // rust: pub fn refresh_attributes<H: JavaKey + Clone, W: NotificationWorld<H>>(
    // rust: storage: &mut ActiveEffects<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: let attributes = world.attributes(storage)?;
    // rust: let updates = world.pending_updates(storage, attributes)?;
    // rust: let mut cursor = world.update_set(updates).cursor();
    // rust: while cursor.has_next() {
    // rust: let instance = world
    // rust: .update_set(updates)
    // rust: .next(&mut cursor)
    // rust: .map_err(W::iterator_error)?;
    // rust: let attribute = world.attribute_of(storage, instance)?;
    // rust: world.attribute_updated(storage, attribute)?;
}
    // rust: world.update_set_mut(updates).clear();
    // rust: Ok(())
}
    // rust: pub fn on_added<H: JavaKey + Clone, W: NotificationWorld<H>>(
    // rust: storage: &mut ActiveEffects<H>,
    // rust: instance: &EffectInstance<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: let level = world.level(storage)?;
    // rust: if !world.is_client(storage, level)? {
    // rust: storage.dirty = true;
    // rust: let effect = instance.read().effect.clone();
    // rust: let attributes = world.attributes(storage)?;
    // rust: let amplifier = instance.read().details.amplifier;
    // rust: world.add_modifiers(storage, effect, attributes, amplifier)?;
    // rust: world.send_effect_to_passengers(storage, instance)?;
}
    // rust: Ok(())
}
    // rust: pub fn on_updated<H: JavaKey + Clone, W: NotificationWorld<H>>(
    // rust: storage: &mut ActiveEffects<H>,
    // rust: instance: &EffectInstance<H>,
    // rust: reapply: bool,
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: let level = world.level(storage)?;
    // rust: if world.is_client(storage, level)? {
    // rust: return Ok(());
}
    // rust: storage.dirty = true;
    // rust: if reapply {
    // rust: let effect = instance.read().effect.clone();
    // rust: let attributes = world.attributes(storage)?;
    // rust: world.remove_modifiers(storage, effect.clone(), attributes)?;
    // rust: let attributes = world.attributes(storage)?;
    // rust: let amplifier = instance.read().details.amplifier;
    // rust: world.add_modifiers(storage, effect, attributes, amplifier)?;
    // rust: refresh_attributes(storage, world)?;
}
    // rust: world.send_effect_to_passengers(storage, instance)
}
    // rust: pub fn on_removed<H: JavaKey + Clone, W: NotificationWorld<H>>(
    // rust: storage: &mut ActiveEffects<H>,
    // rust: instances: &[EffectInstance<H>],
    // rust: world: &mut W,
    // rust: ) -> Result<(), W::Error> {
    // rust: let level = world.level(storage)?;
    // rust: if world.is_client(storage, level)? {
    // rust: return Ok(());
}
    // rust: storage.dirty = true;
    // rust: for instance in instances {
    // rust: let effect = instance.read().effect.clone();
    // rust: let attributes = world.attributes(storage)?;
    // rust: world.remove_modifiers(storage, effect, attributes)?;
    // rust: for passenger in world.passengers() {
    // rust: if world.is_server_player(passenger) {
    // rust: let connection = world.connection(passenger);
    // rust: let entity = world.entity_id(storage)?;
    // rust: let effect = instance.read().effect.clone();
    // rust: world.send_packet(storage, connection, EffectPacket::Remove { entity, effect })?;
}
}
}
    // rust: refresh_attributes(storage, world)
}
