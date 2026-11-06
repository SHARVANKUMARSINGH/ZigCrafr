//! Transpiled from Horizon Rust crate
package horizon_world_registry

import "core:fmt"
import "core:mem"
import "core:math"

// Runtime block-state IDs imported from a version-pinned registry data export.
// This supplies identities and default properties, not block behavior.
    // rust: mod facts;
    // rust: mod json;
    // rust: pub(crate) mod snapshot;
// use crate::{DATA_VERSION, chunk::BlockState, compression::invalid, nbt::Tag};
    // rust: pub use json::BlockStateJsonCodec;
    // rust: pub(crate) use json::java_integer;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet, HashMap},
    // rust: hash::{DefaultHasher, Hash, Hasher},
    // rust: io,
}

BlockStateId :: struct {

BlockRegistry :: struct {
    states: [dynamic]BlockState,
    // Ids by a hash of their state, checked against `states`: 12 bytes per
    // state instead of a second copy of every name and property map (about
    // 125 MB for a registry of 190,000 states).
    ids: HashMap<u64,
    // States whose hash an earlier state already took (none in vanilla).
    collided: BTreeMap<BlockState,
    defaults: BTreeMap<string,
}
// The hash [`BlockRegistry`] indexes states by (fixed keys: the same in
// every process).
state_key :: proc(state: ^BlockState) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut hasher = DefaultHasher::new();
    // rust: state.name.hash(&mut hasher);
    // rust: for (key, value) in &state.properties {
    // rust: key.hash(&mut hasher);
    // rust: value.hash(&mut hasher);
}
    // rust: hasher.finish()
}
    // rust: impl BlockRegistry {
from_nbt :: proc(tag: ^Tag) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if tag.get("DataVersion") != Some(&Tag::Int(DATA_VERSION)) {
    // rust: return Err(invalid("block registry DataVersion mismatch"));
}
    // rust: let Some(Tag::List(entries)) = tag.get("states") else {
    // rust: return Err(invalid("missing registry states"));
}
    // rust: let Some(Tag::Compound(defaults)) = tag.get("defaults") else {
    // rust: return Err(invalid("missing registry defaults"));
}
    // rust: let states = entries
    // rust: .iter()
    // rust: .map(BlockState::from_nbt)
    // rust: .collect::<io::Result<_>>()?;
    // rust: let defaults = defaults
    // rust: .iter()
    // rust: .map(|(name, id)| {
    // rust: let name = name.to_string().map_err(|e| invalid(e.to_string()))?;
    // rust: let Tag::Int(id) = id else {
    // rust: return Err(invalid("default state ID is not an int"));
}
    // rust: Ok((name, i64::from(*id)))
    // rust: })
    // rust: .collect::<io::Result<_>>()?;
    // rust: Self::from_states(states, defaults)
}

    // The registry of a resources `facts.json` (`{"states": [[..., ..., ...,
    // ..., state], ...], "defaults": {name: id}}`), read as it streams: no
    // JSON or NBT tree of the whole file is built. For a pack of 190,000
    // states the two trees were several hundred megabytes at startup.
from_facts_json :: proc(reader: impl io::Read) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Self::from_facts_json_with_flags(reader)?.0)
}

    // [`Self::from_facts_json`], with each state's `(air, fluid)` columns.
    // rust: pub fn from_facts_json_with_flags(
    // rust: reader: impl io::Read,
    // rust: ) -> io::Result<(Self, Vec<(bool, bool)>)> {
    // rust: let facts: facts::Facts =
    // rust: facts::with_shared_strings(|| serde_json::from_reader(io::BufReader::new(reader)))
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: Self::from_facts(facts)
}

    // [`Self::from_facts_json_with_flags`] over bytes already in memory.
    //
    // `serde_json` cannot borrow out of a reader, so `from_reader` copies
    // every string it parses; over one slice it borrows instead. The facts
    // are about 10 MB and sit at the head of the start, before anything
    // else in the core bundle can begin, so the difference is on the
    // critical path.
from_facts_json_bytes :: proc(bytes: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let facts: facts::Facts = facts::with_shared_strings(|| serde_json::from_slice(bytes))
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: Self::from_facts(facts)
}

from_facts :: proc(facts: facts::Facts) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let flags = facts.states.iter().map(|r| (r.air, r.fluid)).collect();
    // rust: let states = facts.states.into_iter().map(|r| r.state).collect();
    // rust: Ok((Self::from_states(states, facts.defaults)?, flags))
}

from_states :: proc(states: [dynamic]BlockState, defaults: BTreeMap<string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if states.is_empty() || states.len() > i32::MAX as usize {
    // rust: return Err(invalid("invalid registry size"));
}
    // rust: let mut result = Self {
    // rust: states: Vec::with_capacity(states.len()),
    // rust: ids: HashMap::with_capacity(states.len()),
    // rust: collided: BTreeMap::new(),
    // rust: defaults: BTreeMap::new(),
}
        // The states' property names and values: a few hundred strings, shared.
    // rust: let mut strings = crate::block_state_properties::SharedStrings::default();
    // rust: for (i, mut state) in states.into_iter().enumerate() {
    // rust: state.properties.share(&mut strings);
    // rust: if result.id(&state).is_some() {
    // rust: return Err(invalid("duplicate block registry state"));
}
    // rust: match result.ids.entry(state_key(&state)) {
    // rust: std::collections::hash_map::Entry::Vacant(slot) => {
    // rust: slot.insert(i as u32);
}
    // rust: std::collections::hash_map::Entry::Occupied(_) => {
    // rust: result
    // rust: .collided
    // rust: .insert(state.clone(), BlockStateId(i as u32));
}
}
    // rust: result.states.push(state);
}
    // rust: for (name, id) in defaults {
    // rust: if id < 0
    // rust: || id > i64::from(i32::MAX)
    // rust: || result
    // rust: .states
    // rust: .get(id as usize)
    // rust: .is_none_or(|s| s.name != name)
    // rust: {
    // rust: return Err(invalid("invalid default block state ID"));
}
    // rust: result.defaults.insert(name, BlockStateId(id as u32));
}
    // rust: let names: BTreeSet<_> = result.states.iter().map(|s| &s.name).collect();
    // rust: if names.len() != result.defaults.len()
    // rust: || names
    // rust: .iter()
    // rust: .any(|name| !result.defaults.contains_key(*name))
    // rust: {
    // rust: return Err(invalid("registry is missing block defaults"));
}
    // rust: Ok(result)
}
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.states.len()
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.states.is_empty()
}
state :: proc(self: ^Self, id: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.states.get(id.0 as usize)
}
id :: proc(self: ^Self, state: ^BlockState) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.ids.get(&state_key(state)) {
    // rust: Some(&id) if self.states[id as usize] == *state => Some(BlockStateId(id)),
    // rust: _ => self.collided.get(state).copied(),
}
}
default_state :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.defaults.get(name).copied()
}

    // The values `property` takes on `block`, in `Property.getPossibleValues`
    // order. The state list is in `StateDefinition` order (properties sorted
    // by name, values in their own order), so a value's first appearance is
    // that order.
property_values :: proc(self: ^Self, block: string, property: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut values: Vec<&str> = Vec::new();
    // rust: for state in self
    // rust: .states
    // rust: .iter()
    // rust: .filter(|state| state.name.as_str() == block)
    // rust: {
    // rust: if let Some(value) = state.properties.get(property) {
    // rust: let value = value.as_str();
    // rust: if !values.contains(&value) {
    // rust: values.push(value);
}
}
}
    // rust: values
}

    // Resolve a saved descriptor, supplying omitted default properties. Unlike
    // vanilla's lenient logging paths, invalid properties return a typed error.
resolve :: proc(self: ^Self, descriptor: ^BlockState) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let default = self
    // rust: .default_state(&descriptor.name)
    // rust: .ok_or_else(|| invalid("unknown block name"))?;
    // rust: let mut state = self.state(default).unwrap().clone();
    // rust: for (key, value) in &descriptor.properties {
    // rust: if !state.properties.contains_key(key) {
    // rust: return Err(invalid("unknown block property"));
}
    // rust: state.properties.insert(key.clone(), value.clone());
}
    // rust: self.id(&state)
    // rust: .ok_or_else(|| invalid("invalid block property value"))
}
}

// A per-state table (`occlusion.nbt`, `cached-collision.nbt`, ...) whose
// `states` list, the identity of every state it describes in id order, has
// been checked against `registry`.
BlockTable :: struct {
    tag: ^'t Tag,
    registry: ^'r BlockRegistry,
    // How many levels, from this one down, [`BlockTableFile::read`] checked
    // while reading: their `states` lists are kept empty in the tree.
    read_checked: u8,
}
    // rust: impl<'t, 'r> BlockTable<'t, 'r> {
    // Checks that `tag`'s `states` names the registry's states in id order.
check :: proc(tag: ^'t Tag, registry: ^'r BlockRegistry, what: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: tag,
    // rust: registry,
    // rust: read_checked: 0,
}
    // rust: .checked(what)
}
checked :: proc(self: ^Self, what: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let Some(Tag::List(states)) = self.tag.get("states") else {
    // rust: return Err(invalid(format!("missing {what} state identities")));
}
    // rust: if self.read_checked == 0 {
    // rust: if states.len() != self.registry.len() {
    // rust: return Err(invalid(format!("{what} registry size mismatch")));
}
    // rust: for (id, state) in states.iter().enumerate() {
    // rust: if self.registry.state(BlockStateId(id as u32))
    // rust: != Some(&BlockState::from_nbt(state)?)
    // rust: {
    // rust: return Err(invalid(format!("{what} state identities differ")));
}
}
}
    // rust: Ok(self)
}
    // The table nested under `key` (`block-properties.nbt`'s `occlusion`),
    // with its own `states`, checked the same way.
nested :: proc(self: ^Self, key: string, what: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: tag: self
    // rust: .tag
    // rust: .get(key)
    // rust: .ok_or_else(|| invalid(format!("missing {what}")))?,
    // rust: registry: self.registry,
    // rust: read_checked: self.read_checked.saturating_sub(1),
}
    // rust: .checked(what)
}
tag :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.tag
}
get :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.tag.get(key)
}
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
}
}

// A per-state table read from its file with its state identities checked
// while reading, so they never exist as a tree: for 190,000 states (a big
// modpack) that tree took 300-600 MB per table.
BlockTableFile :: struct {
    tag: Tag,
    registry: ^'r BlockRegistry,
}
    // rust: impl<'r> BlockTableFile<'r> {
    // [`Self::read`] of the file at `path`.
open :: proc(path: ^std::path::Path, registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let bytes = std::fs::read(path)?;
    // rust: Self::read(&bytes, registry).map_err(|e| invalid(format!("{}: {e}", path.display())))
}
    // Reads `bytes`, checking every `states` list of the root compound and
    // of the compounds directly under it against `registry`.
read :: proc(bytes: []u8, registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut visit = |states: &mut crate::nbt::ListElements<'_, '_, '_>| {
    // rust: if states.len() != registry.len() {
    // rust: return Err(states.error("table registry size mismatch"));
}
    // rust: let mut id = 0u32;
    // rust: while let Some(tag) = states.next_element()? {
    // rust: let state =
    // rust: BlockState::from_nbt(&tag).map_err(|_| states.error("invalid table state"))?;
    // rust: if registry.state(BlockStateId(id)) != Some(&state) {
    // rust: return Err(states.error("table state identities differ"));
}
    // rust: id += 1;
}
    // rust: Ok(())
}
    // rust: let (named, _) = crate::nbt::read_named_streaming(
    // rust: bytes,
    // rust: crate::nbt::Limits::tables(),
    // rust: "states",
    // rust: &mut visit,
    // rust: )
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: Ok(Self {
    // rust: tag: named.tag,
    // rust: registry,
    // rust: })
}
    // The table, checked (`what` names it in errors).
table :: proc(self: ^Self, what: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: BlockTable {
    // rust: tag: &self.tag,
    // rust: registry: self.registry,
    // rust: read_checked: 2,
}
    // rust: .checked(what)
}
}
