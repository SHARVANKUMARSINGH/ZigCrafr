//! Transpiled from Horizon Rust crate
package horizon_assets_foreign_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

node :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: ItemModelNode::decode(&serde_json::from_str(json).unwrap())
}
model_id :: proc(n: ^ItemModelNode) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match n {
    // rust: ItemModelNode::Model(leaf) => &leaf.model,
    // rust: other => panic!("not a model: {other:?}"),
}
}

node_with_a_model_id_draws_that_model :: proc() {
}
    // rust: let n = node(r#"{"type":"mod:thing","model":"mod:item/thing","tints":[{"type":"mod:tint"}]}"#)
    // rust: .unwrap();
    // rust: assert_eq!(model_id(&n), "mod:item/thing");
    // rust: let ItemModelNode::Model(leaf) = n else {
    // rust: unreachable!()
}
    // rust: assert_eq!(leaf.tints, vec![TintSource::Constant(-1)]);
    // rust: let n = node(r#"{"type":"mod:thing","base_model":"mod:item/base"}"#).unwrap();
    // rust: assert_eq!(model_id(&n), "mod:item/base");
    // rust: let n = node(r#"{"type":"mod:thing","on_model":"mod:item/a"}"#).unwrap();
    // rust: assert_eq!(model_id(&n), "mod:item/a");
}

node_with_a_nested_node_decodes_it :: proc() {
}
    // rust: let n = node(
    // rust: r#"{"type":"neoforge:trimmed_armor","base_model":{"type":"minecraft:model","model":"mod:item/boots"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(model_id(&n), "mod:item/boots");
    // rust: let n = node(
    // rust: r#"{"type":"mod:x","model":{"type":"mod:y","model":"mod:item/inner"},"transformation":[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let ItemModelNode::Composite {
    // rust: models,
    // rust: transformation,
    // rust: } = n
    // rust: else {
    // rust: panic!("a transformation wraps the nested node")
}
    // rust: assert!(transformation.is_some());
    // rust: assert_eq!(model_id(&models[0]), "mod:item/inner");
}

node_with_nothing_usable_is_empty :: proc() {
}
    // rust: assert!(matches!(
    // rust: node(r#"{"type":"mod:facade"}"#).unwrap(),
    // rust: ItemModelNode::Empty
    // rust: ));
    // rust: assert!(matches!(
    // rust: node(r#"{"type":"mod:x","model":7}"#).unwrap(),
    // rust: ItemModelNode::Empty
    // rust: ));
    // rust: assert!(ClientItem::from_json(r#"{"model":{"type":"ae2:facade"}}"#).is_ok());
}

unknown_vanilla_names_still_fail :: proc() {
}
    // rust: assert!(node(r#"{"type":"minecraft:nope"}"#).is_err());
    // rust: assert!(node(r#"{"type":"nope","model":"a:b"}"#).is_err());
    // rust: let leaf = r#"{"type":"minecraft:model","model":"a:b"}"#;
    // rust: for json in [
    // rust: format!(
    // rust: r#"{{"type":"minecraft:condition","property":"minecraft:nope","on_true":{leaf},"on_false":{leaf}}}"#
    // rust: ),
    // rust: format!(
    // rust: r#"{{"type":"minecraft:select","property":"minecraft:nope","cases":[],"fallback":{leaf}}}"#
    // rust: ),
    // rust: format!(
    // rust: r#"{{"type":"minecraft:range_dispatch","property":"minecraft:nope","entries":[],"fallback":{leaf}}}"#
    // rust: ),
    // rust: ] {
    // rust: assert!(node(&json).is_err(), "{json}");
}
    // rust: assert!(
    // rust: node(r#"{"type":"minecraft:special","base":"a:b","model":{"type":"minecraft:nope"}}"#)
    // rust: .is_err()
    // rust: );
    // rust: assert!(ClientItem::from_json(r#"{"model":{"type":"minecraft:nope"}}"#).is_err());
}

condition_property_is_false :: proc() {
}
    // rust: let n = node(
    // rust: r#"{"type":"minecraft:condition","property":"mod:flag",
    // rust: "on_true":{"type":"minecraft:model","model":"a:yes"},
    // rust: "on_false":{"type":"minecraft:model","model":"a:no"}}"#,
    // rust: )
    // rust: .unwrap();
    // A mod's property stays a condition its mod answers per stack
    // (`item_model_property`); with no mod answering it, `on_false` is drawn.
    // rust: let ItemModelNode::Condition {
    // rust: property: ConditionProperty::Custom(property),
    // rust: on_false,
    // rust: ..
    // rust: } = &n
    // rust: else {
    // rust: panic!("not a custom condition: {n:?}")
}
    // rust: assert_eq!(property, "mod:flag");
    // rust: assert_eq!(model_id(on_false), "a:no");
}

select_property_takes_the_fallback_or_nothing :: proc() {
}
    // rust: let n = node(
    // rust: r#"{"type":"minecraft:select","property":"mod:level",
    // rust: "cases":[{"when":"low","model":{"type":"minecraft:model","model":"a:low"}}],
    // rust: "fallback":{"type":"minecraft:model","model":"a:other"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(model_id(&n), "a:other");
    // rust: let n = node(r#"{"type":"minecraft:select","property":"mod:level","cases":[]}"#).unwrap();
    // rust: assert!(matches!(n, ItemModelNode::Empty));
}

range_property_reads_zero :: proc() {
}
    // rust: let entry = |t: f32, m: &str| {
    // rust: format!(r#"{{"threshold":{t},"model":{{"type":"minecraft:model","model":"{m}"}}}}"#)
}
    // rust: let fallback = r#","fallback":{"type":"minecraft:model","model":"a:fb"}"#;
    // rust: let make = |entries: &[String], fallback: &str| {
    // rust: node(&format!(
    // rust: r#"{{"type":"minecraft:range_dispatch","property":"mod:fill","entries":[{}]{fallback}}}"#,
    // rust: entries.join(",")
    // rust: ))
    // rust: .unwrap()
}
    // rust: let n = make(&[entry(0.2, "a:one"), entry(0.4, "a:two")], fallback);
    // rust: assert_eq!(model_id(&n), "a:fb");
    // rust: let n = make(
    // rust: &[
    // rust: entry(0.0, "a:zero"),
    // rust: entry(-1.0, "a:neg"),
    // rust: entry(0.5, "a:half"),
    // rust: ],
    // rust: fallback,
    // rust: );
    // rust: assert_eq!(model_id(&n), "a:zero");
    // rust: let n = make(&[entry(0.2, "a:one")], "");
    // rust: assert!(matches!(n, ItemModelNode::Empty));
}

special_type_keeps_its_base_model :: proc() {
}
    // rust: let n = node(
    // rust: r#"{"type":"minecraft:special","base":"mod:item/cube","model":{"type":"mod:energy_cube"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(model_id(&n), "mod:item/cube");
    // rust: let n =
    // rust: node(r#"{"type":"minecraft:special","base":"a:b","model":{"type":"minecraft:shield"}}"#)
    // rust: .unwrap();
    // rust: assert!(matches!(n, ItemModelNode::Special { .. }));
}

fluid_container_draws_its_base_without_the_fluid :: proc() {
}
    // rust: let n = node(
    // rust: r#"{"type":"neoforge:fluid_container","fluid":"mod:gas","cover_is_mask":false,"flip_gas":true,
    // rust: "textures":{"base":"minecraft:item/bucket","fluid":"neoforge:item/mask/bucket_fluid"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(model_id(&n), "minecraft:item/bucket");
    // rust: let n = node(
    // rust: r#"{"type":"neoforge:fluid_container","cover_is_mask":false,
    // rust: "textures":{"base":"a:item/flask","cover":"a:item/flask_cover"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let ItemModelNode::Composite { models, .. } = n else {
    // rust: panic!("base and cover")
}
    // rust: assert_eq!(models.len(), 2);
    // rust: assert!(matches!(
    // rust: node(r#"{"type":"neoforge:fluid_container"}"#).unwrap(),
    // rust: ItemModelNode::Empty
    // rust: ));
}
