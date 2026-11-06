//! Transpiled from Horizon Rust crate
package horizon_client_packs

import "core:fmt"
import "core:mem"
import "core:math"

// Resource pack selection bound to the game: the pack screen lists, and a
// full resource reload after a change, while playing.
// use super::{
    // rust: Game, PackResources, Resources, UiResources, build_renderer, prepare_renderer_textures,
}
// use horizon_client::{
    // rust: assets::Assets,
    // rust: gfx::PreparedTextures,
    // rust: hud::HudAtlas,
    // rust: lang, pack_browser,
    // rust: pack_screen::{self, Compat, PackInfo, Source as PackSource},
    // rust: packs::{self, Pack, Position},
    // rust: streaming::WorkerContext,
    // rust: text::{Style, Text},
}
// use std::{
    // rust: collections::BTreeSet,
    // rust: path::{Path, PathBuf},
    // rust: sync::Arc,
}

// Where overlay roots are built (beside options.txt).
cache_dir :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: std::env::current_dir()
    // rust: .unwrap_or_default()
    // rust: .join(".horizon-cache/resourcepacks")
}
packs_dir :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: std::env::current_dir()
    // rust: .unwrap_or_default()
    // rust: .join("resourcepacks")
}
    // rust: mod folder;

// `Util.getPlatform().openPath`: the system file manager on the folder.
open_folder :: proc(dir: ^Path) {
}
    // rust: if let Err(e) = folder::command(dir).and_then(|mut command| command.spawn()) {
    // rust: log::warn!("Horizon: could not open {}: {e}", dir.display());
}
}
// `Util.getPlatform().openUri`: the system browser on the link.
open_uri :: proc(uri: string) {
}
    // URLs need Windows' registered protocol handler, not Explorer's path
    // handling. ShellExecute also preserves the URL as one Unicode value,
    // without interpolating its query string into a command interpreter.
    // rust: if let Err(error) = open::that_detached(uri) {
    // rust: log::warn!("Horizon: could not open URI {uri}: {error}");
}
    // rust: open_folder(Path::new(uri));
}
// The resource root to load from, given the vanilla root, the selection and
// a server's packs, which go on top (`Pack.Position.TOP`, fixed).
    // rust: pub fn startup_root(
    // rust: vanilla: &Path,
    // rust: selected: &[String],
    // rust: server: &[Pack],
    // rust: ) -> std::io::Result<PathBuf> {
    // rust: let all = packs::discover(vanilla, &packs_dir());
    // rust: let mut enabled = packs::enabled(&all, selected);
    // rust: enabled.extend_from_slice(server);
    // rust: packs::resource_root(vanilla, &enabled, &cache_dir())
}
info :: proc(p: ^Pack) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let built_in = !p.id.starts_with("file/");
    // rust: PackInfo {
    // rust: id: p.id.clone(),
    // rust: title: p.title.clone(),
    // rust: description: p.raw_description.clone(),
    // rust: description_style: p.description_style.clone(),
    // rust: source: if built_in {
    // rust: PackSource::BuiltIn
    // rust: } else {
    // rust: PackSource::Default
    // rust: },
    // rust: compat: p.compatibility,
    // rust: icon: p.icon_png().as_deref().and_then(pack_screen::load_icon),
    // rust: required: false,
    // rust: position: Position::Top,
    // rust: fixed: false,
}
}
// A pack from `DownloadedPackSource.loadRequestedPacks`: fixed at the top of
// the selected list (`DOWNLOADED_PACK_SELECTION`), labelled as a server pack
// (or a world's own pack when its id is the local-world uuid).
downloaded_info :: proc(p: ^Pack) -> P {
    // Ported from Horizon
    return {}
}
    // `WorldOpenFlows.WORLD_PACK_ID` as hex in `server/{uuid}/…`.
WORLD :: "server/640a6a92b6cb48a0b391831586500359/"
    // rust: let world = p.id.starts_with(WORLD);
    // rust: PackInfo {
    // rust: id: p.id.clone(),
    // rust: title: p.title.clone(),
    // rust: description: p.raw_description.clone(),
    // rust: description_style: p.description_style.clone(),
    // rust: source: if world {
    // rust: PackSource::World
    // rust: } else {
    // rust: PackSource::Server
    // rust: },
    // rust: compat: p.compatibility,
    // rust: icon: p.icon_png().as_deref().and_then(pack_screen::load_icon),
    // rust: required: true,
    // rust: position: Position::Top,
    // rust: fixed: true,
}
}
// The vanilla pack: required, at the bottom (`BuiltInPackSource`), with the
// client JAR's `pack.png` that the prepared resources hold.
vanilla_info :: proc(vanilla: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: PackInfo {
    // rust: id: "vanilla".into(),
    // rust: title: Text::translate("resourcePack.vanilla.name", &[]),
    // rust: description: Text::translate("resourcePack.vanilla.description", &[]),
    // rust: description_style: Style::default(),
    // rust: source: PackSource::BuiltIn,
    // rust: compat: Compat::Compatible,
    // rust: icon: std::fs::read(vanilla.join("pack.png"))
    // rust: .ok()
    // rust: .as_deref()
    // rust: .and_then(pack_screen::load_icon),
    // rust: required: true,
    // rust: position: Position::Bottom,
    // rust: fixed: false,
}
}
// Packs the Resource Packs screen lists: folder and built-in packs, then any
// active downloaded server (or world) packs, then vanilla.
    // rust: pub(super) fn pack_infos(vanilla: &Path, server: &[Pack]) -> Vec<PackInfo> {
    // rust: let mut infos: Vec<PackInfo> = packs::discover(vanilla, &packs_dir())
    // rust: .iter()
    // rust: .map(info)
    // rust: .collect();
    // rust: infos.extend(server.iter().map(downloaded_info));
    // rust: infos.push(vanilla_info(vanilla));
    // rust: infos
}
    // rust: impl Game<'_> {
    // rust: pub(super) fn vanilla_root(&self) -> PathBuf {
    // rust: if self.ui.vanilla_root.as_os_str().is_empty() {
    // rust: self.options.resources.clone()
    // rust: } else {
    // rust: self.ui.vanilla_root.clone()
}
}
    // Whether all active packs preserve vanilla's block models. The server
    // overlay sits above the local selection and must be included too.
    // rust: pub(super) fn model_packs_are_vanilla(&self) -> bool {
    // rust: self.settings.horizon.vanilla_models_with_server_packs(
    // rust: self.settings.resource_packs.iter().map(String::as_str),
    // rust: self.server_packs.active.iter().map(|pack| pack.id.as_str()),
    // rust: )
}
    // The leaf mode that is safe for the current local and server packs.
    // rust: pub(super) fn effective_leaf_culling(&self) -> horizon_client::graphics::LeafCullingMode {
    // rust: self.settings
    // rust: .horizon
    // rust: .leaf_culling_effective_with_server_packs(
    // rust: self.settings.resource_packs.iter().map(String::as_str),
    // rust: self.server_packs.active.iter().map(|pack| pack.id.as_str()),
    // rust: )
}
    // The packs the pack screen offers and the current selection
    // (`PackSelectionScreen` makes its `PackSelectionModel` from them).
    // rust: pub(super) fn refresh_pack_lists(&mut self) {
    // rust: let infos = pack_infos(&self.vanilla_root(), &self.server_packs.active);
    // rust: let browsing = self.settings.extras.pack_browser;
    // rust: let o = &mut self.ui.options;
    // rust: o.pack_browser = browsing;
    // rust: o.pack_infos = infos;
    // rust: o.pack_selection = self.settings.resource_packs.clone();
    // rust: o.pack_screen = None;
}
    // `Minecraft.reloadResourcePacks`: rebuild the overlay and reload every
    // client resource from it, as vanilla's reload listeners do: block
    // models and sprites (every section is meshed again,
    // `LevelRenderer.allChanged`), the shared atlas (GUI, item, entity,
    // particle and font textures), item models, sounds, languages, GUI
    // metadata and the cloud and world border textures. The loading runs on
    // a worker under the progress overlay (`LoadingOverlay` over
    // `ReloadableResourceManager.createReload`'s background executor), so
    // the window keeps drawing; `drive_pack_reload` applies it.
    // Horizon's pack browser: what its worker finished since the last
    // frame. A pack that landed becomes an entry in the available list.
    // rust: pub(super) fn drive_pack_browser(&mut self) {
    // rust: let Some(screen) = &mut self.ui.options.pack_screen else {
    // rust: return;
}
    // rust: let Some(browser) = &mut screen.browser else {
    // rust: return;
}
    // rust: let Some(message) = browser.poll() else {
    // rust: return;
}
    // rust: if let pack_browser::Message::Results(_) = &message {
            // The rows draw their icons as they land.
    // rust: browser.fetch_icons();
}
    // rust: if let pack_browser::Message::Icon(id, png) = &message {
    // rust: let key = pack_screen::icon_texture(id);
    // rust: if let Some(icon) = pack_screen::load_fetched_icon(png) {
                // Tracked, so closing the browser frees it again.
    // rust: screen.keep_browser_icon(key, icon);
}
    // rust: return;
}
    // rust: if let pack_browser::Message::Downloaded(name) = message {
    // rust: log::info!("Horizon: added the resource pack {name}");
            // Rebuilding the screen would shut the list; keep it and only
            // refresh what the lists read.
    // rust: let selection = self.settings.resource_packs.clone();
    // rust: let infos = pack_infos(&self.vanilla_root(), &self.server_packs.active);
    // rust: self.ui.options.pack_infos = infos;
    // rust: self.ui.options.pack_selection = selection;
    // rust: self.ui.options.pack_screen = None;
}
}
    // rust: pub(super) fn reload_packs(&mut self) {
        // Pack reload updates tail-owned mob metadata. Keep menus responsive
        // until those resources exist, then apply the latest selection once.
        // A reload already under its overlay finishes first (vanilla's
        // `pendingReload`, which `runTick` starts once the overlay is gone).
    // rust: if reload_waits(self.rest_loader.is_some(), self.pack_reload.is_some()) {
    // rust: self.pending_pack_reload = true;
    // rust: return;
}
    // rust: if let Err(e) = self.spawn_pack_reload(ReloadKind::Selection) {
    // rust: self.selection_reload_failed(&format!("could not start the pack reload: {e}"));
}
}
    // `reloadResourcePacks`' failure (`Minecraft.rollbackResourcePacks`): with
    // a pack selected, all selected packs are dropped and the reload runs
    // again, with the load-failure toast; with none left to drop, the pack
    // screen again, with the error.
selection_reload_failed :: proc(self: ^Self, error: string) {
}
    // rust: log::warn!("Horizon: resource reload failed: {error}");
    // rust: let all = packs::discover(&self.vanilla_root(), &packs_dir());
    // rust: if packs::able_to_clear_any_pack(&all, &self.settings.resource_packs) {
            // clearResourcePacksOnError.
    // rust: log::info!("Caught error loading resourcepacks, removing all selected resourcepacks");
    // rust: self.settings.resource_packs.clear();
    // rust: self.settings.save(&Self::options_path());
    // rust: if self.spawn_pack_reload(ReloadKind::Selection).is_ok() {
                // addResourcePackLoadFailToast(null), SystemToast.addOrUpdate.
    // rust: let title = lang::tr("resourcePack.load_fail", &[]);
    // rust: match &mut self.server_packs.load_fail {
    // rust: Some(toast) => toast.reset(title, None),
    // rust: None => {
    // rust: if self.toast_allowed("system", "pack_load_failure") {
    // rust: self.server_packs.load_fail =
    // rust: Some(horizon_client::toasts::SystemToast::new(title, None));
}
}
}
    // rust: return;
}
}
    // rust: if self.screen != super::Screen::Options {
    // rust: self.open_options_at(
    // rust: self.title.is_some(),
    // rust: horizon_client::options_ui::Page::Packs,
    // rust: );
}
    // rust: self.ui.options.resource_error = Some(error.to_string());
}
    // Stages the selection with the server's active packs on top on a
    // worker (`createReload`'s background executor); the frame draws its
    // progress meanwhile, and the overlay takes no input (`LoadingOverlay`),
    // so what is held is released (`KeyMapping.releaseAll`).
    // rust: pub(super) fn spawn_pack_reload(&mut self, kind: ReloadKind) -> std::io::Result<()> {
    // rust: self.keys.clear();
    // rust: self.physical_keys.clear();
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: let vanilla = self.vanilla_root();
    // rust: if self.ui.vanilla_root.as_os_str().is_empty() {
    // rust: self.ui.vanilla_root = vanilla.clone();
}
    // rust: let (selected, server, mods, dev_mods) = (
    // rust: self.settings.resource_packs.clone(),
    // rust: self.server_packs.active.clone(),
    // rust: self.applied_mods(),
    // rust: self.options.dev_mods.clone(),
    // rust: );
    // rust: let (assets, res, context) = (
    // rust: self.pack.assets.clone(),
    // rust: self.res.clone(),
    // rust: self.pack.context.clone(),
    // rust: );
    // rust: let (unicode, japanese) = (self.settings.force_unicode, self.settings.japanese_glyphs);
    // rust: self.pack_reload = Some(PackReload::spawn(kind, move |progress| {
    // rust: stage_pack(
    // rust: &vanilla, &selected, &server, &mods, &dev_mods, &assets, &res, &context, unicode,
    // rust: japanese, progress,
    // rust: )
    // rust: .map_err(|e| e.to_string())
    // rust: })?);
    // rust: Ok(())
}
    // `LoadingOverlay.tick` once the reload is done: the staged pack is
    // applied on the render thread, and its outcome goes to whoever asked
    // (`reloadResourcePacks`' callback, or `PackReloadConfig.Callbacks`).
    // rust: pub(super) fn drive_pack_reload(&mut self) {
    // rust: let Some((kind, staged)) = self.pack_reload.as_mut().and_then(PackReload::finished) else {
    // rust: return;
}
    // rust: self.pack_reload = None;
    // rust: let result =
    // rust: staged.and_then(|staged| self.apply_staged_pack(staged).map_err(|e| e.to_string()));
    // rust: match kind {
    // rust: ReloadKind::Selection => {
    // rust: self.mods_reloaded(result.is_ok());
    // rust: if let Err(e) = result {
    // rust: self.selection_reload_failed(&e);
}
}
    // rust: ReloadKind::Server => {
    // rust: if let Err(e) = &result {
    // rust: log::warn!("Horizon: server resource pack reload failed: {e}");
}
    // rust: self.finish_pack_reload(result.is_ok());
}
}
}
    // The render-thread half: the renderer on the new pack's textures, then
    // the swap (`ReloadInstance`'s application listeners).
    // rust: pub(super) fn apply_staged_pack(&mut self, staged: StagedPack) -> horizon_client::Result<()> {
    // rust: let StagedPack {
    // rust: root,
    // rust: gui,
    // rust: pack,
    // rust: textures,
    // rust: cem,
    // rust: block_entity_shapes,
    // rust: sounds,
    // rust: ui_metadata,
    // rust: language,
    // rust: } = staged;
        // Keep the working GPU resources, and hand its window surface over.
    // rust: if let Some(renderer) = &mut self.renderer {
    // rust: renderer.release_surface();
}
    // rust: let renderer = match self
    // rust: .window
    // rust: .clone()
    // rust: .map(|window| {
    // rust: build_renderer(
    // rust: window,
    // rust: self.options.offscreen,
    // rust: &pack,
    // rust: &gui,
    // rust: self.renderer.as_ref(),
    // rust: Some(textures),
    // rust: self.settings.horizon.api,
    // rust: self.settings.horizon.translucent_batching,
    // rust: self.settings.horizon.wide_frame(),
    // rust: super::shader_packs::picked_pack_draws_flat(&self.settings),
    // rust: (
    // rust: self.settings.file.int("textureFiltering"),
    // rust: self.settings.file.int("maxAnisotropyBit"),
    // rust: ),
    // rust: )
    // rust: })
    // rust: .transpose()
    // rust: {
    // rust: Ok(renderer) => renderer,
    // rust: Err(error) => {
    // rust: if let Some(renderer) = &mut self.renderer {
    // rust: renderer.recreate_surface().map_err(|restore| {
    // rust: format!(
    // rust: "{error}; could not restore the previous rendering surface: {restore}"
    // rust: )
    // rust: })?;
}
    // rust: return Err(error);
}
}
        // Everything loaded: switch over.
    // rust: self.waypoint_styles = horizon_client::locator_bar::WaypointStyles::load(&root);
    // rust: self.armor_stand_assets.reload_trims(&root);
    // rust: self.random_tick_sections.clear();
    // rust: self.portals.sections.clear();
    // rust: self.options.resources = root.clone();
    // rust: self.pack = pack;
    // rust: self.gui = gui;
        // The new atlas's skin and map slots are blank: players and maps
        // upload into it again instead of naming sprites it does not have.
    // rust: self.skin_slots.forget();
    // rust: self.skin_downloads
    // rust: .borrow_mut()
    // rust: .set_resource_root(self.options.resources.clone());
    // rust: self.maps.slots.forget();
    // rust: self.map_patches.clear();
        // Kept mod block entities name the old atlas's sprites.
    // rust: self.kept_block_entities.get_mut().clear();
        // The atlas's sprites moved: the particle engine re-reads every rect
        // and the packs' sprite sets, or every particle draws a stale region.
    // rust: self.particles
    // rust: .reload(&root, &self.gui.atlas.sprites, &self.gui.atlas.translucent);
    // rust: horizon_client::ui_theme::reset_atlas();
        // Villager hats come from the pack's texture metadata (shared data, swapped in place).
    // rust: *self
    // rust: .res
    // rust: .mob_data()
    // rust: .villager_hats
    // rust: .write()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) =
    // rust: horizon_client::mobs::villager_hats::VillagerHats::load(&root);
    // rust: *self
    // rust: .res
    // rust: .mob_data()
    // rust: .cem
    // rust: .write()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) = cem;
    // rust: self.res
    // rust: .block_entity_render()
    // rust: .set_shapes(block_entity_shapes);
        // The random entity textures and emissive overlays the new atlas packs. A new scan is
        // a new generation:
        // every mob (every splitscreen player's too) chooses again on its next tick.
    // rust: *self
    // rust: .res
    // rust: .mob_data()
    // rust: .random_textures
    // rust: .write()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) =
    // rust: std::mem::take(&mut self.gui.atlas.random_textures);
    // rust: *self
    // rust: .res
    // rust: .mob_data()
    // rust: .emissive
    // rust: .write()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) = self.gui.atlas.emissive.clone();
    // rust: *self
    // rust: .res
    // rust: .mob_data()
    // rust: .blinks
    // rust: .write()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner) =
    // rust: std::mem::take(&mut self.gui.atlas.blinks);
    // rust: horizon_client::ui::set_metadata(ui_metadata);
        // Read with the language in use when the reload started: one picked since then wins.
    // rust: let code = lang::code();
    // rust: lang::set(if language.code == code {
    // rust: language
    // rust: } else {
    // rust: lang::Language::load(&[&root], &code)
    // rust: });
    // rust: self.refresh_remote_language();
    // rust: self.audio.reload_with(&root, sounds);
    // rust: self.clear_lod();
        // A pack that may replace leaf models falls back to `Off` before the
        // reload marks every section dirty.
    // rust: self.streaming.leaf_culling = self.effective_leaf_culling();
    // rust: let context = self.worker_context();
    // rust: self.streaming.reload_resources(&mut self.world, context);
    // rust: self.pending_uploads.clear();
        // New GPU textures: a renderer built from the reloaded resources; the
        // sections are uploaded again as they are meshed.
    // rust: if let Some(mut renderer) = renderer {
            // The old one's size: a splitscreen player's view is smaller than the window the new
            // one was sized from (it drew a window-sized frame into the view, cut off).
    // rust: if let Some(old) = &self.renderer {
    // rust: renderer.resize(old.config.width, old.config.height);
}
    // rust: self.renderer = Some(renderer);
    // rust: self.apply_ui_settings();
}
        // Horizon's own shader pack is built again: its sprite tags name the old atlas's
        // layers, and a new renderer runs no pack.
    // rust: self.native_shaders = super::native_shaders::NativeShaders::picking(&std::mem::take(
    // rust: &mut self.native_shaders.picked,
    // rust: ));
    // rust: self.ui.chat.rescale(&self.gui.atlas);
        // The creative screen survives the reload; item names may not.
    // rust: self.creative_screen.forget_items();
    // rust: self.native_client_resources_reloaded();
    // rust: Ok(())
}
}

// The CPU half of a pack reload (`PackReload` runs it on a worker;
// `apply_staged_pack` does the GPU half and the swap): the overlay
// root, the models and sprites, the menu bundle, the pack's tables and its
// CPU mip chains.
    // rust: pub(super) fn stage_pack(
    // rust: vanilla_root: &Path,
    // rust: selected: &[String],
    // rust: server: &[Pack],
    // rust: mods_enabled: &BTreeSet<String>,
    // rust: dev_mods: &[PathBuf],
    // rust: assets: &Arc<Assets>,
    // rust: res: &Resources,
    // rust: context: &WorkerContext,
    // rust: force_unicode: bool,
    // rust: japanese: bool,
    // rust: progress: &super::Progress,
    // rust: ) -> horizon_client::Result<StagedPack> {
    // rust: let root = startup_root(vanilla_root, selected, server)?;
    // rust: let root = super::mods::content_root(&root, mods_enabled, dev_mods);
    // rust: progress.set(1);
    // The world's models and sprites and the GUI atlas read the same root and nothing of
    // each other: about a second each, side by side.
    // rust: let mod_image = crate::game::mods::built_with_native_mods();
    // The sound events, the GUI sprites' metadata and the language are read here too, not in
    // the frame that applies the reload (about 20 ms of it).
    // rust: let (render, atlas, panorama, (sounds, ui_metadata, language)) = std::thread::scope(|s| {
    // rust: let atlas = s.spawn(|| {
    // rust: HudAtlas::build_over_with_image(&root, vanilla_root, mod_image)
    // rust: .map_err(|e| e.to_string())
    // rust: });
    // rust: let panorama = s.spawn(|| horizon_client::gfx::panorama::Faces::load(&root, vanilla_root));
    // rust: let small = s.spawn(|| {
    // rust: (
    // rust: horizon_client::sound_events::SoundRegistry::load(&root),
    // rust: horizon_client::ui::read_metadata(&root),
    // rust: lang::Language::load(&[&root], &lang::code()),
    // rust: )
    // rust: });
    // rust: (
    // rust: assets.reload(&root),
    // rust: atlas.join(),
    // rust: panorama.join(),
    // rust: small
    // rust: .join()
    // rust: .unwrap_or_else(|p| std::panic::resume_unwind(p)),
    // rust: )
    // rust: });
    // rust: let render = Arc::new(render?);
    // rust: let mut atlas = atlas.unwrap_or_else(|p| std::panic::resume_unwind(p))?;
    // rust: atlas.font.uniform = force_unicode;
    // rust: atlas.font.japanese = japanese;
    // rust: let gui = UiResources {
    // rust: atlas,
    // rust: panorama: Arc::new(panorama.unwrap_or_else(|p| std::panic::resume_unwind(p))),
}
    // rust: progress.set(2);
    // rust: let pack = PackResources::load(
    // rust: &root,
    // rust: assets.clone(),
    // rust: render,
    // rust: res.facts(),
    // rust: context.biomes.clone(),
    // rust: context.light.clone(),
    // rust: )?;
    // rust: let textures = prepare_renderer_textures(&pack);
    // rust: let cem = Arc::new(horizon_client::mobs::cem::CemModels::load(
    // rust: &root,
    // rust: res.mob_types(),
    // rust: ));
    // rust: let block_entity_shapes = res.block_entity_render().shapes_for(&root);
    // rust: progress.set(3);
    // rust: Ok(StagedPack {
    // rust: root,
    // rust: gui,
    // rust: pack,
    // rust: textures,
    // rust: cem,
    // rust: block_entity_shapes,
    // rust: sounds,
    // rust: ui_metadata,
    // rust: language,
    // rust: })
}

// Everything a pack reload builds on the CPU (`apply_staged_pack` finishes
// it on the render thread).
    // rust: pub(super) struct StagedPack {
    // rust: pub root: PathBuf,
    // rust: pub gui: UiResources,
    // rust: pub pack: PackResources,
    // rust: pub textures: PreparedTextures,
    // The packs' custom entity models (OptiFine CEM).
    // rust: pub cem: Arc<horizon_client::mobs::cem::CemModels>,
    // The block entities' models, the packs' custom entity models over vanilla's.
    // rust: pub block_entity_shapes: Arc<horizon_client::block_entity_render::BlockEntityShapes>,
    // The root's sound events, GUI sprite metadata and current language.
    // rust: pub sounds: horizon_client::sound_events::SoundRegistry,
    // rust: pub ui_metadata: horizon_client::ui::UiMetadata,
    // rust: pub language: lang::Language,
}

// `LoadingOverlay`'s stage lines for a pack reload, indexed by `progress`.
    // rust: const RELOAD_LINES: [&str; 4] = [
    // rust: "Preparing resources",
    // rust: "Loading assets",
    // rust: "Loading pack tables",
    // rust: "Applying resources",
    // rust: ];
// Whether a reload asked for now waits: for the world's resources, or for
// the reload already under its overlay (`Minecraft.reloadResourcePacks`
// hands back `pendingReload` while a `LoadingOverlay` is up).
reload_waits :: proc(world_loading: bool, in_flight: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: world_loading || in_flight
}
// Who asked for a pack reload: its outcome goes back there.
    // rust: pub(super) enum ReloadKind {
    // The player's own selection (`Minecraft.reloadResourcePacks`).
    // rust: Selection,
    // A server's packs (`DownloadedPackSource.startReload`).
    // rust: Server,
}
    // rust: type StageResult = std::result::Result<StagedPack, String>;
// A pack reload whose CPU half runs on a worker while `progress` feeds the
// loading overlay; `Game::drive_pack_reload` applies it on the render thread.
    // rust: pub(super) struct PackReload {
    // rust: pub(super) progress: super::Progress,
    // rust: kind: ReloadKind,
    // rust: handle: Option<std::thread::JoinHandle<StageResult>>,
}
    // rust: impl PackReload {
    // Starts `stage` on its own thread and returns at once.
    // rust: fn spawn(
    // rust: kind: ReloadKind,
    // rust: stage: impl FnOnce(&super::Progress) -> StageResult + Send + 'static,
    // rust: ) -> std::io::Result<Self> {
    // rust: let progress = super::Progress::with(&RELOAD_LINES);
    // rust: let worker = progress.clone();
    // rust: let handle = std::thread::Builder::new()
    // rust: .name("pack-reload".into())
    // rust: .spawn(move || stage(&worker))?;
    // rust: Ok(Self {
    // rust: progress,
    // rust: kind,
    // rust: handle: Some(handle),
    // rust: })
}
    // rust: pub(super) fn kind(&self) -> ReloadKind {
    // rust: self.kind
}
    // The staged pack once the worker is done (taken once); none while it runs.
finished :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.handle.as_ref()?.is_finished() {
    // rust: return None;
}
    // rust: let staged = self
    // rust: .handle
    // rust: .take()?
    // rust: .join()
    // rust: .unwrap_or_else(|_| Err("the pack reload worker panicked".into()));
    // rust: Some((self.kind, staged))
}
}

    // rust: mod tests {
//     use super::*;
//     use std::{sync::mpsc, time::Duration};

wait :: proc(reload: ^PackReload) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: for _ in 0..500 {
    // rust: if let Some(done) = reload.finished() {
    // rust: return done;
}
    // rust: std::thread::sleep(Duration::from_millis(10));
}
    // rust: panic!("the reload worker never finished");
}

a_reload_stages_on_a_worker_while_the_caller_goes_on :: proc() {
}
        // The stage blocks until the caller lets it go: `spawn` returning at
        // all means the window thread is free to draw the overlay.
    // rust: let (release, blocked) = mpsc::channel::<()>();
    // rust: let (thread, ran_on) = mpsc::channel();
    // rust: let mut reload = PackReload::spawn(ReloadKind::Selection, move |progress| {
    // rust: blocked.recv().unwrap();
    // rust: progress.set(2);
    // rust: thread
    // rust: .send(std::thread::current().name().map(str::to_owned))
    // rust: .unwrap();
    // rust: Err("staged".into())
    // rust: })
    // rust: .unwrap();
    // rust: assert!(reload.finished().is_none(), "still staging");
    // rust: assert_eq!(reload.progress.line(), "Preparing resources");
    // rust: release.send(()).unwrap();
    // rust: let (kind, staged) = wait(&mut reload);
    // rust: assert_eq!(kind, ReloadKind::Selection);
    // rust: assert_eq!(staged.err().as_deref(), Some("staged"));
    // rust: assert_eq!(reload.progress.line(), "Loading pack tables");
    // rust: assert_eq!(ran_on.recv().unwrap().as_deref(), Some("pack-reload"));
    // rust: assert!(reload.finished().is_none(), "the outcome is taken once");
}

a_panicking_stage_fails_the_reload :: proc() {
}
    // rust: let mut reload = PackReload::spawn(ReloadKind::Server, |_| panic!("bad pack")).unwrap();
    // rust: let (kind, staged) = wait(&mut reload);
    // rust: assert_eq!(kind, ReloadKind::Server);
    // rust: assert_eq!(
    // rust: staged.err().as_deref(),
    // rust: Some("the pack reload worker panicked")
    // rust: );
}

a_reload_waits_for_world_resources_and_the_one_in_flight :: proc() {
}
    // rust: assert!(!reload_waits(false, false));
    // rust: assert!(reload_waits(true, false));
    // rust: assert!(reload_waits(false, true));
    // rust: assert!(reload_waits(true, true));
}
}
