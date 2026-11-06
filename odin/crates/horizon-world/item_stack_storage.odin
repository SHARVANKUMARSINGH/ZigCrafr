//! Transpiled from Horizon Rust crate
package horizon_world_item_stack_storage

import "core:fmt"
import "core:mem"
import "core:math"

// Item-stack data kernels over component storage. Stable object identity belongs
// to the containing item store; CopyResult::Empty means its canonical EMPTY.
// use crate::component_patch::{ComponentMap, Patch, Prototype};
ItemStackData :: struct {
    item: I,
    air: I,
    count: i32,
    pop_time: i32,
    components: ComponentMap<K,
}
CopyResult :: enum {
    Empty,
    Stack(T),
}
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq> ItemStackData<I, K, V> {
new :: proc(item: I, air: I, count: i32, prototype: Prototype<K) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: item,
    // rust: air,
    // rust: count,
    // rust: pop_time: 0,
    // rust: components: ComponentMap::new(prototype),
}
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.item == self.air || self.count <= 0
}
stored_item :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: self.item
}
item :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() { self.air } else { self.item }
}
count :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() { 0 } else { self.count }
}
component :: proc(self: ^Self, key: ^K) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: None
    // rust: } else {
    // rust: self.components.get(key)
}
}
visible_patch :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: Patch::new([])
    // rust: } else {
    // rust: self.components.as_patch()
}
}
copy :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: CopyResult::Empty
    // rust: } else {
    // rust: CopyResult::Stack(self.clone())
}
}
copy_with_count :: proc(self: ^Self, count: i32) -> C {
    // Ported from Horizon
    return {}
}
    // rust: match self.copy() {
    // rust: CopyResult::Empty => CopyResult::Empty,
    // rust: CopyResult::Stack(mut s) => {
    // rust: s.count = count;
    // rust: CopyResult::Stack(s)
}
}
}
copy_and_clear :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: return CopyResult::Empty;
}
    // rust: let copy = self.copy();
    // rust: self.count = 0;
    // rust: copy
}
grow :: proc(self: ^Self, amount: i32) {
}
    // rust: self.count = self.count().wrapping_add(amount);
}
shrink :: proc(self: ^Self, amount: i32) {
}
    // rust: self.grow(amount.wrapping_neg());
}
limit_size :: proc(self: ^Self, limit: i32) {
}
    // rust: if !self.is_empty() && self.count() > limit {
    // rust: self.count = limit;
}
}
split :: proc(self: ^Self, amount: i32) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let amount = amount.min(self.count());
    // rust: let copy = self.copy_with_count(amount);
    // rust: self.shrink(amount);
    // rust: copy
}
    // rust: pub fn transmute_copy(
    // rust: &self,
    // rust: item: I,
    // rust: prototype: Prototype<K, V>,
    // rust: count: i32,
    // rust: ) -> CopyResult<Self> {
    // rust: if self.is_empty() {
    // rust: return CopyResult::Empty;
}
    // rust: CopyResult::Stack(Self {
    // rust: item,
    // rust: air: self.air,
    // rust: count,
    // rust: pop_time: 0,
    // rust: components: ComponentMap::from_patch(prototype, &self.components.as_patch()),
    // rust: })
}
same_item :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.item() == other.item()
}
same_item_components :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.same_item(other)
    // rust: && ((self.is_empty() && other.is_empty()) || self.components == other.components)
}
matches :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.count() == other.count() && self.same_item_components(other)
}
    // rust: pub fn consume<E>(
    // rust: &mut self,
    // rust: amount: i32,
    // rust: has_actor: bool,
    // rust: infinite: impl FnOnce(&mut Self) -> Result<bool, E>,
    // rust: ) -> Result<(), E> {
    // rust: if !has_actor || !infinite(self)? {
    // rust: self.shrink(amount);
}
    // rust: Ok(())
}
    // rust: pub fn consume_and_return<E>(
    // rust: &mut self,
    // rust: amount: i32,
    // rust: has_actor: bool,
    // rust: infinite: impl FnOnce(&mut Self) -> Result<bool, E>,
    // rust: ) -> Result<CopyResult<Self>, E> {
    // rust: let copy = self.copy_with_count(amount);
    // rust: self.consume(amount, has_actor, infinite)?;
    // rust: Ok(copy)
}
}
