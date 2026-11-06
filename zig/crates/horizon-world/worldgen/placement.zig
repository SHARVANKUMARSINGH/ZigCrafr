//! Transpiled from Horizon Rust crate
//! Module: horizon-world_placement
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Placement modifiers that depend on random state and generation bounds.
//! Block-query modifiers and actual configured features remain separate work.
    // rust: mod chain;
    // rust: mod layer;
// use super::block_predicate::{BlockPredicate, PredicateBlockResolver};
// use super::{
    // rust: DecodeError, Object, anchor::WorldGenerationContext, biome_temperature::biome_info_noise,
    // rust: density::identifier, double, height_provider::HeightProvider, int_range, integer, number_text,
    // rust: optional, required, value_provider::IntProvider,
}
// use crate::heightmap::HeightmapType;
    // rust: pub use chain::{FeaturePlacementError, FeaturePlacer};
// use horizon_core::random::{InvalidBound, RandomSource};
// use serde_json::value::RawValue;
    // rust: mod context;
    // rust: pub use context::{LayerBlock, PlacementContext, PlacementQueryError};

pub const PlacementModifier = enum {
    Biome,
    BlockPredicate(BlockPredicate),
    EnvironmentScan {,
    upwards: bool,
    target: BlockPredicate,
    allowed: BlockPredicate,
    max_steps: i32,
    // rust: },
    Heightmap(HeightmapType),
    SurfaceRelative {,
    heightmap: HeightmapType,
    min: i32,
    max: i32,
    // rust: },
    SurfaceWaterDepth(i32),
    Count(IntProvider),
    CountOnEveryLayer(IntProvider),
    NoiseBasedCount {,
    ratio: i32,
    factor: f64,
    offset: f64,
    // rust: },
    NoiseThresholdCount {,
    level: f64,
    below: i32,
    above: i32,
    // rust: },
    InSquare,
    Cuboid {,
    xz_size: IntProvider,
    y_size: IntProvider,
    include_edges: bool,
    include_interior: bool,
    // rust: },
    Offset([IntProvider; 3]),
    HeightRange(HeightProvider),
    Rarity(i32),
    RandomChance(f32),
    Fixed(Vec<[i32; 3]>),
    RandomlySelected(Vec<Self>),
};
pub const PlacementError = enum {
    Random(InvalidBound),
    World(PlacementQueryError),
    Output(E),
    WorkLimit,
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for PlacementError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Random(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Output(e) => e.fmt(f),
    // rust: Self::WorkLimit => f.write_str("placement work limit exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for PlacementError<E> {}
    // rust: impl<E> From<InvalidBound> for PlacementError<E> {
pub fn from(value: InvalidBound) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::Random(value)
}
}
    // rust: impl<E> From<PlacementQueryError> for PlacementError<E> {
pub fn from(value: PlacementQueryError) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::World(value)
}
}
    // rust: impl PlacementModifier {
pub fn from_json(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::decode(json, 0, &mut 65536)
}
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::decode_with_blocks(json, depth, remaining, None)
}
    // rust: pub fn from_json_with_blocks(
    // rust: json: &str,
    // rust: blocks: &impl PredicateBlockResolver,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Self::decode_with_blocks(json, 0, &mut 65536, Some(blocks))
}
    // rust: pub(crate) fn decode_with_blocks(
    // rust: json: &str,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: blocks: Option<&dyn PredicateBlockResolver>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth > 256 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("placement depth or node count"));
}
    // rust: *remaining -= 1;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: let provider = |name, min, max| {
    // rust: let value = IntProvider::from_json(required(&object, name)?.get())?;
    // rust: let bounds = value.bounds();
    // rust: if bounds[0] < min || bounds[1] > max {
    // rust: return Err(DecodeError::Field("placement provider bounds"));
}
    // rust: Ok(value)
}
    // rust: let heightmap = || {
    // rust: let name: String = serde_json::from_str(required(&object, "heightmap")?.get())?;
    // rust: HeightmapType::ALL
    // rust: .into_iter()
    // rust: .find(|kind| kind.name() == name)
    // rust: .ok_or(DecodeError::Field("heightmap"))
}
    // rust: match kind.as_str() {
    // rust: "minecraft:biome" => Ok(Self::Biome),
    // rust: "minecraft:block_predicate_filter" => {
    // rust: Ok(Self::BlockPredicate(BlockPredicate::decode_with_blocks(
    // rust: required(&object, "predicate")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: blocks,
    // rust: )?))
}
    // rust: "minecraft:environment_scan" => {
    // rust: let direction: String =
    // rust: serde_json::from_str(required(&object, "direction_of_search")?.get())?;
    // rust: let upwards = match direction.as_str() {
    // rust: "up" => true,
    // rust: "down" => false,
    // rust: _ => return Err(DecodeError::Field("scan direction")),
}
    // rust: Ok(Self::EnvironmentScan {
    // rust: upwards,
    // rust: target: BlockPredicate::decode_with_blocks(
    // rust: required(&object, "target_condition")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: blocks,
    // rust: )?,
    // rust: allowed: optional(&object, "allowed_search_condition")
    // rust: .map(|v| {
    // rust: BlockPredicate::decode_with_blocks(
    // rust: v.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: blocks,
    // rust: )
    // rust: })
    // rust: .transpose()?
    // rust: .unwrap_or(BlockPredicate::True),
    // rust: max_steps: int_range(required(&object, "max_steps")?, "scan steps", 1, 32)?,
    // rust: })
}
    // rust: "minecraft:heightmap" => Ok(Self::Heightmap(heightmap()?)),
    // rust: "minecraft:surface_relative_threshold_filter" => Ok(Self::SurfaceRelative {
    // rust: heightmap: heightmap()?,
    // rust: min: optional(&object, "min_inclusive")
    // rust: .map(integer)
    // rust: .transpose()?
    // rust: .unwrap_or(i32::MIN),
    // rust: max: optional(&object, "max_inclusive")
    // rust: .map(integer)
    // rust: .transpose()?
    // rust: .unwrap_or(i32::MAX),
    // rust: }),
    // rust: "minecraft:surface_water_depth_filter" => Ok(Self::SurfaceWaterDepth(integer(
    // rust: required(&object, "max_water_depth")?,
    // rust: )?)),
    // rust: "minecraft:noise_based_count" => Ok(Self::NoiseBasedCount {
    // rust: ratio: integer(required(&object, "noise_to_count_ratio")?)?,
    // rust: factor: double(required(&object, "noise_factor")?)?,
    // rust: offset: optional(&object, "noise_offset")
    // rust: .map(double)
    // rust: .transpose()?
    // rust: .unwrap_or(0.),
    // rust: }),
    // rust: "minecraft:noise_threshold_count" => Ok(Self::NoiseThresholdCount {
    // rust: level: double(required(&object, "noise_level")?)?,
    // rust: below: integer(required(&object, "below_noise")?)?,
    // rust: above: integer(required(&object, "above_noise")?)?,
    // rust: }),
    // rust: "minecraft:count_on_every_layer" => {
    // rust: Ok(Self::CountOnEveryLayer(provider("count", 0, 256)?))
}
    // rust: "minecraft:count" => Ok(Self::Count(provider("count", 0, 4096)?)),
    // rust: "minecraft:in_square" => Ok(Self::InSquare),
    // rust: "minecraft:cuboid" => Ok(Self::Cuboid {
    // rust: xz_size: provider("xz_size", 1, 16)?,
    // rust: y_size: provider("y_size", 1, 16)?,
    // rust: include_edges: optional(&object, "include_edges")
    // rust: .map(|raw| serde_json::from_str(raw.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(true),
    // rust: include_interior: optional(&object, "include_interior")
    // rust: .map(|raw| serde_json::from_str(raw.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(true),
    // rust: }),
    // rust: "minecraft:offset" => Ok(Self::Offset([
    // rust: provider("x", -16, 16)?,
    // rust: provider("y", -16, 16)?,
    // rust: provider("z", -16, 16)?,
    // rust: ])),
    // rust: "minecraft:height_range" => Ok(Self::HeightRange(HeightProvider::from_json(
    // rust: required(&object, "height")?.get(),
    // rust: )?)),
    // rust: "minecraft:rarity_filter" => Ok(Self::Rarity(int_range(
    // rust: required(&object, "chance")?,
    // rust: "chance",
    // rust: 1,
    // rust: i32::MAX,
    // rust: )?)),
    // rust: "minecraft:random_chance" => {
    // rust: let chance: f32 = number_text(required(&object, "chance")?)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field("chance"))?;
    // rust: if !(0. ..=1.).contains(&chance) || chance.is_sign_negative() {
    // rust: return Err(DecodeError::Field("chance"));
}
    // rust: Ok(Self::RandomChance(chance))
}
    // rust: "minecraft:fixed_placement" => {
    // rust: let values: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "positions")?.get())?;
    // rust: if values.len() > 8192 {
    // rust: return Err(DecodeError::Field("fixed positions"));
}
    // rust: let mut positions = Vec::with_capacity(values.len());
    // rust: for raw in values {
    // rust: let coords: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if coords.len() != 3 {
    // rust: return Err(DecodeError::Field("block position"));
}
    // rust: positions.push([
    // rust: integer(&coords[0])?,
    // rust: integer(&coords[1])?,
    // rust: integer(&coords[2])?,
    // rust: ]);
}
    // rust: Ok(Self::Fixed(positions))
}
    // rust: "minecraft:randomly_selected" => {
    // rust: let values: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "placements")?.get())?;
    // rust: if values.is_empty() || values.len() > 8192 {
    // rust: return Err(DecodeError::Field("selected placements"));
}
    // rust: Ok(Self::RandomlySelected(
    // rust: values
    // rust: .iter()
    // rust: .map(|v| Self::decode_with_blocks(v.get(), depth + 1, remaining, blocks))
    // rust: .collect::<Result<_, _>>()?,
    // rust: ))
}
    // rust: _ => Err(DecodeError::Field("placement modifier type")),
}
}
    /// Return the count for repeating modifiers without allocating or emitting
    /// positions. Sampling still consumes the count provider's random draws.
    // rust: pub fn repetitions(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: ) -> Result<Option<i32>, InvalidBound> {
    // rust: let [x, _, z] = position;
    // rust: Ok(match self {
    // rust: Self::Count(provider) => Some(provider.sample(random)?),
    // rust: Self::NoiseBasedCount {
    // rust: ratio,
    // rust: factor,
    // rust: offset,
    // rust: } => {
    // rust: let noise = f64::from(biome_info_noise(
    // rust: f64::from(x) / factor,
    // rust: f64::from(z) / factor,
    // rust: ));
    // rust: Some(((noise + offset) * f64::from(*ratio)).ceil() as i32)
}
    // rust: Self::NoiseThresholdCount {
    // rust: level,
    // rust: below,
    // rust: above,
    // rust: } => {
    // rust: let noise = f64::from(biome_info_noise(f64::from(x) / 200., f64::from(z) / 200.));
    // rust: Some(if noise < *level { *below } else { *above })
}
    // rust: _ => None,
    // rust: })
}
    /// Emit positions in native callback order. The callback shares the random
    /// stream; failures retain prior emissions and consumed draws.
    // rust: pub fn modify<R: RandomSource, E>(
    // rust: &self,
    // rust: mut context: WorldGenerationContext,
    // rust: random: &mut R,
    // rust: position: [i32; 3],
    // rust: emit: impl FnMut(&mut R, [i32; 3]) -> Result<(), E>,
    // rust: ) -> Result<(), PlacementError<E>> {
    // rust: self.modify_in(&mut context, random, position, emit)
}
    // rust: pub fn modify_in<R: RandomSource, E>(
    // rust: &self,
    // rust: context: &mut impl PlacementContext,
    // rust: random: &mut R,
    // rust: position: [i32; 3],
    // rust: mut emit: impl FnMut(&mut R, [i32; 3]) -> Result<(), E>,
    // rust: ) -> Result<(), PlacementError<E>> {
    // rust: self.modify_inner(context, random, position, &mut emit, &mut 65536)
}
    // rust: fn modify_inner<R: RandomSource, E>(
    // rust: &self,
    // rust: context: &mut impl PlacementContext,
    // rust: random: &mut R,
    // rust: position: [i32; 3],
    // rust: emit: &mut impl FnMut(&mut R, [i32; 3]) -> Result<(), E>,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<(), PlacementError<E>> {
    // rust: if *remaining == 0 {
    // rust: return Err(PlacementError::WorkLimit);
}
    // rust: *remaining -= 1;
    // rust: let [x, y, z] = position;
    // rust: match self {
    // rust: Self::Biome => {
    // rust: let feature = context
    // rust: .top_feature()
    // rust: .ok_or(PlacementQueryError::Unavailable)?;
    // rust: if context.biome_allows_feature(position, feature)? {
    // rust: emit(random, position).map_err(PlacementError::Output)?;
}
}
    // rust: Self::BlockPredicate(predicate) => {
    // rust: if predicate.test_inner(context, position, 0, remaining)? {
    // rust: emit(random, position).map_err(PlacementError::Output)?;
}
}
    // rust: Self::EnvironmentScan {
    // rust: upwards,
    // rust: target,
    // rust: allowed,
    // rust: max_steps,
    // rust: } => {
    // rust: let mut position = position;
    // rust: if !allowed.test_inner(context, position, 0, remaining)? {
    // rust: return Ok(());
}
    // rust: for _ in 0..*max_steps {
    // rust: if target.test_inner(context, position, 0, remaining)? {
    // rust: return emit(random, position).map_err(PlacementError::Output);
}
    // rust: position[1] = position[1].wrapping_add(if *upwards { 1 } else { -1 });
    // rust: if context.outside_build_height(position[1])? {
    // rust: return Ok(());
}
    // rust: if !allowed.test_inner(context, position, 0, remaining)? {
    // rust: break;
}
}
    // rust: if target.test_inner(context, position, 0, remaining)? {
    // rust: emit(random, position).map_err(PlacementError::Output)?;
}
}
    // rust: Self::CountOnEveryLayer(count) => {
    // rust: layer::modify(count, context, random, position, emit, remaining)?
}
    // rust: Self::Heightmap(kind) => {
    // rust: let height = context.height(*kind, x, z)?;
    // rust: if height > context.min_y()? {
    // rust: emit(random, [x, height, z]).map_err(PlacementError::Output)?;
}
}
    // rust: Self::SurfaceRelative {
    // rust: heightmap,
    // rust: min,
    // rust: max,
    // rust: } => {
    // rust: let height = i64::from(context.height(*heightmap, x, z)?);
    // rust: if height + i64::from(*min) <= i64::from(y)
    // rust: && i64::from(y) <= height + i64::from(*max)
    // rust: {
    // rust: emit(random, position).map_err(PlacementError::Output)?;
}
}
    // rust: Self::SurfaceWaterDepth(max) => {
    // rust: let floor = context.height(HeightmapType::OceanFloor, x, z)?;
    // rust: let surface = context.height(HeightmapType::WorldSurface, x, z)?;
    // rust: if surface.wrapping_sub(floor) <= *max {
    // rust: emit(random, position).map_err(PlacementError::Output)?;
}
}
    // rust: Self::Count(_) | Self::NoiseBasedCount { .. } | Self::NoiseThresholdCount { .. } => {
    // rust: let count = self
    // rust: .repetitions(random, position)?
    // rust: .expect("repeating modifier");
    // rust: if count > 4096 {
    // rust: return Err(PlacementError::WorkLimit);
}
    // rust: for _ in 0..count {
    // rust: emit(random, position).map_err(PlacementError::Output)?;
}
}
    // rust: Self::Cuboid {
    // rust: xz_size,
    // rust: y_size,
    // rust: include_edges,
    // rust: include_interior,
    // rust: } => {
    // rust: let ny = y_size.sample(random)?;
    // rust: let nx = xz_size.sample(random)?;
    // rust: let nz = xz_size.sample(random)?;
    // rust: if nx < 0 || ny < 0 || nz < 0 {
    // rust: return Ok(());
}
    // rust: for dx in 0..=nx {
    // rust: for dy in 0..=ny {
    // rust: for dz in 0..=nz {
    // rust: if *remaining == 0 {
    // rust: return Err(PlacementError::WorkLimit);
}
    // rust: *remaining -= 1;
    // rust: let bx = dx == 0 || dx == nx;
    // rust: let by = dy == 0 || dy == ny;
    // rust: let bz = dz == 0 || dz == nz;
    // rust: if !include_edges && (u8::from(bx) + u8::from(by) + u8::from(bz)) >= 2 {
    // rust: continue;
}
    // rust: if !(*include_interior || bx || by || bz) {
    // rust: continue;
}
    // rust: emit(
    // rust: random,
    // rust: [x.wrapping_add(dx), y.wrapping_add(dy), z.wrapping_add(dz)],
    // rust: )
    // rust: .map_err(PlacementError::Output)?;
}
}
}
}
    // rust: Self::InSquare => {
    // rust: let x = x.wrapping_add(random.next_int_bound(16)?);
    // rust: let z = z.wrapping_add(random.next_int_bound(16)?);
    // rust: emit(random, [x, y, z]).map_err(PlacementError::Output)?;
}
    // rust: Self::Offset(offsets) => {
    // rust: let x = x.wrapping_add(offsets[0].sample(random)?);
    // rust: let y = y.wrapping_add(offsets[1].sample(random)?);
    // rust: let z = z.wrapping_add(offsets[2].sample(random)?);
    // rust: emit(random, [x, y, z]).map_err(PlacementError::Output)?;
}
    // rust: Self::HeightRange(height) => {
    // rust: let y = height.sample(random, context.generation())?;
    // rust: emit(random, [x, y, z]).map_err(PlacementError::Output)?;
}
    // rust: Self::Rarity(chance) => {
    // rust: if random.next_float() < 1. / *chance as f32 {
    // rust: emit(random, position).map_err(PlacementError::Output)?;
}
}
    // rust: Self::RandomChance(chance) => {
    // rust: if random.next_float() < *chance {
    // rust: emit(random, position).map_err(PlacementError::Output)?;
}
}
    // rust: Self::Fixed(positions) => {
    // rust: if positions.len() > 8192 {
    // rust: return Err(PlacementError::WorkLimit);
}
    // rust: for p in positions {
    // rust: if p[0] >> 4 == x >> 4 && p[2] >> 4 == z >> 4 {
    // rust: emit(random, *p).map_err(PlacementError::Output)?;
}
}
}
    // rust: Self::RandomlySelected(placements) => {
    // rust: if placements.len() > 8192 {
    // rust: return Err(PlacementError::WorkLimit);
}
    // rust: let index = random.next_int_bound(placements.len() as i32)? as usize;
    // rust: placements[index].modify_inner(context, random, position, emit, remaining)?;
}
}
    // rust: Ok(())
}
}
