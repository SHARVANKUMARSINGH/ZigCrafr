//! Transpiled from Horizon Rust crate
package horizon_client_chat

import "core:fmt"
import "core:mem"
import "core:math"

// Chat, the command registries and the per-world state behind commands
// (game rules, the world clock, difficulty), bound to the game.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: chat::{
    // rust: Chat, ChatAbilities, ChatAction, ChatScreen, ChatSource, ChatVisibility, Commands,
    // rust: SYSTEM_INDICATOR, normalize_chat_message,
    // rust: },
    // rust: command::Registries,
    // rust: gamerules::GameRules,
    // rust: hud::HudBatch,
    // rust: screen_draw::Measure,
    // rust: text::{ClickEvent, Style, Text},
}
// use horizon_world::registry::{BlockRegistry, BlockStateId};
// use std::{
    // rust: collections::BTreeMap,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Arc, Mutex},
}

// The tree the chat parses and completes with: `Remote::chat_tree`, which is
// a server's, once it has sent one (ClientPacketListener.commands), else the
// game's own, plus the commands native mods own (`chat_tree_for`).
    // rust: pub(super) fn chat_tree(
    // rust: remote: &Option<super::remote::Remote>,
    // rust: ) -> &horizon_client::command::Dispatcher {
    // rust: match remote.as_ref() {
    // rust: Some(server) => &server.chat_tree,
    // rust: None => horizon_client::command::vanilla::game_dispatcher(),
}
}
// use winit::{
    // rust: event::KeyEvent,
    // rust: keyboard::{KeyCode, PhysicalKey},
}

// `base` with the commands native mods own (`native_commands`) added: each a
// literal that takes the rest of the line as it was typed, run by
// `native_command` (`Dispatcher::with_mod_commands`), so the chat box colours
// and completes them as it does the game's own.
    // rust: pub(super) fn with_native_commands(
    // rust: base: &horizon_client::command::Dispatcher,
    // rust: names: &[&str],
    // rust: ) -> horizon_client::command::Dispatcher {
    // A name the tree already has keeps that command (colour, completion).
    // rust: base.with_mod_commands(
    // rust: names
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|name| base.find(name).is_none()),
    // rust: )
}

    // rust: impl Game<'_> {
    // The tree the chat box colours, completes and parses with for the
    // world's connection: `base`, the tree the server sent, or the game's own
    // before it does. Built where that base changes — once per connection —
    // rather than at each keystroke, and asking the mods then, not per key.
    // rust: pub(super) fn chat_tree_for(
    // rust: &mut self,
    // rust: base: Option<&horizon_client::command::Dispatcher>,
    // rust: ) -> horizon_client::command::Dispatcher {
    // rust: let mut names = Vec::new();
    // rust: self.native_commands(&mut names);
    // rust: names.push("studio");
    // rust: let base = match base {
    // rust: Some(tree) => tree,
    // rust: None => horizon_client::command::vanilla::game_dispatcher(),
}
    // rust: with_native_commands(base, &names)
}
}

// The local player's name (offline single player).
PLAYER_NAME :: "Player"

// ServerClockManager.ServerClockInstance for the overworld clock (its
// total ticks are the world's day time).
WorldClock :: struct {
    partial: f32,
    rate: f32,
    paused: bool,
}
    // rust: impl Default for WorldClock {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: partial: 0.0,
    // rust: rate: 1.0,
    // rust: paused: false,
}
}
}
// A clock time marker from the timelines (ClockTimeMarker).
TimeMarker :: struct {
    ticks: i64,
    period: Maybe(i64),
    show: bool,
}
    // rust: impl TimeMarker {
occurs_at :: proc(self: ^Self, total: i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self.period {
    // rust: Some(p) => self.ticks == total.rem_euclid(p),
    // rust: None => self.ticks == total,
}
}
resolve :: proc(self: ^Self, total: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self.period {
    // rust: Some(p) => {
    // rust: let d = self.ticks - total.rem_euclid(p);
    // rust: total + if d > 0 { d } else { p + d }
}
    // rust: None => self.ticks,
}
}
}
// `ChatComponent.Draft`: the text the chat box kept, and whether it was a command.
ChatDraft :: struct {
    text: string,
    command: bool,
}
// `ChatScreen.ExitReason`: why the chat screen went away.
    // rust: pub(super) enum ChatExit {
    // Another screen replaced it (death, a container, a disconnect).
    // rust: Interrupted,
    // The player closed it (Escape).
    // rust: Intentional,
    // A message was sent.
    // rust: Done,
}
// `ChatScreen.shouldDiscardDraft`.
should_discard_draft :: proc(reason: ChatExit, save_chat_drafts: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: reason != ChatExit::Interrupted && (reason != ChatExit::Intentional || !save_chat_drafts)
}
// UI and command state that lives beside the game.
UiState :: struct {
    chat: Chat,
    chat_screen: Maybe(ChatScreen),
    // `ChatComponent.latestDraft`.
    chat_draft: Maybe(ChatDraft),
    // `ChatScreen.isDraft`: the box opened with the draft and is unchanged since.
    chat_draft_shown: bool,
    // When the chat screen opened (its input took the focus: the cursor blink).
    chat_opened: Maybe(std::time::Instant),
    // The chat screen is `InBedChatScreen`: the sleeper's, with a Leave Bed button.
    in_bed_chat: bool,
    registries: Registries,
    rules: GameRules,
    clock: WorldClock,
    // Command state for registered clocks other than Overworld. Overworld's
    // canonical ticks stay in World.day_time and its state stays in clock.
    command_clocks: BTreeMap<string,
    // Time markers and timelines of the overworld clock.
    markers: BTreeMap<string,
    timelines: BTreeMap<string,
    // 0 peaceful .. 3 hard.
    difficulty: u8,
    // F1: hide the HUD.
    hide_gui: bool,
    // Death message key set by the cause of death (e.g. /kill).
    death_cause: Maybe(string),
    // Path of an F2 screenshot waiting for its frame.
    screenshot_message: Maybe(std::path::PathBuf),
    // The options screens.
    options: horizon_client::options_ui::OptionsUi,
    // The prepared resources before resource packs are layered on.
    vanilla_root: std::path::PathBuf,
    // Death screen cause and when the player died (buttons wait 20 ticks).
    death_text: Maybe(Text),
    died_at: Maybe(std::time::Instant),
    // `DeathScreen.TitleConfirmScreen` and when it opened (its buttons wait
    // 20 ticks, `setDelay`).
    death_confirm: Maybe(std::time::Instant),
    // `LivingEntity.deathTime` of the window's player: ticks since it died.
    death_time: u32,
}

    // rust: impl UiState {
    // The state a window starts with: the chat remembers the commands kept
    // in the game folder (`ChatComponent`'s constructor).
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut ui = Self::default();
    // rust: if let Ok(dir) = std::env::current_dir() {
    // rust: ui.chat.load_history(&dir);
}
    // rust: ui
}
}

// The ids `build_registries` lists from the prepared resources' folders.
// The folders don't change while the game runs, so each root is read once
// instead of at every world opening (thousands of files).
ResourceIds :: struct {
    recipes: [dynamic]string,
    loot_tables: [dynamic]string,
    templates: [dynamic]string,
    // `entity-types.json`'s keys, sorted (empty when the file is missing).
    entity_types: [dynamic]string,
    enchantments: [dynamic]string,
    structures: [dynamic]string,
    biomes: [dynamic]string,
    clocks: [dynamic]string,
    // The overworld clock's timelines, their periods and time markers.
    timelines: Vec<(string,
    markers: Vec<(string,
}
RESOURCE_IDS :: Mutex::new(Vec::new())

// The `minecraft:` ids of the `.json` files directly in `dir`, sorted.
json_ids_in :: proc(dir: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: Vec<String> = std::fs::read_dir(dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: e.file_name()
    // rust: .to_str()?
    // rust: .strip_suffix(".json")
    // rust: .map(|n| format!("minecraft:{n}"))
    // rust: })
    // rust: .collect();
    // rust: out.sort();
    // rust: out
}

// The overworld clock's timelines (with their periods) and their time
// markers, read from `data/minecraft/timeline`.
overworld_timelines :: proc(root: ^Path) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let dir = root.join("data/minecraft/timeline");
    // rust: let (mut timelines, mut markers) = (Vec::new(), Vec::new());
    // rust: for name in json_ids_in(&dir) {
    // rust: let path = dir.join(format!("{}.json", name.trim_start_matches("minecraft:")));
    // rust: let Ok(v) =
    // rust: serde_json::from_slice::<serde_json::Value>(&std::fs::read(path).unwrap_or_default())
    // rust: else {
    // rust: continue;
}
    // rust: if v["clock"].as_str() != Some("minecraft:overworld") {
    // rust: continue;
}
    // rust: let period = v["period_ticks"].as_i64();
    // rust: timelines.push((name.clone(), period));
    // rust: for (marker, def) in v["time_markers"].as_object().into_iter().flatten() {
    // rust: let (ticks, show) = match def {
    // rust: serde_json::Value::Number(n) => (n.as_i64().unwrap_or(0), false),
    // rust: other => (
    // rust: other["ticks"].as_i64().unwrap_or(0),
    // rust: other["show_in_commands"].as_bool().unwrap_or(false),
    // rust: ),
}
    // rust: markers.push((
    // rust: marker.clone(),
    // rust: TimeMarker {
    // rust: ticks,
    // rust: period,
    // rust: show,
    // rust: },
    // rust: ));
}
}
    // rust: (timelines, markers)
}

resource_ids :: proc(root: ^Path) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let mut cache = RESOURCE_IDS.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some((_, ids)) = cache.iter().find(|(cached, _)| cached == root) {
    // rust: return ids.clone();
}
    // rust: let data = root.join("data/minecraft");
    // rust: let mut entity_types: Vec<String> = serde_json::from_slice::<serde_json::Value>(
    // rust: &std::fs::read(root.join("entity-types.json")).unwrap_or_default(),
    // rust: )
    // rust: .ok()
    // rust: .and_then(|v| {
    // rust: v.as_object().map(|o| {
    // rust: o.keys()
    // rust: .map(|k| horizon_client::command::args::normalize(k))
    // rust: .collect()
    // rust: })
    // rust: })
    // rust: .unwrap_or_default();
    // rust: entity_types.sort();
    // rust: let (timelines, markers) = overworld_timelines(root);
    // rust: let ids = Arc::new(ResourceIds {
    // rust: recipes: ids_under(&data.join("recipe"), "json"),
        // `/loot ... loot <id>` must find a content mod's tables too.
    // rust: loot_tables: json_ids_of_every_namespace(root, "loot_table"),
    // rust: templates: templates_under(&root.join("worldgen/structure")),
    // rust: entity_types,
    // rust: enchantments: json_ids_in(&data.join("enchantment")),
    // rust: structures: json_ids_in(&data.join("worldgen/structure")),
    // rust: biomes: json_ids_in(&data.join("worldgen/biome")),
    // rust: clocks: json_ids_in(&data.join("world_clock")),
    // rust: timelines,
    // rust: markers,
    // rust: });
    // rust: cache.push((root.to_owned(), ids.clone()));
    // rust: ids
}

// Every block's properties and their values, as `/setblock` completes them.
    // rust: type BlockProperties = BTreeMap<String, Vec<(String, Vec<String>)>>;
BLOCK_PROPERTIES :: Mutex::new(Vec::new())

// `BlockProperties` of a block registry, listed once: a registry never
// changes once built, and walking its tens of thousands of states took
// about 30 ms of every world opening.
block_properties :: proc(registry: ^'static BlockRegistry) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let key = std::ptr::from_ref(registry) as usize;
    // rust: let mut cache = BLOCK_PROPERTIES.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some((_, properties)) = cache.iter().find(|(cached, _)| *cached == key) {
    // rust: return properties.clone();
}
    // rust: let mut blocks: BTreeMap<String, BTreeMap<String, Vec<String>>> = BTreeMap::new();
    // rust: for id in 0..registry.len() {
    // rust: let Some(state) = registry.state(BlockStateId(id as u32)) else {
    // rust: continue;
}
    // rust: let props = blocks.entry(state.name.clone()).or_default();
    // rust: for (k, v) in &state.properties {
    // rust: let values = props.entry(k.clone()).or_default();
    // rust: if !values.contains(v) {
    // rust: values.push(v.clone());
}
}
}
    // rust: let properties: Arc<BlockProperties> = Arc::new(
    // rust: blocks
    // rust: .into_iter()
    // rust: .map(|(k, v)| (k, v.into_iter().collect()))
    // rust: .collect(),
    // rust: );
    // rust: cache.push((key, properties.clone()));
    // rust: properties
}

COMMAND_EXPORTS :: Mutex::new(Vec::new())

// What the registries take from a folder's `command-registries.json`
// (vanilla's built-in registries), read once like the resource ids: parsing
// its 1.6 MB again took about 15 ms of every world opening. Only the part
// the registries fill from stays, not the parsed export (4.2 MB, against
// 2.2 MB). A dedicated server opens its world once and keeps nothing.
command_export :: proc(dir: ^Path, keep: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut cache = COMMAND_EXPORTS.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some((_, export)) = cache.iter().find(|(cached, _)| cached == dir) {
    // rust: return export.clone();
}
    // rust: let export = std::fs::read(dir.join("command-registries.json"))
    // rust: .ok()
    // rust: .and_then(|bytes| serde_json::from_slice(&bytes).ok())
    // rust: .map(|export| Arc::new(Registries::from_export(&export)));
    // rust: if keep {
    // rust: cache.push((dir.to_owned(), export.clone()));
}
    // rust: export
}

// The `minecraft:` ids of the `extension` files under `root`, sorted.
ids_under :: proc(root: ^Path, extension: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: ids_in(root, extension, "minecraft")
}

// The ids of the `.json` files in `data/<namespace>/<kind>` of every
// namespace of `root` (vanilla's and the content mods'), sorted.
json_ids_of_every_namespace :: proc(root: ^Path, kind: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let data = root.join("data");
    // rust: let mut namespaces: std::collections::BTreeSet<String> = std::fs::read_dir(&data)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter(|e| e.path().is_dir())
    // rust: .map(|e| e.file_name().to_string_lossy().into_owned())
    // rust: .collect();
    // A prepared root's namespaces live in its data file, not on the disk.
    // rust: if let Some(files) = horizon_core::prepared_files::files_under(&data) {
    // rust: namespaces.extend(
    // rust: files
    // rust: .iter()
    // rust: .filter_map(|f| Some(f.split_once('/')?.0.to_owned())),
    // rust: );
}
    // rust: let mut out: Vec<String> = namespaces
    // rust: .iter()
    // rust: .flat_map(|ns| ids_in(&data.join(ns).join(kind), "json", ns))
    // rust: .collect();
    // rust: out.sort();
    // rust: out
}

// The templates of every namespace folder under `root` (vanilla's and the
// content mods'), as `namespace:path`, sorted.
templates_under :: proc(root: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(namespaces) = std::fs::read_dir(root) else {
    // rust: return Vec::new();
}
    // rust: let mut out: Vec<String> = namespaces
    // rust: .flatten()
    // rust: .filter(|e| e.path().is_dir())
    // rust: .flat_map(|e| ids_in(&e.path(), "nbt", &e.file_name().to_string_lossy()))
    // rust: .collect();
    // rust: out.sort();
    // rust: out
}

// The `namespace:` ids of the `extension` files under `root`, sorted.
ids_in :: proc(root: ^Path, extension: string, namespace: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let suffix = format!(".{extension}");
    // A prepared root's folder: from its data file, without listing the disk.
    // rust: if let Some(files) = horizon_core::prepared_files::files_under(root) {
    // rust: let mut out: Vec<String> = files
    // rust: .iter()
    // rust: .filter_map(|file| file.strip_suffix(&suffix))
    // rust: .filter(|path| !path.is_empty() && !path.ends_with('/'))
    // rust: .map(|path| format!("{namespace}:{path}"))
    // rust: .collect();
    // rust: out.sort();
    // rust: return out;
}
    // rust: let mut out = Vec::new();
    // rust: let mut stack = vec![root.to_owned()];
    // rust: while let Some(dir) = stack.pop() {
    // rust: let Ok(entries) = std::fs::read_dir(&dir) else {
    // rust: continue;
}
    // rust: for e in entries.flatten() {
    // rust: let path = e.path();
            // The listing's own type, without another look at each file; a
            // link is followed, as `Path::is_dir` does.
    // rust: let is_dir = e
    // rust: .file_type()
    // rust: .is_ok_and(|t| t.is_dir() || (t.is_symlink() && path.is_dir()));
    // rust: if is_dir {
    // rust: stack.push(path);
    // rust: } else if path.extension().and_then(|x| x.to_str()) == Some(extension)
    // rust: && let Ok(rel) = path.strip_prefix(root)
    // rust: {
    // rust: out.push(format!(
    // rust: "{namespace}:{}",
    // rust: rel.with_extension("").to_string_lossy().replace('\\', "/")
    // rust: ));
}
}
}
    // rust: out.sort();
    // rust: out
}

// `SuggestionProviders.SUMMONABLE_ENTITIES`: Entity types available for
// `/summon` autocomplete, filtering out types that cannot be summoned.
    // rust: pub(super) fn summonable_entities(
    // rust: entity_types: &[String],
    // rust: mob_types: impl IntoIterator<Item = impl AsRef<str>>,
    // rust: ) -> Vec<String> {
    // rust: let mut summonable: Vec<String> = if !entity_types.is_empty() {
    // rust: entity_types
    // rust: .iter()
    // rust: .filter(|id| !matches!(id.as_str(), "minecraft:player" | "minecraft:fishing_bobber"))
    // rust: .cloned()
    // rust: .collect()
    // rust: } else {
    // rust: let mut list: Vec<String> = mob_types
    // rust: .into_iter()
    // rust: .map(|k| horizon_client::command::args::normalize(k.as_ref()))
    // rust: .filter(|id| !matches!(id.as_str(), "minecraft:player" | "minecraft:fishing_bobber"))
    // rust: .collect();
    // rust: list.extend(
    // rust: [
    // rust: "minecraft:item",
    // rust: "minecraft:experience_orb",
    // rust: "minecraft:falling_block",
    // rust: "minecraft:arrow",
    // rust: "minecraft:lightning_bolt",
    // rust: "minecraft:minecart",
    // rust: "minecraft:chest_minecart",
    // rust: "minecraft:hopper_minecart",
    // rust: "minecraft:furnace_minecart",
    // rust: "minecraft:tnt_minecart",
    // rust: "minecraft:wind_charge",
    // rust: "minecraft:breeze_wind_charge",
    // rust: ]
    // rust: .map(String::from),
    // rust: );
    // rust: list
}
    // content mods' thrown types.
    // rust: let thrown = horizon_client::projectiles::thrown_types().iter();
    // rust: summonable.extend(thrown.map(|t| t.id.to_owned()));
    // rust: summonable.sort();
    // rust: summonable.dedup();
    // rust: summonable
}

    // rust: impl Game<'_> {
    // The caches `build_registries` and `join_server` read (`resource_ids`,
    // `block_properties`, `command_export`, `builtin_registries`), filled on a helper
    // thread while the title screen is up: the first world opened or server joined
    // built them in its frame (20 ms of the Join click on an M4 Pro). Whoever needs one
    // before it is done waits for it, as before.
    // rust: pub(super) fn preload_registries(&self) {
    // rust: if self.options.dedicated.is_some() {
    // rust: return;
}
    // rust: let dirs = [self.options.resources.clone(), self.ui.vanilla_root.clone()];
    // rust: let registry = self.pack.assets.registry;
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Registries preload".into())
    // rust: .spawn(move || {
    // rust: horizon_threads::behind_server();
    // rust: super::remote::builtin_registries(&dirs[0]);
    // rust: resource_ids(&dirs[0]);
    // rust: block_properties(registry);
    // rust: for dir in &dirs {
    // rust: if command_export(dir, true).is_some() {
    // rust: break;
}
}
    // rust: });
    // rust: if let Err(e) = spawned {
    // rust: log::warn!("Horizon: registries preload: {e}");
}
}
    // `PlayerList.isOp` for the single-player owner: the world's Allow Commands.
    // rust: pub(super) fn allow_commands(&self) -> bool {
    // rust: self.level.allow_commands == Some(true)
}
    // `IntegratedServer.setWorldAllowCommands`, then `updatePermissions`.
    // rust: pub(super) fn set_allow_commands(&mut self, allow: bool) {
    // rust: self.level.allow_commands = Some(allow);
    // rust: self.ui.registries.permission = owner_permission(allow);
}
    // Commands the game issues itself (the server console, harnesses, the
    // control socket) run at the owner's level whatever Allow Commands says.
    // rust: pub(super) fn as_console<T>(&mut self, f: impl FnOnce(&mut Self) -> T) -> T {
    // rust: let level = std::mem::replace(&mut self.ui.registries.permission, 4);
    // rust: let out = f(self);
    // rust: self.ui.registries.permission = level;
    // rust: out
}
    // Registry contents for argument parsing (built when a world opens).
    // rust: pub(super) fn build_registries(&mut self) {
    // rust: let permission = owner_permission(self.allow_commands());
    // rust: let reg = &mut self.ui.registries;
    // rust: reg.permission = permission;
    // rust: let ids = resource_ids(&self.options.resources);
    // rust: self.ui.registries.recipes = ids.recipes.clone();
    // rust: self.ui.registries.damage_types = self
    // rust: .health_resources
    // rust: .damage
    // rust: .entries()
    // rust: .map(|(_, d)| d.name.clone())
    // rust: .collect();
    // rust: self.ui.registries.loot_tables = ids.loot_tables.clone();
    // rust: self.ui.registries.templates = ids.templates.clone();
    // rust: self.ui.registries.sounds = self.audio.event_names();
    // rust: self.ui.registries.attributes = [
    // rust: "armor",
    // rust: "armor_toughness",
    // rust: "attack_damage",
    // rust: "attack_knockback",
    // rust: "attack_speed",
    // rust: "block_break_speed",
    // rust: "block_interaction_range",
    // rust: "burning_time",
    // rust: "camera_distance",
    // rust: "explosion_knockback_resistance",
    // rust: "entity_interaction_range",
    // rust: "fall_damage_multiplier",
    // rust: "flying_speed",
    // rust: "follow_range",
    // rust: "gravity",
    // rust: "jump_strength",
    // rust: "knockback_resistance",
    // rust: "luck",
    // rust: "max_absorption",
    // rust: "max_health",
    // rust: "mining_efficiency",
    // rust: "movement_efficiency",
    // rust: "movement_speed",
    // rust: "oxygen_bonus",
    // rust: "safe_fall_distance",
    // rust: "scale",
    // rust: "sneaking_speed",
    // rust: "spawn_reinforcements",
    // rust: "step_height",
    // rust: "submerged_mining_speed",
    // rust: "sweeping_damage_ratio",
    // rust: "tempt_range",
    // rust: "water_movement_efficiency",
    // rust: ]
    // rust: .iter()
    // rust: .map(|a| format!("minecraft:{a}"))
    // rust: .collect();
    // rust: let reg = &mut self.ui.registries;
    // rust: let mut items: Vec<String> = self
    // rust: .res
    // rust: .items()
    // rust: .order
    // rust: .iter()
    // rust: .map(|s| s.to_string())
    // rust: .collect();
    // rust: items.sort();
    // rust: reg.items = items;
    // rust: reg.item_tags = self
    // rust: .res
    // rust: .items()
    // rust: .item_tags
    // rust: .keys()
    // rust: .map(|k| horizon_client::command::args::normalize(k))
    // rust: .collect();
    // rust: reg.item_tags.sort();
    // rust: reg.block_tags = self
    // rust: .res
    // rust: .items()
    // rust: .block_tags
    // rust: .keys()
    // rust: .map(|k| horizon_client::command::args::normalize(k))
    // rust: .collect();
    // rust: reg.block_tags.sort();
    // rust: reg.blocks = BlockProperties::clone(&block_properties(self.pack.assets.registry));
    // rust: reg.summonable = summonable_entities(&ids.entity_types, self.res.mob_types().keys());
    // rust: let mut types = ids.entity_types.clone();
    // rust: if types.is_empty() {
    // rust: types = reg.summonable.clone();
    // rust: types.push("minecraft:player".into());
    // rust: types.sort();
}
    // rust: reg.entity_types = types;
        // The mob effect registry: every effect `/effect` and the
        // `mob_effect` resource arguments accept.
    // rust: reg.effects = horizon_client::brewing::all_effects()
    // rust: .map(|e| horizon_client::brewing::namespaced(e.id).to_owned())
    // rust: .collect();
    // rust: reg.effects.sort();
    // rust: reg.enchantments = ids.enchantments.clone();
    // rust: reg.structures = ids.structures.clone();
    // rust: reg.biomes = ids.biomes.clone();
    // rust: reg.clocks = ids.clocks.clone();
    // rust: reg.dimensions = vec![
    // rust: "minecraft:overworld".into(),
    // rust: "minecraft:the_nether".into(),
    // rust: "minecraft:the_end".into(),
    // rust: ];
    // rust: reg.players = vec![PLAYER_NAME.into()];
        // Timelines of the overworld clock and their time markers.
    // rust: self.ui.timelines = ids.timelines.iter().cloned().collect();
    // rust: self.ui.markers = ids.markers.iter().cloned().collect();
        // Vanilla's built-in registries (mob effects, components, dialogs...).
    // rust: for dir in [&self.options.resources, &self.ui.vanilla_root] {
    // rust: if let Some(export) = command_export(dir, self.options.dedicated.is_none()) {
    // rust: self.ui.registries.fill_from_exported(&export);
    // rust: break;
}
}
    // rust: let reg = &mut self.ui.registries;
    // rust: reg.timelines = self.ui.timelines.keys().cloned().collect();
    // rust: reg.time_markers = self
    // rust: .ui
    // rust: .markers
    // rust: .iter()
    // rust: .filter(|(_, m)| m.show)
    // rust: .map(|(k, _)| k.clone())
    // rust: .collect();
}
    // The block the player is looking at, for coordinate suggestions, and
    // the entity, for entity arguments (ClientSuggestionProvider).
    // `ClientSuggestionProvider.getRelevantCoordinates` and
    // `getAbsoluteCoordinates` read `Minecraft.hitResult` only when it is a
    // block: an entity in front of the block leaves the `~` defaults.
refresh_dynamic_registries :: proc(self: ^Self) {
}
    // rust: let hit = if self.pick_entity_hit().is_some() {
    // rust: None
    // rust: } else {
    // rust: self.pick()
}
    // rust: self.ui.registries.target_block = hit.as_ref().map(|h| h.pos);
    // rust: self.ui.registries.target_point =
    // rust: hit.map(|h| h.point.map(horizon_client::java_text::format_fixed2));
    // rust: self.ui.registries.selected_entities = self.crosshair_entity_uuid().into_iter().collect();
        // ClientPacketListener.getOnlinePlayerNames on a server.
    // rust: if let Some(names) = self.remote_online_names() {
    // rust: self.ui.registries.players = names;
}
    // rust: self.ui.registries.custom_completions = self.remote_custom_completions();
}
    // `ChatComponent.createScreen`: T or / opens the chat with the draft kept
    // last time, when this method can restore it (a command draft only for
    // /), else with its prefix.
    // rust: pub(super) fn open_chat_method(&mut self, prefix: &str) {
        // handleKeybinds: the number keys select before key.chat and key.command.
    // rust: self.select_queued_hotbar();
    // rust: let command = prefix == "/";
    // rust: let draft = self
    // rust: .ui
    // rust: .chat_draft
    // rust: .as_ref()
    // rust: .filter(|d| !command || d.command)
    // rust: .map(|d| d.text.clone());
    // rust: self.open_chat(draft.as_deref().unwrap_or(prefix));
    // rust: self.ui.chat_draft_shown = draft.is_some() && self.ui.chat_screen.is_some();
}
    // rust: pub(super) fn open_chat(&mut self, initial: &str) {
    // rust: if self.player.is_none() {
    // rust: return;
}
    // rust: self.ui.chat_draft_shown = false;
    // rust: self.refresh_dynamic_registries();
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1280, 720], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: let mut screen = ChatScreen::new(
    // rust: &m,
    // rust: &c,
    // rust: initial,
    // rust: self.ui.chat.recent.len(),
    // rust: b.width as i32,
    // rust: b.height as i32,
    // rust: self.chat_abilities(),
    // rust: );
    // rust: screen.auto_suggestions = self.settings.auto_suggestions;
    // rust: self.ui.chat_screen = Some(screen);
    // rust: self.ui.chat_opened = Some(std::time::Instant::now());
    // rust: self.screen = Screen::Chat;
    // rust: self.keys.clear();
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: self.capture(false);
}
    // rust: pub(super) fn close_chat(&mut self, reason: ChatExit) {
        // InBedChatScreen.onClose: leaving the screen means getting up; the
        // screen goes once the player has woken (`tick_in_bed_chat`).
    // rust: if self.ui.in_bed_chat && self.sleeping.is_some() {
    // rust: self.wake_up();
    // rust: return;
}
    // rust: let text = self
    // rust: .ui
    // rust: .chat_screen
    // rust: .as_ref()
    // rust: .map_or_else(String::new, |s| s.value().to_owned());
    // rust: self.keep_chat_draft(&text, reason);
    // rust: self.ui.chat_draft_shown = false;
    // rust: self.ui.chat_screen = None;
    // rust: self.ui.chat.reset_scroll();
    // rust: if self.screen == Screen::Chat {
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
    // `ChatScreen.removed`: the text left in the box becomes the draft unless
    // `shouldDiscardDraft` (closed on purpose without Save Chat Drafts, or
    // sent); blank text discards the draft. A draft still shown unchanged
    // stays as it is.
keep_chat_draft :: proc(self: ^Self, text: string, reason: ChatExit) {
}
        // During PvP & HUD's chat search the box holds the query: the draft is the text the
        // search put aside, whichever way the chat closed.
    // rust: let aside;
    // rust: let text = if self.pvp.chat_search {
    // rust: self.pvp.chat_search = false;
    // rust: aside = std::mem::take(&mut self.pvp.chat_search_aside);
    // rust: aside.as_str()
    // rust: } else {
    // rust: text
}
    // rust: let unchanged =
    // rust: self.ui.chat_draft_shown && self.ui.chat_draft.as_ref().is_some_and(|d| d.text == text);
    // rust: if should_discard_draft(reason, self.settings.file.bool("saveChatDrafts"))
    // rust: || text.trim().is_empty()
    // rust: {
    // rust: self.ui.chat_draft = None;
    // rust: } else if !unchanged {
    // rust: self.ui.chat_draft = Some(ChatDraft {
    // rust: text: text.to_owned(),
    // rust: command: text.starts_with('/'),
    // rust: });
}
}
    // `Gui.tick`: a sleeper gets `InBedChatScreen`; when the player has
    // woken (`onPlayerWokeUp`) it closes, or turns into the plain chat
    // screen if something was typed.
    // rust: pub(super) fn tick_in_bed_chat(&mut self) {
        // Another screen took over the open chat (death, a container the
        // server opened): `ChatScreen.removed` runs with the INTERRUPTED reason.
    // rust: if self.screen != Screen::Chat && self.ui.chat_screen.is_some() {
    // rust: let text = self
    // rust: .ui
    // rust: .chat_screen
    // rust: .as_ref()
    // rust: .map_or_else(String::new, |s| s.value().to_owned());
    // rust: self.keep_chat_draft(&text, ChatExit::Interrupted);
    // rust: self.ui.chat_draft_shown = false;
    // rust: self.ui.chat_screen = None;
    // rust: self.ui.chat.reset_scroll();
}
    // rust: if self.screen != Screen::Chat {
    // rust: self.ui.in_bed_chat = false;
}
    // rust: if self.ui.in_bed_chat {
    // rust: if self.sleeping.is_none() {
    // rust: self.ui.in_bed_chat = false;
    // rust: let text = self
    // rust: .ui
    // rust: .chat_screen
    // rust: .as_ref()
    // rust: .map_or_else(String::new, |s| s.value().to_owned());
    // rust: self.close_chat(ChatExit::Interrupted);
    // rust: if !text.is_empty() {
    // rust: self.open_chat(&text);
}
}
    // rust: } else if self.sleeping.is_some() && self.screen == Screen::Playing {
    // rust: self.open_chat("");
    // rust: self.ui.in_bed_chat = self.screen == Screen::Chat;
}
}
    // The Leave Bed button of `InBedChatScreen`: its bounds.
leave_bed_button :: proc(width: f32, height: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (width as i32 / 2 - 100, height as i32 - 40, 200, 20)
}
    // The Leave Bed button's draws. It registers as a button
    // (`widgets::record`), so the pad's and the keyboard's focus reach it (the
    // pad's starts on it) and `horizon-ctl click-button` finds it.
    // rust: fn leave_bed_draws(
    // rust: m: &Measure,
    // rust: mouse: (i32, i32),
    // rust: width: f32,
    // rust: height: f32,
    // rust: ) -> Vec<horizon_client::screen_draw::Draw> {
    // rust: let (x, y, w, h) = Self::leave_bed_button(width, height);
    // rust: let label = Text::literal(horizon_client::lang::get_or(
    // rust: "multiplayer.stopSleeping",
    // rust: "Leave Bed",
    // rust: ));
    // rust: horizon_client::widgets::record(
    // rust: &label.plain(),
    // rust: [x as f32, y as f32, w as f32, h as f32],
    // rust: true,
    // rust: );
    // rust: let mut button = Vec::new();
    // rust: horizon_client::screen_draw::button(
    // rust: &mut button,
    // rust: m,
    // rust: &label,
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: true,
    // rust: horizon_client::screen_draw::inside(mouse, x, y, w, h),
    // rust: horizon_client::hud_overlays::now_ms(),
    // rust: );
    // rust: button
}
    // `Minecraft.computeChatAbilities` from the Chat option.
    // rust: pub(super) fn chat_abilities(&self) -> ChatAbilities {
    // rust: ChatAbilities::new(ChatVisibility::from_option(self.settings.chat_visibility))
}
    // A chat message from the game (ChatComponent.addServerSystemMessage).
    // rust: pub(super) fn system_message(&mut self, text: Text) {
    // rust: if let Some(capture) = self.chat_capture.as_mut() {
    // rust: capture.push(text);
    // rust: return;
}
        // Connected to a server (single player's own included), the chat on
        // screen is the connection's: the game's own messages join it.
    // rust: if self.remote.is_some() {
    // rust: self.chat_line(text, ChatSource::Server);
    // rust: return;
}
        // The Chat option's Hidden level takes the server's messages too.
    // rust: self.local_chat_line(text, Some(SYSTEM_INDICATOR), ChatSource::Server);
}
    // A player's chat line on the window's own chat: a guest's message on
    // the server's own chat (`HostEvent::Chat`). `ChatListener`
    // checks `canReceivePlayerMessages` for these, so Commands Only and
    // Hidden drop them; command feedback (`/list`, `/tp`) is a system
    // message and takes the system-message permission instead.
    // rust: pub(super) fn player_message(&mut self, text: Text) {
    // rust: if let Some(capture) = self.chat_capture.as_mut() {
    // rust: capture.push(text);
    // rust: return;
}
        // A server's client receives the line as a packet (PlayerChat or
        // DisguisedChat) and filters it there.
    // rust: if self.remote.is_none() {
    // rust: self.local_chat_line(text, None, ChatSource::Player);
}
}
    // A line on the window's own chat when the Chat option lets `source`
    // through.
local_chat_line :: proc(self: ^Self, text: Text, indicator: Maybe(u32), source: ChatSource) {
}
    // rust: if !self.ui.chat.shows(source) {
    // rust: return;
}
    // rust: let focused = self.screen == Screen::Chat;
    // rust: self.ui.chat.add(
    // rust: &self.gui.atlas,
    // rust: text,
    // rust: indicator,
    // rust: source,
    // rust: self.visual_ticks(),
    // rust: focused,
    // rust: );
}
    // Keys while the chat screen is open.
    // rust: pub(super) fn chat_key(&mut self, event: &KeyEvent) {
    // rust: if let Some(shortcut) = self.edit_shortcut(event) {
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: if let Some(screen) = self.ui.chat_screen.as_mut() {
    // rust: screen.shortcut(&m, &c, shortcut, &mut self.clipboard);
}
    // rust: return;
}
    // rust: let PhysicalKey::Code(key) = event.physical_key else {
    // rust: return;
}
    // rust: self.chat_key_code(key, event.text.as_deref());
}
    // A key (and the text it typed) while the chat screen is open.
    // rust: pub(super) fn chat_key_code(&mut self, key: KeyCode, typed_text: Option<&str>) {
        // The live modifiers, not `self.keys`: every ModifiersChanged runs
        // sync_toggle, which drops ShiftLeft and ControlLeft from `self.keys`
        // while a screen is open.
    // rust: let ctrl = self.has_control_down_with_quirk();
    // rust: let shift = self.has_shift_down();
        // PvP & HUD's chat search: Ctrl+F starts and stops it, Enter stops it (sends nothing).
    // rust: if self.settings.extras.pvp.chat.search
    // rust: && match key {
    // rust: KeyCode::KeyF => ctrl,
    // rust: KeyCode::Enter | KeyCode::NumpadEnter => self.pvp.chat_search,
    // rust: _ => false,
}
    // rust: {
    // rust: self.toggle_chat_search();
    // rust: return;
}
    // rust: match key {
            // ChatScreen.keyPressed: the chat scrolls a page.
    // rust: KeyCode::PageUp | KeyCode::PageDown
    // rust: if !self
    // rust: .ui
    // rust: .chat_screen
    // rust: .as_ref()
    // rust: .is_some_and(|s| s.suggestions_visible()) =>
    // rust: {
    // rust: let n = self.ui.chat.lines_per_page(true) as i32 - 1;
    // rust: self.ui
    // rust: .chat
    // rust: .scroll_by(if key == KeyCode::PageUp { n } else { -n }, true);
    // rust: return;
}
    // rust: _ => {}
}
    // rust: let Some(mut screen) = self.ui.chat_screen.take() else {
    // rust: return;
}
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: match screen.key(&m, &c, &self.ui.chat.recent, key, shift, ctrl) {
    // rust: ChatAction::Close => {
                // Escape: the box still holds its text, which close_chat keeps as the draft
                // (a search's query gives way to the text it put aside: keep_chat_draft).
    // rust: self.ui.chat_screen = Some(screen);
    // rust: self.close_chat(ChatExit::Intentional);
}
    // rust: ChatAction::Submit(message) => {
                // InBedChatScreen sends without closing (`closeOnSubmit` is
                // false): the box empties and the screen stays.
    // rust: if self.ui.in_bed_chat && self.sleeping.is_some() {
    // rust: screen.suggest_command(&m, &c, "");
    // rust: self.ui.chat.reset_scroll();
    // rust: self.ui.chat_screen = Some(screen);
    // rust: } else {
                    // The screen is taken here, so close_chat sees no text: a sent
                    // message discards the draft (DONE).
    // rust: self.close_chat(ChatExit::Done);
}
    // rust: if !message.is_empty() {
    // rust: self.handle_chat_input(&message);
}
}
    // rust: ChatAction::None => {
                // charTyped: the text the key typed.
    // rust: if let Some(text) = typed_text
    // rust: && self.types_text()
    // rust: {
    // rust: screen.type_text(&m, &c, text);
}
    // rust: self.ui.chat_screen = Some(screen);
}
}
}
    // The server's completions for an `ask_server` request
    // (ClientPacketListener.handleCommandSuggestions).
    // rust: pub(super) fn chat_server_suggestions(
    // rust: &mut self,
    // rust: id: i32,
    // rust: range: (usize, usize),
    // rust: list: Vec<(String, Option<String>)>,
    // rust: ) {
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: if let Some(screen) = self.ui.chat_screen.as_mut() {
    // rust: screen.server_suggestions(&m, &c, id, range, list);
}
}
    // Text typed into the chat box (control socket `chat`).
    // rust: pub(super) fn chat_type(&mut self, text: &str) {
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: if let Some(screen) = self.ui.chat_screen.as_mut() {
    // rust: screen.type_text(&m, &c, text);
}
}
    // ChatScreen.handleChatInput: the message comes in normalized
    // (`normalizeChatMessage`: trimmed, whitespace runs collapsed, cut to the
    // 256 UTF-16 units the packet holds), into history, then as a command or
    // a chat line. The Chat option's restrictions stop the message here too,
    // so a control-socket `chat` cannot send what the player's setting hides.
    // rust: pub(super) fn handle_chat_input(&mut self, message: &str) {
    // rust: let message = normalize_chat_message(message);
    // rust: if message.is_empty() || !self.chat_abilities().allows(&message) {
    // rust: return;
}
    // rust: self.ui.chat.add_recent(&message);
        // On a server (single player's own included) the server runs it,
        // unless a client mod owns the command.
    // rust: if self.remote.is_some() {
    // rust: if let Some(command) = message.strip_prefix('/')
    // rust: && self.client_mod_command(command)
    // rust: {
    // rust: return;
}
    // rust: self.send_chat(&message);
    // rust: return;
}
    // rust: if let Some(command) = message.strip_prefix('/') {
            // A native mod's command first.
    // rust: if !self.client_mod_command(command) {
    // rust: self.run_command(command);
}
    // rust: } else {
    // rust: let line = Text::translate(
    // rust: "chat.type.text",
    // rust: &[self.player_display_name(), Text::literal(message.as_str())],
    // rust: );
    // rust: let focused = self.screen == Screen::Chat;
    // rust: self.ui.chat.add(
    // rust: &self.gui.atlas,
    // rust: line,
    // rust: None,
    // rust: ChatSource::Player,
    // rust: self.visual_ticks(),
    // rust: focused,
    // rust: );
}
}
    // rust: pub(super) fn chat_scroll(&mut self, amount: f32) {
    // rust: let cursor = self.cursor;
    // rust: let height = self.renderer.as_ref().map_or(720.0, |r| {
    // rust: HudBatch::new([r.config.width, r.config.height]).height
    // rust: });
    // rust: let _ = height;
    // rust: let mouse = (cursor.0.floor() as i32, cursor.1.floor() as i32);
    // rust: if let Some(screen) = self.ui.chat_screen.as_mut()
    // rust: && screen.scroll(mouse, amount as f64)
    // rust: {
    // rust: return;
}
        // ChatScreen.mouseScrolled: `hasShiftDown`, either Shift key.
    // rust: let shift = self.has_shift_down();
    // rust: let amount = amount.clamp(-1.0, 1.0) * if shift { 1.0 } else { 7.0 };
    // rust: self.ui.chat.scroll_by(amount as i32, true);
}
    // rust: pub(super) fn chat_click(&mut self) {
    // rust: let cursor = self.cursor;
    // rust: let height = self.renderer.as_ref().map_or(720.0, |r| {
    // rust: HudBatch::new([r.config.width, r.config.height]).height
    // rust: });
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: if self.ui.in_bed_chat && self.sleeping.is_some() {
    // rust: let width = self.renderer.as_ref().map_or(1280.0, |r| {
    // rust: HudBatch::new([r.config.width, r.config.height]).width
    // rust: });
    // rust: let (x, y, w, h) = Self::leave_bed_button(width, height);
    // rust: if horizon_client::screen_draw::inside((cursor.0 as i32, cursor.1 as i32), x, y, w, h) {
    // rust: self.wake_up();
    // rust: return;
}
}
    // rust: if let Some(screen) = self.ui.chat_screen.as_mut() {
    // rust: if screen.click(&m, &c, cursor.0 as f64, cursor.1 as f64) {
    // rust: return;
}
    // rust: } else {
    // rust: return;
}
    // rust: let style = self.ui.chat.style_at(
    // rust: &self.gui.atlas.font,
    // rust: height as i32,
    // rust: cursor.0 as f64,
    // rust: cursor.1 as f64,
    // rust: );
        // PvP & HUD's copy on click: a message where the click has nothing else to do.
    // rust: if self.settings.extras.pvp.chat.copy
    // rust: && !self.has_shift_down()
    // rust: && style.as_ref().is_none_or(|s| s.click.is_none())
    // rust: && let Some(message) =
    // rust: self.ui
    // rust: .chat
    // rust: .message_at(height as i32, cursor.0 as f64, cursor.1 as f64)
    // rust: {
//             use horizon_client::clipboard::Clipboard;
    // rust: self.clipboard.set(message);
    // rust: let copied =
    // rust: Text::translate_with_fallback("horizon.chat.copied", "Message copied", &[]);
    // rust: self.titles.set_overlay(copied, false);
    // rust: return;
}
    // rust: let Some(style) = style else {
    // rust: return;
}
        // ChatScreen.handleComponentClicked: with Shift held only an
        // insertion acts, else only the click event.
    // rust: if self.has_shift_down() {
    // rust: if let Some(insertion) = style.insertion
    // rust: && let Some(screen) = self.ui.chat_screen.as_mut()
    // rust: {
    // rust: screen.type_text(&m, &c, &insertion);
}
    // rust: return;
}
    // rust: match style.click {
    // rust: Some(ClickEvent::CopyToClipboard(value)) => {
//                 use horizon_client::clipboard::Clipboard;
    // rust: self.clipboard.set(&value);
}
    // rust: Some(ClickEvent::OpenFile(path)) => {
    // rust: super::packs::open_folder(std::path::Path::new(&path));
}
    // rust: Some(ClickEvent::OpenUrl(url)) => self.click_url(url),
    // rust: Some(ClickEvent::SuggestCommand(command)) => {
    // rust: if let Some(screen) = self.ui.chat_screen.as_mut() {
    // rust: screen.suggest_command(&m, &c, &command);
}
}
    // rust: Some(ClickEvent::RunCommand(command)) => self.click_command(&command),
            // Screen.defaultHandleGameClickEvent: the dialog opens over the
            // screen, and closes back to it.
    // rust: Some(ClickEvent::ShowDialog(dialog)) => self.show_dialog_ref(&dialog),
            // Screen.defaultHandleGameClickEvent: custom actions retain chat.
    // rust: Some(ClickEvent::Custom { id, payload }) => {
    // rust: if let Some(remote) = &self.remote {
    // rust: remote.session.send_custom_click(&id, payload);
}
}
            // Screen.defaultHandleClickEvent: a page link means nothing in chat.
    // rust: Some(ClickEvent::ChangePage(_)) | None => {}
}
}
    // `Screen.clickUrlAction`: nothing with Web Links off, else the link
    // opens, after the confirmation unless Prompt on Links is off.
    // rust: pub(super) fn click_url(&mut self, url: String) {
    // rust: if !self.settings.chat_links {
    // rust: return;
}
    // rust: if self.settings.chat_links_prompt {
    // rust: self.link_prompt = Some(url);
    // rust: } else {
    // rust: super::packs::open_uri(&url);
}
}
    // `ConfirmLinkScreen` (untrusted): the link and its warning over the
    // chat, answered yes to open it.
    // rust: fn link_prompt_layout(
    // rust: &self,
    // rust: url: &str,
    // rust: size: (f32, f32),
    // rust: ) -> horizon_client::confirm_screen::Choice {
    // rust: let warning = Text::translate("chat.link.warning", &[]).with_color(0xFF_CCCC);
    // rust: let message = Text::literal(url)
    // rust: .append(Text::literal("\n"))
    // rust: .append(warning);
        // ConfirmLinkScreen.addButtons: yes, copy and no, 100 wide each.
    // rust: horizon_client::confirm_screen::Choice::new(
    // rust: &self.gui.atlas.font,
    // rust: size,
    // rust: &Text::translate("chat.link.confirm", &[]),
    // rust: &message,
    // rust: 3,
    // rust: 100.0,
    // rust: )
}
    // rust: pub(super) fn draw_link_prompt(&self, batch: &mut HudBatch) {
    // rust: let Some(url) = &self.link_prompt else {
    // rust: return;
}
    // rust: horizon_client::widgets::cover_frame();
        // ConfirmLinkScreen: the question and the link (its warning is a
        // widget of its own, not narrated).
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: super::screen_info::confirm(
    // rust: "chat/confirm_link",
    // rust: &super::screen_info::tr("chat.link.confirm", &[]),
    // rust: url,
    // rust: )
    // rust: });
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: horizon_client::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, true);
    // rust: let labels = [
    // rust: Text::translate("gui.yes", &[]),
    // rust: Text::translate("chat.copy", &[]),
    // rust: Text::translate("gui.no", &[]),
    // rust: ];
    // rust: let mut layout = self.link_prompt_layout(url, (w, h));
    // rust: layout.declare_no(2);
    // rust: layout.draw(batch, atlas, self.cursor, &labels);
}
    // The prompt's answer: the link opens on yes; either way the chat is back.
    // rust: pub(super) fn answer_link_prompt(&mut self, yes: bool) {
    // rust: if let Some(url) = self.link_prompt.take()
    // rust: && yes
    // rust: {
    // rust: super::packs::open_uri(&url);
}
}
    // rust: pub(super) fn link_prompt_click(&mut self) {
    // rust: let Some(url) = self.link_prompt.clone() else {
    // rust: return;
}
    // rust: let pressed = self
    // rust: .link_prompt_layout(&url, self.gui_size())
    // rust: .pressed_at(self.cursor);
    // rust: if let Some(button) = pressed {
    // rust: self.audio.play_button_click();
    // rust: if button == LINK_COPY {
                // ConfirmLinkScreen.copyToClipboard, then the callback's no.
//                 use horizon_client::clipboard::Clipboard;
    // rust: self.clipboard.set(&url);
}
    // rust: self.answer_link_prompt(button == LINK_YES);
}
}
    // `Screen.clickCommandAction`: run a clicked command as the player
    // without adding it to the chat history. A client mod's command goes
    // first, as `ClientPacketListener.sendUnattendedCommand` lets client
    // commands take it.
    // rust: pub(super) fn click_command(&mut self, command: &str) {
    // rust: let command = command.strip_prefix('/').unwrap_or(command);
    // rust: if self.client_mod_command(command) {
    // rust: return;
}
    // rust: if self.remote.is_some() {
    // rust: self.send_unattended_command(command);
    // rust: } else {
    // rust: self.run_command(command);
}
}
    // PvP & HUD's chat search on or off. The box holds the query: what was typed is put aside
    // when the search starts and comes back when it stops.
toggle_chat_search :: proc(self: ^Self) {
}
    // rust: let typed = self.ui.chat_screen.as_ref().map(|s| s.value().to_owned());
    // rust: let next = if self.pvp.chat_search {
    // rust: std::mem::take(&mut self.pvp.chat_search_aside)
    // rust: } else {
    // rust: self.pvp.chat_search_aside = typed.unwrap_or_default();
    // rust: String::new()
}
    // rust: self.pvp.chat_search = !self.pvp.chat_search;
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: if let Some(screen) = self.ui.chat_screen.as_mut() {
    // rust: screen.suggest_command(&m, &c, &next);
}
}
    // Chat lines over the HUD (focused while the chat screen is open).
    // rust: pub(super) fn draw_chat(&mut self, batch: &mut HudBatch) {
    // rust: let focused = self.screen == Screen::Chat;
    // rust: let options = self.settings.extras.pvp.chat;
    // rust: self.ui.chat.set_qol(&self.gui.atlas, options.qol());
        // A search ends with its option; a chat closed some other way ends it in keep_chat_draft.
    // rust: if self.pvp.chat_search && self.ui.chat_screen.is_none() {
            // The chat went without closing (leaving the world): nothing to give back.
    // rust: self.pvp.chat_search = false;
    // rust: self.pvp.chat_search_aside.clear();
    // rust: } else if self.pvp.chat_search && !options.search {
    // rust: self.toggle_chat_search();
}
    // rust: let query = self
    // rust: .ui
    // rust: .chat_screen
    // rust: .as_ref()
    // rust: .filter(|_| focused && self.pvp.chat_search)
    // rust: .map(|s| s.value());
    // rust: self.ui.chat.set_search(&self.gui.atlas, query);
    // rust: self.ui.chat.search_prompt = focused && self.pvp.chat_search;
    // rust: if self.ui.hide_gui && !focused {
    // rust: return;
}
    // rust: self.ui.chat.smooth = self.settings.extras.chat_animation;
    // rust: self.ui.chat.hide_indicator = !self.settings.extras.chat_indicator;
        // The fractional tick makes the smooth chat extra's slide move every
        // frame; vanilla's fade reads it too.
    // rust: let now = self.visual_ticks() as f32 + self.clock.fraction() as f32;
    // rust: self.ui.chat.draw(batch, &self.gui.atlas, now, focused);
}
    // `HoverEvent.EntityTooltipInfo.getTooltipLines`: the name when the
    // event has one, the entity type and the UUID.
entity_tooltip_lines :: proc(entity: ^serde_json::Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut lines = Vec::new();
    // rust: if let Some(name) = entity.get("name") {
    // rust: let name = horizon_client::component::to_text(name, &mut |s| Text::literal(s));
    // rust: lines.push((name, u32::MAX));
}
    // rust: let id = entity
    // rust: .get("id")
    // rust: .and_then(serde_json::Value::as_str)
    // rust: .unwrap_or_default();
    // rust: let kind = Text::translate(&format!("entity.{}", id.replace(':', ".")), &[]);
    // rust: lines.push((
    // rust: Text::translate("gui.entity_tooltip.type", &[kind]),
    // rust: u32::MAX,
    // rust: ));
    // rust: if let Some(uuid) = entity.get("uuid").and_then(Self::entity_uuid) {
    // rust: lines.push((Text::literal(uuid), u32::MAX));
}
    // rust: lines
}
    // The UUID of a ShowEntity event: its string, or the int array
    // `UUIDUtil.CODEC` writes (most significant word first).
entity_uuid :: proc(v: ^serde_json::Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(s) = v.as_str() {
    // rust: return Some(s.to_owned());
}
    // rust: let words = v.as_array().filter(|w| w.len() == 4)?;
    // rust: let mut bits = 0u128;
    // rust: for w in words {
    // rust: bits = (bits << 32) | u128::from(w.as_i64()? as u32);
}
    // rust: Some(horizon_protocol::crypto::uuid_string(bits))
}
    // rust: pub(super) fn draw_chat_screen(&mut self, batch: &mut HudBatch) {
    // rust: let Some(mut screen) = self.ui.chat_screen.take() else {
    // rust: return;
}
        // ChatScreen.updateNarrationState: the restricted prompt is
        // `displayMode.showRestrictedPrompt`, the abilities' restrictions.
    // rust: let in_bed = self.ui.in_bed_chat && self.sleeping.is_some();
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: super::screen_info::chat(
    // rust: in_bed,
    // rust: screen.value(),
    // rust: screen.abilities.any_restriction(),
    // rust: &super::screen_info::tr,
    // rust: )
    // rust: });
    // rust: let m = Measure(&self.gui.atlas.font);
    // rust: let c = Commands {
    // rust: dispatcher: chat_tree(&self.remote),
    // rust: registries: &self.ui.registries,
}
    // rust: screen.resize(&m, &c, batch.width as i32, batch.height as i32);
        // Options.getBackgroundColor(Integer.MIN_VALUE).
    // rust: let background = if self.settings.file.bool("backgroundForChatOnly") {
    // rust: i32::MIN
    // rust: } else {
    // rust: self.settings.text_background(0.0) as i32
}
    // rust: let mouse = (self.cursor.0.floor() as i32, self.cursor.1.floor() as i32);
    // rust: let blink = self
    // rust: .ui
    // rust: .chat_opened
    // rust: .map_or(0, |t| t.elapsed().as_millis() as u64);
    // rust: let draws = screen.draw(&m, mouse, blink, background);
    // rust: horizon_client::screen_draw::paint(batch, &self.gui.atlas, &draws);
    // rust: self.ui.chat_screen = Some(screen);
    // rust: if in_bed {
    // rust: let button = Self::leave_bed_draws(&m, mouse, batch.width, batch.height);
    // rust: horizon_client::screen_draw::paint(batch, &self.gui.atlas, &button);
}
        // The hovered message part's tooltip (`renderComponentHoverEffect`),
        // or the text of the message tag under the cursor.
    // rust: let height = batch.height as i32;
    // rust: let (cx, cy) = (f64::from(self.cursor.0), f64::from(self.cursor.1));
    // rust: let wrap = (batch.width as i32 / 2).max(200);
        // handleTagIcon: the chat-modified icons over the cursor or its message.
    // rust: let (tag_tooltip, tag_icons) =
    // rust: self.ui
    // rust: .chat
    // rust: .focused_tags(&self.gui.atlas.font, height, cx, cy);
    // rust: horizon_client::hud_layout::paint(batch, &self.gui.atlas, &tag_icons);
    // rust: if let Some(style) = self.ui.chat.style_at(&self.gui.atlas.font, height, cx, cy) {
            // ActiveTextCollector.ClickableStyleFinder: a click event, or an
            // insertion while Shift is held (ChatScreen.includeInsertions).
    // rust: if style.click.is_some() || (style.insertion.is_some() && self.has_shift_down()) {
    // rust: horizon_client::widgets::request_cursor(
    // rust: horizon_client::widgets::Cursor::PointingHand,
    // rust: );
}
    // rust: if let Some(hover) = style.hover {
    // rust: let lines = self.wrapped_rows(&hover, wrap);
    // rust: self.draw_tooltip_lines(batch, &lines, self.cursor.0, self.cursor.1);
    // rust: } else if let Some(stack) = style
    // rust: .hover_item
    // rust: .as_deref()
    // rust: .and_then(horizon_client::item_data::stack_from_hover)
    // rust: .filter(|s| self.items().get(&s.item).is_some())
    // rust: {
    // rust: self.draw_stack_tooltip(batch, &stack, self.cursor.0, self.cursor.1);
    // rust: } else if let Some(entity) = style
    // rust: .hover_entity
    // rust: .as_deref()
    // rust: .filter(|_| self.settings.file.bool("advancedItemTooltips"))
    // rust: {
                // ChatScreen: a ShowEntity tooltip only with advanced tooltips on.
    // rust: let lines = Self::entity_tooltip_lines(entity);
    // rust: self.draw_tooltip_lines(batch, &lines, self.cursor.0, self.cursor.1);
}
    // rust: } else if let Some(tag) = &tag_tooltip {
            // The message tag's text, split at 210.
    // rust: let lines = self.wrapped_rows(tag, 210);
    // rust: self.draw_tooltip_lines(batch, &lines, self.cursor.0, self.cursor.1);
}
}
    // `Font.split`: a tooltip text wrapped at `width`, one white row per line.
    // rust: pub(super) fn wrapped_rows(&self, text: &Text, width: i32) -> Vec<(Text, u32)> {
    // rust: let split = self
    // rust: .gui
    // rust: .atlas
    // rust: .font
    // rust: .split(&text.resolve_legacy(), width as f32);
    // rust: split.into_iter().map(|row| (row, u32::MAX)).collect()
}
    // Advance the overworld clock (ServerClockManager.tick) when
    // `advance_time` allows it.
    // rust: pub(super) fn advance_clock(&mut self) {
    // rust: if !self.ui.rules.bool("advance_time") || self.ui.clock.paused {
    // rust: return;
}
    // rust: let c = &mut self.ui.clock;
    // rust: c.partial += c.rate;
    // rust: let whole = c.partial.floor();
    // rust: c.partial -= whole;
    // rust: self.world.day_time += whole as i64;
}
    // `ServerClockInstance.packNetworkState`: the rate players' clients
    // advance the overworld clock at, 0 while it is paused (`/time pause`)
    // or `advance_time` is off.
    // rust: pub(super) fn network_clock_rate(&self) -> f32 {
    // rust: if self.ui.rules.bool("advance_time") && !self.ui.clock.paused {
    // rust: self.ui.clock.rate
    // rust: } else {
    // rust: 0.0
}
}
    // The engine-side rule values (block behaviour and health).
    // rust: pub(super) fn level_rules(&self) -> horizon_world::level::GameRules {
    // rust: let r = &self.ui.rules;
    // rust: horizon_world::level::GameRules {
    // rust: water_source_conversion: r.bool("water_source_conversion"),
    // rust: lava_source_conversion: r.bool("lava_source_conversion"),
    // rust: random_tick_speed: r.int("random_tick_speed"),
    // rust: block_drops: r.bool("block_drops"),
    // rust: mob_griefing: r.bool("mob_griefing"),
    // rust: max_snow_accumulation_height: r.int("max_snow_accumulation_height"),
    // rust: spawn_mobs: r.bool("spawn_mobs"),
    // rust: spawn_monsters: r.bool("spawn_monsters"),
    // rust: fire_spread_radius_around_player: r.int("fire_spread_radius_around_player"),
    // rust: spread_vines: r.bool("spread_vines"),
}
}
    // Apply rules mirrored in other state (natural regeneration, difficulty).
    // rust: pub(super) fn sync_rules(&mut self) {
    // rust: self.world.health_rules.natural_regeneration =
    // rust: self.ui.rules.bool("natural_health_regeneration");
        // Player.isInvulnerableTo: the damage-type rules.
    // rust: self.world.health_rules.drowning_damage = self.ui.rules.bool("drowning_damage");
    // rust: self.world.health_rules.fall_damage = self.ui.rules.bool("fall_damage");
    // rust: self.world.health_rules.fire_damage = self.ui.rules.bool("fire_damage");
    // rust: self.world.health_rules.freeze_damage = self.ui.rules.bool("freeze_damage");
    // rust: horizon_client::mobs::sulfur_cube::set_tnt_explodes(self.ui.rules.bool("tnt_explodes"));
//         use horizon_world::food::Difficulty;
    // rust: self.world.health_rules.difficulty = match self.ui.difficulty {
    // rust: 0 => Difficulty::Peaceful,
    // rust: 1 => Difficulty::Easy,
    // rust: 3 => Difficulty::Hard,
    // rust: _ => Difficulty::Normal,
}
}
    // `ServerClockManager.ServerClockInstance.loadFrom`: restore the existing
    // Overworld state when a world opens; clear the other command-state cache.
    // rust: pub(super) fn load_world_state(&mut self) {
    // rust: self.ui.rules =
    // rust: GameRules::load_with_features(&self.world_root, &self.level.enabled_features);
    // rust: self.ui.clock = WorldClock::default();
    // rust: self.ui.command_clocks.clear();
        // PrimaryLevelData: the difficulty comes back from level.dat's difficulty_settings.
    // rust: self.ui.difficulty = self.level.difficulty_id();
    // rust: if let Ok(bytes) = std::fs::read(self.world_root.join("data/minecraft/world_clocks.dat"))
    // rust: && let Ok(raw) = horizon_world::compression::Compression::Gzip.decode(&bytes, 1 << 20)
    // rust: && let Ok((root, _)) =
    // rust: horizon_world::nbt::read_named(&raw, horizon_world::nbt::Limits::default())
    // rust: && let Some(c) = root
    // rust: .tag
    // rust: .get("data")
    // rust: .and_then(|d| d.get("minecraft:overworld"))
    // rust: {
//             use horizon_world::nbt::Tag;
    // rust: if let Some(Tag::Float(r)) = c.get("rate") {
    // rust: self.ui.clock.rate = f32::from_bits(*r);
}
    // rust: if let Some(Tag::Float(p)) = c.get("partial_tick") {
    // rust: self.ui.clock.partial = f32::from_bits(*p);
}
    // rust: if let Some(Tag::Byte(p)) = c.get("paused") {
    // rust: self.ui.clock.paused = *p != 0;
}
}
    // rust: self.ui.chat.clear();
    // rust: self.build_registries();
    // rust: self.sync_rules();
}
    // Save the clock beside level.dat (Level.write saves the game rules: a
    // second writer of game_rules.dat could leave it with the rules loaded
    // when the world opened).
    // rust: pub(super) fn save_world_state(&mut self) {
    // rust: if self.world_root.as_os_str().is_empty() {
    // rust: return;
}
//         use horizon_world::nbt::Tag;
    // rust: let c = self.ui.clock;
        // The other clocks stay as saved; the overworld one keeps the fields Horizon
        // does not model, and (like vanilla's codec) omits rate, partial tick and
        // pause while they have their defaults.
    // rust: let path = self.world_root.join("data/minecraft/world_clocks.dat");
    // rust: let existing = horizon_client::save::read_dat(&path);
    // rust: let mut data = match existing.as_ref().and_then(|r| r.get("data")) {
    // rust: Some(d @ Tag::Compound(_)) => d.clone(),
    // rust: _ => Tag::Compound(Default::default()),
}
    // rust: let mut clock = match data.get("minecraft:overworld") {
    // rust: Some(c @ Tag::Compound(_)) => c.clone(),
    // rust: _ => Tag::Compound(Default::default()),
}
    // rust: if let Tag::Compound(map) = &mut clock {
    // rust: map.insert("total_ticks".into(), Tag::Long(self.world.day_time));
    // rust: for (key, value, default) in [
    // rust: (
    // rust: "partial_tick",
    // rust: Tag::Float(c.partial.to_bits()),
    // rust: c.partial == 0.0,
    // rust: ),
    // rust: ("rate", Tag::Float(c.rate.to_bits()), c.rate == 1.0),
    // rust: ("paused", Tag::Byte(i8::from(c.paused)), !c.paused),
    // rust: ] {
    // rust: if default {
    // rust: map.remove(&key.into());
    // rust: } else {
    // rust: map.insert(key.into(), value);
}
}
}
    // rust: if let Tag::Compound(map) = &mut data {
    // rust: map.insert("minecraft:overworld".into(), clock);
}
    // rust: let root = Tag::compound([
    // rust: ("data", data),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]);
    // rust: if let Err(e) = horizon_client::save::write_dat(&path, root) {
    // rust: log::warn!("the world clocks were not written: {e}");
}
}
    // F1 hides the HUD (see `hud`); the screenshot key still works.
    // rust: pub(super) fn toggle_hide_gui(&mut self) {
    // rust: self.ui.hide_gui = !self.ui.hide_gui;
}
    // F2: ScreenShot.grab into `screenshots/` with vanilla's file name.
    // rust: pub(super) fn take_screenshot(&mut self) {
    // rust: let dir = horizon_client::logging::player_dir().join("screenshots");
    // rust: if std::fs::create_dir_all(&dir).is_err() {
    // rust: return;
}
    // rust: let name = screenshot_name(&dir);
    // rust: let Some(renderer) = self.renderer.as_mut() else {
    // rust: return;
}
    // rust: let path = dir.join(name);
    // rust: renderer.screenshot = Some(horizon_client::gfx::ScreenshotRequest {
    // rust: path: path.clone(),
    // rust: size: None,
    // rust: scaled: true,
    // rust: });
    // rust: self.ui.screenshot_message = Some(path);
}
    // `Minecraft.handleGlobalKeyPress`'s screenshot branch: the
    // `key.screenshot` mapping (F2 by default) takes the picture before a
    // screen or a text box sees the key, and the debug modifier suppresses it.
    // rust: pub(super) fn screenshot_shortcut(&mut self, key: KeyCode, repeat: bool) -> bool {
    // rust: if repeat
    // rust: || horizon_client::keybinds::key_name(key)
    // rust: != Some(self.settings.keys.get("key.screenshot"))
    // rust: {
    // rust: return false;
}
    // rust: self.screenshot_action()
}
    // key.screenshot from any device: not while F3 is down, where F3+F2 is a
    // debug key.
    // rust: pub(super) fn screenshot_action(&mut self) -> bool {
    // rust: if self.debug_keys.modifier_down {
    // rust: return false;
}
    // rust: self.take_screenshot();
    // rust: true
}
    // After a frame: report a finished F2 screenshot in chat.
    // rust: pub(super) fn finish_screenshot(&mut self, result: &std::result::Result<[u32; 2], String>) {
    // rust: let Some(path) = self.ui.screenshot_message.take() else {
    // rust: return;
}
    // rust: let message = match result {
    // rust: Ok(_) => {
    // rust: log::info!("Saved screenshot to {}", path.display());
    // rust: let name = path.file_name().unwrap_or_default().to_string_lossy();
    // rust: let link = Text::styled(
    // rust: name,
    // rust: Style {
    // rust: underlined: Some(true),
    // rust: click: Some(ClickEvent::OpenFile(path.to_string_lossy().into_owned())),
    // rust: ..Style::default()
    // rust: },
    // rust: );
    // rust: Text::translate("screenshot.success", &[link])
}
    // rust: Err(e) => Text::translate("screenshot.failure", &[Text::literal(e.clone())]),
}
    // rust: let focused = self.screen == Screen::Chat;
    // rust: self.ui.chat.add(
    // rust: &self.gui.atlas,
    // rust: message,
    // rust: None,
    // rust: ChatSource::Client,
    // rust: self.visual_ticks(),
    // rust: focused,
    // rust: );
}
}
// `yyyy-MM-dd_HH.mm.ss[_n].png` (Util.getFilenameFormattedDateTime, in local time).
screenshot_name :: proc(dir: ^std::path::Path) -> S {
    // Ported from Horizon
    return {}
}
    // Util.getFilenameFormattedDateTime: the local date and time.
    // rust: let base = chrono::Local::now().format("%Y-%m-%d_%H.%M.%S").to_string();
    // rust: let mut n = 1;
    // rust: loop {
    // rust: let name = if n == 1 {
    // rust: format!("{base}.png")
    // rust: } else {
    // rust: format!("{base}_{n}.png")
}
    // rust: if !dir.join(&name).exists() {
    // rust: return name;
}
    // rust: n += 1;
}
}

// `IntegratedServer.getProfilePermissions` for the owner: `OWNER` (4) when
// commands are allowed, else `ALL` (0).
owner_permission :: proc(allow_commands: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if allow_commands { 4 } else { 0 }
}

// `ConfirmLinkScreen`'s buttons, left to right: yes, copy, no.
LINK_YES :: 0
LINK_COPY :: 1

    // rust: mod tests {
//     use super::*;

    // `ChatScreen.shouldDiscardDraft`.
draft_discard_follows_the_exit_reason :: proc() {
}
    // rust: assert!(!should_discard_draft(ChatExit::Interrupted, false));
    // rust: assert!(!should_discard_draft(ChatExit::Interrupted, true));
    // rust: assert!(should_discard_draft(ChatExit::Intentional, false));
    // rust: assert!(!should_discard_draft(ChatExit::Intentional, true));
    // rust: assert!(should_discard_draft(ChatExit::Done, true));
}

resource_ids_are_listed_once_per_root :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-ids-{}", std::process::id()));
    // rust: let recipe = root.join("data/minecraft/recipe");
    // rust: std::fs::create_dir_all(recipe.join("sub")).unwrap();
    // rust: std::fs::write(recipe.join("b.json"), "{}").unwrap();
    // rust: std::fs::write(recipe.join("sub/a.json"), "{}").unwrap();
    // rust: std::fs::write(recipe.join("notes.txt"), "").unwrap();
    // rust: let first = resource_ids(&root);
    // rust: assert_eq!(first.recipes, ["minecraft:b", "minecraft:sub/a"]);
    // rust: assert!(first.loot_tables.is_empty());
    // rust: std::fs::write(recipe.join("c.json"), "{}").unwrap();
    // rust: assert!(Arc::ptr_eq(&first, &resource_ids(&root)));
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    // A content mod's loot tables are listed with vanilla's, so `/loot`
    // finds them.
loot_tables_of_every_namespace_are_listed :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-loot-ids-{}", std::process::id()));
    // rust: for dir in [
    // rust: "data/minecraft/loot_table/chests",
    // rust: "data/mymod/loot_table/rooms",
    // rust: ] {
    // rust: std::fs::create_dir_all(root.join(dir)).unwrap();
}
    // rust: std::fs::write(root.join("data/minecraft/loot_table/chests/a.json"), "{}").unwrap();
    // rust: std::fs::write(root.join("data/mymod/loot_table/rooms/b.json"), "{}").unwrap();
    // rust: std::fs::write(root.join("data/mymod/loot_table/notes.txt"), "").unwrap();
    // rust: assert_eq!(
    // rust: resource_ids(&root).loot_tables,
    // rust: ["minecraft:chests/a", "mymod:rooms/b"]
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    // Only the overworld clock's timelines count; a marker is a bare tick
    // count (hidden from commands) or an object that may show itself.
overworld_timelines_and_markers :: proc() {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-timelines-{}", std::process::id()));
    // rust: let dir = root.join("data/minecraft/timeline");
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(
    // rust: dir.join("day.json"),
    // rust: r#"{"clock":"minecraft:overworld","period_ticks":24000,
    // rust: "time_markers":{"minecraft:noon":6000,
    // rust: "minecraft:night":{"ticks":13000,"show_in_commands":true}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: dir.join("other.json"),
    // rust: r#"{"clock":"minecraft:the_end","time_markers":{"minecraft:x":1}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(dir.join("broken.json"), "{").unwrap();
    // rust: let (timelines, markers) = overworld_timelines(&root);
    // rust: assert_eq!(timelines, [("minecraft:day".to_owned(), Some(24000))]);
    // rust: let mut markers: Vec<_> = markers
    // rust: .iter()
    // rust: .map(|(name, m)| (name.as_str(), m.ticks, m.period, m.show))
    // rust: .collect();
    // rust: markers.sort();
    // rust: assert_eq!(
    // rust: markers,
    // rust: [
    // rust: ("minecraft:night", 13000, Some(24000), true),
    // rust: ("minecraft:noon", 6000, Some(24000), false),
    // rust: ]
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&root);
}

    // The export is read once per folder; a folder without one stays without.
command_exports_are_read_once_per_folder :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-export-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join("command-registries.json"), r#"{"effects":["a"]}"#).unwrap();
    // rust: let first = command_export(&dir, true).unwrap();
    // rust: assert_eq!(first.effects, ["a"]);
    // rust: std::fs::write(dir.join("command-registries.json"), "{}").unwrap();
    // rust: assert!(Arc::ptr_eq(&first, &command_export(&dir, true).unwrap()));
    // rust: assert!(command_export(&dir.join("missing"), true).is_none());
        // A dedicated server's read is not kept.
    // rust: let other = dir.join("other");
    // rust: std::fs::create_dir_all(&other).unwrap();
    // rust: std::fs::write(
    // rust: other.join("command-registries.json"),
    // rust: r#"{"effects":["b"]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let once = command_export(&other, false).unwrap();
    // rust: assert_eq!(once.effects, ["b"]);
    // rust: assert!(!Arc::ptr_eq(&once, &command_export(&other, false).unwrap()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

    // A native mod's command is in the tree the chat box uses (#456): known
    // rather than red, and offered as it types. With no mod claiming one the
    // tree is the game's own, as it was before the mods were asked.
native_mod_commands_join_the_chat_tree :: proc() {
}
    // rust: let reg = Registries::default();
    // rust: let vanilla = horizon_client::command::vanilla::game_dispatcher();
    // rust: let plain = with_native_commands(vanilla, &[]);
    // rust: assert_eq!(plain.nodes.len(), vanilla.nodes.len());
    // rust: assert!(plain.find("flyspeed").is_none());
    // rust: let tree = with_native_commands(vanilla, &["flyspeed"]);
    // rust: assert!(tree.find("flyspeed").is_some());
        // The rest of the line goes to the mod, as `native_command` gets it.
    // rust: let parse = tree.parse("flyspeed 4", &reg);
    // rust: assert_eq!(
    // rust: parse.executable().unwrap().1,
    // rust: horizon_client::command::MOD_COMMAND
    // rust: );
    // rust: let parse = tree.parse("fly", &reg);
    // rust: let offered: Vec<String> = tree
    // rust: .client_suggestions(&parse, 3, &reg)
    // rust: .1
    // rust: .into_iter()
    // rust: .map(|s| s.text)
    // rust: .collect();
    // rust: assert!(offered.contains(&"flyspeed".to_owned()), "{offered:?}");
        // A name the game has keeps that command: the chat still knows it.
    // rust: let shared = with_native_commands(vanilla, &["help"]);
    // rust: assert!(shared.find("help").is_some());
    // rust: assert_eq!(
    // rust: shared.parse("help", &reg).executable().map(|e| e.1),
    // rust: vanilla.parse("help", &reg).executable().map(|e| e.1)
    // rust: );
    // rust: assert_eq!(shared.nodes.len(), vanilla.nodes.len());
}

    // When `entity_types` is empty (no `entity-types.json`), fallback includes
    // standard mobs, non-mob entities, and `wind_charge` / `breeze_wind_charge`.
summonable_entities_empty_fallback_includes_mobs_and_non_mobs :: proc() {
}
    // rust: let mobs = ["cow", "zombie", "skeleton"];
    // rust: let summonable = summonable_entities(&[], mobs);
    // rust: assert!(summonable.contains(&"minecraft:cow".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:zombie".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:skeleton".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:item".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:arrow".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:lightning_bolt".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:minecart".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:wind_charge".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:breeze_wind_charge".to_string()));
}

    // Non-summonables `minecraft:player` and `minecraft:fishing_bobber` are
    // never included in `reg.summonable`.
summonable_entities_never_includes_player_or_fishing_bobber :: proc() {
}
    // rust: let all_types = vec![
    // rust: "minecraft:cow".to_string(),
    // rust: "minecraft:player".to_string(),
    // rust: "minecraft:fishing_bobber".to_string(),
    // rust: "minecraft:wind_charge".to_string(),
    // rust: ];
    // rust: let summonable = summonable_entities(&all_types, &[] as &[&str]);
    // rust: assert!(!summonable.contains(&"minecraft:player".to_string()));
    // rust: assert!(!summonable.contains(&"minecraft:fishing_bobber".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:cow".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:wind_charge".to_string()));

    // rust: let fallback = summonable_entities(&[], ["player", "fishing_bobber", "zombie"]);
    // rust: assert!(!fallback.contains(&"minecraft:player".to_string()));
    // rust: assert!(!fallback.contains(&"minecraft:fishing_bobber".to_string()));
    // rust: assert!(fallback.contains(&"minecraft:zombie".to_string()));
}

    // `minecraft:wind_charge` and `minecraft:breeze_wind_charge` are in
    // `reg.summonable`, and `/summon wind` or `/summon minecraft:wind_charg`
    // suggest them via `Suggests::SummonableEntities` / `resource_matches`.
summonable_entities_suggests_wind_charge_variants :: proc() {
}
    // rust: let all_types = vec![
    // rust: "minecraft:wind_charge".to_string(),
    // rust: "minecraft:breeze_wind_charge".to_string(),
    // rust: "minecraft:zombie".to_string(),
    // rust: ];
    // rust: let summonable = summonable_entities(&all_types, &[] as &[&str]);
    // rust: assert!(summonable.contains(&"minecraft:wind_charge".to_string()));
    // rust: assert!(summonable.contains(&"minecraft:breeze_wind_charge".to_string()));

    // rust: assert!(horizon_client::command::args::resource_matches(
    // rust: "wind",
    // rust: "minecraft:wind_charge"
    // rust: ));
    // rust: assert!(horizon_client::command::args::resource_matches(
    // rust: "wind",
    // rust: "minecraft:breeze_wind_charge"
    // rust: ));
    // rust: assert!(horizon_client::command::args::resource_matches(
    // rust: "minecraft:wind_charg",
    // rust: "minecraft:wind_charge"
    // rust: ));
    // rust: assert!(!horizon_client::command::args::resource_matches(
    // rust: "minecraft:wind_charg",
    // rust: "minecraft:breeze_wind_charge"
    // rust: ));

    // rust: let reg = Registries {
    // rust: permission: 2,
    // rust: summonable,
    // rust: ..Default::default()
}
    // rust: let vanilla = horizon_client::command::vanilla::game_dispatcher();

    // rust: let parse = vanilla.parse("summon wind", &reg);
    // rust: let (_range, suggestions) = vanilla.client_suggestions(&parse, "summon wind".len(), &reg);
    // rust: let texts: Vec<String> = suggestions.into_iter().map(|s| s.text).collect();
    // rust: assert!(texts.contains(&"minecraft:wind_charge".to_string()));
    // rust: assert!(texts.contains(&"minecraft:breeze_wind_charge".to_string()));

    // rust: let parse = vanilla.parse("summon minecraft:wind_charg", &reg);
    // rust: let (_range, suggestions) =
    // rust: vanilla.client_suggestions(&parse, "summon minecraft:wind_charg".len(), &reg);
    // rust: let texts: Vec<String> = suggestions.into_iter().map(|s| s.text).collect();
    // rust: assert_eq!(texts, vec!["minecraft:wind_charge".to_string()]);
}

    // `Registries::fill_from_export` and `fill_from_exported` populate
    // `self.summonable` and `self.entity_types` when present in export JSON,
    // and sort/dedup properly.
export_propagation_populates_and_dedups_summonable_and_entity_types :: proc() {
}
    // rust: let export_json = serde_json::json!({
    // rust: "summonable": [
    // rust: "minecraft:zombie",
    // rust: "minecraft:arrow",
    // rust: "minecraft:zombie",
    // rust: "minecraft:wind_charge"
    // rust: ],
    // rust: "entity_types": [
    // rust: "minecraft:zombie",
    // rust: "minecraft:player",
    // rust: "minecraft:arrow",
    // rust: "minecraft:zombie"
    // rust: ]
    // rust: });
    // rust: let mut reg = Registries::default();
    // rust: reg.fill_from_export(&export_json);
    // rust: assert_eq!(
    // rust: reg.summonable,
    // rust: vec![
    // rust: "minecraft:arrow".to_string(),
    // rust: "minecraft:wind_charge".to_string(),
    // rust: "minecraft:zombie".to_string(),
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: reg.entity_types,
    // rust: vec![
    // rust: "minecraft:arrow".to_string(),
    // rust: "minecraft:player".to_string(),
    // rust: "minecraft:zombie".to_string(),
    // rust: ]
    // rust: );

    // rust: let mut dest = Registries::default();
    // rust: dest.fill_from_exported(&reg);
    // rust: assert_eq!(dest.summonable, reg.summonable);
    // rust: assert_eq!(dest.entity_types, reg.entity_types);

    // rust: let mut prefilled = Registries {
    // rust: summonable: vec!["minecraft:pig".to_string()],
    // rust: entity_types: vec!["minecraft:pig".to_string()],
    // rust: ..Default::default()
}
    // rust: prefilled.fill_from_exported(&reg);
    // rust: assert_eq!(prefilled.summonable, vec!["minecraft:pig".to_string()]);
    // rust: assert_eq!(prefilled.entity_types, vec!["minecraft:pig".to_string()]);
}

    // The sleeper's chat: Leave Bed is a button target for the pad and the
    // keyboard, right above the chat box, and the D-pad steps between the
    // two.
leave_bed_is_a_focus_target_above_the_chat_box :: proc() {
}
//         use super::super::key_focus;
//         use horizon_client::{
    // rust: font::Font,
    // rust: gamepad::{Button, focus_step_strict},
    // rust: widgets::Kind,
}
//         use std::collections::HashMap;
        // The missing-glyph metrics measure without game assets.
    // rust: let font = Font::load(
    // rust: Path::new("/nonexistent-horizon-chat-test-resources"),
    // rust: &HashMap::new(),
    // rust: &[],
    // rust: (1, 1),
    // rust: (0, 0),
    // rust: horizon_client::hud::Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 1,
    // rust: h: 1,
    // rust: },
    // rust: );
    // rust: let m = Measure(&font);
    // rust: let registries = Registries::default();
    // rust: let c = Commands {
    // rust: dispatcher: horizon_client::command::vanilla::game_dispatcher(),
    // rust: registries: &registries,
}
    // rust: let (width, height) = (427.0, 240.0);
    // rust: let mut screen = ChatScreen::new(
    // rust: &m,
    // rust: &c,
    // rust: "",
    // rust: 0,
    // rust: width as i32,
    // rust: height as i32,
    // rust: ChatAbilities::new(ChatVisibility::Full),
    // rust: );
    // rust: screen.draw(&m, (0, 0), 0, 0);
    // rust: Game::leave_bed_draws(&m, (0, 0), width, height);
    // rust: horizon_client::widgets::end_frame(u64::MAX);

    // rust: let targets = key_focus::drawn_targets();
    // rust: let (x, y, w, h) = Game::leave_bed_button(width, height);
    // rust: let bed = targets
    // rust: .iter()
    // rust: .copied()
    // rust: .find(|t| t.rect == [x as f32, y as f32, w as f32, h as f32])
    // rust: .expect("Leave Bed is a focus target");
    // rust: assert_eq!(bed.kind, Kind::Button);
    // rust: assert!(key_focus::keyboard_targets(targets.clone(), false).contains(&bed));
    // rust: let field = targets
    // rust: .iter()
    // rust: .copied()
    // rust: .find(|t| t.kind == Kind::Field)
    // rust: .expect("the chat box is a focus target");
    // rust: let rects: Vec<_> = targets.iter().map(|t| t.rect).collect();
    // rust: let step =
    // rust: |from: [f32; 4], button| focus_step_strict(from, button, &rects).map(|i| targets[i]);
    // rust: assert_eq!(step(field.rect, Button::DPadUp), Some(bed));
    // rust: assert_eq!(step(bed.rect, Button::DPadDown), Some(field));
}
}
