//! Transpiled from Horizon Rust crate
package horizon_client_gizmos

import "core:fmt"
import "core:mem"
import "core:math"

// Debug gizmos (26.3 `net.minecraft.gizmos`): coloured lines with a width
// in pixels, as `GizmoFeatureRenderer.buildLines` draws them, and the two
// debug renderers the F3 keys switch on: `ChunkBorderRenderer` (F3+G) and
// `EntityHitboxDebugRenderer` (F3+B).

// A line: world-space ends, ARGB colour, width in pixels.
Line :: struct {
    start: [f64,
    end: [f64,
    color: u32,
    width: f32,
}

// The gizmos of a frame: depth-tested lines, and lines drawn over
// everything (`GizmoProperties.setAlwaysOnTop`).
Gizmos :: struct {
    lines: [dynamic]Line,
    on_top: [dynamic]Line,
}

// `CommonColors`.
WHITE :: 0xFFFF_FFFF
RED :: 0xFFFF_0000
BLUE :: 0xFF00_00FF
YELLOW :: 0xFFFF_FF00
// `ChunkBorderRenderer.CELL_BORDER`, `YELLOW`, `MAJOR_LINES` and the outer
// columns' `ARGB.colorFromFloat(0.5F, 1.0F, 0.0F, 0.0F)`.
CELL_BORDER :: 0xFF00_9B9B
CHUNK_YELLOW :: 0xFFFF_FF00
MAJOR_LINES :: 0xFF3F_3FFF
OUTER_COLUMNS :: 0x7FFF_0000
// `ARGB.colorFromFloat(1.0F, 0.25F, 1.0F, 0.0F)`: dragon parts.
DRAGON_PART :: 0xFF3F_FF00
// `BlockEntityWithBoundingBoxRenderer.InvisibleBlockType`.
InvisibleBlock :: enum {
    Air,
    StructureVoid,
    Barrier,
    Light,
}
    // rust: impl InvisibleBlock {
    // The marker's stroke: `colorFromFloat(1, 0.5, 0.5, 1)`, `(1, 1, 0.75,
    // 0.75)`, `-65536` and `-256`.
color :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Air => 0xFF7F_7FFF,
    // rust: Self::StructureVoid => 0xFFFF_BFBF,
    // rust: Self::Barrier => 0xFFFF_0000,
    // rust: Self::Light => 0xFFFF_FF00,
}
}
}
// `ARGB.colorFromFloat(1.0F, 0.9F, 0.9F, 0.9F)`: a block entity's box.
BOUNDING_BOX :: 0xFFE5_E5E5
// `GizmoStyle.stroke(argb)` and `Gizmos.arrow(start, end, argb)`.
STROKE_WIDTH :: 2.5

    // rust: impl Gizmos {
    // `DebugCrosshairRenderer`: the world axes one block in front of the
    // camera, `0.01 * gui_scale` long, X red, Y green, Z light blue, each a
    // 2 pixel line over a 4 pixel black one. Drawn on top, in that order.
debug_crosshair :: proc(self: ^Self, camera: [f64; 3], x_rot: f32, y_rot: f32, gui_scale: f32) {
}
    // rust: let forward = view_vector(x_rot, y_rot);
    // rust: let center: [f64; 3] = std::array::from_fn(|i| camera[i] + forward[i]);
    // rust: let length = f64::from(0.01 * gui_scale);
    // rust: let axes = [(0, 0xFFFF_0000), (1, 0xFF00_FF00), (2, 0xFF7F_7FFF)];
    // rust: let end = |axis: usize| {
    // rust: let mut p = center;
    // rust: p[axis] += length;
    // rust: p
}
    // rust: for (axis, _) in axes {
    // rust: self.on_top.push(Line {
    // rust: start: center,
    // rust: end: end(axis),
    // rust: color: 0xFF00_0000,
    // rust: width: 4.0,
    // rust: });
}
    // rust: for (axis, color) in axes {
    // rust: self.on_top.push(Line {
    // rust: start: center,
    // rust: end: end(axis),
    // rust: color,
    // rust: width: 2.0,
    // rust: });
}
}
    // `Gizmos.line`.
line :: proc(self: ^Self, start: [f64; 3], end: [f64; 3], color: u32, width: f32) {
}
    // rust: self.lines.push(Line {
    // rust: start,
    // rust: end,
    // rust: color,
    // rust: width,
    // rust: });
}
    // `CuboidGizmo.emit` with a stroke style: the twelve edges in its order.
cuboid :: proc(self: ^Self, min: [f64; 3], max: [f64; 3], color: u32, width: f32) {
}
    // rust: let edges = cuboid_edges(min, max);
    // rust: self.lines.extend(edges.iter().map(|&(start, end)| Line {
    // rust: start,
    // rust: end,
    // rust: color,
    // rust: width,
    // rust: }));
}
    // `CuboidGizmo.emit` with a stroke style drawn on top of everything
    // (`Gizmos.cuboid(aabb, style, true)`).
cuboid_on_top :: proc(self: ^Self, min: [f64; 3], max: [f64; 3], color: u32, width: f32) {
}
    // rust: let edges = cuboid_edges(min, max);
    // rust: self.on_top.extend(edges.iter().map(|&(start, end)| Line {
    // rust: start,
    // rust: end,
    // rust: color,
    // rust: width,
    // rust: }));
}
    // `BlockEntityWithBoundingBoxRenderer.submit`: the box at `block` +
    // `local` of `size` blocks (nothing when a side is empty), then the
    // markers of the invisible blocks in it, indexed `z * sx * sy + y * sx + x`.
    // rust: pub fn bounding_box(
    // rust: &mut self,
    // rust: block: [i32; 3],
    // rust: local: [i32; 3],
    // rust: size: [i32; 3],
    // rust: invisible: Option<&[Option<InvisibleBlock>]>,
    // rust: ) {
    // rust: if size.iter().any(|s| *s < 1) {
    // rust: return;
}
    // rust: let at = |i: usize| f64::from(block[i] + local[i]);
    // rust: let far = |i: usize| f64::from(block[i] + local[i] + size[i]);
        // `ARGB.colorFromFloat(1.0F, 0.9F, 0.9F, 0.9F)`.
    // rust: self.cuboid_on_top(
    // rust: [at(0), at(1), at(2)],
    // rust: [far(0), far(1), far(2)],
    // rust: BOUNDING_BOX,
    // rust: STROKE_WIDTH,
    // rust: );
    // rust: let Some(invisible) = invisible else {
    // rust: return;
}
    // rust: let (sx, sy) = (size[0] as usize, size[1] as usize);
    // rust: for x in 0..size[0] {
    // rust: for y in 0..size[1] {
    // rust: for z in 0..size[2] {
    // rust: let index = z as usize * sx * sy + y as usize * sx + x as usize;
    // rust: let Some(Some(kind)) = invisible.get(index) else {
    // rust: continue;
}
                    // Air gets bigger markers: 0.45 - 0.05 to 0.55 + 0.05.
    // rust: let scale = if *kind == InvisibleBlock::Air {
    // rust: 0.05f32
    // rust: } else {
    // rust: 0.0
}
    // rust: let corner = |i: usize, d: i32, sign: f32| {
    // rust: f64::from(
    // rust: (block[i] + local[i] + d) as f32
    // rust: + if sign < 0.0 {
    // rust: 0.45 - scale
    // rust: } else {
    // rust: 0.55 + scale
    // rust: },
    // rust: )
}
    // rust: let min = [corner(0, x, -1.0), corner(1, y, -1.0), corner(2, z, -1.0)];
    // rust: let max = [corner(0, x, 1.0), corner(1, y, 1.0), corner(2, z, 1.0)];
    // rust: self.cuboid(min, max, kind.color(), STROKE_WIDTH);
}
}
}
}
    // `ArrowGizmo.emit`: the shaft, then four tips around the end.
arrow :: proc(self: ^Self, start: [f64; 3], end: [f64; 3], color: u32, width: f32) {
}
    // rust: self.line(start, end, color, width);
    // rust: let d = glam::DVec3::from(end) - glam::DVec3::from(start);
    // rust: let dir = d.as_vec3().normalize();
        // Quaternionf.rotationTo((1, 0, 0), direction).
    // rust: let rotation = glam::Quat::from_rotation_arc(glam::Vec3::X, dir);
        // (float) Mth.clamp(distance * 0.1, 0.1, 1.0).
    // rust: let len = (d.length() * f64::from(0.1f32)).clamp(f64::from(0.1f32), 1.0) as f32;
    // rust: for tip in [
    // rust: glam::Vec3::new(-len, len, 0.0),
    // rust: glam::Vec3::new(-len, 0.0, len),
    // rust: glam::Vec3::new(-len, -len, 0.0),
    // rust: glam::Vec3::new(-len, 0.0, -len),
    // rust: ] {
    // rust: let t = rotation * tip;
    // rust: let from = [
    // rust: end[0] + f64::from(t.x),
    // rust: end[1] + f64::from(t.y),
    // rust: end[2] + f64::from(t.z),
    // rust: ];
    // rust: self.line(from, end, color, width);
}
}
    // `ChunkBorderRenderer.emitGizmos` around the camera entity's block.
chunk_borders :: proc(self: ^Self, camera_block: [i32; 3], min_y: i32, max_y: i32) {
}
    // rust: let x0 = f64::from(camera_block[0] & !15);
    // rust: let z0 = f64::from(camera_block[2] & !15);
    // rust: let section_y = camera_block[1] & !15;
    // rust: let (ymin, ymax) = (min_y as f32 as f64, (max_y + 1) as f32 as f64);
    // rust: let column = |g: &mut Self, x: f64, z: f64, color: u32, width: f32| {
    // rust: g.line([x, ymin, z], [x, ymax, z], color, width);
}
    // rust: for x in (-16..=32).step_by(16) {
    // rust: for z in (-16..=32).step_by(16) {
    // rust: column(
    // rust: self,
    // rust: x0 + f64::from(x),
    // rust: z0 + f64::from(z),
    // rust: OUTER_COLUMNS,
    // rust: 4.0,
    // rust: );
}
}
    // rust: for x in (2..16).step_by(2) {
    // rust: let color = if x % 4 == 0 {
    // rust: CELL_BORDER
    // rust: } else {
    // rust: CHUNK_YELLOW
}
    // rust: column(self, x0 + f64::from(x), z0, color, 1.0);
    // rust: column(self, x0 + f64::from(x), z0 + 16.0, color, 1.0);
}
    // rust: for z in (2..16).step_by(2) {
    // rust: let color = if z % 4 == 0 {
    // rust: CELL_BORDER
    // rust: } else {
    // rust: CHUNK_YELLOW
}
    // rust: column(self, x0, z0 + f64::from(z), color, 1.0);
    // rust: column(self, x0 + 16.0, z0 + f64::from(z), color, 1.0);
}
    // rust: let ring = |g: &mut Self, y: f64, color: u32, width: f32| {
    // rust: g.line([x0, y, z0], [x0, y, z0 + 16.0], color, width);
    // rust: g.line([x0, y, z0 + 16.0], [x0 + 16.0, y, z0 + 16.0], color, width);
    // rust: g.line([x0 + 16.0, y, z0 + 16.0], [x0 + 16.0, y, z0], color, width);
    // rust: g.line([x0 + 16.0, y, z0], [x0, y, z0], color, width);
}
    // rust: let mut y = min_y;
    // rust: while y <= max_y + 1 {
    // rust: let color = if y % 8 == 0 {
    // rust: CELL_BORDER
    // rust: } else {
    // rust: CHUNK_YELLOW
}
    // rust: ring(self, f64::from(y as f32), color, 1.0);
    // rust: y += 2;
}
    // rust: for x in [0.0, 16.0] {
    // rust: for z in [0.0, 16.0] {
    // rust: column(self, x0 + x, z0 + z, MAJOR_LINES, 4.0);
}
}
        // The camera's section, always on top.
    // rust: let min = [x0, f64::from(section_y), z0];
    // rust: let max = [x0 + 16.0, f64::from(section_y + 16), z0 + 16.0];
    // rust: self.on_top
    // rust: .extend(cuboid_edges(min, max).iter().map(|&(start, end)| Line {
    // rust: start,
    // rust: end,
    // rust: color: MAJOR_LINES,
    // rust: width: 1.0,
    // rust: }));
    // rust: let mut y = min_y;
    // rust: while y <= max_y + 1 {
    // rust: ring(self, f64::from(y), MAJOR_LINES, 4.0);
    // rust: y += 16;
}
}
    // `EntityHitboxDebugRenderer.showHitboxes` for a client entity:
    // `position` is the interpolated position, `size` (width, height).
    // `eye` is the eye height and view rotations (x, y) for living
    // entities; other entities still get the view arrow from `view`.
    // rust: pub fn hitbox(
    // rust: &mut self,
    // rust: position: [f64; 3],
    // rust: size: (f32, f32),
    // rust: eye_height: f32,
    // rust: living: bool,
    // rust: view: (f32, f32),
    // rust: ) {
    // rust: let half = f64::from(size.0) / 2.0;
    // rust: let min = [position[0] - half, position[1], position[2] - half];
    // rust: let max = [
    // rust: position[0] + half,
    // rust: position[1] + f64::from(size.1),
    // rust: position[2] + half,
    // rust: ];
    // rust: self.entity_box(min, max, position, eye_height, living, view);
}
    // The same for an entity whose box is not centred on its position
    // (a painting or an item frame): `min` and `max` are the box.
    // rust: pub fn entity_box(
    // rust: &mut self,
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: position: [f64; 3],
    // rust: eye_height: f32,
    // rust: living: bool,
    // rust: view: (f32, f32),
    // rust: ) {
    // rust: self.cuboid(min, max, WHITE, STROKE_WIDTH);
    // rust: if living {
    // rust: let eye = min[1] + f64::from(eye_height);
    // rust: let d = 0.009999999776482582;
    // rust: self.cuboid(
    // rust: [min[0], eye - d, min[2]],
    // rust: [max[0], eye + d, max[2]],
    // rust: RED,
    // rust: STROKE_WIDTH,
    // rust: );
}
    // rust: let eye = [
    // rust: position[0],
    // rust: position[1] + f64::from(eye_height),
    // rust: position[2],
    // rust: ];
    // rust: let v = view_vector(view.0, view.1);
    // rust: let end = [
    // rust: eye[0] + v[0] * 2.0,
    // rust: eye[1] + v[1] * 2.0,
    // rust: eye[2] + v[2] * 2.0,
    // rust: ];
    // rust: self.arrow(eye, end, BLUE, STROKE_WIDTH);
}
}

// `CuboidGizmo.emit`'s fill: the six quads (+X, -X, -Z, +Z, +Y, -Y), each
// counter-clockwise seen from outside.
cuboid_fill_quads :: proc(min: [f64; 3], max: [f64; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [x0, y0, z0] = min;
    // rust: let [x1, y1, z1] = max;
    // rust: [
    // rust: [[x1, y0, z0], [x1, y1, z0], [x1, y1, z1], [x1, y0, z1]],
    // rust: [[x0, y0, z0], [x0, y0, z1], [x0, y1, z1], [x0, y1, z0]],
    // rust: [[x0, y0, z0], [x0, y1, z0], [x1, y1, z0], [x1, y0, z0]],
    // rust: [[x0, y0, z1], [x1, y0, z1], [x1, y1, z1], [x0, y1, z1]],
    // rust: [[x0, y1, z0], [x0, y1, z1], [x1, y1, z1], [x1, y1, z0]],
    // rust: [[x0, y0, z0], [x1, y0, z0], [x1, y0, z1], [x0, y0, z1]],
    // rust: ]
}

// `ARGB.colorFromFloat(0.375F, 1.0F, 0.0F, 0.0F)`: the fill of an error marker.
ERROR_MARKER_FILL :: 0x5FFF_0000
// `TestInstanceRenderer.submitErrorMarker`'s billboard text scale.
ERROR_MARKER_TEXT_SCALE :: 0.16

// `TestInstanceRenderer.submitErrorMarker`: the marker's box, `new
// AABB(pos).inflate(0.02F)`, and the centre of its text,
// `Vec3.atLowerCornerWithOffset(pos, 0.5, 1.2, 0.5)`.
error_marker_shape :: proc(pos: [i32; 3]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let pad = f64::from(0.02f32);
    // rust: (
    // rust: pos.map(|v| f64::from(v) - pad),
    // rust: pos.map(|v| f64::from(v) + 1.0 + pad),
    // rust: [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 1.2,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ],
    // rust: )
}

// `GizmoFeatureRenderer.buildTexts`: the world size of one font pixel,
// `scale / 16`.
billboard_text_unit :: proc(scale: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: scale / 16.0
}

// The edges of `CuboidGizmo.emit`'s stroke, in order.
cuboid_edges :: proc(min: [f64; 3], max: [f64; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let [x0, y0, z0] = min;
    // rust: let [x1, y1, z1] = max;
    // rust: [
    // rust: ([x0, y0, z0], [x1, y0, z0]),
    // rust: ([x0, y0, z0], [x0, y1, z0]),
    // rust: ([x0, y0, z0], [x0, y0, z1]),
    // rust: ([x1, y0, z0], [x1, y1, z0]),
    // rust: ([x1, y1, z0], [x0, y1, z0]),
    // rust: ([x0, y1, z0], [x0, y1, z1]),
    // rust: ([x0, y1, z1], [x0, y0, z1]),
    // rust: ([x0, y0, z1], [x1, y0, z1]),
    // rust: ([x1, y0, z1], [x1, y0, z0]),
    // rust: ([x0, y1, z1], [x1, y1, z1]),
    // rust: ([x1, y0, z1], [x1, y1, z1]),
    // rust: ([x1, y1, z0], [x1, y1, z1]),
    // rust: ]
}

// `Entity.calculateViewVector(xRot, yRot)`.
view_vector :: proc(x_rot: f32, y_rot: f32) -> [ {
    // Ported from Horizon
    return {}
}
//     use horizon_core::geometry::trig::{cos, sin};
    // rust: let x = f64::from(x_rot * (std::f32::consts::PI / 180.0));
    // rust: let y = f64::from(-y_rot * (std::f32::consts::PI / 180.0));
    // rust: let (yc, ys, xc, xs) = (cos(y), sin(y), cos(x), sin(x));
    // rust: [f64::from(ys * xc), f64::from(-xs), f64::from(yc * xc)]
}

// `GizmoFeatureRenderer.buildLines`: camera-relative ends, clipped at the
// near plane in view space (z = -0.05), as (start, end, colour, width).
camera_relative :: proc(lines: ^[Line], camera: [f64; 3], view: glam::Mat4) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity(lines.len());
    // rust: for l in lines {
    // rust: let rel = |p: [f64; 3]| {
    // rust: glam::Vec3::new(
    // rust: (p[0] - camera[0]) as f32,
    // rust: (p[1] - camera[1]) as f32,
    // rust: (p[2] - camera[2]) as f32,
    // rust: )
}
    // rust: let (mut start, mut end) = (rel(l.start), rel(l.end));
    // rust: let (sv, ev) = (view.transform_point3(start), view.transform_point3(end));
    // rust: let (start_behind, end_behind) = (sv.z > -0.05, ev.z > -0.05);
    // rust: if start_behind && end_behind {
    // rust: continue;
}
    // rust: if start_behind || end_behind {
    // rust: let denom = ev.z - sv.z;
    // rust: if denom.abs() >= 1.0e-9 {
    // rust: let t = ((-0.05 - sv.z) / denom).clamp(0.0, 1.0);
    // rust: let cut = start.lerp(end, t);
    // rust: if start_behind {
    // rust: start = cut;
    // rust: } else {
    // rust: end = cut;
}
}
}
    // rust: out.push([
    // rust: start.x,
    // rust: start.y,
    // rust: start.z,
    // rust: end.x,
    // rust: end.y,
    // rust: end.z,
    // rust: f32::from_bits(l.color),
    // rust: l.width,
    // rust: ]);
}
    // rust: out
}

    // rust: mod tests {
an_error_marker_is_a_filled_box_with_text_above_it :: proc() {
}
    // rust: let (min, max, text) = error_marker_shape([10, 64, -3]);
    // rust: let pad = f64::from(0.02f32);
    // rust: assert_eq!(min, [10.0 - pad, 64.0 - pad, -3.0 - pad]);
    // rust: assert_eq!(max, [11.0 + pad, 65.0 + pad, -2.0 + pad]);
    // rust: assert_eq!(text, [10.5, 65.2, -2.5]);
        // 0.375 of 255 floors to 95; the colour is red.
    // rust: assert_eq!(ERROR_MARKER_FILL, 0x5FFF_0000);
    // rust: assert_eq!(billboard_text_unit(ERROR_MARKER_TEXT_SCALE), 0.01);
    // rust: let quads = cuboid_fill_quads(min, max);
    // rust: assert_eq!(quads.len(), 6);
        // Every quad is flat on a face of the box and counter-clockwise from outside.
    // rust: for q in quads {
    // rust: let n = (glam::DVec3::from(q[1]) - glam::DVec3::from(q[0]))
    // rust: .cross(glam::DVec3::from(q[2]) - glam::DVec3::from(q[1]));
    // rust: let centre = q
    // rust: .iter()
    // rust: .fold(glam::DVec3::ZERO, |a, p| a + glam::DVec3::from(*p))
    // rust: / 4.0;
    // rust: let middle = (glam::DVec3::from(min) + glam::DVec3::from(max)) / 2.0;
    // rust: assert!(n.dot(centre - middle) > 0.0);
}
    // rust: assert_eq!(quads[0][0], [max[0], min[1], min[2]]);
}

//     use super::*;

debug_crosshair_is_the_world_axes_ahead_of_the_camera :: proc() {
}
    // rust: let mut g = Gizmos::default();
        // Looking south (yaw 0) at GUI scale 2: one block towards +Z.
    // rust: g.debug_crosshair([0.5, 64.0, 0.5], 0.0, 0.0, 2.0);
    // rust: assert!(g.lines.is_empty());
    // rust: let ends: Vec<([f64; 3], u32, f32)> =
    // rust: g.on_top.iter().map(|l| (l.end, l.color, l.width)).collect();
    // rust: assert_eq!(g.on_top[0].start, [0.5, 64.0, 1.5]);
        // CROSSHAIR_SCALE * guiScale, in floats as vanilla scales.
    // rust: let l = f64::from(0.01f32 * 2.0);
    // rust: let (x, y, z) = (
    // rust: [0.5 + l, 64.0, 1.5],
    // rust: [0.5, 64.0 + l, 1.5],
    // rust: [0.5, 64.0, 1.5 + l],
    // rust: );
    // rust: assert_eq!(
    // rust: ends,
    // rust: [
    // rust: (x, 0xFF00_0000, 4.0),
    // rust: (y, 0xFF00_0000, 4.0),
    // rust: (z, 0xFF00_0000, 4.0),
    // rust: (x, 0xFFFF_0000, 2.0),
    // rust: (y, 0xFF00_FF00, 2.0),
    // rust: (z, 0xFF7F_7FFF, 2.0),
    // rust: ]
    // rust: );
}

chunk_borders_match_the_renderer :: proc() {
}
    // rust: let mut g = Gizmos::default();
    // rust: g.chunk_borders([37, 70, -5], -64, 319);
        // 4 * 4 outer columns, 2 * 7 + 2 * 7 inner columns, a ring every 2
        // blocks, 4 major columns, a major ring every 16.
    // rust: let rings = (-64..=320).step_by(2).count();
    // rust: let majors = (-64..=320).step_by(16).count();
    // rust: assert_eq!(g.lines.len(), 16 + 28 + rings * 4 + 4 + majors * 4);
    // rust: assert_eq!(g.on_top.len(), 12);
    // rust: let first = g.lines[0];
    // rust: assert_eq!(first.start, [16.0, -64.0, -32.0]);
    // rust: assert_eq!(first.end, [16.0, 320.0, -32.0]);
    // rust: assert_eq!((first.color, first.width), (OUTER_COLUMNS, 4.0));
        // The section box around y 70.
    // rust: assert_eq!(g.on_top[0].start, [32.0, 64.0, -16.0]);
    // rust: assert_eq!(g.on_top[11].end, [48.0, 80.0, 0.0]);
        // y 0 and 8 are cell-coloured rings, y 2 yellow.
    // rust: let ring_at = |y: f64| {
    // rust: g.lines
    // rust: .iter()
    // rust: .find(|l| l.start[1] == y && l.end[1] == y)
    // rust: .unwrap()
}
    // rust: assert_eq!(ring_at(8.0).color, CELL_BORDER);
    // rust: assert_eq!(ring_at(2.0).color, CHUNK_YELLOW);
}

hitbox_box_eye_line_and_view_arrow :: proc() {
}
    // rust: let mut g = Gizmos::default();
    // rust: g.hitbox([0.5, 64.0, 0.5], (0.6, 1.8), 1.62, true, (0.0, 0.0));
    // rust: assert_eq!(g.lines.len(), 12 + 12 + 5);
        // EntityDimensions.makeBoundingBox: the float half width.
    // rust: let corner = 0.5 - f64::from(0.6f32 / 2.0);
    // rust: assert_eq!(g.lines[0].start, [corner, 64.0, corner]);
    // rust: assert_eq!(g.lines[12].color, RED);
        // Looking south (yRot 0): the arrow points +z.
    // rust: let arrow = g.lines[24];
    // rust: assert_eq!(arrow.color, BLUE);
    // rust: assert!((arrow.end[2] - 2.5).abs() < 1e-6 && (arrow.end[0] - 0.5).abs() < 1e-6);
    // rust: let mut g = Gizmos::default();
    // rust: g.hitbox([0.0, 0.0, 0.0], (0.25, 0.25), 0.2125, false, (0.0, 0.0));
    // rust: assert_eq!(g.lines.len(), 12 + 5);
}

lines_behind_the_camera_are_clipped_at_the_near_plane :: proc() {
}
    // rust: let view = glam::Mat4::IDENTITY; // looking down -z
    // rust: let lines = [
    // rust: Line {
    // rust: start: [0.0, 0.0, -2.0],
    // rust: end: [0.0, 0.0, 2.0],
    // rust: color: WHITE,
    // rust: width: 1.0,
    // rust: },
    // rust: Line {
    // rust: start: [0.0, 0.0, 1.0],
    // rust: end: [1.0, 0.0, 2.0],
    // rust: color: WHITE,
    // rust: width: 1.0,
    // rust: },
    // rust: ];
    // rust: let out = camera_relative(&lines, [0.0; 3], view);
    // rust: assert_eq!(out.len(), 1);
    // rust: assert!((out[0][5] + 0.05).abs() < 1e-6);
}

bounding_box_draws_the_box_on_top_and_markers_for_invisible_blocks :: proc() {
}
    // rust: let mut g = Gizmos::default();
    // rust: let mut invisible = vec![None; 2];
    // rust: invisible[1] = Some(InvisibleBlock::Barrier);
    // rust: g.bounding_box([10, 64, 10], [1, 0, 0], [2, 1, 1], Some(&invisible));
        // The box: twelve edges, from the corner to the far corner.
    // rust: assert_eq!(g.on_top.len(), 12);
    // rust: assert_eq!(g.on_top[0].start, [11.0, 64.0, 10.0]);
    // rust: assert_eq!(g.on_top[0].end, [13.0, 64.0, 10.0]);
    // rust: assert!(g.on_top.iter().all(|l| l.color == BOUNDING_BOX));
        // The barrier at index 1 (x = 1): 0.45 to 0.55 inside its block, red.
    // rust: assert_eq!(g.lines.len(), 12);
    // rust: let l = &g.lines[0];
    // rust: assert_eq!(l.color, 0xFFFF_0000);
    // rust: assert!((l.start[0] - 12.45).abs() < 1e-6 && (l.end[0] - 12.55).abs() < 1e-6);
        // An empty side draws nothing.
    // rust: let mut none = Gizmos::default();
    // rust: none.bounding_box([0; 3], [0; 3], [0, 3, 3], None);
    // rust: assert!(none.on_top.is_empty() && none.lines.is_empty());
}

air_markers_are_larger_than_the_others :: proc() {
}
    // rust: let mut g = Gizmos::default();
    // rust: g.bounding_box(
    // rust: [0; 3],
    // rust: [0; 3],
    // rust: [1, 1, 1],
    // rust: Some(&[Some(InvisibleBlock::Air)]),
    // rust: );
    // rust: let (min, max) = (g.lines[0].start[0], g.lines[0].end[0]);
    // rust: assert!((min - 0.4).abs() < 1e-6 && (max - 0.6).abs() < 1e-6);
    // rust: assert_eq!(g.lines[0].color, 0xFF7F_7FFF);
}
}
