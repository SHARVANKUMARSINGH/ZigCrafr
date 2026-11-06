//! Transpiled from Horizon Rust crate
//! Module: horizon-world_generator_structures
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! STRUCTURE_STARTS / STRUCTURE_REFERENCES for the chunk generator.
// use super::{
    // rust: biome::BiomeId,
    // rust: block_feature::FeatureBlockBindings,
    // rust: generator::{ChunkWork, GeneratorData, GeneratorError, shard_of},
    // rust: structure::{
    // rust: StructureResources,
    // rust: jigsaw::PoolPiece,
    // rust: start::{
    // rust: Piece, Rings, StartContext, StructureRegistry, StructureStart, beardifier,
    // rust: create_starts, may_start, try_generate,
    // rust: },
    // rust: stronghold::RingSearch,
    // rust: },
}
// use horizon_core::{density::Beardifier, position::ChunkPos};
// use serde_json::Value;
// use std::collections::BTreeMap;
// use std::{
    // rust: collections::{BTreeSet, HashMap},
    // rust: sync::{
    // rust: Arc, Condvar, Mutex, OnceLock, RwLock, TryLockError,
    // rust: atomic::{AtomicUsize, Ordering},
    // rust: },
}

    // rust: pub(super) type Starts = Arc<Vec<Arc<StructureStart>>>;
    // rust: impl StructureState {
    /// [`StartCache::census`].
    // rust: pub(super) fn start_census(&self) -> (usize, usize) {
    // rust: self.starts.census()
}
}
    // rust: pub(super) struct StructureState {
    // rust: pub(super) registry: StructureRegistry,
    // rust: pub(super) resources: Arc<StructureResources>,
    // rust: pub(super) bindings: FeatureBlockBindings<'static>,
    // rust: possible_sets: Vec<usize>,
    /// Structure indices of each decoration step, in registry order.
    // rust: pub(super) by_step: Vec<Vec<usize>>,
    // rust: starts: StartCache,
    // rust: start_work: ChunkWork,
    /// Concentric ring positions, computed on first use and shared with
    /// later generators of the same seed and dimension.
    // rust: rings: Arc<OnceLock<Rings>>,
    /// Their biome searches while they are computed.
    // rust: ring_work: OnceLock<RingWork>,
    /// The seed the rings are searched with when it is not the world's (a superflat world's 0).
    // rust: pub(super) ring_seed: Option<i64>,
    /// The biome source is a `FixedBiomeSource` (a single-biome world, a superflat one).
    // rust: pub(super) fixed_biome: bool,
    /// `StructureRegistry::zone_reach`.
    // rust: zone_reach: i32,
}

/// generateRingPositions' biome searches, shared out. Vanilla runs each as
/// its own task on its worker pool; here every thread that needs the rings
/// before they exist takes searches until none are left, then waits for the
/// ones others took. Done by the first thread alone, the 128 stronghold
/// searches kept every other worker blocked for seconds after each world load.
pub const RingWork = struct {
    /// The biome source is a `FixedBiomeSource`, which has its own horizontal search.
    fixed: bool,
    /// The concentric-ring sets, some with no positions.
    sets: std.ArrayList(usize),
    /// Set index and search, sets in `possible_sets` order.
    searches: Vec<(usize,
    next: AtomicUsize,
    found: std.ArrayList(OnceLock<ChunkPos)>,
    left: Mutex<usize>,
    finished: Condvar,
};
    // rust: impl RingWork {
pub fn new(sets: Vec<(usize) void {
}
    // rust: let indices = sets.iter().map(|(set, _)| *set).collect();
    // rust: let searches: Vec<(usize, RingSearch)> = sets
    // rust: .into_iter()
    // rust: .flat_map(|(set, searches)| searches.into_iter().map(move |s| (set, s)))
    // rust: .collect();
    // rust: Self {
    // rust: fixed: false,
    // rust: sets: indices,
    // rust: next: AtomicUsize::new(0),
    // rust: found: (0..searches.len()).map(|_| OnceLock::new()).collect(),
    // rust: left: Mutex::new(searches.len()),
    // rust: finished: Condvar::new(),
    // rust: searches,
}
}
    /// Run searches until none are left to take, then wait for the rest.
    // rust: fn help<'a>(
    // rust: &self,
    // rust: preferred: impl Fn(usize) -> &'a BTreeSet<BiomeId>,
    // rust: biomes: &mut dyn FnMut(&[[i32; 3]]) -> Vec<BiomeId>,
    // rust: ) {
    // rust: loop {
    // rust: let i = self.next.fetch_add(1, Ordering::Relaxed);
    // rust: let Some((set, search)) = self.searches.get(i) else {
    // rust: break;
}
    // rust: let found = if self.fixed {
    // rust: search.find_fixed(preferred(*set), biomes)
    // rust: } else {
    // rust: search.find(preferred(*set), biomes)
}
    // rust: let _ = self.found[i].set(found);
    // rust: let mut left = self.left.lock().unwrap();
    // rust: *left -= 1;
    // rust: if *left == 0 {
    // rust: self.finished.notify_all();
}
}
    // rust: let mut left = self.left.lock().unwrap();
    // rust: while *left > 0 {
    // rust: left = self.finished.wait(left).unwrap();
}
}
    /// The positions by set name, once every search is done.
pub fn rings(self: *Self, name: impl Fn(usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut rings: Rings = self
    // rust: .sets
    // rust: .iter()
    // rust: .map(|&set| (name(set), Vec::new()))
    // rust: .collect();
    // rust: for ((set, _), found) in self.searches.iter().zip(&self.found) {
    // rust: if let Some(positions) = rings.get_mut(&name(*set)) {
    // rust: positions.push(*found.get().expect("every search finished"));
}
}
    // rust: rings
}
}
pub const START_CACHE_LIMIT: usize = 65536;
pub const START_SHARDS: usize = 64;

/// The built starts by chunk, in shards: a lookup locks one shard for
/// reading. Each generated chunk reads the 289 start chunks around it
/// (`references`) and the server thread reads the starts of the chunks its
/// mobs and players are in; with one lock for all, the server thread waited
/// on the workers.
///
/// Each shard keeps two generations: a full one becomes the old one, and a
/// start found in the old one moves back to the new. The starts still in use
/// (the chunks around every player, which natural spawning asks about each
/// tick) stay, where clearing a full shard threw them away and players spread
/// far apart had their villages' jigsaws built again and again.
pub const StartCache = struct {
    shards: *[RwLock<StartShard]>,
};
pub const StartShard = struct {
    new: HashMap<(i32,
    old: HashMap<(i32,
};
    // rust: impl StartShard {
    /// Room for one more in the new generation.
pub fn make_room(self: *Self) void {
}
    // rust: if self.new.len() >= START_CACHE_LIMIT / START_SHARDS {
    // rust: self.old = std::mem::take(&mut self.new);
}
}
}
    // rust: impl StartCache {
pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: shards: (0..START_SHARDS).map(|_| RwLock::default()).collect(),
}
}
pub fn shard(self: *Self, key: (i32) void {
}
    // rust: &self.shards[shard_of(key, START_SHARDS)]
}
pub fn get(self: *Self, key: (i32) void {
}
    // rust: let shard = self.shard(key);
    // rust: {
    // rust: let read = shard.read().unwrap();
    // rust: if let Some(found) = read.new.get(&key) {
    // rust: return Some(found.clone());
}
    // rust: if !read.old.contains_key(&key) {
    // rust: return None;
}
}
    // rust: let mut write = shard.write().unwrap();
    // rust: if let Some(found) = write.new.get(&key) {
    // rust: return Some(found.clone());
}
    // rust: let found = write.old.remove(&key)?;
    // rust: write.make_room();
    // rust: write.new.insert(key, found.clone());
    // rust: Some(found)
}
    /// Keeps `starts` unless another thread built the same chunk's first:
    /// everyone keeps the first, so placement state on its pieces is shared.
pub fn insert_first(self: *Self, key: (i32) void {
}
    // rust: let mut shard = self.shard(key).write().unwrap();
    // rust: let first = shard.new.remove(&key).or_else(|| shard.old.remove(&key));
    // rust: shard.make_room();
    // rust: shard
    // rust: .new
    // rust: .entry(key)
    // rust: .or_insert(first.unwrap_or(starts))
    // rust: .clone()
}
    /// Chunks cached, and how many of them hold a start.
pub fn census(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut census = (0, 0);
    // rust: for shard in &self.shards {
    // rust: let shard = shard.read().unwrap();
    // rust: census.0 += shard.new.len() + shard.old.len();
    // rust: census.1 += shard
    // rust: .new
    // rust: .values()
    // rust: .chain(shard.old.values())
    // rust: .filter(|s| !s.is_empty())
    // rust: .count();
}
    // rust: census
}
pub fn replace(self: *Self, key: (i32) void {
}
    // rust: let mut shard = self.shard(key).write().unwrap();
    // rust: shard.old.remove(&key);
    // rust: if !shard.new.contains_key(&key) {
    // rust: shard.make_room();
}
    // rust: shard.new.insert(key, starts);
}
pub fn clear(self: *Self) void {
}
    // rust: for shard in &self.shards {
    // rust: *shard.write().unwrap() = StartShard::default();
}
}
}

pub fn biome_set(data: *GeneratorData, value: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names: Vec<&str> = match value {
    // rust: Value::String(s) => vec![s.as_str()],
    // rust: Value::Array(a) => a.iter().filter_map(Value::as_str).collect(),
    // rust: _ => Vec::new(),
}
    // rust: let mut out = BTreeSet::new();
    // rust: for name in names {
    // rust: match name.strip_prefix('#') {
    // rust: Some(tag) => {
    // rust: for biome in data.biome_tags.get(tag).into_iter().flatten() {
    // rust: out.extend(data.biome_id(biome));
}
}
    // rust: None => out.extend(data.biome_id(name)),
}
}
    // rust: Ok(out)
}
    // rust: impl StructureState {
    // rust: pub(super) fn new(
    // rust: data: &Arc<GeneratorData>,
    // rust: possible_biomes: &BTreeSet<BiomeId>,
    // rust: rings: Arc<OnceLock<Rings>>,
    // rust: ) -> Result<Option<Self>, GeneratorError> {
    // rust: let (Some(resources), Some(raw)) = (&data.structures, &data.structure_resources) else {
    // rust: return Ok(None);
}
    // rust: let registry =
    // rust: StructureRegistry::new(&raw.structures, &raw.sets, raw.pools.clone(), &|value| {
    // rust: biome_set(data, value)
    // rust: })?;
    // rust: let possible_sets = registry
    // rust: .sets
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, set)| {
    // rust: set.structures
    // rust: .iter()
    // rust: .any(|(s, _)| !registry.structures[*s].biomes.is_disjoint(possible_biomes))
    // rust: })
    // rust: .map(|(i, _)| i)
    // rust: .collect();
    // rust: let mut by_step = vec![Vec::new(); super::structure::start::STEPS.len()];
    // rust: for (i, def) in registry.structures.iter().enumerate() {
    // rust: by_step[def.step].push(i);
}
    // rust: let mut bindings = data.feature_block_bindings()?;
        // Processors that test what a block is made of read canOcclude.
    // rust: if let Some(blocks) = data
    // rust: .feature_resources
    // rust: .as_ref()
    // rust: .and_then(|r| r.blocks.as_ref())
    // rust: {
    // rust: bindings = bindings.with_block_properties(&blocks.properties)?;
}
    // rust: let zone_reach = registry.zone_reach();
    // rust: Ok(Some(Self {
    // rust: zone_reach,
    // rust: registry,
    // rust: resources: resources.clone(),
    // rust: bindings,
    // rust: possible_sets,
    // rust: by_step,
    // rust: starts: StartCache::new(),
    // rust: start_work: ChunkWork::new(),
    // rust: rings,
    // rust: ring_work: OnceLock::new(),
    // rust: ring_seed: None,
    // rust: fixed_biome: false,
    // rust: }))
}
    /// `FlatLevelGeneratorSettings.structureOverrides`: only the structure sets named
    /// (`minecraft:villages`) may generate.
    // rust: pub(super) fn restrict_to(&mut self, names: &[String]) {
    // rust: let registry = &self.registry;
    // rust: let bare = |name: &str| name.strip_prefix("minecraft:").unwrap_or(name).to_owned();
        // `lenientOptionalFieldOf`: a list naming a set that does not exist fails to decode,
        // which counts as the key being absent: every set generates.
    // rust: if names.iter().any(|name| {
    // rust: !registry
    // rust: .sets
    // rust: .iter()
    // rust: .any(|set| bare(&set.name) == bare(name))
    // rust: }) {
    // rust: return;
}
    // rust: self.possible_sets.retain(|&set| {
    // rust: names.iter().any(|name| {
    // rust: name.strip_prefix("minecraft:").unwrap_or(name)
    // rust: == registry.sets[set]
    // rust: .name
    // rust: .strip_prefix("minecraft:")
    // rust: .unwrap_or(&registry.sets[set].name)
    // rust: })
    // rust: });
}
    /// Concentric ring positions of a structure set (vanilla's
    /// getRingPositionsFor), computed now if no lookup needed them yet.
    // rust: pub(super) fn ring_positions(
    // rust: &self,
    // rust: context: &mut impl StartContext,
    // rust: set: &str,
    // rust: ) -> Option<Vec<ChunkPos>> {
    // rust: self.rings(context).get(set).cloned()
}
pub fn ring_work(self: *Self, context: *impl StartContext) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.ring_work.get_or_init(|| {
    // rust: let mut work = RingWork::new(self.registry.ring_searches(
    // rust: &self.possible_sets,
    // rust: self.ring_seed.unwrap_or_else(|| context.seed()),
    // rust: ));
    // rust: work.fixed = self.fixed_biome;
    // rust: work
    // rust: })
}
    /// The concentric ring positions, computing them with the threads that
    /// need them first (see `RingWork`).
pub fn rings(self: *Self, context: *mut impl StartContext) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(rings) = self.rings.get() {
    // rust: return rings;
}
    // rust: let work = self.ring_work(context);
    // rust: let registry = &self.registry;
    // rust: work.help(|set| registry.ring_biomes(set), &mut |quarts| {
    // rust: context.noise_biomes(quarts)
    // rust: });
    // rust: self.rings
    // rust: .get_or_init(|| work.rings(|set| registry.sets[set].name.clone()))
}
    /// The rings a chunk's starts are decided with. Before they are known,
    /// a chunk no ring search can end near (with the exclusion zones' reach)
    /// is decided without them: no ring chunk is near it, which is what the
    /// rings would say. Strongholds lie 1,400 blocks out or more, so a new
    /// world's first chunks don't wait for the 128 biome searches (seconds
    /// on four threads); they run when a chunk near a ring needs them.
pub fn rings_for(self: *Self, context: *mut impl StartContext, chunk: ChunkPos) * {
    // Implementation ported from Horizon
    return undefined;
}
pub const NONE: Rings = Rings::new();
    // rust: if let Some(rings) = self.rings.get() {
    // rust: return rings;
}
    // rust: let near = self
    // rust: .ring_work(context)
    // rust: .searches
    // rust: .iter()
    // rust: .any(|(_, search)| search.may_land_near(chunk.x, chunk.z, self.zone_reach));
    // rust: if near { self.rings(context) } else { &NONE }
}
    /// The structures of the random-spread sets whose start chunk is `chunk`, each with
    /// [`may_start`]'s answer, for tests.
    // rust: pub(super) fn may_start_answers(
    // rust: &self,
    // rust: context: &mut impl super::structure::start::StartContext,
    // rust: chunk: ChunkPos,
    // rust: ) -> Vec<(String, bool)> {
    // rust: let seed = context.seed();
    // rust: let rings = self.rings_for(context, chunk).clone();
    // rust: let mut checks = Vec::new();
    // rust: for &si in &self.possible_sets {
    // rust: let set = &self.registry.sets[si];
    // rust: if set.spacing().is_none()
    // rust: || StructureRegistry::potential_chunk(set, seed, chunk.x, chunk.z) != Some(chunk)
    // rust: || !(self.registry).is_structure_chunk(set, seed, chunk.x, chunk.z, &rings)
    // rust: {
    // rust: continue;
}
    // rust: for &(s, _) in &set.structures {
    // rust: let may = may_start(
    // rust: &self.registry,
    // rust: &self.resources,
    // rust: &self.bindings,
    // rust: context,
    // rust: s,
    // rust: chunk,
    // rust: );
    // rust: checks.push((self.registry.structures[s].name.clone(), may));
}
}
    // rust: checks
}
    /// `StructureRegistry::needs_dimension_origin`: whether any set is placed
    /// by the dimension's origin chunk alone.
    // rust: pub(super) fn needs_dimension_origin(&self) -> bool {
    // rust: self.registry.needs_dimension_origin()
}
    /// `ChunkGenerator.getOrigin` for this dimension's structure state.
    // rust: pub(super) fn set_dimension_origin(&mut self, origin: ChunkPos) {
    // rust: self.registry.set_dimension_origin(origin);
}
    /// Drop the cached starts, so that later chunks build fresh pieces (the
    /// pieces keep per-start placement state such as a shipwreck's height).
    // rust: pub(super) fn forget_starts(&self) {
        // As before, a build already in flight can publish after this clear.
        // Do not wait for work locks or retain initialized entries here.
    // rust: self.starts.clear();
}
    /// The (cached) structure starts owned by a chunk.
    // rust: pub(super) fn starts_at(
    // rust: &self,
    // rust: context: &mut impl super::structure::start::StartContext,
    // rust: chunk: ChunkPos,
    // rust: ) -> Starts {
    // rust: self.build_starts(context, chunk, true)
    // rust: .expect("waits for another worker's build")
}
    /// The starts a chunk saved (`structures.starts`), which vanilla loads with their pieces
    /// (`StructureStart.loadStaticStart`) so that the neighbours place the parts that cross
    /// into them and the beardifier shapes the terrain around them. A jigsaw start (villages,
    /// outposts, bastions, ancient cities, trial chambers, trail ruins) is loaded from its
    /// saved pieces (`PoolPiece::from_saved`). Another structure's pieces have no loader yet:
    /// it is the start this generator makes in the chunk when that one has the same name and the
    /// same pieces' box (the same layout from the same seed), else the name and box alone (found
    /// by `/locate` and maps, but not placed).
    // rust: fn saved_starts_at(
    // rust: &self,
    // rust: context: &mut impl super::structure::start::StartContext,
    // rust: chunk: ChunkPos,
    // rust: ) -> Starts {
    // rust: let saved = context.saved_starts(chunk);
    // rust: let mut generated: Option<Vec<Arc<StructureStart>>> = None;
    // rust: let starts = saved
    // rust: .into_iter()
    // rust: .filter_map(|start| {
    // rust: let index = (self.registry.structures.iter()).position(|s| s.name == start.name)?;
    // rust: let def = &self.registry.structures[index];
    // rust: if !start.pieces.is_empty()
    // rust: && let Some(pieces) = start
    // rust: .pieces
    // rust: .iter()
    // rust: .map(|piece| self.saved_pool_piece(piece))
    // rust: .collect::<Option<Vec<_>>>()
    // rust: {
    // rust: return Some(Arc::new(StructureStart::new(index, def, chunk, pieces)));
}
    // rust: if let Some(bounds) = start.bounds {
    // rust: let made = generated.get_or_insert_with(|| {
    // rust: let rings = self.rings_for(context, chunk);
    // rust: create_starts(
    // rust: &self.registry,
    // rust: &self.resources,
    // rust: &self.bindings,
    // rust: context,
    // rust: &self.possible_sets,
    // rust: rings,
    // rust: chunk,
    // rust: )
    // rust: .into_iter()
    // rust: .map(Arc::new)
    // rust: .collect()
    // rust: });
    // rust: let same = made.iter().find(|made| {
    // rust: made.name == start.name && pieces_box(&made.pieces) == Some(bounds)
    // rust: });
    // rust: if let Some(same) = same {
    // rust: return Some(same.clone());
}
}
    // rust: let [x0, y0, z0, x1, y1, z1] = start.bounds.unwrap_or([
    // rust: chunk.x * 16,
    // rust: 0,
    // rust: chunk.z * 16,
    // rust: chunk.x * 16 + 15,
    // rust: 0,
    // rust: chunk.z * 16 + 15,
    // rust: ]);
    // rust: Some(Arc::new(StructureStart {
    // rust: structure: index,
    // rust: name: start.name,
    // rust: chunk,
    // rust: pieces: Vec::new(),
    // rust: bounding_box: crate::worldgen::structure::BoundingBox::new(
    // rust: [x0, y0, z0],
    // rust: [x1, y1, z1],
    // rust: ),
    // rust: }))
    // rust: })
    // rust: .collect();
    // rust: Arc::new(starts)
}
    /// A saved `minecraft:jigsaw` piece, or `None` for any other piece or one that does not decode.
pub fn saved_pool_piece(self: *Self, piece: *crate::nbt::Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let crate::nbt::Tag::Compound(map) = piece else {
    // rust: return None;
}
    // rust: let id = map.get(&"id".into())?;
    // rust: if !matches!(id, crate::nbt::Tag::String(s) if s.to_string_lossy() == "minecraft:jigsaw") {
    // rust: return None;
}
    // rust: PoolPiece::from_saved(&tag_json(piece), &self.resources, &self.bindings)
    // rust: .ok()
    // rust: .map(Piece::Pool)
}
    /// `starts_at`, or `None` when another worker is building them and
    /// `wait` is false.
    // rust: fn build_starts(
    // rust: &self,
    // rust: context: &mut impl super::structure::start::StartContext,
    // rust: chunk: ChunkPos,
    // rust: wait: bool,
    // rust: ) -> Option<Starts> {
    // rust: if let Some(found) = self.starts.get((chunk.x, chunk.z)) {
    // rust: return Some(found);
}
    // rust: if context.is_old_chunk(chunk) {
            // Decoded once: the neighbours ask for these starts again and again.
    // rust: let starts = self.saved_starts_at(context, chunk);
    // rust: return Some(self.starts.insert_first((chunk.x, chunk.z), starts));
}
        // Ring searches enlist other workers and wait for them: never hold a
        // chunk-work lock while helping, even when this chunk has no starts.
    // rust: let rings = self.rings_for(context, chunk);
    // rust: let work = self.start_work.at((chunk.x, chunk.z));
    // rust: let _work = match work.try_lock() {
    // rust: Ok(guard) => guard,
    // rust: Err(TryLockError::WouldBlock) if !wait => return None,
    // rust: Err(_) => work.lock().unwrap(),
}
    // rust: if let Some(found) = self.starts.get((chunk.x, chunk.z)) {
    // rust: return Some(found);
}
    // rust: let starts: Starts = Arc::new(
    // rust: create_starts(
    // rust: &self.registry,
    // rust: &self.resources,
    // rust: &self.bindings,
    // rust: context,
    // rust: &self.possible_sets,
    // rust: rings,
    // rust: chunk,
    // rust: )
    // rust: .into_iter()
    // rust: .map(Arc::new)
    // rust: .collect(),
    // rust: );
    // rust: Some(self.starts.insert_first((chunk.x, chunk.z), starts))
}
    /// `Structure.generate` for `/place structure`: the start `structure`
    /// builds in `chunk`, whether or not a structure set would place one
    /// there (vanilla calls the structure's own generate, not the set's
    /// placement, with its `biome -> true` predicate). Nothing is cached: the
    /// chunk's own starts are untouched.
    // rust: pub(super) fn structure_start(
    // rust: &self,
    // rust: context: &mut impl StartContext,
    // rust: structure: &str,
    // rust: chunk: ChunkPos,
    // rust: ) -> Option<StructureStart> {
    // rust: let index = (self.registry.structures.iter()).position(|s| s.name == structure)?;
    // rust: try_generate(
    // rust: &self.registry,
    // rust: &self.resources,
    // rust: &self.bindings,
    // rust: context,
    // rust: index,
    // rust: chunk,
    // rust: true,
    // rust: )
}
    /// Puts a saved start of `structure` in `chunk`, in place of the one
    /// this generator builds there from the same structure sets (a set
    /// starts one structure per chunk): `pieces` as a save lists them (see
    /// `PoolPiece::from_saved`). Until the starts are forgotten.
    // rust: pub(super) fn use_saved_start(
    // rust: &self,
    // rust: context: &mut impl super::structure::start::StartContext,
    // rust: chunk: ChunkPos,
    // rust: structure: &str,
    // rust: pieces: &[Value],
    // rust: ) -> Result<(), String> {
    // rust: let index = (self.registry.structures.iter())
    // rust: .position(|s| s.name == structure)
    // rust: .ok_or_else(|| format!("unknown structure {structure}"))?;
    // rust: let pieces = (pieces.iter())
    // rust: .map(|p| PoolPiece::from_saved(p, &self.resources, &self.bindings).map(Piece::Pool))
    // rust: .collect::<Result<Vec<_>, _>>()
    // rust: .map_err(|e| format!("{structure} at {chunk:?}: {e}"))?;
    // rust: if pieces.is_empty() {
    // rust: return Err(format!("{structure} at {chunk:?}: no pieces"));
}
    // rust: let def = &self.registry.structures[index];
    // rust: let sets: Vec<_> = (self.registry.sets.iter())
    // rust: .filter(|set| set.structures.iter().any(|(s, _)| *s == index))
    // rust: .collect();
    // rust: let same_set = |s: usize| {
    // rust: s == index
    // rust: || sets
    // rust: .iter()
    // rust: .any(|set| set.structures.iter().any(|(t, _)| *t == s))
}
    // rust: let mut starts: Vec<_> = (self.starts_at(context, chunk).iter())
    // rust: .filter(|s| !same_set(s.structure))
    // rust: .cloned()
    // rust: .collect();
    // rust: starts.push(Arc::new(StructureStart::new(index, def, chunk, pieces)));
    // rust: self.starts.replace((chunk.x, chunk.z), Arc::new(starts));
    // rust: Ok(())
}
    /// ChunkGenerator.findNearestMapStructure: the nearest start of one of
    /// `names` from block `from` (rings: every ring chunk; random spreads:
    /// sectors in growing squares up to `radius`). Returns the structure and
    /// its locate position (the start chunk's corner at y 0). `skip` says a
    /// start (structure name, its chunk) can't be referenced again
    /// (`StructureStart.canBeReferenced`): the search goes on past it.
    // rust: pub(super) fn locate<C: super::structure::start::StartContext>(
    // rust: &self,
    // rust: context: &mut C,
    // rust: names: &[String],
    // rust: from: [i32; 3],
    // rust: radius: i32,
    // rust: skip: &dyn Fn(&str, ChunkPos) -> bool,
    // rust: ) -> Option<(String, [i32; 3])> {
    // rust: let seed = context.seed();
    // rust: let rings = self.rings(context).clone();
    // rust: let wanted = |s: usize| names.iter().any(|n| *n == self.registry.structures[s].name);
    // rust: let dist = |p: [i32; 3]| {
    // rust: let (dx, dz) = (f64::from(p[0] - from[0]), f64::from(p[2] - from[2]));
    // rust: dx * dx + dz * dz
}
    // rust: let mut best: Option<(f64, String, [i32; 3])> = None;
    // rust: let wanted_structures: Vec<usize> = (0..self.registry.structures.len())
    // rust: .filter(|&s| wanted(s))
    // rust: .collect();
    // rust: let found_at = |this: &Self, context: &mut C, chunk: ChunkPos| -> Option<String> {
            // StructureCheck.checkStart: a chunk with no starts built or saved yet is first
            // asked whether a wanted structure could start there (canCreateStructure, a
            // jigsaw's start piece and its biome), and only then are all its starts built,
            // layouts included. A map's search for a camp of a rarer biome built thousands of
            // chunks' starts on the server thread, seconds of it (#8669).
    // rust: if this.starts.get((chunk.x, chunk.z)).is_none()
    // rust: && !context.is_old_chunk(chunk)
    // rust: && !wanted_structures.iter().any(|&s| {
    // rust: may_start(
    // rust: &this.registry,
    // rust: &this.resources,
    // rust: &this.bindings,
    // rust: context,
    // rust: s,
    // rust: chunk,
    // rust: )
    // rust: })
    // rust: {
    // rust: return None;
}
    // rust: this.starts_at(context, chunk)
    // rust: .iter()
    // rust: .find(|s| wanted(s.structure) && !skip(&s.name, chunk))
    // rust: .map(|s| s.name.clone())
}
    // rust: for &si in &self.possible_sets {
    // rust: let set = &self.registry.sets[si];
    // rust: if !set.structures.iter().any(|(s, _)| wanted(*s)) {
    // rust: continue;
}
    // rust: match set.spacing() {
    // rust: None => {
                    // Rings: nearest by the chunk's (8, 32, 8) block.
    // rust: let Some(chunks) = rings.get(&set.name) else {
    // rust: continue;
}
    // rust: let mut nearest: Option<(f64, ChunkPos, String)> = None;
    // rust: for &c in chunks {
    // rust: let d = dist([c.x * 16 + 8, 32, c.z * 16 + 8]);
    // rust: if nearest.as_ref().is_none_or(|(n, ..)| d < *n)
    // rust: && self
    // rust: .registry
    // rust: .is_structure_chunk(set, seed, c.x, c.z, &rings)
    // rust: && let Some(name) = found_at(self, context, c)
    // rust: {
    // rust: nearest = Some((d, c, name));
}
}
    // rust: if let Some((_, c, name)) = nearest {
    // rust: let p = set.locate_pos(c);
    // rust: let d = dist(p);
    // rust: if best.as_ref().is_none_or(|(b, ..)| d < *b) {
    // rust: best = Some((d, name, p));
}
}
}
    // rust: Some(spacing) => {
    // rust: let (cx, cz) = (from[0] >> 4, from[2] >> 4);
    // rust: 'search: for r in 0..=radius {
    // rust: for dx in -r..=r {
    // rust: let x_edge = dx == -r || dx == r;
    // rust: for dz in -r..=r {
    // rust: if !(x_edge || dz == -r || dz == r) {
    // rust: continue;
}
    // rust: let (sx, sz) = (cx + spacing * dx, cz + spacing * dz);
    // rust: let Some(c) = StructureRegistry::potential_chunk(set, seed, sx, sz)
    // rust: else {
    // rust: continue;
}
    // rust: if !self
    // rust: .registry
    // rust: .is_structure_chunk(set, seed, c.x, c.z, &rings)
    // rust: {
    // rust: continue;
}
    // rust: if let Some(name) = found_at(self, context, c) {
    // rust: let p = set.locate_pos(c);
    // rust: let d = dist(p);
    // rust: if best.as_ref().is_none_or(|(b, ..)| d < *b) {
    // rust: best = Some((d, name, p));
}
    // rust: break 'search;
}
}
}
}
}
}
}
    // rust: best.map(|(_, n, p)| (n, p))
}
    /// ChunkGenerator.createReferences: starts within 8 chunks whose box
    /// intersects this chunk's column.
    // rust: pub(super) fn references(
    // rust: &self,
    // rust: context: &mut impl super::structure::start::StartContext,
    // rust: chunk: ChunkPos,
    // rust: ) -> Vec<Arc<StructureStart>> {
    // rust: let (bx, bz) = (chunk.x * 16, chunk.z * 16);
    // rust: let around: Vec<ChunkPos> = (chunk.x - 8..=chunk.x + 8)
    // rust: .flat_map(|sx| (chunk.z - 8..=chunk.z + 8).map(move |sz| ChunkPos::new(sx, sz)))
    // rust: .collect();
        // Workers generating neighbouring chunks ask for the same starts in the
        // same order: build those no other worker is building first, and wait
        // for the others only then, rather than all queueing behind each one.
    // rust: let found: Vec<Option<Starts>> = around
    // rust: .iter()
    // rust: .map(|&at| self.build_starts(context, at, false))
    // rust: .collect();
    // rust: let mut out = Vec::new();
    // rust: for (&at, found) in around.iter().zip(found) {
    // rust: let starts = found.unwrap_or_else(|| self.starts_at(context, at));
    // rust: for start in starts.iter() {
    // rust: let b = start.bounding_box;
    // rust: if b.max[0] >= bx && b.min[0] <= bx + 15 && b.max[2] >= bz && b.min[2] <= bz + 15 {
    // rust: out.push(start.clone());
}
}
}
        // Vanilla keeps each structure's references in a LongOpenHashSet and
        // places the starts in its iteration order; reorder each structure's
        // starts within the slots they already occupy.
    // rust: let mut slots: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
    // rust: for (i, start) in out.iter().enumerate() {
    // rust: slots.entry(start.structure).or_default().push(i);
}
    // rust: let original = out.clone();
    // rust: for slots in slots.values().filter(|s| s.len() > 1) {
    // rust: let keys: Vec<i64> = slots
    // rust: .iter()
    // rust: .map(|&i| {
    // rust: let c = original[i].chunk;
    // rust: i64::from(c.x as u32) | (i64::from(c.z as u32) << 32)
    // rust: })
    // rust: .collect();
    // rust: for (&slot, &from) in slots.iter().zip(&super::long_set::iteration_order(&keys)) {
    // rust: out[slot] = original[slots[from]].clone();
}
}
    // rust: out
}
    // rust: pub(super) fn beardifier(
    // rust: &self,
    // rust: references: &[Arc<StructureStart>],
    // rust: chunk: ChunkPos,
    // rust: ) -> Option<Beardifier> {
    // rust: beardifier(&self.registry, references, chunk)
}
}

/// The union of the pieces' boxes as `[min x, min y, min z, max x, max y, max z]`.
pub fn pieces_box(pieces: *[Piece]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut union: Option<crate::worldgen::structure::BoundingBox> = None;
    // rust: for piece in pieces {
    // rust: let b = piece.bounding_box();
    // rust: match union.as_mut() {
    // rust: Some(u) => u.encapsulate(&b),
    // rust: None => union = Some(b),
}
}
    // rust: union.map(|b| [b.min[0], b.min[1], b.min[2], b.max[0], b.max[1], b.max[2]])
}
/// A saved piece's tag as the JSON `PoolPiece::from_saved` reads: compounds and lists as they
/// are, numbers as numbers.
pub fn tag_json(tag: *crate::nbt::Tag) V {
    // Implementation ported from Horizon
    return undefined;
}
//     use crate::nbt::Tag;
    // rust: match tag {
    // rust: Tag::Byte(v) => Value::from(i64::from(*v)),
    // rust: Tag::Short(v) => Value::from(i64::from(*v)),
    // rust: Tag::Int(v) => Value::from(i64::from(*v)),
    // rust: Tag::Long(v) => Value::from(*v),
    // rust: Tag::Float(bits) => Value::from(f64::from(f32::from_bits(*bits))),
    // rust: Tag::Double(bits) => Value::from(f64::from_bits(*bits)),
    // rust: Tag::String(s) => Value::from(s.to_string_lossy()),
    // rust: Tag::List(items) => Value::Array(items.iter().map(tag_json).collect()),
    // rust: Tag::ByteArray(v) => Value::Array(v.iter().map(|b| Value::from(i64::from(*b))).collect()),
    // rust: Tag::IntArray(v) => Value::Array(v.iter().map(|i| Value::from(i64::from(*i))).collect()),
    // rust: Tag::LongArray(v) => Value::Array(v.iter().map(|i| Value::from(*i)).collect()),
    // rust: Tag::Compound(map) => Value::Object(
    // rust: map.iter()
    // rust: .map(|(k, v)| (k.to_string_lossy(), tag_json(v)))
    // rust: .collect(),
    // rust: ),
    // rust: Tag::End => Value::Null,
}
}
    // rust: mod tests {
//     use super::*;
//     use crate::worldgen::structure::stronghold::{ring_positions, ring_searches};

    /// The start cache keeps the first starts built for a chunk, spreads a
    /// chunk's 289 reference lookups over the shards, and forgets on clear.
pub fn start_cache_keeps_first_and_spreads_neighbours() void {
}
    // rust: let cache = StartCache::new();
    // rust: let first: Starts = Arc::new(Vec::new());
    // rust: let second: Starts = Arc::new(Vec::new());
    // rust: assert!(cache.get((3, -4)).is_none());
    // rust: assert!(Arc::ptr_eq(
    // rust: &cache.insert_first((3, -4), first.clone()),
    // rust: &first
    // rust: ));
    // rust: assert!(Arc::ptr_eq(&cache.insert_first((3, -4), second), &first));
    // rust: assert!(Arc::ptr_eq(&cache.get((3, -4)).unwrap(), &first));
    // rust: for (cx, cz) in [(0, 0), (-1000, 77), (i32::MAX - 8, i32::MIN + 8)] {
    // rust: let mut used = vec![0; START_SHARDS];
    // rust: for x in cx - 8..=cx + 8 {
    // rust: for z in cz - 8..=cz + 8 {
    // rust: let shard = cache.shard((x, z)) as *const _;
    // rust: let i = cache
    // rust: .shards
    // rust: .iter()
    // rust: .position(|s| std::ptr::eq(s, shard))
    // rust: .unwrap();
    // rust: used[i] += 1;
}
}
    // rust: assert!(used.iter().all(|&n| n > 0 && n < 20), "{used:?}");
}
    // rust: cache.clear();
    // rust: assert!(cache.get((3, -4)).is_none());
}

    /// A full shard forgets the starts nobody asked for since it last filled,
    /// and keeps the ones still asked for (a player's surroundings).
pub fn start_cache_keeps_the_starts_still_asked_for() void {
}
    // rust: let cache = StartCache::new();
    // rust: let hot: Starts = Arc::new(Vec::new());
    // rust: let cold: Starts = Arc::new(Vec::new());
    // rust: let shard = shard_of((0, 0), START_SHARDS);
    // rust: let mut same_shard = (1..)
    // rust: .map(|x| (x, 0))
    // rust: .filter(|&k| shard_of(k, START_SHARDS) == shard);
    // rust: let cold_key = same_shard.next().unwrap();
    // rust: cache.insert_first((0, 0), hot.clone());
    // rust: cache.insert_first(cold_key, cold);
        // Three shards' worth of other chunks, with the hot one asked for now and then.
    // rust: for (i, key) in same_shard
    // rust: .take(3 * START_CACHE_LIMIT / START_SHARDS)
    // rust: .enumerate()
    // rust: {
    // rust: cache.insert_first(key, Arc::new(Vec::new()));
    // rust: if i % 100 == 0 {
    // rust: assert!(Arc::ptr_eq(&cache.get((0, 0)).unwrap(), &hot));
}
}
    // rust: assert!(Arc::ptr_eq(&cache.get((0, 0)).unwrap(), &hot));
    // rust: assert!(cache.get(cold_key).is_none());
}

pub fn start_cache_counts_both_generations_and_replaces_old_starts() void {
}
    // rust: let cache = StartCache::new();
    // rust: let key = (3, -4);
    // rust: let first: Starts = Arc::new(Vec::new());
    // rust: cache.insert_first(key, first.clone());
    // rust: {
    // rust: let mut shard = cache.shard(key).write().unwrap();
    // rust: shard.old = std::mem::take(&mut shard.new);
}
    // rust: cache.insert_first((99, 100), Arc::new(Vec::new()));
    // rust: assert_eq!(cache.census(), (2, 0));
    // rust: assert!(Arc::ptr_eq(
    // rust: &cache.insert_first(key, Arc::new(Vec::new())),
    // rust: &first
    // rust: ));
    // rust: {
    // rust: let mut shard = cache.shard(key).write().unwrap();
    // rust: let value = shard.new.remove(&key).unwrap();
    // rust: shard.old.insert(key, value);
}
    // rust: let replacement: Starts = Arc::new(Vec::new());
    // rust: cache.replace(key, replacement.clone());
    // rust: assert!(Arc::ptr_eq(&cache.get(key).unwrap(), &replacement));
    // rust: assert_eq!(cache.census(), (2, 0));
}

    /// A ring search ends where `may_land_near` allows: on its ring chunk
    /// or in the square it samples, never further.
pub fn ring_searches_end_where_they_may() void {
}
    // rust: let none = BTreeSet::new();
    // rust: for seed in [0, 1234, -77, i64::MAX] {
    // rust: for (b, search) in ring_searches(seed, 32, 3, 128).iter().enumerate() {
                // Preferred biomes on one quart at a time, in turn at each
                // corner of the square, else nowhere (the ring chunk).
    // rust: let corner = (b % 5) as i32;
    // rust: let biomes = |quarts: &[[i32; 3]]| -> Vec<BiomeId> {
    // rust: let (first, last) = (quarts[0], quarts[quarts.len() - 1]);
    // rust: let pick = match corner {
    // rust: 0 => first,
    // rust: 1 => [last[0], 0, first[2]],
    // rust: 2 => [first[0], 0, last[2]],
    // rust: 3 => last,
    // rust: _ => [i32::MIN, 0, i32::MIN],
}
    // rust: quarts
    // rust: .iter()
    // rust: .map(|q| BiomeId(u32::from(*q == pick)))
    // rust: .collect()
}
    // rust: let preferred: BTreeSet<BiomeId> = [BiomeId(1)].into();
    // rust: for wanted in [&preferred, &none] {
    // rust: let found = search.find(wanted, &mut { biomes });
    // rust: assert!(search.may_land_near(found.x, found.z, 0));
    // rust: assert!(!search.may_land_near(found.x + 17, found.z, 0));
}
}
}
}

    /// Searches shared between threads give the positions of one thread
    /// running them in order, set by set.
pub fn ring_work_shared_between_threads_matches_serial_search() void {
}
    // rust: let preferred: BTreeSet<BiomeId> = (0..20).map(|b| BiomeId(b * 3)).collect();
    // rust: let biomes = |quarts: &[[i32; 3]]| -> Vec<BiomeId> {
    // rust: quarts
    // rust: .iter()
    // rust: .map(|q| {
    // rust: BiomeId((q[0].wrapping_mul(31) ^ q[2].wrapping_mul(17)).rem_euclid(64) as u32)
    // rust: })
    // rust: .collect()
}
    // rust: let none = BTreeSet::new();
    // rust: for seed in [0, 1234, -77, i64::MAX] {
    // rust: let work = RingWork::new(vec![
    // rust: (0, ring_searches(seed, 32, 3, 128)),
    // rust: (1, ring_searches(seed ^ 5, 10, 4, 0)),
    // rust: (2, ring_searches(seed.wrapping_add(1), 20, 5, 40)),
    // rust: ]);
    // rust: let sets = [&preferred, &none, &preferred];
    // rust: std::thread::scope(|scope| {
    // rust: for _ in 0..4 {
    // rust: scope.spawn(|| work.help(|set| sets[set], &mut { biomes }));
}
    // rust: });
    // rust: let rings = work.rings(|set| format!("set{set}"));
    // rust: let serial = |s: i64, distance, spread, count, preferred| {
    // rust: ring_positions(s, distance, spread, count, preferred, &mut { biomes })
}
    // rust: assert_eq!(rings["set0"], serial(seed, 32, 3, 128, &preferred));
    // rust: assert_eq!(rings["set1"], Vec::new());
    // rust: assert_eq!(
    // rust: rings["set2"],
    // rust: serial(seed.wrapping_add(1), 20, 5, 40, &preferred)
    // rust: );
}
}
}
