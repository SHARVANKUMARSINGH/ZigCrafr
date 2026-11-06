//! Transpiled from Horizon Rust crate
package horizon_world_state_provider

import "core:fmt"
import "core:mem"
import "core:math"

// Initial block-state providers, bound to immutable block and tag identities.
    // rust: mod catalog;
    // rust: mod noise;
    // rust: pub use catalog::StateProviderCatalog;
    // rust: pub(crate) mod properties;
// use super::{
    // rust: DecodeError, Object,
    // rust: block_predicate::{BlockPredicate, PredicateBlockResolver},
    // rust: density::identifier,
    // rust: feature::FeatureWorld,
    // rust: optional,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: value_provider::IntProvider,
    // rust: weighted::WeightedList,
}
// use crate::block_properties::{BlockPropertiesRegistry, BlockProperty, BoundBlockProperty};
// use crate::registry::{BlockRegistry, BlockStateId, BlockStateJsonCodec};
// use horizon_core::random::{InvalidBound, RandomSource};
// use noise::NoiseProvider;
// use properties::StateProperties;
// use serde_json::value::RawValue;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::{Arc, OnceLock},
}
DIRECTIONS :: ["down", "up", "north", "south", "west", "east"]
    // rust: type Rotations = Arc<Vec<[BlockStateId; 6]>>;

StateProviderBindings :: struct {
    physical_properties: Option<[BoundBlockProperty,
    biomes: Maybe(^super::biome_predicate::BiomePredicateBindings),
    fluids: super::fluid_predicate::FluidPredicateBindings,
    codec: BlockStateJsonCodec<'r>,
    blocks: BTreeMap<string,
    tags: BTreeMap<string,
    registry: ^'r BlockRegistry,
    rotations: OnceLock<Result<Rotations,
    integers: BTreeSet<(string,
    properties: OnceLock<Result<^StateProperties,
    predicate_states: OnceLock<BTreeMap<BlockStateId,
}
    // rust: impl<'r> StateProviderBindings<'r> {
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
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
    // Resolved tag lists preserve holder order, including an empty named set.
    // rust: pub fn new(
    // rust: registry: &'r BlockRegistry,
    // rust: integers: BTreeSet<(String, String)>,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let codec = BlockStateJsonCodec::new(registry, integers.clone())
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))?;
    // rust: let mut blocks = BTreeMap::new();
    // rust: for index in 0..registry.len() {
    // rust: let name = &registry.state(BlockStateId(index as u32)).unwrap().name;
    // rust: blocks
    // rust: .entry(name.clone())
    // rust: .or_insert_with(|| registry.default_state(name).unwrap());
}
    // rust: let mut bound_tags = BTreeMap::new();
    // rust: for (name, entries) in tags {
    // rust: if entries.len() > MAX_TAG_BLOCKS {
    // rust: return Err(DecodeError::Field("provider tag size"));
}
    // rust: let values = entries
    // rust: .iter()
    // rust: .map(|name| {
    // rust: blocks
    // rust: .get(&identifier(name)?)
    // rust: .copied()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown block {name}")))
    // rust: })
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: if bound_tags
    // rust: .insert(super::tags::identifier(name)?, Arc::new(values))
    // rust: .is_some()
    // rust: {
    // rust: return Err(DecodeError::Field("duplicate provider block tag"));
}
}
    // rust: Ok(Self {
    // rust: codec,
    // rust: biomes: None,
    // rust: physical_properties: None,
    // rust: fluids: super::fluid_predicate::FluidPredicateBindings::new(registry)?,
    // rust: blocks,
    // rust: tags: bound_tags,
    // rust: registry,
    // rust: rotations: OnceLock::new(),
    // rust: integers,
    // rust: properties: OnceLock::new(),
    // rust: predicate_states: OnceLock::new(),
    // rust: })
}
state :: proc(self: ^Self, json: string, full: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.codec
    // rust: .decode(json, full)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
}
rotations :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.rotations
    // rust: .get_or_init(|| rotation_table(self.registry))
    // rust: .clone()
    // rust: .map_err(DecodeError::Registry)
}
    // rust: pub(crate) fn properties(&self) -> Result<Arc<StateProperties>, DecodeError> {
    // rust: self.properties
    // rust: .get_or_init(|| StateProperties::build(self.registry, &self.integers).map(Arc::new))
    // rust: .clone()
    // rust: .map_err(DecodeError::Registry)
}
block_set :: proc(self: ^Self, raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Ok(name) = serde_json::from_str::<String>(raw.get()) {
    // rust: if let Some(tag) = name.strip_prefix('#') {
    // rust: return self
    // rust: .tags
    // rust: .get(&super::tags::identifier(tag)?)
    // rust: .cloned()
    // rust: .ok_or_else(|| {
    // rust: DecodeError::Registry(format!("unknown provider block tag {tag}"))
    // rust: });
}
    // rust: let state = self
    // rust: .blocks
    // rust: .get(&identifier(&name)?)
    // rust: .copied()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown block {name}")))?;
    // rust: return Ok(Arc::new(vec![state]));
}
    // rust: let names: Vec<String> = serde_json::from_str(raw.get())?;
    // rust: if names.len() > 8192 {
    // rust: return Err(DecodeError::Field("provider block list size"));
}
    // rust: Ok(Arc::new(
    // rust: names
    // rust: .iter()
    // rust: .map(|name| {
    // rust: self.blocks
    // rust: .get(&identifier(name)?)
    // rust: .copied()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown block {name}")))
    // rust: })
    // rust: .collect::<Result<Vec<_>, _>>()?,
    // rust: ))
}
}
    // rust: impl PredicateBlockResolver for StateProviderBindings<'_> {
predicate_state :: proc(self: ^Self, json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.state(json, false)
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
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: let defaults = self.block_set(&raw)?;
    // rust: let states = self.predicate_states.get_or_init(|| {
    // rust: let mut states = BTreeMap::<BlockStateId, BTreeSet<BlockStateId>>::new();
    // rust: for id in 0..self.registry.len() {
    // rust: let id = BlockStateId(id as u32);
    // rust: let default = self.blocks[&self.registry.state(id).unwrap().name];
    // rust: states.entry(default).or_default().insert(id);
}
    // rust: states
    // rust: .into_iter()
    // rust: .map(|(id, values)| (id, Arc::new(values)))
    // rust: .collect()
    // rust: });
    // rust: if defaults.len() == 1 {
    // rust: return Ok(states[&defaults[0]].clone());
}
    // rust: Ok(Arc::new(
    // rust: defaults
    // rust: .iter()
    // rust: .flat_map(|id| states[id].iter().copied())
    // rust: .collect(),
    // rust: ))
}
}
BlockStateProvider :: struct {
Node :: enum {
    RuleBased {,
    fallback: Maybe(^BlockStateProvider),
    rules: Vec<(BlockPredicate,
    // rust: },
    Noise(Box<NoiseProvider>),
    Simple(BlockStateId),
    Weighted(WeightedList<BlockStateId>),
    RandomBlock(Arc<Vec<BlockStateId>>),
    Rotated {,
    source: ^BlockStateProvider,
    direction: Maybe(uint),
    rotations: Rotations,
    // rust: },
    CopyProperties(Box<BlockStateProvider>, Arc<StateProperties>),
    RandomizedInt {,
    source: ^BlockStateProvider,
    property: string,
    values: IntProvider,
    properties: ^StateProperties,
    // rust: },
}
StateProviderError :: enum {
    Random(InvalidBound),
    World(E),
    Query(PlacementQueryError),
    InvalidState,
    InvalidPropertyValue,
    EmptyNoiseSelection,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for StateProviderError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Random(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::InvalidState => f.write_str("unregistered provider source state"),
    // rust: Self::InvalidPropertyValue => f.write_str("invalid randomized property value"),
    // rust: Self::EmptyNoiseSelection => f.write_str("empty dual-noise state selection"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for StateProviderError<E> {}
    // rust: impl<E> From<InvalidBound> for StateProviderError<E> {
from :: proc(e: InvalidBound) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::Random(e)
}
}
    // rust: impl BlockStateProvider {
    // Native DIRECT_CODEC is an exclusive choice: exactly one of a full state
    // object and a typed provider must decode. Compact state strings are not
    // direct providers; named provider holders are a separate registry layer.
    // rust: pub fn from_json(
    // rust: json: &str,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::decode(json, bindings, 0, &mut 65536, None)
}
    // rust: fn decode_holder(
    // rust: json: &str,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: catalog: Option<&StateProviderCatalog>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth > 128 || *remaining == 0 {
    // rust: return Err(DecodeError::Field(
    // rust: "state provider resource expansion limit",
    // rust: ));
}
    // rust: if let Ok(name) = serde_json::from_str::<String>(json) {
    // rust: let name = identifier(&name)?;
    // rust: let resource = catalog
    // rust: .and_then(|c| c.lookup(&name))
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown state provider {name}")))?;
    // rust: *remaining -= 1;
    // rust: Self::decode(resource, bindings, depth + 1, remaining, catalog)
    // rust: } else {
    // rust: Self::decode(json, bindings, depth, remaining, catalog)
}
}
    // rust: fn decode(
    // rust: json: &str,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: catalog: Option<&StateProviderCatalog>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth > 128 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("state provider depth"));
}
    // rust: match (
    // rust: bindings.state(json, true),
    // rust: Self::decode_typed(json, bindings, depth, remaining, catalog),
    // rust: ) {
    // rust: (Ok(state), Err(_)) => Ok(Self(Node::Simple(state))),
    // rust: (Err(_), Ok(provider)) => Ok(provider),
    // rust: _ => Err(DecodeError::Field("exclusive state or provider")),
}
}
    // rust: fn decode_typed(
    // rust: json: &str,
    // rust: bindings: &StateProviderBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: catalog: Option<&StateProviderCatalog>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth > 128 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("state provider depth"));
}
    // rust: *remaining -= 1;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: Ok(Self(match kind.as_str() {
    // rust: "minecraft:rule_based" => {
    // rust: let fallback = optional(&object, "fallback")
    // rust: .map(|raw| {
    // rust: Self::decode_holder(raw.get(), bindings, depth + 1, remaining, catalog)
    // rust: .map(Box::new)
    // rust: })
    // rust: .transpose()?;
    // rust: let raw_rules: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "rules")?.get())?;
    // rust: if raw_rules.len() > 8192 {
    // rust: return Err(DecodeError::Field("provider rule count"));
}
    // rust: let mut rules = Vec::with_capacity(raw_rules.len());
    // rust: for raw in raw_rules {
    // rust: if *remaining == 0 {
    // rust: return Err(DecodeError::Field("provider node count"));
}
    // rust: *remaining -= 1;
    // rust: let rule: Object = serde_json::from_str(raw.get())?;
    // rust: let predicate = BlockPredicate::decode_with_blocks(
    // rust: required(&rule, "if_true")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: Some(bindings),
    // rust: )?;
    // rust: let provider = Self::decode_holder(
    // rust: required(&rule, "then")?.get(),
    // rust: bindings,
    // rust: depth + 1,
    // rust: remaining,
    // rust: catalog,
    // rust: )?;
    // rust: rules.push((predicate, provider));
}
    // rust: Node::RuleBased { fallback, rules }
}
    // rust: "minecraft:noise" | "minecraft:noise_threshold" | "minecraft:dual_noise" => {
    // rust: Node::Noise(Box::new(NoiseProvider::decode(&object, bindings, &kind)?))
}
    // rust: "minecraft:simple" => {
    // rust: Node::Simple(bindings.state(required(&object, "state")?.get(), false)?)
}
    // rust: "minecraft:weighted" => {
    // rust: Node::Weighted(WeightedList::decode(required(&object, "entries")?, |v| {
    // rust: bindings.state(v.get(), false)
    // rust: })?)
}
    // rust: "minecraft:random_block" => {
    // rust: Node::RandomBlock(bindings.block_set(required(&object, "blocks")?)?)
}
    // rust: "minecraft:rotated" => {
    // rust: let direction = optional(&object, "direction")
    // rust: .map(|v| {
    // rust: let name: String = serde_json::from_str(v.get())?;
    // rust: DIRECTIONS
    // rust: .iter()
    // rust: .position(|v| *v == name)
    // rust: .ok_or(DecodeError::Field("provider direction"))
    // rust: })
    // rust: .transpose()?;
    // rust: Node::Rotated {
    // rust: source: Box::new(Self::decode_holder(
    // rust: required(&object, "state")?.get(),
    // rust: bindings,
    // rust: depth + 1,
    // rust: remaining,
    // rust: catalog,
    // rust: )?),
    // rust: direction,
    // rust: rotations: bindings.rotations()?,
}
}
    // rust: "minecraft:copy_properties" => Node::CopyProperties(
    // rust: Box::new(Self::decode_holder(
    // rust: required(&object, "source")?.get(),
    // rust: bindings,
    // rust: depth + 1,
    // rust: remaining,
    // rust: catalog,
    // rust: )?),
    // rust: bindings.properties()?,
    // rust: ),
    // rust: "minecraft:randomized_int" => Node::RandomizedInt {
    // rust: source: Box::new(Self::decode_holder(
    // rust: required(&object, "source")?.get(),
    // rust: bindings,
    // rust: depth + 1,
    // rust: remaining,
    // rust: catalog,
    // rust: )?),
    // rust: property: serde_json::from_str(required(&object, "property")?.get())?,
    // rust: values: IntProvider::decode(required(&object, "values")?, depth + 1, remaining)?,
    // rust: properties: bindings.properties()?,
    // rust: },
    // rust: _ => return Err(DecodeError::Field("block state provider type")),
    // rust: }))
}
    // rust: pub fn get_optional_state<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: ) -> Result<Option<BlockStateId>, StateProviderError<W::Error>> {
    // rust: Ok(match &self.0 {
    // rust: Node::RuleBased { fallback, rules } => {
    // rust: for (predicate, provider) in rules {
    // rust: if predicate
    // rust: .test(world, position)
    // rust: .map_err(StateProviderError::Query)?
    // rust: {
    // rust: if let Some(state) = provider.get_optional_state(world, random, position)? {
    // rust: return Ok(Some(state));
}
}
}
    // rust: match fallback {
    // rust: Some(provider) => provider.get_optional_state(world, random, position)?,
    // rust: None => None,
}
}
    // rust: Node::Noise(provider) => Some(provider.sample(random, position)?),
    // rust: Node::Simple(state) => Some(*state),
    // rust: Node::Weighted(states) => Some(*states.sample(random)?),
    // rust: Node::RandomBlock(states) => {
    // rust: if states.is_empty() {
    // rust: None
    // rust: } else {
    // rust: Some(states[random.next_int_bound(states.len() as i32)? as usize])
}
}
    // rust: Node::Rotated {
    // rust: source,
    // rust: direction,
    // rust: rotations,
    // rust: } => {
                // Native orientation selection precedes the nested state draw.
    // rust: let direction = match direction {
    // rust: Some(value) => *value,
    // rust: None => random.next_int_bound(6)? as usize,
}
    // rust: let state = source.get_state(world, random, position)?;
    // rust: Some(
    // rust: rotations
    // rust: .get(state.0 as usize)
    // rust: .ok_or(StateProviderError::InvalidState)?[direction],
    // rust: )
}
    // rust: Node::CopyProperties(source, properties) => {
    // rust: let target = source.get_state(world, random, position)?;
    // rust: let source = world.block(position).map_err(StateProviderError::World)?;
    // rust: Some(
    // rust: properties
    // rust: .copy(target, source)
    // rust: .ok_or(StateProviderError::InvalidState)?,
    // rust: )
}
    // rust: Node::RandomizedInt {
    // rust: source,
    // rust: property,
    // rust: values,
    // rust: properties,
    // rust: } => {
    // rust: let state = source.get_state(world, random, position)?;
    // rust: if properties
    // rust: .has_integer(state, property)
    // rust: .ok_or(StateProviderError::InvalidState)?
    // rust: {
    // rust: let value = values.sample(random)?;
    // rust: Some(
    // rust: properties
    // rust: .set_integer(state, property, value)
    // rust: .ok_or(StateProviderError::InvalidPropertyValue)?,
    // rust: )
    // rust: } else {
    // rust: Some(state)
}
}
    // rust: })
}
    // rust: pub fn get_state<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: ) -> Result<BlockStateId, StateProviderError<W::Error>> {
    // rust: match self.get_optional_state(world, random, position)? {
    // rust: Some(state) => Ok(state),
    // rust: None => world.block(position).map_err(StateProviderError::World),
}
}
}

// Blocks a bound block tag may list (8,192 before content mods, vanilla's
// tags fit well within it): content mods' blocks join the shared tags
// (`mineable/pickaxe` takes every stone block of a pack).
    // rust: pub(crate) const MAX_TAG_BLOCKS: usize = 1 << 20;

// Bind the pinned registry's full-axis/full-facing/horizontal-facing property
// families. A five-way facing or two-axis property is a different property and
// is intentionally left unchanged. Unrelated properties retain their values.
rotation_table :: proc(registry: ^BlockRegistry) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut values = BTreeMap::<(&str, &str), BTreeSet<&str>>::new();
    // rust: for index in 0..registry.len() {
    // rust: let state = registry.state(BlockStateId(index as u32)).unwrap();
    // rust: for name in ["axis", "facing"] {
    // rust: if let Some(value) = state.properties.get(name) {
    // rust: values
    // rust: .entry((state.name.as_str(), name))
    // rust: .or_default()
    // rust: .insert(value.as_str());
}
}
}
    // rust: let axis: BTreeSet<&str> = ["x", "y", "z"].into_iter().collect();
    // rust: let facing: BTreeSet<&str> = DIRECTIONS.into_iter().collect();
    // rust: let horizontal: BTreeSet<&str> = DIRECTIONS[2..].iter().copied().collect();
    // rust: let mut result = Vec::with_capacity(registry.len());
    // rust: for index in 0..registry.len() {
    // rust: let id = BlockStateId(index as u32);
    // rust: let state = registry.state(id).unwrap();
    // rust: let full_axis = values.get(&(state.name.as_str(), "axis")) == Some(&axis);
    // rust: let directions = values.get(&(state.name.as_str(), "facing"));
    // rust: let mut rotated = [id; 6];
        // Most states have neither family: every rotation is the state itself.
    // rust: if !full_axis && directions != Some(&facing) && directions != Some(&horizontal) {
    // rust: result.push(rotated);
    // rust: continue;
}
    // rust: for (direction, name) in DIRECTIONS.iter().enumerate() {
    // rust: let axis_value = full_axis.then_some(["y", "y", "z", "z", "x", "x"][direction]);
    // rust: let facing_value = (directions == Some(&facing)
    // rust: || (direction >= 2 && directions == Some(&horizontal)))
    // rust: .then_some(*name);
            // A rotation that sets what the state already has is the state.
    // rust: let unchanged = axis_value
    // rust: .is_none_or(|v| state.properties.get("axis").map(String::as_str) == Some(v))
    // rust: && facing_value
    // rust: .is_none_or(|v| state.properties.get("facing").map(String::as_str) == Some(v));
    // rust: if unchanged {
    // rust: continue;
}
    // rust: let mut value = state.clone();
    // rust: if let Some(v) = axis_value {
    // rust: value.properties.insert("axis".into(), v.into());
}
    // rust: if let Some(v) = facing_value {
    // rust: value.properties.insert("facing".into(), v.into());
}
    // rust: rotated[direction] = registry
    // rust: .id(&value)
    // rust: .ok_or_else(|| "incomplete rotation state registry".to_owned())?;
}
    // rust: result.push(rotated);
}
    // rust: Ok(Arc::new(result))
}

    // rust: mod tests {
//     use super::*;
//     use crate::nbt::Tag;

    // air, stone, oak_log axis x/y/z, furnace facing the four horizontal
    // ways, observer facing all six with `powered` false then true, and a
    // hopper's five-way facing.
registry :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let state = |id: &str, props: &[(&str, &str)]| {
    // rust: let mut entries = vec![("id", Tag::String(id.into()))];
    // rust: if !props.is_empty() {
    // rust: entries.push((
    // rust: "properties",
    // rust: Tag::compound(
    // rust: props
    // rust: .iter()
    // rust: .map(|(k, v)| (*k, Tag::String((*v).into())))
    // rust: .collect::<Vec<_>>(),
    // rust: ),
    // rust: ));
}
    // rust: Tag::compound(entries)
}
    // rust: let mut states = vec![state("minecraft:air", &[]), state("minecraft:stone", &[])];
    // rust: for axis in ["x", "y", "z"] {
    // rust: states.push(state("minecraft:oak_log", &[("axis", axis)]));
}
    // rust: for facing in ["north", "south", "west", "east"] {
    // rust: states.push(state("minecraft:furnace", &[("facing", facing)]));
}
    // rust: for powered in ["false", "true"] {
    // rust: for facing in DIRECTIONS {
    // rust: states.push(state(
    // rust: "minecraft:observer",
    // rust: &[("facing", facing), ("powered", powered)],
    // rust: ));
}
}
    // rust: for facing in ["down", "north", "south", "west", "east"] {
    // rust: states.push(state("minecraft:hopper", &[("facing", facing)]));
}
    // rust: BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(crate::DATA_VERSION)),
    // rust: ("states", Tag::List(states)),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound([
    // rust: ("minecraft:air", Tag::Int(0)),
    // rust: ("minecraft:stone", Tag::Int(1)),
    // rust: ("minecraft:oak_log", Tag::Int(3)),
    // rust: ("minecraft:furnace", Tag::Int(5)),
    // rust: ("minecraft:observer", Tag::Int(9)),
    // rust: ("minecraft:hopper", Tag::Int(21)),
    // rust: ]),
    // rust: ),
    // rust: ]))
    // rust: .unwrap()
}

    // Rotations follow the direction (down, up, north, south, west, east):
    // a full axis turns, horizontal facing turns only for the four sides,
    // full facing turns all six ways keeping its other properties, and a
    // five-way facing or a block without these properties stays as it is.
rotations_turn_axis_and_facing_families_only :: proc() {
}
    // rust: let registry = registry();
    // rust: let table = rotation_table(&registry).unwrap();
    // rust: let ids = |state: u32| table[state as usize].map(|id| id.0);
    // rust: assert_eq!(ids(1), [1; 6], "stone");
    // rust: assert_eq!(ids(3), [3, 3, 4, 4, 2, 2], "oak_log axis=y");
    // rust: assert_eq!(ids(2), [3, 3, 4, 4, 2, 2], "oak_log axis=x");
    // rust: assert_eq!(ids(6), [6, 6, 5, 6, 7, 8], "furnace facing=south");
    // rust: assert_eq!(
    // rust: ids(16),
    // rust: [15, 16, 17, 18, 19, 20],
    // rust: "observer powered=true facing=up"
    // rust: );
    // rust: assert_eq!(
    // rust: ids(9),
    // rust: [9, 10, 11, 12, 13, 14],
    // rust: "observer powered=false facing=down"
    // rust: );
    // rust: assert_eq!(ids(22), [22; 6], "hopper facing=north");
}
}
