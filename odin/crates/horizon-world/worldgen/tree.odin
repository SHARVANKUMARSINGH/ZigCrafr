//! Transpiled from Horizon Rust crate
package horizon_world_tree

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla 26.3 `minecraft:tree` and `minecraft:fallen_tree` features: trunk,
// foliage and root placers, decorators, minimum-size clipping and the native
// leaf-distance pass. Native HashSet iteration order is reproduced wherever it
// feeds random draws. Neighbor shape updates at the tree's outer faces are
// delegated to `PlacementContext::update_shape_at_face`.
    // rust: mod decorator;
    // rust: mod fallen;
    // rust: mod foliage;
    // rust: mod trunk;
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: density::identifier,
    // rust: feature::{FeatureError, FeatureWorld},
    // rust: feature_graph::{FeatureDefinition, FeatureExecutionError},
    // rust: int_range, number_text, optional,
    // rust: placement::PlacementContext,
    // rust: required,
    // rust: state_provider::BlockStateProvider,
    // rust: tree_blocks::{self as tb, PosSet, TreeBlocks},
    // rust: value_provider::IntProvider,
}
// use crate::registry::BlockStateId;
// use decorator::TreeDecorator;
    // rust: pub(crate) use decorator::{GROUND_FEATURE_KEY, beehive_occupants};
    // rust: pub use fallen::FallenTreeFeature;
// use foliage::{FoliageAttachment, FoliagePlacer};
// use horizon_core::{geometry::Direction, random::RandomSource};
// use serde_json::value::RawValue;
// use std::{collections::BTreeSet, sync::Arc};
// use trunk::TrunkPlacer;

    // rust: pub(crate) type TreeResult<T, E> = Result<T, FeatureExecutionError<E>>;
// Places a nested configured feature (the pale-moss ground patch).
    // rust: pub(crate) type NestedPlacer<'a, W, R> = dyn FnMut(
    // rust: &FeatureDefinition,
    // rust: &mut W,
    // rust: &mut R,
    // rust: [i32; 3],
    // rust: ) -> TreeResult<bool, <W as FeatureWorld>::Error>
    // rust: + 'a;

    // rust: pub(crate) fn world_error<E>(error: E) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Basic(FeatureError::World(error))
}
    // rust: pub(crate) fn read<W: FeatureWorld>(
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: ) -> TreeResult<BlockStateId, W::Error> {
    // rust: world.block(position).map_err(world_error)
}
// `FeatureWorld::scan_column`.
    // rust: pub(crate) fn scan_column<W: FeatureWorld>(
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: step: i32,
    // rust: limit: i32,
    // rust: keep: impl FnMut(BlockStateId) -> bool,
    // rust: ) -> TreeResult<i32, W::Error> {
    // rust: world
    // rust: .scan_column(position, step, limit, keep)
    // rust: .map_err(world_error)
}
    // rust: pub(crate) fn write<W: FeatureWorld>(
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: flags: i32,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: world.set_block(position, state, flags).map_err(world_error)
}
    // rust: pub(crate) fn sample_state<W: FeatureWorld + PlacementContext>(
    // rust: provider: &BlockStateProvider,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: ) -> TreeResult<BlockStateId, W::Error> {
    // rust: provider
    // rust: .get_state(world, random, position)
    // rust: .map_err(FeatureExecutionError::Provider)
}
    // rust: pub(crate) fn sample_optional<W: FeatureWorld + PlacementContext>(
    // rust: provider: &BlockStateProvider,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: ) -> TreeResult<Option<BlockStateId>, W::Error> {
    // rust: provider
    // rust: .get_optional_state(world, random, position)
    // rust: .map_err(FeatureExecutionError::Provider)
}

// Decoding context shared by every tree component.
    // rust: pub(crate) struct TreeDecoder<'a, 'r> {
    // rust: pub bindings: &'a FeatureBlockBindings<'r>,
    // rust: pub depth: usize,
    // rust: pub remaining: &'a mut usize,
}
    // rust: impl TreeDecoder<'_, '_> {
provider :: proc(self: ^Self, raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (providers, catalog, _) = self
    // rust: .bindings
    // rust: .simple_blocks
    // rust: .as_ref()
    // rust: .ok_or(DecodeError::Field("tree provider bindings"))?;
    // rust: catalog.provider_with_budget(raw.get(), providers, self.depth + 1, self.remaining)
}
    // rust: pub fn int_provider(
    // rust: &mut self,
    // rust: raw: &RawValue,
    // rust: low: i32,
    // rust: high: i32,
    // rust: ) -> Result<IntProvider, DecodeError> {
    // rust: let value = IntProvider::decode(raw, self.depth + 1, self.remaining)?;
    // rust: let [min, max] = value.bounds();
    // rust: if min < low || max > high {
    // rust: return Err(DecodeError::Field("tree integer provider bounds"));
}
    // rust: Ok(value)
}
block_set :: proc(self: ^Self, raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: super::block_predicate::PredicateBlockResolver::predicate_block_set(
    // rust: self.bindings,
    // rust: raw.get(),
    // rust: )
}
}
    // rust: pub(crate) fn unit_float(raw: &RawValue, name: &'static str) -> Result<f32, DecodeError> {
    // rust: let value: f32 = number_text(raw)?
    // rust: .parse()
    // rust: .map_err(|_| DecodeError::Field(name))?;
    // rust: if !(0.0..=1.0).contains(&value) {
    // rust: return Err(DecodeError::Field(name));
}
    // rust: Ok(value)
}
    // rust: pub(crate) fn kind(object: &Object) -> Result<String, DecodeError> {
    // rust: identifier(&serde_json::from_str::<String>(
    // rust: required(object, "type")?.get(),
    // rust: )?)
}
    // rust: fn optional_int(
    // rust: object: &Object,
    // rust: name: &'static str,
    // rust: default: i32,
    // rust: low: i32,
    // rust: high: i32,
    // rust: ) -> Result<i32, DecodeError> {
    // rust: optional(object, name)
    // rust: .map(|raw| int_range(raw, name, low, high))
    // rust: .transpose()
    // rust: .map(|v| v.unwrap_or(default))
}

FeatureSize :: enum {
    TwoLayers {,
    limit: i32,
    lower: i32,
    upper: i32,
    // rust: },
    ThreeLayers {,
    limit: i32,
    upper_limit: i32,
    lower: i32,
    middle: i32,
    upper: i32,
    // rust: },
}
    // rust: impl FeatureSize {
decode :: proc(raw: ^RawValue) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: let clipped = optional(&object, "min_clipped_height")
    // rust: .map(|raw| int_range(raw, "min_clipped_height", 0, 80))
    // rust: .transpose()?;
    // rust: let size = match kind(&object)?.as_str() {
    // rust: "minecraft:two_layers_feature_size" => Self::TwoLayers {
    // rust: limit: optional_int(&object, "limit", 1, 0, 81)?,
    // rust: lower: optional_int(&object, "lower_size", 0, 0, 16)?,
    // rust: upper: optional_int(&object, "upper_size", 1, 0, 16)?,
    // rust: },
    // rust: "minecraft:three_layers_feature_size" => Self::ThreeLayers {
    // rust: limit: optional_int(&object, "limit", 1, 0, 80)?,
    // rust: upper_limit: optional_int(&object, "upper_limit", 1, 0, 80)?,
    // rust: lower: optional_int(&object, "lower_size", 0, 0, 16)?,
    // rust: middle: optional_int(&object, "middle_size", 1, 0, 16)?,
    // rust: upper: optional_int(&object, "upper_size", 1, 0, 16)?,
    // rust: },
    // rust: _ => return Err(DecodeError::Field("feature size type")),
}
    // rust: Ok((size, clipped))
}
size_at_height :: proc(self: ^Self, tree_height: i32, yo: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match *self {
    // rust: Self::TwoLayers {
    // rust: limit,
    // rust: lower,
    // rust: upper,
    // rust: } => {
    // rust: if yo < limit {
    // rust: lower
    // rust: } else {
    // rust: upper
}
}
    // rust: Self::ThreeLayers {
    // rust: limit,
    // rust: upper_limit,
    // rust: lower,
    // rust: middle,
    // rust: upper,
    // rust: } => {
    // rust: if yo < limit {
    // rust: lower
    // rust: } else if yo >= tree_height.wrapping_sub(upper_limit) {
    // rust: upper
    // rust: } else {
    // rust: middle
}
}
}
}
}

MangroveRoots :: struct {
    can_grow_through: ^BTreeSet<BlockStateId>,
    muddy_roots_in: ^BTreeSet<BlockStateId>,
    muddy_roots_provider: BlockStateProvider,
    max_root_width: i32,
    max_root_length: i32,
    random_skew_chance: f32,
}
RootPlacer :: struct {
    trunk_offset_y: IntProvider,
    root_provider: BlockStateProvider,
    above: Option<(BlockStateProvider,
    mangrove: MangroveRoots,
}
    // rust: impl RootPlacer {
decode :: proc(raw: ^RawValue, decoder: ^TreeDecoder<'_) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(raw.get())?;
    // rust: if kind(&object)? != "minecraft:mangrove_root_placer" {
    // rust: return Err(DecodeError::Field("root placer type"));
}
    // rust: let trunk_offset_y = IntProvider::decode(
    // rust: required(&object, "trunk_offset_y")?,
    // rust: decoder.depth + 1,
    // rust: decoder.remaining,
    // rust: )?;
    // rust: let root_provider = decoder.provider(required(&object, "root_provider")?)?;
    // rust: let above = optional(&object, "above_root_placement")
    // rust: .map(|raw| -> Result<_, DecodeError> {
    // rust: let above: Object = serde_json::from_str(raw.get())?;
    // rust: Ok((
    // rust: decoder.provider(required(&above, "above_root_provider")?)?,
    // rust: unit_float(
    // rust: required(&above, "above_root_placement_chance")?,
    // rust: "above_root_placement_chance",
    // rust: )?,
    // rust: ))
    // rust: })
    // rust: .transpose()?;
    // rust: let placement: Object =
    // rust: serde_json::from_str(required(&object, "mangrove_root_placement")?.get())?;
    // rust: let mangrove = MangroveRoots {
    // rust: can_grow_through: decoder.block_set(required(&placement, "can_grow_through")?)?,
    // rust: muddy_roots_in: decoder.block_set(required(&placement, "muddy_roots_in")?)?,
    // rust: muddy_roots_provider: decoder
    // rust: .provider(required(&placement, "muddy_roots_provider")?)?,
    // rust: max_root_width: int_range(
    // rust: required(&placement, "max_root_width")?,
    // rust: "max_root_width",
    // rust: 1,
    // rust: 12,
    // rust: )?,
    // rust: max_root_length: int_range(
    // rust: required(&placement, "max_root_length")?,
    // rust: "max_root_length",
    // rust: 1,
    // rust: 64,
    // rust: )?,
    // rust: random_skew_chance: unit_float(
    // rust: required(&placement, "random_skew_chance")?,
    // rust: "random_skew_chance",
    // rust: )?,
}
    // rust: Ok(Self {
    // rust: trunk_offset_y,
    // rust: root_provider,
    // rust: above,
    // rust: mangrove,
    // rust: })
}
    // rust: fn can_place_root<W: FeatureWorld, R>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: position: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let state = read(run.world, position)?;
    // rust: Ok(tree.blocks.valid_tree_pos(state) || self.mangrove.can_grow_through.contains(&state))
}
    // rust: fn waterlogged<W: FeatureWorld>(
    // rust: tree: &TreeFeature,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> TreeResult<BlockStateId, W::Error> {
    // rust: if tree.blocks.has(state, tb::WATERLOGGABLE) {
    // rust: let here = read(world, position)?;
    // rust: Ok(tree
    // rust: .blocks
    // rust: .waterlogged(state, tree.blocks.has(here, tb::WATER_FLUID)))
    // rust: } else {
    // rust: Ok(state)
}
}
    // rust: fn place_root<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: position: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let here = read(run.world, position)?;
    // rust: if self.mangrove.muddy_roots_in.contains(&here) {
    // rust: let state = sample_state(
    // rust: &self.mangrove.muddy_roots_provider,
    // rust: run.world,
    // rust: run.random,
    // rust: position,
    // rust: )?;
    // rust: let state = Self::waterlogged(tree, run.world, position, state)?;
    // rust: return run.set(Layer::Root, position, state);
}
    // rust: if !self.can_place_root(run, tree, position)? {
    // rust: return Ok(());
}
    // rust: let state = sample_state(&self.root_provider, run.world, run.random, position)?;
    // rust: let state = Self::waterlogged(tree, run.world, position, state)?;
    // rust: run.set(Layer::Root, position, state)?;
    // rust: if let Some((provider, chance)) = &self.above {
    // rust: let above = tb::offset(position, 0, 1, 0);
    // rust: if run.random.next_float() < *chance && tree.blocks.is_air(read(run.world, above)?) {
    // rust: let state = sample_state(provider, run.world, run.random, above)?;
    // rust: let state = Self::waterlogged(tree, run.world, above, state)?;
    // rust: run.set(Layer::Root, above, state)?;
}
}
    // rust: Ok(())
}
    // rust: fn place_roots<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: origin: [i32; 3],
    // rust: trunk_origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let mut column = origin;
    // rust: while column[1] < trunk_origin[1] {
    // rust: if !self.can_place_root(run, tree, column)? {
    // rust: return Ok(false);
}
    // rust: column[1] = column[1].wrapping_add(1);
}
    // rust: let mut roots = vec![tb::offset(trunk_origin, 0, -1, 0)];
    // rust: for direction in tb::HORIZONTAL {
    // rust: let start = tb::relative(trunk_origin, direction, 1);
    // rust: let mut positions = Vec::new();
    // rust: if !self.simulate(run, tree, start, direction, trunk_origin, &mut positions, 0)? {
    // rust: return Ok(false);
}
    // rust: roots.extend(positions);
    // rust: roots.push(start);
}
    // rust: for root in roots {
    // rust: self.place_root(run, tree, root)?;
}
    // rust: Ok(true)
}
    // rust: fn simulate<W: FeatureWorld, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: tree: &TreeFeature,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: origin: [i32; 3],
    // rust: positions: &mut Vec<[i32; 3]>,
    // rust: layer: i32,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let max = self.mangrove.max_root_length;
    // rust: if layer == max || positions.len() as i64 > i64::from(max) {
    // rust: return Ok(false);
}
    // rust: for next in self.potential(run.random, position, direction, origin)? {
    // rust: if self.can_place_root(run, tree, next)? {
    // rust: positions.push(next);
    // rust: if !self.simulate(run, tree, next, direction, origin, positions, layer + 1)? {
    // rust: return Ok(false);
}
}
}
    // rust: Ok(true)
}
    // rust: fn potential<E>(
    // rust: &self,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<Vec<[i32; 3]>, E> {
    // rust: let below = tb::offset(position, 0, -1, 0);
    // rust: let next_to = tb::relative(position, direction, 1);
    // rust: let width = tb::dist_manhattan(position, origin);
    // rust: let max = self.mangrove.max_root_width;
    // rust: let skew = self.mangrove.random_skew_chance;
    // rust: Ok(if width > max - 3 && width <= max {
    // rust: if random.next_float() < skew {
    // rust: vec![below, tb::offset(next_to, 0, -1, 0)]
    // rust: } else {
    // rust: vec![below]
}
    // rust: } else if width > max {
    // rust: vec![below]
    // rust: } else if random.next_float() < skew {
    // rust: vec![below]
    // rust: } else if random.next_boolean() {
    // rust: vec![next_to]
    // rust: } else {
    // rust: vec![below]
    // rust: })
}
}

TreeFeature :: struct {
    trunk_provider: BlockStateProvider,
    trunk_placer: TrunkPlacer,
    foliage_provider: BlockStateProvider,
    foliage_placer: FoliagePlacer,
    root_placer: Maybe(RootPlacer),
    minimum_size: FeatureSize,
    min_clipped_height: Maybe(i32),
    decorators: [dynamic]TreeDecorator,
    ignore_vines: bool,
    below_trunk_provider: BlockStateProvider,
    blocks: ^TreeBlocks,
}

    // rust: pub(crate) enum Layer {
    // rust: Root,
    // rust: Trunk,
    // rust: Foliage,
    // rust: Decoration,
}
    // rust: pub(crate) struct Sets {
    // rust: roots: PosSet,
    // rust: trunks: PosSet,
    // rust: foliage: PosSet,
    // rust: decorations: PosSet,
}
    // rust: pub(crate) struct Run<'a, W, R> {
    // rust: pub world: &'a mut W,
    // rust: pub random: &'a mut R,
    // rust: sets: Sets,
    // Fallen trees write decorations without recording them.
    // rust: track: bool,
}
    // rust: impl<W: FeatureWorld, R> Run<'_, W, R> {
    // rust: pub(crate) fn set(
    // rust: &mut self,
    // rust: layer: Layer,
    // rust: position: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: if self.track {
    // rust: match layer {
    // rust: Layer::Root => self.sets.roots.insert(position),
    // rust: Layer::Trunk => self.sets.trunks.insert(position),
    // rust: Layer::Foliage => self.sets.foliage.insert(position),
    // rust: Layer::Decoration => self.sets.decorations.insert(position),
}
}
    // rust: write(self.world, position, state, 19)?;
    // rust: Ok(())
}
    // rust: pub(crate) fn foliage_contains(&self, position: [i32; 3]) -> bool {
    // rust: self.sets.foliage.contains(position)
}
}

    // rust: impl TreeFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: nested: &decorator::NestedDecoder<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:tree" {
    // rust: return Err(DecodeError::Field("tree feature type"));
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let trunk_provider = decoder.provider(required(&object, "trunk_provider")?)?;
    // rust: let trunk_placer = TrunkPlacer::decode(required(&object, "trunk_placer")?, &mut decoder)?;
    // rust: let foliage_provider = decoder.provider(required(&object, "foliage_provider")?)?;
    // rust: let foliage_placer =
    // rust: FoliagePlacer::decode(required(&object, "foliage_placer")?, &mut decoder)?;
    // rust: let root_placer = optional(&object, "root_placer")
    // rust: .map(|raw| RootPlacer::decode(raw, &mut decoder))
    // rust: .transpose()?;
    // rust: let (minimum_size, min_clipped_height) =
    // rust: FeatureSize::decode(required(&object, "minimum_size")?)?;
    // rust: let decorators = TreeDecorator::decode_list(
    // rust: required(&object, "decorators")?,
    // rust: &mut decoder,
    // rust: optional(&object, decorator::GROUND_FEATURE_KEY),
    // rust: nested,
    // rust: )?;
    // rust: let ignore_vines = optional(&object, "ignore_vines")
    // rust: .map(|raw| serde_json::from_str::<bool>(raw.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false);
    // rust: let below_trunk_provider = decoder.provider(required(&object, "below_trunk_provider")?)?;
    // rust: Ok(Self {
    // rust: trunk_provider,
    // rust: trunk_placer,
    // rust: foliage_provider,
    // rust: foliage_placer,
    // rust: root_placer,
    // rust: minimum_size,
    // rust: min_clipped_height,
    // rust: decorators,
    // rust: ignore_vines,
    // rust: below_trunk_provider,
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
    // rust: track: true,
}
    // rust: let result = self.do_place(&mut run, origin)?;
    // rust: if !result || (run.sets.trunks.is_empty() && run.sets.foliage.is_empty()) {
    // rust: return Ok(false);
}
    // rust: if !self.decorators.is_empty() {
    // rust: let lists = decorator::Lists::new(
    // rust: run.sets.trunks.to_vec(),
    // rust: run.sets.foliage.to_vec(),
    // rust: run.sets.roots.to_vec(),
    // rust: );
    // rust: for decorator in &self.decorators {
    // rust: decorator.place(&mut run, &self.blocks, &lists, nested)?;
}
}
    // rust: let mut bounds: Option<([i32; 3], [i32; 3])> = None;
    // rust: for set in [
    // rust: &run.sets.roots,
    // rust: &run.sets.trunks,
    // rust: &run.sets.foliage,
    // rust: &run.sets.decorations,
    // rust: ] {
    // rust: for p in set.to_vec() {
    // rust: bounds = Some(match bounds {
    // rust: None => (p, p),
    // rust: Some((lo, hi)) => (
    // rust: std::array::from_fn(|i| lo[i].min(p[i])),
    // rust: std::array::from_fn(|i| hi[i].max(p[i])),
    // rust: ),
    // rust: });
}
}
    // rust: let Some((low, high)) = bounds else {
    // rust: return Ok(false);
}
    // rust: let shape = update_leaves(&mut run, &self.blocks, low, high)?;
    // rust: update_shape_at_edge(run.world, &shape, low, 3)?;
    // rust: Ok(true)
}

    // rust: fn do_place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let tree_height = self.trunk_placer.tree_height(run.random)?;
    // rust: let foliage_height = self
    // rust: .foliage_placer
    // rust: .foliage_height(run.random, tree_height)?;
    // rust: let trunk_height = tree_height.wrapping_sub(foliage_height);
    // rust: let leaf_radius = self
    // rust: .foliage_placer
    // rust: .foliage_radius(run.random, trunk_height)?;
    // rust: let trunk_origin = match &self.root_placer {
    // rust: Some(root) => tb::offset(origin, 0, root.trunk_offset_y.sample(run.random)?, 0),
    // rust: None => origin,
}
    // rust: let min_y = origin[1].min(trunk_origin[1]);
    // rust: let max_y = origin[1]
    // rust: .max(trunk_origin[1])
    // rust: .wrapping_add(tree_height)
    // rust: .wrapping_add(1);
    // rust: let world_min = run.world.min_y().map_err(FeatureExecutionError::Query)?;
    // rust: let world_max = run.world.max_y().map_err(FeatureExecutionError::Query)?;
    // rust: if min_y < world_min.wrapping_add(1) || max_y > world_max.wrapping_add(1) {
    // rust: return Ok(false);
}
    // rust: let clipped = self.max_free_tree_height(run, tree_height, trunk_origin)?;
    // rust: if clipped < tree_height && self.min_clipped_height.is_none_or(|min| clipped < min) {
    // rust: return Ok(false);
}
    // rust: if let Some(root) = &self.root_placer {
    // rust: if !root.place_roots(run, self, origin, trunk_origin)? {
    // rust: return Ok(false);
}
}
    // rust: let attachments = self
    // rust: .trunk_placer
    // rust: .place_trunk(run, self, clipped, trunk_origin)?;
    // rust: for attachment in attachments {
    // rust: self.foliage_placer.create_foliage(
    // rust: run,
    // rust: self,
    // rust: clipped,
    // rust: attachment,
    // rust: foliage_height,
    // rust: leaf_radius,
    // rust: )?;
}
    // rust: Ok(true)
}

    // rust: fn max_free_tree_height<W: FeatureWorld, R>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: max_tree_height: i32,
    // rust: tree_pos: [i32; 3],
    // rust: ) -> TreeResult<i32, W::Error> {
    // rust: let mut y = 0;
    // rust: while y <= max_tree_height.wrapping_add(1) {
    // rust: let r = self.minimum_size.size_at_height(max_tree_height, y);
    // rust: for x in -r..=r {
    // rust: for z in -r..=r {
    // rust: let p = tb::offset(tree_pos, x, y, z);
    // rust: let state = read(run.world, p)?;
    // rust: if !self.trunk_placer.is_free(&self.blocks, state)
    // rust: || (!self.ignore_vines && self.blocks.has(state, tb::VINE))
    // rust: {
    // rust: return Ok(y - 2);
}
}
}
    // rust: y += 1;
}
    // rust: Ok(max_tree_height)
}

    // FoliagePlacer.tryPlaceLeaf.
    // rust: pub(crate) fn try_place_leaf<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: run: &mut Run<'_, W, R>,
    // rust: position: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let here = read(run.world, position)?;
    // rust: if self.blocks.has(here, tb::PERSISTENT) || !self.blocks.valid_tree_pos(here) {
    // rust: return Ok(false);
}
    // rust: let mut state = sample_state(&self.foliage_provider, run.world, run.random, position)?;
    // rust: if self.blocks.has(state, tb::WATERLOGGABLE) {
    // rust: let here = read(run.world, position)?;
    // rust: state = self
    // rust: .blocks
    // rust: .waterlogged(state, self.blocks.has(here, tb::WATER_SOURCE));
}
    // rust: run.set(Layer::Foliage, position, state)?;
    // rust: Ok(true)
}
}

// Voxel occupancy over the tree's bounding box.
    // rust: pub(crate) struct Shape {
    // rust: size: [i32; 3],
    // rust: bits: Vec<bool>,
}
    // rust: impl Shape {
new :: proc(size: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let len = size.iter().map(|v| *v as usize).product();
    // rust: Self {
    // rust: size,
    // rust: bits: vec![false; len],
}
}
index :: proc(self: ^Self, z]: [i32; 3]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((x * self.size[1] + y) * self.size[2] + z) as usize
}
fill :: proc(self: ^Self, p: [i32; 3]) {
}
    // rust: let i = self.index(p);
    // rust: self.bits[i] = true;
}
full :: proc(self: ^Self, p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: p.iter()
    // rust: .zip(self.size)
    // rust: .all(|(v, size)| (0..size).contains(v))
    // rust: && self.bits[self.index(p)]
}
}

MAX_TREE_SPAN :: 512
inside :: proc(low: [i32; 3], high: [i32; 3], p: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0..3).all(|i| p[i] >= low[i] && p[i] <= high[i])
}

// TreeFeature.updateLeaves: native bucketed breadth-first distance pass.
    // rust: fn update_leaves<W: FeatureWorld, R>(
    // rust: run: &mut Run<'_, W, R>,
    // rust: blocks: &TreeBlocks,
    // rust: low: [i32; 3],
    // rust: high: [i32; 3],
    // rust: ) -> TreeResult<Shape, W::Error> {
    // rust: let span: [i64; 3] = std::array::from_fn(|i| i64::from(high[i]) - i64::from(low[i]) + 1);
    // rust: if span.iter().any(|s| *s > MAX_TREE_SPAN) {
    // rust: return Err(FeatureExecutionError::WorkLimit);
}
    // rust: let mut shape = Shape::new(span.map(|v| v as i32));
    // rust: let local = |p: [i32; 3]| -> [i32; 3] { std::array::from_fn(|i| p[i].wrapping_sub(low[i])) };
    // rust: let mut fixed = run.sets.decorations.to_vec();
    // rust: fixed.extend(run.sets.roots.to_vec());
    // rust: for p in fixed {
    // rust: if inside(low, high, p) {
    // rust: shape.fill(local(p));
}
}
    // rust: let mut to_check: [PosSet; 7] = Default::default();
    // rust: for p in run.sets.trunks.to_vec() {
    // rust: to_check[0].insert(p);
}
    // rust: let mut smallest = 0usize;
    // rust: loop {
    // rust: while smallest >= 7 || !to_check[smallest].is_empty() {
    // rust: if smallest >= 7 {
    // rust: return Ok(shape);
}
    // rust: let pos = to_check[smallest]
    // rust: .pop_first()
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
    // rust: if !inside(low, high, pos) {
    // rust: continue;
}
    // rust: if smallest != 0 {
    // rust: let state = read(run.world, pos)?;
    // rust: let updated = blocks
    // rust: .with(state, "distance", &smallest.to_string())
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
    // rust: write(run.world, pos, updated, 19)?;
}
    // rust: shape.fill(local(pos));
    // rust: for direction in Direction::ALL {
    // rust: let neighbor = tb::relative(pos, direction, 1);
    // rust: if !inside(low, high, neighbor) || shape.full(local(neighbor)) {
    // rust: continue;
}
    // rust: let state = read(run.world, neighbor)?;
    // rust: if let Some(distance) = blocks.leaf_distance(state) {
    // rust: let next = distance.min(smallest as i32 + 1);
    // rust: if next < 7 {
    // rust: to_check[next as usize].insert(neighbor);
    // rust: smallest = smallest.min(next as usize);
}
}
}
}
    // rust: smallest += 1;
}
}

// StructureTemplate.updateShapeAtEdge face traversal (DiscreteVoxelShape.forAllFaces).
    // rust: pub(crate) fn update_shape_at_edge<W: FeatureWorld + PlacementContext>(
    // rust: world: &mut W,
    // rust: shape: &Shape,
    // rust: start: [i32; 3],
    // rust: flags: i32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let [sx, sy, sz] = shape.size;
    // (c-axis, a size, b size, mapping (a, b, c) -> (x, y, z))
    // rust: type Map = fn(i32, i32, i32) -> [i32; 3];
    // rust: let passes: [(Direction, Direction, i32, i32, i32, Map); 3] = [
    // rust: (Direction::North, Direction::South, sx, sy, sz, |a, b, c| {
    // rust: [a, b, c]
    // rust: }),
    // rust: (Direction::Down, Direction::Up, sz, sx, sy, |a, b, c| {
    // rust: [b, c, a]
    // rust: }),
    // rust: (Direction::West, Direction::East, sy, sz, sx, |a, b, c| {
    // rust: [c, a, b]
    // rust: }),
    // rust: ];
    // rust: for (negative, positive, a_size, b_size, c_size, map) in passes {
    // rust: for a in 0..a_size {
    // rust: for b in 0..b_size {
    // rust: let mut last = false;
    // rust: for c in 0..=c_size {
    // rust: let full = c != c_size && shape.full(map(a, b, c));
    // rust: let face = if !last && full {
    // rust: Some((negative, map(a, b, c)))
    // rust: } else if last && !full {
    // rust: Some((positive, map(a, b, c - 1)))
    // rust: } else {
    // rust: None
}
    // rust: if let Some((direction, local)) = face {
    // rust: let p = std::array::from_fn(|i| start[i].wrapping_add(local[i]));
    // rust: world
    // rust: .update_shape_at_face(p, direction, flags)
    // rust: .map_err(FeatureExecutionError::Query)?;
}
    // rust: last = full;
}
}
}
}
    // rust: Ok(())
}
