//! Transpiled from Horizon Rust crate
package horizon_port_pack_registries

import "core:fmt"
import "core:mem"
import "core:math"

// Carvers, biomes, structures and dimension types.
// use super::{Report, kind, states, vanilla};
// use serde_json::{Map, Value, json};

// A configured carver in 26.3's form. 26.2's cave carvers hard-coded their
// count, thickness and the room's vertical scale per type; 26.3 reads them.
    // rust: pub(super) fn carver(v: &Value, report: &mut Report) -> Value {
    // rust: let Some(t) = kind(v) else {
    // rust: return v.clone();
}
    // rust: let mut c = v.get("config").cloned().unwrap_or_default();
    // rust: let Some(o) = c.as_object_mut() else {
    // rust: return v.clone();
}
    // rust: o.remove("debug_settings");
    // rust: let lava = o.remove("lava_level");
    // rust: let replaceable = o.remove("replaceable");
    // rust: if lava.is_some_and(|l| l != json!({"above_bottom": 8}) && l != json!({"above_bottom": 10})) {
    // rust: report.lossy("carver: lava_level (26.3 takes it from the aquifer)");
}
    // rust: if replaceable.is_some_and(|r| {
    // rust: r != json!("#minecraft:overworld_carver_replaceables")
    // rust: && r != json!("#minecraft:nether_carver_replaceables")
    // rust: }) {
    // rust: report.lossy("carver: replaceable (26.3 carves any stone)");
}
    // rust: let y_scale = o.remove("yScale");
    // rust: let mut n = Map::new();
    // rust: match t {
    // rust: "cave" | "nether_cave" => {
    // rust: let nether = t == "nether_cave";
    // rust: n.insert("type".into(), vanilla("cave"));
    // rust: n.insert(
    // rust: "count".into(),
    // rust: json!({"type": "minecraft:very_biased_to_bottom", "min_inclusive": 0,
    // rust: "max_inclusive": if nether { 9 } else { 14 }}),
    // rust: );
    // rust: n.insert(
    // rust: "thickness".into(),
    // rust: if nether {
    // rust: json!({"type": "minecraft:trapezoid", "min": 0.0, "max": 6.0, "plateau": 2.0})
    // rust: } else {
    // rust: json!({"type": "minecraft:trapezoid", "min": 0.0, "max": 3.0, "plateau": 1.0})
    // rust: },
    // rust: );
    // rust: if !nether {
    // rust: n.insert("weird_thickness_bias".into(), json!(true));
    // rust: } else {
    // rust: n.insert("start_vertical_radius_multiplier".into(), json!(5.0));
}
    // rust: if let Some(s) = y_scale {
    // rust: n.insert("room_vertical_radius_multiplier".into(), s);
}
}
    // rust: "canyon" => {
    // rust: n.insert("type".into(), vanilla("canyon"));
    // rust: if let (Some(s), Some(shape)) =
    // rust: (y_scale, o.get_mut("shape").and_then(Value::as_object_mut))
    // rust: {
    // rust: shape.insert("y_scale".into(), s);
}
}
    // rust: other => {
    // rust: report.unknown(format!("carver {other}"));
    // rust: n.insert("type".into(), v["type"].clone());
}
}
    // rust: for (k, x) in o.iter() {
    // rust: n.insert(k.clone(), x.clone());
}
    // rust: let mut v = Value::Object(n);
    // rust: states(&mut v);
    // rust: v
}

// `{type, minCount, maxCount, weight}` to `{type, count, weight}`.
spawner :: proc(s: ^Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut s = s.clone();
    // rust: if let Some(o) = s.as_object_mut() {
    // rust: let min = o.remove("minCount");
    // rust: let max = o.remove("maxCount");
    // rust: if let (Some(min), Some(max)) = (min, max) {
    // rust: let count = if min == max {
    // rust: min
    // rust: } else {
    // rust: json!({"type": "minecraft:uniform", "min_inclusive": min, "max_inclusive": max})
}
    // rust: o.insert("count".into(), count);
}
}
    // rust: s
}

// A biome in 26.3's form: mob spawns become the
// `minecraft:gameplay/natural_mob_spawns` attribute (every category kept,
// empty ones too, so nothing comes from the dimension's defaults), and the
// creature spawn probability its own attribute.
    // rust: pub(super) fn biome(v: &Value, report: &mut Report) -> Value {
    // rust: let mut v = v.clone();
    // rust: states(&mut v);
    // rust: let Some(o) = v.as_object_mut() else {
    // rust: return v;
}
    // rust: let spawners = o.remove("spawners");
    // rust: let costs = o.remove("spawn_costs");
    // rust: let probability = o.remove("creature_spawn_probability");
    // rust: let attributes = o
    // rust: .entry("attributes")
    // rust: .or_insert_with(|| json!({}))
    // rust: .as_object_mut();
    // rust: let Some(attributes) = attributes else {
    // rust: report.lossy("biome: attributes is not an object");
    // rust: return v;
}
    // rust: if let Some(Value::Object(categories)) = spawners {
    // rust: let by_category: Map<String, Value> = categories
    // rust: .iter()
    // rust: .map(|(c, list)| {
    // rust: let list = list.as_array().into_iter().flatten().map(spawner).collect();
    // rust: (c.clone(), Value::Array(list))
    // rust: })
    // rust: .collect();
    // rust: attributes.insert(
    // rust: "minecraft:gameplay/natural_mob_spawns".into(),
    // rust: json!({"modifier": "overlay", "argument": {
    // rust: "spawn_costs": costs.unwrap_or(json!({})),
    // rust: "spawns_by_category": by_category}}),
    // rust: );
}
    // rust: if let Some(p) = probability
    // rust: && p.as_f64().is_some_and(|p| (p as f32) != 0.1)
    // rust: {
    // rust: attributes.insert(
    // rust: "minecraft:gameplay/creature_world_gen_spawn_probability".into(),
    // rust: p,
    // rust: );
}
    // rust: v
}

// A dimension type: the bed rule's `explodes` is 26.3's `destroy_on_use`.
    // rust: pub(super) fn dimension_type(v: &Value) -> Value {
    // rust: let mut v = v.clone();
    // rust: if let Some(rule) = v
    // rust: .pointer_mut("/attributes/minecraft:gameplay~1bed_rule")
    // rust: .and_then(Value::as_object_mut)
    // rust: && let Some(explodes) = rule.remove("explodes")
    // rust: {
    // rust: rule.insert("destroy_on_use".into(), explodes);
}
    // rust: v
}

// A structure: its spawn overrides' counts in 26.3's form.
    // rust: pub(super) fn structure(v: &Value) -> Value {
    // rust: let mut v = v.clone();
    // rust: states(&mut v);
    // rust: if let Some(Value::Object(overrides)) = v.get_mut("spawn_overrides") {
    // rust: for o in overrides.values_mut() {
    // rust: if let Some(Value::Array(spawns)) = o.get_mut("spawns") {
    // rust: for s in spawns.iter_mut() {
    // rust: *s = spawner(s);
}
}
}
}
    // rust: v
}
