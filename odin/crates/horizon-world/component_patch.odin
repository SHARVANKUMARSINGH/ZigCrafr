//! Transpiled from Horizon Rust crate
package horizon_world_component_patch

import "core:fmt"
import "core:mem"
import "core:math"

// Shared immutable prototypes with ordered, copy-on-write component patches.
// Keys stand for stable component-type identities. Callers supply prototype
// iteration order and values whose equality matches their native component.
// use std::{fmt, sync::Arc};
Prototype :: struct {
Patch :: struct {
ComponentMap :: struct {
    prototype: Prototype<K,
    patch: Patch<K,
}
MissingPrototype :: struct {
    // rust: impl fmt::Display for MissingPrototype {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str("removed component has no prototype value")
}
}
    // rust: impl std::error::Error for MissingPrototype {}
    // rust: fn index<K: Eq, V>(entries: &[(K, V)], key: &K) -> Option<usize> {
    // rust: entries.iter().position(|(k, _)| k == key)
}
    // rust: fn put<K: Eq, V>(entries: &mut Vec<(K, V)>, key: K, value: V) -> Option<V> {
    // rust: if let Some(i) = index(entries, &key) {
    // rust: Some(std::mem::replace(&mut entries[i].1, value))
    // rust: } else {
    // rust: entries.push((key, value));
    // rust: None
}
}
    // rust: fn remove<K: Eq, V>(entries: &mut Vec<(K, V)>, key: &K) -> Option<V> {
    // rust: index(entries, key).map(|i| entries.remove(i).1)
}
    // rust: fn map_equal<K: Eq, V: PartialEq>(a: &[(K, V)], b: &[(K, V)]) -> bool {
    // rust: a.len() == b.len()
    // rust: && a.iter()
    // rust: .all(|(k, v)| index(b, k).is_some_and(|i| b[i].1 == *v))
}
    // rust: impl<K: Clone + Eq, V: Clone + PartialEq> Prototype<K, V> {
new :: proc(entries: impl IntoIterator<Item = (K) {
}
    // rust: let mut values = Vec::new();
    // rust: for (k, v) in entries {
    // rust: put(&mut values, k, v);
}
    // rust: Self(Arc::new(values))
}
get :: proc(self: ^Self, key: ^K) -> O {
    // Ported from Horizon
    return {}
}
    // rust: index(&self.0, key).map(|i| &self.0[i].1)
}
entries :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.0
}
}
    // rust: impl<K: Clone + Eq, V: Clone + PartialEq> Patch<K, V> {
    // None is an explicit removal, distinct from a missing patch entry.
new :: proc(entries: impl IntoIterator<Item = (K) {
}
    // rust: let mut values = Vec::new();
    // rust: for (k, v) in entries {
    // rust: put(&mut values, k, v);
}
    // rust: Self(Arc::new(values))
}
entries :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.0
}
}
    // rust: impl<K: Clone + Eq, V: Clone + PartialEq> ComponentMap<K, V> {
new :: proc(prototype: Prototype<K) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: prototype,
    // rust: patch: Patch(Arc::new(Vec::new())),
}
}
from_patch :: proc(prototype: Prototype<K, patch: ^Patch<K) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let sanitized = patch.0.iter().all(|(k, v)| match v {
    // rust: Some(v) => Some(v) != prototype.get(k),
    // rust: None => prototype.get(k).is_some(),
    // rust: });
    // rust: if sanitized {
    // rust: Self {
    // rust: prototype,
    // rust: patch: patch.clone(),
}
    // rust: } else {
    // rust: let mut result = Self::new(prototype);
    // rust: result.apply_patch(patch);
    // rust: result
}
}
prototype :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.prototype
}
get :: proc(self: ^Self, key: ^K) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match index(&self.patch.0, key) {
    // rust: Some(i) => self.patch.0[i].1.as_ref(),
    // rust: None => self.prototype.get(key),
}
}
has_non_default :: proc(self: ^Self, key: ^K) -> b {
    // Ported from Horizon
    return {}
}
    // rust: index(&self.patch.0, key).is_some()
}
    // Vanilla set returns the prototype value for an earlier removal marker.
    // An unsanitized removal with no prototype causes an error after mutation.
set :: proc(self: ^Self, key: K, value: Maybe(V)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let base = self.prototype.get(&key).cloned();
    // rust: let entries = Arc::make_mut(&mut self.patch.0);
    // rust: let previous = if value == base {
    // rust: remove(entries, &key)
    // rust: } else {
    // rust: put(entries, key, value)
}
    // rust: match previous {
    // rust: Some(Some(v)) => Ok(Some(v)),
    // rust: Some(None) => base.map(Some).ok_or(MissingPrototype),
    // rust: None => Ok(base),
}
}
remove :: proc(self: ^Self, key: K) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let base = self.prototype.get(&key).cloned();
    // rust: let entries = Arc::make_mut(&mut self.patch.0);
    // rust: let previous = if base.is_some() {
    // rust: put(entries, key, None)
    // rust: } else {
    // rust: remove(entries, &key)
}
    // rust: previous.unwrap_or(base)
}
apply_patch :: proc(self: ^Self, patch: ^Patch<K) {
}
    // rust: let entries = Arc::make_mut(&mut self.patch.0);
    // rust: for (k, v) in patch.0.iter() {
    // rust: if v.as_ref() == self.prototype.get(k) {
    // rust: remove(entries, k);
    // rust: } else {
    // rust: put(entries, k.clone(), v.clone());
}
}
}
    // Restore preserves redundant values and removals, unlike apply_patch.
restore_patch :: proc(self: ^Self, patch: ^Patch<K) {
}
    // rust: self.patch = patch.clone();
}
clear_patch :: proc(self: ^Self) {
}
    // rust: self.patch = Patch(Arc::new(Vec::new()));
}
as_patch :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: self.patch.clone()
}
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.entries().count()
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.len() == 0
}
    // Patched values precede untouched prototype values; removed keys vanish.
entries :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.patch
    // rust: .0
    // rust: .iter()
    // rust: .filter_map(|(k, v)| v.as_ref().map(|v| (k, v)))
    // rust: .chain(
    // rust: self.prototype
    // rust: .0
    // rust: .iter()
    // rust: .filter(|(k, _)| !self.has_non_default(k))
    // rust: .map(|(k, v)| (k, v)),
    // rust: )
}
    // Key-set order instead starts with prototype keys, then applies the patch.
keys :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut keys: Vec<_> = self.prototype.0.iter().map(|(k, _)| k.clone()).collect();
    // rust: for (k, v) in self.patch.0.iter() {
    // rust: let i = keys.iter().position(|key| key == k);
    // rust: if v.is_some() {
    // rust: if i.is_none() {
    // rust: keys.push(k.clone());
}
    // rust: } else if let Some(i) = i {
    // rust: keys.remove(i);
}
}
    // rust: keys
}
}
    // rust: impl<K: Eq, V: PartialEq> PartialEq for ComponentMap<K, V> {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: map_equal(&self.prototype.0, &other.prototype.0) && map_equal(&self.patch.0, &other.patch.0)
}
}

    // rust: impl<K: Eq, V: PartialEq> PartialEq for Patch<K, V> {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: map_equal(&self.0, &other.0)
}
}
