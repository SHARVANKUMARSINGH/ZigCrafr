//! Transpiled from Horizon Rust crate
//! Module: horizon-world_object_open_map
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Default fastutil object map with live indexed entries and native traversal.
// use crate::object_open_set::{CursorError, ObjectKey};
// use std::{
    // rust: cell::{Cell, RefCell},
    // rust: rc::Rc,
}
pub const Table = struct {
    keys: std.ArrayList(?K),
    values: std.ArrayList(?V),
};
    // rust: impl<K, V> Table<K, V> {
pub fn new(n: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: keys: std::iter::repeat_with(|| None).take(n + 1).collect(),
    // rust: values: std::iter::repeat_with(|| None).take(n + 1).collect(),
}
}
}
/// An entry retains its array index, not a copy of its key/value. Clones share
/// invalidation when its entry iterator removes that entry.
pub const Entry = struct {};
pub const Cursor = struct {
    position: i32,
    last: i32,
    remaining: i32,
    null: bool,
    wrapped: ?std.ArrayList(Option<K)>,
    entry: ?Entry,
};
    // rust: impl<K> Cursor<K> {
pub fn has_next(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remaining != 0
}
}
pub const TraversalError = enum {
    Cursor(CursorError),
    Callback(E),
};
pub const ObjectOpenMap = struct {
    table: Rc<RefCell<Table<K,
    size: i32,
    null: bool,
};
/// A copy with its own table: the copy's changes never reach the original.
    // rust: impl<K: Clone, V: Clone> Clone for ObjectOpenMap<K, V> {
pub fn clone(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: table: Rc::new(RefCell::new(self.table.borrow().clone())),
    // rust: size: self.size,
    // rust: null: self.null,
}
}
}
    // rust: impl<K, V> Default for ObjectOpenMap<K, V> {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: table: Rc::new(RefCell::new(Table::new(32))),
    // rust: size: 0,
    // rust: null: false,
}
}
}
pub fn mixed(hash: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = (hash as u32).wrapping_mul(0x9e3779b9);
    // rust: (h ^ (h >> 16)) as usize
}
    // rust: impl<K: ObjectKey + Clone, V: Clone> ObjectOpenMap<K, V> {
pub fn len(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.size
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.size == 0
}
pub fn n(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.table.borrow().keys.len() - 1
}
pub fn max_fill(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.n() * 3 / 4) as i32
}
pub fn find(self: *Self, key: *K) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let table = self.table.borrow();
    // rust: let mask = table.keys.len() - 2;
    // rust: let mut p = mixed(key.object_hash()) & mask;
    // rust: while table.keys[p].as_ref().is_some_and(|k| k != key) {
    // rust: p = (p + 1) & mask;
}
    // rust: p
}
pub fn contains_key(self: *Self, key: ?*K) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: key.map_or(self.null, |k| {
    // rust: self.table.borrow().keys[self.find(k)].is_some()
    // rust: })
}
pub fn get(self: *Self, key: ?*K) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = key.map_or(self.n(), |k| self.find(k));
    // rust: let table = self.table.borrow();
    // rust: if key.map_or(self.null, |_| table.keys[p].is_some()) {
    // rust: table.values[p].clone()
    // rust: } else {
    // rust: None
}
}
pub fn entries(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let table = self.table.borrow();
    // rust: let n = table.keys.len() - 1;
    // rust: let mut entries = Vec::new();
    // rust: if self.null {
    // rust: entries.push((None, table.values[n].clone()));
}
    // rust: for p in (0..n).rev() {
    // rust: if table.keys[p].is_some() {
    // rust: entries.push((table.keys[p].clone(), table.values[p].clone()));
}
}
    // rust: entries
}
pub fn put(self: *Self, key: ?K, value: ?V) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = key.as_ref().map_or(self.n(), |k| self.find(k));
    // rust: let existing = if key.is_some() {
    // rust: self.table.borrow().keys[p].is_some()
    // rust: } else {
    // rust: self.null
}
    // rust: let previous = std::mem::replace(&mut self.table.borrow_mut().values[p], value);
    // rust: if existing {
    // rust: return previous;
}
    // rust: if key.is_none() {
    // rust: self.null = true;
}
    // rust: self.table.borrow_mut().keys[p] = key;
    // rust: let old = self.size;
    // rust: self.size = self.size.wrapping_add(1);
    // rust: if old >= self.max_fill() {
    // rust: self.rehash(
    // rust: (((self.size + 1) as f64 / 0.75).ceil() as usize)
    // rust: .max(2)
    // rust: .next_power_of_two(),
    // rust: );
}
    // rust: None
}
pub fn rehash(self: *Self, n: usize) void {
}
    // rust: let old = self.table.borrow();
    // rust: let old_n = old.keys.len() - 1;
    // rust: let mut table = Table::new(n);
    // rust: for p in (0..old_n).rev() {
    // rust: if let Some(key) = &old.keys[p] {
    // rust: let mut dest = mixed(key.object_hash()) & (n - 1);
    // rust: while table.keys[dest].is_some() {
    // rust: dest = (dest + 1) & (n - 1);
}
    // rust: table.keys[dest] = Some(key.clone());
    // rust: table.values[dest] = old.values[p].clone();
}
}
    // rust: table.values[n] = old.values[old_n].clone();
    // rust: drop(old);
    // rust: self.table = Rc::new(RefCell::new(table));
}
    // rust: fn shift(
    // rust: &mut self,
    // rust: mut hole: usize,
    // rust: mut cursor: Option<&mut Cursor<K>>,
    // rust: ) -> Result<(), CursorError> {
    // rust: let mut table = self.table.borrow_mut();
    // rust: let mask = table.keys.len() - 2;
    // rust: loop {
    // rust: let mut p = (hole + 1) & mask;
    // rust: loop {
    // rust: let Some(key) = &table.keys[p] else {
    // rust: *table
    // rust: .keys
    // rust: .get_mut(hole)
    // rust: .ok_or(CursorError::IndexOutOfBounds)? = None;
    // rust: table.values[hole] = None;
    // rust: return Ok(());
}
    // rust: let home = mixed(key.object_hash()) & mask;
    // rust: if if hole <= p {
    // rust: hole >= home || home > p
    // rust: } else {
    // rust: hole >= home && home > p
    // rust: } {
    // rust: break;
}
    // rust: p = (p + 1) & mask;
}
    // rust: if p < hole {
    // rust: if let Some(c) = &mut cursor {
    // rust: c.wrapped
    // rust: .get_or_insert_with(Vec::new)
    // rust: .push(table.keys[p].clone());
}
}
    // rust: let key = table.keys[p].clone();
    // rust: let value = table.values[p].clone();
    // rust: *table
    // rust: .keys
    // rust: .get_mut(hole)
    // rust: .ok_or(CursorError::IndexOutOfBounds)? = key;
    // rust: table.values[hole] = value;
    // rust: hole = p;
}
}
pub fn remove(self: *Self, key: ?*K) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.contains_key(key) {
    // rust: return None;
}
    // rust: let p = key.map_or(self.n(), |k| self.find(k));
    // rust: let old = self.table.borrow().values[p].clone();
    // rust: self.size = self.size.wrapping_sub(1);
    // rust: if key.is_none() {
    // rust: self.null = false;
    // rust: let mut table = self.table.borrow_mut();
    // rust: table.keys[p] = None;
    // rust: table.values[p] = None;
    // rust: } else {
    // rust: self.shift(p, None).unwrap();
}
    // rust: if self.n() > 32 && self.size < self.max_fill() / 4 {
    // rust: self.rehash(self.n() / 2);
}
    // rust: old
}
pub fn clear(self: *Self) void {
}
    // rust: if self.size == 0 {
    // rust: return;
}
    // rust: self.size = 0;
    // rust: self.null = false;
    // rust: let mut table = self.table.borrow_mut();
    // rust: table.keys.fill(None);
    // rust: table.values.fill(None);
}
pub fn cursor(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Cursor {
    // rust: position: self.n() as i32,
    // rust: last: -1,
    // rust: remaining: self.size,
    // rust: null: self.null,
    // rust: wrapped: None,
    // rust: entry: None,
}
}
pub fn next_entry(self: *Self, c: *mut Cursor<K>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !c.has_next() {
    // rust: return Err(CursorError::NoSuchElement);
}
    // rust: c.remaining = c.remaining.wrapping_sub(1);
    // rust: let index = if c.null {
    // rust: c.null = false;
    // rust: c.last = self.n() as i32;
    // rust: c.last
    // rust: } else {
    // rust: loop {
    // rust: c.position = c.position.wrapping_sub(1);
    // rust: if c.position < 0 {
    // rust: c.last = i32::MIN;
    // rust: let key = c
    // rust: .wrapped
    // rust: .as_ref()
    // rust: .ok_or(CursorError::MissingWrapped)?
    // rust: .get(c.position.wrapping_neg().wrapping_sub(1) as usize)
    // rust: .ok_or(CursorError::IndexOutOfBounds)?
    // rust: .as_ref()
    // rust: .ok_or(CursorError::MissingWrapped)?;
    // rust: let p = self.find(key);
                    // Deleting a wrapped member externally can make native iteration
                    // nonterminating. Such invalidated wrapped iterators are excluded.
    // rust: if self.table.borrow().keys[p].is_none() {
    // rust: return Err(CursorError::MissingWrapped);
}
    // rust: break p as i32;
}
    // rust: if self
    // rust: .table
    // rust: .borrow()
    // rust: .keys
    // rust: .get(c.position as usize)
    // rust: .ok_or(CursorError::IndexOutOfBounds)?
    // rust: .is_some()
    // rust: {
    // rust: c.last = c.position;
    // rust: break c.position;
}
}
}
    // rust: let entry = Entry(Rc::new(Cell::new(index)));
    // rust: c.entry = Some(entry.clone());
    // rust: Ok(entry)
}
pub fn entry_key(self: *Self, e: *Entry) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.table
    // rust: .borrow()
    // rust: .keys
    // rust: .get(e.0.get() as usize)
    // rust: .cloned()
    // rust: .ok_or(CursorError::IndexOutOfBounds)
}
pub fn entry_value(self: *Self, e: *Entry) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.table
    // rust: .borrow()
    // rust: .values
    // rust: .get(e.0.get() as usize)
    // rust: .cloned()
    // rust: .ok_or(CursorError::IndexOutOfBounds)
}
    // rust: pub fn set_entry_value(
    // rust: &mut self,
    // rust: e: &Entry,
    // rust: value: Option<V>,
    // rust: ) -> Result<Option<V>, CursorError> {
    // rust: Ok(std::mem::replace(
    // rust: self.table
    // rust: .borrow_mut()
    // rust: .values
    // rust: .get_mut(e.0.get() as usize)
    // rust: .ok_or(CursorError::IndexOutOfBounds)?,
    // rust: value,
    // rust: ))
}
pub fn remove_current(self: *Self, c: *mut Cursor<K>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if c.last == -1 {
    // rust: return Err(CursorError::NoCurrentEntry);
}
    // rust: if c.last == self.n() as i32 {
    // rust: self.null = false;
    // rust: let mut t = self.table.borrow_mut();
    // rust: let n = t.keys.len() - 1;
    // rust: t.keys[n] = None;
    // rust: t.values[n] = None;
    // rust: } else if c.position >= 0 {
    // rust: self.shift(c.last as usize, Some(c))?;
    // rust: } else {
    // rust: let key = c
    // rust: .wrapped
    // rust: .as_mut()
    // rust: .ok_or(CursorError::MissingWrapped)?
    // rust: .get_mut(c.position.wrapping_neg().wrapping_sub(1) as usize)
    // rust: .ok_or(CursorError::IndexOutOfBounds)?
    // rust: .take();
    // rust: self.remove(key.as_ref());
    // rust: c.last = -1;
    // rust: if let Some(e) = &c.entry {
    // rust: e.0.set(-1);
}
    // rust: return Ok(());
}
    // rust: self.size = self.size.wrapping_sub(1);
    // rust: c.last = -1;
    // rust: if let Some(e) = &c.entry {
    // rust: e.0.set(-1);
}
    // rust: Ok(())
}
    // rust: pub fn for_each<E>(
    // rust: &mut self,
    // rust: mut action: impl FnMut(&mut Self, Option<K>, Option<V>) -> Result<(), E>,
    // rust: ) -> Result<(), TraversalError<E>> {
    // rust: if self.null {
    // rust: let value = self.table.borrow().values[self.n()].clone();
    // rust: action(self, None, value).map_err(TraversalError::Callback)?;
}
        // Keys are captured after the null callback. Values remain live even if
        // a callback rehashes the map and replaces both native arrays.
    // rust: let keys = self.table.clone();
    // rust: let n = self.n();
    // rust: for p in (0..n).rev() {
    // rust: let key = keys.borrow().keys[p].clone();
    // rust: if key.is_some() {
    // rust: let value = self
    // rust: .table
    // rust: .borrow()
    // rust: .values
    // rust: .get(p)
    // rust: .cloned()
    // rust: .ok_or(TraversalError::Cursor(CursorError::IndexOutOfBounds))?;
    // rust: action(self, key, value).map_err(TraversalError::Callback)?;
}
}
    // rust: Ok(())
}
}

    // rust: mod tests {
//     use super::*;

pub const K = struct {};
    // rust: impl ObjectKey for K {
pub fn object_hash(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0
}
}

pub fn a_copy_has_its_own_table() void {
}
    // rust: let mut map = ObjectOpenMap::default();
    // rust: map.put(Some(K(1)), Some("one"));
    // rust: let mut copy = map.clone();
    // rust: copy.put(Some(K(1)), Some("uno"));
    // rust: copy.put(Some(K(2)), Some("dos"));
    // rust: assert_eq!(map.get(Some(&K(1))), Some("one"));
    // rust: assert!(!map.contains_key(Some(&K(2))));
    // rust: assert_eq!((map.len(), copy.len()), (1, 2));
}
}
