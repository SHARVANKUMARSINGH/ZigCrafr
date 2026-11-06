//! Transpiled from Horizon Rust crate
package horizon_client_hud_editor

import "core:fmt"
import "core:mem"
import "core:math"

// The HUD editor (`docs/pvp.md`): the PvP & HUD widgets on the game, each in a frame the
// player drags anywhere (snapping to the screen's edges and middle and to the other
// widgets), resizes with the wheel and sends back to its corner with a right click; buttons
// for the text colour, shadow, boxes and their opacity, and Reset. Opened from the PvP & HUD
// page or its key. Nothing here reaches the server.
// use super::{Game, Screen};
// use horizon_client::{
    // rust: hud::{HudBatch, rgba},
    // rust: pvp::Opt,
    // rust: pvp_hud::{self, Layout, Place, WidgetId},
    // rust: text::Text,
    // rust: ui,
}

    // rust: pub(super) struct HudEditor {
    // The widget held, and where the cursor took it from its top left corner.
    // rust: drag: Option<(WidgetId, f32, f32)>,
    // The lines the dragged box snapped to: a vertical one at x, a horizontal one at y.
    // rust: guides: (Option<f32>, Option<f32>),
    // Opened from the PvP & HUD page: Done goes back there.
    // rust: from_options: bool,
}

// The style buttons, two to a row, then Reset and Done.
    // rust: const STYLE: [Opt; 4] = [
    // rust: Opt::HudTextColour,
    // rust: Opt::HudShadow,
    // rust: Opt::HudBackground,
    // rust: Opt::HudOpacity,
    // rust: ];
BUTTON_W :: 150.0
BUTTON_H :: 20.0
GAP :: 4.0
// A frame's colour, and the held or hovered one's.
FRAME :: 0xB0FF_FFFF
FRAME_HOT :: 0xFFFF_FF55
GUIDE :: 0xFF55_FFFF

// The buttons' places, in the middle of the screen: style buttons, then Reset and Done.
buttons :: proc() {
}
    // rust: let left = (w / 2.0 - BUTTON_W - GAP / 2.0).floor();
    // rust: let right = left + BUTTON_W + GAP;
    // rust: let top = (h / 2.0 - (3.0 * BUTTON_H + 2.0 * GAP) / 2.0).floor();
    // rust: let row = |i: f32| top + i * (BUTTON_H + GAP);
    // rust: [
    // rust: (left, row(0.0)),
    // rust: (right, row(0.0)),
    // rust: (left, row(1.0)),
    // rust: (right, row(1.0)),
    // rust: (left, row(2.0)),
    // rust: (right, row(2.0)),
    // rust: ]
}

    // rust: impl Game<'_> {
    // Opens the editor over the game, from the page (`from_options`) or the key.
    // rust: pub(super) fn open_hud_editor(&mut self, from_options: bool) {
    // rust: if self.player.is_none() || self.title.is_some() {
    // rust: return;
}
    // rust: self.keys.clear();
    // rust: self.pvp.editor = Some(HudEditor {
    // rust: from_options,
    // rust: ..HudEditor::default()
    // rust: });
    // rust: self.screen = Screen::HudEditor;
    // rust: self.capture(false);
}
    // rust: pub(super) fn close_hud_editor(&mut self) {
    // rust: let from_options = self.pvp.editor.take().is_some_and(|e| e.from_options);
    // rust: self.settings.save(&Self::options_path());
    // rust: if from_options {
    // rust: self.open_options_at(false, horizon_client::options_ui::Page::Pvp);
    // rust: } else {
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
}
}
    // The editor key, from the game.
    // rust: pub(super) fn hud_editor_key_press(&mut self, name: &str) -> bool {
    // rust: if self.screen != Screen::Playing
    // rust: || self.settings.extras.pvp.editor_key != name
    // rust: || name == "key.keyboard.unknown"
    // rust: {
    // rust: return false;
}
    // rust: self.open_hud_editor(false);
    // rust: self.screen == Screen::HudEditor
}
    // Whether the HUD draws the editor's stand-ins for widgets that have nothing to show.
    // rust: pub(super) fn hud_editing(&self) -> bool {
    // rust: self.screen == Screen::HudEditor
}
style_label :: proc(self: ^Self, opt: Opt) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let p = &self.settings.extras.pvp;
    // rust: let value = match opt.switch(p) {
    // rust: Some(true) => Text::translate("options.on", &[]),
    // rust: Some(false) => Text::translate("options.off", &[]),
    // rust: None => Text::literal(opt.value(p).unwrap_or_default()),
}
    // rust: Text::option_name_value(Text::translate(opt.caption_key(), &[]), value)
}
    // The topmost widget under the cursor.
widget_under_cursor :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (cx, cy) = self.cursor;
    // rust: self.pvp
    // rust: .boxes
    // rust: .iter()
    // rust: .rev()
    // rust: .copied()
    // rust: .find(|(_, [x, y, w, h])| cx >= *x && cx < x + w && cy >= *y && cy < y + h)
}
    // rust: pub(super) fn draw_hud_editor(&mut self, batch: &mut HudBatch) {
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let colour = |c: u32| {
    // rust: let [a, r, g, b] = c.to_be_bytes();
    // rust: rgba(r, g, b, a)
}
    // rust: let held = self.pvp.editor.as_ref().and_then(|e| e.drag).map(|d| d.0);
    // rust: let hot = held.or(self.widget_under_cursor().map(|(id, _)| id));
    // rust: for &(id, [x, y, bw, bh]) in &self.pvp.boxes {
    // rust: let c = colour(if Some(id) == hot { FRAME_HOT } else { FRAME });
    // rust: batch.fill(atlas, x - 1.0, y - 1.0, bw + 2.0, 1.0, c);
    // rust: batch.fill(atlas, x - 1.0, y + bh, bw + 2.0, 1.0, c);
    // rust: batch.fill(atlas, x - 1.0, y, 1.0, bh, c);
    // rust: batch.fill(atlas, x + bw, y, 1.0, bh, c);
}
    // rust: if let Some(e) = &self.pvp.editor {
    // rust: if let Some(x) = e.guides.0 {
    // rust: batch.fill(atlas, x, 0.0, 1.0, h, colour(GUIDE));
}
    // rust: if let Some(y) = e.guides.1 {
    // rust: batch.fill(atlas, 0.0, y, w, 1.0, colour(GUIDE));
}
}
    // rust: let places = buttons((w, h));
    // rust: let hint = Text::translate("horizon.pvp.editor.hint", &[]);
    // rust: let hw = atlas.font.width_text(&hint);
    // rust: let top = places[0].1;
    // rust: let hx = ((w - hw) / 2.0).floor();
    // rust: batch.text_styled(atlas, &hint, hx, top - 14.0, u32::MAX, true);
    // rust: let labels = STYLE.map(|o| self.style_label(o));
    // rust: let rest = [
    // rust: Text::translate("controls.reset", &[]),
    // rust: Text::translate("gui.done", &[]),
    // rust: ];
        // Opacity does nothing without the boxes.
    // rust: let boxes = self.settings.extras.pvp.hud.background;
    // rust: for (i, (label, &(x, y))) in labels.iter().chain(&rest).zip(&places).enumerate() {
    // rust: let active = i != 3 || boxes;
    // rust: let hover = active && ui::hovered(self.cursor, x, y, BUTTON_W, BUTTON_H);
    // rust: ui::button(batch, atlas, x, y, BUTTON_W, BUTTON_H, label, active, hover);
}
}
    // A press: a button, else the widget under the cursor (right button: back to its corner).
    // rust: pub(super) fn hud_editor_press(&mut self, right: bool) {
    // rust: let size = self.gui_size();
    // rust: for (i, &(x, y)) in buttons(size).iter().enumerate() {
    // rust: if right || !ui::hovered(self.cursor, x, y, BUTTON_W, BUTTON_H) {
    // rust: continue;
}
    // rust: let back = self.has_shift_down();
    // rust: let pvp = &mut self.settings.extras.pvp;
    // rust: match i {
    // rust: 3 if !pvp.hud.background => return,
    // rust: 0..4 => STYLE[i].cycle(pvp, back),
    // rust: 4 => pvp.layout = Layout::default(),
    // rust: _ => {
    // rust: self.audio.play_button_click();
    // rust: self.close_hud_editor();
    // rust: return;
}
}
    // rust: self.audio.play_button_click();
    // rust: self.settings.save(&Self::options_path());
    // rust: return;
}
    // rust: let Some((id, [x, y, _, _])) = self.widget_under_cursor() else {
    // rust: return;
}
    // rust: if right {
    // rust: *self.settings.extras.pvp.layout.get_mut(id) = Place::default();
    // rust: self.settings.save(&Self::options_path());
    // rust: } else if let Some(e) = &mut self.pvp.editor {
    // rust: e.drag = Some((id, self.cursor.0 - x, self.cursor.1 - y));
}
}
    // The cursor moved: the held widget follows, snapping to edges near it.
    // rust: pub(super) fn hud_editor_drag(&mut self) {
    // rust: let Some((id, dx, dy)) = self.pvp.editor.as_ref().and_then(|e| e.drag) else {
    // rust: return;
}
    // rust: let Some(&(_, [_, _, w, h])) = self.pvp.boxes.iter().find(|(b, _)| *b == id) else {
    // rust: return;
}
    // rust: let screen = self.gui_size();
    // rust: let others = || self.pvp.boxes.iter().filter(|(b, _)| *b != id);
    // rust: let xs: Vec<(f32, f32)> = others().map(|(_, r)| (r[0], r[2])).collect();
    // rust: let ys: Vec<(f32, f32)> = others().map(|(_, r)| (r[1], r[3])).collect();
    // rust: let (x, gx) = pvp_hud::snap(self.cursor.0 - dx, w, screen.0, &xs);
    // rust: let (y, gy) = pvp_hud::snap(self.cursor.1 - dy, h, screen.1, &ys);
    // rust: let at = pvp_hud::to_fractions((x, y), (w, h), screen);
    // rust: self.settings.extras.pvp.layout.get_mut(id).at = Some(at);
    // rust: if let Some(e) = &mut self.pvp.editor {
    // rust: e.guides = (gx, gy);
}
}
    // rust: pub(super) fn hud_editor_release(&mut self) {
    // rust: if let Some(e) = &mut self.pvp.editor
    // rust: && e.drag.take().is_some()
    // rust: {
    // rust: e.guides = (None, None);
    // rust: self.settings.save(&Self::options_path());
}
}
    // The wheel over a widget resizes it by 10%.
    // rust: pub(super) fn hud_editor_scroll(&mut self, amount: f64) {
    // rust: let Some((id, _)) = self.widget_under_cursor() else {
    // rust: return;
}
    // rust: let place = self.settings.extras.pvp.layout.get_mut(id);
    // rust: let (lo, hi) = pvp_hud::SCALES;
    // rust: place.scale = if amount > 0.0 {
    // rust: place.scale.saturating_add(10).min(hi)
    // rust: } else {
    // rust: place.scale.saturating_sub(10).max(lo)
}
    // rust: self.settings.save(&Self::options_path());
}
}

    // rust: mod tests {
//     use super::*;

the_buttons_sit_in_the_middle_without_overlapping :: proc() {
}
    // rust: let screen = (480.0, 270.0);
    // rust: let places = buttons(screen);
    // rust: for (i, &(x, y)) in places.iter().enumerate() {
    // rust: assert!(x >= 0.0 && x + BUTTON_W <= screen.0 && y >= 0.0 && y + BUTTON_H <= screen.1);
    // rust: for &(ox, oy) in &places[i + 1..] {
    // rust: let apart = x + BUTTON_W <= ox
    // rust: || ox + BUTTON_W <= x
    // rust: || y + BUTTON_H <= oy
    // rust: || oy + BUTTON_H <= y;
    // rust: assert!(apart);
}
}
    // rust: let (left, right) = (places[0].0, places[1].0 + BUTTON_W);
    // rust: assert!((screen.0 - right - left).abs() <= 1.0, "centred");
}
}
