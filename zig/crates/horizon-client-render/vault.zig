//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_vault
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The vault (`VaultBlockEntity` with its `VaultConfig`, `VaultServerData`
//! and `VaultSharedData`): the server tick that walks `VaultState` (inactive,
//! active while players who were not rewarded yet are near, unlocking when one
//! inserts the key, ejecting the rewards one by one) and the key insertion.
//!
//! The state lives in the block (`vault_state`); the tick reads it and reports
//! the next one. The level's random draws the display item and throws the
//! rewards; the loot tables go through the caller, so the game and a
//! differential test world roll them the same way.
    // rust: pub use crate::chunk::block_entity::{Vault, VaultConfig};
// use crate::items::ItemStack;
// use horizon_core::random::RandomSource;
// use horizon_world::nbt::{Compound, Tag};

/// A player's UUID as its four ints (`UUIDUtil.CODEC`).
    // rust: pub type Uuid = [i32; 4];

/// `BuiltInLootTables.TRIAL_CHAMBERS_REWARD`, the default config's table.
pub const DEFAULT_LOOT_TABLE: []const u8 = "minecraft:chests/trial_chambers/reward";
pub const DEFAULT_ACTIVATION_RANGE: f64 = 4.0;
pub const DEFAULT_DEACTIVATION_RANGE: f64 = 4.5;
/// `VaultServerData.MAX_REWARD_PLAYERS`.
pub const MAX_REWARD_PLAYERS: usize = 128;
/// `UNLOCKING_DELAY_TICKS`, `INSERT_FAIL_SOUND_BUFFER_TICKS` and the 20 ticks
/// of `VaultState` between player checks and ejections.
pub const UNLOCKING_DELAY: i64 = 14;
pub const INSERT_FAIL_SOUND_BUFFER: i64 = 15;
pub const STATE_DELAY: i64 = 20;

    // rust: impl Default for VaultConfig {
    /// `VaultConfig.DEFAULT`: the trial key and the trial chambers' reward.
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: loot_table: DEFAULT_LOOT_TABLE.into(),
    // rust: activation_range: DEFAULT_ACTIVATION_RANGE,
    // rust: deactivation_range: DEFAULT_DEACTIVATION_RANGE,
    // rust: key_item: Some(ItemStack::new("minecraft:trial_key", 1)),
    // rust: override_loot_table_to_display: None,
}
}
}

    // rust: impl VaultConfig {
    /// `VaultConfig.CODEC`: a field that fails to decode takes its default
    /// (the key's is none); an activation range past the deactivation range
    /// fails the whole config.
pub fn decode(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Tag::Compound(_) = tag else {
    // rust: return None;
}
    // rust: let range = |k: &str, default: f64| {
    // rust: horizon_client_core::nbt_value::float(tag.get(k)).unwrap_or(default)
}
    // rust: let config = Self {
    // rust: loot_table: identifier(tag.get("loot_table"))
    // rust: .unwrap_or_else(|| DEFAULT_LOOT_TABLE.into()),
    // rust: activation_range: range("activation_range", DEFAULT_ACTIVATION_RANGE),
    // rust: deactivation_range: range("deactivation_range", DEFAULT_DEACTIVATION_RANGE),
    // rust: key_item: tag.get("key_item").and_then(stack),
    // rust: override_loot_table_to_display: identifier(tag.get("override_loot_table_to_display")),
}
    // rust: (config.activation_range <= config.deactivation_range).then_some(config)
}
    /// The fields that differ from their defaults.
pub fn encode(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Compound::new();
    // rust: if self.loot_table != DEFAULT_LOOT_TABLE {
    // rust: out.insert(
    // rust: "loot_table".into(),
    // rust: Tag::String(self.loot_table.as_str().into()),
    // rust: );
}
    // rust: if self.activation_range != DEFAULT_ACTIVATION_RANGE {
    // rust: out.insert(
    // rust: "activation_range".into(),
    // rust: Tag::Double(self.activation_range.to_bits()),
    // rust: );
}
    // rust: if self.deactivation_range != DEFAULT_DEACTIVATION_RANGE {
    // rust: out.insert(
    // rust: "deactivation_range".into(),
    // rust: Tag::Double(self.deactivation_range.to_bits()),
    // rust: );
}
    // rust: if let Some(key) = &self.key_item {
    // rust: out.insert("key_item".into(), horizon_items::item_nbt::item_to_nbt(key));
}
    // rust: if let Some(table) = &self.override_loot_table_to_display {
    // rust: out.insert(
    // rust: "override_loot_table_to_display".into(),
    // rust: Tag::String(table.as_str().into()),
    // rust: );
}
    // rust: Tag::Compound(out)
}
}

/// `VaultState`.
pub const VaultState = enum {
    Inactive,
    Active,
    Unlocking,
    Ejecting,
};

    // rust: impl VaultState {
    // rust: const ALL: [Self; 4] = [
    // rust: Self::Inactive,
    // rust: Self::Active,
    // rust: Self::Unlocking,
    // rust: Self::Ejecting,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Inactive => "inactive",
    // rust: Self::Active => "active",
    // rust: Self::Unlocking => "unlocking",
    // rust: Self::Ejecting => "ejecting",
}
}
pub fn from_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|s| s.name() == name)
}
}

/// A player the vault can detect (`PlayerDetector.INCLUDING_CREATIVE_PLAYERS`).
pub const VaultPlayer = struct {
    uuid: Uuid,
    block: [i32,
    spectator: bool,
};

/// What a vault did that the level shows or sends.
pub const VaultEvent = enum {
    /// `setBlockAndUpdate` with this `vault_state`.
    State(VaultState),
    /// `sendBlockUpdated`: the clients load the new shared data.
    BlockUpdated,
    /// `levelEvent(id, pos, data)`.
    LevelEvent(i32, i32),
    /// `playSound(null, vault, sound, BLOCKS, volume, pitch)`.
    Sound(&'static str, f32, f32),
    /// `DefaultDispenseItemBehavior.spawnItem` from the top of the vault:
    /// the item and its velocity.
    Eject(ItemStack, [f64; 3]),
};

/// What a vault reads from the level.
    // rust: pub trait VaultLevel {
pub fn game_time(self: *Self) i;
    /// `level.getPlayers()`, in the server's order.
pub fn players(self: *Self) V;
}

/// Rolls a loot table (`LootTable.getRandomItems`, stacks split) with the
/// level random, or with the table's random sequence when the flag is set and
/// the table has one.
    // rust: pub type Roll<'a, R> = dyn FnMut(&str, &mut R, bool) -> Vec<ItemStack> + 'a;

    // rust: impl Default for Vault {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: config: VaultConfig::default(),
    // rust: rewarded_players: Vec::new(),
    // rust: state_updating_resumes_at: 0,
    // rust: items_to_eject: Vec::new(),
    // rust: total_ejections_needed: 0,
    // rust: last_insert_fail_timestamp: 0,
    // rust: display_item: None,
    // rust: connected_players: Vec::new(),
    // rust: connected_particles_range: DEFAULT_DEACTIVATION_RANGE,
    // rust: shared_dirty: false,
    // rust: spin: 0.0,
    // rust: o_spin: 0.0,
}
}
}

/// An `Identifier` (`minecraft` when the namespace is left out).
pub fn identifier(t: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match t? {
    // rust: Tag::String(s) => horizon_client_core::identifier::normalize_id(&s.to_string_lossy()),
    // rust: _ => None,
}
}
/// `ItemStack.CODEC`: an item other than air, 1 to 99 of it.
pub fn stack(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = identifier(tag.get("id"))?;
    // rust: if let Some(count) = tag.get("count")
    // rust: && !horizon_client_core::nbt_value::number(Some(count))
    // rust: .is_some_and(|c| (1..=99).contains(&c))
    // rust: {
    // rust: return None;
}
    // rust: let mut item = horizon_items::item_nbt::item_from_nbt(tag)?;
    // rust: item.item = id.as_str().into();
    // rust: (&*item.item != "minecraft:air").then_some(item)
}
/// `UUIDUtil.CODEC_LINKED_SET`: every entry a UUID, duplicates dropped.
pub fn uuids(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Tag::List(list) = tag? else {
    // rust: return None;
}
    // rust: let mut out: Vec<Uuid> = Vec::new();
    // rust: for t in list {
    // rust: let Tag::IntArray(v) = t else {
    // rust: return None;
}
    // rust: let u = <Uuid>::try_from(v.as_slice()).ok()?;
    // rust: if !out.contains(&u) {
    // rust: out.push(u);
}
}
    // rust: Some(out)
}
pub fn encode_uuids(list: *[Uuid]) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::List(list.iter().map(|u| Tag::IntArray(u.to_vec())).collect())
}
/// `ItemStack.matches`, with None as the empty stack.
pub fn matches(a: ?*ItemStack, b: ?*ItemStack) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (a, b) {
    // rust: (None, None) => true,
    // rust: (Some(a), Some(b)) => a.count == b.count && a.same_item_same_components(b),
    // rust: _ => false,
}
}
pub fn same_set(a: *[Uuid], b: *[Uuid]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a.len() == b.len() && a.iter().all(|u| b.contains(u))
}

/// `Mth.wrapDegrees`.
pub fn wrap_degrees(degrees: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = degrees % 360.0;
    // rust: if t >= 180.0 {
    // rust: t - 360.0
    // rust: } else if t < -180.0 {
    // rust: t + 360.0
    // rust: } else {
    // rust: t
}
}

    // rust: impl Vault {
    /// `VaultClientData.updateDisplayItemSpin`, every client tick.
pub fn update_display_item_spin(self: *Self) void {
}
    // rust: self.o_spin = self.spin;
    // rust: self.spin = wrap_degrees(self.spin + 10.0);
}
    /// `VaultRenderer`'s spin: `Mth.rotLerp` between the last two ticks.
pub fn display_spin(self: *Self, partial: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.o_spin + partial * wrap_degrees(self.spin - self.o_spin)
}
    /// `loadAdditional`. `VaultServerData.set` leaves the total of ejections
    /// out, so a vault loaded mid-ejection counts from 0.
pub fn load(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut v = Self {
    // rust: config: tag
    // rust: .get("config")
    // rust: .map_or_else(|| Some(VaultConfig::default()), VaultConfig::decode)
    // rust: .unwrap_or_default(),
    // rust: ..Self::default()
}
    // rust: if let Some(Tag::Compound(_)) = tag.get("server_data") {
    // rust: let server = tag.get("server_data");
    // rust: let get = |k: &str| server.and_then(|s| s.get(k));
    // rust: v.rewarded_players = uuids(get("rewarded_players")).unwrap_or_default();
    // rust: v.state_updating_resumes_at =
    // rust: horizon_client_core::nbt_value::number(get("state_updating_resumes_at"))
    // rust: .unwrap_or(0);
    // rust: v.items_to_eject = match get("items_to_eject") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .map(stack)
    // rust: .collect::<Option<_>>()
    // rust: .unwrap_or_default(),
    // rust: _ => Vec::new(),
}
}
    // rust: if let Some(Tag::Compound(_)) = tag.get("shared_data") {
    // rust: let shared = tag.get("shared_data");
    // rust: let get = |k: &str| shared.and_then(|s| s.get(k));
    // rust: v.display_item = get("display_item").and_then(stack);
    // rust: v.connected_players = uuids(get("connected_players")).unwrap_or_default();
    // rust: v.connected_particles_range =
    // rust: horizon_client_core::nbt_value::float(get("connected_particles_range"))
    // rust: .unwrap_or(DEFAULT_DEACTIVATION_RANGE);
}
    // rust: v
}
    /// `saveAdditional`: the config, shared data and server data.
pub fn save(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut server = Compound::new();
    // rust: if !self.rewarded_players.is_empty() {
    // rust: server.insert(
    // rust: "rewarded_players".into(),
    // rust: encode_uuids(&self.rewarded_players),
    // rust: );
}
    // rust: if self.state_updating_resumes_at != 0 {
    // rust: server.insert(
    // rust: "state_updating_resumes_at".into(),
    // rust: Tag::Long(self.state_updating_resumes_at),
    // rust: );
}
    // rust: if !self.items_to_eject.is_empty() {
    // rust: let items = self
    // rust: .items_to_eject
    // rust: .iter()
    // rust: .map(horizon_items::item_nbt::item_to_nbt)
    // rust: .collect();
    // rust: server.insert("items_to_eject".into(), Tag::List(items));
}
    // rust: if self.total_ejections_needed != 0 {
    // rust: server.insert(
    // rust: "total_ejections_needed".into(),
    // rust: Tag::Int(self.total_ejections_needed),
    // rust: );
}
    // rust: vec![
    // rust: ("config", self.config.encode()),
    // rust: ("shared_data", self.update_shared()),
    // rust: ("server_data", Tag::Compound(server)),
    // rust: ]
}
    /// `VaultSharedData.CODEC`.
pub fn update_shared(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Compound::new();
    // rust: if let Some(item) = &self.display_item {
    // rust: out.insert(
    // rust: "display_item".into(),
    // rust: horizon_items::item_nbt::item_to_nbt(item),
    // rust: );
}
    // rust: if !self.connected_players.is_empty() {
    // rust: out.insert(
    // rust: "connected_players".into(),
    // rust: encode_uuids(&self.connected_players),
    // rust: );
}
    // rust: if self.connected_particles_range != DEFAULT_DEACTIVATION_RANGE {
    // rust: out.insert(
    // rust: "connected_particles_range".into(),
    // rust: Tag::Double(self.connected_particles_range.to_bits()),
    // rust: );
}
    // rust: Tag::Compound(out)
}
    /// `getUpdateTag`: the shared data the clients see.
pub fn update_tag(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([("shared_data", self.update_shared())])
}
    /// `VaultSharedData.setDisplayItem`.
pub fn set_display_item(self: *Self, item: ?ItemStack) void {
}
    // rust: if !matches(self.display_item.as_ref(), item.as_ref()) {
    // rust: self.display_item = item;
    // rust: self.shared_dirty = true;
}
}
    /// `canEjectReward`.
pub fn can_eject_reward(self: *Self, state: VaultState) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.config.key_item.is_some() && state != VaultState::Inactive
}
    /// `cycleDisplayItemFromLootTable`: one item of the display table, rolled
    /// with the level random (`Util.getRandom`).
    // rust: fn cycle_display_item<R: RandomSource>(
    // rust: &mut self,
    // rust: state: VaultState,
    // rust: random: &mut R,
    // rust: roll: &mut Roll<R>,
    // rust: ) {
    // rust: if !self.can_eject_reward(state) {
    // rust: self.set_display_item(None);
    // rust: return;
}
    // rust: let table = self
    // rust: .config
    // rust: .override_loot_table_to_display
    // rust: .as_ref()
    // rust: .unwrap_or(&self.config.loot_table);
    // rust: let mut items = roll(table, random, false);
    // rust: let item = if items.is_empty() {
    // rust: None
    // rust: } else {
    // rust: let i = random.next_int_bound(items.len() as i32).unwrap_or(0) as usize;
    // rust: Some(items.swap_remove(i))
}
    // rust: self.set_display_item(item);
}
    /// `VaultSharedData.updateConnectedPlayersWithinRange` with
    /// `PlayerDetector.INCLUDING_CREATIVE_PLAYERS`.
    // rust: fn update_connected_players<L: VaultLevel>(&mut self, l: &L, pos: [i32; 3], range: f64) {
    // rust: let found: Vec<Uuid> = l
    // rust: .players()
    // rust: .into_iter()
    // rust: .filter(|p| {
    // rust: let d = [0, 1, 2].map(|i| f64::from(p.block[i] - pos[i]));
    // rust: d[0] * d[0] + d[1] * d[1] + d[2] * d[2] < range * range && !p.spectator
    // rust: })
    // rust: .map(|p| p.uuid)
    // rust: .filter(|u| !self.rewarded_players.contains(u))
    // rust: .collect();
    // rust: if !same_set(&self.connected_players, &found) {
    // rust: self.connected_players = found;
    // rust: self.shared_dirty = true;
}
}
    /// `updateStateForConnectedPlayers`.
    // rust: fn update_state_for_connected_players<L: VaultLevel>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: pos: [i32; 3],
    // rust: range: f64,
    // rust: ) -> VaultState {
    // rust: self.update_connected_players(l, pos, range);
    // rust: self.state_updating_resumes_at = l.game_time() + STATE_DELAY;
    // rust: if self.connected_players.is_empty() {
    // rust: VaultState::Inactive
    // rust: } else {
    // rust: VaultState::Active
}
}
    /// `VaultServerData.ejectionProgress`.
pub fn ejection_progress(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.total_ejections_needed == 1 {
    // rust: return 1.0;
}
        // Mth.inverseLerp(size, 1, total), in floats.
    // rust: let size = self.items_to_eject.len() as f32;
    // rust: 1.0 - (size - 1.0) / (self.total_ejections_needed as f32 - 1.0)
}
    /// `VaultState.tickAndGetNext`.
    // rust: fn tick_and_get_next<L: VaultLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: state: VaultState,
    // rust: events: &mut Vec<VaultEvent>,
    // rust: ) -> VaultState {
    // rust: match state {
    // rust: VaultState::Inactive => {
    // rust: self.update_state_for_connected_players(l, pos, self.config.activation_range)
}
    // rust: VaultState::Active => {
    // rust: self.update_state_for_connected_players(l, pos, self.config.deactivation_range)
}
    // rust: VaultState::Unlocking => {
    // rust: self.state_updating_resumes_at = l.game_time() + STATE_DELAY;
    // rust: VaultState::Ejecting
}
    // rust: VaultState::Ejecting => {
                // The progress counts the item being ejected.
    // rust: let progress = self.ejection_progress();
    // rust: let Some(item) = self.items_to_eject.pop() else {
    // rust: self.total_ejections_needed = 0;
    // rust: return self.update_state_for_connected_players(
    // rust: l,
    // rust: pos,
    // rust: self.config.deactivation_range,
    // rust: );
}
                // DefaultDispenseItemBehavior.spawnItem going up, accuracy 2: the
                // power only scales x and z, which are 0.
    // rust: random.next_double();
    // rust: let spread = 0.017_227_5 * 2.0;
    // rust: let v = [
    // rust: random.triangle(0.0, spread),
    // rust: random.triangle(0.2, spread),
    // rust: random.triangle(0.0, spread),
    // rust: ];
    // rust: events.push(VaultEvent::Eject(item, v));
    // rust: events.push(VaultEvent::LevelEvent(3017, 0));
    // rust: events.push(VaultEvent::Sound(
    // rust: "block.vault.eject_item",
    // rust: 1.0,
    // rust: 0.8 + 0.4 * progress,
    // rust: ));
    // rust: self.set_display_item(self.items_to_eject.last().cloned());
    // rust: self.state_updating_resumes_at = l.game_time() + STATE_DELAY;
    // rust: VaultState::Ejecting
}
}
}
    /// `VaultState.onTransition`: `from`'s exit, then `to`'s entry.
    // rust: fn on_transition<R: RandomSource>(
    // rust: &mut self,
    // rust: from: VaultState,
    // rust: to: VaultState,
    // rust: ominous: bool,
    // rust: random: &mut R,
    // rust: roll: &mut Roll<R>,
    // rust: events: &mut Vec<VaultEvent>,
    // rust: ) {
    // rust: events.push(VaultEvent::State(to));
    // rust: if from == VaultState::Ejecting {
    // rust: events.push(VaultEvent::Sound("block.vault.close_shutter", 1.0, 1.0));
}
    // rust: match to {
    // rust: VaultState::Inactive => {
    // rust: self.set_display_item(None);
    // rust: events.push(VaultEvent::LevelEvent(3016, i32::from(ominous)));
}
    // rust: VaultState::Active => {
    // rust: if self.display_item.is_none() {
    // rust: self.cycle_display_item(to, random, roll);
}
    // rust: events.push(VaultEvent::LevelEvent(3015, i32::from(ominous)));
}
    // rust: VaultState::Unlocking => {
    // rust: events.push(VaultEvent::Sound("block.vault.insert_item", 1.0, 1.0))
}
    // rust: VaultState::Ejecting => {
    // rust: events.push(VaultEvent::Sound("block.vault.open_shutter", 1.0, 1.0))
}
}
}
    /// `VaultBlockEntity.Server.tick`: the next state of the block.
    // rust: pub fn server_tick<L: VaultLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: state: VaultState,
    // rust: ominous: bool,
    // rust: roll: &mut Roll<R>,
    // rust: events: &mut Vec<VaultEvent>,
    // rust: ) -> VaultState {
    // rust: let now = l.game_time();
    // rust: if now % 20 == 0 && state == VaultState::Active {
    // rust: self.cycle_display_item(state, random, roll);
}
    // rust: let mut next = state;
    // rust: if now >= self.state_updating_resumes_at {
    // rust: next = self.tick_and_get_next(l, random, pos, state, events);
    // rust: if next != state {
    // rust: self.on_transition(state, next, ominous, random, roll, events);
}
}
    // rust: if std::mem::take(&mut self.shared_dirty) {
    // rust: events.push(VaultEvent::BlockUpdated);
}
    // rust: next
}
    /// `VaultBlock.useItemOn`: None when the item passes to the empty hand (an
    /// empty hand or a vault that is not active), else how many of `stack`
    /// the vault takes (none from a player with infinite materials).
    // rust: pub fn use_item_on<L: VaultLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: state: VaultState,
    // rust: ominous: bool,
    // rust: player: Uuid,
    // rust: stack: Option<&ItemStack>,
    // rust: roll: &mut Roll<R>,
    // rust: events: &mut Vec<VaultEvent>,
    // rust: ) -> Option<u32> {
    // rust: let stack = stack.filter(|s| s.count > 0)?;
    // rust: (state == VaultState::Active).then(|| {
    // rust: self.try_insert_key(l, random, pos, state, ominous, player, stack, roll, events)
    // rust: })
}
    /// `VaultBlockEntity.Server.tryInsertKey`: how many of `stack` the vault
    /// takes.
    // rust: fn try_insert_key<L: VaultLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: state: VaultState,
    // rust: ominous: bool,
    // rust: player: Uuid,
    // rust: stack: &ItemStack,
    // rust: roll: &mut Roll<R>,
    // rust: events: &mut Vec<VaultEvent>,
    // rust: ) -> u32 {
    // rust: if !self.can_eject_reward(state) {
    // rust: return 0;
}
    // rust: let Some(key) = &self.config.key_item else {
    // rust: return 0;
}
    // rust: let key_count = key.count;
    // rust: if !(stack.same_item_same_components(key) && stack.count >= key_count) {
    // rust: self.play_insert_fail_sound(l, "block.vault.insert_item_fail", events);
    // rust: return 0;
}
    // rust: if self.rewarded_players.contains(&player) {
    // rust: self.play_insert_fail_sound(l, "block.vault.reject_rewarded_player", events);
    // rust: return 0;
}
    // rust: let items = roll(&self.config.loot_table.clone(), random, true);
    // rust: if items.is_empty() {
    // rust: return 0;
}
        // unlock
    // rust: self.total_ejections_needed = items.len() as i32;
    // rust: self.items_to_eject = items;
    // rust: self.set_display_item(self.items_to_eject.last().cloned());
    // rust: self.state_updating_resumes_at = l.game_time() + UNLOCKING_DELAY;
    // rust: self.on_transition(state, VaultState::Unlocking, ominous, random, roll, events);
        // addToRewardedPlayers
    // rust: if !self.rewarded_players.contains(&player) {
    // rust: self.rewarded_players.push(player);
    // rust: if self.rewarded_players.len() > MAX_REWARD_PLAYERS {
    // rust: self.rewarded_players.remove(0);
}
}
    // rust: self.update_connected_players(l, pos, self.config.deactivation_range);
    // rust: key_count
}
    /// `playInsertFailSound`: at most once every 15 ticks.
    // rust: fn play_insert_fail_sound<L: VaultLevel>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: sound: &'static str,
    // rust: events: &mut Vec<VaultEvent>,
    // rust: ) {
    // rust: if l.game_time() >= self.last_insert_fail_timestamp + INSERT_FAIL_SOUND_BUFFER {
    // rust: events.push(VaultEvent::Sound(sound, 1.0, 1.0));
    // rust: self.last_insert_fail_timestamp = l.game_time();
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;

pub fn tag(snbt: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_world::nbt::parse_snbt(snbt).expect("snbt").0
}
pub const Level = struct {
    time: i64,
    players: std.ArrayList(VaultPlayer),
};
    // rust: impl VaultLevel for Level {
pub fn game_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.time
}
pub fn players(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.players.clone()
}
}

pub fn a_missing_config_is_the_trial_key_and_an_invalid_one_too() void {
}
    // rust: assert_eq!(Vault::load(&tag("{}")).config, VaultConfig::default());
    // rust: let v = Vault::load(&tag(
    // rust: "{config:{activation_range:5.0d,deactivation_range:4.0d}}",
    // rust: ));
    // rust: assert_eq!(v.config, VaultConfig::default());
        // A config without a key never opens.
    // rust: let v = Vault::load(&tag(
    // rust: r#"{config:{loot_table:"minecraft:chests/trial_chambers/reward_ominous"}}"#,
    // rust: ));
    // rust: assert_eq!(v.config.key_item, None);
    // rust: assert!(!v.can_eject_reward(VaultState::Active));
}

pub fn a_rewarded_player_is_refused_and_a_new_one_unlocks() void {
}
    // rust: let player = [0, 0, 0, 1];
    // rust: let l = Level {
    // rust: time: 100,
    // rust: players: vec![VaultPlayer {
    // rust: uuid: player,
    // rust: block: [1, 0, 0],
    // rust: spectator: false,
    // rust: }],
}
    // rust: let mut v = Vault::default();
    // rust: let mut random = LegacyRandom::new(1);
    // rust: let mut events = Vec::new();
    // rust: let key = ItemStack::new("minecraft:trial_key", 1);
    // rust: let mut roll =
    // rust: |_: &str, _: &mut LegacyRandom, _: bool| vec![ItemStack::new("minecraft:diamond", 2)];
    // rust: let pos = [0, 0, 0];
    // rust: let taken = v.use_item_on(
    // rust: &l,
    // rust: &mut random,
    // rust: pos,
    // rust: VaultState::Inactive,
    // rust: false,
    // rust: player,
    // rust: Some(&key),
    // rust: &mut roll,
    // rust: &mut events,
    // rust: );
    // rust: assert_eq!(taken, None);
    // rust: let taken = v.use_item_on(
    // rust: &l,
    // rust: &mut random,
    // rust: pos,
    // rust: VaultState::Active,
    // rust: false,
    // rust: player,
    // rust: Some(&key),
    // rust: &mut roll,
    // rust: &mut events,
    // rust: );
    // rust: assert_eq!(taken, Some(1));
    // rust: assert_eq!(events[0], VaultEvent::State(VaultState::Unlocking));
    // rust: assert_eq!(v.rewarded_players, [player]);
    // rust: assert_eq!(v.state_updating_resumes_at, 114);
    // rust: events.clear();
    // rust: let taken = v.use_item_on(
    // rust: &l,
    // rust: &mut random,
    // rust: pos,
    // rust: VaultState::Active,
    // rust: false,
    // rust: player,
    // rust: Some(&key),
    // rust: &mut roll,
    // rust: &mut events,
    // rust: );
    // rust: assert_eq!(taken, Some(0));
    // rust: assert_eq!(
    // rust: events,
    // rust: [VaultEvent::Sound(
    // rust: "block.vault.reject_rewarded_player",
    // rust: 1.0,
    // rust: 1.0
    // rust: )]
    // rust: );
}

pub fn saved_data_round_trips() void {
}
    // rust: let v = Vault::load(&tag(
    // rust: r#"{server_data:{rewarded_players:[[I;0,0,0,1]],state_updating_resumes_at:40L,items_to_eject:[{id:"minecraft:emerald",count:3}]},shared_data:{display_item:{id:"minecraft:emerald",count:3}}}"#,
    // rust: ));
    // rust: let saved = Tag::compound(v.save());
    // rust: assert_eq!(Vault::load(&saved), v);
}
}
