//! Transpiled from Horizon Rust crate
//! Module: horizon-core_index
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Deadline index whose traversal matches the pinned fastutil long map. Heap
//! insertion order decides exact ties between chunk heads after save loading.
    // rust: pub(super) struct DeadlineIndex {
    // rust: keys: Vec<i64>,
    // rust: values: Vec<i64>,
    // rust: zero: bool,
    // rust: size: usize,
}
pub fn mix(key: i64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut value = (key as u64).wrapping_mul(0x9e3779b97f4a7c15);
    // rust: value ^= value >> 32;
    // rust: (value ^ (value >> 16)) as usize
}
    // rust: impl Default for DeadlineIndex {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: keys: vec![0; 33],
    // rust: values: vec![0; 33],
    // rust: zero: false,
    // rust: size: 0,
}
}
}
    // rust: impl DeadlineIndex {
pub fn capacity(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.keys.len() - 1
}
pub fn find(self: *Self, key: i64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if key == 0 {
    // rust: return self.capacity();
}
    // rust: let mask = self.capacity() - 1;
    // rust: let mut slot = mix(key) & mask;
    // rust: while self.keys[slot] != 0 && self.keys[slot] != key {
    // rust: slot = (slot + 1) & mask;
}
    // rust: slot
}
    // rust: pub(super) fn put(&mut self, key: i64, value: i64) {
    // rust: let slot = self.find(key);
    // rust: let exists = if key == 0 {
    // rust: self.zero
    // rust: } else {
    // rust: self.keys[slot] != 0
}
    // rust: self.values[slot] = value;
    // rust: if exists {
    // rust: return;
}
    // rust: self.keys[slot] = key;
    // rust: if key == 0 {
    // rust: self.zero = true;
}
    // rust: let old_size = self.size;
    // rust: self.size += 1;
    // rust: if old_size >= self.capacity() * 3 / 4 {
    // rust: self.rehash(self.capacity() * 2);
}
}
pub fn rehash(self: *Self, capacity: usize) void {
}
    // rust: let old_keys = std::mem::replace(&mut self.keys, vec![0; capacity + 1]);
    // rust: let old_values = std::mem::replace(&mut self.values, vec![0; capacity + 1]);
    // rust: for slot in (0..old_keys.len() - 1).rev() {
    // rust: if old_keys[slot] == 0 {
    // rust: continue;
}
    // rust: let destination = self.find(old_keys[slot]);
    // rust: self.keys[destination] = old_keys[slot];
    // rust: self.values[destination] = old_values[slot];
}
    // rust: self.values[capacity] = *old_values.last().unwrap();
}
pub fn shift_keys(self: *Self, mut hole: usize, wrapped: *mut std.ArrayList(i64)) void {
}
    // rust: let mask = self.capacity() - 1;
    // rust: loop {
    // rust: let mut slot = (hole + 1) & mask;
    // rust: loop {
    // rust: let key = self.keys[slot];
    // rust: if key == 0 {
    // rust: self.keys[hole] = 0;
    // rust: return;
}
    // rust: let home = mix(key) & mask;
    // rust: let crosses = if hole <= slot {
    // rust: hole >= home || home > slot
    // rust: } else {
    // rust: hole >= home && home > slot
}
    // rust: if crosses {
    // rust: break;
}
    // rust: slot = (slot + 1) & mask;
}
    // rust: if slot < hole {
    // rust: wrapped.push(self.keys[slot]);
}
    // rust: self.keys[hole] = self.keys[slot];
    // rust: self.values[hole] = self.values[slot];
    // rust: hole = slot;
}
}
    // rust: pub(super) fn remove(&mut self, key: i64) {
    // rust: let slot = self.find(key);
    // rust: if key == 0 {
    // rust: if !self.zero {
    // rust: return;
}
    // rust: self.zero = false;
    // rust: } else {
    // rust: if self.keys[slot] == 0 {
    // rust: return;
}
    // rust: self.shift_keys(slot, &mut Vec::new());
}
    // rust: self.size -= 1;
    // rust: if self.capacity() > 32 && self.size < self.capacity() * 3 / 16 {
    // rust: self.rehash(self.capacity() / 2);
}
}
    /// Visit in vanilla iterator order. The callback updates the deadline and
    /// returns true to remove the entry. Regular iterator removal does not shrink.
    // rust: pub(super) fn visit(&mut self, mut action: impl FnMut(i64, &mut i64) -> bool) {
    // rust: let mut remaining = self.size;
    // rust: let mut position = self.capacity() as isize;
    // rust: let mut wrapped = Vec::new();
    // rust: let mut zero = self.zero;
    // rust: while remaining > 0 {
    // rust: remaining -= 1;
    // rust: let slot = if zero {
    // rust: zero = false;
    // rust: self.capacity()
    // rust: } else {
    // rust: loop {
    // rust: position -= 1;
    // rust: if position < 0 {
    // rust: break self.find(wrapped[(-position - 1) as usize]);
}
    // rust: if self.keys[position as usize] != 0 {
    // rust: break position as usize;
}
}
}
    // rust: let key = self.keys[slot];
    // rust: if !action(key, &mut self.values[slot]) {
    // rust: continue;
}
    // rust: if slot == self.capacity() {
    // rust: self.zero = false;
    // rust: self.size -= 1;
    // rust: } else if position >= 0 {
    // rust: self.shift_keys(slot, &mut wrapped);
    // rust: self.size -= 1;
    // rust: } else {
    // rust: self.remove(key);
}
}
}
}
