//! Transpiled from Horizon Rust crate
package horizon_world_attribute_map

import "core:fmt"
import "core:mem"
import "core:math"

// Live AttributeMap instance lookup and update/synchronization queue ownership.
// use crate::{
    // rust: object_open_map::ObjectOpenMap,
    // rust: object_open_set::{ObjectKey, ObjectOpenSet},
}

ValueKind :: enum {
    Computed,
    Base,
}
ModifierValueError :: enum {
    // Cached instances dereference getModifier's result; suppliers instead
    // report their own missing-attribute/modifier error.
    MissingInstanceModifier,
    World(E),
}
    // rust: pub trait QueryWorld<H, I> {
    // rust: type Error;
    // rust: fn supplier_has_attribute(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: key: Option<H>,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn supplier_has_modifier(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: key: Option<H>,
    // rust: id: &str,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn supplier_value(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: key: Option<H>,
    // rust: kind: ValueKind,
    // rust: ) -> Result<f64, Self::Error>;
    // rust: fn supplier_modifier_value(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: key: Option<H>,
    // rust: id: &str,
    // rust: ) -> Result<f64, Self::Error>;
    // rust: fn instance_value(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: instance: I,
    // rust: kind: ValueKind,
    // rust: ) -> Result<f64, Self::Error>;
    // rust: fn instance_modifier(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: instance: I,
    // rust: id: &str,
    // rust: ) -> Result<Option<f64>, Self::Error>;
    // rust: fn set_instance_base(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<H, I>,
    // rust: instance: I,
    // rust: value: f64,
    // rust: ) -> Result<(), Self::Error>;
}

// Instance handles retain identity independently of map membership. In
// particular, a failed creation callback can leave a queued instance that was
// never inserted into `instances`.
AttributeMap :: struct {
    instances: ObjectOpenMap<H,
    updates: ObjectOpenSet<I>,
    sync: ObjectOpenSet<I>,
}
    // rust: impl<H, I> Default for AttributeMap<H, I> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: instances: ObjectOpenMap::default(),
    // rust: updates: ObjectOpenSet::default(),
    // rust: sync: ObjectOpenSet::default(),
}
}
}
    // rust: impl<H: ObjectKey + Clone, I: ObjectKey + Clone> AttributeMap<H, I> {
    // rust: pub fn has_attribute<W: QueryWorld<H, I>>(
    // rust: &mut self,
    // rust: key: Option<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if self.instances.get(key.as_ref()).is_some() {
    // rust: Ok(true)
    // rust: } else {
    // rust: world.supplier_has_attribute(self, key)
}
}
    // rust: pub fn has_modifier<W: QueryWorld<H, I>>(
    // rust: &mut self,
    // rust: key: Option<H>,
    // rust: id: &str,
    // rust: world: &mut W,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if let Some(instance) = self.instances.get(key.as_ref()) {
    // rust: world
    // rust: .instance_modifier(self, instance, id)
    // rust: .map(|m| m.is_some())
    // rust: } else {
    // rust: world.supplier_has_modifier(self, key, id)
}
}
    // Value queries use a cached instance or its supplier prototype. They do
    // not create an instance or schedule a dirty update.
    // rust: pub fn value<W: QueryWorld<H, I>>(
    // rust: &mut self,
    // rust: key: Option<H>,
    // rust: kind: ValueKind,
    // rust: world: &mut W,
    // rust: ) -> Result<f64, W::Error> {
    // rust: if let Some(instance) = self.instances.get(key.as_ref()) {
    // rust: world.instance_value(self, instance, kind)
    // rust: } else {
    // rust: world.supplier_value(self, key, kind)
}
}
    // rust: pub fn modifier_value<W: QueryWorld<H, I>>(
    // rust: &mut self,
    // rust: key: Option<H>,
    // rust: id: &str,
    // rust: world: &mut W,
    // rust: ) -> Result<f64, ModifierValueError<W::Error>> {
    // rust: if let Some(instance) = self.instances.get(key.as_ref()) {
    // rust: world
    // rust: .instance_modifier(self, instance, id)
    // rust: .map_err(ModifierValueError::World)?
    // rust: .ok_or(ModifierValueError::MissingInstanceModifier)
    // rust: } else {
    // rust: world
    // rust: .supplier_modifier_value(self, key, id)
    // rust: .map_err(ModifierValueError::World)
}
}
    // rust: pub fn reset_base<W: QueryWorld<H, I>>(
    // rust: &mut self,
    // rust: key: Option<H>,
    // rust: world: &mut W,
    // rust: ) -> Result<bool, W::Error> {
    // rust: if !world.supplier_has_attribute(self, key.clone())? {
    // rust: return Ok(false);
}
    // rust: if let Some(instance) = self.instances.get(key.as_ref()) {
    // rust: let value = world.supplier_value(self, key, ValueKind::Base)?;
    // rust: world.set_instance_base(self, instance, value)?;
}
    // rust: Ok(true)
}
    // AttributeMap dispatches to Map.computeIfAbsent(Function), not fastutil's
    // Object2ObjectFunction overload. A null mapping is absent for this call;
    // the ordinary put re-finds its slot after the supplier callback returns.
    // rust: pub fn get_instance<E>(
    // rust: &mut self,
    // rust: key: Option<H>,
    // rust: create: impl FnOnce(&mut Self, Option<H>) -> Result<Option<I>, E>,
    // rust: ) -> Result<Option<I>, E> {
    // rust: if let Some(instance) = self.instances.get(key.as_ref()) {
    // rust: return Ok(Some(instance));
}
    // rust: let instance = create(self, key.clone())?;
    // rust: if instance.is_some() {
    // rust: self.instances.put(key, instance.clone());
}
    // rust: Ok(instance)
}
    // The callback performs instance.getAttribute().value().isClientSyncable().
    // It runs after adding the update entry, and can inspect or mutate both
    // queues. Failure preserves the update entry and skips the sync insertion.
    // rust: pub fn modified<E>(
    // rust: &mut self,
    // rust: instance: Option<I>,
    // rust: syncable: impl FnOnce(&mut Self, Option<I>) -> Result<bool, E>,
    // rust: ) -> Result<(), E> {
    // rust: self.updates.add(instance.clone());
    // rust: if syncable(self, instance.clone())? {
    // rust: self.sync.add(instance);
}
    // rust: Ok(())
}
}
