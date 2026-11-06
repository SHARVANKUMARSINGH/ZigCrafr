//! Transpiled from Horizon Rust crate
package horizon_client_bundles

import "core:fmt"
import "core:mem"
import "core:math"

// `BundleMouseActions`: the wheel over a bundle in a container screen selects
// one of the items it shows, which a click that takes one out of it then takes
// (`BundleContents.Mutable.removeOne`). Moving off the bundle clears the
// selection. On a server the selection is sent to it (`ServerboundSelectBundleItemPacket`).
// use super::{Game, Screen};
// use horizon_client::{
    // rust: bundle::{Contents, toggle_selected},
    // rust: mouse::ScrollWheelHandler,
}
// use horizon_protocol::packets::play::{self, Serverbound as S};

    // rust: pub(super) struct BundleMouse {
    // rust: wheel: ScrollWheelHandler,
    // The slot under the cursor at the last tick (`AbstractContainerScreen.hoveredSlot`).
    // rust: hovered: Option<usize>,
}

// Whether `screen` is an `AbstractContainerScreen`, whose `mouseScrolled` first offers
// the wheel to the hovered slot's `ItemSlotMouseAction`s (the bundle's), and whose
// `onStopHovering` clears the selection: the inventory and container menus, and
// `CreativeModeInventoryScreen`, which scrolls its items only when no bundle took
// the wheel.
    // rust: pub(super) fn takes_bundle_wheel(screen: Screen) -> bool {
    // rust: matches!(screen, Screen::Inventory | Screen::Creative)
}

    // rust: impl Game<'_> {
    // A slot a bundle can be selected in: the player's inventory and off hand in any
    // menu (#4436: a crafting table's, an enchanting table's...), and a container's own
    // slots. A server only knows those in chest-like menus.
bundle_slot :: proc(self: ^Self, slot: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: slot < 36
    // rust: || slot == 504
    // rust: || ((300..500).contains(&slot)
    // rust: && (self.remote.is_none() || self.remote_storage_open())
    // rust: && self.slots().contains(&slot))
}

    // `BundleMouseActions.onMouseScrolled`: the wheel over a bundle moves the selection
    // through the items its tooltip shows. True when the bundle took the wheel.
    // rust: pub(super) fn bundle_scroll(&mut self, x: f64, y: f64) -> bool {
    // rust: let Some(slot) = self.inventory_target().0 else {
    // rust: return false;
}
    // rust: if !self.bundle_slot(slot) {
    // rust: return false;
}
    // rust: let stack = self.slot_mut(slot).clone();
    // rust: let items = self.items();
    // rust: let Some(bundle) = stack.filter(|s| items.get(&s.item).is_some_and(|i| i.bundle)) else {
    // rust: return false;
}
    // rust: let shown = Contents::of(items, &bundle).map_or(0, |c| c.shown_count());
    // rust: if shown == 0 {
    // rust: return false;
}
    // rust: let (wheel_x, wheel_y) = self.bundle_mouse.wheel.on_mouse_scroll(x, y);
    // rust: let wheel = if wheel_y == 0 { -wheel_x } else { wheel_y };
    // rust: if wheel != 0 {
    // rust: let selected = bundle.data().map_or(-1, |d| d.bundle_selected.0);
    // rust: let next = ScrollWheelHandler::next_selection(f64::from(wheel), selected, shown as i32);
    // rust: if next != selected {
    // rust: self.select_bundle(slot, next);
}
}
    // rust: true
}

    // `BundleMouseActions.toggleSelectedBundleItem`: the stack here and, on a server, there.
select_bundle :: proc(self: ^Self, slot: uint, index: i32) {
}
    // rust: if let Some(stack) = self.slot_mut(slot) {
    // rust: toggle_selected(stack, index);
}
    // rust: if self.remote.is_some() {
    // rust: let (_, menu) = self.remote_menu();
    // rust: if let Some(menu_slot) = Self::menu_slot_index(&menu, slot) {
    // rust: self.send(S::SelectBundleItem(play::SelectBundleItem {
    // rust: slot: menu_slot as i32,
    // rust: index,
    // rust: }));
}
}
}

    // `BundleMouseActions.unselectedBundleItem` for the bundle in `slot`, if it has a selection.
    // rust: pub(super) fn unselect_bundle(&mut self, slot: usize) {
    // rust: if !self.bundle_slot(slot) {
    // rust: return;
}
    // rust: let selected = self
    // rust: .slot_mut(slot)
    // rust: .as_ref()
    // rust: .and_then(|s| s.data())
    // rust: .is_some_and(|d| d.bundle_selected.0 >= 0);
    // rust: if selected {
    // rust: self.select_bundle(slot, -1);
}
}

    // `AbstractContainerScreen.onStopHovering` (and `onClose`): leaving a slot, or the
    // screen, clears the bundle's selection.
    // rust: pub(super) fn tick_bundle_hover(&mut self) {
    // rust: let now = if takes_bundle_wheel(self.screen) {
    // rust: self.inventory_target().0
    // rust: } else {
    // rust: None
}
    // rust: if let Some(left) = std::mem::replace(&mut self.bundle_mouse.hovered, now)
    // rust: && Some(left) != now
    // rust: {
    // rust: self.unselect_bundle(left);
}
}
}

    // rust: mod tests {
//     use super::*;

    // `CreativeModeInventoryScreen.mouseScrolled` calls `AbstractContainerScreen`'s
    // first: a bundle under the cursor takes the wheel there too (#3211).
container_screens_offer_the_wheel_to_bundles :: proc() {
}
    // rust: assert!(takes_bundle_wheel(Screen::Inventory));
    // rust: assert!(takes_bundle_wheel(Screen::Creative));
    // rust: for screen in [
    // rust: Screen::Playing,
    // rust: Screen::Chat,
    // rust: Screen::Paused,
    // rust: Screen::Options,
    // rust: ] {
    // rust: assert!(!takes_bundle_wheel(screen));
}
}
}
