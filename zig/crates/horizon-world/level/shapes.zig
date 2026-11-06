//! Transpiled from Horizon Rust crate
//! Module: horizon-world_shapes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `BlockBehaviour.updateShape` for every overriding vanilla class.
//!
//! Dispatch walks the block's class chain; a handler returning `None` defers
//! to the next class (the Java `super` call), the end of the chain returns the
//! state unchanged (`BlockBehaviour.updateShape`).
// use super::{
    // rust: LevelAccess, Sim,
    // rust: classes::Class,
    // rust: query::{axis_of, clockwise, counter_clockwise, is_horizontal},
    // rust: states::BlockId,
    // rust: update::{above, below, rel},
}
// use crate::{fluid::FluidKind, registry::BlockStateId};
// use horizon_core::{
    // rust: geometry::{Axis, Direction},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

/// `SoundEvents.GEYSER_ERUPTION_START`.
pub const GEYSER_ERUPTION_START: []const u8 = "minecraft:block.potent_sulfur.geyser_eruption";
/// `SoundEvents.GEYSER_CONTINUOUS_START`.
pub const GEYSER_CONTINUOUS_START: []const u8 = "minecraft:block.potent_sulfur.geyser_continuous_eruption";

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    /// `BlockState.updateShape(level, ticks, pos, direction, neighbourPos, neighbourState, random)`.
    // rust: pub fn update_shape(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: neighbour_pos: BlockPos,
    // rust: neighbour: BlockStateId,
    // rust: ) -> BlockStateId {
    // rust: let mut new = None;
    // rust: self.level.before_update_shape(
    // rust: self.ticks,
    // rust: pos,
    // rust: state,
    // rust: direction,
    // rust: neighbour_pos,
    // rust: neighbour,
    // rust: &mut new,
    // rust: );
        // A mod's answer: an id past the state table would panic the server.
    // rust: if let Some(new) = new
    // rust: && (new.0 as usize) < self.b.table.state_count()
    // rust: {
    // rust: return new;
}
    // rust: self.update_shape_at(0, state, pos, direction, neighbour_pos, neighbour)
}

    // rust: pub(crate) fn schedule_water_tick(&mut self, pos: BlockPos) {
    // rust: self.schedule_fluid_tick(pos, FluidKind::Water, 5);
}
pub fn waterlogged_tick(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: if self.b.is_waterlogged(state) {
    // rust: self.schedule_water_tick(pos);
}
}

    // rust: fn update_shape_at(
    // rust: &mut self,
    // rust: depth: usize,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: neighbour_pos: BlockPos,
    // rust: neighbour: BlockStateId,
    // rust: ) -> BlockStateId {
    // rust: let chain_len = self.b.data(state).chain.len();
    // rust: for index in depth..chain_len {
    // rust: let class = self.b.data(state).chain[index];
    // rust: if let Some(result) = self.update_shape_class(
    // rust: class,
    // rust: index,
    // rust: state,
    // rust: pos,
    // rust: direction,
    // rust: neighbour_pos,
    // rust: neighbour,
    // rust: ) {
    // rust: return result;
}
}
    // rust: state
}

    // rust: fn update_shape_class(
    // rust: &mut self,
    // rust: class: Class,
    // rust: depth: usize,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: dir: Direction,
    // rust: npos: BlockPos,
    // rust: nstate: BlockStateId,
    // rust: ) -> Option<BlockStateId> {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let t = &b.tags;
    // rust: let n = b.named;
    // rust: let table = &b.table;
    // rust: let air = b.air();
    // rust: let block = b.block(state);
    // rust: macro_rules! sup {
    // rust: () => {
    // rust: self.update_shape_at(depth + 1, state, pos, dir, npos, nstate)
}
}
        // `dir == X && !canSurvive ? AIR : super`.
    // rust: macro_rules! survive_or_air {
    // rust: ($cond:expr) => {{
    // rust: if $cond && !self.can_survive(state, pos) {
    // rust: air
    // rust: } else {
    // rust: sup!()
}
    // rust: }};
}
    // rust: Some(match class {
    // rust: Class::AbstractBed => {
    // rust: if dir == self.bed_neighbour_direction(state) {
    // rust: if b.is_block(nstate, block)
    // rust: && table.text(nstate, p.part) != table.text(state, p.part)
    // rust: {
    // rust: table.set_bool(state, p.occupied, table.bool(nstate, p.occupied))
    // rust: } else {
    // rust: air
}
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::AmethystCluster | Class::ShelfMushroom => {
    // rust: if class == Class::AmethystCluster {
    // rust: self.waterlogged_tick(state, pos);
}
    // rust: survive_or_air!(dir == b.facing(state).opposite())
}
    // rust: Class::AttachedStem => {
    // rust: if !b
    // rust: .data(state)
    // rust: .link
    // rust: .is_some_and(|fruit| b.is_block(nstate, fruit))
    // rust: && dir == b.facing(state)
    // rust: {
    // rust: if let Some(stem) = b.data(state).link2 {
    // rust: return Some(table.set_int(b.default_of(stem), p.age, 7));
}
}
    // rust: sup!()
}
    // rust: Class::BambooSapling => {
    // rust: if !self.can_survive(state, pos) {
    // rust: air
    // rust: } else if dir == Direction::Up && b.is_block(nstate, n.bamboo) {
    // rust: b.default_of(n.bamboo)
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::BambooStalk => {
    // rust: if !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: if dir == Direction::Up
    // rust: && b.is_block(nstate, n.bamboo)
    // rust: && table.int(nstate, p.age) > table.int(state, p.age)
    // rust: {
    // rust: table.cycle(state, p.age)
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Banner
    // rust: | Class::BasePressurePlate
    // rust: | Class::BaseTorch
    // rust: | Class::Cake
    // rust: | Class::CandleCake
    // rust: | Class::FlowerPot
    // rust: | Class::StandingSign => survive_or_air!(dir == Direction::Down),
    // rust: Class::Barrier
    // rust: | Class::BaseRail
    // rust: | Class::Candle
    // rust: | Class::Chain
    // rust: | Class::Conduit
    // rust: | Class::CopperGolemStatue
    // rust: | Class::DecoratedPot
    // rust: | Class::DriedGhast
    // rust: | Class::EnderChest
    // rust: | Class::HeavyCore
    // rust: | Class::Light
    // rust: | Class::LightningRod
    // rust: | Class::MangroveRoots
    // rust: | Class::SculkSensor
    // rust: | Class::SculkShrieker
    // rust: | Class::Shelf
    // rust: | Class::Sign
    // rust: | Class::Slab
    // rust: | Class::SmallDripleaf
    // rust: | Class::TrapDoor
    // rust: | Class::WaterloggedTransparent => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: sup!()
}
    // rust: Class::BaseCoralPlantType => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: survive_or_air!(dir == Direction::Down)
}
    // rust: Class::BaseCoralWallFan => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: if dir.opposite() == b.facing(state) && !self.can_survive(state, pos) {
    // rust: air
    // rust: } else {
    // rust: state
}
}
    // rust: Class::Beehive => sup!(),
    // rust: Class::Bell => {
    // rust: let attachment = table.text(state, p.attachment);
    // rust: let connected = self.bell_connected_direction(state).opposite();
    // rust: if connected == dir && !self.can_survive(state, pos) && attachment != "double_wall"
    // rust: {
    // rust: return Some(air);
}
    // rust: if axis_of(dir) == axis_of(b.facing(state)) {
    // rust: if attachment == "double_wall" && !b.is_face_sturdy(nstate, dir) {
    // rust: let single = table.set_text(state, p.attachment, "single_wall");
    // rust: return Some(table.set_dir(single, p.facing, dir.opposite()));
}
    // rust: if attachment == "single_wall"
    // rust: && connected.opposite() == dir
    // rust: && b.is_face_sturdy(nstate, b.facing(state))
    // rust: {
    // rust: return Some(table.set_text(state, p.attachment, "double_wall"));
}
}
    // rust: sup!()
}
    // rust: Class::BigDripleaf => {
    // rust: if dir == Direction::Down && !self.can_survive(state, pos) {
    // rust: return Some(air);
}
    // rust: self.waterlogged_tick(state, pos);
    // rust: if dir == Direction::Up && b.is_block(nstate, block) {
    // rust: table.with_properties_of(n.big_dripleaf_stem, state)
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::BigDripleafStem => {
    // rust: if matches!(dir, Direction::Down | Direction::Up) && !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: self.waterlogged_tick(state, pos);
    // rust: sup!()
}
    // rust: Class::Brushable => {
    // rust: self.schedule_tick(pos, block, 2);
    // rust: sup!()
}
    // rust: Class::BubbleColumn => {
    // rust: self.schedule_water_tick(pos);
    // rust: if !self.can_survive(state, pos)
    // rust: || dir == Direction::Down
    // rust: || (dir == Direction::Up
    // rust: && !b.is_block(nstate, block)
    // rust: && self.bubble_column_can_occupy(nstate))
    // rust: {
    // rust: self.schedule_tick(pos, block, 5);
}
    // rust: sup!()
}
    // rust: Class::Cactus | Class::SugarCane => {
    // rust: if !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: sup!()
}
    // rust: Class::Campfire => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: if dir == Direction::Down {
    // rust: table.set_bool(state, p.signal_fire, self.is_smoke_source(nstate))
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Carpet | Class::SnowLayer | Class::Vegetation | Class::Frogspawn => {
    // rust: survive_or_air!(true)
}
    // rust: Class::SeaPickle => {
    // rust: if !self.can_survive(state, pos) {
    // rust: return Some(air);
}
    // rust: self.waterlogged_tick(state, pos);
    // rust: sup!()
}
    // rust: Class::CeilingHangingSign | Class::SporeBlossom => {
    // rust: survive_or_air!(dir == Direction::Up)
}
    // rust: Class::Chest => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: if self.chest_can_connect_to(state, nstate) && is_horizontal(dir) {
    // rust: let neighbour_type = table.text(nstate, p.kind);
    // rust: if table.text(state, p.kind) == "single"
    // rust: && neighbour_type != "single"
    // rust: && b.facing(state) == b.facing(nstate)
    // rust: && self.chest_connected_direction(nstate) == dir.opposite()
    // rust: {
    // rust: let opposite = if neighbour_type == "left" {
    // rust: "right"
    // rust: } else {
    // rust: "left"
}
    // rust: return Some(table.set_text(state, p.kind, opposite));
}
    // rust: } else if self.chest_connected_direction(state) == dir {
    // rust: return Some(table.set_text(state, p.kind, "single"));
}
    // rust: sup!()
}
    // rust: Class::CopperChest => {
    // rust: let result = sup!();
    // rust: if self.chest_can_connect_to(state, nstate)
    // rust: && table.text(result, p.kind) != "single"
    // rust: && self.chest_connected_direction(result) == dir
    // rust: {
    // rust: return Some(table.with_properties_of(b.block(nstate), result));
}
    // rust: result
}
    // rust: Class::ChorusFlower => {
    // rust: if dir != Direction::Up && !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: sup!()
}
    // rust: Class::ChorusPlant => {
    // rust: if !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, 1);
    // rust: sup!()
    // rust: } else {
    // rust: let connect = b.is_block(nstate, block)
    // rust: || b.is_block(nstate, n.chorus_flower)
    // rust: || (dir == Direction::Down && b.in_set(nstate, &t.supports_chorus_plant));
    // rust: table.set_bool(state, self.direction_prop(dir), connect)
}
}
            // A content mod's connecting block; the chorus plant's PipeBlock
            // keeps its state (vanilla's has no updateShape).
    // rust: Class::Pipe if b.data(state).class == Class::Pipe => table.set_bool(
    // rust: state,
    // rust: self.direction_prop(dir),
    // rust: self.pipe_connects(state, nstate),
    // rust: ),
    // rust: Class::Cocoa => survive_or_air!(dir == b.facing(state)),
    // rust: Class::Comparator => {
    // rust: if dir == Direction::Down && !b.is_face_sturdy_rigid(nstate, Direction::Up) {
    // rust: air
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::ConcretePowder => {
    // rust: if self.concrete_touches_liquid(pos) {
    // rust: b.data(state)
    // rust: .link
    // rust: .map_or(state, |concrete| b.default_of(concrete))
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Coral => {
    // rust: if !self.coral_scan_for_water(pos) {
    // rust: let delay = 60 + self.random().next_int_bound(40).unwrap_or(0);
    // rust: self.schedule_tick(pos, block, delay);
}
    // rust: sup!()
}
    // rust: Class::CoralFan | Class::CoralPlant => {
    // rust: if dir == Direction::Down && !self.can_survive(state, pos) {
    // rust: return Some(air);
}
    // rust: self.coral_try_schedule_die_tick(state, pos);
    // rust: self.waterlogged_tick(state, pos);
    // rust: sup!()
}
    // rust: Class::CoralWallFan => {
    // rust: if dir.opposite() == b.facing(state) && !self.can_survive(state, pos) {
    // rust: return Some(air);
}
    // rust: self.waterlogged_tick(state, pos);
    // rust: self.coral_try_schedule_die_tick(state, pos);
    // rust: sup!()
}
    // rust: Class::CreakingHeart => {
    // rust: self.schedule_tick(pos, block, 1);
    // rust: sup!()
}
    // rust: Class::Door => {
    // rust: let lower = table.text(state, p.half) == "lower";
    // rust: if dir.normal()[1] == 0 || lower != (dir == Direction::Up) {
    // rust: if lower && dir == Direction::Down && !self.can_survive(state, pos) {
    // rust: air
    // rust: } else {
    // rust: sup!()
}
    // rust: } else if b.instance_of(nstate, Class::Door)
    // rust: && table.text(nstate, p.half) != table.text(state, p.half)
    // rust: {
    // rust: table.set_text(nstate, p.half, table.text(state, p.half))
    // rust: } else {
    // rust: air
}
}
    // rust: Class::DoublePlant => {
    // rust: let half = table.text(state, p.half);
    // rust: let lower = half == "lower";
    // rust: if dir.normal()[1] == 0
    // rust: || lower != (dir == Direction::Up)
    // rust: || (b.is_block(nstate, block) && table.text(nstate, p.half) != half)
    // rust: {
    // rust: if lower && dir == Direction::Down && !self.can_survive(state, pos) {
    // rust: air
    // rust: } else {
    // rust: sup!()
}
    // rust: } else {
    // rust: air
}
}
    // rust: Class::PitcherCrop => {
    // rust: if table.int(state, p.age) >= 3 {
    // rust: sup!()
    // rust: } else if self.can_survive(state, pos) {
    // rust: state
    // rust: } else {
    // rust: air
}
}
    // rust: Class::FaceAttachedHorizontalDirectional | Class::Lantern => {
    // rust: if class == Class::Lantern {
    // rust: self.waterlogged_tick(state, pos);
    // rust: let connected = if table.bool(state, p.hanging) {
    // rust: Direction::Down
    // rust: } else {
    // rust: Direction::Up
}
    // rust: survive_or_air!(connected.opposite() == dir)
    // rust: } else {
    // rust: survive_or_air!(self.face_attached_connected(state).opposite() == dir)
}
}
    // rust: Class::FallingBlock => {
    // rust: let delay = if class_is(b, block, Class::DragonEgg) {
    // rust: 5
    // rust: } else {
    // rust: 2
}
    // rust: self.schedule_tick(pos, block, delay);
    // rust: sup!()
}
    // rust: Class::Farmland | Class::Path => {
    // rust: if dir == Direction::Up && !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: sup!()
}
    // rust: Class::Fence => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: if is_horizontal(dir) {
    // rust: let sturdy = b.is_face_sturdy(nstate, dir.opposite());
    // rust: table.set_bool(
    // rust: state,
    // rust: self.direction_prop(dir),
    // rust: self.fence_connects_to(state, nstate, sturdy, dir.opposite()),
    // rust: )
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::IronBars => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: if is_horizontal(dir) {
    // rust: let sturdy = b.is_face_sturdy(nstate, dir.opposite());
    // rust: table.set_bool(
    // rust: state,
    // rust: self.direction_prop(dir),
    // rust: self.bars_attach_to(nstate, sturdy),
    // rust: )
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::FenceGate => {
    // rust: if axis_of(clockwise(b.facing(state))) != axis_of(dir) {
    // rust: sup!()
    // rust: } else {
    // rust: let other = self.rel_state(pos, dir.opposite());
    // rust: let in_wall = b.in_set(nstate, &t.walls) || b.in_set(other, &t.walls);
    // rust: table.set_bool(state, p.in_wall, in_wall)
}
}
    // rust: Class::Fire => {
    // rust: if self.can_survive(state, pos) {
    // rust: let age = table.int(state, p.age);
    // rust: self.fire_state_with_age(pos, age)
    // rust: } else {
    // rust: air
}
}
    // rust: Class::SoulFire => {
    // rust: if self.can_survive(state, pos) {
    // rust: b.default_of(block)
    // rust: } else {
    // rust: air
}
}
    // rust: Class::GrowingPlantBody => {
    // rust: let growth = b.data(state).growth_direction;
    // rust: if dir == growth.opposite() && !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: let (head, _) = self.growing_plant_pair(block);
    // rust: if dir == growth && !b.is_block(nstate, block) && !b.is_block(nstate, head) {
    // rust: let age = self.random().next_int_bound(25).unwrap_or(0);
    // rust: let head_state = table.set_int(b.default_of(head), p.age, age);
    // rust: return Some(if class_is(b, block, Class::CaveVinesPlant) {
    // rust: table.set_bool(head_state, p.berries, table.bool(state, p.berries))
    // rust: } else {
    // rust: head_state
    // rust: });
}
    // rust: if b.data(state).schedule_fluid_ticks {
    // rust: self.schedule_water_tick(pos);
}
    // rust: sup!()
}
    // rust: Class::GrowingPlantHead => {
    // rust: let growth = b.data(state).growth_direction;
    // rust: let (_, body) = self.growing_plant_pair(block);
    // rust: let to_body = |sim: &Self| {
    // rust: let body_state = b.default_of(body);
    // rust: if class_is(b, block, Class::CaveVines) {
    // rust: sim.b
    // rust: .table
    // rust: .set_bool(body_state, p.berries, table.bool(state, p.berries))
    // rust: } else {
    // rust: body_state
}
}
    // rust: if dir == growth.opposite() {
    // rust: if !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, 1);
    // rust: } else {
    // rust: let next = self.rel_state(pos, growth);
    // rust: if b.is_block(next, block) || b.is_block(next, body) {
    // rust: return Some(to_body(self));
}
}
}
    // rust: if dir != growth || (!b.is_block(nstate, block) && !b.is_block(nstate, body)) {
    // rust: if b.data(state).schedule_fluid_ticks {
    // rust: self.schedule_water_tick(pos);
}
    // rust: sup!()
    // rust: } else {
    // rust: to_body(self)
}
}
    // rust: Class::HangingMoss => {
    // rust: let above_state = self.above_state(pos);
    // rust: if !(b.multiface_can_attach(above_state, Direction::Up)
    // rust: || b.is_block(above_state, block))
    // rust: {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: table.set_bool(state, p.tip, !b.is_block(self.below_state(pos), block))
}
    // rust: Class::HangingRoots => {
    // rust: if dir == Direction::Up && !self.can_survive(state, pos) {
    // rust: return Some(air);
}
    // rust: self.waterlogged_tick(state, pos);
    // rust: sup!()
}
    // rust: Class::HugeMushroom => {
    // rust: if b.is_block(nstate, block) {
    // rust: table.set_bool(state, self.direction_prop(dir), false)
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Ladder => {
    // rust: if dir.opposite() == b.facing(state) && !self.can_survive(state, pos) {
    // rust: return Some(air);
}
    // rust: self.waterlogged_tick(state, pos);
    // rust: sup!()
}
    // rust: Class::Leaves => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: let distance = self.leaf_distance_at(nstate) + 1;
    // rust: if distance != 1 || table.int(state, p.distance) != distance {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: state
}
    // rust: Class::Liquid => {
    // rust: let fluid = b.fluid(state);
    // rust: if fluid.is_source() || b.fluid(nstate).is_source() {
    // rust: let delay = self.fluid_tick_delay(fluid.kind());
    // rust: self.schedule_fluid_tick(pos, fluid.kind(), delay);
}
    // rust: if dir == Direction::Down && self.should_bubble_column_occupy(state) {
    // rust: self.try_schedule_bubble_column(pos, nstate, block);
}
    // rust: sup!()
}
    // rust: Class::MangrovePropagule => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: survive_or_air!(dir == Direction::Up)
}
    // rust: Class::MossyCarpet => {
    // rust: if !self.can_survive(state, pos) {
    // rust: return Some(air);
}
    // rust: let updated = self.mossy_carpet_updated_state(state, pos, false);
    // rust: if self.mossy_carpet_has_faces(updated) {
    // rust: updated
    // rust: } else {
    // rust: air
}
}
    // rust: Class::Multiface => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: if !Direction::ALL
    // rust: .into_iter()
    // rust: .any(|d| self.multiface_has_face(state, d))
    // rust: {
    // rust: air
    // rust: } else if self.multiface_has_face(state, dir)
    // rust: && !b.multiface_can_attach(nstate, dir)
    // rust: {
    // rust: let removed = table.set_bool(state, self.direction_prop(dir), false);
    // rust: if Direction::ALL
    // rust: .into_iter()
    // rust: .any(|d| self.multiface_has_face(removed, d))
    // rust: {
    // rust: removed
    // rust: } else {
    // rust: air
}
    // rust: } else {
    // rust: state
}
}
    // rust: Class::PistonHead => survive_or_air!(dir.opposite() == b.facing(state)),
    // rust: Class::Note => {
    // rust: if dir.normal()[1] != 0 {
    // rust: self.note_block_instrument(pos, state)
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Observer => {
    // rust: if b.facing(state) == dir && !table.bool(state, p.powered) {
    // rust: self.observer_start_signal(pos, block);
}
    // rust: sup!()
}
    // rust: Class::RedstoneWallTorch
    // rust: | Class::WallTorch
    // rust: | Class::TripWireHook
    // rust: | Class::WallBanner
    // rust: | Class::WallSign => {
    // rust: let attached = dir.opposite() == b.facing(state);
    // rust: let fails = attached && !self.can_survive(state, pos);
    // rust: match class {
    // rust: Class::RedstoneWallTorch | Class::WallTorch => {
    // rust: if fails {
    // rust: air
    // rust: } else {
    // rust: state
}
}
    // rust: _ => {
    // rust: if fails {
    // rust: air
    // rust: } else {
    // rust: sup!()
}
}
}
}
    // rust: Class::RedstoneWire => self.redstone_wire_update_shape(state, pos, dir, npos, nstate),
    // rust: Class::Repeater => {
    // rust: if dir == Direction::Down && !b.is_face_sturdy_rigid(nstate, Direction::Up) {
    // rust: air
    // rust: } else if axis_of(dir) != axis_of(b.facing(state)) {
    // rust: let locked = self.diode_is_locked(pos, state);
    // rust: table.set_bool(state, p.locked, locked)
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Scaffolding => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: self.schedule_tick(pos, block, 1);
    // rust: state
}
    // rust: Class::Seagrass => {
    // rust: let result = sup!();
    // rust: if !b.is_air(result) {
    // rust: self.schedule_water_tick(pos);
}
    // rust: result
}
    // rust: Class::Snowy => {
    // rust: if dir == Direction::Up {
    // rust: table.set_bool(state, p.snowy, b.in_set(nstate, &t.snow))
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Speleothem => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: if !matches!(dir, Direction::Up | Direction::Down) {
    // rust: return Some(state);
}
    // rust: let tip = table
    // rust: .dir(state, p.vertical_direction)
    // rust: .unwrap_or(Direction::Up);
    // rust: if tip == Direction::Down && self.ticks.has_block_tick(pos, block) {
    // rust: return Some(state);
}
    // rust: if dir == tip.opposite() && !self.can_survive(state, pos) {
    // rust: self.schedule_tick(pos, block, if tip == Direction::Down { 2 } else { 1 });
    // rust: state
    // rust: } else {
    // rust: let merge = table.text(state, p.thickness) == "tip_merge";
    // rust: let thickness = self.speleothem_thickness(pos, tip, merge);
    // rust: table.set_text(state, p.thickness, thickness)
}
}
    // rust: Class::Stair => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: if is_horizontal(dir) {
    // rust: let shape = self.stairs_shape(state, pos);
    // rust: table.set_text(state, p.shape, shape)
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::TripWire => {
    // rust: if is_horizontal(dir) {
    // rust: let connect = self.tripwire_should_connect_to(nstate, dir);
    // rust: table.set_bool(state, self.direction_prop(dir), connect)
    // rust: } else {
    // rust: sup!()
}
}
    // rust: Class::Vine => {
    // rust: if dir == Direction::Down {
    // rust: sup!()
    // rust: } else {
    // rust: let updated = self.vine_updated_state(state, pos);
    // rust: if self.vine_count_faces(updated) == 0 {
    // rust: air
    // rust: } else {
    // rust: updated
}
}
}
    // rust: Class::Wall => {
    // rust: self.waterlogged_tick(state, pos);
    // rust: match dir {
    // rust: Direction::Down => sup!(),
    // rust: Direction::Up => {
    // rust: let sides = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ]
    // rust: .map(|d| table.text(state, self.direction_prop(d)) != "none");
    // rust: self.wall_shape(state, npos, nstate, sides)
}
    // rust: _ => {
    // rust: let opposite = dir.opposite();
    // rust: let sides = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ]
    // rust: .map(|d| {
    // rust: if d == dir {
    // rust: self.wall_connects_to(
    // rust: nstate,
    // rust: b.is_face_sturdy(nstate, opposite),
    // rust: opposite,
    // rust: )
    // rust: } else {
    // rust: table.text(state, self.direction_prop(d)) != "none"
}
    // rust: });
    // rust: let above_pos = above(pos);
    // rust: let above_state = self.state(above_pos);
    // rust: self.wall_shape(state, above_pos, above_state, sides)
}
}
}
    // rust: Class::WallHangingSign => {
    // rust: survive_or_air!(axis_of(dir) == axis_of(clockwise(b.facing(state))))
}
    // rust: Class::PotentSulfur => {
    // rust: let next = self.potent_sulfur_state(state, pos);
                // validBlockState: a block that was no geyser starts its
                // block entity's countdown over when it becomes dormant.
    // rust: if table.text(next, p.potent_sulfur_state) == "dormant"
    // rust: && !matches!(
    // rust: table.text(state, p.potent_sulfur_state),
    // rust: "erupting" | "dormant"
    // rust: )
    // rust: {
    // rust: self.level.reset_potent_sulfur_countdown(pos);
}
    // rust: next
}
    // rust: Class::NetherPortal => {
    // rust: let x_axis = table.text(state, p.axis) == "x";
    // rust: let update_axis = axis_of(dir);
    // rust: let wrong_axis =
    // rust: update_axis != if x_axis { Axis::X } else { Axis::Z } && update_axis != Axis::Y;
    // rust: if !wrong_axis
    // rust: && !b.is_block(nstate, block)
    // rust: && !self.find_portal_shape(pos, x_axis).is_complete()
    // rust: {
    // rust: air
    // rust: } else {
    // rust: sup!()
}
}
    // rust: _ => return None,
    // rust: })
}

    // ---- family helpers ----

    /// `PotentSulfurBlock.validBlockState` (the geyser block-entity countdown
    /// reset is the caller's).
    // rust: pub(crate) fn potent_sulfur_state(&self, state: BlockStateId, pos: BlockPos) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let key = b.props.potent_sulfur_state;
    // rust: if self.fluid_at(above(pos)).kind() != FluidKind::Water {
    // rust: return b.table.set_text(state, key, "dry");
}
    // rust: let below_state = self.below_state(pos);
    // rust: let fluid = b.fluid(below_state);
    // rust: let source_if_fluid = fluid.kind() == FluidKind::Empty || fluid.is_source();
    // rust: let tagged = |name: &str| b.tag(name).is_some_and(|tag| b.in_set(below_state, tag));
    // rust: if tagged("minecraft:causes_continuous_geyser_eruptions") && source_if_fluid {
    // rust: return b.table.set_text(state, key, "continuous");
}
    // rust: if tagged("minecraft:causes_periodic_geyser_eruptions") && source_if_fluid {
    // rust: if b.table.text(state, key) == "erupting" {
    // rust: state
    // rust: } else {
    // rust: b.table.set_text(state, key, "dormant")
}
    // rust: } else {
    // rust: b.table.set_text(state, key, "wet")
}
}

    /// `PotentSulfurBlock.onPlace`: a geyser that starts erupting (or runs
    /// continuously) queues its eruption block event, plays its start sound
    /// and signals the activation.
    // rust: pub(crate) fn potent_sulfur_on_place(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let current = b.table.text(state, b.props.potent_sulfur_state);
    // rust: if current != "erupting" && current != "continuous" {
    // rust: return;
}
    // rust: let sound = if current == "continuous" {
    // rust: GEYSER_CONTINUOUS_START
    // rust: } else {
    // rust: GEYSER_ERUPTION_START
}
    // rust: self.block_event(pos, b.block(state), 0, 0);
    // rust: self.sound(pos, &sound.into(), 1.0, 1.0);
    // rust: self.game_event_state(pos, "minecraft:block_activate", state);
}

pub fn bed_neighbour_direction(self: *Self, state: BlockStateId) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let facing = self.b.facing(state);
    // rust: if self.b.table.text(state, self.b.props.part) == "foot" {
    // rust: facing
    // rust: } else {
    // rust: facing.opposite()
}
}
    // rust: pub(crate) fn chest_can_connect_to(&self, state: BlockStateId, other: BlockStateId) -> bool {
    // rust: let b = self.b;
    // rust: if b.instance_of(state, Class::CopperChest) {
    // rust: b.tag("minecraft:copper_chests")
    // rust: .is_some_and(|tag| b.in_set(other, tag))
    // rust: && b.table.has(other, b.props.kind)
    // rust: } else {
    // rust: b.block(state) == b.block(other)
}
}
    /// `ChestBlock.getConnectedDirection`.
    // rust: pub(crate) fn chest_connected_direction(&self, state: BlockStateId) -> Direction {
    // rust: let facing = self.b.facing(state);
    // rust: if self.b.table.text(state, self.b.props.kind) == "left" {
    // rust: clockwise(facing)
    // rust: } else {
    // rust: counter_clockwise(facing)
}
}
    /// `FenceBlock.connectsTo`.
    // rust: pub(crate) fn fence_connects_to(
    // rust: &self,
    // rust: fence: BlockStateId,
    // rust: state: BlockStateId,
    // rust: face_solid: bool,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let t = &b.tags;
    // rust: let same_fence = b.in_set(state, &t.fences)
    // rust: && b.in_set(state, &t.wooden_fences) == b.in_set(fence, &t.wooden_fences);
    // rust: let gate = b.instance_of(state, Class::FenceGate)
    // rust: && axis_of(b.facing(state)) == axis_of(clockwise(direction));
    // rust: (!b.is_exception_for_connection(state) && face_solid) || same_fence || gate
}
    /// `IronBarsBlock.attachsTo`.
    // rust: pub(crate) fn bars_attach_to(&self, state: BlockStateId, face_solid: bool) -> bool {
    // rust: let b = self.b;
    // rust: (!b.is_exception_for_connection(state) && face_solid)
    // rust: || b.instance_of(state, Class::IronBars)
    // rust: || b.in_set(state, &b.tags.walls)
}
    /// `WallBlock.connectsTo`.
    // rust: pub(crate) fn wall_connects_to(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: face_solid: bool,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let gate = b.instance_of(state, Class::FenceGate)
    // rust: && axis_of(b.facing(state)) == axis_of(clockwise(direction));
    // rust: b.in_set(state, &b.tags.walls)
    // rust: || (!b.is_exception_for_connection(state) && face_solid)
    // rust: || b.instance_of(state, Class::IronBars)
    // rust: || gate
}
    /// `WallBlock.updateShape(level, state, topPos, topNeighbour, n, e, s, w)`.
    // rust: pub(crate) fn wall_shape(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: top_pos: BlockPos,
    // rust: top: BlockStateId,
    // rust: sides: [bool; 4],
    // rust: ) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let table = &b.table;
    // rust: let cover = self.shape_info_at(top, top_pos).wall_cover;
    // rust: let mut result = state;
    // rust: let directions = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ];
    // rust: for (i, direction) in directions.into_iter().enumerate() {
    // rust: let value = if !sides[i] {
    // rust: "none"
    // rust: } else if cover & (1 << (i + 1)) != 0 {
    // rust: "tall"
    // rust: } else {
    // rust: "low"
}
    // rust: result = table.set_text(result, self.direction_prop(direction), value);
}
        // shouldRaisePost
    // rust: let side = |d: Direction| table.text(result, self.direction_prop(d)).to_owned();
    // rust: let (north, south, east, west) = (
    // rust: side(Direction::North),
    // rust: side(Direction::South),
    // rust: side(Direction::East),
    // rust: side(Direction::West),
    // rust: );
    // rust: let raise = if b.instance_of(top, Class::Wall) && table.bool(top, b.props.up) {
    // rust: true
    // rust: } else {
    // rust: let (nn, sn, en, wn) = (
    // rust: north == "none",
    // rust: south == "none",
    // rust: east == "none",
    // rust: west == "none",
    // rust: );
    // rust: if (nn && sn && wn && en) || nn != sn || wn != en {
    // rust: true
    // rust: } else if (north == "tall" && south == "tall") || (east == "tall" && west == "tall") {
    // rust: false
    // rust: } else {
    // rust: b.in_set(top, &b.tags.wall_post_override) || cover & 1 != 0
}
}
    // rust: table.set_bool(result, b.props.up, raise)
}
    /// `StairBlock.getStairsShape`.
    // rust: pub(crate) fn stairs_shape(&self, state: BlockStateId, pos: BlockPos) -> &'static str {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let table = &b.table;
    // rust: let facing = b.facing(state);
    // rust: let half = table.text(state, p.half);
    // rust: let behind = self.rel_state(pos, facing);
    // rust: if b.instance_of(behind, Class::Stair) && table.text(behind, p.half) == half {
    // rust: let behind_facing = b.facing(behind);
    // rust: if axis_of(behind_facing) != axis_of(facing)
    // rust: && self.stairs_can_take_shape(state, pos, behind_facing.opposite())
    // rust: {
    // rust: return if behind_facing == counter_clockwise(facing) {
    // rust: "outer_left"
    // rust: } else {
    // rust: "outer_right"
}
}
}
    // rust: let front = self.rel_state(pos, facing.opposite());
    // rust: if b.instance_of(front, Class::Stair) && table.text(front, p.half) == half {
    // rust: let front_facing = b.facing(front);
    // rust: if axis_of(front_facing) != axis_of(facing)
    // rust: && self.stairs_can_take_shape(state, pos, front_facing)
    // rust: {
    // rust: return if front_facing == counter_clockwise(facing) {
    // rust: "inner_left"
    // rust: } else {
    // rust: "inner_right"
}
}
}
    // rust: "straight"
}
    // rust: fn stairs_can_take_shape(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let neighbour = self.rel_state(pos, direction);
    // rust: !b.instance_of(neighbour, Class::Stair)
    // rust: || b.facing(neighbour) != b.facing(state)
    // rust: || b.table.text(neighbour, b.props.half) != b.table.text(state, b.props.half)
}
    /// `TripWireBlock.shouldConnectTo`.
    // rust: pub(crate) fn tripwire_should_connect_to(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: direction: Direction,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: if b.is_block(state, b.named.tripwire_hook) {
    // rust: b.facing(state) == direction.opposite()
    // rust: } else {
    // rust: b.is_block(state, b.named.tripwire)
}
}
    /// `LeavesBlock.getDistanceAt`.
    // rust: pub(crate) fn leaf_distance_at(&self, state: BlockStateId) -> i32 {
    // rust: let b = self.b;
    // rust: if b.in_set(state, &b.tags.prevents_nearby_leaf_decay) {
    // rust: 0
    // rust: } else if b.table.has(state, b.props.distance) {
    // rust: b.table.int(state, b.props.distance)
    // rust: } else {
    // rust: 7
}
}
    /// `ConcretePowderBlock.touchesLiquid`.
    // rust: pub(crate) fn concrete_touches_liquid(&self, pos: BlockPos) -> bool {
    // rust: let b = self.b;
    // rust: let solidifies = |state: BlockStateId| b.is_water_fluid(b.fluid(state).kind());
    // rust: let mut test = pos;
    // rust: for direction in Direction::ALL {
    // rust: let current = self.state(test);
    // rust: if direction != Direction::Down || solidifies(current) {
    // rust: test = rel(pos, direction);
    // rust: let state = self.state(test);
    // rust: if solidifies(state) && !b.is_face_sturdy(state, direction.opposite()) {
    // rust: return true;
}
}
}
    // rust: false
}
    // rust: pub(crate) fn coral_scan_for_water(&self, pos: BlockPos) -> bool {
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .any(|d| self.b.is_water_fluid(self.fluid_at(rel(pos, d)).kind()))
}
    /// `BaseCoralPlantTypeBlock.scanForWater(state, level, pos)`.
    // rust: pub(crate) fn coral_plant_scan_for_water(&self, state: BlockStateId, pos: BlockPos) -> bool {
    // rust: if self.b.is_waterlogged(state) {
    // rust: return true;
}
    // rust: self.coral_scan_for_water(pos)
}
    /// `BaseCoralPlantTypeBlock.tryScheduleDieTick`.
    // rust: pub(crate) fn coral_try_schedule_die_tick(&mut self, state: BlockStateId, pos: BlockPos) {
    // rust: if !self.coral_plant_scan_for_water(state, pos) {
    // rust: let delay = 60 + self.random().next_int_bound(40).unwrap_or(0);
    // rust: let block = self.b.block(state);
    // rust: self.schedule_tick(pos, block, delay);
}
}
    /// `BubbleColumnBlock.canOccupy`.
    // rust: pub(crate) fn bubble_column_can_occupy(&self, state: BlockStateId) -> bool {
    // rust: let b = self.b;
    // rust: let fluid = b.fluid(state);
    // rust: b.is_block(state, b.named.bubble_column)
    // rust: || (b.fluid_in(fluid.kind(), b.fluid_tags.bubble_column_can_occupy)
    // rust: && b.instance_of(state, Class::Liquid)
    // rust: && fluid.is_source()
    // rust: && fluid.amount() >= 8)
}
    // rust: pub(crate) fn should_bubble_column_occupy(&self, state: BlockStateId) -> bool {
    // rust: let fluid = self.b.fluid(state);
    // rust: self.b
    // rust: .fluid_in(fluid.kind(), self.b.fluid_tags.bubble_column_can_occupy)
    // rust: && fluid.is_source()
    // rust: && fluid.is_full()
}
    // rust: pub(crate) fn try_schedule_bubble_column(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: below_state: BlockStateId,
    // rust: block: BlockId,
    // rust: ) {
    // rust: let t = &self.b.tags;
    // rust: if self
    // rust: .b
    // rust: .in_set(below_state, &t.enables_bubble_column_drag_down)
    // rust: || self.b.in_set(below_state, &t.enables_bubble_column_push_up)
    // rust: {
    // rust: self.schedule_tick(pos, block, 20);
}
}
    /// `NoteBlock.setInstrument`.
    // rust: pub(crate) fn note_block_instrument(&self, pos: BlockPos, state: BlockStateId) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let above = b.facts(self.above_state(pos)).instrument;
    // rust: let name = if super::data::instrument_works_above(above) {
    // rust: above
    // rust: } else {
    // rust: let below = b.facts(self.below_state(pos)).instrument;
    // rust: if super::data::instrument_works_above(below) {
    // rust: 0
    // rust: } else {
    // rust: below
}
}
    // rust: b.table.set_text(
    // rust: state,
    // rust: b.props.instrument,
    // rust: super::data::INSTRUMENTS[name as usize],
    // rust: )
}
    /// `SpeleothemBlock.calculateSpeleothemThickness`.
    // rust: pub(crate) fn speleothem_thickness(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: tip: Direction,
    // rust: merge: bool,
    // rust: ) -> &'static str {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let base = tip.opposite();
    // rust: let is_with = |state: BlockStateId, direction: Direction| {
    // rust: b.tag("minecraft:speleothems")
    // rust: .is_some_and(|tag| b.in_set(state, tag))
    // rust: && b.table.dir(state, p.vertical_direction) == Some(direction)
}
    // rust: let front = self.rel_state(pos, tip);
    // rust: let block = b.block(self.state(pos));
    // rust: if is_with(front, base) && b.is_block(front, block) {
    // rust: if !merge && b.table.text(front, p.thickness) != "tip_merge" {
    // rust: "tip"
    // rust: } else {
    // rust: "tip_merge"
}
    // rust: } else if !is_with(front, tip) {
    // rust: "tip"
    // rust: } else {
    // rust: let front_thickness = b.table.text(front, p.thickness);
    // rust: if front_thickness != "tip" && front_thickness != "tip_merge" {
    // rust: let behind = self.rel_state(pos, base);
    // rust: if !is_with(behind, tip) {
    // rust: "base"
    // rust: } else {
    // rust: "middle"
}
    // rust: } else {
    // rust: "frustum"
}
}
}
    /// `FireBlock.getStateWithAge` via `BaseFireBlock.getState`.
    // rust: pub(crate) fn fire_state_with_age(&self, pos: BlockPos, age: i32) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let placement = self.fire_state_for(pos);
    // rust: if b.is_block(placement, b.named.fire) {
    // rust: b.table.set_int(placement, b.props.age, age)
    // rust: } else {
    // rust: placement
}
}
    /// `BaseFireBlock.getState(level, pos)`.
    // rust: pub(crate) fn fire_state_for(&self, pos: BlockPos) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let below_pos = below(pos);
    // rust: let below_state = self.state(below_pos);
    // rust: if b.in_set(below_state, &b.tags.soul_fire_base_blocks) {
    // rust: return b.default_of(b.named.soul_fire);
}
    // rust: let fire = b.default_of(b.named.fire);
    // rust: if !self.can_burn(below_state) && !b.is_face_sturdy(below_state, Direction::Up) {
    // rust: let mut result = fire;
    // rust: for direction in Direction::ALL {
    // rust: if direction == Direction::Down {
    // rust: continue;
}
    // rust: let burn = self.can_burn(self.rel_state(pos, direction));
    // rust: result = b
    // rust: .table
    // rust: .set_bool(result, self.direction_prop(direction), burn);
}
    // rust: result
    // rust: } else {
    // rust: fire
}
}
    /// `MossyCarpetBlock.getUpdatedState`.
    // rust: pub(crate) fn mossy_carpet_updated_state(
    // rust: &self,
    // rust: mut state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: create_sides: bool,
    // rust: ) -> BlockStateId {
    // rust: let b = self.b;
    // rust: let table = &b.table;
    // rust: let block = b.block(state);
    // rust: let base = table.bool(state, b.props.bottom);
    // rust: let create_sides = create_sides || base;
    // rust: let mut above_state = None;
    // rust: let mut below_state = None;
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: let key = self.direction_prop(direction);
    // rust: let supported = b.multiface_can_attach(self.rel_state(pos, direction), direction);
    // rust: let mut side = if supported {
    // rust: if create_sides {
    // rust: "low"
    // rust: } else {
    // rust: table.text(state, key)
}
    // rust: } else {
    // rust: "none"
}
    // rust: if side == "low" {
    // rust: let above = *above_state.get_or_insert_with(|| self.above_state(pos));
    // rust: if b.is_block(above, block)
    // rust: && table.text(above, key) != "none"
    // rust: && !table.bool(above, b.props.bottom)
    // rust: {
    // rust: side = "tall";
}
    // rust: if !base {
    // rust: let below = *below_state.get_or_insert_with(|| self.below_state(pos));
    // rust: if b.is_block(below, block) && table.text(below, key) == "none" {
    // rust: side = "none";
}
}
}
    // rust: let side = side.to_owned();
    // rust: state = table.set_text(state, key, &side);
}
    // rust: state
}
    // rust: pub(crate) fn mossy_carpet_has_faces(&self, state: BlockStateId) -> bool {
    // rust: let b = self.b;
    // rust: table_bool(b, state)
    // rust: || [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ]
    // rust: .into_iter()
    // rust: .any(|d| b.table.text(state, self.direction_prop(d)) != "none")
}
}

pub fn table_bool(b: *super::Behaviours, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: b.table.bool(state, b.props.bottom)
}
pub fn class_is(b: *super::Behaviours, block: BlockId, class: Class) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: b.block_data(block).is(class)
}
