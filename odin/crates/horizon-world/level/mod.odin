//! Transpiled from Horizon Rust crate
package horizon_world_mod

import "core:fmt"
import "core:mem"
import "core:math"

// Server-side vanilla block behaviour: `Level.setBlock` with neighbour and
// shape-update propagation, scheduled block/fluid ticks, random ticks,
// placement (`getStateForPlacement`) and interaction (`useWithoutItem`).
//
// The library is client-agnostic. A game owns its chunk storage and exposes
// it through [`LevelAccess`]; it also owns one [`Ticks`] per level (scheduled
// tick queues, the in-flight neighbour-update queue and the random-tick LCG).
// [`Behaviours`] holds immutable tables loaded once from the pinned client
// resources (`block-behaviours.json`, `gameplay-facts.json`,
// `block-tags.json`, `cached-collision.nbt`; see
// `crates/horizon-prepare`).
//
// # Driving a level
//
// Per server tick, in vanilla order (`ServerLevel.tick`):
// 1. [`Behaviours::tick_scheduled`] runs due block ticks then fluid ticks
//    (`blockTicks.tick(time, 65536, ...)`, then `fluidTicks`).
// 2. For every ticking chunk, [`Behaviours::tick_chunk_random`] performs
//    `ServerLevel.tickChunk`'s random ticks: for each non-empty section,
//    `randomTickSpeed` (game rule, default 3) positions are drawn with
//    `Level.getBlockRandomPos` and randomly-ticking block and fluid states are
//    ticked. The caller says which sections are randomly ticking when each is
//    reached (vanilla counts randomly-ticking states per section);
//    [`Behaviours::random_tick`] ticks a single position.
// 3. [`Behaviours::run_block_events`] runs queued block events (pistons),
//    then (after entities) [`Behaviours::tick_block_entities`] advances
//    moving pistons ([`Ticks::moving_pistons`]).
// 4. Player actions call [`Behaviours::place_block`] /
//    [`Behaviours::use_without_item`] / [`Behaviours::destroy_block`].
//
// Every block mutation goes through [`Behaviours::set_block`] with vanilla's
// update flags ([`flags`]). The library writes storage only through
// [`LevelAccess::set_raw`]; the caller updates heightmaps, light, block
// entities and render meshes for the written position.
//
// Side effects the library cannot perform (sounds, particles, item drops,
// spawning falling-block or TNT entities, growing trees) are reported as
// [`LevelEvent`]s through [`LevelAccess::emit`], in vanilla call order.
//
// Randomness is drawn from [`LevelAccess::random`] (vanilla `level.random`, a
// `LegacyRandomSource`) in the same order as vanilla.
//
// # Integration sketch
//
// ```ignore
// use horizon_world::level::{self, Behaviours, LevelAccess, LevelEvent, PlaceContext, Ticks, flags};
//
// struct GameLevel { chunks: Chunks, random: LegacyRandom, time: i64, events: Vec<LevelEvent> }
// impl LevelAccess for GameLevel {
//     fn block_state(&self, pos: BlockPos) -> BlockStateId { self.chunks.get(pos) }
//     fn set_raw(&mut self, pos: BlockPos, state: BlockStateId) -> Option<BlockStateId> {
//         let old = self.chunks.set(pos, state)?; // also mark light/heightmap/mesh dirty
//         Some(old)
//     }
//     fn is_loaded(&self, pos: BlockPos) -> bool { self.chunks.contains(pos.chunk()) }
//     fn random(&mut self) -> &mut LegacyRandom { &mut self.random }
//     fn game_time(&self) -> i64 { self.time }
//     fn block_light(&self, pos: BlockPos) -> i32 { self.chunks.block_light(pos) }
//     fn sky_light(&self, pos: BlockPos) -> i32 { self.chunks.sky_light(pos) }
//     fn emit(&mut self, event: LevelEvent) { self.events.push(event) }
// }
//
// let registry = level::data::load_registry(&resources)?;
// let behaviours = Behaviours::load(&registry, &resources)?;
// let mut ticks = Ticks::new(seed as i32);
// ticks.add_empty_chunk(chunk_pos)?;          // when a chunk loads (remove_chunk on unload)
//
// // Every server tick:
// level.time += 1;
// behaviours.tick_scheduled(&mut level, &mut ticks);
// for chunk in ticking_chunks {
//     behaviours.tick_chunk_random(&mut level, &mut ticks, chunk, |level, from| level.next_ticking_section(chunk, from));
// }
// behaviours.run_block_events(&mut level, &mut ticks);
// /* tick entities */
// behaviours.tick_block_entities(&mut level, &mut ticks);
// for event in level.events.drain(..) { /* play sounds, spawn drops/falling blocks, grow trees */ }
//
// // Player actions:
// behaviours.place_block(&mut level, &mut ticks, &PlaceContext { clicked_pos, face, hit, inside: false,
//     yaw, pitch, sneaking, item: "minecraft:oak_stairs".into(), can_use_game_master_blocks: false });
// behaviours.use_without_item(&mut level, &mut ticks, pos, face, hit, player_context);
// behaviours.player_destroy_block(&mut level, &mut ticks, pos, creative, correct_tool);
// // Falling-block entity landed:
// behaviours.falling_block_landed(&mut level, &mut ticks, landing_pos, carried_state, false);
// ```
// use crate::{
    // rust: fluid::{FluidBlockBindings, FluidKind, FluidState},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Direction, VoxelShape},
    // rust: position::{BlockPos, ChunkPos},
    // rust: random::LegacyRandom,
}
// use std::{collections::HashMap, io, path::Path, sync::Arc, sync::RwLock};

    // rust: pub mod classes;
    // rust: pub mod data;
    // rust: pub mod states;
    // rust: pub mod ticks;

    // rust: mod bonemeal;
    // rust: mod buckets;
    // rust: mod creaking;
    // rust: mod falling;
    // rust: mod feature_world;
    // rust: mod fluids;
    // rust: mod growth;
    // rust: mod hooks;
    // rust: mod interact;
    // rust: pub mod pistons;
    // rust: mod place;
    // rust: mod portal;
    // rust: pub mod portal_travel;
    // rust: mod query;
    // rust: pub(crate) use query::data_2d;
    // rust: pub mod orientation;
    // rust: mod rails;
    // rust: mod redstone;
    // rust: pub mod removal;
    // rust: pub mod sculk;
    // rust: mod shapes;
    // rust: mod shelf;
    // rust: mod signals;
    // rust: mod speleothem;
    // rust: mod survive;
    // rust: mod tick;
    // rust: mod timeline;
    // rust: mod update;
    // rust: mod weather;

    // rust: mod growth_tests;
    // rust: mod tests;

    // rust: pub use bonemeal::TemplateSettings;
    // rust: pub use buckets::BucketContent;
    // rust: pub use data::{BlockData, ItemBinding, ItemKind, Named, Props, PushReaction, StateFacts, Tags};
    // rust: pub use falling::Landing;
    // rust: pub use interact::{InteractionResult, PlayerContext, PlayerEffect, UseBranch, hit_slot};
    // rust: pub use pistons::{BlockEventData, MovingPiston};
    // rust: pub use place::{PlaceContext, PlaceOutcome, PlacementContext};
    // rust: pub use states::{BlockId, PropKey, StateTable};
    // rust: pub use tick::{Precipitation, PrecipitationKind, RandomTickMask};
    // rust: pub use ticks::Ticks;

// `Block.UPDATE_*` flags accepted by [`Behaviours::set_block`].
    // rust: pub mod flags {
UPDATE_NEIGHBORS :: 1
UPDATE_CLIENTS :: 2
UPDATE_INVISIBLE :: 4
    // Read only by a client's level, which rebuilds the section at once.
UPDATE_IMMEDIATE :: 8
UPDATE_KNOWN_SHAPE :: 16
UPDATE_SUPPRESS_DROPS :: 32
UPDATE_MOVE_BY_PISTON :: 64
UPDATE_SKIP_SHAPE_UPDATE_ON_WIRE :: 128
UPDATE_SKIP_BLOCK_ENTITY_SIDEEFFECTS :: 256
UPDATE_SKIP_ON_PLACE :: 512
UPDATE_NONE :: 260
UPDATE_ALL :: 3
UPDATE_ALL_IMMEDIATE :: 11
UPDATE_SKIP_ALL_SIDEEFFECTS :: 816
    // `Block.UPDATE_LIMIT`, the recursion budget of shape updates.
UPDATE_LIMIT :: 512
}

Dimension :: enum {
    Overworld,
    Nether,
    End,
}

// Game rules consulted by block behaviour (vanilla defaults).
GameRules :: struct {
    water_source_conversion: bool,
    lava_source_conversion: bool,
    random_tick_speed: i32,
    block_drops: bool,
    mob_griefing: bool,
    max_snow_accumulation_height: i32,
    spawn_mobs: bool,
    spawn_monsters: bool,
    // `fire_spread_radius_around_player`: -1 spreads everywhere.
    fire_spread_radius_around_player: i32,
    spread_vines: bool,
}
    // rust: impl Default for GameRules {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: water_source_conversion: true,
    // rust: lava_source_conversion: false,
    // rust: random_tick_speed: 3,
    // rust: block_drops: true,
    // rust: mob_griefing: true,
    // rust: max_snow_accumulation_height: 1,
    // rust: spawn_mobs: true,
    // rust: spawn_monsters: true,
    // rust: fire_spread_radius_around_player: 128,
    // rust: spread_vines: true,
}
}
}

// Entity filters for the entity-sensing blocks (pressure plates, tripwire).
EntityQuery :: enum {
    // Any entity that does not ignore block triggers (wooden plates, tripwire).
    Everything,
    // Living entities only (stone plates).
    Mobs,
    // Minecarts only (detector rails).
    Minecart,
    // Arrows only (`AbstractArrow`, thrown tridents included): the entities
    // a wooden button senses.
    Arrows,
}

// Side effects reported to the caller, in vanilla call order.
LevelEvent :: enum {
    // `Level.levelEvent(type, pos, data)`, using vanilla's numeric event IDs
    // (e.g. 2001 block destroyed with `data` = state ID, 1501 lava
    // extinguished, 1009 fire extinguished, 1502 redstone torch burnout,
    // 2009 dripping water/sponge, 1033/1034 ... per `LevelEvent.java`).
    LevelEvent { id: i32, pos: BlockPos, data: i32 },
    // `Level.playSound(null, pos, sound, BLOCKS, volume, pitch)`.
    Sound {,
    pos: BlockPos,
    sound: Arc<str>,
    volume: f32,
    pitch: f32,
    // rust: },
    // A placed template's container whose data has a `LootTable`
    // (`RandomizableContainer.tryLoadLootTable`): the caller keeps the table
    // and rolls it, as for a container a command gives one.
    ContainerLootTable { pos: BlockPos, tag: crate::nbt::Tag },
    // `Block.dropResources(state, level, pos)`: the caller evaluates the
    // block's loot table (no tool, no breaker) and pops the items.
    DropResources { pos: BlockPos, state: BlockStateId },
    // `FallingBlockEntity.fall`: the block at `pos` was already replaced by its
    // fluid's legacy block; the caller spawns and simulates a falling-block
    // entity carrying `state` and calls [`Behaviours::falling_block_landed`]
    // (or drops the item) when it lands.
    FallingBlock {,
    pos: BlockPos,
    state: BlockStateId,
        // Tip damage configured by `SpeleothemBlock.spawnFallingStalactite`.
    hurt_per_distance: Option<f32>,
    // rust: },
    // A sapling reached stage 1 and tried to grow (`TreeGrower.growTree`).
    // The caller runs the grower's configured feature and, on success,
    // replaces the sapling (vanilla leaves the sapling on failure).
    GrowTree {,
    pos: BlockPos,
    state: BlockStateId,
    grower: Arc<str>,
    // rust: },
    // A configured feature placement request from a bonemealed or random-ticked
    // block (huge mushrooms, fungi). The block was already removed when vanilla
    // does so before placing; on failure the caller restores `state`.
    PlaceFeature {,
    pos: BlockPos,
    state: BlockStateId,
    feature: Arc<str>,
    // rust: },
    // `TntBlock.prime`: spawn primed TNT pushed along `rot` (radians, drawn
    // from the level random by `new PrimedTnt`). The primed sound and game
    // event follow as their own events; the caller removes the block.
    PrimeTnt { pos: BlockPos, rot: f64 },
    // Block-entity or entity side effects the caller implements: `"dispense"`
    // (dispenser/dropper/crafter scheduled tick), `"brushable"` (a suspicious
    // block's scheduled tick: `checkReset`), `"hatch"` (frogspawn
    // hatched into tadpoles; the block is already destroyed), `"portal_spawn"`
    // (a nether portal won its zombified piglin roll; the caller checks
    // `anyPlayerCloseEnoughForSpawning` and spawns below the portal),
    // `"golem"` (a carved pumpkin was placed; the caller builds the golem
    // its blocks complete).
    BlockEvent {,
    pos: BlockPos,
    state: BlockStateId,
    kind: &'static str,
    // rust: },
    // A queued block event that reached a block entity
    // (`BaseEntityBlock.triggerEvent`): the client's copy runs
    // `BlockEntity.triggerEvent(a, b)` (`ClientboundBlockEventPacket`), as
    // for a bell's ring (event 1, the struck direction).
    BlockEntityEvent {,
    pos: BlockPos,
    state: BlockStateId,
    a: i32,
    b: i32,
    // rust: },
    // A player-side effect of [`Behaviours::use_without_item`].
    Player {,
    pos: BlockPos,
    state: BlockStateId,
    effect: PlayerEffect,
    // rust: },
    // `Level.gameEvent` (vibration system), by vanilla identifier, with the
    // affected block state when the event carries one.
    GameEvent {,
    pos: BlockPos,
    event: &'static str,
    state: Option<BlockStateId>,
    // rust: },
}

// What spreads from one block to another (`LevelAccess::allow_spread`).
Spread :: enum {
    // A fluid flows into the block (`FlowingFluid.spreadTo`).
    Fluid,
    // Fire spreads to the block or burns it (`FireBlock.tick`,
    // `checkBurnOut`).
    Fire,
}

// The world as seen by block behaviour. Implemented by the game and tests.
    // rust: pub trait LevelAccess {
    // Whether a hopper may pick up this dropped item stack. The default allows.
allow_hopper_pickup_item :: proc(self: ^Self, _pos: BlockPos, _item: string, _count: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // Whether `kind` may spread from `from` to `to`: a native mod may refuse
    // (land claims), and the block at `to` stays as it is. Fire asks after
    // its random draws, which a refusal doesn't change. The default allows.
allow_spread :: proc(self: ^Self, _kind: Spread, _from: BlockPos, _to: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // rust: fn allow_fluid_level_change(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _fluid: &'static str,
    // rust: _from: i32,
    // rust: _to: i32,
    // rust: ) -> bool {
    // rust: true
}
allow_block_ignite :: proc(self: ^Self, _pos: BlockPos, _cause: ^'static str) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
allow_block_burn :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
allow_leaves_decay :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
allow_moisture_change :: proc(self: ^Self, _pos: BlockPos, _from: i32, _to: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
observe_sponge_absorb :: proc(self: ^Self, _pos: BlockPos) {
}
allow_block_fade :: proc(self: ^Self, _pos: BlockPos, _from: BlockStateId, _to: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
allow_block_form :: proc(self: ^Self, _pos: BlockPos, _from: BlockStateId, _to: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // Returns the new note, or None to cancel tuning.
    // rust: fn note_block_change(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _instrument: &str,
    // rust: _old: i32,
    // rust: new: i32,
    // rust: ) -> Option<i32> {
    // rust: Some(new)
}
allow_note_play :: proc(self: ^Self, _pos: BlockPos, _instrument: string, _note: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
allow_bell_ring :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // rust: fn allow_cauldron_level_change(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _from: i32,
    // rust: _to: i32,
    // rust: _reason: &'static str,
    // rust: ) -> bool {
    // rust: true
}
    // Whether the piston at `piston` may push the blocks `push` one step
    // `direction` and destroy `destroy` (`PistonBaseBlock.moveBlocks`, once
    // the structure resolved). Refused, it moves nothing, as a structure
    // that can't move. The default allows.
    // rust: fn allow_piston_move(
    // rust: &self,
    // rust: _piston: BlockPos,
    // rust: _direction: Direction,
    // rust: _push: &[BlockPos],
    // rust: _destroy: &[BlockPos],
    // rust: ) -> bool {
    // rust: true
}
    // Observe a committed `Level.setBlock` state change, before its side effects.
observe_block_changed :: proc(self: ^Self, _pos: BlockPos, _old: BlockStateId, _new: BlockStateId) {
}
    // Observe `BlockState.handleNeighborChanged` before the block handles it.
    // The default does nothing; implementations must not alter the update queue.
    // rust: fn observe_neighbor_changed(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _changed: BlockId,
    // rust: _moved: bool,
    // rust: ) {
}
    // `BlockState.randomTick` from `ServerLevel.tickChunk`, before the block
    // handles it. The level may change the block (`Behaviours::set_block`
    // with `ticks`); setting `handled` skips the block's own random tick. A
    // level that changed the block without setting `handled` must put the
    // block's state as it is now in `state`: the block's own random tick
    // runs on it. The default does nothing.
    // rust: fn before_random_tick(
    // rust: &mut self,
    // rust: _ticks: &mut Ticks,
    // rust: _pos: BlockPos,
    // rust: _state: &mut BlockStateId,
    // rust: _handled: &mut bool,
    // rust: ) {
}
    // `BlockState.tick` from `ServerLevel.tickBlock` (a due scheduled tick
    // whose block is still there), before the block handles it. The level
    // may change the block (`Behaviours::set_block` with `ticks`); setting
    // `handled` skips the block's own tick. A level that changed the block
    // without setting `handled` must put the block's state as it is now in
    // `state`: the block's own tick runs on it. The default does nothing.
    // rust: fn before_tick_block(
    // rust: &mut self,
    // rust: _ticks: &mut Ticks,
    // rust: _pos: BlockPos,
    // rust: _state: &mut BlockStateId,
    // rust: _handled: &mut bool,
    // rust: ) {
}
    // `BonemealableBlock.isValidBonemealTarget` for the block `state` at
    // `pos`, a block the port knows no `BonemealableBlock` for: a native mod
    // answers it for its own blocks, and bone meal is then used up on one as
    // vanilla uses it up (the caller fires the growth particles and consumes
    // the meal). Asked on both sides, as vanilla asks it on both (a client
    // predicts the use with it), so a mod that can only grow on a server says
    // so with `is_client_side`. `Some(false)` refuses it, even a block whose
    // template takes bone meal; `None` (the default) leaves the block its own
    // `BonemealableBlock`, or none.
is_valid_bonemeal_target :: proc(self: ^Self, _pos: BlockPos, _state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // `BonemealableBlock.isBonemealSuccess` for the block `state` at `pos`,
    // after `is_valid_bonemeal_target` said yes: whether it grows this time.
    // Vanilla draws the level's random here, so a mod's draws through
    // [`LevelAccess::random`] stay in vanilla's order. The default says no.
is_bonemeal_success :: proc(self: ^Self, _pos: BlockPos, _state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `BonemealableBlock.performBonemeal` for the block `state` at `pos`:
    // the growth itself, after `is_bonemeal_success` said yes. The meal is
    // used up either way, as vanilla uses it up. `ticks` schedules the ticks
    // the growth schedules, as `before_update_shape` hands them. The default
    // does nothing.
perform_bonemeal :: proc(self: ^Self, _ticks: ^Ticks, _pos: BlockPos, _state: BlockStateId) {
}
    // `BlockState.updateShape` for `state` at `pos` after its neighbour in
    // `direction` became `neighbour`, before the block computes it. `state`
    // may not be in the level yet (a piston landing it). A state put in
    // `new` is the result, and the block's own `updateShape` doesn't run;
    // the level may schedule ticks through `ticks`, as that would. The
    // default does nothing.
    // rust: fn before_update_shape(
    // rust: &self,
    // rust: _ticks: &mut Ticks,
    // rust: _pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _direction: Direction,
    // rust: _neighbour_pos: BlockPos,
    // rust: _neighbour: BlockStateId,
    // rust: _new: &mut Option<BlockStateId>,
    // rust: ) {
}
    // `Block.getStateForPlacement(BlockPlaceContext)` for the block whose
    // default state is `state`, before the block computes the state it is
    // placed in: a native mod chooses it for its own blocks (a block that
    // faces the player, sits on the clicked face, or comes waterlogged).
    // `context` is vanilla's `BlockPlaceContext`, `fluid` the fluid in the
    // position the block would go in. `answer` starts empty: `Some(Some(s))`
    // places `s`, a state of the block's own, `Some(None)` refuses the
    // placement (vanilla's `null` return: the block goes nowhere and nothing
    // is consumed), and `None` leaves the block's own `getStateForPlacement`
    // to run. The default does nothing.
    // rust: fn before_state_for_placement(
    // rust: &self,
    // rust: _state: BlockStateId,
    // rust: _context: &PlacementContext,
    // rust: _fluid: FluidState,
    // rust: _answer: &mut Option<Option<BlockStateId>>,
    // rust: ) {
}
    // `BlockState.canSurvive(level, pos)` for `state` at `pos`, before the
    // block answers it: placing it (`BlockItem.canPlace`), a plant's or an
    // attached block's shape update, and every other rule that asks. `state`
    // may not be in the level yet (it is being placed). An answer put in
    // `survives` is the result, and the block's own rule doesn't run. The
    // default does nothing.
    // rust: fn before_can_survive(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _survives: &mut Option<bool>,
    // rust: ) {
}
    // `VegetationBlock.mayPlaceOn(ground, level, groundPos)` for the plant
    // `state`, before the plant answers it: the blocks a plant can stand on,
    // which its `canSurvive` asks. An answer put in `may` is the result. The
    // default does nothing.
    // rust: fn before_may_place_on(
    // rust: &self,
    // rust: _state: BlockStateId,
    // rust: _ground: BlockStateId,
    // rust: _ground_pos: BlockPos,
    // rust: _may: &mut Option<bool>,
    // rust: ) {
}
    // `Level.isClientSide`: this level is a client's copy (false on a
    // server, a host or the test harness).
is_client_side :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `FireBlock`'s flammability table for `state`'s block, before the
    // table answers it: `(igniteOdds, burnOdds)`, as `FireBlock.setFlammable`
    // sets them. Fire spread, burning out and where fire can stand read it;
    // a waterlogged state never burns and isn't asked. An answer put in
    // `odds` is the result. The default does nothing.
before_fire_odds :: proc(self: ^Self, _state: BlockStateId, _odds: ^Option<(i32) {
}
    // `CampfireBlock.isSmokeSource(state)` for the block under a campfire,
    // before vanilla's rule (a hay bale) answers it: true makes the campfire
    // a signal fire. An answer put in `smoke` is the result. The default
    // does nothing.
before_smoke_source :: proc(self: ^Self, _state: BlockStateId, _smoke: ^Maybe(bool)) {
}
    // `getBlockState`. Unloaded or out-of-bounds positions read as air.
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // Storage write (`LevelChunkSection.setBlockState`). Returns the previous
    // state, or None when nothing could be stored (unloaded chunk).
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
is_loaded :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // Inclusive minimum and exclusive maximum build height.
min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: -64
}
max_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 320
}
    // `getHeight(WORLD_SURFACE, x, z)`: one above the column's highest
    // block that isn't air. Only air lies above it, so scans for the other
    // heightmaps start there. The default, `max_y`, scans the whole column.
world_surface :: proc(self: ^Self, _x: i32, _z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.max_y()
}
    // Whether the world's enabled features contain `minecraft:redstone_experiments`.
redstone_experiments :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // Vanilla `level.random` (a `LegacyRandomSource`).
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
block_light :: proc(self: ^Self, _pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
sky_light :: proc(self: ^Self, _pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 15
}
    // `Level.getSkyDarken` (0 at noon, up to 11 at night).
sky_darken :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
    // `EnvironmentAttributes.SUN_ANGLE` at `pos`, in degrees (0 at noon).
sun_angle :: proc(self: ^Self, _pos: BlockPos) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 0.0
}
is_raining :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
is_thundering :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
is_raining_at :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
dimension :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: Dimension::Overworld
}
game_rules :: proc(self: ^Self) -> G {
    // Ported from Horizon
    return {}
}
    // rust: GameRules::default()
}
    // `Difficulty.getId()` (peaceful 0 .. hard 3).
difficulty :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 2
}
    // `ServerLevel.canSpreadFireAround` (fire-spread radius around players).
can_spread_fire_around :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // The `INCREASED_FIRE_BURNOUT` environment attribute at `pos` (a biome
    // attribute).
increased_fire_burnout :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `Level.isUnobstructed(state, pos, context)`: whether the state's
    // collision shape at `pos` would intersect an entity.
is_unobstructed :: proc(self: ^Self, _pos: BlockPos, _state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // Comparator input from a block entity (`getAnalogOutputSignal` of
    // containers, jukeboxes, lecterns, ...). State-only sources (cake,
    // composter, cauldrons, beehives, ...) are evaluated by the library.
    // rust: fn block_entity_analog_signal(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _direction: Direction,
    // rust: ) -> i32 {
    // rust: 0
}
    // `ItemFrame.getAnalogOutput` of the one item frame in the block at
    // `pos` that faces `facing` (`ComparatorBlock.getItemFrame`), or None when
    // there is not exactly one.
item_frame_analog_output :: proc(self: ^Self, _pos: BlockPos, _facing: Direction) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // `ContainerOpenersCounter.recheckOpenCount` for the chest or ender chest
    // block entity at `pos`: recounts its openers and returns the previous
    // and new counts (the caller plays open/close effects when they change),
    // or None when there is no such block entity.
recheck_container_openers :: proc(self: ^Self, _pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // `CommandBlockEntity.setPowered` for the command block entity at `pos`:
    // stores `powered` and returns the previous flag and `isAutomatic`, or
    // None when there is no command block entity.
    // rust: fn set_command_block_powered(
    // rust: &mut self,
    // rust: _pos: BlockPos,
    // rust: _powered: bool,
    // rust: ) -> Option<(bool, bool)> {
    // rust: None
}
    // `PotentSulfurBlockEntity.resetCountdown` for the potent sulfur block
    // entity at `pos` (`PotentSulfurBlock.validBlockState`).
reset_potent_sulfur_countdown :: proc(self: ^Self, _pos: BlockPos) {
}
    // `BlockState.isSignalSource` once the library answered `vanilla`: the
    // answer to use. The default keeps it.
adjust_signal_source :: proc(self: ^Self, _state: BlockStateId, vanilla: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: vanilla
}
    // `BlockState.hasAnalogOutputSignal` once the library answered `vanilla`:
    // whether comparators read the block. The default keeps it.
adjust_has_analog_output :: proc(self: ^Self, _state: BlockStateId, vanilla: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: vanilla
}
    // `BlockState.getAnalogOutputSignal(level, pos, direction)` once the
    // library answered `vanilla`, `direction` pointing from the block to the
    // comparator reading it: the output to use. The default keeps it.
    // rust: fn adjust_analog_output(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _direction: Direction,
    // rust: vanilla: i32,
    // rust: ) -> i32 {
    // rust: vanilla
}
    // `BlockState.getSignal` (or `getDirectSignal` when `direct`) once the
    // library answered `vanilla`: the signal to use. The default keeps it.
    // rust: fn adjust_signal(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _direction: Direction,
    // rust: _direct: bool,
    // rust: vanilla: i32,
    // rust: ) -> i32 {
    // rust: vanilla
}
    // Weak/strong signal of a block-entity-driven source (trapped chest
    // openers); other sources are evaluated by the library.
    // rust: fn block_entity_signal(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _direction: Direction,
    // rust: ) -> i32 {
    // rust: 0
}
    // Biome answers for a precipitation tick at the column of `pos` (see
    // [`Precipitation`]); None skips snow/ice formation and cauldron filling.
precipitation :: proc(self: ^Self, _pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // Count of entities intersecting `area` that trigger pressure plates or
    // tripwires under `query`.
count_entities :: proc(self: ^Self, _area: Aabb, _query: EntityQuery) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
    // `ServerLevel.isPositionTickingWithEntitiesLoaded` for scheduled ticks.
is_ticking_chunk :: proc(self: ^Self, _chunk: ChunkPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
emit :: proc(self: ^Self, _event: LevelEvent) {
}
    // `LevelChunk.setBlockState` replaced a block that had a block entity by
    // another block: run `BlockEntity.preRemoveSideEffects` when
    // `side_effects` (containers spill their contents, a jukebox pops its
    // record, a lectern its book...) and remove the block entity. Called
    // after the storage write, before `affectNeighborsAfterRemoval`. Returns
    // how many times the side effects called `updateNeighborsAt(pos, block)`
    // (a jukebox whose song changed), which the caller then runs.
    // rust: fn remove_block_entity(
    // rust: &mut self,
    // rust: _pos: BlockPos,
    // rust: _old: BlockStateId,
    // rust: _side_effects: bool,
    // rust: ) -> u8 {
    // rust: 0
}
    // Whether a block entity a mod made lives at `pos` (`native_block_entity`),
    // whatever its block's template: it is removed with its block and no piston
    // moves it, as for a template that has one.
has_mod_block_entity :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // `ShulkerBoxBlockEntity.isClosed` at `pos`: whether the box's lid is
    // still shut. None when no shulker box block entity lives there, or the
    // level keeps none: vanilla then reads the box as closed, a full cube.
shulker_is_closed :: proc(self: ^Self, _pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // Load saved block-entity data into the block entity of the block just
    // placed at `pos` (`BlockEntity.loadWithComponents`): a bee nest a grown
    // tree placed gets its bees. Levels without block entities drop it.
load_block_entity :: proc(self: ^Self, _pos: BlockPos, _nbt: crate::nbt::Compound) {
}
    // Biome identifier at `pos` (`minecraft:plains`), for features placed by
    // block behaviour (bone meal flowers). None when unknown.
biome_name :: proc(self: ^Self, _pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
    // World seed (`WorldGenLevel.getSeed`) for seed-derived feature noise.
world_seed :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 0
}
    // `Level.getDayTime` (the overworld clock driving the day timeline's
    // environment attributes, e.g. eyeblossoms opening at night).
day_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: 6000
}
}

// Raw brightness as `Level.getRawBrightness(pos, skyDarken)`.
    // rust: pub fn raw_brightness<L: LevelAccess + ?Sized>(level: &L, pos: BlockPos, sky_darken: i32) -> i32 {
    // rust: (level.sky_light(pos) - sky_darken).max(level.block_light(pos))
}

// Access only the gameplay fields needed by level behaviour tables.
// Both the JSON fallback and the client's typed decoder implement this.
    // rust: pub trait GameplayStateSource {
flag :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
unsigned :: proc(self: ^Self, name: string) -> u {
    // Ported from Horizon
    return {}
}
number :: proc(self: ^Self, name: string) -> f {
    // Ported from Horizon
    return {}
}
text :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
sound_number :: proc(self: ^Self, name: string) -> f {
    // Ported from Horizon
    return {}
}
sound_id :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
}

// Immutable vanilla block-behaviour tables. Build once with [`Behaviours::load`].
Behaviours :: struct {
    table: StateTable,
    props: Props,
    named: Named,
    tags: Tags,
    all_tags: HashMap<string,
    facts: [dynamic]StateFacts,
    shapes: [dynamic]VoxelShape,
    shape_info: [dynamic]data::ShapeInfo,
    fluid_tags: data::FluidTags,
    blocks: [dynamic]BlockData,
    items: HashMap<string,
    potted_by_content: HashMap<BlockId,
    liquid_blocks: FluidBlockBindings,
    // Uncached (position- or block-entity-dependent) collision shapes.
    dynamic: HashMap<BlockStateId,
    occlusion_cache: RwLock<HashMap<(i32,
    growth: growth::Growth,
}

    // rust: impl Behaviours {
    // Load from a prepared client resource directory (`.local/horizon-client/<version>`).
load :: proc(registry: ^BlockRegistry, resources_dir: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: data::load(registry, resources_dir)
}
    // Reuse the client's typed gameplay projection while it is borrowed from the JSON bytes.
    // rust: pub fn load_with_gameplay<G: GameplayStateSource>(
    // rust: registry: &BlockRegistry,
    // rust: resources_dir: &Path,
    // rust: behaviour: &serde_json::Value,
    // rust: gameplay: &[G],
    // rust: ) -> io::Result<Self> {
    // rust: data::load_with_gameplay(registry, resources_dir, behaviour, gameplay)
}

    // rust: pub fn load_with_behaviour_json(
    // rust: registry: &BlockRegistry,
    // rust: resources_dir: &Path,
    // rust: behaviour: &serde_json::Value,
    // rust: ) -> io::Result<Self> {
    // rust: data::load_with_behaviour_json(registry, resources_dir, behaviour)
}

    // Keep snapshots of the resolved tables and the block-state registry in
    // `dir` (a game folder's `.horizon-cache`), so later launches of the same
    // build restore them instead of resolving the resources again. Without
    // it, [`Self::load`] and `data::load_registry` never cache.
set_cache_dir :: proc(dir: std::path::PathBuf) {
}
    // rust: data::set_cache_dir(dir);
}
facts :: proc(self: ^Self, state: BlockStateId) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.facts[state.0 as usize]
}
block_data :: proc(self: ^Self, block: BlockId) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.blocks[block.0 as usize]
}
data :: proc(self: ^Self, state: BlockStateId) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.block_data(self.table.block(state))
}
block :: proc(self: ^Self, state: BlockStateId) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.table.block(state)
}
item_binding :: proc(self: ^Self, item: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.items.get(item)
}
    // FlowerPotBlock.POTTED_BY_CONTENT: the potted flower pot block that
    // holds plant, if any.
potted_block :: proc(self: ^Self, plant: BlockId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.potted_by_content.get(&plant).copied()
}
tag :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.all_tags.get(name).map(|s| &**s)
}
fluid :: proc(self: ^Self, state: BlockStateId) -> F {
    // Ported from Horizon
    return {}
}
    // rust: self.facts(state).fluid
}
    // `FluidState.createLegacyBlock`.
legacy_block :: proc(self: ^Self, fluid: FluidState) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.liquid_blocks.block(fluid)
}
    // Cached collision shape (`getCollisionShape(level, pos)` for states whose
    // shape does not depend on the world); None for dynamic shapes.
collision_shape :: proc(self: ^Self, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let index = self.facts(state).shape;
    // rust: (index >= 0).then(|| &self.shapes[index as usize])
}
    // Precomputed shape queries; dynamic shapes read as empty.
shape_info :: proc(self: ^Self, state: BlockStateId) -> d {
    // Ported from Horizon
    return {}
}
    // rust: let index = self.facts(state).shape;
    // rust: if index < 0 {
    // rust: data::ShapeInfo::default()
    // rust: } else {
    // rust: self.shape_info[index as usize]
}
}
    // rust: pub(crate) fn has_flag(&self, state: BlockStateId, flag: u32) -> bool {
    // rust: self.facts(state).flags & flag != 0
}
is_air :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.has_flag(state, data::state_flags::AIR)
}
is_solid :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.has_flag(state, data::state_flags::SOLID)
}
is_replaceable :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.has_flag(state, data::state_flags::REPLACEABLE)
}
is_randomly_ticking :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.has_flag(state, data::state_flags::RANDOM_TICKS)
}
    // `isFaceSturdy(level, pos, direction, FULL)` from the empty-level cache.
is_face_sturdy :: proc(self: ^Self, state: BlockStateId, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.facts(state).sturdy & (1 << direction as u32) != 0
}
is_face_sturdy_center :: proc(self: ^Self, state: BlockStateId, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.facts(state).sturdy & (1 << (6 + direction as u32)) != 0
}
is_face_sturdy_rigid :: proc(self: ^Self, state: BlockStateId, direction: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.facts(state).sturdy & (1 << (12 + direction as u32)) != 0
}
    // Tick type ID of a fluid for [`Ticks::schedule_fluid`].
fluid_kind :: proc(self: ^Self, state: BlockStateId) -> F {
    // Ported from Horizon
    return {}
}
    // rust: self.fluid(state).kind()
}
}

// Level mutation entry points (all keep vanilla update semantics).
    // rust: impl Behaviours {
    // `Level.setBlock(pos, state, flags)` with vanilla's update limit (512).
    // Returns false when nothing was written (unloaded, out of bounds, or
    // the state was already present).
    // rust: pub fn set_block<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: flags: i32,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).set_block(pos, state, flags)
}
    // `CopperChestBlock.getFromCopperBlock(copperBlock, facing, level, pos)`.
    // rust: pub fn copper_chest_from_block<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: copper: BlockStateId,
    // rust: facing: Direction,
    // rust: pos: BlockPos,
    // rust: ) -> Option<BlockStateId> {
    // rust: self.sim(level, ticks)
    // rust: .copper_chest_from_block(copper, facing, pos)
}
    // `Level.removeBlock(pos, movedByPiston)`: replace with the fluid's block.
    // rust: pub fn remove_block<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: moved_by_piston: bool,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).remove_block(pos, moved_by_piston)
}
    // `Level.destroyBlock(pos, dropResources)`: destroy particles (2001),
    // optional drops, and replacement by the block's fluid.
    // rust: pub fn destroy_block<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: drop: bool,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks)
    // rust: .destroy_block(pos, drop, flags::UPDATE_LIMIT)
}
    // A player breaking a block (`playerWillDestroy` + `Level.destroyBlock`
    // without drops; the caller handles the player's loot/tool). Double
    // blocks (doors, tall plants, beds) remove their other half as vanilla.
    // rust: pub fn player_destroy_block<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: creative: bool,
    // rust: correct_tool: bool,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks)
    // rust: .player_destroy(pos, creative, correct_tool)
}
    // `IceBlock.playerDestroy` after the drops: mined ice melts into water
    // unless the tool prevents ice melting (silk touch). `destroyed` is the
    // state that was broken.
    // rust: pub fn ice_destroyed_by_player<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: destroyed: BlockStateId,
    // rust: prevents_melting: bool,
    // rust: ) {
    // rust: self.sim(level, ticks)
    // rust: .ice_destroyed_by_player(pos, destroyed, prevents_melting);
}
    // `TurtleEggBlock.playerDestroy` after the drops: a mined stack of eggs
    // loses one egg and the rest stay. `destroyed` is the state that was broken.
    // rust: pub fn turtle_egg_destroyed_by_player<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: destroyed: BlockStateId,
    // rust: ) {
    // rust: self.sim(level, ticks)
    // rust: .turtle_egg_destroyed_by_player(pos, destroyed);
}
    // `BaseFireBlock.getState(level, pos)`: soul fire on its base blocks,
    // otherwise fire shaped by its neighbours.
    // rust: pub fn fire_state_for<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> BlockStateId {
    // rust: self.sim(level, ticks).fire_state_for(pos)
}
    // `BaseFireBlock.canBePlacedAt(level, pos, forwardDirection)`.
    // rust: pub fn fire_can_be_placed_at<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: forward: horizon_core::geometry::Direction,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).fire_can_be_placed_at(pos, forward)
}
    // `BlockState.canSurvive(level, pos)`.
    // rust: pub fn can_survive<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).can_survive(state, pos)
}
    // `BlockState.updateShape(level, ticks, pos, direction, neighbourPos,
    // neighbourState, random)`: the state `state` at `pos` would take after its
    // neighbour in `direction` became `neighbour` (ticks it requests are queued).
    // rust: pub fn update_shape<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: state: BlockStateId,
    // rust: pos: BlockPos,
    // rust: direction: Direction,
    // rust: neighbour_pos: BlockPos,
    // rust: neighbour: BlockStateId,
    // rust: ) -> BlockStateId {
    // rust: self.sim(level, ticks)
    // rust: .update_shape(state, pos, direction, neighbour_pos, neighbour)
}
    // `Block.updateFromNeighbourShapes`: a state adjusted to its neighbours.
    // rust: pub fn update_from_neighbour_shapes<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) -> BlockStateId {
    // rust: self.sim(level, ticks)
    // rust: .update_from_neighbour_shapes(state, pos)
}
    // `Level.updateNeighborsAt(pos, block)`: notify the six neighbours.
    // rust: pub fn update_neighbors_at<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: block: BlockId,
    // rust: ) {
    // rust: self.sim(level, ticks).update_neighbors_at(pos, block);
}
    // `LecternBlock.updateBelow` after a page or book changes.
    // rust: pub fn lectern_update_below<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) {
    // rust: self.sim(level, ticks).lectern_update_below(pos, state);
}
    // `TrappedChestBlockEntity.signalOpenCount` after its opener count changes.
    // rust: pub fn trapped_chest_update_neighbors<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) {
    // rust: self.sim(level, ticks)
    // rust: .trapped_chest_update_neighbors(pos, state);
}
    // `LightningRodBlock.updateNeighbours` after a strike.
    // rust: pub fn lightning_rod_update_neighbors<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: ) {
    // rust: self.sim(level, ticks)
    // rust: .lightning_rod_update_neighbors(pos, state);
}
    // `Level.updateNeighbourForOutputSignal(pos, block)` for the block at
    // `pos`: comparators beside it (or behind a conductor there) read their
    // input again.
    // rust: pub fn update_neighbour_for_output_signal<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let block = self.block(sim.state(pos));
    // rust: sim.update_neighbour_for_output_signal(pos, block);
}
    // `Level.scheduleTick(pos, block, delay)` for the block at `pos`.
    // rust: pub fn schedule_tick<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: delay: i32,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let block = self.block(sim.state(pos));
    // rust: sim.schedule_tick(pos, block, delay);
}
    // `BlockState.handleNeighborChanged(level, pos, changedBlock, orientation, movedByPiston)`
    // for the state currently at `pos`.
    // rust: pub fn handle_neighbor_changed<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: changed: BlockId,
    // rust: ) {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: sim.neighbor_changed(state, pos, changed, false);
}
    // Entity collision with a block (`entityInside`) for the entity-sensing
    // blocks: pressure plates, tripwires and buttons hit by arrows are
    // re-evaluated through [`LevelAccess::count_entities`].
    // rust: pub fn entity_inside<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: self.sim(level, ticks).entity_inside(pos);
}
    // Whether [`Self::entity_inside`] may do anything at a block of `state`:
    // the entity-sensing blocks' classes it looks for. At any other block it
    // only reads the state.
senses_entities :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let data = self.data(state);
    // rust: data.is(classes::Class::BasePressurePlate)
    // rust: || data.is(classes::Class::DetectorRail)
    // rust: || data.is(classes::Class::Button)
    // rust: || data.is(classes::Class::TripWire)
}
    // `LilyPadBlock.entityInside` for a boat whose box is inside `pos`.
    // rust: pub fn boat_inside<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: self.sim(level, ticks).boat_inside(pos);
}
    // `DaylightDetectorBlock.tickEntity` of the daylight detector at `pos`:
    // its signal follows the sky every 20 game ticks. The detector's ticker
    // exists only where the dimension has sky light.
    // rust: pub fn tick_daylight_detector<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) {
    // rust: if level.dimension() == Dimension::Nether || level.game_time() % 20 != 0 {
    // rust: return;
}
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: if sim.b.data(state).is(classes::Class::DaylightDetector) {
    // rust: sim.daylight_detector_update_signal(pos, state);
}
}
    // `BigDripleafBlock.entityInside` for an entity whose box is inside
    // `pos`: whether it is on the ground and its feet's y (`canEntityTilt`).
    // rust: pub fn entity_on_big_dripleaf<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: on_ground: bool,
    // rust: feet_y: f64,
    // rust: ) {
    // rust: self.sim(level, ticks)
    // rust: .big_dripleaf_entity_inside(pos, on_ground, feet_y);
}
    // `BigDripleafBlock.onProjectileHit`: true when a projectile hit a leaf.
    // Unlike entityInside, this tilts powered leaves too.
    // rust: pub fn big_dripleaf_projectile_hit<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).big_dripleaf_projectile_hit(pos)
}
    // `BellBlock.onProjectileHit` for a projectile that hit `face` of the
    // block at `pos` at height `hit_y`. False when the block is not a bell
    // or the hit missed the bell proper.
    // rust: pub fn bell_projectile_hit<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: face: Direction,
    // rust: hit_y: f64,
    // rust: ) -> bool {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: self.data(state).is(classes::Class::Bell)
    // rust: && sim.bell_hit(pos, state, face, hit_y - f64::from(pos.y))
}
    // `BellBlock.attemptToRing(entity, level, pos, null)`: a mob rings the
    // bell from its facing. False when the block at `pos` is not a bell.
    // rust: pub fn bell_attempt_to_ring<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> bool {
    // rust: let mut sim = self.sim(level, ticks);
    // rust: let state = sim.state(pos);
    // rust: if !self.data(state).is(classes::Class::Bell) {
    // rust: return false;
}
    // rust: let facing = sim.b.facing(state);
    // rust: sim.bell_ring(pos, state, facing);
    // rust: true
}
    // Redstone signal queries (`SignalGetter`).
    // rust: pub fn has_neighbor_signal<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> bool {
    // rust: self.sim(level, ticks).has_neighbor_signal(pos)
}
    // rust: pub fn best_neighbor_signal<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: ) -> i32 {
    // rust: self.sim(level, ticks).best_neighbor_signal(pos)
}
    // `BlockState.onProjectileHit` of a target block (`TargetBlock`) hit by
    // a projectile at `location` on the face with normal `face`; `arrow`
    // for an `AbstractArrow`. Returns the output strength, or None when the
    // block at `pos` is not a target block.
    // rust: pub fn target_projectile_hit<L: LevelAccess + ?Sized>(
    // rust: &self,
    // rust: level: &mut L,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: location: [f64; 3],
    // rust: face: [i32; 3],
    // rust: arrow: bool,
    // rust: ) -> Option<i32> {
    // rust: self.sim(level, ticks)
    // rust: .target_projectile_hit(pos, location, face, arrow)
}
}

// One mutable view used by the ported behaviour code.
    // rust: pub(crate) struct Sim<'a, L: LevelAccess + ?Sized> {
    // rust: pub b: &'a Behaviours,
    // rust: pub level: &'a mut L,
    // rust: pub ticks: &'a mut Ticks,
    // `RedstoneWireBlock.shouldSignal` is false while a wire samples its
    // neighbours (`getBlockSignal`).
    // rust: pub wire_signal_off: std::cell::Cell<bool>,
}
    // rust: impl Behaviours {
    // rust: pub(crate) fn sim<'a, L: LevelAccess + ?Sized>(
    // rust: &'a self,
    // rust: level: &'a mut L,
    // rust: ticks: &'a mut Ticks,
    // rust: ) -> Sim<'a, L> {
    // rust: Sim {
    // rust: b: self,
    // rust: level,
    // rust: ticks,
    // rust: wire_signal_off: std::cell::Cell::new(false),
}
}
}
