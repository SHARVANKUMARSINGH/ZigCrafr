//! Transpiled from Horizon Rust crate
//! Module: horizon-client_game_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The game-test runner: `GameTestInfo`, `GameTestRunner`, `GameTestTicker`,
//! `MultipleTestTracker`, `ReportGameListener`, `TestCommand.trackAndStartRunner`
//! and the two test instance types (`BlockBasedTestInstance` and
//! `FunctionGameTestInstance`), over the test instance blocks in a level.
//!
//! Retries (`RetryOptions`, `/test run .. <numberOfTimes> <untilFailed>`) and
//! flaky tests (`max_attempts`, `required_successes`) go through
//! `ReportGameListener`'s counters and `GameTestRunner.rerunTest`.
//!
//! Not ported: test sequences (`GameTestSequence`: the built-in tests, only
//! `always_pass`, do not use them), test environments other than the empty
//! `all_of`, and removing the entities of a finished test.
// use super::{
    // rust: Dim, Game,
    // rust: structure_blocks::template_size,
    // rust: test_entities::{aabb_of, inflate},
    // rust: test_environments::Activation,
    // rust: test_instances::TestDef,
}
// use horizon_client::{
    // rust: containers::BlockEntity,
    // rust: lan::data::component_nbt,
    // rust: test_block::TestBlockMode,
    // rust: test_instance_block::{ErrorMarker, Status, TestInstanceBlock},
    // rust: text::{self, Text},
}
// use horizon_world::{
    // rust: level::flags,
    // rust: worldgen::structure::{BoundingBox, Mirror, Rotation, StructureTemplate},
}
// use std::time::Instant;

    // rust: type Pos = (i32, i32, i32);

/// `GameTestAssertException`, `GameTestAssertPosException`,
/// `GameTestTimeoutException` and `UnknownGameTestException`.
    // rust: pub(super) enum TestError {
    // rust: Assert {
    // rust: message: Text,
    // rust: tick: i32,
    // rust: },
    // rust: AssertPos {
    // rust: message: Text,
    // rust: absolute: Pos,
    // rust: relative: Pos,
    // rust: tick: i32,
    // rust: },
    // rust: Timeout(Text),
    // rust: Unknown(String),
}

pub fn number(v: i32) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Text::literal(v.to_string())
}

    // rust: impl TestError {
    /// `getDescription`.
    // rust: pub(super) fn description(&self) -> Text {
    // rust: match self {
    // rust: Self::Assert { message, tick } => {
    // rust: Text::translate("test.error.tick", &[message.clone(), number(*tick)])
}
    // rust: Self::AssertPos {
    // rust: message,
    // rust: absolute,
    // rust: relative,
    // rust: tick,
    // rust: } => Text::translate(
    // rust: "test.error.position",
    // rust: &[
    // rust: message.clone(),
    // rust: number(absolute.0),
    // rust: number(absolute.1),
    // rust: number(absolute.2),
    // rust: number(relative.0),
    // rust: number(relative.1),
    // rust: number(relative.2),
    // rust: number(*tick),
    // rust: ],
    // rust: ),
    // rust: Self::Timeout(message) => message.clone(),
    // rust: Self::Unknown(reason) => {
    // rust: Text::translate("test.error.unknown", &[Text::literal(reason.clone())])
}
}
}

    /// `getMessage`: the description's characters (a timeout's own message,
    /// an unknown error's reason).
pub fn message(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Unknown(reason) => reason.clone(),
    // rust: other => other.description().plain(),
}
}
}

/// `RetryOptions`.
    // rust: pub(super) struct Retry {
    // rust: number_of_tries: i32,
    // rust: halt_on_failure: bool,
}

    // rust: impl Retry {
    // rust: pub(super) fn new(number_of_tries: i32, halt_on_failure: bool) -> Self {
    // rust: Self {
    // rust: number_of_tries,
    // rust: halt_on_failure,
}
}

    /// `noRetries`.
    // rust: pub(super) fn none() -> Self {
    // rust: Self::new(1, true)
}

    /// `unlimitedTries`.
pub fn unlimited(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.number_of_tries < 1
}

    /// `hasTriesLeft`.
pub fn has_tries_left(self: *Self, attempts: i32, successes: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let has_failures = attempts != successes;
    // rust: let has_more_attempts = self.unlimited() || attempts < self.number_of_tries;
    // rust: has_more_attempts && (!has_failures || !self.halt_on_failure)
}

    /// `hasRetries`.
pub fn has_retries(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.number_of_tries != 1
}
}

/// What `runAtTickTime` runs.
pub const Action = enum {
    /// `BlockBasedTestInstance.run`'s `onEachTick` body.
    BlockBasedTick,
};

/// `GameTestInfo`.
    // rust: pub(super) struct Info {
    // rust: id: u32,
    /// `id()`: the test's registry id.
    // rust: key: String,
    // rust: def: TestDef,
    /// The test instance block (`getTestBlockPos`), once there is one.
    // rust: pos: Pos,
    // rust: has_pos: bool,
    // rust: dim: Dim,
    // rust: extra_rotation: Rotation,
    // rust: tick_count: i32,
    // rust: started: bool,
    // rust: placed: bool,
    // rust: done: bool,
    // rust: error: Option<TestError>,
    // rust: run_at: Vec<(i64, Action)>,
    // rust: started_at: Option<Instant>,
    // rust: run_ms: u128,
    // rust: retry: Retry,
    /// The test whose `ReportGameListener` counts this run: its own id, or
    /// the original's for a rerun (`copyReset`).
    // rust: origin: u32,
    // rust: rerun: bool,
    /// `succeed` removes the entities around the structure; the game does it.
    // rust: discard_entities: bool,
}

    // rust: impl Info {
    // rust: pub(super) fn new(
    // rust: id: u32,
    // rust: key: String,
    // rust: def: TestDef,
    // rust: pos: Option<Pos>,
    // rust: dim: Dim,
    // rust: extra_rotation: Rotation,
    // rust: ) -> Self {
    // rust: Self {
    // rust: id,
    // rust: key,
    // rust: def,
    // rust: pos: pos.unwrap_or_default(),
    // rust: has_pos: pos.is_some(),
    // rust: dim,
    // rust: extra_rotation,
    // rust: tick_count: 0,
    // rust: started: false,
    // rust: placed: false,
    // rust: done: false,
    // rust: error: None,
    // rust: run_at: Vec::new(),
    // rust: started_at: None,
    // rust: run_ms: 0,
    // rust: retry: Retry::none(),
    // rust: origin: id,
    // rust: rerun: false,
    // rust: discard_entities: false,
}
}

    // rust: pub(super) fn with_retry(mut self, retry: Retry) -> Self {
    // rust: self.retry = retry;
    // rust: self
}

    /// `copyReset`: the same test, level and block, as a new run.
pub fn copy_reset(self: *Self, id: u32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pos = self.has_pos.then_some(self.pos);
    // rust: let mut copy = Self::new(
    // rust: id,
    // rust: self.key.clone(),
    // rust: self.def.clone(),
    // rust: pos,
    // rust: self.dim,
    // rust: self.extra_rotation,
    // rust: )
    // rust: .with_retry(self.retry);
    // rust: copy.origin = self.origin;
    // rust: copy.rerun = true;
    // rust: copy
}

    /// `getRotation`.
pub fn rotation(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.def.rotation.get_rotated(self.extra_rotation)
}

    /// `assertionException(description)`.
pub fn assertion(self: *Self, message: Text) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TestError::Assert {
    // rust: message,
    // rust: tick: self.tick_count,
}
}

    /// `fail(Component)`.
pub fn fail(self: *Self, message: Text) void {
}
    // rust: self.error = Some(self.assertion(message));
}

    /// `finish`.
pub fn finish(self: *Self) void {
}
    // rust: if !self.done {
    // rust: self.done = true;
    // rust: if let Some(at) = self.started_at.take() {
    // rust: self.run_ms = at.elapsed().as_millis();
}
}
}

    /// `succeed`: finishes unless a failure is set.
pub fn succeed(self: *Self) void {
}
    // rust: if self.error.is_none() {
    // rust: self.finish();
    // rust: self.discard_entities = true;
}
}

    /// `startExecution(tickDelay)`.
pub fn start_execution(self: *Self, tick_delay: i32) void {
}
    // rust: self.tick_count = -(self.def.setup_ticks + tick_delay + 1);
}

    /// `onEachTick`: the action on every tick from now to the timeout.
pub fn on_each_tick(self: *Self, action: Action) void {
}
    // rust: for i in i64::from(self.tick_count)..i64::from(self.def.max_ticks) {
    // rust: self.run_at.push((i, action));
}
}
}

/// One `GameTestBatch`.
    // rust: pub(super) struct Batch {
    // rust: pub(super) index: i32,
    // rust: pub(super) environment: String,
    // rust: pub(super) infos: Vec<Info>,
}

/// What `GameTestRunner.Builder` is given.
    // rust: pub(super) struct RunnerOptions {
    // rust: halt_on_error: bool,
    // rust: batch_size: usize,
    // rust: clear_between_batches: bool,
    // rust: grid_for_existing: bool,
    // rust: grid: Option<Grid>,
}

    // rust: impl RunnerOptions {
    // rust: pub(super) fn new(halt_on_error: bool, grid: Option<Grid>) -> Self {
    // rust: Self {
    // rust: halt_on_error,
    // rust: batch_size: 50,
    // rust: clear_between_batches: false,
    // rust: grid_for_existing: false,
    // rust: grid,
}
}

    /// `/test verify`: `batcher(fromGameTestInfo(100))`, the grid for
    /// existing tests too, `haltOnError`, `clearBetweenBatches`.
    // rust: pub(super) fn verify(grid: Grid) -> Self {
    // rust: Self {
    // rust: halt_on_error: true,
    // rust: batch_size: 100,
    // rust: clear_between_batches: true,
    // rust: grid_for_existing: true,
    // rust: grid: Some(grid),
}
}
}

/// What `MultipleTestTracker` knows of a test.
pub const Tracked = struct {
    id: u32,
    required: bool,
    done: bool,
    failed: bool,
};

/// `GameTestBatchFactory.fromGameTestInfo(size)`: one batch per environment
/// (and dimension), `size` to a batch.
pub fn batch_infos(infos: std.ArrayList(Info), size: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut batches: Vec<Batch> = Vec::new();
    // rust: let mut counts: Vec<(String, i32)> = Vec::new();
    // rust: for info in infos {
    // rust: let env = info.def.environment.clone();
    // rust: let open = batches
    // rust: .iter_mut()
    // rust: .find(|b| b.environment == env && b.infos.len() < size);
    // rust: if let Some(batch) = open {
    // rust: batch.infos.push(info);
    // rust: continue;
}
    // rust: let index = match counts.iter_mut().find(|(e, _)| *e == env) {
    // rust: Some((_, n)) => {
    // rust: *n += 1;
    // rust: *n
}
    // rust: None => {
    // rust: counts.push((env.clone(), 0));
    // rust: 0
}
}
    // rust: batches.push(Batch {
    // rust: index,
    // rust: environment: env,
    // rust: infos: vec![info],
    // rust: });
}
    // rust: batches
}

/// `/test verify`'s batches: each test in each rotation 100 times, with
/// `RetryOptions(1, true)`, at the test's block if it has one; the batch
/// index is the rotation's ordinal.
    // rust: pub(super) fn verify_batches(infos: &[Info], mut next_id: impl FnMut() -> u32) -> Vec<Batch> {
    // rust: let mut batches = Vec::new();
    // rust: for info in infos {
    // rust: for (ordinal, rotation) in Rotation::ALL.into_iter().enumerate() {
    // rust: let copies = (0..100)
    // rust: .map(|_| {
    // rust: let pos = info.has_pos.then_some(info.pos);
    // rust: Info::new(
    // rust: next_id(),
    // rust: info.key.clone(),
    // rust: info.def.clone(),
    // rust: pos,
    // rust: info.dim,
    // rust: rotation,
    // rust: )
    // rust: .with_retry(Retry::new(1, true))
    // rust: })
    // rust: .collect();
    // rust: batches.push(Batch {
    // rust: index: ordinal as i32,
    // rust: environment: info.def.environment.clone(),
    // rust: infos: copies,
    // rust: });
}
}
    // rust: batches
}

/// A listener's counters, (origin, attempts, successes): its attempts and successes.
pub fn report_of(reports: *mut Vec<(u32) void {
}
    // rust: let at = reports
    // rust: .iter()
    // rust: .position(|r| r.0 == origin)
    // rust: .unwrap_or_else(|| {
    // rust: reports.push((origin, 0, 0));
    // rust: reports.len() - 1
    // rust: });
    // rust: let r = &mut reports[at];
    // rust: (&mut r.1, &mut r.2)
}

/// `GameTestRunner`.
pub const Runner = struct {
    batches: std.ArrayList(Batch),
    current: usize,
    /// `currentBatchTracker`: the tests of the batch still to finish.
    batch_pending: usize,
    tracked: std.ArrayList(Tracked),
    halt_on_error: bool,
    /// `GameTestBatchFactory.fromGameTestInfo(maxTestsPerBatch)`, for reruns.
    batch_size: usize,
    /// `clearBetweenBatches`.
    clear_between_batches: bool,
    /// The grid is also `existingStructureSpawner` (`/test verify`): a test
    /// with a block is moved onto it.
    grid_for_existing: bool,
    /// The tests of the batch before: their levels and blocks, for
    /// `clearBetweenBatches`.
    last_batch: Vec<(Dim,
    /// `newStructureSpawner`: where the tests without a block go.
    grid: ?Grid,
    /// `ReportGameListener`'s (attempts, successes), by original test.
    reports: Vec<(u32,
    /// `scheduledForRerun`.
    scheduled: std.ArrayList(Info),
    /// `stopped`: no batch is running.
    stopped: bool,
};

/// `StructureGridSpawner.DimensionGridState`.
pub const DimGrid = struct {
    first: Pos,
    next: Pos,
    /// The z extent of `rowBounds` (an `AABB(BlockPos)` is one block deep).
    row_z: (i32,
    count: i32,
    /// `testsInLastBatch`: their blocks.
    last_batch: std.ArrayList(Pos),
};

    // rust: impl DimGrid {
pub fn new(first: Pos) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: first,
    // rust: next: first,
    // rust: row_z: (first.2, first.2 + 1),
    // rust: count: 0,
    // rust: last_batch: Vec::new(),
}
}
}

/// `StructureGridSpawner`: a grid per dimension, made when the first test of
/// that dimension is placed (`firstTestNorthWestCorner.apply(dimension)`).
    // rust: pub(super) struct Grid {
    /// The column `createTestPositionAround` starts from: the source's.
    // rust: around: (i32, i32),
    // rust: per_row: i32,
    /// `clearOnBatch`.
    // rust: clear_on_batch: bool,
    // rust: states: Vec<(Dim, DimGrid)>,
}

    // rust: impl Grid {
    // rust: pub(super) fn new(around: (i32, i32), per_row: i32) -> Self {
    // rust: Self {
    // rust: around,
    // rust: per_row,
    // rust: clear_on_batch: false,
    // rust: states: Vec::new(),
}
}

    /// `clearOnBatch = true`.
    // rust: pub(super) fn clearing(mut self) -> Self {
    // rust: self.clear_on_batch = true;
    // rust: self
}
}

/// What a runner says to the server, sent on the next tick (a test's
/// messages come from the server's console, not a player's command).
pub const Out = enum {
    /// `sendSuccess(.., broadcast)`, `sendFailure` or `sendSystemMessage` of
    /// the server's command source.
    Console { text: Text, broadcast: bool },
    /// `ReportGameListener.say`: every player gets it.
    Players(Text),
};

/// `GameTestTicker.SINGLETON` and the runner it holds, `FailedTestTracker`.
    // rust: pub(super) struct GameTests {
    // rust: ticker: Vec<Info>,
    // rust: runner: Option<Runner>,
    // rust: ticking: bool,
    // rust: halting: bool,
    // rust: next_id: u32,
    /// `FailedTestTracker.LAST_FAILED_TESTS`.
    // rust: pub(super) failed: Vec<String>,
    // rust: outbox: Vec<Out>,
    /// `GameTestRunner.currentEnvironment`.
    // rust: environment: Option<Activation>,
}

    // rust: impl GameTests {
    /// A test of the runner (placed or still to place) is in `dim`.
    // rust: pub(super) fn has_tests_in(&self, dim: Dim) -> bool {
    // rust: self.ticker.iter().any(|i| i.dim == dim)
    // rust: || self.runner.as_ref().is_some_and(|r| {
    // rust: r.batches
    // rust: .iter()
    // rust: .flat_map(|b| &b.infos)
    // rust: .chain(&r.scheduled)
    // rust: .any(|i| i.dim == dim)
    // rust: })
}

    // rust: pub(super) fn next_id(&mut self) -> u32 {
    // rust: self.next_id += 1;
    // rust: self.next_id
}
}

    // rust: impl Game<'_> {
    // ---- GameTestRunner / GameTestTicker ----

    /// `GameTestTicker.clear`: a pass in progress halts at its end.
    // rust: pub(super) fn clear_game_tests(&mut self) {
    // rust: if self.game_tests.ticking {
    // rust: self.game_tests.halting = true;
    // rust: } else {
    // rust: self.game_tests.ticker.clear();
    // rust: if self.game_tests.runner.take().is_some() {
                // GameTestRunner.stop: endCurrentEnvironment.
    // rust: self.end_test_environment();
}
}
}

    /// `TestCommand.trackAndStartRunner` for tests already built (batched by
    /// environment, 50 to a batch): the tracker and its listeners, then
    /// `GameTestRunner.start`.
    // rust: pub(super) fn track_and_start_runner(
    // rust: &mut self,
    // rust: infos: Vec<Info>,
    // rust: halt_on_error: bool,
    // rust: grid: Option<Grid>,
    // rust: ) {
    // rust: let batches = batch_infos(infos, 50);
    // rust: self.track_and_start_batches(batches, RunnerOptions::new(halt_on_error, grid));
}

    /// `TestCommand.trackAndStartRunner` for batches already made.
    // rust: pub(super) fn track_and_start_batches(&mut self, batches: Vec<Batch>, options: RunnerOptions) {
    // rust: let tracked = batches
    // rust: .iter()
    // rust: .flat_map(|b| &b.infos)
    // rust: .map(|i| Tracked {
    // rust: id: i.id,
    // rust: required: i.def.required,
    // rust: done: false,
    // rust: failed: false,
    // rust: })
    // rust: .collect();
    // rust: self.game_tests.runner = Some(Runner {
    // rust: batches,
    // rust: current: 0,
    // rust: batch_pending: 0,
    // rust: tracked,
    // rust: halt_on_error: options.halt_on_error,
    // rust: batch_size: options.batch_size,
    // rust: clear_between_batches: options.clear_between_batches,
    // rust: grid_for_existing: options.grid_for_existing,
    // rust: last_batch: Vec::new(),
    // rust: grid: options.grid,
    // rust: reports: Vec::new(),
    // rust: scheduled: Vec::new(),
    // rust: stopped: false,
    // rust: });
    // rust: self.run_batch(0);
}

    /// `GameTestRunner.runBatch`.
pub fn run_batch(self: *Self, index: usize) void {
}
    // rust: let Some(runner) = self.game_tests.runner.as_mut() else {
    // rust: return;
}
    // rust: if index >= runner.batches.len() {
    // rust: self.end_test_environment();
    // rust: self.run_scheduled_reruns();
    // rust: return;
}
    // rust: runner.current = index;
        // clearBetweenBatches: the batch before is cleared and its blocks
        // destroyed.
    // rust: let cleared = if index > 0 && runner.clear_between_batches {
    // rust: std::mem::take(&mut runner.last_batch)
    // rust: } else {
    // rust: Vec::new()
}
        // StructureGridSpawner.onBatchStart (clearOnBatch), every dimension.
    // rust: let mut grid_cleared: Vec<(Dim, Pos)> = Vec::new();
    // rust: if let Some(grid) = runner.grid.as_mut().filter(|g| g.clear_on_batch) {
    // rust: for (dim, g) in &mut grid.states {
    // rust: grid_cleared.extend(
    // rust: std::mem::take(&mut g.last_batch)
    // rust: .into_iter()
    // rust: .map(|p| (*dim, p)),
    // rust: );
    // rust: g.next = g.first;
    // rust: g.row_z = (g.first.2, g.first.2 + 1);
    // rust: g.count = 0;
}
}
    // rust: for (dim, pos) in cleared {
    // rust: self.in_test_level(dim, |g| {
    // rust: if let Some(area) = g.test_bounding_box(pos) {
    // rust: g.clear_test_space(&area);
}
    // rust: g.set_test_block_state(pos, "minecraft:air", flags::UPDATE_ALL);
    // rust: });
}
    // rust: for (dim, pos) in grid_cleared {
    // rust: self.in_test_level(dim, |g| {
    // rust: if let Some(area) = g.test_bounding_box(pos) {
    // rust: g.clear_test_space(&area);
}
    // rust: });
}
    // rust: let Some(runner) = self.game_tests.runner.as_mut() else {
    // rust: return;
}
    // rust: let Some(batch) = runner.batches.get_mut(index) else {
    // rust: return;
}
    // rust: let mut infos = std::mem::take(&mut batch.infos);
    // rust: let (environment, batch_number) = (batch.environment.clone(), batch.index);
        // createStructuresForBatch: `StructureSpawner.IN_PLACE`.
    // rust: let mut spawned = Vec::new();
    // rust: for mut info in infos.drain(..) {
    // rust: if self.spawn_test(&mut info) {
    // rust: spawned.push(info);
}
}
    // rust: log::info!(
    // rust: "Running test environment '{environment}' batch {batch_number} ({} tests)...",
    // rust: spawned.len()
    // rust: );
        // endCurrentEnvironment, then TestEnvironmentDefinition.activate.
    // rust: self.end_test_environment();
    // rust: match self.test_environment(&environment) {
    // rust: Some(definition) => {
    // rust: let activation = self.activate_test_environment(definition);
    // rust: self.game_tests.environment = Some(activation);
}
    // rust: None => log::error!("Missing test environment {environment}"),
}
    // rust: self.game_tests.outbox.push(Out::Console {
    // rust: text: Text::translate(
    // rust: "commands.test.batch.starting",
    // rust: &[Text::literal(environment), number(batch_number)],
    // rust: ),
    // rust: broadcast: true,
    // rust: });
    // rust: if let Some(runner) = self.game_tests.runner.as_mut() {
    // rust: runner.batch_pending = spawned.len();
    // rust: runner.last_batch = spawned.iter().map(|i| (i.dim, i.pos)).collect();
}
    // rust: self.game_tests.ticker.extend(spawned);
}

    /// `GameTestRunner.endCurrentEnvironment`.
pub fn end_test_environment(self: *Self) void {
}
    // rust: if let Some(activation) = self.game_tests.environment.take() {
    // rust: self.tear_down_test_environment(activation);
}
}

    /// `GameTestRunner.runScheduledRerunTests`: the reruns are batched
    /// again and run, or the runner stops.
pub fn run_scheduled_reruns(self: *Self) void {
}
    // rust: let Some(runner) = self.game_tests.runner.as_mut() else {
    // rust: return;
}
    // rust: if runner.scheduled.is_empty() {
    // rust: runner.batches = Vec::new();
    // rust: runner.stopped = true;
    // rust: return;
}
    // rust: let scheduled = std::mem::take(&mut runner.scheduled);
    // rust: log::info!(
    // rust: "Starting re-run of tests: {}",
    // rust: scheduled
    // rust: .iter()
    // rust: .map(|i| i.key.as_str())
    // rust: .collect::<Vec<_>>()
    // rust: .join(", ")
    // rust: );
    // rust: runner.batches = batch_infos(scheduled, runner.batch_size);
    // rust: runner.stopped = false;
    // rust: self.run_batch(0);
}

    /// `GameTestRunner.rerunTest`.
pub fn rerun_test(self: *Self, info: *Info) void {
}
    // rust: let id = self.game_tests.next_id();
    // rust: let copy = info.copy_reset(id);
    // rust: let Some(runner) = self.game_tests.runner.as_mut() else {
    // rust: return;
}
    // rust: runner.scheduled.push(copy);
    // rust: if runner.stopped {
    // rust: self.run_scheduled_reruns();
}
}

    /// `GameTestServer`'s per-tick call: `MinecraftServer.tickServer`'s
    /// `GameTestTicker.SINGLETON.tick()`, for the tests of the level in place.
    // rust: pub(super) fn tick_game_tests(&mut self) {
    // rust: self.flush_game_test_output();
    // rust: if self.game_tests.runner.is_none() {
    // rust: return;
}
    // rust: let dim = self.dim;
    // rust: self.game_tests.ticking = true;
    // rust: let mut infos = std::mem::take(&mut self.game_tests.ticker);
    // rust: for info in infos.iter_mut().filter(|i| i.dim == dim) {
    // rust: self.tick_test(info);
}
    // rust: infos.retain(|i| !i.done);
    // rust: infos.append(&mut self.game_tests.ticker);
    // rust: self.game_tests.ticker = infos;
    // rust: self.game_tests.ticking = false;
    // rust: if std::mem::take(&mut self.game_tests.halting) {
    // rust: self.clear_game_tests();
}
}

    // ---- GameTestInfo ----

    /// `GameTestRunner.spawn`: a test with a block is prepared where it is
    /// (`StructureSpawner.IN_PLACE`), one without goes to the next place in
    /// the grid (`StructureGridSpawner.spawnStructure`), or is dropped
    /// (`NOT_SET`).
pub fn spawn_test(self: *Self, info: *mut Info) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dim = info.dim;
        // The test's own level is in place while it is prepared.
    // rust: match self.in_test_level(dim, |g| g.spawn_test_here(info)) {
    // rust: Some(spawned) => spawned,
    // rust: None => {
    // rust: log::error!("Could not resolve level for dimension: {}", dim.id());
    // rust: false
}
}
}

    /// `spawn_test` with the test's level in place.
pub fn spawn_test_here(self: *Self, info: *mut Info) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let in_place = !self
    // rust: .game_tests
    // rust: .runner
    // rust: .as_ref()
    // rust: .is_some_and(|r| r.grid_for_existing);
    // rust: if info.has_pos && in_place {
    // rust: if !self.prepare_test_structure(info) {
    // rust: return false;
}
    // rust: info.start_execution(1);
    // rust: self.test_structure_loaded(info);
    // rust: return true;
}
    // rust: let Some(mut grid) = self
    // rust: .game_tests
    // rust: .runner
    // rust: .as_mut()
    // rust: .and_then(|runner| runner.grid.take())
    // rust: else {
    // rust: return false;
}
        // `gridFor`: the dimension's grid starts where the source stands.
    // rust: let at = match grid.states.iter().position(|(d, _)| *d == info.dim) {
    // rust: Some(at) => at,
    // rust: None => {
    // rust: let first = self.test_position_in_level(grid.around);
    // rust: grid.states.push((info.dim, DimGrid::new(first)));
    // rust: grid.states.len() - 1
}
}
    // rust: let per_row = grid.per_row;
    // rust: let state = &mut grid.states[at].1;
    // rust: info.pos = state.next;
    // rust: info.has_pos = true;
    // rust: let prepared = self.prepare_test_structure(info);
    // rust: if prepared {
    // rust: state.last_batch.push(info.pos);
    // rust: info.start_execution(1);
    // rust: self.test_structure_loaded(info);
    // rust: if let Some(b) = self.test_bounding_box(info.pos) {
                // `getTestBounds()`: the structure's box and its padding.
    // rust: let width = b.max[0] - b.min[0] + 1;
    // rust: state.row_z = (state.row_z.0.min(b.min[2]), state.row_z.1.max(b.max[2] + 1));
    // rust: state.next.0 += width + 5;
    // rust: state.count += 1;
    // rust: if state.count >= per_row {
    // rust: state.count = 0;
    // rust: state.next.2 += state.row_z.1 - state.row_z.0 + 6;
    // rust: state.next.0 = state.first.0;
    // rust: state.row_z = (state.next.2, state.next.2 + 1);
}
}
}
    // rust: if let Some(runner) = self.game_tests.runner.as_mut() {
    // rust: runner.grid = Some(grid);
}
    // rust: prepared
}

    /// Run `f` with `dim`'s level in place (`enter_level`, as a command
    /// whose source is there), then put the level back. None when the level
    /// cannot be entered.
    // rust: pub(super) fn in_test_level<R>(
    // rust: &mut self,
    // rust: dim: Dim,
    // rust: f: impl FnOnce(&mut Self) -> R,
    // rust: ) -> Option<R> {
    // rust: if dim == self.dim {
    // rust: return Some(f(self));
}
    // rust: let back = self.enter_command_level(dim)?;
    // rust: let result = f(self);
    // rust: if let Err(e) = self.enter_level(None, back) {
    // rust: log::error!("could not return to {}: {e}", back.id());
}
    // rust: Some(result)
}

    /// `level.getChunk(pos)` for the chunks of `area`: forced (the test needs
    /// them kept) and waited for, as vanilla loads them synchronously.
    // rust: pub(super) fn load_test_chunks(&mut self, area: &BoundingBox) {
    // rust: let missing = |g: &Self| -> bool {
    // rust: (area.min[0] >> 4..=area.max[0] >> 4).any(|x| {
    // rust: (area.min[2] >> 4..=area.max[2] >> 4).any(|z| !g.world.chunks.contains_key(&(x, z)))
    // rust: })
}
    // rust: if !missing(self) {
    // rust: return;
}
    // rust: self.force_load_test_chunks(area);
    // rust: let deadline = Instant::now() + std::time::Duration::from_secs(120);
    // rust: while missing(self) && Instant::now() < deadline {
    // rust: let _ = self.streaming.update(&mut self.world);
    // rust: self.streaming.wait(std::time::Duration::from_millis(5));
}
}

    /// `ReportGameListener.testStructureLoaded`.
pub fn test_structure_loaded(self: *Self, info: *Info) void {
}
    // rust: if let Some(runner) = self.game_tests.runner.as_mut() {
    // rust: *report_of(&mut runner.reports, info.origin).0 += 1;
}
}

    /// `GameTestInfo.prepareTestStructure`: the test instance block with the
    /// test's data, then `placeStructure`. False when the block is gone.
pub fn prepare_test_structure(self: *Self, info: *mut Info) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pos = info.pos;
    // rust: self.load_test_chunks(&BoundingBox::new(
    // rust: [pos.0, pos.1, pos.2],
    // rust: [pos.0, pos.1, pos.2],
    // rust: ));
    // rust: self.set_test_block_state(pos, "minecraft:test_instance_block", flags::UPDATE_ALL);
    // rust: if self.test_instance_at(pos).is_none() {
    // rust: self.world.block_entities.insert(
    // rust: pos,
    // rust: BlockEntity::TestInstanceBlock(Box::<TestInstanceBlock>::default()),
    // rust: );
}
    // rust: let size = self
    // rust: .template_entry(&info.def.structure)
    // rust: .map_or([1, 1, 1], |entry| template_size(&entry.tag));
    // rust: if let Some(block) = self.test_instance_mut(pos) {
    // rust: block.data.test = Some(info.key.clone());
    // rust: block.data.size = size;
    // rust: block.data.rotation = info.extra_rotation;
    // rust: block.data.ignore_entities = false;
    // rust: block.data.status = Status::Cleared;
    // rust: block.data.error_message = None;
}
    // rust: self.mark_block_entity_updated(pos);
        // placeStructure
    // rust: if let Some(area) = self.test_bounding_box(pos) {
    // rust: self.load_test_chunks(&area);
}
    // rust: if !self.place_test_structure(pos) {
    // rust: let name = self.test_name(pos).plain();
    // rust: info.fail(Text::translate(
    // rust: "test.error.structure.failure",
    // rust: &[Text::literal(name)],
    // rust: ));
}
    // rust: info.placed = true;
    // rust: self.encase_test_structure(pos);
    // rust: if let Some(bounds) = self.test_bounding_box(pos) {
    // rust: self.clear_test_ticks(&bounds);
}
    // rust: true
}

    /// `getTestBoundingBox`: the structure's box and its padding.
    // rust: pub(super) fn test_bounding_box(&self, pos: Pos) -> Option<BoundingBox> {
    // rust: let padding = self.test_holder_padding(pos);
    // rust: let inner = self.test_structure_box(pos)?;
    // rust: Some(BoundingBox::new(
    // rust: inner.min.map(|v| v - padding),
    // rust: inner.max.map(|v| v + padding),
    // rust: ))
}

    /// `encaseStructure`: barriers around the box, but for the block itself.
pub fn encase_test_structure(self: *Self, pos: Pos) void {
}
    // rust: let block = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .default_state("minecraft:test_instance_block");
    // rust: for at in self.structure_boundary(pos) {
    // rust: if Some(self.world.block(at.0, at.1, at.2)) != block {
    // rust: self.set_test_block_state(at, "minecraft:barrier", flags::UPDATE_ALL);
}
}
}

    /// `GameTestInfo.tick`.
pub fn tick_test(self: *Self, info: *mut Info) void {
}
    // rust: if info.done {
    // rust: return;
}
    // rust: if !info.placed {
    // rust: info.fail(Text::translate("test.error.ticking_without_structure", &[]));
}
    // rust: let has_block = self.test_instance_at(info.pos).is_some();
    // rust: if !has_block {
    // rust: info.fail(Text::translate("test.error.missing_block_entity", &[]));
}
    // rust: if info.error.is_some() {
    // rust: info.finish();
    // rust: } else if !self.test_chunks_loaded(info.pos) {
    // rust: return;
}
    // rust: self.tick_internal(info);
    // rust: if std::mem::take(&mut info.discard_entities)
    // rust: && let Some(b) = self.test_structure_box(info.pos)
    // rust: {
            // `GameTestInfo.succeed`: `getStructureBounds().inflate(1.0)`.
    // rust: self.discard_entities_in(inflate(aabb_of(&b), 1.0));
}
    // rust: if info.done {
    // rust: self.test_finished(info);
}
}

    /// The chunks of the structure are loaded (`areEntitiesActuallyLoadedAndTicking`).
pub fn test_chunks_loaded(self: *Self, pos: Pos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(b) = self.test_structure_box(pos) else {
    // rust: return true;
}
    // rust: (b.min[0] >> 4..=b.max[0] >> 4).all(|cx| {
    // rust: (b.min[2] >> 4..=b.max[2] >> 4).all(|cz| self.world.chunks.contains_key(&(cx, cz)))
    // rust: })
}

    /// `GameTestInfo.tickInternal`.
pub fn tick_internal(self: *Self, info: *mut Info) void {
}
    // rust: info.tick_count += 1;
    // rust: if info.tick_count < 0 {
    // rust: return;
}
    // rust: if !info.started {
    // rust: self.start_test(info);
}
    // rust: let now = i64::from(info.tick_count);
    // rust: let (due, later): (Vec<_>, Vec<_>) = std::mem::take(&mut info.run_at)
    // rust: .into_iter()
    // rust: .partition(|(time, _)| *time <= now);
    // rust: info.run_at = later;
    // rust: for (_, action) in due {
    // rust: if let Err(error) = self.run_action(info, action) {
    // rust: info.error = Some(error);
}
}
    // rust: if info.tick_count > info.def.max_ticks {
            // No sequences: the test had no result in time.
    // rust: info.error = Some(TestError::Timeout(Text::translate(
    // rust: "test.error.timeout.no_result",
    // rust: &[number(info.def.max_ticks)],
    // rust: )));
}
}

    /// `GameTestInfo.startTest`.
pub fn start_test(self: *Self, info: *mut Info) void {
}
    // rust: info.started = true;
    // rust: info.started_at = Some(Instant::now());
    // rust: self.set_test_status(info.pos, Status::Running, None);
    // rust: if let Err(error) = self.run_instance(info) {
    // rust: info.error = Some(error);
}
}

    /// `GameTestInstance.run(helper)`.
pub fn run_instance(self: *Self, info: *mut Info) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if info.def.block_based {
    // rust: return self.run_block_based(info);
}
        // FunctionGameTestInstance: the function from the test function
        // registry (`BuiltinTestFunctions`).
    // rust: let function = info.def.function.as_deref().unwrap_or_default();
    // rust: let function = if function.contains(':') {
    // rust: function.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{function}")
}
    // rust: match function.as_str() {
            // ALWAYS_PASS: GameTestHelper::succeed.
    // rust: "minecraft:always_pass" => {
    // rust: info.succeed();
    // rust: Ok(())
}
    // rust: other => Err(TestError::Unknown(format!(
    // rust: "Trying to access missing test function: {other}"
    // rust: ))),
}
}

pub fn run_action(self: *Self, info: *mut Info, action: Action) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match action {
    // rust: Action::BlockBasedTick => self.block_based_tick(info),
}
}

    // ---- GameTestHelper ----

    /// `absolutePos`.
pub fn test_absolute_pos(self: *Self, info: *Info, relative: Pos) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let origin = self.test_origin(info);
    // rust: let moved = [
    // rust: origin[0] + relative.0,
    // rust: origin[1] + relative.1,
    // rust: origin[2] + relative.2,
    // rust: ];
    // rust: let [x, y, z] = StructureTemplate::transform(moved, Mirror::None, info.rotation(), origin);
    // rust: (x, y, z)
}

    /// `getTestOrigin`: the block entity's start corner.
pub fn test_origin(self: *Self, info: *Info) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let padding = info.def.padding;
    // rust: let rotation = self.test_rotation(info.pos);
    // rust: self.test_instance_at(info.pos).map_or([0; 3], |b| {
    // rust: b.start_corner([info.pos.0, info.pos.1, info.pos.2], padding, rotation)
    // rust: })
}

    /// `assertionException(pos, description)`.
pub fn pos_assertion(self: *Self, info: *Info, relative: Pos, message: Text) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TestError::AssertPos {
    // rust: message,
    // rust: absolute: self.test_absolute_pos(info, relative),
    // rust: relative,
    // rust: tick: info.tick_count,
}
}

    /// `getBlockEntity(pos, TestBlockEntity.class)`: the absolute position of
    /// the test block.
pub fn test_block_entity(self: *Self, info: *Info, relative: Pos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let absolute = self.test_absolute_pos(info, relative);
    // rust: match self.world.block_entities.get(&absolute) {
    // rust: None => Err(self.pos_assertion(
    // rust: info,
    // rust: relative,
    // rust: Text::translate("test.error.missing_block_entity", &[]),
    // rust: )),
    // rust: Some(BlockEntity::TestBlock(_)) => Ok(absolute),
    // rust: Some(other) => Err(self.pos_assertion(
    // rust: info,
    // rust: relative,
    // rust: Text::translate(
    // rust: "test.error.wrong_block_entity",
    // rust: &[Text::literal(other.id().to_owned())],
    // rust: ),
    // rust: )),
}
}

    /// `forEveryBlockInStructure`: the template-relative positions, x then
    /// y then z.
pub fn test_relative_positions(self: *Self, info: *Info) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(b) = self.test_structure_box(info.pos) else {
    // rust: return Vec::new();
}
    // rust: let size = [
    // rust: b.max[0] - b.min[0] + 1,
    // rust: b.max[1] - b.min[1] + 1,
    // rust: b.max[2] - b.min[2] + 1,
    // rust: ];
    // rust: let size = match info.rotation() {
    // rust: Rotation::Clockwise90 | Rotation::Counterclockwise90 => [size[2], size[1], size[0]],
    // rust: _ => size,
}
    // rust: let mut out = Vec::new();
    // rust: for z in 0..size[2] {
    // rust: for y in 0..size[1] {
    // rust: for x in 0..size[0] {
    // rust: out.push((x, y, z));
}
}
}
    // rust: out
}

    /// `BlockBasedTestInstance.findTestBlocks`.
pub fn find_test_blocks(self: *Self, info: *Info, mode: TestBlockMode) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = self.pack.assets.registry;
    // rust: self.test_relative_positions(info)
    // rust: .into_iter()
    // rust: .filter(|&relative| {
    // rust: let at = self.test_absolute_pos(info, relative);
    // rust: registry
    // rust: .state(self.world.block(at.0, at.1, at.2))
    // rust: .is_some_and(|s| {
    // rust: &*s.name == "minecraft:test_block"
    // rust: && s.properties.get("mode").map(String::as_str)
    // rust: == Some(mode.serialized_name())
    // rust: })
    // rust: })
    // rust: .collect()
}

    // ---- BlockBasedTestInstance ----

    /// `BlockBasedTestInstance.run`.
pub fn run_block_based(self: *Self, info: *mut Info) R {
    // Implementation ported from Horizon
    return undefined;
}
        // findStartBlock
    // rust: let starts = self.find_test_blocks(info, TestBlockMode::Start);
    // rust: let missing = |game: &Self, info: &Info, key: &str, mode: TestBlockMode| {
    // rust: game.info_failure(
    // rust: info,
    // rust: Text::translate(key, &[Text::translate(&mode.label_key(), &[])]),
    // rust: )
}
    // rust: if starts.is_empty() {
    // rust: return Err(missing(
    // rust: self,
    // rust: info,
    // rust: "test_block.error.missing",
    // rust: TestBlockMode::Start,
    // rust: ));
}
    // rust: if starts.len() != 1 {
    // rust: return Err(missing(
    // rust: self,
    // rust: info,
    // rust: "test_block.error.too_many",
    // rust: TestBlockMode::Start,
    // rust: ));
}
    // rust: let start = self.test_block_entity(info, starts[0])?;
    // rust: self.trigger_test_block(start);
    // rust: info.on_each_tick(Action::BlockBasedTick);
    // rust: Ok(())
}

    /// `helper.fail(message)`: the exception it throws.
pub fn info_failure(self: *Self, info: *Info, message: Text) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: info.assertion(message)
}

    /// The body of `BlockBasedTestInstance.run`'s `onEachTick`.
pub fn block_based_tick(self: *Self, info: *mut Info) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let accepts = self.find_test_blocks(info, TestBlockMode::Accept);
    // rust: if accepts.is_empty() {
    // rust: return Err(self.info_failure(
    // rust: info,
    // rust: Text::translate(
    // rust: "test_block.error.missing",
    // rust: &[Text::translate(&TestBlockMode::Accept.label_key(), &[])],
    // rust: ),
    // rust: ));
}
    // rust: let mut accepted = false;
    // rust: for relative in accepts {
    // rust: let at = self.test_block_entity(info, relative)?;
    // rust: accepted |= self.test_block_triggered(at);
}
    // rust: if accepted {
    // rust: info.succeed();
    // rust: return Ok(());
}
        // forAllTriggeredTestBlocks(FAIL, fail with the block's message)
    // rust: for relative in self.find_test_blocks(info, TestBlockMode::Fail) {
    // rust: let at = self.test_block_entity(info, relative)?;
    // rust: if self.test_block_triggered(at) {
    // rust: let message = self.test_block_message(at);
    // rust: return Err(self.info_failure(info, Text::literal(message)));
}
}
        // forAllTriggeredTestBlocks(LOG, trigger), each one reset after
    // rust: for relative in self.find_test_blocks(info, TestBlockMode::Log) {
    // rust: let at = self.test_block_entity(info, relative)?;
    // rust: if self.test_block_triggered(at) {
    // rust: self.trigger_test_block(at);
    // rust: self.reset_test_block(at);
}
}
    // rust: Ok(())
}

    // ---- TestInstanceBlockEntity ----

    /// `setRunning`, `setSuccess` and `setErrorMessage`: the status and the
    /// error message it carries (`withStatus` clears it).
pub fn set_test_status(self: *Self, pos: Pos, status: Status, error: ?*Text) void {
}
    // rust: let Some(block) = self.test_instance_mut(pos) else {
    // rust: return;
}
    // rust: block.data.status = status;
    // rust: block.data.error_message = error.map(|t| component_nbt(&t.component()));
    // rust: self.mark_block_entity_updated(pos);
}

    /// `markError`.
pub fn mark_test_error(self: *Self, pos: Pos, at: Pos, message: *Text) void {
}
    // rust: let Some(block) = self.test_instance_mut(pos) else {
    // rust: return;
}
    // rust: block.error_markers.push(ErrorMarker {
    // rust: pos: [at.0, at.1, at.2],
    // rust: text: component_nbt(&message.component()),
    // rust: });
    // rust: self.mark_block_entity_updated(pos);
}

    // ---- listeners ----

    /// The listeners of a finished test, in the order they were added:
    /// `ReportGameListener`, the `TestSummaryDisplayer`, the failure tracker
    /// and the runner's batch listener.
pub fn test_finished(self: *Self, info: *Info) void {
}
    // rust: let passed = info.error.is_none();
    // rust: self.report_game_test(info, passed);
        // TestSummaryDisplayer: only the tests the command started (the
        // listener is not passed on to a rerun's copy).
    // rust: let Some(runner) = self.game_tests.runner.as_mut() else {
    // rust: return;
}
    // rust: let tracked = runner.tracked.iter_mut().find(|t| t.id == info.id);
    // rust: let counted = tracked.is_some();
    // rust: if let Some(t) = tracked {
    // rust: t.done = true;
    // rust: t.failed = !passed;
}
    // rust: let all_done = counted && runner.tracked.iter().all(|t| t.done);
    // rust: let total = runner.tracked.len();
    // rust: let failed_required = runner
    // rust: .tracked
    // rust: .iter()
    // rust: .filter(|t| t.failed && t.required)
    // rust: .count();
    // rust: let failed_optional = runner
    // rust: .tracked
    // rust: .iter()
    // rust: .filter(|t| t.failed && !t.required)
    // rust: .count();
    // rust: let halt = runner.halt_on_error;
    // rust: if all_done {
    // rust: let out = &mut self.game_tests.outbox;
    // rust: out.push(Out::Console {
    // rust: text: Text::translate("commands.test.summary", &[number(total as i32)])
    // rust: .with_color(text::WHITE),
    // rust: broadcast: true,
    // rust: });
    // rust: if failed_required > 0 {
    // rust: out.push(Out::Console {
    // rust: text: Text::translate(
    // rust: "commands.test.summary.failed",
    // rust: &[number(failed_required as i32)],
    // rust: )
    // rust: .with_color(text::RED),
    // rust: broadcast: false,
    // rust: });
    // rust: } else {
    // rust: out.push(Out::Console {
    // rust: text: Text::translate("commands.test.summary.all_required_passed", &[])
    // rust: .with_color(text::GREEN),
    // rust: broadcast: true,
    // rust: });
}
    // rust: if failed_optional > 0 {
    // rust: out.push(Out::Console {
    // rust: text: Text::translate(
    // rust: "commands.test.summary.optional_failed",
    // rust: &[number(failed_optional as i32)],
    // rust: ),
    // rust: broadcast: false,
    // rust: });
}
}
        // FailedTestTracker.rememberFailedTest
    // rust: if !passed && counted {
    // rust: self.game_tests.failed.push(info.key.clone());
}
        // The runner's batch listener.
    // rust: if passed {
    // rust: self.remove_test_barriers(info.pos);
    // rust: } else if halt {
    // rust: self.release_forced_chunks();
    // rust: self.clear_game_tests();
    // rust: return;
}
    // rust: let Some(runner) = self.game_tests.runner.as_mut() else {
    // rust: return;
}
    // rust: runner.batch_pending = runner.batch_pending.saturating_sub(1);
    // rust: if runner.batch_pending == 0 {
    // rust: let next = runner.current + 1;
    // rust: self.release_forced_chunks();
    // rust: self.run_batch(next);
}
}

    /// `ReportGameListener.testPassed` and `testFailed`.
pub fn report_game_test(self: *Self, info: *Info, passed: bool) void {
}
    // rust: let Some(runner) = self.game_tests.runner.as_mut() else {
    // rust: return;
}
    // rust: let (attempts, successes) = report_of(&mut runner.reports, info.origin);
    // rust: if passed {
    // rust: *successes += 1;
}
    // rust: let (attempts, successes) = (*attempts, *successes);
    // rust: let (max_attempts, required) = (info.def.max_attempts, info.def.required_successes);
    // rust: let flaky = max_attempts > 1;
    // rust: let retry = info.retry;
    // rust: let again = if passed {
    // rust: if retry.has_retries() {
    // rust: let line = retry_line(info, retry, attempts, successes, true);
    // rust: self.report_passed(info, &line);
    // rust: retry.has_tries_left(attempts, successes)
    // rust: } else if !flaky {
    // rust: let line = format!(
    // rust: "{} passed! ({}ms / {}gameticks)",
    // rust: info.key, info.run_ms, info.tick_count
    // rust: );
    // rust: self.report_passed(info, &line);
    // rust: false
    // rust: } else if successes >= required {
    // rust: let line = format!(
    // rust: "{} passed {successes} times of {attempts} attempts.",
    // rust: info.key
    // rust: );
    // rust: self.report_passed(info, &line);
    // rust: false
    // rust: } else {
    // rust: self.say(
    // rust: text::GREEN,
    // rust: format!(
    // rust: "Flaky test {} succeeded, attempt: {attempts} successes: {successes}",
    // rust: info.key
    // rust: ),
    // rust: );
    // rust: true
}
    // rust: } else if !flaky {
    // rust: self.report_failure(info, None);
    // rust: if retry.has_retries() {
    // rust: let line = retry_line(info, retry, attempts, successes, false);
    // rust: self.say(text::RED, line);
    // rust: retry.has_tries_left(attempts, successes)
    // rust: } else {
    // rust: false
}
    // rust: } else {
    // rust: let mut line = format!(
    // rust: "Flaky test {} failed, attempt: {attempts}/{max_attempts}",
    // rust: info.key
    // rust: );
    // rust: if required > 1 {
    // rust: line.push_str(&format!(", successes: {successes} ({required} required)"));
}
    // rust: self.say(text::YELLOW, line);
    // rust: if max_attempts - attempts + successes >= required {
    // rust: true
    // rust: } else {
    // rust: self.report_failure(info, Some((attempts, successes)));
    // rust: false
}
}
    // rust: if again {
    // rust: self.rerun_test(info);
}
}

    /// `ReportGameListener.reportPassed`.
pub fn report_passed(self: *Self, info: *Info, line: []const u8) void {
}
    // rust: self.set_test_status(info.pos, Status::Finished, None);
    // rust: self.say(text::GREEN, line.to_owned());
}

    /// `ReportGameListener.reportFailure`: the test's own error, or the
    /// `ExhaustedAttemptsException` of a flaky test that ran out of
    /// attempts (`attempts`, `successes`), whose cause is the test's error.
pub fn report_failure(self: *Self, info: *Info, exhausted: Option<(i32) void {
}
    // rust: let Some(error) = &info.error else {
    // rust: return;
}
    // rust: let (description, message) = match exhausted {
    // rust: None => (error.description(), error.message()),
    // rust: Some((attempts, successes)) => {
    // rust: let text = format!(
    // rust: "Not enough successes: {successes} out of {attempts} attempts. Required successes: {}. max attempts: {}.",
    // rust: info.def.required_successes, info.def.max_attempts
    // rust: );
                // describeError(error) is the cause's message.
    // rust: let cause = error.message();
    // rust: (
    // rust: Text::literal(cause.clone()),
    // rust: format!("{text} cause: {cause}"),
    // rust: )
}
}
    // rust: self.set_test_status(info.pos, Status::Finished, Some(&description));
    // rust: let required = info.def.required;
    // rust: let message = format!(
    // rust: "{}{} failed! {}",
    // rust: if required { "" } else { "(optional) " },
    // rust: info.key,
    // rust: message
    // rust: );
    // rust: self.say(if required { text::RED } else { text::YELLOW }, message);
    // rust: if let TestError::AssertPos {
    // rust: message, absolute, ..
    // rust: } = error
    // rust: {
    // rust: self.mark_test_error(info.pos, *absolute, message);
}
}

    /// `ReportGameListener.say`.
pub fn say(self: *Self, color: u32, text: []const u8) void {
}
    // rust: self.game_tests
    // rust: .outbox
    // rust: .push(Out::Players(Text::literal(text).with_color(color)));
}

    /// Sends what the runner said: the server's console log (and the
    /// operators, when it broadcasts) and the players' chat.
pub fn flush_game_test_output(self: *Self) void {
}
    // rust: for out in std::mem::take(&mut self.game_tests.outbox) {
    // rust: match out {
    // rust: Out::Console { text, broadcast } => {
    // rust: let plain = text.plain();
    // rust: if self.options.dedicated.is_some() {
    // rust: super::dedicated::log("INFO", &plain);
    // rust: } else {
    // rust: log::info!("{plain}");
}
    // rust: if broadcast {
                        // CommandSourceStack.broadcastToAdmins as the server.
    // rust: self.console_broadcast = Some(true);
    // rust: self.broadcast_to_admins(text);
    // rust: self.console_broadcast = None;
    // rust: if let Some(mut host) = self.lan.take() {
    // rust: self.send_admin_feedback(&mut host, None);
    // rust: self.lan = Some(host);
}
    // rust: self.admin_feedback.clear();
}
}
    // rust: Out::Players(text) => {
    // rust: if let Some(host) = self.lan.as_ref() {
    // rust: host.hub.system_message(component_nbt(&text.component()));
}
    // rust: if self.serving.is_none() && self.options.dedicated.is_none() {
    // rust: self.system_message(text);
}
}
}
}
}
}

/// `ReportGameListener.handleRetry`'s line: the counters, then the test's
/// result.
pub fn retry_line(info: *Info, retry: Retry, attempts: i32, successes: i32, passed: bool) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut report = format!(
    // rust: "[Run: {attempts:>4}, Ok: {successes:>4}, Fail: {:>4}",
    // rust: attempts - successes
    // rust: );
    // rust: if !retry.unlimited() {
    // rust: report.push_str(&format!(", Left: {:>4}", retry.number_of_tries - attempts));
}
    // rust: report.push(']');
    // rust: let name = format!(
    // rust: "{} {}! {}ms",
    // rust: info.key,
    // rust: if passed { "passed" } else { "failed" },
    // rust: info.run_ms
    // rust: );
    // rust: format!("{report:<53}{name}")
}

    // rust: mod tests {
//     use super::*;

pub fn info(block_based: bool, max_ticks: i32, setup_ticks: i32) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Info::new(
    // rust: 1,
    // rust: "minecraft:t".into(),
    // rust: TestDef::sample(block_based, max_ticks, setup_ticks),
    // rust: Some((0, 64, 0)),
    // rust: Dim::Overworld,
    // rust: Rotation::None,
    // rust: )
}

pub fn a_test_keeps_its_level_awake_until_it_is_done() void {
}
    // rust: let mut tests = GameTests::default();
    // rust: assert!(!tests.has_tests_in(Dim::Nether));
    // rust: let mut nether = info(false, 10, 0);
    // rust: nether.dim = Dim::Nether;
    // rust: tests.ticker.push(nether);
    // rust: assert!(tests.has_tests_in(Dim::Nether));
    // rust: assert!(!tests.has_tests_in(Dim::Overworld));
        // A rerun keeps the level of the test it copies.
    // rust: assert_eq!(tests.ticker[0].copy_reset(2).dim, Dim::Nether);
}

pub fn a_grid_has_a_state_per_dimension_starting_at_its_own_corner() void {
}
    // rust: let mut grid = Grid::new((4, 9), 10).clearing();
    // rust: assert!(grid.clear_on_batch);
    // rust: grid.states
    // rust: .push((Dim::Overworld, DimGrid::new((4, 70, 12))));
    // rust: grid.states.push((Dim::Nether, DimGrid::new((4, 32, 12))));
    // rust: let nether = &grid.states[1].1;
    // rust: assert_eq!(nether.next, (4, 32, 12));
    // rust: assert_eq!(nether.row_z, (12, 13));
}

pub fn verify_runs_each_rotation_a_hundred_times_in_its_own_batch() void {
}
    // rust: let mut id = 0;
    // rust: let batches = verify_batches(&[info(true, 100, 0)], || {
    // rust: id += 1;
    // rust: id
    // rust: });
    // rust: assert_eq!(batches.len(), 4);
    // rust: for (i, batch) in batches.iter().enumerate() {
    // rust: assert_eq!(batch.index, i as i32);
    // rust: assert_eq!(batch.infos.len(), 100);
    // rust: assert!(
    // rust: batch
    // rust: .infos
    // rust: .iter()
    // rust: .all(|t| t.extra_rotation == Rotation::ALL[i])
    // rust: );
}
    // rust: assert_eq!(id, 400);
}

pub fn start_execution_waits_for_the_setup_ticks_and_the_delay() void {
}
        // always_pass: setup_ticks 1, delay 1: ticks -2, -1 and 0 follow.
    // rust: let mut i = info(false, 1, 1);
    // rust: i.start_execution(1);
    // rust: assert_eq!(i.tick_count, -3);
}

pub fn on_each_tick_runs_every_tick_up_to_the_timeout() void {
}
    // rust: let mut i = info(true, 5, 0);
    // rust: i.tick_count = 2;
    // rust: i.on_each_tick(Action::BlockBasedTick);
    // rust: let times: Vec<i64> = i.run_at.iter().map(|(t, _)| *t).collect();
    // rust: assert_eq!(times, vec![2, 3, 4]);
}

pub fn a_failure_is_not_overwritten_by_success_and_stamps_the_tick() void {
}
    // rust: let mut i = info(true, 5, 0);
    // rust: i.tick_count = 3;
    // rust: i.fail(Text::literal("boom"));
    // rust: i.succeed();
    // rust: assert!(!i.done);
    // rust: assert!(matches!(i.error, Some(TestError::Assert { tick: 3, .. })));
    // rust: let mut ok = info(true, 5, 0);
    // rust: ok.succeed();
    // rust: assert!(ok.done && ok.error.is_none());
}

pub fn unknown_errors_report_their_reason() void {
}
    // rust: let error = TestError::Unknown("no such function".into());
    // rust: assert_eq!(error.message(), "no such function");
}

pub fn retry_options_decide_whether_a_test_runs_again() void {
}
        // noRetries: one try, no rerun.
    // rust: assert!(!Retry::none().has_retries());
    // rust: assert!(!Retry::none().has_tries_left(1, 1));
        // 3 times, not until failed: runs on through failures.
    // rust: let three = Retry::new(3, false);
    // rust: assert!(three.has_retries());
    // rust: assert!(three.has_tries_left(1, 0));
    // rust: assert!(three.has_tries_left(2, 2));
    // rust: assert!(!three.has_tries_left(3, 3));
        // Until failed: stops at the first failure, and 0 means unlimited.
    // rust: let until = Retry::new(0, true);
    // rust: assert!(until.unlimited());
    // rust: assert!(until.has_tries_left(50, 50));
    // rust: assert!(!until.has_tries_left(50, 49));
}

pub fn a_retry_line_counts_runs_and_pads_to_53() void {
}
    // rust: let info = info(true, 10, 0);
    // rust: let line = retry_line(&info, Retry::new(5, false), 2, 1, false);
    // rust: assert!(line.starts_with("[Run:    2, Ok:    1, Fail:    1, Left:    3]"));
    // rust: assert_eq!(line.find("minecraft:t"), Some(53));
    // rust: assert!(line.ends_with("minecraft:t failed! 0ms"));
    // rust: let unlimited = retry_line(&info, Retry::new(0, true), 1, 1, true);
    // rust: assert!(unlimited.starts_with("[Run:    1, Ok:    1, Fail:    0]"));
}

pub fn a_rerun_is_a_copy_that_shares_the_originals_counters() void {
}
    // rust: let original = info(true, 10, 0).with_retry(Retry::new(2, false));
    // rust: let copy = original.copy_reset(9);
    // rust: assert_eq!((copy.id, copy.origin, copy.rerun), (9, 1, true));
    // rust: assert_eq!(copy.retry, original.retry);
    // rust: assert!(copy.has_pos && copy.pos == original.pos);
    // rust: let mut reports = Vec::new();
    // rust: *report_of(&mut reports, copy.origin).0 += 1;
    // rust: *report_of(&mut reports, original.origin).1 += 1;
    // rust: assert_eq!(reports, vec![(1, 1, 1)]);
}
}
