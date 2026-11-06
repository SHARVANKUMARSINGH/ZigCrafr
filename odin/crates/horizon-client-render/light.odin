//! Transpiled from Horizon Rust crate
package horizon_client_render_light

import "core:fmt"
import "core:mem"
import "core:math"

// Sky and block light for one chunk, flood-filled over its 3x3 neighbourhood
// with vanilla's `LightEngine` rules:
// - light entering a block loses `max(1, getLightDampening)` (`getOpacity`);
// - it cannot cross a face where the two blocks' occlusion faces together
//   cover the whole square (`shapeOccludes`, using `getFaceOcclusionShape`
//   only for states with `canOcclude && useShapeForLightOcclusion`), which is
//   what makes slabs, stairs, snow layers etc. block light directionally;
// - sky sources run down each column to the first occluded edge
//   (`ChunkSkyLightSources.isEdgeOccluded`: dampening != 0 or the faces
//   between the two blocks occlude).
//
// The final values of vanilla's queue-based engine are the maximum over all
// paths, so a flood fill to the fixed point reproduces them. Light travels at
// most 15 blocks, so the 48-wide region determines the centre exactly.
// `relight_block` applies vanilla's incremental decrease/increase passes
// directly to resident chunks after a block change.
// use crate::fast_hash::FxHashMap;
// use crate::{
    // rust: blocks::BlockFacts,
    // rust: chunk::{Chunk, ColumnLayout, Light, Section, index},
}
// use horizon_core::geometry::{Direction, ShapeOp, VoxelShape};
// use horizon_world::registry::{BlockRegistry, BlockStateId};
// use std::{
    // rust: cell::RefCell,
    // rust: collections::{HashMap, VecDeque},
    // rust: path::Path,
    // rust: sync::Arc,
}

W :: 48
// Face ID 0: empty occlusion face; 1: the full square.
EMPTY :: 0
FULL :: 1

Cell :: struct {
    dampening: u8,
    emission: u8,
    // Any face is non-empty (`!isEmptyShape`), so edges need the face table.
    shaped: bool,
    faces: [u16,
}
LightTables :: struct {
    cells: [dynamic]Cell,
    // `faceShapeOccludes(a, b)` for every pair of distinct face shapes.
    occludes: [dynamic]bool,
    faces: uint,
    // Number of distinct `(shaped, faces)` configurations.
    types: uint,
    // Per state: `emission << 16 | type << 4 | dampening`. The low 16 bits are
    // what `light_chunk` stores per cell, so a cell costs 2 bytes and the
    // flood fill never reads the (large) `cells` table.
    info: [dynamic]u32,
    // `blocked(type_a, type_b, direction)` as a bit per direction.
    block_masks: [dynamic]u8,
}
    // rust: impl LightTables {
    // Dampening and emission only: every occlusion face is empty.
new :: proc(facts: ^BlockFacts) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut tables = Self {
    // rust: cells: facts
    // rust: .states
    // rust: .iter()
    // rust: .map(|s| Cell {
    // rust: dampening: s.dampening.min(15),
    // rust: emission: s.emission.min(15),
    // rust: shaped: false,
    // rust: faces: [EMPTY; 6],
    // rust: })
    // rust: .collect(),
    // rust: occludes: vec![false, true, true, true],
    // rust: faces: 2,
    // rust: types: 1,
    // rust: info: Vec::new(),
    // rust: block_masks: Vec::new(),
}
    // rust: tables.rebuild_cache();
    // rust: tables
}
    // Build the packed per-cell info and the per-configuration blocking masks
    // used by `light_chunk`'s flood fill.
rebuild_cache :: proc(self: ^Self) {
}
    // rust: let empty: (bool, [u16; 6]) = (false, [EMPTY; 6]);
    // rust: let mut by_config: HashMap<(bool, [u16; 6]), u16> = HashMap::new();
    // rust: by_config.insert(empty, 0);
    // rust: let mut configs: Vec<(bool, [u16; 6])> = vec![empty];
    // rust: let mut info = vec![0u32; self.cells.len()];
    // rust: for (id, cell) in self.cells.iter().enumerate() {
    // rust: let ty = *by_config
    // rust: .entry((cell.shaped, cell.faces))
    // rust: .or_insert_with(|| {
    // rust: configs.push((cell.shaped, cell.faces));
    // rust: (configs.len() - 1) as u16
    // rust: });
    // rust: let packed = u32::from(ty) << 4 | u32::from(cell.dampening.min(15));
    // rust: info[id] = u32::from(cell.emission.min(15)) << 16 | packed;
}
    // rust: let types = configs.len();
    // rust: debug_assert!(
    // rust: types <= 4096,
    // rust: "light tables: {types} cell configurations exceed the 12-bit type field"
    // rust: );
    // rust: let mut block_masks = vec![0u8; types * types];
    // rust: for a in 0..types {
    // rust: for b in 0..types {
    // rust: let (shaped_a, faces_a) = configs[a];
    // rust: let (shaped_b, faces_b) = configs[b];
                // `blocked`: an unshaped pair covers no face; otherwise the two
                // face shapes are compared through the `occludes` table.
    // rust: if !shaped_a && !shaped_b {
    // rust: continue;
}
    // rust: let mut mask = 0u8;
    // rust: for d in 0..6 {
    // rust: if self.occludes[faces_a[d] as usize * self.faces + faces_b[d ^ 1] as usize] {
    // rust: mask |= 1 << d;
}
}
    // rust: block_masks[a * types + b] = mask;
}
}
    // rust: self.types = types;
    // rust: self.info = info;
    // rust: self.block_masks = block_masks;
}
    // Full tables with the vanilla occlusion shapes from `occlusion.nbt`.
load :: proc(root: ^Path, registry: ^BlockRegistry, facts: ^BlockFacts) -> c {
    // Ported from Horizon
    return {}
}
//         use horizon_world::{collision::CachedCollisionRegistry, registry::BlockTableFile};
    // rust: let file = BlockTableFile::open(&root.join("occlusion.nbt"), registry)?;
    // rust: let occlusion = CachedCollisionRegistry::from_table(file.table("occlusion")?)?;
    // rust: let mut tables = Self::new(facts);
    // rust: let block = VoxelShape::block();
    // rust: let mut shapes: Vec<VoxelShape> = vec![VoxelShape::empty(), block.clone()];
    // rust: let mut by_geometry: HashMap<Vec<u64>, u16> = HashMap::new();
    // rust: let mut by_shape: HashMap<*const VoxelShape, [u16; 6]> = HashMap::new();
    // rust: for (id, cell) in tables.cells.iter_mut().enumerate() {
    // rust: let state = &facts.states[id];
            // LightEngine.isEmptyShape: !canOcclude || !useShapeForLightOcclusion.
    // rust: if !state.can_occlude || !state.shape_occlusion {
    // rust: continue;
}
    // rust: let Some(shape) = occlusion.cached_shape(BlockStateId(id as u32))? else {
    // rust: continue;
}
    // rust: if shape.is_empty() {
    // rust: continue;
}
    // rust: let faces = if let Some(faces) = by_shape.get(&std::ptr::from_ref(shape)) {
    // rust: *faces
    // rust: } else {
    // rust: let mut faces = [FULL; 6];
                // BlockState.initCache: solidRender shapes use the full faces.
    // rust: if shape.join_is_not_empty(&block, ShapeOp::XOR)? {
    // rust: for direction in Direction::ALL {
    // rust: let face = shape.face_shape(direction)?;
    // rust: faces[direction as usize] = if face.is_empty() {
    // rust: EMPTY
    // rust: } else if face.same_identity(&block) {
    // rust: FULL
    // rust: } else {
    // rust: let key: Vec<u64> = face
    // rust: .boxes()
    // rust: .iter()
    // rust: .flat_map(|b| {
    // rust: b.min_position()
    // rust: .components()
    // rust: .into_iter()
    // rust: .chain(b.max_position().components())
    // rust: })
    // rust: .map(f64::to_bits)
    // rust: .collect();
    // rust: *by_geometry.entry(key).or_insert_with(|| {
    // rust: shapes.push(face.clone());
    // rust: (shapes.len() - 1) as u16
    // rust: })
}
}
}
    // rust: by_shape.insert(std::ptr::from_ref(shape), faces);
    // rust: faces
}
    // rust: cell.faces = faces;
    // rust: cell.shaped = faces.iter().any(|f| *f != EMPTY);
}
    // rust: let n = shapes.len();
    // rust: let mut occludes = vec![false; n * n];
    // rust: for a in 0..n {
    // rust: for b in 0..n {
    // rust: occludes[a * n + b] = if a == FULL as usize || b == FULL as usize {
    // rust: true
    // rust: } else if a == EMPTY as usize && b == EMPTY as usize {
    // rust: false
    // rust: } else {
                    // Shapes.faceShapeOccludes: the union covers the whole face.
    // rust: let union = shapes[a].join_unoptimized(&shapes[b], ShapeOp::OR)?;
    // rust: !block.join_is_not_empty(&union, ShapeOp::ONLY_FIRST)?
}
}
}
    // rust: tables.occludes = occludes;
    // rust: tables.faces = n;
    // rust: tables.rebuild_cache();
    // rust: Ok(tables)
}
    // Assembled tables (tests and benchmarks): derives the packed light cache.
from_parts :: proc(cells: [dynamic]Cell, occludes: [dynamic]bool, faces: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut tables = Self {
    // rust: cells,
    // rust: occludes,
    // rust: faces,
    // rust: types: 0,
    // rust: info: Vec::new(),
    // rust: block_masks: Vec::new(),
}
    // rust: tables.rebuild_cache();
    // rust: tables
}
    // `LightEngine.shapeOccludes(from, to, direction)`.
blocked :: proc(self: ^Self, from: uint, to: uint, direction: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (a, b) = (&self.cells[from], &self.cells[to]);
    // rust: if !a.shaped && !b.shaped {
    // rust: return false;
}
    // rust: let fa = a.faces[direction] as usize;
    // rust: let fb = b.faces[direction ^ 1] as usize;
    // rust: self.occludes[fa * self.faces + fb]
}
    // `blocked` for two packed cells (`type << 4 | dampening`).
packed_blocked :: proc(self: ^Self, a: u16, b: u16, direction: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.block_masks[(a >> 4) as usize * self.types + (b >> 4) as usize] & (1 << direction) != 0
}
    // `ChunkSkyLightSources.isEdgeOccluded(top, bottom)`.
edge_occluded :: proc(self: ^Self, top: uint, bottom: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.cells[bottom].dampening != 0 || self.blocked(top, bottom, Direction::Down as usize)
}
    // `edge_occluded` for two packed cells.
packed_edge_occluded :: proc(self: ^Self, top: u16, bottom: u16) -> b {
    // Ported from Horizon
    return {}
}
    // rust: bottom & 0xF != 0
    // rust: || ((top | bottom) != 0 && self.packed_blocked(top, bottom, Direction::Down as usize))
}
emission :: proc(self: ^Self, state: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.cells[state as usize].emission
}
dampening :: proc(self: ^Self, state: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.cells[state as usize].dampening
}
    // Whether a state change can change light (`hasDifferentLightProperties`).
differs :: proc(self: ^Self, old: u32, new: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (a, b) = (&self.cells[old as usize], &self.cells[new as usize]);
    // rust: old != new
    // rust: && (a.dampening != b.dampening || a.emission != b.emission || a.shaped || b.shaped)
}
}
// Direction index order matches `Direction` (down, up, north, south, west, east);
// `d ^ 1` is the opposite direction.
    // rust: const OFFSETS: [(i32, i32, i32); 6] = [
    // rust: (0, -1, 0),
    // rust: (0, 1, 0),
    // rust: (0, 0, -1),
    // rust: (0, 0, 1),
    // rust: (-1, 0, 0),
    // rust: (1, 0, 0),
    // rust: ];

LightScratch :: struct {
    states: [dynamic]u16,
    sky: [dynamic]u8,
    block: [dynamic]u8,
    queue: [dynamic]u32,
    sky_queue: [dynamic]u32,
    present: [dynamic]bool,
    lowest: [dynamic]i32,
    ids: Box<[u32,
}

    // rust: impl LightScratch {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: states: Vec::new(),
    // rust: sky: Vec::new(),
    // rust: block: Vec::new(),
    // rust: queue: Vec::new(),
    // rust: sky_queue: Vec::new(),
    // rust: present: vec![false; W * W],
    // rust: lowest: vec![0; W * W],
    // rust: ids: Box::new([0u32; 4096]),
}
}

    // Clear queues and shrink them if capacity exceeds the retention cap.
clear_queues :: proc(self: ^Self) {
}
MAX_QUEUE_CAPACITY :: 65_536
    // rust: self.queue.clear();
    // rust: if self.queue.capacity() > MAX_QUEUE_CAPACITY {
    // rust: self.queue.shrink_to(MAX_QUEUE_CAPACITY);
}
    // rust: self.sky_queue.clear();
    // rust: if self.sky_queue.capacity() > MAX_QUEUE_CAPACITY {
    // rust: self.sky_queue.shrink_to(MAX_QUEUE_CAPACITY);
}
}
}

    // rust: thread_local! {
SCRATCH :: RefCell::new(LightScratch::new())
}

// `region[dz][dx]` holds the chunks around the centre (index 1,1).
// `sky` is false in dimensions without skylight (the Nether).
    // rust: pub fn light_chunk(
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: tables: &LightTables,
    // rust: sky_light: bool,
    // rust: ) -> Vec<Light> {
    // rust: SCRATCH.with_borrow_mut(|scratch| light_chunk_with_scratch(region, tables, sky_light, scratch))
}

    // rust: fn light_chunk_with_scratch(
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: tables: &LightTables,
    // rust: sky_light: bool,
    // rust: scratch: &mut LightScratch,
    // rust: ) -> Vec<Light> {
    // rust: let sections = region[1][1].expect("centre chunk").sections.len();
    // Highest occupied section in the region bounds the work.
    // rust: let mut top_section = 0;
    // rust: for chunk in region.iter().flatten().flatten() {
    // rust: for (i, s) in chunk.sections.iter().enumerate().rev() {
    // rust: if !s.is_uniform(0) {
    // rust: top_section = top_section.max(i + 1);
    // rust: break;
}
}
}
    // One extra section above the highest occupied one: block light rises
    // up to 14 blocks into it (sky light there is always 15).
    // rust: let h = ((top_section + 1) * 16).min(sections * 16);
    // rust: let total = W * W * h;

    // rust: scratch.states.resize(total, 0);
    // rust: scratch.states.fill(0);
    // rust: scratch.sky.resize(total, 0);
    // rust: scratch.sky.fill(0);
    // rust: scratch.block.resize(total, 0);
    // rust: scratch.block.fill(0);
    // rust: scratch.clear_queues();

    // rust: let states = &mut scratch.states[..total];
    // rust: let sky = &mut scratch.sky[..total];
    // rust: let block = &mut scratch.block[..total];
    // rust: let queue = &mut scratch.queue;
    // rust: let sky_queue = &mut scratch.sky_queue;
    // rust: let ids = &mut scratch.ids;

    // rust: for (dz, row) in region.iter().enumerate() {
    // rust: let z_base = dz * 16;
    // rust: for (dx, chunk) in row.iter().enumerate() {
    // rust: let Some(chunk) = chunk else { continue };
    // rust: let x_base = dx * 16;
    // rust: for (si, section) in chunk.sections.iter().enumerate().take(top_section) {
    // rust: if section.is_uniform(0) {
    // rust: continue;
}
    // rust: section.unpack(ids);
    // rust: let y_base = si * 16;
    // rust: for ly in 0..16 {
    // rust: let y = y_base + ly;
    // rust: let y_offset = y * (W * W);
    // rust: for lz in 0..16 {
    // rust: let z = z_base + lz;
    // rust: let p_row = y_offset + z * W + x_base;
    // rust: let i_row = (ly << 8) | (lz << 4);
    // rust: for lx in 0..16 {
    // rust: let id = ids[i_row + lx];
    // rust: if id == 0 {
    // rust: continue;
}
    // rust: let p = p_row + lx;
    // rust: let info = tables.info[id as usize];
    // rust: states[p] = info as u16;
    // rust: let emission = info >> 16;
    // rust: if emission > 0 {
    // rust: block[p] = emission as u8;
    // rust: queue.push(p as u32);
}
}
}
}
}
}
}

    // Columns of missing neighbour chunks neither hold nor pass light.
    // rust: scratch.present.resize(W * W, false);
    // rust: for z in 0..W {
    // rust: for x in 0..W {
    // rust: scratch.present[z * W + x] = region[z / 16][x / 16].is_some();
}
}
    // rust: let present = &scratch.present[..W * W];

    // rust: scratch.lowest.resize(W * W, h as i32);
    // rust: let lowest = &mut scratch.lowest[..W * W];

    // rust: for z in 0..W {
    // rust: for x in 0..W {
    // rust: let col = z * W + x;
    // rust: if !present[col] || !sky_light {
    // rust: lowest[col] = h as i32;
    // rust: continue;
}
            // The top layer (above the occupied range) is always open sky.
    // rust: let mut y = h as i32 - 1;
    // rust: let mut p = (h - 1) * (W * W) + col;
    // rust: sky[p] = 15;
    // rust: while y > 0 {
    // rust: let next_p = p - (W * W);
    // rust: if tables.packed_edge_occluded(states[p], states[next_p]) {
    // rust: break;
}
    // rust: y -= 1;
    // rust: p = next_p;
    // rust: sky[p] = 15;
}
    // rust: lowest[col] = y;
}
}

    // rust: if sky_light {
    // rust: for z in 0..W {
    // rust: for x in 0..W {
    // rust: let col = z * W + x;
    // rust: if !present[col] {
    // rust: continue;
}
    // rust: let own = lowest[col];
    // rust: let mut deepest = own;
    // rust: for (nx, nz) in [
    // rust: (x.wrapping_sub(1), z),
    // rust: (x + 1, z),
    // rust: (x, z.wrapping_sub(1)),
    // rust: (x, z + 1),
    // rust: ] {
    // rust: if nx < W && nz < W && present[nz * W + nx] {
    // rust: deepest = deepest.max(lowest[nz * W + nx]);
}
}
                // Seed propagation from the source cells that border darker cells.
    // rust: let from = own.max(0) as usize;
    // rust: let to = (deepest as usize).min(h.saturating_sub(1));
    // rust: if from <= to {
    // rust: let mut p = from * (W * W) + col;
    // rust: for _ in from..=to {
    // rust: if sky[p] == 15 {
    // rust: sky_queue.push(p as u32);
}
    // rust: p += W * W;
}
}
}
}
}

    // rust: let block_masks = &tables.block_masks;
    // rust: let types = tables.types;

    // rust: let spread = |light: &mut [u8], queue: &mut Vec<u32>| {
    // rust: let mut head = 0;
    // rust: while head < queue.len() {
    // rust: let p = queue[head] as usize;
    // rust: head += 1;
    // rust: let level = light[p];
    // rust: if level <= 1 {
    // rust: continue;
}
    // rust: let min_threshold = level - 1;
    // rust: let y = p / (W * W);
    // rust: let col = p % (W * W);
    // rust: let z = col / W;
    // rust: let x = col % W;
    // rust: let from = states[p];
    // rust: let from_row = (from >> 4) as usize * types;

            // Neighbours by linear offset; `present` only depends on the
            // column, and the axis bounds rule out wrapping.
    // rust: macro_rules! step_neighbour {
    // rust: ($d:expr, $q:expr) => {{
    // rust: let q = $q;
    // rust: if light[q] < min_threshold {
    // rust: let to = states[q];
    // rust: let damp = (to & 0xF).max(1) as u8;
    // rust: if level > light[q] + damp {
    // rust: if block_masks[from_row + (to >> 4) as usize] & (1 << $d) == 0 {
    // rust: light[q] = level - damp;
    // rust: queue.push(q as u32);
}
}
}
    // rust: }};
}
    // rust: if y > 0 {
    // rust: step_neighbour!(0, p - W * W);
}
    // rust: if y + 1 < h {
    // rust: step_neighbour!(1, p + W * W);
}
    // rust: if z > 0 && present[col - W] {
    // rust: step_neighbour!(2, p - W);
}
    // rust: if z + 1 < W && present[col + W] {
    // rust: step_neighbour!(3, p + W);
}
    // rust: if x > 0 && present[col - 1] {
    // rust: step_neighbour!(4, p - 1);
}
    // rust: if x + 1 < W && present[col + 1] {
    // rust: step_neighbour!(5, p + 1);
}
}
}
    // rust: spread(sky, sky_queue);
    // rust: spread(block, queue);
    // rust: let result = pack_lighting(sections, h, sky, block, sky_light);
    // rust: scratch.clear_queues();
    // rust: result
}

// Extract just the centre column's light (`sections` of it); never copy
// worker snapshot sections.
    // rust: fn pack_lighting(
    // rust: sections: usize,
    // rust: h: usize,
    // rust: sky: &[u8],
    // rust: block: &[u8],
    // rust: sky_light: bool,
    // rust: ) -> Vec<Light> {
    // rust: let open = if sky_light { 0xF0 } else { 0x00 };
    // rust: (0..sections)
    // rust: .map(|si| {
    // rust: if si * 16 >= h {
    // rust: return Light::Uniform(open);
}
    // rust: let mut data = Box::new([open; 4096]);
    // rust: for ly in 0..16 {
    // rust: let y = si * 16 + ly;
    // rust: if y >= h {
    // rust: continue;
}
    // rust: let y_offset = y * (W * W);
    // rust: for lz in 0..16 {
    // rust: let p_row = y_offset + (16 + lz) * W + 16;
    // rust: let out_row = (ly << 8) | (lz << 4);
    // rust: for lx in 0..16 {
    // rust: let p = p_row + lx;
    // rust: data[out_row + lx] = sky[p] << 4 | block[p];
}
}
}
    // rust: Light::packed(data)
    // rust: })
    // rust: .collect()
}

// Move a worker's light into current sections, preserving later block/biome
// edits and immutable snapshots retained by other workers.
apply_lighting :: proc(chunk: ^Chunk, lights: [dynamic]Light) {
}
    // rust: for (section, light) in chunk.sections.iter_mut().zip(lights) {
        // A shared section already lit so stays as it is.
    // rust: if let (Light::Uniform(a), Light::Uniform(b)) = (&section.light, &light)
    // rust: && a == b
    // rust: {
    // rust: continue;
}
    // rust: Arc::make_mut(section).light = light;
}
    // rust: crate::chunk::share_uniform(&mut chunk.sections);
}

// `apply_lighting` for a chunk lit before: writes only the sections whose
// light changed and adds the cells that changed to `changed`.
apply_relighting :: proc(chunk: ^Chunk, lights: [dynamic]Light, changed: ^LightChanges) {
}
    // rust: changed.keyed(chunk.layout());
    // rust: for (sy, (section, light)) in chunk.sections.iter_mut().zip(lights).enumerate() {
    // rust: let old = &section.light;
    // rust: let classes = match (old, &light) {
    // rust: (Light::Uniform(a), Light::Uniform(b)) if a == b => continue,
            // (most sections of a chunk relit for a neighbour's edit keep their light: one comparison of the whole)
    // rust: (Light::Full(a), Light::Full(b)) => LightChanges::classes_differing(a, b),
    // rust: _ => {
    // rust: let mut classes = 0;
    // rust: for i in 0..4096 {
    // rust: if old.get(i) != light.get(i) {
    // rust: let (x, y, z) = (i as i32 & 15, (i >> 8) as i32, (i >> 4) as i32 & 15);
    // rust: classes |= 1 << LightChanges::class(x, y, z);
}
}
    // rust: classes
}
}
    // rust: if classes != 0 {
    // rust: changed.add((chunk.x, sy as i32, chunk.z), classes);
    // rust: Arc::make_mut(section).light = light;
}
}
}

// `DataLayer.get`: the nibble at index `i` (`y << 8 | z << 4 | x`), low first.
nibble :: proc(layer: []u8, i: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (layer[i >> 1] >> ((i & 1) * 4)) & 15
}

// A column's light as vanilla stores it, two DataLayers per section (sky,
// block; `layers[i]` for section `i`, `None` where no layer is stored), into
// the sections' packed light, which then needs no light job. A missing sky
// layer repeats the bottom layer of the nearest stored one above it, and
// `above` (per `z << 4 | x`) above the highest
// (`SkyLightSectionStorage.getLightValue`); a missing block layer is dark.
    // rust: pub fn light_from_layers<L: AsRef<[u8]>>(
    // rust: chunk: &mut Chunk,
    // rust: layers: &[(Option<L>, Option<L>)],
    // rust: mut above: [u8; 256],
    // rust: sky_light: bool,
    // rust: ) {
    // rust: let sections = chunk.sections.len();
    // rust: for (si, (sky, block)) in layers.iter().enumerate().take(sections).rev() {
    // rust: let sky = sky.as_ref().filter(|_| sky_light);
    // rust: let section = Arc::make_mut(&mut chunk.sections[si]);
    // rust: if sky.is_none() && block.is_none() && above.iter().all(|&v| v == above[0]) {
    // rust: section.light = Light::Uniform(above[0] << 4);
    // rust: section.compact();
    // rust: continue;
}
    // rust: let mut data = Box::new([0u8; 4096]);
    // rust: for (i, packed) in data.iter_mut().enumerate() {
    // rust: let s = sky.map_or(above[i & 255], |a| nibble(a.as_ref(), i));
    // rust: let b = block.as_ref().map_or(0, |a| nibble(a.as_ref(), i));
    // rust: *packed = s << 4 | b;
}
    // rust: for (i, a) in above.iter_mut().enumerate() {
    // rust: *a = data[i] >> 4;
}
    // rust: section.light = Light::Full(data);
    // rust: section.compact();
}
    // rust: crate::chunk::share_uniform(&mut chunk.sections);
    // rust: chunk.lit = true;
    // rust: chunk.light_loaded = true;
}

// A light update's layers (`LevelLightEngine.queueSectionData`): each one
// given replaces that kind of light in its section, the other kind stays.
// Returns the sections whose light changed.
    // rust: pub fn update_light_layers<L: AsRef<[u8]>>(
    // rust: chunk: &mut Chunk,
    // rust: layers: &[(Option<L>, Option<L>)],
    // rust: sky_light: bool,
    // rust: ) -> Vec<usize> {
    // rust: let mut changed = Vec::new();
    // rust: let sections = chunk.sections.len();
    // rust: for (si, (sky, block)) in layers.iter().enumerate().take(sections) {
    // rust: let sky = sky.as_ref().filter(|_| sky_light);
    // rust: if sky.is_none() && block.is_none() {
    // rust: continue;
}
    // rust: let old = &chunk.sections[si].light;
    // rust: let mut data = Box::new([0u8; 4096]);
    // rust: for (i, packed) in data.iter_mut().enumerate() {
    // rust: let was = old.get(i);
    // rust: let s = sky.map_or(was >> 4, |a| nibble(a.as_ref(), i));
    // rust: let b = block.as_ref().map_or(was & 15, |a| nibble(a.as_ref(), i));
    // rust: *packed = s << 4 | b;
}
    // rust: if (0..4096).all(|i| old.get(i) == data[i]) {
    // rust: continue;
}
    // rust: let section = Arc::make_mut(&mut chunk.sections[si]);
    // rust: section.light = Light::Full(data);
    // rust: section.compact();
    // rust: changed.push(si);
}
    // rust: changed
}

// Resident chunks the incremental relighter reads and writes.
    // rust: pub trait LightWorld {
    // Section `s` of chunk (cx, cz), None unless the chunk is loaded and lit.
section :: proc(self: ^Self, cx: i32, s: uint, cz: i32) -> O {
    // Ported from Horizon
    return {}
}
    // Replace the light of a section `section` returned.
set_section_light :: proc(self: ^Self, cx: i32, s: uint, cz: i32, light: Light) {
}
    // The column the world's chunks hold (its level's).
layout :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
}
    // rust: impl<S: std::hash::BuildHasher> LightWorld for HashMap<(i32, i32), Arc<Chunk>, S> {
layout :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.values()
    // rust: .next()
    // rust: .map_or(ColumnLayout::VANILLA, |c| c.layout())
}
section :: proc(self: ^Self, cx: i32, s: uint, cz: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.get(&(cx, cz))
    // rust: .filter(|c| c.lit)
    // rust: .map(|c| &c.sections[s])
}
set_section_light :: proc(self: ^Self, cx: i32, s: uint, cz: i32, light: Light) {
}
    // rust: if let Some(chunk) = self.get_mut(&(cx, cz)) {
    // rust: Arc::make_mut(&mut Arc::make_mut(chunk).sections[s]).light = light;
}
}
}
// The sections one relight touches, held for the whole flood fill so each
// cell access is an array index instead of a chunk lookup. Light a section
// gets written is copied out on the first write and stored back by `finish`.
Region :: struct {
    world: ^'w mut dyn LightWorld,
    layout: ColumnLayout,
    slots: [dynamic]Slot,
    // Section key (cx, s, cz) to slot, `NONE` where the chunk isn't lit.
    index: FxHashMap<Pos,
    last: (Pos,
}
Slot :: struct {
    key: Pos,
    // The world's section; its light is the value before this relight.
    section: ^Section,
    light: Option<Box<[u8,
}
NONE :: u32::MAX
    // rust: impl<'w> Region<'w> {
new :: proc(world: ^'w mut dyn LightWorld) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: layout: world.layout(),
    // rust: world,
    // rust: slots: Vec::new(),
    // rust: index: FxHashMap::default(),
    // rust: last: ((i32::MIN, 0, 0), NONE),
}
}
slot :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let s = self.layout.section_index(y)?;
    // rust: let key = (x >> 4, s as i32, z >> 4);
    // rust: if self.last.0 != key {
    // rust: self.last = (key, self.load(key));
}
    // rust: (self.last.1 != NONE).then_some(self.last.1 as usize)
}
load :: proc(self: ^Self, key: Pos) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(&slot) = self.index.get(&key) {
    // rust: return slot;
}
    // rust: let slot = match self.world.section(key.0, key.1 as usize, key.2) {
    // rust: Some(section) => {
    // rust: self.slots.push(Slot {
    // rust: key,
    // rust: section: section.clone(),
    // rust: light: None,
    // rust: });
    // rust: (self.slots.len() - 1) as u32
}
    // rust: None => NONE,
}
    // rust: self.index.insert(key, slot);
    // rust: slot
}
state :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let slot = self.slot(x, y, z)?;
    // rust: Some(self.slots[slot].section.get(index(x, y, z)))
}
    // The one state of the section holding `y`, when it has a single one.
uniform_state :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let slot = self.slot(x, y, z)?;
    // rust: let section = &self.slots[slot].section;
    // rust: (section.blocks.bits() == 0).then(|| section.get(0))
}
    // Packed light (sky << 4 | block), None outside loaded, lit chunks.
light :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let slot = self.slot(x, y, z)?;
    // rust: let slot = &self.slots[slot];
    // rust: let i = index(x, y, z);
    // rust: Some(match &slot.light {
    // rust: Some(light) => light[i],
    // rust: None => slot.section.light(i),
    // rust: })
}
    // State and packed light of a cell, with a single section lookup.
cell :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let slot = self.slot(x, y, z)?;
    // rust: let slot = &self.slots[slot];
    // rust: let i = index(x, y, z);
    // rust: let light = match &slot.light {
    // rust: Some(light) => light[i],
    // rust: None => slot.section.light(i),
}
    // rust: Some((slot.section.get(i), light))
}
    // Rewrite a cell's packed light; nothing outside loaded, lit chunks.
update_light :: proc(self: ^Self, x: i32, y: i32, z: i32, f: impl FnOnce(u8) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let Some(slot) = self.slot(x, y, z) else {
    // rust: return;
}
    // rust: let slot = &mut self.slots[slot];
    // rust: let light = slot
    // rust: .light
    // rust: .get_or_insert_with(|| slot.section.light.to_array());
    // rust: let i = index(x, y, z);
    // rust: light[i] = f(light[i]);
}
    // Store back the light of every section whose values changed.
finish :: proc(self: ^Self) {
}
    // rust: for slot in self.slots {
    // rust: let Some(light) = slot.light else {
    // rust: continue;
}
    // rust: if (0..4096).all(|i| slot.section.light(i) == light[i]) {
    // rust: continue;
}
            // Drop the clone first so the world's section isn't copied.
    // rust: drop(slot.section);
    // rust: let (cx, s, cz) = slot.key;
    // rust: self.world
    // rust: .set_section_light(cx, s as usize, cz, Light::packed(light));
}
}
}
    // rust: type Pos = (i32, i32, i32);
// Changed light by section, as vanilla's light engine reports it to
// `LevelRenderer` (`setSectionDirty`) instead of cell by cell: for each
// section (x, section index, z), a bit per class of position the changed
// cells take in it, `3 * 3 * 3` classes for the low face, the inside and the
// high face of each axis. Meshes sample light one block across a face, so the
// class says which neighbouring sections a change dirties too.
LightChanges :: struct {
    sections: FxHashMap<Pos,
    // The column the section indexes count in.
    layout: ColumnLayout,
}
    // rust: impl LightChanges {
    // Changes in chunks of `layout`: what the relighter or a light job adds
    // after this (they all come from one level).
keyed :: proc(self: ^Self, layout: ColumnLayout) {
}
    // rust: debug_assert!(self.sections.is_empty() || self.layout == layout);
    // rust: self.layout = layout;
}
    // A cell whose stored light changed.
push :: proc(self: ^Self) {
}
    // rust: let key = (x >> 4, (y - self.layout.min_y()) >> 4, z >> 4);
    // rust: *self.sections.entry(key).or_default() |= 1 << Self::class(x, y, z);
}
    // Cells of section `key` (x, section index, z) in the given classes.
add :: proc(self: ^Self, key: Pos, classes: u32) {
}
    // rust: *self.sections.entry(key).or_default() |= classes;
}
    // The class of a cell in its section: per axis 0 on the low face, 1
    // inside, 2 on the high face.
class :: proc(x: i32, y: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let axis = |v: i32| match v & 15 {
    // rust: 0 => 0,
    // rust: 15 => 2,
    // rust: _ => 1,
}
    // rust: axis(x) + 3 * axis(y) + 9 * axis(z)
}
    // The classes (bit `class`) of the cells, in a section's index order (`y << 8 | z << 4 | x`), where `a` and
    // `b` differ.
    // rust: pub fn classes_differing<T: PartialEq>(a: &[T; 4096], b: &[T; 4096]) -> u32 {
    // rust: let mut classes = 0;
        // (a row of 16 along x at a time: the rows alike, most of them, cost one comparison)
    // rust: let (rows_a, rows_b) = (a.as_chunks::<16>().0, b.as_chunks::<16>().0);
    // rust: for (row, (ra, rb)) in rows_a.iter().zip(rows_b).enumerate() {
    // rust: if ra == rb {
    // rust: continue;
}
    // rust: let (y, z) = ((row >> 4) as i32, (row & 15) as i32);
    // rust: for x in 0..16 {
    // rust: if ra[x] != rb[x] {
    // rust: classes |= 1 << Self::class(x as i32, y, z);
}
}
}
    // rust: classes
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sections.is_empty()
}
    // The sections (x, section index, z) holding changed cells.
sections :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.sections.keys().copied()
}
    // Every section (x, section index, z) whose cells lie within one block
    // of a changed cell, section indexes outside the column left out (a
    // section next to several changed ones comes once for each).
dirty_sections :: proc(self: ^Self, mut out: impl FnMut(Pos) {
}
        // Per class, the bit set of neighbour offsets (dx, dy, dz in -1..=1,
        // bit (dx + 1) + 3 (dy + 1) + 9 (dz + 1)) its cells reach.
    // rust: const REACH: [u32; 27] = {
    // rust: let mut reach = [0; 27];
    // rust: let mut class = 0;
    // rust: while class < 27 {
    // rust: let axis = [class % 3, class / 3 % 3, class / 9];
    // rust: let mut offset = 0;
    // rust: while offset < 27 {
    // rust: let d = [offset % 3, offset / 3 % 3, offset / 9];
                    // Every class reaches its own section (d = 1, offset 0);
                    // the low face also -1 (d = 0), the high face +1 (d = 2).
    // rust: if (d[0] == 1 || d[0] == axis[0])
    // rust: && (d[1] == 1 || d[1] == axis[1])
    // rust: && (d[2] == 1 || d[2] == axis[2])
    // rust: {
    // rust: reach[class] |= 1 << offset;
}
    // rust: offset += 1;
}
    // rust: class += 1;
}
    // rust: reach
}
    // rust: let sections = self.layout.sections() as i32;
    // rust: for (&(x, sy, z), &classes) in &self.sections {
    // rust: let mut offsets = 0;
    // rust: let mut rest = classes;
    // rust: while rest != 0 {
    // rust: offsets |= REACH[rest.trailing_zeros() as usize];
    // rust: rest &= rest - 1;
}
    // rust: while offsets != 0 {
    // rust: let o = offsets.trailing_zeros() as i32;
    // rust: offsets &= offsets - 1;
    // rust: let s = sy + o / 3 % 3 - 1;
    // rust: if (0..sections).contains(&s) {
    // rust: out((x + o % 3 - 1, s, z + o / 9 - 1));
}
}
}
}
}
level :: proc(world: ^Region, sky: bool, p: Pos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: world
    // rust: .light(p.0, p.1, p.2)
    // rust: .map(|v| if sky { v >> 4 } else { v & 15 })
}
set_level :: proc(world: ^Region, sky: bool, p: Pos, value: u8) {
}
    // rust: world.update_light(p.0, p.1, p.2, |old| {
    // rust: if sky {
    // rust: (old & 0x0F) | value << 4
    // rust: } else {
    // rust: (old & 0xF0) | value
}
    // rust: });
}
// `ChunkSkyLightSources`: the Y of the upper block of the highest occluded
// edge in the column (every block at or above it is a sky source).
lowest_sky_source :: proc(world: ^Region, tables: ^LightTables, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let (min_y, max_y) = (world.layout.min_y(), world.layout.max_y());
    // rust: let mut y = max_y - 1;
    // rust: let Some(mut top) = world.state(x, y, z) else {
    // rust: return min_y;
}
    // rust: while y > min_y {
        // A section of one state that lets light through itself (the air of
        // a tall column) holds no source edge: go to its bottom block.
    // rust: if let Some(state) = world.uniform_state(x, y - 1, z)
    // rust: && state == top
    // rust: && !tables.edge_occluded(top as usize, top as usize)
    // rust: {
    // rust: y = ((y - 1 - min_y) & !15) + min_y;
    // rust: continue;
}
    // rust: let Some(bottom) = world.state(x, y - 1, z) else {
    // rust: break;
}
    // rust: if tables.edge_occluded(top as usize, bottom as usize) {
    // rust: return y;
}
    // rust: top = bottom;
    // rust: y -= 1;
}
    // rust: min_y
}
// Vanilla's `checkBlock` + `runLightUpdates` for changed positions on
// resident, lit chunks: clear the light that may have come through or from
// the old states (decrease pass), then re-seed sources and propagate back in
// from the brighter boundary (increase pass). Adds every position whose
// stored light changed to `changed`, for remeshing. `force` clears around each position
// as if it had been fully lit, for light computed from outdated blocks.
    // rust: pub fn relight(
    // rust: world: &mut impl LightWorld,
    // rust: tables: &LightTables,
    // rust: sky_light: bool,
    // rust: positions: &[Pos],
    // rust: force: bool,
    // rust: changed: &mut LightChanges,
    // rust: ) {
    // rust: let mut region = Region::new(world);
    // rust: changed.keyed(region.layout);
    // rust: relight_region(&mut region, tables, sky_light, positions, force, changed);
    // rust: region.finish();
}
// The columns `changed` touched that border a loaded column not lit yet
// (`unlit`). `relight` reads and writes only lit columns, so an edit's
// darkening can take away light such a neighbour sends in and never put it
// back, and nothing relights the column when that neighbour's own light
// lands: an air block at 0 beside one at 6 (#2786). Vanilla's light engine
// keeps one light storage for every chunk, so its edits and its chunk
// lighting see each other. These columns need a full light job, which
// lights them from the blocks of their whole 3x3, that neighbour's included.
beside_unlit :: proc(changed: ^LightChanges, unlit: impl Fn(i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut columns: Vec<(i32, i32)> = changed.sections().map(|(x, _, z)| (x, z)).collect();
    // rust: columns.sort_unstable();
    // rust: columns.dedup();
    // rust: columns.retain(|&(x, z)| {
    // rust: (-1..=1).any(|dz| (-1..=1).any(|dx| (dx, dz) != (0, 0) && unlit(x + dx, z + dz)))
    // rust: });
    // rust: columns
}
    // rust: fn relight_region(
    // rust: world: &mut Region,
    // rust: tables: &LightTables,
    // rust: sky_light: bool,
    // rust: positions: &[Pos],
    // rust: force: bool,
    // rust: changed: &mut LightChanges,
    // rust: ) {
    // rust: crate::spans::time("lt_block", || {
    // rust: relight_layer(world, tables, false, positions.to_vec(), force, changed)
    // rust: });
    // rust: if sky_light {
    // rust: let (min_y, max_y) = (world.layout.min_y(), world.layout.max_y());
    // rust: let mut seeds = positions.to_vec();
    // rust: let mut columns: FxHashMap<(i32, i32), i32> = FxHashMap::default();
    // rust: crate::spans::time("lt_columns", || {
    // rust: for &(x, _, z) in positions {
    // rust: if columns.contains_key(&(x, z)) {
    // rust: continue;
}
    // rust: let source = lowest_sky_source(world, tables, x, z);
    // rust: columns.insert((x, z), source);
                // Cells whose source status changed: non-15 at or above the new
                // lowest source, and old 15s (sources) below it.
    // rust: for y in source..max_y {
    // rust: if level(world, true, (x, y, z)).is_some_and(|l| l != 15) {
    // rust: seeds.push((x, y, z));
}
}
    // rust: let mut y = source - 1;
    // rust: while y >= min_y && level(world, true, (x, y, z)) == Some(15) {
    // rust: seeds.push((x, y, z));
    // rust: y -= 1;
}
}
    // rust: });
    // rust: crate::spans::time("lt_sky", || {
    // rust: relight_layer(world, tables, true, seeds, force, changed)
    // rust: });
}
}
    // rust: fn relight_layer(
    // rust: world: &mut Region,
    // rust: tables: &LightTables,
    // rust: sky: bool,
    // rust: seeds: Vec<Pos>,
    // rust: force: bool,
    // rust: changed: &mut LightChanges,
    // rust: ) {
    // rust: let mut decrease: VecDeque<(Pos, u8)> = VecDeque::new();
    // rust: let mut cleared: Vec<Pos> = Vec::new();
    // rust: let mut increase: VecDeque<Pos> = VecDeque::new();
    // rust: for p in seeds {
    // rust: let Some(old) = level(world, sky, p) else {
    // rust: continue;
}
        // `BlockLightEngine.checkNode`: a block emitting at least the light
        // already there keeps it and pulls its neighbours' light in. Clearing
        // it would darken and relight everything it lit (flowing lava next to
        // lava: thousands of cells per block).
    // rust: if !sky && !force && old > 0 {
    // rust: let emission = world
    // rust: .state(p.0, p.1, p.2)
    // rust: .map_or(0, |s| tables.cells[s as usize].emission);
    // rust: if emission >= old {
    // rust: if emission > old {
    // rust: set_level(world, sky, p, emission);
    // rust: changed.push(p);
}
    // rust: decrease.push_back((p, 0));
    // rust: increase.push_back(p);
    // rust: continue;
}
}
    // rust: if old > 0 {
    // rust: set_level(world, sky, p, 0);
    // rust: changed.push(p);
}
    // rust: cleared.push(p);
    // rust: decrease.push_back((p, if force { 15 } else { old }));
}
    // rust: while let Some((p, from)) = decrease.pop_front() {
    // rust: for (ox, oy, oz) in OFFSETS {
    // rust: let q = (p.0 + ox, p.1 + oy, p.2 + oz);
    // rust: let Some(l) = level(world, sky, q) else {
    // rust: continue;
}
    // rust: if l == 0 {
    // rust: continue;
}
            // Sky light runs straight down without loss, so a 15 below a
            // cleared 15 may have come from it too.
    // rust: if l < from || (sky && oy == -1 && l == 15 && from == 15) {
    // rust: set_level(world, sky, q, 0);
    // rust: changed.push(q);
    // rust: cleared.push(q);
    // rust: decrease.push_back((q, l));
    // rust: } else {
    // rust: increase.push_back(q);
}
}
}
    // Sources inside the cleared area light up again.
    // rust: let mut sources: FxHashMap<(i32, i32), i32> = FxHashMap::default();
    // rust: crate::spans::time("lt_sources", || {
    // rust: for p in cleared {
    // rust: let seed = if sky {
    // rust: let lowest = *sources
    // rust: .entry((p.0, p.2))
    // rust: .or_insert_with(|| lowest_sky_source(world, tables, p.0, p.2));
    // rust: if p.1 >= lowest { 15 } else { 0 }
    // rust: } else {
    // rust: world
    // rust: .state(p.0, p.1, p.2)
    // rust: .map_or(0, |s| tables.cells[s as usize].emission)
}
    // rust: if seed > level(world, sky, p).unwrap_or(15) {
    // rust: set_level(world, sky, p, seed);
    // rust: changed.push(p);
    // rust: increase.push_back(p);
}
}
    // rust: });
    // rust: while let Some(p) = increase.pop_front() {
    // rust: let Some((from, packed)) = world.cell(p.0, p.1, p.2) else {
    // rust: continue;
}
    // rust: let l = if sky { packed >> 4 } else { packed & 15 };
    // rust: if l <= 1 {
    // rust: continue;
}
    // rust: for (d, (ox, oy, oz)) in OFFSETS.iter().enumerate() {
    // rust: let q = (p.0 + ox, p.1 + oy, p.2 + oz);
    // rust: let Some((to, packed)) = world.cell(q.0, q.1, q.2) else {
    // rust: continue;
}
    // rust: let ql = if sky { packed >> 4 } else { packed & 15 };
    // rust: let next = l.saturating_sub(tables.cells[to as usize].dampening.max(1));
    // rust: if next > ql && !tables.blocked(from as usize, to as usize, d) {
    // rust: set_level(world, sky, q, next);
    // rust: changed.push(q);
    // rust: increase.push_back(q);
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::chunk::{HEIGHT, MIN_Y, SECTIONS};

changed_cells_dirty_only_the_sections_within_a_block :: proc() {
}
    // rust: let dirty = |cells: &[(usize, usize, usize)]| {
    // rust: let a = [0u8; 4096];
    // rust: let mut b = a;
    // rust: for &(x, y, z) in cells {
    // rust: b[y << 8 | z << 4 | x] = 1;
}
    // rust: let mut changes = LightChanges::default();
    // rust: changes.add((0, 5, 0), LightChanges::classes_differing(&a, &b));
    // rust: let mut out = Vec::new();
    // rust: changes.dirty_sections(|p| out.push(p));
    // rust: out.sort_unstable();
    // rust: out
}
    // rust: assert_eq!(dirty(&[]), Vec::<Pos>::new());
    // rust: assert_eq!(dirty(&[(5, 5, 5), (9, 1, 14)]), vec![(0, 5, 0)]);
    // rust: assert_eq!(dirty(&[(0, 5, 5)]), vec![(-1, 5, 0), (0, 5, 0)]);
    // rust: assert_eq!(
    // rust: dirty(&[(15, 15, 5)]),
    // rust: vec![(0, 5, 0), (0, 6, 0), (1, 5, 0), (1, 6, 0)]
    // rust: );
    // rust: assert_eq!(dirty(&[(0, 0, 0)]).len(), 8);
}

AIR :: 0
STONE :: 1
TORCH :: 2
SLAB :: 3
    // Air, stone, torch and a bottom slab (full bottom face, half sides,
    // empty top), with a third face shape for the half sides.
tables :: proc() -> L {
    // Ported from Horizon
    return {}
}
    // rust: let cell = |dampening, emission, faces: [u16; 6]| Cell {
    // rust: dampening,
    // rust: emission,
    // rust: shaped: faces.iter().any(|f| *f != EMPTY),
    // rust: faces,
}
    // rust: LightTables::from_parts(
    // rust: vec![
    // rust: cell(0, 0, [EMPTY; 6]),
    // rust: cell(15, 0, [FULL; 6]),
    // rust: cell(0, 14, [EMPTY; 6]),
    // rust: cell(0, 0, [FULL, EMPTY, 2, 2, 2, 2]),
    // rust: ],
            // empty, full, half: only pairs with a full face cover the square.
    // rust: vec![false, true, false, true, true, true, false, true, false],
    // rust: 3,
    // rust: )
}
world :: proc(edit: impl Fn(^Chunk) {
}
    // rust: world_of(crate::chunk::ColumnLayout::VANILLA, edit)
}
    // Lit chunks around (0, 0) of `layout`, stone up to y 0.
    // rust: fn world_of(
    // rust: layout: crate::chunk::ColumnLayout,
    // rust: edit: impl Fn(&mut Chunk),
    // rust: ) -> HashMap<(i32, i32), Arc<Chunk>> {
    // rust: let mut chunks = HashMap::new();
    // rust: for z in -1..=1 {
    // rust: for x in -1..=1 {
    // rust: let mut c = Chunk::with_layout(x, z, layout);
    // rust: for y in layout.min_y()..0 {
    // rust: for i in 0..256 {
    // rust: c.set(i & 15, y, i >> 4, STONE);
}
}
    // rust: if (x, z) == (0, 0) {
    // rust: edit(&mut c);
}
    // rust: chunks.insert((x, z), c);
}
}
    // rust: let lit: Vec<_> = chunks
    // rust: .keys()
    // rust: .map(|&(x, z)| {
    // rust: let region: [[Option<&Chunk>; 3]; 3] = std::array::from_fn(|dz| {
    // rust: std::array::from_fn(|dx| chunks.get(&(x + dx as i32 - 1, z + dz as i32 - 1)))
    // rust: });
    // rust: let mut c = chunks[&(x, z)].clone();
    // rust: apply_lighting(&mut c, light_chunk(&region, &tables(), true));
    // rust: c.lit = true;
    // rust: ((x, z), Arc::new(c))
    // rust: })
    // rust: .collect();
    // rust: lit.into_iter().collect()
}
sky :: proc(world: ^HashMap<(i32) {
}
    // rust: world[&(x >> 4, z >> 4)].light(x & 15, y, z & 15) >> 4
}
block :: proc(world: ^HashMap<(i32) {
}
    // rust: world[&(x >> 4, z >> 4)].light(x & 15, y, z & 15) & 15
}

torch_light_falls_off_by_one_per_block :: proc() {
}
    // rust: let w = world(|c| {
    // rust: c.set(8, 0, 8, TORCH);
    // rust: });
    // rust: assert_eq!(block(&w, 8, 0, 8), 14);
    // rust: assert_eq!(block(&w, 9, 0, 8), 13);
    // rust: assert_eq!(block(&w, 8, 3, 8), 11);
    // rust: assert_eq!(block(&w, 8, -1, 8), 0);
}
bottom_slab_takes_sky_from_above_but_not_through_its_bottom :: proc() {
}
        // A slab roof over a closed stone room at y 0..2.
    // rust: let w = world(|c| {
    // rust: for x in 4..13 {
    // rust: for z in 4..13 {
    // rust: c.set(x, 3, z, SLAB);
    // rust: for y in 0..3 {
    // rust: let wall = x == 4 || x == 12 || z == 4 || z == 12;
    // rust: c.set(x, y, z, if wall { STONE } else { AIR });
}
}
}
    // rust: });
    // rust: assert_eq!(
    // rust: sky(&w, 8, 3, 8),
    // rust: 15,
    // rust: "slab cell is lit through its open top"
    // rust: );
        // Without the shape test the room would be lit (slabs have no dampening).
    // rust: assert_eq!(sky(&w, 8, 2, 8), 0, "the full bottom face stops sky light");
}
    // #2786: (1, 0) is loaded but its own light job hasn't landed; (0, 0)
    // was lit from the 3x3's blocks, its torch's light and the far torch's
    // in (1, 0) both. Taking its torch away darkens everything the torch
    // lit, the far torch's light at the border too, and `relight` cannot
    // bring that back from a column it doesn't read. Columns like that are
    // lit again whole; without it the border stays at 0 for good once
    // (1, 0)'s light lands beside it.
an_edit_beside_a_column_not_lit_yet_lights_the_column_again :: proc() {
}
    // rust: let tables = tables();
    // rust: let mut w: HashMap<(i32, i32), Arc<Chunk>> = HashMap::new();
    // rust: for z in -1..=1 {
    // rust: for x in -1..=1 {
    // rust: let mut c = Chunk::empty(x, z);
    // rust: for y in MIN_Y..0 {
    // rust: for i in 0..256 {
    // rust: c.set(i & 15, y, i >> 4, STONE);
}
}
    // rust: if (x, z) == (0, 0) {
    // rust: c.set(14, 0, 8, TORCH);
    // rust: } else if (x, z) == (1, 0) {
    // rust: c.set(6, 0, 8, TORCH);
}
    // rust: w.insert((x, z), Arc::new(c));
}
}
    // rust: let light = |w: &HashMap<(i32, i32), Arc<Chunk>>, (x, z): (i32, i32)| {
    // rust: let region: [[Option<&Chunk>; 3]; 3] = std::array::from_fn(|dz| {
    // rust: std::array::from_fn(|dx| {
    // rust: w.get(&(x + dx as i32 - 1, z + dz as i32 - 1)).map(|c| &**c)
    // rust: })
    // rust: });
    // rust: light_chunk(&region, &tables, true)
}
    // rust: let keys: Vec<_> = w.keys().copied().collect();
    // rust: for key in &keys {
    // rust: let lights = light(&w, *key);
    // rust: let c = Arc::make_mut(w.get_mut(key).unwrap());
    // rust: apply_lighting(c, lights);
    // rust: c.lit = *key != (1, 0);
}
        // The far torch at x 22 gives 7 at x 15; (0, 0)'s own torch gives 13.
    // rust: assert_eq!(block(&w, 15, 0, 8), 13);

    // rust: Arc::make_mut(w.get_mut(&(0, 0)).unwrap()).set(14, 0, 8, AIR);
    // rust: let mut changed = LightChanges::default();
    // rust: relight(&mut w, &tables, true, &[(14, 0, 8)], false, &mut changed);
    // rust: let again = beside_unlit(&changed, |x, z| w.get(&(x, z)).is_some_and(|c| !c.lit));
    // rust: for &key in &again {
    // rust: let lights = light(&w, key);
    // rust: let c = Arc::make_mut(w.get_mut(&key).unwrap());
    // rust: apply_relighting(c, lights, &mut LightChanges::default());
}
        // (1, 0)'s own job lands.
    // rust: let lights = light(&w, (1, 0));
    // rust: let c = Arc::make_mut(w.get_mut(&(1, 0)).unwrap());
    // rust: apply_lighting(c, lights);
    // rust: c.lit = true;
    // rust: assert_eq!(block(&w, 16, 0, 8), 8);
    // rust: assert_eq!(block(&w, 15, 0, 8), 7, "air beside 8 across the border");
    // rust: assert_eq!(block(&w, 14, 0, 8), 6);
    // rust: assert!(again.contains(&(0, 0)), "{again:?}");
}
relight_keeps_unchanged_and_unlit_sections :: proc() {
}
    // rust: let mut w = world(|_| {});
    // rust: Arc::make_mut(w.get_mut(&(1, 0)).unwrap()).lit = false;
    // rust: let before = w.clone();
    // rust: let same = |w: &HashMap<(i32, i32), Arc<Chunk>>, key| {
    // rust: w[&key]
    // rust: .sections
    // rust: .iter()
    // rust: .zip(&before[&key].sections)
    // rust: .all(|(a, b)| Arc::ptr_eq(a, b))
}
        // Cleared and lit back to the same values: nothing is stored.
    // rust: relight(
    // rust: &mut w,
    // rust: &tables(),
    // rust: true,
    // rust: &[(8, 5, 8)],
    // rust: false,
    // rust: &mut LightChanges::default(),
    // rust: );
    // rust: assert!(w.keys().all(|&key| same(&w, key)));
        // Light reaching an unlit chunk isn't written into it.
    // rust: Arc::make_mut(w.get_mut(&(0, 0)).unwrap()).set(15, 0, 8, TORCH);
    // rust: relight(
    // rust: &mut w,
    // rust: &tables(),
    // rust: true,
    // rust: &[(15, 0, 8)],
    // rust: false,
    // rust: &mut LightChanges::default(),
    // rust: );
    // rust: assert!(same(&w, (1, 0)));
    // rust: assert_eq!(block(&w, 14, 0, 8), 13);
}
    // Emitters placed in light at most as bright as theirs (flowing lava
    // next to lava) only brighten: nothing they lit is darkened and lit
    // again, and the result is the full relight's.
emitters_placed_in_their_own_light_only_brighten :: proc() {
}
    // rust: let mut w = world(|c| {
    // rust: c.set(8, 0, 8, TORCH);
    // rust: });
    // rust: let block = |w: &HashMap<(i32, i32), Arc<Chunk>>, p: Pos| {
    // rust: w[&(p.0 >> 4, p.2 >> 4)].light(p.0 & 15, p.1, p.2 & 15) & 15
}
    // rust: for (x, y, z) in [(9, 0, 8), (10, 0, 8), (10, 1, 8), (11, 1, 9), (8, 0, 9)] {
    // rust: let around: Vec<Pos> = (-15..=15)
    // rust: .flat_map(|dx| {
    // rust: (-3..=3).flat_map(move |dy| (-15..=15).map(move |dz| (x + dx, y + dy, z + dz)))
    // rust: })
    // rust: .collect();
    // rust: let before: Vec<u8> = around.iter().map(|&p| block(&w, p)).collect();
    // rust: Arc::make_mut(w.get_mut(&(0, 0)).unwrap()).set(x, y, z, TORCH);
    // rust: let mut changed = LightChanges::default();
    // rust: relight(&mut w, &tables(), true, &[(x, y, z)], false, &mut changed);
    // rust: for (&p, &was) in around.iter().zip(&before) {
    // rust: assert!(block(&w, p) >= was, "{p:?} darkened from {was}");
}
}
        // An emitter checked again with its block light unchanged changes
        // nothing, so no section is remeshed.
    // rust: let mut changed = LightChanges::default();
    // rust: relight(&mut w, &tables(), false, &[(8, 0, 8)], false, &mut changed);
    // rust: assert!(changed.is_empty());
    // rust: let region: [[Option<&Chunk>; 3]; 3] = std::array::from_fn(|dz| {
    // rust: std::array::from_fn(|dx| w.get(&(dx as i32 - 1, dz as i32 - 1)).map(|c| &**c))
    // rust: });
    // rust: for (si, s) in light_chunk(&region, &tables(), true).iter().enumerate() {
    // rust: for i in 0..4096 {
    // rust: assert_eq!(
    // rust: s.get(i),
    // rust: w[&(0, 0)].sections[si].light(i),
    // rust: "section {si} index {i}"
    // rust: );
}
}
}
random_border_relights_match_full_relight :: proc() {
}
        // Edits around every border of chunk (0, 0), at the top and bottom of
        // the world, in batches; a held clone of the chunk must not change.
    // rust: let mut w = world(|_| {});
    // rust: let held = w[&(0, 0)].clone();
    // rust: let mut rng = 0x9e37_79b9_u32;
    // rust: let mut next = |n: usize| {
    // rust: rng ^= rng << 13;
    // rust: rng ^= rng >> 17;
    // rust: rng ^= rng << 5;
    // rust: rng as usize % n
}
    // rust: let xz = [-2, -1, 0, 1, 7, 14, 15, 16, 17];
    // rust: let ys = [
    // rust: MIN_Y,
    // rust: MIN_Y + 1,
    // rust: -2,
    // rust: -1,
    // rust: 0,
    // rust: 1,
    // rust: 15,
    // rust: 16,
    // rust: MIN_Y + HEIGHT - 2,
    // rust: MIN_Y + HEIGHT - 1,
    // rust: ];
    // rust: for _ in 0..60 {
    // rust: let positions: Vec<Pos> = (0..1 + next(6))
    // rust: .map(|_| (xz[next(xz.len())], ys[next(ys.len())], xz[next(xz.len())]))
    // rust: .collect();
    // rust: for &(x, y, z) in &positions {
    // rust: let state = [TORCH, SLAB, AIR, STONE][next(4)];
    // rust: Arc::make_mut(w.get_mut(&(x >> 4, z >> 4)).unwrap()).set(x & 15, y, z & 15, state);
}
    // rust: relight(
    // rust: &mut w,
    // rust: &tables(),
    // rust: true,
    // rust: &positions,
    // rust: false,
    // rust: &mut LightChanges::default(),
    // rust: );
}
        // Every chunk, the outer ring lit as `world` lit it (no neighbours
        // past the 3x3).
    // rust: for (&(cx, cz), chunk) in &w {
    // rust: let region: [[Option<&Chunk>; 3]; 3] = std::array::from_fn(|dz| {
    // rust: std::array::from_fn(|dx| {
    // rust: w.get(&(cx + dx as i32 - 1, cz + dz as i32 - 1))
    // rust: .map(|c| &**c)
    // rust: })
    // rust: });
    // rust: for (si, s) in light_chunk(&region, &tables(), true).iter().enumerate() {
    // rust: for i in 0..4096 {
    // rust: assert_eq!(
    // rust: s.get(i),
    // rust: chunk.sections[si].light(i),
    // rust: "chunk {cx},{cz} section {si} index {i}"
    // rust: );
}
}
}
    // rust: let fresh = world(|_| {});
    // rust: for (a, b) in held.sections.iter().zip(&fresh[&(0, 0)].sections) {
    // rust: assert!((0..4096).all(|i| a.light(i) == b.light(i)));
}
}
a_tall_column_is_lit_to_its_top :: proc() {
}
    // rust: let layout = crate::chunk::ColumnLayout::new(-64, 2096).unwrap();
    // rust: let mut chunk = Chunk::with_layout(0, 0, layout);
    // rust: for i in 0..256 {
    // rust: chunk.set(i & 15, 1600, i >> 4, STONE);
}
    // rust: chunk.set(8, 1500, 8, TORCH);
    // rust: let region = [[None; 3], [None, Some(&chunk), None], [None; 3]];
    // rust: let lights = light_chunk(&region, &tables(), true);
    // rust: assert_eq!(lights.len(), 131);
    // rust: apply_lighting(&mut chunk, lights);
    // rust: assert_eq!(chunk.light(8, 1500, 8) & 15, 14);
    // rust: assert_eq!(chunk.light(8, 1501, 8) & 15, 13);
    // rust: assert_eq!(chunk.light(8, 1601, 8) >> 4, 15);
    // rust: assert_eq!(chunk.light(8, 1599, 8) >> 4, 0, "under the roof");
    // rust: assert_eq!(chunk.light(8, 2031, 8), 0xF0);
        // The empty sections above are one shared allocation.
    // rust: let top = chunk.sections.len() - 1;
    // rust: assert!(Arc::ptr_eq(&chunk.sections[top], &chunk.sections[top - 10]));
    // rust: let other = Chunk::with_layout(1, 0, layout);
    // rust: apply_lighting(&mut other.clone(), vec![Light::Uniform(0xF0); 131]);
    // rust: let mut lit = other.clone();
    // rust: apply_lighting(&mut lit, vec![Light::Uniform(0xF0); 131]);
    // rust: assert!(Arc::ptr_eq(&chunk.sections[top], &lit.sections[top]));
}
a_tall_column_relights_as_its_full_light_and_keys_its_sections :: proc() {
}
    // rust: let layout = crate::chunk::ColumnLayout::new(-64, 2096).unwrap();
    // rust: let mut w = world_of(layout, |c| {
    // rust: for i in 0..256 {
    // rust: c.set(i & 15, 1900, i >> 4, STONE);
}
    // rust: });
    // rust: let edits = [
    // rust: ((8, 1800, 8), TORCH),
    // rust: ((8, 1900, 8), AIR),
    // rust: ((3, 2020, 3), TORCH),
    // rust: ];
    // rust: let mut changed = LightChanges::default();
    // rust: for ((x, y, z), state) in edits {
    // rust: Arc::make_mut(w.get_mut(&(0, 0)).unwrap()).set(x, y, z, state);
    // rust: relight(&mut w, &tables(), true, &[(x, y, z)], false, &mut changed);
}
    // rust: let region: [[Option<&Chunk>; 3]; 3] = std::array::from_fn(|dz| {
    // rust: std::array::from_fn(|dx| w.get(&(dx as i32 - 1, dz as i32 - 1)).map(|c| &**c))
    // rust: });
    // rust: let full = light_chunk(&region, &tables(), true);
    // rust: assert_eq!(full.len(), 131);
    // rust: for (si, s) in full.iter().enumerate() {
    // rust: for i in 0..4096 {
    // rust: assert_eq!(
    // rust: s.get(i),
    // rust: w[&(0, 0)].sections[si].light(i),
    // rust: "section {si} index {i}"
    // rust: );
}
}
        // y 2020 is section 130 of the tall column, the top one.
    // rust: assert!(
    // rust: changed
    // rust: .sections()
    // rust: .any(|(x, sy, z)| (x, sy, z) == (0, 130, 0))
    // rust: );
    // rust: let mut dirty = Vec::new();
    // rust: changed.dirty_sections(|s| dirty.push(s.1));
    // rust: assert!(dirty.iter().all(|&sy| (0..131).contains(&sy)), "{dirty:?}");
}
incremental_relight_matches_full_relight :: proc() {
}
    // rust: let mut w = world(|c| {
    // rust: c.set(8, 0, 8, TORCH);
    // rust: });
    // rust: let edits = [
    // rust: ((8, 0, 8), AIR),
    // rust: ((9, 1, 8), STONE),
    // rust: ((3, 2, 3), TORCH),
    // rust: ((8, 5, 8), SLAB),
    // rust: ((8, -1, 8), AIR),
    // rust: ];
    // rust: for ((x, y, z), state) in edits {
    // rust: Arc::make_mut(w.get_mut(&(0, 0)).unwrap()).set(x, y, z, state);
    // rust: relight(
    // rust: &mut w,
    // rust: &tables(),
    // rust: true,
    // rust: &[(x, y, z)],
    // rust: false,
    // rust: &mut LightChanges::default(),
    // rust: );
}
    // rust: let region: [[Option<&Chunk>; 3]; 3] = std::array::from_fn(|dz| {
    // rust: std::array::from_fn(|dx| w.get(&(dx as i32 - 1, dz as i32 - 1)).map(|c| &**c))
    // rust: });
    // rust: let full = light_chunk(&region, &tables(), true);
    // rust: for (si, s) in full.iter().enumerate() {
    // rust: for i in 0..4096 {
    // rust: assert_eq!(
    // rust: s.get(i),
    // rust: w[&(0, 0)].sections[si].light(i),
    // rust: "section {si} index {i}"
    // rust: );
}
}
}
lighting_result_preserves_current_edits_and_snapshots :: proc() {
}
    // rust: let mut current = Chunk::empty(0, 0);
    // rust: current.set(8, MIN_Y, 8, TORCH);
    // rust: let region = [[None; 3], [None, Some(&current), None], [None; 3]];
    // rust: let lights = light_chunk(&region, &tables(), true);
    // rust: let storage = |light: &Light| match light {
    // rust: Light::Full(data) => data.as_ptr(),
    // rust: Light::Sky(layer, _) | Light::Block(layer, _) => layer.as_ptr(),
    // rust: Light::Uniform(_) => panic!("torch light varies"),
}
    // rust: let result_storage = storage(&lights[0]);
    // rust: let snapshot = current.clone();
    // rust: current.set(8, MIN_Y, 8, STONE);
    // rust: Arc::make_mut(&mut current.sections[0]).biomes.set(0, 3);
    // rust: let edited_snapshot = current.clone();
    // rust: apply_lighting(&mut current, lights);
    // rust: assert_eq!(
    // rust: result_storage,
    // rust: storage(&current.sections[0].light),
    // rust: "returned light storage moves without cloning"
    // rust: );
    // rust: current.lit = true;
    // rust: assert_eq!(current.get(8, MIN_Y, 8), STONE);
    // rust: assert_eq!(current.sections[0].biomes.get(0), 3);
    // rust: assert_eq!(snapshot.get(8, MIN_Y, 8), TORCH);
    // rust: assert_eq!(edited_snapshot.sections[0].light(index(8, MIN_Y, 8)), 0xF0);
    // rust: let mut world = HashMap::from([((0, 0), Arc::new(current))]);
        // Streaming replays edits made after the job snapshot with force=true.
    // rust: let mut changed = LightChanges::default();
    // rust: relight(
    // rust: &mut world,
    // rust: &tables(),
    // rust: true,
    // rust: &[(8, MIN_Y, 8)],
    // rust: true,
    // rust: &mut changed,
    // rust: );
    // rust: assert!(!changed.is_empty());
    // rust: let region = [[None; 3], [None, Some(&*world[&(0, 0)]), None], [None; 3]];
    // rust: let fresh = light_chunk(&region, &tables(), true);
    // rust: for (section, light) in world[&(0, 0)].sections.iter().zip(fresh) {
    // rust: for i in 0..4096 {
    // rust: assert_eq!(section.light(i), light.get(i));
}
}
}

relighting_reports_exactly_the_changed_positions :: proc() {
}
    // rust: let mut chunk = Chunk::empty(1, -1);
    // rust: chunk.set(3, MIN_Y + 20, 5, TORCH);
    // rust: let lit = |c: &Chunk| {
    // rust: let region = [[None; 3], [None, Some(c), None], [None; 3]];
    // rust: light_chunk(&region, &tables(), true)
}
    // rust: let light = lit(&chunk);
    // rust: apply_lighting(&mut chunk, light);
    // rust: let sections: Vec<_> = chunk.sections.iter().map(Arc::as_ptr).collect();
        // The same light again: nothing changes and no section is copied.
    // rust: let light = lit(&chunk);
    // rust: let mut changed = LightChanges::default();
    // rust: apply_relighting(&mut chunk, light, &mut changed);
    // rust: assert!(changed.is_empty());
    // rust: assert_eq!(
    // rust: sections,
    // rust: chunk.sections.iter().map(Arc::as_ptr).collect::<Vec<_>>()
    // rust: );
    // rust: let before = chunk.clone();
    // rust: chunk.set(3, MIN_Y + 20, 5, STONE);
    // rust: let light = lit(&chunk);
    // rust: apply_relighting(&mut chunk, light, &mut changed);
    // rust: let mut expected = LightChanges::default();
    // rust: for (sy, (old, new)) in before.sections.iter().zip(&chunk.sections).enumerate() {
    // rust: for i in 0..4096 {
    // rust: if old.light(i) != new.light(i) {
    // rust: let (x, y, z) = (i as i32 & 15, (i >> 8) as i32, (i >> 4) as i32 & 15);
    // rust: expected.push((16 + x, MIN_Y + sy as i32 * 16 + y, -16 + z));
}
}
}
    // rust: assert!(!expected.is_empty());
    // rust: assert_eq!(changed, expected);
        // Only the torch's section and the two it lights into are copied.
    // rust: let copied = sections
    // rust: .iter()
    // rust: .zip(&chunk.sections)
    // rust: .filter(|(old, new)| **old != Arc::as_ptr(new))
    // rust: .count();
    // rust: assert!(copied <= 3, "{copied} sections copied");
}

changes_dirty_the_sections_within_a_block_of_each_cell :: proc() {
}
        // Cells inside sections, on each face and corner, at the bottom and
        // top of the world, on negative coordinates.
    // rust: let mut cells = Vec::new();
    // rust: for x in [-17, -16, -1, 0, 7, 15, 16, 31] {
    // rust: for y in [
    // rust: MIN_Y,
    // rust: MIN_Y + 15,
    // rust: MIN_Y + 16,
    // rust: 70,
    // rust: 79,
    // rust: 80,
    // rust: MIN_Y + HEIGHT - 1,
    // rust: ] {
    // rust: for z in [-33, -32, 5, 15] {
    // rust: cells.push((x, y, z));
}
}
}
    // rust: for n in [1, 2, cells.len()] {
    // rust: for start in 0..cells.len().min(8) {
    // rust: let some: Vec<Pos> = cells.iter().copied().cycle().skip(start).take(n).collect();
    // rust: let mut changes = LightChanges::default();
    // rust: some.iter().for_each(|&c| changes.push(c));
    // rust: let mut dirty = std::collections::BTreeSet::new();
    // rust: changes.dirty_sections(|s| {
    // rust: dirty.insert(s);
    // rust: });
    // rust: let mut expected = std::collections::BTreeSet::new();
    // rust: for &(x, y, z) in &some {
    // rust: for (dx, dy, dz) in (-1..=1)
    // rust: .flat_map(|a| (-1..=1).flat_map(move |b| (-1..=1).map(move |c| (a, b, c))))
    // rust: {
    // rust: let s = (y + dy - MIN_Y) >> 4;
    // rust: if (0..SECTIONS as i32).contains(&s) {
    // rust: expected.insert(((x + dx) >> 4, s, (z + dz) >> 4));
}
}
}
    // rust: assert_eq!(dirty, expected, "{some:?}");
    // rust: let sections: std::collections::BTreeSet<_> = changes.sections().collect();
    // rust: let own: std::collections::BTreeSet<_> = some
    // rust: .iter()
    // rust: .map(|&(x, y, z)| (x >> 4, (y - MIN_Y) >> 4, z >> 4))
    // rust: .collect();
    // rust: assert_eq!(sections, own);
}
}
}

stored_layers_fill_the_column_as_vanilla_reads_them :: proc() {
}
        // Section 10's sky layer is 7 on its bottom row and 3 above; no
        // layers anywhere else; a block layer of 5 in section 2.
    // rust: let mut sky = vec![0x33u8; 2048];
    // rust: sky[..128].fill(0x77);
    // rust: let mut layers: Vec<(Option<Vec<u8>>, Option<Vec<u8>>)> = vec![(None, None); SECTIONS];
    // rust: layers[10].0 = Some(sky);
    // rust: layers[2].1 = Some(vec![0x55; 2048]);
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: light_from_layers(&mut chunk, &layers, [15; 256], true);
    // rust: let at = |c: &Chunk, si: usize, i: usize| c.sections[si].light(i);
    // rust: assert!(chunk.lit && chunk.light_loaded);
    // rust: assert!(
    // rust: matches!(chunk.sections[11].light, Light::Uniform(0xF0)),
    // rust: "above: open sky"
    // rust: );
    // rust: assert_eq!((at(&chunk, 10, 0), at(&chunk, 10, 4095)), (0x70, 0x30));
        // Below, each section repeats the bottom row of the stored one above.
    // rust: assert!(matches!(chunk.sections[9].light, Light::Uniform(0x70)));
    // rust: assert_eq!(at(&chunk, 2, 100), 0x75, "block light only where stored");
    // rust: assert!(matches!(chunk.sections[0].light, Light::Uniform(0x70)));

        // A light update replaces one kind of light in the sections it names.
    // rust: let mut update: Vec<(Option<Vec<u8>>, Option<Vec<u8>>)> = vec![(None, None); SECTIONS];
    // rust: update[2].1 = Some(vec![0; 2048]);
    // rust: update[3].0 = Some(vec![0x77; 2048]);
    // rust: let changed = update_light_layers(&mut chunk, &update, true);
    // rust: assert_eq!(changed, vec![2]);
    // rust: assert!(matches!(chunk.sections[2].light, Light::Uniform(0x70)));
    // rust: update[3].0 = Some(vec![0xFF; 2048]);
    // rust: assert_eq!(
    // rust: update_light_layers(&mut chunk, &update, false),
    // rust: Vec::<usize>::new(),
    // rust: "no sky storage"
    // rust: );
}

empty_chunk_missing_neighbours_and_no_sky :: proc() {
}
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for sky in [false, true] {
    // rust: let region = [[None; 3], [None, Some(&chunk), None], [None; 3]];
    // rust: let lights = light_chunk(&region, &tables(), sky);
    // rust: assert_eq!(lights.len(), SECTIONS);
    // rust: assert!(
    // rust: lights
    // rust: .iter()
    // rust: .all(|v| matches!(v, Light::Uniform(n) if *n == if sky { 0xF0 } else { 0 }))
    // rust: );
    // rust: apply_lighting(&mut chunk, lights);
            // Uniform sections are one shared allocation (`share_uniform`).
    // rust: let first = &chunk.sections[0];
    // rust: assert!(chunk.sections.iter().all(|s| Arc::ptr_eq(s, first)));
}
}

    // Original main's worker packaging and streaming application. Kept here
    // so the benchmark compares the real former copy/compaction work.
    // rust: fn baseline_pack(
    // rust: center: &Chunk,
    // rust: h: usize,
    // rust: sky: &[u8],
    // rust: block: &[u8],
    // rust: ) -> Vec<Arc<crate::chunk::Section>> {
    // rust: let at = |x: usize, y: usize, z: usize| (y * W + z) * W + x;
    // rust: let mut sections = Vec::with_capacity(SECTIONS);
    // rust: for (si, section) in center.sections.iter().enumerate() {
    // rust: let mut out = (**section).clone();
    // rust: if si * 16 >= h {
    // rust: out.light = Light::Uniform(0xF0);
    // rust: } else {
    // rust: let mut data = Box::new([0u8; 4096]);
    // rust: for ly in 0..16 {
    // rust: let y = si * 16 + ly;
    // rust: if y >= h {
    // rust: for i in 0..256 {
    // rust: data[ly << 8 | i] = 0xF0;
}
    // rust: continue;
}
    // rust: for lz in 0..16 {
    // rust: for lx in 0..16 {
    // rust: let p = at(16 + lx, y, 16 + lz);
    // rust: data[index(lx as i32, ly as i32, lz as i32)] = sky[p] << 4 | block[p];
}
}
}
    // rust: out.light = Light::Full(data);
}
    // rust: out.compact();
    // rust: sections.push(Arc::new(out));
}
    // rust: sections
}
baseline_apply :: proc(chunk: ^Chunk, sections: [dynamic]^crate::chunk::Section) {
}
    // rust: for (target, lit) in chunk.sections.iter_mut().zip(sections) {
    // rust: let mut section = (**target).clone();
    // rust: section.light = lit.light.clone();
    // rust: *target = Arc::new(section);
}
}

benchmark_worker_light_results :: proc() {
}
//         use std::{hint::black_box, time::Instant};
    // rust: let mut fixture = Chunk::empty(0, 0);
    // rust: for (si, s) in fixture.sections.iter_mut().enumerate() {
    // rust: let section = Arc::make_mut(s);
    // rust: for i in 0..4096 {
    // rust: section.set(i, ((i + si) % 16) as u32);
}
    // rust: for i in 0..64 {
    // rust: section.biomes.set(i, (i % 4) as u32);
}
    // rust: section.light = Light::Full(Box::new([0x87; 4096]));
}
    // rust: let h = HEIGHT as usize;
    // rust: let sky: Vec<_> = (0..W * W * h).map(|i| (i % 16) as u8).collect();
    // rust: let block: Vec<_> = (0..W * W * h).map(|i| ((i / 16) % 16) as u8).collect();
    // rust: let mut old = fixture.clone();
    // rust: let mut new = fixture.clone();
    // rust: baseline_apply(&mut old, baseline_pack(&fixture, h, &sky, &block));
    // rust: apply_lighting(&mut new, pack_lighting(SECTIONS, h, &sky, &block, true));
    // rust: for (a, b) in old.sections.iter().zip(&new.sections) {
    // rust: for i in 0..4096 {
    // rust: assert_eq!(a.light(i), b.light(i));
    // rust: assert_eq!(a.get(i), b.get(i));
}
    // rust: for i in 0..64 {
    // rust: assert_eq!(a.biomes.get(i), b.biomes.get(i));
}
}
    // rust: for shared in [false, true] {
    // rust: let mut times = [Vec::new(), Vec::new()];
    // rust: for round in 0..11 {
    // rust: for optimized in [round % 2 == 0, round % 2 != 0] {
    // rust: let mut current = fixture.clone();
    // rust: let held = shared.then(|| current.clone());
                    // Warm up and detach for the uniquely-owned scenario.
    // rust: apply_lighting(&mut current, pack_lighting(SECTIONS, h, &sky, &block, true));
    // rust: let started = Instant::now();
    // rust: for _ in 0..500 {
    // rust: let retained = shared.then(|| current.clone());
    // rust: if optimized {
    // rust: apply_lighting(
    // rust: black_box(&mut current),
    // rust: pack_lighting(
    // rust: SECTIONS,
    // rust: h,
    // rust: black_box(&sky),
    // rust: black_box(&block),
    // rust: true,
    // rust: ),
    // rust: );
    // rust: } else {
    // rust: baseline_apply(
    // rust: black_box(&mut current),
    // rust: baseline_pack(
    // rust: black_box(&fixture),
    // rust: h,
    // rust: black_box(&sky),
    // rust: black_box(&block),
    // rust: ),
    // rust: );
}
    // rust: black_box(retained);
    // rust: black_box(&current);
}
    // rust: if round > 0 {
    // rust: times[usize::from(optimized)]
    // rust: .push(started.elapsed().as_secs_f64() * 1e6 / 500.0);
}
    // rust: black_box(held);
}
}
    // rust: for values in &mut times {
    // rust: values.sort_by(f64::total_cmp);
}
    // rust: println!(
    // rust: "pack+apply shared={shared}: baseline {:.3} us optimized {:.3} us speedup {:.2}x",
    // rust: times[0][5],
    // rust: times[1][5],
    // rust: times[0][5] / times[1][5]
    // rust: );
}
    // rust: let payload: usize = fixture.sections.iter().map(|s| s.heap_bytes()).sum();
    // rust: println!(
    // rust: "fixture heap payload {payload} bytes; old worker clones it plus 24 section Arcs; old application clones current payload and 98304 returned light bytes. New worker clones zero section payload; new application clones current payload only when shared."
    // rust: );
}
    // Relight cost for torches placed and removed near chunk borders with
    // slabs flickering around them (fluids next to lava, in the game).
    // `cargo test --profile fast -p horizon-client relight_bench -- --ignored --nocapture`
relight_bench :: proc() {
}
    // rust: let mut w: FxHashMap<_, _> = world(|_| {}).into_iter().collect();
    // rust: let t = tables();
    // rust: let mut rng = 0x2545_f491_u32;
    // rust: let mut next = |n: i32| {
    // rust: rng ^= rng << 13;
    // rust: rng ^= rng >> 17;
    // rust: rng ^= rng << 5;
    // rust: (rng % n as u32) as i32
}
    // rust: let start = std::time::Instant::now();
    // rust: let mut changed = LightChanges::default();
    // rust: for round in 0..400 {
    // rust: let state = [TORCH, SLAB, AIR][round % 3];
    // rust: let positions: Vec<Pos> = (0..32)
    // rust: .map(|_| (next(32) - 8, next(12), next(32) - 8))
    // rust: .collect();
    // rust: for &(x, y, z) in &positions {
    // rust: Arc::make_mut(w.get_mut(&(x >> 4, z >> 4)).unwrap()).set(x & 15, y, z & 15, state);
}
    // rust: relight(&mut w, &t, true, &positions, false, &mut changed);
}
    // rust: println!(
    // rust: "relight_bench: {:?}, {} sections",
    // rust: start.elapsed(),
    // rust: changed.sections().count()
    // rust: );
}

benchmark_light_chunk :: proc() {
}
//         use std::time::Instant;
    // rust: let t = tables();
    // rust: let layout = ColumnLayout::VANILLA;
    // rust: let mut chunks = Vec::new();
    // rust: for cz in -1..=1 {
    // rust: for cx in -1..=1 {
    // rust: let mut c = Chunk::with_layout(cx, cz, layout);
    // rust: for y in layout.min_y()..64 {
    // rust: for i in 0..256 {
    // rust: c.set(i & 15, y, i >> 4, STONE);
}
}
    // rust: for x in 2..14 {
    // rust: for z in 2..14 {
    // rust: c.set(x, 64, z, SLAB);
}
}
    // rust: c.set(8, 65, 8, TORCH);
    // rust: c.set(4, 30, 4, TORCH);
    // rust: chunks.push(c);
}
}
    // rust: let region = [
    // rust: [Some(&chunks[0]), Some(&chunks[1]), Some(&chunks[2])],
    // rust: [Some(&chunks[3]), Some(&chunks[4]), Some(&chunks[5])],
    // rust: [Some(&chunks[6]), Some(&chunks[7]), Some(&chunks[8])],
    // rust: ];

    // rust: for _ in 0..5 {
    // rust: let _ = light_chunk(&region, &t, true);
}

    // rust: let start = Instant::now();
    // rust: let iters = 200;
    // rust: for _ in 0..iters {
    // rust: let _ = std::hint::black_box(light_chunk(std::hint::black_box(&region), &t, true));
}
    // rust: let elapsed = start.elapsed();
    // rust: println!(
    // rust: "benchmark_light_chunk: {:?} total, {:.2} µs/chunk",
    // rust: elapsed,
    // rust: elapsed.as_micros() as f64 / iters as f64
    // rust: );
}

scratch_queues_shrink_above_capacity_cap :: proc() {
}
    // rust: let mut scratch = LightScratch::new();
    // rust: scratch.queue.resize(100_000, 0);
    // rust: scratch.sky_queue.resize(100_000, 0);
    // rust: assert!(scratch.queue.capacity() >= 100_000);
    // rust: assert!(scratch.sky_queue.capacity() >= 100_000);
    // rust: scratch.clear_queues();
    // rust: assert_eq!(scratch.queue.len(), 0);
    // rust: assert_eq!(scratch.sky_queue.len(), 0);
    // rust: assert!(scratch.queue.capacity() < 100_000);
    // rust: assert!(scratch.sky_queue.capacity() < 100_000);
}

    // The baseline flood-fill lighting algorithm before the scratch and wavefront optimizations.
    // rust: fn old_light_chunk(
    // rust: region: &[[Option<&Chunk>; 3]; 3],
    // rust: tables: &LightTables,
    // rust: sky_light: bool,
    // rust: ) -> Vec<Light> {
    // rust: let sections = region[1][1].expect("centre chunk").sections.len();
    // rust: let mut top_section = 0;
    // rust: for chunk in region.iter().flatten().flatten() {
    // rust: for (i, s) in chunk.sections.iter().enumerate().rev() {
    // rust: if !s.is_uniform(0) {
    // rust: top_section = top_section.max(i + 1);
    // rust: break;
}
}
}
    // rust: let h = ((top_section + 1) * 16).min(sections * 16);
    // rust: let at = |x: usize, y: usize, z: usize| (y * W + z) * W + x;
    // rust: let mut states = vec![0u16; W * W * h];
    // rust: let mut sky = vec![0u8; W * W * h];
    // rust: let mut block = vec![0u8; W * W * h];
    // rust: let mut queue = VecDeque::new();
    // rust: let mut sky_queue = VecDeque::new();
    // rust: let mut ids = Box::new([0u32; 4096]);
    // rust: for (dz, row) in region.iter().enumerate() {
    // rust: for (dx, chunk) in row.iter().enumerate() {
    // rust: let Some(chunk) = chunk else { continue };
    // rust: for (si, section) in chunk.sections.iter().enumerate().take(top_section) {
    // rust: if section.is_uniform(0) {
    // rust: continue;
}
    // rust: section.unpack(&mut ids);
    // rust: for (i, &id) in ids.iter().enumerate() {
    // rust: let (lx, lz, ly) = (i & 15, (i >> 4) & 15, i >> 8);
    // rust: let p = at(dx * 16 + lx, si * 16 + ly, dz * 16 + lz);
    // rust: let info = tables.info[id as usize];
    // rust: states[p] = info as u16;
    // rust: let emission = info >> 16;
    // rust: if emission > 0 {
    // rust: block[p] = emission as u8;
    // rust: queue.push_back(p as u32);
}
}
}
}
}
    // rust: let mut present = vec![false; W * W];
    // rust: for z in 0..W {
    // rust: for x in 0..W {
    // rust: present[z * W + x] = region[z / 16][x / 16].is_some();
}
}
    // rust: let mut lowest = vec![h as i32; W * W];
    // rust: let old_packed_edge_occluded = |top: u16, bottom: u16| -> bool {
    // rust: bottom & 0xF != 0 || tables.packed_blocked(top, bottom, Direction::Down as usize)
}
    // rust: for z in 0..W {
    // rust: for x in 0..W {
    // rust: if !present[z * W + x] || !sky_light {
    // rust: continue;
}
    // rust: let mut y = h as i32 - 1;
    // rust: sky[at(x, y as usize, z)] = 15;
    // rust: while y > 0
    // rust: && !old_packed_edge_occluded(
    // rust: states[at(x, y as usize, z)],
    // rust: states[at(x, y as usize - 1, z)],
    // rust: )
    // rust: {
    // rust: y -= 1;
    // rust: sky[at(x, y as usize, z)] = 15;
}
    // rust: lowest[z * W + x] = y;
}
}
    // rust: for z in 0..W {
    // rust: for x in 0..W {
    // rust: if !present[z * W + x] || !sky_light {
    // rust: continue;
}
    // rust: let own = lowest[z * W + x];
    // rust: let mut deepest = own;
    // rust: for (nx, nz) in [
    // rust: (x.wrapping_sub(1), z),
    // rust: (x + 1, z),
    // rust: (x, z.wrapping_sub(1)),
    // rust: (x, z + 1),
    // rust: ] {
    // rust: if nx < W && nz < W && present[nz * W + nx] {
    // rust: deepest = deepest.max(lowest[nz * W + nx]);
}
}
    // rust: let from = own.max(0) as usize;
    // rust: let to = (deepest as usize).min(h.saturating_sub(1));
    // rust: for y in from..=to {
    // rust: if sky[at(x, y, z)] == 15 {
    // rust: sky_queue.push_back(at(x, y, z) as u32);
}
}
}
}
    // rust: let spread = |light: &mut [u8], queue: &mut VecDeque<u32>| {
    // rust: while let Some(p) = queue.pop_front() {
    // rust: let p = p as usize;
    // rust: let level = light[p];
    // rust: if level <= 1 {
    // rust: continue;
}
    // rust: let x = p % W;
    // rust: let z = (p / W) % W;
    // rust: let y = p / (W * W);
    // rust: let from = states[p];
    // rust: let col = z * W + x;
    // rust: macro_rules! neighbour {
    // rust: ($d:expr, $q:expr, $ncol:expr) => {{
    // rust: if present[$ncol] {
    // rust: let q = $q;
    // rust: let to = states[q];
    // rust: let next = level.saturating_sub((to & 0xF).max(1) as u8);
    // rust: if next > light[q] && !tables.packed_blocked(from, to, $d) {
    // rust: light[q] = next;
    // rust: queue.push_back(q as u32);
}
}
    // rust: }};
}
    // rust: if y > 0 {
    // rust: neighbour!(0, p - W * W, col);
}
    // rust: if y + 1 < h {
    // rust: neighbour!(1, p + W * W, col);
}
    // rust: if z > 0 {
    // rust: neighbour!(2, p - W, col - W);
}
    // rust: if z + 1 < W {
    // rust: neighbour!(3, p + W, col + W);
}
    // rust: if x > 0 {
    // rust: neighbour!(4, p - 1, col - 1);
}
    // rust: if x + 1 < W {
    // rust: neighbour!(5, p + 1, col + 1);
}
}
}
    // rust: spread(&mut sky, &mut sky_queue);
    // rust: spread(&mut block, &mut queue);
    // rust: pack_lighting(sections, h, &sky, &block, sky_light)
}

light_chunk_matches_old_algorithm :: proc() {
}
    // rust: let t = tables();
    // rust: let layout = ColumnLayout::VANILLA;

    // rust: let mut rng = 0x1234_5678_u64;
    // rust: let mut next = |max: usize| -> usize {
    // rust: rng = rng.wrapping_mul(6364136223846793005).wrapping_add(1);
    // rust: ((rng >> 32) as usize) % max
}

    // rust: let cases = [
            // (sky_light, missing_pattern)
            // 0 = full 3x3
            // 1 = missing corners
            // 2 = missing edges
            // 3 = random missing neighbours
            // 4 = only centre and single neighbour
    // rust: (true, 0),
    // rust: (false, 0),
    // rust: (true, 1),
    // rust: (false, 1),
    // rust: (true, 2),
    // rust: (false, 2),
    // rust: (true, 3),
    // rust: (false, 3),
    // rust: (true, 4),
    // rust: (false, 4),
    // rust: ];

    // rust: for (round, &(sky_light, pattern)) in cases.iter().enumerate() {
    // rust: let mut chunks = Vec::new();
    // rust: for cz in -1..=1 {
    // rust: for cx in -1..=1 {
    // rust: let mut c = Chunk::with_layout(cx, cz, layout);
    // rust: let base_y = -64 + next(64) as i32;
    // rust: for y in layout.min_y()..base_y {
    // rust: for i in 0..256 {
    // rust: c.set(i & 15, y, i >> 4, STONE);
}
}
    // rust: let features = 10 + next(20);
    // rust: for _ in 0..features {
    // rust: let fx = next(16) as i32;
    // rust: let fz = next(16) as i32;
    // rust: let fy = base_y + next(32) as i32;
    // rust: let block_type = match next(4) {
    // rust: 0 => AIR,
    // rust: 1 => STONE,
    // rust: 2 => TORCH,
    // rust: _ => SLAB,
}
    // rust: c.set(fx, fy, fz, block_type);
}
    // rust: let roof_y = base_y + 10 + next(10) as i32;
    // rust: for rx in 4..12 {
    // rust: for rz in 4..12 {
    // rust: if next(3) != 0 {
    // rust: c.set(rx, roof_y, rz, SLAB);
}
}
}
    // rust: c.set(8, roof_y - 1, 8, TORCH);
    // rust: c.set(next(16) as i32, roof_y + 2, next(16) as i32, TORCH);
    // rust: c.set(0, base_y + 1, 0, TORCH);
    // rust: c.set(15, base_y + 1, 15, TORCH);

    // rust: chunks.push(c);
}
}

    // rust: let mut region: [[Option<&Chunk>; 3]; 3] = [[None; 3]; 3];
    // rust: for dz in 0..3 {
    // rust: for dx in 0..3 {
    // rust: let is_centre = dz == 1 && dx == 1;
    // rust: let chunk_ref = &chunks[dz * 3 + dx];
    // rust: let include = if is_centre {
    // rust: true
    // rust: } else {
    // rust: match pattern {
    // rust: 0 => true,
    // rust: 1 => (dz + dx) % 2 == 1,
    // rust: 2 => (dz + dx) % 2 == 0,
    // rust: 3 => next(10) < 6,
    // rust: 4 => dz == 1 && dx == 2,
    // rust: _ => true,
}
}
    // rust: if include {
    // rust: region[dz][dx] = Some(chunk_ref);
}
}
}

    // rust: let old = old_light_chunk(&region, &t, sky_light);
    // rust: let new = light_chunk(&region, &t, sky_light);

    // rust: assert_eq!(
    // rust: old.len(),
    // rust: new.len(),
    // rust: "round {round}: section count mismatch"
    // rust: );
    // rust: for si in 0..old.len() {
    // rust: for i in 0..4096 {
    // rust: assert_eq!(
    // rust: new[si].get(i),
    // rust: old[si].get(i),
    // rust: "mismatch at round {round} (sky_light={sky_light}, pattern={pattern}), section {si}, index {i} (lx={}, ly={}, lz={}): new={:#04x}, old={:#04x}",
    // rust: i & 15,
    // rust: i >> 8,
    // rust: (i >> 4) & 15,
    // rust: new[si].get(i),
    // rust: old[si].get(i)
    // rust: );
}
}
}
}
}
