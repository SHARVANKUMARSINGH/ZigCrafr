//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pad
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Controllers through gilrs (Horizon's own; docs/controllers.md): the
//! active pad's state each loop iteration, its button edges dispatched as
//! the vanilla key mappings they are bound to, the left stick as an analog
//! move vector and the right stick turning the view. `horizon-ctl pad`
//! injects a virtual pad on top of the real one.
// use super::event_loop::EventLoopCtl;
// use super::{Game, Screen};
// use horizon_client::actions::Action;
// use horizon_client::held::Source;
// use horizon_client::{
    // rust: Result,
    // rust: controller_notice::{Glyph, Notice, NoticeId, Priority},
    // rust: controller_ui::Device,
    // rust: gamepad::{self, Button, Edges, GlyphStyle, HealthWatch, PadState, Route, Rumble},
    // rust: keymapping::SNEAK,
}
// use serde_json::{Value, json};
// use std::time::{Duration, Instant};
// use winit::event::MouseButton;
// use winit::keyboard::KeyCode;

    // rust: pub(super) const HELP: &[&str] = &[
    // rust: "pad BUTTON down|up|tap         a virtual controller button (south east west north lb rb lt rt select start ls rs up down left right)",
    // rust: "pad stick left|right X Y       tilt a virtual stick (-1..1, up positive); 0 0 centres it",
    // rust: "pad trigger left|right VALUE   pull a virtual trigger (0..1)",
    // rust: "pad release                    centre and release the virtual controller",
    // rust: "pad status                     connected controllers, the active one and its state",
    // rust: "pad connection connected|disconnected   as if a controller came or went at this game's own reader",
    // rust: ];

/// The controllers and the state the game last acted on.
    // rust: pub(super) struct Pads {
    /// Splitscreen: this player's pad, read by `PadRouter` for every game, instead of the pads.
    // rust: pub(super) feed: Option<PadState>,
    /// The pad behind `feed`.
    // rust: feed_source: Option<PadId>,
    /// The real controllers and the DualSense's output.
    // rust: devices: hardware::Devices,
    /// The virtual pad of `horizon-ctl pad`.
    // rust: injected: PadState,
    /// The virtual pad was in use at the last poll.
    // rust: virtual_input: bool,
    /// Buttons a `pad ... tap` releases at the next poll.
    // rust: taps: Vec<Button>,
    // rust: edges: Edges,
    // rust: activity: gamepad::Activity,
    // rust: context: Option<Context>,
    // rust: blocked_sticks: [bool; 2],
    /// Releases use the action that received the press, even after a rebind.
    // rust: actions: [Vec<&'static str>; 16],
    /// The game tick each button went down in, and releases held back until
    /// a tick has passed: vanilla samples keys once per tick, so a click
    /// shorter than that (a quick stick click for sprint) would be lost.
    // rust: pressed_at: [Option<u64>; 16],
    // rust: late_releases: Vec<Button>,
    /// The merged state of the last poll.
    // rust: pub(super) state: PadState,
    /// The hardware's buttons at the last poll, for `input-log`'s `pad`
    /// events: the merged state hides which source moved.
    // rust: last_hardware: PadState,
    /// The pad drove the game last (the mouse and keyboard hand control back).
    // rust: pub(super) in_use: bool,
    // rust: pub(super) style: GlyphStyle,
    /// The controller driving this player, or else the first one its own reader sees.
    // rust: pub(super) device: Option<Device>,
    /// Controllers that came and went at this game's own reader since the last poll.
    // rust: connections: Vec<Connection>,
    /// The cursor the pad drives in menus.
    // rust: pub(super) menu: super::pad_menu::MenuCursor,
    /// The last vibration asked for, for `pad status`.
    // rust: last_rumble: Option<(&'static str, gamepad::Pulse)>,
    /// The drop button, while it is held in play.
    // rust: held_drop: Option<gamepad::HeldDrop>,
    /// The drop about to happen is the pad's stack form: it has no Control for `drop_whole_stack`.
    /// On a server the drop waits for the tick.
    // rust: pub(super) drop_stack: bool,
    /// The player's health between polls (a drop is damage taken).
    // rust: health: HealthWatch,
}

pub const Context = struct {
    screen: u64,
    focus_navigation: bool,
    focused: bool,
    osk: bool,
    dialog: bool,
    enabled: bool,
};

    // rust: mod hardware;
    // rust: mod parity_tests;
    // rust: pub(super) use hardware::{PadId, PadRouter};

/// A controller coming or going, for this player's notice (`pad_connection_notice`).
pub const Connection = enum {
    /// A controller of this glyph family connected.
    Connected(GlyphStyle),
    /// One disconnected; `active`: it was driving this player.
    Disconnected { active: bool },
};

/// What a controller did since the last frame.
    // rust: pub(in crate::game) enum PadEvent {
    // rust: Press(PadId, Button),
    /// Disconnected (out of battery, unplugged, out of range).
    // rust: Gone(PadId),
    /// Connected again under the same id (Windows keeps it; macOS gives a new one). On Linux
    /// gilrs gives a new device the slot of a disconnected one of the same model, so there this
    /// can be another controller of that model.
    // rust: Back(PadId),
}

/// A build without the `controllers` feature (the server build, which must not need libudev): no
/// hardware pads, only `horizon-ctl pad`'s virtual one.
    // rust: mod hardware {
//     use super::{super::Game, Pads};
//     use horizon_client::gamepad::{PadState, Pulse, Rumble};
//     use serde_json::{Value, json};

    // rust: impl Pads {
    // rust: pub(super) fn read(&mut self) -> PadState {
    // rust: PadState::default()
}
    // rust: pub(in crate::game) fn release_hardware(&mut self) {}
}

    // rust: pub(in crate::game) type PadId = usize;
    // rust: pub(in crate::game) struct PadRouter {}
    // rust: impl PadRouter {
    // rust: pub(in crate::game) fn adopt(&mut self, _: &mut Pads) {}
    // rust: pub(in crate::game) fn hand_back(&mut self, _: &mut Pads) {}
    // rust: pub(in crate::game) fn events(&mut self) -> Vec<super::PadEvent> {
    // rust: Vec::new()
}
    // rust: pub(in crate::game) fn device(
    // rust: &self,
    // rust: _: PadId,
    // rust: ) -> Option<horizon_client::controller_ui::Device> {
    // rust: None
}
    // rust: pub(in crate::game) fn lend_output(&mut self, _: &mut Pads, _: PadId) {}
    // rust: pub(in crate::game) fn reclaim_output(&mut self, _: &mut Pads) {}
    // rust: pub(in crate::game) fn report_status(&self, _: &mut Pads, _: Option<PadId>) {}
    // rust: pub(in crate::game) fn connected(&self, _: PadId) -> bool {
    // rust: false
}
    // rust: pub(in crate::game) fn uuid(&self, _: PadId) -> [u8; 16] {
    // rust: [0; 16]
}
    // rust: pub(in crate::game) fn state(&self, _: PadId) -> PadState {
    // rust: PadState::default()
}
    // rust: pub(in crate::game) fn name(&self, _: PadId) -> String {
    // rust: String::new()
}
    // rust: pub(in crate::game) fn style(&self, _: PadId) -> horizon_client::gamepad::GlyphStyle {
    // rust: horizon_client::gamepad::GlyphStyle::Auto
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn pad_output_off(&mut self) {}
    // rust: pub(super) fn pad_output_frame(&mut self) {}
    // rust: pub(in crate::game) fn pad_close_output(&mut self) {}
    // rust: pub(super) fn pad_vibrate(&mut self, _: Rumble, _: Pulse) {}
    // rust: pub(super) fn pad_devices_status(&self) -> Value {
    // rust: json!({ "backend": false, "controllers": [] })
}
}
}

    // rust: impl Pads {
    /// The digital buttons the person's pad changed since the last poll.
    // rust: pub(super) fn hardware_edges(&mut self, hardware: PadState) -> Vec<(Button, bool)> {
    // rust: let edges = Button::ALL
    // rust: .into_iter()
    // rust: .filter_map(|button| {
    // rust: let was = self.last_hardware.held(button);
    // rust: let now = hardware.held(button);
    // rust: (was != now).then_some((button, now))
    // rust: })
    // rust: .collect();
    // rust: self.last_hardware = hardware;
    // rust: edges
}

    /// A replay's pad button, in place of `pad`'s line.
    // rust: pub(super) fn inject_button(&mut self, button: Button, down: bool) {
    // rust: self.injected.set(button, down);
}
    /// Splitscreen: this player's pad state, from `source`. Another pad, or
    /// none: the old one's A going away isn't a release.
    // rust: pub(super) fn feed_from(&mut self, source: Option<PadId>, state: PadState) {
    // rust: if self.feed_source != source {
    // rust: self.feed_source = source;
    // rust: self.menu.armed = None;
}
    // rust: self.feed = Some(state);
}
    /// The device the controller settings name: a real one, else `horizon-ctl`'s virtual pad.
    // rust: pub(super) fn device_or_virtual(&self) -> Option<Device> {
    // rust: self.device.clone().or_else(|| {
    // rust: self.in_use.then(|| Device {
    // rust: name: "Virtual controller".to_owned(),
    // rust: vendor: None,
    // rust: product: None,
    // rust: })
    // rust: })
}
    /// A replay ended: let go of everything it held.
    // rust: pub(super) fn clear_injected(&mut self) {
    // rust: self.menu.armed = None;
    // rust: self.injected = PadState::default();
}

    /// Include releases delayed until the next simulation tick.
    // rust: pub(super) fn holds_action(&self, settings: &gamepad::PadSettings, action: &str) -> bool {
    // rust: settings.binding(action).is_some_and(|button| {
    // rust: self.edges.is_held(button) || self.late_releases.contains(&button)
    // rust: })
}

    /// A new player entity took over (spawn, respawn, a server joined, a
    /// dimension change): its health is not compared with the old one's.
    // rust: pub(super) fn player_replaced(&mut self) {
    // rust: self.health.forget();
}

    /// The active pad is a Nintendo one going by its letters.
pub fn by_letter(self: *Self, settings: *gamepad::PadSettings) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.style == GlyphStyle::Nintendo && settings.nintendo_letters
}
}

    // rust: impl Game<'_> {
pub fn pad_context(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Context {
    // rust: screen: self.key_screen(),
    // rust: focus_navigation: self.pad_navigation_mode(),
    // rust: focused: self.focused,
    // rust: osk: self.pad.menu.osk.is_some(),
    // rust: dialog: self.dialog_open() || self.code_of_conduct.is_some(),
    // rust: enabled: self.settings.controller.enabled,
}
}

    /// Once per loop iteration: read the pads and act on button changes.
    // rust: pub(super) fn poll_pads(&mut self, event_loop: &dyn EventLoopCtl) {
    // rust: self.pad.virtual_input = self.pad.injected != PadState::default();
    // rust: let context = self.pad_context();
    // rust: if let Some(old) = self.pad.context.filter(|old| *old != context) {
    // rust: if old.screen != context.screen {
    // rust: self.pad_remember_focus(old.screen);
}
    // rust: self.pad_cancel_inputs(event_loop);
}
    // rust: self.pad.context = Some(context);
    // rust: if !self.settings.controller.enabled {
    // rust: self.pad_output_off();
    // rust: self.pad_cancel_inputs(event_loop);
    // rust: self.pad.state = PadState::default();
    // rust: self.pad.in_use = false;
            // The keyboard's menu focus follows its widget all the same.
    // rust: self.pad_menu_frame(event_loop);
    // rust: return;
}
    // rust: let hardware = match self.pad.feed {
    // rust: Some(state) => state,
    // rust: None => self.pad.read(),
}
        // A Nintendo pad going by its letters is read that way: its own, or the one
        // splitscreen's router feeds this player.
    // rust: let hardware = if self.pad.by_letter(&self.settings.controller) {
    // rust: hardware.by_letter()
    // rust: } else {
    // rust: hardware
}
        // A person's pad, for `input-log` and the repro recording; the virtual
        // pad is an agent's `pad` line and is recorded as that.
    // rust: let hardware_edges = self.pad.hardware_edges(hardware);
    // rust: for (button, down) in hardware_edges {
    // rust: self.note_input(
    // rust: super::input_trace::InputOrigin::User,
    // rust: super::input_trace::TraceKind::Pad {
    // rust: button: button.name().to_owned(),
    // rust: action: if down { "down" } else { "up" }.to_owned(),
    // rust: },
    // rust: );
}
    // rust: for change in std::mem::take(&mut self.pad.connections) {
    // rust: self.pad_connection_notice(change);
}
    // rust: let style = self.settings.controller.glyphs.resolve(self.pad.style);
    // rust: self.ui.options.pad_style = style;
        // Nintendo glyphs on a pad going by its letters name the button playing each part.
    // rust: self.ui.options.pad_by_letter =
    // rust: style == GlyphStyle::Nintendo && self.pad.by_letter(&self.settings.controller);
    // rust: self.ui.options.pad_driving = self.pad.in_use && self.pad_focus_mode();
    // rust: let mut state = hardware.merge(&self.pad.injected);
    // rust: let activity = self.pad.activity.observe(&state, &self.settings.controller);
    // rust: for (i, (stick, deadzone)) in [
    // rust: (&mut state.left, self.settings.controller.move_deadzone),
    // rust: (&mut state.right, self.settings.controller.look_deadzone),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if gamepad::radial(*stick, deadzone) == [0.0; 2] {
    // rust: self.pad.blocked_sticks[i] = false;
}
    // rust: if self.pad.blocked_sticks[i] || !self.pad_focused() {
    // rust: *stick = [0.0; 2];
}
}
    // rust: for button in std::mem::take(&mut self.pad.taps) {
    // rust: self.pad.injected.set(button, false);
}
    // rust: let threshold = self.settings.controller.trigger_threshold;
    // rust: let edges = self.pad.edges.update(&state, threshold);
    // rust: if activity && self.pad_focused() {
    // rust: self.last_input = Instant::now();
    // rust: self.pad.in_use = true;
}
    // rust: self.pad.state = state;
    // rust: self.pad_drop_frame();
    // rust: self.pad_output_frame();
        // Damage from any source, here or on a server; nothing counts on
        // the title screen.
    // rust: let health = self
    // rust: .player
    // rust: .as_ref()
    // rust: .filter(|_| self.title.is_none())
    // rust: .map(|p| p.health.health());
    // rust: if let Some(damage) = self.pad.health.observe(health) {
    // rust: self.pad_rumble(Rumble::Hurt(damage));
}
    // rust: let ticking = self.title.is_none() && self.screen == Screen::Playing && !self.pause;
    // rust: for button in std::mem::take(&mut self.pad.late_releases) {
    // rust: if !ticking || self.pad.pressed_at[button as usize] != Some(self.ticks) {
    // rust: self.pad_button_logged(event_loop, button, false);
    // rust: } else {
    // rust: self.pad.late_releases.push(button);
}
}
    // rust: for (button, down) in edges {
    // rust: self.pad_edge(event_loop, button, down);
    // rust: let context = self.pad_context();
    // rust: if let Some(old) = self.pad.context.filter(|old| *old != context) {
    // rust: if old.screen != context.screen {
    // rust: self.pad_remember_focus(old.screen);
}
    // rust: self.pad_cancel_inputs(event_loop);
    // rust: self.pad.context = Some(context);
    // rust: break;
}
}
    // rust: self.pad_menu_frame(event_loop);
}

pub fn pad_edge(self: *Self, event_loop: *dyn EventLoopCtl, button: Button, down: bool) void {
}
    // rust: let ticking = self.title.is_none() && self.screen == Screen::Playing && !self.pause;
    // rust: if down {
            // Pressed again before its held-back release went out.
    // rust: if let Some(i) = self.pad.late_releases.iter().position(|b| *b == button) {
    // rust: self.pad.late_releases.remove(i);
    // rust: self.pad_button_logged(event_loop, button, false);
}
    // rust: self.pad.pressed_at[button as usize] = Some(self.ticks);
    // rust: } else if ticking && self.pad.pressed_at[button as usize] == Some(self.ticks) {
    // rust: self.pad.late_releases.push(button);
    // rust: return;
}
    // rust: self.pad_button_logged(event_loop, button, down);
}

    /// End held actions and captures before another context receives input.
pub fn pad_cancel_inputs(self: *Self, event_loop: *dyn EventLoopCtl) void {
}
        // Before the releases below: a cancelled press must not click.
    // rust: self.pad.menu.armed = None;
    // rust: let held_sticks = [
    // rust: gamepad::radial(self.pad.state.left, self.settings.controller.move_deadzone)
    // rust: != [0.0; 2],
    // rust: gamepad::radial(self.pad.state.right, self.settings.controller.look_deadzone)
    // rust: != [0.0; 2],
    // rust: ];
    // rust: for (blocked, held) in self.pad.blocked_sticks.iter_mut().zip(held_sticks) {
    // rust: *blocked |= held;
}
    // rust: self.pad.state.left = [0.0; 2];
    // rust: self.pad.state.right = [0.0; 2];
    // rust: self.pad.late_releases.clear();
    // rust: for (button, down) in self.pad.edges.cancel() {
    // rust: self.pad_button_logged(event_loop, button, down);
}
        // A short tap may already be up in Edges but still await its simulation tick.
    // rust: for button in Button::ALL {
    // rust: for action in std::mem::take(&mut self.pad.actions[button as usize]) {
    // rust: if let Err(e) = self.pad_action(action, false) {
    // rust: log::warn!("Horizon: releasing controller action {action}: {e}");
}
}
}
    // rust: self.pad_cancel_menu(event_loop);
}

    // rust: pub(super) fn pad_yield_input(&mut self, event_loop: &dyn EventLoopCtl) {
    // rust: if self.pad.in_use {
    // rust: self.pad.in_use = false;
    // rust: self.pad_cancel_inputs(event_loop);
}
}

pub fn pad_button_logged(self: *Self, event_loop: *dyn EventLoopCtl, button: Button, down: bool) void {
}
    // rust: if let Err(e) = self.pad_button(event_loop, button, down) {
    // rust: log::warn!("Horizon: controller {}: {e}", button.name());
}
}

    /// Input from the pad counts while the window has focus, or always for
    /// the virtual pad (a script can't focus the window).
pub fn pad_focused(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.focused || self.pad.virtual_input
}

    // rust: fn pad_button(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: button: Button,
    // rust: down: bool,
    // rust: ) -> Result<()> {
    // rust: if down && !self.pad_focused() {
    // rust: return Ok(());
}
    // rust: let playing = !self.pad_in_menu();
    // rust: if down && playing && !self.captured && self.focused {
            // Like a click into the window: take the pointer.
    // rust: self.capture(true);
}
    // rust: if !playing {
    // rust: self.pad_menu_button(event_loop, button, down)?;
    // rust: if down {
    // rust: return Ok(());
}
    // rust: } else if button == Button::Start {
    // rust: return if down { self.pad_back() } else { Ok(()) };
}
        // Releases always reach the mappings, so nothing stays held when a
        // screen opened in between.
    // rust: let actions = if down {
    // rust: let actions = self.settings.controller.actions_of(button);
    // rust: self.pad.actions[button as usize] = actions.clone();
    // rust: actions
    // rust: } else {
    // rust: std::mem::take(&mut self.pad.actions[button as usize])
}
    // rust: for action in actions {
    // rust: self.pad_action(action, down)?;
}
    // rust: Ok(())
}

    /// A bound action: a vanilla mapping acts as its default key or mouse
    /// button, like a rebound keyboard key.
pub fn pad_action(self: *Self, action: []const u8, down: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(route) = gamepad::route(action) else {
    // rust: log::warn!("Horizon: controller action {action} has no handler");
    // rust: return Ok(());
}
    // rust: match route {
    // rust: Route::HotbarStep { next } => {
    // rust: if down {
    // rust: self.hotbar_step(next);
}
    // rust: Ok(())
}
    // rust: Route::Sneak
    // rust: if self.settings.controller.toggle_sneak && !self.settings.toggle_crouch =>
    // rust: {
                // A stick click flips sneaking instead of holding it, as
                // vanilla's toggle crouch does: a screen opening releases it
                // and closing restores it (ToggleKeyMapping).
    // rust: if !down {
    // rust: return Ok(());
}
    // rust: let screen_open = self.screen != Screen::Playing || self.title.is_some();
    // rust: let was = self.keys.held(Action::Sneak);
    // rust: self.toggles.pad_toggle(SNEAK, screen_open);
    // rust: self.sync_toggle(SNEAK);
    // rust: if !was && self.keys.held(Action::Sneak) {
                    // The pad's latch: a keyboard handoff leaves it.
    // rust: self.keys.press(KeyCode::ShiftLeft, Source::Pad);
    // rust: self.keys.release(&KeyCode::ShiftLeft, Source::Keyboard);
}
    // rust: self.key_pressed(KeyCode::ShiftLeft, KeyCode::ShiftLeft)
}
    // rust: Route::Sneak => self.mapped_key(
    // rust: KeyCode::ShiftLeft,
    // rust: down,
    // rust: false,
    // rust: KeyCode::ShiftLeft,
    // rust: Source::Pad,
    // rust: ),
    // rust: Route::Screenshot => {
    // rust: if down {
    // rust: self.screenshot_action();
}
    // rust: Ok(())
}
    // rust: Route::SmoothCamera => {
    // rust: if down {
    // rust: self.smooth_camera_action();
}
    // rust: Ok(())
}
    // rust: Route::Fullscreen => {
    // rust: if down {
    // rust: self.toggle_fullscreen();
}
    // rust: Ok(())
}
    // rust: Route::Held => Ok(()),
    // rust: Route::Mouse(button) => {
    // rust: let playing = self.title.is_none() && self.screen == Screen::Playing;
                // What the window path tells mods and the click counters. Pick block isn't one
                // they count.
    // rust: if playing
    // rust: && matches!(button, MouseButton::Left | MouseButton::Right)
    // rust: && (down || !self.mouse_mapping_held_elsewhere(button, Source::Pad))
    // rust: {
    // rust: self.extras_mouse(button, down);
}
    // rust: if !down || playing {
    // rust: self.mouse_mapping(button, down, Source::Pad)?;
}
    // rust: Ok(())
}
    // rust: Route::Key(KeyCode::KeyQ) => {
    // rust: self.pad.drop_stack = false;
    // rust: self.pad.held_drop = down.then(|| {
    // rust: let delay = self.settings.controller.repeat_delay;
    // rust: gamepad::HeldDrop::new(Instant::now(), Duration::from_secs_f32(delay))
    // rust: });
    // rust: self.mapped_key(KeyCode::KeyQ, down, false, KeyCode::KeyQ, Source::Pad)
}
    // rust: Route::Key(key) => self.mapped_key(key, down, false, key, Source::Pad),
}
}

    /// Each poll: a held drop button, as a held Q's key repeats reach the mapping.
pub fn pad_drop_frame(self: *Self) void {
}
    // rust: if self.pad_in_menu() || self.screen_over_playing() {
    // rust: return;
}
    // rust: let interval = Duration::from_secs_f32(self.settings.controller.repeat_interval);
    // rust: let step = self
    // rust: .pad
    // rust: .held_drop
    // rust: .as_mut()
    // rust: .and_then(|held| held.due(Instant::now(), interval));
    // rust: let Some(step) = step else {
    // rust: return;
}
    // rust: self.pad.drop_stack = step == gamepad::DropStep::Stack;
    // rust: if let Err(e) = self.mapped_key(KeyCode::KeyQ, true, true, KeyCode::KeyQ, Source::Pad) {
    // rust: log::warn!("Horizon: controller drop: {e}");
}
}

    /// B and Start: what Escape does where the pad is.
    // rust: pub(super) fn pad_back(&mut self) -> Result<()> {
    // rust: if self.prompt_open() {
    // rust: return self.pad_prompt_back();
}
        // The options open over the title screen too: they come first, as
        // for the keyboard's Escape.
    // rust: if self.screen == Screen::Options {
    // rust: return self.options_key(KeyCode::Escape, None);
}
    // rust: if let Some(title) = self.title.as_mut() {
    // rust: title.escape();
    // rust: self.save_title_options();
    // rust: return Ok(());
}
    // rust: if self.sign_edit.is_some() {
    // rust: self.close_sign_editor();
    // rust: return Ok(());
}
    // rust: if self.book.is_some() {
    // rust: self.close_book();
    // rust: return Ok(());
}
    // rust: self.key_pressed(KeyCode::Escape, KeyCode::Escape)
}

    /// The left stick as the move vector, while playing.
    // rust: pub(super) fn pad_move(&self) -> Option<[f32; 2]> {
    // rust: let settings = &self.settings.controller;
    // rust: if !settings.enabled || self.pad_in_menu() || !self.pad_focused() {
    // rust: return None;
}
    // rust: gamepad::move_vector(self.pad.state.left, settings.move_deadzone)
}

    /// Whether `key` is held, a movement key by the left stick too: as the keys the stick holds
    /// (`eight_direction_keys`), whatever moves the player. For readers of the keys that aren't
    /// the movement itself.
    // rust: pub(super) fn movement_key_held(&self, key: KeyCode) -> bool {
    // rust: if self.keys.raw(&key) {
    // rust: return true;
}
    // rust: let Some(stick) = self.pad_move() else {
    // rust: return false;
}
    // rust: let [forward, backward, left, right] = gamepad::eight_direction_keys(stick);
    // rust: match key {
    // rust: KeyCode::KeyW => forward,
    // rust: KeyCode::KeyS => backward,
    // rust: KeyCode::KeyA => left,
    // rust: KeyCode::KeyD => right,
    // rust: _ => false,
}
}

    /// The right stick turns the view, once per frame (`Entity.turn`).
    // rust: pub(super) fn pad_look(&mut self, seconds: f32) {
    // rust: let settings = &self.settings.controller;
    // rust: if !settings.enabled || self.pad_in_menu() || self.player.is_none() || !self.pad_focused() {
    // rust: return;
}
        // A long frame (a hitch) must not spin the view.
    // rust: let (yaw, pitch) = gamepad::look_delta(
    // rust: self.pad.state.right,
    // rust: settings,
    // rust: seconds.min(0.1),
    // rust: self.scoping(),
    // rust: );
    // rust: if yaw == 0.0 && pitch == 0.0 {
    // rust: return;
}
    // rust: self.look_turn(f64::from(yaw / 0.15), f64::from(pitch / 0.15));
}

    /// Vibrate the active pad, when vibration is on and the pad is the one
    /// playing (a pad lying idle while the mouse plays stays still).
    // rust: pub(super) fn pad_rumble(&mut self, rumble: Rumble) {
    // rust: let settings = &self.settings.controller;
    // rust: if !settings.enabled || !settings.vibration || !self.pad.in_use {
    // rust: return;
}
    // rust: let Some(pulse) = rumble.pulse() else {
    // rust: return;
}
    // rust: self.pad.last_rumble = Some((rumble.name(), pulse));
    // rust: self.pad_vibrate(rumble, pulse);
}

    /// `horizon-ctl pad ...`.
    /// A controller came or went with no splitscreen router: say so on this view, in its one
    /// notice. Nothing here decides what the controller drives; a player who turned controllers
    /// off isn't told about them.
pub fn pad_connection_notice(self: *Self, change: Connection) void {
}
    // rust: if !self.settings.controller.enabled {
    // rust: return;
}
    // rust: let split =
    // rust: |key: &str| horizon_client::lang::get(&format!("horizon.splitscreen.prompt.{key}"));
    // rust: let notice = match change {
    // rust: Connection::Connected(family) => Notice::new(
    // rust: NoticeId::Connection,
    // rust: Priority::Info,
    // rust: split("controller_connected"),
    // rust: horizon_client::lang::get("horizon.pad.notice.connected.press"),
    // rust: )
    // rust: .with_glyph(Glyph {
    // rust: button: Button::South,
    // rust: style: self.settings.controller.glyphs.resolve(family),
    // rust: }),
    // rust: Connection::Disconnected { active } => Notice::new(
    // rust: NoticeId::Connection,
    // rust: if active {
    // rust: Priority::Attention
    // rust: } else {
    // rust: Priority::Info
    // rust: },
    // rust: split("controller_disconnected"),
    // rust: split("controller_disconnected.hint"),
    // rust: ),
}
    // rust: self.split_hud.notice.raise(notice);
}

    // rust: pub(super) fn pad_command(&mut self, words: &[&str]) -> Result<Value> {
    // rust: let arg = |i: usize| -> Result<&str> {
    // rust: words
    // rust: .get(i)
    // rust: .copied()
    // rust: .ok_or_else(|| format!("usage: {}", HELP[0]).into())
}
    // rust: let number = |i: usize| -> Result<f32> {
    // rust: let v: f32 = arg(i)?.parse()?;
    // rust: if v.is_finite() {
    // rust: Ok(v)
    // rust: } else {
    // rust: Err("not a number".into())
}
}
    // rust: match arg(1)? {
    // rust: "status" => {
    // rust: let s = &self.pad.state;
    // rust: let held: Vec<&str> = Button::ALL
    // rust: .into_iter()
    // rust: .filter(|b| self.pad.edges.is_held(*b))
    // rust: .map(Button::name)
    // rust: .collect();
    // rust: let mut status = json!({
    // rust: "enabled": self.settings.controller.enabled,
    // rust: "glyphs": self.pad.style.name(),
    // rust: "last_rumble": self.pad.last_rumble.map(|(why, p)| json!({
    // rust: "reason": why, "strong": p.strong, "weak": p.weak, "ms": p.millis,
    // rust: })),
    // rust: "in_use": self.pad.in_use,
    // rust: "notice": self.split_hud.notice.showing().map(|(title, body)| {
    // rust: json!({ "title": title, "body": body })
    // rust: }),
    // rust: "menu": self.pad_menu_status(),
    // rust: "held": held,
    // rust: "left": s.left,
    // rust: "right": s.right,
    // rust: "triggers": s.triggers,
    // rust: });
    // rust: if let (Some(status), Value::Object(devices)) =
    // rust: (status.as_object_mut(), self.pad_devices_status())
    // rust: {
    // rust: status.extend(devices);
}
    // rust: Ok(status)
}
    // rust: "connection" => {
    // rust: let change = match arg(2)? {
    // rust: "connected" => Connection::Connected(GlyphStyle::PlayStation),
    // rust: "disconnected" => Connection::Disconnected { active: true },
    // rust: other => {
    // rust: return Err(format!(
    // rust: "connection must be connected or disconnected, not {other}"
    // rust: )
    // rust: .into());
}
}
    // rust: self.pad.connections.push(change);
    // rust: Ok(json!({ "ok": true }))
}
    // rust: "release" => {
    // rust: self.pad.menu.armed = None;
    // rust: self.pad.injected = PadState::default();
    // rust: self.pad.taps.clear();
    // rust: Ok(json!({ "ok": true }))
}
    // rust: "stick" => {
    // rust: let v = [number(3)?.clamp(-1.0, 1.0), number(4)?.clamp(-1.0, 1.0)];
    // rust: match arg(2)? {
    // rust: "left" => self.pad.injected.left = v,
    // rust: "right" => self.pad.injected.right = v,
    // rust: other => return Err(format!("stick must be left or right, not {other}").into()),
}
    // rust: Ok(json!({ "ok": true }))
}
    // rust: "trigger" => {
    // rust: let v = number(3)?.clamp(0.0, 1.0);
    // rust: match arg(2)? {
    // rust: "left" => self.pad.injected.triggers[0] = v,
    // rust: "right" => self.pad.injected.triggers[1] = v,
    // rust: other => {
    // rust: return Err(format!("trigger must be left or right, not {other}").into());
}
}
    // rust: Ok(json!({ "ok": true }))
}
    // rust: name => {
    // rust: let button = Button::parse(name)
    // rust: .ok_or_else(|| format!("unknown pad button {name}; {}", HELP[0]))?;
    // rust: match arg(2)? {
    // rust: "down" => self.pad.injected.set(button, true),
    // rust: "up" => self.pad.injected.set(button, false),
    // rust: "tap" => {
    // rust: self.pad.injected.set(button, true);
    // rust: self.pad.taps.push(button);
}
    // rust: other => {
    // rust: return Err(
    // rust: format!("pad action must be down, up or tap, not {other}").into()
    // rust: );
}
}
    // rust: Ok(json!({ "ok": true }))
}
}
}
}
