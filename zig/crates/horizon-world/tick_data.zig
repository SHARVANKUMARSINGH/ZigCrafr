//! Transpiled from Horizon Rust crate
//! Module: horizon-world_tick_data
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Save-format bridge for scheduled block/fluid ticks. Registry identity is
//! supplied by the caller; this module does not implement either type's behavior.
// use crate::{compression::invalid, nbt::Tag};
// use horizon_core::{
    // rust: position::BlockPos,
    // rust: ticks::{SavedTick, TickPriority, TickTypeId},
}
// use std::io;

pub const TickKind = enum {
    Block,
    Fluid,
};
    // rust: impl TickKind {
    // rust: pub const fn field(self) -> &'static str {
    // rust: match self {
    // rust: Self::Block => "block_ticks",
    // rust: Self::Fluid => "fluid_ticks",
}
}
}

    // rust: pub fn read_list(
    // rust: tag: &Tag,
    // rust: mut resolve: impl FnMut(&str) -> Option<TickTypeId>,
    // rust: ) -> io::Result<Vec<SavedTick>> {
    // rust: let Tag::List(entries) = tag else {
    // rust: return Err(invalid("saved ticks are not a list"));
}
    // rust: entries
    // rust: .iter()
    // rust: .map(|entry| {
    // rust: let Some(Tag::String(name)) = entry.get("i") else {
    // rust: return Err(invalid("saved tick is missing type name"));
}
    // rust: let name = name.to_string().map_err(|e| invalid(e.to_string()))?;
    // rust: let kind = resolve(&name).ok_or_else(|| invalid("unknown saved tick type"))?;
    // rust: let int = |key| {
                // NbtOps/Codec.INT use Number.intValue, including narrowing
                // longs and Java's saturating float conversion.
    // rust: match entry.get(key) {
    // rust: Some(Tag::Byte(v)) => Ok(i32::from(*v)),
    // rust: Some(Tag::Short(v)) => Ok(i32::from(*v)),
    // rust: Some(Tag::Int(v)) => Ok(*v),
    // rust: Some(Tag::Long(v)) => Ok(*v as i32),
    // rust: Some(Tag::Float(v)) => Ok(f32::from_bits(*v) as i32),
    // rust: Some(Tag::Double(v)) => Ok(f64::from_bits(*v) as i32),
    // rust: _ => Err(invalid(format!("saved tick is missing number {key}"))),
}
}
    // rust: Ok(SavedTick {
    // rust: kind,
    // rust: pos: BlockPos::new(int("x")?, int("y")?, int("z")?),
    // rust: delay: int("t")?,
    // rust: priority: TickPriority::by_value(int("p")?),
    // rust: })
    // rust: })
    // rust: .collect()
}

    // rust: pub fn write_list(
    // rust: ticks: &[SavedTick],
    // rust: mut name: impl FnMut(TickTypeId) -> Option<String>,
    // rust: ) -> io::Result<Tag> {
    // rust: let entries = ticks
    // rust: .iter()
    // rust: .map(|tick| {
    // rust: let name = name(tick.kind).ok_or_else(|| invalid("unknown saved tick type ID"))?;
    // rust: Ok(Tag::compound([
    // rust: ("i", Tag::String(name.as_str().into())),
    // rust: ("x", Tag::Int(tick.pos.x)),
    // rust: ("y", Tag::Int(tick.pos.y)),
    // rust: ("z", Tag::Int(tick.pos.z)),
    // rust: ("t", Tag::Int(tick.delay)),
    // rust: ("p", Tag::Int(tick.priority as i32)),
    // rust: ]))
    // rust: })
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: Ok(Tag::List(entries))
}
