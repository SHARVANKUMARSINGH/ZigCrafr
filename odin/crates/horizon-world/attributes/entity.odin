//! Transpiled from Horizon Rust crate
package horizon_world_entity

import "core:fmt"
import "core:mem"
import "core:math"

// Registered entity defaults and lazy attribute instances. Cross-attribute bulk
// mutation/serialization order is deliberately outside this per-attribute API.
// use super::{Definition, Instance, Observer};
// use crate::{DATA_VERSION, compression::invalid};
// use serde_json::Value;
// use std::{collections::BTreeMap, convert::Infallible, io, sync::Arc};

AttributeId :: struct {
    // rust: impl AttributeId {
    // rust: pub(super) fn index(self) -> usize {
    // rust: self.0
}
    // The attribute's id in the `minecraft:attribute` registry: the catalog
    // export lists `BuiltInRegistries.ATTRIBUTE` in order.
registry_id :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0 as i32
}
}
RegisteredAttribute :: struct {
    name: string,
    definition: Definition,
    syncable: bool,
}
Catalog :: struct {
    attributes: [dynamic]RegisteredAttribute,
    ids: BTreeMap<string,
    defaults: BTreeMap<string,
}
string :: proc(v: ^Value) -> i {
    // Ported from Horizon
    return {}
}
    // rust: v.as_str()
    // rust: .ok_or_else(|| invalid("expected attribute string"))
}
number :: proc(v: ^Value) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let s = string(v)?;
    // rust: if s.len() != 16 {
    // rust: return Err(invalid("expected 16-digit attribute double bits"));
}
    // rust: Ok(f64::from_bits(
    // rust: u64::from_str_radix(s, 16).map_err(|e| invalid(e.to_string()))?,
    // rust: ))
}
    // rust: impl Catalog {
    // rust: pub(super) fn default_bases(&self, entity: &str) -> Option<Arc<[Option<f64>]>> {
    // rust: self.defaults.get(entity).cloned()
}
    // Imports a version-checked export of registered definitions and actual
    // DefaultAttributes suppliers. Defaults contain base values, not instances.
from_json :: proc(v: ^Value) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if v["data_version"].as_i64() != Some(i64::from(DATA_VERSION)) {
    // rust: return Err(invalid("attribute catalog data version mismatch"));
}
    // rust: let mut attributes = Vec::new();
    // rust: let mut ids = BTreeMap::new();
    // rust: for a in v["attributes"]
    // rust: .as_array()
    // rust: .ok_or_else(|| invalid("missing attributes"))?
    // rust: {
    // rust: let name = string(&a["id"])?;
            // Identifier normalization is shared with modifier IDs.
    // rust: let canonical = super::Modifier::new(name, 0.0, super::Operation::AddValue)?;
    // rust: if canonical.id() != name
    // rust: || ids
    // rust: .insert(name.into(), AttributeId(attributes.len()))
    // rust: .is_some()
    // rust: {
    // rust: return Err(invalid("noncanonical or duplicate attribute identifier"));
}
    // rust: let default = number(&a["default"])?;
    // rust: let definition = if a.get("min").is_some() {
    // rust: Definition::ranged(default, number(&a["min"])?, number(&a["max"])?)?
    // rust: } else {
    // rust: Definition::basic(default)
}
    // rust: attributes.push(RegisteredAttribute {
    // rust: name: name.into(),
    // rust: definition,
    // rust: syncable: a["syncable"]
    // rust: .as_bool()
    // rust: .ok_or_else(|| invalid("missing attribute sync flag"))?,
    // rust: });
}
    // rust: let mut defaults = BTreeMap::new();
    // rust: for (entity, values) in v["entities"]
    // rust: .as_object()
    // rust: .ok_or_else(|| invalid("missing entity defaults"))?
    // rust: {
    // rust: let mut bases = vec![None; attributes.len()];
    // rust: for (name, base) in values
    // rust: .as_object()
    // rust: .ok_or_else(|| invalid("invalid entity supplier"))?
    // rust: {
    // rust: let id = ids
    // rust: .get(name)
    // rust: .ok_or_else(|| invalid("unknown supplier attribute"))?;
    // rust: bases[id.0] = Some(number(base)?);
}
    // rust: defaults.insert(entity.clone(), Arc::from(bases));
}
    // rust: Ok(Self {
    // rust: attributes,
    // rust: ids,
    // rust: defaults,
    // rust: })
}
    // The entity type's supplier base of an attribute, if the type has it.
default_base :: proc(self: ^Self, entity: string, id: AttributeId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.defaults.get(entity).and_then(|b| b[id.0])
}
id :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.ids.get(name).copied()
}
attribute :: proc(self: ^Self, id: AttributeId) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.attributes[id.0]
}
attributes :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.attributes
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, a)| (AttributeId(i), a))
}
entities :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.defaults.keys().map(String::as_str)
}
create :: proc(self: ^^Self, entity: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let bases = self.defaults.get(entity)?.clone();
    // rust: let n = bases.len();
    // rust: Some(EntityAttributes {
    // rust: catalog: self.clone(),
    // rust: bases,
    // rust: instances: vec![None; n],
    // rust: updates: vec![false; n],
    // rust: sync: vec![false; n],
    // rust: })
}
}
LookupError :: enum {
    MissingAttribute,
    MissingModifier,
    InstanceMissingModifier,
}
// Membership in the native update/sync sets, with no JVM identity-hash order
// promise. Clearing a flag acknowledges that particular pending update.
DirtyObserver :: struct {
    update: ^'a mut bool,
    sync: ^'a mut bool,
    syncable: bool,
}
    // rust: impl Observer for DirtyObserver<'_> {
    // rust: type Error = Infallible;
dirty :: proc(self: ^Self, _: ^Instance) -> R {
    // Ported from Horizon
    return {}
}
    // rust: *self.update = true;
    // rust: if self.syncable {
    // rust: *self.sync = true;
}
    // rust: Ok(())
}
}
EntityAttributes :: struct {
    catalog: ^Catalog,
    bases: ^[Maybe(f64)],
    instances: [dynamic]Maybe(^Instance),
    updates: [dynamic]bool,
    sync: [dynamic]bool,
}
    // rust: impl EntityAttributes {
catalog :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.catalog
}
has :: proc(self: ^Self, id: AttributeId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.bases[id.0].is_some()
}
instance :: proc(self: ^Self, id: AttributeId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.instances[id.0].as_deref()
}
    // Merely querying a default value must not instantiate or dirty it.
value :: proc(self: ^Self, id: AttributeId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(a) = self.instances[id.0].as_deref_mut() {
    // rust: return Ok(a.value());
}
    // rust: let base = self.bases[id.0].ok_or(LookupError::MissingAttribute)?;
    // rust: Ok(self.catalog.attribute(id).definition.sanitize(base))
}
base_value :: proc(self: ^Self, id: AttributeId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.instances[id.0]
    // rust: .as_deref()
    // rust: .map(Instance::base_value)
    // rust: .or(self.bases[id.0])
    // rust: .ok_or(LookupError::MissingAttribute)
}
has_modifier :: proc(self: ^Self, id: AttributeId, modifier: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.instance(id)
    // rust: .and_then(|a| a.modifier(modifier))
    // rust: .is_some()
}
modifier_value :: proc(self: ^Self, id: AttributeId, modifier: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(a) = self.instance(id) {
    // rust: return a
    // rust: .modifier(modifier)
    // rust: .map(super::Modifier::amount)
    // rust: .ok_or(LookupError::InstanceMissingModifier);
}
    // rust: if self.has(id) {
    // rust: Err(LookupError::MissingModifier)
    // rust: } else {
    // rust: Err(LookupError::MissingAttribute)
}
}
    // Native getInstance copies the supplier on first access and immediately
    // schedules an update, plus a sync when the definition is client-syncable.
ensure :: proc(self: ^Self, id: AttributeId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.instances[id.0].is_some() {
    // rust: return true;
}
    // rust: let Some(base) = self.bases[id.0] else {
    // rust: return false;
}
    // rust: let definition = self.catalog.attribute(id);
    // rust: let mut instance = Instance::new(definition.definition);
    // rust: let mut observer = DirtyObserver {
    // rust: update: &mut self.updates[id.0],
    // rust: sync: &mut self.sync[id.0],
    // rust: syncable: definition.syncable,
}
        // Registered default suppliers have no modifiers. replaceFrom always
        // invalidates even when the supplier base equals the registered default.
    // rust: let mut source = Instance::new(definition.definition);
    // rust: source.base = base;
    // rust: instance.replace_from(&source, &mut observer).unwrap();
    // rust: self.instances[id.0] = Some(Box::new(instance));
    // rust: true
}
    // Mutations must use the supplied observer to preserve dirty memberships.
    // rust: pub fn edit<R>(
    // rust: &mut self,
    // rust: id: AttributeId,
    // rust: f: impl FnOnce(&mut Instance, &mut DirtyObserver<'_>) -> R,
    // rust: ) -> Option<R> {
    // rust: if !self.ensure(id) {
    // rust: return None;
}
    // rust: let mut observer = DirtyObserver {
    // rust: update: &mut self.updates[id.0],
    // rust: sync: &mut self.sync[id.0],
    // rust: syncable: self.catalog.attribute(id).syncable,
}
    // rust: Some(f(
    // rust: self.instances[id.0].as_deref_mut().unwrap(),
    // rust: &mut observer,
    // rust: ))
}
    // Reset uses the entity supplier's base, without creating a missing instance.
reset_base :: proc(self: ^Self, id: AttributeId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(base) = self.bases[id.0] else {
    // rust: return false;
}
    // rust: if self.instances[id.0].is_some() {
    // rust: self.edit(id, |a, o| a.set_base_value(base, o).unwrap());
}
    // rust: true
}
needs_update :: proc(self: ^Self, id: AttributeId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.updates[id.0]
}
needs_sync :: proc(self: ^Self, id: AttributeId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sync[id.0]
}
clear_update :: proc(self: ^Self, id: AttributeId) {
}
    // rust: self.updates[id.0] = false;
}
clear_sync :: proc(self: ^Self, id: AttributeId) {
}
    // rust: self.sync[id.0] = false;
}
}
