//! Transpiled from Horizon Rust crate
//! Module: horizon-client_seen_grid
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The tick's mob snapshot indexed by where the boxes are, so a box query
//! (`LivingEntity.pushEntities`) reads the mobs near it instead of every
//! mob, and still meets them in snapshot order.
// use crate::fast_hash::FxHashMap;
// use horizon_core::geometry::{Aabb, Axis};

/// Width of a grid column, in blocks.
pub const CELL: f64 = 4.0;

/// Snapshot indices by the column holding each box's minimum corner.
pub const SeenGrid = struct {
    cells: FxHashMap<(i32,
    cell_of: Vec<(i32,
    /// The widest box (along x or z) the grid has held: no box reaches
    /// further than this past its minimum corner.
    reach: f64,
};

pub fn column(x: f64, z: f64) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((x / CELL).floor() as i32, (z / CELL).floor() as i32)
}
pub fn corner(b: Aabb) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: column(b.min(Axis::X), b.min(Axis::Z))
}
pub fn width(b: Aabb) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (b.max(Axis::X) - b.min(Axis::X)).max(b.max(Axis::Z) - b.min(Axis::Z))
}

    // rust: impl SeenGrid {
    /// The boxes of the snapshot's entries, in order.
pub fn new(boxes: impl Iterator<Item = Aabb>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut grid = Self::default();
    // rust: for (i, b) in boxes.enumerate() {
    // rust: let at = corner(b);
    // rust: grid.reach = grid.reach.max(width(b));
    // rust: grid.cells.entry(at).or_default().push(i as u32);
    // rust: grid.cell_of.push(at);
}
    // rust: grid
}
    /// Entry `i`'s box is now `b` (the mob moved or resized).
pub fn update(self: *Self, i: usize, b: Aabb) void {
}
    // rust: self.reach = self.reach.max(width(b));
    // rust: let at = corner(b);
    // rust: let old = std::mem::replace(&mut self.cell_of[i], at);
    // rust: if old == at {
    // rust: return;
}
    // rust: if let Some(list) = self.cells.get_mut(&old)
    // rust: && let Some(k) = list.iter().position(|&j| j == i as u32)
    // rust: {
    // rust: list.swap_remove(k);
}
    // rust: self.cells.entry(at).or_default().push(i as u32);
}
    /// The indices, ascending, of every entry whose box can meet `area`
    /// (a superset: callers still test it). False when the area spans more
    /// columns than the grid holds (or is not finite): scan them all.
pub fn candidates(self: *Self, area: Aabb, out: *mut std.ArrayList(u32)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: out.clear();
        // A box meets `area` only if its minimum corner is below area.max
        // and within `reach` (plus a margin for rounding) of area.min.
    // rust: let margin = self.reach + 1.0;
    // rust: let lo = column(area.min(Axis::X) - margin, area.min(Axis::Z) - margin);
    // rust: let hi = column(area.max(Axis::X), area.max(Axis::Z));
    // rust: let span = |a: i32, b: i32| i64::from(b) - i64::from(a) + 1;
    // rust: let (nx, nz) = (span(lo.0, hi.0), span(lo.1, hi.1));
    // rust: if nx < 1 || nz < 1 || nx.saturating_mul(nz) > self.cells.len() as i64 {
    // rust: return false;
}
    // rust: for x in lo.0..=hi.0 {
    // rust: for z in lo.1..=hi.1 {
    // rust: if let Some(list) = self.cells.get(&(x, z)) {
    // rust: out.extend_from_slice(list);
}
}
}
    // rust: out.sort_unstable();
    // rust: true
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::geometry::Vec3;

pub fn boxed(x: f64, y: f64, z: f64, w: f64) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Aabb::new(Vec3::new(x, y, z), Vec3::new(x + w, y + 1.8, z + w))
}

pub fn candidates_hold_every_meeting_box_in_order() void {
}
        // A small LCG keeps the test free of dependencies.
    // rust: let mut seed = 0x2545_f491_4f6c_dd1du64;
    // rust: let mut next = |range: f64| {
    // rust: seed = seed.wrapping_mul(6_364_136_223_846_793_005).wrapping_add(1);
    // rust: (seed >> 11) as f64 / (1u64 << 53) as f64 * range
}
    // rust: let mut boxes: Vec<Aabb> = (0..300)
    // rust: .map(|_| {
    // rust: boxed(
    // rust: next(64.0) - 32.0,
    // rust: next(8.0),
    // rust: next(64.0) - 32.0,
    // rust: 0.3 + next(1.2),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let mut grid = SeenGrid::new(boxes.iter().copied());
    // rust: let mut out = Vec::new();
    // rust: let mut indexed = 0;
    // rust: for round in 0..2000 {
            // Move one box, sometimes far and wider, as mobs do between queries.
    // rust: let i = round % boxes.len();
    // rust: let w = if round % 97 == 0 { 3.9 } else { 0.6 };
    // rust: boxes[i] = boxed(next(80.0) - 40.0, next(8.0), next(80.0) - 40.0, w);
    // rust: grid.update(i, boxes[i]);
    // rust: let area = boxed(next(70.0) - 35.0, next(8.0), next(70.0) - 35.0, next(2.0));
    // rust: let expected: Vec<u32> = (0..boxes.len() as u32)
    // rust: .filter(|&j| boxes[j as usize].intersects(area))
    // rust: .collect();
    // rust: if grid.candidates(area, &mut out) {
    // rust: indexed += 1;
    // rust: assert!(out.windows(2).all(|p| p[0] < p[1]), "ascending, no repeats");
    // rust: let met: Vec<u32> = out
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&j| boxes[j as usize].intersects(area))
    // rust: .collect();
    // rust: assert_eq!(met, expected);
}
}
    // rust: assert!(indexed > 1900, "the grid answered {indexed} of 2000");
}

pub fn unbounded_areas_fall_back_to_a_full_scan() void {
}
    // rust: let grid = SeenGrid::new([boxed(0.0, 0.0, 0.0, 0.6)].into_iter());
    // rust: let mut out = Vec::new();
    // rust: let huge = Aabb::new(
    // rust: Vec3::new(f64::NEG_INFINITY, 0.0, 0.0),
    // rust: Vec3::new(f64::INFINITY, 1.0, 1.0),
    // rust: );
    // rust: assert!(!grid.candidates(huge, &mut out));
}
}
