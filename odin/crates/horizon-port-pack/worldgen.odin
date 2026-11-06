//! Transpiled from Horizon Rust crate
package horizon_port_pack_worldgen

import "core:fmt"
import "core:mem"
import "core:math"

// Structure mods' worldgen, carried over: block and fluid states in 26.3's
// shape, the structure, placement and pool element types of the common
// structure libraries rewritten as vanilla's, and the loader's convention
// biome tags (`c:`) the structures name.
//
// The libraries' types add rules on top of vanilla's. The start and
// placement rules of Repurposed Structures' and Moog's jigsaws (no start in
// liquid, biomes and terrain height in a radius, a minimum distance from
// the world origin, sets to keep away from) are written under `horizon:`
// keys the game reads (`horizon_world::worldgen::structure::start_checks`),
// so those structures start where the mod would. Rules that change how the
// pieces are laid out (piece caps, burying, clipping) are lost and counted
// by name. Each rewrite is counted in the carry report, and every type left
// as it is is listed, so the coverage report can say what generates and how
// closely.
//
// YUNG's API's files are carried as written ([`crate::yung`]).
// Lithostitched's jigsaws, elements, modifiers and processors are carried by
// [`crate::lithostitched`]; the entries CTOV adds to vanilla's structure sets
// by `legacy_structure_mods`, called from [`crate::carry`].
// use crate::{lithostitched, yung};
// use serde_json::Value;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: io::Read,
    // rust: path::{Path, PathBuf},
}

// Structure types that are vanilla's jigsaw with extra start rules.
    // rust: const JIGSAWS: [&str; 2] = [
    // rust: "moogs_structures:moogs_structures_generic_jigsaw_structure",
    // rust: "repurposed_structures:generic_jigsaw_structure",
    // rust: ];
// The Nether variants of the piece-limited jigsaws: laid out the same,
// then moved onto land.
    // rust: const NETHER_JIGSAWS: [&str; 2] = [
    // rust: "moogs_structures:moogs_structures_generic_nether_jigsaw_structure",
    // rust: "repurposed_structures:generic_nether_jigsaw_structure",
    // rust: ];
// Repurposed Structures' generic jigsaws with a start check of their own: the
// `repurposed` key of `horizon:start_checks` names it.
    // rust: const REPURPOSED_CHECKED: [(&str, &str); 3] = [
    // rust: ("repurposed_structures:city_nether_structure", "city_nether"),
    // rust: (
    // rust: "repurposed_structures:shipwreck_nether_structure",
    // rust: "shipwreck_nether",
    // rust: ),
    // rust: ("repurposed_structures:stronghold_end", "stronghold_end"),
    // rust: ];
// Repurposed Structures' mineshaft: its generic jigsaw laid out under the
// terrain (`"layout": "mineshaft"` in `horizon:piece_limited`).
REPURPOSED_MINESHAFT :: "repurposed_structures:generic_mineshaft"
// Layout rules the piece-limited assembler keeps (`horizon:piece_limited`).
    // rust: const PIECE_LIMITED_RULES: [&str; 4] = [
    // rust: "y_allowance",
    // rust: "burying_type",
    // rust: "use_bounding_box_hack",
    // rust: "pools_that_ignore_boundaries",
    // rust: ];
// Placements that are vanilla's random spread with extra rules.
    // rust: const SPREADS: [&str; 2] = [
    // rust: "moogs_structures:advanced_random_spread",
    // rust: "repurposed_structures:advanced_random_spread",
    // rust: ];
// Mo' Structures' placement (`mostructures:type`) takes its spacing and
// separation from the mod's config, not its files: the defaults it writes
// (MoStructuresConfig), by config key, as (spacing, separation).
    // rust: const MO_SPREADS: [(&str, i64, i64); 17] = [
    // rust: ("abandoned_church", 33, 20),
    // rust: ("air_balloon", 22, 12),
    // rust: ("barn_house", 32, 16),
    // rust: ("big_pyramid", 32, 25),
    // rust: ("ice_tower", 28, 20),
    // rust: ("jungle_pyramid", 25, 22),
    // rust: ("killer_bunny_castle", 32, 22),
    // rust: ("lighthouse", 24, 14),
    // rust: ("moai", 17, 15),
    // rust: ("pillager_factory", 34, 16),
    // rust: ("pillager_mines", 40, 27),
    // rust: ("pirate_ship", 32, 16),
    // rust: ("tavern", 26, 16),
    // rust: ("the_castle_in_the_sky", 32, 22),
    // rust: ("villager_market", 32, 16),
    // rust: ("villager_tower", 26, 16),
    // rust: ("sphinx", 24, 16),
    // rust: ];
// Mo' Structures keeps a start out of this many chunks around a start of
// each set in its `structure_set_to_avoid`.
MO_AVOID_CHUNKS :: 3
// Moog's Structure Lib spreads its structures 1.65 times as far apart as
// its files say (AdvancedRandomSpread's constructor).
MOOGS_SPACING :: 1.65
// The jigsaws' start rules and the `horizon:start_checks` key each maps to.
    // rust: const START_RULES: [(&str, &str); 3] = [
    // rust: ("valid_biome_radius_check", "biome_radius"),
    // rust: ("terrain_height_radius_check", "terrain_radius"),
    // rust: ("allowed_terrain_height_range", "terrain_range"),
    // rust: ];
// The jigsaws' rules on laying out pieces, which vanilla's jigsaw has no
// place for.
    // rust: const LAYOUT_RULES: [&str; 4] = [
    // rust: "y_allowance",
    // rust: "burying_type",
    // rust: "use_bounding_box_hack",
    // rust: "pools_that_ignore_boundaries",
    // rust: ];
// The libraries' terrain kernel field, the game's
// `horizon:enhanced_terrain_adaptation` (docs/mods.md).
    // rust: pub(crate) const ENHANCED_TERRAIN: &str = "enhanced_terrain_adaptation";
    // rust: pub(crate) const HORIZON_ENHANCED_TERRAIN: &str = "horizon:enhanced_terrain_adaptation";
// Fields of older versions the mods' codecs no longer read: their own
// structures ignore them, and so does carry. Repurposed's jungle fortress
// and End stronghold still write `vertical_distance_from_start_piece`.
DEAD_FIELDS :: ["vertical_distance_from_start_piece"]
// Pool elements that are vanilla's with extra fields: (mod type, vanilla type).
    // rust: const ELEMENTS: [(&str, &str); 3] = [
    // rust: (
    // rust: "moogs_structures:versioned_single_pool_element",
    // rust: "minecraft:single_pool_element",
    // rust: ),
    // rust: (
    // rust: "repurposed_structures:legacy_ocean_bottom_single_pool_element",
    // rust: "minecraft:legacy_single_pool_element",
    // rust: ),
    // rust: ("empty_pool_element", "minecraft:empty_pool_element"),
    // rust: ];

// What carry-over did to a mod's worldgen files.
Upgrade :: struct {
    // Files rewritten to vanilla types.
    mapped: uint,
    // Files whose block and fluid states were written in 26.3's shape.
    block_states: uint,
    // Types left as they are (Horizon skips what it cannot run), by type.
    unsupported: BTreeMap<string,
    // Rules of mapped types the game does not run, by field.
    rules_lost: BTreeMap<string,
    // Processors written in Java, taken out of their lists, by type.
    processors_dropped: BTreeMap<string,
    // Processors written in Java carried as data the game runs
    // ([`crate::processors`]), by type.
    processors_carried: BTreeMap<string,
    // Rule tests written in Java carried as the game's own
    // ([`crate::processors::rule_tests`]), by type.
    rule_tests_carried: BTreeMap<string,
    // Entries added to other structure sets and template pools
    // (`horizon:add_to`), by the set or pool they join.
    added_to: BTreeMap<string,
    // Lithostitched worldgen modifiers not carried: by type, `conditions`
    // when they need a mod that is not ported along, `target` when they
    // name their sets or pools by a tag.
    modifiers_left: BTreeMap<string,
}

// Where a mod's additions to other sets and pools go in its carry:
// `data/<id>/worldgen/<kind>/horizon_added/<name>.json`.
ADDED :: "horizon_added"

// Rewrites one `data/<ns>/worldgen/<kind>/...` file in place; whether it
// changed.
// `set_tags` are the mod's structure set tags, expanded
// ([`structure_set_tags`]).
    // rust: pub fn upgrade(
    // rust: kind: &str,
    // rust: v: &mut Value,
    // rust: report: &mut Upgrade,
    // rust: set_tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> bool {
    // rust: let states = block_states(v);
    // rust: report.block_states += usize::from(states);
    // rust: let renamed = crate::carry::renamed_ids(v);
    // rust: let dropped = crate::processors::each_list(kind, v, &mut |list| {
    // rust: drop_java_processors(list, &mut report.processors_dropped)
    // rust: });
    // rust: upgrade_types(kind, v, report, set_tags) || states || dropped || renamed
}

// Takes the processors written in Java (any type outside `minecraft:` and
// the game's own `horizon:`) out of a processor list: `{"processors":
// [...]}`, a bare list, or an id (left as it is). The ones with a data form
// were rewritten before ([`crate::processors::carry`]). The game, like vanilla, refuses a list holding a type it
// does not know, and with it every pool that names the list, so without
// this the structure does not generate at all. Without them it generates
// undecorated: no pillars under it, spawners left as the template has
// them, blocks not swapped. Whether anything was taken out.
drop_java_processors :: proc(list: ^Value, dropped: ^BTreeMap<string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(processors) = crate::processors::processors(list) else {
    // rust: return false;
}
    // rust: let before = processors.len();
    // rust: processors.retain(|p| {
    // rust: let t = p["processor_type"].as_str().unwrap_or_default();
    // rust: let java = !t.starts_with("minecraft:")
    // rust: && !t.starts_with("horizon:")
    // rust: && !lithostitched::game_reads(p);
    // rust: if java {
    // rust: *dropped.entry(t.to_owned()).or_default() += 1;
}
    // rust: !java
    // rust: });
    // rust: let mut changed = processors.len() != before;
    // The inline lists inside Lithostitched's apply_random and condition.
    // rust: for p in processors.iter_mut() {
    // rust: let inner: Vec<&mut Value> = match p["processor_type"].as_str() {
    // rust: Some(t) if t.starts_with("lithostitched:") => lithostitched::inner_lists(p),
    // rust: Some("horizon:pillar" | "horizon:bottom_pillar") => {
    // rust: p.get_mut("pillar_processor_list").into_iter().collect()
}
    // rust: _ => Vec::new(),
}
    // rust: for list in inner {
    // rust: changed |= drop_java_processors(list, dropped);
}
}
    // rust: changed
}

// 1.21.1 writes a block or fluid state as `{"Name": ..., "Properties":
// {...}}`; 26.3's codec reads `{"id": ..., "properties": {...}}` and
// refuses the old shape, which fails the processor list, feature or pool
// holding it. Whether anything changed.
block_states :: proc(v: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Object(o) => {
    // rust: let state = o.get("Name").is_some_and(Value::is_string)
    // rust: && o.keys().all(|k| k == "Name" || k == "Properties");
    // rust: if state {
    // rust: if let Some(name) = o.remove("Name") {
    // rust: o.insert("id".into(), name);
}
    // rust: if let Some(properties) = o.remove("Properties") {
    // rust: o.insert("properties".into(), properties);
}
    // rust: return true;
}
    // rust: o.values_mut()
    // rust: .fold(false, |changed, x| block_states(x) | changed)
}
    // rust: Value::Array(a) => a
    // rust: .iter_mut()
    // rust: .fold(false, |changed, x| block_states(x) | changed),
    // rust: _ => false,
}
}

// The library types of one file rewritten as vanilla's; whether it changed.
    // rust: fn upgrade_types(
    // rust: kind: &str,
    // rust: v: &mut Value,
    // rust: report: &mut Upgrade,
    // rust: set_tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> bool {
    // rust: let lost = &mut report.rules_lost;
    // YUNG's and Lithostitched's types are converted apart from this code.
    // rust: if let Some(changed) =
    // rust: yung::upgrade(kind, v, lost).or_else(|| lithostitched::upgrade(kind, v, lost))
    // rust: {
    // rust: report.mapped += usize::from(changed);
    // rust: return changed;
}
    // rust: let mut unsupported = |t: &str| *report.unsupported.entry(t.to_owned()).or_default() += 1;
    // rust: let changed = match kind {
    // rust: "structure" => match v["type"].as_str() {
    // rust: Some(t)
    // rust: if JIGSAWS.contains(&t)
    // rust: || NETHER_JIGSAWS.contains(&t)
    // rust: || t == REPURPOSED_MINESHAFT
    // rust: || REPURPOSED_CHECKED.iter().any(|(r, _)| *r == t) =>
    // rust: {
    // rust: let mineshaft = t == REPURPOSED_MINESHAFT;
    // rust: let check = REPURPOSED_CHECKED.iter().find(|(r, _)| *r == t);
    // rust: let check = check.map(|(_, c)| *c);
    // rust: let library = match t.split_once(':').map(|(ns, _)| ns) {
    // rust: Some("moogs_structures") => Some("moogs"),
    // rust: Some("repurposed_structures") => Some("repurposed"),
    // rust: _ => None,
}
    // rust: let liquid = if library == Some("moogs") {
    // rust: "top"
    // rust: } else {
    // rust: "lowest"
}
    // rust: let mut limited = library.map(|l| piece_limited(v, l));
    // rust: if let Some(limited) = limited.as_mut().filter(|_| mineshaft) {
    // rust: limited["layout"] = "mineshaft".into();
}
    // rust: start_checks(v, liquid, lost, limited.is_some());
    // rust: if library == Some("moogs") {
                    // GenericJigsawStructure's adaptation, NONE by default;
                    // its pieces may still have their own.
    // rust: let own = v.as_object_mut().and_then(|o| o.remove(ENHANCED_TERRAIN));
    // rust: let none = serde_json::json!({"kernel_size": 0, "kernel_distance": 0,
    // rust: "top": "none", "bottom": "none"});
    // rust: let mut kernel = own.and_then(|a| moogs_terrain(&a, lost)).unwrap_or(none);
    // rust: kernel["rigid_junctions"] = false.into();
    // rust: v[HORIZON_ENHANCED_TERRAIN] = kernel;
    // rust: } else if v
    // rust: .as_object_mut()
    // rust: .and_then(|o| o.remove(ENHANCED_TERRAIN))
    // rust: .is_some()
    // rust: {
    // rust: *lost.entry(ENHANCED_TERRAIN.into()).or_default() += 1;
}
    // rust: if let Some(check) = check {
    // rust: if !v["horizon:start_checks"].is_object() {
    // rust: v["horizon:start_checks"] = Value::Object(Default::default());
}
    // rust: v["horizon:start_checks"]["repurposed"] = check.into();
}
    // rust: if let Some(limited) = limited {
    // rust: v["horizon:piece_limited"] = limited;
}
    // rust: v["type"] = "minecraft:jigsaw".into();
    // rust: true
}
            // Mo' Structures' ModStructure: vanilla's jigsaw that starts only
            // where the terrain under the 5×5 chunks around varies by no
            // more than `heightRange` blocks (-1: anywhere).
    // rust: Some("mostructures:generic") => {
    // rust: let range = v
    // rust: .as_object_mut()
    // rust: .and_then(|o| o.remove("heightRange"))
    // rust: .and_then(|r| r.as_i64())
    // rust: .unwrap_or(-1);
    // rust: if range >= 0 {
    // rust: v["horizon:start_checks"] =
    // rust: serde_json::json!({"terrain_radius": 2, "terrain_range": range});
}
    // rust: v["type"] = "minecraft:jigsaw".into();
    // rust: true
}
            // Formations' SimpleStructure: its pool and placement, laid out
            // by the game (`horizon_world::worldgen::structure::formations`).
    // rust: Some("formations:simple") => {
    // rust: v["type"] = "horizon:formations".into();
    // rust: true
}
            // Its PiecedStructure: the same start, then vanilla's jigsaw
            // (`horizon:pieced`).
    // rust: Some("formations:pieced") => {
    // rust: let Some(o) = v.as_object_mut() else {
    // rust: return false;
}
    // rust: let pool = o.remove("start_pool").unwrap_or_default();
    // rust: let mut pieced = serde_json::Map::new();
    // rust: for k in ["max_depth", "max_distance_from_center"] {
    // rust: pieced.insert(k.into(), o.remove(k).unwrap_or_default());
}
    // rust: o.insert("template".into(), pool);
    // rust: o.insert("horizon:pieced".into(), pieced.into());
    // rust: o.insert("type".into(), "horizon:formations".into());
    // rust: true
}
    // rust: Some(t) if !t.starts_with("minecraft:") => {
    // rust: unsupported(t);
    // rust: false
}
    // rust: _ => false,
    // rust: },
    // rust: "structure_set" => match v["placement"]["type"].as_str() {
    // rust: Some(t) if SPREADS.contains(&t) => {
    // rust: let moogs = t.starts_with("moogs_structures:");
    // rust: let p = &mut v["placement"];
    // rust: if moogs {
    // rust: moogs_spacing(p, lost);
}
    // rust: placement_rules(p, set_tags, lost);
    // rust: p["type"] = "minecraft:random_spread".into();
    // rust: true
}
    // rust: Some("mostructures:type") => mo_placement(&mut v["placement"], lost),
    // rust: Some(t) if !t.starts_with("minecraft:") => {
    // rust: unsupported(t);
    // rust: false
}
    // rust: _ => false,
    // rust: },
    // rust: "template_pool" => {
    // rust: let mut changed = false;
    // rust: let mut elements: Vec<&mut Value> = Vec::new();
    // rust: for e in v["elements"].as_array_mut().into_iter().flatten() {
    // rust: let element = &mut e["element"];
                // A list element holds elements of its own.
    // rust: if element.get("elements").is_some_and(Value::is_array) {
    // rust: elements.extend(element["elements"].as_array_mut().into_iter().flatten());
    // rust: } else {
    // rust: elements.push(element);
}
}
    // rust: for element in elements {
    // rust: if yung::upgrade_pool_element(element, lost)
    // rust: || lithostitched::upgrade_pool_element(element, lost)
    // rust: {
    // rust: changed = true;
    // rust: continue;
}
    // rust: let Some(t) = element["element_type"].as_str() else {
    // rust: continue;
}
    // rust: if let Some((_, to)) = ELEMENTS.iter().find(|(from, _)| *from == t) {
    // rust: if t.starts_with("moogs_structures:") {
    // rust: let own = element
    // rust: .as_object_mut()
    // rust: .and_then(|o| o.remove(ENHANCED_TERRAIN));
    // rust: if let Some(kernel) = own.and_then(|a| moogs_terrain(&a, lost)) {
    // rust: element[HORIZON_ENHANCED_TERRAIN] = kernel;
}
}
    // rust: element["element_type"] = (*to).into();
    // rust: changed = true;
    // rust: } else if t == "formations:single_pool_element" {
                    // Vanilla's element with its own ground level (1 when
                    // missing, as its codec reads it).
    // rust: element["element_type"] = "minecraft:single_pool_element".into();
    // rust: if let Some(o) = element.as_object_mut() {
    // rust: let ground = o.remove("ground_level").unwrap_or(1.into());
    // rust: o.insert("horizon:ground_level".into(), ground);
}
    // rust: changed = true;
    // rust: } else if !t.starts_with("minecraft:") {
    // rust: unsupported(t);
}
}
    // rust: changed
}
    // rust: _ => false,
}
    // rust: report.mapped += usize::from(changed);
    // rust: changed
}

// MoogsStructureLib's terrain adaptation: already the game's shape (with
// its band), when it has the fields the game needs (else it is lost, as
// the library's codec would refuse it).
    // rust: pub(crate) fn moogs_terrain(a: &Value, lost: &mut BTreeMap<String, usize>) -> Option<Value> {
    // rust: let ok = ["kernel_size", "kernel_distance"]
    // rust: .iter()
    // rust: .all(|k| a[k].is_u64())
    // rust: && ["top", "bottom"].iter().all(|k| a[k].is_string());
    // rust: if !ok {
    // rust: *lost.entry(ENHANCED_TERRAIN.into()).or_default() += 1;
}
    // rust: ok.then(|| a.clone())
}

// Moves a Repurposed Structures or Moog's jigsaw's start rules under
// `horizon:start_checks`, and counts the layout rules it loses. `liquid` is
// the block its no-start-in-liquid rule reads.
    // rust: pub(crate) fn start_checks(
    // rust: v: &mut Value,
    // rust: liquid: &str,
    // rust: lost: &mut BTreeMap<String, usize>,
    // rust: limited: bool,
    // rust: ) {
    // rust: let Some(o) = v.as_object_mut() else {
    // rust: return;
}
    // rust: let mut checks = serde_json::Map::new();
    // rust: for (from, to) in START_RULES {
    // rust: if let Some(n) = o.remove(from) {
    // rust: checks.insert(to.into(), n);
}
}
    // rust: if o.remove("cannot_spawn_in_liquid").and_then(|b| b.as_bool()) == Some(true) {
    // rust: checks.insert("liquid".into(), liquid.into());
}
    // y_allowance bounds the terrain heights checked; it also clips pieces,
    // which is lost.
    // rust: for (from, to) in [("min_y_allowed", "min_y"), ("max_y_allowed", "max_y")] {
    // rust: if let Some(n) = o.get("y_allowance").and_then(|y| y.get(from)) {
    // rust: checks.insert(to.into(), n.clone());
}
}
    // rust: for field in DEAD_FIELDS {
    // rust: o.remove(field);
}
    // rust: for rule in LAYOUT_RULES {
    // rust: let kept = limited && PIECE_LIMITED_RULES.contains(&rule);
    // rust: if o.remove(rule).is_some_and(|r| r != Value::Bool(false)) && !kept {
    // rust: *lost.entry(rule.into()).or_default() += 1;
}
}
    // rust: if !checks.is_empty() {
    // rust: o.insert("horizon:start_checks".into(), checks.into());
}
}

// A Repurposed Structures or Moog's jigsaw's layout rules for the game's
// piece-limited assembler: y_allowance, burying, the pools whose fallbacks
// ignore the bounds, liquid, and the Nether variants' land search. The
// bounding box hack is vanilla's expansion hack. The pieces' counts are
// added from the mod's count files ([`piece_counts`]).
piece_limited :: proc(v: ^Value, library: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = serde_json::Map::new();
    // rust: out.insert("library".into(), library.into());
    // rust: let lower = |x: &Value| x.as_str().map(str::to_ascii_lowercase);
    // rust: for (from, to) in [("min_y_allowed", "min_y"), ("max_y_allowed", "max_y")] {
    // rust: if let Some(n) = v.get("y_allowance").and_then(|y| y.get(from)) {
    // rust: out.insert(to.into(), n.clone());
}
}
    // rust: if let Some(b) = v.get("burying_type").and_then(lower) {
    // rust: out.insert("burying".into(), b.into());
}
    // rust: if v["cannot_spawn_in_liquid"].as_bool() == Some(true) {
    // rust: out.insert("no_liquid".into(), true.into());
}
    // rust: if let Some(pools) = v
    // rust: .get("pools_that_ignore_boundaries")
    // rust: .filter(|p| p.is_array())
    // rust: {
    // rust: out.insert("ignore_bounds_pools".into(), pools.clone());
}
    // rust: if v["use_bounding_box_hack"].as_bool() == Some(true) {
    // rust: v["use_expansion_hack"] = true.into();
}
    // rust: if let Some(o) = v.as_object_mut() {
    // rust: if let Some(search) = o.remove("land_search_direction") {
    // rust: out.insert("land_search".into(), lower(&search).into());
}
    // rust: if let Some(ledge) = o.remove("ledge_offset_y") {
    // rust: out.insert("ledge_offset_y".into(), ledge);
}
}
    // rust: out.into()
}

// The pieces' spawn counts of the structures a mod ships, by structure id:
// Repurposed Structures' `rs_pieces_spawn_counts` (each file names its
// `target_structure`) and Moog's `msl_pieces_spawn_counts` (the file's id),
// in the game's `horizon:piece_limited` shape.
    // rust: pub fn piece_counts<R: Read + std::io::Seek>(
    // rust: zip: &mut zip::ZipArchive<R>,
    // rust: ) -> BTreeMap<String, Value> {
    // rust: let mut out = BTreeMap::new();
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
    // rust: let (rs, path) = if let Some(p) = rest.strip_prefix("rs_pieces_spawn_counts/") {
    // rust: (true, p)
    // rust: } else if let Some(p) = rest.strip_prefix("msl_pieces_spawn_counts/") {
    // rust: (false, p)
    // rust: } else {
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
    // rust: let id = match v["target_structure"].as_str() {
    // rust: Some(target) if rs => target.to_owned(),
    // rust: _ if rs => continue,
    // rust: _ => format!("{ns}:{path}"),
}
    // rust: let pieces: Vec<Value> = v["pieces_spawn_counts"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|p| {
    // rust: let mut e = serde_json::Map::new();
    // rust: e.insert("name".into(), p["nbt_piece_name"].as_str()?.into());
    // rust: for (from, to) in [
    // rust: ("always_spawn_this_many", "required"),
    // rust: ("never_spawn_more_than_this_many", "max"),
    // rust: ("minimum_distance_from_center_piece", "min_depth"),
    // rust: ] {
    // rust: if let Some(n) = p.get(from).filter(|n| n.is_number()) {
    // rust: e.insert(to.into(), n.clone());
}
}
    // rust: Some(Value::Object(e))
    // rust: })
    // rust: .collect();
    // rust: out.insert(id, pieces.into());
}
    // rust: out
}

// Adds a structure's piece counts to its `horizon:piece_limited` key.
add_piece_counts :: proc(id: string, v: ^Value, counts: ^BTreeMap<string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match (counts.get(id), v.get_mut("horizon:piece_limited")) {
    // rust: (Some(pieces), Some(limited)) => {
    // rust: limited["pieces"] = pieces.clone();
    // rust: true
}
    // rust: _ => false,
}
}

// AdvancedRandomSpread's spacing and separation, as Moog's computes them
// with its default config: 1.65 times the file's, rounded, the separation
// below the spacing. `when_replacing` (other numbers while a preset
// replaces a vanilla structure) is lost.
moogs_spacing :: proc(p: ^Value, lost: ^BTreeMap<string) {
}
    // rust: let scaled = |k: &str| (p[k].as_f64().unwrap_or(0.) * MOOGS_SPACING).round() as i64;
    // rust: let spacing = scaled("spacing").max(1);
    // rust: let separation = scaled("separation").min(spacing - 1);
    // rust: p["spacing"] = spacing.into();
    // rust: p["separation"] = separation.into();
    // rust: if let Some(o) = p.as_object_mut() {
    // rust: if o.remove("when_replacing").is_some() {
    // rust: *lost.entry("when_replacing".into()).or_default() += 1;
}
}
}

// An advanced random spread's minimum distance from the world origin and
// its super exclusion zone (sets named by a tag) under `horizon:` keys.
    // rust: pub(crate) fn placement_rules(
    // rust: p: &mut Value,
    // rust: set_tags: &BTreeMap<String, Vec<String>>,
    // rust: lost: &mut BTreeMap<String, usize>,
    // rust: ) {
    // rust: let Some(o) = p.as_object_mut() else {
    // rust: return;
}
    // rust: if let Some(d) = o.remove("min_distance_from_world_origin") {
    // rust: o.insert("horizon:min_distance_from_world_origin".into(), d);
}
    // rust: let zone = ["super_exclusion_zone", "enhanced_exclusion_zone"]
    // rust: .into_iter()
    // rust: .find_map(|k| Some((k, o.remove(k)?)));
    // rust: if let Some((key, zone)) = zone {
    // rust: let sets: Vec<String> = match &zone["other_set"] {
    // rust: Value::String(s) => match s.strip_prefix('#') {
    // rust: Some(tag) => set_tags.get(tag).cloned().unwrap_or_default(),
    // rust: None => vec![s.clone()],
    // rust: },
    // rust: Value::Array(a) => a
    // rust: .iter()
    // rust: .filter_map(|s| Some(s.as_str()?.to_owned()))
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
    // rust: if sets.is_empty() {
    // rust: *lost.entry(key.into()).or_default() += 1;
    // rust: } else {
    // rust: o.insert(
    // rust: "horizon:exclusion_zone".into(),
    // rust: serde_json::json!({"other_sets": sets, "chunk_count": zone["chunk_count"]}),
    // rust: );
}
}
}

// Mo' Structures' placement as vanilla's random spread: the spacing and
// separation of its config key, and its sets to avoid as
// `horizon:exclusion_zone` tested by their spread alone
// (ModStructurePlacement.exclusionZoneCheck). A key the config does not
// have fails the mod's codec, and the set stays as it is.
mo_placement :: proc(p: ^Value, lost: ^BTreeMap<string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let key = p["config_key"].as_str().unwrap_or_default();
    // rust: let Some(&(_, spacing, separation)) = MO_SPREADS.iter().find(|(k, ..)| *k == key) else {
    // rust: *lost.entry("config_key".into()).or_default() += 1;
    // rust: return false;
}
    // rust: let Some(o) = p.as_object_mut() else {
    // rust: return false;
}
    // rust: o.remove("config_key");
    // rust: o.insert("spacing".into(), spacing.into());
    // rust: o.insert("separation".into(), separation.into());
    // rust: let avoid = o.remove("structure_set_to_avoid");
    // rust: let sets: Vec<Value> = avoid
    // rust: .iter()
    // rust: .flat_map(|a| a.as_array().into_iter().flatten())
    // rust: .filter(|s| s.is_string())
    // rust: .cloned()
    // rust: .collect();
    // rust: if !sets.is_empty() {
    // rust: o.insert(
    // rust: "horizon:exclusion_zone".into(),
    // rust: serde_json::json!({"other_sets": sets, "chunk_count": MO_AVOID_CHUNKS,
    // rust: "their_zones": false}),
    // rust: );
}
    // rust: o.insert("type".into(), "minecraft:random_spread".into());
    // rust: true
}

// The mod's structure set tags (`data/<ns>/tags/worldgen/structure_set/`),
// by tag id, with the tags they include expanded. Optional entries
// (`{"id": ..., "required": false}`) count as their id.
    // rust: pub fn structure_set_tags<R: Read + std::io::Seek>(
    // rust: zip: &mut zip::ZipArchive<R>,
    // rust: ) -> BTreeMap<String, Vec<String>> {
    // rust: let mut raw: BTreeMap<String, Vec<String>> = BTreeMap::new();
    // rust: for i in 0..zip.len() {
    // rust: let Ok(mut entry) = zip.by_index(i) else {
    // rust: continue;
}
    // rust: let Some(id) = entry
    // rust: .name()
    // rust: .ok()
    // rust: .as_deref()
    // rust: .and_then(|n| n.strip_prefix("data/"))
    // rust: .and_then(|r| r.split_once("/tags/worldgen/structure_set/"))
    // rust: .and_then(|(ns, path)| Some(format!("{ns}:{}", path.strip_suffix(".json")?)))
    // rust: else {
    // rust: continue;
}
    // rust: let mut text = String::new();
    // rust: let Ok(v) = entry.read_to_string(&mut text).map_err(drop).and_then(|_| {
    // rust: serde_json::from_str::<Value>(text.trim_start_matches('\u{feff}')).map_err(drop)
    // rust: }) else {
    // rust: continue;
}
    // rust: let values = v["values"].as_array().into_iter().flatten();
    // rust: raw.insert(
    // rust: id,
    // rust: values
    // rust: .filter_map(|e| e.as_str().or_else(|| e["id"].as_str()).map(str::to_owned))
    // rust: .collect(),
    // rust: );
}
    // rust: let expand = |tag: &str| {
    // rust: let (mut out, mut seen, mut todo) = (Vec::new(), BTreeSet::new(), vec![tag.to_owned()]);
    // rust: while let Some(t) = todo.pop() {
    // rust: if !seen.insert(t.clone()) {
    // rust: continue;
}
    // rust: for e in raw.get(&t).into_iter().flatten() {
    // rust: match e.strip_prefix('#') {
    // rust: Some(inner) => todo.push(inner.to_owned()),
    // rust: None if !out.contains(e) => out.push(e.clone()),
    // rust: None => {}
}
}
}
    // rust: out
}
    // rust: raw.keys().map(|t| (t.clone(), expand(t))).collect()
}

// The `#c:` biome tags `v` names.
convention_tags :: proc(v: ^Value, out: ^BTreeSet<string>) {
}
    // rust: match v {
    // rust: Value::String(s) => {
    // rust: if let Some(tag) = s.strip_prefix("#c:") {
    // rust: out.insert(tag.to_owned());
}
}
    // rust: Value::Array(a) => a.iter().for_each(|x| convention_tags(x, out)),
    // rust: Value::Object(o) => o.values().for_each(|x| convention_tags(x, out)),
    // rust: _ => {}
}
}

// The loader's own convention biome tags (`data/c/tags/worldgen/biome/`),
// by path, read from the loader jar `fetch` keeps in `<work>/loader/`.
loader_biome_tags :: proc(work: ^Path) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = BTreeMap::new();
    // rust: let Ok(dir) = std::fs::read_dir(work.join("loader")) else {
    // rust: return out;
}
    // rust: for jar in dir.flatten().map(|e| e.path()) {
    // rust: let Some(mut zip) = std::fs::File::open(&jar)
    // rust: .ok()
    // rust: .and_then(|f| zip::ZipArchive::new(f).ok())
    // rust: else {
    // rust: continue;
}
    // rust: for i in 0..zip.len() {
    // rust: let Ok(mut entry) = zip.by_index(i) else {
    // rust: continue;
}
    // rust: let Some(path) = entry
    // rust: .name()
    // rust: .ok()
    // rust: .as_deref()
    // rust: .and_then(|n| n.strip_prefix("data/c/tags/worldgen/biome/"))
    // rust: .and_then(|p| p.strip_suffix(".json"))
    // rust: .map(str::to_owned)
    // rust: else {
    // rust: continue;
}
    // rust: let mut text = String::new();
    // rust: if entry.read_to_string(&mut text).is_ok() {
    // rust: if let Ok(v) = serde_json::from_str(&text) {
    // rust: out.insert(path, v);
}
}
}
}
    // rust: out
}

// `tags` and the convention tags they include, in `conventions`.
    // rust: pub fn with_included(
    // rust: tags: &BTreeSet<String>,
    // rust: conventions: &BTreeMap<String, Value>,
    // rust: ) -> BTreeSet<String> {
    // rust: let mut all = BTreeSet::new();
    // rust: let mut todo: Vec<String> = tags.iter().cloned().collect();
    // rust: while let Some(tag) = todo.pop() {
    // rust: if !conventions.contains_key(&tag) || !all.insert(tag.clone()) {
    // rust: continue;
}
    // rust: let mut more = BTreeSet::new();
    // rust: convention_tags(&conventions[&tag], &mut more);
    // rust: todo.extend(more);
}
    // rust: all
}

// Where `fetch` keeps the pack's loader jar, and where it comes from:
// NeoForge's own Maven repository. Only NeoForge packs need it today.
loader_jar :: proc(work: ^Path, loader: string, version: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (loader == "neoforge" && !version.is_empty()).then(|| {
    // rust: (
    // rust: work.join("loader").join(format!("neoforge-{version}-universal.jar")),
    // rust: format!(
    // rust: "https://maven.neoforged.net/releases/net/neoforged/neoforge/{version}/neoforge-{version}-universal.jar"
    // rust: ),
    // rust: )
    // rust: })
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

NO_TAGS :: BTreeMap::new()

formations_pieced_structure_keeps_its_jigsaw :: proc() {
}
    // rust: let mut v = json!({"type": "formations:pieced", "start_pool": "fo:fountain/fountains",
    // rust: "max_depth": 2, "max_distance_from_center": 116, "placement": "surface"});
    // rust: let mut report = Upgrade::default();
    // rust: assert!(upgrade("structure", &mut v, &mut report, &BTreeMap::new()));
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"type": "horizon:formations", "template": "fo:fountain/fountains",
    // rust: "placement": "surface",
    // rust: "horizon:pieced": {"max_depth": 2, "max_distance_from_center": 116}})
    // rust: );
    // rust: assert!(report.unsupported.is_empty());
}

formations_become_the_games :: proc() {
}
    // rust: let mut report = Upgrade::default();
    // rust: let mut s = json!({"type": "formations:simple", "template": "f:campsites",
    // rust: "placement": "surface", "biomes": "#f:x", "step": "surface_structures",
    // rust: "terrain_adaptation": "beard_thin", "spawn_overrides": {}});
    // rust: assert!(upgrade("structure", &mut s, &mut report, &NO_TAGS));
    // rust: assert_eq!(s["type"], "horizon:formations");
    // rust: assert_eq!(s["placement"], "surface");
    // rust: let mut pool = json!({"elements": [
    // rust: {"weight": 1, "element": {"element_type": "formations:single_pool_element",
    // rust: "location": "f:a", "projection": "rigid", "ground_level": 6, "processors": []}},
    // rust: {"weight": 1, "element": {"element_type": "formations:single_pool_element",
    // rust: "location": "f:b", "projection": "rigid", "processors": []}}]});
    // rust: assert!(upgrade("template_pool", &mut pool, &mut report, &NO_TAGS));
    // rust: let e = |i: usize| &pool["elements"][i]["element"];
    // rust: assert_eq!(e(0)["element_type"], "minecraft:single_pool_element");
    // rust: assert_eq!(
    // rust: (
    // rust: e(0)["horizon:ground_level"].clone(),
    // rust: e(1)["horizon:ground_level"].clone()
    // rust: ),
    // rust: (json!(6), json!(1))
    // rust: );
    // rust: assert!(e(0).get("ground_level").is_none());
    // rust: assert!(report.unsupported.is_empty());
}

maps_library_types_to_vanillas :: proc() {
}
    // rust: let mut report = Upgrade::default();
    // rust: let mut s = json!({"type": "lithostitched:jigsaw", "start_pool": "a:b"});
    // rust: assert!(upgrade("structure", &mut s, &mut report, &NO_TAGS));
    // rust: assert_eq!(s["type"], "minecraft:jigsaw");
    // rust: let mut other = json!({"type": "somelib:structure"});
    // rust: assert!(!upgrade("structure", &mut other, &mut report, &NO_TAGS));
    // rust: let mut set = json!({"placement": {"type": "moogs_structures:advanced_random_spread",
    // rust: "spacing": 10, "separation": 5, "min_distance_from_world_origin": 250}});
    // rust: assert!(upgrade("structure_set", &mut set, &mut report, &NO_TAGS));
    // rust: assert_eq!(set["placement"]["type"], "minecraft:random_spread");
        // Moog's spreads 1.65 times as far as its file says.
    // rust: assert_eq!(set["placement"]["spacing"], 17);
    // rust: assert_eq!(set["placement"]["separation"], 8);
    // rust: assert_eq!(
    // rust: set["placement"]["horizon:min_distance_from_world_origin"],
    // rust: 250
    // rust: );
    // rust: assert!(
    // rust: set["placement"]
    // rust: .get("min_distance_from_world_origin")
    // rust: .is_none()
    // rust: );
    // rust: let mut pool = json!({"elements": [
    // rust: {"weight": 1, "element": {"element_type": "moogs_structures:versioned_single_pool_element", "location": "m:x",
    // rust: "enhanced_terrain_adaptation": {"kernel_size": 16, "kernel_distance": 8, "top": "carve",
    // rust: "bottom": "carve", "band": {"bottom": 17, "top": 23}}}},
    // rust: {"weight": 1, "element": {"element_type": "minecraft:list_pool_element", "elements": [
    // rust: {"element_type": "empty_pool_element"}]}},
    // rust: {"weight": 1, "element": {"element_type": "somelib:element"}}
    // rust: ]});
    // rust: assert!(upgrade("template_pool", &mut pool, &mut report, &NO_TAGS));
    // rust: assert_eq!(
    // rust: pool["elements"][0]["element"]["element_type"],
    // rust: "minecraft:single_pool_element"
    // rust: );
        // Its own terrain kernel, band and all, under the game's key.
    // rust: assert_eq!(
    // rust: pool["elements"][0]["element"]["horizon:enhanced_terrain_adaptation"]["band"],
    // rust: json!({"bottom": 17, "top": 23})
    // rust: );
    // rust: assert_eq!(
    // rust: pool["elements"][1]["element"]["elements"][0]["element_type"],
    // rust: "minecraft:empty_pool_element"
    // rust: );
    // rust: assert_eq!(report.mapped, 3);
    // rust: assert_eq!(report.block_states, 0);
    // rust: assert_eq!(
    // rust: report.unsupported,
    // rust: BTreeMap::from([
    // rust: ("somelib:element".into(), 1),
    // rust: ("somelib:structure".into(), 1),
    // rust: ])
    // rust: );
}

keeps_the_jigsaws_start_rules :: proc() {
}
    // rust: let mut report = Upgrade::default();
    // rust: let mut moogs = json!({"type": "moogs_structures:moogs_structures_generic_jigsaw_structure",
    // rust: "cannot_spawn_in_liquid": true, "terrain_height_radius_check": 2,
    // rust: "allowed_terrain_height_range": 12, "valid_biome_radius_check": 1,
    // rust: "y_allowance": {"min_y_allowed": 60}, "burying_type": "lowest_corner",
    // rust: "use_bounding_box_hack": false, "size": 7});
    // rust: assert!(upgrade("structure", &mut moogs, &mut report, &NO_TAGS));
    // rust: assert_eq!(
    // rust: moogs["horizon:start_checks"],
    // rust: json!({"liquid": "top", "terrain_radius": 2, "terrain_range": 12,
    // rust: "biome_radius": 1, "min_y": 60})
    // rust: );
    // rust: for gone in [
    // rust: "cannot_spawn_in_liquid",
    // rust: "y_allowance",
    // rust: "burying_type",
    // rust: "use_bounding_box_hack",
    // rust: ] {
    // rust: assert!(moogs.get(gone).is_none(), "{gone}");
}
    // rust: assert_eq!(moogs["size"], 7);
        // GenericJigsawStructure's terrain kernel, NONE when it has none.
    // rust: assert_eq!(
    // rust: moogs["horizon:enhanced_terrain_adaptation"],
    // rust: json!({"kernel_size": 0, "kernel_distance": 0, "top": "none", "bottom": "none",
    // rust: "rigid_junctions": false})
    // rust: );
    // rust: let mut fortress = json!({"type": "moogs_structures:moogs_structures_generic_nether_jigsaw_structure",
    // rust: "size": 7, "enhanced_terrain_adaptation": {"kernel_size": 16, "kernel_distance": 8,
    // rust: "top": "carve", "bottom": "carve", "band": {"bottom": 17, "top": 23,
    // rust: "piece_heights": [24, 25, 27]}}});
    // rust: assert!(upgrade("structure", &mut fortress, &mut report, &NO_TAGS));
    // rust: assert_eq!(
    // rust: fortress["horizon:enhanced_terrain_adaptation"]["band"]["piece_heights"],
    // rust: json!([24, 25, 27])
    // rust: );
    // rust: assert!(fortress.get("enhanced_terrain_adaptation").is_none());
        // Repurposed Structures reads the block above the bottom. Its jungle
        // fortress's vertical distance is a field its code no longer reads.
    // rust: let mut rs = json!({"type": "repurposed_structures:generic_jigsaw_structure",
    // rust: "cannot_spawn_in_liquid": true, "vertical_distance_from_start_piece": 35});
    // rust: assert!(upgrade("structure", &mut rs, &mut report, &NO_TAGS));
    // rust: assert_eq!(rs["horizon:start_checks"], json!({"liquid": "lowest"}));
    // rust: assert!(rs.get("vertical_distance_from_start_piece").is_none());
        // Repurposed's own checks: the Nether city, Nether shipwrecks, the End stronghold.
    // rust: for (t, check) in [
    // rust: ("city_nether_structure", "city_nether"),
    // rust: ("shipwreck_nether_structure", "shipwreck_nether"),
    // rust: ("stronghold_end", "stronghold_end"),
    // rust: ] {
    // rust: let mut rs = json!({"type": format!("repurposed_structures:{t}"),
    // rust: "cannot_spawn_in_liquid": false, "size": 7});
    // rust: assert!(upgrade("structure", &mut rs, &mut report, &NO_TAGS));
    // rust: assert_eq!(rs["type"], "minecraft:jigsaw");
    // rust: assert_eq!(rs["horizon:start_checks"], json!({"repurposed": check}));
    // rust: assert_eq!(rs["horizon:piece_limited"]["library"], "repurposed");
}
    // rust: assert!(report.unsupported.is_empty());
        // Nothing to check: no key.
    // rust: let mut plain = json!({"type": "lithostitched:jigsaw", "cannot_spawn_in_liquid": false});
    // rust: assert!(upgrade("structure", &mut plain, &mut report, &NO_TAGS));
    // rust: assert!(plain.get("horizon:start_checks").is_none());
        // The layout rules go to the piece-limited assembler.
    // rust: assert!(report.rules_lost.is_empty());
    // rust: assert_eq!(
    // rust: moogs["horizon:piece_limited"],
    // rust: json!({"library": "moogs", "min_y": 60, "burying": "lowest_corner",
    // rust: "no_liquid": true})
    // rust: );
}

mo_structures_become_vanillas_jigsaw_and_spread :: proc() {
}
    // rust: let mut report = Upgrade::default();
    // rust: let mut s = json!({"type": "mostructures:generic", "start_pool": "mostructures:a/base",
    // rust: "size": 7, "heightRange": 25, "use_expansion_hack": true,
    // rust: "start_height": {"absolute": 0}, "max_distance_from_center": 80});
    // rust: assert!(upgrade("structure", &mut s, &mut report, &BTreeMap::new()));
    // rust: assert_eq!(s["type"], "minecraft:jigsaw");
    // rust: assert!(s.get("heightRange").is_none());
    // rust: assert_eq!(
    // rust: s["horizon:start_checks"],
    // rust: json!({"terrain_radius": 2, "terrain_range": 25})
    // rust: );
    // rust: let mut anywhere = json!({"type": "mostructures:generic", "heightRange": -1});
    // rust: assert!(upgrade(
    // rust: "structure",
    // rust: &mut anywhere,
    // rust: &mut report,
    // rust: &BTreeMap::new()
    // rust: ));
    // rust: assert!(anywhere.get("horizon:start_checks").is_none());

        // The config's spacing and separation, not the file's.
    // rust: let mut set = json!({"placement": {"type": "mostructures:type", "config_key": "moai",
    // rust: "salt": 12994829, "spacing": 17, "separation": 15,
    // rust: "structure_set_to_avoid": ["minecraft:villages", "mostructures:lighthouse"]}});
    // rust: assert!(upgrade(
    // rust: "structure_set",
    // rust: &mut set,
    // rust: &mut report,
    // rust: &BTreeMap::new()
    // rust: ));
    // rust: assert_eq!(
    // rust: set["placement"],
    // rust: json!({"type": "minecraft:random_spread", "salt": 12994829, "spacing": 17,
    // rust: "separation": 15, "horizon:exclusion_zone": {"chunk_count": 3,
    // rust: "other_sets": ["minecraft:villages", "mostructures:lighthouse"],
    // rust: "their_zones": false}})
    // rust: );
    // rust: let mut set = json!({"placement": {"type": "mostructures:type",
    // rust: "config_key": "jungle_pyramid", "salt": 1, "spacing": 16, "separation": 14}});
    // rust: assert!(upgrade(
    // rust: "structure_set",
    // rust: &mut set,
    // rust: &mut report,
    // rust: &BTreeMap::new()
    // rust: ));
    // rust: assert_eq!(
    // rust: (
    // rust: &set["placement"]["spacing"],
    // rust: &set["placement"]["separation"]
    // rust: ),
    // rust: (&json!(25), &json!(22))
    // rust: );
    // rust: assert!(set["placement"].get("horizon:exclusion_zone").is_none());
    // rust: let mut unknown = json!({"placement": {"type": "mostructures:type", "config_key": "x"}});
    // rust: assert!(!upgrade(
    // rust: "structure_set",
    // rust: &mut unknown,
    // rust: &mut report,
    // rust: &BTreeMap::new()
    // rust: ));
    // rust: assert_eq!(report.rules_lost["config_key"], 1);
}

super_exclusion_zones_name_their_sets :: proc() {
}
    // rust: let mut zip = zip::ZipWriter::new(std::io::Cursor::new(Vec::new()));
    // rust: let opts = zip::write::SimpleFileOptions::default();
    // rust: for (name, text) in [
    // rust: (
    // rust: "data/rs/tags/worldgen/structure_set/avoid.json",
    // rust: r##"{"values": ["minecraft:villages", "#rs:more", {"id": "x:y", "required": false}]}"##,
    // rust: ),
    // rust: (
    // rust: "data/rs/tags/worldgen/structure_set/more.json",
    // rust: r##"{"values": ["minecraft:villages", "rs:cities", "#rs:avoid"]}"##,
    // rust: ),
    // rust: ] {
    // rust: zip.start_file(name, opts).unwrap();
    // rust: std::io::Write::write_all(&mut zip, text.as_bytes()).unwrap();
}
    // rust: let mut zip = zip::ZipArchive::new(zip.finish().unwrap()).unwrap();
    // rust: let tags = structure_set_tags(&mut zip);
    // rust: assert_eq!(tags["rs:avoid"], ["minecraft:villages", "x:y", "rs:cities"]);
    // rust: let mut report = Upgrade::default();
    // rust: let mut set = json!({"placement": {"type": "repurposed_structures:advanced_random_spread",
    // rust: "spacing": 30, "separation": 10,
    // rust: "super_exclusion_zone": {"chunk_count": 4, "other_set": "#rs:avoid"}}});
    // rust: assert!(upgrade("structure_set", &mut set, &mut report, &tags));
    // rust: assert_eq!(set["placement"]["spacing"], 30);
    // rust: assert_eq!(
    // rust: set["placement"]["horizon:exclusion_zone"],
    // rust: json!({"other_sets": ["minecraft:villages", "x:y", "rs:cities"], "chunk_count": 4})
    // rust: );
    // rust: let mut unknown = json!({"placement": {"type": "repurposed_structures:advanced_random_spread",
    // rust: "spacing": 30, "separation": 10,
    // rust: "super_exclusion_zone": {"chunk_count": 4, "other_set": "#rs:none"}}});
    // rust: assert!(upgrade("structure_set", &mut unknown, &mut report, &tags));
    // rust: assert_eq!(report.rules_lost["super_exclusion_zone"], 1);
}

drops_processors_written_in_java :: proc() {
}
    // rust: let mut report = Upgrade::default();
    // rust: let mut list = json!({"processors": [
    // rust: {"processor_type": "repurposed_structures:bottom_pillar_processor"},
    // rust: {"processor_type": "minecraft:gravity", "heightmap": "WORLD_SURFACE_WG", "offset": -1},
    // rust: {"processor_type": "moogs_structures:spawner_randomizing_processor"}]});
    // rust: assert!(upgrade("processor_list", &mut list, &mut report, &NO_TAGS));
    // rust: assert_eq!(
    // rust: list["processors"],
    // rust: json!([{"processor_type": "minecraft:gravity",
    // rust: "heightmap": "WORLD_SURFACE_WG", "offset": -1}])
    // rust: );
    // rust: let mut pool = json!({"elements": [
    // rust: {"weight": 1, "element": {"element_type": "minecraft:single_pool_element",
    // rust: "processors": {"processors": [{"processor_type": "lithostitched:block_swap"}]}}},
    // rust: {"weight": 1, "element": {"element_type": "minecraft:list_pool_element", "elements": [
    // rust: {"element_type": "minecraft:single_pool_element", "processors": "x:named"}]}}]});
    // rust: assert!(upgrade("template_pool", &mut pool, &mut report, &NO_TAGS));
    // rust: assert_eq!(
    // rust: pool["elements"][0]["element"]["processors"],
    // rust: json!({"processors": []})
    // rust: );
    // rust: assert_eq!(
    // rust: pool["elements"][1]["element"]["elements"][0]["processors"],
    // rust: "x:named"
    // rust: );
    // rust: let mut vanilla = json!({"processors": [{"processor_type": "minecraft:nop"}]});
    // rust: assert!(!upgrade(
    // rust: "processor_list",
    // rust: &mut vanilla,
    // rust: &mut report,
    // rust: &NO_TAGS
    // rust: ));
    // rust: assert_eq!(
    // rust: report.processors_dropped,
    // rust: BTreeMap::from([
    // rust: ("lithostitched:block_swap".into(), 1),
    // rust: ("moogs_structures:spawner_randomizing_processor".into(), 1),
    // rust: ("repurposed_structures:bottom_pillar_processor".into(), 1),
    // rust: ])
    // rust: );
}

piece_limited_jigsaws_keep_their_layout :: proc() {
}
    // rust: let mut report = Upgrade::default();
    // rust: let mut nether = json!({"type": "repurposed_structures:generic_nether_jigsaw_structure",
    // rust: "start_pool": "rs:x", "size": 8, "y_allowance": {"min_y_allowed": 40, "max_y_allowed": 90},
    // rust: "cannot_spawn_in_liquid": true, "pools_that_ignore_boundaries": ["rs:roof"],
    // rust: "use_bounding_box_hack": true, "land_search_direction": "HIGHEST_LAND",
    // rust: "ledge_offset_y": 2});
    // rust: assert!(upgrade("structure", &mut nether, &mut report, &NO_TAGS));
    // rust: assert_eq!(nether["type"], "minecraft:jigsaw");
    // rust: assert_eq!(
    // rust: nether["horizon:piece_limited"],
    // rust: json!({"library": "repurposed", "min_y": 40, "max_y": 90, "no_liquid": true,
    // rust: "ignore_bounds_pools": ["rs:roof"], "land_search": "highest_land",
    // rust: "ledge_offset_y": 2})
    // rust: );
    // rust: assert_eq!(nether["use_expansion_hack"], true);
    // rust: for gone in [
    // rust: "y_allowance",
    // rust: "use_bounding_box_hack",
    // rust: "land_search_direction",
    // rust: "ledge_offset_y",
    // rust: ] {
    // rust: assert!(nether.get(gone).is_none(), "{gone}");
}
    // rust: let mut moogs = json!({"type": "moogs_structures:moogs_structures_generic_jigsaw_structure",
    // rust: "burying_type": "AVERAGE_LAND"});
    // rust: assert!(upgrade("structure", &mut moogs, &mut report, &NO_TAGS));
    // rust: assert_eq!(
    // rust: moogs["horizon:piece_limited"],
    // rust: json!({"library": "moogs", "burying": "average_land"})
    // rust: );
        // Repurposed's mineshaft is laid out under the terrain.
    // rust: let mut mineshaft = json!({"type": "repurposed_structures:generic_mineshaft",
    // rust: "start_pool": "rs:mineshafts/birch/start_pool", "size": 9,
    // rust: "liquid_settings": "ignore_waterlogging"});
    // rust: assert!(upgrade("structure", &mut mineshaft, &mut report, &NO_TAGS));
    // rust: assert_eq!(mineshaft["type"], "minecraft:jigsaw");
    // rust: assert_eq!(
    // rust: mineshaft["horizon:piece_limited"],
    // rust: json!({"library": "repurposed", "layout": "mineshaft"})
    // rust: );
    // rust: assert_eq!(mineshaft["liquid_settings"], "ignore_waterlogging");
        // Lithostitched's jigsaw is vanilla's: no key.
    // rust: let mut litho = json!({"type": "lithostitched:jigsaw"});
    // rust: assert!(upgrade("structure", &mut litho, &mut report, &NO_TAGS));
    // rust: assert!(litho.get("horizon:piece_limited").is_none());
    // rust: assert!(report.rules_lost.is_empty(), "{:?}", report.rules_lost);
    // rust: assert!(report.unsupported.is_empty());

    // rust: let mut zip = zip::ZipWriter::new(std::io::Cursor::new(Vec::new()));
    // rust: let opts = zip::write::SimpleFileOptions::default();
    // rust: for (name, text) in [
    // rust: (
    // rust: "data/rs/rs_pieces_spawn_counts/city.json",
    // rust: r#"{"target_structure": "rs:city_nether", "pieces_spawn_counts": [
    // rust: {"nbt_piece_name": "rs:city/center", "always_spawn_this_many": 1,
    // rust: "never_spawn_more_than_this_many": 1, "minimum_distance_from_center_piece": 3}]}"#,
    // rust: ),
    // rust: (
    // rust: "data/mvs/msl_pieces_spawn_counts/tower.json",
    // rust: r#"{"pieces_spawn_counts": [{"nbt_piece_name": "mvs:top", "never_spawn_more_than_this_many": 2}]}"#,
    // rust: ),
    // rust: ] {
    // rust: zip.start_file(name, opts).unwrap();
    // rust: std::io::Write::write_all(&mut zip, text.as_bytes()).unwrap();
}
    // rust: let mut zip = zip::ZipArchive::new(zip.finish().unwrap()).unwrap();
    // rust: let counts = piece_counts(&mut zip);
    // rust: assert_eq!(
    // rust: counts["rs:city_nether"],
    // rust: json!([{"name": "rs:city/center", "required": 1, "max": 1, "min_depth": 3}])
    // rust: );
    // rust: assert_eq!(counts["mvs:tower"], json!([{"name": "mvs:top", "max": 2}]));
    // rust: assert!(add_piece_counts("rs:city_nether", &mut nether, &counts));
    // rust: assert_eq!(nether["horizon:piece_limited"]["pieces"][0]["required"], 1);
    // rust: assert!(!add_piece_counts("rs:other", &mut nether, &counts));
}

writes_block_states_in_26_3_shape :: proc() {
}
    // rust: let mut report = Upgrade::default();
    // rust: let mut list = json!({"processors": [{"processor_type": "minecraft:rule", "rules": [{
    // rust: "input_predicate": {"predicate_type": "minecraft:always_true"},
    // rust: "output_state": {"Name": "minecraft:oak_stairs", "Properties": {"facing": "east"}}}]}]});
    // rust: assert!(upgrade("processor_list", &mut list, &mut report, &NO_TAGS));
    // rust: assert_eq!(
    // rust: list["processors"][0]["rules"][0]["output_state"],
    // rust: json!({"id": "minecraft:oak_stairs", "properties": {"facing": "east"}})
    // rust: );
    // rust: let mut spring = json!({"type": "minecraft:spring_feature", "config": {
    // rust: "state": {"Name": "minecraft:water"}, "valid_blocks": ["minecraft:stone"]}});
    // rust: assert!(upgrade(
    // rust: "configured_feature",
    // rust: &mut spring,
    // rust: &mut report,
    // rust: &NO_TAGS
    // rust: ));
    // rust: assert_eq!(spring["config"]["state"], json!({"id": "minecraft:water"}));
        // An object with other keys is not a state; a 26.3 state is left as it is.
    // rust: let mut other = json!({"Name": "x", "weight": 1, "state": {"id": "minecraft:stone"}});
    // rust: assert!(!upgrade(
    // rust: "configured_feature",
    // rust: &mut other,
    // rust: &mut report,
    // rust: &NO_TAGS
    // rust: ));
    // rust: assert_eq!(report.block_states, 2);
    // rust: assert_eq!(report.mapped, 0);
}

convention_tags_include_theirs :: proc() {
}
    // rust: let conventions = BTreeMap::from([
    // rust: (
    // rust: "is_hot".to_owned(),
    // rust: json!({"values": ["#c:is_desert", "#minecraft:is_badlands"]}),
    // rust: ),
    // rust: (
    // rust: "is_desert".to_owned(),
    // rust: json!({"values": ["minecraft:desert"]}),
    // rust: ),
    // rust: ("is_cold".to_owned(), json!({"values": []})),
    // rust: ]);
    // rust: let mut used = BTreeSet::new();
    // rust: convention_tags(
    // rust: &json!({"biomes": ["#c:is_hot", "#c:unknown", "#minecraft:x"]}),
    // rust: &mut used,
    // rust: );
    // rust: assert_eq!(used, BTreeSet::from(["is_hot".into(), "unknown".into()]));
    // rust: assert_eq!(
    // rust: with_included(&used, &conventions),
    // rust: BTreeSet::from(["is_hot".into(), "is_desert".into()])
    // rust: );
}
}
