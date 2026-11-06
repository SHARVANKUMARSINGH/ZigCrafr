//! Transpiled from Horizon Rust crate
package horizon_world_json

import "core:fmt"
import "core:mem"
import "core:math"

// Java 26.3 compact/full block-state JSON codecs over a pinned registry.
// use super::{BlockRegistry, BlockStateId};
// use crate::compression::invalid;
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: io,
}

// Property kinds accompany the imported state registry. Integer properties
// parse Java decimal strings; enum and boolean properties use exact names.
BlockStateJsonCodec :: struct {
    registry: ^'a BlockRegistry,
    integers: BTreeSet<(string,
    counts: BTreeMap<string,
}
    // rust: impl<'a> BlockStateJsonCodec<'a> {
    // rust: pub fn new(
    // rust: registry: &'a BlockRegistry,
    // rust: integers: BTreeSet<(String, String)>,
    // rust: ) -> io::Result<Self> {
    // rust: for (block, property) in &integers {
    // rust: let state = registry
    // rust: .default_state(block)
    // rust: .and_then(|id| registry.state(id));
    // rust: if !state.is_some_and(|state| state.properties.contains_key(property)) {
    // rust: return Err(invalid("integer property is absent from block registry"));
}
}
    // rust: let mut counts = BTreeMap::new();
    // rust: for state in &registry.states {
    // rust: *counts.entry(state.name.clone()).or_insert(0) += 1;
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: integers,
    // rust: counts,
    // rust: })
}
    // `full` selects FULL_CODEC, which requires the object representation.
    // Invalid/missing properties keep their defaults, as vanilla's codec does.
decode :: proc(self: ^Self, json: string, full: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let value: Value = serde_json::from_str(json).map_err(|e| invalid(e.to_string()))?;
    // rust: let name = if !full && value.is_string() {
    // rust: value.as_str()
    // rust: } else {
    // rust: value.get("id").and_then(Value::as_str)
}
    // rust: .ok_or_else(|| invalid("missing block identifier"))?;
    // rust: let (namespace, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let name = format!(
    // rust: "{}:{path}",
    // rust: if namespace.is_empty() {
    // rust: "minecraft"
    // rust: } else {
    // rust: namespace
}
    // rust: );
    // rust: let default = self
    // rust: .registry
    // rust: .default_state(&name)
    // rust: .ok_or_else(|| invalid("unknown block identifier"))?;
    // rust: let mut state = self.registry.state(default).unwrap().clone();
    // rust: if let Some(properties) = value.get("properties").and_then(Value::as_object) {
    // rust: for (key, raw) in properties {
    // rust: if !state.properties.contains_key(key) {
    // rust: continue;
}
    // rust: let Some(value) = raw.as_str() else {
    // rust: continue;
}
    // rust: let candidate = if self.integers.contains(&(name.clone(), key.clone())) {
    // rust: let Some(value) = java_integer(value) else {
    // rust: continue;
}
    // rust: value.to_string()
    // rust: } else {
    // rust: value.to_owned()
}
    // rust: let previous = state.properties.insert(key.clone(), candidate).unwrap();
    // rust: if self.registry.id(&state).is_none() {
    // rust: state.properties.insert(key.clone(), previous);
}
}
}
    // rust: self.registry
    // rust: .id(&state)
    // rust: .ok_or_else(|| invalid("block state is absent from registry"))
}
encode :: proc(self: ^Self, id: BlockStateId, full: bool) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let state = self
    // rust: .registry
    // rust: .state(id)
    // rust: .ok_or_else(|| invalid("unknown block state ID"))?;
    // rust: let value = if !full && self.registry.default_state(&state.name) == Some(id) {
    // rust: Value::String(state.name.clone())
    // rust: } else if self.counts[&state.name] == 1 {
    // rust: serde_json::json!({"id":state.name})
    // rust: } else {
    // rust: serde_json::json!({"id":state.name,"properties":state.properties})
}
    // rust: serde_json::to_string(&value).map_err(|e| invalid(e.to_string()))
}
}

    // rust: pub(crate) use horizon_core::text::parse_java_integer as java_integer;
