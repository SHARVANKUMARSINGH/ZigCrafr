//! Transpiled from Horizon Rust crate
//! Module: horizon-client_debug_keys
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The debug keys in the game (26.3 `KeyboardHandler.keyPress`,
//! `handleDebugKeys` and `tick`): F3 combinations, F3+Escape, the held
//! debug-crash keys, and the debug renderers they switch on.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: Result,
    // rust: command::args::GameMode,
    // rust: debug_keys::{CrashNotice, DebugAction, DebugHost, KeyAction, OpenScreen},
    // rust: debug_overlay,
    // rust: gizmos::Gizmos,
    // rust: hud::HudBatch,
    // rust: hud_layout, keybinds,
    // rust: text::{ClickEvent, Style, Text},
}
// use horizon_core::geometry::{Axis, Vec3};
// use horizon_protocol::packets::play::{BlockEntityTagQuery, EntityTagQuery, Serverbound};
// use horizon_world::nbt::Tag;
// use winit::keyboard::KeyCode;

/// `ChatFormatting.YELLOW` and `RED`.
pub const YELLOW: u32 = 0xFF_FF55;
pub const RED: u32 = 0xFF_5555;

/// The game as `KeyboardHandler` sees it while it runs one key event.
pub const Host = struct {
    game: *'g mut Game<'a>,
};

    // rust: impl DebugHost for Host<'_, '_> {
pub fn screen(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.open_screen()
}
pub fn toggle_overlay(self: *Self) void {
}
    // rust: self.game.debug = !self.game.debug;
}
pub fn pause_game(self: *Self, without_menu: bool) void {
}
        // Gui.setPauseScreen: PauseScreen(false) only when the game really
        // pauses (single player, not open to the network). Escape alone opens
        // the menu as it always has (key_pressed).
    // rust: let g = &mut *self.game;
    // rust: if without_menu && g.screen == Screen::Playing {
    // rust: g.pause_menu = !g.has_singleplayer_server() || g.is_published();
    // rust: g.pause_focus = None;
    // rust: g.screen = Screen::Paused;
    // rust: g.capture(false);
    // rust: g.mining = None;
}
}
pub fn debug_action(self: *Self, action: DebugAction, shift: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.run_debug_action(action, shift)
}
}

    // rust: impl Game<'_> {
pub fn open_screen(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.title.is_some() {
    // rust: return OpenScreen::Other;
}
    // rust: match self.screen {
    // rust: Screen::GameModeSwitcher => OpenScreen::GameModeSwitcher,
    // rust: Screen::Playing if self.book.is_none() && self.sign_edit.is_none() => OpenScreen::None,
    // rust: Screen::Paused if !self.pause_menu => OpenScreen::PauseWithoutMenu,
    // rust: _ => OpenScreen::Other,
}
}
    /// A physical key event (already in `physical_keys`) before the game's
    /// own handling. Returns true when it is used up (a debug combination,
    /// F3 itself, F3+Escape).
    // rust: pub(super) fn debug_key(&mut self, key: KeyCode, action: KeyAction) -> bool {
    // rust: let Some(name) = keybinds::key_name(key) else {
    // rust: return false;
}
    // rust: let pressed = action != KeyAction::Release;
    // rust: let switcher_open = self.screen == Screen::GameModeSwitcher;
    // rust: if switcher_open && pressed {
    // rust: if name == self.settings.keys.get("key.debug.switchGameMode") {
    // rust: if let Some(switcher) = &mut self.gamemode_switcher {
    // rust: switcher.cycle();
}
    // rust: } else if key == KeyCode::Escape {
    // rust: self.close_gamemode_switcher(false);
    // rust: } else if name == self.settings.keys.get("key.debug.debugOptions") {
                // The debug options screen interrupts the switcher too
                // (`canInterruptScreen`): it closes, then F6 opens over the game.
    // rust: self.close_gamemode_switcher(false);
    // rust: self.toggle_debug_options();
    // rust: } else if matches!(key, KeyCode::F2 | KeyCode::F11) {
    // rust: return false;
}
    // rust: return true;
}
        // Vanilla types into a focused EditBox through charTyped, which no
        // debug key can swallow. Here the character comes with the key press,
        // so a screen with a focused text box takes every press first;
        // releases still reach KeyboardHandler.
    // rust: let typing = matches!(
    // rust: self.screen,
    // rust: Screen::Chat
    // rust: | Screen::Options
    // rust: | Screen::WorldOptions
    // rust: | Screen::CommandBlock
    // rust: | Screen::BlockEditor
    // rust: ) || self.sign_edit.is_some()
    // rust: || self.book.is_some()
    // rust: || (self.screen == Screen::Creative && self.creative_screen.tab().search)
    // rust: || self.recipe_search_focused()
    // rust: || self.station_typing()
    // rust: || self
    // rust: .title
    // rust: .as_mut()
    // rust: .is_some_and(|t| t.focused_field().is_some());
        // Container screens use Escape, the inventory key and the hotbar and
        // drop keys first; any other screen closes on Escape.
    // rust: let screen_key = match self.screen {
    // rust: Screen::Inventory | Screen::Creative => matches!(
    // rust: key,
    // rust: KeyCode::Escape
    // rust: | KeyCode::KeyE
    // rust: | KeyCode::KeyF
    // rust: | KeyCode::KeyQ
    // rust: | KeyCode::Digit1
    // rust: | KeyCode::Digit2
    // rust: | KeyCode::Digit3
    // rust: | KeyCode::Digit4
    // rust: | KeyCode::Digit5
    // rust: | KeyCode::Digit6
    // rust: | KeyCode::Digit7
    // rust: | KeyCode::Digit8
    // rust: | KeyCode::Digit9
    // rust: ),
    // rust: Screen::Playing => false,
    // rust: _ => key == KeyCode::Escape,
}
    // rust: if pressed && (typing || screen_key) {
    // rust: return false;
}
    // rust: let crash_down = keybinds::key_code(self.settings.keys.get("key.debug.crash"))
    // rust: .is_some_and(|k| self.physical_keys.contains(&k));
    // rust: let shift = self.physical_keys.contains(&KeyCode::ShiftLeft)
    // rust: || self.physical_keys.contains(&KeyCode::ShiftRight);
    // rust: let now = self.debug_millis();
    // rust: let binds = self.settings.keys.clone();
    // rust: let mut keys = std::mem::take(&mut self.debug_keys);
    // rust: let modifier_was_down = keys.modifier_down;
    // rust: let to_game = keys.key_press(
    // rust: &mut Host { game: self },
    // rust: &binds,
    // rust: name,
    // rust: action,
    // rust: shift,
    // rust: crash_down,
    // rust: now,
    // rust: );
    // rust: self.debug_keys = keys;
    // rust: if switcher_open {
    // rust: if name == binds.get("key.debug.modifier") {
    // rust: self.close_gamemode_switcher(true);
    // rust: return true;
}
    // rust: return false;
}
    // rust: if !pressed {
    // rust: return false;
}
        // The debug modifier does nothing else.
    // rust: if name == binds.get("key.debug.modifier") || name == binds.get("key.debug.overlay") {
    // rust: return true;
}
    // rust: if self.open_screen() == OpenScreen::None {
    // rust: !to_game
    // rust: } else {
    // rust: modifier_was_down
}
}
    /// `Util.getMillis` (positive: KeyboardHandler treats 0 as unset).
    // rust: pub(super) fn debug_millis(&self) -> i64 {
    // rust: self.started.elapsed().as_millis() as i64 + 1_000_000
}
    /// `KeyboardHandler.tick`: the debug crash countdown.
    // rust: pub(super) fn tick_debug_keys(&mut self) -> Result<()> {
    // rust: let now = self.debug_millis();
    // rust: match self.debug_keys.tick(now) {
    // rust: None => {}
    // rust: Some(CrashNotice::Message) => {
    // rust: let args = [
    // rust: self.key_text("key.debug.modifier"),
    // rust: self.key_text("key.debug.crash"),
    // rust: ];
    // rust: self.debug_feedback(Text::translate("debug.crash.message", &args));
}
    // rust: Some(CrashNotice::Warning(seconds)) => self.debug_warning(Text::translate(
    // rust: "debug.crash.warning",
    // rust: &[Text::literal(seconds.to_string())],
    // rust: )),
    // rust: Some(CrashNotice::Crash) => {
                // Minecraft.emergencySaveAndCrash: the world is saved, then the
                // game stops; main writes the crash report.
    // rust: let crash = horizon_client::crash::DebugCrash::new();
    // rust: if let Err(e) = self.save_game() {
    // rust: log::error!("the emergency save before the crash failed: {e}");
}
    // rust: return Err(crash.into());
}
}
    // rust: Ok(())
}
    /// The network charts' samples each tick: `PingDebugMonitor.tick` while
    /// they show, `BandwidthDebugMonitor.tick` always.
    // rust: pub(super) fn tick_debug_charts(&mut self) {
    // rust: let shown = self.debug && self.debug_charts.network;
    // rust: let Some(r) = &self.remote else {
            // The integrated server answers within the tick.
    // rust: if shown {
    // rust: self.debug_charts.ping.log(0);
}
    // rust: return;
}
    // rust: let received = r.session.counters.lock().unwrap().as_ref().map(|c| {
    // rust: let order = std::sync::atomic::Ordering::Relaxed;
    // rust: [
    // rust: c.bytes_in.load(order),
    // rust: c.sent.load(order),
    // rust: c.received.load(order),
    // rust: ]
    // rust: });
    // rust: if let Some([bytes, sent, received]) = received {
    // rust: self.debug_charts.log_bandwidth(bytes);
    // rust: self.debug_charts.log_packets([sent, received]);
}
    // rust: if shown {
//             use horizon_protocol::packets::status::Ping;
    // rust: let time = self.debug_millis();
    // rust: self.send(Serverbound::PingRequest(Ping { time }));
}
}
    /// The overlay's chart lines (`DebugScreenOverlay`'s "Debug charts").
    // rust: pub(super) fn debug_chart_lines(&self) -> [String; 3] {
    // rust: let keys = &self.settings.keys;
    // rust: let modifier = keys.get("key.debug.modifier");
    // rust: let key = |mapping: &str| {
    // rust: let prefix = if modifier == "key.keyboard.unknown" {
    // rust: String::new()
    // rust: } else {
    // rust: format!("{}+", keybinds::display_name(modifier).plain())
}
    // rust: format!(
    // rust: "[{prefix}{}]",
    // rust: keybinds::display_name(keys.get(mapping)).plain()
    // rust: )
}
    // rust: let chart = |mapping: &str, name: &str, on: bool| {
    // rust: format!(
    // rust: "{} {name} {}",
    // rust: key(mapping),
    // rust: if on { "visible" } else { "hidden" }
    // rust: )
}
        // `DebugScreenOverlay`: the single-player variants for a local server.
    // rust: let remote = !self.has_singleplayer_server();
    // rust: let c = &self.debug_charts;
    // rust: [
    // rust: format!(
    // rust: "Debug charts: {}; {};",
    // rust: chart("key.debug.profilingChart", "Profiler", false),
    // rust: chart(
    // rust: "key.debug.fpsCharts",
    // rust: if remote { "fps" } else { "fps + tps" },
    // rust: c.fps
    // rust: ),
    // rust: ),
    // rust: format!(
    // rust: "{}; {}",
    // rust: chart(
    // rust: "key.debug.networkCharts",
    // rust: if remote { "Bandwidth + Ping" } else { "Ping" },
    // rust: c.network
    // rust: ),
    // rust: chart("key.debug.lightmapTexture", "Lightmap", c.lightmap),
    // rust: ),
    // rust: format!("To edit: press {}", key("key.debug.debugOptions")),
    // rust: ]
}
    /// `Gui.extractRenderState`'s debug overlay, over everything the frame
    /// drew (menus too); the debug options screen draws it under itself.
    // rust: pub(super) fn draw_debug_overlay(&self, batch: &mut HudBatch, size: [u32; 2]) {
    // rust: if self.screen != Screen::DebugOptions {
    // rust: self.draw_debug_overlay_under(batch, size);
}
}
    /// `DebugScreenOverlay.extractRenderState`: the enabled entries' lines
    /// (`debug-profile.json`), at the debug GUI scale, and the charts while
    /// the overlay is open. F1 hides it unless a screen is open.
    // rust: pub(super) fn draw_debug_overlay_under(&self, batch: &mut HudBatch, size: [u32; 2]) {
    // rust: let screen_open = self.screen != Screen::Playing;
    // rust: let reduced = self.reduced_debug_info();
    // rust: if self.title.is_some()
    // rust: || !self.debug_entries.any_enabled(self.debug, reduced)
    // rust: || (self.ui.hide_gui && !screen_open)
    // rust: {
    // rust: return;
}
    // rust: let framebuffer = size.map(|v| v as i32);
    // rust: let (scale, [width, height]) = debug_overlay::scale(
    // rust: framebuffer,
    // rust: batch.scale as i32,
    // rust: self.settings.file.int("debugGuiScale"),
    // rust: self.settings.force_unicode,
    // rust: [batch.width as i32, batch.height as i32],
    // rust: );
    // rust: let mut d = debug_overlay::Displayer::default();
    // rust: self.debug_entry_lines(&mut d, framebuffer);
        // The chart keys and the charts only while the overlay is open.
    // rust: let footer = if self.debug {
    // rust: self.debug_chart_lines().to_vec()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let (left, right) = d.columns(&footer);
    // rust: let atlas = &self.gui.atlas;
    // rust: let mut draws = debug_overlay::draw(&atlas.font, [&left, &right], scale, width);
    // rust: if self.debug {
    // rust: let charts = self.debug_charts.draw(
    // rust: &atlas.font,
    // rust: width,
    // rust: height,
    // rust: self.settings.max_fps,
    // rust: 1000.0 / self.clock.rate(),
    // rust: !self.has_singleplayer_server(),
    // rust: );
    // rust: draws.push(hud_layout::GuiDraw::Push(vec![hud_layout::PoseOp::Scale(
    // rust: scale, scale,
    // rust: )]));
    // rust: draws.extend(charts);
    // rust: if self.debug_charts.lightmap
    // rust: && let Some(r) = &self.renderer
    // rust: {
    // rust: draws.extend(horizon_client::debug_chart::lightmap(
    // rust: &r.lightmap_pixels,
    // rust: width,
    // rust: height,
    // rust: ));
}
    // rust: draws.push(hud_layout::GuiDraw::Pop);
}
    // rust: hud_layout::paint(batch, atlas, &draws);
}
    /// `DebugEntryFps`.
    // rust: pub(super) fn debug_fps_line(&self, d: &mut debug_overlay::Displayer) {
    // rust: let limit = self.framerate_limit();
    // rust: let present = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map_or("", |r| match r.config.present_mode {
    // rust: wgpu::PresentMode::Immediate => " (immediate)",
    // rust: wgpu::PresentMode::Mailbox => " (mailbox)",
    // rust: wgpu::PresentMode::Fifo => " (fifo)",
    // rust: wgpu::PresentMode::FifoRelaxed => " (fifo relaxed)",
    // rust: _ => "",
    // rust: });
    // rust: let refresh = self
    // rust: .window
    // rust: .as_ref()
    // rust: .and_then(|w| w.current_monitor())
    // rust: .and_then(|m| m.refresh_rate_millihertz())
    // rust: .map_or("0".into(), |mhz| {
    // rust: debug_overlay::refresh_rate_label(f64::from(mhz) / 1000.0)
    // rust: });
        // Horizon: with frame generation running, the frames reaching the screen too.
    // rust: let generated = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .and_then(|r| r.frame_generation_share())
    // rust: .map_or(String::new(), |share| {
    // rust: format!(
    // rust: " ({} fps FSR 3.1)",
    // rust: (self.fps * (1.0 + share)).round() as i32
    // rust: )
    // rust: });
    // rust: d.priority(format!(
    // rust: "{} fps{generated} T: {}{present} @{refresh}Hz",
    // rust: self.fps.round() as i32,
    // rust: if limit == 260 {
    // rust: "inf".into()
    // rust: } else {
    // rust: limit.to_string()
    // rust: },
    // rust: ));
}
    /// `DebugEntrySimplePerformanceImpactors`.
    // rust: pub(super) fn debug_performance_lines(&self, d: &mut debug_overlay::Displayer) {
    // rust: let s = &self.settings;
    // rust: d.line(format!(
    // rust: "{}{}B: {}",
    // rust: if s.improved_transparency {
    // rust: "improved-transparency "
    // rust: } else {
    // rust: ""
    // rust: },
    // rust: match s.clouds.as_str() {
    // rust: "false" => "",
    // rust: "fast" => "fast-clouds ",
    // rust: _ => "fancy-clouds ",
    // rust: },
    // rust: s.biome_blend
    // rust: ));
    // rust: d.line("Filtering: None");
    // rust: d.line(format!(
    // rust: "Terrain Rendering: {}",
    // rust: if self.renderer.as_ref().is_some_and(|r| r.multi_draw) {
    // rust: "multidrawindirect"
    // rust: } else {
    // rust: "naive"
}
    // rust: ));
}
    /// `DebugEntrySystemSpecs` (no Java line: Horizon has no JVM).
    // rust: pub(super) fn debug_system_lines(
    // rust: &self,
    // rust: d: &mut debug_overlay::Displayer,
    // rust: framebuffer: [i32; 2],
    // rust: ) {
    // rust: if let Some(r) = self.renderer.as_ref() {
pub const CPU: std::sync::OnceLock<[]const u8> = std::sync::OnceLock::new();
    // rust: d.group(
    // rust: "system",
    // rust: [format!(
    // rust: "CPU: {}",
    // rust: CPU.get_or_init(horizon_client::crash::cpu)
    // rust: )],
    // rust: );
    // rust: let info = &r.info;
    // rust: d.group(
    // rust: "system",
    // rust: [format!(
    // rust: "Display: {}x{} ({})",
    // rust: framebuffer[0],
    // rust: framebuffer[1],
                    // Metal adapters report no PCI vendor.
    // rust: if info.vendor == 0 && info.backend == wgpu::Backend::Metal {
    // rust: "Apple".into()
    // rust: } else {
    // rust: debug_overlay::vendor_name(info.vendor)
}
    // rust: )],
    // rust: );
    // rust: if let Some(w) = self.window.as_ref() {
    // rust: let density = w.scale_factor();
    // rust: let logical = w.inner_size().to_logical::<f64>(density);
    // rust: d.group(
    // rust: "system",
    // rust: [format!(
    // rust: "Window: {}x{} ({density:.2}x pixel density)",
    // rust: logical.width.round() as i32,
    // rust: logical.height.round() as i32
    // rust: )],
    // rust: );
}
    // rust: let kind = match info.device_type {
    // rust: wgpu::DeviceType::IntegratedGpu => " (iGPU)",
    // rust: wgpu::DeviceType::DiscreteGpu => " (dGPU)",
    // rust: wgpu::DeviceType::VirtualGpu => " (vGPU)",
    // rust: wgpu::DeviceType::Cpu => " (software)",
    // rust: wgpu::DeviceType::Other => "",
}
    // rust: let driver = format!("{} {}", info.driver, info.driver_info);
    // rust: d.group(
    // rust: "system",
    // rust: [
    // rust: format!("{}{kind}", info.name),
    // rust: format!(
    // rust: "{:?} {}",
    // rust: info.backend,
    // rust: driver.trim().lines().next().unwrap_or("")
    // rust: )
    // rust: .trim_end()
    // rust: .to_owned(),
    // rust: ],
    // rust: );
}
        // Horizon's own: HDR's output while the setting is on, under the GPU (a group of its
        // own would move others to the other column).
    // rust: if self.settings.horizon.hdr
    // rust: && let Some(r) = self.renderer.as_ref()
    // rust: {
    // rust: d.group("system", [r.hdr_line()]);
}
}
    /// `DebugEntryTps` for local and remote connections.
    // rust: pub(super) fn debug_tps_line(&self, d: &mut debug_overlay::Displayer) {
    // rust: if self.player.is_some() {
    // rust: let [tx, rx] = self.debug_charts.packet_rates.map(|n| n.round() as i64);
    // rust: let (target, status) = if self.clock.sprinting() {
    // rust: ("-".to_owned(), " (sprinting)")
    // rust: } else if self.clock.stepping() {
    // rust: (
    // rust: format!("{:.1}", 1000.0 / self.clock.rate()),
    // rust: " (frozen - stepping)",
    // rust: )
    // rust: } else if self.clock.frozen() {
    // rust: (format!("{:.1}", 1000.0 / self.clock.rate()), " (frozen)")
    // rust: } else {
    // rust: (format!("{:.1}", 1000.0 / self.clock.rate()), "")
}
    // rust: if self.remote.is_none() || self.integrated.is_some() {
    // rust: let tick_ms = self
    // rust: .integrated
    // rust: .as_ref()
    // rust: .map_or(self.debug_charts.smoothed_tick_ms, |server| {
    // rust: server.smoothed_tick_ms()
    // rust: });
    // rust: d.line(format!(
    // rust: "Integrated server @ {tick_ms:.1}/{target} ms{status}, {tx} tx, {rx} rx",
    // rust: ));
    // rust: } else if let Some(remote) = &self.remote {
    // rust: d.line(format!(
    // rust: "\"{}\" server{status}, {tx} tx, {rx} rx",
    // rust: remote.brand
    // rust: ));
}
}
}
    /// `KeyMapping.getTranslatedKeyMessage`.
pub fn key_text(self: *Self, mapping: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: keybinds::display_name(self.settings.keys.get(mapping))
}
    /// `KeyboardHandler.decorateDebugComponent`: `[Debug]:` in bold, a space,
    /// the message, shown with `Minecraft.showDebugChat`.
pub fn debug_decorated(self: *Self, color: u32, message: Text) void {
}
    // rust: let prefix = Text::translate("debug.prefix", &[])
    // rust: .with_color(color)
    // rust: .bold();
    // rust: self.show_debug_chat(
    // rust: Text::empty()
    // rust: .append(prefix)
    // rust: .append(Text::literal(" "))
    // rust: .append(message),
    // rust: );
}
    /// `Minecraft.showDebugChat`: a client system message the narrator says.
pub fn show_debug_chat(self: *Self, message: Text) void {
}
    // rust: self.say_system_queued(&message);
    // rust: self.system_message(message);
}
pub fn debug_feedback(self: *Self, message: Text) void {
}
    // rust: self.debug_decorated(YELLOW, message);
}
pub fn debug_warning(self: *Self, message: Text) void {
}
    // rust: self.debug_decorated(RED, message);
}
pub fn debug_translated(self: *Self, key: []const u8) void {
}
    // rust: self.debug_feedback(Text::translate(key, &[]));
}
    /// `LocalPlayer.isReducedDebugInfo`: the server's rule or the option.
    // rust: pub(super) fn reduced_debug_info(&self) -> bool {
    // rust: self.settings.reduced_debug_info
    // rust: || self.ui.rules.bool("reduced_debug_info")
    // rust: || self.remote.as_ref().is_some_and(|r| r.reduced_debug_info)
}
    /// `DebugScreenEntryList.isCurrentlyEnabled` for an entry's path.
    // rust: pub(super) fn debug_entry(&self, path: &str) -> bool {
    // rust: self.debug_entries
    // rust: .enabled(path, self.debug, self.reduced_debug_info())
}
    /// The `3d_crosshair` entry.
    // rust: pub(super) fn debug_crosshair(&self) -> bool {
    // rust: self.debug_entry("3d_crosshair")
}
    /// `Permissions.COMMANDS_GAMEMASTER` (`GameModeCommand.PERMISSION_CHECK`).
    // rust: pub(super) fn gamemaster(&self) -> bool {
    // rust: self.ui.registries.permission >= 2
}
pub fn toggle_option(self: *Self, key: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let on = !self.settings.file.bool(key);
    // rust: self.settings
    // rust: .file
    // rust: .set(key, horizon_client::options_file::V::Bool(on));
    // rust: self.settings.save(&Self::options_path());
    // rust: on
}
    /// One matching mapping of `handleDebugKeys`; whether it counts.
pub fn run_debug_action(self: *Self, action: DebugAction, shift: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let player = self.player.is_some() && !self.reduced_debug_info();
    // rust: match action {
    // rust: DebugAction::ReloadChunks => {
    // rust: self.all_sections_changed();
    // rust: self.debug_translated("debug.reload_chunks.message");
    // rust: true
}
    // rust: DebugAction::ShowHitboxes if player => {
    // rust: let on = self
    // rust: .debug_entries
    // rust: .toggle_status("entity_hitboxes", self.debug);
    // rust: self.debug_translated(if on {
    // rust: "debug.show_hitboxes.on"
    // rust: } else {
    // rust: "debug.show_hitboxes.off"
    // rust: });
    // rust: true
}
    // rust: DebugAction::ClearChat => {
                // ChatComponent.clearMessages(false): sent history stays.
    // rust: self.ui.chat.clear();
    // rust: true
}
    // rust: DebugAction::ShowChunkBorders if player => {
    // rust: let on = self
    // rust: .debug_entries
    // rust: .toggle_status("chunk_borders", self.debug);
    // rust: self.debug_translated(if on {
    // rust: "debug.chunk_boundaries.on"
    // rust: } else {
    // rust: "debug.chunk_boundaries.off"
    // rust: });
    // rust: true
}
    // rust: DebugAction::AdvancedTooltips => {
                // The message comes before Options.save here.
    // rust: let on = !self.settings.file.bool("advancedItemTooltips");
    // rust: self.debug_translated(if on {
    // rust: "debug.advanced_tooltips.on"
    // rust: } else {
    // rust: "debug.advanced_tooltips.off"
    // rust: });
    // rust: self.toggle_option("advancedItemTooltips");
    // rust: true
}
    // rust: DebugAction::CopyRecreateCommand => {
    // rust: if player {
    // rust: self.copy_recreate_command(self.gamemaster(), !shift);
}
    // rust: true
}
    // rust: DebugAction::Spectate => {
    // rust: if self.player.is_none() || !self.gamemaster() {
    // rust: self.debug_translated("debug.creative_spectator.error");
    // rust: } else if self.mode != GameMode::Spectator {
    // rust: self.change_game_mode(GameMode::Spectator);
    // rust: } else {
    // rust: let back = self.previous_mode.unwrap_or(GameMode::Creative);
    // rust: self.change_game_mode(back);
}
    // rust: true
}
    // rust: DebugAction::SwitchGameMode if self.open_screen() == OpenScreen::None => {
    // rust: if self.player.is_none() || !self.gamemaster() {
    // rust: self.debug_translated("debug.gamemodes.error");
    // rust: } else {
    // rust: self.open_gamemode_switcher();
}
    // rust: true
}
    // rust: DebugAction::FocusPause => {
    // rust: let on = self.toggle_option("pauseOnLostFocus");
    // rust: self.debug_translated(if on {
    // rust: "debug.pause_focus.on"
    // rust: } else {
    // rust: "debug.pause_focus.off"
    // rust: });
    // rust: true
}
    // rust: DebugAction::ReloadResourcePacks => {
    // rust: self.debug_translated("debug.reload_resourcepacks.message");
    // rust: self.reload_packs();
    // rust: true
}
    // rust: DebugAction::CopyLocation if player => {
    // rust: self.debug_translated("debug.copy_location.message");
    // rust: if let Some(p) = &self.player {
//                     use horizon_client::java_text::format_fixed2 as f2;
    // rust: let command = format!(
    // rust: "/execute in {} run tp @s {} {} {} {} {}",
    // rust: self.dim.id(),
    // rust: f2(p.position.x),
    // rust: f2(p.position.y),
    // rust: f2(p.position.z),
    // rust: f2(f64::from(self.yaw)),
    // rust: f2(f64::from(self.pitch)),
    // rust: );
    // rust: self.set_clipboard(&command);
}
    // rust: true
}
    // rust: DebugAction::DumpVersion => {
    // rust: self.debug_translated("debug.version.header");
    // rust: for line in self.version_lines() {
    // rust: self.show_debug_chat(line);
}
    // rust: true
}
    // rust: DebugAction::ImprovedTransparency => {
    // rust: self.settings.improved_transparency = !self.settings.improved_transparency;
    // rust: self.settings.save(&Self::options_path());
    // rust: self.apply_settings();
    // rust: self.debug_translated(if self.settings.improved_transparency {
    // rust: "debug.improvedTransparency.on"
    // rust: } else {
    // rust: "debug.improvedTransparency.off"
    // rust: });
    // rust: true
}
    // rust: DebugAction::FpsCharts => {
    // rust: self.debug_charts.toggle_fps(&mut self.debug);
    // rust: true
}
    // rust: DebugAction::NetworkCharts => {
    // rust: self.debug_charts.toggle_network(&mut self.debug);
    // rust: true
}
    // rust: DebugAction::LightmapTexture => {
    // rust: self.debug_charts.toggle_lightmap(&mut self.debug);
    // rust: true
}
            // The debug options screen is not wired over the title screen yet:
            // leave F6 unhandled there rather than half-open it.
    // rust: DebugAction::DebugOptions if self.title.is_some() => false,
    // rust: DebugAction::DebugOptions => {
    // rust: self.toggle_debug_options();
    // rust: true
}
            // Horizon's own: a repro recording for a bug report (game/repro.rs).
            // Off unless the AI Agent page enables the shortcuts.
    // rust: DebugAction::RecordSession if !self.settings.extras.repro_keys => false,
    // rust: DebugAction::ExportRepro if !self.settings.extras.repro_keys => false,
    // rust: DebugAction::RecordSession => {
    // rust: self.toggle_recording_key();
    // rust: true
}
    // rust: DebugAction::ExportRepro => {
    // rust: self.export_repro_key();
    // rust: true
}
    // rust: DebugAction::DumpDynamicTextures => {
                // `KeyboardHandler`: `TextureUtil.getDebugTexturePath` is the game
                // folder's `screenshots/debug`; `TextureManager.dumpAllSheets` then
                // writes every dumpable texture there and the chat names the folder.
    // rust: let dir = horizon_client::logging::player_dir()
    // rust: .join("screenshots")
    // rust: .join("debug");
    // rust: match self
    // rust: .gui
    // rust: .atlas
    // rust: .dump_contents(&dir, "minecraft_textures_atlas_gui")
    // rust: {
    // rust: Ok(_) => {
    // rust: log::info!("Dumped dynamic textures to {}", dir.display());
    // rust: let link = Text::styled(
    // rust: "screenshots/debug",
    // rust: Style {
    // rust: underlined: Some(true),
    // rust: click: Some(ClickEvent::OpenFile(
    // rust: dir.to_string_lossy().into_owned(),
    // rust: )),
    // rust: ..Style::default()
    // rust: },
    // rust: );
    // rust: self.debug_feedback(Text::translate(
    // rust: "debug.dump_dynamic_textures",
    // rust: &[link],
    // rust: ));
}
    // rust: Err(e) => log::error!("Failed to dump dynamic textures: {e}"),
}
    // rust: true
}
            // Screens and overlays Horizon does not draw yet (the profiler and
            // its chart): the keys are used up as in vanilla.
    // rust: DebugAction::Profiling | DebugAction::ProfilingChart => true,
    // rust: DebugAction::ShowHitboxes
    // rust: | DebugAction::ShowChunkBorders
    // rust: | DebugAction::SwitchGameMode
    // rust: | DebugAction::CopyLocation => false,
}
}
    /// `ServerboundChangeGameModePacket` handled by the integrated server:
    /// `GameModeCommand.setGameMode` with its feedback.
    // rust: pub(super) fn change_game_mode(&mut self, mode: GameMode) {
    // rust: if self.remote.is_some() {
//             use horizon_protocol::packets::play::ChangeGameMode;
    // rust: let mode = match mode {
    // rust: GameMode::Survival => 0,
    // rust: GameMode::Creative => 1,
    // rust: GameMode::Adventure => 2,
    // rust: GameMode::Spectator => 3,
}
    // rust: self.send(Serverbound::ChangeGameMode(ChangeGameMode { mode }));
    // rust: return;
}
    // rust: if self.set_game_mode(mode) {
    // rust: let name = Text::translate(&format!("gameMode.{}", mode.name()), &[]);
    // rust: self.feedback(Text::translate("commands.gamemode.success.self", &[name]));
}
}
    /// `KeyboardHandler.copyRecreateCommand`: the targeted block or mob as a
    /// `/setblock` or `/summon` command. The server's data (no Shift) comes
    /// from the server the game is connected to, the integrated one included
    /// (`DebugQueryHandler`); without one, the game's own data is the server's.
pub fn copy_recreate_command(self: *Self, add_nbt: bool, from_server: bool) void {
}
    // rust: let query = add_nbt && from_server && self.remote.is_some();
    // rust: let side = if add_nbt && from_server {
    // rust: "server"
    // rust: } else {
    // rust: "client"
}
    // rust: if self.entity_targeted()
    // rust: && let Some((index, _, _)) = self.mob_hit()
    // rust: {
    // rust: let (kind, position, id) = {
    // rust: let m = &self.mobs[index];
    // rust: (m.kind.id.clone(), m.position, m.id)
}
    // rust: if query {
                // DebugQueryHandler.queryEntityTag: the answer copies it.
    // rust: let reply = QueryReply::Entity { id, kind, position };
    // rust: if let Some(transaction) = self.remote.as_mut().map(|r| r.debug_query.start(reply))
    // rust: {
    // rust: self.send(Serverbound::EntityTagQuery(EntityTagQuery {
    // rust: transaction,
    // rust: entity: id as i32,
    // rust: }));
}
    // rust: return;
}
            // Entity.saveWithoutId.
    // rust: let tag = if add_nbt {
    // rust: self.entity_nbt(super::commands::Target::Mob(id))
    // rust: .map(|mut tag| {
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: c.remove(&"id".into());
}
    // rust: tag
    // rust: })
    // rust: } else {
    // rust: None
}
    // rust: self.copy_create_entity_command(&kind, position, tag);
    // rust: self.debug_translated(&format!("debug.inspect.{side}.entity"));
    // rust: return;
}
    // rust: let Some(hit) = self.pick() else {
    // rust: return;
}
    // rust: let pos = hit.pos;
    // rust: let state = self.state_string(self.world.block(pos[0], pos[1], pos[2]));
    // rust: if query {
            // DebugQueryHandler.queryBlockEntityTag: the answer copies it.
    // rust: let reply = QueryReply::Block { pos, state };
    // rust: if let Some(transaction) = self.remote.as_mut().map(|r| r.debug_query.start(reply)) {
    // rust: self.send(Serverbound::BlockEntityTagQuery(BlockEntityTagQuery {
    // rust: transaction,
    // rust: pos,
    // rust: }));
}
    // rust: return;
}
    // rust: let tag = if add_nbt {
    // rust: self.block_entity_tag(pos)
    // rust: } else {
    // rust: None
}
    // rust: self.copy_create_block_command(pos, &state, tag.as_ref());
    // rust: self.debug_translated(&format!("debug.inspect.{side}.block"));
}
    /// `BlockEntity.saveWithoutMetadata` of the block entity at `pos`, if
    /// there is one: its data without the id or the position.
    // rust: pub(super) fn block_entity_tag(&self, pos: [i32; 3]) -> Option<Tag> {
    // rust: let e = self.world.block_entities.get(&(pos[0], pos[1], pos[2]))?;
    // rust: let name = self.data_block_name(pos);
    // rust: let mut tag = horizon_client::save::encode_block_entity((pos[0], pos[1], pos[2]), e, &name);
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: for key in ["id", "x", "y", "z", "keepPacked"] {
    // rust: c.remove(&key.into());
}
}
    // rust: Some(tag)
}
    /// `ClientPacketListener.handleTagQueryPacket`: the server's answer to
    /// the last debug query (`DebugQueryHandler.handleResponse`) completes
    /// it; an answer to an older query is ignored.
    // rust: pub(super) fn answer_tag_query(&mut self, transaction: i32, tag: Tag) {
    // rust: let Some(reply) = self
    // rust: .remote
    // rust: .as_mut()
    // rust: .and_then(|r| r.debug_query.answer(transaction))
    // rust: else {
    // rust: return;
}
        // FriendlyByteBuf.readNbt: an End tag is no compound.
    // rust: let tag = match tag {
    // rust: Tag::End => None,
    // rust: tag => Some(tag),
}
    // rust: match reply {
    // rust: QueryReply::Block { pos, state } => {
    // rust: self.copy_create_block_command(pos, &state, tag.as_ref());
    // rust: self.debug_translated("debug.inspect.server.block");
}
    // rust: QueryReply::Entity { id, kind, position } => {
                // Entity.position() when the answer comes: where it is now,
                // else where it was last.
    // rust: let position = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .map_or(position, |m| m.position);
    // rust: self.copy_create_entity_command(&kind, position, tag);
    // rust: self.debug_translated("debug.inspect.server.entity");
}
}
}
    /// `KeyboardHandler.copyCreateBlockCommand`.
pub fn copy_create_block_command(self: *Self, pos: [i32; 3], state: []const u8, tag: ?*Tag) void {
}
    // rust: let mut description = state.to_owned();
    // rust: if let Some(tag) = tag {
    // rust: description.push_str(&horizon_client::snbt::to_snbt(tag));
}
    // rust: self.set_clipboard(&format!(
    // rust: "/setblock {} {} {} {description}",
    // rust: pos[0], pos[1], pos[2]
    // rust: ));
}
    /// `KeyboardHandler.copyCreateEntityCommand`: the data without its UUID
    /// or position.
pub fn copy_create_entity_command(self: *Self, kind: []const u8, pos: Vec3, tag: ?Tag) void {
}
//         use horizon_client::java_text::format_fixed2 as f2;
    // rust: let mut command = format!("/summon {kind} {} {} {}", f2(pos.x), f2(pos.y), f2(pos.z));
    // rust: if let Some(mut tag) = tag {
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: for key in ["UUID", "Pos"] {
    // rust: c.remove(&key.into());
}
}
    // rust: command.push(' ');
    // rust: command.push_str(&horizon_client::snbt::pretty(&tag).plain());
}
    // rust: self.set_clipboard(&command);
}
    /// `KeyboardHandler.setClipboard`.
pub fn set_clipboard(self: *Self, text: []const u8) void {
}
//         use horizon_client::clipboard::Clipboard;
    // rust: self.clipboard.set(text);
}
    /// The debug renderers' gizmos for a frame (`DebugRenderer.emitGizmos`).
    // rust: pub(super) fn debug_gizmos(&self, alpha: f32, camera: [f64; 3]) -> Gizmos {
    // rust: let mut g = Gizmos::default();
    // rust: self.bounding_box_gizmos(camera, &mut g);
    // rust: self.debug_renderer_gizmos(&mut g);
    // rust: if self.debug_entry("chunk_borders")
    // rust: && let Some(p) = &self.player
    // rust: {
    // rust: let block = [
    // rust: p.position.x.floor() as i32,
    // rust: p.position.y.floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: ];
    // rust: let min_y = self.world.bottom_y();
    // rust: g.chunk_borders(block, min_y, min_y + self.world.layout().height() - 1);
}
    // rust: if !self.debug_entry("entity_hitboxes") {
    // rust: return g;
}
    // rust: let lerp = |a: f64, b: f64| a + f64::from(alpha) * (b - a);
    // rust: let lerpf = |a: f32, b: f32| a + alpha * (b - a);
    // rust: for m in self.mobs.iter() {
    // rust: if m.removed || m.invisible || m.has_effect("minecraft:invisibility") {
    // rust: continue;
}
    // rust: let pos = [
    // rust: lerp(m.previous.x, m.position.x),
    // rust: lerp(m.previous.y, m.position.y),
    // rust: lerp(m.previous.z, m.position.z),
    // rust: ];
    // rust: let view = (
    // rust: lerpf(m.previous_head_pitch, m.head_pitch),
    // rust: lerpf(m.previous_head_yaw, m.head_yaw),
    // rust: );
    // rust: g.hitbox(
    // rust: pos,
    // rust: (m.width(), m.height()),
    // rust: m.eye_height() as f32,
    // rust: true,
    // rust: view,
    // rust: );
}
    // rust: for item in &self.dropped {
    // rust: let pos = [
    // rust: lerp(item.previous.x, item.position.x),
    // rust: lerp(item.previous.y, item.position.y),
    // rust: lerp(item.previous.z, item.position.z),
    // rust: ];
            // EntityType.ITEM: 0.25 by 0.25, eyes at 0.2125.
    // rust: g.hitbox(pos, (0.25, 0.25), 0.2125, false, (0.0, 0.0));
}
        // The other entities (EntityTypes sizes; eyes at 0.85 of the height
        // unless the type sets one). `at` is the interpolated position.
    // rust: let at = |previous: Vec3, now: Vec3| {
    // rust: [
    // rust: lerp(previous.x, now.x),
    // rust: lerp(previous.y, now.y),
    // rust: lerp(previous.z, now.z),
    // rust: ]
}
    // rust: for p in &self.paintings {
    // rust: let (min, max) = p.bounds();
    // rust: let centre = std::array::from_fn(|i| (min[i] + max[i]) / 2.0);
    // rust: g.entity_box(min, max, centre, 0.425, false, step_view(p.step()));
}
    // rust: for f in self.item_frames.iter().filter(|f| !f.invisible) {
    // rust: let (min, max) = f.bounds();
    // rust: let centre = std::array::from_fn(|i| (min[i] + max[i]) / 2.0);
    // rust: g.entity_box(min, max, centre, 0.0, false, step_view(f.step()));
}
    // rust: for c in &self.cushions {
    // rust: let (min, max) = c.bounds();
    // rust: let p = c.position;
    // rust: g.entity_box(min, max, [p.x, p.y, p.z], 0.2125, false, (0.0, c.yaw));
}
        // Interaction: EntityDimensions.scalable(width, height), so its eyes
        // are at 0.85 of the height. Its rotation is not kept here.
    // rust: for i in self.interactions.values() {
    // rust: let b = i.bounds();
    // rust: let p = i.position;
    // rust: g.entity_box(
    // rust: [b.min(Axis::X), b.min(Axis::Y), b.min(Axis::Z)],
    // rust: [b.max(Axis::X), b.max(Axis::Y), b.max(Axis::Z)],
    // rust: [p.x, p.y, p.z],
    // rust: i.height.max(0.0) * 0.85,
    // rust: false,
    // rust: (0.0, 0.0),
    // rust: );
}
    // rust: for a in self.armor_stands.iter().filter(|a| !a.invisible) {
            // ArmorStand.getDimensions: a marker has none, a small one is
            // half scale with its eyes at 0.9875.
    // rust: let (size, eye) = match (a.marker, a.small) {
    // rust: (true, _) => ((0.0, 0.0), 0.0),
    // rust: (_, true) => ((0.25, 0.9875), 0.9875),
    // rust: _ => ((0.5, 1.975), 1.7775),
}
    // rust: g.hitbox(
    // rust: at(a.previous, a.position),
    // rust: size,
    // rust: eye,
    // rust: true,
    // rust: (0.0, a.render_yaw(alpha)),
    // rust: );
}
    // rust: for b in &self.boats {
    // rust: let h = super::boats::HEIGHT as f32;
    // rust: g.hitbox(
    // rust: at(b.previous, b.position),
    // rust: (super::boats::WIDTH as f32, h),
    // rust: h,
    // rust: false,
    // rust: (0.0, b.yaw),
    // rust: );
}
    // rust: for c in &self.carts {
    // rust: let (w, h) = (
    // rust: super::minecarts::WIDTH as f32,
    // rust: super::minecarts::HEIGHT as f32,
    // rust: );
    // rust: g.hitbox(
    // rust: at(c.previous, c.position),
    // rust: (w, h),
    // rust: h * 0.85,
    // rust: false,
    // rust: (0.0, c.yaw),
    // rust: );
}
    // rust: for o in &self.orbs {
    // rust: g.hitbox(
    // rust: at(o.previous, o.position),
    // rust: (0.5, 0.5),
    // rust: 0.425,
    // rust: false,
    // rust: (0.0, 0.0),
    // rust: );
}
    // rust: for f in &self.falling {
    // rust: g.hitbox(
    // rust: at(f.previous, f.position),
    // rust: (0.98, 0.98),
    // rust: 0.833,
    // rust: false,
    // rust: (0.0, 0.0),
    // rust: );
}
    // rust: for t in &self.tnts {
    // rust: g.hitbox(
    // rust: at(t.previous, t.position),
    // rust: (0.98, 0.98),
    // rust: 0.15,
    // rust: false,
    // rust: (0.0, 0.0),
    // rust: );
}
    // rust: for c in &self.crystals {
    // rust: let p = c.position;
    // rust: g.hitbox([p.x, p.y, p.z], (2.0, 2.0), 1.7, false, (0.0, 0.0));
}
    // rust: for p in &self.creatures.projectiles {
//             use horizon_client::projectiles::ProjectileKind as K;
    // rust: let (size, eye) = match p.kind {
    // rust: K::Arrow { .. } | K::Trident => (0.5, 0.13),
    // rust: K::Snowball
    // rust: | K::Egg
    // rust: | K::EnderPearl
    // rust: | K::LlamaSpit
    // rust: | K::Potion { .. }
    // rust: | K::ExperienceBottle
    // rust: | K::Thrown(_) => (0.25, 0.2125),
    // rust: K::SmallFireball | K::ShulkerBullet { .. } | K::WitherSkull { .. } => {
    // rust: (0.3125, 0.265_625)
}
    // rust: K::WindCharge | K::BreezeWindCharge => (0.3125, 0.0),
    // rust: K::LargeFireball { .. } => (1.0, 0.85),
}
    // rust: g.hitbox(
    // rust: at(p.previous, p.position),
    // rust: (size, size),
    // rust: eye,
    // rust: false,
    // rust: (p.pitch, p.yaw),
    // rust: );
}
    // rust: for t in &self.tridents {
    // rust: g.hitbox(
    // rust: at(t.previous, t.position),
    // rust: (0.5, 0.5),
    // rust: 0.13,
    // rust: false,
    // rust: (t.pitch, t.yaw),
    // rust: );
}
        // EntityType.EYE_OF_ENDER: 0.25 by 0.25, never turned.
    // rust: for (previous, now) in self.end.eye_motions() {
    // rust: let v = |p: glam::DVec3| Vec3::new(p.x, p.y, p.z);
    // rust: g.hitbox(
    // rust: at(v(previous), v(now)),
    // rust: (0.25, 0.25),
    // rust: 0.2125,
    // rust: false,
    // rust: (0.0, 0.0),
    // rust: );
}
    // rust: for r in &self.rockets {
            // Projectile.updateRotation: the look follows the motion.
    // rust: let v = r.velocity;
    // rust: let yaw = v.x.atan2(v.z).to_degrees() as f32;
    // rust: let pitch = v.y.atan2(v.x.hypot(v.z)).to_degrees() as f32;
    // rust: g.hitbox(
    // rust: at(r.previous, r.position),
    // rust: (0.25, 0.25),
    // rust: 0.2125,
    // rust: false,
    // rust: (pitch, yaw),
    // rust: );
}
    // rust: for h in self
    // rust: .hook
    // rust: .iter()
    // rust: .map(|h| (h.previous, h.position))
    // rust: .chain(self.remote_hooks.iter().map(|h| (h.previous, h.position)))
    // rust: {
    // rust: g.hitbox(at(h.0, h.1), (0.25, 0.25), 0.2125, false, (0.0, 0.0));
}
    // rust: for b in &self.bolts {
    // rust: g.hitbox(b.at, (0.0, 0.0), 0.0, false, (0.0, 0.0));
}
        // AreaEffectCloud.getDimensions: diameter follows synced radius,
        // height is 0.5; EntityDimensions.scalable gives eyes at 85% height.
    // rust: for c in &self.potions.clouds {
    // rust: g.hitbox(c.at, (c.radius * 2.0, 0.5), 0.425, false, (0.0, 0.0));
}
        // The dragon: 16 by 8, a living entity; its parts follow.
    // rust: if let Some(d) = &self.dragon {
    // rust: g.hitbox(
    // rust: at(d.previous, d.position),
    // rust: (16.0, 8.0),
    // rust: 6.8,
    // rust: true,
    // rust: (0.0, d.yaw),
    // rust: );
}
        // The dragon's parts.
    // rust: for (id, b) in self.special_targets() {
    // rust: if (super::dragon::SPECIAL..super::dragon::SPECIAL + 8).contains(&id) {
    // rust: g.cuboid(
    // rust: [b.min(Axis::X), b.min(Axis::Y), b.min(Axis::Z)],
    // rust: [b.max(Axis::X), b.max(Axis::Y), b.max(Axis::Z)],
    // rust: horizon_client::gizmos::DRAGON_PART,
    // rust: horizon_client::gizmos::STROKE_WIDTH,
    // rust: );
}
}
        // The player's own, unless the camera is in its head.
    // rust: if !self.camera_type.first_person()
    // rust: && let Some(p) = &self.player
    // rust: {
    // rust: let d = p.dimensions;
    // rust: let pos = [
    // rust: lerp(self.previous_position.x, p.position.x),
    // rust: lerp(self.previous_position.y, p.position.y),
    // rust: lerp(self.previous_position.z, p.position.z),
    // rust: ];
    // rust: g.hitbox(
    // rust: pos,
    // rust: (d.width, d.height),
    // rust: d.eye_height,
    // rust: true,
    // rust: (self.pitch, self.yaw),
    // rust: );
}
    // rust: g
}
}

/// The (x, y) rotations whose view vector is the step of a direction.
pub fn step_view(step: [i32; 3]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = step.map(f64::from);
    // rust: (
    // rust: (-y).asin().to_degrees() as f32,
    // rust: (-x.atan2(z)).to_degrees() as f32,
    // rust: )
}

/// `DebugQueryHandler`: the last debug NBT query (F3+I) sent to the server
/// and what its answer completes. Only the newest query is answered.
    // rust: pub(super) struct DebugQuery {
    // rust: transaction: i32,
    // rust: pending: Option<QueryReply>,
}
    // rust: impl Default for DebugQuery {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: transaction: -1,
    // rust: pending: None,
}
}
}
/// What a debug query's answer is copied into: the block command
/// (`copyCreateBlockCommand`) or the entity's (`copyCreateEntityCommand`).
    // rust: pub(super) enum QueryReply {
    // rust: Block {
    // rust: pos: [i32; 3],
    // rust: state: String,
    // rust: },
    // rust: Entity {
    // rust: id: u32,
    // rust: kind: String,
    // rust: position: Vec3,
    // rust: },
}
    // rust: impl DebugQuery {
    /// `DebugQueryHandler.startTransaction`: the next transaction id, which
    /// replaces any query still waiting.
pub fn start(self: *Self, reply: QueryReply) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pending = Some(reply);
    // rust: self.transaction = self.transaction.wrapping_add(1);
    // rust: self.transaction
}
    /// `DebugQueryHandler.handleResponse`: what the answer to `transaction`
    /// completes, once, when it answers the newest query.
pub fn answer(self: *Self, transaction: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if transaction == self.transaction {
    // rust: self.pending.take()
    // rust: } else {
    // rust: None
}
}
}

/// `DebugEntryChunkGeneration`'s `lastPos` and `result`: F3's `Density` line is sampled again
/// only when the feet block or the dimension changes. Vanilla adds the group only inside its
/// server-level branch, so with no generator (a remote server, a LAN world joined, the server
/// thread not there yet) nothing is drawn and nothing of the last world is kept.
    // rust: pub(super) struct DensityCache(Option<(&'static str, [i32; 3], Option<String>)>);
    // rust: impl DensityCache {
    /// The line to draw; `sample` is `None` without a generator.
    // rust: pub(super) fn line(
    // rust: &mut self,
    // rust: dim: &'static str,
    // rust: feet: [i32; 3],
    // rust: sample: Option<impl FnOnce() -> Option<String>>,
    // rust: ) -> Option<&str> {
    // rust: let Some(sample) = sample else {
    // rust: self.0 = None;
    // rust: return None;
}
    // rust: if !self
    // rust: .0
    // rust: .as_ref()
    // rust: .is_some_and(|(d, f, _)| *d == dim && *f == feet)
    // rust: {
    // rust: self.0 = Some((dim, feet, sample()));
}
    // rust: self.0.as_ref().and_then(|(_, _, line)| line.as_deref())
}
    /// Another world: its generator, not the last one's line.
    // rust: pub(super) fn clear(&mut self) {
    // rust: self.0 = None;
}
}

    // rust: mod tests {
//     use super::*;

pub fn block(x: i32) Q {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: QueryReply::Block {
    // rust: pos: [x, 64, 0],
    // rust: state: "minecraft:chest[facing=north,type=single,waterlogged=false]".into(),
}
}

pub fn a_debug_query_is_answered_once_and_only_the_newest() void {
}
    // rust: let mut q = DebugQuery::default();
        // The first transaction is 0 (the handler starts at -1).
    // rust: assert_eq!(q.start(block(1)), 0);
    // rust: assert_eq!(q.answer(0), Some(block(1)));
    // rust: assert_eq!(q.answer(0), None);
        // A second press before the first answer: the older answer is ignored
        // and the newer one copies the newer target.
    // rust: assert_eq!(q.start(block(2)), 1);
    // rust: assert_eq!(q.start(block(3)), 2);
    // rust: assert_eq!(q.answer(1), None);
    // rust: assert_eq!(q.answer(2), Some(block(3)));
}

pub fn the_density_line_is_sampled_when_the_block_or_the_dimension_changes() void {
}
    // rust: let mut cache = DensityCache::default();
    // rust: let samples = std::cell::Cell::new(0);
    // rust: let at = |cache: &mut DensityCache, dim, feet, present: bool| {
    // rust: let sample = || {
    // rust: samples.set(samples.get() + 1);
    // rust: Some(format!("Density {}", samples.get()))
}
    // rust: cache
    // rust: .line(dim, feet, if present { Some(sample) } else { None })
    // rust: .map(str::to_owned)
}
        // Standing still draws the first sample again and again.
    // rust: assert_eq!(
    // rust: at(&mut cache, "o", [0, 70, 0], true).as_deref(),
    // rust: Some("Density 1")
    // rust: );
    // rust: assert_eq!(
    // rust: at(&mut cache, "o", [0, 70, 0], true).as_deref(),
    // rust: Some("Density 1")
    // rust: );
        // A new block, then a new dimension at the same block, sample again.
    // rust: assert_eq!(
    // rust: at(&mut cache, "o", [1, 70, 0], true).as_deref(),
    // rust: Some("Density 2")
    // rust: );
    // rust: assert_eq!(
    // rust: at(&mut cache, "n", [1, 70, 0], true).as_deref(),
    // rust: Some("Density 3")
    // rust: );
        // No generator: nothing is drawn, nothing is kept, even on the same block.
    // rust: assert_eq!(at(&mut cache, "n", [1, 70, 0], false), None);
    // rust: assert_eq!(
    // rust: at(&mut cache, "n", [1, 70, 0], true).as_deref(),
    // rust: Some("Density 4")
    // rust: );
        // Another world clears it too.
    // rust: cache.clear();
    // rust: assert_eq!(
    // rust: at(&mut cache, "n", [1, 70, 0], true).as_deref(),
    // rust: Some("Density 5")
    // rust: );
}
}
