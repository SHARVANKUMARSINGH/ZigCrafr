//! Transpiled from Horizon Rust crate
package horizon_client_render_graphics_style

import "core:fmt"
import "core:mem"
import "core:math"

// The look of Horizon's graphics settings screen, in one place: sizes,
// colours and the controls it draws with. The screen (`graphics_ui`) only
// lays out rows and handles input; a menu theme replaces this module.
//
// It takes the design system's Blocks palette (`horizon_theme::BLOCKS_DARK`,
// `docs/design-system.md`) in a lighter form: square panels of dark glass
// with a thin edge, so the world shows through, flat controls, and the violet
// face on the one main button, in vanilla's font.
// use crate::{
    // rust: hud::{HudAtlas, HudBatch},
    // rust: text::Text,
    // rust: ui,
}
// use horizon_theme::BLOCKS_DARK as B;

// What a setting costs in frame time, shown with its description.
Cost :: enum {
    None,
    Low,
    Medium,
    High,
    // Turning it on makes frames faster (culling, caching, batching).
    Saves,
}
    // rust: impl Cost {
label :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Cost::None => "No cost",
    // rust: Cost::Low => "Low cost",
    // rust: Cost::Medium => "Medium cost",
    // rust: Cost::High => "High cost",
    // rust: Cost::Saves => "Saves time",
}
}
    // `0xRRGGBB`: the palette's success, warn and danger.
rgb :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Cost::None => B.ink_soft,
    // rust: Cost::Low | Cost::Saves => B.success,
    // rust: Cost::Medium => B.warn,
    // rust: Cost::High => B.danger,
}
}
}

// `0xRRGGBB` and an alpha in the HUD's colour encoding.
    // rust: const fn hex(c: u32, a: u8) -> u32 {
    // rust: (a as u32) << 24 | (c & 0xff) << 16 | (c >> 8 & 0xff) << 8 | (c >> 16 & 0xff)
}
// The plate and the strip: the page's dark, see-through, so the world shows behind them.
GLASS :: hex(B.page, 118)
// Their 1 px edge.
EDGE :: hex(B.ink, 26)
// A group's panel, a little lighter than the plate it sits on.
GROUP :: hex(B.ink, 11)
// A hovered or focused row, lit on its group's panel.
HOVER :: hex(B.ink, 18)
// The open page in the page list.
OPEN :: hex(B.ink, 26)
// The rule under the plate's heading, and between two rows of a group.
HEAD_RULE :: hex(B.ink, 31)
ROW_RULE :: hex(B.ink, 15)
// Fields, boxes and the value stepper: sunk, see-through.
WELL :: hex(B.outline, 102)
// A button, a slider's track, the scroller's thumb.
BUTTON :: hex(B.ink, 20)
BUTTON_HOVER :: hex(B.ink, 41)
TRACK :: hex(B.ink, 64)
HANDLE :: hex(B.ink, 255)
// The one main button.
FACE :: hex(B.face, 255)
FACE_HOVER :: hex(0x6a50e6, 255)
// A tick box's edge when off.
BOX_EDGE :: hex(B.ink_soft, 89)
OUTLINE :: hex(B.outline, 255)
ACCENT :: hex(B.accent, 255)
// Vanilla's white text, and its grey for what can't be used now.
WHITE :: u32::MAX
MUTED :: hex(B.muted, 255)
// A page that isn't open, a value at rest.
SOFT :: hex(B.ink_soft, 255)
// Vanilla's grey for a tooltip's lines under its first (`ChatFormatting.GRAY`).
GREY :: hex(0xaaaaaa, 255)
// A light veil over the backdrop, under the panels.
VEIL :: hex(B.page, 77)

// Sizes in GUI pixels.
// Shorter screens than this (a 720p window at scale 3) keep a narrower margin on top.
TITLED :: 300.0
ROW :: 20.0
// A group's name over its panel, and a page's over its groups while searching.
GROUP_ROW :: 14.0
PAGE_ROW :: 16.0
// Space under a group's panel, and more before the next page's name.
GROUP_GAP :: 10.0
PAGE_GAP :: 6.0
// The control on the right of a row (a button, a box or a slider), and the
// left column: the search field, the page list and the buttons.
CONTROL_W :: 112.0
CONTROL_H :: 16.0
SEARCH_H :: 16.0
// Vanilla's scroller: the column `ui::Scroll::press` takes.
SCROLLER_W :: 6.0
// The strip under the plate that describes a setting.
DOCK_H :: 50.0
BUTTON_H :: 20.0
// A row's name and control, from its group panel's edges.
INSET :: 10.0

fill :: proc(batch: ^HudBatch, atlas: ^HudAtlas, h]: [f32; 4], color: u32) {
}
    // rust: batch.fill(atlas, x, y, w, h, color);
}
// A 1 px ring inside `rect`: the keyboard or controller focus, in white as vanilla draws it.
ring :: proc(batch: ^HudBatch, atlas: ^HudAtlas, h]: [f32; 4], color: u32) {
}
    // rust: batch.fill(atlas, x, y, w, 1.0, color);
    // rust: batch.fill(atlas, x, y + h - 1.0, w, 1.0, color);
    // rust: batch.fill(atlas, x, y + 1.0, 1.0, h - 2.0, color);
    // rust: batch.fill(atlas, x + w - 1.0, y + 1.0, 1.0, h - 2.0, color);
}
// The screen's plate, and the strip under it: dark glass with a thin edge.
panel :: proc(batch: ^HudBatch, atlas: ^HudAtlas, rect: [f32; 4]) {
}
    // rust: fill(batch, atlas, rect, GLASS);
    // rust: ring(batch, atlas, rect, EDGE);
}
// A group's panel on the plate, its rows on it.
group :: proc(batch: ^HudBatch, atlas: ^HudAtlas, rect: [f32; 4]) {
}
    // rust: fill(batch, atlas, rect, GROUP);
}
// A sunk well: the search field, the value stepper.
well :: proc(batch: ^HudBatch, atlas: ^HudAtlas, rect: [f32; 4]) {
}
    // rust: fill(batch, atlas, rect, WELL);
}
// The scroller: a faint track and its thumb.
scroller :: proc(batch: ^HudBatch, atlas: ^HudAtlas, track: [f32; 4], thumb: [f32; 4]) {
}
    // rust: fill(batch, atlas, track, ROW_RULE);
    // rust: fill(batch, atlas, thumb, TRACK);
}
// `text` cut to `width` with an ellipsis, as a long name gives way to its control.
fit :: proc(atlas: ^HudAtlas, text: string, width: f32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if atlas.font.width(text) <= width {
    // rust: return text.to_owned();
}
    // rust: let mut out = String::new();
    // rust: for c in text.chars() {
    // rust: if atlas.font.width(&format!("{out}{c}...")) > width {
    // rust: break;
}
    // rust: out.push(c);
}
    // rust: format!("{}...", out.trim_end())
}
// A 12 px tick box ending at `right`, centred in the row at `y`: its edge in the accent when on.
checkbox :: proc(batch: ^HudBatch, atlas: ^HudAtlas, right: f32, y: f32, on: bool, live: bool) {
}
    // rust: let rect = [right - 12.0, y + 4.0, 12.0, 12.0];
    // rust: fill(batch, atlas, rect, WELL);
    // rust: let edge = match (on, live) {
    // rust: (true, true) => ACCENT,
    // rust: (true, false) => MUTED,
    // rust: (false, _) => BOX_EDGE,
}
    // rust: ring(batch, atlas, rect, edge);
    // rust: if on {
    // rust: tick(batch, atlas, rect[0] + 1.0, rect[1] + 2.0, edge);
}
}
// A pixel tick, 10 by 8, over its own shadow.
tick :: proc(batch: ^HudBatch, atlas: ^HudAtlas, x: f32, y: f32, color: u32) {
}
    // rust: const TICK: [&str; 8] = [
    // rust: "         #",
    // rust: "        ##",
    // rust: "       ## ",
    // rust: "#     ##  ",
    // rust: "##   ##   ",
    // rust: " ## ##    ",
    // rust: "  ###     ",
    // rust: "   #      ",
    // rust: ];
    // rust: for (j, row) in TICK.iter().enumerate() {
    // rust: for (i, c) in row.chars().enumerate() {
    // rust: if c == '#' {
    // rust: let (px, py) = (x + i as f32, y + j as f32);
    // rust: fill(batch, atlas, [px + 1.0, py + 1.0, 1.0, 1.0], OUTLINE);
    // rust: fill(batch, atlas, [px, py, 1.0, 1.0], color);
}
}
}
}
// A flat button with its label centred: Undo, Calibrate..., and Done in the
// violet (`primary`). Pointed at or focused, vanilla's white edge.
    // rust: pub fn button(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: rect: [f32; 4],
    // rust: label: &Text,
    // rust: (hover, live, primary): (bool, bool, bool),
    // rust: ) {
    // rust: let [x, y, w, h] = rect;
    // rust: let face = match (live, primary, hover) {
    // rust: (false, _, _) => WELL,
    // rust: (true, true, false) => FACE,
    // rust: (true, true, true) => FACE_HOVER,
    // rust: (true, false, false) => BUTTON,
    // rust: (true, false, true) => BUTTON_HOVER,
}
    // rust: fill(batch, atlas, rect, face);
    // rust: if hover && live {
    // rust: ring(batch, atlas, rect, WHITE);
}
    // rust: let color = if live { WHITE } else { MUTED };
    // rust: let ty = y + ((h - 8.0) / 2.0).floor();
    // rust: scrolling_label(batch, atlas, label, [x + 2.0, ty, w - 4.0], (y, h), color);
}
// A widget label of `[left, y, width]` inside the widget's `(top, height)`: centred when it fits,
// else slid (vanilla `AbstractWidget.extractScrollingStringOverContents`) and clipped to the box.
    // rust: fn scrolling_label(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: text: &Text,
    // rust: [left, y, width]: [f32; 3],
    // rust: (top, height): (f32, f32),
    // rust: color: u32,
    // rust: ) {
    // rust: ui::scrolling_text(
    // rust: batch,
    // rust: atlas,
    // rust: text,
    // rust: left,
    // rust: left + width,
    // rust: top,
    // rust: top + height,
    // rust: y,
    // rust: color,
    // rust: );
}
// A slider: its value over a thin track filled in the accent up to the handle at `position`.
    // rust: pub fn slider(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: rect: [f32; 4],
    // rust: value: &Text,
    // rust: position: f32,
    // rust: (hover, live): (bool, bool),
    // rust: ) {
    // rust: let [x, y, w, h] = rect;
    // rust: let color = if live { WHITE } else { MUTED };
    // rust: scrolling_label(
    // rust: batch,
    // rust: atlas,
    // rust: value,
    // rust: [x + 2.0, y + 1.0, w - 4.0],
    // rust: (y, h),
    // rust: color,
    // rust: );
    // rust: let line = y + h - 3.0;
    // rust: let at = x + (position.clamp(0.0, 1.0) * (w - 4.0)).round();
    // rust: fill(batch, atlas, [x, line, w, 2.0], TRACK);
    // rust: fill(
    // rust: batch,
    // rust: atlas,
    // rust: [x, line, at - x, 2.0],
    // rust: if live { ACCENT } else { MUTED },
    // rust: );
    // rust: let handle = [at, line - 3.0, 4.0, 8.0];
    // rust: fill(batch, atlas, handle, if live { HANDLE } else { MUTED });
    // rust: if hover && live {
    // rust: ring(batch, atlas, [at - 1.0, line - 4.0, 6.0, 10.0], ACCENT);
}
}
// A value that a press steps through: in a well, between the arrows that say so.
    // rust: pub fn cycler(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: rect: [f32; 4],
    // rust: value: &Text,
    // rust: (hover, live): (bool, bool),
    // rust: ) {
    // rust: let [x, y, w, h] = rect;
    // rust: well(batch, atlas, rect);
    // rust: if hover && live {
    // rust: ring(batch, atlas, rect, WHITE);
}
    // rust: let ty = y + ((h - 8.0) / 2.0).floor();
    // rust: let arrows = if hover && live { WHITE } else { MUTED };
    // rust: batch.text_styled(atlas, &Text::literal("<"), x + 3.0, ty, arrows, true);
    // rust: batch.text_styled(atlas, &Text::literal(">"), x + w - 8.0, ty, arrows, true);
    // rust: let color = match (live, hover) {
    // rust: (false, _) => MUTED,
    // rust: (true, true) => WHITE,
    // rust: (true, false) => SOFT,
}
    // rust: scrolling_label(batch, atlas, value, [x + 9.0, ty, w - 18.0], (y, h), color);
}
// A screen's title, centred at the top (split-screen profiles).
title :: proc(batch: ^HudBatch, atlas: ^HudAtlas, text: ^Text) {
}
    // rust: let w = batch.width;
    // rust: ui::centered_text(batch, atlas, text, 0.0, 12.0, w, u32::MAX);
}
// The cost's colour in the HUD's encoding: the square beside its name.
cost_color :: proc(cost: Cost) -> u {
    // Ported from Horizon
    return {}
}
    // rust: hex(cost.rgb(), 255)
}

    // rust: mod tests {
//     use super::*;

atlas :: proc() -> H {
    // Ported from Horizon
    return {}
}
    // rust: HudAtlas::build(std::path::Path::new("/nonexistent/horizon-test-assets")).unwrap()
}

x_span :: proc(batch: ^HudBatch, plain: ^HudBatch) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let label = |v: &&crate::hud::HudVertex| !plain.vertices.iter().any(|p| p.pos == v.pos);
    // rust: batch
    // rust: .vertices
    // rust: .iter()
    // rust: .filter(label)
    // rust: .map(|v| v.pos[0])
    // rust: .fold((f32::INFINITY, f32::NEG_INFINITY), |(lo, hi), x| {
    // rust: (lo.min(x), hi.max(x))
    // rust: })
}

    // A label wider than its widget slides inside the widget's box instead of being cut by
    // characters; a short one stays centred.
long_labels_stay_in_the_widget_and_short_ones_centred :: proc() {
}
    // rust: let atlas = atlas();
    // rust: let rect = [10.0, 20.0, 100.0, 20.0];
    // rust: let long = Text::literal("Graphics API: Prefer Vulkan (Experimental)");
    // rust: assert!(atlas.font.width_text(&long.resolved()) > rect[2]);
    // rust: let short = Text::literal("Done");
    // rust: let short_w = atlas.font.width_text(&short.resolved());
    // rust: let draws: [(&str, fn(&mut HudBatch, &HudAtlas, [f32; 4], &Text)); 3] = [
    // rust: ("button", |b, a, r, t| {
    // rust: button(b, a, r, t, (false, true, false))
    // rust: }),
    // rust: ("slider", |b, a, r, t| {
    // rust: slider(b, a, r, t, 0.5, (false, true))
    // rust: }),
    // rust: ("cycler", |b, a, r, t| cycler(b, a, r, t, (false, true))),
    // rust: ];
    // rust: for (name, draw) in draws {
    // rust: let mut plain = HudBatch::new([640, 480]);
    // rust: draw(&mut plain, &atlas, rect, &Text::empty());
    // rust: let base = plain.vertices.len();
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw(&mut batch, &atlas, rect, &long);
    // rust: assert!(batch.vertices.len() > base, "{name}: long label drawn");
            // The widget's own fill, track and handle also draw: only the label's vertices count.
    // rust: let label = batch
    // rust: .vertices
    // rust: .iter()
    // rust: .filter(|v| !plain.vertices.iter().any(|p| p.pos == v.pos));
    // rust: for v in label {
    // rust: assert!(
    // rust: (rect[0]..=rect[0] + rect[2]).contains(&v.pos[0])
    // rust: && (rect[1]..=rect[1] + rect[3]).contains(&v.pos[1]),
    // rust: "{name}: {:?} outside the widget",
    // rust: v.pos
    // rust: );
}
            // The label's own glyphs (past the widget's fill) start centred.
    // rust: let mut batch = HudBatch::new([640, 480]);
    // rust: draw(&mut batch, &atlas, rect, &short);
    // rust: let (lo, hi) = x_span(&batch, &plain);
    // rust: let middle = (lo + hi) / 2.0;
    // rust: let want = rect[0] + rect[2] / 2.0;
    // rust: assert!(
    // rust: (middle - want).abs() <= short_w / 2.0 + 2.0 && (middle - want).abs() < 3.0,
    // rust: "{name}: centre {middle}, want {want}"
    // rust: );
}
}
}
