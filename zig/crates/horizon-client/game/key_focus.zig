//! Transpiled from Horizon Rust crate
//! Module: horizon-client_key_focus
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla's keyboard focus navigation in Horizon's menus
//! (`Screen.keyPressed`, `ContainerEventHandler.nextFocusPath`, 26.3): Tab
//! and Shift+Tab step the focus in tab order, the arrows move it the way they
//! point, Enter, Space and keypad Enter press the focused widget
//! (`AbstractButton.keyPressed`), and a focused slider's left and right move
//! its value once Enter (or Tab) let them (`AbstractSliderButton.keyPressed`).
//! A focused text field is the screen's focus: those keys type into it.
//!
//! The focus lands on what the controller's focus mode reaches: the targets
//! each screen registers (`widgets::target_as`, docs/controllers.md). This
//! module is the pure part: which key does what, the tab order, the slider
//! rules. `pad_menu.rs` applies it in the game (it shares the controller's
//! focus), `startup_menu.rs` on the title shown while resources load.
// use horizon_client::{
    // rust: gamepad::{self, Button, Rect},
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: widgets::{self, Kind, Target},
}
// use winit::keyboard::KeyCode;

/// A navigation key, as `Screen.keyPressed` and the widgets read it.
    // rust: pub(super) enum Nav {
    /// Tab (forward) or Shift+Tab (`FocusNavigationEvent.TabNavigation`).
    // rust: Tab { forward: bool },
    /// An arrow (`ArrowNavigation`), as the D-pad direction it steps.
    // rust: Arrow(Button),
    /// Enter, Space or keypad Enter (`InputWithModifiers.isSelection`).
    // rust: Select,
}

/// The navigation a key press is, if any.
    // rust: pub(super) fn nav_of(key: KeyCode, shift: bool) -> Option<Nav> {
    // rust: Some(match key {
    // rust: KeyCode::Tab => Nav::Tab { forward: !shift },
    // rust: KeyCode::ArrowUp => Nav::Arrow(Button::DPadUp),
    // rust: KeyCode::ArrowDown => Nav::Arrow(Button::DPadDown),
    // rust: KeyCode::ArrowLeft => Nav::Arrow(Button::DPadLeft),
    // rust: KeyCode::ArrowRight => Nav::Arrow(Button::DPadRight),
    // rust: KeyCode::Enter | KeyCode::NumpadEnter | KeyCode::Space => Nav::Select,
    // rust: _ => return None,
    // rust: })
}

/// What a navigation key does on the screen as it is.
    // rust: pub(super) enum Act {
    /// The screen takes the key itself: a text field's caret, Enter on a
    /// list whose screen joins its selected row, nothing focused.
    // rust: Pass,
    /// Focus `targets[i]` (Tab, or an arrow from no focus).
    // rust: Focus(usize),
    /// Move the focus that way (the controller's step, which scrolls lists).
    // rust: Step(Button),
    /// Press the focused widget (a click on it).
    // rust: Press,
    /// Enter on a focused slider: whether the arrows change its value flips.
    // rust: ToggleSlider,
    /// Left (-1) or right (1) on a slider that can change: one step.
    // rust: Nudge(f32),
}

/// Where the screen is: what `act` reads besides the focus.
    // rust: pub(super) struct Context {
    /// The focused slider's arrows change its value (`canChangeValue`).
    // rust: pub slider_edit: bool,
    /// A text field has the keyboard (a click focused it): with nothing
    /// focused, its caret takes left and right, and Space and Enter belong to
    /// it rather than to the widget the keyboard focus was left on.
    // rust: pub typing: bool,
    /// The screen joins its list's selected row on Enter itself
    /// (`WorldListEntry.keyPressed`): a focused row passes Enter on.
    // rust: pub rows_take_enter: bool,
    /// The GUI size: an arrow from no focus starts at the screen's edge.
    // rust: pub gui: (f32, f32),
}

pub fn horizontal(button: Button) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(button, Button::DPadLeft | Button::DPadRight)
}

/// What `nav` does, `focus` being the focused target (the one a click
/// focused counts) among `targets`.
    // rust: pub(super) fn act(nav: Nav, focus: Option<Target>, targets: &[Target], ctx: Context) -> Act {
    // rust: match (nav, focus) {
    // rust: (Nav::Tab { forward }, _) => {
    // rust: tab_step(targets, focus.map(|t| t.rect), forward).map_or(Act::Pass, Act::Focus)
}
        // EditBox.keyPressed takes left and right for its caret.
    // rust: (
    // rust: Nav::Arrow(b),
    // rust: Some(Target {
    // rust: kind: Kind::Field, ..
    // rust: }),
    // rust: ) if horizontal(b) => Act::Pass,
    // rust: (Nav::Arrow(b), None) if horizontal(b) && ctx.typing => Act::Pass,
    // rust: (
    // rust: Nav::Arrow(b),
    // rust: Some(Target {
    // rust: kind: Kind::Slider { .. },
    // rust: ..
    // rust: }),
    // rust: ) if horizontal(b) && ctx.slider_edit => {
    // rust: Act::Nudge(if b == Button::DPadLeft { -1.0 } else { 1.0 })
}
    // rust: (Nav::Arrow(b), Some(_)) => Act::Step(b),
        // No focus: from the screen's edge behind the arrow
        // (`getBorderForArrowNavigation(direction.getOpposite())`).
    // rust: (Nav::Arrow(b), None) => {
    // rust: let rects: Vec<Rect> = targets.iter().map(|t| t.rect).collect();
    // rust: gamepad::focus_step_rect(edge(ctx.gui, b), b, &rects).map_or(Act::Pass, Act::Focus)
}
        // A focused `EditBox` is the screen's focus (`Screen.setFocused`), so
        // Space and Enter are the box's `charTyped` (a space, say) — never a
        // press of the widget the keyboard's focus was left on from before
        // (`AbstractButton.keyPressed` only hears the focused widget).
    // rust: (Nav::Select, _) if ctx.typing => Act::Pass,
    // rust: (Nav::Select, None) => Act::Pass,
    // rust: (Nav::Select, Some(t)) => match t.kind {
    // rust: Kind::Field => Act::Pass,
    // rust: Kind::Row if ctx.rows_take_enter => Act::Pass,
    // rust: Kind::Slider { .. } => Act::ToggleSlider,
    // rust: _ => Act::Press,
    // rust: },
}
}

/// The strip just outside the screen on the side an arrow comes from.
pub fn edge() void {
}
    // rust: match button {
    // rust: Button::DPadUp => [0.0, h, w, 1.0],
    // rust: Button::DPadLeft => [w, 0.0, 1.0, h],
    // rust: Button::DPadRight => [-1.0, 0.0, 1.0, h],
    // rust: _ => [0.0, -1.0, w, 1.0],
}
}

/// Whether the screen still gets the key after `act`. `Screen.keyPressed`
/// moves the focus on Tab or an arrow and returns false, so a container
/// screen goes on to `checkHotbarKeyPressed` (`AbstractContainerScreen
/// .keyPressed`): Tab bound to the off hand both moves the focus and swaps.
/// Horizon's other screens handle these keys themselves, so only containers
/// pass them on.
    // rust: pub(super) fn passes_on(act: Act, container: bool) -> bool {
    // rust: container && matches!(act, Act::Focus(_) | Act::Step(_))
}

/// `AbstractSliderButton.setFocused`: the arrows change a slider's value
/// when the focus came from the mouse or Tab, not from an arrow.
    // rust: pub(super) fn slider_edit_on_focus(nav: Nav) -> bool {
    // rust: matches!(nav, Nav::Tab { .. })
}

pub fn same(a: Rect, b: Rect) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a.iter().zip(b).all(|(p, q)| (p - q).abs() < 0.5)
}

/// The tab order (`children()` sorted by `getTabOrderGroup`): the order
/// vanilla added the widgets in, which its layouts do row by row. Horizon
/// has no widget tree (a screen registers buttons and other targets
/// separately), so this is reading order: top to bottom, then left to right,
/// ties in the order they were drawn.
    // rust: pub(super) fn tab_order(targets: &[Target]) -> Vec<usize> {
    // rust: let mut order: Vec<usize> = (0..targets.len()).collect();
    // rust: let key = |t: &Target| (t.rect[1].round() as i32, t.rect[0].round() as i32);
    // rust: order.sort_by_key(|&i| key(&targets[i]));
    // rust: order
}

/// Tab or Shift+Tab from `from` (none focused: from the start or the end),
/// wrapping as `Screen.keyPressed` does (no next one: `clearFocus`, then
/// again). A list's rows are one stop, as vanilla's list is one widget: Tab
/// enters it on its first row (Shift+Tab on its last) and leaves it at once.
    // rust: pub(super) fn tab_step(targets: &[Target], from: Option<Rect>, forward: bool) -> Option<usize> {
    // The stops in tab order: a run of rows is one.
    // rust: let mut stops: Vec<Vec<usize>> = Vec::new();
    // rust: for i in tab_order(targets) {
    // rust: let row = targets[i].kind == Kind::Row;
    // rust: match stops.last_mut() {
    // rust: Some(stop) if row && targets[stop[0]].kind == Kind::Row => stop.push(i),
    // rust: _ => stops.push(vec![i]),
}
}
    // rust: if stops.is_empty() {
    // rust: return None;
}
    // rust: let at = from.and_then(|r| {
    // rust: stops
    // rust: .iter()
    // rust: .position(|s| s.iter().any(|&i| same(targets[i].rect, r)))
    // rust: });
    // rust: let n = stops.len();
    // rust: let next = match at {
    // rust: Some(k) if forward => (k + 1) % n,
    // rust: Some(k) => (k + n - 1) % n,
    // rust: None if forward => 0,
    // rust: None => n - 1,
}
    // rust: let stop = &stops[next];
    // rust: Some(if forward {
    // rust: stop[0]
    // rust: } else {
    // rust: stop[stop.len() - 1]
    // rust: })
}

/// What the last drawn frame's screen can focus: its enabled buttons and
/// every target it registered (sliders, fields, rows, slots...).
    // rust: pub(super) fn drawn_targets() -> Vec<Target> {
    // rust: let mut targets: Vec<Target> = widgets::last()
    // rust: .iter()
    // rust: .filter(|w| w.enabled)
    // rust: .map(|w| Target {
    // rust: rect: [w.x, w.y, w.w, w.h],
    // rust: kind: Kind::Button,
    // rust: })
    // rust: .collect();
    // rust: for t in widgets::last_targets() {
        // A button can be both a labelled button and a target.
    // rust: if let Some(same) = targets.iter_mut().find(|o| o.rect == t.rect) {
    // rust: same.kind = t.kind;
    // rust: } else {
    // rust: targets.push(t);
}
}
    // rust: targets
}

/// The targets inside the GUI (`gui`: its size in GUI pixels).
    // rust: pub(super) fn on_screen(mut targets: Vec<Target>, (w, h): (f32, f32)) -> Vec<Target> {
    // rust: let (w, h) = (w + 0.5, h + 0.5);
    // rust: targets.retain(|t| {
    // rust: let [x, y, tw, th] = t.rect;
    // rust: x >= -0.5 && y >= -0.5 && x + tw <= w && y + th <= h
    // rust: });
    // rust: targets
}

/// Which targets the keyboard reaches: vanilla focuses widgets only, never
/// an inventory's slots, and the creative and recipe-book tabs aren't the
/// screen's widgets either (`inventory`).
    // rust: pub(super) fn keyboard_targets(targets: Vec<Target>, inventory: bool) -> Vec<Target> {
    // rust: targets
    // rust: .into_iter()
    // rust: .filter(|t| match t.kind {
    // rust: Kind::Slot => false,
    // rust: Kind::Tab(_) => !inventory,
    // rust: _ => true,
    // rust: })
    // rust: .collect()
}

/// The focus in a newly drawn frame: the same widget, or one the screen
/// moved a little (a list scrolled); else the screen changed and the focus
/// starts again on the first widget (`Screen.setInitialFocus` after a key).
    // rust: pub(super) fn follow(focus: Target, targets: &[Target]) -> Option<Target> {
    // rust: let rects: Vec<Rect> = targets.iter().map(|t| t.rect).collect();
    // rust: gamepad::refind(focus.rect, &rects, 12.0)
    // rust: .or_else(|| tab_step(targets, None, true))
    // rust: .map(|i| targets[i])
}

/// Where a click focuses a text field with its caret at the end of the
/// text, as Tab leaves it (`EditBox.setFocused` keeps the cursor, which
/// `setValue` put at the end): the box's right end.
    // rust: pub(super) fn field_click(rect: Rect) -> (f32, f32) {
    // rust: let [x, y, w, h] = rect;
    // rust: (x + w - 2.0, y + h / 2.0)
}

/// Vanilla's focus look for what has no highlighted sprite: the white
/// one-pixel outline of a focused list's selection
/// (`AbstractSelectionList`) and of a focused `EditBox`. Buttons, sliders
/// and tabs show their highlighted sprite, drawn under the hidden pointer.
    // rust: pub(super) fn draw_outline(atlas: &HudAtlas, batch: &mut HudBatch, focus: Target) {
    // rust: let [x, y, w, h] = focus.rect;
    // rust: if matches!(focus.kind, Kind::Row | Kind::Field) {
    // rust: let white = rgba(255, 255, 255, 255);
    // rust: batch.fill(atlas, x, y, w, 1.0, white);
    // rust: batch.fill(atlas, x, y + h - 1.0, w, 1.0, white);
    // rust: batch.fill(atlas, x, y, 1.0, h, white);
    // rust: batch.fill(atlas, x + w - 1.0, y, 1.0, h, white);
}
}

    // rust: mod tests {
//     use super::*;

pub fn button(x: f32, y: f32) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Target {
    // rust: rect: [x, y, 98.0, 20.0],
    // rust: kind: Kind::Button,
}
}
pub fn row(y: f32) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Target {
    // rust: rect: [100.0, y, 220.0, 36.0],
    // rust: kind: Kind::Row,
}
}
pub fn slider() T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Target {
    // rust: rect: [0.0, 0.0, 150.0, 20.0],
    // rust: kind: Kind::Slider {
    // rust: value: 0.5,
    // rust: track: [4.0, 142.0],
    // rust: },
}
}
pub fn field() T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Target {
    // rust: rect: [0.0, 0.0, 200.0, 20.0],
    // rust: kind: Kind::Field,
}
}
    // rust: const CTX: Context = Context {
    // rust: slider_edit: false,
    // rust: typing: false,
    // rust: rows_take_enter: false,
    // rust: gui: (427.0, 240.0),
}

pub fn keys_map_to_vanillas_navigation() void {
}
    // rust: assert_eq!(
    // rust: nav_of(KeyCode::Tab, false),
    // rust: Some(Nav::Tab { forward: true })
    // rust: );
    // rust: assert_eq!(
    // rust: nav_of(KeyCode::Tab, true),
    // rust: Some(Nav::Tab { forward: false })
    // rust: );
    // rust: assert_eq!(
    // rust: nav_of(KeyCode::ArrowUp, false),
    // rust: Some(Nav::Arrow(Button::DPadUp))
    // rust: );
    // rust: assert_eq!(
    // rust: nav_of(KeyCode::ArrowRight, true),
    // rust: Some(Nav::Arrow(Button::DPadRight))
    // rust: );
        // isSelection: Enter (40), Space (44), keypad Enter (88).
    // rust: for key in [KeyCode::Enter, KeyCode::Space, KeyCode::NumpadEnter] {
    // rust: assert_eq!(nav_of(key, false), Some(Nav::Select));
}
    // rust: assert_eq!(nav_of(KeyCode::KeyA, false), None);
    // rust: assert_eq!(nav_of(KeyCode::Escape, false), None);
}

    /// Tab bound to key.swapOffhand in an inventory: the focus moves and the
    /// screen still checks its hotbar keys; a press stays the widget's.
pub fn containers_still_get_tab_and_arrows_after_the_focus_moves() void {
}
    // rust: assert!(passes_on(Act::Focus(0), true));
    // rust: assert!(passes_on(Act::Step(Button::DPadDown), true));
    // rust: assert!(!passes_on(Act::Press, true));
    // rust: assert!(!passes_on(Act::ToggleSlider, true));
    // rust: assert!(!passes_on(Act::Nudge(1.0), true));
    // rust: assert!(!passes_on(Act::Focus(0), false));
    // rust: assert!(!passes_on(Act::Step(Button::DPadDown), false));
}

    /// The title screen's rows (TitleScreen.init's add order).
pub fn tab_order_reads_rows_top_to_bottom_then_left_to_right() void {
}
    // rust: let targets = [
    // rust: button(164.0, 108.0), // Options
    // rust: button(266.0, 108.0), // Quit
    // rust: button(164.0, 60.0),  // Singleplayer
    // rust: Target {
    // rust: rect: [140.0, 84.0, 20.0, 20.0],
    // rust: kind: Kind::Button,
    // rust: }, // Friends
    // rust: button(164.0, 84.0),  // Realms
    // rust: ];
    // rust: assert_eq!(tab_order(&targets), vec![2, 3, 4, 0, 1]);
}

pub fn tab_wraps_both_ways_and_starts_at_either_end() void {
}
    // rust: let targets = [button(0.0, 0.0), button(0.0, 30.0), button(0.0, 60.0)];
    // rust: assert_eq!(tab_step(&targets, None, true), Some(0));
    // rust: assert_eq!(tab_step(&targets, None, false), Some(2));
    // rust: assert_eq!(tab_step(&targets, Some(targets[0].rect), true), Some(1));
    // rust: assert_eq!(tab_step(&targets, Some(targets[2].rect), true), Some(0));
    // rust: assert_eq!(tab_step(&targets, Some(targets[0].rect), false), Some(2));
        // A rect no longer there: from the start.
    // rust: assert_eq!(tab_step(&targets, Some([9.0; 4]), true), Some(0));
    // rust: assert_eq!(tab_step(&[], None, true), None);
}

pub fn a_lists_rows_are_one_tab_stop() void {
}
    // rust: let search = field();
    // rust: let targets = [search, row(40.0), row(76.0), row(112.0), button(0.0, 200.0)];
        // Into the list on its first row, then out of it.
    // rust: assert_eq!(tab_step(&targets, Some(search.rect), true), Some(1));
    // rust: assert_eq!(tab_step(&targets, Some(targets[2].rect), true), Some(4));
        // Backwards: in on the last row, out to the search box.
    // rust: assert_eq!(tab_step(&targets, Some(targets[4].rect), false), Some(3));
    // rust: assert_eq!(tab_step(&targets, Some(targets[1].rect), false), Some(0));
}

pub fn select_presses_buttons_and_toggles_sliders() void {
}
    // rust: let b = button(0.0, 0.0);
    // rust: assert_eq!(act(Nav::Select, Some(b), &[b], CTX), Act::Press);
    // rust: let s = slider();
    // rust: assert_eq!(act(Nav::Select, Some(s), &[s], CTX), Act::ToggleSlider);
        // Nothing focused: the screen's own Enter (a world list joins).
    // rust: assert_eq!(act(Nav::Select, None, &[b], CTX), Act::Pass);
    // rust: let f = field();
    // rust: assert_eq!(act(Nav::Select, Some(f), &[f], CTX), Act::Pass);
    // rust: let r = row(40.0);
    // rust: assert_eq!(act(Nav::Select, Some(r), &[r], CTX), Act::Press);
    // rust: let joins = Context {
    // rust: rows_take_enter: true,
    // rust: ..CTX
}
    // rust: assert_eq!(act(Nav::Select, Some(r), &[r], joins), Act::Pass);
}

    /// A focused text field is the screen's focus: Space types a space into
    /// it, and neither it nor Enter presses the widget the keyboard's focus
    /// was left on (the Create World tab a keyboard player tabbed to, say).
pub fn a_focused_text_field_keeps_space_and_enter_for_typing() void {
}
    // rust: let b = button(0.0, 40.0);
    // rust: let f = field();
    // rust: let targets = [f, b];
    // rust: let typing = Context {
    // rust: typing: true,
    // rust: ..CTX
}
    // rust: assert_eq!(act(Nav::Select, Some(b), &targets, typing), Act::Pass);
    // rust: assert_eq!(act(Nav::Select, Some(f), &targets, typing), Act::Pass);
        // The same widget still takes them when no field has the focus.
    // rust: assert_eq!(act(Nav::Select, Some(b), &targets, CTX), Act::Press);
}

    /// AbstractSliderButton.keyPressed and setFocused.
pub fn slider_arrows_change_the_value_only_once_allowed() void {
}
    // rust: let s = slider();
    // rust: let left = Nav::Arrow(Button::DPadLeft);
    // rust: let right = Nav::Arrow(Button::DPadRight);
    // rust: assert_eq!(
    // rust: act(left, Some(s), &[s], CTX),
    // rust: Act::Step(Button::DPadLeft),
    // rust: "focused by an arrow: left moves the focus"
    // rust: );
    // rust: let edit = Context {
    // rust: slider_edit: true,
    // rust: ..CTX
}
    // rust: assert_eq!(act(left, Some(s), &[s], edit), Act::Nudge(-1.0));
    // rust: assert_eq!(act(right, Some(s), &[s], edit), Act::Nudge(1.0));
        // Up and down always move the focus.
    // rust: assert_eq!(
    // rust: act(Nav::Arrow(Button::DPadDown), Some(s), &[s], edit),
    // rust: Act::Step(Button::DPadDown)
    // rust: );
    // rust: assert!(slider_edit_on_focus(Nav::Tab { forward: true }));
    // rust: assert!(slider_edit_on_focus(Nav::Tab { forward: false }));
    // rust: assert!(!slider_edit_on_focus(Nav::Arrow(Button::DPadDown)));
}

    /// EditBox.keyPressed consumes left and right, not Tab, up or down.
pub fn a_text_field_keeps_left_and_right() void {
}
    // rust: let f = field();
    // rust: let b = button(0.0, 40.0);
    // rust: let targets = [f, b];
    // rust: for b in [Button::DPadLeft, Button::DPadRight] {
    // rust: assert_eq!(act(Nav::Arrow(b), Some(f), &targets, CTX), Act::Pass);
}
    // rust: assert_eq!(
    // rust: act(Nav::Arrow(Button::DPadDown), Some(f), &targets, CTX),
    // rust: Act::Step(Button::DPadDown)
    // rust: );
    // rust: assert_eq!(
    // rust: act(Nav::Tab { forward: true }, Some(f), &targets, CTX),
    // rust: Act::Focus(1)
    // rust: );
        // A field a click focused (no keyboard focus) keeps them too.
    // rust: let typing = Context {
    // rust: typing: true,
    // rust: ..CTX
}
    // rust: assert_eq!(
    // rust: act(Nav::Arrow(Button::DPadLeft), None, &targets, typing),
    // rust: Act::Pass
    // rust: );
}

pub fn an_arrow_from_no_focus_starts_at_the_screens_edge() void {
}
    // rust: let targets = [
    // rust: button(164.0, 60.0),
    // rust: button(164.0, 84.0),
    // rust: button(10.0, 200.0),
    // rust: ];
    // rust: let down = act(Nav::Arrow(Button::DPadDown), None, &targets, CTX);
    // rust: assert_eq!(down, Act::Focus(0));
    // rust: let up = act(Nav::Arrow(Button::DPadUp), None, &targets, CTX);
    // rust: assert_eq!(up, Act::Focus(2));
    // rust: let right = act(Nav::Arrow(Button::DPadRight), None, &targets, CTX);
    // rust: assert_eq!(right, Act::Focus(2));
}

pub fn the_keyboard_skips_slots_and_inventory_tabs() void {
}
    // rust: let slot = Target {
    // rust: rect: [0.0, 0.0, 16.0, 16.0],
    // rust: kind: Kind::Slot,
}
    // rust: let tab = Target {
    // rust: rect: [0.0, 0.0, 26.0, 32.0],
    // rust: kind: Kind::Tab(false),
}
    // rust: let b = button(0.0, 0.0);
    // rust: assert_eq!(keyboard_targets(vec![slot, tab, b], true), vec![b]);
    // rust: assert_eq!(keyboard_targets(vec![slot, tab, b], false), vec![tab, b]);
}

pub fn focus_follows_its_widget_or_starts_again() void {
}
    // rust: let a = button(0.0, 0.0);
    // rust: let moved = button(0.0, 4.0);
    // rust: let far = button(200.0, 100.0);
    // rust: assert_eq!(follow(a, &[far, moved]), Some(moved));
        // Gone (another screen): the first in tab order.
    // rust: let first = button(0.0, 50.0);
    // rust: assert_eq!(follow(a, &[far, first]), Some(first));
    // rust: assert_eq!(follow(a, &[]), None);
}

pub fn a_field_is_clicked_at_its_end() void {
}
    // rust: assert_eq!(field_click([10.0, 20.0, 200.0, 20.0]), (208.0, 30.0));
}
}
