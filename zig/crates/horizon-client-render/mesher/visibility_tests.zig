//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_visibility_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Exact pre-optimization reference, correctness fixtures, and opt-in benchmark.
// use super::*;

pub fn reference(pad: *Padded, info: *[Info]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut seen = vec![false; 4096];
    // rust: let mut result = 0u64;
    // rust: let opaque = |x: i32, y: i32, z: i32| info[pad.blocks[pi(x, y, z)] as usize].solid;
    // rust: let mut stack = Vec::new();
    // rust: for start in 0..4096usize {
    // rust: let (x, y, z) = (
    // rust: (start & 15) as i32,
    // rust: (start >> 8) as i32,
    // rust: ((start >> 4) & 15) as i32,
    // rust: );
    // rust: if seen[start] || opaque(x, y, z) {
    // rust: continue;
}
    // rust: let mut faces = 0u8;
    // rust: seen[start] = true;
    // rust: stack.push(start);
    // rust: while let Some(c) = stack.pop() {
    // rust: let (x, y, z) = ((c & 15) as i32, (c >> 8) as i32, ((c >> 4) & 15) as i32);
    // rust: if y == 0 {
    // rust: faces |= 1 << 0;
}
    // rust: if y == 15 {
    // rust: faces |= 1 << 1;
}
    // rust: if z == 0 {
    // rust: faces |= 1 << 2;
}
    // rust: if z == 15 {
    // rust: faces |= 1 << 3;
}
    // rust: if x == 0 {
    // rust: faces |= 1 << 4;
}
    // rust: if x == 15 {
    // rust: faces |= 1 << 5;
}
    // rust: for (dx, dy, dz) in [
    // rust: (1, 0, 0),
    // rust: (-1, 0, 0),
    // rust: (0, 1, 0),
    // rust: (0, -1, 0),
    // rust: (0, 0, 1),
    // rust: (0, 0, -1),
    // rust: ] {
    // rust: let (nx, ny, nz) = (x + dx, y + dy, z + dz);
    // rust: if !(0..16).contains(&nx) || !(0..16).contains(&ny) || !(0..16).contains(&nz) {
    // rust: continue;
}
    // rust: let n = (ny << 8 | nz << 4 | nx) as usize;
    // rust: if !seen[n] && !opaque(nx, ny, nz) {
    // rust: seen[n] = true;
    // rust: stack.push(n);
}
}
}
    // rust: for a in 0..6 {
    // rust: if faces & (1 << a) != 0 {
    // rust: for b in 0..6 {
    // rust: if faces & (1 << b) != 0 {
    // rust: result |= 1 << (a * 6 + b);
}
}
}
}
}
    // rust: result
}

pub fn info(solid: bool) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Info {
    // rust: solid,
    // rust: full: false,
    // rust: permeable: false,
    // rust: shade: 1.0,
    // rust: emission: 0,
    // rust: tier: 0,
    // rust: emissive: false,
    // rust: fluid: FluidState::EMPTY,
    // rust: model: false,
    // rust: block_entity: false,
    // rust: tints: [Tint::None; 2],
    // rust: tint_count: 0,
    // rust: offset: None,
    // rust: legacy_solid: false,
    // rust: overlay: false,
    // rust: leaves: false,
    // rust: pane: false,
    // rust: opaque_cube: solid,
    // rust: blocks_flow: false,
    // rust: ice: false,
    // rust: sturdy: 0,
    // rust: face: [0; 6],
    // rust: cover: [0.0; 6],
}
}

pub fn fixture(mut opaque: impl FnMut(i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // Multiple opaque and non-opaque state IDs, plus an opaque padding border.
    // rust: let mut pad = Padded {
    // rust: blocks: vec![1; P * P * P],
    // rust: light: Vec::new(),
}
    // rust: for y in 0..16 {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: pad.blocks[pi(x, y, z)] = u32::from(opaque(x, y, z)) + 2 * ((x + y + z) as u32 & 1);
}
}
}
    // rust: pad
}

pub fn random(seed: *mut u64) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *seed ^= *seed << 13;
    // rust: *seed ^= *seed >> 7;
    // rust: *seed ^= *seed << 17;
    // rust: *seed
}

pub fn cases() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut cases = vec![
    // rust: ("open", fixture(|_, _, _| false)),
    // rust: ("closed", fixture(|_, _, _| true)),
    // rust: ("terrain_half", fixture(|_, y, _| y < 8)),
    // rust: ("dividing_wall", fixture(|x, _, _| x == 8)),
    // rust: (
    // rust: "sealed_cavity",
    // rust: fixture(|x, y, z| [x, y, z].iter().any(|&v| v == 0 || v == 15)),
    // rust: ),
    // rust: (
    // rust: "disconnected_all_pairs",
    // rust: fixture(|x, y, z| {
    // rust: !((x == 8 && z == 8)
    // rust: || ((y == 0 || y == 15) && !((7..=9).contains(&x) && (7..=9).contains(&z))))
    // rust: }),
    // rust: ),
    // rust: ("checkerboard", fixture(|x, y, z| (x + y + z) % 2 == 0)),
    // rust: (
    // rust: "six_face_tunnel",
    // rust: fixture(|x, y, z| [x, y, z].iter().filter(|&&v| v == 8).count() < 2),
    // rust: ),
    // rust: (
    // rust: "open_with_cavity",
    // rust: fixture(|x, y, z| {
    // rust: [x, y, z].iter().all(|&v| (4..=11).contains(&v))
    // rust: && [x, y, z].iter().any(|&v| v == 4 || v == 11)
    // rust: }),
    // rust: ),
    // rust: ];
    // rust: for (name, percent) in [
    // rust: ("opaque_1pct", 1),
    // rust: ("opaque_25pct", 25),
    // rust: ("opaque_50pct", 50),
    // rust: ("opaque_75pct", 75),
    // rust: ("opaque_99pct", 99),
    // rust: ] {
    // rust: let mut seed = 0x1234_5678_9abc_def0;
    // rust: cases.push((name, fixture(|_, _, _| random(&mut seed) % 100 < percent)));
}
    // rust: cases
}

pub fn visibility_matches_reference() void {
}
    // rust: let info = [info(false), info(true), info(false), info(true)];
    // rust: for (name, pad) in cases() {
    // rust: assert_eq!(visibility(&pad, &info), reference(&pad, &info), "{name}");
}
    // All 256 open/closed octant combinations, including disconnected regions.
    // rust: for mask in 0..256u16 {
    // rust: let pad = fixture(|x, y, z| mask & (1 << ((x / 8) + 2 * (z / 8) + 4 * (y / 8))) != 0);
    // rust: assert_eq!(
    // rust: visibility(&pad, &info),
    // rust: reference(&pad, &info),
    // rust: "octants {mask}"
    // rust: );
}
    // Randomized distributions include percolating regions and isolated cells.
    // rust: let mut seed = 0x8765_4321_abcd_ef01;
    // rust: for percent in [1, 10, 25, 50, 75, 90, 99] {
    // rust: for _ in 0..32 {
    // rust: let pad = fixture(|_, _, _| random(&mut seed) % 100 < percent);
    // rust: assert_eq!(visibility(&pad, &info), reference(&pad, &info));
}
}
}

pub fn row_fill_matches_a_cell_by_cell_fill() void {
}
    // rust: let naive = |seeds: u16, open: u16| {
    // rust: let mut fill = seeds;
    // rust: loop {
    // rust: let next = (fill | fill << 1 | fill >> 1) & open;
    // rust: if next == fill {
    // rust: return fill;
}
    // rust: fill = next;
}
}
    // rust: let mut state = 0x9E37_79B9u32;
    // rust: for _ in 0..200_000 {
    // rust: state ^= state << 13;
    // rust: state ^= state >> 17;
    // rust: state ^= state << 5;
    // rust: let open = state as u16;
    // rust: let seeds = (state >> 16) as u16 & open;
    // rust: assert_eq!(
    // rust: fill_row(seeds, open),
    // rust: naive(seeds, open),
    // rust: "{open:016b} {seeds:016b}"
    // rust: );
}
    // Several seeds in one run, the case a carry-based fill gets wrong.
    // rust: assert_eq!(fill_row(0b0110, 0b1111), 0b1111);
    // rust: assert_eq!(fill_row(0xC000, 0xF000), 0xF000);
}

pub fn row_fill_follows_open_runs() void {
}
    // rust: for open in [0u16, 0xFFFF, 0b0111_0110, 0x8001, 0xF0F0, 0x5555] {
    // rust: for bit in 0..16 {
    // rust: let seed = 1u16 << bit;
    // rust: if open & seed == 0 {
    // rust: continue;
}
    // rust: let mut expected = seed;
    // rust: for x in (0..bit).rev().take_while(|&x| open & 1 << x != 0) {
    // rust: expected |= 1 << x;
}
    // rust: for x in (bit + 1..16).take_while(|&x| open & 1 << x != 0) {
    // rust: expected |= 1 << x;
}
    // rust: assert_eq!(fill_row(seed, open), expected, "{open:016b} from {bit}");
}
}
}

/// Mazes: one long winding cavity, and many small ones, where the row
/// sweeps are slowest.
pub fn winding_and_scattered_cavities_match_reference() void {
}
    // rust: let info = [info(false), info(true), info(false), info(true)];
    // rust: let serpentine = fixture(|x, y, z| {
    // rust: let lane = z % 4 == 0 && y % 4 == 0;
    // rust: let turn = (x == 0 && z % 8 == 4) || (x == 15 && z % 8 == 0);
    // rust: let climb = x == 0 && z == 0 && y % 4 != 0;
    // rust: !(lane || (turn && y % 4 == 0) || climb)
    // rust: });
    // rust: assert_eq!(
    // rust: visibility(&serpentine, &info),
    // rust: reference(&serpentine, &info)
    // rust: );
    // rust: let pockets = fixture(|x, y, z| !(x % 3 == 1 && y % 3 == 1 && z % 3 == 1));
    // rust: assert_eq!(visibility(&pockets, &info), reference(&pockets, &info));
}

pub fn visibility_preserves_every_face_pair() void {
}
    // rust: let info = [info(false), info(true), info(false), info(true)];
    // Each subset of six arms is one connected cavity. Its exact flags are
    // the Cartesian product of the touched faces, including self-visibility.
    // rust: for mask in 0..64u8 {
    // rust: let pad = fixture(|x, y, z| {
    // rust: let arm = (x == 8
    // rust: && z == 8
    // rust: && ((y <= 8 && mask & 1 != 0) || (y >= 8 && mask & 2 != 0)))
    // rust: || (x == 8 && y == 8 && ((z <= 8 && mask & 4 != 0) || (z >= 8 && mask & 8 != 0)))
    // rust: || (y == 8 && z == 8 && ((x <= 8 && mask & 16 != 0) || (x >= 8 && mask & 32 != 0)));
    // rust: !(arm || (x == 8 && y == 8 && z == 8))
    // rust: });
    // rust: let mut expected = 0;
    // rust: for a in 0..6 {
    // rust: for b in 0..6 {
    // rust: if mask & (1 << a) != 0 && mask & (1 << b) != 0 {
    // rust: expected |= 1 << (6 * a + b);
}
}
}
    // rust: assert_eq!(visibility(&pad, &info), expected, "arms {mask}");
    // rust: assert_eq!(reference(&pad, &info), expected);
}
    // rust: assert_eq!(visibility(&fixture(|_, _, _| false), &info), ALL_VISIBLE);
    // rust: assert_eq!(visibility(&fixture(|_, _, _| true), &info), 0);
    // Bottom and top sheets each touch five faces; a separate vertical tube
    // supplies Down <-> Up. Their union is all flags, with no six-face region.
    // rust: let (_, pad) = cases()
    // rust: .into_iter()
    // rust: .find(|(name, _)| *name == "disconnected_all_pairs")
    // rust: .unwrap();
    // rust: assert_eq!(visibility(&pad, &info), ALL_VISIBLE);
    // rust: assert_eq!(reference(&pad, &info), ALL_VISIBLE);
    // Two disconnected corner cells must never connect opposite faces.
    // rust: let pad = fixture(|x, y, z| !((x == 0 && y == 0 && z == 0) || (x == 15 && y == 15 && z == 15)));
    // rust: let flags = visibility(&pad, &info);
    // rust: assert_eq!(flags, reference(&pad, &info));
    // rust: assert_eq!(flags & (1 << 1), 0); // Down -> Up
    // rust: assert_ne!(flags & 1, 0); // Down -> Down
}

pub fn visibility_benchmark() void {
}
//     use std::{hint::black_box, time::Instant};
pub const WARMUP: usize = 200;
pub const ITERATIONS: usize = 1000;
pub const SAMPLES: usize = 11;
    // rust: let info = [info(false), info(true), info(false), info(true)];
    // rust: println!(
    // rust: "case,opaque_cells,before_ns,after_ns,speedup; warmup={WARMUP}, iterations={ITERATIONS}, samples={SAMPLES}"
    // rust: );
    // rust: for (name, pad) in cases() {
    // rust: assert_eq!(visibility(&pad, &info), reference(&pad, &info), "{name}");
    // rust: let opaque = (0..4096)
    // rust: .filter(|&i| info[pad.blocks[pi(i & 15, i >> 8, (i >> 4) & 15)] as usize].solid)
    // rust: .count();
    // rust: for _ in 0..WARMUP {
    // rust: black_box(reference(black_box(&pad), black_box(&info)));
    // rust: black_box(visibility(black_box(&pad), black_box(&info)));
}
    // rust: let measure = |f: fn(&Padded, &[Info]) -> u64| {
    // rust: let start = Instant::now();
    // rust: for _ in 0..ITERATIONS {
    // rust: black_box(f(black_box(&pad), black_box(&info)));
}
    // rust: start.elapsed().as_nanos() as f64 / ITERATIONS as f64
}
    // rust: let mut before = Vec::new();
    // rust: let mut after = Vec::new();
    // rust: for sample in 0..SAMPLES {
            // Alternate order to reduce drift bias.
    // rust: if sample % 2 == 0 {
    // rust: before.push(measure(reference));
    // rust: after.push(measure(visibility));
    // rust: } else {
    // rust: after.push(measure(visibility));
    // rust: before.push(measure(reference));
}
}
    // rust: before.sort_by(f64::total_cmp);
    // rust: after.sort_by(f64::total_cmp);
    // rust: let (before, after) = (before[SAMPLES / 2], after[SAMPLES / 2]);
    // rust: println!(
    // rust: "{name},{opaque},{before:.1},{after:.1},{:.2}x",
    // rust: before / after
    // rust: );
}
}
