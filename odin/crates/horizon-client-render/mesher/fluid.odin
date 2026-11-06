//! Transpiled from Horizon Rust crate
package horizon_client_render_fluid

import "core:fmt"
import "core:mem"
import "core:math"

// Fluid surfaces following `FluidRenderer.tesselate`: corner heights, face
// occlusion against neighbour shapes, flow-rotated top UVs, the water overlay
// beside glass and leaves, back faces, cardinal shading and max(self, above)
// light.
// use super::{
    // rust: Info, MeshTables, Padded, SectionMesh, TerrainVertex, fluid_face, lighting, pack_coords,
    // rust: pack_rgb, pi,
}
// use horizon_core::{
    // rust: geometry::{Axis, Direction, VoxelShape, trig},
    // rust: position::BlockPos,
}
// use horizon_world::{
    // rust: fluid::{FluidKind, FluidState},
    // rust: fluid_flow::{FluidFlowWorld, flow_at},
}
// use std::{convert::Infallible, sync::OnceLock};

// `FluidRenderer.MAX_FLUID_HEIGHT`.
MAX_HEIGHT :: 0.888_888_9
EPSILON :: 0.001

// For the occlusion face toward `direction`: the height from the bottom over
// which its slice flush with the `direction` side covers the whole width
// (vertical faces: 1 when the whole square is covered, else 0). This is what
// `Shapes.blockOccludes` decides for a fluid box of a given height.
    // rust: pub(super) fn coverage(shape: &VoxelShape, direction: Direction) -> f32 {
    // rust: let (axis, u, v) = match direction {
    // rust: Direction::Down | Direction::Up => (Axis::Y, Axis::X, Axis::Z),
    // rust: Direction::North | Direction::South => (Axis::Z, Axis::X, Axis::Y),
    // rust: Direction::West | Direction::East => (Axis::X, Axis::Z, Axis::Y),
}
    // rust: let positive = matches!(
    // rust: direction,
    // rust: Direction::Up | Direction::South | Direction::East
    // rust: );
    // rust: let rects: Vec<[f64; 4]> = shape
    // rust: .boxes()
    // rust: .iter()
    // rust: .filter(|b| {
    // rust: if positive {
    // rust: b.max(axis) >= 1.0 - 1e-7
    // rust: } else {
    // rust: b.min(axis) <= 1e-7
}
    // rust: })
    // rust: .map(|b| [b.min(u), b.max(u), b.min(v), b.max(v)])
    // rust: .collect();
    // rust: let mut cuts: Vec<f64> = rects
    // rust: .iter()
    // rust: .flat_map(|r| [r[2], r[3]])
    // rust: .filter(|c| (0.0..=1.0).contains(c))
    // rust: .chain([0.0, 1.0])
    // rust: .collect();
    // rust: cuts.sort_by(f64::total_cmp);
    // rust: cuts.dedup();
    // rust: let mut covered = 0.0;
    // rust: for w in cuts.windows(2) {
    // rust: let middle = (w[0] + w[1]) / 2.0;
    // rust: let mut spans: Vec<(f64, f64)> = rects
    // rust: .iter()
    // rust: .filter(|r| r[2] <= middle && middle <= r[3])
    // rust: .map(|r| (r[0], r[1]))
    // rust: .collect();
    // rust: spans.sort_by(|a, b| a.0.total_cmp(&b.0));
    // rust: let mut reach = 0.0f64;
    // rust: for (lo, hi) in spans {
    // rust: if lo > reach + 1e-7 {
    // rust: break;
}
    // rust: reach = reach.max(hi);
}
    // rust: if reach < 1.0 - 1e-7 {
    // rust: break;
}
    // rust: covered = w[1];
}
    // rust: if matches!(direction, Direction::Down | Direction::Up) && covered < 1.0 {
    // rust: return 0.0;
}
    // rust: covered as f32
}
// `isFaceOccludedByState` for a fluid box `height` tall against `state`'s
// face opposite `direction`.
occluded_by :: proc(direction: Direction, height: f32, state: ^Info) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let opposite = direction.opposite() as usize;
    // rust: match state.face[opposite] {
    // rust: 0 => false,
    // rust: 1 => direction != Direction::Up || height == 1.0,
    // rust: _ => match direction {
    // rust: Direction::Up => {
    // rust: f64::from(height) >= 1.0 - 1e-7 && state.cover[Direction::Down as usize] >= 1.0
}
    // rust: Direction::Down => state.cover[Direction::Up as usize] >= 1.0,
    // rust: _ => f64::from(height) <= f64::from(state.cover[opposite]) + 1e-7,
    // rust: },
}
}
// `isFaceOccludedBySelf`: the cell's own occlusion face toward `direction`.
occluded_by_self :: proc(state: ^Info, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match state.face[direction as usize] {
    // rust: 0 => false,
    // rust: 1 => true,
    // rust: _ => state.cover[direction as usize] >= 1.0,
}
}
// `Mth.atan2`: the client's table-driven arctangent.
atan2 :: proc(mut y: f64, mut x: f64) -> f {
    // Ported from Horizon
    return {}
}
TABLES :: OnceLock::new()
    // rust: let (asin, cos) = TABLES.get_or_init(|| {
    // rust: (0..257)
    // rust: .map(|i| {
    // rust: let a = (f64::from(i) / 256.0).asin();
    // rust: (a, a.cos())
    // rust: })
    // rust: .unzip()
    // rust: });
    // rust: let frac_bias = f64::from_bits(4_805_340_802_404_319_232);
    // rust: let d2 = x * x + y * y;
    // rust: if d2.is_nan() {
    // rust: return f64::NAN;
}
    // rust: let negative_y = y < 0.0;
    // rust: if negative_y {
    // rust: y = -y;
}
    // rust: let negative_x = x < 0.0;
    // rust: if negative_x {
    // rust: x = -x;
}
    // rust: let steep = y > x;
    // rust: if steep {
    // rust: std::mem::swap(&mut x, &mut y);
}
    // Mth.fastInvSqrt
    // rust: let half = 0.5 * d2;
    // rust: let mut r = f64::from_bits((6_910_469_410_427_058_090i64 - (d2.to_bits() as i64 >> 1)) as u64);
    // rust: r *= 1.5 - half * r * r;
    // rust: x *= r;
    // rust: y *= r;
    // rust: let yp = frac_bias + y;
    // rust: let index = yp.to_bits() as i32 as usize;
    // rust: let s_phi = yp - frac_bias;
    // rust: let sd = y * cos[index] - x * s_phi;
    // rust: let mut theta = asin[index] + (6.0 + sd * sd) * sd * 0.166_666_666_666_666_66;
    // rust: if steep {
    // rust: theta = std::f64::consts::FRAC_PI_2 - theta;
}
    // rust: if negative_x {
    // rust: theta = std::f64::consts::PI - theta;
}
    // rust: if negative_y {
    // rust: theta = -theta;
}
    // rust: theta
}
// The padded section as `FlowingFluid.getFlow` sees it (section-relative positions).
FlowView :: struct {
    pad: ^'a Padded,
    info: ^'a [Info],
}
    // rust: impl FlowView<'_> {
id :: proc(self: ^Self, p: BlockPos) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.pad.blocks[pi(p.x, p.y, p.z)]
}
}
    // rust: impl FluidFlowWorld for FlowView<'_> {
    // rust: type Error = Infallible;
    // rust: type Block = u32;
fluid :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.info[self.id(p) as usize].fluid)
}
block :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.id(p))
}
blocks_fluid_flow :: proc(self: ^Self, state: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.info[state as usize].blocks_flow
}
is_ice_class :: proc(self: ^Self, state: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.info[state as usize].ice
}
    // rust: fn is_face_sturdy(
    // rust: &mut self,
    // rust: state: u32,
    // rust: _: BlockPos,
    // rust: d: Direction,
    // rust: ) -> Result<bool, Infallible> {
    // rust: Ok(self.info[state as usize].sturdy & 1 << d as u8 != 0)
}
}
// Whether a `shaders/` pack's fluid top with these corner heights is split into triangles along
// its north-east to south-west diagonal, as Iris 1.11.7 draws it, rather than along vanilla's
// north-west to south-east one (`FluidRenderer.tesselate` puts its vertices NW, SW, SE, NE, and
// `RenderSystem`'s quad indices join vertex 0 to 2).
//
// Our probe packs' readings of Iris (#8464) fit this: a top is split along the diagonal whose
// corners differ more in height, and a top whose north-west and south-east corners are level
// (a still, flat top among them) along north-east to south-west. It is a fit, not Iris's code:
// it covers every lava top we read and every still top but one, and misses 26 of the 343 water
// tops we read (undiagnosed).
    // rust: pub(super) fn splits_north_east(nw: f32, ne: f32, sw: f32, se: f32) -> bool {
    // rust: let (along_nw, along_ne) = ((nw - se).abs(), (ne - sw).abs());
    // rust: along_nw < along_ne || along_nw == 0.0
}
// Emits one fluid cell at section-relative `[x, y, z]`.
// `(nether, shader_pack_lighting, separate_ao, shader_pack)`: the Nether's face shading, only the
// up-face value when a shader pack lights the faces (`Mesher::shader_pack_lighting`), whether to
// keep pure alpha for separate AO, and whether a `shaders/` pack draws the terrain
// (`Mesher::shader_pack`: tops split as Iris splits them, [`splits_north_east`]).
    // rust: pub(super) fn tesselate(
    // rust: tables: &MeshTables,
    // rust: (nether, shader_pack_lighting, separate_ao, shader_pack): (bool, bool, bool, bool),
    // rust: pad: &Padded,
    // rust: water_color: u32,
    // rust: out: &mut SectionMesh,
    // rust: [x, y, z]: [i32; 3],
    // rust: ) {
//     use horizon_assets::model::Direction as D;
    // rust: let cardinal = |d: D| {
    // rust: if shader_pack_lighting {
    // rust: lighting::pack_flat(nether)
    // rust: } else {
    // rust: lighting::cardinal(nether, d)
}
}
    // rust: let info = &tables.info;
    // rust: let at = |p: [i32; 3]| &info[pad.blocks[pi(p[0], p[1], p[2])] as usize];
    // rust: let me = at([x, y, z]);
    // rust: let kind = me.fluid.kind();
    // rust: let same = |s: &Info| s.fluid.kind().same_family(kind);
    // rust: let neighbor = |d: Direction| {
    // rust: let [dx, dy, dz] = d.normal();
    // rust: at([x + dx, y + dy, z + dz])
}
    // rust: let (down, up) = (neighbor(Direction::Down), neighbor(Direction::Up));
    // rust: let should_render = |d: Direction| !same(neighbor(d)) && !occluded_by_self(me, d);
    // rust: let render_up = !same(up);
    // rust: let render_down =
    // rust: should_render(Direction::Down) && !occluded_by(Direction::Down, MAX_HEIGHT, down);
    // rust: let sides = [
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: ]
    // rust: .map(should_render);
    // rust: if !render_up && !render_down && !sides.iter().any(|&s| s) {
    // rust: return;
}
    // rust: let water = matches!(kind, FluidKind::Water | FluidKind::FlowingWater);
    // rust: let tint = if water {
    // rust: water_color & 0xFF_FFFF
    // rust: } else {
    // rust: 0xFF_FFFF
}
    // rust: let emission = if water {
    // rust: 0
    // rust: } else {
    // rust: crate::mesher::hdr_tier("lava", 15)
}
    // rust: let color = |by: f32| {
    // rust: let rgb = [16, 8, 0].map(|shift| lighting::scale((tint >> shift & 255) as i32, by) as u32);
    // rust: if separate_ao {
    // rust: pack_rgb(rgb)
    // rust: } else {
    // rust: crate::mesher::emitting(pack_rgb(rgb), emission)
}
}
    // rust: let height = |p: [i32; 3]| -> f32 {
    // rust: let s = at(p);
    // rust: if same(s) {
    // rust: if same(at([p[0], p[1] + 1, p[2]])) {
    // rust: 1.0
    // rust: } else {
    // rust: s.fluid.own_height()
}
    // rust: } else if !s.legacy_solid {
    // rust: 0.0
    // rust: } else {
    // rust: -1.0
}
}
    // rust: let own = height([x, y, z]);
    // rust: let (mut ne, mut nw, mut se, mut sw) = (1.0f32, 1.0f32, 1.0f32, 1.0f32);
    // rust: if own < 1.0 {
    // rust: let n = height([x, y, z - 1]);
    // rust: let s = height([x, y, z + 1]);
    // rust: let e = height([x + 1, y, z]);
    // rust: let w = height([x - 1, y, z]);
        // calculateAverageHeight(self, height2, height1, corner)
    // rust: let average = |h2: f32, h1: f32, corner: [i32; 3]| -> f32 {
    // rust: if h1 >= 1.0 || h2 >= 1.0 {
    // rust: return 1.0;
}
    // rust: let mut sum = [0f32; 2];
    // rust: let mut add = |h: f32| {
    // rust: if h >= 0.8 {
    // rust: sum[0] += h * 10.0;
    // rust: sum[1] += 10.0;
    // rust: } else if h >= 0.0 {
    // rust: sum[0] += h;
    // rust: sum[1] += 1.0;
}
}
    // rust: if h1 > 0.0 || h2 > 0.0 {
    // rust: let hc = height(corner);
    // rust: if hc >= 1.0 {
    // rust: return 1.0;
}
    // rust: add(hc);
}
    // rust: add(own);
    // rust: add(h1);
    // rust: add(h2);
    // rust: sum[0] / sum[1]
}
    // rust: ne = average(n, e, [x + 1, y, z - 1]);
    // rust: nw = average(n, w, [x - 1, y, z - 1]);
    // rust: se = average(s, e, [x + 1, y, z + 1]);
    // rust: sw = average(s, w, [x - 1, y, z + 1]);
}
    // rust: let light = |p: [i32; 3]| {
    // rust: let above = [p[0], p[1] + 1, p[2]];
    // rust: pack_coords(lighting::max_coords(
    // rust: lighting::coords(pad, at(p), p),
    // rust: lighting::coords(pad, at(above), above),
    // rust: ))
}
    // rust: let (still, flow, overlay) = if water {
    // rust: (
    // rust: tables.water_still,
    // rust: tables.water_flow,
    // rust: Some(tables.water_overlay),
    // rust: )
    // rust: } else {
    // rust: (tables.lava_still, tables.lava_flow, None)
}
    // rust: let target = if water {
    // rust: &mut out.translucent
    // rust: } else {
    // rust: &mut out.solid
}
    // rust: let mut sprite_layers = Vec::new();
    // rust: let mut quad = |v: [([f32; 3], [f32; 2]); 4],
    // rust: layer: u16,
    // rust: color: u32,
    // rust: light: u16,
    // rust: back: bool,
    // rust: face: usize| {
    // rust: if tables.is_animated(layer) && !sprite_layers.contains(&layer) {
    // rust: sprite_layers.push(layer);
}
    // rust: let color = if separate_ao {
    // rust: color
    // rust: } else {
    // rust: fluid_face(color, face)
}
    // rust: let vertex = |(pos, uv)| TerrainVertex::new(pos, uv, layer, color, light);
    // rust: target.extend(v.map(vertex));
    // rust: if back {
    // rust: target.extend([v[0], v[3], v[2], v[1]].map(vertex));
}
}
    // rust: let (fx, fy, fz) = (x as f32, y as f32, z as f32);
    // rust: let bottom = if render_down { EPSILON } else { 0.0 };
    // rust: if render_up && !occluded_by(Direction::Up, nw.min(sw).min(se.min(ne)), up) {
    // rust: nw -= EPSILON;
    // rust: sw -= EPSILON;
    // rust: se -= EPSILON;
    // rust: ne -= EPSILON;
    // rust: let flow_vector = flow_at(
    // rust: &mut FlowView { pad, info },
    // rust: me.fluid,
    // rust: BlockPos::new(x, y, z),
    // rust: )
    // rust: .unwrap_or_else(|e| match e {});
    // rust: let (layer, uv) = if flow_vector.x == 0.0 && flow_vector.z == 0.0 {
    // rust: (still, [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]])
    // rust: } else {
    // rust: let angle =
    // rust: atan2(flow_vector.z, flow_vector.x) as f32 - std::f64::consts::FRAC_PI_2 as f32;
    // rust: let s = trig::sin(f64::from(angle)) * 0.25;
    // rust: let c = trig::cos(f64::from(angle)) * 0.25;
    // rust: (
    // rust: flow,
    // rust: [
    // rust: [0.5 + (-c - s), 0.5 + (-c + s)],
    // rust: [0.5 + (-c + s), 0.5 + (c + s)],
    // rust: [0.5 + (c + s), 0.5 + (c - s)],
    // rust: [0.5 + (c - s), 0.5 + (-c - s)],
    // rust: ],
    // rust: )
}
        // FluidState.shouldRenderBackwardUpFace over the 3x3 cells above.
    // rust: let backward = (-1..=1).any(|ox| {
    // rust: (-1..=1).any(|oz| {
    // rust: let s = at([x + ox, y + 1, z + oz]);
    // rust: !same(s) && !s.solid
    // rust: })
    // rust: });
    // rust: let mut corners = [
    // rust: ([fx, fy + nw, fz], uv[0]),
    // rust: ([fx, fy + sw, fz + 1.0], uv[1]),
    // rust: ([fx + 1.0, fy + se, fz + 1.0], uv[2]),
    // rust: ([fx + 1.0, fy + ne, fz], uv[3]),
    // rust: ];
        // Starting from the south-west corner joins it to the north-east one (0 to 2), with the
        // same winding.
    // rust: if shader_pack && splits_north_east(nw, ne, sw, se) {
    // rust: corners.rotate_left(1);
}
    // rust: quad(
    // rust: corners,
    // rust: layer,
    // rust: color(cardinal(D::Up)),
    // rust: light([x, y, z]),
    // rust: backward,
    // rust: Direction::Up as usize,
    // rust: );
}
    // rust: if render_down {
    // rust: let y0 = fy + bottom;
    // rust: quad(
    // rust: [
    // rust: ([fx, y0, fz], [0.0, 0.0]),
    // rust: ([fx + 1.0, y0, fz], [1.0, 0.0]),
    // rust: ([fx + 1.0, y0, fz + 1.0], [1.0, 1.0]),
    // rust: ([fx, y0, fz + 1.0], [0.0, 1.0]),
    // rust: ],
    // rust: still,
    // rust: color(cardinal(D::Down)),
    // rust: light([x, y - 1, z]),
    // rust: false,
    // rust: Direction::Down as usize,
    // rust: );
}
    // rust: let side_light = light([x, y, z]);
    // rust: let up_shade = cardinal(D::Up);
    // rust: for (i, d) in [
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let (h0, h1, [x0, z0], [x1, z1]) = match d {
    // rust: Direction::North => (nw, ne, [fx, fz + EPSILON], [fx + 1.0, fz + EPSILON]),
    // rust: Direction::South => (
    // rust: se,
    // rust: sw,
    // rust: [fx + 1.0, fz + 1.0 - EPSILON],
    // rust: [fx, fz + 1.0 - EPSILON],
    // rust: ),
    // rust: Direction::West => (sw, nw, [fx + EPSILON, fz + 1.0], [fx + EPSILON, fz]),
    // rust: _ => (
    // rust: ne,
    // rust: se,
    // rust: [fx + 1.0 - EPSILON, fz],
    // rust: [fx + 1.0 - EPSILON, fz + 1.0],
    // rust: ),
}
    // rust: let face_state = neighbor(d);
    // rust: if !sides[i] || occluded_by(d, h0.max(h1), face_state) {
    // rust: continue;
}
    // rust: let (layer, is_overlay) = match overlay {
    // rust: Some(layer) if face_state.overlay => (layer, true),
    // rust: _ => (flow, false),
}
        // Vanilla's side is the up value times the side's; a shader pack's has no side factor.
    // rust: let side = if shader_pack_lighting {
    // rust: 1.0
    // rust: } else if matches!(d, Direction::North | Direction::South) {
    // rust: cardinal(D::North)
    // rust: } else {
    // rust: cardinal(D::West)
}
    // rust: let (v0, v1) = ((1.0 - h0) * 0.5, (1.0 - h1) * 0.5);
    // rust: quad(
    // rust: [
    // rust: ([x0, fy + h0, z0], [0.0, v0]),
    // rust: ([x1, fy + h1, z1], [0.5, v1]),
    // rust: ([x1, fy + bottom, z1], [0.5, 0.5]),
    // rust: ([x0, fy + bottom, z0], [0.0, 0.5]),
    // rust: ],
    // rust: layer,
    // rust: color(up_shade * side),
    // rust: side_light,
    // rust: !is_overlay,
    // rust: d as usize,
    // rust: );
}
    // rust: out.sprite_layers.extend(sprite_layers);
}

    // rust: mod tests {
//     use super::*;
atan2_follows_the_table_approximation :: proc() {
}
    // rust: for (y, x) in [
    // rust: (1.0, 0.0),
    // rust: (0.0, 1.0),
    // rust: (-0.5, 0.25),
    // rust: (0.3, -0.9),
    // rust: (-1.0, -1.0),
    // rust: (0.1, 0.7),
    // rust: ] {
    // rust: let exact = f64::atan2(y, x);
    // rust: assert!((atan2(y, x) - exact).abs() < 1e-6, "{y} {x}");
}
    // rust: assert!(atan2(f64::NAN, 1.0).is_nan());
}
    // Corner heights read back from Iris 1.11.7 with a probe pack of ours (#8464), from water
    // and lava spreading over a floor and from a still lake, and whether Iris split each top
    // along north-east to south-west. Each height is the vanilla average it reads as (for
    // example 13/27 for 0.48047 + 0.001), less `FluidRenderer`'s 0.001.
fluid_tops_split_where_iris_splits_them :: proc() {
}
    // rust: let h = |num: f32, den: f32| num / den - 0.001;
        // (north-west, north-east, south-west, south-east)
    // rust: let cases = [
            // Still and flat: a lake's water, a lava pool.
    // rust: ([h(8.0, 9.0); 4], true),
    // rust: ([h(96.0, 117.0); 4], true),
            // Level along one axis: both diagonals equally steep.
    // rust: (
    // rust: [h(5.0, 9.0), h(13.0, 27.0), h(5.0, 9.0), h(13.0, 27.0)],
    // rust: false,
    // rust: ),
    // rust: (
    // rust: [h(100.0, 117.0), h(100.0, 117.0), h(2.0, 3.0), h(2.0, 3.0)],
    // rust: false,
    // rust: ),
            // North-west to south-east steeper.
    // rust: ([h(5.0, 9.0), h(4.0, 9.0), h(4.0, 9.0), h(7.0, 18.0)], false),
    // rust: ([h(7.0, 18.0), h(4.0, 9.0), h(4.0, 9.0), h(5.0, 9.0)], false),
    // rust: ([h(5.0, 6.0), h(4.0, 9.0), h(2.0, 9.0), h(2.0, 9.0)], false),
            // North-east to south-west steeper.
    // rust: ([h(1.0, 2.0), h(5.0, 9.0), h(7.0, 18.0), h(4.0, 9.0)], true),
    // rust: (
    // rust: [h(4.0, 9.0), h(2.0, 9.0), h(96.0, 117.0), h(4.0, 9.0)],
    // rust: true,
    // rust: ),
            // North-west and south-east level: a saddle.
    // rust: ([h(4.0, 9.0), h(7.0, 18.0), h(7.0, 18.0), h(4.0, 9.0)], true),
    // rust: ];
    // rust: for ([nw, ne, sw, se], iris) in cases {
    // rust: assert_eq!(
    // rust: splits_north_east(nw, ne, sw, se),
    // rust: iris,
    // rust: "{:?}",
    // rust: [nw, ne, sw, se]
    // rust: );
}
}
coverage_of_full_and_partial_faces :: proc() {
}
    // rust: assert_eq!(coverage(&VoxelShape::block(), Direction::North), 1.0);
    // rust: assert_eq!(coverage(&VoxelShape::block(), Direction::Up), 1.0);
    // rust: assert_eq!(coverage(&VoxelShape::empty(), Direction::East), 0.0);
        // A bottom slab covers the lower half of each side and the whole floor.
    // rust: let slab = VoxelShape::from_cube([1, 2, 1], &[true, false]).unwrap();
    // rust: assert_eq!(coverage(&slab, Direction::South), 0.5);
    // rust: assert_eq!(coverage(&slab, Direction::Down), 1.0);
    // rust: assert_eq!(coverage(&slab, Direction::Up), 0.0);
}
}
