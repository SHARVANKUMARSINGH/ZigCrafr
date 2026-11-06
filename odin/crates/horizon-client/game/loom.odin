//! Transpiled from Horizon Rust crate
package horizon_client_loom

import "core:fmt"
import "core:mem"
import "core:math"

// The loom screen (`LoomScreen`): the scrolling pattern list, the banner
// preview and the six-layer error. The menu itself (`LoomMenu`: slots,
// selectable patterns, the pattern buttons, quick moves, the result) runs on
// the verified engine, `horizon_client::menu`, through `Game::menu_session`.
// use super::{Game, stations::Kind};
// use horizon_client::{
    // rust: banner::{self, BannerLayer},
    // rust: hud::{HudBatch, Rect, rgba},
    // rust: items::ItemStack,
    // rust: screen_layout::{self, LoomView, ScreenDraw},
}
// use std::sync::Arc;

// Per-menu loom state: `selectablePatterns`, the selected index and the
// screen's scroller.
    // rust: pub(super) struct LoomState {
    // rust: pub(super) patterns: Vec<Arc<str>>,
    // rust: pub(super) selected: Option<usize>,
    // `displayPatterns`: the pattern buttons are shown.
    // rust: pub(super) display: bool,
    // rust: pub(super) has_max: bool,
    // rust: pub(super) scroll: f32,
    // rust: pub(super) start_row: usize,
    // rust: pub(super) scrolling: bool,
    // The inputs the screen last saw (`bannerStack`, `dyeStack`, `patternStack`).
    // rust: last_inputs: [Option<ItemStack>; 3],
}
    // rust: impl LoomState {
total_rows :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.patterns.len().div_ceil(4)
}
offscreen_rows :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.total_rows() as i32 - 4
}
    // `startRow` for a scroller position.
row_for :: proc(self: ^Self, offs: f32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((offs * self.offscreen_rows() as f32 + 0.5) as i32).max(0) as usize
}
}

BUTTON :: 14.0

inside :: proc(p: (f32) {
}
    // rust: p.0 >= x && p.1 >= y && p.0 < x + w && p.1 < y + h
}
    // rust: impl Game<'_> {
    // `LoomScreen.containerChanged`: the error flag, whether the pattern
    // buttons show (only when an input changed), and the scroller reset.
    // rust: pub(super) fn loom_screen_changed(&mut self) {
    // rust: let Some(s) = self.station.as_mut().filter(|s| s.kind == Kind::Loom) else {
    // rust: return;
}
    // rust: let inputs = [
    // rust: s.inputs[0].clone(),
    // rust: s.inputs[1].clone(),
    // rust: s.inputs[2].clone(),
    // rust: ];
    // rust: let l = &mut s.loom;
    // rust: l.has_max = inputs[0].as_ref().is_some_and(banner::has_max_layers);
    // rust: if inputs != l.last_inputs {
    // rust: l.display =
    // rust: inputs[0].is_some() && inputs[1].is_some() && !l.has_max && !l.patterns.is_empty();
}
    // rust: if l.start_row >= l.total_rows() {
    // rust: l.start_row = 0;
    // rust: l.scroll = 0.0;
}
    // rust: l.last_inputs = inputs;
}
    // A sound the loom or stonecutter menu played: the result's once per
    // tick (`lastSoundTime`).
    // rust: pub(super) fn station_sound(&mut self, sound: &str) {
    // rust: let ticks = self.ticks;
    // rust: let Some(s) = self.station.as_mut() else {
    // rust: return;
}
    // rust: if s.last_sound == ticks {
    // rust: return;
}
    // rust: s.last_sound = ticks;
    // rust: let pos = s.pos;
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: self.audio.play(sound, Some(at), 1.0, 1.0);
}
    // `LoomScreen.mouseClicked` on a pattern button: `clickMenuButton`, and
    // the select sound when the menu took it.
loom_button :: proc(self: ^Self, index: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut taken = false;
    // rust: let flag = &mut taken;
    // rust: self.menu_session(|menu, env, _| {
    // rust: *flag = menu.button(env, index as i32);
    // rust: Some(*flag)
    // rust: });
    // rust: if taken {
    // rust: self.audio
    // rust: .play("minecraft:ui.loom.select_pattern", None, 1.0, 1.0);
    // rust: self.remote_station_button(index as i32);
}
    // rust: taken
}
    // A left click inside the loom's pattern grid or scroller.
    // rust: pub(super) fn loom_click(&mut self, local: (f32, f32)) -> bool {
    // rust: let Some(start_row) = self
    // rust: .station
    // rust: .as_ref()
    // rust: .filter(|s| s.loom.display)
    // rust: .map(|s| s.loom.start_row)
    // rust: else {
    // rust: return false;
}
    // rust: for row in 0..4 {
    // rust: for column in 0..4 {
    // rust: let index = (row + start_row) * 4 + column;
    // rust: let (x, y) = (60.0 + column as f32 * BUTTON, 13.0 + row as f32 * BUTTON);
    // rust: if inside(local, x, y, BUTTON, BUTTON) && self.loom_button(index) {
    // rust: return true;
}
}
}
    // rust: if inside(local, 119.0, 9.0, 12.0, 56.0)
    // rust: && let Some(s) = self.station.as_mut()
    // rust: {
    // rust: s.loom.scrolling = true;
    // rust: return true;
}
    // rust: false
}
    // The pattern buttons a controller can focus (GUI origin relative).
    // rust: pub(super) fn loom_targets(&self) -> Vec<[f32; 4]> {
    // rust: let Some(loom) = self.station.as_ref().map(|s| &s.loom).filter(|l| l.display) else {
    // rust: return Vec::new();
}
    // rust: (0..16)
    // rust: .filter(|i| (i / 4 + loom.start_row) * 4 + i % 4 < loom.patterns.len())
    // rust: .map(|i| {
    // rust: let (row, column) = (i / 4, i % 4);
    // rust: [
    // rust: 60.0 + column as f32 * BUTTON,
    // rust: 13.0 + row as f32 * BUTTON,
    // rust: BUTTON,
    // rust: BUTTON,
    // rust: ]
    // rust: })
    // rust: .collect()
}
    // `LoomScreen.mouseDragged` on the scroller.
    // rust: pub(super) fn loom_drag(&mut self) {
    // rust: let Some(size) = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .map(|r| [r.config.width, r.config.height])
    // rust: else {
    // rust: return;
}
    // rust: let (_, oy) = self.inventory_origin(&HudBatch::new(size));
    // rust: let cursor_y = self.cursor.1;
    // rust: let Some(l) = self.station.as_mut().map(|s| &mut s.loom) else {
    // rust: return;
}
    // rust: if l.scrolling && l.display && l.offscreen_rows() > 0 {
    // rust: let top = oy + 13.0;
    // rust: l.scroll = ((cursor_y - top - 7.5) / (56.0 - 15.0)).clamp(0.0, 1.0);
    // rust: l.start_row = l.row_for(l.scroll);
}
}
    // rust: pub(super) fn loom_release(&mut self) {
    // rust: if let Some(s) = self.station.as_mut() {
    // rust: s.loom.scrolling = false;
}
}
    // `LoomScreen.mouseScrolled`.
    // rust: pub(super) fn loom_scroll(&mut self, d: f32) {
    // rust: let Some(l) = self.station.as_mut().map(|s| &mut s.loom) else {
    // rust: return;
}
    // rust: let offscreen = l.offscreen_rows();
    // rust: if l.display && offscreen > 0 {
    // rust: l.scroll = (l.scroll - d / offscreen as f32).clamp(0.0, 1.0);
    // rust: l.start_row = l.row_for(l.scroll);
}
}
    // `GuiGraphicsExtractor.bannerPattern`: the banner flag model with its
    // layers in a 20x40 picture in picture at `(x, y)`.
    // rust: fn draw_banner_result(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: x: f32,
    // rust: y: f32,
    // rust: base: &str,
    // rust: layers: &[BannerLayer],
    // rust: ) {
    // rust: let banners = &self.stations().banners;
    // rust: let layers: Vec<(String, String)> = layers
    // rust: .iter()
    // rust: .map(|l| (banners.banner_texture(&l.pattern), l.color.to_string()))
    // rust: .collect();
    // rust: horizon_client::item_render::gui::draw_banner_result(
    // rust: &self.pack.item_renderer,
    // rust: &self.gui.atlas.sprites,
    // rust: batch,
    // rust: x,
    // rust: y,
    // rust: base,
    // rust: &layers,
    // rust: );
}
    // Paints `screen_layout` calls at the menu origin (ox, oy): the container
    // background and the dimmed world are drawn by the caller.
    // rust: pub(super) fn paint_screen(
    // rust: &self,
    // rust: batch: &mut HudBatch,
    // rust: ox: f32,
    // rust: oy: f32,
    // rust: draws: &[ScreenDraw],
    // rust: background: bool,
    // rust: ) -> Option<Vec<(horizon_client::text::Text, u32)>> {
    // rust: let atlas = &self.gui.atlas;
    // rust: let mut tooltip = None;
    // rust: let mut sheet: Option<String> = None;
    // rust: for d in draws {
    // rust: match d {
    // rust: ScreenDraw::Gradient { .. } => {}
    // rust: ScreenDraw::Blit {
    // rust: texture,
    // rust: x,
    // rust: y,
    // rust: w,
    // rust: h,
    // rust: tw,
    // rust: th,
    // rust: } => {
    // rust: if background {
    // rust: let name = texture
    // rust: .trim_start_matches("textures/")
    // rust: .trim_end_matches(".png");
    // rust: batch.sprite_region(
    // rust: atlas,
    // rust: name,
    // rust: [ox + *x as f32, oy + *y as f32, *w as f32, *h as f32],
    // rust: *tw as f32,
    // rust: *th as f32,
    // rust: );
}
}
    // rust: ScreenDraw::Sprite { id, x, y, .. } => batch.sprite(
    // rust: atlas,
    // rust: &format!("gui/sprites/{id}"),
    // rust: ox + *x as f32,
    // rust: oy + *y as f32,
    // rust: ),
    // rust: ScreenDraw::Banner {
    // rust: base,
    // rust: layers,
    // rust: x0,
    // rust: y0,
    // rust: ..
    // rust: } => self.draw_banner_result(batch, ox + *x0 as f32, oy + *y0 as f32, base, layers),
    // rust: ScreenDraw::Tooltip { key } => {
    // rust: tooltip = Some(vec![(
    // rust: horizon_client::text::Text::literal(self.translate(key, key)),
    // rust: u32::MAX,
    // rust: )]);
}
    // rust: ScreenDraw::SpriteOf { id } => sheet = Some(id.clone()),
    // rust: ScreenDraw::Fill {
    // rust: x0,
    // rust: y0,
    // rust: x1,
    // rust: y1,
    // rust: color,
    // rust: } => {
    // rust: let c = *color as u32;
    // rust: batch.fill(
    // rust: atlas,
    // rust: ox + *x0 as f32,
    // rust: oy + *y0 as f32,
    // rust: (x1 - x0) as f32,
    // rust: (y1 - y0) as f32,
    // rust: rgba((c >> 16) as u8, (c >> 8) as u8, c as u8, (c >> 24) as u8),
    // rust: );
}
    // rust: ScreenDraw::Atlas { x0, y0, x1, y1, uv } => {
    // rust: if let Some(r) = sheet.as_ref().and_then(|n| atlas.sprites.get(n)).copied() {
    // rust: let (du, dv) = (r.u1 - r.u0, r.v1 - r.v0);
    // rust: let part = Rect {
    // rust: u0: r.u0 + uv[0] * du,
    // rust: u1: r.u0 + uv[1] * du,
    // rust: v0: r.v0 + uv[2] * dv,
    // rust: v1: r.v0 + uv[3] * dv,
    // rust: w: (x1 - x0) as u32,
    // rust: h: (y1 - y0) as u32,
}
    // rust: batch.rect_uv(
    // rust: ox + *x0 as f32,
    // rust: oy + *y0 as f32,
    // rust: (x1 - x0) as f32,
    // rust: (y1 - y0) as f32,
    // rust: part,
    // rust: u32::MAX,
    // rust: );
}
}
}
}
    // rust: tooltip
}
    // `LoomScreen.extractBackground` after the background (the verified
    // `screen_layout::loom`); returns the hovered pattern's tooltip.
    // rust: pub(super) fn draw_loom(
    // rust: &mut self,
    // rust: batch: &mut HudBatch,
    // rust: ox: f32,
    // rust: oy: f32,
    // rust: local: (f32, f32),
    // rust: ) -> Option<Vec<(horizon_client::text::Text, u32)>> {
    // rust: let s = self.station.as_ref()?;
    // rust: let l = &s.loom;
    // rust: let dye = s.inputs[1]
    // rust: .as_ref()
    // rust: .and_then(|d| self.items().get(&d.item))
    // rust: .and_then(|i| i.dye.clone())
    // rust: .unwrap_or_else(|| "white".to_owned());
    // rust: let result = s
    // rust: .result
    // rust: .as_ref()
    // rust: .and_then(|r| Some((banner::banner_color(&r.item)?, banner::layers(r))));
    // rust: let view = LoomView {
    // rust: width: 176,
    // rust: height: 166,
    // rust: left: 0,
    // rust: top: 0,
    // rust: has_banner: s.inputs[0].is_some(),
    // rust: has_dye: s.inputs[1].is_some(),
    // rust: has_pattern: s.inputs[2].is_some(),
    // rust: patterns: &l.patterns,
    // rust: selected: l.selected.map_or(-1, |i| i as i32),
    // rust: display: l.display,
    // rust: has_max: l.has_max,
    // rust: scroll: l.scroll,
    // rust: start_row: l.start_row,
    // rust: result,
    // rust: dye: &dye,
    // rust: mouse: local,
}
    // rust: let draws = screen_layout::loom(&view, &self.stations().banners);
    // rust: self.paint_screen(batch, ox, oy, &draws, false)
}
}

    // rust: mod tests {
//     use super::*;

scroller_rows_follow_the_offset :: proc() {
}
    // rust: let l = LoomState {
    // rust: patterns: (0..40)
    // rust: .map(|i| Arc::from(format!("p{i}").as_str()))
    // rust: .collect(),
    // rust: display: true,
    // rust: ..Default::default()
}
        // 40 patterns = 10 rows, 6 off screen.
    // rust: assert_eq!(l.offscreen_rows(), 6);
    // rust: assert_eq!(l.row_for(0.0), 0);
    // rust: assert_eq!(l.row_for(1.0), 6);
    // rust: assert_eq!(l.row_for(0.5), 3);
}
few_patterns_do_not_scroll :: proc() {
}
    // rust: let l = LoomState {
    // rust: patterns: (0..16)
    // rust: .map(|i| Arc::from(format!("p{i}").as_str()))
    // rust: .collect(),
    // rust: display: true,
    // rust: ..Default::default()
}
    // rust: assert_eq!(l.offscreen_rows(), 0);
}
}
