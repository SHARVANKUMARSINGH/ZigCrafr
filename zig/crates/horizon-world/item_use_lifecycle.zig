//! Transpiled from Horizon Rust crate
//! Module: horizon-world_item_use_lifecycle
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Living item-use lifecycle ordering over stable item-stack handles.
pub const UseState = struct {
    item: I,
    remaining: i32,
    has_recent_kinetic_enemies: bool,
};
    // rust: pub trait UseLifecycleWorld: Sized {
    // rust: type Error;
    // rust: type Item: Clone + Eq;
    // rust: type Hand: Copy;
    // rust: type Level: Copy;
pub fn empty_item(self: *Self) S;
pub fn is_empty(self: *Self, item: Self::Item) b;
pub fn same_item_type(self: *Self, a: Self::Item, b: Self::Item) b;
pub fn using_item(self: *Self, s: *mut UseState<Self::Item>) R;
pub fn used_hand(self: *Self, s: *mut UseState<Self::Item>) R;
    // rust: fn hand_item(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: hand: Self::Hand,
    // rust: ) -> Result<Self::Item, Self::Error>;
    // rust: fn set_hand_item(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: hand: Self::Hand,
    // rust: item: Self::Item,
    // rust: ) -> Result<(), Self::Error>;
pub fn level(self: *Self, s: *mut UseState<Self::Item>) R;
    // rust: fn is_client(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: level: Self::Level,
    // rust: ) -> Result<bool, Self::Error>;
pub fn remaining_ticks(self: *Self, s: *mut UseState<Self::Item>) R;
    // rust: fn item_tick(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: item: Self::Item,
    // rust: level: Self::Level,
    // rust: remaining: i32,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn use_on_release(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: item: Self::Item,
    // rust: ) -> Result<bool, Self::Error>;
    // rust: fn release_item(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: item: Self::Item,
    // rust: level: Self::Level,
    // rust: remaining: i32,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn finish_item(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: item: Self::Item,
    // rust: level: Self::Level,
    // rust: ) -> Result<Self::Item, Self::Error>;
    // rust: fn set_using_flag(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: using: bool,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn finish_vibration(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: item: Self::Item,
    // rust: ) -> Result<(), Self::Error>;
    // rust: fn update_using_item(
    // rust: &mut self,
    // rust: s: &mut UseState<Self::Item>,
    // rust: item: Self::Item,
    // rust: ) -> Result<(), Self::Error> {
    // rust: update(self, s, item)
}
pub fn complete_using_item(self: *Self, s: *mut UseState<Self::Item>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: complete(self, s)
}
pub fn release_using_item(self: *Self, s: *mut UseState<Self::Item>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: release(self, s)
}
pub fn stop_using_item(self: *Self, s: *mut UseState<Self::Item>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stop(self, s)
}
}
    // rust: pub fn tick<W: UseLifecycleWorld>(w: &mut W, s: &mut UseState<W::Item>) -> Result<(), W::Error> {
    // rust: if w.using_item(s)? {
    // rust: let hand = w.used_hand(s)?;
    // rust: let held = w.hand_item(s, hand)?;
    // rust: if w.same_item_type(held.clone(), s.item.clone()) {
    // rust: let hand = w.used_hand(s)?;
    // rust: s.item = w.hand_item(s, hand)?;
    // rust: w.update_using_item(s, s.item.clone())?;
    // rust: } else {
    // rust: w.stop_using_item(s)?;
}
}
    // rust: Ok(())
}
    // rust: pub fn update<W: UseLifecycleWorld>(
    // rust: w: &mut W,
    // rust: s: &mut UseState<W::Item>,
    // rust: item: W::Item,
    // rust: ) -> Result<(), W::Error> {
    // rust: let level = w.level(s)?;
    // rust: let remaining = w.remaining_ticks(s)?;
    // rust: w.item_tick(s, item.clone(), level, remaining)?;
    // rust: s.remaining = s.remaining.wrapping_sub(1);
    // rust: if s.remaining == 0 {
    // rust: let level = w.level(s)?;
    // rust: if !w.is_client(s, level)? && !w.use_on_release(s, item)? {
    // rust: w.complete_using_item(s)?;
}
}
    // rust: Ok(())
}
    // rust: pub fn complete<W: UseLifecycleWorld>(
    // rust: w: &mut W,
    // rust: s: &mut UseState<W::Item>,
    // rust: ) -> Result<(), W::Error> {
    // rust: let level = w.level(s)?;
    // rust: if w.is_client(s, level)? && !w.using_item(s)? {
    // rust: return Ok(());
}
    // rust: let hand = w.used_hand(s)?;
    // rust: let original = s.item.clone();
    // rust: if original != w.hand_item(s, hand)? {
    // rust: w.release_using_item(s)?;
    // rust: return Ok(());
}
    // rust: if !w.is_empty(s.item.clone()) && w.using_item(s)? {
    // rust: let item = s.item.clone();
    // rust: let level = w.level(s)?;
    // rust: let result = w.finish_item(s, item, level)?;
    // rust: if result != s.item {
    // rust: w.set_hand_item(s, hand, result)?;
}
    // rust: w.stop_using_item(s)?;
}
    // rust: Ok(())
}
    // rust: pub fn release<W: UseLifecycleWorld>(w: &mut W, s: &mut UseState<W::Item>) -> Result<(), W::Error> {
    // rust: let hand = w.used_hand(s)?;
    // rust: let held = w.hand_item(s, hand)?;
    // rust: if !w.is_empty(s.item.clone()) && w.same_item_type(held.clone(), s.item.clone()) {
    // rust: s.item = held;
    // rust: let item = s.item.clone();
    // rust: let level = w.level(s)?;
    // rust: let remaining = w.remaining_ticks(s)?;
    // rust: w.release_item(s, item, level, remaining)?;
    // rust: if w.use_on_release(s, s.item.clone())? {
    // rust: tick(w, s)?;
}
}
    // rust: w.stop_using_item(s)
}
    // rust: pub fn stop<W: UseLifecycleWorld>(w: &mut W, s: &mut UseState<W::Item>) -> Result<(), W::Error> {
    // rust: let level = w.level(s)?;
    // rust: if !w.is_client(s, level)? {
    // rust: let using = w.using_item(s)?;
    // rust: s.has_recent_kinetic_enemies = false;
    // rust: w.set_using_flag(s, false)?;
    // rust: if using {
    // rust: w.finish_vibration(s, s.item.clone())?;
}
}
    // rust: s.item = w.empty_item();
    // rust: s.remaining = 0;
    // rust: Ok(())
}
