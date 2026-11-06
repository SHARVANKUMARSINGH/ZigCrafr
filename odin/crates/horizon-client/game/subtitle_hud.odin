//! Transpiled from Horizon Rust crate
package horizon_client_subtitle_hud

import "core:fmt"
import "core:mem"
import "core:math"

// The subtitle overlay in the game (`Hud` -> `SubtitleOverlay`): the sound
// engine reports the sounds it plays while the overlay listens, the HUD
// renders it (which starts or stops the listening as the "Show Subtitles"
// option says).
// use super::Game;
// use horizon_client::{
    // rust: hud::HudBatch,
    // rust: hud_layout,
    // rust: hud_overlays::{SubtitleFrame, SubtitleOverlay, now_ms},
}
// use std::cell::RefCell;

    // rust: pub(super) struct SubtitleState {
    // rust: overlay: RefCell<SubtitleOverlay>,
}
    // rust: impl Game<'_> {
    // Feed the sounds the engine reported since the last tick
    // (`SoundEventListener.onPlaySound`) while the overlay listens.
    // rust: pub(super) fn tick_subtitles(&mut self) {
    // rust: let mut overlay = self.subtitles.overlay.borrow_mut();
    // rust: let listening = overlay.listening();
    // rust: self.audio.record_heard = listening;
    // rust: let heard = self.audio.take_heard();
    // rust: if !listening {
    // rust: return;
}
    // rust: let now = now_ms();
    // rust: for h in heard {
    // rust: let at = h.at.unwrap_or(self.audio.listener);
    // rust: overlay.on_play(Some(&h.subtitle), at, h.range, h.looping, now);
}
}
    // rust: pub(super) fn draw_subtitles(&self, batch: &mut HudBatch) {
        // Hud.extractRenderState: hidden with the rest of the HUD (F1).
    // rust: if self.ui.hide_gui {
    // rust: return;
}
    // rust: let v = &self.view;
    // rust: let frame = SubtitleFrame {
    // rust: show: self.settings.show_subtitles,
    // rust: position: v.position,
    // rust: forward: v.forwards.map(f64::from),
    // rust: up: v.up.map(f64::from),
    // rust: multiplier: f64::from(self.settings.notification_display_time),
    // rust: background: self.settings.text_background(0.8),
    // rust: width: batch.width as i32,
    // rust: height: batch.height as i32,
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let draws = self
    // rust: .subtitles
    // rust: .overlay
    // rust: .borrow_mut()
    // rust: .extract(&frame, &atlas.font, now_ms());
    // rust: hud_layout::paint(batch, atlas, &draws);
}
}
