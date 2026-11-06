//! Transpiled from Horizon Rust crate
package horizon_port_pack_yung

import "core:fmt"
import "core:mem"
import "core:math"

// YUNG's API's worldgen, carried as the mods write it (clean room:
// `cleanroom/structures/spec-yungsapi.md`).
//
// The game reads `yungsapi:yung_jigsaw` structures and
// `yungsapi:yung_single_element` pool elements as they ship
// (`horizon_world::worldgen::structure::jigsaw::Draws::Yung`), so their files
// pass through unchanged. What the game does not run yet is counted by name
// in the carry report: the fields whose behaviour the specification leaves
// open. YUNG's other structure, placement and processor types are left to the
// general code, which lists them as unsupported or drops them.
// use serde_json::Value;
// use std::collections::BTreeMap;

JIGSAW :: "yungsapi:yung_jigsaw"
ELEMENT :: "yungsapi:yung_single_element"
// A terrain adaptation that adapts nothing.
NO_ADAPTATION :: "yungsapi:none"

count :: proc(lost: ^BTreeMap<string, rule: string) {
}
    // rust: *lost.entry(rule).or_default() += 1;
}

// Whether a field changes generation in a way the game does not run yet:
// present, and not the value that changes nothing.
active :: proc(v: ^Value, field: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match &v[field] {
    // rust: Value::Null | Value::Bool(false) => false,
    // rust: Value::Object(o) => o.get("type").and_then(Value::as_str) != Some(NO_ADAPTATION),
    // rust: _ => true,
}
}

// A `yung_jigsaw` structure: `Some(false)` (carried as it is), else `None`.
    // rust: pub(crate) fn upgrade(kind: &str, v: &Value, lost: &mut BTreeMap<String, usize>) -> Option<bool> {
    // rust: if kind != "structure" || v["type"] != JIGSAW {
    // rust: return None;
}
    // spec-yungsapi §2: OPEN-Y1, OPEN-Y2 and §5.
    // rust: for field in [
    // rust: "adapt_noise",
    // rust: "max_y",
    // rust: "min_y",
    // rust: "enhanced_terrain_adaptation",
    // rust: ] {
    // rust: if active(v, field) {
    // rust: count(lost, format!("{JIGSAW} {field}"));
}
}
    // rust: Some(false)
}

// A `yung_single_element` pool element, carried as it is; whether it was one.
    // rust: pub(crate) fn upgrade_pool_element(element: &Value, lost: &mut BTreeMap<String, usize>) -> bool {
    // rust: if element["element_type"] != ELEMENT {
    // rust: return false;
}
    // spec-yungsapi §4 and §5. `name`, `max_count`, `is_priority`,
    // `min_required_depth` and `ignore_bounds` are run (§3, §3.2).
    // rust: for field in ["condition", "enhanced_terrain_adaptation", "modifiers"] {
    // rust: if active(element, field) {
    // rust: count(lost, format!("{ELEMENT} {field}"));
}
}
    // rust: true
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

jigsaws_and_elements_are_carried_as_written :: proc() {
}
    // rust: let mut lost = BTreeMap::new();
    // rust: let dungeon =
    // rust: json!({"type": JIGSAW, "start_pool": "a:b", "size": 10, "adapt_noise": false});
    // rust: assert_eq!(upgrade("structure", &dungeon, &mut lost), Some(false));
    // rust: assert!(lost.is_empty());
    // rust: let stronghold = json!({"type": JIGSAW, "max_y": 0,
    // rust: "enhanced_terrain_adaptation": {"type": "yungsapi:carved"}});
    // rust: assert_eq!(upgrade("structure", &stronghold, &mut lost), Some(false));
    // rust: assert_eq!(lost[&format!("{JIGSAW} max_y")], 1);
    // rust: assert_eq!(lost[&format!("{JIGSAW} enhanced_terrain_adaptation")], 1);
    // rust: assert_eq!(
    // rust: upgrade("structure", &json!({"type": "minecraft:jigsaw"}), &mut lost),
    // rust: None
    // rust: );
    // rust: assert_eq!(upgrade("structure_set", &dungeon, &mut lost), None);

    // rust: let mut lost = BTreeMap::new();
    // rust: let pile = json!({"element_type": ELEMENT, "name": "loot_pile_0", "max_count": 1,
    // rust: "enhanced_terrain_adaptation": {"type": NO_ADAPTATION}, "is_priority": true,
    // rust: "min_required_depth": 2, "ignore_bounds": true});
    // rust: assert!(upgrade_pool_element(&pile, &mut lost));
    // rust: assert!(lost.is_empty());
    // rust: let gated = json!({"element_type": ELEMENT, "condition": {"type": "yungsapi:not"}});
    // rust: assert!(upgrade_pool_element(&gated, &mut lost));
    // rust: assert_eq!(lost[&format!("{ELEMENT} condition")], 1);
    // rust: let single = json!({"element_type": "minecraft:single_pool_element"});
    // rust: assert!(!upgrade_pool_element(&single, &mut lost));
}
}
