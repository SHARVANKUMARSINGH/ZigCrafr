//! Transpiled from Horizon Rust crate
//! Module: horizon-client_mod_content_biomes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Biome modifiers: a content mod's placed features and mob spawns in biomes
//! it does not own (vanilla's), as NeoForge's `add_features`,
//! `remove_features`, `add_spawns`, `remove_spawns`, `add_spawn_costs` and
//! `remove_spawn_costs` biome modifiers do. Each is a file in
//! `data/<ns>/neoforge/biome_modifier/` (older Forge mods:
//! `data/<ns>/forge/biome_modifier/`, type `forge:...`).
//!
//! They rewrite the biomes' `features` lists and
//! `minecraft:gameplay/natural_mob_spawns` attributes when the content root
//! builds: an added feature goes at the end of its step's list, as NeoForge
//! adds it, and the generator orders every biome's lists as vanilla's
//! `FeatureSorter` does; an added spawner goes at the end of its entity type's
//! spawn category with `minCount` and `maxCount` converted to 26.3's `count`.
//! Biomes no modifier names keep their text byte for byte, and a root with no
//! modifiers keeps vanilla's bundle, so vanilla features keep their indices
//! and their random seeds.
// use super::{J, Result};
// use horizon_world::worldgen::structure::start::STEPS;
// use serde_json::{Number, Value};
// use std::collections::{BTreeMap, BTreeSet};

/// The folders a biome modifier sits in, under `data/<ns>`.
pub const FOLDERS: [[]const u8; 2] = ["/neoforge/biome_modifier/", "/forge/biome_modifier/"];

/// Whether a mod file is a biome modifier.
    // rust: pub(super) fn is_modifier(file: &str) -> bool {
    // rust: file.starts_with("data/") && file.ends_with(".json") && FOLDERS.iter().any(|f| file.contains(f))
}

/// One mob spawner entry in an `add_spawns` modifier.
pub const Spawner = struct {
    entity: []const u8,
    weight: i64,
    min_count: i64,
    max_count: i64,
};

/// What a modifier does to its biomes.
pub const Action = enum {
    /// Appends features to one generation step.
    AddFeatures { features: Value, step: usize },
    /// Takes features out of these steps (every step when the file names none).
    RemoveFeatures { features: Value, steps: Vec<usize> },
    /// Appends spawners to their entity types' spawn categories.
    AddSpawns(Vec<Spawner>),
    /// Takes these entity types out of every spawn category.
    RemoveSpawns(Value),
    /// Sets `spawn_costs` for these entity types.
    AddSpawnCosts {,
    entity_types: Value,
    energy_budget: Number,
    charge: Number,
    // rust: },
    /// Takes these entity types out of `spawn_costs`.
    RemoveSpawnCosts(Value),
};

    // rust: impl Action {
pub fn is_add(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self,
    // rust: Self::AddFeatures { .. } | Self::AddSpawns(_) | Self::AddSpawnCosts { .. }
    // rust: )
}
}

/// One biome modifier file.
    // rust: pub(super) struct Modifier {
    /// `<mod>: <file>`, for errors.
    // rust: name: String,
    // rust: biomes: Value,
    // rust: action: Action,
}

/// A generation step's index from its name.
pub fn step(v: *Value) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = v.as_str().ok_or("step: not a name")?;
    // rust: STEPS
    // rust: .iter()
    // rust: .position(|s| *s == name)
    // rust: .ok_or_else(|| format!("unknown generation step {name:?}"))
}

/// One NeoForge `SpawnerData` object from `spawners`.
pub fn spawner(v: *Value) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let o = v.as_object().ok_or("spawner: not an object")?;
    // rust: let entity = o
    // rust: .get("type")
    // rust: .and_then(Value::as_str)
    // rust: .ok_or("spawner: no type")?;
    // rust: let int = |k: &str| {
    // rust: o.get(k)
    // rust: .and_then(Value::as_i64)
    // rust: .ok_or_else(|| format!("spawner: no {k}"))
}
    // rust: let weight = int("weight")?;
    // rust: let min_count = int("minCount")?;
    // rust: let max_count = int("maxCount")?;
    // rust: if weight < 0 {
    // rust: return Err(format!("spawner: weight ({weight}) < 0"));
}
    // rust: if min_count <= 0 {
    // rust: return Err(format!("spawner: minCount ({min_count}) must be positive"));
}
    // rust: if min_count > max_count {
    // rust: return Err(format!(
    // rust: "spawner: minCount ({min_count}) > maxCount ({max_count})"
    // rust: ));
}
    // rust: Ok(Spawner {
    // rust: entity: full(entity),
    // rust: weight,
    // rust: min_count,
    // rust: max_count,
    // rust: })
}

    // rust: impl Modifier {
    /// The modifier in `text`; `None` for `neoforge:none`, which does nothing,
    /// and for a type Horizon doesn't read yet (`add_carvers`, a mod's own
    /// serializer), which is skipped with a line in `warnings`: real mods ship
    /// those beside their feature and spawn modifiers, and one must not drop
    /// every content mod.
    // rust: pub(super) fn read(
    // rust: mod_id: &str,
    // rust: file: &str,
    // rust: text: &str,
    // rust: warnings: &mut Vec<String>,
    // rust: ) -> Result<Option<Self>> {
    // rust: let name = format!("mod {mod_id}: {file}");
    // rust: let at = |e: String| format!("{name}: {e}");
    // rust: let doc: Value = serde_json::from_str(text).map_err(|e| at(e.to_string()))?;
    // rust: let kind = doc["type"].as_str().ok_or_else(|| at("no type".into()))?;
    // rust: let kind = kind
    // rust: .strip_prefix("neoforge:")
    // rust: .or_else(|| kind.strip_prefix("forge:"))
    // rust: .unwrap_or(kind);
    // rust: let field = |key: &str| -> std::result::Result<Value, String> {
    // rust: doc.get(key).cloned().ok_or_else(|| at(format!("no {key}")))
}
    // rust: let action = match kind {
    // rust: "none" => return Ok(None),
    // rust: "add_features" => Action::AddFeatures {
    // rust: features: field("features")?,
    // rust: step: step(&field("step")?).map_err(at)?,
    // rust: },
    // rust: "remove_features" => Action::RemoveFeatures {
    // rust: features: field("features")?,
    // rust: steps: match doc.get("steps") {
    // rust: None => (0..STEPS.len()).collect(),
    // rust: Some(Value::Array(steps)) => steps
    // rust: .iter()
    // rust: .map(step)
    // rust: .collect::<std::result::Result<_, _>>()
    // rust: .map_err(at)?,
    // rust: Some(one) => vec![step(one).map_err(at)?],
    // rust: },
    // rust: },
    // rust: "add_spawns" => {
    // rust: let raw = field("spawners")?;
    // rust: let spawners = match &raw {
    // rust: Value::Array(list) => list
    // rust: .iter()
    // rust: .map(spawner)
    // rust: .collect::<std::result::Result<_, _>>()
    // rust: .map_err(at)?,
    // rust: one @ Value::Object(_) => vec![spawner(one).map_err(at)?],
    // rust: _ => return Err(at("spawners: not a spawner or list".into()).into()),
}
    // rust: Action::AddSpawns(spawners)
}
    // rust: "remove_spawns" => Action::RemoveSpawns(field("entity_types")?),
    // rust: "add_spawn_costs" => {
    // rust: let entity_types = field("entity_types")?;
    // rust: let cost = field("spawn_cost")?;
    // rust: let num = |k: &str| {
    // rust: cost.get(k)
    // rust: .and_then(Value::as_number)
    // rust: .cloned()
    // rust: .ok_or_else(|| at(format!("spawn_cost: no {k}")))
}
    // rust: Action::AddSpawnCosts {
    // rust: entity_types,
    // rust: energy_budget: num("energy_budget")?,
    // rust: charge: num("charge")?,
}
}
    // rust: "remove_spawn_costs" => Action::RemoveSpawnCosts(field("entity_types")?),
    // rust: other => {
    // rust: warnings.push(at(format!(
    // rust: "biome modifier type {other:?} skipped: only feature, spawn and none \
    // rust: modifiers are read"
    // rust: )));
    // rust: return Ok(None);
}
}
    // rust: Ok(Some(Self {
    // rust: biomes: field("biomes")?,
    // rust: action,
    // rust: name,
    // rust: }))
}
}

/// `ns:path` for an id that may leave out `minecraft:`.
pub fn full(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match id.contains(':') {
    // rust: true => id.to_owned(),
    // rust: false => format!("minecraft:{id}"),
}
}

/// A registry the modifiers name entries of: its ids and its tags (tag id →
/// the tag file's text), as the worldgen loader's bundles hold them.
    // rust: pub(super) struct Registry<'a> {
    // rust: pub what: &'static str,
    // rust: pub ids: &'a BTreeSet<String>,
    // rust: pub tags: &'a BTreeMap<String, String>,
}

    // rust: impl Registry<'_> {
    /// The ids a holder set names, in its order without repeats: an id,
    /// `#tag`, a list of ids, or one of NeoForge's `any`, `or`, `and` and
    /// `not` objects. Unknown ids and tags are errors; inside a tag, entries
    /// nobody registers are left out, as the worldgen loader leaves them out.
pub fn resolve(self: *Self, set: *Value) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // rust: match set {
    // rust: Value::String(s) => match s.strip_prefix('#') {
    // rust: Some(tag) => self.expand(&full(tag), &mut out, &mut BTreeSet::new())?,
    // rust: None => {
    // rust: let id = full(s);
    // rust: if !self.ids.contains(&id) {
    // rust: return Err(format!("unknown {} {id}", self.what));
}
    // rust: out.push(id);
}
    // rust: },
    // rust: Value::Array(list) => {
    // rust: for v in list {
    // rust: match v {
    // rust: Value::String(s) if !s.starts_with('#') => {
    // rust: extend(&mut out, self.resolve(v)?)
}
    // rust: _ => return Err(format!("a {} list holds ids only", self.what)),
}
}
}
    // rust: Value::Object(o) => {
    // rust: let kind = o.get("type").and_then(Value::as_str).unwrap_or_default();
    // rust: let kind = kind.strip_prefix("neoforge:").unwrap_or(kind);
    // rust: let sets = || -> std::result::Result<Vec<Vec<String>>, String> {
    // rust: o.get("values")
    // rust: .and_then(Value::as_array)
    // rust: .ok_or(format!("{kind}: no values"))?
    // rust: .iter()
    // rust: .map(|v| self.resolve(v))
    // rust: .collect()
}
    // rust: match kind {
    // rust: "any" => out.extend(self.ids.iter().cloned()),
    // rust: "or" => sets()?.into_iter().for_each(|s| extend(&mut out, s)),
    // rust: "and" => {
    // rust: let mut sets = sets()?.into_iter();
    // rust: out = sets.next().unwrap_or_default();
    // rust: for s in sets {
    // rust: out.retain(|id| s.contains(id));
}
}
    // rust: "not" => {
    // rust: let not = self.resolve(o.get("value").ok_or("not: no value")?)?;
    // rust: out.extend(self.ids.iter().filter(|id| !not.contains(id)).cloned());
}
    // rust: _ => return Err(format!("{} set type {kind:?} is not read", self.what)),
}
}
    // rust: _ => return Err(format!("not a {} id, tag or list", self.what)),
}
    // rust: Ok(out)
}

    // rust: fn expand(
    // rust: &self,
    // rust: tag: &str,
    // rust: out: &mut Vec<String>,
    // rust: seen: &mut BTreeSet<String>,
    // rust: ) -> std::result::Result<(), String> {
    // rust: if !seen.insert(tag.to_owned()) {
    // rust: return Ok(());
}
    // rust: let text = self
    // rust: .tags
    // rust: .get(tag)
    // rust: .ok_or_else(|| format!("unknown {} tag #{tag}", self.what))?;
    // rust: let doc: Value = serde_json::from_str(text).map_err(|e| format!("#{tag}: {e}"))?;
    // rust: for v in doc["values"].as_array().into_iter().flatten() {
    // rust: let (id, required) = match v {
    // rust: Value::String(s) => (s.as_str(), true),
    // rust: Value::Object(o) => match o.get("id").and_then(Value::as_str) {
    // rust: Some(id) => (id, o.get("required") != Some(&Value::Bool(false))),
    // rust: None => continue,
    // rust: },
    // rust: _ => continue,
}
    // rust: match id.strip_prefix('#') {
    // rust: Some(inner) if required || self.tags.contains_key(&full(inner)) => {
    // rust: self.expand(&full(inner), out, seen)?
}
    // rust: Some(_) => {}
    // rust: None if self.ids.contains(&full(id)) => extend(out, [full(id)]),
    // rust: None => {}
}
}
    // rust: Ok(())
}
}

/// Appends the ids `out` lacks.
pub fn extend(out: *mut std.ArrayList([]const u8), ids: impl IntoIterator<Item = []const u8>) void {
}
    // rust: for id in ids {
    // rust: if !out.contains(&id) {
    // rust: out.push(id);
}
}
}

/// Applies `modifiers` to the biome bundle `biomes` (id → the biome's text):
/// every addition first, then every removal, each in mod and file order (as
/// NeoForge's add phase runs before its remove phase). A modifier naming a
/// biome, feature, entity type or tag the root doesn't have (another mod's, a
/// `#c:` convention tag) is skipped with a line in `warnings`, as NeoForge
/// skips a holder set it can't resolve, instead of dropping every content mod.
    // rust: pub(super) fn apply(
    // rust: biomes: &mut J,
    // rust: modifiers: &[Modifier],
    // rust: biome_reg: &Registry<'_>,
    // rust: feature_reg: &Registry<'_>,
    // rust: entity_reg: &Registry<'_>,
    // rust: entity_categories: &BTreeMap<String, String>,
    // rust: warnings: &mut Vec<String>,
    // rust: ) -> Result<Vec<(String, String)>> {
    // rust: let adds = modifiers.iter().filter(|m| m.action.is_add());
    // rust: let removes = modifiers.iter().filter(|m| !m.action.is_add());
    // Each biome changed, parsed once, in the bundle's order.
    // rust: let mut changed: BTreeMap<String, J> = BTreeMap::new();
    // rust: for m in adds.chain(removes) {
    // rust: let at = |e: String| format!("{}: {e}", m.name);
    // rust: let resolved: std::result::Result<(Vec<String>, Vec<String>), String> =
    // rust: biome_reg.resolve(&m.biomes).and_then(|targets| {
    // rust: let ids = match &m.action {
    // rust: Action::AddFeatures { features, .. }
    // rust: | Action::RemoveFeatures { features, .. } => feature_reg.resolve(features)?,
    // rust: Action::AddSpawns(spawners) => {
    // rust: if let Some(s) = spawners
    // rust: .iter()
    // rust: .find(|s| !entity_reg.ids.contains(&s.entity))
    // rust: {
    // rust: return Err(format!("unknown {} {}", entity_reg.what, s.entity));
}
    // rust: Vec::new()
}
    // rust: Action::RemoveSpawns(entity_types)
    // rust: | Action::AddSpawnCosts { entity_types, .. }
    // rust: | Action::RemoveSpawnCosts(entity_types) => entity_reg.resolve(entity_types)?,
}
    // rust: Ok((targets, ids))
    // rust: });
    // rust: let (targets, ids) = match resolved {
    // rust: Ok(both) => both,
    // rust: Err(e) => {
    // rust: warnings.push(at(format!("{e}: skipped")));
    // rust: continue;
}
}
    // rust: if matches!(&m.action, Action::AddSpawns(s) if s.is_empty()) {
    // rust: continue;
}
    // rust: for biome in targets {
    // rust: let doc = match changed.entry(biome.clone()) {
    // rust: std::collections::btree_map::Entry::Occupied(e) => e.into_mut(),
    // rust: std::collections::btree_map::Entry::Vacant(e) => {
    // rust: let Some(J::Str(text)) = biomes.get(&biome) else {
    // rust: continue;
}
    // rust: e.insert(serde_json::from_str(text).map_err(|e| at(format!("{biome}: {e}")))?)
}
}
    // rust: edit(doc, &m.action, &ids, entity_categories)
    // rust: .map_err(|e| at(format!("{biome}: {e}")))?;
}
}
    // rust: let mut out = Vec::with_capacity(changed.len());
    // rust: for (id, doc) in changed {
    // rust: let text = serde_json::to_string(&doc)?;
    // rust: biomes.set(&id, J::Str(text.clone()));
    // rust: out.push((id, text));
}
    // rust: Ok(out)
}

/// One modifier's change to one biome.
    // rust: fn edit(
    // rust: biome: &mut J,
    // rust: action: &Action,
    // rust: ids: &[String],
    // rust: entity_categories: &BTreeMap<String, String>,
    // rust: ) -> std::result::Result<(), String> {
    // rust: match action {
    // rust: Action::AddFeatures { step, .. } => {
    // rust: edit_features(biome, std::slice::from_ref(step), true, ids)
}
    // rust: Action::RemoveFeatures { steps, .. } => edit_features(biome, steps, false, ids),
    // rust: Action::AddSpawns(spawners) => add_spawns(biome, spawners, entity_categories),
    // rust: Action::RemoveSpawns(_) => remove_spawns(biome, ids),
    // rust: Action::AddSpawnCosts {
    // rust: energy_budget,
    // rust: charge,
    // rust: ..
    // rust: } => add_spawn_costs(biome, ids, energy_budget, charge),
    // rust: Action::RemoveSpawnCosts(_) => remove_spawn_costs(biome, ids),
}
}

/// One feature modifier's change to one biome's `features` (a list per step).
    // rust: fn edit_features(
    // rust: biome: &mut J,
    // rust: wanted: &[usize],
    // rust: add: bool,
    // rust: features: &[String],
    // rust: ) -> std::result::Result<(), String> {
    // rust: if biome.get("features").is_none() {
    // rust: biome.set("features", J::Arr(Vec::new()));
}
    // rust: let Some(J::Arr(steps)) = biome.get_mut("features") else {
    // rust: return Err("features: not a list of steps".into());
}
    // rust: if add && let Some(&step) = wanted.first() {
    // rust: while steps.len() <= step {
    // rust: steps.push(J::Arr(Vec::new()));
}
}
    // rust: for &i in wanted {
    // rust: let Some(list) = steps.get_mut(i) else {
    // rust: continue;
}
        // A step may be one id; a tag cannot take more features.
    // rust: if let J::Str(one) = list {
    // rust: if one.starts_with('#') {
    // rust: return Err(format!("step {} is the feature tag {one}", STEPS[i]));
}
    // rust: *list = J::Arr(vec![J::Str(one.clone())]);
}
    // rust: let J::Arr(list) = list else {
    // rust: return Err(format!("step {}: not a list", STEPS[i]));
}
    // rust: let held = |v: &J| match v {
    // rust: J::Str(s) => Some(full(s)),
    // rust: _ => None,
}
    // rust: if add {
    // rust: for f in features {
                // Twice in one step would be a cycle for the sorter.
    // rust: if !list.iter().any(|v| held(v).as_ref() == Some(f)) {
    // rust: list.push(J::Str(f.clone()));
}
}
    // rust: } else {
    // rust: list.retain(|v| held(v).is_none_or(|id| !features.contains(&id)));
}
}
    // rust: Ok(())
}

/// The `minecraft:gameplay/natural_mob_spawns` argument object on `biome`,
/// creating it when the biome does not yet have one.
pub fn natural_spawns(biome: *mut J) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if biome.get("attributes").is_none() {
    // rust: biome.set("attributes", J::Obj(Vec::new()));
}
    // rust: let Some(attrs @ J::Obj(_)) = biome.get_mut("attributes") else {
    // rust: return Err("attributes: not an object".into());
}
pub const KEY: []const u8 = "minecraft:gameplay/natural_mob_spawns";
    // rust: if attrs.get(KEY).is_none() {
    // rust: attrs.set(
    // rust: KEY,
    // rust: J::Obj(vec![
    // rust: (
    // rust: "argument".into(),
    // rust: J::Obj(vec![
    // rust: ("spawn_costs".into(), J::Obj(Vec::new())),
    // rust: ("spawns_by_category".into(), J::Obj(Vec::new())),
    // rust: ]),
    // rust: ),
    // rust: ("modifier".into(), J::Str("overlay".into())),
    // rust: ]),
    // rust: );
}
    // rust: let Some(nat) = attrs.get_mut(KEY) else {
    // rust: unreachable!()
}
    // rust: if nat.get("argument").is_some() {
    // rust: match nat.get_mut("argument") {
    // rust: Some(arg @ J::Obj(_)) => Ok(arg),
    // rust: _ => Err(format!("{KEY}.argument: not an object")),
}
    // rust: } else {
    // rust: match nat {
    // rust: J::Obj(_) => Ok(nat),
    // rust: _ => Err(format!("{KEY}: not an object")),
}
}
}

    // rust: fn add_spawns(
    // rust: biome: &mut J,
    // rust: spawners: &[Spawner],
    // rust: entity_categories: &BTreeMap<String, String>,
    // rust: ) -> std::result::Result<(), String> {
    // rust: let nat = natural_spawns(biome)?;
    // rust: if nat.get("spawns_by_category").is_none() {
    // rust: nat.set("spawns_by_category", J::Obj(Vec::new()));
}
    // rust: let Some(by_cat @ J::Obj(_)) = nat.get_mut("spawns_by_category") else {
    // rust: return Err("spawns_by_category: not an object".into());
}
    // rust: for s in spawners {
    // rust: let cat = entity_categories
    // rust: .get(&s.entity)
    // rust: .map_or("misc", String::as_str);
    // rust: if by_cat.get(cat).is_none() {
    // rust: by_cat.set(cat, J::Arr(Vec::new()));
}
    // rust: let Some(J::Arr(list)) = by_cat.get_mut(cat) else {
    // rust: return Err(format!("spawns_by_category.{cat}: not a list"));
}
    // rust: let count = if s.min_count == s.max_count {
    // rust: J::Num(s.min_count.into())
    // rust: } else {
    // rust: J::Obj(vec![
    // rust: ("type".into(), J::Str("minecraft:uniform".into())),
    // rust: ("min_inclusive".into(), J::Num(s.min_count.into())),
    // rust: ("max_inclusive".into(), J::Num(s.max_count.into())),
    // rust: ])
}
    // rust: list.push(J::Obj(vec![
    // rust: ("type".into(), J::Str(s.entity.clone())),
    // rust: ("count".into(), count),
    // rust: ("weight".into(), J::Num(s.weight.into())),
    // rust: ]));
}
    // rust: Ok(())
}

pub fn remove_spawns(biome: *mut J, entities: *[[]const u8]) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(nat) = biome
    // rust: .get_mut("attributes")
    // rust: .and_then(|a| a.get_mut("minecraft:gameplay/natural_mob_spawns"))
    // rust: else {
    // rust: return Ok(());
}
    // rust: let nat = if nat.get("argument").is_some() {
    // rust: nat.get_mut("argument").unwrap()
    // rust: } else {
    // rust: nat
}
    // rust: let Some(by_cat) = nat.get_mut("spawns_by_category") else {
    // rust: return Ok(());
}
    // rust: let J::Obj(cats) = by_cat else {
    // rust: return Err("spawns_by_category: not an object".into());
}
    // rust: for (cat, list) in cats {
    // rust: let J::Arr(entries) = list else {
    // rust: return Err(format!("spawns_by_category.{cat}: not a list"));
}
    // rust: entries.retain(|entry| {
    // rust: entry
    // rust: .get("type")
    // rust: .and_then(J::as_str)
    // rust: .is_none_or(|t| !entities.contains(&full(t)))
    // rust: });
}
    // rust: Ok(())
}

    // rust: fn add_spawn_costs(
    // rust: biome: &mut J,
    // rust: entities: &[String],
    // rust: energy_budget: &Number,
    // rust: charge: &Number,
    // rust: ) -> std::result::Result<(), String> {
    // rust: let nat = natural_spawns(biome)?;
    // rust: if nat.get("spawn_costs").is_none() {
    // rust: nat.set("spawn_costs", J::Obj(Vec::new()));
}
    // rust: let Some(costs @ J::Obj(_)) = nat.get_mut("spawn_costs") else {
    // rust: return Err("spawn_costs: not an object".into());
}
    // rust: for entity in entities {
    // rust: if let J::Obj(entries) = costs {
    // rust: entries.retain(|(k, _)| k == entity || full(k) != *entity);
}
    // rust: costs.set(
    // rust: entity,
    // rust: J::Obj(vec![
    // rust: ("energy_budget".into(), J::Num(energy_budget.clone())),
    // rust: ("charge".into(), J::Num(charge.clone())),
    // rust: ]),
    // rust: );
}
    // rust: Ok(())
}

pub fn remove_spawn_costs(biome: *mut J, entities: *[[]const u8]) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(nat) = biome
    // rust: .get_mut("attributes")
    // rust: .and_then(|a| a.get_mut("minecraft:gameplay/natural_mob_spawns"))
    // rust: else {
    // rust: return Ok(());
}
    // rust: let nat = if nat.get("argument").is_some() {
    // rust: nat.get_mut("argument").unwrap()
    // rust: } else {
    // rust: nat
}
    // rust: let Some(costs) = nat.get_mut("spawn_costs") else {
    // rust: return Ok(());
}
    // rust: let J::Obj(entries) = costs else {
    // rust: return Err("spawn_costs: not an object".into());
}
    // rust: entries.retain(|(k, _)| !entities.contains(&full(k)));
    // rust: Ok(())
}
