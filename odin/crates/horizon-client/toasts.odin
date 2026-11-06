//! Transpiled from Horizon Rust crate
package horizon_client_toasts

import "core:fmt"
import "core:mem"
import "core:math"

// `ToastManager`'s slide, shared by the game's toasts and the title
// screens' system toasts.
// use crate::hud::{HudAtlas, HudBatch};
// use std::time::Instant;

// `ToastManager.ToastInstance`: slides a toast in and out over 600 ms,
// eased by the square, and counts how long it has been fully shown.
Slide :: struct {
    // When it first updated; the times below are milliseconds since.
    origin: Maybe(Instant),
    begun: bool,
    // `animationStartTime`.
    start: i64,
    // `becameFullyVisibleAt`.
    fully_at: i64,
    show: bool,
    // `visiblePortion`: 0 off screen, 1 fully in.
    portion: f32,
    // `fullyVisibleFor`.
    fully_for: i64,
}
    // rust: impl Slide {
MS :: 600
    // `ToastInstance.update` at `now`; `wants_show` is the toast's own
    // update. The visibility it switched to (the sound to play), and whether
    // it has finished sliding out.
    // rust: pub fn update(
    // rust: &mut self,
    // rust: now: i64,
    // rust: wants_show: impl FnOnce(i64) -> bool,
    // rust: ) -> (Option<bool>, bool) {
    // rust: let was = self.show;
    // rust: if !self.begun {
    // rust: self.begun = true;
    // rust: self.start = now;
    // rust: self.show = true;
}
    // rust: if self.show && now - self.start <= Self::MS {
    // rust: self.fully_at = now;
}
    // rust: self.fully_for = now - self.fully_at;
    // rust: let progress = ((now - self.start) as f32 / Self::MS as f32).clamp(0.0, 1.0);
    // rust: let progress = progress * progress;
    // rust: self.portion = if self.show { progress } else { 1.0 - progress };
    // rust: let wanted = wants_show(self.fully_for);
    // rust: if wanted != self.show {
    // rust: self.start = now - ((1.0 - self.portion) * Self::MS as f32) as i64;
    // rust: self.show = wanted;
}
    // rust: let finished = !self.show && now - self.start > Self::MS;
    // rust: ((self.show != was).then_some(self.show), finished)
}
    // `update` at the time since the first one.
update_now :: proc(self: ^Self, wants_show: impl FnOnce(i64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let origin = *self.origin.get_or_insert_with(Instant::now);
    // rust: self.update(origin.elapsed().as_millis() as i64, wants_show)
}
}

// `SystemToast`: a yellow title over a white message (or the title alone,
// lower down) on the system background. It stays until its display time
// has passed since its last change, or until it is hidden.
SystemToast :: struct {
    slide: Slide,
    // `ToastInstance.firstSlotIndex`: its 32-pixel slot once shown.
    slot: Maybe(uint),
    title: string,
    message: Maybe(string),
    // `changed`: the next update takes its time as `lastChanged`.
    changed: bool,
    last_changed: i64,
    force_hide: bool,
    // `SystemToastId.displayTime`, in milliseconds.
    display_time: f64,
    // The title's colour (`ChatFormatting.YELLOW` unless the text is styled).
    title_color: u32,
}
    // rust: impl SystemToast {
    // `SystemToastId.displayTime`'s default, in milliseconds.
DISPLAY_TIME :: 5000.0
    // `SystemToastId.LOW_DISK_SPACE`'s and `UNSECURE_SERVER_WARNING`'s display time.
LONG_DISPLAY_TIME :: 10000.0
new :: proc(title: string, message: Maybe(string)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: slide: Slide::default(),
    // rust: slot: None,
    // rust: title,
    // rust: message,
    // rust: changed: false,
    // rust: last_changed: 0,
    // rust: force_hide: false,
    // rust: display_time: Self::DISPLAY_TIME,
    // rust: title_color: crate::hud::rgba(255, 255, 0, 255),
}
}
    // A toast of an id with its own display time (`new SystemToastId(displayTime)`).
with_display_time :: proc(ms: f64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.display_time = ms;
    // rust: self
}
    // A title with its own colour (`Component.withStyle(ChatFormatting.RED)`).
with_title_color :: proc(color: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.title_color = color;
    // rust: self
}
    // `reset`: new text, and the display time starts again.
reset :: proc(self: ^Self, title: string, message: Maybe(string)) {
}
    // rust: self.title = title;
    // rust: self.message = message;
    // rust: self.changed = true;
}
display_time :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.display_time
}
    // `addOrUpdate` on a toast that is still shown: `reset` to `other`'s text.
reset_from :: proc(self: ^Self, other: SystemToast) {
}
    // rust: self.title_color = other.title_color;
    // rust: self.reset(other.title, other.message);
}
force_hide :: proc(self: ^Self) {
}
    // rust: self.force_hide = true;
}
    // `ToastInstance.update` with `SystemToast.update`, the display time
    // scaled by the Notification Time option: the visibility it switched
    // to (the sound to play), and whether it has slid out.
update :: proc(self: ^Self, multiplier: f64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: self.slide.update_now(|fully| {
    // rust: if std::mem::take(&mut self.changed) {
    // rust: self.last_changed = fully;
}
    // rust: !self.force_hide
    // rust: && ((fully - self.last_changed) as f64) < self.display_time * multiplier
    // rust: })
}
    // `extractRenderState` at `y`, in from the right edge by the visible
    // portion (`Toast.xPos`).
draw :: proc(self: ^Self, atlas: ^HudAtlas, batch: ^HudBatch, y: f32) {
}
    // rust: let width = std::iter::once(&self.title)
    // rust: .chain(&self.message)
    // rust: .map(|line| HudBatch::text_width(atlas, line))
    // rust: .fold(0.0, f32::max)
    // rust: .ceil()
    // rust: .max(160.0)
    // rust: + 30.0;
    // rust: let x = batch.width - width * self.slide.portion;
    // rust: background(atlas, batch, x, y, width);
    // rust: let yellow = self.title_color;
    // rust: match &self.message {
    // rust: Some(message) => {
    // rust: batch.text(atlas, &self.title, x + 18.0, y + 7.0, yellow, false);
    // rust: batch.text(atlas, message, x + 18.0, y + 19.0, u32::MAX, false);
}
    // rust: None => {
    // rust: batch.text(atlas, &self.title, x + 18.0, y + 12.0, yellow, false);
}
}
}
}
// SystemToast's 32-pixel background keeps the notice icon and borders intact.
background :: proc(atlas: ^HudAtlas, batch: ^HudBatch, x: f32, y: f32, width: f32) {
}
    // rust: let Some(rect) = atlas.sprites.get("gui/sprites/toast/system").copied() else {
    // rust: return;
}
    // rust: let source_x = [0.0, 17.0, rect.w as f32 - 4.0, rect.w as f32];
    // rust: let target_x = [x, x + 17.0, x + width - 4.0, x + width];
    // rust: for col in 0..3 {
    // rust: for (sy, sh, y, h) in [
    // rust: (0.0, 28.0, y, 28.0),
    // rust: (rect.h as f32 - 4.0, 4.0, y + 28.0, 4.0),
    // rust: ] {
    // rust: let mut piece = rect;
    // rust: let du = (rect.u1 - rect.u0) / rect.w as f32;
    // rust: let dv = (rect.v1 - rect.v0) / rect.h as f32;
    // rust: piece.u0 = rect.u0 + source_x[col] * du;
    // rust: piece.u1 = rect.u0 + source_x[col + 1] * du;
    // rust: piece.v0 = rect.v0 + sy * dv;
    // rust: piece.v1 = rect.v0 + (sy + sh) * dv;
    // rust: batch.rect_uv(
    // rust: target_x[col],
    // rust: y,
    // rust: target_x[col + 1] - target_x[col],
    // rust: h,
    // rust: piece,
    // rust: u32::MAX,
    // rust: );
}
}
}

// `NowPlayingToast`'s `musicNoteColorTick`, `lastMusicNoteColorChange` and
// `musicNoteColor`: the notes change colour every 25 ms, while a song plays.
MusicNotes :: struct {
    tick: i32,
    last_change: Maybe(Instant),
    // Opaque ARGB, white until the first change.
    color: u32,
}
    // rust: impl Default for MusicNotes {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: tick: 0,
    // rust: last_change: None,
    // rust: color: u32::MAX,
}
}
}
    // rust: impl MusicNotes {
    // `NowPlayingToast.tickMusicNotes`, for a song that is playing.
tick :: proc(self: ^Self) {
}
    // rust: if self
    // rust: .last_change
    // rust: .is_none_or(|at| at.elapsed().as_millis() > 25)
    // rust: {
    // rust: self.tick += 1;
    // rust: self.last_change = Some(Instant::now());
    // rust: self.color = music_note_color(self.tick);
}
}
}
// `ColorLerper.getLerpedColor(Type.MUSIC_NOTE, tick)` as opaque ARGB: the
// dye colours of `MUSIC_NOTE_COLORS` at 125 % (white is 0xE6E6E6), one per
// 30 ticks, lerped in between.
music_note_color :: proc(tick: i32) -> u {
    // Ported from Horizon
    return {}
}
    // DyeColor ids of WHITE, LIGHT_GRAY, LIGHT_BLUE, BLUE, CYAN, GREEN, LIME,
    // YELLOW, ORANGE, PINK, RED and MAGENTA.
DYES :: [0, 8, 3, 11, 9, 13, 5, 4, 1, 6, 14, 2]
    // rust: let rgb = |dye: usize| -> [i32; 3] {
    // rust: if dye == 0 {
    // rust: return [0xE6; 3];
}
    // rust: let src = crate::mobs::render::DYE[dye];
    // rust: [16, 8, 0].map(|shift| (((src >> shift & 255) as f32 * 1.25).floor() as i32).clamp(0, 255))
}
    // rust: let value = (tick / 30) as usize;
    // rust: let (from, to) = (
    // rust: rgb(DYES[value % DYES.len()]),
    // rust: rgb(DYES[(value + 1) % DYES.len()]),
    // rust: );
    // rust: let sub = (tick % 30) as f32 / 30.0;
    // ARGB.srgbLerp: Mth.lerpInt per channel.
    // rust: let lerp = |i: usize| (from[i] + (sub * (to[i] - from[i]) as f32).floor() as i32) as u32;
    // rust: 0xFF00_0000 | lerp(0) << 16 | lerp(1) << 8 | lerp(2)
}

// `NowPlayingToast` in its `ToastManager.ToastInstance`: it slides in from
// the left edge at the top of the screen and goes out after five seconds
// (scaled by the Notification Time option).
NowPlayingToast :: struct {
    slide: Slide,
    // `updateToast`: `showToast` sets it, `onFinishedRendering` clears it.
    update_toast: bool,
    multiplier: f64,
    // `wantedVisibility` is SHOW.
    wanted: bool,
    finished: bool,
}
    // rust: impl NowPlayingToast {
    // `ToastManager.showNowPlayingToast`: `resetToast`, then `showToast`.
show :: proc(self: ^Self, multiplier: f64) {
}
    // rust: self.slide = Slide::default();
    // rust: self.finished = false;
    // rust: self.update_toast = true;
    // rust: self.multiplier = multiplier;
    // rust: self.wanted = true;
}
    // `ToastManager.hideNowPlayingToast`.
hide :: proc(self: ^Self) {
}
    // rust: self.wanted = false;
}
    // `ToastInstance.update` with `NowPlayingToast.update`. `ToastManager`
    // plays no visibility sound for this toast.
update :: proc(self: ^Self, song_playing: bool, notes: ^MusicNotes) {
}
    // rust: let (update_toast, multiplier) = (self.update_toast, self.multiplier);
    // rust: let wanted = &mut self.wanted;
    // rust: let (_, finished) = self.slide.update_now(|fully| {
    // rust: if update_toast {
    // rust: *wanted = (fully as f64) < 5000.0 * multiplier;
    // rust: if song_playing {
    // rust: notes.tick();
}
}
    // rust: *wanted
    // rust: });
    // rust: if finished && !self.finished {
    // rust: self.update_toast = false;
}
    // rust: self.finished = finished;
}
    // `ToastInstance.extractRenderState` with `Toast.xPos`: nothing once it
    // has slid out.
draw :: proc(self: ^Self, atlas: ^HudAtlas, batch: ^HudBatch, song: string, notes: ^MusicNotes) {
}
    // rust: if self.finished {
    // rust: return;
}
    // rust: let width = Self::width(atlas, song);
    // rust: draw_now_playing(
    // rust: atlas,
    // rust: batch,
    // rust: width * self.slide.portion - width,
    // rust: song,
    // rust: notes.color,
    // rust: );
}
    // `NowPlayingToast.getWidth`.
width :: proc(atlas: ^HudAtlas, song: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 30.0 + HudBatch::text_width(atlas, song).ceil() + 7.0
}
}
// `NowPlayingToast.extractToast` at `x` on the top row: the background, the
// music notes in `notes` (ARGB) and the song's name in light grey.
draw_now_playing :: proc(atlas: ^HudAtlas, batch: ^HudBatch, x: f32, song: string, notes: u32) {
}
    // rust: let width = NowPlayingToast::width(atlas, song);
    // `toast/now_playing`: a nine slice of 160 by 32 with a border of 4, here 30 high.
    // rust: if let Some(rect) = atlas.sprites.get("gui/sprites/toast/now_playing").copied() {
    // rust: let (du, dv) = (
    // rust: (rect.u1 - rect.u0) / rect.w as f32,
    // rust: (rect.v1 - rect.v0) / rect.h as f32,
    // rust: );
    // rust: let source_x = [0.0, 4.0, rect.w as f32 - 4.0, rect.w as f32];
    // rust: let source_y = [0.0, 4.0, rect.h as f32 - 4.0, rect.h as f32];
    // rust: let target_x = [x, x + 4.0, x + width - 4.0, x + width];
    // rust: let target_y = [0.0, 4.0, 26.0, 30.0];
    // rust: for row in 0..3 {
    // rust: for col in 0..3 {
    // rust: let piece = crate::hud::Rect {
    // rust: u0: rect.u0 + source_x[col] * du,
    // rust: u1: rect.u0 + source_x[col + 1] * du,
    // rust: v0: rect.v0 + source_y[row] * dv,
    // rust: v1: rect.v0 + source_y[row + 1] * dv,
    // rust: ..rect
}
    // rust: batch.rect_uv(
    // rust: target_x[col],
    // rust: target_y[row],
    // rust: target_x[col + 1] - target_x[col],
    // rust: target_y[row + 1] - target_y[row],
    // rust: piece,
    // rust: u32::MAX,
    // rust: );
}
}
}
    // rust: if let Some(rect) = atlas.sprites.get("gui/sprites/icon/music_notes").copied() {
    // rust: batch.rect_uv(
    // rust: x + 7.0,
    // rust: 7.0,
    // rust: 16.0,
    // rust: 16.0,
    // rust: rect,
    // rust: crate::mobs::render::abgr(notes & 0x00FF_FFFF),
    // rust: );
}
    // DyeColor.LIGHT_GRAY.getTextColor, at 15 - 9 / 2.
    // rust: batch.text(atlas, song, x + 30.0, 11.0, 0xFFD3_D3D3, true);
}
