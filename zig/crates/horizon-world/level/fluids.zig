//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fluids
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `FlowingFluid` (water and lava) ticking and spreading, `LiquidBlock`
//! interactions, liquid containers (waterlogging) and bucket pickup.
// use super::{
    // rust: Behaviours, Dimension, LevelAccess, Sim, Spread,
    // rust: classes::{Class, Interface},
    // rust: update::{HORIZONTAL, above, below, rel},
}
// use crate::{
    // rust: fluid::{FluidKind, FluidState},
    // rust: registry::BlockStateId,
}
// use horizon_core::{
    // rust: geometry::{Axis, Direction, ShapeOp, VoxelShape},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

/// `LiquidBlock.POSSIBLE_FLOW_DIRECTIONS`.
    // rust: const POSSIBLE_FLOW_DIRECTIONS: [Direction; 5] = [
    // rust: Direction::Down,
    // rust: Direction::South,
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::West,
    // rust: ];

pub fn is_water(kind: FluidKind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(kind, FluidKind::Water | FluidKind::FlowingWater)
}
pub fn source_of(kind: FluidKind) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if is_water(kind) {
    // rust: FluidKind::Water
    // rust: } else {
    // rust: FluidKind::Lava
}
}
pub fn flowing_of(kind: FluidKind) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if is_water(kind) {
    // rust: FluidKind::FlowingWater
    // rust: } else {
    // rust: FluidKind::FlowingLava
}
}

/// `FlowingFluid.SpreadContext`: per-spread caches keyed by horizontal offset.
/// A spread looks at most `SPREAD_REACH` blocks away on each axis (the slope
/// search's 4 steps after the first), so the caches are flat arrays around
/// the origin: no hashing and no allocation on the hot path. A position
/// outside them is read uncached.
pub const SpreadContext = struct {
    origin: BlockPos,
    states: [?BlockStateId,
    holes: [?bool,
};
pub const SPREAD_REACH: i32 = 5;
pub const SPREAD_SIDE: i32 = 2 * SPREAD_REACH + 1;
pub const SPREAD_CELLS: usize = (SPREAD_SIDE * SPREAD_SIDE) ;
    // rust: impl SpreadContext {
pub fn new(origin: BlockPos) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: origin,
    // rust: states: [None; SPREAD_CELLS],
    // rust: holes: [None; SPREAD_CELLS],
}
}
pub fn index(self: *Self, pos: BlockPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = pos.x.wrapping_sub(self.origin.x) + SPREAD_REACH;
    // rust: let z = pos.z.wrapping_sub(self.origin.z) + SPREAD_REACH;
    // rust: ((0..SPREAD_SIDE).contains(&x) && (0..SPREAD_SIDE).contains(&z))
    // rust: .then(|| (x * SPREAD_SIDE + z) as usize)
}
}

    // rust: impl Behaviours {
    /// `state.getBlock() instanceof LiquidBlockContainer`: a block that keeps
    /// a fluid inside its own state (`SimpleWaterloggedBlock` extends the
    /// interface, so stairs, slabs and every other waterloggable block count).
pub fn is_liquid_container(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.implements(state, Interface::LiquidBlockContainer)
    // rust: || self.implements(state, Interface::SimpleWaterlogged)
}
    /// `LiquidBlockContainer.canPlaceLiquid(user, level, pos, state, fluid)`
    /// for a liquid container: `creative` is whether `user` is a creative
    /// player (a bucket in creative mode); a dispenser or a flowing fluid
    /// passes none (`false`).
pub fn can_place_liquid(self: *Self, state: BlockStateId, fluid: FluidKind, creative: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = self.data(state);
    // rust: if data.is(Class::Kelp)
    // rust: || data.is(Class::KelpPlant)
    // rust: || data.is(Class::Seagrass)
    // rust: || data.is(Class::TallSeagrass)
    // rust: {
    // rust: return false;
}
        // `BarrierBlock.canPlaceLiquid`: only a creative player may waterlog.
    // rust: if data.is(Class::Barrier) && !creative {
    // rust: return false;
}
    // rust: if data.is(Class::Slab) && self.table.text(state, self.props.kind) == "double" {
    // rust: return false;
}
    // rust: fluid == FluidKind::Water
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
pub fn fast_lava(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level.dimension() == Dimension::Nether
}
    /// `Fluid.getTickDelay`.
    // rust: pub(crate) fn fluid_tick_delay(&self, kind: FluidKind) -> i32 {
    // rust: match kind {
    // rust: FluidKind::Empty => 0,
    // rust: FluidKind::Water | FluidKind::FlowingWater => 5,
    // rust: _ => {
    // rust: if self.fast_lava() {
    // rust: 10
    // rust: } else {
    // rust: 30
}
}
}
}
pub fn drop_off(self: *Self, kind: FluidKind) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if is_water(kind) || self.fast_lava() {
    // rust: 1
    // rust: } else {
    // rust: 2
}
}
pub fn slope_find_distance(self: *Self, kind: FluidKind) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if is_water(kind) || self.fast_lava() {
    // rust: 4
    // rust: } else {
    // rust: 2
}
}
pub fn can_convert_to_source(self: *Self, kind: FluidKind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rules = self.level.game_rules();
    // rust: if is_water(kind) {
    // rust: rules.water_source_conversion
    // rust: } else {
    // rust: rules.lava_source_conversion
}
}
pub fn fluid_height(self: *Self, fluid: FluidState, pos: BlockPos) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if fluid.kind() == FluidKind::Empty {
    // rust: return 0.0;
}
    // rust: if fluid.kind().same_family(self.fluid_at(above(pos)).kind()) {
    // rust: 1.0
    // rust: } else {
    // rust: fluid.own_height()
}
}
    /// `FluidState.canBeReplacedWith(level, pos, other, direction)`.
    // rust: fn can_be_replaced_with(
    // rust: &self,
    // rust: fluid: FluidState,
    // rust: pos: BlockPos,
    // rust: other: FluidKind,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: match fluid.kind() {
    // rust: FluidKind::Empty => true,
    // rust: FluidKind::Water | FluidKind::FlowingWater => {
    // rust: direction == Direction::Down && !is_water(other)
}
    // rust: _ => self.fluid_height(fluid, pos) >= 0.444_444_45 && is_water(other),
}
}

    // ---- shape occlusion ----

pub fn collision_or_empty(self: *Self, state: BlockStateId) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = self.b.facts(state).shape;
    // rust: match self.b.collision_shape(state) {
    // rust: Some(shape) => (index, shape),
    // rust: None => (-1, VoxelShape::empty_ref()),
}
}
    /// `FlowingFluid.canPassThroughWall`.
    // rust: fn can_pass_through_wall(
    // rust: &self,
    // rust: direction: Direction,
    // rust: source: BlockStateId,
    // rust: target: BlockStateId,
    // rust: ) -> bool {
        // The shapes are compared by identity and borrowed, never cloned: a
        // clone of the shared block or empty shape is atomic reference counts
        // every thread contends on, and this runs for every step of a spread.
    // rust: let (target_index, target_shape) = self.collision_or_empty(target);
    // rust: if target_shape.is_block() {
    // rust: return false;
}
    // rust: let (source_index, source_shape) = self.collision_or_empty(source);
    // rust: if source_shape.is_block() {
    // rust: return false;
}
    // rust: if source_shape.is_empty_identity() && target_shape.is_empty_identity() {
    // rust: return true;
}
    // rust: let cacheable = source_index >= 0 && target_index >= 0;
    // rust: let key = (source_index, target_index, direction as u8);
    // rust: if cacheable
    // rust: && let Some(result) = self
    // rust: .b
    // rust: .occlusion_cache
    // rust: .read()
    // rust: .ok()
    // rust: .and_then(|cache| cache.get(&key).copied())
    // rust: {
    // rust: return result;
}
    // rust: let result = !merged_face_occludes(source_shape, target_shape, direction);
    // rust: if cacheable && let Ok(mut cache) = self.b.occlusion_cache.write() {
    // rust: cache.insert(key, result);
}
    // rust: result
}

    // ---- liquid containers ----

    /// `LiquidBlockContainer` membership (`canHoldAnyFluid` first clause).
    // rust: pub(super) fn is_liquid_container(&self, state: BlockStateId) -> bool {
    // rust: self.b.is_liquid_container(state)
}
    /// `LiquidBlockContainer.canPlaceLiquid` (`Behaviours::can_place_liquid`).
    // rust: pub(crate) fn can_place_liquid(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: fluid: FluidKind,
    // rust: creative: bool,
    // rust: ) -> bool {
    // rust: self.b.can_place_liquid(state, fluid, creative)
}
    /// `LiquidBlockContainer.placeLiquid`.
    // rust: pub(crate) fn place_liquid(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: fluid: FluidState,
    // rust: creative: bool,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: if !self.can_place_liquid(state, fluid.kind(), creative)
    // rust: || fluid.kind() != FluidKind::Water
    // rust: || !b.table.has(state, b.props.waterlogged)
    // rust: {
    // rust: return false;
}
    // rust: if b.is_waterlogged(state) {
    // rust: return false;
}
    // rust: let mut next = b.table.set_bool(state, b.props.waterlogged, true);
    // rust: let data = b.data(state);
    // rust: if (data.is(Class::Candle) || data.is(Class::Campfire)) && b.table.bool(state, b.props.lit)
    // rust: {
    // rust: next = b.table.set_bool(next, b.props.lit, false);
    // rust: if data.is(Class::Campfire) {
    // rust: self.emit(super::LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:entity.generic.extinguish_fire".into(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
    // rust: } else {
    // rust: self.emit(super::LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.candle.extinguish".into(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
}
}
    // rust: self.set_block_and_update(pos, next);
    // rust: let delay = self.fluid_tick_delay(fluid.kind());
    // rust: self.schedule_fluid_tick(pos, fluid.kind(), delay);
        // DriedGhastBlock.placeLiquid: its own place-in-water sound.
    // rust: if data.is(Class::DriedGhast) {
    // rust: self.emit(super::LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.dried_ghast.place_in_water".into(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
}
    // rust: true
}
    /// `BucketPickup.pickupBlock`: true when a fluid was taken.
    // rust: pub(crate) fn pickup_block(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: creative: bool,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::Liquid) {
    // rust: if b.table.int(state, b.props.level) == 0 {
    // rust: self.set_block(pos, b.air(), 11);
    // rust: return true;
}
    // rust: return false;
}
    // rust: if b.implements(state, Interface::SimpleWaterlogged)
    // rust: && b.table.has(state, b.props.waterlogged)
    // rust: {
            // `BarrierBlock.pickupBlock`: only a creative player drains one.
    // rust: if b.instance_of(state, Class::Barrier) && !creative {
    // rust: return false;
}
    // rust: if b.is_waterlogged(state) {
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, b.props.waterlogged, false));
    // rust: if !self.can_survive(state, pos) {
    // rust: self.destroy_block(pos, true, 512);
}
    // rust: return true;
}
    // rust: return false;
}
    // rust: if b.is_block(state, b.named.bubble_column) {
            // BubbleColumnBlock.pickupBlock: the column is removed, the bucket is water.
    // rust: self.set_block(pos, b.air(), 11);
    // rust: return true;
}
    // rust: if b.is_block(state, b.named.powder_snow) {
            // PowderSnowBlock.pickupBlock: the block breaks with its particles and sound.
    // rust: self.set_block(pos, b.air(), 11);
    // rust: self.level_event(2001, pos, state.0 as i32);
    // rust: return true;
}
    // rust: false
}
pub fn can_hold_any_fluid(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_liquid_container(state) || self.b.in_set(state, &self.b.tags.washed_away_by_fluids)
}
pub fn can_hold_specific_fluid(self: *Self, state: BlockStateId, fluid: FluidKind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_liquid_container(state) {
    // rust: self.can_place_liquid(state, fluid, false)
    // rust: } else {
    // rust: true
}
}
pub fn can_hold_fluid(self: *Self, state: BlockStateId, fluid: FluidKind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.can_hold_any_fluid(state) && self.can_hold_specific_fluid(state, fluid)
}

    // ---- FlowingFluid ----

pub fn is_source_of(self: *Self, kind: FluidKind, fluid: FluidState) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fluid.kind().same_family(kind) && fluid.is_source()
}
    /// `FlowingFluid.getNewLiquid`.
pub fn new_liquid(self: *Self, kind: FluidKind, pos: BlockPos, state: BlockStateId) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let mut highest = 0;
    // rust: let mut sources = 0;
    // rust: for direction in HORIZONTAL {
    // rust: let neighbour = self.rel_state(pos, direction);
    // rust: let fluid = b.fluid(neighbour);
    // rust: if fluid.kind().same_family(kind)
    // rust: && self.can_pass_through_wall(direction, state, neighbour)
    // rust: {
    // rust: if fluid.is_source() {
    // rust: sources += 1;
}
    // rust: highest = highest.max(i32::from(fluid.amount()));
}
}
    // rust: if sources >= 2 && self.can_convert_to_source(kind) {
    // rust: let below_state = self.below_state(pos);
    // rust: if b.is_solid(below_state) || self.is_source_of(kind, b.fluid(below_state)) {
    // rust: return FluidState::new(source_of(kind), 8, false);
}
}
    // rust: let above_state = self.above_state(pos);
    // rust: let above_fluid = b.fluid(above_state);
    // rust: if above_fluid.kind() != FluidKind::Empty
    // rust: && above_fluid.kind().same_family(kind)
    // rust: && self.can_pass_through_wall(Direction::Up, state, above_state)
    // rust: {
    // rust: return FluidState::new(flowing_of(kind), 8, true);
}
    // rust: let amount = highest - self.drop_off(kind);
    // rust: if amount <= 0 {
    // rust: FluidState::EMPTY
    // rust: } else {
    // rust: FluidState::new(flowing_of(kind), amount as u8, false)
}
}
pub fn is_water_hole(self: *Self, kind: FluidKind, top: BlockStateId, bottom: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.can_pass_through_wall(Direction::Down, top, bottom) {
    // rust: return false;
}
    // rust: if self.b.fluid(bottom).kind().same_family(kind) {
    // rust: true
    // rust: } else {
    // rust: self.can_hold_fluid(bottom, flowing_of(kind))
}
}
    // rust: fn can_maybe_pass_through(
    // rust: &self,
    // rust: kind: FluidKind,
    // rust: source: BlockStateId,
    // rust: direction: Direction,
    // rust: test: BlockStateId,
    // rust: test_fluid: FluidState,
    // rust: ) -> bool {
    // rust: !self.is_source_of(kind, test_fluid)
    // rust: && self.can_hold_any_fluid(test)
    // rust: && self.can_pass_through_wall(direction, source, test)
}
    // rust: fn can_pass_through(
    // rust: &self,
    // rust: kind: FluidKind,
    // rust: source: BlockStateId,
    // rust: direction: Direction,
    // rust: test: BlockStateId,
    // rust: test_fluid: FluidState,
    // rust: ) -> bool {
    // rust: self.can_maybe_pass_through(kind, source, direction, test, test_fluid)
    // rust: && self.can_hold_specific_fluid(test, flowing_of(kind))
}
pub fn context_state(self: *Self, context: *mut SpreadContext, pos: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(i) = context.index(pos) else {
    // rust: return self.state(pos);
}
    // rust: if let Some(state) = context.states[i] {
    // rust: return state;
}
    // rust: let state = self.state(pos);
    // rust: context.states[i] = Some(state);
    // rust: state
}
pub fn context_is_hole(self: *Self, kind: FluidKind, context: *mut SpreadContext, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let index = context.index(pos);
    // rust: if let Some(hole) = index.and_then(|i| context.holes[i]) {
    // rust: return hole;
}
    // rust: let state = self.context_state(context, pos);
    // rust: let below_state = self.below_state(pos);
    // rust: let hole = self.is_water_hole(kind, state, below_state);
    // rust: if let Some(i) = index {
    // rust: context.holes[i] = Some(hole);
}
    // rust: hole
}
    // rust: fn slope_distance(
    // rust: &self,
    // rust: kind: FluidKind,
    // rust: pos: BlockPos,
    // rust: pass: i32,
    // rust: from: Direction,
    // rust: state: BlockStateId,
    // rust: context: &mut SpreadContext,
    // rust: ) -> i32 {
    // rust: let mut lowest = 1000;
    // rust: for direction in HORIZONTAL {
    // rust: if direction == from {
    // rust: continue;
}
    // rust: let test_pos = rel(pos, direction);
    // rust: let test_state = self.context_state(context, test_pos);
    // rust: let test_fluid = self.b.fluid(test_state);
    // rust: if self.can_pass_through(kind, state, direction, test_state, test_fluid) {
    // rust: if self.context_is_hole(kind, context, test_pos) {
    // rust: return pass;
}
    // rust: if pass < self.slope_find_distance(kind) {
    // rust: let distance = self.slope_distance(
    // rust: kind,
    // rust: test_pos,
    // rust: pass + 1,
    // rust: direction.opposite(),
    // rust: test_state,
    // rust: context,
    // rust: );
    // rust: lowest = lowest.min(distance);
}
}
}
    // rust: lowest
}
    /// `FlowingFluid.getSpread` (EnumMap: iteration in Direction order).
    // rust: fn spread_targets(
    // rust: &self,
    // rust: kind: FluidKind,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> Vec<(Direction, FluidState)> {
    // rust: let mut lowest = 1000;
    // rust: let mut result: Vec<(Direction, FluidState)> = Vec::new();
    // rust: let mut context: Option<SpreadContext> = None;
    // rust: for direction in HORIZONTAL {
    // rust: let test_pos = rel(pos, direction);
    // rust: let test_state = self.state(test_pos);
    // rust: let test_fluid = self.b.fluid(test_state);
    // rust: if !self.can_maybe_pass_through(kind, state, direction, test_state, test_fluid) {
    // rust: continue;
}
    // rust: let new_fluid = self.new_liquid(kind, test_pos, test_state);
    // rust: if !self.can_hold_specific_fluid(test_state, new_fluid.kind()) {
    // rust: continue;
}
    // rust: let context = context.get_or_insert_with(|| SpreadContext::new(pos));
    // rust: let distance = if self.context_is_hole(kind, context, test_pos) {
    // rust: 0
    // rust: } else {
    // rust: self.slope_distance(kind, test_pos, 1, direction.opposite(), test_state, context)
}
    // rust: if distance < lowest {
    // rust: result.clear();
}
    // rust: if distance <= lowest {
    // rust: if self.can_be_replaced_with(test_fluid, test_pos, new_fluid.kind(), direction) {
    // rust: result.push((direction, new_fluid));
}
    // rust: lowest = distance;
}
}
    // rust: result.sort_by_key(|(direction, _)| *direction as u8);
    // rust: result
}
pub fn source_neighbour_count(self: *Self, kind: FluidKind, pos: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HORIZONTAL
    // rust: .into_iter()
    // rust: .filter(|d| self.is_source_of(kind, self.fluid_at(rel(pos, *d))))
    // rust: .count() as i32
}
    /// `FlowingFluid.spreadTo` (with LavaFluid's water-to-stone override).
    // rust: fn spread_to(
    // rust: &mut self,
    // rust: kind: FluidKind,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: direction: Direction,
    // rust: target: FluidState,
    // rust: ) {
    // rust: let b = self.b;
    // rust: if !self
    // rust: .level
    // rust: .allow_spread(Spread::Fluid, rel(pos, direction.opposite()), pos)
    // rust: {
    // rust: return;
}
    // rust: if !is_water(kind)
    // rust: && direction == Direction::Down
    // rust: && b.is_water_fluid(self.fluid_at(pos).kind())
    // rust: {
    // rust: if b.instance_of(state, Class::Liquid) {
    // rust: self.set_block_and_update(pos, b.default_of(b.named.stone));
}
    // rust: self.level_event(1501, pos, 0);
    // rust: return;
}
    // rust: if self.is_liquid_container(state) {
    // rust: self.place_liquid(pos, state, target, false);
    // rust: } else {
    // rust: if !b.is_air(state) {
    // rust: if is_water(kind) {
    // rust: self.drop_resources(state, pos);
    // rust: } else {
    // rust: self.level_event(1501, pos, 0);
}
}
    // rust: let legacy = b.legacy_block(target);
    // rust: self.set_block_and_update(pos, legacy);
}
}
    // rust: fn spread_to_sides(
    // rust: &mut self,
    // rust: kind: FluidKind,
    // rust: pos: BlockPos,
    // rust: fluid: FluidState,
    // rust: state: BlockStateId,
    // rust: ) {
    // rust: let mut neighbour = i32::from(fluid.amount()) - self.drop_off(kind);
    // rust: if fluid.falling() {
    // rust: neighbour = 7;
}
    // rust: if neighbour > 0 {
    // rust: for (direction, new_fluid) in self.spread_targets(kind, pos, state) {
    // rust: let neighbour_pos = rel(pos, direction);
    // rust: let neighbour_state = self.state(neighbour_pos);
    // rust: self.spread_to(kind, neighbour_pos, neighbour_state, direction, new_fluid);
}
}
}
    /// `FlowingFluid.spread`.
pub fn spread(self: *Self, kind: FluidKind, pos: BlockPos, state: BlockStateId, fluid: FluidState) void {
}
    // rust: if fluid.kind() == FluidKind::Empty {
    // rust: return;
}
    // rust: let below_pos = below(pos);
    // rust: let below_state = self.state(below_pos);
    // rust: let below_fluid = self.b.fluid(below_state);
    // rust: if self.can_maybe_pass_through(kind, state, Direction::Down, below_state, below_fluid) {
    // rust: let new_below = self.new_liquid(kind, below_pos, below_state);
    // rust: if self.can_be_replaced_with(below_fluid, below_pos, new_below.kind(), Direction::Down)
    // rust: && self.can_hold_specific_fluid(below_state, new_below.kind())
    // rust: {
    // rust: self.spread_to(kind, below_pos, below_state, Direction::Down, new_below);
    // rust: if self.source_neighbour_count(kind, pos) >= 3 {
    // rust: self.spread_to_sides(kind, pos, fluid, state);
}
    // rust: return;
}
}
    // rust: if fluid.is_source() || !self.is_water_hole(kind, state, below_state) {
    // rust: self.spread_to_sides(kind, pos, fluid, state);
}
}
    /// `FlowingFluid.tick` for the fluid at `pos`.
    // rust: pub(crate) fn fluid_tick(&mut self, pos: BlockPos) {
    // rust: let mut state = self.state(pos);
    // rust: let mut fluid = self.b.fluid(state);
    // rust: let kind = fluid.kind();
    // rust: if kind == FluidKind::Empty {
    // rust: return;
}
    // rust: if !fluid.is_source() {
    // rust: let new_fluid = self.new_liquid(kind, pos, state);
    // rust: let delay = self.spread_delay(kind, pos, fluid, new_fluid);
    // rust: if new_fluid != fluid {
    // rust: let name = match kind {
    // rust: FluidKind::Water | FluidKind::FlowingWater => "water",
    // rust: FluidKind::Lava | FluidKind::FlowingLava => "lava",
    // rust: FluidKind::Empty => return,
}
    // rust: if !self.level.allow_fluid_level_change(
    // rust: pos,
    // rust: name,
    // rust: i32::from(fluid.amount()),
    // rust: i32::from(new_fluid.amount()),
    // rust: ) {
    // rust: return;
}
}
    // rust: if new_fluid.kind() == FluidKind::Empty {
    // rust: fluid = new_fluid;
    // rust: state = self.b.air();
    // rust: self.set_block_and_update(pos, state);
    // rust: } else if new_fluid != fluid {
    // rust: fluid = new_fluid;
    // rust: state = self.b.legacy_block(fluid);
    // rust: self.set_block_and_update(pos, state);
    // rust: self.schedule_fluid_tick(pos, fluid.kind(), delay);
}
}
    // rust: self.spread(kind, pos, state, fluid);
}
    // rust: fn spread_delay(
    // rust: &mut self,
    // rust: kind: FluidKind,
    // rust: pos: BlockPos,
    // rust: old: FluidState,
    // rust: new: FluidState,
    // rust: ) -> i32 {
    // rust: let delay = self.fluid_tick_delay(kind);
    // rust: if is_water(kind) {
    // rust: return delay;
}
    // rust: if old.kind() != FluidKind::Empty
    // rust: && new.kind() != FluidKind::Empty
    // rust: && !old.falling()
    // rust: && !new.falling()
    // rust: && self.fluid_height(new, pos) > self.fluid_height(old, pos)
    // rust: && self.random().next_int_bound(4).unwrap_or(0) != 0
    // rust: {
    // rust: delay * 4
    // rust: } else {
    // rust: delay
}
}

    // ---- LiquidBlock ----

    /// `LiquidBlock.shouldSpreadLiquid`, including lava's conversions.
    // rust: pub(crate) fn should_spread_liquid(&mut self, pos: BlockPos, state: BlockStateId) -> bool {
    // rust: let b = self.b;
    // rust: if !b.is_lava_fluid(b.fluid(state).kind()) {
    // rust: return true;
}
    // rust: let over_soul_soil = b.is_block(self.below_state(pos), b.named.soul_soil);
    // rust: for direction in POSSIBLE_FLOW_DIRECTIONS {
    // rust: let neighbour = rel(pos, direction.opposite());
    // rust: if b.is_water_fluid(self.fluid_at(neighbour).kind()) {
    // rust: let block = if self.fluid_at(pos).is_source() {
    // rust: b.named.obsidian
    // rust: } else {
    // rust: b.named.cobblestone
}
    // rust: self.set_block_and_update(pos, b.default_of(block));
    // rust: self.level_event(1501, pos, 0);
    // rust: return false;
}
    // rust: if over_soul_soil && b.is_block(self.state(neighbour), b.named.blue_ice) {
    // rust: self.set_block_and_update(pos, b.default_of(b.named.basalt));
    // rust: self.level_event(1501, pos, 0);
    // rust: return false;
}
}
    // rust: true
}
    /// `LiquidBlock.onPlace` / `neighborChanged`.
    // rust: pub(crate) fn liquid_block_changed(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: if self.should_spread_liquid(pos, state) {
    // rust: let kind = self.b.fluid(state).kind();
    // rust: let delay = self.fluid_tick_delay(kind);
    // rust: self.schedule_fluid_tick(pos, kind, delay);
}
    // rust: if self.should_bubble_column_occupy(state) {
    // rust: let below_state = self.below_state(pos);
    // rust: let block = self.b.block(state);
    // rust: self.try_schedule_bubble_column(pos, below_state, block);
}
}

    /// `LavaFluid.randomTick`.
    // rust: pub(crate) fn lava_random_tick(&mut self, pos: BlockPos) {
    // rust: if !self.level.can_spread_fire_around(pos) {
    // rust: return;
}
    // rust: let passes = self.random().next_int_bound(3).unwrap_or(0);
    // rust: if passes > 0 {
    // rust: let mut test = pos;
    // rust: for _ in 0..passes {
    // rust: let dx = self.random().next_int_bound(3).unwrap_or(0) - 1;
    // rust: let dz = self.random().next_int_bound(3).unwrap_or(0) - 1;
    // rust: test = test.offset(dx, 1, dz);
    // rust: if !self.level.is_loaded(test) {
    // rust: return;
}
    // rust: let state = self.state(test);
    // rust: if self.b.is_air(state) {
    // rust: if Direction::ALL
    // rust: .into_iter()
    // rust: .any(|d| self.lava_flammable(rel(test, d)))
    // rust: {
    // rust: if !self.level.allow_block_ignite(test, "lava") {
    // rust: return;
}
    // rust: let fire = self.fire_state_for(test);
    // rust: self.set_block_and_update(test, fire);
    // rust: return;
}
    // rust: } else if self
    // rust: .b
    // rust: .tag("minecraft:blocks_lava_fire_spread")
    // rust: .is_some_and(|tag| self.b.in_set(state, tag))
    // rust: {
    // rust: return;
}
}
    // rust: } else {
    // rust: for _ in 0..3 {
    // rust: let dx = self.random().next_int_bound(3).unwrap_or(0) - 1;
    // rust: let dz = self.random().next_int_bound(3).unwrap_or(0) - 1;
    // rust: let test = pos.offset(dx, 0, dz);
    // rust: if !self.level.is_loaded(test) {
    // rust: return;
}
    // rust: if self.is_empty_block(above(test)) && self.lava_flammable(test) {
    // rust: if !self.level.allow_block_ignite(above(test), "lava") {
    // rust: continue;
}
    // rust: let fire = self.fire_state_for(test);
    // rust: self.set_block_and_update(above(test), fire);
}
}
}
}
pub fn lava_flammable(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.is_inside_build_height(pos.y) && !self.level.is_loaded(pos) {
    // rust: return false;
}
    // rust: self.b
    // rust: .has_flag(self.state(pos), super::data::state_flags::IGNITED_BY_LAVA)
}
}

/// `Shapes.mergedFaceOccludes(shape, occluder, direction)`.
    // rust: pub(crate) fn merged_face_occludes(
    // rust: shape: &VoxelShape,
    // rust: occluder: &VoxelShape,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: let block = VoxelShape::block();
    // rust: if shape.is_block() || occluder.is_block() {
    // rust: return true;
}
    // rust: let positive = matches!(
    // rust: direction,
    // rust: Direction::Up | Direction::South | Direction::East
    // rust: );
    // rust: let axis = match direction {
    // rust: Direction::West | Direction::East => Axis::X,
    // rust: Direction::Down | Direction::Up => Axis::Y,
    // rust: _ => Axis::Z,
}
    // rust: let (first, second) = if positive {
    // rust: (shape, occluder)
    // rust: } else {
    // rust: (occluder, shape)
}
    // rust: let max_face = match axis {
    // rust: Axis::X => Direction::East,
    // rust: Axis::Y => Direction::Up,
    // rust: Axis::Z => Direction::South,
}
    // rust: let empty = VoxelShape::empty();
    // SliceShape(first, axis, last layer) / SliceShape(second, axis, 0): the face
    // shapes sample the same boundary layers when the shapes touch the face.
    // rust: let first_slice = if !first.is_empty() && (first.max(axis) - 1.0).abs() <= 1.0e-7 {
    // rust: first.face_shape(max_face).unwrap_or_else(|_| empty.clone())
    // rust: } else {
    // rust: empty.clone()
}
    // rust: let second_slice = if !second.is_empty() && second.min(axis).abs() <= 1.0e-7 {
    // rust: second
    // rust: .face_shape(max_face.opposite())
    // rust: .unwrap_or_else(|_| empty.clone())
    // rust: } else {
    // rust: empty.clone()
}
    // rust: let union = match first_slice.join(&second_slice, ShapeOp::OR) {
    // rust: Ok(shape) => shape,
    // rust: Err(_) => return false,
}
    // rust: !block
    // rust: .join_is_not_empty(&union, ShapeOp::ONLY_FIRST)
    // rust: .unwrap_or(true)
}
