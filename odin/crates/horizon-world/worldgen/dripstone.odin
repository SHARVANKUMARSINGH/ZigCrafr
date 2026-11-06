//! Transpiled from Horizon Rust crate
package horizon_world_dripstone

import "core:fmt"
import "core:mem"
import "core:math"

// `minecraft:speleothem_cluster` and `minecraft:large_dripstone`
// (SpeleothemClusterFeature, LargeDripstoneFeature and SpeleothemUtils).
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::FeatureExecutionError,
    // rust: int_range, number_text, optional,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: tree::{TreeDecoder, TreeResult, kind, read, scan_column, unit_float, write},
    // rust: tree_blocks::{self as tb, TreeBlocks},
    // rust: value_provider::{FloatProvider, IntProvider},
}
// use crate::{heightmap::HeightmapType, registry::BlockStateId};
// use horizon_core::{geometry::trig, random::RandomSource};
// use std::{collections::BTreeSet, sync::Arc};

    // rust: fn query<E>(error: PlacementQueryError) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Query(error)
}
// Column.scan result: optional floor and ceiling edge heights.
Column :: struct {
    floor: Maybe(i32),
    ceiling: Maybe(i32),
}
    // rust: impl Column {
height :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match (self.floor, self.ceiling) {
    // rust: (Some(floor), Some(ceiling)) => Some(ceiling - floor - 1),
    // rust: _ => None,
}
}
}

// Shared speleothem block classification.
Speleothem :: struct {
    base: BlockStateId,
    pointed: BlockStateId,
    replaceable: ^BTreeSet<BlockStateId>,
    lava: BlockStateId,
    blocks: ^TreeBlocks,
}
    // rust: impl Speleothem {
    // rust: fn new(
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: base: BlockStateId,
    // rust: pointed: BlockStateId,
    // rust: replaceable: Arc<BTreeSet<BlockStateId>>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let registry = bindings.registry();
    // rust: let default = |state: BlockStateId| {
    // rust: registry
    // rust: .default_state(&registry.state(state).unwrap().name)
    // rust: .ok_or(DecodeError::Field("speleothem block"))
}
    // rust: Ok(Self {
    // rust: base: default(base)?,
    // rust: pointed: default(pointed)?,
    // rust: replaceable,
    // rust: lava: registry
    // rust: .default_state("minecraft:lava")
    // rust: .ok_or(DecodeError::Field("lava"))?,
    // rust: blocks: bindings.tree_blocks()?,
    // rust: })
}
empty_or_water :: proc(self: ^Self, s: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.is_air(s) || self.blocks.has(s, tb::WATER_BLOCK)
}
empty_water_or_lava :: proc(self: ^Self, s: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.empty_or_water(s) || self.blocks.same_block(s, self.lava)
}
is_base :: proc(self: ^Self, s: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.same_block(s, self.base) || self.replaceable.contains(&s)
}
    // rust: fn scan<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: pos: [i32; 3],
    // rust: range: i32,
    // rust: edge: impl Fn(&Self, BlockStateId) -> bool,
    // rust: ) -> TreeResult<Option<Column>, W::Error> {
    // rust: if !self.empty_or_water(read(world, pos)?) {
    // rust: return Ok(None);
}
        // Column.scan: up to range - 1 empty blocks from pos, then the edge.
    // rust: let mut scan = |step: i32| -> TreeResult<Option<i32>, W::Error> {
    // rust: let y = scan_column(world, pos, step, range - 1, |s| self.empty_or_water(s))?;
    // rust: let p = [pos[0], y, pos[2]];
    // rust: Ok(edge(self, read(world, p)?).then_some(y))
}
    // rust: let ceiling = scan(1)?;
    // rust: let floor = scan(-1)?;
    // rust: Ok(Some(Column { floor, ceiling }))
}
pointed_state :: proc(self: ^Self, up: bool, thickness: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.blocks.with(
    // rust: self.pointed,
    // rust: "vertical_direction",
    // rust: if up { "up" } else { "down" },
    // rust: )?;
    // rust: self.blocks.with(state, "thickness", thickness)
}
    // SpeleothemUtils.growSpeleothem.
    // rust: fn grow<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: start: [i32; 3],
    // rust: up: bool,
    // rust: height: i32,
    // rust: merged: bool,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let step = if up { 1 } else { -1 };
    // rust: if !self.is_base(read(world, tb::offset(start, 0, -step, 0))?) {
    // rust: return Ok(());
}
    // rust: let mut sequence = Vec::new();
    // rust: if height >= 3 {
    // rust: sequence.push("base");
    // rust: sequence.extend(std::iter::repeat_n("middle", (height - 3) as usize));
}
    // rust: if height >= 2 {
    // rust: sequence.push("frustum");
}
    // rust: if height >= 1 {
    // rust: sequence.push(if merged { "tip_merge" } else { "tip" });
}
    // rust: let mut p = start;
    // rust: for thickness in sequence {
    // rust: let mut state = self
    // rust: .pointed_state(up, thickness)
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
    // rust: let water = self.blocks.has(read(world, p)?, tb::WATER_FLUID);
    // rust: state = self.blocks.waterlogged(state, water);
    // rust: write(world, p, state, 2)?;
    // rust: p[1] = p[1].wrapping_add(step);
}
    // rust: Ok(())
}
    // rust: fn place_base_if_possible<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if self.replaceable.contains(&read(world, p)?) {
    // rust: write(world, p, self.base, 2)?;
    // rust: return Ok(true);
}
    // rust: Ok(false)
}
}

    // rust: fn float_provider(
    // rust: raw: &serde_json::value::RawValue,
    // rust: low: f32,
    // rust: high: f32,
    // rust: ) -> Result<FloatProvider, DecodeError> {
    // rust: let value = FloatProvider::from_json(raw.get())?;
    // rust: let [min, max] = value.bounds();
    // rust: if min < low || max > high {
    // rust: return Err(DecodeError::Field("float provider bounds"));
}
    // rust: Ok(value)
}
    // rust: fn float_range(
    // rust: raw: &serde_json::value::RawValue,
    // rust: name: &'static str,
    // rust: low: f32,
    // rust: high: f32,
    // rust: ) -> Result<f32, DecodeError> {
    // rust: let value: f32 = number_text(raw)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field(name))?;
    // rust: if !(low..=high).contains(&value) {
    // rust: return Err(DecodeError::Field(name));
}
    // rust: Ok(value)
}
    // rust: fn block_state(
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: raw: &serde_json::value::RawValue,
    // rust: ) -> Result<BlockStateId, DecodeError> {
    // rust: bindings
    // rust: .codec
    // rust: .decode(raw.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
}
clamped_lerp :: proc(factor: f64, min: f64, max: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if factor < 0.0 {
    // rust: min
    // rust: } else if factor > 1.0 {
    // rust: max
    // rust: } else {
    // rust: min + factor * (max - min)
}
}
clamped_lerp_f32 :: proc(factor: f32, min: f32, max: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if factor < 0.0 {
    // rust: min
    // rust: } else if factor > 1.0 {
    // rust: max
    // rust: } else {
    // rust: min + factor * (max - min)
}
}

SpeleothemClusterFeature :: struct {
    speleothem: Speleothem,
    search_range: i32,
    height: IntProvider,
    radius: IntProvider,
    max_height_diff: i32,
    height_deviation: i32,
    layer_thickness: IntProvider,
    density: FloatProvider,
    wetness: FloatProvider,
    chance_at_max_distance: f32,
    max_distance_from_edge: i32,
    max_distance_from_center: i32,
}
    // rust: impl SpeleothemClusterFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:speleothem_cluster" {
    // rust: return Err(DecodeError::Field("speleothem cluster type"));
}
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let int = |name: &'static str, low: i32, high: i32| {
    // rust: int_range(required(&object, name)?, name, low, high)
}
    // rust: Ok(Self {
    // rust: speleothem: Speleothem::new(
    // rust: bindings,
    // rust: block_state(bindings, required(&object, "base_block")?)?,
    // rust: block_state(bindings, required(&object, "pointed_block")?)?,
    // rust: decoder.block_set(required(&object, "replaceable_blocks")?)?,
    // rust: )?,
    // rust: search_range: int("floor_to_ceiling_search_range", 1, 512)?,
    // rust: height: decoder.int_provider(required(&object, "height")?, 1, 128)?,
    // rust: radius: decoder.int_provider(required(&object, "radius")?, 1, 128)?,
    // rust: max_height_diff: int("max_stalagmite_stalactite_height_diff", 0, 64)?,
    // rust: height_deviation: int("height_deviation", 1, 64)?,
    // rust: layer_thickness: decoder.int_provider(
    // rust: required(&object, "speleothem_block_layer_thickness")?,
    // rust: 0,
    // rust: 128,
    // rust: )?,
    // rust: density: float_provider(required(&object, "density")?, 0.0, 2.0)?,
    // rust: wetness: float_provider(required(&object, "wetness")?, 0.0, 2.0)?,
    // rust: chance_at_max_distance: unit_float(
    // rust: required(&object, "chance_of_speleothem_at_max_distance_from_center")?,
    // rust: "chance_of_speleothem_at_max_distance_from_center",
    // rust: )?,
    // rust: max_distance_from_edge: int(
    // rust: "max_distance_from_edge_affecting_chance_of_speleothem",
    // rust: 1,
    // rust: 64,
    // rust: )?,
    // rust: max_distance_from_center: int("max_distance_from_center_affecting_height_bias", 1, 64)?,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if !self.speleothem.empty_or_water(read(world, origin)?) {
    // rust: return Ok(false);
}
    // rust: let height = self.height.sample(random)?;
    // rust: let wetness = self.wetness.sample(random);
    // rust: let density = self.density.sample(random);
    // rust: let x_radius = self.radius.sample(random)?;
    // rust: let z_radius = self.radius.sample(random)?;
    // rust: for dx in -x_radius..=x_radius {
    // rust: for dz in -z_radius..=z_radius {
    // rust: let distance = (x_radius - dx.abs()).min(z_radius - dz.abs());
    // rust: let chance = f64::from(clamped_lerp_f32(
    // rust: (distance as f32 - 0.0) / (self.max_distance_from_edge as f32 - 0.0),
    // rust: self.chance_at_max_distance,
    // rust: 1.0,
    // rust: ));
    // rust: let p = tb::offset(origin, dx, 0, dz);
    // rust: self.column(world, random, p, dx, dz, wetness, chance, height, density)?;
}
}
    // rust: Ok(true)
}
    // rust: fn column<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: dx: i32,
    // rust: dz: i32,
    // rust: chance_of_water: f32,
    // rust: chance: f64,
    // rust: cluster_height: i32,
    // rust: density: f32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let s = &self.speleothem;
    // rust: let Some(base_column) =
    // rust: s.scan(world, pos, self.search_range, |s, st| !s.empty_or_water(st))?
    // rust: else {
    // rust: return Ok(());
}
    // rust: let ceiling = base_column.ceiling;
    // rust: let base_floor = base_column.floor;
    // rust: if ceiling.is_none() && base_floor.is_none() {
    // rust: return Ok(());
}
    // rust: let want_pool = random.next_float() < chance_of_water;
    // rust: let column = match base_floor {
    // rust: Some(floor_y)
    // rust: if want_pool && self.can_place_pool(world, [pos[0], floor_y, pos[2]])? =>
    // rust: {
    // rust: let water = s
    // rust: .blocks
    // rust: .default_state("minecraft:water")
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
    // rust: write(world, [pos[0], floor_y, pos[2]], water, 2)?;
    // rust: Column {
    // rust: floor: Some(floor_y - 1),
    // rust: ceiling,
}
}
    // rust: _ => base_column,
}
    // rust: let floor = column.floor;
    // rust: let want_stalactite = random.next_double() < chance;
    // rust: let stalactite_height = match ceiling {
    // rust: Some(c)
    // rust: if want_stalactite
    // rust: && !s
    // rust: .blocks
    // rust: .same_block(read(world, [pos[0], c, pos[2]])?, s.lava) =>
    // rust: {
    // rust: let thickness = self.layer_thickness.sample(random)?;
    // rust: self.replace_with_base(world, [pos[0], c, pos[2]], thickness, 1)?;
    // rust: let max = match floor {
    // rust: Some(f) => cluster_height.min(c - f),
    // rust: None => cluster_height,
}
    // rust: self.speleothem_height(random, dx, dz, density, max)?
}
    // rust: _ => 0,
}
    // rust: let want_stalagmite = random.next_double() < chance;
    // rust: let stalagmite_height = match floor {
    // rust: Some(f)
    // rust: if want_stalagmite
    // rust: && !s
    // rust: .blocks
    // rust: .same_block(read(world, [pos[0], f, pos[2]])?, s.lava) =>
    // rust: {
    // rust: let thickness = self.layer_thickness.sample(random)?;
    // rust: self.replace_with_base(world, [pos[0], f, pos[2]], thickness, -1)?;
    // rust: if ceiling.is_some() {
    // rust: let diff = self.max_height_diff;
    // rust: 0.max(stalactite_height + random.next_int_bound(diff * 2 + 1)? - diff)
    // rust: } else {
    // rust: self.speleothem_height(random, dx, dz, density, cluster_height)?
}
}
    // rust: _ => 0,
}
    // rust: let (actual_stalactite, actual_stalagmite) = match (ceiling, floor) {
    // rust: (Some(c), Some(f)) if c - stalactite_height <= f + stalagmite_height => {
    // rust: let lowest_bottom = (c - stalactite_height).max(f + 1);
    // rust: let highest_top = (f + stalagmite_height).min(c - 1);
    // rust: let bottom =
    // rust: random.next_int_bound(highest_top + 1 - lowest_bottom + 1)? + lowest_bottom;
    // rust: (c - bottom, bottom - 1 - f)
}
    // rust: _ => (stalactite_height, stalagmite_height),
}
    // rust: let merge = random.next_boolean()
    // rust: && actual_stalactite > 0
    // rust: && actual_stalagmite > 0
    // rust: && column
    // rust: .height()
    // rust: .is_some_and(|h| actual_stalactite + actual_stalagmite == h);
    // rust: if let Some(c) = ceiling {
    // rust: s.grow(
    // rust: world,
    // rust: [pos[0], c - 1, pos[2]],
    // rust: false,
    // rust: actual_stalactite,
    // rust: merge,
    // rust: )?;
}
    // rust: if let Some(f) = floor {
    // rust: s.grow(
    // rust: world,
    // rust: [pos[0], f + 1, pos[2]],
    // rust: true,
    // rust: actual_stalagmite,
    // rust: merge,
    // rust: )?;
}
    // rust: Ok(())
}
    // rust: fn speleothem_height<E>(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: dx: i32,
    // rust: dz: i32,
    // rust: density: f32,
    // rust: max_height: i32,
    // rust: ) -> TreeResult<i32, E> {
    // rust: if random.next_float() > density {
    // rust: return Ok(0);
}
    // rust: let distance = dx.abs() + dz.abs();
    // rust: let mean = clamped_lerp(
    // rust: (f64::from(distance) - 0.0) / (f64::from(self.max_distance_from_center) - 0.0),
    // rust: f64::from(max_height) / 2.0,
    // rust: 0.0,
    // rust: ) as f32;
    // rust: let value = mean + random.next_gaussian() as f32 * self.height_deviation as f32;
    // rust: let clamped = if value < 0.0 {
    // rust: 0.0
    // rust: } else {
    // rust: value.min(max_height as f32)
}
    // rust: Ok(clamped as i32)
}
    // rust: fn can_place_pool<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let s = &self.speleothem;
    // rust: let state = read(world, p)?;
    // rust: if s.blocks.has(state, tb::WATER_BLOCK)
    // rust: || s.blocks.same_block(state, s.base)
    // rust: || s.blocks.same_block(state, s.pointed)
    // rust: {
    // rust: return Ok(false);
}
    // rust: if s.blocks
    // rust: .has(read(world, tb::offset(p, 0, 1, 0))?, tb::WATER_FLUID)
    // rust: {
    // rust: return Ok(false);
}
    // rust: for direction in tb::HORIZONTAL {
    // rust: if !self.adjacent_ok(world, tb::relative(p, direction, 1))? {
    // rust: return Ok(false);
}
}
    // rust: self.adjacent_ok(world, tb::offset(p, 0, -1, 0))
}
    // rust: fn adjacent_ok<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let state = read(world, p)?;
    // rust: let b = &self.speleothem.blocks;
    // rust: Ok(b.has(state, tb::BASE_STONE_OVERWORLD) || b.has(state, tb::WATER_FLUID))
}
    // rust: fn replace_with_base<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: first: [i32; 3],
    // rust: count: i32,
    // rust: step: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let mut p = first;
    // rust: for _ in 0..count {
    // rust: if !self.speleothem.place_base_if_possible(world, p)? {
    // rust: return Ok(());
}
    // rust: p[1] = p[1].wrapping_add(step);
}
    // rust: Ok(())
}
}

LargeDripstoneFeature :: struct {
    speleothem: Speleothem,
    search_range: i32,
    column_radius: IntProvider,
    height_scale: FloatProvider,
    max_radius_ratio: f32,
    stalactite_bluntness: FloatProvider,
    stalagmite_bluntness: FloatProvider,
    wind_speed: FloatProvider,
    min_radius_for_wind: i32,
    min_bluntness_for_wind: f32,
}
LargeDripstone :: struct {
    root: [i32,
    up: bool,
    radius: i32,
    bluntness: f64,
    scale: f64,
}
Wind :: struct {
    origin_y: i32,
    speed: Option<[f64,
    max_offset: i32,
}
    // rust: impl Wind {
offset :: proc(self: ^Self, p: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let Some(speed) = self.speed else {
    // rust: return p;
}
    // rust: let dy = f64::from(self.origin_y.wrapping_sub(p[1]));
    // rust: let clamp = |v: f64| {
    // rust: let v = v.floor() as i32;
    // rust: if v < -self.max_offset {
    // rust: -self.max_offset
    // rust: } else {
    // rust: v.min(self.max_offset)
}
}
    // rust: tb::offset(p, clamp(speed[0] * dy), 0, clamp(speed[2] * dy))
}
}
speleothem_height :: proc(distance: f64, radius: f64, scale: f64, bluntness: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let distance = if distance < bluntness {
    // rust: bluntness
    // rust: } else {
    // rust: distance
}
    // rust: let r = distance / radius * 0.384;
    // rust: let part1 = 0.75 * horizon_core::jmath::pow(r, 1.3333333333333333);
    // rust: let part2 = horizon_core::jmath::pow(r, 0.6666666666666666);
    // rust: let part3 = 0.3333333333333333 * horizon_core::jmath::log(r);
    // rust: let height = (scale * (part1 - part2 - part3)).max(0.0);
    // rust: height / 0.384 * radius
}
    // rust: impl LargeDripstone {
height_at :: proc(self: ^Self, radius: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: speleothem_height(
    // rust: f64::from(radius),
    // rust: f64::from(self.radius),
    // rust: self.scale,
    // rust: self.bluntness,
    // rust: ) as i32
}
}
    // rust: impl LargeDripstoneFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:large_dripstone" {
    // rust: return Err(DecodeError::Field("large dripstone type"));
}
    // rust: let registry = bindings.registry();
    // rust: let dripstone = registry
    // rust: .default_state("minecraft:dripstone_block")
    // rust: .ok_or(DecodeError::Field("dripstone block"))?;
    // rust: let pointed = registry
    // rust: .default_state("minecraft:pointed_dripstone")
    // rust: .ok_or(DecodeError::Field("pointed dripstone"))?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: Ok(Self {
    // rust: speleothem: Speleothem::new(
    // rust: bindings,
    // rust: dripstone,
    // rust: pointed,
    // rust: decoder.block_set(required(&object, "replaceable_blocks")?)?,
    // rust: )?,
    // rust: search_range: optional(&object, "floor_to_ceiling_search_range")
    // rust: .map(|raw| int_range(raw, "floor_to_ceiling_search_range", 1, 512))
    // rust: .transpose()?
    // rust: .unwrap_or(30),
    // rust: column_radius: decoder.int_provider(required(&object, "column_radius")?, 1, 16)?,
    // rust: height_scale: float_provider(required(&object, "height_scale")?, 0.0, 20.0)?,
    // rust: max_radius_ratio: float_range(
    // rust: required(&object, "max_column_radius_to_cave_height_ratio")?,
    // rust: "max_column_radius_to_cave_height_ratio",
    // rust: 0.1,
    // rust: 1.0,
    // rust: )?,
    // rust: stalactite_bluntness: float_provider(
    // rust: required(&object, "stalactite_bluntness")?,
    // rust: 0.1,
    // rust: 10.0,
    // rust: )?,
    // rust: stalagmite_bluntness: float_provider(
    // rust: required(&object, "stalagmite_bluntness")?,
    // rust: 0.1,
    // rust: 10.0,
    // rust: )?,
    // rust: wind_speed: float_provider(required(&object, "wind_speed")?, 0.0, 2.0)?,
    // rust: min_radius_for_wind: int_range(
    // rust: required(&object, "min_radius_for_wind")?,
    // rust: "min_radius_for_wind",
    // rust: 0,
    // rust: 100,
    // rust: )?,
    // rust: min_bluntness_for_wind: float_range(
    // rust: required(&object, "min_bluntness_for_wind")?,
    // rust: "min_bluntness_for_wind",
    // rust: 0.0,
    // rust: 5.0,
    // rust: )?,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let s = &self.speleothem;
    // rust: if !s.empty_or_water(read(world, origin)?) {
    // rust: return Ok(false);
}
    // rust: let Some(column) = s.scan(world, origin, self.search_range, |s, st| {
    // rust: s.is_base(st) || s.blocks.same_block(st, s.lava)
    // rust: })?
    // rust: else {
    // rust: return Ok(false);
}
    // rust: let (Some(floor), Some(ceiling)) = (column.floor, column.ceiling) else {
    // rust: return Ok(false);
}
    // rust: let height = ceiling - floor - 1;
    // rust: if height < 4 {
    // rust: return Ok(false);
}
    // rust: let by_height = (height as f32 * self.max_radius_ratio) as i32;
    // rust: let [min_r, max_r] = self.column_radius.bounds();
    // rust: let max_radius = if by_height < min_r {
    // rust: min_r
    // rust: } else {
    // rust: by_height.min(max_r)
}
    // rust: let radius = random.next_int_bound(max_radius - min_r + 1)? + min_r;
    // rust: let mut stalactite = LargeDripstone {
    // rust: root: [origin[0], ceiling - 1, origin[2]],
    // rust: up: false,
    // rust: radius,
    // rust: bluntness: f64::from(self.stalactite_bluntness.sample(random)),
    // rust: scale: f64::from(self.height_scale.sample(random)),
}
    // rust: let mut stalagmite = LargeDripstone {
    // rust: root: [origin[0], floor + 1, origin[2]],
    // rust: up: true,
    // rust: radius,
    // rust: bluntness: f64::from(self.stalagmite_bluntness.sample(random)),
    // rust: scale: f64::from(self.height_scale.sample(random)),
}
    // rust: let suitable = |d: &LargeDripstone| {
    // rust: d.radius >= self.min_radius_for_wind
    // rust: && d.bluntness >= f64::from(self.min_bluntness_for_wind)
}
    // rust: let wind = if suitable(&stalactite) && suitable(&stalagmite) {
    // rust: let speed = self.wind_speed.sample(random);
    // rust: let direction = random.next_float() * (std::f32::consts::PI - 0.0) + 0.0;
    // rust: Wind {
    // rust: origin_y: origin[1],
    // rust: speed: Some([
    // rust: f64::from(trig::cos(f64::from(direction)) * speed),
    // rust: 0.0,
    // rust: f64::from(trig::sin(f64::from(direction)) * speed),
    // rust: ]),
    // rust: max_offset: 16 - radius,
}
    // rust: } else {
    // rust: Wind {
    // rust: origin_y: 0,
    // rust: speed: None,
    // rust: max_offset: 0,
}
}
    // rust: let top = self.move_back(world, &mut stalactite, wind)?;
    // rust: let bottom = self.move_back(world, &mut stalagmite, wind)?;
    // rust: if top {
    // rust: self.place_blocks(world, random, &stalactite, wind)?;
}
    // rust: if bottom {
    // rust: self.place_blocks(world, random, &stalagmite, wind)?;
}
    // rust: Ok(true)
}
    // rust: fn move_back<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: d: &mut LargeDripstone,
    // rust: wind: Wind,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let s = &self.speleothem;
    // rust: while d.radius > 1 {
    // rust: let mut root = d.root;
    // rust: let tries = 10.min(d.height_at(0.0));
    // rust: for _ in 0..tries {
    // rust: if s.blocks.same_block(read(world, root)?, s.lava) {
    // rust: return Ok(false);
}
    // rust: if self.circle_embedded(world, wind.offset(root), d.radius)? {
    // rust: d.root = root;
    // rust: return Ok(true);
}
    // rust: root[1] = root[1].wrapping_add(if d.up { -1 } else { 1 });
}
    // rust: d.radius /= 2;
}
    // rust: Ok(false)
}
    // rust: fn circle_embedded<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: center: [i32; 3],
    // rust: radius: i32,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let s = &self.speleothem;
    // rust: if s.empty_water_or_lava(read(world, center)?) {
    // rust: return Ok(false);
}
    // rust: let increment = 6.0f32 / radius as f32;
    // rust: let mut angle = 0.0f32;
    // rust: while angle < (std::f64::consts::PI * 2.0) as f32 {
    // rust: let dx = (trig::cos(f64::from(angle)) * radius as f32) as i32;
    // rust: let dz = (trig::sin(f64::from(angle)) * radius as f32) as i32;
    // rust: if s.empty_water_or_lava(read(world, tb::offset(center, dx, 0, dz))?) {
    // rust: return Ok(false);
}
    // rust: angle += increment;
}
    // rust: Ok(true)
}
    // rust: fn place_blocks<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: d: &LargeDripstone,
    // rust: wind: Wind,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let s = &self.speleothem;
    // rust: for dx in -d.radius..=d.radius {
    // rust: for dz in -d.radius..=d.radius {
    // rust: let current = ((dx * dx + dz * dz) as f32).sqrt();
    // rust: if current > d.radius as f32 {
    // rust: continue;
}
    // rust: let mut height = d.height_at(current);
    // rust: if height <= 0 {
    // rust: continue;
}
    // rust: if f64::from(random.next_float()) < 0.2 {
    // rust: let factor = random.next_float() * (1.0f32 - 0.8f32) + 0.8f32;
    // rust: height = (height as f32 * factor) as i32;
}
    // rust: let mut pos = tb::offset(d.root, dx, 0, dz);
    // rust: let mut out_of_stone = false;
    // rust: let max_y = if d.up {
    // rust: world
    // rust: .height(HeightmapType::WorldSurfaceWg, pos[0], pos[2])
    // rust: .map_err(query)?
    // rust: } else {
    // rust: i32::MAX
}
    // rust: let mut i = 0;
    // rust: while i < height && pos[1] < max_y {
    // rust: let adjusted = wind.offset(pos);
    // rust: let state = read(world, adjusted)?;
    // rust: if s.empty_water_or_lava(state) {
    // rust: out_of_stone = true;
    // rust: write(world, adjusted, s.base, 2)?;
    // rust: } else if out_of_stone && s.blocks.has(state, tb::BASE_STONE_OVERWORLD) {
    // rust: break;
}
    // rust: pos[1] = pos[1].wrapping_add(if d.up { 1 } else { -1 });
    // rust: i += 1;
}
}
}
    // rust: Ok(())
}
}
