//! Transpiled from Horizon Rust crate
//! Module: horizon-client_onboarding
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `AccessibilityOnboardingScreen`: the screen shown once before the title
//! on a first launch (`Gui.addInitialScreens` while `onboardAccessibility`
//! is set), with the Narrator toggle, the Sound, Accessibility and Language
//! pages and Continue. It fades in over two seconds and out over one.
// use super::{Button, Mode, Title, translate};
// use crate::{
    // rust: hud::{HudAtlas, HudBatch, rgba},
    // rust: lang,
}
// use std::{cell::Cell, time::Instant};

/// `AccessibilityOnboardingScreen.TEXT_WIDGET_WIDTH`.
pub const TEXT_WIDTH: f32 = 374.0;
/// `HeaderAndFooterLayout(this, initTitleYPos(), 33)`.
pub const HEADER: f32 = 90.0;
pub const FOOTER: f32 = 33.0;
/// `fadeInStart` runs for 2000 ms, `FADE_OUT_TIME` is 1000 ms.
pub const FADE_IN_SECONDS: f32 = 2.0;
pub const FADE_OUT_SECONDS: f32 = 1.0;

/// The ids of the screen's buttons.
    // rust: pub(super) const NARRATOR: u8 = 80;
    // rust: pub(super) const SOUNDS: u8 = 81;
    // rust: pub(super) const ACCESSIBILITY: u8 = 82;
    // rust: pub(super) const LANGUAGE: u8 = 83;
    // rust: pub(super) const CONTINUE: u8 = 84;

/// The fades of an open screen (`fadeInStart`, `fadingIn`, `fadeOutStart`).
pub const Onboarding = struct {
    fade_in_start: Cell<?Instant>,
    fading_in: Cell<bool>,
    fade_out_start: Cell<?Instant>,
    /// The widget alpha of the frame being drawn.
    alpha: Cell<f32>,
};

    // rust: impl Onboarding {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: fade_in_start: Cell::new(None),
    // rust: fading_in: Cell::new(true),
    // rust: fade_out_start: Cell::new(None),
    // rust: alpha: Cell::new(1.0),
}
}

    /// `Mth.clampedMap(fade, 0.5, 1, 0, 1)`.
pub fn widget_alpha(fade: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((fade.clamp(0.0, 1.0) - 0.5) / 0.5).clamp(0.0, 1.0)
}

    /// `extractRenderState`'s fades at `now`: the alpha every widget gets.
pub fn fade(self: *Self, now: Instant) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.fade_in_start.get().is_none() && self.fading_in.get() {
    // rust: self.fade_in_start.set(Some(now));
}
    // rust: let mut alpha = 1.0;
    // rust: if let Some(start) = self.fade_in_start.get() {
    // rust: let fade = now.saturating_duration_since(start).as_secs_f32() / FADE_IN_SECONDS;
    // rust: if fade >= 1.0 {
    // rust: self.fading_in.set(false);
    // rust: self.fade_in_start.set(None);
    // rust: } else {
    // rust: alpha = Self::widget_alpha(fade);
}
}
    // rust: if let Some(start) = self.fade_out_start.get() {
    // rust: let fade = 1.0 - now.saturating_duration_since(start).as_secs_f32() / FADE_OUT_SECONDS;
    // rust: alpha = if fade <= 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: Self::widget_alpha(fade)
}
}
    // rust: alpha
}

    /// `onClose`: starts the fade out once.
pub fn close(self: *Self, now: Instant) void {
}
    // rust: if self.fade_out_start.get().is_none() {
    // rust: self.fade_out_start.set(Some(now));
}
}

    /// Whether the fade out has run out: `close(true, onClose)`.
pub fn closed(self: *Self, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fade_out_start.get().is_some_and(|start| {
    // rust: now.saturating_duration_since(start).as_secs_f32() >= FADE_OUT_SECONDS
    // rust: })
}
}

    // rust: impl Default for Onboarding {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new()
}
}

/// Where the screen's parts go.
    // rust: pub(super) struct Layout {
    /// The title box: x, y, width, height.
    // rust: pub text: [f32; 4],
    /// The four grid buttons, row by row.
    // rust: pub grid: [(f32, f32); 4],
    // rust: pub continue_at: (f32, f32),
}

/// `HeaderAndFooterLayout.arrangeElements` for the contents (the title in
/// an 8 px cell over the grid of four 150-wide buttons in 4 px cells, both
/// centred) with the title wrapped to `lines`.
    // rust: pub(super) fn layout(w: f32, h: f32, lines: usize) -> Layout {
    // rust: let text_h = 9.0 * lines as f32 + 8.0;
    // The 8 px cell around the box, then the grid's 4 px cell around the
    // two rows of 4 px cells.
    // rust: let content_w = TEXT_WIDTH + 16.0;
    // rust: let content_h = text_h + 16.0 + 64.0;
    // rust: let y = (HEADER + 30.0).min(h - FOOTER - content_h);
    // rust: let x = ((w.max(content_w) - content_w) / 2.0).trunc();
    // The grid: 316 wide in the 382 left by the cell's padding.
    // rust: let grid_x = x + 4.0 + ((content_w - 8.0 - 316.0) / 2.0).trunc() + 4.0;
    // rust: let grid_y = y + text_h + 16.0 + 4.0 + 4.0;
    // rust: Layout {
    // rust: text: [x + 8.0, y + 8.0, TEXT_WIDTH, text_h],
    // rust: grid: [
    // rust: (grid_x, grid_y),
    // rust: (grid_x + 158.0, grid_y),
    // rust: (grid_x, grid_y + 28.0),
    // rust: (grid_x + 158.0, grid_y + 28.0),
    // rust: ],
    // rust: continue_at: (
    // rust: ((w - 150.0) / 2.0).trunc(),
    // rust: h - FOOTER + ((FOOTER - 20.0) / 2.0).trunc(),
    // rust: ),
}
}

/// The wrapped lines of the title (`accessibility.onboarding.screen.title`).
pub fn title_lines(atlas: *HudAtlas) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let title = lang::get_or(
    // rust: "accessibility.onboarding.screen.title",
    // rust: "Welcome to Minecraft!\n\nWould you like to enable the Narrator or visit the Accessibility Settings?",
    // rust: );
    // rust: let mut lines = Vec::new();
    // rust: for paragraph in title.split('\n') {
    // rust: if paragraph.is_empty() {
    // rust: lines.push(String::new());
    // rust: } else {
    // rust: lines.extend(
    // rust: atlas
    // rust: .font
    // rust: .split(&crate::text::Text::literal(paragraph), TEXT_WIDTH - 8.0)
    // rust: .iter()
    // rust: .map(|line| line.plain()),
    // rust: );
}
}
    // rust: lines
}

    // rust: impl Title {
    /// The first screen of a first launch (`addInitialScreens`).
pub fn start_onboarding(self: *Self) void {
}
    // rust: self.mode = Mode::Onboarding(Onboarding::new());
}

    /// `onClose`: Escape and Continue fade the screen out.
    // rust: pub(super) fn onboarding_close(&self) {
    // rust: if let Mode::Onboarding(screen) = &self.mode {
    // rust: screen.close(Instant::now());
}
}

    /// Once the fade out is over the title follows and the owner stores that
    /// onboarding is finished (`Options.onboardingAccessibilityFinished`).
    // rust: pub(super) fn poll_onboarding(&mut self, now: Instant) {
    // rust: if let Mode::Onboarding(screen) = &self.mode
    // rust: && screen.closed(now)
    // rust: {
    // rust: self.mode = Mode::Main;
    // rust: self.onboarding_finished = true;
}
}

    // rust: pub(super) fn onboarding_buttons(&self, w: f32, h: f32) -> Vec<Button> {
    // rust: let layout = layout(w, h, self.message_lines.get());
    // rust: let button =
    // rust: |(x, y): (f32, f32), label: String, enabled: bool, id: u8, icon: Option<_>| Button {
    // rust: x,
    // rust: y,
    // rust: w: 150.0,
    // rust: label,
    // rust: enabled,
    // rust: id,
    // rust: icon: None,
    // rust: trailing: icon,
    // rust: action: None,
}
        // The Narrator button is inactive without a narrator, and shows
        // `options.narrator.notavailable`.
    // rust: let narrator = translate(
    // rust: "options.generic_value",
    // rust: "%s: %s",
    // rust: &[
    // rust: &lang::get_or("options.narrator", "Narrator"),
    // rust: &lang::get_or("options.narrator.notavailable", "Not Available"),
    // rust: ],
    // rust: );
    // rust: vec![
    // rust: button(layout.grid[0], narrator, false, NARRATOR, None),
    // rust: button(
    // rust: layout.grid[1],
    // rust: lang::get_or("options.sounds", "Music & Sounds..."),
    // rust: true,
    // rust: SOUNDS,
    // rust: Some(("icon/music_notes", 16.0)),
    // rust: ),
    // rust: button(
    // rust: layout.grid[2],
    // rust: lang::get_or(
    // rust: "accessibility.onboarding.accessibility.button",
    // rust: "Accessibility Settings...",
    // rust: ),
    // rust: true,
    // rust: ACCESSIBILITY,
    // rust: Some(("icon/accessibility", 15.0)),
    // rust: ),
    // rust: button(
    // rust: layout.grid[3],
    // rust: lang::get_or("options.language", "Language..."),
    // rust: true,
    // rust: LANGUAGE,
    // rust: Some(("icon/language", 15.0)),
    // rust: ),
    // rust: button(
    // rust: layout.continue_at,
    // rust: lang::get_or("gui.continue", "Continue"),
    // rust: true,
    // rust: CONTINUE,
    // rust: None,
    // rust: ),
    // rust: ]
}

    /// The title box over the background; the index of its first vertex,
    /// where the widgets' fade begins.
    // rust: pub(super) fn draw_onboarding(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: w: f32,
    // rust: h: f32,
    // rust: ) -> usize {
    // rust: let Mode::Onboarding(screen) = &self.mode else {
    // rust: return batch.vertices.len();
}
    // rust: screen.alpha.set(screen.fade(Instant::now()));
    // rust: crate::ui::menu_background(batch, atlas, 0.0, 0.0, w, h, false);
    // rust: let lines = title_lines(atlas);
    // rust: self.message_lines.set(lines.len());
    // rust: let first = batch.vertices.len();
    // rust: let [x, y, bw, bh] = layout(w, h, lines.len()).text;
        // FocusableTextWidget: a black fill from x + 1 and the grey outline.
    // rust: batch.fill(atlas, x + 1.0, y, bw - 1.0, bh, rgba(0, 0, 0, 255));
    // rust: let border = rgba(160, 160, 160, 255);
    // rust: batch.fill(atlas, x, y, bw, 1.0, border);
    // rust: batch.fill(atlas, x, y + bh - 1.0, bw, 1.0, border);
    // rust: batch.fill(atlas, x, y, 1.0, bh, border);
    // rust: batch.fill(atlas, x + bw - 1.0, y, 1.0, bh, border);
        // Centred on the widget, the text 4 px inside.
    // rust: let middle = x + (bw / 2.0).trunc();
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: let width = HudBatch::text_width(atlas, line);
    // rust: batch.text(
    // rust: atlas,
    // rust: line,
    // rust: middle - (width.ceil() / 2.0).floor(),
    // rust: y + 4.0 + 9.0 * i as f32,
    // rust: u32::MAX,
    // rust: true,
    // rust: );
}
    // rust: first
}

    /// After the buttons: every widget from `from` takes the fade's alpha,
    /// then the logo (`LogoRenderer(true)` keeps it through the fade).
    // rust: pub(super) fn draw_onboarding_logo(
    // rust: &self,
    // rust: atlas: &HudAtlas,
    // rust: batch: &mut HudBatch,
    // rust: w: f32,
    // rust: from: usize,
    // rust: ) {
    // rust: let Mode::Onboarding(screen) = &self.mode else {
    // rust: return;
}
    // rust: let alpha = screen.alpha.get();
    // rust: if alpha < 1.0 {
    // rust: for vertex in &mut batch.vertices[from..] {
    // rust: let a = (f32::from((vertex.color >> 24) as u8) * alpha).round() as u32;
    // rust: vertex.color = vertex.color & 0x00FF_FFFF | a << 24;
}
}
    // rust: super::draw_logo(atlas, batch, w);
}
}

    // rust: mod tests {
//     use super::*;
//     use std::time::Duration;

pub fn the_widgets_sit_where_the_layouts_put_them() void {
}
        // 854 x 480 GUI pixels, the title wrapped to 4 lines: the contents
        // frame starts at min(90 + 30, 480 - 33 - 124).
    // rust: let l = layout(854.0, 480.0, 4);
    // rust: assert_eq!(l.text, [240.0, 128.0, 374.0, 44.0]);
    // rust: assert_eq!(l.grid[0], (273.0, 188.0));
    // rust: assert_eq!(l.grid[1], (431.0, 188.0));
    // rust: assert_eq!(l.grid[2], (273.0, 216.0));
    // rust: assert_eq!(l.continue_at, (352.0, 453.0));
        // A short window moves the contents up to clear the footer.
    // rust: let l = layout(854.0, 240.0, 4);
    // rust: assert_eq!(l.text[1], 240.0 - 33.0 - 124.0 + 8.0);
}

pub fn the_fades_run_two_seconds_in_and_one_out() void {
}
    // rust: let screen = Onboarding::new();
    // rust: let t0 = Instant::now();
    // rust: assert_eq!(screen.fade(t0), 0.0);
    // rust: let at = |s: f32| t0 + Duration::from_secs_f32(s);
        // Invisible for the first second, then up to full at two seconds.
    // rust: assert_eq!(screen.fade(at(1.0)), 0.0);
    // rust: assert!((screen.fade(at(1.5)) - 0.5).abs() < 1e-3);
    // rust: assert_eq!(screen.fade(at(2.0)), 1.0);
    // rust: assert!(!screen.fading_in.get());
        // Close: full at once, gone after a second, the title follows.
    // rust: screen.close(at(3.0));
    // rust: assert!(!screen.closed(at(3.5)));
    // rust: assert!((screen.fade(at(3.25)) - 0.5).abs() < 1e-3);
    // rust: assert_eq!(screen.fade(at(4.0)), 0.0);
    // rust: assert!(screen.closed(at(4.0)));
}

pub fn escape_continues_and_the_title_follows_the_fade() void {
}
    // rust: let mut title = Title::new(
    // rust: std::path::PathBuf::new(),
    // rust: std::path::Path::new("/nonexistent/horizon-test-resources"),
    // rust: );
    // rust: title.start_onboarding();
    // rust: title.escape();
    // rust: assert!(matches!(title.mode, Mode::Onboarding(_)));
    // rust: title.poll_onboarding(Instant::now());
    // rust: assert!(!title.onboarding_finished);
    // rust: title.poll_onboarding(Instant::now() + Duration::from_secs(2));
    // rust: assert!(matches!(title.mode, Mode::Main));
    // rust: assert!(title.onboarding_finished);
}
}
