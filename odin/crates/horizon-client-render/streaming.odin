//! Transpiled from Horizon Rust crate
package horizon_client_render_streaming

import "core:fmt"
import "core:mem"
import "core:math"

// Chunk streaming: a worker pool generates, lights and meshes chunk columns
// around the player, closest first. The game thread owns the world and only
// hands immutable `Arc` snapshots to workers; results carry a sequence number
// so stale work is dropped.
// use crate::fast_hash::{FxHashMap, FxHashSet};
// use crate::section_mask::SectionMask;
// use crate::{
    // rust: chunk::Chunk,
    // rust: chunk_map::ChunkMembershipDelta,
    // rust: graphics::LeafCullingMode,
    // rust: light::{LightChanges, LightTables, apply_lighting, apply_relighting, light_chunk},
    // rust: mesher::{MeshScratch, MeshTables, Mesher, Region, SectionMesh, borrow},
    // rust: world::World,
}
// use horizon_core::biome::BiomeZoom;
// use horizon_threads::jobs::{Class, PerWorker, Rank, Registration, Source};
// use horizon_world::block_render::FaceVisibility;
// use horizon_world::worldgen::decoration_order::DecorationOrder;
// use std::{
    // rust: collections::{BinaryHeap, HashSet, VecDeque},
    // rust: sync::{Arc, Condvar, Mutex, MutexGuard, RwLock, TryLockError},
}

// How long a worker waits with nothing to do before it gives back its
// generator's scratch buffers ([`ChunkGenerator::idle`]).
IDLE_RELEASE :: std::time::Duration::from_secs(5)

// Worker CPU time and job counts by kind, for benchmarks
// (`examples/gen_light_bench.rs`). Off unless enabled: a relaxed load per
// job then.
    // rust: pub mod job_stats {
//     use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
    // rust: pub const KINDS: [&str; 7] = [
    // rust: "load", "generate", "decorate", "finish", "light", "mesh", "other",
    // rust: ];
ENABLED :: AtomicBool::new(false)
NANOS :: [const { AtomicU64::new(0) }; 7]
COUNT :: [const { AtomicU64::new(0) }; 7]
enable :: proc(on: bool) {
}
    // rust: ENABLED.store(on, Ordering::Relaxed);
}
    // rust: pub(super) fn enabled() -> bool {
    // rust: ENABLED.load(Ordering::Relaxed)
}
    // rust: pub(super) fn add(kind: usize, nanos: u64) {
    // rust: NANOS[kind].fetch_add(nanos, Ordering::Relaxed);
    // rust: COUNT[kind].fetch_add(1, Ordering::Relaxed);
}
    // (kind, nanoseconds, count) since the last call; resets them.
take :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..KINDS.len())
    // rust: .map(|i| {
    // rust: (
    // rust: KINDS[i],
    // rust: NANOS[i].swap(0, Ordering::Relaxed),
    // rust: COUNT[i].swap(0, Ordering::Relaxed),
    // rust: )
    // rust: })
    // rust: .collect()
}
}
// A chunk under generation, opaque to the streamer.
    // rust: pub type Proto = Box<dyn std::any::Any + Send>;
// Chunk generation in vanilla's stages: a neighbour-independent proto chunk
// (biomes, noise, surface, carvers), decoration of a 3x3 neighbourhood
// (FEATURES, which may write into neighbours), then conversion of a chunk
// whose eight neighbours are decorated into a final column. Implementations
// must be thread-safe; each worker of the shared pool
// (`horizon_threads::jobs`) keeps one `Worker` per streamer.
    // rust: pub trait ChunkGenerator: Send + Sync + 'static {
    // rust: type Worker: Send + 'static;
worker :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
lod_sampler :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: where
    // rust: Self: Sized,
    // rust: {
    // rust: let worker = self.worker();
    // rust: Box::new(GeneratorSampler {
    // rust: generator: self,
    // rust: worker,
    // rust: })
}
    // An undecorated far-terrain column, without allocating gameplay chunks.
    // rust: fn lod_surface(
    // rust: &self,
    // rust: _worker: &mut Self::Worker,
    // rust: _x: i32,
    // rust: _z: i32,
    // rust: ) -> Option<crate::lod::Surface> {
    // rust: None
}
    // A previously saved final chunk, bypassing generation.
load :: proc(self: ^Self, _x: i32, _z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // What a loaded chunk needs from the generator before the game uses it,
    // on the worker that loaded it.
prepare_loaded :: proc(self: ^Self, _worker: ^Self::Worker, _chunk: ^Chunk) {
}
    // The worker has had nothing to do for [`IDLE_RELEASE`]: give back what
    // it keeps between jobs only to go faster.
idle :: proc(self: ^Self, _worker: ^Self::Worker) {
}
    // Every worker has had nothing to do for [`IDLE_RELEASE`]: give back the
    // caches the workers share, which only spare work for chunks generated
    // next to each other in a run. Results do not change.
all_idle :: proc(self: ^Self) {
}
proto :: proc(self: ^Self, worker: ^Self::Worker, x: i32, z: i32) -> P {
    // Ported from Horizon
    return {}
}
decorates :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // Decorate `region[4]`; the region is row-major (dz, dx) around it.
decorate :: proc(self: ^Self, _worker: ^Self::Worker, _region: ^[Proto; 9]) {
}
    // Whether a chunk next to final ones (loaded from the save, as the
    // chunks of a world an older version made) is decorated, its features
    // spilling into them (`proto_beside_final`, `final_writes`), as vanilla's
    // are; otherwise it is left undecorated.
decorates_beside_final :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // The proto chunk of a final chunk, for a decoration region to hold: its
    // blocks are `snapshot`'s.
proto_beside_final :: proc(self: ^Self, _worker: ^Self::Worker, _snapshot: ^Chunk) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // What decoration wrote into the proto chunk of a final chunk: the blocks
    // that differ from `snapshot`, as `([x, y, z], state)`.
final_writes :: proc(self: ^Self, _snapshot: ^Chunk, _proto: ^Proto) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec::new()
}
    // The block entities decoration made at the blocks `writes` put into a
    // final chunk (a chest of a structure piece, a spawner), with their
    // contents.
    // rust: fn final_block_entities(
    // rust: &self,
    // rust: _proto: &Proto,
    // rust: _writes: &[([i32; 3], u32)],
    // rust: ) -> Vec<((i32, i32, i32), crate::chunk::block_entity::BlockEntity)> {
    // rust: Vec::new()
}
finish :: proc(self: ^Self, proto: Proto) -> C {
    // Ported from Horizon
    return {}
}
    // Whether `proto` has been decorated (a saved one can come back decorated).
is_decorated :: proc(self: ^Self, _proto: ^Proto) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // What to save of a proto chunk dropped before it became final.
    // A decorated proto chunk's blocks as a column, to light a finished
    // neighbour against (vanilla lights with neighbours at FEATURES).
light_view :: proc(self: ^Self, _proto: ^Proto) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // A decorated proto chunk's column sections (`Chunk::sections`
    // indexes) holding a block other than air: what its neighbours' light
    // layers count once it is at INITIALIZE_LIGHT.
non_air_sections :: proc(self: ^Self, _proto: ^Proto) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // What the generator's shared caches hold: (name, entries, bytes, if
    // known), for `horizon-ctl memory`.
cache_census :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec::new()
}
    // A proto chunk's heap bytes by part, and its sections by bits per
    // block, for `horizon-ctl memory` (`ProtoChunk::heap_bytes`).
proto_heap_bytes :: proc(self: ^Self, _proto: ^Proto) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: ([0; 6], [0; 16])
}
saved_proto :: proc(self: ^Self, _proto: ^Proto) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // Put a saved proto chunk's state back onto `proto`, generated again.
restore_proto :: proc(self: ^Self, _proto: ^Proto, _saved: crate::chunk::SavedProto) {
}
    // Save proto chunks decoration wrote to, so that they come back as they
    // were: generating them again would lose those writes.
save_protos :: proc(self: ^Self, _protos: ^[^Proto]) {
}
    // Save a column that finished after the player moved away: its
    // neighbours' decoration is done, so it can't be generated again.
save_finished :: proc(self: ^Self, _chunk: Chunk) {
}
}
    // rust: pub type LodDetail = ((i32, i32), Arc<[crate::lod::Column; 256]>);

// Independent, thread-owned far-terrain sampling state.
    // rust: pub trait LodSampler: Send {
    // Independent sampling state; native detail generation stays with the owner.
fork :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
request_detail :: proc(self: ^Self, _chunks: ^[(i32) {
}
drain_details :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec::new()
}
    // A loaded chunk's summary, made on the far-terrain worker.
observed :: proc(self: ^Self, _key: (i32) {
}
    // Reduced far detail (`graphics::FarDetail::Reduced`): `grid` may then
    // approximate wide cells.
set_approximate :: proc(self: ^Self, _approximate: bool) {
}
sample :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
column :: proc(self: ^Self, x: i32, z: i32) -> c {
    // Ported from Horizon
    return {}
}
    // rust: crate::lod::Column::from_surface(self.sample(x, z))
}
reduced_column :: proc(self: ^Self, x: i32, z: i32, _width: i32) -> c {
    // Ported from Horizon
    return {}
}
    // rust: self.column(x, z)
}
    // Whether a column since the last call was left empty because its data
    // is still on its way (a BlueMap tile downloading, nothing coarser to
    // stand in): that sample isn't drawn, what it would replace is
    // (`Lod::finish_any_sample`), and it is taken again later.
waited :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `side` x `side` columns from (`x`, `z`), `stride` blocks apart; none
    // when sampling failed and should be tried again later.
grid :: proc(self: ^Self, x: i32, z: i32, stride: i32, side: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut columns = Vec::with_capacity(side * side);
    // rust: for dz in 0..side {
    // rust: for dx in 0..side {
    // rust: columns.push(self.reduced_column(
    // rust: x + dx as i32 * stride,
    // rust: z + dz as i32 * stride,
    // rust: stride,
    // rust: ));
}
}
    // rust: columns
}
}
    // rust: pub trait LodSource: Send + Sync {
sampler :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // Whether its samplers' `observed` chunks become its own (a server's
    // kept terrain): tiles sampled without one are sampled again.
keeps_observed :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
}
GeneratorSampler :: struct {
    generator: ^G,
    worker: G::Worker,
}
    // rust: impl<G: ChunkGenerator> LodSampler for GeneratorSampler<G> {
sample :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.generator.lod_surface(&mut self.worker, x, z)
}
}
    // rust: impl<G: ChunkGenerator> LodSource for G {
sampler :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: ChunkGenerator::lod_sampler(self)
}
}
// The generator's saving, for the streamer (which doesn't know its type).
    // rust: trait Saves: LodSource {
save_protos :: proc(self: ^Self, protos: ^[^Proto]) {
}
save_finished :: proc(self: ^Self, chunk: Chunk) {
}
}
    // rust: impl<G: ChunkGenerator> Saves for G {
save_protos :: proc(self: ^Self, protos: ^[^Proto]) {
}
    // rust: ChunkGenerator::save_protos(self, protos);
}
save_finished :: proc(self: ^Self, chunk: Chunk) {
}
    // rust: ChunkGenerator::save_finished(self, chunk);
}
}
// Per-job mesher inputs that change with the dimension or the options.
MeshSettings :: struct {
    nether: bool,
    shader_pack_lighting: bool,
    separate_ao: bool,
    shader_pack: bool,
    zoom: BiomeZoom,
    blend_radius: i32,
    smooth_lighting: bool,
    cutout_leaves: bool,
    translucent_layers: ^[bool],
    leaf_culling: LeafCullingMode,
}
Job :: enum {
    Generate(i32, i32),
    // A region to decorate, with the final chunks in it (region index and
    // the chunk as it is): their slots hold nothing until the worker makes
    // their proto chunks.
    Decorate(i32, i32, Box<[Proto; 9]>, Vec<(usize, Chunk)>),
    Finish(Proto),
    Light(i32, i32, Box<Region>, u64, bool),
    Mesh(i32, i32, i32, Box<Region>, u64, MeshSettings),
    // Proto chunks checked out to be saved (`ChunkGenerator::save_protos`),
    // off the main thread like vanilla's IOWorker.
    Save(Vec<((i32, i32), Proto)>),
    // A proto chunk checked out for its light view (`light_region`).
    LightView(i32, i32, Proto),
    // Meshes the renderer is done with (`Streaming::free`): their memory
    // is given back here, not in the frame.
    Free(Vec<((i32, i32, i32), SectionMesh)>),
}
// What decoration wrote into the final chunks of its region.
FinalWrites :: struct {
    blocks: Vec<([i32,
    block_entities: Vec<((i32,
}
Done :: enum {
    Generated(Chunk),
    // A proto chunk, and whether it was decorated (loaded so from the save).
    Proto(i32, i32, Proto, bool),
    // A decorated region, the region indices of its final chunks and what
    // decoration wrote into them.
    Decorated(i32, i32, Box<[Proto; 9]>, Vec<usize>, FinalWrites),
    Lit(i32, i32, Vec<crate::chunk::Light>, u64),
    Meshed(i32, i32, i32, SectionMesh, u64),
    Saved(Vec<((i32, i32), Proto)>),
    // A proto chunk back from `Job::LightView`, with its view.
    LightView(i32, i32, Proto, Option<Chunk>),
}
Queued :: struct {
    priority: i64,
    // The column the job is for and what it adds to the column's distance
    // (`Streaming::submit`): the priority is computed again from them when
    // the centre moves (`Streaming::requeue`). None for saves, which go first.
    at: Option<(i32,
    bias: i64,
    order: u64,
    job: Job,
}
    // rust: impl PartialEq for Queued {
eq :: proc(self: ^Self, o: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.priority == o.priority && self.order == o.order
}
}
    // rust: impl Eq for Queued {}
    // rust: impl PartialOrd for Queued {
partial_cmp :: proc(self: ^Self, o: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.cmp(o))
}
}
    // rust: impl Ord for Queued {
cmp :: proc(self: ^Self, o: ^Self) -> s {
    // Ported from Horizon
    return {}
}
        // BinaryHeap is a max-heap: lower priority value = more urgent.
    // rust: o.priority
    // rust: .cmp(&self.priority)
    // rust: .then(o.order.cmp(&self.order))
}
}
Shared :: struct {
    queue: Mutex<BinaryHeap<Queued>>,
    // What meshing reads (block models and sprites), swapped when resource
    // packs reload; each mesh job takes the current one.
    context: RwLock<^WorkerContext>,
    done: Mailbox,
    // Only workers use this pool; frames never wait for its lock. Retaining
    // cleared buffers avoids racing the renderer for the process heap.
    meshes: Mutex<MeshPool>,
    aborted: std::sync::atomic::AtomicBool,
}
MeshPool :: struct {
    meshes: [dynamic]SectionMesh,
    bytes: uint,
}
    // rust: impl MeshPool {
BYTES :: 16 << 20
COUNT :: 128
take :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mesh = self.meshes.pop().unwrap_or_default();
    // rust: self.bytes -= mesh.capacity_bytes();
    // rust: mesh
}
    // A rejected mesh is dropped by the caller, after releasing the lock.
put :: proc(self: ^Self, mut mesh: SectionMesh) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = mesh.capacity_bytes();
    // rust: if bytes == 0 || self.meshes.len() == Self::COUNT || bytes > Self::BYTES - self.bytes {
    // rust: return Some(mesh);
}
    // rust: mesh.clear();
    // rust: self.bytes += bytes;
    // rust: self.meshes.push(mesh);
    // rust: None
}
}

// Finished jobs, from the workers to the game thread, in the order they
// finished. Not an `mpsc` channel: its receiver waits for a sender it finds
// half way through a send, and a worker descheduled there on a busy machine
// held the frame for a scheduler quantum (10 to 30 ms, the RD 32 ocean
// flight's 1% lows). The frame takes what is there without waiting; while a
// worker holds the lock, it takes it the next frame.
Mailbox :: struct {
    done: Mutex<VecDeque<Done>>,
    arrived: Condvar,
}
    // rust: impl Mailbox {
send :: proc(self: ^Self, done: Done) {
}
    // rust: self.done.lock().unwrap().push_back(done);
    // rust: self.arrived.notify_one();
}
try_lock :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.done.try_lock() {
    // rust: Ok(done) => Some(done),
    // rust: Err(TryLockError::WouldBlock) => None,
    // rust: Err(TryLockError::Poisoned(e)) => panic!("{e}"),
}
}
    // Every finished job, or none while a worker is sending.
take :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.try_lock()
    // rust: .map(|mut done| std::mem::take(&mut *done))
    // rust: .unwrap_or_default()
}
try_recv :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.try_lock()?.pop_front()
}
recv_timeout :: proc(self: ^Self, timeout: std::time::Duration) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let done = self.done.lock().unwrap();
    // rust: let (mut done, _) = self
    // rust: .arrived
    // rust: .wait_timeout_while(done, timeout, |done| done.is_empty())
    // rust: .unwrap();
    // rust: done.pop_front()
}
}
// [`Streaming::proto_census`].
ProtoCensus :: struct {
    protos: uint,
    // Packed blocks, section palettes and lists, heightmaps, other terrain
    // data, biomes, the box and its structure lists.
    bytes: [uint,
    sections_by_bits: [uint,
    light_views: uint,
    light_view_bytes: uint,
    // `ChunkGenerator::cache_census`.
    caches: Vec<(^'static str,
}
Streaming :: struct {
    shared: ^Shared,
    // Columns generated and saved as they were left behind: new when they
    // next arrive, though read from the save (`World::loaded_chunks`).
    dropped_new: FxHashSet<(i32,
    non_air_sections: ^dyn Fn(^Proto) - Maybe(SectionMask) + Send + Sync>,
    // `ChunkGenerator::proto_heap_bytes`, for the memory census.
    proto_bytes: ^dyn Fn(^Proto) - ([uint,
    // `ChunkGenerator::cache_census`.
    caches: ^dyn Fn() - Vec<(^'static str,
    // This streamer's place in the shared pool (`horizon_threads::jobs`);
    // dropping it waits for its running jobs.
    jobs: Registration,
    // The workers its in-flight work is sized for.
    workers: uint,
    order: u64,
    // Ticks since the columns and protos that fell out of range were swept.
    scan_age: u8,
    // The centre and radius the sweep was last reset for.
    scan_area: ((i32,
    generating: FxHashSet<(i32,
    generation_scan: GenerationScan,
    // Proto chunks: `None` while checked out to a decoration or save job.
    protos: FxHashMap<(i32,
    // The light jobs' views of proto chunks past the area (`light_region`),
    // built once per proto: each is a neighbour of up to three columns and
    // waits in failed regions until the last one loads. Dropped whenever
    // the proto is checked out, replaced or removed.
    light_views: FxHashMap<(i32,
    decorated: FxHashSet<(i32,
    decorating: uint,
    // The final chunks a running decoration writes into: another one that
    // reaches them waits, as vanilla's features run one after the other and
    // each sees what the one before placed.
    decorating_finals: HashSet<(i32,
    // Save jobs in flight.
    saving: uint,
    // Proto chunks checked out to a worker for their light view.
    viewing: FxHashSet<(i32,
    // Vanilla's decoration order around the player, and the centre and
    // radius it was last ranked for.
    decoration_order: DecorationOrder,
    order_area: Option<((i32,
    // What the queued jobs' priorities were computed from (`requeue`): the
    // centre, the band, and the extra areas.
    queue_basis: (((i32,
    finishing: FxHashSet<(i32,
    decorates: bool,
    // `ChunkGenerator::decorates_beside_final`.
    saves_beside_final: bool,
    lighting: FxHashMap<(i32,
    meshing: FxHashMap<(i32,
    // The sequence each section's latest accepted mesh was dispatched at
    // (`CompiledSectionMesh.compileTaskStartTimeNs`).
    compile_started: FxHashMap<(i32,
    // Chunks whose light is current.
    lit: FxHashSet<(i32,
    // Columns whose sections have been meshed at least once.
    meshed: FxHashSet<(i32,
    // Dirty sections of loaded columns past the render distance, meshed once
    // the player comes closer, and the area they were set aside for.
    waiting: FxHashSet<(i32,
    waiting_area: ((i32,
    // Proto chunks decoration wrote to since they were generated or saved.
    written: FxHashSet<(i32,
    saves: ^dyn Saves,
    // Results received while `save` waited, for the next `update`.
    deferred: [dynamic]Done,
    sequence: u64,
    center: (i32,
    // The view distance around `center`; below 0, no area there (a dedicated
    // server nobody is on).
    radius: i32,
    // `/forceload`ed chunks: kept loaded whatever the distance.
    forced: HashSet<(i32,
    // Chunks a native mod's tickets hold (NeoForge's `TicketController`):
    // kept loaded and ticking as forced ones are, but neither saved with
    // them nor listed by `/forceload`.
    mod_forced: HashSet<(i32,
    // No work is scheduled while paused (title screen).
    paused: bool,
    // Dimension flags: sky light, Nether face shading.
    sky_light: bool,
    nether_shading: bool,
    // A shader pack lights the faces: sections mesh without face shading
    // (`Mesher::shader_pack_lighting`).
    shader_pack_lighting: bool,
    // OptiFine/Iris separate ambient occlusion: vertex RGB has pure tint and alpha holds AO factor
    // (`Mesher::separate_ao`).
    separate_ao: bool,
    // A `shaders/` pack draws the terrain: fluid tops split as Iris splits them
    // (`Mesher::shader_pack`).
    shader_pack: bool,
    // `BiomeManager`'s zoom seed (the hashed world seed) and `biomeBlendRadius`.
    biome_zoom: BiomeZoom,
    biome_blend: i32,
    // The `ao` and `cutoutLeaves` options.
    smooth_lighting: bool,
    cutout_leaves: bool,
    // Sprite layers a shader pack draws in the translucent pass (`[[materials]]
    // translucent`), by layer; empty without one.
    translucent_layers: ^[bool],
    // What the mesher does with leaf faces inside a canopy (`LeafCullingMode`).
    leaf_culling: LeafCullingMode,
    // Incremental relighting of block edits on lit chunks (see `light::relight`).
    light_tables: ^LightTables,
    // Applied edits by sequence, replayed onto light jobs snapshotted before them.
    light_log: Vec<(u64,
    light_edit_sequence: u64,
    // Edit sequence at each in-flight light job's snapshot.
    light_snapshots: FxHashMap<(i32,
    generated_total: u64,
    meshed_total: u64,
    // Chunks come from a server (`insert_remote`/`forget`): nothing is
    // generated and columns are only unloaded when the server says so.
    remote: bool,
    // More areas to keep loaded (centre chunk, radius), e.g. around the
    // players of a server. Each is a square, like vanilla's ticket levels:
    // chunks finish out to `radius + 1` (Chebyshev) and generation reaches
    // past that as around the player. They are generated and kept but not meshed.
    extra: Vec<((i32,
    // `extra`'s squares as a grid, made again when `extra` changes.
    cover: Maybe(ExtraCover),
    // Mesh the sections for drawing (false on a server thread).
    mesh: bool,
    // The pregeneration band (`set_band`).
    band: Maybe(Band),
    // The columns and the next row the band's decoration ranks were given
    // for (`set_band`).
    band_ranked: Option<(i32,
}
// Snapshot only after a scan found no missing candidates. Public range fields
// and `World::chunks` can change without going through Streaming, so compare
// their values and structural membership token rather than a frame timeout.
//
// A scan also keeps every candidate it found, nearest first (`plan`): while
// the ranges stay the same and no column leaves (`World::chunks` removals, or
// `invalidate` for proto chunks dropped), no column becomes wanted, so the
// next batches are the plan's entries still missing. A full scan looks at
// every column of the areas (thousands at render distance 32), and one ran
// whenever a worker finished: it took a quarter of the thread that runs
// `Streaming::update` while a world loaded.
GenerationScan :: struct {
    exhausted: bool,
    center: (i32,
    radius: i32,
    extra: Vec<((i32,
    forced: HashSet<(i32,
    mod_forced: HashSet<(i32,
    band: Maybe(Band),
    chunk_revision: u64,
    plan: Vec<(i64,
    // Entries before it are no longer missing.
    next: uint,
    // What `plan` was made for: the ranges and decoration; the chunk
    // map's revision is `chunk_revision`.
    plan_basis: Maybe(bool),
}
    // rust: impl GenerationScan {
same_ranges :: proc(self: ^Self, ranges: ^Ranges<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.center == ranges.center
    // rust: && self.radius == ranges.radius
    // rust: && self.extra == ranges.extra
    // rust: && self.forced == *ranges.forced
    // rust: && self.mod_forced == *ranges.mod_forced
    // rust: && self.band.as_ref() == ranges.band
}
unchanged :: proc(self: ^Self, ranges: ^Ranges<'_>, world: ^World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.exhausted
    // rust: && self.same_ranges(ranges)
    // rust: && self.chunk_revision == world.chunks.membership_revision()
}
    // A column may be wanted again (a proto chunk was dropped): the next
    // call scans the areas again.
invalidate :: proc(self: ^Self) {
}
    // rust: self.exhausted = false;
    // rust: self.plan_basis = None;
}
    // Whether `plan` still holds every candidate: same ranges, and no
    // column left the chunk map since it was made.
plan_holds :: proc(self: ^Self, input: ^GenerationInputs<'_>) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.plan_basis != Some(input.decorates) || !self.same_ranges(&input.ranges) {
    // rust: return false;
}
    // rust: let revision = input.world.chunks.membership_revision();
    // rust: if revision != self.chunk_revision {
    // rust: let Some(mut changes) = input.world.chunks.deltas_since(self.chunk_revision) else {
    // rust: return false;
}
    // rust: if !changes.all(|(_, change)| matches!(change, ChunkMembershipDelta::Added(_))) {
    // rust: return false;
}
    // rust: self.chunk_revision = revision;
}
    // rust: true
}
remember :: proc(self: ^Self, ranges: Ranges<'_>, world: ^World) {
}
    // rust: self.exhausted = true;
    // rust: self.center = ranges.center;
    // rust: self.radius = ranges.radius;
    // rust: self.extra.clear();
    // rust: self.extra.extend_from_slice(ranges.extra);
    // rust: self.forced.clone_from(ranges.forced);
    // rust: self.mod_forced.clone_from(ranges.mod_forced);
    // rust: self.band = ranges.band.copied();
    // rust: self.chunk_revision = world.chunks.membership_revision();
}
}
GenerationInputs :: struct {
    ranges: Ranges<'a>,
    world: ^'a World,
    generating: ^'a FxHashSet<(i32,
    protos: ^'a FxHashMap<(i32,
    finishing: ^'a FxHashSet<(i32,
    decorates: bool,
    remote: bool,
}
    // rust: impl GenerationScan {
    // None means the scan was skipped; Some preserves the original candidate
    // ordering and bounded batch, including an empty exhausted scan.
    // rust: fn candidates(
    // rust: &mut self,
    // rust: input: GenerationInputs<'_>,
    // rust: capacity: usize,
    // rust: ) -> Option<Vec<(i64, i32, i32)>> {
        // Generation (load or proto), closest first, bounded in flight.
    // rust: let (margin, reach) = Ranges::margins(input.decorates);
    // rust: if input.remote
    // rust: || input.generating.len() >= capacity
    // rust: || self.unchanged(&input.ranges, input.world)
    // rust: {
    // rust: return None;
}
    // rust: let missing = |&(_, x, z): &(i64, i32, i32)| {
    // rust: !input.world.chunks.contains_key(&(x, z))
    // rust: && !input.generating.contains(&(x, z))
    // rust: && !input.protos.contains_key(&(x, z))
    // rust: && !input.finishing.contains(&(x, z))
}
    // rust: if self.plan_holds(&input) {
    // rust: while self.next < self.plan.len() && !missing(&self.plan[self.next]) {
    // rust: self.next += 1;
}
    // rust: let room = capacity - input.generating.len();
    // rust: let batch: Vec<_> = self.plan[self.next..]
    // rust: .iter()
    // rust: .filter(|c| missing(c))
    // rust: .take(room)
    // rust: .copied()
    // rust: .collect();
            // Past the plan's end, the full scan below decides whether
            // anything is left (and remembers when nothing is).
    // rust: if !batch.is_empty() {
    // rust: self.exhausted = false;
    // rust: return Some(batch);
}
}
    // rust: {
    // rust: let mut wanted = Vec::new();
            // Each area's square of columns, as one run per row. Players'
            // areas overlap (a server's players often stand together), so
            // the runs of a row are merged and each column is looked at once.
    // rust: let mut runs: Vec<(i32, i32, i32)> = Vec::new();
    // rust: for (center, radius) in std::iter::once((input.ranges.center, input.ranges.radius))
    // rust: .chain(input.ranges.extra.iter().copied())
    // rust: {
    // rust: let r = radius + margin.max(reach + 1);
    // rust: runs.extend((center.1 - r..=center.1 + r).map(|z| (z, center.0 - r, center.0 + r)));
}
    // rust: if let Some(band) = input.ranges.band {
    // rust: let r = margin.max(reach + 1);
    // rust: runs.extend((band.z0 - r..=band.z1 + r).map(|z| (z, band.x0 - r, band.x1 + r)));
}
    // rust: runs.sort_unstable();
    // rust: let mut runs = runs.into_iter().peekable();
    // rust: while let Some((z, x0, mut x1)) = runs.next() {
    // rust: while let Some((_, _, next_x1)) =
    // rust: runs.next_if(|&(nz, nx0, _)| nz == z && nx0 <= x1.saturating_add(1))
    // rust: {
    // rust: x1 = x1.max(next_x1);
}
    // rust: for x in x0..=x1 {
    // rust: if !input.ranges.requested(x, z, input.decorates)
    // rust: || input.world.chunks.contains_key(&(x, z))
    // rust: || input.generating.contains(&(x, z))
    // rust: || input.protos.contains_key(&(x, z))
    // rust: || input.finishing.contains(&(x, z))
    // rust: {
    // rust: continue;
}
    // rust: wanted.push((input.ranges.priority(x, z), x, z));
}
}
            // Forced chunks and their generation neighbourhood: the ring that
            // is decorated (or finished, without decoration) and the one its
            // 3x3 needs.
    // rust: let reach = if input.decorates {
    // rust: FORCED_TERRAIN_RING
    // rust: } else {
    // rust: FORCED_FEATURES_RING
}
    // rust: for &(fx, fz) in input.ranges.forced_chunks() {
    // rust: for dz in -reach..=reach {
    // rust: for dx in -reach..=reach {
    // rust: let (x, z) = (fx + dx, fz + dz);
    // rust: if input.world.chunks.contains_key(&(x, z))
    // rust: || input.generating.contains(&(x, z))
    // rust: || input.protos.contains_key(&(x, z))
    // rust: || input.finishing.contains(&(x, z))
    // rust: {
    // rust: continue;
}
    // rust: wanted.push((input.ranges.priority(x, z), x, z));
}
}
}
    // rust: let ranges = Ranges {
    // rust: center: input.ranges.center,
    // rust: radius: input.ranges.radius,
    // rust: extra: input.ranges.extra,
    // rust: forced: input.ranges.forced,
    // rust: mod_forced: input.ranges.mod_forced,
    // rust: cover: input.ranges.cover,
    // rust: band: input.ranges.band,
}
    // rust: self.remember(ranges, input.world);
    // rust: if wanted.is_empty() {
    // rust: self.plan.clear();
    // rust: self.plan_basis = None;
    // rust: } else {
                // A bounded batch may leave candidates behind: the next calls
                // take them from the plan as capacity opens.
    // rust: self.exhausted = false;
    // rust: self.plan_basis = Some(input.decorates);
}
    // rust: wanted.sort_unstable();
    // rust: wanted.dedup();
    // rust: self.plan.clear();
    // rust: self.plan.extend_from_slice(&wanted);
    // rust: self.next = 0;
    // rust: wanted.truncate(capacity - input.generating.len());
    // rust: Some(wanted)
}
}
}
// What a pool worker keeps for one streamer between its jobs: the
// generator's worker, and the face visibility table and its occlusion
// cache (like vanilla's per-thread cache: cloning it per job copied every
// state and face shape) and the mesher's scratch.
WorkerLocal :: struct {
    worker: W,
    faces: Maybe((Arc<MeshTables),
    mesh_scratch: MeshScratch,
}
// A streamer's jobs, run by the process's shared pool (`horizon_threads::jobs`).
Jobs :: struct {
    shared: ^Shared,
    generator: ^G,
    light: ^LightTables,
    locals: PerWorker<WorkerLocal<G::Worker>>,
}
    // rust: impl<G: ChunkGenerator> Source for Jobs<G> {
next :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let queue = self.shared.queue.lock().unwrap();
    // rust: if self
    // rust: .shared
    // rust: .aborted
    // rust: .load(std::sync::atomic::Ordering::Relaxed)
    // rust: {
    // rust: for q in queue.iter() {
    // rust: if matches!(q.job, Job::Save(..)) {
    // rust: return Some(Rank::new(Class::Urgent, q.priority));
}
}
    // rust: return None;
}
    // rust: queue.peek().map(|q| {
            // Jobs without a column (saves, meshes to free) go first.
    // rust: let class = if q.at.is_none() {
    // rust: Class::Urgent
    // rust: } else {
    // rust: Class::Near
}
    // rust: Rank::new(class, q.priority)
    // rust: })
}
run :: proc(self: ^Self, worker: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(job) = self.shared.queue.lock().unwrap().pop() else {
    // rust: return false;
}
    // rust: if self
    // rust: .shared
    // rust: .aborted
    // rust: .load(std::sync::atomic::Ordering::Relaxed)
    // rust: && !matches!(job.job, Job::Save(..))
    // rust: {
    // rust: return true;
}
    // rust: let started = job_stats::enabled().then(|| {
    // rust: let kind = match &job.job {
    // rust: Job::Generate(..) => 1,
    // rust: Job::Decorate(..) => 2,
    // rust: Job::Finish(..) => 3,
    // rust: Job::Light(..) => 4,
    // rust: Job::Mesh(..) => 5,
    // rust: _ => 6,
}
            // The other jobs (saves, light views, freed meshes) are many and short: counted, not
            // timed, so the clock reads don't cost more than they do.
    // rust: let cpu = if kind == 6 {
    // rust: std::time::Duration::ZERO
    // rust: } else {
    // rust: crate::spans::thread_cpu().unwrap_or_default()
}
    // rust: (kind, cpu)
    // rust: });
    // rust: let _tag = horizon_threads::heap_tag(match &job.job {
    // rust: Job::Generate(..) => "stream.generate",
    // rust: Job::Decorate(..) => "stream.decorate",
    // rust: Job::Finish(..) => "stream.finish",
    // rust: Job::Light(..) => "stream.light",
    // rust: Job::Mesh(..) => "stream.mesh",
    // rust: _ => "stream.other",
    // rust: });
    // rust: let done = self.locals.with(
    // rust: worker,
    // rust: || {
    // rust: let _tag = horizon_threads::heap_tag("stream.worker_state");
    // rust: WorkerLocal {
    // rust: worker: self.generator.worker(),
    // rust: faces: None,
    // rust: mesh_scratch: MeshScratch::default(),
}
    // rust: },
    // rust: |local| self.run_job(job.job, local),
    // rust: );
    // rust: if let Some((kind, started)) = started {
            // A generation job that found the column saved loaded it.
    // rust: let kind = if kind == 1 && matches!(done, Some(Done::Generated(_))) {
    // rust: 0
    // rust: } else {
    // rust: kind
}
    // rust: let nanos = if kind == 6 {
    // rust: 0
    // rust: } else {
    // rust: let cpu = crate::spans::thread_cpu().unwrap_or_default();
    // rust: cpu.saturating_sub(started).as_nanos() as u64
}
    // rust: job_stats::add(kind, nanos);
}
    // rust: if let Some(done) = done {
    // rust: self.shared.done.send(done);
}
    // rust: true
}
idle :: proc(self: ^Self, worker: uint) {
}
        // A server nobody is on, a client standing still: free the
        // generator's buffers (and the mesher's face cache and scratch)
        // until the next job needs them.
    // rust: self.locals.with_existing(worker, |local| {
    // rust: self.generator.idle(&mut local.worker);
    // rust: local.faces = None;
    // rust: local.mesh_scratch = MeshScratch::default();
    // rust: });
}
all_idle :: proc(self: ^Self) {
}
        // No worker needs retained mesh capacity now. Drop it outside the
        // pool lock; the pool then asks the allocator to return freed pages.
    // rust: let meshes = std::mem::take(&mut *self.shared.meshes.lock().unwrap());
    // rust: drop(meshes);
    // rust: self.generator.all_idle();
}
}
    // rust: impl<G: ChunkGenerator> Jobs<G> {
run_job :: proc(self: ^Self, job: Job, local: ^WorkerLocal<G::Worker>) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (generator, shared, light) = (&self.generator, &self.shared, &self.light);
    // rust: let WorkerLocal {
    // rust: worker,
    // rust: faces,
    // rust: mesh_scratch,
    // rust: } = local;
    // rust: let done = match job {
    // rust: Job::Generate(x, z) => match generator.load(x, z) {
    // rust: Some(chunk) => {
    // rust: generator.prepare_loaded(&mut *worker, &chunk);
    // rust: Done::Generated(chunk)
}
    // rust: None => {
    // rust: let proto = generator.proto(&mut *worker, x, z);
    // rust: let decorated = generator.is_decorated(&proto);
    // rust: Done::Proto(x, z, proto, decorated)
}
    // rust: },
    // rust: Job::Decorate(x, z, mut region, finals) => {
                // The final chunks' proto chunks, made here: a
                // generated proto chunk holding their blocks.
    // rust: for (i, snapshot) in &finals {
    // rust: if let Some(proto) = generator.proto_beside_final(&mut *worker, snapshot) {
    // rust: region[*i] = proto;
}
}
    // rust: generator.decorate(&mut *worker, &mut region);
    // rust: let mut writes = FinalWrites::default();
    // rust: for (i, snapshot) in &finals {
    // rust: let blocks = generator.final_writes(snapshot, &region[*i]);
    // rust: writes
    // rust: .block_entities
    // rust: .extend(generator.final_block_entities(&region[*i], &blocks));
    // rust: writes.blocks.extend(blocks);
    // rust: region[*i] = Box::new(());
}
    // rust: let finals = finals.into_iter().map(|(i, _)| i).collect();
    // rust: Done::Decorated(x, z, region, finals, writes)
}
    // rust: Job::Finish(proto) => {
    // rust: let mut chunk = generator.finish(proto);
    // rust: chunk.generated = true;
    // rust: Done::Generated(chunk)
}
    // rust: Job::Save(protos) => {
    // rust: let refs: Vec<&Proto> = protos.iter().map(|(_, p)| p).collect();
    // rust: generator.save_protos(&refs);
    // rust: Done::Saved(protos)
}
    // rust: Job::LightView(x, z, proto) => {
    // rust: let view = generator.light_view(&proto);
    // rust: Done::LightView(x, z, proto, view)
}
    // rust: Job::Free(meshes) => {
    // rust: for (_, mesh) in meshes {
    // rust: let rejected = shared.meshes.lock().unwrap().put(mesh);
    // rust: drop(rejected);
}
    // rust: return None;
}
    // rust: Job::Light(x, z, region, seq, sky) => {
    // rust: Done::Lit(x, z, light_chunk(&borrow(&region), light, sky), seq)
}
    // rust: Job::Mesh(x, sy, z, region, seq, settings) => {
    // rust: let context = shared.context.read().unwrap().clone();
    // rust: let visibility = match faces.take() {
    // rust: Some((tables, visibility)) if Arc::ptr_eq(&tables, &context.tables) => {
    // rust: visibility
}
    // rust: _ => context.tables.visibility.clone(),
}
    // rust: let mut mesher = Mesher {
    // rust: nether_shading: settings.nether,
    // rust: shader_pack_lighting: settings.shader_pack_lighting,
    // rust: separate_ao: settings.separate_ao,
    // rust: shader_pack: settings.shader_pack,
    // rust: zoom: settings.zoom,
    // rust: blend_radius: settings.blend_radius,
    // rust: smooth_lighting: settings.smooth_lighting,
    // rust: cutout_leaves: settings.cutout_leaves,
    // rust: translucent_layers: &settings.translucent_layers,
    // rust: leaf_culling: settings.leaf_culling,
    // rust: assets: &context.assets,
    // rust: render: &context.render,
    // rust: tables: &context.tables,
    // rust: biomes: &context.biomes,
    // rust: visibility,
}
    // rust: let recycled = shared.meshes.lock().unwrap().take();
    // rust: let mut mesh = mesher.mesh_reusing(&borrow(&region), sy, recycled, mesh_scratch);
    // rust: mesh.sort_solid();
    // rust: *faces = Some((context.tables.clone(), mesher.visibility));
    // rust: Done::Meshed(x, sy, z, mesh, seq)
}
}
    // rust: Some(done)
}
}
WorkerContext :: struct {
    assets: ^crate::assets::Assets,
    render: ^crate::assets::RenderAssets,
    tables: ^MeshTables,
    biomes: ^crate::biome::Biomes,
    light: ^LightTables,
}
    // rust: impl Streaming {
    // rust: pub fn new<G: ChunkGenerator>(
    // rust: generator: Arc<G>,
    // rust: context: Arc<WorkerContext>,
    // rust: threads: usize,
    // rust: ) -> Self {
    // rust: let shared = Arc::new(Shared {
    // rust: queue: Mutex::new(BinaryHeap::new()),
    // rust: context: RwLock::new(context.clone()),
    // rust: done: Mailbox::default(),
    // rust: meshes: Mutex::new(MeshPool::default()),
    // rust: aborted: std::sync::atomic::AtomicBool::new(false),
    // rust: });
    // rust: let light_tables = context.light.clone();
    // rust: let saves: Arc<dyn Saves> = generator.clone();
    // rust: let pool = horizon_threads::jobs::pool();
    // rust: let source = Arc::new(Jobs {
    // rust: shared: shared.clone(),
    // rust: generator: generator.clone(),
    // rust: light: context.light.clone(),
    // rust: locals: horizon_threads::jobs::PerWorker::new(pool.threads()),
    // rust: });
    // rust: let jobs = pool.register(source);
        // The work kept in flight is sized for the workers this streamer may
        // use: the pool's, or fewer when asked (tests, a placeholder).
    // rust: let workers = threads.clamp(1, pool.threads());
    // rust: let non_air_sections = {
    // rust: let generator = generator.clone();
    // rust: Arc::new(move |p: &Proto| generator.non_air_sections(p))
}
    // rust: let proto_bytes = {
    // rust: let generator = generator.clone();
    // rust: Arc::new(move |p: &Proto| generator.proto_heap_bytes(p))
}
    // rust: let caches = {
    // rust: let generator = generator.clone();
    // rust: Arc::new(move || generator.cache_census())
}
    // rust: Self {
    // rust: shared,
    // rust: non_air_sections,
    // rust: proto_bytes,
    // rust: caches,
    // rust: jobs,
    // rust: workers,
    // rust: order: 0,
    // rust: scan_age: 0,
    // rust: scan_area: ((i32::MIN, i32::MIN), i32::MIN),
    // rust: generating: Default::default(),
    // rust: generation_scan: GenerationScan::default(),
    // rust: protos: Default::default(),
    // rust: light_views: Default::default(),
    // rust: decorated: Default::default(),
    // rust: dropped_new: Default::default(),
    // rust: decorating: 0,
    // rust: decorating_finals: HashSet::new(),
    // rust: saving: 0,
    // rust: viewing: Default::default(),
    // rust: decoration_order: DecorationOrder::default(),
    // rust: order_area: None,
    // rust: queue_basis: Default::default(),
    // rust: finishing: Default::default(),
    // rust: decorates: generator.decorates(),
    // rust: saves_beside_final: generator.decorates_beside_final(),
    // rust: lighting: Default::default(),
    // rust: meshing: Default::default(),
    // rust: compile_started: Default::default(),
    // rust: lit: Default::default(),
    // rust: meshed: Default::default(),
    // rust: waiting: Default::default(),
    // rust: waiting_area: ((0, 0), 0, 0),
    // rust: written: Default::default(),
    // rust: saves,
    // rust: deferred: Vec::new(),
    // rust: sequence: 0,
    // rust: center: (0, 0),
    // rust: radius: 8,
    // rust: forced: HashSet::new(),
    // rust: mod_forced: HashSet::new(),
    // rust: paused: false,
    // rust: sky_light: true,
    // rust: nether_shading: false,
    // rust: shader_pack_lighting: false,
    // rust: separate_ao: false,
    // rust: shader_pack: false,
    // rust: biome_zoom: BiomeZoom::new(0),
    // rust: biome_blend: 2,
    // rust: smooth_lighting: true,
    // rust: cutout_leaves: true,
    // rust: translucent_layers: Arc::from([]),
    // rust: leaf_culling: LeafCullingMode::Off,
    // rust: light_tables,
    // rust: light_log: Vec::new(),
    // rust: light_edit_sequence: 0,
    // rust: light_snapshots: Default::default(),
    // rust: generated_total: 0,
    // rust: meshed_total: 0,
    // rust: remote: false,
    // rust: extra: Vec::new(),
    // rust: cover: None,
    // rust: mesh: true,
    // rust: band: None,
    // rust: band_ranked: None,
}
}
    // Shares generation resources, but gives distant work its own worker state.
lod_source :: proc(self: ^Self) -> A {
    // Ported from Horizon
    return {}
}
    // rust: self.saves.clone()
}
    // Resource packs reloaded (`LevelRenderer.allChanged`): mesh with the new
    // models and sprites, and rebuild every loaded section. Meshes in flight
    // were made with the old resources; their results are dropped.
reload_resources :: proc(self: ^Self, world: ^World, context: ^WorkerContext) {
}
    // rust: *self.shared.context.write().unwrap() = context;
    // rust: self.meshing.clear();
    // rust: self.compile_started.clear();
    // rust: for &(x, z) in world.chunks.keys() {
    // rust: if self.lit.contains(&(x, z)) {
    // rust: for sy in 0..world.layout().sections() as i32 {
    // rust: world.dirty_sections.insert((x, sy, z));
}
}
}
}
    // A column received from a server, with the light it sent
    // (`ClientPacketListener.handleLevelChunkWithLight`): nothing is
    // relit, and it and its neighbours remesh (`enableChunkLight`).
insert_remote :: proc(self: ^Self, world: ^World, chunk: Chunk) {
}
    // rust: let key = (chunk.x, chunk.z);
    // rust: self.lighting.remove(&key);
    // rust: self.light_snapshots.remove(&key);
    // rust: world.chunks.insert(key, Arc::new(chunk));
    // rust: self.lit.insert(key);
    // rust: self.generated_total += 1;
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: for sy in 0..world.layout().sections() as i32 {
    // rust: world.dirty_sections.insert((key.0 + dx, sy, key.1 + dz));
}
}
}
}
    // A resident column a server sent again whole (it changed it in bulk):
    // its new blocks taken, the sections that did not change kept as they
    // were, and its light and its neighbours' worked out again here, off
    // the game thread, as light is for the blocks a server changes one at a
    // time; the sections that changed remesh (with theirs) once lit. Until
    // then the sections that changed show the light the packet carried (a
    // Horizon server sends the light from before its relight, then the
    // new light; another server's is already right, which matters where
    // the neighbours this light needs aren't all here).
replace_remote :: proc(self: ^Self, world: ^World, mut chunk: Chunk) {
}
    // rust: let key = (chunk.x, chunk.z);
    // rust: let Some(old) = world.chunks.get(&key).cloned() else {
    // rust: return self.insert_remote(world, chunk);
}
    // rust: if !self.lit.contains(&key) {
    // rust: return self.insert_remote(world, chunk);
}
        // The cells whose blocks changed, by section: they remesh with the neighbours within a block of them (as
        // vanilla's `setBlocksDirty`), not every section round each section changed (which, for the few blocks a
        // section often changes in a bulk edit, is mostly sections that did not).
    // rust: let mut cells = crate::light::LightChanges::default();
    // rust: cells.keyed(world.layout());
    // rust: let kept = keep_unchanged_sections(&old, &mut chunk, &mut cells);
    // rust: chunk.light_loaded = old.light_loaded;
    // rust: chunk.lit = true;
    // rust: world.chunks.insert(key, Arc::new(chunk));
    // rust: world.revision = world.revision.wrapping_add(1);
        // A section with new biomes and the same blocks remeshes now (its tint), with its neighbours, whose tint
        // blends across the border: above and below too, as a block's tint can sample the biome quart of the
        // section next to it (`BiomeManager.getBiome`'s zoom reaches a quart beyond the block).
    // rust: Self::light_updated(world, key.0, key.1, &kept.biomes);
        // A section with the same blocks and new light takes the packet's light (vanilla's
        // `handleLevelChunkWithLight` always applies it) and remeshes as a light update would.
    // rust: Self::light_updated(world, key.0, key.1, &kept.light);
    // rust: if !kept.blocks {
    // rust: return;
}
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: world.dirty_light.insert((key.0 + dx, key.1 + dz));
}
}
    // rust: cells.dirty_sections(|section| {
    // rust: world.dirty_sections.insert(section);
    // rust: });
}
    // A server's light update for a resident column: the sections whose
    // light changed and their neighbours remesh
    // (`setSectionDirtyWithNeighbors`). A resent column's sections with new
    // biomes remesh the same way.
light_updated :: proc(world: ^World, x: i32, z: i32, sections: ^[uint]) {
}
    // rust: for &sy in sections {
    // rust: for dz in -1..=1 {
    // rust: for dy in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: let s = sy as i32 + dy;
    // rust: if (0..world.layout().sections() as i32).contains(&s) {
    // rust: world.dirty_sections.insert((x + dx, s, z + dz));
}
}
}
}
}
}
    // Give back meshes the renderer has copied: a worker frees them, ahead of
    // other jobs, as vanilla's compile task closes its mesh data on its own
    // thread once copied (`SectionRenderDispatcher.RenderSection.CompileTask.doTask`).
    // Freed in the frame, the hundreds of meshes a chunk border brings waited
    // on the allocator behind every busy worker: up to 20 ms of a frame each
    // time while flying at render distance 32.
free :: proc(self: ^Self, meshes: Vec<((i32) {
}
    // rust: if !meshes.is_empty() {
    // rust: self.submit(None, 0, Job::Free(meshes));
}
}
    // The columns the server unloaded (ClientboundForgetLevelChunkPacket),
    // often thousands at once (a teleport or a moved view): their pending
    // sections go through [`forget_pending_sections`]. Returns the chunks
    // they held.
    // rust: pub fn forget_columns(
    // rust: &mut self,
    // rust: world: &mut World,
    // rust: gone: &FxHashSet<(i32, i32)>,
    // rust: ) -> Vec<Arc<Chunk>> {
        // Every column held (a far teleport): no pending section is left to keep, and a
        // pass over them all (80,000 at render distance 32) took 1.7 ms of the frame.
    // rust: if world.chunks.keys().all(|column| gone.contains(column)) {
    // rust: self.meshing.clear();
    // rust: self.compile_started.clear();
    // rust: self.waiting.clear();
    // rust: } else {
    // rust: forget_pending_sections(
    // rust: &mut self.meshing,
    // rust: &mut self.compile_started,
    // rust: &mut self.waiting,
    // rust: gone,
    // rust: world.layout().sections() as i32,
    // rust: );
}
        // `ChunkTaskPriorityQueue.release` for each of them (`ChunkTaskDispatcher`'s
        // `release(col, true)` from the chunk's unload): the jobs still queued for a
        // column go with it instead of running for a level they no longer belong to.
    // rust: if !gone.is_empty()
    // rust: && let Ok(mut queue) = self.shared.queue.lock()
    // rust: {
    // rust: release_columns(&mut queue, gone);
}
    // rust: let mut chunks = Vec::with_capacity(gone.len());
    // rust: for &(x, z) in gone {
    // rust: self.lit.remove(&(x, z));
    // rust: self.meshed.remove(&(x, z));
    // rust: self.lighting.remove(&(x, z));
    // rust: world.dirty_sections.take_column(x, z);
    // rust: chunks.extend(world.chunks.remove(&(x, z)));
}
    // rust: chunks
}
    // Queue a job for the column `at`, nearest first: its distance (`distance`)
    // times four plus `bias`, which orders a column's jobs. A job without a
    // column (a save, meshes to free) goes ahead of every other.
submit :: proc(self: ^Self, at: Option<(i32) {
}
    // rust: self.order += 1;
    // rust: let priority = at.map_or(i64::MIN, |(x, z)| self.distance(x, z) * 4 + bias);
    // rust: self.shared.queue.lock().unwrap().push(Queued {
    // rust: priority,
    // rust: at,
    // rust: bias,
    // rust: order: self.order,
    // rust: job,
    // rust: });
    // rust: self.jobs.notify();
}
    // Rank the queued jobs again when what their priorities were computed
    // from changed: the centre, the extra areas, the band, or the loading
    // screen (ring order, `Ranges::rings`, whose values are far above the
    // distances used after it). Vanilla's chunk task queue follows the
    // current ticket levels in the same way. Without it, generation queued
    // while the loading screen was up waited behind every job queued after
    // it, and with it the decoration of the chunks around the player: at
    // render distance 32 nothing was decorated until every proto chunk had
    // been generated.
requeue :: proc(self: ^Self) {
}
    // rust: let basis = (self.center, self.band);
    // rust: if self.queue_basis.0 == basis && self.queue_basis.1 == self.extra {
    // rust: return;
}
    // rust: self.queue_basis = (basis, self.extra.clone());
    // rust: let mut queue = self.shared.queue.lock().unwrap();
    // rust: rank_again(&mut queue, |x, z| self.distance(x, z));
}
    // rust: fn receive_decorated(
    // rust: &mut self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: region: [Proto; 9],
    // rust: finals: Vec<usize>,
    // rust: writes: FinalWrites,
    // rust: world: &mut World,
    // rust: ) {
    // rust: self.generation_scan.exhausted = false;
    // rust: self.decorating -= 1;
    // rust: for i in &finals {
    // rust: self.decorating_finals
    // rust: .remove(&(x + (i % 3) as i32 - 1, z + (i / 3) as i32 - 1));
}
    // rust: self.decorated.insert((x, z));
    // rust: for (i, proto) in region.into_iter().enumerate() {
            // A final chunk keeps its own chunk: only what decoration wrote
            // into it goes there.
    // rust: if finals.contains(&i) {
    // rust: continue;
}
    // rust: let key = (x + (i % 3) as i32 - 1, z + (i / 3) as i32 - 1);
    // rust: self.light_views.remove(&key);
    // rust: self.protos.insert(key, Some(proto));
    // rust: self.written.insert(key);
}
    // rust: for ([bx, by, bz], state) in writes.blocks {
    // rust: let _ = world.set(bx, by, bz, horizon_world::registry::BlockStateId(state));
}
        // After the blocks: the write of a block with a block entity made a
        // default one, which the generated one replaces.
    // rust: for (pos, entity) in writes.block_entities {
    // rust: if world.chunks.contains_key(&(pos.0 >> 4, pos.2 >> 4)) {
    // rust: world.block_entities.insert(pos, entity);
}
}
}
    // Saved proto chunks come back; those now out of range are dropped by
    // the next `update`.
receive_saved :: proc(self: ^Self, protos: Vec<((i32) {
}
    // rust: self.generation_scan.exhausted = false;
    // rust: self.saving -= 1;
    // rust: for (key, proto) in protos {
    // rust: self.light_views.remove(&key);
    // rust: self.protos.insert(key, Some(proto));
}
}
    // Check out the proto chunks at `keys` and save them on a worker.
save_checked_out :: proc(self: ^Self, keys: impl IntoIterator<Item = (i32) {
}
    // rust: let protos: Vec<((i32, i32), Proto)> = keys
    // rust: .into_iter()
    // rust: .filter_map(|k| {
    // rust: let proto = self.protos.get_mut(&k)?.take()?;
    // rust: self.light_views.remove(&k);
    // rust: Some((k, proto))
    // rust: })
    // rust: .collect();
    // rust: if !protos.is_empty() {
    // rust: self.saving += 1;
            // Ahead of every other job: a column generated again meanwhile
            // would not find them saved.
    // rust: self.submit(None, 0, Job::Save(protos));
}
}
receive_generated :: proc(self: ^Self, mut chunk: Chunk, world: ^World) {
}
    // rust: self.generation_scan.exhausted = false;
    // rust: let key = (chunk.x, chunk.z);
    // rust: self.generating.remove(&key);
    // rust: self.finishing.remove(&key);
    // rust: self.decorated.insert(key);
        // A column that finished after the player moved away is dropped
        // whole: its block entities and saved entities too, or they would
        // stay in the world (and the entities spawn again, duplicated, when
        // the column loads later). A generated one is saved first: its
        // neighbours were decorated around it, so generating it again would
        // not give it back.
    // rust: if !self.ranges().chunk_kept(key.0, key.1, self.decorates) {
    // rust: if chunk.fresh {
    // rust: self.dropped_new.insert(key);
    // rust: self.saves.save_finished(chunk);
}
    // rust: return;
}
        // Generated columns are saved like edited ones, as vanilla saves
        // every chunk it generates.
    // rust: if chunk.fresh {
    // rust: world.modified.insert(key);
}
    // rust: world
    // rust: .block_entities
    // rust: .load_chunk(std::mem::take(&mut chunk.block_entities));
    // rust: if let Some(extras) = &chunk.saved {
    // rust: for (pos, attachments) in &extras.block_entity_attachments {
    // rust: world
    // rust: .block_entities
    // rust: .restore_attachments(*pos, attachments.clone());
}
}
    // rust: world
    // rust: .block_names
    // rust: .extend(std::mem::take(&mut chunk.block_names));
    // rust: let entities = std::mem::take(&mut chunk.entities);
    // rust: if !entities.is_empty() {
    // rust: world.loaded_entities.push(((chunk.x, chunk.z), entities));
}
    // rust: self.generated_total += 1;
        // A chunk saved with its light needs no light job; its unlit
        // neighbours still light themselves from it.
    // rust: let loaded = chunk.light_loaded;
    // rust: let new = self.dropped_new.remove(&key) || chunk.generated;
    // rust: world.loaded_chunks.push((key.0, key.1, new));
    // rust: world.chunks.insert(key, Arc::new(chunk));
    // rust: if loaded {
    // rust: self.lit.insert(key);
    // rust: for sy in 0..world.layout().sections() as i32 {
    // rust: world.dirty_sections.insert((key.0, sy, key.1));
}
}
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: let n = (key.0 + dx, key.1 + dz);
    // rust: if !loaded || world.chunks.get(&n).is_some_and(|c| !c.light_loaded) {
    // rust: world.dirty_light.insert(n);
}
}
}
}
    // The order jobs around the player run in, lowest first.
distance :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.ranges().priority(x, z)
}
    // The 3x3 a light job reads: the finished columns, and for a neighbour
    // that will not finish (past the area), its decorated proto chunk, as
    // vanilla lights its last FULL ring against neighbours at FEATURES.
    // A proto neighbour without its view yet is checked out to a worker,
    // which builds the view off the server thread (`Job::LightView`); the
    // region is asked for again once it is back.
light_region :: proc(self: ^Self, world: ^World, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut region: Region = Default::default();
    // rust: let mut complete = true;
    // rust: for dz in 0..3 {
    // rust: for dx in 0..3 {
    // rust: let n = (x + dx as i32 - 1, z + dz as i32 - 1);
    // rust: region[dz][dx] = match world.chunks.get(&n) {
    // rust: Some(chunk) => Some(chunk.clone()),
    // rust: None if !self.in_range(n.0, n.1, 1) && self.decorated.contains(&n) => {
    // rust: if let Some(view) = self.light_views.get(&n) {
    // rust: Some(view.clone())
    // rust: } else {
    // rust: let proto = self.protos.get_mut(&n)?.take()?;
    // rust: self.viewing.insert(n);
    // rust: self.submit(Some((x, z)), 0, Job::LightView(n.0, n.1, proto));
    // rust: complete = false;
    // rust: None
}
}
    // rust: None => return None,
}
}
}
    // rust: complete.then(|| Box::new(region))
}
    // A proto chunk back from its light view: the view waits in
    // `light_views` for the light jobs that asked for it.
receive_light_view :: proc(self: ^Self, x: i32, z: i32, proto: Proto, view: Maybe(Chunk)) {
}
    // rust: self.viewing.remove(&(x, z));
    // rust: self.protos.insert((x, z), Some(proto));
    // rust: if let Some(view) = view {
    // rust: self.light_views.insert((x, z), Arc::new(view));
}
}
    // Whether `light_region` would find all nine columns: the same walk
    // without building the snapshot, so the scheduler can rank the ready
    // columns before any region is cloned. A proto neighbour whose light
    // view turns out empty is skipped when its region is built, and asked
    // for again, as `light_region` returning `None` always was.
light_region_ready :: proc(self: ^Self, world: ^World, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: light_region_ready(
    // rust: world,
    // rust: |x, z| self.in_range(x, z, 1),
    // rust: &self.decorated,
    // rust: &self.protos,
    // rust: x,
    // rust: z,
    // rust: )
}
region :: proc(world: ^World, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut region: Region = Default::default();
    // rust: for dz in 0..3 {
    // rust: for dx in 0..3 {
    // rust: region[dz][dx] = Some(
    // rust: world
    // rust: .chunks
    // rust: .get(&(x + dx as i32 - 1, z + dz as i32 - 1))?
    // rust: .clone(),
    // rust: );
}
}
    // rust: Some(Box::new(region))
}
is_lit :: proc(self: ^Self, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.lit.contains(&(x, z))
}
    // The non-air sections of a column that is a decorated proto chunk
    // here (vanilla's INITIALIZE_LIGHT and on), if it is one: a level
    // chunk's light layers count them (#4294).
proto_sections :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.decorated.contains(&(x, z)) {
    // rust: return None;
}
    // rust: (self.non_air_sections)(self.protos.get(&(x, z))?.as_ref()?)
}
    // `ChunkMap.getLatestStatus` for the loading screen's chunk map: the
    // furthest step this column has reached, `None` before it is asked for.
    // rust: pub fn latest_status(
    // rust: &self,
    // rust: world: &World,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Option<crate::level_loading::Status> {
//         use crate::level_loading::Status;
    // rust: let key = (x, z);
    // rust: Some(if self.lit.contains(&key) {
    // rust: Status::Full
    // rust: } else if world.chunks.contains_key(&key) {
    // rust: Status::InitializeLight
    // rust: } else if self.decorated.contains(&key) || self.finishing.contains(&key) {
    // rust: Status::Features
    // rust: } else if self.protos.contains_key(&key) {
    // rust: Status::Terrain
    // rust: } else if self.generating.contains(&key) {
    // rust: Status::Empty
    // rust: } else {
    // rust: return None;
    // rust: })
}
    // The sequence the next mesh job will be dispatched after: a clock for
    // `compile_start`, whose jobs all snapshot the world as they are
    // dispatched (`Util.getNanos()` at the start of a compile task).
sequence :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.sequence
}
    // When the section's latest accepted mesh started compiling, on the
    // `sequence` clock (`CompiledSectionMesh.getCompileTaskStartTime`).
compile_start :: proc(self: ^Self, section: (i32) {
}
    // rust: self.compile_started.get(&section).copied()
}
is_meshing :: proc(self: ^Self, section: (i32) {
}
    // rust: self.meshing.contains_key(&section)
}
pending :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.shared.queue.lock().unwrap().len()
}
    // Whether any chunk is queued or on its way from generation to a mesh.
busy :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.chunks_in_flight() || !self.meshing.is_empty() || self.pending() != 0
}
    // Whether the near terrain is still coming in: chunks generating,
    // decorating, finishing or being lit (or their neighbours' light views),
    // or sections meshing for the first time. Each of those is counted from
    // when its job is queued, so queued jobs need no separate count.
    // Remeshing sections already drawn (block, light and fluid updates) is
    // not loading: it kept small machines' far terrain held back
    // (`Lod::set_near_loading`) for as long as anything nearby changed.
terrain_loading :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.chunks_in_flight()
    // rust: || self
    // rust: .meshing
    // rust: .keys()
    // rust: .any(|section| !self.compile_started.contains_key(section))
}
chunks_in_flight :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !(self.generating.is_empty()
    // rust: && self.decorating == 0
    // rust: && self.viewing.is_empty()
    // rust: && self.finishing.is_empty()
    // rust: && self.lighting.is_empty())
}
    // The proto chunks held (not checked out): how many, their heap bytes by
    // part and their sections by bits per block; and the light views of
    // them with their bytes. For `horizon-ctl memory`.
proto_census :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut census = ProtoCensus::default();
    // rust: for proto in self.protos.values().flatten() {
    // rust: let (bytes, bits) = (self.proto_bytes)(proto);
    // rust: census.protos += 1;
    // rust: for (sum, b) in census.bytes.iter_mut().zip(bytes) {
    // rust: *sum += b;
}
    // rust: for (sum, b) in census.sections_by_bits.iter_mut().zip(bits) {
    // rust: *sum += b;
}
}
    // rust: census.light_views = self.light_views.len();
    // rust: census.light_view_bytes = self.light_views.values().map(|v| v.heap_bytes()).sum();
    // rust: census.caches = (self.caches)();
    // rust: census
}
    // How much work each stage holds: queued jobs, then what is in flight or
    // waiting at each step from generation to meshing.
stages :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: ("queued", self.pending()),
    // rust: ("generating", self.generating.len()),
    // rust: (
    // rust: "protos",
    // rust: self.protos.values().filter(|p| p.is_some()).count(),
    // rust: ),
    // rust: ("decorating", self.decorating),
    // rust: ("finishing", self.finishing.len()),
    // rust: ("lighting", self.lighting.len()),
    // rust: ("meshing", self.meshing.len()),
    // rust: ]
}
    // Advance streaming: collect finished work, then schedule more.
    // Returns meshes ready for upload and columns that were unloaded.
    // rust: pub fn update(
    // rust: &mut self,
    // rust: world: &mut World,
    // rust: ) -> (Vec<((i32, i32, i32), SectionMesh)>, Vec<Arc<Chunk>>) {
    // rust: let mut uploads = Vec::new();
    // rust: if self.paused {
    // rust: return (uploads, Vec::new());
}
    // rust: ExtraCover::refresh(&mut self.cover, &self.extra);
        // The sweeps below walk every loaded column and proto chunk. Run them
        // at once when the view moves and every eighth tick otherwise: a
        // column can stay a little past the edge without anyone noticing.
    // rust: let area = (self.center, self.radius);
    // rust: let sweep = area != self.scan_area || self.scan_age >= 8;
    // rust: self.scan_area = area;
    // rust: self.scan_age = if sweep { 0 } else { self.scan_age + 1 };
    // rust: self.requeue();
    // rust: self.relight_edits(world);
    // rust: let deferred = std::mem::take(&mut self.deferred);
    // rust: let received = self.shared.done.take();
        // Meshes made stale meanwhile, freed with the uploaded ones (`free`).
    // rust: let mut stale = Vec::new();
    // rust: for done in deferred.into_iter().chain(received) {
    // rust: match done {
    // rust: Done::Proto(x, z, proto, decorated) => {
    // rust: self.generation_scan.exhausted = false;
    // rust: self.generating.remove(&(x, z));
    // rust: if self.in_range(x, z, 4) || self.near_finished(x, z, 2) {
    // rust: self.light_views.remove(&(x, z));
    // rust: self.protos.insert((x, z), Some(proto));
    // rust: if decorated || !self.decorates {
    // rust: self.decorated.insert((x, z));
}
}
}
    // rust: Done::Decorated(x, z, region, finals, writes) => {
    // rust: self.receive_decorated(x, z, *region, finals, writes, world)
}
    // rust: Done::Generated(chunk) => self.receive_generated(chunk, world),
    // rust: Done::Saved(protos) => self.receive_saved(protos),
    // rust: Done::LightView(x, z, proto, view) => self.receive_light_view(x, z, proto, view),
    // rust: Done::Lit(x, z, sections, seq) => {
    // rust: if self.lighting.get(&(x, z)) != Some(&seq) {
    // rust: continue;
}
    // rust: self.lighting.remove(&(x, z));
    // rust: let snapshot = self.light_snapshots.remove(&(x, z)).unwrap_or(u64::MAX);
    // rust: if let Some(chunk) = world.chunks.get_mut(&(x, z)) {
    // rust: let chunk = Arc::make_mut(chunk);
                        // Keep blocks edited since the snapshot; take only light.
                        // A chunk relit (a neighbour loaded or changed) remeshes
                        // only around the light that changed, as vanilla's light
                        // updates dirty only their sections (#270).
    // rust: let first = self.lit.insert((x, z));
    // rust: let mut changed = LightChanges::default();
    // rust: if first {
    // rust: apply_lighting(chunk, sections);
    // rust: } else {
    // rust: apply_relighting(chunk, sections, &mut changed);
}
                        // Saved unlit (at the edge of what was loaded), or its light
                        // changed: saved again.
    // rust: if (first && !chunk.light_loaded) || !changed.is_empty() {
    // rust: world.modified.insert((x, z));
}
    // rust: chunk.lit = true;
    // rust: if first {
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: for sy in 0..world.layout().sections() as i32 {
    // rust: world.dirty_sections.insert((x + dx, sy, z + dz));
}
}
}
    // rust: } else {
    // rust: Self::mark_light_changes(world, &changed);
}
    // rust: self.replay_light_edits(world, x, z, snapshot);
}
}
    // rust: Done::Meshed(x, sy, z, mesh, seq) => {
    // rust: if self.meshing.get(&(x, sy, z)) != Some(&seq) {
    // rust: stale.push(((x, sy, z), mesh));
    // rust: continue;
}
                    // Its column unloaded while it was meshed: nothing would
                    // ever remove the uploaded section.
    // rust: if !world.chunks.contains_key(&(x, z)) {
    // rust: self.meshing.remove(&(x, sy, z));
    // rust: stale.push(((x, sy, z), mesh));
    // rust: continue;
}
    // rust: self.meshing.remove(&(x, sy, z));
    // rust: self.compile_started.insert((x, sy, z), seq);
    // rust: self.meshed_total += 1;
    // rust: uploads.push(((x, sy, z), mesh));
}
}
}
    // rust: self.free(stale);
    // rust: let mut removed = Vec::new();
    // rust: if sweep {
            // Unload far columns.
    // rust: let far: Vec<_> = world
    // rust: .chunks
    // rust: .keys()
    // rust: .copied()
    // rust: .filter(|&(x, z)| !self.remote && self.ranges().unloaded(x, z, self.decorates))
    // rust: .collect();
    // rust: for key in &far {
    // rust: self.decorated.remove(key);
}
    // rust: removed.reserve(far.len());
    // rust: for key in &far {
    // rust: if let Some(chunk) = world.chunks.remove(key) {
    // rust: removed.push(chunk);
}
    // rust: self.lit.remove(key);
    // rust: self.meshed.remove(key);
    // rust: self.lighting.remove(key);
    // rust: self.light_snapshots.remove(key);
}
    // rust: if !far.is_empty() {
    // rust: let far: HashSet<(i32, i32)> = far.iter().copied().collect();
    // rust: self.meshing.retain(|k, _| !far.contains(&(k.0, k.2)));
    // rust: self.compile_started
    // rust: .retain(|k, _| !far.contains(&(k.0, k.2)));
    // rust: self.waiting.retain(|k| !far.contains(&(k.0, k.2)));
    // rust: world
    // rust: .dirty_sections
    // rust: .retain_columns(|x, z| !far.contains(&(x, z)));
}
            // Drop far proto chunks that are not checked out.
    // rust: let (center, r4) = (self.center, i64::from(self.radius + 4));
    // rust: let ranges = self.ranges();
    // rust: let far: Vec<(i32, i32)> = self
    // rust: .protos
    // rust: .iter()
    // rust: .filter(|&(&(x, z), p)| {
    // rust: p.is_some()
    // rust: && (self.radius < 0
    // rust: || i64::from(x - center.0).pow(2) + i64::from(z - center.1).pow(2)
    // rust: > r4 * r4)
    // rust: && !ranges.in_extra(x, z, 4)
    // rust: && !ranges.in_band(x, z, 4)
    // rust: && !ranges.forced_chunks().any(|f| {
    // rust: (x - f.0).abs() <= FORCED_TERRAIN_RING
    // rust: && (z - f.1).abs() <= FORCED_TERRAIN_RING
    // rust: })
    // rust: })
    // rust: .map(|(k, _)| *k)
    // rust: .collect();
    // rust: if !far.is_empty() {
    // rust: self.generation_scan.invalidate();
}
            // Those decoration wrote to are saved first (see
            // `ChunkGenerator::save_protos`), and dropped once back.
    // rust: let mut written = Vec::new();
    // rust: for key in far {
    // rust: if self.written.remove(&key) {
    // rust: written.push(key);
    // rust: } else {
    // rust: self.protos.remove(&key);
    // rust: self.light_views.remove(&key);
}
}
    // rust: self.save_checked_out(written);
}
    // rust: let (protos, finishing) = (&self.protos, &self.finishing);
    // rust: self.decorated.retain(|k| {
    // rust: protos.contains_key(k) || finishing.contains(k) || world.chunks.contains_key(k)
    // rust: });
        // Finalize chunks whose neighbourhood is decorated.
    // rust: let candidates: Vec<(i32, i32)> = self.protos.keys().copied().collect();
    // rust: for (x, z) in candidates {
    // rust: if world.chunks.contains_key(&(x, z))
    // rust: || self.finishing.contains(&(x, z))
    // rust: || !self.in_range(x, z, 1)
    // rust: {
    // rust: continue;
}
    // rust: let ready = (-1..=1).all(|dz| {
    // rust: (-1..=1).all(|dx| {
    // rust: self.decorated.contains(&(x + dx, z + dz))
    // rust: || world.chunks.contains_key(&(x + dx, z + dz))
    // rust: })
    // rust: });
    // rust: if ready && let Some(Some(_)) = self.protos.get(&(x, z)) {
    // rust: let proto = self
    // rust: .protos
    // rust: .remove(&(x, z))
    // rust: .flatten()
    // rust: .expect("present proto");
    // rust: self.light_views.remove(&(x, z));
    // rust: self.finishing.insert((x, z));
    // rust: self.written.remove(&(x, z));
    // rust: self.submit(Some((x, z)), 0, Job::Finish(proto));
}
}
        // Decorate chunks whose 3x3 proto neighbourhood is available, in
        // vanilla's order: decoration is order dependent where write regions
        // overlap (see `DecorationOrder`).
    // rust: let workers = self.workers;
    // rust: if self.decorates && self.order_area != Some((self.center, self.radius)) {
    // rust: let (decorated, chunks) = (&self.decorated, &world.chunks);
            // The render distance is the server view distance in singleplayer.
    // rust: self.decoration_order
    // rust: .reassign(self.center, self.radius, |x, z| {
    // rust: decorated.contains(&(x, z)) || chunks.contains_key(&(x, z))
    // rust: });
    // rust: self.order_area = Some((self.center, self.radius));
    // rust: let ranges = Ranges {
    // rust: center: self.center,
    // rust: radius: self.radius,
    // rust: extra: &self.extra,
    // rust: forced: &self.forced,
    // rust: mod_forced: &self.mod_forced,
    // rust: cover: ExtraCover::matching(&self.cover, &self.extra),
    // rust: band: self.band.as_ref(),
}
    // rust: let (protos, generating) = (&self.protos, &self.generating);
    // rust: self.decoration_order.retain(|x, z| {
    // rust: ranges.in_range(x, z, 4)
    // rust: || ranges.near_finished(x, z, 2)
    // rust: || protos.contains_key(&(x, z))
    // rust: || generating.contains(&(x, z))
    // rust: });
}
    // rust: if self.decorates && self.decorating < workers * 2 {
    // rust: let wants = |s: &Self, x: i32, z: i32| {
    // rust: !s.decorated.contains(&(x, z))
    // rust: && !world.chunks.contains_key(&(x, z))
    // rust: && (s.in_range(x, z, 2) || s.near_finished(x, z, 1))
}
            // A wanted chunk holds back higher-ranked ones only if it can be
            // decorated: its 3x3 neighbourhood is (or will be) generated as
            // protos, none of them already final.
    // rust: let waits_for = |s: &Self, x: i32, z: i32| {
    // rust: wants(s, x, z)
    // rust: && (-1..=1).all(|dz| {
    // rust: (-1..=1).all(|dx| {
    // rust: let n = (x + dx, z + dz);
    // rust: !world.chunks.contains_key(&n)
    // rust: && (s.protos.contains_key(&n)
    // rust: || s.generating.contains(&n)
    // rust: || s.ranges().requested(n.0, n.1, true))
    // rust: })
    // rust: })
}
    // rust: let keys: Vec<(i32, i32)> = self
    // rust: .protos
    // rust: .iter()
    // rust: .filter(|(k, p)| p.is_some() && wants(self, k.0, k.1))
    // rust: .map(|(k, _)| *k)
    // rust: .collect();
    // rust: let mut wanted: Vec<(u64, i64, i32, i32)> = keys
    // rust: .into_iter()
    // rust: .map(|(x, z)| (0, self.distance(x, z), x, z))
    // rust: .collect();
            // Chunks no ticket reached (forced and extra areas) go last, nearest first.
    // rust: wanted.sort_unstable_by_key(|w| w.1);
    // rust: for w in &mut wanted {
    // rust: w.0 = self.decoration_order.rank_or_append(w.2, w.3);
}
    // rust: wanted.sort_unstable();
            // Most wanted chunks are blocked, and the same neighbours are
            // asked about for each of them: what `waits_for` says is kept for
            // the pass (nothing it reads changes in it but `decorated`, which
            // updates the entry). Without it, scheduling at render distance 32
            // took most of the thread that runs it while the world loaded.
    // rust: let waiting: std::cell::RefCell<FxHashMap<(i32, i32), bool>> = Default::default();
    // rust: for (_, _, x, z) in wanted {
    // rust: if self.decorating >= workers * 2 {
    // rust: break;
}
    // rust: if self.decoration_order.blocked(x, z, |nx, nz| {
    // rust: if let Some(&known) = waiting.borrow().get(&(nx, nz)) {
    // rust: return known;
}
    // rust: let known = waits_for(self, nx, nz);
    // rust: waiting.borrow_mut().insert((nx, nz), known);
    // rust: known
    // rust: }) {
    // rust: continue;
}
    // rust: let keys: Vec<(i32, i32)> =
    // rust: (0..9).map(|i| (x + (i % 3) - 1, z + (i / 3) - 1)).collect();
                // A final neighbour cannot be generated again: a generator that
                // can decorates beside it (a chunk of an older world), writing
                // into it as vanilla's features do; the others skip decoration
                // (worlds saved before proto chunks were saved get here: their
                // final chunks' neighbours are generated again).
    // rust: if keys.iter().any(|k| self.decorating_finals.contains(k)) {
    // rust: continue;
}
    // rust: let finals: Vec<(usize, Chunk)> = keys
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, k)| Some((i, (**world.chunks.get(k)?).clone())))
    // rust: .collect();
    // rust: if !finals.is_empty() && !self.saves_beside_final {
    // rust: self.decorated.insert((x, z));
    // rust: waiting.borrow_mut().insert((x, z), false);
    // rust: continue;
}
    // rust: if !keys.iter().enumerate().all(|(i, k)| {
    // rust: finals.iter().any(|(f, _)| *f == i)
    // rust: || matches!(self.protos.get(k), Some(Some(_)))
    // rust: }) {
    // rust: continue;
}
    // rust: let region: Vec<Proto> = keys
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, k)| {
    // rust: if finals.iter().any(|(f, _)| *f == i) {
    // rust: return Box::new(()) as Proto;
}
    // rust: self.light_views.remove(k);
    // rust: self.protos
    // rust: .insert(*k, None)
    // rust: .flatten()
    // rust: .expect("present proto")
    // rust: })
    // rust: .collect();
    // rust: let region: Box<[Proto; 9]> = match region.try_into() {
    // rust: Ok(r) => Box::new(r),
    // rust: Err(_) => continue,
}
    // rust: self.decorating += 1;
    // rust: self.decorating_finals
    // rust: .extend(finals.iter().map(|(i, _)| keys[*i]));
    // rust: self.submit(Some((x, z)), 1, Job::Decorate(x, z, region, finals));
}
}
    // rust: self.schedule_generation(world, workers);
        // Lighting once all neighbours exist, nearest first and only as
        // much of it as the workers can chew. Vanilla's light engine also
        // hands a bounded queue to its workers and reschedules what did
        // not fit by distance; submitted whole, the light jobs of every
        // unlit column at once — each carrying a 3x3 region snapshot —
        // grew with the render distance and outlived the columns they
        // were queued for (#3629). What stays in `dirty_light` is asked
        // for again, from the current centre, as capacity frees.
    // rust: let mut light: Vec<(i64, i32, i32)> = Vec::new();
    // rust: let mut gone: Vec<(i32, i32)> = Vec::new();
    // rust: for &(x, z) in world.dirty_light.iter() {
    // rust: if !world.chunks.contains_key(&(x, z)) {
    // rust: gone.push((x, z));
    // rust: } else if self.light_region_ready(world, x, z) {
    // rust: light.push((self.distance(x, z), x, z));
}
}
    // rust: for key in gone {
    // rust: world.dirty_light.remove(&key);
}
    // rust: let room = (self.workers * 4).saturating_sub(self.lighting.len());
    // rust: nearest_first(&mut light, room);
    // rust: for (_, x, z) in light {
    // rust: let Some(region) = self.light_region(world, x, z) else {
    // rust: continue;
}
    // rust: world.dirty_light.remove(&(x, z));
    // rust: self.sequence += 1;
    // rust: self.lighting.insert((x, z), self.sequence);
    // rust: self.light_snapshots
    // rust: .insert((x, z), self.light_edit_sequence);
    // rust: self.submit(
    // rust: Some((x, z)),
    // rust: 1,
    // rust: Job::Light(x, z, region, self.sequence, self.sky_light),
    // rust: );
}
        // A server draws nothing: its sections are never meshed.
    // rust: if !self.mesh {
    // rust: world.dirty_sections.clear();
    // rust: return (uploads, removed);
}
        // Meshing once the column and its neighbours are lit, and the column
        // is within the render distance (`in_view_distance`, the columns
        // vanilla draws). Sections set aside past it come back
        // when the player moves: a column that loads with its light gets no
        // other request (#228).
    // rust: let area = (
    // rust: self.center,
    // rust: self.radius,
    // rust: self.forced.len() + self.mod_forced.len(),
    // rust: );
    // rust: if self.waiting_area != area {
    // rust: self.waiting_area = area;
    // rust: let ranges = Ranges {
    // rust: center: self.center,
    // rust: radius: self.radius,
    // rust: extra: &self.extra,
    // rust: forced: &self.forced,
    // rust: mod_forced: &self.mod_forced,
    // rust: cover: ExtraCover::matching(&self.cover, &self.extra),
    // rust: band: self.band.as_ref(),
}
    // rust: self.waiting.retain(|&(x, sy, z)| {
    // rust: let back = ranges.in_view(x, z);
    // rust: if back {
    // rust: world.dirty_sections.insert((x, sy, z));
}
    // rust: !back
    // rust: });
}
        // Column by column: the checks below hold for all of a column's
        // sections, and columns waiting for light cost one look per frame.
    // rust: let mut candidates: Vec<(i64, i32, i32, SectionMask)> = Vec::new();
    // rust: let columns: Vec<_> = world.dirty_sections.columns().collect();
    // rust: for ((x, z), sections) in columns {
    // rust: if !world.chunks.contains_key(&(x, z)) {
    // rust: world.dirty_sections.take_column(x, z);
    // rust: continue;
}
    // rust: if !self.ranges().in_view(x, z) {
    // rust: world.dirty_sections.take_column(x, z);
    // rust: for sy in sections.iter().map(|sy| sy as i32) {
    // rust: self.waiting.insert((x, sy, z));
}
    // rust: continue;
}
            // A neighbour being lit dirties this column again when its light
            // job finishes (new chunks relight their eight neighbours), so
            // wait for it rather than mesh once per neighbour. Columns still
            // in `dirty_light` here can't be lit yet (a neighbour of theirs is
            // missing): waiting for them could last until the player comes
            // back.
    // rust: let ready = (-1..=1).all(|dz| {
    // rust: (-1..=1).all(|dx| {
    // rust: let n = (x + dx, z + dz);
    // rust: self.lit.contains(&n) && !self.lighting.contains_key(&n)
    // rust: })
    // rust: });
    // rust: if !ready {
    // rust: continue;
}
    // rust: candidates.push((self.distance(x, z), x, z, sections));
}
        // Nearest first, and only as many sections as the workers can chew.
        // Every ready column used to be submitted at once, so at a wide
        // render distance the queue — and `meshing`, and each job's 3x3
        // region snapshot — grew with the number of loaded columns and the
        // jobs went stale long before a worker reached them (#3629). What
        // stays dirty is asked for again, from the current centre, as
        // capacity frees; `requeue` then has a small queue to keep close.
    // rust: let room = (self.workers * 32).saturating_sub(self.meshing.len());
    // rust: nearest_first(&mut candidates, room);
    // rust: for (_, x, z, sections) in candidates {
    // rust: let Some(region) = Self::region(world, x, z) else {
    // rust: continue;
}
    // rust: world.dirty_sections.take_column(x, z);
    // rust: for sy in sections.iter().map(|sy| sy as i32) {
    // rust: let first = self.meshed.insert((x, z));
    // rust: self.sequence += 1;
    // rust: self.meshing.insert((x, sy, z), self.sequence);
    // rust: self.submit(
    // rust: Some((x, z)),
    // rust: if first { 2 } else { 0 },
    // rust: Job::Mesh(
    // rust: x,
    // rust: sy,
    // rust: z,
    // rust: region.clone(),
    // rust: self.sequence,
    // rust: MeshSettings {
    // rust: nether: self.nether_shading,
    // rust: shader_pack_lighting: self.shader_pack_lighting,
    // rust: separate_ao: self.separate_ao,
    // rust: shader_pack: self.shader_pack,
    // rust: zoom: self.biome_zoom,
    // rust: blend_radius: self.biome_blend,
    // rust: smooth_lighting: self.smooth_lighting,
    // rust: cutout_leaves: self.cutout_leaves,
    // rust: translucent_layers: self.translucent_layers.clone(),
    // rust: leaf_culling: self.leaf_culling,
    // rust: },
    // rust: ),
    // rust: );
}
}
    // rust: (uploads, removed)
}
schedule_generation :: proc(self: ^Self, world: ^World, workers: uint) {
}
    // rust: let input = GenerationInputs {
    // rust: ranges: Ranges {
    // rust: center: self.center,
    // rust: radius: self.radius,
    // rust: extra: &self.extra,
    // rust: forced: &self.forced,
    // rust: mod_forced: &self.mod_forced,
    // rust: cover: ExtraCover::matching(&self.cover, &self.extra),
    // rust: band: self.band.as_ref(),
    // rust: },
    // rust: world,
    // rust: generating: &self.generating,
    // rust: protos: &self.protos,
    // rust: finishing: &self.finishing,
    // rust: decorates: self.decorates,
    // rust: remote: self.remote,
}
    // rust: if let Some(wanted) = self.generation_scan.candidates(input, workers * 3) {
    // rust: for (_, x, z) in wanted {
    // rust: self.generating.insert((x, z));
    // rust: self.submit(Some((x, z)), 0, Job::Generate(x, z));
}
}
}
    // Relight block edits on lit chunks in place (vanilla's incremental light
    // engine) instead of recomputing the 3x3 chunks around each edit.
relight_edits :: proc(self: ^Self, world: ^World) {
}
    // rust: if world.light_edits.is_empty() {
    // rust: return;
}
    // rust: let edits = std::mem::take(&mut world.light_edits);
    // rust: let positions: Vec<(i32, i32, i32)> = edits
    // rust: .iter()
    // rust: .filter(|(_, old, new)| self.light_tables.differs(*old, *new))
    // rust: .map(|(p, _, _)| *p)
    // rust: .collect();
    // rust: if positions.is_empty() {
    // rust: return;
}
    // rust: let positions = if positions.len() > INLINE_RELIGHT_MAX {
    // rust: self.relight_on_workers(world, positions)
    // rust: } else {
    // rust: positions
}
    // rust: if positions.is_empty() {
    // rust: return;
}
    // rust: let mut changed = LightChanges::default();
    // rust: crate::light::relight(
    // rust: &mut world.chunks,
    // rust: &self.light_tables,
    // rust: self.sky_light,
    // rust: &positions,
    // rust: false,
    // rust: &mut changed,
    // rust: );
    // rust: Self::mark_light_changes(world, &changed);
    // rust: Self::relight_beside_unlit(world, &changed);
    // rust: if !self.light_snapshots.is_empty() {
    // rust: for p in positions {
    // rust: self.light_edit_sequence += 1;
    // rust: self.light_log.push((self.light_edit_sequence, p));
}
}
}
    // Hands a big batch of edits (a `/fill` arriving block by block) to the
    // workers: the columns they touch and their neighbours get full light
    // jobs, as `World::edit_runs` does, instead of relighting every changed
    // cell in the frame (clearing a 64x64x16 volume in the air relit the
    // sky below it: 43 ms of one frame). The sections wait for those jobs
    // before they are meshed again. Returns the edits left to light in the
    // frame: those in columns that can't be lit whole yet (the edge of the
    // loaded area).
    // rust: fn relight_on_workers(
    // rust: &self,
    // rust: world: &mut World,
    // rust: positions: Vec<(i32, i32, i32)>,
    // rust: ) -> Vec<(i32, i32, i32)> {
    // rust: let (columns, inline) = whole_relight_columns(positions, |x, z| {
    // rust: self.lit.contains(&(x, z)) && self.light_region_ready(world, x, z)
    // rust: });
    // rust: world.dirty_light.extend(columns);
    // rust: inline
}
    // A light job computed from blocks older than some edits: redo those
    // edits on top of its result.
replay_light_edits :: proc(self: ^Self, world: ^World, x: i32, z: i32, snapshot: u64) {
}
    // rust: let positions: Vec<(i32, i32, i32)> = self
    // rust: .light_log
    // rust: .iter()
    // rust: .filter(|(seq, p)| {
    // rust: *seq > snapshot && ((p.0 >> 4) - x).abs() <= 1 && ((p.2 >> 4) - z).abs() <= 1
    // rust: })
    // rust: .map(|(_, p)| *p)
    // rust: .collect();
    // rust: if !positions.is_empty() {
    // rust: let mut changed = LightChanges::default();
    // rust: crate::light::relight(
    // rust: &mut world.chunks,
    // rust: &self.light_tables,
    // rust: self.sky_light,
    // rust: &positions,
    // rust: true,
    // rust: &mut changed,
    // rust: );
    // rust: Self::mark_light_changes(world, &changed);
    // rust: Self::relight_beside_unlit(world, &changed);
}
    // rust: let oldest = self.light_snapshots.values().copied().min();
    // rust: match oldest {
    // rust: Some(oldest) => self.light_log.retain(|(seq, _)| *seq > oldest),
    // rust: None => self.light_log.clear(),
}
}
    // A column whose light an edit changed beside a column not lit yet gets
    // a full light job ([`crate::light::beside_unlit`]).
relight_beside_unlit :: proc(world: ^World, changed: ^LightChanges) {
}
    // rust: let columns = crate::light::beside_unlit(changed, |x, z| {
    // rust: world.chunks.get(&(x, z)).is_some_and(|c| !c.lit)
    // rust: });
    // rust: world.dirty_light.extend(columns);
}
    // Sections whose meshes sample a changed light value (faces and corners
    // read light from neighbouring blocks).
mark_light_changes :: proc(world: ^World, changed: ^LightChanges) {
}
    // rust: if let Some(log) = &mut world.light_log {
    // rust: for (x, sy, z) in changed.sections() {
    // rust: log.entry((x, z)).or_default().insert(sy as usize);
}
}
    // rust: changed.dirty_sections(|section| {
    // rust: world.dirty_sections.insert(section);
    // rust: });
}
ranges :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ranges {
    // rust: center: self.center,
    // rust: radius: self.radius,
    // rust: extra: &self.extra,
    // rust: forced: &self.forced,
    // rust: mod_forced: &self.mod_forced,
    // rust: cover: ExtraCover::matching(&self.cover, &self.extra),
    // rust: band: self.band.as_ref(),
}
}
near_finished :: proc(self: ^Self, x: i32, z: i32, reach: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.ranges().near_finished(x, z, reach)
}
    // Abort unvisited background chunk generation, decoration, and meshing on world exit.
abort_generation :: proc(self: ^Self) {
}
    // rust: self.shared
    // rust: .aborted
    // rust: .store(true, std::sync::atomic::Ordering::SeqCst);
    // rust: if let Ok(mut queue) = self.shared.queue.lock() {
    // rust: let mut saves = Vec::new();
    // rust: for item in std::mem::take(&mut *queue).into_vec() {
    // rust: if matches!(item.job, Job::Save(..)) {
    // rust: saves.push(item);
}
}
    // rust: *queue = std::collections::BinaryHeap::from(saves);
}
    // rust: self.generating.clear();
    // rust: self.decorating = 0;
    // rust: self.decorating_finals.clear();
    // rust: self.finishing.clear();
    // rust: self.viewing.clear();
    // rust: self.waiting.clear();
    // rust: self.meshing.clear();
    // rust: self.lighting.clear();
    // rust: self.jobs.notify_all();
}
    // Save what generation holds outside the world: the proto chunks
    // decoration wrote to. With `wait`, the decorations, columns and saves
    // in flight are waited for first (their proto chunks are out in the
    // jobs) and the protos are saved here, before the world's chunks;
    // otherwise a worker saves them (vanilla's autosave hands its chunks to
    // the IOWorker too), and those out in jobs are saved later, as they
    // unload or at the next save.
save :: proc(self: ^Self, world: ^World, wait: bool) {
}
    // rust: if !wait {
    // rust: let written: Vec<(i32, i32)> = self.written.drain().collect();
    // rust: self.save_checked_out(written);
    // rust: return;
}
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(30);
    // rust: let aborted = self
    // rust: .shared
    // rust: .aborted
    // rust: .load(std::sync::atomic::Ordering::Relaxed);
    // rust: while (self.saving > 0)
    // rust: || (!aborted
    // rust: && (self.decorating > 0 || !self.finishing.is_empty() || !self.viewing.is_empty()))
    // rust: {
    // rust: let left = deadline.saturating_duration_since(std::time::Instant::now());
    // rust: match self.shared.done.recv_timeout(left) {
    // rust: Some(Done::Decorated(x, z, region, finals, writes)) => {
    // rust: self.receive_decorated(x, z, *region, finals, writes, world)
}
    // rust: Some(Done::Generated(chunk)) => self.receive_generated(chunk, world),
    // rust: Some(Done::Saved(protos)) => self.receive_saved(protos),
    // rust: Some(Done::LightView(x, z, proto, view)) => {
    // rust: self.receive_light_view(x, z, proto, view)
}
    // rust: Some(other) => self.deferred.push(other),
    // rust: None => {
    // rust: log::warn!("Horizon: chunk generation did not finish before saving");
    // rust: break;
}
}
}
    // rust: let protos: Vec<&Proto> = self
    // rust: .written
    // rust: .iter()
    // rust: .filter_map(|k| self.protos.get(k)?.as_ref())
    // rust: .collect();
    // rust: if !protos.is_empty() {
    // rust: self.saves.save_protos(&protos);
}
    // rust: self.written.clear();
}
    // Finish generation for a closing world without waiting on the event
    // loop. No new generation is scheduled while the save screen is shown.
    // Proto snapshots are checked out to workers before chunk writes, just as
    // in `save(true)`, so older generation cannot overwrite the final chunks.
poll_save :: proc(self: ^Self, world: ^World) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let started = std::time::Instant::now();
    // rust: while let Some(done) = self.shared.done.try_recv() {
    // rust: match done {
    // rust: Done::Decorated(x, z, region, finals, writes) => {
    // rust: self.receive_decorated(x, z, *region, finals, writes, world)
}
    // rust: Done::Generated(chunk) => self.receive_generated(chunk, world),
    // rust: Done::Saved(protos) => self.receive_saved(protos),
    // rust: Done::LightView(x, z, proto, view) => self.receive_light_view(x, z, proto, view),
    // rust: other => self.deferred.push(other),
}
    // rust: if started.elapsed() >= std::time::Duration::from_millis(2) {
    // rust: return false;
}
}
    // rust: let aborted = self
    // rust: .shared
    // rust: .aborted
    // rust: .load(std::sync::atomic::Ordering::Relaxed);
    // rust: if (self.saving > 0)
    // rust: || (!aborted
    // rust: && (self.decorating > 0 || !self.finishing.is_empty() || !self.viewing.is_empty()))
    // rust: {
    // rust: return false;
}
    // rust: let written: Vec<_> = self.written.drain().collect();
    // rust: self.save_checked_out(written);
    // rust: self.saving == 0
}
in_range :: proc(self: ^Self, x: i32, z: i32, margin: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.ranges().in_range(x, z, margin)
}
    // Rank the 3x3 a chunk loaded to FULL decorates, in one generation
    // task's order (`ChunkGenerationTask`: x-outer, z-inner), after every
    // chunk ranked before.
rank_full_task :: proc(self: ^Self, x: i32, z: i32) {
}
    // rust: for dx in -1..=1 {
    // rust: for dz in -1..=1 {
    // rust: self.decoration_order.rank_or_append(x + dx, z + dz);
}
}
}
band :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.band
}
    // Rank the chunks `/forceload add` over chunks `(x0, z0)..=(x1, z1)`
    // decorates in vanilla's order (`forced_order`), after every chunk
    // ranked before.
rank_forced :: proc(self: ^Self, x0: i32, z0: i32, x1: i32, z1: i32) {
}
    // rust: for (x, z) in horizon_world::worldgen::decoration_order::forced_order(x0, z0, x1, z1) {
    // rust: self.decoration_order.rank_or_append(x, z);
}
}
    // Generate, light and keep the chunks of `band` (none: stop), and let
    // go of what earlier bands held as it falls out of range. The chunks a
    // band reaches are ranked for decoration row by row, as they first come
    // within reach, so that a task decorates in the same order however its
    // work is timed and shared among the workers.
set_band :: proc(self: ^Self, band: Maybe(Band)) {
}
    // rust: if self.band == band {
    // rust: return;
}
    // rust: self.band = band;
    // rust: self.generation_scan.exhausted = false;
    // rust: let Some(band) = band else {
    // rust: return;
}
        // Decoration reaches two chunks past the band and generation three.
REACH :: 4
    // rust: let (x0, x1) = (band.x0 - REACH, band.x1 + REACH);
    // rust: let first = match self.band_ranked {
    // rust: Some((rx0, rx1, next)) if (rx0, rx1) == (x0, x1) => next,
    // rust: _ => band.z0 - REACH,
}
    // rust: let end = band.z1 + REACH;
    // rust: for z in first..=end {
    // rust: for x in x0..=x1 {
    // rust: self.decoration_order.rank_or_append(x, z);
}
}
    // rust: self.band_ranked = Some((x0, x1, end.max(first - 1) + 1));
}
    // What holds up the columns `keys`, for a task that stopped advancing:
    // how many are not loaded, loaded but unlit with a light job in flight,
    // and unlit with none (those whose neighbours are all loaded are queued
    // for light again).
unstick_light :: proc(self: ^Self, world: ^World, keys: ^[(i32) {
}
    // rust: let mut counts = [0; 3];
    // rust: for &key in keys {
    // rust: if !world.chunks.contains_key(&key) {
    // rust: counts[0] += 1;
    // rust: } else if self.lit.contains(&key) {
    // rust: } else if self.lighting.contains_key(&key) {
    // rust: counts[1] += 1;
    // rust: } else {
    // rust: counts[2] += 1;
    // rust: if self.light_region(world, key.0, key.1).is_some()
    // rust: || (-1..=1).any(|dz| {
    // rust: (-1..=1).any(|dx| self.viewing.contains(&(key.0 + dx, key.1 + dz)))
    // rust: })
    // rust: {
    // rust: world.dirty_light.insert(key);
}
}
}
    // rust: counts
}
    // Wait up to `timeout` for a worker to finish a job; the next `update`
    // takes it. A server pumps generation with this between its ticks.
wait :: proc(self: ^Self, timeout: std::time::Duration) {
}
    // rust: if let Some(done) = self.shared.done.recv_timeout(timeout) {
    // rust: self.deferred.push(done);
}
}
}
// `ChunkTrackingView.isInViewDistance`: whether the column (x, z) is drawn
// at this render distance around `center`, the camera's column
// (`SectionOcclusionGraph.isInViewDistance`). Each axis gets a column of
// slack, so this reaches past the circle of `radius` columns.
in_view_distance :: proc(center: (i32) {
}
    // rust: let gap = |d: i32| i64::from((d.abs() - 1).max(0));
    // rust: let (dx, dz) = (gap(x - center.0), gap(z - center.1));
    // rust: dx * dx + dz * dz < i64::from(radius) * i64::from(radius)
}
// How long a view's columns are waited for (`ViewArrival`): a server may never
// fill it.
VIEW_WAIT :: std::time::Duration::from_secs(30)
// Whether the columns of a view (centre, radius) have all arrived, as a client
// sees them come: a server forgets the old view's columns, then sends the new
// ones nearest first, so the view's outermost ones come last. Single player
// joins its integrated server the same way, so `Streaming::busy` cannot see
// what is not sent yet.
ViewArrival :: struct {
    view: ((i32,
    since: Maybe(std::time::Instant),
    arrived: bool,
}
    // rust: impl ViewArrival {
    // Whether columns of `view` have yet to arrive (`has`): its outermost ones,
    // at both ends of each of its rows and columns (`in_view_distance`). Once
    // they have, false until the view changes; false too once it is no longer
    // `recent`, and for a radius below 0 (no view).
    // rust: pub fn arriving(
    // rust: &mut self,
    // rust: view: ((i32, i32), i32),
    // rust: now: std::time::Instant,
    // rust: has: impl Fn((i32, i32)) -> bool,
    // rust: ) -> bool {
    // rust: if self.since.is_none() || view != self.view {
    // rust: (self.view, self.since, self.arrived) = (view, Some(now), false);
}
    // rust: let ((x, z), r) = view;
    // rust: if self.arrived || r < 0 || !self.recent(now) {
    // rust: return false;
}
    // rust: self.arrived = (-r..=r).all(|d| {
            // How far row (and column) `d` reaches: `in_view_distance` solved for it.
    // rust: let gap = i64::from((d.abs() - 1).max(0));
    // rust: let room = i64::from(r).pow(2) - gap * gap;
    // rust: room <= 0 || {
    // rust: let e = (room - 1).isqrt() as i32 + 1;
                // Both ends of row `d`, and of column `d`.
    // rust: [-e, e]
    // rust: .into_iter()
    // rust: .all(|e| has((x + d, z + e)) && has((x + e, z + d)))
}
    // rust: });
    // rust: !self.arrived
}
    // Whether the view `arriving` was last given changed less than `VIEW_WAIT`
    // ago: until then sections meshed are its terrain coming in, later an edit's.
recent :: proc(self: ^Self, now: std::time::Instant) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.since
    // rust: .is_some_and(|since| now.saturating_duration_since(since) < VIEW_WAIT)
}
}
// The rings around a `/forceload`ed chunk, in chunks. Vanilla's FORCED
// ticket is level 31 (`ChunkMap.FORCED_TICKET_LEVEL`), the level rises one
// per ring (`ChunkTracker.computeLevelFromNeighbor`), and the level picks
// the column's status (`ChunkLevel.generationStatus`): full (33) two rings
// out, features (34) at three, terrain (35) at four.
FORCED_FULL_RING :: 2
FORCED_FEATURES_RING :: 3
FORCED_TERRAIN_RING :: 4
// The areas kept loaded: circles around the player and `extra`, and forced chunks.
Ranges :: struct {
    center: (i32,
    radius: i32,
    extra: ^'a [((i32,
    forced: ^'a HashSet<(i32,
    // The chunks native mods' tickets hold, kept as forced ones are.
    mod_forced: ^'a HashSet<(i32,
    // `extra` indexed by a grid or buckets: coverage queries without a
    // scan of every area.
    cover: Maybe(^'a ExtraCover),
    band: Maybe(^'a Band),
}
// The chunks a pregeneration task (`/pregen`) wants lit now: rows `z0..=z1`
// of the columns `x0..=x1`, those within `circle` (a centre and a radius in
// chunks) when there is one. Like an extra area, it finishes its chunks and
// the ring around them, so that its own chunks can be lit, and generation
// reaches past that. A task moves it down a strip of columns a row at a
// time, so each chunk is generated once and only the rows in flight stay
// loaded.
Band :: struct {
    x0: i32,
    x1: i32,
    z0: i32,
    z1: i32,
    circle: Option<((i32,
}
    // rust: impl Band {
    // Whether (x, z) lies within `margin` (Chebyshev) of one of the band's
    // chunks: the square of side `2 * margin + 1` around it meets the
    // rectangle at a point inside the circle.
within :: proc(self: ^Self, x: i32, z: i32, margin: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (x0, x1) = (
    // rust: x.saturating_sub(margin).max(self.x0),
    // rust: x.saturating_add(margin).min(self.x1),
    // rust: );
    // rust: let (z0, z1) = (
    // rust: z.saturating_sub(margin).max(self.z0),
    // rust: z.saturating_add(margin).min(self.z1),
    // rust: );
    // rust: if x0 > x1 || z0 > z1 {
    // rust: return false;
}
    // rust: self.circle.is_none_or(|((cx, cz), r)| {
    // rust: let dx = i64::from(cx.clamp(x0, x1)) - i64::from(cx);
    // rust: let dz = i64::from(cz.clamp(z0, z1)) - i64::from(cz);
    // rust: dx * dx + dz * dz <= i64::from(r) * i64::from(r)
    // rust: })
}
    // The band's chunks go after the players' (lower runs first), row by
    // row, as the task wants them lit.
priority :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
AFTER_PLAYERS :: 1 << 40
    // rust: AFTER_PLAYERS
    // rust: + (i64::from(z - self.z0 + 8).max(0) << 20)
    // rust: + i64::from(x - self.x0 + 8).max(0)
}
}
// For every column near the extra areas, how far it lies outside the
// nearest one's square (Chebyshev distance less its radius; 0 inside). A server has an area per player, and streaming asks of every
// loaded and wanted column whether one reaches it, several times a tick:
// with fifty players, a scan of fifty squares per question.
//
// Areas spread too far apart for that grid (players thousands of blocks from
// each other) are found by the square of [`Self::BUCKET`] columns their centre
// is in instead, which also answers which centre is nearest a column
// (`Ranges::distance`, asked of every wanted column to rank it).
ExtraCover :: struct {
    extra: Vec<((i32,
    grid: Maybe(CoverGrid),
    // The indices in `extra` of the areas centred in each bucket.
    buckets: FxHashMap<(i32,
    // The buckets' bounding box, inclusive: (x0, z0, x1, z1).
    bucket_box: (i32,
    // The largest radius in `extra`.
    radius: i32,
}
CoverGrid :: struct {
    x0: i32,
    z0: i32,
    width: u32,
    depth: u32,
    cells: ^[i8],
}
    // rust: impl ExtraCover {
    // The largest margin the grid answers for; beyond it (and outside the
    // grid) a column is further than that from every square.
REACH :: 4
    // The largest grid, in columns (a mebibyte).
CELLS :: 1 << 20
    // The side of a bucket, in columns.
BUCKET :: 64
    // The farthest centre kept in buckets: far enough for any world border.
LIMIT :: 1 << 26
    // rust: fn matching<'a>(
    // rust: cover: &'a Option<ExtraCover>,
    // rust: extra: &[((i32, i32), i32)],
    // rust: ) -> Option<&'a ExtraCover> {
    // rust: cover.as_ref().filter(|c| c.extra == extra)
}
    // Rebuild the coverage index if `extra` changed; none for one area or none
    // (a scan is as quick).
refresh :: proc(cover: ^Maybe(ExtraCover), extra: ^[((i32) {
}
    // rust: if cover.as_ref().is_some_and(|c| c.extra == extra) {
    // rust: return;
}
    // rust: *cover = Self::new(extra);
}
new :: proc(extra: ^[((i32) {
}
    // rust: if extra.len() < 2
    // rust: || extra.iter().any(|&((x, z), r)| {
    // rust: !(0..=64).contains(&r) || x.abs() > Self::LIMIT || z.abs() > Self::LIMIT
    // rust: })
    // rust: {
    // rust: return None;
}
    // rust: let mut buckets: FxHashMap<(i32, i32), Vec<u32>> = FxHashMap::default();
    // rust: let mut bucket_box = (i32::MAX, i32::MAX, i32::MIN, i32::MIN);
    // rust: for (i, &((x, z), _)) in extra.iter().enumerate() {
    // rust: let key = (x.div_euclid(Self::BUCKET), z.div_euclid(Self::BUCKET));
    // rust: buckets.entry(key).or_default().push(i as u32);
    // rust: bucket_box = (
    // rust: bucket_box.0.min(key.0),
    // rust: bucket_box.1.min(key.1),
    // rust: bucket_box.2.max(key.0),
    // rust: bucket_box.3.max(key.1),
    // rust: );
}
    // rust: Some(Self {
    // rust: extra: extra.to_vec(),
    // rust: grid: CoverGrid::new(extra),
    // rust: buckets,
    // rust: bucket_box,
    // rust: radius: extra.iter().map(|&(_, r)| r).max().unwrap_or(0),
    // rust: })
}
    // Whether (x, z) is within `margin` of an area's square, for a
    // `margin` up to `REACH`.
within :: proc(self: ^Self, x: i32, z: i32, margin: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(grid) = &self.grid {
    // rust: return grid.within(x, z, margin);
}
    // rust: let reach = self.radius + margin;
    // rust: let (kx0, kx1) = (
    // rust: (x.saturating_sub(reach)).div_euclid(Self::BUCKET),
    // rust: (x.saturating_add(reach)).div_euclid(Self::BUCKET),
    // rust: );
    // rust: let (kz0, kz1) = (
    // rust: (z.saturating_sub(reach)).div_euclid(Self::BUCKET),
    // rust: (z.saturating_add(reach)).div_euclid(Self::BUCKET),
    // rust: );
    // rust: (kz0..=kz1).any(|kz| {
    // rust: (kx0..=kx1).any(|kx| {
    // rust: self.buckets.get(&(kx, kz)).is_some_and(|areas| {
    // rust: areas.iter().any(|&i| {
    // rust: let ((cx, cz), r) = self.extra[i as usize];
    // rust: (i64::from(x) - i64::from(cx))
    // rust: .abs()
    // rust: .max((i64::from(z) - i64::from(cz)).abs())
    // rust: <= i64::from(r + margin)
    // rust: })
    // rust: })
    // rust: })
    // rust: })
}
    // The squared distance from (x, z) to the nearest area's centre.
    // Buckets are searched ring by ring outwards: once the nearest found is
    // no further than the next ring can be, the search stops.
nearest_sq :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let d = |i: u32| {
    // rust: let (c, _) = self.extra[i as usize];
    // rust: let (dx, dz) = (i64::from(x) - i64::from(c.0), i64::from(z) - i64::from(c.1));
    // rust: dx * dx + dz * dz
}
    // rust: let (qx, qz) = (x.div_euclid(Self::BUCKET), z.div_euclid(Self::BUCKET));
    // rust: let (x0, z0, x1, z1) = self.bucket_box;
    // rust: let last = (qx - x0)
    // rust: .abs()
    // rust: .max((qx - x1).abs())
    // rust: .max((qz - z0).abs())
    // rust: .max((qz - z1).abs());
    // rust: let mut best = i64::MAX;
    // rust: let mut looked = 0usize;
    // rust: for ring in 0..=last {
    // rust: let mut look = |kx: i32, kz: i32| {
    // rust: looked += 1;
    // rust: if let Some(areas) = self.buckets.get(&(kx, kz)) {
    // rust: best = areas.iter().map(|&i| d(i)).fold(best, i64::min);
}
}
    // rust: if ring == 0 {
    // rust: look(qx, qz);
    // rust: } else {
    // rust: for k in -ring..=ring {
    // rust: look(qx + k, qz - ring);
    // rust: look(qx + k, qz + ring);
}
    // rust: for k in 1 - ring..ring {
    // rust: look(qx - ring, qz + k);
    // rust: look(qx + ring, qz + k);
}
}
            // Every centre in a further ring is more than `ring` buckets away
            // on one axis.
    // rust: let bound = i64::from(ring) * i64::from(Self::BUCKET);
    // rust: if best <= bound * bound {
    // rust: break;
}
            // Far from every area: a scan costs less than more empty rings.
    // rust: if looked > self.extra.len() * 4 {
    // rust: return (0..self.extra.len() as u32).map(d).fold(best, i64::min);
}
}
    // rust: best
}
}
    // rust: impl CoverGrid {
    // None for areas too far apart for [`ExtraCover::CELLS`].
new :: proc(extra: ^[((i32) {
}
    // rust: let k = i64::from(ExtraCover::REACH);
    // rust: let (mut x0, mut z0, mut x1, mut z1) = (i64::MAX, i64::MAX, i64::MIN, i64::MIN);
    // rust: for &((x, z), r) in extra {
    // rust: let (x, z, r) = (i64::from(x), i64::from(z), i64::from(r) + k);
    // rust: (x0, z0, x1, z1) = (x0.min(x - r), z0.min(z - r), x1.max(x + r), z1.max(z + r));
}
    // rust: let (width, depth) = ((x1 - x0 + 1) as u64, (z1 - z0 + 1) as u64);
    // rust: if width * depth > ExtraCover::CELLS {
    // rust: return None;
}
    // rust: let (x0, z0, width, depth) = (x0 as i32, z0 as i32, width as u32, depth as u32);
    // rust: let mut cells =
    // rust: vec![(ExtraCover::REACH + 1) as i8; (width * depth) as usize].into_boxed_slice();
        // Inside a square counts as 0: no margin asked for is below it. Each
        // row of a square is a run of one value with a slope at either end.
    // rust: let lower = |run: &mut [i8], v: i8| run.iter_mut().for_each(|c| *c = (*c).min(v));
    // rust: for &((cx, cz), r) in extra {
    // rust: let reach = r + ExtraCover::REACH;
    // rust: for dz in -reach..=reach {
    // rust: let start = (cz + dz - z0) as usize * width as usize + (cx - x0) as usize;
    // rust: let row = &mut cells[start - reach as usize..=start + reach as usize];
    // rust: let flat = dz.abs().max(r);
    // rust: let centre = reach as usize;
    // rust: lower(
    // rust: &mut row[centre - flat as usize..=centre + flat as usize],
    // rust: (flat - r) as i8,
    // rust: );
    // rust: for d in flat + 1..=reach {
    // rust: let v = (d - r) as i8;
    // rust: lower(&mut row[centre - d as usize..=centre - d as usize], v);
    // rust: lower(&mut row[centre + d as usize..=centre + d as usize], v);
}
}
}
    // rust: Some(Self {
    // rust: x0,
    // rust: z0,
    // rust: width,
    // rust: depth,
    // rust: cells,
    // rust: })
}
within :: proc(self: ^Self, x: i32, z: i32, margin: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (dx, dz) = (
    // rust: x.wrapping_sub(self.x0) as u32,
    // rust: z.wrapping_sub(self.z0) as u32,
    // rust: );
    // rust: dx < self.width
    // rust: && dz < self.depth
    // rust: && i32::from(self.cells[(dz * self.width + dx) as usize]) <= margin
}
}
    // rust: impl Ranges<'_> {
    // `distance`, or the band's nearer priority close to it.
priority :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let own = self.distance(x, z);
    // rust: match self.band {
    // rust: Some(band) if band.within(x, z, 4) => own.min(band.priority(x, z)),
    // rust: _ => own,
}
}
distance :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let d = |c: (i32, i32)| {
    // rust: let (dx, dz) = (i64::from(x - c.0), i64::from(z - c.1));
    // rust: dx * dx + dz * dz
}
    // rust: if let Some(cover) = self.cover {
    // rust: return d(self.center).min(cover.nearest_sq(x, z));
}
    // rust: self.extra
    // rust: .iter()
    // rust: .map(|(c, _)| d(*c))
    // rust: .fold(d(self.center), i64::min)
}

    // How far past the view distance chunks are generated, and how far around
    // a finished chunk (`near_finished`): decorated chunks need their
    // neighbours generated too.
margins :: proc(decorates: bool) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if decorates { (3, 2) } else { (1, 1) }
}
    // Chunks generation asks for: loaded from the save, or generated as protos.
requested :: proc(self: ^Self, x: i32, z: i32, decorates: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (margin, reach) = Self::margins(decorates);
    // rust: self.in_range(x, z, margin) || self.near_finished(x, z, reach)
}
    // Finished columns kept when they arrive: within two of the view distance
    // or next to a finished chunk, and every column generation asked for (a
    // saved one loads finished; dropping it had it asked for and loaded again
    // every frame).
chunk_kept :: proc(self: ^Self, x: i32, z: i32, decorates: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.in_range(x, z, 2) || self.near_finished(x, z, 1) || self.requested(x, z, decorates)
}
    // Columns unloaded: past every column kept.
unloaded :: proc(self: ^Self, x: i32, z: i32, decorates: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.in_range(x, z, 3) && !self.near_finished(x, z, Self::margins(decorates).1)
}
    // Whether a chunk finished here (`in_range(_, _, 1)`) lies within `reach`
    // chunks of (x, z) on both axes: its decoration needs its 3x3 neighbours
    // decorated, which need their own 3x3 neighbours generated. The ranges are
    // circles, so a fixed margin alone misses the corners of those squares
    // (render distance 2 never finished the chunks next to the player).
near_finished :: proc(self: ^Self, x: i32, z: i32, reach: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let gap = |d: i32| i64::from((d.abs() - reach).max(0));
    // rust: let (dx, dz) = (gap(x - self.center.0), gap(z - self.center.1));
    // rust: let r = i64::from(self.radius + 1);
        // The extra areas are squares: their finished square grown by `reach`.
    // rust: (self.radius >= 0 && dx * dx + dz * dz <= r * r)
    // rust: || self.in_extra(x, z, 1 + reach)
    // rust: || self.in_band(x, z, 1 + reach)
}
in_range :: proc(self: ^Self, x: i32, z: i32, margin: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.in_main_range(x, z, margin)
    // rust: || self.in_extra(x, z, margin)
    // rust: || self.in_band(x, z, margin)
}
    // Within `margin` of the pregeneration band.
in_band :: proc(self: ^Self, x: i32, z: i32, margin: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.band.is_some_and(|b| b.within(x, z, margin))
}
    // Within `margin` of an extra area's square (Chebyshev distance, as
    // vanilla's ticket levels spread).
in_extra :: proc(self: ^Self, x: i32, z: i32, margin: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(cover) = self.cover
    // rust: && (0..=ExtraCover::REACH).contains(&margin)
    // rust: {
    // rust: return cover.within(x, z, margin);
}
    // rust: self.extra
    // rust: .iter()
    // rust: .any(|&(c, radius)| (x - c.0).abs().max((z - c.1).abs()) <= radius + margin)
}
    // Whether a `/forceload` or a native mod's ticket holds the chunk.
is_forced :: proc(self: ^Self, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.forced.contains(&(x, z)) || self.mod_forced.contains(&(x, z))
}
    // Every chunk a `/forceload` or a native mod's ticket holds, once each.
forced_chunks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.forced
    // rust: .iter()
    // rust: .chain(self.mod_forced.iter().filter(|c| !self.forced.contains(c)))
}
    // The columns meshed for drawing: those vanilla draws around the
    // player (`in_view_distance`), and forced ones.
in_view :: proc(self: ^Self, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: in_view_distance(self.center, self.radius, x, z) || self.is_forced(x, z)
}
in_main_range :: proc(self: ^Self, x: i32, z: i32, margin: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let r = i64::from(self.radius + margin);
    // rust: let (dx, dz) = (i64::from(x - self.center.0), i64::from(z - self.center.1));
    // rust: if self.radius >= 0 && dx * dx + dz * dz <= r * r {
    // rust: return true;
}
        // A forced chunk holds a FORCED ticket at level 31
        // (`ChunkMap.FORCED_TICKET_LEVEL`), and the level rises one per ring
        // (`ChunkTracker.computeLevelFromNeighbor`): the margin is the
        // vanilla status ring the caller asks for.
    // rust: let reach = match margin {
    // rust: 1 => FORCED_FULL_RING,
    // rust: 2 => FORCED_FEATURES_RING,
    // rust: 3 => FORCED_TERRAIN_RING,
    // rust: _ => margin + 1,
}
    // rust: self.forced_chunks()
    // rust: .any(|f| (x - f.0).abs() <= reach && (z - f.1).abs() <= reach)
}
}
    // rust: impl Drop for Streaming {
drop :: proc(self: ^Self) {
}
    // rust: self.abort_generation();
        // Saves in flight hold proto chunks nothing else would save.
    // rust: let deadline = std::time::Instant::now() + std::time::Duration::from_secs(30);
    // rust: while self.saving > 0 {
    // rust: let left = deadline.saturating_duration_since(std::time::Instant::now());
    // rust: match self.shared.done.recv_timeout(left) {
    // rust: Some(Done::Saved(_)) => self.saving -= 1,
    // rust: Some(_) => {}
    // rust: None => break,
}
}
        // `jobs` leaves the pool after this, once its running jobs are
        // done; the jobs still queued go with the queue.
}
}
// The queued jobs' priorities computed again from each one's column
// `distance` (`Streaming::submit`).
rank_again :: proc(queue: ^BinaryHeap<Queued>, distance: impl Fn(i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if queue.is_empty() {
    // rust: return;
}
    // rust: let mut jobs = std::mem::take(queue).into_vec();
    // rust: for job in &mut jobs {
    // rust: if let Some((x, z)) = job.at {
    // rust: job.priority = distance(x, z) * 4 + job.bias;
}
}
    // rust: *queue = BinaryHeap::from(jobs);
}
// `ChunkTaskPriorityQueue.release(pos, clearQueue=true)`: the jobs queued for the
// `gone` columns are dropped, so a view that moved or shrank does not wait behind the
// generation of the chunks it left. A job without a column (a save, meshes to free)
// stays, as vanilla keeps the tasks of a chunk that is still loaded. Returns how many
// jobs went.
release_columns :: proc(queue: ^BinaryHeap<Queued>, gone: ^FxHashSet<(i32) {
}
    // rust: if queue.is_empty() || gone.is_empty() {
    // rust: return 0;
}
    // rust: let queued = std::mem::take(queue).into_vec();
    // rust: let before = queued.len();
    // rust: let kept: Vec<Queued> = queued
    // rust: .into_iter()
    // rust: .filter(|job| !job.at.is_some_and(|at| gone.contains(&at)))
    // rust: .collect();
    // rust: let released = before - kept.len();
    // rust: *queue = BinaryHeap::from(kept);
    // rust: released
}
// Whether the 3x3 a light job for (x, z) reads is all there: every
// neighbour a finished column, or a decorated proto chunk past the area
// (the last FULL ring lights against neighbours at FEATURES, as
// `Streaming::light_region` reads them).
    // rust: fn light_region_ready(
    // rust: world: &World,
    // rust: in_range: impl Fn(i32, i32) -> bool,
    // rust: decorated: &FxHashSet<(i32, i32)>,
    // rust: protos: &FxHashMap<(i32, i32), Option<Proto>>,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> bool {
    // rust: for dz in 0..3 {
    // rust: for dx in 0..3 {
    // rust: let n = (x + dx - 1, z + dz - 1);
    // rust: if world.chunks.contains_key(&n)
    // rust: || (!in_range(n.0, n.1)
    // rust: && decorated.contains(&n)
    // rust: && matches!(protos.get(&n), Some(Some(_))))
    // rust: {
    // rust: continue;
}
    // rust: return false;
}
}
    // rust: true
}
// The nearest `room` of the `candidates`, ordered: the light and mesh
// stages submit bounded work, chosen from everything that is ready each
// `update`, so what runs is always the nearest of what is left — chosen
// again, from the current centre, as capacity frees, the way vanilla's
// chunk task queues follow the current ticket levels. The selection is
// O(n); the sort orders only what is submitted.
    // rust: fn nearest_first<T: Ord>(candidates: &mut Vec<T>, room: usize) {
    // rust: if candidates.len() > room {
    // rust: candidates.select_nth_unstable(room);
    // rust: candidates.truncate(room);
}
    // rust: candidates.sort_unstable();
}
// What `keep_unchanged_sections` found changed.
Resent :: struct {
    // Any section's blocks changed (in a way light or the mesher sees).
    blocks: bool,
    // The sections whose blocks did not change but whose biomes did.
    biomes: [dynamic]uint,
    // The sections whose blocks did not change but whose light the packet changes.
    light: [dynamic]uint,
}
// `new`, a resident column `old` sent again, takes `old`'s sections whose
// blocks it holds unchanged, with `new`'s biomes and light; the sections whose blocks
// changed keep `old`'s light (until lit again) and their cells' classes go in
// `cells`.
    // rust: fn keep_unchanged_sections(
    // rust: old: &Chunk,
    // rust: new: &mut Chunk,
    // rust: cells: &mut crate::light::LightChanges,
    // rust: ) -> Resent {
    // rust: let (mut a, mut b) = (Box::new([0u32; 4096]), Box::new([0u32; 4096]));
    // rust: let mut out = Resent::default();
    // rust: let (x, z) = (new.x, new.z);
    // rust: for s in 0..new.sections.len().min(old.sections.len()) {
        // (sections stored alike hold the same blocks: most of a column sent again, found without unpacking)
    // rust: let same = old.sections[s].blocks.same_storage(&new.sections[s].blocks) || {
    // rust: old.sections[s].unpack(&mut a);
    // rust: new.sections[s].unpack(&mut b);
    // rust: let classes = crate::light::LightChanges::classes_differing(&a, &b);
    // rust: if classes != 0 {
    // rust: cells.add((x, s as i32, z), classes);
}
    // rust: classes == 0
}
    // rust: if !same {
    // rust: out.blocks = true;
    // rust: continue;
}
    // rust: let biomes = new.sections[s].biomes.clone();
    // rust: let changed = !same_values(&old.sections[s].biomes, &biomes);
    // rust: let light = (!same_light(&old.sections[s].light, &new.sections[s].light))
    // rust: .then(|| new.sections[s].light.clone());
    // rust: new.sections[s] = old.sections[s].clone();
    // rust: if changed {
    // rust: Arc::make_mut(&mut new.sections[s]).biomes = biomes;
    // rust: out.biomes.push(s);
}
    // rust: if let Some(light) = light {
    // rust: Arc::make_mut(&mut new.sections[s]).light = light;
    // rust: out.light.push(s);
}
}
    // rust: out
}
// Whether two sections' packed light (4,096 cells) holds the same values.
same_light :: proc(a: ^crate::chunk::Light, b: ^crate::chunk::Light) -> b {
    // Ported from Horizon
    return {}
}
    // rust: a.same_as(b)
}
// Whether two biome containers (64 cells) hold the same values.
    // rust: fn same_values(
    // rust: a: &horizon_core::paletted::PalettedContainer,
    // rust: b: &horizon_core::paletted::PalettedContainer,
    // rust: ) -> bool {
    // rust: if a.same_storage(b) {
    // rust: return true;
}
    // rust: let (mut x, mut y) = ([0u32; 64], [0u32; 64]);
    // rust: a.unpack(&mut x);
    // rust: b.unpack(&mut y);
    // rust: x == y
}

// The most changed blocks one frame relights itself (`Streaming::relight_edits`): a 16^3
// section's worth. Past it, the columns are lit again whole on the workers.
INLINE_RELIGHT_MAX :: 4096

// Splits edits at `positions` into the columns to light again whole and the
// edits to relight in place. An edited column is lit whole with its
// neighbours (light reaches 15 blocks, never past the next column) when all
// nine are `ready` to be lit whole; otherwise its edits stay in place.
    // rust: fn whole_relight_columns(
    // rust: positions: Vec<(i32, i32, i32)>,
    // rust: ready: impl Fn(i32, i32) -> bool,
    // rust: ) -> (FxHashSet<(i32, i32)>, Vec<(i32, i32, i32)>) {
    // rust: let around =
    // rust: |(x, z): (i32, i32)| (-1..=1).flat_map(move |dz| (-1..=1).map(move |dx| (x + dx, z + dz)));
    // rust: let touched: FxHashSet<(i32, i32)> = positions
    // rust: .iter()
    // rust: .map(|&(x, _, z)| (x >> 4, z >> 4))
    // rust: .collect();
    // rust: let whole: FxHashSet<(i32, i32)> = touched
    // rust: .into_iter()
    // rust: .filter(|&column| around(column).all(|(x, z)| ready(x, z)))
    // rust: .collect();
    // rust: let columns = whole.iter().flat_map(|&column| around(column)).collect();
    // rust: let inline = positions
    // rust: .into_iter()
    // rust: .filter(|&(x, _, z)| !whole.contains(&(x >> 4, z >> 4)))
    // rust: .collect();
    // rust: (columns, inline)
}

// Drops the pending sections (`meshing`, `compile_started`, `waiting`) of
// the `gone` columns: one pass over each store when that is cheaper than a
// lookup per section of every column (a far teleport at render distance 32
// forgets ~3,700 columns, 1.7 ms of lookups), else by key.
    // rust: fn forget_pending_sections(
    // rust: meshing: &mut FxHashMap<(i32, i32, i32), u64>,
    // rust: compile_started: &mut FxHashMap<(i32, i32, i32), u64>,
    // rust: waiting: &mut FxHashSet<(i32, i32, i32)>,
    // rust: gone: &FxHashSet<(i32, i32)>,
    // rust: sections: i32,
    // rust: ) {
    // rust: let lookups = gone.len().saturating_mul(sections.max(0) as usize);
    // rust: if lookups > meshing.len() + compile_started.len() + waiting.len() {
    // rust: let kept = |&(x, _, z): &(i32, i32, i32)| !gone.contains(&(x, z));
    // rust: meshing.retain(|k, _| kept(k));
    // rust: compile_started.retain(|k, _| kept(k));
    // rust: waiting.retain(kept);
    // rust: } else {
    // rust: for &(x, z) in gone {
    // rust: for sy in 0..sections {
    // rust: meshing.remove(&(x, sy, z));
    // rust: compile_started.remove(&(x, sy, z));
    // rust: waiting.remove(&(x, sy, z));
}
}
}
}

// No chunk held by a native mod's ticket, for the tests' ranges.
NO_CHUNKS :: std::sync::LazyLock::new(HashSet::new)

    // rust: mod tests {
//     use super::*;

a_resent_column_keeps_its_sections_but_takes_new_biomes :: proc() {
}
    // rust: let mut old = Chunk::empty(2, -3);
    // rust: old.set(1, 10, 1, 1);
    // rust: old.set(1, 40, 1, 1);
    // rust: old.set_biome_cell(0, 0, 0, 1);
    // rust: let mut new = old.clone();
        // a new biome under the same blocks (section 0), and a block changed (section 6)
    // rust: new.set_biome_cell(0, 0, 0, 3);
    // rust: new.set(1, 40, 1, 2);
    // rust: let mut cells = crate::light::LightChanges::default();
    // rust: cells.keyed(crate::chunk::ColumnLayout::VANILLA);
    // rust: let kept = keep_unchanged_sections(&old, &mut new, &mut cells);
    // rust: assert_eq!(
    // rust: kept,
    // rust: Resent {
    // rust: blocks: true,
    // rust: biomes: vec![0],
    // rust: light: vec![],
}
    // rust: );
    // rust: assert_eq!(new.biome(0, -64, 0), 3);
    // rust: assert_eq!(new.block(1, -54, 1).0, 0);
    // rust: assert_eq!(new.block(1, 40, 1).0, 2);
        // the sections alike are shared with the old column
    // rust: assert!(Arc::ptr_eq(&new.sections[1], &old.sections[1]));
    // rust: assert!(!Arc::ptr_eq(&new.sections[0], &old.sections[0]));
        // nothing changed: nothing to do
    // rust: let mut same = old.clone();
    // rust: let kept = keep_unchanged_sections(&old, &mut same, &mut cells);
    // rust: assert_eq!(kept, Resent::default());
    // rust: assert!(Arc::ptr_eq(&same.sections[0], &old.sections[0]));
        // the same blocks under new light: the packet's light, as vanilla applies it
    // rust: let mut lit = old.clone();
    // rust: Arc::make_mut(&mut lit.sections[2]).light = crate::chunk::Light::Uniform(0xF0);
    // rust: Arc::make_mut(&mut old.sections[2]).light = crate::chunk::Light::Uniform(0x50);
    // rust: let kept = keep_unchanged_sections(&old, &mut lit, &mut cells);
    // rust: assert_eq!(
    // rust: kept,
    // rust: Resent {
    // rust: light: vec![2],
    // rust: ..Resent::default()
}
    // rust: );
    // rust: assert_eq!(lit.sections[2].light.get(0), 0xF0);
    // rust: assert!(Arc::ptr_eq(&lit.sections[1], &old.sections[1]));
}

mesh_pool_reuses_capacity_with_clean_geometry_state :: proc() {
}
    // rust: let mut mesh = SectionMesh::default();
    // rust: mesh.solid.resize(64, bytemuck::Zeroable::zeroed());
    // rust: mesh.translucent.resize(16, bytemuck::Zeroable::zeroed());
    // rust: mesh.block_entities.push(([1, 2, 3], 7));
    // rust: mesh.lights.push(([1, 2, 3], 7));
    // rust: mesh.visibility = 0;
    // rust: mesh.sides = crate::mesher::Sides::unsorted(16);
    // rust: let capacities = mesh.capacity_bytes();
    // rust: let pointers = (mesh.solid.as_ptr(), mesh.translucent.as_ptr());
    // rust: let mut pool = MeshPool::default();
    // rust: assert!(pool.put(mesh).is_none());
    // rust: assert_eq!(pool.bytes, capacities);
    // rust: let reused = pool.take();
    // rust: assert_eq!(reused.capacity_bytes(), capacities);
    // rust: assert_eq!(
    // rust: pointers,
    // rust: (reused.solid.as_ptr(), reused.translucent.as_ptr())
    // rust: );
    // rust: assert!(reused.solid.is_empty());
    // rust: assert!(reused.translucent.is_empty());
    // rust: assert!(reused.block_entities.is_empty());
    // rust: assert!(reused.lights.is_empty());
    // rust: assert_eq!(reused.visibility, crate::mesher::ALL_VISIBLE);
    // rust: assert_eq!(reused.sides, crate::mesher::Sides::default());
    // rust: assert_eq!(pool.bytes, 0);
}

mesh_pool_caps_retained_count_and_bytes :: proc() {
}
    // rust: let mut pool = MeshPool::default();
    // rust: for _ in 0..MeshPool::COUNT {
    // rust: let mut mesh = SectionMesh::default();
    // rust: mesh.solid.reserve_exact(1);
    // rust: assert!(pool.put(mesh).is_none());
}
    // rust: let mut extra = SectionMesh::default();
    // rust: extra.solid.reserve_exact(1);
    // rust: assert!(pool.put(extra).is_some());
    // rust: for _ in 0..MeshPool::COUNT {
    // rust: pool.take();
}
    // rust: assert_eq!(pool.bytes, 0);
    // rust: for i in 0..2 {
    // rust: let mut mesh = SectionMesh::default();
    // rust: mesh.solid.reserve_exact(
    // rust: MeshPool::BYTES / std::mem::size_of::<crate::mesher::TerrainVertex>() / 2 + 1,
    // rust: );
    // rust: assert_eq!(pool.put(mesh).is_some(), i == 1);
    // rust: assert!(pool.bytes <= MeshPool::BYTES);
    // rust: assert_eq!(pool.meshes.len(), 1);
}
    // rust: pool.take();
    // rust: assert_eq!(pool.bytes, 0);
    // rust: let mut huge = SectionMesh::default();
    // rust: huge.solid.reserve_exact(
    // rust: MeshPool::BYTES / std::mem::size_of::<crate::mesher::TerrainVertex>() + 1,
    // rust: );
    // rust: assert!(pool.put(huge).is_some());
    // rust: assert!(pool.meshes.is_empty());
    // rust: assert_eq!(pool.bytes, 0);
}

    // The frame never waits for a worker: while one holds the mailbox, the
    // frame takes nothing and finds the results, in order, the next time.
the_frame_takes_finished_jobs_without_waiting :: proc() {
}
    // rust: let mailbox = Mailbox::default();
    // rust: let lit = |seq| Done::Lit(0, 0, Vec::new(), seq);
    // rust: mailbox.send(lit(1));
    // rust: mailbox.send(lit(2));
    // rust: let sending = mailbox.done.lock().unwrap();
    // rust: assert!(mailbox.take().is_empty());
    // rust: assert!(mailbox.try_recv().is_none());
    // rust: drop(sending);
    // rust: let seqs: Vec<u64> = mailbox
    // rust: .take()
    // rust: .into_iter()
    // rust: .map(|done| match done {
    // rust: Done::Lit(_, _, _, seq) => seq,
    // rust: _ => unreachable!(),
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(seqs, [1, 2]);
    // rust: assert!(mailbox.take().is_empty());
    // rust: let waiting = std::time::Instant::now();
    // rust: assert!(
    // rust: mailbox
    // rust: .recv_timeout(std::time::Duration::from_millis(10))
    // rust: .is_none()
    // rust: );
    // rust: assert!(waiting.elapsed() >= std::time::Duration::from_millis(10));
}

    // Whether the forgotten columns are few (looked up by key) or many
    // (one pass over each store), exactly their pending sections go.
forgotten_columns_lose_their_pending_sections_either_way :: proc() {
}
    // rust: let pending: Vec<(i32, i32, i32)> = (0..4)
    // rust: .flat_map(|x| (0..3).map(move |sy| (x, sy, -x)))
    // rust: .collect();
    // rust: for gone in [
    // rust: vec![(1, -1)],
    // rust: (0..400)
    // rust: .map(|x| (x, -x))
    // rust: .filter(|&c| c != (2, -2))
    // rust: .collect(),
    // rust: ] {
    // rust: let gone: FxHashSet<(i32, i32)> = gone.into_iter().collect();
    // rust: let mut meshing: FxHashMap<_, u64> = pending.iter().map(|&k| (k, 1)).collect();
    // rust: let mut started = meshing.clone();
    // rust: let mut waiting: FxHashSet<_> = pending.iter().copied().collect();
    // rust: forget_pending_sections(&mut meshing, &mut started, &mut waiting, &gone, 3);
    // rust: let mut left: Vec<_> = waiting.into_iter().collect();
    // rust: left.sort();
    // rust: let expected: Vec<_> = pending
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&(x, _, z)| !gone.contains(&(x, z)))
    // rust: .collect();
    // rust: assert_eq!(left, expected, "{} gone", gone.len());
    // rust: let mut left: Vec<_> = meshing.into_keys().collect();
    // rust: left.sort();
    // rust: assert_eq!(left, expected);
    // rust: let mut left: Vec<_> = started.into_keys().collect();
    // rust: left.sort();
    // rust: assert_eq!(left, expected);
}
}

    // Edits in two neighbouring columns light those and the ten around
    // them again; a column next to one that can't be lit whole keeps its
    // edits in the frame.
whole_relights_cover_the_edited_columns_and_their_neighbours :: proc() {
}
        // Blocks in columns (0, 0) and (1, 0).
    // rust: let positions = vec![(3, 70, 4), (15, 64, 15), (16, 80, 0), (31, 64, 9)];
    // rust: let (columns, inline) = whole_relight_columns(positions.clone(), |_, _| true);
    // rust: let mut columns: Vec<_> = columns.into_iter().collect();
    // rust: columns.sort();
    // rust: let expected: Vec<(i32, i32)> = (-1..=2)
    // rust: .flat_map(|x| (-1..=1).map(move |z| (x, z)))
    // rust: .collect();
    // rust: assert_eq!(columns, expected);
    // rust: assert!(inline.is_empty());
        // (2, 1) is next to (1, 0) only: (0, 0) is still lit whole.
    // rust: let (columns, inline) = whole_relight_columns(positions, |x, z| (x, z) != (2, 1));
    // rust: assert_eq!(inline, vec![(16, 80, 0), (31, 64, 9)]);
    // rust: assert_eq!(columns.len(), 9);
    // rust: assert!(columns.contains(&(-1, -1)) && columns.contains(&(1, 1)));
        // Negative coordinates floor to their column.
    // rust: let (west, _) = whole_relight_columns(vec![(-1, 64, -17)], |_, _| true);
    // rust: assert!(west.contains(&(-2, -3)) && west.contains(&(0, -1)) && west.len() == 9);
}

queued_jobs_follow_the_centre :: proc() {
}
    // rust: let forced = HashSet::new();
    // rust: let ranges = |center| Ranges {
    // rust: center,
    // rust: radius: 32,
    // rust: extra: &[],
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover: None,
    // rust: band: None,
}
    // rust: let generate = |x, z, priority, order| Queued {
    // rust: priority,
    // rust: at: Some((x, z)),
    // rust: bias: 0,
    // rust: order,
    // rust: job: Job::Generate(x, z),
}
        // Both queued around an earlier centre, where the farther job came first.
    // rust: let earlier = ranges((40, 0));
    // rust: let current = ranges((0, 0));
    // rust: let queued = || {
    // rust: BinaryHeap::from(vec![
    // rust: generate(3, 1, earlier.priority(3, 1) * 4, 1),
    // rust: generate(20, 0, earlier.priority(20, 0) * 4, 2),
    // rust: Queued {
    // rust: priority: i64::MIN,
    // rust: at: None,
    // rust: bias: 0,
    // rust: order: 3,
    // rust: job: Job::Save(Vec::new()),
    // rust: },
    // rust: ])
}
    // rust: let pops = |mut queue: BinaryHeap<Queued>| {
    // rust: std::iter::from_fn(move || queue.pop())
    // rust: .map(|q| q.at)
    // rust: .collect::<Vec<_>>()
}
    // rust: assert_eq!(
    // rust: pops(queued()),
    // rust: [None, Some((20, 0)), Some((3, 1))],
    // rust: "the stale order"
    // rust: );
    // rust: let mut queue = queued();
    // rust: rank_again(&mut queue, |x, z| current.priority(x, z));
    // rust: assert_eq!(pops(queue), [None, Some((3, 1)), Some((20, 0))]);
        // The player moved: the job near the new centre goes first.
    // rust: let mut queue = BinaryHeap::from(vec![generate(3, 1, 0, 1), generate(20, 0, 1, 2)]);
    // rust: let moved = ranges((19, 0));
    // rust: rank_again(&mut queue, |x, z| moved.priority(x, z));
    // rust: assert_eq!(queue.pop().and_then(|q| q.at), Some((20, 0)));
}

    // `ChunkTaskPriorityQueue.release`: a column that unloaded keeps no queued job, so
    // a teleport or a smaller render distance does not spend its workers on the world
    // it left; the other columns' jobs and the jobs without a column (saves, meshes to
    // free) stay, in the same order.
a_released_column_keeps_no_queued_job :: proc() {
}
    // rust: let generate = |x, z, priority, order| Queued {
    // rust: priority,
    // rust: at: Some((x, z)),
    // rust: bias: 0,
    // rust: order,
    // rust: job: Job::Generate(x, z),
}
    // rust: let save = |order| Queued {
    // rust: priority: i64::MIN,
    // rust: at: None,
    // rust: bias: 0,
    // rust: order,
    // rust: job: Job::Save(Vec::new()),
}
    // rust: let queued = || {
    // rust: BinaryHeap::from(vec![
    // rust: generate(0, 0, 0, 1),
    // rust: generate(0, 0, 4, 2),
    // rust: generate(1, 0, 8, 3),
    // rust: generate(9, 9, 12, 4),
    // rust: save(5),
    // rust: ])
}
    // rust: let pops = |mut queue: BinaryHeap<Queued>| {
    // rust: std::iter::from_fn(move || queue.pop())
    // rust: .map(|q| q.at)
    // rust: .collect::<Vec<_>>()
}
        // Nothing goes for a column that is still loaded, or for nothing at all.
    // rust: let mut queue = queued();
    // rust: assert_eq!(release_columns(&mut queue, &FxHashSet::default()), 0);
    // rust: assert_eq!(
    // rust: release_columns(&mut queue, &[(20, 20)].into_iter().collect()),
    // rust: 0
    // rust: );
    // rust: assert_eq!(queue.len(), 5);
        // Both of (0, 0)'s jobs go, its neighbour's and the save stay.
    // rust: let gone: FxHashSet<(i32, i32)> = [(0, 0)].into_iter().collect();
    // rust: assert_eq!(release_columns(&mut queue, &gone), 2);
    // rust: assert_eq!(pops(queue), [None, Some((1, 0)), Some((9, 9))]);
        // Every column leaving at once: only the jobs without one are left.
    // rust: let mut queue = queued();
    // rust: let all: FxHashSet<(i32, i32)> = [(0, 0), (1, 0), (9, 9)].into_iter().collect();
    // rust: assert_eq!(release_columns(&mut queue, &all), 4);
    // rust: assert_eq!(pops(queue), [None]);
}

    // The light and mesh stages submit bounded work, the nearest first:
    // what exceeds the room stays dirty, to be chosen again — from the
    // current centre — as capacity frees. Submitted whole, the queue once
    // held every ready column's jobs and grew with the render distance
    // (#3629); ties break by position, so the choice is deterministic.
bounded_submission_takes_the_nearest_first :: proc() {
}
    // rust: let candidates: Vec<(i64, i32, i32, u32)> = (0..40i32)
    // rust: .map(|i| {
    // rust: let (x, z) = (i / 8 - 2, i % 8 - 3);
    // rust: (
    // rust: i64::from((x - 3).pow(2) + (z - 2).pow(2)),
    // rust: x,
    // rust: z,
    // rust: 1 << (i % 24),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: let mut expected = candidates.clone();
    // rust: expected.sort_unstable();
    // rust: let mut none = candidates.clone();
    // rust: nearest_first(&mut none, 0);
    // rust: assert!(none.is_empty());
    // rust: let mut nearest = candidates;
    // rust: nearest_first(&mut nearest, 5);
    // rust: assert_eq!(nearest, expected[..5]);
    // rust: let mut past = expected.clone();
    // rust: nearest_first(&mut past, expected.len() + 10);
    // rust: assert_eq!(past, expected);
}

    // What the scheduler counts as ready to light: every neighbour a
    // finished column, or a decorated proto chunk past the area — the
    // walk `light_region` makes without its snapshot.
light_readiness_follows_the_region_a_light_job_reads :: proc() {
}
    // rust: let mut world = World::new(horizon_world::registry::BlockStateId(0), 0);
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: let nine = (-1..=1).flat_map(|dz| (-1..=1).map(move |dx| (dx, dz)));
    // rust: for key in nine {
    // rust: world.chunks.insert(key, chunk.clone());
}
        // The kept area is the cross around (0, 0); the corners of the
        // 3x3 light reads lie past it.
    // rust: let in_range = |x: i32, z: i32| x.abs() + z.abs() <= 1;
    // rust: let none = FxHashSet::<(i32, i32)>::default();
    // rust: let empty = FxHashMap::<(i32, i32), Option<Proto>>::default();
    // rust: assert!(light_region_ready(&world, in_range, &none, &empty, 0, 0));
        // A corner is missing, and nothing stands in for it yet.
    // rust: world.chunks.remove(&(1, 1));
    // rust: assert!(!light_region_ready(&world, in_range, &none, &empty, 0, 0));
        // A decorated, checked-in proto chunk past the area lights against.
    // rust: let decorated: FxHashSet<(i32, i32)> = [(1, 1)].into_iter().collect();
    // rust: let mut protos: FxHashMap<(i32, i32), Option<Proto>> = Default::default();
    // rust: protos.insert((1, 1), Some(Box::new(()) as Proto));
    // rust: assert!(light_region_ready(
    // rust: &world, in_range, &decorated, &protos, 0, 0
    // rust: ));
        // The proto is checked out to a job: it cannot be read.
    // rust: protos.insert((1, 1), None);
    // rust: assert!(!light_region_ready(
    // rust: &world, in_range, &decorated, &protos, 0, 0
    // rust: ));
        // A neighbour inside the area waits for the chunk itself.
    // rust: world.chunks.remove(&(1, 0));
    // rust: let mut inside = decorated.clone();
    // rust: inside.insert((1, 0));
    // rust: protos.insert((1, 0), Some(Box::new(()) as Proto));
    // rust: assert!(!light_region_ready(
    // rust: &world, in_range, &inside, &protos, 0, 0
    // rust: ));
}

view_distance_is_vanillas_shape :: proc() {
}
        // ChunkTrackingView.isInViewDistance at render distance 12: a column
        // of slack on each axis, so 533 columns rather than the 441 of a
        // circle of radius 12.
    // rust: let count = |r: i32| {
    // rust: (-40..=40)
    // rust: .flat_map(|x| (-40..=40).map(move |z| (x, z)))
    // rust: .filter(|&(x, z)| in_view_distance((5, -7), r, x + 5, z - 7))
    // rust: .count()
}
    // rust: assert_eq!(count(12), 533);
    // rust: assert_eq!(count(2), 25);
    // rust: for (x, z, inside) in [(12, 0, true), (13, 0, false), (9, 9, true), (10, 9, false)] {
    // rust: assert_eq!(in_view_distance((0, 0), 12, x, z), inside, "({x}, {z})");
    // rust: assert_eq!(
    // rust: in_view_distance((0, 0), 12, -z, -x),
    // rust: inside,
    // rust: "({}, {})",
    // rust: -z,
    // rust: -x
    // rust: );
}
}

    // A view has arrived once the columns at both ends of each of its rows and
    // columns are in: exactly those with a neighbour outside it, at every radius.
    // Then it stays arrived until it changes; a view is `recent`, and waited for,
    // `VIEW_WAIT` at most, and one of no radius not at all.
a_view_has_arrived_once_its_outermost_columns_are_in :: proc() {
}
    // rust: let start = std::time::Instant::now();
    // rust: let center = (3, -4);
    // rust: for r in 0..=16 {
    // rust: let view: FxHashSet<(i32, i32)> = (-r - 1..=r + 1)
    // rust: .flat_map(|x| (-r - 1..=r + 1).map(move |z| (center.0 + x, center.1 + z)))
    // rust: .filter(|&(x, z)| in_view_distance(center, r, x, z))
    // rust: .collect();
    // rust: let arriving = |has: &dyn Fn((i32, i32)) -> bool| {
    // rust: ViewArrival::default().arriving((center, r), start, has)
}
    // rust: assert!(!arriving(&|c| view.contains(&c)), "radius {r}");
    // rust: for &(x, z) in &view {
    // rust: let edge = [(x + 1, z), (x - 1, z), (x, z + 1), (x, z - 1)]
    // rust: .iter()
    // rust: .any(|c| !view.contains(c));
    // rust: let missing = arriving(&|c| c != (x, z) && view.contains(&c));
    // rust: assert_eq!(missing, edge, "radius {r}, column ({x}, {z})");
}
}
    // rust: let mut arrival = ViewArrival::default();
    // rust: let (none, all) = (|_| false, |_| true);
    // rust: assert!(arrival.arriving(((0, 0), 2), start, none));
    // rust: assert!(!arrival.arriving(((0, 0), 2), start, all));
    // rust: assert!(!arrival.arriving(((0, 0), 2), start, none));
        // Moved: waited for again, until `VIEW_WAIT` after the move.
    // rust: let (late, ms) = (start + VIEW_WAIT, std::time::Duration::from_millis(1));
    // rust: assert!(arrival.arriving(((1, 0), 2), start, none));
    // rust: assert!(arrival.arriving(((1, 0), 2), late - ms, none));
    // rust: assert!(arrival.recent(late - ms) && !arrival.recent(late));
    // rust: assert!(!arrival.arriving(((1, 0), 2), late, none));
    // rust: assert!(!arrival.arriving(((1, 0), -1), start, none));
}

GenerationFixture :: struct {
    world: World,
    center: (i32,
    radius: i32,
    extra: Vec<((i32,
    forced: HashSet<(i32,
    generating: FxHashSet<(i32,
    protos: FxHashMap<(i32,
    finishing: FxHashSet<(i32,
    decorates: bool,
    remote: bool,
}
    // rust: impl GenerationFixture {
new :: proc(radius: i32, decorates: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: world: World::new(horizon_world::registry::BlockStateId(0), 0),
    // rust: center: (0, 0),
    // rust: radius,
    // rust: extra: Vec::new(),
    // rust: forced: HashSet::new(),
    // rust: generating: Default::default(),
    // rust: protos: Default::default(),
    // rust: finishing: Default::default(),
    // rust: decorates,
    // rust: remote: false,
}
}
input :: proc(self: ^Self) -> G {
    // Ported from Horizon
    return {}
}
    // rust: GenerationInputs {
    // rust: ranges: Ranges {
    // rust: center: self.center,
    // rust: radius: self.radius,
    // rust: extra: &self.extra,
    // rust: forced: &self.forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover: None,
    // rust: band: None,
    // rust: },
    // rust: world: &self.world,
    // rust: generating: &self.generating,
    // rust: protos: &self.protos,
    // rust: finishing: &self.finishing,
    // rust: decorates: self.decorates,
    // rust: remote: self.remote,
}
}
fill :: proc(self: ^Self) {
}
            // Scheduler only reads membership. Share one real empty column to
            // keep a radius-32 fixture small; chunk content is never consulted.
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: for (_, x, z) in baseline_candidates(self.input(), usize::MAX) {
    // rust: self.world.chunks.insert((x, z), chunk.clone());
}
}
fill_steady :: proc(self: ^Self) {
}
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: for (_, x, z) in baseline_candidates(self.input(), usize::MAX) {
    // rust: if self.input().ranges.in_range(x, z, 1) {
    // rust: self.world.chunks.insert((x, z), chunk.clone());
    // rust: } else {
                    // Generation's outer neighbour margin remains proto;
                    // only columns in the finish range become resident.
    // rust: self.protos.insert((x, z), Some(Box::new(())));
}
}
}
assert_same :: proc(self: ^Self, gate: ^GenerationScan, capacity: uint) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let expected = baseline_candidates(self.input(), capacity);
    // rust: let result = gate.candidates(self.input(), capacity);
    // rust: assert_eq!(result.as_deref().unwrap_or(&[]), expected);
    // rust: result.is_some()
}
}

    // Original scheduling scan, without snapshot bookkeeping, for differential
    // correctness and timing. Keep this independent of the production gate.
baseline_candidates :: proc(input: GenerationInputs<'_>, capacity: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if input.remote || input.generating.len() >= capacity {
    // rust: return Vec::new();
}
    // rust: let margin: i32 = if input.decorates { 3 } else { 1 };
    // rust: let reach = if input.decorates { 2 } else { 1 };
    // rust: let mut wanted = Vec::new();
    // rust: let areas: Vec<_> = std::iter::once((input.ranges.center, input.ranges.radius))
    // rust: .chain(input.ranges.extra.iter().copied())
    // rust: .collect();
    // rust: let missing = |x, z| {
    // rust: !input.world.chunks.contains_key(&(x, z))
    // rust: && !input.generating.contains(&(x, z))
    // rust: && !input.protos.contains_key(&(x, z))
    // rust: && !input.finishing.contains(&(x, z))
}
    // rust: for (center, radius) in areas {
    // rust: let r = radius + margin.max(reach + 1);
    // rust: for dz in -r..=r {
    // rust: for dx in -r..=r {
    // rust: let (x, z) = (center.0 + dx, center.1 + dz);
    // rust: if (input.ranges.in_range(x, z, margin)
    // rust: || input.ranges.near_finished(x, z, reach))
    // rust: && missing(x, z)
    // rust: {
    // rust: wanted.push((input.ranges.distance(x, z), x, z));
}
}
}
}
    // rust: let forced_reach = if input.decorates {
    // rust: FORCED_TERRAIN_RING
    // rust: } else {
    // rust: FORCED_FEATURES_RING
}
    // rust: for &(fx, fz) in input.ranges.forced_chunks() {
    // rust: for dz in -forced_reach..=forced_reach {
    // rust: for dx in -forced_reach..=forced_reach {
    // rust: let (x, z) = (fx + dx, fz + dz);
    // rust: if missing(x, z) {
    // rust: wanted.push((input.ranges.distance(x, z), x, z));
}
}
}
}
    // rust: wanted.sort_unstable();
    // rust: wanted.dedup();
    // rust: wanted.truncate(capacity - input.generating.len());
    // rust: wanted
}

generation_gate_tracks_public_ranges_and_exact_membership :: proc() {
}
    // rust: for decorates in [false, true] {
    // rust: let mut f = GenerationFixture::new(2, decorates);
    // rust: f.fill();
    // rust: let mut gate = GenerationScan::default();
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: assert!(!f.assert_same(&mut gate, 6));
            // Light/mesh state and block content do not affect generation.
    // rust: f.world.dirty_light.insert((0, 0));
    // rust: f.world.dirty_sections.insert((0, 0, 0));
    // rust: Arc::make_mut(f.world.chunks.get_mut(&(0, 0)).unwrap()).lit = true;
    // rust: assert!(!f.assert_same(&mut gate, 6));
            // Same-count removal/replacement must not leave a hole unnoticed.
    // rust: let chunk = f.world.chunks.remove(&(0, 0)).unwrap();
    // rust: f.world.chunks.insert((100, 100), chunk.clone());
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: f.world.chunks.remove(&(100, 100));
    // rust: f.world.chunks.insert((0, 0), chunk);
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: assert!(!f.assert_same(&mut gate, 6));
    // rust: f.center = (1, -1);
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: f.fill();
    // rust: f.assert_same(&mut gate, 6);
    // rust: f.radius += 1;
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: f.fill();
    // rust: f.assert_same(&mut gate, 6);
    // rust: f.extra.push(((20, -20), 2));
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: f.fill();
    // rust: f.assert_same(&mut gate, 6);
    // rust: f.forced.insert((40, 40));
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: f.fill();
    // rust: f.assert_same(&mut gate, 6);
    // rust: f.extra.clear();
    // rust: f.forced.clear();
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: f.remote = true;
    // rust: assert!(!f.assert_same(&mut gate, 6));
    // rust: f.world.chunks.clear();
    // rust: f.remote = false;
    // rust: assert!(f.assert_same(&mut gate, 6));
    // rust: f.fill();
    // rust: f.assert_same(&mut gate, 6);
    // rust: f.world = World::new(horizon_world::registry::BlockStateId(0), 1);
    // rust: assert!(f.assert_same(&mut gate, 6));
}
}

generation_gate_preserves_batches_stage_transitions_and_retries :: proc() {
}
    // rust: for decorates in [false, true] {
    // rust: let mut f = GenerationFixture::new(2, decorates);
    // rust: let mut gate = GenerationScan::default();
    // rust: let mut scheduled = FxHashSet::default();
    // rust: loop {
    // rust: let expected = baseline_candidates(f.input(), 3);
    // rust: let batch = gate.candidates(f.input(), 3).unwrap_or_default();
    // rust: assert_eq!(batch, expected);
    // rust: if batch.is_empty() {
    // rust: break;
}
    // rust: for (_, x, z) in batch {
    // rust: assert!(scheduled.insert((x, z)), "duplicate scheduling");
    // rust: f.generating.insert((x, z));
}
    // rust: if f.generating.len() == 3 {
    // rust: assert!(!f.assert_same(&mut gate, 3)); // capacity pressure
    // rust: } else {
    // rust: f.assert_same(&mut gate, 3);
}
    // rust: for key in std::mem::take(&mut f.generating) {
                    // load miss -> proto -> checked out decoration -> finish.
    // rust: f.protos.insert(key, None);
}
    // rust: gate.exhausted = false; // Done::Proto/Decorated invalidation
}
    // rust: assert!(!scheduled.is_empty());
    // rust: assert!(!f.assert_same(&mut gate, 3));
    // rust: let key = (0, 0);
    // rust: f.protos.remove(&key);
    // rust: f.finishing.insert(key);
    // rust: assert!(!f.assert_same(&mut gate, 3)); // eligibility unchanged
    // rust: f.finishing.remove(&key);
    // rust: f.world.chunks.insert(key, Arc::new(Chunk::empty(0, 0)));
    // rust: gate.exhausted = false; // Done::Generated
    // rust: assert!(f.assert_same(&mut gate, 3));
    // rust: assert!(!f.assert_same(&mut gate, 3));
            // A discarded/pruned proto must be requested again, even without
            // any range or loaded-membership change.
    // rust: let key = scheduled.iter().copied().find(|k| *k != (0, 0)).unwrap();
    // rust: f.protos.remove(&key);
    // rust: gate.exhausted = false;
    // rust: assert!(f.assert_same(&mut gate, 3));
    // rust: assert_eq!(baseline_candidates(f.input(), 3).len(), 1);
}
}

    // Batches taken from the plan are the full scan's, as jobs finish,
    // columns and proto chunks leave and the centre moves.
generation_plan_matches_full_scans_as_columns_arrive :: proc() {
}
    // rust: for decorates in [false, true] {
    // rust: let mut f = GenerationFixture::new(6, decorates);
    // rust: let mut gate = GenerationScan::default();
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: let mut seed = 0x2545_F491_4F6C_DD1Du64;
    // rust: let mut rand = |n: u64| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: seed % n
}
    // rust: let mut scheduled = 0;
    // rust: for step in 0..600 {
    // rust: let capacity = 3 + rand(6) as usize;
    // rust: let expected = baseline_candidates(f.input(), capacity);
    // rust: let batch = gate.candidates(f.input(), capacity).unwrap_or_default();
    // rust: assert_eq!(batch, expected, "step {step}");
    // rust: for (_, x, z) in batch {
    // rust: f.generating.insert((x, z));
    // rust: scheduled += 1;
}
                // Some jobs finish: as a proto chunk, or a final column.
    // rust: let mut done: Vec<_> = f.generating.iter().copied().collect();
    // rust: done.sort_unstable();
    // rust: for key in done {
    // rust: if rand(3) != 0 {
    // rust: continue;
}
    // rust: f.generating.remove(&key);
    // rust: if rand(2) == 0 {
    // rust: f.protos.insert(key, None);
    // rust: } else {
    // rust: f.world.chunks.insert(key, chunk.clone());
}
    // rust: gate.exhausted = false;
}
                // Now and then a column or a proto chunk leaves.
    // rust: if rand(20) == 0 {
    // rust: let mut keys: Vec<_> = f.world.chunks.keys().copied().collect();
    // rust: keys.sort_unstable();
    // rust: if let Some(key) = keys.get(rand(keys.len().max(1) as u64) as usize) {
    // rust: f.world.chunks.remove(key);
}
}
    // rust: if rand(20) == 0 {
    // rust: let mut keys: Vec<_> = f.protos.keys().copied().collect();
    // rust: keys.sort_unstable();
    // rust: if let Some(key) = keys.get(rand(keys.len().max(1) as u64) as usize) {
    // rust: f.protos.remove(key);
    // rust: gate.invalidate();
}
}
    // rust: if step == 300 {
    // rust: f.center = (3, -2);
}
}
    // rust: assert!(scheduled > 200);
}
}

generation_scan_looks_at_overlapping_areas_once :: proc() {
}
        // A server's players: many areas around one spot, some apart, one
        // touching another only at a corner, and part of the land present.
    // rust: for decorates in [false, true] {
    // rust: let mut f = GenerationFixture::new(10, decorates);
    // rust: for i in 0..40 {
    // rust: f.extra.push(((i % 7 - 3, i / 7 - 3), 19));
}
    // rust: f.extra.push(((200, -150), 19));
    // rust: f.extra.push(((243, -107), 19));
    // rust: f.extra.push(((-60, 5), 4));
    // rust: f.forced.insert((90, 90));
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: for x in -40i32..40 {
    // rust: for z in -40i32..40 {
    // rust: match (x * 7 + z * 13).rem_euclid(5) {
    // rust: 0 => drop(f.world.chunks.insert((x, z), chunk.clone())),
    // rust: 1 => drop(f.protos.insert((x, z), None)),
    // rust: 2 if x % 3 == 0 => drop(f.generating.insert((x, z))),
    // rust: _ => {}
}
}
}
    // rust: assert!(baseline_candidates(f.input(), usize::MAX).len() > 1000);
    // rust: for capacity in [usize::MAX, f.generating.len() + 7] {
    // rust: let mut gate = GenerationScan::default();
    // rust: assert!(f.assert_same(&mut gate, capacity));
}
}
}

generation_scan_benchmark :: proc() {
}
//         use std::{hint::black_box, time::Instant};
    // rust: let mut f = GenerationFixture::new(32, true);
    // rust: f.fill_steady();
    // rust: let mut gate = GenerationScan::default();
    // rust: f.assert_same(&mut gate, 12);
    // rust: assert!(!f.assert_same(&mut gate, 12));
FRAMES :: 2000
    // rust: let measure = |optimized: bool, dynamic: bool| {
    // rust: let mut samples = Vec::new();
    // rust: let mut scans = 0;
    // rust: let mut jobs = 0;
    // rust: for repetition in 0..9 {
    // rust: let mut fixture = GenerationFixture::new(32, true);
    // rust: fixture.fill_steady();
    // rust: let saved = fixture.world.chunks.get(&(0, 0)).unwrap().clone();
    // rust: let mut gate = GenerationScan::default();
    // rust: gate.candidates(fixture.input(), 12);
    // rust: let start = Instant::now();
    // rust: let mut count = 0;
    // rust: let mut scheduled = 0;
    // rust: for frame in 0..FRAMES {
                    // Remove a column, queue generation, then accept a saved
                    // load completion. Both schedulers see identical events.
    // rust: if dynamic && frame % 32 == 0 {
    // rust: fixture.world.chunks.remove(&(0, 0));
}
    // rust: if dynamic && frame % 32 == 1 {
    // rust: fixture.generating.remove(&(0, 0));
    // rust: fixture.world.chunks.insert((0, 0), saved.clone());
    // rust: gate.exhausted = false; // Done::Generated
}
    // rust: let result = if optimized {
    // rust: let result = gate.candidates(black_box(fixture.input()), 12);
    // rust: count += usize::from(result.is_some());
    // rust: result.unwrap_or_default()
    // rust: } else {
    // rust: count += 1;
    // rust: baseline_candidates(black_box(fixture.input()), 12)
}
    // rust: let expected_jobs = usize::from(dynamic && frame % 32 == 0);
    // rust: assert_eq!(result.len(), expected_jobs);
    // rust: for (_, x, z) in black_box(result) {
    // rust: assert_eq!((x, z), (0, 0));
    // rust: fixture.generating.insert((x, z));
    // rust: scheduled += 1;
}
}
    // rust: if repetition != 0 {
    // rust: samples.push(start.elapsed().as_secs_f64() * 1e9 / FRAMES as f64);
}
    // rust: assert!(fixture.generating.is_empty());
    // rust: assert_eq!(fixture.world.chunks.len(), f.world.chunks.len());
    // rust: scans = count;
    // rust: jobs = scheduled;
}
    // rust: samples.sort_by(f64::total_cmp);
    // rust: (samples[samples.len() / 2], scans, jobs)
}
    // rust: println!(
    // rust: "radius=32 decorates=true positions/frame=5041 loaded_keys={} proto_keys={} frames/sample={FRAMES} warmup=1 measured=8",
    // rust: f.world.chunks.len(),
    // rust: f.protos.len()
    // rust: );
    // rust: for dynamic in [false, true] {
    // rust: let (before, baseline_scans, before_jobs) = measure(false, dynamic);
    // rust: let (after, optimized_scans, after_jobs) = measure(true, dynamic);
    // rust: assert_eq!(before_jobs, after_jobs);
    // rust: println!(
    // rust: "dynamic={dynamic}: baseline={before:.1}ns/frame optimized={after:.1}ns/frame speedup={:.2}x scans={baseline_scans}/{optimized_scans} jobs={before_jobs}/{after_jobs}",
    // rust: before / after
    // rust: );
}
}

    // The ranges `Streaming::update` checks at each step, from generation to
    // light, must let every chunk the player spawns on finish and light: the
    // 3x3 columns around the player need their own 3x3 neighbours finished,
    // each of those its 3x3 neighbours decorated, and each of those its 3x3
    // neighbours generated and kept. Render distance 2 once stopped short.
spawn_neighbourhood_completes_at_every_distance :: proc() {
}
    // rust: let forced = HashSet::new();
    // rust: for decorates in [true, false] {
    // rust: let (margin, reach) = Ranges::margins(decorates);
    // rust: for radius in 2..=32 {
    // rust: let r = Ranges {
    // rust: center: (5, -7),
    // rust: radius,
    // rust: extra: &[],
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover: None,
    // rust: band: None,
}
    // rust: let square = |x: i32, z: i32, n: i32| {
    // rust: (-n..=n).flat_map(move |dz| (-n..=n).map(move |dx| (x + dx, z + dz)))
}
    // rust: let generated = |x, z| {
    // rust: r.requested(x, z, decorates)
    // rust: && (x - r.center.0).abs() <= radius + margin.max(reach + 1)
    // rust: && (z - r.center.1).abs() <= radius + margin.max(reach + 1)
}
    // rust: let proto_kept = |x, z| r.in_range(x, z, 4) || r.near_finished(x, z, 2);
    // rust: let decorated =
    // rust: |x, z| !decorates || r.in_range(x, z, 2) || r.near_finished(x, z, 1);
    // rust: let chunk_kept = |x, z| r.chunk_kept(x, z, decorates);
    // rust: let unloaded = |x, z| r.unloaded(x, z, decorates);
    // rust: let finishes = |x: i32, z: i32| {
    // rust: r.in_range(x, z, 1)
    // rust: && chunk_kept(x, z)
    // rust: && !unloaded(x, z)
    // rust: && square(x, z, 1).all(|(nx, nz)| {
    // rust: decorated(nx, nz)
    // rust: && (!decorates
    // rust: || square(nx, nz, 1)
    // rust: .all(|(gx, gz)| generated(gx, gz) && proto_kept(gx, gz)))
    // rust: && generated(nx, nz)
    // rust: && proto_kept(nx, nz)
    // rust: })
}
    // rust: let (cx, cz) = r.center;
    // rust: for (x, z) in square(cx, cz, 1) {
    // rust: for (nx, nz) in square(x, z, 1) {
    // rust: assert!(
    // rust: finishes(nx, nz),
    // rust: "radius {radius} (decorates: {decorates}): ({nx}, {nz}) never finishes"
    // rust: );
}
}
}
}
}

    // A column generation asks for is kept when it arrives finished (loaded
    // from the save) and is not unloaded right after: either way it would be
    // asked for and loaded again on the next frame, forever (8 such columns
    // after a teleport at render distance 16 held 8 of the in-flight slots).
requested_columns_stay_loaded :: proc() {
}
    // rust: let forced = HashSet::new();
    // rust: for decorates in [true, false] {
    // rust: for radius in 2..=32 {
    // rust: let r = Ranges {
    // rust: center: (5, -7),
    // rust: radius,
    // rust: extra: &[((radius * 2 + 9, 3), 4)],
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover: None,
    // rust: band: None,
}
    // rust: let span = radius * 3 + 20;
    // rust: for x in -span..=span {
    // rust: for z in -span..=span {
    // rust: if r.requested(x, z, decorates) {
    // rust: assert!(
    // rust: r.chunk_kept(x, z, decorates),
    // rust: "radius {radius} (decorates: {decorates}): ({x}, {z}) is asked for but dropped"
    // rust: );
}
    // rust: if r.chunk_kept(x, z, decorates) {
    // rust: assert!(
    // rust: !r.unloaded(x, z, decorates),
    // rust: "radius {radius} (decorates: {decorates}): ({x}, {z}) is kept then unloaded"
    // rust: );
}
}
}
}
}
}

    // An idle dedicated server keeps no area around its centre: only a spawn
    // search's chunk (FULL alone: its 3x3 decorated, 5x5 generated) and the
    // forced chunks.
no_area_around_an_idle_servers_centre :: proc() {
}
    // rust: let forced = HashSet::from([(30, 30)]);
    // rust: let extra = [((5, -3), -1)];
    // rust: let r = Ranges {
    // rust: center: (5, -3),
    // rust: radius: -1,
    // rust: extra: &extra,
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover: None,
    // rust: band: None,
}
    // rust: for x in -5i32..=15 {
    // rust: for z in -13i32..=7 {
    // rust: let d = (x - 5).abs().max((z + 3).abs());
    // rust: assert_eq!(r.in_range(x, z, 1), d == 0, "({x}, {z})");
    // rust: assert_eq!(r.chunk_kept(x, z, true), d <= 2, "({x}, {z})");
    // rust: assert_eq!(r.requested(x, z, true), d <= 2, "({x}, {z})");
}
}
    // rust: assert!(r.in_range(30, 30, 1));
    // rust: let idle = Ranges { extra: &[], ..r };
    // rust: assert!(!idle.requested(5, -3, true) && idle.unloaded(5, -3, true));
}

    // A server player's area (`lan_update_streaming`: the server view
    // distance + 1) finishes vanilla's FULL square: PLAYER_LOADING tickets at
    // level 31 out to the view distance, FULL (33) two chunks past it. Every
    // chunk the player tracks has its 3x3 neighbourhood finished, so it can
    // be lit and sent, and generation reaches vanilla's FEATURES (34) and
    // TERRAIN (35) rings.
server_player_areas_finish_vanillas_full_square :: proc() {
}
    // rust: let forced = HashSet::new();
    // rust: for view in 2..=32 {
    // rust: let extra = [((40, -9), view + 1)];
    // rust: let r = Ranges {
                // The window's own area, far away.
    // rust: center: (-400, 300),
    // rust: radius: 2,
    // rust: extra: &extra,
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover: None,
    // rust: band: None,
}
    // rust: let level = |x: i32, z: i32| 31 + ((x - 40).abs().max((z + 9).abs()) - view).max(0);
    // rust: for x in 40 - view - 8..=40 + view + 8 {
    // rust: for z in -9 - view - 8..=-9 + view + 8 {
    // rust: assert_eq!(
    // rust: r.in_range(x, z, 1),
    // rust: level(x, z) <= 33,
    // rust: "view {view}: ({x}, {z})"
    // rust: );
    // rust: assert_eq!(
    // rust: r.requested(x, z, true),
    // rust: level(x, z) <= 35,
    // rust: "view {view}: ({x}, {z})"
    // rust: );
    // rust: assert_eq!(
    // rust: r.unloaded(x, z, true),
    // rust: level(x, z) > 35,
    // rust: "view {view}: ({x}, {z})"
    // rust: );
                    // ChunkTrackingView.contains, at any view distance the player may ask for.
    // rust: let tracked = |v: i64| {
    // rust: let gap = |d: i32| i64::from(((d).abs() - 2).max(0));
    // rust: gap(x - 40).pow(2) + gap(z + 9).pow(2) < v * v
}
    // rust: if tracked(i64::from(view)) {
    // rust: for (dx, dz) in (-1..=1).flat_map(|dx| (-1..=1).map(move |dz| (dx, dz))) {
    // rust: assert!(
    // rust: r.in_range(x + dx, z + dz, 1),
    // rust: "view {view}: ({x}, {z}) tracked, not lit"
    // rust: );
}
}
}
}
}
}

    // A `/forceload`ed chunk holds a FORCED ticket at level 31
    // (`ChunkMap.FORCED_TICKET_LEVEL`): the level rises one per ring
    // (`ChunkTracker.computeLevelFromNeighbor`) and picks the column's
    // status (`ChunkLevel.generationStatus`). So vanilla finishes the two
    // rings around it (33), gives the third its features (34) and the
    // fourth its terrain (35), and the rings past that are left alone.
forced_chunks_reach_vanillas_rings :: proc() {
}
    // rust: let forced: HashSet<(i32, i32)> = [(40, -40)].into();
    // rust: let r = Ranges {
            // The player's own area, far away.
    // rust: center: (-400, 300),
    // rust: radius: 2,
    // rust: extra: &[],
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover: None,
    // rust: band: None,
}
    // rust: let level = |x: i32, z: i32| 31 + (x - 40).abs().max((z + 40).abs());
    // rust: for x in 40 - 6..=40 + 6 {
    // rust: for z in -40 - 6..=-40 + 6 {
                // The full ring: the column becomes a level chunk.
    // rust: assert_eq!(r.in_range(x, z, 1), level(x, z) <= 33, "({x}, {z})");
                // The features ring, and the terrain ring.
    // rust: assert_eq!(r.in_range(x, z, 2), level(x, z) <= 34, "({x}, {z})");
    // rust: assert_eq!(r.in_range(x, z, 3), level(x, z) <= 35, "({x}, {z})");
    // rust: assert_eq!(r.requested(x, z, true), level(x, z) <= 35, "({x}, {z})");
    // rust: assert_eq!(r.chunk_kept(x, z, true), level(x, z) <= 35, "({x}, {z})");
    // rust: assert_eq!(r.unloaded(x, z, true), level(x, z) > 35, "({x}, {z})");
}
}
        // Generation reaches the terrain ring: the features ring is
        // decorated from it.
    // rust: let mut fixture = GenerationFixture::new(2, true);
    // rust: fixture.center = (-400, 300);
    // rust: fixture.forced = forced;
    // rust: let candidates = GenerationScan::default()
    // rust: .candidates(fixture.input(), usize::MAX)
    // rust: .expect("a scan");
    // rust: for (dx, dz) in [(-4, 0), (4, 0), (0, -4), (0, 4), (3, 3)] {
    // rust: assert!(
    // rust: candidates
    // rust: .iter()
    // rust: .any(|&(_, x, z)| (x, z) == (40 + dx, -40 + dz)),
    // rust: "the terrain ring at ({}, {}) is not generated",
    // rust: 40 + dx,
    // rust: -40 + dz
    // rust: );
}
}
}

    // rust: mod cover_tests {
//     use super::*;

areas :: proc(seed: ^u64, n: uint, spread: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut next = |m: i32| {
    // rust: *seed ^= *seed << 13;
    // rust: *seed ^= *seed >> 7;
    // rust: *seed ^= *seed << 17;
    // rust: (*seed % (2 * m as u64 + 1)) as i32 - m
}
    // rust: (0..n)
    // rust: .map(|_| ((next(spread), next(spread)), 2 + next(14).abs()))
    // rust: .collect()
}

    // Every question streaming asks gets the same answer with the grid.
    //
    // A debug build checks every fourth cell of each row, shifted by row and case so the cases still cover every
    // cell's position relative to the areas: the full check took 20 of the ~30 s of the crate's tests.
    // `cargo test --release -p horizon-client --lib the_grid_answers_as_the_scan` checks every cell.
the_grid_answers_as_the_scan :: proc() {
}
    // rust: let stride = if cfg!(debug_assertions) { 4 } else { 1 };
    // rust: let mut seed = 0x9E37_79B9_7F4A_7C15u64;
    // rust: let forced: HashSet<(i32, i32)> = [(40, -40)].into();
    // rust: for case in 0..60 {
    // rust: let extra = areas(&mut seed, 2 + case % 20, [4, 30, 120][case % 3]);
    // rust: let cover = ExtraCover::new(&extra).expect("a grid");
    // rust: let ranges = |cover| Ranges {
    // rust: center: (3, -2),
    // rust: radius: 10,
    // rust: extra: &extra,
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover,
    // rust: band: None,
}
    // rust: let (scan, grid) = (ranges(None), ranges(Some(&cover)));
    // rust: let span = [4, 30, 120][case % 3] + 40;
    // rust: for z in -span..=span {
    // rust: let first = -span + (z + case as i32).rem_euclid(stride);
    // rust: for x in (first..=span).step_by(stride as usize) {
    // rust: for m in 0..=ExtraCover::REACH + 2 {
    // rust: assert_eq!(
    // rust: scan.in_extra(x, z, m),
    // rust: grid.in_extra(x, z, m),
    // rust: "case {case} ({x}, {z}) {m}"
    // rust: );
}
    // rust: for d in [false, true] {
    // rust: assert_eq!(scan.unloaded(x, z, d), grid.unloaded(x, z, d));
    // rust: assert_eq!(scan.requested(x, z, d), grid.requested(x, z, d));
    // rust: assert_eq!(scan.chunk_kept(x, z, d), grid.chunk_kept(x, z, d));
}
}
}
}
}

    // Players thousands of blocks apart: no grid fits them, and the buckets
    // answer what a scan of every area does, the nearest centre included.
the_buckets_answer_as_the_scan :: proc() {
}
    // rust: let mut seed = 0x51_7CC1_B727_220Au64;
    // rust: let forced: HashSet<(i32, i32)> = HashSet::new();
    // rust: for case in 0..12 {
            // Spread over 6000 columns (96 000 blocks), some side by side.
    // rust: let mut extra = areas(&mut seed, 2 + case * 9, 3000);
    // rust: extra.push((extra[0].0, 10));
    // rust: extra.push(((extra[1].0.0 + 5, extra[1].0.1 - 70), 4));
    // rust: let cover = ExtraCover::new(&extra).expect("buckets");
    // rust: let ranges = |cover| Ranges {
    // rust: center: (3, -2),
    // rust: radius: 10,
    // rust: extra: &extra,
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover,
    // rust: band: None,
}
    // rust: let (scan, buckets) = (ranges(None), ranges(Some(&cover)));
            // Around each area, and on a coarse lattice over the whole spread.
    // rust: let near = extra.iter().flat_map(|&((cx, cz), _)| {
    // rust: (-80..=80)
    // rust: .step_by(7)
    // rust: .flat_map(move |dz| (-80..=80).step_by(7).map(move |dx| (cx + dx, cz + dz)))
    // rust: });
    // rust: let lattice = (-3200..=3200)
    // rust: .step_by(97)
    // rust: .flat_map(|z| (-3200..=3200).step_by(89).map(move |x| (x, z)));
    // rust: for (x, z) in near.chain(lattice) {
    // rust: assert_eq!(
    // rust: scan.distance(x, z),
    // rust: buckets.distance(x, z),
    // rust: "case {case} ({x}, {z})"
    // rust: );
    // rust: for m in 0..=ExtraCover::REACH {
    // rust: assert_eq!(
    // rust: scan.in_extra(x, z, m),
    // rust: buckets.in_extra(x, z, m),
    // rust: "case {case} ({x}, {z}) {m}"
    // rust: );
}
}
}
}

a_stale_or_impossible_grid_is_not_used :: proc() {
}
    // rust: let mut cover = None;
    // rust: ExtraCover::refresh(&mut cover, &[((0, 0), 11), ((5, 5), 11)]);
    // rust: assert!(ExtraCover::matching(&cover, &[((0, 0), 11), ((5, 5), 11)]).is_some());
    // rust: assert!(ExtraCover::matching(&cover, &[((0, 0), 11), ((5, 6), 11)]).is_none());
        // Too far apart for a mebibyte of grid: buckets alone. One area alone: scans.
    // rust: let far = ExtraCover::new(&[((0, 0), 11), ((100_000, 0), 11)]).expect("buckets");
    // rust: assert!(far.grid.is_none());
    // rust: assert!(ExtraCover::new(&[((0, 0), 11)]).is_none());
    // rust: assert!(ExtraCover::new(&[((i32::MAX - 1, 0), 11), ((i32::MAX - 3, 0), 11)]).is_none());
    // rust: assert!(ExtraCover::new(&[((0, i32::MAX - 1), 11), ((0, i32::MAX - 3), 11)]).is_none());
    // rust: assert!(ExtraCover::new(&[((0, i32::MIN + 1), 11), ((0, i32::MIN + 3), 11)]).is_none());
}

    // cargo test --release -p horizon-client --lib cover_tests::cover_cost -- --ignored --nocapture
cover_cost :: proc() {
}
    // rust: let forced = HashSet::new();
    // rust: for players in [10usize, 25, 50] {
            // The benchmark's bots: most near spawn, a fifth flying outwards.
    // rust: let extra: Vec<_> = (0..players)
    // rust: .map(|i| {
    // rust: let a = i as f64 * 2.399;
    // rust: let d = if i % 5 == 0 { 30.0 } else { 3.0 };
    // rust: (((a.cos() * d) as i32, (a.sin() * d) as i32), 11)
    // rust: })
    // rust: .collect();
    // rust: let cover = ExtraCover::new(&extra).unwrap();
    // rust: let ranges = |cover| Ranges {
    // rust: center: (0, 0),
    // rust: radius: 10,
    // rust: extra: &extra,
    // rust: forced: &forced,
    // rust: mod_forced: &NO_CHUNKS,
    // rust: cover,
    // rust: band: None,
}
            // The columns streaming asks about: everything kept, and the
            // generation scan's ring past it.
    // rust: let columns: Vec<(i32, i32)> = (-60..=60)
    // rust: .flat_map(|z| (-60..=60).map(move |x| (x, z)))
    // rust: .filter(|&(x, z)| {
    // rust: ranges(None).requested(x, z, true) || !ranges(None).unloaded(x, z, true)
    // rust: })
    // rust: .collect();
    // rust: let rounds = 100;
    // rust: let time = |r: &Ranges| {
    // rust: let t = std::time::Instant::now();
    // rust: let mut n = 0usize;
    // rust: for _ in 0..rounds {
    // rust: for &(x, z) in &columns {
    // rust: n += usize::from(r.unloaded(x, z, true));
    // rust: n += usize::from(r.requested(x, z, true));
    // rust: n += usize::from(r.in_range(x, z, 1));
}
}
    // rust: std::hint::black_box(n);
    // rust: t.elapsed().as_secs_f64() * 1e3 / f64::from(rounds)
}
    // rust: let t = std::time::Instant::now();
    // rust: for _ in 0..rounds {
    // rust: std::hint::black_box(ExtraCover::new(std::hint::black_box(&extra)));
}
    // rust: let build = t.elapsed().as_secs_f64() * 1e3 / f64::from(rounds);
    // rust: println!(
    // rust: "{players} players, {} columns, 3 questions each: scan {:.3} ms, grid {:.3} ms (+ {build:.3} ms to build)",
    // rust: columns.len(),
    // rust: time(&ranges(None)),
    // rust: time(&ranges(Some(&cover))),
    // rust: );
}
}
}
