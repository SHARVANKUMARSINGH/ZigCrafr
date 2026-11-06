//! Transpiled from Horizon Rust crate
package horizon_world_extra_items

import "core:fmt"
import "core:mem"
import "core:math"

// Server-player delivery of extra items created by consuming an item.
// use crate::{
    // rust: inventory_pickup::{self, PickupError, PickupHooks},
    // rust: item_stack_refs::StackRef,
    // rust: player_inventory::PlayerInventory,
}
    // rust: pub trait ExtraItemHooks<I, K, V>: PickupHooks<I, K, V> {
    // Native drop uses throwRandomly=false and Prediction::PREDICTED.
    // rust: fn drop_predicted(
    // rust: &mut self,
    // rust: inventory: &mut PlayerInventory<I, K, V>,
    // rust: stack: StackRef<I, K, V>,
    // rust: ) -> Result<(), Self::Error>;
}
    // rust: pub fn deliver<I: Copy + Eq, K: Clone + Eq, V: Clone + PartialEq, H: ExtraItemHooks<I, K, V>>(
    // rust: inventory: &mut PlayerInventory<I, K, V>,
    // rust: stack: StackRef<I, K, V>,
    // rust: hooks: &mut H,
    // rust: ) -> Result<(), PickupError<H::Error>> {
    // rust: if !inventory_pickup::add(inventory, -1, &stack, hooks)? {
    // rust: hooks
    // rust: .drop_predicted(inventory, stack)
    // rust: .map_err(PickupError::Callback)?;
}
    // rust: Ok(())
}
