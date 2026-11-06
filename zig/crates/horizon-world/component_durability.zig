//! Transpiled from Horizon Rust crate
//! Module: horizon-world_component_durability
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Durability backed by native-style component prototypes and patches.
//! Other item components and item identity are supplied by the containing stack.
// use crate::{
    // rust: component_patch::{ComponentMap, MissingPrototype, Patch, Prototype},
    // rust: item_durability::DurabilityStorage,
}
pub const Key = enum {
    MaxDamage,
    Damage,
    Unbreakable,
};
pub const Change = enum {
    MaxDamage(Option<i32>),
    Damage(Option<i32>),
    Unbreakable(bool),
};
    // rust: impl Change {
pub fn parts(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::MaxDamage(v) => (Key::MaxDamage, v),
    // rust: Self::Damage(v) => (Key::Damage, v),
    // rust: Self::Unbreakable(v) => (Key::Unbreakable, v.then_some(0)),
}
}
pub fn from_parts(key: Key, v: ?i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match key {
    // rust: Key::MaxDamage => Self::MaxDamage(v),
    // rust: Key::Damage => Self::Damage(v),
    // rust: Key::Unbreakable => Self::Unbreakable(v.is_some()),
}
}
}
pub const DurabilityPrototype = struct {};
    // rust: impl DurabilityPrototype {
pub fn new(changes: impl IntoIterator<Item = Change>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut entries = Vec::new();
    // rust: for change in changes {
    // rust: let (k, v) = change.parts();
    // rust: let i = entries.iter().position(|(key, _)| *key == k);
    // rust: match (v, i) {
    // rust: (Some(v), Some(i)) => entries[i] = (k, v),
    // rust: (Some(v), None) => entries.push((k, v)),
    // rust: (None, Some(i)) => {
    // rust: entries.remove(i);
}
    // rust: (None, None) => {}
}
}
    // rust: Self(Prototype::new(entries))
}
}
pub const DurabilityPatch = struct {};
    // rust: impl DurabilityPatch {
pub fn new(changes: impl IntoIterator<Item = Change>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self(Patch::new(changes.into_iter().map(Change::parts)))
}
pub fn changes(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|(k, v)| Change::from_parts(*k, *v))
}
}
pub const ComponentDurability = struct {
    count: i32,
    air: bool,
    components: ComponentMap<Key,
};
    // rust: impl ComponentDurability {
pub fn new(prototype: *DurabilityPrototype, count: i32, air: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: count,
    // rust: air,
    // rust: components: ComponentMap::new(prototype.0.clone()),
}
}
    // rust: pub fn from_patch(
    // rust: prototype: &DurabilityPrototype,
    // rust: patch: &DurabilityPatch,
    // rust: count: i32,
    // rust: air: bool,
    // rust: ) -> Self {
    // rust: Self {
    // rust: count,
    // rust: air,
    // rust: components: ComponentMap::from_patch(prototype.0.clone(), &patch.0),
}
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.air || self.count <= 0
}
pub fn count(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() { 0 } else { self.count }
}
    /// Raw storage remains present while the containing item stack is empty.
pub fn raw_component(self: *Self, key: Key) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.components.get(&key).copied()
}
pub fn set(self: *Self, change: Change) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (k, v) = change.parts();
    // rust: self.components
    // rust: .set(k, v)
    // rust: .map(|old| old.map(|v| Change::from_parts(k, Some(v))))
}
pub fn remove(self: *Self, key: Key) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.components
    // rust: .remove(key)
    // rust: .map(|v| Change::from_parts(key, Some(v)))
}
pub fn apply_patch(self: *Self, patch: *DurabilityPatch) void {
}
    // rust: self.components.apply_patch(&patch.0);
}
pub fn restore_patch(self: *Self, patch: *DurabilityPatch) void {
}
    // rust: self.components.restore_patch(&patch.0);
}
pub fn as_patch(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DurabilityPatch(self.components.as_patch())
}
pub fn max_damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: self.raw_component(Key::MaxDamage).unwrap_or(0)
}
}
pub fn damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = if self.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: self.raw_component(Key::Damage).unwrap_or(0)
}
    // rust: value.max(0).min(self.max_damage())
}
pub fn set_damage(self: *Self, value: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.set(Change::Damage(Some(value.max(0).min(self.max_damage()))))
    // rust: .map(|_| ())
}
pub fn is_damageable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.is_empty()
    // rust: && self.raw_component(Key::MaxDamage).is_some()
    // rust: && self.raw_component(Key::Unbreakable).is_none()
    // rust: && self.raw_component(Key::Damage).is_some()
}
pub fn is_damaged(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_damageable() && self.damage() > 0
}
pub fn is_broken(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_damageable() && self.damage() >= self.max_damage()
}
pub fn next_damage_will_break(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_damageable() && self.damage() >= self.max_damage().wrapping_sub(1)
}
pub fn grow(self: *Self, amount: i32) void {
}
    // rust: self.count = self.count().wrapping_add(amount);
}
pub fn shrink(self: *Self, amount: i32) void {
}
    // rust: self.grow(amount.wrapping_neg());
}
}
    // rust: impl DurabilityStorage for ComponentDurability {
    // rust: type Error = MissingPrototype;
pub fn is_damageable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_damageable()
}
pub fn damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.damage()
}
pub fn max_damage(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.max_damage()
}
pub fn set_damage(self: *Self, value: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.set_damage(value)
}
pub fn is_broken(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_broken()
}
pub fn shrink(self: *Self, amount: i32) void {
}
    // rust: self.shrink(amount);
}
}
