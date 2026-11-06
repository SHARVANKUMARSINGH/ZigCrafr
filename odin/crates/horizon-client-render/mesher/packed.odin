//! Transpiled from Horizon Rust crate
package horizon_client_render_packed

import "core:fmt"
import "core:mem"
import "core:math"

// The compact layout of a section's solid quads in the arena: most of them are whole faces
// of a block's cube on the block grid, and those take one 24-byte record each instead of
// four 24-byte vertices. terrain.wgsl's `section_corner` expands a record into the very
// vertex words `TerrainVertex` would hold (`packed_vertex` here is the same on the CPU, and
// a record is kept only when it gives back the quad's four vertices bit for bit), so every
// pass draws the same picture from either layout.
//
// A mesh's solid range is then one record per quad in mesh order (so `Sides` and the draws
// count quads as before), padding to a multiple of 4 slots, and the quads no record fits as
// their four vertices: their record holds the distance to those (`FULL`). A record:
//
// - word 0: the tint (0xRRGGBB as the mesher multiplies it) and the colour's alpha byte;
// - word 1: each corner's grey level before the tint;
// - word 2: the UV rectangle in 1/32 of the sprite (u0, u1, v0, v1, 6 bits each) and, per
//   corner, which edge of it its u and v take;
// - word 3: the layer, and corner 0's light (sky and block light over 4, 6 bits each);
// - word 4: corners 1 and 2's light;
// - word 5: corner 3's light, the face (block x, y, z, the axis it faces along, which side
//   of the block, and where and which way its corners go round), and `FULL` clear.
// use super::TerrainVertex;
// use std::sync::atomic::{AtomicBool, Ordering};

// A solid quad's tint the mesher does not know (fluids): only untinted colours pack.
UNKNOWN_TINT :: u32::MAX
// The tint of an untinted quad, whose colour is its grey level.
WHITE :: 0xFF_FFFF
// Word 5's bit of a quad kept as four vertices; word 0 is then the slots from the record
// to its first vertex.
FULL :: 1 << 31
// The draws' base vertex of a compact mesh: `PACKED_BASE + 4 * slot + corner` is a corner of
// the quad whose record is at `slot`; below it, vertex indices name vertices.
PACKED_BASE :: 1 << 28

// Whether meshes sorted from now on get the compact layout: set by the renderer while its
// passes read it (no shader pack).
PACK :: AtomicBool::new(false)

pack_quads :: proc(on: bool) {
}
    // rust: PACK.store(on, Ordering::Relaxed);
}

packing :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: PACK.load(Ordering::Relaxed)
}

// The order corners go round a face: (du, dw) of each step.
ROUND :: [[0, 0], [1, 0], [1, 1], [0, 1]]

// `quad`'s record, if one gives back its four vertices exactly. `tint`: what the mesher
// multiplied its grey levels by (`UNKNOWN_TINT` when it does not say).
pack_quad :: proc(quad: ^[TerrainVertex; 4], tint: u32) -> O {
    // Ported from Horizon
    return {}
}
    // Corners on the block grid of the section.
    // rust: let mut p = [[0u32; 3]; 4];
    // rust: for (to, v) in p.iter_mut().zip(quad) {
    // rust: for (c, &x) in to.iter_mut().zip(&v.pos) {
    // rust: if !(0.0..=16.0).contains(&x) || x.fract() != 0.0 {
    // rust: return None;
}
    // rust: *c = x as u32;
}
}
    // rust: let axis = (0..3).find(|&a| p.iter().all(|c| c[a] == p[0][a]))?;
    // rust: let (u, w) = ((axis + 1) % 3, (axis + 2) % 3);
    // rust: let lo = [u, w].map(|k| p.iter().map(|c| c[k]).min().unwrap_or(0));
    // rust: if lo.iter().any(|&l| l > 15) {
    // rust: return None;
}
    // rust: let mut steps = [0u32; 4];
    // rust: for (step, c) in steps.iter_mut().zip(&p) {
    // rust: let d = [c[u] - lo[0], c[w] - lo[1]];
    // rust: *step = ROUND.iter().position(|r| *r == d)? as u32;
}
    // rust: let (start, dir) = (0..8u32).map(|n| (n & 3, n >> 2)).find(|&(start, dir)| {
    // rust: (0..4u32).all(|i| {
    // rust: let step = if dir == 1 { 4 - i } else { i };
    // rust: steps[i as usize] == (start + step) & 3
    // rust: })
    // rust: })?;
    // rust: let plane = p[0][axis];
    // rust: let mut block = [0u32; 3];
    // rust: block[axis] = plane.min(15);
    // rust: block[u] = lo[0];
    // rust: block[w] = lo[1];
    // rust: let side = plane - block[axis];
    // rust: let orient = block[0]
    // rust: | block[1] << 4
    // rust: | block[2] << 8
    // rust: | (axis as u32) << 12
    // rust: | side << 14
    // rust: | start << 15
    // rust: | dir << 17;
    // UVs in 1/32 of the sprite, at most two values each way.
    // rust: let mut ranges = [[u32::MAX, 0u32]; 2];
    // rust: let mut uvs = [[0u32; 2]; 4];
    // rust: for (uv, v) in uvs.iter_mut().zip(quad) {
    // rust: for k in 0..2 {
    // rust: let raw = u32::from(v.uv[k]);
    // rust: if raw & 1023 != 0 {
    // rust: return None;
}
    // rust: uv[k] = raw >> 10;
    // rust: ranges[k] = [ranges[k][0].min(uv[k]), ranges[k][1].max(uv[k])];
}
}
    // rust: let mut select = 0u32;
    // rust: for (i, uv) in uvs.iter().enumerate() {
    // rust: for k in 0..2 {
    // rust: if uv[k] == ranges[k][1] && uv[k] != ranges[k][0] {
    // rust: select |= 1 << (2 * i + k);
    // rust: } else if uv[k] != ranges[k][0] {
    // rust: return None;
}
}
}
    // rust: let rect = ranges[0][0] | ranges[0][1] << 6 | ranges[1][0] << 12 | ranges[1][1] << 18;
    // Light in steps of 4 (smooth light averages four levels of 16).
    // rust: let mut light = [0u32; 4];
    // rust: for (l, v) in light.iter_mut().zip(quad) {
    // rust: let (sky, block) = (u32::from(v.light & 0xFF), u32::from(v.light >> 8));
    // rust: if sky & 3 != 0 || block & 3 != 0 {
    // rust: return None;
}
    // rust: *l = sky >> 2 | (block >> 2) << 6;
}
    // The colour: each channel the grey level times the tint's, over 255.
    // rust: let tint = if tint == UNKNOWN_TINT {
    // rust: WHITE
    // rust: } else {
    // rust: tint & WHITE
}
    // rust: let alpha = quad[0].color & 0xFF00_0000;
    // rust: let mut grays = 0u32;
    // rust: for (i, v) in quad.iter().enumerate() {
    // rust: grays |= gray_of(v.color, tint)? << (8 * i);
}
    // rust: let words = [
    // rust: tint | alpha,
    // rust: grays,
    // rust: rect | select << 24,
    // rust: u32::from(quad[0].layer) | light[0] << 16,
    // rust: light[1] | light[2] << 12,
    // rust: light[3] | orient << 12,
    // rust: ];
    // rust: let exact = (0..4).all(|c| {
    // rust: let (a, b) = (packed_vertex(&words, c), quad[c]);
    // rust: bytemuck::bytes_of(&a) == bytemuck::bytes_of(&b)
    // rust: });
    // rust: exact.then_some(words)
}

// The tint's channels, as the mesher takes them for red, green and blue.
channels :: proc(tint: u32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [tint >> 16 & 255, tint >> 8 & 255, tint & 255]
}

// A grey level that `tint` turns into `color`'s red, green and blue.
gray_of :: proc(color: u32, tint: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let want = [color & 255, color >> 8 & 255, color >> 16 & 255];
    // rust: let t = channels(tint);
    // rust: let gives = |g: u32| (0..3).all(|k| g * t[k] / 255 == want[k]);
    // rust: let k = (0..3).max_by_key(|&k| t[k]).unwrap_or(0);
    // rust: if t[k] == 0 {
    // rust: return gives(0).then_some(0);
}
    // rust: let lo = (want[k] * 255).div_ceil(t[k]);
    // rust: let hi = ((want[k] * 255 + 254) / t[k]).min(255);
    // rust: (lo..=hi).find(|&g| gives(g))
}

// Corner `corner` of the quad `words` holds, as terrain.wgsl's `packed_corner` expands it.
packed_vertex :: proc(words: ^[u32; 6], corner: uint) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let [w0, w1, w2, w3, w4, w5] = *words;
    // rust: let orient = w5 >> 12 & 0x3_FFFF;
    // rust: let block = [orient & 15, orient >> 4 & 15, orient >> 8 & 15];
    // rust: let axis = (orient >> 12 & 3) as usize;
    // rust: let side = orient >> 14 & 1;
    // rust: let (start, dir) = (orient >> 15 & 3, orient >> 17 & 1);
    // rust: let i = corner as u32;
    // rust: let step = (start + if dir == 1 { 4 - i } else { i }) & 3;
    // rust: let [du, dw] = ROUND[step as usize];
    // rust: let mut pos = block;
    // rust: pos[axis] += side;
    // rust: pos[(axis + 1) % 3] += du;
    // rust: pos[(axis + 2) % 3] += dw;
    // rust: let select = w2 >> 24;
    // rust: let us = select >> (2 * i) & 1;
    // rust: let vs = select >> (2 * i + 1) & 1;
    // rust: let uv = [w2 >> (6 * us) & 63, w2 >> (12 + 6 * vs) & 63].map(|k| (k << 10) as u16);
    // rust: let light = [w3 >> 16, w4, w4 >> 12, w5][corner] & 0xFFF;
    // rust: let light = ((light & 63) << 2 | (light >> 6 & 63) << 10) as u16;
    // rust: let g = w1 >> (8 * i) & 255;
    // rust: let [r, gr, b] = channels(w0).map(|t| g * t / 255);
    // rust: TerrainVertex {
    // rust: pos: pos.map(|c| c as f32),
    // rust: uv,
    // rust: layer: (w3 & 0xFFFF) as u16,
    // rust: light,
    // rust: color: r | gr << 8 | b << 16 | (w0 & 0xFF00_0000),
}
}

// The compact layout of sorted solid quads with their tints (`SectionMesh::packed`), or
// nothing when it would be no smaller than their vertices.
layout :: proc(solid: ^[TerrainVertex], tints: ^[u32]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let quads = solid.as_chunks::<4>().0;
    // rust: let records: Vec<Option<[u32; 6]>> = quads
    // rust: .iter()
    // rust: .zip(tints)
    // rust: .map(|(q, &t)| pack_quad(q, t))
    // rust: .collect();
    // rust: let n = quads.len();
    // rust: let packed = records.iter().filter(|r| r.is_some()).count();
    // rust: let full = n - packed;
    // rust: let pad = if full > 0 {
    // rust: n.next_multiple_of(4) - n
    // rust: } else {
    // rust: 0
}
    // rust: if n + pad + 4 * full >= 4 * n {
    // rust: return Vec::new();
}
    // rust: let mut out = Vec::with_capacity(n + pad + 4 * full);
    // rust: let mut next = n + pad;
    // rust: for (i, record) in records.iter().enumerate() {
    // rust: out.push(record.unwrap_or_else(|| {
    // rust: let at = next;
    // rust: next += 4;
    // rust: [(at - i) as u32, 0, 0, 0, 0, FULL]
    // rust: }));
}
    // rust: out.resize(n + pad, [0; 6]);
    // rust: for (q, record) in quads.iter().zip(&records) {
    // rust: if record.is_none() {
    // rust: out.extend(
    // rust: q.iter()
    // rust: .map(|v| bytemuck::cast::<TerrainVertex, [u32; 6]>(*v)),
    // rust: );
}
}
    // rust: out
}

// Quads `layout` gave a record of their own.
packed_quads :: proc(layout: ^[[u32; 6]], quads: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: layout
    // rust: .iter()
    // rust: .take(quads)
    // rust: .filter(|w| w[5] & FULL == 0)
    // rust: .count()
}

    // rust: mod tests {
//     use super::*;

TINT :: 0x7F_B238

    // An opaque colour the mesher makes of grey level `g` times `tint`.
tinted :: proc(g: u32, tint: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let [r, gr, b] = channels(tint).map(|t| g * t / 255);
    // rust: r | gr << 8 | b << 16 | 0xFF00_0000
}

    // The top face of block (3, 15, 5), corners in `order`: tinted, smooth lit, with
    // ambient occlusion darkening its corners differently.
top :: proc(order: [uint; 4]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let pos = [
    // rust: [3.0, 16.0, 5.0],
    // rust: [3.0, 16.0, 6.0],
    // rust: [4.0, 16.0, 6.0],
    // rust: [4.0, 16.0, 5.0],
    // rust: ];
    // rust: let uv = [[0, 0], [16 << 10, 0], [16 << 10, 16 << 10], [0, 16 << 10]];
    // rust: let grays = [200, 180, 160, 200];
    // rust: order.map(|i| TerrainVertex {
    // rust: pos: pos[i],
    // rust: uv: uv[i],
    // rust: layer: 7,
    // rust: light: 0xF0 | 0x40 << 8,
    // rust: color: tinted(grays[i], TINT),
    // rust: })
}

same :: proc(a: ^TerrainVertex, b: ^TerrainVertex) -> b {
    // Ported from Horizon
    return {}
}
    // rust: bytemuck::bytes_of(a) == bytemuck::bytes_of(b)
}

a_whole_cube_face_takes_one_record_either_way_round :: proc() {
}
    // rust: for order in [[0, 1, 2, 3], [2, 3, 0, 1], [0, 3, 2, 1]] {
    // rust: let quad = top(order);
    // rust: let words = pack_quad(&quad, TINT).expect("a whole face on the block grid packs");
    // rust: for (corner, v) in quad.iter().enumerate() {
    // rust: assert!(
    // rust: same(&packed_vertex(&words, corner), v),
    // rust: "{order:?} corner {corner}"
    // rust: );
}
}
}

quads_off_the_grid_or_the_steps_keep_their_vertices :: proc() {
}
        // Half a block up: a slab's top.
    // rust: let mut slab = top([0, 1, 2, 3]);
    // rust: for v in &mut slab {
    // rust: v.pos[1] = 8.5;
}
    // rust: assert!(pack_quad(&slab, TINT).is_none());
        // A UV between the 1/32 steps.
    // rust: let mut uv = top([0, 1, 2, 3]);
    // rust: uv[2].uv[0] += 1;
    // rust: assert!(pack_quad(&uv, TINT).is_none());
        // Light between the steps of 4.
    // rust: let mut light = top([0, 1, 2, 3]);
    // rust: light[1].light += 1;
    // rust: assert!(pack_quad(&light, TINT).is_none());
}

a_quad_without_a_record_points_at_its_own_vertices :: proc() {
}
    // rust: let mut odd = top([0, 1, 2, 3]);
    // rust: for v in &mut odd {
    // rust: v.pos[1] = 8.5;
}
    // rust: let mut solid: Vec<TerrainVertex> = Vec::new();
    // rust: for _ in 0..4 {
    // rust: solid.extend(top([0, 1, 2, 3]));
}
    // rust: solid.extend(odd);
    // rust: let out = layout(&solid, &[TINT; 5]);
        // Five records, padded to eight slots, then the odd quad's four vertices.
    // rust: assert_eq!(out.len(), 12);
    // rust: assert_eq!(packed_quads(&out, 5), 4);
    // rust: assert_eq!(out[4][5], FULL);
    // rust: let at = 4 + out[4][0] as usize;
    // rust: for (slot, v) in out[at..at + 4].iter().zip(&odd) {
    // rust: assert!(same(&bytemuck::cast::<[u32; 6], TerrainVertex>(*slot), v));
}
        // Nothing smaller to gain: no layout at all.
    // rust: assert!(layout(&odd, &[TINT]).is_empty());
}
}
