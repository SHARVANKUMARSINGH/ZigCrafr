//! Transpiled from Horizon Rust crate
package horizon_world_library

import "core:fmt"
import "core:mem"
import "core:math"

// Immutable material-rule definitions with a world-seeded density compiler.
// use super::{MaterialCondition, MaterialConditionRegistry, MaterialRule, codec::identifier};
// use crate::{
    // rust: registry::{BlockStateId, BlockStateJsonCodec},
    // rust: worldgen::{
    // rust: DecodeError, Object,
    // rust: aquifer::{AquiferConfig, AquiferSamplers},
    // rust: density::DensityRegistry,
    // rust: number_text, required,
    // rust: router::{NoiseRouter, RouterSamplers},
    // rust: },
}
// use horizon_core::density::{
    // rust: DensitySampler,
    // rust: graph::{DensityCompiler, FunctionId},
}
// use serde_json::value::RawValue;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::Arc,
}

Definition :: enum {
    Block(BlockStateId),
    Bandlands,
    Sequence(Vec<Arc<Self>>),
    Condition(MaterialCondition, Arc<Self>),
    Reference(Arc<Self>),
    Ore {,
    blocks: [BlockStateId; 3],
    chance: f32,
    roots: [usize; 3],
    // rust: },
}

// Definitions are decoded atomically. Density samplers are compiled lazily for
// this world's seed; create workers with the same seed/random mode and a fresh
// cached SamplerContext per worker. The library does not own mutable chunk data.
MaterialRuleLibrary :: struct {
    definitions: BTreeMap<string,
    roots: [dynamic]FunctionId,
    compiler: DensityCompiler,
    compiled: BTreeMap<uint,
}
    // rust: impl MaterialRuleLibrary {
    // rust: pub fn from_json(
    // rust: definitions: &BTreeMap<String, String>,
    // rust: conditions: &MaterialConditionRegistry,
    // rust: blocks: &BlockStateJsonCodec<'_>,
    // rust: mut densities: DensityRegistry,
    // rust: seed: i64,
    // rust: legacy: bool,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if definitions.len() > 8192 {
    // rust: return Err(DecodeError::Field("material rule registry size"));
}
    // rust: let mut raw = BTreeMap::new();
    // rust: for (name, json) in definitions {
    // rust: let value: Box<RawValue> = serde_json::from_str(json)?;
    // rust: if raw.insert(identifier(name)?, value).is_some() {
    // rust: return Err(DecodeError::Field("duplicate material rule"));
}
}
    // rust: let mut loader = Loader {
    // rust: raw,
    // rust: values: BTreeMap::new(),
    // rust: active: BTreeSet::new(),
    // rust: conditions,
    // rust: blocks,
    // rust: roots: Vec::new(),
    // rust: nodes: 0,
}
    // rust: for name in loader.raw.keys().cloned().collect::<Vec<_>>() {
    // rust: loader.resolve(&name, 0)?;
}
    // rust: let roots = densities
    // rust: .decode_functions(&loader.roots.iter().map(String::as_str).collect::<Vec<_>>())?;
    // rust: Ok(Self {
    // rust: definitions: loader.values,
    // rust: roots,
    // rust: compiler: DensityCompiler::new_seeded(densities.into_graph(), seed, legacy),
    // rust: compiled: BTreeMap::new(),
    // rust: })
}
names :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.definitions.keys().map(String::as_str)
}
    // Resolve a named rule without sampling chunk densities yet. Binding the
    // returned rule to MaterialConditions performs eager per-chunk sampling.
rule :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let definition = self
    // rust: .definitions
    // rust: .get(&identifier(name)?)
    // rust: .ok_or(DecodeError::Field("unknown material rule"))?
    // rust: .clone();
    // rust: Ok(MaterialRule::Reference(self.compile(&definition)?))
}
    // Share this compiler's cache namespace with preliminary surface sampling.
named_density :: proc(self: ^Self, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = self
    // rust: .compiler
    // rust: .graph()
    // rust: .function(&identifier(name)?)
    // rust: .ok_or(DecodeError::Field("unknown material density"))?;
    // rust: Ok(self.compiler.get_sampler(id)?)
}
    // The sampler of a function decoded into the density registry passed to
    // `from_json`, sharing this compiler's cache namespace.
    // rust: pub fn function_sampler(
    // rust: &mut self,
    // rust: id: FunctionId,
    // rust: ) -> Result<Arc<dyn DensitySampler>, DecodeError> {
    // rust: Ok(self.compiler.get_sampler(id)?)
}
    // Compile a router decoded into the density registry passed to `from_json`.
    // Its roots share cache IDs with all material and aquifer samplers.
compile_router :: proc(self: ^Self, router: NoiseRouter) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(router.compile(&mut self.compiler)?)
}
    // Compile an aquifer decoded into the same density registry as this library.
    // Reuse the returned roots and the router in one worker's sampler context.
    // rust: pub fn compile_aquifer(
    // rust: &mut self,
    // rust: config: AquiferConfig,
    // rust: ) -> Result<AquiferSamplers, DecodeError> {
    // rust: Ok(config.compile(&mut self.compiler)?)
}
compile :: proc(self: ^Self, definition: ^^Definition) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let key = Arc::as_ptr(definition) as usize;
    // rust: if let Some(value) = self.compiled.get(&key) {
    // rust: return Ok(value.clone());
}
    // rust: let value = Arc::new(match definition.as_ref() {
    // rust: Definition::Block(id) => MaterialRule::Block(*id),
    // rust: Definition::Bandlands => MaterialRule::Bandlands,
    // rust: Definition::Reference(value) => MaterialRule::Reference(self.compile(value)?),
    // rust: Definition::Sequence(children) => MaterialRule::Sequence(
    // rust: children
    // rust: .iter()
    // rust: .map(|child| self.compile(child).map(MaterialRule::Reference))
    // rust: .collect::<Result<_, _>>()?,
    // rust: ),
    // rust: Definition::Condition(condition, child) => MaterialRule::Condition {
    // rust: if_true: condition.clone(),
    // rust: then_run: Box::new(MaterialRule::Reference(self.compile(child)?)),
    // rust: },
    // rust: Definition::Ore {
    // rust: blocks,
    // rust: chance,
    // rust: roots,
    // rust: } => MaterialRule::OreVein {
    // rust: ore: blocks[0],
    // rust: raw_ore: blocks[1],
    // rust: filler: blocks[2],
    // rust: raw_ore_chance: *chance,
    // rust: density: self.compiler.get_sampler(self.roots[roots[0]])?,
    // rust: richness: self.compiler.get_sampler(self.roots[roots[1]])?,
    // rust: filler_gap: self.compiler.get_sampler(self.roots[roots[2]])?,
    // rust: positive_y: self
    // rust: .compiler
    // rust: .graph()
    // rust: .positive_y_bounds(self.roots[roots[0]])?
    // rust: .unwrap_or([i32::MIN, i32::MAX]),
    // rust: },
    // rust: });
    // rust: self.compiled.insert(key, value.clone());
    // rust: Ok(value)
}
}
Loader :: struct {
    raw: BTreeMap<string,
    values: BTreeMap<string,
    active: BTreeSet<string>,
    conditions: ^'a MaterialConditionRegistry,
    blocks: ^'a BlockStateJsonCodec<'b>,
    roots: [dynamic]string,
    nodes: uint,
}
    // rust: impl Loader<'_, '_> {
resolve :: proc(self: ^Self, name: string, depth: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if depth >= 256 {
    // rust: return Err(DecodeError::Field("material rule depth"));
}
    // rust: if let Some(value) = self.values.get(name) {
    // rust: return Ok(value.clone());
}
    // rust: if !self.active.insert(name.to_owned()) {
    // rust: return Err(DecodeError::Field("cyclic material rule"));
}
    // rust: let raw = self
    // rust: .raw
    // rust: .get(name)
    // rust: .ok_or(DecodeError::Field("missing material rule"))?
    // rust: .clone();
    // rust: if !raw.get().starts_with('{') {
    // rust: return Err(DecodeError::Field(
    // rust: "material rule definition must be direct",
    // rust: ));
}
    // rust: let value = self.node(&raw, depth + 1)?;
    // rust: self.active.remove(name);
    // rust: self.values.insert(name.to_owned(), value.clone());
    // rust: Ok(value)
}
node :: proc(self: ^Self, raw: ^RawValue, depth: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes += 1;
    // rust: if depth >= 256 || self.nodes > 65536 {
    // rust: return Err(DecodeError::Field("material rule size"));
}
    // rust: if raw.get().starts_with('"') {
    // rust: let name = identifier(&serde_json::from_str::<String>(raw.get())?)?;
    // rust: return Ok(Arc::new(Definition::Reference(
    // rust: self.resolve(&name, depth + 1)?,
    // rust: )));
}
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: let block = |name| {
    // rust: self.blocks
    // rust: .decode(required(&object, name)?.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
}
    // rust: let value = match kind.as_str() {
    // rust: "minecraft:block" => Definition::Block(block("result_state")?),
    // rust: "minecraft:bandlands" => Definition::Bandlands,
    // rust: "minecraft:sequence" => {
    // rust: let children: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "sequence")?.get())?;
    // rust: Definition::Sequence(
    // rust: children
    // rust: .iter()
    // rust: .map(|child| self.node(child, depth + 1))
    // rust: .collect::<Result<_, _>>()?,
    // rust: )
}
    // rust: "minecraft:condition" => Definition::Condition(
    // rust: self.conditions
    // rust: .decode(required(&object, "if_true")?.get())?,
    // rust: self.node(required(&object, "then_run")?, depth + 1)?,
    // rust: ),
    // rust: "minecraft:ore_vein" => {
    // rust: let blocks = [
    // rust: block("ore_block")?,
    // rust: block("raw_ore_block")?,
    // rust: block("filler_block")?,
    // rust: ];
    // rust: let chance = number_text(required(&object, "raw_ore_chance")?)?
    // rust: .parse::<f32>()
    // rust: .map_err(|_| DecodeError::Field("raw ore chance"))?;
    // rust: if !(0.0..=1.0).contains(&chance) {
    // rust: return Err(DecodeError::Field("raw ore chance"));
}
    // rust: let base = self.roots.len();
    // rust: for name in ["density", "richness", "filler_gap"] {
    // rust: self.roots.push(required(&object, name)?.get().to_owned());
}
    // rust: Definition::Ore {
    // rust: blocks,
    // rust: chance,
    // rust: roots: [base, base + 1, base + 2],
}
}
    // rust: _ => return Err(DecodeError::Field("material rule type")),
}
    // rust: Ok(Arc::new(value))
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::{
    // rust: DATA_VERSION,
    // rust: nbt::Tag,
    // rust: registry::BlockRegistry,
    // rust: worldgen::{
    // rust: anchor::WorldGenerationContext,
    // rust: material_condition::{MaterialConditions, MaterialSurfaceQueries},
    // rust: },
}
//     use horizon_core::{
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, RandomSource},
}
Surface :: struct {
    // rust: impl MaterialSurfaceQueries for Surface {
surface_depth :: proc(self: ^Self, _: i32, _: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
surface_secondary :: proc(self: ^Self, _: i32, _: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.0
}
}
forward_rule_holders_and_invalid_graphs_are_atomic :: proc() {
}
    // rust: let registry = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(vec![Tag::compound([(
    // rust: "id",
    // rust: Tag::String("minecraft:stone".into()),
    // rust: )])]),
    // rust: ),
    // rust: (
    // rust: "defaults",
    // rust: Tag::compound([("minecraft:stone", Tag::Int(0))]),
    // rust: ),
    // rust: ]))
    // rust: .unwrap();
    // rust: let blocks = BlockStateJsonCodec::new(&registry, BTreeSet::new()).unwrap();
    // rust: let conditions = MaterialConditionRegistry::default();
    // rust: let definitions = BTreeMap::from([
    // rust: (
    // rust: "horizon:a".to_owned(),
    // rust: r#"{"type":"condition","if_true":{"type":"hole"},"then_run":"horizon:z"}"#
    // rust: .to_owned(),
    // rust: ),
    // rust: (
    // rust: "horizon:z".to_owned(),
    // rust: r#"{"type":"block","result_state":"stone"}"#.to_owned(),
    // rust: ),
    // rust: ]);
    // rust: let load = |definitions: &BTreeMap<String, String>| {
    // rust: MaterialRuleLibrary::from_json(
    // rust: definitions,
    // rust: &conditions,
    // rust: &blocks,
    // rust: DensityRegistry::from_json(&BTreeMap::new(), &BTreeMap::new()).unwrap(),
    // rust: 0,
    // rust: false,
    // rust: )
}
    // rust: let mut valid = load(&definitions).unwrap();
    // rust: for bad in [
    // rust: r#"{"type":"condition","if_true":{"type":"hole"},"then_run":"horizon:a"}"#,
    // rust: r#"{"type":"condition","if_true":{"type":"hole"},"then_run":"horizon:missing"}"#,
    // rust: r#""horizon:z""#,
    // rust: r#"{"type":"ore_vein","ore_block":"stone","raw_ore_block":"stone","filler_block":"stone","raw_ore_chance":0.1,"density":"horizon:missing","richness":0,"filler_gap":0}"#,
    // rust: ] {
    // rust: let mut invalid = definitions.clone();
    // rust: invalid.insert("horizon:z".to_owned(), bad.to_owned());
    // rust: assert!(load(&invalid).is_err());
}
    // rust: let mut duplicate = definitions;
    // rust: duplicate.insert("z".to_owned(), r#"{"type":"bandlands"}"#.to_owned());
    // rust: duplicate.insert(
    // rust: "minecraft:z".to_owned(),
    // rust: r#"{"type":"bandlands"}"#.to_owned(),
    // rust: );
    // rust: assert!(load(&duplicate).is_err());
    // rust: assert_eq!(
    // rust: valid.names().collect::<Vec<_>>(),
    // rust: vec!["horizon:a", "horizon:z"]
    // rust: );
    // rust: let mut random = LegacyRandom::new(0);
    // rust: let mut worker = MaterialConditions::<LegacyRandom, _>::new(
    // rust: WorldGenerationContext::new(-64, 384, 63),
    // rust: random.fork_positional(),
    // rust: Surface,
    // rust: );
    // rust: let index = worker.add_rule(valid.rule("horizon:a").unwrap()).unwrap();
    // rust: assert_eq!(
    // rust: worker.try_apply(index, BlockPos::new(0, 64, 0)).unwrap(),
    // rust: Some(BlockStateId(0))
    // rust: );
}
}
