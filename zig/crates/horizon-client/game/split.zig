//! Transpiled from Horizon Rust crate
//! Module: horizon-client_split
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Splitscreen (in parts; #3541): more players on this computer in P1's world, each its own `Game`
//! in this process that joins P1's server thread through memory. Every player renders offscreen
//! on one device and the window's compositor copies their frames into their views (halves for
//! two, `split_layout`). Keyboard and mouse drive the player whose view was clicked last (Esc
//! frees the mouse first). A player who leaves its world (pause menu, Disconnect) drops out;
//! when P1 leaves, all do. Alone, P1 plays exactly as without splitscreen: no compositor.
//!
//! Each player plays in a window: Window 1 (the game's), Window 2, 3... (opened for the players
//! put there, closed with their last player), or one filling a monitor, borderless over it.
//! Players in one window share it. Closing a player's own window drops its players; the game's
//! window hides while nobody plays in it (`windows`). `HORIZON_SPLIT_WINDOWS` (testing, until
//! the Setup screen): each seat's window in order, `1,1,2` (P1 and P2 in Window 1, P3 in Window
//! 2), `m2` for a window filling monitor 2 (left to right).
//!
//! Design: one process, one `Game` per player, one wgpu device. The players share the game's
//! data (`Resources`, the packs), one audio output and P1's server. Not one game process per
//! player: that needs GPU textures, input and audio shared across processes.
//!
//! Controllers: P1's is the first used in a menu. In P1's world a controller it isn't using
//! pressing a button is offered to join, on every view (A joins, Y gives it to P1, B says no); a
//! controller that disconnects leaves its player waiting, its view dimmed, until it comes back
//! or another takes over (`pads`).
//!
//! Horizon Settings > Splitscreen... enables joining (off by default).
//! `HORIZON_SPLIT=N` (testing) enables it too, and
//! N-1 players without one join once P1 is in its world, as P2, P3... (`HORIZON_SPLIT=1`: only
//! the controllers). The player in seat N takes `horizon-ctl` on P1's socket path + "N".

// use super::{
    // rust: Game, UiResources, build_renderer,
    // rust: pad::{PadId, PadRouter},
    // rust: start_game,
}
// use horizon_client::gamepad::Button;
// use horizon_client::split_layout::{self as layout, MAX_PLAYERS, Placement, Spot, View};
// use horizon_client::{Result, gfx::compositor::Compositor, widgets};
// use std::{
    // rust: cell::RefCell,
    // rust: path::{Path, PathBuf},
    // rust: sync::Arc,
    // rust: time::{Duration, Instant},
}
// use winit::{
    // rust: application::ApplicationHandler,
    // rust: dpi::{LogicalPosition, LogicalSize, PhysicalPosition, PhysicalSize},
    // rust: event::{DeviceEvent, DeviceId, ElementState, WindowEvent},
    // rust: event_loop::ActiveEventLoop,
    // rust: monitor::MonitorHandle,
    // rust: window::WindowId,
}

    // rust: mod frames;
    // rust: mod hud;
    // rust: pub(super) mod launcher;
    // rust: mod pads;
    // rust: mod players;
    // rust: mod setup;
    // rust: mod windows;

    // rust: pub(super) use hud::Hud;
// use hud::*;
// use windows::*;

    // rust: thread_local! {
    /// The options file of the player whose turn it is (none for P1, whose is the game's own):
    /// every player runs on this thread, one after another.
pub const OPTIONS: RefCell<?PathBuf> = const { RefCell::new(None) };
}

/// The `options.txt` of the player whose turn it is; `None` for P1.
    // rust: pub(super) fn options_path() -> Option<PathBuf> {
    // rust: OPTIONS.with_borrow(Clone::clone)
}

    // rust: impl Game<'_> {
    /// An error stops the event loop, as ever, but not in another splitscreen player's game:
    /// that player drops out (`Split::drop_out`), the others play on.
    // rust: pub(in crate::game) fn exit_on_error(&self, event_loop: &dyn super::event_loop::EventLoopCtl) {
    // rust: if !self.options.split_guest {
    // rust: event_loop.exit();
}
}
}

pub const WINDOW_1: []const u8 = "Window 1";
pub const NEW_WINDOW: []const u8 = "New window";

pub const Guest = struct {
    game: *Game<'a>,
    /// The profile it plays as; `None` while it picks one.
    name: ?[]const u8,
    /// Its seat (2 to `MAX_PLAYERS`): its number (P2...), its control socket, its sounds.
    seat: usize,
    options: PathBuf,
    /// The controller it plays with.
    pad: ?PadId,
    /// The window it plays in, by number.
    window: u8,
    /// Its buttons and focus targets while another player's game runs.
    widgets: widgets::Saved,
    /// Its profile got into the world: turned away after that (a kick), it leaves; before, it
    /// picks again.
    entered: bool,
    bumpers: [bool,
};

    // rust: pub(super) struct Split<'a> {
    // rust: pub(super) host: Game<'a>,
    // rust: guests: Vec<Guest<'a>>,
    /// `HORIZON_SPLIT=N`: players still to add once P1 is in a world.
    // rust: test_players: usize,
    /// `HORIZON_SPLIT` is set: splitscreen is on for this run, without touching the saved switch.
    // rust: forced: bool,
    /// While another player is in, the windows players play in, each with its compositor: the
    /// game's first, then the others (else P1 draws on its window).
    // rust: surfaces: Vec<Surface>,
    /// The windows players play in (Window 1, the game's, always first), each free or filling a
    /// monitor, and P1's.
    // rust: windows: Vec<layout::Window>,
    // rust: p1_window: u8,
    /// Seats in the order their views fill a shared window.
    // rust: order: Vec<usize>,
    /// Seats represented by the open Setup draft, to detect join/leave changes.
    // rust: setup_seats: Vec<usize>,
    /// Whether Window 1 is shown (hidden while nobody plays in it): set once per change, since
    /// Wayland can't say whether a window is visible.
    // rust: window1_shown: bool,
    /// Where each numbered window was when it closed, to open there again (this session).
    // rust: window_rects: std::collections::HashMap<u8, (LogicalPosition<f64>, LogicalSize<f64>)>,
    /// The monitors with their names, left to right, and the one Window 1 is on: read while
    /// splitscreen is on, once a second (`refresh_monitors`), and when it last read them.
    // rust: screens: Vec<(String, MonitorHandle)>,
    // rust: main_screen: Option<String>,
    // rust: screens_read: Option<Instant>,
    /// `HORIZON_SPLIT_WINDOWS`: each seat's window, `1`, `2`... or `m<monitor>`.
    // rust: window_plan: Vec<String>,
    /// The views the players were last fitted to.
    // rust: applied: Vec<View>,
    /// The player keyboard and mouse drive (0 = P1), and the pointer in the window.
    // rust: focus: usize,
    // rust: cursor: PhysicalPosition<f64>,
    // rust: limiter: horizon_client::window::FramerateLimiter,
    // rust: clock: horizon_client::window::SystemClock,
    /// P1's resources, shared by the other players' games for the process's lifetime.
    // rust: res: Option<&'static Arc<super::Resources>>,
    /// Whose game runs now (0 = P1), and P1's buttons while another's does.
    // rust: turn: usize,
    // rust: host_widgets: widgets::Saved,
    /// The launcher's other Microsoft accounts' sessions, for splitscreen players to sign in
    /// with (`launcher::accounts`).
    // rust: accounts: Vec<Arc<horizon_client::auth::AuthSession>>,
    /// `HORIZON_SPLIT_STATS`: when the frame times were last printed.
    // rust: stats: Option<Instant>,
    /// For the readout: where a frame's wall time goes (the turns with their renders, presents,
    /// the GPU wait, outside `about_to_wait`), summed since the last print, and when this frame
    /// started.
    // rust: spent: [Duration; 4],
    // rust: spent_frames: u32,
    // rust: frame_started: Option<Instant>,
    /// The controllers while several play (`pads`), and P1's.
    // rust: pads: PadRouter,
    // rust: p1_pad: pads::P1Pad<PadId>,
    /// Pads whose buttons still count as the press that gave them: released first.
    // rust: fresh: Vec<PadId>,
    /// Controllers offered to join, each since when: several may join at once.
    // rust: offers: Vec<(PadId, Instant)>,
    /// Players whose controller disconnected, longest waiting first.
    // rust: lost: Vec<pads::Lost<PadId>>,
}

    // rust: impl<'a> Split<'a> {
    // rust: pub(super) fn new(host: Game<'a>) -> Self {
    // rust: let split = std::env::var("HORIZON_SPLIT").ok();
    // rust: let test_players = split
    // rust: .as_ref()
    // rust: .and_then(|n| n.parse::<usize>().ok())
    // rust: .map_or(0, |n| n.clamp(1, MAX_PLAYERS) - 1);
    // rust: Self {
    // rust: host,
    // rust: guests: Vec::new(),
    // rust: test_players,
    // rust: forced: split.is_some(),
    // rust: surfaces: Vec::new(),
    // rust: windows: vec![layout::Window {
    // rust: number: 1,
    // rust: placement: Placement::Free(None),
    // rust: }],
    // rust: p1_window: 1,
    // rust: order: Vec::new(),
    // rust: setup_seats: Vec::new(),
    // rust: window1_shown: true,
    // rust: window_rects: Default::default(),
    // rust: screens: Vec::new(),
    // rust: main_screen: None,
    // rust: screens_read: None,
    // rust: window_plan: std::env::var("HORIZON_SPLIT_WINDOWS")
    // rust: .map(|w| w.split(',').map(|s| s.trim().to_owned()).collect())
    // rust: .unwrap_or_default(),
    // rust: applied: Vec::new(),
    // rust: focus: 0,
    // rust: cursor: PhysicalPosition::new(0.0, 0.0),
    // rust: limiter: horizon_client::window::FramerateLimiter::new(0),
    // rust: clock: Default::default(),
    // rust: res: None,
    // rust: turn: 0,
    // rust: host_widgets: Default::default(),
    // rust: accounts: launcher::accounts(),
    // rust: stats: std::env::var_os("HORIZON_SPLIT_STATS").map(|_| Instant::now()),
    // rust: spent: Default::default(),
    // rust: spent_frames: 0,
    // rust: frame_started: None,
    // rust: pads: Default::default(),
    // rust: p1_pad: Default::default(),
    // rust: fresh: Vec::new(),
    // rust: offers: Vec::new(),
    // rust: lost: Vec::new(),
}
}

pub fn players(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 1 + self.guests.len()
}

    /// Player `i`'s turn (0 = P1): its options file, and its own buttons and focus targets, which
    /// screens record while drawing and the control socket and the controller's cursor read.
pub fn turn(self: *Self, i: usize) void {
}
    // rust: if let Some(game) = self.game(i) {
    // rust: horizon_client::hud::GUI_SCALE.store(
    // rust: game.settings.gui_scale,
    // rust: std::sync::atomic::Ordering::Relaxed,
    // rust: );
}
    // rust: if i == self.turn {
    // rust: return;
}
    // rust: let current = widgets::take();
    // rust: match self.turn {
    // rust: 0 => self.host_widgets = current,
    // rust: t => {
    // rust: if let Some(g) = self.guests.get_mut(t - 1) {
    // rust: g.widgets = current;
}
}
}
    // rust: let next = match i {
    // rust: 0 => std::mem::take(&mut self.host_widgets),
    // rust: _ => self
    // rust: .guests
    // rust: .get_mut(i - 1)
    // rust: .map(|g| std::mem::take(&mut g.widgets))
    // rust: .unwrap_or_default(),
}
    // rust: widgets::put(next);
    // rust: OPTIONS.set(
    // rust: self.guests
    // rust: .get(i.wrapping_sub(1))
    // rust: .map(|g| g.options.clone()),
    // rust: );
    // rust: self.turn = i;
}

    /// Player `i`'s game (0 = P1).
pub fn game(self: *Self, i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match i {
    // rust: 0 => Some(&self.host),
    // rust: _ => self.guests.get(i - 1).map(|g| &*g.game),
}
}

pub fn game_mut(self: *Self, i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match i {
    // rust: 0 => Some(&mut self.host),
    // rust: _ => self.guests.get_mut(i - 1).map(|g| &mut *g.game),
}
}

    /// Player `i`'s game, in its turn, and its window's id.
pub fn player(self: *Self, i: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.turn(i);
    // rust: let focus = self.focus;
    // rust: let game = self.game_mut(i)?;
    // rust: game.keyboard_mouse = i == focus;
    // rust: let id = game.window.as_ref()?.id();
    // rust: Some((game, id))
}

    /// Give keyboard and mouse to one player, releasing the previous owner's held controls.
pub fn handoff(self: *Self, next: usize) void {
}
    // rust: if next != self.focus {
    // rust: self.turn(self.focus);
    // rust: if let Some(game) = self.game_mut(self.focus) {
    // rust: game.release_keyboard_mouse();
}
}
    // rust: self.focus = next;
    // rust: for i in 0..self.players() {
    // rust: if let Some(game) = self.game_mut(i) {
    // rust: game.keyboard_mouse = i == next;
}
}
}

    /// The pointer as the focused player sees it: from its view's corner.
pub fn cursor_in_focus(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y] = self.views().get(self.focus).map_or([0, 0], |v| v.1);
    // rust: let at = self.cursor;
    // rust: PhysicalPosition::new(at.x - f64::from(x), at.y - f64::from(y))
}

    /// Player `i`'s name (0 = P1).
pub fn name(self: *Self, i: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match i {
    // rust: 0 => "P1".into(),
    // rust: _ => self.guests[i - 1]
    // rust: .name
    // rust: .clone()
    // rust: .unwrap_or_else(|| "New player".into()),
}
}

    /// Where `HORIZON_SPLIT_WINDOWS` puts the player in `seat`: a window by number, or a new
    /// one filling a monitor.
pub fn planned_window(self: *Self, i: usize, seat: usize) void {
}
    // rust: let Some(plan) = self.window_plan.get(seat - 1).cloned() else {
    // rust: return;
}
    // rust: if let Some(k) = plan.strip_prefix('m') {
    // rust: let monitor = k
    // rust: .parse::<usize>()
    // rust: .ok()
    // rust: .and_then(|k| self.screens.get(k.checked_sub(1)?));
    // rust: let Some(name) = monitor.map(|(name, _)| name.clone()) else {
    // rust: log::warn!("Horizon: splitscreen: no monitor {k}");
    // rust: return;
}
    // rust: let number = (2..=u8::MAX)
    // rust: .find(|n| self.windows.iter().all(|w| w.number != *n))
    // rust: .unwrap_or(u8::MAX);
    // rust: self.windows.push(layout::Window {
    // rust: number,
    // rust: placement: Placement::Fill(name),
    // rust: });
    // rust: return self.set_window(i, number);
}
    // rust: let Ok(number) = plan.parse::<u8>() else {
    // rust: return;
}
    // rust: if !self.windows.iter().any(|w| w.number == number) {
    // rust: self.windows.push(layout::Window {
    // rust: number,
    // rust: placement: Placement::Free(None),
    // rust: });
}
    // rust: self.set_window(i, number);
}

    /// Another player joins: P1 renders offscreen on the same device and a compositor presents
    /// on its window; the world is meshed again for the new renderer.
pub fn enable(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let window = self.host.window.clone().ok_or("no window")?;
    // rust: let mut old = self.host.renderer.take().ok_or("no renderer")?;
    // rust: old.release_surface();
    // rust: let api = self.host.settings.horizon.api;
    // rust: let batching = self.host.settings.horizon.translucent_batching;
    // rust: let shader_pack = super::shader_packs::picked_pack_draws_flat(&self.host.settings);
    // rust: let built = build_renderer(
    // rust: window.clone(),
    // rust: true,
    // rust: &self.host.pack,
    // rust: &self.host.gui,
    // rust: Some(&old),
    // rust: None,
    // rust: api,
    // rust: batching,
    // rust: self.host.settings.horizon.wide_frame(),
    // rust: shader_pack,
    // rust: (
    // rust: self.host.settings.file.int("textureFiltering"),
    // rust: self.host.settings.file.int("maxAnisotropyBit"),
    // rust: ),
    // rust: );
    // rust: let renderer = match built {
    // rust: Ok(r) => r,
    // rust: Err(e) => {
    // rust: old.recreate_surface()?;
    // rust: self.host.renderer = Some(old);
    // rust: return Err(e);
}
}
        // A window it can't present on: P1 keeps drawing on it as before.
    // rust: let compositor = match old.compositor(window.clone()) {
    // rust: Ok(c) => c,
    // rust: Err(e) => {
    // rust: drop(renderer);
    // rust: old.recreate_surface()?;
    // rust: self.host.renderer = Some(old);
    // rust: return Err(e);
}
}
    // rust: self.host.renderer = Some(renderer);
        // The new atlas has no downloaded skins: queue them again, as after device loss.
    // rust: self.host.skin_slots.forget();
    // rust: self.host.split_window = !self.host.options.offscreen;
    // rust: self.host.options.offscreen = true;
    // rust: self.host.options.paced_by_split = true;
        // The new renderer takes the old one's present mode, settings and all: P1's again.
    // rust: self.host.apply_settings();
    // rust: self.host.clear_lod();
    // rust: self.host.all_sections_changed();
    // rust: self.surfaces = vec![Surface {
    // rust: key: 1,
    // rust: placement: Placement::Free(None),
    // rust: size: window.inner_size(),
    // rust: window,
    // rust: compositor,
    // rust: focused: true,
    // rust: title: String::new(),
    // rust: }];
    // rust: self.planned_window(0, 1);
    // rust: Ok(())
}

    /// Splitscreen off or P1 alone again: it draws on its window again.
pub fn disable(self: *Self, event_loop: *ActiveEventLoop, watching: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for k in (0..self.guests.len()).rev() {
    // rust: self.remove_guest(k);
}
    // rust: self.applied.clear();
    // rust: self.order.clear();
    // rust: self.setup_seats.clear();
    // rust: if !watching {
    // rust: self.stop_routing();
}
    // rust: self.p1_window = 1;
    // rust: self.windows.truncate(1);
    // rust: self.surfaces.truncate(1);
    // rust: let Some(main) = self.surfaces.pop() else {
    // rust: return Ok(());
}
    // rust: let window = main.window.clone();
    // rust: window.set_visible(true);
    // rust: self.window1_shown = true;
    // rust: self.host.window = Some(window.clone());
    // rust: let old = self.host.renderer.take().ok_or("no renderer")?;
    // rust: old.take_back(main.compositor);
    // rust: let api = self.host.settings.horizon.api;
    // rust: let batching = self.host.settings.horizon.translucent_batching;
    // rust: let shader_pack = super::shader_packs::picked_pack_draws_flat(&self.host.settings);
    // rust: let built = build_renderer(
    // rust: window.clone(),
    // rust: false,
    // rust: &self.host.pack,
    // rust: &self.host.gui,
    // rust: Some(&old),
    // rust: None,
    // rust: api,
    // rust: batching,
    // rust: self.host.settings.horizon.wide_frame(),
    // rust: shader_pack,
    // rust: (
    // rust: self.host.settings.file.int("textureFiltering"),
    // rust: self.host.settings.file.int("maxAnisotropyBit"),
    // rust: ),
    // rust: );
    // rust: let renderer = match built {
    // rust: Ok(r) => r,
    // rust: Err(e) => {
                // P1 stays offscreen, presented as before (alone now).
    // rust: let compositor = old.compositor(window)?;
    // rust: self.surfaces.push(Surface { compositor, ..main });
    // rust: self.host.renderer = Some(old);
    // rust: return Err(e);
}
}
    // rust: drop(old);
    // rust: self.host.renderer = Some(renderer);
    // rust: self.host.skin_slots.forget();
    // rust: self.host.options.offscreen = false;
    // rust: self.host.split_window = false;
    // rust: self.host.options.paced_by_split = false;
        // Alone again: the pointer is P1's, its view the whole window.
    // rust: self.focus = 0;
    // rust: self.host.keyboard_mouse = true;
    // rust: self.host.view_at = [0, 0];
        // From the offscreen renderer it took no vsync: P1's settings again.
    // rust: self.host.apply_settings();
    // rust: self.host.clear_lod();
    // rust: self.host.all_sections_changed();
    // rust: let id = window.id();
    // rust: self.host
    // rust: .window_event(event_loop, id, WindowEvent::Resized(window.inner_size()));
    // rust: Ok(())
}

    /// P1 is playing in a world others can join: its own (its server thread) or a server's.
pub fn in_world(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.host.title.is_none()
    // rust: && self.host.player.is_some()
    // rust: && (self.host.integrated.is_some() || self.p1_server().is_some())
}

    /// The server P1 joined over the network (a dedicated server, another computer's LAN
    /// world, a friend's invite): the others join it too, each as its own profile.
pub fn p1_server(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.host.integrated.is_some() || self.host.remote.is_none() {
    // rust: return None;
}
    // rust: self.host.server_address().map(str::to_owned)
}

    /// The pads' players who accepted, and the testing players (`HORIZON_SPLIT`, one a frame),
    /// join: whether anyone did.
pub fn admit(self: *Self, _event_loop: *ActiveEventLoop, pad_joins: std.ArrayList(PadId)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut changed = false;
    // rust: for pad in pad_joins {
    // rust: match self.join(Some(pad), None) {
    // rust: Ok(()) => changed = true,
    // rust: Err(e) => {
    // rust: self.restore_given_up_pad(pad);
    // rust: log::warn!("Horizon: splitscreen: a player could not join: {e}");
}
}
}
    // rust: if self.in_world() && self.test_players > 0 {
            // HORIZON_SPLIT_PICK: they pick a profile like a controller's player, else P2...
    // rust: let name = std::env::var_os("HORIZON_SPLIT_PICK")
    // rust: .is_none()
    // rust: .then(|| format!("P{}", self.free_seat().unwrap_or(0)));
    // rust: match self.join(None, name) {
    // rust: Ok(()) => {
    // rust: self.test_players -= 1;
    // rust: changed = true;
}
    // rust: Err(e) => {
                    // One player failing doesn't stop the others: P1 keeps playing.
    // rust: log::warn!("Horizon: splitscreen player couldn't join: {e}");
    // rust: self.test_players = 0;
}
}
}
    // rust: changed
}

    /// Each window shows its players' frames, then the GPU wait, once, for all of them. Only
    /// the game's window waits for the display (vsync): windows each waiting would divide the rate.
    /// When the windows had presented (before the GPU wait), for the frame-time readout.
pub fn present(self: *Self) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let views = self.views();
    // rust: let vsync = self.host.settings.vsync;
    // rust: let paced = windows::paced_surface(self.window1_shown, self.surfaces.len());
        // A present mode switch reconfigures a surface, and an Outdated or Lost texture
        // may: a reconfigure waits for the GPU to come idle and reports an error when a
        // frame is submitted while it waits. Land this turn's frames on the submit
        // threads first (the compositor then copies views already submitted, too).
    // rust: self.wait_queues();
    // rust: let renderers: Vec<_> = std::iter::once(&self.host.renderer)
    // rust: .chain(self.guests.iter().map(|g| &g.game.renderer))
    // rust: .collect();
    // rust: for (k, surface) in self.surfaces.iter_mut().enumerate() {
    // rust: let frames: Vec<_> = renderers
    // rust: .iter()
    // rust: .zip(&views)
    // rust: .filter(|(_, v)| v.0 == k)
    // rust: .filter_map(|(r, v)| Some((r.as_ref()?.offscreen_frame()?, v.1)))
    // rust: .collect();
    // rust: surface.compositor.set_vsync(vsync && k == paced);
    // rust: surface.compositor.present(&frames);
}
    // rust: let presented = Instant::now();
        // One player's CPU work overlapped the GPU drawing another's.
    // rust: let renderers = std::iter::once(&mut self.host.renderer)
    // rust: .chain(self.guests.iter_mut().map(|g| &mut g.game.renderer));
    // rust: for renderer in renderers.flatten() {
    // rust: renderer.paced_elsewhere = true;
    // rust: renderer.wait_in_flight();
}
    // rust: presented
}
    /// Every player's frame submitted by its submit thread, no device wait: before
    /// anything reconfigures a surface, whose wait for the GPU breaks on a submission
    /// made while it waits.
pub fn wait_queues(self: *Self) void {
}
    // rust: let renderers = std::iter::once(&mut self.host.renderer)
    // rust: .chain(self.guests.iter_mut().map(|g| &mut g.game.renderer));
    // rust: for renderer in renderers.flatten() {
    // rust: renderer.wait_submissions();
}
}
}

    // rust: impl ApplicationHandler for Split<'_> {
pub fn resumed(self: *Self, event_loop: *ActiveEventLoop) void {
}
    // rust: self.host.resumed(event_loop);
    // rust: if !self.surfaces.is_empty() {
    // rust: self.relayout(event_loop);
}
}

pub fn window_event(self: *Self, event_loop: *ActiveEventLoop, id: WindowId, event: WindowEvent) void {
}
    // rust: if self.surfaces.is_empty() {
    // rust: return self.host.window_event(event_loop, id, event);
}
    // rust: let Some(surface) = self.surfaces.iter().position(|s| s.window.id() == id) else {
    // rust: return;
}
    // rust: match event {
    // rust: WindowEvent::Resized(size) => {
    // rust: let s = &mut self.surfaces[surface];
    // rust: s.size = size;
    // rust: s.compositor.resize(size.width, size.height);
    // rust: self.relayout(event_loop);
}
            // The views draw themselves offscreen; the compositors present in about_to_wait.
    // rust: WindowEvent::RedrawRequested => {}
            // The game's window: P1's to handle (it saves the world, then quits). Another
            // window: its players leave.
    // rust: WindowEvent::CloseRequested if surface == 0 => {
    // rust: if let Some((host, id)) = self.player(0) {
    // rust: host.window_event(event_loop, id, WindowEvent::CloseRequested);
}
}
    // rust: WindowEvent::CloseRequested => {
    // rust: if let Err(e) = self.close_window(surface) {
    // rust: log::warn!("Horizon: splitscreen: {e}");
}
}
            // Players' pads count while any of the windows has focus.
    // rust: WindowEvent::Focused(focused) => {
    // rust: self.surfaces[surface].focused = focused;
    // rust: let any = self.surfaces.iter().any(|s| s.focused);
    // rust: for i in 0..self.players() {
    // rust: if let Some((player, id)) = self.player(i) {
    // rust: player.window_event(event_loop, id, WindowEvent::Focused(any));
}
}
}
    // rust: WindowEvent::CursorMoved {
    // rust: device_id,
    // rust: position,
    // rust: } => {
    // rust: self.cursor = position;
    // rust: let position = self.cursor_in_focus();
    // rust: let here = self.views().get(self.focus).is_some_and(|v| v.0 == surface);
    // rust: if here && let Some((player, id)) = self.player(self.focus) {
    // rust: player.window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::CursorMoved {
    // rust: device_id,
    // rust: position,
    // rust: },
    // rust: );
}
}
    // rust: WindowEvent::MouseInput {
    // rust: device_id,
    // rust: state: ElementState::Pressed,
    // rust: ..
    // rust: } => {
                // A click on another player's view gives it keyboard and mouse, unless the
                // focused player holds the mouse (playing): Esc frees it first, as in vanilla.
    // rust: let (x, y) = (self.cursor.x as u32, self.cursor.y as u32);
    // rust: let clicked = self.views().iter().position(|(s, [vx, vy], size)| {
    // rust: *s == surface
    // rust: && (*vx..vx + size.width).contains(&x)
    // rust: && (*vy..vy + size.height).contains(&y)
    // rust: });
    // rust: let holding = self.game(self.focus).is_some_and(|g| g.captured);
    // rust: if let Some(clicked) = clicked
    // rust: && clicked != self.focus
    // rust: && !holding
    // rust: {
    // rust: self.handoff(clicked);
    // rust: self.tag(clicked, "Keyboard and mouse");
    // rust: let position = self.cursor_in_focus();
    // rust: if let Some((player, id)) = self.player(clicked) {
    // rust: player.window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::CursorMoved {
    // rust: device_id,
    // rust: position,
    // rust: },
    // rust: );
}
}
                // Only into the focused player's own window: a click in another window
                // is not that player's attack or use.
    // rust: let here = self.views().get(self.focus).is_some_and(|v| v.0 == surface);
    // rust: if here && let Some((player, id)) = self.player(self.focus) {
    // rust: player.window_event(event_loop, id, event);
}
}
    // rust: _ => {
                // Presses (keys, wheel) from a window the focused player is not in stay there;
                // releases still pass, so a key held across a window change can't stick.
    // rust: let here = self.views().get(self.focus).is_some_and(|v| v.0 == surface);
    // rust: let press = match &event {
    // rust: WindowEvent::KeyboardInput { event: key, .. } => {
    // rust: key.state == ElementState::Pressed
}
    // rust: WindowEvent::MouseWheel { .. } => true,
    // rust: _ => false,
}
    // rust: if (here || !press)
    // rust: && let Some((player, id)) = self.player(self.focus)
    // rust: {
    // rust: player.window_event(event_loop, id, event);
}
}
}
    // rust: self.turn(0);
}

pub fn device_event(self: *Self, event_loop: *ActiveEventLoop, id: DeviceId, event: DeviceEvent) void {
}
        // Alone: exactly P1's path, as in window_event (no GUI-scale store per mouse motion).
    // rust: if self.surfaces.is_empty() {
    // rust: return self.host.device_event(event_loop, id, event);
}
    // rust: if let Some((player, _)) = self.player(self.focus) {
    // rust: player.device_event(event_loop, id, event);
}
    // rust: self.turn(0);
}

pub fn about_to_wait(self: *Self, event_loop: *ActiveEventLoop) void {
}
    // rust: let on = self.host.settings.extras.splitscreen || self.forced;
        // Only splitscreen places windows on monitors. Listing them is a round trip to the
        // window server (macOS: 0.1-0.3 ms, more on a busy machine), so not every frame.
    // rust: if (on || !self.surfaces.is_empty())
    // rust: && self
    // rust: .screens_read
    // rust: .is_none_or(|at| at.elapsed() >= Duration::from_secs(1))
    // rust: {
    // rust: self.screens_read = Some(Instant::now());
    // rust: self.refresh_monitors();
}
    // rust: self.host.split_hud.menu = self.guests.iter().any(|g| g.name.is_some());
        // Off, or the last other player gone: P1 draws on its window again.
    // rust: if !self.surfaces.is_empty()
    // rust: && (!on || self.guests.is_empty())
    // rust: && let Err(e) = self.disable(event_loop, on)
    // rust: {
    // rust: log::warn!("Horizon: splitscreen could not switch back: {e}");
}
    // rust: if self.surfaces.is_empty() {
    // rust: self.sync_setup();
    // rust: if !on {
    // rust: self.stop_routing();
    // rust: return self.host.about_to_wait(event_loop);
}
            // Alone, the controllers watched for someone joining; P1's own drives P1, its
            // output (rumble, triggers) through the split's reader for P1's turn.
    // rust: let pad_joins = self.route_pads(true);
    // rust: self.turn(0);
    // rust: if let Some(id) = self.p1_pad.owner {
    // rust: self.pads.lend_output(&mut self.host.pad, id);
}
    // rust: self.host.about_to_wait(event_loop);
    // rust: if self.p1_pad.owner.is_some() {
    // rust: self.pads.reclaim_output(&mut self.host.pad);
}
    // rust: if self.admit(event_loop, pad_joins) {
    // rust: self.relayout(event_loop);
}
    // rust: return;
}
    // rust: let started = Instant::now();
    // rust: if let Some(previous) = self.frame_started.replace(started) {
            // What the last frame left after its own work: events, the limiter, the OS.
    // rust: self.spent[3] += started.saturating_duration_since(previous);
}
    // rust: let pad_joins = self.route_pads(false);
    // rust: self.turn(0);
    // rust: self.host.about_to_wait(event_loop);
    // rust: let mut changed = self.drop_out() | self.admit(event_loop, pad_joins);
    // rust: self.follow_pack_answer();
    // rust: self.sync_profiles();
    // rust: changed |= self.pick_profiles();
    // rust: changed |= self.sync_setup();
    // rust: changed |= self.sync_surfaces(event_loop);
    // rust: if changed || self.views() != self.applied {
    // rust: self.relayout(event_loop);
}
        // Each player's badge: who it is, always with Names on (P1's Setup), else a moment when
        // something changes for it.
    // rust: let names = self.host.settings.extras.splitscreen_names;
    // rust: self.host.split_hud.badge = Some("P1".into());
    // rust: self.host.split_hud.names = names;
    // rust: for g in &mut self.guests {
    // rust: g.game.split_hud.badge = Some(g.name.clone().unwrap_or_else(|| "New player".into()));
    // rust: g.game.split_hud.names = names;
}
    // rust: let master = self.host.audio.master;
    // rust: for i in 0..self.guests.len() {
    // rust: self.turn(i + 1);
            // One set of speakers: P1's volume.
    // rust: self.guests[i].game.audio.master = master;
    // rust: self.guests[i].game.about_to_wait(event_loop);
            // A player's game stops the event loop on an error, as P1's does: say why.
    // rust: if let Some(e) = &self.guests[i].game.error {
    // rust: log::error!("Horizon: splitscreen: P{}: {e}", self.guests[i].seat);
}
            // Choosing its profile, the bumpers move its view (its pad as its game read it: the
            // controller, or `horizon-ctl pad`).
    // rust: let place = self.stop_label(i + 1);
    // rust: let game = &mut self.guests[i].game;
    // rust: if game.ui.options.page() == horizon_client::options_ui::Page::SplitProfiles
    // rust: && game.screen == super::Screen::Options
    // rust: {
    // rust: game.ui.options.split_profiles.place = place;
    // rust: let state = game.pad.state;
    // rust: let held = [
    // rust: state.held(Button::LeftBumper),
    // rust: state.held(Button::RightBumper),
    // rust: ];
    // rust: let before = std::mem::replace(&mut self.guests[i].bumpers, held);
    // rust: if held[0] && !before[0] {
    // rust: self.move_with_bumpers(i + 1, true);
    // rust: } else if held[1] && !before[1] {
    // rust: self.move_with_bumpers(i + 1, false);
}
}
}
    // rust: self.turn(0);
    // rust: let rendered = Instant::now();
    // rust: let presented = self.present();
    // rust: let waited = Instant::now();
    // rust: for (k, d) in [rendered - started, presented - rendered, waited - presented]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: self.spent[k] += d;
}
        // The rest of the frame (the limiter, the OS) counts as outside, from `waited` on.
    // rust: self.spent[3] = self.spent[3].saturating_sub(waited - started);
    // rust: self.spent_frames += 1;
    // rust: self.print_stats();
        // One pace for all: the fastest any player wants, so an idle one (vanilla's AFK limit)
        // can't slow the others. With vsync the display paces anything at or above its refresh
        // rate; the limiter on top would miss refreshes.
    // rust: let limit = std::iter::once(self.host.framerate_limit())
    // rust: .chain(self.guests.iter().map(|g| g.game.framerate_limit()))
    // rust: .max()
    // rust: .unwrap_or(60);
    // rust: let refresh_hz = self
    // rust: .surfaces
    // rust: .get(windows::paced_surface(
    // rust: self.window1_shown,
    // rust: self.surfaces.len(),
    // rust: ))
    // rust: .and_then(|s| s.window.current_monitor()?.refresh_rate_millihertz())
    // rust: .map_or(60, |mhz| mhz.div_ceil(1000) as i32);
    // rust: if !(self.host.settings.vsync && limit >= refresh_hz) {
    // rust: horizon_client::window::end_frame(&mut self.limiter, limit, &mut self.clock);
}
}

pub fn exiting(self: *Self, event_loop: *ActiveEventLoop) void {
}
    // rust: for i in (0..self.players()).rev() {
    // rust: if let Some((player, _)) = self.player(i) {
    // rust: player.exiting(event_loop);
}
}
    // rust: self.turn(0);
}
}

    // rust: impl Game<'_> {
    /// Keyboard and mouse go to another player: release everything they held here.
    // rust: pub(super) fn release_keyboard_mouse(&mut self) {
    // rust: for key in std::mem::take(&mut self.physical_keys) {
    // rust: self.native_key_event(key, false, false);
}
        // Only what the keyboard held, and a script acting as it: this player's pad keeps its
        // presses.
    // rust: let mut released = self
    // rust: .keys
    // rust: .release_source(horizon_client::held::Source::Keyboard);
    // rust: released.extend(
    // rust: self.keys
    // rust: .release_source(horizon_client::held::Source::Agent),
    // rust: );
    // rust: for key in released {
    // rust: if let Err(e) = self.mapped_key(
    // rust: key,
    // rust: false,
    // rust: false,
    // rust: key,
    // rust: horizon_client::held::Source::Keyboard,
    // rust: ) {
    // rust: log::warn!("Horizon: splitscreen: releasing input: {e}");
}
}
    // rust: for button in std::mem::take(&mut self.physical_buttons) {
    // rust: self.extras_mouse(button, false);
}
    // rust: self.drag_button = None;
    // rust: self.modifiers = Default::default();
        // A press this player's pad holds goes on, as for its keys.
    // rust: self.left = self
    // rust: .pad
    // rust: .holds_action(&self.settings.controller, "key.attack");
    // rust: self.right = self.pad.holds_action(&self.settings.controller, "key.use");
    // rust: self.inventory_mouse_release(false);
    // rust: self.inventory_mouse_release(true);
    // rust: self.inventory_pick_release();
    // rust: self.loom_release();
    // rust: self.creative_screen.release();
    // rust: self.ui.options.release();
    // rust: self.dragging = false;
    // rust: self.stats_release();
    // rust: self.world_options_release();
    // rust: self.advancements_mouse(false, [0, 0]);
    // rust: if let Some(title) = &mut self.title {
    // rust: title.release();
    // rust: title.release_field();
}
    // rust: self.capture(false);
    // rust: self.keyboard_mouse = false;
}
}
