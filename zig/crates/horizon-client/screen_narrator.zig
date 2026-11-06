//! Transpiled from Horizon Rust crate
//! Module: horizon-client_screen_narrator
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Screen narration: what the narrator reads of the open screen and when, as
//! `Screen` does (`init`'s `triggerImmediateNarration`, `afterMouseMove`,
//! `afterMouseAction`, `afterKeyboardAction`, `updateNarratorStatus`,
//! `handleDelayedNarration`, `updateNarrationState`).
//!
//! Horizon's screens are drawn, not built from widget objects, so they record
//! their narration as they draw (`widgets::begin_screen`, `widgets::narratable`)
//! and [`ScreenNarrator::frame`] reads the last drawn frame's: a new screen id
//! is a screen opening (`init`), a new GUI size the same screen resized. The
//! input events the game hands it schedule the narration, and the frames run
//! it when due. The frames only record while the narrator can speak
//! (`shouldRunNarration`), whatever its status.
// use crate::widgets::{self, ElementType, ListKind, Narratable, Narration, ScreenInfo, What};
// use horizon_narrator::screen::{Output, Priority, ScreenNarration, Trigger, find_narratable};
// use std::collections::HashMap;
// use std::time::Instant;

/// `InputType`: what the player used last on a screen.
pub const InputType = enum {
    None,
    Mouse,
    KeyboardArrow,
    KeyboardTab,
};

    // rust: impl InputType {
pub fn is_keyboard(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, InputType::KeyboardArrow | InputType::KeyboardTab)
}
}

/// A translation key and its arguments to text (`Component.translatable`).
    // rust: pub type Translate<'a> = &'a dyn Fn(&str, &[&str]) -> String;

/// `Component.translatable(key, args)` in the current language.
pub fn translate(key: []const u8, args: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let args: Vec<&dyn std::fmt::Display> =
    // rust: args.iter().map(|a| a as &dyn std::fmt::Display).collect();
    // rust: crate::lang::tr(key, &args)
}

/// The open screen's narration.
pub const Open = struct {
    id: []const u8,
    /// The GUI size it was laid out for: a new one is `init` again.
    gui: (f32,
    state: ScreenNarration,
    /// Each container list row's `lastNarratable`, by list and row.
    row_last: HashMap<(u64,
    /// `LevelLoadingScreen.lastNarration`.
    last_repeat: i64,
};

/// The screens' narration: the open screen's state, the player's last input
/// type (`Minecraft.lastInputType`) and the widget a click focused.
pub const ScreenNarrator = struct {
    epoch: Instant,
    /// The clock tests set; `None` reads `epoch`.
    clock: ?i64,
    open: ?Open,
    input: InputType,
    /// `ContainerEventHandler.mouseClicked`'s `setFocused`: the widget last
    /// clicked keeps the focus until the screen changes.
    click_focus: ?u64,
    /// The last drawn frame's records.
    frame: Narration,
    /// `widgets::generation` when `frame` was read.
    generation: u64,
    /// The frames record their narration.
    recording: bool,
    /// The first frame was read: the narrator was there from the start.
    started: bool,
    /// The narrator came on while the game ran: the frame of this generation
    /// is the screen already open, which vanilla narrated silently all along.
    adopt: ?u64,
    /// `updateNarratorStatus` before that screen was read.
    pending_status: Option<(i64,
};

    // rust: impl Default for ScreenNarrator {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: epoch: Instant::now(),
    // rust: clock: None,
    // rust: open: None,
    // rust: input: InputType::None,
    // rust: click_focus: None,
    // rust: frame: Narration::default(),
    // rust: generation: 0,
    // rust: recording: false,
    // rust: started: false,
    // rust: adopt: None,
    // rust: pending_status: None,
}
}
}

/// The context `updateNarrationState` reads: the frame, the mouse, focus.
pub const Ctx = struct {
    frame: *'a Narration,
    info: *'a ScreenInfo,
    cursor: (f32,
    click_focus: ?u64,
    /// The controller's focus ring (GUI pixels).
    pad_focus: Option<[f32,
    input: InputType,
    /// `init`'s narration runs before the screen renders: nothing is hovered.
    init: bool,
    /// The frame's tooltip is the hovered widget's (HINT). Not inside a
    /// group, whose tooltips (a recipe's item) aren't its widgets'.
    tooltips: bool,
    tr: Translate<'a>,
};

pub fn contains(h]: [f32; 4]) void {
}
    // rust: cx >= x && cy >= y && cx < x + w && cy < y + h
}

pub fn same_rect(a: [f32; 4], b: [f32; 4]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a.iter().zip(b).all(|(p, q)| (p - q).abs() < 0.5)
}

pub fn num(n: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: n.to_string()
}

    // rust: impl Ctx<'_> {
pub fn tr(self: *Self, key: []const u8, args: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.tr)(key, args)
}
    /// The row widgets of the container list keyed `list`.
pub fn children(self: *Self, list: u64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.frame
    // rust: .items
    // rust: .iter()
    // rust: .filter(move |n| n.parent.is_some_and(|(l, _)| l == list))
}
    /// `isFocused`: the drawer's focus, a click's, or the controller's ring.
    /// A container list is focused with one of its widgets.
pub fn focused(self: *Self, n: *Narratable) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: n.focused
    // rust: || self.click_focus == Some(n.identity())
    // rust: || self.pad_focus.is_some_and(|r| same_rect(r, n.rect))
    // rust: || matches!(n.what, What::ContainerList { .. })
    // rust: && self.children(n.identity()).any(|c| self.focused(c))
}
    /// `isHovered`; a list's is a row under the mouse.
pub fn hovered(self: *Self, n: *Narratable) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.init
    // rust: && match &n.what {
    // rust: What::List { hovered, .. } => hovered.is_some(),
    // rust: What::ContainerList { hovered_row, .. } => hovered_row.is_some(),
    // rust: _ => n.hovered.unwrap_or_else(|| contains(n.rect, self.cursor)),
}
}
    /// `narrationPriority`. A group's is HOVERED while it is visible.
pub fn priority(self: *Self, n: *Narratable) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let What::Group { visible } = n.what {
    // rust: return if visible {
    // rust: Priority::Hovered
    // rust: } else {
    // rust: Priority::None
}
}
    // rust: if self.focused(n) {
    // rust: Priority::Focused
    // rust: } else if self.hovered(n) {
    // rust: Priority::Hovered
    // rust: } else {
    // rust: Priority::None
}
}
}

/// `Screen.updateNarrationState`: the title (or the screen's own elements),
/// then the narrated widget.
    // rust: fn update_narration_state(
    // rust: out: &mut Output<'_>,
    // rust: ctx: &Ctx<'_>,
    // rust: last: &mut Option<u64>,
    // rust: row_last: &mut HashMap<(u64, usize), u64>,
    // rust: ) {
    // rust: let info = ctx.info;
    // rust: let replaces_title =
    // rust: |e: &&(ElementType, u32, Vec<String>)| e.0 == ElementType::Title && e.1 == 0;
    // rust: match info.extra.iter().find(replaces_title) {
    // rust: Some((_, _, lines)) => out.add_lines(ElementType::Title, lines.clone()),
    // rust: None => out.add(ElementType::Title, info.title.clone()),
}
    // rust: for (kind, depth, lines) in info.extra.iter().filter(|e| !replaces_title(e)) {
    // rust: add_at(out, *depth, *kind, lines.clone());
}
    // rust: if info.widgets {
    // rust: update_narrated_widget(out, ctx, last, row_last);
}
}

pub fn add_at(out: *mut Output<'_>, depth: u32, kind: ElementType, lines: std.ArrayList([]const u8)) void {
}
    // rust: if depth == 0 {
    // rust: out.add_lines(kind, lines);
    // rust: } else {
    // rust: add_at(&mut out.nest(), depth - 1, kind, lines);
}
}

/// `Screen.updateNarratedWidget`: the active narratables in tab order, the
/// one `findNarratableWidget` picks with its position, or how to navigate.
    // rust: fn update_narrated_widget(
    // rust: out: &mut Output<'_>,
    // rust: ctx: &Ctx<'_>,
    // rust: last: &mut Option<u64>,
    // rust: row_last: &mut HashMap<(u64, usize), u64>,
    // rust: ) {
    // rust: let mut active: Vec<&Narratable> = ctx
    // rust: .frame
    // rust: .items
    // rust: .iter()
    // rust: .filter(|n| n.parent.is_none() && n.is_active())
    // rust: .collect();
    // rust: active.sort_by_key(|n| n.order);
    // rust: let entries: Vec<(u64, Priority)> = active
    // rust: .iter()
    // rust: .map(|n| (n.identity(), ctx.priority(n)))
    // rust: .collect();
    // rust: match find_narratable(&entries, *last) {
    // rust: Some((i, priority)) => {
    // rust: if priority.is_terminal() {
    // rust: *last = Some(entries[i].0);
}
    // rust: if active.len() > 1 {
    // rust: out.add(
    // rust: ElementType::Position,
    // rust: ctx.tr(
    // rust: "narrator.position.screen",
    // rust: &[&num(i + 1), &num(active.len())],
    // rust: ),
    // rust: );
    // rust: if priority == Priority::Focused {
    // rust: let usage = ctx.info.usage.clone();
    // rust: out.add(
    // rust: ElementType::Usage,
    // rust: usage.unwrap_or_else(|| ctx.tr("narration.component_list.usage", &[])),
    // rust: );
}
}
    // rust: narrate(&mut out.nest(), active[i], ctx, row_last);
}
    // rust: None if ctx.info.navigation => {
    // rust: out.add(ElementType::Usage, ctx.tr("narrator.screen.usage", &[]));
}
    // rust: None => {}
}
}

/// `AbstractWidget.updateNarration`: the widget's `updateWidgetNarration`,
/// then its tooltip's (HINT).
    // rust: fn narrate(
    // rust: out: &mut Output<'_>,
    // rust: n: &Narratable,
    // rust: ctx: &Ctx<'_>,
    // rust: row_last: &mut HashMap<(u64, usize), u64>,
    // rust: ) {
    // rust: let focused = ctx.focused(n);
    // AbstractWidget.defaultButtonNarrationText's usage.
    // rust: let button_usage = |out: &mut Output<'_>, active: bool| {
    // rust: if active {
    // rust: let key = if focused {
    // rust: "narration.button.usage.focused"
    // rust: } else {
    // rust: "narration.button.usage.hovered"
}
    // rust: out.add(ElementType::Usage, ctx.tr(key, &[]));
}
}
    // CycleButton.updateWidgetNarration's usage: the value a click moves to.
    // rust: let cycle_usage = |out: &mut Output<'_>, next: &str, active: bool| {
    // rust: if active {
    // rust: let key = if focused {
    // rust: "narration.cycle_button.usage.focused"
    // rust: } else {
    // rust: "narration.cycle_button.usage.hovered"
}
    // rust: out.add(ElementType::Usage, ctx.tr(key, &[next]));
}
}
    // rust: match &n.what {
    // rust: What::Button { message, active } => {
    // rust: out.add(ElementType::Title, ctx.tr("gui.narrate.button", &[message]));
    // rust: button_usage(out, *active);
}
    // rust: What::Named { title, active } => {
    // rust: out.add(ElementType::Title, title.clone());
    // rust: button_usage(out, *active);
}
    // rust: What::Slider { message, active } => {
    // rust: out.add(ElementType::Title, ctx.tr("gui.narrate.slider", &[message]));
    // rust: if *active {
                // AbstractSliderButton.setFocused: `canChangeValue` when the
                // focus came from the mouse or Tab.
    // rust: let key = if !focused {
    // rust: "narration.slider.usage.hovered"
    // rust: } else if matches!(ctx.input, InputType::Mouse | InputType::KeyboardTab) {
    // rust: "narration.slider.usage.focused"
    // rust: } else {
    // rust: "narration.slider.usage.focused.keyboard_cannot_change_value"
}
    // rust: out.add(ElementType::Usage, ctx.tr(key, &[]));
}
}
    // rust: What::Cycle {
    // rust: message,
    // rust: next,
    // rust: active,
    // rust: } => {
    // rust: out.add(ElementType::Title, ctx.tr("gui.narrate.button", &[message]));
    // rust: cycle_usage(out, next, *active);
}
    // rust: What::NamedCycle {
    // rust: title,
    // rust: next,
    // rust: active,
    // rust: } => {
    // rust: out.add(ElementType::Title, title.clone());
    // rust: cycle_usage(out, next, *active);
}
    // rust: What::Checkbox {
    // rust: message,
    // rust: selected,
    // rust: active,
    // rust: } => {
    // rust: out.add(ElementType::Title, ctx.tr("gui.narrate.button", &[message]));
    // rust: if *active {
    // rust: let key = match (focused, selected) {
    // rust: (true, true) => "narration.checkbox.usage.focused.uncheck",
    // rust: (true, false) => "narration.checkbox.usage.focused.check",
    // rust: (false, true) => "narration.checkbox.usage.hovered.uncheck",
    // rust: (false, false) => "narration.checkbox.usage.hovered.check",
}
    // rust: out.add(ElementType::Usage, ctx.tr(key, &[]));
}
}
    // rust: What::EditBox { message, value, .. } => {
    // rust: out.add(
    // rust: ElementType::Title,
    // rust: ctx.tr("gui.narrate.editBox", &[message, value]),
    // rust: );
}
    // rust: What::Text { message } => out.add(ElementType::Title, message.clone()),
    // rust: What::Recipe { item, more } => {
    // rust: out.add(ElementType::Title, ctx.tr("narration.recipe", &[item]));
    // rust: let mut lines = vec![ctx.tr("narration.button.usage.hovered", &[])];
    // rust: if *more {
    // rust: lines.push(ctx.tr("narration.recipe.usage.more", &[]));
}
    // rust: out.add_lines(ElementType::Usage, lines);
}
    // rust: What::List {
    // rust: kind,
    // rust: total,
    // rust: hovered,
    // rust: selected,
    // rust: } => {
            // ObjectSelectionList / TabNavigationBar.updateWidgetNarration:
            // the hovered row, else the selected one.
    // rust: let hovered = hovered.as_ref().filter(|_| !ctx.init);
    // rust: if let Some(row) = hovered.or(selected.as_ref()) {
    // rust: if *total > 1 {
    // rust: let key = match kind {
    // rust: ListKind::Object => "narrator.position.list",
    // rust: ListKind::Tabs => "narrator.position.tab",
}
    // rust: out.nest().add(
    // rust: ElementType::Position,
    // rust: ctx.tr(key, &[&num(row.index + 1), &num(*total)]),
    // rust: );
}
    // rust: match kind {
    // rust: ListKind::Object => out.add(ElementType::Title, row.narration.clone()),
    // rust: ListKind::Tabs => {
    // rust: out.add(
    // rust: ElementType::Title,
    // rust: ctx.tr("gui.narrate.tab", &[&row.narration]),
    // rust: );
    // rust: if let Some(hint) = &row.hint {
    // rust: out.add(ElementType::Hint, hint.clone());
}
}
}
}
    // rust: if focused {
    // rust: let key = match kind {
    // rust: ListKind::Object => "narration.selection.usage",
    // rust: ListKind::Tabs => "narration.tab_navigation.usage",
}
    // rust: out.add(ElementType::Usage, ctx.tr(key, &[]));
}
    // rust: return;
}
    // rust: What::Group { .. } => {
            // RecipeBookComponent.updateNarration: its active widgets'
            // pick (no last one: a focused widget is always it), one in.
    // rust: let group = n.identity();
    // rust: let children: Vec<&Narratable> =
    // rust: ctx.children(group).filter(|c| c.is_active()).collect();
    // rust: let entries: Vec<(u64, Priority)> = children
    // rust: .iter()
    // rust: .map(|c| (c.identity(), ctx.priority(c)))
    // rust: .collect();
    // rust: if let Some((i, _)) = find_narratable(&entries, None) {
    // rust: let ctx = Ctx {
    // rust: tooltips: false,
    // rust: ..*ctx
}
    // rust: narrate(&mut out.nest(), children[i], &ctx, row_last);
}
    // rust: return;
}
    // rust: What::ContainerList { rows, hovered_row } => {
            // ContainerObjectSelectionList.updateWidgetNarration: the row
            // under the mouse for the mouse and the system, else the focused
            // one; its widget one level deeper, the row's position here.
    // rust: let list = n.identity();
    // rust: let hovered_row = hovered_row.filter(|_| !ctx.init);
    // rust: let row = match (out.trigger(), hovered_row) {
    // rust: (Trigger::Mouse | Trigger::System, Some(row)) => Some(row),
    // rust: _ => ctx
    // rust: .children(list)
    // rust: .find(|c| ctx.focused(c))
    // rust: .and_then(|c| c.parent.map(|(_, row)| row)),
}
    // rust: if let Some(row) = row {
    // rust: let children: Vec<&Narratable> = ctx
    // rust: .children(list)
    // rust: .filter(|c| c.parent == Some((list, row)))
    // rust: .collect();
    // rust: narrate_row(&mut out.nest(), (list, row), &children, ctx, row_last);
    // rust: if *rows > 1 {
    // rust: out.add(
    // rust: ElementType::Position,
    // rust: ctx.tr("narrator.position.list", &[&num(row + 1), &num(*rows)]),
    // rust: );
}
}
    // rust: return;
}
}
    // rust: let hint = n.hint.clone().or_else(|| {
    // rust: (ctx.tooltips && ctx.hovered(n))
    // rust: .then(|| ctx.frame.tooltip.clone())
    // rust: .flatten()
    // rust: });
    // rust: if let Some(hint) = hint.filter(|h| !h.is_empty()) {
    // rust: out.add(ElementType::Hint, hint);
}
}

/// `ContainerObjectSelectionList.Entry.updateNarration`: the row's widget
/// `findNarratableWidget` picks (inactive ones too), with its place in the row.
    // rust: fn narrate_row(
    // rust: out: &mut Output<'_>,
    // rust: row: (u64, usize),
    // rust: children: &[&Narratable],
    // rust: ctx: &Ctx<'_>,
    // rust: row_last: &mut HashMap<(u64, usize), u64>,
    // rust: ) {
    // rust: let entries: Vec<(u64, Priority)> = children
    // rust: .iter()
    // rust: .map(|c| (c.identity(), ctx.priority(c)))
    // rust: .collect();
    // rust: let Some((i, priority)) = find_narratable(&entries, row_last.get(&row).copied()) else {
    // rust: return;
}
    // rust: if priority.is_terminal() {
    // rust: row_last.insert(row, entries[i].0);
}
    // rust: if children.len() > 1 {
    // rust: out.add(
    // rust: ElementType::Position,
    // rust: ctx.tr(
    // rust: "narrator.position.object_list",
    // rust: &[&num(i + 1), &num(children.len())],
    // rust: ),
    // rust: );
}
    // rust: narrate(&mut out.nest(), children[i], ctx, row_last);
}

/// `Screen.runNarration`: what to say now (empty for nothing).
pub fn run(open: *mut Open, ctx: *Ctx<'_>, only_changed: bool, trigger: Trigger) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Open {
    // rust: state, row_last, ..
    // rust: } = open;
    // rust: let mut last = state.last_narratable;
    // rust: let said = state.run(only_changed, trigger, |out| {
    // rust: update_narration_state(out, ctx, &mut last, row_last);
    // rust: });
    // rust: state.last_narratable = last;
    // rust: said
}

    // rust: impl ScreenNarrator {
pub fn now(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.clock
    // rust: .unwrap_or_else(|| self.epoch.elapsed().as_millis() as i64)
}

    /// `Minecraft.setLastInputType`: the mouse's buttons, Tab and the arrows.
    /// Tab and the arrows move the focus off what a click focused.
pub fn set_input(self: *Self, input: InputType) void {
}
    // rust: self.input = input;
    // rust: if input.is_keyboard() {
    // rust: self.click_focus = None;
}
}
    /// `MouseHandler.handleAccumulatedMovement`: `afterMouseMove`.
pub fn mouse_moved(self: *Self) void {
}
    // rust: let now = self.now();
    // rust: if let Some(open) = &mut self.open {
    // rust: open.state.after_mouse_move(now);
}
}
    /// A scroll (`MouseHandler.onScroll`): `afterMouseAction`.
pub fn mouse_action(self: *Self) void {
}
    // rust: let now = self.now();
    // rust: if let Some(open) = &mut self.open {
    // rust: open.state.after_mouse_action(now);
}
}
    /// A mouse button pressed at `cursor` (GUI pixels), before the screen
    /// takes it (`MouseHandler.onButton`): `afterMouseAction`, and a left
    /// click focuses the active widget under the mouse (a container list's
    /// row widget, else the list), as `mouseClicked` does. A click on nothing
    /// keeps the focus.
pub fn mouse_pressed(self: *Self, cursor: (f32) void {
}
    // rust: if self.open.is_none() {
    // rust: return;
}
    // rust: if left && let Some(key) = self.clicked(cursor) {
    // rust: self.click_focus = Some(key);
}
    // rust: self.mouse_action();
}
pub fn clicked(self: *Self, cursor: (f32) void {
}
    // rust: let items = &self.frame.items;
    // rust: let top = items
    // rust: .iter()
    // rust: .find(|n| n.parent.is_none() && n.is_active() && contains(n.rect, cursor))?;
    // rust: let key = top.identity();
    // rust: if !matches!(top.what, What::ContainerList { .. }) {
    // rust: return Some(key);
}
    // rust: let child = items.iter().find(|c| {
    // rust: c.parent.is_some_and(|(list, _)| list == key)
    // rust: && c.is_active()
    // rust: && contains(c.rect, cursor)
    // rust: });
    // rust: Some(child.map_or(key, Narratable::identity))
}
    /// A key pressed before the screen takes it (`KeyboardHandler.keyPress`):
    /// `afterKeyboardAction`.
pub fn keyboard_action(self: *Self) void {
}
    // rust: let now = self.now();
    // rust: if let Some(open) = &mut self.open {
    // rust: open.state.after_keyboard_action(now);
}
}
    /// `Screen.updateNarratorStatus(wasDisabled, trigger)`: once the narrator
    /// is turned on, the open screen is narrated two seconds later.
pub fn status_changed(self: *Self, was_disabled: bool, trigger: Trigger) void {
}
    // rust: let now = self.now();
    // rust: match &mut self.open {
    // rust: Some(open) => open.state.after_status_change(now, was_disabled, trigger),
    // rust: None => self.pending_status = Some((now, was_disabled, trigger)),
}
}

    /// Once per event loop turn, after `widgets::end_frame`: switches the
    /// frames' recording with the narrator, reads the last drawn frame and
    /// says what is due (`Gui.update`'s `handleDelayedNarration`, `init`'s
    /// narration). `gui` is the GUI size, `cursor` the mouse in it,
    /// `pad_focus` the controller's focus ring.
pub fn frame(self: *Self, gui: (f32) void {
}
    // rust: let active = horizon_narrator::is_active();
    // rust: for said in self.frame_with(active, gui, cursor, pad_focus, &translate) {
    // rust: horizon_narrator::say_system_now(&said);
}
}

    /// [`frame`](Self::frame) with the narrator there (`active`) or not: what
    /// to say. `Screen.shouldRunNarration` is `GameNarrator.isActive`, whether
    /// the narrator *can* speak, not its status: while it is off the screens'
    /// narration still runs and is marked said (`saySystemNow` drops it), so
    /// the click that turns it on in the options says only what it changed,
    /// 200 ms later, after the status announcement.
    // rust: fn frame_with(
    // rust: &mut self,
    // rust: active: bool,
    // rust: gui: (f32, f32),
    // rust: cursor: (f32, f32),
    // rust: pad_focus: Option<[f32; 4]>,
    // rust: tr: Translate<'_>,
    // rust: ) -> Vec<String> {
    // rust: if !active {
    // rust: if self.recording {
    // rust: widgets::set_narrating(false);
    // rust: self.recording = false;
    // rust: self.open = None;
    // rust: self.frame = Narration::default();
    // rust: self.adopt = None;
}
    // rust: self.pending_status = None;
    // rust: self.started = true;
    // rust: return Vec::new();
}
    // rust: let generation = widgets::generation();
    // rust: if !self.recording {
    // rust: widgets::set_narrating(true);
    // rust: self.recording = true;
    // rust: self.turned_on(generation);
    // rust: return Vec::new();
}
        // A screen's `triggerImmediateNarration(true)` (a list refilled)
        // reads the frame drawn after it.
    // rust: let mut narrate_now = false;
    // rust: if generation != self.generation {
    // rust: self.generation = generation;
    // rust: self.frame = widgets::take_last_narration();
    // rust: narrate_now = widgets::take_narrate_now();
}
    // rust: let now = self.now();
    // rust: let said = self.step(now, gui, cursor, pad_focus, narrate_now, tr);
        // The drawers work out what only a focused widget narrates for it.
    // rust: let clicked = self.click_focus.and_then(|key| {
    // rust: let items = &self.frame.items;
    // rust: items.iter().find(|n| n.identity() == key).map(|n| n.rect)
    // rust: });
    // rust: widgets::set_narration_focus(clicked.or(pad_focus));
    // rust: said
}

    /// The frames record from the next one drawn, of `generation + 1`: at
    /// startup that is the first screen opening; later it is the screen open
    /// when the narrator came on.
pub fn turned_on(self: *Self, generation: u64) void {
}
    // rust: self.generation = generation;
    // rust: self.adopt = self.started.then_some(generation + 1);
    // rust: self.started = true;
}

    /// One turn over the frame read: the open screen's `init` when it is new
    /// or resized, its repeated narration and the narration due.
    // rust: fn step(
    // rust: &mut self,
    // rust: now: i64,
    // rust: gui: (f32, f32),
    // rust: cursor: (f32, f32),
    // rust: pad_focus: Option<[f32; 4]>,
    // rust: narrate_now: bool,
    // rust: tr: Translate<'_>,
    // rust: ) -> Vec<String> {
    // rust: let adopting = self.adopt.is_some_and(|g| self.generation >= g);
    // rust: let pending = if adopting {
    // rust: self.adopt = None;
    // rust: self.pending_status.take()
    // rust: } else {
    // rust: None
}
    // rust: let Some(info) = &self.frame.screen else {
    // rust: self.open = None;
    // rust: return Vec::new();
}
    // rust: let opened = self.open.as_ref().is_none_or(|o| o.id != info.id);
    // rust: let resized = !opened && self.open.as_ref().is_some_and(|o| o.gui != gui);
    // rust: if opened {
            // Minecraft.setScreen over no screen: `setLastInputType(NONE)`,
            // so a screen opened from the game is never a keyboard one.
    // rust: if self.open.is_none() && !adopting {
    // rust: self.input = InputType::None;
}
    // rust: self.click_focus = None;
    // rust: self.open = Some(Open {
    // rust: id: info.id.clone(),
    // rust: gui,
    // rust: state: ScreenNarration::default(),
    // rust: row_last: HashMap::new(),
    // rust: last_repeat: now,
    // rust: });
    // rust: } else if resized && let Some(open) = &mut self.open {
            // init(width, height) again: rebuildWidgets and clearFocus.
    // rust: open.gui = gui;
    // rust: open.state.last_narratable = None;
    // rust: open.row_last.clear();
    // rust: self.click_focus = None;
}
    // rust: let ctx = |init| Ctx {
    // rust: frame: &self.frame,
    // rust: info,
    // rust: cursor,
    // rust: click_focus: self.click_focus,
    // rust: pad_focus,
    // rust: input: self.input,
    // rust: init,
    // rust: tooltips: true,
    // rust: tr,
}
    // rust: let Some(open) = &mut self.open else {
    // rust: return Vec::new();
}
    // rust: let mut said = Vec::new();
    // rust: if opened || resized {
            // Screen.init: `triggerImmediateNarration(false)`, then the
            // suppression (until the next key for a keyboard user).
    // rust: let text = run(open, &ctx(true), false, Trigger::System);
    // rust: if adopting {
    // rust: if let Some((at, was_disabled, trigger)) = pending {
    // rust: open.state.after_status_change(at, was_disabled, trigger);
}
    // rust: } else {
    // rust: said.push(text);
    // rust: open.state.after_init(now, self.input.is_keyboard());
}
}
    // rust: if narrate_now
    // rust: || info
    // rust: .repeat_ms
    // rust: .is_some_and(|ms| now - open.last_repeat > i64::from(ms))
    // rust: {
    // rust: open.last_repeat = now;
    // rust: said.push(run(open, &ctx(false), true, Trigger::System));
}
    // rust: if let Some(trigger) = open.state.due(now) {
    // rust: said.push(run(open, &ctx(false), true, trigger));
}
    // rust: said.retain(|s| !s.is_empty());
    // rust: said
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::widgets::Row;
//     use ElementType::*;

    /// Keys and their arguments as they are, so the tests read what the
    /// narration is made of without a language loaded.
pub fn keys(key: []const u8, args: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if args.is_empty() {
    // rust: key.to_owned()
    // rust: } else {
    // rust: format!("{key}({})", args.join(", "))
}
}

pub const GUI: (f32, f32) = (427.0, 240.0);

pub const Harness = struct {
    n: ScreenNarrator,
    cursor: (f32,
    pad_focus: Option<[f32,
    gui: (f32,
};

    // rust: impl Harness {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut n = ScreenNarrator {
    // rust: clock: Some(0),
    // rust: ..Default::default()
}
    // rust: n.turned_on(0);
    // rust: Self {
    // rust: n,
    // rust: cursor: (-1.0, -1.0),
    // rust: pad_focus: None,
    // rust: gui: GUI,
}
}
        /// A frame of `screen` drawn and read at `at`.
pub fn draw(self: *Self, at: i64, screen: *ScreenInfo, items: *[Narratable]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.draw_with(at, screen, items, None)
}
    // rust: fn draw_with(
    // rust: &mut self,
    // rust: at: i64,
    // rust: screen: &ScreenInfo,
    // rust: items: &[Narratable],
    // rust: tooltip: Option<&str>,
    // rust: ) -> Vec<String> {
    // rust: self.n.clock = Some(at);
    // rust: self.n.generation += 1;
    // rust: self.n.frame = Narration {
    // rust: screen: Some(screen.clone()),
    // rust: items: items.to_vec(),
    // rust: tooltip: tooltip.map(str::to_owned),
}
    // rust: self.n
    // rust: .step(at, self.gui, self.cursor, self.pad_focus, false, &keys)
}
pub fn at(self: *Self, at: i64) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.n.clock = Some(at);
    // rust: &mut self.n
}
        /// A left click where the mouse is.
pub fn press(self: *Self, at: i64) void {
}
    // rust: self.n.clock = Some(at);
    // rust: self.n.mouse_pressed(self.cursor, true);
}
}

pub fn button(message: []const u8, y: f32) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Narratable::button(message, [100.0, y, 200.0, 20.0], true)
}

pub fn title_screen() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: ScreenInfo::new("title", "Title Screen"),
    // rust: vec![
    // rust: button("Singleplayer", 100.0),
    // rust: button("Multiplayer", 124.0),
    // rust: Narratable::button("Minecraft Realms", [100.0, 148.0, 200.0, 20.0], false),
    // rust: button("Options...", 196.0),
    // rust: ],
    // rust: )
}

pub fn a_screen_opening_says_its_title_and_how_to_navigate() void {
}
    // rust: let mut h = Harness::new();
    // rust: let (screen, items) = title_screen();
        // Under the mouse already, but `init` narrates before the render.
    // rust: h.cursor = (150.0, 110.0);
    // rust: assert_eq!(
    // rust: h.draw(0, &screen, &items),
    // rust: ["Title Screen. narrator.screen.usage"]
    // rust: );
        // The same screen drawn again says nothing new.
    // rust: assert!(h.draw(16, &screen, &items).is_empty());
    // rust: assert!(h.draw(5000, &screen, &items).is_empty());
}

pub fn hovering_a_button_names_it_once_the_suppression_ends() void {
}
    // rust: let mut h = Harness::new();
    // rust: let (screen, items) = title_screen();
    // rust: h.draw(0, &screen, &items);
    // rust: h.cursor = (150.0, 130.0);
    // rust: h.at(100).mouse_moved();
        // Due at 850, but quiet for 2 s after init.
    // rust: assert!(h.draw(1000, &screen, &items).is_empty());
        // Realms is inactive: three narratables, Multiplayer the second.
    // rust: assert_eq!(
    // rust: h.draw(2001, &screen, &items),
    // rust: [
    // rust: "gui.narrate.button(Multiplayer). narrator.position.screen(2, 3). \
    // rust: narration.button.usage.hovered"
    // rust: ]
    // rust: );
        // Moving to Options... says only what changed.
    // rust: h.cursor = (150.0, 200.0);
    // rust: h.at(3000).mouse_moved();
    // rust: assert!(h.draw(3700, &screen, &items).is_empty());
    // rust: assert_eq!(
    // rust: h.draw(3751, &screen, &items),
    // rust: ["gui.narrate.button(Options...). narrator.position.screen(3, 3)"]
    // rust: );
}

pub fn a_click_focuses_its_widget_and_the_focus_is_narrated_first() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("options", "Options");
    // rust: let items = [button("FOV: 70", 50.0), button("Done", 200.0)];
    // rust: h.draw(0, &screen, &items);
    // rust: h.cursor = (150.0, 60.0);
    // rust: h.press(10);
        // A click lifts the suppression: 200 ms later, focused.
    // rust: assert_eq!(
    // rust: h.draw(211, &screen, &items),
    // rust: [
    // rust: "gui.narrate.button(FOV: 70). narrator.position.screen(1, 2). \
    // rust: narration.component_list.usage. narration.button.usage.focused"
    // rust: ]
    // rust: );
        // The focused one was narrated last: the hovered one goes first.
    // rust: h.cursor = (150.0, 205.0);
    // rust: h.at(300).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(1051, &screen, &items),
    // rust: ["gui.narrate.button(Done). narrator.position.screen(2, 2). \
    // rust: narration.button.usage.hovered"]
    // rust: );
        // A click on nothing keeps the focus; a new screen drops it.
    // rust: h.at(1100).mouse_pressed((0.0, 0.0), true);
    // rust: assert_eq!(h.n.click_focus, Some(items[0].identity()));
    // rust: h.draw(1200, &ScreenInfo::new("video", "Video Settings"), &items);
    // rust: assert_eq!(h.n.click_focus, None);
}

pub fn inactive_widgets_are_not_narrated_and_a_single_one_has_no_position() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("death", "You Died!");
    // rust: let inactive = [
    // rust: Narratable::button("Respawn", [100.0, 100.0, 200.0, 20.0], false),
    // rust: Narratable::button("Title Screen", [100.0, 124.0, 200.0, 20.0], false),
    // rust: ];
    // rust: assert_eq!(
    // rust: h.draw(0, &screen, &inactive),
    // rust: ["You Died!. narrator.screen.usage"]
    // rust: );
    // rust: h.cursor = (150.0, 110.0);
    // rust: let items = [
    // rust: Narratable::button("Respawn", [100.0, 100.0, 200.0, 20.0], true),
    // rust: Narratable::button("Title Screen", [100.0, 124.0, 200.0, 20.0], false),
    // rust: ];
    // rust: h.at(3000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(3751, &screen, &items),
    // rust: ["gui.narrate.button(Respawn). narration.button.usage.hovered"]
    // rust: );
}

pub fn sliders_cycle_buttons_and_checkboxes_say_how_to_use_them() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("video", "Video Settings");
    // rust: let items = [
    // rust: Narratable::slider("FOV: 70", [0.0, 0.0, 150.0, 20.0], true),
    // rust: Narratable::new(
    // rust: What::Cycle {
    // rust: message: "Graphics: Fancy".into(),
    // rust: next: "Fabulous!".into(),
    // rust: active: true,
    // rust: },
    // rust: [0.0, 30.0, 150.0, 20.0],
    // rust: ),
    // rust: Narratable::new(
    // rust: What::Checkbox {
    // rust: message: "Do not show this screen again".into(),
    // rust: selected: true,
    // rust: active: true,
    // rust: },
    // rust: [0.0, 60.0, 150.0, 20.0],
    // rust: ),
    // rust: ];
    // rust: h.draw(0, &screen, &items);
        // The controller's ring focuses the slider, as the arrows would:
        // the keyboard can't change it before Enter.
    // rust: h.pad_focus = Some(items[0].rect);
    // rust: h.at(3000).set_input(InputType::KeyboardArrow);
    // rust: h.n.keyboard_action();
    // rust: assert_eq!(
    // rust: h.draw(3201, &screen, &items),
    // rust: [
    // rust: "gui.narrate.slider(FOV: 70). narrator.position.screen(1, 3). \
    // rust: narration.component_list.usage. \
    // rust: narration.slider.usage.focused.keyboard_cannot_change_value"
    // rust: ]
    // rust: );
    // rust: h.pad_focus = None;
    // rust: h.cursor = (10.0, 40.0);
    // rust: h.at(4000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(4751, &screen, &items),
    // rust: [
    // rust: "gui.narrate.button(Graphics: Fancy). narrator.position.screen(2, 3). \
    // rust: narration.cycle_button.usage.hovered(Fabulous!)"
    // rust: ]
    // rust: );
    // rust: h.cursor = (10.0, 70.0);
    // rust: h.at(5000).set_input(InputType::Mouse);
    // rust: h.n.mouse_pressed(h.cursor, true);
    // rust: assert_eq!(
    // rust: h.draw(5201, &screen, &items),
    // rust: ["gui.narrate.button(Do not show this screen again). \
    // rust: narrator.position.screen(3, 3). narration.component_list.usage. \
    // rust: narration.checkbox.usage.focused.uncheck"]
    // rust: );
        // A click focuses a slider that the keys can then change.
    // rust: h.cursor = (10.0, 10.0);
    // rust: h.press(6000);
    // rust: assert_eq!(
    // rust: h.draw(6201, &screen, &items),
    // rust: [
    // rust: "gui.narrate.slider(FOV: 70). narrator.position.screen(1, 3). \
    // rust: narration.slider.usage.focused"
    // rust: ]
    // rust: );
}

pub fn a_hovered_widget_reads_its_tooltip_as_a_hint() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("options", "Options");
    // rust: let items = [
    // rust: button("Language...", 50.0),
    // rust: button("Done", 200.0).hint("Back to the game"),
    // rust: ];
    // rust: h.draw(0, &screen, &items);
    // rust: h.cursor = (150.0, 60.0);
    // rust: h.at(3000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw_with(
    // rust: 3751,
    // rust: &screen,
    // rust: &items,
    // rust: Some("Translations may not be accurate")
    // rust: ),
    // rust: [
    // rust: "gui.narrate.button(Language...). narrator.position.screen(1, 2). \
    // rust: Translations may not be accurate. narration.button.usage.hovered"
    // rust: ]
    // rust: );
        // Its own hint, whatever the frame's tooltip.
    // rust: h.cursor = (150.0, 205.0);
    // rust: h.at(4000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw_with(4751, &screen, &items, Some("Other")),
    // rust: ["gui.narrate.button(Done). narrator.position.screen(2, 2). Back to the game"]
    // rust: );
}

pub fn an_object_list_narrates_its_hovered_row_or_its_selection() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("select_world", "Select World");
    // rust: let list = |hovered: Option<Row>| {
    // rust: Narratable::new(
    // rust: What::List {
    // rust: kind: ListKind::Object,
    // rust: total: 3,
    // rust: hovered,
    // rust: selected: Some(Row::new(0, "Selected: World A")),
    // rust: },
    // rust: [0.0, 50.0, 427.0, 150.0],
    // rust: )
    // rust: .key(widgets::key_of(&"worlds"))
}
    // rust: let items = vec![
    // rust: list(Some(Row::new(1, "Selected: World B"))),
    // rust: button("Play Selected World", 210.0),
    // rust: ];
    // rust: h.draw(0, &screen, &items);
    // rust: h.at(3000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(3751, &screen, &items),
    // rust: ["Selected: World B. narrator.position.screen(1, 2). \
    // rust: narrator.position.list(2, 3)"]
    // rust: );
        // Clicked: focused, its selection and how to move it.
    // rust: h.cursor = (10.0, 60.0);
    // rust: h.press(4000);
    // rust: let items = vec![list(None), button("Play Selected World", 210.0)];
    // rust: assert_eq!(
    // rust: h.draw(4201, &screen, &items),
    // rust: ["Selected: World A. narrator.position.list(1, 3). \
    // rust: narration.component_list.usage. narration.selection.usage"]
    // rust: );
}

pub fn tabs_name_the_hovered_or_current_tab() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("create_world", "Create New World");
    // rust: let mut current = Row::new(0, "Game");
    // rust: current.hint = Some(String::new());
    // rust: let tabs = Narratable::new(
    // rust: What::List {
    // rust: kind: ListKind::Tabs,
    // rust: total: 3,
    // rust: hovered: None,
    // rust: selected: Some(current),
    // rust: },
    // rust: [0.0, 0.0, 427.0, 24.0],
    // rust: )
    // rust: .focused(true);
        // Focused at init (a keyboard user's initial focus).
    // rust: assert_eq!(
    // rust: h.draw(0, &screen, &[tabs]),
    // rust: [
    // rust: "Create New World. gui.narrate.tab(Game). narrator.position.tab(1, 3). . \
    // rust: narration.tab_navigation.usage"
    // rust: ]
    // rust: );
}

pub fn a_container_list_narrates_its_row_and_the_rows_widget() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("options/Video", "Video Settings");
    // rust: let list = widgets::key_of(&"options");
    // rust: let child = |message: &str, x: f32, y: f32, row: usize| {
    // rust: Narratable::button(message, [x, y, 150.0, 20.0], true)
    // rust: .key(widgets::key_of(&message))
    // rust: .child_of(list, row)
}
    // rust: let items = vec![
    // rust: Narratable::new(
    // rust: What::ContainerList {
    // rust: rows: 3,
    // rust: hovered_row: Some(1),
    // rust: },
    // rust: [0.0, 30.0, 427.0, 150.0],
    // rust: )
    // rust: .key(list),
    // rust: child("Graphics: Fancy", 50.0, 40.0, 0),
    // rust: child("Render Distance: 12", 210.0, 40.0, 0),
    // rust: child("Max Framerate: 120", 50.0, 64.0, 1),
    // rust: child("VSync: ON", 210.0, 64.0, 1),
    // rust: button("Done", 200.0),
    // rust: ];
    // rust: h.draw(0, &screen, &items);
    // rust: h.cursor = (250.0, 70.0);
    // rust: h.at(3000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(3751, &screen, &items),
    // rust: [
    // rust: "gui.narrate.button(VSync: ON). narrator.position.screen(1, 2). \
    // rust: narrator.position.list(2, 3). narrator.position.object_list(2, 2). \
    // rust: narration.button.usage.hovered"
    // rust: ]
    // rust: );
        // A click on a row's widget focuses it, and the list with it: the
        // keyboard's narration reads the focused row.
    // rust: h.press(4000);
    // rust: assert_eq!(h.n.click_focus, Some(widgets::key_of(&"VSync: ON")));
    // rust: h.at(4100).keyboard_action();
    // rust: assert_eq!(
    // rust: h.draw(4301, &screen, &items),
    // rust: ["narration.component_list.usage. narration.button.usage.focused"]
    // rust: );
}

pub fn a_screen_of_its_own_elements_skips_the_widgets() void {
}
    // rust: let mut h = Harness::new();
    // rust: let chat = ScreenInfo::new("chat", "Chat screen")
    // rust: .without_widgets()
    // rust: .without_navigation()
    // rust: .element(Usage, 0, "Input message and press Enter to send")
    // rust: .element(Title, 1, "Message to send: hi");
    // rust: let items = [Narratable::edit_box("", "hi", [2.0, 228.0, 423.0, 12.0]).focused(true)];
    // rust: assert_eq!(
    // rust: h.draw(0, &chat, &items),
    // rust: ["Chat screen. Message to send: hi. Input message and press Enter to send"]
    // rust: );
        // NO_TITLE still says its empty title.
    // rust: let connecting = ScreenInfo::new("connect", "");
    // rust: assert_eq!(h.draw(10, &connecting, &[]), [". narrator.screen.usage"]);
}

pub fn a_repeating_screen_says_what_changed_every_two_seconds() void {
}
    // rust: let mut h = Harness::new();
    // rust: let loading = |p: u32| {
    // rust: ScreenInfo::new("level_loading", "")
    // rust: .without_navigation()
    // rust: .element(Title, 0, format!("Loading {p}%"))
    // rust: .repeat_every(2000)
}
    // rust: assert_eq!(h.draw(0, &loading(0), &[]), ["Loading 0%"]);
    // rust: assert!(h.draw(1500, &loading(40), &[]).is_empty());
    // rust: assert_eq!(h.draw(2001, &loading(50), &[]), ["Loading 50%"]);
    // rust: assert!(h.draw(4002, &loading(50), &[]).is_empty());
        // `triggerImmediateNarration(true)` at once.
    // rust: h.n.frame.screen = Some(loading(60));
    // rust: assert_eq!(
    // rust: h.n.step(4100, GUI, (0.0, 0.0), None, true, &keys),
    // rust: ["Loading 60%"]
    // rust: );
}

pub fn a_resize_narrates_the_screen_again() void {
}
    // rust: let mut h = Harness::new();
    // rust: let (screen, items) = title_screen();
    // rust: h.draw(0, &screen, &items);
    // rust: h.gui = (640.0, 360.0);
    // rust: assert_eq!(
    // rust: h.draw(5000, &screen, &items),
    // rust: ["Title Screen. narrator.screen.usage"]
    // rust: );
        // And is quiet for two seconds again.
    // rust: h.cursor = (150.0, 110.0);
    // rust: h.at(5100).mouse_moved();
    // rust: assert!(h.draw(6000, &screen, &items).is_empty());
}

pub fn a_keyboard_user_hears_nothing_more_until_the_next_key() void {
}
    // rust: let mut h = Harness::new();
    // rust: let (screen, items) = title_screen();
    // rust: h.draw(0, &screen, &items);
    // rust: h.at(10).set_input(InputType::KeyboardTab);
    // rust: h.n.keyboard_action();
        // Options opened from the title screen by keyboard.
    // rust: let options = ScreenInfo::new("options", "Options");
    // rust: assert_eq!(
    // rust: h.draw(100, &options, &items),
    // rust: ["Options. narrator.screen.usage"]
    // rust: );
    // rust: h.cursor = (150.0, 110.0);
    // rust: h.at(200).mouse_moved();
    // rust: assert!(h.draw(100_000, &options, &items).is_empty());
    // rust: h.at(100_001).keyboard_action();
    // rust: assert_eq!(
    // rust: h.draw(100_202, &options, &items),
    // rust: [
    // rust: "gui.narrate.button(Singleplayer). narrator.position.screen(1, 3). \
    // rust: narration.button.usage.hovered"
    // rust: ]
    // rust: );
        // A screen opened from the game forgets the keyboard.
    // rust: h.n.frame.screen = None;
    // rust: h.n.step(100_300, GUI, h.cursor, None, false, &keys);
    // rust: assert_eq!(
    // rust: h.draw(100_400, &options, &items),
    // rust: ["Options. narrator.screen.usage"]
    // rust: );
    // rust: assert_eq!(h.n.input, InputType::None);
}

pub fn the_narrator_turned_on_over_a_screen_narrates_it_two_seconds_later() void {
}
    // rust: let mut h = Harness::new();
    // rust: let (screen, items) = title_screen();
        // Ctrl+B before the frames record: the screen open is taken as it
        // is, silently, then narrated 2 s after the key.
    // rust: h.n.recording = false;
    // rust: h.at(1000).status_changed(true, Trigger::Keyboard);
    // rust: h.n.turned_on(h.n.generation);
    // rust: h.cursor = (150.0, 110.0);
    // rust: assert!(h.draw(1016, &screen, &items).is_empty());
    // rust: assert!(h.draw(3000, &screen, &items).is_empty());
        // Only what changed since: the hovered button, which init didn't see.
    // rust: assert_eq!(
    // rust: h.draw(3001, &screen, &items),
    // rust: [
    // rust: "gui.narrate.button(Singleplayer). narrator.position.screen(1, 3). \
    // rust: narration.button.usage.hovered"
    // rust: ]
    // rust: );
}

pub fn key_binds_rows_name_their_key_and_headers_their_category() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("options/KeyBinds", "Key Binds");
    // rust: let list = widgets::key_of(&"options/KeyBinds/list");
    // rust: let child = |n: Narratable, row: usize, x: f32| {
    // rust: n.key(widgets::key_of(&(list, row, x as i32)))
    // rust: .child_of(list, row)
}
    // rust: let items = vec![
    // rust: Narratable::container_list(3, Some(1), [0.0, 38.0, 427.0, 160.0]).key(list),
    // rust: child(
    // rust: Narratable::text("Movement", [180.0, 40.0, 60.0, 17.0]),
    // rust: 0,
    // rust: 180.0,
    // rust: ),
    // rust: child(
    // rust: Narratable::named(
    // rust: "Jump is bound to gui.narrate.button(Space)",
    // rust: [200.0, 60.0, 75.0, 20.0],
    // rust: true,
    // rust: ),
    // rust: 1,
    // rust: 200.0,
    // rust: ),
    // rust: child(
    // rust: Narratable::named("Reset Jump button", [280.0, 60.0, 50.0, 20.0], false),
    // rust: 1,
    // rust: 280.0,
    // rust: ),
    // rust: button("Done", 210.0),
    // rust: ];
    // rust: h.draw(0, &screen, &items);
    // rust: h.cursor = (210.0, 65.0);
    // rust: h.at(3000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(3751, &screen, &items),
    // rust: [
    // rust: "Jump is bound to gui.narrate.button(Space). narrator.position.screen(1, 2). \
    // rust: narrator.position.list(2, 3). narrator.position.object_list(1, 2). \
    // rust: narration.button.usage.hovered"
    // rust: ]
    // rust: );
        // The category header row narrates its text, nothing more.
    // rust: let mut items = items;
    // rust: items[0] = Narratable::container_list(3, Some(0), [0.0, 38.0, 427.0, 160.0]).key(list);
    // rust: h.cursor = (200.0, 45.0);
    // rust: h.at(4000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(4751, &screen, &items),
    // rust: ["Movement. narrator.position.list(1, 3)"]
    // rust: );
}

pub fn a_switch_narrates_its_own_message_and_next_value() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("create_world", "Create New World");
    // rust: let items = [Narratable::new(
    // rust: What::NamedCycle {
    // rust: title: "Generate Structures. gui.narrate.button(: ON). Villages".into(),
    // rust: next: "OFF".into(),
    // rust: active: true,
    // rust: },
    // rust: [100.0, 100.0, 44.0, 20.0],
    // rust: )
    // rust: .hint("Villages")];
    // rust: h.draw(0, &screen, &items);
    // rust: h.cursor = (110.0, 110.0);
    // rust: h.at(3000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(3751, &screen, &items),
    // rust: [
    // rust: "Generate Structures. gui.narrate.button(: ON). Villages. Villages. \
    // rust: narration.cycle_button.usage.hovered(OFF)"
    // rust: ]
    // rust: );
}

pub fn the_recipe_book_narrates_its_hovered_widget_one_level_in() void {
}
    // rust: let mut h = Harness::new();
    // rust: let screen = ScreenInfo::new("container", "Crafting");
    // rust: let book = widgets::key_of(&"recipe_book");
    // rust: let in_book = |n: Narratable, i: usize| n.key(widgets::key_of(&(book, i))).in_group(book);
    // rust: let items = |visible: bool, search_focused: bool| {
    // rust: vec![
    // rust: Narratable::button("", [10.0, 100.0, 20.0, 18.0], true),
    // rust: Narratable::group(visible, [40.0, 40.0, 147.0, 166.0]).key(book),
    // rust: in_book(
    // rust: Narratable::recipe("Oak Planks", false, [51.0, 71.0, 25.0, 25.0]),
    // rust: 0,
    // rust: ),
    // rust: in_book(
    // rust: Narratable::recipe("Torch", true, [76.0, 71.0, 25.0, 25.0]),
    // rust: 1,
    // rust: ),
    // rust: in_book(
    // rust: Narratable::edit_box("Search Items", "to", [65.0, 53.0, 81.0, 14.0])
    // rust: .focused(search_focused),
    // rust: 2,
    // rust: ),
    // rust: in_book(
    // rust: Narratable::cycle(
    // rust: ": Showing All",
    // rust: ": Showing Craftable",
    // rust: [150.0, 52.0, 26.0, 16.0],
    // rust: true,
    // rust: )
    // rust: .hint("Showing All"),
    // rust: 3,
    // rust: ),
    // rust: in_book(Narratable::button("", [10.0, 43.0, 35.0, 27.0], true), 4),
    // rust: ]
}
        // Visible, it is narrated at once, though nothing in it is hovered.
    // rust: h.cursor = (80.0, 80.0);
    // rust: assert_eq!(
    // rust: h.draw(0, &screen, &items(true, false)),
    // rust: ["Crafting. narrator.position.screen(2, 2)"]
    // rust: );
        // A hovered recipe: its result and usage, no tooltip, no position.
    // rust: h.at(3000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw_with(3751, &screen, &items(true, false), Some("Torch")),
    // rust: [
    // rust: "narration.recipe(Torch). narration.button.usage.hovered. narration.recipe.usage.more"
    // rust: ]
    // rust: );
        // The filter reads its tooltip.
    // rust: h.cursor = (160.0, 60.0);
    // rust: h.at(4000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(4751, &screen, &items(true, false)),
    // rust: [
    // rust: "gui.narrate.button(: Showing All). Showing All. narration.cycle_button.usage.hovered(: Showing Craftable)"
    // rust: ]
    // rust: );
        // The focused search box wins over what the mouse is on.
    // rust: h.at(5000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(5751, &screen, &items(true, true)),
    // rust: ["gui.narrate.editBox(Search Items, to)"]
    // rust: );
        // The toggle button before it wins among the hovered.
    // rust: h.cursor = (15.0, 105.0);
    // rust: h.at(6000).mouse_moved();
    // rust: assert_eq!(
    // rust: h.draw(6751, &screen, &items(true, false)),
    // rust: [
    // rust: "gui.narrate.button(). narrator.position.screen(1, 2). narration.button.usage.hovered"
    // rust: ]
    // rust: );
        // Hidden: never narrated, though still counted.
    // rust: h.cursor = (80.0, 80.0);
    // rust: h.at(7000).mouse_moved();
    // rust: let hidden = &items(false, false)[..2];
    // rust: assert_eq!(h.draw(7751, &screen, hidden), ["narrator.screen.usage"]);
    // rust: assert_eq!(
    // rust: h.draw(8000, &ScreenInfo::new("container/2", "Crafting"), hidden),
    // rust: ["Crafting. narrator.screen.usage"]
    // rust: );
}

pub fn the_drawers_hear_which_widget_has_the_focus() void {
}
    // rust: let mut n = ScreenNarrator {
    // rust: clock: Some(0),
    // rust: ..Default::default()
}
    // rust: let rect = [100.0, 40.0, 150.0, 20.0];
    // rust: let tick = |n: &mut ScreenNarrator, frame: u64, at: i64| {
    // rust: widgets::begin_screen(|| ScreenInfo::new("options/Video", "Video"));
    // rust: widgets::narratable(|| Narratable::button("VSync: ON", rect, true));
    // rust: widgets::end_frame(frame);
    // rust: n.clock = Some(at);
    // rust: n.frame_with(true, GUI, (0.0, 0.0), None, &keys)
}
    // rust: tick(&mut n, 50_000, 0);
    // rust: tick(&mut n, 50_001, 16);
    // rust: assert!(!widgets::narration_focused(rect));
    // rust: n.clock = Some(100);
    // rust: n.mouse_pressed((110.0, 50.0), true);
    // rust: tick(&mut n, 50_002, 116);
    // rust: assert!(widgets::narration_focused(rect));
}

pub fn turning_the_narrator_on_with_its_button_says_what_the_click_changed() void {
}
        // The narrator can speak but is off: the screens' narration runs
        // all the same (`shouldRunNarration` is `isActive`).
    // rust: let mut n = ScreenNarrator {
    // rust: clock: Some(0),
    // rust: ..Default::default()
}
    // rust: let mut frames = 40_000;
    // rust: let mut tick = |n: &mut ScreenNarrator, at: i64, label: &str, next: &str, cursor| {
    // rust: widgets::begin_screen(|| ScreenInfo::new("options/Accessibility", "Accessibility"));
    // rust: let (label, next) = (label.to_owned(), next.to_owned());
    // rust: widgets::narratable(|| {
    // rust: Narratable::cycle(label, next, [100.0, 40.0, 150.0, 20.0], true)
    // rust: });
    // rust: widgets::narratable(|| button("Done", 200.0));
    // rust: frames += 1;
    // rust: widgets::end_frame(frames);
    // rust: n.clock = Some(at);
    // rust: n.frame_with(true, GUI, cursor, None, &keys)
}
    // rust: let over = (150.0, 50.0);
        // The first turn switches the frames' recording on.
    // rust: assert!(tick(&mut n, 0, "Narrator: OFF", "Narrates All", over).is_empty());
    // rust: assert!(widgets::narrating());
        // Built and said (saySystemNow drops it while the status is off).
    // rust: assert_eq!(
    // rust: tick(&mut n, 16, "Narrator: OFF", "Narrates All", over),
    // rust: ["Accessibility. narrator.screen.usage"]
    // rust: );
    // rust: n.clock = Some(100);
    // rust: n.mouse_moved();
    // rust: assert_eq!(
    // rust: tick(&mut n, 2017, "Narrator: OFF", "Narrates All", over),
    // rust: [
    // rust: "gui.narrate.button(Narrator: OFF). narrator.position.screen(1, 2). \
    // rust: narration.cycle_button.usage.hovered(Narrates All)"
    // rust: ]
    // rust: );
        // The click turns it on (announced at once by the status update);
        // 200 ms later the screen says only what the click changed.
    // rust: n.clock = Some(3000);
    // rust: n.mouse_pressed(over, true);
    // rust: assert!(
    // rust: tick(
    // rust: &mut n,
    // rust: 3016,
    // rust: "Narrator: Narrates All",
    // rust: "Narrates Chat",
    // rust: over
    // rust: )
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(
    // rust: tick(
    // rust: &mut n,
    // rust: 3201,
    // rust: "Narrator: Narrates All",
    // rust: "Narrates Chat",
    // rust: over
    // rust: ),
    // rust: [
    // rust: "gui.narrate.button(Narrator: Narrates All). narration.component_list.usage. \
    // rust: narration.cycle_button.usage.focused(Narrates Chat)"
    // rust: ]
    // rust: );
        // Without speech nothing is recorded or built.
    // rust: assert!(n.frame_with(false, GUI, over, None, &keys).is_empty());
    // rust: assert!(!widgets::narrating());
}

pub fn the_game_translates_with_the_current_language() void {
}
    // rust: let mut h = Harness::new();
    // rust: h.n.clock = Some(0);
    // rust: h.n.generation += 1;
    // rust: h.n.frame = Narration {
    // rust: screen: Some(ScreenInfo::new("pause", "Game Menu")),
    // rust: items: Vec::new(),
    // rust: tooltip: None,
}
    // rust: assert_eq!(
    // rust: h.n.step(0, GUI, (0.0, 0.0), None, false, &translate),
    // rust: [format!(
    // rust: "Game Menu. {}",
    // rust: translate("narrator.screen.usage", &[])
    // rust: )]
    // rust: );
    // rust: assert_eq!(
    // rust: translate("gui.narrate.button", &["Done"]),
    // rust: crate::lang::tr("gui.narrate.button", &[&"Done"])
    // rust: );
}
}
