//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lan_mount_menu
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The horse inventory for a server's players (`ServerPlayer.openHorseInventory`):
//! shift + use on a tamed horse, donkey, mule, camel, llama or nautilus, or the
//! inventory key while riding one (`ServerboundPlayerCommandPacket`
//! OPEN_INVENTORY), opens `HorseInventoryMenu` over the mount with
//! `ClientboundMountScreenOpenPacket`. Clicks run on the menu engine
//! (`Kind::Mount`) with the mount's saddle, body item and chest copied in and
//! written back, and the slots go to the client after each change, as
//! `broadcastChanges` does.
// use super::{Game, lan::LanHost, lan_crafting::input};
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: menu::{Kind, Menu},
}
// use horizon_protocol::packets::play::{self, Clientbound as C};

/// A guest's open mount menu.
    // rust: pub(super) struct GuestMount {
    // rust: pub(super) window: i32,
    // rust: pub(super) mob: u32,
    // rust: columns: usize,
    // rust: state: i32,
    /// The menu's slots and the carried stack the client was last sent.
    // rust: sent: Option<(Vec<Option<ItemStack>>, Option<ItemStack>)>,
}

    // rust: impl Game<'_> {
    /// `ServerPlayer.openHorseInventory` for mount `mob`: the open menu
    /// closes, the client gets the mount screen and the menu's slots.
    // rust: pub(super) fn lan_open_mount(&mut self, host: &mut LanHost, conn: u32, mob: u32) {
    // rust: let Some(index) = self.mobs.iter().position(|m| m.id == mob) else {
    // rust: return;
}
    // rust: let columns = super::mount_menu::mount_columns(&self.mobs[index]);
    // rust: if !self.guest_may_open(host, conn, "minecraft:horse_inventory", None) {
    // rust: return;
}
        // ServerPlayer.openMenu closes the menu that was open.
    // rust: self.guest_close_all(host, conn);
    // rust: let Some(window) = host.hub.open_mount_window(conn, columns as i32, mob as i32) else {
    // rust: return;
}
    // rust: host.play.entry(conn).or_default().mount_window = Some(GuestMount {
    // rust: window,
    // rust: mob,
    // rust: columns,
    // rust: state: 0,
    // rust: sent: None,
    // rust: });
    // rust: self.lan_send_mount(host, conn);
}

    /// `HorseInventoryMenu` over mount `index`, with the player's inventory
    /// loaded by the caller.
pub fn mount_engine_menu(self: *Self, index: usize, columns: usize) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let env = self.menu_env();
    // rust: let mut menu = Menu::new(Kind::Mount(columns));
    // rust: menu.mount = Some(self.mobs[index].kind.id.to_string());
    // rust: let (saddle, body, items) = self.mount_contents(index);
    // rust: menu.set_slot(&env, 0, saddle);
    // rust: menu.set_slot(&env, 1, body.flatten());
    // rust: for (k, item) in items.into_iter().take(columns * 3).enumerate() {
    // rust: menu.set_slot(&env, 2 + k, item);
}
    // rust: menu
}

    /// The menu's slots (the mount's, then the inventory and the hotbar)
    /// and the carried stack, sent when they changed since the last time.
pub fn lan_send_mount(self: *Self, host: *mut LanHost, conn: u32) void {
}
    // rust: let Some(gm) = host.play.get(&conn).and_then(|p| p.mount_window.as_ref()) else {
    // rust: return;
}
    // rust: let (mob, columns) = (gm.mob, gm.columns);
    // rust: let Some(index) = self.mobs.iter().position(|m| m.id == mob) else {
    // rust: return;
}
    // rust: let Some(g) = host.hub.guests.iter().find(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let (saddle, body, items) = self.mount_contents(index);
    // rust: let mut slots = vec![saddle, body.flatten()];
    // rust: slots.extend(items.into_iter().take(columns * 3));
    // rust: slots.extend((9..36).chain(0..9).map(|i| g.inventory[i].clone()));
    // rust: let carried = g.carried.clone();
    // rust: let now = Some((slots, carried));
    // rust: let Some(gm) = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .and_then(|p| p.mount_window.as_mut())
    // rust: else {
    // rust: return;
}
    // rust: if gm.sent == now {
    // rust: return;
}
    // rust: gm.state = (gm.state + 1) & 0x7FFF;
    // rust: let (window, state) = (gm.window, gm.state);
    // rust: let (slots, carried) = now.clone().unwrap_or_default();
    // rust: gm.sent = now;
    // rust: let content = C::ContainerSetContent(play::ContainerSetContent {
    // rust: container: window,
    // rust: state,
    // rust: items: slots.iter().map(|s| host.hub.stack(s)).collect(),
    // rust: carried: host.hub.stack(&carried),
    // rust: });
    // rust: host.hub.send_to(conn, &content);
}

    /// A click on the guest's mount window; false for other windows.
    // rust: pub(super) fn lan_mount_click(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: ) -> bool {
    // rust: let Some((mob, columns)) = host
    // rust: .play
    // rust: .get(&conn)
    // rust: .and_then(|pl| pl.mount_window.as_ref())
    // rust: .filter(|m| m.window == p.container)
    // rust: .map(|m| (m.mob, m.columns))
    // rust: else {
    // rust: return false;
}
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn)
    // rust: && !host.hub.guests[gi].spectator()
    // rust: && let Some(index) = self.mobs.iter().position(|m| m.id == mob)
    // rust: {
    // rust: let mut menu = self.mount_engine_menu(index, columns);
    // rust: self.guest_menu_op(host, gi, &mut menu, |menu, env| {
    // rust: let _ = menu.click(env, i32::from(p.slot), i32::from(p.button), input(p.input));
    // rust: });
    // rust: self.lan_mount_store(index, columns, &menu);
}
        // The client is told what the server has, whatever it predicted.
    // rust: if let Some(gm) = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .and_then(|pl| pl.mount_window.as_mut())
    // rust: {
    // rust: gm.sent = None;
}
    // rust: self.lan_send_mount(host, conn);
    // rust: true
}

    /// The engine menu's mount slots back on mount `index`.
pub fn lan_store_slots(menu: *Menu, columns: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..columns * 3)
    // rust: .map(|k| menu.slot(2 + k).cloned())
    // rust: .collect()
}
pub fn lan_mount_store(self: *Self, index: usize, columns: usize, menu: *Menu) void {
}
    // rust: let (_, body, _) = self.mount_contents(index);
    // rust: let body = body.map(|_| menu.slot(1).cloned());
    // rust: let items = Self::lan_store_slots(menu, columns);
    // rust: self.mount_store(index, menu.slot(0).cloned(), body, items);
}

    /// `AbstractContainerMenu.removed` of the guest's mount menu (`window`;
    /// None closes it whichever it is): the carried stack goes back to the
    /// inventory. False when no such window is open.
    // rust: pub(super) fn lan_mount_closed(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: Option<i32>,
    // rust: ) -> bool {
    // rust: let closed = host
    // rust: .play
    // rust: .get_mut(&conn)
    // rust: .and_then(|p| {
    // rust: p.mount_window
    // rust: .take_if(|m| window.is_none_or(|w| m.window == w))
    // rust: })
    // rust: .is_some();
    // rust: if closed
    // rust: && let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn)
    // rust: && let Some(carried) = host.hub.guests[gi].carried.take()
    // rust: {
    // rust: self.lan_place_back(host, gi, vec![carried]);
}
    // rust: closed
}

    /// `AbstractMountInventoryMenu.stillValid`: the mount is alive and within
    /// the entity interaction range (3) plus 4 of the guest's eyes.
    // rust: pub(super) fn lan_mount_valid(&self, g: &horizon_client::lan::guest::Guest, mob: u32) -> bool {
    // rust: let eye = [g.position[0], g.position[1] + g.eye_height(), g.position[2]];
    // rust: self.mobs.iter().find(|m| m.id == mob).is_some_and(|m| {
    // rust: let (w, h) = (f64::from(m.width()) / 2.0, f64::from(m.height()));
    // rust: let p = [m.position.x, m.position.y, m.position.z];
    // rust: let lo = [p[0] - w, p[1], p[2] - w];
    // rust: let hi = [p[0] + w, p[1] + h, p[2] + w];
    // rust: let d: f64 = (0..3)
    // rust: .map(|k| (eye[k] - eye[k].clamp(lo[k], hi[k])).powi(2))
    // rust: .sum();
    // rust: m.alive() && d < 7.0 * 7.0
    // rust: })
}

    /// Each tick: a mount menu whose mount died or is out of reach closes
    /// (`AbstractMountInventoryMenu.stillValid`: alive, within the entity
    /// interaction range plus 4 of the eyes), and the others follow the
    /// mount's and the inventory's slots. Only the level the player is in
    /// checks its menu (`ServerPlayer.tick`): another level ticking has
    /// none of its mobs (#5331).
    // rust: pub(super) fn tick_lan_mount_menus(&mut self, host: &mut LanHost) {
    // rust: let open: Vec<(u32, u32, i32)> = host
    // rust: .play
    // rust: .iter()
    // rust: .filter_map(|(c, p)| p.mount_window.as_ref().map(|m| (*c, m.mob, m.window)))
    // rust: .collect();
    // rust: for (conn, mob, window) in open {
    // rust: let Some(g) = host.hub.guests.iter().find(|g| g.conn == conn) else {
    // rust: continue;
}
    // rust: if !host.hub.here(g) {
    // rust: continue;
}
    // rust: if self.lan_mount_valid(g, mob) {
    // rust: self.lan_send_mount(host, conn);
    // rust: } else {
    // rust: self.lan_mount_closed(host, conn, Some(window));
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::ContainerClose(play::ContainerClose { container: window }),
    // rust: );
}
}
}
}
