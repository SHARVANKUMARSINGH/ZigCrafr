//! Transpiled from Horizon Rust crate
//! Module: horizon-client_extras_hud
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! HUD boxes in the corners: the minimap's place and mods' panels, small
//! boxes in GUI pixels stacked per corner (`docs/extras.md`).
// use crate::{
    // rust: extras::Corner,
    // rust: hud::{HudAtlas, HudBatch, Rect, rgba},
}

/// The gap between an overlay and the screen edge or the next overlay.
pub const MARGIN: f32 = 2.0;
pub const BACKGROUND: u32 = 0x7800_0000;

/// Where the next overlay goes in each corner.
pub const Corners = struct {
    width: f32,
    height: f32,
    /// Distance from the corner's top or bottom edge, per `Corner::ALL`.
    used: [f32,
};
    // rust: impl Corners {
    /// `top_right` reserves the status effect icons' rows.
pub fn new(width: f32, height: f32, top_right: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: width,
    // rust: height,
    // rust: used: [0.0, top_right, 0.0, 0.0],
}
}
    /// The top-left position of a `w` x `h` box in `corner`, below (or
    /// above) what the corner already holds.
pub fn place(self: *Self, corner: Corner, w: f32, h: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = Corner::ALL.iter().position(|c| *c == corner).unwrap_or(0);
    // rust: let edge = self.used[i] + MARGIN;
    // rust: self.used[i] = edge + h;
    // rust: let x = if corner.left() {
    // rust: MARGIN
    // rust: } else {
    // rust: self.width - MARGIN - w
}
    // rust: let y = if corner.top() {
    // rust: edge
    // rust: } else {
    // rust: self.height - edge - h
}
    // rust: (x, y)
}
}

/// How the minimap shows: its corner and side in GUI pixels, its image (an
/// atlas rect), the player arrow (the map item's decoration sprite) turned
/// `arrow` degrees clockwise from up, and the rim's N toward `north` when the
/// map turns.
pub const MinimapLook = struct {
    corner: Corner,
    size: f32,
    image: Rect,
    arrow: f32,
    north: Option<(f32,
};
    // rust: pub fn draw_minimap(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: corners: &mut Corners,
    // rust: look: &MinimapLook,
    // rust: ) {
    // rust: let MinimapLook {
    // rust: corner,
    // rust: size,
    // rust: image,
    // rust: arrow,
    // rust: north,
    // rust: } = *look;
    // rust: let (x, y) = corners.place(corner, size, size);
    // rust: batch.rect_uv(x, y, size, size, image, u32::MAX);
    // rust: let (cx, cy) = (x + size / 2.0, y + size / 2.0);
    // rust: if let Some(r) = atlas.sprites.get("map/decorations/player").copied() {
        // MapRenderer's decorations draw the sprite flipped: its arrow
        // points down the texture, so up on screen is half a turn.
    // rust: let (s, c) = (arrow + 180.0).to_radians().sin_cos();
    // rust: let p = |dx: f32, dy: f32| [cx + dx * c - dy * s, cy + dx * s + dy * c];
    // rust: let h = 4.0;
    // rust: batch.quad(
    // rust: [p(-h, h), p(h, h), p(h, -h), p(-h, -h)],
    // rust: [[r.u0, r.v0], [r.u1, r.v0], [r.u1, r.v1], [r.u0, r.v1]],
    // rust: u32::MAX,
    // rust: );
}
    // rust: if let Some((nx, ny)) = north {
    // rust: let reach = size / 2.0 - 6.0;
    // rust: let tw = HudBatch::text_width(atlas, "N");
    // rust: let (tx, ty) = (cx + nx * reach - tw / 2.0, cy + ny * reach - 4.0);
    // rust: batch.text(
    // rust: atlas,
    // rust: "N",
    // rust: tx.round(),
    // rust: ty.round(),
    // rust: rgba(255, 255, 255, 255),
    // rust: true,
    // rust: );
}
}

/// A box of text lines (a mod's HUD panel): `(text, 0xRRGGBB)` each.
    // rust: pub fn draw_lines(
    // rust: batch: &mut HudBatch,
    // rust: atlas: &HudAtlas,
    // rust: corners: &mut Corners,
    // rust: corner: Corner,
    // rust: lines: &[(&str, u32)],
    // rust: ) {
    // rust: if lines.is_empty() {
    // rust: return;
}
    // rust: let w = lines
    // rust: .iter()
    // rust: .map(|(text, _)| HudBatch::text_width(atlas, text))
    // rust: .fold(0.0, f32::max)
    // rust: + 4.0;
    // rust: let h = 10.0 * lines.len() as f32 + 2.0;
    // rust: let (x, y) = corners.place(corner, w, h);
    // rust: batch.fill(atlas, x, y, w, h, BACKGROUND);
    // rust: for (i, (text, color)) in lines.iter().enumerate() {
    // rust: let [_, r, g, b] = color.to_be_bytes();
    // rust: let y = y + 2.0 + 10.0 * i as f32;
    // rust: batch.text(atlas, text, x + 2.0, y, rgba(r, g, b, 255), true);
}
}

    // rust: mod tests {
//     use super::*;

pub fn corners_stack_away_from_their_edge() void {
}
    // rust: let mut c = Corners::new(400.0, 300.0, 26.0);
    // rust: assert_eq!(c.place(Corner::TopLeft, 50.0, 12.0), (2.0, 2.0));
    // rust: assert_eq!(c.place(Corner::TopLeft, 70.0, 20.0), (2.0, 16.0));
        // Top right starts under the effect icons.
    // rust: assert_eq!(c.place(Corner::TopRight, 50.0, 12.0), (348.0, 28.0));
    // rust: assert_eq!(c.place(Corner::BottomRight, 50.0, 12.0), (348.0, 286.0));
    // rust: assert_eq!(c.place(Corner::BottomRight, 50.0, 10.0), (348.0, 274.0));
    // rust: assert_eq!(c.place(Corner::BottomLeft, 10.0, 10.0), (2.0, 288.0));
}
}
