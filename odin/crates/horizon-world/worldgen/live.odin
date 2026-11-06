//! Transpiled from Horizon Rust crate
package horizon_world_live

import "core:fmt"
import "core:mem"
import "core:math"

// Configured and placed features for a live level: what vanilla block
// behaviour reaches through `Feature.place(level, generator, random, pos)`
// on a `ServerLevel` (sapling and fungus growth, bone meal on grass, nylium,
// moss, huge mushrooms). Definitions are decoded lazily by name from the same
// worldgen bundle as decoration and cached.
// use super::{
    // rust: biome::BiomeId,
    // rust: biome_predicate::BiomePredicateBindings,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::{FeatureBlocks, FeatureWorld},
    // rust: feature_catalog::FeatureCatalog,
    // rust: feature_graph::{FeatureDefinition, PlacedFeatureDefinition},
    // rust: generator::{GeneratorData, GeneratorError},
    // rust: placement::PlacementContext,
    // rust: state_provider::{StateProviderBindings, StateProviderCatalog},
    // rust: tags::TagDefinitions,
}
// use crate::block_placement::BlockPlacementBindings;
// use horizon_core::random::RandomSource;
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeSet, HashMap},
    // rust: sync::{Arc, Mutex},
}

    // rust: type Cache<T> = Mutex<HashMap<String, Option<Arc<T>>>>;

LiveFeatures :: struct {
    data: ^GeneratorData,
    catalog: FeatureCatalog,
    bindings: FeatureBlockBindings<'static>,
    blocks: FeatureBlocks,
    configured: Cache<FeatureDefinition>,
    placed: Cache<PlacedFeatureDefinition>,
    // `BiomeGenerationSettings.getBoneMealFeatures` per biome, in vanilla order.
    bone_meal: [dynamic]Vec<string>,
    // Temperature settings per biome (`Biome.getTemperature`).
    temperatures: [dynamic]super::biome_temperature::BiomeTemperatureSettings,
}

resource :: proc(message: impl Into<string>) -> G {
    // Ported from Horizon
    return {}
}
    // rust: GeneratorError::Resource(message.into())
}

// `ConfiguredFeature.getFeatures`: nested configured-feature references of a
// feature JSON, depth first (each reference followed by its own children).
    // rust: fn nested_features(
    // rust: json: &Value,
    // rust: features: &std::collections::BTreeMap<String, String>,
    // rust: depth: usize,
    // rust: out: &mut Vec<String>,
    // rust: ) {
    // rust: if depth > 64 {
    // rust: return;
}
    // rust: match json {
    // rust: Value::Object(map) => {
    // rust: for (key, value) in map {
    // rust: if key == "feature"
    // rust: && let Some(name) = value.as_str()
    // rust: {
    // rust: let name = super::tags::identifier(name).unwrap_or_else(|_| name.to_owned());
    // rust: out.push(name.clone());
    // rust: if let Some(child) = features
    // rust: .get(&name)
    // rust: .and_then(|text| serde_json::from_str::<Value>(text).ok())
    // rust: {
    // rust: nested_features(&child, features, depth + 1, out);
}
    // rust: } else {
    // rust: nested_features(value, features, depth + 1, out);
}
}
}
    // rust: Value::Array(values) => {
    // rust: for value in values {
    // rust: nested_features(value, features, depth + 1, out);
}
}
    // rust: _ => {}
}
}

    // rust: impl LiveFeatures {
    // None when the bundle carries no feature resources.
new :: proc(data: ^^GeneratorData) -> R {
    // Ported from Horizon
    return {}
}
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
        // Configured-feature tag membership (feature_tags names configured features).
    // rust: let mut bone_meal_tag = BTreeSet::new();
    // rust: if let Some(json) = resources
    // rust: .feature_tags
    // rust: .get("minecraft:can_spawn_from_bone_meal")
    // rust: {
    // rust: let value: Value = serde_json::from_str(json)?;
    // rust: for entry in value["values"].as_array().into_iter().flatten() {
    // rust: if let Some(name) = entry.as_str() {
    // rust: bone_meal_tag.insert(super::tags::identifier(name)?);
}
}
}
    // rust: let placed_tags = feature_tags
    // rust: .build(|name, _| resources.placed.contains_key(name).then(|| name.to_owned()))
    // rust: .map_err(|e| resource(format!("feature tags: {e:?}")))?
    // rust: .tags;
    // rust: let mut bone_meal = Vec::with_capacity(data.biome_names().len());
    // rust: for i in 0..data.biome_names().len() {
    // rust: let biome: Value = serde_json::from_str(data.biome_json(BiomeId(i as u32)))?;
    // rust: let mut list = Vec::new();
    // rust: for step in biome["features"].as_array().into_iter().flatten() {
    // rust: let entries: Vec<String> = match step {
    // rust: Value::String(tag) if tag.starts_with('#') => placed_tags
    // rust: .get(&super::tags::identifier(&tag[1..])?)
    // rust: .cloned()
    // rust: .unwrap_or_default(),
    // rust: Value::String(name) => vec![name.clone()],
    // rust: Value::Array(values) => values
    // rust: .iter()
    // rust: .filter_map(|v| v.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: for entry in entries {
    // rust: let name = super::tags::identifier(&entry)?;
    // rust: let Some(placed) = resources
    // rust: .placed
    // rust: .get(&name)
    // rust: .and_then(|text| serde_json::from_str::<Value>(text).ok())
    // rust: else {
    // rust: continue;
}
                    // PlacedFeature.getFeatures: its feature, then that feature's children.
    // rust: let mut found = Vec::new();
    // rust: match &placed["feature"] {
    // rust: Value::String(feature) => {
    // rust: let feature = super::tags::identifier(feature)?;
    // rust: found.push(feature.clone());
    // rust: if let Some(child) = resources
    // rust: .features
    // rust: .get(&feature)
    // rust: .and_then(|text| serde_json::from_str::<Value>(text).ok())
    // rust: {
    // rust: nested_features(&child, &resources.features, 0, &mut found);
}
}
    // rust: inline => nested_features(inline, &resources.features, 0, &mut found),
}
    // rust: list.extend(found.into_iter().filter(|f| bone_meal_tag.contains(f)));
}
}
    // rust: bone_meal.push(list);
}
    // rust: let temperatures = (0..data.biome_names().len())
    // rust: .map(|i| {
    // rust: super::biome_temperature::BiomeTemperatureSettings::from_json(
    // rust: data.biome_json(BiomeId(i as u32)),
    // rust: )
    // rust: })
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: Ok(Some(Self {
    // rust: temperatures,
    // rust: data: data.clone(),
    // rust: catalog,
    // rust: bindings,
    // rust: blocks: FeatureBlocks::from_registry(registry)?,
    // rust: configured: Mutex::new(HashMap::new()),
    // rust: placed: Mutex::new(HashMap::new()),
    // rust: bone_meal,
    // rust: }))
}
data :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.data
}
    // The structure templates and processor lists of this bundle, for the
    // pieces a level places live (`/place structure`).
    // rust: pub(crate) fn structures(&self) -> Option<&super::structure::StructureResources> {
    // rust: self.bindings.structures.as_deref()
}
    // `BlockState.isSolidRender` facts, which legacy structure pieces ask of
    // the blocks around them.
    // rust: pub(crate) fn tree_blocks(&self) -> Option<Arc<super::tree_blocks::TreeBlocks>> {
    // rust: self.bindings.tree_blocks().ok()
}
biome_id :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.data.biome_id(name)
}
    // Raw JSON of a configured feature (for configuration values such as a
    // trunk placer's base height).
configured_json :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let resources = self.data.feature_resources.as_ref()?;
    // rust: serde_json::from_str(resources.features.get(name)?).ok()
}
    // The structure templates and processor lists features place from.
structure_resources :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.bindings.structures.clone()
}
configured :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut cache = self.configured.lock().unwrap();
    // rust: cache
    // rust: .entry(name.to_owned())
    // rust: .or_insert_with(|| {
    // rust: match self
    // rust: .catalog
    // rust: .feature_with_blocks(&Value::from(name).to_string(), &self.bindings)
    // rust: {
    // rust: Ok(f) => Some(Arc::new(f)),
    // rust: Err(e) => {
    // rust: eprintln!("Horizon: feature {name} cannot be placed: {e}");
    // rust: None
}
}
    // rust: })
    // rust: .clone()
}
placed :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut cache = self.placed.lock().unwrap();
    // rust: cache
    // rust: .entry(name.to_owned())
    // rust: .or_insert_with(|| {
    // rust: match self
    // rust: .catalog
    // rust: .placed_feature_with_blocks(&Value::from(name).to_string(), &self.bindings)
    // rust: {
    // rust: Ok(f) => Some(Arc::new(f)),
    // rust: Err(e) => {
    // rust: eprintln!("Horizon: placed feature {name} cannot be placed: {e}");
    // rust: None
}
}
    // rust: })
    // rust: .clone()
}
    // `ConfiguredFeature.place`. Unknown or unsupported features and
    // execution errors report failure.
    // rust: pub fn place_configured<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: name: &str,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> bool
    // rust: where
    // rust: W::Error: std::fmt::Display,
    // rust: {
    // rust: let Some(feature) = self.configured(name) else {
    // rust: return false;
}
    // rust: match feature.place(world, random, origin, self.blocks) {
    // rust: Ok(placed) => placed,
    // rust: Err(e) => {
    // rust: eprintln!("Horizon: placing {name} failed: {e}");
    // rust: false
}
}
}
    // `PlacedFeature.place` (placement modifiers, then the feature).
    // rust: pub fn place_placed<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: name: &str,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> bool
    // rust: where
    // rust: W::Error: std::fmt::Display,
    // rust: {
    // rust: let Some(feature) = self.placed(name) else {
    // rust: return false;
}
    // rust: match feature.place(world, random, origin, self.blocks) {
    // rust: Ok(placed) => placed,
    // rust: Err(e) => {
    // rust: eprintln!("Horizon: placing {name} failed: {e}");
    // rust: false
}
}
}
    // Temperature settings of a biome.
    // rust: pub fn biome_temperature(
    // rust: &self,
    // rust: biome: BiomeId,
    // rust: ) -> Option<super::biome_temperature::BiomeTemperatureSettings> {
    // rust: self.temperatures.get(biome.0 as usize).copied()
}
    // Whether the named biome is in a biome tag (`minecraft:...`).
biome_in_tag :: proc(self: ^Self, biome: string, tag: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.data
    // rust: .biome_tags
    // rust: .get(tag)
    // rust: .is_some_and(|members| members.iter().any(|m| m == biome))
}
    // A block tag's members in registry tag order (for `getRandomElementOf`).
block_tag_entries :: proc(self: ^Self, tag: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.data.block_tags.get(tag).map_or(&[], Vec::as_slice)
}
    // `BiomeGenerationSettings.getBoneMealFeatures` of a biome.
bone_meal_features :: proc(self: ^Self, biome: BiomeId) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.bone_meal
    // rust: .get(biome.0 as usize)
    // rust: .map_or(&[], Vec::as_slice)
}
}
