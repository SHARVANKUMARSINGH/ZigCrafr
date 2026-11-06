//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_sides
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A mesh's solid quads sorted by the side they face, so that the renderer
//! can leave out the quads turned away from the eye before the GPU shades
//! their vertices.
//!
//! A quad in the plane `x = p` whose corners go counter-clockwise seen from
//! +X faces +X. From an eye at `x < p` it is seen from behind, and at
//! `x = p` edge on; the solid pipeline culls back faces, so it draws nothing
//! from there. A bucket of such quads draws nothing at all while the eye is
//! at or below the lowest of their planes, and likewise for the other five
//! axis directions. The seventh bucket holds every other quad (sloped,
//! rotated, degenerate, or whose two triangles wind opposite ways): it is
//! drawn from everywhere.
//!
//! The buckets lie one after another in the mesh, in an order chosen so that
//! the buckets an eye can see are usually one or two runs of quads: one draw
//! each. Coplanar quads facing one way keep their model order, so an overlay
//! on its base still draws in that order. Solid cutout quads are otherwise
//! ordered from the outside toward the section interior to reduce overdraw.
//!
//! The opaque quads (`OPAQUE_LAYER`) and the cutout ones of each bucket are
//! apart, so that each of Metal's two solid passes draws only its own quads
//! (`Part`). Where the renderer draws them in two passes (`group_parts`), all
//! the opaque buckets come first, then all the cutout ones, so each part is
//! one or two runs; elsewhere each bucket holds its opaque quads, then its
//! cutout ones, so one pass over all of them draws the runs it drew before.
// use std::sync::atomic::{AtomicBool, Ordering};

// use super::{OPAQUE_LAYER, TerrainVertex};

/// The buckets in mesh order: +X, +Z, other, +Y, -Z, -X, -Y. Seen from
/// above (+Y, the commonest case), each pair of horizontal sides with a
/// common corner is then one run, or two.
    // rust: const BUCKETS: [Bucket; 7] = [
    // rust: Bucket::Side(0, true),
    // rust: Bucket::Side(2, true),
    // rust: Bucket::Other,
    // rust: Bucket::Side(1, true),
    // rust: Bucket::Side(2, false),
    // rust: Bucket::Side(0, false),
    // rust: Bucket::Side(1, false),
    // rust: ];
pub const OTHER: usize = 2;
/// How far, in blocks, the eye must be behind a bucket's planes before the
/// bucket is left out. The renderer computes both the eye and the section
/// origins in `f32`, with errors far below this.
pub const MARGIN: f32 = 1.0 / 16.0;

pub const Bucket = enum {
    /// Quads in a plane across `axis` facing its positive (`true`) or
    /// negative direction.
    Side(usize, bool),
    Other,
};

/// Whether meshes sorted from now on put every bucket's opaque quads before
/// any cutout ones: set by the renderer when it draws them in two passes.
pub const GROUPED: AtomicBool = AtomicBool::new(false);

/// Sorts later meshes for two solid passes (`true`) or one.
pub fn group_parts(on: bool) void {
}
    // rust: GROUPED.store(on, Ordering::Relaxed);
}

/// The bucket and whether it holds cutout quads of the `n`th part of a
/// mesh, in mesh order.
pub fn slot(grouped: bool, n: usize) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if grouped {
    // rust: (n % 7, n >= 7)
    // rust: } else {
    // rust: (n / 2, n % 2 == 1)
}
}

/// Where each part of each bucket of a mesh's solid quads ends, and the
/// planes that tell whether a bucket can face the eye.
pub const Sides = struct {
    /// The solid quads up to the end of each part of each bucket, in mesh
    /// order (`slot`).
    ends: [u32,
    /// Whether all the opaque parts come first (`group_parts`).
    grouped: bool,
    /// Whether opaque and cutout quads are apart; else either part is every
    /// quad.
    split: bool,
    /// Per bucket facing a positive direction, its lowest plane; facing a
    /// negative one, its highest (unused for the other bucket).
    planes: [f32,
};

    // rust: impl Sides {
    /// `quads` solid quads in one bucket drawn from everywhere: for meshes
    /// that were not sorted.
pub fn unsorted(quads: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut ends = [0; 14];
    // rust: ends[OTHER * 2..].fill(quads);
    // rust: Self {
    // rust: ends,
    // rust: grouped: false,
    // rust: split: false,
    // rust: planes: [0.0; 7],
}
}

    /// A sort with these parts' `ends` and `planes`, for tests.
    // rust: pub(crate) fn from_parts(
    // rust: ends: [u32; 14],
    // rust: grouped: bool,
    // rust: split: bool,
    // rust: planes: [f32; 7],
    // rust: ) -> Self {
    // rust: Self {
    // rust: ends,
    // rust: grouped,
    // rust: split,
    // rust: planes,
}
}

    /// The number of solid quads the buckets hold.
pub fn quads(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ends[13]
}

    /// Calls `draw(first, count)` for each run of quads an eye at `eye`
    /// (relative to the mesh's origin) can see the front of, nearest the
    /// start first. Empty buckets do not break a run.
pub fn visible(self: *Self, eye: [f32; 3], draw: impl FnMut(u32) void {
}
    // rust: self.visible_from(eye, eye[1], Part::All, draw);
}

    /// `visible` for every eye from `eye` straight down to the height `low`: the camera and
    /// its water mirror's eye below the plane, which differ only in y. Only the quads of
    /// `part`, but every quad of a mesh whose parts are not split.
pub fn visible_from(self: *Self, eye: [f32; 3], low: f32, part: Part, draw: impl FnMut(u32) void {
}
    // rust: let seen = |i: usize| match BUCKETS[i] {
    // rust: Bucket::Side(axis, true) => eye[axis] > self.planes[i] - MARGIN,
    // rust: Bucket::Side(1, false) => low < self.planes[i] + MARGIN,
    // rust: Bucket::Side(axis, false) => eye[axis] < self.planes[i] + MARGIN,
    // rust: Bucket::Other => true,
}
    // rust: self.runs(seen, part, draw);
}

    /// For GPU culling's copy of `visible_from` with every part (`gfx::gpu_culling`),
    /// which then only compares: where each bucket of a mesh sorted for one pass ends,
    /// in `BUCKETS` order, and what `visible_from` compares the eye with for each. That
    /// is the lowest plane less `MARGIN` for a bucket facing a positive direction, the
    /// highest plus `MARGIN` for one facing a negative direction, and 0 for the other
    /// bucket, which it never compares. `None` for a mesh sorted for two passes
    /// (`group_parts`), whose buckets lie in two stretches each.
pub fn thresholds(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.grouped {
    // rust: return None;
}
    // rust: let t: [f32; 7] = std::array::from_fn(|i| match BUCKETS[i] {
    // rust: Bucket::Side(_, true) => self.planes[i] - MARGIN,
    // rust: Bucket::Side(_, false) => self.planes[i] + MARGIN,
    // rust: Bucket::Other => 0.0,
    // rust: });
        // A bucket's cutout quads end it (`slot`).
    // rust: Some((std::array::from_fn(|b| self.ends[b * 2 + 1]), t))
}

    /// The runs of `part`'s quads facing every way.
pub fn every(self: *Self, part: Part, draw: impl FnMut(u32) void {
}
    // rust: self.runs(|_| true, part, draw);
}

    /// Calls `draw` for each run of `part`'s quads in the buckets `seen` keeps.
pub fn runs(self: *Self, seen: impl Fn(usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut start = 0;
    // rust: let mut run: Option<u32> = None;
    // rust: for (n, &end) in self.ends.iter().enumerate() {
    // rust: if end == start {
    // rust: continue;
}
    // rust: let (bucket, cutout) = slot(self.grouped, n);
    // rust: let wanted = match part {
    // rust: Part::All => true,
    // rust: _ if !self.split => true,
    // rust: Part::Opaque => !cutout,
    // rust: Part::Cutout => cutout,
}
    // rust: match (wanted && seen(bucket), run) {
    // rust: (true, None) => run = Some(start),
    // rust: (false, Some(first)) => {
    // rust: draw(first, start - first);
    // rust: run = None;
}
    // rust: _ => {}
}
    // rust: start = end;
}
    // rust: if let Some(first) = run {
    // rust: draw(first, start - first);
}
}
}

/// The quads `Sides::visible_from` draws: all of them, or those of one of
/// Metal's two solid passes (terrain.wgsl's `opaque_quad`).
pub const Part = enum {
    All,
    Opaque,
    Cutout,
};

/// The bucket of a quad: the axis plane it lies in and the side its
/// triangles (corners 0, 1, 2 and 0, 2, 3, as the renderer draws them) face.
pub fn bucket(quad: *[TerrainVertex; 4]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = quad.map(|v| v.pos);
    // rust: for axis in 0..3 {
    // rust: if p.iter().any(|v| v[axis] != p[0][axis]) {
    // rust: continue;
}
        // The normal's component along `axis`, twice each triangle's area.
    // rust: let (u, w) = ((axis + 1) % 3, (axis + 2) % 3);
    // rust: let area = |a: usize, b: usize, c: usize| {
    // rust: (p[b][u] - p[a][u]) * (p[c][w] - p[a][w]) - (p[b][w] - p[a][w]) * (p[c][u] - p[a][u])
}
    // rust: let (first, second) = (area(0, 1, 2), area(0, 2, 3));
    // rust: let positive = first >= 0.0 && second >= 0.0;
    // rust: let negative = first <= 0.0 && second <= 0.0;
    // rust: if positive == negative {
            // Opposite windings, or no area at all.
    // rust: return OTHER;
}
    // rust: return BUCKETS
    // rust: .iter()
    // rust: .position(|b| matches!(*b, Bucket::Side(a, s) if a == axis && s == positive))
    // rust: .expect("every side has a bucket");
}
    // rust: OTHER
}

/// Reorders `solid`'s quads by bucket, opaque ones first in each. Solid
/// cutout quads are also ordered front to back within each axis-facing
/// bucket; quads that tie keep the mesher's order (the quad's index ends its
/// sort key), so coplanar overlays still draw over their base.
pub fn sort(solid: *mut std.ArrayList(TerrainVertex)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: sort_tinted(solid, &mut Vec::new())
}

/// `sort`, moving each quad's tint in `tints` (one per quad, or none) with it.
pub fn sort_tinted(solid: *mut std.ArrayList(TerrainVertex), tints: *mut std.ArrayList(u32)) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let grouped = GROUPED.load(Ordering::Relaxed);
    // rust: SORT_SCRATCH.with_borrow_mut(|scratch| sort_with(solid, tints, grouped, scratch))
}

/// `sort`, with all the opaque parts first when `grouped`.
pub fn sort_parts(solid: *mut std.ArrayList(TerrainVertex), grouped: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SORT_SCRATCH.with_borrow_mut(|scratch| sort_with(solid, &mut Vec::new(), grouped, scratch))
}

/// `sort`'s buffers, kept by each meshing thread so sorting a mesh allocates
/// nothing: each quad's part, its sort key, and the sorted quads, which are
/// copied back into the mesh's own (recycled) buffer.
pub const SortScratch = struct {
    slots: std.ArrayList(u8),
    keys: std.ArrayList(u64),
    sorted: Vec<[TerrainVertex,
    tints: std.ArrayList(u32),
};
    // rust: thread_local! {
pub const SORT_SCRATCH: std::cell::RefCell<SortScratch> = Default::default();
}

/// `f32::total_cmp`'s order as an unsigned integer's.
pub fn total_order_key(v: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bits = v.to_bits() as i32;
    // rust: (bits ^ (((bits >> 31) as u32) >> 1) as i32) as u32 ^ 0x8000_0000
}

    // rust: fn sort_with(
    // rust: solid: &mut Vec<TerrainVertex>,
    // rust: tints: &mut Vec<u32>,
    // rust: grouped: bool,
    // rust: scratch: &mut SortScratch,
    // rust: ) -> Sides {
    // rust: let (quads, rest) = solid.as_chunks::<4>();
    // rust: debug_assert!(rest.is_empty(), "solid vertices come in quads");
    // rust: let quads_len = quads.len();
    // rust: let cutout = |q: &[TerrainVertex; 4]| q[0].layer & OPAQUE_LAYER == 0;
    // Each quad's part, by its place in mesh order (`slot`).
    // rust: let position = |b: usize, cutout: bool| match grouped {
    // rust: true => b + 7 * usize::from(cutout),
    // rust: false => b * 2 + usize::from(cutout),
}
    // rust: let slots = &mut scratch.slots;
    // rust: slots.clear();
    // rust: slots.extend(quads.iter().map(|q| position(bucket(q), cutout(q)) as u8));
    // rust: let has_cutout = quads.iter().any(cutout);
    // rust: let mut counts = [0u32; 7];
    // rust: let mut slot_counts = [0u32; 14];
    // rust: let mut planes = [0f32; 7];
    // rust: for (quad, &part) in quads.iter().zip(slots.iter()) {
    // rust: slot_counts[usize::from(part)] += 1;
    // rust: let b = slot(grouped, usize::from(part)).0;
    // rust: if let Bucket::Side(axis, positive) = BUCKETS[b] {
    // rust: let p = quad[0].pos[axis];
    // rust: planes[b] = match (counts[b], positive) {
    // rust: (0, _) => p,
    // rust: (_, true) => planes[b].min(p),
    // rust: (_, false) => planes[b].max(p),
}
}
    // rust: counts[b] += 1;
}
    // rust: let mut slot_ends = [0u32; 14];
    // rust: let mut total = 0;
    // rust: for (end, count) in slot_ends.iter_mut().zip(slot_counts) {
    // rust: total += count;
    // rust: *end = total;
}
    // rust: if has_cutout || counts.iter().filter(|&&c| c > 0).count() > 1 {
        // One integer key per quad: its part, then (cutout meshes, side
        // buckets) its plane from the outside in, then its index, which keeps
        // the order of equal quads as a stable sort does.
    // rust: let keys = &mut scratch.keys;
    // rust: keys.clear();
    // rust: keys.extend(
    // rust: quads
    // rust: .iter()
    // rust: .zip(slots.iter())
    // rust: .enumerate()
    // rust: .map(|(i, (quad, &part))| {
    // rust: let plane = match BUCKETS[slot(grouped, usize::from(part)).0] {
    // rust: Bucket::Side(axis, positive) if has_cutout => {
    // rust: let key = total_order_key(quad[0].pos[axis]);
    // rust: if positive { !key } else { key }
}
    // rust: _ => 0,
}
    // rust: u64::from(part) << 56 | u64::from(plane) << 24 | i as u64
    // rust: }),
    // rust: );
    // rust: debug_assert!(quads.len() < 1 << 24);
    // rust: keys.sort_unstable();
    // rust: let sorted = &mut scratch.sorted;
    // rust: sorted.clear();
    // rust: sorted.extend(keys.iter().map(|&k| quads[(k & 0xFF_FFFF) as usize]));
    // rust: solid.clear();
    // rust: solid.extend_from_slice(sorted.as_flattened());
    // rust: if tints.len() == quads_len {
    // rust: let sorted_tints = &mut scratch.tints;
    // rust: sorted_tints.clear();
    // rust: sorted_tints.extend(keys.iter().map(|&k| tints[(k & 0xFF_FFFF) as usize]));
    // rust: std::mem::swap(tints, sorted_tints);
}
}
    // rust: Sides {
    // rust: ends: slot_ends,
    // rust: grouped,
    // rust: split: true,
    // rust: planes,
}
}

    // rust: mod tests {
//     use super::*;

    /// The sort as it was before the integer keys: quads moved to their
    /// parts in order, then a stable sort by plane in each side bucket.
pub fn reference(solid: *[TerrainVertex], grouped: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let quads = solid.as_chunks::<4>().0;
    // rust: let has_cutout = quads.iter().any(|q| q[0].layer & OPAQUE_LAYER == 0);
    // rust: let mut sorted = Vec::new();
    // rust: for n in 0..14 {
    // rust: let (b, cutout) = slot(grouped, n);
    // rust: let mut part: Vec<[TerrainVertex; 4]> = quads
    // rust: .iter()
    // rust: .filter(|q| bucket(q) == b && (q[0].layer & OPAQUE_LAYER == 0) == cutout)
    // rust: .copied()
    // rust: .collect();
    // rust: if let (Bucket::Side(axis, positive), true) = (BUCKETS[b], has_cutout) {
    // rust: part.sort_by(|a, b| {
    // rust: let (a, b) = (a[0].pos[axis], b[0].pos[axis]);
    // rust: if positive {
    // rust: b.total_cmp(&a)
    // rust: } else {
    // rust: a.total_cmp(&b)
}
    // rust: });
}
    // rust: sorted.extend(part);
}
    // rust: sorted.into_flattened()
}

pub fn integer_keys_sort_as_the_stable_sort_did() void {
}
    // rust: let mut state = 0x2545_F491_4F6C_DD1Du64;
    // rust: let mut next = move || {
    // rust: state ^= state << 13;
    // rust: state ^= state >> 7;
    // rust: state ^= state << 17;
    // rust: state
}
    // rust: for round in 0..100 {
    // rust: let grouped = round % 2 == 1;
    // rust: let mut solid = Vec::new();
    // rust: for _ in 0..(next() % 300) {
    // rust: let origin = [0, 1, 2].map(|_| (next() % 34) as f32 / 2.0 - 0.5);
                // Some negative and signed-zero planes too.
    // rust: let origin = if next() % 9 == 0 {
    // rust: origin.map(|v| -v)
    // rust: } else {
    // rust: origin
}
    // rust: let layer = if round % 3 == 0 {
    // rust: OPAQUE_LAYER
    // rust: } else {
    // rust: (next() % 2) as u16 * OPAQUE_LAYER
}
    // rust: let faces = cube(origin, layer);
    // rust: let face = (next() % 6) as usize;
    // rust: solid.extend_from_slice(&faces[face * 4..face * 4 + 4]);
}
    // rust: let expected = reference(&solid, grouped);
    // rust: let sides = sort_parts(&mut solid, grouped);
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&solid),
    // rust: bytemuck::cast_slice::<_, u8>(&expected),
    // rust: "round {round}"
    // rust: );
    // rust: assert_eq!(sides.quads() as usize * 4, solid.len());
}
}

pub fn quad(corners: [[f32; 3]; 4], layer: u16) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: corners.map(|p| TerrainVertex::new(p, [0.0; 2], layer, 0, 0))
}

    /// A unit block's six faces at `origin`, wound counter-clockwise seen
    /// from outside, as block models are.
pub fn cube(origin: [f32; 3], layer: u16) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, y, z] = origin;
    // rust: let (a, b, c) = (x + 1.0, y + 1.0, z + 1.0);
    // rust: [
    // rust: [[a, y, z], [a, b, z], [a, b, c], [a, y, c]], // +X
    // rust: [[x, y, z], [x, y, c], [x, b, c], [x, b, z]], // -X
    // rust: [[x, b, z], [x, b, c], [a, b, c], [a, b, z]], // +Y
    // rust: [[x, y, z], [a, y, z], [a, y, c], [x, y, c]], // -Y
    // rust: [[x, y, c], [a, y, c], [a, b, c], [x, b, c]], // +Z
    // rust: [[x, y, z], [x, b, z], [a, b, z], [a, y, z]], // -Z
    // rust: ]
    // rust: .into_iter()
    // rust: .flat_map(|q| quad(q, layer))
    // rust: .collect()
}

    /// Where each bucket ends, in a mesh sorted for one pass.
pub fn bucket_ends(sides: *Sides) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert!(!sides.grouped);
    // rust: std::array::from_fn(|b| sides.ends[b * 2 + 1])
}

pub fn runs(sides: *Sides, eye: [f32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: sides.visible(eye, |first, count| out.push((first, count)));
    // rust: out
}

    /// The quads of `solid` whose triangles face `eye`, by their layer.
pub fn front_facing(solid: *[TerrainVertex], eye: [f32; 3]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sub = |a: [f32; 3], b: [f32; 3]| [a[0] - b[0], a[1] - b[1], a[2] - b[2]];
    // rust: solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .filter(|q| {
    // rust: [[0, 1, 2], [0, 2, 3]].iter().any(|t| {
    // rust: let (e1, e2) = (sub(q[t[1]].pos, q[t[0]].pos), sub(q[t[2]].pos, q[t[0]].pos));
    // rust: let n = [
    // rust: e1[1] * e2[2] - e1[2] * e2[1],
    // rust: e1[2] * e2[0] - e1[0] * e2[2],
    // rust: e1[0] * e2[1] - e1[1] * e2[0],
    // rust: ];
    // rust: let to_eye = sub(eye, q[t[0]].pos);
    // rust: n[0] * to_eye[0] + n[1] * to_eye[1] + n[2] * to_eye[2] > 0.0
    // rust: })
    // rust: })
    // rust: .map(|q| q[0].layer)
    // rust: .collect()
}

pub fn cube_faces_go_to_their_buckets_in_order() void {
}
    // rust: let mut solid = cube([3.0, 4.0, 5.0], 0);
    // rust: for (i, v) in solid.iter_mut().enumerate() {
    // rust: v.layer = (i / 4) as u16;
}
    // rust: let sides = sort(&mut solid);
    // rust: assert_eq!(bucket_ends(&sides), [1, 2, 2, 3, 4, 5, 6]);
    // rust: let layers: Vec<u16> = solid.iter().step_by(4).map(|v| v.layer).collect();
        // +X, +Z, +Y, -Z, -X, -Y.
    // rust: assert_eq!(layers, [0, 4, 2, 5, 1, 3]);
    // rust: assert_eq!(sides.planes[0], 4.0); // +X at x = 4
    // rust: assert_eq!(sides.planes[5], 3.0); // -X at x = 3
    // rust: assert_eq!(sides.planes[3], 5.0); // +Y at y = 5
}

pub fn the_drawn_runs_hold_every_quad_that_faces_the_eye() void {
}
        // Blocks across a section, with a sloped quad and a bowtie.
    // rust: let mut solid = Vec::new();
    // rust: let mut layer = 0;
    // rust: for origin in [
    // rust: [0.0, 0.0, 0.0],
    // rust: [7.0, 3.0, 12.0],
    // rust: [15.0, 15.0, 15.0],
    // rust: [2.0, 9.0, 4.0],
    // rust: ] {
    // rust: for q in cube(origin, 0).chunks(4) {
    // rust: solid.extend(q.iter().map(|v| TerrainVertex { layer, ..*v }));
    // rust: layer += 1;
}
}
    // rust: let slope = [
    // rust: [1.0, 1.0, 1.0],
    // rust: [2.0, 1.0, 1.0],
    // rust: [2.0, 2.0, 2.0],
    // rust: [1.0, 2.0, 2.0],
    // rust: ];
    // rust: let bowtie = [
    // rust: [5.0, 1.0, 1.0],
    // rust: [5.0, 2.0, 2.0],
    // rust: [5.0, 1.0, 2.0],
    // rust: [5.0, 2.0, 1.0],
    // rust: ];
    // rust: for corners in [slope, bowtie] {
    // rust: solid.extend(quad(corners, layer));
    // rust: layer += 1;
}
    // rust: let sides = sort(&mut solid);
    // rust: assert_eq!(sides.quads(), u32::from(layer));
    // rust: let eyes = [-20.0f32, -0.5, 0.0, 3.5, 8.0, 15.99, 16.0, 30.0];
    // rust: for &x in &eyes {
    // rust: for &y in &eyes {
    // rust: for &z in &eyes {
    // rust: let eye = [x, y, z];
    // rust: let mut drawn = Vec::new();
    // rust: for (first, count) in runs(&sides, eye) {
    // rust: drawn.extend(
    // rust: solid[first as usize * 4..(first + count) as usize * 4]
    // rust: .iter()
    // rust: .step_by(4)
    // rust: .map(|v| v.layer),
    // rust: );
}
    // rust: for layer in front_facing(&solid, eye) {
    // rust: assert!(drawn.contains(&layer), "{eye:?} misses quad {layer}");
}
}
}
}
}

pub fn runs_merge_across_hidden_and_empty_buckets() void {
}
    // rust: let mut solid = cube([0.0; 3], 0);
    // rust: let sides = sort(&mut solid);
        // From above, +X and +Z: +X, +Z, (no other), +Y is one run.
    // rust: assert_eq!(runs(&sides, [8.0, 8.0, 8.0]), [(0, 3)]);
        // From below, -X and -Z: -Z, -X, -Y.
    // rust: assert_eq!(runs(&sides, [-8.0, -8.0, -8.0]), [(3, 3)]);
        // From above, -X and +Z: +Z, +Y, then -X.
    // rust: assert_eq!(runs(&sides, [-8.0, 8.0, 8.0]), [(1, 2), (4, 1)]);
        // Inside the block every face is seen from behind.
    // rust: assert!(runs(&sides, [0.5; 3]).is_empty());
        // Level with its top, the eye may see it: the margin keeps it.
    // rust: assert_eq!(runs(&sides, [0.5, 1.0, 0.5]), [(2, 1)]);
}

pub fn an_eye_and_its_mirror_below_see_the_faces_of_both() void {
}
    // rust: let mut solid = cube([0.0; 3], 0);
    // rust: let sides = sort(&mut solid);
    // rust: let both = |eye: [f32; 3], low: f32| {
    // rust: let mut out = Vec::new();
    // rust: sides.visible_from(eye, low, Part::All, |first, count| out.push((first, count)));
    // rust: out
}
        // Above the block: +X, +Z and +Y; with the mirror's eye below it, -Y too.
    // rust: assert_eq!(runs(&sides, [8.0, 8.0, 8.0]), [(0, 3)]);
    // rust: assert_eq!(both([8.0, 8.0, 8.0], -8.0), [(0, 3), (5, 1)]);
        // A mirror above the block's bottom adds nothing.
    // rust: assert_eq!(both([8.0, 8.0, 8.0], 0.5), [(0, 3)]);
        // The sides depend on x and z alone.
    // rust: assert_eq!(both([-8.0, 8.0, -8.0], -8.0), [(2, 4)]);
}

    /// Opaque and cutout quads of each bucket split: each pass's runs hold
    /// exactly its own quads facing the eye, and all of them together the
    /// same runs as one pass.
pub fn each_part_draws_its_own_quads_facing_the_eye() void {
}
        // Two blocks: one opaque, one cutout, then an opaque one again, so
        // every bucket holds both kinds out of order.
    // rust: let mut solid = Vec::new();
    // rust: let mut id = 0u16;
    // rust: for (origin, opaque) in [
    // rust: ([0.0, 0.0, 0.0], true),
    // rust: ([4.0, 2.0, 6.0], false),
    // rust: ([9.0, 5.0, 3.0], true),
    // rust: ] {
    // rust: for q in cube(origin, 0).chunks(4) {
    // rust: let layer = id | if opaque { OPAQUE_LAYER } else { 0 };
    // rust: solid.extend(q.iter().map(|v| TerrainVertex { layer, ..*v }));
    // rust: id += 1;
}
}
    // rust: let unsorted = solid;
    // rust: for grouped in [false, true] {
    // rust: let mut solid = unsorted.clone();
    // rust: let sides = sort_parts(&mut solid, grouped);
    // rust: let layers: Vec<u16> = solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|q| q[0].layer)
    // rust: .collect();
    // rust: for eye in [[20.0, 30.0, -10.0], [-5.0, 1.0, 4.0], [5.0, 3.0, 7.0]] {
    // rust: let quads = |part| {
    // rust: let mut out = Vec::new();
    // rust: sides.visible_from(eye, eye[1], part, |first, count| {
    // rust: out.extend(
    // rust: layers[first as usize..(first + count) as usize]
    // rust: .iter()
    // rust: .copied(),
    // rust: )
    // rust: });
    // rust: out.sort_unstable();
    // rust: out
}
    // rust: let mut facing = front_facing(&solid, eye);
    // rust: facing.sort_unstable();
    // rust: let opaque = quads(Part::Opaque);
    // rust: let cutout = quads(Part::Cutout);
    // rust: assert!(opaque.iter().all(|l| l & OPAQUE_LAYER != 0), "{eye:?}");
    // rust: assert!(cutout.iter().all(|l| l & OPAQUE_LAYER == 0), "{eye:?}");
    // rust: for l in &facing {
    // rust: let mine = if l & OPAQUE_LAYER != 0 {
    // rust: &opaque
    // rust: } else {
    // rust: &cutout
}
    // rust: assert!(
    // rust: mine.contains(l),
    // rust: "{eye:?}: quad {l} facing the eye left out"
    // rust: );
}
    // rust: let mut both = [opaque, cutout].concat();
    // rust: both.sort_unstable();
    // rust: assert_eq!(both, quads(Part::All), "{eye:?}");
}
            // Every way: each part once, whole.
    // rust: let mut every = Vec::new();
    // rust: sides.every(Part::Opaque, |first, count| every.push((first, count)));
    // rust: sides.every(Part::Cutout, |first, count| every.push((first, count)));
    // rust: let total: u32 = every.iter().map(|r| r.1).sum();
    // rust: assert_eq!(total, sides.quads());

            // Two passes: from above a corner, each part is one or two runs.
    // rust: if grouped {
    // rust: let mut count = 0;
    // rust: sides.visible_from([20.0, 30.0, -10.0], 30.0, Part::Opaque, |_, _| count += 1);
    // rust: assert_eq!(count, 2);
}
}
}

    /// A mesh that was not sorted has no parts: each pass draws all of it
    /// (the shader leaves out the other pass's quads).
pub fn unsorted_meshes_draw_everything_in_each_part() void {
}
    // rust: let sides = Sides::unsorted(9);
    // rust: for part in [Part::Opaque, Part::Cutout] {
    // rust: let mut out = Vec::new();
    // rust: sides.every(part, |first, count| out.push((first, count)));
    // rust: assert_eq!(out, [(0, 9)]);
}
}

pub fn unsorted_meshes_draw_everything() void {
}
    // rust: let sides = Sides::unsorted(9);
    // rust: assert_eq!(sides.quads(), 9);
    // rust: assert_eq!(runs(&sides, [-100.0; 3]), [(0, 9)]);
    // rust: assert!(runs(&Sides::unsorted(0), [0.0; 3]).is_empty());
}

pub fn one_bucket_keeps_the_mesh_as_it_is() void {
}
    // rust: let mut solid: Vec<_> = (0..3)
    // rust: .flat_map(|i| {
    // rust: quad(
    // rust: [
    // rust: [1.0, 0.0, 0.0],
    // rust: [1.0, 1.0, 0.0],
    // rust: [1.0, 1.0, 1.0],
    // rust: [1.0, 0.0, 1.0],
    // rust: ],
    // rust: i,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let before = solid.clone();
    // rust: let sides = sort(&mut solid);
    // rust: assert_eq!(bucket_ends(&sides), [3; 7]);
    // rust: assert_eq!(
    // rust: solid.iter().map(|v| v.layer).collect::<Vec<_>>(),
    // rust: before.iter().map(|v| v.layer).collect::<Vec<_>>()
    // rust: );
}

pub fn front_to_back_sort_orders_positive_faces_and_keeps_ties_stable() void {
}
    // rust: let mut solid: Vec<_> = [(1.0, 10), (3.0, 30), (3.0, 31)]
    // rust: .into_iter()
    // rust: .flat_map(|(x, layer)| {
    // rust: quad(
    // rust: [[x, 0.0, 0.0], [x, 1.0, 0.0], [x, 1.0, 1.0], [x, 0.0, 1.0]],
    // rust: layer,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: sort(&mut solid);
    // rust: let layers: Vec<u16> = solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|q| q[0].layer)
    // rust: .collect();
    // rust: assert_eq!(layers, [30, 31, 10]);
}

pub fn front_to_back_sort_orders_negative_faces_toward_the_eye() void {
}
    // rust: let mut solid: Vec<_> = [(3.0, 30), (1.0, 10), (2.0, 20)]
    // rust: .into_iter()
    // rust: .flat_map(|(x, layer)| {
    // rust: quad(
    // rust: [[x, 0.0, 0.0], [x, 0.0, 1.0], [x, 1.0, 1.0], [x, 1.0, 0.0]],
    // rust: layer,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: sort(&mut solid);
    // rust: let layers: Vec<u16> = solid
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .map(|q| q[0].layer)
    // rust: .collect();
    // rust: assert_eq!(layers, [10, 20, 30]);
}
}
