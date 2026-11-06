//! Transpiled from Horizon Rust crate
package horizon_client_merchant

import "core:fmt"
import "core:mem"
import "core:math"

// Villager trading: the data-driven `trade_set` / `villager_trade` registries,
// offer generation (`AbstractVillager.addOffersFromTradeSet` with each
// set's `RandomSequence`), `MerchantOffer` pricing, demand and stock, and the
// `VillagerData` level thresholds. The villager entity itself is not part of
// this module; anything that can trade calls [`Merchant`].
// use crate::{
    // rust: enchant::Enchantments,
    // rust: items::{ItemStack, Items},
}
// use horizon_core::random::{RandomSource, XoroshiroRandom, mix_stafford13, seed_from_hash};
// use horizon_world::loot::PackOverlay;
// use serde_json::Value;
// use std::{collections::HashMap, path::Path, sync::Arc};

// `VillagerData.NEXT_LEVEL_XP_THRESHOLDS`.
LEVEL_XP :: [0, 10, 70, 150, 250]
can_level_up :: proc(level: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (1..5).contains(&level)
}
min_xp :: proc(level: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if can_level_up(level) {
    // rust: LEVEL_XP[level as usize - 1]
    // rust: } else {
    // rust: 0
}
}
max_xp :: proc(level: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if can_level_up(level) {
    // rust: LEVEL_XP[level as usize]
    // rust: } else {
    // rust: 0
}
}
// The professions with trades, as in `VillagerProfession`.
    // rust: pub const PROFESSIONS: &[&str] = &[
    // rust: "armorer",
    // rust: "butcher",
    // rust: "cartographer",
    // rust: "cleric",
    // rust: "farmer",
    // rust: "fisherman",
    // rust: "fletcher",
    // rust: "leatherworker",
    // rust: "librarian",
    // rust: "mason",
    // rust: "shepherd",
    // rust: "toolsmith",
    // rust: "weaponsmith",
    // rust: ];

// A villager's or wandering trader's trading state (`AbstractVillager.offers`
// and `Villager.villagerXp`); `None` on the mob until its offers are first asked for.
Trader :: struct {
    xp: i32,
    offers: [dynamic]MerchantOffer,
    // `lastRestockGameTime`, `numberOfRestocksToday` and `lastRestockCheckDay`.
    last_restock: i64,
    restocks_today: i32,
    check_day: i64,
    // The offers are not made yet (vanilla's `offers` is null): they are
    // generated when first asked for, keeping the experience.
    unset: bool,
}
    // rust: impl Trader {
update_demand :: proc(self: ^Self) {
}
    // rust: for o in &mut self.offers {
    // rust: o.update_demand();
}
}
    // `Villager.shouldRestock`.
should_restock :: proc(self: ^Self, game_time: i64, day: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut new_day = game_time > self.last_restock + 12000;
    // rust: new_day |= self.check_day > 0 && day > self.check_day;
    // rust: self.check_day = day;
    // rust: if new_day {
    // rust: self.last_restock = game_time;
            // resetNumberOfRestocks / catchUpDemand.
    // rust: let missed = 2 - self.restocks_today;
    // rust: if missed > 0 {
    // rust: for o in &mut self.offers {
    // rust: o.uses = 0;
}
}
    // rust: for _ in 0..missed {
    // rust: self.update_demand();
}
    // rust: self.restocks_today = 0;
}
    // rust: let allowed = self.restocks_today == 0
    // rust: || self.restocks_today < 2 && game_time > self.last_restock + 2400;
    // rust: allowed && self.offers.iter().any(|o| o.uses > 0)
}
    // `Villager.restock`.
restock :: proc(self: ^Self, game_time: i64) {
}
    // rust: self.update_demand();
    // rust: for o in &mut self.offers {
    // rust: o.uses = 0;
}
    // rust: self.last_restock = game_time;
    // rust: self.restocks_today += 1;
}
}

// `Villager.updateSpecialPrices`: the reputation and Hero of the Village
// discounts of a player, from scratch.
update_special_prices :: proc(offers: ^[MerchantOffer], reputation: i32, hero: Maybe(i32)) {
}
    // 0.3F + 0.0625F * amplifier, widened from float.
    // rust: let hero_modifier = hero.map_or(0.0, |a| f64::from(0.3f32 + 0.0625f32 * a as f32));
    // rust: for offer in offers {
    // rust: offer.special_price_diff = 0;
    // rust: if reputation != 0 {
    // rust: offer.special_price_diff -= (reputation as f32 * offer.price_multiplier).floor() as i32;
}
    // rust: if hero_modifier > 0.0 {
    // rust: let reduction =
    // rust: (hero_modifier * f64::from(offer.base_cost_a.stack.count)).floor() as i32;
    // rust: offer.special_price_diff -= reduction.max(1);
}
}
}
// An `ItemCost`: item and count (component predicates are not used by the
// 26.3 trade data except for one exact match, kept as the stack's data).
ItemCost :: struct {
    stack: ItemStack,
}
    // rust: impl ItemCost {
test :: proc(self: ^Self, s: ^ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: s.item == self.stack.item && (self.stack.extra.is_none() || s.data() == self.stack.data())
}
}
MerchantOffer :: struct {
    base_cost_a: ItemCost,
    cost_b: Maybe(ItemCost),
    result: ItemStack,
    uses: i32,
    max_uses: i32,
    reward_exp: bool,
    special_price_diff: i32,
    demand: i32,
    price_multiplier: f32,
    xp: i32,
}
    // rust: impl MerchantOffer {
max_stack :: proc(items: ^Items, s: ^ItemStack) -> u {
    // Ported from Horizon
    return {}
}
    // rust: items.get(&s.item).map_or(64, |i| i.max_stack)
}
    // `getModifiedCostCount` for cost A.
cost_a_count :: proc(self: ^Self, items: ^Items) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let base = self.base_cost_a.stack.count as i32;
        // Mth.floor(basePrice * demand * priceMultiplier): an int product, then the float.
    // rust: let demand_diff =
    // rust: ((base.wrapping_mul(self.demand) as f32 * self.price_multiplier).floor() as i32).max(0);
    // rust: (base + demand_diff + self.special_price_diff)
    // rust: .clamp(1, Self::max_stack(items, &self.base_cost_a.stack) as i32) as u32
}
cost_a :: proc(self: ^Self, items: ^Items) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemStack {
    // rust: count: self.cost_a_count(items),
    // rust: ..self.base_cost_a.stack.clone()
}
}
cost_b :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.cost_b.as_ref().map(|c| c.stack.clone())
}
out_of_stock :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.uses >= self.max_uses
}
    // `MerchantOffer.updateDemand` (on restock).
update_demand :: proc(self: ^Self) {
}
    // rust: self.demand = self.demand + self.uses - (self.max_uses - self.uses);
}
    // `satisfiedBy(buyA, buyB)`.
    // rust: pub fn satisfied_by(
    // rust: &self,
    // rust: items: &Items,
    // rust: a: Option<&ItemStack>,
    // rust: b: Option<&ItemStack>,
    // rust: ) -> bool {
    // rust: let Some(a) = a else { return false };
    // rust: if !self.base_cost_a.test(a) || a.count < self.cost_a_count(items) {
    // rust: return false;
}
    // rust: match (&self.cost_b, b) {
    // rust: (None, b) => b.is_none(),
    // rust: (Some(c), Some(b)) => c.test(b) && b.count >= c.stack.count,
    // rust: (Some(_), None) => false,
}
}
    // `MerchantOffer.take`: consume the payment; false when not satisfied.
    // rust: pub fn take(
    // rust: &self,
    // rust: items: &Items,
    // rust: a: &mut Option<ItemStack>,
    // rust: b: &mut Option<ItemStack>,
    // rust: ) -> bool {
    // rust: if !self.satisfied_by(items, a.as_ref(), b.as_ref()) {
    // rust: return false;
}
    // rust: let n = self.cost_a_count(items);
    // rust: if let Some(s) = a.as_mut() {
    // rust: s.count -= n;
    // rust: if s.count == 0 {
    // rust: *a = None;
}
}
    // rust: if let (Some(c), Some(s)) = (&self.cost_b, b.as_mut()) {
    // rust: s.count -= c.stack.count;
    // rust: if s.count == 0 {
    // rust: *b = None;
}
}
    // rust: true
}
}
// `MerchantOffers.getRecipeFor`: a hint past the first offer names the only
// offer that may match; otherwise the first offer that fits.
    // rust: pub fn recipe_for(
    // rust: offers: &[MerchantOffer],
    // rust: items: &Items,
    // rust: a: Option<&ItemStack>,
    // rust: b: Option<&ItemStack>,
    // rust: hint: Option<usize>,
    // rust: ) -> Option<usize> {
    // rust: if let Some(h) = hint
    // rust: && h > 0
    // rust: && h < offers.len()
    // rust: {
    // rust: return offers[h].satisfied_by(items, a, b).then_some(h);
}
    // rust: offers.iter().position(|o| o.satisfied_by(items, a, b))
}
// `MerchantContainer.updateSellItem`: (active offer, result).
    // rust: pub fn sell_item(
    // rust: offers: &[MerchantOffer],
    // rust: items: &Items,
    // rust: a: Option<&ItemStack>,
    // rust: b: Option<&ItemStack>,
    // rust: hint: Option<usize>,
    // rust: ) -> (Option<usize>, Option<ItemStack>) {
    // rust: let (a, b) = if a.is_none() { (b, None) } else { (a, b) };
    // rust: if a.is_none() {
    // rust: return (None, None);
}
    // rust: let mut found = recipe_for(offers, items, a, b, hint);
    // rust: let mut active = found;
    // rust: if found.is_none_or(|i| offers[i].out_of_stock()) {
    // rust: active = found;
    // rust: found = recipe_for(offers, items, b, a, hint);
}
    // rust: match found {
    // rust: Some(i) if !offers[i].out_of_stock() => (Some(i), Some(offers[i].result.clone())),
    // rust: _ => (active, None),
}
}

// `RandomSequence(worldSeed ^ salt, id)` with the default salt 0.
sequence_random :: proc(world_seed: i64, id: string) -> X {
    // Ported from Horizon
    return {}
}
SILVER :: 0x6a09_e667_f3bc_c909
GOLDEN :: 0x9e37_79b9_7f4a_7c15
    // rust: let lo = world_seed as u64 ^ SILVER;
    // rust: let hi = lo.wrapping_add(GOLDEN);
    // rust: let key = seed_from_hash(id);
    // rust: XoroshiroRandom::from_state(mix_stafford13(lo ^ key[0]), mix_stafford13(hi ^ key[1]))
}

// What a trade screen's session changes besides the menu, for the caller.
Event :: enum {
    // An experience orb of this value at the merchant (`rewardTradeXp`).
    Orb(i32),
    // The villager reached this level (regeneration for 200 ticks).
    LevelUp(i32),
    // `notifyTradeUpdated`: the merchant says yes (a result) or no, at
    // this pitch.
    TradeUpdated(bool, f32),
    // `MerchantMenu.playTradeSound` (a shift-clicked trade).
    TradeSound,
    // A trade of this offer was made (`notifyTrade`), with the offer as
    // it was right after that trade's use (before a level-up's prices).
    Traded(usize, Box<MerchantOffer>),
}
// What the world lends a trading session for offers made while it is open.
TradeEnv :: struct {
    trades: ^'a Trades,
    enchantments: ^'a Enchantments,
    maps: Maybe(^'a dyn MapMaker),
}
// The merchant side of an open trading screen: `AbstractVillager` /
// `Villager` / `WanderingTrader` as `MerchantMenu` sees it (offers,
// experience, level-ups, special prices for the trading player) and the
// `MerchantContainer` state (selection hint, active offer, future xp).
Session :: struct {
    offers: [dynamic]MerchantOffer,
    xp: i32,
    level: i32,
    // A villager (progress bar, restocks, level-ups), not a wandering trader.
    villager: bool,
    // `minecraft:` ids of the profession and villager type.
    profession: string,
    variant: string,
    // The merchant's own random (`rewardTradeXp`).
    random: horizon_core::random::LegacyRandom,
    origin: [f64,
    // The trading player's reputation and Hero of the Village amplifier.
    reputation: i32,
    hero: Maybe(i32),
    // Trade set sequences the session may draw from (the next levels'), lent
    // by the world's `RandomSequences` and given back when it closes.
    sequences: std::collections::BTreeMap<string,
    selection_hint: uint,
    active: Maybe(uint),
    future_xp: i32,
    // `Mob.ambientSoundTime`.
    ambient_sound_time: i32,
    // `Villager.lastTradedPlayer` is set: the TRADE reputation event is due.
    last_traded: bool,
    events: [dynamic]Event,
}
    // rust: impl Session {
new :: proc(offers: [dynamic]MerchantOffer, villager: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: offers,
    // rust: xp: 0,
    // rust: level: 1,
    // rust: villager,
    // rust: profession: String::new(),
    // rust: variant: "minecraft:plains".into(),
    // rust: random: horizon_core::random::LegacyRandom::new(0),
    // rust: origin: [0.0; 3],
    // rust: reputation: 0,
    // rust: hero: None,
    // rust: sequences: Default::default(),
    // rust: selection_hint: 0,
    // rust: active: None,
    // rust: future_xp: 0,
    // rust: ambient_sound_time: 0,
    // rust: last_traded: false,
    // rust: events: Vec::new(),
}
}
    // `Merchant.showProgressBar` / `canRestock`.
show_progress :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.villager
}
    // The trade sets whose sequences a villager of `profession` at `level`
    // may draw while trading: those of the levels above it.
sequences_needed :: proc(trades: ^Trades, profession: string, level: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (level + 1..=5)
    // rust: .filter_map(|l| trades.sequence(&Trades::set_for(profession, l)))
    // rust: .collect()
}
    // `Villager.updateSpecialPrices` for the trading player.
update_special_prices :: proc(self: ^Self) {
}
    // rust: if self.villager {
    // rust: update_special_prices(&mut self.offers, self.reputation, self.hero);
}
}
    // `AbstractVillager.notifyTrade`: the offer's use, then `rewardTradeXp`
    // (and a level-up with its offers). True when the special prices were
    // recomputed (the menu then updates its result).
    // rust: pub fn notify_trade(
    // rust: &mut self,
    // rust: index: usize,
    // rust: env: Option<&TradeEnv<'_>>,
    // rust: items: &Items,
    // rust: ) -> bool {
    // rust: let Some(offer) = self.offers.get_mut(index) else {
    // rust: return false;
}
    // rust: offer.uses += 1;
    // rust: let offer = offer.clone();
    // rust: self.ambient_sound_time = -80;
    // rust: self.events
    // rust: .push(Event::Traded(index, Box::new(offer.clone())));
    // rust: let mut prices = false;
    // rust: if self.villager {
    // rust: let mut pop = 3 + self.random.next_int_bound(4).unwrap_or(0);
    // rust: self.xp += offer.xp;
    // rust: self.last_traded = true;
    // rust: if can_level_up(self.level) && self.xp >= max_xp(self.level) {
    // rust: self.level += 1;
    // rust: if let Some(env) = env {
    // rust: let set = Trades::set_for(&self.profession, self.level);
    // rust: if env.trades.sets.contains_key(&set) {
    // rust: let more = self.offers_from_set(env, items, &set);
    // rust: self.offers.extend(more);
    // rust: self.update_special_prices();
    // rust: prices = true;
}
}
    // rust: self.events.push(Event::LevelUp(self.level));
    // rust: pop += 5;
}
    // rust: if offer.reward_exp {
    // rust: self.events.push(Event::Orb(pop));
}
    // rust: } else if offer.reward_exp {
    // rust: let pop = 3 + self.random.next_int_bound(4).unwrap_or(0);
    // rust: self.events.push(Event::Orb(pop));
}
    // rust: prices
}
    // rust: fn offers_from_set(
    // rust: &mut self,
    // rust: env: &TradeEnv<'_>,
    // rust: items: &Items,
    // rust: set: &str,
    // rust: ) -> Vec<MerchantOffer> {
    // rust: let Some(sequence) = env.trades.sequence(set) else {
    // rust: return Vec::new();
}
    // rust: let Some(mut random) = self.sequences.remove(&sequence) else {
    // rust: return Vec::new();
}
    // rust: let ctx = TradeContext {
    // rust: items,
    // rust: enchantments: env.enchantments,
    // rust: variant: &self.variant,
    // rust: origin: self.origin,
    // rust: maps: env.maps,
}
    // rust: let out = env.trades.offers_from_set(&ctx, set, &mut random);
    // rust: self.sequences.insert(sequence, random);
    // rust: out
}
    // `AbstractVillager.notifyTradeUpdated`.
notify_trade_updated :: proc(self: ^Self, has_result: bool) {
}
    // rust: if self.ambient_sound_time > -80 + 20 {
    // rust: self.ambient_sound_time = -80;
    // rust: let pitch = self.voice_pitch();
    // rust: self.events.push(Event::TradeUpdated(has_result, pitch));
}
}
    // `LivingEntity.getVoicePitch` of an adult merchant.
voice_pitch :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (self.random.next_float() - self.random.next_float()) * 0.2 + 1.0
}
}

// The trade registries.
Trades :: struct {
    trades: HashMap<string,
    // villager_trade tags, ordered.
    tags: HashMap<string,
    sets: HashMap<string,
    // potion tags, ordered (`set_random_potion` options).
    potion_tags: HashMap<string,
}
// The `.json` files under `dir` as `minecraft:<path>` ids, through `json_folder` (from the
// prepared data file when there is one); a file that doesn't parse is left out.
walk :: proc(dir: ^Path, out: ^HashMap<string) {
}
    // rust: let Ok(folder) = horizon_world::json_folder::read(dir) else {
    // rust: return;
}
    // rust: for file in &folder.files {
    // rust: if let Ok(value) = serde_json::from_slice(file.bytes().unwrap_or_default()) {
    // rust: out.insert(format!("minecraft:{}", file.name), value);
}
}
}
    // rust: impl Trades {
    // Load from a resource root; `overlay` (the world's data packs'
    // content files) merges over it, the way a pack stack layers
    // (`SimpleJsonResourceReloadListener`, `TagLoader`).
load :: proc(root: ^Path, overlay: ^horizon_world::loot::PackOverlay) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let data = root.join("data/minecraft");
    // rust: let (mut trades, mut raw_tags, mut sets) = (HashMap::new(), HashMap::new(), HashMap::new());
    // rust: walk(&data.join("villager_trade"), &mut trades);
    // rust: walk(&data.join("tags/villager_trade"), &mut raw_tags);
    // rust: walk(&data.join("trade_set"), &mut sets);
    // rust: let mut raw_potions = HashMap::new();
    // rust: walk(&data.join("tags/potion"), &mut raw_potions);
        // The packs' trade files: a trade or set's top pack file replaces
        // the game's own (`SimpleJsonResourceReloadListener` sees one
        // resource per id), a tag's entries join in pack order with a
        // `replace` file dropping the lower sources' (`TagLoader.load`).
    // rust: for (id, files) in overlay.kind("villager_trade") {
    // rust: if let Ok(v) = serde_json::from_slice(PackOverlay::top(files)) {
    // rust: trades.insert(id.to_owned(), v);
}
}
    // rust: for (id, files) in overlay.kind("trade_set") {
    // rust: if let Ok(v) = serde_json::from_slice(PackOverlay::top(files)) {
    // rust: sets.insert(id.to_owned(), v);
}
}
    // rust: let values = |v: Value| -> Vec<String> {
    // rust: v["values"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| e.as_str().map(str::to_owned))
    // rust: .collect()
}
    // rust: let mut raw_potions: HashMap<String, Vec<String>> = raw_potions
    // rust: .into_iter()
    // rust: .map(|(k, v)| (k, values(v)))
    // rust: .collect();
    // rust: let mut raw: HashMap<String, Vec<String>> = raw_tags
    // rust: .into_iter()
    // rust: .map(|(k, v)| {
    // rust: (
    // rust: k,
    // rust: v["values"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| e.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: for (registry, raw) in [("villager_trade", &mut raw), ("potion", &mut raw_potions)] {
    // rust: for (id, files) in overlay.tag_kind(registry) {
    // rust: let slot = raw.entry(id).or_default();
    // rust: for bytes in files {
    // rust: let Ok(v) = serde_json::from_slice::<Value>(bytes) else {
    // rust: continue;
}
    // rust: if v["replace"].as_bool() == Some(true) {
    // rust: slot.clear();
}
    // rust: if let Some(vs) = v["values"].as_array() {
    // rust: slot.extend(vs.iter().filter_map(|e| e.as_str().map(str::to_owned)));
}
}
}
}
    // rust: fn expand(
    // rust: name: &str,
    // rust: raw: &HashMap<String, Vec<String>>,
    // rust: out: &mut Vec<String>,
    // rust: depth: u32,
    // rust: ) {
    // rust: for v in raw.get(name).into_iter().flatten() {
    // rust: match v.strip_prefix('#') {
    // rust: Some(t) if depth < 16 => expand(t, raw, out, depth + 1),
    // rust: Some(_) => {}
    // rust: None if !out.contains(v) => out.push(v.clone()),
    // rust: None => {}
}
}
}
    // rust: let expand_all = |raw: &HashMap<String, Vec<String>>| {
    // rust: raw.keys()
    // rust: .map(|k| {
    // rust: let mut v = Vec::new();
    // rust: expand(k, raw, &mut v, 0);
    // rust: (k.clone(), v)
    // rust: })
    // rust: .collect()
}
    // rust: Self {
    // rust: trades,
    // rust: tags: expand_all(&raw),
    // rust: sets,
    // rust: potion_tags: expand_all(&raw_potions),
}
}
    // The random sequence of a trade set (`TradeSet.randomSequence`).
sequence :: proc(self: ^Self, set_id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.sets
    // rust: .get(set_id)?
    // rust: .get("random_sequence")?
    // rust: .as_str()
    // rust: .map(str::to_owned)
}
    // Every trade set's random sequence, sorted.
sequences :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut v: Vec<String> = self.sets.keys().filter_map(|k| self.sequence(k)).collect();
    // rust: v.sort();
    // rust: v
}
    // `VillagerProfession.getTrades(level)`.
set_for :: proc(profession: string, level: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "minecraft:{}/level_{level}",
    // rust: profession.trim_start_matches("minecraft:")
    // rust: )
}
trade_list :: proc(self: ^Self, spec: ^Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match spec {
    // rust: Value::String(s) => match s.strip_prefix('#') {
    // rust: Some(tag) => self.tags.get(tag).cloned().unwrap_or_default(),
    // rust: None => vec![s.clone()],
    // rust: },
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|v| v.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: _ => vec![],
}
}
    // `AbstractVillager.addOffersFromTradeSet`.
    // rust: pub fn offers_from_set<R: RandomSource>(
    // rust: &self,
    // rust: ctx: &TradeContext<'_>,
    // rust: set_id: &str,
    // rust: random: &mut R,
    // rust: ) -> Vec<MerchantOffer> {
    // rust: let Some(set) = self.sets.get(set_id) else {
    // rust: return vec![];
}
    // rust: let mut potential = self.trade_list(&set["trades"]);
    // rust: let amount = int_provider(&set["amount"], random);
    // rust: let duplicates = set["allow_duplicates"].as_bool().unwrap_or(false);
    // rust: let mut out = Vec::new();
    // rust: while (out.len() as i32) < amount && !potential.is_empty() {
    // rust: let roll = random.next_int_bound(potential.len() as i32).unwrap_or(0) as usize;
    // rust: let id = if duplicates {
    // rust: potential[roll].clone()
    // rust: } else {
    // rust: potential.remove(roll)
}
    // rust: match self
    // rust: .trades
    // rust: .get(&id)
    // rust: .and_then(|t| self.offer_from(ctx, t, random))
    // rust: {
    // rust: Some(o) => out.push(o),
    // rust: None if duplicates => {
    // rust: potential.remove(roll);
}
    // rust: None => {}
}
}
    // rust: out
}
}
// What a villager trade's loot context provides.
TradeContext :: struct {
    items: ^'a Items,
    enchantments: ^'a Enchantments,
    // Villager type (`minecraft:plains`, ...), for `merchant_predicate`.
    variant: ^'a str,
    // The merchant's position (the loot context's origin).
    origin: [f64,
    // Finds structures for exploration maps; None finds nothing.
    maps: Maybe(^'a dyn MapMaker),
}
// `ExplorationMapFunction`: `ServerLevel.findNearestMapStructure` and the
// map it makes, for the world the merchant is in.
    // rust: pub trait MapMaker {
    // The map for the nearest structure in `destination` (a structure tag)
    // within `radius` chunks of `origin`, or the stack unchanged when none is
    // found.
    // rust: fn exploration_map(
    // rust: &self,
    // rust: stack: ItemStack,
    // rust: map: &ExplorationMap,
    // rust: origin: [f64; 3],
    // rust: ) -> ItemStack;
}
// An `exploration_map` function's settings.
    // rust: pub use horizon_world::loot::ExplorationMap;
    // rust: fn int_provider<R: RandomSource>(v: &Value, random: &mut R) -> i32 {
    // rust: match v {
    // rust: Value::Number(n) => n.as_i64().unwrap_or(0) as i32,
    // rust: Value::Object(o) => match o.get("type").and_then(Value::as_str).unwrap_or("") {
    // rust: "minecraft:uniform" => {
    // rust: let (min, max) = (
    // rust: o["min"].as_i64().unwrap_or(0) as i32,
    // rust: o["max"].as_i64().unwrap_or(0) as i32,
    // rust: );
    // rust: if min >= max {
    // rust: min
    // rust: } else {
    // rust: min + random.next_int_bound(max - min + 1).unwrap_or(0)
}
}
    // rust: "minecraft:constant" => o["value"].as_i64().unwrap_or(0) as i32,
            // Sum: inputs in order, summed in a long and clamped.
    // rust: "minecraft:add" => {
    // rust: let mut total = 0i64;
    // rust: for input in o["inputs"].as_array().into_iter().flatten() {
    // rust: total += i64::from(int_provider(input, random));
}
    // rust: total.clamp(i64::from(i32::MIN), i64::from(i32::MAX)) as i32
}
    // rust: "minecraft:binomial" => {
    // rust: let n = int_provider(&o["n"], random);
    // rust: let p = float_provider(&o["p"], random);
    // rust: (0..n).filter(|_| random.next_float() < p).count() as i32
}
    // rust: _ => o.get("value").and_then(Value::as_i64).unwrap_or(0) as i32,
    // rust: },
    // rust: _ => 0,
}
}
    // rust: fn float_provider<R: RandomSource>(v: &Value, random: &mut R) -> f32 {
    // rust: match v {
    // rust: Value::Number(n) => n.as_f64().unwrap_or(0.0) as f32,
    // rust: Value::Object(o) => match o.get("type").and_then(Value::as_str).unwrap_or("") {
    // rust: "minecraft:uniform" => {
    // rust: let min = float_provider(&o["min"], random);
    // rust: let max = float_provider(&o["max"], random);
                // Mth.randomBetween
    // rust: random.next_float() * (max - min) + min
}
    // rust: _ => o.get("value").and_then(Value::as_f64).unwrap_or(0.0) as f32,
    // rust: },
    // rust: _ => 0.0,
}
}
// `MobEffect.isInstantaneous`.
instantaneous :: proc(effect: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: effect,
    // rust: "minecraft:saturation" | "minecraft:instant_health" | "minecraft:instant_damage"
    // rust: )
}
cost :: proc(items: ^Items, v: ^Value, additional: i32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let id = v["id"].as_str().unwrap_or("minecraft:air");
    // rust: let max = items.get(id).map_or(64, |i| i.max_stack) as i32;
    // rust: let count = (v["count"].as_i64().unwrap_or(1) as i32 + additional).clamp(0, max);
    // rust: let mut stack = ItemStack::new(id, count as u32);
    // rust: if let Some(potion) = v["components"]["minecraft:potion_contents"]["potion"].as_str() {
    // rust: stack = stack.with_potion(potion);
}
    // rust: ItemCost { stack }
}
variant_ok :: proc(pred: ^Value, variant: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match &pred["predicate"]["minecraft:predicates"]["minecraft:villager/variant"] {
    // rust: Value::String(s) => s == variant,
    // rust: Value::Array(a) => a.iter().any(|x| x.as_str() == Some(variant)),
    // rust: _ => true,
}
}
    // rust: impl Trades {
    // `VillagerTrade.getOffer`.
    // rust: pub fn offer_from<R: RandomSource>(
    // rust: &self,
    // rust: ctx: &TradeContext<'_>,
    // rust: t: &Value,
    // rust: random: &mut R,
    // rust: ) -> Option<MerchantOffer> {
    // rust: if let Some(p) = t.get("merchant_predicate")
    // rust: && !variant_ok(p, ctx.variant)
    // rust: {
    // rust: return None;
}
    // rust: let gives = &t["gives"];
    // rust: let mut result = ItemStack::new(
    // rust: gives["id"].as_str()?,
    // rust: gives["count"].as_u64().unwrap_or(1) as u32,
    // rust: );
    // rust: let mut additional = 0;
    // rust: let modifiers: Vec<&Value> = match &t["given_item_modifier"] {
    // rust: Value::Array(a) => a.iter().collect(),
    // rust: v @ Value::Object(_) => vec![v],
    // rust: _ => vec![],
}
    // rust: for m in modifiers {
    // rust: let (stack, extra) = self.apply_modifier(ctx, m, result, random)?;
    // rust: result = stack;
    // rust: additional += extra;
}
    // rust: if let Some(Value::String(tag)) = t.get("double_trade_price_enchantments")
    // rust: && result
    // rust: .stored_enchantments()
    // rust: .iter()
    // rust: .any(|(e, _)| ctx.enchantments.in_tag(tag, e))
    // rust: {
    // rust: additional *= 2;
}
    // rust: let a = cost(ctx.items, &t["wants"], additional);
    // rust: if a.stack.count < 1 {
    // rust: return None;
}
    // rust: let b = t.get("additional_wants").map(|w| cost(ctx.items, w, 0));
    // rust: if b.as_ref().is_some_and(|b| b.stack.count < 1) {
    // rust: return None;
}
    // rust: let max_uses = match t.get("max_uses") {
    // rust: Some(v) => int_provider(v, random),
    // rust: None => 4,
}
    // rust: let xp = match t.get("xp") {
    // rust: Some(v) => int_provider(v, random),
    // rust: None => 1,
}
    // rust: let discount = match t.get("reputation_discount") {
    // rust: Some(v) => float_provider(v, random),
    // rust: None => 0.0,
}
    // rust: Some(MerchantOffer {
    // rust: base_cost_a: a,
    // rust: cost_b: b,
    // rust: result,
    // rust: uses: 0,
    // rust: max_uses: max_uses.max(1),
    // rust: reward_exp: true,
    // rust: special_price_diff: 0,
    // rust: demand: 0,
    // rust: price_multiplier: discount.max(0.0),
    // rust: xp: xp.max(0),
    // rust: })
}
    // The loot functions trades use; None discards the offer.
    // rust: fn apply_modifier<R: RandomSource>(
    // rust: &self,
    // rust: ctx: &TradeContext<'_>,
    // rust: m: &Value,
    // rust: stack: ItemStack,
    // rust: random: &mut R,
    // rust: ) -> Option<(ItemStack, i32)> {
    // rust: let e = ctx.enchantments;
    // rust: let pool = |options: &Value| -> Vec<Arc<str>> {
    // rust: match options {
    // rust: Value::String(s) if s.starts_with('#') => e.tag(s).to_vec(),
    // rust: Value::String(s) => vec![Arc::from(s.as_str())],
    // rust: Value::Array(a) => a.iter().filter_map(|x| x.as_str().map(Arc::from)).collect(),
    // rust: _ => e.list.iter().map(|x| x.id.clone()).collect(),
}
}
    // rust: match m["type"].as_str().or(m["function"].as_str()).unwrap_or("") {
    // rust: "minecraft:enchant_with_levels" => {
    // rust: let levels = int_provider(&m["levels"], random);
                // EnchantmentHelper.enchantItem on the loot context's random.
    // rust: let chosen = e.select(ctx.items, random, &stack.item, levels, &pool(&m["options"]));
    // rust: let mut out = if &*stack.item == "minecraft:book" {
    // rust: ItemStack::new("minecraft:enchanted_book", stack.count)
    // rust: } else {
    // rust: stack
}
    // rust: for (id, l) in chosen {
    // rust: out.enchant(&id, l);
}
    // rust: let extra = if m["include_additional_cost_component"]
    // rust: .as_bool()
    // rust: .unwrap_or(false)
    // rust: && levels > 0
    // rust: {
    // rust: levels
    // rust: } else {
    // rust: 0
}
    // rust: Some((out, extra))
}
    // rust: "minecraft:enchant_randomly" => {
    // rust: let book = &*stack.item == "minecraft:book";
    // rust: let only_compatible = m["only_compatible"].as_bool().unwrap_or(true);
    // rust: let options: Vec<Arc<str>> = pool(&m["options"])
    // rust: .into_iter()
    // rust: .filter(|id| {
    // rust: book || !only_compatible || e.can_enchant(ctx.items, id, &stack.item)
    // rust: })
    // rust: .collect();
    // rust: if options.is_empty() {
    // rust: return Some((stack, 0));
}
    // rust: let id = options[random.next_int_bound(options.len() as i32).unwrap_or(0) as usize]
    // rust: .clone();
    // rust: let max = e.get(&id).map_or(1, |d| d.max_level) as i32;
    // rust: let level = if max <= 1 {
    // rust: 1
    // rust: } else {
    // rust: 1 + random.next_int_bound(max).unwrap_or(0)
}
    // rust: let mut out = if book {
    // rust: ItemStack::new("minecraft:enchanted_book", 1)
    // rust: } else {
    // rust: stack
}
    // rust: out.enchant(&id, level as u32);
    // rust: let extra = if m["include_additional_cost_component"]
    // rust: .as_bool()
    // rust: .unwrap_or(false)
    // rust: {
    // rust: 2 + random.next_int_bound(5 + level * 10).unwrap_or(0) + 3 * level
    // rust: } else {
    // rust: 0
}
    // rust: Some((out, extra))
}
    // rust: "minecraft:filtered" => {
    // rust: let filter = &m["item_filter"];
    // rust: let item_ok = filter["items"].as_str().is_none_or(|i| i == &*stack.item);
    // rust: let needs = |key: &str, have: bool| filter["predicates"].get(key).is_none() || have;
    // rust: let data = stack.data();
    // rust: let ok = item_ok
    // rust: && needs("minecraft:enchantments", !stack.enchantments().is_empty())
    // rust: && needs(
    // rust: "minecraft:stored_enchantments",
    // rust: !stack.stored_enchantments().is_empty(),
    // rust: )
    // rust: && needs(
    // rust: "minecraft:dyed_color",
    // rust: data.is_some_and(|d| d.dyed_color.is_some()),
    // rust: )
    // rust: && needs("minecraft:map_id", data.is_some_and(|d| d.map_id.is_some()));
    // rust: if ok {
    // rust: Some((stack, 0))
    // rust: } else if m["on_fail"]["type"] == "minecraft:discard" {
    // rust: None
    // rust: } else {
    // rust: Some((stack, 0))
}
}
    // rust: "minecraft:set_potion" => Some((
    // rust: stack.with_potion(m["id"].as_str().unwrap_or("minecraft:water")),
    // rust: 0,
    // rust: )),
    // rust: "minecraft:discard" => None,
    // rust: "minecraft:set_random_dyes" => {
    // rust: let rolls = int_provider(&m["number_of_dyes"], random);
    // rust: if rolls <= 0 {
    // rust: return Some((stack, 0));
}
    // rust: let dyes: Vec<usize> = (0..rolls)
    // rust: .map(|_| random.next_int_bound(16).unwrap_or(0) as usize)
    // rust: .collect();
                // DyedItemColor.applyDyes: one item, the colours mixed in.
    // rust: let current = stack.data().and_then(|d| d.dyed_color);
    // rust: let mut out = ItemStack { count: 1, ..stack };
    // rust: out.data_mut().dyed_color = Some(crate::crafting::apply_dyes(current, &dyes));
    // rust: Some((out, 0))
}
    // rust: "minecraft:set_random_potion" => {
    // rust: let options: Vec<String> = match &m["options"] {
    // rust: Value::String(s) => match s.strip_prefix('#') {
    // rust: Some(tag) => self.potion_tags.get(tag).cloned().unwrap_or_default(),
    // rust: None => vec![s.clone()],
    // rust: },
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|v| v.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: _ => vec![],
}
    // rust: if options.is_empty() {
    // rust: return Some((stack, 0));
}
    // rust: let pick = random.next_int_bound(options.len() as i32).unwrap_or(0) as usize;
    // rust: Some((stack.with_potion(&options[pick]), 0))
}
    // rust: "minecraft:set_stew_effect" => {
    // rust: let effects = m["effects"].as_array().cloned().unwrap_or_default();
    // rust: if &*stack.item != "minecraft:suspicious_stew" || effects.is_empty() {
    // rust: return Some((stack, 0));
}
    // rust: let entry =
    // rust: &effects[random.next_int_bound(effects.len() as i32).unwrap_or(0) as usize];
    // rust: let effect = entry["type"].as_str().unwrap_or("").to_owned();
    // rust: let mut duration = int_provider(&entry["duration"], random);
    // rust: if !instantaneous(&effect) {
    // rust: duration *= 20;
}
    // rust: let mut out = stack;
    // rust: let d = out.data_mut();
                // SuspiciousStewEffects.withEffectAdded
    // rust: d.stew_effects.push((Arc::from(effect.as_str()), duration));
    // rust: Some((out, 0))
}
    // rust: "minecraft:exploration_map" => {
    // rust: let Some(maps) = ctx.maps else {
    // rust: return Some((stack, 0));
}
    // rust: let map = ExplorationMap::from_json(m);
    // rust: Some((maps.exploration_map(stack, &map, ctx.origin), 0))
}
    // rust: _ => Some((stack, 0)),
}
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

items :: proc() -> I {
    // Ported from Horizon
    return {}
}
    // rust: Items::for_tests(HashMap::new())
}
offer :: proc(cost: u32, b: Maybe(u32)) -> M {
    // Ported from Horizon
    return {}
}
    // rust: MerchantOffer {
    // rust: base_cost_a: ItemCost {
    // rust: stack: ItemStack::new("minecraft:emerald", cost),
    // rust: },
    // rust: cost_b: b.map(|n| ItemCost {
    // rust: stack: ItemStack::new("minecraft:book", n),
    // rust: }),
    // rust: result: ItemStack::new("minecraft:iron_boots", 1),
    // rust: uses: 0,
    // rust: max_uses: 12,
    // rust: reward_exp: true,
    // rust: special_price_diff: 0,
    // rust: demand: 0,
    // rust: price_multiplier: 0.2,
    // rust: xp: 1,
}
}

    // A shift-click trades several times in one session: each `Traded`
    // event keeps the offer as it was right after its own trade, which is
    // what the mods hear (`TradeWithVillagerEvent` per `onTake`).
each_trade_event_keeps_its_own_offer :: proc() {
}
    // rust: let items = items();
    // rust: let mut s = Session::new(vec![offer(4, None), offer(2, None)], false);
    // rust: s.notify_trade(1, None, &items);
    // rust: s.notify_trade(1, None, &items);
    // rust: s.notify_trade(0, None, &items);
    // rust: let seen: Vec<_> = s
    // rust: .events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: Event::Traded(i, o) => Some((*i, o.uses, o.base_cost_a.stack.count)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(seen, [(1, 1, 2), (1, 2, 2), (0, 1, 4)]);
    // rust: assert_eq!((s.offers[0].uses, s.offers[1].uses), (1, 2));
}

demand_raises_prices :: proc() {
}
    // rust: let items = items();
    // rust: let mut o = offer(4, None);
    // rust: assert_eq!(o.cost_a_count(&items), 4);
    // rust: o.uses = 12;
    // rust: o.update_demand();
    // rust: assert_eq!(o.demand, 12);
        // 4 + floor(4 * 12 * 0.2) = 13.
    // rust: assert_eq!(o.cost_a_count(&items), 13);
    // rust: o.special_price_diff = -20;
    // rust: assert_eq!(o.cost_a_count(&items), 1);
}

restocks_twice_a_day :: proc() {
}
    // rust: let mut t = Trader {
    // rust: offers: vec![offer(4, None)],
    // rust: ..Default::default()
}
    // rust: assert!(!t.should_restock(100, 0), "nothing used yet");
    // rust: t.offers[0].uses = 12;
    // rust: assert!(t.should_restock(100, 0));
    // rust: t.restock(100);
    // rust: assert_eq!(
    // rust: (t.offers[0].uses, t.offers[0].demand, t.restocks_today),
    // rust: (0, 12, 1)
    // rust: );
    // rust: t.offers[0].uses = 1;
        // The second restock needs 2400 ticks since the first.
    // rust: assert!(!t.should_restock(2000, 0));
    // rust: assert!(t.should_restock(2600, 0));
    // rust: t.restock(2600);
    // rust: t.offers[0].uses = 1;
    // rust: assert!(!t.should_restock(6000, 0), "two a day");
        // A new day resets the count and catches up on demand.
    // rust: assert!(t.should_restock(30000, 1));
    // rust: assert_eq!(t.restocks_today, 0);
}

payment_and_selection :: proc() {
}
    // rust: let items = items();
    // rust: let offers = vec![offer(5, None), offer(1, Some(1))];
    // rust: let mut a = Some(ItemStack::new("minecraft:emerald", 6));
    // rust: let mut b = None;
    // rust: assert_eq!(
    // rust: sell_item(&offers, &items, a.as_ref(), b.as_ref(), None).0,
    // rust: Some(0)
    // rust: );
    // rust: assert!(offers[0].take(&items, &mut a, &mut b));
    // rust: assert_eq!(a.as_ref().unwrap().count, 1);
        // Payment in the second slot only still matches (A and B swap).
    // rust: let book = Some(ItemStack::new("minecraft:book", 1));
    // rust: let (i, r) = sell_item(
    // rust: &offers,
    // rust: &items,
    // rust: None,
    // rust: Some(&ItemStack::new("minecraft:emerald", 5)),
    // rust: None,
    // rust: );
    // rust: assert_eq!(
    // rust: (i, r.map(|r| r.item)),
    // rust: (Some(0), Some(Arc::from("minecraft:iron_boots")))
    // rust: );
    // rust: assert_eq!(
    // rust: sell_item(&offers, &items, a.as_ref(), book.as_ref(), Some(1)).0,
    // rust: Some(1)
    // rust: );
    // rust: let mut out = offers[0].clone();
    // rust: out.uses = 12;
    // rust: assert_eq!(
    // rust: sell_item(
    // rust: &[out],
    // rust: &items,
    // rust: Some(&ItemStack::new("minecraft:emerald", 5)),
    // rust: None,
    // rust: None
    // rust: )
    // rust: .1,
    // rust: None
    // rust: );
}

sequence_random_is_stable :: proc() {
}
    // rust: let mut a = sequence_random(12345, "minecraft:trade_set/armorer/level_1");
    // rust: let mut b = sequence_random(12345, "minecraft:trade_set/armorer/level_1");
    // rust: let mut c = sequence_random(12345, "minecraft:trade_set/butcher/level_1");
    // rust: let (x, y, z) = (a.next_long(), b.next_long(), c.next_long());
    // rust: assert_eq!(x, y);
    // rust: assert_ne!(x, z);
    // rust: assert_eq!(min_xp(2), 10);
    // rust: assert_eq!(max_xp(2), 70);
    // rust: assert!(!can_level_up(5));
}

reputation_and_heroes_lower_prices :: proc() {
}
    // rust: let items = items();
    // rust: let mut offers = vec![offer(10, None), offer(1, None)];
        // Reputation 50 with a 0.2 multiplier: 10 off, floored per offer.
    // rust: update_special_prices(&mut offers, 50, None);
    // rust: assert_eq!(offers[0].special_price_diff, -10);
    // rust: assert_eq!(offers[0].cost_a_count(&items), 1);
    // rust: assert_eq!(offers[1].special_price_diff, -10);
        // Bad reputation raises the price (-30 * 0.2 = -6 floors to -6).
    // rust: update_special_prices(&mut offers, -30, None);
    // rust: assert_eq!(offers[0].special_price_diff, 6);
    // rust: assert_eq!(offers[0].cost_a_count(&items), 16);
        // Hero of the Village I: 0.3 * 10 = 3 off, at least 1.
    // rust: update_special_prices(&mut offers, 0, Some(0));
    // rust: assert_eq!(offers[0].special_price_diff, -3);
    // rust: assert_eq!(offers[1].special_price_diff, -1);
        // Level III: 0.3 + 0.125 = 0.425 -> 4 off a ten emerald price.
    // rust: update_special_prices(&mut offers, 0, Some(2));
    // rust: assert_eq!(offers[0].special_price_diff, -4);
        // Both stack, from scratch each time.
    // rust: update_special_prices(&mut offers, 25, Some(0));
    // rust: assert_eq!(offers[0].special_price_diff, -5 - 3);
    // rust: update_special_prices(&mut offers, 0, None);
    // rust: assert_eq!(offers[0].special_price_diff, 0);
}
offers_follow_the_trade_data :: proc() {
}
    // rust: let items = items();
    // rust: let e = crate::enchant::tests::sample();
    // rust: let mut trades = HashMap::new();
    // rust: trades.insert("minecraft:t/boots".into(), json!({"gives":{"id":"minecraft:iron_boots"},"max_uses":12,"reputation_discount":0.2,"wants":{"count":4,"id":"minecraft:emerald"}}));
    // rust: trades.insert("minecraft:t/helmet".into(), json!({"gives":{"id":"minecraft:iron_helmet"},"max_uses":12,"reputation_discount":0.2,"wants":{"count":5,"id":"minecraft:emerald"}}));
    // rust: trades.insert("minecraft:t/desert".into(), json!({"gives":{"id":"minecraft:sand"},"wants":{"id":"minecraft:emerald"},"merchant_predicate":{"entity":"this","predicate":{"minecraft:predicates":{"minecraft:villager/variant":"minecraft:desert"}},"type":"minecraft:entity_properties"}}));
    // rust: let mut tags = HashMap::new();
    // rust: tags.insert(
    // rust: "minecraft:t/level_1".into(),
    // rust: vec![
    // rust: "minecraft:t/boots".into(),
    // rust: "minecraft:t/helmet".into(),
    // rust: "minecraft:t/desert".into(),
    // rust: ],
    // rust: );
    // rust: let mut sets = HashMap::new();
    // rust: sets.insert(
    // rust: "minecraft:t/level_1".into(),
    // rust: json!({"amount": 5, "trades": "#minecraft:t/level_1"}),
    // rust: );
    // rust: let t = Trades {
    // rust: trades,
    // rust: tags,
    // rust: sets,
    // rust: potion_tags: HashMap::new(),
}
    // rust: let ctx = TradeContext {
    // rust: items: &items,
    // rust: enchantments: &e,
    // rust: variant: "minecraft:plains",
    // rust: origin: [0.0; 3],
    // rust: maps: None,
}
    // rust: let offers = t.offers_from_set(&ctx, "minecraft:t/level_1", &mut sequence_random(1, "x"));
        // The desert-only trade is skipped for a plains villager; no duplicates.
    // rust: assert_eq!(offers.len(), 2);
    // rust: assert_ne!(offers[0].result.item, offers[1].result.item);
    // rust: assert!(
    // rust: offers
    // rust: .iter()
    // rust: .all(|o| o.max_uses == 12 && (o.price_multiplier - 0.2).abs() < 1e-6)
    // rust: );
}
}
