//! Transpiled from Horizon Rust crate
package horizon_client_render_leaf_culling

import "core:fmt"
import "core:mem"
import "core:math"

// Leaf culling: decides which leaf faces a section may draw solid or drop.
//
// The mask is built on the mesh worker from the same padded block snapshot the
// rest of the mesher reads, so a decision never needs a chunk lookup on the
// render thread. It classifies each padded cell as a leaf, a full opaque cube,
// open (air, fluids, partial models, anything else) or unknown (a missing
// chunk, a Y outside the column, or the mask's outer shell). Only leaves can
// hide or solidify anything; unknown and open cells always expose a face.
//
// `Solid` performs an immediate 6-neighbour occlusion check, solidifying fully
// enclosed leaves into the opaque layer without cutout testing. `Solid
// Aggressive` runs a multi-source breadth-first search from leaves touching
// openings, solidifying leaves with a single open face to thin the canopy shell
// by one layer. `Hollow` directly drops faces shared between two leaves within
// the section, preserving boundaries and cavity faces. `Hidden` drops only
// those whose faced leaf has another leaf or an opaque cube behind it
// ([`backed`]), so the layer seen through the canopy's outer holes stays.

// use super::{B, Info, P, Padded, pi};
// use crate::{blocks::RenderShape, chunk::Chunk, graphics::LeafCullingMode};

// A cell of the padded snapshot, as far as leaf culling cares.
    // rust: pub(super) enum Cell {
    // Air, a fluid, a partial model, glass or any other non-occluding block.
    // rust: Open,
    // `LeavesBlock`.
    // rust: Leaf,
    // A full opaque cube (see [`opaque_cube`]).
    // rust: Opaque,
    // Missing chunk, missing section or the mask's outer shell.
    // rust: Unknown,
}

// Whether a state is a full opaque cube: `RenderShape::Model`, `can_occlude`,
// `solid_render` and a full collision shape. Glass, fluids, slabs, stairs,
// chests and models that only partly fill their block are not.
    // rust: pub(super) fn opaque_cube(
    // rust: shape: RenderShape,
    // rust: can_occlude: bool,
    // rust: solid_render: bool,
    // rust: full_collision: bool,
    // rust: ) -> bool {
    // rust: shape == RenderShape::Model && can_occlude && solid_render && full_collision
}

UNVISITED :: u8::MAX

STRIDE_X :: 1
STRIDE_Z :: P as isize
STRIDE_Y :: (P * P) as isize

    // rust: const ADJACENT_STRIDES: [isize; 6] = [
    // rust: STRIDE_X, -STRIDE_X, STRIDE_Z, -STRIDE_Z, STRIDE_Y, -STRIDE_Y,
    // rust: ];

// Per-worker leaf mask and BFS scratch. The vectors keep their capacity
// between sections and modes; `Off` does no work at all.
    // rust: pub(super) struct LeafMask {
    // rust: cells: Vec<Cell>,
    // rust: depth: Vec<u8>,
    // rust: queue: Vec<u16>,
    // rust: active: bool,
}

    // rust: impl LeafMask {
    // Classify the padded snapshot and, for the interior modes, measure how
    // deep each leaf sits below the canopy surface.
    // rust: pub(super) fn prepare(
    // rust: &mut self,
    // rust: mode: LeafCullingMode,
    // rust: pad: &Padded,
    // rust: info: &[Info],
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: base_y: i32,
    // rust: ) {
    // rust: self.active = mode != LeafCullingMode::Off;
    // rust: if !self.active {
    // rust: return;
}
        // Most sections hold no leaves at all; do not classify 8,000 cells to
        // learn that. The centre is the only part this mesh can change.
    // rust: let mut leaves = false;
    // rust: 'scan: for y in 0..16 {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: if info
    // rust: .get(pad.blocks[pi(x, y, z)] as usize)
    // rust: .is_some_and(|state| state.leaves)
    // rust: {
    // rust: leaves = true;
    // rust: break 'scan;
}
}
}
}
    // rust: if !leaves {
    // rust: self.active = false;
    // rust: return;
}
    // rust: if self.cells.len() != P * P * P {
    // rust: self.cells.resize(P * P * P, Cell::Open);
}
    // rust: for y in -B..16 + B {
    // rust: for z in -B..16 + B {
    // rust: for x in -B..16 + B {
    // rust: let i = pi(x, y, z);
    // rust: self.cells[i] = if !known(region, base_y, x, y, z) {
    // rust: Cell::Unknown
    // rust: } else {
    // rust: match info.get(pad.blocks[i] as usize) {
    // rust: None => Cell::Unknown,
    // rust: Some(state) if state.leaves => Cell::Leaf,
    // rust: Some(state) if state.opaque_cube => Cell::Opaque,
    // rust: Some(_) => Cell::Open,
}
}
}
}
}
        // Solid is a purely local six-neighbour test. Reserve the breadth-first
        // search for Solid Aggressive, whose one-open-side rule needs to know
        // whether a leaf is connected to the canopy surface through other
        // leaves.
    // rust: if mode == LeafCullingMode::SolidAggressive {
    // rust: self.depths();
}
}

    // Multi-source BFS from leaves that touch an opening. Opaque neighbours do
    // not expose a leaf: a leaf fully enclosed by stone is interior too.
depths :: proc(self: ^Self) {
}
    // rust: if self.depth.len() != self.cells.len() {
    // rust: self.depth.resize(self.cells.len(), UNVISITED);
    // rust: } else {
    // rust: self.depth.fill(UNVISITED);
}
    // rust: self.queue.clear();
    // rust: for y in -B..16 + B {
    // rust: for z in -B..16 + B {
    // rust: for x in -B..16 + B {
    // rust: let i = pi(x, y, z);
    // rust: if self.cells[i] != Cell::Leaf {
    // rust: continue;
}
    // rust: let touches_open = ADJACENT_STRIDES.iter().any(|&stride| {
    // rust: let j = (i as isize + stride) as usize;
    // rust: matches!(self.cells[j], Cell::Open | Cell::Unknown)
    // rust: });
    // rust: if touches_open {
    // rust: self.depth[i] = 0;
    // rust: self.queue.push(i as u16);
}
}
}
}
    // rust: let mut head = 0;
    // rust: while head < self.queue.len() {
    // rust: let i = self.queue[head] as usize;
    // rust: head += 1;
    // rust: let next_depth = self.depth[i].saturating_add(1);
    // rust: for stride in ADJACENT_STRIDES {
    // rust: let j = (i as isize + stride) as usize;
    // rust: if self.cells[j] == Cell::Leaf && self.depth[j] == UNVISITED {
    // rust: self.depth[j] = next_depth;
    // rust: self.queue.push(j as u16);
}
}
}
}

    // Whether the leaf at `(x, y, z)` may draw in the opaque layer.
    //
    // `Solid` wants a leaf with no open neighbour, which is exactly depth 1 or
    // more. `Solid Aggressive` also takes the next layer of the shell: a leaf
    // with a single open side joins the opaque core, so the cutout shell is
    // one layer thinner. Unknown neighbours never qualify, however many sides
    // they leave open. A leaf the search never reached sits inside a closed
    // volume: interior for both.
    // rust: pub(super) fn interior(&self, mode: LeafCullingMode, x: i32, y: i32, z: i32) -> bool {
    // rust: if !self.active {
    // rust: return false;
}
    // rust: let aggressive = match mode {
    // rust: LeafCullingMode::Solid => false,
    // rust: LeafCullingMode::SolidAggressive => true,
    // rust: _ => return false,
}
        // A section boundary is not proof of a closed volume: the neighbouring
        // section may not be drawn yet, and its data is not ours to assume.
    // rust: if !(1..15).contains(&x) || !(1..15).contains(&y) || !(1..15).contains(&z) {
    // rust: return false;
}
    // rust: let i = pi(x, y, z);
    // rust: if self.cells.get(i) != Some(&Cell::Leaf) {
    // rust: return false;
}
    // rust: if !aggressive {
    // rust: return ADJACENT_STRIDES.iter().all(|&stride| {
    // rust: let j = (i as isize + stride) as usize;
    // rust: matches!(self.cells[j], Cell::Leaf | Cell::Opaque)
    // rust: });
}
    // rust: let depth = self.depth[i];
    // rust: if depth == UNVISITED || depth >= 1 {
    // rust: return true;
}
    // rust: let mut open = 0;
    // rust: for stride in ADJACENT_STRIDES {
    // rust: let j = (i as isize + stride) as usize;
    // rust: match self.cells[j] {
    // rust: Cell::Unknown => return false,
    // rust: Cell::Open => {
    // rust: open += 1;
    // rust: if open > 1 {
    // rust: return false;
}
}
    // rust: Cell::Leaf | Cell::Opaque => {}
}
}
    // rust: open == 1
}
}

// The cells this section's mesh owns. A face on this boundary belongs to the
// neighbouring section as much as to this one; leaf culling leaves it alone.
    // rust: pub(super) fn in_section(x: i32, y: i32, z: i32) -> bool {
    // rust: (0..16).contains(&x) && (0..16).contains(&y) && (0..16).contains(&z)
}

// `Hidden`: whether the padded cell `[x, y, z]`, the one behind a faced leaf,
// is a leaf or a full opaque cube. A cell without real data never is.
    // rust: pub(super) fn backed(
    // rust: pad: &Padded,
    // rust: info: &[Info],
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: base_y: i32,
    // rust: [x, y, z]: [i32; 3],
    // rust: ) -> bool {
    // rust: info.get(pad.blocks[pi(x, y, z)] as usize)
    // rust: .is_some_and(|state| state.leaves || state.opaque_cube)
    // rust: && known(region, base_y, x, y, z)
}

// Whether the padded cell `(x, y, z)` has real block data. A missing chunk
// does not count: `Padded::fill` copies the centre's edge column into it, which
// would make a canopy look enclosed. A Y outside the column counts as unknown
// for the same reason. The mask's outer shell is unknown too, so nothing is
// inferred past the data the worker snapshotted.
known :: proc(region: ^[[Maybe(^Chunk); 3]; 3], base_y: i32, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if x <= -B || x >= 16 + B - 1 || y <= -B || y >= 16 + B - 1 || z <= -B || z >= 16 + B - 1 {
    // rust: return false;
}
    // rust: let chunk = region[((z + 16) >> 4) as usize][((x + 16) >> 4) as usize];
    // rust: chunk.is_some_and(|chunk| chunk.section_index(base_y + y).is_some())
}

    // rust: impl LeafMask {
    // Whether `Hollow` drops the face of the leaf at `(x, y, z)` toward `d`.
    // Only a known leaf on the other side counts: open cells, partial models,
    // missing neighbours and the mask's edge stay visible.
    // rust: pub(super) fn hides_face(
    // rust: &self,
    // rust: mode: LeafCullingMode,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: d: horizon_core::geometry::Direction,
    // rust: ) -> bool {
    // rust: if !self.active || mode != LeafCullingMode::Hollow {
    // rust: return false;
}
    // rust: let [dx, dy, dz] = d.normal();
    // rust: let (nx, ny, nz) = (x + dx, y + dy, z + dz);
    // rust: if !in_section(x, y, z) || !in_section(nx, ny, nz) {
    // rust: return false;
}
    // rust: let i = pi(x, y, z);
    // rust: let ni = pi(nx, ny, nz);
    // rust: self.cells.get(i) == Some(&Cell::Leaf) && self.cells.get(ni) == Some(&Cell::Leaf)
}

cell :: proc(self: ^Self, x: i32, y: i32, z: i32) -> C {
    // Ported from Horizon
    return {}
}
    // rust: checked(x, y, z)
    // rust: .and_then(|i| self.cells.get(i))
    // rust: .copied()
    // rust: .unwrap_or(Cell::Unknown)
}
}

checked :: proc(x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if (-B..16 + B).contains(&x) && (-B..16 + B).contains(&y) && (-B..16 + B).contains(&z) {
    // rust: Some(pi(x, y, z))
    // rust: } else {
    // rust: None
}
}

unpi :: proc(i: uint) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let x = (i % P) as i32 - B;
    // rust: let z = (i / P % P) as i32 - B;
    // rust: let y = (i / (P * P)) as i32 - B;
    // rust: (x, y, z)
}

    // rust: mod tests {
//     use super::*;
//     use crate::{blocks::RenderShape, graphics::LeafCullingMode};
//     use horizon_core::geometry::Direction;
//     use horizon_world::fluid::FluidState;
//     use std::time::Instant;

info :: proc(leaves: bool, opaque: bool) -> I {
    // Ported from Horizon
    return {}
}
    // rust: Info {
    // rust: solid: opaque,
    // rust: full: opaque,
    // rust: permeable: false,
    // rust: shade: 1.0,
    // rust: emission: 0,
    // rust: tier: 0,
    // rust: emissive: false,
    // rust: fluid: FluidState::EMPTY,
    // rust: model: true,
    // rust: block_entity: false,
    // rust: tints: [super::super::Tint::None; 2],
    // rust: tint_count: 0,
    // rust: offset: None,
    // rust: legacy_solid: false,
    // rust: overlay: leaves,
    // rust: leaves,
    // rust: pane: false,
    // rust: opaque_cube: opaque,
    // rust: blocks_flow: false,
    // rust: ice: false,
    // rust: sturdy: 0,
    // rust: face: [0; 6],
    // rust: cover: [0.0; 6],
}
}

    // State 0 is air, 1 leaves, 2 a full opaque cube, 3 a partial model.
states :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: vec![
    // rust: info(false, false),
    // rust: info(true, false),
    // rust: info(false, true),
    // rust: info(false, false),
    // rust: ]
}

padded :: proc(fill: impl Fn(i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: Padded {
    // rust: blocks: (0..P * P * P)
    // rust: .map(|i| {
    // rust: let (x, y, z) = unpi(i);
    // rust: fill(x, y, z)
    // rust: })
    // rust: .collect(),
    // rust: light: vec![0; P * P * P],
}
}

cube :: proc(pad: ^Padded, min: i32, max: i32, state: u32) {
}
    // rust: for y in min..=max {
    // rust: for z in min..=max {
    // rust: for x in min..=max {
    // rust: pad.blocks[pi(x, y, z)] = state;
}
}
}
}

loaded :: proc() -> C {
    // Ported from Horizon
    return {}
}
    // rust: Chunk::empty(0, 0)
}

region :: proc(chunk: ^Chunk) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [[Some(chunk); 3]; 3]
}

built :: proc(mode: LeafCullingMode, pad: ^Padded, states: ^[Info], chunk: ^Chunk) -> L {
    // Ported from Horizon
    return {}
}
    // rust: let mut mask = LeafMask::default();
    // rust: mask.prepare(mode, pad, states, &region(chunk), 0);
    // rust: mask
}

only_a_full_model_cube_is_opaque :: proc() {
}
    // rust: let combinations = [
    // rust: (RenderShape::Model, true, true, true),
    // rust: (RenderShape::Model, true, true, false),
    // rust: (RenderShape::Model, true, false, true),
    // rust: (RenderShape::Model, false, true, true),
    // rust: (RenderShape::Model, false, false, false),
    // rust: (RenderShape::Invisible, true, true, true),
    // rust: (RenderShape::Animated, true, true, true),
    // rust: ];
    // rust: let (shape, can_occlude, solid_render, full_collision) = combinations[0];
    // rust: assert!(opaque_cube(
    // rust: shape,
    // rust: can_occlude,
    // rust: solid_render,
    // rust: full_collision
    // rust: ));
    // rust: for &(shape, can_occlude, solid_render, full_collision) in &combinations[1..] {
    // rust: assert!(
    // rust: !opaque_cube(shape, can_occlude, solid_render, full_collision),
    // rust: "{shape:?} {can_occlude} {solid_render} {full_collision}"
    // rust: );
}
}

solid_marks_the_cell_inside_a_three_cube :: proc() {
}
    // rust: let states = states();
    // rust: let mut pad = padded(|_, _, _| 0);
    // rust: cube(&mut pad, 7, 9, 1);
    // rust: let chunk = loaded();
    // rust: let solid = built(LeafCullingMode::Solid, &pad, &states, &chunk);
    // rust: assert!(!solid.interior(LeafCullingMode::Solid, 7, 8, 8));
    // rust: assert!(solid.interior(LeafCullingMode::Solid, 8, 8, 8));
    // rust: assert!(!solid.interior(LeafCullingMode::Solid, 8, 9, 8));
        // Aggressive also takes the six face-centre leaves, whose only open
        // side faces out of the cube. Corners and edges keep their cutout.
    // rust: let aggressive = built(LeafCullingMode::SolidAggressive, &pad, &states, &chunk);
    // rust: assert!(aggressive.interior(LeafCullingMode::SolidAggressive, 8, 8, 8));
    // rust: assert!(aggressive.interior(LeafCullingMode::SolidAggressive, 7, 8, 8));
    // rust: assert!(aggressive.interior(LeafCullingMode::SolidAggressive, 8, 8, 9));
    // rust: assert!(!aggressive.interior(LeafCullingMode::SolidAggressive, 7, 7, 8));
    // rust: assert!(!aggressive.interior(LeafCullingMode::SolidAggressive, 7, 7, 7));
}

aggressive_takes_the_next_shell_layer :: proc() {
}
    // rust: let states = states();
    // rust: let mut pad = padded(|_, _, _| 0);
    // rust: cube(&mut pad, 6, 10, 1);
    // rust: let chunk = loaded();
    // rust: let solid = built(LeafCullingMode::Solid, &pad, &states, &chunk);
    // rust: let aggressive = built(LeafCullingMode::SolidAggressive, &pad, &states, &chunk);
    // rust: let surface = |v: i32| v == 6 || v == 10;
    // rust: for [x, y, z] in [
    // rust: [6, 8, 8],
    // rust: [10, 8, 8],
    // rust: [6, 6, 8],
    // rust: [6, 6, 6],
    // rust: [7, 8, 8],
    // rust: [8, 8, 8],
    // rust: [7, 7, 7],
    // rust: [8, 8, 7],
    // rust: ] {
    // rust: let expected = !surface(x) && !surface(y) && !surface(z);
    // rust: assert_eq!(
    // rust: solid.interior(LeafCullingMode::Solid, x, y, z),
    // rust: expected,
    // rust: "solid {x} {y} {z}"
    // rust: );
    // rust: let open = [x, y, z].iter().filter(|v| surface(**v)).count();
    // rust: let expected = open <= 1;
    // rust: assert_eq!(
    // rust: aggressive.interior(LeafCullingMode::SolidAggressive, x, y, z),
    // rust: expected,
    // rust: "aggressive {x} {y} {z}"
    // rust: );
}
}

hollow_hides_only_leaf_to_leaf_faces :: proc() {
}
    // rust: let states = states();
    // rust: let mut pad = padded(|_, _, _| 0);
    // rust: cube(&mut pad, 7, 9, 1);
        // Glass (3, a partial model), water and a slab are open: their leaves
        // must keep the face.
    // rust: pad.blocks[pi(10, 8, 8)] = 3;
    // rust: let chunk = loaded();
    // rust: let hollow = built(LeafCullingMode::Hollow, &pad, &states, &chunk);
    // rust: for d in Direction::ALL {
    // rust: assert!(
    // rust: hollow.hides_face(LeafCullingMode::Hollow, 8, 8, 8, d),
    // rust: "{d:?}"
    // rust: );
}
    // rust: assert!(!hollow.hides_face(LeafCullingMode::Hollow, 9, 8, 8, Direction::East));
    // rust: assert!(!hollow.hides_face(LeafCullingMode::Hollow, 7, 8, 8, Direction::West));
        // The other modes never hide a quad.
    // rust: for mode in [
    // rust: LeafCullingMode::Off,
    // rust: LeafCullingMode::Solid,
    // rust: LeafCullingMode::SolidAggressive,
    // rust: ] {
    // rust: let mask = built(mode, &pad, &states, &chunk);
    // rust: assert!(!mask.hides_face(mode, 8, 8, 8, Direction::Up));
}
}

a_cavity_keeps_its_faces_and_its_rim_visible :: proc() {
}
    // rust: let states = states();
    // rust: let mut pad = padded(|_, _, _| 0);
    // rust: cube(&mut pad, 6, 10, 1);
    // rust: pad.blocks[pi(8, 8, 8)] = 0;
    // rust: let chunk = loaded();
    // rust: let hollow = built(LeafCullingMode::Hollow, &pad, &states, &chunk);
    // rust: assert!(!hollow.hides_face(LeafCullingMode::Hollow, 7, 8, 8, Direction::East));
    // rust: assert!(!hollow.hides_face(LeafCullingMode::Hollow, 8, 8, 7, Direction::South));
    // rust: let solid = built(LeafCullingMode::Solid, &pad, &states, &chunk);
    // rust: assert!(!solid.interior(LeafCullingMode::Solid, 7, 8, 8));
    // rust: assert!(!solid.interior(LeafCullingMode::Solid, 6, 8, 8));
        // The corner away from the cavity is still two layers in.
    // rust: assert!(solid.interior(LeafCullingMode::Solid, 9, 9, 9));
}

an_opaque_neighbour_does_not_expose_a_leaf :: proc() {
}
    // rust: let states = states();
    // rust: let mut pad = padded(|_, _, _| 0);
    // rust: for (dx, dy, dz) in [
    // rust: (1, 0, 0),
    // rust: (-1, 0, 0),
    // rust: (0, 1, 0),
    // rust: (0, -1, 0),
    // rust: (0, 0, 1),
    // rust: (0, 0, -1),
    // rust: ] {
    // rust: pad.blocks[pi(8 + dx, 8 + dy, 8 + dz)] = 2;
}
    // rust: pad.blocks[pi(8, 8, 8)] = 1;
    // rust: let chunk = loaded();
    // rust: for mode in [LeafCullingMode::Solid, LeafCullingMode::SolidAggressive] {
    // rust: let mask = built(mode, &pad, &states, &chunk);
    // rust: assert!(mask.interior(mode, 8, 8, 8), "{mode:?}");
}
    // rust: let hollow = built(LeafCullingMode::Hollow, &pad, &states, &chunk);
    // rust: for d in Direction::ALL {
    // rust: assert!(
    // rust: !hollow.hides_face(LeafCullingMode::Hollow, 8, 8, 8, d),
    // rust: "{d:?}"
    // rust: );
}
}

a_leaf_inside_a_closed_volume_is_interior :: proc() {
}
    // rust: let states = states();
        // A leaf cube inside opaque rock: the search has no opening to start
        // from, so every leaf stays unvisited and counts as interior.
    // rust: let mut pad = padded(|_, _, _| 2);
    // rust: cube(&mut pad, 7, 9, 1);
    // rust: let chunk = loaded();
    // rust: for mode in [LeafCullingMode::Solid, LeafCullingMode::SolidAggressive] {
    // rust: let mask = built(mode, &pad, &states, &chunk);
    // rust: if mode == LeafCullingMode::SolidAggressive {
    // rust: assert_eq!(mask.depth[pi(8, 8, 8)], UNVISITED);
}
    // rust: assert!(mask.interior(mode, 8, 8, 8), "{mode:?}");
}
}

missing_chunks_and_sections_are_unknown :: proc() {
}
    // rust: let states = states();
    // rust: let pad = padded(|_, _, _| 1);
    // rust: let chunk = loaded();
    // rust: let mut around = [[Some(&chunk); 3]; 3];
    // rust: around[1][2] = None; // east chunk
    // rust: let mut mask = LeafMask::default();
    // rust: mask.prepare(LeafCullingMode::Hollow, &pad, &states, &around, 0);
        // The leaf at the edge keeps its face toward the missing chunk, even
        // though `Padded::fill` copied the centre's edge leaf there.
    // rust: assert!(!mask.hides_face(LeafCullingMode::Hollow, 15, 8, 8, Direction::East));
        // A leaf one block inside is still between two known leaves.
    // rust: assert!(mask.hides_face(LeafCullingMode::Hollow, 14, 8, 8, Direction::East));

        // A section above the column is unknown too: the same leaf one
        // section up has no data, so it can never be interior.
    // rust: let short = Chunk::with_layout(0, 0, crate::chunk::ColumnLayout::new(0, 16).unwrap());
    // rust: let mut mask = LeafMask::default();
    // rust: mask.prepare(LeafCullingMode::Solid, &pad, &states, &region(&short), 16);
    // rust: assert!(!mask.interior(LeafCullingMode::Solid, 8, 8, 8));

        // The outer shell has no data beyond it.
    // rust: let mut mask = LeafMask::default();
    // rust: mask.prepare(LeafCullingMode::Hollow, &pad, &states, &region(&chunk), 0);
    // rust: assert_eq!(mask.cell(-B, 0, 0), Cell::Unknown);
    // rust: assert_eq!(mask.cell(16 + B - 1, 0, 0), Cell::Unknown);
    // rust: assert_eq!(mask.cell(0, 0, 0), Cell::Leaf);

        // A section boundary is never enclosed, even with every chunk loaded:
        // the neighbouring section may not have been meshed yet.
    // rust: let mut mask = LeafMask::default();
    // rust: mask.prepare(LeafCullingMode::Solid, &pad, &states, &region(&chunk), 0);
    // rust: assert!(!mask.interior(LeafCullingMode::Solid, 15, 8, 8));
    // rust: assert!(mask.interior(LeafCullingMode::Solid, 14, 8, 8));
}

off_does_no_work_and_hides_nothing :: proc() {
}
    // rust: let states = states();
    // rust: let mut pad = padded(|_, _, _| 0);
    // rust: cube(&mut pad, 7, 9, 1);
    // rust: let chunk = loaded();
    // rust: let mut mask = LeafMask::default();
    // rust: mask.prepare(LeafCullingMode::Off, &pad, &states, &region(&chunk), 0);
    // rust: assert!(!mask.active);
    // rust: assert!(mask.cells.is_empty());
    // rust: assert!(!mask.interior(LeafCullingMode::Off, 8, 8, 8));
    // rust: assert!(!mask.hides_face(LeafCullingMode::Off, 8, 8, 8, Direction::Up));
}

a_reused_mask_reclassifies_every_cell :: proc() {
}
    // rust: let states = states();
    // rust: let chunk = loaded();
    // rust: let mut mask = LeafMask::default();
    // rust: let mut leaves = padded(|_, _, _| 0);
    // rust: cube(&mut leaves, 7, 9, 1);
    // rust: mask.prepare(
    // rust: LeafCullingMode::Hollow,
    // rust: &leaves,
    // rust: &states,
    // rust: &region(&chunk),
    // rust: 0,
    // rust: );
    // rust: assert_eq!(mask.cell(8, 8, 8), Cell::Leaf);
    // rust: let mut other = padded(|_, _, _| 0);
    // rust: cube(&mut other, 10, 12, 1);
    // rust: mask.prepare(LeafCullingMode::Hollow, &other, &states, &region(&chunk), 0);
    // rust: assert_eq!(mask.cell(8, 8, 8), Cell::Open);
    // rust: assert_eq!(mask.cell(11, 11, 11), Cell::Leaf);
}

mask_build_benchmark :: proc() {
}
    // rust: let states = states();
    // rust: let mut pad = padded(|x, y, z| {
            // Alternating leaf slabs make the search visit most of the volume.
    // rust: if (x / 2 + y / 2 + z / 2) % 3 == 0 {
    // rust: 1
    // rust: } else {
    // rust: 0
}
    // rust: });
    // rust: cube(&mut pad, 6, 10, 1);
    // rust: let chunk = loaded();
    // rust: let region = region(&chunk);
    // rust: let iterations = 1000;
    // rust: for mode in [LeafCullingMode::Solid, LeafCullingMode::SolidAggressive] {
    // rust: let mut mask = LeafMask::default();
    // rust: let started = Instant::now();
    // rust: for _ in 0..iterations {
    // rust: mask.prepare(mode, &pad, &states, &region, 0);
}
    // rust: let per = started.elapsed() / iterations;
    // rust: println!("leaf mask {mode:?}: {per:?} per section ({iterations} iterations)");
    // rust: assert!(mask.active);
    // rust: if mode == LeafCullingMode::SolidAggressive {
    // rust: assert_ne!(mask.depth[pi(8, 8, 8)], UNVISITED);
}
}
}
}
