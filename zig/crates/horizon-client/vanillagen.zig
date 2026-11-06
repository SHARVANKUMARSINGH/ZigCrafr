//! Transpiled from Horizon Rust crate
//! Module: horizon-client_vanillagen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Binds `horizon_world`'s vanilla overworld generator (noise terrain,
//! aquifers, surface rules, carvers and placed features) to chunk streaming.
// use crate::{
    // rust: biome::Biomes,
    // rust: chunk::{BIOME_STRATEGY, Chunk, ColumnLayout, Section},
    // rust: save::SavedProto,
    // rust: streaming::{ChunkGenerator, LodSampler, Proto},
}
// use horizon_core::{
    // rust: paletted::PalettedContainer,
    // rust: position::ChunkPos,
    // rust: ticks::{ProtoChunkTicks, SavedTick, TickTypeId},
}
// use horizon_world::{
    // rust: heightmap::HeightmapType,
    // rust: loot::PackOverlay,
    // rust: nbt::Tag,
    // rust: registry::BlockRegistry,
    // rust: worldgen::{
    // rust: generator::{
    // rust: GeneratorData, GeneratorWorker, OverworldGenerator, ProtoChunk, SurfaceSample,
    // rust: },
    // rust: overrides::WorldgenOverrides,
    // rust: structure::legacy::PieceRandom,
    // rust: terrain::PreLightChunkStage,
    // rust: },
}
// use std::{path::Path, sync::Arc};
    // rust: mod lod;
    // rust: mod structure_mobs;
// use lod::VanillaLodSampler;
// use structure_mobs::StructureMobFinalizer;

/// The references a saved chunk keeps for its structure start: `(structure, chunk x, chunk z)`.
    // rust: pub type SavedReferences = std::sync::Arc<dyn Fn(&str, i32, i32) -> i32 + Send + Sync>;

pub const VanillaTerrain = struct {
    generator: OverworldGenerator,
    /// Generator biome index -> client biome table index.
    biome_map: std.ArrayList(u16),
    /// Loot tables for generated containers.
    loot: ?*horizon_world::loot::LootData,
    structure_mobs: *StructureMobFinalizer,
    /// A worker for structure queries from the game thread.
    query: std::sync::Mutex<?GeneratorWorker>,
    /// Block state id -> block index, the game's block tick type: worldgen
    /// schedules block ticks by default state id.
    tick_blocks: std.ArrayList(u32),
    /// Block index -> default state id: `tick_blocks` the other way.
    tick_states: std.ArrayList(u32),
    /// Block state id -> the block entity type of its block, if it has one.
    block_entity_types: std.ArrayList(?*'static str),
    seed: i64,
    /// The starts (structure name, chunk) an exploration map pointed at.
    referenced: std::sync::Mutex<std::collections::HashSet<([]const u8,
    reference_file: std::sync::Mutex<?std::path::PathBuf>,
    saved_references: std::sync::Mutex<?SavedReferences>,
    /// The world preset the terrain was generated with (`minecraft:normal`
    /// unless a saved world says otherwise); far decoration uses it too.
    preset: []const u8,
    dimension: []const u8,
    /// When the last proto chunk was generated, in milliseconds since
    /// `created`: the ring search waits for a pause in generation.
    last_proto: std::sync::atomic::AtomicU64,
    created: std::time::Instant,
    /// A superflat generator (`FlatLevelSource`).
    flat: bool,
};
/// A proto chunk, or the position of one whose generation failed.
pub const VanillaProto = enum {
    Ready(Box<ProtoChunk>),
    Failed(i32, i32),
};
/// WorldGenRegion.setBlock gives every block with a block entity a new
/// one: the blocks nothing placed data for (a sculk patch's sensors) get
/// vanilla's defaults.
pub fn add_default_block_entities(kinds: *[?[]const u8], out: *mut Chunk, raw: *mut std.ArrayList(Tag)) void {
}
    // rust: let kind = |v: u32| kinds.get(v as usize).copied().flatten();
    // rust: let mut states = [0u32; 4096];
    // rust: for (si, section) in out.sections.iter().enumerate() {
    // rust: if !section.blocks.maybe_has(|v| kind(v).is_some()) {
    // rust: continue;
}
    // rust: section.unpack(&mut states);
    // rust: for (i, &v) in states.iter().enumerate() {
    // rust: let Some(id) = kind(v) else {
    // rust: continue;
}
    // rust: let i = i as i32;
    // rust: let pos = [
    // rust: out.x * 16 + (i & 15),
    // rust: out.min_y() + si as i32 * 16 + (i >> 8),
    // rust: out.z * 16 + ((i >> 4) & 15),
    // rust: ];
    // rust: let at = |t: &Tag| {
    // rust: ["x", "y", "z"]
    // rust: .iter()
    // rust: .zip(pos)
    // rust: .all(|(k, p)| t.get(k) == Some(&Tag::Int(p)))
}
    // rust: if raw.iter().any(at) || out.block_entities.iter().any(|(p, _)| *p == pos.into()) {
    // rust: continue;
}
    // rust: let tag = Tag::compound([
    // rust: ("id", Tag::String(id.into())),
    // rust: ("x", Tag::Int(pos[0])),
    // rust: ("y", Tag::Int(pos[1])),
    // rust: ("z", Tag::Int(pos[2])),
    // rust: ]);
    // rust: let tag = crate::block_entity_nbt::canonical(&tag).unwrap_or(tag);
    // rust: match crate::save::decode_block_entity(&tag) {
    // rust: Some(modelled) => out.block_entities.push(modelled),
    // rust: None => raw.push(tag),
}
}
}
}

    // rust: impl VanillaTerrain {
    /// A mod's sign takes its template's block entity, whatever its name: a
    /// feature that places one leaves it with text to edit.
pub fn add_mod_signs(self: *Self, facts: *crate::blocks::BlockFacts) void {
}
    // rust: for (state, kind) in self.block_entity_types.iter_mut().enumerate() {
    // rust: let state = horizon_world::registry::BlockStateId(state as u32);
    // rust: if let Some(form) = facts.get(state).sign_form() {
    // rust: *kind = Some(form.block_entity_type());
}
}
}
pub fn client_surface(self: *Self, surface: SurfaceSample) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::lod::Surface {
    // rust: height: surface.height,
    // rust: state: surface.state,
    // rust: water: surface.water,
    // rust: biome: self
    // rust: .biome_map
    // rust: .get(surface.biome.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(0),
}
}
    // rust: pub fn new(
    // rust: dir: &Path,
    // rust: registry: &'static BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: seed: i64,
    // rust: ) -> crate::Result<Self> {
    // rust: Self::for_dimension(dir, registry, biomes, seed, "minecraft:overworld")
}
    // rust: pub fn for_dimension(
    // rust: dir: &Path,
    // rust: registry: &'static BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: seed: i64,
    // rust: dimension: &str,
    // rust: ) -> crate::Result<Self> {
    // rust: Self::for_world(
    // rust: dir,
    // rust: registry,
    // rust: biomes,
    // rust: seed,
    // rust: "minecraft:normal",
    // rust: dimension,
    // rust: true,
    // rust: )
}
    /// A dimension of a world preset (`worldgen/world_preset`) whose
    /// `generate_structures` is `structures` (`ChunkGenerator.createStructures`
    /// and `findNearestMapStructure` do nothing without).
    // rust: pub fn for_world(
    // rust: dir: &Path,
    // rust: registry: &'static BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: seed: i64,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: structures: bool,
    // rust: ) -> crate::Result<Self> {
    // rust: let none = WorldgenOverrides::default();
    // rust: Self::for_world_with(
    // rust: dir, &none, registry, biomes, seed, preset, dimension, structures,
    // rust: )
}
    /// `for_world` with the world's data packs over the bundle at `dir`
    /// (`datapack::worldgen_overrides`).
    // rust: pub fn for_world_with(
    // rust: dir: &Path,
    // rust: overrides: &WorldgenOverrides,
    // rust: registry: &'static BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: seed: i64,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: structures: bool,
    // rust: ) -> crate::Result<Self> {
    // rust: Self::for_world_with_settings(
    // rust: dir, overrides, registry, biomes, seed, preset, dimension, structures, None,
    // rust: )
}
    /// `for_world_with` with the saved dimension's generator and type, below
    /// any dimension supplied by the world's data packs.
    // rust: pub fn for_world_with_settings(
    // rust: dir: &Path,
    // rust: overrides: &WorldgenOverrides,
    // rust: registry: &'static BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: seed: i64,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: structures: bool,
    // rust: saved_stem: Option<&serde_json::Value>,
    // rust: ) -> crate::Result<Self> {
    // rust: let data: Arc<GeneratorData> = shared_data_with(dir, overrides, registry)?;
    // rust: let generator = OverworldGenerator::for_world_with_settings(
    // rust: data, seed, preset, dimension, structures, saved_stem,
    // rust: )?;
    // rust: Self::assemble(dir, registry, biomes, generator, seed, preset, dimension)
}
    /// A superflat overworld with the structures its settings allow
    /// (`FlatLevelSource`: its layers, `structure_overrides` and the fixed biome).
    // rust: pub fn for_flat(
    // rust: dir: &Path,
    // rust: overrides: &WorldgenOverrides,
    // rust: registry: &'static BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: seed: i64,
    // rust: flat: &horizon_world::worldgen::generator::FlatSettings,
    // rust: structures: bool,
    // rust: ) -> crate::Result<Self> {
    // rust: let data: Arc<GeneratorData> = shared_data_with(dir, overrides, registry)?;
    // rust: let generator = OverworldGenerator::flat(data, seed, flat, structures)?;
    // rust: let mut terrain = Self::assemble(
    // rust: dir,
    // rust: registry,
    // rust: biomes,
    // rust: generator,
    // rust: seed,
    // rust: "minecraft:normal",
    // rust: "minecraft:overworld",
    // rust: )?;
    // rust: terrain.flat = true;
    // rust: Ok(terrain)
}
    /// Whether this is a superflat generator, whose `spawnOriginalMobs` places nothing.
pub fn is_flat(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.flat
}
    /// The terrain around a generator, with the tables the client's chunks need.
    // rust: fn assemble(
    // rust: dir: &Path,
    // rust: registry: &'static BlockRegistry,
    // rust: biomes: &Biomes,
    // rust: generator: OverworldGenerator,
    // rust: seed: i64,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: ) -> crate::Result<Self> {
    // rust: let biome_map = generator
    // rust: .data()
    // rust: .biome_names()
    // rust: .iter()
    // rust: .map(|name| biomes.id(name))
    // rust: .collect();
    // rust: if let Some((asked, kept)) = generator.noise_clamped() {
    // rust: log::warn!(
    // rust: "Horizon: {dimension}'s noise settings reach y {}..{}, past its build height; \
    // rust: only y {}..{} generates",
    // rust: asked.min_y,
    // rust: asked.min_y + asked.height,
    // rust: kept.min_y,
    // rust: kept.min_y + kept.height
    // rust: );
}
    // rust: let unsupported = generator.unsupported_features();
    // rust: if !unsupported.is_empty() {
    // rust: log::warn!(
    // rust: "Horizon: {} placed features cannot run and will be skipped",
    // rust: unsupported.len()
    // rust: );
    // rust: if !dir.join("blocks/block-properties.nbt").exists() {
    // rust: log::warn!(
    // rust: "Horizon: the worldgen bundle lacks the block behavior exports (worldgen/blocks/*.nbt); \
    // rust: prepare again (the launcher, or horizon-prepare --prepare) to add them"
    // rust: );
}
}
    // rust: let loot = dir
    // rust: .parent()
    // rust: .and_then(|root| crate::structure_blocks::loot_data(root, &PackOverlay::NONE));
    // rust: if let Some(root) = dir.parent() {
    // rust: crate::mobs::trial_spawner::load_registry(root);
}
    // rust: let mut tick_blocks = Vec::with_capacity(registry.len());
    // rust: let mut tick_states = Vec::new();
    // rust: let mut block_entity_types = Vec::with_capacity(registry.len());
    // rust: let mut last: Option<&str> = None;
    // rust: let mut index = 0u32;
    // rust: for id in 0..registry.len() {
    // rust: let name = registry
    // rust: .state(horizon_world::registry::BlockStateId(id as u32))
    // rust: .map_or("", |s| s.name.as_str());
    // rust: if last.is_some_and(|l| l != name) {
    // rust: index += 1;
}
    // rust: if last != Some(name) {
    // rust: tick_states.push(registry.default_state(name).map_or(id as u32, |s| s.0));
}
    // rust: last = Some(name);
    // rust: tick_blocks.push(index);
    // rust: block_entity_types.push(crate::lan::chunks::block_entity_type(name));
}
    // rust: Ok(Self {
    // rust: generator,
    // rust: biome_map,
    // rust: loot,
    // rust: structure_mobs: Arc::new(StructureMobFinalizer::new(
    // rust: dir.parent().unwrap_or(dir).to_owned(),
    // rust: dimension,
    // rust: )),
    // rust: query: std::sync::Mutex::new(None),
    // rust: tick_blocks,
    // rust: tick_states,
    // rust: block_entity_types,
    // rust: seed,
    // rust: referenced: Default::default(),
    // rust: reference_file: Default::default(),
    // rust: saved_references: Default::default(),
    // rust: preset: preset.to_owned(),
    // rust: dimension: dimension.to_owned(),
    // rust: last_proto: std::sync::atomic::AtomicU64::new(0),
    // rust: created: std::time::Instant::now(),
    // rust: flat: false,
    // rust: })
}
    /// The column the dimension's chunks hold (its build range's).
pub fn layout(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (min_y, height) = self.generator.level();
    // rust: ColumnLayout::of_level(min_y, height)
}
    /// The difficulty (0 peaceful to 3 hard) and overworld clock structure
    /// mobs are finalized with.
pub fn set_spawn_conditions(self: *Self, difficulty: u8, day_time: i64) void {
}
    // rust: self.structure_mobs.set_conditions(difficulty, day_time);
}
    /// The random a chunk's generation steps draw from (`WorldGenRegion`).
pub fn region_random(self: *Self, cx: i32, cz: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.generator.region_random(ChunkPos::new(cx, cz))
}
    /// A mob chunk generation spawns, as the chunk saves it
    /// (`StructureMobFinalizer::spawn_generated`).
    // rust: pub fn spawn_generated(
    // rust: &self,
    // rust: kind: &str,
    // rust: position: horizon_core::geometry::Vec3,
    // rust: yaw: f32,
    // rust: biome: &str,
    // rust: random: &mut dyn PieceRandom,
    // rust: group: &mut Option<crate::mobs::finalize::Group>,
    // rust: ) -> Option<horizon_world::nbt::Compound> {
    // rust: self.structure_mobs
    // rust: .spawn_generated(kind, position, yaw, biome, random, group)
}
    /// Only the generated range of a proto chunk (the Nether is 0..256)
    /// is copied into a column.
pub fn generated_range(chunk: *ProtoChunk, out: *Chunk) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: chunk.terrain.min_y().max(out.min_y()),
    // rust: (chunk.terrain.min_y() + chunk.terrain.height()).min(out.max_y()),
    // rust: )
}
    /// A proto chunk's blocks alone as a column: what a light job reads of
    /// its neighbours.
pub fn block_column(self: *Self, chunk: *ProtoChunk) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pos = chunk.position();
    // rust: let mut out = Chunk::with_layout(pos.x, pos.z, self.layout());
    // rust: let (bx, bz) = (pos.x * 16, pos.z * 16);
    // rust: let (lo, hi) = Self::generated_range(chunk, &out);
    // rust: let mut values = Box::new([0u32; 4096]);
    // rust: for si in 0..out.sections.len() as i32 {
    // rust: let base = out.min_y() + si * 16;
    // rust: if base + 16 <= lo || base >= hi {
    // rust: continue;
}
    // rust: let mut any = false;
            // A whole generated section is read in one pass (it runs on the
            // server thread for every light view); a partly generated one
            // block by block.
    // rust: if base >= lo && base + 16 <= hi && chunk.terrain.section_states(base, &mut values) {
    // rust: any = values.iter().any(|&id| id != 0);
    // rust: } else {
    // rust: values.fill(0);
    // rust: for y in base.max(lo)..(base + 16).min(hi) {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let id = chunk.block(bx + x, y, bz + z).0;
    // rust: values[((y & 15) << 8 | z << 4 | x) as usize] = id;
    // rust: any |= id != 0;
}
}
}
}
    // rust: if any {
    // rust: Arc::make_mut(&mut out.sections[si as usize]).blocks =
    // rust: Section::from_blocks(&values);
}
}
    // rust: out
}
    /// A proto chunk's blocks, biomes, scheduled ticks and post-processing
    /// marks as a column.
pub fn column(self: *Self, chunk: *ProtoChunk) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = self.block_column(chunk);
    // rust: let pos = chunk.position();
    // rust: let (bx, bz) = (pos.x * 16, pos.z * 16);
    // rust: let (lo, hi) = Self::generated_range(chunk, &out);
    // rust: out.structure_refs = chunk
    // rust: .structures()
    // rust: .into_iter()
    // rust: .map(|(id, start, _, _)| (Arc::from(id), (start.x, start.z)))
    // rust: .collect();
    // rust: out.structure_starts = chunk.own_starts();
        // Ticks the features scheduled (leaves reshaped at a tree's edge,
        // fluids of lakes and springs) run once the chunk is live, as
        // LevelChunk takes over ProtoChunk's ticks.
    // rust: let block_ticks: Vec<_> = chunk
    // rust: .terrain
    // rust: .block_ticks()
    // rust: .pack(0)
    // rust: .iter()
    // rust: .filter_map(|t| {
    // rust: let kind = *self.tick_blocks.get(t.kind.0 as usize)?;
    // rust: Some(horizon_core::ticks::SavedTick {
    // rust: kind: horizon_core::ticks::TickTypeId(kind),
    // rust: ..*t
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let fluid_ticks = chunk.terrain.fluid_ticks().pack(0).to_vec();
    // rust: if !block_ticks.is_empty() || !fluid_ticks.is_empty() {
    // rust: out.saved = Some(Arc::new(crate::save::ChunkExtras {
    // rust: block_ticks,
    // rust: fluid_ticks,
    // rust: ..Default::default()
    // rust: }));
}
    // rust: let base_section = chunk.terrain.min_y() >> 4;
    // rust: for (i, marks) in chunk.terrain.postprocessing().iter().enumerate() {
    // rust: let sy = (base_section + i as i32) * 16;
    // rust: for &packed in marks {
    // rust: let p = i32::from(packed);
    // rust: let y = sy + ((p >> 4) & 15);
    // rust: if (lo..hi).contains(&y) {
    // rust: out.postprocess
    // rust: .push([bx + (p & 15), y, bz + ((p >> 8) & 15)]);
}
}
}
    // rust: for si in 0..out.sections.len() as i32 {
    // rust: let mut cells = [0u32; 64];
    // rust: for (j, cell) in cells.iter_mut().enumerate() {
    // rust: let (qx, qz, qy) = (j as i32 & 3, (j as i32 >> 2) & 3, si * 4 + (j as i32 >> 4));
    // rust: let y = (out.min_y() + qy * 4).clamp(lo, hi - 1);
    // rust: let id = chunk.biome_id_at(bx + qx * 4, y, bz + qz * 4);
    // rust: *cell = u32::from(self.biome_map.get(id.0 as usize).copied().unwrap_or(0));
}
    // rust: Arc::make_mut(&mut out.sections[si as usize]).biomes =
    // rust: PalettedContainer::from_values(BIOME_STRATEGY, &cells);
}
    // rust: out
}
    /// The structure starts owned by a chunk (cached by the generator).
    // rust: pub fn starts_at(
    // rust: &self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Vec<Arc<horizon_world::worldgen::structure::start::StructureStart>> {
    // rust: let mut worker = self.query.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let worker = worker.get_or_insert_with(|| self.generator.worker());
    // rust: worker.structure_starts(ChunkPos::new(x, z))
}
    /// `/place structure`: `Structure.generate` for `structure` in chunk
    /// `(x, z)`, whatever the chunk's structure sets place there.
    // rust: pub fn structure_start(
    // rust: &self,
    // rust: structure: &str,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Option<Arc<horizon_world::worldgen::structure::start::StructureStart>> {
    // rust: let mut worker = self.query.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let worker = worker.get_or_insert_with(|| self.generator.worker());
    // rust: worker.structure_start(structure, ChunkPos::new(x, z))
}
    /// `/locate structure`: the nearest start of one of `names` within
    /// `radius` placement sectors of block `from`.
    // rust: pub fn locate(
    // rust: &self,
    // rust: names: &[String],
    // rust: from: [i32; 3],
    // rust: radius: i32,
    // rust: ) -> Option<(String, [i32; 3])> {
    // rust: self.generator.worker().locate(names, from, radius)
}
    /// The chunks an older version saved, which new chunks blend with
    /// (`Blender.of`).
pub fn set_old_world(self: *Self, world: *dyn horizon_world::worldgen::blending::OldWorld) void {
}
    // rust: self.generator.set_old_world(world);
}
    /// The generator's resources, for what reads saved chunks the way it does.
pub fn generator_data(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.generator.data()
}
    /// `NoiseBasedChunkGenerator.addDebugScreenInfo`: F3's `Density` line at
    /// the feet. It reads the samplers only, not the shared query worker, so
    /// a long `/locate biome` or `/place jigsaw` never holds it up.
pub fn density_debug_line(self: *Self, feet: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.generator.debug_density_line(feet)
}
    /// `ChunkGenerator.findNearestMapStructure` for an exploration map: with
    /// `skip_known` (`skip_existing_chunks`) the nearest start no map pointed
    /// at yet, which then counts as pointed at (`StructureStart.addReference`,
    /// at most one: `getMaxReferences`).
    // rust: pub fn locate_for_map(
    // rust: &self,
    // rust: names: &[String],
    // rust: from: [i32; 3],
    // rust: radius: i32,
    // rust: skip_known: bool,
    // rust: ) -> Option<(String, [i32; 3])> {
    // rust: if !skip_known {
    // rust: return self.locate(names, from, radius);
}
    // rust: let saved = self
    // rust: .saved_references
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .clone();
    // rust: let mut referenced = self.referenced.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let found =
    // rust: self.generator
    // rust: .worker()
    // rust: .locate_skipping(names, from, radius, &|name, chunk| {
    // rust: referenced.contains(&(name.to_owned(), chunk.x, chunk.z))
    // rust: || saved
    // rust: .as_ref()
    // rust: .is_some_and(|f| f(name, chunk.x, chunk.z) > 0)
    // rust: })?;
    // rust: referenced.insert((found.0.clone(), found.1[0] >> 4, found.1[2] >> 4));
    // rust: self.save_references(&referenced);
    // rust: Some(found)
}
    /// Where the starts maps pointed at are kept, and the ones kept there:
    /// vanilla keeps the count in each start's chunk (`references`), which a
    /// start nobody visited has no file for.
pub fn set_reference_file(self: *Self, path: std::path::PathBuf) void {
}
    // rust: let mut referenced = self.referenced.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some(list) = std::fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Vec<(String, i32, i32)>>(&b).ok())
    // rust: {
    // rust: referenced.extend(list);
}
    // rust: *self
    // rust: .reference_file
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner()) = Some(path);
}
    /// StructureCheck's `onStructureLoad` and `tryLoadFromStorage`: the
    /// references a chunk saved for its starts (a world saved by vanilla, or
    /// by an older run) count as known, besides the ones kept here.
pub fn set_saved_references(self: *Self, saved: SavedReferences) void {
}
    // rust: *self
    // rust: .saved_references
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner()) = Some(saved);
}
pub fn save_references(self: *Self, referenced: *std::collections::HashSet<([]const u8) void {
}
    // rust: let guard = self
    // rust: .reference_file
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner());
    // rust: let Some(path) = guard.as_ref() else { return };
    // rust: let mut list: Vec<_> = referenced.iter().collect();
    // rust: list.sort();
    // rust: if let Some(dir) = path.parent() {
    // rust: let _ = std::fs::create_dir_all(dir);
}
        // Written beside the file and renamed over it: a crash half way must
        // not leave truncated JSON, which loads as no references at all.
    // rust: let tmp = path.with_extension("json.tmp");
    // rust: let saved = serde_json::to_vec(&list)
    // rust: .map_err(std::io::Error::from)
    // rust: .and_then(|b| std::fs::write(&tmp, b))
    // rust: .and_then(|()| std::fs::rename(&tmp, path));
    // rust: if let Err(e) = saved {
    // rust: log::warn!("Horizon: could not save {}: {e}", path.display());
}
}
    /// `/locate biome`: `BiomeSource.findClosestBiome3d`.
    // rust: pub fn find_closest_biome(
    // rust: &self,
    // rust: search: &horizon_world::worldgen::generator::BiomeSearch<'_>,
    // rust: ) -> Option<(String, [i32; 3])> {
    // rust: let mut worker = self.query.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let worker = worker.get_or_insert_with(|| self.generator.worker());
    // rust: worker.find_closest_biome(search)
}
    /// `BiomeSource.getNoiseBiome` at quart positions, for places that may not
    /// be generated yet (`MapItem.renderBiomePreviewMap`).
pub fn noise_biomes(self: *Self, quarts: *[[i32; 3]]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut worker = self.query.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let worker = worker.get_or_insert_with(|| self.generator.worker());
    // rust: worker.noise_biomes(quarts)
}
    /// `/place jigsaw`: `JigsawPlacement.addPieces`.
    // rust: pub fn jigsaw_pieces(
    // rust: &self,
    // rust: query: &horizon_world::worldgen::generator::JigsawQuery<'_>,
    // rust: ) -> Option<horizon_world::worldgen::generator::JigsawPieces> {
    // rust: let mut worker = self.query.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let worker = worker.get_or_insert_with(|| self.generator.worker());
    // rust: worker.jigsaw_pieces(query)
}
    /// NoiseBasedChunkGenerator.getOrigin: where the world spawn search starts.
pub fn origin(self: *Self) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.generator.origin()?)
}
    /// Concentric ring positions of a structure set (strongholds), searched
    /// for now if no chunk needed them yet.
pub fn ring_positions(self: *Self, set: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut worker = self.query.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let worker = worker.get_or_insert_with(|| self.generator.worker());
    // rust: worker.ring_positions(set)
}
    /// Searches the concentric rings on a thread of their own, as vanilla's
    /// background executor does, once generation pauses for two seconds
    /// (at the latest a minute after the world opens) and in the idle
    /// class: on a laptop's few cores, sharing them with the first chunks,
    /// which don't need the rings, made those 3 s slower. An eye of ender
    /// thrown later finds the rings ready, and a chunk or a query that
    /// needs them first shares the remaining searches with this thread.
pub fn search_rings_behind(self: **Self) void {
}
pub const QUIET: u64 = 2_000;
pub const LATEST: u64 = 60_000;
    // rust: let terrain = Arc::downgrade(self);
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Ring search".into())
    // rust: .spawn(move || {
    // rust: horizon_threads::idle_current();
    // rust: loop {
    // rust: std::thread::sleep(std::time::Duration::from_millis(500));
                    // The world closed: nothing to search for.
    // rust: let Some(terrain) = terrain.upgrade() else {
    // rust: return;
}
    // rust: let now = terrain.elapsed_ms();
    // rust: let last = terrain
    // rust: .last_proto
    // rust: .load(std::sync::atomic::Ordering::Relaxed);
    // rust: if now >= LATEST || (last > 0 && now - last >= QUIET) {
    // rust: let _ = terrain
    // rust: .generator
    // rust: .worker()
    // rust: .ring_positions("minecraft:strongholds");
    // rust: return;
}
}
    // rust: });
    // rust: if let Err(e) = spawned {
    // rust: log::warn!("ring search thread: {e}");
}
}
pub fn elapsed_ms(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: u64::try_from(self.created.elapsed().as_millis()).unwrap_or(u64::MAX)
}
}
/// A bundle directory, the data packs over it, and what loading them gave.
    // rust: type SharedEntry = (std::path::PathBuf, WorldgenOverrides, Arc<GeneratorData>);
pub const SHARED_DATA: std::sync::Mutex<std.ArrayList(SharedEntry)> = std::sync::Mutex::new(Vec::new());
/// Bundles with data packs kept besides the plain ones: a world's dimensions
/// share one, and returning to a world finds it.
pub const SHARED_WITH_PACKS: usize = 2;
/// Let go of the bundles `shared_data` loaded: for a preload no world used
/// (game/world_loading.rs). A generator that holds one keeps it.
pub fn forget_shared_data() void {
}
    // rust: SHARED_DATA
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .clear();
}
/// The worldgen bundle at `dir`, loaded once and shared by every generator
/// and by live feature placement (sapling growth, bone meal).
    // rust: pub fn shared_data(
    // rust: dir: &Path,
    // rust: registry: &'static BlockRegistry,
    // rust: ) -> crate::Result<Arc<GeneratorData>> {
    // rust: shared_data_with(dir, &WorldgenOverrides::default(), registry)
}
/// `shared_data` with a world's data packs over the bundle: loaded once for
/// each set of packs' entries, the most recent few kept.
    // rust: pub fn shared_data_with(
    // rust: dir: &Path,
    // rust: overrides: &WorldgenOverrides,
    // rust: registry: &'static BlockRegistry,
    // rust: ) -> crate::Result<Arc<GeneratorData>> {
    // rust: let mut cache = SHARED_DATA.lock().unwrap_or_else(|e| e.into_inner());
    // rust: if let Some((_, _, data)) = cache
    // rust: .iter()
    // rust: .find(|(path, o, _)| path == dir && o == overrides)
    // rust: {
    // rust: return Ok(data.clone());
}
    // rust: let started = std::time::Instant::now();
    // rust: let data = GeneratorData::load_with(dir, registry, overrides)?;
    // rust: log::info!("Horizon: worldgen data loaded in {:?}", started.elapsed());
    // rust: for warning in data.warnings() {
    // rust: log::warn!("Horizon: data pack worldgen: {warning}");
}
    // rust: if !overrides.is_empty()
    // rust: && cache.iter().filter(|e| !e.1.is_empty()).count() >= SHARED_WITH_PACKS
    // rust: {
    // rust: let oldest = cache.iter().position(|e| !e.1.is_empty());
    // rust: cache.remove(oldest.expect("counted"));
}
    // rust: cache.push((dir.to_owned(), overrides.clone(), data.clone()));
    // rust: Ok(data)
}
    // rust: impl ChunkGenerator for VanillaTerrain {
    // rust: type Worker = GeneratorWorker;
pub fn worker(self: *Self) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut worker = self.generator.worker();
    // rust: worker.set_structure_mobs(self.structure_mobs.clone());
    // rust: worker
}
pub fn lod_sampler(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Box::new(VanillaLodSampler::new(self))
}
pub fn idle(self: *Self, worker: *mut GeneratorWorker) void {
}
    // rust: worker.release();
}
pub fn all_idle(self: *Self) void {
}
    // rust: self.generator.release_caches();
}
    // rust: fn lod_surface(
    // rust: &self,
    // rust: worker: &mut GeneratorWorker,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Option<crate::lod::Surface> {
    // rust: Some(self.client_surface(worker.surface_sample(x, z)?))
}
    /// The structure starts a saved chunk references, as vanilla reads them
    /// with the chunk: built here, on the loading worker, into the
    /// generator's cache, rather than on the game thread the first time
    /// spawning or a mob asks which structures hold a position (a village
    /// start took 70 to 110 ms there, one tick each, after a world loaded).
pub fn prepare_loaded(self: *Self, worker: *mut GeneratorWorker, chunk: *Chunk) void {
}
    // rust: let mut starts: Vec<(i32, i32)> = chunk.structure_refs.iter().map(|(_, at)| *at).collect();
    // rust: starts.sort_unstable();
    // rust: starts.dedup();
    // rust: for (x, z) in starts {
    // rust: worker.structure_starts(ChunkPos::new(x, z));
}
}
pub fn proto(self: *Self, worker: *mut GeneratorWorker, x: i32, z: i32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.last_proto.store(
    // rust: self.elapsed_ms().max(1),
    // rust: std::sync::atomic::Ordering::Relaxed,
    // rust: );
    // rust: match worker.generate_proto(ChunkPos::new(x, z)) {
    // rust: Ok(chunk) => Box::new(VanillaProto::Ready(Box::new(chunk))),
    // rust: Err(e) => {
    // rust: log::warn!("Horizon: generating chunk {x} {z} failed: {e}");
    // rust: Box::new(VanillaProto::Failed(x, z))
}
}
}
pub fn decorates(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn decorates_beside_final(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
    /// A final chunk's proto chunk: terrain generated again with the final
    /// chunk's blocks over it, so that features read and write it as they do
    /// the chunks around it (`ChunkAccess` of a full chunk in the region).
pub fn proto_beside_final(self: *Self, worker: *mut GeneratorWorker, snapshot: *Chunk) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut proto = self.proto(worker, snapshot.x, snapshot.z);
    // rust: self.restore_proto(
    // rust: &mut proto,
    // rust: SavedProto {
    // rust: column: snapshot.clone(),
    // rust: decorated: true,
    // rust: block_entities: Vec::new(),
    // rust: entities: Vec::new(),
    // rust: },
    // rust: );
    // rust: Some(proto)
}
pub fn final_writes(self: *Self, snapshot: *Chunk, proto: *Proto) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(VanillaProto::Ready(chunk)) = proto.downcast_ref::<VanillaProto>() else {
    // rust: return Vec::new();
}
    // rust: let (bx, bz) = (snapshot.x * 16, snapshot.z * 16);
    // rust: let (lo, hi) = (
    // rust: chunk.terrain.min_y().max(snapshot.min_y()),
    // rust: (chunk.terrain.min_y() + chunk.terrain.height()).min(snapshot.max_y()),
    // rust: );
    // rust: let mut writes = Vec::new();
    // rust: for y in lo..hi {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let state = chunk.block(bx + x, y, bz + z).0;
    // rust: if state != snapshot.get(x, y, z) {
    // rust: writes.push(([bx + x, y, bz + z], state));
}
}
}
}
    // rust: writes
}
    // rust: fn final_block_entities(
    // rust: &self,
    // rust: proto: &Proto,
    // rust: writes: &[([i32; 3], u32)],
    // rust: ) -> Vec<((i32, i32, i32), crate::chunk::block_entity::BlockEntity)> {
    // rust: let Some(VanillaProto::Ready(chunk)) = proto.downcast_ref::<VanillaProto>() else {
    // rust: return Vec::new();
}
    // rust: if chunk.block_entities.is_empty() {
    // rust: return Vec::new();
}
    // rust: let (made, _rolled) = crate::structure_blocks::block_entities(chunk, self.loot.as_deref());
    // rust: made.into_iter()
    // rust: .filter(|((x, y, z), _)| writes.iter().any(|(p, _)| *p == [*x, *y, *z]))
    // rust: .collect()
}
pub fn decorate(self: *Self, worker: *mut GeneratorWorker, region: *mut [Proto; 9]) void {
}
    // rust: let taken: Vec<Box<VanillaProto>> = region
    // rust: .iter_mut()
    // rust: .map(|p| {
    // rust: std::mem::replace(p, Box::new(()))
    // rust: .downcast::<VanillaProto>()
    // rust: .expect("vanilla proto")
    // rust: })
    // rust: .collect();
    // rust: let all_ready = taken.iter().all(|p| matches!(**p, VanillaProto::Ready(_)));
    // rust: if all_ready {
    // rust: let chunks: Vec<ProtoChunk> = taken
    // rust: .into_iter()
    // rust: .map(|p| match *p {
    // rust: VanillaProto::Ready(c) => *c,
    // rust: VanillaProto::Failed(..) => unreachable!(),
    // rust: })
    // rust: .collect();
    // rust: let mut array: [ProtoChunk; 9] = match chunks.try_into() {
    // rust: Ok(a) => a,
    // rust: Err(_) => unreachable!(),
}
    // rust: if let Err(e) = worker.decorate(&mut array) {
    // rust: log::warn!("Horizon: decorating chunk failed: {e}");
}
    // rust: for (slot, chunk) in region.iter_mut().zip(array) {
    // rust: *slot = Box::new(VanillaProto::Ready(Box::new(chunk)));
}
    // rust: } else {
    // rust: for (slot, p) in region.iter_mut().zip(taken) {
    // rust: *slot = p;
}
}
}
pub fn is_decorated(self: *Self, proto: *Proto) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(proto.downcast_ref::<VanillaProto>(), Some(VanillaProto::Ready(c)) if c.is_decorated())
}
pub fn light_view(self: *Self, proto: *Proto) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match proto.downcast_ref::<VanillaProto>() {
    // rust: Some(VanillaProto::Ready(chunk)) => Some(self.block_column(chunk)),
    // rust: _ => None,
}
}
pub fn cache_census(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = self.generator.cache_census();
    // rust: vec![
    // rust: ("biome_chunks", c.biome_chunks, Some(c.biome_bytes)),
    // rust: ("carver_biomes", c.carver_entries, None),
    // rust: ("start_chunks", c.start_chunks, None),
    // rust: ("start_lists", c.start_lists, None),
    // rust: ]
}
pub fn proto_heap_bytes(self: *Self, proto: *Proto) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match proto.downcast_ref::<VanillaProto>() {
    // rust: Some(VanillaProto::Ready(chunk)) => (chunk.heap_bytes(), chunk.terrain.storage_bits()),
    // rust: _ => ([0; 6], [0; 16]),
}
}
pub fn non_air_sections(self: *Self, proto: *Proto) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(VanillaProto::Ready(chunk)) = proto.downcast_ref::<VanillaProto>() else {
    // rust: return None;
}
        // The proto's sections from its own minimum Y; the column's from the
        // layout's.
    // rust: let layout = self.layout();
    // rust: let below = (chunk.terrain.min_y() - layout.min_y()) >> 4;
    // rust: let mut mask = crate::section_mask::SectionMask::EMPTY;
    // rust: for i in chunk.terrain.filled_sections() {
    // rust: if let Ok(i) = usize::try_from(i as i32 + below)
    // rust: && i < layout.sections()
    // rust: {
    // rust: mask.insert(i);
}
}
    // rust: Some(mask)
}
pub fn saved_proto(self: *Self, proto: *Proto) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(VanillaProto::Ready(chunk)) = proto.downcast_ref::<VanillaProto>() else {
    // rust: return None;
}
    // rust: let block_entities = chunk
    // rust: .block_entities
    // rust: .iter()
    // rust: .map(|(pos, nbt)| {
    // rust: let mut nbt = nbt.clone();
                // Placed data can lack its type (a brushable block's loot table
                // alone); vanilla saves every pending block entity with its id,
                // and skips one without when the chunk finishes.
    // rust: if let Some(id) =
    // rust: crate::lan::chunks::block_entity_type(chunk.block_name(pos[0], pos[1], pos[2]))
    // rust: {
    // rust: nbt.insert("id".into(), Tag::String(id.into()));
}
    // rust: for (key, v) in ["x", "y", "z"].into_iter().zip(pos) {
    // rust: nbt.insert(key.into(), Tag::Int(*v));
}
    // rust: Tag::Compound(nbt)
    // rust: })
    // rust: .collect();
    // rust: Some(SavedProto {
    // rust: column: self.column(chunk),
    // rust: decorated: chunk.is_decorated(),
    // rust: block_entities,
    // rust: entities: chunk.entities.iter().cloned().map(Tag::Compound).collect(),
    // rust: })
}
    /// The saved state replaces what decoration can change; biomes, structure
    /// starts and references are generated again as they were.
pub fn restore_proto(self: *Self, proto: *mut Proto, saved: SavedProto) void {
}
    // rust: let Some(VanillaProto::Ready(chunk)) = proto.downcast_mut::<VanillaProto>() else {
    // rust: return;
}
    // rust: let column = &saved.column;
    // rust: let (bx, bz) = (column.x * 16, column.z * 16);
    // rust: let (lo, hi) = (
    // rust: chunk.terrain.min_y().max(column.min_y()),
    // rust: (chunk.terrain.min_y() + chunk.terrain.height()).min(column.max_y()),
    // rust: );
    // rust: for y in lo..hi {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let state = column.block(x, y, z);
    // rust: if chunk.block(bx + x, y, bz + z) != state {
    // rust: let _ = chunk.terrain.set_block_raw(bx + x, y, bz + z, state);
}
}
}
}
    // rust: if saved.decorated {
    // rust: chunk
    // rust: .terrain
    // rust: .set_generation_stage(PreLightChunkStage::Features);
    // rust: chunk.set_decorated();
}
        // Heightmaps follow the blocks (ProtoChunk primes missing ones on read).
    // rust: let stage = chunk.terrain.generation_stage().heightmaps();
    // rust: let kinds: Vec<HeightmapType> = HeightmapType::ALL
    // rust: .into_iter()
    // rust: .filter(|&k| chunk.terrain.heightmap(k).is_some() || stage.contains(&k))
    // rust: .collect();
    // rust: let _ = chunk.terrain.prime_heightmaps(&kinds);
    // rust: let ticks = |ticks: &[SavedTick], kind: &dyn Fn(u32) -> Option<u32>| {
    // rust: ProtoChunkTicks::from_saved(ticks.iter().filter_map(|t| {
    // rust: Some(SavedTick {
    // rust: kind: TickTypeId(kind(t.kind.0)?),
    // rust: ..*t
    // rust: })
    // rust: }))
}
    // rust: if let Some(extras) = column.saved.as_deref() {
    // rust: *chunk.terrain.block_ticks_mut() = ticks(&extras.block_ticks, &|k| {
    // rust: self.tick_states.get(k as usize).copied()
    // rust: });
    // rust: *chunk.terrain.fluid_ticks_mut() = ticks(&extras.fluid_ticks, &Some);
}
    // rust: chunk.terrain.clear_postprocessing();
    // rust: for &[x, y, z] in &column.postprocess {
    // rust: chunk.terrain.mark_postprocessing(x, y, z);
}
    // rust: chunk.block_entities = saved
    // rust: .block_entities
    // rust: .into_iter()
    // rust: .filter_map(|tag| {
    // rust: let Tag::Compound(mut nbt) = tag else {
    // rust: return None;
}
    // rust: let mut coordinate = |key: &str| match nbt.remove(&key.into()) {
    // rust: Some(Tag::Int(v)) => Some(v),
    // rust: _ => None,
}
    // rust: let pos = [coordinate("x")?, coordinate("y")?, coordinate("z")?];
    // rust: Some((pos, nbt))
    // rust: })
    // rust: .collect();
    // rust: chunk.entities = saved
    // rust: .entities
    // rust: .into_iter()
    // rust: .filter_map(|tag| match tag {
    // rust: Tag::Compound(nbt) => Some(nbt),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
}
pub fn finish(self: *Self, proto: Proto) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let proto = proto.downcast::<VanillaProto>().expect("vanilla proto");
    // rust: let mut chunk = match *proto {
    // rust: VanillaProto::Ready(c) => c,
    // rust: VanillaProto::Failed(x, z) => return Chunk::with_layout(x, z, self.layout()),
}
    // rust: let mut out = self.column(&chunk);
    // rust: let (block_entities, rolled_loot) =
    // rust: crate::structure_blocks::block_entities(&chunk, self.loot.as_deref());
    // rust: out.block_entities = block_entities;
        // The block entities Horizon does not model (decorated pots with their
        // sherds and loot table) stay as placed, like a
        // loaded chunk's.
    // rust: let mut unmodelled: Vec<Tag> = chunk
    // rust: .block_entities
    // rust: .iter()
    // rust: .filter(|(pos, _)| {
    // rust: !out.block_entities
    // rust: .iter()
    // rust: .any(|(p, _)| *p == (pos[0], pos[1], pos[2]))
    // rust: })
    // rust: .filter_map(|(pos, nbt)| {
    // rust: let id = crate::lan::chunks::block_entity_type(
    // rust: chunk.block_name(pos[0], pos[1], pos[2]),
    // rust: )?;
    // rust: let mut nbt = nbt.clone();
    // rust: nbt.insert("id".into(), Tag::String(id.into()));
    // rust: for (key, v) in ["x", "y", "z"].into_iter().zip(pos) {
    // rust: nbt.insert(key.into(), Tag::Int(*v));
}
    // rust: Some(Tag::Compound(nbt))
    // rust: })
    // rust: .collect();
    // rust: add_default_block_entities(&self.block_entity_types, &mut out, &mut unmodelled);
    // rust: if !unmodelled.is_empty() || !rolled_loot.is_empty() {
    // rust: let mut extras = out
    // rust: .saved
    // rust: .take()
    // rust: .map(Arc::unwrap_or_clone)
    // rust: .unwrap_or_default();
    // rust: extras.block_entities = unmodelled;
    // rust: extras.rolled_loot = rolled_loot;
    // rust: out.saved = Some(Arc::new(extras));
}
    // rust: let entities = std::mem::take(&mut chunk.entities);
        // Chest minecarts keep their loot table; the game rolls it on load.
    // rust: out.entities = entities
    // rust: .into_iter()
    // rust: .map(horizon_world::nbt::Tag::Compound)
    // rust: .collect();
    // rust: for s in &mut out.sections {
    // rust: Arc::make_mut(s).compact();
}
    // rust: out.fresh = true;
    // rust: out
}
}

    // rust: mod default_block_entity_tests {
//     use super::*;

pub fn generated_blocks_get_their_block_entities() void {
}
    // rust: let mut out = Chunk::empty(-2, 3);
    // rust: out.set(4, -40, 9, 7);
    // rust: out.set(5, -40, 9, 6);
    // rust: let mut kinds = vec![None; 8];
    // rust: kinds[6] = Some("minecraft:conduit");
    // rust: kinds[7] = Some("minecraft:sculk_sensor");
    // rust: let mut raw = vec![];
    // rust: add_default_block_entities(&kinds, &mut out, &mut raw);
    // rust: assert!(matches!(
    // rust: out.block_entities[..],
    // rust: [((-28, -40, 57), crate::containers::BlockEntity::Sculk(_))]
    // rust: ));
    // rust: assert_eq!(raw.len(), 1);
    // rust: assert_eq!(
    // rust: raw[0].get("id"),
    // rust: Some(&Tag::String("minecraft:conduit".into()))
    // rust: );
    // rust: add_default_block_entities(&kinds, &mut out, &mut raw);
    // rust: assert_eq!(
    // rust: (out.block_entities.len(), raw.len()),
    // rust: (1, 1),
    // rust: "a placed block entity is kept, not doubled"
    // rust: );
}
}
