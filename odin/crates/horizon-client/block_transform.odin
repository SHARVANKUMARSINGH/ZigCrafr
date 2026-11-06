//! Transpiled from Horizon Rust crate
package horizon_client_block_transform

import "core:fmt"
import "core:mem"
import "core:math"

// The `minecraft:block_transformer` registry (axe, hoe, shovel) that
// `BlockTransformer.transformBlock` reads: each transform's rule based state
// provider is evaluated against the clicked block and the block above.
// `tools/test_block_transformer_parity.py` compares every block state with
// vanilla.
// use crate::{Result, items::Items};
// use horizon_world::{chunk::BlockState, registry::BlockRegistry};
// use serde_json::Value;
// use std::{collections::HashMap, fs, path::Path};

Predicate :: enum {
    Blocks(Vec<String>),
    Tag { tag: String, offset: [i32; 3] },
    AllOf(Vec<Predicate>),
    AnyOf(Vec<Predicate>),
}

Provider :: enum {
    Rules(Vec<(Predicate, Provider)>),
    State(BlockState),
    // `CopyPropertiesProvider`: the source with the clicked block's properties.
    Copy(Box<Provider>),
}

// One `BlockTransformData`.
Transform :: struct {
    provider: Provider,
    disallowed_faces: [dynamic]string,
    sound: string,
    particle: string,
    loot: Maybe(string),
    drop_strategy: string,
    update_from_neighbors: bool,
    transform_type: string,
    consume_on_use: bool,
    damage: u32,
}

Transformers :: struct {
    transformers: HashMap<string,
}

// What the transformer reads of the world: the block state at an offset from
// the clicked position.
    // rust: pub trait Around {
state :: proc(self: ^Self, offset: [i32; 3]) -> B {
    // Ported from Horizon
    return {}
}
}

state_of :: proc(value: ^Value, registry: ^BlockRegistry) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = value["id"].as_str().or_else(|| value["Name"].as_str())?;
    // rust: let default = registry.default_state(name)?;
    // rust: let mut state = registry.state(default)?.clone();
    // rust: for (k, v) in value["properties"].as_object().into_iter().flatten() {
    // rust: state.properties.insert(k.clone(), v.as_str()?.to_owned());
}
    // rust: Some(state)
}

predicate :: proc(value: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match value["type"].as_str()? {
    // rust: "minecraft:matching_blocks" => Predicate::Blocks(match &value["blocks"] {
    // rust: Value::String(s) => vec![s.clone()],
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|b| b.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: _ => return None,
    // rust: }),
    // rust: "minecraft:matching_block_tag" => {
    // rust: let o = value["offset"].as_array();
    // rust: let at = |i: usize| {
    // rust: o.and_then(|o| o.get(i))
    // rust: .and_then(Value::as_i64)
    // rust: .unwrap_or(0) as i32
}
    // rust: Predicate::Tag {
    // rust: tag: value["tag"].as_str()?.to_owned(),
    // rust: offset: [at(0), at(1), at(2)],
}
}
    // rust: "minecraft:all_of" => Predicate::AllOf(
    // rust: value["predicates"]
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(predicate)
    // rust: .collect::<Option<_>>()?,
    // rust: ),
    // rust: "minecraft:any_of" => Predicate::AnyOf(
    // rust: value["predicates"]
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(predicate)
    // rust: .collect::<Option<_>>()?,
    // rust: ),
    // rust: _ => return None,
    // rust: })
}

provider :: proc(value: ^Value, registry: ^BlockRegistry) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match value["type"].as_str() {
    // rust: Some("minecraft:rule_based") => {
    // rust: let mut rules = Vec::new();
    // rust: for rule in value["rules"].as_array()? {
    // rust: rules.push((
    // rust: predicate(&rule["if_true"])?,
    // rust: provider(&rule["then"], registry)?,
    // rust: ));
}
    // rust: Some(Provider::Rules(rules))
}
    // rust: Some("minecraft:copy_properties") => Some(Provider::Copy(Box::new(provider(
    // rust: &value["source"],
    // rust: registry,
    // rust: )?))),
    // rust: _ => state_of(value, registry).map(Provider::State),
}
}

// `BlockState.withPropertiesOf`: the properties both blocks have.
    // rust: fn with_properties_of(
    // rust: registry: &BlockRegistry,
    // rust: mut state: BlockState,
    // rust: old: &BlockState,
    // rust: ) -> Option<BlockState> {
    // rust: let defaults = registry
    // rust: .default_state(&state.name)
    // rust: .and_then(|id| registry.state(id))?;
    // rust: for (k, v) in &old.properties {
    // rust: if defaults.properties.contains_key(k) {
    // rust: let mut candidate = state.clone();
    // rust: candidate.properties.insert(k.clone(), v.clone());
    // rust: if registry.resolve(&candidate).is_ok() {
    // rust: state = candidate;
}
}
}
    // rust: Some(state)
}

    // rust: impl Predicate {
test :: proc(self: ^Self, items: ^Items, around: ^dyn Around) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Blocks(names) => {
    // rust: let state = around.state([0, 0, 0]);
    // rust: names.contains(&state.name)
}
    // rust: Self::Tag { tag, offset } => {
    // rust: let state = around.state(*offset);
    // rust: items
    // rust: .block_tags
    // rust: .get(tag)
    // rust: .is_some_and(|members| members.contains(&state.name))
}
    // rust: Self::AllOf(all) => all.iter().all(|p| p.test(items, around)),
    // rust: Self::AnyOf(any) => any.iter().any(|p| p.test(items, around)),
}
}
}

    // rust: impl Provider {
    // rust: fn state(
    // rust: &self,
    // rust: items: &Items,
    // rust: registry: &BlockRegistry,
    // rust: around: &dyn Around,
    // rust: ) -> Option<BlockState> {
    // rust: match self {
    // rust: Self::Rules(rules) => rules
    // rust: .iter()
    // rust: .find(|(p, _)| p.test(items, around))
    // rust: .and_then(|(_, then)| then.state(items, registry, around)),
    // rust: Self::State(state) => Some(state.clone()),
    // rust: Self::Copy(source) => {
    // rust: let state = source.state(items, registry, around)?;
    // rust: with_properties_of(registry, state, &around.state([0, 0, 0]))
}
}
}
}

    // rust: impl Transformers {
    // Reads `data/minecraft/block_transformer/*.json`.
load :: proc(root: ^Path, registry: ^BlockRegistry) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut transformers = HashMap::new();
    // rust: let dir = root.join("data/minecraft/block_transformer");
    // rust: if dir.exists() {
    // rust: for entry in fs::read_dir(&dir)?.flatten() {
    // rust: let path = entry.path();
    // rust: let Some(stem) = path.file_stem().and_then(|s| s.to_str()) else {
    // rust: continue;
}
    // rust: let list: Value = serde_json::from_slice(&fs::read(&path)?)?;
    // rust: let mut transforms = Vec::new();
    // rust: for t in list.as_array().into_iter().flatten() {
    // rust: let text = |k: &str, d: &str| t[k].as_str().unwrap_or(d).to_owned();
    // rust: let Some(provider) = provider(&t["block_state_provider"], registry) else {
    // rust: continue;
}
    // rust: transforms.push(Transform {
    // rust: provider,
    // rust: disallowed_faces: t["disallowed_faces"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|f| f.as_str().map(str::to_owned))
    // rust: .collect(),
    // rust: sound: text("sound", "minecraft:empty"),
    // rust: particle: text("particle", "none"),
    // rust: loot: t["loot"].as_str().map(str::to_owned),
    // rust: drop_strategy: text("drop_strategy", "from_middle"),
    // rust: update_from_neighbors: t["update_from_neighbors"].as_bool().unwrap_or(true),
    // rust: transform_type: text("transform_type", "single_block"),
    // rust: consume_on_use: t["consume_on_use"].as_bool().unwrap_or(true),
    // rust: damage: t["item_damage_per_use"].as_u64().unwrap_or(0) as u32,
    // rust: });
}
    // rust: transformers.insert(format!("minecraft:{stem}"), transforms);
}
}
    // rust: Ok(Self { transformers })
}

    // `BlockTransformer.transformBlock` without the world writes: the first
    // transform that allows the clicked face and provides a state, with its
    // index.
    // rust: pub fn apply<'a>(
    // rust: &'a self,
    // rust: items: &Items,
    // rust: registry: &BlockRegistry,
    // rust: id: &str,
    // rust: face: &str,
    // rust: around: &dyn Around,
    // rust: ) -> Option<(usize, &'a Transform, BlockState)> {
    // rust: self.transformers
    // rust: .get(id)?
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, t)| !t.disallowed_faces.iter().any(|f| f == face))
    // rust: .find_map(|(i, t)| Some((i, t, t.provider.state(items, registry, around)?)))
}

    // `HoneycombItem.getWaxed`: the waxed twin of a copper block, found from
    // the axe's wax-off transforms (`WAX_OFF_BY_BLOCK` is the inverse of
    // `WAXABLES`).
waxed :: proc(self: ^Self, registry: ^BlockRegistry, old: ^BlockState) -> O {
    // Ported from Horizon
    return {}
}
    // rust: for transform in self.transformers.get("minecraft:axe")? {
    // rust: if transform.particle != "wax_off" {
    // rust: continue;
}
    // rust: let Provider::Rules(rules) = &transform.provider else {
    // rust: continue;
}
    // rust: for (predicate, then) in rules {
    // rust: if let (Predicate::Blocks(names), Provider::Copy(source)) = (predicate, then)
    // rust: && let Provider::State(unwaxed) = &**source
    // rust: && unwaxed.name == old.name
    // rust: && let Some(waxed) = names.first()
    // rust: {
    // rust: let target = registry
    // rust: .default_state(waxed)
    // rust: .and_then(|id| registry.state(id))?
    // rust: .clone();
    // rust: return with_properties_of(registry, target, old);
}
}
}
    // rust: None
}
}
