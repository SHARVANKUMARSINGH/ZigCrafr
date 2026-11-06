//! Transpiled from Horizon Rust crate
//! Module: horizon-client_occlusion_culling
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Shared, conservative block-occlusion queries for renderable geometry.
// use super::{Game, Vertex};
// use horizon_client::{
    // rust: blocks::{BlockFacts, RenderShape, StateFacts},
    // rust: chunk::Chunk,
    // rust: gfx::Renderer,
    // rust: graphics::EntityCullingMode,
    // rust: mesher::SectionMesh,
    // rust: spans,
    // rust: streaming::Streaming,
    // rust: voxel_occlusion::Culler as OcclusionCuller,
    // rust: world::World,
}
// use horizon_core::geometry::Aabb;
// use std::{
    // rust: cell::{Cell, RefCell},
    // rust: sync::{
    // rust: Arc, Weak,
    // rust: atomic::{AtomicU64, Ordering},
    // rust: mpsc::{self, Receiver, SyncSender, TrySendError},
    // rust: },
    // rust: thread::JoinHandle,
    // rust: time::Instant,
}

    // rust: type ChunkKey = (i32, i32);
    // rust: type SectionKey = (i32, i32, i32);
pub const MAX_SNAPSHOT_CHUNKS: i64 = 4_096;
pub const MAX_OCCLUSION_RESULT_CACHE_ENTRIES: usize = 16_384;
pub const RESULT_CACHE_IDLE_FRAMES: u64 = 2;
pub const OCCLUSION_LOOKUP_BUDGET: usize = 8_192;
pub const OPACITY_GRID_SIZE: usize = 1_024;
pub const MAX_OCCLUSION_RAY_STEPS: usize = 512;
pub const CAMERA_SUBCELL_SCALE: f64 = 4.0;
pub const QUERY_BOUNDS_SCALE: f64 = 4.0;
pub const TIMING_SAMPLE_CAPACITY: usize = 256;
pub const PROOF_VALIDATION_TIMING_SAMPLE_STRIDE: u64 = 16;

/// A bounded ring of recent timings. Recording a sample is allocation-free;
/// percentile sorting only happens when a control client requests statistics.
pub const TimingSamples = struct {
    values: [u64,
    len: usize,
    next: usize,
};

    // rust: impl Default for TimingSamples {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: values: [0; TIMING_SAMPLE_CAPACITY],
    // rust: len: 0,
    // rust: next: 0,
}
}
}

    // rust: impl TimingSamples {
pub fn record(self: *Self, nanoseconds: u64) void {
}
    // rust: self.values[self.next] = nanoseconds;
    // rust: self.next = (self.next + 1) % TIMING_SAMPLE_CAPACITY;
    // rust: self.len = (self.len + 1).min(TIMING_SAMPLE_CAPACITY);
}

    /// Nearest-rank p50 and p95 of the most recent samples.
pub fn percentiles_ns(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.len == 0 {
    // rust: return (None, None);
}
    // rust: let mut sorted = self.values;
    // rust: sorted[..self.len].sort_unstable();
    // rust: let p50 = (self.len * 50).div_ceil(100).max(1) - 1;
    // rust: let p95 = (self.len * 95).div_ceil(100).max(1) - 1;
    // rust: (Some(sorted[p50]), Some(sorted[p95]))
}
}

/// Identifies which geometry stage consumed a cached answer. Entity AABBs
/// should usually avoid model generation; mesh bounds are the conservative
/// refinement for visible or uncached AABBs.
    // rust: pub(super) enum QuerySource {
    // rust: EntityAabb,
    // rust: EntityMesh,
}

pub const TimingPhase = enum {
    ResultConsume,
    FrameSubmit,
    JobSend,
    ResultLookup,
};

pub const CacheMissReason = enum {
    EmptySet,
    KeyMismatch,
    CameraMismatch,
    Invalidated,
};

pub const TimingStart = struct {
    wall: Instant,
    thread_cpu: ?std::time::Duration,
};

pub const PhaseTiming = struct {
    wall_ns: u64,
    thread_cpu_ns: u64,
    sample_weight: u64,
    wall_samples: TimingSamples,
    thread_cpu_samples: TimingSamples,
};

    // rust: impl PhaseTiming {
pub fn record(self: *Self, wall_ns: u64, thread_cpu_ns: ?u64, sample_weight: u64) void {
}
    // rust: self.wall_ns = self
    // rust: .wall_ns
    // rust: .saturating_add(wall_ns.saturating_mul(sample_weight));
    // rust: self.sample_weight = sample_weight;
    // rust: self.wall_samples.record(wall_ns);
    // rust: if let Some(thread_cpu_ns) = thread_cpu_ns {
    // rust: self.thread_cpu_ns = self
    // rust: .thread_cpu_ns
    // rust: .saturating_add(thread_cpu_ns.saturating_mul(sample_weight));
    // rust: self.thread_cpu_samples.record(thread_cpu_ns);
}
}
}

pub const EntityBoundsSample = struct {
    frame: u64,
    entity_id: u32,
    camera: [u64,
    min: [u64,
    max: [u64,
};

pub const ProofValidationCounts = struct {
    chunk_checks: u64,
    chunk_cache_hits: u64,
    section_checks: u64,
    section_cache_hits: u64,
    epoch_hits: u64,
};

pub const CachedChunkValidation = struct {
    key: ChunkKey,
    allocation: usize,
    current: bool,
};

/// Proofs for nearby entities commonly name the same few occluding chunks and
/// sections. Keep their validity in sorted vectors and stamp successful checks
/// with an epoch so a stable frame can validate the same certificate in O(1).
pub const FrameProofValidationCache = struct {
    chunks: std.ArrayList(CachedChunkValidation),
    sections: Vec<(SectionKey,
    valid_epoch: u64,
    frame_verified: bool,
    scene_stamp: ?SnapshotKey,
    streaming_sequence: ?u64,
    renderer_sections: ?usize,
};

    // rust: impl Default for FrameProofValidationCache {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: chunks: Vec::new(),
    // rust: sections: Vec::new(),
    // rust: valid_epoch: 1,
    // rust: frame_verified: false,
    // rust: scene_stamp: None,
    // rust: streaming_sequence: None,
    // rust: renderer_sections: None,
}
}
}

    // rust: impl FrameProofValidationCache {
pub fn begin_frame(self: *Self) void {
}
    // rust: self.frame_verified = false;
}

pub fn bump_epoch(self: *Self) void {
}
    // rust: self.chunks.clear();
    // rust: self.sections.clear();
    // rust: self.valid_epoch = self.valid_epoch.wrapping_add(1).max(1);
}

    // rust: fn ensure_frame_verified(
    // rust: &mut self,
    // rust: stamp: SnapshotKey,
    // rust: world: &World,
    // rust: renderer: Option<&Renderer>,
    // rust: streaming: &Streaming,
    // rust: pending_uploads: &[((i32, i32, i32), SectionMesh)],
    // rust: counts: &mut ProofValidationCounts,
    // rust: ) {
    // rust: if self.frame_verified {
    // rust: return;
}
    // rust: self.frame_verified = true;

    // rust: let streaming_sequence = streaming.sequence();
    // rust: let renderer_sections = renderer.map_or(0, Renderer::section_count);
    // rust: let scene_changed = self.scene_stamp.is_some_and(|previous| {
    // rust: previous != stamp
    // rust: || self.streaming_sequence != Some(streaming_sequence)
    // rust: || self.renderer_sections != Some(renderer_sections)
    // rust: });
    // rust: self.scene_stamp = Some(stamp);
    // rust: self.streaming_sequence = Some(streaming_sequence);
    // rust: self.renderer_sections = Some(renderer_sections);
    // rust: if scene_changed {
    // rust: self.bump_epoch();
    // rust: return;
}
    // rust: if self.chunks.is_empty() && self.sections.is_empty() {
    // rust: return;
}
    // rust: if self.chunks.len() > 64 || self.sections.len() > 128 {
    // rust: self.bump_epoch();
    // rust: return;
}

    // rust: let mut invalid = false;
    // rust: for entry in &self.chunks {
    // rust: counts.chunk_checks = counts.chunk_checks.saturating_add(1);
    // rust: if !entry.current
    // rust: || !world
    // rust: .chunks
    // rust: .get(&entry.key)
    // rust: .is_some_and(|chunk| Arc::as_ptr(chunk) as usize == entry.allocation)
    // rust: {
    // rust: invalid = true;
    // rust: break;
}
}
    // rust: if invalid {
    // rust: self.bump_epoch();
    // rust: return;
}

    // rust: for &(key, current) in &self.sections {
    // rust: counts.section_checks = counts.section_checks.saturating_add(1);
    // rust: if !current
    // rust: || !renderer.is_some_and(|renderer| renderer.has_section(key))
    // rust: || world.dirty_sections.contains(&key)
    // rust: || streaming.is_meshing(key)
    // rust: || pending_uploads.iter().any(|(pending, _)| *pending == key)
    // rust: {
    // rust: invalid = true;
    // rust: break;
}
}
    // rust: if invalid {
    // rust: self.bump_epoch();
}
}

    // rust: fn chunk_is_current(
    // rust: &mut self,
    // rust: world: &World,
    // rust: key: ChunkKey,
    // rust: expected: &Weak<Chunk>,
    // rust: counts: &mut ProofValidationCounts,
    // rust: ) -> bool {
    // rust: let allocation = expected.as_ptr() as usize;
    // rust: let cache_key = (key, allocation);
    // rust: match self
    // rust: .chunks
    // rust: .binary_search_by_key(&cache_key, |entry| (entry.key, entry.allocation))
    // rust: {
    // rust: Ok(index) => {
    // rust: counts.chunk_cache_hits = counts.chunk_cache_hits.saturating_add(1);
    // rust: self.chunks[index].current
}
    // rust: Err(index) => {
    // rust: counts.chunk_checks = counts.chunk_checks.saturating_add(1);
    // rust: let current = world
    // rust: .chunks
    // rust: .get(&key)
    // rust: .is_some_and(|chunk| std::ptr::eq(Arc::as_ptr(chunk), expected.as_ptr()));
    // rust: self.chunks.insert(
    // rust: index,
    // rust: CachedChunkValidation {
    // rust: key,
    // rust: allocation,
    // rust: current,
    // rust: },
    // rust: );
    // rust: current
}
}
}

    // rust: fn section_is_current(
    // rust: &mut self,
    // rust: key: SectionKey,
    // rust: world: &World,
    // rust: renderer: Option<&Renderer>,
    // rust: streaming: &Streaming,
    // rust: pending_uploads: &[((i32, i32, i32), SectionMesh)],
    // rust: counts: &mut ProofValidationCounts,
    // rust: ) -> bool {
    // rust: match self.sections.binary_search_by_key(&key, |(key, _)| *key) {
    // rust: Ok(index) => {
    // rust: counts.section_cache_hits = counts.section_cache_hits.saturating_add(1);
    // rust: self.sections[index].1
}
    // rust: Err(index) => {
    // rust: counts.section_checks = counts.section_checks.saturating_add(1);
    // rust: let current = renderer.is_some_and(|renderer| renderer.has_section(key))
    // rust: && !world.dirty_sections.contains(&key)
    // rust: && !streaming.is_meshing(key)
    // rust: && !pending_uploads.iter().any(|(pending, _)| *pending == key);
    // rust: self.sections.insert(index, (key, current));
    // rust: current
}
}
}
}

    // rust: pub(super) struct CullKey {
    // rust: camera: [u64; 3],
    // rust: min: [u64; 3],
    // rust: max: [u64; 3],
}

    // rust: type QueryBoundsKey = ([u64; 3], [u64; 3]);

pub fn query_bounds_key(key: *CullKey) Q {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (key.min, key.max)
}

pub const SnapshotKey = struct {
    world_revision: u64,
    chunks_revision: u64,
    bottom_y: i32,
};

    // rust: impl SnapshotKey {
pub fn same_layout(self: *Self, other: Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.chunks_revision == other.chunks_revision && self.bottom_y == other.bottom_y
}
}

pub const ChunkBounds = struct {
    min_x: i32,
    max_x: i32,
    min_z: i32,
    max_z: i32,
};

/// Sorted weak chunk references avoid holding gameplay chunks or forcing
/// copy-on-write. A worker keeps only its current chunk strongly referenced.
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
    slots: [(?ChunkKey,
};

    // rust: impl LastChunk {
pub fn clear(self: *Self) void {
}
    // rust: self.slots = Default::default();
}

pub fn get(self: *Self, snapshot: *OcclusionSnapshot, key: ChunkKey) O {
    // Implementation ported from Horizon
    return undefined;
}
        // Any 2x2 neighborhood of adjacent chunks has distinct (x & 1, z & 1)
        // parities. Keep all four around so rays crossing a border do not churn
        // Weak::upgrade and Arc::drop on every voxel.
    // rust: let slot = &mut self.slots[(((key.0 as usize) & 1) << 1) | ((key.1 as usize) & 1)];
    // rust: if slot.0 != Some(key) {
    // rust: slot.0 = Some(key);
    // rust: slot.1 = snapshot.chunk(key).and_then(Weak::upgrade);
}
    // rust: slot.1.as_ref()
}
}

pub const OpacityCell = struct {
    position: [i32,
    epoch: u16,
    opaque: bool,
};

/// A direct-mapped voxel cache shared by the rays and box checks in one job.
pub const OpacityGrid = struct {
    epoch: u16,
    cells: [OpacityCell,
};

    // rust: impl Default for OpacityGrid {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: epoch: 1,
    // rust: cells: [OpacityCell::default(); OPACITY_GRID_SIZE],
}
}
}

    // rust: impl OpacityGrid {
pub fn clear(self: *Self) void {
}
    // rust: self.epoch = self.epoch.wrapping_add(1);
    // rust: if self.epoch == 0 {
    // rust: self.cells.fill(OpacityCell::default());
    // rust: self.epoch = 1;
}
}

    // rust: fn opaque(
    // rust: &mut self,
    // rust: snapshot: &OcclusionSnapshot,
    // rust: position: [i32; 3],
    // rust: last_chunk: &mut LastChunk,
    // rust: ) -> bool {
    // rust: let hash = (position[0] as u32).wrapping_mul(73_856_093)
    // rust: ^ (position[1] as u32).wrapping_mul(19_349_663)
    // rust: ^ (position[2] as u32).wrapping_mul(83_492_791);
    // rust: let mixed = hash ^ (hash >> 10) ^ (hash >> 20);
    // rust: let slot = mixed as usize & (OPACITY_GRID_SIZE - 1);
    // rust: let cell = &mut self.cells[slot];
    // rust: if cell.epoch == self.epoch && cell.position == position {
    // rust: return cell.opaque;
}
    // rust: let opaque = snapshot.opaque(position, last_chunk);
    // rust: *cell = OpacityCell {
    // rust: position,
    // rust: epoch: self.epoch,
    // rust: opaque,
}
    // rust: opaque
}
}

    // rust: fn bounds_have_clear_ray(
    // rust: camera: [f64; 3],
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: snapshot: &OcclusionSnapshot,
    // rust: last_chunk: &mut LastChunk,
    // rust: opacity_grid: &mut OpacityGrid,
    // rust: ) -> bool {
    // rust: let center = std::array::from_fn(|axis| min[axis] + (max[axis] - min[axis]) * 0.5);
    // rust: ray_reaches_without_opaque(center, camera, snapshot, last_chunk, opacity_grid)
}

/// A clear sample only short-circuits culling; blocked samples still need the
/// conservative complete-plane test before the worker can hide geometry.
    // rust: fn ray_reaches_without_opaque(
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: snapshot: &OcclusionSnapshot,
    // rust: last_chunk: &mut LastChunk,
    // rust: opacity_grid: &mut OpacityGrid,
    // rust: ) -> bool {
    // rust: if from.into_iter().chain(to).any(|value| !value.is_finite()) {
    // rust: return true;
}
    // rust: let [Some(x), Some(y), Some(z)] = from.map(snapshot_cell) else {
    // rust: return true;
}
    // rust: let mut cell = [x, y, z];
    // rust: let [Some(x), Some(y), Some(z)] = to.map(snapshot_cell) else {
    // rust: return true;
}
    // rust: let target = [x, y, z];
    // rust: if opacity_grid.opaque(snapshot, cell, last_chunk) {
    // rust: return false;
}
    // rust: if cell == target {
    // rust: return true;
}
    // rust: if opacity_grid.opaque(snapshot, target, last_chunk) {
    // rust: return false;
}

    // rust: let delta: [f64; 3] = std::array::from_fn(|axis| to[axis] - from[axis]);
    // rust: let mut step = [0_i32; 3];
    // rust: let mut t_max = [f64::INFINITY; 3];
    // rust: let mut t_delta = [f64::INFINITY; 3];
    // rust: for axis in 0..3 {
    // rust: if delta[axis] > 0.0 {
    // rust: step[axis] = 1;
    // rust: t_max[axis] = (f64::from(cell[axis]) + 1.0 - from[axis]) / delta[axis];
    // rust: t_delta[axis] = 1.0 / delta[axis];
    // rust: } else if delta[axis] < 0.0 {
    // rust: step[axis] = -1;
    // rust: t_max[axis] = (from[axis] - f64::from(cell[axis])) / -delta[axis];
    // rust: t_delta[axis] = -1.0 / delta[axis];
}
}

    // rust: for _ in 0..MAX_OCCLUSION_RAY_STEPS {
    // rust: let axis = if t_max[0] <= t_max[1] && t_max[0] <= t_max[2] {
    // rust: 0
    // rust: } else if t_max[1] <= t_max[2] {
    // rust: 1
    // rust: } else {
    // rust: 2
}
    // rust: if t_max[axis] > 1.0 {
    // rust: return true;
}
    // rust: let Some(next) = cell[axis].checked_add(step[axis]) else {
    // rust: return true;
}
    // rust: cell[axis] = next;
    // rust: if cell == target {
    // rust: return true;
}
    // rust: if opacity_grid.opaque(snapshot, cell, last_chunk) {
    // rust: return false;
}
    // rust: t_max[axis] += t_delta[axis];
}
    // An overlong ray is not a proof of occlusion, so keep geometry visible.
    // rust: true
}

    // rust: pub(super) struct OcclusionProof {
    // rust: sections: Vec<SectionKey>,
    // rust: chunks: Vec<(ChunkKey, Weak<Chunk>)>,
    // rust: validated_epoch: Cell<u64>,
}

pub const CullResults = struct {
    stamp: SnapshotKey,
    camera: [u64,
    generation: u64,
    cancelled: bool,
    hidden: Vec<(CullKey,
    visible: std.ArrayList(CullKey),
    scratch_queries: std.ArrayList(CullKey),
    worker_ns: u64,
    hidden_entities: usize,
    visible_entities: usize,
    deferred_entities: usize,
};

pub const CachedQueryResult = struct {
    key: CullKey,
    stamp: SnapshotKey,
    camera_cell: Option<[i32,
    proof: ?OcclusionProof,
    last_used_frame: Cell<u64>,
};

pub const AsyncCullingStats = struct {
    frames: u64,
    entity_queries: u64,
    entity_cache_hits: u64,
    entity_cache_misses: u64,
    entity_aabb_cache_hits: u64,
    entity_aabb_cache_misses: u64,
    entity_mesh_cache_hits: u64,
    entity_mesh_cache_misses: u64,
    result_cache_evictions: u64,
    result_cache_capacity_evictions: u64,
    result_cache_idle_evictions: u64,
    result_cache_invalidation_replacements: u64,
    cache_miss_empty_set: u64,
    cache_miss_key_mismatch: u64,
    cache_miss_camera_mismatch: u64,
    cache_miss_invalidated: u64,
    entity_vertices_scanned: u64,
    entity_vertices_culled: u64,
    entity_bytes_culled: u64,
    entities_culled: u64,
    queued_queries: u64,
    queries_dropped_while_pending: u64,
    worker_jobs: u64,
    worker_jobs_completed: u64,
    worker_job_query_count_samples: TimingSamples,
    worker_job_queries: u64,
    job_send_full: u64,
    job_send_disconnected: u64,
    stale_camera_jobs: u64,
    stale_world_jobs: u64,
    worker_cancelled_jobs: u64,
    worker_ns: u64,
    worker_job_samples: TimingSamples,
    bounds_scan_ns: u64,
    bounds_scan_samples: TimingSamples,
    worker_hidden_entities: u64,
    worker_visible_entities: u64,
    worker_deferred_entities: u64,
    entity_budget_exhausted_jobs: u64,
    result_consume_timing: PhaseTiming,
    frame_submit_timing: PhaseTiming,
    job_send_timing: PhaseTiming,
    result_lookup_timing: PhaseTiming,
    proof_validation_timing: PhaseTiming,
    proof_validation_counts: ProofValidationCounts,
    result_lookup_calls: u64,
    sampled_entity_id: ?u32,
    sampled_entity_last_frame: u64,
    entity_bounds_samples: std.ArrayList(EntityBoundsSample),
    previous_world_revision: ?u64,
    previous_chunks_revision: ?u64,
    world_revision_changes: u64,
    chunks_revision_changes: u64,
};

pub const CullJob = struct {
    stamp: SnapshotKey,
    snapshot_epoch: u64,
    generation: u64,
    snapshot: *OcclusionSnapshot,
    queries: std.ArrayList(CullKey),
    clear_visible: std.ArrayList(CullKey),
    hidden: Vec<(CullKey,
    rays_filtered: bool,
};

/// Scratch owned by the ray stage. The query vectors cross the channel with a
/// job, while these buffers retain their capacity for the next job. Keeping
/// the direct-mapped grid between unchanged snapshots also preserves spatial
/// coherence across frames without retaining a chunk allocation.
pub const RayWorkerScratch = struct {
    input: std.ArrayList(CullKey),
    blocked: std.ArrayList(CullKey),
    clear_visible: std.ArrayList(CullKey),
    last_chunk: LastChunk,
    opacity_grid: OpacityGrid,
    snapshot_epoch: ?u64,
};

    // rust: impl RayWorkerScratch {
pub fn prepare(self: *Self, snapshot_epoch: u64) void {
}
    // rust: if self.snapshot_epoch != Some(snapshot_epoch) {
    // rust: self.opacity_grid.clear();
    // rust: self.snapshot_epoch = Some(snapshot_epoch);
}
    // rust: self.last_chunk.clear();
    // rust: self.blocked.clear();
    // rust: self.clear_visible.clear();
}
}

/// Scratch owned by the plane stage. The covered-cell and section buffers are
/// reused for every entity and every job so proof construction only allocates
/// the exact deduplicated section count.
pub const PlaneWorkerScratch = struct {
    covered: Vec<[i32,
    sections: std.ArrayList(SectionKey),
    last_chunk: LastChunk,
    opacity_grid: OpacityGrid,
    snapshot_epoch: ?u64,
};

    // rust: impl PlaneWorkerScratch {
pub fn prepare(self: *Self, snapshot_epoch: u64) void {
}
    // rust: if self.snapshot_epoch != Some(snapshot_epoch) {
    // rust: self.opacity_grid.clear();
    // rust: self.snapshot_epoch = Some(snapshot_epoch);
}
    // rust: self.last_chunk.clear();
    // rust: self.covered.clear();
    // rust: self.sections.clear();
}
}

/// Non-blocking world occlusion for entity rendering.
/// Hidden proofs require the exact camera and quantized bounds, and their
/// chunks and rendered sections are revalidated. Fail-open visible results
/// survive camera movement because they can only reduce culling.
    // rust: pub(super) struct AsyncOcclusionCuller {
    // rust: jobs: SyncSender<CullJob>,
    // rust: _ray_thread: JoinHandle<()>,
    // rust: results_rx: Receiver<CullResults>,
    // rust: _thread: JoinHandle<()>,
    // rust: job_generation: Arc<AtomicU64>,
    // rust: snapshot: Option<(SnapshotKey, ChunkBounds, Arc<OcclusionSnapshot>)>,
    // rust: snapshot_epoch: u64,
    // rust: opaque_states: Option<Arc<[bool]>>,
    // rust: queries: RefCell<Vec<CullKey>>,
    // rust: query_results: Vec<CachedQueryResult>,
    // rust: cache_updates: Vec<CachedQueryResult>,
    // rust: cache_merge: Vec<CachedQueryResult>,
    // rust: recycled_visible: Vec<CullKey>,
    // rust: recycled_hidden: Vec<(CullKey, OcclusionProof)>,
    // rust: stats: RefCell<AsyncCullingStats>,
    // rust: proof_validation_cache: RefCell<FrameProofValidationCache>,
    // rust: measure_bounds_timing: Cell<bool>,
    // rust: query_cache_stamp: Option<SnapshotKey>,
    // rust: query_cache_camera_cell: Option<[i32; 3]>,
    // rust: camera: [f64; 3],
    // rust: previous_camera_key: Option<[u64; 3]>,
    // rust: camera_stationary: bool,
    // rust: stamp: SnapshotKey,
    // rust: pending: bool,
    // rust: frame: u64,
    // rust: proof_validation_sample_counter: Cell<u64>,
}

    // rust: impl AsyncOcclusionCuller {
pub fn timing_start(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.measure_bounds_timing.get().then(|| {
    // rust: let thread_cpu = spans::thread_cpu();
    // rust: TimingStart {
    // rust: wall: Instant::now(),
    // rust: thread_cpu,
}
    // rust: })
}

pub fn record_timing(self: *Self, phase: TimingPhase, started: ?TimingStart) void {
}
    // rust: let Some(started) = started else {
    // rust: return;
}
    // rust: let wall_ns = started.wall.elapsed().as_nanos().min(u128::from(u64::MAX)) as u64;
    // rust: let thread_cpu_ns = spans::thread_cpu()
    // rust: .zip(started.thread_cpu)
    // rust: .map(|(end, start)| {
    // rust: end.saturating_sub(start)
    // rust: .as_nanos()
    // rust: .min(u128::from(u64::MAX)) as u64
    // rust: });
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: let timing = match phase {
    // rust: TimingPhase::ResultConsume => &mut stats.result_consume_timing,
    // rust: TimingPhase::FrameSubmit => &mut stats.frame_submit_timing,
    // rust: TimingPhase::JobSend => &mut stats.job_send_timing,
    // rust: TimingPhase::ResultLookup => &mut stats.result_lookup_timing,
}
    // rust: timing.record(wall_ns, thread_cpu_ns, 1);
}

pub fn timing_value(timing: *PhaseTiming) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (wall_p50_ns, wall_p95_ns) = timing.wall_samples.percentiles_ns();
    // rust: let (cpu_p50_ns, cpu_p95_ns) = timing.thread_cpu_samples.percentiles_ns();
    // rust: serde_json::json!({
    // rust: "wall_ms_total": timing.wall_ns as f64 / 1_000_000.0,
    // rust: "wall_ns_p50_recent": wall_p50_ns,
    // rust: "wall_ns_p95_recent": wall_p95_ns,
    // rust: "wall_samples": timing.wall_samples.len,
    // rust: "thread_cpu_ms_total": timing.thread_cpu_ns as f64 / 1_000_000.0,
    // rust: "thread_cpu_ns_p50_recent": cpu_p50_ns,
    // rust: "thread_cpu_ns_p95_recent": cpu_p95_ns,
    // rust: "thread_cpu_samples": timing.thread_cpu_samples.len,
    // rust: "sample_weight": timing.sample_weight.max(1),
    // rust: "totals_are_sampled_estimates": timing.sample_weight > 1,
    // rust: })
}

    // rust: pub(super) fn new() -> std::io::Result<Self> {
    // rust: let (job_tx, job_rx) = mpsc::sync_channel::<CullJob>(1);
    // rust: let (plane_tx, plane_rx) = mpsc::sync_channel::<CullJob>(1);
    // rust: let (result_tx, result_rx) = mpsc::channel::<CullResults>();
    // rust: let job_generation = Arc::new(AtomicU64::new(0));
    // rust: let worker_generation = Arc::clone(&job_generation);
    // rust: let plane_generation = Arc::clone(&job_generation);
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("world-occlusion-culling".into())
    // rust: .spawn(move || {
    // rust: let mut scratch = PlaneWorkerScratch::default();
    // rust: while let Ok(job) = plane_rx.recv() {
    // rust: if result_tx
    // rust: .send(cull_job(job, &plane_generation, &mut scratch))
    // rust: .is_err()
    // rust: {
    // rust: break;
}
}
    // rust: })?;
    // rust: let ray_plane_tx = plane_tx.clone();
    // rust: let ray_thread = std::thread::Builder::new()
    // rust: .name("entity-ray-cull".into())
    // rust: .spawn(move || {
    // rust: let mut scratch = RayWorkerScratch::default();
    // rust: while let Ok(mut job) = job_rx.recv() {
    // rust: filter_rays(&mut job, &worker_generation, &mut scratch);
    // rust: if ray_plane_tx.send(job).is_err() {
    // rust: break;
}
}
    // rust: })?;
    // rust: Ok(Self {
    // rust: jobs: job_tx,
    // rust: _ray_thread: ray_thread,
    // rust: results_rx: result_rx,
    // rust: _thread: thread,
    // rust: job_generation,
    // rust: snapshot: None,
    // rust: snapshot_epoch: 0,
    // rust: opaque_states: None,
    // rust: queries: RefCell::new(Vec::new()),
    // rust: query_results: Vec::new(),
    // rust: cache_updates: Vec::new(),
    // rust: cache_merge: Vec::new(),
    // rust: recycled_visible: Vec::new(),
    // rust: recycled_hidden: Vec::new(),
    // rust: stats: RefCell::new(AsyncCullingStats::default()),
    // rust: proof_validation_cache: RefCell::new(FrameProofValidationCache::default()),
    // rust: measure_bounds_timing: Cell::new(
    // rust: std::env::var("HORIZON_OCCLUSION_PROFILE").is_ok_and(|v| v == "1"),
    // rust: ),
    // rust: query_cache_stamp: None,
    // rust: query_cache_camera_cell: None,
    // rust: camera: [0.0; 3],
    // rust: previous_camera_key: None,
    // rust: camera_stationary: true,
    // rust: stamp: SnapshotKey {
    // rust: world_revision: 0,
    // rust: chunks_revision: 0,
    // rust: bottom_y: 0,
    // rust: },
    // rust: pending: false,
    // rust: frame: 0,
    // rust: proof_validation_sample_counter: Cell::new(0),
    // rust: })
}

    // rust: pub(super) fn begin_frame(&mut self, camera: glam::DVec3, world: &World) {
    // rust: let started = self.timing_start();
    // rust: self.begin_frame_inner(camera, world);
    // rust: self.record_timing(TimingPhase::ResultConsume, started);
}

pub fn begin_frame_inner(self: *Self, camera: glam::DVec3, world: *World) void {
}
    // rust: self.frame = self.frame.saturating_add(1);
    // rust: self.camera = camera.to_array();
    // rust: self.stamp = SnapshotKey {
    // rust: world_revision: world.revision,
    // rust: chunks_revision: world.chunks.membership_revision(),
    // rust: bottom_y: world.bottom_y(),
}
    // rust: self.proof_validation_cache.get_mut().begin_frame();
    // rust: {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.frames = stats.frames.saturating_add(1);
    // rust: if stats
    // rust: .previous_world_revision
    // rust: .is_some_and(|revision| revision != self.stamp.world_revision)
    // rust: {
    // rust: stats.world_revision_changes = stats.world_revision_changes.saturating_add(1);
}
    // rust: if stats
    // rust: .previous_chunks_revision
    // rust: .is_some_and(|revision| revision != self.stamp.chunks_revision)
    // rust: {
    // rust: stats.chunks_revision_changes = stats.chunks_revision_changes.saturating_add(1);
}
    // rust: stats.previous_world_revision = Some(self.stamp.world_revision);
    // rust: stats.previous_chunks_revision = Some(self.stamp.chunks_revision);
}
    // rust: let camera_key = self.camera.map(f64::to_bits);
    // rust: self.camera_stationary = self
    // rust: .previous_camera_key
    // rust: .is_none_or(|previous| previous == camera_key);
    // rust: self.previous_camera_key = Some(camera_key);
    // rust: let current_camera_cell = camera_cell(self.camera);
    // rust: let layout_changed = self
    // rust: .query_cache_stamp
    // rust: .is_some_and(|stamp| !stamp.same_layout(self.stamp));
    // rust: if layout_changed {
            // Invalidate in-flight work in O(1) when the world layout changes.
            // Hidden proofs are tied to the exact camera position; stale-camera
            // results below are retained only as fail-open visibility.
    // rust: self.job_generation.fetch_add(1, Ordering::Relaxed);
}
    // rust: self.query_cache_stamp = Some(self.stamp);
    // rust: self.query_cache_camera_cell = current_camera_cell;
    // rust: while let Ok(mut results) = self.results_rx.try_recv() {
    // rust: self.pending = false;
    // rust: {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.worker_jobs_completed = stats.worker_jobs_completed.saturating_add(1);
    // rust: stats.worker_ns = stats.worker_ns.saturating_add(results.worker_ns);
    // rust: stats.worker_job_samples.record(results.worker_ns);
    // rust: stats.worker_hidden_entities = stats
    // rust: .worker_hidden_entities
    // rust: .saturating_add(results.hidden_entities as u64);
    // rust: stats.worker_visible_entities = stats
    // rust: .worker_visible_entities
    // rust: .saturating_add(results.visible_entities as u64);
    // rust: stats.worker_deferred_entities = stats
    // rust: .worker_deferred_entities
    // rust: .saturating_add(results.deferred_entities as u64);
    // rust: stats.entity_budget_exhausted_jobs = stats
    // rust: .entity_budget_exhausted_jobs
    // rust: .saturating_add(u64::from(results.deferred_entities != 0));
}
    // rust: let generation = self.job_generation.load(Ordering::Relaxed);
    // rust: if results.stamp.same_layout(self.stamp)
    // rust: && results.generation == generation
    // rust: && !results.cancelled
    // rust: {
    // rust: if results.stamp.world_revision != self.stamp.world_revision {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.stale_world_jobs = stats.stale_world_jobs.saturating_add(1);
}
    // rust: if results.camera != camera_key {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.stale_camera_jobs = stats.stale_camera_jobs.saturating_add(1);
}
    // rust: self.cache_results_for_camera(&mut results, camera_key);
    // rust: let scratch = std::mem::take(&mut results.scratch_queries);
    // rust: if scratch.capacity() > self.queries.get_mut().capacity() {
    // rust: *self.queries.get_mut() = scratch;
}
    // rust: } else {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.worker_cancelled_jobs = stats
    // rust: .worker_cancelled_jobs
    // rust: .saturating_add(u64::from(results.cancelled));
    // rust: stats.stale_camera_jobs = stats.stale_camera_jobs.saturating_add(u64::from(
    // rust: results.camera != camera_key || results.generation != generation,
    // rust: ));
    // rust: stats.stale_world_jobs = stats
    // rust: .stale_world_jobs
    // rust: .saturating_add(u64::from(!results.stamp.same_layout(self.stamp)));
}
    // rust: let visible = std::mem::take(&mut results.visible);
    // rust: if visible.capacity() > self.recycled_visible.capacity() {
    // rust: self.recycled_visible = visible;
}
    // rust: let hidden = std::mem::take(&mut results.hidden);
    // rust: if hidden.capacity() > self.recycled_hidden.capacity() {
    // rust: self.recycled_hidden = hidden;
}
}
    // rust: self.queries.get_mut().clear();
}

    // rust: pub(super) fn camera_is_stationary(&self) -> bool {
    // rust: self.camera_stationary
}

    // rust: pub(super) fn query(&self, vertices: &[Vertex], start: usize) -> Option<CullKey> {
    // rust: let scan_started = self.measure_bounds_timing.get().then(Instant::now);
    // rust: let bounds = OcclusionCuller::bounds(self.camera, vertices, start);
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.entity_queries = stats.entity_queries.saturating_add(1);
    // rust: stats.entity_vertices_scanned = stats
    // rust: .entity_vertices_scanned
    // rust: .saturating_add(vertices.len().saturating_sub(start) as u64);
    // rust: if let Some(started) = scan_started {
    // rust: let scan_ns = started.elapsed().as_nanos().min(u128::from(u64::MAX)) as u64;
    // rust: stats.bounds_scan_ns = stats.bounds_scan_ns.saturating_add(scan_ns);
    // rust: stats.bounds_scan_samples.record(scan_ns);
}
    // rust: drop(stats);
    // rust: let (min, max) = bounds?;
    // rust: self.query_bounds(min, max)
}

    // rust: pub(super) fn query_entity_bounds(&self, bounds: Aabb) -> Option<CullKey> {
    // rust: let (min, max) = OcclusionCuller::aabb_bounds(bounds)?;
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.entity_queries = stats.entity_queries.saturating_add(1);
    // rust: drop(stats);
    // rust: self.query_bounds(min, max)
}

    // rust: pub(super) fn query_camera_bounds(&self, lo: glam::Vec3, hi: glam::Vec3) -> Option<CullKey> {
    // rust: let min_rel = lo.min(hi);
    // rust: let max_rel = lo.max(hi);
    // rust: let min = [
    // rust: f64::from(min_rel.x) + self.camera[0],
    // rust: f64::from(min_rel.y) + self.camera[1],
    // rust: f64::from(min_rel.z) + self.camera[2],
    // rust: ];
    // rust: let max = [
    // rust: f64::from(max_rel.x) + self.camera[0],
    // rust: f64::from(max_rel.y) + self.camera[1],
    // rust: f64::from(max_rel.z) + self.camera[2],
    // rust: ];
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.entity_queries = stats.entity_queries.saturating_add(1);
    // rust: stats.entity_vertices_scanned = stats.entity_vertices_scanned.saturating_add(2);
    // rust: drop(stats);
    // rust: self.query_bounds(min, max)
}

pub fn query_bounds(self: *Self, min: [f64; 3], max: [f64; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if (0..3)
    // rust: .any(|axis| !min[axis].is_finite() || !max[axis].is_finite() || min[axis] > max[axis])
    // rust: {
    // rust: return None;
}
    // rust: let min = min.map(|value| (value * QUERY_BOUNDS_SCALE).floor() / QUERY_BOUNDS_SCALE);
    // rust: let max = max.map(|value| (value * QUERY_BOUNDS_SCALE).ceil() / QUERY_BOUNDS_SCALE);
    // rust: if (0..3).any(|axis| !min[axis].is_finite() || !max[axis].is_finite()) {
    // rust: return None;
}
    // rust: Some(CullKey {
    // rust: camera: self.camera.map(f64::to_bits),
    // rust: min: min.map(f64::to_bits),
    // rust: max: max.map(f64::to_bits),
    // rust: })
}

    // rust: pub(super) fn query_result(
    // rust: &self,
    // rust: key: &CullKey,
    // rust: source: QuerySource,
    // rust: ) -> Option<(bool, Option<&OcclusionProof>)> {
    // rust: let sample_lookup = {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.result_lookup_calls = stats.result_lookup_calls.saturating_add(1);
    // rust: self.measure_bounds_timing.get() && stats.result_lookup_calls.is_multiple_of(16)
}
    // rust: let timing_start = sample_lookup.then(|| self.timing_start()).flatten();
    // rust: let entry = self
    // rust: .query_results
    // rust: .binary_search_by_key(&query_bounds_key(key), |entry| query_bounds_key(&entry.key))
    // rust: .ok()
    // rust: .map(|index| &self.query_results[index]);
    // rust: let result = entry.and_then(|entry| {
            // A hidden proof is only valid for the viewpoint that produced it.
            // Bounds quantization does not compensate for camera parallax at an
            // occluder, even when both camera positions share a sub-cell.
    // rust: let camera_matches = entry.key.camera == key.camera;
    // rust: let exact = camera_matches
    // rust: && query_bounds_key(&entry.key) == query_bounds_key(key)
    // rust: && entry.stamp.same_layout(self.stamp)
    // rust: && (entry.proof.is_some()
    // rust: || entry.stamp.world_revision == self.stamp.world_revision);
    // rust: let reusable_visible = entry.proof.is_none()
    // rust: && entry.stamp == self.stamp
    // rust: && self
    // rust: .query_cache_camera_cell
    // rust: .is_some_and(|cell| entry.camera_cell == Some(cell));
    // rust: (exact || reusable_visible).then(|| {
    // rust: entry.last_used_frame.set(self.frame);
    // rust: (entry.proof.is_some(), entry.proof.as_ref())
    // rust: })
    // rust: });
    // rust: let miss_reason = result.is_none().then(|| {
    // rust: cache_miss_reason(
    // rust: entry,
    // rust: key,
    // rust: self.stamp,
    // rust: self.query_cache_camera_cell,
    // rust: self.query_results.is_empty(),
    // rust: )
    // rust: });
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: match result.is_some() {
    // rust: true => stats.entity_cache_hits = stats.entity_cache_hits.saturating_add(1),
    // rust: false => stats.entity_cache_misses = stats.entity_cache_misses.saturating_add(1),
}
    // rust: match (source, result.is_some()) {
    // rust: (QuerySource::EntityAabb, true) => {
    // rust: stats.entity_aabb_cache_hits = stats.entity_aabb_cache_hits.saturating_add(1);
}
    // rust: (QuerySource::EntityAabb, false) => {
    // rust: stats.entity_aabb_cache_misses = stats.entity_aabb_cache_misses.saturating_add(1);
}
    // rust: (QuerySource::EntityMesh, true) => {
    // rust: stats.entity_mesh_cache_hits = stats.entity_mesh_cache_hits.saturating_add(1);
}
    // rust: (QuerySource::EntityMesh, false) => {
    // rust: stats.entity_mesh_cache_misses = stats.entity_mesh_cache_misses.saturating_add(1);
}
}
    // rust: match miss_reason {
    // rust: Some(CacheMissReason::EmptySet) => {
    // rust: stats.cache_miss_empty_set = stats.cache_miss_empty_set.saturating_add(1);
}
    // rust: Some(CacheMissReason::KeyMismatch) => {
    // rust: stats.cache_miss_key_mismatch = stats.cache_miss_key_mismatch.saturating_add(1);
}
    // rust: Some(CacheMissReason::CameraMismatch) => {
    // rust: stats.cache_miss_camera_mismatch =
    // rust: stats.cache_miss_camera_mismatch.saturating_add(1);
}
    // rust: Some(CacheMissReason::Invalidated) => {
    // rust: stats.cache_miss_invalidated = stats.cache_miss_invalidated.saturating_add(1);
}
    // rust: None => {}
}
    // rust: drop(stats);
    // rust: if sample_lookup {
    // rust: self.record_timing(TimingPhase::ResultLookup, timing_start);
}
    // rust: result
}

    // rust: pub(super) fn sample_entity_aabb(&self, entity_id: u32, key: &CullKey) {
    // rust: if !self.measure_bounds_timing.get() {
    // rust: return;
}
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: if stats.entity_bounds_samples.len() >= 10 {
    // rust: return;
}
    // rust: let sampled_id = *stats.sampled_entity_id.get_or_insert(entity_id);
    // rust: if sampled_id != entity_id || stats.sampled_entity_last_frame == stats.frames {
    // rust: return;
}
    // rust: let frame = stats.frames;
    // rust: stats.sampled_entity_last_frame = frame;
    // rust: stats.entity_bounds_samples.push(EntityBoundsSample {
    // rust: frame,
    // rust: entity_id,
    // rust: camera: key.camera,
    // rust: min: key.min,
    // rust: max: key.max,
    // rust: });
}

    // rust: pub(super) fn proof_is_current(
    // rust: &self,
    // rust: world: &World,
    // rust: renderer: Option<&Renderer>,
    // rust: streaming: &Streaming,
    // rust: pending_uploads: &[((i32, i32, i32), SectionMesh)],
    // rust: proof: &OcclusionProof,
    // rust: ) -> bool {
    // rust: let started = if self.measure_bounds_timing.get() {
    // rust: let sample = self.proof_validation_sample_counter.get().wrapping_add(1);
    // rust: self.proof_validation_sample_counter.set(sample);
    // rust: sample
    // rust: .is_multiple_of(PROOF_VALIDATION_TIMING_SAMPLE_STRIDE)
    // rust: .then(|| self.timing_start())
    // rust: .flatten()
    // rust: } else {
    // rust: None
}
    // rust: let (current, counts) = proof_is_current(
    // rust: self.stamp,
    // rust: world,
    // rust: renderer,
    // rust: streaming,
    // rust: pending_uploads,
    // rust: proof,
    // rust: &mut self.proof_validation_cache.borrow_mut(),
    // rust: );
    // rust: if self.measure_bounds_timing.get() {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.proof_validation_counts.chunk_checks = stats
    // rust: .proof_validation_counts
    // rust: .chunk_checks
    // rust: .saturating_add(counts.chunk_checks);
    // rust: stats.proof_validation_counts.chunk_cache_hits = stats
    // rust: .proof_validation_counts
    // rust: .chunk_cache_hits
    // rust: .saturating_add(counts.chunk_cache_hits);
    // rust: stats.proof_validation_counts.section_checks = stats
    // rust: .proof_validation_counts
    // rust: .section_checks
    // rust: .saturating_add(counts.section_checks);
    // rust: stats.proof_validation_counts.section_cache_hits = stats
    // rust: .proof_validation_counts
    // rust: .section_cache_hits
    // rust: .saturating_add(counts.section_cache_hits);
    // rust: stats.proof_validation_counts.epoch_hits = stats
    // rust: .proof_validation_counts
    // rust: .epoch_hits
    // rust: .saturating_add(counts.epoch_hits);
    // rust: if let Some(started) = started {
    // rust: let wall_ns = started.wall.elapsed().as_nanos().min(u128::from(u64::MAX)) as u64;
    // rust: let thread_cpu_ns =
    // rust: spans::thread_cpu()
    // rust: .zip(started.thread_cpu)
    // rust: .map(|(end, start)| {
    // rust: end.saturating_sub(start)
    // rust: .as_nanos()
    // rust: .min(u128::from(u64::MAX)) as u64
    // rust: });
    // rust: stats.proof_validation_timing.record(
    // rust: wall_ns,
    // rust: thread_cpu_ns,
    // rust: PROOF_VALIDATION_TIMING_SAMPLE_STRIDE,
    // rust: );
}
}
    // rust: current
}

pub fn cache_query_results(self: *Self, results: *mut CullResults) void {
}
    // rust: let camera_cell = camera_cell(results.camera.map(f64::from_bits));
    // rust: self.cache_results(results, true, camera_cell);
}

pub fn cache_results_for_camera(self: *Self, results: *mut CullResults, camera: [u64; 3]) void {
}
    // rust: if results.camera == camera {
    // rust: self.cache_query_results(results);
    // rust: } else {
            // Even visible answers suppress a fresh query while their cache
            // entry is live. Drop stale batches instead of sorting and merging
            // results that cannot help this viewpoint.
    // rust: results.visible.clear();
    // rust: results.hidden.clear();
}
}

    // rust: fn cache_results(
    // rust: &mut self,
    // rust: results: &mut CullResults,
    // rust: cache_hidden: bool,
    // rust: result_camera_cell: Option<[i32; 3]>,
    // rust: ) {
    // rust: self.cache_updates.clear();

        // Visible results are fail-open but can hide later culling opportunities
        // after a block edit, so retain them only for the world revision tested.
    // rust: if results.stamp.world_revision == self.stamp.world_revision {
    // rust: self.cache_updates
    // rust: .extend(results.visible.drain(..).map(|key| CachedQueryResult {
    // rust: key,
    // rust: stamp: results.stamp,
    // rust: camera_cell: result_camera_cell,
    // rust: proof: None,
    // rust: last_used_frame: Cell::new(self.frame),
    // rust: }));
    // rust: } else {
    // rust: results.visible.clear();
}

    // rust: if cache_hidden {
    // rust: for (key, proof) in results.hidden.drain(..) {
    // rust: let has_newer_hidden_proof = results.stamp.world_revision
    // rust: != self.stamp.world_revision
    // rust: && self
    // rust: .query_results
    // rust: .binary_search_by_key(&query_bounds_key(&key), |entry| {
    // rust: query_bounds_key(&entry.key)
    // rust: })
    // rust: .ok()
    // rust: .is_some_and(|index| {
    // rust: let entry = &self.query_results[index];
    // rust: entry.camera_cell == result_camera_cell
    // rust: && entry.proof.is_some()
    // rust: && entry.stamp.same_layout(self.stamp)
    // rust: && entry.stamp.world_revision == self.stamp.world_revision
    // rust: });
    // rust: if has_newer_hidden_proof {
    // rust: continue;
}
    // rust: self.cache_updates.push(CachedQueryResult {
    // rust: key,
    // rust: stamp: results.stamp,
    // rust: camera_cell: result_camera_cell,
    // rust: proof: Some(proof),
    // rust: last_used_frame: Cell::new(self.frame),
    // rust: });
}
    // rust: } else {
    // rust: results.hidden.clear();
}

    // rust: if self.cache_updates.is_empty() {
    // rust: return;
}
    // rust: self.cache_updates
    // rust: .sort_unstable_by_key(|entry| query_bounds_key(&entry.key));

    // rust: let existing_len = self.query_results.len();
    // rust: let updates_len = self.cache_updates.len();
    // rust: let mut existing = std::mem::take(&mut self.query_results);
    // rust: let mut updates = std::mem::take(&mut self.cache_updates);
    // rust: let mut merged = std::mem::take(&mut self.cache_merge);
    // rust: merged.clear();
    // rust: merged.reserve(
    // rust: existing_len
    // rust: .saturating_add(updates_len)
    // rust: .min(MAX_OCCLUSION_RESULT_CACHE_ENTRIES),
    // rust: );

    // rust: let mut existing_iter = existing.drain(..).peekable();
    // rust: let mut updates_iter = updates.drain(..).peekable();
    // rust: let mut invalidation_replacements = 0_u64;
    // rust: let mut capacity_evictions = 0_u64;
    // rust: let mut idle_evictions = 0_u64;
    // rust: while existing_iter.peek().is_some() || updates_iter.peek().is_some() {
    // rust: let entry = match (existing_iter.peek(), updates_iter.peek()) {
    // rust: (Some(old), Some(new)) => {
    // rust: match query_bounds_key(&old.key).cmp(&query_bounds_key(&new.key)) {
    // rust: std::cmp::Ordering::Less => existing_iter.next().unwrap(),
    // rust: std::cmp::Ordering::Greater => updates_iter.next().unwrap(),
    // rust: std::cmp::Ordering::Equal => {
    // rust: let old = existing_iter.next().unwrap();
    // rust: let new = updates_iter.next().unwrap();
    // rust: let invalidated = !old.stamp.same_layout(self.stamp)
    // rust: || (old.proof.is_none()
    // rust: && (old.stamp.world_revision != self.stamp.world_revision
    // rust: || old.camera_cell != self.query_cache_camera_cell));
    // rust: invalidation_replacements =
    // rust: invalidation_replacements.saturating_add(u64::from(invalidated));
    // rust: new
}
}
}
    // rust: (Some(_), None) => existing_iter.next().unwrap(),
    // rust: (None, Some(_)) => updates_iter.next().unwrap(),
    // rust: (None, None) => unreachable!(),
}
            // Animated mesh extrema often never repeat. Drop their unused
            // answers during this existing merge, while frequently queried
            // AABBs and mesh bounds retain their entries without extra scans.
    // rust: if self.frame.saturating_sub(entry.last_used_frame.get()) > RESULT_CACHE_IDLE_FRAMES {
    // rust: idle_evictions = idle_evictions.saturating_add(1);
    // rust: } else if merged.len() < MAX_OCCLUSION_RESULT_CACHE_ENTRIES {
    // rust: merged.push(entry);
    // rust: } else {
    // rust: capacity_evictions = capacity_evictions.saturating_add(1);
}
}
    // rust: drop(existing_iter);
    // rust: drop(updates_iter);

    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.result_cache_evictions = stats
    // rust: .result_cache_evictions
    // rust: .saturating_add(capacity_evictions)
    // rust: .saturating_add(idle_evictions);
    // rust: stats.result_cache_idle_evictions = stats
    // rust: .result_cache_idle_evictions
    // rust: .saturating_add(idle_evictions);
    // rust: stats.result_cache_capacity_evictions = stats
    // rust: .result_cache_capacity_evictions
    // rust: .saturating_add(capacity_evictions);
    // rust: stats.result_cache_invalidation_replacements = stats
    // rust: .result_cache_invalidation_replacements
    // rust: .saturating_add(invalidation_replacements);
    // rust: drop(stats);

    // rust: self.query_results = merged;
    // rust: self.cache_updates = updates;
    // rust: self.cache_merge = existing;
}

    // rust: pub(super) fn queue(&self, key: CullKey) {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.queued_queries = stats.queued_queries.saturating_add(1);
    // rust: drop(stats);
    // rust: self.queries.borrow_mut().push(key);
}

    // rust: pub(super) fn finish_frame(&mut self, world: &World, facts: &BlockFacts) {
    // rust: let started = self.timing_start();
    // rust: self.finish_frame_inner(world, facts);
    // rust: self.record_timing(TimingPhase::FrameSubmit, started);
}

pub fn finish_frame_inner(self: *Self, world: *World, facts: *BlockFacts) void {
}
    // rust: let queries = self.queries.get_mut();
    // rust: if self.pending {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.queries_dropped_while_pending = stats
    // rust: .queries_dropped_while_pending
    // rust: .saturating_add(queries.len() as u64);
    // rust: drop(stats);
    // rust: queries.clear();
    // rust: return;
}
    // rust: if queries.is_empty() {
    // rust: return;
}
        // Sort by priority (with full key tie-breaker) in-place and coalesce duplicates
        // in one pass before spending the worker's bounded lookup budget.
    // rust: queries.sort_unstable_by(|a, b| {
    // rust: query_priority(b)
    // rust: .total_cmp(&query_priority(a))
    // rust: .then_with(|| a.cmp(b))
    // rust: });
    // rust: queries.dedup();
    // rust: let Some(bounds) = snapshot_bounds(self.camera, queries) else {
    // rust: queries.clear();
    // rust: return;
}
    // rust: let opaque_states = Arc::clone(
    // rust: self.opaque_states
    // rust: .get_or_insert_with(|| facts.states.iter().map(opaque).collect::<Vec<_>>().into()),
    // rust: );
    // rust: let snapshot = match &mut self.snapshot {
    // rust: Some((stamp, cached_bounds, snapshot)) => {
    // rust: if !stamp.same_layout(self.stamp)
    // rust: || *cached_bounds != bounds
    // rust: || !snapshot.chunks_match(world)
    // rust: {
    // rust: self.snapshot_epoch = self.snapshot_epoch.wrapping_add(1);
    // rust: let snapshot = Arc::make_mut(snapshot);
    // rust: snapshot.opaque_states = Arc::clone(&opaque_states);
    // rust: snapshot.refresh_chunks(world, bounds);
    // rust: *stamp = self.stamp;
    // rust: *cached_bounds = bounds;
}
    // rust: Arc::clone(snapshot)
}
    // rust: None => {
    // rust: self.snapshot_epoch = self.snapshot_epoch.wrapping_add(1);
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
    // rust: snapshot_epoch: self.snapshot_epoch,
    // rust: generation: self.job_generation.load(Ordering::Relaxed),
    // rust: snapshot,
    // rust: queries,
    // rust: clear_visible: std::mem::take(&mut self.recycled_visible),
    // rust: hidden: std::mem::take(&mut self.recycled_hidden),
    // rust: rays_filtered: false,
}
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.worker_jobs = stats.worker_jobs.saturating_add(1);
    // rust: drop(stats);
    // rust: let query_count = job.queries.len();
    // rust: let send_started = self.timing_start();
    // rust: match self.jobs.try_send(job) {
    // rust: Ok(()) => {
    // rust: self.pending = true;
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.worker_job_queries =
    // rust: stats.worker_job_queries.saturating_add(query_count as u64);
    // rust: stats
    // rust: .worker_job_query_count_samples
    // rust: .record(query_count as u64);
}
    // rust: Err(TrySendError::Full(job)) => {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.worker_jobs = stats.worker_jobs.saturating_sub(1);
    // rust: stats.job_send_full = stats.job_send_full.saturating_add(1);
    // rust: drop(stats);
    // rust: *self.queries.get_mut() = job.queries;
    // rust: self.recycled_visible = job.clear_visible;
    // rust: self.recycled_hidden = job.hidden;
}
    // rust: Err(TrySendError::Disconnected(job)) => {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.worker_jobs = stats.worker_jobs.saturating_sub(1);
    // rust: stats.job_send_disconnected = stats.job_send_disconnected.saturating_add(1);
    // rust: drop(stats);
    // rust: *self.queries.get_mut() = job.queries;
    // rust: self.recycled_visible = job.clear_visible;
    // rust: self.recycled_hidden = job.hidden;
}
}
    // rust: self.record_timing(TimingPhase::JobSend, send_started);
}

    // rust: pub(super) fn record_entity_vertices_culled(&self, vertices: usize) {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.entities_culled = stats.entities_culled.saturating_add(1);
    // rust: stats.entity_vertices_culled = stats.entity_vertices_culled.saturating_add(vertices as u64);
    // rust: stats.entity_bytes_culled = stats
    // rust: .entity_bytes_culled
    // rust: .saturating_add((vertices.saturating_mul(std::mem::size_of::<Vertex>())) as u64);
}

    // rust: pub(super) fn record_entity_culled(&self) {
    // rust: let mut stats = self.stats.borrow_mut();
    // rust: stats.entities_culled = stats.entities_culled.saturating_add(1);
}

    // rust: pub(super) fn stats_value(&self) -> serde_json::Value {
    // rust: let stats = self.stats.borrow();
    // rust: let (worker_p50_ns, worker_p95_ns) = stats.worker_job_samples.percentiles_ns();
    // rust: let (bounds_p50_ns, bounds_p95_ns) = stats.bounds_scan_samples.percentiles_ns();
    // rust: let (job_queries_p50, job_queries_p95) =
    // rust: stats.worker_job_query_count_samples.percentiles_ns();
    // rust: let bounds_samples = stats
    // rust: .entity_bounds_samples
    // rust: .iter()
    // rust: .map(|sample| {
    // rust: let hex = |values: [u64; 3]| values.map(|value| format!("0x{value:016x}"));
    // rust: serde_json::json!({
    // rust: "frame": sample.frame,
    // rust: "entity_id": sample.entity_id,
    // rust: "camera_bits": hex(sample.camera),
    // rust: "min_bits": hex(sample.min),
    // rust: "max_bits": hex(sample.max),
    // rust: })
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: let completed_per_frame = if stats.frames == 0 {
    // rust: 0.0
    // rust: } else {
    // rust: stats.worker_jobs_completed as f64 / stats.frames as f64
}
    // rust: let queued_per_frame = if stats.frames == 0 {
    // rust: 0.0
    // rust: } else {
    // rust: stats.worker_jobs as f64 / stats.frames as f64
}
    // rust: let mut value = serde_json::json!({
    // rust: "frames": stats.frames,
    // rust: "entity_queries": stats.entity_queries,
    // rust: "entity_cache_hits": stats.entity_cache_hits,
    // rust: "entity_cache_misses": stats.entity_cache_misses,
    // rust: "result_cache_evictions": stats.result_cache_evictions,
    // rust: "entity_vertices_scanned": stats.entity_vertices_scanned,
    // rust: "entities_culled": stats.entities_culled,
    // rust: "entity_vertices_culled": stats.entity_vertices_culled,
    // rust: "entity_bytes_avoided": stats.entity_bytes_culled,
    // rust: "queued_queries": stats.queued_queries,
    // rust: "queries_dropped_while_pending": stats.queries_dropped_while_pending,
    // rust: "worker_jobs": stats.worker_jobs,
    // rust: "worker_jobs_completed": stats.worker_jobs_completed,
    // rust: "stale_camera_jobs": stats.stale_camera_jobs,
    // rust: "stale_world_jobs": stats.stale_world_jobs,
    // rust: "worker_cancelled_jobs": stats.worker_cancelled_jobs,
    // rust: "worker_ms": stats.worker_ns as f64 / 1_000_000.0,
    // rust: "worker_job_ns_p50_recent": worker_p50_ns,
    // rust: "worker_job_ns_p95_recent": worker_p95_ns,
    // rust: "worker_job_timing_samples": stats.worker_job_samples.len,
    // rust: "worker_jobs_completed_per_frame": completed_per_frame,
    // rust: "worker_jobs_queued_per_frame": queued_per_frame,
    // rust: "bounds_scan_ms": stats.bounds_scan_ns as f64 / 1_000_000.0,
    // rust: "bounds_scan_ns_p50_recent": bounds_p50_ns,
    // rust: "bounds_scan_ns_p95_recent": bounds_p95_ns,
    // rust: "bounds_scan_timing_samples": stats.bounds_scan_samples.len,
    // rust: "worker_hidden_entities": stats.worker_hidden_entities,
    // rust: "worker_visible_entities": stats.worker_visible_entities,
    // rust: "worker_deferred_entities": stats.worker_deferred_entities,
    // rust: "entity_budget_exhausted_jobs": stats.entity_budget_exhausted_jobs,
    // rust: "result_cache_slots": MAX_OCCLUSION_RESULT_CACHE_ENTRIES,
    // rust: "result_cache_entries": self.query_results.len(),
    // rust: "profiling_enabled": self.measure_bounds_timing.get(),
    // rust: "state_bytes": std::mem::size_of::<Self>(),
    // rust: });
    // rust: value["entity_aabb_cache_hits"] = serde_json::json!(stats.entity_aabb_cache_hits);
    // rust: value["entity_aabb_cache_misses"] = serde_json::json!(stats.entity_aabb_cache_misses);
    // rust: value["entity_mesh_cache_hits"] = serde_json::json!(stats.entity_mesh_cache_hits);
    // rust: value["entity_mesh_cache_misses"] = serde_json::json!(stats.entity_mesh_cache_misses);
    // rust: value["result_cache_capacity_evictions"] =
    // rust: serde_json::json!(stats.result_cache_capacity_evictions);
    // rust: value["result_cache_idle_evictions"] = serde_json::json!(stats.result_cache_idle_evictions);
    // rust: value["result_cache_invalidation_replacements"] =
    // rust: serde_json::json!(stats.result_cache_invalidation_replacements);
    // rust: value["cache_miss_empty_set"] = serde_json::json!(stats.cache_miss_empty_set);
    // rust: value["cache_miss_key_mismatch"] = serde_json::json!(stats.cache_miss_key_mismatch);
    // rust: value["cache_miss_camera_mismatch"] = serde_json::json!(stats.cache_miss_camera_mismatch);
    // rust: value["cache_miss_invalidated"] = serde_json::json!(stats.cache_miss_invalidated);
    // rust: value["worker_job_queries"] = serde_json::json!(stats.worker_job_queries);
    // rust: value["worker_job_query_count_p50_recent"] = serde_json::json!(job_queries_p50);
    // rust: value["worker_job_query_count_p95_recent"] = serde_json::json!(job_queries_p95);
    // rust: value["worker_job_query_count_samples"] =
    // rust: serde_json::json!(stats.worker_job_query_count_samples.len);
    // rust: value["job_send_full"] = serde_json::json!(stats.job_send_full);
    // rust: value["job_send_disconnected"] = serde_json::json!(stats.job_send_disconnected);
    // rust: value["world_revision_changes"] = serde_json::json!(stats.world_revision_changes);
    // rust: value["chunks_revision_changes"] = serde_json::json!(stats.chunks_revision_changes);
    // rust: value["worker_blocking_wait_ms"] = serde_json::json!(0.0);
    // rust: value["worker_wait_path"] = serde_json::json!("render thread uses try_recv/try_send");
    // rust: value["phase_timings"] = serde_json::json!({
    // rust: "result_consume": Self::timing_value(&stats.result_consume_timing),
    // rust: "frame_submit": Self::timing_value(&stats.frame_submit_timing),
    // rust: "job_send": Self::timing_value(&stats.job_send_timing),
    // rust: "result_lookup_sampled_1_in_16": Self::timing_value(&stats.result_lookup_timing),
    // rust: "proof_validation": Self::timing_value(&stats.proof_validation_timing),
    // rust: });
    // rust: value["proof_validation"] = serde_json::json!({
    // rust: "unique_chunk_checks": stats.proof_validation_counts.chunk_checks,
    // rust: "cached_chunk_checks": stats.proof_validation_counts.chunk_cache_hits,
    // rust: "unique_section_checks": stats.proof_validation_counts.section_checks,
    // rust: "cached_section_checks": stats.proof_validation_counts.section_cache_hits,
    // rust: "epoch_hits": stats.proof_validation_counts.epoch_hits,
    // rust: });
    // rust: value["sampled_entity_bounds"] = serde_json::json!(bounds_samples);
    // rust: value
}

    // rust: pub(super) fn reset_stats(&self) {
    // rust: *self.stats.borrow_mut() = AsyncCullingStats::default();
    // rust: self.proof_validation_sample_counter.set(0);
}
}

    // rust: fn cache_miss_reason(
    // rust: entry: Option<&CachedQueryResult>,
    // rust: key: &CullKey,
    // rust: stamp: SnapshotKey,
    // rust: camera_cell: Option<[i32; 3]>,
    // rust: cache_empty: bool,
    // rust: ) -> CacheMissReason {
    // rust: let Some(entry) = entry else {
    // rust: return if cache_empty {
    // rust: CacheMissReason::EmptySet
    // rust: } else {
    // rust: CacheMissReason::KeyMismatch
}
}
    // rust: if !entry.stamp.same_layout(stamp)
    // rust: || (entry.proof.is_none() && entry.stamp.world_revision != stamp.world_revision)
    // rust: {
    // rust: return CacheMissReason::Invalidated;
}
    // rust: if entry.key.camera != key.camera
    // rust: && (entry.proof.is_some()
    // rust: || entry.stamp != stamp
    // rust: || !camera_cell.is_some_and(|cell| entry.camera_cell == Some(cell)))
    // rust: {
    // rust: return CacheMissReason::CameraMismatch;
}
    // rust: CacheMissReason::KeyMismatch
}

pub fn query_priority(key: *CullKey) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let camera = key.camera.map(f64::from_bits);
    // rust: let min = key.min.map(f64::from_bits);
    // rust: let max = key.max.map(f64::from_bits);
    // rust: let mut extent = 0.0_f64;
    // rust: let mut distance_squared = 0.0_f64;
    // rust: for axis in 0..3 {
    // rust: let center = min[axis] + (max[axis] - min[axis]) * 0.5;
    // rust: extent = extent.max(max[axis] - min[axis]);
    // rust: distance_squared += (center - camera[axis]).powi(2);
}
    // rust: if extent.is_finite() && distance_squared.is_finite() {
    // rust: extent * extent / distance_squared.max(0.01)
    // rust: } else {
    // rust: 0.0
}
}

pub fn camera_cell(camera: [f64; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [Some(x), Some(y), Some(z)] = camera.map(|value| {
    // rust: let cell = (value * CAMERA_SUBCELL_SCALE).floor();
    // rust: (cell.is_finite() && cell >= f64::from(i32::MIN) && cell <= f64::from(i32::MAX))
    // rust: .then_some(cell as i32)
    // rust: }) else {
    // rust: return None;
}
    // rust: Some([x, y, z])
}

pub fn filter_rays(job: *mut CullJob, generation: *AtomicU64, scratch: *mut RayWorkerScratch) void {
}
    // rust: let Some(first) = job.queries.first() else {
    // rust: job.rays_filtered = true;
    // rust: return;
}
    // rust: let camera = first.camera.map(f64::from_bits);
    // rust: scratch.prepare(job.snapshot_epoch);
    // rust: std::mem::swap(&mut job.queries, &mut scratch.input);
    // rust: job.clear_visible.clear();
    // rust: let mut input = std::mem::take(&mut scratch.input);
    // rust: for key in input.drain(..) {
    // rust: if generation.load(Ordering::Relaxed) != job.generation {
    // rust: break;
}
    // rust: let min = key.min.map(f64::from_bits);
    // rust: let max = key.max.map(f64::from_bits);
    // rust: if bounds_have_clear_ray(
    // rust: camera,
    // rust: min,
    // rust: max,
    // rust: &job.snapshot,
    // rust: &mut scratch.last_chunk,
    // rust: &mut scratch.opacity_grid,
    // rust: ) {
    // rust: scratch.clear_visible.push(key);
    // rust: } else {
    // rust: scratch.blocked.push(key);
}
}
    // rust: scratch.input = input;
    // rust: std::mem::swap(&mut job.queries, &mut scratch.blocked);
    // rust: std::mem::swap(&mut job.clear_visible, &mut scratch.clear_visible);
    // rust: scratch.last_chunk.clear();
    // rust: job.rays_filtered = true;
}

    // rust: fn cull_job(
    // rust: mut job: CullJob,
    // rust: generation: &AtomicU64,
    // rust: scratch: &mut PlaneWorkerScratch,
    // rust: ) -> CullResults {
    // rust: let started = Instant::now();
    // rust: let camera = job
    // rust: .queries
    // rust: .first()
    // rust: .or_else(|| job.clear_visible.first())
    // rust: .map(|key| key.camera.map(f64::from_bits))
    // rust: .unwrap_or([0.0; 3]);
    // rust: let mut remaining = OCCLUSION_LOOKUP_BUDGET;
    // rust: scratch.prepare(job.snapshot_epoch);
    // rust: let mut hidden = job.hidden;
    // rust: hidden.clear();
    // rust: if hidden.capacity() < job.queries.len() {
    // rust: hidden.reserve(job.queries.len() - hidden.capacity());
}
    // rust: let mut visible = job.clear_visible;
    // rust: visible.clear();
    // rust: let mut deferred_entities = 0;
    // rust: let mut cancelled = false;
    // rust: for &key in &job.queries {
    // rust: if generation.load(Ordering::Relaxed) != job.generation {
    // rust: cancelled = true;
    // rust: break;
}
    // rust: scratch.covered.clear();
    // rust: let min = key.min.map(f64::from_bits);
    // rust: let max = key.max.map(f64::from_bits);
    // rust: if !job.rays_filtered
    // rust: && bounds_have_clear_ray(
    // rust: camera,
    // rust: min,
    // rust: max,
    // rust: &job.snapshot,
    // rust: &mut scratch.last_chunk,
    // rust: &mut scratch.opacity_grid,
    // rust: )
    // rust: {
    // rust: visible.push(key);
    // rust: continue;
}
    // rust: if remaining == 0 {
    // rust: deferred_entities += 1;
    // rust: continue;
}
    // rust: let remaining_before = remaining;
    // rust: let is_hidden =
    // rust: OcclusionCuller::occluded_with_budget(camera, &mut remaining, min, max, |pos| {
    // rust: let opaque =
    // rust: scratch
    // rust: .opacity_grid
    // rust: .opaque(&job.snapshot, pos, &mut scratch.last_chunk);
    // rust: if opaque {
    // rust: scratch.covered.push(pos);
}
    // rust: opaque
    // rust: });
    // rust: if !is_hidden && remaining_before != 0 && remaining == 0 {
    // rust: deferred_entities += 1;
    // rust: continue;
}
    // rust: if !is_hidden {
    // rust: visible.push(key);
    // rust: continue;
}
    // rust: scratch.sections.clear();
    // rust: let mut proof_chunks: Vec<(ChunkKey, Weak<Chunk>)> = Vec::new();
    // rust: let mut last_section: Option<SectionKey> = None;
    // rust: let mut last_chunk_key: Option<ChunkKey> = None;
    // rust: let mut valid = true;
    // rust: for &pos in &scratch.covered {
    // rust: let chunk_key = (pos[0] >> 4, pos[2] >> 4);
    // rust: let Some(y) = pos[1].checked_sub(job.stamp.bottom_y) else {
    // rust: valid = false;
    // rust: break;
}
    // rust: let section = (chunk_key.0, y >> 4, chunk_key.1);
    // rust: if last_section == Some(section) {
    // rust: continue;
}
    // rust: last_section = Some(section);
    // rust: scratch.sections.push(section);
    // rust: if last_chunk_key == Some(chunk_key) {
    // rust: continue;
}
    // rust: last_chunk_key = Some(chunk_key);
    // rust: if let Err(index) = proof_chunks.binary_search_by_key(&chunk_key, |(key, _)| *key) {
    // rust: let Some(chunk) = job.snapshot.chunk(chunk_key) else {
    // rust: valid = false;
    // rust: break;
}
    // rust: if chunk.strong_count() == 0 {
    // rust: valid = false;
    // rust: break;
}
    // rust: proof_chunks.insert(index, (chunk_key, chunk.clone()));
}
}
    // rust: if valid {
    // rust: scratch.sections.sort_unstable();
    // rust: scratch.sections.dedup();
    // rust: hidden.push((
    // rust: key,
    // rust: OcclusionProof {
    // rust: sections: scratch.sections.clone(),
    // rust: chunks: proof_chunks,
    // rust: validated_epoch: Cell::new(0),
    // rust: },
    // rust: ));
    // rust: } else {
    // rust: visible.push(key);
}
}
    // rust: hidden.sort_unstable_by_key(|(key, _)| *key);
    // rust: visible.sort_unstable();
    // rust: scratch.last_chunk.clear();
    // rust: let hidden_entities = hidden.len();
    // rust: let visible_entities = visible.len();
    // rust: job.queries.clear();
    // rust: CullResults {
    // rust: stamp: job.stamp,
    // rust: camera: camera.map(f64::to_bits),
    // rust: generation: job.generation,
    // rust: cancelled,
    // rust: hidden,
    // rust: visible,
    // rust: scratch_queries: job.queries,
    // rust: worker_ns: started.elapsed().as_nanos().min(u128::from(u64::MAX)) as u64,
    // rust: hidden_entities,
    // rust: visible_entities,
    // rust: deferred_entities,
}
}

    // rust: pub(super) fn opaque(facts: &StateFacts) -> bool {
    // rust: facts.render_shape == RenderShape::Model
    // rust: && facts.can_occlude
    // rust: && facts.solid_render
    // rust: && facts.full_collision
}

pub fn snapshot_bounds(camera: [f64; 3], queries: *[CullKey]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut min_x = camera[0];
    // rust: let mut max_x = camera[0];
    // rust: let mut min_z = camera[2];
    // rust: let mut max_z = camera[2];
    // rust: for query in queries {
    // rust: let min = query.min.map(f64::from_bits);
    // rust: let max = query.max.map(f64::from_bits);
    // rust: min_x = min_x.min(min[0]);
    // rust: max_x = max_x.max(max[0]);
    // rust: min_z = min_z.min(min[2]);
    // rust: max_z = max_z.max(max[2]);
}
    // Culler::occluded expands projected cells by EPSILON. One block of slack
    // also covers the camera's first cell when it lies exactly on a boundary.
    // rust: let min_x = snapshot_cell(min_x - 1.0)? >> 4;
    // rust: let max_x = snapshot_cell(max_x + 1.0)? >> 4;
    // rust: let min_z = snapshot_cell(min_z - 1.0)? >> 4;
    // rust: let max_z = snapshot_cell(max_z + 1.0)? >> 4;
    // rust: let width = i64::from(max_x) - i64::from(min_x) + 1;
    // rust: let depth = i64::from(max_z) - i64::from(min_z) + 1;
    // rust: if width <= 0 || depth <= 0 || width.checked_mul(depth)? > MAX_SNAPSHOT_CHUNKS {
    // rust: return None;
}
    // rust: Some(ChunkBounds {
    // rust: min_x,
    // rust: max_x,
    // rust: min_z,
    // rust: max_z,
    // rust: })
}

pub fn snapshot_cell(value: f64) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cell = value.floor();
    // rust: (cell.is_finite() && cell >= f64::from(i32::MIN) && cell <= f64::from(i32::MAX))
    // rust: .then_some(cell as i32)
}

    // rust: fn proof_is_current(
    // rust: stamp: SnapshotKey,
    // rust: world: &World,
    // rust: renderer: Option<&Renderer>,
    // rust: streaming: &Streaming,
    // rust: pending_uploads: &[((i32, i32, i32), SectionMesh)],
    // rust: proof: &OcclusionProof,
    // rust: cache: &mut FrameProofValidationCache,
    // rust: ) -> (bool, ProofValidationCounts) {
    // rust: let mut counts = ProofValidationCounts::default();
    // rust: cache.ensure_frame_verified(
    // rust: stamp,
    // rust: world,
    // rust: renderer,
    // rust: streaming,
    // rust: pending_uploads,
    // rust: &mut counts,
    // rust: );
    // rust: if proof.validated_epoch.get() == cache.valid_epoch {
    // rust: counts.chunk_cache_hits = counts
    // rust: .chunk_cache_hits
    // rust: .saturating_add(proof.chunks.len() as u64);
    // rust: counts.section_cache_hits = counts
    // rust: .section_cache_hits
    // rust: .saturating_add(proof.sections.len() as u64);
    // rust: counts.epoch_hits = 1;
    // rust: return (true, counts);
}
    // rust: for (key, expected) in &proof.chunks {
    // rust: if !cache.chunk_is_current(world, *key, expected, &mut counts) {
    // rust: proof.validated_epoch.set(0);
    // rust: return (false, counts);
}
}
    // rust: for &section in &proof.sections {
    // rust: if !cache.section_is_current(
    // rust: section,
    // rust: world,
    // rust: renderer,
    // rust: streaming,
    // rust: pending_uploads,
    // rust: &mut counts,
    // rust: ) {
    // rust: proof.validated_epoch.set(0);
    // rust: return (false, counts);
}
}
    // rust: proof.validated_epoch.set(cache.valid_epoch);
    // rust: (true, counts)
}

/// Cached readiness checks for the synchronous culler. Its projected planes
/// usually walk adjacent voxels in the same chunk and section, so retaining
/// the last lookup removes repeated map and streaming queries from the hot
/// loop without changing the fail-open result.
    // rust: pub(super) struct SyncOccluder<'a> {
    // rust: world: &'a World,
    // rust: facts: &'a BlockFacts,
    // rust: renderer: Option<&'a Renderer>,
    // rust: streaming: &'a Streaming,
    // rust: pending_uploads: &'a [((i32, i32, i32), SectionMesh)],
    // rust: bottom_y: i32,
    // rust: chunk_slots: [Option<(ChunkKey, Option<&'a Chunk>)>; 4],
    // rust: section_slots: [Option<(SectionKey, bool)>; 4],
}

    // rust: impl<'a> SyncOccluder<'a> {
    // rust: pub(super) fn new(
    // rust: world: &'a World,
    // rust: facts: &'a BlockFacts,
    // rust: renderer: Option<&'a Renderer>,
    // rust: streaming: &'a Streaming,
    // rust: pending_uploads: &'a [((i32, i32, i32), SectionMesh)],
    // rust: ) -> Self {
    // rust: Self {
    // rust: world,
    // rust: facts,
    // rust: renderer,
    // rust: streaming,
    // rust: pending_uploads,
    // rust: bottom_y: world.bottom_y(),
    // rust: chunk_slots: [None; 4],
    // rust: section_slots: [None; 4],
}
}

    // rust: pub(super) fn ready(&mut self, pos: [i32; 3]) -> bool {
    // rust: let chunk_key = (pos[0] >> 4, pos[2] >> 4);
    // rust: let chunk_index = (((chunk_key.0 as usize) & 1) << 1) | ((chunk_key.1 as usize) & 1);
    // rust: let chunk = match self.chunk_slots[chunk_index] {
    // rust: Some((key, cached)) if key == chunk_key => cached,
    // rust: _ => {
    // rust: let found = self.world.chunks.get(&chunk_key).map(Arc::as_ref);
    // rust: self.chunk_slots[chunk_index] = Some((chunk_key, found));
    // rust: found
}
}
    // rust: let Some(chunk) = chunk else {
    // rust: return false;
}
    // rust: let state = chunk.block(pos[0] & 15, pos[1], pos[2] & 15);
    // rust: if !opaque(self.facts.get(state)) {
    // rust: return false;
}
    // rust: let Some(y) = pos[1].checked_sub(self.bottom_y) else {
    // rust: return false;
}
    // rust: let section = (chunk_key.0, y >> 4, chunk_key.1);
    // rust: let section_index = (chunk_index ^ (section.1 as usize)) & 3;
    // rust: match self.section_slots[section_index] {
    // rust: Some((key, ready)) if key == section => ready,
    // rust: _ => {
    // rust: let ready = self.renderer.is_some_and(|r| r.has_section(section))
    // rust: && !self.world.dirty_sections.contains(&section)
    // rust: && !self.streaming.is_meshing(section)
    // rust: && !self.pending_uploads.iter().any(|(key, _)| *key == section);
    // rust: self.section_slots[section_index] = Some((section, ready));
    // rust: ready
}
}
}
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn prepare_occlusion_culling(&mut self, camera: glam::DVec3) {
    // rust: self.entity_section_camera = None;
    // rust: self.entity_section_visibility_valid = false;
    // rust: let entity_mode = self.settings.horizon.entity_culling;
    // rust: let requested = entity_mode != EntityCullingMode::Off;
    // rust: let eligible = requested
            // Packs can replace opaque models, so their terrain is not a safe occluder.
    // rust: && self.model_packs_are_vanilla()
    // rust: && self.player.is_some()
    // rust: && !self.spectator();
    // rust: if !eligible {
    // rust: self.sync_occlusion_culler = None;
    // rust: self.async_occlusion_culler = None;
    // rust: self.async_occlusion_culling_failed = false;
    // rust: return;
}
    // rust: let at = camera.to_array().map(|v| v.floor() as i32);
    // rust: self.entity_section_camera = at[1]
    // rust: .checked_sub(self.world.bottom_y())
    // rust: .map(|y| (at[0] >> 4, y >> 4, at[2] >> 4));
    // rust: let camera_facts = self.res.facts().get(self.world.block(at[0], at[1], at[2]));
    // rust: if opaque(camera_facts) {
    // rust: self.sync_occlusion_culler = None;
    // rust: self.async_occlusion_culler = None;
    // rust: self.async_occlusion_culling_failed = false;
    // rust: return;
}
    // rust: self.entity_section_visibility_valid = self.settings.horizon.cave_culling
    // rust: && !camera_facts.solid_render
    // rust: && self.entity_section_camera.is_some();

    // rust: let wants_async = entity_mode == EntityCullingMode::Asynchronous;
    // rust: let wants_sync = entity_mode == EntityCullingMode::Synchronous;
    // rust: if wants_async {
    // rust: if self.async_occlusion_culler.is_none() && !self.async_occlusion_culling_failed {
    // rust: match AsyncOcclusionCuller::new() {
    // rust: Ok(culler) => self.async_occlusion_culler = Some(Box::new(culler)),
    // rust: Err(error) => {
    // rust: log::warn!("Horizon: cannot start world-occlusion-culling worker: {error}");
    // rust: self.async_occlusion_culling_failed = true;
}
}
}
    // rust: if let Some(culler) = &mut self.async_occlusion_culler {
    // rust: culler.begin_frame(camera, &self.world);
}
    // rust: } else {
    // rust: self.async_occlusion_culler = None;
    // rust: self.async_occlusion_culling_failed = false;
}

    // rust: let async_unavailable = wants_async && self.async_occlusion_culler.is_none();
    // rust: self.sync_occlusion_culler = (wants_sync || async_unavailable)
    // rust: .then(|| OcclusionCuller::new(camera.to_array(), 8_192));
}

    // rust: pub(super) fn finish_async_occlusion_culling(&mut self) {
    // rust: if let Some(culler) = &mut self.async_occlusion_culler {
    // rust: culler.finish_frame(&self.world, self.res.facts());
}
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::chunk::ColumnLayout;

pub fn timing_samples_keep_a_bounded_recent_window_and_use_nearest_rank() void {
}
    // rust: let mut samples = TimingSamples::default();
    // rust: assert_eq!(samples.percentiles_ns(), (None, None));
    // rust: for value in 10..=270 {
    // rust: samples.record(value);
}
    // rust: assert_eq!(samples.len, TIMING_SAMPLE_CAPACITY);
    // rust: assert_eq!(samples.percentiles_ns(), (Some(142), Some(258)));
}

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

pub fn run_job(job: CullJob) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cull_job(job, &AtomicU64::new(0), &mut PlaneWorkerScratch::default())
}

pub fn job(snapshot: *OcclusionSnapshot) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let camera = [0.0; 3];
    // rust: let min = [7.95, -0.55, -0.55];
    // rust: let max = [10.05, 0.55, 0.55];
    // rust: CullJob {
    // rust: stamp: SnapshotKey {
    // rust: world_revision: 1,
    // rust: chunks_revision: 1,
    // rust: bottom_y: ColumnLayout::VANILLA.min_y(),
    // rust: },
    // rust: snapshot_epoch: 0,
    // rust: generation: 0,
    // rust: snapshot,
    // rust: queries: vec![CullKey {
    // rust: camera: camera.map(f64::to_bits),
    // rust: min: min.map(f64::to_bits),
    // rust: max: max.map(f64::to_bits),
    // rust: }],
    // rust: clear_visible: Vec::new(),
    // rust: hidden: Vec::new(),
    // rust: rays_filtered: false,
}
}

pub fn async_snapshot_is_bounded_and_handles_negative_chunk_edges() void {
}
    // rust: let camera = [-16.0, 0.0, -16.0];
    // rust: let key = CullKey {
    // rust: camera: camera.map(f64::to_bits),
    // rust: min: [-8.0, -1.0, -8.0].map(f64::to_bits),
    // rust: max: [8.0, 1.0, 8.0].map(f64::to_bits),
}
    // rust: assert_eq!(
    // rust: snapshot_bounds(camera, &[key]),
    // rust: Some(ChunkBounds {
    // rust: min_x: -2,
    // rust: max_x: 0,
    // rust: min_z: -2,
    // rust: max_z: 0,
    // rust: })
    // rust: );

    // rust: let huge = CullKey {
    // rust: camera: [0.0; 3].map(f64::to_bits),
    // rust: min: [5_000.0, 0.0, 5_000.0].map(f64::to_bits),
    // rust: max: [5_001.0, 1.0, 5_001.0].map(f64::to_bits),
}
    // rust: assert_eq!(snapshot_bounds([0.0; 3], &[huge]), None);
}

pub fn async_worker_only_hides_bounds_behind_a_complete_opaque_plane() void {
}
    // rust: let (snapshot, live) = wall(None);
    // rust: let results = run_job(job(snapshot));
    // rust: assert_eq!(results.hidden.len(), 1);
    // rust: assert!(results.visible.is_empty());
    // rust: assert_eq!(results.hidden[0].1.sections.len(), 4);
    // rust: assert_eq!(results.hidden[0].1.chunks.len(), 2);
    // rust: drop(live);

    // rust: let (snapshot, live) = wall(Some([4, 0, 0]));
    // rust: let results = run_job(job(snapshot));
    // rust: assert!(results.hidden.is_empty());
    // rust: assert_eq!(results.visible.len(), 1);
    // rust: drop(live);
}

pub fn entity_rays_only_short_circuit_when_a_sample_path_is_clear() void {
}
    // rust: let (snapshot, live) = wall(None);
    // rust: let mut last_chunk = LastChunk::default();
    // rust: let mut opacity_grid = OpacityGrid::default();
    // rust: assert!(!ray_reaches_without_opaque(
    // rust: [0.0; 3],
    // rust: [8.0, 0.0, 0.0],
    // rust: &snapshot,
    // rust: &mut last_chunk,
    // rust: &mut opacity_grid,
    // rust: ));
    // rust: drop(live);

    // rust: let (snapshot, live) = wall(Some([4, 0, 0]));
    // rust: let mut last_chunk = LastChunk::default();
    // rust: let mut opacity_grid = OpacityGrid::default();
    // rust: assert!(bounds_have_clear_ray(
    // rust: [0.0; 3],
    // rust: [7.95, -0.55, -0.55],
    // rust: [10.05, 0.55, 0.55],
    // rust: &snapshot,
    // rust: &mut last_chunk,
    // rust: &mut opacity_grid,
    // rust: ));
    // rust: drop(live);
}

pub fn ray_scratch_invalidates_cached_voxels_when_the_snapshot_refreshes() void {
}
    // rust: let (opaque_snapshot, opaque_live) = wall(None);
    // rust: let (hole_snapshot, hole_live) = wall(Some([4, 0, 0]));
    // rust: let mut scratch = RayWorkerScratch::default();
    // rust: let generation = AtomicU64::new(0);

    // rust: let mut blocked = job(opaque_snapshot);
    // rust: blocked.snapshot_epoch = 1;
    // rust: filter_rays(&mut blocked, &generation, &mut scratch);
    // rust: assert!(blocked.clear_visible.is_empty());
    // rust: assert_eq!(blocked.queries.len(), 1);

    // rust: let mut clear = job(hole_snapshot);
    // rust: clear.snapshot_epoch = 2;
    // rust: filter_rays(&mut clear, &generation, &mut scratch);
    // rust: assert!(clear.queries.is_empty());
    // rust: assert_eq!(clear.clear_visible.len(), 1);

    // rust: drop((opaque_live, hole_live));
}
}

    // rust: mod external_tests;
