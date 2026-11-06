//! Transpiled from Horizon Rust crate
//! Module: horizon-items_cooldowns
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `Player.getCooldowns()` (`ItemCooldowns`) as the game keeps it: the
//! `use_cooldown` component's entries by cooldown group, counted down once a
//! tick, and the percent `GuiGraphicsExtractor.itemCooldown` shades a slot
//! by. The world crate's `item_cooldowns` models vanilla's hash map and its
//! observers for the parity harness; this is the same data with the lookup a
//! slot needs, and no observer (vanilla's own player uses the plain class).
// use crate::items::ItemStack;
// use horizon_world::nbt::Tag;
// use std::collections::HashMap;
// use std::sync::Arc;

/// A stack's `minecraft:use_cooldown` component.
pub const UseCooldown = struct {
    seconds: f32,
    /// `cooldown_group`: the group the entry is filed under, else the item.
    group: ?*str,
};
    // rust: impl UseCooldown {
    /// `UseCooldown.ticks`: the seconds in ticks, truncated.
pub fn ticks(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.seconds * 20.0) as i32
}
    /// The component as `items.json` holds it.
pub fn from_json(v: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let seconds = v.get("seconds")?.as_f64()? as f32;
    // rust: Some(Self {
    // rust: seconds,
    // rust: group: v
    // rust: .get("cooldown_group")
    // rust: .and_then(|g| g.as_str())
    // rust: .map(Arc::from),
    // rust: })
}
    /// The component as a stack's saved `components` holds it.
pub fn from_tag(t: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Tag::Compound(c) = t else {
    // rust: return None;
}
    // rust: let text = |k: &str| match c.get(&horizon_world::nbt::JavaString::from(k)) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
        // NbtOps.getNumberValue: any numeric tag (vanilla's codec reads a
        // positive float).
    // rust: let seconds = horizon_world::datafix::dynamic::as_number(
    // rust: c.get(&horizon_world::nbt::JavaString::from("seconds"))?,
    // rust: )?
    // rust: .float_value();
    // rust: Some(Self {
    // rust: seconds,
    // rust: group: text("cooldown_group").map(Arc::from),
    // rust: })
}
}

/// The component a stack carries: its own patch first (`ItemStack.get`), then
/// the item's default from `items.json` (`ItemInfo::use_cooldown`).
pub fn component(stack: *ItemStack, default: ?*UseCooldown) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:use_cooldown"))
    // rust: .and_then(UseCooldown::from_tag)
    // rust: .or_else(|| default.cloned())
}

/// `ItemCooldowns.getCooldownGroup`: the component's group, else the item id.
pub fn group(stack: *ItemStack, default: ?*UseCooldown) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: component(stack, default)
    // rust: .and_then(|c| c.group)
    // rust: .unwrap_or_else(|| Arc::clone(&stack.item))
}

/// `ItemCooldowns`: start and end ticks by group, and the tick counter.
pub const Cooldowns = struct {
    tick_count: i32,
    entries: HashMap<*str,
};
    // rust: impl Cooldowns {
    /// `getCooldownPercent`: what is left of the entry, from 1 to 0.
pub fn percent(self: *Self, group: []const u8, partial_tick: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some((start, end)) = self.entries.get(group) else {
    // rust: return 0.0;
}
    // rust: let duration = end.wrapping_sub(*start) as f32;
    // rust: let remaining = *end as f32 - (self.tick_count as f32 + partial_tick);
    // rust: (remaining / duration).clamp(0.0, 1.0)
}
    /// `isOnCooldown`: whether the group still has time to run.
pub fn is_on_cooldown(self: *Self, group: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.percent(group, 0.0) > 0.0
}
    /// `addCooldown`.
pub fn add(self: *Self, group: *str, ticks: i32) void {
}
    // rust: self.entries.insert(
    // rust: group,
    // rust: (self.tick_count, self.tick_count.wrapping_add(ticks)),
    // rust: );
}
    /// `ItemCooldowns.tick`: the counter, then every entry that has run out,
    /// which it hands back (`onCooldownEnded`).
pub fn tick(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tick_count = self.tick_count.wrapping_add(1);
    // rust: let done: Vec<Arc<str>> = self
    // rust: .entries
    // rust: .iter()
    // rust: .filter(|(_, (_, end))| *end <= self.tick_count)
    // rust: .map(|(group, _)| Arc::clone(group))
    // rust: .collect();
    // rust: self.entries.retain(|_, (_, end)| *end > self.tick_count);
    // rust: done
}
    /// `removeCooldown`.
pub fn remove(self: *Self, group: []const u8) void {
}
    // rust: self.entries.remove(group);
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.is_empty()
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

pub fn stack(item: []const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack::new(item, 1)
}

pub fn the_percent_falls_from_one_to_zero_over_the_entry() void {
}
    // rust: let mut c = Cooldowns::default();
    // rust: c.add(Arc::from("minecraft:ender_pearl"), 20);
    // rust: assert!(c.is_on_cooldown("minecraft:ender_pearl"));
    // rust: assert_eq!(c.percent("minecraft:ender_pearl", 0.0), 1.0);
    // rust: for _ in 0..10 {
    // rust: assert!(c.tick().is_empty());
}
    // rust: assert_eq!(c.percent("minecraft:ender_pearl", 0.0), 0.5);
        // The partial tick moves it within the tick.
    // rust: assert_eq!(c.percent("minecraft:ender_pearl", 0.5), 0.475);
    // rust: for _ in 0..9 {
    // rust: c.tick();
}
    // rust: assert!(c.is_on_cooldown("minecraft:ender_pearl"));
        // ItemCooldowns.tick drops the entry at its end tick, and says so.
    // rust: assert_eq!(c.tick(), [Arc::<str>::from("minecraft:ender_pearl")]);
    // rust: assert!(!c.is_on_cooldown("minecraft:ender_pearl"));
    // rust: assert!(c.is_empty());
    // rust: assert_eq!(c.percent("minecraft:ender_pearl", 0.0), 0.0);
}

pub fn the_group_comes_from_the_stack_then_the_item() void {
}
    // rust: let pearl = stack("minecraft:ender_pearl");
    // rust: let default = UseCooldown::from_json(&json!({"seconds": 1.0})).expect("the component");
    // rust: assert_eq!(&*group(&pearl, Some(&default)), "minecraft:ender_pearl");
        // A stack's own component overrides the item's, group included.
    // rust: let mut grouped = stack("minecraft:ender_pearl");
    // rust: grouped.data_mut().set_other(
    // rust: "minecraft:use_cooldown",
    // rust: Some(Tag::compound([
    // rust: ("seconds", Tag::Float(2.0f32.to_bits())),
    // rust: ("cooldown_group", Tag::String("minecraft:pearls".into())),
    // rust: ])),
    // rust: );
    // rust: let c = component(&grouped, Some(&default)).expect("the stack's component");
    // rust: assert_eq!(c.ticks(), 40);
    // rust: assert_eq!(&*group(&grouped, Some(&default)), "minecraft:pearls");
        // An item without the component has no cooldown.
    // rust: assert!(component(&stack("minecraft:dirt"), None).is_none());
}

pub fn the_seconds_read_from_any_numeric_tag() void {
}
    // rust: let from = |seconds: Tag| UseCooldown::from_tag(&Tag::compound([("seconds", seconds)]));
        // An integer tag was dropped before (#7638); seconds: 5 is 100 ticks.
    // rust: let int = from(Tag::Int(5)).expect("the component");
    // rust: assert_eq!(int.seconds, 5.0);
    // rust: assert_eq!(int.ticks(), 100);
        // The other numeric tags read the same way.
    // rust: assert_eq!(from(Tag::Byte(5)).unwrap().seconds, 5.0);
    // rust: assert_eq!(from(Tag::Long(5)).unwrap().seconds, 5.0);
    // rust: assert_eq!(from(Tag::Double(2.5f64.to_bits())).unwrap().seconds, 2.5);
        // The float path keeps working.
    // rust: assert_eq!(from(Tag::Float(5.0f32.to_bits())).unwrap().seconds, 5.0);
}
}
