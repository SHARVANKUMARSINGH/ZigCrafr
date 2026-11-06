//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_lighting
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vertex light and colour of model quads, following `BlockModelLighter`
//! (smooth light and ambient occlusion, including the partial-face weights)
//! and `ModelBlockRenderer`'s integer colour arithmetic (`ARGB.gray`,
//! `scaleRGB`, `multiply`).
// use super::{Info, Padded, pi};
// use horizon_assets::model::Direction as D;

/// `LightCoordsUtil.FULL_BRIGHT`.
    // rust: pub(super) const FULL_BRIGHT: u32 = 0x00F0_00F0;

/// `CardinalLighting.DEFAULT`/`NETHER` by face.
    // rust: pub(super) fn cardinal(nether: bool, face: D) -> f32 {
    // rust: match face {
    // rust: D::Down if nether => 0.9,
    // rust: D::Up if nether => 0.9,
    // rust: D::Down => 0.5,
    // rust: D::Up => 1.0,
    // rust: D::North | D::South => 0.8,
    // rust: D::West | D::East => 0.6,
}
}
/// A face's brightness when a shader pack lights the faces (`Mesher::shader_pack_lighting`): no
/// directional shading, every face at the dimension's up-face value (1.0, the Nether's 0.9).
/// Our probe pack's Iris 1.11.7 values fit this: 0.9 on every Nether face, 1.0 in the overworld.
    // rust: pub(super) fn pack_flat(nether: bool) -> f32 {
    // rust: cardinal(nether, D::Up)
}
pub fn normal(face: D) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match face {
    // rust: D::Down => [0, -1, 0],
    // rust: D::Up => [0, 1, 0],
    // rust: D::North => [0, 0, -1],
    // rust: D::South => [0, 0, 1],
    // rust: D::West => [-1, 0, 0],
    // rust: D::East => [1, 0, 0],
}
}
    // rust: pub(super) fn step(p: [i32; 3], face: D) -> [i32; 3] {
    // rust: let n = normal(face);
    // rust: [p[0] + n[0], p[1] + n[1], p[2] + n[2]]
}
    // rust: fn state<'a>(pad: &Padded, info: &'a [Info], p: [i32; 3]) -> &'a Info {
    // rust: &info[pad.blocks[pi(p[0], p[1], p[2])] as usize]
}
/// `LightCoordsUtil.getLightCoords`: light at `p` as seen through `state`
/// (block level << 4 | sky level << 20).
    // rust: pub(super) fn coords(pad: &Padded, state: &Info, p: [i32; 3]) -> u32 {
    // rust: packed_coords(state, pad.light[pi(p[0], p[1], p[2])])
}
/// `coords` of a stored light byte (sky level << 4 | block level).
    // rust: pub(super) fn packed_coords(state: &Info, packed: u8) -> u32 {
    // rust: if state.emissive {
    // rust: return FULL_BRIGHT;
}
    // rust: let block = u32::from((packed & 15).max(state.emission));
    // rust: block << 4 | u32::from(packed >> 4) << 20
}
/// `LightCoordsUtil.max`.
    // rust: pub(super) fn max_coords(a: u32, b: u32) -> u32 {
    // rust: (a >> 4 & 15).max(b >> 4 & 15) << 4 | (a >> 20 & 15).max(b >> 20 & 15) << 20
}
/// `LightCoordsUtil.lightCoordsWithEmission` (a quad's element light emission), with
/// NeoForge's separate block and sky minimums: `[emission; 2]` is vanilla's.
    // rust: pub(super) fn with_min(coords: u32, [block, sky]: [u8; 2]) -> u32 {
    // rust: if block == 0 && sky == 0 {
    // rust: return coords;
}
    // rust: (coords >> 4 & 15).max(u32::from(block)) << 4 | (coords >> 20 & 15).max(u32::from(sky)) << 20
}
/// `LightCoordsUtil.smoothBlend`: zero samples take the centre; samples without
/// sky light borrow the centre's sky.
    // rust: pub(super) fn smooth_blend(mut a: u32, mut b: u32, mut c: u32, center: u32) -> u32 {
    // rust: if center >> 20 & 15 > 2 || center >> 4 & 15 > 2 {
    // rust: for n in [&mut a, &mut b, &mut c] {
    // rust: if *n == 0 {
    // rust: *n = center;
    // rust: } else if *n >> 20 & 15 == 0 {
    // rust: *n |= center & 0x00FF_0000;
}
}
}
    // rust: (a + b + c + center) >> 2 & 0x00FF_00FF
}
/// `LightCoordsUtil.smoothWeightedBlend` (Java float sums and int narrowing).
pub fn weighted_blend(c: [u32; 4], w: [f32; 4]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let channel = |shift: u32| {
    // rust: let v = |i: usize| (c[i] >> shift & 0xFF) as f32 * w[i];
    // rust: (v(0) + v(1) + v(2) + v(3)) as i32 as u32 & 0xFF
}
    // rust: channel(0) | channel(16) << 16
}
/// `ARGB.gray` channel: `Mth.floor(brightness * 255)`. Without the `floorf`
/// call x86-64's baseline instruction set makes of `f32::floor`: truncation,
/// one lower where that rounded a negative value up (saturating as `as` does).
    // rust: pub(super) fn gray(brightness: f32) -> i32 {
    // rust: let v = brightness * 255.0;
    // rust: let whole = v as i32;
    // rust: if whole as f32 > v {
    // rust: whole.saturating_sub(1)
    // rust: } else {
    // rust: whole
}
}
/// One channel of `ARGB.scaleRGB(color, float)`.
    // rust: pub(super) fn scale(channel: i32, by: f32) -> i32 {
    // rust: ((channel as f32 * by) as i32).clamp(0, 255)
}
// SizeInfo indices into the face shape.
pub const DOWN: u8 = 0;
pub const UP: u8 = 1;
pub const NORTH: u8 = 2;
pub const SOUTH: u8 = 3;
pub const WEST: u8 = 4;
pub const EAST: u8 = 5;
pub const FLIP_DOWN: u8 = 6;
pub const FLIP_UP: u8 = 7;
pub const FLIP_NORTH: u8 = 8;
pub const FLIP_SOUTH: u8 = 9;
pub const FLIP_WEST: u8 = 10;
pub const FLIP_EAST: u8 = 11;
pub const Adjacency = struct {
    corners: [D,
    /// Face-shape factor pairs for each vertex's four corner weights.
    weights: [[u8,
    /// Output vertex for each of the four computed corners.
    remap: [usize,
};
    // rust: const fn adjacency(face: D) -> Adjacency {
//     use D::*;
    // rust: match face {
    // rust: Down => Adjacency {
    // rust: corners: [West, East, North, South],
    // rust: weights: [
    // rust: [
    // rust: FLIP_WEST, SOUTH, FLIP_WEST, FLIP_SOUTH, WEST, FLIP_SOUTH, WEST, SOUTH,
    // rust: ],
    // rust: [
    // rust: FLIP_WEST, NORTH, FLIP_WEST, FLIP_NORTH, WEST, FLIP_NORTH, WEST, NORTH,
    // rust: ],
    // rust: [
    // rust: FLIP_EAST, NORTH, FLIP_EAST, FLIP_NORTH, EAST, FLIP_NORTH, EAST, NORTH,
    // rust: ],
    // rust: [
    // rust: FLIP_EAST, SOUTH, FLIP_EAST, FLIP_SOUTH, EAST, FLIP_SOUTH, EAST, SOUTH,
    // rust: ],
    // rust: ],
    // rust: remap: [0, 1, 2, 3],
    // rust: },
    // rust: Up => Adjacency {
    // rust: corners: [East, West, North, South],
    // rust: weights: [
    // rust: [
    // rust: EAST, SOUTH, EAST, FLIP_SOUTH, FLIP_EAST, FLIP_SOUTH, FLIP_EAST, SOUTH,
    // rust: ],
    // rust: [
    // rust: EAST, NORTH, EAST, FLIP_NORTH, FLIP_EAST, FLIP_NORTH, FLIP_EAST, NORTH,
    // rust: ],
    // rust: [
    // rust: WEST, NORTH, WEST, FLIP_NORTH, FLIP_WEST, FLIP_NORTH, FLIP_WEST, NORTH,
    // rust: ],
    // rust: [
    // rust: WEST, SOUTH, WEST, FLIP_SOUTH, FLIP_WEST, FLIP_SOUTH, FLIP_WEST, SOUTH,
    // rust: ],
    // rust: ],
    // rust: remap: [2, 3, 0, 1],
    // rust: },
    // rust: North => Adjacency {
    // rust: corners: [Up, Down, East, West],
    // rust: weights: [
    // rust: [UP, FLIP_WEST, UP, WEST, FLIP_UP, WEST, FLIP_UP, FLIP_WEST],
    // rust: [UP, FLIP_EAST, UP, EAST, FLIP_UP, EAST, FLIP_UP, FLIP_EAST],
    // rust: [
    // rust: DOWN, FLIP_EAST, DOWN, EAST, FLIP_DOWN, EAST, FLIP_DOWN, FLIP_EAST,
    // rust: ],
    // rust: [
    // rust: DOWN, FLIP_WEST, DOWN, WEST, FLIP_DOWN, WEST, FLIP_DOWN, FLIP_WEST,
    // rust: ],
    // rust: ],
    // rust: remap: [3, 0, 1, 2],
    // rust: },
    // rust: South => Adjacency {
    // rust: corners: [West, East, Down, Up],
    // rust: weights: [
    // rust: [UP, FLIP_WEST, FLIP_UP, FLIP_WEST, FLIP_UP, WEST, UP, WEST],
    // rust: [
    // rust: DOWN, FLIP_WEST, FLIP_DOWN, FLIP_WEST, FLIP_DOWN, WEST, DOWN, WEST,
    // rust: ],
    // rust: [
    // rust: DOWN, FLIP_EAST, FLIP_DOWN, FLIP_EAST, FLIP_DOWN, EAST, DOWN, EAST,
    // rust: ],
    // rust: [UP, FLIP_EAST, FLIP_UP, FLIP_EAST, FLIP_UP, EAST, UP, EAST],
    // rust: ],
    // rust: remap: [0, 1, 2, 3],
    // rust: },
    // rust: West => Adjacency {
    // rust: corners: [Up, Down, North, South],
    // rust: weights: [
    // rust: [
    // rust: UP, SOUTH, UP, FLIP_SOUTH, FLIP_UP, FLIP_SOUTH, FLIP_UP, SOUTH,
    // rust: ],
    // rust: [
    // rust: UP, NORTH, UP, FLIP_NORTH, FLIP_UP, FLIP_NORTH, FLIP_UP, NORTH,
    // rust: ],
    // rust: [
    // rust: DOWN, NORTH, DOWN, FLIP_NORTH, FLIP_DOWN, FLIP_NORTH, FLIP_DOWN, NORTH,
    // rust: ],
    // rust: [
    // rust: DOWN, SOUTH, DOWN, FLIP_SOUTH, FLIP_DOWN, FLIP_SOUTH, FLIP_DOWN, SOUTH,
    // rust: ],
    // rust: ],
    // rust: remap: [3, 0, 1, 2],
    // rust: },
    // rust: East => Adjacency {
    // rust: corners: [Down, Up, North, South],
    // rust: weights: [
    // rust: [
    // rust: FLIP_DOWN, SOUTH, FLIP_DOWN, FLIP_SOUTH, DOWN, FLIP_SOUTH, DOWN, SOUTH,
    // rust: ],
    // rust: [
    // rust: FLIP_DOWN, NORTH, FLIP_DOWN, FLIP_NORTH, DOWN, FLIP_NORTH, DOWN, NORTH,
    // rust: ],
    // rust: [
    // rust: FLIP_UP, NORTH, FLIP_UP, FLIP_NORTH, UP, FLIP_NORTH, UP, NORTH,
    // rust: ],
    // rust: [
    // rust: FLIP_UP, SOUTH, FLIP_UP, FLIP_SOUTH, UP, FLIP_SOUTH, UP, SOUTH,
    // rust: ],
    // rust: ],
    // rust: remap: [1, 2, 3, 0],
    // rust: },
}
}
    // rust: const ADJACENCY: [Adjacency; 6] = [
    // rust: adjacency(D::Down),
    // rust: adjacency(D::Up),
    // rust: adjacency(D::North),
    // rust: adjacency(D::South),
    // rust: adjacency(D::West),
    // rust: adjacency(D::East),
    // rust: ];
/// `prepareQuadShape`: the quad's bounds, whether it is partial (smaller than
/// the block face) and whether it is cubic (flush with the block boundary, or
/// flat on a full collision shape).
pub const Shape = struct {
    bounds: [f32,
    partial: bool,
    cubic: bool,
};
pub fn shape(positions: *[[f32; 3]; 4], face: D, full: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mut min, mut max) = ([32f32; 3], [-32f32; 3]);
    // rust: for p in positions {
    // rust: for i in 0..3 {
    // rust: min[i] = min[i].min(p[i]);
    // rust: max[i] = max[i].max(p[i]);
}
}
    // rust: let mut bounds = [0f32; 12];
    // rust: for (index, value) in [
    // rust: (WEST, min[0]),
    // rust: (EAST, max[0]),
    // rust: (DOWN, min[1]),
    // rust: (UP, max[1]),
    // rust: (NORTH, min[2]),
    // rust: (SOUTH, max[2]),
    // rust: ] {
    // rust: bounds[index as usize] = value;
    // rust: bounds[index as usize + 6] = 1.0 - value;
}
    // rust: let (lo, hi) = (1.0e-4f32, 0.9999f32);
    // rust: let partial = |a: usize, b: usize| min[a] >= lo || min[b] >= lo || max[a] <= hi || max[b] <= hi;
    // rust: let (partial, cubic) = match face {
    // rust: D::Down => (partial(0, 2), min[1] == max[1] && (min[1] < lo || full)),
    // rust: D::Up => (partial(0, 2), min[1] == max[1] && (max[1] > hi || full)),
    // rust: D::North => (partial(0, 1), min[2] == max[2] && (min[2] < lo || full)),
    // rust: D::South => (partial(0, 1), min[2] == max[2] && (max[2] > hi || full)),
    // rust: D::West => (partial(1, 2), min[0] == max[0] && (min[0] < lo || full)),
    // rust: D::East => (partial(1, 2), min[0] == max[0] && (max[0] > hi || full)),
}
    // rust: Shape {
    // rust: bounds,
    // rust: partial,
    // rust: cubic,
}
}
/// `prepareQuadFlat` for a quad without a cull face: light from the
/// neighbour when the quad is flush with the face, else from the block itself.
    // rust: pub(super) fn flat(
    // rust: pad: &Padded,
    // rust: own: &Info,
    // rust: pos: [i32; 3],
    // rust: positions: &[[f32; 3]; 4],
    // rust: face: D,
    // rust: ) -> u32 {
    // rust: coords(
    // rust: pad,
    // rust: own,
    // rust: flat_position(pos, positions, face, None, own.full),
    // rust: )
}
/// Where `tesselateFlat` reads the light of a quad of a block at `pos`: the
/// neighbour on its cull face, else `prepareQuadFlat`'s choice (the neighbour
/// when the quad is cubic, else the block itself). `full` is the block's
/// `isCollisionShapeFullBlock`.
    // rust: pub(super) fn flat_position(
    // rust: pos: [i32; 3],
    // rust: positions: &[[f32; 3]; 4],
    // rust: face: D,
    // rust: cull: Option<D>,
    // rust: full: bool,
    // rust: ) -> [i32; 3] {
    // rust: match cull {
    // rust: Some(d) => step(pos, d),
    // rust: None if shape(positions, face, full).cubic => step(pos, face),
    // rust: None => pos,
}
}
/// `prepareQuadAmbientOcclusion`: per-vertex AO brightness (before `ARGB.gray`)
/// and smooth light coords, by vertex index.
    // rust: pub(super) fn ambient_occlusion(
    // rust: pad: &Padded,
    // rust: info: &[Info],
    // rust: own: &Info,
    // rust: pos: [i32; 3],
    // rust: positions: &[[f32; 3]; 4],
    // rust: face: D,
    // rust: ) -> ([f32; 4], [u32; 4]) {
    // rust: let shape = shape(positions, face, own.full);
    // rust: let base = if shape.cubic { step(pos, face) } else { pos };
    // rust: let adjacency = &ADJACENCY[face as usize];
    // rust: let corner = |i: usize| step(base, adjacency.corners[i]);
    // rust: let sample = |p: [i32; 3]| {
    // rust: let s = state(pad, info, p);
    // rust: (coords(pad, s, p), s.shade)
}
    // rust: let (light0, shade0) = sample(corner(0));
    // rust: let (light1, shade1) = sample(corner(1));
    // rust: let (light2, shade2) = sample(corner(2));
    // rust: let (light3, shade3) = sample(corner(3));
    // rust: let permeable = |i: usize| state(pad, info, step(corner(i), face)).permeable;
    // rust: let (p0, p1, p2, p3) = (permeable(0), permeable(1), permeable(2), permeable(3));
    // rust: let diagonal = |a: usize, b: usize, open: bool| {
    // rust: if open {
    // rust: sample(step(corner(a), adjacency.corners[b]))
    // rust: } else {
    // rust: (light0, shade0)
}
}
    // rust: let (light02, shade02) = diagonal(0, 2, p2 || p0);
    // rust: let (light03, shade03) = diagonal(0, 3, p3 || p0);
    // rust: let (light12, shade12) = diagonal(1, 2, p2 || p1);
    // rust: let (light13, shade13) = diagonal(1, 3, p3 || p1);
    // rust: let next = step(pos, face);
    // rust: let next_state = state(pad, info, next);
    // rust: let light_center = if shape.cubic || !next_state.solid {
    // rust: coords(pad, next_state, next)
    // rust: } else {
    // rust: coords(pad, own, pos)
}
    // rust: let shade_center = if shape.cubic {
    // rust: state(pad, info, base).shade
    // rust: } else {
    // rust: own.shade
}
    // rust: let ao = [
    // rust: (shade3 + shade0 + shade03 + shade_center) * 0.25,
    // rust: (shade2 + shade0 + shade02 + shade_center) * 0.25,
    // rust: (shade2 + shade1 + shade12 + shade_center) * 0.25,
    // rust: (shade3 + shade1 + shade13 + shade_center) * 0.25,
    // rust: ];
    // rust: let blended = [
    // rust: smooth_blend(light3, light0, light03, light_center),
    // rust: smooth_blend(light2, light0, light02, light_center),
    // rust: smooth_blend(light2, light1, light12, light_center),
    // rust: smooth_blend(light3, light1, light13, light_center),
    // rust: ];
    // rust: let mut brightness = [0f32; 4];
    // rust: let mut light = [0u32; 4];
    // rust: for (k, &vertex) in adjacency.remap.iter().enumerate() {
    // rust: if shape.partial {
    // rust: let f = |i: usize| shape.bounds[adjacency.weights[k][i] as usize];
    // rust: let w = [f(0) * f(1), f(2) * f(3), f(4) * f(5), f(6) * f(7)];
    // rust: brightness[vertex] =
    // rust: (ao[0] * w[0] + ao[1] * w[1] + ao[2] * w[2] + ao[3] * w[3]).clamp(0.0, 1.0);
    // rust: light[vertex] = weighted_blend(blended, w);
    // rust: } else {
    // rust: brightness[vertex] = ao[k];
    // rust: light[vertex] = blended[k];
}
}
    // rust: (brightness, light)
}

    // rust: mod tests {
//     use super::*;
    // rust: const fn packed(block: u32, sky: u32) -> u32 {
    // rust: block << 4 | sky << 20
}
pub fn smooth_blend_replaces_dark_samples_with_the_centre() void {
}
    // rust: let center = packed(2, 15);
        // A zero sample takes the centre; a sky-less sample borrows its sky.
    // rust: let blended = smooth_blend(0, packed(8, 0), packed(4, 15), center);
    // rust: assert_eq!(blended & 0xFF, (32 + 128 + 64 + 32) / 4);
    // rust: assert_eq!(blended >> 16 & 0xFF, 240);
        // A dark centre leaves samples untouched.
    // rust: assert_eq!(
    // rust: smooth_blend(0, 0, packed(15, 15), packed(1, 1)) & 0xFF,
    // rust: (240 + 16) / 4
    // rust: );
}
pub fn weighted_blend_narrows_like_java_int_casts() void {
}
    // rust: let c = [packed(15, 15); 4];
    // rust: assert_eq!(weighted_blend(c, [0.25; 4]), packed(15, 15));
        // Negative weights (geometry past the block) wrap through the 0xFF mask.
    // rust: assert_eq!(
    // rust: weighted_blend([packed(1, 0); 4], [-0.25; 4]) & 0xFF,
    // rust: (-16i32 as u32) & 0xFF
    // rust: );
}
pub fn gray_floors_like_f32_floor() void {
}
    // rust: let mut values = vec![
    // rust: f32::NAN,
    // rust: f32::INFINITY,
    // rust: f32::NEG_INFINITY,
    // rust: -0.0,
    // rust: 1.0,
    // rust: -1.0,
    // rust: 1e10,
    // rust: -1e10,
    // rust: ];
    // rust: for bits in (0..u32::MAX).step_by(7919) {
    // rust: values.push(f32::from_bits(bits));
}
    // rust: for i in -3000..3000 {
    // rust: values.push(i as f32 / 1024.0);
}
    // rust: for v in values {
    // rust: assert_eq!(gray(v), (v * 255.0).floor() as i32, "{v:e}");
}
}
pub fn colour_arithmetic_matches_argb_helpers() void {
}
    // rust: assert_eq!(gray(1.0), 255);
    // rust: assert_eq!(gray(0.8), 204);
    // rust: assert_eq!(scale(255, 0.5), 127);
    // rust: assert_eq!(scale(gray(0.6), 0.8), 122);
    // rust: assert_eq!(cardinal(true, D::Down), 0.9);
    // rust: assert_eq!(cardinal(false, D::Down), 0.5);
}
pub fn emission_raises_both_channels_and_drops_fractions() void {
}
    // rust: assert_eq!(with_min(0x0087_0013, [0; 2]), 0x0087_0013);
    // rust: assert_eq!(with_min(0x0087_0013, [3; 2]), packed(3, 8));
    // rust: assert_eq!(max_coords(packed(3, 9), packed(7, 2)), packed(7, 9));
}
pub fn block_and_sky_minimums_raise_their_own_channel() void {
}
    // rust: assert_eq!(with_min(0x0087_0013, [15, 0]), packed(15, 8));
    // rust: assert_eq!(with_min(0x0087_0013, [0, 15]), packed(1, 15));
    // rust: assert_eq!(with_min(0x0087_0013, [15, 15]), packed(15, 15));
}
pub fn flat_light_reads_the_neighbour_a_face_looks_at() void {
}
    // rust: let pos = [4, 64, -2];
    // rust: let full_top = [
    // rust: [0.0, 1.0, 0.0],
    // rust: [0.0, 1.0, 1.0],
    // rust: [1.0, 1.0, 1.0],
    // rust: [1.0, 1.0, 0.0],
    // rust: ];
        // A cull face samples its neighbour, whatever the quad's shape.
    // rust: let inset = full_top.map(|[x, _, z]| [x, 0.75, z]);
    // rust: assert_eq!(
    // rust: flat_position(pos, &inset, D::Up, Some(D::Up), false),
    // rust: [4, 65, -2]
    // rust: );
        // A flush quad without a cull face samples its neighbour too: a block
        // drawn at a cell that is now opaque (a moving block, #3002) still
        // takes the light around it.
    // rust: assert_eq!(
    // rust: flat_position(pos, &full_top, D::Up, None, false),
    // rust: [4, 65, -2]
    // rust: );
    // rust: let west = [
    // rust: [0.0, 0.0, 0.0],
    // rust: [0.0, 0.0, 1.0],
    // rust: [0.0, 1.0, 1.0],
    // rust: [0.0, 1.0, 0.0],
    // rust: ];
    // rust: assert_eq!(flat_position(pos, &west, D::West, None, false), [3, 64, -2]);
        // An inset quad (a piston head's arm) takes the block's own light.
    // rust: assert_eq!(flat_position(pos, &inset, D::Up, None, false), pos);
    // rust: assert_eq!(flat_position(pos, &inset, D::Up, None, true), [4, 65, -2]);
}
pub fn quad_shape_classifies_partial_and_cubic_faces() void {
}
    // rust: let full_top = [
    // rust: [0.0, 1.0, 0.0],
    // rust: [0.0, 1.0, 1.0],
    // rust: [1.0, 1.0, 1.0],
    // rust: [1.0, 1.0, 0.0],
    // rust: ];
    // rust: let s = shape(&full_top, D::Up, false);
    // rust: assert!(s.cubic && !s.partial);
    // rust: let slab_top = full_top.map(|[x, _, z]| [x, 0.5, z]);
    // rust: let s = shape(&slab_top, D::Up, false);
    // rust: assert!(!s.cubic && !s.partial);
    // rust: assert!(shape(&slab_top, D::Up, true).cubic);
    // rust: let small = slab_top.map(|[x, y, z]| [x * 0.5, y, z]);
    // rust: let s = shape(&small, D::Up, false);
    // rust: assert!(s.partial);
    // rust: assert_eq!(s.bounds[EAST as usize], 0.5);
    // rust: assert_eq!(s.bounds[FLIP_EAST as usize], 0.5);
}
}
