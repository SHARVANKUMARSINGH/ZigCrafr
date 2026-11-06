//! Transpiled from Horizon Rust crate
package horizon_world_item_use_catalog

import "core:fmt"
import "core:mem"
import "core:math"

// Version-pinned registered item identities and the component projection used
// by duration/durability queries. Unrepresented components remain outside this
// catalog; importing defaults does not implement their gameplay or codecs.
// use crate::{DATA_VERSION, compression::invalid, item_durability::DurabilityStack};
// use serde_json::Value;
// use std::{collections::BTreeMap, io};
ItemId :: struct {
    // rust: impl ItemId {
raw :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0
}
}
Duration :: enum {
    Components,
    Constant(i32),
    Instrument,
}
UseComponents :: struct {
    max_stack_size: Maybe(i32),
    max_damage: Maybe(i32),
    damage: Maybe(i32),
    unbreakable: bool,
    consume_seconds: Maybe(f32),
    block_delay_seconds: Maybe(f32),
    kinetic_weapon: bool,
    instrument_seconds: Maybe(f32),
}
ItemDefinition :: struct {
    id: ItemId,
    name: string,
    duration: Duration,
    crossbow_release: bool,
    defaults: UseComponents,
}
    // rust: impl ItemDefinition {
id :: proc(self: ^Self) -> I {
    // Ported from Horizon
    return {}
}
    // rust: self.id
}
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.name
}
stack :: proc(self: ^Self, count: i32) -> I {
    // Ported from Horizon
    return {}
}
    // rust: ItemUseStack {
    // rust: definition: self,
    // rust: count,
    // rust: components: self.defaults,
}
}
}
ItemUseStack :: struct {
    definition: ^'a ItemDefinition,
    count: i32,
    components: UseComponents,
}
    // rust: impl ItemUseStack<'_> {
definition :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.definition
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.count <= 0 || self.definition.name == "minecraft:air"
}
max_stack_size :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: 1
    // rust: } else {
    // rust: self.components.max_stack_size.unwrap_or(1)
}
}
durability :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: DurabilityStack {
    // rust: count: self.count,
    // rust: air: self.definition.name == "minecraft:air",
    // rust: max_damage: self.components.max_damage,
    // rust: damage: self.components.damage,
    // rust: unbreakable: self.components.unbreakable,
}
}
is_stackable :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let d = self.durability();
    // rust: self.max_stack_size() > 1 && (!d.is_damageable() || !d.is_damaged())
}
use_duration :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: return 0;
}
    // rust: match self.definition.duration {
    // rust: Duration::Constant(value) => value,
    // rust: Duration::Instrument => self
    // rust: .components
    // rust: .instrument_seconds
    // rust: .map_or(0, |v| (v * 20.0).floor() as i32),
    // rust: Duration::Components => {
    // rust: if let Some(seconds) = self.components.consume_seconds {
    // rust: (seconds * 20.0) as i32
    // rust: } else if self.components.block_delay_seconds.is_some()
    // rust: || self.components.kinetic_weapon
    // rust: {
    // rust: 72000
    // rust: } else {
    // rust: 0
}
}
}
}
use_on_release :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.is_empty() && self.definition.crossbow_release
}
}
ItemUseCatalog :: struct {
    items: [dynamic]ItemDefinition,
    names: BTreeMap<string,
}
    // rust: fn string<'a>(v: &'a Value, key: &str) -> io::Result<&'a str> {
    // rust: v[key]
    // rust: .as_str()
    // rust: .ok_or_else(|| invalid(format!("missing item export string {key}")))
}
optional_int :: proc(v: ^Value, key: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: v.get(key)
    // rust: .map(|v| {
    // rust: v.as_i64()
    // rust: .and_then(|n| i32::try_from(n).ok())
    // rust: .ok_or_else(|| invalid(format!("invalid item integer {key}")))
    // rust: })
    // rust: .transpose()
}
number :: proc(v: ^Value, key: string, default: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: v.get(key).map_or(Ok(default), |v| {
    // rust: v.as_f64()
    // rust: .map(|n| n as f32)
    // rust: .ok_or_else(|| invalid(format!("invalid item number {key}")))
    // rust: })
}
    // rust: impl ItemUseCatalog {
from_json :: proc(value: ^Value) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if value["schema"].as_i64() != Some(1)
    // rust: || value["DataVersion"].as_i64() != Some(i64::from(DATA_VERSION))
    // rust: {
    // rust: return Err(invalid("item catalog version mismatch"));
}
    // rust: let rows = value["items"]
    // rust: .as_array()
    // rust: .ok_or_else(|| invalid("missing item catalog entries"))?;
    // rust: let instruments = value["instruments"]
    // rust: .as_object()
    // rust: .ok_or_else(|| invalid("missing item instruments"))?;
    // rust: let mut items = Vec::with_capacity(rows.len());
    // rust: let mut names = BTreeMap::new();
    // rust: for (index, row) in rows.iter().enumerate() {
    // rust: let raw = u32::try_from(index).map_err(|_| invalid("item catalog too large"))?;
    // rust: if row["id"].as_u64() != Some(u64::from(raw)) {
    // rust: return Err(invalid("non-contiguous item catalog ID"));
}
    // rust: let name = string(row, "name")?;
    // rust: if crate::worldgen::tags::identifier(name).ok().as_deref() != Some(name) {
    // rust: return Err(invalid("noncanonical item identifier"));
}
    // rust: let id = ItemId(raw);
    // rust: if names.insert(name.to_owned(), id).is_some() {
    // rust: return Err(invalid("duplicate item identifier"));
}
    // rust: let duration = match string(row, "duration_impl")? {
    // rust: "Item" => Duration::Components,
    // rust: "BowItem" | "CrossbowItem" | "TridentItem" => Duration::Constant(72000),
    // rust: "BundleItem" | "BrushItem" => Duration::Constant(200),
    // rust: "SpyglassItem" => Duration::Constant(1200),
    // rust: "EnderEyeItem" => Duration::Constant(0),
    // rust: "InstrumentItem" => Duration::Instrument,
    // rust: _ => return Err(invalid("unsupported item duration implementation")),
}
    // rust: let crossbow_release = match string(row, "release_impl")? {
    // rust: "Item" => false,
    // rust: "CrossbowItem" => true,
    // rust: _ => return Err(invalid("unsupported release implementation")),
}
    // rust: let c = row
    // rust: .get("components")
    // rust: .filter(|c| c.is_object())
    // rust: .ok_or_else(|| invalid("missing item component defaults"))?;
    // rust: let instrument_seconds = c
    // rust: .get("minecraft:instrument")
    // rust: .map(|v| {
    // rust: let name = v
    // rust: .as_str()
    // rust: .ok_or_else(|| invalid("expected exported instrument reference"))?;
    // rust: let bits = instruments
    // rust: .get(name)
    // rust: .and_then(Value::as_str)
    // rust: .ok_or_else(|| invalid("unknown item instrument"))?;
    // rust: u32::from_str_radix(bits, 16)
    // rust: .map(f32::from_bits)
    // rust: .map_err(|_| invalid("invalid instrument duration bits"))
    // rust: })
    // rust: .transpose()?;
    // rust: let defaults = UseComponents {
    // rust: max_stack_size: optional_int(c, "minecraft:max_stack_size")?,
    // rust: max_damage: optional_int(c, "minecraft:max_damage")?,
    // rust: damage: optional_int(c, "minecraft:damage")?,
    // rust: unbreakable: c.get("minecraft:unbreakable").is_some(),
    // rust: consume_seconds: c
    // rust: .get("minecraft:consumable")
    // rust: .map(|v| number(v, "consume_seconds", 1.6))
    // rust: .transpose()?,
    // rust: block_delay_seconds: c
    // rust: .get("minecraft:blocks_attacks")
    // rust: .map(|v| number(v, "block_delay_seconds", 0.0))
    // rust: .transpose()?,
    // rust: kinetic_weapon: c.get("minecraft:kinetic_weapon").is_some(),
    // rust: instrument_seconds,
}
    // rust: items.push(ItemDefinition {
    // rust: id,
    // rust: name: name.to_owned(),
    // rust: duration,
    // rust: crossbow_release,
    // rust: defaults,
    // rust: });
}
    // rust: if items.first().is_none_or(|i| i.name != "minecraft:air") {
    // rust: return Err(invalid("item registry must start with air"));
}
    // rust: Ok(Self { items, names })
}
get :: proc(self: ^Self, id: ItemId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.items.get(id.0 as usize)
}
by_name :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.get(*self.names.get(name)?)
}
items :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.items
}
}
