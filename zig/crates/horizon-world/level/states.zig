//! Transpiled from Horizon Rust crate
//! Module: horizon-world_states
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! O(1) block-state property access over the pinned registry.
//!
//! Vanilla's `StateDefinition` enumerates a block's states as the cartesian
//! product of its properties sorted by name, the last property varying fastest,
//! and the global state registry lists every block's states contiguously. The
//! table below derives each property's stride from that layout and verifies it
//! against every registry descriptor at load, so `setValue` is arithmetic.
// use crate::{
    // rust: compression::invalid,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::geometry::{Axis, Direction};
// use std::{collections::HashMap, io};

/// Registry-order block index; equals vanilla's `Block` registry ID.
pub const BlockId = struct {};

/// Interned property name (`facing`, `waterlogged`, ...), shared by all blocks.
pub const PropKey = struct {};

pub const PropValue = struct {
    text: *str,
    int: ?i32,
    boolean: ?bool,
    direction: ?Direction,
};
    // rust: impl PropValue {
pub fn new(text: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: int: text.parse().ok(),
    // rust: boolean: match text {
    // rust: "true" => Some(true),
    // rust: "false" => Some(false),
    // rust: _ => None,
    // rust: },
    // rust: direction: direction_from_name(text),
    // rust: text: text.into(),
}
}
}

pub const Slot = struct {
    key: PropKey,
    stride: u32,
    values: std.ArrayList(PropValue),
};

pub const BlockInfo = struct {
    name: *str,
    base: BlockStateId,
    count: u32,
    default: BlockStateId,
    slots: std.ArrayList(Slot),
};

pub const StateTable = struct {
    blocks: std.ArrayList(BlockInfo),
    state_block: std.ArrayList(u16),
    keys: HashMap<[]const u8,
    key_names: std.ArrayList([]const u8),
    by_name: HashMap<*str,
};

pub fn direction_from_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match name {
    // rust: "down" => Direction::Down,
    // rust: "up" => Direction::Up,
    // rust: "north" => Direction::North,
    // rust: "south" => Direction::South,
    // rust: "west" => Direction::West,
    // rust: "east" => Direction::East,
    // rust: _ => return None,
    // rust: })
}
    // rust: pub const fn direction_name(direction: Direction) -> &'static str {
    // rust: match direction {
    // rust: Direction::Down => "down",
    // rust: Direction::Up => "up",
    // rust: Direction::North => "north",
    // rust: Direction::South => "south",
    // rust: Direction::West => "west",
    // rust: Direction::East => "east",
}
}
    // rust: pub const fn axis_name(axis: Axis) -> &'static str {
    // rust: match axis {
    // rust: Axis::X => "x",
    // rust: Axis::Y => "y",
    // rust: Axis::Z => "z",
}
}

    // rust: impl StateTable {
pub fn new(registry: *BlockRegistry) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut table = Self {
    // rust: blocks: Vec::new(),
    // rust: state_block: Vec::with_capacity(registry.len()),
    // rust: keys: HashMap::new(),
    // rust: key_names: Vec::new(),
    // rust: by_name: HashMap::new(),
}
    // rust: let mut index = 0;
    // rust: while index < registry.len() {
    // rust: let first = registry.state(BlockStateId(index as u32)).unwrap();
    // rust: let mut end = index + 1;
    // rust: while end < registry.len()
    // rust: && registry.state(BlockStateId(end as u32)).unwrap().name == first.name
    // rust: {
    // rust: end += 1;
}
    // rust: let count = (end - index) as u32;
    // rust: let names: Vec<&String> = first.properties.keys().collect();
    // rust: let mut slots = Vec::with_capacity(names.len());
    // rust: let mut stride = count;
    // rust: for name in &names {
    // rust: let mut values = Vec::new();
                // Values of this property cycle with period (stride / len); the
                // first states with stride steps give each value in order.
    // rust: let mut seen = Vec::<&str>::new();
    // rust: for offset in 0..count {
    // rust: let value = registry
    // rust: .state(BlockStateId(index as u32 + offset))
    // rust: .unwrap()
    // rust: .properties[*name]
    // rust: .as_str();
    // rust: if !seen.contains(&value) {
    // rust: seen.push(value);
}
}
    // rust: stride /= seen.len() as u32;
    // rust: for value in seen {
    // rust: values.push(PropValue::new(value));
}
    // rust: let key = table.key_or_insert(name);
    // rust: slots.push(Slot {
    // rust: key,
    // rust: stride,
    // rust: values,
    // rust: });
}
    // rust: if stride != 1 {
    // rust: return Err(invalid("block state count is not a property product"));
}
            // Order of values: derive from the states at multiples of stride.
    // rust: for slot in &mut slots {
    // rust: let len = slot.values.len() as u32;
    // rust: let name = &table.key_names[slot.key.0 as usize];
    // rust: slot.values = (0..len)
    // rust: .map(|i| {
    // rust: PropValue::new(
    // rust: &registry
    // rust: .state(BlockStateId(index as u32 + i * slot.stride))
    // rust: .unwrap()
    // rust: .properties[name],
    // rust: )
    // rust: })
    // rust: .collect();
}
    // rust: let block =
    // rust: BlockId(u16::try_from(table.blocks.len()).map_err(|_| invalid("too many blocks"))?);
    // rust: let default = registry
    // rust: .default_state(&first.name)
    // rust: .ok_or_else(|| invalid("block without default state"))?;
    // rust: let info = BlockInfo {
    // rust: name: first.name.as_str().into(),
    // rust: base: BlockStateId(index as u32),
    // rust: count,
    // rust: default,
    // rust: slots,
}
    // rust: for offset in 0..count {
    // rust: let state = registry.state(BlockStateId(index as u32 + offset)).unwrap();
    // rust: for slot in &info.slots {
    // rust: let value =
    // rust: &slot.values[((offset / slot.stride) % slot.values.len() as u32) as usize];
    // rust: if *value.text != *state.properties[&table.key_names[slot.key.0 as usize]] {
    // rust: return Err(invalid(
    // rust: "registry state order differs from vanilla's state definition",
    // rust: ));
}
}
    // rust: table.state_block.push(block.0);
}
    // rust: if table.by_name.insert(info.name.clone(), block).is_some() {
    // rust: return Err(invalid("block states are not contiguous"));
}
    // rust: table.blocks.push(info);
    // rust: index = end;
}
    // rust: Ok(table)
}
pub fn key_or_insert(self: *Self, name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(key) = self.keys.get(name) {
    // rust: return *key;
}
    // rust: let key = PropKey(self.key_names.len() as u16);
    // rust: self.key_names.push(name.to_owned());
    // rust: self.keys.insert(name.to_owned(), key);
    // rust: key
}
    /// Property keys absent from every block resolve to an unused key, so
    /// lookups through them simply report "no such property".
pub fn key(self: *Self, name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.key_or_insert(name)
}
    /// An existing property key, without interning a new one.
pub fn key_of(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.keys.get(name).copied()
}
pub fn state_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state_block.len()
}
pub fn block_count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.len()
}
pub fn block(self: *Self, state: BlockStateId) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockId(self.state_block[state.0 as usize])
}
pub fn info(self: *Self, block: BlockId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.blocks[block.0 as usize]
}
pub fn name(self: *Self, state: BlockStateId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.info(self.block(state)).name
}
pub fn block_by_name(self: *Self, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.by_name.get(name).copied()
}
pub fn default_state(self: *Self, block: BlockId) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.info(block).default
}
pub fn is(self: *Self, state: BlockStateId, block: BlockId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.state_block[state.0 as usize] == block.0
}
pub fn slot(self: *Self, state: BlockStateId, key: PropKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.info(self.block(state))
    // rust: .slots
    // rust: .iter()
    // rust: .find(|slot| slot.key == key)
}
pub fn has(self: *Self, state: BlockStateId, key: PropKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.slot(state, key).is_some()
}
pub fn index_in(self: *Self, state: BlockStateId, slot: *Slot) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let base = self.info(self.block(state)).base.0;
    // rust: ((state.0 - base) / slot.stride) % slot.values.len() as u32
}
pub fn value(self: *Self, state: BlockStateId, key: PropKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = self.slot(state, key)?;
    // rust: Some(&slot.values[self.index_in(state, slot) as usize])
}
pub fn text(self: *Self, state: BlockStateId, key: PropKey) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value(state, key).map_or("", |v| &v.text)
}
    /// Missing boolean properties read as false.
pub fn bool(self: *Self, state: BlockStateId, key: PropKey) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value(state, key)
    // rust: .and_then(|v| v.boolean)
    // rust: .unwrap_or(false)
}
    /// Missing integer properties read as 0.
pub fn int(self: *Self, state: BlockStateId, key: PropKey) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value(state, key).and_then(|v| v.int).unwrap_or(0)
}
pub fn dir(self: *Self, state: BlockStateId, key: PropKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.value(state, key).and_then(|v| v.direction)
}
    /// Number of values and minimum/maximum for integer properties.
pub fn int_range(self: *Self, state: BlockStateId, key: PropKey) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = self.slot(state, key)?;
    // rust: let ints = slot.values.iter().filter_map(|v| v.int);
    // rust: Some((ints.clone().min()?, ints.max()?))
}
pub fn values(self: *Self, block: BlockId, key: PropKey) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.info(block)
    // rust: .slots
    // rust: .iter()
    // rust: .filter(move |slot| slot.key == key)
    // rust: .flat_map(|slot| slot.values.iter())
}
pub fn with_index(self: *Self, state: BlockStateId, slot: *Slot, index: u32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let current = self.index_in(state, slot);
    // rust: BlockStateId(state.0 - current * slot.stride + index * slot.stride)
}
    /// `setValue` by text; None if the block lacks the property or value.
pub fn with_text(self: *Self, state: BlockStateId, key: PropKey, text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = self.slot(state, key)?;
    // rust: let index = slot.values.iter().position(|v| &*v.text == text)?;
    // rust: Some(self.with_index(state, slot, index as u32))
}
pub fn with_int(self: *Self, state: BlockStateId, key: PropKey, value: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slot = self.slot(state, key)?;
    // rust: let index = slot.values.iter().position(|v| v.int == Some(value))?;
    // rust: Some(self.with_index(state, slot, index as u32))
}
    // rust: pub fn with_bool(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: key: PropKey,
    // rust: value: bool,
    // rust: ) -> Option<BlockStateId> {
    // rust: let slot = self.slot(state, key)?;
    // rust: let index = slot.values.iter().position(|v| v.boolean == Some(value))?;
    // rust: Some(self.with_index(state, slot, index as u32))
}
    // rust: pub fn with_dir(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: key: PropKey,
    // rust: value: Direction,
    // rust: ) -> Option<BlockStateId> {
    // rust: self.with_text(state, key, direction_name(value))
}
    /// Vanilla `setValue` callers always pass legal values; when Horizon's port
    /// would compute an illegal one the state is returned unchanged.
pub fn set_text(self: *Self, state: BlockStateId, key: PropKey, text: []const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.with_text(state, key, text).unwrap_or(state)
}
pub fn set_int(self: *Self, state: BlockStateId, key: PropKey, value: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.with_int(state, key, value).unwrap_or(state)
}
pub fn set_bool(self: *Self, state: BlockStateId, key: PropKey, value: bool) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.with_bool(state, key, value).unwrap_or(state)
}
pub fn set_dir(self: *Self, state: BlockStateId, key: PropKey, value: Direction) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.with_dir(state, key, value).unwrap_or(state)
}
    /// `cycle`: the next value in definition order, wrapping around.
pub fn cycle(self: *Self, state: BlockStateId, key: PropKey) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(slot) = self.slot(state, key) else {
    // rust: return state;
}
    // rust: let next = (self.index_in(state, slot) + 1) % slot.values.len() as u32;
    // rust: self.with_index(state, slot, next)
}
    /// `Block.withPropertiesOf`: copy every property the target block shares.
pub fn with_properties_of(self: *Self, target: BlockId, source: BlockStateId) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut result = self.default_state(target);
    // rust: for slot in &self.info(self.block(source)).slots {
    // rust: let value = &slot.values[self.index_in(source, slot) as usize];
    // rust: if let Some(next) = self.with_text(result, slot.key, &value.text) {
    // rust: result = next;
}
}
    // rust: result
}
}
