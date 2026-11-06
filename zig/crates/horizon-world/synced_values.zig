//! Transpiled from Horizon Rust crate
//! Module: horizon-world_synced_values
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Synchronized typed values with native callback/dirty ordering.
//! Serializer codecs and complete entity schemas are separate.
// use crate::compression::invalid;
// use std::{fmt, io};
pub const DataValue = struct {
    id: u8,
    value: T,
};
pub const Entry = struct {
    id: u8,
    initial: T,
    value: T,
    dirty: bool,
};
pub const SyncedValues = struct {
    entries: std.ArrayList(Entry<T)>,
    dirty: bool,
};
pub const DataError = enum {
    UnknownId(u8),
    Observer(E),
};
    // rust: impl<E: fmt::Display> fmt::Display for DataError<E> {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::UnknownId(id) => write!(f, "unknown synchronized field ID {id}"),
    // rust: Self::Observer(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for DataError<E> {}
    // rust: pub trait Observer<T: SyncedValue = f32> {
    // rust: type Error;
pub fn updated(self: *Self, data: *mut SyncedValues<T>, id: u8) R;
    // rust: fn assigned(
    // rust: &mut self,
    // rust: _data: &mut SyncedValues<T>,
    // rust: _values: &[DataValue<T>],
    // rust: ) -> Result<(), Self::Error> {
    // rust: Ok(())
}
}
/// Equality used by the corresponding boxed native serializer value.
    // rust: pub trait SyncedValue: Clone {
pub fn native_equal(self: *Self, other: *Self) b;
}
    // rust: impl SyncedValue for f32 {
pub fn native_equal(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.to_bits() == other.to_bits() || (self.is_nan() && other.is_nan())
}
}
    // rust: impl SyncedValue for u8 {
pub fn native_equal(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self == other
}
}
    // rust: impl SyncedValue for bool {
pub fn native_equal(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self == other
}
}
    // rust: impl<T: SyncedValue> SyncedValues<T> {
pub fn new(values: *[DataValue<T>]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries = values
    // rust: .iter()
    // rust: .map(|v| Entry {
    // rust: id: v.id,
    // rust: initial: v.value.clone(),
    // rust: value: v.value.clone(),
    // rust: dirty: false,
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: entries.sort_unstable_by_key(|e| e.id);
    // rust: if entries.iter().any(|e| e.id == 255) || entries.windows(2).any(|e| e[0].id == e[1].id) {
    // rust: return Err(invalid("duplicate or reserved synchronized field ID"));
}
    // rust: Ok(Self {
    // rust: entries,
    // rust: dirty: false,
    // rust: })
}
pub fn index(self: *Self, id: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries
    // rust: .binary_search_by_key(&id, |e| e.id)
    // rust: .map_err(|_| id)
}
pub fn get(self: *Self, id: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.entries[self.index(id)?].value.clone())
}
pub fn is_dirty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.dirty
}
pub fn item_dirty(self: *Self, id: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.entries[self.index(id)?].dirty)
}
pub fn is_default(self: *Self, id: u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let e = &self.entries[self.index(id)?];
    // rust: Ok(e.initial.native_equal(&e.value))
}
    // rust: pub fn set<O: Observer<T>>(
    // rust: &mut self,
    // rust: id: u8,
    // rust: value: T,
    // rust: force: bool,
    // rust: observer: &mut O,
    // rust: ) -> Result<(), DataError<O::Error>> {
    // rust: let index = self.index(id).map_err(DataError::UnknownId)?;
    // rust: if force || !value.native_equal(&self.entries[index].value) {
    // rust: self.entries[index].value = value;
    // rust: observer.updated(self, id).map_err(DataError::Observer)?;
    // rust: self.entries[index].dirty = true;
    // rust: self.dirty = true;
}
    // rust: Ok(())
}
    /// Received values always notify, even when equal, and do not set/clear dirty
    /// flags. A failure preserves earlier entries and skips later/batch callbacks.
    // rust: pub fn assign<O: Observer<T>>(
    // rust: &mut self,
    // rust: values: &[DataValue<T>],
    // rust: observer: &mut O,
    // rust: ) -> Result<(), DataError<O::Error>> {
    // rust: for v in values {
    // rust: let index = self.index(v.id).map_err(DataError::UnknownId)?;
    // rust: self.entries[index].value = v.value.clone();
    // rust: observer.updated(self, v.id).map_err(DataError::Observer)?;
}
    // rust: observer.assigned(self, values).map_err(DataError::Observer)
}
pub fn take_dirty(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.dirty {
    // rust: return None;
}
    // rust: self.dirty = false;
    // rust: let mut values = Vec::new();
    // rust: for e in &mut self.entries {
    // rust: if e.dirty {
    // rust: e.dirty = false;
    // rust: values.push(DataValue {
    // rust: id: e.id,
    // rust: value: e.value.clone(),
    // rust: });
}
}
    // rust: Some(values)
}
pub fn non_default(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let values: Vec<_> = self
    // rust: .entries
    // rust: .iter()
    // rust: .filter(|e| !e.initial.native_equal(&e.value))
    // rust: .map(|e| DataValue {
    // rust: id: e.id,
    // rust: value: e.value.clone(),
    // rust: })
    // rust: .collect();
    // rust: if values.is_empty() {
    // rust: None
    // rust: } else {
    // rust: Some(values)
}
}
}
