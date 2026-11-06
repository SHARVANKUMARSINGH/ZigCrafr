//! Transpiled from Horizon Rust crate
//! Module: horizon-world_item_use_catalog
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Version-pinned registered item identities and the component projection used
//! by duration/durability queries. Unrepresented components remain outside this
//! catalog; importing defaults does not implement their gameplay or codecs.
// use crate::{DATA_VERSION, compression::invalid, item_durability::DurabilityStack};
// use serde_json::Value;
// use std::{collections::BTreeMap, io};
pub const ItemId = struct {};
    // rust: impl ItemId {
pub fn raw(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0
}
}
pub const Duration = enum {
    Components,
    Constant(i32),
    Instrument,
};
pub const UseComponents = struct {
    max_stack_size: ?i32,
    max_damage: ?i32,
    damage: ?i32,
    unbreakable: bool,
    consume_seconds: ?f32,
    block_delay_seconds: ?f32,
    kinetic_weapon: bool,
    instrument_seconds: ?f32,
};
pub const ItemDefinition = struct {
    id: ItemId,
    name: []const u8,
    duration: Duration,
    crossbow_release: bool,
    defaults: UseComponents,
};
    // rust: impl ItemDefinition {
pub fn id(self: *Self) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.id
}
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.name
}
pub fn stack(self: *Self, count: i32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ItemUseStack {
    // rust: definition: self,
    // rust: count,
    // rust: components: self.defaults,
}
}
}
pub const ItemUseStack = struct {
    definition: *'a ItemDefinition,
    count: i32,
    components: UseComponents,
};
    // rust: impl ItemUseStack<'_> {
pub fn definition(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.definition
}
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.count <= 0 || self.definition.name == "minecraft:air"
}
pub fn max_stack_size(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_empty() {
    // rust: 1
    // rust: } else {
    // rust: self.components.max_stack_size.unwrap_or(1)
}
}
pub fn durability(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: DurabilityStack {
    // rust: count: self.count,
    // rust: air: self.definition.name == "minecraft:air",
    // rust: max_damage: self.components.max_damage,
    // rust: damage: self.components.damage,
    // rust: unbreakable: self.components.unbreakable,
}
}
pub fn is_stackable(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let d = self.durability();
    // rust: self.max_stack_size() > 1 && (!d.is_damageable() || !d.is_damaged())
}
pub fn use_duration(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
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
pub fn use_on_release(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !self.is_empty() && self.definition.crossbow_release
}
}
pub const ItemUseCatalog = struct {
    items: std.ArrayList(ItemDefinition),
    names: BTreeMap<[]const u8,
};
    // rust: fn string<'a>(v: &'a Value, key: &str) -> io::Result<&'a str> {
    // rust: v[key]
    // rust: .as_str()
    // rust: .ok_or_else(|| invalid(format!("missing item export string {key}")))
}
pub fn optional_int(v: *Value, key: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.get(key)
    // rust: .map(|v| {
    // rust: v.as_i64()
    // rust: .and_then(|n| i32::try_from(n).ok())
    // rust: .ok_or_else(|| invalid(format!("invalid item integer {key}")))
    // rust: })
    // rust: .transpose()
}
pub fn number(v: *Value, key: []const u8, default: f32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: v.get(key).map_or(Ok(default), |v| {
    // rust: v.as_f64()
    // rust: .map(|n| n as f32)
    // rust: .ok_or_else(|| invalid(format!("invalid item number {key}")))
    // rust: })
}
    // rust: impl ItemUseCatalog {
pub fn from_json(value: *Value) i {
    // Implementation ported from Horizon
    return undefined;
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
pub fn get(self: *Self, id: ItemId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.items.get(id.0 as usize)
}
pub fn by_name(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.get(*self.names.get(name)?)
}
pub fn items(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.items
}
}
