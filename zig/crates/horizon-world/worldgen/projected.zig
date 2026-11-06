//! Transpiled from Horizon Rust crate
//! Module: horizon-world_projected
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! 26.3 projection-style features: `minecraft:projected_random_patchy_square`
//! and `minecraft:stepped_column_cluster` (basalt columns).
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::BlockPredicate,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::FeatureExecutionError,
    // rust: int_range,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: state_provider::BlockStateProvider,
    // rust: tree::{TreeDecoder, TreeResult, kind, read, sample_optional, sample_state, write},
    // rust: tree_blocks::{self as tb, TreeBlocks},
    // rust: value_provider::IntProvider,
}
// use crate::registry::BlockStateId;
// use horizon_core::random::RandomSource;
// use std::{collections::BTreeSet, sync::Arc};

    // rust: fn query<E>(error: PlacementQueryError) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Query(error)
}
    // rust: fn predicate(
    // rust: object: &Object,
    // rust: name: &'static str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<BlockPredicate, DecodeError> {
    // rust: BlockPredicate::decode_with_blocks(
    // rust: required(object, name)?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: Some(bindings),
    // rust: )
}

pub const ProjectedPatchySquareFeature = struct {
    block: BlockStateProvider,
    project_through: BlockPredicate,
    size: IntProvider,
    max_projection_height: i32,
};
    // rust: impl ProjectedPatchySquareFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:projected_random_patchy_square" {
    // rust: return Err(DecodeError::Field("projected patchy square type"));
}
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let block = decoder.provider(required(&object, "block")?)?;
    // rust: let size = decoder.int_provider(required(&object, "size")?, 1, 16)?;
    // rust: Ok(Self {
    // rust: block,
    // rust: size,
    // rust: project_through: predicate(&object, "project_through", bindings, depth, remaining)?,
    // rust: max_projection_height: int_range(
    // rust: required(&object, "max_projection_height")?,
    // rust: "max_projection_height",
    // rust: 0,
    // rust: i32::MAX,
    // rust: )?,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let size = self.size.sample(random)?;
    // rust: let bound = size.wrapping_mul(size).wrapping_add(1);
    // rust: for dx in -size..=size {
    // rust: for dz in -size..=size {
    // rust: let probability = dx.abs().wrapping_mul(dz.abs());
    // rust: if random.next_int_bound(bound)? < bound.wrapping_sub(probability) {
    // rust: let mut base = tb::offset(origin, dx, 0, dz);
    // rust: let mut drop = self.max_projection_height;
    // rust: while self
    // rust: .project_through
    // rust: .test(world, tb::offset(base, 0, -1, 0))
    // rust: .map_err(query)?
    // rust: {
    // rust: base = tb::offset(base, 0, -1, 0);
    // rust: drop -= 1;
    // rust: if drop <= 0 {
    // rust: break;
}
}
    // rust: if let Some(state) = sample_optional(&self.block, world, random, base)? {
    // rust: write(world, base, state, 2)?;
}
}
}
}
    // rust: Ok(true)
}
}

pub const SteppedColumnClusterFeature = struct {
    block: BlockStateProvider,
    continue_through: BlockPredicate,
    can_replace: BlockPredicate,
    cannot_place_on: *BTreeSet<BlockStateId>,
    cluster_reach: IntProvider,
    column_count: IntProvider,
    column_reach: IntProvider,
    height: IntProvider,
    blocks: *TreeBlocks,
};
    // rust: impl SteppedColumnClusterFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:stepped_column_cluster" {
    // rust: return Err(DecodeError::Field("stepped column cluster type"));
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let block = decoder.provider(required(&object, "block")?)?;
    // rust: let cannot_place_on = decoder.block_set(required(&object, "cannot_place_on")?)?;
    // rust: let cluster_reach = decoder.int_provider(required(&object, "cluster_reach")?, 0, 13)?;
    // rust: let column_count = decoder.int_provider(required(&object, "column_count")?, 1, 150)?;
    // rust: let column_reach = decoder.int_provider(required(&object, "column_reach")?, 0, 3)?;
    // rust: let height = decoder.int_provider(required(&object, "height")?, 1, 10)?;
    // rust: Ok(Self {
    // rust: block,
    // rust: continue_through: predicate(&object, "continue_through", bindings, depth, remaining)?,
    // rust: can_replace: predicate(&object, "can_replace", bindings, depth, remaining)?,
    // rust: cannot_place_on,
    // rust: cluster_reach,
    // rust: column_count,
    // rust: column_reach,
    // rust: height,
    // rust: blocks,
    // rust: })
}
    // rust: fn can_place_at<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if !self.can_replace.test(world, p).map_err(query)? {
    // rust: return Ok(false);
}
    // rust: let below = read(world, tb::offset(p, 0, -1, 0))?;
    // rust: Ok(!self.blocks.is_air(below) && !self.cannot_place_on.contains(&below))
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if !self.can_place_at(world, origin)? {
    // rust: return Ok(false);
}
    // rust: let column_height = self.height.sample(random)?;
    // rust: let reach = column_height.min(self.cluster_reach.sample(random)?);
    // rust: let count = self.column_count.sample(random)?;
    // rust: let width = reach.wrapping_mul(2).wrapping_add(1);
    // rust: let mut placed = false;
    // rust: for _ in 0..count {
    // rust: let x = origin[0]
    // rust: .wrapping_sub(reach)
    // rust: .wrapping_add(random.next_int_bound(width)?);
    // rust: let y = origin[1].wrapping_add(random.next_int_bound(1)?);
    // rust: let z = origin[2]
    // rust: .wrapping_sub(reach)
    // rust: .wrapping_add(random.next_int_bound(width)?);
    // rust: let pos = [x, y, z];
    // rust: let blocks_y = column_height - tb::dist_manhattan(pos, origin);
    // rust: if blocks_y >= 0 {
    // rust: let column_reach = self.column_reach.sample(random)?;
    // rust: placed |= self.place_column(world, random, pos, blocks_y, column_reach)?;
}
}
    // rust: Ok(placed)
}
    // rust: fn place_column<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: column_height: i32,
    // rust: reach: i32,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let mut placed = false;
        // BlockPos.betweenClosed over a single layer: x fastest, then z.
    // rust: for dz in -reach..=reach {
    // rust: for dx in -reach..=reach {
    // rust: let pos = tb::offset(origin, dx, 0, dz);
    // rust: let step_limit = tb::dist_manhattan(pos, origin);
    // rust: let column = if self.can_replace.test(world, pos).map_err(query)? {
    // rust: self.find_surface(world, pos, step_limit)?
    // rust: } else {
    // rust: self.find_air(world, pos, step_limit)?
}
    // rust: let Some(mut cursor) = column else {
    // rust: continue;
}
    // rust: let mut blocks_y = column_height - step_limit / 2;
    // rust: while blocks_y >= 0 {
    // rust: if self.can_replace.test(world, cursor).map_err(query)? {
    // rust: let state = sample_state(&self.block, world, random, cursor)?;
    // rust: write(world, cursor, state, 3)?;
    // rust: cursor = tb::offset(cursor, 0, 1, 0);
    // rust: placed = true;
    // rust: } else {
    // rust: if !self.continue_through.test(world, cursor).map_err(query)? {
    // rust: break;
}
    // rust: cursor = tb::offset(cursor, 0, 1, 0);
}
    // rust: blocks_y -= 1;
}
}
}
    // rust: Ok(placed)
}
    // rust: fn find_surface<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: mut cursor: [i32; 3],
    // rust: mut limit: i32,
    // rust: ) -> TreeResult<Option<[i32; 3]>, W::Error> {
    // rust: let min_y = world.min_y().map_err(query)?;
    // rust: while cursor[1] > min_y.wrapping_add(1) && limit > 0 {
    // rust: limit -= 1;
    // rust: if self.can_place_at(world, cursor)? {
    // rust: return Ok(Some(cursor));
}
    // rust: cursor = tb::offset(cursor, 0, -1, 0);
}
    // rust: Ok(None)
}
    // rust: fn find_air<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: mut cursor: [i32; 3],
    // rust: mut limit: i32,
    // rust: ) -> TreeResult<Option<[i32; 3]>, W::Error> {
    // rust: let max_y = world.max_y().map_err(query)?;
    // rust: while cursor[1] <= max_y && limit > 0 {
    // rust: limit -= 1;
    // rust: let state = read(world, cursor)?;
    // rust: if self.cannot_place_on.contains(&state) {
    // rust: return Ok(None);
}
    // rust: if self.blocks.is_air(state) {
    // rust: return Ok(Some(cursor));
}
    // rust: cursor = tb::offset(cursor, 0, 1, 0);
}
    // rust: Ok(None)
}
}
