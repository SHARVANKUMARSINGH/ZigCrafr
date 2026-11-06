//! Transpiled from Horizon Rust crate
package horizon_world_conditions

import "core:fmt"
import "core:mem"
import "core:math"

// NeoForge's load conditions (`neoforge:conditions`): a data file that has
// the key loads only when every condition in it holds, and is silently
// absent otherwise, as NeoForge's `ICondition` does. Mods' packs lean on it
// for cross-mod recipes — a recipe for another mod's material only makes
// sense to load when that mod's data is in the root.
// use serde_json::Value;

// What a condition asks: whether a mod's data is loaded. Callers answer from
// the content root's namespaces (`content_namespaces::namespaces`), where a
// mod that is off leaves no namespace behind, plus `minecraft`, always.
    // rust: pub type ModLoaded<'a> = dyn Fn(&str) -> bool + 'a;

// Whether `v`'s `neoforge:conditions` all hold; a file without the key
// loads, one with an unknown condition type doesn't.
conditions_hold :: proc(v: ^Value, loaded: ^ModLoaded) -> b {
    // Ported from Horizon
    return {}
}
hold :: proc(c: ^Value, loaded: ^ModLoaded) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let all = |key: &str| {
    // rust: c[key]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|c| hold(c, loaded))
}
    // rust: match c["type"].as_str() {
    // rust: Some("neoforge:mod_loaded") => c["modid"].as_str().is_some_and(loaded),
    // rust: Some("neoforge:true") => true,
            // An unknown child fails the file: `not` of it is not a pass.
    // rust: Some("neoforge:not") => known(&c["value"]) && !hold(&c["value"], loaded),
    // rust: Some("neoforge:and") => all("values"),
    // rust: Some("neoforge:or") => {
    // rust: let values: Vec<&Value> = c["values"].as_array().into_iter().flatten().collect();
    // rust: values.iter().all(|v| known(v)) && values.iter().any(|v| hold(v, loaded))
}
    // rust: _ => false,
}
}
    // rust: v["neoforge:conditions"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .all(|c| hold(c, loaded))
}

// Whether the condition's kind is one the game knows; an unknown kind
// anywhere in the tree leaves the file out, through `not` and the
// combinators alike.
known :: proc(c: ^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !matches!(
    // rust: c["type"].as_str(),
    // rust: Some("neoforge:mod_loaded")
    // rust: | Some("neoforge:true")
    // rust: | Some("neoforge:not")
    // rust: | Some("neoforge:and")
    // rust: | Some("neoforge:or")
    // rust: ) {
    // rust: return false;
}
    // The whole tree must be known, not only this node: an unknown kind
    // nested inside `not` or a combinator leaves the file out too.
    // rust: match c["type"].as_str() {
    // rust: Some("neoforge:not") => known(&c["value"]),
    // rust: Some("neoforge:and") | Some("neoforge:or") => {
    // rust: c["values"].as_array().into_iter().flatten().all(known)
}
    // rust: _ => true,
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

loaded :: proc(id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(id, "minecraft" | "create")
}

a_file_without_conditions_loads :: proc() {
}
    // rust: assert!(conditions_hold(
    // rust: &json!({"type": "minecraft:crafting"}),
    // rust: &loaded
    // rust: ));
}

mod_loaded_follows_the_answer_and_minecraft_always_holds :: proc() {
}
    // rust: assert!(conditions_hold(
    // rust: &json!({"neoforge:conditions": [{"type": "neoforge:mod_loaded", "modid": "create"}]}),
    // rust: &loaded
    // rust: ));
    // rust: assert!(!conditions_hold(
    // rust: &json!({"neoforge:conditions": [{"type": "neoforge:mod_loaded", "modid": "ic2"}]}),
    // rust: &loaded
    // rust: ));
    // rust: assert!(conditions_hold(
    // rust: &json!({"neoforge:conditions": [{"type": "neoforge:mod_loaded", "modid": "minecraft"}]}),
    // rust: &loaded
    // rust: ));
}

not_and_or_combine_and_all_must_hold :: proc() {
}
    // rust: let not = json!({"type": "neoforge:not", "value": {"type": "neoforge:mod_loaded", "modid": "ic2"}});
    // rust: let mut c = serde_json::Map::new();
    // rust: c.insert("neoforge:conditions".to_owned(), json!([not]));
    // rust: assert!(conditions_hold(&Value::Object(c.clone()), &loaded));
    // rust: let both = json!([
    // rust: {"type": "neoforge:mod_loaded", "modid": "create"},
    // rust: {"type": "neoforge:or", "values": [
    // rust: {"type": "neoforge:mod_loaded", "modid": "ic2"},
    // rust: {"type": "neoforge:true"}
    // rust: ]}
    // rust: ]);
    // rust: c.insert("neoforge:conditions".to_owned(), both);
    // rust: assert!(conditions_hold(&Value::Object(c), &loaded));
        // One failing condition in the list fails the file.
    // rust: let failing = json!([
    // rust: {"type": "neoforge:true"},
    // rust: {"type": "neoforge:mod_loaded", "modid": "ic2"}
    // rust: ]);
    // rust: let mut f = serde_json::Map::new();
    // rust: f.insert("neoforge:conditions".to_owned(), failing);
    // rust: assert!(!conditions_hold(&Value::Object(f), &loaded));
}

an_unknown_kind_nested_in_the_tree_leaves_the_file_out :: proc() {
}
        // `not` of `not` of an unknown: the unknown is two levels down.
    // rust: let nested_not = json!({
    // rust: "neoforge:conditions": [
    // rust: {"type": "neoforge:not", "value":
    // rust: {"type": "neoforge:not", "value":
    // rust: {"type": "example:unknown"}}}
    // rust: ]
    // rust: });
    // rust: assert!(!conditions_hold(&nested_not, &loaded));
        // `or` with a `true` beside a `not` of an unknown: one child is
        // known-true, but the other's subtree holds an unknown.
    // rust: let nested_or = json!({
    // rust: "neoforge:conditions": [
    // rust: {"type": "neoforge:or", "values": [
    // rust: {"type": "neoforge:true"},
    // rust: {"type": "neoforge:not", "value":
    // rust: {"type": "example:unknown"}}
    // rust: ]}
    // rust: ]
    // rust: });
    // rust: assert!(!conditions_hold(&nested_or, &loaded));
}

an_unknown_condition_does_not_load_the_file :: proc() {
}
    // rust: let mut c = serde_json::Map::new();
    // rust: c.insert(
    // rust: "neoforge:conditions".to_owned(),
    // rust: json!([{"type": "neoforge:future_thing"}]),
    // rust: );
    // rust: assert!(!conditions_hold(&Value::Object(c), &loaded));
}
}
