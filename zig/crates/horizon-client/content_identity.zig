//! Transpiled from Horizon Rust crate
//! Module: horizon-client_content_identity
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Identity of the ordered block-state registry used by chunk packets, and of
//! the item, mob effect, entity type and menu registries once content mods
//! add to them (item stacks, effect, entity and open screen packets carry
//! their network ids).
// use horizon_protocol::registry::Builtin;
// use serde::{Deserialize, Serialize, de::IgnoredAny};
// use sha2::{Digest, Sha256};
// use std::{
    // rust: collections::{BTreeMap, HashMap},
    // rust: fmt, io,
    // rust: path::{Path, PathBuf},
    // rust: sync::{Mutex, OnceLock},
}

pub const CHANNEL: []const u8 = "horizon:block_registry";
pub const MARKER: []const u8 = "horizon-content-blocks";
    // rust: pub const MISMATCH: &str =
    // rust: "Content registry mismatch: install the same content mods as the server.";

pub const IdentityError = enum {
    Read(io::Error),
    Json(serde_json::Error),
    Registries(String),
};

    // rust: impl fmt::Display for IdentityError {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Read(error) => write!(f, "cannot read facts.json: {error}"),
    // rust: Self::Json(error) => write!(f, "invalid facts.json: {error}"),
    // rust: Self::Registries(error) => write!(f, "invalid registries.json: {error}"),
}
}
}

    // rust: impl std::error::Error for IdentityError {}

pub const Facts = struct {
    states: std.ArrayList(StateRow),
};

pub const StateRow = struct {};

pub const State = struct {
    id: []const u8,
    properties: Option<BTreeMap<[]const u8,
};

/// Hash the network order and each state's name and properties, not its gameplay facts.
pub fn identity(root: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // Keep each resource root stable and avoid reparsing its large facts file for every join.
pub const IDENTITIES: OnceLock<Mutex<std.AutoHashMap(PathBuf, [u8; 32])>> = OnceLock::new();
    // rust: let mut identities = IDENTITIES.get_or_init(Default::default).lock().unwrap();
    // rust: if let Some(hash) = identities.get(root) {
    // rust: return Ok(*hash);
}
    // rust: let bytes = std::fs::read(root.join("facts.json")).map_err(IdentityError::Read)?;
    // rust: let mut hash = hash_facts(&bytes)?;
    // A root without mod entries keeps its block-only identity.
    // rust: if let Ok(registries) = std::fs::read(root.join("registries.json")) {
    // rust: let report = parse_registries(&registries)?;
    // rust: for registry in REGISTRIES {
    // rust: let entries = mod_entries(&report, registry);
    // rust: if !entries.is_empty() {
    // rust: hash = hash_entries(hash, registry, &entries);
}
}
}
    // rust: let components: Vec<_> = horizon_protocol::item::custom::entries()
    // rust: .map(|(id, name)| (id as u64, name.to_owned()))
    // rust: .collect();
    // rust: if !components.is_empty() {
    // rust: hash = hash_entries(hash, "horizon:nbt_components/v1", &components);
        // Defaults are not sent in a stack patch. Both peers must therefore
        // agree on their values as well as the registered wire IDs, native
        // mods' changes included.
    // rust: let items = horizon_world::item_defaults::read(root).map_err(IdentityError::Read)?;
    // rust: let mut defaults = Vec::new();
    // rust: for (item, components) in items {
    // rust: for (name, value) in components.as_object().into_iter().flatten() {
    // rust: if horizon_protocol::item::custom::id(name).is_some() {
    // rust: defaults.push((defaults.len() as u64, format!("{item}\0{name}\0{value}")));
}
}
}
    // rust: if !defaults.is_empty() {
    // rust: hash = hash_entries(hash, "horizon:nbt_component_defaults/v1", &defaults);
}
}
    // rust: identities.insert(root.to_owned(), hash);
    // rust: Ok(hash)
}

pub fn hash_facts(bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let facts: Facts = serde_json::from_slice(bytes).map_err(IdentityError::Json)?;
    // rust: let mut hash = Sha256::new();
    // rust: for row in facts.states {
    // rust: let encoded = serde_json::to_vec(&row.4).map_err(IdentityError::Json)?;
    // rust: hash.update((encoded.len() as u64).to_le_bytes());
    // rust: hash.update(encoded);
}
    // rust: Ok(hash.finalize().into())
}

/// The built-in registries whose network ids content mods extend besides blocks.
    // rust: const REGISTRIES: [&str; 4] = [
    // rust: "minecraft:item",
    // rust: "minecraft:mob_effect",
    // rust: "minecraft:entity_type",
    // rust: "minecraft:menu",
    // rust: ];

pub fn parse_registries(bytes: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = std::str::from_utf8(bytes).map_err(|e| IdentityError::Registries(e.to_string()))?;
    // rust: Builtin::parse(text).map_err(|e| IdentityError::Registries(e.to_string()))
}

/// The content mods' entries of `registry` in `registries.json`, by network id.
pub fn mod_entries(report: *Builtin, registry: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // Names come indexed by network id, so they are already in order.
    // rust: report
    // rust: .get(registry)
    // rust: .into_iter()
    // rust: .flat_map(|ids| ids.names.iter().enumerate())
    // rust: .filter(|(_, name)| !name.is_empty() && !name.starts_with("minecraft:"))
    // rust: .map(|(id, name)| (id as u64, name.clone()))
    // rust: .collect()
}

/// The identity so far extended with the mods' entries of one registry.
pub fn hash_entries(previous: [u8; 32], registry: []const u8, entries: *[(u64) void {
}
    // rust: let mut hash = Sha256::new();
    // rust: hash.update(previous);
    // rust: hash.update((registry.len() as u64).to_le_bytes());
    // rust: hash.update(registry);
    // rust: for (id, name) in entries {
    // rust: hash.update(id.to_le_bytes());
    // rust: hash.update((name.len() as u64).to_le_bytes());
    // rust: hash.update(name);
}
    // rust: hash.finalize().into()
}

    // rust: mod tests {
//     use super::{hash_entries, hash_facts, identity, mod_entries, parse_registries};

pub fn mod_items_and_effects_join_the_identity() void {
}
pub const EFFECT: []const u8 = "minecraft:mob_effect";
pub const ITEM: []const u8 = "minecraft:item";
    // rust: let entries = |extra: &str, registry: &str| {
    // rust: let report = format!(
    // rust: r#"{{"minecraft:mob_effect":{{"entries":{{"minecraft:speed":{{"protocol_id":0}}{extra}}}}},
    // rust: "minecraft:item":{{"entries":{{"minecraft:air":{{"protocol_id":0}},"ruby:ruby":{{"protocol_id":1}}}}}}}}"#
    // rust: );
    // rust: mod_entries(&parse_registries(report.as_bytes()).unwrap(), registry)
}
    // rust: assert!(entries("", EFFECT).is_empty());
    // rust: let ruby = entries("", ITEM);
    // rust: assert_eq!(ruby, [(1, "ruby:ruby".to_owned())]);
    // rust: let glow = entries(r#","ruby:glow":{"protocol_id":40}"#, EFFECT);
    // rust: assert_eq!(glow, [(40, "ruby:glow".to_owned())]);
    // rust: let zap = entries(r#","ruby:zap":{"protocol_id":40}"#, EFFECT);
    // rust: let blocks = [7; 32];
    // rust: assert_ne!(
    // rust: hash_entries(blocks, EFFECT, &glow),
    // rust: hash_entries(blocks, EFFECT, &zap)
    // rust: );
    // rust: assert_ne!(hash_entries(blocks, EFFECT, &glow), blocks);
    // rust: assert_ne!(hash_entries(blocks, ITEM, &ruby), blocks);
        // the same id and name in another registry is other content.
    // rust: assert_ne!(
    // rust: hash_entries(blocks, ITEM, &glow),
    // rust: hash_entries(blocks, EFFECT, &glow)
    // rust: );
}

    /// a mod menu type in the report changes the identity, so a client
    /// without it is refused before it could be sent an id it lacks.
pub fn a_mod_menu_type_joins_the_identity() void {
}
    // rust: let root = |name: &str, extra: &str| {
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-content-identity-menu-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: let facts = br#"{"states":[["minecraft:stone",false,false,"Block{minecraft:stone}",{"id":"minecraft:stone"}]]}"#;
    // rust: std::fs::write(root.join("facts.json"), facts).unwrap();
    // rust: let report = format!(
    // rust: r#"{{"minecraft:menu":{{"entries":{{"minecraft:generic_9x1":{{"protocol_id":0}}{extra}}}}}}}"#
    // rust: );
    // rust: std::fs::write(root.join("registries.json"), report).unwrap();
    // rust: let hash = identity(&root).unwrap();
    // rust: std::fs::remove_dir_all(&root).unwrap();
    // rust: hash
}
    // rust: let vanilla = root("vanilla", "");
    // rust: let press = root("press", r#","ruby:press":{"protocol_id":25}"#);
    // rust: assert_ne!(press, vanilla);
    // rust: assert_ne!(press, root("mill", r#","ruby:mill":{"protocol_id":25}"#));
}

pub fn a_root_without_mod_entries_keeps_its_block_identity() void {
}
    // rust: let root = std::env::temp_dir().join(format!(
    // rust: "horizon-content-identity-vanilla-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: let facts = br#"{"states":[["minecraft:stone",false,false,"Block{minecraft:stone}",{"id":"minecraft:stone"}]]}"#;
    // rust: std::fs::write(root.join("facts.json"), facts).unwrap();
    // rust: std::fs::write(
    // rust: root.join("registries.json"),
    // rust: br#"{"minecraft:item":{"entries":{"minecraft:air":{"protocol_id":0}}},
    // rust: "minecraft:mob_effect":{"entries":{"minecraft:speed":{"protocol_id":0}}}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(identity(&root).unwrap(), hash_facts(facts).unwrap());
    // rust: std::fs::remove_dir_all(&root).unwrap();
}

pub fn identity_tracks_order_and_properties_not_gameplay_data() void {
}
    // rust: let facts = |a: &str, b: &str| {
    // rust: format!(r#"{{"states":[["x",false,false,"x",{a}],["y",false,false,"y",{b}]]}}"#)
}
    // rust: let a = r#"{"id":"demo:a","properties":{"facing":"north"}}"#;
    // rust: let b = r#"{"id":"demo:b"}"#;
    // rust: let first = hash_facts(facts(a, b).as_bytes()).unwrap();
    // rust: assert_eq!(first, hash_facts(facts(a, b).as_bytes()).unwrap());
    // rust: assert_ne!(first, hash_facts(facts(b, a).as_bytes()).unwrap());
    // rust: assert_ne!(first, hash_facts(facts(a, a).as_bytes()).unwrap());
    // rust: assert_ne!(
    // rust: first,
    // rust: hash_facts(facts(&a.replace("north", "south"), b).as_bytes()).unwrap()
    // rust: );
    // rust: assert_ne!(
    // rust: first,
    // rust: hash_facts(format!(r#"{{"states":[["x",false,false,"x",{a}]]}}"#).as_bytes()).unwrap()
    // rust: );
    // rust: assert!(hash_facts(br#"{"states":[["x",false,false,"x","minecraft:stone"]]}"#).is_err());
    // rust: assert!(hash_facts(br#"{"states":[[]]}"#).is_err());
    // rust: assert!(hash_facts(br#"{"states":[["x",false,false,"x",{"id":"x"},0]]}"#).is_err());
}
}
