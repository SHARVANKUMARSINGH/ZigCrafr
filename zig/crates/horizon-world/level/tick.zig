//! Transpiled from Horizon Rust crate
//! Module: horizon-world_tick
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Scheduled block ticks (`BlockBehaviour.tick`), random ticks
//! (`BlockBehaviour.randomTick`) and the per-tick drivers.
// use super::{
    // rust: Behaviours, LevelAccess, LevelEvent, Sim, Spread, Ticks,
    // rust: classes::Class,
    // rust: data::state_flags,
    // rust: update::{HORIZONTAL, above, below, rel},
}
// use crate::{fluid::FluidKind, registry::BlockStateId};
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: position::{BlockPos, ChunkPos},
    // rust: random::RandomSource,
    // rust: ticks::TickTypeId,
}
// use std::rc::Rc;
// use std::sync::Arc;

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
pub fn rand_int(self: *Self, bound: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.random().next_int_bound(bound).unwrap_or(0)
}

    /// `BlockState.tick` (scheduled block tick).
pub fn tick_block(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let block = b.block(state);
    // rust: let chain = &b.data(state).chain;
    // rust: for &class in chain.iter() {
    // rust: match class {
    // rust: Class::BambooStalk
    // rust: | Class::BigDripleafStem
    // rust: | Class::Cactus
    // rust: | Class::ChorusFlower
    // rust: | Class::ChorusPlant
    // rust: | Class::GrowingPlant
    // rust: | Class::SugarCane => {
    // rust: if !self.can_survive(state, pos) {
    // rust: self.destroy_block(pos, true, 512);
}
}
    // rust: Class::HangingMoss => {
    // rust: let above_state = self.above_state(pos);
    // rust: if !(b.multiface_can_attach(above_state, Direction::Up)
    // rust: || b.is_block(above_state, block))
    // rust: {
    // rust: self.destroy_block(pos, true, 512);
}
}
    // rust: Class::BasePressurePlate => {
    // rust: let signal = self.plate_signal_for_state(state);
    // rust: if signal > 0 {
    // rust: self.plate_check_pressed(pos, state, signal);
}
}
    // rust: Class::DetectorRail => {
    // rust: if b.table.bool(state, b.props.powered) {
    // rust: self.detector_rail_check_pressed(pos, state);
}
}
    // rust: Class::BigDripleaf => self.big_dripleaf_tick(pos, state),
    // rust: Class::AbstractCauldron => self.cauldron_tick(state, pos),
    // rust: Class::BubbleColumn => {
    // rust: let below_state = self.below_state(pos);
    // rust: self.bubble_column_update(pos, state, below_state);
}
    // rust: Class::Button => self.button_tick(pos, state),
    // rust: Class::Diode => self.diode_tick(pos, state),
    // rust: Class::Composter => {
    // rust: if b.table.int(state, p.level) == 7 {
    // rust: self.set_block_and_update(pos, b.table.cycle(state, p.level));
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.composter.ready".into(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
}
}
    // rust: Class::Coral => {
    // rust: if !self.coral_scan_for_water(pos) {
    // rust: if let Some(dead) = b.data(state).link {
    // rust: let next = b.default_of(dead);
    // rust: if self.level.allow_block_fade(pos, state, next) {
    // rust: self.set_block(pos, next, 2);
}
}
}
}
    // rust: Class::CoralFan | Class::CoralPlant | Class::CoralWallFan => {
    // rust: if !self.coral_plant_scan_for_water(state, pos) {
    // rust: if let Some(dead) = b.data(state).link {
    // rust: let mut next =
    // rust: b.table.set_bool(b.default_of(dead), p.waterlogged, false);
    // rust: if class == Class::CoralWallFan {
    // rust: next = b.table.set_dir(next, p.facing, b.facing(state));
}
    // rust: if self.level.allow_block_fade(pos, state, next) {
    // rust: self.set_block(pos, next, 2);
}
}
}
}
    // rust: Class::Chest | Class::EnderChest => {
                    // recheckOpen: openerCountChanged broadcasts the lid, a
                    // trapped chest also updates its neighbours on a change,
                    // and the recheck repeats while anyone has it open.
    // rust: if let Some((previous, count)) = self.level.recheck_container_openers(pos) {
    // rust: self.block_event(pos, block, 1, count);
    // rust: if previous != count && b.data(state).is(Class::TrappedChest) {
    // rust: self.trapped_chest_update_neighbors(pos, state);
}
    // rust: if count > 0 {
    // rust: self.schedule_tick(pos, block, 5);
}
}
}
    // rust: Class::Barrel => {
                    // BarrelBlock.tick → BarrelBlockEntity.recheckOpen →
                    // ContainerOpenersCounter.recheckOpeners: the barrel
                    // recounts its openers, and the count crossing zero opens
                    // or closes it. Unlike a chest it broadcasts no block
                    // event (BarrelBlockEntity$1.openerCountChanged is empty):
                    // the `open` property, the barrel's own sound and the
                    // container game events are its whole report.
    // rust: if let Some((previous, count)) = self.level.recheck_container_openers(pos) {
    // rust: if previous != count {
    // rust: let open = count > 0;
    // rust: let sound: Arc<str> = if open {
    // rust: "minecraft:block.barrel.open".into()
    // rust: } else {
    // rust: "minecraft:block.barrel.close".into()
}
                            // BarrelBlockEntity.playSound: volume 0.5, pitch
                            // 0.9 to 1.0 from the level random.
    // rust: let pitch = 0.9 + self.random().next_float() * 0.1;
    // rust: self.sound(pos, &sound, 0.5, pitch);
                            // BarrelBlockEntity.updateBlockState.
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, p.open, open));
    // rust: self.game_event(
    // rust: pos,
    // rust: if open {
    // rust: "minecraft:container_open"
    // rust: } else {
    // rust: "minecraft:container_close"
    // rust: },
    // rust: );
}
                        // ContainerOpenersCounter.scheduleRecheck holds only
                        // while someone has it open.
    // rust: if count > 0 {
    // rust: self.schedule_tick(pos, block, 5);
}
}
}
    // rust: Class::Dispenser | Class::Crafter => {
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "dispense",
    // rust: });
}
                // CommandBlock.tick runs commands: the caller does it.
    // rust: Class::Command => {
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "command_block",
    // rust: });
}
                // TestBlock.tick resets the block entity: the caller owns it.
    // rust: Class::TestBlock => {
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "test_block_tick",
    // rust: });
}
    // rust: Class::FallingBlock => self.falling_block_tick(pos, state),
    // rust: Class::Brushable => {
                    // BrushableBlock.tick checks the brush reset first (the
                    // caller keeps the brush counts).
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "brushable",
    // rust: });
    // rust: if self.is_free(self.below_state(pos)) && pos.y >= self.level.min_y() {
    // rust: self.falling_block_fall(pos, state, None);
}
}
    // rust: Class::Farmland => {
    // rust: if !self.can_survive(state, pos) {
    // rust: self.turn_to_base_block(pos, state);
}
}
    // rust: Class::Path => self.turn_to_base_block(pos, state),
    // rust: Class::Fire => self.fire_tick(pos, state),
    // rust: Class::Frogspawn => {
    // rust: if !self.can_survive(state, pos) {
    // rust: self.destroy_block(pos, false, 512);
    // rust: } else {
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "hatch",
    // rust: });
    // rust: self.destroy_block(pos, false, 512);
}
}
    // rust: Class::FrostedIce => self.frosted_ice_tick(pos, state),
    // rust: Class::Leaves => {
    // rust: let next = self.leaves_update_distance(state, pos);
    // rust: self.set_block_and_update(pos, next);
}
                // LecternBlock.tick: the page-turn pulse ends.
    // rust: Class::Lectern => {
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, p.powered, false));
    // rust: self.lectern_update_below(pos, state);
}
    // rust: Class::LightningRod => {
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, p.powered, false));
    // rust: self.lightning_rod_update_neighbors(pos, state);
}
    // rust: Class::Liquid => {
    // rust: if self.should_bubble_column_occupy(state) {
    // rust: let below_state = self.below_state(pos);
    // rust: let column = b.named.bubble_column;
    // rust: self.bubble_column_update_for(column, pos, state, below_state);
}
}
    // rust: Class::Observer => self.observer_tick(pos, state),
    // rust: Class::Eyeblossom => self.eyeblossom_tick(state, pos, false),
    // rust: Class::CreakingHeart => self.heart_tick(state, pos),
    // rust: Class::DriedGhast => self.dried_ghast_tick(state, pos),
    // rust: Class::SnifferEgg => self.sniffer_egg_tick(state, pos),
    // rust: Class::RedstoneLamp => self.lamp_tick(pos, state),
    // rust: Class::RedstoneTorch => self.torch_tick(pos, state),
    // rust: Class::Scaffolding => self.scaffolding_tick(pos, state),
    // rust: Class::SculkSensor => self.sculk_sensor_tick(pos, state),
    // rust: Class::SculkShrieker => self.sculk_shrieker_tick(pos, state),
    // rust: Class::SculkCatalyst => self.sculk_catalyst_tick(pos, state),
    // rust: Class::Speleothem => {
    // rust: let tip = b.table.dir(state, p.vertical_direction);
    // rust: if tip == Some(Direction::Up) && !self.can_survive(state, pos) {
    // rust: self.destroy_block(pos, true, 512);
    // rust: } else {
    // rust: self.spawn_falling_stalactite(pos, state);
}
}
    // rust: Class::Target => {
    // rust: if b.table.int(state, p.power) != 0 {
    // rust: self.set_block_and_update(pos, b.table.set_int(state, p.power, 0));
}
}
    // rust: Class::TripWire => self.tripwire_tick(pos),
    // rust: Class::TripWireHook => {
    // rust: self.tripwire_hook_calculate(pos, state, false, true, -1, None)
}
    // rust: _ => continue,
}
    // rust: return;
}
}

    /// `ServerLevel.tickBlock` once the block at `pos` is the tick's: the
    /// level may handle the tick first, else `BlockState.tick`.
pub fn tick_due_block(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let (mut current, mut handled) = (state, false);
    // rust: self.level
    // rust: .before_tick_block(self.ticks, pos, &mut current, &mut handled);
        // A block the level changed ticks as it is now, if it is still the
        // tick's block.
    // rust: if !handled && (current == state || self.block_of(current) == self.block_of(state)) {
    // rust: self.tick_block(current, pos);
}
}

    /// `BlockState.randomTick` followed by the fluid's random tick.
pub fn random_tick_at(self: *Self, pos: BlockPos) void {
}
    // rust: let state = self.state(pos);
    // rust: if self.b.is_randomly_ticking(state) {
    // rust: let (mut current, mut handled) = (state, false);
    // rust: self.level
    // rust: .before_random_tick(self.ticks, pos, &mut current, &mut handled);
            // A block the level changed ticks as it is now, if it still ticks
            // randomly.
    // rust: if !handled && (current == state || self.b.is_randomly_ticking(current)) {
    // rust: self.random_tick_block(current, pos);
}
}
        // Only lava's fluid state ticks randomly. A lava block is ticked twice
        // (LiquidBlock.randomTick, then FluidState.randomTick), as in vanilla.
    // rust: let fluid = self.b.fluid(state).kind();
    // rust: if matches!(fluid, FluidKind::Lava | FluidKind::FlowingLava) {
    // rust: self.lava_random_tick(pos);
}
}

pub fn random_tick_block(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let block = b.block(state);
    // rust: let data = b.data(state);
    // rust: let chain = &data.chain;
    // rust: for class in chain.iter().copied() {
    // rust: match class {
    // rust: Class::BambooSapling => {
    // rust: if self.rand_int(3) == 0
    // rust: && self.is_empty_block(above(pos))
    // rust: && self.raw_brightness(above(pos), 0) >= 9
    // rust: {
    // rust: self.bamboo_sapling_grow(pos);
}
}
    // rust: Class::BambooStalk => {
    // rust: if b.table.int(state, p.stage) == 0
    // rust: && self.rand_int(3) == 0
    // rust: && self.is_empty_block(above(pos))
    // rust: && self.raw_brightness(above(pos), 0) >= 9
    // rust: {
    // rust: let height = self.bamboo_height_below(pos) + 1;
    // rust: if height < 16 {
    // rust: self.bamboo_grow(state, pos, height);
}
}
}
    // rust: Class::Beetroot | Class::TorchflowerCrop => {
    // rust: if self.rand_int(3) != 0 {
    // rust: self.crop_random_tick(state, pos);
}
}
    // rust: Class::Crop => self.crop_random_tick(state, pos),
    // rust: Class::BuddingAmethyst => self.budding_amethyst_tick(pos),
    // rust: Class::Cactus => self.cactus_random_tick(state, pos),
    // rust: Class::ChorusFlower => self.chorus_flower_random_tick(state, pos),
    // rust: Class::Cocoa => {
    // rust: if self.rand_int(5) == 0 {
    // rust: let age = b.table.int(state, p.age);
    // rust: if age < 2 {
    // rust: self.set_block(pos, b.table.set_int(state, p.age, age + 1), 2);
}
}
}
    // rust: Class::Farmland => self.farmland_random_tick(state, pos),
    // rust: Class::NetherPortal => {
                    // NetherPortalBlock.randomTick: only the overworld sets
                    // NETHER_PORTAL_SPAWNS_PIGLINS.
    // rust: let rules = self.level.game_rules();
    // rust: let difficulty = self.level.difficulty();
    // rust: if rules.spawn_mobs
    // rust: && rules.spawn_monsters
    // rust: && difficulty != 0
    // rust: && self.level.dimension() == super::Dimension::Overworld
    // rust: && self.rand_int(2000) < difficulty
    // rust: {
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "portal_spawn",
    // rust: });
}
}
    // rust: Class::GrowingPlantHead => {
    // rust: if b.table.int(state, p.age) < 25
    // rust: && self.random().next_double() < data.grow_probability
    // rust: {
    // rust: let growth = rel(pos, data.growth_direction);
    // rust: if self.growing_plant_can_grow_into(state, self.state(growth)) {
    // rust: let next = self.growing_plant_grow_into_state(state);
    // rust: self.set_block_and_update(growth, next);
}
}
}
    // rust: Class::Ice => {
    // rust: if self.level.block_light(pos) > 11 - i32::from(b.facts(state).dampening) {
    // rust: self.ice_melt(pos, state);
}
}
    // rust: Class::Leaves => {
    // rust: if !b.table.bool(state, p.persistent) && b.table.int(state, p.distance) == 7 {
    // rust: if !self.level.allow_leaves_decay(pos) {
    // rust: continue;
}
    // rust: self.drop_resources(state, pos);
    // rust: self.remove_block(pos, false);
}
}
    // rust: Class::Liquid => {
    // rust: if matches!(
    // rust: b.fluid(state).kind(),
    // rust: FluidKind::Lava | FluidKind::FlowingLava
    // rust: ) {
    // rust: self.lava_random_tick(pos);
}
}
    // rust: Class::MangrovePropagule => {
    // rust: if !b.table.bool(state, p.hanging) {
    // rust: if self.rand_int(7) == 0 {
    // rust: self.sapling_advance_tree(pos, state);
}
    // rust: } else if b.table.int(state, p.age) != 4 {
    // rust: self.set_block(pos, b.table.cycle(state, p.age), 2);
}
}
    // rust: Class::Sapling => {
    // rust: if self.max_local_raw_brightness(above(pos)) >= 9 && self.rand_int(7) == 0 {
    // rust: self.sapling_advance_tree(pos, state);
}
}
    // rust: Class::Mushroom => self.mushroom_random_tick(state, pos),
    // rust: Class::NetherWart => {
    // rust: let age = b.table.int(state, p.age);
    // rust: if age < 3 && self.rand_int(10) == 0 {
    // rust: self.set_block(pos, b.table.set_int(state, p.age, age + 1), 2);
}
}
    // rust: Class::Nylium => {
    // rust: if !self.can_be_nylium(state, pos) {
    // rust: self.set_block_and_update(pos, b.default_of(b.named.netherrack));
}
}
    // rust: Class::PitcherCrop => {
    // rust: let speed = self.crop_growth_speed(block, pos);
    // rust: if self.rand_int((25.0 / speed) as i32 + 1) == 0 {
    // rust: self.pitcher_grow(state, pos, 1);
}
}
    // rust: Class::Speleothem => self.speleothem_random_tick(state, pos),
    // rust: Class::RedStoneOre => {
    // rust: if b.table.bool(state, p.lit) {
    // rust: self.set_block_and_update(pos, b.table.set_bool(state, p.lit, false));
}
}
    // rust: Class::SnowLayer => {
    // rust: if self.level.block_light(pos) > 11 {
    // rust: if !self.level.allow_block_fade(pos, state, b.air()) {
    // rust: continue;
}
    // rust: self.drop_resources(state, pos);
    // rust: self.remove_block(pos, false);
    // rust: self.game_event(pos, "minecraft:block_destroy");
}
}
    // rust: Class::SpreadingSnowy => self.spreading_snowy_tick(state, pos),
    // rust: Class::Stem => self.stem_random_tick(state, pos),
    // rust: Class::SugarCane => {
    // rust: if self.is_empty_block(above(pos)) {
    // rust: let mut height = 1;
    // rust: while b.is_block(self.state(pos.offset(0, -height, 0)), block) {
    // rust: height += 1;
}
    // rust: if height < 3 {
    // rust: let age = b.table.int(state, p.age);
    // rust: if age == 15 {
    // rust: self.set_block_and_update(above(pos), b.default_of(block));
    // rust: self.set_block(pos, b.table.set_int(state, p.age, 0), 260);
    // rust: } else {
    // rust: self.set_block(pos, b.table.set_int(state, p.age, age + 1), 260);
}
}
}
}
    // rust: Class::SweetBerryBush => {
    // rust: let age = b.table.int(state, p.age);
    // rust: if age < 3 && self.rand_int(5) == 0 && self.raw_brightness(above(pos), 0) >= 9 {
    // rust: let next = b.table.set_int(state, p.age, age + 1);
    // rust: self.set_block(pos, next, 2);
    // rust: self.game_event(pos, "minecraft:block_change");
}
}
    // rust: Class::Vine => self.vine_random_tick(state, pos),
    // rust: Class::Eyeblossom => self.eyeblossom_tick(state, pos, true),
    // rust: Class::FlowerPot => self.potted_eyeblossom_tick(state, pos),
    // rust: Class::TurtleEgg => self.turtle_egg_tick(state, pos),
    // rust: Class::DriedGhast => self.dried_ghast_random_tick(state, pos),
    // rust: Class::WeatheringCopperFull => self.copper_change_over_time(state, pos),
    // rust: _ => continue,
}
    // rust: return;
}
    // rust: if data.implements(super::classes::Interface::WeatheringCopper) {
    // rust: let upper_door = data.is(Class::Door) && b.table.text(state, p.half) == "upper";
    // rust: let right_chest = data.is(Class::Chest) && b.table.text(state, p.kind) == "right";
    // rust: if !upper_door && !right_chest {
    // rust: self.copper_change_over_time(state, pos);
}
}
}

    // ---- helpers ----

    // rust: pub(crate) fn turn_to_base_block(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let base = b.data(state).link.unwrap_or(b.named.dirt);
        // Block.pushEntitiesUp(state, base, level, pos): the game lifts what
        // stands in the new block's added top onto it.
    // rust: self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "push_entities_up",
    // rust: });
    // rust: self.set_block_and_update(pos, b.default_of(base));
    // rust: self.game_event(pos, "minecraft:block_change");
}
    /// `FallingBlock.isFree`.
    // rust: pub(crate) fn is_free(&self, state: BlockStateId) -> bool {
    // rust: let b = self.b;
    // rust: b.is_air(state)
    // rust: || b.tag("minecraft:fire")
    // rust: .is_some_and(|tag| b.in_set(state, tag))
    // rust: || b.liquid(state)
    // rust: || b.is_replaceable(state)
}
pub fn leaves_update_distance(self: *Self, state: BlockStateId, pos: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut distance = 7;
    // rust: for direction in Direction::ALL {
    // rust: distance = distance.min(self.leaf_distance_at(self.rel_state(pos, direction)) + 1);
    // rust: if distance == 1 {
    // rust: break;
}
}
    // rust: self.b.table.set_int(state, self.b.props.distance, distance)
}
    // rust: fn bubble_column_update(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: below_state: BlockStateId,
    // rust: ) {
    // rust: let column = self.b.block(state);
    // rust: self.bubble_column_update_for(column, pos, state, below_state);
}
    /// `BubbleColumnBlock.updateColumn(column, level, pos, occupyState, belowState)`.
    // rust: pub(crate) fn bubble_column_update_for(
    // rust: &mut self,
    // rust: column: super::states::BlockId,
    // rust: pos: BlockPos,
    // rust: occupy: BlockStateId,
    // rust: below_state: BlockStateId,
    // rust: ) {
    // rust: let b = self.b;
    // rust: if !self.bubble_column_can_occupy(occupy) {
    // rust: return;
}
    // rust: let column_state = if b.is_block(below_state, column) {
    // rust: below_state
    // rust: } else if b.in_set(below_state, &b.tags.enables_bubble_column_push_up) {
    // rust: b.table.set_bool(b.default_of(column), b.props.drag, false)
    // rust: } else if b.in_set(below_state, &b.tags.enables_bubble_column_drag_down) {
    // rust: b.table.set_bool(b.default_of(column), b.props.drag, true)
    // rust: } else if b.is_block(occupy, column) {
    // rust: b.default_of(b.named.water)
    // rust: } else {
    // rust: occupy
}
    // rust: self.set_block(pos, column_state, 2);
    // rust: let mut up = above(pos);
    // rust: while self.bubble_column_can_occupy(self.state(up)) {
    // rust: if !self.set_block(up, column_state, 2) {
    // rust: return;
}
    // rust: up = above(up);
}
}
pub fn big_dripleaf_tick(self: *Self, pos: BlockPos, state: BlockStateId) void {
}
    // rust: let b = self.b;
    // rust: let (next, delay) = match b.table.text(state, b.props.tilt) {
    // rust: _ if self.has_neighbor_signal(pos) => return self.big_dripleaf_reset_tilt(pos, state),
    // rust: "unstable" => ("partial", 10),
    // rust: "partial" => ("full", 100),
    // rust: "full" => return self.big_dripleaf_reset_tilt(pos, state),
    // rust: _ => return,
}
        // setTiltAndScheduleTick: PARTIAL and FULL cause vibrations.
    // rust: self.set_block(pos, b.table.set_text(state, b.props.tilt, next), 2);
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: let pitch = self.random().next_float() * 0.4 + 0.8;
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.big_dripleaf.tilt_down".into(),
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: });
    // rust: self.schedule_tick(pos, b.block(state), delay);
}
pub fn scaffolding_tick(self: *Self, pos: BlockPos, state: BlockStateId) void {
}
    // rust: let b = self.b;
    // rust: let distance = self.scaffolding_distance(pos);
    // rust: let bottom = self.scaffolding_is_bottom(pos, distance);
    // rust: let next = b.table.set_bool(
    // rust: b.table.set_int(state, b.props.distance, distance),
    // rust: b.props.bottom,
    // rust: bottom,
    // rust: );
    // rust: if distance == 7 {
    // rust: if b.table.int(state, b.props.distance) == 7 {
    // rust: self.falling_block_fall(pos, next, None);
    // rust: } else {
    // rust: self.destroy_block(pos, true, 512);
}
    // rust: } else if state != next {
    // rust: self.set_block_and_update(pos, next);
}
}
    /// `ScaffoldingBlock.isBottom`.
    // rust: pub(crate) fn scaffolding_is_bottom(&self, pos: BlockPos, distance: i32) -> bool {
    // rust: let b = self.b;
    // rust: distance > 0 && !b.is_block(self.below_state(pos), b.named.scaffolding)
}
pub fn fire_tick(self: *Self, pos: BlockPos, state: BlockStateId) void {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let block = b.block(state);
    // rust: let delay = 30 + self.rand_int(10);
    // rust: self.schedule_tick(pos, block, delay);
    // rust: if !self.level.can_spread_fire_around(pos) {
    // rust: return;
}
    // rust: if !self.can_survive(state, pos) {
    // rust: self.remove_block(pos, false);
}
    // rust: let below_state = self.below_state(pos);
    // rust: let infiniburn = match self.level.dimension() {
    // rust: super::Dimension::Overworld => &b.tags.infiniburn_overworld,
    // rust: super::Dimension::Nether => &b.tags.infiniburn_nether,
    // rust: super::Dimension::End => &b.tags.infiniburn_end,
}
    // rust: let infini = b.in_set(below_state, infiniburn);
    // rust: let age = b.table.int(state, p.age);
    // rust: let raining = self.level.is_raining();
    // rust: if !infini
    // rust: && raining
    // rust: && self.fire_near_rain(pos)
    // rust: && self.random().next_float() < 0.2 + age as f32 * 0.03
    // rust: {
    // rust: self.remove_block(pos, false);
    // rust: return;
}
    // rust: let new_age = 15.min(age + self.rand_int(3) / 2);
    // rust: let mut state = state;
    // rust: if age != new_age {
    // rust: state = b.table.set_int(state, p.age, new_age);
    // rust: self.set_block(pos, state, 260);
}
    // rust: if !infini {
    // rust: if !self.is_valid_fire_location(pos) {
    // rust: if !self.sturdy(below(pos), Direction::Up) || age > 3 {
    // rust: self.remove_block(pos, false);
}
    // rust: return;
}
    // rust: if age == 15 && self.rand_int(4) == 0 && !self.can_burn(self.below_state(pos)) {
    // rust: self.remove_block(pos, false);
    // rust: return;
}
}
        // FireBlock.tick: the INCREASED_FIRE_BURNOUT environment attribute.
    // rust: let burnout = self.level.increased_fire_burnout(pos);
    // rust: let extra = if burnout { -50 } else { 0 };
    // rust: for (direction, chance) in [
    // rust: (Direction::East, 300),
    // rust: (Direction::West, 300),
    // rust: (Direction::Down, 250),
    // rust: (Direction::Up, 250),
    // rust: (Direction::North, 300),
    // rust: (Direction::South, 300),
    // rust: ] {
    // rust: self.fire_check_burn_out(pos, rel(pos, direction), chance + extra, age);
}
    // rust: for xx in -1..=1 {
    // rust: for zz in -1..=1 {
    // rust: for yy in -1..=4 {
    // rust: if xx == 0 && yy == 0 && zz == 0 {
    // rust: continue;
}
    // rust: let mut rate = 100;
    // rust: if yy > 1 {
    // rust: rate += (yy - 1) * 100;
}
    // rust: let test = pos.offset(xx, yy, zz);
    // rust: let ignite = self.fire_ignite_odds_at(test);
    // rust: if ignite > 0 {
    // rust: let mut odds = (ignite + 40 + self.level.difficulty() * 7) / (age + 30);
    // rust: if burnout {
    // rust: odds /= 2;
}
    // rust: if odds > 0
    // rust: && self.rand_int(rate) <= odds
    // rust: && (!self.level.is_raining() || !self.fire_near_rain(test))
    // rust: {
    // rust: let spread_age = 15.min(age + self.rand_int(5) / 4);
    // rust: if self.level.allow_spread(Spread::Fire, pos, test)
    // rust: && self.level.allow_block_ignite(test, "spread")
    // rust: {
    // rust: let next = self.fire_state_with_age(test, spread_age);
    // rust: self.set_block_and_update(test, next);
}
}
}
}
}
}
}
    /// `FireBlock.getIgniteOdds(level, pos)`: only for air with flammable neighbours.
pub fn fire_ignite_odds_at(self: *Self, pos: BlockPos) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.is_empty_block(pos) {
    // rust: return 0;
}
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .map(|d| self.ignite_odds(self.rel_state(pos, d)))
    // rust: .max()
    // rust: .unwrap_or(0)
}
pub fn fire_near_rain(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level.is_raining_at(pos)
    // rust: || self.level.is_raining_at(rel(pos, Direction::West))
    // rust: || self.level.is_raining_at(rel(pos, Direction::East))
    // rust: || self.level.is_raining_at(rel(pos, Direction::North))
    // rust: || self.level.is_raining_at(rel(pos, Direction::South))
}
    /// `FireBlock.checkBurnOut` of the block at `pos` by the fire at `fire`.
pub fn fire_check_burn_out(self: *Self, fire: BlockPos, pos: BlockPos, chance: i32, age: i32) void {
}
    // rust: let b = self.b;
    // rust: let odds = self.burn_odds(self.state(pos));
    // rust: if self.rand_int(chance) < odds {
    // rust: let old = self.state(pos);
    // rust: let allowed = self.level.allow_spread(Spread::Fire, fire, pos);
    // rust: let mut burned = false;
    // rust: if self.rand_int(age + 10) < 5 && !self.level.is_raining_at(pos) {
    // rust: let new_age = (age + self.rand_int(5) / 4).min(15);
    // rust: if allowed
    // rust: && self.level.allow_block_burn(pos)
    // rust: && self.level.allow_block_ignite(pos, "spread")
    // rust: {
    // rust: let next = self.fire_state_with_age(pos, new_age);
    // rust: self.set_block_and_update(pos, next);
    // rust: burned = true;
}
    // rust: } else if allowed && self.level.allow_block_burn(pos) {
    // rust: self.remove_block(pos, false);
    // rust: burned = true;
}
    // rust: if burned && b.instance_of(old, Class::Tnt) {
    // rust: self.prime_tnt(pos);
}
}
}
pub fn frosted_ice_tick(self: *Self, pos: BlockPos, state: BlockStateId) void {
}
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: let fewer = |sim: &Self, at: BlockPos, limit: i32| {
    // rust: let mut count = 0;
    // rust: for d in Direction::ALL {
    // rust: if sim.b.is_block(sim.rel_state(at, d), block) {
    // rust: count += 1;
    // rust: if count >= limit {
    // rust: return false;
}
}
}
    // rust: true
}
    // rust: if self.rand_int(3) == 0 || fewer(self, pos, 4) {
    // rust: let brightness = if self.level.dimension() == super::Dimension::End {
    // rust: self.level.block_light(pos)
    // rust: } else {
    // rust: self.max_local_raw_brightness(pos)
}
    // rust: let age = b.table.int(state, b.props.age);
    // rust: if brightness > 11 - age - i32::from(b.facts(state).dampening)
    // rust: && self.frosted_slightly_melt(pos, state)
    // rust: {
    // rust: for direction in Direction::ALL {
    // rust: let neighbour_pos = rel(pos, direction);
    // rust: let neighbour = self.state(neighbour_pos);
    // rust: if b.is_block(neighbour, block)
    // rust: && !self.frosted_slightly_melt(neighbour_pos, neighbour)
    // rust: {
    // rust: let delay = self
    // rust: .random()
    // rust: .next_int_between_inclusive(20, 40)
    // rust: .unwrap_or(20);
    // rust: self.schedule_tick(neighbour_pos, block, delay);
}
}
    // rust: return;
}
}
    // rust: let delay = self
    // rust: .random()
    // rust: .next_int_between_inclusive(20, 40)
    // rust: .unwrap_or(20);
    // rust: self.schedule_tick(pos, block, delay);
}
pub fn frosted_slightly_melt(self: *Self, pos: BlockPos, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let age = b.table.int(state, b.props.age);
    // rust: if age < 3 {
    // rust: self.set_block(pos, b.table.set_int(state, b.props.age, age + 1), 2);
    // rust: false
    // rust: } else {
    // rust: self.ice_melt(pos, state);
    // rust: true
}
}

    // ---- crops and plants ----

    /// `CropBlock.getGrowthSpeed`.
    // rust: pub(crate) fn crop_growth_speed(&self, block: super::states::BlockId, pos: BlockPos) -> f32 {
    // rust: let b = self.b;
    // rust: let mut speed = 1.0f32;
    // rust: let under = below(pos);
    // rust: for xx in -1..=1 {
    // rust: for zz in -1..=1 {
    // rust: let mut block_speed = 0.0f32;
    // rust: let state = self.state(under.offset(xx, 0, zz));
    // rust: if b.in_set(state, &b.tags.grows_crops) {
    // rust: block_speed = 1.0;
    // rust: if b.table.int(state, b.props.moisture) > 0 {
    // rust: block_speed = 3.0;
}
}
    // rust: if xx != 0 || zz != 0 {
    // rust: block_speed /= 4.0;
}
    // rust: speed += block_speed;
}
}
    // rust: let is = |at: BlockPos| b.is_block(self.state(at), block);
    // rust: let (n, s, w, e) = (
    // rust: rel(pos, Direction::North),
    // rust: rel(pos, Direction::South),
    // rust: rel(pos, Direction::West),
    // rust: rel(pos, Direction::East),
    // rust: );
    // rust: let horizontal = is(w) || is(e);
    // rust: let vertical = is(n) || is(s);
    // rust: let diagonal = is(rel(w, Direction::North))
    // rust: || is(rel(e, Direction::North))
    // rust: || is(rel(e, Direction::South))
    // rust: || is(rel(w, Direction::South));
    // rust: if (horizontal && vertical) || diagonal {
    // rust: speed /= 2.0;
}
    // rust: speed
}
pub fn crop_random_tick(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: if self.raw_brightness(pos, 0) < 9 {
    // rust: return;
}
    // rust: let age = b.table.int(state, b.props.age);
    // rust: let max = self.crop_max_age(state);
    // rust: if age < max {
    // rust: let speed = self.crop_growth_speed(b.block(state), pos);
    // rust: if self.rand_int((25.0 / speed) as i32 + 1) == 0 {
    // rust: let next = self.crop_state_for_age(state, age + 1);
    // rust: self.set_block(pos, next, 2);
}
}
}
pub fn stem_random_tick(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: if self.raw_brightness(pos, 0) < 9 {
    // rust: return;
}
    // rust: let speed = self.crop_growth_speed(b.block(state), pos);
    // rust: if self.rand_int((25.0 / speed) as i32 + 1) != 0 {
    // rust: return;
}
    // rust: let age = b.table.int(state, b.props.age);
    // rust: if age < 7 {
    // rust: self.set_block(pos, b.table.set_int(state, b.props.age, age + 1), 2);
    // rust: return;
}
    // rust: let direction = HORIZONTAL[self.rand_int(4) as usize];
    // rust: let relative = rel(pos, direction);
    // rust: let data = b.data(state);
    // rust: let below_state = self.below_state(relative);
    // rust: if b.is_air(self.state(relative))
    // rust: && data
    // rust: .support_tag2
    // rust: .as_ref()
    // rust: .is_some_and(|tag| b.in_set(below_state, tag))
    // rust: {
    // rust: if let (Some(fruit), Some(stem)) = (data.link, data.link2) {
    // rust: self.set_block_and_update(relative, b.default_of(fruit));
    // rust: self.set_block_and_update(
    // rust: pos,
    // rust: b.table
    // rust: .set_dir(b.default_of(stem), b.props.facing, direction),
    // rust: );
}
}
}
    /// `PitcherCropBlock.grow`.
    // rust: pub(crate) fn pitcher_grow(&mut self, state: BlockStateId, pos: BlockPos, increase: i32) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let (lower_pos, lower) = if b.table.text(state, p.half) == "upper" {
    // rust: let below_pos = below(pos);
    // rust: let below_state = self.state(below_pos);
    // rust: if !b.is_block(below_state, b.named.pitcher_crop)
    // rust: || b.table.text(below_state, p.half) != "lower"
    // rust: {
    // rust: return;
}
    // rust: (below_pos, below_state)
    // rust: } else {
    // rust: (pos, state)
}
    // rust: let new_age = b.table.int(lower, p.age) + increase;
    // rust: let can_grow = b.table.int(lower, p.age) < 4
    // rust: && self.raw_brightness(lower_pos, 0) >= 8
    // rust: && self.is_inside_build_height(lower_pos.y + 1)
    // rust: && (new_age < 3 || {
    // rust: let upper = self.state(above(lower_pos));
    // rust: b.is_air(upper) || b.is_block(upper, b.named.pitcher_crop)
    // rust: });
    // rust: if !can_grow {
    // rust: return;
}
    // rust: let grown = b.table.set_int(lower, p.age, new_age);
    // rust: self.set_block(lower_pos, grown, 2);
    // rust: if new_age >= 3 {
    // rust: let upper_pos = above(lower_pos);
    // rust: let upper = b.table.set_text(grown, p.half, "upper");
    // rust: let upper = b
    // rust: .table
    // rust: .with_bool(upper, p.waterlogged, self.is_water_at(upper_pos))
    // rust: .unwrap_or(upper);
    // rust: self.set_block(upper_pos, upper, 3);
}
}
    // rust: pub(crate) fn growing_plant_can_grow_into(
    // rust: &self,
    // rust: plant: BlockStateId,
    // rust: state: BlockStateId,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let data = b.data(plant);
    // rust: if data.is(Class::Kelp) {
            // KelpBlock.canGrowInto: any water block state.
    // rust: b.is_block(state, b.named.water)
    // rust: } else {
            // NetherVines.isValidGrowthState / CaveVines: air only.
    // rust: b.is_air(state)
}
}
pub fn growing_plant_grow_into_state(self: *Self, state: BlockStateId) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let next = b.table.cycle(state, b.props.age);
    // rust: if b.instance_of(state, Class::CaveVines) {
    // rust: let berries = self.random().next_float() < 0.11;
    // rust: return b.table.set_bool(next, b.props.berries, berries);
}
    // rust: next
}
pub fn cactus_random_tick(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: let above_pos = above(pos);
    // rust: if !self.is_empty_block(above_pos) {
    // rust: return;
}
    // rust: let mut height = 1;
    // rust: let age = b.table.int(state, b.props.age);
    // rust: while b.is_block(self.state(pos.offset(0, -height, 0)), block) {
    // rust: height += 1;
    // rust: if height == 3 && age == 15 {
    // rust: return;
}
}
    // rust: if age == 8 && self.can_survive(b.default_of(block), above_pos) {
    // rust: let chance = if height >= 3 { 0.25 } else { 0.1 };
    // rust: if self.random().next_double() <= chance {
    // rust: self.set_block_and_update(above_pos, b.default_of(b.named.cactus_flower));
}
    // rust: } else if age == 15 && height < 3 {
    // rust: self.set_block_and_update(above_pos, b.default_of(block));
    // rust: let reset = b.table.set_int(state, b.props.age, 0);
    // rust: self.set_block(pos, reset, 260);
    // rust: self.neighbor_changed_full(reset, above_pos, block, false);
}
    // rust: if age < 15 {
    // rust: self.set_block(pos, b.table.set_int(state, b.props.age, age + 1), 260);
}
}
pub fn farmland_random_tick(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let moisture = b.table.int(state, b.props.moisture);
    // rust: let mut near_water = false;
    // rust: 'search: for x in -4..=4 {
    // rust: for y in 0..=1 {
    // rust: for z in -4..=4 {
    // rust: if b.is_water_fluid(self.fluid_at(pos.offset(x, y, z)).kind()) {
    // rust: near_water = true;
    // rust: break 'search;
}
}
}
}
    // rust: if !near_water && !self.level.is_raining_at(above(pos)) {
    // rust: if moisture > 0 {
    // rust: if self
    // rust: .level
    // rust: .allow_moisture_change(pos, moisture, moisture - 1)
    // rust: {
    // rust: self.set_block(
    // rust: pos,
    // rust: b.table.set_int(state, b.props.moisture, moisture - 1),
    // rust: 2,
    // rust: );
}
    // rust: } else if !b.in_set(self.above_state(pos), &b.tags.maintains_farmland) {
    // rust: self.turn_to_base_block(pos, state);
}
    // rust: } else if moisture < 7 && self.level.allow_moisture_change(pos, moisture, 7) {
    // rust: self.set_block(pos, b.table.set_int(state, b.props.moisture, 7), 2);
}
}
    /// `SaplingBlock.advanceTree`.
    // rust: pub(crate) fn sapling_advance_tree(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: self.advance_tree(pos, state);
}
pub fn mushroom_random_tick(self: *Self, state: BlockStateId, mut pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: if self.rand_int(25) != 0 {
    // rust: return;
}
        // canSpread: at most four of this mushroom within a 9x3x9 box.
    // rust: let block = b.block(state);
    // rust: let mut max = 5;
    // rust: for x in -4..=4 {
    // rust: for y in -1..=1 {
    // rust: for z in -4..=4 {
    // rust: if b.is_block(self.state(pos.offset(x, y, z)), block) {
    // rust: max -= 1;
    // rust: if max <= 0 {
    // rust: return;
}
}
}
}
}
    // rust: let mut offset = self.mushroom_offset(pos);
    // rust: for _ in 0..4 {
    // rust: if self.is_empty_block(offset) && self.can_survive(state, offset) {
    // rust: pos = offset;
}
    // rust: offset = self.mushroom_offset(pos);
}
    // rust: if self.is_empty_block(offset) && self.can_survive(state, offset) {
    // rust: self.set_block(offset, state, 2);
}
}
pub fn mushroom_offset(self: *Self, pos: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let x = self.rand_int(3) - 1;
    // rust: let y = self.rand_int(2) - self.rand_int(2);
    // rust: let z = self.rand_int(3) - 1;
    // rust: pos.offset(x, y, z)
}
    /// `LightEngine.getLightDampeningInto(state, above, UP, above.dampening) < 15`.
pub fn top_face_lets_light(self: *Self, state: BlockStateId, above_state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let occluding = |s: BlockStateId| {
    // rust: b.has_flag(s, state_flags::CAN_OCCLUDE)
    // rust: && b.has_flag(s, super::data::state_flags::SHAPE_OCCLUSION)
}
    // rust: let dampening = i32::from(b.facts(above_state).dampening);
    // rust: let from_full = occluding(state) && b.collision_face_full(state, Direction::Up);
    // rust: let to_full = occluding(above_state) && b.collision_face_full(above_state, Direction::Down);
    // rust: let into = if !occluding(state) && !occluding(above_state) {
    // rust: dampening
    // rust: } else if from_full || to_full {
    // rust: 16
    // rust: } else {
    // rust: dampening
}
    // rust: into < 15
}
pub fn can_be_nylium(self: *Self, state: BlockStateId, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.top_face_lets_light(state, self.above_state(pos))
}
pub fn snowy_can_stay_alive(self: *Self, state: BlockStateId, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let above_state = self.above_state(pos);
    // rust: if b.is_block(above_state, b.named.snow) && b.table.int(above_state, b.props.layers) == 1 {
    // rust: return true;
}
    // rust: if b.fluid(above_state).is_full() {
    // rust: return false;
}
    // rust: self.top_face_lets_light(state, above_state)
}
pub fn spreading_snowy_tick(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let base = b.data(state).link.unwrap_or(b.named.dirt);
    // rust: if !self.snowy_can_stay_alive(state, pos) {
    // rust: self.set_block_and_update(pos, b.default_of(base));
    // rust: return;
}
    // rust: if self.max_local_raw_brightness(above(pos)) < 9 {
    // rust: return;
}
    // rust: let default = b.default_of(b.block(state));
    // rust: for _ in 0..4 {
    // rust: let x = self.rand_int(3) - 1;
    // rust: let y = self.rand_int(5) - 3;
    // rust: let z = self.rand_int(3) - 1;
    // rust: let test = pos.offset(x, y, z);
    // rust: if b.is_block(self.state(test), base)
    // rust: && self.snowy_can_stay_alive(default, test)
    // rust: && !b.is_water_fluid(self.fluid_at(above(test)).kind())
    // rust: {
    // rust: let snowy = b.in_set(self.above_state(test), &b.tags.snow);
    // rust: self.set_block_and_update(test, b.table.set_bool(default, b.props.snowy, snowy));
}
}
}
pub fn budding_amethyst_tick(self: *Self, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: if self.rand_int(5) != 0 {
    // rust: return;
}
    // rust: let direction = Direction::ALL[self.rand_int(6) as usize];
    // rust: let grow = rel(pos, direction);
    // rust: let relative = self.state(grow);
    // rust: let name = |n: &str| b.table.block_by_name(n);
    // rust: let stages = [
    // rust: "minecraft:small_amethyst_bud",
    // rust: "minecraft:medium_amethyst_bud",
    // rust: "minecraft:large_amethyst_bud",
    // rust: "minecraft:amethyst_cluster",
    // rust: ];
    // rust: let fluid = b.fluid(relative);
    // rust: let can_cluster_grow =
    // rust: b.is_air(relative) || (b.is_block(relative, b.named.water) && fluid.amount() == 8);
    // rust: let next = if can_cluster_grow {
    // rust: name(stages[0])
    // rust: } else {
    // rust: let mut found = None;
    // rust: for i in 0..3 {
    // rust: if name(stages[i]).is_some_and(|s| b.is_block(relative, s))
    // rust: && b.facing(relative) == direction
    // rust: {
    // rust: found = name(stages[i + 1]);
}
}
    // rust: found
}
    // rust: if let Some(next) = next {
    // rust: let state = b
    // rust: .table
    // rust: .set_dir(b.default_of(next), b.props.facing, direction);
    // rust: let state = b.table.set_bool(
    // rust: state,
    // rust: b.props.waterlogged,
    // rust: fluid == crate::fluid::FluidState::WATER,
    // rust: );
    // rust: self.set_block_and_update(grow, state);
}
}
    // rust: pub(crate) fn bamboo_sapling_grow(&mut self, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let bamboo = b.default_of(b.named.bamboo);
    // rust: let state = b.table.set_text(bamboo, b.props.leaves, "small");
    // rust: self.set_block(above(pos), state, 3);
}
    // rust: pub(crate) fn bamboo_height_below(&self, pos: BlockPos) -> i32 {
    // rust: let mut height = 0;
    // rust: while height < 16
    // rust: && self.b.is_block(
    // rust: self.state(pos.offset(0, -(height + 1), 0)),
    // rust: self.b.named.bamboo,
    // rust: )
    // rust: {
    // rust: height += 1;
}
    // rust: height
}
    // rust: pub(crate) fn bamboo_height_above(&self, pos: BlockPos) -> i32 {
    // rust: let mut height = 0;
    // rust: while height < 16
    // rust: && self.b.is_block(
    // rust: self.state(pos.offset(0, height + 1, 0)),
    // rust: self.b.named.bamboo,
    // rust: )
    // rust: {
    // rust: height += 1;
}
    // rust: height
}
    /// `BambooStalkBlock.growBamboo`.
    // rust: pub(crate) fn bamboo_grow(&mut self, state: BlockStateId, pos: BlockPos, height: i32) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let below_state = self.below_state(pos);
    // rust: let below_two = pos.offset(0, -2, 0);
    // rust: let below_two_state = self.state(below_two);
    // rust: let mut leaves = "none";
    // rust: if height >= 1 {
    // rust: if !b.is_block(below_state, b.named.bamboo)
    // rust: || b.table.text(below_state, p.leaves) == "none"
    // rust: {
    // rust: leaves = "small";
    // rust: } else if b.is_block(below_state, b.named.bamboo)
    // rust: && b.table.text(below_state, p.leaves) != "none"
    // rust: {
    // rust: leaves = "large";
    // rust: if b.is_block(below_two_state, b.named.bamboo) {
    // rust: self.set_block(
    // rust: below(pos),
    // rust: b.table.set_text(below_state, p.leaves, "small"),
    // rust: 3,
    // rust: );
    // rust: self.set_block(
    // rust: below_two,
    // rust: b.table.set_text(below_two_state, p.leaves, "none"),
    // rust: 3,
    // rust: );
}
}
}
    // rust: let age = if b.table.int(state, p.age) != 1 && !b.is_block(below_two_state, b.named.bamboo)
    // rust: {
    // rust: 0
    // rust: } else {
    // rust: 1
}
    // rust: let stage = if (height < 11 || self.random().next_float() >= 0.25) && height != 15 {
    // rust: 0
    // rust: } else {
    // rust: 1
}
    // rust: let next = b.table.set_int(
    // rust: b.table.set_int(
    // rust: b.table
    // rust: .set_text(b.default_of(b.named.bamboo), p.leaves, leaves),
    // rust: p.age,
    // rust: age,
    // rust: ),
    // rust: p.stage,
    // rust: stage,
    // rust: );
    // rust: let _ = self.bamboo_height_above(pos);
    // rust: self.set_block(above(pos), next, 3);
}
    /// `VineBlock.randomTick`.
pub fn vine_random_tick(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let block = b.block(state);
        // The spread_vines rule, checked before the roll.
    // rust: if !self.level.game_rules().spread_vines || self.rand_int(4) != 0 {
    // rust: return;
}
    // rust: let direction = Direction::ALL[self.rand_int(6) as usize];
    // rust: let above_pos = above(pos);
    // rust: let default = b.default_of(block);
    // rust: if super::query::is_horizontal(direction)
    // rust: && !b.table.bool(state, self.direction_prop(direction))
    // rust: {
    // rust: if !self.vine_can_spread(pos, block) {
    // rust: return;
}
    // rust: let test = rel(pos, direction);
    // rust: let edge = self.state(test);
    // rust: if b.is_air(edge) {
    // rust: let cw = super::query::clockwise(direction);
    // rust: let ccw = super::query::counter_clockwise(direction);
    // rust: let cw_face = b.table.bool(state, self.direction_prop(cw));
    // rust: let ccw_face = b.table.bool(state, self.direction_prop(ccw));
    // rust: let cw_test = rel(test, cw);
    // rust: let ccw_test = rel(test, ccw);
    // rust: if cw_face && b.multiface_can_attach(self.state(cw_test), cw) {
    // rust: self.set_block(
    // rust: test,
    // rust: b.table.set_bool(default, self.direction_prop(cw), true),
    // rust: 2,
    // rust: );
    // rust: } else if ccw_face && b.multiface_can_attach(self.state(ccw_test), ccw) {
    // rust: self.set_block(
    // rust: test,
    // rust: b.table.set_bool(default, self.direction_prop(ccw), true),
    // rust: 2,
    // rust: );
    // rust: } else {
    // rust: let opposite = direction.opposite();
    // rust: if cw_face
    // rust: && self.is_empty_block(cw_test)
    // rust: && b.multiface_can_attach(self.rel_state(pos, cw), opposite)
    // rust: {
    // rust: self.set_block(
    // rust: cw_test,
    // rust: b.table
    // rust: .set_bool(default, self.direction_prop(opposite), true),
    // rust: 2,
    // rust: );
    // rust: } else if ccw_face
    // rust: && self.is_empty_block(ccw_test)
    // rust: && b.multiface_can_attach(self.rel_state(pos, ccw), opposite)
    // rust: {
    // rust: self.set_block(
    // rust: ccw_test,
    // rust: b.table
    // rust: .set_bool(default, self.direction_prop(opposite), true),
    // rust: 2,
    // rust: );
    // rust: } else if self.random().next_float() < 0.05
    // rust: && b.multiface_can_attach(self.state(above(test)), Direction::Up)
    // rust: {
    // rust: self.set_block(test, b.table.set_bool(default, p.up, true), 2);
}
}
    // rust: } else if b.multiface_can_attach(edge, direction) {
    // rust: self.set_block(
    // rust: pos,
    // rust: b.table
    // rust: .set_bool(state, self.direction_prop(direction), true),
    // rust: 2,
    // rust: );
}
    // rust: return;
}
    // rust: if direction == Direction::Up && pos.y < self.level.max_y() - 1 {
    // rust: if b.multiface_can_attach(self.state(above_pos), Direction::Up) {
    // rust: self.set_block(pos, b.table.set_bool(state, p.up, true), 2);
    // rust: return;
}
    // rust: if self.is_empty_block(above_pos) {
    // rust: if !self.vine_can_spread(pos, block) {
    // rust: return;
}
    // rust: let mut above_state = state;
    // rust: for d in HORIZONTAL {
    // rust: if self.random().next_boolean()
    // rust: || !b.multiface_can_attach(self.state(rel(above_pos, d)), d)
    // rust: {
    // rust: above_state = b.table.set_bool(above_state, self.direction_prop(d), false);
}
}
    // rust: if HORIZONTAL
    // rust: .into_iter()
    // rust: .any(|d| b.table.bool(above_state, self.direction_prop(d)))
    // rust: {
    // rust: self.set_block(above_pos, above_state, 2);
}
    // rust: return;
}
}
    // rust: if pos.y > self.level.min_y() {
    // rust: let below_pos = below(pos);
    // rust: let below_state = self.state(below_pos);
    // rust: if b.is_air(below_state) || b.is_block(below_state, block) {
    // rust: let before = if b.is_air(below_state) {
    // rust: default
    // rust: } else {
    // rust: below_state
}
    // rust: let mut after = before;
    // rust: for d in HORIZONTAL {
    // rust: if self.random().next_boolean() && b.table.bool(state, self.direction_prop(d)) {
    // rust: after = b.table.set_bool(after, self.direction_prop(d), true);
}
}
    // rust: if before != after
    // rust: && HORIZONTAL
    // rust: .into_iter()
    // rust: .any(|d| b.table.bool(after, self.direction_prop(d)))
    // rust: {
    // rust: self.set_block(below_pos, after, 2);
}
}
}
}
pub fn vine_can_spread(self: *Self, pos: BlockPos, block: super::states::BlockId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut max = 5;
    // rust: for x in -4..=4 {
    // rust: for y in -1..=1 {
    // rust: for z in -4..=4 {
    // rust: if self.b.is_block(self.state(pos.offset(x, y, z)), block) {
    // rust: max -= 1;
    // rust: if max <= 0 {
    // rust: return false;
}
}
}
}
}
    // rust: true
}
    /// `ChorusFlowerBlock.randomTick`.
pub fn chorus_flower_random_tick(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let block = b.block(state);
    // rust: let plant = b.named.chorus_plant;
    // rust: let above_pos = above(pos);
    // rust: if !self.is_empty_block(above_pos) || above_pos.y > self.level.max_y() - 1 {
    // rust: return;
}
    // rust: let age = b.table.int(state, p.age);
    // rust: if age >= 5 {
    // rust: return;
}
    // rust: let mut grow_up = false;
    // rust: let mut pillar_on_support = false;
    // rust: let below_state = self.below_state(pos);
    // rust: if b.in_set(below_state, &b.tags.supports_chorus_flower) {
    // rust: grow_up = true;
    // rust: } else if b.is_block(below_state, plant) {
    // rust: let mut height = 1;
    // rust: for _ in 0..4 {
    // rust: let test = self.state(pos.offset(0, -(height + 1), 0));
    // rust: if !b.is_block(test, plant) {
    // rust: if b.in_set(test, &b.tags.supports_chorus_flower) {
    // rust: pillar_on_support = true;
}
    // rust: break;
}
    // rust: height += 1;
}
    // rust: if height < 2 || height <= self.rand_int(if pillar_on_support { 5 } else { 4 }) {
    // rust: grow_up = true;
}
    // rust: } else if b.is_air(below_state) {
    // rust: grow_up = true;
}
    // rust: let all_empty = |sim: &Self, at: BlockPos, ignore: Option<Direction>| {
    // rust: HORIZONTAL
    // rust: .into_iter()
    // rust: .all(|d| Some(d) == ignore || sim.is_empty_block(rel(at, d)))
}
    // rust: let plant_state = b.default_of(plant);
    // rust: if grow_up && all_empty(self, above_pos, None) && self.is_empty_block(pos.offset(0, 2, 0)) {
    // rust: let connected = self.chorus_plant_with_connections(pos, plant_state);
    // rust: self.set_block(pos, connected, 2);
    // rust: self.set_block(
    // rust: above_pos,
    // rust: b.table.set_int(b.default_of(block), p.age, age),
    // rust: 2,
    // rust: );
    // rust: self.level_event(1033, above_pos, 0);
    // rust: } else if age < 4 {
    // rust: let mut attempts = self.rand_int(4);
    // rust: if pillar_on_support {
    // rust: attempts += 1;
}
    // rust: let mut branched = false;
    // rust: for _ in 0..attempts {
    // rust: let direction = HORIZONTAL[self.rand_int(4) as usize];
    // rust: let target = rel(pos, direction);
    // rust: if self.is_empty_block(target)
    // rust: && self.is_empty_block(below(target))
    // rust: && all_empty(self, target, Some(direction.opposite()))
    // rust: {
    // rust: self.set_block(
    // rust: target,
    // rust: b.table.set_int(b.default_of(block), p.age, age + 1),
    // rust: 2,
    // rust: );
    // rust: self.level_event(1033, target, 0);
    // rust: branched = true;
}
}
    // rust: if branched {
    // rust: let connected = self.chorus_plant_with_connections(pos, plant_state);
    // rust: self.set_block(pos, connected, 2);
    // rust: } else {
    // rust: self.set_block(pos, b.table.set_int(state, p.age, 5), 2);
    // rust: self.level_event(1034, pos, 0);
}
    // rust: } else {
    // rust: self.set_block(pos, b.table.set_int(state, p.age, 5), 2);
    // rust: self.level_event(1034, pos, 0);
}
}
    /// `ServerLevel.tickPrecipitation` at a column whose top (motion-blocking
    /// heightmap) position and biome answers are supplied by the caller.
    // rust: pub(crate) fn precipitation_tick(&mut self, info: Precipitation) {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let top = info.top;
    // rust: let below_pos = below(top);
    // rust: if info.freezes_below {
    // rust: let from = self.state(below_pos);
    // rust: let to = b.default_of(b.named.ice);
    // rust: if self.level.allow_block_form(below_pos, from, to) {
    // rust: self.set_block_and_update(below_pos, to);
}
}
    // rust: if !self.level.is_raining() {
    // rust: return;
}
    // rust: let max_height = self.level.game_rules().max_snow_accumulation_height;
    // rust: if max_height > 0 && info.snows_at_top {
    // rust: let state = self.state(top);
    // rust: if b.is_block(state, b.named.snow) {
    // rust: let layers = b.table.int(state, p.layers);
    // rust: if layers < max_height.min(8) {
    // rust: let to = b.table.set_int(state, p.layers, layers + 1);
    // rust: if self.level.allow_block_form(top, state, to) {
    // rust: self.set_block_and_update(top, to);
}
}
    // rust: } else {
    // rust: let to = b.default_of(b.named.snow);
    // rust: if self.level.allow_block_form(top, state, to) {
    // rust: self.set_block_and_update(top, to);
}
}
}
    // rust: if info.kind != PrecipitationKind::None {
    // rust: let below_state = self.state(below_pos);
    // rust: let data = b.data(below_state);
    // rust: let chance = match info.kind {
    // rust: PrecipitationKind::Rain => 0.05,
    // rust: PrecipitationKind::Snow => 0.1,
    // rust: PrecipitationKind::None => 0.0,
}
    // rust: if data.is(Class::Cauldron) {
    // rust: if self.random().next_float() < chance {
                    // Both place the cauldron's default state, level 1
                    // (CauldronBlock.handlePrecipitation).
    // rust: let to = 1;
    // rust: let reason = if info.kind == PrecipitationKind::Rain {
    // rust: "rain"
    // rust: } else {
    // rust: "snow"
}
    // rust: if !self
    // rust: .level
    // rust: .allow_cauldron_level_change(below_pos, 0, to, reason)
    // rust: {
    // rust: return;
}
    // rust: let next = if info.kind == PrecipitationKind::Rain {
    // rust: b.named.water_cauldron
    // rust: } else {
    // rust: b.named.powder_snow_cauldron
}
    // rust: self.set_block_and_update(below_pos, b.default_of(next));
    // rust: self.game_event(below_pos, "minecraft:block_change");
}
    // rust: } else if data.is(Class::LayeredCauldron) && self.random().next_float() < chance {
    // rust: let matches = (info.kind == PrecipitationKind::Rain
    // rust: && b.is_block(below_state, b.named.water_cauldron))
    // rust: || (info.kind == PrecipitationKind::Snow
    // rust: && b.is_block(below_state, b.named.powder_snow_cauldron));
    // rust: if b.table.int(below_state, p.level) != 3 && matches {
    // rust: let level = b.table.int(below_state, p.level);
    // rust: let reason = if info.kind == PrecipitationKind::Rain {
    // rust: "rain"
    // rust: } else {
    // rust: "snow"
}
    // rust: if !self
    // rust: .level
    // rust: .allow_cauldron_level_change(below_pos, level, level + 1, reason)
    // rust: {
    // rust: return;
}
    // rust: self.set_block_and_update(below_pos, b.table.cycle(below_state, p.level));
    // rust: self.game_event(below_pos, "minecraft:block_change");
}
}
}
}
    /// `ChangeOverTimeBlock.changeOverTime` for weathering copper.
pub fn copper_change_over_time(self: *Self, state: BlockStateId, pos: BlockPos) void {
}
    // rust: if self.random().next_float() >= 0.056_888_89 {
    // rust: return;
}
    // rust: let b = self.b;
    // rust: let own = b.data(state).weather;
    // rust: let (mut same, mut older) = (0, 0);
    // rust: for x in -4i32..=4 {
    // rust: for y in -4i32..=4 {
    // rust: for z in -4i32..=4 {
    // rust: if x.abs() + y.abs() + z.abs() > 4 || (x == 0 && y == 0 && z == 0) {
    // rust: continue;
}
    // rust: let other = self.state(pos.offset(x, y, z));
    // rust: let data = b.data(other);
    // rust: if !data.implements(super::classes::Interface::WeatheringCopper) {
    // rust: continue;
}
    // rust: match data.weather.cmp(&own) {
    // rust: std::cmp::Ordering::Less => return,
    // rust: std::cmp::Ordering::Greater => older += 1,
    // rust: std::cmp::Ordering::Equal => same += 1,
}
}
}
}
    // rust: let chance = (older + 1) as f32 / (older + same + 1) as f32;
    // rust: let modifier = if own == 0 { 0.75 } else { 1.0 };
    // rust: if self.random().next_float() < chance * chance * modifier {
    // rust: if let Some(next) = self.copper_next(state) {
    // rust: self.set_block_and_update(pos, next);
}
}
}
    /// `WeatheringCopper.getNext` by registry naming.
    // rust: pub(crate) fn copper_next(&self, state: BlockStateId) -> Option<BlockStateId> {
    // rust: let b = self.b;
    // rust: let name = &*b.table.info(b.block(state)).name;
    // rust: let path = name.strip_prefix("minecraft:")?;
    // rust: let next = if path == "copper_block" {
    // rust: "exposed_copper".to_owned()
    // rust: } else if let Some(rest) = path.strip_prefix("exposed_") {
    // rust: format!("weathered_{rest}")
    // rust: } else if let Some(rest) = path.strip_prefix("weathered_") {
    // rust: format!("oxidized_{rest}")
    // rust: } else if path.starts_with("oxidized_") || path.starts_with("waxed_") {
    // rust: return None;
    // rust: } else {
    // rust: format!("exposed_{path}")
}
    // rust: let block = b.table.block_by_name(&format!("minecraft:{next}"))?;
    // rust: Some(b.table.with_properties_of(block, state))
}
    /// `WeatheringCopper.getPrevious` (and `getFirst` by repeating it) by
    /// registry naming: the block one oxidation step back.
pub fn copper_previous_name(path: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(rest) = path.strip_prefix("oxidized_") {
    // rust: Some(format!("weathered_{rest}"))
    // rust: } else if let Some(rest) = path.strip_prefix("weathered_") {
    // rust: Some(format!("exposed_{rest}"))
    // rust: } else {
    // rust: path.strip_prefix("exposed_").map(|rest| {
    // rust: if rest == "copper" {
    // rust: "copper_block".to_owned()
    // rust: } else {
    // rust: rest.to_owned()
}
    // rust: })
}
}
pub fn copper_stepped(self: *Self, state: BlockStateId, all_the_way: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let b = self.b;
    // rust: let name = &*b.table.info(b.block(state)).name;
    // rust: let mut path = Self::copper_previous_name(name.strip_prefix("minecraft:")?)?;
    // rust: while all_the_way && let Some(earlier) = Self::copper_previous_name(&path) {
    // rust: path = earlier;
}
    // rust: let block = b.table.block_by_name(&format!("minecraft:{path}"))?;
    // rust: Some(b.table.with_properties_of(block, state))
}
    /// `LightningBolt.clearCopperOnLightningStrike`: the struck copper goes
    /// back to unoxidized, then 3 to 5 random walks of up to 8 steps each
    /// scrape one step of oxidation off the weathering copper they land on.
    /// A waxed block is left as it is but still starts the walks.
    // rust: pub(crate) fn lightning_clear_copper(&mut self, struck: BlockPos) {
    // rust: let b = self.b;
    // rust: let state = self.state(struck);
    // rust: let weathering = b
    // rust: .data(state)
    // rust: .implements(super::classes::Interface::WeatheringCopper);
    // rust: let waxed = b.table.name(state).starts_with("minecraft:waxed_");
    // rust: if !(weathering || waxed) {
    // rust: return;
}
    // rust: if weathering && let Some(first) = self.copper_stepped(state, true) {
    // rust: self.set_block_and_update(struck, first);
}
    // rust: for _ in 0..self.rand_int(3) + 3 {
    // rust: let mut at = struck;
    // rust: for _ in 0..self.rand_int(8) + 1 {
                // randomStepCleaningCopper: up to 10 random blocks in the
                // 3x3x3 cube around the walk's position.
    // rust: let mut next = None;
    // rust: for _ in 0..10 {
    // rust: let x = at.x - 1 + self.rand_int(3);
    // rust: let y = at.y - 1 + self.rand_int(3);
    // rust: let z = at.z - 1 + self.rand_int(3);
    // rust: let candidate = BlockPos::new(x, y, z);
    // rust: let state = self.state(candidate);
    // rust: if b.data(state)
    // rust: .implements(super::classes::Interface::WeatheringCopper)
    // rust: {
    // rust: if let Some(previous) = self.copper_stepped(state, false) {
    // rust: self.set_block_and_update(candidate, previous);
}
    // rust: self.level_event(3002, candidate, -1);
    // rust: next = Some(candidate);
    // rust: break;
}
}
    // rust: match next {
    // rust: Some(p) => at = p,
    // rust: None => break,
}
}
}
}
}

/// `Biome.Precipitation` at a position.
pub const PrecipitationKind = enum {
    None,
    Rain,
    Snow,
};
/// Biome answers for one precipitation tick (`ServerLevel.tickPrecipitation`).
pub const Precipitation = struct {
    /// `getHeightmapPos(MOTION_BLOCKING, pos)`.
    top: BlockPos,
    /// `biome.shouldFreeze(level, top.below())`.
    freezes_below: bool,
    /// `biome.shouldSnow(level, top)`.
    snows_at_top: bool,
    /// `biome.getPrecipitationAt(top.below(), seaLevel)`.
    kind: PrecipitationKind,
};

    // rust: impl Behaviours {
    /// Run due scheduled ticks for the level's current game time, in vanilla
    /// order: block ticks then fluid ticks (65536 each at most).
    // rust: pub fn tick_scheduled<L: LevelAccess + ?Sized>(&self, level: &mut L, ticks: &mut Ticks) {
    // rust: let time = level.game_time();
    // rust: ticks.handling_tick = true;
    // rust: {
    // rust: let level_ref: &L = level;
    // rust: if ticks
    // rust: .blocks
    // rust: .begin_tick(time, 65536, |chunk: ChunkPos| {
    // rust: level_ref.is_ticking_chunk(chunk)
    // rust: })
    // rust: .is_err()
    // rust: {
    // rust: ticks.handling_tick = false;
    // rust: return;
}
}
    // rust: while let Ok(Some(tick)) = ticks.blocks.next_tick() {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(tick.pos);
    // rust: if u32::from(self.block(state).0) == tick.kind.0 {
    // rust: sim.tick_due_block(state, tick.pos);
}
}
    // rust: let _ = ticks.blocks.finish_tick();
    // rust: {
    // rust: let level_ref: &L = level;
    // rust: if ticks
    // rust: .fluids
    // rust: .begin_tick(time, 65536, |chunk: ChunkPos| {
    // rust: level_ref.is_ticking_chunk(chunk)
    // rust: })
    // rust: .is_err()
    // rust: {
    // rust: ticks.handling_tick = false;
    // rust: return;
}
}
    // rust: while let Ok(Some(tick)) = ticks.fluids.next_tick() {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let fluid = self.fluid(sim.state(tick.pos)).kind();
    // rust: if TickTypeId(fluid as u32) == tick.kind {
    // rust: sim.fluid_tick(tick.pos);
}
}
    // rust: let _ = ticks.fluids.finish_tick();
    // rust: ticks.handling_tick = false;
}
    /// `tick_scheduled` one tick at a time, for a caller that must act on
    /// each tick's side effects before the next runs (as vanilla runs them
    /// inline): `scheduled_begin`, then `scheduled_step` until it returns
    /// false, then `scheduled_finish`; block ticks first, then fluid ticks.
    /// Returns whether ticks are due (false: nothing to step or finish).
    // rust: pub fn scheduled_begin<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: fluids: bool,
    // rust: ) -> bool {
    // rust: let time = level.game_time();
    // rust: ticks.handling_tick = true;
    // rust: let level_ref: &L = level;
    // rust: let queue = if fluids {
    // rust: &mut ticks.fluids
    // rust: } else {
    // rust: &mut ticks.blocks
}
    // rust: let ok = queue
    // rust: .begin_tick(time, 65536, |chunk: ChunkPos| {
    // rust: level_ref.is_ticking_chunk(chunk)
    // rust: })
    // rust: .is_ok();
    // rust: if !ok {
    // rust: ticks.handling_tick = false;
}
    // rust: ok
}
    /// Run the next due tick; false when none is left.
    // rust: pub fn scheduled_step<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: fluids: bool,
    // rust: ) -> bool {
    // rust: if fluids {
    // rust: let Ok(Some(tick)) = ticks.fluids.next_tick() else {
    // rust: return false;
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let fluid = self.fluid(sim.state(tick.pos)).kind();
    // rust: if TickTypeId(fluid as u32) == tick.kind {
    // rust: sim.fluid_tick(tick.pos);
}
    // rust: } else {
    // rust: let Ok(Some(tick)) = ticks.blocks.next_tick() else {
    // rust: return false;
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(tick.pos);
    // rust: if u32::from(self.block(state).0) == tick.kind.0 {
    // rust: sim.tick_due_block(state, tick.pos);
}
}
    // rust: true
}
    /// End a `scheduled_begin` phase.
pub fn scheduled_finish(self: *Self, ticks: *mut Ticks, fluids: bool) void {
}
    // rust: let _ = if fluids {
    // rust: ticks.fluids.finish_tick()
    // rust: } else {
    // rust: ticks.blocks.finish_tick()
}
    // rust: ticks.handling_tick = false;
}
    /// Random-tick one chunk (`ServerLevel.tickChunk` block part). Visits the
    /// sections from the bottom up and draws `randomTickSpeed` positions in
    /// each randomly ticking one (`LevelChunkSection.isRandomlyTicking`: it
    /// holds a randomly ticking block or fluid). `next_ticking(level, min_y)`
    /// is the minimum Y of the lowest such section from `min_y` up, as the
    /// chunk is now: vanilla asks as it reaches each section, so the ticks of
    /// the sections below count.
    // rust: pub fn tick_chunk_random<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: chunk: ChunkPos,
    // rust: mut next_ticking: impl FnMut(&mut L, i32) -> Option<i32>,
    // rust: ) {
    // rust: self.tick_chunk_random_masked(level, ticks, chunk, |level, from| {
    // rust: next_ticking(level, from).map(|min_y| (min_y, None))
    // rust: });
}
    /// [`Self::tick_chunk_random`], where `next_ticking` may also give the
    /// section's [`RandomTickMask`]: a drawn position outside it is not read,
    /// as its random tick would do nothing. The draws are the same. After a
    /// position that did tick, the section is asked for again (its blocks may
    /// have changed): a mask is only trusted for the blocks as they are.
    // rust: pub fn tick_chunk_random_masked<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: chunk: ChunkPos,
    // rust: mut next_ticking: impl FnMut(&mut L, i32) -> Option<(i32, Option<Rc<RandomTickMask>>)>,
    // rust: ) {
    // rust: let speed = level.game_rules().random_tick_speed;
    // rust: if speed <= 0 {
    // rust: return;
}
    // rust: let (min_x, min_z) = (chunk.x * 16, chunk.z * 16);
    // rust: for _ in 0..speed {
    // rust: if level.random().next_int_bound(48).unwrap_or(1) == 0 {
    // rust: let pos = ticks.block_random_pos(min_x, 0, min_z, 15);
    // rust: if let Some(info) = level.precipitation(pos) {
    // rust: self.sim(level, ticks).precipitation_tick(info);
}
}
}
    // rust: let mut from = level.min_y();
    // rust: while let Some((min_y, mut mask)) =
    // rust: next_ticking(level, from).filter(|&(y, _)| y < level.max_y())
    // rust: {
    // rust: for _ in 0..speed {
    // rust: let pos = ticks.block_random_pos(min_x, min_y, min_z, 15);
    // rust: if mask.as_ref().is_none_or(|m| m.may_tick(pos)) {
    // rust: self.sim(level, ticks).random_tick_at(pos);
                    // The same section as it is now; one that stopped
                    // ticking still gets the rest of its draws, unfiltered.
    // rust: mask = next_ticking(level, min_y)
    // rust: .filter(|&(y, _)| y == min_y)
    // rust: .and_then(|(_, m)| m);
}
}
    // rust: from = min_y + 16;
}
}
    /// Whether a random tick at a block of `state` can do anything: what
    /// [`Self::tick_chunk_random_masked`]'s masks hold. `random_tick_at`
    /// ticks a randomly ticking block, then lava's fluid.
pub fn random_tick_candidate(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.is_randomly_ticking(state)
    // rust: || matches!(
    // rust: self.fluid(state).kind(),
    // rust: FluidKind::Lava | FluidKind::FlowingLava
    // rust: )
}
    /// Random-tick a single position (block then fluid), as `tickChunk` does.
    // rust: pub fn random_tick<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: self.sim(level, ticks).random_tick_at(pos);
}
    /// `LightningBolt.clearCopperOnLightningStrike` for the block at `struck`.
    // rust: pub fn lightning_clear_copper<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: struck: BlockPos,
    // rust: ) {
    // rust: self.sim(level, ticks).lightning_clear_copper(struck);
}
    /// Run one scheduled block tick at `pos` immediately (no queue check).
    // rust: pub fn scheduled_block_tick<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: sim.tick_block(state, pos);
}
    /// Run one scheduled fluid tick at `pos` immediately.
    // rust: pub fn scheduled_fluid_tick<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: self.sim(level, ticks).fluid_tick(pos);
}
}

/// Which of a section's 4,096 blocks a random tick can do anything for
/// ([`Behaviours::random_tick_candidate`]), one bit each in the section's
/// index order (`y << 8 | z << 4 | x`). Vanilla reads the block at every drawn
/// position; most hold stone, dirt or air, and the read is a cache miss.
pub const RandomTickMask = struct {};
    // rust: impl RandomTickMask {
    /// The mask of `blocks` (4,096 states in index order).
pub fn of(blocks: *[u32], mut candidate: impl FnMut(u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut bits = [0u64; 64];
    // rust: let mut last = None;
    // rust: for (i, &state) in blocks.iter().enumerate().take(4096) {
    // rust: let hit = match last {
    // rust: Some((s, hit)) if s == state => hit,
    // rust: _ => {
    // rust: let hit = candidate(state);
    // rust: last = Some((state, hit));
    // rust: hit
}
}
    // rust: bits[i >> 6] |= u64::from(hit) << (i & 63);
}
    // rust: Self(bits)
}
pub fn may_tick(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = ((pos.y & 15) << 8 | (pos.z & 15) << 4 | (pos.x & 15)) as usize;
    // rust: self.0[i >> 6] >> (i & 63) & 1 != 0
}
}
