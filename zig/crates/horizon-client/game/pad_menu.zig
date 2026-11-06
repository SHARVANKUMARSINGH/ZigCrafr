//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pad_menu
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A controller in menus, screens and inventories (Horizon's own;
//! docs/controllers.md). Each screen is driven one way:
//!
//! - **Focus** (menus): a highlight steps between the widgets, list rows and
//!   fields each screen registers (`widgets::target_as`) with vanilla's
//!   arrow-key navigation; A presses the focused one, the bumpers switch tabs,
//!   the right stick scrolls, left/right move a focused slider, A on a text
//!   field opens the on-screen keyboard (`osk`).
//! - **Crosshair** (inventories, containers and the screens whose clickable
//!   parts register no target): a pointer the left stick moves and the D-pad
//!   steps between slots and buttons; the bumpers switch tabs, or the recipe
//!   book's pages with the triggers on its categories.
//!
//! Both feed the screens the same pointer events a mouse sends (the pointer
//! sits on the focused widget, hidden), so every screen keeps its mouse
//! behaviour (drags, sliders, scrollbars, hover highlights) with no pad code
//! of its own.
// use super::event_loop::EventLoopCtl;
// use super::{
    // rust: Game, Screen,
    // rust: key_focus::{self, Act},
}
// use horizon_client::actions::Action;
// use horizon_client::{
    // rust: Result,
    // rust: creative::Creative,
    // rust: gamepad::{self, Button, Rect},
    // rust: hud::HudBatch,
    // rust: options_ui::{Event, Page},
    // rust: osk::{self, Keyboard},
    // rust: screen_narrator::InputType,
    // rust: widgets::{self, Kind, Target},
}
// use horizon_client_input::snap;
// use std::time::Instant;
// use winit::{
    // rust: dpi::PhysicalPosition,
    // rust: event::{DeviceId, ElementState, MouseButton, MouseScrollDelta, TouchPhase, WindowEvent},
    // rust: keyboard::KeyCode,
    // rust: window::WindowId,
}

/// How far the stick must lean to step focus.
pub const STICK_STEP: f32 = 0.55;
/// Scrolls a step may try to reveal the next row of a list.
pub const SCROLL_TRIES: u8 = 4;

/// A focus step that ran off the visible part of a list: the list was
/// scrolled and the step runs again once a new frame is drawn. When the
/// targets didn't move (nothing scrolled), the step takes vanilla's vague
/// pass instead.
pub const Pending = struct {
    button: Button,
    from: Rect,
    generation: u64,
    tries: u8,
    before: std.ArrayList(Rect),
    /// How far the list was scrolled, when it has a scrollbar.
    amount: ?f32,
};

/// What the focused widget is called (`widgets::slug`), found again by that when it moves: a list
/// scrolled another row into its place, a filter or a new layout moved it.
pub const FocusName = struct {
    screen: u64,
    /// The focus it was read from: once the focus is elsewhere, it isn't this one's name.
    rect: Rect,
    name: []const u8,
};

/// The focus the pad left a screen on (`MenuCursor::remembered`).
pub const Remembered = struct {
    rect: Rect,
    name: ?[]const u8,
};

/// The targets at the screen size they were drawn for, to carry the focus or the
/// crosshair over when that changes (a window resize, the GUI scale).
pub const Layout = struct {
    screen: u64,
    size: (f32,
    rects: std.ArrayList(Rect),
    /// What the focused widget is called (`widgets::slug`): how many rows fit changes with the
    /// size, so the same place in the draw order can be another widget.
    focus_name: ?[]const u8,
    /// The size last seen, once it's not `size`, and the frame drawn when it
    /// changed: the new targets come with a later frame.
    resized: Option<((f32,
};

/// The targets as the right stick found them, until a new frame shows how
/// far the list moved under the focus.
pub const StickScrolled = struct {
    screen: u64,
    generation: u64,
    down: bool,
    before: std.ArrayList(Rect),
    /// How far the focus's list was scrolled, when it has a scrollbar.
    amount: ?f32,
};

    // rust: pub(super) struct MenuCursor {
    /// Where the pad put the pointer (GUI pixels); `None` while the mouse
    /// has it.
    // rust: pub(super) pos: Option<(f32, f32)>,
    // rust: last_poll: Option<Instant>,
    /// The stick moved the cursor last poll (it settles when let go).
    // rust: moving: bool,
    /// Gliding onto a slot or control: from, to, since.
    // rust: glide: Option<((f32, f32), (f32, f32), Instant)>,
    /// Where the stick's current movement started.
    // rust: gesture: Option<(f32, f32)>,
    /// Pointer mode: the open screen's target centres last poll.
    // rust: anchors: Option<(Screen, Vec<(f32, f32)>)>,
    // rust: layout: Option<Layout>,
    // rust: wheel: [f32; 2],
    /// The wheel event being handled is the right stick's, on a focus-mode
    /// screen: it scrolls, whatever the pointer is over, and changes no value.
    // rust: stick_scroll: bool,
    /// The wheel event being handled is a focus step past a list's edge: it
    /// scrolls what the pointer is over, and changes no value.
    // rust: step_scroll: bool,
    // rust: stick_scrolled: Option<StickScrolled>,
    /// The held D-pad direction and when it last stepped.
    // rust: repeat: Option<(Button, Instant, bool)>,
    /// Pointer buttons the pad holds down.
    // rust: pub(super) held: [bool; 2],
    /// The focused button A went down on: letting go presses it, unless the
    /// focus moved or the input was cancelled first.
    // rust: pub(super) armed: Option<Rect>,
    /// The OS pointer is hidden while the pad's cursor is drawn.
    // rust: os_hidden: bool,
    /// Polls since a menu opened (its widgets are drawn after one frame).
    // rust: open_polls: u32,
    /// Focus mode: the focused target as last drawn.
    // rust: pub(super) focus: Option<Target>,
    /// The left stick's step direction last poll.
    // rust: stick: Option<Button>,
    // rust: pending: Option<Pending>,
    /// The focused slider being nudged and where the pad put its handle.
    // rust: nudge: Option<(Rect, f32)>,
    /// Steps since the held direction went down (sliders speed up).
    // rust: repeats: u32,
    /// The on-screen keyboard, open over a text field.
    // rust: pub(super) osk: Option<Keyboard>,
    /// The keyboard was closed on this screen (it doesn't open by itself again).
    // rust: osk_dismissed: bool,
    /// The keyboard drives the focus (`key_focus`: Tab, the arrows, Enter):
    /// focus mode whatever the screen, the OS pointer shown.
    // rust: pub(super) keyboard: bool,
    /// The focused slider's arrows change its value (`canChangeValue`).
    // rust: slider_edit: bool,
    /// What the last click landed on: vanilla focuses it, so the next Tab
    /// or arrow goes on from there (`ContainerEventHandler.mouseClicked`).
    // rust: origin: Option<Rect>,
    /// A shortcut put the focus here: not where the screen reopens.
    // rust: shortcut_focus: Option<Rect>,
    /// A pointer event the pad or the keyboard sends is being handled.
    // rust: synthetic: bool,
    /// Where the real mouse last moved the pointer (window pixels).
    // rust: real_pointer: Option<PhysicalPosition<f64>>,
    /// The screen the keyboard's focus is on (`Game::key_screen`), and the
    /// frame drawn when another one opened: the focus starts again on the
    /// new screen's first drawn frame.
    // rust: key_screen: u64,
    // rust: key_restart: Option<u64>,
    /// The pad's focus on each screen it left (`Game::key_screen`), so coming
    /// back lands where it was, as vanilla keeps a screen's focused widget.
    // rust: remembered: std::collections::HashMap<u64, Remembered>,
    /// The frame drawn when the pad last left a screen.
    // rust: left_screen: u64,
    /// The focused widget's name, while it has one of its own.
    // rust: focus_name: Option<FocusName>,
    /// Which prompt is up (`Game::pad_prompt_key`).
    // rust: prompt: Option<u64>,
    /// The frame drawn when one came or went: the focus starts again once it shows.
    // rust: prompt_restart: Option<u64>,
    /// The screen and the place the crosshair goes back to when the prompt over it closes.
    // rust: prompt_crosshair: Option<(Screen, (f32, f32))>,
}

    // rust: impl MenuCursor {
    /// `Screen.clearFocus`: nothing is focused any more, and no click focus
    /// is kept for the next Tab (`ComponentPath.applyFocus(false)`).
pub fn clear_focus(self: *Self) void {
}
    // rust: self.focus = None;
    // rust: self.origin = None;
    // rust: self.slider_edit = false;
    // rust: self.pending = None;
    // rust: self.armed = None;
}
}

/// The target of the one widget called `name` (`widgets::slug`). None when several are: the
/// rectangles have to tell them apart.
pub fn named_target(name: []const u8, labelled: *[widgets::Widget], rects: *[Rect]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut same = labelled.iter().filter(|w| widgets::slug(&w.label) == name);
    // rust: let w = same.next().filter(|_| same.next().is_none())?;
    // rust: let rect = [w.x, w.y, w.w, w.h];
    // rust: rects
    // rust: .iter()
    // rust: .position(|r| r.iter().zip(&rect).all(|(a, b)| (a - b).abs() < 0.5))
}

/// How far the list holding `rect` is scrolled.
pub fn list_amount(areas: *[gamepad::ScrollArea], rect: *Rect) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: areas.iter().find(|a| a.holds(rect)).map(|a| a.amount)
}

/// How far the rows of a list moved, by what its scrollbar says: `None` when it
/// has none to ask, `Some(None)` when they didn't.
pub fn list_shift(was: ?f32, now: ?f32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dy = was?.trunc() - now?.trunc();
    // rust: Some((dy.abs() >= 0.5).then_some(dy))
}

/// The target nearest `rect` on its line, for a focus that lost it.
pub fn beside(rect: Rect, targets: *[Rect]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let middle = rect[1] + rect[3] / 2.0;
    // rust: let centre = |r: &Rect| r[0] + r[2] / 2.0;
    // rust: targets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, r)| r[1] <= middle && middle < r[1] + r[3])
    // rust: .min_by(|(_, a), (_, b)| {
    // rust: let from = centre(&rect);
    // rust: (centre(a) - from)
    // rust: .abs()
    // rust: .total_cmp(&(centre(b) - from).abs())
    // rust: })
    // rust: .map(|(i, _)| i)
}

/// Where letting go of A clicks: the armed button, if the focus is still on it.
pub fn armed_click(armed: ?Rect, focus: ?Target) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: focus
    // rust: .filter(|focus| armed == Some(focus.rect))
    // rust: .map(|focus| focus.center())
}

    // rust: impl Game<'_> {
    /// A menu, a screen, the title, a sign or a book is open: the pad drives
    /// it instead of the player.
    // rust: pub(super) fn pad_in_menu(&self) -> bool {
    // rust: self.key_focus_screen() || self.prompt_open()
}

    /// A screen the keyboard's focus can drive is open. A prompt over the world isn't one: its
    /// keys are its own.
pub fn key_focus_screen(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.title.is_some()
    // rust: || self.screen != Screen::Playing
    // rust: || self.sign_edit.is_some()
    // rust: || self.book.is_some()
}

    /// Which prompt is up: another one starts the controller's focus again.
pub fn pad_prompt_key(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::hash::{Hash, Hasher};
    // rust: if !self.prompt_open() {
    // rust: return None;
}
    // rust: let mut hasher = std::collections::hash_map::DefaultHasher::new();
    // rust: (
    // rust: self.command_prompt.is_some(),
    // rust: self.link_prompt.is_some(),
    // rust: self.code_of_conduct.is_some(),
    // rust: self.server_packs.prompt.is_some(),
    // rust: )
    // rust: .hash(&mut hasher);
    // rust: self.dialog_screen_key().hash(&mut hasher);
    // rust: Some(hasher.finish())
}

    /// B or Start on a prompt: as Escape, the top one first. The code of conduct has no answer
    /// by Escape (`shouldCloseOnEsc`), and a dialog only when it allows it.
    // rust: pub(super) fn pad_prompt_back(&mut self) -> Result<()> {
    // rust: if self.command_prompt.is_some() {
    // rust: self.answer_command_prompt(false);
    // rust: } else if self.link_prompt.is_some() {
    // rust: self.answer_link_prompt(false);
    // rust: } else if self.code_of_conduct.is_some() {
    // rust: } else if self.server_packs.prompt.is_some() {
    // rust: self.answer_pack_prompt(false)?;
    // rust: } else {
    // rust: self.dialog_key(KeyCode::Escape, None, None)?;
}
    // rust: Ok(())
}

    /// Where the focus starts on a prompt: on what answers no, when it has that, so a press meant
    /// for the game can't accept anything. A dialog with text to fill in starts on its first
    /// input; its warning icon comes last.
pub fn pad_prompt_first(self: *Self, targets: *[Target]) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use widgets::Action;
    // rust: if !self.dialog_starts_typing() {
    // rust: let declared = widgets::last_actions(self.key_screen());
    // rust: let no = declared
    // rust: .iter()
    // rust: .filter(|d| d.enabled && matches!(d.action, Action::Cancel | Action::Back))
    // rust: .find_map(|d| targets.iter().find(|t| t.rect == d.rect));
    // rust: if let Some(no) = no {
    // rust: return Some(*no);
}
}
    // rust: let warning = self.dialog_warning_icon();
    // rust: let rest: Vec<Target> = targets
    // rust: .iter()
    // rust: .filter(|t| Some(t.rect) != warning)
    // rust: .copied()
    // rust: .collect();
    // rust: key_focus::tab_step(&rest, None, true).map(|i| rest[i])
}

    // rust: pub(super) fn gui_scale(&self) -> Option<HudBatch> {
    // rust: self.renderer
    // rust: .as_ref()
    // rust: .map(|r| HudBatch::new([r.config.width, r.config.height]))
}

    /// Focus drives the open screen: every menu but inventories and
    /// containers, and the screens whose clickable parts register no focus
    /// target (the advancements map, the statistics lists, the pack rows, a
    /// book's page text), where the pointer does (the keyboard always focuses).
    // rust: pub(super) fn pad_navigation_mode(&self) -> bool {
    // rust: self.prompt_open() || !self.pad_pointer_screen()
}

    /// The open screen is one the crosshair drives, whatever is over it.
pub fn pad_pointer_screen(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.screen,
    // rust: Screen::Inventory | Screen::Creative | Screen::Stats | Screen::Advancements
    // rust: ) || self.book.is_some()
    // rust: || (self.screen == Screen::Options && self.ui.options.page() == Page::Packs)
}

    // rust: pub(super) fn pad_focus_mode(&self) -> bool {
    // rust: self.pad.menu.keyboard || self.pad_navigation_mode()
}

    /// Where focus can land: buttons drawn last frame, every registered
    /// target (sliders, fields, rows, keyboard keys), and the slots
    /// and tabs of inventories (GUI pixels), on screen. The keyboard's
    /// focus skips what vanilla's keyboard can't reach (`key_targets`).
    // rust: pub(super) fn pad_targets(&self) -> Vec<Target> {
    // rust: if self.pad.menu.keyboard {
    // rust: self.key_targets()
    // rust: } else {
    // rust: self.pad_visible_targets()
}
}

    /// The targets the keyboard reaches: no slots, no inventory tabs.
pub fn key_targets(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
        // Advancements' tabs aren't widgets either: vanilla clicks them by hand. Statistics'
        // stay out too until a parity check settles where its tab bar sits in the order.
    // rust: let inventory = self.title.is_none()
    // rust: && matches!(
    // rust: self.screen,
    // rust: Screen::Inventory | Screen::Creative | Screen::Advancements | Screen::Stats
    // rust: );
    // rust: key_focus::keyboard_targets(self.pad_visible_targets(), inventory)
}

pub fn pad_visible_targets(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let targets = self.pad_all_targets();
    // rust: match self.gui_scale() {
    // rust: Some(batch) => key_focus::on_screen(targets, (batch.width, batch.height)),
    // rust: None => targets,
}
}

pub fn pad_all_targets(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut targets = key_focus::drawn_targets();
    // rust: if self.title.is_some()
    // rust: || self.sign_edit.is_some()
    // rust: || self.book.is_some()
    // rust: || self.prompt_open()
    // rust: {
    // rust: return targets;
}
    // rust: let Some(batch) = self.gui_scale() else {
    // rust: return targets;
}
    // rust: let slot = |x: f32, y: f32| Target {
    // rust: rect: [x, y, 16.0, 16.0],
    // rust: kind: Kind::Slot,
}
    // rust: match self.screen {
    // rust: Screen::Inventory => {
    // rust: let (ox, oy) = self.inventory_origin(&batch);
    // rust: targets.extend(self.slots().into_iter().map(|i| {
    // rust: let (x, y) = self.slot_position(i);
    // rust: slot(ox + x, oy + y)
    // rust: }));
    // rust: targets.extend(
    // rust: self.station_targets()
    // rust: .into_iter()
    // rust: .map(|[x, y, w, h]| Target {
    // rust: rect: [ox + x, oy + y, w, h],
    // rust: kind: Kind::Button,
    // rust: }),
    // rust: );
    // rust: targets.extend(self.recipe_book_targets());
}
    // rust: Screen::Creative => {
    // rust: let (ox, oy) = Self::creative_origin(&batch);
    // rust: if self.creative_inventory_open() {
    // rust: targets.extend(self.slots().into_iter().map(|i| {
    // rust: let (x, y) = self.slot_position(i);
    // rust: slot(ox + x, oy + y)
    // rust: }));
    // rust: } else {
    // rust: for r in 0..5 {
    // rust: for c in 0..9 {
    // rust: targets.push(slot(
    // rust: ox + 9.0 + c as f32 * 18.0,
    // rust: oy + 18.0 + r as f32 * 18.0,
    // rust: ));
}
}
    // rust: for c in 0..9 {
    // rust: targets.push(slot(ox + 9.0 + c as f32 * 18.0, oy + 112.0));
}
}
    // rust: for (i, t) in self.creative_screen.tabs.iter().enumerate() {
                    // A tab of another page of mods' tabs isn't drawn: its place is another's.
    // rust: if !self.creative_screen.on_page(t) {
    // rust: continue;
}
    // rust: let (x, y) = Creative::tab_position(t);
    // rust: targets.push(Target {
    // rust: rect: [ox + x, oy + y, 26.0, 32.0],
    // rust: kind: Kind::Tab(i == self.creative_screen.selected),
    // rust: });
}
}
    // rust: _ => {}
}
    // rust: targets
}

    /// Where focus starts when a menu opens: the held hotbar slot in an
    /// inventory, else the first button, else the first target that isn't
    /// a tab.
pub fn pad_first_target(self: *Self, targets: *[Target]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.pad.menu.keyboard {
            // Screen.setInitialFocus: a forward Tab from nothing.
    // rust: return key_focus::tab_step(targets, None, true).map(|i| targets[i]);
}
    // rust: if self.prompt_open() {
    // rust: return self.pad_prompt_first(targets).or(targets.first().copied());
}
        // Back on a screen the pad left: where it was, as vanilla keeps a
        // screen's focused widget (Options, after its Done). The same widget
        // first: the rows under it can have moved.
    // rust: let rects: Vec<Rect> = targets.iter().map(|t| t.rect).collect();
    // rust: if let Some(i) = self
    // rust: .pad
    // rust: .menu
    // rust: .remembered
    // rust: .get(&self.key_screen())
    // rust: .and_then(|r| {
    // rust: r.name
    // rust: .as_ref()
    // rust: .and_then(|n| named_target(n, &widgets::last_labelled(), &rects))
    // rust: .or_else(|| gamepad::refind(r.rect, &rects, 2.0))
    // rust: })
    // rust: {
    // rust: return Some(targets[i]);
}
    // rust: let batch = self.gui_scale()?;
    // rust: let at = |x: f32, y: f32| {
    // rust: targets
    // rust: .iter()
    // rust: .find(|t| t.rect[0] == x && t.rect[1] == y)
    // rust: .copied()
}
    // rust: if self.title.is_none() {
    // rust: match self.screen {
    // rust: Screen::Inventory => {
    // rust: let (ox, oy) = self.inventory_origin(&batch);
    // rust: let (x, y) = self.slot_position(self.selected);
    // rust: if let Some(t) = at(ox + x, oy + y) {
    // rust: return Some(t);
}
}
    // rust: Screen::Creative if !self.creative_inventory_open() => {
    // rust: let (ox, oy) = Self::creative_origin(&batch);
    // rust: if let Some(t) = at(ox + 9.0 + self.selected as f32 * 18.0, oy + 112.0) {
    // rust: return Some(t);
}
}
    // rust: _ => {}
}
}
        // Screen.setInitialFocus, as the keyboard's: the first control in tab
        // order (Singleplayer on the title, the first option row), not
        // whatever happened to register first.
    // rust: key_focus::tab_step(targets, None, true)
    // rust: .map(|i| targets[i])
    // rust: .or_else(|| {
    // rust: targets
    // rust: .iter()
    // rust: .find(|t| !matches!(t.kind, Kind::Tab(_)))
    // rust: .copied()
    // rust: })
    // rust: .or(targets.first().copied())
}

    /// The pointer is over a slot or control.
pub fn pad_over_target(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y) = self.cursor;
    // rust: self.pad_targets().iter().any(|t| {
    // rust: let [tx, ty, w, h] = t.rect;
    // rust: (tx..tx + w).contains(&x) && (ty..ty + h).contains(&y)
    // rust: })
}

    /// Start the cursor's glide onto `to` (GUI pixels), from wherever it is.
pub fn pad_glide_to(self: *Self, to: (f32) void {
}
    // rust: self.pad.menu.glide = Some((self.cursor, to, Instant::now()));
}

    /// Send the window a pointer move to `at` (GUI pixels), as the mouse would.
pub fn pad_pointer_to(self: *Self, event_loop: *dyn EventLoopCtl, at: (f32) void {
}
    // rust: let (Some(window), Some(batch)) = (self.window.as_ref(), self.gui_scale()) else {
    // rust: return;
}
    // rust: let id = window.id();
    // rust: let at = (
    // rust: at.0.clamp(0.0, batch.width - 1.0),
    // rust: at.1.clamp(0.0, batch.height - 1.0),
    // rust: );
    // rust: let position =
    // rust: PhysicalPosition::new(f64::from(at.0 * batch.scale), f64::from(at.1 * batch.scale));
    // rust: self.pad_synthetic_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::CursorMoved {
    // rust: device_id: DeviceId::dummy(),
    // rust: position,
    // rust: },
    // rust: );
        // Read back what the window made of it, so a real mouse move shows.
    // rust: self.pad.menu.pos = Some(self.cursor);
}

pub fn pad_pointer_button(self: *Self, event_loop: *dyn EventLoopCtl, right: bool, pressed: bool) void {
}
    // rust: let Some(id) = self.window.as_ref().map(|w| w.id()) else {
    // rust: return;
}
    // rust: self.pad.menu.held[usize::from(right)] = pressed;
    // rust: let button = if right {
    // rust: MouseButton::Right
    // rust: } else {
    // rust: MouseButton::Left
}
    // rust: let state = if pressed {
    // rust: ElementState::Pressed
    // rust: } else {
    // rust: ElementState::Released
}
    // rust: self.pad_synthetic_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::MouseInput {
    // rust: device_id: DeviceId::dummy(),
    // rust: state,
    // rust: button,
    // rust: },
    // rust: );
}

    /// A click (press and release) at a point, the pointer staying there.
    /// A pointer event of the pad's or the keyboard's, as the window would
    /// send it (marked, so it isn't taken for the real mouse).
    // rust: fn pad_synthetic_event(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: id: WindowId,
    // rust: event: WindowEvent,
    // rust: ) {
    // rust: let was = std::mem::replace(&mut self.pad.menu.synthetic, true);
    // rust: self.handle_window_event(event_loop, id, event, super::input_trace::InputOrigin::Game);
    // rust: self.pad.menu.synthetic = was;
}

    /// The event being handled is one the pad or the keyboard's focus made
    /// up (`pad_synthetic_event`), not the window's. A controller's click or
    /// a focused widget's is not the mouse, so the native mods' mouse hooks
    /// skip it.
    // rust: pub(super) fn pad_synthetic_input(&self) -> bool {
    // rust: self.pad.menu.synthetic
}

pub fn pad_click_at(self: *Self, event_loop: *dyn EventLoopCtl, at: (f32) void {
}
    // rust: self.pad_pointer_to(event_loop, at);
    // rust: self.pad_pointer_button(event_loop, right, true);
    // rust: self.pad_pointer_button(event_loop, right, false);
}

    /// The wheel event being handled only scrolls (`MenuCursor::stick_scroll`).
    // rust: pub(super) fn pad_stick_scroll(&self) -> bool {
    // rust: self.pad.menu.stick_scroll || self.pad.menu.step_scroll
}

    /// It came from a focus step, so the pointer still decides what scrolls.
    // rust: pub(super) fn pad_step_scroll(&self) -> bool {
    // rust: self.pad.menu.step_scroll
}

    /// The right stick's wheel: in focus mode a list scrolls and the focus
    /// goes with it (`pad_follow_focus`, once the next frame is drawn).
    // rust: fn pad_stick_wheel(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: focus_mode: bool,
    // rust: targets: &[Target],
    // rust: [x, y]: [f32; 2],
    // rust: ) {
    // rust: if focus_mode && y != 0.0 && self.pad.menu.stick_scrolled.is_none() {
    // rust: let amount = self
    // rust: .pad
    // rust: .menu
    // rust: .focus
    // rust: .and_then(|f| list_amount(&widgets::last_scroll_areas(), &f.rect));
    // rust: self.pad.menu.stick_scrolled = Some(StickScrolled {
    // rust: amount,
    // rust: screen: self.key_screen(),
    // rust: generation: widgets::generation(),
    // rust: down: y < 0.0,
    // rust: before: targets.iter().map(|t| t.rect).collect(),
    // rust: });
}
    // rust: self.pad.menu.stick_scroll = focus_mode;
    // rust: self.pad_wheel(event_loop, x, y);
    // rust: self.pad.menu.stick_scroll = false;
}

pub fn pad_step_wheel(self: *Self, event_loop: *dyn EventLoopCtl, button: Button) void {
}
    // rust: let y = if button == Button::DPadUp { 1.0 } else { -1.0 };
    // rust: self.pad.menu.step_scroll = true;
    // rust: self.pad_wheel(event_loop, 0.0, y);
    // rust: self.pad.menu.step_scroll = false;
}

pub fn pad_wheel(self: *Self, event_loop: *dyn EventLoopCtl, x: f32, y: f32) void {
}
        // Another row can scroll under the armed button's rect.
    // rust: self.pad.menu.armed = None;
    // rust: let Some(id) = self.window.as_ref().map(|w| w.id()) else {
    // rust: return;
}
    // rust: self.pad_synthetic_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::MouseWheel {
    // rust: device_id: DeviceId::dummy(),
    // rust: delta: MouseScrollDelta::LineDelta(x, y),
    // rust: phase: TouchPhase::Moved,
    // rust: },
    // rust: );
}

    /// Put the pointer where the pad last left it, or on the first target
    /// (focus mode: focus lands there too).
pub fn pad_take_pointer(self: *Self, event_loop: *dyn EventLoopCtl) void {
}
    // rust: if self.pad.menu.pos.is_some() {
    // rust: return;
}
    // rust: let targets = self.pad_targets();
    // rust: let first = self.pad_first_target(&targets);
    // rust: if self.pad_focus_mode() && first.is_some() {
    // rust: self.pad.menu.focus = first;
    // rust: if let Some(target) = first {
    // rust: self.pad_focus_selects_row(target);
}
}
    // rust: let at = first.map_or(self.cursor, |t| t.center());
    // rust: self.pad_pointer_to(event_loop, at);
}

    /// Run `f` with `key` held as a keyboard holds it, in the modifier word
    /// screens read as well as the physical keys, then put both back. The
    /// pad's only way to send Shift or Ctrl, so it can't fall out of step
    /// with what the keyboard sends.
    // rust: fn pad_with_modifier<T>(&mut self, key: KeyCode, f: impl FnOnce(&mut Self) -> T) -> T {
    // rust: let held = horizon_client_input::modifiers::hold(
    // rust: &mut self.modifiers,
    // rust: &mut self.physical_keys,
    // rust: key,
    // rust: );
    // rust: let result = f(self);
    // rust: horizon_client_input::modifiers::restore(
    // rust: &mut self.modifiers,
    // rust: &mut self.physical_keys,
    // rust: held,
    // rust: );
    // rust: result
}

    /// Focus mode with something to focus on this screen.
pub fn pad_focusing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pad_focus_mode() && self.pad.menu.focus.is_some()
}

    /// A button in a menu.
    // rust: pub(super) fn pad_menu_button(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: button: Button,
    // rust: down: bool,
    // rust: ) -> Result<()> {
    // rust: if !down {
    // rust: match button {
    // rust: Button::South if self.pad.menu.armed.is_some() => {
    // rust: let armed = self.pad.menu.armed.take();
    // rust: if let Some(at) = armed_click(armed, self.pad.menu.focus) {
    // rust: self.pad_click_at(event_loop, at, false);
}
}
    // rust: Button::South if self.pad.menu.held[0] => {
    // rust: self.pad_pointer_button(event_loop, false, false)
}
    // rust: Button::West if self.pad.menu.held[1] => {
    // rust: self.pad_pointer_button(event_loop, true, false)
}
    // rust: b if self.pad.menu.repeat.is_some_and(|r| r.0 == b) => self.pad.menu.repeat = None,
    // rust: _ => {}
}
    // rust: return Ok(());
}
        // The pad takes the focus back from the keyboard.
    // rust: self.pad.menu.keyboard = false;
        // A prompt over the screen answers first; no press reaches both.
    // rust: let prompt = self.prompt_open();
        // Bindings waiting for a button: this one (Start cancels).
    // rust: if !prompt
    // rust: && self.screen == Screen::Options
    // rust: && self.ui.options.controller_open()
    // rust: && let Some(action) = self.ui.options.selected_pad_action.take()
    // rust: {
    // rust: if button != Button::Start {
    // rust: self.settings.controller.bind(action, Some(button));
}
    // rust: return self.handle_option_events(vec![Event::Changed]);
}
        // A key row waiting for its key takes a mouse button: anything that clicks would bind it.
        // B or Start is Escape, which unbinds (`pad_back`).
    // rust: if self.pad_binding() && !matches!(button, Button::East | Button::Start) {
    // rust: return Ok(());
}
        // Splitscreen Setup: A picks up the focused player's tile, then left/right (or LB/RB)
        // cycle where it goes, A drops it, B puts it back (`split_ui`).
    // rust: if !prompt && self.screen == Screen::Options && self.ui.options.page() == Page::SplitSetup {
    // rust: let setup = &mut self.ui.options.split_setup;
    // rust: if setup.pad_button(button) {
                // Dropped or put back: the focus follows the player to its tile.
    // rust: if let Some(rect) = setup.take_refocus() {
    // rust: let kind = Kind::Button;
    // rust: self.pad_focus_on(event_loop, Target { rect, kind });
}
    // rust: return Ok(());
}
    // rust: if button == Button::South
    // rust: && self.pad_focusing()
    // rust: && let Some(focus) = self.pad.menu.focus
    // rust: && self.ui.options.split_setup.pad_pick_up(focus.center())
    // rust: {
    // rust: return Ok(());
}
}
        // The on-screen keyboard takes every button while it is open.
    // rust: if let Some(keyboard) = self.pad.menu.osk.as_mut() {
    // rust: if let Some(out) = keyboard.button(button) {
    // rust: self.pad_osk_output(out);
}
    // rust: if matches!(
    // rust: button,
    // rust: Button::DPadUp | Button::DPadDown | Button::DPadLeft | Button::DPadRight
    // rust: ) {
    // rust: self.pad.menu.repeat = Some((button, Instant::now(), false));
}
    // rust: return Ok(());
}
    // rust: if let Some((action, target)) = self.pad_action_target(button) {
    // rust: if action == widgets::Action::Exit {
    // rust: self.pad_focus_on(event_loop, target);
    // rust: self.pad.menu.shortcut_focus = Some(target.rect);
    // rust: } else {
    // rust: self.pad_click_at(event_loop, target.center(), false);
}
    // rust: return Ok(());
}
        // A prompt has its focus and B: the screen behind it has none of its buttons now.
    // rust: if prompt
    // rust: && !matches!(
    // rust: button,
    // rust: Button::South
    // rust: | Button::East
    // rust: | Button::Start
    // rust: | Button::DPadUp
    // rust: | Button::DPadDown
    // rust: | Button::DPadLeft
    // rust: | Button::DPadRight
    // rust: )
    // rust: {
    // rust: return Ok(());
}
        // A with nothing focused lands the focus, as the D-pad does: nothing
        // fires on a widget the player hasn't seen highlighted.
    // rust: if button == Button::South && self.pad_focus_mode() && self.pad.menu.focus.is_none() {
    // rust: let targets = self.pad_targets();
    // rust: if let Some(first) = self.pad_first_target(&targets) {
    // rust: self.pad_focus_on(event_loop, first);
    // rust: return Ok(());
}
}
    // rust: match button {
    // rust: Button::East | Button::Start => return self.pad_back(),
    // rust: Button::South if self.pad_focusing() => {
    // rust: let focus = self.pad.menu.focus.expect("focusing");
    // rust: match focus.kind {
                    // A click would jump the handle; left/right move it.
    // rust: Kind::Slider { .. } => {}
    // rust: Kind::Field => {
    // rust: self.pad_click_at(event_loop, focus.center(), false);
    // rust: self.pad_open_keyboard();
}
    // rust: Kind::Button | Kind::Tab(_) => {
    // rust: self.pad_pointer_to(event_loop, focus.center());
    // rust: self.pad.menu.armed = Some(focus.rect);
}
    // rust: _ => {
    // rust: self.pad_pointer_to(event_loop, focus.center());
    // rust: self.pad_pointer_button(event_loop, false, true);
}
}
}
    // rust: Button::South | Button::West => {
    // rust: self.pad_take_pointer(event_loop);
    // rust: self.pad_pointer_button(event_loop, button == Button::West, true);
                // A on a text field in pointer mode opens the keyboard, as
                // in focus mode (not the right click).
    // rust: if button == Button::South
    // rust: && !self.pad_focusing()
    // rust: && field_at(&self.pad_targets(), self.cursor)
    // rust: {
    // rust: self.pad_open_keyboard();
}
}
            // Y in an inventory: a shift-click (quick move).
    // rust: Button::North if matches!(self.screen, Screen::Inventory | Screen::Creative) => {
    // rust: self.pad_take_pointer(event_loop);
    // rust: let in_keys = self.keys.held(Action::Sneak);
    // rust: self.keys.insert(KeyCode::ShiftLeft);
    // rust: self.pad_with_modifier(KeyCode::ShiftLeft, |game| {
    // rust: game.pad_pointer_button(event_loop, false, true);
    // rust: game.pad_pointer_button(event_loop, false, false);
    // rust: });
    // rust: if !in_keys {
    // rust: self.keys.remove(&KeyCode::ShiftLeft);
}
}
            // View / left stick in an inventory: throw one / the stack from
            // the slot under focus (Q / Ctrl+Q).
    // rust: Button::Select | Button::LeftStick
    // rust: if matches!(self.screen, Screen::Inventory | Screen::Creative)
    // rust: && self.title.is_none() =>
    // rust: {
    // rust: self.pad_take_pointer(event_loop);
    // rust: if button == Button::LeftStick {
    // rust: self.pad_with_modifier(KeyCode::ControlLeft, |game| {
    // rust: game.key_pressed(KeyCode::KeyQ, KeyCode::KeyQ)
    // rust: })?;
    // rust: } else {
    // rust: self.key_pressed(KeyCode::KeyQ, KeyCode::KeyQ)?;
}
}
    // rust: Button::DPadUp | Button::DPadDown | Button::DPadLeft | Button::DPadRight => {
    // rust: self.pad.menu.repeats = 0;
    // rust: self.pad_step(event_loop, button);
    // rust: self.pad.menu.repeat = Some((button, Instant::now(), false));
}
            // The recipe book open: bumpers turn its pages, triggers change its category.
    // rust: Button::LeftBumper | Button::RightBumper if self.pad_recipe_book_showing() => {
    // rust: self.pad_recipe_page(button == Button::RightBumper);
}
    // rust: Button::LeftTrigger | Button::RightTrigger if self.pad_recipe_book_showing() => {
    // rust: self.pad_tab(event_loop, button == Button::RightTrigger);
}
            // Bumpers switch tabs (creative, Create World, the graphics sidebar, ...).
    // rust: Button::LeftBumper | Button::RightBumper => {
    // rust: self.pad_tab(event_loop, button == Button::RightBumper);
}
    // rust: _ => {}
}
    // rust: Ok(())
}

    /// One D-pad (or stick) step in either mode.
pub fn pad_step(self: *Self, event_loop: *dyn EventLoopCtl, button: Button) void {
}
    // rust: if let Some(keyboard) = self.pad.menu.osk.as_mut() {
    // rust: keyboard.step(button);
    // rust: return;
}
        // A slider's step is a click, which a waiting key row would bind.
    // rust: if self.pad_binding() {
    // rust: return;
}
        // Splitscreen Setup with a player held: the stick cycles it as the D-pad does.
    // rust: if !self.prompt_open()
    // rust: && self.screen == Screen::Options
    // rust: && self.ui.options.page() == Page::SplitSetup
    // rust: && self.ui.options.split_setup.holding()
    // rust: {
    // rust: self.ui.options.split_setup.pad_button(button);
    // rust: return;
}
    // rust: if self.pad_focus_mode() {
    // rust: let targets = self.pad_targets();
    // rust: if !targets.is_empty() {
    // rust: self.pad_focus_step(event_loop, button, &targets);
    // rust: return;
}
}
    // rust: self.pad_pointer_step(event_loop, button);
}

    /// Pointer mode: hop the cursor to the nearest target that way.
pub fn pad_pointer_step(self: *Self, event_loop: *dyn EventLoopCtl, button: Button) void {
}
    // rust: if self.pad.menu.pos.is_none() {
    // rust: self.pad_take_pointer(event_loop);
    // rust: return;
}
        // With A held over slots, the drag goes on to the next slot (a stack
        // spreads); on anything else (a slider grabbed), the D-pad nudges.
    // rust: if self.pad.menu.held[0] {
    // rust: let slots: Vec<Target> = self
    // rust: .pad_targets()
    // rust: .into_iter()
    // rust: .filter(|t| matches!(t.kind, Kind::Slot))
    // rust: .collect();
    // rust: let centres: Vec<(f32, f32)> = slots.iter().map(Target::center).collect();
    // rust: if snap::nearest(self.cursor, &centres, 0.5).is_some() {
    // rust: if let Some(i) = gamepad::focus_step(self.cursor, button, &centres)
    // rust: && (self.pad.menu.repeats == 0
    // rust: || !gamepad::repeat_crosses_slots(self.cursor, centres[i], true))
    // rust: {
    // rust: self.pad_pointer_to(event_loop, centres[i]);
}
    // rust: return;
}
    // rust: let (dx, dy) = match button {
    // rust: Button::DPadLeft => (-2.0, 0.0),
    // rust: Button::DPadRight => (2.0, 0.0),
    // rust: Button::DPadUp => (0.0, -2.0),
    // rust: _ => (0.0, 2.0),
}
    // rust: let at = self.cursor;
    // rust: self.pad_pointer_to(event_loop, (at.0 + dx, at.1 + dy));
    // rust: return;
}
    // rust: if matches!(button, Button::DPadUp | Button::DPadDown)
    // rust: && self.screen == Screen::Inventory
    // rust: && self.station_list_step(button == Button::DPadUp)
    // rust: {
    // rust: return;
}
        // A step during a glide goes on from where the glide ends.
    // rust: let from = self.pad.menu.glide.map_or(self.cursor, |(_, to, _)| to);
    // rust: let targets = self.pad_targets();
    // rust: let centres: Vec<(f32, f32)> = targets.iter().map(Target::center).collect();
    // rust: let Some(i) = gamepad::focus_step(from, button, &centres) else {
    // rust: return;
}
        // A held direction stops at the edge of the slots it is on; a fresh press may cross.
    // rust: let on_slot = targets.iter().any(|t| {
    // rust: t.kind == Kind::Slot
    // rust: && (t.center().0 - from.0).abs() <= 0.5
    // rust: && (t.center().1 - from.1).abs() <= 0.5
    // rust: });
    // rust: if self.pad.menu.repeats > 0
    // rust: && on_slot
    // rust: && gamepad::repeat_crosses_slots(from, centres[i], targets[i].kind == Kind::Slot)
    // rust: {
    // rust: return;
}
    // rust: self.pad_glide_to(centres[i]);
}

    /// Focus mode: move the highlight (or a focused slider's value).
    // rust: fn pad_focus_step(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: button: Button,
    // rust: targets: &[Target],
    // rust: ) {
    // rust: let Some(focus) = self.pad.menu.focus else {
    // rust: self.pad.menu.pos = None;
    // rust: self.pad_take_pointer(event_loop);
    // rust: return;
}
    // rust: if matches!(focus.kind, Kind::Slider { .. })
    // rust: && matches!(button, Button::DPadLeft | Button::DPadRight)
    // rust: {
    // rust: let step = gamepad::slider_step(self.pad.menu.repeats);
    // rust: let sign = if button == Button::DPadLeft {
    // rust: -1.0
    // rust: } else {
    // rust: 1.0
}
    // rust: self.pad_nudge(event_loop, focus, sign * step);
    // rust: return;
}
    // rust: self.pad_focus_move(event_loop, button, focus, targets);
}

    /// Move a focused slider's handle by `by` GUI pixels (one pixel is
    /// vanilla's arrow-key step, `value + 1 / (width - 8)`), as a click there.
pub fn pad_nudge(self: *Self, event_loop: *dyn EventLoopCtl, focus: Target, by: f32) void {
}
    // rust: let Kind::Slider { value, track } = focus.kind else {
    // rust: return;
}
    // rust: let from = match self.pad.menu.nudge {
    // rust: Some((rect, x)) if rect == focus.rect => x,
    // rust: _ => gamepad::slider_x(track, value),
}
    // rust: let x = (from + by).clamp(track[0], track[0] + track[1]);
    // rust: self.pad.menu.nudge = Some((focus.rect, x));
    // rust: self.pad_click_at(event_loop, (x, focus.center().1), false);
}

    /// Step the focus that way: vanilla's arrow-key navigation; a step out of a
    /// list that can still scroll that way (`gamepad::list_step`) scrolls it
    /// and goes on once the next frame is drawn.
    // rust: fn pad_focus_move(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: button: Button,
    // rust: focus: Target,
    // rust: targets: &[Target],
    // rust: ) {
        // The focus goes on from where the scroll leaves it (a held direction's
        // repeat can come first).
    // rust: if self.pad.menu.pending.is_some() {
    // rust: return;
}
    // rust: let rects: Vec<Rect> = targets.iter().map(|t| t.rect).collect();
    // rust: let vertical = matches!(button, Button::DPadUp | Button::DPadDown);
    // rust: let areas = widgets::last_scroll_areas();
    // rust: let step = if vertical {
    // rust: gamepad::list_step(focus.rect, button, &rects, &areas)
    // rust: } else {
    // rust: gamepad::focus_step_rect(focus.rect, button, &rects)
}
        // Outside the list a screen has, a step scrolls nothing (Back, Done).
    // rust: let outside = !areas.is_empty() && !areas.iter().any(|a| a.holds(&focus.rect));
    // rust: match step {
    // rust: Some(i) => self.pad_focus_on(event_loop, targets[i]),
    // rust: None if vertical && outside => {
    // rust: if let Some(i) = gamepad::focus_step_vague(focus.rect, button, &rects) {
    // rust: self.pad_focus_on(event_loop, targets[i]);
}
}
    // rust: None if vertical => {
                // Off the visible rows of a list: scroll it and try again on
                // the next frame.
    // rust: self.pad_step_wheel(event_loop, button);
    // rust: self.pad.menu.pending = Some(Pending {
    // rust: button,
    // rust: from: focus.rect,
    // rust: generation: widgets::generation(),
    // rust: tries: 1,
    // rust: before: rects,
    // rust: amount: list_amount(&areas, &focus.rect),
    // rust: });
}
    // rust: None => {}
}
}

    /// `AbstractSelectionList.setFocused`, on the lists where selecting does no more.
pub fn pad_focus_selects_row(self: *Self, target: Target) void {
}
    // rust: if target.kind != Kind::Row {
    // rust: return;
}
    // rust: let size = self.gui_size();
    // rust: if let Some(title) = self.title.as_mut().filter(|t| t.focus_selects_row()) {
    // rust: title.focus_world_row(target.center(), size);
}
}

pub fn pad_focus_on(self: *Self, event_loop: *dyn EventLoopCtl, target: Target) void {
}
    // rust: self.pad.menu.shortcut_focus = None;
    // rust: let left = self.pad.menu.focus.replace(target);
    // rust: if left.is_some_and(|l| l.rect != target.rect) {
    // rust: self.clear_screen_click_focus();
    // rust: self.pad.menu.armed = None;
}
    // rust: self.pad.menu.pending = None;
    // rust: self.pad.menu.nudge = None;
    // rust: if !self.pad.menu.held[0] {
    // rust: self.pad_pointer_to(event_loop, target.center());
}
    // rust: if self.pad.menu.keyboard {
            // The key itself was narrated (`narrate_input`).
    // rust: self.key_focus_landed(event_loop, left, target);
    // rust: return;
}
    // rust: if left.is_none_or(|l| l.rect != target.rect) {
    // rust: self.pad_focus_selects_row(target);
}
        // The screen's narration hears it as an arrow key moving the focus.
    // rust: self.narration.set_input(InputType::KeyboardArrow);
    // rust: self.narration.keyboard_action();
}

    /// The pad leaves screen `screen`: remember its focus there for when it
    /// comes back. Called before the new screen's targets are read, so the
    /// focus is still the left screen's.
    // rust: pub(super) fn pad_remember_focus(&mut self, screen: u64) {
    // rust: self.pad.menu.left_screen = widgets::generation();
    // rust: let Some(focus) = self.pad.menu.focus else {
    // rust: return;
}
    // rust: if self.pad.menu.shortcut_focus.take() == Some(focus.rect) {
    // rust: return;
}
    // rust: let name = self.pad_focus_name();
    // rust: let remembered = &mut self.pad.menu.remembered;
    // rust: if remembered.len() > 32 && !remembered.contains_key(&screen) {
    // rust: remembered.clear();
}
    // rust: let rect = focus.rect;
    // rust: remembered.insert(screen, Remembered { rect, name });
}

    /// Vanilla's arrow navigation moves a screen's focus off the widget a
    /// click focused: the screens that draw that click focus themselves drop
    /// it, so only the pad's focus shows.
pub fn clear_screen_click_focus(self: *Self) void {
}
    // rust: if let Some(title) = self.title.as_mut() {
    // rust: title.focused_button = None;
}
    // rust: match self.screen {
    // rust: Screen::Paused => self.pause_focus = None,
    // rust: Screen::Dead => self.death_focus = None,
    // rust: Screen::Options => self.ui.options.clear_click_focus(),
    // rust: _ => {}
}
    // rust: if let Some(options) = self.world_options.as_mut() {
    // rust: options.clear_click_focus();
}
}

    /// The controller's focus ring in focus mode, for the screen's narration:
    /// the focused widget.
    // rust: pub(super) fn pad_focus_rect(&self) -> Option<[f32; 4]> {
    // rust: let focus = self
    // rust: .pad
    // rust: .menu
    // rust: .focus
    // rust: .filter(|_| self.pad_in_menu() && self.pad_focus_mode());
    // rust: focus.map(|t| t.rect)
}

    /// A bumper: the next or previous tab, wrapping (creative keeps its own
    /// order; other screens register their tabs).
pub fn pad_tab(self: *Self, event_loop: *dyn EventLoopCtl, next: bool) void {
}
    // rust: if self.screen == Screen::Creative && self.title.is_none() {
    // rust: self.pad_creative_tab(next);
    // rust: return;
}
        // A held A is on a widget: a tab click would land in the middle of its press.
    // rust: if self.pad.menu.held[0] || self.pad.menu.armed.is_some() {
    // rust: return;
}
    // rust: let tabs: Vec<(Rect, bool)> = self
    // rust: .pad_targets()
    // rust: .into_iter()
    // rust: .filter_map(|t| match t.kind {
    // rust: Kind::Tab(selected) => Some((t.rect, selected)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: let Some(i) = gamepad::tab_step(&tabs, next) else {
    // rust: return;
}
    // rust: let rect = tabs[i].0;
    // rust: let back = self.pad.menu.pos;
    // rust: self.pad_click_at(
    // rust: event_loop,
    // rust: (rect[0] + rect[2] / 2.0, rect[1] + rect[3] / 2.0),
    // rust: false,
    // rust: );
    // rust: if self.pad_focus_mode() {
            // The page changed under the old focus: start again on the new one.
    // rust: self.pad.menu.focus = Some(Target {
    // rust: rect,
    // rust: kind: Kind::Tab(true),
    // rust: });
    // rust: } else if let Some(at) = back {
    // rust: self.pad_pointer_to(event_loop, at);
}
}

    /// An inventory with its recipe book open and nothing over it: the book's tabs are targets
    /// only then (`recipe_book_targets`).
pub fn pad_recipe_book_showing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.title.is_none()
    // rust: && self.screen == Screen::Inventory
    // rust: && self
    // rust: .recipe_book_targets()
    // rust: .iter()
    // rust: .any(|t| matches!(t.kind, Kind::Tab(_)))
}

    /// Select the next or previous creative tab (wrapping), as clicking it does. A tab on
    /// another page of mods' tabs shows its page: clicking where it would be would hit the
    /// tab drawn there on this page.
pub fn pad_creative_tab(self: *Self, next: bool) void {
}
    // rust: let count = self.creative_screen.tabs.len();
    // rust: if count == 0 {
    // rust: return;
}
    // rust: let selected = self.creative_screen.selected;
    // rust: let tab = if next {
    // rust: (selected + 1) % count
    // rust: } else {
    // rust: (selected + count - 1) % count
}
    // rust: super::select_creative_tab(&mut self.creative_screen, &mut self.inv_clicks, tab);
    // rust: self.refresh_saved_hotbars();
    // rust: self.inv_drag = None;
    // rust: self.last_inv_click = None;
}

    /// Once per poll in a menu: the stick moves the cursor (pointer) or
    /// steps focus, the right stick scrolls, a held direction repeats, focus
    /// follows its widget from frame to frame, and the OS pointer hides
    /// while the pad drives.
    // rust: pub(super) fn pad_menu_frame(&mut self, event_loop: &dyn EventLoopCtl) {
    // rust: let now = Instant::now();
    // rust: let seconds = self
    // rust: .pad
    // rust: .menu
    // rust: .last_poll
    // rust: .map_or(0.0, |t| now.duration_since(t).as_secs_f32().min(0.05));
    // rust: self.pad.menu.last_poll = Some(now);
    // rust: self.key_focus_frame();
    // rust: let in_menu =
    // rust: self.pad_in_menu() && (self.settings.controller.enabled || self.pad.menu.keyboard);
    // rust: if !in_menu {
    // rust: let menu = &mut self.pad.menu;
    // rust: menu.keyboard = false;
    // rust: menu.slider_edit = false;
    // rust: menu.open_polls = 0;
    // rust: menu.pos = None;
    // rust: menu.repeat = None;
    // rust: menu.held = [false; 2];
    // rust: menu.focus = None;
    // rust: menu.pending = None;
    // rust: menu.stick_scrolled = None;
    // rust: menu.anchors = None;
    // rust: menu.layout = None;
    // rust: menu.nudge = None;
    // rust: menu.osk = None;
    // rust: menu.osk_dismissed = false;
    // rust: menu.focus_name = None;
    // rust: menu.prompt = None;
    // rust: menu.prompt_restart = None;
    // rust: menu.prompt_crosshair = None;
    // rust: self.pad_show_os_pointer(true);
    // rust: return;
}
    // rust: self.pad.menu.open_polls = self.pad.menu.open_polls.saturating_add(1);
        // A real mouse move hands the pointer back. The keyboard's focus
        // stays where the next Tab or arrow goes on from.
    // rust: if let Some(at) = self.pad.menu.pos
    // rust: && ((at.0 - self.cursor.0).abs() > 0.5 || (at.1 - self.cursor.1).abs() > 0.5)
    // rust: {
    // rust: self.pad.menu.pos = None;
    // rust: let focus = self.pad.menu.focus.take();
    // rust: if std::mem::take(&mut self.pad.menu.keyboard) {
    // rust: self.pad.menu.origin = focus.map(|t| t.rect);
}
    // rust: self.pad_yield_input(event_loop);
}
        // Focus lands on the menu as it opens when the pad was in use.
    // rust: if self.pad.in_use && self.pad.menu.pos.is_none() && self.pad.menu.open_polls == 3 {
    // rust: self.pad_take_pointer(event_loop);
}
    // rust: if !self.pad.in_use && !self.pad.menu.keyboard {
    // rust: self.pad_show_os_pointer(true);
    // rust: return;
}
    // rust: let focus_mode = self.pad_focus_mode();
    // rust: let targets = if focus_mode {
    // rust: self.pad_targets()
    // rust: } else {
    // rust: Vec::new()
}
    // rust: let focusing = focus_mode && !targets.is_empty();
    // rust: let resizing = self.pad_follow_resize(event_loop);
    // rust: let restarting = self.pad_prompt_frame(&targets);
    // rust: if focusing && !resizing && !restarting && !self.key_focus_restart(event_loop, &targets) {
    // rust: self.pad_follow_focus(event_loop, &targets);
}
    // rust: let (move_deadzone, look_deadzone) = (
    // rust: self.settings.controller.move_deadzone,
    // rust: self.settings.controller.look_deadzone,
    // rust: );
    // rust: let state = self.pad.state;
    // rust: if focusing || self.pad.menu.osk.is_some() {
            // The stick steps like the D-pad.
    // rust: let dir = gamepad::stick_direction_held(
    // rust: gamepad::radial(state.left, move_deadzone),
    // rust: STICK_STEP,
    // rust: self.pad.menu.stick,
    // rust: );
    // rust: if dir != self.pad.menu.stick {
    // rust: if let Some((b, ..)) = self.pad.menu.repeat
    // rust: && Some(b) == self.pad.menu.stick
    // rust: {
    // rust: self.pad.menu.repeat = None;
}
    // rust: self.pad.menu.stick = dir;
    // rust: if let Some(button) = dir {
    // rust: if self.pad.menu.pos.is_none() && self.pad.menu.osk.is_none() {
    // rust: self.pad_take_pointer(event_loop);
    // rust: } else {
    // rust: self.pad.menu.repeats = 0;
    // rust: self.pad_step(event_loop, button);
}
    // rust: self.pad.menu.repeat = Some((button, now, false));
}
}
    // rust: } else {
    // rust: self.pad.menu.stick = None;
    // rust: let tuning = &snap::TUNING;
    // rust: let mut speed = seconds * self.settings.controller.pointer_speed;
    // rust: if tuning.over_target_speed != 1.0 && self.pad_over_target() {
    // rust: speed *= tuning.over_target_speed;
}
    // rust: let (dx, dy) = gamepad::cursor_delta(state.left, move_deadzone, speed);
    // rust: if dx != 0.0 || dy != 0.0 {
    // rust: self.pad.menu.glide = None;
    // rust: self.pad_take_pointer(event_loop);
    // rust: let at = self.cursor;
    // rust: self.pad.menu.gesture.get_or_insert(at);
    // rust: self.pad_pointer_to(event_loop, (at.0 + dx, at.1 + dy));
    // rust: self.pad.menu.moving = true;
    // rust: } else if self.pad.menu.moving {
                // Let go: the snapping engine picks where it settles.
    // rust: self.pad.menu.moving = false;
    // rust: let start = self.pad.menu.gesture.take().unwrap_or(self.cursor);
    // rust: let centres: Vec<(f32, f32)> =
    // rust: self.pad_targets().iter().map(Target::center).collect();
    // rust: if let Some(i) = snap::settle(start, self.cursor, &centres, tuning) {
    // rust: self.pad_glide_to(centres[i]);
}
    // rust: } else if let Some((from, to, since)) = self.pad.menu.glide {
    // rust: let elapsed = now.duration_since(since).as_secs_f32();
    // rust: self.pad_pointer_to(event_loop, snap::glide(from, to, elapsed, tuning));
    // rust: if elapsed >= tuning.glide_seconds {
    // rust: self.pad.menu.glide = None;
}
}
    // rust: if !resizing {
    // rust: self.pad_follow_targets();
}
}
        // Nothing scrolls under the on-screen keyboard.
    // rust: let scroll = if self.pad.menu.osk.is_some() {
    // rust: [0.0, 0.0]
    // rust: } else {
    // rust: gamepad::radial(state.right, look_deadzone)
}
    // rust: let wheel = &mut self.pad.menu.wheel;
    // rust: wheel[0] += scroll[0] * self.settings.controller.scroll_speed * seconds;
    // rust: wheel[1] += scroll[1] * self.settings.controller.scroll_speed * seconds;
    // rust: if scroll == [0.0, 0.0] {
    // rust: *wheel = [0.0, 0.0];
}
    // rust: let lines = [wheel[0].trunc(), wheel[1].trunc()];
    // rust: if lines != [0.0, 0.0] {
    // rust: wheel[0] -= lines[0];
    // rust: wheel[1] -= lines[1];
            // Stick right scrolls right: the wheel's x runs the other way.
    // rust: self.pad_stick_wheel(event_loop, focus_mode, &targets, [-lines[0], lines[1]]);
}
    // rust: if let Some((button, since, repeating)) = self.pad.menu.repeat {
    // rust: let wait = if repeating {
    // rust: self.settings.controller.repeat_interval
    // rust: } else {
    // rust: self.settings.controller.repeat_delay
}
    // rust: if now.duration_since(since).as_secs_f32() >= wait {
    // rust: self.pad.menu.repeat = Some((button, now, true));
    // rust: self.pad.menu.repeats = self.pad.menu.repeats.saturating_add(1);
    // rust: self.pad_step(event_loop, button);
}
}
    // rust: self.pad_auto_keyboard();
        // Vanilla's keyboard focus leaves the mouse pointer alone.
    // rust: self.pad_show_os_pointer(self.pad.menu.pos.is_none() || self.pad.menu.keyboard);
}

    /// Each poll: a prompt came up or went away. The keyboard was typing into what was open, and
    /// the focus starts again once the new frame shows: nothing pressed on one screen lands on
    /// the other. A keyboard a prompt took from chat or a sign opens again after it
    /// (`pad_auto_keyboard`), and the crosshair goes back to where it was. Whether the focus is
    /// waiting for that frame.
pub fn pad_prompt_frame(self: *Self, targets: *[Target]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prompt = self.pad_prompt_key();
    // rust: if prompt != self.pad.menu.prompt {
    // rust: let pointer_screen = self.pad_pointer_screen();
    // rust: let (screen, cursor) = (self.screen, self.cursor);
    // rust: let menu = &mut self.pad.menu;
    // rust: let opened = menu.prompt.is_none();
    // rust: menu.prompt = prompt;
    // rust: if menu.osk.take().is_some() && opened {
    // rust: menu.osk_dismissed = false;
}
    // rust: if menu.keyboard {
    // rust: menu.prompt_crosshair = None;
    // rust: } else {
    // rust: if opened && pointer_screen && menu.pos.is_some() && menu.prompt_crosshair.is_none()
    // rust: {
    // rust: let at = menu.glide.map_or(cursor, |(_, to, _)| to);
    // rust: menu.prompt_crosshair = Some((screen, at));
}
    // rust: menu.focus = None;
    // rust: menu.armed = None;
    // rust: menu.pending = None;
    // rust: menu.nudge = None;
    // rust: menu.stick_scrolled = None;
    // rust: menu.prompt_restart = Some(widgets::generation());
}
}
    // rust: let Some(changed_at) = self.pad.menu.prompt_restart else {
    // rust: return false;
}
        // Two frames on: the first may have been drawn before it changed.
    // rust: if widgets::generation() <= changed_at + 1 {
    // rust: return true;
}
    // rust: self.pad.menu.prompt_restart = None;
    // rust: if self.pad.menu.pos.is_some() && !targets.is_empty() {
    // rust: self.pad.menu.focus = self.pad_first_target(targets);
}
    // rust: if self.pad.menu.prompt.is_none()
    // rust: && let Some((screen, at)) = self.pad.menu.prompt_crosshair.take()
    // rust: && screen == self.screen
    // rust: && self.pad.menu.pos.is_some()
    // rust: && !self.pad_focus_mode()
    // rust: {
    // rust: self.pad_glide_to(at);
}
    // rust: false
}

    /// Each poll: the screen's size changed (a window resize, the GUI scale), so
    /// once its new layout is drawn, the focus and the crosshair go on from the
    /// same widget. Too far for `pad_follow_focus` and `snap::follow`, which it
    /// holds off (true) until then.
pub fn pad_follow_resize(self: *Self, event_loop: *dyn EventLoopCtl) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(batch) = self.gui_scale() else {
    // rust: return false;
}
    // rust: let (screen, size) = (self.key_screen(), (batch.width, batch.height));
    // rust: let Some(mut layout) = self.pad.menu.layout.take().filter(|l| l.screen == screen) else {
    // rust: self.pad.menu.layout = Some(Layout {
    // rust: screen,
    // rust: size,
    // rust: rects: self.pad_targets().iter().map(|t| t.rect).collect(),
    // rust: focus_name: self.pad_focus_name(),
    // rust: resized: None,
    // rust: });
    // rust: return false;
}
    // rust: let generation = widgets::generation();
    // rust: if size == layout.size {
    // rust: layout.resized = None;
    // rust: layout.rects = self.pad_targets().iter().map(|t| t.rect).collect();
    // rust: layout.focus_name = self.pad_focus_name();
    // rust: self.pad.menu.layout = Some(layout);
    // rust: return false;
}
    // rust: if layout.resized.is_none_or(|(seen, _)| seen != size) {
    // rust: layout.resized = Some((size, generation));
}
        // Two frames on: the first may have been drawn before the size changed.
    // rust: if layout.resized.is_some_and(|(_, at)| generation <= at + 1) {
    // rust: self.pad.menu.layout = Some(layout);
    // rust: return true;
}
    // rust: let targets = self.pad_targets();
    // rust: let rects: Vec<Rect> = targets.iter().map(|t| t.rect).collect();
    // rust: let (before, old) = (std::mem::take(&mut layout.rects), layout.size);
    // rust: let found = |from: Rect| gamepad::refind_resized(from, &before, &rects, old, size);
    // rust: self.pad.menu.pending = None;
    // rust: self.pad.menu.nudge = None;
    // rust: self.pad.menu.anchors = None;
    // rust: if self.pad_focus_mode() {
    // rust: let named = layout
    // rust: .focus_name
    // rust: .take()
    // rust: .and_then(|name| named_target(&name, &widgets::last_labelled(), &rects));
    // rust: self.pad.menu.focus = named
    // rust: .or_else(|| self.pad.menu.focus.and_then(|focus| found(focus.rect)))
    // rust: .map(|i| targets[i]);
    // rust: } else if self.pad.menu.pos.is_some() && self.pad.menu.held == [false; 2] {
    // rust: let at = self.cursor;
    // rust: let on = before.iter().find(|r| {
    // rust: (r[0] + r[2] / 2.0 - at.0).abs() <= 0.5 && (r[1] + r[3] / 2.0 - at.1).abs() <= 0.5
    // rust: });
    // rust: let to = match on.and_then(|r| found(*r)) {
    // rust: Some(i) => targets[i].center(),
    // rust: None => gamepad::rescaled(at, old, size),
}
    // rust: self.pad.menu.glide = None;
    // rust: self.pad.menu.gesture = None;
    // rust: self.pad_pointer_to(event_loop, to);
}
    // rust: self.pad.menu.layout = Some(Layout {
    // rust: screen,
    // rust: size,
    // rust: rects,
    // rust: focus_name: None,
    // rust: resized: None,
    // rust: });
    // rust: false
}

    /// What the focused widget is called, when it has a name of its own on this screen.
pub fn pad_focus_name(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, w, h] = self.pad.menu.focus?.rect;
    // rust: widgets::last_labelled()
    // rust: .iter()
    // rust: .find(|l| {
    // rust: (l.x - x).abs() < 0.5
    // rust: && (l.y - y).abs() < 0.5
    // rust: && (l.w - w).abs() < 0.5
    // rust: && (l.h - h).abs() < 0.5
    // rust: })
    // rust: .map(|l| widgets::slug(&l.label))
    // rust: .filter(|name| !name.is_empty())
}

    /// The focused widget where its name says it is now, on the screen and from the focus the
    /// name was read from. The keyboard's focus keeps to the rectangles it always followed.
pub fn pad_named_focus(self: *Self, focus: Target, rects: *[Rect]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let named = self.pad.menu.focus_name.as_ref().filter(|n| {
    // rust: !self.pad.menu.keyboard && n.rect == focus.rect && n.screen == self.key_screen()
    // rust: })?;
    // rust: named_target(&named.name, &widgets::last_labelled(), rects)
}

    /// Pointer mode, each poll: the targets moved out from under a resting
    /// cursor (a recipe book opened, another creative tab): it goes with them.
pub fn pad_follow_targets(self: *Self) void {
}
        // A press can move them (the recipe book opens on the way down): the
        // cursor follows once it's let go, from the layout it pressed on.
    // rust: if self.pad.menu.held != [false; 2] {
    // rust: return;
}
    // rust: let centres: Vec<(f32, f32)> = self.pad_targets().iter().map(Target::center).collect();
    // rust: let before = self
    // rust: .pad
    // rust: .menu
    // rust: .anchors
    // rust: .replace((self.screen, centres.clone()))
    // rust: .filter(|(screen, _)| *screen == self.screen);
    // rust: let menu = &self.pad.menu;
    // rust: if menu.pos.is_none() || menu.moving || menu.glide.is_some() {
    // rust: return;
}
    // rust: if let Some((_, before)) = before
    // rust: && let Some(i) = snap::follow(self.cursor, &before, &centres)
    // rust: {
    // rust: self.pad_glide_to(centres[i]);
}
}

    /// Focus mode, each poll: find the focused widget in the new frame (a
    /// list scrolled, a page changed), finish a step that scrolled a list,
    /// and keep the hidden pointer on the focused widget.
pub fn pad_follow_focus(self: *Self, event_loop: *dyn EventLoopCtl, targets: *[Target]) void {
}
    // rust: let rects: Vec<Rect> = targets.iter().map(|t| t.rect).collect();
    // rust: let screen = self.key_screen();
    // rust: let stick_scrolled = self
    // rust: .pad
    // rust: .menu
    // rust: .stick_scrolled
    // rust: .take_if(|s| widgets::generation() > s.generation)
    // rust: .filter(|s| s.screen == screen);
    // rust: let ready = self
    // rust: .pad
    // rust: .menu
    // rust: .pending
    // rust: .as_ref()
            // Two frames on: the first may have been drawn before the scroll.
    // rust: .map(|p| widgets::generation() > p.generation + 1);
    // rust: if ready == Some(true)
    // rust: && let Some(p) = self.pad.menu.pending.take()
    // rust: {
            // A step scrolled a list: carry on from where the focused row moved
            // (still leaving a list with more to show, it scrolls again), or
            // take the step it would have taken when nothing scrolled.
    // rust: let areas = widgets::last_scroll_areas();
    // rust: let shift = list_shift(p.amount, list_amount(&areas, &p.from)).unwrap_or_else(|| {
    // rust: gamepad::scroll_shift(&p.before, &rects, p.button == Button::DPadDown)
    // rust: });
    // rust: let mut from = p.from;
    // rust: let step = if let Some(dy) = shift {
    // rust: from[1] += dy;
    // rust: self.pad.menu.focus = gamepad::refind(from, &rects, 2.0).map(|i| targets[i]);
    // rust: gamepad::list_step(from, p.button, &rects, &areas)
    // rust: } else {
    // rust: gamepad::focus_step_rect(p.from, p.button, &rects)
}
    // rust: match step {
    // rust: Some(i) => self.pad_focus_on(event_loop, targets[i]),
    // rust: None if shift.is_some() && p.tries < SCROLL_TRIES => {
    // rust: self.pad_step_wheel(event_loop, p.button);
    // rust: self.pad.menu.pending = Some(Pending {
    // rust: from,
    // rust: generation: widgets::generation(),
    // rust: tries: p.tries + 1,
    // rust: before: rects.clone(),
    // rust: amount: list_amount(&areas, &from),
    // rust: ..p
    // rust: });
}
    // rust: None => {}
}
    // rust: } else if ready.is_none() {
    // rust: if let Some(focus) = self.pad.menu.focus {
    // rust: let kind = std::mem::discriminant(&focus.kind);
    // rust: let named = self.pad_named_focus(focus, &rects);
    // rust: let followed = stick_scrolled.and_then(|s| {
                    // Its scrollbar knows how far, when the rows land on each other's places.
    // rust: let areas = widgets::last_scroll_areas();
    // rust: if let Some(Some(dy)) = list_shift(s.amount, list_amount(&areas, &focus.rect)) {
    // rust: let mut moved = focus.rect;
    // rust: moved[1] += dy;
    // rust: if let Some(i) = gamepad::refind(moved, &rects, 0.5) {
    // rust: return Some(i);
}
}
    // rust: let after: Vec<(Rect, bool)> = targets
    // rust: .iter()
    // rust: .map(|t| (t.rect, std::mem::discriminant(&t.kind) == kind))
    // rust: .collect();
    // rust: gamepad::follow_scroll(focus.rect, s.down, &s.before, &after)
    // rust: });
                // The widget itself, wherever it went; else where its rectangle says.
    // rust: self.pad.menu.focus = named
    // rust: .or(followed)
    // rust: .or_else(|| gamepad::refind(focus.rect, &rects, 12.0))
    // rust: .map(|i| targets[i]);
    // rust: if self.pad.menu.focus.is_none() && self.pad.menu.pos.is_some() {
                    // The widget went away on this screen (a Reset or an Undo took itself away
                    // when pressed): what's beside it. Two frames on, as the first may have been
                    // drawn before the screen changed.
    // rust: let next_to = (!self.pad.menu.keyboard
    // rust: && widgets::generation() > self.pad.menu.left_screen + 1)
    // rust: .then(|| beside(focus.rect, &rects))
    // rust: .flatten();
                    // Else a page changed: start again.
    // rust: let first = match next_to {
    // rust: Some(i) => Some(targets[i]),
    // rust: None => self.pad_first_target(targets),
}
    // rust: if self.pad.menu.keyboard
    // rust: && let Some(first) = first
    // rust: {
                        // Screen.setInitialFocus after a keyboard press.
    // rust: self.pad_focus_on(event_loop, first);
    // rust: } else {
    // rust: self.pad.menu.focus = first;
}
}
    // rust: } else if self.pad.menu.pos.is_some() {
                // The pad drives but nothing is focused (switched from the pointer).
    // rust: let centres: Vec<(f32, f32)> = targets.iter().map(Target::center).collect();
    // rust: self.pad.menu.focus = if self.prompt_open() {
    // rust: self.pad_first_target(targets)
    // rust: } else {
    // rust: gamepad::nearest(self.cursor, &centres, f32::INFINITY).map(|i| targets[i])
}
}
}
    // rust: self.pad.menu.focus_name = self.pad.menu.focus.and_then(|focus| {
    // rust: let name = self.pad_focus_name()?;
    // rust: let (screen, rect) = (self.key_screen(), focus.rect);
    // rust: Some(FocusName { screen, rect, name })
    // rust: });
    // rust: let Some(focus) = self.pad.menu.focus else {
    // rust: return;
}
    // rust: if self.pad.menu.pos.is_none() || self.pad.menu.held.iter().any(|h| *h) {
    // rust: return;
}
    // rust: let at = match self.pad.menu.nudge {
    // rust: Some((rect, x)) if rect == focus.rect => (x, focus.center().1),
    // rust: _ => focus.center(),
}
        // A text field the keyboard focused keeps the pointer where its
        // click put the caret.
    // rust: let [x, y, w, h] = focus.rect;
    // rust: let inside = (x..x + w).contains(&self.cursor.0) && (y..y + h).contains(&self.cursor.1);
    // rust: if self.pad.menu.keyboard && focus.kind == Kind::Field && inside {
    // rust: return;
}
    // rust: if (at.0 - self.cursor.0).abs() > 0.5 || (at.1 - self.cursor.1).abs() > 0.5 {
    // rust: self.pad_pointer_to(event_loop, at);
}
}

pub fn pad_show_os_pointer(self: *Self, show: bool) void {
}
    // rust: if self.pad.menu.os_hidden != show {
    // rust: return;
}
    // rust: self.pad.menu.os_hidden = !show;
        // Controller menus leave the native pointer to its owning player.
    // rust: if !self.keyboard_mouse {
    // rust: return;
}
    // rust: if let Some(window) = &self.window {
    // rust: window.set_cursor_visible(show && !self.captured);
}
}

    /// `pad status`: the menu mode, the focused target and every target.
    // rust: pub(super) fn pad_menu_status(&self) -> serde_json::Value {
    // rust: let kind = |k: Kind| match k {
    // rust: Kind::Button => "button",
    // rust: Kind::Slider { .. } => "slider",
    // rust: Kind::Field => "field",
    // rust: Kind::Row => "row",
    // rust: Kind::Slot => "slot",
    // rust: Kind::Tab(true) => "tab*",
    // rust: Kind::Tab(false) => "tab",
}
    // rust: let target = |t: &Target| serde_json::json!({ "rect": t.rect, "kind": kind(t.kind) });
    // rust: serde_json::json!({
    // rust: "mode": if self.pad_focus_mode() { "focus" } else { "pointer" },
    // rust: "focus": self.pad.menu.focus.as_ref().map(target),
    // rust: "pointer": self.pad.menu.pos.map(|_| self.cursor),
    // rust: "keyboard": self.pad.menu.osk.is_some(),
    // rust: "targets": self.pad_targets().iter().map(target).collect::<Vec<_>>(),
    // rust: "actions": self.pad_actions_status(),
    // rust: "glyphs": self.pad_glyphs_status(),
    // rust: "undeclared": self.pad_undeclared_buttons(),
    // rust: "screen_key": format!("{:016x}", self.key_screen()),
    // rust: "remembered": self
    // rust: .pad
    // rust: .menu
    // rust: .remembered
    // rust: .iter()
    // rust: .map(|(k, r)| (format!("{k:016x}"), serde_json::json!(r.rect)))
    // rust: .collect::<serde_json::Map<_, _>>(),
    // rust: })
}

    // ---- the keyboard: vanilla's focus navigation (`key_focus`) ----

    // rust: pub(super) fn pad_cancel_menu(&mut self, event_loop: &dyn EventLoopCtl) {
    // rust: for right in [false, true] {
    // rust: if self.pad.menu.held[usize::from(right)] {
    // rust: self.pad_pointer_button(event_loop, right, false);
}
}
    // rust: self.pad.menu.repeat = None;
    // rust: self.pad.menu.stick = None;
    // rust: self.pad.menu.wheel = [0.0; 2];
    // rust: self.pad.menu.moving = false;
    // rust: self.pad.menu.glide = None;
    // rust: self.pad.menu.gesture = None;
    // rust: self.pad.menu.pending = None;
    // rust: self.pad.menu.nudge = None;
}

    /// The keyboard drives the open menu's focus.
    // rust: pub(super) fn key_focus_driving(&self) -> bool {
    // rust: self.pad.menu.keyboard && self.key_focus_screen()
}

    /// A pointer event the keyboard sends (a press, the hidden pointer on
    /// the focused widget) is being handled: the screen's narration doesn't
    /// take it for the mouse (`InputType` stays the keyboard's).
    // rust: pub(super) fn key_focus_quiet(&self) -> bool {
    // rust: self.pad.menu.synthetic && self.pad.menu.keyboard
}

    /// The screen keeps the navigation keys for itself: typing in chat (Tab
    /// completes a command), a sign, a book, the creative, recipe-book and
    /// mods searches, the anvil's name, a command block, a dialog, a key or
    /// button being bound, the credits, the on-screen keyboard.
pub fn key_focus_blocked(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let playing_screen = |screen| self.title.is_none() && self.screen == screen;
    // rust: self.pad.menu.osk.is_some()
    // rust: || playing_screen(Screen::Chat)
    // rust: || self.sign_edit.is_some()
    // rust: || matches!(self.book, Some(super::books::BookScreen::Edit { .. }))
    // rust: || (playing_screen(Screen::Creative) && self.creative_screen.tab().search)
    // rust: || self.recipe_search_focused()
    // rust: || self.mod_browser_typing()
    // rust: || self.station_typing()
    // rust: || self.screen == Screen::CommandBlock
    // rust: || self.screen == Screen::Win
    // rust: || self.dialog_open()
    // rust: || (self.screen == Screen::Options
    // rust: && (self.options_waiting_for_key()
    // rust: || self.ui.options.selected_pad_action.is_some()))
}

    /// `Screen.clearFocus`, which `Gui.setScreen` runs on the screen it takes
    /// down: the keyboard's focus belongs to that screen. A key bound to the
    /// container's own close key can move the focus and close the screen in
    /// one press (Tab bound to the inventory), and vanilla clears the focus
    /// before the next frame, so nothing stays highlighted.
    // rust: pub(super) fn pad_clear_focus(&mut self) {
    // rust: self.pad.menu.clear_focus();
}

    /// A key pressed in a menu, before the screen takes it
    /// (`Screen.keyPressed`): Tab, Shift+Tab and the arrows move the focus,
    /// Enter, Space and keypad Enter press the focused widget; the focused
    /// widget's own keys come first (a text field's caret, a slider's
    /// value). Whether the key was used; when not, the screen has it (a
    /// container also has Tab and the arrows once they moved the focus).
    // rust: pub(super) fn key_focus_key(&mut self, event_loop: &dyn EventLoopCtl, key: KeyCode) -> bool {
    // rust: let Some(nav) = key_focus::nav_of(key, self.has_shift_down()) else {
    // rust: return false;
}
    // rust: if !self.key_focus_screen() || self.key_focus_blocked() {
    // rust: return false;
}
    // rust: let targets = self.key_targets();
    // rust: if targets.is_empty() {
    // rust: return false;
}
    // rust: let find = |rect: Rect| {
    // rust: targets
    // rust: .iter()
    // rust: .find(|t| t.rect.iter().zip(rect).all(|(a, b)| (a - b).abs() < 0.5))
    // rust: .copied()
}
        // The focus: the keyboard's or the controller's, else what a click
        // focused (a slider a click focused changes with the arrows).
    // rust: let mut slider_edit = self.pad.menu.slider_edit;
    // rust: let mut focus = self
    // rust: .pad
    // rust: .menu
    // rust: .focus
    // rust: .filter(|_| self.pad_focus_mode())
    // rust: .and_then(|f| find(f.rect));
    // rust: if focus.is_none()
    // rust: && let Some(clicked) = self.pad.menu.origin.and_then(find)
    // rust: {
    // rust: focus = Some(clicked);
    // rust: slider_edit = true;
}
    // rust: let ctx = key_focus::Context {
    // rust: slider_edit,
    // rust: typing: self.edit_box_focused(),
    // rust: rows_take_enter: self.title.as_ref().is_some_and(|t| t.list_focused()),
    // rust: gui: self.gui_size(),
}
    // rust: let act = key_focus::act(nav, focus, &targets, ctx);
    // rust: if act == Act::Pass {
    // rust: return false;
}
    // rust: if !self.pad.menu.keyboard {
    // rust: self.pad.menu.key_screen = self.key_screen();
    // rust: self.pad.menu.key_restart = None;
}
    // rust: let menu = &mut self.pad.menu;
    // rust: menu.keyboard = true;
    // rust: menu.origin = None;
    // rust: menu.focus = focus;
    // rust: menu.slider_edit = slider_edit;
    // rust: if menu.pos.is_none() {
    // rust: menu.pos = Some(self.cursor);
}
    // rust: match (act, focus) {
    // rust: (Act::Focus(i), _) => {
    // rust: self.pad_focus_on(event_loop, targets[i]);
    // rust: self.pad.menu.slider_edit = key_focus::slider_edit_on_focus(nav);
}
    // rust: (Act::Step(button), Some(focus)) => {
    // rust: self.pad_focus_move(event_loop, button, focus, &targets);
}
    // rust: (Act::Press, Some(focus)) => {
                // AbstractButton.keyPressed: onPress, with its click sound.
    // rust: self.pad_click_at(event_loop, focus.center(), false);
}
    // rust: (Act::ToggleSlider, _) => self.pad.menu.slider_edit = !slider_edit,
    // rust: (Act::Nudge(sign), Some(focus)) => self.pad_nudge(event_loop, focus, sign),
    // rust: _ => {}
}
        // The narration reads a focused slider's `canChangeValue` from the
        // input type (Tab: it can, an arrow: it can't); keep them in step
        // after Enter flipped it or a click let it.
    // rust: if let Some(Target {
    // rust: kind: Kind::Slider { .. },
    // rust: ..
    // rust: }) = self.pad.menu.focus
    // rust: {
    // rust: self.narration.set_input(if self.pad.menu.slider_edit {
    // rust: InputType::KeyboardTab
    // rust: } else {
    // rust: InputType::KeyboardArrow
    // rust: });
}
    // rust: let container =
    // rust: self.title.is_none() && matches!(self.screen, Screen::Inventory | Screen::Creative);
    // rust: !key_focus::passes_on(act, container)
}

    /// Which screen is open, as far as the keyboard's focus cares.
    // rust: pub(super) fn key_screen(&self) -> u64 {
//         use std::hash::{Hash, Hasher};
    // rust: let mut hasher = std::collections::hash_map::DefaultHasher::new();
    // rust: std::mem::discriminant(&self.screen).hash(&mut hasher);
    // rust: self.remote_menu_id().hash(&mut hasher);
    // rust: if self.screen == Screen::Options {
    // rust: std::mem::discriminant(&self.ui.options.page()).hash(&mut hasher);
}
    // rust: self.title
    // rust: .as_ref()
    // rust: .map(|t| t.screen_key())
    // rust: .hash(&mut hasher);
    // rust: (self.sign_edit.is_some(), self.book.is_some()).hash(&mut hasher);
    // rust: self.pad_prompt_key().hash(&mut hasher);
    // rust: hasher.finish()
}

    /// Each poll while the keyboard has the focus: another screen opened
    /// (a pressed button opened it), so once it is drawn the focus starts on
    /// its first widget (`Screen.setInitialFocus` after a key). Whether the
    /// focus is waiting for that or just started again.
pub fn key_focus_restart(self: *Self, event_loop: *dyn EventLoopCtl, targets: *[Target]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.pad.menu.keyboard {
    // rust: return false;
}
    // rust: let screen = self.key_screen();
    // rust: if screen != self.pad.menu.key_screen {
    // rust: self.pad.menu.key_screen = screen;
    // rust: self.pad.menu.key_restart = Some(widgets::generation());
    // rust: self.pad.menu.pending = None;
}
    // rust: let Some(changed_at) = self.pad.menu.key_restart else {
    // rust: return false;
}
        // Two frames on: the first may have been drawn before the click.
    // rust: if widgets::generation() > changed_at + 1 {
    // rust: self.pad.menu.key_restart = None;
    // rust: self.pad.menu.focus = None;
    // rust: if let Some(first) = self.pad_first_target(targets) {
    // rust: self.pad_focus_on(event_loop, first);
}
}
    // rust: true
}

    /// The keyboard's focus moved from `left` to `target`
    /// (`ComponentPath.applyFocus`): a slider's arrows don't change it yet,
    /// a text field takes the typing (a click at its end, where Tab leaves
    /// the caret) and the one left behind lets go of it, and a world row is
    /// selected (`AbstractSelectionList.setFocused`).
    // rust: fn key_focus_landed(
    // rust: &mut self,
    // rust: event_loop: &dyn EventLoopCtl,
    // rust: left: Option<Target>,
    // rust: target: Target,
    // rust: ) {
    // rust: self.pad.menu.slider_edit = false;
    // rust: if left.is_some_and(|l| l.rect == target.rect) {
    // rust: return;
}
    // rust: if left.is_some_and(|l| l.kind == Kind::Field)
    // rust: && target.kind != Kind::Field
    // rust: && let Some(title) = self.title.as_mut()
    // rust: {
    // rust: title.blur_field();
}
    // rust: match target.kind {
    // rust: Kind::Field => {
    // rust: self.pad_click_at(event_loop, key_focus::field_click(target.rect), false);
}
    // rust: Kind::Row => {
    // rust: let size = self.gui_size();
    // rust: if let Some(title) = self.title.as_mut() {
    // rust: title.focus_world_row(target.center(), size);
}
}
    // rust: _ => {}
}
}

    /// The real mouse, before the screen takes it: where it is, and a press
    /// or a scroll hands it the pointer back from the keyboard, at the
    /// place the mouse left it (`setLastInputType(MOUSE)`).
    // rust: pub(super) fn key_focus_mouse(&mut self, event_loop: &dyn EventLoopCtl, event: &WindowEvent) {
    // rust: if self.pad.menu.synthetic {
    // rust: return;
}
    // rust: let takeover = match event {
    // rust: WindowEvent::CursorMoved { position, .. } => {
    // rust: self.pad.menu.real_pointer != Some(*position)
}
    // rust: WindowEvent::KeyboardInput { event, .. } => event.state == ElementState::Pressed,
    // rust: WindowEvent::MouseInput { state, .. } => *state == ElementState::Pressed,
    // rust: WindowEvent::MouseWheel { .. } => true,
    // rust: _ => false,
}
    // rust: if takeover {
    // rust: self.pad_yield_input(event_loop);
}
    // rust: match event {
    // rust: WindowEvent::CursorMoved { position, .. } => {
    // rust: self.pad.menu.real_pointer = Some(*position);
}
    // rust: WindowEvent::MouseInput {
    // rust: state: ElementState::Pressed,
    // rust: ..
    // rust: } => self.key_focus_to_mouse(event_loop),
    // rust: WindowEvent::MouseWheel { .. } => self.key_focus_to_mouse(event_loop),
    // rust: _ => {}
}
}

    /// Only a press accepted by ScreenEvent.Pre may focus the widget under it.
    // rust: pub(super) fn key_focus_mouse_press(&mut self, event: &WindowEvent) {
    // rust: if !self.pad.menu.synthetic
    // rust: && self.key_focus_screen()
    // rust: && matches!(
    // rust: event,
    // rust: WindowEvent::MouseInput {
    // rust: state: ElementState::Pressed,
    // rust: button: MouseButton::Left,
    // rust: ..
}
    // rust: )
    // rust: {
    // rust: let (cx, cy) = self.cursor;
    // rust: self.pad.menu.origin = self
    // rust: .key_targets()
    // rust: .into_iter()
    // rust: .find(|t| {
    // rust: let [x, y, w, h] = t.rect;
    // rust: cx >= x && cy >= y && cx < x + w && cy < y + h
    // rust: })
    // rust: .map(|t| t.rect);
}
}

    /// The keyboard lets go of the pointer: it goes back to the real mouse.
pub fn key_focus_to_mouse(self: *Self, event_loop: *dyn EventLoopCtl) void {
}
    // rust: if !std::mem::take(&mut self.pad.menu.keyboard) {
    // rust: return;
}
    // rust: let menu = &mut self.pad.menu;
    // rust: menu.origin = menu.focus.take().map(|t| t.rect);
    // rust: menu.pos = None;
    // rust: menu.pending = None;
    // rust: menu.nudge = None;
    // rust: let real = menu.real_pointer;
    // rust: if let (Some(position), Some(id)) = (real, self.window.as_ref().map(|w| w.id())) {
    // rust: self.pad_synthetic_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::CursorMoved {
    // rust: device_id: DeviceId::dummy(),
    // rust: position,
    // rust: },
    // rust: );
}
}

    /// Each poll: what a click focused is forgotten once it is gone (the
    /// screen changed), and out of menus.
pub fn key_focus_frame(self: *Self) void {
}
    // rust: let Some(origin) = self.pad.menu.origin else {
    // rust: return;
}
    // rust: let there = self.key_focus_screen()
    // rust: && self
    // rust: .key_targets()
    // rust: .iter()
    // rust: .any(|t| t.rect.iter().zip(origin).all(|(a, b)| (a - b).abs() < 0.5));
    // rust: if !there {
    // rust: self.pad.menu.origin = None;
}
}

    /// The keyboard focus the title had while resources loaded
    /// (`StartupMenu`), carried into the game's.
    // rust: pub(super) fn key_focus_adopt(&mut self, focus: Target, slider_edit: bool) {
    // rust: let screen = self.key_screen();
    // rust: let menu = &mut self.pad.menu;
    // rust: menu.key_screen = screen;
    // rust: menu.key_restart = None;
    // rust: menu.keyboard = true;
    // rust: menu.focus = Some(focus);
    // rust: menu.slider_edit = slider_edit;
    // rust: menu.pos = Some(self.cursor);
}

    // ---- text fields ----

    /// A text field has keyboard focus: chat, a sign, a book being written,
    /// a search box, the anvil's name, the title screens' and the options'
    /// fields, the LAN port, a dialog's input, the command box and the edit
    /// screens of the jigsaw, structure and test blocks.
pub fn pad_typing(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.screen == Screen::Chat && self.title.is_none())
    // rust: || self.sign_edit.is_some()
    // rust: || matches!(self.book, Some(super::books::BookScreen::Edit { .. }))
    // rust: || (self.screen == Screen::Creative && self.creative_screen.tab().search)
    // rust: || self.recipe_search_focused()
    // rust: || self.station_typing()
    // rust: || self.dialog_typing()
    // rust: || self.mod_browser_typing()
    // rust: || matches!(
    // rust: self.screen,
    // rust: Screen::CommandBlock | Screen::BlockEditor | Screen::Social | Screen::DebugOptions
    // rust: )
}

    /// Open the on-screen keyboard over the focused field: Horizon's, or
    /// Steam's on a Steam Deck (`steam://open/keyboard`, which types into
    /// the window like a real keyboard).
pub fn pad_open_keyboard(self: *Self) void {
}
        // Without xdg-open (macOS, Windows), Horizon's keyboard instead.
    // rust: if gamepad::steam_keyboard(self.settings.controller.keyboard)
    // rust: && std::process::Command::new("xdg-open")
    // rust: .arg("steam://open/keyboard")
    // rust: .stdin(std::process::Stdio::null())
    // rust: .stdout(std::process::Stdio::null())
    // rust: .stderr(std::process::Stdio::null())
    // rust: .spawn()
    // rust: .is_ok()
    // rust: {
    // rust: return;
}
    // rust: self.pad.menu.osk = Some(Keyboard::default());
}

    /// Chat or a sign opened by the pad (either menu mode): the keyboard
    /// opens with it (once per screen; B closes it for good). Not the chat a
    /// sleeper gets (`InBedChatScreen`): the game opens that one, not the
    /// player, so the keyboard waits for A on its chat box.
pub fn pad_auto_keyboard(self: *Self) void {
}
    // rust: let menu = &self.pad.menu;
    // rust: if osk_auto_opens(
    // rust: menu.osk.is_some(),
    // rust: menu.osk_dismissed,
    // rust: self.pad.in_use,
    // rust: menu.open_polls,
    // rust: !self.prompt_open()
    // rust: && ((self.screen == Screen::Chat && !self.ui.in_bed_chat)
    // rust: || self.sign_edit.is_some()),
    // rust: ) {
    // rust: self.pad.menu.osk_dismissed = true;
    // rust: self.pad_open_keyboard();
}
}

    /// What a key of the on-screen keyboard does: the same as a typed key in
    /// the field that has focus.
pub fn pad_osk_output(self: *Self, out: osk::Output) void {
}
//         use osk::Output;
    // rust: let (key, text) = match &out {
    // rust: Output::Text(t) => (None, Some(t.as_str())),
    // rust: Output::Backspace => (Some(KeyCode::Backspace), None),
    // rust: Output::Enter => (Some(KeyCode::Enter), None),
    // rust: Output::Close => {
    // rust: self.pad.menu.osk = None;
    // rust: self.pad.menu.osk_dismissed = true;
    // rust: return;
}
}
    // rust: let backspace = key == Some(KeyCode::Backspace);
    // rust: if self.dialog_open() {
            // Over whatever else is open. Enter only ends the typing, but for a new line.
    // rust: let result = match text {
    // rust: Some(t) => {
    // rust: self.dialog_type(t);
    // rust: Ok(())
}
    // rust: None if backspace || self.dialog_typing_lines() => {
    // rust: self.dialog_key(key.expect("a key"), None, None)
}
    // rust: None => Ok(()),
}
    // rust: if let Err(e) = result {
    // rust: log::warn!("Horizon: on-screen keyboard: {e}");
}
    // rust: } else if self.screen == Screen::Chat && self.title.is_none() {
    // rust: match text {
    // rust: Some(t) => self.chat_type(t),
    // rust: None => self.chat_key_code(key.expect("a key"), None),
}
    // rust: } else if self.sign_edit.is_some() {
    // rust: self.sign_input(key, text);
    // rust: } else if self.book.is_some() {
    // rust: self.book_input(key, text);
    // rust: } else if self.screen == Screen::Creative && self.creative_screen.tab().search {
    // rust: if backspace {
    // rust: self.creative_search_backspace(false);
    // rust: } else if key != Some(KeyCode::Enter) {
    // rust: self.creative_search_edit(text);
}
    // rust: } else if self.mod_browser_typing() {
    // rust: if key != Some(KeyCode::Enter) {
    // rust: self.mod_browser_text(text, backspace);
}
    // rust: } else if self.recipe_search_focused() {
    // rust: if key != Some(KeyCode::Enter) {
    // rust: self.recipe_text(text, backspace);
}
    // rust: } else if self.station_typing() {
    // rust: if key != Some(KeyCode::Enter) {
    // rust: self.station_text(text, backspace);
}
    // rust: } else if self.screen == Screen::WorldOptions {
    // rust: if key != Some(KeyCode::Enter) {
    // rust: self.world_options_text(text);
}
    // rust: } else if self.screen == Screen::CommandBlock {
            // Enter is its Done, as on the keyboard.
    // rust: match text {
    // rust: Some(t) => self.command_block_type(t),
    // rust: None => self.command_block_key_code(key.expect("a key"), None, None),
}
    // rust: } else if self.screen == Screen::BlockEditor {
    // rust: match text {
    // rust: Some(t) => self.block_editor_type(t),
    // rust: None => self.block_editor_key_code(key.expect("a key"), None, None),
}
    // rust: } else if self.screen == Screen::Social {
    // rust: match text {
    // rust: Some(t) => self.social_type(t),
    // rust: None if backspace => self.social_backspace(),
    // rust: None => {}
}
    // rust: } else if self.screen == Screen::DebugOptions {
    // rust: match text {
    // rust: Some(t) => self.debug_options_type(t),
    // rust: None if backspace => self.debug_options_backspace(),
    // rust: None => {}
}
    // rust: } else if self.screen == Screen::Options {
    // rust: let result = match text {
    // rust: Some(t) => {
    // rust: self.ui.options.type_text(&self.gui.atlas, t);
    // rust: Ok(())
}
    // rust: None => self.options_key(key.expect("a key"), None),
}
    // rust: if let Err(e) = result {
    // rust: log::warn!("Horizon: on-screen keyboard: {e}");
}
    // rust: } else if self.title.is_some() {
    // rust: match key {
    // rust: Some(KeyCode::Enter) => {
    // rust: if let Some(t) = self.title.as_mut() {
    // rust: t.confirm_edit();
}
}
    // rust: Some(KeyCode::Backspace) => self.title_edit(None, true),
    // rust: _ => self.title_edit(text, false),
}
}
        // Enter ends the typing, but for a dialog's new line; a field that
        // closed with it closes the keyboard.
    // rust: if (key == Some(KeyCode::Enter) && !self.dialog_typing_lines())
    // rust: || (!self.pad_typing()
    // rust: && self.title.is_none()
    // rust: && !matches!(self.screen, Screen::Options | Screen::WorldOptions))
    // rust: {
    // rust: self.pad.menu.osk = None;
}
}

    // ---- drawing ----

    /// The pad's cursor (pointer mode) or focus highlight (focus mode), and
    /// the on-screen keyboard, over everything else.
    // rust: pub(super) fn draw_pad_cursor(&self, batch: &mut HudBatch) {
    // rust: widgets::set_action_glyphs(self.pad_action_glyphs_on());
    // rust: widgets::set_action_screen(self.key_screen());
    // rust: if !self.pad_in_menu() {
    // rust: return;
}
    // rust: if let Some(keyboard) = &self.pad.menu.osk {
    // rust: let at_top = self
    // rust: .pad
    // rust: .menu
    // rust: .focus
    // rust: .is_some_and(|f| f.center().1 > batch.height / 2.0)
    // rust: || self.screen == Screen::Chat;
    // rust: let mut ui = horizon_client::ui_theme::Ui::new(&self.gui.atlas, batch, self.cursor);
    // rust: let options = &self.ui.options;
    // rust: keyboard.draw(&mut ui, at_top, options.pad_style, options.pad_by_letter);
    // rust: ui.finish();
    // rust: return;
}
    // rust: if !self.pad.in_use && !self.pad.menu.keyboard {
    // rust: return;
}
    // rust: let Some((x, y)) = self.pad.menu.pos else {
    // rust: return;
}
    // rust: if self.pad_focus_mode()
    // rust: && let Some(focus) = self.pad.menu.focus
    // rust: {
    // rust: self.draw_pad_focus(batch, focus);
    // rust: self.draw_pad_action_glyphs(batch);
    // rust: return;
}
    // rust: self.draw_pad_action_glyphs(batch);
        // A crosshair centred on the point it clicks: inventories, and a
        // screen with nothing to focus.
//         use horizon_client::pad_cursor;
    // rust: let (left, top) = pad_cursor::origin((x, y));
    // rust: batch.sprite_scaled(
    // rust: &self.gui.atlas,
    // rust: pad_cursor::SPRITE,
    // rust: left,
    // rust: top,
    // rust: pad_cursor::DRAWN,
    // rust: pad_cursor::DRAWN,
    // rust: u32::MAX,
    // rust: );
}

    /// The focus highlight, as vanilla's keyboard focus looks: buttons,
    /// sliders and slots already draw their highlighted sprite under the
    /// (hidden) pointer, and list rows and fields get vanilla's white
    /// one-pixel outline (`AbstractSelectionList`'s focused selection,
    /// `EditBox`'s highlighted border).
pub fn draw_pad_focus(self: *Self, batch: *mut HudBatch, focus: Target) void {
}
    // rust: key_focus::draw_outline(&self.gui.atlas, batch, focus);
}
}

/// Whether the keyboard opens by itself over chat or a sign: the pad is in
/// use and the screen has been open for a few polls, and it is neither
/// open nor dismissed already. Independent of the menu mode.
    // rust: fn osk_auto_opens(
    // rust: osk_open: bool,
    // rust: dismissed: bool,
    // rust: pad_in_use: bool,
    // rust: polls: u32,
    // rust: typing_screen: bool,
    // rust: ) -> bool {
    // rust: !osk_open && !dismissed && pad_in_use && polls >= 3 && typing_screen
}

/// Whether a text field in `targets` contains the point `at` (GUI pixels).
pub fn field_at(targets: *[Target], at: (f32) void {
}
    // rust: targets.iter().any(|t| {
    // rust: let [x, y, w, h] = t.rect;
    // rust: t.kind == Kind::Field && at.0 >= x && at.0 < x + w && at.1 >= y && at.1 < y + h
    // rust: })
}

    // rust: mod tests {
//     use super::*;

pub fn a_focus_that_lost_its_widget_goes_beside_it() void {
}
    // rust: let reset = [200.0, 50.0, 40.0, 20.0];
    // rust: let targets = [
    // rust: [0.0, 0.0, 100.0, 16.0],
    // rust: [100.0, 50.0, 90.0, 20.0],
    // rust: [0.0, 50.0, 40.0, 20.0],
    // rust: [200.0, 80.0, 40.0, 20.0],
    // rust: ];
    // rust: assert_eq!(beside(reset, &targets), Some(1));
    // rust: assert_eq!(beside(reset, &targets[3..]), None);
}

pub fn keyboard_auto_opens_for_pad_on_typing_screen() void {
}
    // rust: assert!(osk_auto_opens(false, false, true, 3, true));
    // rust: assert!(!osk_auto_opens(false, false, true, 2, true));
    // rust: assert!(!osk_auto_opens(false, false, false, 5, true));
    // rust: assert!(!osk_auto_opens(false, true, true, 5, true));
    // rust: assert!(!osk_auto_opens(true, false, true, 5, true));
    // rust: assert!(!osk_auto_opens(false, false, true, 5, false));
}

pub fn labelled(label: []const u8, rect: Rect) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, w, h] = rect;
    // rust: widgets::Widget {
    // rust: label: label.to_owned(),
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: enabled: true,
    // rust: kind: Kind::Button,
}
}

pub fn a_named_widget_is_found_wherever_it_moved() void {
}
    // rust: let (first, second) = ([10.0, 40.0, 100.0, 20.0], [10.0, 64.0, 100.0, 20.0]);
    // rust: let labels = [labelled("FOV: 80", second), labelled("Done", first)];
        // Its value changed its label and another row took its place: the name still finds it.
    // rust: assert_eq!(named_target("fov", &labels, &[first, second]), Some(1));
        // Clipped away: no target where the label says, so the rectangles decide.
    // rust: assert_eq!(named_target("fov", &labels, &[first]), None);
    // rust: assert_eq!(named_target("music", &labels, &[first, second]), None);
}

pub fn two_widgets_of_one_name_leave_it_to_the_rectangles() void {
}
    // rust: let (first, second) = ([10.0, 40.0, 40.0, 20.0], [10.0, 64.0, 40.0, 20.0]);
    // rust: let labels = [labelled("Reset", first), labelled("Reset", second)];
    // rust: assert_eq!(named_target("reset", &labels, &[first, second]), None);
}

pub fn a_scrollbar_tells_how_far_rows_moved_when_rectangles_cannot() void {
}
        // A whole row a notch: the same rectangles, so only the amount shows it.
    // rust: assert_eq!(list_shift(Some(0.0), Some(24.0)), Some(Some(-24.0)));
    // rust: assert_eq!(list_shift(Some(24.0), Some(0.0)), Some(Some(24.0)));
    // rust: assert_eq!(list_shift(Some(24.0), Some(24.0)), Some(None));
        // No scrollbar on either frame: nothing to ask.
    // rust: assert_eq!(list_shift(None, Some(24.0)), None);
    // rust: assert_eq!(list_shift(Some(24.0), None), None);
}

pub fn armed_button_clicks_only_while_still_focused() void {
}
    // rust: let rect = [10.0, 20.0, 100.0, 20.0];
    // rust: let kind = Kind::Button;
    // rust: let focus = Some(Target { rect, kind });
    // rust: assert_eq!(armed_click(Some(rect), focus), Some((60.0, 30.0)));
    // rust: let moved = Some(Target {
    // rust: rect: [10.0, 44.0, 100.0, 20.0],
    // rust: kind,
    // rust: });
    // rust: assert_eq!(armed_click(Some(rect), moved), None);
    // rust: assert_eq!(armed_click(Some(rect), None), None);
    // rust: assert_eq!(armed_click(None, focus), None);
}

pub fn clear_focus_leaves_nothing_focused() void {
}
    // rust: let mut menu = MenuCursor {
    // rust: focus: Some(Target {
    // rust: rect: [229.0, 98.0, 20.0, 18.0],
    // rust: kind: Kind::Button,
    // rust: }),
    // rust: origin: Some([229.0, 98.0, 20.0, 18.0]),
    // rust: slider_edit: true,
    // rust: ..MenuCursor::default()
}
    // rust: menu.clear_focus();
    // rust: assert!(menu.focus.is_none());
    // rust: assert!(menu.origin.is_none());
    // rust: assert!(!menu.slider_edit);
}

pub fn field_hit_test() void {
}
    // rust: let t = |rect, kind| Target { rect, kind };
    // rust: let targets = [
    // rust: t([0.0, 0.0, 50.0, 20.0], Kind::Button),
    // rust: t([10.0, 30.0, 100.0, 20.0], Kind::Field),
    // rust: ];
    // rust: assert!(field_at(&targets, (10.0, 30.0)));
    // rust: assert!(field_at(&targets, (109.0, 49.0)));
    // rust: assert!(!field_at(&targets, (110.0, 40.0)));
    // rust: assert!(!field_at(&targets, (50.0, 29.0)));
    // rust: assert!(!field_at(&targets, (5.0, 5.0)), "a button is not a field");
    // rust: assert!(!field_at(&[], (5.0, 5.0)));
}
}
