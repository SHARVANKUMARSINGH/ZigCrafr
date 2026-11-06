//! Transpiled from Horizon Rust crate
package horizon_protocol_registry

import "core:fmt"
import "core:mem"
import "core:math"

// Registry id tables. Built-in registries (items, entity types, menus, sound
// events ...) have fixed network ids, read from the data generator's
// registries report. Data-driven registries (dimension types, biomes, chat
// types, damage types ...) are numbered in the order the server sends them
// during configuration.
// use crate::{
    // rust: Error, Result,
    // rust: packets::configuration::{RegistryData, UpdateTags},
}
// use horizon_world::nbt::{JavaString, Tag};
// use std::{collections::HashMap, path::Path};

// One registry: names by network id and the reverse lookup.
Ids :: struct {
    names: [dynamic]string,
    ids: HashMap<string,
}
    // rust: impl Ids {
from_names :: proc(names: [dynamic]string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let ids = names
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, n)| (n.clone(), i as i32))
    // rust: .collect();
    // rust: Self { names, ids }
}
name :: proc(self: ^Self, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: usize::try_from(id)
    // rust: .ok()
    // rust: .and_then(|i| self.names.get(i))
    // rust: .map(String::as_str)
}
id :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.ids.get(name).copied()
}
}

// The built-in registries from `registries.json` (`--reports`).
Builtin :: struct {
    registries: HashMap<string,
}
// The names of both kinds of registry a connection knows: the built-in ones
// first (as a hub's `SyncData::id` does), then those the server synced.
SyncedNames :: struct {
    builtin: ^'a Builtin,
    dynamic: ^'a Dynamic,
}
    // rust: impl crate::item::Names for SyncedNames<'_> {
name :: proc(self: ^Self, registry: string, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.builtin
    // rust: .get(registry)
    // rust: .and_then(|ids| ids.name(id))
    // rust: .or_else(|| self.dynamic.name(registry, id))
    // rust: .or_else(|| {
    // rust: (self.dynamic.custom_components && registry == "minecraft:data_component_type")
    // rust: .then(|| crate::item::custom::name(id))
    // rust: .flatten()
    // rust: })
    // rust: .map(str::to_owned)
}
}

    // rust: impl Builtin {
load :: proc(path: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let text = std::fs::read_to_string(path)
    // rust: .map_err(|e| Error::new(format!("{}: {e}", path.display())))?;
    // rust: Self::parse(&text)
}
parse :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let json: serde_json::Value = serde_json::from_str(text)
    // rust: .map_err(|e| Error::new(format!("registries report: {e}")))?;
    // rust: let mut registries = HashMap::new();
    // rust: for (name, registry) in json
    // rust: .as_object()
    // rust: .ok_or_else(|| Error::new("registries report is not an object"))?
    // rust: {
    // rust: let Some(entries) = registry["entries"].as_object() else {
    // rust: continue;
}
    // rust: let mut names = vec![String::new(); entries.len()];
    // rust: for (entry, value) in entries {
    // rust: let id = value["protocol_id"]
    // rust: .as_u64()
    // rust: .ok_or_else(|| Error::new(format!("{entry}: no protocol_id")))?
    // rust: as usize;
    // rust: if id >= names.len() {
    // rust: names.resize(id + 1, String::new());
}
    // rust: names[id] = entry.clone();
}
    // rust: registries.insert(name.clone(), Ids::from_names(names));
}
    // rust: Ok(Self { registries })
}
get :: proc(self: ^Self, registry: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.registries.get(registry)
}
    // Look for the report next to prepared resources, then in the data
    // generator output of a development checkout.
find :: proc(resources: ^Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let candidates = [
    // rust: resources.join("registries.json"),
    // rust: resources.join("../../datagen/out/reports/registries.json"),
    // rust: resources.join("../datagen/out/reports/registries.json"),
    // rust: ];
    // rust: candidates.into_iter().find(|p| p.is_file())
}
}

// Registries synchronized during configuration, in arrival order.
Dynamic :: struct {
    registries: HashMap<string,
    // The `minecraft:dialog` tags the server sent: each tag's entries by id.
    dialog_tags: HashMap<string,
    // The peer confirmed the native component registry identity.
    custom_components: bool,
}
    // rust: impl Dynamic {
    // The dialog tags of a `ClientboundUpdateTagsPacket`.
add_tags :: proc(self: ^Self, packet: ^UpdateTags) {
}
    // rust: for r in packet
    // rust: .registries
    // rust: .iter()
    // rust: .filter(|r| r.registry == "minecraft:dialog")
    // rust: {
    // rust: self.dialog_tags = r
    // rust: .tags
    // rust: .iter()
    // rust: .map(|t| (t.name.clone(), t.ids.clone()))
    // rust: .collect();
}
}
add :: proc(self: ^Self, packet: RegistryData) {
}
    // rust: let entries = packet.entries.into_iter().map(|e| (e.id, e.data)).collect();
    // rust: self.registries.insert(packet.registry, entries);
}
name :: proc(self: ^Self, registry: string, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let i = usize::try_from(id).ok()?;
    // rust: self.registries
    // rust: .get(registry)?
    // rust: .get(i)
    // rust: .map(|(n, _)| n.as_str())
}
    // The id of an entry by name, the reverse of `name`. A registry has one
    // entry per id, so the first match is the only one.
id :: proc(self: ^Self, registry: string, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let list = self.registries.get(registry)?;
    // rust: list.iter().position(|(n, _)| n == name).map(|i| i as i32)
}
data :: proc(self: ^Self, registry: string, id: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let i = usize::try_from(id).ok()?;
    // rust: self.registries.get(registry)?.get(i)?.1.as_ref()
}
len :: proc(self: ^Self, registry: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.registries.get(registry).map_or(0, Vec::len)
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.registries.is_empty()
}
    // The dimension type's vertical range and sky light, from its
    // synchronized data or the vanilla defaults for known names.
dimension :: proc(self: ^Self, id: i32) -> D {
    // Ported from Horizon
    return {}
}
    // rust: let name = self
    // rust: .name("minecraft:dimension_type", id)
    // rust: .unwrap_or("minecraft:overworld");
    // rust: let mut d = DimensionType::vanilla(name);
    // rust: if let Some(Tag::Compound(map)) = self.data("minecraft:dimension_type", id) {
    // rust: let int = |k: &str| match map.get(&JavaString::from(k)) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: _ => None,
}
    // rust: if let Some(v) = int("min_y") {
    // rust: d.min_y = v;
}
    // rust: if let Some(v) = int("height") {
    // rust: d.height = v;
}
    // rust: if let Some(v) = int("logical_height") {
    // rust: d.logical_height = v;
}
            // DimensionType's codec refuses a shape outside these; the client sizes
            // its columns and light from them, so keep the named type's own.
    // rust: if !DimensionType::valid_shape(d.min_y, d.height) {
    // rust: let vanilla = DimensionType::vanilla(name);
    // rust: d.min_y = vanilla.min_y;
    // rust: d.height = vanilla.height;
}
    // rust: if let Some(Tag::Byte(v)) = map.get(&JavaString::from("has_skylight")) {
    // rust: d.has_skylight = *v != 0;
}
    // rust: if let Some(Tag::Byte(v)) = map.get(&JavaString::from("has_ceiling")) {
    // rust: d.has_ceiling = *v != 0;
}
            // Any number, as vanilla's codec reads it (Horizon's own server sends a
            // world pack's JSON numbers as doubles).
    // rust: d.ambient_light = match map.get(&JavaString::from("ambient_light")) {
    // rust: Some(Tag::Float(v)) => f32::from_bits(*v),
    // rust: Some(Tag::Double(v)) => f64::from_bits(*v) as f32,
    // rust: Some(Tag::Int(v)) => *v as f32,
    // rust: Some(Tag::Byte(v)) => f32::from(*v),
    // rust: _ => d.ambient_light,
}
            // DimensionType.defaultClock: the world clock this level's day
            // time follows (absent in the Nether).
    // rust: d.default_clock = match map.get(&JavaString::from("default_clock")) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: Some(Tag::Compound(c)) => match c.get(&JavaString::from("id")) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => d.default_clock,
    // rust: },
    // rust: _ => d.default_clock,
}
}
    // rust: d
}
}
// The parts of a DimensionType the client needs for chunk layout.
DimensionType :: struct {
    name: string,
    min_y: i32,
    height: i32,
    logical_height: i32,
    has_skylight: bool,
    // `DimensionType.hasCeiling`: weather, spawning and maps read it.
    has_ceiling: bool,
    // `DimensionType.ambientLight`: the light every block gets, whatever its light level.
    ambient_light: f32,
    // `DimensionType.defaultClock`: the `minecraft:world_clock` this level
    // samples for day time (`None` in the Nether).
    default_clock: Maybe(string),
}
    // rust: impl DimensionType {
    // `DimensionType.MIN_Y`, `MAX_Y` and `MIN_HEIGHT`: a type's `min_y` and
    // `height` are multiples of 16, at least 16 high, inside -2032..=2031.
valid_shape :: proc(min_y: i32, height: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: min_y % 16 == 0
    // rust: && height % 16 == 0
    // rust: && height >= 16
    // rust: && min_y >= -2032
    // rust: && i64::from(min_y) + i64::from(height) <= 2032
}
vanilla :: proc(name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (min_y, height, logical_height, has_skylight, has_ceiling, default_clock) = match name {
    // rust: "minecraft:the_nether" => (0, 256, 128, false, true, None),
    // rust: "minecraft:the_end" => (0, 256, 256, true, false, Some("minecraft:the_end")),
            // overworld_caves builds like the Overworld but has a ceiling.
    // rust: "minecraft:overworld_caves" => (-64, 384, 384, true, true, Some("minecraft:overworld")),
    // rust: _ => (-64, 384, 384, true, false, Some("minecraft:overworld")),
}
    // rust: let ambient_light = match name {
    // rust: "minecraft:the_nether" => 0.1,
    // rust: "minecraft:the_end" => 0.25,
    // rust: _ => 0.0,
}
    // rust: Self {
    // rust: name: name.to_owned(),
    // rust: min_y,
    // rust: height,
    // rust: logical_height,
    // rust: has_skylight,
    // rust: has_ceiling,
    // rust: ambient_light,
    // rust: default_clock: default_clock.map(str::to_owned),
}
}
sections :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (self.height / 16) as usize
}
}

// Mth.ceillog2(n): bits for a global palette over `n` values.
ceil_log2 :: proc(n: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if n <= 1 {
    // rust: 0
    // rust: } else {
    // rust: (usize::BITS - (n - 1).leading_zeros()) as u8
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::packets::configuration::RegistryEntry;

parses_registry_reports :: proc() {
}
    // rust: let report = r#"{"minecraft:item":{"default":"minecraft:air","entries":{"minecraft:stone":{"protocol_id":1},"minecraft:air":{"protocol_id":0}},"protocol_id":5}}"#;
    // rust: let b = Builtin::parse(report).unwrap();
    // rust: let items = b.get("minecraft:item").unwrap();
    // rust: assert_eq!(items.name(1), Some("minecraft:stone"));
    // rust: assert_eq!(items.id("minecraft:air"), Some(0));
    // rust: assert_eq!(items.name(2), None);
}

dynamic_registries_follow_arrival_order :: proc() {
}
    // rust: let mut d = Dynamic::default();
    // rust: d.add(RegistryData {
    // rust: registry: "minecraft:dimension_type".into(),
    // rust: entries: vec![
    // rust: RegistryEntry {
    // rust: id: "minecraft:overworld".into(),
    // rust: data: None,
    // rust: },
    // rust: RegistryEntry {
    // rust: id: "minecraft:the_nether".into(),
    // rust: data: Some(Tag::compound([
    // rust: ("min_y", Tag::Int(0)),
    // rust: ("height", Tag::Int(256)),
    // rust: ("has_skylight", Tag::Byte(0)),
    // rust: ])),
    // rust: },
    // rust: ],
    // rust: });
    // rust: assert_eq!(
    // rust: d.dimension(0),
    // rust: DimensionType::vanilla("minecraft:overworld")
    // rust: );
    // rust: assert_eq!(d.dimension(1).sections(), 16);
    // rust: assert!(!d.dimension(1).has_skylight);
        // The type's data leaves has_ceiling out; the Nether default holds.
    // rust: assert!(d.dimension(1).has_ceiling);
    // rust: assert_eq!(d.dimension(1).default_clock, None);
        // ...and so does its ambient light.
    // rust: assert_eq!(d.dimension(1).ambient_light, 0.1);
    // rust: assert_eq!(ceil_log2(35723), 16);
    // rust: assert_eq!(ceil_log2(65), 7);
    // rust: assert_eq!(ceil_log2(64), 6);
}

a_dimension_shape_the_codec_refuses_keeps_the_named_types :: proc() {
}
    // rust: let shape = |min_y: i32, height: i32| {
    // rust: let mut d = Dynamic::default();
    // rust: d.add(RegistryData {
    // rust: registry: "minecraft:dimension_type".into(),
    // rust: entries: vec![RegistryEntry {
    // rust: id: "example:tall".into(),
    // rust: data: Some(Tag::compound([
    // rust: ("min_y", Tag::Int(min_y)),
    // rust: ("height", Tag::Int(height)),
    // rust: ])),
    // rust: }],
    // rust: });
    // rust: let t = d.dimension(0);
    // rust: (t.min_y, t.height)
}
        // The tallest the codec takes, and a few it refuses.
    // rust: assert_eq!(shape(-2032, 4064), (-2032, 4064));
    // rust: assert_eq!(shape(0, 2_147_483_632), (-64, 384));
    // rust: assert_eq!(shape(0, 8), (-64, 384));
    // rust: assert_eq!(shape(-64, 100), (-64, 384));
    // rust: assert_eq!(shape(-2048, 256), (-64, 384));
    // rust: assert_eq!(shape(1024, 1024), (-64, 384));
}

dimension_reads_default_clock :: proc() {
}
    // rust: let mut d = Dynamic::default();
    // rust: d.add(RegistryData {
    // rust: registry: "minecraft:dimension_type".into(),
    // rust: entries: vec![RegistryEntry {
    // rust: id: "pack:custom".into(),
    // rust: data: Some(Tag::compound([
    // rust: ("min_y", Tag::Int(-64)),
    // rust: ("height", Tag::Int(384)),
    // rust: ("logical_height", Tag::Int(384)),
    // rust: ("has_skylight", Tag::Byte(1)),
    // rust: ("default_clock", Tag::String("minecraft:overworld".into())),
    // rust: ])),
    // rust: }],
    // rust: });
    // rust: let dim = d.dimension(0);
    // rust: assert_eq!(dim.name, "pack:custom");
    // rust: assert_eq!(dim.default_clock.as_deref(), Some("minecraft:overworld"));
}

dimension_reads_ambient_light :: proc() {
}
    // rust: let mut d = Dynamic::default();
    // rust: d.add(RegistryData {
    // rust: registry: "minecraft:dimension_type".into(),
    // rust: entries: vec![RegistryEntry {
    // rust: id: "pack:custom".into(),
    // rust: data: Some(Tag::compound([
    // rust: ("height", Tag::Int(384)),
    // rust: ("ambient_light", Tag::Float(0.375f32.to_bits())),
    // rust: ])),
    // rust: }],
    // rust: });
    // rust: assert_eq!(d.dimension(0).ambient_light, 0.375);
        // A world pack's JSON number, as Horizon's server sends it.
    // rust: d.add(RegistryData {
    // rust: registry: "minecraft:dimension_type".into(),
    // rust: entries: vec![RegistryEntry {
    // rust: id: "pack:custom".into(),
    // rust: data: Some(Tag::compound([(
    // rust: "ambient_light",
    // rust: Tag::Double(0.5f64.to_bits()),
    // rust: )])),
    // rust: }],
    // rust: });
    // rust: assert_eq!(d.dimension(0).ambient_light, 0.5);
}
}
