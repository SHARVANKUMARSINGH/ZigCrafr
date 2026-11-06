//! Transpiled from Horizon Rust crate
package horizon_world_stored_effect_attributes

import "core:fmt"
import "core:mem"
import "core:math"

// Effect modifier dispatch bound to a captured attribute map and its instances.
// use crate::{
    // rust: attribute_map::AttributeMap,
    // rust: attributes::Modifier,
    // rust: effect_attribute_modifiers::{self as effects, Definitions, ModifierWorld},
    // rust: object_open_set::ObjectKey,
}

    // rust: pub trait AttributeAccess<H: ObjectKey + Clone, I: ObjectKey + Clone> {
    // rust: type Error;
    // Supplier creation receives the actual map, including pending queues,
    // before the new instance is inserted into its lookup collection.
    // rust: fn create_instance(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<H>,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: attribute: Option<H>,
    // rust: ) -> Result<Option<I>, Self::Error>;
    // rust: fn get_instance(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<H>,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: attribute: Option<H>,
    // rust: ) -> Result<Option<I>, Self::Error> {
    // rust: map.get_instance(attribute, |map, key| {
    // rust: self.create_instance(definitions, map, key)
    // rust: })
}
    // rust: fn remove_modifier(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<H>,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: instance: &I,
    // rust: id: &str,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn add_permanent(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<H>,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: instance: &I,
    // rust: modifier: Modifier,
    // rust: ) -> Result<(), Self::Error>;
}
// The caller captures this map before dispatching the effect's modifier body.
// Instance methods continue to receive it after lookup membership changes.
StoredAttributes :: struct {
    map: ^'a mut AttributeMap<H,
    world: ^'a mut W,
}
    // rust: impl<H: ObjectKey + Clone, I: ObjectKey + Clone, W: AttributeAccess<H, I>> ModifierWorld<H>
    // rust: for StoredAttributes<'_, H, I, W>
    // rust: {
    // rust: type Instance = I;
    // rust: type Error = W::Error;
    // rust: fn get_instance(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<H>,
    // rust: attribute: Option<H>,
    // rust: ) -> Result<Option<I>, Self::Error> {
    // rust: self.world.get_instance(definitions, self.map, attribute)
}
    // rust: fn remove_modifier(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<H>,
    // rust: instance: &I,
    // rust: id: &str,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.world
    // rust: .remove_modifier(definitions, self.map, instance, id)
}
    // rust: fn add_permanent(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<H>,
    // rust: instance: &I,
    // rust: modifier: Modifier,
    // rust: ) -> Result<(), Self::Error> {
    // rust: self.world
    // rust: .add_permanent(definitions, self.map, instance, modifier)
}
}
    // rust: pub fn add<H: ObjectKey + Clone, I: ObjectKey + Clone, W: AttributeAccess<H, I>>(
    // rust: definitions: &mut Definitions<H>,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: world: &mut W,
    // rust: amplifier: i32,
    // rust: ) -> Result<(), effects::Error<W::Error>> {
    // rust: effects::add_modifiers(definitions, &mut StoredAttributes { map, world }, amplifier)
}
    // rust: pub fn remove<H: ObjectKey + Clone, I: ObjectKey + Clone, W: AttributeAccess<H, I>>(
    // rust: definitions: &mut Definitions<H>,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: world: &mut W,
    // rust: ) -> Result<(), effects::Error<W::Error>> {
    // rust: effects::remove_modifiers(definitions, &mut StoredAttributes { map, world })
}
