//! Transpiled from Horizon Rust crate
package horizon_client_native_quick_move

import "core:fmt"
import "core:mem"
import "core:math"

// A shift-click in a mod container's menu, routed by the mods
// (`native_menu_quick_move`, `AbstractContainerMenu.quickMoveStack`) before
// the game's own routing.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: block_entities::Pos, containers::BlockEntity, items::ItemStack, lan::menu::Slots,
}
// use horizon_protocol::packets::play;

// `ClickType.QUICK_MOVE`'s id in `ServerboundContainerClickPacket`.
QUICK_MOVE :: 1

// Where a menu slot of a block container's menu lives: the container's own
// slot `k`, or the player's inventory index (hotbar 0 to 8, then the 27
// main slots), the menu listing the main slots before the hotbar.
    // rust: pub(super) enum MenuSlot {
    // rust: Container(usize),
    // rust: Inventory(usize),
}

// The slot a quick move of `slot` on a menu with `size` container slots
// asks a mod about, or None when the click is not one: another click type,
// a button other than left or right (`doClick` takes 0 and 1), no slot,
// a slot past the menu, or a container slot the mod's screen hides (the
// menu has no such slot, so the click goes nowhere).
    // rust: pub(super) fn quick_move_slot(
    // rust: input: i32,
    // rust: button: i32,
    // rust: slot: i32,
    // rust: size: usize,
    // rust: hidden: &[usize],
    // rust: ) -> Option<MenuSlot> {
    // rust: if input != QUICK_MOVE || !(0..=1).contains(&button) {
    // rust: return None;
}
    // rust: let slot = usize::try_from(slot).ok()?;
    // rust: if slot < size {
    // rust: return (!hidden.contains(&slot)).then_some(MenuSlot::Container(slot));
}
    // rust: let n = slot - size;
    // rust: match n {
    // rust: 0..27 => Some(MenuSlot::Inventory(9 + n)),
    // rust: 27..36 => Some(MenuSlot::Inventory(n - 27)),
    // rust: _ => None,
}
}

// What a quick move the mods were asked about leaves: when one took it
// (`handled`), the clicked slot holds what is left of `stack`, whatever the
// mods wrote there, and their other changes to the block's items stay;
// otherwise the block's items are as they were before the call (`before`),
// so nothing a mod moved without taking the click is kept twice.
    // rust: fn settle(
    // rust: at: MenuSlot,
    // rust: handled: bool,
    // rust: stack: ItemStack,
    // rust: before: &[Option<ItemStack>],
    // rust: items: &mut Vec<Option<ItemStack>>,
    // rust: inventory: &mut [Option<ItemStack>],
    // rust: ) {
    // rust: if !handled {
    // rust: before.clone_into(items);
    // rust: return;
}
    // rust: let left = (stack.count > 0).then_some(stack);
    // rust: match at {
    // rust: MenuSlot::Container(k) => {
    // rust: if items.len() <= k {
    // rust: items.resize(k + 1, None);
}
    // rust: items[k] = left;
}
    // rust: MenuSlot::Inventory(i) => {
    // rust: if let Some(s) = inventory.get_mut(i) {
    // rust: *s = left;
}
}
}
}

    // rust: impl Game<'_> {
    // `ServerGamePacketListenerImpl.handleContainerClick` for a quick move
    // in a guest's open mod container menu (on a vanilla menu type or the
    // mod's own): the mods' `native_menu_quick_move` first, as the clicking
    // player. True when a mod took it: the slot keeps what the mod left and
    // the guest's client gets the whole menu again. False for every other
    // click, and for one no mod took, so the game's own routing runs.
    // rust: pub(super) fn lan_mod_quick_move(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: ) -> bool {
    // rust: let Some(g) = host.hub.guest(conn) else {
    // rust: return false;
}
    // rust: let Some(menu) = g
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|m| p.container != 0 && m.window == p.container)
    // rust: else {
    // rust: return false;
}
    // rust: let Slots::Block(pos) = menu.slots else {
    // rust: return false;
}
    // rust: let Some(at) = quick_move_slot(
    // rust: p.input,
    // rust: i32::from(p.button),
    // rust: i32::from(p.slot),
    // rust: menu.size,
    // rust: &menu.hidden,
    // rust: ) else {
    // rust: return false;
}
        // A spectator's or a dead player's click and a menu no longer valid
        // change nothing, and a shift-click during a drag only ends the drag
        // (`doClick`'s resetQuickCraft): the game's own path answers them.
    // rust: if g.spectator()
    // rust: || g.dead
    // rust: || menu.drag.is_some()
    // rust: || !menu.slots.still_valid(&self.world, g, menu.pos)
    // rust: {
    // rust: return false;
}
    // rust: let size = menu.size;
    // rust: let window = menu.window;
        // A mod menu type keeps its drag in the connection's machine menu
        // (`lan_machine_click`), not in `menu.drag`: a shift-click during it
        // goes there too, to only end the drag.
    // rust: if host
    // rust: .play
    // rust: .get(&conn)
    // rust: .and_then(|play| play.crafting.machine.as_ref())
    // rust: .is_some_and(|(w, m)| *w == window && m.quick_crafting())
    // rust: {
    // rust: return false;
}
    // rust: if !matches!(
    // rust: self.world.block_entities.get(&pos),
    // rust: Some(BlockEntity::Mod(m)) if !m.id.is_empty()
    // rust: ) {
    // rust: return false;
}
    // rust: let handled = self
    // rust: .as_guest(host, conn, |game| {
    // rust: game.mod_menu_quick_move(pos, size, p.slot as usize, at)
    // rust: })
    // rust: .unwrap_or(false);
    // rust: if !handled {
    // rust: return false;
}
        // The mod menu type's engine starts over from the block entity next click.
    // rust: if let Some(play) = host.play.get_mut(&conn)
    // rust: && play
    // rust: .crafting
    // rust: .machine
    // rust: .as_ref()
    // rust: .is_some_and(|(w, _)| *w == window)
    // rust: {
    // rust: play.crafting.machine = None;
}
        // sendAllDataToRemote: the client predicted the game's routing. A mod
        // that removed its own block leaves no menu to send: it closes, and
        // the inventory goes out on its own.
    // rust: if matches!(
    // rust: self.world.block_entities.get(&pos),
    // rust: Some(BlockEntity::Mod(_))
    // rust: ) {
    // rust: host.hub.resend_menu(conn, window, &self.world);
    // rust: } else if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) {
    // rust: host.hub.close_container(conn);
    // rust: host.hub.send_inventory(gi);
}
    // rust: true
}

    // The mods' `native_menu_quick_move` on menu slot `slot` (living at
    // `at`) of the mod container at `pos` (`size` container slots), for the
    // player in place: true when
    // one took it, the slot then holding what is left of its stack. The
    // block entity is out of the world during the call.
mod_menu_quick_move :: proc(self: ^Self, pos: Pos, size: uint, slot: uint, at: MenuSlot) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(BlockEntity::Mod(m)) = self.world.block_entities.get_mut(&pos) else {
    // rust: return false;
}
    // rust: let held = match at {
    // rust: MenuSlot::Container(k) => m.items.get(k).cloned().flatten(),
    // rust: MenuSlot::Inventory(i) => self.inventory.get(i).cloned().flatten(),
}
    // rust: let Some(mut stack) = held.filter(|s| s.count > 0) else {
    // rust: return false;
}
    // rust: let mut taken = std::mem::take(&mut **m);
    // rust: let items = taken.items.clone();
    // rust: let mut handled = false;
    // rust: self.native_menu_quick_move(
    // rust: [pos.0, pos.1, pos.2],
    // rust: &mut taken,
    // rust: size,
    // rust: slot,
    // rust: &mut stack,
    // rust: &mut handled,
    // rust: );
    // rust: settle(
    // rust: at,
    // rust: handled,
    // rust: stack,
    // rust: &items,
    // rust: &mut taken.items,
    // rust: &mut self.inventory,
    // rust: );
    // rust: self.put_back_mod_block_entity(pos, taken, &items);
    // rust: handled
}
}

    // rust: mod tests {
//     use super::{MenuSlot, quick_move_slot, settle};
//     use horizon_client::items::ItemStack;

stack :: proc(item: string, count: u32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack {
    // rust: item: item.into(),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
}
}

    // A quick move asks about the clicked slot only: a `generic_9x1` menu
    // has the container's 9, then the main inventory, then the hotbar.
a_quick_move_names_the_container_or_inventory_slot :: proc() {
}
    // rust: assert_eq!(
    // rust: quick_move_slot(1, 0, 0, 9, &[]),
    // rust: Some(MenuSlot::Container(0))
    // rust: );
    // rust: assert_eq!(
    // rust: quick_move_slot(1, 1, 8, 9, &[]),
    // rust: Some(MenuSlot::Container(8))
    // rust: );
        // The first main slot is inventory index 9, the last 35.
    // rust: assert_eq!(
    // rust: quick_move_slot(1, 0, 9, 9, &[]),
    // rust: Some(MenuSlot::Inventory(9))
    // rust: );
    // rust: assert_eq!(
    // rust: quick_move_slot(1, 0, 35, 9, &[]),
    // rust: Some(MenuSlot::Inventory(35))
    // rust: );
        // The hotbar comes last in the menu and first in the inventory.
    // rust: assert_eq!(
    // rust: quick_move_slot(1, 0, 36, 9, &[]),
    // rust: Some(MenuSlot::Inventory(0))
    // rust: );
    // rust: assert_eq!(
    // rust: quick_move_slot(1, 0, 44, 9, &[]),
    // rust: Some(MenuSlot::Inventory(8))
    // rust: );
}

    // Only a left or right shift-click on a slot the menu has is a quick
    // move: no other click type, button, outside click or hidden slot.
other_clicks_are_not_quick_moves :: proc() {
}
        // PICKUP, SWAP, CLONE, THROW, QUICK_CRAFT, PICKUP_ALL.
    // rust: for input in [0, 2, 3, 4, 5, 6] {
    // rust: assert_eq!(quick_move_slot(input, 0, 0, 9, &[]), None);
}
    // rust: assert_eq!(quick_move_slot(1, 2, 0, 9, &[]), None);
    // rust: assert_eq!(quick_move_slot(1, -1, 0, 9, &[]), None);
    // rust: assert_eq!(quick_move_slot(1, 0, -999, 9, &[]), None);
    // rust: assert_eq!(quick_move_slot(1, 0, 45, 9, &[]), None);
        // A slot the mod's screen hides is not in the menu.
    // rust: assert_eq!(quick_move_slot(1, 0, 3, 9, &[3]), None);
    // rust: assert_eq!(
    // rust: quick_move_slot(1, 0, 4, 9, &[3]),
    // rust: Some(MenuSlot::Container(4))
    // rust: );
        // The inventory's slots are never hidden.
    // rust: assert_eq!(
    // rust: quick_move_slot(1, 0, 9, 9, &[0, 1, 2, 3, 4, 5, 6, 7, 8]),
    // rust: Some(MenuSlot::Inventory(9))
    // rust: );
}

    // A taken shift-click from the inventory: the clicked slot keeps what the
    // mod left, and what it put in its block stays there.
a_taken_click_leaves_the_remainder_in_the_clicked_slot :: proc() {
}
    // rust: let before = vec![None; 9];
    // rust: let mut items = before.clone();
    // rust: items[8] = Some(stack("minecraft:cobblestone", 32));
    // rust: let mut inventory = vec![None; 36];
    // rust: inventory[0] = Some(stack("minecraft:cobblestone", 64));
    // rust: let left = stack("minecraft:cobblestone", 32);
    // rust: settle(
    // rust: MenuSlot::Inventory(0),
    // rust: true,
    // rust: left.clone(),
    // rust: &before,
    // rust: &mut items,
    // rust: &mut inventory,
    // rust: );
    // rust: assert_eq!(inventory[0], Some(left));
    // rust: assert_eq!(items[8], Some(stack("minecraft:cobblestone", 32)));
        // All of it taken: the slot empties.
    // rust: settle(
    // rust: MenuSlot::Inventory(0),
    // rust: true,
    // rust: stack("minecraft:cobblestone", 0),
    // rust: &before,
    // rust: &mut items,
    // rust: &mut inventory,
    // rust: );
    // rust: assert_eq!(inventory[0], None);
}

    // A taken click on the block's own slot: the remainder wins over what the
    // mod wrote to that slot, so a moved stack is never also left behind.
the_clicked_container_slot_gets_the_remainder :: proc() {
}
    // rust: let before = vec![Some(stack("minecraft:dirt", 10))];
        // The mod moved the dirt to a slot past the menu's and left the clicked one as it was.
    // rust: let mut items = vec![
    // rust: Some(stack("minecraft:dirt", 10)),
    // rust: None,
    // rust: Some(stack("minecraft:dirt", 10)),
    // rust: ];
    // rust: let mut inventory = vec![None; 36];
    // rust: settle(
    // rust: MenuSlot::Container(0),
    // rust: true,
    // rust: stack("minecraft:dirt", 0),
    // rust: &before,
    // rust: &mut items,
    // rust: &mut inventory,
    // rust: );
    // rust: assert_eq!(items, [None, None, Some(stack("minecraft:dirt", 10))]);
}

    // A click no mod took leaves the block's items as they were before the
    // call, so a mod that moved items without taking it duplicates nothing.
an_untaken_click_keeps_the_items_as_they_were :: proc() {
}
    // rust: let before = vec![Some(stack("minecraft:dirt", 10)), None];
    // rust: let mut items = vec![None, Some(stack("minecraft:dirt", 10))];
    // rust: let mut inventory = vec![None; 36];
    // rust: inventory[3] = Some(stack("minecraft:dirt", 5));
    // rust: settle(
    // rust: MenuSlot::Inventory(3),
    // rust: false,
    // rust: stack("minecraft:dirt", 0),
    // rust: &before,
    // rust: &mut items,
    // rust: &mut inventory,
    // rust: );
    // rust: assert_eq!(items, before);
    // rust: assert_eq!(inventory[3], Some(stack("minecraft:dirt", 5)));
}
}
