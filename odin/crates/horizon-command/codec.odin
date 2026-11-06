//! Transpiled from Horizon Rust crate
package horizon_command_codec

import "core:fmt"
import "core:mem"
import "core:math"

// ResourceOrIdArgument and the data-fixer-upper decoding of inline values
// commands accept (loot predicates, item modifiers, slot sources, context
// providers, dialogs), reproducing the codec error messages vanilla reports.
// use super::args::{Registries, is_id_char, parse_identifier};
// use super::{CmdResult, CommandError, Reader};
// use horizon_world::nbt::{Compound, JavaString, Tag};

snbt :: proc(t: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: horizon_client_core::snbt::to_snbt(t)
}
not_map :: proc(t: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("Not a map: {}", snbt(t))
}
not_list :: proc(t: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("Not a list: {}", snbt(t))
}
no_key :: proc(key: string, t: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("No key {key} in MapLike[{}]", snbt(t))
}
either :: proc(a: string, b: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("Failed to parse either. First: {a}; Second: {b}")
}
    // rust: pub fn get<'t>(map: &'t Compound, key: &str) -> Option<&'t Tag> {
    // rust: map.get(&JavaString::from(key))
}
is_number :: proc(t: ^Tag) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: t,
    // rust: Tag::Byte(_) | Tag::Short(_) | Tag::Int(_) | Tag::Long(_) | Tag::Float(_) | Tag::Double(_)
    // rust: )
}
as_string :: proc(t: ^Tag) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match t {
    // rust: Tag::String(s) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}

// KeyDispatchCodec over a type registry: the map, its `type` and the
// type's own fields (`fields` checks them).
    // rust: fn dispatch(
    // rust: t: &Tag,
    // rust: reg: &Registries,
    // rust: type_registry: &str,
    // rust: fields: &dyn Fn(&str, &Compound, &Tag) -> Result<(), String>,
    // rust: ) -> Result<(), String> {
    // rust: let Tag::Compound(map) = t else {
    // rust: return Err(not_map(t));
}
    // rust: let Some(ty) = get(map, "type") else {
    // rust: return Err(no_key("type", t));
}
    // rust: let Some(name) = as_string(ty) else {
    // rust: return Err("Not a string".into());
}
    // rust: let Some(id) = parse_identifier(&name) else {
    // rust: return Err(format!("Not a valid resource location: {name}"));
}
    // rust: let known = reg.ids(type_registry);
    // rust: if !known.is_empty() && !known.contains(&id) {
    // rust: return Err(format!(
    // rust: "Unknown registry key in ResourceKey[minecraft:root / {type_registry}]: {id}"
    // rust: ));
}
    // rust: fields(&id, map, t)
}
// Required fields, reported in vanilla's order when missing.
require :: proc(map: ^Compound, t: ^Tag, keys: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let missing: Vec<String> = keys
    // rust: .iter()
    // rust: .filter(|k| get(map, k).is_none())
    // rust: .map(|k| no_key(k, t))
    // rust: .collect();
    // rust: if missing.is_empty() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(missing.join("; "))
}
}
// The required fields of each context number provider type, in the
// order DataFixerUpper reports them missing (the reverse of the record's).
provider_fields :: proc(id: string, map: ^Compound, t: ^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match id.trim_start_matches("minecraft:") {
    // rust: "uniform" => require(map, t, &["max", "min"]),
    // rust: "constant" => require(map, t, &["value"]),
    // rust: "binomial" => require(map, t, &["p", "n"]),
    // rust: "add" | "mul" | "avg" | "max" | "min" | "length" => require(map, t, &["inputs"]),
    // rust: "sub" | "div" | "mod" | "floor_div" | "floor_mod" => require(map, t, &["right", "left"]),
    // rust: "pow" => require(map, t, &["exponent", "base"]),
    // rust: "abs" | "negate" | "from_float" | "from_int" | "floor" | "ceil" | "round" | "sqrt"
    // rust: | "sin" | "cos" | "truncate" => require(map, t, &["input"]),
    // rust: "conditional" => require(map, t, &["on_true", "condition"]),
    // rust: "number_dispatcher" => require(map, t, &["cases"]),
    // rust: "weighted_list" => require(map, t, &["distribution"]),
    // rust: "enchantment_level" => require(map, t, &["amount"]),
    // rust: "score" => require(map, t, &["score", "target"]),
    // rust: _ => Ok(()),
}
}
// A holder list codec: a single element, a `#tag`, or a list.
element_or_list :: proc(t: ^Tag, element: ^dyn Fn(^Tag) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let first = match element(t) {
    // rust: Ok(()) => return Ok(()),
    // rust: Err(e) => e,
}
    // rust: let tag_ref = match as_string(t) {
    // rust: Some(s) if s.starts_with('#') => return Ok(()),
    // rust: Some(_) => "Not a tag id".to_owned(),
    // rust: None => "Not a string".to_owned(),
}
    // rust: let list = match t {
    // rust: Tag::List(items) => {
    // rust: let errors: Vec<String> = items.iter().filter_map(|i| element(i).err()).collect();
    // rust: if errors.is_empty() {
    // rust: return Ok(());
}
    // rust: errors.join("; ")
}
    // rust: _ => not_list(t),
}
    // rust: let last = element(t).err().unwrap_or_default();
    // rust: Err(either(first, either(tag_ref, either(list, last))))
}

// CompositeLootItemCondition.createCodec / InvertedLootItemCondition:
// required inline combinator children must decode before command execution.
predicate_fields :: proc(id: string, map: ^Compound, t: ^Tag, reg: ^Registries) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match id.trim_start_matches("minecraft:") {
    // rust: "all_of" | "any_of" => {
    // rust: require(map, t, &["terms"])?;
    // rust: let terms = get(map, "terms").expect("required field");
    // rust: let Tag::List(terms) = terms else {
    // rust: return Err(not_list(terms));
}
    // rust: for term in terms {
    // rust: decode("minecraft:predicate", term, reg)?;
}
    // rust: Ok(())
}
    // rust: "inverted" => {
    // rust: require(map, t, &["term"])?;
    // rust: decode(
    // rust: "minecraft:predicate",
    // rust: get(map, "term").expect("required field"),
    // rust: reg,
    // rust: )
}
        // Other predicate families retain their existing codec/evaluator paths.
    // rust: _ => Ok(()),
}
}

// Decode an inline value of a ResourceOrIdArgument registry.
decode :: proc(registry: string, t: ^Tag, reg: ^Registries) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match registry {
    // rust: "minecraft:context_int_provider" | "minecraft:context_float_provider" => {
    // rust: if is_number(t) {
    // rust: return Ok(());
}
    // rust: let ty = format!("{registry}_type");
    // rust: let second = dispatch(t, reg, &ty, &provider_fields);
    // rust: second.map_err(|e| either("Not a number".into(), e))
}
    // rust: "minecraft:predicate" => {
    // rust: dispatch(t, reg, "minecraft:loot_condition_type", &|id, map, t| {
    // rust: predicate_fields(id, map, t, reg)
    // rust: })
}
    // rust: "minecraft:item_modifier" => element_or_list(t, &|x| {
    // rust: dispatch(x, reg, "minecraft:loot_function_type", &|_, _, _| Ok(()))
    // rust: }),
    // rust: "minecraft:slot_source" => element_or_list(t, &|x| {
    // rust: dispatch(x, reg, "minecraft:slot_source_type", &|id, map, t| {
    // rust: if id == "minecraft:contents" {
    // rust: require(map, t, &["component"])?;
    // rust: let value = get(map, "component").expect("required component");
    // rust: let name = as_string(value).ok_or_else(|| "Not a string".to_owned())?;
    // rust: let component = parse_identifier(&name)
    // rust: .ok_or_else(|| format!("Not a valid resource location: {name}"))?;
    // rust: let known = reg.ids("minecraft:data_component_type");
    // rust: if !known.is_empty() && !known.contains(&component) {
    // rust: return Err(format!(
    // rust: "Unknown registry key in ResourceKey[minecraft:root / minecraft:data_component_type]: {component}"
    // rust: ));
}
    // rust: if !matches!(
    // rust: component.as_str(),
    // rust: "minecraft:container"
    // rust: | "minecraft:bundle_contents"
    // rust: | "minecraft:charged_projectiles"
    // rust: ) {
    // rust: return Err("No items in component".into());
}
}
    // rust: Ok(())
    // rust: })
    // rust: }),
        // Dialog types: CommonDialogData's title, then each type's own.
    // rust: "minecraft:dialog" => dispatch(t, reg, "minecraft:dialog_type", &|id, map, t| {
    // rust: let own: &[&str] = match id {
    // rust: "minecraft:confirmation" => &["yes", "no"],
    // rust: "minecraft:multi_action" => &["actions"],
    // rust: "minecraft:dialog_list" => &["dialogs"],
    // rust: _ => &[],
}
    // rust: let keys: Vec<&str> = std::iter::once("title")
    // rust: .chain(own.iter().copied())
    // rust: .collect();
    // rust: require(map, t, &keys)
    // rust: }),
    // rust: "minecraft:worldgen/feature" | "minecraft:loot_table" => match t {
    // rust: Tag::Compound(_) => Ok(()),
    // rust: _ => Err(not_map(t)),
    // rust: },
    // rust: _ => Ok(()),
}
}

// Identifier.readNonEmpty (None when empty or invalid).
read_non_empty :: proc(reader: ^Reader) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let start = reader.cursor;
    // rust: while reader.can_read() && is_id_char(reader.peek()) {
    // rust: reader.skip();
}
    // rust: let raw = &reader.string[start..reader.cursor];
    // rust: let id = if raw.is_empty() {
    // rust: None
    // rust: } else {
    // rust: parse_identifier(raw)
}
    // rust: if id.is_none() {
    // rust: reader.cursor = start;
}
    // rust: id
}

// ResourceOrIdArgument.parse: a registry id (checked) or an inline SNBT
// value decoded with the registry's codec.
resource_or_id :: proc(reader: ^Reader, reg: ^Registries, registry: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let start = reader.cursor;
    // rust: let mut r = reader.clone();
    // rust: r.skip_whitespace();
    // rust: if let Some(id) = read_non_empty(&mut r) {
    // rust: reader.cursor = r.cursor;
    // rust: if !reg.ids(registry).contains(&id) {
    // rust: return Err(CommandError::tr_at(
    // rust: "argument.resource_or_id.no_such_element",
    // rust: &[&id, &registry],
    // rust: reader,
    // rust: ));
}
    // rust: return Ok(());
}
    // rust: reader.cursor = start;
    // rust: let tag = super::snbt::parse_tag_argument(reader)?;
    // rust: decode(registry, &tag, reg)
    // rust: .map_err(|m| CommandError::tr_at("argument.resource_or_id.failed_to_parse", &[&m], reader))
}

    // rust: mod predicate_tests {
//     use super::*;

inline_constant_combinators_require_decodable_children :: proc() {
}
    // rust: let reg = Registries::default();
    // rust: let decode_text = |text| {
    // rust: let (tag, _) = horizon_world::nbt::parse_snbt(text).unwrap();
    // rust: decode("minecraft:predicate", &tag, &reg)
}
    // rust: assert!(decode_text(r#"{type:"minecraft:all_of",terms:[{type:"minecraft:inverted",term:{type:"minecraft:any_of",terms:[]}}]}"#).is_ok());
    // rust: assert_eq!(
    // rust: decode_text(r#"{type:"minecraft:all_of"}"#),
    // rust: Err(r#"No key terms in MapLike[{type:"minecraft:all_of"}]"#.into())
    // rust: );
    // rust: assert_eq!(
    // rust: decode_text(r#"{type:"minecraft:inverted"}"#),
    // rust: Err(r#"No key term in MapLike[{type:"minecraft:inverted"}]"#.into())
    // rust: );
    // rust: for bad in [
    // rust: r#"{type:"minecraft:all_of",terms:[{}]}"#,
    // rust: r#"{type:"minecraft:inverted",term:{}}"#,
    // rust: ] {
    // rust: assert_eq!(decode_text(bad), Err("No key type in MapLike[{}]".into()));
}
}
}

    // rust: mod contents_component_tests {
//     use super::*;

only_component_collections_are_admitted_for_contents_sources :: proc() {
}
    // rust: let reg = Registries::default();
    // rust: for component in [
    // rust: "container",
    // rust: "bundle_contents",
    // rust: "charged_projectiles",
    // rust: "damage",
    // rust: ] {
    // rust: let raw = Tag::compound([
    // rust: ("type", Tag::String("contents".into())),
    // rust: ("component", Tag::String(component.into())),
    // rust: (
    // rust: "slot_source",
    // rust: Tag::compound([
    // rust: ("type", Tag::String("slot_range".into())),
    // rust: ("slots", Tag::String("container.0".into())),
    // rust: ]),
    // rust: ),
    // rust: ]);
    // rust: let result = decode("minecraft:slot_source", &raw, &reg);
    // rust: if component == "damage" {
                // Exact outer codec error independently captured from Java.
    // rust: assert_eq!(result, Err(r#"Failed to parse either. First: No items in component; Second: Failed to parse either. First: Not a string; Second: Failed to parse either. First: Not a list: {component:"damage",slot_source:{slots:"container.0",type:"slot_range"},type:"contents"}; Second: No items in component"#.into()));
    // rust: } else {
    // rust: assert_eq!(result, Ok(()));
}
}
}
}
