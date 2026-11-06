//! Transpiled from Horizon Rust crate
package horizon_world_tests

import "core:fmt"
import "core:mem"
import "core:math"

// Behaviour tests over an in-memory level. They need the prepared client
// resources (`HORIZON_RESOURCES`, or `.local/horizon-client/<version>` at the
// repository root) and are skipped when those are absent.
// use super::*;
// use crate::chunk::BlockState;
// use horizon_core::random::RandomSource;
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: path::PathBuf,
    // rust: sync::OnceLock,
}

Fixture :: struct {
    registry: BlockRegistry,
    behaviours: Behaviours,
}

fixture :: proc() -> O {
    // Ported from Horizon
    return {}
}
FIXTURE :: OnceLock::new()
    // rust: FIXTURE
    // rust: .get_or_init(|| {
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: if !root.join("block-behaviours.json").exists() {
    // rust: eprintln!("skipping level tests: no resources at {}", root.display());
    // rust: return None;
}
    // rust: let registry = data::load_registry(&root).expect("registry");
    // rust: let behaviours = Behaviours::load(&registry, &root).expect("behaviours");
    // rust: Some(Fixture {
    // rust: registry,
    // rust: behaviours,
    // rust: })
    // rust: })
    // rust: .as_ref()
}

    // rust: pub(crate) struct TestLevel {
    // rust: blocks: HashMap<BlockPos, BlockStateId>,
    // rust: air: BlockStateId,
    // rust: random: LegacyRandom,
    // rust: pub time: i64,
    // rust: pub day_time: i64,
    // rust: pub events: Vec<LevelEvent>,
    // rust: pub block_light: HashMap<BlockPos, i32>,
    // `Level.isClientSide`.
    // rust: pub client_side: bool,
    // Positions that refuse fluids, fire and piston moves, as a land claim would.
    // rust: pub guarded: HashSet<BlockPos>,
    // What `adjust_signal` answers at a position: the weak and direct signal,
    // and the only direction they go in, if any.
    // rust: pub signals: HashMap<BlockPos, (i32, i32, Option<Direction>)>,
    // What `adjust_analog_output` answers at a position, for the states in
    // `analog_states` (`adjust_has_analog_output`).
    // rust: pub analog: HashMap<BlockPos, i32>,
    // rust: pub analog_states: HashSet<BlockStateId>,
    // What `before_fire_odds` answers for a state.
    // rust: pub fire_odds: HashMap<BlockStateId, (i32, i32)>,
    // What `before_smoke_source` answers for a state.
    // rust: pub smoke_sources: HashMap<BlockStateId, bool>,
    // What `recheck_container_openers` answers at a position: the opener
    // count before and after the recount.
    // rust: pub openers: HashMap<BlockPos, (i32, i32)>,
    // Every position whose container openers were recounted, in order.
    // rust: pub opener_rechecks: Vec<BlockPos>,
    // `ShulkerBoxBlockEntity.isClosed` at a position: `true` for a shut lid,
    // `false` for an open box. Positions not listed have no block entity.
    // rust: pub shulker_closed: HashMap<BlockPos, bool>,
}
    // rust: impl TestLevel {
new :: proc(b: ^Behaviours) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: blocks: HashMap::new(),
    // rust: air: b.air(),
    // rust: random: LegacyRandom::new(42),
    // rust: signals: HashMap::new(),
    // rust: analog: HashMap::new(),
    // rust: analog_states: HashSet::new(),
    // rust: time: 0,
    // rust: day_time: 0,
    // rust: events: Vec::new(),
    // rust: block_light: HashMap::new(),
    // rust: client_side: false,
    // rust: guarded: HashSet::new(),
    // rust: fire_odds: HashMap::new(),
    // rust: smoke_sources: HashMap::new(),
    // rust: openers: HashMap::new(),
    // rust: opener_rechecks: Vec::new(),
    // rust: shulker_closed: HashMap::new(),
}
}
}
    // rust: impl LevelAccess for TestLevel {
recheck_container_openers :: proc(self: ^Self, pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.opener_rechecks.push(pos);
    // rust: self.openers.get(&pos).copied()
}
shulker_is_closed :: proc(self: ^Self, pos: BlockPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.shulker_closed.get(&pos).copied()
}
adjust_has_analog_output :: proc(self: ^Self, state: BlockStateId, vanilla: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: vanilla || self.analog_states.contains(&state)
}
    // rust: fn adjust_analog_output(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _direction: Direction,
    // rust: vanilla: i32,
    // rust: ) -> i32 {
    // rust: self.analog.get(&pos).copied().unwrap_or(vanilla)
}
    // rust: fn adjust_signal(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: direction: Direction,
    // rust: direct: bool,
    // rust: vanilla: i32,
    // rust: ) -> i32 {
    // rust: match self.signals.get(&pos) {
    // rust: Some((_, _, Some(only))) if *only != direction => 0,
    // rust: Some((weak, strong, _)) => {
    // rust: if direct {
    // rust: *strong
    // rust: } else {
    // rust: *weak
}
}
    // rust: None => vanilla,
}
}
is_client_side :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.client_side
}
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.get(&pos).copied().unwrap_or(self.air)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.blocks.insert(pos, state).unwrap_or(self.air))
}
is_loaded :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.random
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.time
}
day_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.day_time
}
block_light :: proc(self: ^Self, pos: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.block_light.get(&pos).copied().unwrap_or(0)
}
emit :: proc(self: ^Self, event: LevelEvent) {
}
    // rust: self.events.push(event);
}
allow_spread :: proc(self: ^Self, _kind: Spread, _from: BlockPos, to: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.guarded.contains(&to)
}
    // rust: fn allow_piston_move(
    // rust: &self,
    // rust: _piston: BlockPos,
    // rust: direction: Direction,
    // rust: push: &[BlockPos],
    // rust: destroy: &[BlockPos],
    // rust: ) -> bool {
    // rust: !push
    // rust: .iter()
    // rust: .flat_map(|&p| [p, update::rel(p, direction)])
    // rust: .chain(destroy.iter().copied())
    // rust: .any(|p| self.guarded.contains(&p))
}
before_fire_odds :: proc(self: ^Self, state: BlockStateId, odds: ^Option<(i32) {
}
    // rust: if let Some(&answer) = self.fire_odds.get(&state) {
    // rust: *odds = Some(answer);
}
}
before_smoke_source :: proc(self: ^Self, state: BlockStateId, smoke: ^Maybe(bool)) {
}
    // rust: if let Some(&answer) = self.smoke_sources.get(&state) {
    // rust: *smoke = Some(answer);
}
}
}

World :: struct {
    f: ^'f Fixture,
    level: TestLevel,
    ticks: Ticks,
}
    // rust: impl<'f> World<'f> {
new :: proc(f: ^'f Fixture) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: for x in -4..4 {
    // rust: for z in -4..4 {
    // rust: ticks.add_empty_chunk(ChunkPos::new(x, z)).unwrap();
}
}
    // rust: Self {
    // rust: level: TestLevel::new(&f.behaviours),
    // rust: f,
    // rust: ticks,
}
}
b :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.f.behaviours
}
id :: proc(self: ^Self, name: string, props: ^[(string) {
}
    // rust: let state = BlockState {
    // rust: name: format!("minecraft:{name}"),
    // rust: properties: props
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect(),
}
    // rust: self.f
    // rust: .registry
    // rust: .resolve(&state)
    // rust: .unwrap_or_else(|_| panic!("unknown state {name} {props:?}"))
}
set :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.f.behaviours.set_block(
    // rust: &mut self.level,
    // rust: &mut self.ticks,
    // rust: pos,
    // rust: state,
    // rust: flags::UPDATE_ALL,
    // rust: )
}
    // Raw storage write without updates (world generation).
put :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) {
}
    // rust: self.level.blocks.insert(pos, state);
}
get :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.level.block_state(pos)
}
name :: proc(self: ^Self, pos: BlockPos) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.f.registry.state(self.get(pos)).unwrap();
    // rust: let props: Vec<String> = state
    // rust: .properties
    // rust: .iter()
    // rust: .map(|(k, v)| format!("{k}={v}"))
    // rust: .collect();
    // rust: format!(
    // rust: "{}[{}]",
    // rust: state.name.trim_start_matches("minecraft:"),
    // rust: props.join(",")
    // rust: )
}
prop :: proc(self: ^Self, pos: BlockPos, key: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.f
    // rust: .registry
    // rust: .state(self.get(pos))
    // rust: .unwrap()
    // rust: .properties
    // rust: .get(key)
    // rust: .cloned()
    // rust: .unwrap_or_default()
}
tick :: proc(self: ^Self) {
}
    // rust: self.level.time += 1;
    // rust: self.f
    // rust: .behaviours
    // rust: .tick_scheduled(&mut self.level, &mut self.ticks);
}
    // Scheduled ticks, block events and block entities, as `ServerLevel.tick`.
full_tick :: proc(self: ^Self) {
}
    // rust: self.tick();
    // rust: self.f
    // rust: .behaviours
    // rust: .run_block_events(&mut self.level, &mut self.ticks);
    // rust: self.f
    // rust: .behaviours
    // rust: .tick_block_entities(&mut self.level, &mut self.ticks);
}
floor :: proc(self: ^Self, y: i32, radius: i32, block: string) {
}
    // rust: let state = self.id(block, &[]);
    // rust: for x in -radius..=radius {
    // rust: for z in -radius..=radius {
    // rust: self.put(BlockPos::new(x, y, z), state);
}
}
}
}

    // rust: macro_rules! world {
    // rust: () => {{
    // rust: let Some(f) = fixture() else {
    // rust: return;
}
    // rust: World::new(f)
    // rust: }};
}

block_observation_follows_successful_commits_only :: proc() {
}
//     use std::cell::RefCell;

Observation :: enum {
    Block(BlockPos, BlockStateId, BlockStateId),
    Neighbor,
}
Observer :: struct {
    inner: TestLevel,
    loaded: bool,
    seen: RefCell<[dynamic]Observation>,
}
    // rust: impl LevelAccess for Observer {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.block_state(pos)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.set_raw(pos, state)
}
is_loaded :: proc(self: ^Self, _pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.loaded
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.random()
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.game_time()
}
observe_block_changed :: proc(self: ^Self, pos: BlockPos, old: BlockStateId, new: BlockStateId) {
}
    // rust: assert_eq!(self.block_state(pos), new);
    // rust: self.seen
    // rust: .borrow_mut()
    // rust: .push(Observation::Block(pos, old, new));
}
observe_neighbor_changed :: proc(self: ^Self, _: BlockPos, _: BlockStateId, _: BlockId, _: bool) {
}
    // rust: self.seen.borrow_mut().push(Observation::Neighbor);
}
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let b = &f.behaviours;
    // rust: let mut level = Observer {
    // rust: inner: TestLevel::new(b),
    // rust: loaded: true,
    // rust: seen: RefCell::new(Vec::new()),
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: let pos = BlockPos::new(0, 80, 0);
    // rust: let stone = f.registry.default_state("minecraft:stone").unwrap();
    // rust: assert!(b.set_block(&mut level, &mut ticks, pos, stone, flags::UPDATE_ALL));
    // rust: let seen = level.seen.borrow();
    // rust: assert_eq!(seen[0], Observation::Block(pos, b.air(), stone));
    // rust: assert!(seen[1..].contains(&Observation::Neighbor));
    // rust: drop(seen);
    // rust: level.seen.borrow_mut().clear();
    // rust: assert!(!b.set_block(&mut level, &mut ticks, pos, stone, flags::UPDATE_ALL));
    // rust: level.loaded = false;
    // rust: assert!(!b.set_block(&mut level, &mut ticks, pos, b.air(), flags::UPDATE_ALL));
    // rust: level.loaded = true;
    // rust: assert!(!b.set_block(
    // rust: &mut level,
    // rust: &mut ticks,
    // rust: BlockPos::new(0, 320, 0),
    // rust: stone,
    // rust: flags::UPDATE_ALL
    // rust: ));
    // rust: assert!(level.seen.borrow().is_empty());
    // rust: assert!(b.set_block(&mut level, &mut ticks, pos, b.air(), flags::UPDATE_ALL));
    // rust: assert_eq!(
    // rust: level.seen.borrow()[0],
    // rust: Observation::Block(pos, stone, b.air())
    // rust: );
}

neighbor_observation_follows_dispatch_order :: proc() {
}
//     use std::cell::RefCell;

Observer :: struct {
    inner: TestLevel,
    seen: RefCell<Vec<(BlockPos,
}
    // rust: impl LevelAccess for Observer {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.block_state(pos)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.set_raw(pos, state)
}
is_loaded :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.is_loaded(pos)
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.random()
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.game_time()
}
    // rust: fn observe_neighbor_changed(
    // rust: &self,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: changed: BlockId,
    // rust: moved: bool,
    // rust: ) {
    // rust: assert_eq!(self.block_state(pos), state);
    // rust: self.seen.borrow_mut().push((pos, state, changed, moved));
}
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let b = &f.behaviours;
    // rust: let mut level = Observer {
    // rust: inner: TestLevel::new(b),
    // rust: seen: RefCell::new(Vec::new()),
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: let changed = b.table.block_by_name("minecraft:stone").unwrap();
    // rust: b.update_neighbors_at(&mut level, &mut ticks, BlockPos::new(0, 0, 0), changed);
    // rust: let expected = [
    // rust: (-1, 0, 0),
    // rust: (1, 0, 0),
    // rust: (0, -1, 0),
    // rust: (0, 1, 0),
    // rust: (0, 0, -1),
    // rust: (0, 0, 1),
    // rust: ];
    // rust: let actual = level.seen.borrow();
    // rust: assert_eq!(actual.len(), expected.len());
    // rust: for (event, (x, y, z)) in actual.iter().zip(expected) {
    // rust: assert_eq!(*event, (BlockPos::new(x, y, z), b.air(), changed, false));
}
    // rust: drop(actual);
    // rust: b.sim(&mut level, &mut ticks)
    // rust: .neighbor_changed(b.air(), BlockPos::new(3, 4, 5), changed, true);
    // rust: assert_eq!(
    // rust: level.seen.borrow().last(),
    // rust: Some(&(BlockPos::new(3, 4, 5), b.air(), changed, true))
    // rust: );
}

random_tick_hook_can_change_the_block_and_skip_its_own_tick :: proc() {
}
//     use std::cell::Cell;

Grower :: struct {
    inner: TestLevel,
    b: ^'static Behaviours,
        // The state the hook sets, if any, and the `setBlock` flags it sets
        // it with.
    to: Maybe(BlockStateId),
    flags: i32,
    handle: bool,
        // `neighborChanged` calls the hook's writes made.
    notified: Cell<uint>,
    seen: Vec<(BlockPos,
        // Moves on with every write, as `World::revision` does.
    revision: u64,
}
    // rust: impl LevelAccess for Grower {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.block_state(pos)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.revision += 1;
    // rust: self.inner.set_raw(pos, state)
}
is_loaded :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.is_loaded(pos)
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.random()
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.game_time()
}
    // rust: fn observe_neighbor_changed(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: _state: BlockStateId,
    // rust: _changed: BlockId,
    // rust: _moved: bool,
    // rust: ) {
    // rust: self.notified.set(self.notified.get() + 1);
}
    // rust: fn before_random_tick(
    // rust: &mut self,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: &mut BlockStateId,
    // rust: handled: &mut bool,
    // rust: ) {
    // rust: assert_eq!(self.block_state(pos), *state);
    // rust: self.seen.push((pos, *state));
            // The hook, then the level's part of the contract as `GameLevel`
            // keeps it: re-read the block if the hook wrote.
    // rust: let revision = self.revision;
    // rust: if let Some(to) = self.to {
    // rust: let b = self.b;
    // rust: assert!(b.set_block(self, ticks, pos, to, self.flags));
}
    // rust: *handled = self.handle;
    // rust: if !*handled && self.revision != revision {
    // rust: *state = self.block_state(pos);
}
}
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let b = &f.behaviours;
    // rust: let wheat = f.registry.default_state("minecraft:wheat").unwrap();
    // rust: let grown = b.table.set_int(wheat, b.props.age, 3);
    // rust: let next = b.table.set_int(wheat, b.props.age, 4);
    // rust: let mut level = Grower {
    // rust: inner: TestLevel::new(b),
    // rust: b,
    // rust: to: Some(grown),
    // rust: flags: flags::UPDATE_CLIENTS,
    // rust: handle: true,
    // rust: notified: Cell::new(0),
    // rust: seen: Vec::new(),
    // rust: revision: 0,
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: let stone = f.registry.default_state("minecraft:stone").unwrap();
    // rust: let (low, high) = (BlockPos::new(0, 1, 0), BlockPos::new(4, 1, 0));
    // rust: level.set_raw(low, stone);
    // rust: level.set_raw(high, wheat);
    // rust: let draw = |level: &Grower| level.inner.random.clone().next_long();
    // rust: let before = draw(&level);
    // rust: b.random_tick(&mut level, &mut ticks, low);
    // rust: assert!(level.seen.is_empty());
    // rust: b.random_tick(&mut level, &mut ticks, high);
    // rust: assert_eq!(level.seen, [(high, wheat)]);
    // rust: assert_eq!(level.block_state(high), grown);
    // The crop's own tick never ran: it would have drawn from the random.
    // rust: assert_eq!(draw(&level), before);
    // Grown with flag 2, as `CropBlock.randomTick` grows a crop, no
    // neighbour hears of it; with `UPDATE_ALL` the six do.
    // rust: assert_eq!(level.notified.get(), 0);
    // rust: level.flags = flags::UPDATE_ALL;
    // rust: level.set_raw(high, wheat);
    // rust: b.random_tick(&mut level, &mut ticks, high);
    // rust: assert_eq!(level.block_state(high), grown);
    // rust: assert_eq!(level.notified.get(), 6);
    // rust: level.flags = flags::UPDATE_CLIENTS;
    // Unhandled and unchanged, the crop ticks as before.
    // rust: (level.to, level.handle) = (None, false);
    // rust: level.set_raw(high, wheat);
    // rust: b.random_tick(&mut level, &mut ticks, high);
    // rust: assert_eq!(level.seen.len(), 3);
    // rust: assert_ne!(draw(&level), before);
    // Changed but unhandled, the crop ticks as the hook left it: it stays at
    // the hook's age or grows from there, never from the age it had.
    // rust: level.to = Some(grown);
    // rust: let mut grew = false;
    // rust: for _ in 0..1000 {
    // rust: level.set_raw(high, wheat);
    // rust: b.random_tick(&mut level, &mut ticks, high);
    // rust: let now = level.block_state(high);
    // rust: assert!(now == grown || now == next, "{now:?}");
    // rust: grew |= now == next;
}
    // rust: assert!(grew);
    // Changed into a block that doesn't tick randomly, nothing more runs.
    // rust: level.to = Some(stone);
    // rust: level.set_raw(high, wheat);
    // rust: let before = draw(&level);
    // rust: b.random_tick(&mut level, &mut ticks, high);
    // rust: assert_eq!(level.block_state(high), stone);
    // rust: assert_eq!(draw(&level), before);
}

tick_block_hook_can_change_the_block_and_skip_its_own_tick :: proc() {
}
//     use horizon_core::ticks::TickPriority;

Ticked :: struct {
    inner: TestLevel,
    b: ^'static Behaviours,
        // The state the hook sets, if any, and the `setBlock` flags it sets
        // it with.
    to: Maybe(BlockStateId),
    flags: i32,
    handle: bool,
    seen: Vec<(BlockPos,
        // Moves on with every write, as `World::revision` does.
    revision: u64,
}
    // rust: impl LevelAccess for Ticked {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.block_state(pos)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.revision += 1;
    // rust: self.inner.set_raw(pos, state)
}
is_loaded :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.is_loaded(pos)
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.random()
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.game_time()
}
    // rust: fn before_tick_block(
    // rust: &mut self,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: &mut BlockStateId,
    // rust: handled: &mut bool,
    // rust: ) {
    // rust: assert_eq!(self.block_state(pos), *state);
    // rust: self.seen.push((pos, *state));
            // The hook, then the level's part of the contract as `GameLevel`
            // keeps it: re-read the block if the hook wrote.
    // rust: let revision = self.revision;
    // rust: if let Some(to) = self.to {
    // rust: let b = self.b;
    // rust: assert!(b.set_block(self, ticks, pos, to, self.flags));
}
    // rust: *handled = self.handle;
    // rust: if !*handled && self.revision != revision {
    // rust: *state = self.block_state(pos);
}
}
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let b = &f.behaviours;
    // rust: let target = f.registry.default_state("minecraft:target").unwrap();
    // rust: let powered = b.table.set_int(target, b.props.power, 15);
    // rust: let to = b.table.set_int(target, b.props.power, 7);
    // rust: let mut level = Ticked {
    // rust: inner: TestLevel::new(b),
    // rust: b,
    // rust: to: Some(to),
        // A target's own tick writes with `setBlockAndUpdate`.
    // rust: flags: flags::UPDATE_ALL,
    // rust: handle: true,
    // rust: seen: Vec::new(),
    // rust: revision: 0,
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: ticks.add_empty_chunk(ChunkPos::new(0, 0)).unwrap();
    // rust: let pos = BlockPos::new(1, 1, 1);
    // The due ticks run as the game runs them, stepped (scheduled_begin,
    // scheduled_step, scheduled_finish), or as tests do, through
    // tick_scheduled.
    // rust: let run = |level: &mut Ticked, ticks: &mut Ticks, stepped: bool| {
    // rust: if stepped {
    // rust: assert!(b.scheduled_begin(level, ticks, false));
    // rust: while b.scheduled_step(level, ticks, false) {}
    // rust: b.scheduled_finish(ticks, false);
    // rust: } else {
    // rust: b.tick_scheduled(level, ticks);
}
}
    // One tick of the block at `pos` falls due.
    // rust: let due = |level: &mut Ticked, ticks: &mut Ticks, stepped: bool| {
    // rust: let (time, block) = (level.inner.time, b.block(level.block_state(pos)));
    // rust: ticks.schedule_block(time, pos, block, 1, TickPriority::Normal);
    // rust: level.inner.time += 1;
    // rust: run(level, ticks, stepped);
}
    // rust: let rod = |facing: &str, powered: &str| {
    // rust: let lightning_rod = f.registry.default_state("minecraft:lightning_rod").unwrap();
    // rust: let mut s = f.registry.state(lightning_rod).unwrap().clone();
    // rust: s.properties.insert("facing".into(), facing.into());
    // rust: s.properties.insert("powered".into(), powered.into());
    // rust: f.registry.resolve(&s).unwrap()
}
    // rust: for stepped in [false, true] {
    // rust: level.seen.clear();
    // rust: (level.to, level.handle) = (Some(to), true);
    // rust: level.set_raw(pos, powered);
    // rust: due(&mut level, &mut ticks, stepped);
    // rust: assert_eq!(level.seen, [(pos, powered)]);
    // rust: assert_eq!(level.block_state(pos), to);
        // Unhandled, the target's own tick turns it off.
    // rust: (level.to, level.handle) = (None, false);
    // rust: level.set_raw(pos, powered);
    // rust: due(&mut level, &mut ticks, stepped);
    // rust: assert_eq!(level.block_state(pos), target);
        // A tick whose block was replaced runs nothing.
    // rust: let stone = f.registry.default_state("minecraft:stone").unwrap();
    // rust: level.set_raw(pos, powered);
    // rust: let block = b.block(powered);
    // rust: ticks.schedule_block(level.inner.time, pos, block, 1, TickPriority::Normal);
    // rust: level.inner.time += 1;
    // rust: level.set_raw(pos, stone);
    // rust: run(&mut level, &mut ticks, stepped);
    // rust: assert_eq!(level.seen.len(), 2);
        // Changed into another block and unhandled, nothing more runs.
    // rust: level.to = Some(stone);
    // rust: level.set_raw(pos, powered);
    // rust: due(&mut level, &mut ticks, stepped);
    // rust: assert_eq!(level.seen.len(), 3);
    // rust: assert_eq!(level.block_state(pos), stone);
        // Changed but unhandled, the block ticks as the hook left it: the
        // rod's tick unpowers it facing where the hook turned it.
    // rust: (level.to, level.handle) = (Some(rod("north", "true")), false);
    // rust: level.set_raw(pos, rod("up", "true"));
    // rust: due(&mut level, &mut ticks, stepped);
    // rust: assert_eq!(level.block_state(pos), rod("north", "false"));
}
}

state_table_matches_registry :: proc() {
}
    // rust: let Some(f) = fixture() else {
    // rust: return;
}
    // rust: let t = &f.behaviours.table;
    // rust: assert_eq!(t.state_count(), f.registry.len());
    // rust: let stairs = f.registry.default_state("minecraft:oak_stairs").unwrap();
    // rust: let key = f.behaviours.props.facing;
    // rust: let east = t.with_text(stairs, key, "east").unwrap();
    // rust: assert_eq!(f.registry.state(east).unwrap().properties["facing"], "east");
    // rust: assert_eq!(t.text(east, f.behaviours.props.half), "bottom");
    // rust: assert!(classes::Class::ALL.len() <= 320);
}

fences_connect_and_disconnect :: proc() {
}
    // rust: let mut w = world!();
    // rust: let fence = w.id("oak_fence", &[]);
    // rust: let a = BlockPos::new(0, 1, 0);
    // rust: let c = BlockPos::new(1, 1, 0);
    // rust: w.set(a, fence);
    // rust: w.set(c, fence);
    // rust: assert_eq!(w.prop(a, "east"), "true");
    // rust: assert_eq!(w.prop(c, "west"), "true");
    // rust: let stone = w.id("stone", &[]);
    // rust: w.set(BlockPos::new(0, 1, -1), stone);
    // rust: assert_eq!(w.prop(a, "north"), "true", "fences connect to sturdy faces");
    // rust: let air = w.b().air();
    // rust: w.set(c, air);
    // rust: assert_eq!(w.prop(a, "east"), "false");
}

a_barrel_recounts_its_openers_on_its_scheduled_tick :: proc() {
}
//     use horizon_core::ticks::TickPriority;
    // rust: let mut w = world!();
    // rust: let barrel = w.id("barrel", &[("facing", "north"), ("open", "true")]);
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: w.put(pos, barrel);
    // rust: let block = w.b().block(barrel);
    // One scheduled tick of the barrel falls due.
    // rust: let due = |w: &mut World| {
    // rust: w.ticks
    // rust: .schedule_block(w.level.time, pos, block, 1, TickPriority::Normal);
    // rust: w.tick();
}
    // rust: let sounds = |w: &World, name: &str| {
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, LevelEvent::Sound { sound, .. } if &**sound == name))
    // rust: .count()
}
    // rust: let game_events = |w: &World, name: &str| {
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, LevelEvent::GameEvent { event, .. } if *event == name))
    // rust: .count()
}
    // A player walked away while the menu was still counted open.
    // rust: w.level.openers.insert(pos, (1, 0));
    // rust: due(&mut w);
    // rust: assert_eq!(
    // rust: w.level.opener_rechecks,
    // rust: [pos],
    // rust: "BarrelBlock.tick asks its block entity to recheck the openers"
    // rust: );
    // rust: assert_eq!(
    // rust: w.prop(pos, "open"),
    // rust: "false",
    // rust: "updateBlockState closes the barrel"
    // rust: );
    // rust: assert_eq!(sounds(&w, "minecraft:block.barrel.close"), 1);
    // rust: let pitch = w
    // rust: .level
    // rust: .events
    // rust: .iter()
    // rust: .find_map(|e| match e {
    // rust: LevelEvent::Sound {
    // rust: sound,
    // rust: volume,
    // rust: pitch,
    // rust: ..
    // rust: } if &**sound == "minecraft:block.barrel.close" => Some((*volume, *pitch)),
    // rust: _ => None,
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(pitch.0, 0.5);
    // rust: assert!((0.9..1.0).contains(&pitch.1), "pitch {}", pitch.1);
    // rust: assert_eq!(game_events(&w, "minecraft:container_close"), 1);
    // A barrel's openerCountChanged is empty: no lid block event (a chest
    // queues one here).
    // rust: assert!(
    // rust: w.ticks.block_events.is_empty(),
    // rust: "a barrel broadcasts no block event"
    // rust: );
    // Someone opens it again: the recount finds them and the lid opens.
    // rust: w.level.openers.insert(pos, (0, 1));
    // rust: due(&mut w);
    // rust: assert_eq!(w.prop(pos, "open"), "true");
    // rust: assert_eq!(sounds(&w, "minecraft:block.barrel.open"), 1);
    // rust: assert_eq!(game_events(&w, "minecraft:container_open"), 1);
    // ContainerOpenersCounter.scheduleRecheck: the recheck repeats while the
    // barrel is open, five ticks later.
    // rust: let rechecks = w.level.opener_rechecks.len();
    // rust: for _ in 0..5 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.level.opener_rechecks.len(), rechecks + 1);
    // Nobody has it open on the next recount: the chain stops there.
    // rust: w.level.openers.insert(pos, (1, 0));
    // rust: for _ in 0..5 {
    // rust: w.tick();
}
    // rust: let rechecks = w.level.opener_rechecks.len();
    // rust: for _ in 0..10 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.level.opener_rechecks.len(), rechecks);
    // rust: assert_eq!(w.prop(pos, "open"), "false");
}

walls_and_panes_connect :: proc() {
}
    // rust: let mut w = world!();
    // rust: let wall = w.id("cobblestone_wall", &[]);
    // rust: let pane = w.id("glass_pane", &[]);
    // rust: w.set(BlockPos::new(0, 1, 0), wall);
    // rust: w.set(BlockPos::new(0, 1, 1), wall);
    // rust: w.set(BlockPos::new(0, 1, 2), wall);
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 1), "north"), "low");
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 1), "south"), "low");
    // rust: assert_eq!(
    // rust: w.prop(BlockPos::new(0, 1, 1), "up"),
    // rust: "false",
    // rust: "straight wall drops its post"
    // rust: );
    // rust: let stone = w.id("stone", &[]);
    // rust: w.set(BlockPos::new(0, 2, 1), stone);
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 1), "north"), "tall");
    // rust: w.set(BlockPos::new(5, 1, 0), pane);
    // rust: w.set(BlockPos::new(6, 1, 0), pane);
    // rust: assert_eq!(w.prop(BlockPos::new(5, 1, 0), "east"), "true");
}

stairs_form_corners :: proc() {
}
    // rust: let mut w = world!();
    // rust: let north = w.id("oak_stairs", &[("facing", "north")]);
    // rust: let east = w.id("oak_stairs", &[("facing", "east")]);
    // rust: w.set(BlockPos::new(0, 1, 0), north);
    // rust: w.set(BlockPos::new(0, 1, -1), east);
    // The north-facing stair has an east-facing stair behind it.
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "shape"), "outer_right");
}

torch_and_door_halves_break_with_support :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 3, "stone");
    // rust: let torch = w.id("torch", &[]);
    // rust: w.set(BlockPos::new(1, 1, 1), torch);
    // rust: let door = w.id("oak_door", &[("half", "lower")]);
    // rust: let upper = w.id("oak_door", &[("half", "upper")]);
    // rust: w.set(BlockPos::new(0, 1, 0), door);
    // rust: w.set(BlockPos::new(0, 2, 0), upper);
    // rust: let air = w.b().air();
    // rust: w.set(BlockPos::new(1, 0, 1), air);
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(1, 1, 1)),
    // rust: air,
    // rust: "torch pops without support"
    // rust: );
    // rust: assert!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, LevelEvent::DropResources { .. }))
    // rust: );
    // rust: w.set(BlockPos::new(0, 1, 0), air);
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(0, 2, 0)),
    // rust: air,
    // rust: "upper door half goes with the lower"
    // rust: );
}

snowy_grass_and_chests_pair :: proc() {
}
    // rust: let mut w = world!();
    // rust: let grass = w.id("grass_block", &[]);
    // rust: w.set(BlockPos::new(0, 0, 0), grass);
    // rust: let snow = w.id("snow", &[]);
    // rust: w.set(BlockPos::new(0, 1, 0), snow);
    // rust: assert_eq!(w.prop(BlockPos::new(0, 0, 0), "snowy"), "true");
    // A left chest's partner sits clockwise of its facing; removing the
    // partner makes it single again.
    // rust: let left = w.id("chest", &[("facing", "north"), ("type", "left")]);
    // rust: let right = w.id("chest", &[("facing", "north"), ("type", "right")]);
    // rust: w.set(BlockPos::new(3, 1, 0), left);
    // rust: w.set(BlockPos::new(4, 1, 0), right);
    // rust: let air = w.b().air();
    // rust: w.set(BlockPos::new(4, 1, 0), air);
    // rust: assert_eq!(w.prop(BlockPos::new(3, 1, 0), "type"), "single");
}

sand_falls_and_concrete_solidifies :: proc() {
}
    // rust: let mut w = world!();
    // rust: let sand = w.id("sand", &[]);
    // rust: w.set(BlockPos::new(0, 5, 0), sand);
    // rust: w.tick();
    // rust: w.tick();
    // rust: assert_eq!(w.get(BlockPos::new(0, 5, 0)), w.b().air());
    // rust: assert!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, LevelEvent::FallingBlock { state, .. } if *state == sand))
    // rust: );
    // rust: w.floor(0, 2, "stone");
    // rust: let water = w.id("water", &[]);
    // rust: w.put(BlockPos::new(1, 1, 0), water);
    // rust: let powder = w.id("white_concrete_powder", &[]);
    // rust: let landing = w.b().falling_block_landed(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: BlockPos::new(0, 1, 0),
    // rust: powder,
    // rust: false,
    // rust: );
    // rust: assert_eq!(
    // rust: landing,
    // rust: falling::Landing::Placed(w.id("white_concrete", &[]))
    // rust: );
}

water_spreads_on_a_floor :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let water = w.id("water", &[]);
    // rust: w.set(BlockPos::new(0, 1, 0), water);
    // rust: for _ in 0..60 {
    // rust: w.tick();
}
    // rust: for d in 1..=7 {
    // rust: let pos = BlockPos::new(d, 1, 0);
    // rust: assert_eq!(
    // rust: w.prop(pos, "level"),
    // rust: d.to_string(),
    // rust: "flow at distance {d}: {}",
    // rust: w.name(pos)
    // rust: );
}
    // rust: assert_eq!(w.get(BlockPos::new(8, 1, 0)), w.b().air());
    // Diagonals follow Manhattan distance.
    // rust: assert_eq!(w.prop(BlockPos::new(2, 1, 2), "level"), "4");
}

refused_spread_keeps_water_out_of_a_guarded_block :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: w.level.guarded.insert(BlockPos::new(3, 1, 0));
    // rust: let water = w.id("water", &[]);
    // rust: w.set(BlockPos::new(0, 1, 0), water);
    // rust: for _ in 0..60 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(2, 1, 0), "level"), "2");
    // rust: assert_eq!(w.get(BlockPos::new(3, 1, 0)), w.b().air());
    // Water still reaches (4, 1, 0) around the guarded block.
    // rust: assert_eq!(w.prop(BlockPos::new(4, 1, 0), "level"), "6");
}

bucket_source_removal_drains_spread_water :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let at = BlockPos::new(0, 1, 0);
    // rust: assert!(
    // rust: w.b()
    // rust: .bucket_empty(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: at,
    // rust: None,
    // rust: BucketContent::Fluid(crate::fluid::FluidKind::Water),
    // rust: "minecraft:item.bucket.empty",
    // rust: false,
    // rust: false
    // rust: )
    // rust: .is_some()
    // rust: );
    // rust: for _ in 0..60 {
    // rust: w.tick();
}
    // rust: assert_ne!(w.get(BlockPos::new(1, 1, 0)), w.b().air());
    // rust: assert_eq!(
    // rust: w.b().bucket_pickup(&mut w.level, &mut w.ticks, at, false),
    // rust: Some("minecraft:water_bucket")
    // rust: );
    // rust: for _ in 0..120 {
    // rust: w.tick();
}
    // rust: for x in -8..=8 {
    // rust: for z in -8..=8 {
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(x, 1, z)),
    // rust: w.b().air(),
    // rust: "water remains at {x}, {z}"
    // rust: );
}
}
}

water_falls_and_makes_sources :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 4, "stone");
    // rust: let water = w.id("water", &[]);
    // rust: w.set(BlockPos::new(0, 4, 0), water);
    // rust: for _ in 0..30 {
    // rust: w.tick();
}
    // rust: assert_eq!(
    // rust: w.prop(BlockPos::new(0, 3, 0), "level"),
    // rust: "8",
    // rust: "falling water"
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "level"), "8");
    // Two sources make a third (no holes within slope distance, so the
    // sources spread in every direction).
    // rust: let mut w = world!();
    // rust: w.floor(0, 12, "stone");
    // rust: w.set(BlockPos::new(0, 1, 0), water);
    // rust: w.set(BlockPos::new(2, 1, 0), water);
    // rust: for _ in 0..20 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.get(BlockPos::new(1, 1, 0)), water);
    // On a small platform the water instead seeks the nearest edges.
    // rust: let mut w = world!();
    // rust: w.floor(0, 4, "stone");
    // rust: w.set(BlockPos::new(0, 1, 0), water);
    // rust: w.set(BlockPos::new(2, 1, 0), water);
    // rust: for _ in 0..20 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.get(BlockPos::new(1, 1, 0)), w.b().air());
    // rust: assert_eq!(w.prop(BlockPos::new(-1, 1, 0), "level"), "1");
}

lava_meets_water :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 4, "stone");
    // rust: let lava = w.id("lava", &[]);
    // rust: let water = w.id("water", &[]);
    // rust: w.set(BlockPos::new(0, 1, 0), lava);
    // rust: w.set(BlockPos::new(1, 1, 0), water);
    // rust: assert_eq!(w.get(BlockPos::new(0, 1, 0)), w.id("obsidian", &[]));
    // rust: let mut w = world!();
    // rust: w.floor(0, 4, "stone");
    // rust: w.set(BlockPos::new(0, 1, 0), lava);
    // rust: for _ in 0..40 {
    // rust: w.tick();
}
    // rust: w.set(BlockPos::new(1, 2, 0), water);
    // rust: for _ in 0..40 {
    // rust: w.tick();
}
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(1, 1, 0)),
    // rust: w.id("cobblestone", &[]),
    // rust: "{}",
    // rust: w.name(BlockPos::new(1, 1, 0))
    // rust: );
}

waterlogged_blocks_schedule_water :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 4, "stone");
    // rust: let slab = w.id("oak_slab", &[("waterlogged", "true")]);
    // rust: w.set(BlockPos::new(0, 1, 0), slab);
    // A neighbour shape update schedules the slab's water tick.
    // rust: let stone = w.id("stone", &[]);
    // rust: w.set(BlockPos::new(0, 1, 1), stone);
    // rust: for _ in 0..20 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(1, 1, 0), "level"), "1");
}

redstone_lever_wire_and_lamp :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 20, "stone");
    // rust: let wire = w.id("redstone_wire", &[]);
    // rust: let lamp = w.id("redstone_lamp", &[]);
    // rust: let lever = w.id("lever", &[("face", "floor"), ("facing", "north")]);
    // rust: for x in 1..=5 {
    // rust: w.set(BlockPos::new(x, 1, 0), wire);
}
    // rust: w.set(BlockPos::new(6, 1, 0), lamp);
    // rust: w.set(BlockPos::new(0, 1, 0), lever);
    // rust: let lever_on = w
    // rust: .b()
    // rust: .table
    // rust: .set_bool(w.get(BlockPos::new(0, 1, 0)), w.b().props.powered, true);
    // rust: w.set(BlockPos::new(0, 1, 0), lever_on);
    // rust: assert_eq!(w.prop(BlockPos::new(1, 1, 0), "power"), "15");
    // rust: assert_eq!(w.prop(BlockPos::new(5, 1, 0), "power"), "11");
    // rust: assert_eq!(w.prop(BlockPos::new(6, 1, 0), "lit"), "true");
    // rust: let lever_off = w.b().table.set_bool(lever_on, w.b().props.powered, false);
    // rust: w.set(BlockPos::new(0, 1, 0), lever_off);
    // rust: assert_eq!(w.prop(BlockPos::new(3, 1, 0), "power"), "0");
    // rust: for _ in 0..5 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(6, 1, 0), "lit"), "false");
}

repeater_delays_and_torch_inverts :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let block = w.id("redstone_block", &[]);
    // A repeater takes its input from the side it faces.
    // rust: let repeater = w.id("repeater", &[("facing", "west")]);
    // rust: w.set(BlockPos::new(1, 1, 0), repeater);
    // rust: w.set(BlockPos::new(0, 1, 0), block);
    // rust: assert_eq!(w.prop(BlockPos::new(1, 1, 0), "powered"), "false");
    // rust: w.tick();
    // rust: w.tick();
    // rust: assert_eq!(w.prop(BlockPos::new(1, 1, 0), "powered"), "true");
    // rust: let torch = w.id("redstone_torch", &[]);
    // rust: let stone = w.id("stone", &[]);
    // rust: w.set(BlockPos::new(5, 1, 0), stone);
    // rust: w.set(BlockPos::new(5, 2, 0), torch);
    // A redstone block only weakly powers the stone: the torch stays lit.
    // rust: w.set(BlockPos::new(6, 1, 0), block);
    // rust: w.tick();
    // rust: w.tick();
    // rust: assert_eq!(w.prop(BlockPos::new(5, 2, 0), "lit"), "true");
    // A lever on the stone strongly powers it.
    // rust: let air = w.b().air();
    // rust: w.set(BlockPos::new(6, 1, 0), air);
    // rust: let lever = w.id(
    // rust: "lever",
    // rust: &[("face", "wall"), ("facing", "east"), ("powered", "true")],
    // rust: );
    // rust: w.set(BlockPos::new(6, 1, 0), lever);
    // LeverBlock.pull notifies the attached block's neighbours.
    // rust: let lever_block = w.b().block(lever);
    // rust: w.b().update_neighbors_at(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: BlockPos::new(5, 1, 0),
    // rust: lever_block,
    // rust: );
    // rust: w.tick();
    // rust: w.tick();
    // rust: assert_eq!(w.prop(BlockPos::new(5, 2, 0), "lit"), "false");
}

crops_grow_and_leaves_decay :: proc() {
}
    // rust: let mut w = world!();
    // rust: let farmland = w.id("farmland", &[("moisture", "7")]);
    // rust: let wheat = w.id("wheat", &[]);
    // rust: w.put(BlockPos::new(0, 0, 0), farmland);
    // rust: w.put(BlockPos::new(0, 1, 0), wheat);
    // rust: for _ in 0..400 {
    // rust: w.b()
    // rust: .random_tick(&mut w.level, &mut w.ticks, BlockPos::new(0, 1, 0));
}
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "age"), "7");
    // rust: let leaves = w.id("oak_leaves", &[("distance", "7")]);
    // rust: w.put(BlockPos::new(5, 5, 5), leaves);
    // rust: w.b()
    // rust: .random_tick(&mut w.level, &mut w.ticks, BlockPos::new(5, 5, 5));
    // rust: assert_eq!(w.get(BlockPos::new(5, 5, 5)), w.b().air());
    // rust: let log = w.id("oak_log", &[]);
    // rust: let leaf = w.id("oak_leaves", &[]);
    // rust: w.set(BlockPos::new(9, 5, 5), leaf);
    // rust: w.set(BlockPos::new(8, 5, 5), log);
    // rust: w.tick();
    // rust: assert_eq!(w.prop(BlockPos::new(9, 5, 5), "distance"), "1");
}

    // rust: impl World<'_> {
    // Right-click `item` on the `face` of `clicked`, hitting the face centre
    // (offset vertically by `dy`), looking with `yaw`/`pitch`.
    // rust: fn place(
    // rust: &mut self,
    // rust: item: &str,
    // rust: clicked: BlockPos,
    // rust: face: Direction,
    // rust: yaw: f32,
    // rust: pitch: f32,
    // rust: dy: f64,
    // rust: ) -> PlaceOutcome {
    // rust: let [nx, ny, nz] = face.normal();
    // rust: let hit = horizon_core::geometry::Vec3::new(
    // rust: f64::from(clicked.x) + 0.5 + f64::from(nx) * 0.5,
    // rust: f64::from(clicked.y) + 0.5 + f64::from(ny) * 0.5 + dy,
    // rust: f64::from(clicked.z) + 0.5 + f64::from(nz) * 0.5,
    // rust: );
    // rust: let ctx = PlaceContext {
    // rust: clicked_pos: clicked,
    // rust: face,
    // rust: hit,
    // rust: inside: false,
    // rust: yaw,
    // rust: pitch,
    // rust: sneaking: false,
    // rust: item: format!("minecraft:{item}"),
    // rust: can_use_game_master_blocks: false,
}
    // rust: self.f
    // rust: .behaviours
    // rust: .place_block(&mut self.level, &mut self.ticks, &ctx)
}
use_block :: proc(self: ^Self, pos: BlockPos) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let player = PlayerContext {
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: may_build: true,
    // rust: can_eat: true,
    // rust: game_master: false,
}
    // rust: let hit = horizon_core::geometry::Vec3::new(
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 0.5,
    // rust: f64::from(pos.z),
    // rust: );
    // rust: self.f.behaviours.use_without_item(
    // rust: &mut self.level,
    // rust: &mut self.ticks,
    // rust: pos,
    // rust: Direction::North,
    // rust: hit,
    // rust: player,
    // rust: )
}
    // Right-click the north face of `pos` with `item` (or an empty hand),
    // and which of `useItemOn` and `useWithoutItem` answered.
use_branch :: proc(self: ^Self, pos: BlockPos, item: Maybe(string)) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let player = PlayerContext {
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: may_build: true,
    // rust: can_eat: false,
    // rust: game_master: false,
}
    // rust: let hit = horizon_core::geometry::Vec3::new(
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 0.5,
    // rust: f64::from(pos.z),
    // rust: );
    // rust: self.f.behaviours.use_item_on_branch(
    // rust: &mut self.level,
    // rust: &mut self.ticks,
    // rust: pos,
    // rust: Direction::North,
    // rust: hit,
    // rust: player,
    // rust: item,
    // rust: )
}
    // Right-click the north face of `pos` holding `item` in the main hand.
use_item :: proc(self: ^Self, pos: BlockPos, item: string) -> I {
    // Ported from Horizon
    return {}
}
    // rust: self.use_item_on(pos, Some(item), 0.5)
}
    // Right-click the north face of `pos` with an empty main hand.
use_empty_hand :: proc(self: ^Self, pos: BlockPos) -> I {
    // Ported from Horizon
    return {}
}
    // rust: self.use_item_on(pos, None, 0.5)
}
    // Right-click the north face of `pos` with an empty main hand, hitting
    // `dy` blocks above the block's floor.
use_empty_hand_at :: proc(self: ^Self, pos: BlockPos, dy: f64) -> I {
    // Ported from Horizon
    return {}
}
    // rust: self.use_item_on(pos, None, dy)
}
use_item_on :: proc(self: ^Self, pos: BlockPos, item: Maybe(string), dy: f64) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let player = PlayerContext {
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: may_build: true,
    // rust: can_eat: true,
    // rust: game_master: false,
}
    // rust: let hit = horizon_core::geometry::Vec3::new(
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + dy,
    // rust: f64::from(pos.z),
    // rust: );
    // rust: self.f.behaviours.use_item_on(
    // rust: &mut self.level,
    // rust: &mut self.ticks,
    // rust: pos,
    // rust: Direction::North,
    // rust: hit,
    // rust: player,
    // rust: item,
    // rust: )
}
}

use_on_a_block_says_which_branch_answered :: proc() {
}
    // ServerPlayerGameMode.useItemOn: ITEM_USED_ON_BLOCK when useItemOn
    // consumes the click, DEFAULT_BLOCK_USE when useWithoutItem does.
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // A lever has no useItemOn of its own: it flips with any hand.
    // rust: let lever = w.id("lever", &[("face", "floor"), ("facing", "north")]);
    // rust: for item in [None, Some("minecraft:stick")] {
    // rust: w.put(pos, lever);
    // rust: let (result, branch) = w.use_branch(pos, item);
    // rust: assert!(result.consumes_action(), "{item:?}");
    // rust: assert_eq!(branch, UseBranch::WithoutItem, "{item:?}");
}
    // RespawnAnchorBlock.useItemOn: glowstone charges it.
    // rust: let anchor = w.id("respawn_anchor", &[("charges", "0")]);
    // rust: w.put(pos, anchor);
    // rust: assert_eq!(
    // rust: w.use_branch(pos, Some("minecraft:glowstone")),
    // rust: (InteractionResult::Success, UseBranch::ItemOn)
    // rust: );
    // CandleBlock.useItemOn: an empty hand snuffs a lit candle.
    // rust: let candle = w.id("candle", &[("candles", "1"), ("lit", "true")]);
    // rust: w.put(pos, candle);
    // rust: assert_eq!(
    // rust: w.use_branch(pos, None),
    // rust: (InteractionResult::Success, UseBranch::ItemOn)
    // rust: );
    // SweetBerryBushBlock.useItemOn: bone meal on a growing bush passes on
    // to the item without trying the empty hand.
    // rust: let bush = w.id("sweet_berry_bush", &[("age", "0")]);
    // rust: w.put(pos, bush);
    // rust: assert_eq!(
    // rust: w.use_branch(pos, Some("minecraft:bone_meal")),
    // rust: (InteractionResult::Pass, UseBranch::ItemOn)
    // rust: );
}

glowstone_charges_a_respawn_anchor_up_to_four :: proc() {
}
    // RespawnAnchorBlock.useItemOn: glowstone on an anchor below 4 charges
    // charges it and the click ends (SUCCESS), so no glowstone is placed (#3034).
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let empty = w.id("respawn_anchor", &[("charges", "0")]);
    // rust: w.put(pos, empty);
    // rust: for charges in 1..=4 {
    // rust: assert_eq!(
    // rust: w.use_item(pos, "minecraft:glowstone"),
    // rust: InteractionResult::Success
    // rust: );
    // rust: assert_eq!(w.prop(pos, "charges"), charges.to_string());
}
    // A full anchor can't be charged: TRY_WITH_EMPTY_HAND, then useWithoutItem
    // (the respawn point), which leaves the charges alone.
    // rust: w.use_item(pos, "minecraft:glowstone");
    // rust: assert_eq!(w.prop(pos, "charges"), "4");
    // Anything else on an empty anchor passes, so the item is used instead.
    // rust: w.put(pos, empty);
    // rust: assert_eq!(w.use_item(pos, "minecraft:stone"), InteractionResult::Pass);
    // rust: assert_eq!(w.prop(pos, "charges"), "0");
}

mining_lights_redstone_ore_until_its_random_tick :: proc() {
}
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: for ore in ["redstone_ore", "deepslate_redstone_ore"] {
    // rust: let unlit = w.id(ore, &[("lit", "false")]);
    // rust: let lit = w.id(ore, &[("lit", "true")]);
    // rust: w.put(pos, unlit);
    // rust: w.b().attack_block(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(w.get(pos), lit);
    // rust: w.b().attack_block(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(w.get(pos), lit);
    // rust: w.b().random_tick(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(w.get(pos), unlit);
}
    // rust: let stone = w.id("stone", &[]);
    // rust: w.put(pos, stone);
    // rust: w.b().attack_block(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(w.get(pos), stone);
}

placement_orients_blocks :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 6, "stone");
    // rust: let ground = BlockPos::new(0, 0, 0);
    // Looking north (yaw 180) at the top of the floor.
    // rust: w.place("oak_stairs", ground, Direction::Up, 180.0, 30.0, 0.0);
    // rust: assert_eq!(
    // rust: w.name(BlockPos::new(0, 1, 0)),
    // rust: "oak_stairs[facing=north,half=bottom,shape=straight,waterlogged=false]"
    // rust: );
    // rust: w.place(
    // rust: "oak_log",
    // rust: BlockPos::new(1, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: );
    // rust: w.place(
    // rust: "oak_log",
    // rust: BlockPos::new(1, 1, 0),
    // rust: Direction::East,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(2, 1, 0), "axis"), "x");
    // Torch against the log's east face becomes a wall torch facing east.
    // rust: w.place(
    // rust: "torch",
    // rust: BlockPos::new(2, 1, 0),
    // rust: Direction::East,
    // rust: 270.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(w.name(BlockPos::new(3, 1, 0)), "wall_torch[facing=east]");
    // Furnaces face the player; observers face where the player looks.
    // rust: w.place(
    // rust: "furnace",
    // rust: BlockPos::new(-2, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(-2, 1, 0), "facing"), "north");
    // rust: w.place(
    // rust: "observer",
    // rust: BlockPos::new(-3, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(-3, 1, 0), "facing"), "south");
}

placement_merges_slabs_and_stacks :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 4, "stone");
    // rust: let ground = BlockPos::new(0, 0, 0);
    // rust: w.place("oak_slab", ground, Direction::Up, 0.0, 60.0, 0.0);
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "type"), "bottom");
    // rust: w.place(
    // rust: "oak_slab",
    // rust: BlockPos::new(0, 1, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 60.0,
    // rust: -0.5,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "type"), "double");
    // Clicking the upper half of a side face places a top slab.
    // rust: w.place(
    // rust: "oak_slab",
    // rust: BlockPos::new(0, 1, 0),
    // rust: Direction::East,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.25,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(1, 1, 0), "type"), "top");
    // rust: w.place(
    // rust: "snow",
    // rust: BlockPos::new(3, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 60.0,
    // rust: 0.0,
    // rust: );
    // rust: w.place(
    // rust: "snow",
    // rust: BlockPos::new(3, 1, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 60.0,
    // rust: -0.375,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(3, 1, 0), "layers"), "2");
    // rust: w.place(
    // rust: "candle",
    // rust: BlockPos::new(-3, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 60.0,
    // rust: 0.0,
    // rust: );
    // rust: w.place(
    // rust: "candle",
    // rust: BlockPos::new(-3, 1, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 60.0,
    // rust: -0.4,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(-3, 1, 0), "candles"), "2");
}

doors_beds_and_plants_place_both_halves :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 6, "grass_block");
    // rust: let ground = BlockPos::new(0, 0, 0);
    // rust: w.place("oak_door", ground, Direction::Up, 180.0, 30.0, 0.0);
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "half"), "lower");
    // rust: assert_eq!(w.prop(BlockPos::new(0, 2, 0), "half"), "upper");
    // rust: assert_eq!(
    // rust: w.use_block(BlockPos::new(0, 1, 0)),
    // rust: InteractionResult::Success
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "open"), "true");
    // rust: assert_eq!(
    // rust: w.prop(BlockPos::new(0, 2, 0), "open"),
    // rust: "true",
    // rust: "the upper half follows"
    // rust: );
    // rust: w.place(
    // rust: "red_bed",
    // rust: BlockPos::new(3, 0, 0),
    // rust: Direction::Up,
    // rust: 180.0,
    // rust: 30.0,
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(3, 1, 0), "part"), "foot");
    // rust: assert_eq!(w.prop(BlockPos::new(3, 1, -1), "part"), "head");
    // rust: w.place(
    // rust: "sunflower",
    // rust: BlockPos::new(-3, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 30.0,
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(-3, 2, 0), "half"), "upper");
    // Iron doors cannot be opened by hand.
    // rust: w.place(
    // rust: "iron_door",
    // rust: BlockPos::new(5, 0, 0),
    // rust: Direction::Up,
    // rust: 180.0,
    // rust: 30.0,
    // rust: 0.0,
    // rust: );
    // rust: assert_eq!(w.use_block(BlockPos::new(5, 1, 0)), InteractionResult::Pass);
    // A placement into a solid block fails.
    // rust: assert_eq!(
    // rust: w.place(
    // rust: "stone",
    // rust: BlockPos::new(0, 0, 0),
    // rust: Direction::West,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0
    // rust: ),
    // rust: PlaceOutcome::Failed
    // rust: );
}

levers_power_wire_through_interaction :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 8, "stone");
    // rust: w.place(
    // rust: "lever",
    // rust: BlockPos::new(0, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 60.0,
    // rust: 0.0,
    // rust: );
    // rust: for x in 1..=3 {
    // rust: w.place(
    // rust: "redstone",
    // rust: BlockPos::new(x, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 60.0,
    // rust: 0.0,
    // rust: );
}
    // rust: assert_eq!(
    // rust: w.use_block(BlockPos::new(0, 1, 0)),
    // rust: InteractionResult::Success
    // rust: );
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "powered"), "true");
    // rust: assert_eq!(w.prop(BlockPos::new(3, 1, 0), "power"), "13");
    // rust: w.use_block(BlockPos::new(0, 1, 0));
    // rust: assert_eq!(w.prop(BlockPos::new(1, 1, 0), "power"), "0");
    // Buttons release after their pressed time.
    // rust: w.place(
    // rust: "stone_button",
    // rust: BlockPos::new(5, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 60.0,
    // rust: 0.0,
    // rust: );
    // rust: w.use_block(BlockPos::new(5, 1, 0));
    // rust: assert_eq!(w.prop(BlockPos::new(5, 1, 0), "powered"), "true");
    // rust: for _ in 0..20 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(5, 1, 0), "powered"), "false");
}

pistons_push_and_sticky_pistons_pull :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("sticky_piston", &[("facing", "east")]);
    // rust: let block = w.id("redstone_block", &[]);
    // rust: let dirt = w.id("dirt", &[]);
    // rust: let air = w.b().air();
    // rust: w.set(BlockPos::new(0, 1, 0), piston);
    // rust: w.set(BlockPos::new(1, 1, 0), dirt);
    // rust: w.set(BlockPos::new(-1, 1, 0), block);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "extended"), "true");
    // rust: assert_eq!(
    // rust: w.name(BlockPos::new(1, 1, 0)),
    // rust: "piston_head[facing=east,short=false,type=sticky]"
    // rust: );
    // rust: assert_eq!(w.get(BlockPos::new(2, 1, 0)), dirt);
    // rust: assert!(w.ticks.moving_pistons.is_empty());
    // rust: w.set(BlockPos::new(-1, 1, 0), air);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "extended"), "false");
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(1, 1, 0)),
    // rust: dirt,
    // rust: "the sticky piston pulled the block back"
    // rust: );
    // rust: assert_eq!(w.get(BlockPos::new(2, 1, 0)), air);
}

refused_spread_keeps_fire_off_a_guarded_block :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: w.set(BlockPos::new(0, 0, 0), w.id("netherrack", &[]));
    // rust: let planks = w.id("oak_planks", &[]);
    // rust: w.set(BlockPos::new(1, 1, 0), planks);
    // rust: w.set(BlockPos::new(-1, 1, 0), planks);
    // rust: w.level.guarded.insert(BlockPos::new(1, 1, 0));
    // rust: w.set(BlockPos::new(0, 1, 0), w.id("fire", &[]));
    // rust: for _ in 0..4000 {
    // rust: w.tick();
}
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(1, 1, 0)),
    // rust: planks,
    // rust: "the guarded planks never burn"
    // rust: );
    // rust: assert_ne!(
    // rust: w.get(BlockPos::new(-1, 1, 0)),
    // rust: planks,
    // rust: "the other planks burned"
    // rust: );
}

refused_piston_move_leaves_the_piston_retracted :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("piston", &[("facing", "east")]);
    // rust: let block = w.id("redstone_block", &[]);
    // rust: let dirt = w.id("dirt", &[]);
    // rust: w.level.guarded.insert(BlockPos::new(2, 1, 0));
    // rust: w.set(BlockPos::new(0, 1, 0), piston);
    // rust: w.set(BlockPos::new(1, 1, 0), dirt);
    // rust: w.set(BlockPos::new(-1, 1, 0), block);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "extended"), "false");
    // rust: assert_eq!(w.get(BlockPos::new(1, 1, 0)), dirt);
    // rust: assert_eq!(w.get(BlockPos::new(2, 1, 0)), w.b().air());
    // rust: assert!(w.ticks.moving_pistons.is_empty());
}

refused_sticky_pull_keeps_the_block_and_sends_no_event :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("sticky_piston", &[("facing", "east")]);
    // rust: let block = w.id("redstone_block", &[]);
    // rust: let dirt = w.id("dirt", &[]);
    // rust: let air = w.b().air();
    // rust: w.set(BlockPos::new(0, 1, 0), piston);
    // rust: w.set(BlockPos::new(1, 1, 0), dirt);
    // rust: w.set(BlockPos::new(-1, 1, 0), block);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.get(BlockPos::new(2, 1, 0)), dirt);
    // rust: w.level.guarded.insert(BlockPos::new(2, 1, 0));
    // rust: w.level.events.clear();
    // rust: w.set(BlockPos::new(-1, 1, 0), air);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "extended"), "false");
    // rust: assert_eq!(w.get(BlockPos::new(1, 1, 0)), air);
    // rust: assert_eq!(w.get(BlockPos::new(2, 1, 0)), dirt, "the pull was refused");
    // Clients would replay a retraction event and pull the block anyway.
    // rust: let sent = w.level.events.iter().any(
    // rust: |e| matches!(e, LevelEvent::BlockEntityEvent { pos, .. } if *pos == BlockPos::new(0, 1, 0)),
    // rust: );
    // rust: assert!(!sent, "no retraction event for a refused pull");
}

// TntBlock.prime returns false on a client: neither the entity, the removal,
// nor its random push may be predicted while replaying a piston update.
tnt_duper_3856_client_neighbor_does_not_prime_or_remove_tnt :: proc() {
}
    // rust: let mut w = world!();
    // rust: let f = w.f;
    // rust: w.level.client_side = true;
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let tnt = w.id("tnt", &[]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: w.put(pos, tnt);
    // rust: w.put(pos.offset(1, 0, 0), power);
    // rust: let mut random = w.level.random.clone();
    // rust: f.behaviours.handle_neighbor_changed(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: pos,
    // rust: f.behaviours.block(power),
    // rust: );
    // rust: assert_eq!(w.get(pos), tnt, "client must wait for server block changes");
    // rust: assert!(
    // rust: w.level.events.is_empty(),
    // rust: "client must not emit TNT effects"
    // rust: );
    // rust: assert_eq!(w.level.random.next_long(), random.next_long());
}

tnt_duper_3856_client_placement_does_not_prime_tnt :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.level.client_side = true;
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let tnt = w.id("tnt", &[]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: w.put(pos.offset(1, 0, 0), power);
    // rust: w.set(pos, tnt);
    // rust: assert_eq!(w.get(pos), tnt);
    // rust: assert!(w.level.events.is_empty());
}

tnt_duper_3856_server_still_primes_each_powered_tnt :: proc() {
}
    // rust: let mut w = world!();
    // rust: let tnt = w.id("tnt", &[]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: for pos in [BlockPos::new(0, 1, 0), BlockPos::new(0, 1, 3)] {
    // rust: w.put(pos.offset(1, 0, 0), power);
    // rust: w.set(pos, tnt);
    // rust: assert_eq!(w.get(pos), w.b().air());
    // rust: assert_eq!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, LevelEvent::PrimeTnt { pos: p, .. } if *p == pos))
    // rust: .count(),
    // rust: 1,
    // rust: );
}
}

// Breaking a wall torch next to a BUD-powered TNT updates the old block while
// the piston already holds its saved state. This vanilla duplication must
// continue to work on the server, without a second TNT from the client.
tnt_duper_3856_piston_keeps_original_and_primes_one_tnt :: proc() {
}
    // rust: let Some(f) = fixture() else {
    // rust: return;
}
    // rust: for client in [false, true] {
    // rust: let mut w = World::new(f);
    // rust: w.level.client_side = client;
    // rust: let base = BlockPos::new(0, 2, 0);
    // rust: let piston = w.id("sticky_piston", &[("facing", "east")]);
    // rust: let slime = w.id("slime_block", &[]);
    // rust: let tnt = w.id("tnt", &[]);
    // rust: let torch = w.id("wall_torch", &[("facing", "north")]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: w.put(base, piston);
    // rust: w.put(base.offset(1, 0, 0), slime);
    // rust: w.put(base.offset(2, 0, 0), slime);
    // rust: w.put(base.offset(2, -1, 0), slime);
    // rust: w.put(base.offset(2, -1, -1), tnt);
    // rust: w.put(base.offset(2, 0, -1), torch);
        // Raw writes model a powered TNT that has not received an update yet.
    // rust: w.put(base.offset(2, -1, -2), power);
    // rust: w.put(base.offset(-1, 0, 0), power);
    // rust: if client {
    // rust: assert!(f.behaviours.client_block_event(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: base,
    // rust: 0,
    // rust: Direction::East as i32
    // rust: ));
    // rust: } else {
    // rust: f.behaviours.handle_neighbor_changed(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: base,
    // rust: f.behaviours.block(power),
    // rust: );
    // rust: f.behaviours.run_block_events(&mut w.level, &mut w.ticks);
}
    // rust: let primed = w
    // rust: .level
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, LevelEvent::PrimeTnt { .. }))
    // rust: .count();
    // rust: assert_eq!(primed, usize::from(!client), "client={client}");
    // rust: for _ in 0..10 {
    // rust: w.level.time += 1;
    // rust: if client {
    // rust: f.behaviours
    // rust: .client_tick_block_entities(&mut w.level, &mut w.ticks);
    // rust: } else {
    // rust: f.behaviours.tick_block_entities(&mut w.level, &mut w.ticks);
}
}
    // rust: assert_eq!(
    // rust: w.get(base.offset(3, -1, -1)),
    // rust: tnt,
    // rust: "original must survive, client={client}"
    // rust: );
    // rust: assert_eq!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .filter(|e| matches!(e, LevelEvent::PrimeTnt { .. }))
    // rust: .count(),
    // rust: usize::from(!client)
    // rust: );
}
}

// `ServerLevel.runBlockEvents` reports a handled event for the clients
// (`ClientboundBlockEventPacket`), carrying the block the event named.
a_handled_block_event_reaches_the_clients :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("piston", &[("facing", "east")]);
    // rust: let block = w.id("redstone_block", &[]);
    // rust: w.set(BlockPos::new(0, 1, 0), piston);
    // rust: w.set(BlockPos::new(-1, 1, 0), block);
    // rust: w.level.events.clear();
    // rust: w.full_tick();
    // rust: assert!(w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::BlockEntityEvent {
    // rust: pos,
    // rust: state,
    // rust: a: 0,
    // rust: ..
    // rust: } if *pos == BlockPos::new(0, 1, 0) && *state == piston
    // rust: )));
}

// `ClientLevel.blockEvent`: the client re-runs `triggerEvent` on its own
// level, which builds the moving block entities a piston's `moveBlocks`
// makes, and ticks them to the placed block.
a_client_replays_a_pistons_block_event :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("sticky_piston", &[("facing", "east")]);
    // rust: let dirt = w.id("dirt", &[]);
    // rust: let block = w.id("redstone_block", &[]);
    // rust: w.put(BlockPos::new(0, 1, 0), piston);
    // rust: w.put(BlockPos::new(1, 1, 0), dirt);
    // rust: w.put(BlockPos::new(-1, 1, 0), block);
    // rust: w.f.behaviours.client_block_event(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: BlockPos::new(0, 1, 0),
    // rust: 0,
    // rust: Direction::East as i32,
    // rust: );
    // rust: assert!(
    // rust: w.ticks
    // rust: .moving_pistons
    // rust: .iter()
    // rust: .any(|(p, _)| *p == BlockPos::new(2, 1, 0))
    // rust: );
    // rust: for _ in 0..3 {
    // rust: w.level.time += 1;
    // rust: w.f.behaviours
    // rust: .client_tick_block_entities(&mut w.level, &mut w.ticks);
}
    // rust: assert_eq!(w.get(BlockPos::new(2, 1, 0)), dirt);
    // rust: assert_eq!(
    // rust: w.name(BlockPos::new(1, 1, 0)),
    // rust: "piston_head[facing=east,short=false,type=sticky]"
    // rust: );
    // rust: assert!(w.ticks.moving_pistons.is_empty());
}

// A client's copy of a move doesn't start the pistons the moved block
// powers (`checkIfExtend` is server-only): their own block events come from
// the server.
a_client_replay_starts_no_other_piston :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: w.level.client_side = true;
    // rust: let piston = w.id("piston", &[("facing", "east")]);
    // rust: let block = w.id("redstone_block", &[]);
    // rust: let up = w.id("piston", &[("facing", "up")]);
    // rust: w.put(BlockPos::new(0, 1, 0), piston);
    // rust: w.put(BlockPos::new(1, 1, 0), block);
    // rust: w.put(BlockPos::new(2, 2, 0), up);
    // rust: w.f.behaviours.client_block_event(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: BlockPos::new(0, 1, 0),
    // rust: 0,
    // rust: Direction::East as i32,
    // rust: );
    // rust: for _ in 0..10 {
    // rust: w.level.time += 1;
    // rust: w.f.behaviours
    // rust: .client_tick_block_entities(&mut w.level, &mut w.ticks);
}
    // rust: assert_eq!(w.get(BlockPos::new(2, 1, 0)), block);
    // rust: assert_eq!(w.get(BlockPos::new(2, 2, 0)), up);
    // rust: assert!(w.ticks.moving_pistons.is_empty());
    // rust: assert!(w.ticks.block_events.is_empty());
}

pistons_pop_fragile_blocks_and_refuse_obsidian :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("piston", &[("facing", "east")]);
    // rust: let block = w.id("redstone_block", &[]);
    // rust: let torch = w.id("torch", &[]);
    // rust: let obsidian = w.id("obsidian", &[]);
    // rust: w.set(BlockPos::new(0, 1, 0), piston);
    // rust: w.set(BlockPos::new(1, 1, 0), torch);
    // rust: w.set(BlockPos::new(-1, 1, 0), block);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(
    // rust: w.name(BlockPos::new(1, 1, 0)),
    // rust: "piston_head[facing=east,short=false,type=normal]"
    // rust: );
    // rust: assert!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, LevelEvent::DropResources { state, .. } if *state == torch))
    // rust: );
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: w.set(BlockPos::new(0, 1, 0), piston);
    // rust: w.set(BlockPos::new(1, 1, 0), obsidian);
    // rust: w.set(BlockPos::new(-1, 1, 0), block);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "extended"), "false");
    // rust: assert_eq!(w.get(BlockPos::new(1, 1, 0)), obsidian);
}

// `MovingPistonBlock.getDrops`: a broken moving piston drops the block it is
// moving, and drops nothing at all once its moving-piston block entity is
// gone.
a_broken_moving_piston_drops_the_block_it_carries :: proc() {
}
    // rust: let mut w = world!();
    // rust: let moving = w.id("moving_piston", &[("facing", "east"), ("type", "normal")]);
    // rust: let sand = w.id("sand", &[]);
    // rust: let carried = BlockPos::new(0, 1, 0);
    // rust: let orphan = BlockPos::new(5, 1, 5);
    // rust: for pos in [carried, orphan] {
    // rust: w.put(pos, moving);
}
    // rust: w.ticks.moving_pistons.push((
    // rust: carried,
    // rust: MovingPiston {
    // rust: moved_state: sand,
    // rust: direction: Direction::East,
    // rust: extending: true,
    // rust: source: false,
    // rust: progress: 0.5,
    // rust: progress_o: 0.4,
    // rust: last_ticked: 0,
    // rust: death_ticks: 0,
    // rust: id: 0,
    // rust: },
    // rust: ));
    // rust: w.level.events.clear();
    // rust: for pos in [carried, orphan] {
    // rust: w.b().destroy_block(&mut w.level, &mut w.ticks, pos, true);
}
    // rust: let drops: Vec<(BlockPos, BlockStateId)> = w
    // rust: .level
    // rust: .events
    // rust: .iter()
    // rust: .filter_map(|e| match e {
    // rust: LevelEvent::DropResources { pos, state } => Some((*pos, *state)),
    // rust: _ => None,
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(
    // rust: drops,
    // rust: vec![(carried, sand)],
    // rust: "the moving piston drops the sand it carries; without its block entity there is nothing to drop"
    // rust: );
}

// `MovingPistonBlock.useWithoutItem`: a moving piston with no block entity (its
// move is not in flight) is removed by the click, and one that is still moving
// keeps its block and passes the click on.
a_moving_piston_without_a_block_entity_is_removed_by_a_click :: proc() {
}
    // rust: let mut w = world!();
    // rust: let moving = w.id("moving_piston", &[("facing", "east"), ("type", "normal")]);
    // rust: let orphan = BlockPos::new(0, 1, 0);
    // rust: let in_flight = BlockPos::new(4, 1, 4);
    // rust: let air = w.id("air", &[]);
    // rust: for pos in [orphan, in_flight] {
    // rust: w.put(pos, moving);
}
    // rust: w.ticks.moving_pistons.push((
    // rust: in_flight,
    // rust: MovingPiston {
    // rust: moved_state: w.id("sand", &[]),
    // rust: direction: Direction::East,
    // rust: extending: true,
    // rust: source: false,
    // rust: progress: 0.5,
    // rust: progress_o: 0.4,
    // rust: last_ticked: 0,
    // rust: death_ticks: 0,
    // rust: id: 0,
    // rust: },
    // rust: ));
    // rust: assert_eq!(w.use_block(orphan), InteractionResult::Consume);
    // rust: assert_eq!(w.get(orphan), air, "the orphan moving piston is removed");
    // rust: assert_eq!(w.use_block(in_flight), InteractionResult::Pass);
    // rust: assert_eq!(
    // rust: w.get(in_flight),
    // rust: moving,
    // rust: "a moving piston in flight keeps its block"
    // rust: );
}

// `MovingPistonBlock.destroy`: a moving piston a player breaks takes the
// extended piston base behind it with it; an unextended base stays.
breaking_a_moving_piston_removes_its_extended_base :: proc() {
}
    // rust: let mut w = world!();
    // rust: let moving = w.id("moving_piston", &[("facing", "east"), ("type", "normal")]);
    // rust: let extended = w.id("piston", &[("facing", "east"), ("extended", "true")]);
    // rust: let retracted = w.id("piston", &[("facing", "east"), ("extended", "false")]);
    // rust: let air = w.id("air", &[]);
    // The head at (1, 1, 0) faces east, so its base is at (0, 1, 0).
    // rust: w.put(BlockPos::new(0, 1, 0), extended);
    // rust: w.put(BlockPos::new(1, 1, 0), moving);
    // rust: w.f.behaviours.player_destroy_block(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: BlockPos::new(1, 1, 0),
    // rust: false,
    // rust: true,
    // rust: );
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(0, 1, 0)),
    // rust: air,
    // rust: "the extended base goes with the moving piston"
    // rust: );
    // rust: w.put(BlockPos::new(5, 1, 0), retracted);
    // rust: w.put(BlockPos::new(6, 1, 0), moving);
    // rust: w.f.behaviours.player_destroy_block(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: BlockPos::new(6, 1, 0),
    // rust: false,
    // rust: true,
    // rust: );
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(5, 1, 0)),
    // rust: retracted,
    // rust: "an unextended base is left alone"
    // rust: );
}

// `LevelChunk.setBlockState` over a moving piston only runs the block
// entity's `finalTick`: `MovingPistonBlock.destroy`, which removes the
// extended base, is `ServerPlayerGameMode.destroyBlock`'s alone. `/setblock`,
// `/fill` and `Level.destroyBlock` over the head leave a headless piston.
replacing_a_moving_piston_leaves_its_extended_base :: proc() {
}
    // rust: let mut w = world!();
    // rust: let moving = w.id("moving_piston", &[("facing", "east"), ("type", "normal")]);
    // rust: let extended = w.id("piston", &[("facing", "east"), ("extended", "true")]);
    // rust: let air = w.id("air", &[]);
    // /setblock ~ ~ ~ air on the head: the extended base stays.
    // rust: w.put(BlockPos::new(0, 1, 0), extended);
    // rust: w.put(BlockPos::new(1, 1, 0), moving);
    // rust: w.set(BlockPos::new(1, 1, 0), air);
    // rust: assert_eq!(w.get(BlockPos::new(1, 1, 0)), air);
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(0, 1, 0)),
    // rust: extended,
    // rust: "a setBlock over the head leaves a headless extended piston"
    // rust: );
    // Level.destroyBlock (explosions, decay) is not a player break either.
    // rust: w.put(BlockPos::new(4, 1, 0), extended);
    // rust: w.put(BlockPos::new(5, 1, 0), moving);
    // rust: w.b()
    // rust: .destroy_block(&mut w.level, &mut w.ticks, BlockPos::new(5, 1, 0), false);
    // rust: assert_eq!(
    // rust: w.get(BlockPos::new(4, 1, 0)),
    // rust: extended,
    // rust: "destroyBlock over the head leaves a headless extended piston"
    // rust: );
}

dripstone_fills_cauldrons :: proc() {
}
    // rust: let mut w = world!();
    // rust: let block = w.id("dripstone_block", &[]);
    // rust: let water = w.id("water", &[]);
    // rust: let tip = w.id(
    // rust: "pointed_dripstone",
    // rust: &[("vertical_direction", "down"), ("thickness", "tip")],
    // rust: );
    // rust: let cauldron = w.id("cauldron", &[]);
    // rust: w.put(BlockPos::new(0, 11, 0), water);
    // rust: w.put(BlockPos::new(0, 10, 0), block);
    // rust: w.put(BlockPos::new(0, 9, 0), tip);
    // rust: w.put(BlockPos::new(0, 5, 0), cauldron);
    // rust: for _ in 0..100 {
    // rust: w.b()
    // rust: .random_tick(&mut w.level, &mut w.ticks, BlockPos::new(0, 9, 0));
}
    // rust: for _ in 0..80 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.name(BlockPos::new(0, 5, 0)), "water_cauldron[level=1]");
}

a_level_can_answer_for_a_blocks_signal :: proc() {
}
    // rust: let mut w = world!();
    // rust: let source = BlockPos::new(0, 1, 0);
    // rust: let beside = BlockPos::new(-1, 1, 0);
    // rust: let above = BlockPos::new(0, 2, 0);
    // rust: let conductor = BlockPos::new(1, 1, 0);
    // rust: let past_it = BlockPos::new(2, 1, 0);
    // rust: let gold = w.id("gold_block", &[]);
    // rust: let stone = w.id("stone", &[]);
    // rust: w.set(source, gold);
    // rust: w.set(conductor, stone);
    // rust: let read = |w: &mut World, pos| {
    // rust: w.f.behaviours
    // rust: .best_neighbor_signal(&mut w.level, &mut w.ticks, pos)
}
    // rust: assert_eq!(read(&mut w, beside), 0, "gold gives nothing by itself");

    // A weak signal reaches what touches it, and stops at a conductor.
    // rust: w.level.signals.insert(source, (7, 0, None));
    // rust: assert_eq!(read(&mut w, beside), 7);
    // rust: assert_eq!(read(&mut w, past_it), 0);

    // A direct signal passes through the conductor.
    // rust: w.level.signals.insert(source, (7, 15, None));
    // rust: assert_eq!(read(&mut w, past_it), 15);

    // One side only: `Down` is the direction read by the block above.
    // rust: w.level
    // rust: .signals
    // rust: .insert(source, (9, 0, Some(Direction::Down)));
    // rust: assert_eq!(read(&mut w, above), 9);
    // rust: assert_eq!(read(&mut w, beside), 0);

    // Vanilla's sources go through the same answer untouched.
    // rust: w.level.signals.clear();
    // rust: let redstone = w.id("redstone_block", &[]);
    // rust: w.set(source, redstone);
    // rust: assert_eq!(read(&mut w, beside), 15);
}

a_level_can_answer_for_a_blocks_comparator_output :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 4, "stone");
    // rust: let block = BlockPos::new(0, 1, 0);
    // rust: let comparator = BlockPos::new(1, 1, 0);
    // rust: let after = BlockPos::new(2, 1, 0);
    // A comparator facing west reads the block west of it.
    // rust: let facing_west = w.id("comparator", &[("facing", "west")]);
    // rust: w.set(comparator, facing_west);
    // rust: let read = |w: &mut World| {
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: w.f.behaviours
    // rust: .best_neighbor_signal(&mut w.level, &mut w.ticks, after)
}
    // rust: let gold = w.id("gold_block", &[]);
    // rust: w.level.analog.insert(block, 9);
    // rust: w.set(block, gold);
    // rust: assert_eq!(read(&mut w), 0, "gold has no output of its own");

    // Placing a block that says it has one tells the comparator, as Level.setBlock does.
    // rust: w.level.analog_states.insert(gold);
    // rust: w.set(block, w.id("stone", &[]));
    // rust: w.set(block, gold);
    // rust: assert_eq!(read(&mut w), 9);

    // An output that changes without the block: updateNeighbourForOutputSignal.
    // rust: w.level.analog.insert(block, 4);
    // rust: assert_eq!(read(&mut w), 9, "nothing told the comparator yet");
    // rust: w.f.behaviours
    // rust: .update_neighbour_for_output_signal(&mut w.level, &mut w.ticks, block);
    // rust: assert_eq!(read(&mut w), 4);

    // Behind a conductor, and out of range answers are clamped.
    // rust: let further = BlockPos::new(-1, 1, 0);
    // rust: w.set(block, w.id("stone", &[]));
    // rust: w.level.analog.insert(further, 40);
    // rust: w.set(further, gold);
    // rust: assert_eq!(read(&mut w), 15);
}

sculk_sensor_phases_and_signal :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 6, "stone");
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let sensor = w.id("sculk_sensor", &[]);
    // rust: w.set(pos, sensor);
    // rust: assert!(w.b().sculk_sensor_can_activate(w.get(pos)));
    // rust: w.f.behaviours
    // rust: .sculk_sensor_activate(&mut w.level, &mut w.ticks, pos, 11);
    // rust: assert_eq!(w.prop(pos, "sculk_sensor_phase"), "active");
    // rust: assert_eq!(w.prop(pos, "power"), "11");
    // The sensor powers the block below it from the top.
    // rust: let below = BlockPos::new(0, 0, 0);
    // rust: assert_eq!(
    // rust: w.f.behaviours
    // rust: .best_neighbor_signal(&mut w.level, &mut w.ticks, below),
    // rust: 11,
    // rust: "the block under an active sensor receives its power"
    // rust: );
    // rust: for _ in 0..29 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(pos, "sculk_sensor_phase"), "active");
    // rust: w.tick();
    // rust: assert_eq!(w.prop(pos, "sculk_sensor_phase"), "cooldown");
    // rust: assert_eq!(w.prop(pos, "power"), "0");
    // rust: for _ in 0..10 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(pos, "sculk_sensor_phase"), "inactive");
}

calibrated_sensor_is_active_for_ten_ticks :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 6, "stone");
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let sensor = w.id("calibrated_sculk_sensor", &[("facing", "north")]);
    // rust: w.set(pos, sensor);
    // rust: w.f.behaviours
    // rust: .sculk_sensor_activate(&mut w.level, &mut w.ticks, pos, 4);
    // rust: for _ in 0..9 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(pos, "sculk_sensor_phase"), "active");
    // rust: w.tick();
    // rust: assert_eq!(w.prop(pos, "sculk_sensor_phase"), "cooldown");
    // The block behind (south) feeds the calibration signal.
    // rust: let source = w.id("redstone_block", &[]);
    // rust: w.set(BlockPos::new(0, 1, 1), source);
    // rust: assert_eq!(
    // rust: w.f.behaviours
    // rust: .calibrated_back_signal(&mut w.level, &mut w.ticks, pos),
    // rust: 15
    // rust: );
}

sculk_charge_spreads_veins_and_sculk :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 12, "stone");
    // rust: w.floor(-1, 12, "stone");
    // rust: let origin = BlockPos::new(0, 1, 0);
    // rust: let catalyst = w.id("sculk_catalyst", &[]);
    // rust: w.put(origin, catalyst);
    // rust: let mut spreader = sculk::SculkSpreader::default();
    // rust: spreader.add_cursors(BlockPos::new(2, 1, 0), 40);
    // rust: assert_eq!(spreader.cursors.len(), 1);
    // rust: for _ in 0..80 {
    // rust: w.f.behaviours.sculk_update_cursors(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: &mut spreader,
    // rust: origin,
    // rust: true,
    // rust: );
}
    // rust: let sculk = w.id("sculk", &[]);
    // rust: let found = (-12..=12)
    // rust: .flat_map(|x| (-12..=12).map(move |z| BlockPos::new(x, 0, z)))
    // rust: .filter(|p| w.get(*p) == sculk)
    // rust: .count();
    // rust: assert!(found > 0, "the charge turned stone into sculk");
    // rust: assert!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, LevelEvent::LevelEvent { id: 3006, .. })),
    // rust: "charge particles are reported"
    // rust: );
}

shrieker_responds_when_the_shriek_ends :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 6, "stone");
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let shrieker = w.id("sculk_shrieker", &[("can_summon", "true")]);
    // rust: w.set(pos, shrieker);
    // rust: w.f.behaviours
    // rust: .sculk_shrieker_shriek(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(w.prop(pos, "shrieking"), "true");
    // rust: for _ in 0..89 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(pos, "shrieking"), "true");
    // rust: w.tick();
    // rust: assert_eq!(w.prop(pos, "shrieking"), "false");
    // rust: assert!(w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::BlockEvent {
    // rust: kind: "shrieker_respond",
    // rust: ..
}
    // rust: )));
}

catalyst_bloom_lasts_eight_ticks :: proc() {
}
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let catalyst = w.id("sculk_catalyst", &[]);
    // rust: w.set(pos, catalyst);
    // rust: w.f.behaviours
    // rust: .sculk_catalyst_bloom(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(w.prop(pos, "bloom"), "true");
    // rust: for _ in 0..7 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(pos, "bloom"), "true");
    // rust: w.tick();
    // rust: assert_eq!(w.prop(pos, "bloom"), "false");
}

placing_and_breaking_report_the_affected_state :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 4, "stone");
    // rust: let wool = w.id("white_wool", &[]);
    // rust: let placed = w.place(
    // rust: "white_wool",
    // rust: BlockPos::new(0, 0, 0),
    // rust: Direction::Up,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: );
    // rust: assert!(matches!(placed, PlaceOutcome::Placed { .. }));
    // rust: assert!(w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::GameEvent { event: "minecraft:block_place", state: Some(s), .. } if *s == wool
    // rust: )));
    // rust: w.level.events.clear();
    // rust: w.f.behaviours
    // rust: .destroy_block(&mut w.level, &mut w.ticks, BlockPos::new(0, 1, 0), false);
    // rust: assert!(w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::GameEvent { event: "minecraft:block_destroy", state: Some(s), .. } if *s == wool
    // rust: )));
}

dispenser_buckets_pick_up_and_empty :: proc() {
}
    // rust: let mut w = world!();
    // rust: let at = BlockPos::new(0, 10, 0);
    // A dispenser has no hit result: nothing beside to try.
    // rust: let empty = |w: &mut World, content, sound: &str, creative| {
    // rust: w.f.behaviours
    // rust: .bucket_empty(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: at,
    // rust: None,
    // rust: content,
    // rust: sound,
    // rust: false,
    // rust: creative,
    // rust: )
    // rust: .is_some()
}
    // rust: let water = w.id("water", &[("level", "0")]);
    // rust: w.put(at, water);
    // rust: let picked = w.b().bucket_pickup(&mut w.level, &mut w.ticks, at, false);
    // rust: assert_eq!(picked, Some("minecraft:water_bucket"));
    // rust: assert_eq!(w.get(at), w.b().air());
    // Flowing water gives nothing.
    // rust: let flowing = w.id("water", &[("level", "3")]);
    // rust: w.put(at, flowing);
    // rust: assert_eq!(
    // rust: w.b().bucket_pickup(&mut w.level, &mut w.ticks, at, false),
    // rust: None
    // rust: );
    // A waterlogged slab is drained and stays a slab.
    // rust: let slab = w.id("oak_slab", &[("waterlogged", "true")]);
    // rust: w.put(at, slab);
    // rust: assert_eq!(
    // rust: w.b().bucket_pickup(&mut w.level, &mut w.ticks, at, false),
    // rust: Some("minecraft:water_bucket")
    // rust: );
    // rust: assert_eq!(w.prop(at, "waterlogged"), "false");
    // Powder snow comes up as its bucket.
    // rust: let snow = w.id("powder_snow", &[]);
    // rust: w.put(at, snow);
    // rust: assert_eq!(
    // rust: w.b().bucket_pickup(&mut w.level, &mut w.ticks, at, false),
    // rust: Some("minecraft:powder_snow_bucket")
    // rust: );
    // A barrier only a creative player fills or drains.
    // rust: let barrier = w.id("barrier", &[]);
    // rust: w.put(at, barrier);
    // rust: let sound = "minecraft:item.bucket.empty";
    // rust: let content = BucketContent::Fluid(crate::fluid::FluidKind::Water);
    // rust: assert!(!empty(&mut w, content, sound, false));
    // rust: assert_eq!(w.prop(at, "waterlogged"), "false");
    // rust: assert!(empty(&mut w, content, sound, true));
    // rust: assert_eq!(w.prop(at, "waterlogged"), "true");
    // rust: assert_eq!(
    // rust: w.b().bucket_pickup(&mut w.level, &mut w.ticks, at, false),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: w.b().bucket_pickup(&mut w.level, &mut w.ticks, at, true),
    // rust: Some("minecraft:water_bucket")
    // rust: );
    // rust: assert_eq!(w.prop(at, "waterlogged"), "false");
    // Emptying water into air makes a source; stone refuses.
    // rust: let air = w.b().air();
    // rust: w.put(at, air);
    // rust: assert!(empty(&mut w, content, sound, false));
    // rust: assert_eq!(w.name(at), "water[level=0]");
    // rust: let stone = w.id("stone", &[]);
    // rust: w.put(at, stone);
    // rust: assert!(!empty(&mut w, content, sound, false));
    // Water fills a waterloggable slab instead of replacing it.
    // rust: let dry = w.id("oak_slab", &[]);
    // rust: w.put(at, dry);
    // rust: assert!(empty(&mut w, content, sound, false));
    // rust: assert_eq!(w.prop(at, "waterlogged"), "true");
    // Powder snow only goes into empty space.
    // rust: let air = w.b().air();
    // rust: w.put(at, air);
    // rust: assert!(empty(
    // rust: &mut w,
    // rust: BucketContent::Powder,
    // rust: "minecraft:item.bucket.empty_powder_snow",
    // rust: false
    // rust: ));
    // rust: assert_eq!(w.name(at), "powder_snow[]");
}

a_bucket_replaces_a_bubble_column_and_breaks_a_flower :: proc() {
}
    // rust: let mut w = world!();
    // rust: let at = BlockPos::new(0, 10, 0);
    // rust: let sound = "minecraft:item.bucket.empty";
    // rust: let water = BucketContent::Fluid(crate::fluid::FluidKind::Water);
    // rust: let pour = |w: &mut World| {
    // rust: w.f.behaviours.bucket_empty(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: at,
    // rust: None,
    // rust: water,
    // rust: sound,
    // rust: false,
    // rust: false,
    // rust: )
}
    // rust: let broke = |w: &World| {
    // rust: w.level.events.iter().any(|e| {
    // rust: matches!(
    // rust: e,
    // rust: LevelEvent::GameEvent {
    // rust: event: "minecraft:block_destroy",
    // rust: ..
    // rust: } | LevelEvent::LevelEvent { id: 2001, .. }
    // rust: )
    // rust: })
}
    // `BlockState.liquid()` is true: the column is replaced, not broken.
    // rust: w.put(at, w.id("bubble_column", &[("drag", "true")]));
    // rust: w.level.events.clear();
    // rust: assert_eq!(pour(&mut w), Some(at));
    // rust: assert_eq!(w.name(at), "water[level=0]");
    // rust: assert!(!broke(&w), "a bubble column is liquid()");
    // A replaceable plant is not `liquid()`: the bucket breaks it first.
    // rust: w.put(at, w.id("dandelion", &[]));
    // rust: w.level.events.clear();
    // rust: assert_eq!(pour(&mut w), Some(at));
    // rust: assert_eq!(w.name(at), "water[level=0]");
    // rust: assert!(broke(&w), "a flower is broken before the water goes in");
}

clicked_bucket_pours_beside_a_refusing_block :: proc() {
}
    // rust: let mut w = world!();
    // rust: let at = BlockPos::new(0, 10, 0);
    // rust: let above = BlockPos::new(0, 11, 0);
    // rust: let sound = "minecraft:item.bucket.empty";
    // rust: let content = BucketContent::Fluid(crate::fluid::FluidKind::Water);
    // rust: let air = w.b().air();
    // rust: let click = |w: &mut World, sneaking: bool| {
    // rust: w.f.behaviours.bucket_empty(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: at,
    // rust: Some(above),
    // rust: content,
    // rust: sound,
    // rust: sneaking,
    // rust: false,
    // rust: )
}
    // Sneak-clicking a slab pours beside it, where Shift no longer counts.
    // rust: let slab = w.id("oak_slab", &[]);
    // rust: w.put(at, slab);
    // rust: assert_eq!(click(&mut w, true), Some(above));
    // rust: assert_eq!(w.prop(at, "waterlogged"), "false");
    // rust: assert_eq!(w.name(above), "water[level=0]");
    // A double slab holds no water: the click fills the block beside it.
    // rust: w.put(above, air);
    // rust: let double = w.id("oak_slab", &[("type", "double")]);
    // rust: w.put(at, double);
    // rust: assert_eq!(click(&mut w, false), Some(above));
    // rust: assert_eq!(w.prop(at, "type"), "double");
    // rust: assert_eq!(w.name(above), "water[level=0]");
    // Both refusing empties nothing.
    // rust: let stone = w.id("stone", &[]);
    // rust: w.put(above, stone);
    // rust: assert_eq!(click(&mut w, false), None);
    // rust: assert_eq!(w.prop(at, "type"), "double");
    // rust: assert_eq!(w.get(above), stone);
}

creaking_heart_follows_its_logs_and_the_night :: proc() {
}
    // rust: let mut w = world!();
    // rust: let heart_at = BlockPos::new(0, 10, 0);
    // rust: let log = |w: &World, axis: &str| w.id("pale_oak_log", &[("axis", axis)]);
    // rust: let heart = w.id(
    // rust: "creaking_heart",
    // rust: &[("axis", "y"), ("creaking_heart_state", "uprooted")],
    // rust: );
    // rust: let (below, above) = (BlockPos::new(0, 9, 0), BlockPos::new(0, 11, 0));
    // rust: w.put(heart_at, heart);
    // rust: w.put(below, log(&w, "y"));
    // A log along another axis does not count.
    // rust: w.put(above, log(&w, "x"));
    // rust: assert!(
    // rust: !w.b()
    // rust: .creaking_heart_has_logs(&mut w.level, &mut w.ticks, heart_at, heart)
    // rust: );
    // Day: a log update wakes the uprooted heart to dormant.
    // rust: let up = log(&w, "y");
    // rust: w.set(above, up);
    // rust: for _ in 0..3 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(heart_at, "creaking_heart_state"), "dormant");
    // Night: the same trunk wakes a fresh heart up.
    // rust: w.level.day_time = 14000;
    // rust: w.put(heart_at, heart);
    // rust: w.put(above, w.b().air());
    // rust: w.set(above, up);
    // rust: for _ in 0..3 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(heart_at, "creaking_heart_state"), "awake");
    // Placed without logs it stays uprooted.
    // rust: w.put(above, w.b().air());
    // rust: w.put(heart_at, heart);
    // rust: let air = w.b().air();
    // rust: w.set(above, air);
    // rust: for _ in 0..3 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(heart_at, "creaking_heart_state"), "uprooted");
}

player_breaks_fire_with_extinguish_not_generic_break_event :: proc() {
}
    // rust: for name in ["fire", "soul_fire", "white_wool"] {
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let support = w.id("soul_soil", &[]);
    // rust: w.put(BlockPos::new(0, 0, 0), support);
    // rust: let state = w.id(name, &[]);
    // rust: w.put(pos, state);
    // rust: w.level.events.clear();
    // rust: assert!(
    // rust: w.f.behaviours
    // rust: .player_destroy_block(&mut w.level, &mut w.ticks, pos, false, true)
    // rust: );
    // rust: let is_fire = name != "white_wool";
    // rust: assert_eq!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e,LevelEvent::LevelEvent {id:1009,pos:p,..} if *p==pos)),
    // rust: is_fire,
    // rust: "extinguish for {name}"
    // rust: );
    // rust: assert_eq!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e,LevelEvent::LevelEvent {id:2001,pos:p,..} if *p==pos)),
    // rust: !is_fire,
    // rust: "generic break for {name}"
    // rust: );
    // rust: assert_eq!(w.get(pos), w.b().air());
}
}

big_dripleaf_tilts_under_an_entity_standing_on_it :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 2, "clay");
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let leaf = w.id("big_dripleaf", &[("facing", "north")]);
    // rust: w.put(pos, leaf);
    // rust: let stand = |w: &mut World, on_ground: bool, feet: f64| {
    // rust: w.f.behaviours
    // rust: .entity_on_big_dripleaf(&mut w.level, &mut w.ticks, pos, on_ground, feet);
}
    // canEntityTilt: in the air, or with its feet at or under 0.6875, nothing.
    // rust: stand(&mut w, false, 1.9375);
    // rust: stand(&mut w, true, 1.6875);
    // rust: assert_eq!(w.prop(pos, "tilt"), "none");
    // Standing on the leaf's top (15/16): UNSTABLE, then PARTIAL and FULL
    // 10 ticks apart, and back to NONE 100 ticks later.
    // rust: stand(&mut w, true, 1.9375);
    // rust: assert_eq!(w.prop(pos, "tilt"), "unstable");
    // rust: for _ in 0..10 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(pos, "tilt"), "partial");
    // rust: for _ in 0..10 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(pos, "tilt"), "full");
    // A tilted leaf doesn't restart under the entity.
    // rust: stand(&mut w, true, 1.9375);
    // rust: assert_eq!(w.prop(pos, "tilt"), "full");
    // rust: for _ in 0..100 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.prop(pos, "tilt"), "none");
    // A powered leaf doesn't tilt.
    // rust: let power = w.id("redstone_block", &[]);
    // rust: w.put(BlockPos::new(1, 1, 0), power);
    // rust: stand(&mut w, true, 1.9375);
    // rust: assert_eq!(w.prop(pos, "tilt"), "none");
}

using_storage_and_interactable_blocks_succeeds :: proc() {
}
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let cases: &[(&str, &[(&str, &str)])] = &[
    // rust: ("chest", &[("facing", "north"), ("type", "single")]),
    // rust: ("trapped_chest", &[("facing", "north"), ("type", "single")]),
    // rust: ("barrel", &[("facing", "up")]),
    // rust: ("ender_chest", &[("facing", "north")]),
    // rust: ("shulker_box", &[("facing", "up")]),
    // rust: ("dispenser", &[("facing", "north")]),
    // rust: ("dropper", &[("facing", "north")]),
    // rust: ("hopper", &[("facing", "down")]),
    // rust: ("crafter", &[("orientation", "north_up")]),
    // rust: ("furnace", &[("facing", "north")]),
    // rust: ("blast_furnace", &[("facing", "north")]),
    // rust: ("smoker", &[("facing", "north")]),
    // rust: ("brewing_stand", &[]),
    // rust: ("beacon", &[]),
    // rust: ("decorated_pot", &[]),
    // rust: ("jukebox", &[("has_record", "true")]),
    // rust: ];
    // rust: for &(name, props) in cases {
    // rust: w.put(pos, w.id(name, props));
    // rust: assert_eq!(
    // rust: w.use_block(pos),
    // rust: InteractionResult::Success,
    // rust: "{name} should succeed (client swing)"
    // rust: );
}
    // rust: w.put(pos, w.id("jukebox", &[("has_record", "false")]));
    // rust: assert_eq!(
    // rust: w.use_block(pos),
    // rust: InteractionResult::Pass,
    // rust: "an empty jukebox passes"
    // rust: );
}

open_shulker_box_supports_only_through_its_base_plate :: proc() {
}
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: for facing in Direction::ALL {
    // rust: let prop = match facing {
    // rust: Direction::Down => "down",
    // rust: Direction::Up => "up",
    // rust: Direction::North => "north",
    // rust: Direction::South => "south",
    // rust: Direction::West => "west",
    // rust: Direction::East => "east",
}
    // rust: w.put(pos, w.id("shulker_box", &[("facing", prop)]));
    // rust: w.level.shulker_closed.remove(&pos);
        // A shut box, and a box whose block entity the level doesn't keep,
        // both read as a closed full cube.
    // rust: {
    // rust: let sim = w.b().sim(&mut w.level, &mut w.ticks);
    // rust: assert!(
    // rust: sim.sturdy(pos, Direction::Up),
    // rust: "closed box facing {facing:?}"
    // rust: );
    // rust: assert!(
    // rust: sim.sturdy(pos, Direction::Down),
    // rust: "closed box facing {facing:?}"
    // rust: );
    // rust: assert!(
    // rust: sim.can_support_rigid_block(pos),
    // rust: "closed box facing {facing:?}"
    // rust: );
    // rust: assert!(
    // rust: sim.can_support_center(pos, Direction::Up),
    // rust: "closed box facing {facing:?}"
    // rust: );
}

    // rust: w.level.shulker_closed.insert(pos, false);
    // rust: let plate = facing.opposite();
    // rust: let sim = w.b().sim(&mut w.level, &mut w.ticks);
    // rust: assert!(
    // rust: sim.sturdy(pos, plate),
    // rust: "open box facing {facing:?} keeps its base plate"
    // rust: );
    // rust: assert!(
    // rust: !sim.sturdy(pos, facing),
    // rust: "open box facing {facing:?} has no support on its lid side"
    // rust: );
    // rust: assert_eq!(
    // rust: sim.can_support_rigid_block(pos),
    // rust: plate == Direction::Up,
    // rust: "open box facing {facing:?}"
    // rust: );
    // rust: assert!(
    // rust: sim.can_support_center(pos, plate),
    // rust: "open box facing {facing:?} base plate"
    // rust: );
    // rust: assert!(
    // rust: !sim.can_support_center(pos, facing),
    // rust: "open box facing {facing:?} lid side"
    // rust: );
}
}

torch_survives_on_a_box_opening_down_but_not_on_an_open_lid :: proc() {
}
    // rust: let mut w = world!();
    // rust: let box_pos = BlockPos::new(0, 1, 0);
    // rust: let torch_pos = BlockPos::new(0, 2, 0);
    // rust: w.put(torch_pos, w.id("torch", &[]));
    // rust: let torch = w.get(torch_pos);
    // Facing up, the lid is the top face: open, the torch above loses support.
    // rust: w.put(box_pos, w.id("shulker_box", &[("facing", "up")]));
    // rust: assert!(
    // rust: w.b()
    // rust: .sim(&mut w.level, &mut w.ticks)
    // rust: .can_survive(torch, torch_pos),
    // rust: "a torch stands on a closed box"
    // rust: );
    // rust: w.level.shulker_closed.insert(box_pos, false);
    // rust: assert!(
    // rust: !w.b()
    // rust: .sim(&mut w.level, &mut w.ticks)
    // rust: .can_survive(torch, torch_pos),
    // rust: "an open lid doesn't hold a torch"
    // rust: );
    // Facing down, the base plate is the top face, so the torch stands.
    // rust: w.put(box_pos, w.id("shulker_box", &[("facing", "down")]));
    // rust: assert!(
    // rust: w.b()
    // rust: .sim(&mut w.level, &mut w.ticks)
    // rust: .can_survive(torch, torch_pos),
    // rust: "the base plate of a box opening down still holds a torch"
    // rust: );
}

creative_breaking_piston_head_does_not_drop_piston :: proc() {
}
    // rust: for (piston_name, head_type) in [("piston", "normal"), ("sticky_piston", "sticky")] {
    // rust: let mut w = world!();
    // rust: let base_pos = BlockPos::new(0, 1, 0);
    // rust: let head_pos = BlockPos::new(1, 1, 0);
    // rust: let base = w.id(piston_name, &[("extended", "true"), ("facing", "east")]);
    // rust: let head = w.id(
    // rust: "piston_head",
    // rust: &[("type", head_type), ("facing", "east"), ("short", "false")],
    // rust: );
    // rust: w.put(base_pos, base);
    // rust: w.put(head_pos, head);
    // rust: w.level.events.clear();

        // Breaking the head in creative mode. Destroying the base first makes the
        // head's shape update remove it, so its own removeBlock finds air.
    // rust: w.f.behaviours
    // rust: .player_destroy_block(&mut w.level, &mut w.ticks, head_pos, true, true);

        // Both head and base must be removed:
    // rust: assert_eq!(w.get(head_pos), w.b().air(), "head should become air");
    // rust: assert_eq!(w.get(base_pos), w.b().air(), "base should become air");

        // Must NOT drop the base: the head's own removal (its shape update) drops
        // its empty loot, as vanilla's updateOrDestroy does.
    // rust: assert!(
    // rust: !w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, LevelEvent::DropResources { pos, .. } if *pos == base_pos)),
    // rust: "creative mode breaking {head_type} piston head must not drop the base piston"
    // rust: );
}
}

survival_breaking_piston_head_drops_piston :: proc() {
}
    // rust: for (piston_name, head_type) in [("piston", "normal"), ("sticky_piston", "sticky")] {
    // rust: let mut w = world!();
    // rust: let base_pos = BlockPos::new(0, 1, 0);
    // rust: let head_pos = BlockPos::new(1, 1, 0);
    // rust: let base = w.id(piston_name, &[("extended", "true"), ("facing", "east")]);
    // rust: let head = w.id(
    // rust: "piston_head",
    // rust: &[("type", head_type), ("facing", "east"), ("short", "false")],
    // rust: );
    // rust: w.put(base_pos, base);
    // rust: w.put(head_pos, head);
    // rust: w.level.events.clear();

        // Breaking the head in survival mode:
    // rust: assert!(
    // rust: w.f.behaviours
    // rust: .player_destroy_block(&mut w.level, &mut w.ticks, head_pos, false, true),
    // rust: "head should be destroyed"
    // rust: );

        // Both head and base must be removed:
    // rust: assert_eq!(w.get(head_pos), w.b().air(), "head should become air");
    // rust: assert_eq!(w.get(base_pos), w.b().air(), "base should become air");

        // Must drop the base piston at base_pos:
    // rust: assert!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, LevelEvent::DropResources { pos, .. } if *pos == base_pos)),
    // rust: "survival mode breaking {head_type} piston head must drop base piston"
    // rust: );
}
}

// A lever on the back of a piston stays through extend and retract.
lever_on_piston_back_survives_extend_and_retract :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: for kind in ["piston", "sticky_piston"] {
    // rust: let piston = w.id(kind, &[("facing", "east")]);
    // rust: let lever = w.id("lever", &[("face", "wall"), ("facing", "west")]);
    // rust: w.set(BlockPos::new(0, 1, 0), piston);
    // rust: w.set(BlockPos::new(-1, 1, 0), lever);
    // rust: let on = w.b().table.set_bool(lever, w.b().props.powered, true);
    // rust: w.set(BlockPos::new(-1, 1, 0), on);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(BlockPos::new(0, 1, 0), "extended"), "true", "{kind}");
    // rust: assert_eq!(
    // rust: w.name(BlockPos::new(-1, 1, 0)),
    // rust: "lever[face=wall,facing=west,powered=true]",
    // rust: "{kind}"
    // rust: );
    // rust: w.set(BlockPos::new(-1, 1, 0), lever);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(
    // rust: w.prop(BlockPos::new(0, 1, 0), "extended"),
    // rust: "false",
    // rust: "{kind}"
    // rust: );
    // rust: assert_eq!(
    // rust: w.name(BlockPos::new(-1, 1, 0)),
    // rust: "lever[face=wall,facing=west,powered=false]",
    // rust: "{kind}"
    // rust: );
}
}

dust_on_a_downward_piston_survives_extend_and_retract :: proc() {
}
    // PistonBaseBlock.triggerEvent writes the retracting base as a
    // `moving_piston` and still updates the neighbours around it, so the wire
    // above the base is asked whether it can survive. Vanilla reads that block
    // through its block entity, whose collision shape holds the extended base;
    // the exported support facts see no block entity and call every face
    // unsupported, which broke the dust (#4728).
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("piston", &[("facing", "down")]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: let wire = w.id("redstone_wire", &[]);
    // rust: let air = w.b().air();
    // rust: let base = BlockPos::new(0, 3, 0);
    // rust: let dust = BlockPos::new(0, 4, 0);
    // rust: w.set(base, piston);
    // rust: w.set(dust, wire);
    // rust: w.set(BlockPos::new(1, 3, 0), power);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(base, "extended"), "true");
    // rust: assert!(
    // rust: w.name(BlockPos::new(0, 2, 0)).starts_with("piston_head"),
    // rust: "the piston pushed its head down"
    // rust: );
    // rust: assert!(
    // rust: w.name(dust).starts_with("redstone_wire"),
    // rust: "the dust stays on the extended piston, got {}",
    // rust: w.name(dust)
    // rust: );
    // rust: w.set(BlockPos::new(1, 3, 0), air);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(base, "extended"), "false");
    // rust: assert!(
    // rust: w.name(dust).starts_with("redstone_wire"),
    // rust: "the dust stays through the retract, got {}",
    // rust: w.name(dust)
    // rust: );
}

a_candle_on_an_uneaten_cake_makes_a_candle_cake :: proc() {
}
    // CakeBlock.useItemOn: any candle on a cake with no bites turns it into the
    // matching unlit candle cake; a bitten cake does not.
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let cake = w.id("cake", &[("bites", "0")]);
    // rust: for (item, block) in [
    // rust: ("minecraft:candle", "candle_cake"),
    // rust: ("minecraft:red_candle", "red_candle_cake"),
    // rust: ] {
    // rust: w.put(pos, cake);
    // rust: assert_eq!(w.use_item(pos, item), InteractionResult::Success);
    // rust: assert_eq!(w.get(pos), w.id(block, &[("lit", "false")]));
}
    // rust: let bitten = w.id("cake", &[("bites", "1")]);
    // rust: w.put(pos, bitten);
    // rust: w.use_item(pos, "minecraft:candle");
    // rust: assert_ne!(w.get(pos), w.id("candle_cake", &[("lit", "false")]));
    // rust: w.put(pos, cake);
    // Anything else answers TRY_WITH_EMPTY_HAND, and ServerPlayerGameMode
    // then calls useWithoutItem with whatever the main hand holds, so a stone
    // eats a slice of the cake instead of adding a candle to it.
    // rust: assert_eq!(
    // rust: w.use_item(pos, "minecraft:stone"),
    // rust: InteractionResult::Success
    // rust: );
    // rust: assert_eq!(w.get(pos), bitten);
}

water_douses_a_lit_campfire_with_the_extinguish_sound :: proc() {
}
    // CampfireBlock.placeLiquid: a lit campfire that takes water goes out
    // and plays GENERIC_EXTINGUISH_FIRE, `entity.generic.extinguish_fire`.
    // rust: let mut w = world!();
    // rust: let at = BlockPos::new(0, 10, 0);
    // rust: w.put(at, w.id("campfire", &[("lit", "true")]));
    // rust: w.level.events.clear();
    // rust: let placed = w.f.behaviours.bucket_empty(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: at,
    // rust: None,
    // rust: BucketContent::Fluid(crate::fluid::FluidKind::Water),
    // rust: "minecraft:item.bucket.empty",
    // rust: false,
    // rust: false,
    // rust: );
    // rust: assert_eq!(placed, Some(at));
    // rust: assert_eq!(w.prop(at, "lit"), "false");
    // rust: assert_eq!(w.prop(at, "waterlogged"), "true");
    // rust: assert!(
    // rust: w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::Sound { sound, .. } if &**sound == "minecraft:entity.generic.extinguish_fire"
    // rust: )),
    // rust: "the extinguish sound"
    // rust: );
}

an_empty_hand_snuffs_a_lit_candle :: proc() {
}
    // CandleBlock.useItemOn: an empty hand on a lit candle (`mayBuild`) runs
    // AbstractCandleBlock.extinguish: unlit, the wick smoke, the extinguish
    // sound, the block-change game event, and nothing drops.
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let lit = w.id("candle", &[("lit", "true")]);
    // rust: let unlit = w.id("candle", &[("lit", "false")]);
    // rust: w.put(pos, lit);
    // rust: w.level.events.clear();
    // rust: assert_eq!(w.use_empty_hand(pos), InteractionResult::Success);
    // rust: assert_eq!(w.get(pos), unlit);
    // rust: assert!(
    // rust: w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::Sound { sound, .. } if &**sound == "minecraft:block.candle.extinguish"
    // rust: )),
    // rust: "the candle extinguish sound"
    // rust: );
    // rust: assert!(
    // rust: w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::BlockEvent {
    // rust: kind: "candle_smoke",
    // rust: ..
}
    // rust: )),
    // rust: "the wick smoke"
    // rust: );
    // rust: assert!(
    // rust: w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::GameEvent {
    // rust: event: "minecraft:block_change",
    // rust: ..
}
    // rust: )),
    // rust: "the block-change game event"
    // rust: );
    // rust: assert!(
    // rust: !w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, LevelEvent::DropResources { .. })),
    // rust: "snuffing drops nothing"
    // rust: );
    // A held item, or a candle that is already out, leaves it alone.
    // rust: w.put(pos, lit);
    // rust: assert_eq!(w.use_item(pos, "minecraft:stick"), InteractionResult::Pass);
    // rust: assert_eq!(w.get(pos), lit);
    // rust: w.put(pos, unlit);
    // rust: assert_eq!(w.use_empty_hand(pos), InteractionResult::Pass);
}

an_empty_hand_on_a_lit_candle_cake_eats_it_or_snuffs_its_candle :: proc() {
}
    // CandleCakeBlock.useWithoutItem below the candle eats the cake body
    // (CakeBlock.eat on a plain cake), so one bite is gone and the candle with
    // it; on the candle above half a block, CandleCakeBlock.useItemOn snuffs it
    // (`candleHit`) and the cake stays; flint and steel passes, so the cake is
    // not eaten.
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let lit = w.id("candle_cake", &[("lit", "true")]);
    // rust: w.put(pos, lit);
    // rust: assert_eq!(w.use_empty_hand(pos), InteractionResult::Success);
    // rust: assert_eq!(w.get(pos), w.id("cake", &[("bites", "1")]));
    // rust: w.put(pos, lit);
    // rust: w.level.events.clear();
    // rust: assert_eq!(w.use_empty_hand_at(pos, 0.75), InteractionResult::Success);
    // rust: assert_eq!(w.get(pos), w.id("candle_cake", &[("lit", "false")]));
    // rust: assert!(
    // rust: w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::Sound { sound, .. } if &**sound == "minecraft:block.candle.extinguish"
    // rust: )),
    // rust: "the candle extinguish sound"
    // rust: );
    // rust: w.put(pos, lit);
    // rust: assert_eq!(
    // rust: w.use_item(pos, "minecraft:flint_and_steel"),
    // rust: InteractionResult::Pass
    // rust: );
    // rust: assert_eq!(w.get(pos), lit);
}

flowers_and_saplings_can_be_placed_in_flower_pots :: proc() {
}
    // FlowerPotBlock.useItemOn: placing a plant in an empty pot pots it.
    // Clicking a potted plant with another plant CONSUMEs without change.
    // Clicking a potted plant with an empty hand takes the plant out (useWithoutItem).
    // Clicking an empty pot with empty hand or non-plant item CONSUMEs.
    // rust: let mut w = world!();
    // rust: let pos = BlockPos::new(0, 1, 0);
    // rust: let empty_pot = w.id("flower_pot", &[]);
    // rust: for (item, potted_block) in [
    // rust: ("minecraft:poppy", "potted_poppy"),
    // rust: ("minecraft:dandelion", "potted_dandelion"),
    // rust: ("minecraft:oak_sapling", "potted_oak_sapling"),
    // rust: ("minecraft:cactus", "potted_cactus"),
    // rust: ("minecraft:red_mushroom", "potted_red_mushroom"),
    // rust: ("minecraft:fern", "potted_fern"),
    // rust: ] {
    // rust: w.put(pos, empty_pot);
    // rust: assert_eq!(w.use_item(pos, item), InteractionResult::Success);
    // rust: assert_eq!(w.get(pos), w.id(potted_block, &[]));

        // Right-clicking a potted plant with another flower does nothing (CONSUME).
    // rust: assert_eq!(
    // rust: w.use_item(pos, "minecraft:poppy"),
    // rust: InteractionResult::Consume
    // rust: );
    // rust: assert_eq!(w.get(pos), w.id(potted_block, &[]));

        // Right-clicking a potted plant with empty hand extracts the plant.
    // rust: assert_eq!(w.use_block(pos), InteractionResult::Success);
    // rust: assert_eq!(w.get(pos), empty_pot);
}

    // Right-clicking an empty flower pot with an empty hand does nothing (CONSUME, no swing).
    // rust: w.put(pos, empty_pot);
    // rust: let empty_click = w.use_block(pos);
    // rust: assert_eq!(empty_click, InteractionResult::Consume);
    // rust: assert!(empty_click.consumes_action());
    // rust: assert!(!empty_click.should_swing());
    // rust: assert_eq!(w.get(pos), empty_pot);

    // Right-clicking an empty flower pot with a non-plant item does nothing (CONSUME, no swing).
    // rust: let non_plant_click = w.use_item(pos, "minecraft:stone");
    // rust: assert_eq!(non_plant_click, InteractionResult::Consume);
    // rust: assert!(non_plant_click.consumes_action());
    // rust: assert!(!non_plant_click.should_swing());
    // rust: assert_eq!(w.get(pos), empty_pot);
}

update_shape_hook_can_answer_for_the_block :: proc() {
}
//     use horizon_core::ticks::TickPriority;
//     use std::cell::RefCell;

Shaper :: struct {
    inner: TestLevel,
    b: ^'static Behaviours,
    fence: BlockId,
        // The state the hook answers for a fence, if any.
    answer: Maybe(BlockStateId),
    seen: RefCell<Vec<(BlockPos,
        // The `state` each call was given.
    states: RefCell<[dynamic]BlockStateId>,
}
    // rust: impl LevelAccess for Shaper {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.block_state(pos)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.set_raw(pos, state)
}
is_loaded :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.is_loaded(pos)
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.random()
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.game_time()
}
emit :: proc(self: ^Self, event: LevelEvent) {
}
    // rust: self.inner.emit(event);
}
    // rust: fn before_update_shape(
    // rust: &self,
    // rust: ticks: &mut Ticks,
    // rust: pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: direction: Direction,
    // rust: neighbour_pos: BlockPos,
    // rust: neighbour: BlockStateId,
    // rust: new: &mut Option<BlockStateId>,
    // rust: ) {
            // A piston landing a block asks before the block is in the world.
    // rust: assert_eq!(self.block_state(neighbour_pos), neighbour);
    // rust: self.seen.borrow_mut().push((pos, direction));
    // rust: self.states.borrow_mut().push(state);
    // rust: if let Some(answer) = self.answer
    // rust: && self.b.block(state) == self.fence
    // rust: {
    // rust: *new = Some(answer);
    // rust: let time = self.game_time();
    // rust: ticks.schedule_block(time, pos, self.fence, 2, TickPriority::Normal);
}
}
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let b = &f.behaviours;
    // rust: let fence = f.registry.default_state("minecraft:oak_fence").unwrap();
    // rust: let with = |key: &str| {
    // rust: let mut s = f.registry.state(fence).unwrap().clone();
    // rust: s.properties.insert(key.into(), "true".into());
    // rust: f.registry.resolve(&s).unwrap()
}
    // rust: let stone = f.registry.default_state("minecraft:stone").unwrap();
    // rust: let mut level = Shaper {
    // rust: inner: TestLevel::new(b),
    // rust: b,
    // rust: fence: b.block(fence),
    // rust: answer: Some(with("west")),
    // rust: seen: RefCell::new(Vec::new()),
    // rust: states: RefCell::new(Vec::new()),
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: ticks.add_empty_chunk(ChunkPos::new(0, 0)).unwrap();
    // rust: let pos = BlockPos::new(1, 1, 1);
    // rust: level.set_raw(pos, fence);
    // Stone placed east of the fence: the hook's state, not the fence's own,
    // and the tick the hook scheduled.
    // rust: b.set_block(
    // rust: &mut level,
    // rust: &mut ticks,
    // rust: BlockPos::new(2, 1, 1),
    // rust: stone,
    // rust: flags::UPDATE_ALL,
    // rust: );
    // rust: assert!(level.seen.borrow().contains(&(pos, Direction::East)));
    // rust: assert_eq!(level.block_state(pos), with("west"));
    // rust: assert!(ticks.has_block_tick(pos, b.block(fence)));
    // Fitted to all its neighbours (as post-processing or a piston does), the
    // fence is asked once per direction.
    // rust: level.seen.borrow_mut().clear();
    // rust: assert_eq!(
    // rust: b.update_from_neighbour_shapes(&mut level, &mut ticks, pos, with("west")),
    // rust: with("west")
    // rust: );
    // rust: assert_eq!(level.seen.borrow().len(), 6);
    // Fitted into an empty spot (a piston landing it), every call still got
    // the incoming state first, not the air at `pos`.
    // rust: level.seen.borrow_mut().clear();
    // rust: level.states.borrow_mut().clear();
    // rust: level.set_raw(pos, b.air());
    // rust: assert_eq!(
    // rust: b.update_from_neighbour_shapes(&mut level, &mut ticks, pos, fence),
    // rust: with("west")
    // rust: );
    // rust: assert_eq!(level.seen.borrow().len(), 6);
    // rust: assert_eq!(level.states.borrow()[0], fence);
    // A made-up id is ignored, not trusted.
    // rust: level.answer = Some(BlockStateId(u32::MAX));
    // rust: level.set_raw(pos, fence);
    // rust: b.set_block(
    // rust: &mut level,
    // rust: &mut ticks,
    // rust: BlockPos::new(2, 1, 1),
    // rust: stone,
    // rust: flags::UPDATE_ALL,
    // rust: );
    // rust: assert_ne!(level.block_state(pos), BlockStateId(u32::MAX));
    // rust: level.answer = Some(with("west"));
    // Without an answer the fence connects as vanilla's does.
    // rust: level.answer = None;
    // rust: level.set_raw(pos, fence);
    // rust: b.set_block(
    // rust: &mut level,
    // rust: &mut ticks,
    // rust: BlockPos::new(1, 1, 2),
    // rust: stone,
    // rust: flags::UPDATE_ALL,
    // rust: );
    // rust: assert_eq!(level.block_state(pos), with("south"));
    // Air breaks the fence, with its drops.
    // rust: level.answer = Some(b.air());
    // rust: level.set_raw(pos, fence);
    // rust: b.set_block(
    // rust: &mut level,
    // rust: &mut ticks,
    // rust: BlockPos::new(1, 1, 0),
    // rust: stone,
    // rust: flags::UPDATE_ALL,
    // rust: );
    // rust: assert_eq!(level.block_state(pos), b.air());
    // rust: assert!(level.inner.events.iter().any(
    // rust: |e| matches!(e, LevelEvent::DropResources { pos: p, state } if *p == pos && *state == fence)
    // rust: ));
}

the_level_chooses_the_state_a_block_is_placed_in :: proc() {
}
//     use crate::fluid::{FluidKind, FluidState};
//     use horizon_core::geometry::Vec3;
//     use std::cell::RefCell;

    // What one call of the hook was asked.
Asked :: struct {
    state: BlockStateId,
    pos: BlockPos,
    clicked: BlockPos,
    face: Direction,
    item: string,
    sneaking: bool,
    replace_clicked: bool,
    fluid: FluidState,
}
Placer :: struct {
    inner: TestLevel,
    b: ^'static Behaviours,
        // The block the hook answers for.
    block: BlockId,
        // What it answers for that block.
    answer: Maybe(Option<BlockStateId)>,
    asked: RefCell<[dynamic]Asked>,
}
    // rust: impl LevelAccess for Placer {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.block_state(pos)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.set_raw(pos, state)
}
is_loaded :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.is_loaded(pos)
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.random()
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.game_time()
}
emit :: proc(self: ^Self, event: LevelEvent) {
}
    // rust: self.inner.emit(event);
}
    // rust: fn before_state_for_placement(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: context: &PlacementContext,
    // rust: fluid: FluidState,
    // rust: answer: &mut Option<Option<BlockStateId>>,
    // rust: ) {
    // rust: self.asked.borrow_mut().push(Asked {
    // rust: state,
    // rust: pos: context.pos,
    // rust: clicked: context.hit_pos,
    // rust: face: context.face,
    // rust: item: context.item.clone(),
    // rust: sneaking: context.sneaking,
    // rust: replace_clicked: context.replace_clicked,
    // rust: fluid,
    // rust: });
    // rust: if self.b.block(state) == self.block {
    // rust: *answer = self.answer;
}
}
}
    // One call of the hook, as owned values (the level is mutable again after).
    // rust: fn asked(
    // rust: level: &Placer,
    // rust: ) -> (
    // rust: BlockStateId,
    // rust: BlockPos,
    // rust: BlockPos,
    // rust: Direction,
    // rust: String,
    // rust: bool,
    // rust: bool,
    // rust: FluidState,
    // rust: ) {
    // rust: let asked = level.asked.borrow();
    // rust: let first = &asked[0];
    // rust: (
    // rust: first.state,
    // rust: first.pos,
    // rust: first.clicked,
    // rust: first.face,
    // rust: first.item.clone(),
    // rust: first.sneaking,
    // rust: first.replace_clicked,
    // rust: first.fluid,
    // rust: )
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let b = &f.behaviours;
    // rust: let stone = f.registry.default_state("minecraft:stone").unwrap();
    // rust: let furnace = f.registry.default_state("minecraft:furnace").unwrap();
    // rust: let furnace_block = b.block(furnace);
    // The same block facing another way: what a mod block's hook answers.
    // rust: let facing = |direction: &str| {
    // rust: let mut s = f.registry.state(furnace).unwrap().clone();
    // rust: s.properties.insert("facing".into(), direction.into());
    // rust: f.registry.resolve(&s).unwrap()
}
    // rust: let mut level = Placer {
    // rust: inner: TestLevel::new(b),
    // rust: b,
    // rust: block: furnace_block,
    // rust: answer: Some(Some(facing("east"))),
    // rust: asked: RefCell::new(Vec::new()),
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: ticks.add_empty_chunk(ChunkPos::new(0, 0)).unwrap();
    // rust: let ground = BlockPos::new(0, 0, 0);
    // rust: level.set_raw(ground, stone);
    // Looking south (yaw 0) at the top of the floor, holding a furnace.
    // rust: let mut ctx = PlaceContext {
    // rust: clicked_pos: ground,
    // rust: face: Direction::Up,
    // rust: hit: Vec3::new(0.5, 1.0, 0.5),
    // rust: inside: false,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: sneaking: false,
    // rust: item: "minecraft:furnace".into(),
    // rust: can_use_game_master_blocks: false,
}
    // The hook's state, not the one vanilla's furnace placement computes.
    // rust: assert_eq!(
    // rust: b.state_for_placement(&mut level, &mut ticks, furnace_block, &ctx),
    // rust: Some(facing("east"))
    // rust: );
    // It was asked with the block it decides for, where the block would go
    // (above the stone), the block clicked, the face clicked, the item in
    // hand, and the fluid of the position it goes in (none: dry stone).
    // rust: let (state, pos, clicked, face, item, sneaking, replace_clicked, fluid) = asked(&level);
    // rust: assert_eq!(state, furnace);
    // rust: assert_eq!(pos, BlockPos::new(0, 1, 0));
    // rust: assert_eq!(clicked, ground);
    // rust: assert_eq!(face, Direction::Up);
    // rust: assert_eq!(item, "minecraft:furnace");
    // rust: assert!(!replace_clicked);
    // rust: assert!(!sneaking);
    // rust: assert_eq!(fluid, FluidState::EMPTY);
    // Clicking a block that can be replaced: the block goes into it, and the
    // fluid already there (water) reaches the hook, which a waterlogged block
    // reads. Sneaking reaches it too, as `isSecondaryUseActive`.
    // rust: level.asked.borrow_mut().clear();
    // rust: let water = f.registry.default_state("minecraft:water").unwrap();
    // rust: level.set_raw(BlockPos::new(0, 1, 0), water);
    // rust: ctx.clicked_pos = BlockPos::new(0, 1, 0);
    // rust: ctx.sneaking = true;
    // rust: assert_eq!(
    // rust: b.state_for_placement(&mut level, &mut ticks, furnace_block, &ctx),
    // rust: Some(facing("east"))
    // rust: );
    // rust: let (_, pos, _, _, _, sneaking, replace_clicked, fluid) = asked(&level);
    // rust: assert_eq!(pos, BlockPos::new(0, 1, 0));
    // rust: assert!(replace_clicked);
    // rust: assert!(sneaking);
    // rust: assert_eq!(fluid.kind(), FluidKind::Water);
    // Refused (vanilla's `null` return): there is no state, so the placement
    // fails and the stack is kept.
    // rust: level.answer = Some(None);
    // rust: assert_eq!(
    // rust: b.state_for_placement(&mut level, &mut ticks, furnace_block, &ctx),
    // rust: None
    // rust: );
    // Without an answer the block's own `getStateForPlacement` runs: a furnace
    // placed with yaw 0 faces north, which is its default state.
    // rust: level.answer = None;
    // rust: assert_eq!(
    // rust: b.state_for_placement(&mut level, &mut ticks, furnace_block, &ctx),
    // rust: Some(furnace)
    // rust: );
    // And a block the hook does not answer for is unaffected.
    // rust: let stairs = b.block(f.registry.default_state("minecraft:oak_stairs").unwrap());
    // rust: let vanilla = b.state_for_placement(&mut level, &mut ticks, stairs, &ctx);
    // rust: level.answer = Some(Some(facing("west")));
    // rust: assert_eq!(
    // rust: b.state_for_placement(&mut level, &mut ticks, stairs, &ctx),
    // rust: vanilla
    // rust: );
    // A dispenser places through the same state computation
    // (`ShulkerBoxDispenseBehavior`'s `DirectionalPlaceContext`): it places
    // the hook's state too, with the dispenser's own view of the click.
    // rust: level.answer = Some(Some(facing("east")));
    // rust: level.asked.borrow_mut().clear();
    // rust: let front = BlockPos::new(3, 1, 1);
    // rust: let dispenser = PlaceContext {
    // rust: clicked_pos: front,
    // rust: face: Direction::East,
    // rust: hit: Vec3::new(3.0, 1.0, 1.5),
    // rust: inside: false,
    // rust: yaw: 270.0,
    // rust: pitch: 0.0,
    // rust: sneaking: false,
    // rust: item: "minecraft:furnace".into(),
    // rust: can_use_game_master_blocks: false,
}
    // rust: assert!(b.directional_can_place(&mut level, &mut ticks, &dispenser));
    // rust: let outcome = b.place_block(&mut level, &mut ticks, &dispenser);
    // rust: assert_eq!(
    // rust: outcome,
    // rust: PlaceOutcome::Placed {
    // rust: pos: front,
    // rust: state: facing("east")
}
    // rust: );
    // rust: assert_eq!(level.block_state(front), facing("east"));
    // rust: let (state, pos, _, _, item, _, replace_clicked, _) = asked(&level);
    // rust: assert_eq!(state, furnace);
    // rust: assert_eq!(pos, front);
    // rust: assert_eq!(item, "minecraft:furnace");
    // rust: assert!(replace_clicked, "the front block is air: it is replaced");
    // A made-up id is not trusted, nor is another block's state: the block
    // places as vanilla's would.
    // rust: level.answer = Some(Some(BlockStateId(u32::MAX)));
    // rust: assert_eq!(
    // rust: b.state_for_placement(&mut level, &mut ticks, furnace_block, &ctx),
    // rust: Some(furnace)
    // rust: );
    // rust: level.answer = Some(Some(b.default_of(stairs)));
    // rust: assert_eq!(
    // rust: b.state_for_placement(&mut level, &mut ticks, furnace_block, &ctx),
    // rust: Some(furnace)
    // rust: );
}

survive_hooks_answer_for_the_block :: proc() {
}
//     use std::cell::Cell;

Rules :: struct {
    inner: TestLevel,
    b: ^'static Behaviours,
        // A plant and the one block it may stand on, by `mayPlaceOn`.
    ground: Option<(BlockId,
        // A block and its `canSurvive` answer.
    survive: Option<(BlockId,
    asked: Cell<uint>,
}
    // rust: impl LevelAccess for Rules {
block_state :: proc(self: ^Self, pos: BlockPos) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.block_state(pos)
}
set_raw :: proc(self: ^Self, pos: BlockPos, state: BlockStateId) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.set_raw(pos, state)
}
is_loaded :: proc(self: ^Self, pos: BlockPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.is_loaded(pos)
}
random :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.random()
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.inner.game_time()
}
emit :: proc(self: ^Self, event: LevelEvent) {
}
    // rust: self.inner.emit(event);
}
    // rust: fn before_can_survive(
    // rust: &self,
    // rust: _pos: BlockPos,
    // rust: state: BlockStateId,
    // rust: survives: &mut Option<bool>,
    // rust: ) {
    // rust: self.asked.set(self.asked.get() + 1);
    // rust: if let Some((block, answer)) = self.survive
    // rust: && self.b.block(state) == block
    // rust: {
    // rust: *survives = Some(answer);
}
}
    // rust: fn before_may_place_on(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: ground: BlockStateId,
    // rust: _ground_pos: BlockPos,
    // rust: may: &mut Option<bool>,
    // rust: ) {
    // rust: if let Some((plant, on)) = self.ground
    // rust: && self.b.block(state) == plant
    // rust: {
    // rust: *may = Some(self.b.block(ground) == on);
}
}
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let b = &f.behaviours;
    // rust: let state = |name: &str| f.registry.default_state(name).unwrap();
    // rust: let (dandelion, stone, cobblestone) = (
    // rust: state("minecraft:dandelion"),
    // rust: state("minecraft:stone"),
    // rust: state("minecraft:cobblestone"),
    // rust: );
    // rust: let mut level = Rules {
    // rust: inner: TestLevel::new(b),
    // rust: b,
    // rust: ground: None,
    // rust: survive: None,
    // rust: asked: Cell::new(0),
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: ticks.add_empty_chunk(ChunkPos::new(0, 0)).unwrap();
    // rust: let ground = BlockPos::new(1, 1, 1);
    // rust: let pos = BlockPos::new(1, 2, 1);
    // rust: let place = |level: &mut Rules, ticks: &mut Ticks, item: &str| {
    // rust: let ctx = PlaceContext {
    // rust: clicked_pos: ground,
    // rust: face: Direction::Up,
    // rust: hit: horizon_core::geometry::Vec3::new(1.5, 2.0, 1.5),
    // rust: inside: false,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: sneaking: false,
    // rust: item: item.into(),
    // rust: can_use_game_master_blocks: false,
}
    // rust: b.place_block(level, ticks, &ctx)
}
    // rust: level.set_raw(ground, stone);

    // A dandelion doesn't stand on stone in vanilla, so it can't be placed there.
    // rust: assert!(!b.can_survive(&mut level, &mut ticks, pos, dandelion));
    // rust: assert_eq!(
    // rust: place(&mut level, &mut ticks, "minecraft:dandelion"),
    // rust: PlaceOutcome::Failed
    // rust: );
    // A mod's mayPlaceOn names stone: placed, through the dandelion's own canSurvive.
    // rust: level.ground = Some((b.block(dandelion), b.block(stone)));
    // rust: assert!(matches!(
    // rust: place(&mut level, &mut ticks, "minecraft:dandelion"),
    // rust: PlaceOutcome::Placed { pos: p, .. } if p == pos
    // rust: ));
    // rust: assert_eq!(level.block_state(pos), dandelion);
    // Its ground turns to cobblestone: its shape update asks again and it pops off, with its drops.
    // rust: b.set_block(
    // rust: &mut level,
    // rust: &mut ticks,
    // rust: ground,
    // rust: cobblestone,
    // rust: flags::UPDATE_ALL,
    // rust: );
    // rust: assert_eq!(level.block_state(pos), b.air());
    // rust: assert!(level.inner.events.iter().any(
    // rust: |e| matches!(e, LevelEvent::DropResources { pos: p, state } if *p == pos && *state == dandelion)
    // rust: ));

    // canSurvive answered for the block itself wins over its own rule, either way.
    // rust: level.survive = Some((b.block(dandelion), true));
    // rust: assert!(b.can_survive(&mut level, &mut ticks, pos, dandelion));
    // rust: level.set_raw(ground, stone);
    // rust: level.survive = Some((b.block(stone), false));
    // rust: assert_eq!(
    // rust: place(&mut level, &mut ticks, "minecraft:stone"),
    // rust: PlaceOutcome::Failed
    // rust: );
    // rust: assert_eq!(level.block_state(pos), b.air());
    // Without an answer the block's own rule runs: stone survives anywhere.
    // rust: level.survive = None;
    // rust: let asked = level.asked.get();
    // rust: assert!(matches!(
    // rust: place(&mut level, &mut ticks, "minecraft:stone"),
    // rust: PlaceOutcome::Placed { .. }
    // rust: ));
    // rust: assert!(level.asked.get() > asked);
}

a_level_can_answer_how_a_block_burns :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let glass = w.id("glass", &[]);
    // rust: let planks = w.id("oak_planks", &[]);
    // rust: let burn = |w: &mut World, fire: BlockPos| {
    // rust: w.set(fire.offset(0, -1, 0), w.id("netherrack", &[]));
    // rust: w.set(fire.offset(1, 0, 0), glass);
    // rust: w.set(fire.offset(-1, 0, 0), planks);
    // rust: w.set(fire, w.id("fire", &[]));
    // rust: for _ in 0..4000 {
    // rust: w.tick();
}
}
    // Vanilla's table: glass never burns, planks do.
    // rust: let fire = BlockPos::new(0, 1, 0);
    // rust: burn(&mut w, fire);
    // rust: assert_eq!(w.get(fire.offset(1, 0, 0)), glass, "glass doesn't burn");
    // rust: assert_ne!(w.get(fire.offset(-1, 0, 0)), planks, "planks burn");

    // The level's answer wins over the table, either way.
    // rust: w.level.fire_odds.insert(glass, (30, 60));
    // rust: w.level.fire_odds.insert(planks, (0, 0));
    // rust: let fire = BlockPos::new(0, 1, 6);
    // rust: burn(&mut w, fire);
    // rust: assert_ne!(w.get(fire.offset(1, 0, 0)), glass, "flammable glass burns");
    // rust: assert_eq!(
    // rust: w.get(fire.offset(-1, 0, 0)),
    // rust: planks,
    // rust: "fireproof planks don't"
    // rust: );

    // Fire in the air beside a block stays only while the block's ignite
    // odds are above zero, and burn odds of zero never destroy the block.
    // rust: let lit_beside = |w: &mut World, at: BlockPos, ticks: usize| {
    // rust: w.set(at.offset(1, 0, 0), glass);
    // rust: w.set(at, w.id("fire", &[]));
    // rust: for _ in 0..ticks {
    // rust: w.tick();
}
    // rust: w.get(at)
}
    // rust: let fire = w.id("fire", &[]);
    // rust: w.level.fire_odds.clear();
    // rust: let at = BlockPos::new(-6, 5, 0);
    // rust: assert_ne!(
    // rust: w.b().block(lit_beside(&mut w, at, 45)),
    // rust: w.b().block(fire),
    // rust: "fire beside plain glass goes out"
    // rust: );
    // rust: w.level.fire_odds.insert(glass, (5, 0));
    // rust: let at = BlockPos::new(-6, 5, 6);
    // rust: assert_eq!(
    // rust: w.b().block(lit_beside(&mut w, at, 45)),
    // rust: w.b().block(fire),
    // rust: "fire stands beside glass that ignites"
    // rust: );
    // rust: for _ in 0..4000 {
    // rust: w.tick();
}
    // rust: assert_eq!(w.get(at.offset(1, 0, 0)), glass, "and never burns it away");
}

a_level_can_answer_what_makes_a_campfire_signal :: proc() {
}
    // rust: let mut w = world!();
    // rust: let (stone, hay) = (w.id("stone", &[]), w.id("hay_block", &[]));
    // rust: let ground = BlockPos::new(0, 0, 0);
    // rust: let campfire = ground.offset(0, 1, 0);
    // rust: let place = |w: &mut World| {
    // rust: w.level.blocks.remove(&campfire);
    // rust: let ctx = PlaceContext {
    // rust: clicked_pos: ground,
    // rust: face: Direction::Up,
    // rust: hit: horizon_core::geometry::Vec3::new(0.5, 1.0, 0.5),
    // rust: inside: false,
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: sneaking: false,
    // rust: item: "minecraft:campfire".into(),
    // rust: can_use_game_master_blocks: false,
}
    // rust: let b = w.b();
    // rust: assert!(matches!(
    // rust: b.place_block(&mut w.level, &mut w.ticks, &ctx),
    // rust: PlaceOutcome::Placed { .. }
    // rust: ));
    // rust: w.prop(campfire, "signal_fire")
}
    // rust: w.put(ground, stone);
    // rust: assert_eq!(place(&mut w), "false");
    // rust: w.put(ground, hay);
    // rust: assert_eq!(place(&mut w), "true", "vanilla's hay bale");

    // The level makes stone a smoke source and hay not: placed, and as the ground changes.
    // rust: w.level.smoke_sources.insert(stone, true);
    // rust: w.level.smoke_sources.insert(hay, false);
    // rust: assert_eq!(place(&mut w), "false");
    // rust: w.set(ground, stone);
    // rust: assert_eq!(w.prop(campfire, "signal_fire"), "true");
    // rust: w.set(ground, hay);
    // rust: assert_eq!(w.prop(campfire, "signal_fire"), "false");
}

// #8490 carpet duplication machine: four slime blocks, a sticky piston, a dead
// wall coral fan and three carpets on the slime column's far side.
carpet_duplication_machine_8490 :: proc() {
}
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let slime = w.id("slime_block", &[]);
    // rust: let air = w.b().air();
    // rust: let piston = w.id("sticky_piston", &[("facing", "west")]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: let fan = w.id(
    // rust: "dead_tube_coral_wall_fan",
    // rust: &[("facing", "west"), ("waterlogged", "false")],
    // rust: );
    // rust: let carpet = w.id("white_carpet", &[]);
    // rust: w.set(
    // rust: BlockPos::new(4, 1, 0),
    // rust: w.id("grass_block", &[("snowy", "false")]),
    // rust: );
    // rust: for y in 2..6 {
    // rust: w.set(BlockPos::new(3, y, 0), slime);
}
    // rust: w.set(BlockPos::new(4, 2, 0), piston);
    // rust: w.set(BlockPos::new(2, 2, 0), fan);
    // rust: for y in 3..6 {
    // rust: w.set(BlockPos::new(2, y, 0), carpet);
}
    // rust: w.set(BlockPos::new(5, 2, 0), power);
    // rust: let fan_name = |w: &mut World, x: i32, y: i32| w.name(BlockPos::new(x, y, 0));
    // rust: for _ in 0..6 {
    // rust: w.full_tick();
}
    // Pushed one block west: the column lands with its fan and carpets (the
    // fan reads the slime block still shown as a finished moving piston).
    // rust: for y in 2..6 {
    // rust: assert_eq!(w.get(BlockPos::new(2, y, 0)), slime, "slime y={y}");
}
    // rust: assert!(fan_name(&mut w, 1, 2).starts_with("dead_tube_coral_wall_fan"));
    // rust: for y in 3..6 {
    // rust: assert_eq!(w.get(BlockPos::new(1, y, 0)), carpet, "carpet y={y}");
}
    // rust: w.set(BlockPos::new(5, 2, 0), air);
    // rust: for _ in 0..6 {
    // rust: w.full_tick();
}
    // Pulled back: the machine is whole again at its start.
    // rust: for y in 2..6 {
    // rust: assert_eq!(w.get(BlockPos::new(3, y, 0)), slime, "pulled slime y={y}");
}
    // rust: assert!(fan_name(&mut w, 2, 2).starts_with("dead_tube_coral_wall_fan"));
    // rust: for y in 3..6 {
    // rust: assert_eq!(w.get(BlockPos::new(2, y, 0)), carpet, "pulled carpet y={y}");
}
}

a_rail_on_a_block_a_piston_pushes_pops_off :: proc() {
}
    // PistonBaseBlock.moveBlocks writes the arriving blocks as `moving_piston`
    // and then updates the neighbours of every source cell. The rail on the
    // second stone asks whether that cell supports it: vanilla reads the moving
    // block's shape offset by `progress - 1`, a whole block back at progress 0,
    // so nothing holds the rail and it pops, though another stone arrives under
    // it (dynamic_support pins the moving shape's support against vanilla).
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("piston", &[("facing", "east")]);
    // rust: let stone = w.id("stone", &[]);
    // rust: let rail = w.id("rail", &[]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: let piston_pos = BlockPos::new(0, 1, 0);
    // rust: let rail_pos = BlockPos::new(2, 2, 0);
    // rust: w.set(piston_pos, piston);
    // rust: w.set(BlockPos::new(1, 1, 0), stone);
    // rust: w.set(BlockPos::new(2, 1, 0), stone);
    // rust: w.set(rail_pos, rail);
    // rust: w.set(BlockPos::new(-1, 1, 0), power);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(piston_pos, "extended"), "true");
    // rust: assert_eq!(w.name(BlockPos::new(2, 1, 0)), "stone[]");
    // rust: assert_eq!(w.name(BlockPos::new(3, 1, 0)), "stone[]");
    // rust: assert_eq!(w.name(rail_pos), "air[]");
}

a_rail_riding_on_slime_stays_on_it :: proc() {
}
    // #8111: the slime block carries the rail on top of it. The rail's block
    // entity can finish while the slime's still holds `moving_piston` at
    // progress 1, whose shape is the slime block in its cell, so the rail is
    // supported both ways.
    // rust: let mut w = world!();
    // rust: w.floor(0, 10, "stone");
    // rust: let piston = w.id("sticky_piston", &[("facing", "east")]);
    // rust: let slime = w.id("slime_block", &[]);
    // rust: let rail = w.id("rail", &[]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: let air = w.b().air();
    // rust: let piston_pos = BlockPos::new(0, 1, 0);
    // rust: let power_pos = BlockPos::new(-1, 1, 0);
    // rust: w.set(piston_pos, piston);
    // rust: w.set(BlockPos::new(1, 1, 0), slime);
    // rust: w.set(BlockPos::new(1, 2, 0), rail);
    // rust: w.set(power_pos, power);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(piston_pos, "extended"), "true");
    // rust: assert_eq!(w.name(BlockPos::new(2, 1, 0)), "slime_block[]");
    // rust: let pushed = w.name(BlockPos::new(2, 2, 0));
    // rust: assert!(pushed.starts_with("rail"), "pushed: got {pushed}");
    // rust: w.set(power_pos, air);
    // rust: for _ in 0..4 {
    // rust: w.full_tick();
}
    // rust: assert_eq!(w.prop(piston_pos, "extended"), "false");
    // rust: let pulled = w.name(BlockPos::new(1, 2, 0));
    // rust: assert!(pulled.starts_with("rail"), "pulled back: got {pulled}");
}
