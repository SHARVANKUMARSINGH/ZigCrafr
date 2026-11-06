//! Transpiled from Horizon Rust crate
//! Module: horizon-client_lod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Speculative decoration is isolated from gameplay and never writes normal saves.
// use super::*;
// use crate::{
    // rust: fast_hash::{FxHashMap, FxHashSet},
    // rust: lod::{Column, Span, Surface},
    // rust: streaming::LodDetail,
}
// use horizon_world::{
    // rust: heightmap::HeightmapState,
    // rust: registry::BlockStateId,
    // rust: worldgen::{
    // rust: decoration_order::vanilla_order,
    // rust: generator::{GenBlockStates, GeneratorError},
    // rust: },
}
// use std::{
    // rust: collections::VecDeque,
    // rust: sync::{
    // rust: Condvar, Mutex,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: mpsc,
    // rust: },
    // rust: thread,
}

    // rust: mod islands;
    // rust: mod vegetation;
// use islands::EndIslands;
// use vegetation::Vegetation;
pub const CACHE: usize = 1024;
/// Chunks waiting for decoration: enough batches to keep every thread busy.
pub const REQUESTS: usize = 1024;
/// Chunks a side a decoration batch emits. Each needs a two-chunk border of
/// proto chunks, which the batch shares: 4 built four protos per chunk, 8
/// builds 2.25, and the protos (noise, surface) are most of far decoration.
pub const BATCH: i32 = 8;
pub fn batch_origin() void {
}
    // rust: (x.div_euclid(BATCH) * BATCH, z.div_euclid(BATCH) * BATCH)
}
pub const Requests = struct {
    chunks: FxHashSet<(i32,
    center: [i32,
    /// The batches the decoration threads are working on.
    current: FxHashSet<(i32,
    finished: FxHashSet<(i32,
};
pub const Shared = struct {
    requests: Mutex<Requests>,
    wake: Condvar,
    stop: AtomicBool,
};
pub fn distance() void {
}
    // rust: let dx = i64::from(x * 16 + 8 - center[0]);
    // rust: let dz = i64::from(z * 16 + 8 - center[1]);
    // rust: dx * dx + dz * dz
}
pub const Builder = struct {
    shared: *Shared,
    results: mpsc::Receiver<LodDetail>,
    threads: std.ArrayList(thread::JoinHandle<())>,
};
    // rust: impl Builder {
pub fn new(terrain: *VanillaTerrain, background: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shared = Arc::new(Shared {
    // rust: requests: Mutex::new(Requests::default()),
    // rust: wake: Condvar::new(),
    // rust: stop: AtomicBool::new(false),
    // rust: });
    // rust: let (tx, results) = mpsc::channel();
        // Idle priority: decoration only takes time the near chunks, the
        // ticks and the frame leave, so more cores can share it: a third of
        // the threads, rounded up (a 4-thread machine's one thread left idle
        // time while the far trees and structures came in).
    // rust: let count = horizon_threads::worker_count().div_ceil(3).clamp(1, 12);
    // rust: let threads = (0..count)
    // rust: .map(|_| Self::spawn(terrain.clone(), shared.clone(), tx.clone(), background))
    // rust: .collect();
    // rust: Self {
    // rust: shared,
    // rust: results,
    // rust: threads,
}
}
    // rust: fn spawn(
    // rust: terrain: Arc<VanillaTerrain>,
    // rust: worker: Arc<Shared>,
    // rust: tx: mpsc::Sender<LodDetail>,
    // rust: background: bool,
    // rust: ) -> thread::JoinHandle<()> {
    // rust: thread::Builder::new()
    // rust: .name("Far decoration".into())
    // rust: .spawn(move || {
    // rust: if background {
    // rust: horizon_threads::idle_current();
}
                // A superflat world's far ring is its flat ground (`FlatTerrain::lod_surface`);
                // a normal overworld rebuilt here would draw hills, oceans and trees.
    // rust: if terrain.is_flat() {
    // rust: worker.stop.store(true, Ordering::Relaxed);
    // rust: return;
}
                // Structure pieces have mutable one-shot placement flags. Sharing
                // gameplay's seeded pipeline would consume its chests/spawners.
    // rust: let generator = match OverworldGenerator::for_dimension(
    // rust: terrain.generator.data().clone(),
    // rust: terrain.seed,
    // rust: &terrain.preset,
    // rust: &terrain.dimension,
    // rust: ) {
    // rust: Ok(generator) => generator,
    // rust: Err(error) => {
    // rust: log::warn!("Horizon: far decoration unavailable: {error}");
    // rust: worker.stop.store(true, Ordering::Relaxed);
    // rust: return;
}
}
    // rust: let mut state = generator.worker();
    // rust: loop {
    // rust: let key = {
    // rust: let mut requests = worker.requests.lock().unwrap();
    // rust: while requests.chunks.is_empty() && !worker.stop.load(Ordering::Relaxed) {
    // rust: requests = worker.wake.wait(requests).unwrap();
}
    // rust: if worker.stop.load(Ordering::Relaxed) {
    // rust: break;
}
    // rust: let key = *requests
    // rust: .chunks
    // rust: .iter()
    // rust: .min_by_key(|&&key| (distance(key, requests.center), key))
    // rust: .unwrap();
    // rust: let origin = batch_origin(key);
    // rust: requests.chunks.retain(|&key| batch_origin(key) != origin);
    // rust: requests.current.insert(origin);
    // rust: origin
}
    // rust: let result = decorated_batch(&mut state, key, BATCH, &worker.stop, |chunk| {
    // rust: let pos = chunk.position();
    // rust: let key = (pos.x, pos.z);
    // rust: worker.requests.lock().unwrap().finished.insert(key);
    // rust: let columns = columns(chunk, &terrain.biome_map, &terrain.dimension);
    // rust: if tx.send((key, columns)).is_err() {
    // rust: worker.stop.store(true, Ordering::Relaxed);
}
    // rust: });
    // rust: worker.requests.lock().unwrap().current.remove(&key);
    // rust: match result {
    // rust: Ok(_) => {}
    // rust: Err(error) => {
    // rust: log::warn!(
    // rust: "Horizon: far decoration failed at {} {}: {error}",
    // rust: key.0,
    // rust: key.1
    // rust: );
    // rust: worker.stop.store(true, Ordering::Relaxed);
    // rust: break;
}
}
}
    // rust: })
    // rust: .expect("far decoration worker")
}
pub fn request(self: *Self, chunks: *[(i32) void {
}
    // rust: if self.shared.stop.load(Ordering::Relaxed) {
    // rust: return;
}
    // rust: let mut requests = self.shared.requests.lock().unwrap();
    // rust: requests.center = center;
    // rust: for &key in chunks {
    // rust: if !requests.current.contains(&batch_origin(key)) && !requests.finished.contains(&key) {
    // rust: requests.chunks.insert(key);
}
}
    // rust: if requests.chunks.len() > REQUESTS {
    // rust: let mut sorted: Vec<_> = requests.chunks.iter().copied().collect();
    // rust: sorted.sort_unstable_by_key(|&key| (distance(key, center), key));
    // rust: requests.chunks = sorted.into_iter().take(REQUESTS).collect();
}
    // rust: self.shared.wake.notify_all();
}
}
    // rust: impl Drop for Builder {
pub fn drop(self: *Self) void {
}
        // Under the lock the threads check it with: one between its check and
        // its wait missed the wake, and closing the world waited forever.
    // rust: let requests = self.shared.requests.lock();
    // rust: self.shared.stop.store(true, Ordering::Relaxed);
    // rust: drop(requests);
    // rust: self.shared.wake.notify_all();
    // rust: for thread in self.threads.drain(..) {
    // rust: let _ = thread.join();
}
}
}

/// Share the two-chunk terrain halo and one-chunk feature halo across adjacent
/// targets. Emit each target only after all nine feature centers have run.
/// These proto chunks never enter World, lighting or normal save queues.
    // rust: fn decorated_batch(
    // rust: worker: &mut GeneratorWorker,
    // rust: origin: (i32, i32),
    // rust: size: i32,
    // rust: stop: &AtomicBool,
    // rust: mut emit: impl FnMut(&ProtoChunk),
    // rust: ) -> Result<FxHashMap<(i32, i32), ProtoChunk>, GeneratorError> {
    // Each region starts afresh; flags from a previous speculative structure
    // placement must not suppress blocks in this region.
    // rust: worker.forget_structure_starts();
    // rust: let mut chunks = FxHashMap::default();
    // rust: for dx in -2..size + 2 {
    // rust: for dz in -2..size + 2 {
    // rust: if stop.load(Ordering::Relaxed) {
    // rust: return Ok(FxHashMap::default());
}
    // rust: let key = (origin.0 + dx, origin.1 + dz);
    // rust: chunks.insert(key, worker.generate_proto(ChunkPos::new(key.0, key.1))?);
}
}
    // rust: let mut remaining: FxHashMap<_, u8> = (0..size)
    // rust: .flat_map(|x| (0..size).map(move |z| ((origin.0 + x, origin.1 + z), 9)))
    // rust: .collect();
    // rust: let center = (origin.0 + size / 2, origin.1 + size / 2);
    // rust: for (x, z) in vanilla_order(center, size / 2)
    // rust: .into_iter()
    // rust: .filter(|&(x, z)| {
    // rust: x >= origin.0 - 1 && x <= origin.0 + size && z >= origin.1 - 1 && z <= origin.1 + size
    // rust: })
    // rust: {
    // rust: if stop.load(Ordering::Relaxed) {
    // rust: return Ok(FxHashMap::default());
}
    // rust: let mut region: [ProtoChunk; 9] = std::array::from_fn(|i| {
    // rust: chunks
    // rust: .remove(&(x + i as i32 % 3 - 1, z + i as i32 / 3 - 1))
    // rust: .expect("generated neighborhood")
    // rust: });
    // rust: worker.decorate(&mut region)?;
    // rust: for chunk in region {
    // rust: let pos = chunk.position();
    // rust: chunks.insert((pos.x, pos.z), chunk);
}
    // rust: for dx in -1..=1 {
    // rust: for dz in -1..=1 {
    // rust: let key = (x + dx, z + dz);
    // rust: if let Some(left) = remaining.get_mut(&key) {
    // rust: *left -= 1;
    // rust: if *left == 0 {
    // rust: emit(&chunks[&key]);
}
}
}
}
}
    // rust: assert!(
    // rust: remaining.values().all(|&left| left == 0),
    // rust: "incomplete far decoration halo"
    // rust: );
    // rust: Ok(chunks)
}

    // rust: fn decorated_region(
    // rust: worker: &mut GeneratorWorker,
    // rust: center: (i32, i32),
    // rust: stop: &AtomicBool,
    // rust: ) -> Result<Option<ProtoChunk>, GeneratorError> {
    // rust: Ok(decorated_batch(worker, center, 1, stop, |_| {})?.remove(&center))
}
pub fn columns(chunk: *ProtoChunk, biome_map: *[u16], dimension: []const u8) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let states = chunk.data().block_states();
    // rust: let registry = chunk.data().registry();
    // The level's range, all of it inside its column; the column's bottom
    // stands for "no surface".
    // rust: let (min, height) = (chunk.terrain.min_y(), chunk.terrain.height());
    // rust: let max = min + height;
    // rust: let bottom = crate::chunk::ColumnLayout::of_level(min, height).min_y();
    // rust: let water = registry.default_state("minecraft:water");
    // rust: Arc::new(std::array::from_fn(|index| {
    // rust: let x = (index & 15) as i32;
    // rust: let z = (index >> 4) as i32;
    // rust: let mut column = Column::default();
    // rust: for y in min..max {
    // rust: let mut state = chunk.block(x, y, z);
    // rust: let properties = states.get(state);
    // rust: let mut name = registry.state(state).map_or("", |s| s.name.as_str());
    // rust: if properties.is_air()
    // rust: || (!properties.blocks_motion_in_heightmap()
    // rust: && !properties.has_fluid()
    // rust: && !matches!(name, "minecraft:chorus_plant" | "minecraft:chorus_flower"))
    // rust: {
    // rust: continue;
}
            // Kelp and seagrass hold water: far off they are the water around
            // them, as saved chunks' far columns have them. As spans of their
            // own they hid the seabed with no top face of theirs, a hole
            // where the sky showed through (white dots across the sea).
    // rust: if !properties.blocks_motion_in_heightmap()
    // rust: && properties.has_fluid()
    // rust: && !matches!(name, "minecraft:water" | "minecraft:lava")
    // rust: && let Some(water) = water
    // rust: {
    // rust: state = water;
    // rust: name = "minecraft:water";
}
    // rust: let fluid = matches!(name, "minecraft:water" | "minecraft:lava");
    // rust: let biome = biome_map
    // rust: .get(chunk.biome_id_at(x, y, z).0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(0);
            // shortcut: no propagated far block light, use the normal lighting
            // engine if accurate distant block-light propagation is required.
            // Skylight is `shade_sky`'s, once the column is complete.
    // rust: let light = if dimension == "minecraft:the_nether" {
    // rust: 0
    // rust: } else {
    // rust: 240
    // rust: } | if name == "minecraft:lava" {
    // rust: 15 << 12
    // rust: } else {
    // rust: 0
}
    // rust: column.push(Span {
    // rust: min: y as i16,
    // rust: max: (y + 1) as i16,
    // rust: state,
    // rust: biome,
    // rust: light,
    // rust: });
    // rust: if fluid {
    // rust: let surface = column.surface.get_or_insert(Surface {
    // rust: height: bottom,
    // rust: state: BlockStateId(0),
    // rust: water: None,
    // rust: biome,
    // rust: });
    // rust: surface.water = Some((y + 1, state));
    // rust: } else {
    // rust: column.surface = Some(Surface {
    // rust: height: y + 1,
    // rust: state,
    // rust: water: None,
    // rust: biome,
    // rust: });
}
}
    // rust: if dimension != "minecraft:the_nether" {
    // rust: shade_sky(&mut column, states, Dampening::PerLevel);
}
    // rust: column
    // rust: }))
}
/// How much of its own dampening a run records, for [`shade_sky`]. Either
/// way the light it passes on to the spans under it is the same, so seabeds
/// and the ground under canopies are lit identically.
pub const Dampening = enum {
    /// A span a level, as a real chunk's light has them. A column that
    /// `Column::reduced` merges with its neighbours needs this: a reduction
    /// takes the brightest light of each slice it merges, so one bright span
    /// for a whole sea lit its bed as brightly as its surface.
    PerLevel,
    /// One span for the run, lit as its top is. A previewed column already
    /// stands for a whole far cell and is never reduced against neighbouring
    /// columns, so nothing merges a run with the bed under it, and the levels
    /// between its top and its bottom reach no face that is drawn: the spans
    /// inside a run have neither a top nor a bottom face (`hides` matches on
    /// state, not light), and the side of a run is exposed at its top, where
    /// the light is the run's brightest -- below that the neighbour hides it,
    /// and above it `add_side` raises the light to the neighbour's own sky.
    ///
    /// Over real seed-1234 terrain, nine tiles each at levels 0, 2, 4 and 6,
    /// `PerLevel` leaves 18.7, 12.3, 12.0 and 12.6 spans a column where the
    /// runs themselves are 4.1 to 4.5: 64% to 78% of every stored far span
    /// was a gradient step, and a sea 15 blocks deep or more spent 16 spans
    /// on one.
    PerRun,
};
/// Skylight as it reaches the top of each span straight down from the sky:
/// fluids and leaves take a level per block, as vanilla's dampening does.
/// Full skylight everywhere lit seabeds and the ground under canopies as if
/// they stood in the open.
// ponytail: straight down only. Solid blocks take none, though vanilla's
// stop it: the faces under them that far terrain shows are cliffs and
// overhangs, which vanilla lights sideways from the open air, and they went
// black. The lighting engine for exact light.
pub fn shade_sky(column: *mut Column, states: *GenBlockStates, dampening: Dampening) void {
}
    // rust: shade_runs(
    // rust: column,
    // rust: |id| {
    // rust: let state = states.get(id);
            // A solid block stops no light here, as the note above says; a
            // fluid or leaves take a level a block.
    // rust: !(state.motion && state.no_leaves)
    // rust: },
    // rust: dampening,
    // rust: );
}
/// [`shade_sky`] over a predicate rather than the generator's block states,
/// which have no constructor outside `horizon-world`.
pub fn shade_runs(column: *mut Column, dampens: impl Fn(BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sky = 15u32;
    // rust: let mut shaded = Vec::with_capacity(column.spans.len());
    // rust: for span in column.spans.iter().rev() {
    // rust: let lit = |min, max, sky: u32| Span {
    // rust: min,
    // rust: max,
    // rust: light: (span.light & !0xf0) | (sky << 4) as u16,
    // rust: ..*span
}
    // rust: if !dampens(span.state) {
    // rust: shaded.push(lit(span.min, span.max, sky));
    // rust: continue;
}
    // rust: if dampening == Dampening::PerRun {
    // rust: shaded.push(lit(span.min, span.max, sky));
            // What the per-level walk below leaves, so the spans under the
            // run are lit the same either way.
    // rust: let height = i32::from(span.max) - i32::from(span.min);
    // rust: sky = sky.saturating_sub(height.max(0) as u32);
    // rust: continue;
}
    // rust: let mut top = span.max;
    // rust: while top > span.min {
    // rust: let bottom = if sky == 0 { span.min } else { top - 1 };
    // rust: shaded.push(lit(bottom, top, sky));
    // rust: sky = sky.saturating_sub((top - bottom) as u32);
    // rust: top = bottom;
}
}
    // rust: shaded.reverse();
    // rust: column.spans = shaded.into();
}

/// A wide cell's column is one point of the terrain: a cave, an overhang's
/// lip or the water an aquifer-less sample puts in caves under sea level stood
/// for the whole cell, a slab hanging over air or a band of water in a cliff
/// once its neighbours were lower. Under the top solid span the column is
/// ground: gaps take the span below, buried fluids the ground under them.
pub fn fill_under_surface(column: *mut Column, fluid: impl Fn(BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(top) = column.spans.iter().rposition(|span| !fluid(span.state)) else {
    // rust: return;
}
    // rust: let Some(ground) = column.spans[..=top].iter().find(|span| !fluid(span.state)) else {
    // rust: return;
}
    // rust: let mut state = ground.state;
    // rust: let mut filled = Column {
    // rust: surface: column.surface,
    // rust: spans: crate::lod::Spans::with_capacity(column.spans.len()),
}
    // rust: for (index, &span) in column.spans.iter().enumerate() {
    // rust: let mut span = span;
    // rust: if index <= top {
    // rust: if fluid(span.state) {
    // rust: span.state = state;
    // rust: } else {
    // rust: state = span.state;
}
    // rust: if let Some(below) = filled.spans.last_mut()
    // rust: && below.max < span.min
    // rust: {
    // rust: below.max = span.min;
}
}
    // rust: filled.push(span);
}
    // rust: *column = filled;
}

/// A whole tile inside visited chunks needs no density work at all. This
/// used to evaluate the lattice first and throw all of it away in the per-cell
/// cache check below.
    // rust: fn cached_grid(
    // rust: cache: &FxHashMap<(i32, i32), Arc<[Column; 256]>>,
    // rust: x: i32,
    // rust: z: i32,
    // rust: width: i32,
    // rust: side: usize,
    // rust: ) -> Option<Vec<Column>> {
    // rust: if width > 16 || cache.is_empty() {
    // rust: return None;
}
    // rust: let mut columns = Vec::with_capacity(side * side);
    // rust: for dz in 0..side {
    // rust: for dx in 0..side {
    // rust: let (wx, wz) = (x + dx as i32 * width, z + dz as i32 * width);
    // rust: let cached = cache.get(&(wx >> 4, wz >> 4))?;
    // rust: columns.push(Column::reduced(
    // rust: cached,
    // rust: (wx & 15) as usize,
    // rust: (wz & 15) as usize,
    // rust: width as usize,
    // rust: ));
}
}
    // rust: Some(columns)
}

    // rust: pub(super) struct VanillaLodSampler {
    // rust: generator: Arc<VanillaTerrain>,
    // rust: worker: GeneratorWorker,
    // rust: builder: Option<Builder>,
    // rust: vegetation: Arc<Vegetation>,
    // rust: islands: EndIslands,
    // rust: cache: FxHashMap<(i32, i32), Arc<[Column; 256]>>,
    // rust: order: VecDeque<(i32, i32)>,
    // rust: details: Vec<LodDetail>,
    /// Reduced far detail: `lod_grid` approximates wide cells.
    // rust: approximate: bool,
}
    // rust: impl VanillaLodSampler {
    // rust: pub(super) fn new(generator: Arc<VanillaTerrain>) -> Self {
    // rust: let worker = generator.generator.worker();
    // rust: let builder = Some(Builder::new(generator.clone(), true));
    // rust: let vegetation = Arc::new(Vegetation::new(
    // rust: generator.generator.data(),
    // rust: &generator.biome_map,
    // rust: generator.seed,
    // rust: ));
    // rust: let islands = EndIslands::new(generator.clone());
    // rust: Self {
    // rust: generator,
    // rust: worker,
    // rust: builder,
    // rust: vegetation,
    // rust: islands,
    // rust: cache: FxHashMap::default(),
    // rust: order: VecDeque::new(),
    // rust: details: Vec::new(),
    // rust: approximate: false,
}
}
}
    // rust: impl LodSampler for VanillaLodSampler {
pub fn fork(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(Box::new(Self {
    // rust: generator: self.generator.clone(),
    // rust: worker: self.generator.generator.worker(),
    // rust: builder: None,
    // rust: vegetation: self.vegetation.clone(),
    // rust: islands: self.islands.fork(),
    // rust: cache: FxHashMap::default(),
    // rust: order: VecDeque::new(),
    // rust: details: Vec::new(),
    // rust: approximate: self.approximate,
    // rust: }))
}
pub fn set_approximate(self: *Self, approximate: bool) void {
}
    // rust: self.approximate = approximate;
}
pub fn request_detail(self: *Self, chunks: *[(i32) void {
}
    // rust: let mut missing = Vec::new();
    // rust: for &key in chunks {
    // rust: if let Some(columns) = self.cache.get(&key) {
    // rust: self.details.push((key, columns.clone()));
    // rust: } else {
    // rust: missing.push(key);
}
}
    // rust: if let Some(builder) = &self.builder {
    // rust: builder.request(&missing, center);
}
}
pub fn drain_details(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(builder) = &self.builder else {
    // rust: return std::mem::take(&mut self.details);
}
    // rust: while let Ok((key, columns)) = builder.results.try_recv() {
    // rust: if !self.cache.contains_key(&key) {
    // rust: self.order.push_back(key);
}
    // rust: self.cache.insert(key, columns.clone());
    // rust: while self.cache.len() > CACHE {
    // rust: if let Some(old) = self.order.pop_front() {
    // rust: self.cache.remove(&old);
    // rust: builder
    // rust: .shared
    // rust: .requests
    // rust: .lock()
    // rust: .unwrap()
    // rust: .finished
    // rust: .remove(&old);
}
}
    // rust: self.details.push((key, columns));
}
    // rust: std::mem::take(&mut self.details)
}
pub fn sample(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.column(x, z).surface
}
pub fn column(self: *Self, x: i32, z: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.reduced_column(x, z, 1)
}
pub fn reduced_column(self: *Self, x: i32, z: i32, width: i32) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if width <= 16
    // rust: && let Some(columns) = self.cache.get(&(x >> 4, z >> 4))
    // rust: {
    // rust: return Column::reduced(
    // rust: columns,
    // rust: (x & 15) as usize,
    // rust: (z & 15) as usize,
    // rust: width as usize,
    // rust: );
}
    // rust: self.grid(x, z, width, 1).pop().unwrap_or_default()
}
pub fn grid(self: *Self, x: i32, z: i32, width: i32, side: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(columns) = cached_grid(&self.cache, x, z, width, side) {
    // rust: return columns;
}
    // rust: let samples =
    // rust: match self
    // rust: .worker
    // rust: .lod_grid(x + width / 2, z + width / 2, width, side, self.approximate)
    // rust: {
    // rust: Ok(samples) => samples,
    // rust: Err(error) => {
    // rust: log::warn!("Horizon: direct far sampling failed: {error}");
    // rust: return vec![Column::default(); side * side];
}
}
    // rust: samples
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: .map(|(index, (surface, spans))| {
    // rust: let (wx, wz) = (
    // rust: x + (index % side) as i32 * width,
    // rust: z + (index / side) as i32 * width,
    // rust: );
    // rust: if width <= 16
    // rust: && let Some(columns) = self.cache.get(&(wx >> 4, wz >> 4))
    // rust: {
    // rust: return Column::reduced(
    // rust: columns,
    // rust: (wx & 15) as usize,
    // rust: (wz & 15) as usize,
    // rust: width as usize,
    // rust: );
}
    // rust: self.preview_column(wx + width / 2, wz + width / 2, width, surface, spans)
    // rust: })
    // rust: .collect()
}
}
    // rust: impl VanillaLodSampler {
    // rust: fn preview_column(
    // rust: &mut self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: width: i32,
    // rust: surface: Option<SurfaceSample>,
    // rust: spans: Vec<(i32, i32, BlockStateId)>,
    // rust: ) -> Column {
    // rust: let surface = surface.map(|sample| self.generator.client_surface(sample));
    // rust: let biome = surface.map_or(0, |surface| surface.biome);
    // rust: let registry = self.generator.generator.data().registry();
    // rust: let mut column = Column {
    // rust: surface,
    // rust: spans: crate::lod::Spans::new(),
}
    // rust: for (min, max, state) in spans.into_iter().rev() {
    // rust: column.push(Span {
    // rust: min: min as i16,
    // rust: max: max as i16,
    // rust: state,
    // rust: biome,
    // rust: light: if self.generator.dimension == "minecraft:the_nether" {
    // rust: 0
    // rust: } else {
    // rust: 240
    // rust: } | if registry
    // rust: .state(state)
    // rust: .is_some_and(|s| s.name == "minecraft:lava")
    // rust: {
    // rust: 15 << 12
    // rust: } else {
    // rust: 0
    // rust: },
    // rust: });
}
    // rust: let nether = self.generator.dimension == "minecraft:the_nether";
    // rust: let light = if nether { 0 } else { 240 };
    // rust: if width > 1 && self.generator.dimension == "minecraft:overworld" {
    // rust: let states = self.generator.generator.data().block_states();
    // rust: fill_under_surface(&mut column, |state| states.get(state).has_fluid());
}
    // rust: self.vegetation.apply(&mut column, x, z, width, light);
    // rust: self.islands.apply(&mut column, x, z, width, light);
    // rust: if !nether {
    // rust: shade_sky(
    // rust: &mut column,
    // rust: self.generator.generator.data().block_states(),
    // rust: Dampening::PerRun,
    // rust: );
}
    // rust: column
}
}

    // rust: mod tests {
    /// Either dampening lights everything under a run the same, so seabeds
    /// and the ground under canopies keep the light they had; `PerRun` spends
    /// one span on the run itself where `PerLevel` spends one a level.
pub fn a_run_passes_on_the_same_light_however_much_of_it_it_records() void {
}
//         use super::*;
    // rust: let span = |min: i16, max: i16, state: u32| Span {
    // rust: min,
    // rust: max,
    // rust: state: BlockStateId(state),
    // rust: biome: 0,
    // rust: light: 240,
}
        // State 1 dampens (water), state 2 does not (sand).
    // rust: let dampens = |id: BlockStateId| id == BlockStateId(1);
    // rust: let sky = |span: &Span| (span.light & 0xf0) >> 4;
    // rust: for depth in [1i16, 2, 5, 14, 15, 16, 40] {
    // rust: let bed = span(0, 4, 2);
    // rust: let water = span(4, 4 + depth, 1);
    // rust: let mut level = Column {
    // rust: surface: None,
    // rust: spans: vec![bed, water].into(),
}
    // rust: let mut run = level.clone();
    // rust: shade_runs(&mut level, dampens, Dampening::PerLevel);
    // rust: shade_runs(&mut run, dampens, Dampening::PerRun);

            // The bed is one span either way, lit identically: this is what
            // the per-level walk was added for.
    // rust: assert_eq!(level.spans[0], run.spans[0], "depth {depth}: the bed");
    // rust: assert_eq!(
    // rust: sky(&level.spans[0]),
    // rust: 15u16.saturating_sub(depth.max(0) as u16),
    // rust: "depth {depth}: the bed takes the light the run let through"
    // rust: );
            // The run's top face is the topmost span's, and takes the light
            // arriving at the top of the run: full sky, nothing above it.
    // rust: assert_eq!(sky(level.spans.last().unwrap()), 15, "depth {depth}");
    // rust: assert_eq!(sky(run.spans.last().unwrap()), 15, "depth {depth}");
    // rust: assert_eq!(level.spans.last().unwrap().max, 4 + depth);
    // rust: assert_eq!(run.spans.last().unwrap().max, 4 + depth);
            // One span for the run, against one a level down to the dark.
    // rust: assert_eq!(run.spans.len(), 2, "depth {depth}");
            // A span a block while the sky lasts (15 levels), then one for
            // whatever of the run is left below the dark.
    // rust: let walked = if depth <= 15 { depth as usize } else { 16 };
    // rust: assert_eq!(
    // rust: level.spans.len(),
    // rust: 1 + walked,
    // rust: "depth {depth}: a span a level, then the rest in one"
    // rust: );
            // Neither invents or loses ground: the spans still cover the
            // column exactly, bottom to top, without a gap or an overlap.
    // rust: for shaded in [&level, &run] {
    // rust: assert_eq!(shaded.spans.first().unwrap().min, 0);
    // rust: assert_eq!(shaded.spans.last().unwrap().max, 4 + depth);
    // rust: for pair in shaded.spans.windows(2) {
    // rust: assert_eq!(pair[0].max, pair[1].min, "depth {depth}");
}
}
}
}
    /// A solid run takes no light from what passes down it, under either
    /// dampening: only fluids and leaves dim the column.
pub fn solid_runs_are_one_span_and_dim_nothing() void {
}
//         use super::*;
    // rust: let stone = Span {
    // rust: min: 0,
    // rust: max: 60,
    // rust: state: BlockStateId(2),
    // rust: biome: 0,
    // rust: light: 240,
}
    // rust: for dampening in [Dampening::PerLevel, Dampening::PerRun] {
    // rust: let mut column = Column {
    // rust: surface: None,
    // rust: spans: vec![stone].into(),
}
    // rust: shade_runs(&mut column, |_| false, dampening);
    // rust: assert_eq!(column.spans, [stone], "{dampening:?}");
}
}
    /// The all-cached path must return exactly the per-cell reductions the
    /// old override produced, including negative chunk coordinates.
pub fn cached_grid_equals_each_cells_reduction() void {
}
    // rust: let mut cache: FxHashMap<(i32, i32), Arc<[Column; 256]>> = FxHashMap::default();
    // rust: let columns: Arc<[Column; 256]> = Arc::new(std::array::from_fn(|i| {
    // rust: Column::from_surface(Some(Surface {
    // rust: height: 60 + i as i32 % 8,
    // rust: state: BlockStateId(i as u32 % 3 + 1),
    // rust: water: None,
    // rust: biome: 0,
    // rust: }))
    // rust: }));
    // rust: cache.insert((0, 0), columns.clone());
    // rust: cache.insert((-1, -1), columns.clone());
    // rust: for (x, z) in [(0, 0), (4, 4), (8, 8), (-8, -8), (-16, -16)] {
    // rust: let fast = cached_grid(&cache, x, z, 4, 2)
    // rust: .unwrap_or_else(|| panic!("inside cached chunks at {x},{z}"));
    // rust: for dz in 0..2 {
    // rust: for dx in 0..2 {
    // rust: let (wx, wz) = (x + dx * 4, z + dz * 4);
    // rust: assert_eq!(
    // rust: fast[dz as usize * 2 + dx as usize],
    // rust: Column::reduced(&columns, (wx & 15) as usize, (wz & 15) as usize, 4)
    // rust: );
}
}
}
        // One missing chunk falls back to the generator path.
    // rust: assert!(cached_grid(&cache, 12, 0, 4, 2).is_none());
    // rust: assert!(cached_grid(&cache, 0, 0, 32, 2).is_none());
}

//     use super::*;
pub fn decorated_lod_refines_real_seed_canopies_and_all_dimensions() c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("resources"),
    // rust: );
    // rust: let assets = crate::assets::Assets::load(&root)?;
    // rust: let biomes = crate::biome::Biomes::load(&root)?;
    // rust: let terrain = Arc::new(VanillaTerrain::new(
    // rust: &root.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: )?);
    // rust: let mut sampler = VanillaLodSampler::new(terrain.clone());
        // This bounded test waits for decoration. Idle workers can be starved
        // by other tests, so keep the real request/result path at normal priority.
    // rust: sampler.builder = Some(Builder::new(terrain.clone(), false));
    // rust: let mut fork = sampler.fork().expect("independent far sampler");
    // rust: let direct = sampler.grid(-1024, 0, 32, 16);
    // rust: assert_eq!(
    // rust: direct,
    // rust: fork.grid(-1024, 0, 32, 16),
    // rust: "sampling workers must agree on seed/biome vegetation"
    // rust: );
    // rust: let grass = assets
    // rust: .registry
    // rust: .default_state("minecraft:grass_block")
    // rust: .unwrap();
    // rust: let planted = |ground, biome, width, x, z| {
    // rust: let mut column = Column::from_surface(Some(Surface {
    // rust: height: 80,
    // rust: state: ground,
    // rust: water: None,
    // rust: biome,
    // rust: }));
    // rust: sampler.vegetation.apply(&mut column, x, z, width, 240);
    // rust: column
}
    // rust: let forest = biomes.id("minecraft:forest");
    // rust: let plains = biomes.id("minecraft:plains");
    // rust: let leaves = |column: &Column| {
    // rust: column.spans.iter().any(|span| {
    // rust: assets
    // rust: .registry
    // rust: .state(span.state)
    // rust: .unwrap()
    // rust: .name
    // rust: .ends_with("_leaves")
    // rust: })
}
    // rust: let mut forest_count = 0;
    // rust: let mut plains_count = 0;
    // rust: for z in 0..64 {
    // rust: for x in 0..64 {
    // rust: forest_count += usize::from(leaves(&planted(grass, forest, 1, x, z)));
    // rust: plains_count += usize::from(leaves(&planted(grass, plains, 1, x, z)));
}
}
    // rust: assert!(
    // rust: forest_count > 1000 && forest_count > plains_count * 4,
    // rust: "feature-derived vegetation density: forest={forest_count}, plains={plains_count}"
    // rust: );
    // rust: for width in [16, 32, 128, 512, 1024] {
    // rust: assert!(
    // rust: leaves(&planted(grass, forest, width, 0, 0)),
    // rust: "forest canopy missing at scale {width}"
    // rust: );
}
        // The End's chorus plants come from the biome's own feature data: only
        // end highlands carry it, and only end stone is a valid ground.
    // rust: let end_stone = assets
    // rust: .registry
    // rust: .default_state("minecraft:end_stone")
    // rust: .unwrap();
    // rust: let chorus_name = |state| {
    // rust: matches!(
    // rust: assets.registry.state(state).unwrap().name.as_str(),
    // rust: "minecraft:chorus_plant" | "minecraft:chorus_flower"
    // rust: )
}
    // rust: let chorus = |column: &Column| column.spans.iter().any(|span| chorus_name(span.state));
    // rust: let highlands = biomes.id("minecraft:end_highlands");
    // rust: assert!(
    // rust: sampler.vegetation.chorus_count(highlands).unwrap_or(0.) > 0.,
    // rust: "end highlands keep the chorus feature"
    // rust: );
    // rust: assert_eq!(
    // rust: sampler.vegetation.chorus_count(forest),
    // rust: None,
    // rust: "a biome without the feature estimates none"
    // rust: );
    // rust: let mut highlands_count = 0;
    // rust: let mut control_count = 0;
    // rust: for z in 0..64 {
    // rust: for x in 0..64 {
    // rust: highlands_count += usize::from(chorus(&planted(end_stone, highlands, 1, x, z)));
    // rust: control_count += usize::from(chorus(&planted(end_stone, forest, 1, x, z)));
}
}
    // rust: assert!(
    // rust: highlands_count > 0 && control_count == 0,
    // rust: "feature-derived chorus density: highlands={highlands_count}, forest={control_count}"
    // rust: );
    // rust: let stem = (0..64)
    // rust: .flat_map(|z| (0..64).map(move |x| (x, z)))
    // rust: .map(|(x, z)| planted(end_stone, highlands, 1, x, z))
    // rust: .find(|column| chorus(column))
    // rust: .expect("a chorus column");
    // rust: let plant = stem
    // rust: .spans
    // rust: .iter()
    // rust: .find(|span| chorus_name(span.state))
    // rust: .unwrap();
    // rust: assert!(
    // rust: (2..=5).contains(&(i32::from(plant.max - plant.min))),
    // rust: "stem height follows the feature's 2..=5"
    // rust: );
    // rust: let top = stem.spans.last().unwrap();
    // rust: assert_eq!(
    // rust: assets.registry.state(top.state).unwrap().name,
    // rust: "minecraft:chorus_flower"
    // rust: );
    // rust: assert_eq!(stem.surface.unwrap().height, i32::from(top.max));
    // rust: let mut wide = 0;
    // rust: for width in [2, 4] {
    // rust: for z in (0..64).step_by(2) {
    // rust: for x in (0..64).step_by(2) {
    // rust: wide += usize::from(chorus(&planted(end_stone, highlands, width, x, z)));
}
}
}
    // rust: assert!(wide > 0, "nearby LOD cells still draw chorus");
    // rust: for z in (0..64).step_by(16) {
    // rust: for x in (0..64).step_by(16) {
    // rust: assert!(
    // rust: !chorus(&planted(end_stone, highlands, 16, x, z)),
    // rust: "a 16-block cell is too wide to read as one plant"
    // rust: );
}
}
    // rust: let key = (-64, 0);
    // rust: sampler.request_detail(&[key], [-1024, 0]);
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(30);
    // rust: let generated = loop {
    // rust: if let Some((_, columns)) = sampler.drain_details().into_iter().find(|(k, _)| *k == key)
    // rust: {
    // rust: break columns;
}
    // rust: assert!(
    // rust: std::time::Instant::now() < deadline,
    // rust: "decoration worker stalled"
    // rust: );
    // rust: std::thread::sleep(std::time::Duration::from_millis(5));
}
    // rust: let count = |suffix: &str| {
    // rust: generated
    // rust: .iter()
    // rust: .flat_map(|column| &column.spans)
    // rust: .filter(|span| {
    // rust: assets
    // rust: .registry
    // rust: .state(span.state)
    // rust: .unwrap()
    // rust: .name
    // rust: .ends_with(suffix)
    // rust: })
    // rust: .map(|span| i32::from(span.max - span.min))
    // rust: .sum::<i32>()
}
    // rust: assert!(count("_leaves") > 0, "unexplored forest has a real canopy");
    // rust: assert!(count("_log") > 0, "canopy retains its trunks");
    // rust: let sky = |span: &Span| (span.light >> 4) & 15;
    // rust: assert!(
    // rust: generated
    // rust: .iter()
    // rust: .filter_map(|column| column.spans.last())
    // rust: .all(|top| sky(top) == 15),
    // rust: "the top of every column is in the open"
    // rust: );
    // rust: assert!(
    // rust: generated
    // rust: .iter()
    // rust: .flat_map(|column| &column.spans)
    // rust: .any(|span| (1..15).contains(&sky(span))),
    // rust: "ground under the canopy is shaded, not black"
    // rust: );
    // rust: assert!(generated.iter().all(|column| {
    // rust: column
    // rust: .spans
    // rust: .windows(2)
    // rust: .all(|pair| pair[0].max <= pair[1].min)
    // rust: }));
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: assert_eq!(
    // rust: sampler.column(key.0 * 16 + x, key.1 * 16 + z),
    // rust: generated[(z * 16 + x) as usize]
    // rust: );
}
}
    // rust: sampler.request_detail(&[key], [-1024, 0]);
    // rust: let cached = sampler.drain_details();
    // rust: assert!(
    // rust: Arc::ptr_eq(&cached[0].1, &generated),
    // rust: "reuses completed compact data"
    // rust: );
    // rust: drop(sampler);
    // rust: let mut worker = terrain.generator.worker();
    // rust: let started = std::time::Instant::now();
    // rust: for x in 0..BATCH {
    // rust: for z in 0..BATCH {
    // rust: decorated_region(&mut worker, (key.0 + x, key.1 + z), &AtomicBool::new(false))?
    // rust: .unwrap();
}
}
    // rust: let separate = started.elapsed();
    // rust: let started = std::time::Instant::now();
    // rust: let mut emitted = FxHashMap::default();
    // rust: let region = decorated_batch(&mut worker, key, BATCH, &AtomicBool::new(false), |chunk| {
    // rust: let pos = chunk.position();
    // rust: assert!(
    // rust: emitted
    // rust: .insert(
    // rust: (pos.x, pos.z),
    // rust: columns(chunk, &terrain.biome_map, "minecraft:overworld")
    // rust: )
    // rust: .is_none()
    // rust: );
    // rust: })?;
    // rust: eprintln!(
    // rust: "far generation: {} separate targets={separate:?}, shared targets={:?}",
    // rust: emitted.len(),
    // rust: started.elapsed()
    // rust: );
    // rust: assert_eq!(emitted.len(), (BATCH * BATCH) as usize);
    // rust: for (key, data) in emitted {
    // rust: assert_eq!(
    // rust: data,
    // rust: columns(&region[&key], &terrain.biome_map, "minecraft:overworld"),
    // rust: "emitted before all neighbouring features completed"
    // rust: );
}
    // rust: assert_eq!(batch_origin((-1, -BATCH - 1)), (-BATCH, -2 * BATCH));
    // rust: let stop = AtomicBool::new(true);
    // rust: assert!(decorated_region(&mut terrain.generator.worker(), key, &stop)?.is_none());
    // rust: for (dimension, center) in [
    // rust: ("minecraft:the_nether", (0, 0)),
    // rust: ("minecraft:the_end", (16, 0)),
    // rust: ] {
    // rust: let generator = OverworldGenerator::for_dimension(
    // rust: terrain.generator.data().clone(),
    // rust: 1234,
    // rust: "minecraft:normal",
    // rust: dimension,
    // rust: )?;
    // rust: let mut emitted = 0;
    // rust: let mut region = decorated_batch(
    // rust: &mut generator.worker(),
    // rust: center,
    // rust: BATCH,
    // rust: &AtomicBool::new(false),
    // rust: |_| emitted += 1,
    // rust: )?;
    // rust: assert_eq!(emitted, (BATCH * BATCH) as usize);
    // rust: let chunk = region.remove(&center).unwrap();
    // rust: let data = columns(&chunk, &terrain.biome_map, dimension);
    // rust: if dimension == "minecraft:the_nether" {
    // rust: assert!(
    // rust: data.iter()
    // rust: .flat_map(|c| &c.spans)
    // rust: .all(|s| s.light & 0xf0 == 0)
    // rust: );
    // rust: assert!(data.iter().flat_map(|c| &c.spans).any(|s| {
    // rust: assets.registry.state(s.state).unwrap().name == "minecraft:lava"
    // rust: && s.light >> 12 == 15
    // rust: }));
    // rust: } else {
    // rust: assert!(
    // rust: data.iter().all(|c| c.spans.is_empty()),
    // rust: "End void stays empty"
    // rust: );
}
}
        // Reuse the saved-proto bastion fixture. Repeated speculative regions
        // must reconstruct structures after their one-shot placement flags ran.
    // rust: let generator = OverworldGenerator::for_dimension(
    // rust: terrain.generator.data().clone(),
    // rust: -1860902098141295193,
    // rust: "minecraft:normal",
    // rust: "minecraft:the_nether",
    // rust: )?;
    // rust: let mut worker = generator.worker();
    // rust: let mut previous = None;
    // rust: for _ in 0..2 {
    // rust: let chunk = decorated_region(&mut worker, (3, 7), &AtomicBool::new(false))?.unwrap();
    // rust: assert!(
    // rust: chunk
    // rust: .structures()
    // rust: .iter()
    // rust: .any(|(name, _, _, _)| name.contains("bastion"))
    // rust: );
    // rust: let data = columns(&chunk, &terrain.biome_map, "minecraft:the_nether");
    // rust: let snapshot = (data, chunk.block_entities);
    // rust: if let Some(previous) = &previous {
    // rust: assert_eq!(
    // rust: &snapshot, previous,
    // rust: "speculative structure state leaked between regions"
    // rust: );
}
    // rust: previous = Some(snapshot);
}
    // rust: Ok(())
}
    /// Small End islands are decoration over the void, so the direct sampler
    /// has to estimate them from `end_island_decorated`.
pub fn end_small_islands_are_estimated_over_the_void() c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("resources"),
    // rust: );
    // rust: let assets = crate::assets::Assets::load(&root)?;
    // rust: let biomes = crate::biome::Biomes::load(&root)?;
    // rust: let terrain = Arc::new(VanillaTerrain::for_dimension(
    // rust: &root.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: "minecraft:the_end",
    // rust: )?);
    // rust: let mut sampler = VanillaLodSampler::new(terrain.clone());
    // rust: let mut search = terrain.generator.worker();
    // rust: let mut center = None;
    // rust: 'search: for x in (1024..=8192).step_by(512) {
    // rust: for z in (-8192..=8192).step_by(512) {
    // rust: let biome = search.noise_biomes(&[[x >> 2, 16, z >> 2]]);
    // rust: if biome.first().and_then(|name| name.as_deref())
    // rust: != Some("minecraft:small_end_islands")
    // rust: {
    // rust: continue;
}
    // rust: if search.surface_sample(x, z).is_some() {
    // rust: continue;
}
    // rust: center = Some((x, z));
    // rust: break 'search;
}
}
    // rust: let (cx, cz) = center.expect("a small end islands region");
    // rust: let end_stone = assets
    // rust: .registry
    // rust: .default_state("minecraft:end_stone")
    // rust: .unwrap();
        // The estimator itself, a wide void at one block per cell.
    // rust: let mut islands = 0;
    // rust: for z in cz - 128..cz + 128 {
    // rust: for x in cx - 128..cx + 128 {
    // rust: let mut column = Column::default();
    // rust: sampler.islands.apply(&mut column, x, z, 1, 240);
    // rust: let Some(surface) = column.surface else {
    // rust: continue;
}
    // rust: assert!(
    // rust: (56..=71).contains(&surface.height),
    // rust: "island top at {}",
    // rust: surface.height
    // rust: );
    // rust: assert_eq!(surface.state, end_stone);
    // rust: assert!(column.spans.iter().any(|span| {
    // rust: span.state == end_stone && i32::from(span.max) == surface.height
    // rust: }));
    // rust: assert!(
    // rust: column.spans.iter().all(|span| i32::from(span.min) >= 45),
    // rust: "an estimated island floats above the void"
    // rust: );
    // rust: islands += 1;
}
}
    // rust: assert!(islands > 0, "no estimated small islands in a 256² void");
        // And through the whole direct-sampling path with the real biome map.
    // rust: let sampled = sampler.grid(cx - 32, cz - 32, 1, 64);
    // rust: assert!(
    // rust: sampled.iter().any(|column| column
    // rust: .surface
    // rust: .is_some_and(|surface| surface.state == end_stone)),
    // rust: "direct sampling shows an island in the real small end islands biome"
    // rust: );
    // rust: Ok(())
}
    /// The refined path must keep the real feature's end stone in its columns.
pub fn end_small_islands_from_decoration_survive_far_columns() c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("resources"),
    // rust: );
    // rust: let assets = crate::assets::Assets::load(&root)?;
    // rust: let biomes = crate::biome::Biomes::load(&root)?;
    // rust: let terrain = Arc::new(VanillaTerrain::for_dimension(
    // rust: &root.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: "minecraft:the_end",
    // rust: )?);
    // rust: let sampler = VanillaLodSampler::new(terrain.clone());
    // rust: let mut worker = terrain.generator.worker();
    // rust: let stop = AtomicBool::new(false);
    // rust: let mut centers = Vec::new();
    // rust: 'search: for cx in (64..=512).step_by(4) {
    // rust: for cz in (-512..=512).step_by(4) {
    // rust: let (x, z) = (cx * 16 + 8, cz * 16 + 8);
    // rust: let biome = worker.noise_biomes(&[[x >> 2, 16, z >> 2]]);
    // rust: if biome.first().and_then(|name| name.as_deref())
    // rust: != Some("minecraft:small_end_islands")
    // rust: {
    // rust: continue;
}
    // rust: if worker.surface_sample(x, z).is_some() {
    // rust: continue;
}
    // rust: centers.push((cx, cz));
    // rust: if centers.len() >= 200 {
    // rust: break 'search;
}
}
}
    // rust: for &(cx, cz) in &centers {
            // The replay is cheap; only decorate chunks it actually places in.
    // rust: let origins = sampler.islands.origins(cx, cz);
    // rust: if origins.is_empty() {
    // rust: continue;
}
    // rust: let Some(chunk) = decorated_region(&mut worker, (cx, cz), &stop)? else {
    // rust: continue;
}
    // rust: for [x, y, z] in &origins {
    // rust: assert!((55..=70).contains(y), "island origin at y {y} in {cx} {cz}");
    // rust: assert_eq!(
    // rust: chunk.block_name(*x, *y, *z),
    // rust: "minecraft:end_stone",
    // rust: "exact origin {x} {y} {z} is the real island's top centre"
    // rust: );
}
    // rust: let min = chunk.terrain.min_y();
    // rust: let max = min + chunk.terrain.height();
    // rust: let mut raw = 0;
    // rust: for y in min..max {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: raw += usize::from(chunk.block_name(x, y, z) == "minecraft:end_stone");
}
}
}
    // rust: let kept: usize = columns(&chunk, &terrain.biome_map, "minecraft:the_end")
    // rust: .iter()
    // rust: .flat_map(|column| &column.spans)
    // rust: .filter(|span| {
    // rust: assets.registry.state(span.state).unwrap().name == "minecraft:end_stone"
    // rust: })
    // rust: .map(|span| (span.max - span.min) as usize)
    // rust: .sum();
    // rust: assert_eq!(
    // rust: raw, kept,
    // rust: "far columns keep the real small island in {cx} {cz}"
    // rust: );
    // rust: return Ok(());
}
    // rust: panic!(
    // rust: "no exact small end island among {} candidates",
    // rust: centers.len()
    // rust: );
}
    /// Vanilla decoration places chorus plants in the End; the far columns must
    /// keep them even though they are not motion-blocking blocks.
pub fn end_far_columns_keep_real_chorus_plants() c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::path::PathBuf::from(
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES").expect("resources"),
    // rust: );
    // rust: let assets = crate::assets::Assets::load(&root)?;
    // rust: let biomes = crate::biome::Biomes::load(&root)?;
    // rust: let terrain = Arc::new(VanillaTerrain::for_dimension(
    // rust: &root.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: 1234,
    // rust: "minecraft:the_end",
    // rust: )?);
    // rust: let mut worker = terrain.generator.worker();
    // rust: let chorus = |state| {
    // rust: matches!(
    // rust: assets.registry.state(state).unwrap().name.as_str(),
    // rust: "minecraft:chorus_plant" | "minecraft:chorus_flower"
    // rust: )
}
    // rust: let mut checked = 0;
    // rust: 'search: for cx in (-160..=160).step_by(16) {
    // rust: for cz in (-160..=160).step_by(16) {
    // rust: let (x, z) = (cx * 16 + 8, cz * 16 + 8);
    // rust: let biome = worker.noise_biomes(&[[x >> 2, 16, z >> 2]]);
    // rust: if biome.first().and_then(|name| name.as_deref()) != Some("minecraft:end_highlands")
    // rust: {
    // rust: continue;
}
    // rust: if worker.surface_sample(x, z).is_none() {
    // rust: continue;
}
    // rust: checked += 1;
    // rust: if checked > 24 {
    // rust: break 'search;
}
    // rust: let Some(chunk) = decorated_region(&mut worker, (cx, cz), &AtomicBool::new(false))?
    // rust: else {
    // rust: continue;
}
    // rust: let min = chunk.terrain.min_y();
    // rust: let max = min + chunk.terrain.height();
    // rust: let mut raw = 0;
    // rust: for y in min..max {
    // rust: for zz in 0..16 {
    // rust: for xx in 0..16 {
    // rust: raw += usize::from(chorus(chunk.block(xx, y, zz)));
}
}
}
    // rust: if raw == 0 {
    // rust: continue;
}
    // rust: let kept: usize = columns(&chunk, &terrain.biome_map, "minecraft:the_end")
    // rust: .iter()
    // rust: .flat_map(|column| &column.spans)
    // rust: .filter(|span| chorus(span.state))
    // rust: .map(|span| (span.max - span.min) as usize)
    // rust: .sum();
    // rust: assert_eq!(
    // rust: raw, kept,
    // rust: "far columns keep every real chorus block in {cx} {cz}"
    // rust: );
    // rust: return Ok(());
}
}
    // rust: panic!("no generated end_highlands chunk with chorus among {checked} candidates");
}
}
