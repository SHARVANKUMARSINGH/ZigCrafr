//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_occlusion
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `SectionOcclusionGraph`: which sections the camera can see through open
//! faces. Breadth-first from the camera section through the faces each
//! section's VisGraph connects, never stepping back towards the camera. As in
//! vanilla's `runUpdates`, a section leads on through whatever any of the faces
//! it was entered through connects to, and beyond 60 blocks a step is taken
//! only if the line from the section towards the camera stays in sections the
//! search has reached.
//!
//! As in vanilla, the full search runs off the render thread: a worker keeps
//! its own copy of every section's connectivity and searches over dense
//! arrays around the camera. Frames use the last finished graph and never wait
//! for the next one. A section meshed in between propagates into the graph the
//! frame has (vanilla's partial update), so what it opens shows at once; what
//! it closes goes at the next full search.
//!
//! GPU culling (gfx/gpu_culling.rs) answers as `contains` does from a copy of
//! the graph (`Reach`): the cells it reached, kept as bits too, sent again
//! whenever the generation moves, which it does whenever an answer may change.
// use super::SectionKey;
// use crate::fast_hash::FxHashSet;
// use crate::mesher::ALL_VISIBLE;
// use glam::DVec3;
// use std::collections::{HashMap, VecDeque};
// use std::sync::mpsc::{self, Receiver, Sender, TryRecvError};

/// Vanilla's `Direction` order: down, up, north, south, west, east.
    // rust: const STEPS: [(i32, i32, i32); 6] = [
    // rust: (0, -1, 0),
    // rust: (0, 1, 0),
    // rust: (0, 0, -1),
    // rust: (0, 0, 1),
    // rust: (-1, 0, 0),
    // rust: (1, 0, 0),
    // rust: ];
/// In `Graph::directions`: the cell has a node.
pub const REACHED: u8 = 1 << 7;
/// `MINIMUM_ADVANCED_CULLING_SECTION_DISTANCE`: `blockToSectionCoord(60)`.
pub const DISTANT_SECTIONS: i32 = 60 >> 4;
/// `MINIMUM_ADVANCED_CULLING_DISTANCE` (60 blocks), squared.
pub const DISTANT_SQR: f64 = 3600.0;
/// `CEILED_SECTION_DIAGONAL`: `ceil(sqrt(3) * 16)`.
pub const SECTION_DIAGONAL: f64 = 28.0;
/// In `Graph::rays`: the line from this corner stays in reached sections.
pub const SEES: u8 = u8::MAX;

/// VisGraph connectivity per column, one entry per section (bottom first).
/// A missing column or section connects every face.
pub const Columns = struct {
    /// The lowest block y of section 0 (`Level.getMinY`).
    min_y: i32,
    sections: i32,
    map: HashMap<(i32,
};

    // rust: impl Columns {
pub fn new(min_y: i32, sections: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: min_y,
    // rust: sections,
    // rust: map: HashMap::new(),
}
}
    /// `SectionPos.of`: the section holding `pos`.
pub fn section_of(self: *Self, pos: DVec3) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: (pos.x.floor() as i32) >> 4,
    // rust: (pos.y.floor() as i32 - self.min_y) >> 4,
    // rust: (pos.z.floor() as i32) >> 4,
    // rust: )
}
    /// Whether the section's connectivity changed.
pub fn set(self: *Self, key: SectionKey, vis: u64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !(0..self.sections).contains(&key.1) {
    // rust: return false;
}
    // rust: let column = match self.map.get_mut(&(key.0, key.2)) {
    // rust: Some(column) => column,
    // rust: None if vis == ALL_VISIBLE => return false,
    // rust: None => self
    // rust: .map
    // rust: .entry((key.0, key.2))
    // rust: .or_insert_with(|| vec![ALL_VISIBLE; self.sections as usize].into()),
}
    // rust: let slot = &mut column[key.1 as usize];
    // rust: if *slot == vis {
    // rust: return false;
}
    // rust: *slot = vis;
    // rust: if vis == ALL_VISIBLE && column.iter().all(|&v| v == ALL_VISIBLE) {
    // rust: self.map.remove(&(key.0, key.2));
}
    // rust: true
}
pub fn get(self: *Self, key: SectionKey) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.map
    // rust: .get(&(key.0, key.2))
    // rust: .and_then(|column| column.get(usize::try_from(key.1).ok()?))
    // rust: .copied()
    // rust: .unwrap_or(ALL_VISIBLE)
}
pub fn apply(self: *Self, edit: Edit) void {
}
    // rust: match edit {
    // rust: Edit::Set(key, vis) => {
    // rust: self.set(key, vis);
}
    // rust: Edit::Clear => self.map.clear(),
}
}
}

pub const Edit = enum {
    Set(SectionKey, u64),
    Clear,
};

/// One search's result over the box around the camera: vanilla's
/// `GraphStorage.sectionToNodeMap`, as dense arrays.
pub const Graph = struct {
    from: SectionKey,
    radius: i32,
    /// The world: lowest block y and height in sections.
    min_y: i32,
    sections: i32,
    /// The searched box: lowest section y and its height in sections.
    y0: i32,
    height: i32,
    /// Per cell: `REACHED`, and the directions travelled from the camera to
    /// it (`Node.directions`).
    directions: std.ArrayList(u8),
    /// Per cell: the faces it was entered through, one bit per face
    /// (`Node.sourceDirections`, as the faces rather than the steps); none for
    /// the camera's.
    entered: std.ArrayList(u8),
    /// `REACHED` of each cell again, a bit each at `index` (32 a word, lowest
    /// bit first): the GPU's copy (`Occlusion::reach`), written with it
    /// (`set_reached`).
    bits: std.ArrayList(u32),
    /// Whether any section in the searched top layer was reached. Sections
    /// above a clamped box use this conservative sky-band answer.
    sky_reached: bool,
    /// Per section corner, during a full search: `SEES`, or how far the line
    /// from it towards the camera is known to stay in reached sections (the
    /// first sample that was not). Sections are only ever added during a
    /// search, so a line that stays in reached sections keeps doing so, and
    /// one that didn't need only be checked again from where it failed.
    rays: std.ArrayList(u8),
};

    // rust: impl Graph {
pub fn index(self: *Self, key: SectionKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (dx, dz, dy) = (key.0 - self.from.0, key.2 - self.from.2, key.1 - self.y0);
    // rust: let side = 2 * self.radius + 1;
    // rust: if dx.abs() > self.radius || dz.abs() > self.radius || !(0..self.height).contains(&dy) {
    // rust: return None;
}
    // rust: Some((((dz + self.radius) * side + dx + self.radius) * self.height + dy) as usize)
}
pub fn key(self: *Self, index: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let side = 2 * self.radius + 1;
    // rust: let i = index as i32;
    // rust: let column = i / self.height;
    // rust: (
    // rust: self.from.0 + column % side - self.radius,
    // rust: self.y0 + i % self.height,
    // rust: self.from.2 + column / side - self.radius,
    // rust: )
}
pub fn contains(self: *Self, key: SectionKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(i) = self.index(key) {
    // rust: self.directions[i] & REACHED != 0
    // rust: } else if (0..=self.sections).contains(&key.1)
    // rust: && key.1 >= self.y0 + self.height
    // rust: && (key.0 - self.from.0).abs() <= self.radius
    // rust: && (key.2 - self.from.2).abs() <= self.radius
    // rust: {
            // Everything above the highest non-air section is open sky. A
            // full search can reach that layer from a neighbouring column,
            // so checking only this column's top cell can hide an upper
            // section that is visible through the open layer. Once any top
            // cell is reached, conservatively keep the whole sky band visible.
    // rust: self.sky_reached
    // rust: } else {
    // rust: false
}
}
    /// Cell `i` is reached, having travelled `directions` (`REACHED` among
    /// them): the one writer of `REACHED`, so `bits` say what `directions` do.
pub fn set_reached(self: *Self, i: usize, directions: u8) void {
}
    // rust: debug_assert!(directions & REACHED != 0);
    // rust: self.directions[i] = directions;
    // rust: self.bits[i / 32] |= 1 << (i % 32);
}
    /// The full search from the camera (vanilla's `scheduleFullUpdate`).
    // rust: fn search(
    // rust: &mut self,
    // rust: columns: &Columns,
    // rust: camera: DVec3,
    // rust: radius: i32,
    // rust: vis: &mut Vec<u64>,
    // rust: queue: &mut VecDeque<u32>,
    // rust: ) {
    // rust: let from = columns.section_of(camera);
    // rust: self.from = from;
    // rust: self.radius = radius;
    // rust: self.min_y = columns.min_y;
    // rust: self.sections = columns.sections;
    // rust: self.y0 = -1;
    // rust: if from.1 >= columns.sections {
    // rust: self.height = columns.sections + 2;
    // rust: } else {
    // rust: let mut max_non_air_y = 0;
    // rust: for dz in -radius..=radius {
    // rust: for dx in -radius..=radius {
    // rust: let Some(column) = columns.map.get(&(from.0 + dx, from.2 + dz)) else {
    // rust: continue;
}
    // rust: for (y, &v) in column.iter().enumerate().rev() {
    // rust: let y = y as i32;
    // rust: if y <= max_non_air_y {
    // rust: break;
}
    // rust: if v != ALL_VISIBLE {
    // rust: max_non_air_y = y;
    // rust: break;
}
}
}
}
    // rust: let top_y = max_non_air_y.max(from.1);
    // rust: self.height = (top_y + 3).max(3).min(columns.sections + 2);
}
    // rust: let side = (2 * radius + 1) as usize;
    // rust: let size = side * side * self.height as usize;
    // rust: self.directions.clear();
    // rust: self.directions.resize(size, 0);
    // rust: self.bits.clear();
    // rust: self.bits.resize(size.div_ceil(32), 0);
    // rust: self.entered.clear();
    // rust: self.entered.resize(size, 0);
    // rust: self.sky_reached = false;
    // rust: self.rays.clear();
    // rust: self.rays
    // rust: .resize((side + 1) * (side + 1) * (self.height + 1) as usize, 0);
    // rust: vis.clear();
    // rust: vis.resize(size, ALL_VISIBLE);
    // rust: for dz in -radius..=radius {
    // rust: for dx in -radius..=radius {
    // rust: let Some(column) = columns.map.get(&(from.0 + dx, from.2 + dz)) else {
    // rust: continue;
}
    // rust: let base = self
    // rust: .index((from.0 + dx, 0, from.2 + dz))
    // rust: .expect("column inside the searched box");
    // rust: let len = (column.len() as i32).min(self.height - 1) as usize;
    // rust: vis[base..base + len].copy_from_slice(&column[..len]);
}
}
    // rust: queue.clear();
    // rust: if (0..columns.sections).contains(&from.1) {
    // rust: let start = self.index(from).expect("camera inside the searched box");
    // rust: self.set_reached(start, REACHED);
    // rust: queue.push_back(start as u32);
    // rust: } else {
    // rust: self.seed_outside(camera, queue);
}
    // rust: self.propagate(queue, camera, true, |i, _| vis[i]);
}
    /// `initializeQueueForFullUpdate` with the camera above or below the
    /// world (no render section there): every section of the world's top
    /// layer (bottom layer from below) is entered through its outer face, its
    /// travelled directions pointing away from the camera's column, sorted
    /// by the squared distance from the camera's block to the section's
    /// centre (a stable sort over vanilla's x-then-z loop). Vanilla seeds only
    /// columns in view distance; this search covers its whole box, as it does
    /// from inside the world.
pub fn seed_outside(self: *Self, camera: DVec3, queue: *mut VecDeque<u32>) void {
}
        // STEPS indexes: down, up, north, south, west, east.
    // rust: let (y, travel) = if self.from.1 < 0 {
    // rust: (0, 1)
    // rust: } else {
    // rust: (self.sections - 1, 0)
}
    // rust: let block = (camera.x.floor() as i64, camera.z.floor() as i64);
    // rust: let mut seeds = Vec::with_capacity(((2 * self.radius + 1) as usize).pow(2));
    // rust: for dx in -self.radius..=self.radius {
    // rust: for dz in -self.radius..=self.radius {
    // rust: let mut directions = REACHED | 1 << travel;
    // rust: directions |= match dx.signum() {
    // rust: 1 => 1 << 5,
    // rust: -1 => 1 << 4,
    // rust: _ => 0,
}
    // rust: directions |= match dz.signum() {
    // rust: 1 => 1 << 3,
    // rust: -1 => 1 << 2,
    // rust: _ => 0,
}
                // The y offset is the same for every seed.
    // rust: let centre = |section: i32| i64::from(section) * 16 + 8;
    // rust: let (ox, oz) = (
    // rust: block.0 - centre(self.from.0 + dx),
    // rust: block.1 - centre(self.from.2 + dz),
    // rust: );
    // rust: seeds.push((ox * ox + oz * oz, dx, dz, directions));
}
}
    // rust: seeds.sort_by_key(|seed| seed.0);
    // rust: for (_, dx, dz, directions) in seeds {
    // rust: let i = self
    // rust: .index((self.from.0 + dx, y, self.from.2 + dz))
    // rust: .expect("seed inside the searched box");
    // rust: self.set_reached(i, directions);
            // Entered through the face opposite the travel (`sourceDirection`).
    // rust: self.entered[i] = 1 << (travel ^ 1);
    // rust: queue.push_back(i as u32);
}
}
    /// Vanilla's `runUpdates`: take nodes from the queue and step through
    /// every face their entry faces connect to, away from the camera. A step
    /// into a section already reached adds the face it enters through.
    /// `full`: the search from `camera` (`rays` holds its lines), not a
    /// partial update. Whether it reached a cell it had not.
    // rust: fn propagate(
    // rust: &mut self,
    // rust: queue: &mut VecDeque<u32>,
    // rust: camera: DVec3,
    // rust: full: bool,
    // rust: vis: impl Fn(usize, SectionKey) -> u64,
    // rust: ) -> bool {
    // rust: let mut grew = false;
    // rust: let eye = (
    // rust: (camera.x.floor() as i32) >> 4,
    // rust: (camera.y.floor() as i32 - self.min_y) >> 4,
    // rust: (camera.z.floor() as i32) >> 4,
    // rust: );
        // `SectionPos.center` of the camera's section.
    // rust: let centre = [eye.0 * 16 + 8, eye.1 * 16 + self.min_y + 8, eye.2 * 16 + 8];
    // rust: while let Some(index) = queue.pop_front() {
    // rust: let i = index as usize;
    // rust: let key = self.key(i);
    // rust: if key.1 == self.y0 + self.height - 1 {
    // rust: self.sky_reached = true;
}
    // rust: let directions = self.directions[i];
    // rust: let entered = self.entered[i];
    // rust: let exits = if entered == 0 {
    // rust: 0x3f
    // rust: } else {
    // rust: let vis = vis(i, key);
    // rust: (0..6)
    // rust: .filter(|face| entered & (1 << face) != 0)
    // rust: .fold(0, |exits, face| exits | (vis >> (face * 6)) as u8 & 0x3f)
}
    // rust: let distant = (key.0 - eye.0).abs() > DISTANT_SECTIONS
    // rust: || (key.1 - eye.1).abs() > DISTANT_SECTIONS
    // rust: || (key.2 - eye.2).abs() > DISTANT_SECTIONS;
            // The distant test once per axis: both steps along an axis start
            // from the same corner. While the camera is in the section the
            // graph was searched from, every step leads away from it or
            // sideways, so no point of the line falls in a neighbour this loop
            // adds. A partial update after the camera moved tests every step.
    // rust: let reuse = eye == self.from;
    // rust: let mut seen = [None; 3];
    // rust: for (d, step) in STEPS.iter().enumerate() {
    // rust: if exits & (1 << d) == 0 || directions & (1 << (d ^ 1)) != 0 {
    // rust: continue;
}
    // rust: let next = (key.0 + step.0, key.1 + step.1, key.2 + step.2);
    // rust: if next.1 < -1 || next.1 > self.sections {
    // rust: continue;
}
    // rust: let Some(n) = self.index(next) else { continue };
    // rust: if distant {
    // rust: let sees = match seen[d / 2] {
    // rust: Some(sees) if reuse => sees,
    // rust: _ => self.sees_camera(key, d, centre, camera, full),
}
    // rust: seen[d / 2] = Some(sees);
    // rust: if !sees {
    // rust: continue;
}
}
    // rust: if self.directions[n] & REACHED == 0 {
    // rust: self.set_reached(n, directions | 1 << d);
    // rust: self.entered[n] = 1 << (d ^ 1);
    // rust: queue.push_back(n as u32);
    // rust: grew = true;
    // rust: } else {
    // rust: self.entered[n] |= 1 << (d ^ 1);
}
}
}
    // rust: grew
}
    /// Vanilla's distant step test: from the corner of `key` that the step `d`
    /// picks, walk towards the camera in section diagonals while farther than
    /// 60 blocks. Every point inside the world has to fall in a section the
    /// search has reached. Same arithmetic as JOML's `Vector3d` (no FMA).
    /// `full`: remember the answer per corner in `rays`.
    // rust: fn sees_camera(
    // rust: &mut self,
    // rust: key: SectionKey,
    // rust: d: usize,
    // rust: centre: [i32; 3],
    // rust: camera: DVec3,
    // rust: full: bool,
    // rust: ) -> bool {
    // rust: let origin = [key.0 * 16, key.1 * 16 + self.min_y, key.2 * 16];
        // The step's axis in x, y, z order: down/up, north/south, west/east.
    // rust: let axis = [1, 2, 0][d / 2];
    // rust: let far = |c: usize| {
    // rust: i32::from(if c == axis {
    // rust: centre[c] > origin[c]
    // rust: } else {
    // rust: centre[c] < origin[c]
    // rust: })
}
    // rust: let corner = (key.0 + far(0), key.1 + far(1), key.2 + far(2));
    // rust: let slot = full.then(|| {
    // rust: let side = 2 * self.radius + 2;
    // rust: let (x, z) = (
    // rust: corner.0 - self.from.0 + self.radius,
    // rust: corner.2 - self.from.2 + self.radius,
    // rust: );
    // rust: ((z * side + x) * (self.height + 1) + corner.1 - self.y0) as usize
    // rust: });
    // rust: let known = slot.map_or(0, |slot| self.rays[slot]);
    // rust: if known == SEES {
    // rust: return true;
}
    // rust: let failed = self.walk(corner, camera, known);
    // rust: if let Some(slot) = slot {
    // rust: self.rays[slot] = failed.unwrap_or(SEES);
}
    // rust: failed.is_none()
}
    /// The line from the section corner `corner` towards the camera; `None`
    /// if every sample is in a reached section, else the first one that is
    /// not (counted from 1). The first `known - 1` samples are known to be
    /// reached: they are stepped over (the same additions, so the same
    /// points) without looking them up.
pub fn walk(self: *Self, corner: SectionKey, camera: DVec3, known: u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut check = [
    // rust: f64::from(corner.0 * 16),
    // rust: f64::from(corner.1 * 16 + self.min_y),
    // rust: f64::from(corner.2 * 16),
    // rust: ];
    // rust: let camera = [camera.x, camera.y, camera.z];
    // rust: let to = [
    // rust: camera[0] - check[0],
    // rust: camera[1] - check[1],
    // rust: camera[2] - check[2],
    // rust: ];
    // rust: let inverse = 1.0 / (to[0] * to[0] + (to[1] * to[1] + to[2] * to[2])).sqrt();
    // rust: let step = to.map(|t| t * inverse * SECTION_DIAGONAL);
    // rust: let (min_y, max_y) = (
    // rust: f64::from(self.min_y),
    // rust: f64::from(self.min_y + self.sections * 16 - 1),
    // rust: );
    // rust: let far = |p: &[f64; 3]| {
    // rust: let (x, y, z) = (p[0] - camera[0], p[1] - camera[1], p[2] - camera[2]);
    // rust: x * x + (y * y + z * z) > DISTANT_SQR
}
    // rust: let mut sample = 0u8;
    // rust: while sample + 1 < known {
    // rust: for (c, s) in check.iter_mut().zip(step) {
    // rust: *c += s;
}
    // rust: sample += 1;
}
    // rust: while far(&check) {
    // rust: for (c, s) in check.iter_mut().zip(step) {
    // rust: *c += s;
}
    // rust: sample = sample.saturating_add(1);
    // rust: if check[1] > max_y || check[1] < min_y {
    // rust: break;
}
    // rust: let section = (
    // rust: floor(check[0]) >> 4,
    // rust: (floor(check[1]) - self.min_y) >> 4,
    // rust: floor(check[2]) >> 4,
    // rust: );
    // rust: if !self.contains(section) {
                // A count too long to keep (`SEES`) starts over next time.
    // rust: return Some(if sample == SEES { 0 } else { sample });
}
}
    // rust: None
}
}

/// The graph `Occlusion::contains` reads, for GPU culling's copy
/// (gfx/gpu_culling.rs): its searched box (`Graph::index`), the level's height
/// in sections, whether the search reached the box's top layer (the sky band
/// above a clamped box), and its cells' `REACHED` as bits.
pub const Reach = struct {
    /// `Occlusion::generation` when it was taken.
    generation: u64,
    from_x: i32,
    from_z: i32,
    radius: i32,
    y0: i32,
    height: i32,
    sections: i32,
    sky_reached: bool,
    bits: *'a [u32],
};

    // rust: impl Reach<'_> {
    /// gpu_culling.wgsl's `reached`, statement for statement: what
    /// `Graph::contains` answers.
pub fn contains(self: *Self, key: SectionKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = self.radius;
    // rust: let (dx, dz, dy) = (key.0 - self.from_x, key.2 - self.from_z, key.1 - self.y0);
    // rust: if dx < -r || dx > r || dz < -r || dz > r || dy < 0 {
    // rust: return false;
}
    // rust: if dy >= self.height {
    // rust: return self.sky_reached && (0..=self.sections).contains(&key.1);
}
    // rust: let i = (((dz + r) * (2 * r + 1) + dx + r) * self.height + dy) as usize;
    // rust: (self.bits[i / 32] >> (i % 32)) & 1 != 0
}
}

/// `Mth.floor` for coordinates inside the world, without a libm call (the
/// x86-64 baseline has no rounding instruction).
pub fn floor(x: f64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = x as i32;
    // rust: i - i32::from(f64::from(i) > x)
}

pub const Job = struct {
    edits: std.ArrayList(Edit),
    camera: DVec3,
    radius: i32,
    /// Buffers to reuse.
    graph: Graph,
};

/// The thread that runs full searches over its own copy of the columns.
pub const Worker = struct {
    jobs: Sender<Job>,
    done: Receiver<(Graph,
};

    // rust: impl Worker {
pub fn spawn(min_y: i32, sections: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (jobs, job_rx) = mpsc::channel::<Job>();
    // rust: let (done_tx, done) = mpsc::channel();
    // rust: std::thread::Builder::new()
    // rust: .name("occlusion".into())
    // rust: .spawn(move || {
    // rust: let mut columns = Columns::new(min_y, sections);
    // rust: let (mut vis, mut queue) = (Vec::new(), VecDeque::new());
    // rust: while let Ok(mut job) = job_rx.recv() {
    // rust: for edit in job.edits.drain(..) {
    // rust: columns.apply(edit);
}
    // rust: job.graph
    // rust: .search(&columns, job.camera, job.radius, &mut vis, &mut queue);
    // rust: if done_tx.send((job.graph, job.edits)).is_err() {
    // rust: break;
}
}
    // rust: })
    // rust: .ok()?;
    // rust: Some(Self { jobs, done })
}
}

/// A new value for `Occlusion::generation`, unique in the process: a copy made
/// from an older `Occlusion` (another level's) never matches. As gfx.rs
/// `next_block_entity_revision`.
pub fn next_generation() u {
    // Implementation ported from Horizon
    return undefined;
}
pub const NEXT: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(1);
    // rust: NEXT.fetch_add(1, std::sync::atomic::Ordering::Relaxed)
}

pub const Occlusion = struct {
    /// The render thread's copy, for partial updates (and searches when the
    /// worker is gone).
    columns: Columns,
    /// Edits the worker has not been sent yet.
    edits: std.ArrayList(Edit),
    /// A full search is due: sections changed since the last one started.
    dirty: bool,
    /// The last finished search; `None` until one finishes, or after the
    /// columns were cleared.
    graph: ?Graph,
    spare: Graph,
    worker: ?Worker,
    /// The camera section and radius of the running search.
    running: Option<(SectionKey,
    /// The running search started before the columns were cleared: drop it.
    discard: bool,
    /// The camera section and radius `graph`'s search started from (or is
    /// starting from).
    searched: Option<(SectionKey,
    /// Sections changed since `graph`'s search started, to propagate from.
    changed: std.ArrayList(SectionKey),
    /// Sections changed since the running search started: they propagate into
    /// its graph when it lands.
    changed_late: std.ArrayList(SectionKey),
    vis: std.ArrayList(u64),
    queue: VecDeque<u32>,
    /// Changes whenever `contains` may answer differently (`generation`).
    generation: u64,
};

    // rust: impl Occlusion {
    /// The world's lowest block y and its height in sections.
pub fn new(min_y: i32, sections: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: columns: Columns::new(min_y, sections),
    // rust: edits: Vec::new(),
    // rust: dirty: true,
    // rust: graph: None,
    // rust: spare: Graph::default(),
    // rust: worker: Worker::spawn(min_y, sections),
    // rust: running: None,
    // rust: discard: false,
    // rust: searched: None,
    // rust: changed: Vec::new(),
    // rust: changed_late: Vec::new(),
    // rust: vis: Vec::new(),
    // rust: queue: VecDeque::new(),
    // rust: generation: next_generation(),
}
}
pub fn set(self: *Self, key: SectionKey, vis: u64) void {
}
    // rust: if self.columns.set(key, vis) {
    // rust: self.changed(key, vis);
}
}
pub fn changed(self: *Self, key: SectionKey, vis: u64) void {
}
    // rust: self.edits.push(Edit::Set(key, vis));
    // rust: self.dirty = true;
    // rust: self.changed.push(key);
    // rust: if self.running.is_some() {
    // rust: self.changed_late.push(key);
}
}
    /// Every section of the column `x`, `z` goes (sees through every face).
pub fn remove_column(self: *Self, x: i32, z: i32) void {
}
    // rust: let Some(column) = self.columns.map.remove(&(x, z)) else {
    // rust: return;
}
    // rust: for (y, &vis) in column.iter().enumerate() {
    // rust: if vis != ALL_VISIBLE {
    // rust: self.changed((x, y as i32, z), ALL_VISIBLE);
}
}
}
    /// `remove_column` for each of `gone`. When they are every column it holds (a
    /// teleport drops the whole view), the old graph says nothing about what arrives
    /// next: it starts over as `clear` does instead of seeing through each removed
    /// section one edit at a time (some 90 000 at render distance 32).
pub fn remove_columns(self: *Self, gone: *FxHashSet<(i32) void {
}
    // rust: if self.columns.map.keys().all(|column| gone.contains(column)) {
    // rust: self.clear();
    // rust: return;
}
    // rust: for &(x, z) in gone {
    // rust: self.remove_column(x, z);
}
}
pub fn clear(self: *Self) void {
}
    // rust: self.columns.map.clear();
    // rust: self.edits.clear();
    // rust: self.edits.push(Edit::Clear);
    // rust: self.dirty = true;
        // Another world: the old graph says nothing about it. Without one, every
        // section was visible already, and stays so.
    // rust: if let Some(graph) = self.graph.take() {
    // rust: self.spare = graph;
    // rust: self.generation = next_generation();
}
    // rust: self.searched = None;
    // rust: self.discard = self.running.is_some();
    // rust: self.changed.clear();
    // rust: self.changed_late.clear();
}
    /// Whether `key` is visible from the camera. Without a usable graph
    /// (before the first search lands, or with the camera somewhere the graph
    /// never reached) every section is.
pub fn contains(self: *Self, key: SectionKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.graph.as_ref().is_none_or(|g| g.contains(key))
}
    /// Whether the current graph knows that `key` is visible from
    /// `camera_section`. Unknown is returned when the graph is absent, was
    /// searched from another section, or does not cover the queried section.
pub fn visible_for_camera(self: *Self, key: SectionKey, camera_section: SectionKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let graph = self.graph.as_ref()?;
    // rust: if graph.from != camera_section {
    // rust: return None;
}
    // rust: let dx = i64::from(key.0) - i64::from(graph.from.0);
    // rust: let dz = i64::from(key.2) - i64::from(graph.from.2);
    // rust: if dx.abs() > i64::from(graph.radius)
    // rust: || dz.abs() > i64::from(graph.radius)
    // rust: || key.1 < graph.y0
    // rust: || key.1 > graph.sections
    // rust: {
    // rust: return None;
}
    // rust: Some(graph.contains(key))
}
    /// Changes whenever `contains` may answer differently: a search landed, a
    /// partial update reached more sections, or the graph went.
pub fn generation(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.generation
}
    /// The graph `contains` reads; `None` while every section counts as
    /// visible.
pub fn reach(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.graph.as_ref().map(|g| Reach {
    // rust: generation: self.generation,
    // rust: from_x: g.from.0,
    // rust: from_z: g.from.2,
    // rust: radius: g.radius,
    // rust: y0: g.y0,
    // rust: height: g.height,
    // rust: sections: g.sections,
    // rust: sky_reached: g.sky_reached,
    // rust: bits: &g.bits,
    // rust: })
}
    /// The bits `reach` exports are the cells' `REACHED`, cell for cell.
pub fn reach_is_exact(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.graph.as_ref().is_none_or(|g| {
    // rust: g.bits.len() == g.directions.len().div_ceil(32)
    // rust: && g.directions
    // rust: .iter()
    // rust: .enumerate()
    // rust: .all(|(i, &d)| (d & REACHED != 0) == ((g.bits[i / 32] >> (i % 32)) & 1 != 0))
    // rust: })
}
    /// Take a finished search, propagate changed sections into the graph,
    /// and start a search when sections changed or the camera moved to
    /// another section. Never waits for the worker.
pub fn update(self: *Self, camera: DVec3, radius: i32) void {
}
    // rust: let from = self.columns.section_of(camera);
    // rust: self.collect(false);
    // rust: self.propagate_changes(camera);
    // rust: if self.running.is_none() && (self.dirty || self.searched != Some((from, radius))) {
    // rust: self.start(camera, radius);
}
        // A graph that never reached the camera's section hides everything
        // around it: until the new one lands, cull by the frustum alone.
    // rust: if self
    // rust: .graph
    // rust: .as_ref()
    // rust: .is_some_and(|g| g.from != from && !g.contains(from))
    // rust: && let Some(graph) = self.graph.take()
    // rust: {
    // rust: self.spare = graph;
    // rust: self.generation = next_generation();
}
}
pub fn start(self: *Self, camera: DVec3, radius: i32) void {
}
    // rust: let from = self.columns.section_of(camera);
    // rust: self.dirty = false;
    // rust: self.searched = Some((from, radius));
    // rust: let graph = std::mem::take(&mut self.spare);
    // rust: if let Some(worker) = &self.worker {
    // rust: let job = Job {
    // rust: edits: std::mem::take(&mut self.edits),
    // rust: camera,
    // rust: radius,
    // rust: graph,
}
    // rust: if worker.jobs.send(job).is_ok() {
    // rust: self.running = Some((from, radius));
    // rust: self.changed_late.clear();
    // rust: return;
}
    // rust: log::warn!("Horizon: the occlusion worker stopped; culling on the render thread");
    // rust: self.worker = None;
}
    // rust: self.edits.clear();
    // rust: let mut graph = Graph::default();
    // rust: graph.search(
    // rust: &self.columns,
    // rust: camera,
    // rust: radius,
    // rust: &mut self.vis,
    // rust: &mut self.queue,
    // rust: );
    // rust: self.land(graph);
}
pub fn collect(self: *Self, wait: bool) void {
}
    // rust: let Some(worker) = &self.worker else { return };
    // rust: if self.running.is_none() {
    // rust: return;
}
    // rust: let result = if wait {
    // rust: worker.done.recv().map_err(|_| TryRecvError::Disconnected)
    // rust: } else {
    // rust: worker.done.try_recv()
}
    // rust: match result {
    // rust: Ok((graph, edits)) => {
    // rust: self.running = None;
    // rust: if self.edits.is_empty() {
    // rust: self.edits = edits;
}
    // rust: if std::mem::take(&mut self.discard) {
    // rust: self.spare = graph;
    // rust: return;
}
    // rust: self.land(graph);
    // rust: self.changed.clear();
    // rust: self.changed.append(&mut self.changed_late);
}
    // rust: Err(TryRecvError::Empty) => {}
    // rust: Err(TryRecvError::Disconnected) => {
                // The edits it held are lost with it: search here from now on.
    // rust: self.worker = None;
    // rust: self.running = None;
    // rust: self.discard = false;
    // rust: self.dirty = true;
}
}
}
pub fn land(self: *Self, graph: Graph) void {
}
    // rust: if let Some(old) = self.graph.replace(graph) {
    // rust: self.spare = old;
}
    // rust: self.generation = next_generation();
}
    /// Vanilla's `runPartialUpdate`: what changed sections now connect to.
pub fn propagate_changes(self: *Self, camera: DVec3) void {
}
    // rust: let Some(graph) = &mut self.graph else {
    // rust: self.changed.clear();
    // rust: return;
}
    // rust: self.queue.clear();
    // rust: for key in self.changed.drain(..) {
    // rust: if let Some(i) = graph.index(key)
    // rust: && graph.directions[i] & REACHED != 0
    // rust: {
    // rust: self.queue.push_back(i as u32);
}
}
    // rust: let columns = &self.columns;
    // rust: if graph.propagate(&mut self.queue, camera, false, |_, key| columns.get(key)) {
    // rust: self.generation = next_generation();
}
}
    /// Wait for the running search: tests, and A/B timing of the old
    /// blocking search.
pub fn settle(self: *Self, camera: DVec3, radius: i32) void {
}
    // rust: self.update(camera, radius);
    // rust: self.collect(true);
    // rust: self.propagate_changes(camera);
}
}

    // rust: mod tests {
//     use super::*;

    /// The centre of a section, in a world whose section 0 starts at y 0.
pub fn at(key: SectionKey) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DVec3::new(
    // rust: f64::from(key.0) * 16.0 + 8.0,
    // rust: f64::from(key.1) * 16.0 + 8.0,
    // rust: f64::from(key.2) * 16.0 + 8.0,
    // rust: )
}

pub fn constants_are_vanillas() void {
}
    // rust: assert_eq!(SECTION_DIAGONAL, (3f64.sqrt() * 16.0).ceil());
    // rust: assert_eq!(DISTANT_SECTIONS, 3);
}

pub fn floor_is_std_floor() void {
}
    // rust: let mut x = -40_000.0_f64;
    // rust: while x < 40_000.0 {
    // rust: for v in [x, x + 0.5, x - 1e-9, x + 1e-9, -x] {
    // rust: assert_eq!(floor(v), v.floor() as i32, "{v}");
}
    // rust: x += 0.37;
}
}

pub fn open_space_reaches_the_whole_box() void {
}
    // rust: let mut o = Occlusion::new(0, 4);
    // rust: o.settle(at((0, 1, 0)), 2);
    // rust: for x in -2..=2 {
    // rust: for z in -2..=2 {
    // rust: for y in -1..=4 {
    // rust: assert!(o.contains((x, y, z)), "{x} {y} {z}");
}
}
}
    // rust: assert!(!o.contains((3, 1, 0)));
}

pub fn closed_neighbours_hide_what_is_behind_them() void {
}
    // rust: let mut o = Occlusion::new(0, 4);
    // rust: for (dx, dy, dz) in STEPS {
    // rust: o.set((dx, 1 + dy, dz), 0);
}
    // rust: o.settle(at((0, 1, 0)), 3);
    // rust: assert!(o.contains((1, 1, 0)), "a neighbour is seen");
    // rust: assert!(!o.contains((2, 1, 0)), "nothing shows through it");
    // rust: o.set((1, 1, 0), ALL_VISIBLE);
    // rust: o.settle(at((0, 1, 0)), 3);
    // rust: assert!(o.contains((2, 1, 0)));
}

    /// `visible_for_camera` answers only for the box of the graph it holds, and
    /// only for the camera that search started from. Everywhere else it says
    /// unknown, so the caller keeps the geometry.
pub fn visible_for_camera_is_unknown_outside_its_box_and_its_camera() void {
}
        // No graph yet: nothing to answer with.
    // rust: assert_eq!(
    // rust: Occlusion::new(0, 4).visible_for_camera((0, 1, 0), (0, 1, 0)),
    // rust: None
    // rust: );
    // rust: let mut o = Occlusion::new(0, 4);
    // rust: o.settle(at((0, 1, 0)), 2);
    // rust: let from = o.columns.section_of(at((0, 1, 0)));
    // rust: assert_eq!(from, (0, 1, 0), "the camera section searched from");
        // Inside the searched box the answer is `contains`, its edges too.
    // rust: for x in -2..=2 {
    // rust: for z in -2..=2 {
    // rust: for y in -1..=4 {
    // rust: assert_eq!(
    // rust: o.visible_for_camera((x, y, z), from),
    // rust: Some(o.contains((x, y, z))),
    // rust: "{x} {y} {z}"
    // rust: );
}
}
}
    // rust: assert_eq!(
    // rust: o.visible_for_camera((2, 1, 0), from),
    // rust: Some(true),
    // rust: "the box's edge"
    // rust: );
        // Off the box's sides, below it, or above the level: unknown.
    // rust: for key in [
    // rust: (3, 1, 0),
    // rust: (-3, 1, 0),
    // rust: (0, 1, 3),
    // rust: (0, 1, -3),
    // rust: (0, -2, 0),
    // rust: (0, 5, 0),
    // rust: ] {
    // rust: assert_eq!(o.visible_for_camera(key, from), None, "{key:?}");
}
        // Another camera section: this graph is not about it.
    // rust: assert_eq!(o.visible_for_camera((0, 1, 0), (1, 1, 0)), None);
}

    /// The answer follows the graph: a closed wall hides the section behind it,
    /// and opening the wall shows it again.
pub fn visible_for_camera_reports_what_the_graph_hides() void {
}
    // rust: let mut o = Occlusion::new(0, 4);
    // rust: for (dx, dy, dz) in STEPS {
    // rust: o.set((dx, 1 + dy, dz), 0);
}
    // rust: o.settle(at((0, 1, 0)), 3);
    // rust: let from = (0, 1, 0);
    // rust: assert_eq!(
    // rust: o.visible_for_camera((1, 1, 0), from),
    // rust: Some(true),
    // rust: "the wall itself"
    // rust: );
    // rust: assert_eq!(
    // rust: o.visible_for_camera((2, 1, 0), from),
    // rust: Some(false),
    // rust: "hidden behind it"
    // rust: );
    // rust: o.set((1, 1, 0), ALL_VISIBLE);
    // rust: o.settle(at((0, 1, 0)), 3);
    // rust: assert_eq!(o.visible_for_camera((2, 1, 0), from), Some(true));
}

    /// Faces `a` and `b` of a section see each other, nothing else does.
pub fn connects(a: usize, b: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 1 << (a * 6 + b) | 1 << (b * 6 + a)
}

    /// #629 / #782 rule 1: a section first entered through a face that leads
    /// nowhere still leads on through the face it is entered through later.
pub fn a_section_leads_on_through_every_face_it_is_entered_through() void {
}
    // rust: let mut o = Occlusion::new(0, 4);
        // (1, 1, 1) is reached through its west face first (from (0, 1, 1),
        // queued before (1, 1, 0)), then through its north face. Only north
        // leads on, to the east.
    // rust: o.set((1, 1, 1), connects(2, 5));
        // Every other way into (2, 1, 1) is closed.
    // rust: for key in [(2, 1, 0), (2, 0, 1), (2, 2, 1)] {
    // rust: o.set(key, 0);
}
    // rust: o.settle(at((0, 1, 0)), 3);
    // rust: let graph = o.graph.as_ref().expect("searched");
    // rust: let i = graph.index((1, 1, 1)).unwrap();
    // rust: assert_eq!(
    // rust: graph.entered[i],
    // rust: 1 << 2 | 1 << 4,
    // rust: "entered from north and west"
    // rust: );
    // rust: assert!(o.contains((2, 1, 1)), "seen through the north face");
}

pub fn frames_never_wait_and_partial_updates_open_at_once() void {
}
    // rust: let mut o = Occlusion::new(0, 4);
    // rust: for (dx, dy, dz) in STEPS {
    // rust: o.set((dx, 1 + dy, dz), 0);
}
    // rust: let camera = at((0, 1, 0));
    // rust: o.settle(camera, 3);
    // rust: assert!(!o.contains((2, 1, 0)));
        // Opening the wall shows what is behind it in the same frame, from the
        // graph the frame has, whether or not the full search has finished.
    // rust: o.set((1, 1, 0), ALL_VISIBLE);
    // rust: o.update(camera, 3);
    // rust: assert!(o.contains((2, 1, 0)));
    // rust: assert!(o.contains((3, 1, 0)));
        // Closing it again lasts until the next full search lands.
    // rust: o.set((1, 1, 0), 0);
    // rust: o.settle(camera, 3);
    // rust: o.settle(camera, 3);
    // rust: assert!(!o.contains((2, 1, 0)));
}

pub fn a_graph_that_lost_the_camera_culls_nothing() void {
}
    // rust: let mut o = Occlusion::new(0, 4);
    // rust: for (dx, dy, dz) in STEPS {
    // rust: o.set((dx, 1 + dy, dz), 0);
}
    // rust: o.settle(at((0, 1, 0)), 3);
    // rust: assert!(!o.contains((3, 1, 0)));
        // The camera jumped past the wall; the next search is still running.
    // rust: let o = &mut o;
    // rust: o.update(at((3, 1, 0)), 3);
    // rust: if o.running.is_some() {
    // rust: assert!(o.contains((3, 1, 0)));
}
    // rust: o.settle(at((3, 1, 0)), 3);
    // rust: assert!(o.contains((3, 1, 0)));
    // rust: assert!(
    // rust: !o.contains((0, 1, 0)),
    // rust: "the old camera section is walled in"
    // rust: );
}

    /// #1037: from far above or below the world, the search starts from the
    /// world's top or bottom layer (`initializeQueueForFullUpdate`), so the
    /// ground stays drawn at any height.
pub fn a_camera_outside_the_world_sees_it_from_its_top_or_bottom() void {
}
    // rust: for from in [(0, 6, 0), (0, 9, 0), (2, 40, -1), (0, -1, 0), (1, -7, 0)] {
    // rust: let mut o = Occlusion::new(0, 6);
    // rust: o.settle(at(from), 3);
    // rust: for x in -1..=5 {
    // rust: for z in -4..=2 {
    // rust: for y in 0..6 {
    // rust: let inside = (x - from.0).abs() <= 3 && (z - from.2).abs() <= 3;
    // rust: assert_eq!(o.contains((x, y, z)), inside, "{from:?}: {x} {y} {z}");
}
}
}
    // rust: assert!(
    // rust: !o.contains(from),
    // rust: "{from:?}: the camera's own section is not in the world"
    // rust: );
}
}

    /// Seeds enter through the outer face and never turn back up (down)
    /// or towards the camera's column.
pub fn a_closed_top_layer_hides_the_world_from_above() void {
}
    // rust: let mut o = Occlusion::new(0, 6);
    // rust: for x in -3..=3 {
    // rust: for z in -3..=3 {
    // rust: o.set((x, 5, z), 0);
}
}
    // rust: o.settle(at((0, 30, 0)), 3);
    // rust: assert!(
    // rust: o.contains((0, 5, 0)) && o.contains((3, 5, -3)),
    // rust: "the top is seen"
    // rust: );
    // rust: assert!(
    // rust: !o.contains((0, 4, 0)) && !o.contains((2, 1, 2)),
    // rust: "nothing under it"
    // rust: );
    // rust: assert!(!o.contains((0, 6, 0)), "seeds don't step back up");
        // From below, the open bottom layer shows everything up to the lid.
    // rust: o.settle(at((0, -9, 0)), 3);
    // rust: assert!(o.contains((0, 0, 0)) && o.contains((1, 4, 1)) && o.contains((1, 5, 1)));
    // rust: assert!(!o.contains((0, -1, 0)), "seeds don't step back down");
}

    /// Vanilla's `runUpdates` as written (a map of nodes, a FIFO queue,
    /// `Vector3d` maths), over the same box: whether each cell is reached.
    /// `rays: false` leaves out the distant step test.
pub fn reference(columns: *Columns, camera: DVec3, radius: i32, rays: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
pub const Node = struct {
    directions: u8,
    sources: u8,
};
    // rust: let from = columns.section_of(camera);
    // rust: let y0 = -1;
    // rust: let height = columns.sections + 2;
    // rust: let side = 2 * radius + 1;
    // rust: let index = |k: SectionKey| {
    // rust: let (dx, dz, dy) = (k.0 - from.0, k.2 - from.2, k.1 - y0);
    // rust: (dx.abs() <= radius && dz.abs() <= radius && (0..height).contains(&dy))
    // rust: .then(|| (((dz + radius) * side + dx + radius) * height + dy) as usize)
}
    // rust: let block = |k: SectionKey| [k.0 * 16, k.1 * 16 + columns.min_y, k.2 * 16];
        // Direction.getAxis in x, y, z order.
    // rust: let axis = |d: usize| [1, 2, 0][d / 2];
    // rust: let centre = block(from).map(|c| c + 8);
    // rust: let mut nodes: HashMap<SectionKey, Node> = HashMap::new();
    // rust: let mut queue = VecDeque::new();
    // rust: if (0..columns.sections).contains(&from.1) {
    // rust: nodes.insert(
    // rust: from,
    // rust: Node {
    // rust: directions: 0,
    // rust: sources: 0,
    // rust: },
    // rust: );
    // rust: queue.push_back(from);
    // rust: } else {
            // initializeQueueForFullUpdate from outside the world.
    // rust: let above = from.1 >= columns.sections;
    // rust: let (y, travel) = if above {
    // rust: (columns.sections - 1, 0)
    // rust: } else {
    // rust: (0, 1)
}
    // rust: let camera_block = [camera.x.floor() as i64, camera.z.floor() as i64];
    // rust: let mut seeds = Vec::new();
    // rust: for x in -radius..=radius {
    // rust: for z in -radius..=radius {
    // rust: let key = (from.0 + x, y, from.2 + z);
    // rust: let mut directions = 1 << travel;
    // rust: if x > 0 {
    // rust: directions |= 1 << 5;
    // rust: } else if x < 0 {
    // rust: directions |= 1 << 4;
}
    // rust: if z > 0 {
    // rust: directions |= 1 << 3;
    // rust: } else if z < 0 {
    // rust: directions |= 1 << 2;
}
    // rust: let origin = block(key);
    // rust: let dx = camera_block[0] - i64::from(origin[0] + 8);
    // rust: let dz = camera_block[1] - i64::from(origin[2] + 8);
    // rust: seeds.push((dx * dx + dz * dz, key, directions));
}
}
    // rust: seeds.sort_by_key(|seed| seed.0);
    // rust: for (_, key, directions) in seeds {
    // rust: nodes.insert(
    // rust: key,
    // rust: Node {
    // rust: directions,
    // rust: sources: 1 << travel,
    // rust: },
    // rust: );
    // rust: queue.push_back(key);
}
}
    // rust: while let Some(key) = queue.pop_front() {
    // rust: let node = &nodes[&key];
    // rust: let (directions, sources) = (node.directions, node.sources);
    // rust: let vis = columns.get(key);
    // rust: let distant = (key.0 - from.0).abs() > 3
    // rust: || (key.1 - from.1).abs() > 3
    // rust: || (key.2 - from.2).abs() > 3;
    // rust: for (d, step) in STEPS.iter().enumerate() {
    // rust: let next = (key.0 + step.0, key.1 + step.1, key.2 + step.2);
    // rust: if next.1 < -1 || next.1 > columns.sections || index(next).is_none() {
    // rust: continue;
}
    // rust: if directions & (1 << (d ^ 1)) != 0 {
    // rust: continue;
}
                // facesCanSeeEachother(source.getOpposite(), direction).
    // rust: if sources != 0
    // rust: && !(0..6)
    // rust: .any(|s| sources & (1 << s) != 0 && vis & (1 << ((s ^ 1) * 6 + d)) != 0)
    // rust: {
    // rust: continue;
}
    // rust: if rays && distant {
    // rust: let origin = block(key);
    // rust: let max = |c: usize| {
    // rust: if c == axis(d) {
    // rust: centre[c] > origin[c]
    // rust: } else {
    // rust: centre[c] < origin[c]
}
}
    // rust: let mut check = DVec3::new(
    // rust: f64::from(origin[0] + if max(0) { 16 } else { 0 }),
    // rust: f64::from(origin[1] + if max(1) { 16 } else { 0 }),
    // rust: f64::from(origin[2] + if max(2) { 16 } else { 0 }),
    // rust: );
    // rust: let length = |v: DVec3| (v.x * v.x + (v.y * v.y + v.z * v.z)).sqrt();
    // rust: let to = camera - check;
    // rust: let step = to * (1.0 / length(to)) * 28.0;
    // rust: let mut visible = true;
    // rust: while length(check - camera).powi(2) > 3600.0 {
    // rust: check += step;
    // rust: let max_y = columns.min_y + columns.sections * 16 - 1;
    // rust: if check.y > f64::from(max_y) || check.y < f64::from(columns.min_y) {
    // rust: break;
}
    // rust: let section = columns.section_of(check);
    // rust: if !nodes.contains_key(&section) {
    // rust: visible = false;
    // rust: break;
}
}
    // rust: if !visible {
    // rust: continue;
}
}
    // rust: match nodes.get_mut(&next) {
    // rust: Some(existing) => existing.sources |= 1 << d,
    // rust: None => {
    // rust: nodes.insert(
    // rust: next,
    // rust: Node {
    // rust: directions: directions | 1 << d,
    // rust: sources: 1 << d,
    // rust: },
    // rust: );
    // rust: queue.push_back(next);
}
}
}
}
    // rust: let mut reached = vec![false; (side * side * height) as usize];
    // rust: for key in nodes.keys() {
    // rust: reached[index(*key).unwrap()] = true;
}
    // rust: reached
}

pub fn random_world(o: *mut Occlusion, seed: u64, count: usize, spread: i32) void {
}
    // rust: let mut seed = seed;
    // rust: let mut next = || {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: seed
}
    // rust: let span = (2 * spread + 1) as u64;
    // rust: for _ in 0..count {
    // rust: let r = next();
    // rust: let key = (
    // rust: (r % span) as i32 - spread,
    // rust: ((r >> 8) % 6) as i32,
    // rust: ((r >> 16) % span) as i32 - spread,
    // rust: );
            // Open, half open or nearly closed sections.
    // rust: let vis = match r >> 40 & 3 {
    // rust: 0 => next() & next() & next(),
    // rust: 1 => next(),
    // rust: _ => next() | next(),
}
    // rust: o.set(key, vis & ALL_VISIBLE);
}
}

pub fn reached(o: *Occlusion) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let graph = o.graph.as_ref().expect("searched");
    // rust: graph.directions.iter().map(|&d| d & REACHED != 0).collect()
}

    /// The graph is vanilla's, cell for cell, near the camera and beyond the
    /// distant step test's 60 blocks.
pub fn same_sections_as_vanilla() void {
}
    // rust: let (mut hidden, mut rayed) = (0, 0);
    // rust: for seed in [0x9e37_79b9, 7, 0xdead_beef] {
    // rust: for (spread, count, radius) in [(6, 900, 6), (12, 2600, 12)] {
    // rust: let mut o = Occlusion::new(0, 6);
    // rust: random_world(&mut o, seed, count, spread);
    // rust: for from in [(0, 2, 0), (3, 0, -2), (-5, 5, 4), (1, -1, 1), (0, 7, 0)] {
                    // Off-centre, so the rays are not axis-aligned.
    // rust: let camera = at(from) + DVec3::new(3.3, -5.7, 1.9);
    // rust: o.settle(camera, radius);
    // rust: o.settle(camera, radius);
    // rust: let reached = reached(&o);
    // rust: assert_eq!(
    // rust: reached,
    // rust: reference(&o.columns, camera, radius, true),
    // rust: "{seed} {from:?} {radius}"
    // rust: );
    // rust: let no_rays = reference(&o.columns, camera, radius, false);
    // rust: rayed += no_rays
    // rust: .iter()
    // rust: .zip(&reached)
    // rust: .filter(|(a, b)| **a && !**b)
    // rust: .count();
    // rust: hidden += reached.iter().filter(|&&r| !r).count();
}
}
}
    // rust: assert!(hidden > 1000, "the worlds hide sections ({hidden})");
    // rust: assert!(
    // rust: rayed > 100,
    // rust: "the distant step test culls sections ({rayed})"
    // rust: );
}

    /// A clamped search may conservatively show sections above its searched
    /// box, but it must never hide one that the full-height search reaches.
pub fn vertical_clamping_only_adds_overdraw() void {
}
    // rust: let mut compared = 0;
    // rust: let mut overdraw = 0;
    // rust: let mut clamped = 0;
    // rust: for seed in [0x9e37_79b9, 7, 0xdead_beef, 0x2545_f491] {
    // rust: for (spread, count, radius) in [(6, 900, 6), (12, 2600, 12)] {
    // rust: let mut o = Occlusion::new(0, 24);
    // rust: random_world(&mut o, seed, count, spread);
    // rust: let camera = at((0, 2, 0)) + DVec3::new(3.3, -5.7, 1.9);
    // rust: o.settle(camera, radius);
    // rust: let graph = o.graph.as_ref().expect("searched");
    // rust: clamped += usize::from(graph.height < o.columns.sections + 2);
    // rust: let full = reference(&o.columns, camera, radius, true);
    // rust: let from = o.columns.section_of(camera);
    // rust: let side = 2 * radius + 1;
    // rust: let height = o.columns.sections + 2;
    // rust: let full_contains = |key: SectionKey| {
    // rust: let (dx, dz, dy) = (key.0 - from.0, key.2 - from.2, key.1 + 1);
    // rust: if dx.abs() > radius || dz.abs() > radius || !(0..height).contains(&dy) {
    // rust: return false;
}
    // rust: full[(((dz + radius) * side + dx + radius) * height + dy) as usize]
}
    // rust: for x in from.0 - radius..=from.0 + radius {
    // rust: for z in from.2 - radius..=from.2 + radius {
    // rust: for y in -1..=o.columns.sections {
    // rust: let key = (x, y, z);
    // rust: let expected = full_contains(key);
    // rust: let actual = o.contains(key);
    // rust: compared += 1;
    // rust: assert!(
    // rust: !expected || actual,
    // rust: "clamped search hid {key:?} for seed {seed:#x}, spread {spread}, radius {radius}; from={from:?}, y0={}, height={}, expected={expected}, actual={actual}",
    // rust: graph.y0,
    // rust: graph.height
    // rust: );
    // rust: overdraw += usize::from(actual && !expected);
    // rust: if actual && !expected {
    // rust: assert!(
    // rust: y >= graph.y0 + graph.height,
    // rust: "overdraw must be above the clamped box: {key:?}, y0={}, height={}",
    // rust: graph.y0,
    // rust: graph.height
    // rust: );
}
}
}
}
}
}
    // rust: assert!(clamped > 0, "the comparison exercised a clamped search");
    // rust: assert!(compared > 50_000, "compared {compared} sections");
    // rust: assert!(overdraw > 0, "the conservative top-cell rule was exercised");
}

    /// A line checked again from the sample it failed at, after more
    /// sections were reached, ends where checking it from its corner does.
pub fn a_line_checked_again_resumes_where_it_failed() void {
}
    // rust: let mut seed = 0x2545_f491_u64;
    // rust: let mut next = || {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: seed
}
    // rust: let columns = Columns::new(-64, 24);
    // rust: let mut graph = Graph::default();
    // rust: let (mut vis, mut queue) = (Vec::new(), VecDeque::new());
    // rust: let (mut resumed, mut seen) = (0, 0);
    // rust: for _ in 0..40 {
    // rust: let camera = DVec3::new(
    // rust: (next() % 3000) as f64 / 100.0 - 15.0,
    // rust: (next() % 30000) as f64 / 100.0 - 60.0,
    // rust: (next() % 3000) as f64 / 100.0 - 15.0,
    // rust: );
            // Open air: every section reached; then holes along the lines.
    // rust: graph.search(&columns, camera, 12, &mut vis, &mut queue);
    // rust: for cell in graph.directions.iter_mut() {
    // rust: if next() % 4 == 0 {
    // rust: *cell = 0;
}
}
    // rust: let from = graph.from;
    // rust: for _ in 0..25 {
    // rust: let corner = (
    // rust: from.0 + (next() % 25) as i32 - 12,
    // rust: graph.y0 + (next() % graph.height as u64) as i32,
    // rust: from.2 + (next() % 25) as i32 - 12,
    // rust: );
    // rust: let mut known = 0;
    // rust: while let Some(failed) = graph.walk(corner, camera, known) {
    // rust: for earlier in 0..=failed {
    // rust: assert_eq!(graph.walk(corner, camera, earlier), Some(failed));
}
    // rust: known = failed;
    // rust: resumed += 1;
                    // More sections reached, as the search goes on.
    // rust: for cell in graph.directions.iter_mut() {
    // rust: if next() % 3 == 0 {
    // rust: *cell |= REACHED;
}
}
    // rust: assert_eq!(
    // rust: graph.walk(corner, camera, known),
    // rust: graph.walk(corner, camera, 0)
    // rust: );
}
    // rust: seen += usize::from(known > 1);
}
}
    // rust: assert!(resumed > 200 && seen > 50, "{resumed} {seen}");
}

    /// #782 rule 2: behind a wall, a section the search reaches around its
    /// edge is culled when the line to the camera crosses the wall's shadow.
pub fn distant_sections_behind_a_wall_are_culled() void {
}
    // rust: let mut o = Occlusion::new(0, 4);
        // A closed wall at x 2, z -2..=2, the whole height.
    // rust: for z in -2..=2 {
    // rust: for y in -1..=4 {
    // rust: o.set((2, y, z), 0);
}
}
    // rust: let camera = at((0, 1, 0));
    // rust: o.settle(camera, 12);
    // rust: let no_rays = reference(&o.columns, camera, 12, false);
    // rust: let graph = o.graph.as_ref().expect("searched");
    // rust: let behind = graph.index((9, 1, 3)).unwrap();
    // rust: assert!(no_rays[behind], "reached around the wall's edge");
    // rust: assert!(
    // rust: !o.contains((9, 1, 3)),
    // rust: "but its line to the camera is hidden"
    // rust: );
    // rust: assert!(o.contains((9, 1, 9)), "a section off to the side is seen");
}

    /// `cargo test --profile fast -p horizon-client --lib occlusion::tests::search_cost -- --ignored --nocapture`:
    /// full searches at render distance 32 over a world with open sky above
    /// y 64 and caves below it.
pub fn search_cost() void {
}
    // rust: let mut o = Occlusion::new(-64, 24);
    // rust: let mut seed = 0x9e37_79b9_u64;
    // rust: let mut next = || {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: seed
}
    // rust: for x in -40..=40 {
    // rust: for z in -40..=40 {
    // rust: for y in 0..24 {
    // rust: let vis = if y >= 8 {
    // rust: ALL_VISIBLE
    // rust: } else if next() % 5 == 0 {
    // rust: next() & ALL_VISIBLE
    // rust: } else {
    // rust: 0
}
    // rust: o.set((x, y, z), vis);
}
}
}
    // rust: let camera = DVec3::new(3.3, 70.2, -5.6);
    // rust: let (mut vis, mut queue) = (Vec::new(), VecDeque::new());
    // rust: let mut graph = Graph::default();
    // rust: let mut best = f64::MAX;
    // rust: for _ in 0..12 {
    // rust: let started = std::time::Instant::now();
    // rust: graph.search(&o.columns, camera, 34, &mut vis, &mut queue);
    // rust: best = best.min(started.elapsed().as_secs_f64() * 1000.0);
}
    // rust: let reached = graph
    // rust: .directions
    // rust: .iter()
    // rust: .filter(|&&d| d & REACHED != 0)
    // rust: .count();
    // rust: println!("search_cost: best {best:.2} ms over 12, {reached} reached");
}

    /// Removed columns see through every face: the graph is the one of a world that
    /// never had them, whether some columns go or all of them (a teleport).
pub fn removed_columns_leave_the_graph_of_a_world_without_them() void {
}
pub fn without(o: *Occlusion, gone: *FxHashSet<(i32) void {
}
    // rust: let mut fresh = Occlusion::new(0, 6);
    // rust: for (&(x, z), column) in &o.columns.map {
    // rust: if !gone.contains(&(x, z)) {
    // rust: for (y, &vis) in column.iter().enumerate() {
    // rust: fresh.set((x, y as i32, z), vis);
}
}
}
    // rust: fresh
}
    // rust: let camera = at((0, 2, 0));
    // rust: let mut o = Occlusion::new(0, 6);
    // rust: random_world(&mut o, 0x51ed_2701, 900, 6);
    // rust: o.settle(camera, 6);
    // rust: let some: FxHashSet<(i32, i32)> = (-6..=6)
    // rust: .flat_map(|x| (-1..=1).map(move |z| (x, z)))
    // rust: .collect();
    // rust: let mut expected = without(&o, &some);
    // rust: o.remove_columns(&some);
    // rust: o.settle(camera, 6);
    // rust: expected.settle(camera, 6);
    // rust: let graph = |o: &Occlusion| o.graph.as_ref().expect("searched").directions.clone();
    // rust: assert_eq!(graph(&o), graph(&expected));

    // rust: let all: FxHashSet<(i32, i32)> = o.columns.map.keys().copied().collect();
    // rust: o.remove_columns(&all);
    // rust: assert!(o.contains((40, 3, 40)), "no graph from the old view culls");
    // rust: random_world(&mut o, 0x2545_f491, 900, 6);
    // rust: let mut arrived = Occlusion::new(0, 6);
    // rust: random_world(&mut arrived, 0x2545_f491, 900, 6);
    // rust: o.settle(camera, 6);
    // rust: arrived.settle(camera, 6);
    // rust: assert_eq!(graph(&o), graph(&arrived));
}

    /// The worker's graph is the one the render thread would compute.
pub fn the_worker_matches_a_search_on_the_render_thread() void {
}
    // rust: let mut o = Occlusion::new(0, 6);
    // rust: random_world(&mut o, 0x9e37_79b9, 800, 6);
    // rust: for from in [(0, 2, 0), (3, 0, -2), (-5, 5, 4)] {
    // rust: let camera = at(from);
    // rust: o.settle(camera, 6);
    // rust: o.settle(camera, 6);
    // rust: let mut local = Graph::default();
    // rust: local.search(&o.columns, camera, 6, &mut Vec::new(), &mut VecDeque::new());
    // rust: let graph = o.graph.as_ref().expect("searched");
    // rust: assert_eq!(graph.directions, local.directions);
    // rust: assert_eq!(graph.entered, local.entered);
}
}

pub fn vertical_clamping_bounds_height_and_reaches_open_sky() void {
}
    // rust: let mut o = Occlusion::new(0, 24);
    // rust: o.set((0, 5, 0), 0); // Wall at section 5
    // rust: o.settle(at((0, 2, 0)), 4);
    // rust: let graph = o.graph.as_ref().expect("searched");
    // rust: assert_eq!(graph.height, 5 + 3);
    // rust: assert!(o.contains((0, 2, 0)), "camera section is reached");
    // rust: assert!(o.contains((1, 20, 1)), "open air column is reached");

        // An enclosed cave cannot reach the sky
    // rust: let mut cave = Occlusion::new(0, 24);
    // rust: for (dx, dy, dz) in STEPS {
    // rust: cave.set((dx, 1 + dy, dz), 0);
}
    // rust: cave.settle(at((0, 1, 0)), 4);
    // rust: assert!(
    // rust: !cave.contains((0, 10, 0)),
    // rust: "enclosed cave does not see the sky"
    // rust: );
}

    /// `contains` over the columns `radius` + 3 around `from`, from two
    /// sections below the level to two above it, checked against the graph
    /// `reach` exports: `None` exactly without a graph, the same answer for
    /// every key, nothing past its box, its bits its cells' `REACHED`, and its
    /// sky band reached exactly when a bit of its top layer is.
pub fn answers(o: *Occlusion, from: SectionKey, radius: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let reach = o.reach();
    // rust: assert_eq!(reach.is_some(), o.graph.is_some(), "a graph exported");
    // rust: assert!(o.reach_is_exact(), "the bits are the cells'");
    // rust: if let Some(g) = &o.graph {
    // rust: let height = g.height as usize;
    // rust: let mut top = (height - 1..g.directions.len()).step_by(height);
    // rust: let sky = top.any(|i| (g.bits[i / 32] >> (i % 32)) & 1 != 0);
    // rust: assert_eq!(g.sky_reached, sky, "the sky band");
}
    // rust: let past = |key: SectionKey| {
    // rust: o.graph.as_ref().is_some_and(|g| {
    // rust: (key.0 - g.from.0).abs() > g.radius
    // rust: || (key.2 - g.from.2).abs() > g.radius
    // rust: || !(g.y0..=g.sections).contains(&key.1)
    // rust: })
}
    // rust: let mut answers = Vec::new();
    // rust: for x in from.0 - radius - 3..=from.0 + radius + 3 {
    // rust: for z in from.2 - radius - 3..=from.2 + radius + 3 {
    // rust: for y in -2..=o.columns.sections + 1 {
    // rust: let key = (x, y, z);
    // rust: let contains = o.contains(key);
    // rust: assert_eq!(reach.is_none_or(|r| r.contains(key)), contains, "{key:?}");
    // rust: assert!(!(contains && past(key)), "{key:?} past the box");
    // rust: answers.push(contains);
}
}
}
    // rust: answers
}

    /// The graph `reach` exports answers as `contains` (`answers`): walled in,
    /// opened by a partial update, cleared; over clamped boxes, the sky band
    /// above them reached or not (a closed cave); from above the world. The
    /// search, the partial update and `clear` each change the generation, and
    /// another level's graph never repeats one.
pub fn the_exported_graph_answers_as_contains() void {
}
    // rust: let mut o = Occlusion::new(0, 4);
    // rust: let first = o.generation();
    // rust: answers(&o, (0, 1, 0), 3);
    // rust: for (dx, dy, dz) in STEPS {
    // rust: o.set((dx, 1 + dy, dz), 0);
}
    // rust: o.settle(at((0, 1, 0)), 3);
    // rust: assert_ne!(o.generation(), first, "a search landed");
    // rust: let walled = answers(&o, (0, 1, 0), 3);
    // rust: let searched = o.generation();
    // rust: o.set((0, 1, 1), ALL_VISIBLE);
    // rust: o.update(at((0, 1, 0)), 3);
    // rust: assert_ne!(o.generation(), searched, "a partial update reached more");
    // rust: assert_ne!(answers(&o, (0, 1, 0), 3), walled);
    // rust: let opened = o.generation();
    // rust: o.clear();
    // rust: assert_ne!(o.generation(), opened, "the graph went");
    // rust: answers(&o, (0, 1, 0), 3);
        // Another level's graph never takes one of this one's generations, or
        // the pass would keep its copy of this one.
    // rust: let mut other = Occlusion::new(0, 4);
    // rust: other.settle(at((0, 1, 0)), 3);
    // rust: assert_ne!(other.generation(), searched, "another level's graph");

    // rust: let (mut clamped, mut band) = (0, [0; 2]);
    // rust: let mut check = |mut o: Occlusion, camera: DVec3, radius: i32| {
    // rust: o.settle(camera, radius);
    // rust: answers(&o, o.columns.section_of(camera), radius);
    // rust: let g = o.graph.as_ref().expect("searched");
    // rust: if g.height < o.columns.sections + 2 {
    // rust: clamped += 1;
                // The first section above the box, over the camera's column.
    // rust: band[usize::from(o.contains((g.from.0, g.y0 + g.height, g.from.2)))] += 1;
}
}
    // rust: for seed in [0x9e37_79b9, 7, 0xdead_beef, 0x2545_f491] {
    // rust: for (spread, count, radius) in [(6, 900, 6), (12, 2600, 12)] {
    // rust: let mut o = Occlusion::new(0, 24);
    // rust: random_world(&mut o, seed, count, spread);
    // rust: check(o, at((0, 2, 0)) + DVec3::new(3.3, -5.7, 1.9), radius);
}
}
    // rust: let mut cave = Occlusion::new(0, 24);
    // rust: for (dx, dy, dz) in STEPS {
    // rust: cave.set((dx, 1 + dy, dz), 0);
}
    // rust: check(cave, at((0, 1, 0)), 4);
    // rust: let mut above = Occlusion::new(0, 24);
    // rust: random_world(&mut above, 7, 900, 6);
    // rust: check(above, DVec3::new(3.3, 400.0, -5.6), 6);
    // rust: assert!(
    // rust: clamped > 0 && band[0] > 0 && band[1] > 0,
    // rust: "{clamped} clamped, the band above hidden and seen {band:?}"
    // rust: );
}

    /// Whenever an answer of `contains` changes, so does the generation: over
    /// 300 random steps, each a section set (open, closed or anything between),
    /// a column removed, the camera moved to another section (now and then
    /// above or below the world), or now and then another world, after a
    /// `clear` or a teleport that drops every column (`remove_columns`), each
    /// followed by a frame's `update` or a settled search; then an update from
    /// a section the graph never reached. The exported graph answers as
    /// `contains` after every step.
pub fn every_change_of_the_answers_changes_the_generation() void {
}
    // rust: let mut seed = 0x0bad_5eed_u64;
    // rust: let mut next = || {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: seed
}
    // rust: let (spread, radius, around) = (5, 3, (0, 0, 0));
    // rust: let offset = DVec3::new(3.3, -5.7, 1.9);
    // rust: let mut o = Occlusion::new(0, 24);
    // rust: random_world(&mut o, 0x2545_f491, 400, spread);
    // rust: let mut camera = at((0, 2, 0)) + offset;
    // rust: o.settle(camera, radius);
    // rust: let mut last = (o.generation(), answers(&o, around, spread + radius));
    // rust: let mut changed = 0;
    // rust: for step in 0..300 {
    // rust: let r = next();
    // rust: let key = (
    // rust: (r % 11) as i32 - spread,
    // rust: ((r >> 8) % 7) as i32,
    // rust: ((r >> 16) % 11) as i32 - spread,
    // rust: );
    // rust: match r >> 24 & 15 {
    // rust: 0..=7 => {
    // rust: let vis = match r >> 28 & 3 {
    // rust: 0 => ALL_VISIBLE,
    // rust: 1 => 0,
    // rust: _ => next() & ALL_VISIBLE,
}
    // rust: o.set(key, vis);
}
    // rust: 8 | 9 => o.remove_column(key.0, key.2),
    // rust: 10..=13 => {
    // rust: let y = match r >> 32 & 7 {
    // rust: 0 => 30,
    // rust: 1 => -3,
    // rust: _ => key.1,
}
    // rust: camera = at((key.0, y, key.2)) + offset;
}
    // rust: _ if r >> 36 & 7 == 0 => {
    // rust: o.clear();
    // rust: random_world(&mut o, next(), 400, spread);
}
    // rust: _ if r >> 36 & 7 == 1 => {
                    // A teleport: every column goes at once.
    // rust: let all: FxHashSet<_> = o.columns.map.keys().copied().collect();
    // rust: o.remove_columns(&all);
    // rust: random_world(&mut o, next(), 400, spread);
}
    // rust: _ => {}
}
    // rust: if r >> 40 & 1 == 0 {
    // rust: o.update(camera, radius);
    // rust: } else {
    // rust: o.settle(camera, radius);
}
    // rust: let now = (o.generation(), answers(&o, around, spread + radius));
    // rust: if now.1 != last.1 {
    // rust: assert_ne!(
    // rust: now.0, last.0,
    // rust: "step {step}: answers changed, the generation not"
    // rust: );
    // rust: changed += 1;
}
    // rust: last = now;
}
    // rust: assert!(changed >= 50, "{changed} steps changed answers");
        // Walled in, then past the wall: the graph never reached the camera's
        // section, and goes until the next search lands. (The first settle may
        // land a search that started before the wall.)
    // rust: for (dx, dy, dz) in STEPS {
    // rust: o.set((dx, 1 + dy, dz), 0);
}
    // rust: o.settle(at((0, 1, 0)), radius);
    // rust: o.settle(at((0, 1, 0)), radius);
    // rust: let walled = (o.generation(), answers(&o, around, spread + radius));
    // rust: assert!(!o.contains((3, 1, 0)), "past the wall");
    // rust: o.update(at((3, 1, 0)), radius);
    // rust: assert_ne!(answers(&o, around, spread + radius), walled.1);
    // rust: assert_ne!(o.generation(), walled.0, "the graph went");
}
}
