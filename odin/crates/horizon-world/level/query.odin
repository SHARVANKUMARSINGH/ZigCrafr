//! Transpiled from Horizon Rust crate
package horizon_world_query

import "core:fmt"
import "core:mem"
import "core:math"

// Block-state queries shared by the ported behaviour (`BlockStateBase`
// accessors and `Block` static helpers).
// use super::{
    // rust: Behaviours, LevelAccess, Sim,
    // rust: classes::{Class, Interface},
    // rust: data::{BlockSet, state_flags},
    // rust: states::{BlockId, PropKey},
    // rust: update::{above, below, rel},
}
// use crate::block_support::SupportType;
// use crate::{fluid::FluidKind, registry::BlockStateId};
// use horizon_core::{
    // rust: geometry::{Direction, Vec3, VoxelShape},
    // rust: position::BlockPos,
}

    // rust: pub(crate) const fn clockwise(direction: Direction) -> Direction {
    // rust: match direction {
    // rust: Direction::North => Direction::East,
    // rust: Direction::East => Direction::South,
    // rust: Direction::South => Direction::West,
    // rust: Direction::West => Direction::North,
    // rust: other => other,
}
}
    // rust: pub(crate) const fn counter_clockwise(direction: Direction) -> Direction {
    // rust: match direction {
    // rust: Direction::North => Direction::West,
    // rust: Direction::West => Direction::South,
    // rust: Direction::South => Direction::East,
    // rust: Direction::East => Direction::North,
    // rust: other => other,
}
}
    // rust: pub(crate) const fn is_horizontal(direction: Direction) -> bool {
    // rust: !matches!(direction, Direction::Up | Direction::Down)
}
    // rust: pub(crate) fn axis_of(direction: Direction) -> horizon_core::geometry::Axis {
//     use horizon_core::geometry::Axis;
    // rust: match direction {
    // rust: Direction::West | Direction::East => Axis::X,
    // rust: Direction::Up | Direction::Down => Axis::Y,
    // rust: Direction::North | Direction::South => Axis::Z,
}
}
// `Direction.from2DDataValue` (S, W, N, E).
    // rust: pub(crate) fn from_2d(value: i32) -> Direction {
    // rust: [
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: ][value.rem_euclid(4) as usize]
}
    // rust: pub(crate) fn data_2d(direction: Direction) -> i32 {
    // rust: match direction {
    // rust: Direction::South => 0,
    // rust: Direction::West => 1,
    // rust: Direction::North => 2,
    // rust: Direction::East => 3,
    // rust: _ => -1,
}
}

    // rust: impl Behaviours {
    // rust: pub(crate) fn in_set(&self, state: BlockStateId, set: &BlockSet) -> bool {
    // rust: set.contains(self.table.block(state))
}
    // rust: pub(crate) fn is_block(&self, state: BlockStateId, block: BlockId) -> bool {
    // rust: self.table.is(state, block)
}
    // rust: pub(crate) fn instance_of(&self, state: BlockStateId, class: Class) -> bool {
    // rust: self.data(state).is(class)
}
    // rust: pub(crate) fn implements(&self, state: BlockStateId, interface: Interface) -> bool {
    // rust: self.data(state).implements(interface)
}
    // rust: pub(crate) fn fluid_in(&self, kind: FluidKind, mask: u8) -> bool {
    // rust: mask & (1 << kind as u8) != 0
}
    // rust: pub(crate) fn is_water_fluid(&self, kind: FluidKind) -> bool {
    // rust: self.fluid_in(kind, self.fluid_tags.water)
}
    // rust: pub(crate) fn is_lava_fluid(&self, kind: FluidKind) -> bool {
    // rust: self.fluid_in(kind, self.fluid_tags.lava)
}
    // rust: pub(crate) fn liquid(&self, state: BlockStateId) -> bool {
    // rust: self.has_flag(state, state_flags::LIQUID)
}
    // rust: pub(crate) fn solid_render(&self, state: BlockStateId) -> bool {
    // rust: self.has_flag(state, state_flags::SOLID_RENDER)
}
    // rust: pub(crate) fn full_collision(&self, state: BlockStateId) -> bool {
    // rust: self.has_flag(state, state_flags::FULL_COLLISION)
}
    // `Block.isFaceFull(state.getCollisionShape(level, pos), direction)`.
    // rust: pub(crate) fn collision_face_full(&self, state: BlockStateId, direction: Direction) -> bool {
    // rust: self.shape_info(state).full_faces & (1 << direction as u8) != 0
}
    // `MultifaceBlock.canAttachTo(level, direction, neighbourPos, neighbourState)`.
    // rust: pub(crate) fn multiface_can_attach(
    // rust: &self,
    // rust: neighbour: BlockStateId,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: let face = direction.opposite();
    // rust: self.is_face_sturdy(neighbour, face) || self.collision_face_full(neighbour, face)
}
    // `Block.isExceptionForConnection`.
    // rust: pub(crate) fn is_exception_for_connection(&self, state: BlockStateId) -> bool {
    // rust: let n = &self.named;
    // rust: let block = self.table.block(state);
    // rust: self.instance_of(state, Class::Leaves)
    // rust: || block == n.barrier
    // rust: || block == n.carved_pumpkin
    // rust: || block == n.jack_o_lantern
    // rust: || block == n.melon
    // rust: || block == n.pumpkin
    // rust: || self.tags.shulker_boxes.contains(block)
}
    // rust: pub(crate) fn is_waterlogged(&self, state: BlockStateId) -> bool {
    // rust: self.table.bool(state, self.props.waterlogged)
}
    // rust: pub(crate) fn facing(&self, state: BlockStateId) -> Direction {
    // rust: self.table
    // rust: .dir(state, self.props.facing)
    // rust: .unwrap_or(Direction::North)
}
    // The boolean/enum property named after `direction` (`north`, `up`, ...).
    // rust: pub(crate) fn dir_prop(&self, direction: Direction) -> PropKey {
    // rust: let p = &self.props;
    // rust: match direction {
    // rust: Direction::Down => p.down,
    // rust: Direction::Up => p.up,
    // rust: Direction::North => p.north,
    // rust: Direction::South => p.south,
    // rust: Direction::West => p.west,
    // rust: Direction::East => p.east,
}
}
    // rust: pub(crate) fn default_of(&self, block: BlockId) -> BlockStateId {
    // rust: self.table.default_state(block)
}
    // rust: pub(crate) fn air(&self) -> BlockStateId {
    // rust: self.table.default_state(self.named.air)
}
}

// Block-entity lookups for dynamic shapes: Horizon's level keeps no shulker
// box animation state, so boxes read as closed (a full cube).
NoBlockEntities :: struct {
    // rust: impl crate::dynamic_support::DynamicSupportWorld for NoBlockEntities {
    // rust: type Error = std::convert::Infallible;
shulker_is_closed :: proc(self: ^Self, _position: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(None)
}
    // rust: fn moving_piston_shape(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<Option<horizon_core::geometry::VoxelShape>, Self::Error> {
    // rust: Ok(None)
}
}
    // rust: impl crate::block_collision::DynamicCollisionWorld for NoBlockEntities {
    // rust: fn shulker_collision_state(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<Option<crate::block_collision::ShulkerCollisionState>, Self::Error> {
    // rust: Ok(None)
}
}

// Block-entity lookups for dynamic shapes, read from the level itself: a
// shulker box's lid state decides whether its support shape is the open plate
// or the closed full cube (`ShulkerBoxBlock.getBlockSupportShape`).
LevelBlockEntities :: struct {
    // rust: impl<L: LevelAccess + ?Sized> crate::dynamic_support::DynamicSupportWorld
    // rust: for LevelBlockEntities<'_, L>
    // rust: {
    // rust: type Error = std::convert::Infallible;
shulker_is_closed :: proc(self: ^Self, position: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self
    // rust: .0
    // rust: .shulker_is_closed(BlockPos::new(position[0], position[1], position[2])))
}
    // rust: fn moving_piston_shape(
    // rust: &mut self,
    // rust: _position: [i32; 3],
    // rust: ) -> Result<Option<VoxelShape>, Self::Error> {
    // rust: Ok(None)
}
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    // Shape queries over `getCollisionShape(level, pos)`, including the
    // position-dependent shapes (bamboo, speleothems, shulker boxes).
    // rust: pub(crate) fn shape_info_at(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: ) -> super::data::ShapeInfo {
    // rust: if self.b.facts(state).shape >= 0 {
    // rust: return self.b.shape_info(state);
}
    // rust: match self.b.dynamic.get(&state) {
    // rust: Some(support) => support
    // rust: .collision_shape(&mut NoBlockEntities, [pos.x, pos.y, pos.z])
    // rust: .ok()
    // rust: .and_then(|shape| super::data::analyse_shape(&shape).ok())
    // rust: .unwrap_or_default(),
    // rust: None => super::data::ShapeInfo::default(),
}
}
    // The state whose cached support facts stand in for the block at `pos`.
    // Vanilla reads a retracting piston's `moving_piston` block through its
    // block entity, whose collision shape contains the extended base; the
    // exported facts see no block entity and call every face unsupported,
    // which made a lever on the piston's back pop off when it retracted.
    // rust: pub(super) fn support_state(&self, pos: BlockPos) -> BlockStateId {
    // rust: let state = self.state(pos);
    // rust: if self.b.is_block(state, self.b.named.moving_piston) {
    // rust: if let Some(piston) = self.moving_piston(pos) {
                // `PistonMovingBlockEntity.getCollisionShape`: only a piston base.
    // rust: if piston.source
    // rust: && !piston.extending
    // rust: && (self.b.is_block(piston.moved_state, self.b.named.piston)
    // rust: || self
    // rust: .b
    // rust: .is_block(piston.moved_state, self.b.named.sticky_piston))
    // rust: {
    // rust: return self
    // rust: .b
    // rust: .table
    // rust: .set_bool(piston.moved_state, self.b.props.extended, true);
}
                // The same method for any other moving block: its collision shape
                // is `movedState.getCollisionShape(..).move(dir * extendedProgress)`,
                // and `getExtendedProgress` is 0 once progress reaches 1.0, so a
                // finished-but-not-yet-placed block supports like itself (a wall
                // coral fan keeps its slime block while the column lands). At 0 or
                // 0.5 progress the shape is shifted off the cell, a face never full.
    // rust: if !piston.source && piston.progress >= 1.0 {
    // rust: return piston.moved_state;
}
}
}
    // rust: state
}
    // `PistonMovingBlockEntity.getCollisionShape` for a block a piston moves (not the
    // piston's own base or head): the moved block's collision shape, offset by
    // `getExtendedProgress(progress)` along the movement (`progress - 1` while
    // extending, `1 - progress` while retracting). `MOVING_PISTON` has a dynamic shape,
    // so `isFaceSturdy` asks this shape every time. When `PistonBaseBlock.moveBlocks`
    // updates the neighbours, progress is 0 and the shape sits a whole block back,
    // outside the cell: a rail on a pushed block loses its support and pops. At
    // progress 1, before the block entity finishes, it sits in the cell: a rail
    // carried by slime finishes on top of a slime block still moving below it
    // (#8111). None for other cells, and for moved blocks without a fixed shape.
moving_block_shape :: proc(self: ^Self, pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !self.b.is_block(self.state(pos), self.b.named.moving_piston) {
    // rust: return None;
}
    // rust: let piston = self.moving_piston(pos)?;
    // rust: if piston.source {
    // rust: return None;
}
    // rust: let shape = self.b.collision_shape(piston.moved_state)?;
    // rust: let [x, y, z] = piston.shape_state().interpolated_offset(1.0);
    // rust: Some(shape.moved(Vec3::new(f64::from(x), f64::from(y), f64::from(z))))
}
    // `isFaceSturdy(level, pos, direction, support)` of a moved block's cell, from its
    // shape ([`Self::moving_block_shape`]); None for every other cell.
    // rust: fn moving_block_supports(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: support: SupportType,
    // rust: ) -> Option<bool> {
    // rust: let shape = self.moving_block_shape(pos)?;
    // rust: Some(support.is_supporting(&shape, direction).unwrap_or(false))
}
    // `ShulkerBoxBlock.getBlockSupportShape` at `pos`: vanilla asks the block
    // entity because a shulker box's shape is dynamic, so an open box gives
    // support only through its one-pixel plate opposite `facing`, where the
    // exported facts see a closed full cube. None for every other block.
    // rust: fn shulker_support(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: support: SupportType,
    // rust: ) -> Option<bool> {
    // rust: let state = self.state(pos);
    // rust: if !self
    // rust: .b
    // rust: .tags
    // rust: .shulker_boxes
    // rust: .contains(self.b.table.block(state))
    // rust: {
    // rust: return None;
}
    // rust: let mut world = LevelBlockEntities(&*self.level);
    // rust: self.b
    // rust: .dynamic
    // rust: .get(&state)?
    // rust: .is_face_sturdy(&mut world, [pos.x, pos.y, pos.z], direction, support)
    // rust: .ok()
}
sturdy :: proc(self: ^Self, pos: BlockPos, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(sturdy) = self.moving_block_supports(pos, direction, SupportType::Full) {
    // rust: return sturdy;
}
    // rust: if let Some(sturdy) = self.shulker_support(pos, direction, SupportType::Full) {
    // rust: return sturdy;
}
    // rust: self.b.is_face_sturdy(self.support_state(pos), direction)
}
    // `Block.canSupportRigidBlock(level, below)`.
can_support_rigid_block :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(rigid) = self.moving_block_supports(pos, Direction::Up, SupportType::Rigid) {
    // rust: return rigid;
}
    // rust: if let Some(rigid) = self.shulker_support(pos, Direction::Up, SupportType::Rigid) {
    // rust: return rigid;
}
    // rust: self.b
    // rust: .is_face_sturdy_rigid(self.support_state(pos), Direction::Up)
}
    // `Block.canSupportCenter(level, pos, direction)`.
can_support_center :: proc(self: ^Self, pos: BlockPos, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.support_state(pos);
    // rust: if direction == Direction::Down && self.b.in_set(state, &self.b.tags.unstable_bottom_center)
    // rust: {
    // rust: return false;
}
    // rust: if let Some(center) = self.moving_block_supports(pos, direction, SupportType::Center) {
    // rust: return center;
}
    // rust: if let Some(center) = self.shulker_support(pos, direction, SupportType::Center) {
    // rust: return center;
}
    // rust: self.b.is_face_sturdy_center(state, direction)
}
is_empty_block :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b.is_air(self.state(pos))
}
    // `LevelReader.isWaterAt`: the fluid at `pos` is in the water tag.
is_water_at :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b.is_water_fluid(self.fluid_at(pos).kind())
}
    // `Level.getRawBrightness(pos, darken)`.
raw_brightness :: proc(self: ^Self, pos: BlockPos, darken: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: super::raw_brightness(self.level, pos, darken)
}
    // `LevelReader.getMaxLocalRawBrightness(pos)`.
max_local_raw_brightness :: proc(self: ^Self, pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.raw_brightness(pos, self.level.sky_darken())
}
is_redstone_conductor :: proc(self: ^Self, state: BlockStateId, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.b.has_flag(state, state_flags::CONDUCTOR)
}
    // rust: pub(crate) fn above_state(&self, pos: BlockPos) -> BlockStateId {
    // rust: self.state(above(pos))
}
    // rust: pub(crate) fn below_state(&self, pos: BlockPos) -> BlockStateId {
    // rust: self.state(below(pos))
}
    // rust: pub(crate) fn rel_state(&self, pos: BlockPos, direction: Direction) -> BlockStateId {
    // rust: self.state(rel(pos, direction))
}
    // rust: pub(crate) fn is_inside_build_height(&self, y: i32) -> bool {
    // rust: y >= self.level.min_y() && y < self.level.max_y()
}
}
