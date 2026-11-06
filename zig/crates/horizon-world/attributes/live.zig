//! Transpiled from Horizon Rust crate
//! Module: horizon-world_live
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Registered entity attributes backed by live native-order maps and queues.
// use super::{
    // rust: AttributeError, Instance, Modifier, Observer,
    // rust: entity::{AttributeId, Catalog},
}
// use crate::{
    // rust: attribute_map::{AttributeMap, ModifierValueError, QueryWorld, ValueKind},
    // rust: effect_attribute_modifiers::{self as effects, Definitions},
    // rust: object_open_set::{ObjectKey, ObjectOpenSet},
    // rust: stored_effect_attributes::{self as stored, AttributeAccess},
}
// use std::{convert::Infallible, sync::Arc};

pub const Key = struct {
    catalog: *Catalog,
    id: AttributeId,
    hash: i32,
};
    // rust: impl Key {
pub fn attribute(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.id
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.catalog.attribute(self.id).name
}
}
    // rust: impl PartialEq for Key {
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Arc::ptr_eq(&self.catalog, &other.catalog) && self.id == other.id
}
}
    // rust: impl Eq for Key {}
    // rust: impl ObjectKey for Key {
pub fn object_hash(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hash
}
}
pub const Handle = struct {
    owner: *(),
    index: usize,
    hash: i32,
};
    // rust: impl Handle {
pub fn index(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.index
}
}
    // rust: impl PartialEq for Handle {
pub fn eq(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Arc::ptr_eq(&self.owner, &other.owner) && self.index == other.index
}
}
    // rust: impl Eq for Handle {}
    // rust: impl ObjectKey for Handle {
pub fn object_hash(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.hash
}
}
pub const Error = enum {
    UnknownEntity,
    InvalidHolderHashes,
    NullAttribute,
    MissingAttribute,
    MissingModifier,
    MissingInstanceModifier,
    ForeignInstance,
    DuplicateModifier(String),
};
pub const Node = struct {
    handle: Handle,
    key: Key,
    value: Instance,
};
/// Observer for registered attributes. Registry syncability is immutable for
/// this binding; richer virtual attributes can use AttributeMap directly.
pub const Dirty = struct {
    map: *'a mut AttributeMap<Key,
    handle: Handle,
    syncable: bool,
};
    // rust: impl Observer for Dirty<'_> {
    // rust: type Error = Infallible;
pub fn dirty(self: *Self, _: *mut Instance) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map
    // rust: .modified(Some(self.handle.clone()), |_, _| Ok(self.syncable))
}
}
pub const Data = struct {
    catalog: *Catalog,
    bases: *[?f64],
    keys: std.ArrayList(Key),
    owner: *(),
    nodes: std.ArrayList(Node),
    next_identity: G,
};
    // rust: impl<G: FnMut() -> i32> Data<G> {
pub fn base(self: *Self, key: *Key) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Arc::ptr_eq(&self.catalog, &key.catalog)
    // rust: .then(|| self.bases[key.id.index()])
    // rust: .flatten()
}
pub fn node(self: *Self, h: *Handle) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !Arc::ptr_eq(&self.owner, &h.owner) {
    // rust: return Err(Error::ForeignInstance);
}
    // rust: self.nodes.get(h.index).ok_or(Error::ForeignInstance)
}
pub fn node_mut(self: *Self, h: *Handle) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !Arc::ptr_eq(&self.owner, &h.owner) {
    // rust: return Err(Error::ForeignInstance);
}
    // rust: self.nodes.get_mut(h.index).ok_or(Error::ForeignInstance)
}
    // rust: fn create(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<Key, Handle>,
    // rust: key: Option<Key>,
    // rust: ) -> Result<Option<Handle>, Error> {
    // rust: let Some(key) = key else {
    // rust: return Ok(None);
}
    // rust: let Some(base) = self.base(&key) else {
    // rust: return Ok(None);
}
    // rust: let definition = self.catalog.attribute(key.id);
    // rust: let mut source = Instance::new(definition.definition);
        // Registered suppliers have no modifiers. Preserve exported base bits
        // rather than invoking an equality-short-circuiting setter here.
    // rust: source.base = base;
    // rust: let mut value = Instance::new(definition.definition);
    // rust: let handle = Handle {
    // rust: owner: self.owner.clone(),
    // rust: index: self.nodes.len(),
    // rust: hash: (self.next_identity)(),
}
    // rust: let mut observer = Dirty {
    // rust: map,
    // rust: handle: handle.clone(),
    // rust: syncable: definition.syncable,
}
    // rust: value
    // rust: .replace_from(&source, &mut observer)
    // rust: .map_err(convert_error)?;
    // rust: self.nodes.push(Node {
    // rust: key,
    // rust: handle: handle.clone(),
    // rust: value,
    // rust: });
    // rust: Ok(Some(handle))
}
    // rust: fn edit<R>(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<Key, Handle>,
    // rust: handle: &Handle,
    // rust: edit: impl FnOnce(&mut Instance, &mut Dirty<'_>) -> Result<R, AttributeError<Infallible>>,
    // rust: ) -> Result<R, Error> {
    // rust: let node = self.node_mut(handle)?;
    // rust: let syncable = node.key.catalog.attribute(node.key.id).syncable;
    // rust: let mut observer = Dirty {
    // rust: map,
    // rust: handle: handle.clone(),
    // rust: syncable,
}
    // rust: edit(&mut node.value, &mut observer).map_err(convert_error)
}
}
pub fn convert_error(error: AttributeError<Infallible>) E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match error {
    // rust: AttributeError::DuplicateModifier(id) => Error::DuplicateModifier(id),
    // rust: AttributeError::Observer(e) => match e {},
}
}
    // rust: impl<G: FnMut() -> i32> QueryWorld<Key, Handle> for Data<G> {
    // rust: type Error = Error;
    // rust: fn supplier_has_attribute(
    // rust: &mut self,
    // rust: _: &mut AttributeMap<Key, Handle>,
    // rust: key: Option<Key>,
    // rust: ) -> Result<bool, Error> {
    // rust: Ok(key.is_some_and(|k| self.base(&k).is_some()))
}
    // rust: fn supplier_has_modifier(
    // rust: &mut self,
    // rust: _: &mut AttributeMap<Key, Handle>,
    // rust: _: Option<Key>,
    // rust: _: &str,
    // rust: ) -> Result<bool, Error> {
    // rust: Ok(false)
}
    // rust: fn supplier_value(
    // rust: &mut self,
    // rust: _: &mut AttributeMap<Key, Handle>,
    // rust: key: Option<Key>,
    // rust: kind: ValueKind,
    // rust: ) -> Result<f64, Error> {
    // rust: let key = key.ok_or(Error::NullAttribute)?;
    // rust: let base = self.base(&key).ok_or(Error::MissingAttribute)?;
    // rust: Ok(match kind {
    // rust: ValueKind::Base => base,
    // rust: ValueKind::Computed => self.catalog.attribute(key.id).definition.sanitize(base),
    // rust: })
}
    // rust: fn supplier_modifier_value(
    // rust: &mut self,
    // rust: _: &mut AttributeMap<Key, Handle>,
    // rust: key: Option<Key>,
    // rust: _: &str,
    // rust: ) -> Result<f64, Error> {
    // rust: let key = key.ok_or(Error::NullAttribute)?;
    // rust: self.base(&key).ok_or(Error::MissingAttribute)?;
    // rust: Err(Error::MissingModifier)
}
    // rust: fn instance_value(
    // rust: &mut self,
    // rust: _: &mut AttributeMap<Key, Handle>,
    // rust: h: Handle,
    // rust: kind: ValueKind,
    // rust: ) -> Result<f64, Error> {
    // rust: let value = &mut self.node_mut(&h)?.value;
    // rust: Ok(match kind {
    // rust: ValueKind::Computed => value.value(),
    // rust: ValueKind::Base => value.base_value(),
    // rust: })
}
    // rust: fn instance_modifier(
    // rust: &mut self,
    // rust: _: &mut AttributeMap<Key, Handle>,
    // rust: h: Handle,
    // rust: id: &str,
    // rust: ) -> Result<Option<f64>, Error> {
    // rust: Ok(self.node(&h)?.value.modifier(id).map(|m| m.amount()))
}
    // rust: fn set_instance_base(
    // rust: &mut self,
    // rust: map: &mut AttributeMap<Key, Handle>,
    // rust: h: Handle,
    // rust: value: f64,
    // rust: ) -> Result<(), Error> {
    // rust: self.edit(map, &h, |a, o| a.set_base_value(value, o))
}
}
    // rust: impl<G: FnMut() -> i32> AttributeAccess<Key, Handle> for Data<G> {
    // rust: type Error = Error;
    // rust: fn create_instance(
    // rust: &mut self,
    // rust: _: &mut Definitions<Key>,
    // rust: map: &mut AttributeMap<Key, Handle>,
    // rust: key: Option<Key>,
    // rust: ) -> Result<Option<Handle>, Error> {
    // rust: self.create(map, key)
}
    // rust: fn remove_modifier(
    // rust: &mut self,
    // rust: _: &mut Definitions<Key>,
    // rust: map: &mut AttributeMap<Key, Handle>,
    // rust: h: &Handle,
    // rust: id: &str,
    // rust: ) -> Result<(), Error> {
    // rust: self.edit(map, h, |a, o| a.remove(id, o)).map(|_| ())
}
    // rust: fn add_permanent(
    // rust: &mut self,
    // rust: _: &mut Definitions<Key>,
    // rust: map: &mut AttributeMap<Key, Handle>,
    // rust: h: &Handle,
    // rust: modifier: Modifier,
    // rust: ) -> Result<(), Error> {
    // rust: self.edit(map, h, |a, o| a.add_permanent(modifier, o))
}
}
/// An identity allocator that can be copied with its state, so the attributes holding it can be.
    // rust: pub trait Identities: FnMut() -> i32 {
pub fn clone_box(self: *Self) B;
}
    // rust: impl<F: FnMut() -> i32 + Clone + 'static> Identities for F {
pub fn clone_box(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Box::new(self.clone())
}
}
    // rust: impl Clone for Box<dyn Identities> {
pub fn clone(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
        // The boxed allocator's own copy, not a box around this box.
    // rust: (**self).clone_box()
}
}
/// Owns an entity's instances and pending queues. Holder hashes come from the
/// registry runtime; instance hashes come from the supplied identity allocator.
/// Supplying oracle hashes permits reproducible JVM-order differential checks.
pub const LiveAttributes = struct {
    map: AttributeMap<Key,
    data: Data<G>,
};
    // rust: impl<G: FnMut() -> i32> LiveAttributes<G> {
    // rust: pub fn new(
    // rust: catalog: Arc<Catalog>,
    // rust: entity: &str,
    // rust: holder_hashes: &[i32],
    // rust: next_identity: G,
    // rust: ) -> Result<Self, Error> {
    // rust: let bases = catalog.default_bases(entity).ok_or(Error::UnknownEntity)?;
    // rust: if holder_hashes.len() != bases.len() {
    // rust: return Err(Error::InvalidHolderHashes);
}
    // rust: let keys = catalog
    // rust: .attributes()
    // rust: .map(|(id, _)| Key {
    // rust: catalog: catalog.clone(),
    // rust: id,
    // rust: hash: holder_hashes[id.index()],
    // rust: })
    // rust: .collect();
    // rust: Ok(Self {
    // rust: map: AttributeMap::default(),
    // rust: data: Data {
    // rust: catalog,
    // rust: bases,
    // rust: keys,
    // rust: owner: Arc::new(()),
    // rust: nodes: Vec::new(),
    // rust: next_identity,
    // rust: },
    // rust: })
}
pub fn catalog(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.data.catalog
}
pub fn key(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .catalog
    // rust: .id(name)
    // rust: .map(|id| self.data.keys[id.index()].clone())
}
pub fn keys(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.data.keys
}
pub fn lookup(self: *Self, key: ?*Key) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.instances.get(key)
}
pub fn get_instance(self: *Self, key: ?Key) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map
    // rust: .get_instance(key, |map, key| self.data.create(map, key))
}
pub fn has_attribute(self: *Self, key: ?Key) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.has_attribute(key, &mut self.data)
}
pub fn has_modifier(self: *Self, key: ?Key, id: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.has_modifier(key, id, &mut self.data)
}
pub fn value(self: *Self, key: ?Key, kind: ValueKind) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.value(key, kind, &mut self.data)
}
    /// The computed value exactly as the instance's cache holds it, without
    /// recomputing a dirty instance. An absent instance reads its supplier
    /// base, the same fallback `AttributeMap.getValue` uses (only an instance
    /// carries modifiers). Native `AttributeInstance.getValue` is the only
    /// thing that recomputes and clears the dirty flag, so a reader vanilla
    /// performs on some paths only must take this rather than `value`.
pub fn cached_value(self: *Self, key: ?*Key) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(handle) = self.map.instances.get(key) {
    // rust: return Ok(self.data.node(&handle)?.value.cached_value());
}
    // rust: let key = key.ok_or(Error::NullAttribute)?;
    // rust: let base = self.data.base(key).ok_or(Error::MissingAttribute)?;
    // rust: Ok(self
    // rust: .data
    // rust: .catalog
    // rust: .attribute(key.id)
    // rust: .definition
    // rust: .sanitize(base))
}
    /// `cached_value` of the attribute with this registered name.
pub fn cached_value_of(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = self.key(name).ok_or(Error::MissingAttribute)?;
    // rust: self.cached_value(Some(&key))
}
pub fn modifier_value(self: *Self, key: ?Key, id: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map
    // rust: .modifier_value(key, id, &mut self.data)
    // rust: .map_err(|e| match e {
    // rust: ModifierValueError::World(e) => e,
    // rust: ModifierValueError::MissingInstanceModifier => Error::MissingInstanceModifier,
    // rust: })
}
pub fn reset_base(self: *Self, key: ?Key) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.reset_base(key, &mut self.data)
}
pub fn instance(self: *Self, handle: *Handle) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data.node(handle).map(|n| &n.value)
}
pub fn attribute(self: *Self, handle: *Handle) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data.node(handle).map(|n| &n.key)
}
pub fn instances(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .nodes
    // rust: .iter()
    // rust: .map(|n| (&n.handle, &n.key, &n.value))
}
pub fn entries(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map.instances.entries()
}
pub fn updates(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.map.updates
}
pub fn updates_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.map.updates
}
pub fn sync(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.map.sync
}
pub fn sync_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.map.sync
}
    // rust: pub fn edit<R>(
    // rust: &mut self,
    // rust: handle: &Handle,
    // rust: edit: impl FnOnce(&mut Instance, &mut Dirty<'_>) -> Result<R, AttributeError<Infallible>>,
    // rust: ) -> Result<R, Error> {
    // rust: self.data.edit(&mut self.map, handle, edit)
}
    // rust: pub fn add_effect_modifiers(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<Key>,
    // rust: amplifier: i32,
    // rust: ) -> Result<(), effects::Error<Error>> {
    // rust: stored::add(definitions, &mut self.map, &mut self.data, amplifier)
}
    // rust: pub fn remove_effect_modifiers(
    // rust: &mut self,
    // rust: definitions: &mut Definitions<Key>,
    // rust: ) -> Result<(), effects::Error<Error>> {
    // rust: stored::remove(definitions, &mut self.map, &mut self.data)
}
}
