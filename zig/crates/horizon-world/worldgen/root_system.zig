//! Transpiled from Horizon Rust crate
//! Module: horizon-world_root_system
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `minecraft:root_system`: a nested tree on a rooted-dirt column with
//! hanging roots below.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::BlockPredicate,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::{FeatureExecutionError, PlacedFeatureDefinition},
    // rust: int_range,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: state_provider::BlockStateProvider,
    // rust: tree::{TreeDecoder, TreeResult, kind, read, sample_state, write},
    // rust: tree_blocks::{self as tb, TreeBlocks},
    // rust: vegetation::{PlacedDecoder, PlacedPlacer},
}
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::{collections::BTreeSet, sync::Arc};

    // rust: fn query<E>(error: PlacementQueryError) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Query(error)
}

pub const RootSystemFeature = struct {
    tree: *PlacedFeatureDefinition,
    required_vertical_space: i32,
    level_test_distance: i32,
    max_level_deviation: i32,
    root_radius: i32,
    root_replaceable: *BTreeSet<BlockStateId>,
    root_provider: BlockStateProvider,
    root_attempts: i32,
    root_column_max_height: i32,
    hanging_radius: i32,
    hanging_span: i32,
    hanging_provider: BlockStateProvider,
    hanging_attempts: i32,
    allowed_water: i32,
    allowed_tree_position: BlockPredicate,
    blocks: *TreeBlocks,
};
    // rust: impl RootSystemFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: nested: &PlacedDecoder<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:root_system" {
    // rust: return Err(DecodeError::Field("root system type"));
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let tree = nested(required(&object, "feature")?.get(), depth + 1, remaining)?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let int = |name: &'static str, low: i32, high: i32| {
    // rust: int_range(required(&object, name)?, name, low, high)
}
    // rust: Ok(Self {
    // rust: tree: Box::new(tree),
    // rust: required_vertical_space: int("required_vertical_space_for_tree", 1, 64)?,
    // rust: level_test_distance: int("level_test_distance", 0, 16)?,
    // rust: max_level_deviation: int("max_level_deviation", 0, 64)?,
    // rust: root_radius: int("root_radius", 1, 64)?,
    // rust: root_replaceable: decoder.block_set(required(&object, "root_replaceable")?)?,
    // rust: root_provider: decoder.provider(required(&object, "root_state_provider")?)?,
    // rust: root_attempts: int("root_placement_attempts", 1, 256)?,
    // rust: root_column_max_height: int("root_column_max_height", 1, 4096)?,
    // rust: hanging_radius: int("hanging_root_radius", 1, 64)?,
    // rust: hanging_span: int("hanging_roots_vertical_span", 1, 16)?,
    // rust: hanging_provider: decoder
    // rust: .provider(required(&object, "hanging_root_state_provider")?)?,
    // rust: hanging_attempts: int("hanging_root_placement_attempts", 1, 256)?,
    // rust: allowed_water: int("allowed_vertical_water_for_tree", 1, 64)?,
    // rust: allowed_tree_position: BlockPredicate::decode_with_blocks(
    // rust: required(&object, "allowed_tree_position")?.get(),
    // rust: depth + 1,
    // rust: decoder.remaining,
    // rust: Some(bindings),
    // rust: )?,
    // rust: blocks,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: nested: &mut PlacedPlacer<'_, W, R>,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if !self.blocks.is_air(read(world, origin)?) {
    // rust: return Ok(false);
}
    // rust: if self.dirt_and_tree(world, random, origin, nested)? {
    // rust: self.hanging_roots(world, random, origin)?;
}
    // rust: Ok(true)
}
    // rust: fn space_for_tree<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: pos: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let mut column = pos;
    // rust: for i in 1..=self.required_vertical_space {
    // rust: column = tb::offset(column, 0, 1, 0);
    // rust: let state = read(world, column)?;
    // rust: let allowed = self.blocks.is_air(state)
    // rust: || (i < self.allowed_water && self.blocks.has(state, tb::WATER_FLUID));
    // rust: if !allowed {
    // rust: return Ok(false);
}
}
    // rust: if self.level_test_distance > 0 {
            // Direction.from2DDataValue: SOUTH, WEST, NORTH, EAST.
    // rust: for direction in [
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: ] {
    // rust: let corner = tb::relative(pos, direction, self.level_test_distance);
    // rust: let below = read(world, tb::offset(corner, 0, -self.max_level_deviation, 0))?;
    // rust: let above = read(world, tb::offset(corner, 0, self.max_level_deviation, 0))?;
    // rust: if self.blocks.is_air(below) || !self.blocks.is_air(above) {
    // rust: return Ok(false);
}
}
}
    // rust: Ok(true)
}
    // rust: fn dirt_and_tree<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: nested: &mut PlacedPlacer<'_, W, R>,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let mut working = origin;
    // rust: for y in 0..self.root_column_max_height {
    // rust: working = tb::offset(working, 0, 1, 0);
    // rust: let surface = world
    // rust: .height(
    // rust: crate::heightmap::HeightmapType::WorldSurface,
    // rust: working[0],
    // rust: working[2],
    // rust: )
    // rust: .map_err(query)?;
    // rust: if surface < working[1] {
    // rust: return Ok(false);
}
    // rust: if self
    // rust: .allowed_tree_position
    // rust: .test(world, working)
    // rust: .map_err(query)?
    // rust: && self.space_for_tree(world, working)?
    // rust: {
    // rust: let below_state = read(world, tb::offset(working, 0, -1, 0))?;
    // rust: if self.blocks.has(below_state, tb::LAVA_FLUID)
    // rust: || !self.blocks.has(below_state, tb::SOLID)
    // rust: {
    // rust: return Ok(false);
}
    // rust: if nested(&self.tree, world, random, working)? {
    // rust: let target = origin[1].wrapping_add(y);
    // rust: let mut level = origin[1];
    // rust: while level < target {
    // rust: self.rooted_dirt(world, random, [origin[0], level, origin[2]])?;
    // rust: level += 1;
}
    // rust: return Ok(true);
}
}
}
    // rust: Ok(false)
}
    // rust: fn rooted_dirt<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: column: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let r = self.root_radius;
    // rust: for _ in 0..self.root_attempts {
    // rust: let dx = random.next_int_bound(r)? - random.next_int_bound(r)?;
    // rust: let dz = random.next_int_bound(r)? - random.next_int_bound(r)?;
    // rust: let p = tb::offset(column, dx, 0, dz);
    // rust: if self.root_replaceable.contains(&read(world, p)?) {
    // rust: let state = sample_state(&self.root_provider, world, random, p)?;
    // rust: write(world, p, state, 2)?;
}
}
    // rust: Ok(())
}
    // rust: fn hanging_roots<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let (r, span) = (self.hanging_radius, self.hanging_span);
    // rust: for _ in 0..self.hanging_attempts {
    // rust: let dx = random.next_int_bound(r)? - random.next_int_bound(r)?;
    // rust: let dy = random.next_int_bound(span)? - random.next_int_bound(span)?;
    // rust: let dz = random.next_int_bound(r)? - random.next_int_bound(r)?;
    // rust: let p = tb::offset(origin, dx, dy, dz);
    // rust: if !self.blocks.is_air(read(world, p)?) {
    // rust: continue;
}
    // rust: let state = sample_state(&self.hanging_provider, world, random, p)?;
    // rust: if world.block_survives(state, p).map_err(query)? {
    // rust: let above = read(world, tb::offset(p, 0, 1, 0))?;
    // rust: if world
    // rust: .state_face_sturdy(above, p, Direction::Down)
    // rust: .map_err(query)?
    // rust: {
    // rust: write(world, p, state, 2)?;
}
}
}
    // rust: Ok(())
}
}
