//! Transpiled from Horizon Rust crate
package horizon_world_item_cooldowns

import "core:fmt"
import "core:mem"
import "core:math"

// Item cooldown storage with native hash-map expiry order and callback prefixes.
// use crate::java_hash_map::{CursorError, JavaHashMap, JavaKey};
CooldownInstance :: struct {
    start: i32,
    end: i32,
}
ItemCooldowns :: struct {
    tick_count: i32,
    entries: JavaHashMap<K,
}
    // rust: pub trait Observer<K: JavaKey + Clone> {
    // rust: type Error;
    // rust: fn started(
    // rust: &mut self,
    // rust: cooldowns: &mut ItemCooldowns<K>,
    // rust: group: K,
    // rust: duration: i32,
    // rust: ) -> Result<(), Self::Error>;
ended :: proc(self: ^Self, cooldowns: ^ItemCooldowns<K>, group: K) -> R {
    // Ported from Horizon
    return {}
}
}
TickError :: enum {
    Iterator(CursorError),
    Observer(E),
}
    // rust: impl<K: JavaKey + Clone> Default for ItemCooldowns<K> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: tick_count: 0,
    // rust: entries: JavaHashMap::default(),
}
}
}
    // rust: impl<K: JavaKey + Clone> ItemCooldowns<K> {
entries :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.entries.entries()
}
percent :: proc(self: ^Self, group: ^K, partial_tick: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let Some(instance) = self.entries.get(group) else {
    // rust: return 0.0;
}
    // rust: let duration = instance.end.wrapping_sub(instance.start) as f32;
    // rust: let remaining = instance.end as f32 - (self.tick_count as f32 + partial_tick);
    // rust: (remaining / duration).clamp(0.0, 1.0)
}
is_on_cooldown :: proc(self: ^Self, group: ^K) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.percent(group, 0.0) > 0.0
}
    // rust: pub fn add<O: Observer<K>>(
    // rust: &mut self,
    // rust: group: K,
    // rust: duration: i32,
    // rust: observer: &mut O,
    // rust: ) -> Result<(), O::Error> {
    // rust: self.entries.put(
    // rust: group.clone(),
    // rust: CooldownInstance {
    // rust: start: self.tick_count,
    // rust: end: self.tick_count.wrapping_add(duration),
    // rust: },
    // rust: );
    // rust: observer.started(self, group, duration)
}
    // rust: pub fn remove<O: Observer<K>>(&mut self, group: K, observer: &mut O) -> Result<(), O::Error> {
    // rust: self.entries.remove(&group);
    // rust: observer.ended(self, group)
}
    // rust: pub fn tick<O: Observer<K>>(&mut self, observer: &mut O) -> Result<(), TickError<O::Error>> {
    // rust: self.tick_count = self.tick_count.wrapping_add(1);
    // rust: let mut cursor = self.entries.cursor();
    // rust: while cursor.has_next() {
    // rust: let (key, instance) = self
    // rust: .entries
    // rust: .next_entry(&mut cursor)
    // rust: .map_err(TickError::Iterator)?
    // rust: .unwrap();
    // rust: if instance.end <= self.tick_count {
    // rust: let key = key.clone();
    // rust: self.entries
    // rust: .remove_current(&mut cursor)
    // rust: .map_err(TickError::Iterator)?;
    // rust: observer.ended(self, key).map_err(TickError::Observer)?;
}
}
    // rust: Ok(())
}
}
UseCooldown :: struct {
    seconds: f32,
    group: Maybe(K),
}
    // rust: impl<K: PartialEq> PartialEq for UseCooldown<K> {
eq :: proc(self: ^Self, other: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let bits = |v: f32| if v.is_nan() { 0x7fc00000 } else { v.to_bits() };
    // rust: bits(self.seconds) == bits(other.seconds) && self.group == other.group
}
}
    // rust: impl<K> UseCooldown<K> {
ticks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (self.seconds * 20.0) as i32
}
}
// The registered item identifier is fetched even when the component has a group.
    // rust: pub fn group<K: Clone>(
    // rust: component: Option<&UseCooldown<K>>,
    // rust: item_identifier: impl FnOnce() -> K,
    // rust: ) -> K {
    // rust: let item = item_identifier();
    // rust: component.and_then(|c| c.group.clone()).unwrap_or(item)
}

// The player query is a class test; retrieving its cooldown manager is virtual.
    // rust: pub trait CooldownUser {
    // rust: type Error;
    // rust: type Stack;
    // rust: type Manager;
is_player :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
cooldowns :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn add_cooldown(
    // rust: &mut self,
    // rust: manager: Self::Manager,
    // rust: stack: Self::Stack,
    // rust: ticks: i32,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: impl<K> UseCooldown<K> {
    // rust: pub fn apply<W: CooldownUser>(&self, user: &mut W, stack: W::Stack) -> Result<(), W::Error> {
    // rust: if user.is_player() {
    // rust: let manager = user.cooldowns()?;
    // rust: user.add_cooldown(manager, stack, self.ticks())?;
}
    // rust: Ok(())
}
}
