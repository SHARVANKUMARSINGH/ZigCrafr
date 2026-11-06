//! Transpiled from Horizon Rust crate
package horizon_client_options

import "core:fmt"
import "core:mem"
import "core:math"

// The options screens bound to the game: drawing, input, applying settings
// (video, sound, chat, font, language) and the F11 fullscreen toggle.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: Result,
    // rust: hud::HudBatch,
    // rust: lang,
    // rust: options_ui::{Event, Page},
    // rust: window::{FrameContext, InactivityFpsLimit, framerate_limit},
}
// use serde_json::{Value, json};
// use winit::{event::MouseButton, keyboard::KeyCode, window::Fullscreen};

// `CommonLinks.ACCESSIBILITY_HELP`, the Accessibility page's footer link.
    // rust: pub(super) const ACCESSIBILITY_HELP_LINK: &str = "https://aka.ms/MinecraftJavaAccessibility";

    // rust: pub(super) const CONTROL_HELP: &[&str] = &[
    // rust: "options-get [KEY...]           options.txt values by key, with their type, range or choices",
    // rust: "options-set KEY VALUE          set an option (enums by name, keys as key.keyboard.w, lists as JSON), apply and save it",
    // rust: ];

    // rust: impl Game<'_> {
    // rust: pub(super) fn save_title_options(&mut self) {
    // rust: if let Some(title) = &self.title
    // rust: && (title.last_server != self.settings.file.string("lastServer")
    // rust: || title.skip_multiplayer_warning
    // rust: != self.settings.file.bool("skipMultiplayerWarning"))
    // rust: {
    // rust: self.settings.file.set(
    // rust: "lastServer",
    // rust: horizon_client::options_file::V::Str(title.last_server.clone()),
    // rust: );
    // rust: self.settings.file.set(
    // rust: "skipMultiplayerWarning",
    // rust: horizon_client::options_file::V::Bool(title.skip_multiplayer_warning),
    // rust: );
    // rust: self.settings.save(&Self::options_path());
}
}
    // `options-get` and `options-set`; None for other commands.
    // rust: pub(super) fn options_control(&mut self, words: &[&str], line: &str) -> Result<Option<Value>> {
    // rust: match words[0] {
    // rust: "options-get" => {
    // rust: let file = self.settings.to_file();
    // rust: let wanted: Vec<&str> = if words.len() > 1 {
    // rust: words[1..].to_vec()
    // rust: } else {
    // rust: horizon_client::options_file::keys()
}
    // rust: let mut options = serde_json::Map::new();
    // rust: for key in wanted {
    // rust: let described = file.describe(key).ok_or_else(|| {
    // rust: format!("unknown option {key}; options-get lists them all")
    // rust: })?;
    // rust: options.insert(key.to_owned(), described);
}
    // rust: Ok(Some(json!({ "options": options })))
}
    // rust: "options-set" => {
    // rust: let key = words.get(1).ok_or("options-set KEY VALUE")?;
                // The value runs to the end of the line (lists, server names).
    // rust: let value = line
    // rust: .trim_start()
    // rust: .strip_prefix("options-set")
    // rust: .and_then(|rest| rest.trim_start().strip_prefix(key))
    // rust: .map(str::trim)
    // rust: .filter(|v| !v.is_empty())
    // rust: .ok_or("options-set KEY VALUE: missing the value")?;
    // rust: let narrator = self.settings.narrator();
    // rust: self.settings = self.settings.with_option(key, value)?;
                // As the options screen applies a change (OptionInstance.set
                // runs the narrator's onValueUpdate for a new value only).
    // rust: let mut events = vec![Event::Changed];
    // rust: if self.settings.narrator() != narrator {
    // rust: events.push(Event::Narrator);
}
    // rust: self.handle_option_events(events)?;
    // rust: match *key {
    // rust: "lang" => self.load_language(&self.settings.language.clone()),
    // rust: "resourcePacks" | "incompatibleResourcePacks" => self.reload_packs(),
    // rust: _ => {}
}
                // Labels change (a language, a value): `ui` reads the redrawn screen.
    // rust: self.ui_wait.clicked();
    // rust: let now = self.settings.to_file().describe(key);
    // rust: Ok(Some(json!({ "ok": true, "key": key, "option": now })))
}
    // rust: _ => Ok(None),
}
}
    // This player's `options.txt`: in the game folder, or in `--player-dir` when several
    // players share one (`logging::set_player_dir`).
    // rust: pub(super) fn options_path() -> std::path::PathBuf {
        // Splitscreen's second player has its own options (`split::options_path`).
    // rust: if let Some(path) = super::split::options_path() {
    // rust: return path;
}
    // rust: horizon_client::logging::player_dir().join("options.txt")
}
    // The game folder (the working directory): what its players share, saves, packs, mods.
    // rust: pub(super) fn game_dir() -> std::path::PathBuf {
    // rust: std::env::current_dir().unwrap_or_default()
}
    // `shaderpacks/` in the game folder.
    // rust: pub(super) fn shader_packs_dir() -> std::path::PathBuf {
    // rust: Self::game_dir().join(horizon_client::shader_pack_list::DIR)
}
    // rust: pub(super) fn gui_size(&self) -> (f32, f32) {
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1280, 720], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: (b.width, b.height)
}
    // Open the options screens (OptionsScreen) from the title or pause menu.
    // rust: pub(super) fn open_options(&mut self, from_title: bool) {
    // rust: self.open_options_at(from_title, Page::Main);
}
    // rust: pub(super) fn open_options_at(&mut self, from_title: bool, page: Page) {
        // Gameplay keys must not stay held behind the options screen, where
        // bindings can also change before the physical key is released.
    // rust: self.keys.clear();
    // rust: self.screen = Screen::Options;
    // rust: self.options_from_title = from_title;
    // rust: self.options_to_game = false;
    // rust: let minecart_improvements = self.minecart_improvements();
    // rust: let mods_live = self.mods_live_now();
    // rust: let ui = &mut self.ui.options;
    // rust: ui.open_at(!from_title && self.title.is_none(), page);
    // rust: ui.mods_live = mods_live;
    // rust: ui.minecart_improvements = minecart_improvements;
    // rust: let root = self.options.resources.clone();
    // rust: ui.languages = lang::available(&[&root]);
    // rust: self.refresh_pack_lists();
}
    // While the resource pack screen is open, `resourcepacks/` is looked at once a second
    // and the list found again when its packs changed (`PackSelectionScreen.tick`'s
    // watcher).
watch_pack_folder :: proc(self: ^Self) {
}
    // rust: if !self.ui.options.resource_packs_open() {
    // rust: self.pack_folder = None;
    // rust: return;
}
    // rust: let now = std::time::Instant::now();
    // rust: if self
    // rust: .pack_folder
    // rust: .as_ref()
    // rust: .is_some_and(|(at, _)| now.duration_since(*at).as_secs_f32() < 1.0)
    // rust: {
    // rust: return;
}
    // rust: let signature: Vec<(String, u64, Option<std::time::SystemTime>)> =
    // rust: std::fs::read_dir(super::packs::packs_dir())
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| {
    // rust: let meta = e.metadata().ok();
    // rust: (
    // rust: e.file_name().to_string_lossy().into_owned(),
    // rust: meta.as_ref().map_or(0, |m| m.len()),
    // rust: meta.and_then(|m| m.modified().ok()),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let changed = self
    // rust: .pack_folder
    // rust: .as_ref()
    // rust: .is_some_and(|(_, seen)| *seen != signature);
    // rust: self.pack_folder = Some((now, signature));
    // rust: if changed {
    // rust: let infos = super::packs::pack_infos(&self.vanilla_root(), &self.server_packs.active);
    // rust: self.ui.options.update_pack_infos(infos);
}
}
    // rust: pub(super) fn draw_options(&mut self, batch: &mut HudBatch) {
    // rust: self.watch_pack_folder();
    // rust: let context = self.controller_settings_context();
    // rust: let mut ui = std::mem::take(&mut self.ui.options);
    // rust: if ui.controller_open() {
    // rust: ui.controller.context = context;
}
    // rust: ui.draw(&self.settings, batch, &self.gui.atlas, self.cursor);
    // rust: self.ui.options = ui;
    // rust: self.show_calibration(batch.height);
}
    // Whose controller settings these are and what this game sees (`controller_ui`): the
    // player's badge in splitscreen with its name, and its own controller.
controller_settings_context :: proc(self: ^Self) -> h {
    // Ported from Horizon
    return {}
}
    // rust: let name = self.options.player_name();
    // rust: let player = match &self.split_hud.badge {
    // rust: Some(badge) if *badge != name => format!("{badge} · {name}"),
    // rust: _ => name,
}
    // rust: horizon_client::controller_ui::Context {
    // rust: player,
    // rust: device: self.pad.device_or_virtual(),
    // rust: detected: detected_controller_style(self.pad.device.as_ref(), self.pad.style),
    // rust: style: self.ui.options.pad_style,
    // rust: by_letter: self.ui.options.pad_by_letter,
}
}
    // HDR calibration's test picture to the renderer, full screen while it runs: the
    // window goes fullscreen for it and back after, if it wasn't already.
    // rust: pub(super) fn show_calibration(&mut self, h: f32) {
    // rust: let picture = (self.screen == Screen::Options)
    // rust: .then(|| self.ui.options.calibration_picture(h))
    // rust: .flatten();
    // rust: if let Some(r) = self.renderer.as_mut() {
    // rust: r.set_hdr_calibration(picture.map(|(step, nits, band)| {
    // rust: horizon_client::gfx::HdrCalibration {
    // rust: step: step.number(),
    // rust: nits,
    // rust: band,
}
    // rust: }));
}
    // rust: let Some(window) = &self.window else {
    // rust: return;
}
    // rust: match (picture.is_some(), self.ui.options.calibration_fullscreen) {
    // rust: (true, None) => {
    // rust: let was = window.fullscreen().is_some();
    // rust: if !was {
    // rust: window.set_fullscreen(Some(Fullscreen::Borderless(None)));
}
    // rust: self.ui.options.calibration_fullscreen = Some(was);
}
    // rust: (false, Some(was)) => {
    // rust: if !was {
    // rust: window.set_fullscreen(None);
}
    // rust: self.ui.options.calibration_fullscreen = None;
}
    // rust: _ => {}
}
}
    // rust: pub(super) fn options_mouse(&mut self, pressed: bool, right: bool) -> Result<()> {
    // rust: if !pressed {
    // rust: if right {
    // rust: return Ok(());
}
    // rust: let events = self.ui.options.release();
    // rust: self.dragging = false;
    // rust: return self.handle_option_events(events);
}
    // rust: if !right {
    // rust: self.dragging = true;
}
    // rust: let size = self.gui_size();
    // rust: let framebuffer = self.renderer.as_ref().map_or([1280, 720], |r| {
    // rust: [r.config.width as i32, r.config.height as i32]
    // rust: });
    // rust: let mut ui = std::mem::take(&mut self.ui.options);
    // rust: ui.shift = self.modifiers.shift_key();
    // rust: let events = ui.click(
    // rust: &mut self.settings,
    // rust: &self.gui.atlas,
    // rust: self.cursor.0,
    // rust: self.cursor.1,
    // rust: size,
    // rust: framebuffer,
    // rust: false,
    // rust: right,
    // rust: );
    // rust: self.ui.options = ui;
    // rust: self.handle_option_events(events)
}
    // rust: pub(super) fn options_drag(&mut self) -> Result<()> {
    // rust: let size = self.gui_size();
    // rust: let framebuffer = self.renderer.as_ref().map_or([1280, 720], |r| {
    // rust: [r.config.width as i32, r.config.height as i32]
    // rust: });
    // rust: let mut ui = std::mem::take(&mut self.ui.options);
    // rust: let events = ui.click(
    // rust: &mut self.settings,
    // rust: &self.gui.atlas,
    // rust: self.cursor.0,
    // rust: self.cursor.1,
    // rust: size,
    // rust: framebuffer,
    // rust: true,
    // rust: false,
    // rust: );
    // rust: self.ui.options = ui;
    // rust: self.handle_option_events(events)
}
    // rust: pub(super) fn options_key(&mut self, key: KeyCode, text: Option<&str>) -> Result<()> {
    // rust: let size = self.gui_size();
    // rust: let shift = self.has_shift_down();
    // rust: let framebuffer = self.renderer.as_ref().map_or([1280, 720], |r| {
    // rust: [r.config.width as i32, r.config.height as i32]
    // rust: });
    // rust: self.ui.options.size = size;
    // rust: self.ui.options.framebuffer = framebuffer;
    // rust: let mut ui = std::mem::take(&mut self.ui.options);
    // rust: let events = ui.key_modifiers(&mut self.settings, &self.gui.atlas, key, text, shift);
    // rust: self.ui.options = ui;
    // rust: self.handle_option_events(events)
}
    // Ctrl+A/C/V/X in the options' search boxes; false when none has focus.
    // rust: pub(super) fn options_shortcut(
    // rust: &mut self,
    // rust: shortcut: horizon_client::clipboard::EditShortcut,
    // rust: ) -> bool {
    // rust: self.ui
    // rust: .options
    // rust: .shortcut(&self.gui.atlas, shortcut, &mut self.clipboard)
}
    // rust: pub(super) fn options_scroll(&mut self, amount: f32) -> Result<()> {
    // rust: if self.pad_stick_scroll() {
    // rust: let size = self.gui_size();
    // rust: self.ui
    // rust: .options
    // rust: .scroll_at(&self.settings, size, self.cursor, amount);
    // rust: return Ok(());
}
    // rust: let framebuffer = self.renderer.as_ref().map_or([1280, 720], |r| {
    // rust: [r.config.width as i32, r.config.height as i32]
    // rust: });
    // rust: if self.ui.options.video_open() && self.has_control_down() {
            // VideoSettingsScreen.mouseScrolled: Ctrl with the wheel steps the GUI scale.
    // rust: let mut ui = std::mem::take(&mut self.ui.options);
    // rust: let events = ui.video_wheel_gui_scale(&mut self.settings, framebuffer, amount);
    // rust: self.ui.options = ui;
    // rust: return self.handle_option_events(events);
}
    // rust: let size = self.gui_size();
    // rust: let events =
    // rust: self.ui
    // rust: .options
    // rust: .wheel(&mut self.settings, size, self.cursor, framebuffer, amount);
    // rust: self.handle_option_events(events)
}
    // Mouse buttons pressed while a key is being bound.
    // rust: pub(super) fn options_waiting_for_key(&self) -> bool {
    // rust: self.ui.options.selected_key.is_some()
}
    // rust: pub(super) fn options_bind_mouse(&mut self, button: MouseButton) -> Result<()> {
    // rust: let events = self.ui.options.bind_mouse(&mut self.settings, button);
    // rust: self.handle_option_events(events)
}
    // rust: pub(super) fn handle_option_events(&mut self, events: Vec<Event>) -> Result<()> {
    // rust: for e in events {
    // rust: match e {
    // rust: Event::ButtonClick => self.audio.play_button_click(),
    // rust: Event::Changed => {
    // rust: self.settings.save(&Self::options_path());
    // rust: self.apply_settings();
    // rust: self.switch_mods();
    // rust: self.sync_native_switches();
    // rust: self.sync_pregen_option();
    // rust: self.sync_agent_control();
    // rust: self.ui.options.agent_status = self.agent_status_lines();
}
    // rust: Event::SliderDrag => {
    // rust: self.apply_settings();
}
                // Options.createSoundSliderOptionInstance: the preview plays
                // only without a level (on the title screen's options).
    // rust: Event::Volume(source, volume) if self.title.is_some() => {
    // rust: self.audio.preview(source, volume);
}
    // rust: Event::Volume(..) => {}
    // rust: Event::CopyAgentDetails => {
//                     use horizon_client::clipboard::Clipboard;
    // rust: let text = self.agent_details();
    // rust: self.clipboard.set(&text);
}
                // The AI Agent page's repro buttons (game/repro.rs).
    // rust: Event::ToggleRecording => self.toggle_recording_key(),
    // rust: Event::ExportRepro => self.export_repro_key(),
                // The Music page: the situations' tracks, and playing one now.
    // rust: Event::ListMusicTracks => self.ui.options.music_groups = self.music_groups(),
    // rust: Event::PlayMusicTrack(event, track) => self.play_music_track(&event, &track),
    // rust: Event::Close if self.ui.options.resource_error.is_some() => {}
    // rust: Event::Close => {
    // rust: self.settings.save(&Self::options_path());
    // rust: let to_game = std::mem::take(&mut self.options_to_game);
    // rust: self.screen = if std::mem::take(&mut self.options_to_world_options) {
    // rust: Screen::WorldOptions
    // rust: } else if self.options_from_title || to_game {
    // rust: Screen::Playing
    // rust: } else {
    // rust: Screen::Paused
}
    // rust: if to_game {
    // rust: self.capture(true);
}
    // rust: self.dragging = false;
                    // Closed from calibration (horizon-ctl, a lost window): out of it.
    // rust: self.show_calibration(0.0);
}
    // rust: Event::Language(code) => {
    // rust: self.load_language(&code);
}
    // rust: Event::Packs(_) => {
    // rust: self.settings.save(&Self::options_path());
    // rust: self.reload_packs();
}
    // rust: Event::OpenPackFolder => {
    // rust: let dir = super::packs::packs_dir();
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: super::packs::open_folder(&dir);
}
                // Horizon's own Add button: the screen picked a hit, the game
                // owns the folder it lands in.
    // rust: Event::DownloadPack(i) => {
    // rust: let dir = super::packs::packs_dir();
    // rust: if let Some(screen) = &mut self.ui.options.pack_screen
    // rust: && let Some(browser) = &mut screen.browser
    // rust: {
    // rust: browser.download(i, &dir, horizon_core::VANILLA_VERSION);
}
}
    // rust: Event::DataPacks(ids) => {
    // rust: let resources = self.vanilla_root();
    // rust: if let Some(title) = &mut self.title {
    // rust: title.offer_data_packs(&resources, ids);
}
}
    // rust: Event::OpenDataPackFolder(dir) => {
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: super::packs::open_folder(&dir);
}
    // rust: Event::OpenModFolder => {
    // rust: let dir = Self::game_dir().join(horizon_client::mod_list::DIR);
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: super::packs::open_folder(&dir);
}
    // rust: Event::BrowseMods => {
    // rust: let ui = &mut self.ui.options.mod_browser;
    // rust: self.mods.jobs.browse(ui, Self::game_dir());
}
    // rust: Event::InstallMod(id) => {
    // rust: let ui = &mut self.ui.options.mod_browser;
    // rust: self.mods.jobs.install(ui, Self::game_dir(), id);
}
                // The website, through ConfirmLinkScreen as other links.
    // rust: Event::OpenModPage(url) => self.confirm_trusted_link(&url, Screen::Options),
    // rust: Event::ListShaderPacks => {
    // rust: self.settings.shader_packs =
    // rust: horizon_client::shader_pack_list::scan(&Self::shader_packs_dir());
}
                // Saved; the next frame's `shader_pack_inputs` loads the pick.
    // rust: Event::ShaderPack => self.settings.save(&Self::options_path()),
    // rust: Event::OpenShaderOptions => self.open_shader_options(),
    // rust: Event::ShaderOptions => self.save_shader_options(),
    // rust: Event::NativePackOptions(i) => {
    // rust: if let Some(pack) = self.settings.shader_packs.get(i) {
    // rust: pack.save_values(&Self::shader_packs_dir());
}
}
    // rust: Event::OpenShaderPackFolder => {
    // rust: let dir = Self::shader_packs_dir();
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: super::packs::open_folder(&dir);
}
    // rust: Event::NativeSettings(i) => self.native_settings_refresh(i),
    // rust: Event::NativeButton(i, b) => self.native_settings_event(i, b),
    // rust: Event::Credits => self.open_win_screen(false, super::win::Finish::Options),
    // rust: Event::HudEditor => self.open_hud_editor(true),
                // AccessibilityOptionsScreen's link button: ConfirmLinkScreen
                // back to the options screen.
    // rust: Event::AccessibilityHelp => {
    // rust: self.confirm_trusted_link(ACCESSIBILITY_HELP_LINK, Screen::Options)
}
    // rust: Event::Narrator => self.narrator_status_changed(),
    // rust: Event::OpenStudioFolder => {
    // rust: let dir = std::path::PathBuf::from("recordings");
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: super::packs::open_folder(&dir);
}
}
}
    // rust: Ok(())
}
    // LanguageManager.setSelected + reload: translations, then re-wrap chat.
    // rust: pub(super) fn load_language(&mut self, code: &str) {
    // rust: let root = self.options.resources.clone();
    // rust: lang::set(lang::Language::load(&[&root], code));
    // rust: self.refresh_remote_language();
    // rust: self.ui.chat.rescale(&self.gui.atlas);
    // rust: self.creative_screen.forget_items();
}
    // Window.updateFullscreenIfChanged: only a changed option asks the
    // window to change, so applying settings never undoes a fullscreen
    // the compositor set up.
apply_fullscreen :: proc(self: ^Self) {
}
        // A splitscreen guest draws in a window it shares: its option never changes the window.
    // rust: if self.options.split_guest {
    // rust: return;
}
    // rust: if let Some(w) = self.window.clone() {
    // rust: let monitor = w.current_monitor().or_else(|| w.primary_monitor());
    // rust: if let Some(modes) = self
    // rust: .video_modes
    // rust: .refresh(monitor, horizon_client::window::monitor_video_modes)
    // rust: {
    // rust: self.settings.video_modes = modes;
}
    // rust: let in_video_screen = self.screen == Screen::Options && self.ui.options.video_open();
    // rust: let wanted = self.settings.fullscreen;
    // rust: let exclusive = self.settings.file.bool("exclusiveFullscreen");
    // rust: let preferred = self
    // rust: .settings
    // rust: .file
    // rust: .fullscreen_resolution
    // rust: .as_deref()
    // rust: .and_then(horizon_client::window::VideoMode::read);
    // rust: let leaving = !wanted && w.fullscreen().is_some();
    // rust: self.fullscreen
    // rust: .apply(&w, wanted, exclusive, preferred, in_video_screen);
    // rust: if leaving {
    // rust: windowed_again(&w);
}
}
}
    // Settings that Horizon applies beyond render distance, volume and GUI scale.
    // rust: pub(super) fn apply_ui_settings(&mut self) {
    // rust: if horizon_client_render::mipmap::set_dither_cutouts(
    // rust: self.settings.horizon.dither_cutout_mips,
    // rust: ) {
    // rust: self.reload_packs();
}
    // rust: self.apply_fullscreen();
    // rust: let s = &self.settings;
    // rust: if let Some(r) = self.renderer.as_mut() {
    // rust: r.gamma = s.gamma;
    // rust: r.fullbright = s.extras.fullbright;
    // rust: r.improved_transparency = s.improved_transparency;
    // rust: r.set_present_mode(s.vsync, s.horizon.present_mode);
    // rust: r.animated_textures = s.horizon.animated_textures;
    // rust: r.screenshot_quality = s.horizon.screenshot_quality;
    // rust: r.set_mipmap_levels(s.mipmap_levels.max(0) as u32);
    // rust: r.set_texture_filtering(
    // rust: s.file.int("textureFiltering"),
    // rust: s.file.int("maxAnisotropyBit"),
    // rust: );
    // rust: r.set_world_post(
    // rust: s.horizon.resolution_scale as f32 / 100.0,
    // rust: s.horizon.fxaa,
    // rust: s.horizon.taa,
    // rust: s.horizon.upscaling.ratio(),
    // rust: );
    // rust: r.set_frame_generation(
    // rust: s.horizon.frame_generation != horizon_client::graphics::FrameGeneration::Off,
    // rust: );
    // rust: r.set_hdr_lighting(s.horizon.hdr_lighting);
            // Where it is offered (`Renderer::gpu_culling_offer`); unchanged, it does nothing.
    // rust: let _ = r.set_gpu_culling(s.horizon.gpu_culling);
    // rust: r.set_hdr(
    // rust: s.horizon.hdr,
    // rust: s.horizon.paper_white_nits() as f32,
    // rust: s.horizon.peak_nits() as f32,
    // rust: s.horizon.black_level_nits(),
    // rust: s.horizon.hdr_ui_brightness as f32 / 100.0,
    // rust: &Self::options_path().with_file_name(horizon_client::graphics::HDR_MARKER),
    // rust: );
}
    // rust: let mut volumes = s.volumes;
    // rust: volumes[0] = 1.0;
        // Splitscreen: the speakers are P1's, and so are their volumes.
    // rust: if !self.options.split_guest {
    // rust: horizon_client::settings::set_source_volumes(volumes);
}
    // rust: super::narrator::sync(s);
    // rust: let chat = s.chat_options();
    // rust: let rescale = {
    // rust: let o = &self.ui.chat.options;
    // rust: o.width != chat.width || o.scale != chat.scale || o.line_spacing != chat.line_spacing
}
    // rust: self.ui.chat.options = chat;
    // rust: if rescale {
    // rust: self.ui.chat.rescale(&self.gui.atlas);
}
    // rust: let font = &mut self.gui.atlas.font;
    // rust: if font.uniform != s.force_unicode || font.japanese != s.japanese_glyphs {
    // rust: font.uniform = s.force_unicode;
    // rust: font.japanese = s.japanese_glyphs;
    // rust: font.reset_cache();
    // rust: self.ui.chat.rescale(&self.gui.atlas);
}
        // 3D skin layers: a skin's slabs are built when it is resolved, so a
        // change here rebuilds the players already on screen (the Options
        // screen keeps resolving them every frame; this covers the console
        // and a setting restored from options.txt at start).
    // rust: if self.title.is_none() {
    // rust: self.update_remote_skins();
}
}
    // `Window.updateFullscreenState`: a fullscreen change made by the window
    // system is adopted by the option (`Minecraft.fullscreenStateChanged`).
    // rust: pub(super) fn observe_fullscreen(&mut self) {
        // HDR calibration's own fullscreen is not the player's option: it
        // goes back to what it was when the calibration ends.
    // rust: if self.ui.options.calibration_fullscreen.is_some() {
    // rust: return;
}
    // rust: let Some(w) = &self.window else { return };
    // rust: if self.options.split_guest {
    // rust: return;
}
    // rust: if let Some(now) = self.fullscreen.observe(w.fullscreen().is_some())
    // rust: && self.settings.fullscreen != now
    // rust: {
    // rust: self.settings.fullscreen = now;
    // rust: self.settings.save(&Self::options_path());
}
}
    // F11 (key.fullscreen): Window.toggleFullScreen, remembered in options.txt.
    // rust: pub(super) fn toggle_fullscreen(&mut self) {
        // Splitscreen: another player's F11 toggles the window it plays in, kept out of its
        // options (a profile that saved it would turn the next window fullscreen on joining).
    // rust: if self.options.split_guest {
            // Window 1 is P1's: its fullscreen follows P1's option, not a guest's key.
    // rust: if self.options.split_in_main_window {
    // rust: return;
}
    // rust: if let Some(w) = &self.window {
    // rust: let on = w.fullscreen().is_none();
    // rust: w.set_fullscreen(on.then_some(Fullscreen::Borderless(None)));
    // rust: if !on {
    // rust: windowed_again(w);
}
}
    // rust: return;
}
    // rust: self.settings.fullscreen = !self.settings.fullscreen;
    // rust: self.settings.save(&Self::options_path());
    // rust: self.apply_ui_settings();
}
    // `FramerateLimitTracker.getFramerateLimit`: the Max Framerate option,
    // throttled when minimised, idle, or in a menu without a world.
    // rust: pub(super) fn framerate_limit(&self) -> i32 {
    // rust: let context = FrameContext {
    // rust: inactivity: if self.settings.inactivity_fps_limit == "minimized" {
    // rust: InactivityFpsLimit::Minimized
    // rust: } else {
    // rust: InactivityFpsLimit::Afk
    // rust: },
    // rust: iconified: self
    // rust: .window
    // rust: .as_ref()
    // rust: .is_some_and(|w| w.is_minimized().unwrap_or(false)),
    // rust: focused: self.focused,
            // Window.isExclusiveFullscreen.
    // rust: exclusive_fullscreen: self
    // rust: .window
    // rust: .as_ref()
    // rust: .is_some_and(|w| matches!(w.fullscreen(), Some(Fullscreen::Exclusive(_)))),
    // rust: now_ms: self.started.elapsed().as_millis() as i64,
    // rust: latest_input_ms: self.last_input.duration_since(self.started).as_millis() as i64,
    // rust: has_level: self.title.is_none(),
    // rust: has_screen: self.title.is_some() || self.screen != super::Screen::Playing,
    // rust: has_overlay: false,
}
    // rust: let limit = framerate_limit(self.settings.max_fps as i32, context);
    // rust: let limit = self
    // rust: .settings
    // rust: .horizon
    // rust: .battery_limit(limit, self.title.is_none(), self.focused);
        // A native mod may only lower it (`native_framerate_limit`).
    // rust: let mut hooked = limit;
    // rust: self.native_framerate_limit(
    // rust: self.focused,
    // rust: context.iconified,
    // rust: self.title.is_none(),
    // rust: &mut hooked,
    // rust: );
    // rust: if hooked >= 1 {
    // rust: hooked.min(limit)
    // rust: } else {
    // rust: limit
}
}
    // `Minecraft.runTick`'s frame limiter: `FramerateLimiter.limitDisplayFPS`
    // below 260 frames per second, sleeping then spin-waiting until the
    // frame's slot ends (not in scripted frame-count runs).
    // rust: pub(super) fn limit_frame(&mut self) {
    // rust: if self.options.frames.is_some() || self.options.paced_by_split {
    // rust: return;
}
    // rust: let limit = self.framerate_limit();
    // rust: match self.settings.horizon.pacing {
    // rust: horizon_client::graphics::Pacing::Precise => {
    // rust: horizon_client::window::end_frame(&mut self.limiter, limit, &mut self.frame_clock)
}
    // rust: horizon_client::graphics::Pacing::Efficient => {
    // rust: let mut clock = horizon_client::window::SleepingClock(self.frame_clock);
    // rust: horizon_client::window::end_frame_on_grid(&mut self.limiter, limit, &mut clock);
}
}
}
}

// The named device can be a connected pad that has not driven the game yet.
    // rust: fn detected_controller_style(
    // rust: device: Option<&horizon_client::controller_ui::Device>,
    // rust: fallback: horizon_client::gamepad::GlyphStyle,
    // rust: ) -> horizon_client::gamepad::GlyphStyle {
    // rust: device.map_or(fallback, |d| {
    // rust: horizon_client::gamepad::GlyphStyle::of_device(d.vendor, d.product)
    // rust: })
}

// Out of fullscreen, a window that splitscreen opened to fill a monitor (no border, the
// monitor's size) is a window again: its border back and, still covering the monitor, the game's
// first size (854 x 480) in the middle of it, to be moved and sized.
windowed_again :: proc(w: ^winit::window::Window) {
}
    // Only those: an ordinary window has its border, and its own size comes back by itself.
    // rust: if w.is_decorated() {
    // rust: return;
}
    // rust: w.set_decorations(true);
    // rust: let Some(m) = w.current_monitor() else {
    // rust: return;
}
    // rust: let (size, screen) = (w.inner_size(), m.size());
    // rust: if size.width >= screen.width && size.height >= screen.height {
    // rust: let scale = m.scale_factor();
    // rust: let small = winit::dpi::LogicalSize::new(854.0, 480.0).to_physical::<u32>(scale);
    // rust: let _ = w.request_inner_size(small);
    // rust: let at = m.position();
    // rust: w.set_outer_position(winit::dpi::PhysicalPosition::new(
    // rust: at.x + (screen.width.saturating_sub(small.width) / 2) as i32,
    // rust: at.y + (screen.height.saturating_sub(small.height) / 2) as i32,
    // rust: ));
}
}

    // rust: mod controller_context_tests {
//     use super::detected_controller_style;
//     use horizon_client::{controller_ui::Device, gamepad::GlyphStyle};

detected_style_follows_the_named_device_even_before_it_is_used :: proc() {
}
    // rust: let mut device = Device {
    // rust: name: "pad".into(),
    // rust: vendor: Some(0x054c),
    // rust: product: None,
}
    // rust: assert_eq!(
    // rust: detected_controller_style(Some(&device), GlyphStyle::Xbox),
    // rust: GlyphStyle::PlayStation
    // rust: );
    // rust: device.vendor = Some(0x057e);
    // rust: assert_eq!(
    // rust: detected_controller_style(Some(&device), GlyphStyle::PlayStation),
    // rust: GlyphStyle::Nintendo
    // rust: );
    // rust: assert_eq!(
    // rust: detected_controller_style(None, GlyphStyle::PlayStation),
    // rust: GlyphStyle::PlayStation
    // rust: );
}
}
