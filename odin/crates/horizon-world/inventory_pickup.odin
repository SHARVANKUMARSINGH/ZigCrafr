//! Transpiled from Horizon Rust crate
package horizon_world_inventory_pickup

import "core:fmt"
import "core:mem"
import "core:math"

// Player inventory resource insertion. The source stack is consumed in place;
// callbacks can mutate aliased stacks or inventory slots at native boundaries.
// use crate::{
    // rust: item_stack_refs::StackRef,
    // rust: player_inventory::{InventoryError, InventoryRules, PlayerInventory},
}
PickupError :: enum {
    Inventory(InventoryError),
    Callback(E),
}
    // rust: pub trait PickupHooks<I, K, V>: InventoryRules<I, K, V> {
    // rust: type Error;
item_max_stack_size :: proc(self: ^Self, stack: ^StackRef<I) -> i {
    // Ported from Horizon
    return {}
}
    // rust: fn max_stack_size(
    // rust: &mut self,
    // rust: inventory: &mut PlayerInventory<I, K, V>,
    // rust: ) -> Result<i32, Self::Error>;
    // rust: fn infinite_materials(
    // rust: &mut self,
    // rust: inventory: &mut PlayerInventory<I, K, V>,
    // rust: ) -> Result<bool, Self::Error>;
}
    // rust: fn limit<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, H: PickupHooks<I, K, V>>(
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: stack: &StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<i32, PickupError<H::Error>> {
    // rust: let max = hooks.max_stack_size(inv).map_err(PickupError::Callback)?;
    // rust: Ok(max.min(hooks.item_max_stack_size(stack)))
}
    // rust: fn remaining<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, H: PickupHooks<I, K, V>>(
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: target: &StackRef<I, K, V>,
    // rust: stack: &StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<bool, PickupError<H::Error>> {
    // rust: if target.read().is_empty()
    // rust: || !target.read().same_item_components(&stack.read())
    // rust: || hooks.item_max_stack_size(target) <= 1
    // rust: || hooks.is_damaged(target)
    // rust: {
    // rust: return Ok(false);
}
    // rust: let count = target.read().count();
    // rust: Ok(count < limit(inv, target, hooks)?)
}
    // rust: pub fn slot_with_space<
    // rust: I: Copy + Eq,
    // rust: K: Clone + Eq,
    // rust: V: Clone + PartialEq,
    // rust: H: PickupHooks<I, K, V>,
    // rust: >(
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: stack: &StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<i32, PickupError<H::Error>> {
    // rust: let target = inv.selected_item();
    // rust: if remaining(inv, &target, stack, hooks)? {
    // rust: return Ok(inv.selected() as i32);
}
    // rust: let target = inv.get(40).expect("offhand");
    // rust: if remaining(inv, &target, stack, hooks)? {
    // rust: return Ok(40);
}
    // rust: for i in 0..36 {
    // rust: let target = inv.get(i).expect("valid slot");
    // rust: if remaining(inv, &target, stack, hooks)? {
    // rust: return Ok(i);
}
}
    // rust: Ok(-1)
}
    // rust: fn add_resource<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, H: PickupHooks<I, K, V>>(
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: index: i32,
    // rust: stack: &StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<i32, PickupError<H::Error>> {
    // rust: let count = stack.read().count();
    // rust: let mut target = inv.get(index).map_err(PickupError::Inventory)?;
    // rust: if target.read().is_empty() {
    // rust: target = inv.stacks().resolve(stack.read().copy_with_count(0));
    // rust: inv.set(index, target.clone())
    // rust: .map_err(PickupError::Inventory)?;
}
    // rust: let max = limit(inv, &target, hooks)?;
    // rust: let amount = count.min(max.wrapping_sub(target.read().count()));
    // rust: if amount == 0 {
    // rust: return Ok(count);
}
    // rust: let count = count.wrapping_sub(amount);
    // rust: target.write().grow(amount);
    // rust: target.write().pop_time = 5;
    // rust: Ok(count)
}
    // rust: pub fn add<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, H: PickupHooks<I, K, V>>(
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: mut index: i32,
    // rust: stack: &StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<bool, PickupError<H::Error>> {
    // rust: if stack.read().is_empty() {
    // rust: return Ok(false);
}
    // rust: if hooks.is_damaged(stack) {
    // rust: if index == -1 {
    // rust: index = inv.free_slot();
}
    // rust: if index >= 0 {
            // copyAndClear is evaluated before List.set validates its index.
    // rust: let copy = inv.stacks().resolve(stack.write().copy_and_clear());
    // rust: inv.set_non_equipment(index, copy)
    // rust: .map_err(PickupError::Inventory)?;
    // rust: inv.get(index)
    // rust: .expect("validated ordinary slot")
    // rust: .write()
    // rust: .pop_time = 5;
    // rust: return Ok(true);
}
    // rust: if hooks
    // rust: .infinite_materials(inv)
    // rust: .map_err(PickupError::Callback)?
    // rust: {
    // rust: stack.write().count = 0;
    // rust: return Ok(true);
}
    // rust: return Ok(false);
}
    // rust: let before = loop {
    // rust: let before = stack.read().count();
    // rust: let left = if index == -1 {
    // rust: let mut slot = slot_with_space(inv, stack, hooks)?;
    // rust: if slot == -1 {
    // rust: slot = inv.free_slot();
}
    // rust: if slot == -1 {
    // rust: stack.read().count()
    // rust: } else {
    // rust: add_resource(inv, slot, stack, hooks)?
}
    // rust: } else {
    // rust: add_resource(inv, index, stack, hooks)?
}
    // rust: stack.write().count = left;
    // rust: if stack.read().is_empty() || stack.read().count() >= before {
    // rust: break before;
}
}
    // rust: if stack.read().count() == before
    // rust: && hooks
    // rust: .infinite_materials(inv)
    // rust: .map_err(PickupError::Callback)?
    // rust: {
    // rust: stack.write().count = 0;
    // rust: return Ok(true);
}
    // rust: Ok(stack.read().count() < before)
}
