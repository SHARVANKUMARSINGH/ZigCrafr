//! Transpiled from Horizon Rust crate
package horizon_port_pack_mod

import "core:fmt"
import "core:mem"
import "core:math"

// A 26.2 data pack's world generation, rewritten in 26.3's formats.
//
// 26.3 reworked the worldgen registries: configured carvers and features
// became `carver` and `feature` with their `config` unwrapped, noise
// parameters gained a base amplitude, density functions name their inputs
// `input`/`left`/`right`, the noise settings moved aquifers, ore veins and
// the surface rule out of the router into an `aquifers` object and a
// `material_rule`, and biomes carry their mob spawns as attributes. Each
// conversion here is the one vanilla's own data went through between 26.2
// and 26.3, written so that the 26.3 pack generates what the 26.2 pack did:
// the hard-coded parts of 26.2 (the beardifier added to the final density,
// the deep dark aquifer exclusion, the ore veinifier, the interpolation
// cell from `size_horizontal`/`size_vertical`) are spelled out as data.
// Whatever has no faithful 26.3 form is kept as it is and listed in the
// report.
    // rust: mod density;
    // rust: mod features;
    // rust: mod noise;
    // rust: mod registries;
    // rust: mod settings;

// use density::Context;
// use noise::noise;
    // rust: pub use noise::parity_base_amplitude;
// use registries::{biome, carver, dimension_type, structure};
// use serde_json::{Value, json};
// use std::{collections::BTreeMap, fs, io::Read, path::Path};

// 26.3's data pack format (`version.json`'s `pack_version.data_major`).
PACK_FORMAT :: 121

// What the upgrade did and what it could not do faithfully.
Report :: struct {
    // Files rewritten, per registry.
    upgraded: BTreeMap<string,
    // Files written that the 26.2 pack did not have (named density
    // functions the noise settings share).
    added: [dynamic]string,
    // Parts that changed meaning or were dropped, with how often.
    lossy: BTreeMap<string,
    // Types the upgrade does not know, left as they are.
    unknown: BTreeMap<string,
}

    // rust: impl Report {
lossy :: proc(self: ^Self, what: impl Into<string>) {
}
    // rust: *self.lossy.entry(what.into()).or_default() += 1;
}
unknown :: proc(self: ^Self, what: impl Into<string>) {
}
    // rust: *self.unknown.entry(what.into()).or_default() += 1;
}
}

// Every file of a pack, by its path inside the pack (`data/...`,
// `pack.mcmeta`), upgraded. Files outside world generation are kept as
// they are.
upgrade_pack :: proc(files: ^BTreeMap<string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut report = Report::default();
    // rust: let mut json: BTreeMap<String, Value> = BTreeMap::new();
    // rust: let mut out: BTreeMap<String, Vec<u8>> = BTreeMap::new();
    // rust: for (path, bytes) in files {
    // rust: let parsed = path
    // rust: .ends_with(".json")
    // rust: .then(|| serde_json::from_slice::<Value>(bytes).ok())
    // rust: .flatten();
    // rust: match parsed {
    // rust: Some(v) if path.starts_with("data/") => {
    // rust: json.insert(path.clone(), v);
}
    // rust: _ => {
    // rust: out.insert(path.clone(), bytes.clone());
}
}
}
    // rust: let mut ctx = Context::new(&json);
    // rust: let mut written: BTreeMap<String, Value> = BTreeMap::new();
    // rust: for (path, v) in &json {
    // rust: let Some(file) = PackFile::parse(path) else {
    // rust: written.insert(path.clone(), v.clone());
    // rust: continue;
}
    // rust: let upgraded = match file.registry.as_str() {
    // rust: "worldgen/noise" => Some(noise(v, &mut report)),
    // rust: "worldgen/density_function" => Some(ctx.named_function(&file.id(), v, &mut report)),
    // rust: "worldgen/noise_settings" => Some(ctx.settings(&file.id(), v, &mut report)),
    // rust: "worldgen/configured_carver" => Some(carver(v, &mut report)),
    // rust: "worldgen/configured_feature" => Some(features::feature(v, &mut report)),
    // rust: "worldgen/placed_feature" => Some(features::placed(v, &mut report)),
    // rust: "worldgen/biome" => Some(biome(v, &mut report)),
    // rust: "worldgen/structure" => Some(structure(v)),
    // rust: "worldgen/world_preset" => Some(ctx.world_preset(v, &mut report)),
    // rust: "dimension" => Some(ctx.dimension(v, &mut report)),
    // rust: "dimension_type" => Some(dimension_type(v)),
    // rust: "worldgen/template_pool" | "worldgen/processor_list" => {
    // rust: let mut v = v.clone();
    // rust: states(&mut v);
    // rust: Some(v)
}
    // rust: _ => None,
}
    // rust: let path = match file.registry.as_str() {
    // rust: "worldgen/configured_carver" => file.with_registry("worldgen/carver"),
    // rust: "worldgen/configured_feature" => file.with_registry("worldgen/feature"),
    // rust: _ => path.clone(),
}
    // rust: match upgraded {
    // rust: Some(u) => {
    // rust: *report.upgraded.entry(file.registry.clone()).or_default() += 1;
    // rust: written.insert(path, u);
}
    // rust: None => {
    // rust: written.insert(path, v.clone());
}
}
}
    // rust: for (id, v) in std::mem::take(&mut ctx.generated) {
    // rust: let path = registry_path("worldgen/density_function", &id);
    // rust: report.added.push(path.clone());
    // rust: written.insert(path, v);
}
    // rust: for (id, v) in std::mem::take(&mut ctx.rules) {
    // rust: let path = registry_path("worldgen/material_rule", &id);
    // rust: report.added.push(path.clone());
    // rust: written.insert(path, v);
}
    // rust: for (path, v) in written {
    // rust: out.insert(path, pretty(&v));
}
    // rust: if let Some(meta) = out
    // rust: .get("pack.mcmeta")
    // rust: .and_then(|b| serde_json::from_slice(b).ok())
    // rust: {
    // rust: out.insert("pack.mcmeta".into(), pretty(&mcmeta(meta)));
}
    // rust: (out, report)
}

pretty :: proc(v: ^Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut bytes = serde_json::to_vec_pretty(v).unwrap_or_default();
    // rust: bytes.push(b'\n');
    // rust: bytes
}

// `pack.mcmeta` for 26.3: the pack format range is 26.3's alone.
mcmeta :: proc(mut meta: Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(pack) = meta.get_mut("pack").and_then(Value::as_object_mut) {
    // rust: pack.remove("supported_formats");
    // rust: pack.insert("pack_format".into(), json!(PACK_FORMAT));
    // rust: pack.insert("min_format".into(), json!(PACK_FORMAT));
    // rust: pack.insert("max_format".into(), json!(PACK_FORMAT));
    // rust: if let Some(Value::String(d)) = pack.get_mut("description") {
    // rust: d.push_str(" (upgraded to 26.3)");
}
}
    // rust: meta
}

// `data/<ns>/<registry...>/<path>.json`, split by the registries the
// upgrade knows (a registry name has one or two segments).
PackFile :: struct {
    namespace: string,
    registry: string,
    path: string,
}

    // rust: impl PackFile {
parse :: proc(path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let rest = path.strip_prefix("data/")?.strip_suffix(".json")?;
    // rust: let (namespace, rest) = rest.split_once('/')?;
    // rust: let (registry, path) = if let Some(r) = rest.strip_prefix("worldgen/") {
    // rust: let (kind, path) = r.split_once('/')?;
    // rust: (format!("worldgen/{kind}"), path)
    // rust: } else {
    // rust: rest.split_once('/').map(|(k, p)| (k.to_owned(), p))?
}
    // rust: Some(Self {
    // rust: namespace: namespace.into(),
    // rust: registry,
    // rust: path: path.into(),
    // rust: })
}
id :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{}:{}", self.namespace, self.path)
}
with_registry :: proc(self: ^Self, registry: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("data/{}/{registry}/{}.json", self.namespace, self.path)
}
}

registry_path :: proc(registry: string, id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: format!("data/{ns}/{registry}/{path}.json")
}

// A type name without its `minecraft:` prefix, as the codecs read both.
kind :: proc(v: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let t = v.get("type")?.as_str()?;
    // rust: Some(t.strip_prefix("minecraft:").unwrap_or(t))
}

// An id with its namespace (`minecraft:` when it has none).
full_id :: proc(id: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if id.contains(':') {
    // rust: id.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{id}")
}
}

// Whether an object of type `t` appears anywhere in `v`.
contains_type :: proc(v: ^Value, t: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Value::Object(o) => kind(v) == Some(t) || o.values().any(|x| contains_type(x, t)),
    // rust: Value::Array(a) => a.iter().any(|x| contains_type(x, t)),
    // rust: _ => false,
}
}

vanilla :: proc(name: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Value::String(format!("minecraft:{name}"))
}

// ---------------------------------------------------------------------------
// Block states

// 26.2 writes a block or fluid state as `{"Name": ..., "Properties":
// {...}}`; 26.3 reads `{"id": ..., "properties": {...}}` (or the id alone
// for the default state).
states :: proc(v: ^Value) {
}
    // rust: match v {
    // rust: Value::Object(o) => {
    // rust: let state = o.get("Name").is_some_and(Value::is_string)
    // rust: && o.keys().all(|k| k == "Name" || k == "Properties");
    // rust: if state {
    // rust: let name = o.remove("Name").unwrap_or_default();
    // rust: match o.remove("Properties") {
    // rust: Some(Value::Object(p)) if !p.is_empty() => {
    // rust: o.insert("id".into(), name);
    // rust: o.insert("properties".into(), Value::Object(p));
}
    // rust: _ => *v = name,
}
    // rust: return;
}
    // rust: o.values_mut().for_each(states);
}
    // rust: Value::Array(a) => a.iter_mut().for_each(states),
    // rust: _ => {}
}
}

// ---------------------------------------------------------------------------
// Files

// A pack's files by their path inside it, from a zip or a folder. A zip
// whose `pack.mcmeta` sits in one top folder is read from that folder.
read_pack :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let at = |e: &dyn std::fmt::Display| format!("{}: {e}", path.display());
    // rust: let mut files = BTreeMap::new();
    // rust: if path.is_dir() {
    // rust: let mut stack = vec![path.to_path_buf()];
    // rust: while let Some(dir) = stack.pop() {
    // rust: for entry in fs::read_dir(&dir).map_err(|e| at(&e))? {
    // rust: let p = entry.map_err(|e| at(&e))?.path();
    // rust: if p.is_dir() {
    // rust: stack.push(p);
    // rust: } else if let Ok(rel) = p.strip_prefix(path) {
    // rust: let rel = rel.to_string_lossy().replace('\\', "/");
    // rust: files.insert(rel, fs::read(&p).map_err(|e| at(&e))?);
}
}
}
    // rust: } else {
    // rust: let file = fs::File::open(path).map_err(|e| at(&e))?;
    // rust: let mut zip = zip::ZipArchive::new(file).map_err(|e| at(&e))?;
    // rust: for i in 0..zip.len() {
    // rust: let mut entry = zip.by_index(i).map_err(|e| at(&e))?;
    // rust: if entry.is_dir() {
    // rust: continue;
}
            // A pack from the internet may name entries `../x` or `/x`. The
            // stored name is checked: zip 9's `enclosed_name` drops a leading
            // `..` instead of refusing it.
    // rust: let raw = String::from_utf8_lossy(entry.name_raw()).replace('\\', "/");
    // rust: if entry.enclosed_name().is_none() || !is_inside(Path::new(&raw)) {
    // rust: return Err(at(&format!("entry {raw:?} leaves the pack")));
}
    // rust: let mut bytes = Vec::new();
    // rust: entry.read_to_end(&mut bytes).map_err(|e| at(&e))?;
    // rust: files.insert(raw, bytes);
}
}
    // rust: if !files.contains_key("pack.mcmeta") {
    // rust: let top = files
    // rust: .keys()
    // rust: .find_map(|k| k.strip_suffix("/pack.mcmeta").filter(|t| !t.contains('/')))
    // rust: .map(|t| format!("{t}/"));
    // rust: if let Some(top) = top {
    // rust: files = files
    // rust: .into_iter()
    // rust: .filter_map(|(k, v)| k.strip_prefix(&top).map(|k| (k.to_owned(), v)))
    // rust: .collect();
}
}
    // rust: if !files.contains_key("pack.mcmeta") {
    // rust: return Err(format!("{}: no pack.mcmeta", path.display()));
}
    // rust: Ok(files)
}

// Upgrades the pack at `input` into the folder `out`, which must not
// exist yet (a world's `datapacks/<name>`).
upgrade_into :: proc(input: ^Path, out: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if out.exists() {
    // rust: return Err(format!("{} already exists", out.display()));
}
    // rust: let files = read_pack(input)?;
    // rust: let (upgraded, report) = upgrade_pack(&files);
    // rust: for (path, bytes) in upgraded {
    // rust: if !is_inside(Path::new(&path)) {
    // rust: return Err(format!("{path}: leaves {}", out.display()));
}
    // rust: let target = out.join(&path);
    // rust: if let Some(parent) = target.parent() {
    // rust: fs::create_dir_all(parent).map_err(|e| format!("{}: {e}", parent.display()))?;
}
    // rust: fs::write(&target, bytes).map_err(|e| format!("{}: {e}", target.display()))?;
}
    // rust: Ok(report)
}

// Whether `path` is a plain relative path: no root, drive, `.` or `..`.
is_inside :: proc(path: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: path.components().next().is_some()
    // rust: && path
    // rust: .components()
    // rust: .all(|c| matches!(c, std::path::Component::Normal(_)))
}

    // rust: impl Report {
    // The report as lines for the terminal.
lines :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut lines: Vec<String> = self
    // rust: .upgraded
    // rust: .iter()
    // rust: .map(|(r, n)| format!("upgraded {n} {r}"))
    // rust: .collect();
    // rust: if !self.added.is_empty() {
    // rust: lines.push(format!(
    // rust: "added {} shared density functions",
    // rust: self.added.len()
    // rust: ));
}
    // rust: lines.extend(
    // rust: self.lossy
    // rust: .iter()
    // rust: .map(|(w, n)| format!("not faithful ({n}x): {w}")),
    // rust: );
    // rust: lines.extend(
    // rust: self.unknown
    // rust: .iter()
    // rust: .map(|(w, n)| format!("left as it is ({n}x): {w}")),
    // rust: );
    // rust: lines
}
}

    // rust: mod tests {
//     use super::*;

up :: proc(path: string, v: Value) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let files = BTreeMap::from([(path.to_owned(), serde_json::to_vec(&v).unwrap())]);
    // rust: let (out, report) = upgrade_pack(&files);
    // rust: let (_, bytes) = out
    // rust: .into_iter()
    // rust: .find(|(p, _)| !p.contains("/upgraded/"))
    // rust: .unwrap();
    // rust: (serde_json::from_slice(&bytes).unwrap(), report)
}

noise_keeps_the_octaves_and_finds_the_parity_amplitude :: proc() {
}
    // rust: let (v, _) = up(
    // rust: "data/x/worldgen/noise/n.json",
    // rust: json!({"firstOctave": -7, "amplitudes": [1.0, 2.0, 1.0, 0.0, 0.0, 0.0]}),
    // rust: );
        // Vanilla 26.3's minecraft:ridge, which 26.2 wrote as above.
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"base_amplitude": 0.9147152149950137, "base_octave": -7, "octave_count": 6,
    // rust: "amplitude_modifiers": [1.0, 2.0, 1.0, 0.0, 0.0, 0.0]})
    // rust: );
    // rust: let (v, _) = up(
    // rust: "data/x/worldgen/noise/n.json",
    // rust: json!({"firstOctave": -3, "amplitudes": [1.0]}),
    // rust: );
        // Vanilla 26.3's minecraft:aquifer_barrier.
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"base_amplitude": 0.955388882960065, "base_octave": -3})
    // rust: );
}

density_arguments_and_removed_types :: proc() {
}
    // rust: let (v, _) = up(
    // rust: "data/x/worldgen/density_function/f.json",
    // rust: json!({"type": "minecraft:add", "argument1": {"type": "minecraft:constant", "argument": 2.0},
    // rust: "argument2": {"type": "minecraft:abs", "argument": {"type": "minecraft:y_clamped_gradient",
    // rust: "from_y": -64, "to_y": 320, "from_value": 1.5, "to_value": -1.5}}}),
    // rust: );
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"type": "minecraft:add", "left": 2.0, "right": {"type": "minecraft:abs",
    // rust: "input": {"type": "minecraft:gradient", "axis": "y", "from_coordinate": -64,
    // rust: "to_coordinate": 320, "from_value": 1.5, "to_value": -1.5}}})
    // rust: );
    // rust: let (v, _) = up(
    // rust: "data/x/worldgen/density_function/f.json",
    // rust: json!({"type": "minecraft:shifted_noise", "noise": "minecraft:erosion",
    // rust: "shift_x": "minecraft:shift_x", "shift_y": 0.0, "shift_z": "minecraft:shift_z",
    // rust: "xz_scale": 0.25, "y_scale": 0.0}),
    // rust: );
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"type": "minecraft:noise", "noise": "minecraft:erosion", "shift_x": "minecraft:shift_x",
    // rust: "shift_z": "minecraft:shift_z", "xz_scale": 0.25, "y_scale": 0.0})
    // rust: );
}

flat_cache_slices_at_y_zero_only_what_depends_on_y :: proc() {
}
    // rust: let flat = |argument: Value| {
    // rust: up(
    // rust: "data/x/worldgen/density_function/f.json",
    // rust: json!({"type": "minecraft:flat_cache", "argument": argument}),
    // rust: )
    // rust: .0
}
    // rust: let n = json!({"type": "minecraft:noise", "noise": "x:n", "xz_scale": 1.0, "y_scale": 0.0});
    // rust: assert_eq!(
    // rust: flat(n.clone()),
    // rust: json!({"type": "minecraft:cache", "input": n})
    // rust: );
    // rust: let y = json!({"type": "minecraft:mul", "argument1": "minecraft:y", "argument2": 2.0});
    // rust: assert_eq!(
    // rust: flat(y),
    // rust: json!({"type": "minecraft:cache", "input": {"type": "minecraft:slice", "axis": "y",
    // rust: "coordinate": 0, "input": {"type": "minecraft:mul", "left": "minecraft:y", "right": 2.0}}})
    // rust: );
}

interpolation_cell_comes_from_the_settings :: proc() {
}
    // rust: let settings = json!({"noise": {"min_y": 0, "height": 128, "size_horizontal": 2, "size_vertical": 1},
    // rust: "noise_router": {}, "surface_rule": {"type": "minecraft:sequence", "sequence": []},
    // rust: "default_block": {"Name": "minecraft:stone"}, "default_fluid": {"Name": "minecraft:water",
    // rust: "Properties": {"level": "0"}}, "aquifers_enabled": false, "ore_veins_enabled": false,
    // rust: "sea_level": 32, "disable_mob_generation": false, "legacy_random_source": false,
    // rust: "spawn_target": []});
    // rust: let files = BTreeMap::from([
    // rust: (
    // rust: "data/x/worldgen/noise_settings/s.json".to_owned(),
    // rust: serde_json::to_vec(&settings).unwrap(),
    // rust: ),
    // rust: (
    // rust: "data/x/worldgen/density_function/f.json".to_owned(),
    // rust: serde_json::to_vec(&json!({"type": "minecraft:interpolated", "argument": 1.0}))
    // rust: .unwrap(),
    // rust: ),
    // rust: ]);
    // rust: let (out, _) = upgrade_pack(&files);
    // rust: let f: Value =
    // rust: serde_json::from_slice(&out["data/x/worldgen/density_function/f.json"]).unwrap();
    // rust: assert_eq!(
    // rust: f,
    // rust: json!({"type": "minecraft:interpolated", "cell_size_xz": 8, "cell_size_y": 4, "input": 1.0})
    // rust: );
    // rust: let s: Value =
    // rust: serde_json::from_slice(&out["data/x/worldgen/noise_settings/s.json"]).unwrap();
    // rust: assert_eq!(s["noise"], json!({"min_y": 0, "height": 128}));
    // rust: assert_eq!(
    // rust: s["default_fluid"],
    // rust: json!({"id": "minecraft:water", "properties": {"level": "0"}})
    // rust: );
    // rust: assert_eq!(s["default_block"], json!("minecraft:stone"));
    // rust: assert!(s.get("aquifers").is_none());
    // rust: assert_eq!(
    // rust: s["noise_router"]["final_density"]["right"],
    // rust: json!({"type": "minecraft:beardifier"})
    // rust: );
}

settings_move_aquifers_veins_and_spawn_target :: proc() {
}
    // rust: let settings = json!({"noise": {"min_y": -64, "height": 384, "size_horizontal": 1, "size_vertical": 2},
    // rust: "noise_router": {"barrier": 1.0, "fluid_level_floodedness": 2.0, "fluid_level_spread": 3.0,
    // rust: "lava": 4.0, "temperature": "x:t", "vegetation": "x:v", "continents": "x:c",
    // rust: "erosion": "x:e", "depth": "x:d", "ridges": "x:r", "final_density": "x:f",
    // rust: "preliminary_surface_level": {"type": "minecraft:constant", "argument": 64.0},
    // rust: "vein_toggle": 0.5, "vein_ridged": -1.0, "vein_gap": 0.0},
    // rust: "surface_rule": {"type": "minecraft:block", "result_state": {"Name": "minecraft:dirt"}},
    // rust: "default_block": {"Name": "minecraft:stone"}, "default_fluid": {"Name": "minecraft:water"},
    // rust: "aquifers_enabled": true, "ore_veins_enabled": true, "sea_level": 63,
    // rust: "disable_mob_generation": false, "legacy_random_source": false,
    // rust: "spawn_target": [{"temperature": [-1, 1], "humidity": [-1, 1], "continentalness": [-0.11, 1],
    // rust: "erosion": [-1, 1], "weirdness": [-1, -0.16], "depth": 0, "offset": 0}]});
    // rust: let files = BTreeMap::from([(
    // rust: "data/x/worldgen/noise_settings/s.json".to_owned(),
    // rust: serde_json::to_vec(&settings).unwrap(),
    // rust: )]);
    // rust: let (out, _) = upgrade_pack(&files);
    // rust: let read = |p: &str| -> Value { serde_json::from_slice(&out[p]).unwrap() };
    // rust: let s = read("data/x/worldgen/noise_settings/s.json");
    // rust: assert_eq!(s["material_rule"], json!("x:s/upgraded/material_rule"));
    // rust: let rule = read("data/x/worldgen/material_rule/s/upgraded/material_rule.json");
    // rust: let aquifers = &s["aquifers"];
    // rust: assert_eq!(aquifers["barrier"], json!(1.0));
    // rust: assert_eq!(
    // rust: aquifers["surface_level"],
    // rust: json!("x:s/upgraded/preliminary_surface_level")
    // rust: );
    // rust: assert_eq!(aquifers["exclusion"]["left"]["right"], json!("x:e"));
    // rust: let rules = rule["sequence"].as_array().unwrap();
    // rust: assert_eq!(rules.len(), 3);
    // rust: assert_eq!(rules[0]["type"], json!("minecraft:ore_vein"));
    // rust: assert_eq!(
    // rust: rules[2],
    // rust: json!({"type": "minecraft:block", "result_state": "minecraft:dirt"})
    // rust: );
    // rust: assert_eq!(
    // rust: s["spawn_target"],
    // rust: json!([{"x:t": [-1, 1], "x:v": [-1, 1], "x:c": [-0.11, 1], "x:e": [-1, 1], "x:r": [-1, -0.16]}])
    // rust: );
    // rust: assert_eq!(
    // rust: s["noise_router"]["chunk_surface_level"],
    // rust: json!({"type": "minecraft:interpolated", "cell_size_xz": 16, "cell_size_y": 1,
    // rust: "input": "x:s/upgraded/preliminary_surface_level"})
    // rust: );
}

features_lose_their_config_and_placements_their_spread :: proc() {
}
    // rust: let (v, _) = up(
    // rust: "data/x/worldgen/configured_feature/f.json",
    // rust: json!({"type": "minecraft:disk", "config": {"state_provider": {"type":
    // rust: "minecraft:simple_state_provider", "state": {"Name": "minecraft:clay"}}, "radius": 2}}),
    // rust: );
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"type": "minecraft:disk", "state_provider": "minecraft:clay", "radius": 2})
    // rust: );
    // rust: let (v, _) = up(
    // rust: "data/x/worldgen/placed_feature/p.json",
    // rust: json!({"feature": "x:f", "placement": [{"type": "minecraft:random_offset",
    // rust: "xz_spread": 0, "y_spread": -1}]}),
    // rust: );
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"feature": "x:f", "placement": [{"type": "minecraft:offset", "x": 0, "y": -1, "z": 0}]})
    // rust: );
}

biome_spawns_become_attributes :: proc() {
}
    // rust: let (v, _) = up(
    // rust: "data/x/worldgen/biome/b.json",
    // rust: json!({"spawners": {"monster": [{"type": "minecraft:zombie", "minCount": 4, "maxCount": 4,
    // rust: "weight": 95}], "ambient": []}, "spawn_costs": {}, "creature_spawn_probability": 0.07,
    // rust: "attributes": {"minecraft:visual/sky_color": "#78a7ff"}}),
    // rust: );
    // rust: assert_eq!(
    // rust: v["attributes"]["minecraft:gameplay/natural_mob_spawns"],
    // rust: json!({"modifier": "overlay", "argument": {"spawn_costs": {}, "spawns_by_category": {
    // rust: "monster": [{"type": "minecraft:zombie", "count": 4, "weight": 95}], "ambient": []}}})
    // rust: );
    // rust: assert_eq!(
    // rust: v["attributes"]["minecraft:gameplay/creature_world_gen_spawn_probability"],
    // rust: json!(0.07)
    // rust: );
    // rust: assert!(v.get("spawners").is_none());
}

entries_outside_the_pack_are_refused :: proc() {
}
//         use std::io::Write;
    // rust: let dir = std::env::temp_dir().join(format!("upgrade-escape-{}", std::process::id()));
    // rust: let _ = fs::remove_dir_all(&dir);
    // rust: fs::create_dir_all(&dir).unwrap();
    // rust: for (i, name) in ["../escape.txt", "data/../../escape.txt", "/escape.txt"]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let zip_path = dir.join(format!("p{i}.zip"));
    // rust: let mut zip = zip::ZipWriter::new(fs::File::create(&zip_path).unwrap());
    // rust: for (file, bytes) in [("pack.mcmeta", &b"{}"[..]), (name, b"x")] {
    // rust: zip.start_file(file, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(bytes).unwrap();
}
    // rust: zip.finish().unwrap();
    // rust: let out = dir.join(format!("out{i}/datapacks/p-26.3"));
    // rust: let err = upgrade_into(&zip_path, &out).unwrap_err();
    // rust: assert!(err.contains("leaves the pack"), "{name}: {err}");
    // rust: assert!(!out.exists(), "{name}");
}
    // rust: assert!(!dir.join("escape.txt").exists());
    // rust: assert!(is_inside(Path::new("data/x/worldgen/biome/b.json")));
    // rust: assert!(!is_inside(Path::new("data/../x.json")));
    // rust: assert!(!is_inside(Path::new("")));
    // rust: fs::remove_dir_all(&dir).unwrap();
}

carvers_move_and_spell_out_their_hard_coded_shape :: proc() {
}
    // rust: let files = BTreeMap::from([(
    // rust: "data/x/worldgen/configured_carver/c.json".to_owned(),
    // rust: serde_json::to_vec(&json!({"type": "minecraft:canyon", "config": {"probability": 0.01,
    // rust: "yScale": 3.0, "lava_level": {"above_bottom": 8}, "shape": {"width_smoothness": 3}}}))
    // rust: .unwrap(),
    // rust: )]);
    // rust: let (out, _) = upgrade_pack(&files);
    // rust: let v: Value = serde_json::from_slice(&out["data/x/worldgen/carver/c.json"]).unwrap();
    // rust: assert_eq!(
    // rust: v,
    // rust: json!({"type": "minecraft:canyon", "probability": 0.01,
    // rust: "shape": {"width_smoothness": 3, "y_scale": 3.0}})
    // rust: );
}
}
