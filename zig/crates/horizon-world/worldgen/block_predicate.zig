//! Transpiled from Horizon Rust crate
//! Module: horizon-world_block_predicate
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Initial world-position predicates with ordered short-circuit evaluation.
// use super::anchor::VerticalAnchor;
// use super::placement::{PlacementContext, PlacementQueryError};
// use super::{DecodeError, Object, density::identifier, integer, optional, required};
// use crate::{
    // rust: block_properties::{BlockProperty, BoundBlockProperty},
    // rust: registry::BlockStateId,
}
// use horizon_core::geometry::Direction;
// use serde_json::value::RawValue;
// use std::{collections::BTreeSet, sync::Arc};

/// `predicate_property` for resolvers that hold the bound physical properties
/// (`block_feature` and `state_provider`), in `BlockProperty` order.
    // rust: pub(super) fn bound_property(
    // rust: values: Option<&[BoundBlockProperty; 4]>,
    // rust: property: BlockProperty,
    // rust: ) -> Result<BoundBlockProperty, DecodeError> {
    // rust: let values = values.ok_or(DecodeError::Field("predicate block property registry"))?;
    // rust: Ok(values[match property {
    // rust: BlockProperty::Solid => 0,
    // rust: BlockProperty::Replaceable => 1,
    // rust: BlockProperty::Liquid => 2,
    // rust: BlockProperty::SolidRender => 3,
    // rust: }]
    // rust: .clone())
}

/// Resolve a block holder set against the same immutable registry used by world
/// queries. Unknown blocks/tags fail during decoding, even in unused branches.
    // rust: pub trait PredicateBlockResolver {
pub fn predicate_state(self: *Self, _json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(DecodeError::Field("predicate block state registry"))
}
    // rust: fn predicate_property(
    // rust: &self,
    // rust: _property: BlockProperty,
    // rust: ) -> Result<BoundBlockProperty, DecodeError> {
    // rust: Err(DecodeError::Field("predicate block property registry"))
}
    // rust: fn predicate_biome_set(
    // rust: &self,
    // rust: _json: &str,
    // rust: ) -> Result<Arc<BTreeSet<super::biome::BiomeId>>, DecodeError> {
    // rust: Err(DecodeError::Field("predicate biome registry"))
}
    // rust: fn predicate_fluid_set(
    // rust: &self,
    // rust: _json: &str,
    // rust: ) -> Result<super::fluid_predicate::BoundFluidSet, DecodeError> {
    // rust: Err(DecodeError::Field("predicate fluid registry"))
}
pub fn predicate_block_set(self: *Self, json: []const u8) R;
}

pub const BlockPredicate = enum {
    True,
    Unobstructed,
    WouldSurvive {,
    state: BlockStateId,
    offset: [i32; 3],
    // rust: },
    HasSturdyFace {,
    direction: Direction,
    offset: [i32; 3],
    // rust: },
    Property {,
    property: BoundBlockProperty,
    offset: [i32; 3],
    // rust: },
    MatchingBiomes(Arc<BTreeSet<super::biome::BiomeId>>),
    MatchingFluids {,
    fluids: super::fluid_predicate::BoundFluidSet,
    offset: [i32; 3],
    // rust: },
    MatchingBlocks {,
    states: Arc<BTreeSet<BlockStateId>>,
    offset: [i32; 3],
    // rust: },
    MatchingBlockTag {,
    tag: String,
    offset: [i32; 3],
    // rust: },
    HeightRange {,
    min: VerticalAnchor,
    max: VerticalAnchor,
    // rust: },
    Volume {,
    min: [i32; 3],
    max: [i32; 3],
    predicate: Box<Self>,
    // rust: },
    Not(Box<Self>),
    All(Vec<Self>),
    Any(Vec<Self>),
    InsideWorldBounds([i32; 3]),
};
    // rust: impl BlockPredicate {
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
    // rust: return Err(DecodeError::Field("block predicate depth or node count"));
}
    // rust: *remaining -= 1;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let kind = identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "type")?.get(),
    // rust: )?)?;
    // rust: match kind.as_str() {
    // rust: "minecraft:would_survive" => Ok(Self::WouldSurvive {
    // rust: state: blocks
    // rust: .ok_or(DecodeError::Field("predicate block state registry"))?
    // rust: .predicate_state(required(&object, "state")?.get())?,
    // rust: offset: optional(&object, "offset")
    // rust: .map(offset)
    // rust: .transpose()?
    // rust: .unwrap_or([0; 3]),
    // rust: }),
    // rust: "minecraft:has_sturdy_face" => {
    // rust: let name: String = serde_json::from_str(required(&object, "direction")?.get())?;
    // rust: let direction = match name.as_str() {
    // rust: "down" => Direction::Down,
    // rust: "up" => Direction::Up,
    // rust: "north" => Direction::North,
    // rust: "south" => Direction::South,
    // rust: "west" => Direction::West,
    // rust: "east" => Direction::East,
    // rust: _ => return Err(DecodeError::Field("predicate direction")),
}
    // rust: Ok(Self::HasSturdyFace {
    // rust: direction,
    // rust: offset: optional(&object, "offset")
    // rust: .map(offset)
    // rust: .transpose()?
    // rust: .unwrap_or([0; 3]),
    // rust: })
}

    // rust: "minecraft:solid" | "minecraft:replaceable" => Ok(Self::Property {
    // rust: property: blocks
    // rust: .ok_or(DecodeError::Field("predicate block property registry"))?
    // rust: .predicate_property(if kind == "minecraft:solid" {
    // rust: BlockProperty::Solid
    // rust: } else {
    // rust: BlockProperty::Replaceable
    // rust: })?,
    // rust: offset: optional(&object, "offset")
    // rust: .map(offset)
    // rust: .transpose()?
    // rust: .unwrap_or([0; 3]),
    // rust: }),
    // rust: "minecraft:unobstructed" => {
    // rust: if let Some(raw) = optional(&object, "offset") {
    // rust: vector(raw)?;
}
                // The pinned evaluator deliberately ignores its decoded offset.
    // rust: Ok(Self::Unobstructed)
}
    // rust: "minecraft:matching_biomes" => Ok(Self::MatchingBiomes(
    // rust: blocks
    // rust: .ok_or(DecodeError::Field("predicate biome registry"))?
    // rust: .predicate_biome_set(required(&object, "biomes")?.get())?,
    // rust: )),
    // rust: "minecraft:matching_fluids" => Ok(Self::MatchingFluids {
    // rust: fluids: blocks
    // rust: .ok_or(DecodeError::Field("predicate fluid registry"))?
    // rust: .predicate_fluid_set(required(&object, "fluids")?.get())?,
    // rust: offset: optional(&object, "offset")
    // rust: .map(offset)
    // rust: .transpose()?
    // rust: .unwrap_or([0; 3]),
    // rust: }),
    // rust: "minecraft:matching_blocks" => Ok(Self::MatchingBlocks {
    // rust: states: blocks
    // rust: .ok_or(DecodeError::Field("predicate block registry"))?
    // rust: .predicate_block_set(required(&object, "blocks")?.get())?,
    // rust: offset: optional(&object, "offset")
    // rust: .map(offset)
    // rust: .transpose()?
    // rust: .unwrap_or([0; 3]),
    // rust: }),
    // rust: "minecraft:matching_block_tag" => Ok(Self::MatchingBlockTag {
    // rust: tag: super::tags::identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "tag")?.get(),
    // rust: )?)?,
    // rust: offset: optional(&object, "offset")
    // rust: .map(offset)
    // rust: .transpose()?
    // rust: .unwrap_or([0; 3]),
    // rust: }),
    // rust: "minecraft:height_range" => Ok(Self::HeightRange {
    // rust: min: VerticalAnchor::from_json(required(&object, "min_inclusive")?.get())?,
    // rust: max: VerticalAnchor::from_json(required(&object, "max_inclusive")?.get())?,
    // rust: }),
    // rust: "minecraft:volume_match" => {
    // rust: let min = offset(required(&object, "min")?)?;
    // rust: let max = offset(required(&object, "max")?)?;
    // rust: if (0..3).any(|i| min[i] > max[i]) {
    // rust: return Err(DecodeError::Field("predicate volume bounds"));
}
    // rust: Ok(Self::Volume {
    // rust: min,
    // rust: max,
    // rust: predicate: Box::new(Self::decode_with_blocks(
    // rust: required(&object, "match")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: blocks,
    // rust: )?),
    // rust: })
}
    // rust: "minecraft:true" => Ok(Self::True),
    // rust: "minecraft:not" => Ok(Self::Not(Box::new(Self::decode_with_blocks(
    // rust: required(&object, "predicate")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: blocks,
    // rust: )?))),
    // rust: "minecraft:all_of" | "minecraft:any_of" => {
    // rust: let values: Vec<Box<RawValue>> =
    // rust: serde_json::from_str(required(&object, "predicates")?.get())?;
    // rust: if values.len() > 8192 {
    // rust: return Err(DecodeError::Field("predicate list"));
}
    // rust: let values = values
    // rust: .iter()
    // rust: .map(|v| Self::decode_with_blocks(v.get(), depth + 1, remaining, blocks))
    // rust: .collect::<Result<_, _>>()?;
    // rust: Ok(if kind == "minecraft:all_of" {
    // rust: Self::All(values)
    // rust: } else {
    // rust: Self::Any(values)
    // rust: })
}
    // rust: "minecraft:inside_world_bounds" => Ok(Self::InsideWorldBounds(
    // rust: optional(&object, "offset")
    // rust: .map(offset)
    // rust: .transpose()?
    // rust: .unwrap_or([0; 3]),
    // rust: )),
    // rust: _ => Err(DecodeError::Field("block predicate type")),
}
}
    // rust: pub fn test(
    // rust: &self,
    // rust: world: &mut impl PlacementContext,
    // rust: position: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: self.test_inner(world, position, 0, &mut 65536)
}
    // rust: pub(crate) fn test_inner(
    // rust: &self,
    // rust: world: &mut impl PlacementContext,
    // rust: position: [i32; 3],
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: if depth > 256 || *remaining == 0 {
    // rust: return Err(PlacementQueryError::WorkLimit);
}
    // rust: *remaining -= 1;
    // rust: match self {
    // rust: Self::WouldSurvive { state, offset } => world.block_survives(
    // rust: *state,
    // rust: std::array::from_fn(|i| position[i].wrapping_add(offset[i])),
    // rust: ),
    // rust: Self::Property { property, offset } => {
    // rust: let state = world
    // rust: .block_state(std::array::from_fn(|i| position[i].wrapping_add(offset[i])))?;
    // rust: Ok(property.contains(state))
}
    // rust: Self::HasSturdyFace { direction, offset } => world.face_sturdy(
    // rust: std::array::from_fn(|i| position[i].wrapping_add(offset[i])),
    // rust: *direction,
    // rust: ),
    // rust: Self::Unobstructed => world.unobstructed_block(position),
    // rust: Self::MatchingBiomes(biomes) => Ok(biomes.contains(&world.biome_identity(position)?)),
    // rust: Self::MatchingFluids { fluids, offset } => {
    // rust: let state = world
    // rust: .block_state(std::array::from_fn(|i| position[i].wrapping_add(offset[i])))?;
    // rust: Ok(fluids.contains(state))
}
    // rust: Self::MatchingBlocks { states, offset } => {
    // rust: let state = world
    // rust: .block_state(std::array::from_fn(|i| position[i].wrapping_add(offset[i])))?;
    // rust: Ok(states.contains(&state))
}
    // rust: Self::MatchingBlockTag { tag, offset } => world.block_matches_tag(
    // rust: std::array::from_fn(|i| position[i].wrapping_add(offset[i])),
    // rust: tag,
    // rust: ),
    // rust: Self::HeightRange { min, max } => {
    // rust: let context = world.predicate_generation()?;
    // rust: let min = min.resolve(context);
    // rust: let max = max.resolve(context);
    // rust: Ok(position[1] >= min && position[1] <= max)
}
    // rust: Self::Volume {
    // rust: min,
    // rust: max,
    // rust: predicate,
    // rust: } => {
                // Native order is X, Z, Y. Each child shares the evaluation
                // budget, including nested volumes and early-failing queries.
    // rust: for x in min[0]..=max[0] {
    // rust: for z in min[2]..=max[2] {
    // rust: for y in min[1]..=max[1] {
    // rust: let offset = [x, y, z];
    // rust: let p = std::array::from_fn(|i| position[i].wrapping_add(offset[i]));
    // rust: if !predicate.test_inner(world, p, depth + 1, remaining)? {
    // rust: return Ok(false);
}
}
}
}
    // rust: Ok(true)
}
    // rust: Self::True => Ok(true),
    // rust: Self::Not(value) => Ok(!value.test_inner(world, position, depth + 1, remaining)?),
    // rust: Self::All(values) | Self::Any(values) => {
    // rust: let all = matches!(self, Self::All(_));
    // rust: for value in values {
    // rust: let result = value.test_inner(world, position, depth + 1, remaining)?;
    // rust: if result != all {
    // rust: return Ok(result);
}
}
    // rust: Ok(all)
}
    // rust: Self::InsideWorldBounds(offset) => world
    // rust: .inside_build_height(std::array::from_fn(|i| position[i].wrapping_add(offset[i]))),
}
}
}

pub fn vector(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let values: Vec<Box<RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if values.len() != 3 {
    // rust: return Err(DecodeError::Field("predicate offset"));
}
    // rust: let mut result = [0; 3];
    // rust: for (out, value) in result.iter_mut().zip(values.iter()) {
    // rust: *out = integer(value)?;
}
    // rust: Ok(result)
}

pub fn offset(raw: *RawValue) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let result = vector(raw)?;
    // Native Math.abs(MIN_VALUE) wraps and passes this codec.
    // rust: if result.iter().any(|v| v.wrapping_abs() > 16) {
    // rust: return Err(DecodeError::Field("predicate offset"));
}
    // rust: Ok(result)
}
