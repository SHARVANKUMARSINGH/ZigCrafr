//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_menus
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Server menus for native mods (docs/native-mods.md, "Server menus", API
//! 10): a vanilla chest menu (`generic_9x1` to `generic_9x6`) a mod opens
//! for a player and fills with items to look at. No click moves anything:
//! each reaches the mod (`native_menu_clicked`), as does the menu's closing
//! (`native_menu_closed`), and the client shows the menu as the server sends
//! it again. A stock client shows it; nothing on the player's side.
//! `native_exchange_items` swaps two players' stacks in one step, checked
//! first, so a trade built on these menus never moves an item before both
//! sides are settled.
// use super::{Game, lan::LanHost};
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: lan::{data::component_nbt, menu::NativeMenuEvent},
    // rust: text::Text,
}

/// The inventory slot (0..9 the hotbar, 9..36 the rest) a click on `slot`
/// of a native menu of `size` slots landed on, when it is the player's
/// inventory below the menu (`ChestMenu`: the menu's slots, then the
/// inventory's 27, then the hotbar's 9).
    // rust: pub(crate) fn native_menu_inventory_slot(size: usize, slot: i32) -> Option<usize> {
    // rust: let n = usize::try_from(slot).ok()?.checked_sub(size)?;
    // rust: match n {
    // rust: 0..27 => Some(n + 9),
    // rust: 27..36 => Some(n - 27),
    // rust: _ => None,
}
}

/// Adds every stack of `gets` to the 36 slots of `inventory`, onto matching
/// stacks first, then into empty slots, hotbar first; false when one doesn't
/// fit whole. `max` is an item's stack size.
    // rust: pub(super) fn fit(
    // rust: inventory: &mut [Option<ItemStack>],
    // rust: gets: &[ItemStack],
    // rust: max: &impl Fn(&ItemStack) -> u32,
    // rust: ) -> bool {
    // rust: for stack in gets {
    // rust: let mut left = stack.count;
    // rust: let max = max(stack).max(1);
    // rust: for slot in inventory.iter_mut().take(36).flatten() {
    // rust: if left > 0 && slot.same_item_same_components(stack) && slot.count < max {
    // rust: let n = (max - slot.count).min(left);
    // rust: slot.count += n;
    // rust: left -= n;
}
}
    // rust: for slot in inventory.iter_mut().take(36) {
    // rust: if left > 0 && slot.is_none() {
    // rust: let n = max.min(left);
    // rust: *slot = Some(ItemStack {
    // rust: count: n,
    // rust: ..stack.clone()
    // rust: });
    // rust: left -= n;
}
}
    // rust: if left > 0 {
    // rust: return false;
}
}
    // rust: true
}

/// Two players' offers swapped, or nothing changed: each offer is the
/// inventory slots it takes with the stack each must still hold, exactly.
/// The stacks leave their slots, then go to the other side where they fit
/// whole; an Err (which side, why) leaves both inventories as they were.
    // rust: fn exchange(
    // rust: a: &mut Vec<Option<ItemStack>>,
    // rust: a_offer: &[(usize, ItemStack)],
    // rust: b: &mut Vec<Option<ItemStack>>,
    // rust: b_offer: &[(usize, ItemStack)],
    // rust: max: impl Fn(&ItemStack) -> u32,
    // rust: ) -> Result<(), String> {
    // rust: fn take(
    // rust: inv: &[Option<ItemStack>],
    // rust: offer: &[(usize, ItemStack)],
    // rust: who: &str,
    // rust: ) -> Result<(Vec<Option<ItemStack>>, Vec<ItemStack>), String> {
    // rust: let mut left = inv.to_vec();
    // rust: let mut taken = Vec::new();
    // rust: for (slot, expected) in offer {
    // rust: match left.get_mut(*slot).filter(|_| *slot < 36) {
    // rust: Some(s) if s.as_ref() == Some(expected) => taken.push(s.take().expect("checked")),
    // rust: _ => return Err(format!("{who} no longer holds their offer")),
}
}
    // rust: Ok((left, taken))
}
    // rust: let (mut a_after, a_gives) = take(a, a_offer, "the first player")?;
    // rust: let (mut b_after, b_gives) = take(b, b_offer, "the second player")?;
    // rust: if !fit(&mut a_after, &b_gives, &max) {
    // rust: return Err("the first player has no room".into());
}
    // rust: if !fit(&mut b_after, &a_gives, &max) {
    // rust: return Err("the second player has no room".into());
}
    // rust: *a = a_after;
    // rust: *b = b_after;
    // rust: Ok(())
}

/// Server menus, for server mods (API 10). The players are named by UUID;
/// none of these runs while a player's state is swapped in (inside
/// `native_perform_command`, the menus can be opened and filled, but
/// `native_player_stacks` and `native_exchange_items` refuse: call them from
/// `native_menu_clicked` or `native_server_tick`).
    // rust: impl Game<'_> {
pub fn native_conn(self: *Self, uuid: u128) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let host = self.lan.as_ref()?;
    // rust: let g = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.placed && g.uuid == uuid)?;
    // rust: Some(g.conn)
}
    /// Opens a chest menu of `rows` rows (1 to 6) titled `title` for the
    /// player, showing `items` (by slot, padded with empty ones), in place of
    /// the menu they had open: its window id.
    // rust: pub(super) fn native_open_menu(
    // rust: &mut self,
    // rust: uuid: u128,
    // rust: rows: u8,
    // rust: title: Text,
    // rust: items: Vec<Option<ItemStack>>,
    // rust: ) -> Option<i32> {
    // rust: let conn = self.native_conn(uuid)?;
    // rust: let mut host = self.lan.take()?;
        // ServerPlayer.openMenu closes the menu that was open.
    // rust: self.guest_close_all(&mut host, conn);
    // rust: let window =
    // rust: host.hub
    // rust: .open_native_menu(conn, rows, component_nbt(&title.component()), items);
    // rust: self.lan = Some(host);
    // rust: window
}
    /// Replaces what the player's open native menu shows; sent with the
    /// tick's container sync.
    // rust: pub(super) fn native_set_menu_items(&mut self, uuid: u128, items: Vec<Option<ItemStack>>) {
    // rust: if let Some(conn) = self.native_conn(uuid)
    // rust: && let Some(host) = self.lan.as_mut()
    // rust: {
    // rust: host.hub.set_native_menu(conn, items);
}
}
    /// Closes the player's native menu (a `native_menu_closed` follows).
    // rust: pub(super) fn native_close_menu(&mut self, uuid: u128) {
    // rust: if let Some(conn) = self.native_conn(uuid)
    // rust: && let Some(host) = self.lan.as_mut()
    // rust: && host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .and_then(|g| g.menu.as_ref())
    // rust: .is_some_and(|m| m.slots == horizon_client::lan::menu::Slots::Native)
    // rust: {
    // rust: host.hub.close_container(conn);
}
}
    /// The player's 36 inventory slots (0..9 the hotbar), to show or offer
    /// them; None for a player not here, dead, or whose state is swapped in.
    // rust: pub(super) fn native_player_stacks(&self, uuid: u128) -> Option<Vec<Option<ItemStack>>> {
    // rust: let host = self.lan.as_ref()?;
    // rust: let g = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.placed && g.uuid == uuid)?;
    // rust: (!g.dead && self.lan_acting != Some(g.conn)).then(|| {
    // rust: let mut stacks = g.inventory.clone();
    // rust: stacks.resize(36, None);
    // rust: stacks
    // rust: })
}
    /// Swaps two players' offers (inventory slots, each with the stack it
    /// must still hold, exactly) in one step: the stacks leave their slots
    /// and go to the other player where they fit whole, or nothing moves and
    /// the Err says why. Both must be here and alive, neither with their
    /// state swapped in. Their screens follow with the tick's sync.
    // rust: pub(super) fn native_exchange_items(
    // rust: &mut self,
    // rust: a: u128,
    // rust: a_offer: &[(usize, ItemStack)],
    // rust: b: u128,
    // rust: b_offer: &[(usize, ItemStack)],
    // rust: ) -> Result<(), String> {
    // rust: if a == b {
    // rust: return Err("a player can't trade with themselves".into());
}
    // rust: let acting = self.lan_acting;
    // rust: let items = self.res.items();
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return Err("no server".into());
}
    // rust: let find = |uuid: u128| {
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .position(|g| g.placed && !g.dead && g.uuid == uuid)
    // rust: .filter(|&i| acting != Some(host.hub.guests[i].conn))
}
    // rust: let (Some(ia), Some(ib)) = (find(a), find(b)) else {
    // rust: return Err("both players must be here".into());
}
    // rust: let mut inv_a = std::mem::take(&mut host.hub.guests[ia].inventory);
    // rust: let mut inv_b = std::mem::take(&mut host.hub.guests[ib].inventory);
    // rust: let result = exchange(&mut inv_a, a_offer, &mut inv_b, b_offer, |s| {
    // rust: items.get(&s.item).map_or(64, |i| i.max_stack)
    // rust: });
    // rust: host.hub.guests[ia].inventory = inv_a;
    // rust: host.hub.guests[ib].inventory = inv_b;
    // rust: result
}
}

/// A menu a player has open, as the mods last heard it
/// (`native_player_container_open`).
    // rust: pub(super) struct HeardMenu {
    /// The window id the player's client knows it by.
    // rust: window: i32,
    /// The menu type's name; a mount's inventory has none in vanilla.
    // rust: menu: String,
    /// The block the menu is of.
    // rust: pos: Option<[i32; 3]>,
}

/// What a mount's inventory is called, as vanilla's `HorseInventoryMenu` has
/// no menu type.
pub const MOUNT_MENU: []const u8 = "horizon:mount_inventory";

/// The menu `conn` has open, whichever way the game keeps it: a block's
/// container, a trade, a crafting table, a workstation, a lectern or a
/// mount's inventory. Not the player's own inventory menu.
pub fn open_menu_of(host: *LanHost, conn: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let g = host.hub.guest(conn)?;
    // rust: let play = host.play.get(&conn);
    // rust: if let Some(m) = &g.menu {
    // rust: let menu = host.hub.registry_name("minecraft:menu", m.kind)?;
        // A vehicle's menu is keyed by a stand-in, not a block.
    // rust: let pos = m
    // rust: .pos
    // rust: .filter(|p| p.1 != horizon_client::lan::menu::VEHICLE_KEY_Y)
    // rust: .map(|p| [p.0, p.1, p.2]);
    // rust: return Some((m.window, menu, pos));
}
    // rust: let play = play?;
    // rust: let (window, menu, pos) = if let Some(gm) = &play.merchant {
    // rust: (gm.window, "minecraft:merchant", None)
    // rust: } else if let Some((window, _, _, pos)) = &play.crafting.table {
    // rust: (*window, "minecraft:crafting", Some(*pos))
    // rust: } else if let Some(st) = &play.station {
    // rust: (
    // rust: st.window,
    // rust: super::lan_stations::menu_of(st.kind)?.0,
    // rust: Some(st.pos),
    // rust: )
    // rust: } else if let Some(l) = &play.lectern {
    // rust: (
    // rust: l.window,
    // rust: "minecraft:lectern",
    // rust: Some([l.key.0, l.key.1, l.key.2]),
    // rust: )
    // rust: } else if let Some(m) = &play.mount_window {
    // rust: (m.window, MOUNT_MENU, None)
    // rust: } else {
    // rust: return None;
}
    // rust: Some((window, menu, pos))
}

/// Where the game calls the menu hook points.
    // rust: impl Game<'_> {
    /// The mods hear the menus the players here opened or closed since the
    /// last tick (`PlayerContainerEvent`), in that order for a menu another
    /// replaced: what each player has open is compared with what the mods last
    /// heard. A menu opened and closed again inside one tick is not heard.
    // rust: pub(super) fn tick_player_menus(&mut self, host: &mut LanHost) {
    // rust: let conns: Vec<u32> = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| host.hub.here(g))
    // rust: .map(|g| g.conn)
    // rust: .collect();
    // rust: for conn in conns {
            // `AbstractContainerScreen.tick` closes the container once the player is no longer
            // alive, so a death closes the menu now (the lid falls, the mods hear Close), not at
            // the respawn.
    // rust: let dead = host.hub.guest(conn).is_some_and(|g| g.dead);
    // rust: if dead && host.hub.guest(conn).is_some_and(|g| g.menu.is_some()) {
    // rust: self.guest_container_closed(host, conn);
    // rust: host.hub.close_container(conn);
}
            // Compared as borrowed: nothing is built each tick while it stays open.
    // rust: let now = if dead { None } else { open_menu_of(host, conn) };
    // rust: let heard = host.play.get(&conn).and_then(|p| p.menu_heard.as_ref());
    // rust: if now == heard.map(|h| (h.window, h.menu.as_str(), h.pos)) {
    // rust: continue;
}
    // rust: let now = now.map(|(window, menu, pos)| HeardMenu {
    // rust: window,
    // rust: menu: menu.to_owned(),
    // rust: pos,
    // rust: });
    // rust: let heard = host.play.get(&conn).and_then(|p| p.menu_heard.clone());
            // Remembered first: a hook can run commands that close menus.
    // rust: if let Some(p) = host.play.get_mut(&conn) {
    // rust: p.menu_heard.clone_from(&now);
}
    // rust: if let Some(old) = heard {
    // rust: self.player_menu_closed(host, conn, old);
}
    // rust: if let Some(new) = now {
    // rust: self.player_menu_opened(host, conn, new);
}
}
}

    /// `conn`'s menu closes with the guest in the level in place
    /// (`ServerPlayer.doCloseContainer`): the mods hear it, if they heard it
    /// open.
    // rust: pub(super) fn player_menu_closing(&mut self, host: &mut LanHost, conn: u32) {
    // rust: let heard = host.play.get_mut(&conn).and_then(|p| p.menu_heard.take());
    // rust: if let Some(old) = heard {
    // rust: self.player_menu_closed(host, conn, old);
}
}

pub fn player_menu_opened(self: *Self, host: *mut LanHost, conn: u32, menu: HeardMenu) void {
}
    // rust: let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) else {
    // rust: return;
}
    // rust: let dimension = self.dim.id();
    // rust: self.player_hook(host, conn, move |g| {
    // rust: g.native_player_container_open(uuid, &name, dimension, &menu.menu, menu.pos);
    // rust: });
}

pub fn player_menu_closed(self: *Self, host: *mut LanHost, conn: u32, menu: HeardMenu) void {
}
    // rust: let Some((uuid, name)) = host.hub.guest(conn).map(|g| (g.uuid, g.name.clone())) else {
    // rust: return;
}
    // rust: let dimension = self.dim.id();
    // rust: self.player_hook(host, conn, move |g| {
    // rust: g.native_player_container_close(uuid, &name, dimension, &menu.menu, menu.pos);
    // rust: });
}

    /// Runs a player hook with the guest's state in place, or as it is when
    /// the guest has no body to swap in.
pub fn player_hook(self: *Self, host: *mut LanHost, conn: u32, f: impl FnOnce(*mut Self) void {
}
    // rust: let mut f = Some(f);
    // rust: if self.lan_acting != Some(conn) {
    // rust: self.as_guest(host, conn, |g| {
    // rust: if let Some(f) = f.take() {
    // rust: f(g);
}
    // rust: });
}
    // rust: if let Some(f) = f {
    // rust: f(self);
}
}

    /// The clicks on and closings of native menus the hub collected, each
    /// told to the mods with the hub back in `self.lan`, no player's state
    /// swapped in.
    // rust: pub(super) fn run_native_menu_events(&mut self) {
    // rust: loop {
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: if host.hub.native_menu_events.is_empty() {
    // rust: return;
}
    // rust: match host.hub.native_menu_events.remove(0) {
    // rust: NativeMenuEvent::Click {
    // rust: uuid,
    // rust: window,
    // rust: slot,
    // rust: button,
    // rust: mode,
    // rust: } => self.native_menu_clicked(uuid, window, slot, button, mode),
    // rust: NativeMenuEvent::Closed { uuid, window } => self.native_menu_closed(uuid, window),
}
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn stack(item: []const u8, count: u32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemStack {
    // rust: item: item.into(),
    // rust: count,
    // rust: damage: 0,
    // rust: extra: None,
}
}
pub fn inventory(stacks: *[(usize) void {
}
    // rust: let mut inv = vec![None; 36];
    // rust: for (i, s) in stacks {
    // rust: inv[*i] = Some(s.clone());
}
    // rust: inv
}
pub fn max(s: *ItemStack) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if &*s.item == "minecraft:diamond_sword" {
    // rust: 1
    // rust: } else {
    // rust: 64
}
}

pub fn menu_clicks_map_to_the_inventory_below() void {
}
        // A 6-row chest: 54 slots, then the inventory's 27, then the hotbar.
    // rust: assert_eq!(native_menu_inventory_slot(54, 3), None);
    // rust: assert_eq!(native_menu_inventory_slot(54, 54), Some(9));
    // rust: assert_eq!(native_menu_inventory_slot(54, 80), Some(35));
    // rust: assert_eq!(native_menu_inventory_slot(54, 81), Some(0));
    // rust: assert_eq!(native_menu_inventory_slot(54, 89), Some(8));
    // rust: assert_eq!(native_menu_inventory_slot(54, 90), None);
    // rust: assert_eq!(native_menu_inventory_slot(54, -999), None);
    // rust: assert_eq!(native_menu_inventory_slot(9, 9), Some(9));
}

pub fn an_exchange_swaps_both_offers() void {
}
    // rust: let mut a = inventory(&[
    // rust: (0, stack("minecraft:diamond", 5)),
    // rust: (1, stack("minecraft:dirt", 64)),
    // rust: ]);
    // rust: let mut b = inventory(&[
    // rust: (4, stack("minecraft:diamond_sword", 1)),
    // rust: (5, stack("minecraft:diamond", 60)),
    // rust: ]);
    // rust: let a_offer = [(0, stack("minecraft:diamond", 5))];
    // rust: let b_offer = [(4, stack("minecraft:diamond_sword", 1))];
    // rust: exchange(&mut a, &a_offer, &mut b, &b_offer, max).unwrap();
        // A gets the sword in the slot their diamonds left; B's diamonds
        // fill their stack to 64, the rest in the first empty slot.
    // rust: assert_eq!(a[0], Some(stack("minecraft:diamond_sword", 1)));
    // rust: assert_eq!(a[1], Some(stack("minecraft:dirt", 64)));
    // rust: assert_eq!(b[0], Some(stack("minecraft:diamond", 1)));
    // rust: assert_eq!(b[4], None);
    // rust: assert_eq!(b[5], Some(stack("minecraft:diamond", 64)));
    // rust: let count = |inv: &[Option<ItemStack>], item: &str| -> u32 {
    // rust: inv.iter()
    // rust: .flatten()
    // rust: .filter(|s| &*s.item == item)
    // rust: .map(|s| s.count)
    // rust: .sum()
}
        // Nothing made, nothing lost.
    // rust: assert_eq!(
    // rust: count(&a, "minecraft:diamond") + count(&b, "minecraft:diamond"),
    // rust: 65
    // rust: );
    // rust: assert_eq!(
    // rust: count(&a, "minecraft:diamond_sword") + count(&b, "minecraft:diamond_sword"),
    // rust: 1
    // rust: );
}

pub fn an_exchange_that_cant_complete_moves_nothing() void {
}
    // rust: let a0 = inventory(&[(0, stack("minecraft:diamond", 5))]);
    // rust: let b0 = inventory(&[(2, stack("minecraft:emerald", 3))]);
        // The offer changed since it was made (moved, dropped, used).
    // rust: let (mut a, mut b) = (a0.clone(), b0.clone());
    // rust: let stale = [(0, stack("minecraft:diamond", 6))];
    // rust: assert!(exchange(&mut a, &stale, &mut b, &[], max).is_err());
    // rust: assert_eq!((&a, &b), (&a0, &b0));
        // An empty or out-of-range slot.
    // rust: assert!(
    // rust: exchange(
    // rust: &mut a,
    // rust: &[(7, stack("minecraft:diamond", 5))],
    // rust: &mut b,
    // rust: &[],
    // rust: max
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert!(
    // rust: exchange(
    // rust: &mut a,
    // rust: &[(36, stack("minecraft:diamond", 5))],
    // rust: &mut b,
    // rust: &[],
    // rust: max
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: assert_eq!((&a, &b), (&a0, &b0));
        // No room: B's inventory is full of other things.
    // rust: let full: Vec<_> = (0..36).map(|_| Some(stack("minecraft:dirt", 64))).collect();
    // rust: let mut b = full.clone();
    // rust: let offer = [(0, stack("minecraft:diamond", 5))];
    // rust: assert!(exchange(&mut a, &offer, &mut b, &[], max).is_err());
    // rust: assert_eq!((&a, &b), (&a0, &full));
        // The same slot offered twice is the second time empty.
    // rust: let twice = [
    // rust: (0, stack("minecraft:diamond", 5)),
    // rust: (0, stack("minecraft:diamond", 5)),
    // rust: ];
    // rust: let mut b = b0.clone();
    // rust: assert!(exchange(&mut a, &twice, &mut b, &[], max).is_err());
    // rust: assert_eq!((&a, &b), (&a0, &b0));
}
}
