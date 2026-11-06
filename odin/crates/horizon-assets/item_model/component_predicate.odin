//! Transpiled from Horizon Rust crate
package horizon_assets_component_predicate

import "core:fmt"
import "core:mem"
import "core:math"

// Component conditions used by enchantment-dependent item models.
// use super::*;

// `DataComponentPredicate.singleCodec`: a single predicate's type discriminator
// (`predicate`) and its wrapped codec's separate `value` field.
    // rust: pub(super) fn decode(m: &Map<String, Value>) -> Result<Value> {
    // rust: let id = component_type(required(m, "predicate")?)?;
    // rust: let mut value = required(m, "value")?.clone();
    // rust: if matches!(
    // rust: id.as_str(),
    // rust: "minecraft:enchantments" | "minecraft:stored_enchantments"
    // rust: ) {
    // rust: let mut entries = Vec::new();
    // rust: for entry in list(&value)? {
    // rust: let mut entry = object(entry)?.clone();
    // rust: if let Some(selector) = get(&entry, "enchantments") {
    // rust: let selector = match selector {
    // rust: Value::Array(ids) => Value::Array(
    // rust: ids.iter()
    // rust: .map(ident)
    // rust: .map(|r| r.map(Value::String))
    // rust: .collect::<Result<_>>()?,
    // rust: ),
    // rust: Value::String(name) if name.starts_with('#') => {
    // rust: Value::String(format!("#{}", identifier(&name[1..])?))
}
    // rust: _ => Value::String(ident(selector)?),
}
    // rust: entry.insert("enchantments".into(), selector);
}
    // rust: if let Some(levels) = get(&entry, "levels") {
    // rust: let levels = if levels.is_object() {
    // rust: let mut bounds = Map::new();
    // rust: for key in ["min", "max"] {
    // rust: if let Some(n) = get(object(levels)?, key) {
    // rust: bounds.insert(key.into(), Value::from(int(n)?));
}
}
                    // MinMaxBounds.Bounds.validateSwappedBoundsInCodec.
    // rust: if bounds
    // rust: .get("min")
    // rust: .and_then(Value::as_i64)
    // rust: .zip(bounds.get("max").and_then(Value::as_i64))
    // rust: .is_some_and(|(min, max)| min > max)
    // rust: {
    // rust: return Err(err("minimum exceeds maximum"));
}
    // rust: Value::Object(bounds)
    // rust: } else {
    // rust: Value::from(int(levels)?)
}
    // rust: entry.insert("levels".into(), levels);
}
    // rust: entries.push(Value::Object(entry));
}
    // rust: value = Value::Array(entries);
}
    // rust: Ok(Value::Object(Map::from_iter([(id, value)])))
}

// `EnchantmentsPredicate.matches` and `EnchantmentPredicate.containedIn`:
// all entries must match; each entry needs one selected, present enchantment
// with a matching level. An empty predicate list still needs the component.
    // rust: pub(super) fn matches(
    // rust: predicate: &Value,
    // rust: components: &Components,
    // rust: env: &dyn ItemEnv,
    // rust: ) -> Option<bool> {
    // rust: let (id, expected) = predicate.as_object()?.iter().next()?;
    // rust: if !matches!(
    // rust: id.as_str(),
    // rust: "minecraft:enchantments" | "minecraft:stored_enchantments"
    // rust: ) {
    // rust: return None;
}
    // rust: let Some(have) = components.get(id).and_then(Value::as_object) else {
    // rust: return Some(false);
}
    // rust: Some(expected.as_array()?.iter().all(|entry| {
    // rust: let Some(entry) = entry.as_object() else {
    // rust: return false;
}
    // rust: have.iter().any(|(id, level)| {
    // rust: let level = level.as_i64().unwrap_or(0);
    // rust: let selector = get(entry, "enchantments");
    // rust: let selected = match selector {
    // rust: None => true,
    // rust: Some(Value::String(s)) => s
    // rust: .strip_prefix('#')
    // rust: .map_or(s == id, |tag| env.enchantment_in_tag(id, tag)),
    // rust: Some(Value::Array(ids)) => ids.iter().any(|s| s.as_str() == Some(id)),
    // rust: _ => false,
}
    // rust: selected
    // rust: && if selector.is_some() {
    // rust: matches_enchantment(level, get(entry, "levels"))
    // rust: } else {
    // rust: level_matches(level, get(entry, "levels"))
}
    // rust: })
    // rust: }))
}

// `EnchantmentPredicate.matchesEnchantment`: a named enchantment needs a
// nonzero level even when its bounds accept zero.
matches_enchantment :: proc(level: i64, bounds: Maybe(^Value)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: level != 0 && level_matches(level, bounds)
}

// `MinMaxBounds.Ints.matches`: inclusive bounds, or an exact integer.
level_matches :: proc(level: i64, bounds: Maybe(^Value)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: match bounds {
    // rust: None => true,
    // rust: Some(Value::Number(n)) => n.as_i64() == Some(level),
    // rust: Some(Value::Object(bounds)) => {
    // rust: get(bounds, "min")
    // rust: .and_then(Value::as_i64)
    // rust: .is_none_or(|min| level >= min)
    // rust: && get(bounds, "max")
    // rust: .and_then(Value::as_i64)
    // rust: .is_none_or(|max| level <= max)
}
    // rust: _ => false,
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

Tags :: struct {
    // rust: impl ItemEnv for Tags {
enchantment_in_tag :: proc(self: ^Self, enchantment: string, tag: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: enchantment == "minecraft:density" && tag == "horizon:mace"
}
}

unnamed_predicates_inspect_entries_but_named_ones_require_a_nonzero_level :: proc() {
}
    // rust: let components = Components::from_iter([(
    // rust: "minecraft:enchantments".into(),
    // rust: json!({"minecraft:density":0}),
    // rust: )]);
    // rust: assert_eq!(
    // rust: matches(&json!({"minecraft:enchantments":[{}]}), &components, &NoEnv),
    // rust: Some(true)
    // rust: );
    // rust: assert_eq!(
    // rust: matches(
    // rust: &json!({"minecraft:enchantments":[{"enchantments":"minecraft:density"}]}),
    // rust: &components,
    // rust: &NoEnv
    // rust: ),
    // rust: Some(false)
    // rust: );
}

enchantment_selectors_use_the_hosts_registry_tags :: proc() {
}
    // rust: let condition = json!({"predicate":"enchantments", "value":[
    // rust: {"enchantments":"#horizon:mace", "levels":{"min":3}}
    // rust: ]});
    // rust: let predicate = decode(condition.as_object().unwrap()).unwrap();
    // rust: let mut components = Components::from_iter([(
    // rust: "minecraft:enchantments".into(),
    // rust: json!({"minecraft:density":3}),
    // rust: )]);
    // rust: assert_eq!(matches(&predicate, &components, &Tags), Some(true));
    // rust: assert_eq!(matches(&predicate, &components, &NoEnv), Some(false));
    // rust: components.insert(
    // rust: "minecraft:enchantments".into(),
    // rust: json!({"minecraft:density":2}),
    // rust: );
    // rust: assert_eq!(matches(&predicate, &components, &Tags), Some(false));
}
}
