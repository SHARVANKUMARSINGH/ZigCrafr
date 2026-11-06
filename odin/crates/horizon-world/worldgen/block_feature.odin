//! Transpiled from Horizon Rust crate
package horizon_world_block_feature

import "core:fmt"
import "core:mem"
import "core:math"

// Registry-bound block-writing features and their state codec bindings.
// use super::{
    // rust: DecodeError, Object,
    // rust: density::identifier,
    // rust: feature::FeatureWorld,
    // rust: int_range,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
}
// use crate::block_properties::{BlockPropertiesRegistry, BlockProperty, BoundBlockProperty};
// use crate::registry::{BlockRegistry, BlockStateId, BlockStateJsonCodec};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::Arc,
}

// Block states by block name and by tag name ([`FeatureBlockBindings::bind_tags`]).
    // rust: pub type BoundBlockTags = (
    // rust: Arc<BTreeMap<String, Arc<BTreeSet<BlockStateId>>>>,
    // rust: Arc<BoundTags>,
    // rust: );

// Block tags' states by tag name, each bound the first time it is read: of
// vanilla's 300 block tags (406,779 states in all), world generation reads a
// few dozen. A tag's blocks are checked when it is made, so binding it later
// cannot fail; once bound, reading it takes no lock.
BoundTags :: struct {
    blocks: Arc<BTreeMap<string,
    tags: BTreeMap<,
    // rust: String,
    // rust: (
    // rust: Vec<String>,
    std: :sync::OnceLock<^BTreeSet<BlockStateId>>,
    // rust: ),
    // rust: >,
}
    // rust: impl BoundTags {
    // The states of the tag `name`, bound on first use.
    // rust: pub fn get<Q: Ord + ?Sized>(&self, name: &Q) -> Option<&Arc<BTreeSet<BlockStateId>>>
    // rust: where
    // rust: String: std::borrow::Borrow<Q>,
    // rust: {
    // rust: let (blocks, states) = self.tags.get(name)?;
    // rust: Some(states.get_or_init(|| {
    // rust: Arc::new(
    // rust: blocks
    // rust: .iter()
    // rust: .flat_map(|block| {
    // rust: self.blocks
    // rust: .get::<str>(block)
    // rust: .into_iter()
    // rust: .flat_map(|states| states.iter().copied())
    // rust: })
    // rust: .collect(),
    // rust: )
    // rust: }))
}
}
FeatureBlockBindings :: struct {
    registry: ^'r BlockRegistry,
    // rust: pub(crate) simple_blocks: Option<(
    super: :state_provider::StateProviderBindings<'r>,
    super: :state_provider::StateProviderCatalog,
    crate: :block_placement::BlockPlacementBindings<'r>,
    // rust: )>,
    physical_properties: Option<[BoundBlockProperty,
    // rust: pub(crate) occlusion_faces: Option<crate::block_properties::BoundOcclusionFaces>,
    // rust: pub(crate) can_occlude: Option<BoundBlockProperty>,
    biomes: Maybe(^super::biome_predicate::BiomePredicateBindings),
    // rust: pub(crate) fluids: super::fluid_predicate::FluidPredicateBindings,
    // rust: pub(crate) codec: BlockStateJsonCodec<'r>,
    // rust: pub(crate) blocks: Arc<BTreeMap<String, Arc<BTreeSet<BlockStateId>>>>,
    // rust: pub(crate) tags: Arc<BoundTags>,
    // rust: pub(crate) air: [BlockStateId; 3],
    tree_blocks: std::sync::OnceLock<^super::tree_blocks::TreeBlocks>,
    // rust: pub(crate) structures: Option<Arc<super::structure::StructureResources>>,
}
    // rust: impl<'r> FeatureBlockBindings<'r> {
    // Shared tree/vegetation classifications, built on first use. Requires
    // state-provider and block-property bindings.
    // Bind structure templates and processor lists for template features.
    // rust: pub fn with_structures(
    // rust: mut self,
    // rust: structures: Arc<super::structure::StructureResources>,
    // rust: ) -> Self {
    // rust: self.structures = Some(structures);
    // rust: self
}
    // rust: pub(crate) fn tree_blocks(&self) -> Result<Arc<super::tree_blocks::TreeBlocks>, DecodeError> {
    // rust: if let Some(blocks) = self.tree_blocks.get() {
    // rust: return Ok(blocks.clone());
}
    // rust: let blocks = Arc::new(super::tree_blocks::TreeBlocks::build(self)?);
    // rust: Ok(self.tree_blocks.get_or_init(|| blocks).clone())
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
}
    // BlockState.isSolid (legacy solidity), when block properties are bound.
    // rust: pub(crate) fn solid(&self) -> Result<BoundBlockProperty, DecodeError> {
    // rust: self.physical_properties
    // rust: .as_ref()
    // rust: .map(|p| p[0].clone())
    // rust: .ok_or(DecodeError::Field("block properties"))
}

    // Bind provider resources and precompiled placement operations to this registry.
    // rust: pub fn with_state_providers(
    // rust: mut self,
    // rust: providers: super::state_provider::StateProviderBindings<'r>,
    // rust: catalog: super::state_provider::StateProviderCatalog,
    // rust: placement: crate::block_placement::BlockPlacementBindings<'r>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if !std::ptr::eq(self.registry, providers.registry())
    // rust: || !std::ptr::eq(self.registry, placement.registry())
    // rust: {
    // rust: return Err(DecodeError::Field(
    // rust: "feature provider/placement registry identity",
    // rust: ));
}
    // rust: self.simple_blocks = Some((providers, catalog, placement));
    // rust: Ok(self)
}

    // rust: pub fn with_block_properties(
    // rust: mut self,
    // rust: properties: &BlockPropertiesRegistry<'r>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if !std::ptr::eq(self.registry, properties.registry()) {
    // rust: return Err(DecodeError::Field(
    // rust: "block properties use a different registry",
    // rust: ));
}
    // rust: self.physical_properties = Some([
    // rust: properties.bind(BlockProperty::Solid),
    // rust: properties.bind(BlockProperty::Replaceable),
    // rust: properties.bind(BlockProperty::Liquid),
    // rust: properties.bind(BlockProperty::SolidRender),
    // rust: ]);
    // rust: self.occlusion_faces = Some(properties.bind_occlusion_faces());
    // rust: self.can_occlude = Some(properties.bind_can_occlude());
    // rust: Ok(self)
}
    // rust: pub fn with_biomes(
    // rust: mut self,
    // rust: biomes: Arc<super::biome_predicate::BiomePredicateBindings>,
    // rust: ) -> Self {
    // rust: self.biomes = Some(biomes);
    // rust: self
}

    // rust: pub fn with_fluid_tags(
    // rust: mut self,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: self.fluids = self.fluids.with_resolved_tags(tags)?;
    // rust: Ok(self)
}
    // rust: pub fn new(
    // rust: registry: &'r BlockRegistry,
    // rust: integers: BTreeSet<(String, String)>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::with_tags(registry, integers, &BTreeMap::new())
}
    // Bind an immutable snapshot of already-resolved block tags.
    // rust: pub fn with_tags(
    // rust: registry: &'r BlockRegistry,
    // rust: integers: BTreeSet<(String, String)>,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let bound = Self::bind_tags(registry, tags)?;
    // rust: Self::with_bound_tags(registry, integers, bound)
}
    // Every block's states and every tag's, by name: what `with_tags` binds,
    // to share between the bindings made over the same registry and tags.
    // rust: pub fn bind_tags(
    // rust: registry: &BlockRegistry,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Result<BoundBlockTags, DecodeError> {
    // rust: let mut blocks = BTreeMap::<String, BTreeSet<BlockStateId>>::new();
    // rust: for id in 0..registry.len() {
    // rust: let id = BlockStateId(id as u32);
    // rust: blocks
    // rust: .entry(registry.state(id).unwrap().name.clone())
    // rust: .or_default()
    // rust: .insert(id);
}
    // rust: let mut bound_tags = BTreeMap::new();
    // rust: for (name, entries) in tags {
    // rust: let mut tag_blocks = Vec::with_capacity(entries.len());
    // rust: for name in entries {
    // rust: let block = identifier(name)?;
    // rust: if !blocks.contains_key(&block) {
    // rust: return Err(DecodeError::Registry(format!("unknown block {name}")));
}
    // rust: tag_blocks.push(block);
}
    // rust: if bound_tags
    // rust: .insert(
    // rust: super::tags::identifier(name)?,
    // rust: (tag_blocks, std::sync::OnceLock::new()),
    // rust: )
    // rust: .is_some()
    // rust: {
    // rust: return Err(DecodeError::Field("duplicate block tag"));
}
}
    // rust: let blocks: Arc<BTreeMap<_, _>> = Arc::new(
    // rust: blocks
    // rust: .into_iter()
    // rust: .map(|(name, states)| (name, Arc::new(states)))
    // rust: .collect(),
    // rust: );
    // rust: Ok((
    // rust: blocks.clone(),
    // rust: Arc::new(BoundTags {
    // rust: blocks,
    // rust: tags: bound_tags,
    // rust: }),
    // rust: ))
}
    // [`FeatureBlockBindings::with_tags`] over tags already bound by
    // [`FeatureBlockBindings::bind_tags`].
    // rust: pub fn with_bound_tags(
    // rust: registry: &'r BlockRegistry,
    // rust: integers: BTreeSet<(String, String)>,
    // rust: (blocks, tags): BoundBlockTags,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let codec = BlockStateJsonCodec::new(registry, integers)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))?;
    // rust: let get = |name| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown air block {name}")))
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: simple_blocks: None,
    // rust: codec,
    // rust: biomes: None,
    // rust: physical_properties: None,
    // rust: occlusion_faces: None,
    // rust: can_occlude: None,
    // rust: fluids: super::fluid_predicate::FluidPredicateBindings::new(registry)?,
    // rust: blocks,
    // rust: tags,
    // rust: tree_blocks: std::sync::OnceLock::new(),
    // rust: structures: None,
    // rust: air: [
    // rust: get("minecraft:air")?,
    // rust: get("minecraft:cave_air")?,
    // rust: get("minecraft:void_air")?,
    // rust: ],
    // rust: })
}
}
    // rust: impl super::block_predicate::PredicateBlockResolver for FeatureBlockBindings<'_> {
predicate_state :: proc(self: ^Self, json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.codec
    // rust: .decode(json, false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
}
    // rust: fn predicate_property(
    // rust: &self,
    // rust: property: BlockProperty,
    // rust: ) -> Result<BoundBlockProperty, DecodeError> {
    // rust: super::block_predicate::bound_property(self.physical_properties.as_ref(), property)
}
    // rust: fn predicate_biome_set(
    // rust: &self,
    // rust: json: &str,
    // rust: ) -> Result<Arc<BTreeSet<super::biome::BiomeId>>, DecodeError> {
    // rust: self.biomes
    // rust: .as_ref()
    // rust: .ok_or(DecodeError::Field("predicate biome registry"))?
    // rust: .resolve(json)
}

    // rust: fn predicate_fluid_set(
    // rust: &self,
    // rust: json: &str,
    // rust: ) -> Result<super::fluid_predicate::BoundFluidSet, DecodeError> {
    // rust: self.fluids.resolve(json)
}
predicate_block_set :: proc(self: ^Self, json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Ok(name) = serde_json::from_str::<String>(json) {
    // rust: if let Some(tag) = name.strip_prefix('#') {
    // rust: return self
    // rust: .tags
    // rust: .get(&super::tags::identifier(tag)?)
    // rust: .cloned()
    // rust: .ok_or_else(|| {
    // rust: DecodeError::Registry(format!("unknown predicate block tag {tag}"))
    // rust: });
}
    // rust: return self
    // rust: .blocks
    // rust: .get(&identifier(&name)?)
    // rust: .cloned()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown predicate block {name}")));
}
    // rust: let names: Vec<String> = serde_json::from_str(json)?;
    // rust: if names.len() > 8192 {
    // rust: return Err(DecodeError::Field("predicate block list size"));
}
    // rust: let mut states = BTreeSet::new();
    // rust: for name in names {
    // rust: states.extend(
    // rust: self.blocks
    // rust: .get(&identifier(&name)?)
    // rust: .ok_or_else(|| {
    // rust: DecodeError::Registry(format!("unknown predicate block {name}"))
    // rust: })?
    // rust: .iter()
    // rust: .copied(),
    // rust: );
}
    // rust: Ok(Arc::new(states))
}
}
FillLayerFeature :: struct {
    height: i32,
    state: BlockStateId,
    air: [BlockStateId,
}
BlockFeatureError :: enum {
    World(E),
    Query(PlacementQueryError),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for BlockFeatureError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for BlockFeatureError<E> {}
    // rust: impl FillLayerFeature {
from_json :: proc(json: string, bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: if kind != "minecraft:fill_layer" {
    // rust: return Err(DecodeError::Field("fill-layer feature type"));
}
    // rust: Ok(Self {
    // rust: height: int_range(required(&object, "height")?, "fill-layer height", 0, 4064)?,
    // rust: state: bindings
    // rust: .codec
    // rust: .decode(required(&object, "state")?.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))?,
    // rust: air: bindings.air,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, BlockFeatureError<W::Error>> {
    // rust: for dx in 0..16 {
    // rust: for dz in 0..16 {
                // Vanilla re-queries the world minimum for each column.
    // rust: let y = world
    // rust: .min_y()
    // rust: .map_err(BlockFeatureError::Query)?
    // rust: .wrapping_add(self.height);
    // rust: let position = [origin[0].wrapping_add(dx), y, origin[2].wrapping_add(dz)];
    // rust: let state = world.block(position).map_err(BlockFeatureError::World)?;
    // rust: if self.air.contains(&state) {
    // rust: world
    // rust: .set_block(position, self.state, 2)
    // rust: .map_err(BlockFeatureError::World)?;
}
}
}
    // rust: Ok(true)
}
}

ReplaceBlockFeature :: struct {
    targets: Vec<(super::rule_test::RuleTest,
}
    // rust: impl ReplaceBlockFeature {
from_json :: proc(json: string, bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::decode(json, bindings, 0, &mut 65536)
}
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: if kind != "minecraft:replace_single_block" {
    // rust: return Err(DecodeError::Field("replace-block feature type"));
}
    // rust: let targets = decode_targets(&object, bindings, depth, remaining)?;
    // rust: Ok(Self { targets })
}
    // rust: pub fn place<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl horizon_core::random::RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, BlockFeatureError<W::Error>> {
    // rust: for (rule, state) in &self.targets {
    // rust: let current = world.block(origin).map_err(BlockFeatureError::World)?;
    // rust: if rule.test(current, origin, random) {
    // rust: world
    // rust: .set_block(origin, *state, 2)
    // rust: .map_err(BlockFeatureError::World)?;
    // rust: break;
}
}
    // rust: Ok(true)
}
}

    // rust: pub(crate) type BlockReplacements = Vec<(super::rule_test::RuleTest, BlockStateId)>;
    // rust: pub(crate) fn decode_targets(
    // rust: object: &Object,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<BlockReplacements, DecodeError> {
    // rust: let values: Vec<Box<serde_json::value::RawValue>> =
    // rust: serde_json::from_str(required(object, "targets")?.get())?;
    // rust: if values.len() > 8192 {
    // rust: return Err(DecodeError::Field("replacement targets"));
}
    // rust: values
    // rust: .iter()
    // rust: .map(|value| {
    // rust: let object: Object = serde_json::from_str(value.get())?;
    // rust: Ok((
    // rust: super::rule_test::RuleTest::decode(
    // rust: required(&object, "target")?.get(),
    // rust: bindings,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )?,
    // rust: bindings
    // rust: .codec
    // rust: .decode(required(&object, "state")?.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))?,
    // rust: ))
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()
}

    // rust: mod bound_tag_tests {
//     use super::*;
//     use crate::nbt::Tag;

registry :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let state = |id: &str| Tag::compound([("id", Tag::String(id.into()))]);
    // rust: let log = |axis: &str| {
    // rust: Tag::compound([
    // rust: ("id", Tag::String("minecraft:oak_log".into())),
    // rust: (
    // rust: "properties",
    // rust: Tag::compound([("axis", Tag::String(axis.into()))]),
    // rust: ),
    // rust: ])
}
    // rust: BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(crate::DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![
    // rust: state("minecraft:air"),
    // rust: state("minecraft:stone"),
    // rust: log("x"),
    // rust: log("y"),
    // rust: state("minecraft:dirt"),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound([
    // rust: ("minecraft:air", Tag::Int(0)),
    // rust: ("minecraft:stone", Tag::Int(1)),
    // rust: ("minecraft:oak_log", Tag::Int(3)),
    // rust: ("minecraft:dirt", Tag::Int(4)),
    // rust: ]),
    // rust: ),
    // rust: ]))
    // rust: .unwrap()
}

tags :: proc(entries: ^[(string) {
}
    // rust: entries
    // rust: .iter()
    // rust: .map(|(name, blocks)| {
    // rust: (
    // rust: name.to_string(),
    // rust: blocks.iter().map(|b| b.to_string()).collect(),
    // rust: )
    // rust: })
    // rust: .collect()
}

    // A tag reads as every state of its blocks, whichever is read first; a
    // tag that names an unknown block still fails the binding itself.
tags_read_as_their_blocks_states :: proc() {
}
    // rust: let registry = registry();
    // rust: let (blocks, bound) = FeatureBlockBindings::bind_tags(
    // rust: &registry,
    // rust: &tags(&[
    // rust: ("minecraft:logs", &["minecraft:oak_log"]),
    // rust: ("minecraft:base", &["stone", "minecraft:dirt", "oak_log"]),
    // rust: ("minecraft:empty", &[]),
    // rust: ]),
    // rust: )
    // rust: .unwrap();
    // rust: let ids = |set: &BTreeSet<BlockStateId>| set.iter().map(|s| s.0).collect::<Vec<_>>();
    // rust: assert_eq!(ids(&blocks["minecraft:oak_log"]), [2, 3]);
    // rust: assert_eq!(ids(bound.get("minecraft:base").unwrap()), [1, 2, 3, 4]);
    // rust: assert_eq!(ids(bound.get("minecraft:logs").unwrap()), [2, 3]);
    // rust: assert_eq!(ids(bound.get("minecraft:base").unwrap()), [1, 2, 3, 4]);
    // rust: assert!(bound.get("minecraft:empty").unwrap().is_empty());
    // rust: assert!(bound.get("minecraft:leaves").is_none());
    // rust: let unknown = FeatureBlockBindings::bind_tags(
    // rust: &registry,
    // rust: &tags(&[("minecraft:logs", &["minecraft:birch_log"])]),
    // rust: );
    // rust: assert!(matches!(unknown, Err(DecodeError::Registry(_))));
}
}
