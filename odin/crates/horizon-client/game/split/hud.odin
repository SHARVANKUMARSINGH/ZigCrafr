//! Transpiled from Horizon Rust crate
package horizon_client_hud

import "core:fmt"
import "core:mem"
import "core:math"

// What splitscreen draws over a player's view: its badge, questions answered with the pad and
// notices.
// use super::*;
// use horizon_client::controller_notice::{NoticeSlot, panel};
// use horizon_client::gamepad::Button;
// use horizon_client::hud::{HudBatch, rgba};
// use horizon_client::pad_glyph;
// use std::time::Duration;

// What splitscreen draws over a player's view (`Game::split_hud`): its corner badge (who, for a
// moment, with why), a question its controller answers, and notices nobody has to answer.
    // rust: pub(in crate::game) struct Hud {
    // rust: pub(in crate::game) menu: bool,
    // rust: pub(in crate::game) badge: Option<String>,
    // The badge's name stays (P1's Setup, Names); off, it shows only with a place.
    // rust: pub(super) names: bool,
    // rust: pub(super) place: Option<(String, Instant)>,
    // rust: pub(super) prompt: Option<Prompt>,
    // rust: pub(in crate::game) notice: NoticeSlot,
}

// A question on a player's view, answered with its controller's buttons.
    // rust: pub(super) struct Prompt {
    // rust: pub(super) ask: Ask,
    // rust: pub(super) title: String,
    // rust: pub(super) choices: Vec<(Button, String)>,
}

// What a prompt asks: a controller may join (every view, a strip at the top: nobody stops
// playing for it), or its controller disconnected (the view dimmed beneath: any controller
// answers).
    // rust: pub(super) enum Ask {
    // rust: Join,
    // rust: Lost,
}

// A splitscreen prompt's text in the selected language (`horizon.splitscreen.prompt.*`).
    // rust: pub(super) fn tr(key: &str, args: &[&dyn std::fmt::Display]) -> String {
    // rust: horizon_client::lang::tr(&format!("horizon.splitscreen.prompt.{key}"), args)
}

// The question on a waiting player's view.
    // rust: pub(super) fn lost_prompt(name: &str) -> Prompt {
    // rust: Prompt {
    // rust: ask: Ask::Lost,
    // rust: title: tr("lost", &[&name]),
    // rust: choices: vec![
    // rust: (Button::South, tr("lost.use_another", &[])),
    // rust: (Button::East, tr("lost.leave", &[])),
    // rust: ],
}
}

    // rust: impl Game<'_> {
    // P1 opens Setup; another player opens profiles to switch identity.
    // rust: pub(in crate::game) fn open_split_settings(&mut self) {
    // rust: let page = if self.options.split_guest {
    // rust: horizon_client::options_ui::Page::SplitProfiles
    // rust: } else {
    // rust: horizon_client::options_ui::Page::SplitSetup
}
    // rust: self.open_options_at(false, page);
}

    // Splitscreen over this player's view, above the other toasts (`ToastManager`'s slots).
    // rust: pub(in crate::game) fn draw_split_hud(&mut self, batch: &mut HudBatch, hidden: bool) {
    // rust: let atlas = &self.gui.atlas;
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let width = |text: &str| HudBatch::text_width(atlas, text).ceil();
        // After a choice's words, room before the next; a glyph without words ("LB" of "LB RB
        // Move") sits right next to the next glyph.
    // rust: let gap = |what: &str| if what.is_empty() { 0.0 } else { 12.0 };
        // The badge, top left: who, and a moment where. F1 hides it with the rest of the HUD.
    // rust: if let (false, Some(badge)) = (hidden, &self.split_hud.badge) {
    // rust: let place = self.split_hud.place.as_ref();
    // rust: let text = match place.filter(|(_, until)| Instant::now() < *until) {
    // rust: Some((place, _)) => Some(format!("{badge} · {place}")),
    // rust: None => self.split_hud.names.then(|| badge.clone()),
}
    // rust: if let Some(text) = text {
    // rust: batch.text(atlas, &text, 2.0, 2.0, rgba(255, 255, 255, 230), true);
}
}
        // A question: centred over the view dimmed, or a strip at the top (a controller joining).
    // rust: if let Some(prompt) = &self.split_hud.prompt {
    // rust: let style = self.ui.options.pad_style;
    // rust: let dim = prompt.ask != Ask::Join;
    // rust: if dim {
    // rust: batch.fill(atlas, 0.0, 0.0, w, h, rgba(0, 0, 0, 120));
}
    // rust: let glyphs: Vec<_> = prompt
    // rust: .choices
    // rust: .iter()
    // rust: .map(|(b, what)| (*b, pad_glyph::width(atlas, *b, style), what.as_str()))
    // rust: .collect();
    // rust: let line: f32 = glyphs
    // rust: .iter()
    // rust: .map(|(_, gw, what)| gw + 4.0 + width(what) + gap(what))
    // rust: .sum::<f32>()
    // rust: - 12.0;
    // rust: let pw = width(&prompt.title).max(line) + 16.0;
    // rust: let ph = 34.0;
    // rust: let (px, py) = (
    // rust: ((w - pw) / 2.0).floor(),
    // rust: if dim { ((h - ph) / 2.0).floor() } else { 18.0 },
    // rust: );
    // rust: panel(batch, atlas, [px, py, pw, ph]);
    // rust: let tx = (px + (pw - width(&prompt.title)) / 2.0).floor();
    // rust: batch.text(
    // rust: atlas,
    // rust: &prompt.title,
    // rust: tx,
    // rust: py + 6.0,
    // rust: rgba(255, 255, 255, 255),
    // rust: true,
    // rust: );
    // rust: let mut x = (px + (pw - line) / 2.0).floor();
    // rust: let y = py + 20.0;
    // rust: for (button, gw, what) in glyphs {
    // rust: pad_glyph::draw(batch, atlas, button, style, x, y);
    // rust: x += gw + 4.0;
    // rust: batch.text(atlas, what, x, y, rgba(220, 220, 220, 255), false);
    // rust: x += width(what) + gap(what);
}
}
        // A notice nobody answers: at the top, under a joining controller's strip, for as long
        // as a toast shows (5 s, times the setting).
    // rust: let below_strip = matches!(&self.split_hud.prompt, Some(p) if p.ask == Ask::Join);
    // rust: let shown_for =
    // rust: Duration::from_secs_f64(5.0 * f64::from(self.settings.notification_display_time));
    // rust: let top = if below_strip { 56.0 } else { 18.0 };
    // rust: self.split_hud.notice.draw(batch, atlas, top, shown_for);
}
}

    // rust: impl<'a> Split<'a> {
    // The join question on every player's view in the world (a strip at the top), or gone.
    // rust: pub(super) fn prompt_join(&mut self, prompt: Option<Prompt>) {
    // rust: let views = std::iter::once(&mut self.host.split_hud).chain(
    // rust: self.guests
    // rust: .iter_mut()
    // rust: .filter(|g| g.name.is_some())
    // rust: .map(|g| &mut g.game.split_hud),
    // rust: );
    // rust: for hud in views {
    // rust: match &prompt {
    // rust: Some(p) => {
    // rust: if hud.prompt.as_ref().is_none_or(|q| q.ask == Ask::Join) {
    // rust: hud.prompt = Some(p.clone());
}
}
    // rust: None if hud.prompt.as_ref().is_some_and(|q| q.ask == Ask::Join) => {
    // rust: hud.prompt = None
}
    // rust: None => {}
}
}
}

    // Player `i`'s badge says `note` for a few seconds.
    // rust: pub(super) fn tag(&mut self, i: usize, note: &str) {
    // rust: let place = Some((note.to_owned(), Instant::now() + Duration::from_secs(3)));
    // rust: if let Some(game) = self.game_mut(i) {
    // rust: game.split_hud.place = place;
}
}
}
