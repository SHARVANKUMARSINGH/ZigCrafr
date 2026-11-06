//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_processors
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Structure processors the structure libraries write in Java, carried over
//! as data the game runs: the ones that give spawners their mob.
//!
//! - Moog's Structure Lib's and Repurposed Structures' spawner randomizing
//!   processors pick a mob from a weighted list for each spawner. They become
//!   `horizon:spawner_mobs` (`horizon_world::worldgen::structure::processor`),
//!   with Repurposed's `rs_spawners` list written in.
//! - Moog's vanilla loot swap only acts when its mod's "replace vanilla"
//!   preset is on; one that ships off is a no-op and is taken out.
//! - Repurposed Structures' mineshaft sky view becomes the game's
//!   `horizon:mineshaft_sky_view`.
//!
//! Lithostitched's processors and Choice Theorem's Overhauled Village's
//! compat hook are carried by `crate::lithostitched`, called from [`carry`].
//!
//! What is not here is taken out of its list later and counted
//! (`worldgen::upgrade`). The entity NBT is written in 26.3's shape (an
//! `equipment` map, not 1.21.1's `HandItems` and `ArmorItems`).
// use crate::lithostitched;
// use serde_json::{Value, json};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: io::{Read, Seek},
}

/// What the processors read from the mod's own data files.
pub const ProcessorData = struct {
    /// Repurposed Structures' `rs_spawners/<path>.json` by id: each mob and
    /// its weight, without the weight-0 entries its loader removes.
    spawners: BTreeMap<[]const u8,
    /// Moog's "replace vanilla" presets that are on by default:
    /// `(mod id, vanilla_key)`.
    replace_vanilla: BTreeSet<([]const u8,
    /// The mod's processor lists by id, for Lithostitched's references.
    lists: BTreeMap<[]const u8,
    /// The mods named by its `ctov:modular_compat` processors that are
    /// ported along ([`Self::mark_loaded`]).
    compat_loaded: BTreeSet<[]const u8>,
};

    // rust: impl ProcessorData {
    /// Notes which mods its compat processors name are `loaded`.
pub fn mark_loaded(self: *Self, loaded: *dyn Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lithostitched::mark_loaded(self, loaded);
}

    // rust: pub fn read<R: Read + Seek>(zip: &mut zip::ZipArchive<R>) -> Self {
    // rust: let mut out = Self::default();
    // rust: for i in 0..zip.len() {
    // rust: let Ok(mut entry) = zip.by_index(i) else {
    // rust: continue;
}
    // rust: let Ok(name) = entry.name().map(|n| n.into_owned()) else {
    // rust: continue;
}
    // rust: let Some((ns, rest)) = name
    // rust: .strip_prefix("data/")
    // rust: .and_then(|r| r.strip_suffix(".json"))
    // rust: .and_then(|r| r.split_once('/'))
    // rust: else {
    // rust: continue;
}
    // rust: let spawners = rest.strip_prefix("rs_spawners/");
    // rust: let list = rest.strip_prefix("worldgen/processor_list/");
    // rust: if spawners.is_none() && list.is_none() && rest != "moogs_structures/replace_vanilla" {
    // rust: continue;
}
    // rust: let mut text = String::new();
    // rust: let Ok(v) = entry
    // rust: .read_to_string(&mut text)
    // rust: .map_err(|_| ())
    // rust: .and_then(|_| serde_json::from_str::<Value>(&text).map_err(|_| ()))
    // rust: else {
    // rust: continue;
}
    // rust: if let Some(path) = list {
    // rust: out.lists.insert(format!("{ns}:{path}"), v);
    // rust: continue;
}
    // rust: if let Some(path) = spawners {
    // rust: let mobs = v["mobs"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|m| Some((m["name"].as_str()?.to_owned(), m["weight"].as_f64()?)))
    // rust: .filter(|(_, w)| *w != 0.)
    // rust: .collect();
    // rust: out.spawners.insert(format!("{ns}:{path}"), mobs);
    // rust: continue;
}
    // rust: for preset in v["presets"].as_array().into_iter().flatten() {
    // rust: if preset["default_enabled"].as_bool() != Some(true) {
    // rust: continue;
}
    // rust: for r in preset["replacements"].as_array().into_iter().flatten() {
    // rust: if let Some(key) = r["vanilla_key"].as_str() {
    // rust: out.replace_vanilla.insert((ns.to_owned(), key.to_owned()));
}
}
}
}
    // rust: out
}
}

/// Calls `f` on each processor list in a worldgen file: a `processor_list`
/// file, and the inline lists of a template pool's elements (list elements
/// included). Whether any call changed something.
pub fn each_list(kind: []const u8, v: *mut Value, f: *mut dyn FnMut(*mut Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: "processor_list" => f(v),
    // rust: "template_pool" => {
    // rust: let mut changed = false;
    // rust: for e in v["elements"].as_array_mut().into_iter().flatten() {
    // rust: let element = &mut e["element"];
    // rust: if let Some(list) = element.get_mut("elements").and_then(Value::as_array_mut) {
    // rust: for inner in list {
    // rust: if let Some(p) = inner.get_mut("processors") {
    // rust: changed |= f(p);
}
}
    // rust: } else if let Some(p) = element.get_mut("processors") {
    // rust: changed |= f(p);
}
}
    // rust: changed
}
    // rust: _ => false,
}
}

/// The processors of a list: `{"processors": [...]}` or a bare list (an id
/// names another file and is left alone).
pub fn processors(list: *mut Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match list {
    // rust: Value::Array(a) => Some(a),
    // rust: Value::Object(o) => o.get_mut("processors").and_then(Value::as_array_mut),
    // rust: _ => None,
}
}

/// Rewrites the processors of a worldgen file that have a data form; each is
/// counted by type in `carried`. Whether anything changed.
    // rust: pub fn carry(
    // rust: kind: &str,
    // rust: v: &mut Value,
    // rust: data: &ProcessorData,
    // rust: carried: &mut BTreeMap<String, usize>,
    // rust: ) -> bool {
    // rust: each_list(kind, v, &mut |list| {
    // rust: let Some(list) = processors(list) else {
    // rust: return false;
}
    // rust: let (out, changed) = carry_all(std::mem::take(list), data, carried);
    // rust: *list = out;
    // rust: changed
    // rust: })
}

/// The processors of one list carried: references written in, then each
/// one with a data form replaced by it. Whether anything changed.
    // rust: pub(crate) fn carry_all(
    // rust: list: Vec<Value>,
    // rust: data: &ProcessorData,
    // rust: carried: &mut BTreeMap<String, usize>,
    // rust: ) -> (Vec<Value>, bool) {
    // rust: carry_at(list, data, carried, 0)
}

/// [`carry_all`] for a list `depth` pillars deep (see [`pillar`]).
    // rust: fn carry_at(
    // rust: list: Vec<Value>,
    // rust: data: &ProcessorData,
    // rust: carried: &mut BTreeMap<String, usize>,
    // rust: depth: usize,
    // rust: ) -> (Vec<Value>, bool) {
    // rust: let (expanded, mut changed) = lithostitched::expand_references(list, data, carried);
    // rust: let mut out = Vec::with_capacity(expanded.len());
    // rust: for p in expanded {
    // rust: let kind = p["processor_type"].as_str().unwrap_or_default().to_owned();
        // Lithostitched's processors stay theirs, with what they hold carried.
    // rust: let replacement = lithostitched::processor(&kind, &p, data, carried).or_else(|| {
    // rust: match pillar_type(&kind) {
    // rust: Some(to) => Some(vec![pillar(&p, to, data, carried, depth)]),
    // rust: None => as_data(&kind, &p, data),
}
    // rust: });
    // rust: match replacement {
    // rust: Some(replacement) => {
    // rust: *carried.entry(kind).or_default() += 1;
    // rust: out.extend(replacement);
    // rust: changed = true;
}
    // rust: None => out.push(p),
}
}
    // rust: (out, changed)
}

/// The game's type for the mods' processors that place blocks past their
/// template, which keep their fields (`horizon-world`'s `pillars.rs`).
pub fn pillar_type(kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match kind {
    // rust: "repurposed_structures:pillar_processor" | "moogs_structures:pillar_processor" => {
    // rust: "horizon:pillar"
}
    // rust: "repurposed_structures:bottom_pillar_processor" => "horizon:bottom_pillar",
    // rust: "repurposed_structures:close_off_fluid_sources_processor"
    // rust: | "moogs_structures:close_off_fluid_sources_processor" => "horizon:close_off_fluid_sources",
    // rust: "repurposed_structures:close_off_air_sources_processor" => "horizon:close_off_air_sources",
    // rust: _ => return None,
    // rust: })
}

/// A pillar processor as the game's `to`. Its `pillar_processor_list`
/// (which runs on each block of the column; Repurposed's often names the
/// list it is in) is written in, carried; the pillars inside that copy lose
/// theirs, as a column's blocks are never the mods' triggers.
    // rust: fn pillar(
    // rust: p: &Value,
    // rust: to: &str,
    // rust: data: &ProcessorData,
    // rust: carried: &mut BTreeMap<String, usize>,
    // rust: depth: usize,
    // rust: ) -> Value {
    // rust: let mut out = p.clone();
    // rust: out["processor_type"] = to.into();
    // rust: let Some(o) = out.as_object_mut() else {
    // rust: return out;
}
    // rust: let Some(list) = o.remove("pillar_processor_list") else {
    // rust: return out;
}
    // rust: let inner = match &list {
    // rust: Value::String(id) if id == "minecraft:empty" => None,
    // rust: _ if depth > 0 => None,
    // rust: other => referenced(other, data),
}
    // rust: if let Some(inner) = inner {
    // rust: let (inner, _) = carry_at(inner, data, carried, depth + 1);
    // rust: o.insert("pillar_processor_list".into(), json!({"processors": inner}));
}
    // rust: out
}

/// Repurposed Structures' rule tests and the game's types that run them
/// (`horizon_world::worldgen`'s `rule_test` and `structure::processor`).
    // rust: const RULE_TESTS: [(&str, &str); 3] = [
    // rust: (
    // rust: "repurposed_structures:matter_phase_rule_test",
    // rust: "horizon:matter_phase",
    // rust: ),
    // rust: (
    // rust: "repurposed_structures:piece_origin_axis_aligned_linear_pos_rule_test",
    // rust: "horizon:piece_origin_axis_aligned_linear_pos",
    // rust: ),
    // rust: (
    // rust: "repurposed_structures:y_value_pos_rule_test",
    // rust: "horizon:y_value",
    // rust: ),
    // rust: ];

/// Renames the rule tests written in Java that the game runs under its own
/// type ([`RULE_TESTS`]) in a worldgen file's processor lists; each is
/// counted by type in `carried`. Their fields are the mod's. Whether
/// anything changed. Without this the game, like vanilla, refuses the list
/// and every pool naming it: Repurposed's mineshafts and Nether monument.
pub fn rule_tests(kind: []const u8, v: *mut Value, carried: *mut BTreeMap<[]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
pub fn rename(v: *mut Value, carried: *mut BTreeMap<[]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match v {
    // rust: Value::Object(o) => {
    // rust: let mut changed = false;
    // rust: if let Some(Value::String(t)) = o.get_mut("predicate_type")
    // rust: && let Some((old, new)) = RULE_TESTS.iter().find(|(old, _)| t == old)
    // rust: {
    // rust: *carried.entry((*old).to_owned()).or_default() += 1;
    // rust: *t = (*new).to_owned();
    // rust: changed = true;
}
    // rust: o.values_mut().fold(changed, |c, x| rename(x, carried) | c)
}
    // rust: Value::Array(a) => a.iter_mut().fold(false, |c, x| rename(x, carried) | c),
    // rust: _ => false,
}
}
    // rust: each_list(kind, v, &mut |list| rename(list, carried))
}

/// The processors of the lists a reference names: an id, an inline list, or
/// a list of either.
    // rust: pub(crate) fn referenced(lists: &Value, data: &ProcessorData) -> Option<Vec<Value>> {
    // rust: let one = |l: &Value| -> Option<Vec<Value>> {
    // rust: let mut list = match l {
    // rust: Value::String(id) if !id.starts_with('#') => {
    // rust: let id = if id.contains(':') {
    // rust: id.clone()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: data.lists.get(&id)?.clone()
}
    // rust: Value::Object(_) | Value::Array(_) => l.clone(),
    // rust: _ => return None,
}
    // rust: processors(&mut list).map(std::mem::take)
}
    // rust: match lists {
        // A bare list of processors is one inline list; else a list of lists.
    // rust: Value::Array(a) if a.iter().any(|x| x.get("processor_type").is_some()) => Some(a.clone()),
    // rust: Value::Array(a) => Some(a.iter().map(one).collect::<Option<Vec<_>>>()?.concat()),
    // rust: other => one(other),
}
}

/// The data form of a Java processor: the processors to put in its place
/// (none for a no-op), or `None` when it has none.
pub fn as_data(kind: []const u8, p: *Value, data: *ProcessorData) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: kind.split_once(':')?;
    // rust: Some(match kind {
        // Its structure voids keep the world's block, as vanilla's
        // block_ignore does (the templates hold them; vanilla places them).
    // rust: "repurposed_structures:structure_void_processor" => vec![json!({
    // rust: "processor_type": "minecraft:block_ignore",
    // rust: "blocks": ["minecraft:structure_void"]})],
    // rust: "moogs_structures:spawner_randomizing_processor" => {
    // rust: let mobs = p["weighted_entities"]
    // rust: .as_array()?
    // rust: .iter()
    // rust: .map(|e| {
                    // The entry's NBT, then its id over it.
    // rust: let mut entity = match &e["nbt"] {
    // rust: Value::Object(o) => o.clone(),
    // rust: _ => serde_json::Map::new(),
}
    // rust: entity.insert("id".into(), e["entity"].as_str()?.into());
    // rust: Some(json!({"entity": entity, "weight": e["weight"].as_f64()?}))
    // rust: })
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: vec![spawner_mobs(p, mobs, None)]
}
    // rust: "repurposed_structures:spawner_randomizing_processor" => {
            // A list the mod does not ship falls back to a vanilla dungeon
            // mob in the mod; left out here.
    // rust: let list = data
    // rust: .spawners
    // rust: .get(p["rs_spawner_resourcelocation"].as_str()?)?;
    // rust: let mobs = list
    // rust: .iter()
    // rust: .map(|(id, weight)| json!({"entity": {"id": id}, "weight": weight}))
    // rust: .collect();
    // rust: vec![spawner_mobs(p, mobs, repurposed_light(p)?)]
}
        // Wet where the world holds water, dry where it does not.
    // rust: "repurposed_structures:waterlogging_when_replacing_water_processor" => {
    // rust: vec![json!({"processor_type": "horizon:waterlog_in_world_water"})]
}
        // Its mineshafts: nothing above the ocean floor but grounded rails.
    // rust: "repurposed_structures:mineshaft_sky_view_processor" => {
    // rust: vec![json!({"processor_type": "horizon:mineshaft_sky_view"})]
}
    // rust: "moogs_structures:vanilla_loot_swap_processor" => {
    // rust: let key = (
    // rust: p["modid"].as_str()?.to_owned(),
    // rust: p["vanilla_key"].as_str()?.to_owned(),
    // rust: );
    // rust: if data.replace_vanilla.contains(&key) {
    // rust: return None;
}
    // rust: Vec::new()
}
    // rust: "moogs_structures:trial_spawner_randomizing_processor" => {
            // The configs by id: 26.3 reads them from `trial_spawner/`, the
            // folder Moog's loads them from.
    // rust: let mut nbt = json!({"normal_config": p["normal_config"].as_str()?});
    // rust: if let Some(ominous) = p["ominous_config"].as_str() {
    // rust: nbt["ominous_config"] = ominous.into();
}
            // The state the template was saved with goes.
    // rust: let saved = [
    // rust: "server_data",
    // rust: "shared_data",
    // rust: "spawn_data",
    // rust: "cooldown_end_at_tick",
    // rust: "next_mob_spawns_at",
    // rust: ];
    // rust: vec![same_state_rule(&TRIAL_SPAWNER_STATES, &saved, |_| {
    // rust: nbt.clone()
    // rust: })]
}
    // rust: "moogs_structures:vault_randomizing_processor" => {
    // rust: let normal = p["loot_table"].as_str()?;
    // rust: let config = |ominous: bool| {
    // rust: let (table, key) = match ominous {
    // rust: true => (
    // rust: p["ominous_loot_table"].as_str().unwrap_or(normal),
    // rust: p["ominous_key_item"]
    // rust: .as_str()
    // rust: .unwrap_or("minecraft:ominous_trial_key"),
    // rust: ),
    // rust: false => (
    // rust: normal,
    // rust: p["key_item"].as_str().unwrap_or("minecraft:trial_key"),
    // rust: ),
}
                // Merged into the vault's config, as the mod puts both in.
    // rust: json!({"config": {"loot_table": table, "key_item": {"id": key, "count": 1}}})
}
    // rust: vec![same_state_rule(
    // rust: &VAULT_STATES,
    // rust: &["server_data", "shared_data"],
    // rust: |s| config(s.get("ominous") == Some(&"true")),
    // rust: )]
}
    // rust: _ => return None,
    // rust: })
}

/// A block's states, as (block, [(property, values)]).
    // rust: type States = (
    // rust: &'static str,
    // rust: &'static [(&'static str, &'static [&'static str])],
    // rust: );
    // rust: const TRIAL_SPAWNER_STATES: States = (
    // rust: "minecraft:trial_spawner",
    // rust: &[
    // rust: (
    // rust: "trial_spawner_state",
    // rust: &[
    // rust: "inactive",
    // rust: "waiting_for_players",
    // rust: "active",
    // rust: "waiting_for_reward_ejection",
    // rust: "ejecting_reward",
    // rust: "cooldown",
    // rust: ],
    // rust: ),
    // rust: ("ominous", &["false", "true"]),
    // rust: ],
    // rust: );
    // rust: const VAULT_STATES: States = (
    // rust: "minecraft:vault",
    // rust: &[
    // rust: ("facing", &["north", "south", "west", "east"]),
    // rust: (
    // rust: "vault_state",
    // rust: &["inactive", "active", "unlocking", "ejecting"],
    // rust: ),
    // rust: ("ominous", &["false", "true"]),
    // rust: ],
    // rust: );

/// Moog's trial spawner and vault processors keep the block, take keys out
/// of its block entity and set others. As vanilla's `rule`: one rule per
/// state of the block, matching it and writing it back, with the game's
/// `horizon:edit` modifier taking out `remove` and merging `nbt(state)` in.
    // rust: fn same_state_rule(
    // rust: states: &States,
    // rust: remove: &[&str],
    // rust: nbt: impl Fn(&BTreeMap<&str, &str>) -> Value,
    // rust: ) -> Value {
    // rust: let (block, properties) = states;
    // rust: let mut all = vec![BTreeMap::new()];
    // rust: for (key, values) in properties.iter() {
    // rust: all = all
    // rust: .into_iter()
    // rust: .flat_map(|s| {
    // rust: values.iter().map(move |v| {
    // rust: let mut s = s.clone();
    // rust: s.insert(*key, *v);
    // rust: s
    // rust: })
    // rust: })
    // rust: .collect();
}
    // rust: let rules: Vec<Value> = all
    // rust: .iter()
    // rust: .map(|s| {
    // rust: let state = json!({"id": block, "properties": s});
    // rust: json!({
    // rust: "input_predicate": {"predicate_type": "minecraft:blockstate_match", "block_state": state},
    // rust: "location_predicate": {"predicate_type": "minecraft:always_true"},
    // rust: "output_state": state,
    // rust: "block_entity_modifier": {"type": "horizon:edit", "remove": remove, "data": nbt(s)},
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: json!({"processor_type": "minecraft:rule", "rules": rules})
}

/// An entity's NBT in 26.3's shape, in place: 1.21.1's `ArmorItems` (feet
/// to head), `HandItems` (main hand, off hand) and their drop chances become
/// `equipment` and `drop_chances` by slot; empty items and the default drop
/// chance (0.085) are left out, as 26.3 saves them. Whether it changed.
pub fn upgrade_entity(entity: *mut Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(o) = entity.as_object_mut() else {
    // rust: return false;
}
pub const ARMOR: [[]const u8; 4] = ["feet", "legs", "chest", "head"];
pub const HANDS: [[]const u8; 2] = ["mainhand", "offhand"];
    // rust: let mut changed = false;
    // rust: for (items, chances, slots) in [
    // rust: ("ArmorItems", "ArmorDropChances", &ARMOR[..]),
    // rust: ("HandItems", "HandDropChances", &HANDS[..]),
    // rust: ] {
    // rust: if let Some(Value::Array(list)) = o.remove(items) {
    // rust: changed = true;
    // rust: for (slot, item) in slots.iter().zip(list) {
    // rust: if item.get("id").is_some() {
    // rust: let equipment = o.entry("equipment").or_insert_with(|| json!({}));
    // rust: equipment[*slot] = item;
}
}
}
    // rust: if let Some(Value::Array(list)) = o.remove(chances) {
    // rust: changed = true;
    // rust: for (slot, chance) in slots.iter().zip(list) {
    // rust: if chance.as_f64().is_some_and(|c| (c - 0.085).abs() > 1e-6) {
    // rust: let drop = o.entry("drop_chances").or_insert_with(|| json!({}));
    // rust: drop[*slot] = chance;
}
}
}
}
    // rust: changed
}

/// A 1.21.1 trial spawner config (`trial_spawner/`) in 26.3's shape, in
/// place: its mobs' NBT ([`upgrade_entity`]). Whether it changed.
pub fn upgrade_trial_spawner(config: *mut Value) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut changed = false;
    // rust: for p in config["spawn_potentials"]
    // rust: .as_array_mut()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: {
    // rust: changed |= upgrade_entity(&mut p["data"]["entity"]);
}
    // rust: changed
}

/// [`as_data`]'s `horizon:spawner_mobs` for the mods' spawner randomizing
/// processors, whose fields have the same names and defaults.
pub fn spawner_mobs(p: *Value, mobs: std.ArrayList(Value), rules: ?Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = json!({"processor_type": "horizon:spawner_mobs", "mobs": mobs});
    // rust: for key in [
    // rust: "delay",
    // rust: "min_spawn_delay",
    // rust: "max_spawn_delay",
    // rust: "spawn_count",
    // rust: "max_nearby_entities",
    // rust: "required_player_range",
    // rust: "spawn_range",
    // rust: ] {
    // rust: if let Some(n) = p.get(key).filter(|n| n.is_i64()) {
    // rust: out[key] = n.clone();
}
}
    // rust: if let Some(r) = rules {
    // rust: out["custom_spawn_rules"] = r;
}
    // rust: if let Some(b) = p.get("spawner_replacement_block") {
    // rust: out["replacement"] = b.clone();
}
    // rust: out
}

/// Repurposed Structures' `custom_spawn_rules` from its light level ranges:
/// `Some(None)` without either, `None` when one does not read. The sky
/// light's upper bound is written as `max_exclusive`, as the mod does.
pub fn repurposed_light(p: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let range = |key: &str| -> Option<Option<(i64, i64)>> {
    // rust: match p.get(key) {
    // rust: None => Some(None),
    // rust: Some(Value::Number(n)) => n.as_i64().map(|n| Some((n, n))),
    // rust: Some(v) => Some(Some((
    // rust: v["min_inclusive"].as_i64()?,
    // rust: v["max_inclusive"].as_i64()?,
    // rust: ))),
}
}
    // rust: let (block, sky) = (
    // rust: range("valid_block_light_level")?,
    // rust: range("valid_sky_light_level")?,
    // rust: );
    // rust: if block.is_none() && sky.is_none() {
    // rust: return Some(None);
}
    // rust: let mut rules = json!({});
    // rust: if let Some((min, max)) = block {
    // rust: rules["block_light_limit"] = json!({"min_inclusive": min, "max_inclusive": max});
}
    // rust: if let Some((min, max)) = sky {
    // rust: rules["sky_light_limit"] = json!({"min_inclusive": min, "max_exclusive": max});
}
    // rust: Some(Some(rules))
}

    // rust: mod tests {
//     use super::*;

pub fn data() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut d = ProcessorData::default();
    // rust: d.spawners.insert(
    // rust: "repurposed_structures:dungeons/badlands".into(),
    // rust: vec![
    // rust: ("minecraft:husk".into(), 10.),
    // rust: ("minecraft:cave_spider".into(), 3.),
    // rust: ],
    // rust: );
    // rust: d.replace_vanilla.insert(("mvs".into(), "village".into()));
    // rust: d
}

pub fn spawner_processors_become_data() void {
}
    // rust: let mut list = json!({"processors": [
    // rust: {"processor_type": "moogs_structures:spawner_randomizing_processor",
    // rust: "weighted_entities": [{"entity": "minecraft:blaze", "weight": 2, "nbt": {"Health": 5}}],
    // rust: "spawn_count": 2, "spawner_replacement_block": {"Name": "minecraft:stone"}},
    // rust: {"processor_type": "repurposed_structures:spawner_randomizing_processor",
    // rust: "rs_spawner_resourcelocation": "repurposed_structures:dungeons/badlands",
    // rust: "valid_block_light_level": {"min_inclusive": 0, "max_inclusive": 7}},
    // rust: {"processor_type": "repurposed_structures:spawner_randomizing_processor",
    // rust: "rs_spawner_resourcelocation": "repurposed_structures:missing"},
    // rust: {"processor_type": "minecraft:gravity", "heightmap": "WORLD_SURFACE_WG", "offset": 0},
    // rust: {"processor_type": "moogs_structures:vanilla_loot_swap_processor",
    // rust: "modid": "mns", "vanilla_key": "fortress", "loot_table_mapping": {}},
    // rust: {"processor_type": "moogs_structures:vanilla_loot_swap_processor",
    // rust: "modid": "mvs", "vanilla_key": "village", "loot_table_mapping": {}}]});
    // rust: let mut carried = BTreeMap::new();
    // rust: assert!(carry("processor_list", &mut list, &data(), &mut carried));
    // rust: let p = list["processors"].as_array().unwrap();
    // rust: assert_eq!(p.len(), 5, "{p:#?}");
    // rust: assert_eq!(
    // rust: p[0],
    // rust: json!({"processor_type": "horizon:spawner_mobs",
    // rust: "mobs": [{"entity": {"Health": 5, "id": "minecraft:blaze"}, "weight": 2.0}],
    // rust: "spawn_count": 2, "replacement": {"Name": "minecraft:stone"}})
    // rust: );
    // rust: assert_eq!(
    // rust: p[1],
    // rust: json!({"processor_type": "horizon:spawner_mobs",
    // rust: "mobs": [{"entity": {"id": "minecraft:husk"}, "weight": 10.0},
    // rust: {"entity": {"id": "minecraft:cave_spider"}, "weight": 3.0}],
    // rust: "custom_spawn_rules": {"block_light_limit": {"min_inclusive": 0, "max_inclusive": 7}}})
    // rust: );
        // Unknown list, vanilla processor, and a swap whose preset is on: kept
        // (the Java ones are dropped later); the swap that is off is gone.
    // rust: assert_eq!(
    // rust: p[2]["rs_spawner_resourcelocation"],
    // rust: "repurposed_structures:missing"
    // rust: );
    // rust: assert_eq!(p[3]["processor_type"], "minecraft:gravity");
    // rust: assert_eq!(p[4]["modid"], "mvs");
    // rust: assert_eq!(
    // rust: carried,
    // rust: BTreeMap::from([
    // rust: ("moogs_structures:spawner_randomizing_processor".into(), 1),
    // rust: ("moogs_structures:vanilla_loot_swap_processor".into(), 1),
    // rust: (
    // rust: "repurposed_structures:spawner_randomizing_processor".into(),
    // rust: 1
    // rust: ),
    // rust: ])
    // rust: );
}

pub fn trial_spawners_and_vaults_drop_their_saved_state() void {
}
    // rust: let mut list = json!({"processors": [
    // rust: {"processor_type": "moogs_structures:trial_spawner_randomizing_processor",
    // rust: "normal_config": "mns:arena/normal", "ominous_config": "mns:arena/ominous"},
    // rust: {"processor_type": "moogs_structures:vault_randomizing_processor",
    // rust: "loot_table": "mns:vaults/main", "ominous_loot_table": "mns:vaults/ominous"}]});
    // rust: let mut carried = BTreeMap::new();
    // rust: assert!(carry("processor_list", &mut list, &data(), &mut carried));
    // rust: let p = list["processors"].as_array().unwrap();
    // rust: let rules = |i: usize| p[i]["rules"].as_array().unwrap().clone();
        // Every state of the block: 6 x 2 trial spawners, 4 x 4 x 2 vaults.
    // rust: assert_eq!((rules(0).len(), rules(1).len()), (12, 32));
    // rust: let spawner = &rules(0)[0];
    // rust: assert_eq!(
    // rust: spawner["input_predicate"]["block_state"],
    // rust: spawner["output_state"]
    // rust: );
    // rust: assert_eq!(
    // rust: spawner["block_entity_modifier"],
    // rust: json!({"type": "horizon:edit",
    // rust: "remove": ["server_data", "shared_data", "spawn_data",
    // rust: "cooldown_end_at_tick", "next_mob_spawns_at"],
    // rust: "data": {"normal_config": "mns:arena/normal",
    // rust: "ominous_config": "mns:arena/ominous"}})
    // rust: );
    // rust: for rule in rules(1) {
    // rust: let ominous = rule["output_state"]["properties"]["ominous"] == "true";
    // rust: let (table, key) = match ominous {
    // rust: true => ("mns:vaults/ominous", "minecraft:ominous_trial_key"),
    // rust: false => ("mns:vaults/main", "minecraft:trial_key"),
}
    // rust: assert_eq!(
    // rust: rule["block_entity_modifier"],
    // rust: json!({"type": "horizon:edit", "remove": ["server_data", "shared_data"],
    // rust: "data": {"config": {"loot_table": table,
    // rust: "key_item": {"id": key, "count": 1}}}})
    // rust: );
}
    // rust: assert_eq!(carried.len(), 2);
}

pub fn trial_spawner_mobs_take_26_3s_equipment() void {
}
    // rust: let mut config = json!({"spawn_potentials": [{"weight": 1, "data": {"entity": {
    // rust: "id": "minecraft:skeleton",
    // rust: "ArmorItems": [{}, {}, {}, {"id": "minecraft:iron_helmet", "count": 1}],
    // rust: "ArmorDropChances": [0.085, 0.085, 0.085, 0.0],
    // rust: "HandItems": [{"id": "minecraft:bow", "count": 1}, {}],
    // rust: "HandDropChances": [0.085, 0.085]}}}]});
    // rust: assert!(upgrade_trial_spawner(&mut config));
    // rust: assert_eq!(
    // rust: config["spawn_potentials"][0]["data"]["entity"],
    // rust: json!({"id": "minecraft:skeleton",
    // rust: "equipment": {"head": {"id": "minecraft:iron_helmet", "count": 1},
    // rust: "mainhand": {"id": "minecraft:bow", "count": 1}},
    // rust: "drop_chances": {"head": 0.0}})
    // rust: );
    // rust: assert!(!upgrade_trial_spawner(&mut config));
}

pub fn repurposed_waterlogging_follows_the_world() void {
}
    // rust: let mut list = json!({"processors": [{"processor_type":
    // rust: "repurposed_structures:waterlogging_when_replacing_water_processor"},
    // rust: {"processor_type": "repurposed_structures:mineshaft_sky_view_processor"}]});
    // rust: let mut carried = BTreeMap::new();
    // rust: assert!(carry(
    // rust: "processor_list",
    // rust: &mut list,
    // rust: &ProcessorData::default(),
    // rust: &mut carried
    // rust: ));
    // rust: assert_eq!(
    // rust: list["processors"],
    // rust: json!([{"processor_type": "horizon:waterlog_in_world_water"},
    // rust: {"processor_type": "horizon:mineshaft_sky_view"}])
    // rust: );
}

pub fn repurposed_rule_tests_become_the_games() void {
}
    // rust: let rule = |input: Value, position: Value| {
    // rust: json!({"input_predicate": input, "location_predicate": {"predicate_type":
    // rust: "repurposed_structures:matter_phase_rule_test", "phase_to_test_for": "AIR"},
    // rust: "position_predicate": position, "output_state": {"id": "minecraft:lava"}})
}
    // rust: let mut pool = json!({"elements": [{"weight": 1, "element": {
    // rust: "element_type": "minecraft:single_pool_element", "processors": {"processors": [
    // rust: {"processor_type": "minecraft:rule", "rules": [rule(
    // rust: json!({"predicate_type": "minecraft:always_true"}),
    // rust: json!({"predicate_type": "repurposed_structures:y_value_pos_rule_test",
    // rust: "min_y_value": 0, "max_y_value": 31}))]},
    // rust: {"processor_type": "minecraft:capped", "limit": 2, "delegate": {
    // rust: "processor_type": "minecraft:rule", "rules": [rule(
    // rust: json!({"predicate_type": "minecraft:block_match", "block": "minecraft:rail"}),
    // rust: json!({"predicate_type":
    // rust: "repurposed_structures:piece_origin_axis_aligned_linear_pos_rule_test",
    // rust: "axis": "y", "min_dist": 0, "max_dist": 1}))]}}]}}}]});
    // rust: let mut carried = BTreeMap::new();
    // rust: assert!(rule_tests("template_pool", &mut pool, &mut carried));
    // rust: let list = &pool["elements"][0]["element"]["processors"]["processors"];
    // rust: let first = &list[0]["rules"][0];
    // rust: assert_eq!(
    // rust: first["location_predicate"]["predicate_type"],
    // rust: "horizon:matter_phase"
    // rust: );
    // rust: assert_eq!(first["location_predicate"]["phase_to_test_for"], "AIR");
    // rust: assert_eq!(
    // rust: first["position_predicate"]["predicate_type"],
    // rust: "horizon:y_value"
    // rust: );
    // rust: assert_eq!(first["position_predicate"]["max_y_value"], 31);
    // rust: let delegated = &list[1]["delegate"]["rules"][0];
    // rust: assert_eq!(
    // rust: delegated["position_predicate"]["predicate_type"],
    // rust: "horizon:piece_origin_axis_aligned_linear_pos"
    // rust: );
    // rust: assert_eq!(
    // rust: delegated["input_predicate"]["predicate_type"],
    // rust: "minecraft:block_match"
    // rust: );
    // rust: assert_eq!(carried.values().sum::<usize>(), 4);
    // rust: assert_eq!(carried["repurposed_structures:matter_phase_rule_test"], 2);
        // A file holding none is left as it is.
    // rust: assert!(!rule_tests("template_pool", &mut pool, &mut carried));
    // rust: assert!(!rule_tests(
    // rust: "structure",
    // rust: &mut json!({"predicate_type":
    // rust: "repurposed_structures:y_value_pos_rule_test"}),
    // rust: &mut carried
    // rust: ));
}

pub fn repurposed_structure_voids_keep_the_world() void {
}
    // rust: let mut list = json!({"processors": [
    // rust: {"processor_type": "repurposed_structures:structure_void_processor"}]});
    // rust: let mut carried = BTreeMap::new();
    // rust: assert!(carry(
    // rust: "processor_list",
    // rust: &mut list,
    // rust: &ProcessorData::default(),
    // rust: &mut carried
    // rust: ));
    // rust: assert_eq!(
    // rust: list["processors"],
    // rust: json!([{"processor_type": "minecraft:block_ignore",
    // rust: "blocks": ["minecraft:structure_void"]}])
    // rust: );
    // rust: assert_eq!(carried["repurposed_structures:structure_void_processor"], 1);
}

pub fn pillars_become_the_games() void {
}
    // rust: let mut d = ProcessorData::default();
        // Repurposed's city list names itself as its pillar's list.
    // rust: let city = json!({"processors": [
    // rust: {"processor_type": "repurposed_structures:pillar_processor", "direction": "down",
    // rust: "pillar_length": 15, "pillar_processor_list": "repurposed_structures:cities/x",
    // rust: "pillar_trigger_and_replacements": [{"trigger": {"Name": "minecraft:red_stained_glass"},
    // rust: "replacement": {"Name": "minecraft:cobblestone"}}]},
    // rust: {"processor_type": "minecraft:block_rot", "integrity": 0.5}]});
    // rust: d.lists
    // rust: .insert("repurposed_structures:cities/x".into(), city.clone());
    // rust: let mut list = city;
    // rust: list["processors"].as_array_mut().unwrap().extend([
    // rust: json!({"processor_type": "repurposed_structures:bottom_pillar_processor",
    // rust: "pillar_processor_list": "minecraft:empty"}),
    // rust: json!({"processor_type": "moogs_structures:close_off_fluid_sources_processor",
    // rust: "weighted_list_of_replacement_blocks": [{"block": "minecraft:stone", "weight": 1}]}),
    // rust: json!({"processor_type": "repurposed_structures:close_off_air_sources_processor",
    // rust: "weighted_list_of_replacement_blocks": [{"block": "minecraft:prismarine", "weight": 1}]}),
    // rust: json!({"processor_type": "betterfortresses:pillar_processor",
    // rust: "target_block": {"Name": "minecraft:orange_terracotta"},
    // rust: "target_block_output": {"defaultBlockState": {"Name": "minecraft:red_nether_bricks"}, "entries": []},
    // rust: "pillar_states": {"defaultBlockState": {"Name": "minecraft:nether_bricks"}, "entries": []}}),
    // rust: json!({"processor_type": "betterfortresses:stair_pillar_processor"}),
    // rust: ]);
    // rust: let mut carried = BTreeMap::new();
    // rust: assert!(carry("processor_list", &mut list, &d, &mut carried));
    // rust: let p = list["processors"].as_array().unwrap();
    // rust: let types: Vec<&str> = p
    // rust: .iter()
    // rust: .map(|p| p["processor_type"].as_str().unwrap())
    // rust: .collect();
    // rust: assert_eq!(
    // rust: types,
    // rust: [
    // rust: "horizon:pillar",
    // rust: "minecraft:block_rot",
    // rust: "horizon:bottom_pillar",
    // rust: "horizon:close_off_fluid_sources",
    // rust: "horizon:close_off_air_sources",
                // YUNG's processors stay Java (dropped later) until the
                // specification covers them.
    // rust: "betterfortresses:pillar_processor",
    // rust: "betterfortresses:stair_pillar_processor"
    // rust: ]
    // rust: );
        // The named list is written in once; its own pillar loses its list.
    // rust: let inner = &p[0]["pillar_processor_list"]["processors"];
    // rust: assert_eq!(inner[0]["processor_type"], "horizon:pillar");
    // rust: assert!(inner[0].get("pillar_processor_list").is_none());
    // rust: assert_eq!(
    // rust: inner[0]["pillar_trigger_and_replacements"],
    // rust: p[0]["pillar_trigger_and_replacements"]
    // rust: );
    // rust: assert_eq!(inner[1]["processor_type"], "minecraft:block_rot");
    // rust: assert!(p[2].get("pillar_processor_list").is_none());
    // rust: assert_eq!(
    // rust: p[4]["weighted_list_of_replacement_blocks"],
    // rust: json!([{"block": "minecraft:prismarine", "weight": 1}])
    // rust: );
    // rust: assert_eq!(carried["repurposed_structures:pillar_processor"], 2);
    // rust: assert!(!carried.contains_key("betterfortresses:stair_pillar_processor"));
}
}
