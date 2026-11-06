//! Transpiled from Horizon Rust crate
package horizon_client_native_menu_stacks

import "core:fmt"
import "core:mem"
import "core:math"

// The stacks of a server-opened menu for native client mods
// (docs/native-mods.md, "Entity and level handles", API
// @API:client_entity_refs@): what the window shows in each slot, as the
// server last synced it, where `NativeScreenView` only counts the slots.
// use super::Game;
// use horizon_client::items::ItemStack;

    // rust: impl Game<'_> {
    // The stacks of the menu the server opened for this window, with their
    // components, by the server's slot number (`AbstractContainerMenu.slots`,
    // the numbers `ContainerSetSlot` and `ContainerClick` carry): the menu's
    // own slots, then the player's inventory and hotbar below it. An empty
    // slot is None. None on a server, while no server-opened menu is up (the
    // window's own inventory, creative), and for a menu whose slots the
    // client doesn't lay out (a lectern). API @API:client_entity_refs@.
    // rust: pub(super) fn native_menu_stacks(&mut self) -> Option<Vec<Option<ItemStack>>> {
    // rust: let (_, menu) = self.remote.as_ref()?.menu.clone()?;
    // rust: let slots: Vec<usize> = (0..).map_while(|s| Self::menu_slot(&menu, s)).collect();
    // rust: if slots.is_empty() {
    // rust: return None;
}
    // rust: Some(slots.into_iter().map(|i| self.slot_view(i)).collect())
}
}
