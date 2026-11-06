//! Transpiled from Horizon Rust crate
package horizon_client_creative_hotbar

import "core:fmt"
import "core:mem"
import "core:math"

// The creative toolbars, `hotbar.nbt` beside `options.txt`: hold the save or
// load key and press a hotbar key (`Minecraft.handleKeybinds`).
// use super::Game;
// use horizon_client::{hotbar, items::ItemStack, keybinds, text::Text};
// use horizon_world::nbt::Tag;

    // rust: impl Game<'_> {
    // Whether the key bound to `mapping` is held, or the controller button bound to it.
    // rust: pub(super) fn mapped_key_down(&self, mapping: &str) -> bool {
    // rust: keybinds::key_code(self.settings.keys.get(mapping))
    // rust: .is_some_and(|k| self.physical_keys.contains(&k))
    // rust: || self.pad.holds_action(&self.settings.controller, mapping)
}

    // `CreativeModeInventoryScreen.selectTab` on the HOTBAR tab: each saved
    // row's nine stacks, or for an empty row a locked paper in that row's own
    // slot, named after the keys that save it (`inventory.hotbarInfo`).
    // rust: pub(super) fn refresh_saved_hotbars(&mut self) {
    // rust: if !self.creative_screen.tab().hotbar {
    // rust: return;
}
    // rust: let path = Self::options_path().with_file_name("hotbar.nbt");
    // rust: let known = |id: &str| self.res.items().get(id).is_some();
    // rust: let rows = hotbar::load(&path, &known);
    // rust: let key = |mapping: &str| keybinds::display_name(self.settings.keys.get(mapping)).plain();
    // rust: let empty = || ItemStack::new("minecraft:air", 0);
    // rust: let mut items = Vec::with_capacity(hotbar::GROUPS * hotbar::SIZE);
    // rust: for (i, row) in rows.iter().enumerate().take(hotbar::GROUPS) {
    // rust: if row.iter().any(Option::is_some) {
    // rust: items.extend(row.iter().map(|s| s.clone().unwrap_or_else(empty)));
    // rust: continue;
}
    // rust: for j in 0..hotbar::SIZE {
    // rust: if j != i {
    // rust: items.push(empty());
    // rust: continue;
}
    // rust: let with = [
    // rust: key("key.saveToolbarActivator"),
    // rust: key(&format!("key.hotbar.{}", i + 1)),
    // rust: ];
    // rust: let mut paper = ItemStack::new("minecraft:paper", 1);
    // rust: let data = paper.data_mut();
    // rust: data.set_other(
    // rust: "minecraft:creative_slot_lock",
    // rust: Some(Tag::compound(Vec::<(&str, Tag)>::new())),
    // rust: );
    // rust: data.set_other(
    // rust: "minecraft:item_name",
    // rust: Some(Tag::compound([
    // rust: ("translate", Tag::String("inventory.hotbarInfo".into())),
    // rust: (
    // rust: "with",
    // rust: Tag::List(
    // rust: with.iter()
    // rust: .map(|s| Tag::String(s.as_str().into()))
    // rust: .collect(),
    // rust: ),
    // rust: ),
    // rust: ])),
    // rust: );
    // rust: items.push(paper);
}
}
    // rust: self.creative_screen.set_saved_hotbars(items);
}
    // `CreativeModeInventoryScreen.handleHotbarLoadOrSave` for the hotbar key
    // `index`: load puts the saved row in the hotbar (the creative slot
    // packets follow from the inventory change), save stores the hotbar and
    // says so on the action bar.
    // rust: pub(super) fn hotbar_load_or_save(&mut self, index: usize, load: bool) {
    // rust: let path = Self::options_path().with_file_name("hotbar.nbt");
    // rust: let known = |id: &str| self.items().get(id).is_some();
    // rust: let mut rows = hotbar::load(&path, &known);
    // rust: if load {
    // rust: for (slot, stack) in rows[index].iter().enumerate() {
    // rust: self.inventory[slot] = stack.clone();
}
    // rust: return;
}
    // rust: rows[index] = self.inventory[..hotbar::SIZE].to_vec();
    // rust: if let Err(e) = hotbar::save(&path, &rows) {
            // saveHotbar sets the message inside its try, so a failed save says nothing.
    // rust: log::warn!("the creative hotbar was not saved: {e}");
    // rust: return;
}
    // rust: let key = |mapping: &str| keybinds::display_name(self.settings.keys.get(mapping));
    // rust: let message = Text::translate(
    // rust: "inventory.hotbarSaved",
    // rust: &[
    // rust: key("key.loadToolbarActivator"),
    // rust: key(&format!("key.hotbar.{}", index + 1)),
    // rust: ],
    // rust: );
        // handleHotbarLoadOrSave: the overlay, said at once.
    // rust: self.say_system_now(&message);
    // rust: self.titles.set_overlay(message, false);
}
}
