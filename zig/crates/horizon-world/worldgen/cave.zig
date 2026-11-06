//! Transpiled from Horizon Rust crate
//! Module: horizon-world_cave
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Underground structures expressed as features: lakes, monster rooms
//! (dungeons) and geodes.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::BlockPredicate,
    // rust: double_range,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::FeatureExecutionError,
    // rust: int_range, optional,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: state_provider::BlockStateProvider,
    // rust: tree::{TreeDecoder, TreeResult, kind, read, sample_state, write},
    // rust: tree_blocks::{self as tb, TreeBlocks},
    // rust: value_provider::IntProvider,
}
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: noise::{Noise, NormalNoise},
    // rust: random::{LegacyRandom, RandomSource},
}
// use std::{collections::BTreeSet, sync::Arc};

    // rust: fn query<E>(error: PlacementQueryError) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Query(error)
}
    // rust: fn state<E>(blocks: &TreeBlocks, name: &str) -> TreeResult<BlockStateId, E> {
    // rust: blocks
    // rust: .default_state(name)
    // rust: .ok_or(FeatureExecutionError::InvalidState)
}
/// Feature.safeSetBlock.
    // rust: fn safe_set<W: FeatureWorld>(
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: value: BlockStateId,
    // rust: cannot_replace: impl Fn(BlockStateId) -> bool,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: if !cannot_replace(read(world, p)?) {
    // rust: write(world, p, value, 2)?;
}
    // rust: Ok(())
}
/// Feature.markAboveForPostProcessing.
    // rust: fn mark_above<W: FeatureWorld + PlacementContext>(
    // rust: world: &mut W,
    // rust: blocks: &TreeBlocks,
    // rust: p: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let mut above = p;
    // rust: for _ in 0..2 {
    // rust: above = tb::offset(above, 0, 1, 0);
    // rust: if blocks.is_air(read(world, above)?) {
    // rust: return Ok(());
}
    // rust: world.mark_postprocessing(above).map_err(query)?;
}
    // rust: Ok(())
}

pub const LakeFeature = struct {
    fluid: BlockStateProvider,
    barrier: BlockStateProvider,
    can_place: BlockPredicate,
    can_replace_air_or_fluid: BlockPredicate,
    can_replace_barrier: BlockPredicate,
    blocks: *TreeBlocks,
};
    // rust: impl LakeFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:lake" {
    // rust: return Err(DecodeError::Field("lake type"));
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let fluid = decoder.provider(required(&object, "fluid")?)?;
    // rust: let barrier = decoder.provider(required(&object, "barrier")?)?;
    // rust: let mut predicate = |name: &'static str| {
    // rust: BlockPredicate::decode_with_blocks(
    // rust: required(&object, name)?.get(),
    // rust: depth + 1,
    // rust: decoder.remaining,
    // rust: Some(bindings),
    // rust: )
}
    // rust: Ok(Self {
    // rust: fluid,
    // rust: barrier,
    // rust: can_place: predicate("can_place_feature")?,
    // rust: can_replace_air_or_fluid: predicate("can_replace_with_air_or_fluid")?,
    // rust: can_replace_barrier: predicate("can_replace_with_barrier")?,
    // rust: blocks,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if origin[1] <= world.min_y().map_err(query)?.wrapping_add(4) {
    // rust: return Ok(false);
}
    // rust: let origin = tb::offset(origin, -8, -4, -8);
    // rust: let mut grid = [false; 2048];
    // rust: let spots = random.next_int_bound(4)? + 4;
    // rust: for _ in 0..spots {
    // rust: let xr = random.next_double() * 6.0 + 3.0;
    // rust: let yr = random.next_double() * 4.0 + 2.0;
    // rust: let zr = random.next_double() * 6.0 + 3.0;
    // rust: let xp = random.next_double() * (16.0 - xr - 2.0) + 1.0 + xr / 2.0;
    // rust: let yp = random.next_double() * (8.0 - yr - 4.0) + 2.0 + yr / 2.0;
    // rust: let zp = random.next_double() * (16.0 - zr - 2.0) + 1.0 + zr / 2.0;
    // rust: for xx in 1..15 {
    // rust: for zz in 1..15 {
    // rust: for yy in 1..7 {
    // rust: let xd = (f64::from(xx) - xp) / (xr / 2.0);
    // rust: let yd = (f64::from(yy) - yp) / (yr / 2.0);
    // rust: let zd = (f64::from(zz) - zp) / (zr / 2.0);
    // rust: if xd * xd + yd * yd + zd * zd < 1.0 {
    // rust: grid[((xx * 16 + zz) * 8 + yy) as usize] = true;
}
}
}
}
}
    // rust: let at = |x: i32, y: i32, z: i32| grid[((x * 16 + z) * 8 + y) as usize];
    // rust: let edge = |x: i32, y: i32, z: i32| {
    // rust: !at(x, y, z)
    // rust: && ((x < 15 && at(x + 1, y, z))
    // rust: || (x > 0 && at(x - 1, y, z))
    // rust: || (z < 15 && at(x, y, z + 1))
    // rust: || (z > 0 && at(x, y, z - 1))
    // rust: || (y < 7 && at(x, y + 1, z))
    // rust: || (y > 0 && at(x, y - 1, z)))
}
    // rust: let fluid = sample_state(&self.fluid, world, random, origin)?;
    // rust: for xx in 0..16 {
    // rust: for zz in 0..16 {
    // rust: for yy in 0..8 {
    // rust: if edge(xx, yy, zz) {
    // rust: let p = tb::offset(origin, xx, yy, zz);
    // rust: let state = read(world, p)?;
    // rust: if yy >= 4 && self.blocks.has(state, tb::LIQUID) {
    // rust: return Ok(false);
}
    // rust: if yy < 4 && !self.blocks.has(state, tb::SOLID) && state != fluid {
    // rust: return Ok(false);
}
    // rust: if !self.can_place.test(world, p).map_err(query)? {
    // rust: return Ok(false);
}
}
}
}
}
    // rust: let cave_air = state(&self.blocks, "minecraft:cave_air")?;
    // rust: for xx in 0..16 {
    // rust: for zz in 0..16 {
    // rust: for yy in 0..8 {
    // rust: if at(xx, yy, zz) {
    // rust: let p = tb::offset(origin, xx, yy, zz);
    // rust: if self
    // rust: .can_replace_air_or_fluid
    // rust: .test(world, p)
    // rust: .map_err(query)?
    // rust: {
    // rust: let air = yy >= 4;
    // rust: write(world, p, if air { cave_air } else { fluid }, 2)?;
    // rust: if air {
    // rust: world.schedule_block_tick(p, cave_air, 0).map_err(query)?;
    // rust: mark_above(world, &self.blocks, p)?;
}
}
}
}
}
}
    // rust: let barrier = sample_state(&self.barrier, world, random, origin)?;
    // rust: if !self.blocks.is_air(barrier) {
    // rust: for xx in 0..16 {
    // rust: for zz in 0..16 {
    // rust: for yy in 0..8 {
    // rust: if edge(xx, yy, zz) && (yy < 4 || random.next_int_bound(2)? != 0) {
    // rust: let p = tb::offset(origin, xx, yy, zz);
    // rust: let state = read(world, p)?;
    // rust: if self.blocks.has(state, tb::SOLID)
    // rust: && self.can_replace_barrier.test(world, p).map_err(query)?
    // rust: {
    // rust: write(world, p, barrier, 2)?;
    // rust: mark_above(world, &self.blocks, p)?;
}
}
}
}
}
}
    // rust: if self.blocks.has(fluid, tb::WATER_FLUID) {
    // rust: let ice = state(&self.blocks, "minecraft:ice")?;
    // rust: for xx in 0..16 {
    // rust: for zz in 0..16 {
    // rust: let p = tb::offset(origin, xx, 4, zz);
    // rust: let biome = world.biome_identity(p).map_err(query)?;
    // rust: if world.biome_should_freeze(biome, p, false).map_err(query)?
    // rust: && self
    // rust: .can_replace_air_or_fluid
    // rust: .test(world, p)
    // rust: .map_err(query)?
    // rust: {
    // rust: write(world, p, ice, 2)?;
}
}
}
}
    // rust: Ok(true)
}
}

    // rust: const DUNGEON_MOBS: [&str; 4] = [
    // rust: "minecraft:skeleton",
    // rust: "minecraft:zombie",
    // rust: "minecraft:zombie",
    // rust: "minecraft:spider",
    // rust: ];
pub const MonsterRoomFeature = struct {
    blocks: *TreeBlocks,
};
    // rust: impl MonsterRoomFeature {
    // rust: pub(crate) fn new(bindings: &FeatureBlockBindings<'_>) -> Result<Self, DecodeError> {
    // rust: Ok(Self {
    // rust: blocks: bindings.tree_blocks()?,
    // rust: })
}
    // rust: fn solid<W: FeatureWorld>(&self, world: &mut W, p: [i32; 3]) -> TreeResult<bool, W::Error> {
    // rust: Ok(self.blocks.has(read(world, p)?, tb::SOLID))
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let blocks = &*self.blocks;
    // rust: let cannot = |s: BlockStateId| blocks.has(s, tb::FEATURES_CANNOT_REPLACE);
    // rust: let xr = random.next_int_bound(2)? + 2;
    // rust: let (min_x, max_x) = (-xr - 1, xr + 1);
    // rust: let zr = random.next_int_bound(2)? + 2;
    // rust: let (min_z, max_z) = (-zr - 1, zr + 1);
    // rust: let mut holes = 0;
    // rust: for dx in min_x..=max_x {
    // rust: for dy in -1..=4 {
    // rust: for dz in min_z..=max_z {
    // rust: let p = tb::offset(origin, dx, dy, dz);
    // rust: let solid = self.solid(world, p)?;
    // rust: if (dy == -1 || dy == 4) && !solid {
    // rust: return Ok(false);
}
    // rust: if (dx == min_x || dx == max_x || dz == min_z || dz == max_z)
    // rust: && dy == 0
    // rust: && blocks.is_air(read(world, p)?)
    // rust: && blocks.is_air(read(world, tb::offset(p, 0, 1, 0))?)
    // rust: {
    // rust: holes += 1;
}
}
}
}
    // rust: if !(1..=5).contains(&holes) {
    // rust: return Ok(false);
}
    // rust: let cave_air = state(blocks, "minecraft:cave_air")?;
    // rust: let cobble = state(blocks, "minecraft:cobblestone")?;
    // rust: let mossy = state(blocks, "minecraft:mossy_cobblestone")?;
    // rust: let min_y = world.min_y().map_err(query)?;
    // rust: for dx in min_x..=max_x {
    // rust: for dy in (-1..=3).rev() {
    // rust: for dz in min_z..=max_z {
    // rust: let p = tb::offset(origin, dx, dy, dz);
    // rust: let wall = read(world, p)?;
    // rust: if dx == min_x
    // rust: || dy == -1
    // rust: || dz == min_z
    // rust: || dx == max_x
    // rust: || dy == 4
    // rust: || dz == max_z
    // rust: {
    // rust: if p[1] >= min_y && !self.solid(world, tb::offset(p, 0, -1, 0))? {
    // rust: write(world, p, cave_air, 2)?;
    // rust: } else if blocks.has(wall, tb::SOLID) && !blocks.has(wall, tb::CHEST) {
    // rust: let value = if dy == -1 && random.next_int_bound(4)? != 0 {
    // rust: mossy
    // rust: } else {
    // rust: cobble
}
    // rust: safe_set(world, p, value, cannot)?;
}
    // rust: } else if !blocks.has(wall, tb::CHEST | tb::SPAWNER) {
    // rust: safe_set(world, p, cave_air, cannot)?;
}
}
}
}
    // rust: let chest = state(blocks, "minecraft:chest")?;
    // rust: for _ in 0..2 {
    // rust: for _ in 0..3 {
    // rust: let x = origin[0]
    // rust: .wrapping_add(random.next_int_bound(xr * 2 + 1)?)
    // rust: .wrapping_sub(xr);
    // rust: let z = origin[2]
    // rust: .wrapping_add(random.next_int_bound(zr * 2 + 1)?)
    // rust: .wrapping_sub(zr);
    // rust: let p = [x, origin[1], z];
    // rust: if !blocks.is_air(read(world, p)?) {
    // rust: continue;
}
    // rust: let mut walls = 0;
    // rust: for direction in tb::HORIZONTAL {
    // rust: if self.solid(world, tb::relative(p, direction, 1))? {
    // rust: walls += 1;
}
}
    // rust: if walls == 1 {
    // rust: let oriented = self.reorient(world, p, chest)?;
    // rust: safe_set(world, p, oriented, cannot)?;
    // rust: world
    // rust: .set_block_entity_loot_table(p, "minecraft:chests/simple_dungeon", random)
    // rust: .map_err(query)?;
    // rust: break;
}
}
}
    // rust: let spawner = state(blocks, "minecraft:spawner")?;
    // rust: safe_set(world, origin, spawner, cannot)?;
    // rust: if read(world, origin)? == spawner {
    // rust: let mob = DUNGEON_MOBS[random.next_int_bound(4)? as usize];
    // rust: world.configure_spawner(origin, mob).map_err(query)?;
}
    // rust: Ok(true)
}
    /// StructurePiece.reorient for the chest's horizontal facing.
    // rust: fn reorient<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: chest: BlockStateId,
    // rust: ) -> TreeResult<BlockStateId, W::Error> {
    // rust: let blocks = &*self.blocks;
    // rust: let mut solid_neighbor = None;
    // rust: for direction in tb::HORIZONTAL {
    // rust: let state = read(world, tb::relative(p, direction, 1))?;
    // rust: if blocks.has(state, tb::CHEST) {
    // rust: return Ok(chest);
}
    // rust: if blocks.has(state, tb::SOLID_RENDER) {
    // rust: if solid_neighbor.is_some() {
    // rust: solid_neighbor = None;
    // rust: break;
}
    // rust: solid_neighbor = Some(direction);
}
}
    // rust: let facing = |d: Direction| {
    // rust: blocks
    // rust: .with(chest, "facing", tb::direction_name(d))
    // rust: .ok_or(FeatureExecutionError::InvalidState)
}
    // rust: if let Some(direction) = solid_neighbor {
    // rust: return facing(direction.opposite());
}
    // rust: let mut lock = blocks
    // rust: .properties
    // rust: .value(chest, "facing")
    // rust: .and_then(|v| tb::decode_direction(v).ok())
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
    // rust: let mut rel = tb::relative(p, lock, 1);
    // rust: if blocks.has(read(world, rel)?, tb::SOLID_RENDER) {
    // rust: lock = lock.opposite();
    // rust: rel = tb::relative(p, lock, 1);
}
    // rust: if blocks.has(read(world, rel)?, tb::SOLID_RENDER) {
    // rust: lock = tb::clockwise(lock);
    // rust: rel = tb::relative(p, lock, 1);
}
    // rust: if blocks.has(read(world, rel)?, tb::SOLID_RENDER) {
    // rust: lock = lock.opposite();
}
    // rust: facing(lock)
}
}

pub const GeodeFeature = struct {
    filling: BlockStateProvider,
    inner: BlockStateProvider,
    alternate_inner: BlockStateProvider,
    middle: BlockStateProvider,
    outer: BlockStateProvider,
    inner_placements: std.ArrayList(BlockStateId),
    cannot_replace: *BTreeSet<BlockStateId>,
    invalid_blocks: *BTreeSet<BlockStateId>,
    layers: [f64,
    crack_chance: f64,
    base_crack_size: f64,
    crack_point_offset: i32,
    potential_chance: f64,
    alternate_chance: f64,
    require_alternate: bool,
    outer_wall_distance: IntProvider,
    distribution_points: IntProvider,
    point_offset: IntProvider,
    min_gen_offset: i32,
    max_gen_offset: i32,
    noise_multiplier: f64,
    invalid_threshold: i32,
    noise: NormalNoise,
    blocks: *TreeBlocks,
};
pub fn chance(object: *Object, name: *'static str, default: f64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: optional(object, name)
    // rust: .map(|raw| double_range(raw, name, 0.0, 1.0))
    // rust: .transpose()
    // rust: .map(|v| v.unwrap_or(default))
}
    // rust: impl GeodeFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:geode" {
    // rust: return Err(DecodeError::Field("geode type"));
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let settings: Object = serde_json::from_str(required(&object, "blocks")?.get())?;
    // rust: let placements: Vec<Box<serde_json::value::RawValue>> =
    // rust: serde_json::from_str(required(&settings, "inner_placements")?.get())?;
    // rust: if placements.is_empty() || placements.len() > 8192 {
    // rust: return Err(DecodeError::Field("geode inner placements"));
}
    // rust: let inner_placements = placements
    // rust: .iter()
    // rust: .map(|raw| {
    // rust: bindings
    // rust: .codec
    // rust: .decode(raw.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
    // rust: })
    // rust: .collect::<Result<_, _>>()?;
    // rust: let layers: Object = serde_json::from_str(required(&object, "layers")?.get())?;
    // rust: let layer = |name: &'static str, default: f64| {
    // rust: optional(&layers, name)
    // rust: .map(|raw| double_range(raw, name, 0.01, 50.0))
    // rust: .transpose()
    // rust: .map(|v| v.unwrap_or(default))
}
    // rust: let crack: Object = serde_json::from_str(required(&object, "crack")?.get())?;
    // rust: let mut provider =
    // rust: |name: &'static str, default: [i32; 2], low: i32, high: i32| match optional(
    // rust: &object, name,
    // rust: ) {
    // rust: Some(raw) => decoder.int_provider(raw, low, high),
    // rust: None => Ok(IntProvider::Uniform {
    // rust: min: default[0],
    // rust: max: default[1],
    // rust: }),
}
    // rust: let outer_wall_distance = provider("outer_wall_distance", [4, 5], 1, 20)?;
    // rust: let distribution_points = provider("distribution_points", [3, 4], 1, 20)?;
    // rust: let point_offset = provider("point_offset", [1, 2], 0, 10)?;
    // rust: let int_or = |name: &'static str, default: i32| {
    // rust: optional(&object, name)
    // rust: .map(super::integer)
    // rust: .transpose()
    // rust: .map(|v| v.unwrap_or(default))
}
    // rust: Ok(Self {
    // rust: filling: decoder.provider(required(&settings, "filling_provider")?)?,
    // rust: inner: decoder.provider(required(&settings, "inner_layer_provider")?)?,
    // rust: alternate_inner: decoder
    // rust: .provider(required(&settings, "alternate_inner_layer_provider")?)?,
    // rust: middle: decoder.provider(required(&settings, "middle_layer_provider")?)?,
    // rust: outer: decoder.provider(required(&settings, "outer_layer_provider")?)?,
    // rust: inner_placements,
    // rust: cannot_replace: decoder.block_set(required(&settings, "cannot_replace")?)?,
    // rust: invalid_blocks: decoder.block_set(required(&settings, "invalid_blocks")?)?,
    // rust: layers: [
    // rust: layer("filling", 1.7)?,
    // rust: layer("inner_layer", 2.2)?,
    // rust: layer("middle_layer", 3.2)?,
    // rust: layer("outer_layer", 4.2)?,
    // rust: ],
    // rust: crack_chance: chance(&crack, "generate_crack_chance", 1.0)?,
    // rust: base_crack_size: optional(&crack, "base_crack_size")
    // rust: .map(|raw| double_range(raw, "base_crack_size", 0.0, 5.0))
    // rust: .transpose()?
    // rust: .unwrap_or(2.0),
    // rust: crack_point_offset: optional(&crack, "crack_point_offset")
    // rust: .map(|raw| int_range(raw, "crack_point_offset", 0, 10))
    // rust: .transpose()?
    // rust: .unwrap_or(2),
    // rust: potential_chance: chance(&object, "use_potential_placements_chance", 0.35)?,
    // rust: alternate_chance: chance(&object, "use_alternate_layer0_chance", 0.0)?,
    // rust: require_alternate: optional(&object, "placements_require_layer0_alternate")
    // rust: .map(|raw| serde_json::from_str::<bool>(raw.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(true),
    // rust: outer_wall_distance,
    // rust: distribution_points,
    // rust: point_offset,
    // rust: min_gen_offset: int_or("min_gen_offset", -16)?,
    // rust: max_gen_offset: int_or("max_gen_offset", 16)?,
    // rust: noise_multiplier: chance(&object, "noise_multiplier", 0.05)?,
    // rust: invalid_threshold: super::integer(required(&object, "invalid_blocks_threshold")?)?,
    // rust: noise: NormalNoise::create_parity(-4, &[1.0])?,
    // rust: blocks,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let blocks = &*self.blocks;
    // rust: let cannot = |s: BlockStateId| self.cannot_replace.contains(&s);
    // rust: let num_points = self.distribution_points.sample(random)?;
    // rust: let seed = world.world_seed().map_err(query)?;
    // rust: let noise = self
    // rust: .noise
    // rust: .create(&mut LegacyRandom::new(seed))
    // rust: .map_err(|_| FeatureExecutionError::InvalidState)?;
    // rust: let crack_adjust = f64::from(num_points) / f64::from(self.outer_wall_distance.bounds()[1]);
    // rust: let [filling, inner, middle, outer] = self.layers;
    // rust: let inner_air = 1.0 / filling.sqrt();
    // rust: let innermost = 1.0 / (inner + crack_adjust).sqrt();
    // rust: let inner_crust = 1.0 / (middle + crack_adjust).sqrt();
    // rust: let outer_crust = 1.0 / (outer + crack_adjust).sqrt();
    // rust: let crack_size = 1.0
    // rust: / (self.base_crack_size
    // rust: + random.next_double() / 2.0
    // rust: + if num_points > 3 { crack_adjust } else { 0.0 })
    // rust: .sqrt();
    // rust: let crack = f64::from(random.next_float()) < self.crack_chance;
    // rust: let mut invalid = 0;
    // rust: let mut points = Vec::new();
    // rust: for _ in 0..num_points {
    // rust: let x = self.outer_wall_distance.sample(random)?;
    // rust: let y = self.outer_wall_distance.sample(random)?;
    // rust: let z = self.outer_wall_distance.sample(random)?;
    // rust: let p = tb::offset(origin, x, y, z);
    // rust: let state = read(world, p)?;
    // rust: if blocks.is_air(state) || self.invalid_blocks.contains(&state) {
    // rust: invalid += 1;
    // rust: if invalid > self.invalid_threshold {
    // rust: return Ok(false);
}
}
    // rust: points.push((p, self.point_offset.sample(random)?));
}
    // rust: let mut crack_points = Vec::new();
    // rust: if crack {
    // rust: let index = random.next_int_bound(4)?;
    // rust: let o = num_points * 2 + 1;
    // rust: let (cx, cz) = match index {
    // rust: 0 => (o, 0),
    // rust: 1 => (0, o),
    // rust: 2 => (o, o),
    // rust: _ => (0, 0),
}
    // rust: for y in [7, 5, 1] {
    // rust: crack_points.push(tb::offset(origin, cx, y, cz));
}
}
    // rust: let dist_sqr = |a: [i32; 3], b: [i32; 3]| -> f64 {
    // rust: (0..3)
    // rust: .map(|i| {
    // rust: let d = f64::from(a[i]) - f64::from(b[i]);
    // rust: d * d
    // rust: })
    // rust: .sum()
}
    // rust: let mut potential = Vec::new();
    // rust: let air_state = blocks
    // rust: .default_state("minecraft:air")
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
    // rust: let (lo, hi) = (self.min_gen_offset, self.max_gen_offset);
        // BlockPos.betweenClosed iterates x fastest, then y, then z.
    // rust: for dz in lo..=hi {
    // rust: for dy in lo..=hi {
    // rust: for dx in lo..=hi {
    // rust: let p = tb::offset(origin, dx, dy, dz);
    // rust: let noise_offset =
    // rust: f64::from(noise.get3(f64::from(p[0]), f64::from(p[1]), f64::from(p[2])))
    // rust: * self.noise_multiplier;
    // rust: let mut shell = 0.0;
    // rust: for (point, offset) in &points {
    // rust: shell +=
    // rust: 1.0 / (dist_sqr(p, *point) + f64::from(*offset)).sqrt() + noise_offset;
}
    // rust: if shell < outer_crust {
    // rust: continue;
}
    // rust: if shell >= inner_air {
    // rust: let value = sample_state(&self.filling, world, random, p)?;
    // rust: safe_set(world, p, value, cannot)?;
    // rust: continue;
}
    // rust: let mut crack_sum = 0.0;
    // rust: for point in &crack_points {
    // rust: crack_sum += 1.0
    // rust: / (dist_sqr(p, *point) + f64::from(self.crack_point_offset)).sqrt()
    // rust: + noise_offset;
}
    // rust: if crack && crack_sum >= crack_size {
    // rust: safe_set(world, p, air_state, cannot)?;
    // rust: for direction in Direction::ALL {
    // rust: let q = tb::relative(p, direction, 1);
    // rust: let fluid = world.fluid_state(q).map_err(query)?;
    // rust: if fluid.kind() != crate::fluid::FluidKind::Empty {
    // rust: world
    // rust: .schedule_fluid_tick(q, fluid.kind(), 0)
    // rust: .map_err(query)?;
}
}
    // rust: } else if shell >= innermost {
    // rust: let alternate = f64::from(random.next_float()) < self.alternate_chance;
    // rust: let provider = if alternate {
    // rust: &self.alternate_inner
    // rust: } else {
    // rust: &self.inner
}
    // rust: let value = sample_state(provider, world, random, p)?;
    // rust: safe_set(world, p, value, cannot)?;
    // rust: if (!self.require_alternate || alternate)
    // rust: && f64::from(random.next_float()) < self.potential_chance
    // rust: {
    // rust: potential.push(p);
}
    // rust: } else if shell >= inner_crust {
    // rust: let value = sample_state(&self.middle, world, random, p)?;
    // rust: safe_set(world, p, value, cannot)?;
    // rust: } else if shell >= outer_crust {
    // rust: let value = sample_state(&self.outer, world, random, p)?;
    // rust: safe_set(world, p, value, cannot)?;
}
}
}
}
    // rust: for crystal in potential {
    // rust: let index = random.next_int_bound(self.inner_placements.len() as i32)? as usize;
    // rust: let mut state = self.inner_placements[index];
    // rust: for direction in Direction::ALL {
    // rust: if blocks
    // rust: .properties
    // rust: .values(state, "facing")
    // rust: .is_some_and(|v| v.len() == 6)
    // rust: {
    // rust: state = blocks
    // rust: .with(state, "facing", tb::direction_name(direction))
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
}
    // rust: let target = tb::relative(crystal, direction, 1);
    // rust: let existing = read(world, target)?;
    // rust: if blocks.has(state, tb::WATERLOGGABLE) {
    // rust: state = blocks.waterlogged(state, blocks.has(existing, tb::FLUID_SOURCE));
}
                // BuddingAmethystBlock.canClusterGrowAtState.
    // rust: if blocks.is_air(existing)
    // rust: || (blocks.has(existing, tb::WATER_BLOCK)
    // rust: && blocks.has(existing, tb::FLUID_FULL))
    // rust: {
    // rust: safe_set(world, target, state, cannot)?;
    // rust: break;
}
}
}
    // rust: Ok(true)
}
}
