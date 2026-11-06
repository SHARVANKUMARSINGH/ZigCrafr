//! Transpiled from Horizon Rust crate
package horizon_world_codec

import "core:fmt"
import "core:mem"
import "core:math"

// Bounded numeric-condition registry loading and direct/holder JSON codecs.
// use super::MaterialCondition;
// use crate::worldgen::{
    // rust: DecodeError, Object, anchor::VerticalAnchor, double, int_range, integer, optional, required,
}
// use serde_json::{Value, value::RawValue};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::Arc,
}

    // rust: pub(super) fn identifier(name: &str) -> Result<String, DecodeError> {
    // rust: let (namespace, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let namespace = if namespace.is_empty() {
    // rust: "minecraft"
    // rust: } else {
    // rust: namespace
}
    // rust: let valid = |c: u8| c.is_ascii_lowercase() || c.is_ascii_digit() || b"_.-".contains(&c);
    // rust: if !namespace.bytes().all(valid) || !path.bytes().all(|c| valid(c) || c == b'/') {
    // rust: return Err(DecodeError::Field("material identifier"));
}
    // rust: Ok(format!("{namespace}:{path}"))
}
MaterialConditionReference :: struct {
    name: string,
    value: ^MaterialCondition,
}
    // rust: impl MaterialConditionReference {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.name
}
value :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.value
}
}
// A named biome-tag snapshot for a fixed world-generation configuration.
MaterialBiomeTag :: struct {
    name: string,
    members: ^[string],
}
    // rust: impl MaterialBiomeTag {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.name
}
members :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.members
}
}
BiomeCatalog :: struct {
    names: BTreeSet<string>,
    tags: BTreeMap<string,
}
MaterialConditionRegistry :: struct {
    values: BTreeMap<string,
    biomes: Maybe(^BiomeCatalog),
}
    // rust: impl MaterialConditionRegistry {
    // Load an immutable set atomically, including forward references. Cycles,
    // unresolved references and resource-limit violations are typed errors.
from_json :: proc(definitions: ^BTreeMap<string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::load(definitions, None)
}
    // Bind resolved biome tags, such as `TagDefinitions::build().tags`.
    // Names and memberships remain immutable for the lifetime of this registry.
    // rust: pub fn from_json_with_biome_tags(
    // rust: definitions: &BTreeMap<String, String>,
    // rust: biomes: &BTreeSet<String>,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if biomes.len() > 8192 || tags.len() > 8192 {
    // rust: return Err(DecodeError::Field("material biome catalog size"));
}
    // rust: let names: BTreeSet<_> = biomes
    // rust: .iter()
    // rust: .map(|name| identifier(name))
    // rust: .collect::<Result<_, _>>()?;
    // rust: let mut values = BTreeMap::new();
    // rust: let mut count = 0usize;
    // rust: for (name, members) in tags {
    // rust: count = count.saturating_add(members.len());
    // rust: if count > 65536 {
    // rust: return Err(DecodeError::Field("material biome tag size"));
}
    // rust: let mut bound = Vec::with_capacity(members.len());
    // rust: for member in members {
    // rust: let member = identifier(member)?;
    // rust: if !names.contains(&member) {
    // rust: return Err(DecodeError::Field("unknown tagged biome"));
}
    // rust: bound.push(member);
}
    // rust: if values.insert(identifier(name)?, Arc::from(bound)).is_some() {
    // rust: return Err(DecodeError::Field("duplicate biome tag"));
}
}
    // rust: Self::load(
    // rust: definitions,
    // rust: Some(Arc::new(BiomeCatalog {
    // rust: names,
    // rust: tags: values,
    // rust: })),
    // rust: )
}
    // rust: fn load(
    // rust: definitions: &BTreeMap<String, String>,
    // rust: biomes: Option<Arc<BiomeCatalog>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if definitions.len() > 8192 {
    // rust: return Err(DecodeError::Field("material registry size"));
}
    // rust: let mut loader = Loader {
    // rust: biomes,
    // rust: ..Loader::default()
}
    // rust: for (name, json) in definitions {
    // rust: if loader
    // rust: .definitions
    // rust: .insert(identifier(name)?, serde_json::from_str(json)?)
    // rust: .is_some()
    // rust: {
    // rust: return Err(DecodeError::Field("duplicate material condition"));
}
}
    // rust: let names: Vec<_> = loader.definitions.keys().cloned().collect();
    // rust: for name in names {
    // rust: loader.resolve(&name, 0)?;
}
    // rust: Ok(Self {
    // rust: values: loader.values,
    // rust: biomes: loader.biomes,
    // rust: })
}
decode :: proc(self: ^Self, json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let raw: Box<RawValue> = serde_json::from_str(json)?;
    // rust: Loader {
    // rust: values: self.values.clone(),
    // rust: biomes: self.biomes.clone(),
    // rust: ..Loader::default()
}
    // rust: .node(&raw, 0)
}
get :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = identifier(name).ok()?;
    // rust: self.values
    // rust: .get(&name)
    // rust: .map(|value| MaterialConditionReference {
    // rust: name,
    // rust: value: value.clone(),
    // rust: })
}
entries :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.values
    // rust: .iter()
    // rust: .map(|(name, value)| (name.as_str(), value.as_ref()))
}
}
Loader :: struct {
    definitions: BTreeMap<string,
    values: BTreeMap<string,
    active: BTreeSet<string>,
    biomes: Maybe(^BiomeCatalog),
    nodes: uint,
}
    // rust: impl Loader {
resolve :: proc(self: ^Self, name: string, depth: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if depth >= 256 {
    // rust: return Err(DecodeError::Field("material condition depth"));
}
    // rust: if let Some(value) = self.values.get(name) {
    // rust: return Ok(value.clone());
}
    // rust: if !self.active.insert(name.to_owned()) {
    // rust: return Err(DecodeError::Field("cyclic material condition"));
}
    // rust: let json = self
    // rust: .definitions
    // rust: .get(name)
    // rust: .ok_or(DecodeError::Field("missing material condition"))?
    // rust: .clone();
    // rust: if !json.get().starts_with('{') {
    // rust: return Err(DecodeError::Field("material definition must be direct"));
}
    // rust: let value = Arc::new(self.node(&json, depth + 1)?);
    // rust: self.active.remove(name);
    // rust: self.values.insert(name.to_owned(), value.clone());
    // rust: Ok(value)
}
node :: proc(self: ^Self, raw: ^RawValue, depth: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.nodes += 1;
    // rust: if depth >= 256 || self.nodes > 65536 {
    // rust: return Err(DecodeError::Field("material condition size"));
}
    // rust: if raw.get().starts_with('"') {
    // rust: let name = identifier(&serde_json::from_str::<String>(raw.get())?)?;
    // rust: let value = self.resolve(&name, depth + 1)?;
    // rust: return Ok(MaterialCondition::Reference(MaterialConditionReference {
    // rust: name,
    // rust: value,
    // rust: }));
}
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: let number = |name| integer(required(&object, name)?);
    // rust: let boolean = |name| {
    // rust: serde_json::from_str::<bool>(required(&object, name)?.get()).map_err(DecodeError::from)
}
    // rust: let anchor = |name| VerticalAnchor::from_json(required(&object, name)?.get());
    // rust: let multiplier = || {
    // rust: int_range(
    // rust: required(&object, "surface_depth_multiplier")?,
    // rust: "surface_depth_multiplier",
    // rust: -20,
    // rust: 20,
    // rust: )
}
    // rust: Ok(match kind.as_str() {
    // rust: "minecraft:noise_threshold" => MaterialCondition::NoiseThreshold {
    // rust: noise: identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "noise")?.get(),
    // rust: )?)?,
    // rust: min: double(required(&object, "min_threshold")?)?,
    // rust: max: double(required(&object, "max_threshold")?)?,
    // rust: is_3d: optional(&object, "is_3d")
    // rust: .map(|raw| serde_json::from_str(raw.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false),
    // rust: },
    // rust: "minecraft:temperature" => MaterialCondition::Temperature,
    // rust: "minecraft:above_preliminary_surface" => MaterialCondition::AbovePreliminarySurface,
    // rust: "minecraft:biome" => {
    // rust: let catalog = self
    // rust: .biomes
    // rust: .as_ref()
    // rust: .ok_or(DecodeError::Field("missing biome catalog"))?;
    // rust: let raw = required(&object, "biome_is")?;
    // rust: let names: Vec<String> = if raw.get().starts_with('"') {
    // rust: let name: String = serde_json::from_str(raw.get())?;
    // rust: if let Some(tag) = name.strip_prefix('#') {
    // rust: let name = identifier(tag)?;
    // rust: let members = catalog
    // rust: .tags
    // rust: .get(&name)
    // rust: .ok_or(DecodeError::Field("unknown biome tag"))?
    // rust: .clone();
    // rust: return Ok(MaterialCondition::BiomeTag(MaterialBiomeTag {
    // rust: name,
    // rust: members,
    // rust: }));
}
    // rust: vec![name]
    // rust: } else {
    // rust: serde_json::from_str(raw.get())?
}
    // rust: if names.len() > 8192 {
    // rust: return Err(DecodeError::Field("biome condition size"));
}
    // rust: let mut resolved = Vec::with_capacity(names.len());
    // rust: for name in names {
    // rust: let name = identifier(&name)?;
    // rust: if !catalog.names.contains(&name) {
    // rust: return Err(DecodeError::Field("unknown material biome"));
}
    // rust: resolved.push(name);
}
    // rust: MaterialCondition::Biome(resolved)
}
    // rust: "minecraft:hole" => MaterialCondition::Hole,
    // rust: "minecraft:steep" => MaterialCondition::Steep,
    // rust: "minecraft:y_above" => MaterialCondition::YAbove {
    // rust: anchor: anchor("anchor")?,
    // rust: surface_depth_multiplier: multiplier()?,
    // rust: add_stone_depth: boolean("add_stone_depth")?,
    // rust: },
    // rust: "minecraft:water" => MaterialCondition::Water {
    // rust: offset: number("offset")?,
    // rust: surface_depth_multiplier: multiplier()?,
    // rust: add_stone_depth: boolean("add_stone_depth")?,
    // rust: },
    // rust: "minecraft:stone_depth" => {
    // rust: let surface: String =
    // rust: serde_json::from_str(required(&object, "surface_type")?.get())?;
    // rust: let ceiling = match surface.as_str() {
    // rust: "ceiling" => true,
    // rust: "floor" => false,
    // rust: _ => return Err(DecodeError::Field("surface_type")),
}
    // rust: MaterialCondition::StoneDepth {
    // rust: offset: number("offset")?,
    // rust: add_surface_depth: boolean("add_surface_depth")?,
    // rust: secondary_depth_range: number("secondary_depth_range")?,
    // rust: ceiling,
}
}
    // rust: "minecraft:vertical_gradient" => MaterialCondition::VerticalGradient {
    // rust: random_name: identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "random_name")?.get(),
    // rust: )?)?,
    // rust: true_at_and_below: anchor("true_at_and_below")?,
    // rust: false_at_and_above: anchor("false_at_and_above")?,
    // rust: },
    // rust: "minecraft:not" => MaterialCondition::Not(Box::new(
    // rust: self.node(required(&object, "invert")?, depth + 1)?,
    // rust: )),
    // rust: _ => return Err(DecodeError::Field("unsupported material condition type")),
    // rust: })
}
}
    // rust: impl MaterialCondition {
from_json :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: MaterialConditionRegistry::default().decode(json)
}
    // Encode the vanilla codec value. Nonfinite double thresholds use the
    // same NaN/Infinity tokens as Gson; strict JSON decoding rejects those tokens.
to_json :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.encoded(0)
}
encoded :: proc(self: ^Self, depth: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if depth >= 256 {
    // rust: return Err(DecodeError::Field("material condition depth"));
}
    // rust: match self {
    // rust: Self::Not(child) => Ok(format!(
    // rust: "{{\"type\":\"minecraft:not\",\"invert\":{}}}",
    // rust: child.encoded(depth + 1)?
    // rust: )),
    // rust: Self::NoiseThreshold {
    // rust: noise,
    // rust: min,
    // rust: max,
    // rust: is_3d,
    // rust: } => {
    // rust: let number = |v: f64| {
    // rust: if v.is_nan() {
    // rust: "NaN".to_owned()
    // rust: } else if v == f64::INFINITY {
    // rust: "Infinity".to_owned()
    // rust: } else if v == f64::NEG_INFINITY {
    // rust: "-Infinity".to_owned()
    // rust: } else {
    // rust: serde_json::to_string(&v).unwrap()
}
}
    // rust: Ok(format!(
    // rust: "{{\"type\":\"minecraft:noise_threshold\",\"noise\":{},\"min_threshold\":{},\"max_threshold\":{}{}}}",
    // rust: serde_json::to_string(&identifier(noise)?)?,
    // rust: number(*min),
    // rust: number(*max),
    // rust: if *is_3d { ",\"is_3d\":true" } else { "" }
    // rust: ))
}
    // rust: _ => Ok(serde_json::to_string(&self.json_value(depth)?)?),
}
}
json_value :: proc(self: ^Self, depth: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if depth >= 256 {
    // rust: return Err(DecodeError::Field("material condition depth"));
}
    // rust: let multiplier = |value: i32| {
    // rust: if (-20..=20).contains(&value) {
    // rust: Ok(value)
    // rust: } else {
    // rust: Err(DecodeError::Field("surface_depth_multiplier"))
}
}
    // rust: let anchor = |value: VerticalAnchor| -> Result<Value, DecodeError> {
    // rust: Ok(serde_json::from_str(&value.to_json()?)?)
}
    // rust: Ok(match self {
    // rust: Self::Temperature => serde_json::json!({"type":"minecraft:temperature"}),
    // rust: Self::AbovePreliminarySurface => {
    // rust: serde_json::json!({"type":"minecraft:above_preliminary_surface"})
}
    // rust: Self::BiomeTag(tag) => {
    // rust: serde_json::json!({"type":"minecraft:biome","biome_is":format!("#{}",tag.name)})
}
    // rust: Self::Biome(names) => {
    // rust: let names = names
    // rust: .iter()
    // rust: .map(|name| identifier(name))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: let value = if names.len() == 1 {
    // rust: Value::String(names[0].clone())
    // rust: } else {
    // rust: serde_json::to_value(names)?
}
    // rust: serde_json::json!({"type":"minecraft:biome","biome_is":value})
}
    // rust: Self::Hole => serde_json::json!({"type":"minecraft:hole"}),
    // rust: Self::Steep => serde_json::json!({"type":"minecraft:steep"}),
    // rust: Self::YAbove {
    // rust: anchor: a,
    // rust: surface_depth_multiplier,
    // rust: add_stone_depth,
    // rust: } => {
    // rust: serde_json::json!({"type":"minecraft:y_above","anchor":anchor(*a)?,"surface_depth_multiplier":multiplier(*surface_depth_multiplier)?,"add_stone_depth":add_stone_depth})
}
    // rust: Self::Water {
    // rust: offset,
    // rust: surface_depth_multiplier,
    // rust: add_stone_depth,
    // rust: } => {
    // rust: serde_json::json!({"type":"minecraft:water","offset":offset,"surface_depth_multiplier":multiplier(*surface_depth_multiplier)?,"add_stone_depth":add_stone_depth})
}
    // rust: Self::StoneDepth {
    // rust: offset,
    // rust: add_surface_depth,
    // rust: secondary_depth_range,
    // rust: ceiling,
    // rust: } => {
    // rust: serde_json::json!({"type":"minecraft:stone_depth","offset":offset,"add_surface_depth":add_surface_depth,"secondary_depth_range":secondary_depth_range,"surface_type":if *ceiling{"ceiling"}else{"floor"}})
}
    // rust: Self::VerticalGradient {
    // rust: random_name,
    // rust: true_at_and_below,
    // rust: false_at_and_above,
    // rust: } => {
    // rust: serde_json::json!({"type":"minecraft:vertical_gradient","random_name":identifier(random_name)?,"true_at_and_below":anchor(*true_at_and_below)?,"false_at_and_above":anchor(*false_at_and_above)?})
}
    // rust: Self::Not(_) | Self::NoiseThreshold { .. } => {
    // rust: return Err(DecodeError::Field("condition requires direct encoding"));
}
    // rust: Self::Reference(reference) => Value::String(reference.name.clone()),
    // rust: })
}
}

    // rust: mod tests {
//     use super::*;
forward_references_are_stable_and_invalid_graphs_fail_atomically :: proc() {
}
    // rust: let definitions = BTreeMap::from([
    // rust: ("a".to_owned(), r#"{"type":"not","invert":"z"}"#.to_owned()),
    // rust: ("z".to_owned(), r#"{"type":"hole"}"#.to_owned()),
    // rust: ]);
    // rust: let registry = MaterialConditionRegistry::from_json(&definitions).unwrap();
    // rust: let reference = registry.decode(r#""a""#).unwrap();
    // rust: assert_eq!(reference.to_json().unwrap(), r#""minecraft:a""#);
    // rust: assert!(
    // rust: registry
    // rust: .decode(r#"{"type":"not","invert":"missing"}"#)
    // rust: .is_err()
    // rust: );
    // rust: assert_eq!(registry.entries().count(), 2);
    // rust: assert_eq!(
    // rust: registry.get("z").unwrap().value().to_json().unwrap(),
    // rust: r#"{"type":"minecraft:hole"}"#
    // rust: );
    // rust: let mut cyclic = definitions.clone();
    // rust: cyclic.insert("z".to_owned(), r#"{"type":"not","invert":"a"}"#.to_owned());
    // rust: assert!(MaterialConditionRegistry::from_json(&cyclic).is_err());
    // rust: let mut alias = definitions.clone();
    // rust: alias.insert("z".to_owned(), r#""a""#.to_owned());
    // rust: assert!(MaterialConditionRegistry::from_json(&alias).is_err());
    // rust: let mut duplicate = definitions;
    // rust: duplicate.insert("minecraft:z".to_owned(), r#"{"type":"steep"}"#.to_owned());
    // rust: assert!(MaterialConditionRegistry::from_json(&duplicate).is_err());
    // rust: assert_eq!(reference.to_json().unwrap(), r#""minecraft:a""#);
}
}
