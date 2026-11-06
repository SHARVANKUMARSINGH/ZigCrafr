//! Transpiled from Horizon Rust crate
package horizon_world_fallen

import "core:fmt"
import "core:mem"
import "core:math"

// `minecraft:fallen_tree`: a stump and an optional fallen log with decorators.
// use super::{
    // rust: NestedPlacer, Run, Sets, TreeDecoder, TreeResult, decorator::Lists, decorator::NestedDecoder,
    // rust: decorator::TreeDecorator, kind, read, sample_state, write,
}
// use crate::worldgen::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::FeatureExecutionError,
    // rust: placement::PlacementContext,
    // rust: required,
    // rust: state_provider::BlockStateProvider,
    // rust: tree_blocks::{self as tb, Axis, PosSet, TreeBlocks},
    // rust: value_provider::IntProvider,
}
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::sync::Arc;

FallenTreeFeature :: struct {
    trunk_provider: BlockStateProvider,
    log_length: IntProvider,
    stump_decorators: [dynamic]TreeDecorator,
    log_decorators: [dynamic]TreeDecorator,
    blocks: ^TreeBlocks,
}
    // rust: impl FallenTreeFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: nested: &NestedDecoder<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:fallen_tree" {
    // rust: return Err(DecodeError::Field("fallen tree feature type"));
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: Ok(Self {
    // rust: trunk_provider: decoder.provider(required(&object, "trunk_provider")?)?,
    // rust: log_length: decoder.int_provider(required(&object, "log_length")?, 0, 16)?,
    // rust: stump_decorators: TreeDecorator::decode_list(
    // rust: required(&object, "stump_decorators")?,
    // rust: &mut decoder,
    // rust: None,
    // rust: nested,
    // rust: )?,
    // rust: log_decorators: TreeDecorator::decode_list(
    // rust: required(&object, "log_decorators")?,
    // rust: &mut decoder,
    // rust: None,
    // rust: nested,
    // rust: )?,
    // rust: blocks,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: nested: &mut NestedPlacer<'_, W, R>,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let mut run = Run {
    // rust: world,
    // rust: random,
    // rust: sets: Sets::default(),
    // rust: track: false,
}
    // rust: let stump = self.place_log(&mut run, origin, None)?;
    // rust: self.decorate(&mut run, &[stump], &self.stump_decorators, nested)?;
    // rust: let direction = tb::HORIZONTAL[run.random.next_int_bound(4)? as usize];
    // rust: let length = self.log_length.sample(run.random)? - 2;
    // rust: let mut start = tb::relative(origin, direction, 2 + run.random.next_int_bound(2)?);
    // rust: start = tb::offset(start, 0, 1, 0);
    // rust: for _ in 0..6 {
    // rust: if self.may_place_on(&mut run, start)? {
    // rust: break;
}
    // rust: start = tb::offset(start, 0, -1, 0);
}
    // rust: if self.can_place_log(&mut run, length, start, direction)? {
    // rust: let mut logs = PosSet::default();
    // rust: let mut p = start;
    // rust: for _ in 0..length {
    // rust: logs.insert(self.place_log(&mut run, p, Some(Axis::of(direction)))?);
    // rust: p = tb::relative(p, direction, 1);
}
    // rust: self.decorate(&mut run, &logs.to_vec(), &self.log_decorators, nested)?;
}
    // rust: Ok(true)
}
    // rust: fn decorate<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: logs: &[[i32; 3]],
    // rust: decorators: &[TreeDecorator],
    // rust: nested: &mut NestedPlacer<'_, W, R>,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: if decorators.is_empty() {
    // rust: return Ok(());
}
    // rust: let lists = Lists::new(logs.to_vec(), vec![], vec![]);
    // rust: for decorator in decorators {
    // rust: decorator.place(run, &self.blocks, &lists, nested)?;
}
    // rust: Ok(())
}
    // rust: fn place_log<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: p: [i32; 3],
    // rust: axis: Option<Axis>,
    // rust: ) -> TreeResult<[i32; 3], W::Error> {
    // rust: let mut state = sample_state(&self.trunk_provider, run.world, run.random, p)?;
    // rust: if let Some(axis) = axis {
    // rust: state = self.blocks.try_axis(state, axis);
}
    // rust: write(run.world, p, state, 3)?;
        // Feature.markAboveForPostProcessing.
    // rust: let mut above = p;
    // rust: for _ in 0..2 {
    // rust: above = tb::offset(above, 0, 1, 0);
    // rust: if self.blocks.is_air(read(run.world, above)?) {
    // rust: break;
}
    // rust: run.world
    // rust: .mark_postprocessing(above)
    // rust: .map_err(FeatureExecutionError::Query)?;
}
    // rust: Ok(p)
}
    // rust: fn over_solid_ground<W: FeatureWorld + PlacementContext, R>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: p: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let below = read(run.world, tb::offset(p, 0, -1, 0))?;
    // rust: run.world
    // rust: .state_face_sturdy(below, p, Direction::Up)
    // rust: .map_err(FeatureExecutionError::Query)
}
    // rust: fn may_place_on<W: FeatureWorld + PlacementContext, R>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: p: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: Ok(self.blocks.valid_tree_pos(read(run.world, p)?) && self.over_solid_ground(run, p)?)
}
    // rust: fn can_place_log<W: FeatureWorld + PlacementContext, R>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: length: i32,
    // rust: start: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let mut gap = 0;
    // rust: let mut p = start;
    // rust: for _ in 0..length {
    // rust: if !self.blocks.valid_tree_pos(read(run.world, p)?) {
    // rust: return Ok(false);
}
    // rust: if !self.over_solid_ground(run, p)? {
    // rust: gap += 1;
    // rust: if gap > 2 {
    // rust: return Ok(false);
}
    // rust: } else {
    // rust: gap = 0;
}
    // rust: p = tb::relative(p, direction, 1);
}
    // rust: Ok(true)
}
}
