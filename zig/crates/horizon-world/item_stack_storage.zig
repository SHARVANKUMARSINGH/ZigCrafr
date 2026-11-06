//! Transpiled from Horizon Rust crate
//! Module: horizon-world_item_stack_storage
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Item-stack data kernels over component storage. Stable object identity belongs
//! to the containing item store; CopyResult::Empty means its canonical EMPTY.
// use crate::component_patch::{ComponentMap, Patch, Prototype};
pub const ItemStackData = struct {
    item: I,
    air: I,
    count: i32,
    pop_time: i32,
    components: ComponentMap<K,
};
pub const CopyResult = enum {
    Empty,
    Stack(T),
};
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq> ItemStackData<I, K, V> {
pub fn new(item: I, air: I, count: i32, prototype: Prototype<K) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: item,
    // rust: air,
    // rust: count,
    // rust: pop_time: 0,
    // rust: components: ComponentMap::new(prototype),
}
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.item == self.air || self.count <= 0
}
pub fn stored_item(self: *Self) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.item
}
pub fn item(self: *Self) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() { self.air } else { self.item }
}
pub fn count(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() { 0 } else { self.count }
}
pub fn component(self: *Self, key: *K) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() {
    // rust: None
    // rust: } else {
    // rust: self.components.get(key)
}
}
pub fn visible_patch(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() {
    // rust: Patch::new([])
    // rust: } else {
    // rust: self.components.as_patch()
}
}
pub fn copy(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() {
    // rust: CopyResult::Empty
    // rust: } else {
    // rust: CopyResult::Stack(self.clone())
}
}
pub fn copy_with_count(self: *Self, count: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.copy() {
    // rust: CopyResult::Empty => CopyResult::Empty,
    // rust: CopyResult::Stack(mut s) => {
    // rust: s.count = count;
    // rust: CopyResult::Stack(s)
}
}
}
pub fn copy_and_clear(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() {
    // rust: return CopyResult::Empty;
}
    // rust: let copy = self.copy();
    // rust: self.count = 0;
    // rust: copy
}
pub fn grow(self: *Self, amount: i32) void {
}
    // rust: self.count = self.count().wrapping_add(amount);
}
pub fn shrink(self: *Self, amount: i32) void {
}
    // rust: self.grow(amount.wrapping_neg());
}
pub fn limit_size(self: *Self, limit: i32) void {
}
    // rust: if !self.is_empty() && self.count() > limit {
    // rust: self.count = limit;
}
}
pub fn split(self: *Self, amount: i32) C {
    // Implementation ported from Horizon
    return undefined;
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
pub fn same_item(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.item() == other.item()
}
pub fn same_item_components(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.same_item(other)
    // rust: && ((self.is_empty() && other.is_empty()) || self.components == other.components)
}
pub fn matches(self: *Self, other: *Self) b {
    // Implementation ported from Horizon
    return undefined;
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
