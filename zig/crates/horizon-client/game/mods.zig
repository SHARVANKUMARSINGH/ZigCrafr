//! Transpiled from Horizon Rust crate
//! Module: horizon-client_mods
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mods in the game (`docs/mods.md`): content mods' blocks, items, data and
//! assets (`content_root`), and the Mods page's rows. Code mods are native
//! (`native_hooks.rs`); WebAssembly code mods don't run any more.
// use super::Game;
// use horizon_client::{
    // rust: lang,
    // rust: mod_list::{self, Installed},
    // rust: text::Text,
}
// use std::path::PathBuf;

    // rust: pub(super) struct ModsState {
    /// `--dev-mod PATH`: always on.
    // rust: pub(super) dev: Vec<PathBuf>,
    /// The WebAssembly mods found that no longer run, for the one-time notice.
    // rust: stopped: Vec<String>,
    /// Browse mods' worker (`mod_browser`).
    // rust: pub(super) jobs: super::mod_browser::Jobs,
    /// The content mods the loaded resources were built with: a switch the
    /// game can apply live moves it to the player's choice (`switch_mods`).
    // rust: pub(super) applied: Option<std::collections::BTreeSet<String>>,
    /// A live switch's resource reload is running: when it applied, the server
    /// reloads its data from the new root. Its start, for the log.
    // rust: pub(super) live: Option<std::time::Instant>,
    /// The content mods installed, and those of them with only assets and
    /// data (`mod_content::live_switch`): they switch with a world open.
    // rust: content_ids: std::collections::BTreeSet<String>,
    // rust: live_ids: std::collections::BTreeSet<String>,
    /// The server's data comes from a root a live switch built, not the one
    /// `res` was loaded from: the world tables are built from it even with no
    /// data pack (`build_world_tables`).
    // rust: pub(super) data_switched: bool,
}

/// Freeze native component IDs before reading content or opening a connection.
/// With no mod registering any, nothing is installed, which every reader
/// treats as no custom components, and `registries.json` isn't read.
    // rust: pub(super) fn register_components(root: &std::path::Path) -> horizon_client::Result<()> {
    // rust: let mut names = Vec::new();
    // rust: Game::native_component_types(&mut names);
    // rust: if names.is_empty() {
    // rust: return Ok(());
}
    // rust: let path =
    // rust: horizon_protocol::registry::Builtin::find(root).ok_or("registries.json not found")?;
    // rust: let builtin = horizon_protocol::registry::Builtin::load(&path)?;
    // rust: let types = builtin
    // rust: .get("minecraft:data_component_type")
    // rust: .ok_or("missing data component registry")?;
    // rust: let first = i32::try_from(types.names.len())?;
    // rust: horizon_protocol::item::custom::install(first, names)
    // rust: .map_err(|error| format!("invalid native component registration: {error}"))?;
    // rust: Ok(())
}

/// The blocks and items native mods declare in code (`native_blocks`,
/// `native_items`): asked once, so every content root of this run, a pack
/// reload's included, has the same ones.
pub fn native_declared() *;
    // rust: Vec<horizon_mods::content::Block>,
    // rust: Vec<horizon_mods::content::Item>,
    // rust: ) {
    // rust: static DECLARED: std::sync::OnceLock<(
    // rust: Vec<horizon_mods::content::Block>,
    // rust: Vec<horizon_mods::content::Item>,
    // rust: )> = std::sync::OnceLock::new();
    // rust: DECLARED.get_or_init(|| {
    // rust: let (mut blocks, mut items) = (Vec::new(), Vec::new());
    // rust: Game::native_blocks(&mut blocks);
    // rust: Game::native_items(&mut items);
    // rust: (blocks, items)
    // rust: })
}
/// The native mods' standalone models (`native_standalone_models`), set once
/// before the resources first load.
    // rust: pub(super) fn register_standalone_models() {
    // rust: let mut names = Vec::new();
    // rust: Game::native_standalone_models(&mut names);
    // rust: horizon_client::models::register_standalone(names);
}
/// The native mods' entity model layers (`native_layer_definitions`), kept
/// once at start for `native_bake_layer`.
    // rust: pub(super) fn register_layer_definitions() {
    // rust: let mut layers = Vec::new();
    // rust: Game::native_layer_definitions(&mut layers);
    // rust: horizon_client::mobs::model_layers::register(layers);
}

/// `root` with the content mods that are on layered over it
/// (docs/modpacks.md): their blocks, items, data and assets. Read once at
/// start, before the resources load; a mod whose content is refused is left
/// out here and its row on the Mods page says why.
    // rust: pub(super) fn content_root(
    // rust: root: &std::path::Path,
    // rust: enabled: &std::collections::BTreeSet<String>,
    // rust: dev: &[std::path::PathBuf],
    // rust: ) -> std::path::PathBuf {
//     use horizon_client::mod_content::{self, ContentMod};
//     use horizon_mods::{Capability, Content, Package};
    // rust: let here = std::env::current_dir().unwrap_or_default();
    // rust: let mut paths = horizon_mods::find(&here.join(mod_list::DIR));
    // rust: paths.retain(|p| !dev.contains(p));
    // rust: paths.extend(dev.iter().cloned());
    // rust: let mut known = None;
    // rust: let mut mods: Vec<ContentMod> = Vec::new();
    // The first load's list stays (`set_local`): a reload does not hash the files again.
    // rust: let announce = !horizon_protocol::mod_list::is_set();
    // rust: let mut announced = Vec::new();
    // rust: for path in &paths {
    // rust: let Ok(package) = Package::read(path) else {
    // rust: continue;
}
    // rust: let m = &package.manifest;
    // rust: let on = enabled.contains(&m.id) || dev.contains(path);
    // rust: if !on
    // rust: || !m.capabilities.contains(&Capability::Registries)
    // rust: || mods.iter().any(|c| c.id == m.id)
    // rust: {
    // rust: continue;
}
        // The items this mod's native code declares may be a file item's crafting remainder.
    // rust: let declared: Vec<String> = native_declared()
    // rust: .1
    // rust: .iter()
    // rust: .filter(|i| i.id.split_once(':').is_some_and(|(ns, _)| ns == m.id))
    // rust: .map(|i| i.id.clone())
    // rust: .collect();
    // rust: let content = match Content::read_declaring(path, m, &declared) {
    // rust: Ok(content) => content,
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: mod {} content not loaded: {e}", m.id);
    // rust: continue;
}
}
    // rust: let known = match &mut known {
    // rust: Some(types) => types,
    // rust: None => match mod_content::known_components(root) {
    // rust: Ok(types) => known.insert(types),
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: content mods not loaded: {e}");
    // rust: register_mob_effects(&[]);
    // rust: return root.to_owned();
}
    // rust: },
}
    // rust: let candidate = ContentMod {
    // rust: id: m.id.clone(),
    // rust: content,
}
    // rust: match mod_content::accept_mod(&mut mods, candidate, known) {
    // rust: Ok(_) if announce => announced.push(announced_entry(m, path)),
    // rust: Ok(_) => {}
    // rust: Err(e) => log::warn!("Horizon: mod {} content not loaded: {e}", m.id),
}
}
    // rust: let (blocks, items) = native_declared();
    // rust: if !blocks.is_empty() || !items.is_empty() {
    // rust: if known.is_none() {
    // rust: match mod_content::known_components(root) {
    // rust: Ok(types) => known = Some(types),
    // rust: Err(e) => log::warn!("Horizon: native mods' blocks and items not loaded: {e}"),
}
}
    // rust: if let Some(known) = &known {
    // rust: for e in mod_content::accept_declared(&mut mods, blocks, items, known) {
    // rust: log::warn!("Horizon: {e}");
}
            // A file item's remainder named a code-declared item that was refused: that mod
            // alone is left out, not every content mod through the overlay's check.
    // rust: for e in mod_content::drop_dangling_remainders(&mut mods) {
    // rust: log::warn!("Horizon: {e}");
}
}
}
    // rust: match mod_content::resource_root(root, &mods, &here.join(".horizon-cache")) {
    // rust: Ok(out) => {
    // rust: if announce {
    // rust: horizon_protocol::mod_list::set_local(announced);
}
    // rust: if out != root {
    // rust: log::info!(
    // rust: "Horizon: content from {} mod(s) in {}",
    // rust: mods.len(),
    // rust: out.display()
    // rust: );
}
    // rust: register_mob_effects(&mods);
    // rust: register_entity_types(&mods);
    // rust: register_menu_types(&mods);
    // rust: out
}
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: content mods not loaded: {e}");
    // rust: register_mob_effects(&[]);
    // rust: register_entity_types(&[]);
    // rust: register_menu_types(&[]);
    // rust: root.to_owned()
}
}
}

/// A loaded mod as a server tells joining clients (`horizon_protocol::mod_list`): its manifest's
/// id, version and side, and the SHA-256 of its `.hmod` (none for a folder).
    // rust: fn announced_entry(
    // rust: m: &horizon_mods::Manifest,
    // rust: path: &std::path::Path,
    // rust: ) -> horizon_protocol::mod_list::Entry {
//     use horizon_mods::Side;
//     use horizon_protocol::mod_list;
//     use sha2::{Digest, Sha256};
    // rust: let sha256 = if path.is_file() {
    // rust: std::fs::read(path)
    // rust: .ok()
    // rust: .map(|bytes| Sha256::digest(bytes).into())
    // rust: } else {
    // rust: None
}
    // rust: mod_list::Entry {
    // rust: id: m.id.clone(),
    // rust: version: m.version.clone(),
    // rust: sha256,
    // rust: side: match m.side {
    // rust: Side::Both => mod_list::Side::Both,
    // rust: Side::Server => mod_list::Side::Server,
    // rust: Side::Client => mod_list::Side::Client,
    // rust: },
}
}

/// The mods' mob effects join vanilla's (`brewing::effect`), once the root
/// holding their network ids is built. The startup root's effects, none
/// included, stay until restart: a pack reload after a Mods switch builds a
/// root with others.
pub fn register_mob_effects(mods: *[horizon_client::mod_content::ContentMod]) void {
}
//     use horizon_client::brewing::{self, Category};
//     use horizon_mods::content::EffectCategory;
    // rust: let effects = horizon_client::mod_content::mob_effects(mods);
    // rust: let ids: Vec<String> = effects.iter().map(|e| e.id.clone()).collect();
    // rust: let set = brewing::register_mod_effects(effects.into_iter().map(|e| {
    // rust: let category = match e.category {
    // rust: EffectCategory::Beneficial => Category::Beneficial,
    // rust: EffectCategory::Harmful => Category::Harmful,
    // rust: EffectCategory::Neutral => Category::Neutral,
}
    // rust: (e.id.clone(), e.color, category)
    // rust: }));
    // rust: if !set
    // rust: && brewing::mod_effects()
    // rust: .iter()
    // rust: .map(|e| e.id)
    // rust: .ne(ids.iter().map(String::as_str))
    // rust: {
    // rust: log::warn!("Horizon: the mods' mob effects changed; restart the game to use them");
}
}

/// the mods' thrown entity types, as their mob effects: set once, from the
/// startup root. Living types are mobs, loaded with vanilla's from the
/// content root's `entity-types.json`.
pub fn register_entity_types(mods: *[horizon_client::mod_content::ContentMod]) void {
}
//     use horizon_client::projectiles;
    // rust: let mut types = horizon_client::mod_content::entity_types(mods);
    // rust: types.retain(|t| t.item.is_some());
    // rust: let set = projectiles::register_thrown_types(
    // rust: types
    // rust: .iter()
    // rust: .filter_map(|t| Some((t.id.clone(), t.item.clone()?, t.damage))),
    // rust: );
    // rust: if !set
    // rust: && projectiles::thrown_types()
    // rust: .iter()
    // rust: .map(|t| t.id)
    // rust: .ne(types.iter().map(|t| t.id.as_str()))
    // rust: {
    // rust: log::warn!("Horizon: the mods' entity types changed; restart the game to use them");
}
}

/// the mods' menu types, as their entity types: set once, from the startup
/// root.
pub fn register_menu_types(mods: *[horizon_client::mod_content::ContentMod]) void {
}
//     use horizon_client::containers;
    // rust: let menus = horizon_client::mod_content::menu_types(mods);
    // rust: let set = containers::register_mod_menu_types(menus.iter().map(|m| {
    // rust: let results = m.results.iter().map(|&r| usize::from(r)).collect();
    // rust: (m.id.clone(), m.slots.into(), m.data_slots.into(), results)
    // rust: }));
    // rust: if !set
    // rust: && containers::mod_menu_types()
    // rust: .iter()
    // rust: .map(|m| m.id)
    // rust: .ne(menus.iter().map(|m| m.id.as_str()))
    // rust: {
    // rust: log::warn!("Horizon: the mods' menu types changed; restart the game to use them");
}
}

/// What the launcher writes beside a game it built with native mods: their ids under `mods`.
pub const BUILD_INFO: []const u8 = "native-mods.json";

/// `native-mods.json`'s `mods` list is not empty: the game was built with mods.
pub fn build_lists_mods(built: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: serde_json::from_str::<serde_json::Value>(built)
    // rust: .ok()
    // rust: .and_then(|info| info["mods"].as_array().map(|mods| !mods.is_empty()))
    // rust: .unwrap_or(false)
}

/// Whether the game playing was built with native mods: the launcher writes their ids into
/// [`BUILD_INFO`] beside the executable, and a release or Nightly has no such file.
    // rust: pub(super) fn built_with_native_mods() -> bool {
    // rust: std::env::current_exe()
    // rust: .ok()
    // rust: .and_then(|exe| std::fs::read_to_string(exe.with_file_name(BUILD_INFO)).ok())
    // rust: .is_some_and(|built| build_lists_mods(&built))
}

/// The native mods the launcher built this game with, `id version, id version`, for the crash
/// report (`built`: its [`BUILD_INFO`]). None for a release or Nightly, which have no mods.
pub fn native_mods_detail(built: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let info: serde_json::Value = serde_json::from_str(built).unwrap_or_default();
    // rust: let list = info["mods"]
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(|m| {
    // rust: let text = |key: &str| m[key].as_str().unwrap_or("?").to_owned();
    // rust: format!("{} {}", text("id"), text("version"))
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ");
    // rust: (!list.is_empty()).then_some(list)
}

/// Notes a content mod's id, and whether its files can switch with a world
/// open (`mod_content::live_switch`).
    // rust: fn live_switch_of(
    // rust: path: &std::path::Path,
    // rust: package: &horizon_mods::Package,
    // rust: content_ids: &mut std::collections::BTreeSet<String>,
    // rust: live_ids: &mut std::collections::BTreeSet<String>,
    // rust: ) {
    // rust: let id = &package.manifest.id;
    // rust: content_ids.insert(id.clone());
    // rust: let content = horizon_mods::Content::read(path, &package.manifest);
    // rust: match content
    // rust: .as_ref()
    // rust: .map(horizon_client::mod_content::live_switch)
    // rust: {
    // rust: Ok(Ok(())) if package.wasm.is_none() => {
    // rust: live_ids.insert(id.clone());
}
    // rust: Ok(Err(why)) => log::debug!("Horizon: mod {id} switches on a restart: {why}"),
    // rust: _ => {}
}
}

/// A row for each native mod the launcher installed in `dir` (`<id>.hnmod`) that this game wasn't
/// built with (`built`: its [`BUILD_INFO`], empty for a release or Nightly) and that has no row
/// yet. The page said "No mods" before, and players copied the files into `horizon-mods` (#4770).
/// Its toggle is the `mod.<id>` line the launcher's next build follows.
pub fn not_built(dir: *std::path::Path, built: []const u8, rows: *[Installed]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let info: serde_json::Value = serde_json::from_str(built).unwrap_or_default();
    // rust: let in_build = |id: &str| {
    // rust: info["mods"]
    // rust: .as_array()
    // rust: .is_some_and(|mods| mods.iter().any(|m| m["id"] == id))
}
    // rust: let mut paths: Vec<PathBuf> = std::fs::read_dir(dir)
    // rust: .map(|d| d.flatten().map(|e| e.path()).collect())
    // rust: .unwrap_or_default();
    // rust: paths.retain(|p| p.extension().is_some_and(|e| e == "hnmod"));
    // rust: paths.sort();
    // rust: let mut out: Vec<Installed> = Vec::new();
    // rust: for path in paths {
    // rust: let Ok(bundle) = horizon_mods::index::native::Bundle::read(&path) else {
    // rust: continue;
}
    // rust: let m = bundle.manifest;
    // rust: let listed = rows.iter().chain(&out).any(|row| row.id == m.id);
    // rust: if !listed && !in_build(&m.id) {
    // rust: out.push(Installed {
    // rust: title: format!("{} {}", m.id, m.version),
    // rust: id: m.id,
    // rust: description: String::new(),
    // rust: problem: Some(mod_list::NOT_BUILT.to_owned()),
    // rust: dev: false,
    // rust: native: None,
    // rust: });
}
}
    // rust: out
}

/// A WebAssembly code mod's row on the Mods page.
pub const STOPPED: []const u8 = "Doesn't run any more: needs a native port";
/// The player was told once about the WebAssembly mods that stopped (`horizon-mods/<this>`).
pub const NOTICE_SEEN: []const u8 = ".native-notice";

    // rust: impl Game<'_> {
    /// Lists the installed mods on the Mods page. Content mods load with the resources
    /// (`content_root`); native ones are built into the game (`native_hooks.rs`). WebAssembly code
    /// mods don't run any more: their rows say so, and the player hears it once in the chat
    /// (`tell_native_now`).
    // rust: pub(super) fn start_mods(&mut self) {
    // rust: let dir = Self::game_dir().join(mod_list::DIR);
    // rust: let mut paths = horizon_mods::find(&dir);
    // rust: paths.retain(|p| !self.mods.dev.contains(p));
    // rust: paths.extend(self.mods.dev.iter().cloned());
    // rust: let (mut content_ids, mut live_ids) = Default::default();
    // rust: self.settings.mods.installed = paths
    // rust: .iter()
    // rust: .map(|path| {
    // rust: let file = path.file_name().unwrap_or_default().to_string_lossy();
    // rust: let package = match horizon_mods::Package::read(path) {
    // rust: Ok(package) => package,
    // rust: Err(e) => {
    // rust: return Installed {
    // rust: id: String::new(),
    // rust: title: file.into_owned(),
    // rust: description: String::new(),
    // rust: problem: Some(format!("Can't be read: {e}")),
    // rust: dev: false,
    // rust: native: None,
}
}
}
    // rust: let m = &package.manifest;
    // rust: let problem = package.wasm.is_some().then(|| STOPPED.to_owned());
    // rust: live_switch_of(path, &package, &mut content_ids, &mut live_ids);
    // rust: Installed {
    // rust: id: m.id.clone(),
    // rust: title: format!("{} {}", m.name, m.version),
    // rust: description: m.description.clone(),
    // rust: problem,
    // rust: dev: self.mods.dev.contains(path),
    // rust: native: None,
}
    // rust: })
    // rust: .collect();
    // rust: (self.mods.content_ids, self.mods.live_ids) = (content_ids, live_ids);
    // rust: self.ui.options.mods_live = self.mods_live_now();
    // rust: if self.mods.applied.is_none() {
    // rust: self.mods.applied = Some(self.settings.mods.enabled.clone());
}
        // A mod with a native version built in says so instead, and isn't news.
    // rust: self.list_native_mods();
    // rust: self.sync_native_switches();
    // rust: let built = std::env::current_exe()
    // rust: .ok()
    // rust: .and_then(|exe| std::fs::read_to_string(exe.with_file_name(BUILD_INFO)).ok())
    // rust: .unwrap_or_default();
    // rust: let built_mods = native_mods_detail(&built);
    // rust: let built_with_mods = built_mods.is_some();
    // rust: if let Some(list) = built_mods {
    // rust: horizon_client::crash::set_detail("Native Mods", list);
}
    // rust: horizon_client::gfx::native_render::set_mods_built_in(
    // rust: built_with_mods
    // rust: || self
    // rust: .settings
    // rust: .mods
    // rust: .installed
    // rust: .iter()
    // rust: .any(|m| m.native.is_some()),
    // rust: );
    // rust: let native_dir = Self::game_dir().join(mod_list::NATIVE_DIR);
    // rust: let unbuilt = not_built(&native_dir, &built, &self.settings.mods.installed);
    // rust: self.settings.mods.installed.extend(unbuilt);
    // rust: let installed = &self.settings.mods.installed;
    // rust: self.mods.stopped = installed
    // rust: .iter()
    // rust: .filter(|row| row.problem.as_deref() == Some(STOPPED))
    // rust: .map(|row| row.title.clone())
    // rust: .collect();
}
    /// The content mods the Mods page lets the player switch with a world
    /// open: in single player and on an open LAN world, those with only
    /// assets and data; none on another server, which owns its data.
    // rust: pub(super) fn mods_live_now(&self) -> std::collections::BTreeSet<String> {
    // rust: match self.integrated.is_some() || self.remote.is_none() {
    // rust: true => self.mods.live_ids.clone(),
    // rust: false => Default::default(),
}
}
    /// The content mods the resources load with: the ones applied, which a
    /// switch that needs a restart doesn't change.
    // rust: pub(super) fn applied_mods(&self) -> std::collections::BTreeSet<String> {
    // rust: self.mods
    // rust: .applied
    // rust: .clone()
    // rust: .unwrap_or_else(|| self.settings.mods.enabled.clone())
}
    /// The player turned content mods on or off (Options > Mods, or an
    /// install from Browse Mods): those with only assets and data apply now
    /// (docs/design/mod-hotload.md), through the resource reload and then the
    /// server's data reload (`mods_reloaded`); those that add blocks, items or
    /// worldgen wait for a restart, and the Mods page says so.
    // rust: pub(super) fn switch_mods(&mut self) {
    // rust: let Some(applied) = self.mods.applied.clone() else {
    // rust: return;
}
    // rust: let wanted = self.settings.mods.enabled.clone();
    // rust: if applied == wanted {
    // rust: return;
}
        // Native mods' `mod.<id>` lines follow the player's choice as they are
        // (`sync_native_switches`); a content mod with blocks, items or
        // worldgen keeps the state it loaded with until a restart.
    // rust: let content = &self.mods.content_ids;
    // rust: let mut next = wanted.clone();
    // rust: let mut waiting = Vec::new();
    // rust: for id in applied.symmetric_difference(&wanted) {
    // rust: if !content.contains(id) || self.mods.live_ids.contains(id) {
    // rust: continue;
}
    // rust: log::info!("Horizon: mod {id} needs a restart to switch");
    // rust: waiting.push(id.clone());
    // rust: if applied.contains(id) {
    // rust: next.insert(id.clone());
    // rust: } else {
    // rust: next.remove(id);
}
}
    // rust: self.ui.options.mods_note = (!waiting.is_empty())
    // rust: .then(|| lang::tr("horizon.mods.switch.restart", &[&waiting.join(", ")]));
    // rust: let changed = applied
    // rust: .symmetric_difference(&next)
    // rust: .any(|id| content.contains(id));
    // rust: if !changed {
    // rust: self.mods.applied = Some(next);
    // rust: return;
}
    // rust: log::info!(
    // rust: "Horizon: content mods switched live: {:?} -> {:?}",
    // rust: applied,
    // rust: next
    // rust: );
    // rust: self.mods.applied = Some(next);
    // rust: self.mods.live = Some(std::time::Instant::now());
    // rust: self.reload_packs();
}
    /// A live switch's resources applied: the server reloads its data packs
    /// from the new root, as `/reload` does (recipes, tags, loot tables,
    /// advancements, functions), and sends them to its players.
    // rust: pub(super) fn mods_reloaded(&mut self, applied: bool) {
    // rust: let Some(started) = self.mods.live.take() else {
    // rust: return;
}
    // rust: let resources_ms = started.elapsed().as_millis();
    // rust: if !applied {
    // rust: return;
}
    // rust: let root = self.options.resources.clone();
    // rust: let enabled = self.applied_mods();
    // rust: let reload = move |g: &mut Game<'_>| {
    // rust: let at = std::time::Instant::now();
    // rust: g.options.resources = root;
    // rust: g.settings.mods.enabled = enabled.clone();
    // rust: g.mods.applied = Some(enabled);
    // rust: g.mods.data_switched = true;
    // rust: if g.world_root.as_os_str().is_empty() {
    // rust: return;
}
    // rust: g.reload_datapacks(true);
    // rust: log::info!(
    // rust: "Horizon: content mods switched live: server data reloaded in {} ms",
    // rust: at.elapsed().as_millis()
    // rust: );
}
    // rust: log::info!("Horizon: content mods switched live: resources reloaded in {resources_ms} ms");
    // rust: if let Some(server) = &self.integrated {
    // rust: server.post(reload);
    // rust: } else if self.remote.is_none() {
    // rust: reload(self);
}
}
    /// Trait mods follow the player's switches at once
    /// (`mod_api::set_mod_on`): the next dispatch skips a mod turned off.
    /// Mixin code checks `native_on` itself.
    // rust: pub(super) fn sync_native_switches(&self) {
    // rust: for id in horizon_client::mod_api::mod_ids() {
    // rust: let on = !self.settings.mods.disabled.contains(*id);
    // rust: horizon_client::mod_api::set_mod_on(id, on);
}
}
    /// Once, in the first world after the update: which WebAssembly mods stopped.
    // rust: pub(super) fn tell_native_now(&mut self) {
    // rust: if self.mods.stopped.is_empty() || self.player.is_none() {
    // rust: return;
}
    // rust: let names = std::mem::take(&mut self.mods.stopped).join(", ");
    // rust: let seen = Self::game_dir().join(mod_list::DIR).join(NOTICE_SEEN);
    // rust: if seen.exists() {
    // rust: return;
}
    // rust: self.system_message(Text::literal(format!(
    // rust: "Horizon mods are native now: {names} stopped running until they have a native version. The launcher's Mods page has the native ones."
    // rust: )));
    // rust: let _ = std::fs::write(&seen, "");
}
}

/// Mob types loaded from a scratch root whose `entity-types.json` has a
/// zombie, a villager, and the rows a content root writes for a mod's types
/// (`mod_content`): `ruby:ghoul` (a zombie with 40 health), `ruby:settler` (a
/// villager as it is) and `ruby:bolt` (a thrown snowball, not a mob).
    // rust: pub(super) fn living_mod_types()
    // rust: -> std::collections::HashMap<String, std::sync::Arc<horizon_client::mobs::MobType>> {
    // rust: let zombie =
    // rust: r#""width":0.6,"height":1.95,"eye_height":1.74,"category":"monster","fire_immune":false"#;
    // rust: let villager =
    // rust: r#""width":0.6,"height":1.95,"eye_height":1.62,"category":"misc","fire_immune":false"#;
    // rust: let trader =
    // rust: r#""width":0.6,"height":1.95,"eye_height":1.62,"category":"creature","fire_immune":false"#;
    // rust: let table = format!(
    // rust: r#"{{"minecraft:zombie":{{{zombie},"attributes":{{"minecraft:max_health":20.0,"minecraft:movement_speed":0.23000000417232513}}}},
    // rust: "minecraft:villager":{{{villager},"attributes":{{"minecraft:max_health":20.0,"minecraft:movement_speed":0.5}}}},
    // rust: "minecraft:wandering_trader":{{{trader},"attributes":{{"minecraft:max_health":20.0,"minecraft:movement_speed":0.7}}}},
    // rust: "minecraft:snowball":{{"width":0.25,"height":0.25,"eye_height":0.0,"category":"misc","fire_immune":false}},
    // rust: "ruby:ghoul":{{{zombie},"attributes":{{"minecraft:max_health":40.0,"minecraft:movement_speed":0.23000000417232513}},"template":"minecraft:zombie"}},
    // rust: "ruby:settler":{{{villager},"attributes":{{"minecraft:max_health":20.0,"minecraft:movement_speed":0.5}},"template":"minecraft:villager"}},
    // rust: "ruby:merchant":{{{trader},"attributes":{{"minecraft:max_health":20.0,"minecraft:movement_speed":0.7}},"template":"minecraft:wandering_trader"}},
    // rust: "ruby:bolt":{{"width":0.25,"height":0.25,"eye_height":0.0,"category":"misc","fire_immune":false,"template":"minecraft:snowball"}}}}"#
    // rust: );
    // A folder per call: tests run in parallel in one process, and each removes its own.
pub const CALLS: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(0);
    // rust: let call = CALLS.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-living-mod-types-{}-{call}",
    // rust: std::process::id()
    // rust: ));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: std::fs::write(root.join("entity-types.json"), table).unwrap();
    // rust: let types = horizon_client::mobs::MobTypes::load_for_server(&root).unwrap();
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: types
    // rust: .types
    // rust: .into_iter()
    // rust: .map(|(id, t)| (id, std::sync::Arc::new(t)))
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;
//     use std::io::Write;

    /// A content mod's living type is a mob of its template's species under
    /// its own id, with its own attributes: it saves its id with every field
    /// its template's class saves, loads back as itself, and rolls its own
    /// loot table. A thrown type stays a projectile.
pub fn a_mod_living_type_is_its_templates_mob_with_its_own_attributes() void {
}
//         use horizon_client::mobs::{Mob, Species, drops::death_loot_table};
//         use horizon_core::geometry::Vec3;
    // rust: let types = living_mod_types();
    // rust: let (zombie, ghoul) = (&types["minecraft:zombie"], &types["ruby:ghoul"]);
    // rust: assert_eq!(ghoul.species, Species::Zombie);
    // rust: assert_eq!(ghoul.class_id(), "minecraft:zombie");
    // rust: assert_eq!(types["ruby:settler"].species, Species::Villager);
    // rust: assert!(!types.contains_key("ruby:bolt"), "a thrown type is no mob");
    // rust: assert_eq!((zombie.max_health, ghoul.max_health), (20.0, 40.0));
    // rust: assert_eq!(ghoul.speed.to_bits(), zombie.speed.to_bits());
    // rust: assert_eq!(
    // rust: (ghoul.sounds, ghoul.texture.as_str()),
    // rust: (zombie.sounds, zombie.texture.as_str())
    // rust: );

    // rust: let at = Vec3::new(0.5, 64.0, 0.5);
    // rust: let (zombie, ghoul) = (
    // rust: Mob::new(1, zombie.clone(), at, 0.0),
    // rust: Mob::new(2, ghoul.clone(), at, 0.0),
    // rust: );
    // rust: assert_eq!(ghoul.health, 40.0);
    // rust: let saved = |m: &Mob| horizon_client::entity_nbt::mob_to_nbt(m, [0, 0, 0, 2], None, None);
    // rust: let keys = |tag: &horizon_world::nbt::Tag| -> Vec<String> {
    // rust: let horizon_world::nbt::Tag::Compound(map) = tag else {
    // rust: panic!("a mob saves a compound");
}
    // rust: map.keys().map(|k| k.to_string_lossy()).collect()
}
    // rust: let (zombie_tag, ghoul_tag) = (saved(&zombie), saved(&ghoul));
    // rust: let Some(horizon_world::nbt::Tag::String(id)) = ghoul_tag.get("id") else {
    // rust: panic!("a saved mob has its id");
}
    // rust: assert_eq!(id.to_string_lossy(), "ruby:ghoul");
    // rust: assert_eq!(
    // rust: keys(&ghoul_tag),
    // rust: keys(&zombie_tag),
    // rust: "it saves what a zombie saves"
    // rust: );
    // rust: for key in ["IsBaby", "CanBreakDoors", "DrownedConversionTime"] {
    // rust: assert!(keys(&ghoul_tag).iter().any(|k| k == key), "{key}");
}
    // rust: let loaded = horizon_client::entity_nbt::mob_from_nbt(&ghoul_tag, &types, 3, None)
    // rust: .expect("it loads back");
    // rust: assert_eq!(
    // rust: (loaded.kind.id.as_str(), loaded.health),
    // rust: ("ruby:ghoul", 40.0)
    // rust: );
    // rust: assert_eq!(
    // rust: death_loot_table(&ghoul, true).as_deref(),
    // rust: Some("ruby:entities/ghoul")
    // rust: );
    // rust: assert_eq!(
    // rust: death_loot_table(&zombie, true).as_deref(),
    // rust: Some("minecraft:entities/zombie")
    // rust: );
}

    /// A content mod's type from the wandering trader, the neutral template
    /// whose behaviour is all goals: a trader under its own id, with a
    /// trader's goals, that saves what a trader saves and loads back.
pub fn a_mod_trader_type_is_a_wandering_trader_under_its_own_id() void {
}
//         use horizon_client::mobs::{Mob, Species};
//         use horizon_world::nbt::Tag;
    // rust: let types = living_mod_types();
    // rust: let merchant = &types["ruby:merchant"];
    // rust: assert_eq!(merchant.species, Species::WanderingTrader);
    // rust: assert_eq!(merchant.class_id(), "minecraft:wandering_trader");
    // rust: let at = horizon_core::geometry::Vec3::new(0.5, 64.0, 0.5);
    // rust: let trader = Mob::new(1, types["minecraft:wandering_trader"].clone(), at, 0.0);
    // rust: let merchant = Mob::new(2, merchant.clone(), at, 0.0);
    // rust: assert!(merchant.ai.goals.has("Float") && trader.ai.goals.has("Float"));
    // rust: let saved = |m: &Mob| horizon_client::entity_nbt::mob_to_nbt(m, [0, 0, 0, 2], None, None);
    // rust: let keys = |tag: &Tag| -> Vec<String> {
    // rust: let Tag::Compound(map) = tag else {
    // rust: panic!("a mob saves a compound");
}
    // rust: map.keys().map(|k| k.to_string_lossy()).collect()
}
    // rust: let tag = saved(&merchant);
    // rust: assert_eq!(
    // rust: keys(&tag),
    // rust: keys(&saved(&trader)),
    // rust: "it saves what a trader saves"
    // rust: );
    // rust: let loaded =
    // rust: horizon_client::entity_nbt::mob_from_nbt(&tag, &types, 3, None).expect("it loads back");
    // rust: assert_eq!(
    // rust: (loaded.kind.id.as_str(), loaded.species()),
    // rust: ("ruby:merchant", Species::WanderingTrader)
    // rust: );
}

    /// Only a build whose `native-mods.json` lists a mod counts as built with mods.
pub fn only_a_listed_mod_makes_a_build_a_mod_build() void {
}
    // rust: assert!(!build_lists_mods(""));
    // rust: assert!(!build_lists_mods("{}"));
    // rust: assert!(!build_lists_mods(r#"{"mods":[]}"#));
    // rust: assert!(!build_lists_mods(r#"{"mods":"worldmap"}"#));
    // rust: assert!(build_lists_mods(r#"{"mods":[{"id":"worldmap"}]}"#));
}

    /// A minimal `.hnmod` the registry accepts: its manifest and its mixin's.
pub fn hnmod(dir: *std::path::Path, id: []const u8) void {
}
    // rust: let horizon = "a".repeat(40);
    // rust: let manifest = serde_json::json!({
    // rust: "schema": 1, "id": id, "version": "0.3.0", "game": "26.3",
    // rust: "horizon": horizon, "mixins": "b".repeat(40),
    // rust: });
    // rust: let mixin = format!(
    // rust: "[mod]\nid = \"{id}\"\nversion = \"0.3.0\"\n[compatibility]\nhorizon_revision = \"{horizon}\"\n"
    // rust: );
    // rust: let file = std::fs::File::create(dir.join(format!("{id}.hnmod"))).unwrap();
    // rust: let mut zip = zip::ZipWriter::new(file);
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: zip.start_file("horizon-native.json", options).unwrap();
    // rust: zip.write_all(manifest.to_string().as_bytes()).unwrap();
    // rust: zip.start_file(format!("mixins/{id}/horizon-mixin.toml"), options)
    // rust: .unwrap();
    // rust: zip.write_all(mixin.as_bytes()).unwrap();
    // rust: zip.finish().unwrap();
}

pub fn the_crash_report_lists_the_builds_native_mods() void {
}
    // rust: let built = r#"{"mods":[{"id":"machine_sample","version":"0.1.0","sha256":null},{"id":"pipes","version":"2.0"}]}"#;
    // rust: assert_eq!(
    // rust: native_mods_detail(built).as_deref(),
    // rust: Some("machine_sample 0.1.0, pipes 2.0")
    // rust: );
        // A release has no file; a build without mods has an empty list.
    // rust: assert_eq!(native_mods_detail(""), None);
    // rust: assert_eq!(native_mods_detail(r#"{"mods":[]}"#), None);
}

pub fn native_mods_installed_but_not_built_get_a_row_saying_so() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-not-built-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: for id in ["veinminer", "zoom", "minimap"] {
    // rust: hnmod(&dir, id);
}
    // rust: std::fs::write(dir.join("notes.txt"), "not a mod").unwrap();
    // rust: std::fs::write(dir.join("broken.hnmod"), "not a zip").unwrap();
        // A release: none is built in; the page lists them, sorted, instead of "No mods".
    // rust: let rows = not_built(&dir, "", &[]);
    // rust: let ids: Vec<&str> = rows.iter().map(|r| r.id.as_str()).collect();
    // rust: assert_eq!(ids, ["minimap", "veinminer", "zoom"]);
    // rust: assert_eq!(rows[1].title, "veinminer 0.3.0");
    // rust: assert_eq!(rows[1].problem.as_deref(), Some(mod_list::NOT_BUILT));
    // rust: assert!(rows.iter().all(|r| r.native.is_none() && !r.dev));
        // A native build with zoom, and minimap's row already listed by its own hook.
    // rust: let built =
    // rust: r#"{"base":"nightly-2026-10-30-1da354b","mods":[{"id":"zoom","version":"0.3.0"}]}"#;
    // rust: let listed = Installed {
    // rust: id: "minimap".into(),
    // rust: ..rows[0].clone()
}
    // rust: let rows = not_built(&dir, built, &[listed]);
    // rust: assert_eq!(rows.len(), 1);
    // rust: assert_eq!(rows[0].id, "veinminer");
        // No folder: no rows.
    // rust: assert!(not_built(&dir.join("missing"), "", &[]).is_empty());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

    /// A trait mod's `register_goals` (`Mob.registerGoals`) gets every new
    /// mob: the goals of its type replace its template's, its `Float` goal
    /// floats the navigation as FloatGoal's constructor does, and the
    /// template's other types keep their goals. The only test here that
    /// installs the client library's hooks.
pub fn a_mods_register_goals_replaces_its_types_goals() void {
}
//         use horizon_client::mobs::{
    // rust: Mob,
    // rust: goals::{self, Cx, Goal},
}
//         use horizon_client::mod_api::{Hooks, RegisterGoalsEvent, dispatch_register_goals};
//         use horizon_client::native_client_hooks::{NativeClientHooks, install};
//         use horizon_core::geometry::Vec3;
        // docs/native-mods.md's example.
pub const ToPost = struct {
    post: [f64,
};
    // rust: impl Goal for ToPost {
pub fn flags(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: goals::MOVE
}
pub fn can_use(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = self.post;
    // rust: let (dx, dy, dz) = (m.position.x - x, m.position.y - y, m.position.z - z);
    // rust: dx * dx + dy * dy + dz * dz > 16.0
}
pub fn can_continue(self: *Self, m: *mut Mob, _: *mut Cx) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !m.ai.nav.is_done()
}
pub fn start(self: *Self, m: *mut Mob, cx: *mut Cx) void {
}
    // rust: m.nav_move_to(cx.w, self.post, 1.0);
}
pub fn box_clone(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Box::new(self.clone())
}
}
pub const Guards = struct {};
    // rust: impl Hooks for Guards {
pub fn register_goals(self: *Self, event: *mut RegisterGoalsEvent<'_>) void {
}
    // rust: if event.mob.kind.id == "ruby:guard" {
    // rust: let ai = &mut event.mob.ai;
    // rust: ai.goals.clear();
    // rust: ai.targets.clear();
    // rust: ai.goals.add(0, goals::Float);
    // rust: ai.goals.add(
    // rust: 1,
    // rust: ToPost {
    // rust: post: [0.5, 64.0, 0.5],
    // rust: },
    // rust: );
}
}
}
    // rust: static MODS: std::sync::LazyLock<Vec<Box<dyn Hooks>>> =
    // rust: std::sync::LazyLock::new(|| vec![Box::new(Guards)]);
    // rust: let installed = install(NativeClientHooks {
    // rust: menu_slot_rules: |_, _, _, _, _| {},
    // rust: living_heal: |_, _, _| {},
    // rust: player_chat: |_, _, _, _, _| {},
    // rust: living_breathe: |_, _, _, _, _| {},
    // rust: living_drown: |_, _, _, _, _, _| {},
    // rust: living_fall: |_, _, _, _, _| {},
    // rust: living_jump: |_, _| {},
    // rust: register_goals: |mob| dispatch_register_goals(&MODS, mob),
    // rust: ingredient: |_, _, _| {},
    // rust: ingredient_test: |_, _, _, _| {},
    // rust: });
    // rust: assert!(installed.is_ok());

    // rust: let types = living_mod_types();
    // rust: let mut guard = (*types["ruby:ghoul"]).clone();
    // rust: guard.id = "ruby:guard".into();
    // rust: let at = Vec3::new(0.5, 64.0, 0.5);
    // rust: let guard = Mob::new(1, std::sync::Arc::new(guard), at, 0.0);
    // rust: let ghoul = Mob::new(2, types["ruby:ghoul"].clone(), at, 0.0);
    // rust: assert!(guard.ai.goals.has("Float") && guard.ai.goals.has("ToPost"));
    // rust: assert!(!guard.ai.goals.has("RandomLookAround"));
    // rust: assert!(!guard.ai.targets.has("NearestTarget"));
    // rust: assert!(guard.ai.nav.can_float);
    // rust: assert!(ghoul.ai.goals.has("RandomLookAround") && !ghoul.ai.goals.has("ToPost"));
    // rust: assert!(ghoul.ai.targets.has("NearestTarget"));
    // rust: assert!(!ghoul.ai.nav.can_float, "a zombie has no FloatGoal");
}
}
