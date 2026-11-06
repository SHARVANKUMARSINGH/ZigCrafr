//! Transpiled from Horizon Rust crate
package horizon_client_voxel_occlusion

import "core:fmt"
import "core:mem"
import "core:math"

// Conservative, budgeted occlusion against full opaque block cross-sections.
//
// A covered projection rectangle proves that an entire bounding box is hidden.
// Testing a few rays would miss openings between those rays.
// use horizon_core::geometry::Aabb;
// use std::cell::Cell;

EPSILON :: 1.0e-5

Culler :: struct {
    camera: [f64,
    remaining: Cell<uint>,
}

    // rust: impl Culler {
new :: proc(camera: [f64; 3], budget: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: camera,
    // rust: remaining: Cell::new(budget),
}
}

    // Remaining block lookups in this frame's shared culling budget.
remaining :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.remaining.get()
}

    // Remove only this entity's completed camera-relative mesh when hidden.
    // rust: pub fn cull_vertices(
    // rust: &self,
    // rust: vertices: &mut Vec<crate::mesher::Vertex>,
    // rust: start: usize,
    // rust: opaque: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> bool {
    // rust: let hidden = self.hidden(vertices, start, opaque);
    // rust: if hidden {
    // rust: vertices.truncate(start);
}
    // rust: hidden
}

    // Whether this entity's completed camera-relative mesh (`vertices[start..]`) is hidden.
    // rust: pub fn hidden(
    // rust: &self,
    // rust: vertices: &[crate::mesher::Vertex],
    // rust: start: usize,
    // rust: opaque: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> bool {
    // rust: if self.remaining.get() == 0 {
    // rust: return false;
}
    // rust: let Some((min, max)) = Self::bounds(self.camera, vertices, start) else {
    // rust: return false;
}
    // rust: self.occluded(min, max, opaque)
}

    // Whether a declared world-space entity AABB is hidden. Entity model
    // bounds receive the same small edge margin as mesh-derived bounds.
hidden_bounds :: proc(self: ^Self, bounds: Aabb, opaque: impl FnMut([i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.remaining.get() == 0 {
    // rust: return false;
}
    // rust: let Some((min, max)) = Self::aabb_bounds(bounds) else {
    // rust: return false;
}
    // rust: self.occluded(min, max, opaque)
}

    // Whether camera-relative model bounds are hidden. This avoids building
    // synthetic vertices when a renderer already has a conservative AABB.
    // rust: pub fn hidden_camera_bounds(
    // rust: &self,
    // rust: lo: [f32; 3],
    // rust: hi: [f32; 3],
    // rust: opaque: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> bool {
    // rust: if self.remaining.get() == 0
    // rust: || self.camera.into_iter().any(|value| !value.is_finite())
    // rust: || lo.into_iter().chain(hi).any(|value| !value.is_finite())
    // rust: {
    // rust: return false;
}
    // rust: let min = std::array::from_fn(|axis| {
    // rust: f64::from(lo[axis].min(hi[axis])) + self.camera[axis] - 0.05
    // rust: });
    // rust: let max = std::array::from_fn(|axis| {
    // rust: f64::from(lo[axis].max(hi[axis])) + self.camera[axis] + 0.05
    // rust: });
    // rust: self.occluded(min, max, opaque)
}

    // World-space bounds expanded for floating-point and rasterization edges.
aabb_bounds :: proc(bounds: Aabb) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let lo = bounds.min_position();
    // rust: let hi = bounds.max_position();
    // rust: let min = [lo.x, lo.y, lo.z];
    // rust: let max = [hi.x, hi.y, hi.z];
    // rust: if (0..3)
    // rust: .any(|axis| !min[axis].is_finite() || !max[axis].is_finite() || min[axis] > max[axis])
    // rust: {
    // rust: return None;
}
    // rust: Some((min.map(|value| value - 0.05), max.map(|value| value + 0.05)))
}

    // World-space bounds from camera-relative vertices, grown for floating-point
    // and rasterization edges. The asynchronous path sends these to its worker.
    // rust: pub fn bounds(
    // rust: camera: [f64; 3],
    // rust: vertices: &[crate::mesher::Vertex],
    // rust: start: usize,
    // rust: ) -> Option<([f64; 3], [f64; 3])> {
    // rust: if start >= vertices.len() || camera.into_iter().any(|value| !value.is_finite()) {
    // rust: return None;
}
    // rust: let mut min = [f64::INFINITY; 3];
    // rust: let mut max = [f64::NEG_INFINITY; 3];
    // rust: for vertex in &vertices[start..] {
    // rust: let [x, y, z] = vertex.pos;
    // rust: if !x.is_finite() || !y.is_finite() || !z.is_finite() {
    // rust: return None;
}
    // rust: let [x, y, z] = [f64::from(x), f64::from(y), f64::from(z)];
    // rust: min[0] = min[0].min(x);
    // rust: max[0] = max[0].max(x);
    // rust: min[1] = min[1].min(y);
    // rust: max[1] = max[1].max(y);
    // rust: min[2] = min[2].min(z);
    // rust: max[2] = max[2].max(z);
}
        // Camera translation is monotonic, so offsetting the extrema is exact
        // and avoids three f64 additions for every scanned vertex.
    // rust: let min = std::array::from_fn(|axis| min[axis] + camera[axis]);
    // rust: let max = std::array::from_fn(|axis| max[axis] + camera[axis]);
        // Cover floating-point and rasterization edges as well as the vertices.
    // rust: let min = min.map(|value| value - 0.05);
    // rust: let max = max.map(|value| value + 0.05);
    // rust: Some((min, max))
}

    // Returns true only when a complete opaque block plane covers the bounds.
    // Unknown blocks, invalid bounds and an exhausted lookup budget stay visible.
    // rust: pub fn occluded(
    // rust: &self,
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: mut opaque: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> bool {
    // rust: let mut remaining = self.remaining.get();
    // rust: let hidden = Self::occluded_with_budget(self.camera, &mut remaining, min, max, &mut opaque);
    // rust: self.remaining.set(remaining);
    // rust: hidden
}

    // The worker-facing form of [`Self::occluded`]. Keeping the budget in a
    // local integer avoids `Cell` loads and stores for every projected plane
    // while preserving the same conservative lookup accounting.
    // rust: pub fn occluded_with_budget(
    // rust: camera: [f64; 3],
    // rust: remaining: &mut usize,
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: mut opaque: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> bool {
    // rust: if (0..3).any(|a| {
    // rust: !camera[a].is_finite() || !min[a].is_finite() || !max[a].is_finite() || min[a] > max[a]
    // rust: }) {
    // rust: return false;
}
    // rust: let mut best = (0, 0.0, 0.0);
    // rust: for a in 0..3 {
    // rust: let (gap, sign) = if camera[a] < min[a] {
    // rust: (min[a] - camera[a], 1.0)
    // rust: } else {
    // rust: (camera[a] - max[a], -1.0)
}
    // rust: if gap > best.1 {
    // rust: best = (a, gap, sign);
}
}
    // rust: let (axis, gap, sign) = best;
    // rust: if !gap.is_finite() || gap <= EPSILON {
    // rust: return false;
}
    // rust: let across = [(axis + 1) % 3, (axis + 2) % 3];
    // rust: let Some(mut cell) = floor_cell(camera[axis]) else {
    // rust: return false;
}
    // rust: let step = if sign > 0.0 { 1 } else { -1 };
    // rust: if (f64::from(cell) + 0.5 - camera[axis]) * sign <= EPSILON {
    // rust: let Some(next) = cell.checked_add(step) else {
    // rust: return false;
}
    // rust: cell = next;
}
        // These two reciprocals are invariant for every plane along the ray.
    // rust: let denominator_min = (min[axis] - camera[axis]) * sign;
    // rust: let denominator_max = (max[axis] - camera[axis]) * sign;
    // rust: if !denominator_min.is_finite()
    // rust: || !denominator_max.is_finite()
    // rust: || denominator_min.abs() <= EPSILON
    // rust: || denominator_max.abs() <= EPSILON
    // rust: {
    // rust: return false;
}
    // rust: let reciprocal_min = 1.0 / denominator_min;
    // rust: let reciprocal_max = 1.0 / denominator_max;
    // rust: let transverse_min = [
    // rust: min[across[0]] - camera[across[0]],
    // rust: min[across[1]] - camera[across[1]],
    // rust: ];
    // rust: let transverse_max = [
    // rust: max[across[0]] - camera[across[0]],
    // rust: max[across[1]] - camera[across[1]],
    // rust: ];
    // rust: loop {
    // rust: let depth = (f64::from(cell) + 0.5 - camera[axis]) * sign;
    // rust: if depth >= gap - EPSILON || *remaining == 0 {
    // rust: return false;
}
    // rust: let t_min = depth * reciprocal_min;
    // rust: let t_max = depth * reciprocal_max;
    // rust: let mut lo = [f64::INFINITY; 2];
    // rust: let mut hi = [f64::NEG_INFINITY; 2];
    // rust: for i in 0..2 {
    // rust: let camera_axis = camera[across[i]];
    // rust: for t in [t_min, t_max] {
    // rust: let p_min = camera_axis + t * transverse_min[i];
    // rust: let p_max = camera_axis + t * transverse_max[i];
    // rust: if !p_min.is_finite() || !p_max.is_finite() {
    // rust: return false;
}
    // rust: lo[i] = lo[i].min(p_min);
    // rust: hi[i] = hi[i].max(p_max);
}
}
    // rust: let bounds = [
    // rust: floor_cell(lo[0] - EPSILON),
    // rust: floor_cell(hi[0] + EPSILON),
    // rust: floor_cell(lo[1] - EPSILON),
    // rust: floor_cell(hi[1] + EPSILON),
    // rust: ];
    // rust: let [Some(x0), Some(x1), Some(y0), Some(y1)] = bounds else {
    // rust: return false;
}
    // rust: let center_x = x0 + ((i64::from(x1) - i64::from(x0)) / 2) as i32;
    // rust: let center_y = y0 + ((i64::from(y1) - i64::from(y0)) / 2) as i32;
    // rust: let mut pos = [0; 3];
    // rust: pos[axis] = cell;
    // rust: pos[across[0]] = center_x;
    // rust: pos[across[1]] = center_y;
    // rust: *remaining -= 1;
    // rust: if opaque(pos) {
    // rust: let area = (i64::from(x1) - i64::from(x0) + 1)
    // rust: .checked_mul(i64::from(y1) - i64::from(y0) + 1)
    // rust: .and_then(|n| usize::try_from(n).ok());
    // rust: let Some(additional) = area.and_then(|n| n.checked_sub(1)) else {
    // rust: return false;
}
    // rust: if additional > *remaining {
    // rust: return false;
}
                // Keep Y in the inner loop for X-facing planes. This keeps
                // consecutive probes in one chunk column. Charge only probes
                // actually visited when a gap short-circuits the rectangle.
    // rust: let covered = if across[0] == 1 {
    // rust: (y0..=y1).all(|y| {
    // rust: pos[across[1]] = y;
    // rust: (x0..=x1).all(|x| {
    // rust: if x == center_x && y == center_y {
    // rust: return true;
}
    // rust: *remaining -= 1;
    // rust: pos[across[0]] = x;
    // rust: opaque(pos)
    // rust: })
    // rust: })
    // rust: } else {
    // rust: (x0..=x1).all(|x| {
    // rust: pos[across[0]] = x;
    // rust: (y0..=y1).all(|y| {
    // rust: if x == center_x && y == center_y {
    // rust: return true;
}
    // rust: *remaining -= 1;
    // rust: pos[across[1]] = y;
    // rust: opaque(pos)
    // rust: })
    // rust: })
}
    // rust: if covered {
    // rust: return true;
}
}
    // rust: let Some(next) = cell.checked_add(step) else {
    // rust: return false;
}
    // rust: cell = next;
}
}
}

floor_cell :: proc(value: f64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let n = value.floor();
    // rust: (n.is_finite() && n >= f64::from(i32::MIN) && n <= f64::from(i32::MAX)).then_some(n as i32)
}

    // rust: mod tests;
