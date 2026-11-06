//! Transpiled from Horizon Rust crate
//! Module: horizon-world_block_placement
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Block placement operations used by the simple-block world-generation feature.
// use crate::{
    // rust: block_properties::{BlockPropertiesRegistry, BlockProperty, BoundBlockProperty},
    // rust: compression::invalid,
    // rust: fluid::FluidStateTable,
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::{
    // rust: feature::FeatureWorld,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: },
}
// use horizon_core::geometry::Direction;
// use std::{collections::BTreeSet, io, sync::Arc};

    // rust: const HORIZONTAL: [Direction; 4] = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ];
pub const SIDE_NAMES: [[]const u8; 4] = ["north", "east", "south", "west"];

pub const Placement = enum {
    Single,
    Double(usize),
    Moss,
};
pub const DoublePlant = struct {
    halves: [[BlockStateId,
    waterlogged: bool,
};
pub const Moss = struct {
    bottom: bool,
    sides: [u8,
};
    // rust: impl Moss {
pub fn code(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sides
    // rust: .into_iter()
    // rust: .fold(usize::from(self.bottom), |code, side| {
    // rust: code * 3 + usize::from(side)
    // rust: })
}
pub fn has_faces(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.bottom || self.sides.into_iter().any(|side| side != 0)
}
}
pub const BlockPlacementError = enum {
    World(E),
    Registry(io::Error),
    Query(PlacementQueryError),
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for BlockPlacementError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(error) => error.fmt(f),
    // rust: Self::Registry(error) => error.fmt(f),
    // rust: Self::Query(error) => error.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for BlockPlacementError<E> {}

pub const BlockPlacementBindings = struct {
    registry: *'r BlockRegistry,
    operations: *BlockPlacement,
};
/// Precompiled transitions shared by decoded features in one registry snapshot.
pub const BlockPlacement = struct {
    kinds: std.ArrayList(Placement),
    doubles: std.ArrayList(DoublePlant),
    replaceable: BoundBlockProperty,
    fluids: FluidStateTable,
    air: [BlockStateId,
    defaults: std.ArrayList(BlockStateId),
    moss: std.ArrayList(?Moss),
    moss_ids: [BlockStateId,
    moss_default: BlockStateId,
};
    // rust: impl<'r> BlockPlacementBindings<'r> {
    // rust: pub fn new(
    // rust: registry: &'r BlockRegistry,
    // rust: properties: &BlockPropertiesRegistry<'r>,
    // rust: double_plants: &BTreeSet<String>,
    // rust: mossy_carpets: &BTreeSet<String>,
    // rust: ) -> io::Result<Self> {
    // rust: if !std::ptr::eq(registry, properties.registry()) {
    // rust: return Err(invalid("placement properties use another registry"));
}
    // rust: for name in double_plants.iter().chain(mossy_carpets) {
    // rust: if registry.default_state(name).is_none() {
    // rust: return Err(invalid("unknown placement definition"));
}
}
    // rust: let default = |name: &str| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| invalid("missing placement block"))
}
    // rust: let mut kinds = Vec::with_capacity(registry.len());
    // rust: let mut doubles = Vec::new();
    // rust: let mut defaults = Vec::new();
    // rust: let mut moss = Vec::new();
    // rust: let mut moss_ids = [None; 162];
    // rust: for index in 0..registry.len() {
    // rust: let id = BlockStateId(index as u32);
    // rust: let state = registry.state(id).unwrap();
    // rust: defaults.push(default(&state.name)?);
    // rust: let kind = if double_plants.contains(&state.name) {
    // rust: let waterlogged = state.properties.contains_key("waterlogged");
    // rust: let mut halves = [[id; 2]; 2];
    // rust: for (half, values) in halves.iter_mut().enumerate() {
    // rust: for (water, target) in values.iter_mut().enumerate() {
    // rust: let mut descriptor = state.clone();
    // rust: descriptor.properties.insert(
    // rust: "half".into(),
    // rust: if half == 0 { "lower" } else { "upper" }.into(),
    // rust: );
    // rust: if waterlogged {
    // rust: descriptor.properties.insert(
    // rust: "waterlogged".into(),
    // rust: if water == 0 { "false" } else { "true" }.into(),
    // rust: );
}
    // rust: *target = registry
    // rust: .id(&descriptor)
    // rust: .ok_or_else(|| invalid("missing double-plant transition"))?;
}
}
    // rust: let selected = doubles.len();
    // rust: doubles.push(DoublePlant {
    // rust: halves,
    // rust: waterlogged,
    // rust: });
    // rust: Placement::Double(selected)
    // rust: } else if mossy_carpets.contains(&state.name) {
    // rust: Placement::Moss
    // rust: } else {
    // rust: Placement::Single
}
    // rust: kinds.push(kind);
    // rust: let value = if state.name == "minecraft:pale_moss_carpet" {
    // rust: let bottom = match state.properties.get("bottom").map(String::as_str) {
    // rust: Some("true") => true,
    // rust: Some("false") => false,
    // rust: _ => return Err(invalid("invalid moss bottom")),
}
    // rust: let mut sides = [0; 4];
    // rust: for (slot, name) in sides.iter_mut().zip(SIDE_NAMES) {
    // rust: *slot = match state.properties.get(name).map(String::as_str) {
    // rust: Some("none") => 0,
    // rust: Some("low") => 1,
    // rust: Some("tall") => 2,
    // rust: _ => return Err(invalid("invalid moss side")),
}
}
    // rust: let value = Moss { bottom, sides };
    // rust: if moss_ids[value.code()].replace(id).is_some() {
    // rust: return Err(invalid("ambiguous moss state"));
}
    // rust: Some(value)
    // rust: } else {
    // rust: None
}
    // rust: moss.push(value);
}
    // rust: let moss_ids = moss_ids
    // rust: .into_iter()
    // rust: .collect::<Option<Vec<_>>>()
    // rust: .ok_or_else(|| invalid("incomplete moss states"))?
    // rust: .try_into()
    // rust: .map_err(|_| invalid("invalid moss state count"))?;
    // rust: Ok(Self {
    // rust: registry,
    // rust: operations: Arc::new(BlockPlacement {
    // rust: kinds,
    // rust: doubles,
    // rust: replaceable: properties.bind(BlockProperty::Replaceable),
    // rust: fluids: FluidStateTable::new(registry)?,
    // rust: air: [
    // rust: default("minecraft:air")?,
    // rust: default("minecraft:cave_air")?,
    // rust: default("minecraft:void_air")?,
    // rust: ],
    // rust: defaults,
    // rust: moss,
    // rust: moss_ids,
    // rust: moss_default: default("minecraft:pale_moss_carpet")?,
    // rust: }),
    // rust: })
}
pub fn registry(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
}
pub fn operations(self: *Self) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.operations.clone()
}
}
    // rust: impl BlockPlacement {
    // rust: fn read<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: ) -> Result<BlockStateId, BlockPlacementError<W::Error>> {
    // rust: let state = world.block(position).map_err(BlockPlacementError::World)?;
    // rust: if state.0 as usize >= self.kinds.len() {
    // rust: return Err(BlockPlacementError::Registry(invalid(
    // rust: "unregistered placement world state",
    // rust: )));
}
    // rust: Ok(state)
}
pub fn moss_state(self: *Self, state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.moss[state.0 as usize]
}
    // rust: fn updated_moss<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: Moss,
    // rust: position: [i32; 3],
    // rust: force: bool,
    // rust: ) -> Result<Moss, BlockPlacementError<W::Error>> {
    // rust: let force = force | state.bottom;
    // rust: let mut result = state;
    // rust: let mut above = None;
    // rust: let mut below = None;
    // rust: for (index, direction) in HORIZONTAL.into_iter().enumerate() {
    // rust: let mut side = if world
    // rust: .attachment_at(position, direction)
    // rust: .map_err(BlockPlacementError::Query)?
    // rust: {
    // rust: if force { 1 } else { state.sides[index] }
    // rust: } else {
    // rust: 0
}
    // rust: if side == 1 {
    // rust: let upper = match above {
    // rust: Some(id) => id,
    // rust: None => {
    // rust: let id = self.read(world, relative(position, Direction::Up))?;
    // rust: above = Some(id);
    // rust: id
}
}
    // rust: if self
    // rust: .moss_state(upper)
    // rust: .is_some_and(|value| !value.bottom && value.sides[index] != 0)
    // rust: {
    // rust: side = 2;
}
    // rust: if !state.bottom {
    // rust: let lower = match below {
    // rust: Some(id) => id,
    // rust: None => {
    // rust: let id = self.read(world, relative(position, Direction::Down))?;
    // rust: below = Some(id);
    // rust: id
}
}
    // rust: if self
    // rust: .moss_state(lower)
    // rust: .is_some_and(|value| value.sides[index] == 0)
    // rust: {
    // rust: side = 0;
}
}
}
    // rust: result.sides[index] = side;
}
    // rust: Ok(result)
}
    // rust: fn topper<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: ) -> Result<Option<BlockStateId>, BlockPlacementError<W::Error>> {
    // rust: let above = relative(position, Direction::Up);
    // rust: let current = self.read(world, above)?;
    // rust: if self.moss_state(current).is_some_and(|value| value.bottom)
    // rust: || (self.moss_state(current).is_none() && !self.replaceable.contains(current))
    // rust: {
    // rust: return Ok(None);
}
    // rust: let mut state = self.moss_state(self.moss_default).unwrap();
    // rust: state.bottom = false;
    // rust: state = self.updated_moss(world, state, above, true)?;
    // rust: for side in &mut state.sides {
    // rust: if *side != 0
    // rust: && !world
    // rust: .next_world_boolean()
    // rust: .map_err(BlockPlacementError::Query)?
    // rust: {
    // rust: *side = 0;
}
}
    // rust: let id = self.moss_ids[state.code()];
    // rust: Ok((state.has_faces() && id != current).then_some(id))
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: flags: i32,
    // rust: ) -> Result<bool, BlockPlacementError<W::Error>> {
    // rust: let kind = *self.kinds.get(state.0 as usize).ok_or_else(|| {
    // rust: BlockPlacementError::Registry(invalid("unregistered placement candidate"))
    // rust: })?;
    // rust: match kind {
    // rust: Placement::Single => {
    // rust: world
    // rust: .set_block(position, state, flags)
    // rust: .map_err(BlockPlacementError::World)?;
}
    // rust: Placement::Double(index) => {
    // rust: let above = relative(position, Direction::Up);
    // rust: let current = self.read(world, above)?;
    // rust: if !self.air.contains(&current)
    // rust: && (self.fluids.get(state) != self.fluids.get(current)
    // rust: || !self.replaceable.contains(current))
    // rust: {
    // rust: return Ok(false);
}
    // rust: let plant = self.doubles[index];
    // rust: for (half, at) in [position, above].into_iter().enumerate() {
    // rust: let water = plant.waterlogged
    // rust: && world.water_at(at).map_err(BlockPlacementError::Query)?;
    // rust: world
    // rust: .set_block(at, plant.halves[half][usize::from(water)], flags)
    // rust: .map_err(BlockPlacementError::World)?;
}
}
    // rust: Placement::Moss => {
    // rust: let lower = self.updated_moss(
    // rust: world,
    // rust: self.moss_state(self.moss_default).unwrap(),
    // rust: position,
    // rust: true,
    // rust: )?;
    // rust: world
    // rust: .set_block(position, self.moss_ids[lower.code()], flags)
    // rust: .map_err(BlockPlacementError::World)?;
    // rust: if let Some(top) = self.topper(world, position)? {
    // rust: world
    // rust: .set_block(relative(position, Direction::Up), top, flags)
    // rust: .map_err(BlockPlacementError::World)?;
    // rust: let lower = self.updated_moss(world, lower, position, true)?;
    // rust: world
    // rust: .set_block(position, self.moss_ids[lower.code()], flags)
    // rust: .map_err(BlockPlacementError::World)?;
}
}
}
    // rust: Ok(true)
}
    // rust: pub fn schedule_tick<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: delay: i32,
    // rust: ) -> Result<(), BlockPlacementError<W::Error>> {
    // rust: let state = self.read(world, position)?;
    // rust: world
    // rust: .schedule_block_tick(position, self.defaults[state.0 as usize], delay)
    // rust: .map_err(BlockPlacementError::Query)
}
}
pub fn relative(position: [i32; 3], direction: Direction) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let step = direction.normal();
    // rust: std::array::from_fn(|i| position[i].wrapping_add(step[i]))
}
