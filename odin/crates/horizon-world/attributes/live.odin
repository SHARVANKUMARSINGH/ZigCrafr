//! Transpiled from Horizon Rust crate
package horizon_world_live

import "core:fmt"
import "core:mem"
import "core:math"

// Registered entity attributes backed by live native-order maps and queues.
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

Key :: struct {
    catalog: ^Catalog,
    id: AttributeId,
    hash: i32,
}
    // rust: impl Key {
attribute :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.catalog.attribute(self.id).name
}
}
    // rust: impl PartialEq for Key {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Arc::ptr_eq(&self.catalog, &other.catalog) && self.id == other.id
}
}
    // rust: impl Eq for Key {}
    // rust: impl ObjectKey for Key {
object_hash :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.hash
}
}
Handle :: struct {
    owner: ^(),
    index: uint,
    hash: i32,
}
    // rust: impl Handle {
index :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.index
}
}
    // rust: impl PartialEq for Handle {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Arc::ptr_eq(&self.owner, &other.owner) && self.index == other.index
}
}
    // rust: impl Eq for Handle {}
    // rust: impl ObjectKey for Handle {
object_hash :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.hash
}
}
Error :: enum {
    UnknownEntity,
    InvalidHolderHashes,
    NullAttribute,
    MissingAttribute,
    MissingModifier,
    MissingInstanceModifier,
    ForeignInstance,
    DuplicateModifier(String),
}
Node :: struct {
    handle: Handle,
    key: Key,
    value: Instance,
}
// Observer for registered attributes. Registry syncability is immutable for
// this binding; richer virtual attributes can use AttributeMap directly.
Dirty :: struct {
    map: ^'a mut AttributeMap<Key,
    handle: Handle,
    syncable: bool,
}
    // rust: impl Observer for Dirty<'_> {
    // rust: type Error = Infallible;
dirty :: proc(self: ^Self, _: ^Instance) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.map
    // rust: .modified(Some(self.handle.clone()), |_, _| Ok(self.syncable))
}
}
Data :: struct {
    catalog: ^Catalog,
    bases: ^[Maybe(f64)],
    keys: [dynamic]Key,
    owner: ^(),
    nodes: [dynamic]Node,
    next_identity: G,
}
    // rust: impl<G: FnMut() -> i32> Data<G> {
base :: proc(self: ^Self, key: ^Key) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Arc::ptr_eq(&self.catalog, &key.catalog)
    // rust: .then(|| self.bases[key.id.index()])
    // rust: .flatten()
}
node :: proc(self: ^Self, h: ^Handle) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !Arc::ptr_eq(&self.owner, &h.owner) {
    // rust: return Err(Error::ForeignInstance);
}
    // rust: self.nodes.get(h.index).ok_or(Error::ForeignInstance)
}
node_mut :: proc(self: ^Self, h: ^Handle) -> R {
    // Ported from Horizon
    return {}
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
convert_error :: proc(error: AttributeError<Infallible>) -> E {
    // Ported from Horizon
    return {}
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
// An identity allocator that can be copied with its state, so the attributes holding it can be.
    // rust: pub trait Identities: FnMut() -> i32 {
clone_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
}
    // rust: impl<F: FnMut() -> i32 + Clone + 'static> Identities for F {
clone_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: Box::new(self.clone())
}
}
    // rust: impl Clone for Box<dyn Identities> {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
        // The boxed allocator's own copy, not a box around this box.
    // rust: (**self).clone_box()
}
}
// Owns an entity's instances and pending queues. Holder hashes come from the
// registry runtime; instance hashes come from the supplied identity allocator.
// Supplying oracle hashes permits reproducible JVM-order differential checks.
LiveAttributes :: struct {
    map: AttributeMap<Key,
    data: Data<G>,
}
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
catalog :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.data.catalog
}
key :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.data
    // rust: .catalog
    // rust: .id(name)
    // rust: .map(|id| self.data.keys[id.index()].clone())
}
keys :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.data.keys
}
lookup :: proc(self: ^Self, key: Maybe(^Key)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.map.instances.get(key)
}
get_instance :: proc(self: ^Self, key: Maybe(Key)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.map
    // rust: .get_instance(key, |map, key| self.data.create(map, key))
}
has_attribute :: proc(self: ^Self, key: Maybe(Key)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.map.has_attribute(key, &mut self.data)
}
has_modifier :: proc(self: ^Self, key: Maybe(Key), id: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.map.has_modifier(key, id, &mut self.data)
}
value :: proc(self: ^Self, key: Maybe(Key), kind: ValueKind) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.map.value(key, kind, &mut self.data)
}
    // The computed value exactly as the instance's cache holds it, without
    // recomputing a dirty instance. An absent instance reads its supplier
    // base, the same fallback `AttributeMap.getValue` uses (only an instance
    // carries modifiers). Native `AttributeInstance.getValue` is the only
    // thing that recomputes and clears the dirty flag, so a reader vanilla
    // performs on some paths only must take this rather than `value`.
cached_value :: proc(self: ^Self, key: Maybe(^Key)) -> R {
    // Ported from Horizon
    return {}
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
    // `cached_value` of the attribute with this registered name.
cached_value_of :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let key = self.key(name).ok_or(Error::MissingAttribute)?;
    // rust: self.cached_value(Some(&key))
}
modifier_value :: proc(self: ^Self, key: Maybe(Key), id: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.map
    // rust: .modifier_value(key, id, &mut self.data)
    // rust: .map_err(|e| match e {
    // rust: ModifierValueError::World(e) => e,
    // rust: ModifierValueError::MissingInstanceModifier => Error::MissingInstanceModifier,
    // rust: })
}
reset_base :: proc(self: ^Self, key: Maybe(Key)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.map.reset_base(key, &mut self.data)
}
instance :: proc(self: ^Self, handle: ^Handle) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.data.node(handle).map(|n| &n.value)
}
attribute :: proc(self: ^Self, handle: ^Handle) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.data.node(handle).map(|n| &n.key)
}
instances :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.data
    // rust: .nodes
    // rust: .iter()
    // rust: .map(|n| (&n.handle, &n.key, &n.value))
}
entries :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.map.instances.entries()
}
updates :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.map.updates
}
updates_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.map.updates
}
sync :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.map.sync
}
sync_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
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
