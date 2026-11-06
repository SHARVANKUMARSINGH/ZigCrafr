//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_item_fluids
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Fluids held by item stacks for native mods (docs/native-mods.md): vanilla's
//! buckets, and a mod's own containers (`native_item_fluid_tank`), read,
//! filled and drained in millibuckets. NeoForge's
//! `Capabilities.FluidHandler.ITEM` acts on one item of a stack at a time and
//! may swap the item for another; so do these. They take a stack and answer
//! without changing it: the caller shrinks its stack by one and hands out the
//! changed container they return. They hold no world state, so they work on
//! any side.
// use super::Game;
// use horizon_client::items::ItemStack;
// use horizon_world::nbt::{Compound, JavaString, Tag};

/// What one item of a stack holds (`native_item_fluid`).
    // rust: pub(crate) struct NativeItemFluid {
    /// `minecraft:water` or `minecraft:lava`; none when it is empty.
    // rust: pub(crate) fluid: Option<String>,
    /// In millibuckets: a bucket is a thousand.
    // rust: pub(crate) amount: i32,
    // rust: pub(crate) capacity: i32,
}

pub const CUSTOM_DATA: []const u8 = "minecraft:custom_data";
/// The key under `minecraft:custom_data` that keeps a mod container's
/// contents: `{Fluid: "minecraft:water", Amount: 250}`.
pub const TANK: []const u8 = "horizon_fluid";
/// A bucket's capacity, vanilla's `FluidType.BUCKET_VOLUME`.
pub const BUCKET: i32 = 1000;
pub const MOD_CAPACITY: std::ops::RangeInclusive<i32> = 1..=1_000_000;

/// The bucket items: (empty, full), by the fluid they hold. A bucket is all
/// or nothing, as `BucketItem` is. Milk, powder snow and fish buckets hold
/// no fluid Horizon models.
    // rust: const BUCKETS: [(&str, &str); 2] = [
    // rust: ("minecraft:water", "minecraft:water_bucket"),
    // rust: ("minecraft:lava", "minecraft:lava_bucket"),
    // rust: ];

pub fn is_fluid(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BUCKETS.iter().any(|(fluid, _)| *fluid == name)
}

/// The contents a mod container's stack keeps in its `custom_data`: none and
/// 0 when empty, or when what is there isn't a tank.
pub fn read_tank(stack: *ItemStack) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::Compound(data)) = stack.data().and_then(|d| d.other(CUSTOM_DATA)) else {
    // rust: return (None, 0);
}
    // rust: let Some(Tag::Compound(tank)) = data.get(&JavaString::from(TANK)) else {
    // rust: return (None, 0);
}
    // rust: let amount = match tank.get(&JavaString::from("Amount")) {
    // rust: Some(Tag::Int(amount)) => (*amount).max(0),
    // rust: _ => 0,
}
    // rust: match tank.get(&JavaString::from("Fluid")) {
    // rust: Some(Tag::String(fluid)) if amount > 0 => (Some(fluid.to_string_lossy()), amount),
    // rust: _ => (None, 0),
}
}

/// One item of `stack` holding `amount` of `fluid`, its other data kept. An
/// empty tank carries nothing, so empty containers stack.
pub fn with_tank(stack: *ItemStack, fluid: []const u8, amount: i32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut one = stack.clone();
    // rust: one.count = 1;
    // rust: let mut data = match one.data().and_then(|d| d.other(CUSTOM_DATA)) {
    // rust: Some(Tag::Compound(data)) => data.clone(),
    // rust: _ => Compound::new(),
}
    // rust: if amount > 0 {
    // rust: data.insert(
    // rust: JavaString::from(TANK),
    // rust: Tag::compound([
    // rust: ("Fluid", Tag::String(JavaString::from(fluid))),
    // rust: ("Amount", Tag::Int(amount)),
    // rust: ]),
    // rust: );
    // rust: } else {
    // rust: data.remove(&JavaString::from(TANK));
}
    // rust: let value = (!data.is_empty()).then_some(Tag::Compound(data));
    // rust: one.data_mut().set_other(CUSTOM_DATA, value);
    // What a server sent for the stack no longer describes it; kept, an
    // emptied container would not stack with a plain one.
    // rust: one.data_mut().wire = Default::default();
    // rust: one.tidy();
    // rust: one
}

/// `stack` as a fresh single `item`, as `BucketItem` makes its result.
pub fn bucket(item: []const u8) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack::new(item, 1)
}

/// What one item of `stack` holds, if it is a container: a bucket, or an item
/// whose mod gave it `capacity`.
pub fn contents(stack: *ItemStack, capacity: ?i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if stack.count == 0 {
    // rust: return None;
}
    // rust: if &*stack.item == "minecraft:bucket" {
    // rust: return Some(NativeItemFluid {
    // rust: fluid: None,
    // rust: amount: 0,
    // rust: capacity: BUCKET,
    // rust: });
}
    // rust: if let Some((fluid, _)) = BUCKETS.iter().find(|(_, full)| *full == &*stack.item) {
    // rust: return Some(NativeItemFluid {
    // rust: fluid: Some((*fluid).to_owned()),
    // rust: amount: BUCKET,
    // rust: capacity: BUCKET,
    // rust: });
}
    // rust: let capacity = capacity?;
    // rust: let (fluid, amount) = read_tank(stack);
    // rust: Some(NativeItemFluid {
    // rust: fluid,
    // rust: amount,
    // rust: capacity,
    // rust: })
}

/// How much of `amount` of `fluid` one item of `stack` takes, and the item
/// it becomes.
    // rust: fn fill_one(
    // rust: stack: &ItemStack,
    // rust: capacity: Option<i32>,
    // rust: fluid: &str,
    // rust: amount: i32,
    // rust: ) -> Option<(i32, ItemStack)> {
    // rust: let held = contents(stack, capacity)?;
    // rust: let mut unchanged = stack.clone();
    // rust: unchanged.count = 1;
    // rust: if !is_fluid(fluid) || amount <= 0 {
    // rust: return Some((0, unchanged));
}
    // rust: if &*stack.item == "minecraft:bucket" {
        // All or nothing: a bucket takes a whole bucket.
    // rust: let full = BUCKETS.iter().find(|(f, _)| *f == fluid)?.1;
    // rust: return Some(if amount >= BUCKET {
    // rust: (BUCKET, bucket(full))
    // rust: } else {
    // rust: (0, unchanged)
    // rust: });
}
    // rust: if capacity.is_none() || held.fluid.as_deref().is_some_and(|f| f != fluid) {
    // rust: return Some((0, unchanged));
}
    // rust: let take = (held.capacity - held.amount).max(0).min(amount);
    // rust: if take == 0 {
    // rust: return Some((0, unchanged));
}
    // rust: Some((take, with_tank(stack, fluid, held.amount + take)))
}

/// The fluid and how much one item of `stack` gives of at most `max`, and
/// the item it becomes.
    // rust: fn drain_one(
    // rust: stack: &ItemStack,
    // rust: capacity: Option<i32>,
    // rust: max: i32,
    // rust: ) -> Option<(String, i32, ItemStack)> {
    // rust: let held = contents(stack, capacity)?;
    // rust: let fluid = held.fluid?;
    // rust: if max <= 0 {
    // rust: return None;
}
    // rust: if capacity.is_none() || BUCKETS.iter().any(|(_, full)| *full == &*stack.item) {
        // A full bucket gives its whole bucket or nothing.
    // rust: return (max >= BUCKET).then(|| (fluid, BUCKET, bucket("minecraft:bucket")));
}
    // rust: let give = held.amount.min(max);
    // rust: Some((
    // rust: fluid.clone(),
    // rust: give,
    // rust: with_tank(stack, &fluid, held.amount - give),
    // rust: ))
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// The capacity a mod gave item `item`, clamped; none for any other item.
pub fn native_item_tank_capacity(self: *Self, item: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if item.starts_with("minecraft:") {
    // rust: return None;
}
    // rust: let mut capacity = None;
    // rust: self.native_item_fluid_tank(item, &mut capacity);
    // rust: capacity.map(|c| c.clamp(*MOD_CAPACITY.start(), *MOD_CAPACITY.end()))
}
    /// `Capabilities.FluidHandler.ITEM`, read: the fluid, amount and capacity
    /// of one item of `stack`. A bucket holds a bucket of water or lava or
    /// nothing; a mod's container what it keeps in its `custom_data`. None
    /// for any other item, and for an empty stack.
    // rust: pub(in crate::game) fn native_item_fluid(&self, stack: &ItemStack) -> Option<NativeItemFluid> {
    // rust: contents(stack, self.native_item_tank_capacity(&stack.item))
}
    /// Fills one item of `stack` with up to `amount` millibuckets of `fluid`
    /// (`minecraft:water`, `minecraft:lava`), as `IFluidHandler.fill`: a
    /// bucket takes a whole bucket or nothing and becomes the full one; a
    /// mod's container takes what fits of one fluid. The amount it takes, and
    /// the single item it becomes (the item itself when it took nothing). The
    /// stack given is not changed: shrink it by one and hand out the result.
    /// None where the stack is no container.
    // rust: pub(in crate::game) fn native_item_fluid_fill(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: fluid: &str,
    // rust: amount: i32,
    // rust: ) -> Option<(i32, ItemStack)> {
    // rust: fill_one(
    // rust: stack,
    // rust: self.native_item_tank_capacity(&stack.item),
    // rust: fluid,
    // rust: amount,
    // rust: )
}
    /// Drains up to `max` millibuckets out of one item of `stack`, as
    /// `IFluidHandler.drain`: a full bucket gives its whole bucket or nothing
    /// and becomes an empty one; a mod's container gives what it holds, up to
    /// `max`. The fluid, the amount, and the single item it becomes. The stack
    /// given is not changed. None where it is no container, holds nothing, or
    /// `max` is less than a bucket's for a bucket.
    // rust: pub(in crate::game) fn native_item_fluid_drain(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: max: i32,
    // rust: ) -> Option<(String, i32, ItemStack)> {
    // rust: drain_one(stack, self.native_item_tank_capacity(&stack.item), max)
}
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::Arc;

pub const W: []const u8 = "minecraft:water";
pub const L: []const u8 = "minecraft:lava";

pub fn canister(count: u32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack::new("mymod:canister", count)
}

pub fn an_empty_bucket_takes_a_whole_bucket_or_nothing() void {
}
    // rust: let empty = ItemStack::new("minecraft:bucket", 3);
    // rust: let (took, result) = fill_one(&empty, None, W, 1500).unwrap();
    // rust: assert_eq!(
    // rust: (took, &*result.item, result.count),
    // rust: (1000, "minecraft:water_bucket", 1)
    // rust: );
    // rust: let (took, result) = fill_one(&empty, None, L, 1000).unwrap();
    // rust: assert_eq!((took, &*result.item), (1000, "minecraft:lava_bucket"));
    // rust: let (took, result) = fill_one(&empty, None, W, 999).unwrap();
    // rust: assert_eq!(
    // rust: (took, &*result.item, result.count),
    // rust: (0, "minecraft:bucket", 1)
    // rust: );
        // Not a fluid Horizon models.
    // rust: assert_eq!(fill_one(&empty, None, "minecraft:milk", 1000).unwrap().0, 0);
}

pub fn a_full_bucket_gives_a_whole_bucket_and_takes_nothing() void {
}
    // rust: let full = ItemStack::new("minecraft:lava_bucket", 1);
    // rust: assert_eq!(fill_one(&full, None, L, 1000).unwrap().0, 0);
    // rust: assert_eq!(drain_one(&full, None, 999), None);
    // rust: let (fluid, took, result) = drain_one(&full, None, 5000).unwrap();
    // rust: assert_eq!(
    // rust: (fluid.as_str(), took, &*result.item),
    // rust: (L, 1000, "minecraft:bucket")
    // rust: );
    // rust: let empty = ItemStack::new("minecraft:bucket", 1);
    // rust: assert_eq!(drain_one(&empty, None, 1000), None);
}

pub fn other_items_are_no_containers() void {
}
    // rust: let stone = ItemStack::new("minecraft:stone", 1);
    // rust: assert_eq!(contents(&stone, None), None);
    // rust: assert_eq!(fill_one(&stone, None, W, 1000), None);
    // rust: assert_eq!(drain_one(&stone, None, 1000), None);
    // rust: assert_eq!(contents(&ItemStack::new("minecraft:bucket", 0), None), None);
        // A mod item nobody gave a capacity is none either.
    // rust: assert_eq!(contents(&canister(1), None), None);
}

pub fn a_mod_container_keeps_one_fluid_up_to_its_capacity() void {
}
    // rust: let stack = canister(4);
    // rust: let (took, filled) = fill_one(&stack, Some(750), W, 500).unwrap();
    // rust: assert_eq!((took, filled.count), (500, 1));
    // rust: assert_eq!(read_tank(&filled), (Some(W.to_owned()), 500));
        // Only the room is taken, and only of the same fluid.
    // rust: let (took, full) = fill_one(&filled, Some(750), W, 500).unwrap();
    // rust: assert_eq!(took, 250);
    // rust: assert_eq!(read_tank(&full), (Some(W.to_owned()), 750));
    // rust: assert_eq!(fill_one(&full, Some(750), W, 1).unwrap().0, 0);
    // rust: assert_eq!(fill_one(&filled, Some(750), L, 100).unwrap().0, 0);
    // rust: assert_eq!(
    // rust: contents(&full, Some(750)),
    // rust: Some(NativeItemFluid {
    // rust: fluid: Some(W.to_owned()),
    // rust: amount: 750,
    // rust: capacity: 750
    // rust: })
    // rust: );
}

pub fn draining_a_mod_container_empties_it_back_to_a_plain_stack() void {
}
    // rust: let (_, filled) = fill_one(&canister(1), Some(1000), L, 300).unwrap();
    // rust: let (fluid, took, rest) = drain_one(&filled, Some(1000), 100).unwrap();
    // rust: assert_eq!((fluid.as_str(), took), (L, 100));
    // rust: assert_eq!(read_tank(&rest), (Some(L.to_owned()), 200));
    // rust: let (_, took, empty) = drain_one(&rest, Some(1000), 5000).unwrap();
    // rust: assert_eq!(took, 200);
        // Nothing left over, so it stacks with a container never filled.
    // rust: assert_eq!(empty, canister(1));
    // rust: assert_eq!(drain_one(&empty, Some(1000), 100), None);
}

pub fn an_emptied_container_from_a_server_stacks_with_a_plain_one() void {
}
    // rust: let mut sent = canister(2);
    // rust: sent.data_mut().wire =
    // rust: horizon_client::item_data::Wire::new(canister(2), Arc::from(vec![1u8]));
    // rust: let (_, filled) = fill_one(&sent, Some(100), W, 40).unwrap();
    // rust: let (_, _, emptied) = drain_one(&filled, Some(100), 40).unwrap();
    // rust: assert!(emptied.same_item_same_components(&canister(1)));
}

pub fn a_container_keeps_the_rest_of_its_custom_data() void {
}
    // rust: let mut stack = canister(1);
    // rust: stack.data_mut().set_other(
    // rust: CUSTOM_DATA,
    // rust: Some(Tag::compound([(
    // rust: "owner",
    // rust: Tag::String(JavaString::from("Alex")),
    // rust: )])),
    // rust: );
    // rust: let (_, filled) = fill_one(&stack, Some(1000), W, 10).unwrap();
    // rust: let Some(Tag::Compound(data)) = filled.data().and_then(|d| d.other(CUSTOM_DATA)) else {
    // rust: panic!("no custom data");
}
    // rust: assert!(data.contains_key(&JavaString::from("owner")));
    // rust: assert!(data.contains_key(&JavaString::from(TANK)));
    // rust: let (_, _, emptied) = drain_one(&filled, Some(1000), 10).unwrap();
    // rust: assert_eq!(emptied, stack);
}
}
