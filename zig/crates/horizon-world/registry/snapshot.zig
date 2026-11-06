//! Transpiled from Horizon Rust crate
//! Module: horizon-world_snapshot
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A `BlockRegistry`'s snapshot wire format: the built tables, exact and
//! small — names and property strings once in a table, states and defaults as
//! indexes into it. Restore rebuilds through `SharedStrings`, so the process
//! still holds one string per distinct name and value.
// use super::{BlockRegistry, BlockStateId};
// use crate::{
    // rust: block_state_properties::{BlockProperties, SharedStrings},
    // rust: chunk::BlockState,
    // rust: compression::invalid,
}
// use serde::{Deserialize, Serialize};
// use std::{
    // rust: collections::{BTreeMap, HashMap},
    // rust: io,
}

/// A state: its name and property strings as `strings` indexes.
pub const WireState = struct {
    name: u32,
    properties: Vec<(u32,
};

/// Everything `BlockRegistry::from_states` builds, in id order.
    // rust: pub(crate) struct Snapshot {
    /// Every block name and property name and value, in first-use order.
    // rust: strings: Vec<String>,
    // rust: states: Vec<WireState>,
    /// `facts.json`'s `(air, fluid)` columns per state, bits 0 and 1.
    // rust: flags: Vec<u8>,
    /// `state_key` → id; the same build recomputes the same keys.
    // rust: ids: Vec<(u64, u32)>,
    // rust: collided: Vec<(WireState, u32)>,
    /// Block name → default state id.
    // rust: defaults: Vec<(u32, u32)>,
}

/// The snapshot's string table while it is written: indexes each new string.
pub const Strings = struct {
    strings: std.ArrayList([]const u8),
    index: HashMap<*'a str,
};
    // rust: impl<'a> Strings<'a> {
pub fn get(self: *Self, text: *'a str) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(&index) = self.index.get(text) {
    // rust: return index;
}
    // rust: let index = self.strings.len() as u32;
    // rust: self.strings.push(text.to_owned());
    // rust: self.index.insert(text, index);
    // rust: index
}
pub fn state(self: *Self, state: *'a BlockState) W {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: WireState {
    // rust: name: self.get(&state.name),
    // rust: properties: state
    // rust: .properties
    // rust: .iter()
    // rust: .map(|(key, value)| (self.get(key), self.get(value)))
    // rust: .collect(),
}
}
}

    // rust: pub(crate) fn capture(registry: &BlockRegistry, flags: &[(bool, bool)]) -> Snapshot {
    // rust: let mut strings = Strings {
    // rust: strings: Vec::new(),
    // rust: index: HashMap::new(),
}
    // rust: let states = registry
    // rust: .states
    // rust: .iter()
    // rust: .map(|state| strings.state(state))
    // rust: .collect();
    // rust: let flags = flags
    // rust: .iter()
    // rust: .map(|&(air, fluid)| air as u8 | ((fluid as u8) << 1))
    // rust: .collect();
    // rust: let ids = registry.ids.iter().map(|(&key, &id)| (key, id)).collect();
    // rust: let collided = registry
    // rust: .collided
    // rust: .iter()
    // rust: .map(|(state, id)| (strings.state(state), id.0))
    // rust: .collect();
    // rust: let defaults = registry
    // rust: .defaults
    // rust: .iter()
    // rust: .map(|(name, id)| (strings.get(name.as_str()), id.0))
    // rust: .collect();
    // rust: Snapshot {
    // rust: strings: strings.strings,
    // rust: states,
    // rust: flags,
    // rust: ids,
    // rust: collided,
    // rust: defaults,
}
}

    // rust: pub(crate) fn restore(snapshot: Snapshot) -> io::Result<(BlockRegistry, Vec<(bool, bool)>)> {
    // rust: let Snapshot {
    // rust: strings,
    // rust: states,
    // rust: flags,
    // rust: ids,
    // rust: collided,
    // rust: defaults,
    // rust: } = snapshot;
    // rust: if states.is_empty()
    // rust: || states.len() > i32::MAX as usize
    // rust: || flags.len() != states.len()
    // rust: || flags.iter().any(|f| *f > 3)
    // rust: || ids.len() > states.len()
    // rust: || collided.len() > states.len()
    // rust: {
    // rust: return Err(invalid("cached registry size mismatch"));
}
    // rust: let mut shared = SharedStrings::default();
    // rust: let text: Vec<&'static String> = strings.iter().map(|s| shared.get(s)).collect();
    // rust: let at = |index: u32| {
    // rust: text.get(index as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("cached registry string out of range"))
}
    // rust: let state_of = |wire: WireState| -> io::Result<BlockState> {
    // rust: let properties = wire
    // rust: .properties
    // rust: .iter()
    // rust: .map(|&(key, value)| Ok((at(key)?, at(value)?)))
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: Ok(BlockState {
    // rust: name: (*at(wire.name)?).clone(),
    // rust: properties: BlockProperties::from_shared(properties),
    // rust: })
}
    // rust: let states = states
    // rust: .into_iter()
    // rust: .map(state_of)
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // `from_states` puts every state in `ids` or `collided`: require that.
    // rust: let mut seen = vec![false; states.len()];
    // rust: let mut mark = |id: u32| match seen.get_mut(id as usize) {
    // rust: Some(slot) if !*slot => {
    // rust: *slot = true;
    // rust: Ok(())
}
    // rust: _ => Err(invalid("cached registry state id out of range")),
}
    // rust: let mut id_map = HashMap::with_capacity(ids.len());
    // rust: for (key, id) in ids {
    // rust: mark(id)?;
    // rust: if id_map.insert(key, id).is_some() {
    // rust: return Err(invalid("cached registry ids duplicate a key"));
}
}
    // rust: let mut collided_map = BTreeMap::new();
    // rust: for (wire, id) in collided {
    // rust: mark(id)?;
    // rust: if collided_map
    // rust: .insert(state_of(wire)?, BlockStateId(id))
    // rust: .is_some()
    // rust: {
    // rust: return Err(invalid("cached registry collided states duplicate"));
}
}
    // rust: if seen.iter().any(|covered| !*covered) {
    // rust: return Err(invalid("cached registry is missing state ids"));
}
    // rust: let mut default_map = BTreeMap::new();
    // rust: for (name, id) in defaults {
    // rust: let name = at(name)?;
    // rust: let state = states
    // rust: .get(id as usize)
    // rust: .ok_or_else(|| invalid("cached registry default out of range"))?;
    // rust: if state.name != *name {
    // rust: return Err(invalid("cached registry default names another state"));
}
    // rust: if default_map
    // rust: .insert((*name).clone(), BlockStateId(id))
    // rust: .is_some()
    // rust: {
    // rust: return Err(invalid("cached registry defaults duplicate a name"));
}
}
    // rust: let flags = flags.iter().map(|f| (f & 1 != 0, f & 2 != 0)).collect();
    // rust: Ok((
    // rust: BlockRegistry {
    // rust: states,
    // rust: ids: id_map,
    // rust: collided: collided_map,
    // rust: defaults: default_map,
    // rust: },
    // rust: flags,
    // rust: ))
}

    // rust: mod tests {
//     use super::*;

pub fn small() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let json = br#"{"defaults": {"minecraft:air": 0, "minecraft:oak_slab": 1},
    // rust: "states": [
    // rust: ["minecraft:air", true, false, "x", "minecraft:air"],
    // rust: ["minecraft:oak_slab", false, false, "x", {"id": "minecraft:oak_slab", "properties": {"type": "top"}}],
    // rust: ["minecraft:oak_slab", false, true, "x", {"id": "minecraft:oak_slab", "properties": {"type": "bottom"}}]
    // rust: ]}"#;
    // rust: BlockRegistry::from_facts_json_with_flags(&json[..]).unwrap()
}

pub fn snapshot_roundtrips_the_built_tables() void {
}
    // rust: let (registry, flags) = small();
    // rust: let (restored, restored_flags) = restore(capture(&registry, &flags)).unwrap();
    // rust: assert_eq!(restored_flags, flags);
    // rust: assert_eq!(restored.len(), registry.len());
    // rust: for i in 0..registry.len() as u32 {
    // rust: let id = BlockStateId(i);
    // rust: assert_eq!(restored.state(id), registry.state(id));
    // rust: assert_eq!(
    // rust: restored.id(registry.state(id).unwrap()),
    // rust: registry.id(registry.state(id).unwrap())
    // rust: );
}
    // rust: for name in ["minecraft:air", "minecraft:oak_slab"] {
    // rust: assert_eq!(restored.default_state(name), registry.default_state(name));
}
        // The restored properties keep the shared strings, not copies.
    // rust: let (a, b) = (
    // rust: restored.state(BlockStateId(1)).unwrap(),
    // rust: restored.state(BlockStateId(2)).unwrap(),
    // rust: );
    // rust: let key = a.properties.keys().next().unwrap();
    // rust: assert!(std::ptr::eq(key, b.properties.keys().next().unwrap()));
}

pub fn restore_rejects_beyond_the_tables() void {
}
    // rust: let (registry, flags) = small();
    // rust: let mut snapshot = capture(&registry, &flags);
    // rust: snapshot.flags.pop();
    // rust: assert!(restore(snapshot).is_err(), "short flags");
    // rust: let mut snapshot = capture(&registry, &flags);
    // rust: snapshot.ids.push((0, 99));
    // rust: assert!(restore(snapshot).is_err(), "id out of range");
    // rust: let mut snapshot = capture(&registry, &flags);
    // rust: snapshot.ids.pop();
    // rust: assert!(restore(snapshot).is_err(), "a state unindexed");
    // rust: let mut snapshot = capture(&registry, &flags);
    // rust: snapshot.strings.push("minecraft:cobblestone".into());
    // rust: let cobble = snapshot.strings.len() as u32 - 1;
    // rust: snapshot.defaults[0].0 = cobble;
    // rust: assert!(restore(snapshot).is_err(), "default names another state");
    // rust: let mut snapshot = capture(&registry, &flags);
    // rust: snapshot.defaults[0].0 = 99;
    // rust: assert!(restore(snapshot).is_err(), "default string out of range");
    // rust: let mut snapshot = capture(&registry, &flags);
    // rust: snapshot.states[0].name = 99;
    // rust: assert!(restore(snapshot).is_err(), "name out of range");
    // rust: let mut snapshot = capture(&registry, &flags);
    // rust: snapshot.flags[0] = 4;
    // rust: assert!(restore(snapshot).is_err(), "unused flag bits");
}
}
