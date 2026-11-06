//! Transpiled from Horizon Rust crate
//! Module: horizon-client_particle_culling
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Particle visibility checks and their worker, separate from entity culling.
// use super::Game;
// use horizon_client::{
    // rust: blocks::{BlockFacts, RenderShape, StateFacts},
    // rust: chunk::Chunk,
    // rust: entity_culling::Culler,
    // rust: graphics::ParticleCullingMode,
    // rust: world::World,
}
// use std::{
    // rust: array,
    // rust: cell::RefCell,
    // rust: sync::{
    // rust: Arc, Weak,
    // rust: mpsc::{self, Receiver, SyncSender, TrySendError},
    // rust: },
    // rust: thread::JoinHandle,
}

    // rust: type ChunkKey = (i32, i32);
    // rust: type SectionKey = (i32, i32, i32);
pub const MAX_SNAPSHOT_CHUNKS: i64 = 4_096;

pub const CullKey = struct {
    camera: [u64,
    min: [u64,
    max: [u64,
};

pub const SnapshotKey = struct {
    world_revision: u64,
    chunks_revision: u64,
    bottom_y: i32,
};

pub const ChunkBounds = struct {
    min_x: i32,
    max_x: i32,
    min_z: i32,
    max_z: i32,
};

pub const OcclusionSnapshot = struct {
    chunks: Vec<(ChunkKey,
    opaque_states: *[bool],
};

    // rust: impl OcclusionSnapshot {
pub fn chunk(self: *Self, key: ChunkKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks
    // rust: .binary_search_by_key(&key, |(key, _)| *key)
    // rust: .ok()
    // rust: .map(|index| &self.chunks[index].1)
}

pub fn refresh_chunks(self: *Self, world: *World, bounds: ChunkBounds) void {
}
    // rust: self.chunks.clear();
    // rust: for x in bounds.min_x..=bounds.max_x {
    // rust: for z in bounds.min_z..=bounds.max_z {
    // rust: if let Some(chunk) = world.chunks.get(&(x, z)) {
    // rust: self.chunks.push(((x, z), Arc::downgrade(chunk)));
}
}
}
}

pub fn chunks_match(self: *Self, world: *World) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks.iter().all(|(key, expected)| {
    // rust: world
    // rust: .chunks
    // rust: .get(key)
    // rust: .is_some_and(|current| std::ptr::eq(expected.as_ptr(), Arc::as_ptr(current)))
    // rust: })
}

pub fn opaque(self: *Self, pos: [i32; 3], last_chunk: *mut LastChunk) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (pos[0] >> 4, pos[2] >> 4);
    // rust: let Some(chunk) = last_chunk.get(self, key) else {
    // rust: return false;
}
    // rust: let state = chunk.block(pos[0] & 15, pos[1], pos[2] & 15);
    // rust: self.opaque_states
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
}

pub const LastChunk = struct {
    key: ?ChunkKey,
    value: ?*Chunk,
};

    // rust: impl LastChunk {
pub fn get(self: *Self, snapshot: *OcclusionSnapshot, key: ChunkKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.key != Some(key) {
    // rust: self.key = Some(key);
    // rust: self.value = snapshot.chunk(key).and_then(Weak::upgrade);
}
    // rust: self.value.as_ref()
}
}

pub const OcclusionProof = struct {
    sections: std.ArrayList(SectionKey),
    chunks: Vec<(ChunkKey,
};

pub const CullResults = struct {
    stamp: SnapshotKey,
    answers: Vec<(CullKey,
    scratch_queries: std.ArrayList(CullKey),
};

pub const CullJob = struct {
    stamp: SnapshotKey,
    snapshot: *OcclusionSnapshot,
    queries: std.ArrayList(CullKey),
};

    // rust: pub(super) struct ParticleAsyncState {
    // rust: culler: Option<ParticleAsyncCuller>,
    // rust: failed: bool,
}

/// Particle occlusion has a dedicated worker so its queue cannot delay entity visibility jobs.
pub const ParticleAsyncCuller = struct {
    jobs: SyncSender<CullJob>,
    results_rx: Receiver<CullResults>,
    _thread: JoinHandle<()>,
    snapshot: Option<(SnapshotKey,
    opaque_states: ?*[bool],
    results: ?CullResults,
    queries: RefCell<std.ArrayList(CullKey)>,
    camera: [f64,
    stamp: SnapshotKey,
    pending: bool,
};

    // rust: impl ParticleAsyncCuller {
pub fn new() s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (job_tx, job_rx) = mpsc::sync_channel::<CullJob>(1);
    // rust: let (result_tx, result_rx) = mpsc::channel::<CullResults>();
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("particle-culling".into())
    // rust: .spawn(move || {
    // rust: while let Ok(job) = job_rx.recv() {
    // rust: if result_tx.send(cull_job(job)).is_err() {
    // rust: break;
}
}
    // rust: })?;
    // rust: Ok(Self {
    // rust: jobs: job_tx,
    // rust: results_rx: result_rx,
    // rust: _thread: thread,
    // rust: snapshot: None,
    // rust: opaque_states: None,
    // rust: results: None,
    // rust: queries: RefCell::new(Vec::new()),
    // rust: camera: [0.0; 3],
    // rust: stamp: SnapshotKey {
    // rust: world_revision: 0,
    // rust: chunks_revision: 0,
    // rust: bottom_y: 0,
    // rust: },
    // rust: pending: false,
    // rust: })
}

pub fn begin_frame(self: *Self, camera: glam::DVec3, world: *World) void {
}
    // rust: while let Ok(mut results) = self.results_rx.try_recv() {
    // rust: self.pending = false;
    // rust: let scratch = std::mem::take(&mut results.scratch_queries);
    // rust: if scratch.capacity() > self.queries.get_mut().capacity() {
    // rust: *self.queries.get_mut() = scratch;
}
    // rust: self.results = Some(results);
}
    // rust: self.camera = camera.to_array();
    // rust: self.stamp = SnapshotKey {
    // rust: world_revision: world.revision,
    // rust: chunks_revision: world.chunks.membership_revision(),
    // rust: bottom_y: world.bottom_y(),
}
    // rust: if self
    // rust: .results
    // rust: .as_ref()
    // rust: .is_some_and(|results| results.stamp != self.stamp)
    // rust: {
    // rust: self.results = None;
}
    // rust: self.queries.get_mut().clear();
}

pub fn query(self: *Self, min: [f64; 3], max: [f64; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.camera.iter().all(|value| value.is_finite())
    // rust: || (0..3).any(|axis| {
    // rust: !min[axis].is_finite() || !max[axis].is_finite() || min[axis] > max[axis]
    // rust: })
    // rust: {
    // rust: return None;
}
    // rust: Some(CullKey {
    // rust: camera: self.camera.map(f64::to_bits),
    // rust: min: min.map(f64::to_bits),
    // rust: max: max.map(f64::to_bits),
    // rust: })
}

pub fn cached(self: *Self, key: *CullKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let results = self
    // rust: .results
    // rust: .as_ref()
    // rust: .filter(|results| results.stamp == self.stamp)?;
    // rust: let index = results
    // rust: .answers
    // rust: .binary_search_by_key(key, |(key, _)| *key)
    // rust: .ok()?;
    // rust: Some(results.answers[index].1.as_ref())
}

pub fn queue(self: *Self, key: CullKey) void {
}
    // rust: self.queries.borrow_mut().push(key);
}

pub fn finish_frame(self: *Self, world: *World, facts: *BlockFacts) void {
}
    // rust: let queries = self.queries.get_mut();
    // rust: if self.pending {
    // rust: queries.clear();
    // rust: return;
}
    // rust: if queries.is_empty() {
    // rust: return;
}
    // rust: queries.sort_unstable();
    // rust: queries.dedup();
    // rust: let Some(bounds) = snapshot_bounds(self.camera, queries) else {
    // rust: queries.clear();
    // rust: return;
}
    // rust: let opaque_states = Arc::clone(self.opaque_states.get_or_insert_with(|| {
    // rust: facts
    // rust: .states
    // rust: .iter()
    // rust: .map(state_is_opaque)
    // rust: .collect::<Vec<_>>()
    // rust: .into()
    // rust: }));
    // rust: let snapshot = match &mut self.snapshot {
    // rust: Some((stamp, cached_bounds, snapshot)) => {
    // rust: if stamp != &self.stamp || *cached_bounds != bounds || !snapshot.chunks_match(world)
    // rust: {
    // rust: let snapshot = Arc::make_mut(snapshot);
    // rust: snapshot.opaque_states = Arc::clone(&opaque_states);
    // rust: snapshot.refresh_chunks(world, bounds);
    // rust: *stamp = self.stamp;
    // rust: *cached_bounds = bounds;
}
    // rust: Arc::clone(snapshot)
}
    // rust: None => {
    // rust: let mut snapshot = OcclusionSnapshot {
    // rust: chunks: Vec::new(),
    // rust: opaque_states,
}
    // rust: snapshot.refresh_chunks(world, bounds);
    // rust: let snapshot = Arc::new(snapshot);
    // rust: self.snapshot = Some((self.stamp, bounds, Arc::clone(&snapshot)));
    // rust: snapshot
}
}
    // rust: let queries = std::mem::take(queries);
    // rust: let job = CullJob {
    // rust: stamp: self.stamp,
    // rust: snapshot,
    // rust: queries,
}
    // rust: match self.jobs.try_send(job) {
    // rust: Ok(()) => self.pending = true,
    // rust: Err(TrySendError::Full(job) | TrySendError::Disconnected(job)) => {
    // rust: *self.queries.get_mut() = job.queries;
}
}
}
}

pub fn snapshot_bounds(camera: [f64; 3], queries: *[CullKey]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut min = [i32::MAX; 3];
    // rust: let mut max = [i32::MIN; 3];
    // rust: let mut include = |point: [f64; 3]| {
    // rust: for axis in 0..3 {
    // rust: let value = point[axis].floor();
    // rust: if !value.is_finite() || value < f64::from(i32::MIN) || value > f64::from(i32::MAX) {
    // rust: return false;
}
    // rust: let value = value as i32;
    // rust: min[axis] = min[axis].min(value);
    // rust: max[axis] = max[axis].max(value);
}
    // rust: true
}
    // rust: if !include(camera) {
    // rust: return None;
}
    // rust: for query in queries {
    // rust: if !include(query.min.map(f64::from_bits)) || !include(query.max.map(f64::from_bits)) {
    // rust: return None;
}
}
    // rust: let bounds = ChunkBounds {
    // rust: min_x: min[0] >> 4,
    // rust: max_x: max[0] >> 4,
    // rust: min_z: min[2] >> 4,
    // rust: max_z: max[2] >> 4,
}
    // rust: let width = i64::from(bounds.max_x) - i64::from(bounds.min_x) + 1;
    // rust: let depth = i64::from(bounds.max_z) - i64::from(bounds.min_z) + 1;
    // rust: (width > 0 && depth > 0 && width * depth <= MAX_SNAPSHOT_CHUNKS).then_some(bounds)
}

pub fn cull_job(mut job: CullJob) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let camera = job.queries[0].camera.map(f64::from_bits);
    // rust: let culler = Culler::new(camera, 8_192);
    // rust: let mut last_chunk = LastChunk::default();
    // rust: let mut answers = Vec::with_capacity(job.queries.len());
    // rust: let mut covered = Vec::new();
    // rust: for &key in &job.queries {
    // rust: covered.clear();
    // rust: let min = key.min.map(f64::from_bits);
    // rust: let max = key.max.map(f64::from_bits);
    // rust: let proof = if culler.occluded(min, max, |pos| {
    // rust: let opaque = job.snapshot.opaque(pos, &mut last_chunk);
    // rust: if opaque {
    // rust: covered.push(pos);
}
    // rust: opaque
    // rust: }) {
    // rust: let mut sections = Vec::with_capacity(covered.len());
    // rust: let mut chunks: Vec<(ChunkKey, Weak<Chunk>)> = Vec::new();
    // rust: let mut valid = true;
    // rust: for &pos in &covered {
    // rust: let chunk_key = (pos[0] >> 4, pos[2] >> 4);
    // rust: let Some(y) = pos[1].checked_sub(job.stamp.bottom_y) else {
    // rust: valid = false;
    // rust: break;
}
    // rust: sections.push((chunk_key.0, y.div_euclid(16), chunk_key.1));
    // rust: if let Err(index) = chunks.binary_search_by_key(&chunk_key, |(key, _)| *key) {
    // rust: let Some(chunk) = job.snapshot.chunk(chunk_key) else {
    // rust: valid = false;
    // rust: break;
}
    // rust: if chunk.strong_count() == 0 {
    // rust: valid = false;
    // rust: break;
}
    // rust: chunks.insert(index, (chunk_key, chunk.clone()));
}
}
    // rust: if valid {
    // rust: sections.sort_unstable();
    // rust: sections.dedup();
    // rust: Some(Arc::new(OcclusionProof { sections, chunks }))
    // rust: } else {
    // rust: None
}
    // rust: } else {
    // rust: None
}
    // rust: answers.push((key, proof));
}
    // rust: job.queries.clear();
    // rust: CullResults {
    // rust: stamp: job.stamp,
    // rust: answers,
    // rust: scratch_queries: job.queries,
}
}

pub fn state_is_opaque(facts: *StateFacts) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: facts.render_shape == RenderShape::Model
    // rust: && facts.can_occlude
    // rust: && facts.solid_render
    // rust: && facts.full_collision
}

pub const CLUSTER_CACHE_SIZE: usize = 1_024;
pub const CLUSTER_SIZE: f64 = 8.0;
pub const MAX_CLUSTER_OCCLUSION_RADIUS: f64 = 1.0;

pub const ClusterCacheEntry = struct {
    cluster: [i32,
    hidden: bool,
};

pub const ClusterVisibilityCache = struct {
    entries: [?ClusterCacheEntry,
};

    // rust: impl Default for ClusterVisibilityCache {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: entries: [None; CLUSTER_CACHE_SIZE],
}
}
}

    // rust: impl ClusterVisibilityCache {
pub fn get(self: *Self, cluster: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries[cluster_cache_slot(cluster)]
    // rust: .filter(|entry| entry.cluster == cluster)
    // rust: .map(|entry| entry.hidden)
}

pub fn get_or_compute(self: *Self, cluster: [i32; 3], compute: impl FnOnce() b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(hidden) = self.get(cluster) {
    // rust: return hidden;
}
    // rust: let hidden = compute();
    // rust: self.insert(cluster, hidden);
    // rust: hidden
}

pub fn insert(self: *Self, cluster: [i32; 3], hidden: bool) void {
}
    // rust: self.entries[cluster_cache_slot(cluster)] = Some(ClusterCacheEntry { cluster, hidden });
}
}

pub fn cluster_cache_slot(cluster: [i32; 3]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hash = (cluster[0] as u32).wrapping_mul(73_856_093)
    // rust: ^ (cluster[1] as u32).wrapping_mul(19_349_663)
    // rust: ^ (cluster[2] as u32).wrapping_mul(83_492_791);
    // rust: hash as usize & (CLUSTER_CACHE_SIZE - 1)
}

/// Use one conservatively expanded 8-block cluster bound for small particles.
pub fn cluster_query(min: [f64; 3], max: [f64; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if (0..3).any(|axis| !min[axis].is_finite() || !max[axis].is_finite() || min[axis] > max[axis])
    // rust: {
    // rust: return None;
}
    // rust: let center = array::from_fn(|axis| min[axis] + (max[axis] - min[axis]) * 0.5);
    // rust: let radius = (0..3)
    // rust: .map(|axis| (max[axis] - min[axis]) * 0.5)
    // rust: .fold(0.0_f64, f64::max);
    // rust: if !radius.is_finite() || radius > MAX_CLUSTER_OCCLUSION_RADIUS {
    // rust: return None;
}
    // rust: let cluster = center.map(|value| {
    // rust: let coordinate = (value / CLUSTER_SIZE).floor();
    // rust: (coordinate.is_finite()
    // rust: && coordinate >= f64::from(i32::MIN)
    // rust: && coordinate <= f64::from(i32::MAX))
    // rust: .then_some(coordinate as i32)
    // rust: });
    // rust: let [Some(x), Some(y), Some(z)] = cluster else {
    // rust: return None;
}
    // rust: let cluster = [x, y, z];
    // rust: let min = cluster
    // rust: .map(|coordinate| f64::from(coordinate) * CLUSTER_SIZE - MAX_CLUSTER_OCCLUSION_RADIUS);
    // rust: let max = cluster.map(|coordinate| {
    // rust: (f64::from(coordinate) + 1.0) * CLUSTER_SIZE + MAX_CLUSTER_OCCLUSION_RADIUS
    // rust: });
    // rust: Some((cluster, min, max))
}

    // rust: pub(super) struct ParticleOcclusionContext<'borrow, 'game> {
    // rust: game: &'borrow Game<'game>,
    // rust: mode: ParticleCullingMode,
    // rust: sync_culler: Option<Culler>,
    // rust: clusters: ClusterVisibilityCache,
}

    // rust: impl ParticleOcclusionContext<'_, '_> {
    // rust: pub(super) fn hidden(&mut self, min: [f64; 3], max: [f64; 3]) -> bool {
    // rust: if self.mode == ParticleCullingMode::Off {
    // rust: return false;
}
    // rust: let Some((cluster, min, max)) = cluster_query(min, max) else {
            // Large particles can extend beyond the cluster's conservative
            // bounds. Keep them visible rather than scheduling their own ray job.
    // rust: return false;
}
    // rust: let mode = self.mode;
    // rust: let game = self.game;
    // rust: let sync_culler = self.sync_culler.as_ref();
    // rust: self.clusters.get_or_compute(cluster, || match mode {
    // rust: ParticleCullingMode::Off => false,
    // rust: ParticleCullingMode::Synchronous => {
    // rust: sync_culler.is_some_and(|culler| game.particle_occluded_sync(culler, min, max))
}
    // rust: ParticleCullingMode::Asynchronous => {
    // rust: game.async_particle_hidden(min, max).unwrap_or_else(|| {
    // rust: sync_culler.is_some_and(|culler| game.particle_occluded_sync(culler, min, max))
    // rust: })
}
    // rust: })
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn particle_occlusion_context(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: ) -> ParticleOcclusionContext<'_, '_> {
    // rust: let at = camera.to_array().map(|value| value.floor() as i32);
    // rust: let camera_inside_opaque =
    // rust: state_is_opaque(self.res.facts().get(self.world.block(at[0], at[1], at[2])));
    // rust: let mode =
    // rust: if self.model_packs_are_vanilla() && self.player.is_some() && !camera_inside_opaque {
    // rust: self.settings.horizon.particle_culling
    // rust: } else {
    // rust: ParticleCullingMode::Off
}
    // rust: if mode == ParticleCullingMode::Asynchronous {
    // rust: let mut state = self.async_particle_culler.borrow_mut();
    // rust: if state.culler.is_none() && !state.failed {
    // rust: match ParticleAsyncCuller::new() {
    // rust: Ok(culler) => state.culler = Some(culler),
    // rust: Err(error) => {
    // rust: log::warn!("Horizon: cannot start particle-culling worker: {error}");
    // rust: state.failed = true;
}
}
}
    // rust: if let Some(culler) = &mut state.culler {
    // rust: culler.begin_frame(camera, &self.world);
}
    // rust: } else {
    // rust: let mut state = self.async_particle_culler.borrow_mut();
    // rust: state.culler = None;
    // rust: state.failed = false;
}
    // rust: ParticleOcclusionContext {
    // rust: game: self,
    // rust: mode,
    // rust: sync_culler: (mode != ParticleCullingMode::Off)
    // rust: .then(|| Culler::new(camera.to_array(), 8_192)),
    // rust: clusters: ClusterVisibilityCache::default(),
}
}

    // rust: pub(super) fn particle_occluded_sync(
    // rust: &self,
    // rust: culler: &Culler,
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: ) -> bool {
    // rust: culler.occluded(min, max, |pos| self.particle_occluder_ready(pos))
}

pub fn particle_occluder_ready(self: *Self, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if !state_is_opaque(self.res.facts().get(state)) {
    // rust: return false;
}
    // rust: let Some(y) = pos[1].checked_sub(self.world.bottom_y()) else {
    // rust: return false;
}
    // rust: let section = (pos[0] >> 4, y.div_euclid(16), pos[2] >> 4);
    // rust: self.renderer
    // rust: .as_ref()
    // rust: .is_some_and(|renderer| renderer.has_section(section))
    // rust: && !self.world.dirty_sections.contains(&section)
    // rust: && !self.streaming.is_meshing(section)
    // rust: && !self.pending_uploads.iter().any(|(key, _)| *key == section)
}

    // rust: pub(super) fn async_particle_hidden(&self, min: [f64; 3], max: [f64; 3]) -> Option<bool> {
pub const Answer = enum {
    Miss,
    Visible,
    Hidden(Arc<OcclusionProof>),
};

    // rust: let query = {
    // rust: let state = self.async_particle_culler.borrow();
    // rust: let culler = state.culler.as_ref()?;
    // rust: culler.query(min, max)?
}
    // rust: let answer = {
    // rust: let state = self.async_particle_culler.borrow();
    // rust: let culler = state.culler.as_ref()?;
    // rust: match culler.cached(&query) {
    // rust: None => Answer::Miss,
    // rust: Some(None) => Answer::Visible,
    // rust: Some(Some(proof)) => Answer::Hidden(Arc::clone(proof)),
}
}
    // rust: match answer {
    // rust: Answer::Visible => Some(false),
    // rust: Answer::Hidden(proof) if self.particle_proof_is_current(&proof) => Some(true),
    // rust: Answer::Miss | Answer::Hidden(_) => {
    // rust: if let Some(culler) = self.async_particle_culler.borrow().culler.as_ref() {
    // rust: culler.queue(query);
}
    // rust: Some(false)
}
}
}

pub fn particle_proof_is_current(self: *Self, proof: *OcclusionProof) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: proof.chunks.iter().all(|(key, expected)| {
    // rust: self.world
    // rust: .chunks
    // rust: .get(key)
    // rust: .is_some_and(|current| std::ptr::eq(Arc::as_ptr(current), expected.as_ptr()))
    // rust: }) && proof.sections.iter().all(|&section| {
    // rust: self.renderer
    // rust: .as_ref()
    // rust: .is_some_and(|renderer| renderer.has_section(section))
    // rust: && !self.world.dirty_sections.contains(&section)
    // rust: && !self.streaming.is_meshing(section)
    // rust: && !self.pending_uploads.iter().any(|(key, _)| *key == section)
    // rust: })
}

    // rust: pub(super) fn finish_async_particle_culling(&self) {
    // rust: if let Some(culler) = &mut self.async_particle_culler.borrow_mut().culler {
    // rust: culler.finish_frame(&self.world, self.res.facts());
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::chunk::ColumnLayout;

pub fn wall(hole: ?[i32; 3]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut live = Vec::new();
    // rust: let mut chunks = Vec::new();
    // rust: for chunk_z in [-1, 0] {
    // rust: let mut chunk = Chunk::with_layout(0, chunk_z, ColumnLayout::VANILLA);
    // rust: for y in -1..=0 {
    // rust: for z in -1..=0 {
    // rust: let pos = [4, y, z];
    // rust: if hole != Some(pos) {
    // rust: chunk.set(pos[0] & 15, pos[1], pos[2] & 15, 1);
}
}
}
    // rust: let chunk = Arc::new(chunk);
    // rust: chunks.push(((0, chunk_z), Arc::downgrade(&chunk)));
    // rust: live.push(chunk);
}
    // rust: chunks.sort_unstable_by_key(|(key, _)| *key);
    // rust: (
    // rust: Arc::new(OcclusionSnapshot {
    // rust: chunks,
    // rust: opaque_states: Arc::from([false, true]),
    // rust: }),
    // rust: live,
    // rust: )
}

pub fn wall_job(snapshot: *OcclusionSnapshot) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CullJob {
    // rust: stamp: SnapshotKey {
    // rust: world_revision: 1,
    // rust: chunks_revision: 1,
    // rust: bottom_y: ColumnLayout::VANILLA.min_y(),
    // rust: },
    // rust: snapshot,
    // rust: queries: vec![CullKey {
    // rust: camera: [0.0; 3].map(f64::to_bits),
    // rust: min: [7.95, -0.55, -0.55].map(f64::to_bits),
    // rust: max: [10.05, 0.55, 0.55].map(f64::to_bits),
    // rust: }],
}
}

pub fn a_cluster_query_covers_small_particles_across_negative_boundaries() void {
}
    // rust: let min = [-0.2, 15.6, -16.2];
    // rust: let max = [0.2, 16.0, -15.8];
    // rust: let (cluster, query_min, query_max) = cluster_query(min, max).unwrap();

    // rust: assert_eq!(cluster, [0, 1, -2]);
    // rust: for axis in 0..3 {
    // rust: assert!(query_min[axis] <= min[axis]);
    // rust: assert!(query_max[axis] >= max[axis]);
}
    // rust: assert_eq!(query_min, [-1.0, 7.0, -17.0]);
    // rust: assert_eq!(query_max, [9.0, 17.0, -7.0]);
}

pub fn adjacent_clusters_keep_distinct_visibility_bounds() void {
}
    // rust: let left = cluster_query([7.0, 0.0, 0.0], [7.2, 0.2, 0.2]).unwrap();
    // rust: let right = cluster_query([8.1, 0.0, 0.0], [8.3, 0.2, 0.2]).unwrap();

    // rust: assert_eq!(left.0, [0, 0, 0]);
    // rust: assert_eq!(right.0, [1, 0, 0]);
    // rust: assert_ne!((left.1, left.2), (right.1, right.2));
}

pub fn the_maximum_supported_particle_radius_is_still_fully_covered() void {
}
    // rust: let min = [15.0, 15.0, -1.0];
    // rust: let max = [17.0, 17.0, 1.0];
    // rust: let (cluster, query_min, query_max) = cluster_query(min, max).unwrap();

    // rust: assert_eq!(cluster, [2, 2, 0]);
    // rust: assert_eq!(query_min, [15.0, 15.0, -1.0]);
    // rust: assert_eq!(query_max, [25.0, 25.0, 9.0]);
}

pub fn invalid_or_large_particle_bounds_fail_open() void {
}
    // rust: assert!(cluster_query([0.0, f64::NAN, 0.0], [1.0; 3]).is_none());
    // rust: assert!(cluster_query([1.0; 3], [0.0; 3]).is_none());
    // rust: assert!(cluster_query([-1.1, 0.0, 0.0], [1.1, 0.0, 0.0]).is_none());
    // rust: assert!(cluster_query([f64::MAX; 3], [f64::MAX; 3]).is_none());
    // rust: assert!(cluster_query([-f64::MAX; 3], [f64::MAX; 3]).is_none());
}

pub fn particles_in_one_cluster_share_one_occlusion_query() void {
}
    // rust: let first = cluster_query([0.1, 1.0, 2.0], [0.3, 1.2, 2.2]).unwrap();
    // rust: let second = cluster_query([3.0, 3.0, 3.0], [3.4, 3.4, 3.4]).unwrap();

    // rust: assert_eq!(first, second);

    // rust: let mut cache = ClusterVisibilityCache::default();
    // rust: let mut queries = 0;
    // rust: assert!(cache.get_or_compute(first.0, || {
    // rust: queries += 1;
    // rust: true
    // rust: }));
    // rust: assert!(cache.get_or_compute(second.0, || {
    // rust: queries += 1;
    // rust: false
    // rust: }));
    // rust: assert_eq!(queries, 1);
}

pub fn a_direct_mapped_cache_collision_never_reuses_another_cluster_answer() void {
}
    // rust: let candidates = (0..=CLUSTER_CACHE_SIZE)
    // rust: .map(|x| [i32::try_from(x).unwrap(), 0, 0])
    // rust: .collect::<Vec<_>>();
    // rust: let (first, second) = (0..candidates.len())
    // rust: .find_map(|i| {
    // rust: ((i + 1)..candidates.len())
    // rust: .find(|&j| {
    // rust: cluster_cache_slot(candidates[i]) == cluster_cache_slot(candidates[j])
    // rust: })
    // rust: .map(|j| (candidates[i], candidates[j]))
    // rust: })
    // rust: .expect("1025 distinct keys must contain a collision in a 1024-slot cache");
    // rust: let mut cache = ClusterVisibilityCache::default();

    // rust: cache.insert(first, true);
    // rust: assert_eq!(cache.get(first), Some(true));
    // rust: cache.insert(second, false);
    // rust: assert_eq!(cache.get(first), None);
    // rust: assert_eq!(cache.get(second), Some(false));
}

pub fn particle_worker_requires_a_complete_opaque_plane_to_hide() void {
}
    // rust: let (snapshot, live) = wall(None);
    // rust: let results = cull_job(wall_job(snapshot));
    // rust: let proof = results.answers[0].1.as_ref().unwrap();
    // rust: assert_eq!(proof.sections.len(), 4);
    // rust: assert_eq!(proof.chunks.len(), 2);
    // rust: drop(live);

    // rust: let (snapshot, live) = wall(Some([4, 0, 0]));
    // rust: let results = cull_job(wall_job(snapshot));
    // rust: assert!(results.answers[0].1.is_none());
    // rust: drop(live);
}
}
