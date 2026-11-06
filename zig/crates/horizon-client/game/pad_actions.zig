//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pad_actions
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The controller's side of the buttons screens declare (`widgets::Action`): which pad button does
//! which job, and the glyph on the button while the pad drives. A screen only declares; nothing
//! here names one (docs/controllers.md, "Adding a screen").
// use super::{Game, Screen};
// use horizon_client::{
    // rust: gamepad::Button,
    // rust: hud::HudBatch,
    // rust: lang, pad_glyph,
    // rust: widgets::{self, Action, DeclaredAction, Kind, Target},
}

/// The pad buttons that can do a declared job.
pub const ACTION_BUTTONS: [Button; 3] = [Button::West, Button::East, Button::North];

/// The declared button `button` does on this screen, if any.
pub fn action_for_button(button: Button, declared: *[DeclaredAction]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let find = |action| {
    // rust: declared
    // rust: .iter()
    // rust: .find(|d| d.action == action && d.enabled)
    // rust: .copied()
}
    // rust: let leave = || {
    // rust: find(Action::Back)
    // rust: .or_else(|| find(Action::Cancel))
    // rust: .or_else(|| find(Action::Done))
}
    // rust: match button {
    // rust: Button::West => find(Action::Apply).or_else(|| find(Action::Options)),
    // rust: Button::East => leave().or_else(|| find(Action::Exit)),
        // B is taken by leaving the screen: Y goes to the exit.
    // rust: Button::North => leave().and_then(|_| find(Action::Exit)),
    // rust: _ => None,
}
}

/// Where a glyph `wide` goes on a button: inside its left end (or right), centred on its height.
/// `None` when the button is too small for it or isn't all in the view.
    // rust: fn glyph_at(
    // rust: [x, y, w, h]: [f32; 4],
    // rust: wide: f32,
    // rust: (view_w, view_h): (f32, f32),
    // rust: right: bool,
    // rust: ) -> Option<(f32, f32)> {
pub const INSET: f32 = 4.0;
    // rust: let fits = w >= wide + 2.0 * INSET && h >= pad_glyph::HEIGHT;
    // rust: let shown = x >= 0.0 && y >= 0.0 && x + w <= view_w && y + h <= view_h;
    // rust: (fits && shown).then(|| {
    // rust: let at = if right {
    // rust: x + w - INSET - wide + 2.0
    // rust: } else {
    // rust: x + INSET
}
    // rust: (at, y + ((h - 8.0) / 2.0).floor())
    // rust: })
}

    // rust: impl Game<'_> {
    /// A key row waits for its key: B is Escape, which unbinds; its buttons aren't pressed. A
    /// prompt over the row has the buttons first.
    // rust: pub(super) fn pad_binding(&self) -> bool {
    // rust: !self.prompt_open()
    // rust: && self.screen == Screen::Options
    // rust: && (self.options_waiting_for_key() || self.ui.options.selected_pad_action.is_some())
}

    /// The declared buttons the pad can do now.
pub fn pad_actions(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.pad_binding() {
    // rust: return Vec::new();
}
    // rust: let mut declared = widgets::last_actions(self.key_screen());
        // A split guest's Quit Game does nothing.
    // rust: if self.options.split_guest && self.title.is_some() {
    // rust: declared.retain(|d| d.action != Action::Exit);
}
    // rust: declared
}

    /// The job `button` does here, on the target that does it. `None` while it isn't on screen,
    /// so B still falls back to Escape.
    // rust: pub(super) fn pad_action_target(&self, button: Button) -> Option<(Action, Target)> {
    // rust: let declared = action_for_button(button, &self.pad_actions())?;
    // rust: let [x, y, w, h] = declared.rect;
    // rust: let at = (x + w / 2.0, y + h / 2.0);
        // A button that registers no focus target (a sign's Done) is still pressed.
    // rust: let target = self
    // rust: .pad_targets()
    // rust: .into_iter()
    // rust: .find(|t| {
    // rust: let [x, y, w, h] = t.rect;
    // rust: (x..x + w).contains(&at.0) && (y..y + h).contains(&at.1)
    // rust: })
    // rust: .unwrap_or(Target {
    // rust: rect: declared.rect,
    // rust: kind: Kind::Button,
    // rust: });
    // rust: Some((declared.action, target))
}

    /// Declared buttons show their glyph: the pad drives, and a menu is open. Focus or crosshair.
    // rust: pub(super) fn pad_action_glyphs_on(&self) -> bool {
    // rust: self.pad.in_use
    // rust: && !self.pad.menu.keyboard
    // rust: && self.pad.menu.osk.is_none()
    // rust: && self.pad.menu.pos.is_some()
    // rust: && self.pad_in_menu()
}

    /// Each pad button's glyph on the button it does, A on an exit the focus is already on: this
    /// player's glyphs in this player's view. One that doesn't fit is left out.
pub fn pad_glyphs(self: *Self, view: (f32) void {
}
    // rust: if !self.pad_action_glyphs_on() {
    // rust: return Vec::new();
}
    // rust: let focus = self.pad.menu.focus.filter(|_| self.pad_focus_mode());
    // rust: let (atlas, style) = (&self.gui.atlas, self.ui.options.pad_style);
    // rust: let width = |button: Button| pad_glyph::width(atlas, button, style);
    // rust: let mut glyphs = Vec::new();
        // A on a text field opens the keyboard: at its right end, its text stays in view.
    // rust: if let Some(focus) = focus.filter(|f| f.kind == Kind::Field)
    // rust: && let Some((x, y)) = glyph_at(focus.rect, width(Button::South), view, true)
    // rust: {
    // rust: glyphs.push((Button::South, x, y));
}
    // rust: let declared = self.pad_actions();
    // rust: for button in ACTION_BUTTONS {
    // rust: let Some(d) = action_for_button(button, &declared) else {
    // rust: continue;
}
    // rust: let glyph = if d.action == Action::Exit && focus.is_some_and(|f| f.rect == d.rect) {
    // rust: Button::South
    // rust: } else {
    // rust: button
}
    // rust: if let Some((x, y)) = glyph_at(d.rect, width(glyph), view, false) {
    // rust: glyphs.push((glyph, x, y));
}
}
    // rust: glyphs
}

    // rust: pub(super) fn draw_pad_action_glyphs(&self, batch: &mut HudBatch) {
    // rust: let (atlas, style) = (&self.gui.atlas, self.ui.options.pad_style);
    // rust: for (button, x, y) in self.pad_glyphs((batch.width, batch.height)) {
    // rust: pad_glyph::draw(batch, atlas, button, style, x, y);
}
}

    /// `pad status`: the glyphs drawn now and where: its text's place, what it covers, and its
    /// sprite (none: the label on a key).
    // rust: pub(super) fn pad_glyphs_status(&self) -> Vec<serde_json::Value> {
    // rust: let view = self.gui_scale().map_or((0.0, 0.0), |b| (b.width, b.height));
    // rust: let (atlas, style) = (&self.gui.atlas, self.ui.options.pad_style);
    // rust: self.pad_glyphs(view)
    // rust: .iter()
    // rust: .map(|&(button, x, y)| {
    // rust: serde_json::json!({
    // rust: "button": format!("{button:?}"),
    // rust: "at": [x, y],
    // rust: "rect": pad_glyph::rect(atlas, button, style, x, y),
    // rust: "sprite": pad_glyph::art(atlas, button, style),
    // rust: })
    // rust: })
    // rust: .collect()
}

    /// `pad status`: what this screen declared.
    // rust: pub(super) fn pad_actions_status(&self) -> Vec<serde_json::Value> {
    // rust: self.pad_actions()
    // rust: .iter()
    // rust: .map(|d| {
    // rust: serde_json::json!({
    // rust: "action": format!("{:?}", d.action),
    // rust: "rect": d.rect,
    // rust: "enabled": d.enabled,
    // rust: })
    // rust: })
    // rust: .collect()
}

    /// `pad status`: buttons labelled Done, Back or Cancel that didn't declare their job.
    // rust: pub(super) fn pad_undeclared_buttons(&self) -> Vec<String> {
    // rust: let names = [
    // rust: ("gui.done", "Done"),
    // rust: ("gui.back", "Back"),
    // rust: ("gui.cancel", "Cancel"),
    // rust: ]
    // rust: .map(|(key, fallback)| lang::get_or(key, fallback));
    // rust: let declared = widgets::last_actions(self.key_screen());
    // rust: widgets::last_labelled()
    // rust: .into_iter()
    // rust: .filter(|w| names.contains(&w.label))
    // rust: .filter(|w| !declared.iter().any(|d| d.rect == [w.x, w.y, w.w, w.h]))
    // rust: .map(|w| w.label)
    // rust: .collect()
}
}

    // rust: mod tests {
//     use super::*;

pub fn declared(action: Action, enabled: bool) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DeclaredAction {
    // rust: action,
    // rust: rect: [0.0, 0.0, 10.0, 10.0],
    // rust: enabled,
}
}

pub fn does(button: Button, on: *[DeclaredAction]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: action_for_button(button, on).map(|d| d.action)
}

pub fn b_leaves_the_screen_back_first() void {
}
    // rust: let on = [
    // rust: declared(Action::Done, true),
    // rust: declared(Action::Cancel, true),
    // rust: declared(Action::Back, true),
    // rust: ];
    // rust: assert_eq!(does(Button::East, &on), Some(Action::Back));
    // rust: assert_eq!(does(Button::East, &on[..2]), Some(Action::Cancel));
    // rust: assert_eq!(does(Button::East, &on[..1]), Some(Action::Done));
}

pub fn a_disabled_button_does_nothing() void {
}
    // rust: let on = [
    // rust: declared(Action::Apply, false),
    // rust: declared(Action::Done, false),
    // rust: ];
    // rust: assert_eq!(does(Button::West, &on), None);
    // rust: assert_eq!(does(Button::East, &on), None);
}

pub fn x_applies_or_opens_the_options() void {
}
    // rust: let on = [
    // rust: declared(Action::Options, true),
    // rust: declared(Action::Apply, true),
    // rust: ];
    // rust: assert_eq!(does(Button::West, &on), Some(Action::Apply));
    // rust: assert_eq!(does(Button::West, &on[..1]), Some(Action::Options));
}

pub fn the_exit_is_b_with_nothing_to_leave_by_else_y() void {
}
    // rust: let title = [declared(Action::Exit, true)];
    // rust: assert_eq!(does(Button::East, &title), Some(Action::Exit));
    // rust: assert_eq!(does(Button::North, &title), None);
    // rust: let pause = [declared(Action::Back, true), declared(Action::Exit, true)];
    // rust: assert_eq!(does(Button::East, &pause), Some(Action::Back));
    // rust: assert_eq!(does(Button::North, &pause), Some(Action::Exit));
}

pub fn a_face_glyph_on_a_button_stays_clear_of_its_label() void {
}
    // rust: let (x, y) = glyph_at(
    // rust: [10.0, 20.0, 150.0, 20.0],
    // rust: pad_glyph::FACE_WIDTH,
    // rust: (640.0, 480.0),
    // rust: false,
    // rust: )
    // rust: .unwrap();
        // Vertically inside the button, ending before the label's left (its x + 2 + room).
    // rust: assert_eq!((y - 2.0, y - 2.0 + pad_glyph::HEIGHT), (24.0, 36.0));
    // rust: widgets::set_action_glyphs(true);
    // rust: let label_left = 10.0 + 2.0 + widgets::action_glyph_room();
    // rust: widgets::set_action_glyphs(false);
    // rust: assert!(x - 1.0 + pad_glyph::FACE_WIDTH < label_left);
}

pub fn a_glyph_goes_on_a_button_it_fits_in_the_view() void {
}
    // rust: let view = (320.0, 240.0);
    // rust: let button = [10.0, 20.0, 150.0, 20.0];
    // rust: assert_eq!(glyph_at(button, 10.0, view, false), Some((14.0, 26.0)));
        // A text field's is at its right end.
    // rust: assert_eq!(glyph_at(button, 10.0, view, true), Some((148.0, 26.0)));
        // Too narrow, too short, running off a small split view.
    // rust: assert_eq!(glyph_at([10.0, 20.0, 15.0, 20.0], 10.0, view, false), None);
    // rust: assert_eq!(glyph_at([10.0, 20.0, 150.0, 8.0], 10.0, view, false), None);
        // Art as tall as the row fits; a row any shorter would clip it.
    // rust: assert_eq!(
    // rust: glyph_at([10.0, 20.0, 150.0, 12.0], 12.0, view, false),
    // rust: Some((14.0, 22.0))
    // rust: );
    // rust: assert_eq!(glyph_at([10.0, 20.0, 150.0, 11.0], 12.0, view, false), None);
    // rust: assert_eq!(glyph_at(button, 10.0, (120.0, 240.0), false), None);
}

pub fn a_screen_that_declares_nothing_keeps_its_buttons() void {
}
    // rust: for button in ACTION_BUTTONS {
    // rust: assert_eq!(does(button, &[]), None);
}
}
}
