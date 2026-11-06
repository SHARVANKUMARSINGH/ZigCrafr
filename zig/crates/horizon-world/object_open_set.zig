//! Transpiled from Horizon Rust crate
//! Module: horizon-world_object_open_set
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Default fastutil ObjectOpenHashSet storage and live iterator semantics.
//! Key hashing/equality must be pure; null is represented by None.
    // rust: pub trait ObjectKey: Eq {
pub fn object_hash(self: *Self) i;
}
pub const CursorError = enum {
    NoSuchElement,
    NoCurrentEntry,
    MissingWrapped,
    IndexOutOfBounds,
};
pub const Cursor = struct {
    position: i32,
    last: i32,
    remaining: i32,
    null: bool,
    wrapped: ?std.ArrayList(Option<K)>,
};
    // rust: impl<K> Cursor<K> {
pub fn has_next(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.remaining != 0
}
}
pub const ObjectOpenSet = struct {
    slots: std.ArrayList(?K),
    size: i32,
    null: bool,
};
    // rust: impl<K> Default for ObjectOpenSet<K> {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: slots: std::iter::repeat_with(|| None).take(33).collect(),
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
    // rust: impl<K: ObjectKey + Clone> ObjectOpenSet<K> {
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
    // rust: self.slots.len() - 1
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
    // rust: let mask = self.n() - 1;
    // rust: let mut p = mixed(key.object_hash()) & mask;
    // rust: while self.slots[p].as_ref().is_some_and(|old| old != key) {
    // rust: p = (p + 1) & mask;
}
    // rust: p
}
pub fn contains(self: *Self, key: ?*K) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: key.map_or(self.null, |key| self.slots[self.find(key)].is_some())
}
pub fn get(self: *Self, key: *K) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.slots[self.find(key)].as_ref()
}
pub fn values(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.null.then_some(None).into_iter().chain(
    // rust: self.slots[..self.n()]
    // rust: .iter()
    // rust: .rev()
    // rust: .filter_map(|v| v.as_ref().map(Some)),
    // rust: )
}
pub fn add(self: *Self, key: ?K) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(key) = key {
    // rust: let p = self.find(&key);
    // rust: if self.slots[p].is_some() {
    // rust: return false;
}
    // rust: self.slots[p] = Some(key);
    // rust: } else {
    // rust: if self.null {
    // rust: return false;
}
    // rust: self.null = true;
}
    // rust: let old = self.size;
    // rust: self.size = self.size.wrapping_add(1);
    // rust: if old >= self.max_fill() {
    // rust: self.rehash(
    // rust: (((self.size + 1) as f64 / 0.75).ceil() as usize)
    // rust: .max(2)
    // rust: .next_power_of_two(),
    // rust: );
}
    // rust: true
}
pub fn rehash(self: *Self, capacity: usize) void {
}
    // rust: let old = std::mem::replace(&mut self.slots, vec![None; capacity + 1]);
    // rust: for key in old.into_iter().rev().flatten() {
    // rust: let p = self.find(&key);
    // rust: self.slots[p] = Some(key);
}
}
    // rust: fn shift(
    // rust: &mut self,
    // rust: mut hole: usize,
    // rust: mut cursor: Option<&mut Cursor<K>>,
    // rust: ) -> Result<(), CursorError> {
    // rust: let mask = self.n() - 1;
    // rust: loop {
    // rust: let mut p = (hole + 1) & mask;
    // rust: loop {
    // rust: let Some(key) = &self.slots[p] else {
    // rust: *self
    // rust: .slots
    // rust: .get_mut(hole)
    // rust: .ok_or(CursorError::IndexOutOfBounds)? = None;
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
    // rust: if let Some(cursor) = &mut cursor {
    // rust: cursor
    // rust: .wrapped
    // rust: .get_or_insert_with(Vec::new)
    // rust: .push(self.slots[p].clone());
}
}
    // rust: let key = self.slots[p].clone();
    // rust: *self
    // rust: .slots
    // rust: .get_mut(hole)
    // rust: .ok_or(CursorError::IndexOutOfBounds)? = key;
    // rust: hole = p;
}
}
pub fn remove(self: *Self, key: ?*K) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(key) = key {
    // rust: let p = self.find(key);
    // rust: if self.slots[p].is_none() {
    // rust: return false;
}
    // rust: self.size = self.size.wrapping_sub(1);
    // rust: self.shift(p, None).unwrap();
    // rust: } else {
    // rust: if !self.null {
    // rust: return false;
}
    // rust: self.null = false;
    // rust: self.size = self.size.wrapping_sub(1);
}
    // rust: if self.n() > 32 && self.size < self.max_fill() / 4 {
    // rust: self.rehash(self.n() / 2);
}
    // rust: true
}
pub fn clear(self: *Self) void {
}
    // rust: if self.size == 0 {
    // rust: return;
}
    // rust: self.size = 0;
    // rust: self.null = false;
    // rust: self.slots.fill(None);
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
}
}
    /// The cursor reads the live slot array. Unlike HashMap it has no
    /// modification counter, including when callbacks clear or resize the set.
pub fn next(self: *Self, cursor: *mut Cursor<K>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !cursor.has_next() {
    // rust: return Err(CursorError::NoSuchElement);
}
    // rust: cursor.remaining = cursor.remaining.wrapping_sub(1);
    // rust: if cursor.null {
    // rust: cursor.null = false;
    // rust: cursor.last = self.n() as i32;
    // rust: return Ok(None);
}
    // rust: loop {
    // rust: cursor.position = cursor.position.wrapping_sub(1);
    // rust: if cursor.position < 0 {
    // rust: cursor.last = i32::MIN;
    // rust: let wrapped = cursor.wrapped.as_ref().ok_or(CursorError::MissingWrapped)?;
    // rust: return wrapped
    // rust: .get(cursor.position.wrapping_neg().wrapping_sub(1) as usize)
    // rust: .cloned()
    // rust: .ok_or(CursorError::IndexOutOfBounds);
}
    // rust: let key = self
    // rust: .slots
    // rust: .get(cursor.position as usize)
    // rust: .ok_or(CursorError::IndexOutOfBounds)?;
    // rust: if key.is_some() {
    // rust: cursor.last = cursor.position;
    // rust: return Ok(key.clone());
}
}
}
pub fn remove_current(self: *Self, cursor: *mut Cursor<K>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cursor.last == -1 {
    // rust: return Err(CursorError::NoCurrentEntry);
}
    // rust: if cursor.last == self.n() as i32 {
    // rust: self.null = false;
    // rust: } else if cursor.position >= 0 {
    // rust: self.shift(cursor.last as usize, Some(cursor))?;
    // rust: } else {
    // rust: let wrapped = cursor.wrapped.as_mut().ok_or(CursorError::MissingWrapped)?;
    // rust: let key = wrapped
    // rust: .get_mut(cursor.position.wrapping_neg().wrapping_sub(1) as usize)
    // rust: .ok_or(CursorError::IndexOutOfBounds)?
    // rust: .take();
    // rust: self.remove(key.as_ref());
    // rust: cursor.last = -1;
    // rust: return Ok(());
}
    // rust: self.size = self.size.wrapping_sub(1);
    // rust: cursor.last = -1;
    // rust: Ok(())
}
}
