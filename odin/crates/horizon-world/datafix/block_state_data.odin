//! Transpiled from Horizon Rust crate
package horizon_world_block_state_data

import "core:fmt"
import "core:mem"
import "core:math"

// `BlockStateData`: the table that maps the 1.12 block states (`blockId << 4 | data`)
// to 1.13 block states, and the 1.12 `Name` + `Properties` tags to those ids.
// The table itself is `block_state_data.txt`, generated from vanilla's source by
// `tools/gen_block_state_data.py`.
//
// Vanilla keeps one tag object per `register` call (and per defaulted id) and
// `ChunkPalettedStorageFix` compares them by identity, so a state is an
// *instance* here: `register` calls make instances, ids without a call share
// the instance of the first call for their block.
// use std::collections::HashMap;
// use std::sync::OnceLock;

// use super::dynamic::{as_str, key, string};
// use crate::nbt::{Compound, Tag};

// A block state: name and properties sorted by key.
State :: struct {
    name: string,
    props: Vec<(string,
}

    // rust: impl State {
new :: proc(name: string, props: ^[(string) {
}
    // rust: let mut props: Vec<(String, String)> = props
    // rust: .iter()
    // rust: .map(|(k, v)| ((*k).to_owned(), (*v).to_owned()))
    // rust: .collect();
    // rust: props.sort();
    // rust: Self {
    // rust: name: name.to_owned(),
    // rust: props,
}
}
property :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.props
    // rust: .iter()
    // rust: .find(|(k, _)| k == name)
    // rust: .map_or("", |(_, v)| v)
}
    // The NBT tag: `{Name}` or `{Name, Properties}`.
to_tag :: proc(self: ^Self) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = Tag::compound([("Name", string(&self.name))]);
    // rust: if !self.props.is_empty() {
    // rust: let mut props = Compound::new();
    // rust: for (k, v) in &self.props {
    // rust: props.insert(key(k), string(v));
}
    // rust: super::dynamic::set(&mut tag, "Properties", Tag::Compound(props));
}
    // rust: tag
}
    // A tag read back as a state (`Name` and an optional `Properties` of strings only).
from_tag :: proc(tag: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Tag::Compound(c) = tag else {
    // rust: return None;
}
    // rust: let name = as_str(c.get(&key("Name")))?;
    // rust: let mut props = Vec::new();
    // rust: let mut expected = 1;
    // rust: if let Some(p) = c.get(&key("Properties")) {
    // rust: expected += 1;
    // rust: let Tag::Compound(p) = p else {
    // rust: return None;
}
    // rust: for (k, v) in p {
    // rust: props.push((k.to_string_lossy(), as_str(Some(v))?));
}
}
    // rust: if c.len() != expected {
    // rust: return None;
}
    // rust: props.sort();
    // rust: Some(Self { name, props })
}
}

Data :: struct {
    // One entry per `register` call.
    instances: [dynamic]State,
    // `MAP`: the instance of each id (after the defaulting of `finalizeMaps`).
    map: [dynamic]Maybe(u32),
    id_by_old: HashMap<State,
    id_by_old_name: HashMap<string,
}

parse_props :: proc(s: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if s.is_empty() {
    // rust: return Vec::new();
}
    // rust: s.split(';')
    // rust: .map(|kv| {
    // rust: let (k, v) = kv.split_once('=').unwrap_or((kv, ""));
    // rust: (k.to_owned(), v.to_owned())
    // rust: })
    // rust: .collect()
}

data :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
DATA :: OnceLock::new()
    // rust: DATA.get_or_init(|| {
    // rust: let mut map: Vec<Option<u32>> = vec![None; 4096];
    // rust: let mut defaults: Vec<Option<u32>> = vec![None; 256];
    // rust: let mut instances = Vec::new();
    // rust: let mut id_by_old = HashMap::new();
    // rust: let mut id_by_old_name: HashMap<String, i32> = HashMap::new();
    // rust: for line in include_str!("block_state_data.txt").lines() {
    // rust: if line.starts_with('#') || line.is_empty() {
    // rust: continue;
}
    // rust: let f: Vec<&str> = line.split('\t').collect();
    // rust: let id: usize = f[0].parse().expect("id");
    // rust: let instance = instances.len() as u32;
    // rust: instances.push(State {
    // rust: name: f[1].to_owned(),
    // rust: props: parse_props(f.get(2).copied().unwrap_or("")),
    // rust: });
    // rust: map[id] = Some(instance);
    // rust: if defaults[id >> 4].is_none() {
    // rust: defaults[id >> 4] = Some(instance);
}
    // rust: for pair in f[3..].chunks(2) {
    // rust: let old = State {
    // rust: name: pair[0].to_owned(),
    // rust: props: parse_props(pair.get(1).copied().unwrap_or("")),
}
    // rust: id_by_old_name.entry(old.name.clone()).or_insert(id as i32);
    // rust: id_by_old.insert(old, id as i32);
}
}
    // rust: for (i, slot) in map.iter_mut().enumerate() {
    // rust: if slot.is_none() {
    // rust: *slot = defaults[i >> 4];
}
}
    // rust: Data {
    // rust: instances,
    // rust: map,
    // rust: id_by_old,
    // rust: id_by_old_name,
}
    // rust: })
}

    // rust: impl Data {
    // `getTag(id)` as an instance.
instance :: proc(self: ^Self, id: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let slot = usize::try_from(id)
    // rust: .ok()
    // rust: .filter(|i| *i < 4096)
    // rust: .and_then(|i| self.map[i]);
    // rust: slot.or(self.map[0]).expect("air is registered")
}
state :: proc(self: ^Self, instance: u32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.instances[instance as usize]
}
}

// `BlockStateData.getTag`.
get_tag :: proc(id: i32) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let d = data();
    // rust: d.state(d.instance(id)).to_tag()
}

// `BlockStateData.upgradeBlockStateTag`.
upgrade_block_state_tag :: proc(old: ^Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let d = data();
    // rust: match State::from_tag(old).and_then(|s| d.id_by_old.get(&s).copied()) {
    // rust: Some(id) if (0..4096).contains(&id) => match d.map[id as usize] {
    // rust: Some(i) => d.state(i).to_tag(),
    // rust: None => old.clone(),
    // rust: },
    // rust: _ => old.clone(),
}
}

// `BlockStateData.upgradeBlock(String)`.
upgrade_block_name :: proc(old: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let d = data();
    // rust: match d.id_by_old_name.get(old) {
    // rust: Some(&id) if (0..4096).contains(&id) => match d.map[id as usize] {
    // rust: Some(i) => d.state(i).name.clone(),
    // rust: None => old.to_owned(),
    // rust: },
    // rust: _ => old.to_owned(),
}
}

// `BlockStateData.upgradeBlock(int)`.
upgrade_block_id :: proc(id: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let d = data();
    // rust: match usize::try_from(id).ok().filter(|i| *i < 4096) {
    // rust: Some(i) => match d.map[i] {
    // rust: Some(inst) => d.state(inst).name.clone(),
    // rust: None => "minecraft:air".to_owned(),
    // rust: },
    // rust: None => "minecraft:air".to_owned(),
}
}
