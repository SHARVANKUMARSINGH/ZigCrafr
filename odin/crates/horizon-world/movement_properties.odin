//! Transpiled from Horizon Rust crate
package horizon_world_movement_properties

import "core:fmt"
import "core:mem"
import "core:math"

// Registry-bound block movement coefficients, identities and reloadable tags.
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

MovementCoefficients :: struct {
    friction: f32,
    speed_factor: f32,
    jump_factor: f32,
    bounce_restitution: f32,
    fall_distance_reduction: f32,
    fence_gate: bool,
}
MovementBlock :: struct {
    coefficients: MovementCoefficients,
    fence: bool,
    wall: bool,
    suppresses_bounce: bool,
    water: bool,
    bubble_column: bool,
}
MovementTags :: struct {
    fences: BTreeSet<string>,
    walls: BTreeSet<string>,
    suppresses_bounce: BTreeSet<string>,
}
// Definitions are private version-specific data; no runtime Java is required.
MovementProperties :: struct {
    registry: ^'r BlockRegistry,
    definitions: BTreeMap<string,
}
    // rust: impl<'r> MovementProperties<'r> {
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
}
coefficients :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let state = self
    // rust: .registry
    // rust: .state(state)
    // rust: .ok_or_else(|| invalid("movement state outside registry"))?;
    // rust: Ok(self.definitions[&state.name])
}

from_nbt :: proc(tag: ^Tag, registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Self::from_table(BlockTable::check(tag, registry, "movement")?)
}
from_table :: proc(table: BlockTable<'_) -> i {
    // Ported from Horizon
    return {}
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
    // Bind again when tags reload; existing bindings retain their old snapshot.
bind :: proc(self: ^Self, tags: ^MovementTags) -> i {
    // Ported from Horizon
    return {}
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
BoundMovementProperties :: struct {
    states: [dynamic]MovementBlock,
}
    // rust: impl BoundMovementProperties {
get :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("movement state outside registry"))
}
}
    // rust: pub trait MovementBlockProvider {
    // rust: type Error;
movement_block_state :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
}
MovementBlockError :: enum {
    Data(io::Error),
    World(E),
}
    // rust: impl<E: fmt::Display> fmt::Display for MovementBlockError<E> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for MovementBlockError<E> {
source :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(match self {
    // rust: Self::Data(e) => e,
    // rust: Self::World(e) => e,
    // rust: })
}
}
RegistryMovementWorld :: struct {
    properties: ^'a BoundMovementProperties,
    world: ^'a mut W,
}
    // rust: impl<W: MovementBlockProvider> MovementBlockWorld for RegistryMovementWorld<'_, W> {
    // rust: type Error = MovementBlockError<W::Error>;
    // rust: type State = MovementBlock;
block_state :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = self
    // rust: .world
    // rust: .movement_block_state(p)
    // rust: .map_err(MovementBlockError::World)?;
    // rust: self.properties.get(state).map_err(MovementBlockError::Data)
}
is_fence :: proc(self: ^Self, s: MovementBlock) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.fence)
}
is_wall :: proc(self: ^Self, s: MovementBlock) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.wall)
}
is_fence_gate :: proc(self: ^Self, s: MovementBlock) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.coefficients.fence_gate)
}
is_water :: proc(self: ^Self, s: MovementBlock) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.water)
}
is_bubble_column :: proc(self: ^Self, s: MovementBlock) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.bubble_column)
}
jump_factor :: proc(self: ^Self, s: MovementBlock) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.coefficients.jump_factor)
}
speed_factor :: proc(self: ^Self, s: MovementBlock) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.coefficients.speed_factor)
}
}
