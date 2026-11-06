//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_item_energy
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Energy held by item stacks for native mods (docs/native-mods.md): a mod's
//! batteries and charged tools (`native_item_energy_buffer`), read, filled
//! and drained. Vanilla has no energy; the contract is NeoForge's
//! `Capabilities.Energy.ITEM`, an `EnergyHandler` reached through an
//! `ItemAccess`: it acts on one item of a stack at a time and may change it.
//! So do these, as the item fluid helpers (`native_item_fluids.rs`) do: they
//! take a stack and answer without changing it, and the caller shrinks its
//! stack by one and hands out the changed item they return. They hold no
//! world state, so they work on any side.
// use super::Game;
// use horizon_client::items::ItemStack;
// use horizon_world::nbt::{Compound, JavaString, Tag};

/// The buffer a mod item declares (`native_item_energy_buffer`), as
/// NeoForge's `SimpleEnergyHandler` is built: its capacity and the most one
/// insert and one extract move.
pub const ItemEnergyBuffer = struct {
    capacity: i32,
    /// The most one insert moves; 0 takes none.
    max_insert: i32,
    /// The most one extract moves; 0 gives none.
    max_extract: i32,
};

/// What one item of a stack holds (`native_item_energy`).
    // rust: pub(crate) struct NativeItemEnergy {
    // rust: pub(crate) amount: i32,
    // rust: pub(crate) capacity: i32,
    /// The most one insert moves.
    // rust: pub(crate) max_insert: i32,
    /// The most one extract moves.
    // rust: pub(crate) max_extract: i32,
}

pub const CUSTOM_DATA: []const u8 = "minecraft:custom_data";
/// The int under `minecraft:custom_data` that keeps the amount, as a mod
/// block's buffer keeps it under `energy`.
pub const ENERGY: []const u8 = "horizon_energy";

/// The buffer as declared, or none when its capacity is under 1; the limits
/// are clamped to 0..=capacity, as a block's are.
pub fn checked(buffer: ItemEnergyBuffer) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (buffer.capacity >= 1).then(|| ItemEnergyBuffer {
    // rust: capacity: buffer.capacity,
    // rust: max_insert: buffer.max_insert.clamp(0, buffer.capacity),
    // rust: max_extract: buffer.max_extract.clamp(0, buffer.capacity),
    // rust: })
}

/// The amount a stack keeps in its `custom_data`: anything but an int, or a
/// negative, reads as empty.
pub fn read_energy(stack: *ItemStack) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::Compound(data)) = stack.data().and_then(|d| d.other(CUSTOM_DATA)) else {
    // rust: return 0;
}
    // rust: match data.get(&JavaString::from(ENERGY)) {
    // rust: Some(Tag::Int(energy)) => (*energy).max(0),
    // rust: _ => 0,
}
}

/// One item of `stack`, unchanged.
pub fn one_of(stack: *ItemStack) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut one = stack.clone();
    // rust: one.count = 1;
    // rust: one
}

/// One item of `stack` holding `energy`, its other data kept. An empty item
/// carries nothing, so empty batteries stack with new ones.
pub fn with_energy(stack: *ItemStack, energy: i32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut one = one_of(stack);
    // rust: let mut data = match one.data().and_then(|d| d.other(CUSTOM_DATA)) {
    // rust: Some(Tag::Compound(data)) => data.clone(),
    // rust: _ => Compound::new(),
}
    // rust: if energy > 0 {
    // rust: data.insert(JavaString::from(ENERGY), Tag::Int(energy));
    // rust: } else {
    // rust: data.remove(&JavaString::from(ENERGY));
}
    // rust: let value = (!data.is_empty()).then_some(Tag::Compound(data));
    // rust: one.data_mut().set_other(CUSTOM_DATA, value);
    // What a server sent for the stack no longer describes it; kept, an
    // emptied battery would not stack with a new one.
    // rust: one.data_mut().wire = Default::default();
    // rust: one.tidy();
    // rust: one
}

/// What one item of `stack` holds, if it has a buffer.
pub fn contents(stack: *ItemStack, buffer: ?ItemEnergyBuffer) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let buffer = buffer?;
    // rust: (stack.count > 0).then(|| NativeItemEnergy {
    // rust: amount: read_energy(stack),
    // rust: capacity: buffer.capacity,
    // rust: max_insert: buffer.max_insert,
    // rust: max_extract: buffer.max_extract,
    // rust: })
}

/// `SimpleEnergyHandler.insert` on one item of `stack`: the room left (none
/// when it holds more than its capacity), the call's limit and what was
/// offered, whichever is least; and the item it becomes.
    // rust: fn insert_one(
    // rust: stack: &ItemStack,
    // rust: buffer: Option<ItemEnergyBuffer>,
    // rust: offered: i32,
    // rust: ) -> Option<(i32, ItemStack)> {
    // rust: let held = contents(stack, buffer)?;
    // rust: let took = (held.capacity.saturating_sub(held.amount))
    // rust: .min(offered)
    // rust: .min(held.max_insert)
    // rust: .max(0);
    // rust: if took == 0 {
    // rust: return Some((0, one_of(stack)));
}
    // rust: Some((took, with_energy(stack, held.amount + took)))
}

/// `SimpleEnergyHandler.extract` on one item of `stack`: what it holds, the
/// call's limit and what was asked, whichever is least; and the item it
/// becomes.
    // rust: fn extract_one(
    // rust: stack: &ItemStack,
    // rust: buffer: Option<ItemEnergyBuffer>,
    // rust: asked: i32,
    // rust: ) -> Option<(i32, ItemStack)> {
    // rust: let held = contents(stack, buffer)?;
    // rust: let gave = held.amount.min(asked).min(held.max_extract).max(0);
    // rust: if gave == 0 {
    // rust: return Some((0, one_of(stack)));
}
    // rust: Some((gave, with_energy(stack, held.amount - gave)))
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// The buffer a mod gave item `item`, checked; none for any other item.
pub fn native_item_energy_of(self: *Self, item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if item.starts_with("minecraft:") {
    // rust: return None;
}
    // rust: let mut buffer = None;
    // rust: self.native_item_energy_buffer(item, &mut buffer);
    // rust: buffer.and_then(checked)
}
    /// `Capabilities.Energy.ITEM`, read: the amount, capacity and limits per
    /// call of one item of `stack`, which keeps the amount in its
    /// `custom_data`. None for an item without a buffer, and for an empty
    /// stack.
    // rust: pub(in crate::game) fn native_item_energy(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: ) -> Option<NativeItemEnergy> {
    // rust: contents(stack, self.native_item_energy_of(&stack.item))
}
    /// `EnergyHandler.insert`: up to `amount` into one item of `stack`, no
    /// more than its room and its limit per call. The amount that went in,
    /// and the single item it becomes (the item itself when it took
    /// nothing). The stack given is not changed: shrink it by one and hand
    /// out the result, or leave the result unused to simulate. None where
    /// the item has no buffer.
    // rust: pub(in crate::game) fn native_item_energy_insert(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: amount: i32,
    // rust: ) -> Option<(i32, ItemStack)> {
    // rust: insert_one(stack, self.native_item_energy_of(&stack.item), amount)
}
    /// `EnergyHandler.extract`: up to `amount` out of one item of `stack`,
    /// no more than it holds and its limit per call. The amount that came
    /// out, and the single item it becomes. The stack given is not changed,
    /// as with `native_item_energy_insert`. None where the item has no
    /// buffer.
    // rust: pub(in crate::game) fn native_item_energy_extract(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: amount: i32,
    // rust: ) -> Option<(i32, ItemStack)> {
    // rust: extract_one(stack, self.native_item_energy_of(&stack.item), amount)
}
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::Arc;

pub fn battery(count: u32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack::new("mymod:battery", count)
}

pub fn buffer(capacity: i32, max_insert: i32, max_extract: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: checked(ItemEnergyBuffer {
    // rust: capacity,
    // rust: max_insert,
    // rust: max_extract,
    // rust: })
}

pub fn an_insert_stops_at_the_room_the_limit_and_the_offer() void {
}
    // rust: let b = buffer(1000, 300, 1000);
    // rust: let (took, one) = insert_one(&battery(5), b, 200).unwrap();
    // rust: assert_eq!((took, one.count, read_energy(&one)), (200, 1, 200));
    // rust: let (took, one) = insert_one(&one, b, 5000).unwrap();
    // rust: assert_eq!((took, read_energy(&one)), (300, 500));
    // rust: let (_, one) = insert_one(&one, b, 300).unwrap();
    // rust: let (_, one) = insert_one(&one, b, 300).unwrap();
    // rust: assert_eq!(read_energy(&one), 1000);
    // rust: assert_eq!(insert_one(&one, b, 1).unwrap().0, 0);
        // Nothing offered, or a negative offer, moves nothing.
    // rust: assert_eq!(insert_one(&battery(1), b, 0).unwrap(), (0, battery(1)));
    // rust: assert_eq!(insert_one(&battery(1), b, -50).unwrap(), (0, battery(1)));
}

pub fn an_extract_stops_at_what_is_held_the_limit_and_the_ask() void {
}
    // rust: let b = buffer(1000, 1000, 150);
    // rust: let (_, full) = insert_one(&battery(1), b, 400).unwrap();
    // rust: let (gave, rest) = extract_one(&full, b, 100).unwrap();
    // rust: assert_eq!((gave, read_energy(&rest)), (100, 300));
    // rust: let (gave, rest) = extract_one(&rest, b, 1000).unwrap();
    // rust: assert_eq!((gave, read_energy(&rest)), (150, 150));
    // rust: let (gave, empty) = extract_one(&rest, b, 1000).unwrap();
    // rust: assert_eq!(gave, 150);
        // Nothing left, so it is a new battery again and stacks with one.
    // rust: assert_eq!(empty, battery(1));
    // rust: assert_eq!(extract_one(&empty, b, 10).unwrap(), (0, battery(1)));
}

pub fn a_zero_limit_closes_that_way_only() void {
}
        // A generator's output cell: it gives, and takes nothing.
    // rust: let source = buffer(500, 0, 500);
    // rust: assert_eq!(insert_one(&battery(1), source, 100).unwrap().0, 0);
    // rust: let sink = buffer(500, 500, 0);
    // rust: let (_, charged) = insert_one(&battery(1), sink, 100).unwrap();
    // rust: assert_eq!(extract_one(&charged, sink, 100).unwrap().0, 0);
    // rust: assert_eq!(extract_one(&charged, source, 100).unwrap().0, 100);
}

pub fn a_buffer_is_checked_as_a_blocks_is() void {
}
    // rust: assert_eq!(buffer(0, 10, 10), None);
    // rust: assert_eq!(buffer(-5, 10, 10), None);
    // rust: assert_eq!(
    // rust: buffer(100, 500, -3),
    // rust: Some(ItemEnergyBuffer {
    // rust: capacity: 100,
    // rust: max_insert: 100,
    // rust: max_extract: 0,
    // rust: })
    // rust: );
}

pub fn items_without_a_buffer_hold_nothing() void {
}
    // rust: assert_eq!(contents(&battery(1), None), None);
    // rust: assert_eq!(insert_one(&battery(1), None, 10), None);
    // rust: assert_eq!(extract_one(&battery(1), None, 10), None);
    // rust: assert_eq!(contents(&battery(0), buffer(100, 10, 10)), None);
}

pub fn what_a_stack_holds_reads_back_with_its_limits() void {
}
    // rust: let b = buffer(2000, 50, 75);
    // rust: let (_, one) = insert_one(&battery(1), b, 50).unwrap();
    // rust: assert_eq!(
    // rust: contents(&one, b),
    // rust: Some(NativeItemEnergy {
    // rust: amount: 50,
    // rust: capacity: 2000,
    // rust: max_insert: 50,
    // rust: max_extract: 75,
    // rust: })
    // rust: );
        // A damaged or foreign value reads as empty.
    // rust: let mut odd = battery(1);
    // rust: odd.data_mut().set_other(
    // rust: CUSTOM_DATA,
    // rust: Some(Tag::compound([(
    // rust: ENERGY,
    // rust: Tag::String(JavaString::from("9")),
    // rust: )])),
    // rust: );
    // rust: assert_eq!(read_energy(&odd), 0);
    // rust: odd.data_mut()
    // rust: .set_other(CUSTOM_DATA, Some(Tag::compound([(ENERGY, Tag::Int(-40))])));
    // rust: assert_eq!(read_energy(&odd), 0);
}

pub fn more_than_the_capacity_takes_nothing_and_still_gives() void {
}
        // A mod that shrank its capacity after the item was charged.
    // rust: let mut over = battery(1);
    // rust: over.data_mut()
    // rust: .set_other(CUSTOM_DATA, Some(Tag::compound([(ENERGY, Tag::Int(900))])));
    // rust: let b = buffer(500, 500, 500);
    // rust: assert_eq!(insert_one(&over, b, 100).unwrap().0, 0);
    // rust: let (gave, rest) = extract_one(&over, b, 1000).unwrap();
    // rust: assert_eq!((gave, read_energy(&rest)), (500, 400));
}

pub fn an_emptied_battery_from_a_server_stacks_with_a_new_one() void {
}
    // rust: let b = buffer(100, 100, 100);
    // rust: let mut sent = battery(2);
    // rust: sent.data_mut().wire =
    // rust: horizon_client::item_data::Wire::new(battery(2), Arc::from(vec![1u8]));
    // rust: let (_, charged) = insert_one(&sent, b, 40).unwrap();
    // rust: let (_, emptied) = extract_one(&charged, b, 40).unwrap();
    // rust: assert!(emptied.same_item_same_components(&battery(1)));
}

pub fn a_battery_keeps_the_rest_of_its_custom_data() void {
}
    // rust: let b = buffer(1000, 1000, 1000);
    // rust: let mut stack = battery(1);
    // rust: stack.data_mut().set_other(
    // rust: CUSTOM_DATA,
    // rust: Some(Tag::compound([(
    // rust: "owner",
    // rust: Tag::String(JavaString::from("Alex")),
    // rust: )])),
    // rust: );
    // rust: let (_, charged) = insert_one(&stack, b, 10).unwrap();
    // rust: let Some(Tag::Compound(data)) = charged.data().and_then(|d| d.other(CUSTOM_DATA)) else {
    // rust: panic!("no custom data");
}
    // rust: assert!(data.contains_key(&JavaString::from("owner")));
    // rust: assert_eq!(data.get(&JavaString::from(ENERGY)), Some(&Tag::Int(10)));
    // rust: let (_, emptied) = extract_one(&charged, b, 10).unwrap();
    // rust: assert_eq!(emptied, stack);
}
}
