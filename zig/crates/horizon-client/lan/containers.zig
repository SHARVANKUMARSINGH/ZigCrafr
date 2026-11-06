//! Transpiled from Horizon Rust crate
//! Module: horizon-client_containers
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Hub operations on what guests perceive and do beyond the basics: sounds,
//! level events, animations and block containers with their clicks.
// use super::{
    // rust: hub::Hub,
    // rust: menu::{self, Menu, NativeMenuEvent, Rules, Slots, View},
}
// use crate::{containers::BlockEntity, items::ItemStack, world::World};
// use horizon_core::random::RandomSource;
// use horizon_protocol::{
    // rust: item::Hashed,
    // rust: packets::{
    // rust: configuration::CustomPayload,
    // rust: play::{self, Clientbound as C},
    // rust: },
}
// use horizon_world::nbt::Tag;
// use std::collections::HashMap;

/// Encode a captured level sound and its broadcast radius without a live hub.
/// Entity-bound events use the entity packet; ordinary level sounds retain
/// their fixed-point coordinates. The caller supplies the synced registry id.
    // rust: pub fn captured_sound_packet(
    // rust: sound: &crate::audio::CapturedSound,
    // rust: sound_id: Option<i32>,
    // rust: seed: i64,
    // rust: ) -> (C, f64) {
    // rust: let holder = match sound_id {
    // rust: Some(id) => (id, None),
    // rust: None => (-1, Some((sound.event.clone(), None))),
}
    // rust: let packet = match sound.entity {
    // rust: Some(id) => C::SoundEntity(play::SoundEntity {
    // rust: sound: holder,
    // rust: source: sound.source as i32,
    // rust: id: id as i32,
    // rust: volume: sound.volume,
    // rust: pitch: sound.pitch,
    // rust: seed,
    // rust: }),
    // rust: None => C::Sound(play::Sound {
    // rust: sound: holder,
    // rust: source: sound.source as i32,
    // rust: x: (sound.position[0] * 8.0) as i32,
    // rust: y: (sound.position[1] * 8.0) as i32,
    // rust: z: (sound.position[2] * 8.0) as i32,
    // rust: volume: sound.volume,
    // rust: pitch: sound.pitch,
    // rust: seed,
    // rust: }),
}
    // rust: (packet, captured_sound_range(sound))
}

    // rust: pub(super) fn captured_sound_range(sound: &crate::audio::CapturedSound) -> f64 {
    // SoundEvent.getRange multiplies as floats before the broadcast widens it.
    // rust: f64::from(if sound.volume > 1.0 {
    // rust: 16.0 * sound.volume
    // rust: } else {
    // rust: 16.0
    // rust: })
}

    // rust: impl Hub {
pub fn send_to(self: *Self, conn: u32, packet: *C) void {
}
    // rust: if let Some(g) = self.guest(conn) {
    // rust: if let C::RemoveEntities(p) = packet {
    // rust: self.send_ordered_removal(g, &p.ids);
    // rust: } else {
    // rust: g.send(packet);
}
}
}

    /// `ChunkMap.sendToTrackingPlayers`: send to every placed guest that
    /// tracks the entity `id`.
pub fn send_to_tracking(self: *Self, id: i32, packet: *C) void {
}
    // rust: let body = packet.encode();
    // rust: for g in self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| self.here(g) && g.tracker.is_tracking(id))
    // rust: {
    // rust: g.sender.send(body.clone());
}
}

    /// Send to every placed guest within `range` blocks of `at`
    /// (`PlayerList.broadcast`, which leaves out a player exactly at `range`).
pub fn broadcast_near(self: *Self, at: [f64; 3], range: f64, packet: *C, except: ?u32) void {
}
    // rust: let body = packet.encode();
    // rust: for g in self
    // rust: .guests
    // rust: .iter()
    // rust: .filter(|g| self.here(g) && Some(g.conn) != except)
    // rust: {
    // rust: if within_range(at, g.position, range) {
    // rust: g.sender.send(body.clone());
}
}
}

    /// ClientboundSoundPacket for a sound event name (an inline event when
    /// the registry does not know it).
    // rust: pub fn sound_packet(
    // rust: &self,
    // rust: name: &str,
    // rust: at: [f64; 3],
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: source: i32,
    // rust: seed: i64,
    // rust: ) -> C {
    // rust: let sound = match self.sync.id("minecraft:sound_event", name) {
    // rust: Some(id) => (id, None),
    // rust: None => (-1, Some((name.to_owned(), None))),
}
    // rust: C::Sound(play::Sound {
    // rust: sound,
    // rust: source,
    // rust: x: (at[0] * 8.0) as i32,
    // rust: y: (at[1] * 8.0) as i32,
    // rust: z: (at[2] * 8.0) as i32,
    // rust: volume,
    // rust: pitch,
    // rust: seed,
    // rust: })
}
    /// Draw the next seed from the server sound source.
pub fn next_sound_seed(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: next_sound_seed(&mut *self.sound_seeds.lock().unwrap())
}

    /// The entity overload of `ServerLevel.playSeededSound`. The emitter stays
    /// an entity id on the wire; clients which do not know it drop the sound.
pub fn captured_sound(self: *Self, sound: *crate::audio::CapturedSound, except: ?u32) void {
}
    // rust: let except = except.or_else(|| {
    // rust: sound.except_entity.and_then(|id| {
    // rust: self.guests
    // rust: .iter()
    // rust: .find(|g| g.entity_id as u32 == id)
    // rust: .map(|g| g.conn)
    // rust: })
    // rust: });
    // rust: let seed = self.next_sound_seed();
    // rust: let (packet, range) = captured_sound_packet(
    // rust: sound,
    // rust: self.sync.id("minecraft:sound_event", &sound.event),
    // rust: seed,
    // rust: );
    // rust: self.broadcast_near(sound.position, range, &packet, except);
}

    // rust: pub fn sound(
    // rust: &self,
    // rust: name: &str,
    // rust: at: [f64; 3],
    // rust: volume: f32,
    // rust: pitch: f32,
    // rust: source: i32,
    // rust: except: Option<u32>,
    // rust: ) {
        // Level.playSound: soundSeedGenerator.nextLong per call, not the tick.
    // rust: let seed = self.next_sound_seed();
    // rust: let packet = self.sound_packet(name, at, volume, pitch, source, seed);
    // rust: self.broadcast_near(at, f64::from(volume.max(1.0)) * 16.0, &packet, except);
}

    /// ClientboundLevelEventPacket (block break particles and sounds ...).
pub fn level_event(self: *Self, kind: i32, pos: [i32; 3], data: i32, except: ?u32) void {
}
    // rust: let at = [f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])];
    // rust: self.broadcast_near(
    // rust: at,
    // rust: 64.0,
    // rust: &C::LevelEvent(play::LevelEvent {
    // rust: kind,
    // rust: pos,
    // rust: data,
    // rust: global: false,
    // rust: }),
    // rust: except,
    // rust: );
}

    /// `ServerLevel.globalLevelEvent`: the packet with its global flag, for
    /// every player on the server (`PlayerList.broadcastAll`).
pub fn global_level_event(self: *Self, kind: i32, pos: [i32; 3], data: i32) void {
}
    // rust: self.broadcast(&C::LevelEvent(play::LevelEvent {
    // rust: kind,
    // rust: pos,
    // rust: data,
    // rust: global: true,
    // rust: }));
}

    /// ClientboundBlockEventPacket (`PlayerList.broadcast` within 64 blocks).
pub fn block_event(self: *Self, pos: [i32; 3], b0: i32, b1: i32, state: u32) void {
}
    // rust: let block = self
    // rust: .encoder
    // rust: .block_ids
    // rust: .get(state as usize)
    // rust: .copied()
    // rust: .unwrap_or(0);
    // rust: let at = [f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])];
    // rust: self.broadcast_near(
    // rust: at,
    // rust: 64.0,
    // rust: &C::BlockEvent(play::BlockEvent {
    // rust: pos,
    // rust: b0: b0 as u8,
    // rust: b1: b1 as u8,
    // rust: block,
    // rust: }),
    // rust: None,
    // rust: );
}

pub fn entity_event(self: *Self, id: i32, event: i8, at: [f64; 3]) void {
}
    // rust: self.broadcast_near(
    // rust: at,
    // rust: 128.0,
    // rust: &C::EntityEvent(play::EntityEvent { id, event }),
    // rust: None,
    // rust: );
}

    /// `ServerPlayer.crit` (`magicCrit` when `magic`): send the victim's
    /// animation to the players tracking the attacker and the attacker
    /// themselves (`sendToTrackingPlayersAndSelf`).
pub fn critical_hit(self: *Self, attacker: i32, target: i32, magic: bool) void {
}
    // rust: let body = C::Animate(play::Animate {
    // rust: id: target,
    // rust: action: if magic { 2 } else { 1 },
    // rust: })
    // rust: .encode();
    // rust: for g in self.guests.iter().filter(|g| {
    // rust: self.here(g) && (g.entity_id == attacker || g.tracker.is_tracking(attacker))
    // rust: }) {
    // rust: g.sender.send(body.clone());
}
}

    /// `ServerLevel.broadcastDamageEvent`: the clients around show the hurt
    /// entity's flash and hear its hurt sound.
    // rust: pub fn damage_event(
    // rust: &self,
    // rust: id: i32,
    // rust: kind: &str,
    // rust: cause: Option<i32>,
    // rust: direct: Option<i32>,
    // rust: at: [f64; 3],
    // rust: ) {
    // rust: let Some(source_type) = self.sync.id("minecraft:damage_type", kind) else {
    // rust: return;
}
    // rust: self.broadcast_near(
    // rust: at,
    // rust: 128.0,
    // rust: &C::DamageEvent(play::DamageEvent {
    // rust: id,
    // rust: source_type,
    // rust: cause,
    // rust: direct,
    // rust: position: None,
    // rust: }),
    // rust: None,
    // rust: );
}

pub fn swing(self: *Self, id: i32, hand: i32, at: [f64; 3], except: ?u32) void {
}
    // rust: self.broadcast_near(
    // rust: at,
    // rust: 128.0,
    // rust: &C::SwingAnimation(play::SwingAnimation {
    // rust: id,
    // rust: hand,
    // rust: kind: 1,
    // rust: duration: 6,
    // rust: }),
    // rust: except,
    // rust: );
}

pub fn take_item(self: *Self, item: i32, collector: i32, count: i32, at: [f64; 3]) void {
}
    // rust: self.broadcast_near(
    // rust: at,
    // rust: 64.0,
    // rust: &C::TakeItemEntity(play::TakeItemEntity {
    // rust: item,
    // rust: player: collector,
    // rust: amount: count,
    // rust: }),
    // rust: None,
    // rust: );
}

    /// Open a block container for a guest (ServerPlayer.openMenu). `extra`,
    /// for a mod menu type, goes first in a `horizon:menu_extra` payload with
    /// the window and `pos` (`openMenu` with an extra-data writer).
    // rust: pub fn open_container(
    // rust: &mut self,
    // rust: conn: u32,
    // rust: menu_kind: &str,
    // rust: title: Tag,
    // rust: pos: (i32, i32, i32),
    // rust: slots: Slots,
    // rust: items: Vec<Option<ItemStack>>,
    // rust: extra: Option<Vec<u8>>,
    // rust: ) {
    // rust: let Some(kind) = self
    // rust: .sync
    // rust: .builtin
    // rust: .get("minecraft:menu")
    // rust: .and_then(|m| m.id(menu_kind))
    // rust: else {
    // rust: return;
}
    // rust: let Some(i) = self.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: self.close_container_at(i);
    // rust: let g = &mut self.guests[i];
    // rust: g.next_window = g.next_window % 100 + 1;
    // rust: let window = g.next_window;
    // rust: if let Some(data) = extra {
    // rust: let message = horizon_protocol::menu_extra::Message {
    // rust: window,
    // rust: pos: [pos.0, pos.1, pos.2],
    // rust: data,
}
    // rust: match horizon_protocol::menu_extra::encode(&message) {
    // rust: Ok(data) => g.send(&C::CustomPayload(CustomPayload {
    // rust: channel: horizon_protocol::menu_extra::CHANNEL.into(),
    // rust: data,
    // rust: })),
    // rust: Err(e) => log::warn!("Horizon: {menu_kind}'s extra data not sent: {e}"),
}
}
    // rust: g.send(&C::OpenScreen(play::OpenScreen {
    // rust: container: window,
    // rust: menu: kind,
    // rust: title,
    // rust: }));
    // rust: let mod_type = crate::containers::mod_menu_type(menu_kind);
    // rust: g.menu = Some(Menu {
    // rust: window,
    // rust: kind,
    // rust: pos: Some(pos),
    // rust: slots,
    // rust: size: items.len(),
    // rust: state: 0,
    // rust: sent: Vec::new(),
    // rust: drag: None,
    // rust: sent_data: Vec::new(),
    // rust: hidden: Vec::new(),
    // rust: mod_type,
    // rust: });
    // rust: self.send_menu_content(i, items);
}

    /// The open menu of `conn` has no `hidden` container slots: a mod's screen
    /// does not show them, so a click or a shift-click never reaches them.
pub fn hide_menu_slots(self: *Self, conn: u32, hidden: std.ArrayList(usize)) void {
}
    // rust: if let Some(m) = self
    // rust: .guests
    // rust: .iter_mut()
    // rust: .find(|g| g.conn == conn)
    // rust: .and_then(|g| g.menu.as_mut())
    // rust: {
    // rust: m.hidden = hidden;
}
}

    /// Opens a native mod's menu of `rows` rows (1 to 6, a chest's
    /// `generic_9xN`) showing `items` (padded to the rows' slots), over the
    /// guest's inventory: no click moves anything, each is a
    /// [`NativeMenuEvent`]. The window's id, or None for an unknown guest.
    // rust: pub fn open_native_menu(
    // rust: &mut self,
    // rust: conn: u32,
    // rust: rows: u8,
    // rust: title: Tag,
    // rust: mut items: Vec<Option<ItemStack>>,
    // rust: ) -> Option<i32> {
    // rust: let rows = rows.clamp(1, 6);
    // rust: let kind = self
    // rust: .sync
    // rust: .builtin
    // rust: .get("minecraft:menu")
    // rust: .and_then(|m| m.id(&format!("minecraft:generic_9x{rows}")))?;
    // rust: let i = self.guests.iter().position(|g| g.conn == conn)?;
    // rust: self.close_container_at(i);
    // rust: let size = usize::from(rows) * 9;
    // rust: items.resize(size, None);
    // rust: let g = &mut self.guests[i];
    // rust: g.native_menu = items.clone();
    // rust: g.next_window = g.next_window % 100 + 1;
    // rust: let window = g.next_window;
    // rust: g.send(&C::OpenScreen(play::OpenScreen {
    // rust: container: window,
    // rust: menu: kind,
    // rust: title,
    // rust: }));
    // rust: g.menu = Some(Menu {
    // rust: window,
    // rust: kind,
    // rust: pos: None,
    // rust: slots: Slots::Native,
    // rust: size,
    // rust: state: 0,
    // rust: sent: Vec::new(),
    // rust: drag: None,
    // rust: sent_data: Vec::new(),
    // rust: hidden: Vec::new(),
    // rust: mod_type: None,
    // rust: });
    // rust: self.send_menu_content(i, items);
    // rust: Some(window)
}

    /// Replaces what a guest's open native menu shows; the changed slots go
    /// out with the tick's container sync.
pub fn set_native_menu(self: *Self, conn: u32, mut items: std.ArrayList(?ItemStack)) void {
}
    // rust: if let Some(g) = self.guest_mut(conn)
    // rust: && let Some(m) = g.menu.as_ref().filter(|m| m.slots == Slots::Native)
    // rust: {
    // rust: items.resize(m.size, None);
    // rust: g.native_menu = items;
}
}

    /// Open a trading window for a guest (`Merchant.openTradingScreen`):
    /// its id, or None when the menu type is unknown.
pub fn open_merchant_window(self: *Self, conn: u32, title: Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.open_window(conn, "minecraft:merchant", title)
}

    /// ServerPlayer.openMenu for a menu the game runs (merchant, crafting
    /// table): the open container closes, a new window id opens this menu.
pub fn open_window(self: *Self, conn: u32, menu: []const u8, title: Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = self
    // rust: .sync
    // rust: .builtin
    // rust: .get("minecraft:menu")
    // rust: .and_then(|m| m.id(menu))?;
    // rust: let i = self.guests.iter().position(|g| g.conn == conn)?;
    // rust: self.close_container_at(i);
    // rust: let g = &mut self.guests[i];
    // rust: g.next_window = g.next_window % 100 + 1;
    // rust: let window = g.next_window;
    // rust: g.send(&C::OpenScreen(play::OpenScreen {
    // rust: container: window,
    // rust: menu: kind,
    // rust: title,
    // rust: }));
    // rust: Some(window)
}

    /// ServerPlayer.openHorseInventory: the open container closes, a new
    /// window id opens mount `entity`'s inventory with its chest's columns
    /// (ClientboundMountScreenOpenPacket).
pub fn open_mount_window(self: *Self, conn: u32, columns: i32, entity: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = self.guests.iter().position(|g| g.conn == conn)?;
    // rust: self.close_container_at(i);
    // rust: let g = &mut self.guests[i];
    // rust: g.next_window = g.next_window % 100 + 1;
    // rust: let window = g.next_window;
    // rust: g.send(&C::MountScreenOpen(play::MountScreenOpen {
    // rust: container: window,
    // rust: columns,
    // rust: entity,
    // rust: }));
    // rust: Some(window)
}

pub fn send_menu_content(self: *Self, i: usize, mut items: std.ArrayList(?ItemStack)) void {
}
    // rust: for j in 0..36 {
    // rust: items.push(self.guests[i].inventory[player_slot(j)].clone());
}
    // rust: let net: Vec<_> = items.iter().map(|s| self.stack(s)).collect();
    // rust: let carried = self.guests[i].carried.clone();
    // rust: let carried = self.stack(&carried);
    // rust: let g = &mut self.guests[i];
    // rust: let Some(menu) = g.menu.as_mut() else {
    // rust: return;
}
    // rust: menu.state = (menu.state + 1) & 0x7FFF;
    // rust: let packet = C::ContainerSetContent(play::ContainerSetContent {
    // rust: container: menu.window,
    // rust: state: menu.state,
    // rust: items: net,
    // rust: carried,
    // rust: });
    // rust: menu.sent = items;
    // rust: g.send(&packet);
    // rust: g.inventory_told();
}

    /// `AbstractContainerMenu.sendAllDataToRemote` for the guest's open
    /// block container `window`: every slot and the carried stack again.
pub fn resend_menu(self: *Self, conn: u32, window: i32, world: *World) void {
}
    // rust: let Some(i) = self.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let g = &self.guests[i];
    // rust: let Some(items) = g
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|m| window != 0 && m.window == window)
    // rust: .and_then(|m| m.slots.read(world, g))
    // rust: else {
    // rust: return;
}
    // rust: self.send_menu_content(i, items);
}

pub fn close_container_at(self: *Self, i: usize) void {
}
    // rust: let g = &mut self.guests[i];
    // rust: if let Some(menu) = g.menu.take() {
    // rust: g.send(&C::ContainerClose(play::ContainerClose {
    // rust: container: menu.window,
    // rust: }));
    // rust: if menu.slots == Slots::Native {
    // rust: g.native_menu.clear();
    // rust: let (uuid, window) = (g.uuid, menu.window);
    // rust: self.native_menu_events
    // rust: .push(NativeMenuEvent::Closed { uuid, window });
}
}
}

    // rust: pub(super) fn close_container_for(&mut self, i: usize) {
    // rust: self.close_container_at(i);
}

pub fn close_container(self: *Self, conn: u32) void {
}
    // rust: if let Some(i) = self.guests.iter().position(|g| g.conn == conn) {
    // rust: self.close_container_at(i);
}
}

    /// The client closed its window.
pub fn container_closed(self: *Self, conn: u32, window: i32) void {
}
    // rust: if let Some(g) = self.guest_mut(conn)
    // rust: && g.menu.as_ref().is_some_and(|m| m.window == window)
    // rust: {
    // rust: let native = g.menu.take().is_some_and(|m| m.slots == Slots::Native);
    // rust: if native {
    // rust: g.native_menu.clear();
    // rust: let uuid = g.uuid;
    // rust: self.native_menu_events
    // rust: .push(NativeMenuEvent::Closed { uuid, window });
}
}
}

pub fn hashed_matches(self: *Self, claimed: *?Hashed, mine: *?ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (claimed, mine) {
    // rust: (None, None) => true,
    // rust: (Some(h), Some(s)) => h.item == self.item_id(&s.item) && h.count == s.count as i32,
    // rust: _ => false,
}
}

pub fn view_slot(self: *Self, i: usize, world: *World, slot: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let g = &self.guests[i];
    // rust: match &g.menu {
    // rust: Some(m) if slot < m.size => m.slots.get(world, g, slot),
    // rust: Some(m) => g
    // rust: .inventory
    // rust: .get(player_slot(slot - m.size))
    // rust: .cloned()
    // rust: .flatten(),
    // rust: None => g.menu_slot(slot),
}
}

    /// ServerGamePacketListenerImpl.handleContainerClick. Returns the stacks
    /// thrown out of the menu.
    // rust: pub fn container_click(
    // rust: &mut self,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: world: &mut World,
    // rust: rules: &dyn Rules,
    // rust: ) -> Vec<ItemStack> {
    // rust: let Some(i) = self.guests.iter().position(|g| g.conn == conn) else {
    // rust: return Vec::new();
}
    // rust: let in_menu = p.container != 0;
    // rust: let window_ok = !in_menu
    // rust: || self.guests[i]
    // rust: .menu
    // rust: .as_ref()
    // rust: .is_some_and(|m| m.window == p.container);
    // rust: if !window_ok {
    // rust: return Vec::new();
}
    // rust: if self.guests[i].spectator() {
            // A spectator's click changes nothing, and sendAllDataToRemote
            // takes back what its client predicted.
    // rust: self.resend_menu(conn, p.container, world);
    // rust: return Vec::new();
}
        // A native mod's menu: the click is the mod's to answer, and the
        // whole menu and the cursor go back as they were.
    // rust: if in_menu && self.guests[i].menu.as_ref().map(|m| m.slots) == Some(Slots::Native) {
    // rust: self.native_menu_events.push(NativeMenuEvent::Click {
    // rust: uuid: self.guests[i].uuid,
    // rust: window: p.container,
    // rust: slot: i32::from(p.slot),
    // rust: button: i32::from(p.button),
    // rust: mode: p.input,
    // rust: });
    // rust: self.resend_menu(conn, p.container, world);
    // rust: return Vec::new();
}
        // A menu that is no longer valid takes no clicks.
    // rust: if let Some(m) = self.guests[i].menu.as_ref().filter(|_| in_menu)
    // rust: && !m.slots.still_valid(world, &self.guests[i], m.pos)
    // rust: {
    // rust: return Vec::new();
}
        // AbstractContainerMenu.isValidSlotIndex: -999 or below the menu's slot
        // count. A slot past the menu would reach the inventory beyond its 36 slots.
    // rust: let slots = match self.guests[i].menu.as_ref().filter(|_| in_menu) {
    // rust: Some(m) => m.size + 36,
    // rust: None => 46,
}
    // rust: if i32::from(p.slot) >= slots as i32 && p.slot != -999 {
    // rust: return Vec::new();
}
    // rust: let source = self.guests[i].menu.as_ref().map(|m| m.slots);
    // rust: let shulker_box = self
    // rust: .sync
    // rust: .builtin
    // rust: .get("minecraft:menu")
    // rust: .and_then(|m| m.id("minecraft:shulker_box"));
    // rust: let shulker = in_menu
    // rust: && shulker_box.is_some()
    // rust: && self.guests[i].menu.as_ref().map(|m| m.kind) == shulker_box;
    // rust: let mut drag = if in_menu {
    // rust: self.guests[i].menu.as_mut().and_then(|m| m.drag.take())
    // rust: } else {
    // rust: self.guests[i].drag.take()
}
    // rust: let hidden = self.guests[i]
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|_| in_menu)
    // rust: .map_or_else(Vec::new, |m| m.hidden.clone());
    // rust: let guest = &mut self.guests[i];
    // rust: let mut items = source.and_then(|s| s.read(world, guest));
    // rust: if in_menu && items.is_none() {
    // rust: return Vec::new();
}
    // rust: let mut view = View {
    // rust: guest,
    // rust: container: items.as_deref_mut(),
    // rust: shulker,
    // rust: hidden: &hidden,
}
    // rust: let (drops, changed) = menu::click(
    // rust: &mut view,
    // rust: &mut drag,
    // rust: i32::from(p.slot),
    // rust: i32::from(p.button),
    // rust: p.input,
    // rust: rules,
    // rust: );
    // rust: if let (Some(source), Some(items)) = (source, items) {
    // rust: source.write(world, guest, items);
}
    // rust: if in_menu {
    // rust: if let Some(m) = self.guests[i].menu.as_mut() {
    // rust: m.drag = drag;
}
    // rust: } else {
    // rust: self.guests[i].drag = drag;
}
    // rust: self.answer_click(i, p, world, &changed);
    // rust: drops
}

    /// `AbstractContainerMenu.setSelectedBundleItemIndex` on the guest's open
    /// menu: a container's own slots, or the inventory's. A bundle's selection
    /// lives on the server's stack until the click that takes from it.
pub fn select_bundle_item(self: *Self, conn: u32, slot: usize, index: i32, world: *mut World) void {
}
    // rust: let Some(g) = self.guests.iter_mut().find(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let open = g.menu.as_ref().map(|m| (m.size, m.slots));
    // rust: let mut items = match open {
    // rust: Some((size, source)) if slot < size => source.read(world, g),
    // rust: _ => None,
}
    // rust: let stack = match open {
    // rust: Some((size, _)) if slot < size => items
    // rust: .as_mut()
    // rust: .and_then(|items| items.get_mut(slot))
    // rust: .and_then(Option::as_mut),
            // setSelectedBundleItemIndex: a slot of the menu only.
    // rust: Some((size, _)) if slot - size < 36 => g
    // rust: .inventory
    // rust: .get_mut(player_slot(slot - size))
    // rust: .and_then(Option::as_mut),
    // rust: Some(_) => None,
    // rust: None => match slot {
    // rust: 9..=35 => g.inventory.get_mut(slot).and_then(Option::as_mut),
    // rust: 36..=44 => g.inventory.get_mut(slot - 36).and_then(Option::as_mut),
    // rust: 45 => g.offhand.as_mut(),
    // rust: _ => None,
    // rust: },
}
    // rust: if let Some(stack) = stack {
    // rust: crate::bundle::toggle_selected(stack, index);
}
    // rust: if let (Some((_, source)), Some(items)) = (open, items) {
    // rust: source.write(world, g, items);
}
}

    /// A click on the inventory menu (window 0) the game applied itself
    /// (the crafting grid): the client is corrected like after any click.
    // rust: pub fn inventory_clicked(
    // rust: &mut self,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: world: &World,
    // rust: changed: &[usize],
    // rust: ) {
    // rust: if let Some(i) = self.guests.iter().position(|g| g.conn == conn) {
    // rust: self.answer_click(i, p, world, changed);
}
}

    /// What the client predicted for click `p` is what the server has, for a
    /// menu of `total` slots read through `view`.
    // rust: pub fn click_agreed(
    // rust: &mut self,
    // rust: i: usize,
    // rust: p: &play::ContainerClick,
    // rust: total: usize,
    // rust: view: &dyn Fn(usize) -> Option<ItemStack>,
    // rust: changed: &[usize],
    // rust: ) -> bool {
    // rust: let carried = self.guests[i].carried.clone();
    // rust: if !self.hashed_matches(&p.carried, &carried) {
    // rust: return false;
}
    // rust: let claimed: HashMap<usize, &Option<Hashed>> =
    // rust: p.changed.iter().map(|(s, h)| (*s as usize, h)).collect();
    // rust: (0..total).all(|slot| match claimed.get(&slot) {
    // rust: Some(c) => self.hashed_matches(c, &view(slot)),
    // rust: None => !changed.contains(&slot),
    // rust: })
}

    /// After a click: tell the client about every slot it got wrong, or that
    /// it did not claim, and the carried stack.
    // rust: fn answer_click(
    // rust: &mut self,
    // rust: i: usize,
    // rust: p: &play::ContainerClick,
    // rust: world: &World,
    // rust: changed: &[usize],
    // rust: ) {
    // rust: let in_menu = p.container != 0;
        // handleContainerClick: a click made without the latest state gets the
        // whole menu (`broadcastFullState`). Answering it slot by slot can leave
        // the client with a correction of a click it has already gone past.
    // rust: let g = &self.guests[i];
    // rust: let open = g
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|_| in_menu)
    // rust: .map(|m| (m.size, m.state));
    // rust: let stale = match open {
    // rust: Some((_, state)) => p.state != state,
    // rust: None => !in_menu && p.state != g.menu_state,
}
    // rust: if stale {
    // rust: match open {
    // rust: Some((size, _)) => {
    // rust: let items = (0..size).map(|s| self.view_slot(i, world, s)).collect();
    // rust: self.send_menu_content(i, items);
}
    // rust: None => self.send_inventory(i),
}
    // rust: return;
}
    // rust: let claimed: HashMap<usize, Option<Hashed>> = p
    // rust: .changed
    // rust: .iter()
    // rust: .map(|(s, h)| (*s as usize, h.clone()))
    // rust: .collect();
    // rust: let total = if in_menu {
    // rust: self.guests[i].menu.as_ref().map_or(0, |m| m.size) + 36
    // rust: } else {
    // rust: 46
}
    // rust: let mut resend: Vec<usize> = Vec::new();
    // rust: for slot in 0..total {
    // rust: let mine = self.view_slot(i, world, slot);
    // rust: let agreed = match claimed.get(&slot) {
    // rust: Some(c) => self.hashed_matches(c, &mine),
    // rust: None => !changed.contains(&slot),
}
    // rust: if !agreed {
    // rust: resend.push(slot);
}
}
    // rust: for slot in resend {
    // rust: let mine = self.view_slot(i, world, slot);
    // rust: let net = self.stack(&mine);
    // rust: let g = &mut self.guests[i];
    // rust: let state = if in_menu {
    // rust: g.menu.as_mut().map_or(0, |m| {
    // rust: m.state = (m.state + 1) & 0x7FFF;
    // rust: m.state
    // rust: })
    // rust: } else {
    // rust: g.menu_state = (g.menu_state + 1) & 0x7FFF;
    // rust: g.menu_state
}
    // rust: g.send(&C::ContainerSetSlot(play::ContainerSetSlot {
    // rust: container: p.container,
    // rust: state,
    // rust: slot: slot as i16,
    // rust: item: net,
    // rust: }));
}
    // rust: let carried = self.guests[i].carried.clone();
    // rust: if !self.hashed_matches(&p.carried, &carried) {
    // rust: let net = self.stack(&carried);
    // rust: self.guests[i].send(&C::SetCursorItem(play::SetCursorItem { item: net }));
}
        // What the client now believes equals the server's state.
    // rust: let items: Vec<_> = (0..total).map(|s| self.view_slot(i, world, s)).collect();
    // rust: if in_menu {
            // Nor is the inventory menu's sync to send what this click settled:
            // ServerPlayer.tick broadcasts only the open menu.
    // rust: let own = open.map_or(0, |(size, _)| size);
    // rust: let settled = claimed.keys().copied().chain(changed.iter().copied());
    // rust: for slot in settled.filter(|&s| s >= own && s < own + 36) {
    // rust: self.guests[i].menu_sent[slot - own + 9] = items[slot].clone();
}
    // rust: if let Some(m) = self.guests[i].menu.as_mut() {
    // rust: m.sent = items;
}
    // rust: } else {
    // rust: self.guests[i].menu_sent = items;
}
}

    /// AbstractContainerMenu.broadcastChanges' data slots: a furnace's
    /// AbstractFurnaceBlockEntity.dataAccess (lit time left, lit total, cooking
    /// timer, cooking total), each sent when it changes.
pub fn sync_container_data(self: *Self, i: usize, world: *World) void {
}
    // rust: let g = &mut self.guests[i];
    // rust: let Some(m) = g.menu.as_mut() else {
    // rust: return;
}
    // rust: let Slots::Block(pos) = m.slots else {
    // rust: return;
}
        // AbstractFurnaceBlockEntity.dataAccess, BrewingStandBlockEntity.dataAccess,
        // CrafterBlockEntity.containerData.
    // rust: let data = match world.block_entities.get(&pos) {
    // rust: Some(BlockEntity::Furnace(f)) => vec![
    // rust: f.lit_remaining,
    // rust: f.lit_total,
    // rust: f.cooking_timer,
    // rust: f.cooking_total,
    // rust: ],
    // rust: Some(BlockEntity::Brewing(b)) => {
    // rust: vec![b.brew_time, b.fuel, b.total_brew_time, b.total_fuel]
}
            // CrafterBlockEntity.containerData: the disabled slots, then triggered.
    // rust: Some(BlockEntity::Crafter(c)) => c
    // rust: .disabled
    // rust: .iter()
    // rust: .chain([&c.triggered])
    // rust: .map(|&d| i32::from(d))
    // rust: .collect(),
            // A mod's menu: the data slots its tick set. A mod menu type's
            // `ContainerData` has as many as it declares, all sent on open
            // (`sendInitialData`), 0 where the tick set none.
    // rust: Some(BlockEntity::Mod(e)) if m.mod_type.is_some() || !e.data.is_empty() => {
    // rust: let mut data = e.data.clone();
    // rust: if let Some(t) = m.mod_type {
    // rust: data.resize(t.data_slots, 0);
}
    // rust: data
}
    // rust: _ => return,
}
    // rust: .into_iter()
    // rust: .map(|v| v as i16)
    // rust: .collect::<Vec<i16>>();
    // rust: m.sent_data.resize(data.len(), None);
    // rust: let window = m.window;
    // rust: let changed: Vec<(usize, i16)> = data
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|&(k, v)| m.sent_data[k] != Some(*v))
    // rust: .map(|(k, &v)| (k, v))
    // rust: .collect();
    // rust: for &(k, value) in &changed {
    // rust: m.sent_data[k] = Some(value);
}
    // rust: for (k, value) in changed {
    // rust: g.send(&C::ContainerSetData(play::ContainerSetData {
    // rust: container: window,
    // rust: id: k as i16,
    // rust: value,
    // rust: }));
}
}

    /// Slot changes of open containers (AbstractContainerMenu.broadcastChanges).
pub fn sync_containers(self: *Self, world: *World) void {
}
    // rust: for i in 0..self.guests.len() {
    // rust: let Some(menu) = self.guests[i]
    // rust: .menu
    // rust: .as_ref()
    // rust: .filter(|_| self.here(&self.guests[i]))
    // rust: else {
    // rust: continue;
}
    // rust: let (size, window, slots) = (menu.size, menu.window, menu.slots);
    // rust: if !slots.valid(world) {
    // rust: self.close_container_at(i);
    // rust: continue;
}
    // rust: for slot in 0..size + 36 {
    // rust: let now = self.view_slot(i, world, slot);
    // rust: let sent = self.guests[i]
    // rust: .menu
    // rust: .as_ref()
    // rust: .and_then(|m| m.sent.get(slot).cloned());
    // rust: if sent.as_ref() == Some(&now) {
    // rust: continue;
}
    // rust: let net = self.stack(&now);
    // rust: let g = &mut self.guests[i];
    // rust: if let Some(m) = g.menu.as_mut() {
    // rust: m.state = (m.state + 1) & 0x7FFF;
    // rust: let state = m.state;
    // rust: if m.sent.len() <= slot {
    // rust: m.sent.resize(slot + 1, None);
}
    // rust: m.sent[slot] = now;
    // rust: g.send(&C::ContainerSetSlot(play::ContainerSetSlot {
    // rust: container: window,
    // rust: state,
    // rust: slot: slot as i16,
    // rust: item: net,
    // rust: }));
}
}
            // Then the data slots, as broadcastChanges does.
    // rust: self.sync_container_data(i, world);
}
}
}

/// Inventory index of the n-th player slot of a container menu (27 main, then the hotbar).
pub fn player_slot(n: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if n < 27 { 9 + n } else { n - 27 }
}

/// `Level.soundSeedGenerator.nextLong` for `ClientboundSoundPacket.seed`.
pub fn next_sound_seed(g: *mut impl RandomSource) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: g.next_long()
}

/// `PlayerList.broadcast`'s distance test: the summed squared axis distances
/// against the squared radius, and a player exactly at the radius is out.
    // rust: pub(super) fn within_range(at: [f64; 3], pos: [f64; 3], range: f64) -> bool {
    // rust: let d: f64 = (0..3).map(|k| (pos[k] - at[k]).powi(2)).sum();
    // rust: d < range * range
}

    // rust: mod tests {
//     use super::{next_sound_seed, within_range};
//     use horizon_core::random::LegacyRandom;

pub fn two_sounds_in_one_tick_get_different_seeds() void {
}
    // rust: let mut g = LegacyRandom::new(0);
    // rust: let a = next_sound_seed(&mut g);
    // rust: let b = next_sound_seed(&mut g);
    // rust: assert_ne!(a, b);
    // rust: assert_ne!(a, 0);
    // rust: assert_ne!(b, 0);
}

pub fn the_tick_is_not_the_sound_seed() void {
}
    // rust: let ticks = 12i64;
    // rust: let mut g = LegacyRandom::new(0);
    // rust: assert_ne!(next_sound_seed(&mut g), ticks);
}

    /// `PlayerList.broadcast` compares the squared distances with `ifge`, so a
    /// player exactly on the radius gets no packet while one a hair inside does.
pub fn a_guest_exactly_on_the_radius_hears_nothing() void {
}
    // rust: let at = [10.0, 64.0, -3.0];
    // rust: let at_radius = [at[0] + 16.0, at[1], at[2]];
    // rust: assert!(!within_range(at, at_radius, 16.0));
    // rust: assert!(within_range(at, [at[0] + 15.99, at[1], at[2]], 16.0));
    // rust: assert!(within_range(at, at, 16.0));
}
}
