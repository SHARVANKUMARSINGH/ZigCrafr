//! Transpiled from Horizon Rust crate
package horizon_client_skin_layers

import "core:fmt"
import "core:mem"
import "core:math"

// 3D skin layers (off by default): the player's outer skin layer drawn as
// its own pixels, each opaque texel extruded out of the model as a small
// slab (`threeDSkinLayers` in horizon-extras.txt, Options → Skin Customization).
//
// Vanilla draws the outer layer as one box inflated by 0.25 px, so a hat,
// jacket, sleeves and trousers read as a flat skin over the body. Here each
// texel of those boxes that the skin paints becomes a slab one texel deep:
// the face pushed out along the box's normal, its sides filled in where the
// neighbouring texel is transparent. Hair, hoods and hems then have a
// silhouette of their own, and the gaps between painted texels stay open.
//
// The geometry is built once per (skin texture, slim/wide) from the decoded
// 64×64 RGBA skin and cached by the game; the model tree, part names and the
// texture's normalised UVs are the ones the renderer already uses, so both
// the CPU and the GPU (`super::skin`) pose paths draw it unchanged.
// use super::{Part, Polygon};

// The parts of `PlayerModel` that make up the outer layer, as the prepared
// `entity-models.json` names them.
    // rust: pub const OUTER_PARTS: [&str; 6] = [
    // rust: "hat",
    // rust: "jacket",
    // rust: "left_sleeve",
    // rust: "right_sleeve",
    // rust: "left_pants",
    // rust: "right_pants",
    // rust: ];

// The size of a prepared skin image: `resample_64` always hands out this
// many texels a side, wide and legacy skins alike.
SIZE :: 64

// How far a texel is pushed out, in model units (1 = 1/16 block = one skin
// texel): the depth the 3D Skin Layers mod uses by default.
DEPTH :: 1.0

// A texel this transparent is not drawn at all (`alpha` of 0–255); the ones
// just above it stay, so a tinted glass-like layer keeps its translucency.
ALPHA_CUTOFF :: 8

// `model` with every outer-layer part replaced by its extruded geometry,
// or `None` when the model has no outer layer to extrude.
extrude :: proc(model: ^Part, skin: []u8, size: uint, depth: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if skin.len() < size * size * 4 {
    // rust: return None;
}
    // rust: let mut changed = false;
    // rust: let mut out = model.clone();
    // rust: explode(&mut out, skin, size, depth, &mut changed);
    // rust: changed.then_some(out)
}

explode :: proc(part: ^Part, skin: []u8, size: uint, depth: f32, changed: ^bool) {
}
    // rust: if OUTER_PARTS.contains(&part.name.as_str()) {
    // rust: let mut polygons = Vec::with_capacity(part.polygons.len() * 8);
    // rust: for polygon in &part.polygons {
    // rust: polygons.extend(extrude_polygon(polygon, skin, size, depth, changed));
}
    // rust: part.polygons = polygons;
}
    // rust: for child in &mut part.children {
    // rust: explode(child, skin, size, depth, changed);
}
}

// The slabs a face's texels make, or the face itself when it cannot be read
// as a texel grid (a model whose UVs are not an axis-aligned rectangle).
    // rust: fn extrude_polygon(
    // rust: polygon: &Polygon,
    // rust: skin: &[u8],
    // rust: size: usize,
    // rust: depth: f32,
    // rust: changed: &mut bool,
    // rust: ) -> Vec<Polygon> {
    // rust: let (u0, u1, v0, v1) = polygon
    // rust: .vertices
    // rust: .iter()
    // rust: .fold((f32::MAX, f32::MIN, f32::MAX, f32::MIN), |a, v| {
    // rust: (a.0.min(v[3]), a.1.max(v[3]), a.2.min(v[4]), a.3.max(v[4]))
    // rust: });
    // rust: let texels_u = ((u1 - u0) * size as f32).round() as i32;
    // rust: let texels_v = ((v1 - v0) * size as f32).round() as i32;
    // rust: if texels_u <= 0 || texels_v <= 0 || texels_u > 32 || texels_v > 32 {
    // rust: return vec![polygon.clone()];
}
    // rust: let (Some(a), Some(b), Some(c)) = (
    // rust: corner(polygon, u0, v0),
    // rust: corner(polygon, u1, v0),
    // rust: corner(polygon, u0, v1),
    // rust: ) else {
    // rust: return vec![polygon.clone()];
}
    // rust: let n = glam::Vec3::from_array(polygon.normal).normalize_or_zero();
    // rust: if n == glam::Vec3::ZERO {
    // rust: return vec![polygon.clone()];
}
    // The face's own axes, from its UV grid, so the skirt normals point away
    // from the slab no matter how the quad is wound.
    // rust: let du = (b - a).normalize_or_zero();
    // rust: let dv = (c - a).normalize_or_zero();
    // rust: let span_u = (u1 - u0).max(f32::EPSILON);
    // rust: let span_v = (v1 - v0).max(f32::EPSILON);
    // rust: let at = |u: f32, v: f32| a + (b - a) * ((u - u0) / span_u) + (c - a) * ((v - v0) / span_v);
    // rust: let base_u = (u0 * size as f32).round() as i32;
    // rust: let base_v = (v0 * size as f32).round() as i32;
    // rust: let opaque = |i: i32, j: i32| {
    // rust: if i < 0 || j < 0 || i >= texels_u || j >= texels_v {
    // rust: return false;
}
    // rust: let x = (base_u + i) as usize;
    // rust: let y = (base_v + j) as usize;
    // rust: x < size && y < size && skin[(y * size + x) * 4 + 3] > ALPHA_CUTOFF
}
    // rust: let mut out = Vec::with_capacity((texels_u * texels_v) as usize);
    // rust: let step = 1.0 / size as f32;
    // rust: for j in 0..texels_v {
    // rust: for i in 0..texels_u {
    // rust: if !opaque(i, j) {
    // rust: continue;
}
    // rust: let (ua, va) = (u0 + i as f32 * step, v0 + j as f32 * step);
    // rust: let (ub, vb) = (ua + step, va + step);
    // rust: let (p00, p10) = (at(ua, va), at(ub, va));
    // rust: let (p11, p01) = (at(ub, vb), at(ua, vb));
    // rust: let lift = n * depth;
    // rust: out.push(quad(
    // rust: [p00 + lift, p10 + lift, p11 + lift, p01 + lift],
    // rust: [(ua, va), (ub, va), (ub, vb), (ua, vb)],
    // rust: polygon.normal,
    // rust: ));
            // Sides only where the neighbour is not painted: the ones between
            // two texels would be hidden inside the layer and cost fill rate.
    // rust: let (uc, vc) = ((ua + ub) * 0.5, (va + vb) * 0.5);
    // rust: let sides = [
    // rust: ((i - 1, j), -du, [p00, p01]),
    // rust: ((i + 1, j), du, [p10, p11]),
    // rust: ((i, j - 1), -dv, [p01, p11]),
    // rust: ((i, j + 1), dv, [p00, p10]),
    // rust: ];
    // rust: for ((ni, nj), normal, [s0, s1]) in sides {
    // rust: if opaque(ni, nj) {
    // rust: continue;
}
    // rust: let normal = normal.normalize_or_zero().to_array();
    // rust: let uv = (uc, vc);
    // rust: out.push(quad(
    // rust: [s0, s1, s1 + lift, s0 + lift],
    // rust: [uv, uv, uv, uv],
    // rust: normal,
    // rust: ));
}
}
}
    // rust: if out.is_empty() {
        // A layer the skin leaves blank on this face: nothing to draw there.
    // rust: *changed = true;
    // rust: return out;
}
    // rust: *changed = true;
    // rust: out
}

quad :: proc(positions: [glam::Vec3; 4], uvs: [(f32) {
}
    // rust: Polygon {
    // rust: normal,
    // rust: vertices: std::array::from_fn(|k| {
    // rust: [
    // rust: positions[k].x,
    // rust: positions[k].y,
    // rust: positions[k].z,
    // rust: uvs[k].0,
    // rust: uvs[k].1,
    // rust: ]
    // rust: }),
    // rust: cull_back: false,
}
}

corner :: proc(polygon: ^Polygon, u: f32, v: f32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: polygon
    // rust: .vertices
    // rust: .iter()
    // rust: .find(|a| (a[3] - u).abs() < 1e-4 && (a[4] - v).abs() < 1e-4)
    // rust: .map(|a| glam::Vec3::new(a[0], a[1], a[2]))
}

    // rust: mod tests {
//     use super::*;

    // A 2×2-texel face facing +Z, its four corners at the given depth.
face :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: Polygon {
    // rust: normal: [0.0, 0.0, 1.0],
    // rust: vertices: [
    // rust: [-1.0, -1.0, 0.5, 0.0, 0.0],
    // rust: [1.0, -1.0, 0.5, 0.5, 0.0],
    // rust: [1.0, 1.0, 0.5, 0.5, 0.5],
    // rust: [-1.0, 1.0, 0.5, 0.0, 0.5],
    // rust: ],
    // rust: cull_back: false,
}
}

skin :: proc(alpha: [u8; 4]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut skin = vec![0; 64 * 64 * 4];
    // rust: for (i, a) in alpha.iter().enumerate() {
    // rust: skin[i * 4 + 3] = *a;
}
    // rust: skin
}

one_slab_and_four_sides_for_a_single_painted_texel :: proc() {
}
    // rust: let model = Part {
    // rust: name: "hat".into(),
    // rust: pose: [0.0; 9],
    // rust: polygons: vec![face()],
    // rust: children: Vec::new(),
}
    // rust: let out = extrude(&model, &skin([255, 0, 0, 0]), 64, 1.0).expect("a hat");
        // One face plus four skirts.
    // rust: assert_eq!(out.polygons.len(), 5);
    // rust: let top = out.polygons[0].vertices;
    // rust: for v in top {
    // rust: assert!(v[2] > 1.4, "the slab is pushed out: {v:?}");
}
}

a_transparent_face_draws_nothing :: proc() {
}
    // rust: let model = Part {
    // rust: name: "jacket".into(),
    // rust: pose: [0.0; 9],
    // rust: polygons: vec![face()],
    // rust: children: Vec::new(),
}
    // rust: let out = extrude(&model, &skin([0, 0, 0, 0]), 64, 1.0).expect("a jacket");
    // rust: assert!(out.polygons.is_empty());
}

a_part_that_is_not_an_outer_layer_is_untouched :: proc() {
}
    // rust: let model = Part {
    // rust: name: "head".into(),
    // rust: pose: [0.0; 9],
    // rust: polygons: vec![face()],
    // rust: children: Vec::new(),
}
    // rust: assert!(extrude(&model, &skin([255, 255, 255, 255]), 64, 1.0).is_none());
}
}
