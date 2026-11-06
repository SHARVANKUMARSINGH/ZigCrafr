//! Transpiled from Horizon Rust crate
//! Module: horizon-world_generator_decoration
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! FEATURES status over a 3×3 neighborhood of generated chunks.
//!
//! Placed features are resolved by name from the bundled feature registries.
//! Roots whose algorithm or bindings are not implemented are left out of
//! execution (but keep their place in vanilla's per-step feature ordering, so
//! decoration seeds of the remaining features are unchanged).
// use super::structure::{
    // rust: BoundingBox,
    // rust: start::{STEPS, place_in_chunk},
}
// use super::{
    // rust: anchor::WorldGenerationContext,
    // rust: biome::BiomeId,
    // rust: biome_chunk::BiomeRegion,
    // rust: biome_predicate::BiomePredicateBindings,
    // rust: biome_source::ResolvedBiomeSource,
    // rust: biome_temperature::BiomeTemperature,
    // rust: biome_weather::BiomeWeatherBindings,
    // rust: block_feature::FeatureBlockBindings,
    // rust: decoration::{DecorationWorld, FeatureDecorationPlan},
    // rust: feature::{FeatureBlocks, FeatureWorld},
    // rust: feature_catalog::FeatureCatalog,
    // rust: feature_graph::PlacedFeatureDefinition,
    // rust: feature_region::{RegionError, TerrainRegion},
    // rust: feature_sort::FeatureIdentity,
    // rust: generator::{
    // rust: DecorateStats, GenBlockStates, GeneratorData, GeneratorError, ProtoChunk, WorkerState,
    // rust: },
    // rust: placement::{FeaturePlacer, LayerBlock, PlacementContext, PlacementQueryError},
    // rust: tags::TagDefinitions,
    // rust: terrain::PreLightChunkStage,
    // rust: write_zone::GenerationWriteZone,
}
// use super::{
    // rust: generator_blocks::BlockBehavior,
    // rust: state_provider::{StateProviderBindings, StateProviderCatalog},
}
// use crate::{
    // rust: block_collision::{DynamicCollisionWorld, ShulkerCollisionState},
    // rust: block_placement::BlockPlacementBindings,
    // rust: block_support::SupportType,
    // rust: block_survival::SurvivalWorld,
    // rust: dynamic_support::DynamicSupportWorld,
    // rust: fluid::{FluidKind, FluidState},
    // rust: heightmap::{HeightmapState, HeightmapType},
    // rust: registry::BlockStateId,
}
// use horizon_core::random::{WorldgenRandom, XoroshiroRandom};
// use horizon_core::{
    // rust: biome::obfuscate_seed,
    // rust: geometry::{Axis, Direction, VoxelShape},
    // rust: position::{BlockPos, ChunkPos},
}
// use serde_json::Value;
// use std::collections::HashMap;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::Arc,
}

    // rust: pub(super) struct Decoration {
    // rust: plan: FeatureDecorationPlan,
    // rust: names: Vec<String>,
    /// Executable roots by identity, or why the root cannot be executed.
    // rust: features: Vec<Result<PlacedFeatureDefinition, String>>,
    /// Placed features of each biome's generation settings, by BiomeId.
    // rust: biome_features: Vec<BTreeSet<FeatureIdentity>>,
    // rust: bindings: FeatureBlockBindings<'static>,
    // rust: weather: Option<BiomeWeatherBindings>,
    // rust: blocks: FeatureBlocks,
    // rust: catalog: FeatureCatalog,
    /// Placed features referenced by name (feature pool elements), decoded lazily.
    // rust: named: std::sync::Mutex<HashMap<String, Option<Arc<PlacedFeatureDefinition>>>>,
    /// BlockBehaviour.Properties.postProcess: states whose worldgen writes mark
    /// their own position (mushrooms) or the one above (soul sand, magma).
    // rust: postprocess_self: Vec<BlockStateId>,
    // rust: postprocess_above: Vec<BlockStateId>,
    /// A superflat world's `FillLayerFeature`s (`TOP_LAYER_MODIFICATION`): the level Y and state
    /// of each layer that is not opaque to `MOTION_BLOCKING`, filled after the structures.
    // rust: pub(super) top_layers: Vec<(i32, BlockStateId)>,
}
pub fn resource(message: impl Into<[]const u8>) G {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: GeneratorError::Resource(message.into())
}
/// Biomes in vanilla's possible-biome encounter order for this source.
pub fn possible_biomes(source: *ResolvedBiomeSource) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut seen = BTreeSet::new();
    // rust: let ordered: Vec<String> = match source {
    // rust: ResolvedBiomeSource::MultiNoise(source) => source
    // rust: .parameters()
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|(_, name)| name.clone())
    // rust: .collect(),
    // rust: ResolvedBiomeSource::End(source) => [
    // rust: &source.center,
    // rust: &source.highlands,
    // rust: &source.midlands,
    // rust: &source.islands,
    // rust: &source.barrens,
    // rust: ]
    // rust: .into_iter()
    // rust: .cloned()
    // rust: .collect(),
    // rust: other => other
    // rust: .possible_biomes()
    // rust: .into_iter()
    // rust: .map(str::to_owned)
    // rust: .collect(),
}
    // rust: ordered
    // rust: .into_iter()
    // rust: .filter(|name| seen.insert(name.clone()))
    // rust: .collect()
}
/// `FlatLevelGeneratorSettings.adjustGenerationSettings`: what a superflat world keeps of its
/// biome's generation settings.
    // rust: pub(super) struct FlatDecoration {
    /// `(!voidGen || biome is the_void) && decoration`: the biome's own placed features, but
    /// those of the two structure steps (and of the lakes step when `lakes` is on).
    // rust: pub(super) features: bool,
    /// `addLakes`: the lakes step is `createLakesList`.
    // rust: pub(super) lakes: bool,
}
/// `GenerationStep.Decoration` ordinals `adjustGenerationSettings` treats on their own.
pub const LAKES_STEP: usize = 1;
pub const UNDERGROUND_STRUCTURES_STEP: usize = 3;
pub const SURFACE_STRUCTURES_STEP: usize = 4;
/// `FlatLevelGeneratorSettings.createLakesList`.
    // rust: const FLAT_LAKES: [&str; 2] = [
    // rust: "minecraft:lake_lava_underground",
    // rust: "minecraft:lake_lava_surface",
    // rust: ];
    // rust: impl FlatDecoration {
    /// The settings' `features` and `lakes`, for layers that are all air (`void_gen`) or not and a
    /// biome that is the_void or not.
    // rust: pub(super) fn new(features: bool, lakes: bool, void_gen: bool, the_void: bool) -> Self {
    // rust: Self {
    // rust: features: (!void_gen || the_void) && features,
    // rust: lakes,
}
}
    /// Which of the biome's own entries step `step` keeps.
pub fn keeps_biome_step(self: *Self, step: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.features
    // rust: && step != UNDERGROUND_STRUCTURES_STEP
    // rust: && step != SURFACE_STRUCTURES_STEP
    // rust: && !(self.lakes && step == LAKES_STEP)
}
}
    // rust: impl Decoration {
    // rust: pub(super) fn new(
    // rust: data: &Arc<GeneratorData>,
    // rust: source: &ResolvedBiomeSource,
    // rust: ) -> Result<Option<Self>, GeneratorError> {
    // rust: Self::new_with(data, source, None)
}
    /// `new` for a superflat world (`flat`): its fixed biome's settings as
    /// `adjustGenerationSettings` leaves them. The steps stay (structures place in them);
    /// the `FillLayerFeature`s are `top_layers`.
    // rust: pub(super) fn new_with(
    // rust: data: &Arc<GeneratorData>,
    // rust: source: &ResolvedBiomeSource,
    // rust: flat: Option<FlatDecoration>,
    // rust: ) -> Result<Option<Self>, GeneratorError> {
    // rust: let Some(resources) = &data.feature_resources else {
    // rust: return Ok(None);
}
    // rust: let registry = data.registry();
    // rust: let mut feature_tags = TagDefinitions::default();
    // rust: for (name, json) in &resources.feature_tags {
    // rust: feature_tags.apply_json(name, "vanilla", json)?;
}
    // rust: let catalog =
    // rust: FeatureCatalog::from_resources(&resources.features, &resources.placed, &feature_tags)?;
    // rust: let biomes = Arc::new(BiomePredicateBindings::new(
    // rust: &data
    // rust: .biome_names()
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, name)| (name.to_string(), BiomeId(i as u32)))
    // rust: .collect(),
    // rust: &data.biome_tags,
    // rust: )?);
    // rust: let mut bindings = data
    // rust: .feature_block_bindings()?
    // rust: .with_fluid_tags(&resources.fluid_tags)?
    // rust: .with_biomes(biomes.clone());
    // rust: if let Some(structures) = &data.structures {
    // rust: bindings = bindings.with_structures(structures.clone());
}
    // rust: if let Some(blocks) = &resources.blocks {
    // rust: bindings = bindings
    // rust: .with_block_properties(&blocks.properties)?
    // rust: .with_state_providers(
    // rust: StateProviderBindings::new(
    // rust: registry,
    // rust: data.integers().clone(),
    // rust: &data.block_tags,
    // rust: )?
    // rust: .with_block_properties(&blocks.properties)?
    // rust: .with_fluid_tags(&resources.fluid_tags)?
    // rust: .with_biomes(biomes),
    // rust: StateProviderCatalog::from_resources(&resources.state_providers)?,
    // rust: BlockPlacementBindings::new(
    // rust: registry,
    // rust: &blocks.properties,
    // rust: &blocks.double_plants,
    // rust: &blocks.mossy_carpets,
    // rust: )?,
    // rust: )?;
}
    // rust: let tags = feature_tags
    // rust: .build(|name, _| resources.placed.contains_key(name).then(|| name.to_owned()))
    // rust: .map_err(|e| resource(format!("feature tags: {e:?}")))?
    // rust: .tags;
    // rust: let mut ids = BTreeMap::<String, FeatureIdentity>::new();
    // rust: let mut names = Vec::new();
    // rust: let mut features = Vec::new();
    // rust: let mut identity = |name: &str| -> FeatureIdentity {
    // rust: *ids.entry(name.to_owned()).or_insert_with(|| {
    // rust: let id = FeatureIdentity(names.len() as u32);
    // rust: names.push(name.to_owned());
    // rust: features.push(
    // rust: catalog
    // rust: .placed_feature_with_blocks(&Value::from(name).to_string(), &bindings)
    // rust: .map_err(|e| e.to_string()),
    // rust: );
    // rust: id
    // rust: })
}
    // rust: let mut biome_features = vec![BTreeSet::new(); data.biome_names().len()];
    // rust: let mut plan = Vec::new();
    // rust: for name in possible_biomes(source) {
    // rust: let id = data
    // rust: .biome_id(&name)
    // rust: .ok_or_else(|| resource(format!("unknown biome {name}")))?;
    // rust: let json: Value = serde_json::from_str(data.biome_json(id))?;
    // rust: let mut steps = Vec::new();
    // rust: for (index, step) in json["features"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .enumerate()
    // rust: {
    // rust: let mut list = Vec::new();
                // The builder takes the lakes first, then the biome's steps it keeps.
    // rust: if flat.is_some_and(|f| f.lakes) && index == LAKES_STEP {
    // rust: for name in FLAT_LAKES {
    // rust: let feature = identity(name);
    // rust: list.push(feature);
    // rust: biome_features[id.0 as usize].insert(feature);
}
}
    // rust: if flat.is_some_and(|f| !f.keeps_biome_step(index)) {
    // rust: steps.push(list);
    // rust: continue;
}
    // rust: let entries = match step {
    // rust: Value::String(tag) if tag.starts_with('#') => tags
    // rust: .get(&super::tags::identifier(&tag[1..])?)
    // rust: .cloned()
    // rust: .ok_or_else(|| resource(format!("unknown feature tag {tag}")))?,
    // rust: Value::String(name) => vec![name.clone()],
    // rust: Value::Array(values) => values
    // rust: .iter()
    // rust: .map(|v| {
    // rust: v.as_str()
    // rust: .map(str::to_owned)
    // rust: .ok_or_else(|| resource("inline placed feature in biome"))
    // rust: })
    // rust: .collect::<Result<_, _>>()?,
    // rust: _ => return Err(resource("biome feature step")),
}
    // rust: for entry in entries {
    // rust: let feature = identity(&super::tags::identifier(&entry)?);
    // rust: list.push(feature);
    // rust: biome_features[id.0 as usize].insert(feature);
}
    // rust: steps.push(list);
}
            // A biome with fewer steps still gets the lakes (`PlainBuilder` grows its list).
    // rust: if flat.is_some_and(|f| f.lakes) && steps.len() <= LAKES_STEP {
    // rust: steps.resize_with(LAKES_STEP, Vec::new);
    // rust: let lakes = FLAT_LAKES.map(&mut identity).to_vec();
    // rust: biome_features[id.0 as usize].extend(lakes.iter().copied());
    // rust: steps.push(lakes);
}
    // rust: plan.push((id, steps));
}
    // rust: let plan = FeatureDecorationPlan::new(plan).map_err(|e| resource(e.to_string()))?;
    // rust: let weather = BiomeWeatherBindings::new(&bindings).ok();
    // rust: let states = |names: &[&str]| -> Vec<BlockStateId> {
    // rust: names
    // rust: .iter()
    // rust: .filter_map(|n| registry.default_state(n))
    // rust: .collect()
}
    // rust: let postprocess_self = states(&["minecraft:brown_mushroom", "minecraft:red_mushroom"]);
    // rust: let postprocess_above = states(&["minecraft:soul_sand", "minecraft:magma_block"]);
    // rust: Ok(Some(Self {
    // rust: postprocess_self,
    // rust: postprocess_above,
    // rust: plan,
    // rust: names,
    // rust: features,
    // rust: biome_features,
    // rust: weather,
    // rust: blocks: FeatureBlocks::from_registry(registry)?,
    // rust: bindings,
    // rust: catalog,
    // rust: named: std::sync::Mutex::new(HashMap::new()),
    // rust: top_layers: Vec::new(),
    // rust: }))
}
pub fn named_feature(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut named = self.named.lock().unwrap();
    // rust: named
    // rust: .entry(name.to_owned())
    // rust: .or_insert_with(|| {
    // rust: self.catalog
    // rust: .placed_feature_with_blocks(&Value::from(name).to_string(), &self.bindings)
    // rust: .ok()
    // rust: .map(Arc::new)
    // rust: })
    // rust: .clone()
}
    /// Vanilla's feature identity and the step-local index/step mixed into
    /// `set_feature_seed`.
    // rust: pub(super) fn seed(&self, name: &str) -> Option<(u32, i32, i32)> {
    // rust: let identity = self.names.iter().position(|candidate| candidate == name)? as u32;
    // rust: let (index, step) = self.plan.seed(FeatureIdentity(identity))?;
    // rust: Some((identity, index as i32, step as i32))
}
    /// Replays a feature's placement chain and the feature itself on a no-op
    /// world. This advances vanilla's random stream but writes no blocks, so a
    /// caller can reproduce the exact origins without generating terrain.
    // rust: pub(super) fn origins(
    // rust: &self,
    // rust: world_seed: i64,
    // rust: chunk: ChunkPos,
    // rust: mut biome_allows: impl FnMut([i32; 3]) -> bool,
    // rust: ) -> Vec<[i32; 3]> {
    // rust: let Some((identity, index, step)) = self.seed("minecraft:end_island_decorated") else {
    // rust: return Vec::new();
}
    // rust: let Ok(feature) = &self.features[identity as usize] else {
    // rust: return Vec::new();
}
    // rust: let blocks = self.blocks;
    // rust: let mut random = WorldgenRandom::new(XoroshiroRandom::new(0));
    // rust: let seed = random.set_decoration_seed(world_seed, chunk.x * 16, chunk.z * 16);
    // rust: random.set_feature_seed(seed, index, step);
    // rust: let mut world = OriginWorld {
    // rust: air: blocks.air,
    // rust: generation: WorldGenerationContext::new(0, 256, 0),
    // rust: biome_allows: &mut biome_allows,
}
    // rust: let mut origins = Vec::new();
    // rust: let mut placer = FeaturePlacer::new();
    // rust: let _ = placer.place_with_biome_check(
    // rust: &feature.placement,
    // rust: &mut world,
    // rust: &mut random,
    // rust: [chunk.x * 16, 0, chunk.z * 16],
    // rust: FeatureIdentity(identity),
    // rust: |world, random, position| {
    // rust: origins.push(position);
    // rust: feature
    // rust: .feature
    // rust: .place(world, random, position, blocks)
    // rust: .map(|_| true)
    // rust: .map_err(|_| ())
    // rust: },
    // rust: );
    // rust: origins
}
    /// Placed-feature roots that cannot run, with their decode errors.
    // rust: pub(super) fn unsupported(&self) -> Vec<(String, String)> {
    // rust: self.names
    // rust: .iter()
    // rust: .zip(&self.features)
    // rust: .filter_map(|(name, feature)| feature.as_ref().err().map(|e| (name.clone(), e.clone())))
    // rust: .collect()
}
    // rust: pub(super) fn decorate(
    // rust: &self,
    // rust: data: &Arc<GeneratorData>,
    // rust: seed: i64,
    // rust: generation: WorldGenerationContext,
    // rust: worker: &mut WorkerState,
    // rust: region: &mut [ProtoChunk; 9],
    // rust: level_random: &mut dyn super::structure::legacy::PieceRandom,
    // rust: structures: Option<&super::generator_structures::StructureState>,
    // rust: ) -> Result<DecorateStats, GeneratorError> {
    // rust: let center = region[4].position();
    // rust: for (i, chunk) in region.iter().enumerate() {
    // rust: let expected = ChunkPos::new(
    // rust: center.x.wrapping_add(i as i32 % 3 - 1),
    // rust: center.z.wrapping_add(i as i32 / 3 - 1),
    // rust: );
    // rust: if chunk.position() != expected {
    // rust: return Err(resource("decoration region is not a 3×3 neighborhood"));
}
    // rust: if (chunk.terrain.generation_stage() as u8) < PreLightChunkStage::Terrain as u8 {
    // rust: return Err(resource("decoration requires terrain-stage chunks"));
}
}
    // rust: if region[4].is_decorated() {
    // rust: return Ok(DecorateStats::default());
}
    // rust: let mut chunks = Vec::with_capacity(9);
    // rust: let mut biomes = Vec::with_capacity(9);
    // rust: let (min_y, height) = (region[4].terrain.min_y(), region[4].terrain.height());
    // rust: for chunk in region.iter_mut() {
            // A one-section stand-in while the region holds the terrain: it
            // is swapped back below, and allocating the full height for nine
            // stand-ins per region cost more than some features.
    // rust: let empty = super::terrain::TerrainChunk::new(
    // rust: chunk.position(),
    // rust: min_y,
    // rust: 16,
    // rust: data.registry(),
    // rust: data.block_states().clone(),
    // rust: )
    // rust: .map_err(|e| resource(e.to_string()))?;
    // rust: chunks.push(std::mem::replace(&mut chunk.terrain, empty));
    // rust: biomes.push(chunk.biomes().clone());
}
    // rust: let terrain = TerrainRegion::new(chunks, generation)
    // rust: .and_then(|region| region.with_block_bindings(&self.bindings))
    // rust: .map(|region| region.with_world_seed(seed));
    // rust: let terrain = match terrain {
    // rust: Ok(terrain) => terrain,
    // rust: Err(e) => return Err(resource(e.to_string())),
}
    // rust: let structures_only = worker.structures_only;
    // rust: let references = region[4].structure_starts.clone();
    // rust: let mut block_entities = Vec::new();
    // rust: for chunk in region.iter_mut() {
    // rust: block_entities.append(&mut chunk.block_entities);
}
    // rust: let mut world = World {
    // rust: block_entities,
    // rust: entities: Vec::new(),
    // rust: level_random,
    // rust: structure_mobs: worker.structure_mobs.clone(),
    // rust: starts: references.clone(),
    // rust: biome_names: data.biome_names(),
    // rust: blocks: data
    // rust: .feature_resources
    // rust: .as_ref()
    // rust: .and_then(|r| r.blocks.as_ref()),
    // rust: region: terrain,
    // rust: biomes: BiomeRegion::new(biomes, obfuscate_seed(seed))
    // rust: .map_err(|e| resource(e.to_string()))?,
    // rust: zone: GenerationWriteZone::new(center, 1),
    // rust: center,
    // rust: uniform_biomes: vec![UNKNOWN_BIOME; 9 * (height / 16).max(0) as usize],
    // rust: biome_quarts: region[4].biomes().quart_range(),
    // rust: decoration: self,
    // rust: temperatures: &mut worker.temperatures,
    // rust: behaviours: data.behaviours.as_deref(),
            // WorldGenRegion.isOutsideBuildHeight: the level's range, not the noise's.
    // rust: build: (min_y, min_y + height),
    // rust: shape_ticks: std::cell::RefCell::new(crate::level::Ticks::new(0)),
}
    // rust: let mut stats = DecorateStats::default();
    // rust: let blocks = self.blocks;
        // The blocks' facts: `BlockState.isSolidRender` and the rest, the
        // structure pieces ask them of the blocks around them.
    // rust: let tree_blocks = self
    // rust: .bindings
    // rust: .tree_blocks()
    // rust: .map_err(|e| resource(e.to_string()))?;
        // ChunkGenerator.getWritableArea: the chunk's minimum Y + 1 to its maximum Y.
    // rust: let chunk_box = BoundingBox::new(
    // rust: [center.x * 16, min_y + 1, center.z * 16],
    // rust: [center.x * 16 + 15, min_y + height - 1, center.z * 16 + 15],
    // rust: );
    // rust: let mut structure_errors = 0;
    // rust: let result = self.plan.decorate(
    // rust: &mut world,
    // rust: center,
    // rust: seed,
    // rust: STEPS.len(),
    // rust: |world, random, decoration_seed, step| {
    // rust: let Some(structures) = structures else {
    // rust: return Ok(());
}
    // rust: let Some(in_step) = structures.by_step.get(step) else {
    // rust: return Ok(());
}
    // rust: for (index, &structure) in in_step.iter().enumerate() {
    // rust: random.set_feature_seed(decoration_seed, index as i32, step as i32);
    // rust: for start in references.iter().filter(|s| s.structure == structure) {
    // rust: let mut place_feature =
    // rust: |world: &mut World<'_>,
    // rust: random: &mut WorldgenRandom<XoroshiroRandom>,
    // rust: name: &str,
    // rust: pos: [i32; 3]| {
    // rust: match self.named_feature(name) {
    // rust: Some(feature) => feature
    // rust: .place(world, random, pos, blocks)
    // rust: .map_err(|e| PlacementQueryError::Failed(e.to_string())),
    // rust: None => Ok(false),
}
}
    // rust: if place_in_chunk(
    // rust: start,
    // rust: world,
    // rust: &structures.resources,
    // rust: &tree_blocks,
    // rust: random,
    // rust: chunk_box,
    // rust: &mut place_feature,
    // rust: )
    // rust: .is_err()
    // rust: {
    // rust: structure_errors += 1;
}
}
}
    // rust: Ok(())
    // rust: },
    // rust: |world, placer, random, id, origin| {
    // rust: if structures_only {
    // rust: return Ok(false);
}
    // rust: let Ok(feature) = &self.features[id.0 as usize] else {
    // rust: stats.unsupported += 1;
    // rust: stats.skipped.insert(self.names[id.0 as usize].clone());
    // rust: return Ok(false);
}
    // rust: stats.placed += 1;
    // rust: let placed = placer.place_with_biome_check(
    // rust: &feature.placement,
    // rust: world,
    // rust: random,
    // rust: origin,
    // rust: id,
    // rust: |world, random, p| feature.feature.place(world, random, p, blocks),
    // rust: );
    // rust: if placed.is_err() {
    // rust: stats.failed += 1;
    // rust: stats.skipped.insert(self.names[id.0 as usize].clone());
}
    // rust: Ok(placed.unwrap_or(false))
    // rust: },
    // rust: );
        // `FillLayerFeature.place` for the chunk: air at the layer's Y becomes the layer.
    // rust: if result.is_ok() && !structures_only {
    // rust: for &(y, state) in &self.top_layers {
    // rust: for dz in 0..16 {
    // rust: for dx in 0..16 {
    // rust: let at = [center.x * 16 + dx, y, center.z * 16 + dz];
    // rust: let current = world
    // rust: .block(at)
    // rust: .map_err(|e| GeneratorError::Stage("features", e.to_string()))?;
    // rust: if data.block_states().get(current).is_air() {
    // rust: world
    // rust: .set_block(at, state, 2)
    // rust: .map_err(|e| GeneratorError::Stage("features", e.to_string()))?;
}
}
}
}
}
    // rust: for (pos, nbt) in std::mem::take(&mut world.block_entities) {
    // rust: let index = ((pos[2] >> 4).wrapping_sub(center.z) + 1) * 3
    // rust: + (pos[0] >> 4).wrapping_sub(center.x)
    // rust: + 1;
    // rust: if let Some(chunk) = usize::try_from(index).ok().and_then(|i| region.get_mut(i)) {
    // rust: chunk.block_entities.push((pos, nbt));
}
}
        // WorldGenRegion.addFreshEntity: into the chunk holding the position.
    // rust: for nbt in std::mem::take(&mut world.entities) {
    // rust: let Some(at) = block_of(&nbt) else {
    // rust: continue;
}
    // rust: let index = ((at[2] >> 4).wrapping_sub(center.z) + 1) * 3
    // rust: + (at[0] >> 4).wrapping_sub(center.x)
    // rust: + 1;
    // rust: if let Some(chunk) = usize::try_from(index).ok().and_then(|i| region.get_mut(i)) {
    // rust: chunk.entities.push(nbt);
}
}
    // rust: for terrain in world.region.into_chunks() {
    // rust: let p = terrain.position();
    // rust: let index = (p.z.wrapping_sub(center.z) + 1) * 3 + p.x.wrapping_sub(center.x) + 1;
    // rust: region[index as usize].terrain = terrain;
}
    // rust: result.map_err(|e| GeneratorError::Stage("features", e.to_string()))?;
    // rust: stats.failed += structure_errors;
    // rust: region[4]
    // rust: .terrain
    // rust: .set_generation_stage(PreLightChunkStage::Features);
    // rust: region[4].set_decorated();
    // rust: Ok(stats)
}
}

/// `a`, and `b` when it differs.
    // rust: fn span<T: PartialEq>(a: T, b: T) -> (T, Option<T>) {
    // rust: let b = (a != b).then_some(b);
    // rust: (a, b)
}
pub const UNKNOWN_BIOME: u32 = u32::MAX;
pub const MIXED_BIOMES: u32 = u32::MAX - 1;
    // rust: impl World<'_> {
    /// The biome of a biome section when all its quarts hold the same one
    /// (and its chunk has biomes); `None` when mixed or outside the region.
pub fn uniform_section(self: *Self, cx: i32, cz: i32, section: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (dx, dz) = (
    // rust: i64::from(cx) - i64::from(self.center.x) + 1,
    // rust: i64::from(cz) - i64::from(self.center.z) + 1,
    // rust: );
    // rust: if !(0..3).contains(&dx) || !(0..3).contains(&dz) {
    // rust: return None;
}
    // rust: let sections = self.uniform_biomes.len() / 9;
    // rust: if section >= sections {
    // rust: return None;
}
    // rust: let slot = (dz * 3 + dx) as usize * sections + section;
    // rust: if self.uniform_biomes[slot] == UNKNOWN_BIOME {
    // rust: let chunk = ChunkPos::new(cx, cz);
    // rust: let ready = self.region.chunk(cx, cz).is_ok_and(|c| {
    // rust: c.highest_generated_status() >= crate::chunk_status::ChunkStatus::Biomes
    // rust: });
    // rust: let values = self
    // rust: .biomes
    // rust: .chunk(chunk)
    // rust: .ok()
    // rust: .and_then(|c| c.section(section));
    // rust: self.uniform_biomes[slot] = match values {
    // rust: Some(values) if ready && values.iter().all(|b| *b == values[0]) => values[0].0,
    // rust: _ => MIXED_BIOMES,
}
}
    // rust: match self.uniform_biomes[slot] {
    // rust: MIXED_BIOMES => None,
    // rust: id => Some(BiomeId(id)),
}
}
    /// BiomeManager.getBiome without the zoom when every quart it can pick
    /// lies in biome sections of one and the same biome.
pub fn uniform_biome(self: *Self, z]: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let base = [x, y, z].map(|v| v.wrapping_sub(2) >> 2);
    // rust: let (bottom, top) = self.biome_quarts;
    // rust: let section = |q: i32| ((q.clamp(bottom, top) - bottom) >> 2) as usize;
        // The chunks and sections holding the quarts base..=base + 1.
    // rust: let (x0, x1) = span(base[0] >> 2, base[0].wrapping_add(1) >> 2);
    // rust: let (z0, z1) = span(base[2] >> 2, base[2].wrapping_add(1) >> 2);
    // rust: let (s0, s1) = span(section(base[1]), section(base[1].wrapping_add(1)));
    // rust: let found = self.uniform_section(x0, z0, s0)?;
    // rust: for cx in std::iter::once(x0).chain(x1) {
    // rust: for cz in std::iter::once(z0).chain(z1) {
    // rust: for s in std::iter::once(s0).chain(s1) {
    // rust: if self.uniform_section(cx, cz, s)? != found {
    // rust: return None;
}
}
}
}
    // rust: Some(found)
}
}
/// Advances a feature's random stream with no block storage; every write is
/// discarded. Placement modifiers still see the real biome and build bounds.
pub const OriginWorld = struct {
    air: BlockStateId,
    generation: WorldGenerationContext,
    biome_allows: *'a mut dyn FnMut([i32,
};
    // rust: impl FeatureWorld for OriginWorld<'_> {
    // rust: type Error = ();
pub fn block(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.air)
}
pub fn set_block(self: *Self, _: [i32; 3], _: BlockStateId, _: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
}
    // rust: impl PlacementContext for OriginWorld<'_> {
pub fn generation(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.generation
}
pub fn min_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.generation.min_y)
}
pub fn height(self: *Self, _: HeightmapType, _: i32, _: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.generation.min_y + self.generation.height)
}
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.generation.min_y + self.generation.height - 1)
}
    // rust: fn biome_allows_feature(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: _: FeatureIdentity,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: Ok((self.biome_allows)(position))
}
}

/// WorldGenRegion-style view: reads anywhere in the 3×3 region, writes within
/// the FEATURES step's write radius, biome lookups through the biome zoom.
pub const World = struct {
    block_entities: Vec<([i32,
    entities: std.ArrayList(crate::nbt::Compound),
    level_random: *'a mut dyn super::structure::legacy::PieceRandom,
    structure_mobs: ?*dyn super::generator::StructureMobs,
    starts: std.ArrayList(*super::structure::start::StructureStart),
    biome_names: *'a [*str],
    blocks: ?*'a BlockBehavior,
    region: TerrainRegion<'static,
    biomes: BiomeRegion<BiomeId>,
    zone: GenerationWriteZone,
    center: ChunkPos,
    /// Per biome section of the nine chunks (chunk-major): its one biome id,
    /// MIXED_BIOMES, or UNKNOWN_BIOME until first asked.
    uniform_biomes: std.ArrayList(u32),
    /// The quart Ys biome lookups clamp to (`BiomeChunk::quart_range`).
    biome_quarts: (i32,
    decoration: *'a Decoration,
    temperatures: *'a mut [BiomeTemperature],
    behaviours: ?*'a crate::level::Behaviours,
    /// Inclusive minimum and exclusive maximum build height.
    build: (i32,
    /// The tick capture `shape_update` passes to `updateShape`.
    shape_ticks: std::cell::RefCell<crate::level::Ticks>,
};
/// Read-only `LevelAccess` view of the decoration region for
/// `BlockState.updateShape` (writes go through `World::set_block`).
pub const ShapeLevel = struct {
    world: *'w World<'a>,
    random: horizon_core::random::LegacyRandom,
};
    // rust: impl crate::level::LevelAccess for ShapeLevel<'_, '_> {
pub fn block_state(self: *Self, pos: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world
    // rust: .region
    // rust: .block([pos.x, pos.y, pos.z])
    // rust: .unwrap_or(BlockStateId(0))
}
pub fn set_raw(self: *Self, _: BlockPos, _: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn is_loaded(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.region.block([pos.x, pos.y, pos.z]).is_ok()
}
pub fn min_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.build.0
}
pub fn max_y(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.build.1
}
pub fn random(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.random
}
pub fn game_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
    /// Lighting has not run during FEATURES: the light engine has no data for
    /// these chunks, so sky light reads zero too (MushroomBlock.canSurvive).
pub fn sky_light(self: *Self, _: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
}
    // rust: impl World<'_> {
    /// `BlockState.updateShape` of the state at `pos` against `neighbor`.
    // rust: fn shape_update(
    // rust: &self,
    // rust: behaviours: &crate::level::Behaviours,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: direction: Direction,
    // rust: neighbor_pos: [i32; 3],
    // rust: neighbor: BlockStateId,
    // rust: ) -> (BlockStateId, Vec<crate::level::ticks::CapturedTick>) {
    // rust: let mut level = ShapeLevel {
    // rust: world: self,
    // rust: random: horizon_core::random::LegacyRandom::new(0),
}
        // The ticks updateShape schedules (LeavesBlock re-measuring its
        // distance, waterlogged blocks' fluid) go to the proto chunks. While
        // capturing, scheduling leaves the rest of `Ticks` untouched, so the
        // region keeps one instead of building one per update.
    // rust: let mut ticks = self.shape_ticks.borrow_mut();
    // rust: ticks.capture = Some(Vec::new());
    // rust: let updated = behaviours.update_shape(
    // rust: &mut level,
    // rust: &mut ticks,
    // rust: state,
    // rust: BlockPos::new(pos[0], pos[1], pos[2]),
    // rust: direction,
    // rust: BlockPos::new(neighbor_pos[0], neighbor_pos[1], neighbor_pos[2]),
    // rust: neighbor,
    // rust: );
    // rust: (updated, ticks.capture.take().unwrap_or_default())
}
    /// Schedule ticks a shape update requested in the region's proto chunks.
    // rust: fn schedule_captured(
    // rust: &mut self,
    // rust: behaviours: &crate::level::Behaviours,
    // rust: ticks: Vec<crate::level::ticks::CapturedTick>,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: for t in ticks {
    // rust: let at = [t.pos.x, t.pos.y, t.pos.z];
    // rust: if t.fluid {
    // rust: let fluid = crate::fluid::FluidKind::ALL[t.kind as usize];
    // rust: self.schedule_fluid_tick(at, fluid, t.delay)?;
    // rust: } else {
    // rust: let state = behaviours
    // rust: .table
    // rust: .default_state(crate::level::BlockId(t.kind as u16));
    // rust: self.schedule_block_tick(at, state, t.delay)?;
}
}
    // rust: Ok(())
}
}
    // rust: impl DecorationWorld for World<'_> {
    // rust: type Error = RegionError;
pub fn min_section_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .region
    // rust: .min_y()
    // rust: .map_err(|_| RegionError::InvalidChunks)?
    // rust: >> 4)
}
    /// `BiomeRegion::present_in_chunk`: the distinct ids, ascending, from a
    /// bitset instead of sorting every quart of the column.
pub fn chunk_biomes(self: *Self, chunk: ChunkPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let biomes = self.biomes.chunk(chunk).map_err(RegionError::Biome)?;
    // rust: let mut seen: Vec<u64> = Vec::new();
    // rust: let mut last = None;
    // rust: let mut section = 0;
    // rust: while let Some(values) = biomes.section(section) {
    // rust: for &id in values {
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
    // rust: let mut out = Vec::new();
    // rust: for (word, &bits) in seen.iter().enumerate() {
    // rust: let mut bits = bits;
    // rust: while bits != 0 {
    // rust: out.push(BiomeId(word as u32 * 64 + bits.trailing_zeros()));
    // rust: bits &= bits - 1;
}
}
    // rust: Ok(out)
}
pub fn set_currently_generating(self: *Self, _: ?FeatureIdentity) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
}
    // rust: impl FeatureWorld for World<'_> {
    // rust: type Error = RegionError;
pub fn block(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.block(position)
}
    // rust: fn scan_column(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: step: i32,
    // rust: limit: i32,
    // rust: keep: impl FnMut(BlockStateId) -> bool,
    // rust: ) -> Result<i32, RegionError> {
    // rust: self.region.scan_column(position, step, limit, keep)
}
    // rust: fn set_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: flags: i32,
    // rust: ) -> Result<bool, RegionError> {
    // rust: if !self
    // rust: .zone
    // rust: .contains_block(BlockPos::new(position[0], position[1], position[2]))
    // rust: {
    // rust: return Ok(false);
}
    // rust: let old = self.region.block(position)?;
    // rust: self.region.set_block_worldgen(position, state)?;
        // ProtoChunk keeps a block entity that already exists when the same kind
        // of block is set again (a chest turning waterlogged); other changes drop it.
    // rust: let registry = self.decoration.bindings.registry();
    // rust: let same_block = old == state
    // rust: || registry.state(old).map(|s| s.name.as_str())
    // rust: == registry.state(state).map(|s| s.name.as_str());
    // rust: if !same_block {
    // rust: self.block_entities.retain(|(p, _)| *p != position);
}
        // WorldGenRegion.setBlock: BlockState.getPostProcessPos unless UPDATE_KNOWN_SHAPE.
    // rust: if flags & 16 == 0 {
    // rust: let [x, y, z] = position;
    // rust: let mark = if self.decoration.postprocess_self.contains(&state) {
    // rust: Some(y)
    // rust: } else if self.decoration.postprocess_above.contains(&state) {
    // rust: Some(y.wrapping_add(1))
    // rust: } else {
    // rust: None
}
    // rust: if let Some(y) = mark {
    // rust: self.region
    // rust: .chunk_mut(x >> 4, z >> 4)?
    // rust: .mark_postprocessing(x, y, z);
}
}
    // rust: Ok(true)
}
}
pub fn query(e: impl std::fmt::Display) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PlacementQueryError::Failed(e.to_string())
}
/// The blocks whose block entity is a `RandomizableContainer`: every
/// `RandomizableContainerBlockEntity` subclass (chest, trapped chest, barrel,
/// dispenser, dropper, hopper, shulker box, crafter) and the decorated pot, which
/// implements the interface on a plain `BlockEntity`. `RandomizableContainer`'s
/// `setBlockEntityLootTable` hands a loot table to those and to nothing else.
    // rust: const RANDOMIZABLE_CONTAINERS: [&str; 25] = [
    // rust: "minecraft:chest",
    // rust: "minecraft:trapped_chest",
    // rust: "minecraft:barrel",
    // rust: "minecraft:dispenser",
    // rust: "minecraft:dropper",
    // rust: "minecraft:hopper",
    // rust: "minecraft:shulker_box",
    // rust: "minecraft:white_shulker_box",
    // rust: "minecraft:orange_shulker_box",
    // rust: "minecraft:magenta_shulker_box",
    // rust: "minecraft:light_blue_shulker_box",
    // rust: "minecraft:yellow_shulker_box",
    // rust: "minecraft:lime_shulker_box",
    // rust: "minecraft:pink_shulker_box",
    // rust: "minecraft:gray_shulker_box",
    // rust: "minecraft:light_gray_shulker_box",
    // rust: "minecraft:cyan_shulker_box",
    // rust: "minecraft:purple_shulker_box",
    // rust: "minecraft:blue_shulker_box",
    // rust: "minecraft:brown_shulker_box",
    // rust: "minecraft:green_shulker_box",
    // rust: "minecraft:red_shulker_box",
    // rust: "minecraft:black_shulker_box",
    // rust: "minecraft:crafter",
    // rust: "minecraft:decorated_pot",
    // rust: ];
/// Whether the block entity of a block of this name is a `RandomizableContainer`.
/// Every worldgen caller places a chest today, so the wider set is defensive.
pub fn randomizable_container(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: RANDOMIZABLE_CONTAINERS.contains(&name)
}

/// `RandomizableContainer.setBlockEntityLootTable` for a world that keeps block
/// entities as NBT: the compound a randomizable container's block entity takes, or
/// None when the block there is not one. The seed is drawn only where vanilla draws
/// it, inside the `instanceof RandomizableContainer` branch.
    // rust: fn loot_table_nbt(
    // rust: registry: &crate::registry::BlockRegistry,
    // rust: state: BlockStateId,
    // rust: table: &str,
    // rust: random: &mut impl horizon_core::random::RandomSource,
    // rust: ) -> Option<crate::nbt::Compound> {
//     use crate::nbt::Tag;
    // rust: let name = registry.state(state)?.name.to_string();
    // rust: if !randomizable_container(&name) {
    // rust: return None;
}
    // rust: let mut nbt = crate::nbt::Compound::new();
    // rust: nbt.insert("id".into(), Tag::String(name.as_str().into()));
    // rust: nbt.insert("LootTable".into(), Tag::String(table.into()));
    // rust: nbt.insert("LootTableSeed".into(), Tag::Long(random.next_long()));
    // rust: Some(nbt)
}
    // rust: impl<'a> World<'a> {
pub fn blocks(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.ok_or(PlacementQueryError::Unavailable)
}
}
/// Proto chunks hold no block entities, so dynamic shapes resolve to absent.
    // rust: impl DynamicSupportWorld for World<'_> {
    // rust: type Error = PlacementQueryError;
pub fn shulker_is_closed(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(None)
}
    // rust: fn moving_piston_shape(
    // rust: &mut self,
    // rust: _: [i32; 3],
    // rust: ) -> Result<Option<VoxelShape>, PlacementQueryError> {
    // rust: Ok(None)
}
}
    // rust: impl DynamicCollisionWorld for World<'_> {
    // rust: fn shulker_collision_state(
    // rust: &mut self,
    // rust: _: [i32; 3],
    // rust: ) -> Result<Option<ShulkerCollisionState>, PlacementQueryError> {
    // rust: Ok(None)
}
}
    // rust: impl SurvivalWorld for World<'_> {
pub fn fluid_state(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.fluid_state(position)
}
    /// Unlit generation chunks report no sky or block light.
pub fn raw_brightness(self: *Self, _: [i32; 3], _: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0)
}
pub fn block_state(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.block_state(position)
}
}
    // rust: impl PlacementContext for World<'_> {
    // rust: fn state_collision_empty(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let collision = self.blocks()?.collision.clone();
    // rust: collision
    // rust: .collision_shape(self, state, position)
    // rust: .map(|shape| shape.is_empty())
    // rust: .map_err(query)
}
    /// RandomizableContainer.setBlockEntityLootTable: only a container block that
    /// is actually there takes the table, and then it draws the loot seed.
    // rust: fn set_block_entity_loot_table(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: table: &str,
    // rust: random: &mut impl horizon_core::random::RandomSource,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let chunk = self.region.chunk(position[0] >> 4, position[2] >> 4)?;
    // rust: let state = chunk.block(position[0], position[1], position[2]);
    // rust: let registry = self.decoration.bindings.registry();
    // rust: let Some(nbt) = loot_table_nbt(registry, state, table, random) else {
    // rust: return Ok(());
}
    // rust: self.set_block_entity(position, nbt)
}
    /// BeehiveDecorator: `getBlockEntity(pos, BEEHIVE)` then
    /// `storeBee(Occupant.create(ticks))` for each bee.
    // rust: fn store_beehive_occupants(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: ticks_in_hive: &[i32],
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let chunk = self.region.chunk(position[0] >> 4, position[2] >> 4)?;
    // rust: let state = chunk.block(position[0], position[1], position[2]);
    // rust: let registry = self.decoration.bindings.registry();
    // rust: if !matches!(
    // rust: registry.state(state).map(|s| s.name.as_str()),
    // rust: Some("minecraft:bee_nest" | "minecraft:beehive")
    // rust: ) {
    // rust: return Ok(());
}
    // rust: self.set_block_entity(position, super::tree::beehive_occupants(ticks_in_hive))
}
    /// SpawnerBlockEntity.setEntityId: the next spawn data and no potentials.
    // rust: fn configure_spawner(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: entity: &str,
    // rust: ) -> Result<(), PlacementQueryError> {
//         use crate::nbt::Tag;
    // rust: let chunk = self.region.chunk(position[0] >> 4, position[2] >> 4)?;
    // rust: let state = chunk.block(position[0], position[1], position[2]);
    // rust: let registry = self.decoration.bindings.registry();
    // rust: if registry.state(state).map(|s| s.name.as_str()) != Some("minecraft:spawner") {
    // rust: return Ok(());
}
    // rust: let mut mob = crate::nbt::Compound::new();
    // rust: mob.insert("id".into(), Tag::String(entity.into()));
    // rust: let mut data = crate::nbt::Compound::new();
    // rust: data.insert("entity".into(), Tag::Compound(mob));
    // rust: let mut nbt = crate::nbt::Compound::new();
    // rust: nbt.insert("id".into(), Tag::String("minecraft:mob_spawner".into()));
    // rust: nbt.insert("SpawnData".into(), Tag::Compound(data));
    // rust: nbt.insert("SpawnPotentials".into(), Tag::List(Vec::new()));
    // rust: self.set_block_entity(position, nbt)
}
    // rust: fn attachment_at(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let blocks = self.blocks()?;
    // rust: blocks
    // rust: .survival
    // rust: .can_attach_to(self, position, direction)
    // rust: .map_err(query)
}
pub fn next_world_boolean(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.level_random.boolean())
}
pub fn next_world_float(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.level_random.float())
}
pub fn next_world_int(self: *Self, bound: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.level_random.int(bound))
}
    // rust: fn block_survives(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: if let (None, Some(behaviours)) = (self.blocks, self.behaviours) {
    // rust: let mut level = ShapeLevel {
    // rust: world: self,
    // rust: random: horizon_core::random::LegacyRandom::new(0),
}
    // rust: let mut ticks = crate::level::Ticks::new(0);
    // rust: let pos = BlockPos::new(position[0], position[1], position[2]);
    // rust: return Ok(behaviours.can_survive(&mut level, &mut ticks, pos, state));
}
    // rust: let blocks = self.blocks()?;
    // rust: blocks
    // rust: .survival
    // rust: .can_survive(self, state, position)
    // rust: .map_err(query)
}
    // rust: fn face_sturdy(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let state = self.region.block_state(position)?;
    // rust: self.state_face_sturdy(state, position, direction)
}
    // rust: fn state_face_sturdy(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
        // Without the exported support tables, fall back to the gameplay
        // behaviour's empty-level sturdiness cache.
    // rust: if let (None, Some(behaviours)) = (self.blocks, self.behaviours) {
    // rust: return Ok(behaviours.is_face_sturdy(state, direction));
}
    // rust: let support = self.blocks()?.support.clone();
    // rust: support
    // rust: .is_face_sturdy(self, state, position, direction, SupportType::Full)
    // rust: .map_err(query)
}
    // rust: fn center_sturdy(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let state = self.region.block_state(position)?;
    // rust: if let (None, Some(behaviours)) = (self.blocks, self.behaviours) {
    // rust: return Ok(behaviours.is_face_sturdy_center(state, direction));
}
    // rust: let support = self.blocks()?.support.clone();
    // rust: support
    // rust: .is_face_sturdy(self, state, position, direction, SupportType::Center)
    // rust: .map_err(query)
}
pub fn can_occlude(self: *Self, state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(behaviours) = self.behaviours {
    // rust: return Ok(behaviours.has_flag(state, crate::level::data::state_flags::CAN_OCCLUDE));
}
    // rust: let properties = &self.blocks()?.properties;
    // rust: let name = properties
    // rust: .registry()
    // rust: .state(state)
    // rust: .ok_or(PlacementQueryError::Unavailable)?
    // rust: .name
    // rust: .clone();
    // rust: Ok(properties.definition(&name).is_some_and(|d| d.can_occlude))
}
    // rust: fn collision_full_block(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let collision = self.blocks()?.collision.clone();
    // rust: let shape = collision
    // rust: .collision_shape(self, state, position)
    // rust: .map_err(query)?;
    // rust: let [nx, ny, nz] = shape.sizes();
    // rust: Ok(!shape.is_empty()
    // rust: && [Axis::X, Axis::Y, Axis::Z]
    // rust: .into_iter()
    // rust: .all(|axis| shape.min(axis) == 0.0 && shape.max(axis) == 1.0)
    // rust: && (0..nx).all(|x| {
    // rust: (0..ny).all(|y| (0..nz).all(|z| shape.is_full(x as i32, y as i32, z as i32)))
    // rust: }))
}
pub fn add_entity(self: *Self, mut nbt: crate::nbt::Compound) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(mobs) = self.structure_mobs.clone()
    // rust: && nbt.contains_key(&"horizon:finalize".into())
    // rust: {
    // rust: let at = block_of(&nbt).unwrap_or([0; 3]);
    // rust: let biome = self
    // rust: .biome_identity(at)
    // rust: .ok()
    // rust: .and_then(|b| self.biome_names.get(b.0 as usize))
    // rust: .map_or("", |n| &**n)
    // rust: .to_owned();
    // rust: let structures: Vec<String> = self
    // rust: .starts
    // rust: .iter()
    // rust: .filter(|s| s.pieces.iter().any(|p| p.bounding_box().is_inside(at)))
    // rust: .map(|s| s.name.clone())
    // rust: .collect();
    // rust: if mobs.finalize(&mut nbt, &biome, &structures, self.level_random) {
    // rust: nbt.remove(&"horizon:finalize".into());
}
}
    // rust: self.entities.push(nbt);
    // rust: Ok(())
}
    /// SpikeFeature.placeSpike: the crystal is a fresh entity of the region,
    /// saved with the chunk.
    // rust: fn spawn_end_crystal(
    // rust: &mut self,
    // rust: position: [f64; 3],
    // rust: yaw: f32,
    // rust: beam_target: Option<[i32; 3]>,
    // rust: invulnerable: bool,
    // rust: ) -> Result<(), PlacementQueryError> {
//         use crate::nbt::Tag;
    // rust: let mut nbt = crate::nbt::Compound::new();
    // rust: nbt.insert("id".into(), Tag::String("minecraft:end_crystal".into()));
    // rust: nbt.insert(
    // rust: "Pos".into(),
    // rust: Tag::List(position.iter().map(|v| Tag::Double(v.to_bits())).collect()),
    // rust: );
    // rust: nbt.insert(
    // rust: "Rotation".into(),
    // rust: Tag::List(vec![Tag::Float(yaw.to_bits()), Tag::Float(0)]),
    // rust: );
    // rust: nbt.insert("Invulnerable".into(), Tag::Byte(i8::from(invulnerable)));
    // rust: nbt.insert("ShowBottom".into(), Tag::Byte(1));
    // rust: if let Some(b) = beam_target {
    // rust: nbt.insert("beam_target".into(), Tag::IntArray(b.to_vec()));
}
    // rust: self.add_entity(nbt)
}
    // rust: fn set_block_entity(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: nbt: crate::nbt::Compound,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.block_entities.retain(|(p, _)| *p != position);
    // rust: self.block_entities.push((position, nbt));
    // rust: Ok(())
}
    /// WorldGenRegion.getBlockEntity creates the gateway's block entity when the
    /// block is an End gateway; TheEndGatewayBlockEntity.setExitPosition.
    // rust: fn configure_end_gateway(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: exit: [i32; 3],
    // rust: exact: bool,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let chunk = self.region.chunk(position[0] >> 4, position[2] >> 4)?;
    // rust: let state = chunk.block(position[0], position[1], position[2]);
    // rust: let registry = self.decoration.bindings.registry();
    // rust: if registry.state(state).map(|s| s.name.as_str()) != Some("minecraft:end_gateway") {
    // rust: return Ok(());
}
//         use crate::nbt::Tag;
    // rust: let mut nbt = crate::nbt::Compound::new();
    // rust: nbt.insert("id".into(), Tag::String("minecraft:end_gateway".into()));
    // rust: nbt.insert("Age".into(), Tag::Long(0));
    // rust: nbt.insert("exit_portal".into(), Tag::IntArray(exit.to_vec()));
    // rust: if exact {
    // rust: nbt.insert("ExactTeleport".into(), Tag::Byte(1));
}
    // rust: self.set_block_entity(position, nbt)
}
pub fn world_seed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.world_seed()
}
    // rust: fn update_shape_at_face(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: flags: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let Some(behaviours) = self.behaviours else {
    // rust: return Ok(());
}
    // rust: let n = direction.normal();
    // rust: let neighbor_pos = [position[0] + n[0], position[1] + n[1], position[2] + n[2]];
    // rust: let state = self.region.block(position).map_err(query)?;
    // rust: let neighbor = self.region.block(neighbor_pos).map_err(query)?;
    // rust: let (new_state, ticks) = self.shape_update(
    // rust: behaviours,
    // rust: state,
    // rust: position,
    // rust: direction,
    // rust: neighbor_pos,
    // rust: neighbor,
    // rust: );
    // rust: self.schedule_captured(behaviours, ticks)?;
    // rust: if new_state != state {
    // rust: self.set_block(position, new_state, flags & !1)
    // rust: .map_err(query)?;
}
    // rust: let (new_neighbor, ticks) = self.shape_update(
    // rust: behaviours,
    // rust: neighbor,
    // rust: neighbor_pos,
    // rust: direction.opposite(),
    // rust: position,
    // rust: new_state,
    // rust: );
    // rust: self.schedule_captured(behaviours, ticks)?;
    // rust: if new_neighbor != neighbor {
    // rust: self.set_block(neighbor_pos, new_neighbor, flags & !1)
    // rust: .map_err(query)?;
}
    // rust: Ok(())
}
    // rust: fn update_from_neighbour_shapes(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: flags: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let Some(behaviours) = self.behaviours else {
    // rust: return Ok(());
}
    // rust: let state = self.region.block(position).map_err(query)?;
        // Block.UPDATE_SHAPE_ORDER.
    // rust: let mut new_state = state;
    // rust: for direction in [
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: Direction::Down,
    // rust: Direction::Up,
    // rust: ] {
    // rust: let n = direction.normal();
    // rust: let neighbor_pos = [position[0] + n[0], position[1] + n[1], position[2] + n[2]];
    // rust: let neighbor = self.region.block(neighbor_pos).map_err(query)?;
    // rust: let (updated, ticks) = self.shape_update(
    // rust: behaviours,
    // rust: new_state,
    // rust: position,
    // rust: direction,
    // rust: neighbor_pos,
    // rust: neighbor,
    // rust: );
    // rust: self.schedule_captured(behaviours, ticks)?;
    // rust: new_state = updated;
}
    // rust: if new_state != state {
    // rust: self.set_block(position, new_state, flags).map_err(query)?;
}
    // rust: Ok(())
}
pub fn ensure_can_write(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self
    // rust: .zone
    // rust: .contains_block(BlockPos::new(position[0], position[1], position[2])))
}
    /// ProtoChunk.setBlockState: the section and the stage's heightmaps.
    // rust: fn set_chunk_block(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.region
    // rust: .set_block_worldgen(position, state)
    // rust: .map_err(|e| query(format!("{e:?}")))?;
    // rust: Ok(())
}
    /// BulkSectionAccess write: section storage only, no heightmap updates.
    // rust: fn set_section_block(
    // rust: &mut self,
    // rust: [x, y, z]: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.region
    // rust: .chunk_mut(x >> 4, z >> 4)?
    // rust: .set_block_raw(x, y, z, state)
    // rust: .map_err(|e| query(format!("{e:?}")))?;
    // rust: Ok(())
}
    /// Generation regions contain no entities.
pub fn unobstructed_block(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(true)
}
    // rust: fn destroy_block_without_entity(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: _drop_resources: bool,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let chunk = self.region.chunk(position[0] >> 4, position[2] >> 4)?;
    // rust: let state = chunk.block(position[0], position[1], position[2]);
    // rust: if chunk.block_properties(state).is_air() {
    // rust: return Ok(false);
}
    // rust: let air = self
    // rust: .decoration
    // rust: .bindings
    // rust: .registry()
    // rust: .default_state("minecraft:air")
    // rust: .ok_or(PlacementQueryError::Unavailable)?;
    // rust: self.set_block(position, air, 3).map_err(query)
}
    // rust: fn biome_should_freeze(
    // rust: &mut self,
    // rust: biome: BiomeId,
    // rust: position: [i32; 3],
    // rust: require_edge: bool,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let weather = self
    // rust: .decoration
    // rust: .weather
    // rust: .clone()
    // rust: .ok_or(PlacementQueryError::Unavailable)?;
    // rust: let settings = self.temperatures[biome.0 as usize].settings();
    // rust: let mut temperature = std::mem::replace(
    // rust: &mut self.temperatures[biome.0 as usize],
    // rust: BiomeTemperature::new(settings),
    // rust: );
    // rust: let result = weather.should_freeze(self, &mut temperature, position, require_edge);
    // rust: self.temperatures[biome.0 as usize] = temperature;
    // rust: result
}
    // rust: fn biome_should_snow(
    // rust: &mut self,
    // rust: biome: BiomeId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let weather = self
    // rust: .decoration
    // rust: .weather
    // rust: .clone()
    // rust: .ok_or(PlacementQueryError::Unavailable)?;
    // rust: let settings = self.temperatures[biome.0 as usize].settings();
    // rust: let mut temperature = std::mem::replace(
    // rust: &mut self.temperatures[biome.0 as usize],
    // rust: BiomeTemperature::new(settings),
    // rust: );
    // rust: let result = weather.should_snow(self, &mut temperature, position);
    // rust: self.temperatures[biome.0 as usize] = temperature;
    // rust: result
}
    /// Lighting has not run during FEATURES; block light reads zero.
pub fn block_brightness(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0)
}
pub fn fluid_state(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.fluid_state(position)
}
pub fn sea_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.sea_level()
}
    // rust: fn schedule_fluid_tick(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: fluid: FluidKind,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.region.schedule_fluid_tick(position, fluid, delay)
}
pub fn mark_postprocessing(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.mark_postprocessing(position)
}
pub fn water_at(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.water_at(position)
}
    // rust: fn schedule_block_tick(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: block: BlockStateId,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: self.region.schedule_block_tick(position, block, delay)
}
pub fn biome_identity(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(biome) = self.uniform_biome(position) {
    // rust: return Ok(biome);
}
    // rust: self.region
    // rust: .biome_at(
    // rust: &self.biomes,
    // rust: BlockPos::new(position[0], position[1], position[2]),
    // rust: )
    // rust: .copied()
    // rust: .map_err(Into::into)
}
    // rust: fn biome_allows_feature(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: feature: FeatureIdentity,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: let biome = self.biome_identity(position)?;
    // rust: Ok(self.decoration.biome_features[biome.0 as usize].contains(&feature))
}
pub fn block_state(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.block_state(position)
}
    // rust: fn block_matches_tag(
    // rust: &mut self,
    // rust: position: [i32; 3],
    // rust: tag: &str,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: self.region.block_matches_tag(position, tag)
}
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.max_y()
}
pub fn layer_block(self: *Self, position: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.layer_block(position)
}
pub fn generation(self: *Self) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.generation()
}
pub fn min_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.min_y()
}
pub fn height(self: *Self, kind: HeightmapType, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.region.height(kind, x, z)
}
    /// OreFeature's search for a column under its blob, without a trait call
    /// per column. Defers to `height` when a heightmap still has to be primed.
    // rust: fn any_height_at_least(
    // rust: &mut self,
    // rust: kind: HeightmapType,
    // rust: [x0, z0]: [i32; 2],
    // rust: size: i32,
    // rust: y: i32,
    // rust: ) -> Result<Option<bool>, PlacementQueryError> {
    // rust: let (x1, z1) = (x0.wrapping_add(size), z0.wrapping_add(size));
    // rust: if size < 0 || x1 < x0 || z1 < z0 {
    // rust: return Ok(None);
}
    // rust: for cx in x0 >> 4..=x1 >> 4 {
    // rust: for cz in z0 >> 4..=z1 >> 4 {
    // rust: if !self
    // rust: .region
    // rust: .chunk(cx, cz)
    // rust: .is_ok_and(|c| c.heightmap(kind).is_some())
    // rust: {
    // rust: return Ok(None);
}
}
}
        // Any column will do, so each chunk's part of the square is read
        // from its heightmap in one go.
    // rust: for cx in x0 >> 4..=x1 >> 4 {
    // rust: let xs = [x0.max(cx << 4) & 15, x1.min((cx << 4) + 15) & 15];
    // rust: for cz in z0 >> 4..=z1 >> 4 {
    // rust: let zs = [z0.max(cz << 4) & 15, z1.min((cz << 4) + 15) & 15];
    // rust: let map = self.region.chunk(cx, cz)?.heightmap(kind).unwrap();
    // rust: if map.any_first_available_at_least(xs, zs, y) {
    // rust: return Ok(Some(true));
}
}
}
    // rust: Ok(Some(false))
}
}

/// The block an entity's `Pos` is in.
pub fn block_of(nbt: *crate::nbt::Compound) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(crate::nbt::Tag::List(p)) = nbt.get(&"Pos".into()) else {
    // rust: return None;
}
    // rust: Some(std::array::from_fn(|i| match p.get(i) {
    // rust: Some(crate::nbt::Tag::Double(b)) => f64::from_bits(*b).floor() as i32,
    // rust: _ => 0,
    // rust: }))
}

    // rust: mod tests {
//     use super::loot_table_nbt;
//     use crate::registry::BlockRegistry;
//     use horizon_core::random::{LegacyRandom, RandomSource};

    /// Air, a chest, a dispenser and a furnace: one randomizable container the
    /// worldgen callers place, three they do not, and one plain container.
pub fn registry() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let names = [
    // rust: "minecraft:air",
    // rust: "minecraft:chest",
    // rust: "minecraft:dispenser",
    // rust: "minecraft:hopper",
    // rust: "minecraft:shulker_box",
    // rust: "minecraft:light_gray_shulker_box",
    // rust: "minecraft:crafter",
    // rust: "minecraft:decorated_pot",
    // rust: "minecraft:furnace",
    // rust: "minecraft:ender_chest",
    // rust: ];
    // rust: let rows: Vec<serde_json::Value> = names
    // rust: .iter()
    // rust: .map(|name| {
    // rust: serde_json::json!([name, name.ends_with("air"), false, "",
    // rust: {"id": name, "properties": {}}])
    // rust: })
    // rust: .collect();
    // rust: let defaults: serde_json::Map<String, serde_json::Value> = (names.iter().enumerate())
    // rust: .map(|(i, name)| ((*name).to_owned(), serde_json::json!(i)))
    // rust: .collect();
    // rust: let facts = serde_json::json!({"states": rows, "defaults": defaults});
    // rust: let registry = BlockRegistry::from_facts_json(facts.to_string().as_bytes()).unwrap();
    // rust: Box::leak(Box::new(registry))
}

pub fn state(name: []const u8) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: registry().default_state(name).unwrap()
}

    /// `RandomizableContainer.setBlockEntityLootTable` hands the table to the block
    /// entity of any `RandomizableContainer`, not only the chests the two worldgen
    /// callers place today.
pub fn a_randomizable_container_takes_a_loot_table() void {
}
    // rust: for name in [
    // rust: "minecraft:chest",
    // rust: "minecraft:dispenser",
    // rust: "minecraft:hopper",
    // rust: "minecraft:shulker_box",
    // rust: "minecraft:light_gray_shulker_box",
    // rust: "minecraft:crafter",
    // rust: "minecraft:decorated_pot",
    // rust: ] {
    // rust: let mut random = LegacyRandom::new(4);
    // rust: let nbt = loot_table_nbt(
    // rust: registry(),
    // rust: state(name),
    // rust: "minecraft:chests/simple_dungeon",
    // rust: &mut random,
    // rust: )
    // rust: .unwrap_or_else(|| panic!("no loot table for {name}"));
    // rust: assert_eq!(
    // rust: nbt.get(&"id".into()),
    // rust: Some(&crate::nbt::Tag::String(name.into()))
    // rust: );
    // rust: assert_eq!(
    // rust: nbt.get(&"LootTable".into()),
    // rust: Some(&crate::nbt::Tag::String(
    // rust: "minecraft:chests/simple_dungeon".into()
    // rust: ))
    // rust: );
            // The seed is the first long of the random: same seed, same draw.
    // rust: assert_eq!(
    // rust: nbt.get(&"LootTableSeed".into()),
    // rust: Some(&crate::nbt::Tag::Long(LegacyRandom::new(4).next_long()))
    // rust: );
}
}

    /// A block whose block entity is not a `RandomizableContainer` keeps no table,
    /// and the seed is not drawn for it.
pub fn a_plain_container_takes_no_loot_table() void {
}
    // rust: for name in [
    // rust: "minecraft:furnace",
    // rust: "minecraft:ender_chest",
    // rust: "minecraft:air",
    // rust: ] {
    // rust: let mut random = LegacyRandom::new(4);
    // rust: assert!(
    // rust: loot_table_nbt(
    // rust: registry(),
    // rust: state(name),
    // rust: "minecraft:chests/simple_dungeon",
    // rust: &mut random
    // rust: )
    // rust: .is_none(),
    // rust: "{name}"
    // rust: );
    // rust: assert_eq!(
    // rust: random.next_long(),
    // rust: LegacyRandom::new(4).next_long(),
    // rust: "{name}"
    // rust: );
}
}
}
