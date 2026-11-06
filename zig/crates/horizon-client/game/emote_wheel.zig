//! Transpiled from Horizon Rust crate
//! Module: horizon-client_emote_wheel
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The emote wheel (`key.emote`, B by default; bindable on a controller): the player's emotes
//! around the middle of the screen. Hover one and release the key, click it, or press its
//! number; Escape or the key again closes it. The game doesn't pause and nothing is sent to the
//! game server.

// use super::{Game, Screen};
// use horizon_client::{hud::HudBatch, text::Text};
// use std::time::{Duration, Instant};
// use winit::event::{ElementState, MouseButton, WindowEvent};
// use winit::keyboard::{KeyCode, PhysicalKey};

/// Emotes on the wheel.
    // rust: pub(super) const SLOTS: usize = 8;
/// The ring, in GUI pixels from the middle; inside `INNER` nothing is hovered.
pub const INNER: f32 = 30.0;
pub const OUTER: f32 = 92.0;
/// Held at least this long, releasing the key plays what is hovered (or closes); a tap leaves the
/// wheel open.
pub const HOLD: Duration = Duration::from_millis(250);

    // rust: pub(super) struct Wheel {
    // rust: opened: Option<Instant>,
    // rust: hovered: Option<usize>,
}

/// The slice under a point `(dx, dy)` from the middle (GUI pixels, y down) of a wheel of `n`:
/// slice 0 is straight up, then clockwise. None in the dead middle or past the ring.
    // rust: pub(super) fn slice_at(dx: f32, dy: f32, n: usize) -> Option<usize> {
    // rust: let r = dx.hypot(dy);
    // rust: if n == 0 || r < INNER || r > OUTER * 1.6 {
    // rust: return None;
}
    // rust: let turn = std::f32::consts::TAU / n as f32;
    // Clockwise from up, centred on each slice.
    // rust: let angle = (dx.atan2(-dy) + turn / 2.0).rem_euclid(std::f32::consts::TAU);
    // rust: Some(((angle / turn) as usize).min(n - 1))
}

/// A point at `radius` and `angle` (radians clockwise from up) around `(cx, cy)`.
pub fn at(cx: f32, cy: f32, radius: f32, angle: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [cx + radius * angle.sin(), cy - radius * angle.cos()]
}

    // rust: impl Game<'_> {
    /// Opens the wheel from play.
    // rust: pub(super) fn open_emote_wheel(&mut self) {
    // rust: self.refresh_owned_emotes();
    // rust: self.emote_wheel = Wheel {
    // rust: opened: Some(Instant::now()),
    // rust: hovered: None,
}
    // rust: self.screen = Screen::EmoteWheel;
    // rust: self.keys.clear();
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: self.mining = None;
    // rust: self.capture(false);
}

    /// Closes the wheel; `play`: the slice to play first.
    // rust: pub(super) fn close_emote_wheel(&mut self, play: Option<usize>) {
    // rust: self.emote_wheel = Wheel::default();
    // rust: self.screen = Screen::Playing;
    // rust: self.capture(true);
    // rust: let id = play.and_then(|i| self.owned_emotes().get(i).map(|e| e.id.clone()));
    // rust: if let Some(id) = id {
    // rust: self.play_emote(&id);
}
}

    /// The emote key let go: a held press plays what is hovered, a tap keeps the wheel open.
    // rust: pub(super) fn emote_wheel_released(&mut self) {
    // rust: let held = self
    // rust: .emote_wheel
    // rust: .opened
    // rust: .is_some_and(|at| at.elapsed() >= HOLD);
    // rust: if held || self.emote_wheel.hovered.is_some() {
    // rust: self.close_emote_wheel(self.emote_wheel.hovered);
}
}

    /// A window event while the wheel is open: the emote key let go, or a left click. True when
    /// the wheel took it.
    // rust: pub(super) fn emote_wheel_event(&mut self, event: &WindowEvent) -> bool {
    // rust: match event {
    // rust: WindowEvent::KeyboardInput { event, .. }
    // rust: if event.state == ElementState::Released
    // rust: && matches!(event.physical_key, PhysicalKey::Code(key)
    // rust: if self.settings.keys.translate(key) == Some(Ok(KeyCode::KeyB))) =>
    // rust: {
    // rust: self.emote_wheel_released();
    // rust: true
}
    // rust: WindowEvent::MouseInput {
    // rust: state: ElementState::Pressed,
    // rust: button: MouseButton::Left,
    // rust: ..
    // rust: } => {
    // rust: self.emote_wheel_click();
    // rust: true
}
    // rust: _ => false,
}
}

    /// A click on the wheel: plays the hovered emote, or closes.
    // rust: pub(super) fn emote_wheel_click(&mut self) {
    // rust: self.close_emote_wheel(self.emote_wheel.hovered);
}

    // rust: pub(super) fn draw_emote_wheel(&mut self, batch: &mut HudBatch) {
    // rust: horizon_client::widgets::begin_screen(|| {
    // rust: horizon_client::widgets::ScreenInfo::new("emote_wheel", "horizon.emote_wheel.title")
    // rust: });
    // rust: let ids: Vec<String> = self
    // rust: .owned_emotes()
    // rust: .iter()
    // rust: .take(SLOTS)
    // rust: .map(|e| e.id.clone())
    // rust: .collect();
    // rust: let names: Vec<String> = ids.iter().map(|id| self.emote_name(id)).collect();
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let (cx, cy) = (w / 2.0, h / 2.0);
    // rust: let n = names.len();
        // The cursor is in GUI pixels, as the batch.
    // rust: let (mx, my) = self.cursor;
    // rust: self.emote_wheel.hovered = slice_at(mx - cx, my - cy, n);
    // rust: let hovered = self.emote_wheel.hovered;
    // rust: let atlas = &self.gui.atlas;
        // The ring: each slice a fan of quads, the hovered one brighter.
    // rust: let slices = n.max(1);
    // rust: let turn = std::f32::consts::TAU / slices as f32;
    // rust: let gap = 0.03;
    // rust: for i in 0..slices {
    // rust: let colour = match (n, hovered == Some(i)) {
    // rust: (0, _) => 0x9010_1018,
    // rust: (_, true) => 0xD0A9_8FFF,
    // rust: _ => 0xA010_1018,
}
    // rust: let from = i as f32 * turn - turn / 2.0 + gap;
    // rust: let span = turn - 2.0 * gap;
    // rust: for k in 0..6 {
    // rust: let (a0, a1) = (
    // rust: from + span * k as f32 / 6.0,
    // rust: from + span * (k + 1) as f32 / 6.0,
    // rust: );
    // rust: batch.fill_quad(
    // rust: atlas,
    // rust: [
    // rust: at(cx, cy, INNER, a0),
    // rust: at(cx, cy, OUTER, a0),
    // rust: at(cx, cy, OUTER, a1),
    // rust: at(cx, cy, INNER, a1),
    // rust: ],
    // rust: colour,
    // rust: );
}
}
        // Each slice's number and name, in the middle of its band.
    // rust: for (i, name) in names.iter().enumerate() {
    // rust: let [x, y] = at(cx, cy, (INNER + OUTER) / 2.0, i as f32 * turn);
    // rust: let label = format!("{} {name}", i + 1);
    // rust: let lw = HudBatch::text_width(atlas, &label);
    // rust: let colour = if hovered == Some(i) {
    // rust: u32::MAX
    // rust: } else {
    // rust: 0xFFC8_C8D0
}
    // rust: batch.text(atlas, &label, x - lw / 2.0, y - 4.0, colour, true);
}
    // rust: let title = match (n, hovered) {
    // rust: (0, _) => Text::translate("horizon.emote_wheel.empty", &[]),
    // rust: (_, Some(i)) => Text::literal(&names[i]),
    // rust: _ => Text::translate("horizon.emote_wheel.title", &[]),
}
    // rust: let plain = title.plain();
    // rust: let tw = HudBatch::text_width(atlas, &plain);
    // rust: batch.text_styled(atlas, &title, cx - tw / 2.0, cy - 4.0, u32::MAX, true);
    // rust: let help = Text::translate("horizon.emote_wheel.help", &[]);
    // rust: let hw = HudBatch::text_width(atlas, &help.plain());
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &help,
    // rust: cx - hw / 2.0,
    // rust: cy + OUTER + 10.0,
    // rust: 0xFFA0_A0A8,
    // rust: true,
    // rust: );
}
}

    // rust: mod tests {
//     use super::*;

pub fn slices_go_clockwise_from_the_top_with_a_dead_middle() void {
}
        // Eight slices: up, up-right, right... each centred on its direction.
    // rust: assert_eq!(slice_at(0.0, -60.0, 8), Some(0));
    // rust: assert_eq!(slice_at(42.0, -42.0, 8), Some(1));
    // rust: assert_eq!(slice_at(60.0, 0.0, 8), Some(2));
    // rust: assert_eq!(slice_at(0.0, 60.0, 8), Some(4));
    // rust: assert_eq!(slice_at(-60.0, 0.0, 8), Some(6));
        // Just left of up is still the top slice; a bit more is the last.
    // rust: assert_eq!(slice_at(-10.0, -60.0, 8), Some(0));
    // rust: assert_eq!(slice_at(-35.0, -60.0, 8), Some(7));
        // The middle and far away: nothing. No emotes: nothing.
    // rust: assert_eq!(slice_at(5.0, 5.0, 8), None);
    // rust: assert_eq!(slice_at(0.0, -400.0, 8), None);
    // rust: assert_eq!(slice_at(0.0, -60.0, 0), None);
        // Two: top and bottom halves.
    // rust: assert_eq!(slice_at(50.0, -10.0, 2), Some(0));
    // rust: assert_eq!(slice_at(50.0, 10.0, 2), Some(1));
}
}
