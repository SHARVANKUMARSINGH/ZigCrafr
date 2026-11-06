//! Transpiled from Horizon Rust crate
package horizon_client_depth

import "core:fmt"
import "core:mem"
import "core:math"

// Back-to-front ordering for the orthographic GUI item view (near is +Z).
// Whole-face average depths fail when a long, tilted face overlaps a short
// one, such as a banner's cloth and support. Partition faces by their planes
// instead, splitting intersecting faces with their UVs. Coplanar faces keep
// submission order so banner/shield pattern layers still paint bottom first.
// use super::super::ItemQuad;
// use glam::{Vec3, Vec4};

    // rust: pub(super) struct Corner {
    // rust: pub pos: Vec3,
    // rust: pub uv: [f32; 2],
    // rust: pub glint_uv: [f32; 2],
    // rust: pub cit_uv: [f32; 2],
}

    // rust: pub(super) struct Face {
    // rust: pub quad: usize,
    // rust: pub corners: Vec<Corner>,
}

EPSILON :: 1e-4

split :: proc(face: Face, distances: ^[f32]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut back = Vec::new();
    // rust: let mut front = Vec::new();
    // rust: for i in 0..face.corners.len() {
    // rust: let a = face.corners[i];
    // rust: let b = face.corners[(i + 1) % face.corners.len()];
    // rust: let da = distances[i];
    // rust: let db = distances[(i + 1) % face.corners.len()];
    // rust: if da <= EPSILON {
    // rust: back.push(a);
}
    // rust: if da >= -EPSILON {
    // rust: front.push(a);
}
    // rust: if (da < -EPSILON && db > EPSILON) || (da > EPSILON && db < -EPSILON) {
    // rust: let t = da / (da - db);
    // rust: let corner = Corner {
    // rust: pos: a.pos.lerp(b.pos, t),
    // rust: uv: std::array::from_fn(|k| a.uv[k] + (b.uv[k] - a.uv[k]) * t),
    // rust: cit_uv: std::array::from_fn(|k| a.cit_uv[k] + (b.cit_uv[k] - a.cit_uv[k]) * t),
    // rust: glint_uv: std::array::from_fn(|k| {
    // rust: a.glint_uv[k] + (b.glint_uv[k] - a.glint_uv[k]) * t
    // rust: }),
}
    // rust: back.push(corner);
    // rust: front.push(corner);
}
}
    // rust: (
    // rust: Face {
    // rust: quad: face.quad,
    // rust: corners: back,
    // rust: },
    // rust: Face {
    // rust: quad: face.quad,
    // rust: corners: front,
    // rust: },
    // rust: )
}

    // rust: pub(super) fn sort(quads: &[ItemQuad]) -> Vec<Face> {
    // rust: let mut planes = vec![Vec4::ZERO; quads.len()];
    // rust: let faces: Vec<_> = quads
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, q)| {
    // rust: let normal = (q.pos[2] - q.pos[0]).cross(q.pos[3] - q.pos[1]);
            // Front faces wind counter-clockwise on screen with Y up.
    // rust: if normal.z >= 0.0 {
    // rust: return None;
}
    // rust: let normal = -normal.normalize();
    // rust: planes[i] = normal.extend(-normal.dot(q.pos[0]));
    // rust: Some(Face {
    // rust: quad: i,
    // rust: corners: std::array::from_fn::<_, 4, _>(|k| Corner {
    // rust: pos: q.pos[k],
    // rust: uv: q.uv[k],
    // rust: glint_uv: q.gui_glint_uv.unwrap_or(q.foil_uv)[k],
    // rust: cit_uv: q.foil_uv[k],
    // rust: })
    // rust: .to_vec(),
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let mut out = Vec::new();
    // An explicit stack avoids recursion for models with many parallel faces.
    // rust: let mut pending = vec![(faces, false)];
    // rust: while let Some((faces, emit)) = pending.pop() {
    // rust: if emit {
    // rust: out.extend(faces);
    // rust: continue;
}
    // rust: let mut faces = faces.into_iter();
    // rust: let Some(first) = faces.next() else { continue };
    // rust: let plane = planes[first.quad];
    // rust: let mut coplanar = vec![first];
    // rust: let mut back = Vec::new();
    // rust: let mut front = Vec::new();
    // rust: for face in faces {
    // rust: let distances: Vec<_> = face
    // rust: .corners
    // rust: .iter()
    // rust: .map(|c| plane.dot(c.pos.extend(1.0)))
    // rust: .collect();
    // rust: let behind = distances.iter().any(|d| *d < -EPSILON);
    // rust: let ahead = distances.iter().any(|d| *d > EPSILON);
    // rust: match (behind, ahead) {
    // rust: (false, false) => coplanar.push(face),
    // rust: (true, false) => back.push(face),
    // rust: (false, true) => front.push(face),
    // rust: (true, true) => {
    // rust: let (b, f) = split(face, &distances);
    // rust: back.push(b);
    // rust: front.push(f);
}
}
}
    // rust: pending.push((front, false));
    // rust: pending.push((coplanar, true));
    // rust: pending.push((back, false));
}
    // rust: out
}
