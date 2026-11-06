//! Transpiled from Horizon Rust crate
//! Module: horizon-world_generator
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Production noise-chunk generation for one dimension of a world preset.
//!
//! `GeneratorData` holds seed-independent resources parsed once from a bundle
//! directory (see `GeneratorData::load`). `OverworldGenerator` binds a world seed
//! and is shared across threads; each thread owns a `GeneratorWorker`.
//! `generate_proto` runs vanilla's BIOMES and TERRAIN statuses (noise fill with
//! aquifers, material surface, carvers) and primes the post-terrain heightmaps.
//! `decorate` runs the FEATURES status for the center of a 3×3 neighborhood with
//! whatever feature algorithms are implemented; structures are not generated.
// use super::{
    // rust: DecodeError,
    // rust: anchor::WorldGenerationContext,
    // rust: aquifer::{
    // rust: AquiferConfig, AquiferField, AquiferSamplers, DisabledAquifer, GlobalFluidPicker,
    // rust: NoiseBasedAquifer, RegistryAquiferBlockStates,
    // rust: },
    // rust: biome::BiomeId,
    // rust: biome_chunk::{BiomeChunk, BiomeRegion},
    // rust: biome_source::{BiomeSourceCatalog, ResolvedBiomeSource},
    // rust: biome_temperature::{BiomeTemperature, BiomeTemperatureSettings},
    // rust: carver::{CarverCatalog, WorldCarver, generate_carving_mask},
    // rust: carving::{CarvingBlocks, apply_carving_mask_shared},
    // rust: climate::{ClimateSampler, decode_parameter, quantize},
    // rust: decode_noise,
    // rust: density::DensityRegistry,
    // rust: generator_structures::Starts,
    // rust: material_condition::{
    // rust: CompiledSurfaceRule, MaterialConditionRegistry, MaterialConditions, MaterialDensitySources,
    // rust: MaterialRule, MaterialRuleError, MaterialRuleLibrary, MaterialSurfaceQueries,
    // rust: },
    // rust: material_extensions::{ExtensionBlocks, ExtensionNoises, MaterialExtensions},
    // rust: material_stage::{SurfaceInputs, TopMaterialInputs, build_surface_shared},
    // rust: material_surface::{ClayBandBlocks, MaterialSurface},
    // rust: overrides::{self, WorldgenOverrides},
    // rust: router::{NoiseRouter, RouterField, RouterSamplers},
    // rust: settings::NoiseSettings,
    // rust: spawn_finder::{SpawnTargetPoint, find_spawn_position},
    // rust: tags::TagDefinitions,
    // rust: terrain::{PreLightChunkStage, TerrainAquifer, TerrainBlockStates, TerrainChunk, fill_noise},
}
// use crate::{
    // rust: heightmap::{HeightmapState, HeightmapType},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::{
    // rust: biome::{BiomeZoom, obfuscate_seed},
    // rust: density::{DensitySampler, SamplerContext},
    // rust: noise::{DensityVolume, Noise},
    // rust: position::{BlockPos, ChunkPos},
    // rust: random::{LegacyRandom, PositionalRandom, RandomSource, XoroshiroRandom},
}
// use serde_json::Value;
// use std::{
    // rust: any::Any,
    // rust: collections::{BTreeMap, BTreeSet, HashMap},
    // rust: fs, io,
    // rust: path::Path,
    // rust: sync::{Arc, Mutex, OnceLock},
}

pub const GeneratorError = enum {
    Io(io::Error),
    Decode(DecodeError),
    /// A resource is missing or inconsistent with the block registry.
    Resource(String),
    /// A generation stage failed; the chunk is incomplete.
    Stage(&'static str, String),
};
    // rust: impl std::fmt::Display for GeneratorError {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Io(e) => e.fmt(f),
    // rust: Self::Decode(e) => e.fmt(f),
    // rust: Self::Resource(e) => write!(f, "invalid generator resources: {e}"),
    // rust: Self::Stage(stage, e) => write!(f, "{stage} failed: {e}"),
}
}
}
    // rust: impl std::error::Error for GeneratorError {}
    // rust: impl From<io::Error> for GeneratorError {
pub fn from(e: io::Error) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Io(e)
}
}
    // rust: impl From<DecodeError> for GeneratorError {
pub fn from(e: DecodeError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Decode(e)
}
}
    // rust: impl From<serde_json::Error> for GeneratorError {
pub fn from(e: serde_json::Error) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Decode(e.into())
}
}
    // rust: fn stage<E: std::fmt::Display>(name: &'static str) -> impl FnOnce(E) -> GeneratorError {
    // rust: move |e| GeneratorError::Stage(name, e.to_string())
}
pub fn resource(message: impl Into<[]const u8>) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: GeneratorError::Resource(message.into())
}

/// Heightmap-relevant block behavior, one entry per registry state.
pub const GenBlockState = struct {
    air: bool,
    air_block: bool,
    fluid: bool,
    motion: bool,
    no_leaves: bool,
};
    // rust: impl HeightmapState for GenBlockState {
pub fn is_air(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.air
}
pub fn is_air_block(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.air_block
}
pub fn has_fluid(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fluid
}
pub fn blocks_motion_in_heightmap(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.motion
}
pub fn blocks_motion_in_heightmap_no_leaves(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.no_leaves
}
}
/// Shared, cheaply cloned state table bound into every generated chunk.
pub const GenBlockStates = struct {};
    // rust: impl GenBlockStates {
pub fn get(self: *Self, id: BlockStateId) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.get(id.0 as usize).copied().unwrap_or_default()
}
}
    // rust: impl TerrainBlockStates for GenBlockStates {
    // rust: type State = GenBlockState;
pub fn heightmap_state(self: *Self, id: BlockStateId) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(id)
}
}

/// Feature resources for the FEATURES status, keyed by resource identifier.
    // rust: pub(super) struct FeatureResources {
    // rust: pub(super) features: BTreeMap<String, String>,
    // rust: pub(super) placed: BTreeMap<String, String>,
    // rust: pub(super) feature_tags: BTreeMap<String, String>,
    // rust: pub(super) fluid_tags: BTreeMap<String, Vec<String>>,
    // rust: pub(super) state_providers: BTreeMap<String, String>,
    /// Block properties, support, collision and survival for placement checks.
    // rust: pub(super) blocks: Option<super::generator_blocks::BlockBehavior>,
}

/// Raw structure, structure-set and template-pool resources.
    // rust: pub(super) struct StructureBundles {
    // rust: pub(super) structures: BTreeMap<String, String>,
    // rust: pub(super) sets: BTreeMap<String, String>,
    // rust: pub(super) pools: BTreeMap<String, String>,
}

/// Seed-independent generation resources, loaded once and shared by every
/// generator. Biome identities are indices into the sorted biome registry.
pub const GeneratorData = struct {
    registry: *'static BlockRegistry,
    states: GenBlockStates,
    integers: BTreeSet<([]const u8,
    noises: BTreeMap<[]const u8,
    densities: BTreeMap<[]const u8,
    rules: BTreeMap<[]const u8,
    settings: BTreeMap<[]const u8,
    presets: BTreeMap<[]const u8,
    world_presets: BTreeMap<[]const u8,
    /// Data packs' level stems (`dimension/<id>.json`), by dimension id:
    /// they replace the world preset's.
    dimensions: BTreeMap<[]const u8,
    /// Data packs' dimension types (`dimension_type/<id>.json`), by id:
    /// they replace the vanilla ones' build ranges.
    dimension_types: BTreeMap<[]const u8,
    /// What loading the data packs' entries left out, for the log.
    warnings: std.ArrayList([]const u8),
    conditions: MaterialConditionRegistry,
    source_catalog: BiomeSourceCatalog,
    biome_names: std.ArrayList(*str),
    biome_ids: BTreeMap<[]const u8,
    biome_json: std.ArrayList([]const u8),
    temperatures: std.ArrayList(BiomeTemperatureSettings),
    biome_carvers: std.ArrayList(Vec<*WorldCarver)>,
    carving_blocks: CarvingBlocks,
    // rust: pub(super) block_tags: BTreeMap<String, Vec<String>>,
    /// `block_tags` bound to block states, once for the feature bindings of
    /// decoration, structures and live features (`feature_block_bindings`).
    bound_block_tags: std::sync::OnceLock<super::block_feature::BoundBlockTags>,
    // rust: pub(super) biome_tags: BTreeMap<String, Vec<String>>,
    // rust: pub(super) feature_resources: Option<FeatureResources>,
    /// Templates, processor lists and per-state template transforms.
    // rust: pub(super) structures: Option<Arc<super::structure::StructureResources>>,
    // rust: pub(super) structure_resources: Option<StructureBundles>,
    /// Block shape-update behaviour (`block-behaviours.json` next to the
    /// worldgen directory) for template placement's neighbor updates.
    // rust: pub(super) behaviours: Option<Arc<crate::level::Behaviours>>,
    /// Concentric ring positions by seed and dimension generator (see
    /// `rings_for`), most recent last.
    ring_cache: Mutex<std.ArrayList(RingCacheEntry)>,
    /// Placed-feature decoration by biome source (see `decoration_for`),
    /// most recent last.
    decorations: Mutex<Vec<([]const u8,
    /// What `BlendingData` asks of the blocks of an old chunk, by state.
    old_chunk_facts: OnceLock<OldChunkFacts>,
};
/// `BlendingData.isGround` and `SURFACE_BLOCKS`, by block state id.
pub const OldChunkFacts = struct {
    ground: std.ArrayList(bool),
    surface: std.ArrayList(bool),
};
    // rust: type RingCacheEntry = ((i64, String), Arc<OnceLock<super::structure::start::Rings>>);
/// Generators whose ring positions are kept: the dimensions of a few worlds.
pub const RING_CACHE_LIMIT: usize = 8;
    // rust: type DecorationSlot =
    // rust: Arc<OnceLock<Result<Option<Arc<super::generator_decoration::Decoration>>, String>>>;
/// Biome sources whose decoration is kept: the three dimensions and a spare.
pub const DECORATION_CACHE_LIMIT: usize = 4;
    // rust: type Bundle = BTreeMap<String, String>;
/// The bundle `name` with the data packs' entries over it.
    // rust: fn read_bundle(
    // rust: dir: &Path,
    // rust: overrides: &WorldgenOverrides,
    // rust: name: &str,
    // rust: ) -> Result<Bundle, GeneratorError> {
    // rust: let path = dir.join(format!("{name}.json"));
    // rust: let text =
    // rust: fs::read_to_string(&path).map_err(|e| resource(format!("{}: {e}", path.display())))?;
    // rust: Ok(overrides.apply(name, serde_json::from_str(&text)?))
}
    // rust: fn read_optional_bundle(
    // rust: dir: &Path,
    // rust: overrides: &WorldgenOverrides,
    // rust: name: &str,
    // rust: ) -> Result<Option<Bundle>, GeneratorError> {
    // rust: if dir.join(format!("{name}.json")).exists() {
    // rust: read_bundle(dir, overrides, name).map(Some)
    // rust: } else {
    // rust: Ok(None)
}
}
/// The tags of the bundle `name`, the data packs' tag files after the
/// prepared ones. A tag naming what is not there fails on its own, as
/// vanilla's TagLoader leaves it out. Without packs the prepared tags must
/// all resolve; with them (a pack's tag can also break a prepared tag that
/// includes it), each failed tag goes into `dropped` for the log.
    // rust: fn build_tags(
    // rust: raw: &Bundle,
    // rust: overrides: &WorldgenOverrides,
    // rust: name: &str,
    // rust: dropped: &mut Vec<String>,
    // rust: known: impl Fn(&str) -> bool,
    // rust: ) -> Result<BTreeMap<String, Vec<String>>, GeneratorError> {
    // rust: let mut definitions = TagDefinitions::default();
    // rust: for (name, json) in raw {
    // rust: definitions.apply_json(name, "vanilla", json)?;
}
    // rust: for (id, pack, json) in overrides.tags(name) {
    // rust: definitions
    // rust: .apply_json(id, pack, json)
    // rust: .map_err(|e| resource(format!("{pack}: tag {id}: {e}")))?;
}
    // rust: let built = definitions
    // rust: .build(|id, _| known(id).then(|| id.to_owned()))
    // rust: .map_err(|e| resource(format!("tags: {e:?}")))?;
    // rust: if overrides.tags(name).next().is_none() && !built.missing.is_empty() {
    // rust: return Err(resource(format!(
    // rust: "unresolved tag entries in {:?}",
    // rust: built.missing.keys().collect::<Vec<_>>()
    // rust: )));
}
    // rust: for (tag, entries) in &built.missing {
    // rust: dropped.push(format!(
    // rust: "{name}: tag {tag} names what is missing: {}",
    // rust: entries
    // rust: .iter()
    // rust: .map(|e| format!("{:?} ({})", e.entry, e.source))
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ")
    // rust: ));
}
    // rust: Ok(built.tags)
}
/// Convert a data-generator `biome_parameters` report into the quantized
/// preset table format, using vanilla's float `quantizeCoord`.
pub fn quantize_parameter_report(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let report: Value = serde_json::from_str(json)?;
    // rust: let float = |v: &Value| -> Result<i64, GeneratorError> {
    // rust: let text = v.to_string();
    // rust: text.parse::<f32>()
    // rust: .map(quantize)
    // rust: .map_err(|_| resource("biome parameter value"))
}
    // rust: let mut entries = Vec::new();
    // rust: for entry in report["biomes"]
    // rust: .as_array()
    // rust: .ok_or_else(|| resource("biome parameter report"))?
    // rust: {
    // rust: let parameters = &entry["parameters"];
    // rust: let mut coordinates = Vec::new();
    // rust: for key in [
    // rust: "temperature",
    // rust: "humidity",
    // rust: "continentalness",
    // rust: "erosion",
    // rust: "depth",
    // rust: "weirdness",
    // rust: ] {
    // rust: let value = &parameters[key];
    // rust: coordinates.push(match value.as_array() {
    // rust: Some(range) if range.len() == 2 => {
    // rust: serde_json::json!([float(&range[0])?, float(&range[1])?])
}
    // rust: None if value.is_number() => {
    // rust: let v = float(value)?;
    // rust: serde_json::json!([v, v])
}
    // rust: _ => return Err(resource("biome parameter interval")),
    // rust: });
}
    // rust: entries.push(serde_json::json!({
    // rust: "coordinates": coordinates,
    // rust: "offset": float(&parameters["offset"])?,
    // rust: "biome": entry["biome"],
    // rust: }));
}
    // rust: Ok(Value::Array(entries).to_string())
}
/// `load` on a thread of its own ("Worldgen loader").
    // rust: fn loading<T: Send + 'static>(
    // rust: load: impl FnOnce() -> T + Send + 'static,
    // rust: ) -> io::Result<std::thread::JoinHandle<T>> {
    // rust: std::thread::Builder::new()
    // rust: .name("Worldgen loader".into())
    // rust: .spawn(load)
}
/// A loading thread's result; its panic goes on in this thread.
    // rust: fn joined<T>(thread: std::thread::JoinHandle<T>) -> T {
    // rust: thread
    // rust: .join()
    // rust: .unwrap_or_else(|panic| std::panic::resume_unwind(panic))
}
    // rust: impl GeneratorData {
    /// Load a worldgen bundle directory. Required files are JSON objects mapping
    /// resource identifiers to the resource's JSON text: `noises`, `densities`,
    /// `rules` (material rules), `conditions` (material conditions), `settings`
    /// (noise settings), `carvers`, `biomes`, `biome_tags`, `block_tags`,
    /// `world_presets`; `block_flags.json` is an array of `[is_air, has_fluid]`
    /// per registry state. Multi-noise tables come from `presets.json`
    /// (quantized) or `biome_parameters/<name>.json` data-generator reports.
    /// Optional decoration inputs: `features`, `placed_features`,
    /// `feature_tags`, `fluid_tags`, `state_providers` and the Java-exported
    /// block behavior files in `blocks/` (see `generator_blocks`). Integer block properties are derived from
    /// the registry: properties whose every value is a decimal integer.
pub fn load(dir: *Path, registry: *'static BlockRegistry) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::load_with(dir, registry, &WorldgenOverrides::default())
}
    /// `load` with a world's data packs over the bundles (see `overrides`).
    // rust: pub fn load_with(
    // rust: dir: &Path,
    // rust: registry: &'static BlockRegistry,
    // rust: ov: &WorldgenOverrides,
    // rust: ) -> Result<Arc<Self>, GeneratorError> {
    // rust: let mut warnings = Vec::new();
    // rust: let flags: Vec<(bool, bool)> =
    // rust: serde_json::from_str(&fs::read_to_string(dir.join("block_flags.json"))?)?;
    // rust: if flags.len() != registry.len() {
    // rust: return Err(resource("block_flags.json does not match the registry"));
}
    // rust: let block_tags = build_tags(
    // rust: &read_bundle(dir, ov, "block_tags")?,
    // rust: ov,
    // rust: "block_tags",
    // rust: &mut warnings,
    // rust: |id| registry.default_state(id).is_some(),
    // rust: )?;
    // rust: let fluid_tags = match read_optional_bundle(dir, ov, "fluid_tags")? {
    // rust: Some(raw) => build_tags(&raw, ov, "fluid_tags", &mut warnings, |id| {
    // rust: matches!(
    // rust: id,
    // rust: "minecraft:water"
    // rust: | "minecraft:flowing_water"
    // rust: | "minecraft:lava"
    // rust: | "minecraft:flowing_lava"
    // rust: | "minecraft:empty"
    // rust: )
    // rust: })?,
    // rust: None => BTreeMap::new(),
}
        // The three biggest reads (the block tables, the structure templates
        // and the block behaviours) need only the tags: they run on threads of
        // their own while this one reads the rest. A new world's first chunks
        // wait for all of it, with the chunk workers idle.
    // rust: let blocks = loading({
    // rust: let (dir, tags, fluids) = (dir.join("blocks"), block_tags.clone(), fluid_tags.clone());
    // rust: move || super::generator_blocks::BlockBehavior::load(&dir, registry, &tags, &fluids)
    // rust: })?;
    // rust: let structures = loading({
    // rust: let (dir, tags, ov) = (dir.to_owned(), block_tags.clone(), ov.clone());
    // rust: move || -> Result<_, GeneratorError> {
    // rust: let Ok(json) = fs::read_to_string(dir.join("blocks/structure-blocks.json")) else {
    // rust: return Ok(None);
}
    // rust: Ok(Some(Arc::new(super::structure::StructureResources::new(
    // rust: registry,
    // rust: super::structure::StateTransforms::from_json(&json, registry.len())?,
    // rust: &dir.join("structure"),
    // rust: read_optional_bundle(&dir, &ov, "processor_lists")?.unwrap_or_default(),
    // rust: &tags,
    // rust: ))))
}
    // rust: })?;
    // rust: let behaviours = loading({
    // rust: let root = dir.parent().map(Path::to_owned);
    // rust: move || {
    // rust: root.filter(|root| root.join("block-behaviours.json").exists())
    // rust: .and_then(|root| crate::level::Behaviours::load(registry, &root).ok())
    // rust: .map(Arc::new)
}
    // rust: })?;
    // rust: let tag_set = |name: &str| -> Result<BTreeSet<&str>, GeneratorError> {
    // rust: Ok(block_tags
    // rust: .get(name)
    // rust: .ok_or_else(|| resource(format!("missing block tag {name}")))?
    // rust: .iter()
    // rust: .map(String::as_str)
    // rust: .collect())
}
    // rust: let motion = tag_set("minecraft:blocks_motion_in_heightmap")?;
    // rust: let no_leaves = tag_set("minecraft:blocks_motion_in_heightmap_no_leaves")?;
    // rust: let mut values = BTreeMap::<(String, String), bool>::new();
    // rust: let states = (0..registry.len())
    // rust: .map(|i| {
    // rust: let state = registry.state(BlockStateId(i as u32)).unwrap();
    // rust: for (key, value) in &state.properties {
    // rust: let integer = !value.is_empty()
    // rust: && value
    // rust: .trim_start_matches('-')
    // rust: .bytes()
    // rust: .all(|b| b.is_ascii_digit());
    // rust: *values
    // rust: .entry((state.name.clone(), key.clone()))
    // rust: .or_insert(true) &= integer;
}
    // rust: GenBlockState {
    // rust: air: flags[i].0,
    // rust: air_block: state.name == "minecraft:air",
    // rust: fluid: flags[i].1,
    // rust: motion: motion.contains(state.name.as_str()),
    // rust: no_leaves: no_leaves.contains(state.name.as_str()),
}
    // rust: })
    // rust: .collect::<Vec<_>>();
    // rust: let integers = values
    // rust: .into_iter()
    // rust: .filter_map(|(key, integer)| integer.then_some(key))
    // rust: .collect();
    // rust: let biomes = read_bundle(dir, ov, "biomes")?;
    // rust: let biome_tags = build_tags(
    // rust: &read_bundle(dir, ov, "biome_tags")?,
    // rust: ov,
    // rust: "biome_tags",
    // rust: &mut warnings,
    // rust: |id| biomes.contains_key(id),
    // rust: )?;
    // rust: let biome_set = biomes.keys().cloned().collect::<BTreeSet<_>>();
    // rust: let conditions = MaterialConditionRegistry::from_json_with_biome_tags(
    // rust: &read_bundle(dir, ov, "conditions")?,
    // rust: &biome_set,
    // rust: &biome_tags,
    // rust: )?;
    // rust: let mut presets = read_optional_bundle(dir, ov, "presets")?.unwrap_or_default();
    // rust: let reports = dir.join("biome_parameters");
    // rust: if reports.is_dir() {
    // rust: for entry in fs::read_dir(&reports)? {
    // rust: let path = entry?.path();
    // rust: let Some(stem) = path
    // rust: .file_stem()
    // rust: .and_then(|s| s.to_str())
    // rust: .filter(|_| path.extension().is_some_and(|e| e == "json"))
    // rust: else {
    // rust: continue;
}
    // rust: presets
    // rust: .entry(format!("minecraft:{stem}"))
    // rust: .or_insert(quantize_parameter_report(&fs::read_to_string(&path)?)?);
}
}
    // rust: let source_catalog =
    // rust: BiomeSourceCatalog::new(&biome_set, &biome_tags, &presets.keys().cloned().collect())?;
    // rust: let carvers = CarverCatalog::from_json(&read_bundle(dir, ov, "carvers")?)?;
    // rust: let mut biome_names = Vec::new();
    // rust: let mut biome_ids = BTreeMap::new();
    // rust: let mut biome_json = Vec::new();
    // rust: let mut temperatures = Vec::new();
    // rust: let mut biome_carvers = Vec::new();
    // rust: for (name, json) in &biomes {
    // rust: biome_ids.insert(name.clone(), BiomeId(biome_names.len() as u32));
    // rust: biome_names.push(Arc::<str>::from(name.as_str()));
    // rust: temperatures.push(BiomeTemperatureSettings::from_json(json)?);
    // rust: let value: Value = serde_json::from_str(json)?;
    // rust: biome_carvers.push(carvers.decode_set(&value["carvers"].to_string())?);
    // rust: biome_json.push(json.clone());
}
    // rust: let carving_blocks = CarvingBlocks::from_registry(
    // rust: registry,
    // rust: &tag_set("minecraft:uncarvable")?
    // rust: .into_iter()
    // rust: .map(str::to_owned)
    // rust: .collect(),
    // rust: )
    // rust: .map_err(|e| resource(format!("carving blocks: {e}")))?;
    // rust: let feature_resources = match (
    // rust: read_optional_bundle(dir, ov, "features")?,
    // rust: read_optional_bundle(dir, ov, "placed_features")?,
    // rust: ) {
    // rust: (Some(features), Some(placed)) => Some(FeatureResources {
    // rust: features,
    // rust: placed,
    // rust: feature_tags: read_optional_bundle(dir, ov, "feature_tags")?.unwrap_or_default(),
    // rust: blocks: joined(blocks)?,
    // rust: fluid_tags,
    // rust: state_providers: read_optional_bundle(dir, ov, "state_providers")?
    // rust: .unwrap_or_default(),
    // rust: }),
    // rust: _ => None,
}
    // rust: let structures = joined(structures)?;
    // rust: let structure_resources = match (
    // rust: read_optional_bundle(dir, ov, "structures")?,
    // rust: read_optional_bundle(dir, ov, "structure_sets")?,
    // rust: read_optional_bundle(dir, ov, "template_pools")?,
    // rust: ) {
    // rust: (Some(structures), Some(sets), Some(pools)) => Some(StructureBundles {
    // rust: structures,
    // rust: sets,
    // rust: pools,
    // rust: }),
    // rust: _ => None,
}
    // rust: let behaviours = joined(behaviours);
    // rust: Ok(Arc::new(Self {
    // rust: behaviours,
    // rust: structure_resources,
    // rust: structures,
    // rust: registry,
    // rust: states: GenBlockStates(states.into()),
    // rust: integers,
    // rust: noises: read_bundle(dir, ov, "noises")?,
    // rust: densities: read_bundle(dir, ov, "densities")?,
    // rust: rules: read_bundle(dir, ov, "rules")?,
    // rust: settings: read_bundle(dir, ov, "settings")?,
    // rust: world_presets: read_bundle(dir, ov, "world_presets")?,
    // rust: dimensions: ov.apply(overrides::DIMENSIONS, BTreeMap::new()),
    // rust: dimension_types: ov.apply(overrides::DIMENSION_TYPES, BTreeMap::new()),
    // rust: warnings,
    // rust: presets,
    // rust: conditions,
    // rust: source_catalog,
    // rust: biome_names,
    // rust: biome_ids,
    // rust: biome_json,
    // rust: temperatures,
    // rust: biome_carvers,
    // rust: carving_blocks,
    // rust: block_tags,
    // rust: biome_tags,
    // rust: feature_resources,
    // rust: ring_cache: Mutex::new(Vec::new()),
    // rust: decorations: Mutex::new(Vec::new()),
    // rust: old_chunk_facts: OnceLock::new(),
    // rust: bound_block_tags: std::sync::OnceLock::new(),
    // rust: }))
}
    /// The concentric ring positions (strongholds) of the generator for
    /// `seed` and the dimension `generator` definition, shared by every
    /// generator built for them. They depend on nothing else, so returning
    /// to a dimension, which builds its generator again, finds them done.
    // rust: pub(super) fn rings_for(
    // rust: &self,
    // rust: seed: i64,
    // rust: generator: &Value,
    // rust: ) -> Arc<OnceLock<super::structure::start::Rings>> {
    // rust: let key = (seed, generator.to_string());
    // rust: let mut cache = self.ring_cache.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let rings = match cache.iter().position(|(k, _)| *k == key) {
    // rust: Some(i) => cache.remove(i).1,
    // rust: None => Arc::new(OnceLock::new()),
}
    // rust: if cache.len() >= RING_CACHE_LIMIT {
    // rust: cache.remove(0);
}
    // rust: cache.push((key, rings.clone()));
    // rust: rings
}
    /// The placed-feature decoration of the biome source `source_json`
    /// (resolved: `source`), shared by every generator that uses it. It
    /// depends on these resources and the source alone, not on the seed, and
    /// building it (decoding the placed features of every biome the source
    /// can place) took about 140 ms of each world opening. A caller that
    /// arrives while another builds it waits for that build.
    // rust: pub(super) fn decoration_for(
    // rust: self: &Arc<Self>,
    // rust: source_json: &str,
    // rust: source: &ResolvedBiomeSource,
    // rust: ) -> Result<Option<Arc<super::generator_decoration::Decoration>>, GeneratorError> {
    // rust: let slot = {
    // rust: let mut cache = self.decorations.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let slot = match cache.iter().position(|(k, _)| k == source_json) {
    // rust: Some(i) => cache.remove(i).1,
    // rust: None => Arc::new(OnceLock::new()),
}
    // rust: if cache.len() >= DECORATION_CACHE_LIMIT {
    // rust: cache.remove(0);
}
    // rust: cache.push((source_json.to_owned(), slot.clone()));
    // rust: slot
}
    // rust: slot.get_or_init(|| {
    // rust: super::generator_decoration::Decoration::new(self, source)
    // rust: .map(|d| d.map(Arc::new))
    // rust: .map_err(|e| e.to_string())
    // rust: })
    // rust: .clone()
    // rust: .map_err(resource)
}
    /// Builds the decoration of `preset`'s `dimension` generator before a
    /// world needs it (the world screens' preload), so opening the world
    /// finds it ready.
    // rust: pub fn prepare_decoration(
    // rust: self: &Arc<Self>,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: ) -> Result<(), GeneratorError> {
    // rust: let preset_json: Value = serde_json::from_str(
    // rust: self.world_presets
    // rust: .get(preset)
    // rust: .ok_or_else(|| resource(format!("missing world preset {preset}")))?,
    // rust: )?;
    // rust: let source_json =
    // rust: preset_json["dimensions"][dimension]["generator"]["biome_source"].to_string();
    // rust: let source = self
    // rust: .source_catalog
    // rust: .decode(&source_json)?
    // rust: .resolve(&self.presets)
    // rust: .map_err(|e| resource(format!("biome source: {e}")))?;
    // rust: self.decoration_for(&source_json, &source).map(drop)
}
pub fn registry(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
}
    /// What loading the data packs' entries left out (tags naming what is
    /// missing), for the log.
pub fn warnings(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.warnings
}
pub fn block_states(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.states
}
    /// Biome identifiers in registry (identifier-sorted) order.
pub fn configured_feature_json(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.feature_resources
    // rust: .as_ref()?
    // rust: .features
    // rust: .get(name)
    // rust: .map(String::as_str)
}
pub fn placed_feature_json(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.feature_resources
    // rust: .as_ref()?
    // rust: .placed
    // rust: .get(name)
    // rust: .map(String::as_str)
}
pub fn biome_names(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.biome_names
}
pub fn old_chunk_facts(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.old_chunk_facts.get_or_init(|| {
    // rust: let members = |tag: &str| -> std::collections::HashSet<&str> {
    // rust: self.block_tags
    // rust: .get(tag)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(String::as_str)
    // rust: .collect()
}
    // rust: let (leaves, logs) = (members("minecraft:leaves"), members("minecraft:logs"));
    // rust: let collision = self
    // rust: .feature_resources
    // rust: .as_ref()
    // rust: .and_then(|resources| resources.blocks.as_ref())
    // rust: .map(|blocks| &blocks.collision);
    // rust: let surface_names = [
    // rust: "minecraft:podzol",
    // rust: "minecraft:gravel",
    // rust: "minecraft:grass_block",
    // rust: "minecraft:stone",
    // rust: "minecraft:coarse_dirt",
    // rust: "minecraft:sand",
    // rust: "minecraft:red_sand",
    // rust: "minecraft:mycelium",
    // rust: "minecraft:snow_block",
    // rust: "minecraft:terracotta",
    // rust: "minecraft:dirt",
    // rust: ];
    // rust: let (mut ground, mut surface) = (Vec::new(), Vec::new());
    // rust: for index in 0..self.registry.len() {
    // rust: let id = BlockStateId(index as u32);
    // rust: let name = self.registry.state(id).map_or("", |s| s.name.as_str());
    // rust: surface.push(surface_names.contains(&name));
                // An empty collision shape: air, the liquids (no entity stands
                // on them), powder snow and the like; and leaves, logs and
                // huge mushrooms, which `isGround` leaves out.
    // rust: let excluded = self.states.get(id).air
    // rust: || leaves.contains(name)
    // rust: || logs.contains(name)
    // rust: || matches!(
    // rust: name,
    // rust: "minecraft:brown_mushroom_block"
    // rust: | "minecraft:red_mushroom_block"
    // rust: | "minecraft:water"
    // rust: | "minecraft:lava"
    // rust: | "minecraft:powder_snow"
    // rust: );
    // rust: ground.push(
    // rust: !excluded
    // rust: && match collision {
    // rust: Some(registry) => registry
    // rust: .collision_block(id)
    // rust: .map_or(true, |block| !block.empty_shape),
    // rust: None => self.states.get(id).motion,
    // rust: },
    // rust: );
}
    // rust: OldChunkFacts { ground, surface }
    // rust: })
}
    /// `BlendingData.isGround` of a block state of an old chunk.
pub fn is_old_chunk_ground(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.old_chunk_facts()
    // rust: .ground
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
    /// Whether the block state is one of `BlendingData.SURFACE_BLOCKS`.
pub fn is_old_chunk_surface(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.old_chunk_facts()
    // rust: .surface
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
pub fn biome_name(self: *Self, id: BiomeId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.biome_names[id.0 as usize]
}
pub fn biome_id(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.biome_ids.get(name).copied()
}
    /// The biome's resource JSON (climate, effects such as water/sky/foliage
    /// colors, attributes, carvers and features).
pub fn biome_json(self: *Self, id: BiomeId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.biome_json[id.0 as usize]
}
    // rust: pub(super) fn integers(&self) -> &BTreeSet<(String, String)> {
    // rust: &self.integers
}
    /// Feature block bindings over this data's blocks and block tags. The tags'
    /// state sets are bound once and shared: each binding held 5 MB of them.
    // rust: pub(super) fn feature_block_bindings(
    // rust: &self,
    // rust: ) -> Result<super::block_feature::FeatureBlockBindings<'static>, DecodeError> {
//         use super::block_feature::FeatureBlockBindings;
    // rust: let bound = match self.bound_block_tags.get() {
    // rust: Some(bound) => bound.clone(),
    // rust: None => {
    // rust: let bound = FeatureBlockBindings::bind_tags(self.registry, &self.block_tags)?;
    // rust: self.bound_block_tags.get_or_init(|| bound).clone()
}
}
    // rust: FeatureBlockBindings::with_bound_tags(self.registry, self.integers.clone(), bound)
}
}

/// A generated chunk with its quart biomes. Blocks and heightmaps live in
/// `terrain`; after `generate_proto` it is at the TERRAIN status with the
/// WORLD_SURFACE(_WG), OCEAN_FLOOR(_WG) and MOTION_BLOCKING(_NO_LEAVES)
/// heightmaps primed. Fluid positions scheduled for postprocessing are kept in
/// `terrain.postprocessing()`.
pub const ProtoChunk = struct {
    terrain: TerrainChunk<'static,
    biomes: BiomeChunk<BiomeId>,
    data: *GeneratorData,
    decorated: bool,
    /// Block-entity data placed by structures and template features, in
    /// placement order (positions are absolute block coordinates).
    block_entities: Vec<([i32,
    /// Structure starts referencing this chunk (STRUCTURE_REFERENCES).
    // rust: pub(super) structure_starts: Vec<Arc<super::structure::start::StructureStart>>,
    /// The starts made in this chunk (STRUCTURE_STARTS), also those none of
    /// whose pieces reach it (a giant ruined portal next door).
    own_starts: Starts,
    /// Entities placed by structures (`ProtoChunk.addEntity`), as NBT with
    /// absolute `Pos`.
    entities: std.ArrayList(crate::nbt::Compound),
};
    // rust: impl ProtoChunk {
    /// Its own heap bytes by part (`horizon-ctl memory`): packed blocks,
    /// section palettes and lists, heightmaps, other terrain data, biomes,
    /// and the box with its structure lists (the starts it shares not counted).
pub fn heap_bytes(self: *Self) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [storage, lists, heightmaps, other] = self.terrain.heap_bytes();
    // rust: [
    // rust: storage,
    // rust: lists,
    // rust: heightmaps,
    // rust: other,
    // rust: self.biomes.heap_bytes(),
    // rust: std::mem::size_of::<Self>()
    // rust: + self.block_entities.capacity()
    // rust: * std::mem::size_of::<([i32; 3], crate::nbt::Compound)>()
    // rust: + self.structure_starts.capacity() * std::mem::size_of::<usize>()
    // rust: + self.entities.capacity() * std::mem::size_of::<crate::nbt::Compound>(),
    // rust: ]
}
pub fn position(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.terrain.position()
}
pub fn block(self: *Self, x: i32, y: i32, z: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.terrain.block(x, y, z)
}
pub fn block_name(self: *Self, x: i32, y: i32, z: i32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self
    // rust: .data
    // rust: .registry
    // rust: .state(self.block(x, y, z))
    // rust: .expect("registered state")
    // rust: .name
}
    /// Stored quart biome (4×4×4 cell) containing this block, without the
    /// client's biome zoom. X/Z wrap to this chunk; Y clamps to its range.
pub fn biome_id_at(self: *Self, x: i32, y: i32, z: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: *self.biomes.noise_biome([x >> 2, y >> 2, z >> 2])
}
pub fn biome_at(self: *Self, x: i32, y: i32, z: i32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data.biome_name(self.biome_id_at(x, y, z))
}
pub fn biomes(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.biomes
}
pub fn data(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.data
}
    /// Structure starts referencing this chunk: (structure id, start chunk,
    /// inclusive bounding box min/max).
pub fn structures(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.structure_starts
    // rust: .iter()
    // rust: .map(|s| {
    // rust: (
    // rust: s.name.as_str(),
    // rust: s.chunk,
    // rust: s.bounding_box.min,
    // rust: s.bounding_box.max,
    // rust: )
    // rust: })
    // rust: .collect()
}
pub fn is_decorated(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.decorated
}
    /// The structure starts this chunk holds itself (`structures.starts`).
pub fn own_starts(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.own_starts.to_vec()
}
    /// Also restores a saved proto chunk that was decorated before it was saved.
pub fn set_decorated(self: *Self) void {
}
    // rust: self.decorated = true;
}
    /// Highest non-air block + 1 in the column (WORLD_SURFACE).
pub fn surface_height(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.terrain
    // rust: .heightmap(HeightmapType::WorldSurface)
    // rust: .and_then(|map| map.first_available(x & 15, z & 15).ok())
    // rust: .unwrap_or(self.terrain.min_y())
}
}

/// Per-noise-settings values resolved from the dimension's generator JSON.
pub const Settings = struct {
    noise_min_y: i32,
    noise_height: i32,
    /// The dimension type's build range (LevelHeightAccessor): proto chunks,
    /// their heightmaps and the decoration region span it, while the noise
    /// only fills `noise_min_y..noise_min_y + noise_height`.
    level_min_y: i32,
    level_height: i32,
    sea_level: i32,
    default_block: BlockStateId,
    default_fluid: BlockStateId,
    legacy: bool,
};

/// The seed-bound pipeline for one random-source kind.
pub const Pipeline = struct {
    data: *GeneratorData,
    seed: i64,
    settings: Settings,
    root: R::Positional,
    router: RouterSamplers,
    climate: ClimateSampler,
    aquifer: ?[Arc<dyn DensitySampler,
    rule: MaterialRule,
    preliminary: *dyn DensitySampler,
    source: ResolvedBiomeSource,
    surface: MaterialSurface<R::Positional>,
    noises: BTreeMap<[]const u8,
    extensions: MaterialExtensions<R::Positional>,
    picker: GlobalFluidPicker,
    zoom: BiomeZoom,
    biome_cache: BiomeCache,
    biome_work: ChunkWork,
    carver_cache: Mutex<HashMap<(i32,
    // rust: pub(super) decoration: Option<Arc<super::generator_decoration::Decoration>>,
    // rust: pub(super) structures: Option<super::generator_structures::StructureState>,
    /// Definitions for explicit placement when automatic structure starts are off.
    manual_structures: std::sync::OnceLock<?super::generator_structures::StructureState>,
    /// The noise settings' `spawn_target` points.
    spawn_target: std.ArrayList(SpawnTargetPoint),
    /// The chunks an older version generated, which new chunks blend with.
    old_world: std::sync::OnceLock<*dyn super::blending::OldWorld>,
    /// The noise settings' `debug_functions`: label and sampler.
    debug_density: Vec<([]const u8,
    spawn_position: std::sync::OnceLock<[i32,
    /// A superflat world: its layers stand where the noise terrain would.
    flat: ?FlatLayers,
};
/// `FlatLevelGeneratorSettings.getLayers` as `FlatLevelSource` reads them: the states from the
/// level's minimum Y up, with the layers `adjustGenerationSettings` replaced by `null`
/// (not opaque to `MOTION_BLOCKING`: a feature fills them later) marked.
pub const FlatLayers = struct {
    min_y: i32,
    states: std.ArrayList(BlockStateId),
    /// `layers.get(i) == null`: `getBaseHeight` skips it, `getBaseColumn` reads it as air, and
    /// `buildTerrain` leaves it for the `FillLayerFeature` that runs after the structures.
    null: std.ArrayList(bool),
};
/// A superflat world's generator settings (`FlatLevelGeneratorSettings`).
pub const FlatSettings = struct {
    /// The layers, bottom up: block id and height.
    layers: Vec<([]const u8,
    /// The biome the whole world is.
    biome: []const u8,
    /// `structure_overrides`: the structure sets that may generate (all of them when `None`).
    structure_overrides: ?std.ArrayList([]const u8),
    /// `features`: the biome's own placed features decorate the world.
    features: bool,
    /// `lakes`: the lava lakes (`createLakesList`) take the biome's lakes step.
    lakes: bool,
};
pub const CACHE_LIMIT: usize = 16384;
/// What a generator's shared caches hold ([`OverworldGenerator::cache_census`]).
pub const CacheCensus = struct {
    /// Chunks in the biome cache, and their bytes.
    biome_chunks: usize,
    biome_bytes: usize,
    /// Carver origins whose biome is cached.
    carver_entries: usize,
    /// Chunks in the structure start cache, and how many of them hold starts.
    start_chunks: usize,
    start_lists: usize,
};
/// Coordinates only equal missing neighbour keys. Weak entries retain no
/// computed values across eviction or explicit invalidation. Only one work
/// lock may be held at a time; finish shared prerequisites before acquiring it.
/// Sharded by key: every worker asks for the locks of the same neighbourhoods.
    // rust: pub(super) struct ChunkWork(Box<[Mutex<HashMap<(i32, i32), std::sync::Weak<Mutex<()>>>>]>);
pub const WORK_SHARDS: usize = 64;
/// The shard of `key` among `shards` (a power of two).
    // rust: pub(super) fn shard_of(key: (i32, i32), shards: usize) -> usize {
    // rust: let hash = (key.0 as u32).wrapping_mul(0x9E37_79B9) ^ (key.1 as u32).wrapping_mul(0x85EB_CA6B);
    // rust: (hash >> (32 - shards.trailing_zeros())) as usize
}
    // rust: impl ChunkWork {
    // rust: pub(super) fn new() -> Self {
    // rust: Self((0..WORK_SHARDS).map(|_| Mutex::default()).collect())
}
    // rust: pub(super) fn at(&self, key: (i32, i32)) -> Arc<Mutex<()>> {
    // rust: let mut work = self.0[shard_of(key, WORK_SHARDS)].lock().unwrap();
    // rust: if let Some(lock) = work.get(&key).and_then(std::sync::Weak::upgrade) {
    // rust: return lock;
}
    // rust: if work.len() >= 4096 / WORK_SHARDS {
            // Keep every active builder/waiter on its original lock, including
            // when the result cache was cleared while it was in flight.
    // rust: work.retain(|_, lock| lock.strong_count() > 0);
}
    // rust: let lock = Arc::new(Mutex::new(()));
    // rust: work.insert(key, Arc::downgrade(&lock));
    // rust: lock
}
}

    // rust: type BiomeCache = Mutex<HashMap<(i32, i32), Arc<BiomeChunk<BiomeId>>>>;

/// `NoiseGeneratorSettings`' `default_block` and `default_fluid`: a block state
/// in 26.3's form, the id alone or `{"id", "properties"}`.
    // rust: fn state(
    // rust: codec: &crate::registry::BlockStateJsonCodec<'_>,
    // rust: raw: &Value,
    // rust: ) -> Result<BlockStateId, GeneratorError> {
    // rust: codec
    // rust: .decode(&raw.to_string(), false)
    // rust: .map_err(|e| resource(format!("block state {raw}: {e}")))
}

    // rust: impl<R: RandomSource + 'static> Pipeline<R>
    // rust: where
    // rust: R::Positional: Clone + Send + Sync,
    // rust: {
    // rust: fn new(
    // rust: data: Arc<GeneratorData>,
    // rust: seed: i64,
    // rust: mut random: R,
    // rust: generator: &Value,
    // rust: settings_json: &Value,
    // rust: with_structures: bool,
    // rust: level: Option<(i32, i32)>,
    // rust: ) -> Result<Self, GeneratorError> {
    // rust: let registry = data.registry;
    // rust: let noise = &settings_json["noise"];
    // rust: let min_y = noise["min_y"]
    // rust: .as_i64()
    // rust: .ok_or_else(|| resource("noise min_y"))? as i32;
    // rust: let height = noise["height"]
    // rust: .as_i64()
    // rust: .ok_or_else(|| resource("noise height"))? as i32;
    // rust: let (level_min_y, level_height) = level.unwrap_or((min_y, height));
    // rust: if min_y < level_min_y || min_y + height > level_min_y + level_height {
    // rust: return Err(resource("noise range outside the dimension's build height"));
}
    // rust: let codec = crate::registry::BlockStateJsonCodec::new(registry, data.integers.clone())
    // rust: .map_err(|e| resource(e.to_string()))?;
    // rust: let settings = Settings {
    // rust: noise_min_y: min_y,
    // rust: noise_height: height,
    // rust: level_min_y,
    // rust: level_height,
    // rust: sea_level: settings_json["sea_level"]
    // rust: .as_i64()
    // rust: .ok_or_else(|| resource("sea_level"))? as i32,
    // rust: default_block: state(&codec, &settings_json["default_block"])?,
    // rust: default_fluid: state(&codec, &settings_json["default_fluid"])?,
    // rust: legacy: settings_json["legacy_random_source"]
    // rust: .as_bool()
    // rust: .unwrap_or(false),
}
    // rust: let root = random.fork_positional();
    // rust: let mut densities = DensityRegistry::from_json(&data.noises, &data.densities)?;
    // rust: let router =
    // rust: NoiseRouter::from_json(&settings_json["noise_router"].to_string(), &mut densities)?;
        // NoiseGeneratorSettings.debugFunctions: a registered density or an
        // inline one, each with its label.
    // rust: let debug_functions = settings_json
    // rust: .get("debug_functions")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|entry| {
    // rust: let label = entry["label"]
    // rust: .as_str()
    // rust: .ok_or_else(|| resource("debug label"))?;
    // rust: let id = match &entry["function"] {
    // rust: Value::String(name) => densities
    // rust: .reference(name)
    // rust: .ok_or_else(|| resource(format!("debug function {name}")))?,
    // rust: inline => densities.decode_functions(&[&inline.to_string()])?[0],
}
    // rust: Ok((label.to_owned(), id))
    // rust: })
    // rust: .collect::<Result<Vec<_>, GeneratorError>>()?;
    // rust: let aquifers = settings_json
    // rust: .get("aquifers")
    // rust: .filter(|v| !v.is_null())
    // rust: .map(|v| AquiferConfig::from_json(&v.to_string(), &mut densities))
    // rust: .transpose()?;
    // rust: let mut library = MaterialRuleLibrary::from_json(
    // rust: &data.rules,
    // rust: &data.conditions,
    // rust: &codec,
    // rust: densities,
    // rust: seed,
    // rust: settings.legacy,
    // rust: )?;
    // rust: let router = library.compile_router(router)?;
    // rust: let debug_density = debug_functions
    // rust: .into_iter()
    // rust: .map(|(label, id)| Ok((label, library.function_sampler(id)?)))
    // rust: .collect::<Result<Vec<_>, GeneratorError>>()?;
    // rust: let aquifer = aquifers
    // rust: .map(|config| library.compile_aquifer(config))
    // rust: .transpose()?
    // rust: .map(|samplers| AquiferField::ALL.map(|field| samplers.get(field).clone()));
    // rust: let rule_name = settings_json["material_rule"]
    // rust: .as_str()
    // rust: .ok_or_else(|| resource("material_rule"))?;
    // rust: let rule = library.rule(rule_name)?;
    // rust: let preliminary = router.get(RouterField::ChunkSurfaceLevel).clone();
    // rust: let spawn_target = match settings_json.get("spawn_target") {
    // rust: Some(Value::Array(points)) => points
    // rust: .iter()
    // rust: .map(|point| {
    // rust: let Value::Object(fields) = point else {
    // rust: return Err(resource("spawn_target point"));
}
    // rust: let parameters = fields
    // rust: .iter()
    // rust: .map(|(name, interval)| {
    // rust: Ok((
    // rust: library.named_density(name)?,
    // rust: decode_parameter(&interval.to_string())?,
    // rust: ))
    // rust: })
    // rust: .collect::<Result<_, GeneratorError>>()?;
    // rust: Ok(SpawnTargetPoint { parameters })
    // rust: })
    // rust: .collect::<Result<_, GeneratorError>>()?,
    // rust: _ => Vec::new(),
}
    // rust: let source_json = generator["biome_source"].to_string();
    // rust: let source = data
    // rust: .source_catalog
    // rust: .decode(&source_json)?
    // rust: .resolve(&data.presets)
    // rust: .map_err(|e| resource(format!("biome source: {e}")))?;
    // rust: let climate = router.climate_sampler();
    // rust: let mut noises = BTreeMap::new();
    // rust: for (name, json) in &data.noises {
    // rust: let noise: Arc<dyn Noise> = Arc::new(
    // rust: decode_noise(json)?
    // rust: .create(&mut root.from_hash_of(name))
    // rust: .map_err(DecodeError::from)?,
    // rust: );
    // rust: noises.insert(name.clone(), noise);
}
    // rust: let noise = |name: &str| -> Result<Arc<dyn Noise>, GeneratorError> {
    // rust: noises
    // rust: .get(name)
    // rust: .cloned()
    // rust: .ok_or_else(|| resource(format!("missing noise {name}")))
}
    // rust: let surface = MaterialSurface::new(
    // rust: root.clone(),
    // rust: ClayBandBlocks::from_registry(registry).ok_or_else(|| resource("clay bands"))?,
    // rust: noise("minecraft:clay_bands_offset")?,
    // rust: noise("minecraft:surface")?,
    // rust: noise("minecraft:surface_secondary")?,
    // rust: );
    // rust: let default = |name: &str| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| resource(format!("missing block {name}")))
}
    // rust: let extensions = MaterialExtensions::new(
    // rust: root.clone(),
    // rust: ExtensionBlocks {
    // rust: default: settings.default_block,
    // rust: water: default("minecraft:water")?,
    // rust: packed_ice: default("minecraft:packed_ice")?,
    // rust: snow: default("minecraft:snow_block")?,
    // rust: },
    // rust: ExtensionNoises {
    // rust: badlands_surface: noise("minecraft:badlands_surface")?,
    // rust: badlands_pillar: noise("minecraft:badlands_pillar")?,
    // rust: badlands_roof: noise("minecraft:badlands_pillar_roof")?,
    // rust: iceberg_surface: noise("minecraft:iceberg_surface")?,
    // rust: iceberg_pillar: noise("minecraft:iceberg_pillar")?,
    // rust: iceberg_roof: noise("minecraft:iceberg_pillar_roof")?,
    // rust: },
    // rust: settings.sea_level,
    // rust: );
    // rust: let picker = GlobalFluidPicker::new(
    // rust: settings.sea_level,
    // rust: settings.default_fluid,
    // rust: default("minecraft:lava")?,
    // rust: default("minecraft:air")?,
    // rust: );
    // rust: let mut pipeline = Self {
    // rust: zoom: BiomeZoom::new(obfuscate_seed(seed)),
    // rust: data,
    // rust: seed,
    // rust: settings,
    // rust: root,
    // rust: router,
    // rust: climate,
    // rust: aquifer,
    // rust: rule,
    // rust: preliminary,
    // rust: source,
    // rust: surface,
    // rust: noises,
    // rust: extensions,
    // rust: picker,
    // rust: biome_cache: Mutex::new(HashMap::new()),
    // rust: biome_work: ChunkWork::new(),
    // rust: carver_cache: Mutex::new(HashMap::new()),
    // rust: decoration: None,
    // rust: structures: None,
    // rust: manual_structures: std::sync::OnceLock::new(),
    // rust: spawn_target,
    // rust: old_world: std::sync::OnceLock::new(),
    // rust: debug_density,
    // rust: spawn_position: std::sync::OnceLock::new(),
    // rust: flat: None,
}
    // rust: pipeline.decoration = pipeline
    // rust: .data
    // rust: .decoration_for(&source_json, &pipeline.source)?;
    // rust: if with_structures {
    // rust: let possible = pipeline
    // rust: .source
    // rust: .possible_biomes()
    // rust: .into_iter()
    // rust: .filter_map(|name| pipeline.data.biome_id(name))
    // rust: .collect();
    // rust: let rings = pipeline.data.rings_for(seed, generator);
    // rust: pipeline.structures =
    // rust: super::generator_structures::StructureState::new(&pipeline.data, &possible, rings)?;
    // rust: if let Some(state) = pipeline.structures.as_mut() {
    // rust: state.fixed_biome = generator["biome_source"]["type"] == "minecraft:fixed";
}
            // ChunkGenerator.createState reads getOrigin: a noise generator
            // answers the chunk of its NoiseSpawnFinder position, others
            // chunk 0 0. Only a dimension-origin structure set reads it.
    // rust: if pipeline
    // rust: .structures
    // rust: .as_ref()
    // rust: .is_some_and(|state| state.needs_dimension_origin())
    // rust: && let Ok([x, z]) = pipeline.spawn_column()
    // rust: {
    // rust: let origin = ChunkPos::new(x >> 4, z >> 4);
    // rust: if let Some(state) = pipeline.structures.as_mut() {
    // rust: state.set_dimension_origin(origin);
}
}
}
    // rust: Ok(pipeline)
}
    /// `NoiseBasedChunkGenerator.getOrigin`'s spawn column: the
    /// NoiseSpawnFinder position, or 0 0 when the noise settings have no
    /// spawn target (`ChunkGenerator.getOrigin`). Cached.
pub fn spawn_column(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(position) = self.spawn_position.get() {
    // rust: return Ok(*position);
}
        // ChunkGenerator.getOrigin is 0 0 without a spawn target.
    // rust: let position = if self.spawn_target.is_empty() {
    // rust: [0, 0]
    // rust: } else {
    // rust: find_spawn_position(&self.spawn_target, &mut SamplerContext::cached())
    // rust: .map_err(|e| GeneratorError::Stage("spawn search", e.to_string()))?
}
    // rust: Ok(*self.spawn_position.get_or_init(|| position))
}
    /// Manual placement reads the registry without enabling the automatic
    /// structure state, its placement sets, starts or locate searches.
pub fn placement_structures(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.structures.as_ref().or_else(|| {
    // rust: self.manual_structures
    // rust: .get_or_init(|| {
    // rust: super::generator_structures::StructureState::new(
    // rust: &self.data,
    // rust: &BTreeSet::new(),
    // rust: Arc::new(std::sync::OnceLock::new()),
    // rust: )
    // rust: .ok()
    // rust: .flatten()
    // rust: })
    // rust: .as_ref()
    // rust: })
}
pub fn generation(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
        // `new WorldGenerationContext(generator, level)`: the larger minimum Y and the smaller
        // height of the generator and the level (`FlatLevelSource`: 0 and 384).
    // rust: if self.flat.is_some() {
    // rust: return WorldGenerationContext::new(
    // rust: self.settings.level_min_y.max(0),
    // rust: self.settings.level_height.min(384),
    // rust: self.settings.sea_level,
    // rust: );
}
    // rust: WorldGenerationContext::new(
    // rust: self.settings.noise_min_y,
    // rust: self.settings.noise_height,
    // rust: self.settings.sea_level,
    // rust: )
}
    /// `Blender.of(region)` for the chunk at `pos`.
pub fn blender_at(self: *Self, pos: ChunkPos) A {
    // Implementation ported from Horizon
    return undefined;
}
        // `SharedConstants.DEBUG_DISABLE_BLENDING`.
pub const DISABLED: OnceLock<bool> = OnceLock::new();
    // rust: if *DISABLED.get_or_init(|| std::env::var_os("HORIZON_DISABLE_BLENDING").is_some()) {
    // rust: return Arc::new(super::blending::Blender::empty());
}
    // rust: Arc::new(match self.old_world.get() {
    // rust: Some(world) => super::blending::Blender::of(world.as_ref(), pos),
    // rust: None => super::blending::Blender::empty(),
    // rust: })
}
    // rust: fn biome_chunk(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: pos: ChunkPos,
    // rust: ) -> Result<Arc<BiomeChunk<BiomeId>>, GeneratorError> {
    // rust: self.biome_chunk_or_busy(worker, pos, true)
    // rust: .map(|chunk| chunk.expect("waited for the builder"))
}
    /// The chunk's biomes, built here if no other thread is building them.
    /// With `wait` false, None when another thread is building them now.
    // rust: fn biome_chunk_or_busy(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: pos: ChunkPos,
    // rust: wait: bool,
    // rust: ) -> Result<Option<Arc<BiomeChunk<BiomeId>>>, GeneratorError> {
    // rust: if let Some(chunk) = self.biome_cache.lock().unwrap().get(&(pos.x, pos.z)) {
    // rust: return Ok(Some(chunk.clone()));
}
        // An old chunk keeps the biomes it was saved with.
    // rust: if let Some(old) = self
    // rust: .old_world
    // rust: .get()
    // rust: .and_then(|world| world.old_biomes(pos.x, pos.z))
    // rust: {
    // rust: return Ok(Some(old));
}
    // rust: let work = self.biome_work.at((pos.x, pos.z));
    // rust: let _work = if wait {
    // rust: work.lock().unwrap()
    // rust: } else {
    // rust: match work.try_lock() {
    // rust: Ok(guard) => guard,
    // rust: Err(std::sync::TryLockError::WouldBlock) => return Ok(None),
    // rust: Err(std::sync::TryLockError::Poisoned(error)) => panic!("{error}"),
}
}
    // rust: if let Some(chunk) = self.biome_cache.lock().unwrap().get(&(pos.x, pos.z)) {
    // rust: return Ok(Some(chunk.clone()));
}
    // rust: let (min, height) = (self.settings.level_min_y, self.settings.level_height);
    // rust: let mut chunk = BiomeChunk::new(pos, min, height, BiomeId(0)).map_err(stage("biomes"))?;
    // rust: let mut resolver = self.source.resolver(
    // rust: &self.climate,
    // rust: self.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: let context = &mut worker.biome_context;
    // rust: let volume = resolver
    // rust: .prepare_volume(
    // rust: context,
    // rust: [
    // rust: pos.x.wrapping_shl(4) >> 2,
    // rust: min >> 2,
    // rust: pos.z.wrapping_shl(4) >> 2,
    // rust: ],
    // rust: [4, height >> 2, 4],
    // rust: )
    // rust: .map_err(stage("biomes"))?;
    // rust: let ids = &self.data.biome_ids;
    // rust: let blender = self.blender_at(pos);
        // Names point into the source's parameter list: neighbouring quarts
        // mostly resolve to the same entry, so skip the map lookup for it.
    // rust: let mut last: Option<(*const str, BiomeId)> = None;
    // rust: chunk
    // rust: .fill(min, min + height - 1, |quart| -> Result<BiomeId, String> {
                // `Blender.getBiomeResolver`: an old chunk's biome near it.
    // rust: if !blender.is_empty()
    // rust: && let Some(old) = blender.blend_biome(quart[0], quart[1], quart[2])
    // rust: {
    // rust: return Ok(old);
}
    // rust: let name = resolver
    // rust: .sample_prepared(context, volume.as_ref(), quart)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if let Some((pointer, id)) = last {
    // rust: if std::ptr::eq(pointer, name) {
    // rust: return Ok(id);
}
}
    // rust: let id = ids.get(name).copied().ok_or_else(|| name.to_owned())?;
    // rust: last = Some((name as *const str, id));
    // rust: Ok(id)
    // rust: })
    // rust: .map_err(stage("biomes"))?;
    // rust: let chunk = Arc::new(chunk);
    // rust: let mut cache = self.biome_cache.lock().unwrap();
    // rust: if cache.len() >= CACHE_LIMIT {
    // rust: cache.clear();
}
    // rust: cache.insert((pos.x, pos.z), chunk.clone());
    // rust: Ok(Some(chunk))
}
pub fn carver_biome(self: *Self, worker: *mut WorkerState, origin: ChunkPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (origin.x, origin.z);
    // rust: if let Some(id) = worker.carver_biomes.get(&key) {
    // rust: return Ok(*id);
}
    // rust: if worker.carver_biomes.len() >= 4096 {
    // rust: worker.carver_biomes.clear();
}
    // rust: if let Some(id) = self.carver_cache.lock().unwrap().get(&key) {
    // rust: worker.carver_biomes.insert(key, *id);
    // rust: return Ok(*id);
}
    // rust: let mut resolver = self.source.resolver(
    // rust: &self.climate,
    // rust: self.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: let quart = [
    // rust: origin.x.wrapping_shl(4) >> 2,
    // rust: 0,
    // rust: origin.z.wrapping_shl(4) >> 2,
    // rust: ];
    // rust: let name = resolver
    // rust: .sample(&mut worker.carver_context, quart)
    // rust: .map_err(|e| e.to_string())?;
    // rust: let id = self.data.biome_id(name).ok_or_else(|| name.to_owned())?;
    // rust: let mut cache = self.carver_cache.lock().unwrap();
    // rust: if cache.len() >= CACHE_LIMIT * 4 {
    // rust: cache.clear();
}
    // rust: cache.insert(key, id);
    // rust: worker.carver_biomes.insert(key, id);
    // rust: Ok(id)
}
    // rust: fn generate(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: pos: ChunkPos,
    // rust: ) -> Result<ProtoChunk, GeneratorError> {
    // rust: let mut context = std::mem::take(&mut worker.terrain_context);
    // rust: let result = self.generate_with_context(worker, pos, &mut context);
        // Release chunk-specific bindings and caches even after a sampling error.
    // rust: context.reset();
    // rust: worker.terrain_context = context;
    // rust: result
}
    /// With the native End source there are no badlands/iceberg extensions.
    /// Disabled aquifers with air as their default fluid can only add lava or
    /// air to the default solid, so this constant rule would rewrite each solid
    /// with the state it already has. Check their imported material flags too.
    /// Noise filling already built the WG maps; these writes add no fluid marks.
pub fn identity_end_surface(self: *Self, pos: ChunkPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !matches!(self.source, ResolvedBiomeSource::End(_))
            // At wrapped block coordinates the ordinary biome-region lookup
            // can fail; retain that lookup and its error outside this range.
    // rust: || ![pos.x, pos.z].into_iter().all(|c| {
    // rust: c.checked_mul(16).is_some_and(|b| {
    // rust: b.checked_sub(16).is_some() && b.checked_add(31).is_some()
    // rust: })
    // rust: })
    // rust: || self.aquifer.is_some()
    // rust: || Some(self.settings.default_block)
    // rust: != self.data.registry.default_state("minecraft:end_stone")
    // rust: || Some(self.settings.default_fluid)
    // rust: != self.data.registry.default_state("minecraft:air")
    // rust: || !self.data.states.get(self.settings.default_fluid).air
    // rust: || !self
    // rust: .data
    // rust: .registry
    // rust: .default_state("minecraft:lava")
    // rust: .is_some_and(|lava| self.data.states.get(lava).fluid)
    // rust: {
    // rust: return false;
}
    // rust: let mut rule = &self.rule;
        // Restrict the shortcut to shallow block references; other rules still
        // run their normal compilation, queries and error handling.
    // rust: for _ in 0..32 {
    // rust: match rule {
    // rust: MaterialRule::Reference(next) => rule = next,
    // rust: MaterialRule::Block(state) => return *state == self.settings.default_block,
    // rust: _ => return false,
}
}
    // rust: false
}
    // rust: fn generate_with_context(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: pos: ChunkPos,
    // rust: context: &mut SamplerContext,
    // rust: ) -> Result<ProtoChunk, GeneratorError> {
    // rust: let data = &self.data;
    // rust: let (min, height, sea) = (
    // rust: self.settings.noise_min_y,
    // rust: self.settings.noise_height,
    // rust: self.settings.sea_level,
    // rust: );
    // rust: let mut clock = std::time::Instant::now();
    // rust: let mut neighbors = Vec::with_capacity(9);
        // The biome ids present, as a bitset: ascending like a sorted set.
    // rust: let mut seen: Vec<u64> = Vec::new();
        // Build the neighbours no other thread is building first, then wait
        // for the rest (each is built once, by whichever thread gets it).
    // rust: let around =
    // rust: |i: i32| ChunkPos::new(pos.x.wrapping_add(i % 3 - 1), pos.z.wrapping_add(i / 3 - 1));
    // rust: let mut ready: [Option<Arc<BiomeChunk<BiomeId>>>; 9] = Default::default();
    // rust: for (i, slot) in ready.iter_mut().enumerate() {
    // rust: *slot = self.biome_chunk_or_busy(worker, around(i as i32), false)?;
}
    // rust: for (i, slot) in ready.iter_mut().enumerate() {
    // rust: let chunk = match slot.take() {
    // rust: Some(chunk) => chunk,
    // rust: None => self.biome_chunk(worker, around(i as i32))?,
}
    // rust: {
    // rust: let mut section = 0;
    // rust: let mut last = None;
    // rust: while let Some(biomes) = chunk.section(section) {
    // rust: for &id in biomes {
    // rust: if last == Some(id) {
    // rust: continue;
}
    // rust: last = Some(id);
    // rust: let word = id.0 as usize / 64;
    // rust: if seen.len() <= word {
    // rust: seen.resize(word + 1, 0);
}
    // rust: seen[word] |= 1 << (id.0 % 64);
}
    // rust: section += 1;
}
    // rust: neighbors.push((*chunk).clone());
}
}
    // rust: let possible = seen.iter().enumerate().flat_map(|(word, &bits)| {
    // rust: let mut bits = bits;
    // rust: std::iter::from_fn(move || {
    // rust: (bits != 0).then(|| {
    // rust: let bit = bits.trailing_zeros();
    // rust: bits &= bits - 1;
    // rust: BiomeId(word as u32 * 64 + bit)
    // rust: })
    // rust: })
    // rust: });
    // rust: let center = neighbors[4].clone();
    // rust: let biomes =
    // rust: BiomeRegion::new(neighbors, obfuscate_seed(self.seed)).map_err(stage("biomes"))?;
    // rust: let possible = possible.map(|id| data.biome_name(id).to_owned()).collect();
    // rust: worker.timings.biomes += lap(&mut clock);
    // rust: let mut chunk = TerrainChunk::new(
    // rust: pos,
    // rust: self.settings.level_min_y,
    // rust: self.settings.level_height,
    // rust: data.registry,
    // rust: data.states.clone(),
    // rust: )
    // rust: .map_err(stage("noise"))?;
    // rust: chunk.set_generation_stage(PreLightChunkStage::Biomes);
    // rust: let (references, own_starts) = match &self.structures {
    // rust: Some(structures) => {
    // rust: let mut queries = StructureQueries {
    // rust: pipeline: self,
    // rust: worker,
    // rust: valid: BTreeSet::new(),
}
    // rust: (
    // rust: structures.references(&mut queries, pos),
    // rust: structures.starts_at(&mut queries, pos),
    // rust: )
}
    // rust: None => (Vec::new(), Starts::default()),
}
        // `FlatLevelSource.buildTerrain`: the layers, and nothing else (no noise, surface or carvers).
    // rust: if let Some(flat) = &self.flat {
    // rust: for (i, &state) in flat.states.iter().enumerate() {
    // rust: let y = flat.min_y + i as i32;
    // rust: if y >= self.settings.level_min_y + self.settings.level_height {
    // rust: break;
}
    // rust: if flat.null[i] || data.states.get(state).is_air() {
    // rust: continue;
}
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: chunk
    // rust: .set_block_raw(
    // rust: pos.x.wrapping_shl(4) + x,
    // rust: y,
    // rust: pos.z.wrapping_shl(4) + z,
    // rust: state,
    // rust: )
    // rust: .map_err(stage("flat"))?;
}
}
}
    // rust: chunk
    // rust: .prime_heightmaps(&[
    // rust: HeightmapType::WorldSurfaceWg,
    // rust: HeightmapType::OceanFloorWg,
    // rust: HeightmapType::MotionBlocking,
    // rust: HeightmapType::MotionBlockingNoLeaves,
    // rust: HeightmapType::OceanFloor,
    // rust: HeightmapType::WorldSurface,
    // rust: ])
    // rust: .map_err(stage("heightmaps"))?;
    // rust: chunk.set_generation_stage(PreLightChunkStage::Terrain);
    // rust: return Ok(ProtoChunk {
    // rust: terrain: chunk,
    // rust: biomes: center,
    // rust: data: data.clone(),
    // rust: decorated: false,
    // rust: block_entities: Vec::new(),
    // rust: structure_starts: references,
    // rust: own_starts,
    // rust: entities: Vec::new(),
    // rust: });
}
    // rust: let volume = DensityVolume::new(
    // rust: [16, height, 16],
    // rust: [pos.x.wrapping_shl(4), min, pos.z.wrapping_shl(4)],
    // rust: [1; 3],
    // rust: )
    // rust: .map_err(stage("noise"))?;
    // rust: let blender = self.blender_at(pos);
    // rust: let beard = self
    // rust: .structures
    // rust: .as_ref()
    // rust: .and_then(|s| s.beardifier(&references, pos));
    // rust: if beard.is_some() || !blender.is_empty() {
    // rust: let mut fields = horizon_core::density::WorldFields::default();
    // rust: if let Some(beard) = beard {
    // rust: fields = fields.with_field(
    // rust: horizon_core::density::WorldField::Beardifier,
    // rust: Arc::new(beard),
    // rust: );
}
    // rust: if !blender.is_empty() {
    // rust: let buffer = Arc::new(blender.output_buffer(volume));
    // rust: for (field, offset) in [
    // rust: (horizon_core::density::WorldField::BlendAlpha, false),
    // rust: (horizon_core::density::WorldField::BlendOffset, true),
    // rust: ] {
    // rust: fields = fields.with_field(
    // rust: field,
    // rust: Arc::new(super::blending::BlendFieldSampler {
    // rust: buffer: buffer.clone(),
    // rust: offset,
    // rust: }),
    // rust: );
}
    // rust: fields = fields.with_blender(blender.clone());
}
    // rust: *context = std::mem::take(context).with_world_fields(fields);
}
    // rust: worker.timings.structures += lap(&mut clock);
    // rust: worker.timings.noise += lap(&mut clock);
    // rust: let mut aquifer: Box<dyn TerrainAquifer> = match &self.aquifer {
    // rust: Some(samplers) => Box::new(
    // rust: NoiseBasedAquifer::new(
    // rust: AquiferSamplers::new(samplers.clone()),
    // rust: self.picker,
    // rust: self.root
    // rust: .from_hash_of("minecraft:aquifer")
    // rust: .fork_positional(),
    // rust: RegistryAquiferBlockStates::new(data.registry).map_err(stage("aquifer"))?,
    // rust: volume,
    // rust: context,
    // rust: )
    // rust: .map_err(stage("aquifer"))?,
    // rust: ),
    // rust: None => Box::new(DisabledAquifer::new(
    // rust: self.picker,
    // rust: data.registry.default_state("minecraft:air").unwrap(),
    // rust: )),
}
    // rust: worker.timings.noise += lap(&mut clock);
    // rust: fill_noise(
    // rust: &mut chunk,
    // rust: volume,
    // rust: self.router.get(RouterField::FinalDensity).as_ref(),
    // rust: context,
    // rust: aquifer.as_mut(),
    // rust: self.settings.default_block,
    // rust: )
    // rust: .map_err(stage("noise"))?;
    // rust: let generation = self.generation();
    // rust: worker.timings.noise += lap(&mut clock);
        // The surface rule, compiled by this worker's first chunk.
    // rust: let mut shared = worker
    // rust: .surface_rule
    // rust: .take()
    // rust: .and_then(|cache| cache.downcast::<CompiledSurfaceRule<R>>().ok())
    // rust: .map(|cache| *cache);
    // rust: if !self.identity_end_surface(pos) {
    // rust: build_surface_shared(
    // rust: &mut chunk,
    // rust: &self.rule,
    // rust: &mut shared,
    // rust: SurfaceInputs::<R, _> {
    // rust: generation,
    // rust: noise_volume: volume,
    // rust: root: self.root.clone(),
    // rust: surface: SurfaceQueries {
    // rust: pipeline: self,
    // rust: temperatures: &mut worker.temperatures,
    // rust: biome: Biomes::Region(&biomes),
    // rust: uniform_biomes: Some(UniformSurfaceBiomes::new(
    // rust: pos,
    // rust: self.settings.level_min_y,
    // rust: self.settings.level_height,
    // rust: )),
    // rust: possible: Some(possible),
    // rust: },
    // rust: preliminary_surface: self.preliminary.clone(),
    // rust: density_context: context,
    // rust: write_min_y: min,
    // rust: write_max_y: min + height - 1,
    // rust: },
    // rust: &self.extensions,
    // rust: )
    // rust: .map_err(stage("surface"))?;
}
    // rust: worker.timings.surface += lap(&mut clock);
    // rust: let carvers = &data.biome_carvers;
    // rust: let mask = generate_carving_mask(self.seed, pos, generation, false, |origin| {
    // rust: self.carver_biome(worker, origin)
    // rust: .map(|id| carvers[id.0 as usize].as_slice())
    // rust: })
    // rust: .map_err(stage("carvers"))?;
    // rust: worker.timings.carvers += lap(&mut clock);
    // rust: if !mask.is_empty() {
    // rust: let mut resolver = self.source.resolver(
    // rust: &self.climate,
    // rust: self.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: let mut biome_context = SamplerContext::default();
    // rust: apply_carving_mask_shared(
    // rust: &mut chunk,
    // rust: &mask,
    // rust: &self.rule,
    // rust: &mut shared,
    // rust: TopMaterialInputs::<R, _> {
    // rust: generation,
    // rust: root: self.root.clone(),
    // rust: surface: SurfaceQueries {
    // rust: pipeline: self,
    // rust: temperatures: &mut worker.temperatures,
    // rust: biome: Biomes::Resolver(&mut resolver, &mut biome_context),
    // rust: uniform_biomes: None,
    // rust: possible: None,
    // rust: },
    // rust: preliminary_surface: self.preliminary.clone(),
    // rust: density_context: context,
    // rust: },
    // rust: aquifer.as_mut(),
    // rust: &data.carving_blocks,
    // rust: |[x, y, z]| blender.carving_filter(x, y, z).unwrap_or(true),
    // rust: )
    // rust: .map_err(stage("carvers"))?;
}
    // rust: worker.surface_rule = shared.map(|rule| Box::new(rule) as Box<dyn Any + Send>);
    // rust: worker.timings.carvers += lap(&mut clock);
    // rust: chunk
    // rust: .prime_heightmaps(&[
    // rust: HeightmapType::MotionBlocking,
    // rust: HeightmapType::MotionBlockingNoLeaves,
    // rust: HeightmapType::OceanFloor,
    // rust: HeightmapType::WorldSurface,
    // rust: ])
    // rust: .map_err(stage("heightmaps"))?;
    // rust: chunk.set_generation_stage(PreLightChunkStage::Terrain);
    // rust: let _ = sea;
    // rust: Ok(ProtoChunk {
    // rust: terrain: chunk,
    // rust: biomes: center,
    // rust: data: data.clone(),
    // rust: decorated: false,
    // rust: block_entities: Vec::new(),
    // rust: structure_starts: references,
    // rust: own_starts,
    // rust: entities: Vec::new(),
    // rust: })
}
}

    // rust: impl<R: RandomSource> Pipeline<R>
    // rust: where
    // rust: R::Positional: Clone + Send + Sync,
    // rust: {
    /// WorldGenRegion's level random, positioned at the center chunk.
pub fn region_random_at(self: *Self, center: ChunkPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.root
    // rust: .from_hash_of("minecraft:worldgen_region_random")
    // rust: .fork_positional()
    // rust: .at(BlockPos::new(
    // rust: center.x.wrapping_shl(4),
    // rust: 0,
    // rust: center.z.wrapping_shl(4),
    // rust: ))
}
    /// The Y range `getBaseHeight` and `getBaseColumn` answer for: the noise's, or a superflat
    /// world's whole level (its layers are not bound by any noise settings).
pub fn column_range(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.flat.is_some() {
    // rust: (self.settings.level_min_y, self.settings.level_height)
    // rust: } else {
    // rust: (self.settings.noise_min_y, self.settings.noise_height)
}
}
    /// ChunkGenerator.getBaseHeight: the first free Y above the noise column
    /// (with aquifers, without terrain adaptation) for a heightmap type.
pub fn base_height(self: *Self, x: i32, z: i32, kind: HeightmapType) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (min, _) = self.column_range();
    // rust: let mut found = min;
    // rust: self.noise_column(x, z, &mut |y, state| {
    // rust: if kind.is_opaque(self.data.states.get(state)) {
    // rust: found = y + 1;
    // rust: return true;
}
    // rust: false
    // rust: });
    // rust: found
}
    /// ChunkGenerator.getBaseColumn: opacity of each noise-column state for
    /// a heightmap type, indexed from the minimum Y.
pub fn base_column(self: *Self, x: i32, z: i32, kind: HeightmapType) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.base_columns(x, z, &[kind]).pop().unwrap_or_default()
}
    /// One noise-column pass, as opacities for each heightmap kind.
pub fn base_columns(self: *Self, x: i32, z: i32, kinds: *[HeightmapType]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (min, height) = self.column_range();
    // rust: let mut columns = vec![vec![false; height as usize]; kinds.len()];
    // rust: self.noise_column(x, z, &mut |y, state| {
    // rust: let state = self.data.states.get(state);
    // rust: for (column, kind) in columns.iter_mut().zip(kinds) {
    // rust: column[(y - min) as usize] = kind.is_opaque(state);
}
    // rust: false
    // rust: });
    // rust: columns
}
    /// ChunkGenerator.getBaseColumn's blocks, by what structures test
    /// (BlockState.isSolid is blocksMotion for the noise's blocks, which
    /// are never cobwebs or bamboo saplings).
pub fn noise_blocks(self: *Self, x: i32, z: i32) s {
    // Implementation ported from Horizon
    return undefined;
}
//         use super::structure::start::{NoiseBlock, NoiseColumn};
    // rust: let (min, height) = self.column_range();
    // rust: let mut blocks = vec![NoiseBlock::Air; height as usize];
    // rust: let registry = self.data.registry;
    // rust: self.noise_column(x, z, &mut |y, state| {
    // rust: let props = self.data.states.get(state);
    // rust: blocks[(y - min) as usize] = if props.is_air() {
    // rust: NoiseBlock::Air
    // rust: } else {
    // rust: match registry.state(state).map(|s| s.name.as_str()) {
    // rust: Some("minecraft:water") => NoiseBlock::Water,
    // rust: Some("minecraft:lava") => NoiseBlock::Lava,
    // rust: _ if props.blocks_motion_in_heightmap() => NoiseBlock::Solid,
    // rust: _ => NoiseBlock::Other,
}
}
    // rust: false
    // rust: });
    // rust: NoiseColumn { min, blocks }
}
    /// iterateNoiseColumn from the top down until `visit` returns true.
pub fn noise_column(self: *Self, x: i32, z: i32, visit: *mut dyn FnMut(i32) b {
    // Implementation ported from Horizon
    return undefined;
}
        // `FlatLevelSource.getBaseHeight` and `getBaseColumn`: the layers, and air above them.
    // rust: if let Some(flat) = &self.flat {
    // rust: let air = self.data.registry.default_state("minecraft:air");
    // rust: let top = self.settings.level_min_y + self.settings.level_height;
    // rust: for y in (self.settings.level_min_y..top).rev() {
    // rust: let i = (y - flat.min_y) as usize;
    // rust: let state = match flat.states.get(i) {
    // rust: Some(&state) if !flat.null[i] => state,
    // rust: _ => match air {
    // rust: Some(air) => air,
    // rust: None => return,
    // rust: },
}
    // rust: if visit(y, state) {
    // rust: return;
}
}
    // rust: return;
}
    // rust: let (min, height) = (self.settings.noise_min_y, self.settings.noise_height);
    // rust: let Ok(volume) = DensityVolume::new([1, height, 1], [x, min, z], [1; 3]) else {
    // rust: return;
}
    // rust: let mut context = SamplerContext::cached();
    // rust: let mut aquifer: Box<dyn TerrainAquifer> = match &self.aquifer {
    // rust: Some(samplers) => match RegistryAquiferBlockStates::new(self.data.registry)
    // rust: .ok()
    // rust: .and_then(|blocks| {
    // rust: NoiseBasedAquifer::new(
    // rust: AquiferSamplers::new(samplers.clone()),
    // rust: self.picker,
    // rust: self.root
    // rust: .from_hash_of("minecraft:aquifer")
    // rust: .fork_positional(),
    // rust: blocks,
    // rust: volume,
    // rust: &mut context,
    // rust: )
    // rust: .ok()
    // rust: }) {
    // rust: Some(aquifer) => Box::new(aquifer),
    // rust: None => return,
    // rust: },
    // rust: None => Box::new(DisabledAquifer::new(
    // rust: self.picker,
    // rust: self.data.registry.default_state("minecraft:air").unwrap(),
    // rust: )),
}
    // rust: let mut density = vec![0.; height as usize];
    // rust: if self
    // rust: .router
    // rust: .get(RouterField::FinalDensity)
    // rust: .sample_volume(&mut context, &mut density, volume)
    // rust: .is_err()
    // rust: {
    // rust: return;
}
    // rust: for y in (0..height).rev() {
    // rust: let state = aquifer
    // rust: .compute_substance(
    // rust: &mut context,
    // rust: [x, min + y, z],
    // rust: f64::from(density[y as usize]),
    // rust: )
    // rust: .ok()
    // rust: .flatten()
    // rust: .unwrap_or(self.settings.default_block);
    // rust: if visit(min + y, state) {
    // rust: return;
}
}
}
}
/// Biome and height queries for structure generation on one worker.
    // rust: pub(super) struct StructureQueries<'a, R: RandomSource> {
    // rust: pipeline: &'a Pipeline<R>,
    // rust: worker: &'a mut WorkerState,
    // rust: valid: BTreeSet<BiomeId>,
}
    // rust: impl<R: RandomSource> super::structure::jigsaw::JigsawContext for StructureQueries<'_, R>
    // rust: where
    // rust: R::Positional: Clone + Send + Sync,
    // rust: {
    // Structure.GenerationContext.heightAccessor: the chunk, so the level's range.
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.settings.level_min_y
}
pub fn max_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.settings.level_min_y + self.pipeline.settings.level_height - 1
}
pub fn base_height(self: *Self, x: i32, z: i32, kind: HeightmapType) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(h) = self.worker.heights.get(&(x, z, kind as u8)) {
    // rust: return *h;
}
    // rust: let h = self.pipeline.base_height(x, z, kind);
    // rust: if self.worker.heights.len() > 65536 {
    // rust: self.worker.heights.clear();
}
    // rust: self.worker.heights.insert((x, z, kind as u8), h);
    // rust: h
}
    /// JigsawPlacement.couldStructureExistInColumn: one resolver for the
    /// column (createResolverForChunk, a bulk climate volume of 1 x n x 1
    /// quarts, as the biome stage samples a chunk), then each quart from the
    /// bottom. One volume costs about what a few single climate samples do;
    /// a column without a valid biome took one sample per quart (~500 in To
    /// The Max).
pub fn column_has_valid_biome(self: *Self, x: i32, z: i32, min_y: i32, max_y: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (qx, qz, qmin, qmax) = (x >> 2, z >> 2, min_y >> 2, max_y >> 2);
    // rust: if qmin > qmax {
    // rust: return false;
}
    // rust: let pipeline = self.pipeline;
    // rust: let mut resolver = pipeline.source.resolver(
    // rust: &pipeline.climate,
    // rust: pipeline.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: let context = &mut self.worker.biome_context;
    // rust: let volume = resolver
    // rust: .prepare_volume(context, [qx, qmin, qz], [1, qmax - qmin + 1, 1])
    // rust: .ok()
    // rust: .flatten();
    // rust: (qmin..=qmax).any(|qy| {
    // rust: let id = resolver
    // rust: .sample_prepared(context, volume.as_ref(), [qx, qy, qz])
    // rust: .ok()
    // rust: .and_then(|name| pipeline.data.biome_id(name))
    // rust: .unwrap_or(BiomeId(0));
    // rust: self.valid.contains(&id)
    // rust: })
}
}
    // rust: impl<R: RandomSource + 'static> super::structure::start::StartContext for StructureQueries<'_, R>
    // rust: where
    // rust: R::Positional: Clone + Send + Sync,
    // rust: {
pub fn is_old_chunk(self: *Self, chunk: ChunkPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline
    // rust: .old_world
    // rust: .get()
    // rust: .is_some_and(|world| world.is_old_chunk(chunk.x, chunk.z))
}
pub fn saved_starts(self: *Self, chunk: ChunkPos) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline
    // rust: .old_world
    // rust: .get()
    // rust: .map(|world| world.saved_starts(chunk.x, chunk.z))
    // rust: .unwrap_or_default()
}
pub fn seed(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.seed
}
pub fn sea_level(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.settings.sea_level
}
pub fn generator_min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.pipeline.flat.is_some() {
    // rust: 0
    // rust: } else {
    // rust: self.pipeline.settings.noise_min_y
}
}
pub fn base_column(self: *Self, x: i32, z: i32, kind: HeightmapType) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.base_column(x, z, kind)
}
pub fn base_columns(self: *Self, x: i32, z: i32, kinds: *[HeightmapType]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.base_columns(x, z, kinds)
}
pub fn noise_column(self: *Self, x: i32, z: i32) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.noise_blocks(x, z)
}
pub fn cold_enough_to_snow(self: *Self, biome: BiomeId, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sea = self.pipeline.settings.sea_level;
    // rust: self.worker.temperatures[biome.0 as usize]
    // rust: .cold_enough_to_snow(BlockPos::new(pos[0], pos[1], pos[2]), sea)
}
pub fn generation(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.generation()
}
pub fn noise_biome(self: *Self, quart: [i32; 3]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(&id) = self.worker.structure_biomes.get(&quart) {
    // rust: return id;
}
    // rust: let id = self.noise_biomes(&[quart])[0];
    // rust: if self.worker.structure_biomes.len() >= 1 << 16 {
    // rust: self.worker.structure_biomes.clear();
}
    // rust: self.worker.structure_biomes.insert(quart, id);
    // rust: id
}
pub fn noise_biomes(self: *Self, quarts: *[[i32; 3]]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut resolver = self.pipeline.source.resolver(
    // rust: &self.pipeline.climate,
    // rust: self.pipeline.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: quarts
    // rust: .iter()
    // rust: .map(|&quart| {
    // rust: resolver
    // rust: .sample(&mut self.worker.carver_context, quart)
    // rust: .ok()
    // rust: .and_then(|name| self.pipeline.data.biome_id(name))
    // rust: .unwrap_or(BiomeId(0))
    // rust: })
    // rust: .collect()
}
    /// `None` is `/place structure`'s `biome -> true`: every biome the bundle
    /// knows counts as valid.
pub fn set_valid_biomes(self: *Self, biomes: ?*BTreeSet<BiomeId>) void {
}
    // rust: self.valid = match biomes {
    // rust: Some(biomes) => biomes.clone(),
    // rust: None => (0..self.pipeline.data.biome_names().len() as u32)
    // rust: .map(BiomeId)
    // rust: .collect(),
}
}
}

pub const Biomes = enum {
    Region(&'a BiomeRegion<BiomeId>),
    Resolver(,
    // rust: &'a mut super::biome_source::BiomeSourceResolver<'b>,
    // rust: &'a mut SamplerContext,
    // rust: ),
    /// A resolver whose answers are kept per quart: far sampling paints eight
    /// depths of every column, and neighbouring columns share quarts, so most
    /// queries repeat one (each is a full climate sample and parameter search).
    Memo(,
    // rust: &'a mut super::biome_source::BiomeSourceResolver<'b>,
    // rust: &'a mut SamplerContext,
    // rust: &'a mut BiomeMemo,
    // rust: ),
};
/// Resolved biomes by quart (`Biomes::Memo`).
pub const BiomeMemo = struct {
    biomes: HashMap<[i32,
    /// Quarts per side of the columns sharing one biome, the first one asked
    /// (its surface's); 0 for one per quart. Far cells wider than a quart
    /// don't show a biome change a few blocks down, and climate changes over
    /// hundreds of blocks: a far tile shares one per 4x4 of its columns, in
    /// cells up to 64 blocks wide.
    /// (Painting asks through the biome zoom, which strays into neighbouring
    /// quarts: per quart, those strays were most of the climate samples.)
    cell: i32,
};
/// The biome at `quart`, resolved once per quart (`Biomes::Memo`).
    // rust: fn memo_biome(
    // rust: data: &GeneratorData,
    // rust: resolver: &mut super::biome_source::BiomeSourceResolver<'_>,
    // rust: context: &mut SamplerContext,
    // rust: memo: &mut BiomeMemo,
    // rust: quart: [i32; 3],
    // rust: ) -> Result<BiomeId, MaterialRuleError> {
    // rust: let key = if memo.cell > 0 {
    // rust: [
    // rust: quart[0].div_euclid(memo.cell),
    // rust: 0,
    // rust: quart[2].div_euclid(memo.cell),
    // rust: ]
    // rust: } else {
    // rust: quart
}
    // rust: if let Some(&id) = memo.biomes.get(&key) {
    // rust: return Ok(id);
}
    // rust: let name = resolver
    // rust: .sample(context, quart)
    // rust: .map_err(|_| MaterialRuleError::BiomeQueryFailed)?;
    // rust: let id = data.biome_id(name).ok_or(MaterialRuleError::MissingBiome)?;
    // rust: memo.biomes.insert(key, id);
    // rust: Ok(id)
}
// Per quart cell of a block-biome lookup: a lazy equality proof for its
// eight corners, or (when they differ) their jitter and biomes, so the blocks
// of the cell only redo the distance comparison.
pub const SurfaceCell = enum {
    Unknown,
    /// A corner lookup failed: only the original lookup may report errors.
    Lookup,
    Uniform(BiomeId),
    Mixed(u32),
};
pub const MixedCell = struct {
    jitter: [[f64,
    biomes: [BiomeId,
};
pub const UniformSurfaceBiomes = struct {
    origin: [i32,
    height: i32,
    cells: std.ArrayList(SurfaceCell),
    mixed: std.ArrayList(MixedCell),
    /// The cell of the previous lookup (columns are walked down in y).
    last: ([i32,
};
    // rust: impl UniformSurfaceBiomes {
pub fn new(pos: ChunkPos, min_y: i32, height: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let height = (height >> 2) + 1;
    // rust: Self {
    // rust: origin: [
    // rust: pos.x.wrapping_shl(4).wrapping_sub(2) >> 2,
    // rust: min_y.wrapping_sub(2) >> 2,
    // rust: pos.z.wrapping_shl(4).wrapping_sub(2) >> 2,
    // rust: ],
    // rust: height,
    // rust: cells: vec![SurfaceCell::Unknown; 25 * height as usize],
    // rust: mixed: Vec::new(),
    // rust: last: ([0; 3], SurfaceCell::Unknown),
}
}
pub fn get(self: *Self, region: *BiomeRegion<BiomeId>, p: BlockPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let base = [p.x, p.y, p.z].map(|v| v.wrapping_sub(2) >> 2);
    // rust: let cell = if self.last.0 == base && self.last.1 != SurfaceCell::Unknown {
    // rust: self.last.1
    // rust: } else {
    // rust: let cell = self.cell(region, base);
    // rust: self.last = (base, cell);
    // rust: cell
}
    // rust: match cell {
    // rust: SurfaceCell::Uniform(id) => Some(id),
    // rust: SurfaceCell::Mixed(index) => {
    // rust: let mixed = &self.mixed[index as usize];
    // rust: Some(mixed.biomes[BiomeZoom::select_corner(p, &mixed.jitter)])
}
    // rust: SurfaceCell::Unknown | SurfaceCell::Lookup => None,
}
}
pub fn cell(self: *Self, region: *BiomeRegion<BiomeId>, base: [i32; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d: [i32; 3] = std::array::from_fn(|i| base[i].wrapping_sub(self.origin[i]));
    // rust: if !(0..5).contains(&d[0]) || !(0..self.height).contains(&d[1]) || !(0..5).contains(&d[2]) {
    // rust: return SurfaceCell::Lookup;
}
    // rust: let slot = &mut self.cells[((d[0] * 5 + d[2]) * self.height + d[1]) as usize];
    // rust: if *slot != SurfaceCell::Unknown {
    // rust: return *slot;
}
        // These are immutable stored lookups, in quart_at_block's corner order.
    // rust: let mut biomes = [BiomeId(0); 8];
    // rust: for (corner, biome) in biomes.iter_mut().enumerate() {
    // rust: let offsets = [(corner >> 2) & 1, (corner >> 1) & 1, corner & 1];
    // rust: match region.noise_biome(std::array::from_fn(|i| {
    // rust: base[i].wrapping_add(offsets[i] as i32)
    // rust: })) {
    // rust: Ok(id) => *biome = *id,
    // rust: Err(_) => {
    // rust: *slot = SurfaceCell::Lookup;
    // rust: return SurfaceCell::Lookup;
}
}
}
    // rust: let value = if biomes.iter().all(|id| *id == biomes[0]) {
    // rust: SurfaceCell::Uniform(biomes[0])
    // rust: } else {
    // rust: self.mixed.push(MixedCell {
    // rust: jitter: region.zoom().corner_jitter(base),
    // rust: biomes,
    // rust: });
    // rust: SurfaceCell::Mixed(self.mixed.len() as u32 - 1)
}
    // rust: *slot = value;
    // rust: value
}
}
/// Material-rule world queries for one chunk: shared seed-bound noises, the
/// worker's temperature caches and either stored or raw-resolver biomes.
pub const SurfaceQueries = struct {
    pipeline: *'a Pipeline<R>,
    temperatures: *'a mut [BiomeTemperature],
    biome: Biomes<'a,
    possible: ?BTreeSet<[]const u8>,
    uniform_biomes: ?UniformSurfaceBiomes,
};
    // rust: impl<R: RandomSource> SurfaceQueries<'_, '_, R> {
pub fn temperature(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = self
    // rust: .pipeline
    // rust: .data
    // rust: .biome_id(name)
    // rust: .ok_or(MaterialRuleError::MissingBiome)?;
    // rust: Ok(&mut self.temperatures[id.0 as usize])
}
}
    // rust: impl<R: RandomSource> MaterialSurfaceQueries for SurfaceQueries<'_, '_, R> {
pub fn surface_depth(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.surface.surface_depth(x, z)
}
pub fn surface_secondary(self: *Self, x: i32, z: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.surface.surface_secondary(x, z)
}
pub fn band(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline
    // rust: .surface
    // rust: .band([p.x, p.y, p.z])
    // rust: .ok_or(MaterialRuleError::InvalidBandIndex)
}
pub fn bind_noise(self: *Self, name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline
    // rust: .noises
    // rust: .get(&super::tags::identifier(name)?)
    // rust: .cloned()
    // rust: .ok_or(DecodeError::Field("unknown material noise"))
}
pub fn possible_biomes(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.possible.clone()
}
pub fn biome(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .biome_id(p)?
    // rust: .map(|id| self.pipeline.data.biome_names[id as usize].clone()))
}
pub fn biome_index(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(self.pipeline.data.biome_id(name).map(|id| id.0))
}
pub fn biome_id(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = &self.pipeline.data;
    // rust: let id = match &mut self.biome {
    // rust: Biomes::Region(region) => match self
    // rust: .uniform_biomes
    // rust: .as_mut()
    // rust: .and_then(|cache| cache.get(region, p))
    // rust: {
    // rust: Some(id) => id,
    // rust: None => *region
    // rust: .biome(p)
    // rust: .map_err(|_| MaterialRuleError::MissingBiome)?,
    // rust: },
    // rust: Biomes::Resolver(resolver, context) => {
    // rust: let name = resolver
    // rust: .sample(context, self.pipeline.zoom.quart_at_block(p))
    // rust: .map_err(|_| MaterialRuleError::BiomeQueryFailed)?;
    // rust: data.biome_id(name).ok_or(MaterialRuleError::MissingBiome)?
}
    // rust: Biomes::Memo(resolver, context, memo) => memo_biome(
    // rust: data,
    // rust: resolver,
    // rust: context,
    // rust: memo,
    // rust: self.pipeline.zoom.quart_at_block(p),
    // rust: )?,
}
    // rust: Ok(Some(id.0))
}
    // rust: fn cold_enough_to_snow(
    // rust: &mut self,
    // rust: name: &str,
    // rust: p: BlockPos,
    // rust: sea: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: Ok(self.temperature(name)?.cold_enough_to_snow(p, sea))
}
    // rust: fn melts_frozen_ocean(
    // rust: &mut self,
    // rust: name: &str,
    // rust: p: BlockPos,
    // rust: sea: i32,
    // rust: ) -> Result<bool, MaterialRuleError> {
    // rust: Ok(self
    // rust: .temperature(name)?
    // rust: .should_melt_frozen_ocean_iceberg_slightly(p, sea))
}
}

pub fn lap(clock: *mut std::time::Instant) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let now = std::time::Instant::now();
    // rust: let elapsed = now - *clock;
    // rust: *clock = now;
    // rust: elapsed
}
/// Cumulative wall time spent by one worker in each proto-chunk stage.
pub const StageTimings = struct {
    chunks: u64,
    biomes: std::time::Duration,
    /// Noise fill including aquifer setup.
    noise: std::time::Duration,
    surface: std::time::Duration,
    /// Structure starts/references and terrain adaptation.
    structures: std::time::Duration,
    /// Carving mask generation/application and final heightmap priming.
    carvers: std::time::Duration,
};
/// Worker-owned mutable caches. Biome temperature caches mirror vanilla's
/// thread-local caches and never change results.
    // rust: pub(super) struct WorkerState {
    // rust: pub(super) temperatures: Vec<BiomeTemperature>,
    // rust: terrain_context: SamplerContext,
    // rust: biome_context: SamplerContext,
    // rust: carver_context: SamplerContext,
    /// Seed/dimension-bound lookups avoid the shared mutex for overlapping
    /// carver neighborhoods. Bounded independently of the shared cache.
    // rust: carver_biomes: HashMap<(i32, i32), BiomeId>,
    /// Noise biomes asked one at a time by structure placement checks
    /// (`StartContext::noise_biome`): several structures test the same
    /// quarts, column checks whole columns, and each is a full climate sample.
    // rust: structure_biomes: HashMap<[i32; 3], BiomeId>,
    // rust: timings: StageTimings,
    // rust: heights: HashMap<(i32, i32, u8), i32>,
    /// Decorate with structure pieces only (for structure parity checks).
    // rust: pub(super) structures_only: bool,
    // rust: pub(super) structure_mobs: Option<Arc<dyn StructureMobs>>,
    /// The world's surface rule compiled once for this worker's chunks: a
    /// `CompiledSurfaceRule` of the pipeline's random.
    // rust: surface_rule: Option<Box<dyn Any + Send>>,
}
/// `Mob.finalizeSpawn(level, difficulty, STRUCTURE, null)` of the entities a
/// structure places with finalizeEntities, run by the game, which owns mobs.
    // rust: pub trait StructureMobs: Send + Sync {
    /// Finalizes the entity in `nbt` if it is a mob, drawing from the
    /// region's random. `biome` is the biome at its block, `structures` the
    /// structures with a piece there. False when it could not: the entity
    /// keeps its `horizon:finalize` for the game to finish on load.
    // rust: fn finalize(
    // rust: &self,
    // rust: nbt: &mut crate::nbt::Compound,
    // rust: biome: &str,
    // rust: structures: &[String],
    // rust: random: &mut dyn super::structure::legacy::PieceRandom,
    // rust: ) -> bool;
}

    // rust: trait SeededPipeline: Send + Sync {
    // rust: fn generate(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: pos: ChunkPos,
    // rust: ) -> Result<ProtoChunk, GeneratorError>;
    // rust: fn decorate(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: region: &mut [ProtoChunk; 9],
    // rust: ) -> Result<DecorateStats, GeneratorError>;
pub fn data(self: *Self) *;
    /// What the shared caches hold, for `horizon-ctl memory`.
pub fn cache_census(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: CacheCensus::default()
}
    /// Empty the caches that only spare work ([`OverworldGenerator::release_caches`]).
pub fn release_caches(self: *Self) void {
}
    /// The exact `end_island_decorated` origins in a chunk, without terrain.
pub fn end_island_origins(self: *Self, chunk: ChunkPos) V;
pub fn sea_level(self: *Self) i;
    /// The level's build range (minimum Y, height).
pub fn level(self: *Self) (;
    // rust: fn surface_sample(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: x: i32,
    // rust: z: i32,
    // rust: spans: Option<&mut Vec<(i32, i32, BlockStateId)>>,
    // rust: ) -> Option<SurfaceSample>;
    // rust: fn lod_grid(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: x: i32,
    // rust: z: i32,
    // rust: width: i32,
    // rust: side: usize,
    // rust: approximate: bool,
    // rust: ) -> Result<Vec<LodColumn>, GeneratorError>;
    // rust: fn structure_starts(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: pos: ChunkPos,
    // rust: ) -> Vec<Arc<super::structure::start::StructureStart>>;
    /// `Structure.generate` for one structure in one chunk (`/place
    /// structure`), outside any structure set's placement.
    // rust: fn structure_start(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: structure: &str,
    // rust: chunk: ChunkPos,
    // rust: ) -> Option<Arc<super::structure::start::StructureStart>>;
pub fn unsupported_features(self: *Self) V;
    // rust: fn use_saved_start(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: chunk: ChunkPos,
    // rust: structure: &str,
    // rust: pieces: &[serde_json::Value],
    // rust: ) -> Result<(), String>;
pub fn forget_structure_starts(self: *Self) void;
pub fn ring_positions(self: *Self, worker: *mut WorkerState, set: []const u8) O;
    /// The structures whose random-spread set may start in `chunk`, each with whether a
    /// search's start check lets it start there.
    // rust: fn may_start_answers(
    // rust: &self,
    // rust: _worker: &mut WorkerState,
    // rust: _chunk: ChunkPos,
    // rust: ) -> Vec<(String, bool)> {
    // rust: Vec::new()
}
pub fn spawn_position(self: *Self) R;
pub fn region_random(self: *Self, center: ChunkPos) B;
    // rust: fn locate(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: names: &[String],
    // rust: from: [i32; 3],
    // rust: radius: i32,
    // rust: skip: &dyn Fn(&str, ChunkPos) -> bool,
    // rust: ) -> Option<(String, [i32; 3])>;
    /// The chunks an older version generated, for `Blender.of`.
pub fn set_old_world(self: *Self, world: *dyn super::blending::OldWorld) void;
    /// `NoiseBasedChunkGenerator.addDebugScreenInfo`.
pub fn debug_density_line(self: *Self, feet: [i32; 3]) O;
    // rust: fn find_closest_biome(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: search: &BiomeSearch<'_>,
    // rust: ) -> Option<(String, [i32; 3])>;
    /// `BiomeSource.getNoiseBiome` at each quart position (unloaded chunks).
pub fn noise_biomes(self: *Self, worker: *mut WorkerState, quarts: *[[i32; 3]]) V;
    // rust: fn jigsaw_pieces(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: query: &JigsawQuery<'_>,
    // rust: ) -> Option<JigsawPieces>;
}
    // rust: impl<R: RandomSource + 'static> SeededPipeline for Pipeline<R>
    // rust: where
    // rust: R::Positional: Clone + Send + Sync,
    // rust: {
    // rust: fn generate(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: pos: ChunkPos,
    // rust: ) -> Result<ProtoChunk, GeneratorError> {
    // rust: Pipeline::generate(self, worker, pos)
}
    // rust: fn decorate(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: region: &mut [ProtoChunk; 9],
    // rust: ) -> Result<DecorateStats, GeneratorError> {
    // rust: match &self.decoration {
    // rust: Some(decoration) => {
    // rust: let mut random = self.region_random_at(region[4].position());
    // rust: decoration.decorate(
    // rust: &self.data,
    // rust: self.seed,
    // rust: self.generation(),
    // rust: worker,
    // rust: region,
    // rust: &mut random,
    // rust: self.structures.as_ref(),
    // rust: )
}
    // rust: None => Err(resource("decoration resources were not loaded")),
}
}
pub fn data(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.data
}
pub fn release_caches(self: *Self) void {
}
        // Taken out under the lock, dropped after it.
    // rust: let biomes = std::mem::take(&mut *self.biome_cache.lock().unwrap());
    // rust: let carvers = std::mem::take(&mut *self.carver_cache.lock().unwrap());
    // rust: drop((biomes, carvers));
}
pub fn cache_census(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let biomes = self.biome_cache.lock().unwrap();
    // rust: let (start_chunks, start_lists) = self
    // rust: .structures
    // rust: .as_ref()
    // rust: .map_or((0, 0), |s| s.start_census());
    // rust: CacheCensus {
    // rust: biome_chunks: biomes.len(),
    // rust: biome_bytes: biomes
    // rust: .values()
    // rust: .map(|b| std::mem::size_of::<BiomeChunk<BiomeId>>() + b.heap_bytes())
    // rust: .sum::<usize>()
    // rust: + biomes.capacity() * std::mem::size_of::<((i32, i32), usize)>(),
    // rust: carver_entries: self.carver_cache.lock().unwrap().len(),
    // rust: start_chunks,
    // rust: start_lists,
}
}
pub fn end_island_origins(self: *Self, chunk: ChunkPos) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(decoration) = &self.decoration else {
    // rust: return Vec::new();
}
    // rust: let mut resolver = self.source.resolver(
    // rust: &self.climate,
    // rust: self.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: let mut context = SamplerContext::cached();
    // rust: decoration.origins(self.seed, chunk, |position| {
    // rust: let quart = [position[0] >> 2, position[1] >> 2, position[2] >> 2];
    // rust: resolver.sample(&mut context, quart).ok() == Some("minecraft:small_end_islands")
    // rust: })
}
pub fn sea_level(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.settings.sea_level
}
pub fn level(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.settings.level_min_y, self.settings.level_height)
}
    // rust: fn structure_starts(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: pos: ChunkPos,
    // rust: ) -> Vec<Arc<super::structure::start::StructureStart>> {
    // rust: match &self.structures {
    // rust: Some(structures) => structures
    // rust: .starts_at(
    // rust: &mut StructureQueries {
    // rust: pipeline: self,
    // rust: worker,
    // rust: valid: BTreeSet::new(),
    // rust: },
    // rust: pos,
    // rust: )
    // rust: .to_vec(),
    // rust: None => Vec::new(),
}
}
    // rust: fn structure_start(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: structure: &str,
    // rust: chunk: ChunkPos,
    // rust: ) -> Option<Arc<super::structure::start::StructureStart>> {
    // rust: self.placement_structures()?
    // rust: .structure_start(
    // rust: &mut StructureQueries {
    // rust: pipeline: self,
    // rust: worker,
    // rust: valid: BTreeSet::new(),
    // rust: },
    // rust: structure,
    // rust: chunk,
    // rust: )
    // rust: .map(Arc::new)
}
pub fn unsupported_features(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.decoration
    // rust: .as_ref()
    // rust: .map(|decoration| decoration.unsupported())
    // rust: .unwrap_or_default()
}
    // rust: fn use_saved_start(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: chunk: ChunkPos,
    // rust: structure: &str,
    // rust: pieces: &[serde_json::Value],
    // rust: ) -> Result<(), String> {
    // rust: let structures = (self.structures.as_ref()).ok_or("structures were not loaded")?;
    // rust: let mut queries = StructureQueries {
    // rust: pipeline: self,
    // rust: worker,
    // rust: valid: BTreeSet::new(),
}
    // rust: structures.use_saved_start(&mut queries, chunk, structure, pieces)
}
pub fn forget_structure_starts(self: *Self) void {
}
    // rust: if let Some(structures) = &self.structures {
    // rust: structures.forget_starts();
}
}
pub fn may_start_answers(self: *Self, worker: *mut WorkerState, chunk: ChunkPos) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match &self.structures {
    // rust: Some(structures) => structures.may_start_answers(
    // rust: &mut StructureQueries {
    // rust: pipeline: self,
    // rust: worker,
    // rust: valid: BTreeSet::new(),
    // rust: },
    // rust: chunk,
    // rust: ),
    // rust: None => Vec::new(),
}
}
pub fn ring_positions(self: *Self, worker: *mut WorkerState, set: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.structures.as_ref()?.ring_positions(
    // rust: &mut StructureQueries {
    // rust: pipeline: self,
    // rust: worker,
    // rust: valid: BTreeSet::new(),
    // rust: },
    // rust: set,
    // rust: )
}
pub fn region_random(self: *Self, center: ChunkPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Box::new(self.region_random_at(center))
}
pub fn spawn_position(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.spawn_column()
}
    // rust: fn locate(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: names: &[String],
    // rust: from: [i32; 3],
    // rust: radius: i32,
    // rust: skip: &dyn Fn(&str, ChunkPos) -> bool,
    // rust: ) -> Option<(String, [i32; 3])> {
    // rust: self.structures.as_ref()?.locate(
    // rust: &mut StructureQueries {
    // rust: pipeline: self,
    // rust: worker,
    // rust: valid: BTreeSet::new(),
    // rust: },
    // rust: names,
    // rust: from,
    // rust: radius,
    // rust: skip,
    // rust: )
}
pub fn set_old_world(self: *Self, world: *dyn super::blending::OldWorld) void {
}
    // rust: let _ = self.old_world.set(world);
}
    /// `NoiseBasedChunkGenerator.addDebugScreenInfo`: the labelled values of
    /// the settings' `debug_functions` at `feet`, three decimals each.
pub fn debug_density_line(self: *Self, feet: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.debug_density.is_empty() {
    // rust: return None;
}
    // rust: let mut context = SamplerContext::cached();
    // rust: let mut line = String::from("Density ");
    // rust: for (label, sampler) in &self.debug_density {
    // rust: let value = sampler.sample_value(&mut context, feet).ok()?;
    // rust: line.push_str(&format!("{label}: {:.3} ", f64::from(value)));
}
    // rust: line.pop();
    // rust: Some(line)
}
    // rust: fn find_closest_biome(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: search: &BiomeSearch<'_>,
    // rust: ) -> Option<(String, [i32; 3])> {
        // BiomeSource.findClosestBiome3d.
    // rust: let candidates: BTreeSet<&str> = self
    // rust: .source
    // rust: .possible_biomes()
    // rust: .into_iter()
    // rust: .filter(|name| (search.allowed)(name))
    // rust: .collect();
    // rust: if candidates.is_empty() {
    // rust: return None;
}
    // rust: let mut resolver = self.source.resolver(
    // rust: &self.climate,
    // rust: self.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: let ys = out_from_origin(
    // rust: search.origin[1],
    // rust: search.min_y + 1,
    // rust: search.max_y + 1,
    // rust: search.vertical,
    // rust: );
    // rust: let radius = search.radius.div_euclid(search.horizontal);
    // rust: for [sx, sz] in spiral_around(radius) {
    // rust: let x = search.origin[0].wrapping_add(sx.wrapping_mul(search.horizontal));
    // rust: let z = search.origin[2].wrapping_add(sz.wrapping_mul(search.horizontal));
    // rust: for &y in &ys {
    // rust: let quart = [x >> 2, y >> 2, z >> 2];
    // rust: let Ok(name) = resolver.sample(&mut worker.carver_context, quart) else {
    // rust: continue;
}
    // rust: if candidates.contains(name) {
    // rust: return Some((name.to_owned(), [x, y, z]));
}
}
}
    // rust: None
}
    // rust: fn surface_sample(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: x: i32,
    // rust: z: i32,
    // rust: mut spans: Option<&mut Vec<(i32, i32, BlockStateId)>>,
    // rust: ) -> Option<SurfaceSample> {
    // rust: let mut top = None;
    // rust: let mut water = None;
    // rust: let mut below = 0;
    // rust: let mut surface_complete = false;
    // rust: let mut visit = |y, state| {
    // rust: let properties = self.data.states.get(state);
    // rust: if let Some(spans) = spans.as_mut()
    // rust: && !properties.is_air()
    // rust: {
    // rust: if let Some((min, _, previous)) = spans.last_mut()
    // rust: && *min == y + 1
    // rust: && *previous == state
    // rust: {
    // rust: *min = y;
    // rust: } else {
    // rust: spans.push((y, y + 1, state));
}
}
    // rust: if surface_complete {
    // rust: return false;
}
    // rust: if properties.is_air() || properties.has_fluid() {
    // rust: if top.is_some() {
    // rust: surface_complete = true;
    // rust: return spans.is_none();
}
    // rust: if properties.has_fluid() {
    // rust: water.get_or_insert((y + 1, state));
    // rust: } else {
                    // Match the material traversal's water reset across air gaps.
    // rust: water = None;
}
    // rust: } else {
    // rust: top.get_or_insert((y + 1, state));
    // rust: below += 1;
}
    // rust: false
}
    // rust: self.noise_column(x, z, &mut visit);
    // rust: let (height, state) = top?;
        // A superflat surface is its top layer, with its one biome.
    // rust: if self.flat.is_some() {
    // rust: let biome = self
    // rust: .source
    // rust: .possible_biomes()
    // rust: .into_iter()
    // rust: .find_map(|name| self.data.biome_id(name))?;
    // rust: return Some(SurfaceSample {
    // rust: height,
    // rust: state,
    // rust: water,
    // rust: biome,
    // rust: });
}
    // rust: let y = height - 1;
    // rust: let position = BlockPos::new(x, y, z);
    // rust: let mut resolver = self.source.resolver(
    // rust: &self.climate,
    // rust: self.router.get(RouterField::Erosion).as_ref(),
    // rust: );
        // Use a fresh bounded context: far samples must not grow the chunk/structure caches.
    // rust: let mut biome_context = SamplerContext::default();
    // rust: let biome = resolver
    // rust: .sample(&mut biome_context, self.zoom.quart_at_block(position))
    // rust: .ok()?;
    // rust: let biome = self.data.biome_id(biome)?;
    // rust: let volume = DensityVolume::new([1; 3], [x, y, z], [1; 3]).ok()?;
    // rust: let queries = SurfaceQueries {
    // rust: pipeline: self,
    // rust: temperatures: &mut worker.temperatures,
    // rust: biome: Biomes::Resolver(&mut resolver, &mut biome_context),
    // rust: uniform_biomes: None,
    // rust: possible: None,
}
    // rust: let sources = MaterialDensitySources::new(
    // rust: queries,
    // rust: volume,
    // rust: self.preliminary.clone(),
    // rust: SamplerContext::default(),
    // rust: )
    // rust: .ok()?;
    // rust: let mut material =
    // rust: MaterialConditions::<R, _>::new(self.generation(), self.root.clone(), sources);
    // rust: let rule = material.add_rule(self.rule.clone()).ok()?;
        // shortcut: distant surfaces omit slope rules and column extensions; nearby chunks provide full terrain.
    // rust: material.update_xz(x, z, 0, 0);
    // rust: material.update_y(1, below, water.map_or(i32::MIN, |(height, _)| height), y);
    // rust: let state = material.try_apply(rule, position).ok()?.unwrap_or(state);
    // rust: if let Some(spans) = spans
    // rust: && let Some(index) = spans.iter().position(|&(min, max, _)| min <= y && y < max)
    // rust: && spans[index].2 != state
    // rust: {
    // rust: let (min, max, _) = spans[index];
    // rust: if min == y {
    // rust: spans[index].2 = state;
    // rust: } else {
    // rust: spans[index].1 = y;
    // rust: spans.insert(index, (y, max, state));
}
}
    // rust: Some(SurfaceSample {
    // rust: height,
    // rust: state,
    // rust: water,
    // rust: biome,
    // rust: })
}
    // rust: fn lod_grid(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: x: i32,
    // rust: z: i32,
    // rust: width: i32,
    // rust: side: usize,
    // rust: approximate: bool,
    // rust: ) -> Result<Vec<LodColumn>, GeneratorError> {
    // rust: if width <= 0 || side == 0 || side > 64 {
    // rust: return Err(resource("far sample dimensions"));
}
        // A superflat world's columns are its layers: the surface sample, and its spans.
    // rust: if self.flat.is_some() {
    // rust: let mut columns = Vec::with_capacity(side * side);
    // rust: for dz in 0..side {
    // rust: for dx in 0..side {
    // rust: let (wx, wz) = (x + dx as i32 * width, z + dz as i32 * width);
    // rust: let mut spans = Vec::new();
    // rust: let sample =
    // rust: SeededPipeline::surface_sample(self, worker, wx, wz, Some(&mut spans));
    // rust: columns.push((sample, spans));
}
}
    // rust: return Ok(columns);
}
    // rust: let mut geometry = Vec::with_capacity(side * side);
        // The coarse and band passes below share the 2D (x/z-only) parts.
    // rust: let mut context = if approximate {
    // rust: SamplerContext::sparse().with_planes()
    // rust: } else {
    // rust: SamplerContext::sparse()
}
    // rust: let (min, height) = (self.settings.noise_min_y, self.settings.noise_height);
    // rust: let step_xz = width.max(4);
    // rust: let ox = x.div_euclid(4) * 4;
    // rust: let oz = z.div_euclid(4) * 4;
    // rust: let nx = ((x - ox + (side as i32 - 1) * width + step_xz - 1) / step_xz) + 1;
    // rust: let nz = ((z - oz + (side as i32 - 1) * width + step_xz - 1) / step_xz) + 1;
        // Reduced far detail: how many blocks down surface rules paint a far
        // column. Vanilla's rules reach eight blocks (dirt under grass, sand
        // under a beach, powder snow over a peak), but a tile this wide draws
        // at most a block or two of each column's vertical face, so painting
        // the six below it is work no view resolves. Depth 1 is always painted,
        // so the surface the tile shows -- its height, its top state, its
        // biome -- is exactly what Full detail gives; only the interior of a
        // span, seen on a cliff, loses its vanilla material. Narrow tiles keep
        // all eight: their faces are tall enough in view to show them.
    // rust: let material_depth = if approximate && width >= 16 { 2 } else { 8 };
        // Approximate: cells many blocks wide keep their interpolated shape on
        // a coarser vertical lattice, for a fraction of the density work.
    // rust: let step_y = match width {
    // rust: _ if !approximate => 8,
    // rust: ..32 => 8,
    // rust: 32..128 => 16,
    // rust: _ => 32,
}
    // rust: let final_density = self.router.get(RouterField::FinalDensity);
        // Approximate: far tiles show the surface, so find its band on a
        // coarse lattice (its points are the fine lattice's), then sample the
        // fine lattice only inside it. Most of a tall world's column is sky or
        // deep rock. Parts thinner than the coarse step above an air sample
        // (floating islands, overhang lips) can be missed; below the band, a
        // column is one span of the default block.
    // rust: let (band_min, band_max) = if approximate {
pub const COARSE: i32 = 64;
    // rust: let coarse_layers = (height + COARSE - 1) / COARSE + 1;
    // rust: let coarse = DensityVolume::new(
    // rust: [nx, coarse_layers, nz],
    // rust: [ox, min, oz],
    // rust: [step_xz, COARSE, step_xz],
    // rust: )
    // rust: .map_err(stage("far density"))?;
    // rust: let mut coarse_densities = vec![0.; coarse.size()];
    // rust: final_density
    // rust: .sample_volume(&mut context, &mut coarse_densities, coarse)
    // rust: .map_err(stage("far density"))?;
    // rust: let (mut lowest, mut highest) = (i32::MAX, i32::MIN);
    // rust: for iz in 0..nz as usize {
    // rust: for ix in 0..nx as usize {
    // rust: let solid = (0..coarse_layers as usize)
    // rust: .rev()
    // rust: .find(|&iy| coarse_densities[coarse.index([ix, iy, iz]).unwrap()] > 0.);
    // rust: if let Some(iy) = solid {
    // rust: let y = min + iy as i32 * COARSE;
    // rust: lowest = lowest.min(y - COARSE);
    // rust: highest = highest.max(y + 2 * COARSE);
}
}
}
    // rust: if lowest > highest {
    // rust: (min, min + height)
    // rust: } else {
    // rust: let lowest = lowest.max(min);
    // rust: (
    // rust: min + (lowest - min) / step_y * step_y,
    // rust: highest
    // rust: .max(self.settings.sea_level + COARSE)
    // rust: .min(min + height),
    // rust: )
}
    // rust: } else {
    // rust: (min, min + height)
}
    // rust: let ny = (band_max - band_min + step_y - 1) / step_y + 1;
    // rust: let volume =
    // rust: DensityVolume::new([nx, ny, nz], [ox, band_min, oz], [step_xz, step_y, step_xz])
    // rust: .map_err(stage("far density"))?;
    // rust: let mut densities = vec![0.; volume.size()];
    // rust: final_density
    // rust: .sample_volume(&mut context, &mut densities, volume)
    // rust: .map_err(stage("far density"))?;
    // rust: let aquifer = DisabledAquifer::new(
    // rust: self.picker,
    // rust: self.data.registry.default_state("minecraft:air").unwrap(),
    // rust: );
        // Interpolate the supplied lattice, never the physical bounding volume.
    // rust: let value = |wx: i32, iy: usize, wz: i32| {
    // rust: let rx = (wx - ox) as f32 / step_xz as f32;
    // rust: let rz = (wz - oz) as f32 / step_xz as f32;
    // rust: let ix = rx.floor() as usize;
    // rust: let iz = rz.floor() as usize;
    // rust: let at = |dx: usize, dz: usize| {
    // rust: densities[volume
    // rust: .index([
    // rust: (ix + dx).min(nx as usize - 1),
    // rust: iy,
    // rust: (iz + dz).min(nz as usize - 1),
    // rust: ])
    // rust: .unwrap()]
}
    // rust: let mix = |a: f32, b: f32, t: f32| a + (b - a) * t;
    // rust: mix(
    // rust: mix(at(0, 0), at(1, 0), rx - ix as f32),
    // rust: mix(at(0, 1), at(1, 1), rx - ix as f32),
    // rust: rz - iz as f32,
    // rust: )
}
    // rust: let mut profile = vec![0.; ny as usize];
    // rust: let mut resolver = self.source.resolver(
    // rust: &self.climate,
    // rust: self.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: let mut biome_context = SamplerContext::cached();
    // rust: let mut biome_memo = BiomeMemo {
    // rust: biomes: HashMap::new(),
            // Columns `width` blocks apart are width / 4 quarts apart; cells
            // stop at 64 blocks (wider ones moved a third of level 6's biomes).
    // rust: cell: if approximate && width >= 4 {
    // rust: width.min(16)
    // rust: } else {
    // rust: 0
    // rust: },
}
    // rust: for dz in 0..side {
    // rust: for dx in 0..side {
    // rust: let (wx, wz) = (x + dx as i32 * width, z + dz as i32 * width);
    // rust: let mut top = None;
    // rust: let mut water = None;
    // rust: let mut below = 0;
    // rust: let mut complete = false;
    // rust: let mut spans: Vec<(i32, i32, BlockStateId)> = Vec::new();
    // rust: for (iy, density) in profile.iter_mut().enumerate() {
    // rust: *density = value(wx, iy, wz);
}
    // rust: for y in (band_min..band_max).rev() {
    // rust: let iy = ((y - band_min) / step_y) as usize;
    // rust: let alpha = ((y - band_min) % step_y) as f32 / step_y as f32;
    // rust: let density = profile[iy] + (profile[iy + 1] - profile[iy]) * alpha;
    // rust: let state = aquifer
    // rust: .compute_substance([wx, y, wz], f64::from(density))
    // rust: .unwrap_or(self.settings.default_block);
    // rust: let properties = self.data.states.get(state);
    // rust: if !properties.is_air() {
    // rust: if let Some((min, _, old)) = spans.last_mut()
    // rust: && *min == y + 1
    // rust: && *old == state
    // rust: {
    // rust: *min = y;
    // rust: } else {
    // rust: spans.push((y, y + 1, state));
}
}
    // rust: if !complete {
    // rust: if properties.is_air() || properties.has_fluid() {
    // rust: if top.is_some() {
    // rust: complete = true;
    // rust: } else if properties.has_fluid() {
    // rust: water.get_or_insert((y + 1, state));
    // rust: } else {
    // rust: water = None;
}
    // rust: } else {
    // rust: top.get_or_insert((y + 1, state));
    // rust: below += 1;
}
}
}
    // rust: if band_min > min {
    // rust: let fill = self.settings.default_block;
    // rust: if top.is_some() && !complete {
    // rust: below += band_min - min;
}
    // rust: match spans.last_mut() {
    // rust: Some((low, _, state)) if *low == band_min && *state == fill => *low = min,
    // rust: _ => spans.push((min, band_min, fill)),
}
}
                // Void cells still need a biome: the End's small islands are
                // features over the void, and their biome is 2D there.
    // rust: let biome = if let Some((height, _)) = top {
    // rust: memo_biome(
    // rust: &self.data,
    // rust: &mut resolver,
    // rust: &mut biome_context,
    // rust: &mut biome_memo,
    // rust: self.zoom.quart_at_block(BlockPos::new(wx, height - 1, wz)),
    // rust: )
    // rust: .map_err(stage("far biome"))?
    // rust: } else {
    // rust: BiomeId(0)
}
    // rust: geometry.push((top, water, below, spans, biome));
}
}
    // rust: if geometry.iter().all(|column| column.0.is_none()) {
    // rust: return Ok(geometry
    // rust: .into_iter()
    // rust: .map(|(_, _, _, spans, _)| (None, spans))
    // rust: .collect());
}
    // rust: let volume =
    // rust: DensityVolume::new([1; 3], [x, 0, z], [1; 3]).map_err(stage("far material"))?;
    // rust: let queries = SurfaceQueries {
    // rust: pipeline: self,
    // rust: temperatures: &mut worker.temperatures,
    // rust: biome: Biomes::Memo(&mut resolver, &mut biome_context, &mut biome_memo),
    // rust: uniform_biomes: None,
    // rust: possible: None,
}
    // rust: let sources = MaterialDensitySources::new(
    // rust: queries,
    // rust: volume,
    // rust: self.preliminary.clone(),
    // rust: SamplerContext::cached(),
    // rust: )
    // rust: .map_err(stage("far material"))?;
    // rust: let mut material =
    // rust: MaterialConditions::<R, _>::new(self.generation(), self.root.clone(), sources);
    // rust: let rule = material
    // rust: .add_rule(self.rule.clone())
    // rust: .map_err(stage("far material"))?;
    // rust: let mut result = Vec::with_capacity(side * side);
    // rust: for (index, (top, water, below, mut spans, biome)) in geometry.into_iter().enumerate() {
    // rust: let (wx, wz) = (
    // rust: x + (index % side) as i32 * width,
    // rust: z + (index / side) as i32 * width,
    // rust: );
    // rust: let Some((height, mut state)) = top else {
    // rust: result.push((None, spans));
    // rust: continue;
}
    // rust: material.update_xz(wx, wz, 0, 0);
    // rust: for depth in 1..=below.min(material_depth) {
    // rust: let y = height - depth;
    // rust: material.update_y(
    // rust: depth,
    // rust: below - depth + 1,
    // rust: water.map_or(i32::MIN, |(height, _)| height),
    // rust: y,
    // rust: );
    // rust: let Some(index) = spans.iter().position(|&(min, max, _)| min <= y && y < max)
    // rust: else {
    // rust: continue;
}
    // rust: let (min, max, old) = spans[index];
    // rust: let painted = material
    // rust: .try_apply(rule, BlockPos::new(wx, y, wz))
    // rust: .map_err(stage("far material"))?
    // rust: .unwrap_or(old);
    // rust: if depth == 1 {
    // rust: state = painted;
}
    // rust: if old == painted {
    // rust: continue;
}
    // rust: let mut replacement = Vec::with_capacity(3);
    // rust: if y + 1 < max {
    // rust: replacement.push((y + 1, max, old));
}
    // rust: replacement.push((y, y + 1, painted));
    // rust: if min < y {
    // rust: replacement.push((min, y, old));
}
    // rust: spans.splice(index..=index, replacement);
}
    // rust: result.push((
    // rust: Some(SurfaceSample {
    // rust: height,
    // rust: state,
    // rust: water,
    // rust: biome,
    // rust: }),
    // rust: spans,
    // rust: ));
}
    // rust: Ok(result)
}
pub fn noise_biomes(self: *Self, worker: *mut WorkerState, quarts: *[[i32; 3]]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut resolver = self.source.resolver(
    // rust: &self.climate,
    // rust: self.router.get(RouterField::Erosion).as_ref(),
    // rust: );
    // rust: quarts
    // rust: .iter()
    // rust: .map(|&quart| {
    // rust: resolver
    // rust: .sample(&mut worker.carver_context, quart)
    // rust: .ok()
    // rust: .map(str::to_owned)
    // rust: })
    // rust: .collect()
}
    // rust: fn jigsaw_pieces(
    // rust: &self,
    // rust: worker: &mut WorkerState,
    // rust: query: &JigsawQuery<'_>,
    // rust: ) -> Option<JigsawPieces> {
        // JigsawPlacement.generateJigsaw: addPieces with no heightmap
        // projection, MaxDistance(128), no aliases, no padding and
        // waterlogging applied. The pieces draw from the GenerationContext's
        // random, seeded from the level seed and the position's chunk, not
        // from the level random.
    // rust: let structures = self.placement_structures()?;
    // rust: let mut random = horizon_core::random::WorldgenRandom::new(LegacyRandom::new(0));
    // rust: random.set_large_feature_seed(self.seed, query.position[0] >> 4, query.position[2] >> 4);
    // rust: let aliases = BTreeMap::new();
    // rust: let config = super::structure::jigsaw::JigsawConfig {
    // rust: start_pool: query.pool,
    // rust: start_jigsaw: Some(query.target),
    // rust: max_depth: query.max_depth,
    // rust: use_expansion_hack: false,
    // rust: project_to: None,
    // rust: max_distance: [128, 128],
    // rust: aliases: &aliases,
    // rust: padding: [0, 0],
    // rust: waterlogging: true,
}
    // rust: let (_, pieces) = super::structure::jigsaw::assemble(
    // rust: &config,
    // rust: &mut StructureQueries {
    // rust: pipeline: self,
    // rust: worker,
    // rust: valid: BTreeSet::new(),
    // rust: },
    // rust: &structures.registry.pools,
    // rust: &structures.resources,
    // rust: &structures.bindings,
    // rust: &mut random,
    // rust: query.position,
    // rust: )?;
    // rust: Some(JigsawPieces {
    // rust: pieces,
    // rust: resources: structures.resources.clone(),
    // rust: })
}
}

/// A `JigsawPlacement.generateJigsaw` request (`/place jigsaw`).
pub const JigsawQuery = struct {
    pool: *'a str,
    target: *'a str,
    max_depth: i32,
    position: [i32,
};
/// The assembled pieces of a jigsaw and the templates they place.
pub const JigsawPieces = struct {
    pieces: std.ArrayList(super::structure::jigsaw::PoolPiece),
    resources: *super::structure::StructureResources,
};

/// A `findClosestBiome3d` query.
pub const BiomeSearch = struct {
    allowed: *'a dyn Fn([]const u8) -> bool,
    origin: [i32,
    radius: i32,
    horizontal: i32,
    vertical: i32,
    /// `level.getMinY()` and `level.getMaxY()`.
    min_y: i32,
    max_y: i32,
};

/// `Mth.outFromOrigin(origin, lower, upper, step)`.
pub fn out_from_origin(origin: i32, lower: i32, upper: i32, step: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let center = origin.clamp(lower, upper);
    // rust: let mut out = Vec::new();
    // rust: let mut cursor = center;
    // rust: loop {
    // rust: let distance = (center - cursor).abs();
    // rust: if !(center - distance >= lower || center + distance <= upper) {
    // rust: return out;
}
    // rust: out.push(cursor);
    // rust: let negative = cursor <= center;
    // rust: let can_move_positive = center + distance + step <= upper;
    // rust: let mut next = center + distance + step;
    // rust: if !negative || !can_move_positive {
    // rust: let attempt = center - distance - if negative { step } else { 0 };
    // rust: if attempt >= lower {
    // rust: next = attempt;
}
}
    // rust: cursor = next;
}
}

/// `BlockPos.spiralAround(ZERO, radius, EAST, SOUTH)` as (x, z) offsets.
pub fn spiral_around(radius: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
pub const DIRS: [[i32; 2]; 4] = [[1, 0], [0, 1], [-1, 0], [0, -1]];
    // rust: let legs = 4 * radius;
    // rust: let (mut leg, mut leg_size, mut leg_index) = (-1i32, 0i32, 0i32);
    // rust: let mut last = [0, 1];
    // rust: std::iter::from_fn(move || {
    // rust: let d = DIRS[((leg + 4) % 4) as usize];
    // rust: let cursor = [last[0] + d[0], last[1] + d[1]];
    // rust: last = cursor;
    // rust: if leg_index >= leg_size {
    // rust: if leg >= legs {
    // rust: return None;
}
    // rust: leg += 1;
    // rust: leg_index = 0;
    // rust: leg_size = leg / 2 + 1;
}
    // rust: leg_index += 1;
    // rust: Some(cursor)
    // rust: })
}

/// Counters from one FEATURES pass.
pub const DecorateStats = struct {
    /// Placed-feature roots executed (including those that placed nothing).
    placed: usize,
    /// Roots skipped because their algorithm or bindings are not implemented.
    unsupported: usize,
    /// Roots that started but failed on an unavailable world query or error.
    /// Their partial writes are kept, as each root reseeds its own random.
    failed: usize,
    /// Identifiers of skipped or failed roots, for diagnostics.
    skipped: BTreeSet<[]const u8>,
};

/// A seed-bound generator for one dimension, shareable across worker threads.
pub const OverworldGenerator = struct {
    pipeline: *dyn SeededPipeline,
    /// The noise range the settings asked for and the build height's part
    /// of it that generates, when they differ.
    noise_clamped: Option<(NoiseSettings,
};
    // rust: impl OverworldGenerator {
    /// What the shared caches hold, for `horizon-ctl memory`.
pub fn cache_census(self: *Self) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.cache_census()
}
    /// Empty the chunk biome and carver biome caches, while nothing generates:
    /// they keep every chunk generated (up to 16384, 6 KB each) and only spare
    /// computing a chunk's biomes again. The biomes come out the same: the
    /// caches are emptied whole at their limit too.
pub fn release_caches(self: *Self) void {
}
    // rust: self.pipeline.release_caches();
}
    /// The chunks an older version generated, which new chunks blend with
    /// (`Blender.of`); set once, before chunks are generated.
pub fn set_old_world(self: *Self, world: *dyn super::blending::OldWorld) void {
}
    // rust: self.pipeline.set_old_world(world);
}
    /// The `minecraft:overworld` dimension of the `minecraft:normal` world preset.
pub fn new(data: *GeneratorData, seed: i64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::for_dimension(data, seed, "minecraft:normal", "minecraft:overworld")
}
    /// The overworld without structures (no starts, terrain adaptation or
    /// structure pieces), as in a world with structure generation disabled.
pub fn without_structures(data: *GeneratorData, seed: i64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::build(data, seed, "minecraft:normal", "minecraft:overworld", false)
}
    /// Any noise-generator dimension of a bundled world preset.
    // rust: pub fn for_dimension(
    // rust: data: Arc<GeneratorData>,
    // rust: seed: i64,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: ) -> Result<Self, GeneratorError> {
    // rust: Self::build(data, seed, preset, dimension, true)
}
    /// A superflat overworld (`FlatLevelSource`): the layers where the terrain would be, a
    /// fixed biome, and the structure sets `structure_overrides` allows (every one when it
    /// names none) generating on the flat ground, with or without structures.
    // rust: pub fn flat(
    // rust: data: Arc<GeneratorData>,
    // rust: seed: i64,
    // rust: flat: &FlatSettings,
    // rust: structures: bool,
    // rust: ) -> Result<Self, GeneratorError> {
    // rust: let registry = data.registry;
    // rust: let (level_min_y, level_height) = overrides::LevelHeight::of_type(
    // rust: &Value::from("minecraft:overworld"),
    // rust: &data.dimension_types,
    // rust: )
    // rust: .map_or((-64, 384), |h| (h.min_y, h.height));
        // The overworld's own noise settings give the level its sea level and the rest of
        // the generator its data; no noise is ever sampled.
    // rust: let settings_json: Value = serde_json::from_str(
    // rust: data.settings
    // rust: .get("minecraft:overworld")
    // rust: .ok_or_else(|| resource("missing noise settings minecraft:overworld"))?,
    // rust: )?;
        // `Biome.CODEC.lenientOptionalFieldOf("biome")`: an unknown biome is Plains.
    // rust: let biome = if data.biome_id(&flat.biome).is_some() {
    // rust: flat.biome.as_str()
    // rust: } else {
    // rust: "minecraft:plains"
}
    // rust: let generator = serde_json::json!({
    // rust: "type": "minecraft:noise",
    // rust: "settings": "minecraft:overworld",
    // rust: "biome_source": { "type": "minecraft:fixed", "biome": biome },
    // rust: "structure_overrides": flat.structure_overrides,
    // rust: });
    // rust: let mut pipeline = Pipeline::new(
    // rust: data.clone(),
    // rust: seed,
    // rust: XoroshiroRandom::new(seed),
    // rust: &generator,
    // rust: &settings_json,
    // rust: structures,
    // rust: Some((level_min_y, level_height)),
    // rust: )?;
    // rust: let mut states = Vec::new();
    // rust: let mut null = Vec::new();
    // rust: for (block, height) in &flat.layers {
    // rust: let id = registry
    // rust: .default_state(block)
    // rust: .ok_or_else(|| resource(format!("missing block {block}")))?;
            // `adjustGenerationSettings`: a layer that is not opaque to MOTION_BLOCKING is
            // `null` in the layers `FlatLevelSource` reads.
    // rust: let hole = !HeightmapType::MotionBlocking.is_opaque(data.states.get(id));
    // rust: for _ in 0..(*height).max(0) {
    // rust: states.push(id);
    // rust: null.push(hole);
}
}
        // `updateLayers`: `voidGen` when every layer is air (no layers at all, too).
    // rust: let air = registry.default_state("minecraft:air");
    // rust: let void_gen = states.iter().all(|&id| Some(id) == air);
    // rust: states.truncate(level_height.max(0) as usize);
    // rust: null.truncate(states.len());
        // `FlatLevelSource.getSeaLevel`; its minimum Y and depth are in `generation`.
    // rust: pipeline.settings.sea_level = -63;
    // rust: let top_layers: Vec<(i32, BlockStateId)> = null
    // rust: .iter()
    // rust: .zip(&states)
    // rust: .enumerate()
    // rust: .filter(|(_, (hole, _))| **hole)
    // rust: .map(|(i, (_, &state))| (level_min_y + i as i32, state))
    // rust: .collect();
    // rust: pipeline.flat = Some(FlatLayers {
    // rust: min_y: level_min_y,
    // rust: states,
    // rust: null,
    // rust: });
        // `FlatLevelSource` decorates with `adjustGenerationSettings` of the biome.
    // rust: let adjust = super::generator_decoration::FlatDecoration::new(
    // rust: flat.features,
    // rust: flat.lakes,
    // rust: void_gen,
    // rust: biome == "minecraft:the_void",
    // rust: );
    // rust: pipeline.decoration = super::generator_decoration::Decoration::new_with(
    // rust: &data,
    // rust: &pipeline.source,
    // rust: Some(adjust),
    // rust: )?
    // rust: .map(|mut decoration| {
    // rust: decoration.top_layers = top_layers;
    // rust: Arc::new(decoration)
    // rust: });
    // rust: if let (Some(state), Some(only)) = (pipeline.structures.as_mut(), &flat.structure_overrides)
    // rust: {
    // rust: state.restrict_to(only);
}
        // `ChunkGeneratorStructureState.createForFlat`: the stronghold rings use seed 0.
    // rust: if let Some(state) = pipeline.structures.as_mut() {
    // rust: state.ring_seed = Some(0);
}
    // rust: Ok(Self {
    // rust: pipeline: Arc::new(pipeline),
    // rust: noise_clamped: None,
    // rust: })
}
    /// A dimension of a world preset, with or without structures (the
    /// world's `generate_structures`: without, no starts, terrain adaptation,
    /// structure pieces or structure locating).
    // rust: pub fn for_world(
    // rust: data: Arc<GeneratorData>,
    // rust: seed: i64,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: structures: bool,
    // rust: ) -> Result<Self, GeneratorError> {
    // rust: Self::build(data, seed, preset, dimension, structures)
}
    // rust: fn build(
    // rust: data: Arc<GeneratorData>,
    // rust: seed: i64,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: with_structures: bool,
    // rust: ) -> Result<Self, GeneratorError> {
    // rust: Self::for_world_with_settings(data, seed, preset, dimension, with_structures, None)
}
    /// A saved level stem supplies the generator and dimension type when no data
    /// pack replaces that dimension. Worlds without one use the preset's stem.
    // rust: pub fn for_world_with_settings(
    // rust: data: Arc<GeneratorData>,
    // rust: seed: i64,
    // rust: preset: &str,
    // rust: dimension: &str,
    // rust: with_structures: bool,
    // rust: saved_stem: Option<&Value>,
    // rust: ) -> Result<Self, GeneratorError> {
    // rust: let stem = if let Some(json) = data.dimensions.get(dimension) {
    // rust: serde_json::from_str(json)?
    // rust: } else if let Some(stem) = saved_stem {
    // rust: stem.clone()
    // rust: } else {
    // rust: let preset_json: Value = serde_json::from_str(
    // rust: data.world_presets
    // rust: .get(preset)
    // rust: .ok_or_else(|| resource(format!("missing world preset {preset}")))?,
    // rust: )?;
    // rust: preset_json["dimensions"][dimension].clone()
}
    // rust: let generator = stem["generator"].clone();
        // The level's build range: its dimension type's, a data pack's
        // over the vanilla one.
    // rust: let level = overrides::LevelHeight::of_type(&stem["type"], &data.dimension_types)
    // rust: .map(|h| (h.min_y, h.height));
    // rust: if generator["type"].as_str() != Some("minecraft:noise") {
    // rust: return Err(resource(format!("{dimension} is not a noise generator")));
}
    // rust: let mut settings_json: Value = match &generator["settings"] {
    // rust: Value::String(name) => serde_json::from_str(
    // rust: data.settings
    // rust: .get(name)
    // rust: .ok_or_else(|| resource(format!("missing noise settings {name}")))?,
    // rust: )?,
    // rust: inline => inline.clone(),
}
        // NoiseSettings.clampToHeightAccessor: noise past the build height
        // (a data pack's taller terrain over a dimension type it left as it
        // was) fills only the part inside it.
    // rust: let mut noise_clamped = None;
    // rust: if let Some((level_min_y, level_height)) = level
    // rust: && let (Some(min_y), Some(height)) = (
    // rust: settings_json["noise"]["min_y"].as_i64(),
    // rust: settings_json["noise"]["height"].as_i64(),
    // rust: )
    // rust: {
    // rust: let noise = NoiseSettings::new(min_y as i32, height as i32);
    // rust: let clamped = noise.clamp_to_height(level_min_y, level_height);
    // rust: if clamped != noise {
    // rust: settings_json["noise"]["min_y"] = clamped.min_y.into();
    // rust: settings_json["noise"]["height"] = clamped.height.into();
    // rust: noise_clamped = Some((noise, clamped));
}
}
    // rust: let pipeline: Arc<dyn SeededPipeline> = if settings_json["legacy_random_source"]
    // rust: .as_bool()
    // rust: .unwrap_or(false)
    // rust: {
    // rust: Arc::new(Pipeline::new(
    // rust: data,
    // rust: seed,
    // rust: LegacyRandom::new(seed),
    // rust: &generator,
    // rust: &settings_json,
    // rust: with_structures,
    // rust: level,
    // rust: )?)
    // rust: } else {
    // rust: Arc::new(Pipeline::new(
    // rust: data,
    // rust: seed,
    // rust: XoroshiroRandom::new(seed),
    // rust: &generator,
    // rust: &settings_json,
    // rust: with_structures,
    // rust: level,
    // rust: )?)
}
    // rust: Ok(Self {
    // rust: pipeline,
    // rust: noise_clamped,
    // rust: })
}
pub fn data(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.data()
}
    /// The noise range the noise settings asked for and the part of it
    /// inside the dimension's build height, when the settings reach past it.
pub fn noise_clamped(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.noise_clamped
}
    /// The exact `end_island_decorated` origins in a chunk, without terrain.
pub fn end_island_origins(self: *Self, chunk: ChunkPos) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.end_island_origins(chunk)
}
pub fn sea_level(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.sea_level()
}
    /// The dimension's build range (minimum Y, height): what its chunks span.
pub fn level(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.level()
}
    /// Placed features of this dimension's biomes that decoration skips because
    /// their algorithm or bindings are not implemented, with the decode error.
pub fn unsupported_features(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.unsupported_features()
}
    /// NoiseBasedChunkGenerator.getOrigin: the chunk a new world's spawn
    /// search starts from (NoiseSpawnFinder over the `spawn_target` points).
pub fn origin(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [x, z] = self.spawn_position()?;
    // rust: Ok(ChunkPos::new(x >> 4, z >> 4))
}
    /// NoiseSpawnFinder.findSpawnPosition: the column `origin` is the chunk of.
pub fn spawn_position(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.spawn_position()
}
    /// A new `WorldGenRegion` random centred on the chunk: what its generation
    /// steps draw from (`level.getRandom()`).
    // rust: pub fn region_random(
    // rust: &self,
    // rust: center: ChunkPos,
    // rust: ) -> Box<dyn super::structure::legacy::PieceRandom> {
    // rust: self.pipeline.region_random(center)
}
    /// `NoiseBasedChunkGenerator.addDebugScreenInfo`: the `Density` line of
    /// the noise settings' `debug_functions` at the feet (none without them).
    /// It reads the pipeline's samplers only, so it needs no worker.
pub fn debug_density_line(self: *Self, feet: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.debug_density_line(feet)
}
    /// Create per-thread state. Workers are cheap; keep one per thread.
pub fn worker(self: *Self) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = self.pipeline.data();
    // rust: GeneratorWorker {
    // rust: pipeline: self.pipeline.clone(),
    // rust: state: WorkerState {
    // rust: temperatures: data
    // rust: .temperatures
    // rust: .iter()
    // rust: .map(|s| BiomeTemperature::new(*s))
    // rust: .collect(),
    // rust: terrain_context: SamplerContext::cached(),
    // rust: biome_context: SamplerContext::cached(),
    // rust: carver_context: SamplerContext::default(),
    // rust: carver_biomes: HashMap::new(),
    // rust: structure_biomes: HashMap::new(),
    // rust: timings: StageTimings::default(),
    // rust: structures_only: false,
    // rust: structure_mobs: None,
    // rust: heights: HashMap::new(),
    // rust: surface_rule: None,
    // rust: },
}
}
}

/// A surface-only noise column for far terrain. Heights are exclusive top faces.
pub const SurfaceSample = struct {
    height: i32,
    state: BlockStateId,
    water: Option<(i32,
    biome: BiomeId,
};

    // rust: pub type LodColumn = (Option<SurfaceSample>, Vec<(i32, i32, BlockStateId)>);

/// Per-thread generation state.
pub const GeneratorWorker = struct {
    pipeline: *dyn SeededPipeline,
    state: WorkerState,
};
    // rust: impl GeneratorWorker {
    /// Biomes, noise fill and aquifers, material surface and carvers: the
    /// vanilla statuses up to TERRAIN. Independent of neighbor chunks' state.
pub fn generate_proto(self: *Self, pos: ChunkPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let result = self.pipeline.generate(&mut self.state, pos);
    // rust: self.state.timings.chunks += 1;
    // rust: result
}
    /// Noise/aquifer surface and its material rule, without chunks, structures or features.
pub fn surface_sample(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.surface_sample(&mut self.state, x, z, None)
}
    /// Noise/aquifer material runs, excluding air; bounds are half-open.
    /// Features and carvers still require generated chunks.
    // rust: pub fn surface_column(
    // rust: &mut self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> (Option<SurfaceSample>, Vec<(i32, i32, BlockStateId)>) {
    // rust: let mut spans = Vec::new();
    // rust: let surface = self
    // rust: .pipeline
    // rust: .surface_sample(&mut self.state, x, z, Some(&mut spans));
    // rust: (surface, spans)
}
    /// `/locate structure`: the nearest start of one of `names`.
    // rust: pub fn locate(
    // rust: &mut self,
    // rust: names: &[String],
    // rust: from: [i32; 3],
    // rust: radius: i32,
    // rust: ) -> Option<(String, [i32; 3])> {
    // rust: self.locate_skipping(names, from, radius, &|_, _| false)
}
    /// `ChunkGenerator.findNearestMapStructure`: like `locate`, past the
    /// starts `skip` says can't be referenced again (an explorer map that
    /// skips known structures).
    // rust: pub fn locate_skipping(
    // rust: &mut self,
    // rust: names: &[String],
    // rust: from: [i32; 3],
    // rust: radius: i32,
    // rust: skip: &dyn Fn(&str, ChunkPos) -> bool,
    // rust: ) -> Option<(String, [i32; 3])> {
    // rust: self.pipeline
    // rust: .locate(&mut self.state, names, from, radius, skip)
}
    /// Direct far sampling: work scales with rendered vertical resolution,
    /// without allocating chunks, carving masks or propagated aquifers.
    /// `approximate` (Reduced far detail) trades the exact tile for speed in
    /// wide cells: one biome per 4x4 columns, a coarser vertical lattice, and
    /// density only around the surface.
    // rust: pub fn lod_grid(
    // rust: &mut self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: width: i32,
    // rust: side: usize,
    // rust: approximate: bool,
    // rust: ) -> Result<Vec<LodColumn>, GeneratorError> {
    // rust: self.pipeline
    // rust: .lod_grid(&mut self.state, x, z, width, side, approximate)
}
pub fn noise_biomes(self: *Self, quarts: *[[i32; 3]]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.noise_biomes(&mut self.state, quarts)
}
    /// `NoiseBasedChunkGenerator.addDebugScreenInfo`: the `Density` line of
    /// the noise settings' `debug_functions` at the feet (none without them).
pub fn debug_density_line(self: *Self, feet: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.debug_density_line(feet)
}
    /// `BiomeSource.findClosestBiome3d`: the first sampled position whose
    /// noise biome passes `allowed`, spiralling out from the origin.
pub fn find_closest_biome(self: *Self, search: *BiomeSearch<'_>) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.find_closest_biome(&mut self.state, search)
}
    /// `JigsawPlacement.addPieces` for `/place jigsaw`, drawing from the
    /// generation context's random (level seed and the position's chunk).
pub fn jigsaw_pieces(self: *Self, query: *JigsawQuery<'_>) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.jigsaw_pieces(&mut self.state, query)
}
    /// ConcentricRingsStructurePlacement chunks of a structure set (such as
    /// `minecraft:strongholds`), searched for now if nothing needed them yet.
pub fn ring_positions(self: *Self, set: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.ring_positions(&mut self.state, set)
}
    /// STRUCTURE_STARTS: the structure starts owned by a chunk (cached).
    // rust: pub fn structure_starts(
    // rust: &mut self,
    // rust: pos: ChunkPos,
    // rust: ) -> Vec<Arc<super::structure::start::StructureStart>> {
    // rust: self.pipeline.structure_starts(&mut self.state, pos)
}
    /// `Structure.generate` for `/place structure`: the start `structure`
    /// builds in `chunk`, whatever its placement set says about that chunk.
    // rust: pub fn structure_start(
    // rust: &mut self,
    // rust: structure: &str,
    // rust: chunk: ChunkPos,
    // rust: ) -> Option<Arc<super::structure::start::StructureStart>> {
    // rust: self.pipeline
    // rust: .structure_start(&mut self.state, structure, chunk)
}
    /// Puts a saved start of `structure` (its pieces as a save lists them, in
    /// JSON) in `chunk`, in place of the one generation builds there, until
    /// the starts are forgotten. Harnesses place another game's layout.
    // rust: pub fn use_saved_start(
    // rust: &mut self,
    // rust: chunk: ChunkPos,
    // rust: structure: &str,
    // rust: pieces: &[serde_json::Value],
    // rust: ) -> Result<(), String> {
    // rust: (self.pipeline).use_saved_start(&mut self.state, chunk, structure, pieces)
}
    /// Forget the cached structure starts: chunks generated afterwards get
    /// fresh starts, as in a new level that has not loaded the old chunks.
pub fn forget_structure_starts(self: *Self) void {
}
    // rust: self.pipeline.forget_structure_starts();
}
pub fn may_start_answers(self: *Self, chunk: ChunkPos) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.pipeline.may_start_answers(&mut self.state, chunk)
}
pub fn stage_timings(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state.timings
}
    /// FEATURES status for `region[4]`. The region is a 3×3 neighborhood in
    /// row-major order: index `(dz + 1) * 3 + (dx + 1)` around the center.
    /// Writes may reach the neighbors, as in vanilla. Unsupported features are
    /// skipped and counted. On error, chunks keep partial writes.
    // rust: pub fn decorate(
    // rust: &mut self,
    // rust: region: &mut [ProtoChunk; 9],
    // rust: ) -> Result<DecorateStats, GeneratorError> {
    // rust: self.pipeline.decorate(&mut self.state, region)
}
    /// Skip placed features when decorating and keep structure pieces only
    /// (for structure placement parity checks).
pub fn set_structures_only(self: *Self, only: bool) void {
}
    // rust: self.state.structures_only = only;
}
pub fn set_structure_mobs(self: *Self, mobs: *dyn StructureMobs) void {
}
    // rust: self.state.structure_mobs = Some(mobs);
}
    /// Give back the density scratch buffers and the lookup caches, which only
    /// speed up the next chunks (a generating worker holds megabytes of them).
    /// Results do not change: they are made again on demand.
pub fn release(self: *Self) void {
}
    // rust: let state = &mut self.state;
    // rust: for context in [
    // rust: &mut state.terrain_context,
    // rust: &mut state.biome_context,
    // rust: &mut state.carver_context,
    // rust: ] {
    // rust: context.clear_scratch();
}
    // rust: state.carver_biomes = HashMap::new();
    // rust: state.structure_biomes = HashMap::new();
    // rust: state.heights = HashMap::new();
}
}

    // rust: mod tests {
//     use super::*;
pub fn settings_default_states_read_the_26_3_block_state_form() void {
}
    // rust: let facts = br#"{"states": [
    // rust: ["minecraft:stone", false, false, "x", "minecraft:stone"],
    // rust: ["minecraft:jigsaw", false, false, "x", {"id": "minecraft:jigsaw", "properties": {"orientation": "north_up"}}],
    // rust: ["minecraft:jigsaw", false, false, "x", {"id": "minecraft:jigsaw", "properties": {"orientation": "down_north"}}]
    // rust: ], "defaults": {"minecraft:stone": 0, "minecraft:jigsaw": 1}}"#;
    // rust: let (registry, _) = BlockRegistry::from_facts_json_bytes(facts).unwrap();
    // rust: let codec =
    // rust: crate::registry::BlockStateJsonCodec::new(&registry, Default::default()).unwrap();
    // rust: let read = |raw: Value| state(&codec, &raw).map(|id| id.0);
    // rust: assert_eq!(read(Value::from("minecraft:stone")).unwrap(), 0);
    // rust: assert_eq!(
    // rust: read(serde_json::json!({"id": "minecraft:jigsaw", "properties": {"orientation": "down_north"}}))
    // rust: .unwrap(),
    // rust: 2
    // rust: );
    // rust: assert_eq!(
    // rust: read(serde_json::json!({"id": "minecraft:jigsaw"})).unwrap(),
    // rust: 1
    // rust: );
    // rust: assert!(read(serde_json::json!({"properties": {}})).is_err());
}
pub fn pack_tags_join_the_prepared_ones_and_broken_ones_are_dropped() void {
}
    // rust: let raw = Bundle::from([(
    // rust: "minecraft:hill".to_owned(),
    // rust: r#"{"values":["minecraft:a"]}"#.to_owned(),
    // rust: )]);
    // rust: let known = |id: &str| id != "minecraft:gone";
    // rust: let mut ov = WorldgenOverrides::default();
    // rust: ov.add_tag(
    // rust: "biome_tags",
    // rust: "minecraft:hill",
    // rust: "file/p",
    // rust: r#"{"values":["minecraft:b"]}"#.into(),
    // rust: );
    // rust: ov.add_tag(
    // rust: "biome_tags",
    // rust: "p:broken",
    // rust: "file/p",
    // rust: r#"{"values":["minecraft:gone"]}"#.into(),
    // rust: );
    // rust: let mut dropped = Vec::new();
    // rust: let tags = build_tags(&raw, &ov, "biome_tags", &mut dropped, known).unwrap();
    // rust: assert_eq!(tags["minecraft:hill"], ["minecraft:a", "minecraft:b"]);
    // rust: assert!(!tags.contains_key("p:broken"));
    // rust: assert_eq!(dropped.len(), 1, "{dropped:?}");
    // rust: assert!(dropped[0].contains("p:broken"));
        // Without packs the prepared tags must all resolve.
    // rust: let broken = Bundle::from([(
    // rust: "p:broken".to_owned(),
    // rust: r#"{"values":["minecraft:gone"]}"#.to_owned(),
    // rust: )]);
    // rust: let none = WorldgenOverrides::default();
    // rust: assert!(build_tags(&broken, &none, "biome_tags", &mut dropped, known).is_err());
}
pub fn a_pack_level_stem_names_taller_noise_which_clamps_to_the_build_height() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return;
}
    // rust: let registry = Box::leak(Box::new(crate::level::data::load_registry(&root).unwrap()));
    // rust: let dir = root.join("worldgen");
    // rust: let vanilla = GeneratorData::load(&dir, registry).unwrap();
    // rust: let mut settings: Value =
    // rust: serde_json::from_str(&vanilla.settings["minecraft:overworld"]).unwrap();
    // rust: settings["noise"]["height"] = 2096.into();
    // rust: let preset: Value =
    // rust: serde_json::from_str(&vanilla.world_presets["minecraft:normal"]).unwrap();
    // rust: let mut stem = preset["dimensions"]["minecraft:overworld"].clone();
    // rust: stem["generator"]["settings"] = "horizon:tall".into();
    // rust: let mut ov = WorldgenOverrides::default();
    // rust: ov.set("settings", "horizon:tall", settings.to_string());
    // rust: ov.set(
    // rust: overrides::DIMENSIONS,
    // rust: "minecraft:overworld",
    // rust: stem.to_string(),
    // rust: );
    // rust: let packed = GeneratorData::load_with(&dir, registry, &ov).unwrap();
    // rust: assert!(packed.warnings().is_empty(), "{:?}", packed.warnings());
    // rust: let (asked, kept) = OverworldGenerator::new(packed, 0)
    // rust: .unwrap()
    // rust: .noise_clamped()
    // rust: .expect("the pack's noise reaches past the build height");
    // rust: assert_eq!((asked.min_y, asked.height), (-64, 2096));
    // rust: assert_eq!((kept.min_y, kept.height), (-64, 384));
    // rust: let plain = OverworldGenerator::new(vanilla, 0).unwrap();
    // rust: assert!(plain.noise_clamped().is_none());
}
pub fn end_identity_surface_matches_normal_surface_and_rejects_custom_rules() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return;
}
    // rust: let registry = Box::leak(Box::new(crate::level::data::load_registry(&root).unwrap()));
    // rust: let data = GeneratorData::load(&root.join("worldgen"), registry).unwrap();
    // rust: let preset: Value = serde_json::from_str(&data.world_presets["minecraft:normal"]).unwrap();
    // rust: let settings: Value = serde_json::from_str(&data.settings["minecraft:end"]).unwrap();
    // rust: let mut pipeline = Pipeline::new(
    // rust: data.clone(),
    // rust: 12345,
    // rust: LegacyRandom::new(12345),
    // rust: &preset["dimensions"]["minecraft:the_end"]["generator"],
    // rust: &settings,
    // rust: false,
    // rust: None,
    // rust: )
    // rust: .unwrap();
    // rust: let mut worker = OverworldGenerator::for_world(
    // rust: data.clone(),
    // rust: 12345,
    // rust: "minecraft:normal",
    // rust: "minecraft:the_end",
    // rust: false,
    // rust: )
    // rust: .unwrap()
    // rust: .worker();
    // rust: assert!(pipeline.identity_end_surface(ChunkPos::new(0, 0)));
    // rust: for pos in [
    // rust: ChunkPos::new(0, 0),
    // rust: ChunkPos::new(128, 128),
    // rust: ChunkPos::new(-128, 192),
    // rust: ChunkPos::new(1_875_000, -1_875_000),
    // rust: ] {
    // rust: let actual = pipeline.generate(&mut worker.state, pos).unwrap();
    // rust: let rule = pipeline.rule.clone();
            // A singleton sequence evaluates the same block rule through the full surface path.
    // rust: pipeline.rule = MaterialRule::Sequence(vec![rule.clone()]);
    // rust: assert!(!pipeline.identity_end_surface(ChunkPos::new(0, 0)));
    // rust: let expected = pipeline.generate(&mut worker.state, pos).unwrap();
    // rust: pipeline.rule = rule;
    // rust: assert_eq!(
    // rust: actual.terrain.generation_stage(),
    // rust: expected.terrain.generation_stage()
    // rust: );
    // rust: for section in 0..actual.terrain.height() as usize / 16 {
    // rust: assert_eq!(
    // rust: actual.terrain.section(section).unwrap().to_nbt().unwrap(),
    // rust: expected.terrain.section(section).unwrap().to_nbt().unwrap()
    // rust: );
}
    // rust: for kind in HeightmapType::ALL {
    // rust: assert_eq!(
    // rust: actual.terrain.heightmap(kind).map(|m| m.raw_data()),
    // rust: expected.terrain.heightmap(kind).map(|m| m.raw_data())
    // rust: );
}
    // rust: assert_eq!(
    // rust: actual.terrain.postprocessing(),
    // rust: expected.terrain.postprocessing()
    // rust: );
    // rust: assert_eq!(
    // rust: actual.terrain.block_ticks().pack(0),
    // rust: expected.terrain.block_ticks().pack(0)
    // rust: );
    // rust: assert_eq!(
    // rust: actual.terrain.fluid_ticks().pack(0),
    // rust: expected.terrain.fluid_ticks().pack(0)
    // rust: );
    // rust: assert_eq!(actual.block_entities, expected.block_entities);
    // rust: assert_eq!(actual.entities, expected.entities);
    // rust: assert_eq!(actual.structures(), expected.structures());
}
    // rust: assert!(!pipeline.identity_end_surface(ChunkPos::new(i32::MAX, 0)));
    // rust: let old_rule = pipeline.rule.clone();
    // rust: pipeline.rule = MaterialRule::Block(registry.default_state("minecraft:stone").unwrap());
    // rust: assert!(!pipeline.identity_end_surface(ChunkPos::new(0, 0)));
    // rust: pipeline.rule = old_rule;
    // rust: let old_fluid = pipeline.settings.default_fluid;
    // rust: pipeline.settings.default_fluid = registry.default_state("minecraft:stone").unwrap();
    // rust: assert!(!pipeline.identity_end_surface(ChunkPos::new(0, 0)));
    // rust: pipeline.settings.default_fluid = old_fluid;
    // rust: let old_source = std::mem::replace(
    // rust: &mut pipeline.source,
    // rust: ResolvedBiomeSource::Fixed(super::super::biome_source::FixedBiomeSource {
    // rust: biome: "minecraft:the_end".into(),
    // rust: }),
    // rust: );
    // rust: assert!(!pipeline.identity_end_surface(ChunkPos::new(0, 0)));
    // rust: pipeline.source = old_source;
    // rust: pipeline.aquifer = Some(std::array::from_fn(|_| {
    // rust: pipeline.router.get(RouterField::Erosion).clone()
    // rust: }));
    // rust: assert!(!pipeline.identity_end_surface(ChunkPos::new(0, 0)));
}

pub fn uniform_surface_biomes_preserve_zoom_and_missing_corner_errors() void {
}
//         use super::super::biome_chunk::BiomeChunk;
//         use std::convert::Infallible;

    // rust: for pos in [
    // rust: ChunkPos::new(0, 0),
    // rust: ChunkPos::new(-17, 23),
    // rust: ChunkPos::new(i32::MIN >> 4, i32::MAX >> 4),
    // rust: ] {
    // rust: for seed in [0, -1, i64::MIN] {
    // rust: for mixed in [false, true] {
    // rust: let mut chunks = Vec::new();
    // rust: for dz in -1..=1 {
    // rust: for dx in -1..=1 {
    // rust: let mut chunk = BiomeChunk::new(
    // rust: ChunkPos::new(pos.x + dx, pos.z + dz),
    // rust: -64,
    // rust: 128,
    // rust: BiomeId(7),
    // rust: )
    // rust: .unwrap();
    // rust: chunk
    // rust: .fill(-64, 63, |[x, y, z]| {
    // rust: Ok::<_, Infallible>(if mixed {
    // rust: BiomeId(
    // rust: (x.div_euclid(3) + y.div_euclid(4) + z.div_euclid(2))
    // rust: .rem_euclid(5)
    // rust: as u32,
    // rust: )
    // rust: } else {
    // rust: BiomeId(7)
    // rust: })
    // rust: })
    // rust: .unwrap();
    // rust: chunks.push(chunk);
}
}
    // rust: let region = BiomeRegion::new(chunks, seed).unwrap();
    // rust: let mut cache = UniformSurfaceBiomes::new(pos, -64, 128);
    // rust: let mut hits = 0;
    // rust: for x in 0..16 {
    // rust: for z in 0..16 {
                            // Include clamped Y, out-of-cache Y, and revisit each
                            // cached proof in the ordinary descending traversal.
    // rust: for y in (-70..70).rev() {
    // rust: let p = BlockPos::new(pos.x * 16 + x, y, pos.z * 16 + z);
    // rust: let shortcut = cache.get(&region, p);
    // rust: hits += usize::from(shortcut.is_some());
    // rust: let actual = shortcut.map_or_else(|| region.biome(p).copied(), Ok);
    // rust: assert_eq!(actual, region.biome(p).copied());
}
}
}
    // rust: if !mixed && pos.x != i32::MIN >> 4 {
    // rust: assert!(hits > 0);
}
}
}
}

        // Some unselected corners are missing. Probing them must neither invent
        // an error nor hide the original selected-corner error.
    // rust: let pos = ChunkPos::new(0, 0);
    // rust: let region =
    // rust: BiomeRegion::new(vec![BiomeChunk::new(pos, 0, 16, BiomeId(7)).unwrap()], -1).unwrap();
    // rust: let mut cache = UniformSurfaceBiomes::new(pos, 0, 16);
    // rust: let mut successes = 0;
    // rust: let mut failures = 0;
    // rust: for x in -2..18 {
    // rust: for z in -2..18 {
    // rust: let p = BlockPos::new(x, 7, z);
    // rust: let actual = cache
    // rust: .get(&region, p)
    // rust: .map_or_else(|| region.biome(p).copied(), Ok);
    // rust: assert_eq!(actual, region.biome(p).copied());
    // rust: successes += usize::from(actual.is_ok());
    // rust: failures += usize::from(actual.is_err());
}
}
    // rust: assert!(successes > 0 && failures > 0);
}

    /// Reduced far detail paints only the top two blocks of a wide column
    /// (`material_depth`). Vanilla's surface rules reach eight blocks down, so
    /// Full detail layers dirt under grass; a tile 256 blocks across draws at
    /// most a block or two of each column's face, so Reduced leaves the rest as
    /// the default block. The second half of this test samples the same tile at
    /// Full detail to prove the first half is discriminating, not vacuous.
pub fn reduced_far_detail_paints_only_the_top_of_a_wide_column() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .or_else(|| std::env::var_os("HORIZON_RESOURCES"))
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return;
}
    // rust: let registry: &'static BlockRegistry = Box::leak(Box::new(
    // rust: crate::level::data::load_registry(&root).expect("registry"),
    // rust: ));
    // rust: let data = GeneratorData::load(&root.join("worldgen"), registry).expect("worldgen data");
    // rust: let generator = OverworldGenerator::without_structures(data, 1234).expect("generator");
    // rust: let mut worker = generator.worker();
        // The block a column holds at `y`, where its spans cover it.
    // rust: let at = |spans: &[(i32, i32, BlockStateId)], y: i32| {
    // rust: spans
    // rust: .iter()
    // rust: .find(|&&(low, high, _)| low <= y && y < high)
    // rust: .map(|&(_, _, state)| state)
}
        // Two depths inside the eight vanilla rules reach, both below the two
        // Reduced keeps. Only columns whose spans cover both are compared, so a
        // cave or an overhang between them is never read as a painted layer.
    // rust: let layered = |grid: &[LodColumn]| {
    // rust: let mut compared = 0;
    // rust: let mut differing = 0;
    // rust: for (surface, spans) in grid {
    // rust: let Some(surface) = surface else { continue };
    // rust: let (Some(shallow), Some(deep)) =
    // rust: (at(spans, surface.height - 4), at(spans, surface.height - 8))
    // rust: else {
    // rust: continue;
}
    // rust: compared += 1;
    // rust: differing += usize::from(shallow != deep);
}
    // rust: (compared, differing)
}
        // 16 columns 16 blocks apart: a level 4 tile, which the gate covers.
    // rust: let (compared, differing) = layered(&worker.lod_grid(0, 0, 16, 16, true).expect("reduced"));
    // rust: assert!(compared > 64, "only {compared} columns to compare");
    // rust: assert_eq!(
    // rust: differing, 0,
    // rust: "{differing} of {compared} reduced columns still carry a painted layer below depth 2"
    // rust: );
    // rust: let (compared, differing) = layered(&worker.lod_grid(0, 0, 16, 16, false).expect("full"));
    // rust: assert!(compared > 64, "only {compared} columns to compare");
    // rust: assert!(
    // rust: differing > 0,
    // rust: "Full detail painted no layer below depth 2 either, so the check above proves nothing"
    // rust: );
}
pub fn far_surface_matches_undecorated_land_and_keeps_end_void() void {
}
    // rust: let root = std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .or_else(|| std::env::var_os("HORIZON_RESOURCES"))
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return;
}
    // rust: let registry: &'static BlockRegistry = Box::leak(Box::new(
    // rust: crate::level::data::load_registry(&root).expect("registry"),
    // rust: ));
    // rust: let data = GeneratorData::load(&root.join("worldgen"), registry).expect("worldgen data");
    // rust: let generator =
    // rust: OverworldGenerator::without_structures(data.clone(), 1234).expect("generator");
    // rust: let mut worker = generator.worker();
    // rust: let sample = worker.surface_sample(0, 0).expect("land");
    // rust: let (column_surface, spans) = worker.surface_column(0, 0);
    // rust: let column_surface = column_surface.expect("column land");
    // rust: assert_eq!(column_surface.height, sample.height);
    // rust: assert_eq!(column_surface.state, sample.state);
    // rust: assert_eq!(column_surface.water, sample.water);
    // rust: assert_eq!(column_surface.biome, sample.biome);
    // rust: assert!(spans.iter().all(|&(min, max, state)| {
    // rust: min < max && !generator.data().block_states().get(state).is_air()
    // rust: }));
    // rust: assert!(spans.windows(2).all(|pair| {
    // rust: pair[1].1 <= pair[0].0 && (pair[1].1 != pair[0].0 || pair[1].2 != pair[0].2)
    // rust: }));
    // rust: assert!(spans.iter().any(|&(min, max, state)| {
    // rust: min < sample.height && sample.height - 1 < max && state == sample.state
    // rust: }));
    // rust: assert!(sample.water.is_some_and(|(height, state)| {
    // rust: spans
    // rust: .iter()
    // rust: .any(|&(min, max, block)| min < height && height - 1 < max && block == state)
    // rust: }));
    // rust: let chunk = worker.generate_proto(ChunkPos::new(0, 0)).expect("terrain");
    // rust: assert_eq!(
    // rust: sample.water.map_or(sample.height, |(height, _)| height),
    // rust: chunk.surface_height(0, 0)
    // rust: );
    // rust: assert_eq!(sample.state, chunk.block(0, sample.height - 1, 0));
    // rust: assert!(
    // rust: sample.water.is_some(),
    // rust: "fixture includes underwater terrain"
    // rust: );
    // rust: let started = std::time::Instant::now();
    // rust: let mut exact = Vec::new();
    // rust: for z in 0..8 {
    // rust: for x in 0..8 {
    // rust: exact.push(worker.surface_column(-1024 + x * 32, z * 32));
}
}
    // rust: let dense_time = started.elapsed();
    // rust: let started = std::time::Instant::now();
    // rust: let direct = worker.lod_grid(-1024, 0, 32, 8, false).unwrap();
    // rust: for z in 0..8 {
    // rust: for x in 0..8 {
    // rust: let wx = -1024 + x * 32;
    // rust: let wz = z * 32;
    // rust: let (surface, spans) = &direct[(z * 8 + x) as usize];
    // rust: let expected = exact[(z * 8 + x) as usize].0;
    // rust: if let (Some(surface), Some(expected)) = (surface, expected) {
    // rust: assert!(
    // rust: (surface.height - expected.height).abs() <= 32,
    // rust: "coarse height exceeds its vertical resolution at {wx} {wz}: {} vs {}",
    // rust: surface.height,
    // rust: expected.height
    // rust: );
    // rust: assert!(spans.iter().any(|&(min, max, state)| min < surface.height
    // rust: && surface.height - 1 < max
    // rust: && state == surface.state));
}
    // rust: assert!(spans.iter().all(|&(min, max, _)| min < max));
    // rust: assert!(spans.windows(2).all(|pair| pair[1].1 <= pair[0].0));
}
}
    // rust: eprintln!(
    // rust: "64 far columns: dense={dense_time:?}, direct32={:?}",
    // rust: started.elapsed()
    // rust: );
    // rust: let end =
    // rust: OverworldGenerator::for_dimension(data, 1234, "minecraft:normal", "minecraft:the_end")
    // rust: .expect("End generator");
    // rust: let mut worker = end.worker();
    // rust: assert!(worker.surface_sample(0, 0).is_some());
    // rust: assert!(worker.surface_sample(256, 0).is_none());
    // rust: let (surface, spans) = worker.surface_column(256, 0);
    // rust: assert!(surface.is_none());
    // rust: assert!(spans.is_empty());
    // rust: let (surface, spans) = worker
    // rust: .lod_grid(256, 0, 32, 1, false)
    // rust: .unwrap()
    // rust: .pop()
    // rust: .unwrap();
    // rust: assert!(
    // rust: surface.is_none() && spans.is_empty(),
    // rust: "direct sampling retains End void"
    // rust: );
}

pub fn local_carver_cache_is_worker_owned_and_eviction_preserves_terrain() void {
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return;
}
    // rust: let registry = Box::leak(Box::new(
    // rust: crate::level::data::load_registry(&root).expect("registry"),
    // rust: ));
    // rust: let data = GeneratorData::load(&root.join("worldgen"), registry).unwrap();
    // rust: let generator = OverworldGenerator::new(data.clone(), 12345).unwrap();
    // rust: let mut first = generator.worker();
    // rust: let mut second = generator.worker();
    // rust: let pos = ChunkPos::new(0, 0);
    // rust: let before = first.generate_proto(pos).unwrap();
    // rust: assert!(!first.state.carver_biomes.is_empty());
    // rust: assert!(second.state.carver_biomes.is_empty());
    // rust: second.generate_proto(pos).unwrap();
    // rust: assert_eq!(first.state.carver_biomes, second.state.carver_biomes);
    // rust: let expected = first.state.carver_biomes.clone();
    // rust: first.state.carver_biomes.clear();
        // Fill unrelated origins to force eviction on the next local miss.
    // rust: for x in 0..4096 {
    // rust: first.state.carver_biomes.insert((x, 100_000), BiomeId(0));
}
    // rust: let after = first.generate_proto(pos).unwrap();
    // rust: assert_eq!(first.state.carver_biomes, expected);
    // rust: for y in -64..320 {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: assert_eq!(before.block(x, y, z), after.block(x, y, z));
    // rust: assert_eq!(before.biome_id_at(x, y, z), after.biome_id_at(x, y, z));
}
}
}
    // rust: assert!(
    // rust: OverworldGenerator::new(data, -1)
    // rust: .unwrap()
    // rust: .worker()
    // rust: .state
    // rust: .carver_biomes
    // rust: .is_empty()
    // rust: );
    // rust: assert_eq!(second.state.carver_biomes, expected);
}

    /// The prepared worldgen data, if this checkout has it.
pub fn prepared_data() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return None;
}
    // rust: let registry: &'static BlockRegistry = Box::leak(Box::new(
    // rust: crate::level::data::load_registry(&root).expect("registry"),
    // rust: ));
    // rust: Some(GeneratorData::load(&root.join("worldgen"), registry).expect("worldgen data"))
}

    /// A superflat world decorates with what `adjustGenerationSettings` keeps of its biome
    /// (26.3 bytecode): the lava lakes of `createLakesList` in the lakes step (0 and 1) when
    /// `lakes` is on; the biome's own features with `features` on, but those of the two
    /// structure steps (plains' monster rooms are underground structures); nothing of the
    /// biome when every layer is air, unless the biome is the_void.
pub fn a_superflat_world_keeps_what_adjust_generation_settings_keeps() void {
}
    // rust: let Some(data) = prepared_data() else {
    // rust: return;
}
//         use super::super::generator_decoration::{Decoration, FlatDecoration};
    // rust: let plains = ResolvedBiomeSource::Fixed(super::super::biome_source::FixedBiomeSource {
    // rust: biome: "minecraft:plains".into(),
    // rust: });
    // rust: let kept = |layer: &str, features, lakes, name: &str| {
    // rust: let void_gen = layer == "minecraft:air";
    // rust: let adjust = FlatDecoration::new(features, lakes, void_gen, false);
    // rust: let decoration = Decoration::new_with(&data, &plains, Some(adjust))
    // rust: .unwrap()
    // rust: .expect("decoration");
    // rust: decoration.seed(name).map(|(_, index, step)| (index, step))
}
    // rust: let grass = "minecraft:grass_block";
        // The Overworld preset: lakes and features.
    // rust: assert_eq!(
    // rust: kept(grass, true, true, "minecraft:lake_lava_underground"),
    // rust: Some((0, 1))
    // rust: );
    // rust: assert_eq!(
    // rust: kept(grass, true, true, "minecraft:lake_lava_surface"),
    // rust: Some((1, 1))
    // rust: );
    // rust: assert_eq!(
    // rust: kept(grass, true, true, "minecraft:trees_plains").map(|s| s.1),
    // rust: Some(9)
    // rust: );
    // rust: assert_eq!(
    // rust: kept(grass, true, true, "minecraft:freeze_top_layer").map(|s| s.1),
    // rust: Some(10)
    // rust: );
    // rust: assert_eq!(kept(grass, true, true, "minecraft:monster_room"), None);
        // Lakes alone: no tree, no flower, no ore.
    // rust: assert_eq!(
    // rust: kept(grass, false, true, "minecraft:lake_lava_surface"),
    // rust: Some((1, 1))
    // rust: );
    // rust: assert_eq!(kept(grass, false, true, "minecraft:trees_plains"), None);
    // rust: assert_eq!(kept(grass, false, true, "minecraft:ore_iron_upper"), None);
        // Features alone: plains' own lakes step stays.
    // rust: assert_eq!(
    // rust: kept(grass, true, false, "minecraft:lake_lava_surface").map(|s| s.1),
    // rust: Some(1)
    // rust: );
    // rust: assert_eq!(
    // rust: kept(grass, true, false, "minecraft:ore_iron_upper").map(|s| s.1),
    // rust: Some(6)
    // rust: );
        // Neither: the steps run for structures, with no feature in them.
    // rust: assert_eq!(
    // rust: kept(grass, false, false, "minecraft:lake_lava_surface"),
    // rust: None
    // rust: );
        // Every layer air (`voidGen`) and a biome other than the_void: no biome features.
    // rust: assert_eq!(
    // rust: kept("minecraft:air", true, false, "minecraft:trees_plains"),
    // rust: None
    // rust: );
}

    /// Seed 1234's strongholds where vanilla 26.3 puts them
    /// (VanillaStructureStartOracle with HORIZON_RINGS). Each search sampled
    /// its quarts through fresh resolvers, which broke climate ties their own
    /// way: three of the 128 were up to 6 chunks off.
pub fn stronghold_rings_match_vanilla() void {
}
    // rust: let Some(data) = prepared_data() else {
    // rust: return;
}
    // rust: let generator = OverworldGenerator::new(data, 1234).expect("generator");
    // rust: let rings = generator
    // rust: .worker()
    // rust: .ring_positions("minecraft:strongholds")
    // rust: .expect("ring positions");
    // rust: assert_eq!(rings.len(), 128);
    // rust: for (i, x, z) in [
    // rust: (0, -100, -125),
    // rust: (1, 131, -12),
    // rust: (111, 1190, -560),
    // rust: (113, 1305, -112),
    // rust: ] {
    // rust: assert_eq!(rings[i], ChunkPos::new(x, z), "stronghold {i}");
}
}

    /// Seed 8675309's giant ruined portal starts in chunk (-26, 23) and lies
    /// wholly in (-26, 24): its own chunk still holds the start, as vanilla's
    /// getAllStarts does, though no piece reaches it.
pub fn a_chunk_holds_its_starts_whose_pieces_lie_elsewhere() void {
}
    // rust: let Some(data) = prepared_data() else {
    // rust: return;
}
    // rust: let generator = OverworldGenerator::new(data, 8675309).expect("generator");
    // rust: let mut worker = generator.worker();
    // rust: let proto = worker
    // rust: .generate_proto(ChunkPos::new(-26, 23))
    // rust: .expect("proto");
    // rust: let own: Vec<_> = proto.own_starts().iter().map(|s| s.name.clone()).collect();
    // rust: assert!(
    // rust: own.iter().any(|n| n == "minecraft:ruined_portal_mountain"),
    // rust: "{own:?}"
    // rust: );
}

    /// Chunks no ring search can end near are decided without the rings,
    /// which stay unsearched, and get the starts they get with them.
pub fn chunks_far_from_the_rings_do_not_search_them() void {
}
    // rust: let Some(data) = prepared_data() else {
    // rust: return;
}
    // rust: let generator = OverworldGenerator::new(data.clone(), 4321).expect("generator");
    // rust: let mut worker = generator.worker();
    // rust: let summary = |worker: &mut GeneratorWorker, c: ChunkPos| -> Vec<(String, i32, i32)> {
    // rust: worker
    // rust: .structure_starts(c)
    // rust: .iter()
    // rust: .map(|s| (s.name.clone(), s.chunk.x, s.chunk.z))
    // rust: .collect()
}
    // rust: let chunks: Vec<ChunkPos> = (-24..=24)
    // rust: .step_by(3)
    // rust: .flat_map(|x| (-24..=24).step_by(3).map(move |z| ChunkPos::new(x, z)))
    // rust: .collect();
    // rust: let before: Vec<_> = chunks.iter().map(|&c| summary(&mut worker, c)).collect();
    // rust: assert!(before.iter().any(|s| !s.is_empty()), "no starts to compare");
    // rust: let searched = || data.ring_cache.lock().unwrap()[0].1.get().is_some();
    // rust: assert!(!searched());
    // rust: let rings = worker
    // rust: .ring_positions("minecraft:strongholds")
    // rust: .expect("ring positions");
    // rust: assert_eq!(rings.len(), 128);
    // rust: assert!(searched());
    // rust: worker.forget_structure_starts();
    // rust: let after: Vec<_> = chunks.iter().map(|&c| summary(&mut worker, c)).collect();
    // rust: assert_eq!(before, after);
}

    /// A map's structure search skips a chunk's starts when no wanted structure's start
    /// piece and biome fit there (#8669). Over the candidate chunks of every random-spread
    /// set around the camp TiesB2007's map went looking from, a skipped structure is never
    /// one the chunk's full starts hold, and some are skipped.
pub fn may_start_never_skips_a_start_the_chunk_holds() void {
}
    // rust: let Some(data) = prepared_data() else {
    // rust: return;
}
    // rust: let generator = OverworldGenerator::new(data, -3292718948513116954).expect("generator");
    // rust: let mut worker = generator.worker();
    // rust: let (mut held, mut skipped) = (0, 0);
    // rust: for x in 212..332 {
    // rust: for z in -481..-361 {
    // rust: let chunk = ChunkPos::new(x, z);
    // rust: let checks = worker.may_start_answers(chunk);
    // rust: if checks.is_empty() {
    // rust: continue;
}
    // rust: let starts: Vec<String> = (worker.structure_starts(chunk).iter())
    // rust: .map(|s| s.name.clone())
    // rust: .collect();
    // rust: for (name, may_start) in checks {
    // rust: if starts.contains(&name) {
    // rust: assert!(
    // rust: may_start,
    // rust: "{name} starts in {chunk:?}, but its check skips it"
    // rust: );
    // rust: held += 1;
    // rust: } else if !may_start {
    // rust: skipped += 1;
}
}
}
}
    // rust: assert!(held > 0 && skipped > 0, "held {held}, skipped {skipped}");
}

    /// Generators of one seed and dimension share their ring positions;
    /// another seed or generator gets its own, and old entries go.
pub fn ring_positions_are_shared_by_seed_and_dimension() void {
}
    // rust: let Some(data) = prepared_data() else {
    // rust: return;
}
    // rust: let first = OverworldGenerator::new(data.clone(), 1234).expect("generator");
    // rust: let again = OverworldGenerator::new(data.clone(), 1234).expect("generator");
    // rust: {
    // rust: let cache = data.ring_cache.lock().unwrap();
    // rust: assert_eq!(cache.len(), 1);
            // The cache's handle and the two generators'.
    // rust: assert_eq!(Arc::strong_count(&cache[0].1), 3);
}
    // rust: drop((first, again));
    // rust: let a = data.rings_for(1, &serde_json::json!({ "settings": "a" }));
    // rust: assert!(Arc::ptr_eq(
    // rust: &a,
    // rust: &data.rings_for(1, &serde_json::json!({ "settings": "a" }))
    // rust: ));
    // rust: assert!(!Arc::ptr_eq(
    // rust: &a,
    // rust: &data.rings_for(2, &serde_json::json!({ "settings": "a" }))
    // rust: ));
    // rust: assert!(!Arc::ptr_eq(
    // rust: &a,
    // rust: &data.rings_for(1, &serde_json::json!({ "settings": "b" }))
    // rust: ));
    // rust: for seed in 10..10 + RING_CACHE_LIMIT as i64 {
    // rust: data.rings_for(seed, &serde_json::json!({ "settings": "a" }));
}
    // rust: assert_eq!(data.ring_cache.lock().unwrap().len(), RING_CACHE_LIMIT);
    // rust: assert!(!Arc::ptr_eq(
    // rust: &a,
    // rust: &data.rings_for(1, &serde_json::json!({ "settings": "a" }))
    // rust: ));
}

    /// Generators of every seed share their biome source's decoration, the
    /// one the world screens' preload built; another dimension gets its own.
pub fn decoration_is_shared_by_biome_source() void {
}
    // rust: let Some(data) = prepared_data() else {
    // rust: return;
}
    // rust: data.prepare_decoration("minecraft:normal", "minecraft:overworld")
    // rust: .expect("decoration");
    // rust: let built = |i: usize| {
    // rust: let cache = data.decorations.lock().unwrap();
    // rust: let slot = cache[i].1.get().expect("built").clone();
    // rust: slot.expect("decoration").expect("feature resources")
}
    // rust: let prepared = built(0);
        // The cache's handle and ours.
    // rust: assert_eq!(Arc::strong_count(&prepared), 2);
    // rust: let first = OverworldGenerator::new(data.clone(), 1234).expect("generator");
    // rust: let other = OverworldGenerator::new(data.clone(), -7).expect("generator");
    // rust: assert_eq!(Arc::strong_count(&prepared), 4);
    // rust: assert_eq!(data.decorations.lock().unwrap().len(), 1);
    // rust: let nether = OverworldGenerator::for_dimension(
    // rust: data.clone(),
    // rust: 1234,
    // rust: "minecraft:normal",
    // rust: "minecraft:the_nether",
    // rust: )
    // rust: .expect("generator");
    // rust: assert_eq!(data.decorations.lock().unwrap().len(), 2);
    // rust: assert!(!Arc::ptr_eq(&prepared, &built(1)));
    // rust: drop((first, other, nether));
    // rust: assert_eq!(Arc::strong_count(&prepared), 2);
}

pub fn parameter_reports_quantize_like_vanilla() void {
}
    // rust: let report = r#"{"biomes":[{"biome":"minecraft:plains","parameters":{
    // rust: "temperature":[-0.45,-0.15],"humidity":[-1.0,-0.35],"continentalness":[-0.11,0.03],
    // rust: "erosion":[0.45,0.55],"depth":0.0,"weirdness":[-0.2633,-0.05],"offset":0.0}}]}"#;
    // rust: let table: Value =
    // rust: serde_json::from_str(&quantize_parameter_report(report).unwrap()).unwrap();
    // rust: assert_eq!(
    // rust: table,
    // rust: serde_json::json!([{"coordinates":[[-4500,-1500],[-10000,-3500],[-1100,300],
    // rust: [4500,5500],[0,0],[-2633,-500]],"offset":0,"biome":"minecraft:plains"}])
    // rust: );
    // rust: assert!(
    // rust: quantize_parameter_report(r#"{"biomes":[{"parameters":{"temperature":"x"}}]}"#)
    // rust: .is_err()
    // rust: );
}
pub fn neighbour_work_cleanup_keeps_active_keys_and_releases_idle_keys() void {
}
    // rust: let work = ChunkWork::new();
    // rust: let first = work.at((0, 0));
    // rust: let held = first.lock().unwrap();
    // rust: let same = work.at((0, 0));
    // rust: assert!(Arc::ptr_eq(&first, &same));
    // rust: assert!(!Arc::ptr_eq(&first, &work.at((1, 0))));
        // Sweep many expired weak entries while a builder and a prospective
        // waiter retain their key. Cleanup must not split their coordination.
    // rust: for x in 1..8192 {
    // rust: drop(work.at((x, 1)));
}
    // rust: assert!(
    // rust: work.0
    // rust: .iter()
    // rust: .map(|s| s.lock().unwrap().len())
    // rust: .sum::<usize>()
    // rust: <= 4096
    // rust: );
    // rust: assert!(Arc::ptr_eq(&same, &work.at((0, 0))));
    // rust: let weak = Arc::downgrade(&first);
    // rust: drop(held);
    // rust: drop((first, same));
    // rust: assert!(weak.upgrade().is_none());
    // rust: let next = work.at((0, 0));
    // rust: assert_eq!(Arc::strong_count(&next), 1);
}

    /// Emptying the shared caches (every worker idle) changes no chunk: the
    /// chunks generated after it have the same blocks and biomes.
pub fn released_caches_generate_the_same_chunks() void {
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return;
}
    // rust: let registry = Box::leak(Box::new(
    // rust: crate::level::data::load_registry(&root).expect("registry"),
    // rust: ));
    // rust: let data = GeneratorData::load(&root.join("worldgen"), registry).expect("worldgen data");
    // rust: let preset: Value = serde_json::from_str(&data.world_presets["minecraft:normal"]).unwrap();
    // rust: let generator_json = &preset["dimensions"]["minecraft:overworld"]["generator"];
    // rust: let settings: Value =
    // rust: serde_json::from_str(&data.settings[generator_json["settings"].as_str().unwrap()])
    // rust: .unwrap();
    // rust: let generator = OverworldGenerator {
    // rust: pipeline: Arc::new(
    // rust: Pipeline::new(
    // rust: data,
    // rust: 12345,
    // rust: XoroshiroRandom::new(12345),
    // rust: generator_json,
    // rust: &settings,
    // rust: true,
    // rust: Some((-64, 384)),
    // rust: )
    // rust: .expect("pipeline"),
    // rust: ),
    // rust: noise_clamped: None,
}
    // rust: let contents = |chunk: &ProtoChunk| {
    // rust: let (x0, z0) = (chunk.position().x * 16, chunk.position().z * 16);
    // rust: let mut out = Vec::new();
    // rust: for y in (-64..320).step_by(3) {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: out.push(chunk.block(x0 + x, y, z0 + z).0);
    // rust: out.push(chunk.biome_id_at(x0 + x, y, z0 + z).0);
}
}
}
    // rust: out
}
    // rust: let mut worker = generator.worker();
    // rust: let chunks = [
    // rust: ChunkPos::new(11, -11),
    // rust: ChunkPos::new(12, -11),
    // rust: ChunkPos::new(-3, 7),
    // rust: ];
    // rust: let before: Vec<_> = chunks
    // rust: .iter()
    // rust: .map(|&p| contents(&worker.generate_proto(p).unwrap()))
    // rust: .collect();
    // rust: assert!(generator.cache_census().biome_chunks > 0);
    // rust: generator.release_caches();
    // rust: worker.release();
    // rust: let census = generator.cache_census();
    // rust: assert_eq!((census.biome_chunks, census.carver_entries), (0, 0));
        // The other way round, so a neighbour's biomes come from the cache
        // where they were made before, and the reverse.
    // rust: for (&p, before) in chunks.iter().zip(&before).rev() {
    // rust: assert_eq!(
    // rust: &contents(&worker.generate_proto(p).unwrap()),
    // rust: before,
    // rust: "chunk {p:?}"
    // rust: );
}
}

    /// Equal concurrent misses share one biome volume and the same mutable
    /// structure pieces. Exercise cold ring startup before work coordination,
    /// then cache eviction and explicit start invalidation with old Arcs alive.
pub fn concurrent_neighbours_share_results_and_survive_invalidation() void {
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return;
}
    // rust: let registry = Box::leak(Box::new(
    // rust: crate::level::data::load_registry(&root).expect("registry"),
    // rust: ));
    // rust: let data = GeneratorData::load(&root.join("worldgen"), registry).expect("worldgen data");
    // rust: let preset: Value = serde_json::from_str(&data.world_presets["minecraft:normal"]).unwrap();
    // rust: let generator_json = &preset["dimensions"]["minecraft:overworld"]["generator"];
    // rust: let settings: Value =
    // rust: serde_json::from_str(&data.settings[generator_json["settings"].as_str().unwrap()])
    // rust: .unwrap();
    // rust: let pipeline = Arc::new(
    // rust: Pipeline::new(
    // rust: data,
    // rust: 12345,
    // rust: XoroshiroRandom::new(12345),
    // rust: generator_json,
    // rust: &settings,
    // rust: true,
    // rust: Some((-64, 384)),
    // rust: )
    // rust: .expect("pipeline"),
    // rust: );
    // rust: let generator = OverworldGenerator {
    // rust: pipeline: pipeline.clone(),
    // rust: noise_clamped: None,
}
    // rust: let barrier = std::sync::Barrier::new(6);
    // rust: let pos = ChunkPos::new(11, -11); // ancient city for this seed
    // rust: let results = std::thread::scope(|scope| {
    // rust: let handles: Vec<_> = (0..6)
    // rust: .map(|_| {
    // rust: scope.spawn(|| {
    // rust: let mut worker = generator.worker();
    // rust: barrier.wait();
    // rust: let biomes = pipeline.biome_chunk(&mut worker.state, pos).unwrap();
    // rust: let starts = pipeline.structure_starts(&mut worker.state, pos);
    // rust: (biomes, starts)
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: handles
    // rust: .into_iter()
    // rust: .map(|h| h.join().unwrap())
    // rust: .collect::<Vec<_>>()
    // rust: });
    // rust: let (biomes, starts) = &results[0];
    // rust: assert!(!starts.is_empty(), "fixture must exercise shared pieces");
    // rust: for (b, s) in &results[1..] {
    // rust: assert!(Arc::ptr_eq(biomes, b));
    // rust: assert_eq!(starts.len(), s.len());
    // rust: for (first, other) in starts.iter().zip(s) {
    // rust: assert!(Arc::ptr_eq(first, other));
}
}
        // Force the existing whole-cache biome eviction threshold.
    // rust: {
    // rust: let mut cache = pipeline.biome_cache.lock().unwrap();
    // rust: cache.clear();
    // rust: for x in 0..CACHE_LIMIT as i32 {
    // rust: cache.insert((x, 10000), biomes.clone());
}
}
    // rust: let mut worker = generator.worker();
    // rust: let rebuilt = pipeline.biome_chunk(&mut worker.state, pos).unwrap();
    // rust: assert!(!Arc::ptr_eq(biomes, &rebuilt));
    // rust: assert_eq!(pipeline.biome_cache.lock().unwrap().len(), 1);
    // rust: for section in 0..24 {
    // rust: assert_eq!(biomes.section(section), rebuilt.section(section));
}
    // rust: worker.forget_structure_starts();
    // rust: let fresh = worker.structure_starts(pos);
    // rust: assert_eq!(starts.len(), fresh.len());
    // rust: for (old, new) in starts.iter().zip(&fresh) {
    // rust: assert!(!Arc::ptr_eq(old, new));
    // rust: assert_eq!(old.name, new.name);
    // rust: assert_eq!(old.bounding_box, new.bounding_box);
}
    // rust: let again = worker.structure_starts(pos);
    // rust: for (first, hit) in fresh.iter().zip(&again) {
    // rust: assert!(Arc::ptr_eq(first, hit));
}
}

    /// The resources the worldgen tests read.
pub fn test_root() s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::var_os("HORIZON_TEST_RESOURCES")
    // rust: .or_else(|| std::env::var_os("HORIZON_RESOURCES"))
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3")
    // rust: })
}
    /// The block registry the worldgen bundle needs. `GeneratorData` keeps it
    /// for as long as the generator lives, so it is shared, not freed.
    // rust: static TEST_REGISTRY: std::sync::LazyLock<BlockRegistry> = std::sync::LazyLock::new(|| {
    // rust: crate::level::data::load_registry(&test_root()).expect("registry")
    // rust: });

    /// The world presets with their own noise settings generate the terrain
    /// those settings describe: the amplified and large-biome presets are not
    /// the overworld's terrain under another name.
pub fn world_presets_use_their_own_noise_settings() void {
}
    // rust: let root = test_root();
    // rust: if !root.join("worldgen/world_presets.json").exists() {
    // rust: eprintln!("skipping: no worldgen bundle at {}", root.display());
    // rust: return;
}
    // rust: let data =
    // rust: GeneratorData::load(&root.join("worldgen"), &TEST_REGISTRY).expect("worldgen data");
    // rust: let surface = |preset: &str| {
    // rust: let generator = OverworldGenerator::for_world(
    // rust: data.clone(),
    // rust: 1234,
    // rust: preset,
    // rust: "minecraft:overworld",
    // rust: false,
    // rust: )
    // rust: .expect("generator");
    // rust: let mut worker = generator.worker();
    // rust: (0..32)
    // rust: .map(|i| {
    // rust: worker
    // rust: .surface_sample(i * 137, i * 91)
    // rust: .expect("surface")
    // rust: .height
    // rust: })
    // rust: .collect::<Vec<_>>()
}
    // rust: let normal = surface("minecraft:normal");
    // rust: assert!(normal.iter().all(|height| (0..384).contains(height)));
    // rust: assert_ne!(normal, surface("minecraft:amplified"));
    // rust: assert_ne!(normal, surface("minecraft:large_biomes"));
}
}
