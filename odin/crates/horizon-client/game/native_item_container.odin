//! Transpiled from Horizon Rust crate
package horizon_client_native_item_container

import "core:fmt"
import "core:mem"
import "core:math"

// Items held by item stacks for native mods (docs/native-mods.md): a mod's
// backpacks, storage cells and toolboxes (`native_item_container`), read,
// filled and emptied. NeoForge's `Capabilities.Item.ITEM` is a
// `ResourceHandler<ItemResource>` reached through an `ItemAccess`: it acts on
// one item of a stack at a time and may change it. So do these, as the item
// fluid and energy helpers do: they take a stack and answer without changing
// it, and the caller shrinks its stack by one and hands out the changed item
// they return. The contents live in `minecraft:container`, as a shulker box
// item keeps them. They hold no world state, so they work on any side.
// use super::Game;
// use horizon_client::items::ItemStack;
// use horizon_world::nbt::Tag;

// `ItemContainerContents`' limit on slots.
MAX_SLOTS :: 256
// `Container.getMaxStackSize`.
CONTAINER_MAX :: 99

// The slots of one item of `stack`, empty ones included; slots past `size`
// are dropped, as the item has no room for them.
contents :: proc(stack: ^ItemStack, size: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut slots = vec![None; size as usize];
    // rust: for (slot, item) in stack.data().map_or(&[][..], |d| &d.container[..]) {
    // rust: if let Some(s) = slots.get_mut(usize::from(*slot))
    // rust: && item.count > 0
    // rust: {
    // rust: *s = Some(item.clone());
}
}
    // rust: slots
}

// One item of `stack`, unchanged.
one_of :: proc(stack: ^ItemStack) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let mut one = stack.clone();
    // rust: one.count = 1;
    // rust: one
}

// One item of `stack` holding `slots`, its other data kept. An empty item
// carries nothing, so it stacks with a new one.
with_contents :: proc(stack: ^ItemStack, slots: ^[Maybe(ItemStack)]) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let mut one = one_of(stack);
    // rust: let data = one.data_mut();
    // rust: data.container = slots
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, s)| Some((i as u8, s.clone().filter(|s| s.count > 0)?)))
    // rust: .collect();
    // What a server sent for the stack no longer describes it; kept, an
    // emptied item would not stack with a new one.
    // rust: data.wire = Default::default();
    // rust: one.tidy();
    // rust: one
}

// `SimpleContainer.addItem` on one item of `stack`: `item` tops up the
// slots that hold the same item and components, then goes into the first
// empty ones. Unlike `SimpleContainer`, which puts the whole rest in the
// first empty slot and cuts it to the limit, no slot takes more than its
// limit (`limit`), and what doesn't fit stays out. A shulker box never goes
// in (`Item.canFitInsideContainerItems`). The count that went in, and the
// item it becomes.
    // rust: fn insert_one(
    // rust: stack: &ItemStack,
    // rust: size: Option<u32>,
    // rust: item: &ItemStack,
    // rust: limit: u32,
    // rust: ) -> Option<(u32, ItemStack)> {
    // rust: let size = size?;
    // rust: if stack.count == 0 {
    // rust: return None;
}
    // rust: if item.count == 0 || !horizon_client::menu::fits_inside_container_items(item) {
    // rust: return Some((0, one_of(stack)));
}
    // rust: let mut slots = contents(stack, size);
    // rust: let mut left = item.count;
    // rust: for held in slots.iter_mut().flatten() {
    // rust: if left == 0 {
    // rust: break;
}
    // rust: if held.same_item_same_components(item) {
    // rust: let room = limit.saturating_sub(held.count).min(left);
    // rust: held.count += room;
    // rust: left -= room;
}
}
    // rust: for slot in slots.iter_mut().filter(|s| s.is_none()) {
    // rust: if left == 0 {
    // rust: break;
}
    // rust: let put = limit.min(left);
    // rust: *slot = Some(ItemStack {
    // rust: count: put,
    // rust: ..item.clone()
    // rust: });
    // rust: left -= put;
}
    // rust: let moved = item.count - left;
    // rust: if moved == 0 {
    // rust: return Some((0, one_of(stack)));
}
    // rust: Some((moved, with_contents(stack, &slots)))
}

// Up to `max` out of `slot` of one item of `stack`: what came out (none
// when nothing did), and the item it becomes.
    // rust: fn extract_one(
    // rust: stack: &ItemStack,
    // rust: size: Option<u32>,
    // rust: slot: usize,
    // rust: max: u32,
    // rust: ) -> Option<(Option<ItemStack>, ItemStack)> {
    // rust: let size = size?;
    // rust: if stack.count == 0 {
    // rust: return None;
}
    // rust: let mut slots = contents(stack, size);
    // rust: let Some(Some(held)) = slots.get_mut(slot) else {
    // rust: return Some((None, one_of(stack)));
}
    // rust: let take = held.count.min(max);
    // rust: if take == 0 {
    // rust: return Some((None, one_of(stack)));
}
    // rust: let taken = ItemStack {
    // rust: count: take,
    // rust: ..held.clone()
}
    // rust: held.count -= take;
    // rust: Some((Some(taken), with_contents(stack, &slots)))
}

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    // The slots a mod gave item `item`, clamped; none for any other item.
item_container_size :: proc(self: ^Self, item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if item.starts_with("minecraft:") {
    // rust: return None;
}
    // rust: let mut slots = None;
    // rust: self.native_item_container(item, &mut slots);
    // rust: slots.filter(|s| *s >= 1).map(|s| s.min(MAX_SLOTS))
}
    // `Container.getMaxStackSize(stack)`: the container's 99, or the stack's
    // own limit (its `max_stack_size` component, else the item's) when less.
item_container_limit :: proc(self: ^Self, stack: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let own = match stack
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:max_stack_size"))
    // rust: {
    // rust: Some(Tag::Int(n)) => (*n).clamp(1, 99) as u32,
    // rust: _ => self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(64, |i| i.max_stack),
}
    // rust: own.min(CONTAINER_MAX)
}
    // `Capabilities.Item.ITEM`, read: the slots of one item of `stack`,
    // empty ones included, kept in its `minecraft:container`. None for an
    // item without slots, and for an empty stack.
    // rust: pub(in crate::game) fn native_item_container_slots(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: ) -> Option<Vec<Option<ItemStack>>> {
    // rust: let size = self.item_container_size(&stack.item)?;
    // rust: (stack.count > 0).then(|| contents(stack, size))
}
    // `ResourceHandler.insert`: as much of `item` as fits into one item of
    // `stack`, topping up the slots that hold the same item and components
    // first, then the first empty ones (`SimpleContainer.addItem`'s order),
    // no slot past its limit (99, or the item's own when less). A shulker
    // box never goes in. The count that went in, and the single item it
    // becomes (the item itself when none did). The stack given is not
    // changed: shrink it by one and hand out the result, or leave the result
    // unused to simulate. None where the item has no slots.
    // rust: pub(in crate::game) fn native_item_container_insert(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: item: &ItemStack,
    // rust: ) -> Option<(u32, ItemStack)> {
    // rust: let size = self.item_container_size(&stack.item);
    // rust: insert_one(stack, size, item, self.item_container_limit(item))
}
    // `ResourceHandler.extract`: up to `max` out of slot `slot` of one item
    // of `stack`. What came out (none when the slot is empty or past the
    // item's slots), and the single item it becomes. The stack given is not
    // changed, as with `native_item_container_insert`. None where the item
    // has no slots.
    // rust: pub(in crate::game) fn native_item_container_extract(
    // rust: &self,
    // rust: stack: &ItemStack,
    // rust: slot: usize,
    // rust: max: u32,
    // rust: ) -> Option<(Option<ItemStack>, ItemStack)> {
    // rust: let size = self.item_container_size(&stack.item);
    // rust: extract_one(stack, size, slot, max)
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_world::nbt::JavaString;
//     use std::sync::Arc;

bag :: proc(count: u32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack::new("mymod:bag", count)
}

of :: proc(item: string, count: u32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack::new(item, count)
}

    // (slot, item, count) of what one item holds.
held :: proc(stack: ^ItemStack, size: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: contents(stack, size)
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, s)| s.map(|s| (i, s.item.to_string(), s.count)))
    // rust: .collect()
}

an_insert_tops_up_equal_stacks_before_empty_slots :: proc() {
}
    // rust: let (_, one) = insert_one(&bag(1), Some(3), &of("minecraft:stone", 10), 64).unwrap();
    // rust: let (_, one) = insert_one(&one, Some(3), &of("minecraft:dirt", 5), 64).unwrap();
    // rust: let (moved, one) = insert_one(&one, Some(3), &of("minecraft:stone", 60), 64).unwrap();
        // 54 top up slot 0 to 64, the other 6 take the first empty slot.
    // rust: assert_eq!(moved, 60);
    // rust: assert_eq!(
    // rust: held(&one, 3),
    // rust: [
    // rust: (0, "minecraft:stone".into(), 64),
    // rust: (1, "minecraft:dirt".into(), 5),
    // rust: (2, "minecraft:stone".into(), 6),
    // rust: ]
    // rust: );
}

no_slot_passes_its_limit_and_the_rest_stays_out :: proc() {
}
        // 16 per slot (ender pearls), two slots: 32 of 40 go in.
    // rust: let (moved, one) =
    // rust: insert_one(&bag(1), Some(2), &of("minecraft:ender_pearl", 40), 16).unwrap();
    // rust: assert_eq!(moved, 32);
    // rust: assert_eq!(
    // rust: held(&one, 2),
    // rust: [
    // rust: (0, "minecraft:ender_pearl".into(), 16),
    // rust: (1, "minecraft:ender_pearl".into(), 16),
    // rust: ]
    // rust: );
        // Full: nothing goes in, and the item comes back as it was.
    // rust: assert_eq!(
    // rust: insert_one(&one, Some(2), &of("minecraft:ender_pearl", 1), 16).unwrap(),
    // rust: (0, one.clone())
    // rust: );
}

different_components_never_share_a_slot :: proc() {
}
    // rust: let mut named = of("minecraft:stone", 1);
    // rust: named.data_mut().set_other(
    // rust: "minecraft:custom_name",
    // rust: Some(Tag::String(JavaString::from("Rock"))),
    // rust: );
    // rust: let (_, one) = insert_one(&bag(1), Some(2), &of("minecraft:stone", 1), 64).unwrap();
    // rust: let (moved, one) = insert_one(&one, Some(2), &named, 64).unwrap();
    // rust: assert_eq!(moved, 1);
    // rust: assert_eq!(held(&one, 2).len(), 2);
}

a_shulker_box_never_goes_in :: proc() {
}
    // rust: let shulker = of("minecraft:red_shulker_box", 1);
    // rust: assert_eq!(
    // rust: insert_one(&bag(1), Some(9), &shulker, 1).unwrap(),
    // rust: (0, bag(1))
    // rust: );
        // Another container item does.
    // rust: assert_eq!(insert_one(&bag(1), Some(9), &bag(1), 64).unwrap().0, 1);
}

an_extract_takes_up_to_max_and_an_emptied_bag_is_new_again :: proc() {
}
    // rust: let (_, full) = insert_one(&bag(1), Some(4), &of("minecraft:apple", 20), 64).unwrap();
    // rust: let (taken, rest) = extract_one(&full, Some(4), 0, 15).unwrap();
    // rust: assert_eq!(taken.map(|t| t.count), Some(15));
    // rust: assert_eq!(held(&rest, 4), [(0, "minecraft:apple".into(), 5)]);
    // rust: let (taken, empty) = extract_one(&rest, Some(4), 0, 64).unwrap();
    // rust: assert_eq!(
    // rust: taken.map(|t| (t.item.to_string(), t.count)),
    // rust: Some(("minecraft:apple".into(), 5))
    // rust: );
    // rust: assert_eq!(empty, bag(1));
        // An empty slot, or one past the bag's slots, gives nothing.
    // rust: assert_eq!(extract_one(&empty, Some(4), 0, 1).unwrap(), (None, bag(1)));
    // rust: assert_eq!(
    // rust: extract_one(&full, Some(4), 7, 1).unwrap(),
    // rust: (None, full.clone())
    // rust: );
}

the_stack_given_stays_and_one_item_comes_back :: proc() {
}
    // rust: let stack = bag(3);
    // rust: let (moved, one) = insert_one(&stack, Some(1), &of("minecraft:stone", 1), 64).unwrap();
    // rust: assert_eq!((moved, one.count, stack.count), (1, 1, 3));
    // rust: assert_eq!(stack, bag(3));
}

items_without_slots_hold_nothing :: proc() {
}
    // rust: assert_eq!(
    // rust: insert_one(&bag(1), None, &of("minecraft:stone", 1), 64),
    // rust: None
    // rust: );
    // rust: assert_eq!(extract_one(&bag(1), None, 0, 1), None);
    // rust: assert_eq!(
    // rust: insert_one(&bag(0), Some(3), &of("minecraft:stone", 1), 64),
    // rust: None
    // rust: );
        // Nothing to insert moves nothing.
    // rust: assert_eq!(
    // rust: insert_one(&bag(1), Some(3), &of("minecraft:stone", 0), 64).unwrap(),
    // rust: (0, bag(1))
    // rust: );
}

slots_past_the_size_are_dropped :: proc() {
}
        // A mod that shrank its bag after it was filled.
    // rust: let (_, big) = insert_one(&bag(1), Some(3), &of("minecraft:stone", 64 * 3), 64).unwrap();
    // rust: assert_eq!(held(&big, 2).len(), 2);
    // rust: assert_eq!(extract_one(&big, Some(2), 2, 64).unwrap().0, None);
}

an_emptied_bag_from_a_server_stacks_with_a_new_one :: proc() {
}
    // rust: let mut sent = bag(2);
    // rust: sent.data_mut().wire = horizon_client::item_data::Wire::new(bag(2), Arc::from(vec![1u8]));
    // rust: let (_, filled) = insert_one(&sent, Some(1), &of("minecraft:stone", 3), 64).unwrap();
    // rust: let (_, emptied) = extract_one(&filled, Some(1), 0, 3).unwrap();
    // rust: assert!(emptied.same_item_same_components(&bag(1)));
}

a_bag_keeps_the_rest_of_its_data :: proc() {
}
    // rust: let mut stack = bag(1);
    // rust: stack.data_mut().set_other(
    // rust: "minecraft:custom_name",
    // rust: Some(Tag::String(JavaString::from("Kit"))),
    // rust: );
    // rust: let (_, filled) = insert_one(&stack, Some(2), &of("minecraft:stone", 2), 64).unwrap();
    // rust: assert!(
    // rust: filled
    // rust: .data()
    // rust: .and_then(|d| d.other("minecraft:custom_name"))
    // rust: .is_some()
    // rust: );
    // rust: assert_eq!(held(&filled, 2), [(0, "minecraft:stone".into(), 2)]);
    // rust: let (_, emptied) = extract_one(&filled, Some(2), 0, 2).unwrap();
    // rust: assert_eq!(emptied, stack);
}
}
