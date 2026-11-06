//! Transpiled from Horizon Rust crate
package horizon_client_remote_stations

import "core:fmt"
import "core:mem"
import "core:math"

// A server's workstation menus on this client: the server opens the menu
// (`ClientboundOpenScreenPacket` with the station's `MenuType`), the
// station screen draws it, and its clicks and buttons are predicted on the
// menu engine (`Game::menu_session`) and sent, as
// `MultiPlayerGameMode.handleContainerInput` and `handleInventoryButtonClick`
// do. The menu's client-side `slotsChanged` follows the server's slots, and
// its data slots come in `ClientboundContainerSetDataPacket`.
// use super::{
    // rust: Game, Screen,
    // rust: stations::{Kind, Station},
}
// use horizon_protocol::packets::play::{self, Serverbound as S};

    // rust: impl Game<'_> {
    // The server opened workstation menu `menu` in window `container`.
    // rust: pub(super) fn remote_open_station(
    // rust: &mut self,
    // rust: container: i32,
    // rust: menu: String,
    // rust: kind: Kind,
    // rust: title: horizon_client::text::Text,
    // rust: pos: [i32; 3],
    // rust: ) {
    // rust: if let Some(r) = self.remote.as_mut() {
    // rust: r.menu = Some((container, menu));
    // rust: r.menu_title = Some(title);
}
    // rust: self.craft_size = 2;
    // rust: self.container = None;
    // rust: self.station = Some(Station::new_kind(kind, pos));
    // rust: self.screen = Screen::Inventory;
    // rust: self.capture(false);
}

    // Window `container` is the server's workstation menu, open here.
    // rust: pub(super) fn remote_station_open(&self, container: i32) -> bool {
    // rust: self.station.is_some()
    // rust: && self
    // rust: .remote
    // rust: .as_ref()
    // rust: .and_then(|r| r.menu.as_ref())
    // rust: .is_some_and(|(id, name)| {
    // rust: *id == container && Self::remote_station_kind(name).is_some()
    // rust: })
}

    // The server set station slot `internal`: the client menu's
    // `Slot.set` runs its container's `setChanged`, so the loom lists the
    // patterns its inputs allow and the stonecutter the recipes of its input.
    // rust: pub(super) fn remote_station_slot_changed(&mut self, internal: usize) {
    // rust: if !self.station.as_ref().is_some_and(|s| {
    // rust: matches!(
    // rust: s.kind,
    // rust: Kind::Loom
    // rust: | Kind::Stonecutter
    // rust: | Kind::Grindstone
    // rust: | Kind::Anvil
    // rust: | Kind::Smithing
    // rust: | Kind::Cartography
    // rust: )
    // rust: }) {
    // rust: return;
}
    // rust: self.menu_session(|menu, env, to_menu| {
    // rust: let i = to_menu(internal)?;
    // rust: let stack = menu.slot(i).cloned();
    // rust: menu.set_slot(env, i, stack);
    // rust: Some(true)
    // rust: });
        // AnvilScreen.slotChanged: the box shows the new input's name, which
        // its responder sends.
    // rust: self.remote_anvil_rename();
}

    // `AbstractContainerMenu.setData` from the server.
    // rust: pub(super) fn remote_station_data(&mut self, id: usize, value: i16) {
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: match (s.kind, id) {
            // LoomMenu.selectedBannerPatternIndex.
    // rust: (Kind::Loom, 0) => s.loom.selected = usize::try_from(value).ok(),
            // StonecutterMenu.selectedRecipeIndex.
    // rust: (Kind::Stonecutter, 0) => s.selected = usize::try_from(value).ok(),
            // AnvilMenu.cost.
    // rust: (Kind::Anvil, 0) => s.anvil.cost = i32::from(value),
            // EnchantmentMenu: costs, the seed (the screen's glyph names),
            // the clues' enchantments and levels.
    // rust: (Kind::Enchanting, 0..3) => s.offers.costs[id] = i32::from(value),
    // rust: (Kind::Enchanting, 3) => self.level.xp_seed = i32::from(value),
    // rust: (Kind::Enchanting, 4..7) => {
    // rust: let name = self.remote.as_ref().and_then(|r| {
    // rust: r.registries
    // rust: .name("minecraft:enchantment", i32::from(value))
    // rust: .map(std::sync::Arc::<str>::from)
    // rust: });
    // rust: let level = s.offers.clues[id - 4].as_ref().map_or(1, |(_, l)| *l);
    // rust: s.offers.clues[id - 4] = name.map(|n| (n, level));
}
    // rust: (Kind::Enchanting, 7..10) => {
    // rust: if let Some((_, level)) = s.offers.clues[id - 7].as_mut() {
    // rust: *level = value.max(0) as u32;
}
}
            // BeaconMenu: the levels, then the powers (BeaconScreen's
            // dataChanged shows the menu's).
    // rust: (Kind::Beacon, 0) => s.beacon_levels = Some(i32::from(value)),
    // rust: (Kind::Beacon, 1 | 2) => {
    // rust: let effect = self.remote_effect_id(i32::from(value) - 1);
    // rust: let index =
    // rust: effect.and_then(|e| super::beacon::EFFECTS.iter().position(|(n, _)| *n == e));
    // rust: if let Some(s) = self.station.as_mut() {
    // rust: s.beacon[id - 1] = index;
}
}
    // rust: _ => {}
}
}

    // `AnvilScreen.onNameChanged` on a server: the rename box's text (blank
    // when it is the input's own name) goes to the server when the menu's
    // `setItemName` takes it.
    // rust: pub(super) fn remote_anvil_rename(&mut self) {
    // rust: if self.remote.is_none() {
    // rust: return;
}
    // rust: let Some(s) = self
    // rust: .station
    // rust: .as_ref()
    // rust: .filter(|s| s.kind == Kind::Anvil && s.inputs[0].is_some())
    // rust: else {
    // rust: return;
}
    // rust: let name = self.anvil_item_name(s);
    // rust: if s.anvil_sent.as_deref() == Some(&name) {
    // rust: return;
}
    // rust: if let Some(s) = self.station.as_mut() {
    // rust: s.anvil_sent = Some(name.clone());
}
    // rust: self.send(S::RenameItem(play::RenameItem { name }));
}

    // `MultiPlayerGameMode.handleInventoryButtonClick`: the screen already
    // ran `clickMenuButton` on its own menu.
    // rust: pub(super) fn remote_station_button(&self, button: i32) {
    // rust: if let Some((container, _)) = self.remote.as_ref().and_then(|r| r.menu.as_ref())
    // rust: && self.remote_station_open(*container)
    // rust: {
    // rust: self.send(S::ContainerButtonClick(play::ContainerButtonClick {
    // rust: container: *container,
    // rust: button,
    // rust: }));
}
}
}
