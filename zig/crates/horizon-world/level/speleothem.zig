//! Transpiled from Horizon Rust crate
//! Module: horizon-world_speleothem
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `SpeleothemBlock` growth (pointed dripstone, sulfur spikes) and
//! `PointedDripstoneBlock` fluid transfer into cauldrons and mud.
// use super::{
    // rust: LevelAccess, Sim,
    // rust: classes::Class,
    // rust: states::BlockId,
    // rust: update::{above, below, rel},
}
// use crate::{fluid::FluidKind, registry::BlockStateId};
// use horizon_core::{geometry::Direction, position::BlockPos, random::RandomSource};

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
pub fn speleothem_tag(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.b
    // rust: .tag("minecraft:speleothems")
    // rust: .is_some_and(|tag| self.b.in_set(state, tag))
}
pub fn speleothem_with(self: *Self, state: BlockStateId, direction: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.speleothem_tag(state)
    // rust: && self.b.table.dir(state, self.b.props.vertical_direction) == Some(direction)
}
pub fn speleothem_is_tip(self: *Self, state: BlockStateId, include_merged: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.speleothem_tag(state) {
    // rust: return false;
}
    // rust: let thickness = self.b.table.text(state, self.b.props.thickness);
    // rust: thickness == "tip" || (include_merged && thickness == "tip_merge")
}
pub fn is_free_hanging_stalactite(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.speleothem_with(state, Direction::Down)
    // rust: && self.b.table.text(state, self.b.props.thickness) == "tip"
    // rust: && !self.b.is_waterlogged(state)
}
    /// `SpeleothemBlock.findBlockVertical`.
    // rust: fn find_block_vertical(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: up: bool,
    // rust: path: impl Fn(&Self, BlockPos, BlockStateId) -> bool,
    // rust: target: impl Fn(&Self, BlockStateId) -> bool,
    // rust: max_steps: i32,
    // rust: ) -> Option<BlockPos> {
    // rust: let mut current = pos;
    // rust: for _ in 1..max_steps {
    // rust: current = if up { above(current) } else { below(current) };
    // rust: let state = self.state(current);
    // rust: if target(self, state) {
    // rust: return Some(current);
}
    // rust: if !self.is_inside_build_height(current.y) || !path(self, current, state) {
    // rust: return None;
}
}
    // rust: None
}
    // rust: fn speleothem_find_tip(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: max: i32,
    // rust: include_merged: bool,
    // rust: ) -> Option<BlockPos> {
    // rust: if self.speleothem_is_tip(state, include_merged) {
    // rust: return Some(pos);
}
    // rust: let b = self.b;
    // rust: let direction = b
    // rust: .table
    // rust: .dir(state, b.props.vertical_direction)
    // rust: .unwrap_or(Direction::Up);
    // rust: let block = b.block(state);
    // rust: self.find_block_vertical(
    // rust: pos,
    // rust: direction == Direction::Up,
    // rust: |sim, _, s| {
    // rust: sim.b.is_block(s, block)
    // rust: && sim.b.table.dir(s, sim.b.props.vertical_direction) == Some(direction)
    // rust: },
    // rust: |sim, s| sim.speleothem_is_tip(s, include_merged),
    // rust: max,
    // rust: )
}
    /// `SpeleothemBlock.randomTick` (+ `PointedDripstoneBlock.maybeTransferFluid`).
    // rust: pub(crate) fn speleothem_random_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::PointedDripstone) {
    // rust: let value = self.random().next_float();
    // rust: self.dripstone_transfer_fluid(state, pos, value);
}
    // rust: let start = self.speleothem_with(state, Direction::Down)
    // rust: && !b.is_block(self.above_state(pos), b.block(state));
    // rust: if self.random().next_float() < 0.011_377_778 && start {
    // rust: self.speleothem_grow(state, pos);
}
}
pub fn speleothem_grow(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: let data = b.data(state);
    // rust: let mut can_grow = data
    // rust: .link
    // rust: .is_some_and(|grow_on| b.is_block(self.above_state(pos), grow_on));
    // rust: if data.is(Class::PointedDripstone) {
    // rust: let fluid = b.fluid(self.state(pos.offset(0, 2, 0)));
    // rust: can_grow &= fluid.kind() == FluidKind::Water;
}
    // rust: if !can_grow {
    // rust: return;
}
    // rust: let max = if data.is(Class::SulfurSpike) { 2 } else { 7 };
    // rust: let Some(tip_pos) = self.speleothem_find_tip(state, pos, max, false) else {
    // rust: return;
}
    // rust: let tip = self.state(tip_pos);
    // rust: if self.is_free_hanging_stalactite(tip) && self.speleothem_can_tip_grow(block, tip, tip_pos)
    // rust: {
    // rust: if self.random().next_boolean() {
    // rust: self.speleothem_grow_to(block, tip_pos, Direction::Down);
    // rust: } else {
    // rust: self.speleothem_grow_stalagmite_below(block, tip_pos);
}
}
}
    // rust: fn speleothem_unmerged_tip(
    // rust: &self,
    // rust: block: BlockId,
    // rust: state: BlockStateId,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: self.speleothem_is_tip(state, false)
    // rust: && self.b.table.dir(state, self.b.props.vertical_direction) == Some(direction)
    // rust: && self.b.is_block(state, block)
}
    // rust: fn speleothem_can_tip_grow(
    // rust: &self,
    // rust: block: BlockId,
    // rust: tip: BlockStateId,
    // rust: tip_pos: BlockPos,
    // rust: ) -> bool {
    // rust: let direction = self
    // rust: .b
    // rust: .table
    // rust: .dir(tip, self.b.props.vertical_direction)
    // rust: .unwrap_or(Direction::Up);
    // rust: let grow = self.rel_state(tip_pos, direction);
    // rust: if self.b.fluid(grow).kind() != FluidKind::Empty {
    // rust: false
    // rust: } else {
    // rust: self.b.is_air(grow) || self.speleothem_unmerged_tip(block, grow, direction.opposite())
}
}
    // rust: fn speleothem_create(
    // rust: &mut self,
    // rust: block: BlockId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: thickness: &str,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let state = b
    // rust: .table
    // rust: .set_dir(b.default_of(block), b.props.vertical_direction, direction);
    // rust: let state = b.table.set_text(state, b.props.thickness, thickness);
    // rust: let water = self.fluid_at(pos) == crate::fluid::FluidState::WATER
    // rust: || self.fluid_at(pos).kind() == FluidKind::Water;
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, b.props.waterlogged, water));
}
pub fn speleothem_grow_to(self: *Self, block: BlockId, from: BlockPos, direction: Direction) void {
}
    // rust: let b = self.b;
    // rust: let target = rel(from, direction);
    // rust: let existing = self.state(target);
    // rust: if self.speleothem_unmerged_tip(block, existing, direction.opposite()) {
    // rust: let (stalactite, stalagmite) =
    // rust: if b.table.dir(existing, b.props.vertical_direction) == Some(Direction::Up) {
    // rust: (above(target), target)
    // rust: } else {
    // rust: (target, below(target))
}
    // rust: self.speleothem_create(block, stalactite, Direction::Down, "tip_merge");
    // rust: self.speleothem_create(block, stalagmite, Direction::Up, "tip_merge");
    // rust: } else if b.is_air(existing) || b.is_block(existing, b.named.water) {
    // rust: self.speleothem_create(block, target, direction, "tip");
}
}
pub fn speleothem_grow_stalagmite_below(self: *Self, block: BlockId, from: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let mut pos = from;
    // rust: for _ in 0..10 {
    // rust: pos = below(pos);
    // rust: let state = self.state(pos);
    // rust: if b.fluid(state).kind() != FluidKind::Empty {
    // rust: return;
}
    // rust: if self.speleothem_unmerged_tip(block, state, Direction::Up)
    // rust: && self.speleothem_can_tip_grow(block, state, pos)
    // rust: {
    // rust: self.speleothem_grow_to(block, pos, Direction::Up);
    // rust: return;
}
    // rust: if self.is_valid_speleothem_placement(block, pos, Direction::Up)
    // rust: && !self.is_water_at(below(pos))
    // rust: {
    // rust: self.speleothem_grow_to(block, below(pos), Direction::Up);
    // rust: return;
}
    // rust: if b.data(b.default_of(block)).is(Class::PointedDripstone)
    // rust: && !self.dripstone_can_drip_through(state)
    // rust: {
    // rust: return;
}
}
}
    /// `PointedDripstoneBlock.canDripThrough`.
pub fn dripstone_can_drip_through(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: if b.is_air(state) {
    // rust: return true;
}
    // rust: if b.solid_render(state) || b.fluid(state).kind() != FluidKind::Empty {
    // rust: return false;
}
        // REQUIRED_SPACE_TO_DRIP_THROUGH_NON_SOLID_BLOCK = column(4, 0, 16).
    // rust: match b.collision_shape(state) {
    // rust: None => true,
    // rust: Some(shape) => {
    // rust: let column = horizon_core::geometry::VoxelShape::from_box(
    // rust: horizon_core::geometry::Aabb::new(
    // rust: horizon_core::geometry::Vec3::new(0.375, 0.0, 0.375),
    // rust: horizon_core::geometry::Vec3::new(0.625, 1.0, 0.625),
    // rust: ),
    // rust: );
    // rust: column.is_ok_and(|column| {
    // rust: !column
    // rust: .join_is_not_empty(shape, horizon_core::geometry::ShapeOp::AND)
    // rust: .unwrap_or(true)
    // rust: })
}
}
}
    /// `PointedDripstoneBlock.getFluidAboveStalactite`: (position above the
    /// root, fluid, state there).
    // rust: fn dripstone_fluid_above(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: ) -> Option<(BlockPos, FluidKind, BlockStateId)> {
    // rust: let b = self.b;
    // rust: if !self.speleothem_with(state, Direction::Down) {
    // rust: return None;
}
    // rust: let block = b.block(state);
    // rust: let direction = Direction::Down;
    // rust: let root = self.find_block_vertical(
    // rust: pos,
    // rust: true,
    // rust: |sim, _, s| {
    // rust: sim.b.is_block(s, block)
    // rust: && sim.b.table.dir(s, sim.b.props.vertical_direction) == Some(direction)
    // rust: },
    // rust: |sim, s| !sim.b.is_block(s, block),
    // rust: 11,
    // rust: )?;
    // rust: let above_pos = above(root);
    // rust: let above_state = self.state(above_pos);
    // rust: let fluid = if b.is_block(above_state, b.named.mud)
    // rust: && self.level.dimension() != super::Dimension::Nether
    // rust: {
    // rust: FluidKind::Water
    // rust: } else {
    // rust: b.fluid(above_state).kind()
}
    // rust: Some((above_pos, fluid, above_state))
}
pub fn dripstone_transfer_fluid(self: *Self, state: BlockStateId, pos: BlockPos, value: f32) void {
}
    // rust: let b = self.b;
    // rust: if value > 0.175_781_25 {
    // rust: return;
}
    // rust: if !self.speleothem_with(state, Direction::Down)
    // rust: || b.is_block(self.above_state(pos), b.block(state))
    // rust: {
    // rust: return;
}
    // rust: let Some((source_pos, fluid, source_state)) = self.dripstone_fluid_above(state, pos) else {
    // rust: return;
}
    // rust: let probability = match fluid {
    // rust: FluidKind::Water => 0.175_781_25,
    // rust: FluidKind::Lava => 0.058_593_75,
    // rust: _ => return,
}
    // rust: if value >= probability {
    // rust: return;
}
    // rust: let Some(tip) = self.speleothem_find_tip(state, pos, 11, false) else {
    // rust: return;
}
    // rust: if b.is_block(source_state, b.named.mud) && fluid == FluidKind::Water {
    // rust: self.set_block_and_update(source_pos, b.default_of(b.named.clay));
    // rust: self.game_event(source_pos, "minecraft:block_change");
    // rust: self.level_event(1504, tip, 0);
    // rust: } else if let Some(cauldron) = self.dripstone_find_cauldron(tip, fluid) {
    // rust: self.level_event(1504, tip, 0);
    // rust: let delay = 50 + tip.y - cauldron.y;
    // rust: let block = b.block(self.state(cauldron));
    // rust: self.schedule_tick(cauldron, block, delay);
}
}
pub fn cauldron_can_receive(self: *Self, state: BlockStateId, fluid: FluidKind) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let data = b.data(state);
    // rust: if data.is(Class::Cauldron) {
    // rust: true
    // rust: } else if data.is(Class::LayeredCauldron) {
    // rust: fluid == FluidKind::Water && b.is_block(state, b.named.water_cauldron)
    // rust: } else {
    // rust: false
}
}
pub fn dripstone_find_cauldron(self: *Self, tip: BlockPos, fluid: FluidKind) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.find_block_vertical(
    // rust: tip,
    // rust: false,
    // rust: |sim, _, s| sim.dripstone_can_drip_through(s),
    // rust: |sim, s| sim.cauldron_can_receive(s, fluid),
    // rust: 11,
    // rust: )
}
    /// `AbstractCauldronBlock.tick`: receive a drip from a stalactite above.
    // rust: pub(crate) fn cauldron_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let Some(tip) = self.find_block_vertical(
    // rust: pos,
    // rust: true,
    // rust: |sim, _, s| sim.dripstone_can_drip_through(s),
    // rust: |sim, s| sim.is_free_hanging_stalactite(s),
    // rust: 11,
    // rust: ) else {
    // rust: return;
}
    // rust: let tip_state = self.state(tip);
    // rust: let fluid = self
    // rust: .dripstone_fluid_above(tip_state, tip)
    // rust: .map(|(_, f, _)| f)
    // rust: .filter(|f| matches!(f, FluidKind::Water | FluidKind::Lava))
    // rust: .unwrap_or(FluidKind::Empty);
    // rust: if fluid == FluidKind::Empty || !self.cauldron_can_receive(state, fluid) {
    // rust: return;
}
    // rust: let data = b.data(state);
    // rust: if data.is(Class::Cauldron) {
    // rust: let (next, event) = if fluid == FluidKind::Water {
    // rust: (b.named.water_cauldron, 1047)
    // rust: } else {
    // rust: (b.named.lava_cauldron, 1046)
}
    // rust: let to = if fluid == FluidKind::Water { 1 } else { 3 };
    // rust: if !self
    // rust: .level
    // rust: .allow_cauldron_level_change(pos, 0, to, "dripstone")
    // rust: {
    // rust: return;
}
    // rust: self.set_block_and_update(pos, b.default_of(next));
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: self.level_event(event, pos, 0);
    // rust: } else if data.is(Class::LayeredCauldron) {
    // rust: let level = b.table.int(state, b.props.level);
    // rust: if level < 3 {
    // rust: if !self
    // rust: .level
    // rust: .allow_cauldron_level_change(pos, level, level + 1, "dripstone")
    // rust: {
    // rust: return;
}
    // rust: self.set_block_and_update(pos, b.table.set_int(state, b.props.level, level + 1));
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: self.level_event(1047, pos, 0);
}
}
}
}
