//! Transpiled from Horizon Rust crate
package horizon_client_controller_notice

import "core:fmt"
import "core:mem"
import "core:math"

// A notice about a controller nobody has to answer: translated words, the controller's own glyph
// if it helps, how long it stays. A view holds one at a time (`NoticeSlot`), so they never stack:
// each player's game has its own slot, and what raises a notice (splitscreen's joins and
// reconnects, a solo game's controller coming and going) decides that for itself.
// use crate::gamepad::{Button, GlyphStyle};
// use crate::hud::{HudAtlas, HudBatch, rgba};
// use crate::pad_glyph;
// use crate::toasts::Slide;
// use std::time::{Duration, Instant};

// What a notice is about: another with the same id takes its place at once, whatever its
// priority (a controller reconnecting replaces its disconnect) and without sliding in again.
NoticeId :: enum {
    // A controller connected or disconnected.
    Connection,
    // A splitscreen player the server sent away.
    PlayerLeft,
    // The stick stopped moving the player at its own angle on this server.
    Movement,
}

// Which of two notices about different things stays up.
Priority :: enum {
    // Good to know; it doesn't replace something that needs the player.
    Info,
    // The player may have to do something.
    Attention,
}

// A button shown before the body, in the player's glyphs.
Glyph :: struct {
    button: Button,
    style: GlyphStyle,
}

Notice :: struct {
    id: NoticeId,
    priority: Priority,
    title: string,
    body: string,
    glyph: Maybe(Glyph),
    // When it was raised: it goes that long after, drawn or not (a notice raised on the way
    // out of a world must not wait for the next one).
    raised: Instant,
    slide: Slide,
}

    // rust: impl Notice {
    // rust: pub fn new(
    // rust: id: NoticeId,
    // rust: priority: Priority,
    // rust: title: impl Into<String>,
    // rust: body: impl Into<String>,
    // rust: ) -> Self {
    // rust: Self {
    // rust: id,
    // rust: priority,
    // rust: title: title.into(),
    // rust: body: body.into(),
    // rust: glyph: None,
    // rust: raised: Instant::now(),
    // rust: slide: Slide::default(),
}
}
with_glyph :: proc(glyph: Glyph) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.glyph = Some(glyph);
    // rust: self
}
}

// The one notice over a player's view.
NoticeSlot :: struct {
    current: Maybe(Notice),
}

    // rust: impl NoticeSlot {
    // `notice` shows here: in place of one about the same thing, and of anything that doesn't
    // outrank it. Otherwise it's dropped, not queued: by the time the other goes it is old news.
raise :: proc(self: ^Self, mut notice: Notice) {
}
    // rust: match &mut self.current {
    // rust: Some(old) if old.id == notice.id => {
                // Already on screen: the words change and its time starts again.
    // rust: notice.slide = std::mem::take(&mut old.slide);
    // rust: *old = notice;
}
    // rust: Some(old) if old.priority > notice.priority => {}
    // rust: current => *current = Some(notice),
}
}
clear :: proc(self: ^Self) {
}
    // rust: self.current = None;
}
    // What it shows now, for `pad status`.
showing :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.current
    // rust: .as_ref()
    // rust: .map(|n| (n.title.as_str(), n.body.as_str()))
}
    // Its time, after `shown_for`: it slides out (`ToastManager`'s slide); one whose time passed
    // while nothing drew is simply gone. Then whether anything is left to draw.
update :: proc(self: ^Self, shown_for: Duration) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(notice) = &mut self.current else {
    // rust: return false;
}
    // rust: let elapsed = notice.raised.elapsed();
    // rust: let finished = if notice.slide.origin.is_none() && elapsed > shown_for {
    // rust: true
    // rust: } else {
    // rust: notice.slide.update_now(|_| elapsed <= shown_for).1
}
    // rust: if finished {
    // rust: self.current = None;
}
    // rust: !finished
}
    // The notice under `top` on a view: a strip in the middle, its words wrapped to the view (a
    // toast is as wide as its longest line: off a narrow view's edge), sliding down from the
    // view's edge.
draw :: proc(self: ^Self, batch: ^HudBatch, atlas: ^HudAtlas, top: f32, shown_for: Duration) {
}
    // rust: if !self.update(shown_for) {
    // rust: return;
}
    // rust: let Some(notice) = &self.current else {
    // rust: return;
}
    // rust: let w = batch.width;
    // rust: let width = |text: &str| HudBatch::text_width(atlas, text).ceil();
    // rust: let max = (w - 24.0).min(260.0);
    // rust: let glyph = notice
    // rust: .glyph
    // rust: .map(|g| (g, pad_glyph::width(atlas, g.button, g.style) + 4.0));
    // rust: let indent = glyph.map_or(0.0, |g| g.1);
    // rust: let lines = crate::split_profiles::wrap(&notice.body, max - indent, width);
    // rust: let inner = lines
    // rust: .iter()
    // rust: .map(|l| width(l) + indent)
    // rust: .fold(width(&notice.title), f32::max);
    // rust: let (pw, ph) = (inner.min(max) + 16.0, 20.0 + 10.0 * lines.len() as f32);
    // rust: let px = ((w - pw) / 2.0).floor();
    // rust: let py = (top - (1.0 - notice.slide.portion) * (top + ph)).floor();
    // rust: panel(batch, atlas, [px, py, pw, ph]);
    // rust: let white = rgba(255, 255, 255, 255);
    // rust: let tx = (px + (pw - width(&notice.title)) / 2.0).floor();
    // rust: batch.text(atlas, &notice.title, tx, py + 6.0, white, true);
    // rust: for (k, line) in lines.iter().enumerate() {
    // rust: let lx = (px + (pw - width(line) - indent) / 2.0).floor();
    // rust: let y = py + 18.0 + 10.0 * k as f32;
    // rust: if let (0, Some((g, _))) = (k, glyph) {
    // rust: pad_glyph::draw(batch, atlas, g.button, g.style, lx, y);
}
    // rust: batch.text(atlas, line, lx + indent, y, rgba(200, 200, 200, 255), false);
}
}
}

// The prompts' and notices' box: dark, a faint edge.
panel :: proc(batch: ^HudBatch, atlas: ^HudAtlas, ph]: [f32; 4]) {
}
    // rust: batch.fill(atlas, px, py, pw, ph, rgba(0, 0, 0, 210));
    // rust: let edge = rgba(255, 255, 255, 90);
    // rust: for [x, y, fw, fh] in [
    // rust: [px, py, pw, 1.0],
    // rust: [px, py + ph - 1.0, pw, 1.0],
    // rust: [px, py, 1.0, ph],
    // rust: [px + pw - 1.0, py, 1.0, ph],
    // rust: ] {
    // rust: batch.fill(atlas, x, y, fw, fh, edge);
}
}

    // rust: mod tests {
//     use super::*;

notice :: proc(id: NoticeId, priority: Priority, title: string) -> N {
    // Ported from Horizon
    return {}
}
    // rust: Notice::new(id, priority, title, "")
}

a_view_holds_one_notice_however_many_are_raised :: proc() {
}
    // rust: let mut slot = NoticeSlot::default();
    // rust: for i in 0..50 {
    // rust: let title = i.to_string();
    // rust: slot.raise(notice(NoticeId::Connection, Priority::Info, &title));
}
    // rust: assert_eq!(slot.showing().map(|s| s.0), Some("49"));
}

a_reconnect_replaces_its_disconnect_though_it_ranks_lower :: proc() {
}
    // rust: let mut slot = NoticeSlot::default();
    // rust: slot.raise(notice(NoticeId::Connection, Priority::Attention, "gone"));
    // rust: slot.raise(notice(NoticeId::Connection, Priority::Info, "back"));
    // rust: assert_eq!(slot.showing().map(|s| s.0), Some("back"));
}

what_needs_the_player_stays_over_other_news :: proc() {
}
    // rust: let mut slot = NoticeSlot::default();
    // rust: slot.raise(notice(NoticeId::PlayerLeft, Priority::Attention, "left"));
    // rust: slot.raise(notice(NoticeId::Connection, Priority::Info, "back"));
    // rust: assert_eq!(slot.showing().map(|s| s.0), Some("left"));
        // News of the same rank is newer.
    // rust: slot.raise(notice(NoticeId::Connection, Priority::Attention, "gone"));
    // rust: assert_eq!(slot.showing().map(|s| s.0), Some("gone"));
}

a_notice_raised_while_nothing_draws_is_gone_when_its_time_has_passed :: proc() {
}
    // rust: let mut slot = NoticeSlot::default();
    // rust: slot.raise(notice(NoticeId::Connection, Priority::Info, "old"));
    // rust: std::thread::sleep(Duration::from_millis(2));
    // rust: assert!(!slot.update(Duration::ZERO));
    // rust: assert_eq!(slot.showing(), None);
}

a_notice_on_screen_stays_for_its_time_then_slides_out :: proc() {
}
    // rust: let mut slot = NoticeSlot::default();
    // rust: slot.raise(notice(NoticeId::Connection, Priority::Info, "new"));
    // rust: assert!(slot.update(Duration::from_secs(60)));
    // rust: std::thread::sleep(Duration::from_millis(2));
        // Past its time it slides out rather than vanishing.
    // rust: assert!(slot.update(Duration::ZERO));
    // rust: assert!(slot.showing().is_some());
}
}
