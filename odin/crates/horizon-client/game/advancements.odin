//! Transpiled from Horizon Rust crate
package horizon_client_advancements

import "core:fmt"
import "core:mem"
import "core:math"

// The player's advancements in the game: criteria triggered from game
// events (`CriteriaTriggers`), awarding with rewards, the toast and the
// chat announcement, and `players/advancements/<uuid>.json`.
// use super::{Dim, Game};
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: advancements::{self as adv, EntityView, Frame, ItemView, Progress, Tree},
    // rust: hud::{HudBatch, rgba},
    // rust: items::ItemStack,
    // rust: text::{self, Style, Text},
    // rust: toasts::Slide,
}
// use horizon_core::geometry::Vec3;
// use horizon_core::random::RandomSource;
// use horizon_protocol::packets::play::Clientbound as C;
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet, VecDeque},
    // rust: sync::Arc,
    // rust: time::Instant,
}

    // rust: pub(super) struct Toast {
    // rust: icon: String,
    // rust: frame: Frame,
    // rust: title: Text,
    // rust: slide: Slide,
    // `ToastInstance.firstSlotIndex`: the 32-pixel slot it stacks in once it
    // leaves the queue.
    // rust: slot: Option<usize>,
    // A `RecipeToast`: the crafting station and result of each display
    // unlocked while it lasts (`recipeItems`); empty for an advancement.
    // rust: recipes: Vec<(String, ItemStack)>,
    // `RecipeToast.changed` and `lastChanged`.
    // rust: changed: bool,
    // rust: last_changed: i64,
}
    // rust: impl Toast {
    // `RecipeToast.addOrUpdate` on a new toast.
    // rust: pub(super) fn recipe(items: Vec<(String, ItemStack)>) -> Self {
    // rust: Self {
    // rust: icon: String::new(),
    // rust: frame: Frame::Task,
    // rust: title: Text::literal(""),
    // rust: slide: Slide::default(),
    // rust: slot: None,
    // rust: recipes: items,
    // rust: changed: true,
    // rust: last_changed: 0,
}
}
    // rust: pub(super) fn is_recipe(&self) -> bool {
    // rust: !self.recipes.is_empty()
}
    // `RecipeToast.addItem`: more displays on a toast still queued or shown.
    // rust: pub(super) fn add_recipes(&mut self, items: Vec<(String, ItemStack)>) {
    // rust: self.recipes.extend(items);
    // rust: self.changed = true;
}
    // `Toast.update` with `fullyVisibleForMs`: whether it wants to be shown.
wants_show :: proc(self: ^Self, fully_for: i64, multiplier: f64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let time = 5000.0 * multiplier;
    // rust: if self.recipes.is_empty() {
            // AdvancementToast.
    // rust: return (fully_for as f64) < time;
}
    // rust: if self.changed {
    // rust: self.last_changed = fully_for;
    // rust: self.changed = false;
}
    // rust: ((fully_for - self.last_changed) as f64) < time
}
    // `RecipeToast.displayedRecipeIndex`: the displays take turns over the
    // toast's display time.
displayed_recipe :: proc(self: ^Self, fully_for: i64, multiplier: f64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let n = self.recipes.len() as f64;
    // rust: (fully_for as f64 / (5000.0 * multiplier / n).max(1.0) % n) as usize
}
}
// Where the player's fall, lava ride and Nether trip began, the blast that
// last hit the player, and the effects the last tick saw (`ServerPlayer`'s
// fields of the same names). A guest keeps their own, as `levitation` does.
    // rust: pub(super) struct TravelMarks {
    // `startingToFallPosition`.
    // rust: pub(super) fall: Option<[f64; 3]>,
    // `currentExplosionImpactPos` and `currentExplosionCause` (the entity
    // that made the blast, if any).
    // rust: pub(super) blast: Option<([f64; 3], Option<EntityView>)>,
    // `enteredLavaOnVehiclePosition`.
    // rust: pub(super) lava_ride: Option<[f64; 3]>,
    // `enteredNetherPosition`.
    // rust: pub(super) nether: Option<[f64; 3]>,
    // The (effect, amplifier) pairs `EffectsChangedTrigger` last saw.
    // rust: pub(super) effects: Vec<(&'static str, i32)>,
    // `PlayerEffects::changes` as the last tick saw it.
    // rust: pub(super) effect_changes: u32,
}
    // rust: pub(super) struct AdvState {
    // rust: pub(super) tree: Arc<Tree>,
    // `ClientAdvancements`: a server's tree carries each advancement's
    // place on its tab (`DisplayInfo` x, y), in tree order.
    // rust: pub(super) positions: Option<Vec<(f32, f32)>>,
    // rust: pub(super) progress: Progress,
    // rust: pub(super) loaded: bool,
    // rust: pub(super) toasts: VecDeque<Toast>,
    // Awards skip the toast (`/advancement grant ... everything`).
    // rust: pub(super) quiet: bool,
    // The inventory last seen by `inventory_changed`.
    // rust: pub(super) last_inventory: u64,
    // `ServerPlayer.levitationStartPos` and `levitationStartTime`.
    // rust: pub(super) levitation: Option<([f64; 3], u64)>,
    // The fall, lava ride, Nether trip, blast and effects `tick_marks` follows.
    // rust: pub(super) marks: TravelMarks,
    // While the game acts for a network player (`as_guest`): the
    // advancements whose progress changed (`progressChanged`), the recipes
    // unlocked and the announcements, for their client and everyone's.
    // rust: pub(super) changed: BTreeSet<usize>,
    // rust: pub(super) unlocked: Vec<String>,
    // rust: pub(super) announced: Vec<Text>,
    // The tree being read on another thread since the world opened
    // (`prefetch_advancement_tree`), taken by the first `advancement_tree`.
    // rust: pub(super) pending_tree: Option<std::thread::JoinHandle<Arc<Tree>>>,
    // `inventory_changed`'s criteria by item, built for `tree`.
    // rust: inventory_index: Option<(Arc<Tree>, Arc<adv::InventoryIndex>)>,
}
    // rust: impl AdvState {
    // Drop the prefetched tree and the index built for the old one (a
    // `/reload` rebuilt the tree).
    // rust: pub(super) fn reset_tree(&mut self) {
    // rust: self.pending_tree = None;
    // rust: self.inventory_index = None;
}
}
// The game's world for predicates.
View :: struct {
    // rust: impl adv::World for View<'_, '_> {
dimension :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.0.dim.id()
}
    // `WeatherCheck.test`'s level queries, using dimension-aware effective levels.
weather :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (rain, thunder) = self.0.weather_levels(1.0);
    // rust: (f64::from(rain) > 0.2, f64::from(thunder) > 0.9)
}
biome :: proc(self: ^Self, p: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .world
    // rust: .chunks
    // rust: .get(&(p[0] >> 4, p[2] >> 4))
    // rust: .map(|c| {
    // rust: self.0
    // rust: .res
    // rust: .biomes()
    // rust: .get(c.biome(p[0], p[1], p[2]))
    // rust: .name
    // rust: .clone()
    // rust: })
    // rust: .unwrap_or_default()
}
structures :: proc(self: ^Self, p: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.0.structures_at(p)
}
block :: proc(self: ^Self, p: [i32; 3]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.0.world.block(p[0], p[1], p[2]);
    // rust: let name = self.0.res.facts().get(state).name.to_string();
    // rust: let props = self
    // rust: .0
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)
    // rust: .map(|s| {
    // rust: s.properties
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: (name, props)
}
fluid :: proc(self: ^Self, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self
    // rust: .0
    // rust: .res
    // rust: .facts()
    // rust: .get(self.0.world.block(p[0], p[1], p[2]))
    // rust: .fluid
    // rust: {
    // rust: horizon_client::blocks::Fluid::Water => Some("minecraft:water".into()),
    // rust: horizon_client::blocks::Fluid::Lava => Some("minecraft:lava".into()),
    // rust: _ => None,
}
}
can_see_sky :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (p[1] + 1..p[1] + 200).all(|y| {
    // rust: !self
    // rust: .0
    // rust: .res
    // rust: .facts()
    // rust: .get(self.0.world.block(p[0], y, p[2]))
    // rust: .full_collision
    // rust: })
}
light :: proc(self: ^Self, p: [i32; 3]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let l = self.0.world.light(p[0], p[1], p[2]);
    // rust: i32::from((l >> 4).max(l & 15))
}
    // `CampfireBlock.isSmokeyPos`: share the beehive smoke test.
smokey :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client::beehive::smokey(&self.0.mob_world_base(&[]), p)
}
block_entity_nbt :: proc(self: ^Self, p: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.0.block_entity_nbt(p)
}
in_tag :: proc(self: ^Self, registry: string, tag: string, id: string) -> b {
    // Ported from Horizon
    return {}
}
        // The world's packs' tags over the game's own, as the server's
        // registries bind them (`TagLoader.loadTagsForExistingRegistries`).
    // rust: if let Some(tags) = self
    // rust: .0
    // rust: .world_tables
    // rust: .as_ref()
    // rust: .and_then(|t| t.pack_tags.get(registry))
    // rust: {
    // rust: return tags.get(tag).is_some_and(|t| t.contains(id));
}
    // rust: let items = self.0.items();
    // rust: match registry {
    // rust: "item" => items.item_in_tag(tag, id),
    // rust: "block" => items.block_in_tag(tag, id),
    // rust: "entity_type" => self.0.res.mob_data().entity_has(tag, id),
    // rust: "worldgen/biome" => self.0.res.mob_data().biome_has(tag, id),
    // rust: "worldgen/structure" => vanilla_structure_tags(&self.0.options.resources)
    // rust: .get(tag)
    // rust: .is_some_and(|t| t.contains(id)),
    // rust: "damage_type" => self
    // rust: .0
    // rust: .health_resources
    // rust: .damage
    // rust: .id(id)
    // rust: .is_some_and(|source| self.0.health_resources.damage.in_tag(source, tag)),
    // rust: _ => false,
}
}
}
    // rust: type Tags = std::collections::HashMap<String, std::collections::HashSet<String>>;
// The game's own `worldgen/structure` tags (a world without data packs has
// no `WorldTables` to hold them), loaded once for the resource root first
// asked for, as `StructureSpawns::shared`.
vanilla_structure_tags :: proc(root: ^std::path::Path) -> ^ {
    // Ported from Horizon
    return {}
}
TAGS :: std::sync::OnceLock::new()
    // rust: TAGS.get_or_init(|| {
    // rust: horizon_client::items::load_tags(
    // rust: root,
    // rust: "worldgen/structure",
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap_or_default()
    // rust: })
}
now_text :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let secs = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs()) as i64;
    // rust: adv::date_text(secs)
}
    // rust: impl Game<'_> {
    // `ItemPredicate.test` (the `item_filter` of a filtered item modifier).
    // rust: pub(super) fn loot_item_filter(&self, predicate: &Value, s: &ItemStack) -> bool {
    // rust: adv::item(predicate, &item_view(s), &View(self))
}
    // `BaseContainerBlockEntity.canOpen`: whether the `lock` of the block
    // entity at `key` keeps a player with this main hand out (`LockCode`).
    // rust: pub(super) fn container_locked_for(
    // rust: &self,
    // rust: key: (i32, i32, i32),
    // rust: spectator: bool,
    // rust: hand: Option<&ItemStack>,
    // rust: ) -> bool {
    // rust: let Some(lock) = self.world.block_lock(key) else {
    // rust: return false;
}
    // rust: let lock = horizon_client::item_render::tag_json(lock);
    // rust: let hand = hand.map(item_view);
    // rust: !adv::can_unlock(&lock, spectator, hand.as_ref(), &View(self))
}
}
    // rust: pub(super) fn item_view(s: &ItemStack) -> ItemView {
    // rust: ItemView {
    // rust: id: s.item.to_string(),
    // rust: count: s.count,
    // rust: damage: s.damage,
    // rust: enchantments: s
    // rust: .enchantments()
    // rust: .iter()
    // rust: .map(|(id, l)| (id.to_string(), *l))
    // rust: .collect(),
    // rust: potion: s.potion().map(str::to_owned),
    // rust: custom_name: s.custom_name().is_some(),
}
}
    // rust: impl Game<'_> {
adv_path :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(super::stats::player_json(
    // rust: &self.world_root,
    // rust: "advancements",
    // rust: self.level.player_uuid?,
    // rust: ))
}
    // A server with no player of its own and nobody it acts for: there is
    // no player for advancements and statistics.
    // rust: pub(super) fn no_player_here(&self) -> bool {
    // rust: self.options.dedicated.is_some() && self.lan_acting.is_none()
}
    // The advancement tree, loaded once.
    // rust: pub(super) fn advancement_tree(&mut self) -> Arc<Tree> {
    // rust: if self.adv.tree.list.is_empty() {
    // rust: let tree = match self.adv.pending_tree.take().map(|h| h.join()) {
    // rust: Some(Ok(tree)) => tree,
    // rust: _ => {
    // rust: let overlay = self.pack_files();
    // rust: Tree::shared(&self.options.resources.join("data"), &overlay)
}
}
    // rust: self.adv.tree = tree;
            // With the tree, while the world loads: built on the first
            // inventory change it cost that tick ~10 ms.
    // rust: self.inventory_index();
}
    // rust: self.adv.tree.clone()
}
    // `inventory_changed`'s criteria by item, for the tree in place.
inventory_index :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let tree = self.adv.tree.clone();
    // rust: if let Some((built, index)) = &self.adv.inventory_index
    // rust: && Arc::ptr_eq(built, &tree)
    // rust: {
    // rust: return index.clone();
}
    // rust: let items = self.items();
    // rust: let index = Arc::new(adv::InventoryIndex::build(&tree, |tag| {
    // rust: items
    // rust: .item_tags
    // rust: .get(tag)
    // rust: .map(|t| t.iter().map(String::as_str).collect())
    // rust: .unwrap_or_default()
    // rust: }));
    // rust: self.adv.inventory_index = Some((tree, index.clone()));
    // rust: index
}
    // Start reading the advancement files on another thread while the world
    // loads. The first tick's first criterion trigger used to read and parse
    // all of them on the game thread (about 60 ms).
    // rust: pub(super) fn prefetch_advancement_tree(&mut self) {
    // rust: if !self.adv.tree.list.is_empty() || self.adv.pending_tree.is_some() {
    // rust: return;
}
    // rust: let data = self.options.resources.join("data");
        // The world's packs' advancements go over the game's own, and a
        // native mod's contributed files are already among them: the tables
        // were built for this open (`build_world_tables`), so the hook is
        // asked once, not again here.
    // rust: let files = match &self.world_tables {
    // rust: Some(tables) => tables.files.clone(),
    // rust: None => super::functions::content_overlay(
    // rust: &self.world_root,
    // rust: &self.options.resources,
    // rust: self.cmds.vanilla_disabled,
    // rust: &self.level.enabled_features,
    // rust: ),
}
    // rust: self.adv.pending_tree = std::thread::Builder::new()
    // rust: .name("horizon-advancements".into())
    // rust: .spawn(move || Tree::shared(&data, &horizon_world::loot::PackOverlay { files: &files }))
    // rust: .ok();
}
    // rust: pub(super) fn load_advancements(&mut self) {
    // rust: if self.adv.loaded || self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: self.adv.loaded = true;
    // rust: self.advancement_tree();
    // rust: let progress = self
    // rust: .adv_path()
    // rust: .and_then(|p| std::fs::read_to_string(p).ok())
    // rust: .and_then(|t| serde_json::from_str::<Value>(&t).ok())
    // rust: .map(|v| Progress::from_json(&v))
    // rust: .unwrap_or_default();
        // The known recipes are the player's own (`recipeBook`), not the
        // rewards of done advancements: /recipe take sticks.
    // rust: let tree = self.adv.tree.clone();
    // rust: self.adv.progress = progress;
    // rust: self.ui.registries.advancements = tree.list.iter().map(|a| a.id.clone()).collect();
}
    // rust: pub(super) fn save_advancements(&self) {
    // rust: if !self.adv.loaded || self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: let Some(path) = self.adv_path() else {
    // rust: return;
}
    // rust: let json = self
    // rust: .adv
    // rust: .progress
    // rust: .to_json(&self.adv.tree, horizon_world::DATA_VERSION);
    // rust: if let Some(dir) = path.parent() {
    // rust: let _ = std::fs::create_dir_all(dir);
}
    // rust: if let Ok(text) = serde_json::to_string_pretty(&json) {
    // rust: let _ = std::fs::write(path, text);
}
}
    // The player as predicates see it.
    // The predicate view of a command target.
    // rust: pub(super) fn entity_view_of(&self, t: super::commands::Target) -> EntityView {
//         use super::commands::Target;
    // rust: match t {
    // rust: Target::Player => self.player_entity(),
    // rust: Target::Mob(id) => self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| self.mob_entity(m))
    // rust: .unwrap_or_default(),
            // A server's player: what its last `ServerboundPlayerInputPacket`
            // held (shift 32) and its game mode.
    // rust: Target::Guest(conn) if self.command_guest(conn).is_some() => {
    // rust: let g = self.command_guest(conn).expect("checked");
    // rust: EntityView {
    // rust: kind: self.target_type(t),
    // rust: position: g.position,
    // rust: sneaking: g.sneaking,
    // rust: input_sneak: g.input & 32 != 0,
    // rust: team: self
    // rust: .score
    // rust: .board
    // rust: .players_team(&g.name)
    // rust: .map(|t| t.name.clone()),
    // rust: gamemode: Some(
    // rust: match g.game_mode {
    // rust: 1 => "creative",
    // rust: 2 => "adventure",
    // rust: 3 => "spectator",
    // rust: _ => "survival",
}
    // rust: .to_owned(),
    // rust: ),
    // rust: ..EntityView::default()
}
}
    // rust: other => EntityView {
    // rust: kind: self.target_type(other),
    // rust: position: self.target_position(other).unwrap_or_default(),
    // rust: ..EntityView::default()
    // rust: },
}
}
    // A `ContextAwarePredicate` for `this` at `origin`.
    // rust: pub(super) fn conditions_hold(
    // rust: &self,
    // rust: v: &Value,
    // rust: this: Option<&EntityView>,
    // rust: origin: [f64; 3],
    // rust: ) -> bool {
    // rust: adv::conditions(
    // rust: v,
    // rust: &adv::Entities {
    // rust: this,
    // rust: origin,
    // rust: tool: None,
    // rust: block_pos: None,
    // rust: },
    // rust: &View(self),
    // rust: )
}
    // The player as a command's predicates see it: with what it looks at.
    // rust: pub(super) fn player_entity(&self) -> EntityView {
    // rust: self.player_entity_looking(true)
}
    // [`Self::entity_view_of`] for testing `predicate` (a predicate, a list
    // of conditions or an item modifier): the player with the level,
    // statistics, advancements and recipes it may ask for, and nothing
    // copied when it asks for none.
    // rust: pub(super) fn entity_view_asked(
    // rust: &self,
    // rust: t: super::commands::Target,
    // rust: predicate: &Value,
    // rust: ) -> EntityView {
    // rust: self.entity_view_asking(t, adv::facts_asked_in(predicate))
}
    // [`Self::entity_view_of`] with the player's records `asked` names.
    // rust: pub(super) fn entity_view_asking(
    // rust: &self,
    // rust: t: super::commands::Target,
    // rust: asked: adv::FactsAsked,
    // rust: ) -> EntityView {
//         use super::commands::Target;
    // rust: let mut view = self.entity_view_of(t);
    // rust: match t {
    // rust: Target::Player => view.player_facts = self.player_facts(asked),
    // rust: Target::Guest(conn) => view.player_facts = self.guest_facts(conn, asked),
    // rust: _ => {}
}
    // rust: view
}
    // [`Self::player_facts`] of a server's player who is not in place
    // (selectors leave out the one in place): its own records, kept on the
    // hub while another acts.
guest_facts :: proc(self: ^Self, conn: u32, asked: adv::FactsAsked) -> a {
    // Ported from Horizon
    return {}
}
    // rust: let Some(host) = self.lan.as_ref() else {
    // rust: return adv::PlayerFacts::default();
}
    // rust: let Some(g) = host
    // rust: .hub
    // rust: .guest(conn)
    // rust: .filter(|_| self.lan_acting != Some(conn))
    // rust: else {
    // rust: return adv::PlayerFacts::default();
}
    // rust: let stats = (host.play.get(&conn).map(|p| &p.stats)).filter(|s| s.loaded);
    // rust: adv::PlayerFacts {
    // rust: level: asked.level.then_some(g.xp_level),
    // rust: stats: stats.filter(|_| asked.stats).map(|s| s.values.clone()),
    // rust: advancements: asked
    // rust: .advancements
    // rust: .then(|| (self.adv.tree.clone(), g.advancements.clone())),
    // rust: recipes: asked.recipes.then(|| g.recipe_book.recipes.clone()),
}
}
    // [`Self::player_entity`] for `trigger`'s criteria: what the player
    // looks at, and its level, statistics, advancements and recipes, only
    // when one of them may ask (a ray against every entity and copies of
    // the player's records otherwise), and its compound only when one of
    // them may test `nbt`.
    // rust: pub(super) fn player_entity_for(&mut self, trigger: &str) -> EntityView {
    // rust: let mut me = self.player_entity_for_any(&[trigger]);
    // rust: if self.adv.tree.may_test_nbt(trigger) {
    // rust: me.nbt = self.player_nbt();
}
    // rust: me
}
    // [`Self::player_entity_for`] for the criteria of several triggers,
    // without the player's compound (building it needs `&mut self`).
    // rust: pub(super) fn player_entity_for_any(&self, triggers: &[&str]) -> EntityView {
    // rust: let tree = &self.adv.tree;
    // rust: let mut me = self.player_entity_looking(triggers.iter().any(|t| tree.may_look(t)));
    // rust: let asked = (triggers.iter()).fold(adv::FactsAsked::default(), |all, t| {
    // rust: all.or(tree.player_facts_asked(t))
    // rust: });
    // rust: me.player_facts = self.player_facts(asked);
    // rust: me
}
    // The player's level, statistics, advancements and recipes that
    // `asked` names, for `PlayerPredicate`; records not loaded stay `None`.
player_facts :: proc(self: ^Self, asked: adv::FactsAsked) -> a {
    // Ported from Horizon
    return {}
}
    // rust: if self.player.is_none() {
    // rust: return adv::PlayerFacts::default();
}
    // rust: adv::PlayerFacts {
    // rust: level: asked.level.then_some(self.experience.level),
    // rust: stats: (asked.stats && self.stats.loaded).then(|| self.stats.values.clone()),
    // rust: advancements: (asked.advancements && self.adv.loaded)
    // rust: .then(|| (self.adv.tree.clone(), self.adv.progress.clone())),
    // rust: recipes: asked
    // rust: .recipes
    // rust: .then(|| self.level.recipe_book.recipes.clone()),
}
}
    // The player as predicates see it, with what it looks at when `looking`.
    // rust: pub(super) fn player_entity_looking(&self, looking: bool) -> EntityView {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return EntityView::default();
}
    // rust: let mut eq: [Option<ItemView>; 7] = Default::default();
    // rust: eq[0] = self.held().map(item_view);
    // rust: eq[1] = self.offhand.as_ref().map(item_view);
    // rust: for (i, a) in self.armor.iter().enumerate() {
    // rust: eq[2 + i] = a.as_ref().map(item_view);
}
    // rust: let vehicle = self.riding.and_then(|id| {
    // rust: self.mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map(|m| Box::new(self.mob_entity(m)))
    // rust: .or_else(|| {
    // rust: self.boats
    // rust: .iter()
    // rust: .find(|b| b.id == id)
    // rust: .map(|b| Box::new(self.boat_entity(b)))
    // rust: })
    // rust: });
    // rust: EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: position: [p.position.x, p.position.y, p.position.z],
            // Entity.isOnFire on a server: remainingFireTicks (players aren't fire immune).
    // rust: on_fire: p.fire_ticks > 0,
    // rust: sneaking: p.pose == horizon_client::pose::Pose::Crouching,
            // Input.shift: the held key, as `BlockItem.place`'s sneaking reads it.
    // rust: input_sneak: self.keys.held(Action::Sneak),
    // rust: sprinting: p.sprinting,
    // rust: swimming: p.pose == horizon_client::pose::Pose::Swimming,
    // rust: flying: p.flying,
    // rust: on_ground: p.ground.on_ground,
    // rust: equipment: eq,
    // rust: vehicle,
    // rust: effects: self
    // rust: .potions
    // rust: .effects
    // rust: .list
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let id = horizon_client::brewing::namespaced(e.id);
    // rust: (id.to_owned(), e.amplifier, e.duration)
    // rust: })
    // rust: .collect(),
    // rust: gamemode: Some(self.mode.name().to_owned()),
    // rust: team: self.player_team().map(|t| t.name.clone()),
            // Vanilla looks for it inside PlayerPredicate.matches whatever the
            // trigger; skipped for a trigger whose criteria can't ask.
    // rust: looking_at: looking
    // rust: .then(|| self.looking_at_entity().map(Box::new))
    // rust: .flatten(),
    // rust: ..Default::default()
}
}
    // The player as a passenger of the vehicle `id` (`Entity.getPassengers`).
rider_entity :: proc(self: ^Self, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let p = self.player.as_ref().filter(|_| self.riding == Some(id))?;
    // rust: Some(EntityView {
    // rust: kind: "minecraft:player".into(),
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: gamemode: Some(self.mode.name().to_owned()),
    // rust: ..Default::default()
    // rust: })
}
    // A boat as the predicates see it: its type, and its passengers (the
    // mobs seated on it, then the player riding it).
    // rust: pub(super) fn boat_entity(&self, b: &super::boats::Boat) -> EntityView {
    // rust: EntityView {
    // rust: kind: b.entity_type(),
    // rust: position: [b.position.x, b.position.y, b.position.z],
    // rust: on_ground: b.on_ground,
    // rust: passengers: self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.extra.mount == Some(b.id))
    // rust: .map(|m| self.mob_entity(m))
    // rust: .chain(self.rider_entity(b.id))
    // rust: .collect(),
    // rust: ..Default::default()
}
}
    // A dropped item as the predicates see it.
    // rust: pub(super) fn item_entity_view(&self, e: &horizon_client::entities::ItemEntity) -> EntityView {
    // rust: EntityView {
    // rust: kind: "minecraft:item".into(),
    // rust: position: [e.position.x, e.position.y, e.position.z],
    // rust: on_ground: e.on_ground,
    // rust: on_fire: e.fire_ticks > 0,
    // rust: ..Default::default()
}
}
    // rust: pub(super) fn mob_entity(&self, m: &horizon_client::mobs::Mob) -> EntityView {
        // mainhand, offhand, head, chest, legs, feet.
    // rust: let slot = |i: &Option<std::sync::Arc<str>>| {
    // rust: i.as_ref().map(|id| item_view(&ItemStack::new(id, 1)))
}
    // rust: let mut equipment: [Option<ItemView>; 7] = Default::default();
    // rust: equipment[0] = slot(&m.extra.main_hand);
    // rust: equipment[1] = slot(&m.extra.off_hand);
    // rust: equipment[2] = slot(&m.extra.head);
    // rust: equipment[3] = slot(&m.extra.chest);
    // rust: equipment[4] = slot(&m.extra.legs);
    // rust: equipment[5] = slot(&m.extra.feet);
        // The body slot (a wolf's armor, a horse's), with its durability.
    // rust: equipment[6] = m.extra.body.as_ref().map(|id| {
    // rust: let mut armor = ItemStack::new(id, 1);
    // rust: armor.damage = m.extra.body_damage.max(0) as u32;
    // rust: item_view(&armor)
    // rust: });
    // rust: let passengers: Vec<EntityView> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|r| r.extra.mount == Some(m.id))
    // rust: .map(|r| self.mob_entity(r))
    // rust: .chain(self.rider_entity(m.id))
    // rust: .collect();
        // `NbtPredicate.getEntityTagToCompare`: the mob as saved, with the
        // mobs riding it under `Passengers`, when a criterion may ask.
    // rust: let nbt = self.adv.tree.tests_nbt().then(|| {
    // rust: let uuid = self.persist.uuids.get(&m.id).copied().unwrap_or_default();
    // rust: let raw = self.persist.raw.get(&m.id);
    // rust: let registry = Some(self.pack.assets.registry);
    // rust: let mut tag = horizon_client::entity_nbt::mob_to_nbt(m, uuid, raw, registry);
    // rust: let riders = passengers.iter().filter_map(|r| r.nbt.clone()).collect();
    // rust: super::persist::add_passengers(&mut tag, riders);
    // rust: tag
    // rust: });
    // rust: EntityView {
    // rust: kind: m.kind.id.clone(),
    // rust: position: [m.position.x, m.position.y, m.position.z],
    // rust: on_fire: m.fire_ticks > 0,
    // rust: baby: m.is_baby(),
    // rust: on_ground: m.on_ground,
    // rust: equipment,
            // LivingEntity.getActiveEffectsMap supplies the active predicate instances.
    // rust: effects: m
    // rust: .extra
    // rust: .effects
    // rust: .iter()
    // rust: .map(|&(id, duration, amplifier)| {
    // rust: let id = horizon_client::brewing::namespaced(id);
    // rust: (id.to_owned(), amplifier, duration)
    // rust: })
    // rust: .collect(),
    // rust: components: horizon_client::mobs::finalize::variant_component(m)
    // rust: .map(|(id, value)| (id.to_owned(), value))
    // rust: .into_iter()
    // rust: .collect(),
    // rust: passengers,
    // rust: nbt,
    // rust: team: self.mob_team_of(m).map(|t| t.name.clone()),
    // rust: ..Default::default()
}
}
    // `SimpleCriterionTrigger.trigger`: test each open criterion of the
    // trigger and award what it completes.
    // rust: pub(super) fn trigger(&mut self, name: &str, test: impl Fn(&Value, &dyn adv::World) -> bool) {
    // rust: if self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: self.load_advancements();
    // rust: let tree = self.adv.tree.clone();
    // rust: let Some(list) = tree.by_trigger.get(name) else {
    // rust: return;
}
    // rust: self.trigger_criteria(&tree, list, test);
}
    // `trigger` for some of a trigger's criteria: (advancement, criterion)
    // indexes in `tree`, in tree order.
    // rust: fn trigger_criteria(
    // rust: &mut self,
    // rust: tree: &Tree,
    // rust: list: &[(usize, usize)],
    // rust: test: impl Fn(&Value, &dyn adv::World) -> bool,
    // rust: ) {
    // rust: let mut hits = Vec::new();
    // rust: {
    // rust: let view = View(self);
    // rust: for &(ai, ci) in list {
    // rust: let a = &tree.list[ai];
    // rust: let c = &a.criteria[ci];
    // rust: if self.adv.progress.has(&a.id, &c.name) || self.adv.progress.done(a) {
    // rust: continue;
}
    // rust: if test(&c.conditions, &view) {
    // rust: hits.push((ai, ci));
}
}
}
    // rust: if hits.is_empty() {
    // rust: return;
}
    // rust: let date = now_text();
    // rust: for (ai, ci) in hits {
    // rust: let a = &tree.list[ai];
    // rust: let was = self.adv.progress.done(a);
    // rust: let criterion = &a.criteria[ci].name;
    // rust: if self.adv.progress.grant(&a.id, criterion, &date) {
    // rust: self.advancement_progress(&a.id, criterion, true);
    // rust: if let (Some(player), Some(name)) =
    // rust: (self.lan_acting_uuid, self.lan_acting_name.clone())
    // rust: {
    // rust: self.native_player_advancement_criterion_grant(player, &name, &a.id, criterion);
}
}
    // rust: self.progress_changed(ai);
    // rust: if !was && self.adv.progress.done(a) {
    // rust: self.award(ai);
}
}
}
    // `PlayerAdvancements.award` / `revoke` after a criterion's progress changed.
advancement_progress :: proc(self: ^Self, advancement: string, criterion: string, granted: bool) {
}
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: self.native_player_advancement_progress(player, &name, advancement, criterion, granted);
}
}
    // The criteria `CriteriaTriggers.TICK` granted network players in the hub
    // (their first tick and a reload), told to the mods.
    // rust: pub(super) fn run_native_advancement_grants(&mut self) {
    // rust: let Some(host) = self.lan.as_mut() else {
    // rust: return;
}
    // rust: for batch in std::mem::take(&mut host.hub.native_advancement_grants) {
    // rust: for grant in batch.grants {
    // rust: self.native_player_advancement_progress(
    // rust: batch.player,
    // rust: &batch.name,
    // rust: &grant.advancement,
    // rust: &grant.criterion,
    // rust: true,
    // rust: );
}
}
}
    // `PlayerAdvancements.progressChanged`, kept for a network player's client.
progress_changed :: proc(self: ^Self, index: uint) {
}
    // rust: if self.lan_acting.is_some() {
    // rust: self.adv.changed.insert(index);
}
}
    // After `ServerRecipeBook.addRecipes`: the toast and the
    // `recipe_unlocked` trigger of each recipe now known.
    // rust: pub(super) fn recipe_unlocked(&mut self, unlocked: &[String]) {
    // rust: let mut allowed = Vec::with_capacity(unlocked.len());
    // rust: let mut refused = Vec::new();
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: for recipe in unlocked {
    // rust: let mut cancel = false;
    // rust: self.native_player_recipe_discovered(player, &name, recipe, &mut cancel);
    // rust: if cancel {
    // rust: refused.push(recipe.clone());
    // rust: } else {
    // rust: allowed.push(recipe.clone());
}
}
    // rust: if !refused.is_empty() {
    // rust: let removed = self
    // rust: .level
    // rust: .recipe_book
    // rust: .remove_recipes(&world_stations!(self).recipe_index, &refused);
    // rust: if self.lan_acting.is_some() && !removed.is_empty() {
    // rust: self.guest_packets.push(C::RecipeBookRemove(
    // rust: horizon_protocol::packets::recipes::RecipeBookRemove { ids: removed },
    // rust: ));
}
}
    // rust: } else {
    // rust: allowed.extend_from_slice(unlocked);
}
    // rust: if self.lan_acting.is_some() {
            // A network player's client gets them in ClientboundRecipeBookAddPacket.
    // rust: self.adv.unlocked.extend_from_slice(&allowed);
    // rust: } else {
    // rust: self.recipe_toast(&allowed);
}
    // rust: if allowed.is_empty() || self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: self.load_advancements();
    // rust: let tree = self.adv.tree.clone();
    // rust: for r in &allowed {
    // rust: let list = tree.recipe_criteria(r);
    // rust: self.trigger_criteria(&tree, &list, |c, _| {
    // rust: c["recipes"]
    // rust: .as_str()
    // rust: .is_some_and(|id| adv::full(id) == r.as_str())
    // rust: });
}
}
    // `KnowledgeBookItem.use`: the recipes the book names become known and it
    // is used up. A book naming a recipe this server does not have is
    // vanilla's `Invalid recipe: {}` and knows nothing. Whether the click
    // ends here: `InteractionResult.SUCCESS` does and swings, `FAIL` leaves
    // the other hand its turn (`Minecraft.startUseItem`).
    // rust: pub(super) fn use_knowledge_book(&mut self, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:knowledge_book" {
    // rust: return false;
}
    // rust: let slot = self.held_slot();
    // rust: let mut hand = self.stack_in(slot).cloned();
    // rust: let infinite = self.creative;
    // rust: let index = &world_stations!(self).recipe_index;
    // rust: let result = self
    // rust: .level
    // rust: .recipe_book
    // rust: .use_knowledge_book(index, &mut hand, infinite);
    // rust: *self.stack_in_mut(slot) = hand;
    // rust: match result {
    // rust: Ok(unlocked) => {
    // rust: self.recipe_unlocked(&unlocked);
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: self.swing_arm();
    // rust: true
}
    // rust: Err(invalid) => {
    // rust: if let Some(id) = invalid {
    // rust: log::error!("Invalid recipe: {id}");
}
    // rust: false
}
}
}
    // `AdvancementRewards.grant`'s pickup: volume 0.2 at the player's feet,
    // pitch `(nextFloat - nextFloat) * 0.7 + 1`, times 2. `playSound(null, …)`
    // so the player hears it. The draws are the level random, which is the
    // stream item pickup already uses for this pitch.
advancement_pickup_sound :: proc(self: ^Self) {
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: let pitch =
    // rust: ((self.world.random.next_float() - self.world.random.next_float()) * 0.7 + 1.0) * 2.0;
    // rust: self.audio
    // rust: .play("minecraft:entity.item.pickup", Some(at), 0.2, pitch);
}
    // `PlayerAdvancements.award` once done: `AdvancementRewards.grant`,
    // then toast and announcement.
award :: proc(self: ^Self, index: uint) {
}
    // rust: let tree = self.adv.tree.clone();
    // rust: let a = &tree.list[index];
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: self.native_player_advancement_done(player, &name, &a.id);
}
        // AdvancementRewards.grant
    // rust: if a.rewards.experience > 0 {
    // rust: let old_level = self.experience.level;
    // rust: let points = self.xp_change(a.rewards.experience).map_or(0, |p| p.max(0));
    // rust: let gained_level = self.experience.give(points);
    // rust: if let Some(level) = gained_level {
    // rust: self.play_level_up(1, level);
}
    // rust: self.native_player_level_changed(old_level);
}
        // ServerPlayer.awardRecipesByKey: the rewards that name a recipe.
    // rust: let rewards: Vec<String> = a
    // rust: .rewards
    // rust: .recipes
    // rust: .iter()
    // rust: .filter(|r| world_stations!(self).recipe_index.contains(r))
    // rust: .cloned()
    // rust: .collect();
    // rust: let (_, unlocked) = self
    // rust: .level
    // rust: .recipe_book
    // rust: .add_recipes(&world_stations!(self).recipe_index, &rewards);
    // rust: for table in &a.rewards.loot {
    // rust: let items = world_items!(self).loot_table(table, false, None, &mut self.world.random);
    // rust: for s in items {
                // Inventory.add returns false when anything is left, and
                // AdvancementRewards then drops that remainder with no
                // pickup sound. A stack the inventory takes whole plays
                // entity.item.pickup at the player's feet.
    // rust: if let Some(rest) = self.give(s) {
    // rust: if let Some(eye) = self.eye_position() {
    // rust: self.spawn_item(rest, eye, [0.0; 3], 0);
}
    // rust: } else {
    // rust: self.advancement_pickup_sound();
}
}
}
    // rust: if let Some(function) = &a.rewards.function {
    // rust: self.run_advancement_reward_function(function);
}
    // rust: if let Some(d) = &a.display {
            // A network player's client shows its own toast.
    // rust: if d.show_toast
    // rust: && !self.adv.quiet
    // rust: && self.lan_acting.is_none()
    // rust: && self.toast_allowed("advancement", &a.id)
    // rust: {
    // rust: self.adv.toasts.push_back(Toast {
    // rust: icon: d.icon.clone(),
    // rust: frame: d.frame,
    // rust: title: text_of(&d.title),
    // rust: slide: Slide::default(),
    // rust: slot: None,
    // rust: recipes: Vec::new(),
    // rust: changed: false,
    // rust: last_changed: 0,
    // rust: });
}
    // rust: if d.announce && self.ui.rules.bool("show_advancement_messages") {
    // rust: let key = match d.frame {
    // rust: Frame::Task => "chat.type.advancement.task",
    // rust: Frame::Goal => "chat.type.advancement.goal",
    // rust: Frame::Challenge => "chat.type.advancement.challenge",
}
    // rust: let name = adv_name(a);
                // PlayerList.broadcastSystemMessage: everyone hears of a
                // network player's advancement.
    // rust: match self.lan_acting_name.clone() {
                    // Player.getDisplayName.
    // rust: Some(_) => {
    // rust: let player = self.target_name(super::commands::Target::Player);
    // rust: self.adv
    // rust: .announced
    // rust: .push(Text::translate(key, &[player, name]));
}
    // rust: None => {
    // rust: let text = Text::translate(key, &[self.player_display_text(), name]);
                        // The guests hear of the host's advancement too.
    // rust: if let Some(host) = &self.lan {
    // rust: host.hub
    // rust: .system_message(horizon_client::lan::data::component_nbt(
    // rust: &text.component(),
    // rust: ));
}
    // rust: self.system_message(text);
}
}
}
}
    // rust: self.recipe_unlocked(&unlocked);
}
    // `InventoryChangeTrigger`, checked when the inventory changes.
    // rust: pub(super) fn check_inventory_trigger(&mut self) {
//         use std::hash::{Hash, Hasher};
    // rust: let mut h = std::collections::hash_map::DefaultHasher::new();
    // rust: for s in self
    // rust: .inventory
    // rust: .iter()
    // rust: .chain(self.armor.iter())
    // rust: .chain(std::iter::once(&self.offhand))
    // rust: {
    // rust: s.as_ref().map(|s| (&s.item, s.count)).hash(&mut h);
}
    // rust: let key = h.finish();
    // rust: if key == self.adv.last_inventory {
    // rust: return;
}
    // rust: self.adv.last_inventory = key;
    // rust: let stacks: Vec<ItemView> = self
    // rust: .inventory
    // rust: .iter()
    // rust: .chain(self.armor.iter())
    // rust: .chain(std::iter::once(&self.offhand))
    // rust: .flatten()
    // rust: .map(item_view)
    // rust: .collect();
        // InventoryChangeTrigger slots: occupied, full and empty counts.
    // rust: let all: Vec<&Option<ItemStack>> = self
    // rust: .inventory
    // rust: .iter()
    // rust: .chain(self.armor.iter())
    // rust: .chain(std::iter::once(&self.offhand))
    // rust: .collect();
    // rust: let occupied = all.iter().filter(|s| s.is_some()).count() as f64;
    // rust: let empty = all.len() as f64 - occupied;
    // rust: let full = all
    // rust: .iter()
    // rust: .filter_map(|s| s.as_ref())
    // rust: .filter(|s| {
    // rust: self.res
    // rust: .items()
    // rust: .get(&s.item)
    // rust: .is_some_and(|i| s.count >= i.max_stack)
    // rust: })
    // rust: .count() as f64;
        // Only the criteria the items held could pass (`InventoryIndex`).
    // rust: if self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: self.load_advancements();
    // rust: let tree = self.adv.tree.clone();
    // rust: let index = self.inventory_index();
    // rust: let list = index.candidates(stacks.iter().map(|s| s.id.as_str()));
    // rust: if list.is_empty() {
    // rust: return;
}
    // rust: let me = self.player_entity_for("minecraft:inventory_changed");
    // rust: self.trigger_criteria(&tree, &list, move |c, w| {
    // rust: let slots = &c["slots"];
    // rust: let range = |k: &str, v: f64| {
    // rust: let r = &slots[k];
    // rust: r.is_null()
    // rust: || r.as_f64().is_some_and(|n| (n - v).abs() < 0.5)
    // rust: || r.is_object()
    // rust: && r["min"].as_f64().is_none_or(|m| v >= m)
    // rust: && r["max"].as_f64().is_none_or(|m| v <= m)
}
    // rust: if !(range("occupied", occupied) && range("full", full) && range("empty", empty)) {
    // rust: return false;
}
    // rust: let mut wanted: Vec<&Value> = c["items"]
    // rust: .as_array()
    // rust: .map(|a| a.iter().collect())
    // rust: .unwrap_or_default();
    // rust: for s in &stacks {
    // rust: wanted.retain(|p| !adv::item(p, s, w));
}
            // `InventoryChangeTrigger.TriggerInstance`'s `player`
            // (`ContextAwarePredicate`), tested by `SimpleCriterionTrigger.trigger`.
    // rust: wanted.is_empty()
    // rust: && adv::conditions(
    // rust: &c["player"],
    // rust: &adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
    // rust: },
    // rust: w,
    // rust: )
    // rust: });
}
    // `PlayerTrigger.LOCATION` every second, and the other per-tick checks.
    // rust: pub(super) fn tick_advancements(&mut self) {
    // rust: if self.player.is_none() || self.remote.is_some() {
    // rust: return;
}
    // rust: self.check_inventory_trigger();
        // ServerPlayer.tick: PlayerTrigger.TICK every tick.
    // rust: let me = self.player_entity_for("minecraft:tick");
    // rust: self.trigger("minecraft:tick", |c, w| {
    // rust: let ctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &ctx, w)
    // rust: });
        // ServerPlayer.onEffectAdded and onEffectsRemoved keep the start of a
        // levitation; tick fires LEVITATION while there is one.
    // rust: let levitating = self
    // rust: .potions
    // rust: .effects
    // rust: .list
    // rust: .iter()
    // rust: .any(|e| e.id == "levitation");
    // rust: match (levitating, self.adv.levitation) {
    // rust: (true, None) => {
    // rust: let at = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: self.adv.levitation = at.map(|at| (at, self.ticks));
}
    // rust: (false, Some(_)) => self.adv.levitation = None,
    // rust: _ => {}
}
    // rust: if let Some((start, since)) = self.adv.levitation {
    // rust: self.trigger_levitation(start, (self.ticks - since) as i64);
}
    // rust: self.tick_marks();
    // rust: if self.ticks.is_multiple_of(20) {
    // rust: let me = self.player_entity_for("minecraft:location");
    // rust: self.trigger("minecraft:location", |c, w| {
    // rust: let ctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &ctx, w)
    // rust: });
}
}
    // A player condition plus one entity (`player`, `entity` keys).
    // rust: pub(super) fn trigger_entity(&mut self, name: &str, key: &str, target: &EntityView) {
    // rust: let me = self.player_entity_for(name);
    // rust: let target = target.clone();
    // rust: let key = key.to_owned();
    // rust: self.trigger(name, move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let ectx = adv::Entities {
    // rust: this: Some(&target),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w) && adv::conditions(&c[&key], &ectx, w)
    // rust: });
}
    // `KilledTrigger` (`player_killed_entity`): the entity killed and the
    // killing blow's damage source (none: any `killing_blow` fails).
    // rust: pub(super) fn trigger_killed(&mut self, target: &EntityView, blow: Option<&adv::DamageView>) {
    // rust: self.trigger_killed_as("minecraft:player_killed_entity", target, blow);
}
    // `KilledTrigger.trigger` for any of its three instances
    // (`player_killed_entity`, `entity_killed_player`,
    // `kill_mob_near_sculk_catalyst`).
    // rust: pub(super) fn trigger_killed_as(
    // rust: &mut self,
    // rust: name: &str,
    // rust: target: &EntityView,
    // rust: blow: Option<&adv::DamageView>,
    // rust: ) {
    // rust: let me = self.player_entity_for(name);
    // rust: let target = target.clone();
    // rust: let blow = blow.cloned();
    // rust: self.trigger(name, move |c, w| {
    // rust: adv::killed(c, &me, &target, blow.as_ref(), w)
    // rust: });
}
    // `KilledByArrowTrigger`: what the arrow killed and the weapon it came from.
    // rust: pub(super) fn trigger_killed_by_arrow(
    // rust: &mut self,
    // rust: victims: &[EntityView],
    // rust: weapon: Option<&ItemStack>,
    // rust: ) {
    // rust: let me = self.player_entity_for("minecraft:killed_by_arrow");
    // rust: let victims = victims.to_vec();
    // rust: let weapon = weapon.map(item_view);
    // rust: self.trigger("minecraft:killed_by_arrow", move |c, w| {
    // rust: adv::killed_by_arrow(c, &me, &victims, weapon.as_ref(), w)
    // rust: });
}
    // `LevitationTrigger`: how far the player rose from where it started
    // levitating, and for how long.
trigger_levitation :: proc(self: ^Self, start: [f64; 3], duration: i64) {
}
    // rust: let me = self.player_entity_for("minecraft:levitation");
    // rust: self.trigger("minecraft:levitation", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && (c["distance"].is_null() || adv::distance(&c["distance"], start, me.position))
    // rust: && adv::range_i(&c["duration"], duration)
    // rust: });
}
    // `ServerPlayer.tick`: `trackStartFallingPosition` and the end of a fall
    // (`resetFallDistance`), `trackEnteredOrExitedLavaOnVehicle`, the way back
    // from the Nether, and `onEffectAdded`, `onEffectUpdated` and
    // `onEffectsRemoved`, which are seen as each tick ends.
tick_marks :: proc(self: ^Self) {
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: let falling = p.fall_distance > 0.0;
    // rust: let dead = p.health.dead_or_dying();
    // rust: let lava = self
    // rust: .riding
    // rust: .and_then(|id| self.mobs.iter().find(|m| m.id == id))
    // rust: .is_some_and(|m| m.fluids.in_lava);
    // rust: match (falling, self.adv.marks.fall) {
    // rust: (true, None) => {
    // rust: self.adv.marks.fall = Some(at);
                // `trackStartFallingPosition`: the last blast is spent by the
                // fall (whatever made it), and counts only if the player was
                // above where it hit.
    // rust: if let Some((impact, cause)) = self.adv.marks.blast.take()
    // rust: && impact[1] <= at[1]
    // rust: {
    // rust: self.trigger_fall_after_explosion(impact, cause);
}
}
            // `resetFallDistance`: a fall ends by landing, climbing or water.
    // rust: (false, Some(start)) => {
    // rust: self.adv.marks.fall = None;
    // rust: if !dead {
    // rust: self.trigger_distance("minecraft:fall_from_height", start);
}
}
    // rust: _ => {}
}
    // rust: match (lava, self.adv.marks.lava_ride) {
    // rust: (true, None) => self.adv.marks.lava_ride = Some(at),
    // rust: (true, Some(start)) => self.trigger_distance("minecraft:ride_entity_in_lava", start),
    // rust: (false, Some(_)) => self.adv.marks.lava_ride = None,
    // rust: (false, None) => {}
}
        // Back in the Overworld from the Nether: measured from where it was entered.
    // rust: if let Some(start) = self.adv.marks.nether
    // rust: && self.dim == Dim::Overworld
    // rust: {
    // rust: self.adv.marks.nether = None;
    // rust: self.trigger_distance("minecraft:nether_travel", start);
}
    // rust: let effects = self.effects_seen();
        // `onEffectAdded`, `onEffectUpdated` (an `update` that changed the
        // duration, amplifier or flags too) and `onEffectsRemoved`.
    // rust: let changes = self.potions.effects.changes;
    // rust: if effects != self.adv.marks.effects || changes != self.adv.marks.effect_changes {
    // rust: self.adv.marks.effects = effects;
    // rust: self.adv.marks.effect_changes = changes;
    // rust: self.trigger_effects_changed(None);
}
}
    // The (effect, amplifier) pairs `marks.effects` compares.
effects_seen :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.potions
    // rust: .effects
    // rust: .list
    // rust: .iter()
    // rust: .map(|e| (e.id, e.amplifier))
    // rust: .collect()
}
    // `EffectsChangedTrigger` for a change the caller knows the source of;
    // the end-of-tick check then does not fire it a second time.
    // rust: pub(super) fn trigger_effects_changed_by(&mut self, source: Option<EntityView>) {
    // rust: self.adv.marks.effects = self.effects_seen();
    // rust: self.adv.marks.effect_changes = self.potions.effects.changes;
    // rust: self.trigger_effects_changed(source);
}
    // `DistanceTrigger`: the player's `player` condition, `start_position`
    // at `start`, and the `distance` from `start` to the player.
trigger_distance :: proc(self: ^Self, name: string, start: [f64; 3]) {
}
    // rust: let me = self.player_entity_for(name);
    // rust: self.trigger(name, move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::location(&c["start_position"], start, w)
    // rust: && (c["distance"].is_null() || adv::distance(&c["distance"], start, me.position))
    // rust: });
}
    // `FallAfterExplosionTrigger.trigger`: a blast that hit the player at
    // `impact` (made by `cause`, or by nothing), measured to where the
    // player is now. `matches` tests `cause` only when the instance has one,
    // and a missing cause fails it.
trigger_fall_after_explosion :: proc(self: ^Self, impact: [f64; 3], cause: Maybe(EntityView)) {
}
    // rust: let me = self.player_entity_for("minecraft:fall_after_explosion");
    // rust: self.trigger("minecraft:fall_after_explosion", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::location(&c["start_position"], impact, w)
    // rust: && (c["distance"].is_null() || adv::distance(&c["distance"], impact, me.position))
    // rust: && (c["cause"].is_null()
    // rust: || cause.as_ref().is_some_and(|cause| {
    // rust: let cctx = adv::Entities {
    // rust: this: Some(cause),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["cause"], &cctx, w)
    // rust: }))
    // rust: });
}
    // `EffectsChangedTrigger`: the player's `effects`, and for an effect that
    // `source` gave, that entity (`source`).
trigger_effects_changed :: proc(self: ^Self, source: Maybe(EntityView)) {
}
    // rust: let me = self.player_entity_for("minecraft:effects_changed");
    // rust: self.trigger("minecraft:effects_changed", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let effects = c["effects"].is_null()
    // rust: || adv::entity(
    // rust: &serde_json::json!({ "minecraft:effects": c["effects"] }),
    // rust: &me,
    // rust: w,
    // rust: me.position,
    // rust: );
    // rust: let source = c["source"].is_null()
    // rust: || source.as_ref().is_some_and(|s| {
    // rust: let sctx = adv::Entities {
    // rust: this: Some(s),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["source"], &sctx, w)
    // rust: });
    // rust: adv::conditions(&c["player"], &pctx, w) && effects && source
    // rust: });
}
    // `ItemDurabilityTrigger.trigger` and `TriggerInstance.matches`: a player's
    // item takes damage (`ItemStack.applyDamage`), `stack` as it is before the
    // damage and `new_damage` the unclamped damage value it is about to get.
    // `durability` tests `maxDamage - newDamage`, `delta` tests
    // `damageValue - newDamage`.
    // rust: pub(super) fn trigger_item_durability(&mut self, stack: &ItemStack, new_damage: u32) {
    // rust: if self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: let me = self.player_entity_for("minecraft:item_durability_changed");
    // rust: let item = item_view(stack);
    // rust: let max = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .map_or(0, |i| i.max_damage) as i64;
        // ItemStack.getDamageValue clamps to 0..=getMaxDamage.
    // rust: let damage = i64::from(stack.damage).clamp(0, max);
    // rust: let new_damage = i64::from(new_damage);
    // rust: self.trigger("minecraft:item_durability_changed", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && (c["item"].is_null() || adv::item(&c["item"], &item, w))
    // rust: && adv::range_i(&c["durability"], max - new_damage)
    // rust: && adv::range_i(&c["delta"], damage - new_damage)
    // rust: });
}
    // `ServerPlayer.updateUsingItem`: USING_ITEM for the item in use.
    // rust: pub(super) fn trigger_using_item(&mut self, stack: &ItemStack) {
    // rust: if self.remote.is_some() || self.no_player_here() {
    // rust: return;
}
    // rust: let me = self.player_entity_for("minecraft:using_item");
    // rust: let it = item_view(stack);
    // rust: self.trigger("minecraft:using_item", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w) && adv::item(&c["item"], &it, w)
    // rust: });
}
    // The entity a 100 block ray from the eyes meets first, if no block is
    // in the way (`ProjectileUtil.getEntityHitResult` over every entity but
    // the player that is not a spectator, then `hasLineOfSight`).
looking_at_entity :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
//         use super::commands::Target;
//         use super::entity::{Entity as _, entity_lists_of, for_each_entity};
//         use horizon_core::geometry::Aabb;
    // rust: let eye = self.eye_position()?;
    // rust: let dir = super::view_vector(self.yaw, self.pitch);
    // rust: let mut best: Option<(Target, f64)> = None;
    // rust: let mut offer = |t: Option<Target>, b: Aabb| {
    // rust: if let Some(t) = t
    // rust: && let Some(d) = super::ray_box(eye, dir, 100.0, b)
    // rust: && best.is_none_or(|(_, bd)| d < bd)
    // rust: {
    // rust: best = Some((t, d));
}
}
    // rust: for_each_entity!(entity_lists_of!(self), e => {
    // rust: if !e.is_removed() {
    // rust: offer(e.selector_target(), e.bounds());
}
    // rust: });
    // rust: let aabb = |(lo, hi): ([f64; 3], [f64; 3])| {
    // rust: Aabb::new(
    // rust: Vec3::new(lo[0], lo[1], lo[2]),
    // rust: Vec3::new(hi[0], hi[1], hi[2]),
    // rust: )
}
    // rust: for f in self.item_frames.iter() {
    // rust: offer(Some(Target::Frame(f.id)), aabb(f.bounds()));
}
    // rust: for p in self.paintings.iter() {
    // rust: offer(Some(Target::Painting(p.id)), aabb(p.bounds()));
}
    // rust: for c in self.crystals.iter() {
    // rust: offer(Some(Target::Crystal(c.id)), c.bounds());
}
    // rust: let (t, _) = best?;
        // `LivingEntity.hasLineOfSight`: eye to the target's eye height,
        // `ClipContext.Block.COLLIDER`, no fluids, within 128 blocks.
    // rust: let at = self.target_position(t)?;
    // rust: let from = Vec3::new(eye[0], eye[1], eye[2]);
    // rust: let to = Vec3::new(at[0], at[1] + self.target_eye_height(t), at[2]);
    // rust: let world = self.mob_world_base(&[]);
    // rust: let clear = to.distance(from) <= 128.0 && world.clear_between(from, to, false);
    // rust: if !clear {
    // rust: return None;
}
    // rust: Some(match t {
    // rust: Target::Mob(id) => self.mob_entity(self.mobs.iter().find(|m| m.id == id)?),
    // rust: Target::Boat(id) => self.boat_entity(self.boats.iter().find(|b| b.id == id)?),
    // rust: other => self.entity_view_of(other),
    // rust: })
}
    // `PlayerHurtEntityTrigger`: the player, the damage and the victim.
    // rust: pub(super) fn trigger_player_hurt_entity(
    // rust: &mut self,
    // rust: victim: &EntityView,
    // rust: damage: &adv::DamageView,
    // rust: ) {
    // rust: let me = self.player_entity_for("minecraft:player_hurt_entity");
    // rust: let (victim, damage) = (victim.clone(), damage.clone());
    // rust: self.trigger("minecraft:player_hurt_entity", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let vctx = adv::Entities {
    // rust: this: Some(&victim),
    // rust: ..pctx
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::damage(&c["damage"], &damage, w, me.position)
    // rust: && adv::conditions(&c["entity"], &vctx, w)
    // rust: });
}
    // The player's hit on `victim` as `LivingEntity.hurtServer` reports it:
    // `kind` damage of `amount` from `direct` (the player's own hand when
    // `None`), nothing blocked.
    // rust: pub(super) fn player_hit(
    // rust: &mut self,
    // rust: victim: &EntityView,
    // rust: kind: &str,
    // rust: direct: Option<EntityView>,
    // rust: amount: f32,
    // rust: ) {
    // rust: let me = self.player_entity_for("minecraft:player_hurt_entity");
    // rust: self.trigger_player_hurt_entity(
    // rust: victim,
    // rust: &adv::DamageView {
    // rust: kind: kind.to_owned(),
    // rust: is_direct: direct.is_none(),
    // rust: direct: direct.or_else(|| Some(me.clone())),
    // rust: source: Some(me),
    // rust: original: amount,
    // rust: actual: amount,
    // rust: blocked: false,
    // rust: },
    // rust: );
}
    // `EntityHurtPlayerTrigger`: the player and the damage it took.
    // rust: pub(super) fn trigger_entity_hurt_player(&mut self, damage: &adv::DamageView) {
    // rust: let me = self.player_entity_for("minecraft:entity_hurt_player");
    // rust: let damage = damage.clone();
    // rust: self.trigger("minecraft:entity_hurt_player", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::damage(&c["damage"], &damage, w, me.position)
    // rust: });
}
    // A player condition plus one item (`item` key).
    // rust: pub(super) fn trigger_item(&mut self, name: &str, stack: &ItemStack) {
    // rust: let me = self.player_entity_for(name);
    // rust: let it = item_view(stack);
    // rust: self.trigger(name, move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w) && adv::item(&c["item"], &it, w)
    // rust: });
}
    // rust: pub(super) fn trigger_item_entity(
    // rust: &mut self,
    // rust: name: &str,
    // rust: stack: &ItemStack,
    // rust: target: &EntityView,
    // rust: ) {
    // rust: let me = self.player_entity_for(name);
    // rust: let it = item_view(stack);
    // rust: self.trigger(name, |c, w| adv::item_entity(c, &me, target, &it, w));
}
    // `ServerPlayer.onItemPickup`: the player in place (the host, or the
    // guest `as_guest` runs) picked up an item entity whose owner
    // (`ItemEntity.getOwner`, the thrower) is `thrower`: the whole stack, or
    // what is left after a partial take. An owner that is that player also
    // fires `LivingEntity.onItemPickup` (the by-entity trigger); one that is
    // gone, or another player, fires nothing here.
    // rust: pub(super) fn trigger_thrown_picked_up_by_player(
    // rust: &mut self,
    // rust: stack: &ItemStack,
    // rust: thrower: [i32; 4],
    // rust: ) {
    // rust: let target = if thrower == self.acting_uuid() {
            // The player is the entity of both triggers.
    // rust: let me = self.player_entity_for_any(&[
    // rust: "minecraft:thrown_item_picked_up_by_entity",
    // rust: "minecraft:thrown_item_picked_up_by_player",
    // rust: ]);
    // rust: self.trigger_item_entity("minecraft:thrown_item_picked_up_by_entity", stack, &me);
    // rust: me
    // rust: } else if let Some(id) = self.mob_by_uuid(thrower) {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: self.mob_entity(m)
    // rust: } else {
    // rust: return;
}
    // rust: self.trigger_item_entity("minecraft:thrown_item_picked_up_by_player", stack, &target);
}
    // `ConstructBeaconTrigger`: the pyramid levels of the new beacon.
    // rust: pub(super) fn trigger_construct_beacon(&mut self, levels: i32) {
    // rust: let me = self.player_entity_for("minecraft:construct_beacon");
    // rust: self.trigger("minecraft:construct_beacon", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w) && adv::range_i(&c["level"], i64::from(levels))
    // rust: });
}
    // `EnchantedItemTrigger`: the enchanted item and the levels it cost.
    // rust: pub(super) fn trigger_enchanted_item(&mut self, stack: &ItemStack, levels: i32) {
    // rust: let me = self.player_entity_for("minecraft:enchanted_item");
    // rust: let it = item_view(stack);
    // rust: self.trigger("minecraft:enchanted_item", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::item(&c["item"], &it, w)
    // rust: && adv::range_i(&c["levels"], i64::from(levels))
    // rust: });
}
    // `BrewedPotionTrigger`: the potion contents of a stack taken from a
    // brewing stand.
    // rust: pub(super) fn trigger_brewed_potion(&mut self, stack: &ItemStack) {
    // rust: let me = self.player_entity_for("minecraft:brewed_potion");
    // rust: let potion = stack.potion().map(str::to_owned);
    // rust: self.trigger("minecraft:brewed_potion", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::potions(&c["potion"], potion.as_deref(), w)
    // rust: });
}
    // `TradeTrigger`: the villager and the item the trade gave.
    // rust: pub(super) fn trigger_trade(&mut self, villager: &EntityView, stack: &ItemStack) {
    // rust: let me = self.player_entity_for("minecraft:villager_trade");
    // rust: let villager = villager.clone();
    // rust: let it = item_view(stack);
    // rust: self.trigger("minecraft:villager_trade", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let vctx = adv::Entities {
    // rust: this: Some(&villager),
    // rust: ..pctx
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::conditions(&c["villager"], &vctx, w)
    // rust: && adv::item(&c["item"], &it, w)
    // rust: });
}
    // `FishingRodHookedTrigger`: the rod, what the hook is in (or the hook)
    // and the items it caught.
    // rust: pub(super) fn trigger_fishing_rod_hooked(
    // rust: &mut self,
    // rust: rod: &ItemStack,
    // rust: hooked: &EntityView,
    // rust: items: &[ItemStack],
    // rust: ) {
    // rust: let me = self.player_entity_for("minecraft:fishing_rod_hooked");
    // rust: let rod = item_view(rod);
    // rust: let hooked = hooked.clone();
    // rust: let items: Vec<ItemView> = items.iter().map(item_view).collect();
    // rust: self.trigger("minecraft:fishing_rod_hooked", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let ectx = adv::Entities {
    // rust: this: Some(&hooked),
    // rust: ..pctx
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::item(&c["rod"], &rod, w)
    // rust: && adv::conditions(&c["entity"], &ectx, w)
    // rust: && (c["item"].is_null() || items.iter().any(|i| adv::item(&c["item"], i, w)))
    // rust: });
}
    // `EnterBlockTrigger`: the block, its state properties and the player.
    // rust: pub(super) fn trigger_enter_block(&mut self, state: horizon_world::registry::BlockStateId) {
    // rust: let Some(definition) = self.pack.assets.registry.state(state).cloned() else {
    // rust: return;
}
    // rust: let me = self.player_entity_for("minecraft:enter_block");
    // rust: self.trigger("minecraft:enter_block", move |c, w| {
    // rust: let block_ok = adv::id_matches(&c["blocks"], "block", &definition.name, w);
    // rust: let state_ok = c["state"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|(k, v)| definition.properties.get(k).map(String::as_str) == v.as_str());
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: block_ok && state_ok && adv::conditions(&c["player"], &pctx, w)
    // rust: });
}
    // `SlideDownBlockTrigger`: match the actual block and its state.
    // rust: pub(super) fn trigger_honey_slide(&mut self, pos: [i32; 3]) {
    // rust: let me = self.player_entity_for("minecraft:slide_down_block");
    // rust: self.trigger("minecraft:slide_down_block", move |c, w| {
    // rust: let ctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &ctx, w) && adv::block(c, pos, w)
    // rust: });
}

    // `TargetBlockTrigger`: signal and projectile conditions are evaluated in
    // the shooter's context, including distance from the shooter.
    // rust: pub(super) fn trigger_target_hit(&mut self, projectile: &EntityView, strength: i32) {
    // rust: let me = self.player_entity_for("minecraft:target_hit");
    // rust: let projectile = projectile.clone();
    // rust: self.trigger("minecraft:target_hit", move |c, w| {
    // rust: let player = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let target = adv::Entities {
    // rust: this: Some(&projectile),
    // rust: ..player
}
    // rust: adv::conditions(&c["player"], &player, w)
    // rust: && adv::range_i(&c["signal_strength"], i64::from(strength))
    // rust: && adv::conditions(&c["projectile"], &target, w)
    // rust: });
}

    // `ItemUsedOnLocationTrigger` (placed_block, item_used_on_block).
    // rust: pub(super) fn trigger_block(&mut self, name: &str, pos: [i32; 3], stack: &ItemStack) {
    // rust: let me = self.player_entity_for(name);
    // rust: let it = item_view(stack);
    // rust: self.trigger(name, move |c, w| {
    // rust: let ctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: Some(&it),
    // rust: block_pos: Some(pos),
}
    // rust: adv::conditions(&c["location"], &ctx, w)
    // rust: });
}
    // `DefaultBlockInteractionTrigger` (default_block_use): the player, and
    // the block's `BLOCK_USE` context at its centre, with no tool.
    // rust: pub(super) fn trigger_default_block_use(&mut self, pos: [i32; 3]) {
    // rust: self.trigger_block_use("minecraft:default_block_use", pos, None);
}
    // `AnyBlockInteractionTrigger` (any_block_use): the player, and the
    // block's `ADVANCEMENT_LOCATION` context at its centre with the stack in
    // hand as the use left it.
    // rust: pub(super) fn trigger_any_block_use(&mut self, pos: [i32; 3], stack: &ItemStack) {
    // rust: self.trigger_block_use("minecraft:any_block_use", pos, Some(stack));
}
trigger_block_use :: proc(self: ^Self, name: string, pos: [i32; 3], stack: Maybe(^ItemStack)) {
}
    // rust: let me = self.player_entity_for(name);
    // rust: let it = stack.map(item_view);
    // rust: let centre = pos.map(|c| f64::from(c) + 0.5);
    // rust: self.trigger(name, move |c, w| {
    // rust: let player = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let location = adv::Entities {
    // rust: origin: centre,
    // rust: tool: it.as_ref(),
    // rust: block_pos: Some(pos),
    // rust: ..player
}
    // rust: adv::conditions(&c["player"], &player, w)
    // rust: && adv::conditions(&c["location"], &location, w)
    // rust: });
}
    // `LightningStrikeTrigger`: the bolt, and the mobs around it that it did
    // not hit (`bystander`), each tested from this player's position.
    // rust: pub(super) fn trigger_lightning_strike(&mut self, bolt: &EntityView, viewers: &[EntityView]) {
    // rust: let me = self.player_entity_for("minecraft:lightning_strike");
    // rust: let (bolt, viewers) = (bolt.clone(), viewers.to_vec());
    // rust: self.trigger("minecraft:lightning_strike", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let bctx = adv::Entities {
    // rust: this: Some(&bolt),
    // rust: ..pctx
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::conditions(&c["lightning"], &bctx, w)
    // rust: && (c["bystander"].is_null()
    // rust: || viewers.iter().any(|v| {
    // rust: adv::conditions(
    // rust: &c["bystander"],
    // rust: &adv::Entities {
    // rust: this: Some(v),
    // rust: ..pctx
    // rust: },
    // rust: w,
    // rust: )
    // rust: }))
    // rust: });
}
    // `ChanneledLightningTrigger`: each victim condition matched by some
    // mob the bolt hit, from the player who channelled it.
    // rust: pub(super) fn trigger_channeled_lightning(&mut self, victims: &[EntityView]) {
    // rust: let me = self.player_entity_for("minecraft:channeled_lightning");
    // rust: let victims = victims.to_vec();
    // rust: self.trigger("minecraft:channeled_lightning", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && c["victims"].as_array().into_iter().flatten().all(|want| {
    // rust: victims.iter().any(|v| {
    // rust: adv::conditions(
    // rust: want,
    // rust: &adv::Entities {
    // rust: this: Some(v),
    // rust: ..pctx
    // rust: },
    // rust: w,
    // rust: )
    // rust: })
    // rust: })
    // rust: });
}
    // `SpearMobsTrigger`: the living entities the spear stabbed in this use.
    // rust: pub(super) fn trigger_spear_mobs(&mut self, stabbed: usize) {
    // rust: let me = self.player_entity_for("minecraft:spear_mobs");
    // rust: self.trigger("minecraft:spear_mobs", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && c["count"].as_u64().is_none_or(|n| stabbed as u64 >= n)
    // rust: });
}
    // `BeeNestDestroyedTrigger`: the nest's block state, the tool that broke
    // it and the bees left inside.
    // rust: pub(super) fn trigger_bee_nest_destroyed(
    // rust: &mut self,
    // rust: state: horizon_world::registry::BlockStateId,
    // rust: tool: Option<&ItemStack>,
    // rust: bees: i64,
    // rust: ) {
    // rust: let Some(definition) = self.pack.assets.registry.state(state).cloned() else {
    // rust: return;
}
    // rust: let me = self.player_entity_for("minecraft:bee_nest_destroyed");
    // rust: let tool = tool.map(item_view).unwrap_or_default();
    // rust: self.trigger("minecraft:bee_nest_destroyed", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: let state_ok = c["state"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|(k, v)| definition.properties.get(k).map(String::as_str) == v.as_str());
    // rust: adv::id_matches(&c["blocks"], "block", &definition.name, w)
    // rust: && state_ok
    // rust: && adv::item(&c["item"], &tool, w)
    // rust: && adv::range_i(&c["num_bees_inside"], bees)
    // rust: && adv::conditions(&c["player"], &pctx, w)
    // rust: });
}
    // `Entity.startRiding`'s `sendEventAndTriggers`: `START_RIDING_TRIGGER`
    // for every `ServerPlayer` in `entityToRide.getIndirectPassengersStream()`.
    // rust: pub(super) fn trigger_started_riding(&mut self, vehicle: u32) {
    // rust: let mounts: Vec<(u32, Option<u32>)> =
    // rust: self.mobs.iter().map(|m| (m.id, m.extra.mount)).collect();
    // rust: let aboard = super::boarding::passenger_vehicles(vehicle, &mounts);
    // rust: self.for_each_player(|g| {
    // rust: if g.riding.is_some_and(|v| aboard.contains(&v)) {
    // rust: g.trigger_player("minecraft:started_riding");
}
    // rust: });
}
    // A trigger with only the player condition (slept_in_bed, started_riding).
    // rust: pub(super) fn trigger_player(&mut self, name: &str) {
    // rust: let me = self.player_entity_for(name);
    // rust: self.trigger(name, move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: });
}
    // `RecipeCraftedTrigger`: the recipe and the stacks that went into it
    // (`ServerPlayer.triggerRecipeCrafted`); an empty slot is air.
    // rust: pub(super) fn trigger_recipe_crafted(
    // rust: &mut self,
    // rust: recipe: &str,
    // rust: ingredients: &[Option<ItemStack>],
    // rust: ) {
    // rust: let me = self.player_entity_for("minecraft:recipe_crafted");
    // rust: let used: Vec<ItemView> = ingredients
    // rust: .iter()
    // rust: .map(|s| {
    // rust: s.as_ref().map_or_else(
    // rust: || ItemView {
    // rust: id: "minecraft:air".to_owned(),
    // rust: ..Default::default()
    // rust: },
    // rust: item_view,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let recipe = recipe.to_owned();
    // rust: self.trigger("minecraft:recipe_crafted", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::id_matches(&c["recipes"], "recipe", &recipe, w)
    // rust: && adv::recipe_ingredients(&c["ingredients"], &used, w)
    // rust: });
}
    // `LootTableTrigger`: a container's loot table unpacked for this player
    // (`RandomizableContainer.unpackLootTable`).
    // rust: pub(super) fn trigger_loot_table(&mut self, table: &str) {
    // rust: let me = self.player_entity_for("minecraft:player_generates_container_loot");
    // rust: let table = table.to_owned();
    // rust: self.trigger("minecraft:player_generates_container_loot", move |c, w| {
    // rust: let pctx = adv::Entities {
    // rust: this: Some(&me),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &pctx, w)
    // rust: && adv::id_matches(&c["loot_tables"], "loot_table", &table, w)
    // rust: });
}
    // `BredAnimalsTrigger`.
    // rust: pub(super) fn trigger_bred(
    // rust: &mut self,
    // rust: parent: &EntityView,
    // rust: partner: &EntityView,
    // rust: child: Option<&EntityView>,
    // rust: ) {
    // rust: let me = self.player_entity_for("minecraft:bred_animals");
    // rust: let (parent, partner, child) = (parent.clone(), partner.clone(), child.cloned());
    // rust: self.trigger("minecraft:bred_animals", move |c, w| {
    // rust: let ctx = |e: &EntityView| {
    // rust: adv::Entities {
    // rust: this: Some(e),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: .this
    // rust: .map(|_| ())
}
    // rust: let _ = ctx;
    // rust: let test = |key: &str, e: Option<&EntityView>| {
    // rust: c[key].is_null()
    // rust: || e.is_some_and(|e| {
    // rust: adv::conditions(
    // rust: &c[key],
    // rust: &adv::Entities {
    // rust: this: Some(e),
    // rust: origin: me.position,
    // rust: tool: None,
    // rust: block_pos: None,
    // rust: },
    // rust: w,
    // rust: )
    // rust: })
}
            // matches(parent, partner, child) or (partner, parent, child).
    // rust: (test("parent", Some(&parent)) && test("partner", Some(&partner))
    // rust: || test("parent", Some(&partner)) && test("partner", Some(&parent)))
    // rust: && test("child", child.as_ref())
    // rust: });
}
    // `ChangeDimensionTrigger`, and `ServerPlayer.enteredNetherPosition`: the
    // Overworld position the player went into the Nether from (`at`) is kept
    // for the way back, and any other trip drops it.
    // rust: pub(super) fn trigger_dimension(&mut self, from: Dim, to: Dim, at: [f64; 3]) {
    // rust: let (from_id, to_id) = (from.id().to_owned(), to.id().to_owned());
    // rust: self.trigger("minecraft:changed_dimension", move |c, _| {
    // rust: c["from"].as_str().is_none_or(|f| adv::full(f) == from_id)
    // rust: && c["to"].as_str().is_none_or(|t| adv::full(t) == to_id)
    // rust: });
    // rust: if from == Dim::Overworld && to == Dim::Nether {
    // rust: self.adv.marks.nether = Some(at);
    // rust: } else if !(from == Dim::Nether && to == Dim::Overworld) {
    // rust: self.adv.marks.nether = None;
}
}
    // `ToastManager.SLOT_COUNT`.
    // rust: pub(super) const TOAST_SLOTS: usize = 5;
    // `ToastManager.update` and `extractRenderState` for the `AdvancementToast`s and
    // `RecipeToast`s: up to five stack in 32-pixel slots, the rest queue. `hidden` (F1)
    // keeps them timing out without drawing them.
    // rust: pub(super) fn draw_toasts(&mut self, batch: &mut HudBatch, hidden: bool) {
    // rust: let multiplier = f64::from(self.settings.notification_display_time);
    // rust: let mut sound_played = false;
    // rust: let mut i = 0;
    // rust: while i < self.adv.toasts.len() {
    // rust: let t = &mut self.adv.toasts[i];
    // rust: if t.slot.is_none() {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let origin = *t.slide.origin.get_or_insert_with(Instant::now);
    // rust: let now = origin.elapsed().as_millis() as i64;
    // rust: let mut slide = std::mem::take(&mut t.slide);
    // rust: let (sound, finished) = slide.update(now, |fully| t.wants_show(fully, multiplier));
    // rust: t.slide = slide;
    // rust: if finished {
    // rust: self.adv.toasts.remove(i);
    // rust: continue;
}
            // Only the first visibility change of an update plays its sound.
    // rust: if let Some(show) = sound
    // rust: && !std::mem::replace(&mut sound_played, true)
    // rust: {
    // rust: let event = if show { "ui.toast.in" } else { "ui.toast.out" };
    // rust: self.audio
    // rust: .play(&format!("minecraft:{event}"), None, 1.0, 1.0);
}
    // rust: i += 1;
}
        // The queued toasts take the free slots in order; a challenge's own sound
        // plays once as it leaves the queue.
    // rust: let mut used = self.toast_slots_used();
    // rust: let mut challenge_sound = false;
    // rust: for t in &mut self.adv.toasts {
    // rust: if t.slot.is_some() {
    // rust: continue;
}
    // rust: let Some(slot) = (0..Self::TOAST_SLOTS).find(|s| used & (1 << s) == 0) else {
    // rust: break;
}
    // rust: used |= 1 << slot;
    // rust: t.slot = Some(slot);
    // rust: challenge_sound |= !t.is_recipe() && t.frame == Frame::Challenge;
}
    // rust: if challenge_sound {
    // rust: self.audio
    // rust: .play("minecraft:ui.toast.challenge_complete", None, 1.0, 1.0);
}
    // rust: if hidden {
    // rust: return;
}
    // rust: for i in 0..self.adv.toasts.len() {
    // rust: if let Some(slot) = self.adv.toasts[i].slot {
    // rust: self.draw_toast(batch, i, 32.0 * slot as f32, multiplier);
}
}
}
    // The slots held by shown advancement, recipe, pack and narrator toasts,
    // as bits.
    // rust: pub(super) fn toast_slots_used(&self) -> u32 {
    // rust: let packs = self.server_packs.toast_slots();
    // rust: self.adv
    // rust: .toasts
    // rust: .iter()
    // rust: .filter_map(|t| t.slot)
    // rust: .chain(packs)
    // rust: .chain(self.narrator_toast.as_ref().and_then(|t| t.slot))
    // rust: .fold(self.tutorial_toast_slots(), |used, slot| used | 1 << slot)
}
    // `ToastManager.addToast`'s `ToastAddEvent`: whether a new toast of
    // `kind` (`id` within it) may be queued; false when a mod cancelled it.
    // Always asked: a bundle injected at the hook point is not in `mods()`.
    // rust: pub(super) fn toast_allowed(&mut self, kind: &str, id: &str) -> bool {
    // rust: let mut cancel = false;
    // rust: self.native_toast_add(kind, id, &mut cancel);
    // rust: !cancel
}
    // The `AdvancementToast` or `RecipeToast` at `index` in its slot at `y`.
draw_toast :: proc(self: ^Self, batch: ^HudBatch, index: uint, y: f32, multiplier: f64) {
}
    // rust: let t = &self.adv.toasts[index];
    // rust: let x = batch.width - 160.0 * t.slide.portion;
    // rust: let fully_for = t.slide.fully_for;
    // rust: let (title, frame, icon) = (t.title.clone(), t.frame, t.icon.clone());
    // rust: let recipe = t
    // rust: .is_recipe()
    // rust: .then(|| t.recipes[t.displayed_recipe(fully_for, multiplier)].clone());
    // rust: if let Some((station, item)) = recipe {
            // RecipeToast: black description under a purple title, the
            // station at 0.6 scale in the corner over the cycling result.
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.sprite(atlas, "gui/sprites/toast/recipe", x, y);
    // rust: let title = self.translate("recipe.toast.title", "New Recipe(s) Unlocked!");
    // rust: let description = self.translate("recipe.toast.description", "Check your recipe book");
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.text(atlas, &title, x + 30.0, y + 7.0, 0xFF50_0050, false);
    // rust: batch.text(atlas, &description, x + 30.0, y + 18.0, 0xFF00_0000, false);
    // rust: let start = batch.vertices.len();
    // rust: self.draw_item_model(batch, &ItemStack::new(&station, 1), x + 3.0, y + 3.0);
    // rust: batch.scale_since(start, x, y, 0.6, 0.6);
    // rust: self.draw_item_model(batch, &item, x + 8.0, y + 8.0);
    // rust: return;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: batch.sprite(atlas, "gui/sprites/toast/advancement", x, y);
    // rust: let (key, color) = toast_label(frame);
        // AdvancementToast.extractRenderState: a title of one line sits under
        // the frame's label; a longer one is wrapped at 125, the label fading
        // out first (to 1.5 s) and the lines fading in after it over 0.3 s.
    // rust: let lines = atlas.font.split(&title.resolve_legacy(), 125.0);
    // rust: let label = Text::translate(key, &[]);
    // rust: let rgb = color & 0x00FF_FFFF;
    // rust: if let [line] = lines.as_slice() {
    // rust: batch.text_styled(atlas, &label, x + 30.0, y + 7.0, color, false);
    // rust: batch.text_styled(atlas, line, x + 30.0, y + 18.0, u32::MAX, false);
    // rust: } else if fully_for < 1500 {
    // rust: let fade = ((1500 - fully_for) as f32 / 300.0).clamp(0.0, 1.0);
    // rust: let alpha = (fade * 255.0).floor() as u32;
    // rust: if alpha != 0 {
    // rust: batch.text_styled(atlas, &label, x + 30.0, y + 11.0, alpha << 24 | rgb, false);
}
    // rust: } else {
    // rust: let fade = ((fully_for - 1500) as f32 / 300.0).clamp(0.0, 1.0);
    // rust: let alpha = (fade * 252.0).floor() as u32;
    // rust: if alpha != 0 {
    // rust: let mut line_y = y + (16 - lines.len() as i32 * 9 / 2) as f32;
    // rust: for line in &lines {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: line,
    // rust: x + 30.0,
    // rust: line_y,
    // rust: alpha << 24 | 0x00FF_FFFF,
    // rust: false,
    // rust: );
    // rust: line_y += 9.0;
}
}
}
    // rust: self.draw_item(batch, &ItemStack::new(&icon, 1), x + 8.0, y + 8.0);
}
}
// The toast's frame label and its colour (`AdvancementToast`: -30465, pink,
// for a challenge, else -256, yellow), packed as `hud::rgba` for the batch.
toast_label :: proc(frame: Frame) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match frame {
    // rust: Frame::Task => ("advancements.toast.task", rgba(255, 255, 0, 255)),
    // rust: Frame::Goal => ("advancements.toast.goal", rgba(255, 255, 0, 255)),
    // rust: Frame::Challenge => ("advancements.toast.challenge", rgba(255, 136, 255, 255)),
}
}
// `Advancement.name`: the bracketed title in the frame's colour, with the
// description on hover; the id when there is no display.
    // rust: pub(super) fn adv_name(a: &adv::Advancement) -> Text {
    // rust: let Some(d) = &a.display else {
    // rust: return Text::literal(a.id.clone());
}
    // rust: let color = frame_color(d.frame);
    // rust: let title = text_of(&d.title).with_style(&Style {
    // rust: hover: Some(Box::new(decorate_name(d))),
    // rust: ..Style::default()
    // rust: });
    // rust: Text::translate("chat.square_brackets", &[title]).with_color(color)
}
frame_color :: proc(frame: Frame) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match frame {
    // rust: Frame::Challenge => text::DARK_PURPLE,
    // rust: _ => text::GREEN,
}
}
// `Advancement.decorateName`: a copy of the title with the frame's colour
// under its own style (mergeStyles), then a new line and the description
// after the title's own siblings, so both inherit the title's root style.
// Built on the title's JSON (a list as its first element with the rest as
// siblings): a parsed Text moves a styled root's style down a level once it
// has siblings.
decorate_name :: proc(d: ^adv::Display) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut component = match horizon_client::scoreboard::canonical_component(&d.title) {
    // rust: Value::String(s) => serde_json::json!({ "text": s }),
    // rust: c => c,
}
    // rust: if let Some(o) = component.as_object_mut() {
    // rust: let frame = Text::empty().with_color(frame_color(d.frame)).component();
    // rust: o.entry("color").or_insert_with(|| frame["color"].clone());
    // rust: let extra = o.entry("extra").or_insert_with(|| serde_json::json!([]));
    // rust: if let Some(extra) = extra.as_array_mut() {
    // rust: extra.extend(["\n".into(), d.description.clone()]);
}
}
    // rust: text_of(&component).with_component(component)
}
    // rust: impl Game<'_> {
    // `AdvancementCommands.Action.GRANT` on one advancement (or one of
    // its criteria): false when nothing changed.
    // rust: pub(super) fn grant_advancement(&mut self, index: usize, criterion: Option<&str>) -> bool {
    // rust: let tree = self.adv.tree.clone();
    // rust: let a = &tree.list[index];
    // rust: if criterion.is_none() && self.adv.progress.done(a) {
    // rust: return false;
}
    // rust: let names: Vec<&str> = match criterion {
    // rust: Some(c) => vec![c],
    // rust: None => a.criteria.iter().map(|c| c.name.as_str()).collect(),
}
    // rust: let date = now_text();
    // rust: let mut changed = false;
    // rust: for c in names {
    // rust: let was = self.adv.progress.done(a);
    // rust: if self.adv.progress.grant(&a.id, c, &date) {
    // rust: changed = true;
    // rust: self.advancement_progress(&a.id, c, true);
    // rust: self.progress_changed(index);
    // rust: if !was && self.adv.progress.done(a) {
    // rust: self.award(index);
}
}
}
    // rust: changed || criterion.is_none()
}
    // `AdvancementCommands.Action.REVOKE`.
    // rust: pub(super) fn revoke_advancement(&mut self, index: usize, criterion: Option<&str>) -> bool {
    // rust: let tree = self.adv.tree.clone();
    // rust: let a = &tree.list[index];
    // rust: self.progress_changed(index);
    // rust: match criterion {
    // rust: Some(c) => self.revoke_criterion(&a.id, c),
    // rust: None => {
    // rust: let mut any = false;
    // rust: for c in &a.criteria {
    // rust: any |= self.revoke_criterion(&a.id, &c.name);
}
    // rust: any
}
}
}
    // `PlayerAdvancements.revoke(holder, criterion)`: the progress change and
    // the hook for it.
revoke_criterion :: proc(self: ^Self, advancement: string, criterion: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let revoked = self.adv.progress.revoke(advancement, criterion);
    // rust: if revoked {
    // rust: self.advancement_progress(advancement, criterion, false);
}
    // rust: revoked
}
}
    // rust: impl Game<'_> {
    // `ClientAdvancements.update` (ClientboundUpdateAdvancementsPacket):
    // the server's advancements replace or join the tree, each changed one
    // takes the progress sent, and one just done shows its toast. `icons`
    // are the added advancements' icon items by name.
    // rust: pub(super) fn remote_advancements(
    // rust: &mut self,
    // rust: p: horizon_protocol::packets::play::UpdateAdvancements,
    // rust: icons: Vec<String>,
    // rust: ) {
//         use horizon_client::scoreboard::tag_to_json;
    // rust: let mut list: Vec<adv::Advancement> = Vec::new();
    // rust: let mut positions: Vec<(f32, f32)> = Vec::new();
    // rust: if !p.reset {
    // rust: let old = self.adv.positions.take().unwrap_or_default();
    // rust: for (i, a) in self.adv.tree.list.iter().enumerate() {
    // rust: if !p.removed.contains(&a.id) {
    // rust: list.push(a.clone());
    // rust: positions.push(old.get(i).copied().unwrap_or((0.0, 0.0)));
}
}
    // rust: } else {
    // rust: self.adv.progress = Progress::default();
}
    // rust: for id in &p.removed {
    // rust: self.adv.progress.criteria.remove(id);
}
    // rust: for (a, icon) in p.added.into_iter().zip(icons) {
    // rust: list.retain(|o| o.id != a.id);
    // rust: let display = a.display.map(|d| adv::Display {
    // rust: icon,
    // rust: title: tag_to_json(&d.title),
    // rust: description: tag_to_json(&d.description),
    // rust: frame: match d.frame {
    // rust: 1 => Frame::Challenge,
    // rust: 2 => Frame::Goal,
    // rust: _ => Frame::Task,
    // rust: },
    // rust: background: d.background,
    // rust: show_toast: d.show_toast,
    // rust: announce: false,
    // rust: hidden: d.hidden,
    // rust: });
    // rust: let mut criteria: Vec<adv::Criterion> = Vec::new();
    // rust: for name in a.requirements.iter().flatten() {
    // rust: if !criteria.iter().any(|c| &c.name == name) {
    // rust: criteria.push(adv::Criterion {
    // rust: name: name.clone(),
    // rust: trigger: String::new(),
    // rust: conditions: Value::Null.into(),
    // rust: });
}
}
    // rust: list.push(adv::Advancement {
    // rust: id: a.id,
    // rust: parent: a.parent,
    // rust: display,
    // rust: criteria,
    // rust: requirements: a.requirements,
    // rust: rewards: Default::default(),
    // rust: });
    // rust: positions.push((a.x, a.y));
}
    // rust: let mut tree = Tree::default();
    // rust: tree.list = list;
    // rust: for (i, a) in tree.list.iter().enumerate() {
    // rust: tree.by_id.insert(a.id.clone(), i);
}
    // rust: self.ui.registries.advancements = tree.list.iter().map(|a| a.id.clone()).collect();
    // rust: self.adv.tree = Arc::new(tree);
    // rust: self.adv.positions = Some(positions);
    // rust: let tree = self.adv.tree.clone();
    // rust: for (id, criteria) in p.progress {
    // rust: let Some(&i) = tree.by_id.get(&id) else {
    // rust: continue;
}
            // The client only shows whether a criterion is obtained, not when.
    // rust: let obtained: BTreeMap<String, String> = criteria
    // rust: .into_iter()
    // rust: .filter(|(_, at)| at.is_some())
    // rust: .map(|(name, _)| (name, String::new()))
    // rust: .collect();
    // rust: self.adv.progress.criteria.insert(id, obtained);
    // rust: let a = &tree.list[i];
    // rust: if !p.reset
    // rust: && p.show
    // rust: && self.adv.progress.done(a)
    // rust: && let Some(d) = a.display.as_ref().filter(|d| d.show_toast)
    // rust: && self.toast_allowed("advancement", &a.id)
    // rust: {
    // rust: self.adv.toasts.push_back(Toast {
    // rust: icon: d.icon.clone(),
    // rust: frame: d.frame,
    // rust: title: text_of(&d.title),
    // rust: slide: Slide::default(),
    // rust: slot: None,
    // rust: recipes: Vec::new(),
    // rust: changed: false,
    // rust: last_changed: 0,
    // rust: });
}
}
}
}
// An advancement's title or description: a whole component (ComponentSerialization.CODEC),
// with its siblings and styles, as a plugin's `{"text":"","extra":[...]}` needs.
    // rust: pub(super) fn text_of(v: &Value) -> Text {
    // rust: horizon_client::scoreboard::comp_text(v)
}

    // rust: mod tests {
//     use super::*;

mob_predicate_view_reads_active_effect_instances :: proc() {
}
//         use crate::game::{Audio, Options, Settings, commands::Target, load_resources};
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &crate::game::Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: game.build_registries();
    // rust: let kind = game.res.mob_types()["minecraft:zombie"].clone();
    // rust: let actor = |id| {
    // rust: let mut mob =
    // rust: horizon_client::mobs::Mob::new(id, kind.clone(), Vec3::new(4.5, 200.0, 4.5), 0.0);
    // rust: mob.no_ai = true;
    // rust: mob.no_gravity = true;
    // rust: mob
}
    // rust: game.mobs.push(actor(32300));
    // rust: let matches = |game: &Game<'_>, id, effects: Value| {
    // rust: let view = game.entity_view_of(Target::Mob(id));
    // rust: assert_eq!(view.kind, "minecraft:zombie");
    // rust: adv::entity(
    // rust: &serde_json::json!({"minecraft:effects": effects}),
    // rust: &view,
    // rust: &View(game),
    // rust: [4.5, 200.0, 4.5],
    // rust: )
}
    // rust: let speed_two = serde_json::json!({"minecraft:speed": {"amplifier": 2}});
    // rust: assert!(!matches(&game, 32300, speed_two.clone()));
    // rust: game.mobs[0].add_effect_with("minecraft:speed", -1, 2, false, false);
    // rust: assert_eq!(game.mobs[0].extra.effects, vec![("minecraft:speed", -1, 2)]);
    // rust: assert_eq!(
    // rust: game.entity_view_of(Target::Mob(32300)).effects,
    // rust: vec![("minecraft:speed".to_owned(), 2, -1)]
    // rust: );
    // rust: assert!(matches(&game, 32300, speed_two));
    // rust: assert!(!matches(
    // rust: &game,
    // rust: 32300,
    // rust: serde_json::json!({"minecraft:speed": {"amplifier": 5}})
    // rust: ));
    // rust: game.mobs[0].add_effect("minecraft:fire_resistance", 400, 0);
    // rust: assert!(matches(
    // rust: &game,
    // rust: 32300,
    // rust: serde_json::json!({
    // rust: "minecraft:speed": {"amplifier": 2},
    // rust: "minecraft:fire_resistance": {"amplifier": 0, "duration": 400}
    // rust: })
    // rust: ));
    // rust: let mut finite = actor(32301);
    // rust: finite.add_effect("minecraft:speed", 400, 0);
    // rust: game.mobs.push(finite);
    // rust: assert!(matches(
    // rust: &game,
    // rust: 32301,
    // rust: serde_json::json!({
    // rust: "minecraft:speed": {"amplifier": 0, "duration": 400}
    // rust: })
    // rust: ));
    // rust: assert!(!matches(
    // rust: &game,
    // rust: 32301,
    // rust: serde_json::json!({
    // rust: "minecraft:speed": {"amplifier": 0, "duration": {"max": 399}}
    // rust: })
    // rust: ));
}

looking_at_triggers_are_the_ones_that_ask :: proc() {
}
    // rust: let criterion = |trigger: &str, conditions: serde_json::Value| adv::Criterion {
    // rust: name: "c".into(),
    // rust: trigger: trigger.into(),
    // rust: conditions: horizon_world::lazy_json::LazyJson::new(&conditions),
}
    // rust: let looking = serde_json::json!({"player": {"type": "minecraft:entity_properties",
    // rust: "entity": "this", "predicate": {"minecraft:type_specific/player":
    // rust: {"looking_at": {"minecraft:entity_type": "minecraft:oak_boat"}}}}});
    // rust: let reference = serde_json::json!({"player": [{"condition": "minecraft:reference",
    // rust: "name": "pack:looks"}]});
    // rust: let plain = serde_json::json!({"player": {"type": "minecraft:entity_properties",
    // rust: "entity": "this", "predicate": {"minecraft:flags": {"is_sneaking": true}}}});
    // rust: let mut tree = Tree::default();
    // rust: tree.list.push(adv::Advancement {
    // rust: id: "pack:a".into(),
    // rust: parent: None,
    // rust: display: None,
    // rust: criteria: vec![
    // rust: criterion("minecraft:using_item", looking),
    // rust: criterion("minecraft:location", reference),
    // rust: criterion("minecraft:tick", plain),
    // rust: ],
    // rust: requirements: Vec::new(),
    // rust: rewards: Default::default(),
    // rust: });
    // rust: tree.index_looking_at();
    // rust: assert!(tree.may_look("minecraft:using_item"));
    // rust: assert!(tree.may_look("minecraft:location"));
    // rust: assert!(!tree.may_look("minecraft:tick"));
}

nbt_triggers_are_the_ones_that_ask :: proc() {
}
    // rust: let criterion = |trigger: &str, conditions: serde_json::Value| adv::Criterion {
    // rust: name: "c".into(),
    // rust: trigger: trigger.into(),
    // rust: conditions: horizon_world::lazy_json::LazyJson::new(&conditions),
}
    // rust: let nbt = serde_json::json!({"entity": [{"condition": "minecraft:entity_properties",
    // rust: "entity": "this", "predicate": {"minecraft:nbt": "{Variant:1}"}}]});
    // rust: let reference = serde_json::json!({"player": [{"condition": "minecraft:reference",
    // rust: "name": "pack:saved"}]});
    // rust: let plain = serde_json::json!({"entity": [{"condition": "minecraft:entity_properties",
    // rust: "entity": "this", "predicate": {"minecraft:flags": {"is_baby": true}}}]});
    // rust: let mut tree = Tree::default();
    // rust: tree.index_nbt();
    // rust: assert!(!tree.tests_nbt());
    // rust: tree.list.push(adv::Advancement {
    // rust: id: "pack:a".into(),
    // rust: parent: None,
    // rust: display: None,
    // rust: criteria: vec![
    // rust: criterion("minecraft:player_interacted_with_entity", nbt),
    // rust: criterion("minecraft:location", reference),
    // rust: criterion("minecraft:tame_animal", plain),
    // rust: ],
    // rust: requirements: Vec::new(),
    // rust: rewards: Default::default(),
    // rust: });
    // rust: tree.index_nbt();
    // rust: assert!(tree.tests_nbt());
    // rust: assert!(tree.may_test_nbt("minecraft:player_interacted_with_entity"));
    // rust: assert!(tree.may_test_nbt("minecraft:location"));
    // rust: assert!(!tree.may_test_nbt("minecraft:tame_animal"));
}

toast_labels_are_yellow_or_pink :: proc() {
}
        // The batch takes colours as `rgba`: 0xFFFF_FF00 there is cyan (#5850).
    // rust: for frame in [Frame::Task, Frame::Goal] {
    // rust: assert_eq!(toast_label(frame).1.to_le_bytes(), [255, 255, 0, 255]);
}
    // rust: assert_eq!(
    // rust: toast_label(Frame::Challenge).1.to_le_bytes(),
    // rust: [255, 136, 255, 255]
    // rust: );
}

recipes :: proc(n: uint) -> T {
    // Ported from Horizon
    return {}
}
    // rust: Toast::recipe(
    // rust: (0..n)
    // rust: .map(|i| {
    // rust: let item = ItemStack::new(&format!("minecraft:item_{i}"), 1);
    // rust: ("minecraft:crafting_table".to_owned(), item)
    // rust: })
    // rust: .collect(),
    // rust: )
}
    // Drives a toast frame by frame (every `step` ms) and returns the slide
    // portions at the given times and when it finished.
run :: proc(toast: ^Toast, step: i64, until: i64, at: ^[i64]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut slide = Slide::default();
    // rust: let mut seen = Vec::new();
    // rust: for now in (0..=until).step_by(step as usize) {
    // rust: let (_, finished) = slide.update(now, |f| toast.wants_show(f, 1.0));
    // rust: if finished {
    // rust: return (seen, Some(now));
}
    // rust: if at.contains(&now) {
    // rust: seen.push(slide.portion);
}
}
    // rust: (seen, None)
}

titles_keep_their_siblings_and_styles :: proc() {
}
    // rust: let title = text_of(&serde_json::json!({
    // rust: "text": "",
    // rust: "extra": [{"text": "Quest ", "color": "gold"}, "Board"],
    // rust: }));
    // rust: assert_eq!(title.plain(), "Quest Board");
    // rust: assert_eq!(title.spans[0].style.color, Some(text::GOLD));
    // rust: assert_eq!(title.spans[1].style.color, None);
    // rust: let vanilla = text_of(&serde_json::json!({"translate": "advancements.story.root.title"}));
    // rust: assert_eq!(
    // rust: vanilla,
    // rust: Text::translate("advancements.story.root.title", &[])
    // rust: );
    // rust: assert_eq!(
    // rust: vanilla.translation_key(),
    // rust: Some("advancements.story.root.title")
    // rust: );
}

announced :: proc(title: Value, description: Value) -> a {
    // Ported from Horizon
    return {}
}
    // rust: adv::Advancement {
    // rust: id: "quests:board".into(),
    // rust: parent: None,
    // rust: display: Some(adv::Display {
    // rust: icon: "minecraft:book".into(),
    // rust: title,
    // rust: description,
    // rust: frame: Frame::Task,
    // rust: background: None,
    // rust: show_toast: true,
    // rust: announce: true,
    // rust: hidden: false,
    // rust: }),
    // rust: criteria: Vec::new(),
    // rust: requirements: Vec::new(),
    // rust: rewards: adv::Rewards::default(),
}
}
    // The chat hover: the JSON a client receives, and the spans drawn here.
hover :: proc(a: ^adv::Advancement) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let local = decorate_name(a.display.as_ref().unwrap());
    // rust: let sent = adv_name(a).component()["with"][0]["hover_event"]["value"].clone();
    // rust: (sent, local)
}

chat_hover_keeps_the_titles_siblings_before_the_description :: proc() {
}
    // rust: let a = announced(
    // rust: serde_json::json!({"text": "", "extra": [{"text": "Quest ", "color": "gold"}, "Board"]}),
    // rust: serde_json::json!("Open the board"),
    // rust: );
    // rust: let (sent, local) = hover(&a);
    // rust: let sent = horizon_client::scoreboard::comp_text(&sent);
    // rust: assert_eq!(sent.plain(), "Quest Board\nOpen the board");
    // rust: let colors = |t: &Text| t.spans.iter().map(|s| s.style.color).collect::<Vec<_>>();
    // rust: let (gold, green) = (Some(text::GOLD), Some(text::GREEN));
    // rust: assert_eq!(colors(&sent), [gold, green, green, green]);
        // The spans drawn here come from the same JSON a client receives.
    // rust: assert_eq!(colors(&local), colors(&sent));
}

chat_hover_description_takes_a_styled_titles_own_style :: proc() {
}
        // mergeStyles keeps the title's gold; the description inherits it.
    // rust: let object = announced(
    // rust: serde_json::json!({"text": "Quest", "color": "gold", "bold": true, "extra": [" Board"]}),
    // rust: serde_json::json!("Open the board"),
    // rust: );
    // rust: let list = announced(
    // rust: serde_json::json!([{"text": "Quest", "color": "gold", "bold": true}, " Board"]),
    // rust: serde_json::json!("Open the board"),
    // rust: );
    // rust: for a in [object, list] {
    // rust: let (sent, local) = hover(&a);
    // rust: let sent = horizon_client::scoreboard::comp_text(&sent);
    // rust: assert_eq!(sent.plain(), "Quest Board\nOpen the board");
    // rust: let last = &sent.spans.last().unwrap().style;
    // rust: assert_eq!((last.color, last.bold), (Some(text::GOLD), Some(true)));
    // rust: assert_eq!(local.spans.last().unwrap().style, *last);
}
}

chat_hover_of_a_vanilla_advancement :: proc() {
}
    // rust: let a = announced(
    // rust: serde_json::json!({"translate": "advancements.story.root.title"}),
    // rust: serde_json::json!({"translate": "advancements.story.root.description"}),
    // rust: );
    // rust: assert_eq!(
    // rust: hover(&a).0,
    // rust: serde_json::json!({
    // rust: "translate": "advancements.story.root.title",
    // rust: "color": "green",
    // rust: "extra": ["\n", {"translate": "advancements.story.root.description"}],
    // rust: })
    // rust: );
}

toasts_slide_in_squared_and_out_after_five_seconds :: proc() {
}
    // rust: let mut toast = recipes(1);
    // rust: let (portions, finished) = run(&mut toast, 10, 10_000, &[0, 300, 600, 3000]);
        // (300 / 600)² = 0.25: ToastInstance.calculateVisiblePortion.
    // rust: assert_eq!(portions, [0.0, 0.25, 1.0, 1.0]);
        // Fully in at 600, shown 5000 ms, out over 600 more.
    // rust: assert!(
    // rust: finished.is_some_and(|t| (6200..=6220).contains(&t)),
    // rust: "{finished:?}"
    // rust: );
}

the_first_update_plays_the_show_sound_and_the_hide_sound_follows :: proc() {
}
    // rust: let mut toast = recipes(1);
    // rust: let mut slide = Slide::default();
    // rust: assert_eq!(slide.update(0, |f| toast.wants_show(f, 1.0)).0, Some(true));
    // rust: assert_eq!(slide.update(100, |f| toast.wants_show(f, 1.0)).0, None);
    // rust: assert_eq!(
    // rust: slide.update(5600, |f| toast.wants_show(f, 1.0)).0,
    // rust: Some(false)
    // rust: );
}

recipe_toasts_cycle_through_their_displays_over_the_display_time :: proc() {
}
    // rust: let toast = recipes(4);
    // rust: let shown: Vec<usize> = [0, 1249, 1250, 2500, 3750, 4999, 5000]
    // rust: .iter()
    // rust: .map(|&t| toast.displayed_recipe(t, 1.0))
    // rust: .collect();
    // rust: assert_eq!(shown, [0, 0, 1, 2, 3, 3, 0]);
        // notificationDisplayTime doubles each turn.
    // rust: assert_eq!(toast.displayed_recipe(2500, 2.0), 1);
}

unlocking_more_recipes_keeps_the_toast_up_five_more_seconds :: proc() {
}
    // rust: let mut toast = recipes(1);
    // rust: let mut slide = Slide::default();
    // rust: let mut finished = None;
    // rust: for now in (0..=20_000).step_by(10) {
    // rust: if now == 4000 {
    // rust: toast.add_recipes(recipes(1).recipes);
}
    // rust: if slide.update(now, |f| toast.wants_show(f, 1.0)).1 {
    // rust: finished = Some(now);
    // rust: break;
}
}
    // rust: assert_eq!(toast.recipes.len(), 2);
        // lastChanged moved to 3400 ms fully shown: hidden at 8400 + 600.
    // rust: assert!(
    // rust: finished.is_some_and(|t| (9600..=9620).contains(&t)),
    // rust: "{finished:?}"
    // rust: );
}
}
    // rust: mod structure_tag_tests {
//     use super::View;
//     use crate::game::{Audio, Game, Options, Progress, Settings, load_resources};
//     use horizon_client::advancements::{World, id_matches};
//     use serde_json::json;

    // `LocationPredicate.structures` names a `#tag`: the game's own
    // `worldgen/structure` tags, and with a world's data packs theirs over
    // the game's.
location_structure_tags_hold_their_structures :: proc() {
}
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: let set = |s: &str| json!(s);
    // rust: let holds = |game: &Game, tag: &str, id: &str| {
    // rust: id_matches(&set(tag), "worldgen/structure", id, &View(game))
}
        // A world without packs: the game's own tags.
    // rust: assert!(game.world_tables.is_none());
    // rust: assert!(holds(
    // rust: &game,
    // rust: "#minecraft:village",
    // rust: "minecraft:village_taiga"
    // rust: ));
    // rust: assert!(holds(&game, "#shipwreck", "minecraft:shipwreck_beached"));
    // rust: assert!(!holds(&game, "#minecraft:village", "minecraft:shipwreck"));
    // rust: assert!(!View(&game).in_tag("worldgen/structure", "mypack:village", "minecraft:igloo"));

        // A pack's own tag (nesting the game's) and an addition to the game's.
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-structure-tags-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let pack = dir.join("datapacks").join("mypack");
    // rust: let tags = pack.join("data/mypack/tags/worldgen/structure");
    // rust: let game_tags = pack.join("data/minecraft/tags/worldgen/structure");
    // rust: std::fs::create_dir_all(&tags).unwrap();
    // rust: std::fs::create_dir_all(&game_tags).unwrap();
    // rust: std::fs::write(pack.join("pack.mcmeta"), "{}").unwrap();
    // rust: std::fs::write(
    // rust: tags.join("village.json"),
    // rust: r##"{"values": ["#minecraft:village", "minecraft:igloo"]}"##,
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: game_tags.join("shipwreck.json"),
    // rust: r#"{"values": ["minecraft:ocean_ruin_cold"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let settings = json!({"enabled": ["file/mypack"], "disabled": []});
    // rust: std::fs::write(dir.join("datapacks.json"), settings.to_string()).unwrap();
    // rust: game.world_root = dir.clone();
    // rust: let (tables, _) = game.build_world_tables(false, &[]).unwrap();
    // rust: game.world_tables = tables;
    // rust: assert!(game.world_tables.is_some());
    // rust: assert!(holds(&game, "#mypack:village", "minecraft:igloo"));
    // rust: assert!(holds(&game, "#mypack:village", "minecraft:village_plains"));
    // rust: assert!(!holds(&game, "#mypack:village", "minecraft:shipwreck"));
    // rust: assert!(holds(
    // rust: &game,
    // rust: "#minecraft:shipwreck",
    // rust: "minecraft:ocean_ruin_cold"
    // rust: ));
    // rust: assert!(holds(&game, "#minecraft:shipwreck", "minecraft:shipwreck"));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
