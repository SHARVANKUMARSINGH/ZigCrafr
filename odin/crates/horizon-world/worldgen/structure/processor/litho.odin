//! Transpiled from Horizon Rust crate
package horizon_world_litho

import "core:fmt"
import "core:mem"
import "core:math"

// Lithostitched's processors (spec-lithostitched §5), read as its data
// writes them: `lithostitched:block_swap` (in `processor.rs`), `reference`,
// `apply_random`, `condition`, `set_block` and `discard_input`.
//
// The draws of `random_chance`, `apply_random` and `set_block` follow
// Lithostitched's `random_mode` (per block or per piece), but its seeding is
// not known (OPEN-L6): a positional random of the world seed, the block's or
// the piece's position and the processor itself, so the shares match while
// the blocks chosen do not.
// use super::{BlockStateId, DecodeError, Modifier, ProcessorList, ProcessorRandom};
// use crate::worldgen::{block_feature::FeatureBlockBindings, structure::StructureResources};
// use horizon_core::{
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, position_seed},
}
// use serde_json::Value;
// use std::collections::BTreeSet;

// `random_mode` (`condition`, `set_block`) or `mode` (`apply_random`).
    // rust: pub(super) struct Draws {
    // rust: per_piece: bool,
    // The processor's own salt, so two processors on a block draw apart.
    // rust: salt: i64,
}
    // rust: impl Draws {
decode :: proc(mode: Maybe(^Value), processor: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let per_piece = match mode.and_then(Value::as_str) {
    // rust: None | Some("per_block") => false,
    // rust: Some("per_piece") => true,
    // rust: _ => return Err(DecodeError::Field("random_mode")),
}
        // FNV-1a over the processor's JSON: the same in every run.
    // rust: let salt = (processor.to_string().bytes()).fold(0xcbf2_9ce4_8422_2325_u64, |h, b| {
    // rust: (h ^ u64::from(b)).wrapping_mul(0x0100_0000_01b3)
    // rust: }) as i64;
    // rust: Ok(Self { per_piece, salt })
}
    // The random for the block at `pos` of the piece at `piece`.
    // rust: pub(super) fn random(self, world_seed: i64, piece: [i32; 3], pos: [i32; 3]) -> LegacyRandom {
    // rust: let [x, y, z] = if self.per_piece { piece } else { pos };
    // rust: LegacyRandom::new(world_seed ^ self.salt ^ position_seed(BlockPos::new(x, y, z)))
}
}

// A processor or a list of them (`then`, `else`, `apply_random`'s data):
// a list holder (`ProcessorList::decode`), or one processor object.
    // rust: fn processors(
    // rust: value: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<ProcessorList, DecodeError> {
    // rust: let one = value.get("processor_type").is_some();
    // rust: let holder = if one {
    // rust: Value::Array(vec![value.clone()])
    // rust: } else {
    // rust: value.clone()
}
    // rust: ProcessorList::decode(&holder.to_string(), resources, bindings)
}

// `reference`: the named lists, run in turn on the block.
    // rust: pub(super) fn reference(
    // rust: value: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Vec<ProcessorList>, DecodeError> {
    // rust: let names = match &value["processor_lists"] {
    // rust: Value::Array(a) => a.clone(),
    // rust: other => vec![other.clone()],
}
    // rust: (names.iter())
    // rust: .map(|name| match name.as_str() {
    // rust: Some(n) if n.starts_with('#') => Err(DecodeError::Field("processor list tag")),
    // rust: Some(_) => ProcessorList::decode(&name.to_string(), resources, bindings),
    // rust: None => Err(DecodeError::Field("processor_lists")),
    // rust: })
    // rust: .collect()
}

// `apply_random`: one list drawn by weight runs on the block.
ApplyRandom :: struct {
    // rust: pub(super) draws: Draws,
    lists: Vec<(i32,
    total: i32,
}
    // rust: impl ApplyRandom {
    // rust: pub(super) fn decode(
    // rust: value: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let entries = value["processor_lists"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("apply_random processor_lists"))?;
    // rust: let lists = (entries.iter())
    // rust: .map(|e| match e.get("data") {
    // rust: Some(data) => {
    // rust: let weight = e["weight"]
    // rust: .as_i64()
    // rust: .unwrap_or(1)
    // rust: .clamp(0, i64::from(i32::MAX));
    // rust: Ok((weight as i32, processors(data, resources, bindings)?))
}
    // rust: None => Ok((1, processors(e, resources, bindings)?)),
    // rust: })
    // rust: .collect::<Result<Vec<_>, DecodeError>>()?;
    // rust: let total = lists
    // rust: .iter()
    // rust: .map(|(w, _)| *w)
    // rust: .fold(0i32, i32::saturating_add);
    // rust: Ok(Self {
    // rust: draws: Draws::decode(value.get("mode"), value)?,
    // rust: lists,
    // rust: total,
    // rust: })
}
    // The list drawn: one bounded draw over the total weight.
    // rust: pub(super) fn pick(&self, random: &mut impl ProcessorRandom) -> Option<&ProcessorList> {
    // rust: if self.total <= 0 {
    // rust: return None;
}
    // rust: let mut at = random.int(self.total);
    // rust: for (weight, list) in &self.lists {
    // rust: at -= weight;
    // rust: if at < 0 {
    // rust: return Some(list);
}
}
    // rust: None
}
}

// Lithostitched's processor conditions.
    // rust: pub(super) enum Condition {
    // rust: True,
    // rust: AllOf(Vec<Condition>),
    // rust: AnyOf(Vec<Condition>),
    // rust: Not(Box<Condition>),
    // rust: Chance(f32),
    // `matching_blocks`: the template's block (`input`) or the world's
    // (`location`) is one of `blocks`, with `properties`.
    // rust: Matching {
    // rust: blocks: BTreeSet<String>,
    // rust: properties: Vec<(String, String)>,
    // rust: location: bool,
    // rust: },
}
    // rust: impl Condition {
    // One condition, or a list of them that must all pass (`if_true`).
    // rust: pub(super) fn decode(
    // rust: value: &Value,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let list = |v: &Value| -> Result<Vec<Self>, DecodeError> {
    // rust: (v.as_array().ok_or(DecodeError::Field("conditions"))?.iter())
    // rust: .map(|c| Self::decode(c, bindings))
    // rust: .collect()
}
    // rust: if value.is_array() {
    // rust: return Ok(Self::AllOf(list(value)?));
}
    // rust: let kind = value["type"].as_str().unwrap_or_default();
    // rust: Ok(match crate::worldgen::tags::identifier(kind)?.as_str() {
    // rust: "lithostitched:true" => Self::True,
    // rust: "lithostitched:all_of" => Self::AllOf(list(&value["conditions"])?),
    // rust: "lithostitched:any_of" => Self::AnyOf(list(&value["conditions"])?),
    // rust: "lithostitched:not" => {
    // rust: Self::Not(Box::new(Self::decode(&value["condition"], bindings)?))
}
    // rust: "lithostitched:random_chance" => Self::Chance(
    // rust: value["chance"]
    // rust: .as_f64()
    // rust: .ok_or(DecodeError::Field("random_chance chance"))? as f32,
    // rust: ),
    // rust: "lithostitched:matching_blocks" => Self::Matching {
    // rust: blocks: blocks(&value["blocks"], bindings)?,
    // rust: properties: (value
    // rust: .get("properties")
    // rust: .and_then(Value::as_object)
    // rust: .into_iter())
    // rust: .flatten()
    // rust: .map(|(k, v)| {
    // rust: (
    // rust: k.clone(),
    // rust: v.as_str().map_or_else(|| v.to_string(), str::to_owned),
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: location: match value.get("match_type").and_then(Value::as_str) {
    // rust: None | Some("input") => false,
    // rust: Some("location") => true,
    // rust: _ => return Err(DecodeError::Field("matching_blocks match_type")),
    // rust: },
    // rust: },
    // rust: _ => return Err(DecodeError::Field("lithostitched condition type")),
    // rust: })
}
    // rust: pub(super) fn test(
    // rust: &self,
    // rust: input: BlockStateId,
    // rust: location: BlockStateId,
    // rust: registry: &crate::registry::BlockRegistry,
    // rust: random: &mut impl ProcessorRandom,
    // rust: ) -> bool {
    // rust: match self {
    // rust: Self::True => true,
    // rust: Self::AllOf(all) => all
    // rust: .iter()
    // rust: .all(|c| c.test(input, location, registry, random)),
    // rust: Self::AnyOf(any) => any
    // rust: .iter()
    // rust: .any(|c| c.test(input, location, registry, random)),
    // rust: Self::Not(c) => !c.test(input, location, registry, random),
    // rust: Self::Chance(chance) => random.float() < *chance,
    // rust: Self::Matching {
    // rust: blocks,
    // rust: properties,
    // rust: location: at_location,
    // rust: } => {
    // rust: let Some(state) = registry.state(if *at_location { location } else { input })
    // rust: else {
    // rust: return false;
}
    // rust: blocks.contains(&state.name)
    // rust: && (properties.iter()).all(|(k, v)| state.properties.get(k) == Some(v))
}
}
}
}
// A block set (an id, a list, `#tag`) by block name. Blocks the game does
// not have are left out: no template block can be one.
    // rust: fn blocks(
    // rust: value: &Value,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<BTreeSet<String>, DecodeError> {
    // rust: let names: Vec<&str> = match value {
    // rust: Value::String(s) => vec![s.as_str()],
    // rust: Value::Array(a) => a.iter().filter_map(Value::as_str).collect(),
    // rust: _ => return Err(DecodeError::Field("matching_blocks blocks")),
}
    // rust: let registry = bindings.registry();
    // rust: let mut out = BTreeSet::new();
    // rust: for name in names {
    // rust: match name.strip_prefix('#') {
    // rust: Some(tag) => {
    // rust: let tag = crate::worldgen::tags::identifier(tag)?;
    // rust: let states = bindings.tags.get(&tag).into_iter().flat_map(|s| s.iter());
    // rust: out.extend(states.filter_map(|s| Some(registry.state(*s)?.name.clone())));
}
    // rust: None => {
    // rust: out.insert(crate::worldgen::tags::identifier(name)?.to_string());
}
}
}
    // rust: Ok(out)
}

// `condition`: `then` when the conditions pass, else `else` (none: the
// block as it is).
Conditional :: struct {
    // rust: pub(super) draws: Draws,
    // rust: pub(super) condition: Condition,
    // rust: pub(super) then: ProcessorList,
    // rust: pub(super) otherwise: ProcessorList,
}
    // rust: impl Conditional {
    // rust: pub(super) fn decode(
    // rust: value: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let branch = |key| match value.get(key) {
    // rust: Some(v) => processors(v, resources, bindings),
    // rust: None => Ok(ProcessorList(Vec::new())),
}
    // rust: Ok(Self {
    // rust: draws: Draws::decode(value.get("random_mode"), value)?,
    // rust: condition: Condition::decode(&value["if_true"], bindings)?,
    // rust: then: branch("then")?,
    // rust: otherwise: branch("else")?,
    // rust: })
}
}

// `set_block`: the block from a state provider (simple or weighted).
SetBlock :: struct {
    // rust: pub(super) draws: Draws,
    states: Vec<(i32,
    total: i32,
    // `preserve_state` (true by default): the template block's properties
    // the new block has too are kept.
    // rust: pub(super) preserve: bool,
    // rust: pub(super) modifier: Modifier,
}
    // rust: impl SetBlock {
    // rust: pub(super) fn decode(
    // rust: value: &Value,
    // rust: state: impl Fn(&Value) -> Result<BlockStateId, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let provider = &value["state_provider"];
    // rust: let kind = provider["type"].as_str().unwrap_or_default();
    // rust: let states = match crate::worldgen::tags::identifier(kind)?.as_str() {
    // rust: "minecraft:simple_state_provider" => vec![(1, state(&provider["state"])?)],
    // rust: "minecraft:weighted_state_provider" => (provider["entries"].as_array().into_iter())
    // rust: .flatten()
    // rust: .map(|e| {
    // rust: Ok((
    // rust: e["weight"].as_i64().unwrap_or(1).clamp(0, 1 << 30) as i32,
    // rust: state(&e["data"])?,
    // rust: ))
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?,
    // rust: _ => return Err(DecodeError::Field("set_block state_provider")),
}
    // rust: let total = states.iter().map(|(w, _)| *w).sum();
    // rust: if total <= 0 {
    // rust: return Err(DecodeError::Field("set_block state_provider"));
}
    // rust: Ok(Self {
    // rust: draws: Draws::decode(value.get("random_mode"), value)?,
    // rust: states,
    // rust: total,
    // rust: preserve: value
    // rust: .get("preserve_state")
    // rust: .and_then(Value::as_bool)
    // rust: .unwrap_or(true),
    // rust: modifier: Modifier::decode(value.get("block_entity_modifier"))?,
    // rust: })
}
    // The provider's state: WeightedList.getRandom, one bounded draw.
    // rust: pub(super) fn state(&self, random: &mut impl ProcessorRandom) -> BlockStateId {
    // rust: let mut at = random.int(self.total);
    // rust: for (weight, state) in &self.states {
    // rust: at -= weight;
    // rust: if at < 0 {
    // rust: return *state;
}
}
    // rust: self.states[0].1
}
}

    // rust: mod tests {
//     use super::super::{BlockInfo, PlaceSettings, ProcessorList, process_list};
//     use crate::{
    // rust: heightmap::HeightmapType,
    // rust: nbt::{JavaString, Tag},
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::{
    // rust: anchor::WorldGenerationContext,
    // rust: block_feature::FeatureBlockBindings,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: structure::{
    // rust: Rotation, StateTransforms, StructureResources, template::parse_state_string,
    // rust: },
    // rust: },
}
//     use serde_json::{Value, json};
//     use std::collections::{BTreeMap, BTreeSet};

    // Every combination of `properties`' values, the first one the default.
states :: proc(name: string, properties: ^[(string) {
}
    // rust: let mut out = vec![serde_json::Map::new()];
    // rust: for (key, values) in properties {
    // rust: out = (out.iter())
    // rust: .flat_map(|o| {
    // rust: values.iter().map(move |v| {
    // rust: let mut o = o.clone();
    // rust: o.insert((*key).into(), (*v).into());
    // rust: o
    // rust: })
    // rust: })
    // rust: .collect();
}
    // rust: (out.into_iter())
    // rust: .map(|p| json!([name, name.ends_with("air"), false, "", {"id": name, "properties": p}]))
    // rust: .collect()
}

    // A registry of the blocks CTOV's lists and the probe pack use.
registry :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let ages: Vec<String> = (0..8).map(|a| a.to_string()).collect();
    // rust: let ages: Vec<&str> = ages.iter().map(String::as_str).collect();
    // rust: let levels: Vec<String> = (0..16).map(|a| a.to_string()).collect();
    // rust: let levels: Vec<&str> = levels.iter().map(String::as_str).collect();
    // rust: let water = [("level", &levels[..])];
    // rust: let stairs: &[(&str, &[&str])] =
    // rust: &[("facing", &["north", "east"]), ("half", &["bottom", "top"])];
    // rust: let blocks: Vec<(&str, &[(&str, &[&str])])> = vec![
    // rust: ("minecraft:air", &[]),
    // rust: ("minecraft:cave_air", &[]),
    // rust: ("minecraft:void_air", &[]),
    // rust: ("minecraft:lava", &water),
    // rust: ("minecraft:cobblestone", &[]),
    // rust: ("minecraft:blackstone", &[]),
    // rust: ("minecraft:deepslate", &[]),
    // rust: ("minecraft:water", &water),
    // rust: ("minecraft:spruce_planks", &[]),
    // rust: ("minecraft:chest", &[]),
    // rust: ("minecraft:oak_log", &[("axis", &["y", "x"])]),
    // rust: ("minecraft:stripped_cherry_log", &[("axis", &["y", "x"])]),
    // rust: ("minecraft:oak_stairs", stairs),
    // rust: ("minecraft:warped_stairs", stairs),
    // rust: ];
    // rust: let wheat = [("age", &ages[..])];
    // rust: let beetroots = [("age", &ages[..4])];
    // rust: let mut rows = Vec::new();
    // rust: let mut defaults = BTreeMap::new();
    // rust: let crops: [(&str, &[(&str, &[&str])]); 3] = [
    // rust: ("minecraft:wheat", &wheat),
    // rust: ("minecraft:carrots", &wheat),
    // rust: ("minecraft:beetroots", &beetroots),
    // rust: ];
    // rust: for (name, properties) in blocks.into_iter().chain(crops) {
    // rust: defaults.insert(name, rows.len());
    // rust: rows.extend(states(name, properties));
}
    // rust: let facts = json!({"states": rows, "defaults": defaults});
    // rust: let registry = BlockRegistry::from_facts_json(facts.to_string().as_bytes()).unwrap();
    // rust: Box::leak(Box::new(registry))
}

    // The world a piece is placed in: one block everywhere.
World :: struct {
    seed: i64,
    block: BlockStateId,
}
    // rust: impl PlacementContext for World {
world_seed :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.seed)
}
block_state :: proc(self: ^Self, _: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.block)
}
generation :: proc(self: ^Self) -> W {
    // Ported from Horizon
    return {}
}
    // rust: WorldGenerationContext::new(-64, 384, 63)
}
min_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(-64)
}
height :: proc(self: ^Self, _: HeightmapType, _: i32, _: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Err(PlacementQueryError::Unavailable)
}
}

Lists :: struct {
    registry: ^'static BlockRegistry,
    resources: StructureResources,
}
    // rust: impl Lists {
new :: proc(lists: ^[(string) {
}
    // rust: let registry = registry();
    // rust: let lists = (lists.iter())
    // rust: .map(|(id, list)| ((*id).to_owned(), list.to_string()))
    // rust: .collect();
    // rust: let resources = StructureResources::new(
    // rust: registry,
    // rust: StateTransforms::default(),
    // rust: std::path::Path::new("/nonexistent"),
    // rust: lists,
    // rust: &BTreeMap::new(),
    // rust: );
    // rust: Self {
    // rust: registry,
    // rust: resources,
}
}
id :: proc(self: ^Self, state: string) -> B {
    // Ported from Horizon
    return {}
}
    // rust: parse_state_string(self.registry, state).unwrap()
}
decode :: proc(self: ^Self, processors: Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let bindings = FeatureBlockBindings::new(self.registry, BTreeSet::new()).unwrap();
    // rust: ProcessorList::decode(&processors.to_string(), &self.resources, &bindings)
}
        // The block the list makes of template block `state` at `pos` of the
        // piece at `piece`, in a world of `world`: None when it is not placed.
    // rust: fn run(
    // rust: &self,
    // rust: list: &ProcessorList,
    // rust: world: (i64, &str),
    // rust: piece: [i32; 3],
    // rust: pos: [i32; 3],
    // rust: state: &str,
    // rust: ) -> Option<BlockInfo> {
    // rust: let mut world = World {
    // rust: seed: world.0,
    // rust: block: self.id(world.1),
}
    // rust: let info = BlockInfo {
    // rust: pos,
    // rust: state: self.id(state),
    // rust: nbt: None,
}
    // rust: let mut settings = PlaceSettings::new(Rotation::None);
    // rust: process_list(
    // rust: list,
    // rust: &mut world,
    // rust: &self.resources,
    // rust: piece,
    // rust: piece,
    // rust: [0; 3],
    // rust: info,
    // rust: &mut settings,
    // rust: )
    // rust: .unwrap()
}
name :: proc(self: ^Self, info: Maybe(BlockInfo)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match info {
    // rust: None => "none".into(),
    // rust: Some(info) => {
    // rust: let s = self.registry.state(info.state).unwrap();
    // rust: let props: Vec<String> = s
    // rust: .properties
    // rust: .iter()
    // rust: .map(|(k, v)| format!("{k}={v}"))
    // rust: .collect();
    // rust: match props.is_empty() {
    // rust: true => s.name.clone(),
    // rust: false => format!("{}[{}]", s.name, props.join(",")),
}
}
}
}
        // `name(run(...))` for one template block in an air world of seed 0.
out :: proc(self: ^Self, list: ^ProcessorList, state: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.name(self.run(list, (0, "minecraft:air"), [0; 3], [0; 3], state))
}
}

swap :: proc(blocks: Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: json!({"processor_type": "lithostitched:block_swap", "blocks": blocks})
}
set_block :: proc(provider: Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: json!({"processor_type": "lithostitched:set_block", "state_provider": provider})
}
simple :: proc(name: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: json!({"type": "minecraft:simple_state_provider", "state": {"id": name}})
}

block_swap_keeps_the_properties_the_new_block_can_have :: proc() {
}
    // rust: let t = Lists::new(&[]);
    // rust: let list = t
    // rust: .decode(json!([swap(json!({
    // rust: "minecraft:wheat": "minecraft:carrots",
    // rust: "oak_stairs": "minecraft:warped_stairs",
    // rust: "minecraft:cobblestone": "natures_spirit:missing"}))]))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: t.out(&list, "minecraft:wheat[age=7]"),
    // rust: "minecraft:carrots[age=7]"
    // rust: );
    // rust: assert_eq!(
    // rust: t.out(&list, "minecraft:oak_stairs[facing=east,half=top]"),
    // rust: "minecraft:warped_stairs[facing=east,half=top]"
    // rust: );
        // A block the game lacks leaves the template's; others pass.
    // rust: assert_eq!(
    // rust: t.out(&list, "minecraft:cobblestone"),
    // rust: "minecraft:cobblestone"
    // rust: );
    // rust: assert_eq!(
    // rust: t.out(&list, "minecraft:oak_log[axis=x]"),
    // rust: "minecraft:oak_log[axis=x]"
    // rust: );
        // Beetroots' age stops at 3: ripe wheat gives the default (spec-ctov §4).
    // rust: let beet = t
    // rust: .decode(json!([swap(
    // rust: json!({"minecraft:wheat": "minecraft:beetroots"})
    // rust: )]))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: t.out(&beet, "minecraft:wheat[age=7]"),
    // rust: "minecraft:beetroots[age=0]"
    // rust: );
    // rust: assert_eq!(
    // rust: t.out(&beet, "minecraft:wheat[age=2]"),
    // rust: "minecraft:beetroots[age=2]"
    // rust: );
}

references_run_the_named_lists_in_turn :: proc() {
}
    // rust: let t = Lists::new(&[
    // rust: (
    // rust: "t:logs",
    // rust: json!({"processors": [swap(json!({"minecraft:oak_log": "minecraft:stripped_cherry_log"}))]}),
    // rust: ),
    // rust: (
    // rust: "t:stone",
    // rust: json!([swap(
    // rust: json!({"minecraft:stripped_cherry_log": "minecraft:cobblestone"})
    // rust: )]),
    // rust: ),
    // rust: (
    // rust: "t:discard",
    // rust: json!([{"processor_type": "lithostitched:discard_input"}]),
    // rust: ),
    // rust: ]);
    // rust: let reference = |lists: Value| json!([{"processor_type": "lithostitched:reference", "processor_lists": lists}]);
    // rust: let one = t.decode(reference(json!("t:logs"))).unwrap();
    // rust: assert_eq!(
    // rust: t.out(&one, "minecraft:oak_log[axis=x]"),
    // rust: "minecraft:stripped_cherry_log[axis=x]"
    // rust: );
    // rust: let both = t.decode(reference(json!(["t:logs", "t:stone"]))).unwrap();
    // rust: assert_eq!(t.out(&both, "minecraft:oak_log"), "minecraft:cobblestone");
    // rust: let reversed = t.decode(reference(json!(["t:stone", "t:logs"]))).unwrap();
    // rust: assert_eq!(
    // rust: t.out(&reversed, "minecraft:oak_log"),
    // rust: "minecraft:stripped_cherry_log[axis=y]"
    // rust: );
        // discard_input: the template block is not placed, and the lists after it do not run.
    // rust: let discard = t.decode(reference(json!(["t:discard", "t:logs"]))).unwrap();
    // rust: assert_eq!(t.out(&discard, "minecraft:oak_log"), "none");
        // The game has no processor list tags; unknown lists are errors.
    // rust: assert!(t.decode(reference(json!(["#t:palettes"]))).is_err());
    // rust: assert!(t.decode(reference(json!("t:missing"))).is_err());
}

    // The probe pack's nested condition (spec-lithostitched §7.3): template
    // cobblestone becomes blackstone or deepslate, half each.
conditions_run_then_or_else :: proc() {
}
    // rust: let t = Lists::new(&[]);
    // rust: let inner = json!({"processor_type": "lithostitched:condition", "random_mode": "per_block",
    // rust: "if_true": {"type": "lithostitched:random_chance", "chance": 0.5},
    // rust: "then": set_block(simple("minecraft:blackstone")),
    // rust: "else": [set_block(simple("minecraft:deepslate"))]});
    // rust: let list = t
    // rust: .decode(json!([{"processor_type": "lithostitched:condition",
    // rust: "if_true": [{"type": "lithostitched:matching_blocks", "blocks": "minecraft:cobblestone"}],
    // rust: "then": [inner]}]))
    // rust: .unwrap();
    // rust: let mut counts = BTreeMap::<String, u32>::new();
    // rust: for i in 0..4000 {
    // rust: let out = t.run(
    // rust: &list,
    // rust: (1234, "minecraft:air"),
    // rust: [0; 3],
    // rust: [i % 64, i / 64, 7],
    // rust: "minecraft:cobblestone",
    // rust: );
    // rust: *counts.entry(t.name(out)).or_default() += 1;
}
    // rust: assert_eq!(counts.len(), 2, "{counts:?}");
    // rust: assert!(
    // rust: (1850..2150).contains(&counts["minecraft:blackstone"]),
    // rust: "{counts:?}"
    // rust: );
        // Not cobblestone, and no `else`: the block as it is.
    // rust: assert_eq!(
    // rust: t.out(&list, "minecraft:oak_log"),
    // rust: "minecraft:oak_log[axis=y]"
    // rust: );

        // `location` tests the world's block, with properties on the input.
    // rust: let water = t
    // rust: .decode(
    // rust: json!([{"processor_type": "lithostitched:condition", "random_mode": "per_piece",
    // rust: "if_true": {"type": "lithostitched:matching_blocks", "blocks": ["minecraft:water"],
    // rust: "match_type": "location"},
    // rust: "then": set_block(simple("minecraft:spruce_planks"))}]),
    // rust: )
    // rust: .unwrap();
    // rust: let at = |world| {
    // rust: t.name(t.run(
    // rust: &water,
    // rust: (0, world),
    // rust: [0; 3],
    // rust: [1, 2, 3],
    // rust: "minecraft:cobblestone",
    // rust: ))
}
    // rust: assert_eq!(at("minecraft:water"), "minecraft:spruce_planks");
    // rust: assert_eq!(at("minecraft:air"), "minecraft:cobblestone");
    // rust: let ripe = t
    // rust: .decode(json!([{"processor_type": "lithostitched:condition",
    // rust: "if_true": {"type": "lithostitched:all_of", "conditions": [
    // rust: {"type": "lithostitched:true"},
    // rust: {"type": "lithostitched:matching_blocks", "blocks": "minecraft:wheat", "properties": {"age": "7"}},
    // rust: {"type": "lithostitched:not", "condition": {"type": "lithostitched:any_of", "conditions": [
    // rust: {"type": "lithostitched:random_chance", "chance": 0.0},
    // rust: {"type": "lithostitched:matching_blocks", "blocks": "minecraft:water", "match_type": "location"}]}}]},
    // rust: "then": swap(json!({"minecraft:wheat": "minecraft:carrots"}))}]))
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: t.out(&ripe, "minecraft:wheat[age=7]"),
    // rust: "minecraft:carrots[age=7]"
    // rust: );
    // rust: assert_eq!(
    // rust: t.out(&ripe, "minecraft:wheat[age=6]"),
    // rust: "minecraft:wheat[age=6]"
    // rust: );
    // rust: let bad = json!([{"processor_type": "lithostitched:condition", "random_mode": "per_chunk",
    // rust: "if_true": {"type": "lithostitched:true"}}]);
    // rust: assert!(t.decode(bad).is_err());
}

    // `apply_random` (spec-lithostitched §7.3: crimson 1 : birch 3, one
    // choice per piece): here blackstone 1 : deepslate 3.
apply_random_draws_per_piece_or_per_block :: proc() {
}
    // rust: let t = Lists::new(&[(
    // rust: "t:deepslate",
    // rust: json!([swap(
    // rust: json!({"minecraft:cobblestone": "minecraft:deepslate"})
    // rust: )]),
    // rust: )]);
    // rust: let random = |mode: &str| {
    // rust: t.decode(json!([{"processor_type": "lithostitched:apply_random", "mode": mode,
    // rust: "processor_lists": [
    // rust: {"weight": 1, "data": [swap(json!({"minecraft:cobblestone": "minecraft:blackstone"}))]},
    // rust: {"weight": 3, "data": "t:deepslate"}]}]))
    // rust: .unwrap()
}
    // rust: let (per_piece, per_block) = (random("per_piece"), random("per_block"));
    // rust: let outcomes = |list: &ProcessorList, seed: i64, piece: [i32; 3]| -> Vec<String> {
    // rust: (0..20)
    // rust: .map(|i| {
    // rust: let pos = [piece[0] + i, piece[1], piece[2] + 3 * i];
    // rust: t.name(t.run(
    // rust: list,
    // rust: (seed, "minecraft:air"),
    // rust: piece,
    // rust: pos,
    // rust: "minecraft:cobblestone",
    // rust: ))
    // rust: })
    // rust: .collect()
}
    // rust: let mut blackstone_pieces = 0;
    // rust: for p in 0..400 {
    // rust: let piece = [16 * p, 70, -40 * p];
    // rust: let blocks = outcomes(&per_piece, 1234, piece);
    // rust: assert!(blocks.iter().all(|b| *b == blocks[0]), "{blocks:?}");
    // rust: blackstone_pieces += u32::from(blocks[0] == "minecraft:blackstone");
            // The same piece and seed give the same blocks.
    // rust: assert_eq!(outcomes(&per_piece, 1234, piece), blocks);
}
    // rust: assert!(
    // rust: (70..130).contains(&blackstone_pieces),
    // rust: "{blackstone_pieces}"
    // rust: );
        // Per block, one piece mixes both.
    // rust: let mixed: BTreeSet<String> = (0..10)
    // rust: .flat_map(|p| outcomes(&per_block, 1234, [p, 0, 0]))
    // rust: .collect();
    // rust: assert_eq!(mixed.len(), 2, "{mixed:?}");
        // A plain list: every entry weight 1. An entry list holding nothing is a no-op.
    // rust: let plain = t
    // rust: .decode(
    // rust: json!([{"processor_type": "lithostitched:apply_random", "mode": "per_block",
    // rust: "processor_lists": ["t:deepslate", []]}]),
    // rust: )
    // rust: .unwrap();
    // rust: let seen: BTreeSet<String> = (0..10)
    // rust: .flat_map(|p| outcomes(&plain, 9, [p, 0, 0]))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: seen,
    // rust: BTreeSet::from(["minecraft:cobblestone".into(), "minecraft:deepslate".into()])
    // rust: );
}

set_block_runs_its_provider :: proc() {
}
    // rust: let t = Lists::new(&[]);
    // rust: let stairs = "minecraft:oak_stairs[facing=east,half=top]";
    // rust: let warped = |preserve: Value| {
    // rust: let mut p = set_block(simple("minecraft:warped_stairs"));
    // rust: if !preserve.is_null() {
    // rust: p["preserve_state"] = preserve;
}
    // rust: t.decode(json!([p])).unwrap()
}
        // preserve_state (true by default) keeps the properties both blocks have.
    // rust: assert_eq!(
    // rust: t.out(&warped(Value::Null), stairs),
    // rust: "minecraft:warped_stairs[facing=east,half=top]"
    // rust: );
    // rust: assert_eq!(
    // rust: t.out(&warped(json!(false)), stairs),
    // rust: "minecraft:warped_stairs[facing=north,half=bottom]"
    // rust: );

    // rust: let weighted = t
    // rust: .decode(json!([set_block(
    // rust: json!({"type": "minecraft:weighted_state_provider", "entries": [
    // rust: {"weight": 1, "data": {"id": "minecraft:blackstone"}},
    // rust: {"weight": 3, "data": {"id": "minecraft:deepslate"}}]})
    // rust: )]))
    // rust: .unwrap();
    // rust: let blackstone = (0..2000)
    // rust: .filter(|i| {
    // rust: let out = t.run(
    // rust: &weighted,
    // rust: (42, "minecraft:air"),
    // rust: [0; 3],
    // rust: [*i, 0, -*i],
    // rust: "minecraft:cobblestone",
    // rust: );
    // rust: t.name(out) == "minecraft:blackstone"
    // rust: })
    // rust: .count();
    // rust: assert!((420..580).contains(&blackstone), "{blackstone}");

        // block_entity_modifier gives the output its block entity.
    // rust: let mut loot = set_block(simple("minecraft:chest"));
    // rust: loot["block_entity_modifier"] =
    // rust: json!({"type": "minecraft:append_loot", "loot_table": "t:chests/house"});
    // rust: let out = t
    // rust: .run(
    // rust: &t.decode(json!([loot])).unwrap(),
    // rust: (0, "minecraft:air"),
    // rust: [0; 3],
    // rust: [0; 3],
    // rust: "minecraft:air",
    // rust: )
    // rust: .unwrap();
    // rust: let table = out
    // rust: .nbt
    // rust: .as_ref()
    // rust: .and_then(|n| n.get(&JavaString::from("LootTable")));
    // rust: assert_eq!(table, Some(&Tag::String("t:chests/house".into())));

        // Providers the game does not run are refused.
    // rust: assert!(
    // rust: t.decode(json!([set_block(
    // rust: json!({"type": "minecraft:noise_provider"})
    // rust: )]))
    // rust: .is_err()
    // rust: );
}
}
