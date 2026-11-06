//! Transpiled from Horizon Rust crate
package horizon_client_render_clouds

import "core:fmt"
import "core:mem"
import "core:math"

// Cloud visibility and flat/fancy cell geometry (`CloudRenderer`).
// `EnvironmentAttributes.CLOUD_HEIGHT`'s default, and the overworld's `visual/cloud_height`.
CLOUD_HEIGHT :: 192.33

// Whether the cloud color has any packed alpha (vanilla gates the clouds on it).
has_color :: proc(alpha: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (alpha.clamp(0.0, 1.0) * 255.0) as u8 > 0
}

// `LevelRenderer`: skip OFF clouds and colors with no packed alpha.
visible :: proc(mode: string, alpha: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: mode != "false" && has_color(alpha)
}

// `buildFlatCell`: bottom plane, in both windings for the culled cloud pipeline.
flat_cell :: proc(x: f32, z: f32, bottom: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let p = [
    // rust: [x + 12.0, bottom, z],
    // rust: [x + 12.0, bottom, z + 12.0],
    // rust: [x, bottom, z + 12.0],
    // rust: [x, bottom, z],
    // rust: ];
    // rust: [p, [p[3], p[2], p[1], p[0]]]
}

// Direction order is DOWN, UP, NORTH, SOUTH, WEST, EAST; inward faces use bits 6..12.
face_mask :: proc(x: i32, z: i32, bottom: f32, empty: [bool; 4]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut mask = 0;
    // rust: if bottom <= 0.0 {
    // rust: mask |= 1 << 1;
}
    // rust: if bottom + 4.0 >= 0.0 {
    // rust: mask |= 1;
}
    // rust: for (i, visible) in [z > 0, z < 0, x > 0, x < 0].into_iter().enumerate() {
    // rust: if empty[i] && visible {
    // rust: mask |= 1 << (i + 2);
}
}
    // rust: if x.abs() <= 1 && z.abs() <= 1 {
    // rust: mask |= 63 << 6;
}
    // rust: mask
}

// Exterior faces first, then reversed interior faces, in vanilla emission order.
faces :: proc(mask: u16) -> i {
    // Ported from Horizon
    return {}
}
    // rust: [1, 0, 2, 3, 4, 5]
    // rust: .into_iter()
    // rust: .filter(move |d| mask & (1 << d) != 0)
    // rust: .map(|d| (d, false))
    // rust: .chain(
    // rust: (0..6)
    // rust: .filter(move |d| mask & (1 << (d + 6)) != 0)
    // rust: .map(|d| (d, true)),
    // rust: )
}

// `CloudRenderer.prepare`: the cell radius for the Cloud Distance option
// (in chunks), independent of the render distance.
radius_cells :: proc(cloud_range_chunks: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: ((cloud_range_chunks * 16) as f32 / 12.0).ceil() as i32
}

CellIter :: struct {
    radius: i32,
    ring: i32,
    x: i32,
    pending_z: Maybe(i32),
}

    // rust: impl CellIter {
new :: proc(radius: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: radius,
    // rust: ring: 0,
    // rust: x: 0,
    // rust: pending_z: None,
}
}
}

    // rust: impl Iterator for CellIter {
    // rust: type Item = (i32, i32);

next :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(z) = self.pending_z.take() {
    // rust: let x = self.x;
    // rust: self.x += 1;
    // rust: return Some((x, z));
}
    // rust: let r2 = self.radius * self.radius;
    // rust: while self.ring <= 2 * self.radius {
    // rust: let min_abs = self.ring - self.radius;
    // rust: while self.x <= self.ring {
    // rust: if min_abs > 0 && self.x > -min_abs && self.x < min_abs {
    // rust: self.x = min_abs;
}
    // rust: let x = self.x;
    // rust: let z = self.ring - x.abs();
    // rust: if z <= self.radius && x * x + z * z <= r2 {
    // rust: if z != 0 {
    // rust: self.pending_z = Some(z);
    // rust: return Some((x, -z));
    // rust: } else {
    // rust: self.x += 1;
    // rust: return Some((x, 0));
}
}
    // rust: self.x += 1;
}
    // rust: self.ring += 1;
    // rust: self.x = -self.ring;
}
    // rust: None
}
}

// CloudRenderer builds cells in expanding Manhattan rings, nearest first.
cells :: proc(radius: i32) -> C {
    // Ported from Horizon
    return {}
}
    // rust: CellIter::new(radius)
}

// Per-frame cloud inputs. Resources are immutable for the renderer's lifetime:
// resource-pack reloads replace the renderer and its cache together.
Input :: struct {
    texture: ^'a (u32,
    uv: [f32,
    camera: glam::DVec3,
    time: i64,
    partial_tick: f64,
    range: i32,
    fast: bool,
    color: [f32,
}

MeshKey :: struct {
    cell_x: i64,
    cell_z: i64,
    radius: i32,
    fast: bool,
    // The two vertical face tests include both surfaces at the boundaries.
    top: bool,
    bottom: bool,
}

    // rust: pub(crate) struct Uniform {
    // rust: offset: [f32; 4],
    // rust: colors: [[f32; 4]; 4],
}

// How far the clouds have drifted, in ticks: the game time within one trip across the cloud
// texture (`width` cells of 400 ticks), plus the partial tick (`CloudRenderer.prepare`).
drift :: proc(time: i64, partial_tick: f64, width: u32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: time.rem_euclid(i64::from(width) * 400) as f64 + partial_tick
}

    // rust: impl Input<'_> {
state :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (w, h, _) = self.texture;
    // rust: let offset = drift(self.time, self.partial_tick, *w);
    // rust: let mut x = self.camera.x + offset * 0.030_000_001;
    // rust: let mut z = self.camera.z + 3.96;
    // rust: let (tw, th) = (f64::from(*w) * 12.0, f64::from(*h) * 12.0);
    // rust: x -= (x / tw).floor() * tw;
    // rust: z -= (z / th).floor() * th;
    // rust: let cell_x = (x / 12.0).floor() as i64;
    // rust: let cell_z = (z / 12.0).floor() as i64;
    // rust: let bottom = (CLOUD_HEIGHT - self.camera.y) as f32;
    // rust: let key = MeshKey {
    // rust: cell_x,
    // rust: cell_z,
    // rust: radius: radius_cells(self.range),
    // rust: fast: self.fast,
    // rust: top: bottom <= 0.0,
    // rust: bottom: bottom + 4.0 >= 0.0,
}
    // rust: let colors = [1.0, 0.7, 0.8, 0.9].map(|shade| {
    // rust: let [r, g, b, a] = self.color;
    // rust: [r * shade, g * shade, b * shade, a]
    // rust: .map(|v| (v.clamp(0.0, 1.0) * 255.0) as u8 as f32 / 255.0)
    // rust: });
    // rust: (
    // rust: key,
    // rust: Uniform {
    // rust: offset: [
    // rust: -(x - cell_x as f64 * 12.0) as f32,
    // rust: bottom,
    // rust: -(z - cell_z as f64 * 12.0) as f32,
    // rust: 0.0,
    // rust: ],
    // rust: colors,
    // rust: },
    // rust: )
}
}

    // rust: pub(crate) struct Mesh {
    // rust: key: Option<MeshKey>,
    // rust: cells: Vec<(i32, i32)>,
    // rust: cached_radius: Option<i32>,
    // rust: pub vertices: Vec<crate::mesher::Vertex>,
}

    // rust: fn push_quad(
    // rust: vertices: &mut Vec<crate::mesher::Vertex>,
    // rust: p: [[f32; 3]; 4],
    // rust: shade: u32,
    // rust: normal: [i8; 4],
    // rust: uv: [f32; 2],
    // rust: ) {
    // rust: for pos in p {
    // rust: vertices.push(crate::mesher::Vertex {
    // rust: normal,
    // rust: pos,
    // rust: uv,
    // rust: layer: 4,
    // rust: color: u32::MAX,
    // rust: light: shade,
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}

    // rust: fn emit_face(
    // rust: vertices: &mut Vec<crate::mesher::Vertex>,
    // rust: direction: usize,
    // rust: inside: bool,
    // rust: x0: f32,
    // rust: z0: f32,
    // rust: uv: [f32; 2],
    // rust: ) {
    // rust: let x1 = x0 + 12.0;
    // rust: let z1 = z0 + 12.0;
Y0 :: 0.0
Y1 :: 4.0
    // rust: let (p, shade, normal) = match direction {
    // rust: 0 => (
    // rust: [[x1, Y0, z0], [x1, Y0, z1], [x0, Y0, z1], [x0, Y0, z0]],
    // rust: 1,
    // rust: [0, -127, 0, 0],
    // rust: ),
    // rust: 1 => (
    // rust: [[x0, Y1, z0], [x0, Y1, z1], [x1, Y1, z1], [x1, Y1, z0]],
    // rust: 0,
    // rust: [0, 127, 0, 0],
    // rust: ),
    // rust: 2 => (
    // rust: [[x0, Y0, z0], [x0, Y1, z0], [x1, Y1, z0], [x1, Y0, z0]],
    // rust: 2,
    // rust: [0, 0, -127, 0],
    // rust: ),
    // rust: 3 => (
    // rust: [[x1, Y0, z1], [x1, Y1, z1], [x0, Y1, z1], [x0, Y0, z1]],
    // rust: 2,
    // rust: [0, 0, 127, 0],
    // rust: ),
    // rust: 4 => (
    // rust: [[x0, Y0, z1], [x0, Y1, z1], [x0, Y1, z0], [x0, Y0, z0]],
    // rust: 3,
    // rust: [-127, 0, 0, 0],
    // rust: ),
    // rust: _ => (
    // rust: [[x1, Y0, z0], [x1, Y1, z0], [x1, Y1, z1], [x1, Y0, z1]],
    // rust: 3,
    // rust: [127, 0, 0, 0],
    // rust: ),
}
    // rust: if inside {
    // rust: push_quad(
    // rust: vertices,
    // rust: [p[3], p[2], p[1], p[0]],
    // rust: shade,
    // rust: normal.map(|c| -c),
    // rust: uv,
    // rust: );
    // rust: } else {
    // rust: push_quad(vertices, p, shade, normal, uv);
}
}

    // rust: fn emit_faces(
    // rust: vertices: &mut Vec<crate::mesher::Vertex>,
    // rust: mask: u16,
    // rust: x0: f32,
    // rust: z0: f32,
    // rust: uv: [f32; 2],
    // rust: ) {
    // rust: for d in [1, 0, 2, 3, 4, 5] {
    // rust: if mask & (1 << d) != 0 {
    // rust: emit_face(vertices, d, false, x0, z0, uv);
}
}
    // rust: if mask >> 6 != 0 {
    // rust: for d in 0..6 {
    // rust: if mask & (1 << (d + 6)) != 0 {
    // rust: emit_face(vertices, d, true, x0, z0, uv);
}
}
}
}

emit_flat_cell :: proc(vertices: ^[dynamic]crate::mesher::Vertex, x0: f32, z0: f32, uv: [f32; 2]) {
}
    // rust: let x1 = x0 + 12.0;
    // rust: let z1 = z0 + 12.0;
    // rust: let p = [[x1, 0.0, z0], [x1, 0.0, z1], [x0, 0.0, z1], [x0, 0.0, z0]];
    // rust: push_quad(vertices, p, 0, [0; 4], uv);
    // rust: push_quad(vertices, [p[3], p[2], p[1], p[0]], 0, [0; 4], uv);
}

    // rust: impl Mesh {
    // Returns true only when vertices must be uploaded. Sub-cell motion and
    // color changes update only the uniform, as in CloudRenderer.prepare.
prepare :: proc(self: ^Self, input: ^Input<'_>) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (key, uniform) = input.state();
    // rust: if self.key.as_ref() == Some(&key) {
    // rust: return (false, uniform);
}
    // rust: if self.cached_radius != Some(key.radius) {
    // rust: self.cells = self::cells(key.radius).collect();
    // rust: self.cached_radius = Some(key.radius);
}
    // rust: self.vertices.clear();

    // rust: let (w, h, tex_cells) = input.texture;
    // rust: let (cell_x, cell_z) = (key.cell_x, key.cell_z);
    // rust: let bottom = uniform.offset[1];
    // rust: let uv = input.uv;

    // rust: let (w_i64, h_i64) = (i64::from(*w), i64::from(*h));
    // rust: let filled = |cx: i64, cz: i64| {
    // rust: tex_cells[(cz.rem_euclid(h_i64) * w_i64 + cx.rem_euclid(w_i64)) as usize]
}

    // rust: for &(dx, dz) in &self.cells {
    // rust: let (dx_i64, dz_i64) = (i64::from(dx), i64::from(dz));
    // rust: let (cx, cz) = (cell_x + dx_i64, cell_z + dz_i64);
    // rust: if !filled(cx, cz) {
    // rust: continue;
}
    // rust: let x0 = dx as f32 * 12.0;
    // rust: let z0 = dz as f32 * 12.0;

    // rust: if input.fast {
    // rust: emit_flat_cell(&mut self.vertices, x0, z0, uv);
    // rust: continue;
}

    // rust: let mask = face_mask(
    // rust: dx,
    // rust: dz,
    // rust: bottom,
    // rust: [
    // rust: !filled(cx, cz - 1),
    // rust: !filled(cx, cz + 1),
    // rust: !filled(cx - 1, cz),
    // rust: !filled(cx + 1, cz),
    // rust: ],
    // rust: );
    // rust: emit_faces(&mut self.vertices, mask, x0, z0, uv);
}

    // rust: self.key = Some(key);
    // rust: (true, uniform)
}
}

    // rust: mod tests {
//     use super::*;
cached_mesh_tracks_geometry_but_not_subcell_motion_or_color :: proc() {
}
    // rust: let texture = (8, 8, (0..64).map(|i| i % 3 != 0).collect());
    // rust: let mut input = Input {
    // rust: texture: &texture,
    // rust: uv: [0.5; 2],
    // rust: camera: glam::DVec3::new(1.0, 100.0, 1.0),
    // rust: time: 0,
    // rust: partial_tick: 0.0,
    // rust: range: 2,
    // rust: fast: false,
    // rust: color: [1.0; 4],
}
    // rust: let mut mesh = Mesh::default();
    // rust: assert!(mesh.prepare(&input).0);
    // rust: let vertices = bytemuck::cast_slice::<_, u8>(&mesh.vertices).to_vec();
    // rust: let pointer = mesh.vertices.as_ptr();
    // rust: for tick in 0..100 {
    // rust: input.time = tick;
    // rust: input.partial_tick = 0.5;
    // rust: input.camera.x = 2.0;
    // rust: input.camera.y = 101.0;
    // rust: input.color = [0.8, 0.7, 0.6, 0.5];
    // rust: let (rebuilt, uniform) = mesh.prepare(&input);
    // rust: assert!(!rebuilt);
    // rust: assert_eq!(mesh.vertices.as_ptr(), pointer);
    // rust: assert_eq!(bytemuck::cast_slice::<_, u8>(&mesh.vertices), vertices);
    // rust: assert_eq!(uniform.offset[1], (192.33 - input.camera.y) as f32);
    // rust: assert_eq!(
    // rust: uniform.colors[1],
    // rust: [0.8 * 0.7, 0.7 * 0.7, 0.6 * 0.7, 0.5].map(|v| (v * 255.0) as u8 as f32 / 255.0)
    // rust: );
    // rust: for color in uniform.colors {
    // rust: assert_eq!(color[3], 127.0 / 255.0);
}
}
    // rust: for (x, y, z, range, fast) in [
    // rust: (13.0, 101.0, 1.0, 2, false),
    // rust: (13.0, 101.0, -5.0, 2, false),
    // rust: (13.0, 192.33, -5.0, 2, false),
    // rust: (13.0, 196.34, -5.0, 2, false),
    // rust: (13.0, 196.34, -5.0, 3, false),
    // rust: (13.0, 196.34, -5.0, 3, true),
    // rust: ] {
    // rust: input.camera = glam::DVec3::new(x, y, z);
    // rust: input.range = range;
    // rust: input.fast = fast;
    // rust: assert!(mesh.prepare(&input).0);
    // rust: let mut fresh = Mesh::default();
    // rust: fresh.prepare(&input);
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&mesh.vertices),
    // rust: bytemuck::cast_slice::<_, u8>(&fresh.vertices)
    // rust: );
    // rust: assert!(!mesh.prepare(&input).0);
}
        // Drift alone crosses a cell, even with a stationary camera.
    // rust: input.time += 400;
    // rust: assert!(mesh.prepare(&input).0);
        // Resource reload constructs a new renderer and cache, including empty packs.
    // rust: let mut reloaded = Mesh::default();
    // rust: let empty = (1, 1, vec![false]);
    // rust: input.texture = &empty;
    // rust: assert!(reloaded.prepare(&input).0);
    // rust: assert!(reloaded.vertices.is_empty());
    // rust: assert!(!reloaded.prepare(&input).0);
}

settings_and_packed_alpha_gate_clouds :: proc() {
}
    // rust: for mode in ["false", "fast", "true"] {
    // rust: assert_eq!(visible(mode, 1.0), mode != "false");
    // rust: assert!(!visible(mode, 0.0));
    // rust: assert!(!visible(mode, 0.5 / 255.0));
}
    // rust: assert!(visible("fast", 1.0 / 255.0));
}

fast_cells_are_flat_at_the_bottom_and_visible_from_both_sides :: proc() {
}
    // rust: for bottom in [-10.0, 0.0, 10.0] {
    // rust: let [down, up] = flat_cell(-3.0, 7.0, bottom);
    // rust: assert_eq!(
    // rust: down,
    // rust: [
    // rust: [9.0, bottom, 7.0],
    // rust: [9.0, bottom, 19.0],
    // rust: [-3.0, bottom, 19.0],
    // rust: [-3.0, bottom, 7.0],
    // rust: ]
    // rust: );
    // rust: assert_eq!(up, [down[3], down[2], down[1], down[0]]);
    // rust: for (quad, sign) in [(down, -1.0), (up, 1.0)] {
    // rust: let [a, b, c] = [quad[0], quad[1], quad[2]].map(glam::Vec3::from_array);
    // rust: assert!((b - a).cross(c - a).y * sign > 0.0);
}
}
}

cells_are_nearest_first_and_unique :: proc() {
}
    // rust: let cells: Vec<_> = cells(2).collect();
    // rust: assert_eq!(cells[0], (0, 0));
    // rust: assert_eq!(cells.len(), 13);
    // rust: assert!(
    // rust: cells
    // rust: .windows(2)
    // rust: .all(|w| w[0].0.abs() + w[0].1.abs() <= w[1].0.abs() + w[1].1.abs())
    // rust: );
    // rust: assert_eq!(
    // rust: cells.iter().collect::<std::collections::HashSet<_>>().len(),
    // rust: cells.len()
    // rust: );
}
only_camera_facing_exterior_faces :: proc() {
}
    // rust: assert_eq!(face_mask(2, 2, 10.0, [true; 4]), 1 | 4 | 16);
    // rust: assert_eq!(face_mask(-2, -2, -5.0, [true; 4]), 2 | 8 | 32);
    // rust: assert_eq!(face_mask(2, 2, 0.0, [false; 4]), 3);
}
cloud_distance_sets_the_radius :: proc() {
}
    // rust: assert_eq!(radius_cells(2), 3);
    // rust: assert_eq!(radius_cells(12), 16);
    // rust: assert_eq!(radius_cells(128), 171);
}
connected_cells_have_no_exterior_walls :: proc() {
}
    // rust: assert_eq!(face_mask(2, 2, 10.0, [false; 4]), 1);
}
nearby_cells_keep_inward_faces_for_camera_inside_clouds :: proc() {
}
    // rust: assert_eq!(face_mask(0, 0, 0.0, [false; 4]), 3 | (63 << 6));
}
}
