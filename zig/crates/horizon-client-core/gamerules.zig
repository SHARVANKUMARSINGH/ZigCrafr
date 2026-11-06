//! Transpiled from Horizon Rust crate
//! Module: horizon-client-core_gamerules
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Game rules (26.3 `GameRules`): the registered rules with their category,
//! type, default and bounds, a value map, and persistence in the world's
//! `data/minecraft/game_rules.dat` saved-data file.
// use horizon_world::{
    // rust: DATA_VERSION,
    // rust: compression::Compression,
    // rust: nbt::{self, Limits, NamedTag, Tag},
}
// use std::{collections::BTreeMap, fs, path::Path};

pub const Value = enum {
    Bool(bool),
    Int(i32),
};
    // rust: impl std::fmt::Display for Value {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Value::Bool(b) => write!(f, "{b}"),
    // rust: Value::Int(i) => write!(f, "{i}"),
}
}
}
pub const Rule = struct {
    name: *'static str,
    category: *'static str,
    default: Value,
    min: i32,
    max: i32,
};
    // rust: const fn b(name: &'static str, category: &'static str, default: bool) -> Rule {
    // rust: Rule {
    // rust: name,
    // rust: category,
    // rust: default: Value::Bool(default),
    // rust: min: 0,
    // rust: max: 0,
}
}
    // rust: const fn i(name: &'static str, category: &'static str, default: i32, min: i32, max: i32) -> Rule {
    // rust: Rule {
    // rust: name,
    // rust: category,
    // rust: default: Value::Int(default),
    // rust: min,
    // rust: max,
}
}
/// Every rule available without experimental features, in registration order.
    // rust: pub const RULES: &[Rule] = &[
    // rust: b("advance_time", "updates", true),
    // rust: b("advance_weather", "updates", true),
    // rust: b("allow_entering_nether_using_portals", "misc", true),
    // rust: b("block_drops", "drops", true),
    // rust: b("block_explosion_drop_decay", "drops", true),
    // rust: b("command_blocks_work", "misc", true),
    // rust: b("command_block_output", "chat", true),
    // rust: b("drowning_damage", "player", true),
    // rust: b("elytra_movement_check", "player", true),
    // rust: b("ender_pearls_vanish_on_death", "player", true),
    // rust: b("entity_drops", "drops", true),
    // rust: b("fall_damage", "player", true),
    // rust: b("fire_damage", "player", true),
    // rust: i(
    // rust: "fire_spread_radius_around_player",
    // rust: "updates",
    // rust: 128,
    // rust: -1,
    // rust: i32::MAX,
    // rust: ),
    // rust: b("forgive_dead_players", "mobs", true),
    // rust: b("freeze_damage", "player", true),
    // rust: b("global_sound_events", "misc", true),
    // rust: b("immediate_respawn", "player", false),
    // rust: b("keep_inventory", "player", false),
    // rust: b("lava_source_conversion", "updates", false),
    // rust: b("limited_crafting", "player", false),
    // rust: b("locator_bar", "player", true),
    // rust: b("log_admin_commands", "chat", true),
    // rust: i("max_block_modifications", "misc", 32768, 1, i32::MAX),
    // rust: i("max_command_forks", "misc", 65536, 0, i32::MAX),
    // rust: i("max_command_sequence_length", "misc", 65536, 0, i32::MAX),
    // rust: i("max_entity_cramming", "mobs", 24, 0, i32::MAX),
    // rust: i("max_snow_accumulation_height", "updates", 1, 0, 8),
    // rust: b("mob_drops", "drops", true),
    // rust: b("mob_explosion_drop_decay", "drops", true),
    // rust: b("mob_griefing", "mobs", true),
    // rust: b("natural_health_regeneration", "player", true),
    // rust: b("player_movement_check", "player", true),
    // rust: i(
    // rust: "players_nether_portal_creative_delay",
    // rust: "player",
    // rust: 0,
    // rust: 0,
    // rust: i32::MAX,
    // rust: ),
    // rust: i(
    // rust: "players_nether_portal_default_delay",
    // rust: "player",
    // rust: 80,
    // rust: 0,
    // rust: i32::MAX,
    // rust: ),
    // rust: i("players_sleeping_percentage", "player", 100, 0, i32::MAX),
    // rust: b("projectiles_can_break_blocks", "drops", true),
    // rust: b("pvp", "player", true),
    // rust: b("raids", "mobs", true),
    // rust: i("random_tick_speed", "updates", 3, 0, i32::MAX),
    // rust: b("reduced_debug_info", "misc", false),
    // rust: i("respawn_radius", "player", 10, 0, i32::MAX),
    // rust: b("send_command_feedback", "chat", true),
    // rust: b("show_advancement_messages", "chat", true),
    // rust: b("show_death_messages", "chat", true),
    // rust: b("spawner_blocks_work", "misc", true),
    // rust: b("spawn_mobs", "spawning", true),
    // rust: b("spawn_monsters", "spawning", true),
    // rust: b("spawn_patrols", "spawning", true),
    // rust: b("spawn_phantoms", "spawning", true),
    // rust: b("spawn_wandering_traders", "spawning", true),
    // rust: b("spawn_wardens", "spawning", true),
    // rust: b("spectators_generate_chunks", "player", true),
    // rust: b("spread_vines", "updates", true),
    // rust: b("tnt_explodes", "misc", true),
    // rust: b("tnt_explosion_drop_decay", "drops", false),
    // rust: b("universal_anger", "mobs", false),
    // rust: b("water_source_conversion", "updates", true),
    // rust: ];
/// GameRules.MAX_MINECART_SPEED (26.3), available with minecart improvements.
pub const MAX_MINECART_SPEED: Rule = i("max_minecart_speed", "misc", 8, 1, 1000);
pub const MINECART_IMPROVEMENTS: []const u8 = "minecraft:minecart_improvements";

pub fn available_rules(minecart_improvements: bool) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: RULES
    // rust: .iter()
    // rust: .chain(minecart_improvements.then_some(&MAX_MINECART_SPEED))
}

pub fn rule(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: available_rules(true).find(|r| r.name == name)
}

/// Current values (defaults unless set).
pub const GameRules = struct {
    values: BTreeMap<*'static str,
    minecart_improvements: bool,
};
    // rust: impl GameRules {
pub fn with_features(features: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: minecart_improvements: features.iter().any(|f| f == MINECART_IMPROVEMENTS),
    // rust: ..Self::default()
}
}
    /// GameRules.copy(enabledFeatures): keep available values, add defaults for
    /// newly enabled rules and discard rules absent from the target feature set.
pub fn copy_with_features(self: *Self, features: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut rules = Self::with_features(features);
    // rust: for (&name, &value) in &self.values {
    // rust: rules.set(name, value);
}
    // rust: rules
}
pub fn available_rules(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: available_rules(self.minecart_improvements)
}
pub fn get(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = rule(name)?;
    // rust: if r.name == MAX_MINECART_SPEED.name && !self.minecart_improvements {
    // rust: return None;
}
    // rust: Some(self.values.get(r.name).copied().unwrap_or(r.default))
}
pub fn bool(self: *Self, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.get(name), Some(Value::Bool(true)))
}
    /// Parse a network rule value, retaining type and range validation.
pub fn set_string(self: *Self, name: []const u8, text: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value = match self.get(name) {
    // rust: Some(Value::Bool(_)) => text.parse::<bool>().ok().map(Value::Bool),
    // rust: Some(Value::Int(_)) => text.parse::<i32>().ok().map(Value::Int),
    // rust: None => None,
}
    // rust: value.is_some_and(|v| self.set(name, v))
}
pub fn int(self: *Self, name: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.get(name) {
    // rust: Some(Value::Int(v)) => v,
    // rust: _ => 0,
}
}
    /// Set a rule; false if the name or value type is wrong.
pub fn set(self: *Self, name: []const u8, value: Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(r) = rule(name).filter(|r| self.get(r.name).is_some()) else {
    // rust: return false;
}
    // rust: let ok = match (r.default, value) {
    // rust: (Value::Bool(_), Value::Bool(_)) => true,
    // rust: (Value::Int(_), Value::Int(v)) => (r.min..=r.max).contains(&v),
    // rust: _ => false,
}
    // rust: if ok && value == r.default {
    // rust: self.values.remove(r.name);
    // rust: } else if ok {
    // rust: self.values.insert(r.name, value);
}
    // rust: ok
}
    /// Every rule's value by name without namespace, as `save::Level` holds
    /// them (booleans as 0 or 1).
pub fn by_name(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.available_rules()
    // rust: .map(|r| {
    // rust: let v = match self.values.get(r.name).copied().unwrap_or(r.default) {
    // rust: Value::Bool(b) => i32::from(b),
    // rust: Value::Int(i) => i,
}
    // rust: (r.name.to_owned(), v)
    // rust: })
    // rust: .collect()
}
    /// GameRuleMap codec: `{data: {"minecraft:<rule>": value...}, DataVersion}`.
pub fn to_nbt(self: *Self) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data: Vec<(horizon_world::nbt::JavaString, Tag)> = self
    // rust: .available_rules()
    // rust: .map(|r| {
    // rust: let v = self.values.get(r.name).copied().unwrap_or(r.default);
    // rust: let tag = match v {
    // rust: Value::Bool(b) => Tag::Byte(i8::from(b)),
    // rust: Value::Int(i) => Tag::Int(i),
}
    // rust: (
    // rust: horizon_world::nbt::JavaString::from(format!("minecraft:{}", r.name).as_str()),
    // rust: tag,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: NamedTag {
    // rust: name: "".into(),
    // rust: tag: Tag::compound([
    // rust: ("data", Tag::compound(data)),
    // rust: ("DataVersion", Tag::Int(DATA_VERSION)),
    // rust: ]),
}
}
pub fn from_nbt(root: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::from_nbt_with_features(root, &[])
}
pub fn from_nbt_with_features(root: *Tag, features: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut rules = Self::with_features(features);
    // rust: let Some(data) = root.get("data") else {
    // rust: return rules;
}
    // rust: for r in rules.available_rules() {
    // rust: let key = format!("minecraft:{}", r.name);
    // rust: let value = data.get(&key).or_else(|| data.get(r.name));
    // rust: match (r.default, value) {
    // rust: (Value::Bool(_), Some(Tag::Byte(v))) => {
    // rust: rules.set(r.name, Value::Bool(*v != 0));
}
    // rust: (Value::Int(_), Some(Tag::Int(v))) => {
    // rust: rules.set(r.name, Value::Int(*v));
}
    // rust: _ => {}
}
}
    // rust: rules
}
pub fn load(world: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::load_with_features(world, &[])
}
pub fn load_with_features(world: *Path, features: *[[]const u8]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Ok(bytes) = fs::read(world.join("data/minecraft/game_rules.dat")) else {
    // rust: return Self::with_features(features);
}
    // rust: let Ok(raw) = Compression::Gzip.decode(&bytes, 16 << 20) else {
    // rust: return Self::with_features(features);
}
    // rust: match nbt::read_named(&raw, Limits::default()) {
    // rust: Ok((root, _)) => Self::from_nbt_with_features(&root.tag, features),
    // rust: Err(_) => Self::with_features(features),
}
}
pub fn save(self: *Self, world: *Path) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = world.join("data/minecraft");
    // rust: fs::create_dir_all(&dir)?;
    // rust: let bytes =
    // rust: nbt::write_named(&self.to_nbt(), Limits::default()).map_err(|e| e.to_string())?;
    // rust: fs::write(
    // rust: dir.join("game_rules.dat"),
    // rust: Compression::Gzip.encode(&bytes)?,
    // rust: )?;
    // rust: Ok(())
}
}

    // rust: mod tests {
//     use super::*;

pub fn network_values_validate_rule_names_types_and_bounds() void {
}
    // rust: let mut rules = GameRules::default();
    // rust: assert!(rules.set_string("minecraft:keep_inventory", "true"));
    // rust: assert!(rules.bool("keep_inventory"));
    // rust: assert!(!rules.set_string("minecraft:keep_inventory", "1"));
    // rust: assert!(rules.bool("keep_inventory"));
    // rust: assert!(rules.set_string("minecraft:random_tick_speed", "7"));
    // rust: assert_eq!(rules.int("random_tick_speed"), 7);
    // rust: assert!(!rules.set_string("minecraft:random_tick_speed", "-1"));
    // rust: assert!(!rules.set_string("minecraft:random_tick_speed", "999999999999"));
    // rust: assert!(!rules.set_string("minecraft:unknown", "true"));
    // rust: assert!(!rules.set_string("other:keep_inventory", "false"));
    // rust: assert_eq!(rules.int("random_tick_speed"), 7);
}
pub fn defaults_bounds_and_round_trip() void {
}
    // rust: let mut rules = GameRules::default();
    // rust: assert!(rules.bool("advance_time"));
    // rust: assert_eq!(rules.int("random_tick_speed"), 3);
    // rust: assert!(!rules.set("random_tick_speed", Value::Bool(true)));
    // rust: assert!(!rules.set("max_snow_accumulation_height", Value::Int(9)));
    // rust: assert!(rules.set("keep_inventory", Value::Bool(true)));
    // rust: assert!(rules.set("minecraft:random_tick_speed", Value::Int(10)));
    // rust: let back = GameRules::from_nbt(&rules.to_nbt().tag);
    // rust: assert_eq!(back, rules);
    // rust: assert!(back.bool("keep_inventory"));
    // rust: let dir = std::env::temp_dir().join(format!("horizon-gamerules-{}", std::process::id()));
    // rust: rules.save(&dir).unwrap();
    // rust: assert_eq!(GameRules::load(&dir), rules);
    // rust: let _ = fs::remove_dir_all(dir);
}
}
