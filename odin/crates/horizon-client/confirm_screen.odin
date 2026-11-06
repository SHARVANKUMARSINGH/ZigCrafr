//! Transpiled from Horizon Rust crate
package horizon_client_confirm_screen

import "core:fmt"
import "core:mem"
import "core:math"

// `ConfirmScreen`: a title, a message wrapped to `width - 50` (15 lines at
// most) and two 150-wide buttons 4 apart and 16 below it, the whole column
// centred; Escape answers no.
// use crate::{
    // rust: font::Font,
    // rust: hud::{HudAtlas, HudBatch},
    // rust: text::Text,
    // rust: ui,
}

Confirm :: struct {
    // Each line and where it is drawn.
    lines: Vec<(Text,
    // The yes and no buttons' corners.
    buttons: [(f32,
    focus: Maybe(uint),
    // `declare_no` was called.
    declares_no: bool,
}
    // rust: impl Confirm {
new :: proc(font: ^Font, size: (f32) {
}
    // rust: let Choice { lines, buttons, .. } = Choice::new(font, size, title, message, 2, 150.0);
    // rust: Self {
    // rust: lines,
    // rust: buttons: [buttons[0], buttons[1]],
    // rust: focus: None,
    // rust: declares_no: false,
}
}
    // Tab cycles focus between yes (0) and no (1).
tab :: proc(self: ^Self, reverse: bool) {
}
    // rust: self.focus = match self.focus {
    // rust: Some(0) => Some(1),
    // rust: Some(1) => Some(0),
    // rust: None => Some(if reverse { 1 } else { 0 }),
    // rust: _ => Some(0),
}
}
    // Left or right arrow key focuses yes or no.
arrow :: proc(self: ^Self, left: bool) {
}
    // rust: self.focus = Some(if left { 0 } else { 1 });
}
    // The answer of the currently focused button.
answer :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.focus {
    // rust: Some(0) => Some(true),
    // rust: Some(1) => Some(false),
    // rust: _ => None,
}
}
    // The answer a click at `cursor` gives: true for yes, false for no.
answer_at :: proc(self: ^Self, cursor: (f32) {
}
    // rust: let [yes, no] = self.buttons;
    // rust: let on = |(x, y): (f32, f32)| ui::hovered(cursor, x, y, 150.0, 20.0);
    // rust: if on(yes) {
    // rust: Some(true)
    // rust: } else if on(no) {
    // rust: Some(false)
    // rust: } else {
    // rust: None
}
}
    // The lines and the buttons (yes first), over whatever is behind.
    // rust: pub fn draw(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: labels: [&Text; 2],
    // rust: ) {
    // rust: self.draw_active(batch, atlas, cursor, labels, true);
}
    // The second button answers no, as Escape does (`widgets::Action`), once drawn.
declare_no :: proc(self: ^Self) {
}
    // rust: self.declares_no = true;
}
    // `draw` with the buttons greyed out while `setDelay` runs (`active` false).
    // rust: pub fn draw_active(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: labels: [&Text; 2],
    // rust: active: bool,
    // rust: ) {
    // rust: for (line, x, y) in &self.lines {
    // rust: batch.text_styled(atlas, line, *x, *y, u32::MAX, true);
}
    // rust: for (i, ((bx, by), label)) in self.buttons.into_iter().zip(labels).enumerate() {
    // rust: let is_focused = self.focus == Some(i);
    // rust: let hover = active && (ui::hovered(cursor, bx, by, 150.0, 20.0) || is_focused);
    // rust: if self.declares_no && i == 1 {
    // rust: let action = crate::widgets::Action::Cancel;
    // rust: ui::action_button(
    // rust: batch, atlas, action, bx, by, 150.0, 20.0, label, active, hover,
    // rust: );
    // rust: } else {
    // rust: ui::button(batch, atlas, bx, by, 150.0, 20.0, label, active, hover);
}
}
}
}

// `ConfirmScreen` with a row of `count` buttons `width` wide, 4 apart: `ConfirmLinkScreen`'s
// yes, copy and no are three of 100. `Confirm` is its two of 150.
Choice :: struct {
    // Each line and where it is drawn.
    lines: Vec<(Text,
    // The buttons' corners, left to right.
    buttons: Vec<(f32,
    width: f32,
    focus: Maybe(uint),
    // The button `declare_no` named.
    no_button: Maybe(uint),
}
    // rust: impl Choice {
    // rust: pub fn new(
    // rust: font: &Font,
    // rust: (w, h): (f32, f32),
    // rust: title: &Text,
    // rust: message: &Text,
    // rust: count: usize,
    // rust: width: f32,
    // rust: ) -> Self {
    // rust: let message: Vec<Text> = font
    // rust: .split_lines(message, w - 50.0)
    // rust: .into_iter()
    // rust: .map(|(line, _)| line)
    // rust: .take(15)
    // rust: .collect();
    // rust: let tw = font.width_text(title);
    // rust: let mw = message
    // rust: .iter()
    // rust: .map(|l| font.width_text(l))
    // rust: .fold(0.0, f32::max);
    // rust: let mh = 9.0 * message.len() as f32;
    // rust: let row = width * count as f32 + 4.0 * count.saturating_sub(1) as f32;
    // rust: let col = tw.max(mw).max(row);
    // rust: let total = 9.0 + 8.0 + mh + 8.0 + 36.0;
    // rust: let (lx, ly) = (((w - col) / 2.0).trunc(), ((h - total) / 2.0).trunc());
    // rust: let cell = |cw: f32| lx + ((col - cw) / 2.0).trunc();
    // rust: let mid = cell(mw) + (mw / 2.0).trunc();
    // rust: let mut lines = vec![(title.clone(), cell(tw), ly)];
    // rust: for (i, line) in message.into_iter().enumerate() {
    // rust: let x = mid - (font.width_text(&line) / 2.0).trunc();
    // rust: lines.push((line, x, ly + 17.0 + 9.0 * i as f32));
}
    // rust: let (bx, by) = (cell(row), ly + 9.0 + 8.0 + mh + 8.0 + 16.0);
    // rust: Self {
    // rust: lines,
    // rust: buttons: (0..count)
    // rust: .map(|i| (bx + (width + 4.0) * i as f32, by))
    // rust: .collect(),
    // rust: width,
    // rust: focus: None,
    // rust: no_button: None,
}
}
    // Tab cycles focus across the buttons.
tab :: proc(self: ^Self, reverse: bool) {
}
    // rust: let count = self.buttons.len();
    // rust: if count == 0 {
    // rust: return;
}
    // rust: self.focus = match self.focus {
    // rust: Some(cur) => {
    // rust: if reverse {
    // rust: Some(if cur == 0 { count - 1 } else { cur - 1 })
    // rust: } else {
    // rust: Some((cur + 1) % count)
}
}
    // rust: None => Some(if reverse { count - 1 } else { 0 }),
}
}
    // Left or right arrow key moves focus.
arrow :: proc(self: ^Self, left: bool) {
}
    // rust: let count = self.buttons.len();
    // rust: if count == 0 {
    // rust: return;
}
    // rust: self.focus = match self.focus {
    // rust: Some(cur) => {
    // rust: if left {
    // rust: Some(cur.saturating_sub(1))
    // rust: } else {
    // rust: Some((cur + 1).min(count - 1))
}
}
    // rust: None => Some(if left { 0 } else { count - 1 }),
}
}
    // The index of the currently focused button.
pressed :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.focus
}
    // The button a click at `cursor` hits, counted from the left.
pressed_at :: proc(self: ^Self, cursor: (f32) {
}
    // rust: self.buttons
    // rust: .iter()
    // rust: .position(|&(x, y)| ui::hovered(cursor, x, y, self.width, 20.0))
}
    // Button `i` answers no, as Escape does (`widgets::Action`), once drawn.
declare_no :: proc(self: ^Self, i: uint) {
}
    // rust: self.no_button = Some(i);
}
    // The lines and the buttons, over whatever is behind.
    // rust: pub fn draw(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: cursor: (f32, f32),
    // rust: labels: &[Text],
    // rust: ) {
    // rust: for (line, x, y) in &self.lines {
    // rust: batch.text_styled(atlas, line, *x, *y, u32::MAX, true);
}
    // rust: for (i, (&(bx, by), label)) in self.buttons.iter().zip(labels).enumerate() {
    // rust: let is_focused = self.focus == Some(i);
    // rust: let hover = ui::hovered(cursor, bx, by, self.width, 20.0) || is_focused;
    // rust: if self.no_button == Some(i) {
    // rust: let action = crate::widgets::Action::Cancel;
    // rust: ui::action_button(
    // rust: batch, atlas, action, bx, by, self.width, 20.0, label, true, hover,
    // rust: );
    // rust: } else {
    // rust: ui::button(batch, atlas, bx, by, self.width, 20.0, label, true, hover);
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::hud::Rect;
//     use std::{collections::HashMap, path::Path};

font :: proc() -> F {
    // Ported from Horizon
    return {}
}
        // The missing-glyph metrics let these tests run without game assets.
    // rust: let rect = Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w: 1,
    // rust: h: 1,
}
    // rust: Font::load(
    // rust: Path::new("/nonexistent-horizon-confirm-test-resources"),
    // rust: &HashMap::new(),
    // rust: &[],
    // rust: (1, 1),
    // rust: (0, 0),
    // rust: rect,
    // rust: )
}

three_buttons_sit_four_apart_in_the_middle :: proc() {
}
    // rust: let (title, message) = (Text::literal("Open?"), Text::literal("https://x"));
    // rust: let c = Choice::new(&font(), (480.0, 270.0), &title, &message, 3, 100.0);
    // rust: let xs: Vec<f32> = c.buttons.iter().map(|b| b.0).collect();
        // 3 x 100 + 2 x 4 = 308 wide, centred on 480.
    // rust: assert_eq!(xs, vec![86.0, 190.0, 294.0]);
    // rust: assert_eq!(c.pressed_at((191.0, c.buttons[1].1 + 1.0)), Some(1));
    // rust: assert_eq!(c.pressed_at((188.0, c.buttons[1].1 + 1.0)), None);
        // Confirm keeps its two 150-wide buttons where they were.
    // rust: let two = Confirm::new(&font(), (480.0, 270.0), &title, &message);
    // rust: assert_eq!(two.buttons[0].0, 88.0);
    // rust: assert_eq!(two.buttons[1].0, 242.0);
}

only_the_button_declared_no_gets_its_job :: proc() {
}
//         use crate::widgets::{self, Action, DeclaredAction};
    // rust: let atlas = HudAtlas::build(Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let (title, message) = (Text::literal("Title"), Text::literal("Message"));
    // rust: let labels = [
    // rust: Text::literal("Yes"),
    // rust: Text::literal("Copy"),
    // rust: Text::literal("No"),
    // rust: ];
    // rust: let drawn = |frame: u64, draw: &dyn Fn(&mut HudBatch)| {
    // rust: widgets::set_action_screen(7);
    // rust: draw(&mut HudBatch::new([480, 270]));
    // rust: widgets::end_frame(frame);
    // rust: widgets::last_actions(7)
}
    // rust: let no = |rect| {
    // rust: vec![DeclaredAction {
    // rust: action: Action::Cancel,
    // rust: rect,
    // rust: enabled: true,
    // rust: }]
}

    // rust: let mut confirm = Confirm::new(&font(), (480.0, 270.0), &title, &message);
    // rust: let draw_confirm = |confirm: &Confirm, batch: &mut HudBatch| {
    // rust: confirm.draw(batch, &atlas, (0.0, 0.0), [&labels[0], &labels[2]]);
}
    // rust: assert!(drawn(1, &|b| draw_confirm(&confirm, b)).is_empty());
    // rust: confirm.declare_no();
    // rust: let (x, y) = confirm.buttons[1];
    // rust: assert_eq!(
    // rust: drawn(2, &|b| draw_confirm(&confirm, b)),
    // rust: no([x, y, 150.0, 20.0])
    // rust: );

    // rust: let mut choice = Choice::new(&font(), (480.0, 270.0), &title, &message, 3, 100.0);
    // rust: let draw_choice = |choice: &Choice, batch: &mut HudBatch| {
    // rust: choice.draw(batch, &atlas, (0.0, 0.0), &labels);
}
    // rust: assert!(drawn(3, &|b| draw_choice(&choice, b)).is_empty());
    // rust: choice.declare_no(2);
    // rust: let (x, y) = choice.buttons[2];
    // rust: assert_eq!(
    // rust: drawn(4, &|b| draw_choice(&choice, b)),
    // rust: no([x, y, 100.0, 20.0])
    // rust: );
}

confirm_and_choice_keyboard_navigation :: proc() {
}
    // rust: let (title, message) = (Text::literal("Title"), Text::literal("Message"));
    // rust: let mut confirm = Confirm::new(&font(), (480.0, 270.0), &title, &message);
    // rust: assert_eq!(confirm.focus, None);
    // rust: assert_eq!(confirm.answer(), None);

    // rust: confirm.tab(false);
    // rust: assert_eq!(confirm.focus, Some(0));
    // rust: assert_eq!(confirm.answer(), Some(true));

    // rust: confirm.tab(false);
    // rust: assert_eq!(confirm.focus, Some(1));
    // rust: assert_eq!(confirm.answer(), Some(false));

    // rust: confirm.tab(true);
    // rust: assert_eq!(confirm.focus, Some(0));

    // rust: confirm.arrow(false);
    // rust: assert_eq!(confirm.focus, Some(1));
    // rust: confirm.arrow(true);
    // rust: assert_eq!(confirm.focus, Some(0));

    // rust: let mut choice = Choice::new(&font(), (480.0, 270.0), &title, &message, 3, 100.0);
    // rust: assert_eq!(choice.focus, None);
    // rust: assert_eq!(choice.pressed(), None);

    // rust: choice.tab(false);
    // rust: assert_eq!(choice.focus, Some(0));
    // rust: assert_eq!(choice.pressed(), Some(0));

    // rust: choice.tab(false);
    // rust: assert_eq!(choice.focus, Some(1));

    // rust: choice.tab(false);
    // rust: assert_eq!(choice.focus, Some(2));

    // rust: choice.tab(false);
    // rust: assert_eq!(choice.focus, Some(0));

    // rust: choice.arrow(false);
    // rust: assert_eq!(choice.focus, Some(1));
    // rust: choice.arrow(true);
    // rust: assert_eq!(choice.focus, Some(0));
}
}
