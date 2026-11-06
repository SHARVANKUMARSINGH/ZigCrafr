//! Transpiled from Horizon Rust crate
package horizon_world_player_equipment

import "core:fmt"
import "core:mem"
import "core:math"

// Player hand access through the selected inventory slot and shared equipment.
// Equipping writes storage before invoking LivingEntity's onEquipItem hook.
// use crate::{
    // rust: item_stack_refs::StackRef,
    // rust: player_inventory::{EquipmentSlot, PlayerInventory},
}
InteractionHand :: enum {
    Main,
    Off,
}
    // rust: impl InteractionHand {
slot :: proc(self: ^Self) -> E {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Main => EquipmentSlot::MainHand,
    // rust: Self::Off => EquipmentSlot::OffHand,
}
}
}
    // rust: pub fn get<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq>(
    // rust: inv: &PlayerInventory<I, K, V>,
    // rust: slot: EquipmentSlot,
    // rust: ) -> StackRef<I, K, V> {
    // rust: if slot == EquipmentSlot::MainHand {
    // rust: inv.selected_item()
    // rust: } else {
    // rust: inv.equipment().get(slot)
}
}
    // rust: pub fn set<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq>(
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: slot: EquipmentSlot,
    // rust: stack: StackRef<I, K, V>,
    // rust: ) -> StackRef<I, K, V> {
    // rust: if slot == EquipmentSlot::MainHand {
    // rust: inv.set_selected_item(stack)
    // rust: } else {
    // rust: inv.equipment().set(slot, stack)
}
}
    // rust: pub fn is_empty<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq>(
    // rust: inv: &PlayerInventory<I, K, V>,
    // rust: ) -> bool {
    // rust: inv.selected_item().read().is_empty()
    // rust: && inv
    // rust: .equipment()
    // rust: .entries()
    // rust: .iter()
    // rust: .all(|(_, s)| s.read().is_empty())
}
    // rust: pub trait EquipWorld<I, K, V> {
    // rust: type Error;
    // rust: fn on_equip(
    // rust: &mut self,
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: slot: EquipmentSlot,
    // rust: old: StackRef<I, K, V>,
    // rust: new: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: pub fn set_item_slot<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, W: EquipWorld<I, K, V>>(
    // rust: w: &mut W,
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: slot: EquipmentSlot,
    // rust: stack: StackRef<I, K, V>,
    // rust: ) -> Result<(), W::Error> {
    // rust: let old = set(inv, slot, stack.clone());
    // rust: w.on_equip(inv, slot, old, stack)
}
    // rust: pub fn get_hand<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq>(
    // rust: inv: &PlayerInventory<I, K, V>,
    // rust: hand: InteractionHand,
    // rust: ) -> StackRef<I, K, V> {
    // rust: get(inv, hand.slot())
}
    // rust: pub fn set_hand<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, W: EquipWorld<I, K, V>>(
    // rust: w: &mut W,
    // rust: inv: &mut PlayerInventory<I, K, V>,
    // rust: hand: InteractionHand,
    // rust: stack: StackRef<I, K, V>,
    // rust: ) -> Result<(), W::Error> {
    // rust: set_item_slot(w, inv, hand.slot(), stack)
}
