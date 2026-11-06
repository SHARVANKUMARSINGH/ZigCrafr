//! Transpiled from Horizon Rust crate
package horizon_client_lan_stations

import "core:fmt"
import "core:mem"
import "core:math"

// Workstation menus for LAN guests: the screen a guest's use opens runs on
// the host's menu engine (`horizon_client::menu`), the one single player
// uses, with vanilla's packets: OpenScreen with the station's `MenuType`,
// container clicks, `ServerboundContainerButtonClickPacket`, the content and
// data slot sync after each (`broadcastChanges`), and the inputs back into
// the inventory when the menu closes (`AbstractContainerMenu.clearContainer`).
// use super::{
    // rust: Game,
    // rust: lan::LanHost,
    // rust: lan_crafting::input,
    // rust: stations::{Kind as StationKind, Station},
}
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: items::ItemStack,
    // rust: menu::{AnvilCraft, Kind, Menu},
}
// use horizon_core::random::RandomSource;
// use horizon_protocol::packets::play::{self, Clientbound as C};

// A guest's open workstation menu.
    // rust: pub(super) struct GuestStation {
    // rust: pub(super) window: i32,
    // rust: state: i32,
    // rust: pub(super) kind: StationKind,
    // rust: pub(super) pos: [i32; 3],
    // rust: menu: Box<Menu>,
    // The data slots the client was last sent.
    // rust: sent_data: Vec<i32>,
    // The game time of the menu's last sound (`lastSoundTime`).
    // rust: last_sound: u64,
}

// A guest's open lectern: `LecternMenu` over the block entity, made on the
// menu engine for each click (`Game::lectern_menu`).
    // rust: pub(super) struct GuestLectern {
    // rust: pub(super) window: i32,
    // rust: state: i32,
    // rust: pub(super) key: (i32, i32, i32),
    // The book and page the client was last sent (`broadcastChanges`).
    // rust: sent: Option<(Option<ItemStack>, i32)>,
}

// The `MenuType`, the engine's menu and the input slots
// (`clearContainer`'s container) of a station a guest can use.
    // rust: pub(super) fn menu_of(kind: StationKind) -> Option<(&'static str, Kind, std::ops::Range<usize>)> {
    // rust: Some(match kind {
    // rust: StationKind::Loom => ("minecraft:loom", Kind::Loom, 0..3),
    // rust: StationKind::Stonecutter => ("minecraft:stonecutter", Kind::Stonecutter, 0..1),
    // rust: StationKind::Grindstone => ("minecraft:grindstone", Kind::Grindstone, 0..2),
    // rust: StationKind::Anvil => ("minecraft:anvil", Kind::Anvil, 0..2),
    // rust: StationKind::Smithing => ("minecraft:smithing", Kind::Smithing, 0..3),
    // rust: StationKind::Enchanting => ("minecraft:enchantment", Kind::Enchanting, 0..2),
    // rust: StationKind::Beacon => ("minecraft:beacon", Kind::Beacon, 0..1),
    // rust: StationKind::Cartography => ("minecraft:cartography_table", Kind::Cartography, 0..2),
    // rust: _ => return None,
    // rust: })
}

    // rust: impl Game<'_> {
    // A workstation a guest's use opened (`ServerPlayer.openMenu`); false
    // when guests can't use that one yet.
    // rust: pub(super) fn lan_open_station(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: station: &Station,
    // rust: ) -> bool {
    // rust: let Some((menu_type, kind, _)) = menu_of(station.kind) else {
    // rust: return false;
}
        // The mods may stop the menu; the click is spent.
    // rust: if !self.guest_may_open(host, conn, menu_type, Some(station.pos)) {
    // rust: return true;
}
        // ServerPlayer.openMenu closes the menu that was open.
    // rust: self.guest_close_all(host, conn);
    // rust: let title = horizon_protocol::text::translatable(station.kind.title_key(), &[]);
    // rust: let Some(window) = host.hub.open_window(conn, menu_type, title) else {
    // rust: return true;
}
    // rust: let mut menu = Box::new(Menu::new(kind));
        // Without a mod the take runs AnvilMenu.onTake's order in the click itself.
    // rust: menu.anvil_hook = kind == Kind::Anvil && !horizon_client::mod_api::mods().is_empty();
    // rust: if let Some(g) = host.hub.guests.iter_mut().find(|g| g.conn == conn)
    // rust: && kind == Kind::Enchanting
    // rust: {
            // Player.enchantmentSeed, made when first needed.
    // rust: if g.xp_seed == 0 {
    // rust: g.xp_seed = self.world.random.next_int();
}
    // rust: menu.data[3] = g.xp_seed;
}
    // rust: if kind == Kind::Beacon {
    // rust: menu.data = self.beacon_data(host, station.pos).to_vec();
}
    // rust: host.play.entry(conn).or_default().station = Some(GuestStation {
    // rust: window,
    // rust: state: 0,
    // rust: kind: station.kind,
    // rust: pos: station.pos,
    // rust: menu,
    // rust: sent_data: Vec::new(),
    // rust: last_sound: 0,
    // rust: });
    // rust: self.lan_send_station(host, conn);
    // rust: true
}

    // Runs `op` on the guest's open station (window `window`, any when
    // None) with their inventory in it, then sends what changed. False when
    // no such window is open.
    // rust: fn lan_station_op(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: Option<i32>,
    // rust: op: impl FnOnce(&mut Menu, &horizon_client::menu::Env),
    // rust: ) -> bool {
    // rust: let Some(mut gs) = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .and_then(|p| p.station.take_if(|s| window.is_none_or(|w| s.window == w)))
    // rust: else {
    // rust: return false;
}
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn)
    // rust: && !host.hub.guests[gi].spectator()
    // rust: {
            // createResult runs when the inputs change (or a rename): a click
            // elsewhere must not hand the hooks their own result again.
    // rust: let result_slot = match gs.kind {
    // rust: StationKind::Anvil | StationKind::Grindstone => Some(2),
    // rust: StationKind::Smithing => Some(3),
    // rust: _ => None,
}
    // rust: let before = result_slot.map(|r| {
    // rust: let slots: Vec<_> = (0..=r).map(|s| gs.menu.slot(s).cloned()).collect();
                // Only the anvil has a data slot (its cost); grindstone and smithing menus have none.
    // rust: (slots, gs.menu.data.first().copied())
    // rust: });
    // rust: let mut undo = None;
    // rust: let hook = gs.menu.anvil_hook;
    // rust: self.guest_menu_op(host, gi, &mut gs.menu, |menu, env| {
    // rust: undo = hook.then(|| menu.anvil_undo());
    // rust: op(menu, env);
    // rust: });
            // AnvilCraftEvent.Pre: the taken result's onTake waits for the mods.
    // rust: let mut anvil_craft = gs.menu.anvil_craft.take();
    // rust: let mut cancelled = false;
    // rust: if let Some(craft) = &anvil_craft {
    // rust: let guest = &host.hub.guests[gi];
    // rust: let (uuid, name) = (guest.uuid, guest.name.clone());
    // rust: let mut cancel = false;
    // rust: self.native_anvil_craft_pre(uuid, &name, gs.pos, craft, &mut cancel);
    // rust: if cancel && let Some(undo) = undo {
                    // The take is refused: the result, inputs, cost, inventory
                    // and cursor are as before the click (the resync below
                    // tells the client).
    // rust: anvil_craft = None;
    // rust: cancelled = true;
    // rust: self.guest_menu_op(host, gi, &mut gs.menu, |menu, _| menu.anvil_cancel(undo));
    // rust: } else {
    // rust: gs.menu.anvil_take(&self.menu_env());
    // rust: let dropped = std::mem::take(&mut gs.menu.dropped);
    // rust: self.drop_guest_items(host, gi, dropped);
}
}
            // A cancelled take runs no createResult: the inputs are untouched.
    // rust: let recomputed = !cancelled
    // rust: && before.is_some_and(|(slots, cost)| {
    // rust: cost != gs.menu.data.first().copied()
    // rust: || slots
    // rust: .iter()
    // rust: .enumerate()
    // rust: .any(|(s, b)| gs.menu.slot(s) != b.as_ref())
    // rust: });
    // rust: if recomputed && gs.kind == StationKind::Anvil {
    // rust: let guest = &host.hub.guests[gi];
    // rust: let (uuid, name) = (guest.uuid, guest.name.clone());
    // rust: let mut result = gs.menu.slot(2).cloned();
    // rust: self.native_prepare_anvil(uuid, &name, gs.pos, &mut result, &mut gs.menu.data[0]);
    // rust: let env = self.menu_env();
    // rust: gs.menu.set_slot(&env, 2, result);
}
    // rust: if recomputed && gs.kind == StationKind::Grindstone {
    // rust: let guest = &host.hub.guests[gi];
    // rust: let (uuid, name) = (guest.uuid, guest.name.clone());
    // rust: let mut result = gs.menu.slot(2).cloned();
    // rust: self.native_prepare_grindstone(uuid, &name, gs.pos, &mut result);
    // rust: let env = self.menu_env();
    // rust: gs.menu.set_slot(&env, 2, result);
}
    // rust: if recomputed && gs.kind == StationKind::Smithing {
    // rust: let guest = &host.hub.guests[gi];
    // rust: let (uuid, name) = (guest.uuid, guest.name.clone());
    // rust: let mut result = gs.menu.slot(3).cloned();
    // rust: self.native_prepare_smithing(uuid, &name, gs.pos, &mut result);
    // rust: let env = self.menu_env();
    // rust: gs.menu.set_slot(&env, 3, result);
}
    // rust: self.lan_station_sounds(&mut gs);
    // rust: if let Some(amount) = gs.menu.ground.take() {
    // rust: self.grindstone_taken(gs.pos, amount);
}
    // rust: self.lan_station_combined(host, conn, &mut gs, anvil_craft.as_ref());
    // rust: if let Some(button) = gs.menu.enchant_button.take() {
    // rust: self.lan_enchant(host, gi, &mut gs, button);
}
    // rust: if std::mem::take(&mut gs.menu.enchant_changed) {
    // rust: self.lan_enchant_offers(host, gi, &mut gs);
}
}
    // rust: host.play.entry(conn).or_default().station = Some(gs);
    // rust: self.lan_send_station(host, conn);
    // rust: true
}

    // How many slots of its own the guest's open station menu has before the
    // player's inventory (`slot_count - 36`), if one is open.
    // rust: pub(super) fn lan_station_own_slots(host: &LanHost, conn: u32) -> Option<usize> {
    // rust: let gs = host.play.get(&conn)?.station.as_ref()?;
    // rust: Some(gs.menu.slot_count() - 36)
}

    // `LecternBlock.openScreen` for a guest: `minecraft:lectern` over the
    // block entity, with its book and page.
    // rust: pub(super) fn lan_open_lectern(&mut self, host: &mut LanHost, conn: u32, key: (i32, i32, i32)) {
    // rust: if !self.guest_may_open(host, conn, "minecraft:lectern", Some([key.0, key.1, key.2])) {
    // rust: return;
}
        // ServerPlayer.openMenu closes the menu that was open.
    // rust: self.guest_close_all(host, conn);
    // rust: let title = horizon_protocol::text::translatable("container.lectern", &[]);
    // rust: let Some(window) = host.hub.open_window(conn, "minecraft:lectern", title) else {
    // rust: return;
}
    // rust: host.play.entry(conn).or_default().lectern = Some(GuestLectern {
    // rust: window,
    // rust: state: 0,
    // rust: key,
    // rust: sent: None,
    // rust: });
    // rust: self.lan_send_lectern(host, conn, true);
}

    // The lectern's book and page for the client: everything (`all`), or
    // what changed since it was last sent.
lan_send_lectern :: proc(self: ^Self, host: ^LanHost, conn: u32, all: bool) {
}
    // rust: let Some(gl) = host.play.get_mut(&conn).and_then(|p| p.lectern.as_mut()) else {
    // rust: return;
}
    // rust: let (book, page) = match self.world.block_entities.get(&gl.key) {
    // rust: Some(BlockEntity::Lectern(l)) => (l.book.clone(), l.page),
    // rust: _ => (None, 0),
}
    // rust: let now = Some((book.clone(), page));
    // rust: if !all && gl.sent == now {
    // rust: return;
}
    // rust: let page_changed = gl.sent.as_ref().is_none_or(|(_, p)| *p != page);
    // rust: gl.sent = now;
    // rust: gl.state = (gl.state + 1) & 0x7FFF;
    // rust: let (window, state) = (gl.window, gl.state);
    // rust: let carried = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn)
    // rust: .and_then(|g| g.carried.clone());
    // rust: let content = C::ContainerSetContent(play::ContainerSetContent {
    // rust: container: window,
    // rust: state,
    // rust: items: vec![host.hub.stack(&book)],
    // rust: carried: host.hub.stack(&carried),
    // rust: });
    // rust: host.hub.send_to(conn, &content);
    // rust: if all || page_changed {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::ContainerSetData(play::ContainerSetData {
    // rust: container: window,
    // rust: id: 0,
    // rust: value: page as i16,
    // rust: }),
    // rust: );
}
}

    // Runs `op` on the guest's lectern menu (window `window`) with their
    // inventory, the block entity takes the book and page back, and the
    // client gets what changed. False when no such window is open.
    // rust: fn lan_lectern_op(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: i32,
    // rust: op: impl FnOnce(&mut Menu, &horizon_client::menu::Env),
    // rust: ) -> bool {
    // rust: let Some(key) = host
    // rust: .play
    // rust: .get(&conn)
    // rust: .and_then(|p| p.lectern.as_ref())
    // rust: .filter(|l| l.window == window)
    // rust: .map(|l| l.key)
    // rust: else {
    // rust: return false;
}
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn)
    // rust: && !host.hub.guests[gi].spectator()
    // rust: && let Some(mut menu) = self.lectern_menu(key)
    // rust: {
            // Player.mayBuild: survival and creative.
    // rust: let may_build = matches!(host.hub.guests[gi].game_mode, 0 | 1);
    // rust: self.guest_menu_op(host, gi, &mut menu, |menu, env| {
    // rust: menu.may_build = may_build;
    // rust: op(menu, env);
    // rust: });
    // rust: self.lectern_menu_done(key, &menu);
}
    // rust: self.lan_send_lectern(host, conn, true);
    // rust: true
}

    // A click on the guest's lectern window; false for other windows.
    // rust: pub(super) fn lan_lectern_click(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: ) -> bool {
    // rust: self.lan_lectern_op(host, conn, p.container, |menu, env| {
    // rust: let _ = menu.click(env, i32::from(p.slot), i32::from(p.button), input(p.input));
    // rust: })
}

    // The rest of a taken anvil or smithing result's `onTake`: the guest
    // pays the levels, the anvil wears (level event 1030 or 1029), the
    // smithing table sounds (1044). An anvil's `craft` is then reported to
    // the mods (`AnvilCraftEvent.Post`).
    // rust: fn lan_station_combined(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: gs: &mut GuestStation,
    // rust: craft: Option<&AnvilCraft>,
    // rust: ) {
    // rust: let change = std::mem::take(&mut gs.menu.level_change);
    // rust: if change != 0 {
    // rust: self.as_guest(host, conn, |g| g.give_levels(change));
}
    // rust: if !std::mem::take(&mut gs.menu.combined) {
    // rust: return;
}
    // rust: if gs.kind == StationKind::Smithing {
    // rust: self.level_event_at(1044, gs.pos, 0);
    // rust: } else {
    // rust: let creative = gs.menu.creative;
            // A broken anvil closes the menu on the next stillValid check.
    // rust: self.anvil_used(gs.pos, creative);
    // rust: if let Some(craft) = craft
    // rust: && let Some(guest) = host.hub.guests.iter().find(|g| g.conn == conn)
    // rust: {
    // rust: let (uuid, name) = (guest.uuid, guest.name.clone());
    // rust: self.native_anvil_craft_post(uuid, &name, gs.pos, craft);
}
}
}

    // `EnchantmentMenu.slotsChanged` with a level: the costs and clues for
    // the guest's seed and the bookshelves around the table.
lan_enchant_offers :: proc(self: ^Self, host: ^LanHost, gi: uint, gs: ^GuestStation) {
}
    // rust: let seed = host.hub.guests[gi].xp_seed;
    // rust: let bookcases = self.count_bookshelves(gs.pos);
    // rust: let offers = horizon_client::stations::enchant_offers(
    // rust: &self.stations().enchantments,
    // rust: self.items(),
    // rust: seed,
    // rust: bookcases,
    // rust: gs.menu.slot(0),
    // rust: );
    // rust: let guest = &host.hub.guests[gi];
    // rust: let mut costs = offers.costs;
    // rust: self.native_prepare_item_enchant(guest.uuid, &guest.name, gs.pos, &mut costs);
    // rust: let mut clues = offers.clues;
    // rust: for i in 0..3 {
            // A cost a mod changed shows the clue of the list it will give.
    // rust: if costs[i] != offers.costs[i]
    // rust: && let Some(stack) = gs.menu.slot(0)
    // rust: {
    // rust: clues[i] = horizon_client::stations::enchant_clue(
    // rust: &self.stations().enchantments,
    // rust: self.items(),
    // rust: seed,
    // rust: i,
    // rust: costs[i],
    // rust: stack,
    // rust: );
}
}
    // rust: for i in 0..3 {
    // rust: gs.menu.data[i] = costs[i];
    // rust: let clue = clues[i].as_ref();
    // rust: gs.menu.data[4 + i] = clue
    // rust: .and_then(|(e, _)| host.hub.registry_id("minecraft:enchantment", e))
    // rust: .unwrap_or(-1);
    // rust: gs.menu.data[7 + i] = clue.map_or(-1, |(_, l)| *l as i32);
}
    // rust: gs.menu.data[3] = seed;
}

    // `EnchantmentMenu.clickMenuButton`'s `access.execute`: the item gets
    // the offer's enchantments, the guest pays its levels and lapis and
    // gets a new seed, the table sounds, and the offers are made again.
lan_enchant :: proc(self: ^Self, host: ^LanHost, gi: uint, gs: ^GuestStation, button: uint) {
}
    // rust: let Some(item) = gs.menu.slot(0).cloned() else {
    // rust: return;
}
    // rust: let g = &host.hub.guests[gi];
    // rust: let (seed, creative, conn, uuid, name) =
    // rust: (g.xp_seed, g.creative(), g.conn, g.uuid, g.name.clone());
    // rust: let Some(enchanted) = horizon_client::stations::apply_enchantment(
    // rust: &self.stations().enchantments,
    // rust: self.items(),
    // rust: seed,
    // rust: button,
    // rust: gs.menu.data[button],
    // rust: &item,
    // rust: ) else {
    // rust: return;
}
    // rust: let enchanted_for_hook = enchanted.clone();
    // rust: let need = button as i32 + 1;
        // Player.onEnchantmentPerformed, and EnchantmentMenu's awardStat(ENCHANT_ITEM).
    // rust: self.as_guest(host, conn, |game| {
    // rust: game.give_levels(-need);
    // rust: game.award_custom_stat("enchant_item", 1);
            // CriteriaTriggers.ENCHANTED_ITEM, with the levels it cost.
    // rust: game.trigger_enchanted_item(&enchanted, need);
    // rust: });
    // rust: host.hub.guests[gi].xp_seed = self.world.random.next_int();
    // rust: let env = self.menu_env();
    // rust: let lapis = gs.menu.slot(1).cloned().filter(|_| !creative).map(|mut l| {
    // rust: l.count = l.count.saturating_sub(need as u32);
    // rust: l
    // rust: });
    // rust: gs.menu.set_slot(&env, 0, Some(enchanted));
    // rust: if !creative {
    // rust: gs.menu.set_slot(&env, 1, lapis.filter(|l| l.count > 0));
}
    // rust: gs.menu.enchant_changed = false;
    // rust: self.lan_enchant_offers(host, gi, gs);
    // rust: let pitch = self.world.random.next_float() * 0.1 + 0.9;
    // rust: let at = gs.pos.map(|v| f64::from(v) + 0.5);
    // rust: self.audio.play(
    // rust: "minecraft:block.enchantment_table.use",
    // rust: Some(at),
    // rust: 1.0,
    // rust: pitch,
    // rust: );
    // rust: self.native_enchant_item(uuid, &name, gs.pos, &enchanted_for_hook, need);
}

    // `ServerGamePacketListenerImpl.handleRenameItem`: the guest's anvil
    // takes the name (`AnvilMenu.setItemName`).
    // rust: pub(super) fn lan_station_rename(&mut self, host: &mut LanHost, conn: u32, name: &str) {
    // rust: let anvil = host
    // rust: .play
    // rust: .get(&conn)
    // rust: .and_then(|p| p.station.as_ref())
    // rust: .is_some_and(|s| s.kind == StationKind::Anvil);
    // rust: if anvil
    // rust: && self.chat_filter_text(
    // rust: host,
    // rust: conn,
    // rust: &[name],
    // rust: horizon_client::lan::hub::chat_filter::Place::Anvil,
    // rust: )
    // rust: {
    // rust: self.lan_station_op(host, conn, None, |menu, env| {
    // rust: menu.rename(env, name);
    // rust: });
}
}

    // The sounds the menu played, at the station (heard by everyone around,
    // as `level.playSound(null, pos, ...)`), once per tick.
lan_station_sounds :: proc(self: ^Self, gs: ^GuestStation) {
}
    // rust: let sounds = std::mem::take(&mut gs.menu.sounds);
    // rust: if sounds.is_empty() || gs.last_sound == self.ticks {
    // rust: return;
}
    // rust: gs.last_sound = self.ticks;
    // rust: let at = gs.pos.map(|v| f64::from(v) + 0.5);
    // rust: for sound in sounds {
    // rust: self.audio.play(sound, Some(at), 1.0, 1.0);
}
}

    // A click on the guest's station window; false for other windows.
    // rust: pub(super) fn lan_station_click(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: ) -> bool {
    // rust: self.lan_station_op(host, conn, Some(p.container), |menu, env| {
    // rust: let _ = menu.click(env, i32::from(p.slot), i32::from(p.button), input(p.input));
    // rust: })
}

    // `ServerGamePacketListenerImpl.handleContainerButtonClick`:
    // `clickMenuButton`, then `broadcastChanges` when the menu took it.
    // rust: pub(super) fn lan_station_button(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: i32,
    // rust: id: i32,
    // rust: ) {
        // A mod container's menu: its mod's buttons (`native_menu_button`),
        // as handleContainerButtonClick checks them: the open menu, not a
        // spectator, still valid.
    // rust: if let Some(g) = host.hub.guest(conn)
    // rust: && let Some(menu) = g.menu.as_ref().filter(|m| m.window == window)
    // rust: && let Some(pos) = menu.pos
    // rust: && self.mod_menu_at(pos).is_some()
    // rust: {
    // rust: if !g.spectator() && menu.slots.still_valid(&self.world, g, menu.pos) {
                // The clicking player's cursor stack (`clickMenuButton`'s
                // other half). Single player's own player is a guest of
                // its own host too (`lan.rs:165`), so this one path covers
                // both single player and a LAN guest.
    // rust: let mut carried = g.carried.clone();
                // As that player: `native_acting_player`, `native_acting_id`
                // and `native_give_stack` answer for the one who pressed.
    // rust: self.as_guest(host, conn, |game| {
    // rust: game.mod_menu_button(pos, id, &mut carried)
    // rust: });
    // rust: if host.hub.guest(conn).is_some_and(|g| g.carried != carried) {
    // rust: let net = host.hub.stack(&carried);
    // rust: if let Some(g) = host.hub.guest_mut(conn) {
    // rust: g.carried = carried;
    // rust: g.send(&C::SetCursorItem(play::SetCursorItem { item: net }));
}
}
}
    // rust: return;
}
        // LecternMenu's page buttons and Take Book.
    // rust: if self.lan_lectern_op(host, conn, window, |menu, env| {
    // rust: menu.button(env, id);
    // rust: }) {
    // rust: return;
}
    // rust: let identity = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone()));
    // rust: let mut selected = false;
    // rust: let kind = host
    // rust: .play
    // rust: .get(&conn)
    // rust: .and_then(|p| p.station.as_ref())
    // rust: .filter(|s| s.window == window)
    // rust: .map(|s| s.kind);
    // rust: self.lan_station_op(host, conn, Some(window), |menu, env| {
    // rust: selected = menu.button(env, id);
    // rust: });
    // rust: if selected && let Some((player, name)) = identity {
    // rust: match kind {
    // rust: Some(StationKind::Loom) => {
    // rust: self.native_player_loom_pattern_select(player, &name, id);
}
    // rust: Some(StationKind::Stonecutter) => {
    // rust: self.native_player_stonecutter_recipe_select(player, &name, id);
}
    // rust: _ => {}
}
}
}

    // The whole station menu and its changed data slots for the client
    // (`sendAllDataToRemote` / `broadcastChanges`).
lan_send_station :: proc(self: ^Self, host: ^LanHost, conn: u32) {
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let Some(gs) = host.play.get_mut(&conn).and_then(|p| p.station.as_mut()) else {
    // rust: return;
}
    // rust: gs.state = (gs.state + 1) & 0x7FFF;
    // rust: let own = gs.menu.slot_count() - 36;
    // rust: let mut items: Vec<Option<ItemStack>> =
    // rust: (0..own).map(|s| gs.menu.slot(s).cloned()).collect();
    // rust: let g = &host.hub.guests[gi];
    // rust: items.extend((9..36).chain(0..9).map(|i| g.inventory[i].clone()));
    // rust: let carried = g.carried.clone();
    // rust: let packet = C::ContainerSetContent(play::ContainerSetContent {
    // rust: container: gs.window,
    // rust: state: gs.state,
    // rust: items: items.iter().map(|s| host.hub.stack(s)).collect(),
    // rust: carried: host.hub.stack(&carried),
    // rust: });
    // rust: gs.sent_data.resize(gs.menu.data.len(), i32::MIN);
    // rust: let mut data = Vec::new();
    // rust: for (k, &v) in gs.menu.data.iter().enumerate() {
    // rust: if gs.sent_data[k] != v {
    // rust: gs.sent_data[k] = v;
    // rust: data.push(C::ContainerSetData(play::ContainerSetData {
    // rust: container: gs.window,
    // rust: id: k as i16,
    // rust: value: v as i16,
    // rust: }));
}
}
    // rust: host.hub.send_to(conn, &packet);
    // rust: host.hub.guests[gi].inventory_told();
    // rust: for packet in data {
    // rust: host.hub.send_to(conn, &packet);
}
}

    // `AbstractContainerMenu.removed` of the guest's station (`window`;
    // None closes it whichever it is): the carried stack and the inputs go
    // back to the inventory, what doesn't fit is dropped. False when no such
    // window is open.
    // rust: pub(super) fn lan_station_closed(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: Option<i32>,
    // rust: ) -> bool {
        // A lectern's menu keeps nothing of its own (the book is the block entity's).
    // rust: let lectern = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .and_then(|p| p.lectern.take_if(|l| window.is_none_or(|w| l.window == w)));
    // rust: if lectern.is_some() {
            // AbstractContainerMenu.removed: the carried stack goes back.
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn)
    // rust: && let Some(carried) = host.hub.guests[gi].carried.take()
    // rust: {
    // rust: self.lan_place_back(host, gi, vec![carried]);
}
    // rust: if window.is_some() {
    // rust: return true;
}
}
    // rust: let Some(gs) = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .and_then(|p| p.station.take_if(|s| window.is_none_or(|w| s.window == w)))
    // rust: else {
    // rust: return false;
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return true;
}
        // AbstractContainerMenu.removed: the carried stack first, then the inputs.
    // rust: let mut back: Vec<ItemStack> = host.hub.guests[gi].carried.take().into_iter().collect();
    // rust: let inputs = station_inputs(&gs);
    // rust: if gs.kind == StationKind::Beacon {
            // BeaconMenu.removed drops the payment (player.drop).
    // rust: if !back.is_empty() {
    // rust: self.lan_place_back(host, gi, std::mem::take(&mut back));
}
    // rust: self.drop_guest_items(host, gi, inputs);
    // rust: } else {
    // rust: back.extend(inputs);
}
    // rust: if !back.is_empty() {
    // rust: self.lan_place_back(host, gi, back);
}
    // rust: true
}

    // `BeaconBlockEntity.dataAccess`: the pyramid's levels and the powers
    // (`BeaconMenu.encodeEffect`: the `mob_effect` id + 1, 0 for none).
beacon_data :: proc(self: ^Self, host: ^LanHost, pos: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let Some(BlockEntity::Beacon(b)) = self.world.block_entities.get(&(pos[0], pos[1], pos[2]))
    // rust: else {
    // rust: return [0; 3];
}
    // rust: let encode = |e: &Option<String>| {
    // rust: e.as_deref()
    // rust: .and_then(|n| host.hub.registry_id("minecraft:mob_effect", n))
    // rust: .map_or(0, |id| id + 1)
}
    // rust: [b.levels, encode(&b.primary), encode(&b.secondary)]
}

    // `ServerGamePacketListenerImpl.handleSetBeaconPacket`: the guest's
    // beacon menu takes the powers (`BeaconMenu.updateEffects`), and they
    // become the block entity's (`dataAccess.set`: the power_select sound
    // while the beam is up).
    // rust: pub(super) fn lan_station_beacon(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: primary: Option<i32>,
    // rust: secondary: Option<i32>,
    // rust: ) {
    // rust: let Some(pos) = host
    // rust: .play
    // rust: .get(&conn)
    // rust: .and_then(|p| p.station.as_ref())
    // rust: .filter(|s| s.kind == StationKind::Beacon)
    // rust: .map(|s| s.pos)
    // rust: else {
    // rust: return;
}
    // rust: let Some((player, name)) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn)
    // rust: .map(|g| (g.uuid, g.name.clone()))
    // rust: else {
    // rust: return;
}
        // An id the registry doesn't have fails the packet's codec.
    // rust: let mut powers: [Option<(i32, String)>; 2] = [None, None];
    // rust: for (k, id) in [primary, secondary].into_iter().enumerate() {
    // rust: if let Some(id) = id {
    // rust: let Some(name) = host.hub.registry_name("minecraft:mob_effect", id) else {
    // rust: return;
}
    // rust: powers[k] = Some((id, name.to_owned()));
}
}
    // rust: let data = self.beacon_data(host, pos);
    // rust: let mut updated = None;
    // rust: self.lan_station_op(host, conn, None, |menu, env| {
    // rust: menu.data.copy_from_slice(&data);
    // rust: let power = |k: usize| powers[k].as_ref().map(|(id, n)| (*id, n.as_str()));
    // rust: updated = Some(menu.beacon_update(env, power(0), power(1)));
    // rust: });
        // handleSetBeaconPacket: effects the beacon can't give, or no payment, disconnect.
    // rust: if updated == Some(false) {
    // rust: let name = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn)
    // rust: .map(|g| g.name.clone());
    // rust: eprintln!(
    // rust: "Player {} tried to set invalid beacon effects",
    // rust: name.unwrap_or_default()
    // rust: );
    // rust: host.hub.kick(
    // rust: conn,
    // rust: horizon_protocol::text::translatable("multiplayer.disconnect.generic", &[]),
    // rust: );
}
    // rust: if updated != Some(true) {
    // rust: return;
}
    // rust: let [primary, secondary] = powers.map(|p| p.map(|(_, n)| n));
    // rust: let mut select_sound = false;
    // rust: if let Some(BlockEntity::Beacon(b)) =
    // rust: self.world.block_entities.get_mut(&(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: b.primary = primary.clone();
    // rust: b.secondary = secondary.clone();
    // rust: select_sound = !b.sections.is_empty();
}
    // rust: self.native_player_change_beacon_effect(
    // rust: player,
    // rust: &name,
    // rust: pos,
    // rust: primary.as_deref().unwrap_or(""),
    // rust: secondary.as_deref().unwrap_or(""),
    // rust: );
    // rust: if select_sound {
    // rust: self.beacon_sound(pos, "minecraft:block.beacon.power_select");
}
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
}

    // `ServerPlayer.doTick`'s `stillValid`: a guest's station closes once its
    // block is gone or the guest is out of reach (`isWithinBlockInteractionRange(pos, 4)`).
    // rust: pub(super) fn lan_stations_tick(&mut self, host: &mut LanHost) {
    // rust: self.lan_lecterns_tick(host);
    // rust: let conns: Vec<u32> = host
    // rust: .play
    // rust: .iter()
    // rust: .filter(|(_, p)| p.station.is_some())
    // rust: .map(|(c, _)| *c)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: let Some(g) = host.hub.guests.iter().find(|g| g.conn == conn) else {
    // rust: continue;
}
    // rust: if !host.hub.here(g) {
    // rust: continue;
}
    // rust: let Some(gs) = host.play.get(&conn).and_then(|p| p.station.as_ref()) else {
    // rust: continue;
}
    // rust: if !self.lan_station_valid(g, gs) {
    // rust: let window = gs.window;
    // rust: self.lan_station_closed(host, conn, Some(window));
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::ContainerClose(play::ContainerClose { container: window }),
    // rust: );
    // rust: } else if gs.kind == StationKind::Beacon {
                // The beacon's data slots follow its block entity.
    // rust: let data = self.beacon_data(host, gs.pos);
    // rust: if let Some(gs) = host.play.get_mut(&conn).and_then(|p| p.station.as_mut())
    // rust: && gs.menu.data[..] != data[..]
    // rust: {
    // rust: gs.menu.data.copy_from_slice(&data);
    // rust: self.lan_send_station(host, conn);
}
}
}
}
}

    // rust: impl Game<'_> {
    // A station menu's `stillValid`: its block is still that station and the
    // guest is within `isWithinBlockInteractionRange(pos, 4)`.
    // rust: pub(super) fn lan_station_valid(
    // rust: &self,
    // rust: g: &horizon_client::lan::guest::Guest,
    // rust: gs: &GuestStation,
    // rust: ) -> bool {
    // rust: let [x, y, z] = gs.pos;
    // rust: let name = &self.res.facts().get(self.world.block(x, y, z)).name;
    // rust: StationKind::from_block(name) == Some(gs.kind) && g.within_block_range(gs.pos, 4.0)
}

    // `LecternMenu.stillValid` (`Container.stillValidBlockEntity`): the block
    // entity still holds a book and the guest is within the interaction
    // range and its buffer.
    // rust: pub(super) fn lan_lectern_valid(
    // rust: &self,
    // rust: g: &horizon_client::lan::guest::Guest,
    // rust: key: (i32, i32, i32),
    // rust: ) -> bool {
    // rust: matches!(
    // rust: self.world.block_entities.get(&key),
    // rust: Some(BlockEntity::Lectern(l)) if l.book.is_some()
    // rust: ) && g.within_block_range([key.0, key.1, key.2], 4.0)
}

    // The guests' lecterns each tick: `stillValid` (the block entity, its
    // book, the reach) closes them, and `broadcastChanges` sends a book or
    // page another player changed.
lan_lecterns_tick :: proc(self: ^Self, host: ^LanHost) {
}
    // rust: let open: Vec<(u32, i32, (i32, i32, i32))> = host
    // rust: .play
    // rust: .iter()
    // rust: .filter_map(|(c, p)| p.lectern.as_ref().map(|l| (*c, l.window, l.key)))
    // rust: .collect();
    // rust: for (conn, window, key) in open {
    // rust: let Some(g) = host.hub.guests.iter().find(|g| g.conn == conn) else {
    // rust: continue;
}
    // rust: if !host.hub.here(g) {
    // rust: continue;
}
    // rust: if self.lan_lectern_valid(g, key) {
    // rust: self.lan_send_lectern(host, conn, false);
    // rust: } else {
    // rust: self.lan_station_closed(host, conn, Some(window));
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::ContainerClose(play::ContainerClose { container: window }),
    // rust: );
}
}
}
}

// What `clearContainer` gives back from a station's menu.
    // rust: pub(super) fn station_inputs(gs: &GuestStation) -> Vec<ItemStack> {
    // rust: menu_of(gs.kind)
    // rust: .map(|(_, _, inputs)| inputs.filter_map(|s| gs.menu.slot(s).cloned()).collect())
    // rust: .unwrap_or_default()
}
