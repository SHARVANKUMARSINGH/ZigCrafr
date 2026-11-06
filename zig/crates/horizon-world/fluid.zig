//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fluid
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Fluid states carried by the pinned vanilla block-state registry.
//! Flow updates, spreading and entity interaction are separate simulation work.
// use crate::{
    // rust: chunk::BlockState,
    // rust: compression::invalid,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use std::io;

pub const FluidKind = enum {
    Empty,
    FlowingWater,
    Water,
    FlowingLava,
    Lava,
};
    // rust: impl FluidKind {
    // rust: pub const ALL: [Self; 5] = [
    // rust: Self::Empty,
    // rust: Self::FlowingWater,
    // rust: Self::Water,
    // rust: Self::FlowingLava,
    // rust: Self::Lava,
    // rust: ];
    // rust: pub const fn name(self) -> &'static str {
    // rust: match self {
    // rust: Self::Empty => "minecraft:empty",
    // rust: Self::FlowingWater => "minecraft:flowing_water",
    // rust: Self::Water => "minecraft:water",
    // rust: Self::FlowingLava => "minecraft:flowing_lava",
    // rust: Self::Lava => "minecraft:lava",
}
}
pub fn from_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL.into_iter().find(|kind| kind.name() == name)
}
    // rust: pub const fn same_family(self, other: Self) -> bool {
    // rust: matches!(
    // rust: (self, other),
    // rust: (Self::Empty, Self::Empty)
    // rust: | (
    // rust: Self::Water | Self::FlowingWater,
    // rust: Self::Water | Self::FlowingWater
    // rust: )
    // rust: | (
    // rust: Self::Lava | Self::FlowingLava,
    // rust: Self::Lava | Self::FlowingLava
    // rust: )
    // rust: )
}
    // rust: pub const fn mask(self) -> u8 {
    // rust: 1 << self as u8
}
}
pub const FluidState = struct {
    kind: FluidKind,
    amount: u8,
    falling: bool,
};
    // rust: impl FluidState {
    /// Native fluid states require an object; properties decode leniently.
pub fn from_json(json: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value: serde_json::Value =
    // rust: serde_json::from_str(json).map_err(|e| invalid(e.to_string()))?;
    // rust: let name = value
    // rust: .get("id")
    // rust: .and_then(serde_json::Value::as_str)
    // rust: .ok_or_else(|| invalid("missing fluid identifier"))?;
    // rust: let (namespace, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let name = format!(
    // rust: "{}:{path}",
    // rust: if namespace.is_empty() {
    // rust: "minecraft"
    // rust: } else {
    // rust: namespace
}
    // rust: );
    // rust: let kind =
    // rust: FluidKind::from_name(&name).ok_or_else(|| invalid("unknown fluid identifier"))?;
    // rust: if kind == FluidKind::Empty {
    // rust: return Ok(Self::EMPTY);
}
    // rust: let flowing = matches!(kind, FluidKind::FlowingWater | FluidKind::FlowingLava);
    // rust: let mut state = Self {
    // rust: kind,
    // rust: amount: if flowing { 1 } else { 8 },
    // rust: falling: true,
}
    // rust: if let Some(properties) = value
    // rust: .get("properties")
    // rust: .and_then(serde_json::Value::as_object)
    // rust: {
    // rust: if let Some(value) = properties
    // rust: .get("falling")
    // rust: .and_then(serde_json::Value::as_str)
    // rust: {
    // rust: match value {
    // rust: "true" => state.falling = true,
    // rust: "false" => state.falling = false,
    // rust: _ => {}
}
}
    // rust: if flowing {
    // rust: if let Some(value) = properties
    // rust: .get("level")
    // rust: .and_then(serde_json::Value::as_str)
    // rust: .and_then(crate::registry::java_integer)
    // rust: .filter(|v| (1..=8).contains(v))
    // rust: {
    // rust: state.amount = value as u8;
}
}
}
    // rust: Ok(state)
}
pub fn to_json(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut value = serde_json::json!({"id": self.kind.name()});
    // rust: if self.kind != FluidKind::Empty {
    // rust: let mut properties = serde_json::json!({"falling": self.falling.to_string()});
    // rust: if !self.is_source() {
    // rust: properties["level"] = self.amount.to_string().into();
}
    // rust: value["properties"] = properties;
}
    // rust: serde_json::to_string(&value).map_err(|e| invalid(e.to_string()))
}
    /// A fluid state from its parts; the empty fluid ignores amount and falling.
    // rust: pub const fn new(kind: FluidKind, amount: u8, falling: bool) -> Self {
    // rust: if matches!(kind, FluidKind::Empty) {
    // rust: return Self::EMPTY;
}
    // rust: Self {
    // rust: kind,
    // rust: amount,
    // rust: falling,
}
}
    // rust: pub const EMPTY: Self = Self {
    // rust: kind: FluidKind::Empty,
    // rust: amount: 0,
    // rust: falling: false,
}
    // rust: pub const WATER: Self = Self {
    // rust: kind: FluidKind::Water,
    // rust: amount: 8,
    // rust: falling: false,
}
    // rust: pub const fn kind(self) -> FluidKind {
    // rust: self.kind
}
    // rust: pub const fn amount(self) -> u8 {
    // rust: self.amount
}
    // rust: pub const fn falling(self) -> bool {
    // rust: self.falling
}
    // rust: pub const fn is_source(self) -> bool {
    // rust: matches!(self.kind, FluidKind::Water | FluidKind::Lava)
}
    // rust: pub const fn is_full(self) -> bool {
    // rust: self.amount == 8
}
    // rust: pub fn height_at<W: FluidHeightWorld>(
    // rust: self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, W::Error> {
    // rust: if self.kind == FluidKind::Empty {
    // rust: return Ok(0.0);
}
    // rust: let above = [position[0], position[1].wrapping_add(1), position[2]];
    // rust: Ok(if self.kind.same_family(world.fluid(above)?.kind) {
    // rust: 1.0
    // rust: } else {
    // rust: self.own_height()
    // rust: })
}
    // rust: pub fn camera_height_at<W: FluidHeightWorld>(
    // rust: self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: ) -> Result<f32, W::Error> {
    // rust: if self.is_source() {
    // rust: let above = [position[0], position[1].wrapping_add(1), position[2]];
    // rust: if world.sturdy_down(above)? {
    // rust: return Ok(1.0);
}
}
    // rust: self.height_at(world, position)
}
pub fn own_height(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f32::from(self.amount) / 9.0
}
pub fn from_block(state: *BlockState) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let water = state.name == "minecraft:water";
    // rust: if water || state.name == "minecraft:lava" {
    // rust: let level = state
    // rust: .properties
    // rust: .get("level")
    // rust: .and_then(|v| v.parse::<u8>().ok())
    // rust: .filter(|v| *v <= 15)
    // rust: .ok_or_else(|| invalid("invalid liquid block level"))?;
    // rust: let kind = match (water, level == 0) {
    // rust: (true, true) => FluidKind::Water,
    // rust: (true, false) => FluidKind::FlowingWater,
    // rust: (false, true) => FluidKind::Lava,
    // rust: (false, false) => FluidKind::FlowingLava,
}
    // rust: return Ok(Self {
    // rust: kind,
    // rust: amount: if level == 0 || level >= 8 {
    // rust: 8
    // rust: } else {
    // rust: 8 - level
    // rust: },
    // rust: falling: level >= 8,
    // rust: });
}
    // rust: if matches!(
    // rust: state.name.as_str(),
    // rust: "minecraft:kelp"
    // rust: | "minecraft:kelp_plant"
    // rust: | "minecraft:seagrass"
    // rust: | "minecraft:tall_seagrass"
    // rust: | "minecraft:bubble_column"
    // rust: ) {
    // rust: return Ok(Self::WATER);
}
    // rust: match state.properties.get("waterlogged").map(String::as_str) {
    // rust: Some("true") => {
                // The pinned copper-grate blocks use falling source water.
    // rust: let falling = matches!(
    // rust: state.name.as_str(),
    // rust: "minecraft:copper_grate"
    // rust: | "minecraft:exposed_copper_grate"
    // rust: | "minecraft:weathered_copper_grate"
    // rust: | "minecraft:oxidized_copper_grate"
    // rust: | "minecraft:waxed_copper_grate"
    // rust: | "minecraft:waxed_exposed_copper_grate"
    // rust: | "minecraft:waxed_weathered_copper_grate"
    // rust: | "minecraft:waxed_oxidized_copper_grate"
    // rust: );
    // rust: Ok(Self {
    // rust: falling,
    // rust: ..Self::WATER
    // rust: })
}
    // rust: None | Some("false") => Ok(Self::EMPTY),
    // rust: _ => Err(invalid("invalid waterlogged block property")),
}
}
}
/// Queries required by fluid surface height and camera immersion. The caller
/// owns block shape/support behavior and world-query failures.
    // rust: pub trait FluidHeightWorld {
    // rust: type Error;
pub fn fluid(self: *Self, position: [i32; 3]) R;
pub fn sturdy_down(self: *Self, position: [i32; 3]) R;
}
pub const FluidStateTable = struct {};
    // rust: impl FluidStateTable {
pub fn new(registry: *BlockRegistry) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..registry.len())
    // rust: .map(|i| FluidState::from_block(registry.state(BlockStateId(i as u32)).unwrap()))
    // rust: .collect::<io::Result<Vec<_>>>()
    // rust: .map(Self)
}
pub fn get(self: *Self, state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.get(state.0 as usize).copied()
}
}

/// Bound identities for converting fluid states into their legacy liquid blocks.
pub const FluidBlockBindings = struct {
    air: BlockStateId,
    water: [BlockStateId,
    lava: [BlockStateId,
};
    // rust: impl FluidBlockBindings {
pub fn new(registry: *BlockRegistry) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let levels = |name: &str| -> io::Result<[BlockStateId; 16]> {
    // rust: let default = registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| invalid("missing liquid block"))?;
    // rust: let mut state = registry.state(default).unwrap().clone();
    // rust: let mut result = [default; 16];
    // rust: for (level, id) in result.iter_mut().enumerate() {
    // rust: state.properties.insert("level".into(), level.to_string());
    // rust: *id = registry
    // rust: .id(&state)
    // rust: .ok_or_else(|| invalid("missing liquid block level"))?;
}
    // rust: Ok(result)
}
    // rust: Ok(Self {
    // rust: air: registry
    // rust: .default_state("minecraft:air")
    // rust: .ok_or_else(|| invalid("missing air block"))?,
    // rust: water: levels("minecraft:water")?,
    // rust: lava: levels("minecraft:lava")?,
    // rust: })
}
pub fn block(self: *Self, state: FluidState) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if state.kind == FluidKind::Empty {
    // rust: return self.air;
}
    // rust: let level = if state.is_source() {
    // rust: 0
    // rust: } else {
    // rust: 8 - state.amount.min(8) + if state.falling { 8 } else { 0 }
    // rust: } as usize;
    // rust: if state.kind.same_family(FluidKind::Water) {
    // rust: self.water[level]
    // rust: } else {
    // rust: self.lava[level]
}
}
}
