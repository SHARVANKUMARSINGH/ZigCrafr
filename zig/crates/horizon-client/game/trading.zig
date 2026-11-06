//! Transpiled from Horizon Rust crate
//! Module: horizon-client_trading
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The merchant (villager trading) menu: `MerchantMenu` / `MerchantScreen`
//! layout (276x166, drawn 50 px left of the usual 176-wide origin), offer
//! buttons, payment slots, the result slot's `onTake`, villager experience and
//! level-ups with new offers from the next trade set.
// use super::{
    // rust: Game,
    // rust: stations::{INPUT, Kind, RESULT, Station},
}
// use horizon_client::mobs::{
    // rust: Species,
    // rust: render::{PROFESSIONS, VILLAGER_TYPES},
    // rust: villager,
}
// use horizon_client::{
    // rust: hud::{HudBatch, rgba},
    // rust: items::ItemStack,
    // rust: merchant::{self, MerchantOffer, TradeContext},
}

/// The merchant screen is 100 px wider than the 176-px menus it shares an origin with.
pub const SHIFT: f32 = -50.0;
pub const GREY: u32 = 0xFF40_4040;

    // rust: pub(super) struct MerchantState {
    /// The merchant's side of the menu: offers, experience, level, the
    /// selection hint and active offer (`horizon_client::merchant::Session`).
    // rust: pub(super) session: Box<merchant::Session>,
    /// The offer list's scroll offset.
    // rust: pub(super) scroll: usize,
    /// The scroller is held by the mouse (`isDragging`).
    // rust: pub(super) dragging: bool,
    /// The offer button that keeps focus after a click (drawn highlighted).
    // rust: pub(super) focused: Option<usize>,
    /// The trading mob (its offers and experience are written back on
    /// close) and its custom name.
    // rust: pub(super) mob: Option<u32>,
    // rust: pub(super) name: Option<String>,
}
    // rust: impl MerchantState {
    /// `Merchant.showProgressBar`: villagers only.
    // rust: pub(super) fn progress(&self) -> bool {
    // rust: self.session.show_progress()
}
}
/// Player inventory slot positions in `MerchantMenu` (x from 108).
    // rust: pub(super) fn inventory_slot(i: usize) -> (f32, f32) {
    // rust: match i {
    // rust: 0..9 => (108.0 + SHIFT + i as f32 * 18.0, 142.0),
    // rust: _ => (
    // rust: 108.0 + SHIFT + ((i - 9) % 9) as f32 * 18.0,
    // rust: 84.0 + ((i - 9) / 9) as f32 * 18.0,
    // rust: ),
}
}

/// `ExplorationMapFunction` in the game world: the nearest structure of the
/// tag through the generator's `/locate`, a new map centred on it with its
/// target decoration.
    // rust: pub(super) struct GameMaps<'a> {
    // rust: pub(super) terrain: Option<std::sync::Arc<horizon_client::vanillagen::VanillaTerrain>>,
    /// Structure tag -> its structures.
    // rust: pub(super) structure_tag: &'a dyn Fn(&str) -> Vec<String>,
    /// Maps made, for the caller to register: (map id, centre x, z, scale, target).
    // rust: pub(super) made: std::cell::RefCell<Vec<(i32, [i32; 3], u8, String)>>,
    // rust: pub(super) next_id: std::cell::Cell<i32>,
}
    // rust: impl merchant::MapMaker for GameMaps<'_> {
    // rust: fn exploration_map(
    // rust: &self,
    // rust: stack: ItemStack,
    // rust: map: &merchant::ExplorationMap,
    // rust: origin: [f64; 3],
    // rust: ) -> ItemStack {
    // rust: let Some(terrain) = self.terrain.as_ref() else {
    // rust: return stack;
}
    // rust: let names = (self.structure_tag)(&map.destination);
    // rust: if names.is_empty() {
    // rust: return stack;
}
    // rust: let from = [
    // rust: origin[0].floor() as i32,
    // rust: origin[1].floor() as i32,
    // rust: origin[2].floor() as i32,
    // rust: ];
    // rust: let Some((_, at)) =
    // rust: terrain.locate_for_map(&names, from, map.search_radius, map.skip_existing_chunks)
    // rust: else {
    // rust: return stack;
}
    // rust: let id = self.next_id.get();
    // rust: self.next_id.set(id + 1);
    // rust: self.made
    // rust: .borrow_mut()
    // rust: .push((id, at, map.zoom, map.decoration.clone()));
        // The trade's own map item (woodland_mansion_map, ...) keeps its id.
    // rust: let mut out = stack;
    // rust: let d = out.data_mut();
    // rust: d.map_id = Some(id);
    // rust: d.other.push((
    // rust: "minecraft:map_decorations".into(),
    // rust: horizon_world::nbt::Tag::compound([(
    // rust: "+",
    // rust: horizon_world::nbt::Tag::compound([
    // rust: (
    // rust: "type",
    // rust: horizon_world::nbt::Tag::String(map.decoration.as_str().into()),
    // rust: ),
    // rust: (
    // rust: "x",
    // rust: horizon_world::nbt::Tag::Double(f64::from(at[0]).to_bits()),
    // rust: ),
    // rust: (
    // rust: "z",
    // rust: horizon_world::nbt::Tag::Double(f64::from(at[2]).to_bits()),
    // rust: ),
    // rust: (
    // rust: "rotation",
    // rust: horizon_world::nbt::Tag::Float(180.0f32.to_bits()),
    // rust: ),
    // rust: ]),
    // rust: )]),
    // rust: ));
    // rust: out
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn random_sequences_path(&self) -> std::path::PathBuf {
    // rust: self.world_root.join("data/minecraft/random_sequences.dat")
}
    /// `RandomSequences` as `random_sequences.dat` (not on a server's guest).
    // rust: pub(super) fn save_random_sequences(&mut self) {
    // rust: if self.remote.is_some() || self.rand_sequences.ids().is_empty() {
    // rust: return;
}
    // rust: let tag = horizon_world::nbt::Tag::compound([
    // rust: ("data", self.rand_sequences.to_nbt()),
    // rust: (
    // rust: "DataVersion",
    // rust: horizon_world::nbt::Tag::Int(horizon_world::DATA_VERSION),
    // rust: ),
    // rust: ]);
    // rust: if let Err(e) = horizon_client::save::write_dat(&self.random_sequences_path(), tag) {
    // rust: log::warn!("the villager random sequences were not written: {e}");
}
}
    /// `AbstractVillager.addOffersFromTradeSet` with the world's random
    /// sequence of the set, at the merchant's position.
    // rust: fn offers_from_set(
    // rust: &mut self,
    // rust: set: &str,
    // rust: variant: &str,
    // rust: origin: [f64; 3],
    // rust: ) -> Vec<MerchantOffer> {
    // rust: let Some(sequence) = self.stations().trades.sequence(set) else {
    // rust: return Vec::new();
}
    // rust: let mut random = self.rand_sequences.lend(&sequence, self.level.seed);
    // rust: let next_map = self.peek_map_id();
    // rust: let tag = |t: &str| self.structure_tag(t);
    // rust: let maps = GameMaps {
    // rust: terrain: self.end.locator(),
    // rust: structure_tag: &tag,
    // rust: made: Default::default(),
    // rust: next_id: std::cell::Cell::new(next_map),
}
    // rust: let ctx = TradeContext {
    // rust: items: self.items(),
    // rust: enchantments: &self.stations().enchantments,
    // rust: variant,
    // rust: origin,
    // rust: maps: Some(&maps),
}
    // rust: let offers = self
    // rust: .res
    // rust: .stations()
    // rust: .trades
    // rust: .offers_from_set(&ctx, set, &mut random);
    // rust: let made = maps.made.into_inner();
    // rust: self.rand_sequences.give_back(sequence, random);
    // rust: self.register_exploration_maps(made);
    // rust: offers
}
    /// `AbstractVillager.getOffers`: generated on first use.
    // rust: pub(super) fn ensure_offers(&mut self, index: usize) {
    // rust: let species = self.mobs[index].species();
    // rust: let unset = self.mobs[index]
    // rust: .extra
    // rust: .trade
    // rust: .as_ref()
    // rust: .is_none_or(|t| t.unset);
    // rust: if unset {
    // rust: let m = &self.mobs[index];
    // rust: let variant = format!(
    // rust: "minecraft:{}",
    // rust: VILLAGER_TYPES[m.extra.variant as usize % VILLAGER_TYPES.len()]
    // rust: );
    // rust: let origin = [m.position.x, m.position.y, m.position.z];
    // rust: let offers = if species == Species::WanderingTrader {
    // rust: let mut v = Vec::new();
    // rust: for set in ["buying", "uncommon", "common"] {
    // rust: v.extend(self.offers_from_set(
    // rust: &format!("minecraft:wandering_trader/{set}"),
    // rust: &variant,
    // rust: origin,
    // rust: ));
}
    // rust: v
    // rust: } else {
    // rust: let profession = PROFESSIONS[m.extra.variant2 as usize % PROFESSIONS.len()];
    // rust: let level = i32::from(m.extra.variant3.max(1));
    // rust: let set = merchant::Trades::set_for(profession, level);
    // rust: if self.stations().trades.sets.contains_key(&set) {
    // rust: self.offers_from_set(&set, &variant, origin)
    // rust: } else {
    // rust: Vec::new()
}
}
    // rust: let trade = self.mobs[index].extra.trade.get_or_insert_default();
    // rust: trade.offers = offers;
    // rust: trade.unset = false;
}
}
    /// `Villager.mobInteract` / `WanderingTrader.mobInteract`: shake the
    /// head without offers, else open the trading screen.
    // rust: pub(super) fn interact_trader(
    // rust: &mut self,
    // rust: index: usize,
    // rust: item: &str,
    // rust: ) -> horizon_client::Result<bool> {
    // rust: let m = &self.mobs[index];
    // rust: let species = m.species();
    // rust: if !matches!(species, Species::Villager | Species::WanderingTrader)
    // rust: || !m.alive()
    // rust: || item == "minecraft:villager_spawn_egg"
    // rust: || self.station.is_some()
    // rust: || m.extra.flag2
    // rust: || (species == Species::Villager && villager::sleeping(m))
    // rust: {
    // rust: return Ok(false);
}
    // rust: if m.is_baby() {
            // A baby villager shakes its head; a baby wandering trader does
            // nothing of its own.
    // rust: if species == Species::WanderingTrader {
    // rust: return Ok(false);
}
    // rust: let mut events = Vec::new();
    // rust: villager::set_unhappy(&mut self.mobs[index], &mut events);
    // rust: self.handle_mob_events(events)?;
    // rust: return Ok(true);
}
    // rust: self.award_custom_stat("talked_to_villager", 1);
    // rust: self.ensure_offers(index);
    // rust: let m = &self.mobs[index];
    // rust: let trade = m.extra.trade.as_deref().cloned().unwrap_or_default();
    // rust: if trade.offers.is_empty() {
    // rust: if species == Species::Villager {
    // rust: let mut events = Vec::new();
    // rust: villager::set_unhappy(&mut self.mobs[index], &mut events);
    // rust: self.handle_mob_events(events)?;
}
    // rust: return Ok(true);
}
    // rust: let villager = species == Species::Villager;
    // rust: let profession = if villager {
    // rust: PROFESSIONS[m.extra.variant2 as usize % PROFESSIONS.len()]
    // rust: } else {
    // rust: "wandering_trader"
}
    // rust: let level = if villager {
    // rust: i32::from(m.extra.variant3.max(1)).min(5)
    // rust: } else {
    // rust: 1
}
    // rust: let mut session = merchant::Session::new(trade.offers, villager);
    // rust: session.xp = trade.xp;
    // rust: session.level = level;
    // rust: session.profession = format!("minecraft:{profession}");
    // rust: session.variant = format!(
    // rust: "minecraft:{}",
    // rust: VILLAGER_TYPES[m.extra.variant as usize % VILLAGER_TYPES.len()]
    // rust: );
    // rust: session.random = m.random.clone();
    // rust: session.origin = [m.position.x, m.position.y, m.position.z];
    // rust: session.ambient_sound_time = m.ambient_timer;
    // rust: let (id, name) = (m.id, m.custom_name.clone());
    // rust: if villager {
    // rust: session.reputation = self.villager_reputation(id);
    // rust: session.hero = self.hero_amplifier();
    // rust: for seq in merchant::Session::sequences_needed(
    // rust: &self.stations().trades,
    // rust: &session.profession,
    // rust: level,
    // rust: ) {
    // rust: let r = self.rand_sequences.lend(&seq, self.level.seed);
    // rust: session.sequences.insert(seq, r);
}
}
        // startTrading: updateSpecialPrices, then the screen opens.
    // rust: session.update_special_prices();
        // setTradingPlayer: a wandering trader stands still while trading, a
        // villager's brain follows and looks at the player
        // (LookAndFollowTradingPlayerSink).
    // rust: self.mobs[index].extra.flag2 = true;
    // rust: self.open_merchant_state(MerchantState {
    // rust: session: Box::new(session),
    // rust: scroll: 0,
    // rust: dragging: false,
    // rust: focused: None,
    // rust: mob: Some(id),
    // rust: name,
    // rust: });
    // rust: Ok(true)
}
    /// `Villager.setTradingPlayer(null)`: the session goes back to the mob
    /// (special prices stay as they were), the borrowed sequences to the world.
    // rust: pub(super) fn merchant_closed(&mut self, state: &mut MerchantState) {
    // rust: let session = &mut state.session;
    // rust: for (id, r) in std::mem::take(&mut session.sequences) {
    // rust: self.rand_sequences.give_back(id, r);
}
    // rust: let traded = std::mem::take(&mut session.last_traded);
    // rust: let Some(id) = state.mob else { return };
    // rust: let Some(m) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: if session.villager {
    // rust: m.extra.variant3 = session.level.clamp(1, 5) as u8;
}
    // rust: m.extra.flag2 = false;
    // rust: m.random = session.random.clone();
    // rust: m.ambient_timer = session.ambient_sound_time;
    // rust: let trade = m.extra.trade.get_or_insert_default();
    // rust: trade.xp = session.xp;
    // rust: trade.offers = session.offers.clone();
    // rust: if traded && session.villager {
    // rust: self.villager_traded(id);
}
}
    /// Opens a merchant menu without a mob (horizon-ctl `trade`).
    // rust: pub(super) fn open_merchant(&mut self, profession: &str, variant: &str, level: i32) {
    // rust: let profession = format!("minecraft:{}", profession.trim_start_matches("minecraft:"));
    // rust: let variant = format!("minecraft:{}", variant.trim_start_matches("minecraft:"));
    // rust: let level = level.clamp(1, 5);
    // rust: let origin = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map_or([0.0; 3], |p| [p.position.x, p.position.y, p.position.z]);
    // rust: let mut offers = Vec::new();
    // rust: for l in 1..=level {
    // rust: let set = merchant::Trades::set_for(&profession, l);
    // rust: offers.extend(self.offers_from_set(&set, &variant, origin));
}
    // rust: let mut session = merchant::Session::new(offers, true);
    // rust: session.profession = profession;
    // rust: session.variant = variant;
    // rust: session.level = level;
    // rust: session.xp = merchant::min_xp(level);
    // rust: session.origin = origin;
    // rust: self.open_merchant_state(MerchantState {
    // rust: session: Box::new(session),
    // rust: scroll: 0,
    // rust: dragging: false,
    // rust: focused: None,
    // rust: mob: None,
    // rust: name: None,
    // rust: });
}
    /// A server's trading window (no mob here: the server keeps it).
    // rust: pub(super) fn open_remote_merchant(
    // rust: &mut self,
    // rust: session: merchant::Session,
    // rust: name: Option<String>,
    // rust: ) {
    // rust: self.open_merchant_state(MerchantState {
    // rust: session: Box::new(session),
    // rust: scroll: 0,
    // rust: dragging: false,
    // rust: focused: None,
    // rust: mob: None,
    // rust: name,
    // rust: });
}
pub fn open_merchant_state(self: *Self, state: MerchantState) void {
}
    // rust: let mut s = Station::new_kind(Kind::Merchant, [0, 0, 0]);
    // rust: s.merchant = Some(Box::new(state));
    // rust: self.station = Some(s);
    // rust: self.screen = super::Screen::Inventory;
    // rust: self.capture(false);
    // rust: self.right = false;
}
    /// The trading mob's random before a menu click (it ticks meanwhile).
    // rust: pub(super) fn merchant_sync_in(&self, session: &mut merchant::Session, mob: Option<u32>) {
    // rust: if let Some(m) = mob.and_then(|id| self.mobs.iter().find(|m| m.id == id)) {
    // rust: session.random = m.random.clone();
    // rust: session.ambient_sound_time = m.ambient_timer;
    // rust: session.origin = [m.position.x, m.position.y, m.position.z];
}
}
    /// After a menu click: the session back to the station, its random to
    /// the mob, and what it did (orbs, level-ups, the yes/no voice).
    // rust: pub(super) fn merchant_sync_out(&mut self, session: Box<merchant::Session>) {
    // rust: let mob = self
    // rust: .station
    // rust: .as_ref()
    // rust: .and_then(|s| s.merchant.as_ref())
    // rust: .and_then(|m| m.mob);
    // rust: let (session, traded) = self.merchant_apply(session, mob);
    // rust: self.merchant_traded(mob, &traded);
    // rust: if let Some(m) = self.station.as_mut().and_then(|s| s.merchant.as_mut()) {
    // rust: m.session = session;
}
}
    /// What a menu click's session did, applied to the world and its mob;
    /// with the offer of each trade made (as it is after the trade), for
    /// `merchant_traded`.
    // rust: pub(super) fn merchant_apply(
    // rust: &mut self,
    // rust: session: Box<merchant::Session>,
    // rust: mob: Option<u32>,
    // rust: ) -> (Box<merchant::Session>, Vec<MerchantOffer>) {
    // rust: let mut session = session;
    // rust: let events = std::mem::take(&mut session.events);
    // rust: let mut traded = Vec::new();
    // rust: let (villager, origin) = (session.villager, session.origin);
    // rust: if let Some(m) = mob.and_then(|id| self.mobs.iter_mut().find(|m| m.id == id)) {
    // rust: m.random = session.random.clone();
    // rust: m.ambient_timer = session.ambient_sound_time;
    // rust: if villager {
    // rust: m.extra.variant3 = session.level.clamp(1, 5) as u8;
}
}
    // rust: for e in events {
    // rust: match e {
    // rust: merchant::Event::Orb(v) => {
    // rust: self.add_orb([origin[0], origin[1] + 0.5, origin[2]], v as u32)
}
    // rust: merchant::Event::LevelUp(_) => {
    // rust: if let Some(m) = mob.and_then(|id| self.mobs.iter_mut().find(|m| m.id == id)) {
    // rust: m.add_effect("minecraft:regeneration", 200, 0);
}
}
    // rust: merchant::Event::TradeUpdated(yes, pitch) => {
    // rust: let sound = match (villager, yes) {
    // rust: (true, true) => "minecraft:entity.villager.yes",
    // rust: (true, false) => "minecraft:entity.villager.no",
    // rust: (false, true) => "minecraft:entity.wandering_trader.yes",
    // rust: (false, false) => "minecraft:entity.wandering_trader.no",
}
    // rust: self.audio.play(sound, Some(origin), 1.0, pitch);
}
    // rust: merchant::Event::Traded(index, offer) => {
                    // The mods may change the live offer (Bukkit's PlayerTradeEvent#getTrade).
    // rust: let trader = mob.and_then(|id| {
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: Some((id, super::native_hooks::mob_kind(m)))
    // rust: });
    // rust: if let (Some((id, kind)), Some(live)) = (trader, session.offers.get_mut(index))
    // rust: {
    // rust: self.native_merchant_offer_traded(id, &kind, live);
}
    // rust: traded.push(*offer);
}
    // rust: merchant::Event::TradeSound => {
    // rust: let sound = if villager {
    // rust: "minecraft:entity.villager.yes"
    // rust: } else {
    // rust: "minecraft:entity.wandering_trader.yes"
}
    // rust: self.audio.play(sound, Some(origin), 1.0, 1.0);
}
}
}
    // rust: (session, traded)
}
    /// `MerchantResultSlot.onTake` for each trade made (`offers`, as each
    /// was right after its trade): the statistic, `AbstractVillager.notifyTrade`'s
    /// `villager_trade` trigger, then the mods' `native_trade_with_villager`
    /// for a server's player (when the trader is still in the level).
    // rust: pub(super) fn merchant_traded(&mut self, mob: Option<u32>, offers: &[MerchantOffer]) {
    // rust: for offer in offers {
    // rust: self.award_custom_stat("traded_with_villager", 1);
    // rust: let merchant = mob.and_then(|id| self.mobs.iter().find(|m| m.id == id));
    // rust: let kind = merchant.map(super::native_hooks::mob_kind);
    // rust: let villager = merchant.map(|m| self.mob_entity(m));
    // rust: if let Some(villager) = villager {
    // rust: self.trigger_trade(&villager, &offer.result);
}
            // TradeWithVillagerEvent: on the server, in the player's turn.
    // rust: if let (Some(id), Some(kind), Some(_)) = (mob, kind, self.lan_acting) {
    // rust: self.native_trade_with_villager(id, &kind, offer);
}
}
}
    /// `MerchantMenu.tryMoveItems` for the selected offer (the select trade packet).
pub fn try_move_items(self: *Self, index: usize) void {
}
    // rust: if self.remote.is_some() {
            // ServerboundSelectTradePacket; the server moves the items.
    // rust: if let Some(m) = self.station.as_mut().and_then(|s| s.merchant.as_mut()) {
    // rust: m.session.selection_hint = index;
}
    // rust: self.send(horizon_protocol::packets::play::Serverbound::SelectTrade(
    // rust: horizon_protocol::packets::play::SelectTrade { item: index as i32 },
    // rust: ));
    // rust: return;
}
    // rust: self.menu_session(|menu, env, _| {
    // rust: menu.merchant_select(env, index);
    // rust: Some(true)
    // rust: });
}
    /// Clicks on the offer list; true when one was hit. A press on the
    /// scroller holds it (`MerchantScreen.mouseClicked`).
    // rust: pub(super) fn merchant_click(&mut self, local: (f32, f32)) -> bool {
    // rust: let Some(m) = self.station.as_mut().and_then(|s| s.merchant.as_mut()) else {
    // rust: return false;
}
    // rust: m.dragging = on_scroller(local, m.session.offers.len());
    // rust: if m.dragging {
    // rust: return true;
}
    // rust: for i in 0..7 {
    // rust: let (x, y) = (5.0 + SHIFT, 18.0 + 20.0 * i as f32);
    // rust: if local.0 >= x
    // rust: && local.0 < x + 88.0
    // rust: && local.1 >= y
    // rust: && local.1 < y + 20.0
    // rust: && i + m.scroll < m.session.offers.len()
    // rust: {
    // rust: let index = i + m.scroll;
    // rust: if let Some(m) = self.station.as_mut().and_then(|s| s.merchant.as_mut()) {
    // rust: m.focused = Some(i);
}
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.try_move_items(index);
    // rust: return true;
}
}
    // rust: false
}
    /// `AbstractButton.keyPressed` on the focused offer button: Enter or
    /// Space presses it again, key repeats included, so holding Space
    /// refills the payment slots after every trade. Focus stays on the
    /// button through slot clicks (`ContainerEventHandler.mouseClicked`).
    // rust: pub(super) fn merchant_key(&mut self, key: winit::keyboard::KeyCode) -> bool {
//         use winit::keyboard::KeyCode;
    // rust: if !matches!(key, KeyCode::Enter | KeyCode::NumpadEnter | KeyCode::Space) {
    // rust: return false;
}
    // rust: let Some(m) = self.station.as_ref().and_then(|s| s.merchant.as_ref()) else {
    // rust: return false;
}
        // Buttons past the last offer are hidden, and a hidden button is inactive.
    // rust: let Some(index) = m
    // rust: .focused
    // rust: .map(|row| row + m.scroll)
    // rust: .filter(|&index| index < m.session.offers.len())
    // rust: else {
    // rust: return false;
}
    // rust: self.audio
    // rust: .play("minecraft:ui.button.click", None, 0.25, 1.0);
    // rust: self.try_move_items(index);
    // rust: true
}
    /// The offer buttons a controller can focus (GUI origin relative).
    // rust: pub(super) fn merchant_targets(&self) -> Vec<[f32; 4]> {
    // rust: let Some(m) = self.station.as_ref().and_then(|s| s.merchant.as_ref()) else {
    // rust: return Vec::new();
}
    // rust: (0..7)
    // rust: .filter(|i| i + m.scroll < m.session.offers.len())
    // rust: .map(|i| [5.0 + SHIFT, 18.0 + 20.0 * i as f32, 88.0, 20.0])
    // rust: .collect()
}
    /// `MerchantScreen.mouseDragged`: the held scroller follows the cursor.
    // rust: pub(super) fn merchant_drag(&mut self) {
    // rust: let Some(size) = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| [r.config.width, r.config.height])
    // rust: else {
    // rust: return;
}
    // rust: let (_, oy) = self.inventory_origin(&HudBatch::new(size));
    // rust: let y = self.cursor.1 - oy;
    // rust: if let Some(m) = self.station.as_mut().and_then(|s| s.merchant.as_mut())
    // rust: && m.dragging
    // rust: {
    // rust: m.scroll = drag_scroll(y, m.session.offers.len());
}
}
    // rust: pub(super) fn merchant_scroll(&mut self, d: f32) {
    // rust: let Some(m) = self.station.as_mut().and_then(|s| s.merchant.as_mut()) else {
    // rust: return;
}
    // rust: if m.session.offers.len() > 7 {
    // rust: let max = m.session.offers.len() - 7;
    // rust: m.scroll = scrolled(m.scroll, max, d);
}
}
    /// `MerchantScreen` rendering.
    // rust: pub(super) fn draw_merchant(&mut self, batch: &mut HudBatch) -> bool {
    // rust: let (ox, oy) = self.inventory_origin(batch);
    // rust: let local = (self.cursor.0 - ox, self.cursor.1 - oy);
    // rust: let Some(m) = self.station.as_ref().and_then(|s| s.merchant.as_ref()) else {
    // rust: return false;
}
    // rust: let (progress, custom) = (m.progress(), m.name.clone());
    // rust: let (profession, level, xp, scroll, shop, future, focused) = (
    // rust: m.session
    // rust: .profession
    // rust: .trim_start_matches("minecraft:")
    // rust: .to_owned(),
    // rust: m.session.level,
    // rust: m.session.xp,
    // rust: m.scroll,
    // rust: m.session.selection_hint,
    // rust: m.session.future_xp,
    // rust: m.focused,
    // rust: );
    // rust: let offers = m.session.offers.clone();
    // rust: let costs: Vec<ItemStack> = offers.iter().map(|o| o.cost_a(self.items())).collect();
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.fill(
    // rust: atlas,
    // rust: 0.0,
    // rust: 0.0,
    // rust: batch.width,
    // rust: batch.height,
    // rust: rgba(16, 16, 16, 160),
    // rust: );
    // rust: if let Some(mut r) = atlas.sprites.get("gui/container/villager").copied() {
    // rust: let (du, dv) = ((r.u1 - r.u0) / r.w as f32, (r.v1 - r.v0) / r.h as f32);
    // rust: r.u1 = r.u0 + 276.0 * du;
    // rust: r.v1 = r.v0 + 166.0 * dv;
    // rust: batch.rect_uv(ox + SHIFT, oy, 276.0, 166.0, r, u32::MAX);
}
    // rust: let tr = |k: &str, f: &str| horizon_client::lang::get_or(k, f);
    // rust: let name = custom.unwrap_or_else(|| {
    // rust: if progress {
    // rust: tr(
    // rust: &format!("entity.minecraft.villager.{profession}"),
    // rust: &profession,
    // rust: )
    // rust: } else {
    // rust: tr("entity.minecraft.wandering_trader", "Wandering Trader")
}
    // rust: });
        // The screen's title is the merchant's name; its label adds the level.
    // rust: super::screen_info::name_container(|| name.clone());
    // rust: let title = if progress {
    // rust: tr("merchant.title", "%s - %s")
    // rust: .replacen("%s", &name, 1)
    // rust: .replacen("%s", &tr(&format!("merchant.level.{level}"), ""), 1)
    // rust: } else {
    // rust: name
}
    // rust: let tw = HudBatch::text_width(atlas, &title);
    // rust: batch.text(
    // rust: atlas,
    // rust: &title,
    // rust: ox + SHIFT + (49.0 + 138.0 - (tw / 2.0).floor()),
    // rust: oy + 6.0,
    // rust: GREY,
    // rust: false,
    // rust: );
    // rust: let trades = tr("merchant.trades", "Trades");
    // rust: let tw = HudBatch::text_width(atlas, &trades);
    // rust: batch.text(
    // rust: atlas,
    // rust: &trades,
    // rust: ox + SHIFT + 5.0 - (tw / 2.0).floor() + 48.0,
    // rust: oy + 6.0,
    // rust: GREY,
    // rust: false,
    // rust: );
    // rust: batch.text(
    // rust: atlas,
    // rust: &tr("container.inventory", "Inventory"),
    // rust: ox + SHIFT + 107.0,
    // rust: oy + 72.0,
    // rust: GREY,
    // rust: false,
    // rust: );
    // rust: if offers.get(shop).is_some_and(MerchantOffer::out_of_stock) {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/villager/out_of_stock",
    // rust: ox + SHIFT + 182.0,
    // rust: oy + 35.0,
    // rust: );
}
        // Experience bar (levels 1-4).
    // rust: if progress && level < 5 {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/villager/experience_bar_background",
    // rust: ox + SHIFT + 136.0,
    // rust: oy + 16.0,
    // rust: );
    // rust: let min = merchant::min_xp(level);
    // rust: if xp >= min && merchant::can_level_up(level) {
    // rust: let mult = 102.0 / (merchant::max_xp(level) - min) as f32;
    // rust: let w = ((mult * (xp - min) as f32).floor()).min(102.0);
    // rust: batch.sprite_part(
    // rust: atlas,
    // rust: "gui/sprites/container/villager/experience_bar_current",
    // rust: ox + SHIFT + 136.0,
    // rust: oy + 16.0,
    // rust: w / 102.0,
    // rust: );
    // rust: if future > 0 {
    // rust: let fw = (future as f32 * mult).floor().min(102.0 - w);
    // rust: if let Some(mut r) = atlas
    // rust: .sprites
    // rust: .get("gui/sprites/container/villager/experience_bar_result")
    // rust: .copied()
    // rust: {
    // rust: let du = (r.u1 - r.u0) / r.w as f32;
    // rust: r.u0 += w * du;
    // rust: r.u1 = r.u0 + fw * du;
    // rust: batch.rect_uv(ox + SHIFT + 136.0 + w, oy + 16.0, fw, 5.0, r, u32::MAX);
}
}
}
}
        // Scroller.
    // rust: let steps = offers.len() as i32 + 1 - 7;
    // rust: if steps > 1 {
    // rust: let left = 139 - (27 + (steps - 1) * 139 / steps);
    // rust: let step = 1 + left / steps + 139 / steps;
    // rust: let mut y = (scroll as i32 * step).min(113);
    // rust: if scroll as i32 == steps - 1 {
    // rust: y = 113;
}
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/villager/scroller",
    // rust: ox + SHIFT + 94.0,
    // rust: oy + 18.0 + y as f32,
    // rust: );
    // rust: } else {
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/villager/scroller_disabled",
    // rust: ox + SHIFT + 94.0,
    // rust: oy + 18.0,
    // rust: );
}
        // Offer buttons.
    // rust: let mut tooltip: Option<ItemStack> = None;
    // rust: for (row, (index, offer)) in offers.iter().enumerate().skip(scroll).take(7).enumerate() {
    // rust: let (bx, by) = (ox + SHIFT + 5.0, oy + 18.0 + 20.0 * row as f32);
    // rust: let hover = local.0 >= 5.0 + SHIFT
    // rust: && local.0 < 93.0 + SHIFT
    // rust: && local.1 >= 18.0 + 20.0 * row as f32
    // rust: && local.1 < 38.0 + 20.0 * row as f32;
    // rust: let sprite = if hover || focused == Some(row) {
    // rust: "gui/sprites/widget/button_highlighted"
    // rust: } else {
    // rust: "gui/sprites/widget/button"
}
    // rust: batch.sprite_scaled(&self.gui.atlas, sprite, bx, by, 88.0, 20.0, u32::MAX);
    // rust: let y = oy + 16.0 + 1.0 + 20.0 * row as f32 + 2.0;
    // rust: let base = offer.base_cost_a.stack.clone();
    // rust: let cost_a = costs[index].clone();
    // rust: let x = ox + SHIFT + 10.0;
    // rust: if base.count == cost_a.count {
    // rust: self.draw_item(batch, &cost_a, x, y);
    // rust: } else {
                // Discounted: the base price struck through, then the new price.
    // rust: self.draw_item(
    // rust: batch,
    // rust: &ItemStack {
    // rust: count: 1,
    // rust: ..cost_a.clone()
    // rust: },
    // rust: x,
    // rust: y,
    // rust: );
    // rust: let atlas = &self.gui.atlas;
    // rust: let t = base.count.to_string();
    // rust: batch.text(
    // rust: atlas,
    // rust: &t,
    // rust: x + 17.0 - HudBatch::text_width(atlas, &t),
    // rust: y + 9.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: let t = cost_a.count.to_string();
    // rust: batch.text(
    // rust: atlas,
    // rust: &t,
    // rust: x + 14.0 + 17.0 - HudBatch::text_width(atlas, &t),
    // rust: y + 9.0,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
    // rust: batch.sprite(
    // rust: atlas,
    // rust: "gui/sprites/container/villager/discount_strikethrough",
    // rust: x + 7.0,
    // rust: y + 12.0,
    // rust: );
}
    // rust: if let Some(b) = offer.cost_b() {
    // rust: self.draw_item(batch, &b, ox + SHIFT + 40.0, y);
}
    // rust: let arrow = if offer.out_of_stock() {
    // rust: "trade_arrow_out_of_stock"
    // rust: } else {
    // rust: "trade_arrow"
}
    // rust: batch.sprite(
    // rust: &self.gui.atlas,
    // rust: &format!("gui/sprites/container/villager/{arrow}"),
    // rust: ox + SHIFT + 60.0,
    // rust: y + 3.0,
    // rust: );
    // rust: self.draw_item(batch, &offer.result, ox + SHIFT + 73.0, y);
    // rust: if hover && self.carried.is_none() {
    // rust: let rel = local.0 - (5.0 + SHIFT);
    // rust: tooltip = if rel < 20.0 {
    // rust: Some(cost_a)
    // rust: } else if rel > 30.0 && rel < 50.0 {
    // rust: offer.cost_b()
    // rust: } else if rel > 65.0 {
    // rust: Some(offer.result.clone())
    // rust: } else {
    // rust: None
}
}
}
        // Slots, hover highlight, carried stack, tooltip.
    // rust: let slots: Vec<usize> = (0..36).chain([INPUT, INPUT + 1, RESULT]).collect();
    // rust: let drag = self.drag_view();
    // rust: self.draw_hovered_slot_highlight(batch, false, ox, oy);
    // rust: for i in slots {
    // rust: let (sx, sy) = self.slot_position(i);
    // rust: let stack = self.slot_mut(i).clone();
    // rust: self.draw_slot_item(batch, drag.as_ref(), i, &stack, ox + sx, oy + sy);
}
    // rust: self.draw_hovered_slot_highlight(batch, true, ox, oy);
    // rust: if let Some(slot) = self.slot_at(batch, self.cursor.0, self.cursor.1)
    // rust: && tooltip.is_none()
    // rust: {
    // rust: tooltip = self.slot_mut(slot).clone();
}
        // An out-of-stock trade: "the villager needs to restock" over the
        // result (isHovering(186, 35, 22, 21), canRestock).
    // rust: let deprecated = progress
    // rust: && offers.get(shop).is_some_and(MerchantOffer::out_of_stock)
    // rust: && local.0 >= 186.0 + SHIFT - 1.0
    // rust: && local.0 < 186.0 + SHIFT + 22.0 + 1.0
    // rust: && local.1 >= 35.0 - 1.0
    // rust: && local.1 < 35.0 + 21.0 + 1.0;
    // rust: if self.carried.is_some() {
    // rust: self.draw_carried(batch);
    // rust: if let Some(stack) = tooltip.filter(|s| self.tooltip_with_carried(s)) {
    // rust: self.draw_stack_tooltip(batch, &stack, self.cursor.0, self.cursor.1);
}
    // rust: } else if deprecated {
    // rust: let text = horizon_client::lang::get_or(
    // rust: "merchant.deprecated",
    // rust: "Villagers restock up to two times per day.",
    // rust: );
    // rust: let lines: Vec<(String, u32)> =
    // rust: text.split('\n').map(|l| (l.to_owned(), u32::MAX)).collect();
    // rust: self.draw_tooltip_lines(batch, &lines, self.cursor.0, self.cursor.1);
    // rust: } else if let Some(stack) = tooltip {
    // rust: self.draw_stack_tooltip(batch, &stack, self.cursor.0, self.cursor.1);
}
    // rust: true
}
}

/// Whether a press at `local` (GUI origin relative) lands on the offer list's
/// scroller, which only takes it when there are more than 7 offers.
pub fn on_scroller(local: (f32) void {
}
    // rust: let x = SHIFT + 94.0;
    // rust: offers > 7
    // rust: && local.0 > x
    // rust: && local.0 < x + 6.0
    // rust: && local.1 > 18.0
    // rust: && local.1 <= 18.0 + 139.0 + 1.0
}
/// The first shown offer for the scroller dragged to `y` (GUI origin
/// relative): the 139-px track starts at 18 and the scroller is 27 px tall.
pub fn drag_scroll(y: f32, offers: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let max = offers.saturating_sub(7) as i32;
    // rust: let offs = (y - 18.0 - 13.5) / (139.0 - 27.0);
    // rust: ((offs * max as f32 + 0.5) as i32).clamp(0, max) as usize
}

/// `MerchantScreen.mouseScrolled`: `Mth.clamp((int)(scrollOff - scrollY), 0, max)`,
/// so a fractional wheel step that truncates to zero does not move the list.
pub fn scrolled(scroll: usize, max: usize, d: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((scroll as f64 - f64::from(d)) as i32).clamp(0, max as i32) as usize
}

    // rust: mod tests {
//     use super::*;

    /// `MerchantScreen.mouseScrolled`: the offset is `(int)(scrollOff - scrollY)`
    /// clamped, so the list moves by as many rows as the event's delta and a
    /// fractional delta still moves one row (the truncation is after the
    /// subtraction). Horizon moved exactly one row per event.
pub fn the_offers_scroll_by_the_wheel_delta() void {
}
    // rust: assert_eq!(scrolled(3, 5, 1.0), 2, "one notch down");
    // rust: assert_eq!(scrolled(3, 5, -1.0), 4, "one notch up");
    // rust: assert_eq!(scrolled(3, 5, 0.25), 2, "a fraction still moves a row");
    // rust: assert_eq!(scrolled(3, 5, 2.5), 0, "a two-and-a-half notch event");
    // rust: assert_eq!(scrolled(0, 5, 1.0), 0, "clamped at the top");
    // rust: assert_eq!(scrolled(5, 5, -1.0), 5, "clamped at the bottom");
}

pub fn scroller_takes_presses_only_with_more_than_seven_offers() void {
}
    // rust: let x = SHIFT + 97.0;
    // rust: assert!(on_scroller((x, 20.0), 8));
    // rust: assert!(!on_scroller((x, 20.0), 7));
        // The track's edges: x is exclusive both ways, y includes 158.
    // rust: assert!(!on_scroller((SHIFT + 94.0, 20.0), 8));
    // rust: assert!(!on_scroller((SHIFT + 100.0, 20.0), 8));
    // rust: assert!(!on_scroller((x, 18.0), 8));
    // rust: assert!(on_scroller((x, 158.0), 8));
    // rust: assert!(!on_scroller((x, 158.5), 8));
}
pub fn dragged_scroller_picks_the_nearest_offer() void {
}
        // 10 offers: the list scrolls 3 steps over the track's 112 px.
    // rust: assert_eq!(drag_scroll(0.0, 10), 0);
    // rust: assert_eq!(drag_scroll(31.5, 10), 0);
    // rust: assert_eq!(drag_scroll(31.5 + 112.0 / 2.0, 10), 2);
    // rust: assert_eq!(drag_scroll(31.5 + 112.0, 10), 3);
    // rust: assert_eq!(drag_scroll(500.0, 10), 3);
}
}
