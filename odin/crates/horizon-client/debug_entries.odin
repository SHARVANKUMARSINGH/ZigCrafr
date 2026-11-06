//! Transpiled from Horizon Rust crate
package horizon_client_debug_entries

import "core:fmt"
import "core:mem"
import "core:math"

// The debug screen's entries (26.3 `DebugScreenEntries`, `DebugScreenEntryList`):
// what each F3 line block and debug renderer is, whether it shows always,
// only in the overlay or never, the two built-in profiles, and
// `debug-profile.json` beside `options.txt`, which keeps them.
// use std::collections::BTreeMap;
// use std::path::{Path, PathBuf};

// `DebugScreenEntryStatus`.
Status :: enum {
    AlwaysOn,
    InOverlay,
    Never,
}

    // rust: impl Status {
    // `getSerializedName`.
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Status::AlwaysOn => "alwaysOn",
    // rust: Status::InOverlay => "inOverlay",
    // rust: Status::Never => "never",
}
}
parse :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: [Status::AlwaysOn, Status::InOverlay, Status::Never]
    // rust: .into_iter()
    // rust: .find(|s| s.name() == name)
}
}

// `DebugScreenProfile`.
Profile :: enum {
    Default,
    Performance,
}

    // rust: impl Profile {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Profile::Default => "default",
    // rust: Profile::Performance => "performance",
}
}
translation_key :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Profile::Default => "debug.options.profile.default",
    // rust: Profile::Performance => "debug.options.profile.performance",
}
}
parse :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: [Profile::Default, Profile::Performance]
    // rust: .into_iter()
    // rust: .find(|p| p.name() == name)
}
    // `DebugScreenEntries.PROFILES`.
statuses :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
//         use Status::*;
    // rust: match self {
    // rust: Profile::Default => &[
    // rust: ("3d_crosshair", InOverlay),
    // rust: ("game_version", InOverlay),
    // rust: ("tps", InOverlay),
    // rust: ("fps", InOverlay),
    // rust: ("memory", InOverlay),
    // rust: ("system_specs", InOverlay),
    // rust: ("player_position", InOverlay),
    // rust: ("player_section_position", InOverlay),
    // rust: ("simple_performance_impactors", InOverlay),
    // rust: ],
    // rust: Profile::Performance => &[
    // rust: ("tps", InOverlay),
    // rust: ("fps", AlwaysOn),
    // rust: ("gpu_utilization", InOverlay),
    // rust: ("memory", InOverlay),
    // rust: ("simple_performance_impactors", InOverlay),
    // rust: ],
}
}
}

// `DebugEntryCategory`: the screen's two sections, by `sortKey`.
Category :: enum {
    // `SCREEN_TEXT`, `debug.options.category.text`.
    Text,
    // `RENDERER` (`DebugEntryNoop`), `debug.options.category.renderer`.
    Renderer,
}

    // rust: impl Category {
translation_key :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Category::Text => "debug.options.category.text",
    // rust: Category::Renderer => "debug.options.category.renderer",
}
}
}

// One registered entry: its path in the `minecraft` namespace, its section,
// and whether it shows while debug info is reduced (`isAllowed(true)`).
Entry :: struct {
    path: ^'static str,
    category: Category,
    reduced: bool,
}

    // rust: const fn text(path: &'static str, reduced: bool) -> Entry {
    // rust: Entry {
    // rust: path,
    // rust: category: Category::Text,
    // rust: reduced,
}
}
    // rust: const fn renderer(path: &'static str) -> Entry {
    // rust: Entry {
    // rust: path,
    // rust: category: Category::Renderer,
    // rust: reduced: false,
}
}

// `DebugScreenEntries`' registrations, in their order.
    // rust: pub const ENTRIES: [Entry; 46] = [
    // rust: text("game_version", true),
    // rust: text("fps", true),
    // rust: text("tps", true),
    // rust: text("memory", true),
    // rust: text("detailed_memory", true),
    // rust: text("system_specs", true),
    // rust: text("looking_at_block_state", false),
    // rust: text("looking_at_block_tags", false),
    // rust: text("looking_at_fluid_state", false),
    // rust: text("looking_at_fluid_tags", false),
    // rust: text("looking_at_entity", false),
    // rust: text("looking_at_entity_tags", false),
    // rust: text("chunk_render_stats", true),
    // rust: text("chunk_generation_stats", false),
    // rust: text("entity_render_stats", true),
    // rust: text("particle_render_stats", false),
    // rust: text("chunk_source_stats", true),
    // rust: text("player_position", false),
    // rust: text("player_section_position", true),
    // rust: text("player_speed", false),
    // rust: text("light_levels", false),
    // rust: text("heightmap", false),
    // rust: text("biome", false),
    // rust: text("local_difficulty", false),
    // rust: text("day_count", false),
    // rust: text("entity_spawn_counts", false),
    // rust: text("sound_mood", false),
    // rust: text("sound_cache", true),
    // rust: text("post_effects", false),
    // rust: renderer("entity_hitboxes"),
    // rust: renderer("chunk_borders"),
    // rust: renderer("3d_crosshair"),
    // rust: renderer("chunk_section_paths"),
    // rust: text("gpu_utilization", true),
    // rust: text("simple_performance_impactors", true),
    // rust: renderer("chunk_section_octree"),
    // rust: renderer("visualize_water_levels"),
    // rust: renderer("visualize_heightmap"),
    // rust: renderer("visualize_collision_boxes"),
    // rust: renderer("visualize_entity_supporting_blocks"),
    // rust: renderer("visualize_block_light_levels"),
    // rust: renderer("visualize_sky_light_levels"),
    // rust: renderer("visualize_solid_faces"),
    // rust: renderer("visualize_chunks_on_server"),
    // rust: renderer("visualize_sky_light_sections"),
    // rust: renderer("chunk_section_visibility"),
    // rust: ];

// `DebugScreenEntries.getEntry` by path.
entry :: proc(path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: ENTRIES.iter().find(|e| e.path == path)
}

// `DebugOptionsScreen.OptionList.updateSearch`: the entries whose path
// contains `search`, by category then identifier.
search :: proc(search: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut all: Vec<&Entry> = ENTRIES.iter().filter(|e| e.path.contains(search)).collect();
    // rust: all.sort_by(|a, b| a.category.cmp(&b.category).then(a.path.cmp(b.path)));
    // rust: all
}

// `DebugScreenEntryList`: every entry's status (by full identifier, as the
// file keeps them) and the profile they came from if unchanged. Whether the
// F3 overlay is open (`isOverlayVisible`) is the game's `debug`.
DebugEntries :: struct {
    statuses: BTreeMap<string,
    profile: Maybe(Profile),
    file: Maybe(PathBuf),
}

    // rust: impl Default for DebugEntries {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut entries = Self {
    // rust: statuses: BTreeMap::new(),
    // rust: profile: None,
    // rust: file: None,
}
    // rust: entries.reset_to_profile(Profile::Default);
    // rust: entries
}
}

identifier :: proc(path: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("minecraft:{path}")
}

    // rust: impl DebugEntries {
    // `DebugScreenEntryList.load` from `debug-profile.json` in `dir`: the
    // default profile without a file; a file that does not parse is reset
    // to it and saved again.
load :: proc(dir: ^Path) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let file = dir.join("debug-profile.json");
    // rust: let mut entries = Self {
    // rust: file: Some(file.clone()),
    // rust: ..Self::default()
}
    // rust: let Ok(text) = std::fs::read_to_string(&file) else {
    // rust: return entries;
}
    // rust: match Self::parse(&text) {
    // rust: Some((Some(profile), _)) => entries.reset_to_profile(profile),
    // rust: Some((None, custom)) => {
    // rust: entries.statuses = custom;
    // rust: entries.profile = None;
}
    // rust: None => {
    // rust: log::error!(
    // rust: "Couldn't read debug profile file {}, resetting to default",
    // rust: file.display()
    // rust: );
    // rust: entries.save();
}
}
    // rust: entries
}
    // `SerializedOptions.CODEC`: an optional `profile` name and an optional
    // `custom` map of identifiers to statuses.
parse :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut json: serde_json::Value = serde_json::from_str(text).ok()?;
    // rust: upgrade(&mut json);
    // rust: let object = json.as_object()?;
    // rust: let profile = match object.get("profile") {
    // rust: Some(name) => Some(Profile::parse(name.as_str()?)?),
    // rust: None => None,
}
    // rust: let mut custom = BTreeMap::new();
    // rust: if let Some(map) = object.get("custom") {
    // rust: for (key, status) in map.as_object()? {
                // Identifier.CODEC: a bare path is in the minecraft namespace.
    // rust: let key = if key.contains(':') {
    // rust: key.clone()
    // rust: } else {
    // rust: identifier(key)
}
    // rust: custom.insert(key, Status::parse(status.as_str()?)?);
}
}
    // rust: Some((profile, custom))
}
    // `DebugScreenEntryList.save`: the profile's name while it is unchanged,
    // else every status, with the data version the codec wraps it in.
save :: proc(self: ^Self) {
}
    // rust: let Some(file) = &self.file else {
    // rust: return;
}
    // rust: let mut json = serde_json::Map::new();
    // rust: json.insert(
    // rust: "DataVersion".into(),
    // rust: horizon_core::version::DATA_VERSION.into(),
    // rust: );
    // rust: match self.profile {
    // rust: Some(profile) => {
    // rust: json.insert("profile".into(), profile.name().into());
}
    // rust: None => {
    // rust: let custom: serde_json::Map<String, serde_json::Value> = self
    // rust: .statuses
    // rust: .iter()
    // rust: .map(|(k, s)| (k.clone(), s.name().into()))
    // rust: .collect();
    // rust: json.insert("custom".into(), custom.into());
}
}
    // rust: if let Err(e) = std::fs::write(file, serde_json::Value::Object(json).to_string()) {
    // rust: log::error!("Failed to save debug profile file {}: {e}", file.display());
}
}
reset_to_profile :: proc(self: ^Self, profile: Profile) {
}
    // rust: self.profile = Some(profile);
    // rust: self.statuses = profile
    // rust: .statuses()
    // rust: .iter()
    // rust: .map(|(path, status)| (identifier(path), *status))
    // rust: .collect();
}
    // `loadProfile` then `save` (the screen's profile buttons).
load_profile :: proc(self: ^Self, profile: Profile) {
}
    // rust: self.reset_to_profile(profile);
    // rust: self.save();
}
is_using_profile :: proc(self: ^Self, profile: Profile) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.profile == Some(profile)
}
    // `getStatus`: never for an entry the statuses leave out.
status :: proc(self: ^Self, path: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.statuses
    // rust: .get(&identifier(path))
    // rust: .copied()
    // rust: .unwrap_or(Status::Never)
}
    // `setStatus`: the statuses are custom from now on, and saved.
set_status :: proc(self: ^Self, path: string, status: Status) {
}
    // rust: self.profile = None;
    // rust: self.statuses.insert(identifier(path), status);
    // rust: self.save();
}
    // `toggleStatus` (F3+B, F3+G) with the overlay open or not: whether the
    // entry is on afterwards.
toggle_status :: proc(self: ^Self, path: string, overlay: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (status, on) = match self.statuses.get(&identifier(path)) {
    // rust: Some(Status::AlwaysOn) => (Status::Never, false),
    // rust: Some(Status::InOverlay) if overlay => (Status::Never, false),
    // rust: Some(Status::Never) if overlay => (Status::InOverlay, true),
    // rust: _ => (Status::AlwaysOn, true),
}
    // rust: self.set_status(path, status);
    // rust: on
}
    // `isCurrentlyEnabled` (`rebuildCurrentList`): on always, or in the
    // `overlay` while it is open, and allowed with the debug info `reduced`.
enabled :: proc(self: ^Self, path: string, overlay: bool, reduced: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let shown = match self.status(path) {
    // rust: Status::AlwaysOn => true,
    // rust: Status::InOverlay => overlay,
    // rust: Status::Never => false,
}
    // rust: shown && entry(path).is_some_and(|e| e.reduced || !reduced)
}
    // `getCurrentlyEnabled().isEmpty()` negated: something to draw.
any_enabled :: proc(self: ^Self, overlay: bool, reduced: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: ENTRIES
    // rust: .iter()
    // rust: .any(|e| self.enabled(e.path, overlay, reduced))
}
}

// `DataFixTypes.DEBUG_PROFILE.wrapCodec(..., 4649)`: a file without a
// `DataVersion` is from 4649, the version the file first had.
FIRST_VERSION :: 4649

// The `DataFixers` rules for `References.DEBUG_PROFILE`, each run when the
// file is older than its schema, on the `custom` map.
upgrade :: proc(json: ^serde_json::Value) {
}
    // rust: let version = json
    // rust: .get("DataVersion")
    // rust: .and_then(serde_json::Value::as_i64)
    // rust: .unwrap_or(FIRST_VERSION);
    // rust: let Some(custom) = json.get_mut("custom").and_then(|c| c.as_object_mut()) else {
    // rust: return;
}
    // 4650 DebugProfileOverlayReferenceFix: the status `inF3` is `inOverlay`.
    // rust: if version < 4650 {
    // rust: for status in custom.values_mut() {
    // rust: if status.as_str() == Some("inF3") {
    // rust: *status = "inOverlay".into();
}
}
}
    // 4763 DebugProfileLookingAtSplitFix: the targeted block and fluid
    // entries became their `_state` halves; a key already there wins.
    // rust: if version < 4763 {
    // rust: for (old, new) in [
    // rust: (
    // rust: "minecraft:looking_at_block",
    // rust: "minecraft:looking_at_block_state",
    // rust: ),
    // rust: (
    // rust: "minecraft:looking_at_fluid",
    // rust: "minecraft:looking_at_fluid_state",
    // rust: ),
    // rust: ] {
    // rust: if let Some(status) = custom.remove(old) {
    // rust: custom.entry(new).or_insert(status);
}
}
}
    // 5001 DebugProfileRenameEntryFix: `post_effect` is `post_effects`.
    // rust: if version < 5001
    // rust: && let Some(status) = custom.remove("minecraft:post_effect")
    // rust: {
    // rust: custom.insert("minecraft:post_effects".into(), status);
}
}

    // rust: mod tests {
//     use super::*;

toggling_follows_the_overlay :: proc() {
}
    // rust: let mut e = DebugEntries::default();
        // Not in the default profile: on always while F3 is closed.
    // rust: assert!(e.toggle_status("entity_hitboxes", false));
    // rust: assert_eq!(e.status("entity_hitboxes"), Status::AlwaysOn);
    // rust: assert!(!e.toggle_status("entity_hitboxes", false));
    // rust: assert_eq!(e.status("entity_hitboxes"), Status::Never);
        // With F3 open, a hidden entry goes in the overlay only.
    // rust: assert!(e.toggle_status("chunk_borders", true));
    // rust: assert_eq!(e.status("chunk_borders"), Status::AlwaysOn);
    // rust: assert!(!e.toggle_status("chunk_borders", true));
    // rust: assert_eq!(e.status("chunk_borders"), Status::Never);
    // rust: assert!(e.toggle_status("chunk_borders", true));
    // rust: assert_eq!(e.status("chunk_borders"), Status::InOverlay);
    // rust: assert!(!e.toggle_status("chunk_borders", true));
    // rust: assert!(!e.is_using_profile(Profile::Default));
}

enabled_needs_the_overlay_and_full_debug_info :: proc() {
}
    // rust: let mut e = DebugEntries::default();
    // rust: assert!(!e.any_enabled(false, false));
    // rust: assert!(e.enabled("player_position", true, false));
        // Reduced debug info hides the position, not the section.
    // rust: assert!(!e.enabled("player_position", true, true));
    // rust: assert!(e.enabled("player_section_position", true, true));
    // rust: e.load_profile(Profile::Performance);
    // rust: assert!(e.enabled("fps", false, false));
    // rust: assert!(!e.enabled("memory", false, false));
}

the_file_keeps_a_profile_or_the_statuses :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-debug-profile-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let mut e = DebugEntries::load(&dir);
    // rust: assert!(e.is_using_profile(Profile::Default));
    // rust: e.load_profile(Profile::Performance);
    // rust: let saved: serde_json::Value =
    // rust: serde_json::from_str(&std::fs::read_to_string(dir.join("debug-profile.json")).unwrap())
    // rust: .unwrap();
    // rust: assert_eq!(saved["profile"], "performance");
    // rust: assert!(DebugEntries::load(&dir).is_using_profile(Profile::Performance));
    // rust: e.set_status("biome", Status::AlwaysOn);
    // rust: let loaded = DebugEntries::load(&dir);
    // rust: assert_eq!(loaded.status("biome"), Status::AlwaysOn);
    // rust: assert_eq!(loaded.status("fps"), Status::AlwaysOn);
    // rust: assert!(!loaded.is_using_profile(Profile::Performance));
        // A broken file is reset to the default profile.
    // rust: std::fs::write(dir.join("debug-profile.json"), "{\"profile\":\"nope\"}").unwrap();
    // rust: assert!(DebugEntries::load(&dir).is_using_profile(Profile::Default));
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

old_files_are_upgraded_by_their_data_version :: proc() {
}
        // No DataVersion: every fix runs.
    // rust: let (_, custom) = DebugEntries::parse(
    // rust: r#"{"custom":{"minecraft:fps":"inF3","minecraft:looking_at_block":"alwaysOn",
    // rust: "minecraft:looking_at_fluid":"inF3","minecraft:looking_at_fluid_state":"never",
    // rust: "minecraft:post_effect":"alwaysOn"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(custom["minecraft:fps"], Status::InOverlay);
    // rust: assert_eq!(custom["minecraft:looking_at_block_state"], Status::AlwaysOn);
    // rust: assert_eq!(custom["minecraft:looking_at_fluid_state"], Status::Never);
    // rust: assert_eq!(custom["minecraft:post_effects"], Status::AlwaysOn);
    // rust: assert!(!custom.contains_key("minecraft:looking_at_block"));
    // rust: assert!(!custom.contains_key("minecraft:post_effect"));
        // From 4763 on, only the post effects rename is left.
    // rust: let (_, custom) = DebugEntries::parse(
    // rust: r#"{"DataVersion":4763,"custom":{"minecraft:looking_at_block":"alwaysOn",
    // rust: "minecraft:post_effect":"alwaysOn"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(custom["minecraft:looking_at_block"], Status::AlwaysOn);
    // rust: assert_eq!(custom["minecraft:post_effects"], Status::AlwaysOn);
        // `inF3` is no status any more once the file is past 4650.
    // rust: assert!(DebugEntries::parse(r#"{"DataVersion":4650,"custom":{"fps":"inF3"}}"#).is_none());
}

the_list_sorts_text_before_renderers :: proc() {
}
    // rust: let all = search("");
    // rust: assert_eq!(all.len(), 46);
    // rust: assert_eq!(all[0].path, "biome");
    // rust: let first_renderer = all
    // rust: .iter()
    // rust: .position(|e| e.category == Category::Renderer)
    // rust: .unwrap();
    // rust: assert_eq!(all[first_renderer].path, "3d_crosshair");
    // rust: assert!(
    // rust: all[first_renderer..]
    // rust: .iter()
    // rust: .all(|e| e.category == Category::Renderer)
    // rust: );
    // rust: assert_eq!(search("chunk_b").len(), 1);
}
}
