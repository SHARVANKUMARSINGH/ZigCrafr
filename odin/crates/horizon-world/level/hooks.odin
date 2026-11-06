//! Transpiled from Horizon Rust crate
package horizon_world_hooks

import "core:fmt"
import "core:mem"
import "core:math"

// `neighborChanged`, `onPlace`, `affectNeighborsAfterRemoval` and
// `updateIndirectNeighbourShapes` for the overriding vanilla classes.
// use super::{
    // rust: LevelAccess, LevelEvent, Sim,
    // rust: classes::Class,
    // rust: states::BlockId,
    // rust: update::{below, rel},
}
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, position::BlockPos, random::RandomSource};

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
    // `BlockState.handleNeighborChanged`.
    // rust: pub fn neighbor_changed(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: changed: BlockId,
    // rust: moved: bool,
    // rust: ) {
    // rust: self.neighbor_changed_oriented(state, pos, changed, None, moved);
}
    // rust: pub fn neighbor_changed_oriented(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: changed: BlockId,
    // rust: orientation: Option<super::orientation::Orientation>,
    // rust: moved: bool,
    // rust: ) {
    // rust: self.level
    // rust: .observe_neighbor_changed(pos, state, changed, moved);
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: let chain = &b.data(state).chain;
    // rust: for &class in chain.iter() {
    // rust: match class {
    // rust: Class::AbstractSkull => self.skull_neighbor_changed(pos, state),
    // rust: Class::BaseRail => self.rail_neighbor_changed(pos, state, changed, moved),
    // rust: Class::Bell => self.bell_neighbor_changed(pos, state),
    // rust: Class::BigDripleaf => {
    // rust: if self.has_neighbor_signal(pos) {
    // rust: self.big_dripleaf_reset_tilt(pos, state);
}
}
    // rust: Class::Command => {
                    // CommandBlock.setPoweredAndUpdate
    // rust: let signal = self.has_neighbor_signal(pos);
    // rust: if let Some((was_powered, automatic)) =
    // rust: self.level.set_command_block_powered(pos, signal)
    // rust: && signal
    // rust: && !was_powered
    // rust: && !automatic
    // rust: && !b.is_block(state, b.named.chain_command_block)
    // rust: {
    // rust: self.schedule_tick(pos, block, 1);
}
}
                // StructureBlock.neighborChanged: the caller owns the block entity.
    // rust: Class::Structure => self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "structure_block",
    // rust: }),
                // TestBlock.neighborChanged: the caller owns the block entity.
    // rust: Class::TestBlock => self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "test_block",
    // rust: }),
    // rust: Class::CopperBulb => self.copper_bulb_check(pos, state),
    // rust: Class::Crafter => self.crafter_neighbor_changed(pos, state),
    // rust: Class::Diode => self.diode_neighbor_changed(pos, state),
    // rust: Class::Dispenser => self.dispenser_neighbor_changed(pos, state),
    // rust: Class::Door => self.door_neighbor_changed(pos, state, changed),
    // rust: Class::FenceGate => self.gate_neighbor_changed(pos, state),
    // rust: Class::FrostedIce => {
    // rust: if b.block_data(changed).is(Class::FrostedIce)
    // rust: && self.frosted_ice_fewer_neighbours_than(pos, 2)
    // rust: {
    // rust: self.frosted_ice_melt(pos, state);
}
}
    // rust: Class::Hopper => self.hopper_check_powered(pos, state),
    // rust: Class::Liquid => self.liquid_block_changed(pos, state),
    // rust: Class::Note => self.note_neighbor_changed(pos, state),
    // rust: Class::PistonBase => self.piston_check_if_extend(pos, state),
    // rust: Class::PistonHead => {
    // rust: if self.can_survive(state, pos) {
    // rust: let base = rel(pos, b.facing(state).opposite());
    // rust: self.neighbor_changed_at_oriented(
    // rust: base,
    // rust: changed,
    // rust: orientation.map(|o| o.with_front(b.facing(state).opposite())),
    // rust: );
}
}
    // rust: Class::RedstoneLamp => self.lamp_neighbor_changed(pos, state),
    // rust: Class::RedstoneTorch => self.torch_neighbor_changed(pos, state),
    // rust: Class::RedstoneWire => {
    // rust: if self.level.redstone_experiments() && changed == b.named.redstone_wire {
    // rust: return;
}
    // rust: if self.can_survive(state, pos) {
    // rust: self.wire_update_power(pos, state, orientation, false);
    // rust: } else {
    // rust: self.drop_resources(state, pos);
    // rust: self.remove_block(pos, false);
}
}
    // rust: Class::Shelf => self.shelf_neighbor_changed(pos, state),
    // rust: Class::Sponge => self.sponge_try_absorb(pos),
    // rust: Class::Tnt => self.tnt_check(pos),
    // rust: Class::TrapDoor => self.trapdoor_neighbor_changed(pos, state),
    // rust: _ => continue,
}
    // rust: let _ = block;
    // rust: return;
}
}

    // `BlockState.onPlace`.
on_place :: proc(self: ^Self, state: BlockStateId, pos: BlockPos, old: BlockStateId, moved: bool) {
}
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: let same = b.block(old) == block;
    // rust: let chain = &b.data(state).chain;
    // rust: for &class in chain.iter() {
    // rust: match class {
    // rust: Class::Fire => {
    // rust: self.base_fire_on_place(pos, state, same);
    // rust: let delay = 30 + self.random().next_int_bound(10).unwrap_or(0);
    // rust: self.schedule_tick(pos, block, delay);
}
    // rust: Class::BaseFire => self.base_fire_on_place(pos, state, same),
    // rust: Class::DetectorRail | Class::BaseRail => {
    // rust: if !same {
    // rust: let updated = self.rail_update_state(pos, state, moved);
    // rust: if class == Class::DetectorRail {
    // rust: self.detector_rail_check_pressed(pos, updated);
}
}
}
    // rust: Class::Brushable => {
    // rust: self.schedule_tick(pos, block, 2);
}
    // rust: Class::Composter => {
    // rust: if b.table.int(state, b.props.level) == 7 {
    // rust: self.schedule_tick(pos, block, 20);
}
}
    // rust: Class::CopperBulb => {
    // rust: if !same {
    // rust: self.copper_bulb_check(pos, state);
}
}
    // rust: Class::CoralFan | Class::CoralPlant | Class::CoralWallFan => {
    // rust: self.coral_try_schedule_die_tick(state, pos)
}
    // rust: Class::Diode => self.diode_update_neighbors_in_front(pos, state),
    // rust: Class::FallingBlock => {
    // rust: let delay = if b.data(state).is(Class::DragonEgg) {
    // rust: 5
    // rust: } else {
    // rust: 2
}
    // rust: self.schedule_tick(pos, block, delay);
}
    // rust: Class::Frogspawn => {
    // rust: let delay = self.random().next_int_between(3600, 12000).unwrap_or(3600);
    // rust: self.schedule_tick(pos, block, delay);
}
    // rust: Class::FrostedIce => {
    // rust: let delay = self
    // rust: .random()
    // rust: .next_int_between_inclusive(60, 120)
    // rust: .unwrap_or(60);
    // rust: self.schedule_tick(pos, block, delay);
}
    // rust: Class::Hopper => {
    // rust: if !same {
    // rust: self.hopper_check_powered(pos, state);
}
}
    // rust: Class::LightningRod => {
    // rust: if !same
    // rust: && b.table.bool(state, b.props.powered)
    // rust: && !self.ticks.has_block_tick(pos, block)
    // rust: {
    // rust: self.schedule_tick(pos, block, 8);
}
}
    // rust: Class::Liquid => self.liquid_block_changed(pos, state),
    // rust: Class::PistonBase => {
    // rust: if !same && self.moving_piston(pos).is_none() {
    // rust: self.piston_check_if_extend(pos, state);
}
}
    // rust: Class::PotentSulfur => self.potent_sulfur_on_place(pos, state),
    // rust: Class::Observer => {
    // rust: if !same
    // rust: && b.table.bool(state, b.props.powered)
    // rust: && !self.ticks.has_block_tick(pos, block)
    // rust: {
    // rust: let next = b.table.set_bool(state, b.props.powered, false);
    // rust: self.set_block(pos, next, 18);
    // rust: self.observer_update_in_front(pos, next);
}
}
    // rust: Class::RedstoneTorch => self.torch_notify_neighbors(pos, state),
    // rust: Class::RedstoneWire => {
    // rust: if !same {
    // rust: self.wire_update_power(pos, state, None, true);
    // rust: for direction in [Direction::Up, Direction::Down] {
    // rust: self.update_neighbors_at(rel(pos, direction), block);
}
    // rust: self.wire_update_neighbors_of_neighboring_wires(pos);
}
}
    // rust: Class::Scaffolding => {
    // rust: self.schedule_tick(pos, block, 1);
}
    // rust: Class::Shelf => self.shelf_on_place(pos, state, old),
                // CarvedPumpkinBlock.onPlace: a pumpkin placed by any means may
                // complete a golem; the caller builds it.
    // rust: Class::CarvedPumpkin if !same => self.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state,
    // rust: kind: "golem",
    // rust: }),
    // rust: Class::SnifferEgg => {
    // rust: let boosted = b.is_block(self.below_state(pos), b.named.moss_block);
    // rust: if boosted {
    // rust: self.level_event(3009, pos, 0);
}
    // rust: self.game_event_state(pos, "minecraft:block_place", state);
    // rust: let delay = if boosted { 12000 } else { 24000 } / 3;
    // rust: let jitter = self.random().next_int_bound(300).unwrap_or(0);
    // rust: self.schedule_tick(pos, block, delay + jitter);
}
    // rust: Class::SculkSensor => {
    // rust: if !same
    // rust: && b.table.int(state, b.props.power) > 0
    // rust: && !self.ticks.has_block_tick(pos, block)
    // rust: {
    // rust: self.set_block(pos, b.table.set_int(state, b.props.power, 0), 18);
}
}
    // rust: Class::Sponge => {
    // rust: if !same {
    // rust: self.sponge_try_absorb(pos);
}
}
    // rust: Class::WetSponge => {
    // rust: if self.level.dimension() == super::Dimension::Nether {
    // rust: self.set_block_and_update(pos, b.default_of(b.named.sponge));
    // rust: self.level_event(2009, pos, 0);
    // rust: let pitch = (1.0 + self.random().next_float() * 0.2) * 0.7;
    // rust: self.emit(super::LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.wet_sponge.dries".into(),
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: });
}
}
    // rust: Class::Target => {
    // rust: if !same
    // rust: && b.table.int(state, b.props.power) > 0
    // rust: && !self.ticks.has_block_tick(pos, block)
    // rust: {
    // rust: self.set_block(pos, b.table.set_int(state, b.props.power, 0), 18);
}
}
    // rust: Class::Tnt => {
    // rust: if !same {
    // rust: self.tnt_check(pos);
}
}
    // rust: Class::TripWire => {
    // rust: if !same {
    // rust: self.tripwire_update_source(pos, state);
}
}
    // rust: Class::TurtleEgg => {
    // rust: if b.in_set(self.below_state(pos), &b.tags.sand) {
    // rust: self.level_event(2012, pos, 15);
}
}
    // rust: _ => continue,
}
    // rust: return;
}
}

    // `BlockState.affectNeighborsAfterRemoval`.
    // rust: pub fn affect_neighbors_after_removal(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: moved: bool,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let block = b.block(state);
    // rust: let chain = &b.data(state).chain;
    // rust: for &class in chain.iter() {
    // rust: match class {
    // rust: Class::AbstractFurnace
    // rust: | Class::Barrel
    // rust: | Class::BrewingStand
    // rust: | Class::Chest
    // rust: | Class::ChiseledBookShelf
    // rust: | Class::Crafter
    // rust: | Class::CreakingHeart
    // rust: | Class::DecoratedPot
    // rust: | Class::Dispenser
    // rust: | Class::Hopper
    // rust: | Class::Jukebox
    // rust: | Class::ShulkerBox
    // rust: | Class::CopperGolemStatue => self.update_neighbour_for_output_signal(pos, block),
    // rust: Class::Shelf => {
    // rust: self.update_neighbour_for_output_signal(pos, block);
    // rust: self.shelf_after_powering_down(pos, state);
}
    // rust: Class::BasePressurePlate => {
    // rust: if !moved && self.plate_signal_for_state(state) > 0 {
    // rust: self.plate_update_neighbours(pos, block);
}
}
    // rust: Class::BaseRail => {
    // rust: if !moved {
    // rust: if self.rail_shape(state).starts_with("ascending") {
    // rust: self.update_neighbors_at(super::update::above(pos), block);
}
    // rust: if !b.data(state).is(Class::Rail) {
    // rust: self.update_neighbors_at(pos, block);
    // rust: self.update_neighbors_at(below(pos), block);
}
}
}
    // rust: Class::Button | Class::Lever => {
    // rust: if !moved && b.table.bool(state, b.props.powered) {
    // rust: self.attached_update_neighbours(pos, state);
}
}
    // rust: Class::LightningRod => {
    // rust: if b.table.bool(state, b.props.powered) {
    // rust: self.lightning_rod_update_neighbors(pos, state);
}
}
    // rust: Class::PistonHead => {
    // rust: let base_pos = rel(pos, b.facing(state).opposite());
    // rust: let base = self.state(base_pos);
    // rust: if self.piston_head_fitting_base(state, base) {
    // rust: self.destroy_block(base_pos, true, super::flags::UPDATE_LIMIT);
}
}
    // rust: Class::Lectern => {
    // rust: if b.table.bool(state, b.props.powered) {
    // rust: self.lectern_update_below(pos, state);
}
}
    // rust: Class::Diode => {
    // rust: if !moved {
    // rust: self.diode_update_neighbors_in_front(pos, state);
}
}
    // rust: Class::Observer => {
    // rust: if b.table.bool(state, b.props.powered) && self.ticks.has_block_tick(pos, block)
    // rust: {
    // rust: let off = b.table.set_bool(state, b.props.powered, false);
    // rust: self.observer_update_in_front(pos, off);
}
}
    // rust: Class::RedstoneTorch => {
    // rust: if !moved {
    // rust: self.torch_notify_neighbors(pos, state);
}
}
    // rust: Class::RedstoneWire => {
    // rust: if !moved {
    // rust: for direction in Direction::ALL {
    // rust: self.update_neighbors_at(rel(pos, direction), block);
}
    // rust: self.wire_update_power(pos, state, None, false);
    // rust: self.wire_update_neighbors_of_neighboring_wires(pos);
}
}
    // rust: Class::SculkSensor => {
    // rust: if b.table.text(state, b.table_phase_key()) == "active" {
    // rust: self.update_neighbors_at(pos, block);
    // rust: self.update_neighbors_at(below(pos), block);
}
}
    // rust: Class::TripWire => {
    // rust: if !moved {
    // rust: let powered = b.table.set_bool(state, b.props.powered, true);
    // rust: self.tripwire_update_source(pos, powered);
}
}
    // rust: Class::TripWireHook => {
    // rust: if !moved {
    // rust: self.tripwire_hook_removed(pos, state);
}
}
    // rust: _ => continue,
}
    // rust: return;
}
}

    // `BlockState.updateIndirectNeighbourShapes` (only redstone wire overrides it).
    // rust: pub fn update_indirect_neighbour_shapes(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: flags: i32,
    // rust: limit: i32,
    // rust: ) {
    // rust: if self.b.is_block(state, self.b.named.redstone_wire) {
    // rust: self.wire_update_indirect(state, pos, flags, limit);
}
}

    // `ServerPlayerGameMode.destroyBlock`: `playerWillDestroy` then
    // `removeBlock`. Drops are the caller's (tool-dependent loot).
    // rust: pub(crate) fn player_destroy(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: creative: bool,
    // rust: correct_tool: bool,
    // rust: ) -> bool {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let state = self.state(pos);
    // rust: if b.is_air(state) {
    // rust: return false;
}
    // rust: let data = b.data(state);
        // DoorBlock also clears the bottom half when the tool would not drop it.
    // rust: if ((creative && data.is(Class::DoublePlant))
    // rust: || (data.is(Class::Door) && (creative || !correct_tool)))
    // rust: && b.table.text(state, p.half) == "upper"
    // rust: {
    // rust: let bottom = below(pos);
    // rust: let bottom_state = self.state(bottom);
    // rust: if b.is_block(bottom_state, b.block(state))
    // rust: && b.table.text(bottom_state, p.half) == "lower"
    // rust: {
    // rust: let replacement = if b.is_water_fluid(b.fluid(bottom_state).kind()) {
    // rust: b.default_of(b.named.water)
    // rust: } else {
    // rust: b.air()
}
    // rust: self.set_block(bottom, replacement, 35);
    // rust: self.level_event(2001, bottom, bottom_state.0 as i32);
}
}
    // rust: if creative && data.is(Class::AbstractBed) && b.table.text(state, p.part) == "foot" {
    // rust: let head_pos = rel(pos, b.facing(state));
    // rust: let head = self.state(head_pos);
    // rust: if b.is_block(head, b.block(state)) && b.table.text(head, p.part) == "head" {
    // rust: self.set_block(head_pos, b.air(), 35);
    // rust: self.level_event(2001, head_pos, head.0 as i32);
}
}
        // PistonHeadBlock.playerWillDestroy: in creative, destroy the base piston
        // without drops so removing the head does not drop a piston item.
    // rust: if creative && data.is(Class::PistonHead) {
    // rust: let base_pos = rel(pos, b.facing(state).opposite());
    // rust: let base = self.state(base_pos);
    // rust: if self.piston_head_fitting_base(state, base) {
    // rust: self.destroy_block(base_pos, false, super::flags::UPDATE_LIMIT);
}
}
        // TntBlock.playerWillDestroy: unstable TNT primes unless instabuild.
    // rust: if !creative && data.is(Class::Tnt) && b.table.bool(state, p.unstable) {
    // rust: self.prime_tnt(pos);
}
        // BaseFireBlock emits extinguish and suppresses generic destroy particles/sound.
    // rust: if data.is(Class::BaseFire) {
    // rust: self.level_event(1009, pos, 0);
    // rust: } else {
    // rust: self.level_event(2001, pos, state.0 as i32);
}
    // rust: self.game_event(pos, "minecraft:block_destroy");
    // rust: let removed = self.remove_block(pos, false);
        // MovingPistonBlock.destroy: a moving piston the player broke takes
        // the extended base behind it with it. setBlock callers keep it.
    // rust: if removed && b.is_block(state, b.named.moving_piston) {
    // rust: self.destroy_moving_piston_base(pos, state);
}
    // rust: removed
}
    // `TurtleEggBlock.playerDestroy` (after the drops): `decreaseEggs` plays the
    // break and puts back all but one egg of the mined stack. `destroyed` is the
    // state that was broken.
    // rust: pub(crate) fn turtle_egg_destroyed_by_player(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: destroyed: BlockStateId,
    // rust: ) {
    // rust: let b = self.b;
    // rust: if !b.data(destroyed).is(Class::TurtleEgg) {
    // rust: return;
}
    // rust: let pitch = 0.9 + self.random().next_float() * 0.2;
    // rust: self.sound(
    // rust: pos,
    // rust: &std::sync::Arc::from("minecraft:entity.turtle.egg_break"),
    // rust: 0.7,
    // rust: pitch,
    // rust: );
    // rust: let eggs = b.table.int(destroyed, b.props.eggs);
    // rust: if eggs > 1 {
    // rust: self.set_block(pos, b.table.set_int(destroyed, b.props.eggs, eggs - 1), 2);
    // rust: self.game_event(pos, "minecraft:block_destroy");
    // rust: self.level_event(2001, pos, destroyed.0 as i32);
}
}
    // `IceBlock.playerDestroy` (after the drops): mined ice turns into water
    // when it sits over a solid block or a liquid, unless the tool prevents
    // ice melting (silk touch). In the nether, where water evaporates, the
    // block stays air.
    // rust: pub(crate) fn ice_destroyed_by_player(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: destroyed: BlockStateId,
    // rust: prevents_melting: bool,
    // rust: ) {
    // rust: let b = self.b;
    // rust: if !b.data(destroyed).is(Class::Ice)
    // rust: || prevents_melting
    // rust: || self.level.dimension() == super::Dimension::Nether
    // rust: {
    // rust: return;
}
    // rust: let below = self.below_state(pos);
    // rust: if b.in_set(below, &b.tags.blocks_motion) || b.liquid(below) {
    // rust: let water = b.default_of(b.named.water);
    // rust: self.set_block_and_update(pos, water);
}
}
    // `entityInside` for entity-sensing blocks.
    // rust: pub(crate) fn entity_inside(&mut self, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: let data = b.data(state);
    // rust: if data.is(Class::BasePressurePlate) {
    // rust: let signal = self.plate_signal_for_state(state);
    // rust: if signal == 0 {
    // rust: self.plate_check_pressed(pos, state, signal);
}
    // rust: } else if data.is(Class::DetectorRail) {
    // rust: if !b.table.bool(state, b.props.powered) {
    // rust: self.detector_rail_check_pressed(pos, state);
}
    // rust: } else if data.is(Class::Button) {
            // ButtonBlock.entityInside: a wooden button an arrow is inside.
    // rust: if data.set_type.as_ref().is_some_and(|s| s.arrows)
    // rust: && !b.table.bool(state, b.props.powered)
    // rust: {
    // rust: self.button_check_pressed(pos, state);
}
    // rust: } else if data.is(Class::TripWire)
    // rust: && !b.table.bool(state, b.props.powered)
    // rust: && !self.ticks.has_block_tick(pos, b.block(state))
    // rust: {
    // rust: self.tripwire_check_pressed(pos);
}
}

    // `LilyPadBlock.entityInside` for a boat: the lily pad at `pos` is
    // destroyed with its drops (`Level.destroyBlock(pos, true, entity)`).
    // rust: pub(crate) fn boat_inside(&mut self, pos: BlockPos) {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: if b.data(state).is(Class::LilyPad) {
    // rust: self.destroy_block(pos, true, super::flags::UPDATE_LIMIT);
}
}

    // ---- misc helpers ----

    // `BaseFireBlock.onPlace`: a fire inside an empty obsidian frame (in the
    // overworld or the nether) lights it, otherwise one that cannot survive
    // goes out.
base_fire_on_place :: proc(self: ^Self, pos: BlockPos, state: BlockStateId, same: bool) {
}
    // rust: if same {
    // rust: return;
}
    // rust: if matches!(
    // rust: self.level.dimension(),
    // rust: super::Dimension::Overworld | super::Dimension::Nether
    // rust: ) && let Some(shape) = self.find_empty_portal_shape(pos, true)
    // rust: {
    // rust: self.create_portal_blocks(&shape);
    // rust: return;
}
    // rust: if !self.can_survive(state, pos) {
    // rust: self.remove_block(pos, false);
}
}
    // `SpongeBlock.tryAbsorbWater`.
    // rust: pub(crate) fn sponge_try_absorb(&mut self, start: BlockPos) {
    // rust: if self.sponge_remove_water(start) {
    // rust: let b = self.b;
    // rust: self.set_block(start, b.default_of(b.named.wet_sponge), 2);
    // rust: self.level.observe_sponge_absorb(start);
    // rust: self.emit(super::LevelEvent::Sound {
    // rust: pos: start,
    // rust: sound: "minecraft:block.sponge.absorb".into(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
}
}
sponge_remove_water :: proc(self: ^Self, start: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
//         use std::collections::{HashSet, VecDeque};
    // rust: let b = self.b;
    // rust: let mut queue = VecDeque::from([(start, 0)]);
    // rust: let mut visited = HashSet::new();
    // rust: let mut count = 0;
    // rust: while let Some((pos, depth)) = queue.pop_front() {
    // rust: if !visited.insert(pos) {
    // rust: continue;
}
    // rust: let accept = if pos == start {
    // rust: true
    // rust: } else {
    // rust: let state = self.state(pos);
    // rust: if !b.is_water_fluid(self.fluid_at(pos).kind()) {
    // rust: false
    // rust: } else if self.pickup_block(pos, state, false) {
    // rust: true
    // rust: } else {
    // rust: if b.instance_of(state, Class::Liquid) {
    // rust: self.set_block_and_update(pos, b.air());
    // rust: } else {
    // rust: let n = b.named;
    // rust: let block = b.block(state);
    // rust: if block != n.kelp
    // rust: && block != n.kelp_plant
    // rust: && block != n.seagrass
    // rust: && block != n.tall_seagrass
    // rust: {
    // rust: continue;
}
    // rust: self.drop_resources(state, pos);
    // rust: self.set_block_and_update(pos, b.air());
}
    // rust: true
}
}
    // rust: if !accept {
    // rust: continue;
}
    // rust: count += 1;
    // rust: if count >= 65 {
    // rust: return count > 1;
}
    // rust: if depth < 6 {
    // rust: for direction in Direction::ALL {
    // rust: queue.push_back((rel(pos, direction), depth + 1));
}
}
}
    // rust: count > 1
}
frosted_ice_fewer_neighbours_than :: proc(self: ^Self, pos: BlockPos, limit: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut count = 0;
    // rust: for direction in Direction::ALL {
    // rust: if self
    // rust: .b
    // rust: .data(self.rel_state(pos, direction))
    // rust: .is(Class::FrostedIce)
    // rust: {
    // rust: count += 1;
    // rust: if count >= limit {
    // rust: return false;
}
}
}
    // rust: true
}
    // `FrostedIceBlock.melt` → `IceBlock.melt`.
    // rust: pub(crate) fn frosted_ice_melt(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: self.ice_melt(pos, state);
}
    // `IceBlock.melt`.
    // rust: pub(crate) fn ice_melt(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let target = if self.level.dimension() == super::Dimension::Nether {
    // rust: b.air()
    // rust: } else {
    // rust: b.default_of(b.named.water)
}
    // rust: if !self.level.allow_block_fade(pos, state, target) {
    // rust: return;
}
    // rust: if self.level.dimension() == super::Dimension::Nether {
    // rust: self.remove_block(pos, false);
    // rust: } else {
    // rust: self.set_block_and_update(pos, target);
    // rust: self.neighbor_changed_at(pos, b.named.water);
    // rust: self.game_event_state(pos, "minecraft:block_destroy", state);
}
}
    // `BigDripleafBlock.entityInside` on a server level: an entity standing on
    // a flat leaf (`canEntityTilt`: on the ground, its feet above the leaf's
    // lowest top, 11/16, less 4/16: 0.6875) tilts it UNSTABLE unless the leaf
    // is powered; `setTiltAndScheduleTick` with no sound (UNSTABLE causes no
    // vibration) and the next state in 10 ticks.
    // rust: pub(crate) fn big_dripleaf_entity_inside(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: on_ground: bool,
    // rust: feet_y: f64,
    // rust: ) {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: if !b.data(state).is(Class::BigDripleaf)
    // rust: || b.table.text(state, b.props.tilt) != "none"
    // rust: || !(on_ground && feet_y > f64::from(pos.y) + f64::from(0.6875_f32))
    // rust: || self.has_neighbor_signal(pos)
    // rust: {
    // rust: return;
}
    // rust: self.set_block(pos, b.table.set_text(state, b.props.tilt, "unstable"), 2);
    // rust: self.schedule_tick(pos, b.block(state), 10);
}
    // `BigDripleafBlock.onProjectileHit`: FULL immediately, even while
    // powered; setTiltAndScheduleTick plays the down sound and resets in 100.
    // rust: pub(crate) fn big_dripleaf_projectile_hit(&mut self, pos: BlockPos) -> bool {
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: if !b.data(state).is(Class::BigDripleaf) {
    // rust: return false;
}
    // rust: let next = b.table.set_text(state, b.props.tilt, "full");
    // rust: self.set_block(pos, next, 2);
    // rust: if state != next {
    // rust: self.game_event(pos, "minecraft:block_change");
}
    // rust: let pitch = self.random().next_float() * 0.4 + 0.8;
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.big_dripleaf.tilt_down".into(),
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: });
    // rust: self.schedule_tick(pos, b.block(state), 100);
    // rust: true
}
    // `BigDripleafBlock.resetTilt`.
    // rust: pub(crate) fn big_dripleaf_reset_tilt(&mut self, pos: BlockPos, state: BlockStateId) {
    // rust: let b = self.b;
    // rust: let next = b.table.set_text(state, b.props.tilt, "none");
    // rust: self.set_block(pos, next, 2);
    // rust: if b.table.text(state, b.props.tilt) != "none" {
            // setTilt: NONE causes a vibration when the tilt changes.
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: let pitch = self.random().next_float() * 0.4 + 0.8;
    // rust: self.emit(super::LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.big_dripleaf.tilt_up".into(),
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: });
}
}
}

    // rust: impl super::Behaviours {
    // rust: pub(crate) fn table_phase_key(&self) -> super::states::PropKey {
    // rust: self.props.sculk_sensor_phase
}
}
