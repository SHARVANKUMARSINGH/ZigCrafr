//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lan_trading
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Trading for LAN guests: the villager screen a guest opens runs the same
//! merchant menu as the host's (`horizon_client::menu`, `Kind::Merchant`),
//! with vanilla's packets: OpenScreen (`minecraft:merchant`), MerchantOffers,
//! the select trade packet, container clicks and the content sync after each.
// use super::{
    // rust: Game, lan::LanHost, lan_actions::guest_within_entity_range, stations::Kind as StationKind,
    // rust: trading::MerchantState,
}
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: menu::{Env, Input, Kind, Menu},
    // rust: merchant,
}
// use horizon_protocol::packets::play::{self, Clientbound as C};

/// A guest's open trading screen.
    // rust: pub(super) struct GuestMerchant {
    // rust: pub(super) window: i32,
    // rust: state: i32,
    /// The payment slots and the result.
    // rust: slots: [Option<ItemStack>; 3],
    // rust: pub(super) merchant: Box<MerchantState>,
    /// The offers the client was last sent.
    // rust: sent: Vec<merchant::MerchantOffer>,
    // rust: sent_level: i32,
}

/// A guest's UUID as gossip targets it.
pub fn uuid_words(uuid: u128) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [
    // rust: (uuid >> 96) as i32,
    // rust: (uuid >> 64) as i32,
    // rust: (uuid >> 32) as i32,
    // rust: uuid as i32,
    // rust: ]
}

    // rust: impl Game<'_> {
    /// A trading screen the guest's interaction opened (it opened as a
    /// station while the guest acted): handed to the guest.
    // rust: pub(super) fn lan_open_merchant(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: mut state: MerchantState,
    // rust: ) {
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let uuid = uuid_words(host.hub.guests[gi].uuid);
    // rust: if let Some(id) = state.mob
    // rust: && state.session.villager
    // rust: {
            // startTrading with the guest's reputation. The session already
            // captured their Hero effect while they acted as the player.
    // rust: state.session.reputation = self.villager_reputation_of(id, uuid);
    // rust: state.session.update_special_prices();
}
    // rust: let title = self.merchant_display_name(&state);
    // rust: if !self.guest_may_open(host, conn, "minecraft:merchant", None) {
    // rust: self.merchant_closed(&mut state);
    // rust: return;
}
        // ServerPlayer.openMenu closes the menu that was open.
    // rust: self.guest_close_all(host, conn);
    // rust: let Some(window) = host.hub.open_merchant_window(conn, title) else {
    // rust: self.merchant_closed(&mut state);
    // rust: return;
}
    // rust: let mut gm = GuestMerchant {
    // rust: window,
    // rust: state: 0,
    // rust: slots: [None, None, None],
    // rust: merchant: Box::new(state),
    // rust: sent: Vec::new(),
    // rust: sent_level: 0,
}
    // rust: self.lan_send_offers(host, conn, &mut gm, true);
    // rust: self.lan_send_merchant_content(host, conn, &mut gm);
    // rust: host.play.entry(conn).or_default().merchant = Some(gm);
}
    /// `Entity.getDisplayName` of the merchant, the screen's title: its name
    /// (custom, else the profession's) with the show_entity hover event and
    /// its UUID as insertion.
pub fn merchant_display_name(self: *Self, state: *MerchantState) h {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_world::nbt::Tag;
    // rust: let s = &state.session;
    // rust: let (kind, key) = if s.villager {
    // rust: let p = s.profession.trim_start_matches("minecraft:");
    // rust: (
    // rust: "minecraft:villager",
    // rust: format!("entity.minecraft.villager.{p}"),
    // rust: )
    // rust: } else {
    // rust: (
    // rust: "minecraft:wandering_trader",
    // rust: "entity.minecraft.wandering_trader".to_owned(),
    // rust: )
}
    // rust: let name = match &state.name {
    // rust: Some(n) => horizon_protocol::text::literal(n),
    // rust: None => Tag::compound([("translate", Tag::String(key.as_str().into()))]),
}
    // rust: let uuid = state.mob.map_or([0; 4], |id| self.mob_uuid(id));
    // rust: let w = uuid.map(|v| v as u32);
    // rust: let text = format!(
    // rust: "{:08x}-{:04x}-{:04x}-{:04x}-{:04x}{:08x}",
    // rust: w[0],
    // rust: w[1] >> 16,
    // rust: w[1] & 0xffff,
    // rust: w[2] >> 16,
    // rust: w[2] & 0xffff,
    // rust: w[3]
    // rust: );
    // rust: let mut out = match name.clone() {
    // rust: Tag::Compound(c) => c,
    // rust: other => {
    // rust: let mut c = horizon_world::nbt::Compound::new();
    // rust: c.insert("text".into(), other);
    // rust: c
}
}
    // rust: out.insert(
    // rust: "hover_event".into(),
    // rust: Tag::compound([
    // rust: ("action", Tag::String("show_entity".into())),
    // rust: ("id", Tag::String(kind.into())),
    // rust: ("uuid", Tag::IntArray(uuid.to_vec())),
    // rust: ("name", name),
    // rust: ]),
    // rust: );
    // rust: out.insert("insertion".into(), Tag::String(text.as_str().into()));
    // rust: Tag::Compound(out)
}
    /// The screen title: the custom name, else the profession (the client
    /// adds the level itself).
    /// `ServerPlayer.sendMerchantOffers`, when the offers changed.
    // rust: fn lan_send_offers(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: gm: &mut GuestMerchant,
    // rust: force: bool,
    // rust: ) {
    // rust: let s = &gm.merchant.session;
    // rust: if !force && s.offers == gm.sent && s.level == gm.sent_level {
    // rust: return;
}
    // rust: let offers: Vec<play::NetOffer> = s
    // rust: .offers
    // rust: .iter()
    // rust: .filter_map(|o| {
    // rust: let cost = |st: &ItemStack, hub: &mut horizon_client::lan::hub::Hub| {
    // rust: hub.stack(&Some(st.clone())).map(play::NetCost::from)
}
    // rust: Some(play::NetOffer {
    // rust: cost_a: cost(&o.base_cost_a.stack, &mut host.hub)?,
    // rust: result: host.hub.stack(&Some(o.result.clone()))?,
    // rust: cost_b: match &o.cost_b {
    // rust: Some(b) => Some(cost(&b.stack, &mut host.hub)?),
    // rust: None => None,
    // rust: },
    // rust: out_of_stock: o.out_of_stock(),
    // rust: uses: o.uses,
    // rust: max_uses: o.max_uses,
    // rust: xp: o.xp,
    // rust: special_price: o.special_price_diff,
    // rust: price_multiplier: o.price_multiplier,
    // rust: demand: o.demand,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::MerchantOffers(play::MerchantOffers {
    // rust: container: gm.window,
    // rust: offers,
    // rust: level: s.level,
    // rust: xp: s.xp,
    // rust: show_progress: s.villager,
    // rust: can_restock: s.villager,
    // rust: }),
    // rust: );
    // rust: gm.sent = s.offers.clone();
    // rust: gm.sent_level = s.level;
}
pub fn lan_send_merchant_content(self: *Self, host: *mut LanHost, conn: u32, gm: *mut GuestMerchant) void {
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let mut items: Vec<Option<ItemStack>> = gm.slots.to_vec();
    // rust: let g = &host.hub.guests[gi];
    // rust: items.extend((9..36).chain(0..9).map(|i| g.inventory[i].clone()));
    // rust: let carried = g.carried.clone();
    // rust: let net: Vec<_> = items.iter().map(|s| host.hub.stack(s)).collect();
    // rust: let carried = host.hub.stack(&carried);
    // rust: gm.state = (gm.state + 1) & 0x7FFF;
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::ContainerSetContent(play::ContainerSetContent {
    // rust: container: gm.window,
    // rust: state: gm.state,
    // rust: items: net,
    // rust: carried,
    // rust: }),
    // rust: );
}
    /// Runs `op` on the guest's merchant menu (their inventory copied in and
    /// back), then syncs the client. False when the guest has no such window.
    // rust: fn lan_merchant_op(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: Option<i32>,
    // rust: op: impl FnOnce(&mut Menu, &Env),
    // rust: ) -> bool {
    // rust: let Some(mut gm) = host.play.get_mut(&conn).and_then(|p| p.merchant.take()) else {
    // rust: return false;
}
    // rust: if window.is_some_and(|w| w != gm.window) {
    // rust: host.play.entry(conn).or_default().merchant = Some(gm);
    // rust: return false;
}
    // rust: let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) else {
    // rust: return false;
}
    // rust: let mut session = gm.merchant.session.clone();
    // rust: self.merchant_sync_in(&mut session, gm.merchant.mob);
    // rust: let next_map = self.peek_map_id();
    // rust: let tag = |t: &str| self.structure_tag(t);
    // rust: let maps = super::trading::GameMaps {
    // rust: terrain: self.end.locator(),
    // rust: structure_tag: &tag,
    // rust: made: Default::default(),
    // rust: next_id: std::cell::Cell::new(next_map),
}
    // rust: let trade_env = merchant::TradeEnv {
    // rust: trades: &self.stations().trades,
    // rust: enchantments: &self.stations().enchantments,
    // rust: maps: Some(&maps),
}
    // rust: let env = Env {
    // rust: items: self.items(),
    // rust: recipes: self.recipes(),
    // rust: brewing: &self.stations().brewing,
    // rust: banners: &self.stations().banners,
    // rust: station_recipes: &self.stations().recipes,
    // rust: enchantments: &self.stations().enchantments,
    // rust: names: &self.pack.names,
    // rust: trade: Some(&trade_env),
    // rust: maps: None,
    // rust: limited_crafting: host.hub.limited_crafting,
    // rust: known_recipes: Some(&host.hub.guests[gi].recipe_book),
}
    // rust: let mut menu = Menu::new(Kind::Merchant);
    // rust: {
    // rust: let g = &host.hub.guests[gi];
    // rust: for i in 0..36 {
    // rust: menu.set_player_item(i, g.inventory[i].clone());
}
    // rust: menu.set_player_item(40, g.offhand.clone());
    // rust: menu.selected = g.selected;
    // rust: menu.creative = g.creative();
    // rust: menu.carried = g.carried.clone();
}
    // rust: for (i, s) in gm.slots.iter().enumerate() {
    // rust: menu.set_slot(&env, i, s.clone());
}
    // rust: menu.merchant = Some(session);
    // rust: op(&mut menu, &env);
    // rust: let made = maps.made.take();
    // rust: let session = menu.merchant.take().expect("attached");
    // rust: let dropped = std::mem::take(&mut menu.dropped);
    // rust: gm.slots = [
    // rust: menu.slot(0).cloned(),
    // rust: menu.slot(1).cloned(),
    // rust: menu.slot(2).cloned(),
    // rust: ];
    // rust: {
    // rust: let g = &mut host.hub.guests[gi];
    // rust: for i in 0..36 {
    // rust: g.inventory[i] = menu.player_item(i).cloned();
}
    // rust: g.offhand = menu.player_item(40).cloned();
    // rust: g.carried = menu.carried.take();
}
    // rust: self.register_exploration_maps(made);
    // rust: let (session, traded) = self.merchant_apply(session, gm.merchant.mob);
    // rust: gm.merchant.session = session;
    // rust: if !traded.is_empty() {
            // The guest's own statistic and advancements.
    // rust: if let Some(gi) = host.hub.guests.iter().position(|g| g.conn == conn) {
    // rust: let g = &host.hub.guests[gi];
    // rust: if let Some(entity_id) = gm.merchant.mob {
    // rust: self.native_player_trade(g.uuid, &g.name, entity_id);
}
}
    // rust: self.as_guest(host, conn, |g| g.merchant_traded(gm.merchant.mob, &traded));
}
    // rust: self.drop_guest_items(host, gi, dropped);
    // rust: self.lan_send_offers(host, conn, &mut gm, false);
    // rust: self.lan_send_merchant_content(host, conn, &mut gm);
    // rust: host.play.entry(conn).or_default().merchant = Some(gm);
    // rust: true
}
    /// A container click on the guest's trading window.
    // rust: pub(super) fn lan_merchant_click(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: p: &play::ContainerClick,
    // rust: ) -> bool {
    // rust: let input = match p.input {
    // rust: 0 => Input::Pickup,
    // rust: 1 => Input::QuickMove,
    // rust: 2 => Input::Swap,
    // rust: 3 => Input::Clone,
    // rust: 4 => Input::Throw,
    // rust: 5 => Input::QuickCraft,
    // rust: _ => Input::PickupAll,
}
    // rust: let (slot, button) = (i32::from(p.slot), i32::from(p.button));
    // rust: self.lan_merchant_op(host, conn, Some(p.container), |menu, env| {
    // rust: let _ = menu.click(env, slot, button, input);
    // rust: })
}
    /// ServerboundSelectTradePacket: the selection hint, then tryMoveItems.
    // rust: pub(super) fn lan_select_trade(&mut self, host: &mut LanHost, conn: u32, index: i32) {
    // rust: let Ok(index) = usize::try_from(index) else {
    // rust: return;
}
    // rust: let Some(guest) = host.hub.guests.iter().find(|g| g.conn == conn) else {
    // rust: return;
}
    // rust: let (uuid, name) = (guest.uuid, guest.name.clone());
    // rust: if self.lan_merchant_op(host, conn, None, |menu, env| {
    // rust: menu.merchant_select(env, index)
    // rust: }) {
    // rust: let villager = host
    // rust: .play
    // rust: .get(&conn)
    // rust: .and_then(|p| p.merchant.as_ref())
    // rust: .and_then(|m| m.merchant.mob);
    // rust: self.native_trade_select(uuid, &name, villager, index);
}
}
    /// The guest closed the trading window (or it is closed for them):
    /// MerchantMenu.removed, then the villager gets its state back.
    // rust: pub(super) fn lan_merchant_closed(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: window: Option<i32>,
    // rust: ) -> bool {
    // rust: if !self.lan_merchant_op(host, conn, window, |menu, env| menu.merchant_close(env)) {
    // rust: return false;
}
    // rust: let Some(mut gm) = host.play.get_mut(&conn).and_then(|p| p.merchant.take()) else {
    // rust: return false;
}
    // rust: let uuid = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn)
    // rust: .map(|g| uuid_words(g.uuid));
    // rust: if std::mem::take(&mut gm.merchant.session.last_traded)
    // rust: && let (Some(id), Some(uuid)) = (gm.merchant.mob, uuid)
    // rust: {
    // rust: self.villager_traded_by(id, uuid);
}
    // rust: self.merchant_closed(&mut gm.merchant);
    // rust: true
}
    /// `Merchant.stillValid` for a trader: it is alive and the guest is within
    /// the entity interaction range plus 4 of its box.
    // rust: pub(super) fn lan_merchant_valid(
    // rust: &self,
    // rust: g: &horizon_client::lan::guest::Guest,
    // rust: id: u32,
    // rust: ) -> bool {
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .is_some_and(|m| m.alive() && guest_within_entity_range(g, &m.bounds(), 4.0))
}
    /// `Villager.customServerAiStep` for the guests' trading villagers: the
    /// TRADE reputation event, then the prices follow.
    // rust: pub(super) fn lan_merchant_tick(&mut self, host: &mut LanHost) {
        // `AbstractVillager.stillValid`: the trade screen closes once the trader
        // is gone or dead, or the guest is more than 4 blocks past its reach.
    // rust: let far: Vec<(u32, i32)> = host
    // rust: .play
    // rust: .iter()
    // rust: .filter_map(|(conn, p)| {
    // rust: let gm = p.merchant.as_ref()?;
    // rust: let id = gm.merchant.mob?;
    // rust: let g = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == *conn && host.hub.here(g))?;
    // rust: (!self.lan_merchant_valid(g, id)).then_some((*conn, gm.window))
    // rust: })
    // rust: .collect();
    // rust: for (conn, window) in far {
    // rust: if self.lan_merchant_closed(host, conn, Some(window)) {
    // rust: host.hub.send_to(
    // rust: conn,
    // rust: &C::ContainerClose(play::ContainerClose { container: window }),
    // rust: );
}
}
    // rust: let conns: Vec<u32> = host
    // rust: .play
    // rust: .iter()
    // rust: .filter(|(_, p)| {
    // rust: p.merchant
    // rust: .as_ref()
    // rust: .is_some_and(|m| m.merchant.session.villager && m.merchant.session.last_traded)
    // rust: })
    // rust: .map(|(c, _)| *c)
    // rust: .collect();
    // rust: for conn in conns {
    // rust: let Some(uuid) = host
    // rust: .hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| g.conn == conn && host.hub.here(g))
    // rust: .map(|g| uuid_words(g.uuid))
    // rust: else {
    // rust: continue;
}
    // rust: let Some(gm) = host.play.get_mut(&conn).and_then(|p| p.merchant.as_mut()) else {
    // rust: continue;
}
    // rust: gm.merchant.session.last_traded = false;
    // rust: let Some(id) = gm.merchant.mob else { continue };
    // rust: self.villager_traded_by(id, uuid);
    // rust: let reputation = self.villager_reputation_of(id, uuid);
    // rust: self.lan_merchant_op(host, conn, None, |menu, env| {
    // rust: if let Some(s) = menu.merchant.as_mut() {
    // rust: s.reputation = reputation;
    // rust: s.update_special_prices();
}
    // rust: menu.merchant_update(env);
    // rust: });
}
}
    /// Takes a station a guest's action opened: a trading screen or a
    /// workstation menu goes to the guest (game/lan_stations.rs).
    // rust: pub(super) fn lan_station_opened(
    // rust: &mut self,
    // rust: host: &mut LanHost,
    // rust: conn: u32,
    // rust: station: super::stations::Station,
    // rust: ) {
    // rust: let mut station = station;
    // rust: if station.kind == StationKind::Merchant
    // rust: && let Some(m) = station.merchant.take()
    // rust: {
    // rust: self.lan_open_merchant(host, conn, *m);
    // rust: return;
}
    // rust: self.lan_open_station(host, conn, &station);
}
}
