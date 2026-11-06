//! Transpiled from Horizon Rust crate
//! Module: horizon-optifine_connect
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Which tile a connected face gets. A face's texture directions ([`Axes`]) say where its left,
//! right, up and down neighbours are; [`neighbours`] turns the ones that join into a bit mask;
//! each method then reads its tile from the mask ([`ctm_index`], [`compact_quarters`],
//! [`horizontal`], [`overlay_tiles`]...) or from the position ([`repeat_index`],
//! [`random_index`]).
//!
//! Nothing here knows OptiFine's files, so other connected-texture formats (Fusion's) share it:
//! they build the same mask and read the same tables.
//!
//! The tile tables are OptiFine's documented templates (`ctm_template.png`,
//! `ctm_compact_template.png`, `horizontal_template.png`, `vertical_template.png`,
//! `overlay_template.png`), read off the images.

// use super::Symmetry;

    // rust: pub type Vec3 = [i32; 3];

    // rust: const fn add(a: Vec3, b: Vec3) -> Vec3 {
    // rust: [a[0] + b[0], a[1] + b[1], a[2] + b[2]]
}

    // rust: const fn neg(a: Vec3) -> Vec3 {
    // rust: [-a[0], -a[1], -a[2]]
}

/// In `i64`: a coordinate times -1 can leave `i32`.
    // rust: const fn dot(a: Vec3, b: Vec3) -> i64 {
    // rust: a[0] as i64 * b[0] as i64 + a[1] as i64 * b[1] as i64 + a[2] as i64 * b[2] as i64
}

/// Block faces in `Direction` order, the bit order of [`super::faces`].
pub const Face = enum {
    Down,
    Up,
    North,
    South,
    West,
    East,
};

pub const EAST: Vec3 = [1, 0, 0];
pub const WEST: Vec3 = [-1, 0, 0];
pub const UP: Vec3 = [0, 1, 0];
pub const SOUTH: Vec3 = [0, 0, 1];
pub const NORTH: Vec3 = [0, 0, -1];

    // rust: impl Face {
    // rust: pub const ALL: [Face; 6] = [
    // rust: Face::Down,
    // rust: Face::Up,
    // rust: Face::North,
    // rust: Face::South,
    // rust: Face::West,
    // rust: Face::East,
    // rust: ];

    // rust: pub const fn normal(self) -> Vec3 {
    // rust: match self {
    // rust: Face::Down => [0, -1, 0],
    // rust: Face::Up => UP,
    // rust: Face::North => NORTH,
    // rust: Face::South => SOUTH,
    // rust: Face::West => WEST,
    // rust: Face::East => EAST,
}
}

    /// The face's [`super::faces`] bit.
    // rust: pub const fn bit(self) -> u8 {
    // rust: 1 << self as u8
}
}

/// A block state's `axis`.
pub const Axis = enum {
    X,
    Y,
    Z,
};

/// Where a face's texture points in the world: its right (+u) and its up (-v).
pub const Axes = struct {
    right: Vec3,
    up: Vec3,
};

    // rust: impl Axes {
    /// Where a quad's own texture points, from its corners' positions and UVs, snapped to the
    /// block's axes (Continuity's `orient=texture`): a turned or mirrored model's face turns or
    /// mirrors its neighbours too. `None` for a quad whose UVs don't span it.
pub fn texture(positions: *[[f32; 3]; 4], uv: *[[f32; 2]; 4]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let edge = |k: usize| [0, 1, 2].map(|c| positions[k][c] - positions[0][c]);
    // rust: let step = |k: usize| [uv[k][0] - uv[0][0], uv[k][1] - uv[0][1]];
    // rust: let (e1, e2, d1, d2) = (edge(1), edge(3), step(1), step(3));
        // The edges in UV terms: e = du * (d/du) + dv * (d/dv), solved for the two gradients.
    // rust: let det = d1[0] * d2[1] - d2[0] * d1[1];
    // rust: if !det.is_finite() || det.abs() < 1e-6 {
    // rust: return None;
}
    // rust: let along_u = [0, 1, 2].map(|c| (e1[c] * d2[1] - e2[c] * d1[1]) / det);
    // rust: let along_v = [0, 1, 2].map(|c| (e2[c] * d1[0] - e1[c] * d2[0]) / det);
        // Only a direction close to one of the block's axes (within about 25°): a plant's 45°
        // planes have none.
    // rust: let snap = |v: [f32; 3]| {
    // rust: let k = (0..3).max_by(|&a, &b| v[a].abs().total_cmp(&v[b].abs()))?;
    // rust: let length = v.iter().map(|c| c * c).sum::<f32>().sqrt();
    // rust: let mut out = [0; 3];
    // rust: out[k] = if v[k] > 0.0 { 1 } else { -1 };
    // rust: (v[k].abs() > 0.9 * length).then_some(out)
}
        // v grows downward: the texture's up is against it.
    // rust: let (right, up) = (snap(along_u)?, neg(snap(along_v)?));
    // rust: (dot(right, up) == 0).then_some(Self { right, up })
}

    /// On a vanilla cube: `BlockElement`'s default UVs (OptiFine's `ctm`, Continuity's
    /// `orient=none`).
    // rust: pub const fn cube(face: Face) -> Self {
    // rust: let (right, up) = match face {
    // rust: Face::Down => (EAST, SOUTH),
    // rust: Face::Up => (EAST, NORTH),
    // rust: Face::North => (WEST, UP),
    // rust: Face::South => (EAST, UP),
    // rust: Face::West => (SOUTH, UP),
    // rust: Face::East => (NORTH, UP),
}
    // rust: Self { right, up }
}

    /// On a cube column turned to `axis` as vanilla's blockstates turn one (`x=90, y=90` for
    /// `x`, `x=90` for `z`): OptiFine's horizontal and vertical methods, Continuity's
    /// `orient=state_axis`.
pub fn column(face: Face, axis: Axis) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let turn = |[x, y, z]: Vec3| match axis {
    // rust: Axis::Y => [x, y, z],
            // x=90 takes up to north.
    // rust: Axis::Z => [x, z, -y],
            // Then y=90 takes north to east.
    // rust: Axis::X => [y, z, x],
}
    // rust: let model = Face::ALL
    // rust: .into_iter()
    // rust: .find(|f| turn(f.normal()) == face.normal())
    // rust: .expect("a quarter turn maps faces onto faces");
    // rust: let cube = Self::cube(model);
    // rust: Self {
    // rust: right: turn(cube.right),
    // rust: up: turn(cube.up),
}
}
}

/// Neighbour bits of a face's mask, in texture directions.
pub const U: u8 = 1;
pub const UR: u8 = 2;
pub const R: u8 = 4;
pub const DR: u8 = 8;
pub const D: u8 = 16;
pub const DL: u8 = 32;
pub const L: u8 = 64;
pub const UL: u8 = 128;

/// Each mask bit of a face and the offset from the block of the neighbour it stands for.
pub fn offsets(axes: Axes) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (r, u) = (axes.right, axes.up);
    // rust: let (l, d) = (neg(r), neg(u));
    // rust: [
    // rust: (U, u),
    // rust: (UR, add(u, r)),
    // rust: (R, r),
    // rust: (DR, add(d, r)),
    // rust: (D, d),
    // rust: (DL, add(d, l)),
    // rust: (L, l),
    // rust: (UL, add(u, l)),
    // rust: ]
}

/// The neighbours of a face that join it, by `joins(offset from the block)`: all eight, so
/// overlays see the corners whatever the sides. With `inner_seams`, a neighbour whose own face
/// is covered (the block in front of it joins too) doesn't count, which draws a seam on inner
/// corners.
    // rust: pub fn neighbours(
    // rust: axes: Axes,
    // rust: normal: Vec3,
    // rust: inner_seams: bool,
    // rust: mut joins: impl FnMut(Vec3) -> bool,
    // rust: ) -> u8 {
    // rust: let mut mask = 0;
    // rust: for (bit, offset) in offsets(axes) {
    // rust: if joins(offset) && !(inner_seams && joins(add(offset, normal))) {
    // rust: mask |= bit;
}
}
    // rust: mask
}

/// The 47 tiles of `ctm_template.png`, as the neighbours each one joins: its sides, and a
/// corner only where both sides beside it join (a lone corner draws nothing).
    // rust: const TEMPLATE: [u8; 47] = [
    // rust: 0,
    // rust: R,
    // rust: R | L,
    // rust: L,
    // rust: R | D,
    // rust: D | L,
    // rust: U | R | D,
    // rust: R | D | L,
    // rust: U | UR | R | D | L,
    // rust: U | R | DR | D | L,
    // rust: U | R | D | DL | L | UL,
    // rust: U | UR | R | D | L | UL,
    // rust: D,
    // rust: R | DR | D,
    // rust: R | DR | D | DL | L,
    // rust: D | DL | L,
    // rust: U | R,
    // rust: U | L,
    // rust: U | R | L,
    // rust: U | D | L,
    // rust: U | R | D | L | UL,
    // rust: U | R | D | DL | L,
    // rust: U | R | DR | D | DL | L,
    // rust: U | UR | R | DR | D | L,
    // rust: U | D,
    // rust: U | UR | R | DR | D,
    // rust: U | UR | R | DR | D | DL | L | UL,
    // rust: U | D | DL | L | UL,
    // rust: U | R | DR | D,
    // rust: R | D | DL | L,
    // rust: U | UR | R | D,
    // rust: R | DR | D | L,
    // rust: U | UR | R | D | DL | L | UL,
    // rust: U | UR | R | DR | D | L | UL,
    // rust: U | UR | R | D | DL | L,
    // rust: U | R | DR | D | L | UL,
    // rust: U,
    // rust: U | UR | R,
    // rust: U | UR | R | L | UL,
    // rust: U | L | UL,
    // rust: U | UR | R | L,
    // rust: U | D | L | UL,
    // rust: U | R | L | UL,
    // rust: U | D | DL | L,
    // rust: U | R | DR | D | DL | L | UL,
    // rust: U | UR | R | DR | D | DL | L,
    // rust: U | R | D | L,
    // rust: ];

/// A mask without the corners whose sides don't both join.
    // rust: pub(crate) const fn reduce(mask: u8) -> u8 {
    // rust: let mut out = mask & (U | R | D | L);
    // rust: let corners = [(UR, U | R), (DR, D | R), (DL, D | L), (UL, U | L)];
    // rust: let mut i = 0;
    // rust: while i < corners.len() {
    // rust: let (corner, sides) = corners[i];
    // rust: if mask & corner != 0 && mask & sides == sides {
    // rust: out |= corner;
}
    // rust: i += 1;
}
    // rust: out
}

    // rust: const CTM_INDEX: [u8; 256] = {
    // rust: let mut table = [0; 256];
    // rust: let mut mask = 0;
    // rust: while mask < 256 {
    // rust: let reduced = reduce(mask as u8);
    // rust: let mut tile = 0;
    // rust: while TEMPLATE[tile] != reduced {
    // rust: tile += 1;
}
    // rust: table[mask] = tile as u8;
    // rust: mask += 1;
}
    // rust: table
}

/// The `ctm` tile (0-46) for a neighbour mask.
pub fn ctm_index(mask: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CTM_INDEX[mask as usize] as usize
}

/// `ctm_compact`'s tile (0-4) for each quarter of the face: top-left, top-right, bottom-left,
/// bottom-right. Tile 0 has every border, 1 none, 2 its left and right ones (joined up and
/// down), 3 its top and bottom ones, 4 only the inner corners.
pub fn compact_quarters(mask: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let quarter = |vertical: u8, horizontal: u8, corner: u8| match (
    // rust: mask & vertical != 0,
    // rust: mask & horizontal != 0,
    // rust: ) {
    // rust: (false, false) => 0,
    // rust: (true, false) => 2,
    // rust: (false, true) => 3,
    // rust: (true, true) if mask & corner != 0 => 1,
    // rust: (true, true) => 4,
}
    // rust: [
    // rust: quarter(U, L, UL),
    // rust: quarter(U, R, UR),
    // rust: quarter(D, L, DL),
    // rust: quarter(D, R, DR),
    // rust: ]
}

/// `horizontal`'s tile: 0 the left end of a row, 1 its middle, 2 its right end, 3 alone.
pub fn horizontal(mask: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (mask & L != 0, mask & R != 0) {
    // rust: (false, true) => 0,
    // rust: (true, true) => 1,
    // rust: (true, false) => 2,
    // rust: (false, false) => 3,
}
}

/// `vertical`'s tile: 0 the bottom of a column, 1 its middle, 2 its top, 3 alone.
pub fn vertical(mask: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (mask & U != 0, mask & D != 0) {
    // rust: (true, false) => 0,
    // rust: (true, true) => 1,
    // rust: (false, true) => 2,
    // rust: (false, false) => 3,
}
}

/// `horizontal+vertical`'s 7 tiles: a face alone in its row takes `vertical`'s first three as
/// tiles 4-6.
pub fn horizontal_vertical(mask: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (horizontal(mask), vertical(mask)) {
    // rust: (3, 3) => 3,
    // rust: (3, v) => 4 + v,
    // rust: (h, _) => h,
}
}

/// `vertical+horizontal`'s 7 tiles: a face alone in its column takes `horizontal`'s first three
/// as tiles 4-6.
pub fn vertical_horizontal(mask: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (vertical(mask), horizontal(mask)) {
    // rust: (3, 3) => 3,
    // rust: (3, h) => 4 + h,
    // rust: (v, _) => v,
}
}

/// `overlay`'s tiles (0-16) for a face whose neighbours in `mask` hold the block drawn over it:
/// one tile for the sides (two when they face each other: the template has no tile for those),
/// and one for each corner with neither side beside it.
pub fn overlay_tiles(mask: u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sides: &[usize] = match (mask & U != 0, mask & R != 0, mask & D != 0, mask & L != 0) {
    // rust: (false, false, false, false) => &[],
    // rust: (true, false, false, false) => &[15],
    // rust: (false, true, false, false) => &[7],
    // rust: (false, false, true, false) => &[1],
    // rust: (false, false, false, true) => &[9],
    // rust: (true, true, false, false) => &[10],
    // rust: (true, false, false, true) => &[11],
    // rust: (false, true, true, false) => &[3],
    // rust: (false, false, true, true) => &[4],
    // rust: (true, false, true, false) => &[15, 1],
    // rust: (false, true, false, true) => &[9, 7],
    // rust: (true, true, true, false) => &[12],
    // rust: (true, false, true, true) => &[6],
    // rust: (true, true, false, true) => &[13],
    // rust: (false, true, true, true) => &[5],
    // rust: (true, true, true, true) => &[8],
}
    // rust: let corners = [
    // rust: (UR, U | R, 14),
    // rust: (DR, D | R, 0),
    // rust: (DL, D | L, 2),
    // rust: (UL, U | L, 16),
    // rust: ];
    // rust: let corners = corners
    // rust: .into_iter()
    // rust: .filter(move |&(corner, beside, _)| mask & corner != 0 && mask & beside == 0)
    // rust: .map(|(_, _, tile)| tile);
    // rust: sides.iter().copied().chain(corners)
}

/// `repeat`'s tile: the block's place in a `width` x `height` pattern laid along the face's
/// texture directions, row by row from the top.
pub fn repeat_index(pos: Vec3, axes: Axes, width: u32, height: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, h) = (width.max(1) as i64, height.max(1) as i64);
    // rust: let u = dot(pos, axes.right).rem_euclid(w);
    // rust: let v = (-dot(pos, axes.up)).rem_euclid(h);
    // rust: (v * w + u) as usize
}

/// The face whose choice `face` shares under `symmetry`: itself, the first of its opposite
/// pair, or one face for all six.
pub fn symmetric_face(face: Face, symmetry: Symmetry) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match symmetry {
    // rust: Symmetry::None => face,
    // rust: Symmetry::Opposite => Face::ALL[face as usize & !1],
    // rust: Symmetry::All => Face::Down,
}
}

/// `random`'s tile (below `count`): a fixed choice for the block at `pos` and its (symmetric)
/// face, so a world looks the same every time it loads. `weights` is one per tile; any other
/// length (none given) picks every tile alike. `loops` rehashes the choice (`randomLoops`).
pub fn random_index(pos: Vec3, face: Face, loops: u32, weights: *[u32], count: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // The golden-ratio step keeps a zero input (the origin's down face) off `mix`'s fixed point.
    // rust: let step = |h: u32, v: u32| mix((h ^ v).wrapping_add(0x9e37_79b9));
    // rust: let mut h = step(0, pos[0] as u32);
    // rust: h = step(h, pos[1] as u32);
    // rust: h = step(h, pos[2] as u32);
    // rust: h = step(h, face as u32);
    // rust: for _ in 0..loops {
    // rust: h = step(h, 0);
}
    // rust: let total: u64 = weights.iter().map(|&w| u64::from(w)).sum();
    // rust: if weights.len() != count || total == 0 {
    // rust: return h as usize % count.max(1);
}
    // rust: let mut pick = u64::from(h) % total;
    // rust: weights
    // rust: .iter()
    // rust: .position(|&w| match pick.checked_sub(u64::from(w)) {
    // rust: Some(rest) => {
    // rust: pick = rest;
    // rust: false
}
    // rust: None => true,
    // rust: })
    // rust: .expect("pick is below the weights' total")
}

/// A 32-bit finalizer (Chris Wellons' `lowbias32`): every input bit moves every output bit.
pub fn mix(mut x: u32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: x ^= x >> 16;
    // rust: x = x.wrapping_mul(0x7feb_352d);
    // rust: x ^= x >> 15;
    // rust: x = x.wrapping_mul(0x846c_a68b);
    // rust: x ^ (x >> 16)
}

    // rust: mod tests {
//     use super::*;

pub fn ctm_tiles_from_the_template() void {
}
        // Read off ctm_template.png by hand: the tile's borders are the sides that don't join.
    // rust: assert_eq!(ctm_index(0), 0);
    // rust: assert_eq!(ctm_index(R), 1);
    // rust: assert_eq!(ctm_index(R | L), 2);
    // rust: assert_eq!(ctm_index(L), 3);
    // rust: assert_eq!(ctm_index(D), 12);
    // rust: assert_eq!(ctm_index(U | D), 24);
    // rust: assert_eq!(ctm_index(U), 36);
    // rust: assert_eq!(ctm_index(255), 26);
    // rust: assert_eq!(ctm_index(U | R | D | L), 46);
        // The top-left of a 3x3 square, and a corner whose sides don't both join.
    // rust: assert_eq!(ctm_index(R | DR | D), 13);
    // rust: assert_eq!(ctm_index(U | UR | DR | DL | UL), 36);
        // One missing corner of a full square.
    // rust: assert_eq!(ctm_index(!UR), 44);
}

pub fn compact_quarters_from_the_template() void {
}
        // ctm_compact_template.png: 0 every border, 1 none, 2 left and right borders, 3 top and
        // bottom ones, 4 the inner corners only.
    // rust: assert_eq!(compact_quarters(0), [0; 4]);
    // rust: assert_eq!(compact_quarters(255), [1; 4]);
    // rust: assert_eq!(compact_quarters(U | D), [2; 4]);
    // rust: assert_eq!(compact_quarters(L | R), [3; 4]);
    // rust: assert_eq!(compact_quarters(U | R | D | L), [4; 4]);
        // The left end of a row, and a bottom-left corner of a square.
    // rust: assert_eq!(compact_quarters(R), [0, 3, 0, 3]);
    // rust: assert_eq!(compact_quarters(U | UR | R), [2, 1, 0, 3]);
}

pub fn rows_and_columns() void {
}
    // rust: assert_eq!([R, R | L, L, 0].map(horizontal), [0, 1, 2, 3]);
    // rust: assert_eq!([U, U | D, D, 0].map(vertical), [0, 1, 2, 3]);
        // Joined left: horizontal wins. Alone in the row: the column's tiles, from 4.
    // rust: assert_eq!(horizontal_vertical(L | U), 2);
    // rust: assert_eq!([U, U | D, D, 0].map(horizontal_vertical), [4, 5, 6, 3]);
    // rust: assert_eq!([R, R | L, L, 0].map(vertical_horizontal), [4, 5, 6, 3]);
    // rust: assert_eq!(vertical_horizontal(U | R), 0);
}

pub fn overlay_tiles_from_the_template() void {
}
    // rust: let tiles = |mask| overlay_tiles(mask).collect::<Vec<_>>();
    // rust: assert_eq!(tiles(0), [0usize; 0]);
    // rust: assert_eq!(tiles(D), [1]);
    // rust: assert_eq!(tiles(DR), [0]);
    // rust: assert_eq!(tiles(D | DR), [1], "a corner beside a side is the side's");
    // rust: assert_eq!(tiles(U | D), [15, 1]);
    // rust: assert_eq!(tiles(U | L | DR), [11, 0]);
    // rust: assert_eq!(tiles(255), [8]);
    // rust: assert_eq!(tiles(UR | UL), [14, 16]);
}

pub fn face_directions() void {
}
        // A north face seen from the north: right is west.
    // rust: assert_eq!(Axes::cube(Face::North).right, WEST);
    // rust: assert_eq!(Axes::column(Face::North, Axis::Y), Axes::cube(Face::North));
        // An x log: its grain runs east-west on the top face, its end turned on the east one.
    // rust: let top = Axes::column(Face::Up, Axis::X);
    // rust: assert_eq!((top.right, top.up), (SOUTH, EAST));
    // rust: let end = Axes::column(Face::East, Axis::X);
    // rust: assert_eq!((end.right, end.up), (SOUTH, [0, -1, 0]));
        // A z log: north face is the end.
    // rust: let end = Axes::column(Face::North, Axis::Z);
    // rust: assert_eq!((end.right, end.up), (EAST, [0, -1, 0]));
}

pub fn every_turned_face_keeps_its_texture_facing_out() void {
}
        // A texture's right x up is the face's normal on a cube, and turning keeps it.
    // rust: let cross = |a: Vec3, b: Vec3| {
    // rust: [
    // rust: a[1] * b[2] - a[2] * b[1],
    // rust: a[2] * b[0] - a[0] * b[2],
    // rust: a[0] * b[1] - a[1] * b[0],
    // rust: ]
}
    // rust: for face in Face::ALL {
    // rust: for axis in [Axis::X, Axis::Y, Axis::Z] {
    // rust: let a = Axes::column(face, axis);
    // rust: assert_eq!(cross(a.right, a.up), face.normal(), "{face:?} {axis:?}");
}
}
}

pub fn neighbour_masks() void {
}
    // rust: let axes = Axes::cube(Face::North);
    // rust: let normal = Face::North.normal();
        // Glass at the block's west (its north face's right) and above it.
    // rust: let glass = |o: Vec3| o == WEST || o == UP || o == add(WEST, UP);
    // rust: assert_eq!(neighbours(axes, normal, false, glass), U | UR | R);
        // A block in front of the west neighbour covers its face: an inner seam.
    // rust: let covered = |o: Vec3| glass(o) || o == add(WEST, NORTH);
    // rust: assert_eq!(neighbours(axes, normal, false, covered), U | UR | R);
    // rust: assert_eq!(neighbours(axes, normal, true, covered), U | UR);
        // A covered corner counts as covered too.
    // rust: let corner = |o: Vec3| glass(o) || o == add(add(WEST, UP), NORTH);
    // rust: assert_eq!(neighbours(axes, normal, true, corner), U | R);
}

pub fn symmetry() void {
}
    // rust: assert_eq!(symmetric_face(Face::South, Symmetry::None), Face::South);
    // rust: assert_eq!(symmetric_face(Face::South, Symmetry::Opposite), Face::North);
    // rust: assert_eq!(symmetric_face(Face::East, Symmetry::Opposite), Face::West);
    // rust: assert_eq!(symmetric_face(Face::Up, Symmetry::Opposite), Face::Down);
    // rust: assert_eq!(symmetric_face(Face::East, Symmetry::All), Face::Down);
}

pub fn repeat_patterns() void {
}
    // rust: let north = Axes::cube(Face::North);
        // Along the north face the pattern runs west (its right), rows downward.
    // rust: assert_eq!(repeat_index([0, 0, 0], north, 2, 2), 0);
    // rust: assert_eq!(repeat_index([-1, 0, 0], north, 2, 2), 1);
    // rust: assert_eq!(repeat_index([0, -1, 0], north, 2, 2), 2);
    // rust: assert_eq!(repeat_index([-3, 5, 7], north, 3, 2), 3);
}

pub fn random_choices_are_fixed_and_weighted() void {
}
        // Pinned, so a world keeps its tiles across versions (lowbias32 worked by hand in Python).
    // rust: assert_eq!(random_index([12, 64, -7], Face::Up, 0, &[], 5), 3);
    // rust: assert_eq!(random_index([0, 0, 0], Face::Down, 0, &[], 5), 4);
    // rust: assert_eq!(random_index([0, 0, 0], Face::Down, 1, &[], 4), 2);
        // Weights that don't fit the tiles pick every tile alike, and never past them.
    // rust: for x in 0..50 {
    // rust: assert!(random_index([x, 0, 0], Face::Up, 0, &[1, 1, 1], 2) < 2);
}
        // Weights 1:3 over a 100x100 floor: about a quarter take tile 0.
    // rust: let mut zeros = 0;
    // rust: for x in 0..100 {
    // rust: for z in 0..100 {
    // rust: zeros += (random_index([x, 0, z], Face::Up, 0, &[1, 3], 2) == 0) as u32;
}
}
    // rust: assert!((2200..2800).contains(&zeros), "{zeros}");
        // A zero weight is never picked.
    // rust: for x in 0..200 {
    // rust: assert_ne!(random_index([x, 1, 2], Face::Up, 3, &[2, 0, 1], 3), 1);
}
        // Loops pick another pattern.
    // rust: let differs = (0..50)
    // rust: .filter(|&x| {
    // rust: random_index([x, 0, 0], Face::Up, 0, &[], 4)
    // rust: != random_index([x, 0, 0], Face::Up, 1, &[], 4)
    // rust: })
    // rust: .count();
    // rust: assert!(differs > 20, "{differs}");
}

pub fn a_quads_own_texture_directions() void {
}
        // A north face with the cube's UVs: its texture points as the cube's does.
    // rust: let north = [
    // rust: [1.0, 1.0, 0.0],
    // rust: [0.0, 1.0, 0.0],
    // rust: [0.0, 0.0, 0.0],
    // rust: [1.0, 0.0, 0.0],
    // rust: ];
    // rust: let standard = [[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0]];
    // rust: assert_eq!(
    // rust: Axes::texture(&north, &standard),
    // rust: Some(Axes::cube(Face::North))
    // rust: );
        // Mirrored (a vanilla pane face): right turns to east.
    // rust: let mirrored = [[1.0, 0.0], [0.0, 0.0], [0.0, 1.0], [1.0, 1.0]];
    // rust: assert_eq!(
    // rust: Axes::texture(&north, &mirrored),
    // rust: Some(Axes {
    // rust: right: EAST,
    // rust: up: UP
    // rust: })
    // rust: );
        // A top face turned a quarter (y=90): the texture's up points east, its right south.
    // rust: let top = [
    // rust: [0.0, 1.0, 0.0],
    // rust: [1.0, 1.0, 0.0],
    // rust: [1.0, 1.0, 1.0],
    // rust: [0.0, 1.0, 1.0],
    // rust: ];
    // rust: let turned = [[0.0, 1.0], [0.0, 0.0], [1.0, 0.0], [1.0, 1.0]];
    // rust: assert_eq!(
    // rust: Axes::texture(&top, &turned),
    // rust: Some(Axes {
    // rust: right: SOUTH,
    // rust: up: EAST
    // rust: })
    // rust: );
        // UVs that don't span the quad, or that run diagonally across it.
    // rust: assert_eq!(Axes::texture(&north, &[[0.5, 0.5]; 4]), None);
    // rust: let diagonal = [[0.5, 0.0], [1.0, 0.5], [0.5, 1.0], [0.0, 0.5]];
    // rust: assert_eq!(Axes::texture(&north, &diagonal), None);
    // rust: assert_eq!(Axes::texture(&north, &[[f32::NAN; 2]; 4]), None);
        // A plant's plane, turned 45° about y: no block axis to connect along.
    // rust: let plant = [
    // rust: [1.0, 1.0, 1.0],
    // rust: [0.0, 1.0, 0.0],
    // rust: [0.0, 0.0, 0.0],
    // rust: [1.0, 0.0, 1.0],
    // rust: ];
    // rust: assert_eq!(Axes::texture(&plant, &standard), None);
}
}
