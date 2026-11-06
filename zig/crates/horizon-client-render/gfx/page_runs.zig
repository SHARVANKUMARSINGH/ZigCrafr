//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_page_runs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Solid draws grouped by vertex arena page within distance bands.
//!
//! Sections sit in arena pages of 256 MiB, so render distance 32 spreads
//! them over half a dozen pages, and a list sorted only by distance switches
//! page every few sections: about a thousand indirect multi-draws of two or
//! three entries a frame. Mesa's Intel driver (and wgpu-core, for each
//! vertex buffer change) pays per call, and below four entries Mesa unrolls
//! the call on the CPU entry by entry. Grouping the sections of one band of
//! distance by page keeps the list front to back to within the band (what
//! the depth test needs to reject hidden fragments early) with one call per
//! page and band.
//!
//! The picture does not change: solid draws write depth and are tested
//! against it, so their order only decides which of two fragments at the
//! same depth stays, and sections do not share faces.

/// The width of a band, in blocks.
pub const BAND: f64 = 64.0;
/// Where a run's group sits in its sort key, above band and page.
pub const GROUP_SHIFT: u32 = 62;

/// One section's draws: `start..start + len` of the list.
    // rust: pub(super) struct Run {
    // rust: key: u64,
    // rust: pub start: u32,
    // rust: pub len: u32,
    /// The caller's data, carried along (occlusion culling's test inputs).
    // rust: pub tag: [u32; 3],
}

    // rust: pub(super) struct PageRuns {
    // rust: runs: Vec<Run>,
    // rust: scratch: Vec<([u32; 5], (u32, Option<u32>))>,
}

    // rust: impl PageRuns {
pub fn clear(self: *Self) void {
}
    // rust: self.runs.clear();
}

    /// The draws `start..start + len` of a section `distance` from the
    /// camera (squared, as bits) in arena `page`; runs come nearest first.
pub fn push(self: *Self, distance: u64, page: u32, start: usize, len: usize, tag: [u32; 3]) void {
}
    // rust: self.push_in(0, distance, page, start, len, tag);
}

    /// As `push`, in `group` (0 to 3): regrouping puts each group's runs
    /// before the next group's, then bands and pages within it.
    // rust: pub fn push_in(
    // rust: &mut self,
    // rust: group: u8,
    // rust: distance: u64,
    // rust: page: u32,
    // rust: start: usize,
    // rust: len: usize,
    // rust: tag: [u32; 3],
    // rust: ) {
    // rust: if len > 0 {
    // rust: let band = (f64::from_bits(distance).sqrt() / BAND) as u64;
    // rust: self.runs.push(Run {
    // rust: key: u64::from(group) << GROUP_SHIFT | band << 32 | u64::from(page),
    // rust: start: start as u32,
    // rust: len: len as u32,
    // rust: tag,
    // rust: });
}
}

    /// Reorders `draws[base..]` and their `pages`, which the pushed runs
    /// cover in order, so that each band's runs in one page are adjacent
    /// (in distance order); returns the runs at their new places.
    // rust: pub fn regroup(
    // rust: &mut self,
    // rust: draws: &mut [[u32; 5]],
    // rust: pages: &mut [(u32, Option<u32>)],
    // rust: base: usize,
    // rust: ) -> &[Run] {
        // Group and page: one of each needs no reordering.
    // rust: let page = |r: &Run| r.key & (3 << GROUP_SHIFT | u64::from(u32::MAX));
    // rust: if self.runs.windows(2).all(|w| page(&w[0]) == page(&w[1])) {
    // rust: return &self.runs;
}
        // Stable: within a band and page the runs stay nearest first.
    // rust: self.runs.sort_by_key(|r| r.key);
    // rust: self.scratch.clear();
    // rust: for r in &mut self.runs {
    // rust: let (s, e) = (r.start as usize, (r.start + r.len) as usize);
    // rust: r.start = (base + self.scratch.len()) as u32;
    // rust: self.scratch
    // rust: .extend(draws[s..e].iter().copied().zip(pages[s..e].iter().copied()));
}
    // rust: for (i, &(draw, p)) in self.scratch.iter().enumerate() {
    // rust: draws[base + i] = draw;
    // rust: pages[base + i] = p;
}
    // rust: &self.runs
}
}

    // rust: mod tests {
//     use super::*;

pub fn bits(blocks: f64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (blocks * blocks).to_bits()
}

    /// Runs of (distance in blocks, page, draws), as the list builder pushes them.
pub fn list(runs: *[(f64) void {
}
    // rust: let mut grouped = PageRuns::default();
    // rust: let (mut draws, mut pages) = (Vec::new(), Vec::new());
    // rust: for (n, &(distance, page, count)) in runs.iter().enumerate() {
    // rust: let start = draws.len();
    // rust: for k in 0..count {
    // rust: draws.push([n as u32, k, 0, 0, 0]);
    // rust: pages.push((page, None));
}
    // rust: grouped.push(
    // rust: bits(distance),
    // rust: page,
    // rust: start,
    // rust: count as usize,
    // rust: [n as u32, 0, 0],
    // rust: );
}
    // rust: (grouped, draws, pages)
}

pub fn a_band_draws_each_page_once_keeping_the_order_inside_it() void {
}
    // rust: let (mut grouped, mut draws, mut pages) = list(&[
    // rust: (10.0, 1, 2),
    // rust: (20.0, 0, 1),
    // rust: (30.0, 1, 3),
    // rust: (40.0, 0, 2),
    // rust: (70.0, 1, 1),
    // rust: ]);
    // rust: let runs: Vec<_> = grouped
    // rust: .regroup(&mut draws, &mut pages, 0)
    // rust: .iter()
    // rust: .map(|r| (r.tag[0], r.start, r.len))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: runs,
    // rust: [(1, 0, 1), (3, 1, 2), (0, 3, 2), (2, 5, 3), (4, 8, 1)]
    // rust: );
    // rust: let order: Vec<_> = draws.iter().map(|d| (d[0], d[1])).collect();
    // rust: assert_eq!(
    // rust: order,
    // rust: [
    // rust: (1, 0),
    // rust: (3, 0),
    // rust: (3, 1),
    // rust: (0, 0),
    // rust: (0, 1),
    // rust: (2, 0),
    // rust: (2, 1),
    // rust: (2, 2),
    // rust: (4, 0)
    // rust: ]
    // rust: );
    // rust: let pages: Vec<_> = pages.iter().map(|p| p.0).collect();
    // rust: assert_eq!(pages, [0, 0, 0, 1, 1, 1, 1, 1, 1]);
}

pub fn bands_stay_in_distance_order() void {
}
    // rust: let (mut grouped, mut draws, mut pages) =
    // rust: list(&[(10.0, 1, 1), (100.0, 0, 1), (200.0, 0, 1)]);
    // rust: grouped.regroup(&mut draws, &mut pages, 0);
    // rust: let order: Vec<_> = draws.iter().map(|d| d[0]).collect();
    // rust: assert_eq!(order, [0, 1, 2]);
}

    /// Metal's two solid passes draw a prefix and a suffix of the list:
    /// groups come whole and in order, whatever their distance and page.
pub fn groups_come_before_bands_and_pages() void {
}
    // rust: let mut grouped = PageRuns::default();
    // rust: let mut draws: Vec<_> = (0..5).map(|n| [n, 0, 0, 0, 0]).collect();
    // rust: let mut pages = vec![(0, None); 5];
    // rust: for (n, (group, distance)) in [(2, 10.0), (0, 300.0), (1, 20.0), (0, 30.0), (2, 5.0)]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: grouped.push_in(group, bits(distance), 0, n, 1, [0; 3]);
}
    // rust: grouped.regroup(&mut draws, &mut pages, 0);
    // rust: let order: Vec<_> = draws.iter().map(|d| d[0]).collect();
    // rust: assert_eq!(order, [3, 1, 2, 0, 4]);
}

pub fn one_page_and_an_offset_list() void {
}
    // rust: let (mut grouped, mut draws, mut pages) = list(&[(10.0, 3, 2), (90.0, 3, 1)]);
    // rust: let before = draws.clone();
    // rust: assert_eq!(grouped.regroup(&mut draws, &mut pages, 0)[1].start, 2);
    // rust: assert_eq!(draws, before);
        // A list after other draws: starts are absolute.
    // rust: let mut grouped = PageRuns::default();
    // rust: let mut draws = vec![[9; 5], [7, 0, 0, 0, 0], [8, 0, 0, 0, 0]];
    // rust: let mut pages = vec![(5, None), (1, None), (0, None)];
    // rust: grouped.push(bits(5.0), 1, 1, 1, [0; 3]);
    // rust: grouped.push(bits(6.0), 0, 2, 1, [1, 0, 0]);
    // rust: let runs = grouped.regroup(&mut draws, &mut pages, 1).to_vec();
    // rust: assert_eq!(draws, [[9; 5], [8, 0, 0, 0, 0], [7, 0, 0, 0, 0]]);
    // rust: assert_eq!(pages, [(5, None), (0, None), (1, None)]);
    // rust: assert_eq!((runs[0].tag[0], runs[0].start), (1, 1));
        // Empty runs are left out.
    // rust: grouped.clear();
    // rust: grouped.push(bits(1.0), 0, 0, 0, [0; 3]);
    // rust: assert!(grouped.regroup(&mut [], &mut [], 0).is_empty());
}
}
