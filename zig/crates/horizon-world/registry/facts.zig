//! Transpiled from Horizon Rust crate
//! Module: horizon-world_facts
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The part of `facts.json` the block registry reads, deserialized as it
//! streams: each row's state (its fifth column) and the defaults.
// use crate::{
    // rust: block_state_properties::SharedStrings,
    // rust: chunk::{BlockProperties, BlockState},
}
// use serde::{
    // rust: Deserialize, Deserializer,
    // rust: de::{self, IgnoredAny, MapAccess, SeqAccess, Visitor},
}
// use std::{cell::RefCell, collections::BTreeMap, fmt};

    // rust: pub(super) struct Facts {
    // rust: pub states: Vec<Row>,
    // rust: pub defaults: BTreeMap<String, i64>,
}

/// One `states` row: `[name, air, fluid, description, state, ...]`, keeping
/// the two flags and the state.
    // rust: pub(super) struct Row {
    // rust: pub air: bool,
    // rust: pub fluid: bool,
    // rust: pub state: BlockState,
}

    // rust: impl<'de> Deserialize<'de> for Row {
    // rust: fn deserialize<D: Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
pub const RowVisitor = struct {};
    // rust: impl<'de> Visitor<'de> for RowVisitor {
    // rust: type Value = Row;
pub fn expecting(self: *Self, f: *mut fmt::Formatter) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("a registry state row")
}
    // rust: fn visit_seq<A: SeqAccess<'de>>(self, mut seq: A) -> Result<Row, A::Error> {
    // rust: let length = |i| de::Error::invalid_length(i, &self);
    // rust: seq.next_element::<IgnoredAny>()?.ok_or_else(|| length(0))?;
    // rust: let air = seq.next_element::<bool>()?.ok_or_else(|| length(1))?;
    // rust: let fluid = seq.next_element::<bool>()?.ok_or_else(|| length(2))?;
    // rust: seq.next_element::<IgnoredAny>()?.ok_or_else(|| length(3))?;
    // rust: let state = seq.next_element::<State>()?.ok_or_else(|| length(4))?;
    // rust: while seq.next_element::<IgnoredAny>()?.is_some() {}
    // rust: Ok(Row {
    // rust: air,
    // rust: fluid,
    // rust: state: state.0,
    // rust: })
}
}
    // rust: deserializer.deserialize_seq(RowVisitor)
}
}

    // rust: thread_local! {
    /// The strings the states being read share (`with_shared_strings`).
pub const STRINGS: RefCell<?SharedStrings> = const { RefCell::new(None) };
}

/// Runs `read` with the states it reads sharing their property strings.
    // rust: pub(super) fn with_shared_strings<T>(read: impl FnOnce() -> T) -> T {
    // rust: STRINGS.with(|s| *s.borrow_mut() = Some(SharedStrings::default()));
    // rust: let out = read();
    // rust: STRINGS.with(|s| s.borrow_mut().take());
    // rust: out
}

/// A property name or value, shared with the other states' equal ones.
pub const Shared = struct {};
    // rust: impl<'de> Deserialize<'de> for Shared {
    // rust: fn deserialize<D: Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
pub const SharedVisitor = struct {};
    // rust: impl Visitor<'_> for SharedVisitor {
    // rust: type Value = Shared;
pub fn expecting(self: *Self, f: *mut fmt::Formatter) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("a string")
}
    // rust: fn visit_str<E: de::Error>(self, text: &str) -> Result<Shared, E> {
    // rust: Ok(Shared(STRINGS.with(|s| match s.borrow_mut().as_mut() {
    // rust: Some(strings) => strings.get(text),
    // rust: None => SharedStrings::default().get(text),
    // rust: })))
}
}
    // rust: deserializer.deserialize_str(SharedVisitor)
}
}

/// A state's `properties` object, read straight into shared strings.
pub const Properties = struct {};
    // rust: impl<'de> Deserialize<'de> for Properties {
    // rust: fn deserialize<D: Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
pub const PropertiesVisitor = struct {};
    // rust: impl<'de> Visitor<'de> for PropertiesVisitor {
    // rust: type Value = Properties;
pub fn expecting(self: *Self, f: *mut fmt::Formatter) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("block state properties")
}
    // rust: fn visit_map<A: MapAccess<'de>>(self, mut map: A) -> Result<Properties, A::Error> {
    // rust: let mut pairs = Vec::new();
    // rust: while let Some((Shared(k), Shared(v))) = map.next_entry()? {
    // rust: pairs.push((k, v));
}
    // rust: Ok(Properties(BlockProperties::from_shared(pairs)))
}
}
    // rust: deserializer.deserialize_map(PropertiesVisitor)
}
}

/// A state as BlockState::from_nbt reads it: a name, or `{"id", "properties"}`.
pub const State = struct {};

    // rust: impl<'de> Deserialize<'de> for State {
    // rust: fn deserialize<D: Deserializer<'de>>(deserializer: D) -> Result<Self, D::Error> {
pub const StateVisitor = struct {};
    // rust: impl<'de> Visitor<'de> for StateVisitor {
    // rust: type Value = State;
pub fn expecting(self: *Self, f: *mut fmt::Formatter) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f.write_str("a block state name or {\"id\", \"properties\"}")
}
    // rust: fn visit_str<E: de::Error>(self, name: &str) -> Result<State, E> {
    // rust: Ok(State(BlockState {
    // rust: name: name.to_owned(),
    // rust: properties: BlockProperties::new(),
    // rust: }))
}
    // rust: fn visit_map<A: MapAccess<'de>>(self, mut map: A) -> Result<State, A::Error> {
    // rust: let (mut id, mut properties) = (None, None);
    // rust: while let Some(key) = map.next_key::<std::borrow::Cow<'de, str>>()? {
    // rust: match &*key {
    // rust: "id" if id.is_some() => return Err(de::Error::duplicate_field("id")),
    // rust: "id" => id = Some(map.next_value::<String>()?),
    // rust: "properties" if properties.is_some() => {
    // rust: return Err(de::Error::duplicate_field("properties"));
}
    // rust: "properties" => properties = Some(map.next_value::<Properties>()?.0),
    // rust: _ => {
    // rust: map.next_value::<IgnoredAny>()?;
}
}
}
    // rust: Ok(State(BlockState {
    // rust: name: id.ok_or_else(|| de::Error::missing_field("id"))?,
    // rust: properties: properties.unwrap_or_default(),
    // rust: }))
}
}
    // rust: deserializer.deserialize_any(StateVisitor)
}
}

    // rust: mod tests {
//     use crate::{
    // rust: DATA_VERSION,
    // rust: chunk::BlockState,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId},
}
//     use serde_json::Value;
//     use std::path::Path;

pub fn reads_states_and_defaults() void {
}
    // rust: let json = br#"{"defaults": {"minecraft:air": 0, "minecraft:oak_slab": 2},
    // rust: "states": [
    // rust: ["minecraft:air", true, false, "Block{minecraft:air}", "minecraft:air"],
    // rust: ["minecraft:oak_slab", false, false, "x", {"id": "minecraft:oak_slab", "properties": {"type": "top"}}, "extra"],
    // rust: ["minecraft:oak_slab", false, true, "x", {"id": "minecraft:oak_slab", "properties": {"type": "bottom"}}]
    // rust: ], "other": [1, 2]}"#;
    // rust: let (registry, flags) = BlockRegistry::from_facts_json_with_flags(&json[..]).unwrap();
    // rust: assert_eq!(registry.len(), 3);
    // rust: assert_eq!(flags, [(true, false), (false, false), (false, true)]);
    // rust: assert_eq!(
    // rust: registry.default_state("minecraft:oak_slab"),
    // rust: Some(BlockStateId(2))
    // rust: );
    // rust: let top = BlockState {
    // rust: name: "minecraft:oak_slab".into(),
    // rust: properties: [("type".into(), "top".into())].into(),
}
    // rust: assert_eq!(registry.id(&top), Some(BlockStateId(1)));
        // A default naming another block, a short row, a missing default.
    // rust: for bad in [
    // rust: &br#"{"defaults": {"minecraft:air": 1}, "states": [["minecraft:air", true, false, "", "minecraft:air"], ["minecraft:stone", false, false, "", "minecraft:stone"]]}"#[..],
    // rust: br#"{"defaults": {"minecraft:air": 0}, "states": [["minecraft:air", true, false, ""]]}"#,
    // rust: br#"{"defaults": {}, "states": [["minecraft:air", true, false, "", "minecraft:air"]]}"#,
    // rust: ] {
    // rust: assert!(BlockRegistry::from_facts_json(bad).is_err());
}
}

    /// The streamed registry is the one the JSON and NBT trees built.
pub fn matches_the_tree_built_registry() void {
}
    // rust: let path = Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3/facts.json");
    // rust: let Ok(bytes) = std::fs::read(&path) else {
    // rust: eprintln!("skipped: no prepared facts.json");
    // rust: return;
}
pub fn tag(v: *Value) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::String(s) => Tag::String(s.as_str().into()),
    // rust: Value::Number(n) => Tag::Int(n.as_i64().unwrap() as i32),
    // rust: Value::Object(o) => {
    // rust: Tag::Compound(o.iter().map(|(k, v)| (k.as_str().into(), tag(v))).collect())
}
    // rust: _ => unreachable!(),
}
}
    // rust: let facts: Value = serde_json::from_slice(&bytes).unwrap();
    // rust: let rows = facts["states"].as_array().unwrap();
    // rust: let tree = BlockRegistry::from_nbt(&Tag::compound([
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: (
    // rust: "states",
    // rust: Tag::List(rows.iter().map(|r| tag(&r[4])).collect()),
    // rust: ),
    // rust: ("defaults", tag(&facts["defaults"])),
    // rust: ]))
    // rust: .unwrap();
    // rust: let (streamed, flags) = BlockRegistry::from_facts_json_with_flags(&bytes[..]).unwrap();
    // rust: assert_eq!(streamed.len(), tree.len());
    // rust: for (i, row) in rows.iter().enumerate() {
    // rust: let id = BlockStateId(i as u32);
    // rust: assert_eq!(streamed.state(id), tree.state(id));
    // rust: assert_eq!(
    // rust: flags[i],
    // rust: (row[1].as_bool().unwrap(), row[2].as_bool().unwrap())
    // rust: );
}
    // rust: for name in facts["defaults"].as_object().unwrap().keys() {
    // rust: assert_eq!(streamed.default_state(name), tree.default_state(name));
}
}
}
