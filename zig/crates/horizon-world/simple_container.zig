//! Transpiled from Horizon Rust crate
//! Module: horizon-world_simple_container
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! SimpleContainer storage and transfers using shared stack references.
//! Item component semantics and the virtual size/change hooks are supplied by
//! the caller. Menu transactions, persistence and recipe accounting are separate.
// use crate::{
    // rust: component_patch::Prototype,
    // rust: item_stack_refs::{ItemStacks, StackRef},
}
pub const ContainerError = enum {
    Index,
    Callback(E),
};
    // rust: pub type ContainerResult<T, E> = Result<T, ContainerError<E>>;
pub const SimpleContainer = struct {
    items: Vec<StackRef<I,
    stacks: ItemStacks<I,
};
    // rust: pub trait ContainerHooks<I, K, V> {
    // rust: type Error;
    /// Native getMaxStackSize(), normally 99; called before the item's limit.
    // rust: fn max_stack_size(
    // rust: &mut self,
    // rust: container: &mut SimpleContainer<I, K, V>,
    // rust: ) -> Result<i32, Self::Error>;
pub fn item_max_stack_size(self: *Self, stack: *StackRef<I) i;
pub fn changed(self: *Self, container: *mut SimpleContainer<I) R;
}
    // rust: impl<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq> SimpleContainer<I, K, V> {
pub fn new(size: usize, stacks: ItemStacks<I) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: items: vec![stacks.empty(); size],
    // rust: stacks,
}
}
    /// Like the native varargs constructor, this retains aliases without limits.
pub fn from_items(items: Vec<StackRef<I, stacks: ItemStacks<I) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { items, stacks }
}
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.items
}
pub fn items_mut(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.items
}
pub fn size(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items.len()
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items.iter().all(|s| s.read().is_empty())
}
pub fn get(self: *Self, index: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: usize::try_from(index)
    // rust: .ok()
    // rust: .and_then(|i| self.items.get(i))
    // rust: .cloned()
    // rust: .unwrap_or_else(|| self.stacks.empty())
}
pub fn count_item(self: *Self, item: I) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items.iter().fold(0_i32, |total, s| {
    // rust: let s = s.read();
    // rust: if s.item() == item {
    // rust: total.wrapping_add(s.count())
    // rust: } else {
    // rust: total
}
    // rust: })
}
    // rust: pub fn can_add<H: ContainerHooks<I, K, V>>(
    // rust: &self,
    // rust: stack: &StackRef<I, K, V>,
    // rust: hooks: &H,
    // rust: ) -> bool {
    // rust: self.items.iter().any(|s| {
    // rust: s.read().is_empty()
    // rust: || (s.read().same_item_components(&stack.read())
    // rust: && s.read().count() < hooks.item_max_stack_size(s))
    // rust: })
}
    // rust: fn limit<H: ContainerHooks<I, K, V>>(
    // rust: &mut self,
    // rust: stack: &StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<i32, ContainerError<H::Error>> {
    // rust: let container = hooks
    // rust: .max_stack_size(self)
    // rust: .map_err(ContainerError::Callback)?;
    // rust: Ok(container.min(hooks.item_max_stack_size(stack)))
}
    // rust: pub fn set<H: ContainerHooks<I, K, V>>(
    // rust: &mut self,
    // rust: index: i32,
    // rust: stack: StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<(), ContainerError<H::Error>> {
    // rust: let slot = usize::try_from(index)
    // rust: .ok()
    // rust: .and_then(|i| self.items.get_mut(i))
    // rust: .ok_or(ContainerError::Index)?;
    // rust: *slot = stack.clone();
    // rust: let limit = self.limit(&stack, hooks)?;
    // rust: stack.write().limit_size(limit);
    // rust: hooks.changed(self).map_err(ContainerError::Callback)
}
    // rust: pub fn remove<H: ContainerHooks<I, K, V>>(
    // rust: &mut self,
    // rust: index: i32,
    // rust: amount: i32,
    // rust: hooks: &mut H,
    // rust: ) -> Result<StackRef<I, K, V>, ContainerError<H::Error>> {
    // rust: let s = self.get(index);
    // rust: let result = if amount > 0 && !s.read().is_empty() {
    // rust: self.stacks.split(&s, amount)
    // rust: } else {
    // rust: self.stacks.empty()
}
    // rust: if !result.read().is_empty() {
    // rust: hooks.changed(self).map_err(ContainerError::Callback)?;
}
    // rust: Ok(result)
}
    // rust: pub fn remove_no_update<E>(
    // rust: &mut self,
    // rust: index: i32,
    // rust: ) -> Result<StackRef<I, K, V>, ContainerError<E>> {
    // rust: let slot = usize::try_from(index)
    // rust: .ok()
    // rust: .and_then(|i| self.items.get_mut(i))
    // rust: .ok_or(ContainerError::Index)?;
    // rust: if slot.read().is_empty() {
    // rust: Ok(self.stacks.empty())
    // rust: } else {
    // rust: Ok(std::mem::replace(slot, self.stacks.empty()))
}
}
    // rust: pub fn remove_type<H: ContainerHooks<I, K, V>>(
    // rust: &mut self,
    // rust: item: I,
    // rust: prototype: Prototype<K, V>,
    // rust: amount: i32,
    // rust: hooks: &mut H,
    // rust: ) -> Result<StackRef<I, K, V>, ContainerError<H::Error>> {
    // rust: let result = self.stacks.create(item, 0, prototype);
    // rust: for index in (0..self.size()).rev() {
    // rust: let s = self.items[index].clone();
    // rust: if s.read().item() == item {
    // rust: let wanted = amount.wrapping_sub(result.read().count());
    // rust: let removed = self.stacks.split(&s, wanted);
    // rust: result.write().grow(removed.read().count());
    // rust: if result.read().count() == amount {
    // rust: break;
}
}
}
    // rust: if !result.read().is_empty() {
    // rust: hooks.changed(self).map_err(ContainerError::Callback)?;
}
    // rust: Ok(result)
}
    // rust: pub fn clear<H: ContainerHooks<I, K, V>>(
    // rust: &mut self,
    // rust: hooks: &mut H,
    // rust: ) -> Result<(), ContainerError<H::Error>> {
    // rust: self.items.fill(self.stacks.empty());
    // rust: hooks.changed(self).map_err(ContainerError::Callback)
}
    // rust: pub fn remove_all<H: ContainerHooks<I, K, V>>(
    // rust: &mut self,
    // rust: hooks: &mut H,
    // rust: ) -> ContainerResult<Vec<StackRef<I, K, V>>, H::Error> {
    // rust: let result = self
    // rust: .items
    // rust: .iter()
    // rust: .filter(|s| !s.read().is_empty())
    // rust: .cloned()
    // rust: .collect();
    // rust: self.clear(hooks)?;
    // rust: Ok(result)
}
    // rust: pub fn add<H: ContainerHooks<I, K, V>>(
    // rust: &mut self,
    // rust: stack: &StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<StackRef<I, K, V>, ContainerError<H::Error>> {
    // rust: if stack.read().is_empty() {
    // rust: return Ok(self.stacks.empty());
}
    // rust: let remainder = self.stacks.copy(stack);
    // rust: for index in 0..self.size() {
    // rust: let target = self.items[index].clone();
    // rust: if target.read().same_item_components(&remainder.read()) {
    // rust: let limit = self.limit(&target, hooks)?;
    // rust: let amount = remainder
    // rust: .read()
    // rust: .count()
    // rust: .min(limit.wrapping_sub(target.read().count()));
    // rust: if amount > 0 {
    // rust: target.write().grow(amount);
    // rust: remainder.write().shrink(amount);
    // rust: hooks.changed(self).map_err(ContainerError::Callback)?;
}
    // rust: if remainder.read().is_empty() {
    // rust: return Ok(self.stacks.empty());
}
}
}
    // rust: for index in 0..self.size() {
    // rust: if self.items[index].read().is_empty() {
    // rust: let moved = self.stacks.resolve(remainder.write().copy_and_clear());
    // rust: self.set(index as i32, moved, hooks)?;
    // rust: break;
}
}
    // rust: if remainder.read().is_empty() {
    // rust: Ok(self.stacks.empty())
    // rust: } else {
    // rust: Ok(remainder)
}
}
}
