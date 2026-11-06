//! Transpiled from Horizon Rust crate
//! Module: horizon-world_overrides
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A world's data packs over the prepared worldgen bundles.
//!
//! Vanilla builds its worldgen registries from the enabled packs in order:
//! the built-in pack first, then each enabled pack, a later pack's file for
//! an id replacing an earlier one's. Tags are the exception: every pack's
//! file for a tag adds its entries, and `replace` drops what came before.
//! The prepared bundles are the built-in pack, so the packs above it are
//! entries that replace or join a bundle's (`GeneratorData::load_with`).
// use serde_json::Value;
// use std::collections::BTreeMap;

/// The bundle of `dimension/<id>.json` level stems. Nothing prepared has
/// it: a pack's level stem stands in for the world preset's.
pub const DIMENSIONS: []const u8 = "dimensions";
/// The bundle of `dimension_type/<id>.json` dimension types. Nothing
/// prepared has it: the vanilla types' are `LevelHeight::vanilla`.
pub const DIMENSION_TYPES: []const u8 = "dimension_types";

/// Pack folders (`data/<ns>/<kind>/`) the chunk generator reads, and the
/// bundle each joins.
    // rust: const KINDS: [(&str, &str); 16] = [
    // rust: ("dimension", DIMENSIONS),
    // rust: ("dimension_type", DIMENSION_TYPES),
    // rust: ("worldgen/biome", "biomes"),
    // rust: ("worldgen/block_state_provider", "state_providers"),
    // 26.3's names: 26.2 called them configured_carver and configured_feature.
    // rust: ("worldgen/carver", "carvers"),
    // rust: ("worldgen/feature", "features"),
    // rust: ("worldgen/density_function", "densities"),
    // rust: ("worldgen/material_condition", "conditions"),
    // rust: ("worldgen/material_rule", "rules"),
    // rust: ("worldgen/noise", "noises"),
    // rust: ("worldgen/noise_settings", "settings"),
    // rust: ("worldgen/placed_feature", "placed_features"),
    // rust: ("worldgen/processor_list", "processor_lists"),
    // rust: ("worldgen/structure", "structures"),
    // rust: ("worldgen/structure_set", "structure_sets"),
    // rust: ("worldgen/template_pool", "template_pools"),
    // rust: ];
/// Tag folders the chunk generator reads, and the tag bundle each joins.
    // rust: const TAG_KINDS: [(&str, &str); 3] = [
    // rust: ("tags/block", "block_tags"),
    // rust: ("tags/fluid", "fluid_tags"),
    // rust: ("tags/worldgen/biome", "biome_tags"),
    // rust: ];
/// The pack folders `add_file` looks at, in walk order.
pub const PACK_KINDS: [[]const u8; 4] = ["dimension", "dimension_type", "tags", "worldgen"];

/// `ns:path` for a pack file `data/<ns>/<kind>/<path>.json`.
pub fn resource_id(file: []const u8, kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (ns, rest) = file.strip_prefix("data/")?.split_once('/')?;
    // rust: let path = rest
    // rust: .strip_prefix(kind)?
    // rust: .strip_prefix('/')?
    // rust: .strip_suffix(".json")?;
    // rust: Some(format!("{ns}:{path}"))
}

/// What `add_file` made of a pack file.
pub const PackFile = enum {
    /// An entry or tag file the generator reads.
    Read,
    /// A worldgen file of a kind the generator does not read (its folder).
    NotRead(String),
    /// A generator file whose text could not be read.
    Unreadable,
    /// Not worldgen.
    Other,
};

/// A level's build range (`LevelHeightAccessor`: `min_y`, `height`) and the
/// rest of its dimension type the game reads: `logical_height`,
/// `has_skylight` and `has_ceiling`.
pub const LevelHeight = struct {
    min_y: i32,
    height: i32,
    logical_height: i32,
    has_skylight: bool,
    has_ceiling: bool,
};
    // rust: impl LevelHeight {
    /// The vanilla dimension types'.
pub fn vanilla(dimension_type: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (min_y, height, logical_height, has_skylight, has_ceiling) = match dimension_type {
            // overworld_caves builds like the Overworld but has a ceiling.
    // rust: "minecraft:overworld" => (-64, 384, 384, true, false),
    // rust: "minecraft:overworld_caves" => (-64, 384, 384, true, true),
    // rust: "minecraft:the_nether" => (0, 256, 128, false, true),
    // rust: "minecraft:the_end" => (0, 256, 256, true, false),
    // rust: _ => return None,
}
    // rust: Some(Self {
    // rust: min_y,
    // rust: height,
    // rust: logical_height,
    // rust: has_skylight,
    // rust: has_ceiling,
    // rust: })
}
    /// A dimension type's JSON, if its codec accepts the range: multiples
    /// of 16, at least 16 high, within `DimensionType.MIN_Y` (-2032) and
    /// `MAX_Y` (2031), and a logical height within the height.
pub fn of_json(v: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let int = |k: &str| i32::try_from(v[k].as_i64()?).ok();
    // rust: let (min_y, height) = (int("min_y")?, int("height")?);
    // rust: let logical_height = int("logical_height").unwrap_or(height);
    // rust: let valid = min_y % 16 == 0
    // rust: && height % 16 == 0
    // rust: && height >= 16
    // rust: && min_y >= -2032
    // rust: && min_y + height <= 2032
    // rust: && (0..=height).contains(&logical_height);
    // rust: valid.then_some(Self {
    // rust: min_y,
    // rust: height,
    // rust: logical_height,
    // rust: has_skylight: v["has_skylight"].as_bool().unwrap_or(true),
            // The codec requires has_ceiling; a type the packs leave it out
            // of gets the open-sky default.
    // rust: has_ceiling: v["has_ceiling"].as_bool().unwrap_or(false),
    // rust: })
}
    /// A level stem's `type` (a dimension type id, or one inline), with the
    /// packs' `types` over the vanilla ones.
pub fn of_type(ty: *Value, types: *BTreeMap<[]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ty {
    // rust: Value::String(id) => match types.get(id) {
    // rust: Some(json) => Self::of_json(&serde_json::from_str(json).ok()?),
    // rust: None => Self::vanilla(id),
    // rust: },
    // rust: inline @ Value::Object(_) => Self::of_json(inline),
    // rust: _ => None,
}
}
}

/// Replacement and added bundle entries, and tag files, from data packs.
pub const WorldgenOverrides = struct {
    /// Bundle name → id → the highest pack's JSON text for it.
    entries: BTreeMap<[]const u8,
    /// Tag bundle name → (tag id, pack id, tag file text), lowest pack first.
    tags: BTreeMap<[]const u8,
};
    // rust: impl WorldgenOverrides {
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries.is_empty() && self.tags.is_empty()
}
    /// A pack's file for `id` in `bundle`: called for packs from the lowest
    /// to the highest, so the last call for an id wins.
pub fn set(self: *Self, bundle: []const u8, id: []const u8, json: []const u8) void {
}
    // rust: self.entries
    // rust: .entry(bundle.to_owned())
    // rust: .or_default()
    // rust: .insert(id.to_owned(), json);
}
    /// A pack's tag file for the tag `id` in the tag bundle `bundle`, in
    /// pack order.
pub fn add_tag(self: *Self, bundle: []const u8, id: []const u8, pack: []const u8, json: []const u8) void {
}
    // rust: self.tags.entry(bundle.to_owned()).or_default().push((
    // rust: id.to_owned(),
    // rust: pack.to_owned(),
    // rust: json,
    // rust: ));
}
    /// The file `file` (`data/<ns>/...`, relative to the pack root) of the
    /// pack `pack`, whose text `read` gives. Packs go from the lowest to the
    /// highest, each in its own file order.
    // rust: pub fn add_file(
    // rust: &mut self,
    // rust: pack: &str,
    // rust: file: &str,
    // rust: read: impl FnOnce() -> Option<String>,
    // rust: ) -> PackFile {
    // rust: let Some((_, rest)) = file.strip_prefix("data/").and_then(|r| r.split_once('/')) else {
    // rust: return PackFile::Other;
}
    // rust: if let Some((bundle, id)) = KINDS
    // rust: .iter()
    // rust: .find_map(|(kind, bundle)| Some((bundle, resource_id(file, kind)?)))
    // rust: {
    // rust: let Some(json) = read() else {
    // rust: return PackFile::Unreadable;
}
    // rust: self.set(bundle, &id, json);
    // rust: PackFile::Read
    // rust: } else if let Some((bundle, id)) = TAG_KINDS
    // rust: .iter()
    // rust: .find_map(|(kind, bundle)| Some((bundle, resource_id(file, kind)?)))
    // rust: {
    // rust: let Some(json) = read() else {
    // rust: return PackFile::Unreadable;
}
    // rust: self.add_tag(bundle, &id, pack, json);
    // rust: PackFile::Read
    // rust: } else if rest.starts_with("worldgen/") || rest.starts_with("tags/worldgen/") {
    // rust: PackFile::NotRead(rest.rsplit_once('/').map_or(rest, |(k, _)| k).to_owned())
    // rust: } else {
    // rust: PackFile::Other
}
}
    /// After the last pack: leaves out the packs' new biomes (`known` says
    /// which the game has), and what names them names the rest without
    /// them: their biome tags' other biomes, and the climate points of the
    /// other biomes in a level stem's multi-noise list (the left-out
    /// biome's climate goes to its nearest neighbours). Returns what it
    /// left out, for the log.
pub fn finish(self: *Self, known: impl Fn([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let left_out = self.retain("biomes", &known);
    // rust: let mut warnings: Vec<String> = left_out
    // rust: .iter()
    // rust: .map(|id| {
    // rust: format!("biome {id} is new: Horizon cannot add biomes yet, so it is left out")
    // rust: })
    // rust: .collect();
    // rust: if left_out.is_empty() {
    // rust: return warnings;
}
    // rust: let gone = |v: &Value| {
    // rust: let id = v.as_str().or_else(|| v["id"].as_str()).unwrap_or_default();
    // rust: let id = if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
    // rust: left_out.contains(&id)
}
    // rust: for (_, _, json) in self.tags.get_mut("biome_tags").into_iter().flatten() {
    // rust: if let Ok(mut v) = serde_json::from_str::<Value>(json)
    // rust: && let Some(values) = v["values"].as_array_mut()
    // rust: {
    // rust: let before = values.len();
    // rust: values.retain(|e| !gone(e));
    // rust: if values.len() != before {
    // rust: *json = v.to_string();
}
}
}
    // rust: for (id, json) in self.entries.get_mut(DIMENSIONS).into_iter().flatten() {
    // rust: let Ok(mut v) = serde_json::from_str::<Value>(json) else {
    // rust: continue;
}
    // rust: let Some(points) = v["generator"]["biome_source"]["biomes"].as_array_mut() else {
    // rust: continue;
}
    // rust: let before = points.len();
    // rust: points.retain(|p| !gone(&p["biome"]));
    // rust: if points.len() != before {
    // rust: warnings.push(format!(
    // rust: "dimension {id}: {} of its {before} biome climate points name left-out \
    // rust: biomes and are removed",
    // rust: before - points.len()
    // rust: ));
    // rust: *json = v.to_string();
}
}
    // rust: warnings
}
    /// The build range of the vanilla level `level` (`minecraft:overworld`,
    /// `minecraft:the_nether`, `minecraft:the_end`) with these packs: the
    /// dimension type its level stem names (a pack's stem, else the
    /// preset's, whose type has the level's name), a pack's file for that
    /// type over the vanilla one. `None` when the packs give it a range the
    /// codec refuses.
pub fn level_height(self: *Self, level: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let none = BTreeMap::new();
    // rust: let types = self.entries.get(DIMENSION_TYPES).unwrap_or(&none);
    // rust: let ty = match self.entries.get(DIMENSIONS).and_then(|d| d.get(level)) {
    // rust: Some(stem) => serde_json::from_str::<Value>(stem).ok()?["type"].clone(),
    // rust: None => Value::String(level.to_owned()),
}
    // rust: LevelHeight::of_type(&ty, types)
}
    /// The entries packs give `bundle`.
pub fn entries(self: *Self, bundle: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entries
    // rust: .get(bundle)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(id, json)| (id.as_str(), json.as_str()))
}
    /// The tag files packs give the tag bundle `bundle`, in pack order.
pub fn tags(self: *Self, bundle: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.tags
    // rust: .get(bundle)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(id, pack, json)| (id.as_str(), pack.as_str(), json.as_str()))
}
    /// Removes the entries of `bundle` that `keep` refuses, returning their ids.
pub fn retain(self: *Self, bundle: []const u8, mut keep: impl FnMut([]const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(entries) = self.entries.get_mut(bundle) else {
    // rust: return Vec::new();
}
    // rust: let dropped: Vec<String> = entries.keys().filter(|id| !keep(id)).cloned().collect();
    // rust: for id in &dropped {
    // rust: entries.remove(id);
}
    // rust: if entries.is_empty() {
    // rust: self.entries.remove(bundle);
}
    // rust: dropped
}
    /// `bundle` with the packs' entries over it.
    // rust: pub fn apply(
    // rust: &self,
    // rust: bundle: &str,
    // rust: mut base: BTreeMap<String, String>,
    // rust: ) -> BTreeMap<String, String> {
    // rust: for (id, json) in self.entries(bundle) {
    // rust: base.insert(id.to_owned(), json.to_owned());
}
    // rust: base
}
}

    // rust: mod tests {
//     use super::*;

pub fn the_highest_pack_wins_and_others_join() void {
}
    // rust: let mut o = WorldgenOverrides::default();
    // rust: assert!(o.is_empty());
    // rust: o.set("noises", "minecraft:cave", "low".into());
    // rust: o.set("noises", "minecraft:cave", "high".into());
    // rust: o.set("noises", "pack:new", "new".into());
    // rust: let base = BTreeMap::from([
    // rust: ("minecraft:cave".to_owned(), "vanilla".to_owned()),
    // rust: ("minecraft:other".to_owned(), "kept".to_owned()),
    // rust: ]);
    // rust: let merged = o.apply("noises", base);
    // rust: assert_eq!(merged["minecraft:cave"], "high");
    // rust: assert_eq!(merged["minecraft:other"], "kept");
    // rust: assert_eq!(merged["pack:new"], "new");
    // rust: assert_eq!(o.apply("densities", BTreeMap::new()).len(), 0);
}

pub fn pack_files_go_to_their_bundles() void {
}
    // rust: let mut o = WorldgenOverrides::default();
    // rust: let text = |t: &str| {
    // rust: let t = t.to_owned();
    // rust: move || Some(t)
}
    // rust: let mut add = |file: &str, json: &str| o.add_file("file/p", file, text(json));
    // rust: assert_eq!(
    // rust: add("data/minecraft/worldgen/noise/cave.json", "1"),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/p/worldgen/density_function/a/b.json", "2"),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/minecraft/worldgen/noise_settings/overworld.json", "3"),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/minecraft/worldgen/structure_set/mineshafts.json", "4"),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/minecraft/dimension/overworld.json", "5"),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/minecraft/tags/worldgen/biome/is_hill.json", "{}"),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add(
    // rust: "data/minecraft/dimension_type/overworld.json",
    // rust: r#"{"min_y":-64,"height":2096}"#
    // rust: ),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/minecraft/worldgen/carver/cave.json", "6"),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/minecraft/worldgen/feature/water_delta.json", "7"),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add(
    // rust: "data/p/worldgen/block_state_provider/stony_cliffs.json",
    // rust: "8"
    // rust: ),
    // rust: PackFile::Read
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/minecraft/worldgen/configured_carver/cave.json", "{}"),
    // rust: PackFile::NotRead("worldgen/configured_carver".into())
    // rust: );
    // rust: assert_eq!(
    // rust: add("data/minecraft/worldgen/world_preset/normal.json", "{}"),
    // rust: PackFile::NotRead("worldgen/world_preset".into())
    // rust: );
    // rust: assert_eq!(add("data/p/function/f.mcfunction", ""), PackFile::Other);
    // rust: assert_eq!(
    // rust: o.add_file("file/p", "data/p/worldgen/noise/x.json", || None),
    // rust: PackFile::Unreadable
    // rust: );
    // rust: let get = |bundle: &str| o.entries(bundle).collect::<Vec<_>>();
    // rust: assert_eq!(get("noises"), [("minecraft:cave", "1")]);
    // rust: assert_eq!(get("densities"), [("p:a/b", "2")]);
    // rust: assert_eq!(get("settings"), [("minecraft:overworld", "3")]);
    // rust: assert_eq!(get("structure_sets"), [("minecraft:mineshafts", "4")]);
    // rust: assert_eq!(get(DIMENSIONS), [("minecraft:overworld", "5")]);
    // rust: assert_eq!(get("carvers"), [("minecraft:cave", "6")]);
    // rust: assert_eq!(get("features"), [("minecraft:water_delta", "7")]);
    // rust: assert_eq!(get("state_providers"), [("p:stony_cliffs", "8")]);
    // rust: assert_eq!(get("structures"), []);
    // rust: assert_eq!(o.tags("biome_tags").count(), 1);
}

pub fn levels_take_their_height_from_the_packs_dimension_types() void {
}
    // rust: let mut o = WorldgenOverrides::default();
    // rust: let overworld = o.level_height("minecraft:overworld");
    // rust: assert_eq!(overworld, LevelHeight::vanilla("minecraft:overworld"));
    // rust: let nether = o.level_height("minecraft:the_nether").unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: nether.logical_height,
    // rust: nether.has_skylight,
    // rust: nether.has_ceiling
    // rust: ),
    // rust: (128, false, true)
    // rust: );
        // overworld_caves builds like the Overworld but has a ceiling.
    // rust: let caves = LevelHeight::vanilla("minecraft:overworld_caves").unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: caves.min_y,
    // rust: caves.height,
    // rust: caves.has_skylight,
    // rust: caves.has_ceiling
    // rust: ),
    // rust: (-64, 384, true, true)
    // rust: );
    // rust: o.set(
    // rust: DIMENSION_TYPES,
    // rust: "minecraft:overworld",
    // rust: r#"{"min_y":-64,"height":2096,"logical_height":384,"has_skylight":true,"has_ceiling":true}"#.into(),
    // rust: );
    // rust: let tall = LevelHeight {
    // rust: min_y: -64,
    // rust: height: 2096,
    // rust: logical_height: 384,
    // rust: has_skylight: true,
    // rust: has_ceiling: true,
}
    // rust: assert_eq!(o.level_height("minecraft:overworld"), Some(tall));
    // rust: let end = o.level_height("minecraft:the_end");
    // rust: assert_eq!(end, LevelHeight::vanilla("minecraft:the_end"));
        // A pack's level stem names another type.
    // rust: o.set(
    // rust: DIMENSIONS,
    // rust: "minecraft:the_end",
    // rust: r#"{"type":"minecraft:overworld"}"#.into(),
    // rust: );
    // rust: assert_eq!(o.level_height("minecraft:the_end"), Some(tall));
        // Ranges the codec refuses.
    // rust: for bad in [
    // rust: r#"{"min_y":-60,"height":384}"#,
    // rust: r#"{"min_y":-64,"height":2112}"#,
    // rust: r#"{"min_y":0,"height":0}"#,
    // rust: r#"{"min_y":0,"height":256,"logical_height":300}"#,
    // rust: ] {
    // rust: o.set(DIMENSION_TYPES, "minecraft:overworld", bad.into());
    // rust: assert_eq!(o.level_height("minecraft:overworld"), None, "{bad}");
}
        // The codec requires has_ceiling: a type without it keeps the pack's
        // fields and the open-sky default.
    // rust: o.set(
    // rust: DIMENSION_TYPES,
    // rust: "minecraft:overworld",
    // rust: r#"{"min_y":-64,"height":384,"logical_height":384,"has_skylight":true}"#.into(),
    // rust: );
    // rust: let open = o.level_height("minecraft:overworld").unwrap();
    // rust: assert!((open.height, open.has_skylight, open.has_ceiling) == (384, true, false));
}

pub fn new_biomes_are_left_out_of_tags_and_climate_points() void {
}
    // rust: let mut o = WorldgenOverrides::default();
    // rust: o.set("biomes", "minecraft:plains", "{}".into());
    // rust: o.set("biomes", "minecraft:molten_peaks", "{}".into());
    // rust: o.add_tag(
    // rust: "biome_tags",
    // rust: "minecraft:is_hill",
    // rust: "file/p",
    // rust: r#"{"values":["minecraft:plains","molten_peaks",{"id":"minecraft:molten_peaks","required":false}]}"#.into(),
    // rust: );
    // rust: o.set(
    // rust: DIMENSIONS,
    // rust: "minecraft:overworld",
    // rust: r#"{"generator":{"biome_source":{"biomes":[{"biome":"minecraft:plains"},{"biome":"minecraft:molten_peaks"}]}}}"#.into(),
    // rust: );
    // rust: let warnings = o.finish(|id| id == "minecraft:plains");
    // rust: assert_eq!(warnings.len(), 2, "{warnings:?}");
    // rust: assert_eq!(o.entries("biomes").count(), 1);
    // rust: let (_, _, tag) = o.tags("biome_tags").next().unwrap();
    // rust: assert_eq!(tag, r#"{"values":["minecraft:plains"]}"#);
    // rust: let (_, stem) = o.entries(DIMENSIONS).next().unwrap();
    // rust: assert!(!stem.contains("molten_peaks") && stem.contains("minecraft:plains"));
}
}
