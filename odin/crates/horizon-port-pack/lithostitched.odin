//! Transpiled from Horizon Rust crate
package horizon_port_pack_lithostitched

import "core:fmt"
import "core:mem"
import "core:math"

// Lithostitched's worldgen, carried as the game reads it (clean room:
// `cleanroom/structures/spec-lithostitched.md`; CTOV's processor:
// `spec-ctov.md` §4).
//
// - `lithostitched:jigsaw` structures become vanilla's jigsaw. Lithostitched
//   lays jigsaws out its own way (OPEN-L5): Horizon keeps vanilla's layouts.
// - Its processors (`block_swap`, `reference`, `apply_random`, `condition`,
//   `set_block`, `discard_input`) are the game's own types
//   (`horizon_world`'s `structure::processor`): they are carried as written,
//   the processors nested in them carried in turn. CTOV's
//   `ctov:modular_compat` (a reference that runs only when its mod is loaded)
//   becomes a `reference` when the mod is ported along, else nothing.
// - `add_template_pool_elements` and `add_processor_list_processors`
//   modifiers become `horizon:add_to` pool and processor list files
//   (`docs/mods.md`), with their `priority`, when their load conditions pass.
// - Its `limited` and `guaranteed` pool elements are the game's own
//   (`horizon_world`'s `structure::jigsaw`); `delegating` places its
//   `delegate`, and what it adds is counted as lost.
// use crate::{processors::ProcessorData, worldgen::Upgrade};
// use serde_json::{Value, json};
// use std::collections::BTreeMap;

JIGSAW :: "lithostitched:jigsaw"
// Vanilla's JigsawStructure.MAX_DEPTH.
MAX_SIZE :: 20
MODULAR_COMPAT :: "ctov:modular_compat"
// The processor types the game reads.
    // rust: const PROCESSORS: [&str; 6] = [
    // rust: "lithostitched:block_swap",
    // rust: "lithostitched:reference",
    // rust: "lithostitched:apply_random",
    // rust: "lithostitched:condition",
    // rust: "lithostitched:set_block",
    // rust: "lithostitched:discard_input",
    // rust: ];

count :: proc(map: ^BTreeMap<string, name: string) {
}
    // rust: *map.entry(name.to_owned()).or_default() += 1;
}

// A `lithostitched:jigsaw` structure as vanilla's jigsaw: `Some(true)`, else
// `None`.
    // rust: pub(crate) fn upgrade(
    // rust: kind: &str,
    // rust: v: &mut Value,
    // rust: lost: &mut BTreeMap<String, usize>,
    // rust: ) -> Option<bool> {
    // rust: if kind != "structure" || v["type"] != JIGSAW {
    // rust: return None;
}
    // rust: v["type"] = "minecraft:jigsaw".into();
    // `size` may be an int provider (sampled per start): its largest value.
    // rust: let size = match &v["size"] {
    // rust: Value::Null => None,
    // rust: Value::Number(n) => n.as_i64(),
    // rust: provider => {
    // rust: count(lost, "lithostitched:jigsaw size provider");
    // rust: ["max_inclusive", "value"]
    // rust: .iter()
    // rust: .find_map(|k| provider[k].as_i64())
}
}
    // rust: if let Some(size) = size {
    // rust: if size > MAX_SIZE {
    // rust: count(lost, "lithostitched:jigsaw size over 20");
}
    // rust: v["size"] = size.clamp(0, MAX_SIZE).into();
}
    // rust: let o = v.as_object_mut()?;
    // rust: match o.remove("start_projection") {
    // rust: Some(Value::String(heightmap)) if heightmap != "floor" && heightmap != "ceiling" => {
    // rust: o.entry("project_start_to_heightmap")
    // rust: .or_insert(heightmap.into());
}
    // rust: Some(_) => count(lost, "lithostitched:jigsaw start_projection"),
    // rust: None => {}
}
    // rust: if o.remove("fixed_rotation").is_some_and(|f| f == true) {
    // rust: count(lost, "lithostitched:jigsaw fixed_rotation");
}
    // rust: Some(true)
}

// Lithostitched's pool elements as the element they wrap; whether `element`
// was one.
    // rust: pub(crate) fn upgrade_pool_element(
    // rust: element: &mut Value,
    // rust: lost: &mut BTreeMap<String, usize>,
    // rust: ) -> bool {
    // rust: let Some(kind) = element["element_type"].as_str() else {
    // rust: return false;
}
    // rust: let unwrap = match kind {
    // rust: "lithostitched:guaranteed" => false,
        // A `limit` is what it adds (spec-lithostitched §3).
    // rust: "lithostitched:limited" => element["limit"].as_i64().is_none(),
    // rust: "lithostitched:delegating" => true,
    // rust: _ => return false,
}
    // rust: if unwrap {
    // rust: count(lost, kind);
    // rust: let delegate = element["delegate"].take();
    // rust: *element = delegate;
        // A delegate wrapping another (only `delegating` allows it).
    // rust: upgrade_pool_element(element, lost);
}
    // rust: true
}

// The ids a modifier targets: an id or a list of ids (`None` for tags and
// Lithostitched's object forms).
ids :: proc(v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let id = |v: &Value| {
    // rust: v.as_str()
    // rust: .filter(|s| !s.starts_with('#'))
    // rust: .map(str::to_owned)
}
    // rust: match v {
    // rust: Value::Array(a) => a.iter().map(id).collect(),
    // rust: other => Some(vec![id(other)?]),
}
}

// NeoForge's load conditions (`neoforge:conditions`): all must pass.
conditions_pass :: proc(v: ^Value, loaded: ^dyn Fn(string) -> b {
    // Ported from Horizon
    return {}
}
pass :: proc(c: ^Value, loaded: ^dyn Fn(string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let all = |key: &str| {
    // rust: c[key]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|c| pass(c, loaded))
}
    // rust: match c["type"].as_str() {
    // rust: Some("neoforge:mod_loaded") => c["modid"].as_str().is_some_and(loaded),
    // rust: Some("neoforge:true") => true,
    // rust: Some("neoforge:not") => !pass(&c["value"], loaded),
    // rust: Some("neoforge:and") => all("values"),
    // rust: Some("neoforge:or") => {
    // rust: (c["values"].as_array().into_iter().flatten()).any(|c| pass(c, loaded))
}
    // rust: _ => false,
}
}
    // rust: (v["neoforge:conditions"].as_array().into_iter().flatten()).all(|c| pass(c, loaded))
}

// A worldgen modifier as a file the game merges: `("template_pool", file)`
// for `add_template_pool_elements`, `("processor_list", file)` for
// `add_processor_list_processors` (spec-lithostitched §2.1, §2.2); the
// others are counted in `report.modifiers_left`.
    // rust: pub(crate) fn modifier(
    // rust: v: &Value,
    // rust: loaded: &dyn Fn(&str) -> bool,
    // rust: report: &mut Upgrade,
    // rust: ) -> Option<(&'static str, Value)> {
    // rust: let kind = v["type"].as_str().unwrap_or("no type");
    // rust: if !conditions_pass(v, loaded) {
    // rust: count(&mut report.modifiers_left, "conditions");
    // rust: return None;
}
    // 1.8.1 reads `processor_lists`, not the wiki's `processor_list`.
    // rust: let (to, targets, list) = match kind {
    // rust: "lithostitched:add_template_pool_elements" => {
    // rust: ("template_pool", "template_pools", "elements")
}
    // rust: "lithostitched:add_processor_list_processors" => {
    // rust: ("processor_list", "processor_lists", "processors")
}
    // rust: _ => {
    // rust: count(&mut report.modifiers_left, kind);
    // rust: return None;
}
}
    // rust: let (Some(targets), Some(entries)) = (ids(&v[targets]), v[list].as_array()) else {
    // rust: count(&mut report.modifiers_left, "target");
    // rust: return None;
}
    // rust: for target in &targets {
    // rust: *report.added_to.entry(target.clone()).or_default() += entries.len();
}
    // rust: let mut file = json!({"horizon:add_to": targets, list: entries});
    // rust: if let Some(priority) = v["priority"].as_i64() {
    // rust: file["horizon:priority"] = priority.into();
}
    // rust: Some((to, file))
}

// Whether the game reads a Lithostitched processor as it is: one of its
// types, with no processor list named by tag (the game has no processor
// list tags) and a state provider it runs.
    // rust: pub(crate) fn game_reads(p: &Value) -> bool {
    // rust: let Some(kind) = p["processor_type"]
    // rust: .as_str()
    // rust: .filter(|t| PROCESSORS.contains(t))
    // rust: else {
    // rust: return false;
}
    // rust: let tag = |v: &Value| v.as_str().is_some_and(|s| s.starts_with('#'));
    // rust: match kind {
    // rust: "lithostitched:reference" => match &p["processor_lists"] {
    // rust: Value::Array(a) => !a.iter().any(tag),
    // rust: other => other.is_string() && !tag(other),
    // rust: },
    // rust: "lithostitched:apply_random" => p["processor_lists"]
    // rust: .as_array()
    // rust: .is_some_and(|a| a.iter().all(|e| !tag(e) && !tag(&e["data"]))),
    // rust: "lithostitched:set_block" => matches!(
    // rust: p["state_provider"]["type"].as_str(),
    // rust: Some("minecraft:simple_state_provider" | "minecraft:weighted_state_provider")
    // rust: ),
    // rust: "lithostitched:block_swap" => p["blocks"].is_object(),
    // rust: "lithostitched:condition" => !p["if_true"].is_null(),
    // rust: _ => true,
}
}

// The processor lists inside a Lithostitched processor, for the general
// code that walks lists (`then`, `else`, `apply_random`'s inline data).
    // rust: pub(crate) fn inner_lists(p: &mut Value) -> Vec<&mut Value> {
    // rust: match p["processor_type"].as_str() {
    // rust: Some("lithostitched:apply_random") => (p["processor_lists"].as_array_mut().into_iter())
    // rust: .flatten()
    // rust: .filter_map(|e| e.get_mut("data").filter(|d| !d.is_string()))
    // rust: .collect(),
    // rust: Some("lithostitched:condition") => (p.as_object_mut().into_iter())
    // rust: .flat_map(|o| o.iter_mut())
    // rust: .filter(|(k, _)| *k == "then" || *k == "else")
    // rust: .map(|(_, v)| v)
    // rust: .collect(),
    // rust: _ => Vec::new(),
}
}

// A Lithostitched processor with the processors nested in it carried
// (`Some`, when one of them changed); `None` for any other processor.
    // rust: pub(crate) fn processor(
    // rust: kind: &str,
    // rust: p: &Value,
    // rust: data: &ProcessorData,
    // rust: carried: &mut BTreeMap<String, usize>,
    // rust: ) -> Option<Vec<Value>> {
    // rust: if !PROCESSORS.contains(&kind) {
    // rust: return None;
}
    // rust: let mut out = p.clone();
    // rust: let mut changed = false;
    // rust: for list in inner_lists(&mut out) {
        // One processor alone is a list of one.
    // rust: if list.get("processor_type").is_some() {
    // rust: *list = Value::Array(vec![list.take()]);
    // rust: changed = true;
}
    // rust: if let Some(processors) = crate::processors::processors(list) {
    // rust: let (inner, inner_changed) =
    // rust: crate::processors::carry_all(std::mem::take(processors), data, carried);
    // rust: *processors = inner;
    // rust: changed |= inner_changed;
}
}
    // rust: changed.then(|| vec![out])
}

// The list with CTOV's modular compat processors written as the game's
// `reference` (its mod is ported along) or taken out; whether any was.
    // rust: pub(crate) fn expand_references(
    // rust: list: Vec<Value>,
    // rust: data: &ProcessorData,
    // rust: carried: &mut BTreeMap<String, usize>,
    // rust: ) -> (Vec<Value>, bool) {
    // rust: let mut changed = false;
    // rust: let mut out = Vec::with_capacity(list.len());
    // rust: for p in list {
    // rust: if p["processor_type"] != MODULAR_COMPAT {
    // rust: out.push(p);
    // rust: continue;
}
    // rust: changed = true;
    // rust: count(carried, MODULAR_COMPAT);
    // rust: let loaded = p["modid"]
    // rust: .as_str()
    // rust: .is_some_and(|m| data.compat_loaded.contains(m));
    // rust: if loaded {
    // rust: out.push(json!({"processor_type": "lithostitched:reference",
    // rust: "processor_lists": p["reference"].clone()}));
}
}
    // rust: (out, changed)
}

// Notes which mods CTOV's modular compat processors name are `loaded`.
    // rust: pub(crate) fn mark_loaded(data: &mut ProcessorData, loaded: &dyn Fn(&str) -> bool) {
visit :: proc(v: ^Value, out: ^[dynamic]string) {
}
    // rust: match v {
    // rust: Value::Object(o) => {
    // rust: if o.get("processor_type").and_then(Value::as_str) == Some(MODULAR_COMPAT)
    // rust: && let Some(m) = o.get("modid").and_then(Value::as_str)
    // rust: {
    // rust: out.push(m.to_owned());
}
    // rust: o.values().for_each(|v| visit(v, out));
}
    // rust: Value::Array(a) => a.iter().for_each(|v| visit(v, out)),
    // rust: _ => {}
}
}
    // rust: let mut named = Vec::new();
    // rust: data.lists.values().for_each(|l| visit(l, &mut named));
    // rust: data.compat_loaded
    // rust: .extend(named.into_iter().filter(|m| loaded(m)));
}

    // rust: mod tests {
//     use super::*;
//     use crate::worldgen::upgrade as upgrade_file;

jigsaws_become_vanillas :: proc() {
}
    // rust: let mut lost = BTreeMap::new();
    // rust: let mut s = json!({"type": JIGSAW, "size": {"type": "uniform", "min_inclusive": 3,
    // rust: "max_inclusive": 40}, "start_projection": "WORLD_SURFACE_WG", "fixed_rotation": true});
    // rust: assert_eq!(upgrade("structure", &mut s, &mut lost), Some(true));
    // rust: assert_eq!(
    // rust: s,
    // rust: json!({"type": "minecraft:jigsaw", "size": 20,
    // rust: "project_start_to_heightmap": "WORLD_SURFACE_WG"})
    // rust: );
    // rust: assert_eq!(lost.len(), 3);
    // rust: assert_eq!(
    // rust: upgrade(
    // rust: "structure",
    // rust: &mut json!({"type": "minecraft:jigsaw"}),
    // rust: &mut lost
    // rust: ),
    // rust: None
    // rust: );
}

limited_and_guaranteed_elements_stay_theirs :: proc() {
}
    // rust: let mut lost = BTreeMap::new();
    // rust: let delegate = json!({"element_type": "minecraft:single_pool_element", "location": "a:b",
    // rust: "projection": "rigid", "processors": "minecraft:empty"});
    // rust: for kept in [
    // rust: json!({"element_type": "lithostitched:limited", "limit": 1, "delegate": delegate}),
    // rust: json!({"element_type": "lithostitched:guaranteed", "count": 1, "min_depth": 3,
    // rust: "delegate": delegate}),
    // rust: ] {
    // rust: let mut e = kept.clone();
    // rust: assert!(upgrade_pool_element(&mut e, &mut lost));
    // rust: assert_eq!(e, kept);
}
    // rust: assert!(lost.is_empty());
        // Without a limit, and `delegating`: the delegate, the rest counted.
    // rust: for kind in ["lithostitched:limited", "lithostitched:delegating"] {
    // rust: let mut e = json!({"element_type": kind, "delegate": delegate});
    // rust: assert!(upgrade_pool_element(&mut e, &mut lost));
    // rust: assert_eq!(e, delegate);
    // rust: assert_eq!(lost[kind], 1);
}
    // rust: assert!(!upgrade_pool_element(&mut delegate.clone(), &mut lost));
}

modifiers_add_to_pools_when_their_mods_are_loaded :: proc() {
}
    // rust: let mut report = Upgrade::default();
    // rust: let loaded = |m: &str| m == "waystones";
    // rust: let add = |modid: &str, pools: Value| {
    // rust: json!({"type": "lithostitched:add_template_pool_elements", "template_pools": pools,
    // rust: "elements": [{"weight": 2, "element": {"element_type": "minecraft:empty_pool_element"}}],
    // rust: "neoforge:conditions": [{"type": "neoforge:mod_loaded", "modid": modid}]})
}
    // rust: let (kind, file) = modifier(
    // rust: &add("waystones", json!("ctov:village/plains/house")),
    // rust: &loaded,
    // rust: &mut report,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(kind, "template_pool");
    // rust: assert_eq!(file["horizon:add_to"], json!(["ctov:village/plains/house"]));
    // rust: assert_eq!(file["elements"][0]["weight"], 2);
    // rust: assert_eq!(report.added_to["ctov:village/plains/house"], 1);
    // rust: assert!(modifier(&add("sawmill", json!("a:b")), &loaded, &mut report).is_none());
    // rust: assert!(modifier(&add("waystones", json!("#a:pools")), &loaded, &mut report).is_none());
    // rust: let aliases = json!({"type": "lithostitched:set_pool_aliases"});
    // rust: assert!(modifier(&aliases, &loaded, &mut report).is_none());
        // Processors appended to lists, with the modifier's priority; 1.8.1
        // reads `processor_lists` (spec-lithostitched §2.2).
    // rust: let nop = json!([{"processor_type": "minecraft:nop"}]);
    // rust: let processors = json!({"type": "lithostitched:add_processor_list_processors",
    // rust: "priority": 10, "processor_lists": ["minecraft:mossify_10_percent"], "processors": nop});
    // rust: let (kind, file) = modifier(&processors, &loaded, &mut report).unwrap();
    // rust: assert_eq!(kind, "processor_list");
    // rust: assert_eq!(
    // rust: file,
    // rust: json!({"horizon:add_to": ["minecraft:mossify_10_percent"], "processors": nop,
    // rust: "horizon:priority": 10})
    // rust: );
    // rust: let wiki = json!({"type": "lithostitched:add_processor_list_processors",
    // rust: "processor_list": "minecraft:mossify_10_percent", "processors": nop});
    // rust: assert!(modifier(&wiki, &loaded, &mut report).is_none());
    // rust: assert_eq!(
    // rust: report.modifiers_left,
    // rust: BTreeMap::from([
    // rust: ("conditions".into(), 1),
    // rust: ("lithostitched:set_pool_aliases".into(), 1),
    // rust: ("target".into(), 2),
    // rust: ])
    // rust: );
}

    // A CTOV list (spec-ctov §4): references, a condition with a single
    // processor and a nested condition, a random list holding the compat
    // hook, and processors the game cannot read.
processors_stay_lithostitcheds_with_their_insides_carried :: proc() {
}
    // rust: let hook = json!({"processor_type": MODULAR_COMPAT, "modid": "natures_spirit",
    // rust: "reference": "ctov:village/mesa/house_wisteria"});
    // rust: let list = json!({"processors": [
    // rust: {"processor_type": "lithostitched:reference", "processor_lists": ["ctov:village/mesa/house"]},
    // rust: {"processor_type": "lithostitched:condition", "random_mode": "per_block",
    // rust: "if_true": {"type": "lithostitched:matching_blocks", "blocks": "minecraft:water",
    // rust: "match_type": "location"},
    // rust: "then": {"processor_type": "lithostitched:set_block", "state_provider": {
    // rust: "type": "minecraft:simple_state_provider", "state": {"Name": "minecraft:spruce_planks"}}},
    // rust: "else": [{"processor_type": "somemod:java_processor"}]},
    // rust: {"processor_type": "lithostitched:apply_random", "mode": "per_piece", "processor_lists": [
    // rust: {"weight": 1, "data": "minecraft:empty"},
    // rust: {"weight": 1, "data": {"processors": [hook]}}]},
    // rust: {"processor_type": "lithostitched:reference", "processor_lists": "#ctov:palettes"},
    // rust: {"processor_type": "lithostitched:set_block", "state_provider": {
    // rust: "type": "minecraft:noise_provider"}}]});
    // rust: for (loaded, wisteria) in [
    // rust: (false, json!([])),
    // rust: (
    // rust: true,
    // rust: json!([{"processor_type":
    // rust: "lithostitched:reference", "processor_lists": "ctov:village/mesa/house_wisteria"}]),
    // rust: ),
    // rust: ] {
    // rust: let mut data = ProcessorData::default();
    // rust: data.lists
    // rust: .insert("ctov:village/mesa/house".into(), list.clone());
    // rust: mark_loaded(&mut data, &|m| loaded && m == "natures_spirit");
    // rust: let mut v = list.clone();
    // rust: let mut report = Upgrade::default();
    // rust: crate::processors::carry(
    // rust: "processor_list",
    // rust: &mut v,
    // rust: &data,
    // rust: &mut report.processors_carried,
    // rust: );
    // rust: upgrade_file("processor_list", &mut v, &mut report, &BTreeMap::new());
    // rust: let p = &v["processors"];
    // rust: assert_eq!(p.as_array().unwrap().len(), 3, "{p}");
    // rust: assert_eq!(p[0], list["processors"][0]);
            // One processor is a list of one; the Java one is taken out.
    // rust: assert_eq!(
    // rust: p[1]["then"][0]["state_provider"]["state"]["id"],
    // rust: "minecraft:spruce_planks"
    // rust: );
    // rust: assert_eq!(p[1]["else"], json!([]));
    // rust: assert_eq!(p[2]["processor_lists"][0]["data"], "minecraft:empty");
    // rust: assert_eq!(p[2]["processor_lists"][1]["data"]["processors"], wisteria);
    // rust: assert_eq!(report.processors_carried[MODULAR_COMPAT], 1);
    // rust: assert_eq!(
    // rust: report.processors_dropped,
    // rust: BTreeMap::from([
    // rust: ("lithostitched:reference".into(), 1),
    // rust: ("lithostitched:set_block".into(), 1),
    // rust: ("somemod:java_processor".into(), 1),
    // rust: ])
    // rust: );
}
}
}
