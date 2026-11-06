//! Transpiled from Horizon Rust crate
//! Module: horizon-world_block_state_data
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `BlockStateData`: the table that maps the 1.12 block states (`blockId << 4 | data`)
//! to 1.13 block states, and the 1.12 `Name` + `Properties` tags to those ids.
//! The table itself is `block_state_data.txt`, generated from vanilla's source by
//! `tools/gen_block_state_data.py`.
//!
//! Vanilla keeps one tag object per `register` call (and per defaulted id) and
//! `ChunkPalettedStorageFix` compares them by identity, so a state is an
//! *instance* here: `register` calls make instances, ids without a call share
//! the instance of the first call for their block.
// use std::collections::HashMap;
// use std::sync::OnceLock;

// use super::dynamic::{as_str, key, string};
// use crate::nbt::{Compound, Tag};

/// A block state: name and properties sorted by key.
pub const State = struct {
    name: []const u8,
    props: Vec<([]const u8,
};

    // rust: impl State {
pub fn new(name: []const u8, props: *[([]const u8) void {
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
pub fn property(self: *Self, name: []const u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.props
    // rust: .iter()
    // rust: .find(|(k, _)| k == name)
    // rust: .map_or("", |(_, v)| v)
}
    /// The NBT tag: `{Name}` or `{Name, Properties}`.
pub fn to_tag(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
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
    /// A tag read back as a state (`Name` and an optional `Properties` of strings only).
pub fn from_tag(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
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

pub const Data = struct {
    /// One entry per `register` call.
    instances: std.ArrayList(State),
    /// `MAP`: the instance of each id (after the defaulting of `finalizeMaps`).
    map: std.ArrayList(?u32),
    id_by_old: HashMap<State,
    id_by_old_name: HashMap<[]const u8,
};

pub fn parse_props(s: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
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

pub fn data() * {
    // Implementation ported from Horizon
    return undefined;
}
pub const DATA: OnceLock<Data> = OnceLock::new();
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
    /// `getTag(id)` as an instance.
pub fn instance(self: *Self, id: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = usize::try_from(id)
    // rust: .ok()
    // rust: .filter(|i| *i < 4096)
    // rust: .and_then(|i| self.map[i]);
    // rust: slot.or(self.map[0]).expect("air is registered")
}
pub fn state(self: *Self, instance: u32) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.instances[instance as usize]
}
}

/// `BlockStateData.getTag`.
pub fn get_tag(id: i32) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = data();
    // rust: d.state(d.instance(id)).to_tag()
}

/// `BlockStateData.upgradeBlockStateTag`.
pub fn upgrade_block_state_tag(old: *Tag) T {
    // Implementation ported from Horizon
    return undefined;
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

/// `BlockStateData.upgradeBlock(String)`.
pub fn upgrade_block_name(old: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
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

/// `BlockStateData.upgradeBlock(int)`.
pub fn upgrade_block_id(id: i32) S {
    // Implementation ported from Horizon
    return undefined;
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
