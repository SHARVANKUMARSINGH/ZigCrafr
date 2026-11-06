//! Transpiled from Horizon Rust crate
package horizon_world_attachments

import "core:fmt"
import "core:mem"
import "core:math"

// Typed native-mod data attached to server-owned holders.
// use std::{
    // rust: any::Any,
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fmt,
}

// use crate::nbt::{Compound, JavaString, Tag};

// An attachment operation could not be completed.
AttachmentError :: enum {
    // The holder does not exist or is unavailable on this side.
    MissingHolder,
    // The key was used with a different Rust type.
    TypeMismatch,
    // The saved value could not be decoded.
    Decode,
    // The value could not be encoded.
    Encode,
    // A namespace in the saved compound is not a compound.
    InvalidNamespace,
    // Copy-on-death requires a serializer.
    InvalidCopyPolicy,
    // Syncing to clients requires a serializer.
    InvalidSyncPolicy,
}

// NBT key reserved for server-owned attachment maps.
ATTACHMENTS_KEY :: "horizon:attachments"

// Read the reserved compound without replacing an invalid saved value.
attachment_compound :: proc(tag: Maybe(^Tag)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match tag {
    // rust: None => Ok(None),
    // rust: Some(Tag::Compound(compound)) => Ok(Some(compound)),
    // rust: Some(_) => Err(AttachmentError::InvalidNamespace),
}
}

// A server holder in the host's current dimension.
Holder :: enum {
    Entity(u32),
    Player(u128),
    BlockEntity([i32; 3]),
    Chunk([i32; 2]),
    Level,
}

// Object-safe access to the current server's holders.
    // rust: pub trait AttachmentHost {
attachments :: proc(self: ^Self, holder: Holder) -> R {
    // Ported from Horizon
    return {}
}
}

// The optional on-disk representation of an attachment.
AttachmentCodec :: struct {
    encode: fn(^T) -> Result<Compound,
    decode: fn(^Compound) -> Result<T,
}

// A mod-defined attachment key and its value's behavior.
AttachmentType :: struct {
    namespace: ^'static str,
    name: ^'static str,
    default: fn() -> T,
    codec: Maybe(AttachmentCodec<T)>,
    copy_on_death: bool,
    // Send the value to the clients that see the holder; needs a codec.
    sync: bool,
}

    // rust: impl<T> AttachmentType<T> {
validate_policy :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.copy_on_death && self.codec.is_none() {
    // rust: return Err(AttachmentError::InvalidCopyPolicy);
}
    // rust: if self.sync && self.codec.is_none() {
    // rust: return Err(AttachmentError::InvalidSyncPolicy);
}
    // rust: Ok(())
}
}

// One attachment's new state for a client; `None` means removed.
AttachmentSync :: struct {
    namespace: JavaString,
    name: JavaString,
    value: Maybe(Compound),
}

    // rust: impl<T: Clone + Send + Sync + 'static> AttachmentType<T> {
    // Read a value, inserting its default if absent; see `get_existing`.
    // rust: pub fn get<H: AttachmentHost + ?Sized>(
    // rust: &self,
    // rust: host: &mut H,
    // rust: holder: Holder,
    // rust: ) -> Result<T, AttachmentError> {
    // rust: host.attachments(holder)?.get(self)
}
    // Whether a holder carries a value, like NeoForge's `hasData`; never inserts the default.
    // API 317.
    // rust: pub fn has<H: AttachmentHost + ?Sized>(
    // rust: &self,
    // rust: host: &mut H,
    // rust: holder: Holder,
    // rust: ) -> Result<bool, AttachmentError> {
    // rust: Ok(host.attachments(holder)?.has(self))
}
    // Read a value only if present, like `getExistingData`. API 317.
    // rust: pub fn get_existing<H: AttachmentHost + ?Sized>(
    // rust: &self,
    // rust: host: &mut H,
    // rust: holder: Holder,
    // rust: ) -> Result<Option<T>, AttachmentError> {
    // rust: host.attachments(holder)?.get_existing(self)
}
    // Replace a value on an existing holder.
    // rust: pub fn set<H: AttachmentHost + ?Sized>(
    // rust: &self,
    // rust: host: &mut H,
    // rust: holder: Holder,
    // rust: value: T,
    // rust: ) -> Result<(), AttachmentError> {
    // rust: host.attachments(holder)?.set(self, value)
}
    // Remove a value from an existing holder.
    // rust: pub fn remove<H: AttachmentHost + ?Sized>(
    // rust: &self,
    // rust: host: &mut H,
    // rust: holder: Holder,
    // rust: ) -> Result<Option<T>, AttachmentError> {
    // rust: host.attachments(holder)?.remove(self)
}
    // Send the current value to the clients that see the holder.
    // rust: pub fn sync_data<H: AttachmentHost + ?Sized>(
    // rust: &self,
    // rust: host: &mut H,
    // rust: holder: Holder,
    // rust: ) -> Result<(), AttachmentError> {
    // rust: host.attachments(holder)?.mark_sync(self)
}
}

    // rust: trait Value: Send + Sync {
as_any :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
clone_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
encoded :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
copy_on_death :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
sync :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
}
TypedValue :: struct {
    value: T,
    encoded: Maybe(Compound),
    copy_on_death: bool,
    sync: bool,
}
    // rust: impl<T: Clone + Send + Sync + 'static> Value for TypedValue<T> {
as_any :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.value
}
clone_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: Box::new(Self {
    // rust: value: self.value.clone(),
    // rust: encoded: self.encoded.clone(),
    // rust: copy_on_death: self.copy_on_death,
    // rust: sync: self.sync,
    // rust: })
}
encoded :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.encoded.as_ref()
}
copy_on_death :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.copy_on_death
}
sync :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sync
}
}
// The saved form of a decoded value: its encoding and the policies it was
// declared with. `None` when the type has no codec.
envelope :: proc(value: ^dyn Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: value.encoded().map(|encoded| {
    // rust: let mut envelope = Compound::new();
    // rust: envelope.insert("value".into(), Tag::Compound(encoded.clone()));
    // rust: if value.copy_on_death() {
    // rust: envelope.insert("copy_on_death".into(), Tag::Byte(1));
}
    // rust: if value.sync() {
    // rust: envelope.insert("sync".into(), Tag::Byte(1));
}
    // rust: envelope
    // rust: })
}
raw_value :: proc(raw: ^Compound) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match raw.get(&"value".into()) {
    // rust: Some(Tag::Compound(value)) => Some(value),
    // rust: _ => None,
}
}

Entry :: enum {
    Raw(Compound),
    Decoded(Box<dyn Value>),
}
    // rust: impl Entry {
    // The encoded value, as clients receive it.
synced_value :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Raw(raw) => raw_value(raw),
    // rust: Self::Decoded(value) => value.encoded(),
}
}
is_synced :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Raw(raw) => matches!(raw.get(&"sync".into()), Some(Tag::Byte(1))),
    // rust: Self::Decoded(value) => value.sync(),
}
}
}
    // rust: impl Clone for Entry {
clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Raw(value) => Self::Raw(value.clone()),
    // rust: Self::Decoded(value) => Self::Decoded(value.clone_box()),
}
}
}

// The data held by one entity, block entity, chunk or level.
Attachments :: struct {
    entries: BTreeMap<(JavaString,
    // Keep malformed or otherwise unrecognized NBT exactly as it was read.
    raw: Compound,
    // Keys to send to clients at the next flush; never saved.
    pending: BTreeSet<(JavaString,
}
    // rust: impl fmt::Debug for Attachments {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_struct("Attachments")
    // rust: .field("keys", &self.entries.keys())
    // rust: .finish()
}
}

    // rust: impl Attachments {
    // Read the namespaced attachment compound, leaving unknown data intact.
from_nbt :: proc(raw: Compound) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut result = Self {
    // rust: entries: BTreeMap::new(),
    // rust: raw,
    // rust: pending: BTreeSet::new(),
}
    // rust: for (namespace, tag) in &result.raw {
    // rust: if let Tag::Compound(names) = tag {
    // rust: for (name, value) in names {
    // rust: if let Tag::Compound(value) = value {
    // rust: result
    // rust: .entries
    // rust: .insert((namespace.clone(), name.clone()), Entry::Raw(value.clone()));
}
}
}
}
    // rust: result
}
    // Encode changed values, preserving raw entries and unrecognized tags.
to_nbt :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut raw = self.raw.clone();
    // rust: for ((namespace, name), entry) in &self.entries {
    // rust: let value = match entry {
    // rust: Entry::Raw(value) => Some(value.clone()),
    // rust: Entry::Decoded(value) => envelope(value.as_ref()),
}
    // rust: if let Some(value) = value {
    // rust: let tag = raw
    // rust: .entry(namespace.clone())
    // rust: .or_insert_with(|| Tag::Compound(Compound::new()));
    // rust: let Tag::Compound(names) = tag else {
    // rust: unreachable!("attachment namespace checked before mutation");
}
    // rust: names.insert(name.clone(), Tag::Compound(value));
}
}
    // rust: raw
}
    // Copy opted-in values through their disk encoding for a player respawn.
copy_on_death :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut copy = Self::default();
    // rust: for (key, entry) in &self.entries {
    // rust: let encoded = match entry {
    // rust: Entry::Raw(raw)
    // rust: if matches!(raw.get(&"copy_on_death".into()), Some(Tag::Byte(1))) =>
    // rust: {
    // rust: Some(raw.clone())
}
    // rust: Entry::Decoded(value) if value.copy_on_death() => {
    // rust: Some(envelope(value.as_ref()).ok_or(AttachmentError::InvalidCopyPolicy)?)
}
    // rust: _ => None,
}
    // rust: if let Some(encoded) = encoded {
    // rust: copy.entries.insert(key.clone(), Entry::Raw(encoded));
}
}
    // rust: Ok(copy)
}
    // Whether a value is stored, saved or set, without decoding or inserting it.
    // rust: pub fn has<T: Clone + Send + Sync + 'static>(&self, ty: &AttachmentType<T>) -> bool {
    // rust: self.entries
    // rust: .contains_key(&(ty.namespace.into(), ty.name.into()))
}
    // Get a stored value without inserting the default; saved values decode lazily.
    // rust: pub fn get_existing<T: Clone + Send + Sync + 'static>(
    // rust: &mut self,
    // rust: ty: &AttachmentType<T>,
    // rust: ) -> Result<Option<T>, AttachmentError> {
    // rust: ty.validate_policy()?;
    // rust: if self
    // rust: .raw
    // rust: .get(&ty.namespace.into())
    // rust: .is_some_and(|tag| !matches!(tag, Tag::Compound(_)))
    // rust: {
    // rust: return Err(AttachmentError::InvalidNamespace);
}
    // rust: let value = match self.entries.get(&(ty.namespace.into(), ty.name.into())) {
    // rust: Some(Entry::Raw(raw)) => {
    // rust: let value = raw_value(raw).ok_or(AttachmentError::Decode)?;
    // rust: (ty.codec.as_ref().ok_or(AttachmentError::Decode)?.decode)(value)?
}
    // rust: Some(Entry::Decoded(value)) => {
    // rust: return value
    // rust: .as_any()
    // rust: .downcast_ref::<T>()
    // rust: .cloned()
    // rust: .map(Some)
    // rust: .ok_or(AttachmentError::TypeMismatch);
}
    // rust: None => return Ok(None),
}
    // rust: self.insert_decoded(ty, value.clone())?;
    // rust: Ok(Some(value))
}
    // Get an existing value or insert its default; saved values decode lazily.
    // rust: pub fn get<T: Clone + Send + Sync + 'static>(
    // rust: &mut self,
    // rust: ty: &AttachmentType<T>,
    // rust: ) -> Result<T, AttachmentError> {
    // rust: if let Some(value) = self.get_existing(ty)? {
    // rust: return Ok(value);
}
    // rust: let value = (ty.default)();
    // rust: self.insert_decoded(ty, value.clone())?;
    // rust: if ty.sync {
    // rust: self.pending.insert((ty.namespace.into(), ty.name.into()));
}
    // rust: Ok(value)
}
    // Replace a value. A key already decoded as a different type is rejected.
    // rust: pub fn set<T: Clone + Send + Sync + 'static>(
    // rust: &mut self,
    // rust: ty: &AttachmentType<T>,
    // rust: value: T,
    // rust: ) -> Result<(), AttachmentError> {
    // rust: ty.validate_policy()?;
    // rust: if self
    // rust: .raw
    // rust: .get(&ty.namespace.into())
    // rust: .is_some_and(|tag| !matches!(tag, Tag::Compound(_)))
    // rust: {
    // rust: return Err(AttachmentError::InvalidNamespace);
}
    // rust: if let Some(Entry::Decoded(old)) = self.entries.get(&(ty.namespace.into(), ty.name.into()))
    // rust: && !old.as_any().is::<T>()
    // rust: {
    // rust: return Err(AttachmentError::TypeMismatch);
}
    // rust: self.insert_decoded(ty, value)?;
    // rust: if ty.sync {
    // rust: self.pending.insert((ty.namespace.into(), ty.name.into()));
}
    // rust: if let Some(Tag::Compound(names)) = self.raw.get_mut(&ty.namespace.into()) {
    // rust: names.remove(&ty.name.into());
}
    // rust: Ok(())
}
    // Remove a value, retaining all other namespaces and names. A saved value
    // that does not decode is removed too, and its error returned.
    // rust: pub fn remove<T: Clone + Send + Sync + 'static>(
    // rust: &mut self,
    // rust: ty: &AttachmentType<T>,
    // rust: ) -> Result<Option<T>, AttachmentError> {
    // rust: if !self.has(ty) {
    // rust: return Ok(None);
}
    // rust: if ty.sync {
    // rust: self.pending.insert((ty.namespace.into(), ty.name.into()));
}
    // rust: let value = self.get_existing(ty);
    // rust: self.entries.remove(&(ty.namespace.into(), ty.name.into()));
    // rust: if let Some(Tag::Compound(names)) = self.raw.get_mut(&ty.namespace.into()) {
    // rust: names.remove(&ty.name.into());
}
    // rust: value
}
    // rust: fn insert_decoded<T: Clone + Send + Sync + 'static>(
    // rust: &mut self,
    // rust: ty: &AttachmentType<T>,
    // rust: value: T,
    // rust: ) -> Result<(), AttachmentError> {
    // rust: let encoded = ty
    // rust: .codec
    // rust: .as_ref()
    // rust: .map(|codec| (codec.encode)(&value))
    // rust: .transpose()?;
    // rust: self.entries.insert(
    // rust: (ty.namespace.into(), ty.name.into()),
    // rust: Entry::Decoded(Box::new(TypedValue {
    // rust: value,
    // rust: encoded,
    // rust: copy_on_death: ty.copy_on_death,
    // rust: sync: ty.sync,
    // rust: })),
    // rust: );
    // rust: Ok(())
}
    // Queue a value to be sent to clients again; nothing for an unsynced type.
    // rust: pub fn mark_sync<T: 'static>(&mut self, ty: &AttachmentType<T>) -> Result<(), AttachmentError> {
    // rust: ty.validate_policy()?;
    // rust: if ty.sync {
    // rust: self.pending.insert((ty.namespace.into(), ty.name.into()));
}
    // rust: Ok(())
}
    // The changes to send to clients since the last call: the current value
    // of each queued key, or `None` for one that is gone.
take_sync_changes :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: std::mem::take(&mut self.pending)
    // rust: .into_iter()
    // rust: .map(|(namespace, name)| {
    // rust: let value = self
    // rust: .entries
    // rust: .get(&(namespace.clone(), name.clone()))
    // rust: .and_then(Entry::synced_value)
    // rust: .cloned();
    // rust: AttachmentSync {
    // rust: namespace,
    // rust: name,
    // rust: value,
}
    // rust: })
    // rust: .collect()
}
    // Every synced value, for a client that starts seeing the holder.
synced :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.entries
    // rust: .iter()
    // rust: .filter(|(_, entry)| entry.is_synced())
    // rust: .filter_map(|((namespace, name), entry)| {
    // rust: Some(AttachmentSync {
    // rust: namespace: namespace.clone(),
    // rust: name: name.clone(),
    // rust: value: Some(entry.synced_value()?.clone()),
    // rust: })
    // rust: })
    // rust: .collect()
}
    // Client side: keep what the server sent, decoded by the next `get`.
apply_sync :: proc(self: ^Self, change: AttachmentSync) {
}
    // rust: let key = (change.namespace, change.name);
    // rust: match change.value {
    // rust: Some(value) => {
    // rust: let raw = [("value".into(), Tag::Compound(value))].into();
    // rust: self.entries.insert(key, Entry::Raw(raw));
}
    // rust: None => {
    // rust: self.entries.remove(&key);
}
}
}
}

    // rust: mod tests {
//     use super::*;

encode :: proc(n: ^i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok([(JavaString::from("value"), Tag::Int(*n))].into())
}
decode :: proc(c: ^Compound) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match c.get(&"value".into()) {
    // rust: Some(Tag::Int(n)) => Ok(*n),
    // rust: _ => Err(AttachmentError::Decode),
}
}
    // rust: static COUNTER: AttachmentType<i32> = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "counter",
    // rust: default: || 0,
    // rust: codec: Some(AttachmentCodec { encode, decode }),
    // rust: copy_on_death: false,
    // rust: sync: false,
}
    // rust: static SYNCED: AttachmentType<i32> = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "synced",
    // rust: default: || 7,
    // rust: codec: Some(AttachmentCodec { encode, decode }),
    // rust: copy_on_death: false,
    // rust: sync: true,
}
change :: proc(name: string, value: Maybe(i32)) -> A {
    // Ported from Horizon
    return {}
}
    // rust: AttachmentSync {
    // rust: namespace: "test".into(),
    // rust: name: name.into(),
    // rust: value: value.map(|n| encode(&n).unwrap()),
}
}
    // rust: static MEMORY: AttachmentType<i32> = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "memory",
    // rust: default: || 3,
    // rust: codec: None,
    // rust: copy_on_death: false,
    // rust: sync: false,
}
saved_values_round_trip_and_memory_values_do_not :: proc() {
}
    // rust: let mut map = Attachments::default();
    // rust: map.set(&COUNTER, 42).unwrap();
    // rust: map.set(&MEMORY, 8).unwrap();
    // rust: let mut loaded = Attachments::from_nbt(map.to_nbt());
    // rust: assert_eq!(loaded.get(&COUNTER), Ok(42));
    // rust: assert_eq!(loaded.get(&MEMORY), Ok(3));
    // rust: assert_eq!(loaded.remove(&COUNTER), Ok(Some(42)));
    // rust: let mut reopened = Attachments::from_nbt(loaded.to_nbt());
    // rust: assert_eq!(reopened.get(&COUNTER), Ok(0));
}
untouched_saved_value_copies_on_respawn :: proc() {
}
    // rust: let keep = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "keep",
    // rust: default: || 0,
    // rust: codec: Some(AttachmentCodec { encode, decode }),
    // rust: copy_on_death: true,
    // rust: sync: false,
}
    // rust: let mut original = Attachments::default();
    // rust: original.set(&keep, 42).unwrap();
    // rust: original.set(&COUNTER, 5).unwrap();
    // rust: let loaded = Attachments::from_nbt(original.to_nbt());
    // rust: let mut respawned = loaded.copy_on_death().unwrap();
    // rust: assert_eq!(respawned.get(&keep), Ok(42));
    // rust: assert_eq!(respawned.get(&COUNTER), Ok(0));
}
existing_reads_leave_an_absent_value_absent :: proc() {
}
    // rust: let mut map = Attachments::default();
    // rust: assert!(!map.has(&COUNTER));
    // rust: assert_eq!(map.get_existing(&COUNTER), Ok(None));
    // rust: assert!(!map.has(&COUNTER));
    // rust: assert_eq!(map.to_nbt(), Compound::new());
    // rust: assert_eq!(map.get(&COUNTER), Ok(0));
    // rust: assert!(map.has(&COUNTER));
    // rust: assert_ne!(map.to_nbt(), Compound::new());
    // rust: map.set(&COUNTER, 5).unwrap();
    // rust: assert_eq!(map.get_existing(&COUNTER), Ok(Some(5)));
}
existing_read_decodes_a_saved_value_without_changing_it :: proc() {
}
    // rust: let mut map = Attachments::default();
    // rust: map.set(&COUNTER, 42).unwrap();
    // rust: map.set(&MEMORY, 8).unwrap();
    // rust: let saved = map.to_nbt();
    // rust: let mut loaded = Attachments::from_nbt(saved.clone());
    // rust: assert!(loaded.has(&COUNTER));
    // rust: assert_eq!(loaded.get_existing(&COUNTER), Ok(Some(42)));
    // rust: assert_eq!(loaded.to_nbt(), saved);
    // rust: assert!(!loaded.has(&MEMORY));
    // rust: assert_eq!(loaded.get_existing(&MEMORY), Ok(None));
}
unknown_and_invalid_values_survive_a_failed_decode :: proc() {
}
    // rust: let saved: Compound = [(
    // rust: JavaString::from("test"),
    // rust: Tag::Compound(
    // rust: [
    // rust: (
    // rust: JavaString::from("counter"),
    // rust: Tag::Compound(
    // rust: [(JavaString::from("value"), Tag::String("bad".into()))].into(),
    // rust: ),
    // rust: ),
    // rust: (JavaString(vec![0xd800]), Tag::Compound(Compound::new())),
    // rust: ]
    // rust: .into(),
    // rust: ),
    // rust: )]
    // rust: .into();
    // rust: let mut map = Attachments::from_nbt(saved.clone());
    // rust: assert!(map.has(&COUNTER));
    // rust: assert_eq!(map.get_existing(&COUNTER), Err(AttachmentError::Decode));
    // rust: assert_eq!(map.get(&COUNTER), Err(AttachmentError::Decode));
    // rust: assert_eq!(map.to_nbt(), saved);
    // rust: assert_eq!(map.remove(&COUNTER), Err(AttachmentError::Decode));
    // rust: assert_eq!(map.remove(&COUNTER), Ok(None), "removed all the same");
}
synced_set_and_remove_report_the_last_state_once :: proc() {
}
    // rust: let mut map = Attachments::default();
    // rust: map.set(&SYNCED, 1).unwrap();
    // rust: map.set(&SYNCED, 2).unwrap();
    // rust: map.remove(&SYNCED).unwrap();
    // rust: assert_eq!(map.take_sync_changes(), [change("synced", None)]);
    // rust: assert!(map.take_sync_changes().is_empty());
}
default_creation_is_synced_and_a_later_read_is_not :: proc() {
}
    // rust: let mut map = Attachments::default();
    // rust: assert_eq!(map.get(&SYNCED), Ok(7));
    // rust: assert_eq!(map.take_sync_changes(), [change("synced", Some(7))]);
    // rust: assert_eq!(map.get(&SYNCED), Ok(7));
    // rust: assert!(map.take_sync_changes().is_empty());
}
unsynced_types_report_no_changes :: proc() {
}
    // rust: let mut map = Attachments::default();
    // rust: map.set(&COUNTER, 1).unwrap();
    // rust: map.remove(&COUNTER).unwrap();
    // rust: map.mark_sync(&COUNTER).unwrap();
    // rust: assert!(map.take_sync_changes().is_empty());
}
sync_without_a_codec_is_refused :: proc() {
}
    // rust: let broken = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "broken",
    // rust: default: || 0,
    // rust: codec: None,
    // rust: copy_on_death: false,
    // rust: sync: true,
}
    // rust: let mut map = Attachments::default();
    // rust: assert_eq!(map.get(&broken), Err(AttachmentError::InvalidSyncPolicy));
    // rust: assert_eq!(map.set(&broken, 1), Err(AttachmentError::InvalidSyncPolicy));
    // rust: assert_eq!(
    // rust: map.mark_sync(&broken),
    // rust: Err(AttachmentError::InvalidSyncPolicy)
    // rust: );
    // rust: assert!(map.take_sync_changes().is_empty());
}
a_saved_sync_flag_puts_undecoded_values_in_the_snapshot :: proc() {
}
    // rust: let mut map = Attachments::default();
    // rust: map.set(&SYNCED, 5).unwrap();
    // rust: map.set(&COUNTER, 6).unwrap();
    // rust: let saved = map.to_nbt();
    // rust: let Some(Tag::Compound(names)) = saved.get(&"test".into()) else {
    // rust: panic!("namespace saved");
}
    // rust: let Some(Tag::Compound(envelope)) = names.get(&"synced".into()) else {
    // rust: panic!("entry saved");
}
    // rust: assert_eq!(envelope.get(&"sync".into()), Some(&Tag::Byte(1)));
    // rust: let loaded = Attachments::from_nbt(saved);
    // rust: assert_eq!(loaded.synced(), [change("synced", Some(5))]);
}
applied_changes_decode_through_the_codec_and_removals_clear :: proc() {
}
    // rust: let mut map = Attachments::default();
    // rust: map.apply_sync(change("synced", Some(9)));
    // rust: assert_eq!(map.get(&SYNCED), Ok(9));
    // rust: map.apply_sync(change("synced", None));
    // rust: assert_eq!(map.get(&SYNCED), Ok(7));
}
sync_data_reports_the_current_value :: proc() {
}
One :: struct {
    // rust: impl AttachmentHost for One {
attachments :: proc(self: ^Self, _: Holder) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(&mut self.0)
}
}
    // rust: let mut host = One(Attachments::default());
    // rust: SYNCED.set(&mut host, Holder::Level, 4).unwrap();
    // rust: host.0.take_sync_changes();
    // rust: SYNCED.sync_data(&mut host, Holder::Level).unwrap();
    // rust: assert_eq!(host.0.take_sync_changes(), [change("synced", Some(4))]);
}
}
