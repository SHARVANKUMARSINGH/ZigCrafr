//! Transpiled from Horizon Rust crate
//! Module: horizon-client_startup_menu
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The interactive title before world resources exist. Uses only the menu
//! atlas/panorama; transfers the actual screen and queued entry to Game.
// use super::event_loop::EventLoopCtl;
// use super::key_focus::{self, Act};
// use super::*;
// use horizon_client::{
    // rust: clipboard::{self, AppendSelection, SystemClipboard},
    // rust: options_ui::{Event, OptionsUi, Page},
    // rust: widgets::{Kind, Target},
}
// use winit::{event::KeyEvent, keyboard::ModifiersState};

    // rust: pub(super) struct StartupMenu {
    // rust: title: Option<Title>,
    // rust: options: OptionsUi,
    // rust: options_open: bool,
    /// The credits from Credits & Attribution, and their last frame.
    // rust: win: Option<(horizon_client::win_screen::WinScreen, Instant)>,
    // rust: root: PathBuf,
    // rust: cursor: (f32, f32),
    // rust: pointer: (f64, f64),
    // rust: modifiers: ModifiersState,
    // rust: physical_keys: HashSet<KeyCode>,
    // rust: dragging: bool,
    // rust: clipboard: SystemClipboard,
    // rust: selection: AppendSelection,
    /// The narrator's `NARRATOR_TOGGLE` toast, handed to the game with the title.
    // rust: narrator_toast: Option<horizon_client::toasts::SystemToast>,
    /// The screens' narration, handed to the game with the title (which
    /// stays the screen already opened).
    // rust: narration: horizon_client::screen_narrator::ScreenNarrator,
    /// Frames drawn, for `widgets::end_frame`.
    // rust: frames: u64,
    /// The keyboard's focus (`key_focus`: Tab, the arrows, Enter); the
    /// pointer sits on it, as in the game.
    // rust: key_focus: Option<Target>,
    /// The focused slider's arrows change its value (`canChangeValue`).
    // rust: key_slider_edit: bool,
    /// What the last click landed on, for the next Tab or arrow.
    // rust: key_origin: Option<[f32; 4]>,
    /// The focused slider being nudged and where the keyboard put its handle.
    // rust: key_nudge: Option<([f32; 4], f32)>,
    /// A click the keyboard sends is being handled.
    // rust: key_synthetic: bool,
    /// The screen the keyboard's focus is on (`key_screen`).
    // rust: key_screen: u64,
    // rust: pub pending: Option<PendingWorldEntry>,
    // rust: pub reload_packs: bool,
    /// Browse mods' worker (`mod_browser`).
    // rust: mod_jobs: super::mod_browser::Jobs,
    // rust: pub perf: horizon_client::telemetry::Session,
}

    // rust: impl StartupMenu {
pub fn new(options: *Options, pack_error: ?[]const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pending = if let Some(address) = &options.server {
    // rust: Some(PendingWorldEntry::Server {
    // rust: address: address.clone(),
    // rust: name: options.player_name(),
    // rust: cookies: None,
    // rust: lan: false,
    // rust: })
    // rust: } else {
    // rust: options
    // rust: .world
    // rust: .as_ref()
    // rust: .map(|folder| PendingWorldEntry::Local {
    // rust: folder: folder.clone(),
    // rust: name: None,
    // rust: seed: Some(options.seed),
    // rust: creative: options.creative,
    // rust: create: None,
    // rust: })
}
    // rust: let mut menu = Self {
    // rust: pending,
    // rust: ..Default::default()
}
    // rust: menu.root = options.resources.clone();
    // rust: if let Some(error) = pack_error {
    // rust: menu.options.open_at(false, Page::Packs);
    // rust: menu.options.resource_error = Some(error.to_owned());
    // rust: menu.options_open = true;
}
    // rust: if menu.pending.is_some() {
    // rust: menu.perf.world_opening();
}
    // rust: Ok(menu)
}

    // rust: pub(super) fn set_root(&mut self, root: PathBuf, settings: &Settings) {
    // rust: horizon_client::ui::load_metadata(&root);
    // rust: horizon_client::lang::set(horizon_client::lang::Language::load(
    // rust: &[&root],
    // rust: &settings.language,
    // rust: ));
    // rust: self.root = root;
    // rust: if self.title.is_none() {
    // rust: let mut title = Title::new(
    // rust: std::env::current_dir().unwrap_or_default().join("saves"),
    // rust: &self.root,
    // rust: );
    // rust: title.last_server = settings.file.string("lastServer");
    // rust: title.skip_multiplayer_warning = settings.file.bool("skipMultiplayerWarning");
            // Gui.addInitialScreens: the accessibility onboarding comes first.
    // rust: if settings.file.bool("onboardAccessibility") {
    // rust: title.start_onboarding();
}
    // rust: self.title = Some(title);
}
}

    // rust: pub(super) fn handoff(&mut self, game: &mut Game<'_>) {
    // rust: game.title = self
    // rust: .title
    // rust: .take()
    // rust: .map(|title| title.with_user(|| game.options.player_name()));
    // rust: game.pending_entry = self.pending.take();
    // rust: game.cursor = self.cursor;
    // rust: game.modifiers = self.modifiers;
    // rust: game.physical_keys = std::mem::take(&mut self.physical_keys);
    // rust: game.clipboard = std::mem::take(&mut self.clipboard);
    // rust: game.text_selection = std::mem::take(&mut self.selection);
    // rust: game.perf = std::mem::take(&mut self.perf);
    // rust: game.narrator_toast = self.narrator_toast.take();
    // rust: game.narration = std::mem::take(&mut self.narration);
        // Preserve an existing resource-error screen opened by start_game.
    // rust: if self.options_open {
    // rust: let resource_error = game.ui.options.resource_error.take();
    // rust: game.ui.options = std::mem::take(&mut self.options);
    // rust: game.ui.options.resource_error =
    // rust: game.ui.options.resource_error.take().or(resource_error);
    // rust: game.screen = Screen::Options;
    // rust: game.options_from_title = true;
    // rust: game.dragging = self.dragging;
}
    // rust: if let Some(focus) = self.key_focus.take() {
    // rust: game.key_focus_adopt(focus, self.key_slider_edit);
}
}

    /// After a frame is drawn: its widgets become the last frame's, and the
    /// open screen's narration reads them (`Gui.update`'s
    /// `handleDelayedNarration`). `gui` is the GUI size.
    // rust: pub(super) fn frame_drawn(&mut self, gui: (f32, f32)) {
    // rust: self.frames += 1;
    // rust: horizon_client::widgets::end_frame(self.frames);
        // The keyboard's focus follows its widget, or starts again on a new
        // screen.
    // rust: if let Some(focus) = self.key_focus {
    // rust: let targets = key_focus::keyboard_targets(
    // rust: key_focus::on_screen(key_focus::drawn_targets(), gui),
    // rust: false,
    // rust: );
    // rust: let screen = self.key_screen();
    // rust: self.key_focus = if screen == self.key_screen {
    // rust: key_focus::follow(focus, &targets)
    // rust: } else {
                // Screen.setInitialFocus: a forward Tab from nothing.
    // rust: self.key_screen = screen;
    // rust: key_focus::tab_step(&targets, None, true).map(|i| targets[i])
}
    // rust: if let Some(now) = self.key_focus
    // rust: && now.rect != focus.rect
    // rust: {
    // rust: self.cursor = now.center();
    // rust: self.key_nudge = None;
}
}
    // rust: self.narration
    // rust: .frame(gui, self.cursor, self.key_focus.map(|t| t.rect));
}

    /// Which screen is open, as far as the keyboard's focus cares.
pub fn key_screen(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::hash::{Hash, Hasher};
    // rust: let mut hasher = std::collections::hash_map::DefaultHasher::new();
    // rust: (self.options_open, self.win.is_some()).hash(&mut hasher);
    // rust: std::mem::discriminant(&self.options.page()).hash(&mut hasher);
    // rust: self.title.as_ref().map(Title::screen_key).hash(&mut hasher);
    // rust: hasher.finish()
}

    /// The keyboard lets go of the focus (the real mouse is used): it stays
    /// where the next Tab or arrow goes on from. Whether it had it.
pub fn key_focus_release(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(focus) = self.key_focus.take() else {
    // rust: return false;
}
    // rust: self.key_origin = Some(focus.rect);
    // rust: self.key_nudge = None;
    // rust: true
}

pub fn queue_entry(self: *Self, action: Action, player_name: []const u8) void {
}
    // rust: let entry = match action {
    // rust: Action::Play { folder } => PendingWorldEntry::Local {
    // rust: folder,
    // rust: name: None,
    // rust: seed: None,
    // rust: creative: false,
    // rust: create: None,
    // rust: },
    // rust: Action::Create {
    // rust: folder,
    // rust: name,
    // rust: seed,
    // rust: creative,
    // rust: options,
    // rust: } => PendingWorldEntry::Local {
    // rust: folder,
    // rust: name: Some(name),
    // rust: seed,
    // rust: creative,
    // rust: create: Some(Box::new(options)),
    // rust: },
    // rust: Action::Connect { address, lan } => PendingWorldEntry::Server {
    // rust: address,
    // rust: name: player_name,
    // rust: cookies: None,
    // rust: lan,
    // rust: },
    // rust: _ => return,
}
    // rust: self.pending = Some(entry);
    // rust: self.perf.world_opening();
}

pub fn shortcut(self: *Self, event: *KeyEvent) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let edit = if cfg!(target_os = "macos") {
    // rust: self.modifiers.super_key()
    // rust: } else {
    // rust: self.modifiers.control_key()
}
    // rust: clipboard::edit_shortcut(
    // rust: clipboard::shortcut_letter(&event.logical_key, event.physical_key),
    // rust: edit,
    // rust: self.modifiers.shift_key(),
    // rust: self.modifiers.alt_key(),
    // rust: )
}

    /// `Screen.keyPressed` on the title screens: the action a key starts (Enter confirms, see `confirm_key` in title.rs).
pub fn title_key(self: *Self, event: *KeyEvent, viewport: (f32) void {
}
    // rust: let shortcut = self.shortcut(event);
    // rust: let Some(title) = &mut self.title else {
    // rust: return Action::None;
}
    // rust: if let Some(shortcut) = shortcut {
    // rust: if title.has_caret_field() {
    // rust: title.field_shortcut(shortcut, &mut self.clipboard);
    // rust: } else if let Some((id, value, max)) = title.focused_field()
    // rust: && self
    // rust: .selection
    // rust: .apply(id, value, shortcut, &mut self.clipboard, |v, t| {
    // rust: clipboard::append_limited(v, t, max)
    // rust: })
    // rust: {
    // rust: title.search_changed();
}
    // rust: return Action::None;
}
        // `TabNavigationBar.keyPressed` comes before the open tab's own
        // widgets: Ctrl plus a digit or Tab picks a tab instead of reaching
        // them.
    // rust: let ctrl = if cfg!(target_os = "macos") {
    // rust: self.modifiers.super_key()
    // rust: } else {
    // rust: self.modifiers.control_key()
}
    // rust: if let PhysicalKey::Code(key) = event.physical_key
    // rust: && title
    // rust: .tab_bar_key(key, ctrl, self.modifiers.shift_key())
    // rust: .is_some()
    // rust: {
    // rust: return Action::None;
}
    // rust: match event.physical_key {
    // rust: PhysicalKey::Code(KeyCode::Escape) => title.escape(),
    // rust: PhysicalKey::Code(KeyCode::F5) => title.refresh_servers(),
    // rust: PhysicalKey::Code(KeyCode::Tab) => {
    // rust: title.tab_dir(self.modifiers.shift_key(), viewport);
}
    // rust: PhysicalKey::Code(KeyCode::Enter | KeyCode::NumpadEnter) => {
    // rust: return title.confirm_key_size(viewport).0;
}
    // rust: PhysicalKey::Code(KeyCode::Space)
    // rust: if !title.has_caret_field()
    // rust: && (title.list_focused() || title.focused_button.is_some()) =>
    // rust: {
    // rust: return title.confirm_key_size(viewport).0;
}
    // rust: PhysicalKey::Code(
    // rust: key @ (KeyCode::Backspace
    // rust: | KeyCode::Delete
    // rust: | KeyCode::ArrowLeft
    // rust: | KeyCode::ArrowRight
    // rust: | KeyCode::Home
    // rust: | KeyCode::End),
    // rust: ) if title.has_caret_field() => {
    // rust: title.field_key(
    // rust: key,
    // rust: self.modifiers.control_key(),
    // rust: self.modifiers.shift_key(),
    // rust: );
}
    // rust: PhysicalKey::Code(
    // rust: key @ (KeyCode::ArrowLeft
    // rust: | KeyCode::ArrowRight
    // rust: | KeyCode::ArrowUp
    // rust: | KeyCode::ArrowDown),
    // rust: ) => {
    // rust: title.arrow_key(key, viewport, self.modifiers.shift_key());
}
    // rust: _ => {
    // rust: let cleared = !title.has_caret_field()
    // rust: && title
    // rust: .focused_field()
    // rust: .is_some_and(|(id, value, _)| self.selection.take(id, value));
    // rust: if cleared {
    // rust: title.search_changed();
}
    // rust: if event.physical_key == PhysicalKey::Code(KeyCode::Backspace) {
    // rust: if !cleared {
    // rust: title.backspace();
}
    // rust: } else if let Some(text) = &event.text {
    // rust: title.type_text(text);
}
}
}
    // rust: Action::None
}
}

/// A panic's message: its `&str` or `String` payload.
pub fn panic_text(payload: *(dyn std::any::Any + Send) void {
}
    // rust: payload
    // rust: .downcast_ref::<&str>()
    // rust: .copied()
    // rust: .or_else(|| payload.downcast_ref::<String>().map(String::as_str))
    // rust: .unwrap_or("Box<dyn Any>")
}

/// Each generation has its own channel and progress. Pack changes wait for the
/// old tail before starting another generation, including cache/global writes.
    // rust: pub(super) fn spawn_loader(
    // rust: options: &Options,
    // rust: settings: &Settings,
    // rust: vanilla_root: &std::path::Path,
    // rust: started: Instant,
    // rust: progress: &Progress,
    // rust: ) -> Result<(Receiver<LoaderMsg>, JoinHandle<()>)> {
    // rust: let (sender, receiver) = std::sync::mpsc::channel();
    // rust: let settings = settings.clone();
    // rust: let vanilla_root = vanilla_root.to_path_buf();
    // rust: let dev_mods = options.dev_mods.clone();
    // rust: let world = launch_world(options).map(str::to_owned);
    // rust: let progress = progress.clone();
    // rust: let handle = std::thread::Builder::new()
    // rust: .name("resource-loader".into())
    // rust: .spawn(move || {
    // rust: let mut pack_error = None;
    // rust: let root = packs::startup_root(&vanilla_root, &settings.resource_packs, &[])
    // rust: .unwrap_or_else(|error| {
    // rust: pack_error = Some(error.to_string());
    // rust: vanilla_root.clone()
    // rust: });
    // rust: let root = mods::content_root(&root, &settings.mods.enabled, &dev_mods);
    // rust: let result = load_resources(
    // rust: root,
    // rust: world.as_deref(),
    // rust: &vanilla_root,
    // rust: &settings,
    // rust: started,
    // rust: true,
    // rust: false,
    // rust: &progress,
    // rust: &mut |gui, root| {
    // rust: let _ = sender.send(LoaderMsg::Ui(gui, root.to_path_buf()));
    // rust: },
    // rust: )
    // rust: .map(|mut loaded| {
    // rust: loaded.pack_error = loaded.pack_error.or(pack_error);
    // rust: loaded
    // rust: })
    // rust: .map_err(|error| error.to_string());
    // rust: let _ = sender.send(LoaderMsg::Done(result));
    // rust: })?;
    // rust: Ok((receiver, handle))
}

    // rust: impl Loading {
    // rust: pub(super) fn poll_menu_resources(&mut self) -> Result<()> {
        // Once `Done` arrived the generation is over: the caller may have taken
        // its result, and the finished loader's channel is closed.
    // rust: if self.loaded.is_none() && !self.delivered {
    // rust: loop {
    // rust: match self.receiver.try_recv() {
    // rust: Ok(LoaderMsg::Ui(gui, root)) => self.set_ui(gui, root),
    // rust: Ok(LoaderMsg::Done(result)) => {
    // rust: self.loaded = Some(result);
    // rust: self.delivered = true;
    // rust: break;
}
    // rust: Err(TryRecvError::Empty) => break,
    // rust: Err(TryRecvError::Disconnected) => {
                        // The loader sends `Done` before it returns: it panicked.
    // rust: let reason = match self.handle.take().map(JoinHandle::join) {
    // rust: Some(Err(payload)) => panic_text(payload.as_ref()).to_owned(),
    // rust: Some(Ok(())) => "it returned without a result".into(),
    // rust: None => "no loader thread was running".into(),
}
    // rust: return Err(
    // rust: format!("resource loader stopped before finishing: {reason}").into(),
    // rust: );
}
}
}
}
    // rust: self.drive_menu_mod_browser();
    // rust: self.restart_menu_resources()
}
    /// The startup menu's Browse mods, as `Game::drive_mod_browser`.
pub fn drive_menu_mod_browser(self: *Self) void {
}
    // rust: let menu = &mut self.menu;
    // rust: if menu
    // rust: .mod_jobs
    // rust: .poll(&mut menu.options.mod_browser, &mut self.settings.mods)
    // rust: {
    // rust: self.settings.save(&Game::options_path());
}
}
    // rust: pub(super) fn apply_menu_settings(&mut self) {
    // rust: if let Some(renderer) = &mut self.renderer {
    // rust: renderer.gamma = self.settings.gamma;
    // rust: renderer.set_present_mode(self.settings.vsync, self.settings.horizon.present_mode);
}
    // rust: horizon_client::hud::GUI_SCALE.store(self.settings.gui_scale, Ordering::Relaxed);
    // rust: super::narrator::sync(&self.settings);
    // rust: if let Some(gui) = &mut self.gui {
    // rust: gui.atlas.font.uniform = self.settings.force_unicode;
    // rust: gui.atlas.font.japanese = self.settings.japanese_glyphs;
}
    // rust: if let Some(window) = self.window.clone() {
    // rust: let monitor = window
    // rust: .current_monitor()
    // rust: .or_else(|| window.primary_monitor());
    // rust: if let Some(modes) = self
    // rust: .video_modes
    // rust: .refresh(monitor, horizon_client::window::monitor_video_modes)
    // rust: {
    // rust: self.settings.video_modes = modes;
}
    // rust: let preferred = self
    // rust: .settings
    // rust: .file
    // rust: .fullscreen_resolution
    // rust: .as_deref()
    // rust: .and_then(horizon_client::window::VideoMode::read);
    // rust: self.fullscreen.apply(
    // rust: &window,
    // rust: self.settings.fullscreen,
    // rust: self.settings.file.bool("exclusiveFullscreen"),
    // rust: preferred,
    // rust: false,
    // rust: );
}
    // rust: self.update_menu_cursor();
}

pub fn update_menu_cursor(self: *Self) void {
}
    // rust: let batch = HudBatch::new(self.menu_size());
    // rust: self.menu.cursor = (
    // rust: self.menu.pointer.0 as f32 / batch.scale,
    // rust: self.menu.pointer.1 as f32 / batch.scale,
    // rust: );
}

pub fn menu_size(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.renderer
    // rust: .as_ref()
    // rust: .map_or([1280, 720], |r| [r.config.width, r.config.height])
}

pub fn save_menu_address(self: *Self) void {
}
    // rust: if self.menu.title.as_ref().is_some_and(|title| {
    // rust: title.last_server != self.settings.file.string("lastServer")
    // rust: || title.skip_multiplayer_warning
    // rust: != self.settings.file.bool("skipMultiplayerWarning")
    // rust: }) {
    // rust: self.save_menu_settings();
}
}

pub fn save_menu_settings(self: *Self) void {
}
    // rust: if let Some(title) = &self.menu.title {
    // rust: self.settings.file.set(
    // rust: "lastServer",
    // rust: horizon_client::options_file::V::Str(title.last_server.clone()),
    // rust: );
    // rust: self.settings.file.set(
    // rust: "skipMultiplayerWarning",
    // rust: horizon_client::options_file::V::Bool(title.skip_multiplayer_warning),
    // rust: );
}
    // rust: self.settings.save(&Game::options_path());
}

pub fn open_menu_options(self: *Self, page: Page) void {
}
    // rust: self.menu.options.open_at(false, page);
    // rust: self.menu.options.languages = horizon_client::lang::available(&[&self.menu.root]);
    // rust: self.menu.options.pack_infos = packs::pack_infos(&self.vanilla_root, &[]);
    // rust: self.menu.options.pack_selection = self.settings.resource_packs.clone();
    // rust: self.menu.options.pack_screen = None;
    // rust: self.menu.options_open = true;
}

pub fn menu_option_events(self: *Self, events: std.ArrayList(Event)) void {
}
    // rust: for event in events {
    // rust: match event {
    // rust: Event::Changed => {
    // rust: self.save_menu_settings();
    // rust: self.apply_menu_settings();
}
    // rust: Event::SliderDrag => {
    // rust: self.apply_menu_settings();
}
    // rust: Event::Close if self.menu.options.resource_error.is_some() => {}
    // rust: Event::Close => {
    // rust: self.menu.options_open = false;
    // rust: self.menu.dragging = false;
    // rust: self.save_menu_settings();
}
    // rust: Event::Language(code) => {
    // rust: horizon_client::lang::set(horizon_client::lang::Language::load(
    // rust: &[&self.menu.root],
    // rust: &code,
    // rust: ));
    // rust: self.save_menu_settings();
}
    // rust: Event::Packs(_) => {
    // rust: self.save_menu_settings();
    // rust: self.menu.reload_packs = true;
}
    // rust: Event::OpenPackFolder => {
    // rust: let dir = packs::packs_dir();
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: packs::open_folder(&dir);
}
    // rust: Event::DownloadPack(i) => {
    // rust: let dir = packs::packs_dir();
    // rust: if let Some(screen) = &mut self.menu.options.pack_screen
    // rust: && let Some(browser) = &mut screen.browser
    // rust: {
    // rust: browser.download(i, &dir, horizon_core::VANILLA_VERSION);
}
}
    // rust: Event::DataPacks(ids) => {
    // rust: let resources = self.vanilla_root.clone();
    // rust: if let Some(title) = &mut self.menu.title {
    // rust: title.offer_data_packs(&resources, ids);
}
}
    // rust: Event::OpenDataPackFolder(dir) => {
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: packs::open_folder(&dir);
}
    // rust: Event::OpenModFolder => {
    // rust: let dir = Game::game_dir().join(horizon_client::mod_list::DIR);
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: packs::open_folder(&dir);
}
    // rust: Event::BrowseMods => {
    // rust: let ui = &mut self.menu.options.mod_browser;
    // rust: self.menu.mod_jobs.browse(ui, Game::game_dir());
}
    // rust: Event::InstallMod(id) => {
    // rust: let ui = &mut self.menu.options.mod_browser;
    // rust: self.menu.mod_jobs.install(ui, Game::game_dir(), id);
}
    // rust: Event::OpenModPage(url) => packs::open_uri(&url),
    // rust: Event::ListShaderPacks => {
    // rust: self.settings.shader_packs =
    // rust: horizon_client::shader_pack_list::scan(&Game::shader_packs_dir());
}
    // rust: Event::ShaderPack => self.save_menu_settings(),
    // rust: Event::OpenShaderOptions => {
    // rust: self.settings.shader_options = super::shader_packs::read_shader_options(
    // rust: &self.settings.horizon.shader_pack,
    // rust: &self.settings.language,
    // rust: &horizon_shaders::Macros::standard(),
    // rust: );
}
    // rust: Event::ShaderOptions => {
    // rust: if let Some(options) = self.settings.shader_options.take() {
    // rust: super::shader_packs::write_shader_options(&options);
}
}
    // rust: Event::NativePackOptions(i) => {
    // rust: if let Some(pack) = self.settings.shader_packs.get(i) {
    // rust: pack.save_values(&Game::shader_packs_dir());
}
}
    // rust: Event::OpenShaderPackFolder => {
    // rust: let dir = Game::shader_packs_dir();
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: packs::open_folder(&dir);
}
    // rust: Event::Credits => {
    // rust: if let Some(gui) = &self.gui {
    // rust: let name = self.options.as_ref().map_or_else(
    // rust: || horizon_client::offline_name::generate(0),
    // rust: Options::player_name,
    // rust: );
    // rust: let screen = horizon_client::win_screen::WinScreen::new(
    // rust: false,
    // rust: &self.menu.root,
    // rust: &name,
    // rust: &gui.atlas.font,
    // rust: );
    // rust: self.menu.win = Some((screen, Instant::now()));
}
}
    // rust: Event::Narrator => super::narrator::update_status(
    // rust: self.settings.narrator(),
    // rust: &mut self.menu.narrator_toast,
    // rust: ),
                // The startup menu has no screen stack for ConfirmLinkScreen;
                // the link opens directly, as the menu's other links do.
    // rust: Event::AccessibilityHelp => {
    // rust: super::packs::open_uri(super::options::ACCESSIBILITY_HELP_LINK)
}
                // Mods' settings pages open only in a running game.
                // The HUD editor needs a world: its button is inactive here.
    // rust: Event::NativeSettings(_) | Event::NativeButton(..) | Event::HudEditor => {}
                // The startup menu runs before the game opens a control socket,
                // and before its sound engine (no clicks, no volume previews,
                // and no music tracks to list or play).
    // rust: Event::ButtonClick
    // rust: | Event::CopyAgentDetails
    // rust: | Event::ToggleRecording
    // rust: | Event::ExportRepro
    // rust: | Event::ListMusicTracks
    // rust: | Event::PlayMusicTrack(..)
    // rust: | Event::Volume(..) => {}
    // rust: Event::OpenStudioFolder => {
    // rust: let dir = std::path::PathBuf::from("recordings");
    // rust: let _ = std::fs::create_dir_all(&dir);
    // rust: packs::open_folder(&dir);
}
}
}
}

    /// `Game::narrator_hotkey` on the startup menu's screens.
pub fn menu_narrator_hotkey(self: *Self, event: *KeyEvent) void {
}
    // rust: let letter = clipboard::shortcut_letter(&event.logical_key, event.physical_key);
    // rust: if letter != Some('b') {
    // rust: return;
}
    // rust: let menu = &mut self.menu;
    // rust: let control_with_quirk = if cfg!(target_os = "macos") {
    // rust: menu.modifiers.super_key()
    // rust: } else {
    // rust: menu.modifiers.control_key()
}
    // rust: let edit_box_focused = if menu.options_open {
    // rust: menu.options.typing()
    // rust: } else if menu.win.is_some() || menu.pending.is_some() {
    // rust: false
    // rust: } else {
    // rust: menu.title
    // rust: .as_mut()
    // rust: .is_some_and(|t| t.has_caret_field() || t.focused_field().is_some())
}
    // rust: let hotkey = super::narrator::is_hotkey(
    // rust: event.state == ElementState::Pressed,
    // rust: control_with_quirk,
    // rust: letter,
    // rust: edit_box_focused,
    // rust: horizon_narrator::is_active(),
    // rust: self.settings.file.bool("narratorHotkey"),
    // rust: );
    // rust: if !hotkey {
    // rust: return;
}
    // rust: let was_disabled = super::narrator::cycle_status(&mut self.settings);
    // rust: super::narrator::update_status(self.settings.narrator(), &mut self.menu.narrator_toast);
    // rust: self.save_menu_settings();
    // rust: self.menu
    // rust: .narration
    // rust: .status_changed(was_disabled, horizon_narrator::screen::Trigger::Keyboard);
}

pub fn menu_options_click(self: *Self, drag: bool, right: bool) void {
}
    // rust: let size = self.menu_size();
    // rust: let batch = HudBatch::new(size);
    // rust: let Some(gui) = &self.gui else { return };
    // rust: self.menu.options.shift = self.menu.modifiers.shift_key();
    // rust: let events = self.menu.options.click(
    // rust: &mut self.settings,
    // rust: &gui.atlas,
    // rust: self.menu.cursor.0,
    // rust: self.menu.cursor.1,
    // rust: (batch.width, batch.height),
    // rust: [size[0] as i32, size[1] as i32],
    // rust: drag,
    // rust: right,
    // rust: );
    // rust: self.menu_option_events(events);
}

    /// The Realms screen's join, once its address came back: queued like a click on a server.
    // rust: pub(super) fn poll_menu_realms(&mut self, event_loop: &dyn EventLoopCtl) {
    // rust: if let Some(action) = self
    // rust: .menu
    // rust: .title
    // rust: .as_mut()
    // rust: .and_then(Title::take_connect_request)
    // rust: {
    // rust: self.menu_action(event_loop, action);
}
}

pub fn menu_action(self: *Self, event_loop: *dyn EventLoopCtl, action: Action) void {
}
    // rust: match action {
    // rust: Action::Quit => event_loop.exit(),
    // rust: Action::Options => self.open_menu_options(Page::Main),
    // rust: Action::Accessibility => self.open_menu_options(Page::Accessibility),
    // rust: Action::Language => self.open_menu_options(Page::Language),
    // rust: Action::Sounds => self.open_menu_options(Page::Sound),
    // rust: Action::Credits => self.open_menu_options(Page::Credits),
    // rust: Action::OpenUri(uri) => super::packs::open_uri(&uri),
    // rust: Action::CopyText(text) => {
//                 use horizon_client::clipboard::Clipboard;
    // rust: self.menu.clipboard.set(&text);
}
    // rust: Action::DataPacks { dir, selected } => {
    // rust: let resources = self.vanilla_root.clone();
    // rust: self.menu.options.open_data_packs(dir, selected, resources);
    // rust: self.menu.options_open = true;
}
    // rust: action => {
    // rust: let name = self
    // rust: .options
    // rust: .as_ref()
    // rust: .map_or_else(|| "Player".into(), |o| o.player_name());
    // rust: self.menu.queue_entry(action, name);
}
}
    // rust: self.save_menu_address();
}

    /// The real mouse before the screen takes it: a move, a press or a
    /// scroll hands the pointer back from the keyboard (a press or a scroll
    /// where the mouse left it), and a left press focuses what it lands on.
pub fn menu_key_focus_mouse(self: *Self, event: *WindowEvent) void {
}
    // rust: match event {
    // rust: WindowEvent::CursorMoved { .. } => {
    // rust: self.menu.key_focus_release();
}
    // rust: WindowEvent::MouseInput { state, button, .. } => {
    // rust: if self.menu.key_focus_release() {
    // rust: self.update_menu_cursor();
}
    // rust: if *state == ElementState::Pressed && *button == MouseButton::Left {
    // rust: let (cx, cy) = self.menu.cursor;
    // rust: self.menu.key_origin = self
    // rust: .menu_key_targets()
    // rust: .into_iter()
    // rust: .find(|t| {
    // rust: let [x, y, w, h] = t.rect;
    // rust: cx >= x && cy >= y && cx < x + w && cy < y + h
    // rust: })
    // rust: .map(|t| t.rect);
}
}
    // rust: WindowEvent::MouseWheel { .. } if self.menu.key_focus_release() => {
    // rust: self.update_menu_cursor();
}
    // rust: _ => {}
}
}

    /// What the keyboard can focus on the screen last drawn.
pub fn menu_key_targets(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let batch = HudBatch::new(self.menu_size());
    // rust: key_focus::keyboard_targets(
    // rust: key_focus::on_screen(key_focus::drawn_targets(), (batch.width, batch.height)),
    // rust: false,
    // rust: )
}

    /// `Screen.keyPressed`'s focus navigation on the title shown while
    /// resources load, as `Game::key_focus_key` does it in the game (the
    /// pointer sits on the focus; a step past a list's visible rows doesn't
    /// scroll it here). Whether the key was used.
pub fn menu_key_focus(self: *Self, event_loop: *dyn EventLoopCtl, key: KeyCode) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(nav) = key_focus::nav_of(key, self.menu.modifiers.shift_key()) else {
    // rust: return false;
}
    // rust: let options = &self.menu.options;
    // rust: if self.gui.is_none()
    // rust: || self.menu.pending.is_some()
    // rust: || self.menu.win.is_some()
    // rust: || (self.menu.options_open
    // rust: && (options.selected_key.is_some() || options.selected_pad_action.is_some()))
    // rust: {
    // rust: return false;
}
    // rust: let targets = self.menu_key_targets();
    // rust: if targets.is_empty() {
    // rust: return false;
}
    // rust: let find = |rect: [f32; 4]| {
    // rust: targets
    // rust: .iter()
    // rust: .find(|t| t.rect.iter().zip(rect).all(|(a, b)| (a - b).abs() < 0.5))
    // rust: .copied()
}
    // rust: let mut slider_edit = self.menu.key_slider_edit;
    // rust: let mut focus = self.menu.key_focus.and_then(|f| find(f.rect));
    // rust: if focus.is_none()
    // rust: && let Some(clicked) = self.menu.key_origin.and_then(find)
    // rust: {
    // rust: focus = Some(clicked);
    // rust: slider_edit = true;
}
    // rust: let (typing, rows_take_enter) = if self.menu.options_open {
    // rust: (self.menu.options.typing(), false)
    // rust: } else if let Some(title) = &mut self.menu.title {
    // rust: (
    // rust: title.has_caret_field() || title.focused_field().is_some(),
    // rust: title.list_focused(),
    // rust: )
    // rust: } else {
    // rust: (false, false)
}
    // rust: let batch = HudBatch::new(self.menu_size());
    // rust: let ctx = key_focus::Context {
    // rust: slider_edit,
    // rust: typing,
    // rust: rows_take_enter,
    // rust: gui: (batch.width, batch.height),
}
    // rust: let act = key_focus::act(nav, focus, &targets, ctx);
    // rust: if act == Act::Pass {
    // rust: return false;
}
    // rust: if self.menu.key_focus.is_none() {
    // rust: self.menu.key_screen = self.menu.key_screen();
}
    // rust: self.menu.key_origin = None;
    // rust: self.menu.key_focus = focus;
    // rust: self.menu.key_slider_edit = slider_edit;
    // rust: match (act, focus) {
    // rust: (Act::Focus(i), _) => {
    // rust: self.menu_key_focus_on(event_loop, targets[i]);
    // rust: self.menu.key_slider_edit = key_focus::slider_edit_on_focus(nav);
}
    // rust: (Act::Step(button), Some(focus)) => {
    // rust: let rects: Vec<[f32; 4]> = targets.iter().map(|t| t.rect).collect();
    // rust: if let Some(i) =
    // rust: horizon_client::gamepad::focus_step_rect(focus.rect, button, &rects)
    // rust: {
    // rust: self.menu_key_focus_on(event_loop, targets[i]);
}
}
    // rust: (Act::Press, Some(focus)) => self.menu_key_click(event_loop, focus.center()),
    // rust: (Act::ToggleSlider, _) => self.menu.key_slider_edit = !slider_edit,
    // rust: (
    // rust: Act::Nudge(sign),
    // rust: Some(
    // rust: focus @ Target {
    // rust: kind: Kind::Slider { value, track },
    // rust: ..
    // rust: },
    // rust: ),
    // rust: ) => {
    // rust: let from = match self.menu.key_nudge {
    // rust: Some((rect, x)) if rect == focus.rect => x,
    // rust: _ => horizon_client::gamepad::slider_x(track, value),
}
    // rust: let x = (from + sign).clamp(track[0], track[0] + track[1]);
    // rust: self.menu.key_nudge = Some((focus.rect, x));
    // rust: self.menu_key_click(event_loop, (x, focus.center().1));
}
    // rust: _ => {}
}
    // rust: if let Some(Target {
    // rust: kind: Kind::Slider { .. },
    // rust: ..
    // rust: }) = self.menu.key_focus
    // rust: {
//             use horizon_client::screen_narrator::InputType;
    // rust: self.menu.narration.set_input(if self.menu.key_slider_edit {
    // rust: InputType::KeyboardTab
    // rust: } else {
    // rust: InputType::KeyboardArrow
    // rust: });
}
    // rust: true
}

    /// The keyboard's focus lands on `target`, the pointer with it (see
    /// `Game::key_focus_landed`).
pub fn menu_key_focus_on(self: *Self, event_loop: *dyn EventLoopCtl, target: Target) void {
}
    // rust: let left = self.menu.key_focus.replace(target);
    // rust: self.menu.key_nudge = None;
    // rust: self.menu.key_slider_edit = false;
    // rust: self.menu.cursor = target.center();
    // rust: if left.is_some_and(|l| l.rect == target.rect) {
    // rust: return;
}
    // rust: if left.is_some_and(|l| l.kind == Kind::Field)
    // rust: && target.kind != Kind::Field
    // rust: && !self.menu.options_open
    // rust: && let Some(title) = &mut self.menu.title
    // rust: {
    // rust: title.blur_field();
}
    // rust: match target.kind {
    // rust: Kind::Field => self.menu_key_click(event_loop, key_focus::field_click(target.rect)),
    // rust: Kind::Row if !self.menu.options_open => {
    // rust: let batch = HudBatch::new(self.menu_size());
    // rust: if let Some(title) = &mut self.menu.title {
    // rust: title.focus_world_row(target.center(), (batch.width, batch.height));
}
}
    // rust: _ => {}
}
}

    /// A left click at `at` (GUI pixels), the pointer staying there.
pub fn menu_key_click(self: *Self, event_loop: *dyn EventLoopCtl, at: (f32) void {
}
    // rust: self.menu.cursor = at;
    // rust: let was = std::mem::replace(&mut self.menu.key_synthetic, true);
    // rust: for state in [ElementState::Pressed, ElementState::Released] {
    // rust: let click = WindowEvent::MouseInput {
    // rust: device_id: DeviceId::dummy(),
    // rust: state,
    // rust: button: MouseButton::Left,
}
    // rust: if let Err(e) = self.menu_event(event_loop, click) {
    // rust: log::warn!("Horizon: keyboard focus click: {e}");
}
}
    // rust: self.menu.key_synthetic = was;
}

    // rust: pub(super) fn menu_event(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: event: WindowEvent,
    // rust: ) -> Result<()> {
    // rust: if let WindowEvent::KeyboardInput { event, .. } = &event
    // rust: && let PhysicalKey::Code(key) = event.physical_key
    // rust: {
    // rust: if event.state == ElementState::Pressed {
    // rust: self.menu.physical_keys.insert(key);
    // rust: } else {
    // rust: self.menu.physical_keys.remove(&key);
}
}
    // rust: if let WindowEvent::KeyboardInput { event, .. } = &event {
    // rust: self.menu_narrator_hotkey(event);
}
        // The real mouse takes the pointer back from the keyboard's focus.
    // rust: let synthetic = self.menu.key_synthetic;
    // rust: if !synthetic {
    // rust: self.menu_key_focus_mouse(&event);
}
        // Fullscreen (F11) is the window's: not the screen's input; the
        // keyboard's own clicks aren't the mouse.
    // rust: let f11 = matches!(&event, WindowEvent::KeyboardInput { event, .. }
    // rust: if event.physical_key == PhysicalKey::Code(KeyCode::F11));
    // rust: if !f11 && !synthetic {
    // rust: super::narrator::narrate_input(&mut self.menu.narration, &event, self.menu.cursor);
}
        // Screen.keyPressed: Tab, the arrows and Enter move and press the
        // focus, unless the focused widget or the screen keeps them.
    // rust: if let WindowEvent::KeyboardInput {
    // rust: event: key_event, ..
    // rust: } = &event
    // rust: && key_event.state == ElementState::Pressed
    // rust: && let PhysicalKey::Code(key) = key_event.physical_key
    // rust: && self.menu_key_focus(event_loop, key)
    // rust: {
    // rust: return Ok(());
}
    // rust: match event {
    // rust: WindowEvent::CloseRequested => {
    // rust: if !self.settings.quit_shortcuts
    // rust: && horizon_client::input::is_quit_shortcut_down(
    // rust: self.menu.modifiers,
    // rust: &self.menu.physical_keys,
    // rust: )
    // rust: {
    // rust: return Ok(());
}
    // rust: self.save_menu_settings();
    // rust: event_loop.exit();
}
    // rust: WindowEvent::Resized(size) => {
    // rust: if let Some(r) = &mut self.renderer {
    // rust: r.resize(size.width, size.height);
}
    // rust: self.apply_menu_settings();
}
    // rust: WindowEvent::RedrawRequested => self.draw(),
    // rust: WindowEvent::ModifiersChanged(modifiers) => self.menu.modifiers = modifiers.state(),
            // `PackSelectionScreen.onFilesDrop`: a pack dropped on the window
            // joins the Create New World screen's data packs.
    // rust: WindowEvent::DroppedFile(path) => {
    // rust: if let Some(title) = &mut self.menu.title {
    // rust: title.drop_file(path);
}
}
    // rust: WindowEvent::Focused(false) => {
    // rust: self.menu.modifiers = ModifiersState::empty();
    // rust: self.menu.physical_keys.clear();
    // rust: self.menu.dragging = false;
    // rust: if let Some(title) = &mut self.menu.title {
    // rust: title.release();
    // rust: title.release_field();
}
    // rust: let events = self.menu.options.release();
    // rust: self.menu_option_events(events);
}
    // rust: WindowEvent::KeyboardInput { event, .. }
    // rust: if event.state == ElementState::Pressed && self.menu.pending.is_some() =>
    // rust: {
    // rust: if event.physical_key == PhysicalKey::Code(KeyCode::Escape) {
    // rust: self.menu.pending = None;
    // rust: self.menu.perf.cancel_world_opening();
}
}
    // rust: _ if self.gui.is_none() || self.menu.pending.is_some() => {}
    // rust: WindowEvent::KeyboardInput { event, .. } if self.menu.win.is_some() => {
    // rust: if let PhysicalKey::Code(code) = event.physical_key {
    // rust: let pressed = event.state == ElementState::Pressed;
    // rust: if code == KeyCode::Escape && pressed {
    // rust: self.menu.win = None;
    // rust: } else if let Some(key) = horizon_client::win_screen::Key::from_code(code)
    // rust: && let Some((win, _)) = &mut self.menu.win
    // rust: {
    // rust: win.key(key, pressed);
}
}
}
    // rust: WindowEvent::MouseInput { .. } | WindowEvent::MouseWheel { .. }
    // rust: if self.menu.win.is_some() => {}
    // rust: WindowEvent::CursorMoved { position, .. } => {
    // rust: self.menu.pointer = (position.x, position.y);
    // rust: self.update_menu_cursor();
    // rust: if self.menu.options_open && self.menu.dragging {
    // rust: self.menu_options_click(true, false);
    // rust: } else if let Some(title) = &mut self.menu.title {
    // rust: let size = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or([1280, 720], |r| [r.config.width, r.config.height]);
    // rust: let b = HudBatch::new(size);
    // rust: title.drag(self.menu.cursor, (b.width, b.height));
    // rust: title.drag_field(&self.gui.as_ref().unwrap().atlas, self.menu.cursor.0);
}
}
    // rust: WindowEvent::MouseInput { state, button, .. } if self.menu.options_open => {
    // rust: if state == ElementState::Pressed && self.menu.options.selected_key.is_some() {
    // rust: let events = self.menu.options.bind_mouse(&mut self.settings, button);
    // rust: self.menu_option_events(events);
    // rust: } else if matches!(button, MouseButton::Left | MouseButton::Right) {
    // rust: if state == ElementState::Pressed {
    // rust: self.menu.dragging = button == MouseButton::Left;
    // rust: self.menu_options_click(false, button == MouseButton::Right);
    // rust: } else if button == MouseButton::Left {
    // rust: self.menu.dragging = false;
    // rust: let events = self.menu.options.release();
    // rust: self.menu_option_events(events);
}
}
}
    // rust: WindowEvent::MouseInput {
    // rust: state,
    // rust: button: MouseButton::Left,
    // rust: ..
    // rust: } => {
    // rust: let batch = HudBatch::new(self.menu_size());
    // rust: if let (Some(title), Some(gui)) = (&mut self.menu.title, &self.gui) {
    // rust: if state == ElementState::Released {
    // rust: title.release();
    // rust: title.release_field();
    // rust: } else {
    // rust: let (action, _) = title.click(
    // rust: self.menu.cursor.0,
    // rust: self.menu.cursor.1,
    // rust: (batch.width, batch.height),
    // rust: );
    // rust: title.press_field(
    // rust: &gui.atlas,
    // rust: self.menu.cursor,
    // rust: (batch.width, batch.height),
    // rust: self.menu.modifiers.shift_key(),
    // rust: );
    // rust: title.press_rules(
    // rust: &gui.atlas,
    // rust: self.menu.cursor,
    // rust: (batch.width, batch.height),
    // rust: );
    // rust: self.menu_action(event_loop, action);
}
}
}
            // AbstractSelectionList.mouseClicked: a world row takes a click
            // of any button, so the middle one selects it without joining.
    // rust: WindowEvent::MouseInput {
    // rust: state: ElementState::Pressed,
    // rust: button: MouseButton::Middle,
    // rust: ..
    // rust: } => {
    // rust: let batch = HudBatch::new(self.menu_size());
    // rust: if let Some(title) = &mut self.menu.title {
    // rust: title.select_world_at(
    // rust: self.menu.cursor.0,
    // rust: self.menu.cursor.1,
    // rust: (batch.width, batch.height),
    // rust: );
}
}
    // rust: WindowEvent::MouseWheel { delta, .. } => {
    // rust: let raw = match delta {
    // rust: MouseScrollDelta::LineDelta(_, y) => y,
    // rust: MouseScrollDelta::PixelDelta(p) => (p.y / 30.0) as f32,
}
    // rust: let amount = if self.settings.discrete_scroll {
    // rust: horizon_client::mouse::java_signum(f64::from(raw)) as f32
    // rust: } else {
    // rust: raw
    // rust: } * self.settings.mouse_wheel_sensitivity;
    // rust: let size = self.menu_size();
    // rust: let batch = HudBatch::new(size);
    // rust: if self.menu.options_open {
    // rust: let events = self.menu.options.wheel(
    // rust: &mut self.settings,
    // rust: (batch.width, batch.height),
    // rust: self.menu.cursor,
    // rust: [size[0] as i32, size[1] as i32],
    // rust: amount,
    // rust: );
    // rust: self.menu_option_events(events);
    // rust: } else if let Some(title) = &mut self.menu.title {
    // rust: title.scroll_worlds(amount, self.menu.cursor, (batch.width, batch.height));
}
}
    // rust: WindowEvent::KeyboardInput { event, .. } if event.state == ElementState::Pressed => {
    // rust: if event.physical_key == PhysicalKey::Code(KeyCode::F11) {
    // rust: self.settings.fullscreen = !self.settings.fullscreen;
    // rust: self.apply_menu_settings();
    // rust: self.save_menu_settings();
    // rust: } else if self.menu.options_open {
    // rust: let shortcut = self.menu.shortcut(&event);
    // rust: let atlas = &self.gui.as_ref().unwrap().atlas;
    // rust: let handled = shortcut.is_some_and(|s| {
    // rust: self.menu
    // rust: .options
    // rust: .shortcut(atlas, s, &mut self.menu.clipboard)
    // rust: });
    // rust: if !handled && let PhysicalKey::Code(key) = event.physical_key {
    // rust: let events = self.menu.options.key(
    // rust: &mut self.settings,
    // rust: atlas,
    // rust: key,
    // rust: event.text.as_deref(),
    // rust: );
    // rust: self.menu_option_events(events);
}
    // rust: } else {
    // rust: let batch = HudBatch::new(self.menu_size());
    // rust: let action = self.menu.title_key(&event, (batch.width, batch.height));
    // rust: self.menu_action(event_loop, action);
}
}
    // rust: _ => {}
}
    // rust: Ok(())
}

    // rust: pub(super) fn draw_menu(&mut self, batch: &mut HudBatch) {
    // rust: let logs = horizon_client::logging::recent_lines();
    // rust: let Some(gui) = &self.gui else {
            // The pack's screens do not exist yet: the boot screen holds the
            // window, the wordmark and the console's lines while they load.
    // rust: horizon_client::ui_theme::draw_boot(&self.boot, batch, &logs);
    // rust: return;
}
    // rust: if self.menu.pending.is_some() {
    // rust: horizon_client::level_loading::draw_loading_overlay(
    // rust: batch,
    // rust: &gui.atlas,
    // rust: self.progress.line(),
    // rust: self.progress.fraction(),
    // rust: self.settings.file.bool("darkMojangStudiosBackground"),
    // rust: );
    // rust: } else if let Some((win, frame)) = &mut self.menu.win {
    // rust: let now = Instant::now();
            // 20 ticks a second: the startup menu runs no tick rate.
    // rust: let delta_ticks = now.duration_since(*frame).as_secs_f32() * 20.0;
    // rust: *frame = now;
    // rust: horizon_client::widgets::begin_screen(|| win.screen_info());
    // rust: win.draw(batch, &gui.atlas, delta_ticks, Default::default());
    // rust: if win.finished(batch.height) {
    // rust: self.menu.win = None;
}
    // rust: } else if self.menu.options_open {
    // rust: self.menu
    // rust: .options
    // rust: .draw(&self.settings, batch, &gui.atlas, self.menu.cursor);
    // rust: } else if let Some(title) = &mut self.menu.title {
    // rust: title.poll_backup();
    // rust: if std::mem::take(&mut title.onboarding_finished) {
                // Options.onboardingAccessibilityFinished.
    // rust: self.settings.file.set(
    // rust: "onboardAccessibility",
    // rust: horizon_client::options_file::V::Bool(false),
    // rust: );
    // rust: self.settings.save(&Game::options_path());
}
    // rust: let _ = title.update_toast(self.settings.notification_display_time);
    // rust: for found in title.lan_found_narrations((batch.width, batch.height)) {
    // rust: horizon_narrator::say_system_queued(&found.plain());
}
    // rust: let items = match &self.loaded {
    // rust: Some(Ok(loaded)) => Some(&*loaded.pack.item_renderer),
    // rust: _ => None,
}
    // rust: title.draw_with_items(
    // rust: &gui.atlas,
    // rust: items,
    // rust: batch,
    // rust: self.menu.cursor,
    // rust: self.settings.file.bool("hideSplashTexts"),
    // rust: self.settings.file.bool("hideServerAddress"),
    // rust: );
}
    // rust: if let Some(focus) = self.menu.key_focus
    // rust: && self.menu.pending.is_none()
    // rust: && self.menu.win.is_none()
    // rust: {
    // rust: key_focus::draw_outline(&gui.atlas, batch, focus);
}
        // Over every screen, as the game's; no sound before the sound engine.
    // rust: let title_toast = self.menu.title.as_ref().is_some_and(|t| t.has_toast());
    // rust: super::narrator::draw_toast(
    // rust: &mut self.menu.narrator_toast,
    // rust: u32::from(title_toast),
    // rust: f64::from(self.settings.notification_display_time),
    // rust: &gui.atlas,
    // rust: batch,
    // rust: false,
    // rust: );
}

    // rust: pub(super) fn restart_menu_resources(&mut self) -> Result<()> {
    // rust: if !self.menu.reload_packs || self.loaded.is_none() {
    // rust: return Ok(());
}
    // rust: if let Some(Ok(loaded)) = &mut self.loaded {
    // rust: if let Some(loader) = &loaded.rest_loader
    // rust: && !loader.ready()?
    // rust: {
    // rust: return Ok(());
}
    // rust: if let Some(loader) = loaded.rest_loader.take()
    // rust: && let Err(error) = loader.finish()
    // rust: {
    // rust: log::warn!("Horizon: replaced resource generation failed: {error}");
}
}
    // rust: self.loaded = None;
    // rust: self.delivered = false;
    // rust: if let Some(handle) = self.handle.take() {
    // rust: handle.join().map_err(|payload| {
    // rust: format!("resource loader panicked: {}", panic_text(payload.as_ref()))
    // rust: })?;
}
    // rust: self.progress = Progress::new();
    // rust: let options = self.options.as_ref().ok_or("loading already finished")?;
    // rust: let (receiver, handle) = spawn_loader(
    // rust: options,
    // rust: &self.settings,
    // rust: &self.vanilla_root,
    // rust: self.started,
    // rust: &self.progress,
    // rust: )?;
    // rust: self.receiver = receiver;
    // rust: self.handle = Some(handle);
    // rust: self.menu.reload_packs = false;
    // rust: Ok(())
}
}

    // rust: mod tests {
//     use super::*;

pub fn gui(root: *std::path::Path) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: UiResources {
    // rust: atlas: HudAtlas::fonts(root).unwrap(),
    // rust: panorama: Arc::new(horizon_client::gfx::panorama::Faces::colour([
    // rust: 96, 110, 111, 255,
    // rust: ])),
}
}

pub fn loading(receiver: Receiver<LoaderMsg>) L {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Loading {
    // rust: window: None,
    // rust: renderer: None,
    // rust: boot: horizon_client::hud::HudAtlas::boot(),
    // rust: gui: None,
    // rust: settings: Settings::default(),
    // rust: fullscreen: horizon_client::window::FullscreenState::new(false),
    // rust: video_modes: Default::default(),
    // rust: options: None,
    // rust: vanilla_root: PathBuf::new(),
    // rust: pack_error: None,
    // rust: started: Instant::now(),
    // rust: panorama_rotation: Default::default(),
    // rust: progress: Progress::new(),
    // rust: receiver,
    // rust: loaded: None,
    // rust: delivered: false,
    // rust: handle: None,
    // rust: shown: false,
    // rust: ui_at: None,
    // rust: title_drawn: false,
    // rust: menu: StartupMenu::default(),
    // rust: error: None,
}
}

pub fn the_world_renderer_waits_for_the_first_title_frame() void {
}
    // rust: let (_send, receiver) = std::sync::mpsc::channel();
    // rust: let mut loading = loading(receiver);
        // No menu bundle yet: nothing to wait for.
    // rust: assert!(loading.ready_for_handoff());
        // The title artwork is up but no frame of it was presented.
    // rust: loading.ui_at = Some(Instant::now());
    // rust: assert!(!loading.ready_for_handoff());
    // rust: loading.title_drawn = true;
    // rust: assert!(loading.ready_for_handoff());
        // A window never asked to redraw doesn't hold the start for long.
    // rust: loading.title_drawn = false;
    // rust: loading.ui_at = Instant::now().checked_sub(Duration::from_secs(2));
    // rust: assert!(loading.ready_for_handoff());
}

pub fn menu_is_usable_while_the_core_worker_is_blocked() void {
}
    // rust: let root = std::env::temp_dir().join("horizon-startup-menu-no-world-resources");
    // rust: let (sender, receiver) = std::sync::mpsc::channel();
    // rust: let (release, wait) = std::sync::mpsc::channel();
    // rust: let (published, published_rx) = std::sync::mpsc::channel();
    // rust: let worker_root = root.clone();
    // rust: let worker = std::thread::spawn(move || {
    // rust: sender
    // rust: .send(LoaderMsg::Ui(gui(&worker_root), worker_root))
    // rust: .unwrap();
    // rust: published.send(()).unwrap();
    // rust: wait.recv().unwrap();
    // rust: sender
    // rust: .send(LoaderMsg::Done(Err("core failure".into())))
    // rust: .unwrap();
    // rust: });
    // rust: published_rx.recv().unwrap();
    // rust: let mut loading = loading(receiver);
    // rust: loading.poll_menu_resources().unwrap();
    // rust: assert!(loading.gui.is_some());
    // rust: assert!(loading.loaded.is_none());
    // rust: assert!(!worker.is_finished());
        // Navigate and enter a world name without a registry, biomes, pack
        // tables or a Game. Replacing fallback artwork preserves this state.
    // rust: let title = loading.menu.title.as_mut().unwrap();
    // rust: title.mode = horizon_client::title::Mode::Create {
    // rust: name: String::new(),
    // rust: seed: "42".into(),
    // rust: creative: true,
    // rust: focus: 0,
    // rust: options: Default::default(),
}
    // rust: title.type_text("My world");
    // rust: loading.set_ui(gui(&root), root);
    // rust: let action = loading.menu.title.as_ref().unwrap().create_action();
    // rust: loading.menu.queue_entry(action, "Player".into());
    // rust: assert!(
    // rust: matches!(&loading.menu.pending, Some(PendingWorldEntry::Local {
    // rust: name: Some(name), seed: Some(42), creative: true, create: Some(_), ..
    // rust: }) if name == "My world")
    // rust: );
    // rust: let mut batch = HudBatch::new([1280, 720]);
    // rust: loading.draw_menu(&mut batch);
    // rust: assert!(
    // rust: !batch.vertices.is_empty(),
    // rust: "queued entry draws loading progress"
    // rust: );
    // rust: release.send(()).unwrap();
    // rust: worker.join().unwrap();
    // rust: loading.poll_menu_resources().unwrap();
    // rust: assert!(matches!(loading.loaded, Some(Err(ref error)) if error == "core failure"));
}

pub fn queued_server_keeps_address_player_identity_and_lan_kind() void {
}
    // rust: let mut menu = StartupMenu::default();
    // rust: menu.queue_entry(
    // rust: Action::Connect {
    // rust: address: "localhost:25565".into(),
    // rust: lan: true,
    // rust: },
    // rust: "Guest".into(),
    // rust: );
    // rust: assert!(
    // rust: matches!(menu.pending.take(), Some(PendingWorldEntry::Server { address, name, lan: true, .. })
    // rust: if address == "localhost:25565" && name == "Guest")
    // rust: );
    // rust: assert!(menu.pending.take().is_none(), "an entry is consumed once");
}

pub fn a_failed_generation_keeps_its_error_after_the_loader_ends() void {
}
    // rust: let (sender, receiver) = std::sync::mpsc::channel();
    // rust: let worker = std::thread::spawn(move || {
    // rust: sender
    // rust: .send(LoaderMsg::Done(Err("missing facts.json".into())))
    // rust: .unwrap();
    // rust: });
    // rust: let mut loading = loading(receiver);
    // rust: loading.handle = Some(worker);
    // rust: while loading.loaded.is_none() {
    // rust: loading.poll_menu_resources().unwrap();
}
        // App::about_to_wait takes the result to report it; the loop may poll
        // once more before it exits, with the loader gone.
    // rust: assert!(matches!(loading.loaded.take(), Some(Err(e)) if e == "missing facts.json"));
    // rust: while !loading.handle.as_ref().is_none_or(JoinHandle::is_finished) {
    // rust: std::thread::yield_now();
}
    // rust: loading.poll_menu_resources().unwrap();
    // rust: assert!(loading.loaded.is_none());
}

pub fn a_panicking_loader_reports_its_panic() void {
}
    // rust: let (sender, receiver) = std::sync::mpsc::channel::<LoaderMsg>();
    // rust: let worker = std::thread::spawn(move || {
    // rust: let _sender = sender;
    // rust: panic!("atlas has no fonts");
    // rust: });
    // rust: while !worker.is_finished() {
    // rust: std::thread::yield_now();
}
    // rust: let mut loading = loading(receiver);
    // rust: loading.handle = Some(worker);
    // rust: assert_eq!(
    // rust: loading.poll_menu_resources().unwrap_err().to_string(),
    // rust: "resource loader stopped before finishing: atlas has no fonts"
    // rust: );
}

pub fn disconnected_core_worker_is_reported_instead_of_waiting_forever() void {
}
    // rust: let (sender, receiver) = std::sync::mpsc::channel();
    // rust: drop(sender);
    // rust: let mut loading = loading(receiver);
    // rust: assert_eq!(
    // rust: loading.poll_menu_resources().unwrap_err().to_string(),
    // rust: "resource loader stopped before finishing: no loader thread was running"
    // rust: );
}
}
