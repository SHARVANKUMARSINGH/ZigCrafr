//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_border_render
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The world border wall (`WorldBorderRenderer`, `WorldBorderRenderState`):
//! which border the camera is near, the wall's fade and status colour, the
//! cached vertex buffer of the four walls, the scrolling texture transform
//! and which walls are drawn. Kept free of GPU types so the parity fixture
//! can compare every value with vanilla's renderer.
// use crate::worldborder::{WorldBorder, jclamp, jmax, jmin, status_color};

/// `WorldBorderRenderer.RENDERING_OFFSET`.
pub const OFFSET: f64 = 0.01;

/// `WorldBorderRenderState`.
pub const BorderRenderState = struct {
    min_x: f64,
    max_x: f64,
    min_z: f64,
    max_z: f64,
    /// `BorderStatus.getColor`, set only when the wall is visible.
    tint: u32,
    alpha: f64,
};
    // rust: impl BorderRenderState {
    /// `closestBorder`: the four walls by distance from (x, z), nearest
    /// first (a stable sort of north, south, west, east), as
    /// `Direction.get2DDataValue` side indices and distances.
pub fn closest_border(self: *Self, x: f64, z: f64) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sides = [
    // rust: (2, z - self.min_z),
    // rust: (0, self.max_z - z),
    // rust: (1, x - self.min_x),
    // rust: (3, self.max_x - x),
    // rust: ];
        // Comparator.comparingDouble: Double.compare order, stable.
    // rust: sides.sort_by(|a, b| java_double_compare(a.1, b.1));
    // rust: sides
}
}
/// `Double.compare`.
pub fn java_double_compare(a: f64, b: f64) s {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::cmp::Ordering::*;
    // rust: if a < b {
    // rust: Less
    // rust: } else if a > b {
    // rust: Greater
    // rust: } else {
    // rust: let bits = |v: f64| {
    // rust: if v.is_nan() {
    // rust: 0x7ff8_0000_0000_0000u64 as i64
    // rust: } else {
    // rust: v.to_bits() as i64
}
}
    // rust: bits(a).cmp(&bits(b))
}
}

/// `WorldBorderRenderer.extract`.
    // rust: pub fn extract(
    // rust: border: &WorldBorder,
    // rust: partial: f32,
    // rust: camera: [f64; 3],
    // rust: render_distance: f64,
    // rust: state: &mut BorderRenderState,
    // rust: ) {
    // rust: let [min_x, min_z, max_x, max_z] = border.bounds_at(partial);
    // rust: state.min_x = min_x;
    // rust: state.max_x = max_x;
    // rust: state.min_z = min_z;
    // rust: state.max_z = max_z;
    // rust: let (x, z) = (camera[0], camera[2]);
    // rust: let deep_inside = x < max_x - render_distance
    // rust: && x > min_x + render_distance
    // rust: && z < max_z - render_distance
    // rust: && z > min_z + render_distance;
    // rust: let far_outside = x < min_x - render_distance
    // rust: || x > max_x + render_distance
    // rust: || z < min_z - render_distance
    // rust: || z > max_z + render_distance;
    // rust: if !deep_inside && !far_outside {
    // rust: let alpha = 1.0 - border.distance(x, z) / render_distance;
    // rust: state.alpha = jclamp(horizon_core::jmath::pow(alpha, 4.0), 0.0, 1.0);
    // rust: state.tint = status_color(border.status());
    // rust: } else {
    // rust: state.alpha = 0.0;
}
}

/// One `POSITION_TEX` vertex of the wall buffer: position relative to the
/// buffer origin and texture coordinates.
    // rust: pub type BorderVertex = [f32; 5];

/// What `WorldBorderRenderer.prepareDynamicTransforms` writes: the colour
/// modulator, the model offset of the buffer origin from the camera and
/// the texture matrix translation (both u and v).
pub const BorderTransforms = struct {
    color: [f32,
    model_offset: [f32,
    texture_offset: f32,
};

/// `WorldBorderRenderer`'s cached wall buffer.
pub const BorderRenderer = struct {
    needs_rebuild: bool,
    /// Set when `prepare` rebuilt the buffer (cleared by [`Self::take_rebuilt`]).
    rebuilt: bool,
    last_min_x: f64,
    last_min_z: f64,
    last_border: [f64,
    /// Four quads: south, west, north, east (`get2DDataValue` order).
    vertices: [BorderVertex,
};
    // rust: impl Default for BorderRenderer {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: needs_rebuild: true,
    // rust: rebuilt: false,
    // rust: last_min_x: 0.0,
    // rust: last_min_z: 0.0,
    // rust: last_border: [0.0; 4],
    // rust: vertices: [[0.0; 5]; 16],
}
}
}
/// `Mth.floor(double)`.
pub fn floor(v: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = v as i32;
    // rust: if v < f64::from(i) { i - 1 } else { i }
}
/// `Mth.ceil(double)`.
pub fn ceil(v: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = v as i32;
    // rust: if v > f64::from(i) { i + 1 } else { i }
}
/// `Mth.frac(double)`.
pub fn frac(v: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v - v.floor()
}
    // rust: impl BorderRenderer {
    /// `invalidate`: rebuild on the next prepare (e.g. after a resource reload).
pub fn invalidate(self: *Self) void {
}
    // rust: self.needs_rebuild = true;
}
    /// `prepare`: rebuilds the buffer when the border moved; returns whether
    /// the wall is drawn this frame.
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: state: &BorderRenderState,
    // rust: camera: [f64; 3],
    // rust: render_distance: f64,
    // rust: depth_far: f32,
    // rust: ) -> bool {
    // rust: if state.alpha <= 0.0 {
    // rust: return false;
}
    // rust: let half_height = depth_far;
    // rust: let v0 = (-frac(camera[1] * 0.5)) as f32;
    // rust: let v1 = v0 + half_height;
    // rust: let border = [state.min_x, state.min_z, state.max_x, state.max_z];
    // rust: if self.needs_rebuild || border != self.last_border {
    // rust: self.rebuild(
    // rust: state,
    // rust: render_distance,
    // rust: camera[2],
    // rust: camera[0],
    // rust: half_height,
    // rust: v1,
    // rust: v0,
    // rust: );
}
    // rust: true
}
    /// `rebuildWorldBorderBuffer`.
    // rust: fn rebuild(
    // rust: &mut self,
    // rust: state: &BorderRenderState,
    // rust: render_distance: f64,
    // rust: camera_z: f64,
    // rust: camera_x: f64,
    // rust: h: f32,
    // rust: v1: f32,
    // rust: v0: f32,
    // rust: ) {
    // rust: let border_min_x = state.min_x + OFFSET;
    // rust: let border_max_x = state.max_x - OFFSET;
    // rust: let border_min_z = state.min_z + OFFSET;
    // rust: let border_max_z = state.max_z - OFFSET;
    // rust: let min_z = jmax(f64::from(floor(camera_z - render_distance)), border_min_z);
    // rust: let max_z = jmin(f64::from(ceil(camera_z + render_distance)), border_max_z);
    // rust: let u0z = (floor(min_z) & 1) as f32 * 0.5;
    // rust: let u1z = (max_z - min_z) as f32 / 2.0;
    // rust: let min_x = jmax(f64::from(floor(camera_x - render_distance)), border_min_x);
    // rust: let max_x = jmin(f64::from(ceil(camera_x + render_distance)), border_max_x);
    // rust: let u0x = (floor(min_x) & 1) as f32 * 0.5;
    // rust: let u1x = (max_x - min_x) as f32 / 2.0;
    // rust: let (dx, dz) = ((max_x - min_x) as f32, (max_z - min_z) as f32);
    // rust: let south = (border_max_z - min_z) as f32;
    // rust: let east = (border_max_x - min_x) as f32;
    // rust: self.vertices = [
    // rust: [0.0, -h, south, u0x, v1],
    // rust: [dx, -h, south, u1x + u0x, v1],
    // rust: [dx, h, south, u1x + u0x, v0],
    // rust: [0.0, h, south, u0x, v0],
    // rust: [0.0, -h, 0.0, u0z, v1],
    // rust: [0.0, -h, dz, u1z + u0z, v1],
    // rust: [0.0, h, dz, u1z + u0z, v0],
    // rust: [0.0, h, 0.0, u0z, v0],
    // rust: [dx, -h, 0.0, u0x, v1],
    // rust: [0.0, -h, 0.0, u1x + u0x, v1],
    // rust: [0.0, h, 0.0, u1x + u0x, v0],
    // rust: [dx, h, 0.0, u0x, v0],
    // rust: [east, -h, dz, u0z, v1],
    // rust: [east, -h, 0.0, u1z + u0z, v1],
    // rust: [east, h, 0.0, u1z + u0z, v0],
    // rust: [east, h, dz, u0z, v0],
    // rust: ];
    // rust: self.last_border = [state.min_x, state.min_z, state.max_x, state.max_z];
    // rust: self.last_min_x = min_x;
    // rust: self.last_min_z = min_z;
    // rust: self.needs_rebuild = false;
    // rust: self.rebuilt = true;
}
    /// Whether the buffer was rebuilt since the last call (it must be
    /// uploaded again).
pub fn take_rebuilt(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.rebuilt)
}
    /// `prepareDynamicTransforms` at `Util.getMillis()` = `millis`.
    // rust: pub fn transforms(
    // rust: &self,
    // rust: state: &BorderRenderState,
    // rust: camera: [f64; 3],
    // rust: millis: i64,
    // rust: ) -> BorderTransforms {
    // rust: let channel = |shift: u32| ((state.tint >> shift) & 0xFF) as f32 / 255.0;
    // rust: let offset = (millis % 3000) as f32 / 3000.0;
    // rust: BorderTransforms {
    // rust: color: [channel(16), channel(8), channel(0), state.alpha as f32],
    // rust: model_offset: [
    // rust: (self.last_min_x - camera[0]) as f32,
    // rust: (-camera[1]) as f32,
    // rust: (self.last_min_z - camera[2]) as f32,
    // rust: ],
    // rust: texture_offset: offset,
}
}
    /// `draw`: the walls within the render distance, nearest first, as side
    /// indices into [`Self::vertices`] (four vertices each).
pub fn sides(state: *BorderRenderState, camera: [f64; 3], render_distance: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: state
    // rust: .closest_border(camera[0], camera[2])
    // rust: .into_iter()
    // rust: .filter(|&(_, d)| d < render_distance)
    // rust: .map(|(side, _)| side)
    // rust: .collect()
}
}

    // rust: mod tests {
//     use super::*;

pub fn near_wall_is_drawn_and_tinted() void {
}
    // rust: let mut border = WorldBorder::default();
    // rust: border.set_size(100.0);
    // rust: let mut state = BorderRenderState::default();
    // rust: let camera = [40.0, 64.0, 0.0];
    // rust: extract(&border, 0.0, camera, 128.0, &mut state);
    // rust: assert!(state.alpha > 0.0);
    // rust: assert_eq!(state.tint, 0x20A0FF);
    // rust: let mut r = BorderRenderer::default();
    // rust: assert!(r.prepare(&state, camera, 128.0, 512.0));
        // East wall first (10 blocks away), then north and south, then west.
    // rust: assert_eq!(
    // rust: BorderRenderer::sides(&state, camera, 128.0),
    // rust: vec![3, 2, 0, 1]
    // rust: );
    // rust: let t = r.transforms(&state, camera, 4500);
    // rust: assert_eq!(t.texture_offset, 0.5);
        // Far inside a huge border, nothing is drawn.
    // rust: border.set_size(10_000.0);
    // rust: extract(&border, 0.0, camera, 128.0, &mut state);
    // rust: assert_eq!(state.alpha, 0.0);
    // rust: assert!(!r.prepare(&state, camera, 128.0, 512.0));
}
}
