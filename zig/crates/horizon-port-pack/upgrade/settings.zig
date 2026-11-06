//! Transpiled from Horizon Rust crate
//! Module: horizon-port-pack_settings
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Noise settings, dimensions and world presets.
// use super::{
    // rust: Report,
    // rust: density::{Context, cell_of},
    // rust: kind, states, vanilla,
}
// use serde_json::{Map, Value, json};

    // rust: impl Context<'_> {
    /// A density function the settings use in several places, as an id: its
    /// own id when it is one, otherwise a new named function under
    /// `<settings>/upgraded/<name>`.
    // rust: pub(super) fn named(&mut self, settings: &str, name: &str, v: Value) -> Value {
    // rust: if v.is_string() {
    // rust: return v;
}
    // rust: let (ns, path) = settings.split_once(':').unwrap_or(("minecraft", settings));
    // rust: let id = format!("{ns}:{path}/upgraded/{name}");
    // rust: self.generated.insert(id.clone(), v);
    // rust: Value::String(id)
}

    /// 26.2 noise settings in 26.3's form.
    // rust: pub(super) fn settings(&mut self, id: &str, v: &Value, report: &mut Report) -> Value {
    // rust: let Value::Object(o) = v else {
    // rust: return v.clone();
}
    // rust: if o.contains_key("material_rule") {
    // rust: return v.clone();
}
    // rust: let router = o.get("noise_router").cloned().unwrap_or_default();
    // rust: self.cell = cell_of(o.get("noise").unwrap_or(&Value::Null));
    // rust: let conv = |this: &mut Self, report: &mut Report, name: &str| {
    // rust: this.density(&router.get(name).cloned().unwrap_or(json!(0.0)), report)
}
        // The climate functions are named: the spawn target and the aquifer
        // exclusion refer to them by id.
    // rust: let climate = |this: &mut Self, report: &mut Report, name: &str| {
    // rust: let f = conv(this, report, name);
    // rust: this.named(id, name, f)
}
    // rust: let temperature = climate(self, report, "temperature");
    // rust: let vegetation = climate(self, report, "vegetation");
    // rust: let continents = climate(self, report, "continents");
    // rust: let erosion = climate(self, report, "erosion");
    // rust: let depth = climate(self, report, "depth");
    // rust: let ridges = climate(self, report, "ridges");
    // rust: let final_density = conv(self, report, "final_density");
    // rust: let surface = conv(self, report, "preliminary_surface_level");
    // rust: let surface = self.named(id, "preliminary_surface_level", surface);
    // rust: let mut n = Map::new();
    // rust: let mut noise = o.get("noise").cloned().unwrap_or_default();
    // rust: if let Some(noise) = noise.as_object_mut() {
    // rust: noise.remove("size_horizontal");
    // rust: noise.remove("size_vertical");
}
    // rust: n.insert("noise".into(), noise);
    // rust: for key in ["default_block", "default_fluid"] {
    // rust: let mut s = o.get(key).cloned().unwrap_or_default();
    // rust: states(&mut s);
    // rust: n.insert(key.into(), s);
}
    // rust: let aquifers = o
    // rust: .get("aquifers_enabled")
    // rust: .and_then(Value::as_bool)
    // rust: .unwrap_or(true);
    // rust: if aquifers {
    // rust: let barrier = conv(self, report, "barrier");
    // rust: let floodedness = conv(self, report, "fluid_level_floodedness");
    // rust: let spread = conv(self, report, "fluid_level_spread");
    // rust: let lava = conv(self, report, "lava");
            // 26.2's OverworldBiomeBuilder.isDeepDarkRegion: no aquifer
            // where erosion < -0.225 and depth > 0.9 (positive excludes).
    // rust: let exclusion = json!({"type": "minecraft:min",
    // rust: "left": {"type": "minecraft:sub", "left": -0.225, "right": erosion.clone()},
    // rust: "right": {"type": "minecraft:max",
    // rust: "left": {"type": "minecraft:sub", "left": depth.clone(), "right": 0.9},
    // rust: "right": 0.0}});
    // rust: n.insert(
    // rust: "aquifers".into(),
    // rust: json!({"barrier": barrier, "exclusion": exclusion,
    // rust: "fluid_level_floodedness": floodedness, "fluid_level_spread": spread,
    // rust: "lava": lava, "surface_level": surface.clone()}),
    // rust: );
}
    // rust: let mut rule = o.get("surface_rule").cloned().unwrap_or(json!({
    // rust: "type": "minecraft:sequence", "sequence": []}));
    // rust: states(&mut rule);
    // rust: let veins = o
    // rust: .get("ore_veins_enabled")
    // rust: .and_then(Value::as_bool)
    // rust: .unwrap_or(false);
    // rust: let rule = if veins {
    // rust: let toggle = conv(self, report, "vein_toggle");
    // rust: let toggle = self.named(
    // rust: id,
    // rust: "vein_toggle",
    // rust: json!({"type": "minecraft:cache", "input": toggle}),
    // rust: );
    // rust: let ridged = conv(self, report, "vein_ridged");
    // rust: let ridged = self.named(id, "vein_ridged", ridged);
    // rust: let gap = conv(self, report, "vein_gap");
    // rust: let gap = self.named(id, "vein_gap", gap);
            // Ore veins come first: 26.2 placed them while filling the
            // noise, and its surface pass only replaced the default block.
    // rust: let mut sequence = ore_veins(&toggle, &ridged, &gap);
    // rust: sequence.push(rule);
    // rust: json!({"type": "minecraft:sequence", "sequence": sequence})
    // rust: } else {
    // rust: rule
}
    // rust: n.insert(
    // rust: "noise_router".into(),
    // rust: json!({"temperature": temperature, "vegetation": vegetation,
    // rust: "continents": continents, "erosion": erosion,
    // rust: "depth": depth, "ridges": ridges,
    // rust: "chunk_surface_level": {"type": "minecraft:interpolated", "cell_size_xz": 16,
    // rust: "cell_size_y": 1, "input": surface},
    // rust: "final_density": {"type": "minecraft:add", "left": final_density,
    // rust: "right": {"type": "minecraft:beardifier"}}}),
    // rust: );
        // Named, as vanilla names its own (and as Horizon reads them), under
        // the settings' id so other vanilla settings keep their rule.
    // rust: let (ns, path) = id.split_once(':').unwrap_or(("minecraft", id));
    // rust: let rule_id = format!("{ns}:{path}/upgraded/material_rule");
    // rust: self.rules.insert(rule_id.clone(), rule);
    // rust: n.insert("material_rule".into(), Value::String(rule_id));
    // rust: let climate = [
    // rust: ("temperature", n["noise_router"]["temperature"].clone()),
    // rust: ("humidity", n["noise_router"]["vegetation"].clone()),
    // rust: ("continentalness", n["noise_router"]["continents"].clone()),
    // rust: ("erosion", n["noise_router"]["erosion"].clone()),
    // rust: ("weirdness", n["noise_router"]["ridges"].clone()),
    // rust: ];
    // rust: let spawn: Vec<Value> = o
    // rust: .get("spawn_target")
    // rust: .and_then(Value::as_array)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|p| {
    // rust: for key in ["depth", "offset"] {
    // rust: if p.get(key).is_some_and(|d| d.as_f64() != Some(0.0)) {
    // rust: report.lossy(format!("noise settings: spawn target {key} other than 0"));
}
}
    // rust: let mut point = Map::new();
    // rust: for (param, f) in &climate {
    // rust: if let (Some(range), Some(f)) = (p.get(*param), f.as_str()) {
    // rust: point.insert(f.into(), range.clone());
}
}
    // rust: Value::Object(point)
    // rust: })
    // rust: .collect();
    // rust: n.insert("spawn_target".into(), Value::Array(spawn));
    // rust: for key in [
    // rust: "sea_level",
    // rust: "disable_mob_generation",
    // rust: "legacy_random_source",
    // rust: ] {
    // rust: if let Some(x) = o.get(key) {
    // rust: n.insert(key.into(), x.clone());
}
}
    // rust: Value::Object(n)
}

    /// A dimension (`dimension/<id>.json` or a world preset's entry): an
    /// inline noise settings object in its generator is upgraded.
    // rust: pub(super) fn dimension(&mut self, v: &Value, report: &mut Report) -> Value {
    // rust: let mut v = v.clone();
    // rust: let noise = v.get("generator").and_then(kind) == Some("noise");
    // rust: if let Some(settings) = v.pointer("/generator/settings").cloned()
    // rust: && settings.is_object()
    // rust: && noise
    // rust: {
    // rust: v["generator"]["settings"] = self.settings("minecraft:inline", &settings, report);
}
    // rust: v
}

    // rust: pub(super) fn world_preset(&mut self, v: &Value, report: &mut Report) -> Value {
    // rust: let mut v = v.clone();
    // rust: if let Some(dims) = v.get_mut("dimensions").and_then(Value::as_object_mut) {
    // rust: for d in dims.values_mut() {
    // rust: *d = self.dimension(d, report);
}
}
    // rust: v
}
}

/// 26.2's `OreVeinifier` as 26.3 material rules, one per vein type, from
/// the pack's `vein_toggle`, `vein_ridged` and `vein_gap`: a block between
/// the type's heights where the toggle (copper above zero, iron below)
/// clears 0.4 less the edge roundoff, and the ridged noise is negative, is
/// the filler with chance 0.7, and ore where the richness draw and the gap
/// noise allow.
pub fn ore_veins(toggle: *Value, ridged: *Value, gap: *Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let types = [
    // rust: ("copper_ore", "raw_copper_block", "granite", 0, 50, false),
    // rust: (
    // rust: "deepslate_iron_ore",
    // rust: "raw_iron_block",
    // rust: "tuff",
    // rust: -60,
    // rust: -8,
    // rust: true,
    // rust: ),
    // rust: ];
    // rust: types
    // rust: .iter()
    // rust: .map(|(ore, raw, filler, min_y, max_y, negate)| {
    // rust: let veininess = if *negate {
    // rust: json!({"type": "minecraft:negate", "input": toggle})
    // rust: } else {
    // rust: toggle.clone()
}
            // clampedMap(min(maxY - y, y - minY), 0, 20, -0.2, 0)
    // rust: let edge = json!({"type": "minecraft:add",
    // rust: "left": {"type": "minecraft:mul",
    // rust: "left": {"type": "minecraft:clamp",
    // rust: "input": {"type": "minecraft:min",
    // rust: "left": {"type": "minecraft:sub", "left": f64::from(*max_y), "right": "minecraft:y"},
    // rust: "right": {"type": "minecraft:sub", "left": "minecraft:y", "right": f64::from(*min_y)}},
    // rust: "min": 0.0, "max": 20.0},
    // rust: "right": 0.01},
    // rust: "right": -0.2});
    // rust: let density = json!({"type": "minecraft:range_choice", "input": "minecraft:y",
    // rust: "min_inclusive": f64::from(*min_y), "max_exclusive": f64::from(max_y + 1),
    // rust: "when_in_range": {"type": "minecraft:range_choice", "input": ridged,
    // rust: "min_inclusive": -1_000_000.0, "max_exclusive": 0.0,
    // rust: "when_in_range": {"type": "minecraft:range_choice",
    // rust: "input": {"type": "minecraft:add",
    // rust: "left": {"type": "minecraft:sub", "left": veininess, "right": 0.4},
    // rust: "right": edge},
    // rust: "min_inclusive": 0.0, "max_exclusive": 1_000_000.0,
    // rust: "when_in_range": 0.7, "when_out_of_range": -1.0},
    // rust: "when_out_of_range": -1.0},
    // rust: "when_out_of_range": -1.0});
            // clampedMap(|toggle|, 0.4, 0.6, 0.1, 0.3)
    // rust: let richness = json!({"type": "minecraft:add",
    // rust: "left": {"type": "minecraft:clamp", "input": {"type": "minecraft:abs", "input": toggle},
    // rust: "min": 0.4, "max": 0.6},
    // rust: "right": -0.3});
    // rust: json!({"type": "minecraft:ore_vein", "ore_block": vanilla(ore),
    // rust: "raw_ore_block": vanilla(raw), "filler_block": vanilla(filler),
    // rust: "raw_ore_chance": 0.02, "density": density, "richness": richness,
    // rust: "filler_gap": {"type": "minecraft:sub", "left": -0.3, "right": gap}})
    // rust: })
    // rust: .collect()
}
