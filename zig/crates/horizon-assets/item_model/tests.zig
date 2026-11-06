//! Transpiled from Horizon Rust crate
//! Module: horizon-assets_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;

pub fn identifier_adds_default_namespace() void {
}
    // rust: assert_eq!(identifier("stone").unwrap(), "minecraft:stone");
    // rust: assert_eq!(identifier("a:b").unwrap(), "a:b");
}

pub fn positive_modulo_wraps_negatives() void {
}
    // rust: assert!((positive_modulo(-0.25, 1.0) - 0.75).abs() < 1e-6);
    // rust: assert!((positive_modulo(1.5, 1.0) - 0.5).abs() < 1e-6);
}

pub fn display_context_names_round_trip() void {
}
    // rust: for name in ["gui", "ground", "fixed", "head"] {
    // rust: assert_eq!(DisplayContext::by_name(name).unwrap().name(), name);
}
}

pub fn a_mods_tint_source_is_untinted_and_an_unknown_vanilla_one_fails() void {
}
    // rust: let tint = |json: &str| TintSource::decode(&serde_json::from_str(json).unwrap());
    // rust: assert_eq!(
    // rust: tint(r#"{"type":"ae2:storage_cell_state"}"#).unwrap(),
    // rust: TintSource::Constant(-1)
    // rust: );
    // rust: assert!(tint(r#"{"type":"minecraft:nonsense"}"#).is_err());
}

pub fn custom_condition_is_evaluated_per_stack_at_branch_selection() void {
}
pub const Env = struct {};
    // rust: impl ItemEnv for Env {
pub fn item_model_property(self: *Self, property: []const u8, stack: *StackView) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert_eq!(property, "example:charged");
    // rust: stack.count > 1 && stack.patch.get("example:charged") == Some(&Some(Value::Bool(true)))
}
}
    // rust: let definition = ClientItem::from_json(
    // rust: r#"{"model":{
    // rust: "type":"minecraft:condition", "property":"example:charged",
    // rust: "on_true":{"type":"minecraft:model","model":"example:item/charged"},
    // rust: "on_false":{"type":"minecraft:model","model":"example:item/idle"}
    // rust: }}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let mut models = ItemModels::default();
    // rust: models.definitions.insert("example:tool".into(), definition);
    // rust: models.prototypes.insert(
    // rust: "example:tool".into(),
    // rust: BTreeMap::from([(
    // rust: "minecraft:item_model".into(),
    // rust: Value::String("example:tool".into()),
    // rust: )]),
    // rust: );
    // rust: let context = Context {
    // rust: display: DisplayContext::Gui,
    // rust: owner: None,
    // rust: level: None,
    // rust: seed: 0,
}
    // rust: let mut stack = StackView::new("example:tool", 1);
    // rust: let chosen = |stack: &StackView, env: &dyn ItemEnv| {
    // rust: let resolved = models.resolve(stack, &context, env);
    // rust: assert_eq!(resolved.layers.len(), 1);
    // rust: let LayerContent::Model { model } = &resolved.layers[0].content else {
    // rust: panic!("expected model leaf")
}
    // rust: model.clone()
}
    // rust: assert_eq!(chosen(&stack, &NoEnv), "example:item/idle");
    // rust: assert_eq!(chosen(&stack, &Env), "example:item/idle");
    // rust: stack
    // rust: .patch
    // rust: .insert("example:charged".into(), Some(Value::Bool(true)));
    // rust: assert_eq!(chosen(&stack, &Env), "example:item/idle");
    // rust: stack.count = 2;
    // rust: assert_eq!(chosen(&stack, &Env), "example:item/charged");
    // rust: assert_eq!(chosen(&stack, &NoEnv), "example:item/idle");
    // rust: stack.patch.insert("example:charged".into(), None);
    // rust: assert_eq!(chosen(&stack, &Env), "example:item/idle");
}

pub fn custom_condition_validates_its_name_and_both_branches() void {
}
    // rust: let node = |property: &str, on_true: Value| {
    // rust: ItemModelNode::decode(&serde_json::json!({
    // rust: "type": "minecraft:condition", "property": property,
    // rust: "on_true": on_true, "on_false": {"type": "minecraft:empty"}
    // rust: }))
}
    // rust: let empty = serde_json::json!({"type": "minecraft:empty"});
    // rust: for name in [
    // rust: "minecraft:unknown",
    // rust: "unknown",
    // rust: "example:Bad",
    // rust: "bad name:charged",
    // rust: ] {
    // rust: assert!(node(name, empty.clone()).is_err(), "{name}");
}
    // rust: assert!(node("example:charged", Value::Null).is_err());
    // rust: assert!(matches!(
    // rust: node("minecraft:damaged", empty.clone()).unwrap(),
    // rust: ItemModelNode::Condition {
    // rust: property: ConditionProperty::Damaged,
    // rust: ..
}
    // rust: ));
    // rust: assert!(matches!(node("example:charged", empty).unwrap(),
    // rust: ItemModelNode::Condition { property: ConditionProperty::Custom(name), .. } if name == "example:charged"));
}
