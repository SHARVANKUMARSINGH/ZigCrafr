//! Transpiled from Horizon Rust crate
package horizon_world_operation_map

import "core:fmt"
import "core:mem"
import "core:math"

// The pinned operation buckets use open-addressed maps. Preserve their slot
// iteration order because reassociating floating-point modifiers changes values.
// use super::Modifier;
    // rust: pub(super) struct OperationMap {
    // rust: slots: Vec<Option<Modifier>>,
    // rust: len: usize,
}
    // rust: impl Default for OperationMap {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: slots: vec![None; 32],
    // rust: len: 0,
}
}
}
mixed :: proc(m: ^Modifier) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let h = m.0.hash.wrapping_mul(0x9e37_79b9);
    // rust: (h ^ (h >> 16)) as usize
}
capacity :: proc(len: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((len as f64 / 0.75).ceil() as usize)
    // rust: .max(2)
    // rust: .next_power_of_two()
}
    // rust: impl OperationMap {
    // rust: pub(super) fn values(&self) -> impl Iterator<Item = &Modifier> {
    // rust: self.slots.iter().rev().filter_map(Option::as_ref)
}
max_fill :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.slots.len() * 3 / 4
}
find :: proc(self: ^Self, m: ^Modifier) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mask = self.slots.len() - 1;
    // rust: let mut p = mixed(m) & mask;
    // rust: while self.slots[p].as_ref().is_some_and(|old| old.id() != m.id()) {
    // rust: p = (p + 1) & mask;
}
    // rust: p
}
    // rust: pub(super) fn put(&mut self, m: Modifier) {
    // rust: let p = self.find(&m);
    // rust: let new = self.slots[p].is_none();
    // rust: self.slots[p] = Some(m);
    // rust: if new {
    // rust: let old = self.len;
    // rust: self.len += 1;
    // rust: if old >= self.max_fill() {
    // rust: self.rehash(capacity(self.len + 1));
}
}
}
rehash :: proc(self: ^Self, n: uint) {
}
    // rust: let old = std::mem::replace(&mut self.slots, vec![None; n]);
    // rust: for m in old.into_iter().rev().flatten() {
    // rust: let p = self.find(&m);
    // rust: self.slots[p] = Some(m);
}
}
    // rust: pub(super) fn remove(&mut self, m: &Modifier) {
    // rust: let p = self.find(m);
    // rust: if self.slots[p].is_none() {
    // rust: return;
}
    // rust: self.len -= 1;
    // rust: let mask = self.slots.len() - 1;
    // rust: let mut hole = p;
    // rust: loop {
    // rust: let mut p = (hole + 1) & mask;
    // rust: loop {
    // rust: let Some(key) = self.slots[p].as_ref() else {
    // rust: self.slots[hole] = None;
    // rust: if self.slots.len() > 32 && self.len < self.max_fill() / 4 {
    // rust: self.rehash(self.slots.len() / 2);
}
    // rust: return;
}
    // rust: let home = mixed(key) & mask;
    // rust: let moves = if hole <= p {
    // rust: hole >= home || home > p
    // rust: } else {
    // rust: hole >= home && home > p
}
    // rust: if moves {
    // rust: break;
}
    // rust: p = (p + 1) & mask;
}
    // rust: self.slots[hole] = self.slots[p].take();
    // rust: hole = p;
}
}
    // rust: pub(super) fn copy_for_replace(&self) -> Self {
    // rust: let mut result = Self::default();
    // rust: let n = capacity(self.len);
    // rust: if n > result.slots.len() {
    // rust: result.rehash(n);
}
    // rust: for m in self.values() {
    // rust: result.put(m.clone());
}
    // rust: result
}
}
