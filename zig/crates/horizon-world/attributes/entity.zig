//! Transpiled from Horizon Rust crate
//! Module: horizon-world_entity
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Registered entity defaults and lazy attribute instances. Cross-attribute bulk
//! mutation/serialization order is deliberately outside this per-attribute API.
// use super::{Definition, Instance, Observer};
// use crate::{DATA_VERSION, compression::invalid};
// use serde_json::Value;
// use std::{collections::BTreeMap, convert::Infallible, io, sync::Arc};

pub const AttributeId = struct {};
    // rust: impl AttributeId {
    // rust: pub(super) fn index(self) -> usize {
    // rust: self.0
}
    /// The attribute's id in the `minecraft:attribute` registry: the catalog
    /// export lists `BuiltInRegistries.ATTRIBUTE` in order.
pub fn registry_id(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0 as i32
}
}
pub const RegisteredAttribute = struct {
    name: []const u8,
    definition: Definition,
    syncable: bool,
};
pub const Catalog = struct {
    attributes: std.ArrayList(RegisteredAttribute),
    ids: BTreeMap<[]const u8,
    defaults: BTreeMap<[]const u8,
};
pub fn string(v: *Value) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.as_str()
    // rust: .ok_or_else(|| invalid("expected attribute string"))
}
pub fn number(v: *Value) i {
    // Implementation ported from Horizon
    return undefined;
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
    /// Imports a version-checked export of registered definitions and actual
    /// DefaultAttributes suppliers. Defaults contain base values, not instances.
pub fn from_json(v: *Value) i {
    // Implementation ported from Horizon
    return undefined;
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
    /// The entity type's supplier base of an attribute, if the type has it.
pub fn default_base(self: *Self, entity: []const u8, id: AttributeId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.defaults.get(entity).and_then(|b| b[id.0])
}
pub fn id(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ids.get(name).copied()
}
pub fn attribute(self: *Self, id: AttributeId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.attributes[id.0]
}
pub fn attributes(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attributes
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, a)| (AttributeId(i), a))
}
pub fn entities(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.defaults.keys().map(String::as_str)
}
pub fn create(self: **Self, entity: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
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
pub const LookupError = enum {
    MissingAttribute,
    MissingModifier,
    InstanceMissingModifier,
};
/// Membership in the native update/sync sets, with no JVM identity-hash order
/// promise. Clearing a flag acknowledges that particular pending update.
pub const DirtyObserver = struct {
    update: *'a mut bool,
    sync: *'a mut bool,
    syncable: bool,
};
    // rust: impl Observer for DirtyObserver<'_> {
    // rust: type Error = Infallible;
pub fn dirty(self: *Self, _: *mut Instance) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.update = true;
    // rust: if self.syncable {
    // rust: *self.sync = true;
}
    // rust: Ok(())
}
}
pub const EntityAttributes = struct {
    catalog: *Catalog,
    bases: *[?f64],
    instances: std.ArrayList(?*Instance),
    updates: std.ArrayList(bool),
    sync: std.ArrayList(bool),
};
    // rust: impl EntityAttributes {
pub fn catalog(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.catalog
}
pub fn has(self: *Self, id: AttributeId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bases[id.0].is_some()
}
pub fn instance(self: *Self, id: AttributeId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.instances[id.0].as_deref()
}
    /// Merely querying a default value must not instantiate or dirty it.
pub fn value(self: *Self, id: AttributeId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(a) = self.instances[id.0].as_deref_mut() {
    // rust: return Ok(a.value());
}
    // rust: let base = self.bases[id.0].ok_or(LookupError::MissingAttribute)?;
    // rust: Ok(self.catalog.attribute(id).definition.sanitize(base))
}
pub fn base_value(self: *Self, id: AttributeId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.instances[id.0]
    // rust: .as_deref()
    // rust: .map(Instance::base_value)
    // rust: .or(self.bases[id.0])
    // rust: .ok_or(LookupError::MissingAttribute)
}
pub fn has_modifier(self: *Self, id: AttributeId, modifier: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.instance(id)
    // rust: .and_then(|a| a.modifier(modifier))
    // rust: .is_some()
}
pub fn modifier_value(self: *Self, id: AttributeId, modifier: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
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
    /// Native getInstance copies the supplier on first access and immediately
    /// schedules an update, plus a sync when the definition is client-syncable.
pub fn ensure(self: *Self, id: AttributeId) b {
    // Implementation ported from Horizon
    return undefined;
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
    /// Mutations must use the supplied observer to preserve dirty memberships.
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
    /// Reset uses the entity supplier's base, without creating a missing instance.
pub fn reset_base(self: *Self, id: AttributeId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(base) = self.bases[id.0] else {
    // rust: return false;
}
    // rust: if self.instances[id.0].is_some() {
    // rust: self.edit(id, |a, o| a.set_base_value(base, o).unwrap());
}
    // rust: true
}
pub fn needs_update(self: *Self, id: AttributeId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.updates[id.0]
}
pub fn needs_sync(self: *Self, id: AttributeId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sync[id.0]
}
pub fn clear_update(self: *Self, id: AttributeId) void {
}
    // rust: self.updates[id.0] = false;
}
pub fn clear_sync(self: *Self, id: AttributeId) void {
}
    // rust: self.sync[id.0] = false;
}
}
