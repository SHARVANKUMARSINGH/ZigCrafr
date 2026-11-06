//! Transpiled from Horizon Rust crate
package horizon_world_interact

import "core:fmt"
import "core:mem"
import "core:math"

// `BlockBehaviour.useWithoutItem` (right-click with an empty hand or an item
// that does not handle the block itself).
// use super::{Behaviours, LevelAccess, LevelEvent, Sim, Ticks, classes::Class, update::below};
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: geometry::{Direction, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
// use std::sync::Arc;

// `InteractionResult` as seen by the server.
InteractionResult :: enum {
    Success,
    Consume,
    Pass,
}
    // rust: impl InteractionResult {
consumes_action :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !matches!(self, Self::Pass)
}

    // Whether the interaction swings the player's arm.
    //
    // In vanilla, InteractionResult.SUCCESS swings (swing source CLIENT),
    // while CONSUME consumes the action without swinging (swing source SERVER).
should_swing :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self, Self::Success)
}
}
// Which part of `BlockState` answered a use on a block.
UseBranch :: enum {
    // `useItemOn`, with the held item.
    ItemOn,
    // `useWithoutItem`, after `useItemOn` asked to try with an empty hand.
    WithoutItem,
}

// `SelectableSlotContainer.getHitSlot`: the slot of a block with `rows` by
// `columns` slots on its front face (the way it `facing`) that the click at
// `hit` on `face` of the block at `pos` lands in, if it is the front face.
    // rust: pub fn hit_slot(
    // rust: facing: Direction,
    // rust: face: Direction,
    // rust: pos: BlockPos,
    // rust: hit: Vec3,
    // rust: rows: i32,
    // rust: columns: i32,
    // rust: ) -> Option<usize> {
    // rust: if facing != face {
    // rust: return None;
}
    // The location relative to the block in front of the face, which only
    // moves the axis the face points along: the others are the block's own.
    // rust: let (dx, dy, dz) = (
    // rust: hit.x - f64::from(pos.x),
    // rust: hit.y - f64::from(pos.y),
    // rust: hit.z - f64::from(pos.z),
    // rust: );
    // rust: let (x, y) = match face {
    // rust: Direction::North => ((1.0 - dx) as f32, dy as f32),
    // rust: Direction::South => (dx as f32, dy as f32),
    // rust: Direction::West => (dz as f32, dy as f32),
    // rust: Direction::East => ((1.0 - dz) as f32, dy as f32),
    // rust: Direction::Down | Direction::Up => return None,
}
    // getSection
    // rust: let section = |relative: f32, sections: i32| {
    // rust: let size = 16.0f32 / sections as f32;
    // rust: ((relative * 16.0f32 / size).floor() as i32).clamp(0, sections - 1)
}
    // rust: let row = section(1.0 - y, rows);
    // rust: let column = section(x, columns);
    // rust: Some((column + row * columns) as usize)
}

// The interacting player, as far as block behaviour needs it.
PlayerContext :: struct {
    // View rotation in degrees.
    yaw: f32,
    pitch: f32,
    // `Abilities.mayBuild` (false in adventure mode).
    may_build: bool,
    // `Player.canEat(false)` (hunger below max, or creative).
    can_eat: bool,
    // `Player.canUseGameMasterBlocks` (creative operator).
    game_master: bool,
}

// Player-side effects of an interaction, reported through
// [`LevelEvent::Player`]; block changes are already applied.
PlayerEffect :: enum {
    // Open the block's menu (crafting table, furnace, chest, sign editor, ...).
    OpenMenu,
    // `CakeBlock.eat`: the player eats a slice (food 2, saturation 0.1).
    EatCake,
    // Give the item to the player (dropping it when the inventory is full).
    GiveItem(Arc<str>),
    // Pop the item at the block (composter bone meal).
    DropItem(Arc<str>),
    // Evaluate the block-interaction loot table and pop the results.
    InteractLoot(&'static str),
    // Try to sleep in the bed whose head is at the event position.
    Sleep,
    // Respawn anchor: set the respawn point (or explode outside the Nether).
    RespawnAnchor,
}

    // rust: impl<L: LevelAccess + ?Sized> Sim<'_, L> {
player_effect :: proc(self: ^Self, pos: BlockPos, state: BlockStateId, effect: PlayerEffect) {
}
    // rust: self.emit(LevelEvent::Player { pos, state, effect });
}

    // rust: pub(crate) fn use_without_item(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: hit: Vec3,
    // rust: player: PlayerContext,
    // rust: ) -> InteractionResult {
    // rust: let b = self.b;
    // rust: let p = b.props;
    // rust: let table = &b.table;
    // rust: let state = self.state(pos);
    // rust: let data = b.data(state);
    // rust: let block = b.block(state);
//         use InteractionResult::*;
    // rust: for &class in data.chain.iter() {
    // rust: return match class {
    // rust: Class::Door => {
    // rust: if !data.set_type.as_ref().is_some_and(|s| s.can_open_by_hand) {
    // rust: return Pass;
}
    // rust: let next = table.cycle(state, p.open);
    // rust: self.set_block(pos, next, 10);
    // rust: let open = table.bool(next, p.open);
    // rust: self.door_sound(pos, next, open);
    // rust: self.game_event(
    // rust: pos,
    // rust: if open {
    // rust: "minecraft:block_open"
    // rust: } else {
    // rust: "minecraft:block_close"
    // rust: },
    // rust: );
    // rust: Success
}
    // rust: Class::TrapDoor => {
    // rust: if !data.set_type.as_ref().is_some_and(|s| s.can_open_by_hand) {
    // rust: return Pass;
}
    // rust: let next = table.cycle(state, p.open);
    // rust: self.set_block(pos, next, 2);
    // rust: if b.is_waterlogged(next) {
    // rust: self.schedule_water_tick(pos);
}
    // rust: self.trapdoor_sound(pos, next, table.bool(next, p.open));
    // rust: Success
}
    // rust: Class::FenceGate => {
    // rust: let next = if table.bool(state, p.open) {
    // rust: table.set_bool(state, p.open, false)
    // rust: } else {
    // rust: let direction = super::place::from_y_rot(f64::from(player.yaw));
    // rust: let mut next = state;
    // rust: if b.facing(state) == direction.opposite() {
    // rust: next = table.set_dir(next, p.facing, direction);
}
    // rust: table.set_bool(next, p.open, true)
}
    // rust: self.set_block(pos, next, 10);
    // rust: let opens = table.bool(next, p.open);
    // rust: let sound = if opens {
    // rust: data.gate_open.clone()
    // rust: } else {
    // rust: data.gate_close.clone()
}
    // rust: let pitch = self.random().next_float() * 0.1 + 0.9;
    // rust: if let Some(sound) = sound {
    // rust: self.sound(pos, &sound, 1.0, pitch);
}
    // rust: self.game_event(
    // rust: pos,
    // rust: if opens {
    // rust: "minecraft:block_open"
    // rust: } else {
    // rust: "minecraft:block_close"
    // rust: },
    // rust: );
    // rust: Success
}
    // rust: Class::Button => {
    // rust: if table.bool(state, p.powered) {
    // rust: return Consume;
}
    // rust: self.button_press(pos, state);
    // rust: Success
}
    // rust: Class::Lever => {
    // rust: self.lever_pull(pos, state);
    // rust: Success
}
    // rust: Class::Repeater => {
    // rust: if !player.may_build {
    // rust: return Pass;
}
    // rust: self.set_block_and_update(pos, table.cycle(state, p.delay));
    // rust: Success
}
    // rust: Class::Comparator => {
    // rust: if !player.may_build {
    // rust: return Pass;
}
    // rust: let next = table.cycle(state, p.mode);
    // rust: let pitch = if table.text(next, p.mode) == "subtract" {
    // rust: 0.55
    // rust: } else {
    // rust: 0.5
}
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.comparator.click".into(),
    // rust: volume: 0.3,
    // rust: pitch,
    // rust: });
    // rust: self.set_block(pos, next, 2);
    // rust: if b.is_block(self.state(pos), block) {
    // rust: self.comparator_refresh(pos, next);
}
    // rust: Success
}
    // rust: Class::Note => {
    // rust: let next = table.cycle(state, p.note);
    // rust: let old_note = table.int(state, p.note);
    // rust: let new_note = table.int(next, p.note);
    // rust: let instrument = table.text(state, p.instrument);
    // rust: let Some(note) = self
    // rust: .level
    // rust: .note_block_change(pos, instrument, old_note, new_note)
    // rust: else {
    // rust: return Success;
}
    // rust: let next = table.set_int(
    // rust: next,
    // rust: p.note,
    // rust: if (0..=24).contains(&note) {
    // rust: note
    // rust: } else {
    // rust: new_note
    // rust: },
    // rust: );
    // rust: if !self.note_play_allowed(pos, next) {
    // rust: return Success;
}
    // rust: self.set_block_and_update(pos, next);
    // rust: self.note_play_unchecked(pos, next);
    // rust: Success
}
    // rust: Class::RedstoneWire => self.wire_use(pos, state, player),
    // rust: Class::DaylightDetector => {
    // rust: if !player.may_build {
    // rust: return Pass;
}
    // rust: let next = table.cycle(state, p.inverted);
    // rust: self.set_block(pos, next, 2);
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: self.daylight_detector_update_signal(pos, next);
    // rust: Success
}
    // rust: Class::Cake => {
    // rust: if !player.can_eat {
    // rust: return Pass;
}
    // rust: self.player_effect(pos, state, PlayerEffect::EatCake);
    // rust: self.game_event(pos, "minecraft:eat");
    // rust: let bites = table.int(state, p.bites);
    // rust: if bites < 6 {
    // rust: self.set_block_and_update(pos, table.set_int(state, p.bites, bites + 1));
    // rust: } else {
    // rust: self.remove_block(pos, false);
    // rust: self.game_event(pos, "minecraft:block_destroy");
}
    // rust: Success
}
    // rust: Class::CandleCake => {
    // rust: if !player.can_eat {
    // rust: return Pass;
}
    // rust: self.player_effect(pos, state, PlayerEffect::EatCake);
    // rust: self.game_event(pos, "minecraft:eat");
    // rust: let cake = b.default_of(b.named.cake);
    // rust: self.set_block_and_update(pos, table.set_int(cake, p.bites, 1));
    // rust: self.drop_resources(state, pos);
    // rust: Success
}
    // rust: Class::Composter => {
    // rust: if table.int(state, p.level) != 8 {
    // rust: return Pass;
}
    // rust: self.composter_extract_produce(pos, state);
    // rust: Success
}
    // rust: Class::CaveVines | Class::CaveVinesPlant => {
    // rust: if !table.bool(state, p.berries) {
    // rust: return Pass;
}
    // rust: self.player_effect(
    // rust: pos,
    // rust: state,
    // rust: PlayerEffect::InteractLoot("minecraft:harvest/cave_vine"),
    // rust: );
    // rust: let pitch = self.random().next_float() * 0.4 + 0.8;
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.cave_vines.pick_berries".into(),
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: });
    // rust: let next = table.set_bool(state, p.berries, false);
    // rust: self.set_block(pos, next, 2);
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: Success
}
    // rust: Class::SweetBerryBush => {
    // rust: if table.int(state, p.age) <= 1 {
    // rust: return Pass;
}
    // rust: self.player_effect(
    // rust: pos,
    // rust: state,
    // rust: PlayerEffect::InteractLoot("minecraft:harvest/sweet_berry_bush"),
    // rust: );
    // rust: let pitch = 0.8 + self.random().next_float() * 0.4;
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.sweet_berry_bush.pick_berries".into(),
    // rust: volume: 1.0,
    // rust: pitch,
    // rust: });
    // rust: self.set_block(pos, table.set_int(state, p.age, 1), 2);
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: Success
}
    // rust: Class::FlowerPot => {
    // rust: let Some(potted) = data.link else {
    // rust: return Consume;
}
    // rust: if b.is_air(b.default_of(potted)) {
    // rust: return Consume;
}
    // rust: let item = b.block_data(potted).item.clone();
    // rust: self.player_effect(pos, state, PlayerEffect::GiveItem(item));
    // rust: self.set_block_and_update(pos, b.default_of(b.named.flower_pot));
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: Success
}
    // rust: Class::DragonEgg => {
    // rust: self.dragon_egg_teleport(pos, state);
    // rust: Success
}
    // rust: Class::AbstractBed => {
    // rust: let part = table.text(state, p.part).to_owned();
    // rust: let facing = b.facing(state);
    // rust: let other_dir = if part == "foot" {
    // rust: facing
    // rust: } else {
    // rust: facing.opposite()
}
    // rust: let other = self.state(super::update::rel(pos, other_dir));
    // rust: if b.is_block(other, block) && table.text(other, p.part) != part {
    // rust: let head = if part == "head" {
    // rust: pos
    // rust: } else {
    // rust: super::update::rel(pos, facing)
}
    // rust: let head_state = self.state(head);
    // rust: self.player_effect(head, head_state, PlayerEffect::Sleep);
    // rust: Success
    // rust: } else {
    // rust: Consume
}
}
    // rust: Class::RespawnAnchor => {
    // rust: if table.int(state, p.charges) == 0 {
    // rust: return Pass;
}
    // rust: self.player_effect(pos, state, PlayerEffect::RespawnAnchor);
    // rust: Success
}
    // rust: Class::Light => {
    // rust: if player.game_master {
    // rust: self.set_block(pos, table.cycle(state, p.level), 2);
    // rust: Success
    // rust: } else {
    // rust: Consume
}
}
    // rust: Class::ChiseledBookShelf => {
                    // useItemOn and useWithoutItem agree on what a click takes: no
                    // slot under it passes, an empty slot consumes it, a book in
                    // it comes out (the block entity is the game's).
    // rust: let Some(slot) = hit_slot(b.facing(state), face, pos, hit, 2, 3) else {
    // rust: return Pass;
}
    // rust: let occupied = [
    // rust: p.slot_0_occupied,
    // rust: p.slot_1_occupied,
    // rust: p.slot_2_occupied,
    // rust: p.slot_3_occupied,
    // rust: p.slot_4_occupied,
    // rust: p.slot_5_occupied,
    // rust: ];
    // rust: if table.bool(state, occupied[slot]) {
    // rust: Success
    // rust: } else {
    // rust: Consume
}
}
    // rust: Class::Bell => {
    // rust: if self.bell_hit(pos, state, face, hit.y - f64::from(pos.y)) {
    // rust: Success
    // rust: } else {
    // rust: Pass
}
}
    // rust: Class::AbstractFurnace
    // rust: | Class::Anvil
    // rust: | Class::Barrel
    // rust: | Class::Beacon
    // rust: | Class::BrewingStand
    // rust: | Class::CartographyTable
    // rust: | Class::Chest
    // rust: | Class::CopperChest
    // rust: | Class::Crafter
    // rust: | Class::CraftingTable
    // rust: | Class::Dispenser
    // rust: | Class::Dropper
    // rust: | Class::EnchantingTable
    // rust: | Class::EnderChest
    // rust: | Class::Grindstone
    // rust: | Class::Hopper
    // rust: | Class::Loom
    // rust: | Class::ShulkerBox
    // rust: | Class::Sign
    // rust: | Class::SmithingTable
    // rust: | Class::Stonecutter
    // rust: | Class::TrappedChest
    // rust: | Class::Lectern => {
    // rust: self.player_effect(pos, state, PlayerEffect::OpenMenu);
    // rust: Success
}
                // DecoratedPotBlock.useWithoutItem: the wobble always succeeds.
    // rust: Class::DecoratedPot => Success,
                // MovingPistonBlock.useWithoutItem: a moving piston whose block
                // entity is gone (`Level.getBlockEntity` null) is removed by the
                // click on a server; one still in flight passes it on.
    // rust: Class::MovingPiston => {
    // rust: if !self.level.is_client_side() && self.moving_piston(pos).is_none() {
    // rust: self.remove_block(pos, false);
                        // CONSUME: the action is used, the arm does not swing.
    // rust: Consume
    // rust: } else {
    // rust: Pass
}
}
                // JukeboxBlock.useWithoutItem: ejecting a disc is SUCCESS (the
                // insert is useItemOn). An empty jukebox passes.
    // rust: Class::Jukebox if table.bool(state, p.has_record) => Success,
    // rust: Class::Command
    // rust: | Class::Structure
    // rust: | Class::Jigsaw
    // rust: | Class::TestBlock
    // rust: | Class::TestInstanceBlock => {
    // rust: if player.game_master {
    // rust: self.player_effect(pos, state, PlayerEffect::OpenMenu);
    // rust: Success
    // rust: } else {
    // rust: Pass
}
}
    // rust: _ => continue,
}
}
    // rust: let _ = below;
    // rust: Pass
}

    // `RedstoneWireBlock.useWithoutItem`: toggle between dot and cross.
    // rust: fn wire_use(
    // rust: &mut self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: player: PlayerContext,
    // rust: ) -> InteractionResult {
    // rust: let b = self.b;
    // rust: if !player.may_build {
    // rust: return InteractionResult::Pass;
}
    // rust: let connected = |s: BlockStateId, d: Direction| b.table.text(s, b.dir_prop(d)) != "none";
    // rust: let horizontal = super::update::HORIZONTAL;
    // rust: let cross = horizontal.into_iter().all(|d| connected(state, d));
    // rust: let dot = !horizontal.into_iter().any(|d| connected(state, d));
    // rust: if !(cross || dot) {
    // rust: return InteractionResult::Pass;
}
    // rust: let power = b.table.int(state, b.props.power);
    // rust: let base = if cross {
    // rust: b.table
    // rust: .set_int(b.default_of(b.named.redstone_wire), b.props.power, power)
    // rust: } else {
    // rust: self.wire_cross_state(power)
}
    // rust: let next = self.wire_connection_state(base, pos);
    // rust: if next == state {
    // rust: return InteractionResult::Pass;
}
    // rust: self.set_block_and_update(pos, next);
    // rust: let orientation = self.initial_orientation(None, Some(Direction::Up));
    // rust: for direction in horizontal {
    // rust: let relative = super::update::rel(pos, direction);
    // rust: if connected(state, direction) != connected(next, direction)
    // rust: && self.is_redstone_conductor(self.state(relative), relative)
    // rust: {
    // rust: let block = b.block(next);
    // rust: self.update_neighbors_at_except_oriented(
    // rust: relative,
    // rust: block,
    // rust: direction.opposite(),
    // rust: orientation.map(|o| o.with_front(direction)),
    // rust: );
}
}
    // rust: InteractionResult::Success
}

    // `ComposterBlock.extractProduce`: the bone meal pops out, the composter
    // empties and its sound plays.
composter_extract_produce :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: self.player_effect(
    // rust: pos,
    // rust: state,
    // rust: PlayerEffect::DropItem("minecraft:bone_meal".into()),
    // rust: );
    // rust: self.set_block_and_update(pos, b.table.set_int(state, b.props.level, 0));
    // rust: self.game_event(pos, "minecraft:block_change");
    // rust: self.emit(LevelEvent::Sound {
    // rust: pos,
    // rust: sound: "minecraft:block.composter.empty".into(),
    // rust: volume: 1.0,
    // rust: pitch: 1.0,
    // rust: });
}

    // `ComposterBlock.addLayer` once its `compostable` provider gave
    // `layers`: the new state (the old one when no layer is added).
composter_add_layer :: proc(self: ^Self, pos: BlockPos, layers: i32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let b = self.b;
    // rust: let state = self.state(pos);
    // rust: if layers <= 0 {
    // rust: return state;
}
    // rust: let level = b.table.int(state, b.props.level);
    // rust: let next_level = (level + layers).clamp(0, 7);
    // rust: let next = b.table.set_int(state, b.props.level, next_level);
    // rust: self.set_block_and_update(pos, next);
    // rust: self.game_event_state(pos, "minecraft:block_change", next);
    // rust: if next_level == 7 {
    // rust: self.schedule_tick(pos, b.block(state), 20);
}
    // rust: next
}

    // `DragonEggBlock.teleport`.
dragon_egg_teleport :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: let b = self.b;
    // rust: for _ in 0..1000 {
    // rust: let dx = self.random().next_int_bound(16).unwrap_or(0)
    // rust: - self.random().next_int_bound(16).unwrap_or(0);
    // rust: let dy = self.random().next_int_bound(8).unwrap_or(0)
    // rust: - self.random().next_int_bound(8).unwrap_or(0);
    // rust: let dz = self.random().next_int_bound(16).unwrap_or(0)
    // rust: - self.random().next_int_bound(16).unwrap_or(0);
    // rust: let test = pos.offset(dx, dy, dz);
    // rust: if b.is_air(self.state(test))
    // rust: && !b.is_air(self.below_state(test))
    // rust: && self.is_inside_build_height(test.y)
    // rust: {
                // BlockUtil.packDifferenceInPosition(pos, test, 16, 8, 16)
    // rust: let packed = ((dx + 16) << 16) | ((dy + 8) << 8) | (dz + 16);
    // rust: self.level_event(2015, pos, packed);
    // rust: self.set_block(test, state, 2);
    // rust: self.remove_block(pos, false);
    // rust: return;
}
}
}
}

    // rust: impl Behaviours {
    // `ComposterBlock.addLayer` at `pos` with the layers its item's
    // `compostable` provider gave, followed by level event 1500 (fill
    // particles and sound; data 1 when a layer was added) as every caller
    // does: `useItemOn` and the hopper input container. The new state.
    // rust: pub fn composter_insert<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: layers: i32,
    // rust: ) -> BlockStateId {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: let next = sim.composter_add_layer(pos, layers);
    // rust: sim.level_event(1500, pos, i32::from(next != state));
    // rust: next
}

    // `ComposterBlock.addLayer` without level event 1500, for a villager
    // that composts several items and sends the event once at the end
    // (`WorkAtComposter.compostItems`). The new state.
    // rust: pub fn composter_layer<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: layers: i32,
    // rust: ) -> BlockStateId {
    // rust: self.sim(level, ticks).composter_add_layer(pos, layers)
}

    // `ComposterBlock.extractProduce` by a villager (`WorkAtComposter`).
    // rust: pub fn composter_extract<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: sim.composter_extract_produce(pos, state);
}

    // Level event 1500 (`WorkAtComposter.spawnComposterFillEffects`): data 1
    // when the composter's state changed.
    // rust: pub fn composter_fill_effects<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: changed: bool,
    // rust: ) {
    // rust: self.sim(level, ticks)
    // rust: .level_event(1500, pos, i32::from(changed));
}

    // `ComposterBlock.empty`: the hopper output container took the bone meal.
    // rust: pub fn composter_empty<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: let next = self.table.set_int(state, self.props.level, 0);
    // rust: sim.set_block_and_update(pos, next);
    // rust: sim.game_event_state(pos, "minecraft:block_change", next);
}

    // `BlockBehaviour.attack` when mining begins: `RedStoneOreBlock.attack`
    // lights the ore, `DragonEggBlock.attack` teleports the egg,
    // `NoteBlock.attack` plays the note. True for a note block, whose player
    // also earns the `play_noteblock` statistic.
    // rust: pub fn attack_block<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> bool {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: let chain = &self.data(state).chain;
    // rust: if chain.contains(&Class::DragonEgg) {
    // rust: sim.dragon_egg_teleport(pos, state);
}
    // rust: if chain.contains(&Class::Note) {
    // rust: sim.note_play(pos, state);
    // rust: return true;
}
    // rust: if chain.contains(&Class::RedStoneOre) && !self.table.bool(state, self.props.lit) {
    // rust: sim.set_block_and_update(pos, self.table.set_bool(state, self.props.lit, true));
}
    // rust: false
}

    // `BlockState.useWithoutItem` for a right-click on `pos` (hit face and
    // absolute hit location as in `BlockHitResult`).
    // rust: pub fn use_without_item<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: hit: Vec3,
    // rust: player: PlayerContext,
    // rust: ) -> InteractionResult {
    // rust: self.sim(level, ticks)
    // rust: .use_without_item(pos, face, hit, player)
}
    // `DoorBlock.setOpen`: a mob opens or closes the door at `pos` (either half), with its sound
    // and game event. False when it is no door or already so.
    // rust: pub fn set_door_open<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: open: bool,
    // rust: ) -> bool {
    // rust: let state = level.block_state(pos);
    // rust: if !self.data(state).is(Class::Door) || self.table.bool(state, self.props.open) == open {
    // rust: return false;
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let next = self.table.set_bool(state, self.props.open, open);
    // rust: sim.set_block(pos, next, 10);
    // rust: sim.door_sound(pos, next, open);
    // rust: sim.game_event(
    // rust: pos,
    // rust: if open {
    // rust: "minecraft:block_open"
    // rust: } else {
    // rust: "minecraft:block_close"
    // rust: },
    // rust: );
    // rust: true
}
    // `FenceGateBlock.onExplosionHit` for a blast that can trigger blocks (a
    // wind charge): an unpowered gate at `pos` toggles (`setBlockAndUpdate`),
    // with the open or close sound at a random pitch and the matching game
    // event, which has no source entity. Unlike a click, the gate keeps its
    // facing. False when the block is no fence gate or is powered.
    // rust: pub fn fence_gate_exploded<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> bool {
    // rust: let state = level.block_state(pos);
    // rust: let data = self.data(state);
    // rust: if !data.is(Class::FenceGate) || self.table.bool(state, self.props.powered) {
    // rust: return false;
}
    // rust: let open = self.table.bool(state, self.props.open);
    // rust: let sound = if open {
    // rust: data.gate_close.clone()
    // rust: } else {
    // rust: data.gate_open.clone()
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: sim.set_block_and_update(pos, self.table.set_bool(state, self.props.open, !open));
    // rust: let pitch = sim.random().next_float() * 0.1 + 0.9;
    // rust: if let Some(sound) = sound {
    // rust: sim.sound(pos, &sound, 1.0, pitch);
}
    // rust: sim.game_event_state(
    // rust: pos,
    // rust: if open {
    // rust: "minecraft:block_close"
    // rust: } else {
    // rust: "minecraft:block_open"
    // rust: },
    // rust: state,
    // rust: );
    // rust: true
}
    // `AbstractCandleBlock.isLit` (a lit block of `#candles` or `#candle_cakes`) then
    // `AbstractCandleBlock.extinguish(null, ...)`:
    // a lit candle or candle cake at `pos` goes out (`setBlock` with flags 11), with
    // the extinguish sound and the block-change game event, which has no source
    // entity. The smoke is drawn by a client's own `addParticle`, never by the
    // server. False when the block is not a lit candle.
    // rust: pub fn extinguish_candle<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> bool {
    // rust: let state = level.block_state(pos);
    // rust: let data = self.data(state);
        // `#candles` is every `CandleBlock`, `#candle_cakes` every `CandleCakeBlock`.
    // rust: if !(data.is(Class::Candle) || data.is(Class::CandleCake))
    // rust: || !self.table.bool(state, self.props.lit)
    // rust: {
    // rust: return false;
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: sim.set_block(
    // rust: pos,
    // rust: self.table.set_bool(state, self.props.lit, false),
    // rust: super::flags::UPDATE_ALL_IMMEDIATE,
    // rust: );
    // rust: sim.sound(pos, &"minecraft:block.candle.extinguish".into(), 1.0, 1.0);
    // rust: sim.game_event(pos, "minecraft:block_change");
    // rust: true
}
    // `BlockState.useItemOn` with `item` in the main hand, then, when the
    // block asks to try with an empty hand (the default), `useWithoutItem`.
    // `SweetBerryBushBlock.useItemOn` passes bone meal on a bush that can
    // still grow on to the item.
    // rust: pub fn use_item_on<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: hit: Vec3,
    // rust: player: PlayerContext,
    // rust: item: Option<&str>,
    // rust: ) -> InteractionResult {
    // rust: self.use_item_on_branch(level, ticks, pos, face, hit, player, item)
    // rust: .0
}
    // `use_item_on`, and which of the two answered: `ServerPlayerGameMode.useItemOn`
    // triggers ITEM_USED_ON_BLOCK when `useItemOn` consumes the click and
    // DEFAULT_BLOCK_USE when `useWithoutItem` does.
    // rust: pub fn use_item_on_branch<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: hit: Vec3,
    // rust: player: PlayerContext,
    // rust: item: Option<&str>,
    // rust: ) -> (InteractionResult, UseBranch) {
    // rust: match self.block_use_item_on(level, ticks, pos, face, hit, player, item) {
    // rust: Some(result) => (result, UseBranch::ItemOn),
    // rust: None => (
    // rust: self.use_without_item(level, ticks, pos, face, hit, player),
    // rust: UseBranch::WithoutItem,
    // rust: ),
}
}
    // `BlockState.useItemOn`: the result, or `None` for
    // `TRY_WITH_EMPTY_HAND`.
    // rust: fn block_use_item_on<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: hit: Vec3,
    // rust: player: PlayerContext,
    // rust: item: Option<&str>,
    // rust: ) -> Option<InteractionResult> {
    // rust: let state = level.block_state(pos);
    // rust: if item == Some("minecraft:bone_meal")
    // rust: && self.data(state).chain.contains(&Class::SweetBerryBush)
    // rust: && self.table.int(state, self.props.age) < 3
    // rust: {
    // rust: return Some(InteractionResult::Pass);
}
        // FlowerPotBlock.useItemOn: a plant on an empty flower pot pots it.
        // If the pot is not empty and a plant is held, CONSUME (nothing happens).
        // Otherwise, TRY_WITH_EMPTY_HAND (falls through to use_without_item,
        // which takes the plant out if potted, or CONSUME if empty).
    // rust: if self.data(state).is(Class::FlowerPot) {
    // rust: let is_empty = self
    // rust: .data(state)
    // rust: .link
    // rust: .is_none_or(|c| self.is_air(self.default_of(c)));
    // rust: let potted = item
    // rust: .and_then(|i| self.item_binding(i))
    // rust: .and_then(|b| self.potted_block(b.block));
    // rust: if let Some(potted) = potted {
    // rust: if !is_empty {
    // rust: return Some(InteractionResult::Consume);
}
    // rust: let next = self.default_of(potted);
    // rust: let mut sim = self.sim(level, ticks);
    // rust: sim.set_block_and_update(pos, next);
    // rust: sim.game_event(pos, "minecraft:block_change");
    // rust: return Some(InteractionResult::Success);
}
}
        // CakeBlock.useItemOn: a candle on an uneaten cake turns it into a candle cake.
    // rust: if let Some(candle_cake) = self.cake_candle_state(state, item) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: sim.sound(pos, &"minecraft:block.cake.add_candle".into(), 1.0, 1.0);
    // rust: sim.set_block_and_update(pos, candle_cake);
    // rust: sim.game_event(pos, "minecraft:block_change");
    // rust: return Some(InteractionResult::Success);
}
    // rust: if self.data(state).chain.contains(&Class::CopperGolemStatue) {
    // rust: return Some(self.turn_statue(level, ticks, pos, state, item));
}
        // RespawnAnchorBlock.useItemOn: glowstone (`isRespawnFuel`) charges an
        // anchor below 4 charges (`canBeCharged`) and the click ends there.
    // rust: if item == Some("minecraft:glowstone")
    // rust: && self.data(state).chain.contains(&Class::RespawnAnchor)
    // rust: && self.table.int(state, self.props.charges) < 4
    // rust: {
            // RespawnAnchorBlock.charge.
    // rust: let charges = self.table.int(state, self.props.charges);
    // rust: let next = self.table.set_int(state, self.props.charges, charges + 1);
    // rust: let mut sim = self.sim(level, ticks);
    // rust: sim.set_block_and_update(pos, next);
    // rust: sim.game_event_state(pos, "minecraft:block_change", next);
    // rust: sim.sound(
    // rust: pos,
    // rust: &"minecraft:block.respawn_anchor.charge".into(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: return Some(InteractionResult::Success);
}
        // NoteBlock.useItemOn: a mob head on the top face is placed, not tuned
        // (`#minecraft:noteblock_top_instruments`).
    // rust: if face == Direction::Up
    // rust: && self.data(state).chain.contains(&Class::Note)
    // rust: && item.is_some_and(|i| {
    // rust: matches!(
    // rust: i,
    // rust: "minecraft:zombie_head"
    // rust: | "minecraft:skeleton_skull"
    // rust: | "minecraft:creeper_head"
    // rust: | "minecraft:dragon_head"
    // rust: | "minecraft:wither_skeleton_skull"
    // rust: | "minecraft:piglin_head"
    // rust: | "minecraft:player_head"
    // rust: )
    // rust: })
    // rust: {
    // rust: return Some(InteractionResult::Pass);
}
        // WallHangingSignBlock.useItemOn: a hanging sign aimed at the sign's side
        // (not its editable faces, `isHittingEditableSide`) chains onto it. Sign
        // text has no click commands here, so `canExecuteClickCommands` is false.
    // rust: if self.data(state).is(Class::WallHangingSign)
    // rust: && item
    // rust: .and_then(|i| self.item_binding(i))
    // rust: .is_some_and(|binding| binding.kind == super::data::ItemKind::HangingSign)
    // rust: && face != self.facing(state)
    // rust: && face != self.facing(state).opposite()
    // rust: {
    // rust: return Some(InteractionResult::Pass);
}
        // CandleCakeBlock.useItemOn: flint and steel and fire charges pass, so
        // the item lights a fire by the cake instead of eating it.
    // rust: if self.data(state).chain.contains(&Class::CandleCake)
    // rust: && item
    // rust: .is_some_and(|i| matches!(i, "minecraft:flint_and_steel" | "minecraft:fire_charge"))
    // rust: {
    // rust: return Some(InteractionResult::Pass);
}
        // CandleBlock.useItemOn: an empty hand snuffs a lit candle (`mayBuild`).
        // CandleCakeBlock.useItemOn: the same on the cake's lit candle, when the
        // hit is above half a block (`candleHit`).
    // rust: if item.is_none()
    // rust: && ((self.data(state).chain.contains(&Class::Candle) && player.may_build)
    // rust: || (self.data(state).chain.contains(&Class::CandleCake)
    // rust: && hit.y - f64::from(pos.y) > 0.5))
    // rust: && self.table.bool(state, self.props.lit)
    // rust: && self.extinguish_candle(level, ticks, pos)
    // rust: {
            // AbstractCandleBlock.extinguish's wick smoke is a `level.addParticle`,
            // which only a client draws: the clicking client gets it as an event.
    // rust: let next = self.table.set_bool(state, self.props.lit, false);
    // rust: let mut sim = self.sim(level, ticks);
    // rust: sim.emit(LevelEvent::BlockEvent {
    // rust: pos,
    // rust: state: next,
    // rust: kind: "candle_smoke",
    // rust: });
    // rust: return Some(InteractionResult::Success);
}
    // rust: None
}

    // `CakeBlock.useItemOn`: the unlit candle cake that `item` (a `#minecraft:candles` item)
    // turns the uneaten cake `state` into (`CandleCakeBlock.byCandle`), if any.
    // rust: pub fn cake_candle_state(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: item: Option<&str>,
    // rust: ) -> Option<BlockStateId> {
    // rust: if !self.data(state).chain.contains(&Class::Cake)
    // rust: || self.table.int(state, self.props.bites) != 0
    // rust: {
    // rust: return None;
}
        // Every candle item is `[color_]candle` and its candle cake `[color_]candle_cake`.
    // rust: let candle = item?.strip_suffix("candle")?;
    // rust: let id = self.table.block_by_name(&format!("{candle}candle_cake"))?;
    // rust: Some(self.default_of(id))
}

    // `FlowerPotBlock.useItemOn`: the potted plant block state that `item`
    // turns the empty flower pot `state` into (`POTTED_BY_CONTENT`), if any.
    // rust: pub fn potted_flower_state(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: item: Option<&str>,
    // rust: ) -> Option<BlockStateId> {
    // rust: if !self.data(state).is(Class::FlowerPot) {
    // rust: return None;
}
    // rust: let is_empty = self
    // rust: .data(state)
    // rust: .link
    // rust: .is_none_or(|c| self.is_air(self.default_of(c)));
    // rust: if !is_empty {
    // rust: return None;
}
    // rust: let binding = self.item_binding(item?)?;
    // rust: let potted = self.potted_block(binding.block)?;
    // rust: Some(self.default_of(potted))
}

    // `CopperGolemStatueBlock.useItemOn` (and its weathering subclass's): anything but an axe
    // (`#minecraft:axes`, every one named `*_axe`), even an empty hand, turns the statue to its
    // next pose; honeycomb waxes a statue that still weathers instead.
    // rust: fn turn_statue<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: item: Option<&str>,
    // rust: ) -> InteractionResult {
    // rust: let item = item.unwrap_or("minecraft:air");
    // rust: let waxed = self.table.name(state).starts_with("minecraft:waxed_");
    // rust: if item.ends_with("_axe") || (item == "minecraft:honeycomb" && !waxed) {
    // rust: return InteractionResult::Pass;
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: sim.sound(
    // rust: pos,
    // rust: &"minecraft:entity.copper_golem_become_statue".into(),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: sim.set_block_and_update(pos, self.table.cycle(state, self.props.copper_golem_pose));
    // rust: sim.game_event(pos, "minecraft:block_change");
    // rust: InteractionResult::Success
}
}
