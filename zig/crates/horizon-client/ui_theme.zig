//! Transpiled from Horizon Rust crate
//! Module: horizon-client_ui_theme
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The design system's widgets drawn in the game (`crates/horizon-theme`:
//! palette, type scale, radii, control sizes, motion and the bundled fonts;
//! `docs/design-system.md`). Every menu is vanilla's (`ui`); what is left
//! here draws Horizon's own overlays that vanilla has no screen for: the
//! on-screen keyboard a controller types with (`osk`), plus the
//! `horizon.txt` preferences.
//!
//! Build a [`Ui`] over the frame's `HudBatch` with [`Ui::new`], lay out in dp
//! (the launcher's logical pixels) and give every interactive widget a stable
//! `id`. Clicks run the same layout with [`Ui::dry`] and read [`Ui::hit`]: one
//! function draws and hit-tests, so they never disagree.
// use crate::hud::{HudAtlas, HudBatch, Rect};
// use ab_glyph::{Font as _, FontRef, PxScale, ScaleFont as _};
// use std::{cell::RefCell, collections::HashMap, path::Path};

/// A Horizon-only preference from `horizon.txt` beside `options.txt`
/// (`key:value` lines), so vanilla's options file stays exactly as vanilla
/// writes it.
pub fn preference(dir: *Path, key: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = std::fs::read_to_string(dir.join("horizon.txt")).ok()?;
    // rust: text.lines().find_map(|l| {
    // rust: let (k, v) = l.split_once(':')?;
    // rust: (k.trim() == key).then(|| v.trim().to_owned())
    // rust: })
}
/// Set (or with None remove) one preference, keeping the others.
    // rust: pub(crate) fn set_preference(dir: &Path, key: &str, value: Option<&str>) {
    // rust: let text = std::fs::read_to_string(dir.join("horizon.txt")).unwrap_or_default();
    // rust: let mut lines: Vec<String> = text
    // rust: .lines()
    // rust: .filter(|l| l.split_once(':').is_none_or(|(k, _)| k.trim() != key))
    // rust: .map(str::to_owned)
    // rust: .collect();
    // rust: if let Some(v) = value {
    // rust: lines.push(format!("{key}:{v}"));
}
    // rust: let mut out = lines.join("\n");
    // rust: out.push('\n');
    // rust: let _ = std::fs::write(dir.join("horizon.txt"), out);
}

/// The dark palette (`horizon_theme::DARK`) in the HUD's colour encoding, plus the
/// translucent plates the overlays draw over the game.
    // rust: pub(crate) mod color {
//     use horizon_theme::DARK as P;
    // rust: pub const fn hex(c: u32, a: u8) -> u32 {
    // rust: (a as u32) << 24 | (c & 0xff) << 16 | (c >> 8 & 0xff) << 8 | (c >> 16 & 0xff)
}
    /// The page, under every veil.
pub const BG: u32 = hex(P.page, 255);
    /// Hover plates, secondary buttons, fields, the segmented track: the
    /// dark palette's soft plate, as ink over the veil so the plates read the
    /// same over any backdrop (over the page colour they are `plate_soft`).
pub const RAISED: u32 = hex(P.ink, 20);
    /// Pressed plates and a switch that is off (`plate`, the same way).
pub const HOVER: u32 = hex(P.ink, 36);
    /// One-pixel rules between rows, slider tracks.
pub const BORDER: u32 = hex(P.rule, 255);
    /// Text and selection (`ink`).
pub const TEXT: u32 = hex(P.ink, 255);
    /// Values and secondary text (`ink_soft`).
pub const MUTED: u32 = hex(P.ink_soft, 255);
pub const ACCENT: u32 = hex(P.accent, 255);
pub const ON_ACCENT: u32 = hex(P.on_accent, 255);
    // rust: pub(crate) fn with_alpha(c: u32, a: f32) -> u32 {
    // rust: let base = (c >> 24) as f32;
    // rust: (c & 0x00ff_ffff) | ((base * a.clamp(0.0, 1.0)).round() as u32) << 24
}
}

/// The launcher's type scale and shapes (`horizon_theme`), in dp.
    // rust: pub(crate) const SMALL: f32 = horizon_theme::CAPTION.px;
    // rust: pub(crate) const BODY: f32 = horizon_theme::LABEL.px;
/// The boot screen's wordmark (`DISPLAY`) and console lines (`MICRO`).
    // rust: pub(crate) const DISPLAY: f32 = horizon_theme::DISPLAY.px;
    // rust: pub(crate) const MICRO: f32 = horizon_theme::MICRO.px;
/// Fields; plates (hover rows, selection); pills (buttons, segments).
    // rust: pub(crate) const RADIUS: f32 = horizon_theme::RADIUS;
    // rust: pub(crate) const RADIUS_PLATE: f32 = horizon_theme::RADIUS_PLATE;

    // rust: pub(crate) enum Face {
    // rust: Regular,
    // rust: Medium,
    /// The wordmark and page titles (the design system's 500).
    // rust: SemiBold,
    /// Counts, timestamps and the boot screen's console lines.
    // rust: Mono,
}
pub const Fonts = struct {
    faces: [FontRef<'static>,
};
    // rust: impl Fonts {
pub fn load() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = |b: &'static [u8]| FontRef::try_from_slice(b).expect("bundled font");
    // rust: Self {
    // rust: faces: [
    // rust: f(horizon_theme::fonts::GEIST_REGULAR),
    // rust: f(horizon_theme::fonts::GEIST_MEDIUM),
    // rust: f(horizon_theme::fonts::GEIST_SEMIBOLD),
    // rust: f(horizon_theme::fonts::GEIST_MONO),
    // rust: ],
}
}
pub fn face(self: *Self, f: Face) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.faces[f as usize]
}
    /// The ab_glyph scale for an em size in pixels.
pub fn scale(self: *Self, f: Face, px: f32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let font = self.face(f);
    // rust: let upem = font.units_per_em().unwrap_or(1000.0);
    // rust: PxScale::from(px * font.height_unscaled() / upem)
}
}
pub const Key = enum {
    Glyph(Face, u16, u16),
    /// A quarter disc (`false`) or a 1px quarter ring of this radius in pixels.
    Corner(u16, bool),
};
pub const Cached = struct {
    rect: ?Rect,
    /// Offset of the bitmap from the pen (glyphs) in pixels.
    left: f32,
    top: f32,
};
/// Glyphs and corner masks rasterized into the atlas region `horizon/ui-text`.
pub const Cache = struct {
    fonts: Fonts,
    entries: HashMap<Key,
    shelf: (u32,
    pending: std.ArrayList(crate::font::Patch),
    /// The atlas the entries were uploaded to (a new atlas starts over).
    atlas: usize,
};
    // rust: thread_local! {
pub const CACHE: RefCell<?Cache> = const { RefCell::new(None) };
}
/// Reloaded atlases can occupy the same address with empty run-time slots.
pub fn reset_atlas() void {
}
    // rust: CACHE.with(|cache| *cache.borrow_mut() = None);
}
    // rust: fn with_cache<R>(atlas: &HudAtlas, f: impl FnOnce(&mut Cache) -> R) -> R {
    // rust: CACHE.with(|c| {
    // rust: let mut c = c.borrow_mut();
    // rust: let id = atlas as *const HudAtlas as usize;
    // rust: let cache = c.get_or_insert_with(|| Cache {
    // rust: fonts: Fonts::load(),
    // rust: entries: HashMap::new(),
    // rust: shelf: (0, 0, 0),
    // rust: pending: Vec::new(),
    // rust: atlas: id,
    // rust: });
    // rust: if cache.atlas != id {
    // rust: cache.atlas = id;
    // rust: cache.entries.clear();
    // rust: cache.shelf = (0, 0, 0);
    // rust: cache.pending.clear();
}
    // rust: f(cache)
    // rust: })
}
    // rust: impl Cache {
pub fn region(atlas: *HudAtlas) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: atlas.sprites.get("horizon/ui-text").copied()
}
    /// Reserve `w x h` pixels; on overflow forget everything and start over.
pub fn place(self: *Self, atlas: *HudAtlas, w: u32, h: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let region = Self::region(atlas)?;
    // rust: let (mut x, mut y, mut row) = self.shelf;
    // rust: if x + w + 1 > region.w {
    // rust: x = 0;
    // rust: y += row + 1;
    // rust: row = 0;
}
    // rust: if y + h > region.h || w > region.w {
    // rust: self.entries.clear();
    // rust: self.shelf = (0, 0, 0);
    // rust: return None;
}
    // rust: self.shelf = (x + w + 1, y, row.max(h));
    // rust: Some((x, y, region))
}
pub fn upload(self: *Self, atlas: *HudAtlas, w: u32, h: u32, alpha: *[f32]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, y, region) = self.place(atlas, w, h)?;
    // rust: let (ax, ay) = (
    // rust: (region.u0 * atlas.width as f32).round() as u32 + x,
    // rust: (region.v0 * atlas.height as f32).round() as u32 + y,
    // rust: );
    // rust: let rgba = alpha
    // rust: .iter()
    // rust: .flat_map(|a| [255, 255, 255, (a.clamp(0.0, 1.0) * 255.0).round() as u8])
    // rust: .collect();
    // rust: self.pending.push(crate::font::Patch {
    // rust: x: ax,
    // rust: y: ay,
    // rust: width: w,
    // rust: height: h,
    // rust: rgba,
    // rust: });
    // rust: let (aw, ah) = (atlas.width as f32, atlas.height as f32);
    // rust: Some(Rect {
    // rust: u0: ax as f32 / aw,
    // rust: v0: ay as f32 / ah,
    // rust: u1: (ax + w) as f32 / aw,
    // rust: v1: (ay + h) as f32 / ah,
    // rust: w,
    // rust: h,
    // rust: })
}
pub fn glyph(self: *Self, atlas: *HudAtlas, face: Face, id: ab_glyph::GlyphId, px: f32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = (px * 4.0).round() as u16;
    // rust: let key = Key::Glyph(face, id.0, size);
    // rust: if let Some(c) = self.entries.get(&key) {
    // rust: return *c;
}
    // rust: let scale = self.fonts.scale(face, f32::from(size) / 4.0);
    // rust: let glyph = id.with_scale_and_position(scale, ab_glyph::point(0.0, 0.0));
    // rust: let made = match self.fonts.face(face).outline_glyph(glyph) {
    // rust: Some(outline) => {
    // rust: let b = outline.px_bounds();
    // rust: let (w, h) = (b.width() as u32, b.height() as u32);
    // rust: let mut alpha = vec![0.0; (w * h) as usize];
    // rust: outline.draw(|x, y, c| {
    // rust: if x < w && y < h {
    // rust: alpha[(y * w + x) as usize] = c;
}
    // rust: });
                // Light text on dark backgrounds reads thin: a gentle boost.
    // rust: for a in &mut alpha {
    // rust: *a = a.powf(0.85);
}
    // rust: Cached {
    // rust: rect: self.upload(atlas, w, h, &alpha),
    // rust: left: b.min.x,
    // rust: top: b.min.y,
}
}
    // rust: None => Cached {
    // rust: rect: None,
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: },
}
    // rust: if made.rect.is_some() || made.left == 0.0 {
    // rust: self.entries.insert(key, made);
}
    // rust: made
}
pub fn corner(self: *Self, atlas: *HudAtlas, r: u16, ring: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = Key::Corner(r, ring);
    // rust: if let Some(c) = self.entries.get(&key) {
    // rust: return c.rect;
}
        // The top-left quadrant of a circle centred at (r, r), 4x4 supersampled.
    // rust: let n = u32::from(r);
    // rust: let rf = f32::from(r);
    // rust: let mut alpha = vec![0.0; (n * n) as usize];
    // rust: for y in 0..n {
    // rust: for x in 0..n {
    // rust: let mut hits = 0;
    // rust: for sy in 0..4 {
    // rust: for sx in 0..4 {
    // rust: let px = x as f32 + (sx as f32 + 0.5) / 4.0;
    // rust: let py = y as f32 + (sy as f32 + 0.5) / 4.0;
    // rust: let d = ((px - rf).powi(2) + (py - rf).powi(2)).sqrt();
    // rust: if d <= rf && (!ring || d >= rf - 1.0) {
    // rust: hits += 1;
}
}
}
    // rust: alpha[(y * n + x) as usize] = hits as f32 / 16.0;
}
}
    // rust: let rect = self.upload(atlas, n, n, &alpha);
    // rust: if rect.is_some() {
    // rust: self.entries.insert(
    // rust: key,
    // rust: Cached {
    // rust: rect,
    // rust: left: 0.0,
    // rust: top: 0.0,
    // rust: },
    // rust: );
}
    // rust: rect
}
}

/// One frame of design-system drawing, in dp: the
/// launcher's logical pixels, scaled so the screen reads like the launcher's
/// 1040x700 window at any size.
pub const Ui = struct {
    atlas: *'a HudAtlas,
    batch: *'a mut HudBatch,
    /// The screen in dp.
    w: f32,
    h: f32,
    /// The cursor in dp.
    cursor: (f32,
    /// Physical pixels per dp.
    density: f32,
    scale: f32,
};
    // rust: impl<'a> Ui<'a> {
    /// `cursor` is in GUI pixels, like every screen's input.
pub fn new(atlas: *'a HudAtlas, batch: *'a mut HudBatch, cursor: (f32) void {
}
    // rust: let scale = batch.scale;
    // rust: let (pw, ph) = (batch.width * scale, batch.height * scale);
    // rust: let density = (pw / 1040.0).min(ph / 700.0).clamp(1.0, 4.0);
    // rust: Self {
    // rust: atlas,
    // rust: w: pw / density,
    // rust: h: ph / density,
    // rust: cursor: (cursor.0 * scale / density, cursor.1 * scale / density),
    // rust: density,
    // rust: scale,
    // rust: batch,
}
}
    /// Move rasterized glyphs into the batch's atlas uploads (real frames only).
pub fn finish(self: *Self) void {
}
    // rust: let pending = with_cache(self.atlas, |c| std::mem::take(&mut c.pending));
    // rust: self.batch.patches.extend(pending);
}

    // ---- geometry, snapped to physical pixels ----
pub fn px_x(self: *Self, v: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (v * self.density).round()
}
pub fn px_y(self: *Self, v: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (v * self.density).round()
}
pub fn raw_fill(self: *Self, x0: f32, y0: f32, x1: f32, y1: f32, color: u32) void {
}
    // rust: if x1 > x0 && y1 > y0 {
    // rust: let s = self.scale;
    // rust: self.batch.fill(
    // rust: self.atlas,
    // rust: x0 / s,
    // rust: y0 / s,
    // rust: (x1 - x0) / s,
    // rust: (y1 - y0) / s,
    // rust: color,
    // rust: );
}
}
pub fn corner_quad(self: *Self, rect: Rect, x: f32, y: f32, r: f32, flip: (bool) void {
}
    // rust: let (u0, u1) = if flip.0 {
    // rust: (rect.u1, rect.u0)
    // rust: } else {
    // rust: (rect.u0, rect.u1)
}
    // rust: let (v0, v1) = if flip.1 {
    // rust: (rect.v1, rect.v0)
    // rust: } else {
    // rust: (rect.v0, rect.v1)
}
    // rust: let s = self.scale;
    // rust: let (gx, gy, gr) = (x / s, y / s, r / s);
    // rust: self.batch.quad(
    // rust: [[gx, gy], [gx + gr, gy], [gx + gr, gy + gr], [gx, gy + gr]],
    // rust: [[u0, v0], [u1, v0], [u1, v1], [u0, v1]],
    // rust: color,
    // rust: );
}
pub fn corners(self: *Self, x0: f32, y0: f32, x1: f32, y1: f32, r: f32, ring: bool, color: u32) void {
}
    // rust: if r < 1.0 {
    // rust: return;
}
    // rust: let atlas = self.atlas;
    // rust: if let Some(rect) = with_cache(atlas, |c| c.corner(atlas, r as u16, ring)) {
    // rust: self.corner_quad(rect, x0, y0, r, (false, false), color);
    // rust: self.corner_quad(rect, x1 - r, y0, r, (true, false), color);
    // rust: self.corner_quad(rect, x1 - r, y1 - r, r, (true, true), color);
    // rust: self.corner_quad(rect, x0, y1 - r, r, (false, true), color);
}
}
    /// A filled rectangle with rounded corners.
    // rust: pub(crate) fn rounded(&mut self, x: f32, y: f32, w: f32, h: f32, radius: f32, color: u32) {
    // rust: if color >> 24 == 0 {
    // rust: return;
}
    // rust: let (x0, y0, x1, y1) = (
    // rust: self.px_x(x),
    // rust: self.px_y(y),
    // rust: self.px_x(x + w),
    // rust: self.px_y(y + h),
    // rust: );
    // rust: let r = (radius * self.density)
    // rust: .round()
    // rust: .min(((x1 - x0) / 2.0).floor())
    // rust: .min(((y1 - y0) / 2.0).floor())
    // rust: .max(0.0);
    // rust: if r < 1.0 {
    // rust: self.raw_fill(x0, y0, x1, y1, color);
    // rust: return;
}
    // rust: self.raw_fill(x0 + r, y0, x1 - r, y1, color);
    // rust: self.raw_fill(x0, y0 + r, x0 + r, y1 - r, color);
    // rust: self.raw_fill(x1 - r, y0 + r, x1, y1 - r, color);
    // rust: self.corners(x0, y0, x1, y1, r, false, color);
}
    /// A 1px rounded border.
    // rust: pub(crate) fn border(&mut self, x: f32, y: f32, w: f32, h: f32, radius: f32, color: u32) {
    // rust: if color >> 24 == 0 {
    // rust: return;
}
    // rust: let (x0, y0, x1, y1) = (
    // rust: self.px_x(x),
    // rust: self.px_y(y),
    // rust: self.px_x(x + w),
    // rust: self.px_y(y + h),
    // rust: );
    // rust: let r = (radius * self.density)
    // rust: .round()
    // rust: .min(((x1 - x0) / 2.0).floor())
    // rust: .min(((y1 - y0) / 2.0).floor())
    // rust: .max(0.0);
    // rust: self.raw_fill(x0 + r, y0, x1 - r, y0 + 1.0, color);
    // rust: self.raw_fill(x0 + r, y1 - 1.0, x1 - r, y1, color);
    // rust: self.raw_fill(x0, y0 + r, x0 + 1.0, y1 - r, color);
    // rust: self.raw_fill(x1 - 1.0, y0 + r, x1, y1 - r, color);
    // rust: self.corners(x0, y0, x1, y1, r, true, color);
}

    // ---- text ----
    /// The advance of `text` in dp.
    // rust: pub(crate) fn measure(&self, face: Face, size: f32, text: &str) -> f32 {
    // rust: let px = (size * self.density * 4.0).round() / 4.0;
    // rust: with_cache(self.atlas, |c| {
    // rust: let font = c.fonts.face(face);
    // rust: let scaled = font.as_scaled(c.fonts.scale(face, px));
    // rust: let mut w = 0.0;
    // rust: let mut prev = None;
    // rust: for ch in text.chars() {
    // rust: let id = font.glyph_id(ch);
    // rust: if let Some(p) = prev {
    // rust: w += scaled.kern(p, id);
}
    // rust: w += scaled.h_advance(id);
    // rust: prev = Some(id);
}
    // rust: w / self.density
    // rust: })
}
    /// Draw a line of text in a `line`-tall box whose top is `y` (the
    /// launcher's line heights: about 1.45 × size for the interface);
    /// returns its width in dp.
    // rust: pub(crate) fn text_line(
    // rust: &mut self,
    // rust: face: Face,
    // rust: size: f32,
    // rust: line: f32,
    // rust: x: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: text: &str,
    // rust: ) -> f32 {
    // rust: let px = (size * self.density * 4.0).round() / 4.0;
    // rust: let real = color >> 24 != 0;
    // rust: let (x0, y0) = (self.px_x(x), self.px_y(y));
    // rust: let box_px = line * self.density;
    // rust: let atlas = self.atlas;
    // rust: let density = self.density;
    // rust: let mut quads = Vec::new();
    // rust: let width = with_cache(atlas, |c| {
    // rust: let scale = c.fonts.scale(face, px);
    // rust: let (ascent, descent) = {
    // rust: let f = c.fonts.face(face).as_scaled(scale);
    // rust: (f.ascent(), f.descent())
}
    // rust: let baseline = y0 + ((box_px - (ascent - descent)) / 2.0 + ascent).round();
    // rust: let mut pen = x0;
    // rust: let mut prev = None;
    // rust: for ch in text.chars() {
    // rust: let (id, advance, kern) = {
    // rust: let font = c.fonts.face(face);
    // rust: let id = font.glyph_id(ch);
    // rust: let f = font.as_scaled(scale);
    // rust: (id, f.h_advance(id), prev.map_or(0.0, |p| f.kern(p, id)))
}
    // rust: pen += kern;
    // rust: if real && !ch.is_whitespace() {
    // rust: let g = c.glyph(atlas, face, id, px);
    // rust: if let Some(rect) = g.rect {
    // rust: quads.push(((pen + g.left).round(), baseline + g.top, rect));
}
}
    // rust: pen += advance;
    // rust: prev = Some(id);
}
    // rust: (pen - x0) / density
    // rust: });
    // rust: let s = self.scale;
    // rust: for (gx, gy, rect) in quads {
    // rust: self.batch.rect_uv(
    // rust: gx / s,
    // rust: gy / s,
    // rust: rect.w as f32 / s,
    // rust: rect.h as f32 / s,
    // rust: rect,
    // rust: color,
    // rust: );
}
    // rust: width
}
    /// Text in a `1.45 × size` line box whose top is `y`.
    // rust: pub(crate) fn text(
    // rust: &mut self,
    // rust: face: Face,
    // rust: size: f32,
    // rust: x: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: text: &str,
    // rust: ) -> f32 {
    // rust: self.text_line(face, size, (size * 1.45).round(), x, y, color, text)
}
    // rust: pub(crate) fn text_centered(
    // rust: &mut self,
    // rust: face: Face,
    // rust: size: f32,
    // rust: cx: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: text: &str,
    // rust: ) {
    // rust: let w = self.measure(face, size, text);
    // rust: self.text(face, size, cx - w / 2.0, y, color, text);
}

    // ---- the launcher's components ----
}

// ---- the boot screen ----

/// The boot screen's palette on the pure black: a white wordmark and dimmed
/// console lines (the theme's ink is for light pages).
pub const BOOT_TEXT: u32 = color::hex(0xFFFFFF, 255);
pub const BOOT_LOG: u32 = color::hex(0x9BA1A6, 255);

/// The boot screen while the menu is not ready yet: the wordmark centred on
/// pure black and the console's last lines at the bottom right, as the
/// terminal prints them.
pub fn draw_boot(atlas: *HudAtlas, batch: *mut HudBatch, logs: *[[]const u8]) void {
}
    // Pure black under everything: the frame's panorama (the title artwork
    // once the bundle is in) must not leak through.
    // rust: batch.fill(
    // rust: atlas,
    // rust: 0.0,
    // rust: 0.0,
    // rust: batch.width,
    // rust: batch.height,
    // rust: color::hex(0x000000, 255),
    // rust: );
    // rust: wordmark(atlas, batch);
    // rust: draw_boot_log(atlas, batch, logs);
}

/// The wordmark with its tagline, centred.
pub fn wordmark(atlas: *HudAtlas, batch: *mut HudBatch) void {
}
    // rust: let mut ui = Ui::new(atlas, batch, (0.0, 0.0));
    // rust: let size = (ui.w / 16.0).clamp(DISPLAY, 96.0);
    // rust: let small = (size * 0.25).clamp(MICRO, 18.0);
    // rust: let block = size * 1.45 + small * 0.6 + small * 1.5;
    // rust: let top = (ui.h - block) / 2.0;
    // rust: ui.text_centered(Face::SemiBold, size, ui.w / 2.0, top, BOOT_TEXT, "Horizon");
    // rust: ui.text_centered(
    // rust: Face::Mono,
    // rust: small,
    // rust: ui.w / 2.0,
    // rust: top + size * 1.45 + small * 0.6,
    // rust: BOOT_LOG,
    // rust: "Rust based minecraft client",
    // rust: );
    // rust: ui.finish();
}

/// The console's last lines at the bottom left, over any loading screen: long
/// lines wrap word-wise, the block grows upwards.
pub fn draw_boot_log(atlas: *HudAtlas, batch: *mut HudBatch, logs: *[[]const u8]) void {
}
    // rust: if logs.is_empty() {
    // rust: return;
}
    // rust: let mut ui = Ui::new(atlas, batch, (0.0, 0.0));
    // rust: let (size, line, pad) = (MICRO, MICRO * 1.5, 16.0);
    // rust: let max_w = ui.w / 2.0;
    // rust: let max_rows = (((ui.h - pad) / line) as usize).clamp(1, 24);
    // rust: let mut y = ui.h - pad - line;
    // rust: let mut drawn = 0;
    // rust: 'lines: for text in logs.iter().rev() {
    // rust: let chunks = wrapping_lines(&ui, Face::Mono, size, text, max_w);
    // rust: for chunk in chunks.iter().rev() {
    // rust: if drawn == max_rows {
    // rust: break 'lines;
}
    // rust: ui.text(Face::Mono, size, pad, y, BOOT_LOG, chunk);
    // rust: y -= line;
    // rust: drawn += 1;
}
}
    // rust: ui.finish();
}

/// The lines `text` wraps into at `max_w`, word-wise; a word wider than
/// `max_w` on its own breaks at the edge.
pub fn wrapping_lines(ui: *Ui, face: Face, size: f32, text: []const u8, max_w: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut lines = Vec::new();
    // rust: let mut line = String::new();
    // rust: for word in text.split(' ') {
    // rust: let mut word = word;
    // rust: loop {
    // rust: let candidate = if line.is_empty() {
    // rust: word.to_owned()
    // rust: } else {
    // rust: format!("{line} {word}")
}
    // rust: if ui.measure(face, size, &candidate) <= max_w {
    // rust: line = candidate;
    // rust: break;
}
    // rust: if line.is_empty() {
                // The word alone does not fit: hard-break it at the edge.
    // rust: let mut end = 0;
    // rust: for (i, ch) in word.char_indices() {
    // rust: if i > 0 && ui.measure(face, size, &word[..i]) > max_w {
    // rust: break;
}
    // rust: end = i + ch.len_utf8();
}
    // rust: lines.push(word[..end].to_owned());
    // rust: word = &word[end..];
    // rust: } else {
    // rust: lines.push(std::mem::take(&mut line));
}
}
}
    // rust: if !line.is_empty() {
    // rust: lines.push(line);
}
    // rust: lines
}

    // rust: mod tests {
//     use super::*;

pub fn atlas_reload_regenerates_text_and_corners_at_the_same_address() void {
}
    // rust: let atlas = HudAtlas::build(Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: reset_atlas();
    // rust: let draw = |cache: &mut Cache| {
    // rust: let glyph = cache.fonts.face(Face::Regular).glyph_id('A');
    // rust: assert!(
    // rust: cache
    // rust: .glyph(&atlas, Face::Regular, glyph, 16.0)
    // rust: .rect
    // rust: .is_some()
    // rust: );
    // rust: assert!(cache.corner(&atlas, 8, false).is_some());
    // rust: std::mem::take(&mut cache.pending)
}
    // rust: let before = with_cache(&atlas, draw);
    // rust: assert_eq!(before.len(), 2);
    // rust: assert!(with_cache(&atlas, draw).is_empty());
    // rust: reset_atlas();
    // rust: let after = with_cache(&atlas, draw);
    // rust: assert_eq!(after.len(), 2);
    // rust: for (a, b) in before.iter().zip(&after) {
    // rust: assert_eq!((a.x, a.y, a.width, a.height), (b.x, b.y, b.width, b.height));
    // rust: assert_eq!(a.rgba, b.rgba);
}
    // rust: reset_atlas();
}

pub fn the_boot_atlas_holds_the_run_time_glyph_region_without_a_pack() void {
}
    // rust: let atlas = HudAtlas::boot();
    // rust: assert_eq!((atlas.width, atlas.height), (1024, 1024));
    // rust: assert_eq!(
    // rust: atlas.sprites["horizon/ui-text"].texels((atlas.width, atlas.height)),
    // rust: (1024, 512)
    // rust: );
    // rust: assert_eq!(
    // rust: atlas.sprites["horizon/white"].texels((atlas.width, atlas.height)),
    // rust: (4, 4)
    // rust: );
}

pub fn the_boot_screen_centres_the_wordmark_and_left_aligns_the_console() void {
}
    // rust: reset_atlas();
    // rust: let atlas = HudAtlas::boot();
    // rust: let mut batch = HudBatch::new([1280, 720]);
    // rust: draw_boot(&atlas, &mut batch, &[]);
        // The first quad is the pure black backdrop over the frame's panorama.
    // rust: let (w, h) = (batch.width, batch.height);
    // rust: let bg = &batch.vertices[..6];
    // rust: assert!(bg.iter().all(|v| v.color == 0xFF00_0000));
    // rust: assert!(bg.iter().all(|v| v.pos[0] == 0.0 || v.pos[0] == w));
    // rust: assert!(bg.iter().all(|v| v.pos[1] == 0.0 || v.pos[1] == h));
    // rust: assert!(
    // rust: !batch.patches.is_empty(),
    // rust: "the glyphs are queued for the atlas"
    // rust: );

    // rust: let mut batch = HudBatch::new([1280, 720]);
    // rust: wordmark(&atlas, &mut batch);
    // rust: let (min, max) = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| v.pos[0])
    // rust: .fold((f32::MAX, f32::MIN), |(a, b), x| (a.min(x), b.max(x)));
    // rust: assert!(
    // rust: min < batch.width / 2.0 && max > batch.width / 2.0,
    // rust: "the wordmark straddles the centre"
    // rust: );
    // rust: assert!(((min + max) / 2.0 - batch.width / 2.0).abs() < 1.0);

    // rust: let long = "[12:34:56] [Render thread/INFO]: Horizon: resources loaded in 1.0s; 1240 block states, 1500 items, 62 biomes; 8 worker threads".to_owned();
    // rust: let mut batch = HudBatch::new([1280, 720]);
    // rust: draw_boot_log(&atlas, &mut batch, &[long]);
    // rust: let (min, max) = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| v.pos[0])
    // rust: .fold((f32::MAX, f32::MIN), |(a, b), x| (a.min(x), b.max(x)));
    // rust: assert!(min >= 4.0, "the line stays inside the left inset");
    // rust: assert!(
    // rust: max - min <= batch.width / 2.0 + 1.0,
    // rust: "a too wide line is cut to half the screen"
    // rust: );

    // rust: let mut batch = HudBatch::new([1280, 720]);
    // rust: let ui = Ui::new(&atlas, &mut batch, (0.0, 0.0));
    // rust: let lines = wrapping_lines(
    // rust: &ui,
    // rust: Face::Mono,
    // rust: MICRO,
    // rust: "the quick brown fox jumps over the lazy dog",
    // rust: 90.0,
    // rust: );
    // rust: assert!(lines.len() > 1, "a long line wraps");
    // rust: assert!(
    // rust: lines
    // rust: .iter()
    // rust: .all(|l| ui.measure(Face::Mono, MICRO, l) <= 90.0),
    // rust: "every wrapped line fits"
    // rust: );
    // rust: assert_eq!(
    // rust: lines
    // rust: .iter()
    // rust: .map(|l| l.split_whitespace().count())
    // rust: .sum::<usize>(),
    // rust: 9,
    // rust: "the wrap keeps every word"
    // rust: );

    // rust: let mut batch = HudBatch::new([1280, 720]);
    // rust: draw_boot_log(&atlas, &mut batch, &[]);
    // rust: assert!(batch.vertices.is_empty() && batch.patches.is_empty());
    // rust: reset_atlas();
}
}
