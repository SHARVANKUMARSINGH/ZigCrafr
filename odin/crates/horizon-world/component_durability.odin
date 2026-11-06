//! Transpiled from Horizon Rust crate
package horizon_world_component_durability

import "core:fmt"
import "core:mem"
import "core:math"

// Durability backed by native-style component prototypes and patches.
// Other item components and item identity are supplied by the containing stack.
// use crate::{
    // rust: component_patch::{ComponentMap, MissingPrototype, Patch, Prototype},
    // rust: item_durability::DurabilityStorage,
}
Key :: enum {
    MaxDamage,
    Damage,
    Unbreakable,
}
Change :: enum {
    MaxDamage(Option<i32>),
    Damage(Option<i32>),
    Unbreakable(bool),
}
    // rust: impl Change {
parts :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::MaxDamage(v) => (Key::MaxDamage, v),
    // rust: Self::Damage(v) => (Key::Damage, v),
    // rust: Self::Unbreakable(v) => (Key::Unbreakable, v.then_some(0)),
}
}
from_parts :: proc(key: Key, v: Maybe(i32)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match key {
    // rust: Key::MaxDamage => Self::MaxDamage(v),
    // rust: Key::Damage => Self::Damage(v),
    // rust: Key::Unbreakable => Self::Unbreakable(v.is_some()),
}
}
}
DurabilityPrototype :: struct {
    // rust: impl DurabilityPrototype {
new :: proc(changes: impl IntoIterator<Item = Change>) -> S {
    // Ported from Horizon
    return {}
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
DurabilityPatch :: struct {
    // rust: impl DurabilityPatch {
new :: proc(changes: impl IntoIterator<Item = Change>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(Patch::new(changes.into_iter().map(Change::parts)))
}
changes :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|(k, v)| Change::from_parts(*k, *v))
}
}
ComponentDurability :: struct {
    count: i32,
    air: bool,
    components: ComponentMap<Key,
}
    // rust: impl ComponentDurability {
new :: proc(prototype: ^DurabilityPrototype, count: i32, air: bool) -> S {
    // Ported from Horizon
    return {}
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
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.air || self.count <= 0
}
count :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() { 0 } else { self.count }
}
    // Raw storage remains present while the containing item stack is empty.
raw_component :: proc(self: ^Self, key: Key) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.components.get(&key).copied()
}
set :: proc(self: ^Self, change: Change) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (k, v) = change.parts();
    // rust: self.components
    // rust: .set(k, v)
    // rust: .map(|old| old.map(|v| Change::from_parts(k, Some(v))))
}
remove :: proc(self: ^Self, key: Key) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.components
    // rust: .remove(key)
    // rust: .map(|v| Change::from_parts(key, Some(v)))
}
apply_patch :: proc(self: ^Self, patch: ^DurabilityPatch) {
}
    // rust: self.components.apply_patch(&patch.0);
}
restore_patch :: proc(self: ^Self, patch: ^DurabilityPatch) {
}
    // rust: self.components.restore_patch(&patch.0);
}
as_patch :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: DurabilityPatch(self.components.as_patch())
}
max_damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: self.raw_component(Key::MaxDamage).unwrap_or(0)
}
}
damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let value = if self.is_empty() {
    // rust: 0
    // rust: } else {
    // rust: self.raw_component(Key::Damage).unwrap_or(0)
}
    // rust: value.max(0).min(self.max_damage())
}
set_damage :: proc(self: ^Self, value: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.set(Change::Damage(Some(value.max(0).min(self.max_damage()))))
    // rust: .map(|_| ())
}
is_damageable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.is_empty()
    // rust: && self.raw_component(Key::MaxDamage).is_some()
    // rust: && self.raw_component(Key::Unbreakable).is_none()
    // rust: && self.raw_component(Key::Damage).is_some()
}
is_damaged :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_damageable() && self.damage() > 0
}
is_broken :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_damageable() && self.damage() >= self.max_damage()
}
next_damage_will_break :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_damageable() && self.damage() >= self.max_damage().wrapping_sub(1)
}
grow :: proc(self: ^Self, amount: i32) {
}
    // rust: self.count = self.count().wrapping_add(amount);
}
shrink :: proc(self: ^Self, amount: i32) {
}
    // rust: self.grow(amount.wrapping_neg());
}
}
    // rust: impl DurabilityStorage for ComponentDurability {
    // rust: type Error = MissingPrototype;
is_damageable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_damageable()
}
damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.damage()
}
max_damage :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.max_damage()
}
set_damage :: proc(self: ^Self, value: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.set_damage(value)
}
is_broken :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_broken()
}
shrink :: proc(self: ^Self, amount: i32) {
}
    // rust: self.shrink(amount);
}
}
