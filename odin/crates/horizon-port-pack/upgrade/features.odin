//! Transpiled from Horizon Rust crate
package horizon_port_pack_features

import "core:fmt"
import "core:mem"
import "core:math"

// Configured and placed features.
// use super::{Report, kind, states, vanilla};
// use serde_json::{Map, Value, json};

// Feature types 26.3 dropped for compositions of other features; a pack
// using them needs vanilla's composition, which the upgrade does not
// write.
    // rust: const REPLACED_FEATURES: [&str; 12] = [
    // rust: "basalt_columns",
    // rust: "basalt_pillar",
    // rust: "coral_mushroom",
    // rust: "desert_well",
    // rust: "glowstone_blob",
    // rust: "kelp",
    // rust: "nether_forest_vegetation",
    // rust: "sea_pickle",
    // rust: "seagrass",
    // rust: "twisting_vines",
    // rust: "weeping_vines",
    // rust: "random_patch",
    // rust: ];

// 26.2 block state provider types and their 26.3 names.
provider :: proc(t: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match t {
    // rust: "simple_state_provider" => "simple_state_provider",
    // rust: "weighted_state_provider" => "weighted",
    // rust: "rotated_block_provider" => "rotated",
    // rust: "randomized_int_state_provider" => "randomized_int",
    // rust: "rule_based_state_provider" => "rule_based",
    // rust: "noise_provider" => "noise",
    // rust: "dual_noise_provider" => "dual_noise",
    // rust: "noise_threshold_provider" => "noise_threshold",
    // rust: _ => return None,
    // rust: })
}

// One placement modifier: `random_offset` became `offset` with one
// provider per axis (x and z both from `xz_spread`, drawn in that order).
placement :: proc(m: ^Value) {
}
    // rust: if kind(m) == Some("random_offset") {
    // rust: let xz = m.get("xz_spread").cloned().unwrap_or(json!(0));
    // rust: let y = m.get("y_spread").cloned().unwrap_or(json!(0));
    // rust: *m = json!({"type": "minecraft:offset", "x": xz.clone(), "y": y, "z": xz});
}
}

// A configured feature in 26.3's form: `config` unwrapped, block state
// providers renamed, nested features and placements upgraded.
    // rust: pub(super) fn feature(v: &Value, report: &mut Report) -> Value {
    // rust: let Value::Object(o) = v else {
    // rust: return v.clone();
}
    // rust: let Some(t) = kind(v) else {
    // rust: return v.clone();
}
    // rust: if REPLACED_FEATURES.contains(&t) {
    // rust: report.unknown(format!("feature {t} (written as data in 26.3)"));
}
    // rust: let mut n = Map::new();
    // rust: n.insert("type".into(), o["type"].clone());
    // rust: if let Some(Value::Object(config)) = o.get("config") {
    // rust: for (k, x) in config {
    // rust: n.insert(k.clone(), x.clone());
}
}
    // rust: let mut v = Value::Object(n);
    // rust: states(&mut v);
    // rust: nested(&mut v, report);
    // rust: v
}

// Inside a feature: block state providers, placed features and
// configured features held inline.
nested :: proc(v: ^Value, report: ^Report) {
}
    // rust: match v {
    // rust: Value::Object(o) => {
    // rust: if let Some(t) = kind(&Value::Object(o.clone())) {
    // rust: if let Some(to) = provider(t) {
    // rust: if t == "simple_state_provider" {
    // rust: *v = o.get("state").cloned().unwrap_or_default();
    // rust: return;
}
    // rust: o.insert("type".into(), vanilla(to));
}
}
            // An inline placed feature: {feature, placement}.
    // rust: if o.contains_key("placement") && o.contains_key("feature") {
    // rust: let placed = placed(&Value::Object(o.clone()), report);
    // rust: *v = placed;
    // rust: return;
}
    // rust: for x in o.values_mut() {
    // rust: if x.get("config").is_some() && x.get("type").is_some() {
    // rust: *x = feature(x, report);
    // rust: } else {
    // rust: nested(x, report);
}
}
}
    // rust: Value::Array(a) => a.iter_mut().for_each(|x| nested(x, report)),
    // rust: _ => {}
}
}

// A placed feature: its feature (an id or inline) and its placement
// modifiers.
    // rust: pub(super) fn placed(v: &Value, report: &mut Report) -> Value {
    // rust: let mut v = v.clone();
    // rust: states(&mut v);
    // rust: if let Some(f) = v.get("feature").cloned()
    // rust: && f.is_object()
    // rust: {
    // rust: v["feature"] = feature(&f, report);
}
    // rust: if let Some(Value::Array(ms)) = v.get_mut("placement") {
    // rust: for m in ms.iter_mut() {
    // rust: placement(m);
}
}
    // rust: v
}
