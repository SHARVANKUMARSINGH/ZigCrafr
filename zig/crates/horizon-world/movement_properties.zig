//! Transpiled from Horizon Rust crate
//! Module: horizon-world_movement_properties
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Registry-bound block movement coefficients, identities and reloadable tags.
// use crate::{
    // rust: DATA_VERSION,
    // rust: compression::invalid,
    // rust: movement_support::MovementBlockWorld,
    // rust: nbt::Tag,
    // rust: registry::{BlockRegistry, BlockStateId, BlockTable},
}
// use horizon_core::position::BlockPos;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: fmt, io,
}

pub const MovementCoefficients = struct {
    friction: f32,
    speed_factor: f32,
    jump_factor: f32,
    bounce_restitution: f32,
    fall_distance_reduction: f32,
    fence_gate: bool,
};
pub const MovementBlock = struct {
    coefficients: MovementCoefficients,
    fence: bool,
    wall: bool,
    suppresses_bounce: bool,
    water: bool,
    bubble_column: bool,
};
pub const MovementTags = struct {
    fences: BTreeSet<[]const u8>,
    walls: BTreeSet<[]const u8>,
    suppresses_bounce: BTreeSet<[]const u8>,
};
/// Definitions are private version-specific data; no runtime Java is required.
pub const MovementProperties = struct {
    registry: *'r BlockRegistry,
    definitions: BTreeMap<[]const u8,
};
    // rust: impl<'r> MovementProperties<'r> {
pub fn registry(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
}
pub fn coefficients(self: *Self, state: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self
    // rust: .registry
    // rust: .state(state)
    // rust: .ok_or_else(|| invalid("movement state outside registry"))?;
    // rust: Ok(self.definitions[&state.name])
}

pub fn from_nbt(tag: *Tag, registry: *'r BlockRegistry) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::from_table(BlockTable::check(tag, registry, "movement")?)
}
pub fn from_table(table: BlockTable<'_) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tag, registry) = (table.tag(), table.registry());
    // rust: if tag.get("DataVersion") != Some(&Tag::Int(DATA_VERSION)) {
    // rust: return Err(invalid("movement properties DataVersion mismatch"));
}
    // rust: let Some(Tag::Compound(blocks)) = tag.get("blocks") else {
    // rust: return Err(invalid("missing movement definitions"));
}
    // rust: let mut definitions = BTreeMap::new();
    // rust: for (name, properties) in blocks {
    // rust: let name = name.to_string().map_err(|e| invalid(e.to_string()))?;
    // rust: if registry.default_state(&name).is_none() {
    // rust: return Err(invalid("unknown movement definition"));
}
    // rust: let float = |key: &str| -> io::Result<f32> {
    // rust: match properties.get(key) {
    // rust: Some(Tag::Float(bits)) => Ok(f32::from_bits(*bits)),
    // rust: _ => Err(invalid(format!("missing or invalid movement {key}"))),
}
}
    // rust: let fence_gate = match properties.get("fenceGate") {
    // rust: Some(Tag::Byte(0)) => false,
    // rust: Some(Tag::Byte(1)) => true,
    // rust: _ => return Err(invalid("invalid movement gate identity")),
}
    // rust: definitions.insert(
    // rust: name,
    // rust: MovementCoefficients {
    // rust: friction: float("friction")?,
    // rust: speed_factor: float("speedFactor")?,
    // rust: jump_factor: float("jumpFactor")?,
    // rust: bounce_restitution: float("bounceRestitution")?,
    // rust: fall_distance_reduction: float("fallDistanceReduction")?,
    // rust: fence_gate,
    // rust: },
    // rust: );
}
    // rust: for id in 0..registry.len() {
    // rust: if !definitions.contains_key(&registry.state(BlockStateId(id as u32)).unwrap().name) {
    // rust: return Err(invalid("missing movement definition"));
}
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: definitions,
    // rust: })
}
    /// Bind again when tags reload; existing bindings retain their old snapshot.
pub fn bind(self: *Self, tags: *MovementTags) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for name in tags
    // rust: .fences
    // rust: .iter()
    // rust: .chain(&tags.walls)
    // rust: .chain(&tags.suppresses_bounce)
    // rust: {
    // rust: if self.registry.default_state(name).is_none() {
    // rust: return Err(invalid("unknown movement tag member"));
}
}
    // rust: let states = (0..self.registry.len())
    // rust: .map(|id| {
    // rust: let name = &self.registry.state(BlockStateId(id as u32)).unwrap().name;
    // rust: MovementBlock {
    // rust: coefficients: self.definitions[name],
    // rust: fence: tags.fences.contains(name),
    // rust: wall: tags.walls.contains(name),
    // rust: suppresses_bounce: tags.suppresses_bounce.contains(name),
    // rust: water: name == "minecraft:water",
    // rust: bubble_column: name == "minecraft:bubble_column",
}
    // rust: })
    // rust: .collect();
    // rust: Ok(BoundMovementProperties { states })
}
}
pub const BoundMovementProperties = struct {
    states: std.ArrayList(MovementBlock),
};
    // rust: impl BoundMovementProperties {
pub fn get(self: *Self, state: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.states
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("movement state outside registry"))
}
}
    // rust: pub trait MovementBlockProvider {
    // rust: type Error;
pub fn movement_block_state(self: *Self, position: BlockPos) R;
}
pub const MovementBlockError = enum {
    Data(io::Error),
    World(E),
};
    // rust: impl<E: fmt::Display> fmt::Display for MovementBlockError<E> {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for MovementBlockError<E> {
pub fn source(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(match self {
    // rust: Self::Data(e) => e,
    // rust: Self::World(e) => e,
    // rust: })
}
}
pub const RegistryMovementWorld = struct {
    properties: *'a BoundMovementProperties,
    world: *'a mut W,
};
    // rust: impl<W: MovementBlockProvider> MovementBlockWorld for RegistryMovementWorld<'_, W> {
    // rust: type Error = MovementBlockError<W::Error>;
    // rust: type State = MovementBlock;
pub fn block_state(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self
    // rust: .world
    // rust: .movement_block_state(p)
    // rust: .map_err(MovementBlockError::World)?;
    // rust: self.properties.get(state).map_err(MovementBlockError::Data)
}
pub fn is_fence(self: *Self, s: MovementBlock) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(s.fence)
}
pub fn is_wall(self: *Self, s: MovementBlock) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(s.wall)
}
pub fn is_fence_gate(self: *Self, s: MovementBlock) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(s.coefficients.fence_gate)
}
pub fn is_water(self: *Self, s: MovementBlock) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(s.water)
}
pub fn is_bubble_column(self: *Self, s: MovementBlock) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(s.bubble_column)
}
pub fn jump_factor(self: *Self, s: MovementBlock) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(s.coefficients.jump_factor)
}
pub fn speed_factor(self: *Self, s: MovementBlock) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(s.coefficients.speed_factor)
}
}
