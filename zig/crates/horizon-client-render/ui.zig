//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_ui
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Shared GUI widgets drawn as HUD quads: nine-slice sprites (gui.scaling
//! metadata), buttons, sliders, tiled menu backgrounds, separators and the
//! EditBox text field with vanilla cursor, selection and scrolling.
// use crate::{
    // rust: hud::{HudAtlas, HudBatch, Rect, rgba},
    // rust: text::Text,
}
// use std::{
    // rust: collections::HashMap,
    // rust: path::{Path, PathBuf},
    // rust: sync::RwLock,
    // rust: time::Instant,
}

/// `GuiSpriteScaling.NineSlice`: the sprite's size in GUI pixels, whatever
/// its texture's resolution, its borders (left, top, right, bottom) in the
/// same units, and whether the edges and centre stretch rather than tile.
pub const NineSlice = struct {
    width: u32,
    height: u32,
    border: [u32,
    stretch_inner: bool,
};
/// Nine-slice scaling from `.png.mcmeta` files.
pub const NINE_SLICE: RwLock<?std.AutoHashMap([]const u8, NineSlice)> = RwLock::new(None);

/// A `gui.scaling` section of type `nine_slice`.
pub fn parse_nine_slice(v: *serde_json::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = &v["gui"]["scaling"];
    // rust: if s["type"] != "nine_slice" {
    // rust: return None;
}
    // rust: let size = |k: &str| s[k].as_u64().map(|n| n as u32);
    // rust: let border = &s["border"];
    // rust: let border = if let Some(n) = border.as_u64() {
    // rust: [n as u32; 4]
    // rust: } else {
    // rust: let g = |k: &str| border[k].as_u64().unwrap_or(0) as u32;
    // rust: [g("left"), g("top"), g("right"), g("bottom")]
}
    // rust: let (width, height) = (size("width")?, size("height")?);
    // `NineSlice.validate`: borders that meet leave no centre slice, so the
    // sprite has no nine-slice metadata (vanilla draws it as a stretch).
    // rust: let [l, t, r, b] = border;
    // rust: if l.saturating_add(r) >= width || t.saturating_add(b) >= height {
    // rust: return None;
}
    // rust: Some(NineSlice {
    // rust: width,
    // rust: height,
    // rust: border,
    // rust: stretch_inner: s["stretch_inner"].as_bool().unwrap_or(false),
    // rust: })
}
/// Read `gui.scaling` metadata for every GUI sprite under `root`.
pub fn load_metadata(root: *Path) void {
}
    // rust: set_metadata(read_metadata(root));
}
/// The GUI sprites' nine-slice metadata of a resource root, read off the
/// render thread by a pack reload ([`read_metadata`]) and put in use with
/// [`set_metadata`].
pub const UiMetadata = struct {};
/// Puts read metadata in use ([`load_metadata`] in two halves).
pub fn set_metadata(metadata: UiMetadata) void {
}
    // rust: *NINE_SLICE.write().unwrap_or_else(|e| e.into_inner()) = Some(metadata.0);
}
/// Reads the metadata [`load_metadata`] puts in use, without putting it in use.
pub fn read_metadata(root: *Path) U {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut map = HashMap::new();
    // rust: let base = root.join("assets/minecraft/textures");
    // rust: let sprites = base.join("gui/sprites");
    // A prepared root's: from its data file, without listing the disk.
    // rust: let files: Vec<PathBuf> = match horizon_core::prepared_files::files_under(&sprites) {
    // rust: Some(files) => files
    // rust: .iter()
    // rust: .filter(|file| file.ends_with(".png.mcmeta"))
    // rust: .map(|file| sprites.join(file))
    // rust: .collect(),
    // rust: None => {
    // rust: let mut files = Vec::new();
    // rust: let mut stack = vec![sprites];
    // rust: while let Some(dir) = stack.pop() {
    // rust: let Ok(entries) = std::fs::read_dir(&dir) else {
    // rust: continue;
}
    // rust: for e in entries.flatten() {
    // rust: let p = e.path();
    // rust: if p.is_dir() {
    // rust: stack.push(p);
    // rust: } else if p.to_string_lossy().ends_with(".png.mcmeta") {
    // rust: files.push(p);
}
}
}
    // rust: files
}
}
    // rust: for p in files {
    // rust: let name = p.to_string_lossy().into_owned();
    // rust: let Some(stripped) = name.strip_suffix(".png.mcmeta") else {
    // rust: continue;
}
    // rust: let Ok(text) = horizon_core::prepared_files::read_to_string(&p) else {
    // rust: continue;
}
    // rust: let Some(nine_slice) = serde_json::from_str(&text)
    // rust: .ok()
    // rust: .as_ref()
    // rust: .and_then(parse_nine_slice)
    // rust: else {
    // rust: continue;
}
    // rust: let key = Path::new(stripped)
    // rust: .strip_prefix(&base)
    // rust: .map(|r| r.to_string_lossy().replace('\\', "/"))
    // rust: .unwrap_or_default();
    // rust: map.insert(key, nine_slice);
}
    // rust: UiMetadata(map)
}
/// The sprite's nine-slice metadata, when its `.png.mcmeta` has any.
pub fn nine_slice_metadata(sprite: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NINE_SLICE
    // rust: .read()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .as_ref()
    // rust: .and_then(|m| m.get(sprite).copied())
}
/// The sprite's nine-slice metadata; without any (no resources loaded), its
/// GUI size and the widgets' usual borders.
pub fn scaling(sprite: []const u8, r: *Rect) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: nine_slice_metadata(sprite).unwrap_or(NineSlice {
    // rust: width: r.w,
    // rust: height: r.h,
    // rust: border: match sprite {
    // rust: "gui/sprites/widget/button"
    // rust: | "gui/sprites/widget/button_highlighted"
    // rust: | "gui/sprites/widget/button_disabled" => [3; 4],
    // rust: "gui/sprites/widget/slider_handle" | "gui/sprites/widget/slider_handle_highlighted" => {
    // rust: [2, 2, 2, 3]
}
    // rust: _ => [1; 4],
    // rust: },
    // rust: stretch_inner: false,
    // rust: })
}
/// The region `[x, y, w, h]` of a sprite `size` GUI pixels large, in its
/// own units (`TextureAtlasSprite.getU(x / width)`).
pub fn sub(r: Rect, size: [f32; 2], h]: [f32; 4]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (du, dv) = ((r.u1 - r.u0) / size[0], (r.v1 - r.v0) / size[1]);
    // rust: Rect {
    // rust: u0: r.u0 + x * du,
    // rust: v0: r.v0 + y * dv,
    // rust: u1: r.u0 + (x + w) * du,
    // rust: v1: r.v0 + (y + h) * dv,
    // rust: w: w as u32,
    // rust: h: h as u32,
}
}
/// `blitTiledSprite`: `src` (a region of a sprite `size` large, in its
/// units) repeated over `dst` from its top left, the last row and column cut.
pub fn tile(batch: *mut HudBatch, r: Rect, size: [f32; 2], src: [f32; 4], dst: [f32; 4], color: u32) void {
}
    // rust: let [sx, sy, sw, sh] = src;
    // rust: let [dx, dy, dw, dh] = dst;
    // rust: if sw <= 0.0 || sh <= 0.0 || dw <= 0.0 || dh <= 0.0 {
    // rust: return;
}
    // rust: let mut y = 0.0;
    // rust: while y < dh {
    // rust: let h = sh.min(dh - y);
    // rust: let mut x = 0.0;
    // rust: while x < dw {
    // rust: let w = sw.min(dw - x);
    // rust: batch.rect_uv(dx + x, dy + y, w, h, sub(r, size, [sx, sy, w, h]), color);
    // rust: x += sw;
}
    // rust: y += sh;
}
}
/// `GuiGraphicsExtractor.blitNineSlicedSprite`: the corners at their size,
/// the edges and centre tiled (or stretched with `stretch_inner`), all in
/// the sprite's `gui.scaling` units, so a high-resolution pack's sprite draws
/// as the default one does.
    // rust: pub fn nine_slice(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: sprite: &str,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: color: u32,
    // rust: ) {
    // rust: if let Some(r) = atlas.sprites.get(sprite) {
    // rust: draw_nine_slice(batch, *r, scaling(sprite, r), [x, y, w, h], color);
}
}
/// `GuiGraphicsExtractor.blitSprite`: a sprite over `w` × `h` as its
/// `gui.scaling` says, nine-sliced, or stretched when it has no metadata.
/// (`tile`, which no vanilla sprite uses, isn't read yet: it stretches.)
    // rust: pub fn blit_sprite(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: sprite: &str,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: color: u32,
    // rust: ) {
    // rust: if let Some(r) = atlas.sprites.get(sprite) {
    // rust: draw_sprite(batch, *r, nine_slice_metadata(sprite), [x, y, w, h], color);
}
}
    // rust: fn draw_sprite(
    // rust: batch: &mut HudBatch,
    // rust: r: Rect,
    // rust: nine_slice: Option<NineSlice>,
    // rust: [x, y, w, h]: [f32; 4],
    // rust: color: u32,
    // rust: ) {
    // rust: match nine_slice {
    // rust: Some(n) => draw_nine_slice(batch, r, n, [x, y, w, h], color),
    // rust: None => batch.rect_uv(x, y, w, h, r, color),
}
}
    // rust: fn draw_nine_slice(
    // rust: batch: &mut HudBatch,
    // rust: r: Rect,
    // rust: n: NineSlice,
    // rust: [x, y, w, h]: [f32; 4],
    // rust: color: u32,
    // rust: ) {
    // rust: let size = [n.width as f32, n.height as f32];
    // rust: let [sw, sh] = size;
    // rust: let [l, t, rr, b] = n.border.map(|v| v as f32);
    // rust: let (half_w, half_h) = ((w / 2.0).floor(), (h / 2.0).floor());
    // rust: let (l, rr, t, b) = (l.min(half_w), rr.min(half_w), t.min(half_h), b.min(half_h));
    // blitSprite(sprite, width, height, textureX, textureY, x, y, w, h).
    // rust: let part = |batch: &mut HudBatch, tx: f32, ty: f32, dst: [f32; 4]| {
    // rust: if dst[2] != 0.0 && dst[3] != 0.0 {
    // rust: batch.rect_uv(
    // rust: dst[0],
    // rust: dst[1],
    // rust: dst[2],
    // rust: dst[3],
    // rust: sub(r, size, [tx, ty, dst[2], dst[3]]),
    // rust: color,
    // rust: );
}
}
    // blitNineSliceInnerSegment.
    // rust: let inner = |batch: &mut HudBatch, dst: [f32; 4], src: [f32; 4]| {
    // rust: if dst[2] <= 0.0 || dst[3] <= 0.0 {
    // rust: return;
}
    // rust: if n.stretch_inner {
    // rust: batch.rect_uv(dst[0], dst[1], dst[2], dst[3], sub(r, size, src), color);
    // rust: } else {
    // rust: tile(batch, r, size, src, dst, color);
}
}
    // rust: if w == sw && h == sh {
    // rust: part(batch, 0.0, 0.0, [x, y, w, h]);
    // rust: return;
}
    // rust: if h == sh {
    // rust: part(batch, 0.0, 0.0, [x, y, l, h]);
    // rust: inner(batch, [x + l, y, w - rr - l, h], [l, 0.0, sw - rr - l, sh]);
    // rust: part(batch, sw - rr, 0.0, [x + w - rr, y, rr, h]);
    // rust: return;
}
    // rust: if w == sw {
    // rust: part(batch, 0.0, 0.0, [x, y, w, t]);
    // rust: inner(batch, [x, y + t, w, h - b - t], [0.0, t, sw, sh - b - t]);
    // rust: part(batch, 0.0, sh - b, [x, y + h - b, w, b]);
    // rust: return;
}
    // rust: let (cw, ch) = (w - rr - l, h - b - t);
    // rust: let (scw, sch) = (sw - rr - l, sh - b - t);
    // rust: part(batch, 0.0, 0.0, [x, y, l, t]);
    // rust: inner(batch, [x + l, y, cw, t], [l, 0.0, scw, t]);
    // rust: part(batch, sw - rr, 0.0, [x + w - rr, y, rr, t]);
    // rust: part(batch, 0.0, sh - b, [x, y + h - b, l, b]);
    // rust: inner(batch, [x + l, y + h - b, cw, b], [l, sh - b, scw, b]);
    // rust: part(batch, sw - rr, sh - b, [x + w - rr, y + h - b, rr, b]);
    // rust: inner(batch, [x, y + t, l, ch], [0.0, t, l, sch]);
    // rust: inner(batch, [x + l, y + t, cw, ch], [l, t, scw, sch]);
    // rust: inner(batch, [x + w - rr, y + t, rr, ch], [sw - rr, t, rr, sch]);
}
/// Repeat a whole texture with each copy drawn `size` GUI pixels square.
    // rust: pub fn tiled(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: sprite: &str,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: size: f32,
    // rust: color: u32,
    // rust: ) {
    // rust: tiled_sized(batch, atlas, sprite, x, y, w, h, [size, size], color);
}
/// Repeat a texture using its width and height in GUI pixels.
    // rust: pub fn tiled_sized(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: sprite: &str,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: size: [f32; 2],
    // rust: color: u32,
    // rust: ) {
    // rust: let Some(r) = atlas.sprites.get(sprite).copied() else {
    // rust: return;
}
    // rust: tile(
    // rust: batch,
    // rust: r,
    // rust: size,
    // rust: [0.0, 0.0, size[0], size[1]],
    // rust: [x, y, w, h],
    // rust: color,
    // rust: );
}
/// Text drawn at `scale` times its size (a scaled pose).
    // rust: pub fn text_scaled(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: text: &Text,
    // rust: x: f32,
    // rust: y: f32,
    // rust: scale: f32,
    // rust: color: u32,
    // rust: ) {
    // rust: let start = batch.vertices.len();
    // rust: batch.text_styled(atlas, text, 0.0, 0.0, color, true);
    // rust: for v in &mut batch.vertices[start..] {
    // rust: v.pos = [x + v.pos[0] * scale, y + v.pos[1] * scale];
}
}
pub fn hovered(cursor: (f32) void {
}
    // rust: cursor.0 >= x && cursor.0 < x + w && cursor.1 >= y && cursor.1 < y + h
}
/// `TextAlignment.CENTER.calculateLeft` at the box's integer centre:
/// `x + w / 2 - width / 2`. Flooring `(w - width) / 2` sits odd-width labels
/// one pixel left of vanilla when `w` is even.
pub fn centered_left(x: f32, w: f32, width: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: x + (w / 2.0).floor() - (width / 2.0).floor()
}

/// Centered text with a shadow, for titles and lines of text, which vanilla
/// never scrolls: one wider than `w` keeps the characters that fit. Widget
/// labels go through [`scrolling_text`] instead, as vanilla's do.
    // rust: pub fn centered_text(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: text: &Text,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: color: u32,
    // rust: ) {
    // rust: let text = text.resolved();
    // rust: let width = atlas.font.width_text(&text);
    // rust: if width <= w {
    // rust: batch.text_styled(atlas, &text, centered_left(x, w, width), y, color, true);
    // rust: } else {
        // Clip by characters: vanilla clips nothing here, but a title is as
        // wide as the window.
    // rust: let mut shown = Text::empty();
    // rust: let mut used = 0.0;
    // rust: for (i, (c, s)) in text.chars().enumerate() {
    // rust: used += atlas.font.advance(c, s);
    // rust: if used > w - 2.0 {
    // rust: break;
}
    // rust: shown.push(text.slice(i, i + 1));
}
    // rust: batch.text_styled(atlas, &shown, x + 1.0, y, color, true);
}
}
/// `ActiveTextCollector.defaultScrollingHelper`'s slide: a label `overflow`
/// pixels too wide moves from its end back to its start and out again, one
/// sine period every `max(overflow * 0.5, 3)` seconds of `Util.getMillis`.
pub fn scroll_offset(overflow: f32, now_ms: i64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let period = (f64::from(overflow) * 0.5).max(3.0);
    // rust: let seconds = now_ms as f64 / 1000.0;
    // rust: let phase = (std::f64::consts::TAU * seconds / period).cos();
    // rust: let pos = (std::f64::consts::FRAC_PI_2 * phase).sin() / 2.0 + 0.5;
    // rust: f64::from(overflow) * pos
}

/// Where an overflowing label's left edge is drawn: `left - (int) pos`.
pub fn scrolled_left(left: f32, overflow: f32, now_ms: i64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: left - scroll_offset(overflow, now_ms) as i32 as f32
}

/// A widget's label as `AbstractWidget.extractScrollingStringOverContents`
/// draws it, at `now_ms`: centred between `left` and `right` when it fits,
/// else drawn from the left and slid (`defaultScrollingHelper`) inside the
/// widget's box. `y` is the label's top line.
    // rust: pub fn scrolling_text_at(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: text: &Text,
    // rust: left: f32,
    // rust: right: f32,
    // rust: top: f32,
    // rust: bottom: f32,
    // rust: y: f32,
    // rust: now_ms: i64,
    // rust: color: u32,
    // rust: ) {
    // `acceptScrollingWithDefaultCenter`: `centerX = (left + right) / 2`.
    // rust: let center_x = left + ((right - left) / 2.0).floor();
    // rust: scrolling_text_around_at(
    // rust: batch, atlas, text, center_x, left, right, top, bottom, y, now_ms, color,
    // rust: );
}

/// [`scrolling_text_at`] around an explicit `center_x`
/// (`ActiveTextCollector.acceptScrolling`, which `SpriteIconButton.TextAndIcon`
/// calls with the button's middle): a label that fits is centred on `center_x`
/// moved as far as it must to stay between `left` and `right`
/// (`Mth.clamp(centerX, left + lineWidth / 2, right - lineWidth / 2)`), so
/// beside an icon it ends where the icon's room begins. A wider one is drawn
/// from the left and slid inside the box.
    // rust: pub fn scrolling_text_around_at(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: text: &Text,
    // rust: center_x: f32,
    // rust: left: f32,
    // rust: right: f32,
    // rust: top: f32,
    // rust: bottom: f32,
    // rust: y: f32,
    // rust: now_ms: i64,
    // rust: color: u32,
    // rust: ) {
    // rust: let text = text.resolved();
    // rust: let width = atlas.font.width_text(&text);
    // rust: let room = right - left;
    // rust: if width <= room {
    // rust: let half = (width / 2.0).floor();
    // rust: let text_x = center_x.max(left + half).min(right - half);
    // rust: batch.text_styled(atlas, &text, text_x - half, y, color, true);
    // rust: return;
}
    // Scissored to the widget: what does not fit is read as the label
    // slides, never dropped.
    // rust: let start = batch.vertices.len();
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &text,
    // rust: scrolled_left(left, width - room, now_ms),
    // rust: y,
    // rust: color,
    // rust: true,
    // rust: );
    // rust: batch.clip_since(start, left, top, right, bottom);
}

/// [`scrolling_text_at`] at `Util.getMillis`.
    // rust: pub fn scrolling_text(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: text: &Text,
    // rust: left: f32,
    // rust: right: f32,
    // rust: top: f32,
    // rust: bottom: f32,
    // rust: y: f32,
    // rust: color: u32,
    // rust: ) {
    // rust: scrolling_text_at(
    // rust: batch,
    // rust: atlas,
    // rust: text,
    // rust: left,
    // rust: right,
    // rust: top,
    // rust: bottom,
    // rust: y,
    // rust: crate::hud_overlays::now_ms(),
    // rust: color,
    // rust: );
}

/// `MenuTabBar.MenuTabButton.renderLabel` for the tab at `x, y`: its label
/// inside the tab less 1 px on each side, from the tab's top when selected
/// and 3 px lower when not (`acceptScrollingWithDefaultCenter`, so one wider
/// than the tab slides instead of running into the next tab). White, gray
/// for an inactive tab (`WithInactiveMessage`).
    // rust: pub fn menu_tab_label(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: label: &Text,
    // rust: (x, y, width, height): (f32, f32, f32, f32),
    // rust: selected: bool,
    // rust: active: bool,
    // rust: now_ms: i64,
    // rust: ) {
    // rust: let top = y + if selected { 0.0 } else { 3.0 };
    // rust: let bottom = y + height;
    // rust: scrolling_text_at(
    // rust: batch,
    // rust: atlas,
    // rust: label,
    // rust: x + 1.0,
    // rust: x + width - 1.0,
    // rust: top,
    // rust: bottom,
        // defaultScrollingHelper: `(top + bottom - lineHeight) / 2 + 1`.
    // rust: ((top + bottom - 9.0) / 2.0).floor() + 1.0,
    // rust: now_ms,
    // rust: if active { u32::MAX } else { 0xFFA0_A0A0 },
    // rust: );
}

/// Button (AbstractButton): nine-slice sprite plus the centred label.
    // rust: pub fn button(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: label: &Text,
    // rust: active: bool,
    // rust: hover: bool,
    // rust: ) {
    // rust: button_as(batch, atlas, x, y, w, h, label, active, hover, |rect| {
    // rust: crate::widgets::Narratable::button(label.plain(), rect, active)
    // rust: });
}
/// A [`button`] with a job on its screen: its controller button and glyph come from `action`, so
/// a new screen gets them by drawing this for its Done, Back, Cancel or Apply.
    // rust: pub fn action_button(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: action: crate::widgets::Action,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: label: &Text,
    // rust: active: bool,
    // rust: hover: bool,
    // rust: ) {
    // rust: crate::widgets::declare_action(action, [x, y, w, h], active);
    // rust: let room = if active {
    // rust: crate::widgets::action_glyph_room()
    // rust: } else {
    // rust: 0.0
}
    // rust: button_with_room(
    // rust: batch,
    // rust: atlas,
    // rust: [x, y, w, h],
    // rust: label,
    // rust: active,
    // rust: hover,
    // rust: room,
    // rust: |rect| crate::widgets::Narratable::button(label.plain(), rect, active),
    // rust: );
}
/// A [`button`] that vanilla narrates as another widget (a `CycleButton`, a
/// `LockIconButton`): `narration` builds what it records from its rectangle,
/// and only while the narrator records.
    // rust: pub fn button_as(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: label: &Text,
    // rust: active: bool,
    // rust: hover: bool,
    // rust: narration: impl FnOnce([f32; 4]) -> crate::widgets::Narratable,
    // rust: ) {
    // rust: button_with_room(
    // rust: batch,
    // rust: atlas,
    // rust: [x, y, w, h],
    // rust: label,
    // rust: active,
    // rust: hover,
    // rust: 0.0,
    // rust: narration,
    // rust: );
}
/// A button whose label keeps `room` free at its left.
    // rust: fn button_with_room(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: [x, y, w, h]: [f32; 4],
    // rust: label: &Text,
    // rust: active: bool,
    // rust: hover: bool,
    // rust: room: f32,
    // rust: narration: impl FnOnce([f32; 4]) -> crate::widgets::Narratable,
    // rust: ) {
    // rust: let plain = label.plain();
    // rust: crate::widgets::record(&plain, [x, y, w, h], active);
    // An icon button has no label to record, and A presses it all the same.
    // rust: if active && plain.trim().is_empty() {
    // rust: crate::widgets::target([x, y, w, h]);
}
    // rust: crate::widgets::narratable(|| narration([x, y, w, h]).hovered(hover));
    // rust: crate::widgets::widget_cursor(hover, active);
    // rust: let sprite = if !active {
    // rust: "gui/sprites/widget/button_disabled"
    // rust: } else if hover {
    // rust: "gui/sprites/widget/button_highlighted"
    // rust: } else {
    // rust: "gui/sprites/widget/button"
}
    // rust: nine_slice(batch, atlas, sprite, x, y, w, h, u32::MAX);
    // rust: let color = if active {
    // rust: rgba(255, 255, 255, 255)
    // rust: } else {
    // rust: rgba(160, 160, 160, 255)
}
    // Centred on the button, as the title's are, and only moved out from under a glyph.
    // rust: scrolling_text_around_at(
    // rust: batch,
    // rust: atlas,
    // rust: label,
    // rust: x + (w / 2.0).floor(),
    // rust: x + 2.0 + room,
    // rust: x + w - 2.0,
    // rust: y,
    // rust: y + h,
    // rust: y + ((h - 8.0) / 2.0).floor(),
    // rust: crate::hud_overlays::now_ms(),
    // rust: color,
    // rust: );
}
/// AbstractSliderButton: track, 8px handle at `value` (0..1) and the label.
    // rust: pub fn slider(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: label: &Text,
    // rust: value: f32,
    // rust: hover: bool,
    // rust: active: bool,
    // rust: dragging: bool,
    // rust: ) {
    // rust: slider_ext(
    // rust: batch, atlas, x, y, w, label, value, hover, false, false, active, dragging,
    // rust: );
}

/// `AbstractSliderButton.extractWidgetRenderState`: track, 8px handle at `value` (0..1),
/// with support for keyboard focus and `canChangeValue`.
    // rust: pub fn slider_ext(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: label: &Text,
    // rust: value: f32,
    // rust: hover: bool,
    // rust: focused: bool,
    // rust: can_change_value: bool,
    // rust: active: bool,
    // rust: dragging: bool,
    // rust: ) {
    // rust: let kind = crate::widgets::Kind::Slider {
    // rust: value,
    // rust: track: [x + 4.0, w - 8.0],
}
    // The control socket's widget tree (`ui`): its label and value.
    // rust: crate::widgets::record_as(&label.plain(), [x, y, w, 20.0], active, kind);
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::slider(label.plain(), [x, y, w, 20.0], active).hovered(hover)
    // rust: });
    // rust: if active {
        // A controller's D-pad can focus it (Horizon's controller support).
    // rust: crate::widgets::target_as([x, y, w, 20.0], kind);
}
    // rust: let (track, handle) = slider_sprites_ext(hover, active, focused, can_change_value, dragging);
    // rust: nine_slice(batch, atlas, track, x, y, w, 20.0, u32::MAX);
    // rust: nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: handle,
    // rust: x + (value.clamp(0.0, 1.0) * (w - 8.0)).floor(),
    // rust: y,
    // rust: 8.0,
    // rust: 20.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let color = if active {
    // rust: u32::MAX
    // rust: } else {
    // rust: rgba(160, 160, 160, 255)
}
    // rust: scrolling_text(
    // rust: batch,
    // rust: atlas,
    // rust: label,
    // rust: x + 2.0,
    // rust: x + w - 2.0,
    // rust: y,
    // rust: y + 20.0,
    // rust: y + 6.0,
    // rust: color,
    // rust: );
}
pub fn slider_sprites(hover: bool, active: bool, dragging: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: slider_sprites_ext(hover, active, false, false, dragging)
}

/// Track and handle sprites: the track outline shows while dragged or focused with
/// keyboard navigation (!can_change_value), hovering or editing highlights the handle.
    // rust: fn slider_sprites_ext(
    // rust: hover: bool,
    // rust: active: bool,
    // rust: focused: bool,
    // rust: can_change_value: bool,
    // rust: dragging: bool,
    // rust: ) -> (&'static str, &'static str) {
    // rust: let track = if dragging || (active && focused && !can_change_value) {
    // rust: "gui/sprites/widget/slider_highlighted"
    // rust: } else {
    // rust: "gui/sprites/widget/slider"
}
    // rust: let handle = if active && (hover || can_change_value || dragging) {
    // rust: "gui/sprites/widget/slider_handle_highlighted"
    // rust: } else {
    // rust: "gui/sprites/widget/slider_handle"
}
    // rust: (track, handle)
}
/// Slider value for a click at `cx` (AbstractSliderButton.setValueFromMouse).
pub fn slider_value(x: f32, w: f32, cx: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((cx - (x + 4.0)) / (w - 8.0)).clamp(0.0, 1.0)
}
/// Screen.renderMenuBackground: in a world the translucent dark texture,
/// otherwise the dirt-like menu texture, tiled at 32 pixels.
    // rust: pub fn menu_background(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: in_world: bool,
    // rust: ) {
    // rust: let sprite = if in_world {
    // rust: "gui/inworld_menu_background"
    // rust: } else {
    // rust: "gui/menu_background"
}
    // rust: if atlas.sprites.contains_key(sprite) {
    // rust: tiled(batch, atlas, sprite, x, y, w, h, 32.0, u32::MAX);
    // rust: } else {
    // rust: batch.fill(atlas, x, y, w, h, rgba(0, 0, 0, 160));
}
}
/// Header and footer separators of list screens.
    // rust: pub fn separators(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: header_bottom: f32,
    // rust: footer_top: f32,
    // rust: in_world: bool,
    // rust: ) {
    // rust: let (header, footer) = if in_world {
    // rust: (
    // rust: "gui/inworld_header_separator",
    // rust: "gui/inworld_footer_separator",
    // rust: )
    // rust: } else {
    // rust: ("gui/header_separator", "gui/footer_separator")
}
    // rust: let w = batch.width;
    // rust: tiled_sized(
    // rust: batch,
    // rust: atlas,
    // rust: header,
    // rust: 0.0,
    // rust: header_bottom - 2.0,
    // rust: w,
    // rust: 2.0,
    // rust: [32.0, 2.0],
    // rust: u32::MAX,
    // rust: );
    // rust: tiled_sized(
    // rust: batch,
    // rust: atlas,
    // rust: footer,
    // rust: 0.0,
    // rust: footer_top,
    // rust: w,
    // rust: 2.0,
    // rust: [32.0, 2.0],
    // rust: u32::MAX,
    // rust: );
}
/// List background between the separators.
    // rust: pub fn list_background(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: top: f32,
    // rust: bottom: f32,
    // rust: in_world: bool,
    // rust: ) {
    // rust: let sprite = if in_world {
    // rust: "gui/inworld_menu_list_background"
    // rust: } else {
    // rust: "gui/menu_list_background"
}
    // rust: tiled(
    // rust: batch,
    // rust: atlas,
    // rust: sprite,
    // rust: 0.0,
    // rust: top,
    // rust: batch.width,
    // rust: bottom - top,
    // rust: 32.0,
    // rust: u32::MAX,
    // rust: );
}
/// The visible scrollbar thumb, shared by painting and pointer input.
    // rust: pub(crate) fn scrollbar_thumb(
    // rust: top: f32,
    // rust: bottom: f32,
    // rust: content: f32,
    // rust: scroll: f32,
    // rust: ) -> Option<(f32, f32)> {
    // rust: let height = bottom - top;
    // rust: if content <= height {
    // rust: return None;
}
    // rust: let bar = (height * height / content)
    // rust: .clamp(32.0, height - 8.0)
    // rust: .floor();
    // rust: let y = top + ((scroll / (content - height)) * (height - bar)).floor();
    // rust: Some((y, bar))
}

/// `AbstractScrollArea`'s scrolling of a list `top..bottom` holding `content`
/// pixels: the amount, the mouse wheel and the held scrollbar.
pub const Scroll = struct {
    amount: f32,
    /// The pointer's last y while the scrollbar is held (`scrolling`).
    held: ?f32,
};
    // rust: impl Scroll {
pub fn max(top: f32, bottom: f32, content: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (content - (bottom - top)).max(0.0)
}
    /// `setScrollAmount`: kept within the content.
pub fn clamp(self: *Self, top: f32, bottom: f32, content: f32) void {
}
    // rust: self.amount = self.amount.clamp(0.0, Self::max(top, bottom, content));
}
    /// `mouseScrolled`: `rate` pixels per wheel step.
pub fn wheel(self: *Self, delta: f32, rate: f32, top: f32, bottom: f32, content: f32) void {
}
    // rust: self.amount -= delta * rate;
    // rust: self.clamp(top, bottom, content);
}
    /// `updateScrolling`: a press on the scrollbar column at `bar_x` (when
    /// there is something to scroll) holds it.
    // rust: pub fn press(
    // rust: &mut self,
    // rust: (x, y): (f32, f32),
    // rust: bar_x: f32,
    // rust: top: f32,
    // rust: bottom: f32,
    // rust: content: f32,
    // rust: ) -> bool {
    // rust: let over = x >= bar_x && x <= bar_x + 6.0 && y >= top && y < bottom;
    // rust: self.held = (over && Self::max(top, bottom, content) > 0.0).then_some(y);
    // rust: self.held.is_some()
}
pub fn held(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.held.is_some()
}
    /// `mouseDragged` while held: above or below the list jumps to an end,
    /// otherwise the thumb follows the pointer.
pub fn drag(self: *Self, y: f32, top: f32, bottom: f32, content: f32) void {
}
    // rust: let Some(last) = self.held else { return };
    // rust: let max = Self::max(top, bottom, content);
    // rust: if y < top {
    // rust: self.amount = 0.0;
    // rust: } else if y > bottom {
    // rust: self.amount = max;
    // rust: } else {
    // rust: let height = bottom - top;
    // rust: let bar = ((height * height / content).trunc()).clamp(32.0, height - 8.0);
    // rust: self.amount += (y - last) * (max.max(1.0) / (height - bar)).max(1.0);
}
    // rust: self.clamp(top, bottom, content);
    // rust: self.held = Some(y);
}
    /// `onRelease`.
pub fn release(self: *Self) void {
}
    // rust: self.held = None;
}
}

/// Vertical scroll bar of a list (AbstractScrollArea): the sprites, and the
/// list is registered for the controller's focus (`widgets::scroll_area`).
    // rust: pub fn scrollbar(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: x: f32,
    // rust: top: f32,
    // rust: bottom: f32,
    // rust: content: f32,
    // rust: scroll: f32,
    // rust: ) {
    // rust: if content > bottom - top {
    // rust: crate::widgets::scroll_area(
    // rust: [0.0, top, x + 6.0, bottom - top],
    // rust: scroll,
    // rust: content - (bottom - top),
    // rust: );
}
    // rust: scrollbar_sprites(batch, atlas, x, top, bottom, content, scroll);
}

/// The scroll bar's background and scroller sprites.
    // rust: pub fn scrollbar_sprites(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: x: f32,
    // rust: top: f32,
    // rust: bottom: f32,
    // rust: content: f32,
    // rust: scroll: f32,
    // rust: ) {
    // rust: let Some((y, bar)) = scrollbar_thumb(top, bottom, content, scroll) else {
    // rust: return;
}
    // rust: let height = bottom - top;
    // rust: nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/widget/scroller_background",
    // rust: x,
    // rust: top,
    // rust: 6.0,
    // rust: height,
    // rust: u32::MAX,
    // rust: );
    // rust: nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/widget/scroller",
    // rust: x,
    // rust: y,
    // rust: 6.0,
    // rust: bar,
    // rust: u32::MAX,
    // rust: );
}

/// Screen tooltip (DefaultTooltipPositioner + TooltipRenderUtil): the
/// background and frame sprites around the lines, beside the cursor.
pub fn tooltip(batch: *mut HudBatch, atlas: *HudAtlas, lines: *[Text], cursor: (f32) void {
}
    // rust: if lines.is_empty() {
    // rust: return;
}
    // rust: let (w, h) = tooltip_size(atlas, lines);
    // rust: let mut x = cursor.0 + 12.0;
    // rust: let mut y = cursor.1 - 12.0;
    // rust: if x + w > batch.width {
    // rust: x = (cursor.0 - 24.0 - w).max(4.0);
}
    // rust: if y + h + 3.0 > batch.height {
    // rust: y = batch.height - h - 3.0;
}
    // rust: tooltip_box(batch, atlas, lines, x, y, w, h);
}
/// `WidgetTooltipHolder.createTooltipPositioner`'s focused branch
/// (`MenuTooltipPositioner`): a widget with the keyboard focus keeps the
/// pointer where it is, and its tooltip stays against the widget at `rect`.
    // rust: pub fn tooltip_menu(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: lines: &[Text],
    // rust: cursor: (f32, f32),
    // rust: rect: [f32; 4],
    // rust: ) {
    // rust: if lines.is_empty() {
    // rust: return;
}
    // rust: let (w, h) = tooltip_size(atlas, lines);
    // rust: let (x, y) = menu_tooltip_position(
    // rust: (batch.width as i32, batch.height as i32),
    // rust: (cursor.0 as i32, cursor.1 as i32),
    // rust: rect.map(|v| v as i32),
    // rust: (w.ceil() as i32, h.ceil() as i32),
    // rust: );
    // rust: tooltip_box(batch, atlas, lines, x as f32, y as f32, w, h);
}
/// A widget's tooltip while the controller's focus is on it (Horizon's: vanilla has no gamepad
/// input, and the hidden pointer mid-widget would put it over the widget).
pub fn tooltip_under(batch: *mut HudBatch, atlas: *HudAtlas, lines: *[Text], rect: [f32; 4]) void {
}
    // rust: if lines.is_empty() {
    // rust: return;
}
    // rust: let (w, h) = tooltip_size(atlas, lines);
    // rust: let (x, y) = tooltip_under_position((batch.width, batch.height), rect, (w, h));
    // rust: tooltip_box(batch, atlas, lines, x, y, w, h);
}
/// Where `tooltip_under` puts lines of `size`: the frame's top left a pixel under the widget's
/// bottom left, over the widget when the screen ends first, and always on the screen.
pub fn tooltip_under_position(screen: (f32) void {
}
    // The frame reaches this far past the lines on every side.
pub const FRAME: f32 = 4.0;
    // rust: let [x, y, _, height] = rect;
    // rust: let right = screen.0 - size.0 - FRAME;
    // rust: let below = y + height + 1.0 + FRAME;
    // rust: let top = if below + size.1 + FRAME <= screen.1 {
    // rust: below
    // rust: } else {
    // rust: y - 1.0 - FRAME - size.1
}
    // rust: ((x + FRAME).min(right).max(FRAME), top.max(FRAME))
}
/// `MenuTooltipPositioner.positionTooltip`: the tooltip's top left with the
/// pointer at `cursor`, the widget it belongs to at `rect`, and the screen.
/// `MARGIN` 5 and `MOUSE_OFFSET_X` 12 on the horizontal, and the
/// `MAX_OVERLAP_WITH_WIDGET` 3 and `MAX_DISTANCE_TO_WIDGET` 5 of the vertical
/// offset from the widget's top or bottom edge.
    // rust: pub fn menu_tooltip_position(
    // rust: screen: (i32, i32),
    // rust: cursor: (i32, i32),
    // rust: rect: [i32; 4],
    // rust: size: (i32, i32),
    // rust: ) -> (i32, i32) {
    // rust: let [_, y, _, height] = rect;
    // rust: let height = height.max(1);
    // rust: let mut pos = (cursor.0 + 12, cursor.1);
    // rust: if pos.0 + size.0 > screen.0 - 5 {
    // rust: pos.0 = (cursor.0 - 12 - size.0).max(9);
}
    // rust: pos.1 += 3;
    // `bottom() + 3 + getOffset(0, 0, height)` is the widget's edge, `height`
    // further down; below that the tooltip goes under it, else over it.
    // rust: let below = size.1 + 6;
    // rust: if y + 2 * height + below <= screen.1 - 5 {
    // rust: pos.1 += widget_offset(pos.1, y, height);
    // rust: } else {
    // rust: pos.1 -= below + widget_offset(pos.1, y + height, height);
}
    // rust: pos
}
/// `MenuTooltipPositioner.getOffset`: how far the tooltip keeps from the
/// widget's top (or bottom) edge, from `MAX_DISTANCE_TO_WIDGET` 5 to
/// `MAX_OVERLAP_WITH_WIDGET` 3 as the pointer nears the edge.
/// The distance over the height is an int division in vanilla, so the lerp
/// is `height - 3` until the pointer is a whole height away, then 5.
pub fn widget_offset(at: i32, edge: i32, height: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = ((at - edge).unsigned_abs().min(height as u32) / height as u32) as f32;
    // rust: ((height as f32 - 3.0) + d * (5.0 - (height as f32 - 3.0))).round() as i32
}
pub fn tooltip_size(atlas: *HudAtlas, lines: *[Text]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let w = lines
    // rust: .iter()
    // rust: .map(|l| atlas.font.width_text(l))
    // rust: .fold(0.0, f32::max);
    // rust: let h = if lines.len() == 1 {
    // rust: 8.0
    // rust: } else {
    // rust: 10.0 * lines.len() as f32
}
    // rust: (w, h)
}
    // rust: fn tooltip_box(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: lines: &[Text],
    // rust: x: f32,
    // rust: y: f32,
    // rust: w: f32,
    // rust: h: f32,
    // rust: ) {
    // rust: crate::widgets::frame_tooltip(lines);
    // rust: nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/tooltip/background",
    // rust: x - 12.0,
    // rust: y - 12.0,
    // rust: w + 24.0,
    // rust: h + 24.0,
    // rust: u32::MAX,
    // rust: );
    // rust: nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: "gui/sprites/tooltip/frame",
    // rust: x - 12.0,
    // rust: y - 12.0,
    // rust: w + 24.0,
    // rust: h + 24.0,
    // rust: u32::MAX,
    // rust: );
    // rust: let mut ly = y;
    // rust: for (i, line) in lines.iter().enumerate() {
    // rust: batch.text_styled(atlas, line, x, ly, u32::MAX, true);
    // rust: ly += if i == 0 { 12.0 } else { 10.0 };
}
}

/// The EditBox text field.
pub const EditBox = struct {
    value: []const u8,
    /// Cursor and selection anchor, in characters.
    cursor: usize,
    highlight: usize,
    display: usize,
    max_length: usize,
    bordered: bool,
    /// `MultiLineEditBox`: a book page keeps line breaks. A single-line box strips them.
    multiline: bool,
    x: f32,
    y: f32,
    width: f32,
    height: f32,
    focused: bool,
    focused_at: Instant,
    /// Grey completion shown after the text (EditBox.setSuggestion).
    suggestion: ?[]const u8,
    text_color: u32,
    /// `getMessage`: what the narrator calls the box ("<message> edit box:
    /// <value>").
    message: []const u8,
    /// Where a borderless box drawn in a frame of its own focuses: a controller's outline goes
    /// round the frame, not over the text.
    frame: Option<[f32,
};
/// The focused text field of a screen that keeps its values as `String`s
/// (the world list's search, world names, seeds, and the server screens): the `EditBox` state that
/// outlives a frame, its cursor, selection and scroll.
pub const Caret = struct {
    field: ?crate::clipboard::FieldId,
    edit: EditBox,
    /// The last click's time and field, for double clicks.
    last_click: Option<(Instant,
    /// The button is held since a press on the field (`onDrag`).
    held: bool,
};
    // rust: impl Default for Caret {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: field: None,
    // rust: edit: EditBox::new(0.0, 0.0, 200.0, 20.0),
    // rust: last_click: None,
    // rust: held: false,
}
}
}
    // rust: impl Caret {
    /// The box for field `id` holding `value`. A field newly focused, or
    /// whose value changed elsewhere, starts with its cursor at the end.
pub fn sync(self: *Self, id: crate::clipboard::FieldId, value: []const u8, max: usize) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.edit.max_length = max;
    // rust: if self.field != Some(id) || self.edit.value != value {
    // rust: self.edit.value = value.to_owned();
    // rust: self.edit.move_cursor_to_end(false);
    // rust: if self.field != Some(id) {
    // rust: self.edit.display = 0;
    // rust: self.field = Some(id);
}
}
    // rust: &mut self.edit
}
    /// Edit field `id`'s `value` through its box; the value is written back.
    // rust: pub fn edit<R>(
    // rust: &mut self,
    // rust: id: crate::clipboard::FieldId,
    // rust: value: &mut String,
    // rust: max: usize,
    // rust: f: impl FnOnce(&mut EditBox) -> R,
    // rust: ) -> R {
    // rust: let edit = self.sync(id, value, max);
    // rust: let result = f(edit);
    // rust: value.clone_from(&edit.value);
    // rust: result
}
    /// A press on field `id` at GUI `x` (`EditBox.onClick`): a second press
    /// within 250 ms is a double click (`MouseHandler`).
    // rust: pub fn press(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: (id, value, max): (crate::clipboard::FieldId, &mut String, usize),
    // rust: rect: [f32; 4],
    // rust: x: f32,
    // rust: shift: bool,
    // rust: ) {
    // rust: let now = Instant::now();
    // rust: let double = self
    // rust: .last_click
    // rust: .is_some_and(|(at, field)| field == id && now.duration_since(at).as_millis() < 250);
    // rust: self.last_click = Some((now, id));
    // rust: self.held = true;
    // rust: self.edit(id, value, max, |edit| {
    // rust: [edit.x, edit.y, edit.width, edit.height] = rect;
    // rust: edit.click(atlas, x, shift, double);
    // rust: });
}
    /// The pointer moved with the button held after a press on field `id`.
    // rust: pub fn drag(
    // rust: &mut self,
    // rust: atlas: &HudAtlas,
    // rust: (id, value, max): (crate::clipboard::FieldId, &mut String, usize),
    // rust: x: f32,
    // rust: ) {
    // rust: if self.held && self.last_click.is_some_and(|(_, field)| field == id) {
    // rust: self.edit(id, value, max, |edit| edit.drag_to(atlas, x));
}
}
    /// The button was released: drags no longer select.
pub fn release(self: *Self) void {
}
    // rust: self.held = false;
}
    /// Draw field `id` at `rect`: the focused one with its caret, the others
    /// showing the end of their text.
    // rust: pub fn draw(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: (id, value, max): (crate::clipboard::FieldId, &str, usize),
    // rust: rect: [f32; 4],
    // rust: focused: bool,
    // rust: focused_at: Instant,
    // rust: ) {
    // rust: let mut idle;
    // rust: let edit = if focused {
    // rust: self.sync(id, value, max)
    // rust: } else {
    // rust: idle = EditBox::new(0.0, 0.0, 0.0, 0.0);
    // rust: idle.max_length = max;
    // rust: idle.set_value(value);
    // rust: &mut idle
}
    // rust: [edit.x, edit.y, edit.width, edit.height] = rect;
    // rust: edit.focused = focused;
    // rust: if edit.focused_at < focused_at {
    // rust: edit.focused_at = focused_at;
}
    // rust: edit.draw(batch, atlas, None);
}
}

/// `EditBox.extractWidgetRenderState` for Horizon's append-only fields,
/// unbordered and with the cursor at the end: the text from (x, y), the
/// highlight when Select All covers the value (`invert_text` as
/// `setInvertHighlightedTextColor`), and the cursor, blinking from when the
/// field took the focus (`TextCursorUtils.isCursorVisible`): an underscore,
/// or a bar once the value is `max_chars` long. `shadow` is `setTextShadow`.
    // rust: pub fn append_field(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: value: &str,
    // rust: (x, y, width): (f32, f32, f32),
    // rust: (color, shadow): (u32, bool),
    // rust: max_chars: usize,
    // rust: selected: bool,
    // rust: invert_text: bool,
    // rust: focused_ms: u128,
    // rust: ) {
    // rust: let mut cursor_x = x;
    // rust: if !value.is_empty() {
    // rust: batch.text(atlas, value, x, y, color, shadow);
    // rust: cursor_x += HudBatch::text_width(atlas, value) + 1.0;
}
    // rust: let insert = char_len(value) >= max_chars;
    // rust: if insert {
    // rust: cursor_x -= 1.0;
}
    // rust: if selected && !value.is_empty() {
    // rust: let right = x + width;
    // rust: let (x0, x1) = (cursor_x.min(right), (x - 1.0).min(right));
    // rust: batch.text_highlight(atlas, (x1, y - 1.0, x0 - x1, 11.0), invert_text);
}
    // rust: if (focused_ms / 300).is_multiple_of(2) {
    // rust: if insert {
    // rust: batch.fill(atlas, cursor_x, y - 1.0, 1.0, 11.0, color);
    // rust: } else {
    // rust: batch.text(atlas, "_", cursor_x, y, color, shadow);
}
}
}
pub fn byte_index(s: []const u8, chars: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.char_indices().nth(chars).map_or(s.len(), |(i, _)| i)
}
pub fn char_len(s: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.chars().count()
}
/// `EditBox.getWordPosition(dir, from)`: the character index `dir` words away
/// from `from`. Forward, past the rest of the word and its spaces; backward,
/// over any spaces to the start of the word.
pub fn word_position(value: []const u8, dir: isize, from: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chars: Vec<char> = value.chars().collect();
    // rust: let mut pos = from.min(chars.len());
    // rust: if dir < 0 {
    // rust: while pos > 0 && chars[pos - 1] == ' ' {
    // rust: pos -= 1;
}
    // rust: while pos > 0 && chars[pos - 1] != ' ' {
    // rust: pos -= 1;
}
    // rust: } else {
    // rust: while pos < chars.len() && chars[pos] != ' ' {
    // rust: pos += 1;
}
    // rust: while pos < chars.len() && chars[pos] == ' ' {
    // rust: pos += 1;
}
}
    // rust: pos
}
/// `MultilineTextField.getPreviousWord` / `getNextWord`'s `beginIndex` (a book page): any
/// whitespace, line breaks included, separates words, and the search starts from the cursor
/// clamped to the last character, as vanilla's does.
pub fn multiline_word_position(value: []const u8, dir: isize, from: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chars: Vec<char> = value.chars().collect();
    // rust: if chars.is_empty() {
    // rust: return 0;
}
    // rust: let mut pos = from.min(chars.len() - 1);
    // rust: if dir < 0 {
    // rust: while pos > 0 && java_whitespace(chars[pos - 1]) {
    // rust: pos -= 1;
}
    // rust: while pos > 0 && !java_whitespace(chars[pos - 1]) {
    // rust: pos -= 1;
}
    // rust: } else {
    // rust: while pos < chars.len() && !java_whitespace(chars[pos]) {
    // rust: pos += 1;
}
    // rust: while pos < chars.len() && java_whitespace(chars[pos]) {
    // rust: pos += 1;
}
}
    // rust: pos
}
/// `Character.isWhitespace`: Unicode spaces and line breaks but not the no-break spaces, plus
/// the ASCII separators U+001C to U+001F.
    // rust: pub(crate) fn java_whitespace(c: char) -> bool {
    // rust: (c.is_whitespace() && !matches!(c, '\u{85}' | '\u{a0}' | '\u{2007}' | '\u{202f}'))
    // rust: || ('\u{1c}'..='\u{1f}').contains(&c)
}
/// `EditBox.deleteWords(dir)` for an append-only field, whose caret is at the
/// end: removes the word in that direction. True when the value changed.
pub fn delete_words(value: *mut []const u8, dir: isize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let len = char_len(value);
    // rust: let to = word_position(value, dir, len);
    // rust: if to == len {
    // rust: return false;
}
    // rust: value.truncate(byte_index(value, to));
    // rust: true
}
    // rust: impl crate::clipboard::Editable for EditBox {
pub fn select_all(self: *Self) void {
}
    // rust: self.move_cursor_to_end(false);
    // rust: self.highlight = 0;
}
pub fn selected_text(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: EditBox::selected_text(self)
}
pub fn insert(self: *Self, text: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let before = self.value.clone();
    // rust: self.insert_text(text);
    // rust: self.value != before
}
}
    // rust: impl EditBox {
pub fn new(x: f32, y: f32, width: f32, height: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: value: String::new(),
    // rust: cursor: 0,
    // rust: highlight: 0,
    // rust: display: 0,
    // rust: max_length: 32,
    // rust: bordered: true,
    // rust: multiline: false,
    // rust: x,
    // rust: y,
    // rust: width,
    // rust: height,
    // rust: focused: true,
    // rust: focused_at: Instant::now(),
    // rust: suggestion: None,
    // rust: text_color: rgba(224, 224, 224, 255),
    // rust: message: String::new(),
    // rust: frame: None,
}
}
pub fn inner_width(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.bordered {
    // rust: self.width - 8.0
    // rust: } else {
    // rust: self.width
}
}
pub fn text_x(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.bordered { self.x + 4.0 } else { self.x }
}
pub fn text_y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.bordered {
    // rust: self.y + ((self.height - 8.0) / 2.0).floor()
    // rust: } else {
    // rust: self.y
}
}
pub fn reset_blink(self: *Self) void {
}
    // rust: self.focused_at = Instant::now();
}
    /// The caret is showing (`EditBox`'s blink, on for 300 ms of every 600).
pub fn cursor_visible(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.focused && (self.focused_at.elapsed().as_millis() / 300).is_multiple_of(2)
}
pub fn set_value(self: *Self, value: []const u8) void {
}
    // rust: self.value = value.chars().take(self.max_length).collect();
    // rust: self.move_cursor_to_end(false);
}
pub fn selected(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: self.cursor.min(self.highlight),
    // rust: self.cursor.max(self.highlight),
    // rust: )
}
pub fn selected_text(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (a, b) = self.selected();
    // rust: self.value.chars().skip(a).take(b - a).collect()
}
    /// EditBox.insertText: replace the selection, respecting the maximum length.
pub fn insert_text(self: *Self, text: []const u8) void {
}
    // rust: let (a, b) = self.selected();
    // rust: let filtered = crate::clipboard::filter_text(text, self.multiline);
    // rust: let room = self
    // rust: .max_length
    // rust: .saturating_sub(char_len(&self.value) - (b - a));
    // rust: let insert: String = filtered.chars().take(room).collect();
    // rust: let (ba, bb) = (byte_index(&self.value, a), byte_index(&self.value, b));
    // rust: self.value.replace_range(ba..bb, &insert);
    // rust: let pos = a + char_len(&insert);
    // rust: self.set_cursor(pos, false);
}
    /// Delete `n` characters (negative: backwards) or the selection.
pub fn delete_chars(self: *Self, n: isize) void {
}
    // rust: if self.cursor != self.highlight {
    // rust: self.insert_text("");
    // rust: return;
}
    // rust: let target = (self.cursor as isize + n).clamp(0, char_len(&self.value) as isize) as usize;
    // rust: let (a, b) = (self.cursor.min(target), self.cursor.max(target));
    // rust: let (ba, bb) = (byte_index(&self.value, a), byte_index(&self.value, b));
    // rust: self.value.replace_range(ba..bb, "");
    // rust: self.set_cursor(a, false);
}
    /// EditBox.getWordPosition from the cursor.
pub fn word_position(self: *Self, dir: isize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.word_position_from(dir, self.cursor)
}
    /// EditBox.getWordPosition(dir, from), or MultilineTextField's word for a book page.
pub fn word_position_from(self: *Self, dir: isize, from: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.multiline {
    // rust: multiline_word_position(&self.value, dir, from)
    // rust: } else {
    // rust: word_position(&self.value, dir, from)
}
}
pub fn set_cursor(self: *Self, pos: usize, select: bool) void {
}
    // rust: self.cursor = pos.min(char_len(&self.value));
    // rust: if !select {
    // rust: self.highlight = self.cursor;
}
    // rust: self.scroll_to(self.cursor);
    // rust: self.reset_blink();
}
pub fn move_cursor_to_end(self: *Self, select: bool) void {
}
    // rust: self.set_cursor(char_len(&self.value), select);
}
    /// EditBox.findClickedPositionInText: the character boundary under GUI `x`.
pub fn position_at(self: *Self, atlas: *HudAtlas, x: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.layout(atlas);
    // rust: let room = (x.floor() - self.text_x()).min(self.inner_width());
    // rust: let rest: String = self.value.chars().skip(self.display).collect();
    // rust: self.display + atlas.font.fit(&rest, room)
}
    /// EditBox.onClick: the cursor to the pointer, extending the selection
    /// with Shift; a double click selects the word under it (`selectWord`).
pub fn click(self: *Self, atlas: *HudAtlas, x: f32, shift: bool, double: bool) void {
}
    // rust: let pos = self.position_at(atlas, x);
    // rust: if double {
    // rust: let (start, end) = (
    // rust: self.word_position_from(-1, pos),
    // rust: self.word_position_from(1, pos),
    // rust: );
    // rust: self.set_cursor(start, false);
    // rust: self.set_cursor(end, true);
    // rust: } else {
    // rust: self.set_cursor(pos, shift);
}
}
    /// `MultilineTextField.selectWordAtCursor` on a book page: the word before
    /// the cursor is selected, its end found past non-whitespace only
    /// (`getWordEndPosition`).
pub fn select_word_at_cursor(self: *Self) void {
}
    // rust: let begin = multiline_word_position(&self.value, -1, self.cursor);
    // rust: let end = begin
    // rust: + self
    // rust: .value
    // rust: .chars()
    // rust: .skip(begin)
    // rust: .take_while(|c| !java_whitespace(*c))
    // rust: .count();
    // rust: self.set_cursor(begin, false);
    // rust: self.set_cursor(end, true);
}
    /// EditBox.onDrag: the selection follows the pointer.
pub fn drag_to(self: *Self, atlas: *HudAtlas, x: f32) void {
}
    // rust: let pos = self.position_at(atlas, x);
    // rust: self.set_cursor(pos, true);
}
pub fn scroll_to(self: *Self, pos: usize) void {
}
        // EditBox.scrollTo without font access is completed in `layout`.
    // rust: self.display = self.display.min(char_len(&self.value));
    // rust: if pos < self.display {
    // rust: self.display = pos;
}
}
pub fn layout(self: *Self, atlas: *HudAtlas) void {
}
    // rust: let len = char_len(&self.value);
    // rust: self.display = self.display.min(len);
    // rust: let (value, inner) = (self.value.clone(), self.inner_width());
    // rust: let visible = |d: usize| -> usize {
    // rust: let rest: String = value.chars().skip(d).collect();
    // rust: atlas.font.fit(&rest, inner)
}
    // rust: while self.cursor > self.display + visible(self.display) && self.display < len {
    // rust: self.display += 1;
}
    // rust: if self.cursor < self.display {
    // rust: self.display = self.cursor;
}
}
    /// Keyboard editing shared by every text field. Returns true if handled.
pub fn key(self: *Self, key: winit::keyboard::KeyCode, ctrl: bool, shift: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
//         use winit::keyboard::KeyCode as K;
    // rust: match key {
    // rust: K::Backspace => {
    // rust: let n = if ctrl {
    // rust: self.word_position(-1) as isize - self.cursor as isize
    // rust: } else {
    // rust: -1
}
    // rust: self.delete_chars(n);
}
    // rust: K::Delete => {
    // rust: let n = if ctrl {
    // rust: self.word_position(1) as isize - self.cursor as isize
    // rust: } else {
    // rust: 1
}
    // rust: self.delete_chars(n);
}
    // rust: K::ArrowLeft => {
    // rust: let p = if ctrl {
    // rust: self.word_position(-1)
    // rust: } else {
    // rust: self.cursor.saturating_sub(1)
}
    // rust: self.set_cursor(p, shift);
}
    // rust: K::ArrowRight => {
    // rust: let p = if ctrl {
    // rust: self.word_position(1)
    // rust: } else {
    // rust: self.cursor + 1
}
    // rust: self.set_cursor(p, shift);
}
    // rust: K::Home => self.set_cursor(0, shift),
    // rust: K::End => self.move_cursor_to_end(shift),
    // rust: K::KeyA if ctrl => {
    // rust: self.move_cursor_to_end(false);
    // rust: self.highlight = 0;
}
    // rust: _ => return false,
}
    // rust: true
}
    /// Ctrl+A/C/V/X (`EditBox.keyPressed`). True when the value changed.
    // rust: pub fn shortcut(
    // rust: &mut self,
    // rust: shortcut: crate::clipboard::EditShortcut,
    // rust: clipboard: &mut dyn crate::clipboard::Clipboard,
    // rust: ) -> bool {
    // rust: let before = self.value.clone();
    // rust: crate::clipboard::apply(self, shortcut, clipboard);
    // rust: self.reset_blink();
    // rust: self.value != before
}
    /// The first shown character after scrolling to the cursor, and the
    /// milliseconds since the field was focused (the cursor's blink).
pub fn view_state(self: *Self, atlas: *HudAtlas) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.layout(atlas);
    // rust: (self.display, self.focused_at.elapsed().as_millis() as u64)
}
    /// Draw the field; `format` styles the visible text (command colouring).
pub fn draw(self: *Self, batch: *mut HudBatch, atlas: *HudAtlas, format: ?*Text) void {
}
    // rust: self.layout(atlas);
    // rust: crate::widgets::target_as(
    // rust: self.frame
    // rust: .unwrap_or([self.x, self.y, self.width, self.height]),
    // rust: crate::widgets::Kind::Field,
    // rust: );
    // rust: crate::widgets::narratable(|| {
    // rust: crate::widgets::Narratable::edit_box(
    // rust: self.message.clone(),
    // rust: self.value.clone(),
    // rust: [self.x, self.y, self.width, self.height],
    // rust: )
    // rust: .focused(self.focused)
    // rust: });
    // rust: if self.bordered {
    // rust: let sprite = if self.focused {
    // rust: "gui/sprites/widget/text_field_highlighted"
    // rust: } else {
    // rust: "gui/sprites/widget/text_field"
}
    // rust: nine_slice(
    // rust: batch,
    // rust: atlas,
    // rust: sprite,
    // rust: self.x,
    // rust: self.y,
    // rust: self.width,
    // rust: self.height,
    // rust: u32::MAX,
    // rust: );
}
    // rust: let color = self.text_color;
    // rust: let rest: String = self.value.chars().skip(self.display).collect();
    // rust: let shown_len = atlas.font.fit(&rest, self.inner_width());
    // rust: let displayed: String = rest.chars().take(shown_len).collect();
    // rust: let rel_cursor = self.cursor as isize - self.display as isize;
    // rust: let on_screen = rel_cursor >= 0 && rel_cursor as usize <= shown_len;
    // rust: let show_cursor = self.focused
    // rust: && (self.focused_at.elapsed().as_millis() / 300).is_multiple_of(2)
    // rust: && on_screen;
    // rust: let styled = |from: usize, to: usize| -> Text {
    // rust: match format {
    // rust: Some(t) => t.slice(self.display + from, self.display + to),
    // rust: None => Text::literal(
    // rust: displayed
    // rust: .chars()
    // rust: .skip(from)
    // rust: .take(to - from)
    // rust: .collect::<String>(),
    // rust: ),
}
}
    // rust: let (tx, ty) = (self.text_x(), self.text_y());
    // rust: let mut draw_x = tx;
    // rust: if !displayed.is_empty() {
    // rust: let half = if on_screen {
    // rust: rel_cursor as usize
    // rust: } else {
    // rust: shown_len
}
    // rust: let t = styled(0, half);
    // rust: batch.text_styled(atlas, &t, draw_x, ty, color, true);
    // rust: draw_x += atlas.font.width_text(&t) + 1.0;
}
    // rust: let insert =
    // rust: self.cursor < char_len(&self.value) || char_len(&self.value) >= self.max_length;
    // rust: let mut cursor_x = draw_x;
    // rust: if !on_screen {
    // rust: cursor_x = if rel_cursor > 0 { tx + self.width } else { tx };
    // rust: } else if insert {
    // rust: cursor_x -= 1.0;
    // rust: draw_x -= 1.0;
}
    // rust: if !displayed.is_empty() && on_screen && (rel_cursor as usize) < shown_len {
    // rust: batch.text_styled(
    // rust: atlas,
    // rust: &styled(rel_cursor as usize, shown_len),
    // rust: draw_x,
    // rust: ty,
    // rust: color,
    // rust: true,
    // rust: );
}
    // rust: if !insert && let Some(s) = &self.suggestion {
    // rust: batch.text(atlas, s, cursor_x - 1.0, ty, rgba(128, 128, 128, 255), true);
}
    // rust: let rel_highlight =
    // rust: (self.highlight as isize - self.display as isize).clamp(0, shown_len as isize) as usize;
    // rust: if rel_highlight as isize != rel_cursor {
    // rust: let hx = tx
    // rust: + atlas
    // rust: .font
    // rust: .width(&displayed.chars().take(rel_highlight).collect::<String>());
            // textHighlight between the cursor and the anchor, clipped at the right edge.
    // rust: let right = self.x + self.width;
    // rust: let (x0, x1) = (cursor_x.min(right), (hx - 1.0).min(right));
    // rust: let (a, b) = (x0.min(x1), x0.max(x1));
    // rust: batch.text_highlight(atlas, (a, ty - 1.0, b - a, 11.0), true);
}
    // rust: if show_cursor {
    // rust: if insert {
    // rust: batch.fill(atlas, cursor_x, ty - 1.0, 1.0, 11.0, color);
    // rust: } else {
    // rust: batch.text(atlas, "_", cursor_x, ty, color, true);
}
}
    // rust: if self.focused {
    // rust: crate::preedit::report_caret(cursor_x, ty, 10.0);
}
}
    /// Character index under GUI x (mouse click).
pub fn index_at(self: *Self, atlas: *HudAtlas, x: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rest: String = self.value.chars().skip(self.display).collect();
    // rust: self.display + atlas.font.fit(&rest, (x - self.text_x()).max(0.0))
}
    /// GUI x of a character index (EditBox.getScreenX).
pub fn screen_x(self: *Self, atlas: *HudAtlas, index: usize) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if index > char_len(&self.value) {
    // rust: return self.x;
}
    // rust: let shown: String = self
    // rust: .value
    // rust: .chars()
    // rust: .skip(self.display)
    // rust: .take(index.saturating_sub(self.display))
    // rust: .collect();
    // rust: self.text_x() + atlas.font.width(&shown)
}
}

    // rust: mod tests {
//     use super::*;

    /// The quads' destination rectangles and their UVs.
pub fn quads(batch: *HudBatch) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: batch
    // rust: .vertices
    // rust: .chunks(6)
    // rust: .map(|q| {
    // rust: let (a, c) = (q[0], q[2]);
    // rust: (
    // rust: [a.pos[0], a.pos[1], c.pos[0], c.pos[1]],
    // rust: [a.uv[0], a.uv[1], c.uv[0], c.uv[1]],
    // rust: )
    // rust: })
    // rust: .collect()
}
    /// Destination and UV rectangles equal to within f32 rounding.
pub fn assert_quad(actual: ([f32; 4]) void {
}
    // rust: let close = |a: [f32; 4], b: [f32; 4]| a.iter().zip(b).all(|(a, b)| (a - b).abs() < 1e-5);
    // rust: assert!(
    // rust: close(actual.0, expected.0) && close(actual.1, expected.1),
    // rust: "{actual:?} != {expected:?}"
    // rust: );
}
    /// A sprite filling the atlas, `w x h` texels as a 32x pack draws it.
pub fn sprite(w: u32, h: u32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Rect {
    // rust: u0: 0.0,
    // rust: v0: 0.0,
    // rust: u1: 1.0,
    // rust: v1: 1.0,
    // rust: w,
    // rust: h,
}
}
pub fn faithful(json: []const u8) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parse_nine_slice(&serde_json::from_str(json).unwrap()).unwrap()
}
pub fn centered_label_matches_vanilla_integer_center() void {
}
        // Even box, odd text: (w - width) / 2 floors one pixel left of w/2 - width/2.
    // rust: assert_eq!(centered_left(0.0, 200.0, 9.0), 96.0);
    // rust: assert_eq!(centered_left(0.0, 200.0, 8.0), 96.0);
    // rust: assert_eq!(centered_left(10.0, 196.0, 9.0), 104.0);
    // rust: assert_eq!(centered_left(2.0, 196.0, 7.0), 97.0);
}
    /// `defaultScrollingHelper`: one period every `max(overflow * 0.5, 3)`
    /// seconds, a full sine: the label starts with its end showing, shows its
    /// start half a period later, and never slides past either end.
pub fn an_overflowing_label_slides_from_its_end_to_its_start_and_back() void {
}
    // rust: let overflow = 40.0;
        // max(40 * 0.5, 3) = 20 s.
    // rust: assert!((scroll_offset(overflow, 0) - 40.0).abs() < 1.0e-9);
    // rust: assert!(scroll_offset(overflow, 10_000).abs() < 1.0e-9);
    // rust: assert!((scroll_offset(overflow, 20_000) - 40.0).abs() < 1.0e-9);
        // A label one pixel too wide waits the floor of three seconds.
    // rust: assert!(scroll_offset(1.0, 1_500).abs() < 1.0e-9);
    // rust: assert!((scroll_offset(1.0, 0) - 1.0).abs() < 1.0e-9);
    // rust: for ms in 0..40_000 {
    // rust: let offset = scroll_offset(overflow, ms);
    // rust: assert!((0.0..=40.0).contains(&offset), "{ms} ms: {offset}");
}
}

pub fn atlas() H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap()
}

    /// `defaultScrollingHelper` draws an overflowing label from `left` less the
    /// integer part of the slide, so it shows its end first and its start half
    /// a period later, and it moves a whole pixel at a time.
pub fn an_overflowing_label_is_drawn_left_less_the_integer_slide() void {
}
        // max(40 * 0.5, 3) = 20 s: at 0 s the whole overflow is slid, at 10 s none.
    // rust: assert_eq!(scrolled_left(10.0, 40.0, 0), -30.0);
    // rust: assert_eq!(scrolled_left(10.0, 40.0, 10_000), 10.0);
        // A fractional slide is cut, not rounded.
    // rust: let offset = scroll_offset(40.0, 1_000) as i32 as f32;
    // rust: assert!(offset > 0.0);
    // rust: assert_eq!(scrolled_left(10.0, 40.0, 1_000), 10.0 - offset);
}

    /// A controller reaches an icon button only through its target, and can't press a disabled one.
pub fn an_active_icon_button_is_a_focus_target_and_a_disabled_one_is_not() void {
}
    // rust: let atlas = atlas();
    // rust: let mut batch = HudBatch::new([640, 480]);
        // Whatever this thread drew before is the last frame's, then gone.
    // rust: crate::widgets::end_frame(u64::MAX - 1);
    // rust: button(
    // rust: &mut batch,
    // rust: &atlas,
    // rust: 10.0,
    // rust: 20.0,
    // rust: 20.0,
    // rust: 20.0,
    // rust: &Text::empty(),
    // rust: true,
    // rust: false,
    // rust: );
    // rust: button(
    // rust: &mut batch,
    // rust: &atlas,
    // rust: 40.0,
    // rust: 20.0,
    // rust: 20.0,
    // rust: 20.0,
    // rust: &Text::empty(),
    // rust: false,
    // rust: false,
    // rust: );
    // rust: crate::widgets::end_frame(u64::MAX);
    // rust: let targets: Vec<[f32; 4]> = crate::widgets::last_targets()
    // rust: .iter()
    // rust: .map(|t| t.rect)
    // rust: .collect();
    // rust: assert_eq!(targets, [[10.0, 20.0, 20.0, 20.0]]);
}

pub fn a_glyph_leaves_a_label_that_fits_centred() void {
}
    // rust: let atlas = atlas();
    // rust: crate::widgets::set_action_glyphs(true);
    // rust: let label = Text::literal("Done");
    // rust: let mut plain = HudBatch::new([640, 480]);
    // rust: button(
    // rust: &mut plain, &atlas, 10.0, 20.0, 150.0, 20.0, &label, true, false,
    // rust: );
    // rust: let mut declared = HudBatch::new([640, 480]);
    // rust: action_button(
    // rust: &mut declared,
    // rust: &atlas,
    // rust: crate::widgets::Action::Done,
    // rust: 10.0,
    // rust: 20.0,
    // rust: 150.0,
    // rust: 20.0,
    // rust: &label,
    // rust: true,
    // rust: false,
    // rust: );
    // rust: assert_eq!(quads(&plain), quads(&declared));
}

pub fn a_label_wider_than_its_widget_stays_inside_it() void {
}
    // rust: let atlas = atlas();
    // rust: let label = Text::literal("Graphics API: Prefer Vulkan (Experimental)");
    // rust: assert!(atlas.font.width_text(&label.resolved()) > 96.0);
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: scrolling_text_at(
    // rust: &mut batch,
    // rust: &atlas,
    // rust: &label,
    // rust: 10.0,
    // rust: 106.0,
    // rust: 20.0,
    // rust: 40.0,
    // rust: 26.0,
    // rust: 0,
    // rust: u32::MAX,
    // rust: );
    // rust: assert!(!batch.vertices.is_empty());
    // rust: for v in &batch.vertices {
    // rust: assert!(
    // rust: (10.0..=106.0).contains(&v.pos[0]) && (20.0..=40.0).contains(&v.pos[1]),
    // rust: "{:?} outside the widget",
    // rust: v.pos
    // rust: );
}
        // A label that fits is centred and not cut: every glyph is drawn.
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: let short = Text::literal("Done");
    // rust: scrolling_text_at(
    // rust: &mut batch,
    // rust: &atlas,
    // rust: &short,
    // rust: 10.0,
    // rust: 106.0,
    // rust: 20.0,
    // rust: 40.0,
    // rust: 26.0,
    // rust: 0,
    // rust: u32::MAX,
    // rust: );
    // rust: let width = atlas.font.width_text(&short.resolved());
    // rust: let left = centered_left(10.0, 96.0, width);
    // rust: let lo = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| v.pos[0])
    // rust: .fold(f32::INFINITY, f32::min);
    // rust: let hi = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .map(|v| v.pos[0])
    // rust: .fold(f32::NEG_INFINITY, f32::max);
    // rust: assert!(
    // rust: (lo - left).abs() < 0.001,
    // rust: "centred at {left}, drawn from {lo}"
    // rust: );
    // rust: assert!(
    // rust: hi - lo >= width - 0.001,
    // rust: "the whole label is drawn: {lo}..{hi}, {width} wide"
    // rust: );
}

    /// `MenuTabButton.renderLabel` on a 24 px tab: centred on the tab, its
    /// text top at `(0 + 24 - 9) / 2 + 1 = 8` when selected and at
    /// `(3 + 24 - 9) / 2 + 1 = 10` when not; white on an active tab, selected
    /// or not, `0xA0A0A0` on an inactive one (`WithInactiveMessage`). The
    /// Statistics tabs drew every label at 8 and an active unselected one gray.
pub fn a_tab_label_sits_lower_on_an_unselected_tab_and_is_gray_only_when_inactive() void {
}
    // rust: let atlas = atlas();
    // rust: let label = Text::literal("Items");
    // rust: let half = (atlas.font.width_text(&label.resolved()) / 2.0).floor();
        // A 124 px tab at x = 100: `(left + right) / 2 = (101 + 223) / 2 = 162`.
    // rust: let left = 162.0 - half;
    // rust: for (selected, active, y, color) in [
    // rust: (true, true, 8.0, u32::MAX),
    // rust: (false, true, 10.0, u32::MAX),
    // rust: (false, false, 10.0, 0xFFA0_A0A0),
    // rust: ] {
    // rust: let mut tab = HudBatch::new([640, 480]);
    // rust: menu_tab_label(
    // rust: &mut tab,
    // rust: &atlas,
    // rust: &label,
    // rust: (100.0, 0.0, 124.0, 24.0),
    // rust: selected,
    // rust: active,
    // rust: 0,
    // rust: );
    // rust: let mut want = HudBatch::new([640, 480]);
    // rust: want.text_styled(&atlas, &label.resolved(), left, y, color, true);
    // rust: let glyphs = |b: &HudBatch| -> Vec<([u32; 2], u32)> {
    // rust: b.vertices
    // rust: .iter()
    // rust: .filter(|v| v.text == 1)
    // rust: .map(|v| ([v.pos[0].to_bits(), v.pos[1].to_bits()], v.color))
    // rust: .collect()
}
    // rust: assert!(!glyphs(&want).is_empty());
    // rust: assert_eq!(
    // rust: glyphs(&tab),
    // rust: glyphs(&want),
    // rust: "selected {selected}, active {active}"
    // rust: );
}
}

pub fn slider_track_is_outlined_only_while_dragged() void {
}
    // rust: let (track, handle) = slider_sprites(true, true, false);
    // rust: assert_eq!(track, "gui/sprites/widget/slider");
    // rust: assert_eq!(handle, "gui/sprites/widget/slider_handle_highlighted");
    // rust: let (track, handle) = slider_sprites(true, true, true);
    // rust: assert_eq!(track, "gui/sprites/widget/slider_highlighted");
    // rust: assert_eq!(handle, "gui/sprites/widget/slider_handle_highlighted");
    // rust: let (track, handle) = slider_sprites(false, true, false);
    // rust: assert_eq!(track, "gui/sprites/widget/slider");
    // rust: assert_eq!(handle, "gui/sprites/widget/slider_handle");
}
pub fn separator_tiles_sample_both_rows_and_clip_the_last_column() void {
}
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: tile(
    // rust: &mut batch,
    // rust: sprite(32, 2),
    // rust: [32.0, 2.0],
    // rust: [0.0, 0.0, 32.0, 2.0],
    // rust: [0.0, 5.0, 40.0, 2.0],
    // rust: u32::MAX,
    // rust: );
    // rust: let q = quads(&batch);
    // rust: assert_eq!(q.len(), 2);
    // rust: assert_quad(q[0], ([0.0, 5.0, 32.0, 7.0], [0.0, 0.0, 1.0, 1.0]));
    // rust: assert_quad(q[1], ([32.0, 5.0, 40.0, 7.0], [0.0, 0.0, 0.25, 1.0]));
}
pub fn a_border_that_leaves_no_centre_slice_is_no_metadata() void {
}
        // NineSlice.validate rejects 12 + 12 >= 20, so the sprite has none.
    // rust: let json = serde_json::json!({"gui": {"scaling": {
    // rust: "type": "nine_slice", "width": 20, "height": 20, "border": 12}}});
    // rust: assert!(parse_nine_slice(&json).is_none());
        // 9 + 9 < 20 still leaves a centre slice.
    // rust: let json = serde_json::json!({"gui": {"scaling": {
    // rust: "type": "nine_slice", "width": 20, "height": 20, "border": 9}}});
    // rust: assert_eq!(parse_nine_slice(&json).unwrap().border, [9; 4]);
}
pub fn a_high_resolution_button_slices_in_its_gui_units() void {
}
        // Faithful 32x's widget/button: 400x40 texels, gui.scaling 200x20.
    // rust: let n = faithful(
    // rust: r#"{"gui":{"scaling":{"type":"nine_slice","width":200,"height":20,
    // rust: "border":{"left":20,"top":4,"right":20,"bottom":4}}}}"#,
    // rust: );
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw_nine_slice(
    // rust: &mut batch,
    // rust: sprite(400, 40),
    // rust: n,
    // rust: [10.0, 5.0, 150.0, 20.0],
    // rust: u32::MAX,
    // rust: );
    // rust: let q = quads(&batch);
        // Full height: left border, the centre tiled, right border
        // (blitNineSlicedSprite's height == nineSlice.height case).
    // rust: assert_quad(q[0], ([10.0, 5.0, 30.0, 25.0], [0.0, 0.0, 0.1, 1.0]));
    // rust: assert_quad(q[1], ([30.0, 5.0, 140.0, 25.0], [0.1, 0.0, 0.65, 1.0]));
    // rust: assert_quad(q[2], ([140.0, 5.0, 160.0, 25.0], [0.9, 0.0, 1.0, 1.0]));
    // rust: assert_eq!(q.len(), 3);
}
pub fn nine_slice_corners_and_a_stretched_centre() void {
}
        // Faithful 32x's tooltip/frame: 200x200 texels, 100x100, border 12, stretched.
    // rust: let n = faithful(
    // rust: r#"{"gui":{"scaling":{"type":"nine_slice","width":100,"height":100,"border":12,"stretch_inner":true}}}"#,
    // rust: );
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw_nine_slice(
    // rust: &mut batch,
    // rust: sprite(200, 200),
    // rust: n,
    // rust: [0.0, 0.0, 300.0, 40.0],
    // rust: u32::MAX,
    // rust: );
    // rust: let q = quads(&batch);
    // rust: assert_eq!(q.len(), 9);
        // Top left corner: 12 GUI pixels, 12/100 of the sprite.
    // rust: assert_quad(q[0], ([0.0, 0.0, 12.0, 12.0], [0.0, 0.0, 0.12, 0.12]));
        // The centre is one stretched quad (blitNineSliceInnerSegment, stretch_inner).
    // rust: assert_quad(q[7], ([12.0, 12.0, 288.0, 28.0], [0.12, 0.12, 0.88, 0.88]));
        // Bottom right corner.
    // rust: assert_quad(q[5], ([288.0, 28.0, 300.0, 40.0], [0.88, 0.88, 1.0, 1.0]));
}
pub fn a_sprite_drawn_at_its_own_size_is_one_quad() void {
}
    // rust: let n = NineSlice {
    // rust: width: 50,
    // rust: height: 50,
    // rust: border: [10; 4],
    // rust: stretch_inner: false,
}
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw_nine_slice(
    // rust: &mut batch,
    // rust: sprite(100, 100),
    // rust: n,
    // rust: [4.0, 4.0, 50.0, 50.0],
    // rust: u32::MAX,
    // rust: );
    // rust: let q = quads(&batch);
    // rust: assert_eq!(q.len(), 1);
    // rust: assert_quad(q[0], ([4.0, 4.0, 54.0, 54.0], [0.0, 0.0, 1.0, 1.0]));
}
pub fn blit_sprite_nine_slices_a_sprite_whose_metadata_says_so() void {
}
        // Vanilla's tooltip/frame: 100x100, border 10, stretched centre.
    // rust: let n = faithful(
    // rust: r#"{"gui":{"scaling":{"type":"nine_slice","width":100,"height":100,"border":10,"stretch_inner":true}}}"#,
    // rust: );
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw_sprite(
    // rust: &mut batch,
    // rust: sprite(100, 100),
    // rust: Some(n),
    // rust: [10.0, 10.0, 160.0, 26.0],
    // rust: u32::MAX,
    // rust: );
    // rust: let q = quads(&batch);
    // rust: assert_eq!(q.len(), 9);
        // The corners keep their 10 pixels instead of stretching with the box.
    // rust: assert_quad(q[0], ([10.0, 10.0, 20.0, 20.0], [0.0, 0.0, 0.1, 0.1]));
    // rust: assert_quad(q[5], ([160.0, 26.0, 170.0, 36.0], [0.9, 0.9, 1.0, 1.0]));
}
pub fn blit_sprite_stretches_a_sprite_without_metadata() void {
}
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw_sprite(
    // rust: &mut batch,
    // rust: sprite(9, 9),
    // rust: None,
    // rust: [0.0, 0.0, 27.0, 18.0],
    // rust: u32::MAX,
    // rust: );
    // rust: let q = quads(&batch);
    // rust: assert_eq!(q.len(), 1);
    // rust: assert_quad(q[0], ([0.0, 0.0, 27.0, 18.0], [0.0, 0.0, 1.0, 1.0]));
}
pub fn borders_shrink_to_half_the_drawn_size() void {
}
    // rust: let n = NineSlice {
    // rust: width: 20,
    // rust: height: 20,
    // rust: border: [8; 4],
    // rust: stretch_inner: true,
}
    // rust: let mut batch = HudBatch::new([640, 480]);
        // 9 wide: borders of floor(9 / 2) = 4, as vanilla's integer division.
    // rust: draw_nine_slice(
    // rust: &mut batch,
    // rust: sprite(20, 20),
    // rust: n,
    // rust: [0.0, 0.0, 9.0, 30.0],
    // rust: u32::MAX,
    // rust: );
    // rust: let q = quads(&batch);
    // rust: assert_quad(q[0], ([0.0, 0.0, 4.0, 8.0], [0.0, 0.0, 0.2, 0.4]));
    // rust: assert_quad(q[2], ([5.0, 0.0, 9.0, 8.0], [0.8, 0.0, 1.0, 0.4]));
}
pub fn append_fields_highlight_the_whole_value_and_blink_their_cursor() void {
}
//         use crate::hud::Blend;
    // rust: let atlas = HudAtlas::build(Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let end = 10.0 + HudBatch::text_width(&atlas, "abc") + 1.0;
    // rust: let span = |b: &HudBatch, r: &std::ops::Range<u32>| {
    // rust: let v = &b.vertices[r.start as usize..r.end as usize];
    // rust: let xs = v.iter().map(|v| v.pos[0]);
    // rust: let ys = v.iter().map(|v| v.pos[1]);
    // rust: (
    // rust: xs.clone().fold(f32::MAX, f32::min),
    // rust: xs.fold(f32::MIN, f32::max),
    // rust: ys.clone().fold(f32::MAX, f32::min),
    // rust: ys.fold(f32::MIN, f32::max),
    // rust: )
}
        // Select All in the creative search: inverted white, then blue added,
        // from one pixel before the text to the cursor, 11 high.
    // rust: let mut b = HudBatch::new([854, 480]);
    // rust: append_field(
    // rust: &mut b,
    // rust: &atlas,
    // rust: "abc",
    // rust: (10.0, 20.0, 80.0),
    // rust: (u32::MAX, true),
    // rust: 50,
    // rust: true,
    // rust: true,
    // rust: 0,
    // rust: );
    // rust: let blends: Vec<_> = b.blends.iter().map(|(_, blend)| *blend).collect();
    // rust: assert_eq!(blends, vec![Blend::Invert, Blend::Additive]);
    // rust: for (r, _) in &b.blends {
    // rust: assert_eq!(span(&b, r), (9.0, end, 19.0, 30.0));
}
        // The anvil keeps its text colour; 300 ms later the cursor is hidden.
    // rust: let mut b = HudBatch::new([854, 480]);
    // rust: append_field(
    // rust: &mut b,
    // rust: &atlas,
    // rust: "abc",
    // rust: (10.0, 20.0, 103.0),
    // rust: (u32::MAX, true),
    // rust: 50,
    // rust: true,
    // rust: false,
    // rust: 300,
    // rust: );
    // rust: let blends: Vec<_> = b.blends.iter().map(|(_, blend)| *blend).collect();
    // rust: assert_eq!(blends, vec![Blend::Additive]);
    // rust: let quads = |ms| {
    // rust: let mut b = HudBatch::new([854, 480]);
    // rust: append_field(
    // rust: &mut b,
    // rust: &atlas,
    // rust: "abc",
    // rust: (10.0, 20.0, 103.0),
    // rust: (0, true),
    // rust: 50,
    // rust: false,
    // rust: false,
    // rust: ms,
    // rust: );
    // rust: b.vertices.len()
}
    // rust: assert!(quads(300) < quads(600));
        // A full field shows a bar on its last pixel instead of an underscore.
    // rust: let mut b = HudBatch::new([854, 480]);
    // rust: append_field(
    // rust: &mut b,
    // rust: &atlas,
    // rust: "abc",
    // rust: (10.0, 20.0, 80.0),
    // rust: (u32::MAX, true),
    // rust: 3,
    // rust: false,
    // rust: true,
    // rust: 0,
    // rust: );
    // rust: let bar = b.vertices.len() as u32 - 6..b.vertices.len() as u32;
    // rust: assert_eq!(span(&b, &bar), (end - 1.0, end, 19.0, 30.0));
}
pub fn held_scrollbars_follow_the_pointer_and_stop_at_the_ends() void {
}
        // A 100-pixel list holding 400: the thumb is 25 -> 32 high, so a
        // pixel of drag scrolls 300 / 68 pixels (AbstractScrollArea.mouseDragged).
    // rust: let (top, bottom, content) = (0.0, 100.0, 400.0);
    // rust: let mut s = Scroll::default();
    // rust: assert!(!s.press((50.0, 10.0), 100.0, top, bottom, content));
    // rust: assert!(s.press((103.0, 10.0), 100.0, top, bottom, content));
    // rust: s.drag(20.0, top, bottom, content);
    // rust: assert!((s.amount - 10.0 * 300.0 / 68.0).abs() < 1e-3);
    // rust: s.drag(150.0, top, bottom, content);
    // rust: assert_eq!(s.amount, 300.0);
    // rust: s.drag(-5.0, top, bottom, content);
    // rust: assert_eq!(s.amount, 0.0);
    // rust: s.release();
    // rust: s.drag(50.0, top, bottom, content);
    // rust: assert_eq!(s.amount, 0.0);
        // Nothing to scroll: the column doesn't take the press.
    // rust: assert!(!s.press((103.0, 10.0), 100.0, top, bottom, 90.0));
    // rust: s.wheel(-2.0, 18.0, top, bottom, content);
    // rust: assert_eq!(s.amount, 36.0);
}
pub fn edit_box_clicks_place_the_cursor_and_select() void {
}
    // rust: let atlas = HudAtlas::build(Path::new("/nonexistent/horizon-test-assets")).unwrap();
    // rust: let mut e = EditBox::new(10.0, 0.0, 200.0, 20.0);
    // rust: e.set_value("hello world");
    // rust: let at = |e: &EditBox, s: &str| e.text_x() + atlas.font.width(s);
        // findClickedPositionInText: the characters left of the pointer.
    // rust: e.click(&atlas, at(&e, "hello "), false, false);
    // rust: assert_eq!((e.cursor, e.highlight), (6, 6));
        // Shift extends the selection from the anchor.
    // rust: e.click(&atlas, at(&e, "hello wor"), true, false);
    // rust: assert_eq!(e.selected_text(), "wor");
        // selectWord: the word and the spaces after it.
    // rust: e.click(&atlas, at(&e, "he"), false, true);
    // rust: assert_eq!(e.selected_text(), "hello ");
        // onDrag from a click: left of the text is its start.
    // rust: e.click(&atlas, at(&e, "hello "), false, false);
    // rust: e.drag_to(&atlas, e.text_x() - 5.0);
    // rust: assert_eq!((e.cursor, e.highlight), (0, 6));
}
pub fn edit_box_editing() void {
}
    // rust: let mut e = EditBox::new(0.0, 0.0, 100.0, 20.0);
    // rust: e.max_length = 10;
    // rust: e.insert_text("hello world");
    // rust: assert_eq!(e.value, "hello worl");
    // rust: e.set_cursor(5, false);
    // rust: assert_eq!(e.word_position(-1), 0);
    // rust: assert_eq!(e.word_position(1), 6);
    // rust: e.delete_chars(-2);
    // rust: assert_eq!(e.value, "hel worl");
    // rust: e.set_cursor(0, false);
    // rust: e.set_cursor(3, true);
    // rust: assert_eq!(e.selected_text(), "hel");
    // rust: e.insert_text("é§x");
    // rust: assert_eq!(e.value, "éx worl");
    // rust: assert_eq!(e.cursor, 2);
}
pub fn word_position_steps_over_a_word_and_its_spaces() void {
}
    // rust: assert_eq!(word_position("hello world", -1, 11), 6);
    // rust: assert_eq!(word_position("hello world", -1, 6), 0);
    // rust: assert_eq!(word_position("hello   world", -1, 13), 8);
    // rust: assert_eq!(word_position("hello   world", 1, 5), 8);
        // From inside a word: back to its start, forward past it and its spaces.
    // rust: assert_eq!(word_position("hello world", -1, 8), 6);
    // rust: assert_eq!(word_position("hello world", 1, 2), 6);
        // The ends, and a position past the end.
    // rust: assert_eq!(word_position("hello", -1, 0), 0);
    // rust: assert_eq!(word_position("hello", 1, 5), 5);
    // rust: assert_eq!(word_position("hi", -1, 99), 0);
    // rust: assert_eq!(word_position("hi", 1, 99), 2);
}
pub fn multiline_words_split_at_any_whitespace() void {
}
        // Ctrl+Backspace at the end of `one\ntwo` deletes `two` only.
    // rust: assert_eq!(multiline_word_position("one\ntwo", -1, 7), 4);
        // From the end the search starts at the last character, as vanilla's does.
    // rust: assert_eq!(multiline_word_position("one\n", -1, 4), 0);
    // rust: assert_eq!(multiline_word_position("a b", -1, 3), 0);
    // rust: assert_eq!(multiline_word_position("one\n\ntwo", 1, 0), 5);
    // rust: assert_eq!(multiline_word_position("one\u{a0}two", 1, 0), 7);
    // rust: assert_eq!(multiline_word_position("", -1, 0), 0);
}
pub fn delete_words_removes_the_word_before_the_end() void {
}
    // rust: let mut v = "stone bricks".to_string();
    // rust: assert!(delete_words(&mut v, -1));
    // rust: assert_eq!(v, "stone ");
    // rust: assert!(delete_words(&mut v, -1));
    // rust: assert_eq!(v, "");
    // rust: assert!(!delete_words(&mut v, -1));
        // Characters, not bytes.
    // rust: let mut v = "a é§x".to_string();
    // rust: assert!(delete_words(&mut v, -1));
    // rust: assert_eq!(v, "a ");
        // Nothing after the end to delete.
    // rust: let mut v = "stone".to_string();
    // rust: assert!(!delete_words(&mut v, 1));
    // rust: assert_eq!(v, "stone");
}
pub fn a_pad_focused_tooltip_hangs_from_its_widgets_bottom_left() void {
}
    // rust: let screen = (427.0, 240.0);
    // rust: let widget = [100.0, 100.0, 150.0, 20.0];
        // Frame at 100, 121: lines 4 further in.
    // rust: assert_eq!(
    // rust: tooltip_under_position(screen, widget, (80.0, 10.0)),
    // rust: (104.0, 125.0)
    // rust: );
        // The screen's right edge moves it left, its bottom puts it over the widget.
    // rust: assert_eq!(
    // rust: tooltip_under_position(screen, [400.0, 100.0, 20.0, 20.0], (80.0, 10.0)),
    // rust: (343.0, 125.0)
    // rust: );
    // rust: assert_eq!(
    // rust: tooltip_under_position(screen, [100.0, 215.0, 150.0, 20.0], (80.0, 10.0)),
    // rust: (104.0, 200.0)
    // rust: );
}
    /// `MenuTooltipPositioner.positionTooltip`: the pointer's 12 px offset,
    /// the 5 px screen margin, and the 3 to 5 px the tooltip keeps from the
    /// widget's top or bottom edge.
pub fn a_menu_tooltip_stays_by_its_widget() void {
}
    // rust: let screen = (427, 240);
    // rust: let widget = [100, 100, 150, 20];
    // rust: let size = (80, 10);
        // Pointer at the widget's top edge: the tooltip drops 3 px, then
        // `getOffset`'s int division gives `height - 3` = 17 more.
    // rust: assert_eq!(
    // rust: menu_tooltip_position(screen, (100, 100), widget, size),
    // rust: (112, 120)
    // rust: );
        // Near the right edge its left side mirrors to the pointer's left.
    // rust: assert_eq!(
    // rust: menu_tooltip_position(screen, (400, 100), widget, size),
    // rust: (308, 120)
    // rust: );
        // A whole widget height from the edge, the offset is 5.
    // rust: assert_eq!(
    // rust: menu_tooltip_position(screen, (100, 117), widget, size),
    // rust: (112, 125)
    // rust: );
        // A widget too close to the bottom: the tooltip goes above it,
        // 203 - (10 + 6) - 17.
    // rust: assert_eq!(
    // rust: menu_tooltip_position(screen, (100, 200), [100, 200, 150, 20], size),
    // rust: (112, 170)
    // rust: );
}
}
