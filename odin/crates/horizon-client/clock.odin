//! Transpiled from Horizon Rust crate
package horizon_client_clock

import "core:fmt"
import "core:mem"
import "core:math"

// `DeltaTracker.Timer` and the tick-rate managers of 26.3: how real
// milliseconds turn into game ticks, partial ticks and real-time deltas, and
// the `/tick` freeze, step and sprint state.

// `HORIZON_STILL=1`, read once (`FixedStep::still`).
still_requested :: proc() -> b {
    // Ported from Horizon
    return {}
}
STILL :: std::sync::OnceLock::new()
    // rust: *STILL.get_or_init(|| {
    // rust: let on = std::env::var("HORIZON_STILL").is_ok_and(|v| v == "1");
    // rust: if on {
    // rust: log::warn!("HORIZON_STILL=1: worlds start frozen (/tick unfreeze), frames follow the world's ticks");
}
    // rust: on
    // rust: })
}

// `DeltaTracker.Timer`: float arithmetic on integer milliseconds, exactly as
// the client does it.
Timer :: struct {
    delta_ticks: f32,
    delta_tick_residual: f32,
    realtime_delta_ticks: f32,
    paused_delta_tick_residual: f32,
    last_ms: i64,
    last_ui_ms: i64,
    ms_per_tick: f32,
    paused: bool,
    frozen: bool,
}

    // rust: impl Timer {
new :: proc(ticks_per_second: f32, current_ms: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: delta_ticks: 0.0,
    // rust: delta_tick_residual: 0.0,
    // rust: realtime_delta_ticks: 0.0,
    // rust: paused_delta_tick_residual: 0.0,
    // rust: last_ms: current_ms,
    // rust: last_ui_ms: current_ms,
    // rust: ms_per_tick: 1000.0 / ticks_per_second,
    // rust: paused: false,
    // rust: frozen: false,
}
}

    // `advanceGameTime`: the whole ticks to run now. `target_mspt` maps the
    // default milliseconds per tick to the target in force (the tick-rate
    // manager's, when the level runs normally). The caller runs at most ten.
    // rust: pub fn advance_game_time(
    // rust: &mut self,
    // rust: current_ms: i64,
    // rust: target_mspt: impl FnOnce(f32) -> f32,
    // rust: ) -> i32 {
    // rust: self.delta_ticks = (current_ms - self.last_ms) as f32 / target_mspt(self.ms_per_tick);
    // rust: self.last_ms = current_ms;
    // rust: self.delta_tick_residual += self.delta_ticks;
    // rust: let ticks = self.delta_tick_residual as i32;
    // rust: self.delta_tick_residual -= ticks as f32;
    // rust: ticks
}

    // `advanceRealTime`.
advance_real_time :: proc(self: ^Self, current_ms: i64) {
}
    // rust: self.realtime_delta_ticks = (current_ms - self.last_ui_ms) as f32 / self.ms_per_tick;
    // rust: self.last_ui_ms = current_ms;
}

    // `updatePauseState`.
update_pause_state :: proc(self: ^Self, pause: bool) {
}
    // rust: if pause {
    // rust: if !self.paused {
    // rust: self.paused_delta_tick_residual = self.delta_tick_residual;
}
    // rust: self.paused = true;
    // rust: } else {
    // rust: if self.paused {
    // rust: self.delta_tick_residual = self.paused_delta_tick_residual;
}
    // rust: self.paused = false;
}
}

    // `updateFrozenState`.
update_frozen_state :: proc(self: ^Self, frozen: bool) {
}
    // rust: self.frozen = frozen;
}

game_time_delta_ticks :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.delta_ticks
}

    // `getGameTimeDeltaPartialTick`.
game_time_delta_partial_tick :: proc(self: ^Self, ignore_frozen_game: bool) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if !ignore_frozen_game && self.frozen {
    // rust: 1.0
    // rust: } else if self.paused {
    // rust: self.paused_delta_tick_residual
    // rust: } else {
    // rust: self.delta_tick_residual
}
}

    // `getRealtimeDeltaTicks`.
realtime_delta_ticks :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.realtime_delta_ticks > 7.0 {
    // rust: 0.5
    // rust: } else {
    // rust: self.realtime_delta_ticks
}
}
}

NANOSECONDS_PER_SECOND :: 1_000_000_000
NANOSECONDS_PER_MILLISECOND :: 1_000_000

// `TickRateManager`.
TickRateManager :: struct {
    tickrate: f32,
    nanoseconds_per_tick: i64,
    frozen_ticks_to_run: i32,
    run_game_elements: bool,
    is_frozen: bool,
}

    // rust: impl Default for TickRateManager {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: tickrate: 20.0,
    // rust: nanoseconds_per_tick: NANOSECONDS_PER_SECOND / 20,
    // rust: frozen_ticks_to_run: 0,
    // rust: run_game_elements: true,
    // rust: is_frozen: false,
}
}
}

    // rust: impl TickRateManager {
    // `setTickRate` (`Math.max(rate, 1.0F)`, NaN propagates).
set_tick_rate :: proc(self: ^Self, rate: f32) {
}
    // rust: self.tickrate = if rate.is_nan() || rate > 1.0 {
    // rust: rate
    // rust: } else {
    // rust: 1.0
}
    // rust: self.nanoseconds_per_tick =
    // rust: (NANOSECONDS_PER_SECOND as f64 / f64::from(self.tickrate)) as i64;
}
tickrate :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.tickrate
}
milliseconds_per_tick :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.nanoseconds_per_tick as f32 / NANOSECONDS_PER_MILLISECOND as f32
}
nanoseconds_per_tick :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.nanoseconds_per_tick
}
runs_normally :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.run_game_elements
}
is_stepping_forward :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.frozen_ticks_to_run > 0
}
set_frozen_ticks_to_run :: proc(self: ^Self, ticks: i32) {
}
    // rust: self.frozen_ticks_to_run = ticks;
}
frozen_ticks_to_run :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.frozen_ticks_to_run
}
set_frozen :: proc(self: ^Self, frozen: bool) {
}
    // rust: self.is_frozen = frozen;
}
is_frozen :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_frozen
}
    // `tick`: decides whether game elements run this tick.
tick :: proc(self: ^Self) {
}
    // rust: self.run_game_elements = !self.is_frozen || self.frozen_ticks_to_run > 0;
    // rust: if self.frozen_ticks_to_run > 0 {
    // rust: self.frozen_ticks_to_run -= 1;
}
}
}

// What `/tick sprint` reports when it ends.
SprintReport :: struct {
    ticks_per_second: i32,
    milliseconds_per_tick: string,
}

// `ServerTickRateManager`: the freeze, step and sprint state kept by the
// server (the broadcasts to clients are the caller's concern).
ServerTickRateManager :: struct {
    base: TickRateManager,
    remaining_sprint_ticks: i64,
    sprint_tick_start_time: i64,
    sprint_time_spend: i64,
    scheduled_current_sprint_ticks: i64,
    previous_is_frozen: bool,
}

    // rust: impl ServerTickRateManager {
is_sprinting :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.scheduled_current_sprint_ticks > 0
}
remaining_sprint_ticks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.remaining_sprint_ticks
}
    // `stepGameIfPaused`.
step_game_if_paused :: proc(self: ^Self, ticks: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if !self.base.is_frozen() {
    // rust: return false;
}
    // rust: self.base.set_frozen_ticks_to_run(ticks);
    // rust: true
}
    // `stopStepping`.
stop_stepping :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.base.frozen_ticks_to_run() > 0 {
    // rust: self.base.set_frozen_ticks_to_run(0);
    // rust: true
    // rust: } else {
    // rust: false
}
}
    // `stopSprinting`.
stop_sprinting :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.remaining_sprint_ticks > 0 {
    // rust: Some(self.finish_tick_sprint())
    // rust: } else {
    // rust: None
}
}
    // `requestGameToSprint`: true when an earlier sprint was interrupted.
request_game_to_sprint :: proc(self: ^Self, time: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let interrupted = self.remaining_sprint_ticks > 0;
    // rust: self.sprint_time_spend = 0;
    // rust: self.scheduled_current_sprint_ticks = i64::from(time);
    // rust: self.remaining_sprint_ticks = i64::from(time);
    // rust: self.previous_is_frozen = self.base.is_frozen();
    // rust: self.base.set_frozen(false);
    // rust: interrupted
}
finish_tick_sprint :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let completed_ticks = self.scheduled_current_sprint_ticks - self.remaining_sprint_ticks;
    // rust: let milliseconds_to_complete =
    // rust: (self.sprint_time_spend.max(1)) as f64 / NANOSECONDS_PER_MILLISECOND as f64;
    // rust: let ticks_per_second = (1000.0 * completed_ticks as f64 / milliseconds_to_complete) as i32;
    // rust: let per_tick = if completed_ticks == 0 {
    // rust: f64::from(self.base.milliseconds_per_tick())
    // rust: } else {
    // rust: milliseconds_to_complete / completed_ticks as f64
}
    // rust: self.scheduled_current_sprint_ticks = 0;
    // rust: self.sprint_time_spend = 0;
    // rust: self.remaining_sprint_ticks = 0;
    // rust: self.base.set_frozen(self.previous_is_frozen);
    // rust: SprintReport {
    // rust: ticks_per_second,
    // rust: milliseconds_per_tick: crate::java_text::format_fixed2(per_tick),
}
}
    // `checkShouldSprintThisTick`: whether to run this tick without waiting,
    // plus the report when the sprint just finished.
check_should_sprint_this_tick :: proc(self: ^Self, now_ns: i64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if !self.base.run_game_elements {
    // rust: (false, None)
    // rust: } else if self.remaining_sprint_ticks > 0 {
    // rust: self.sprint_tick_start_time = now_ns;
    // rust: self.remaining_sprint_ticks -= 1;
    // rust: (true, None)
    // rust: } else {
    // rust: (false, Some(self.finish_tick_sprint()))
}
}
    // `endTickWork`.
end_tick_work :: proc(self: ^Self, now_ns: i64) {
}
    // rust: self.sprint_time_spend += now_ns - self.sprint_tick_start_time;
}
    // `setTickRate`.
set_tick_rate :: proc(self: ^Self, rate: f32) {
}
    // rust: self.base.set_tick_rate(rate);
}
}

// Ticks one sprint frame may run (rendering carries on between frames).
SPRINT_PER_FRAME :: 40
SAMPLES :: 100

// A step command's broadcast value and the ticks still owed to a new client.
// `ServerTickRateManager.updateStepTicks` sends the former immediately;
// `ServerTickRateManager.updateJoiningPlayer` sends the latter on a join.
StepState :: struct {
    revision: u32,
    requested: i32,
    remaining: i32,
}

// The game's clock: `DeltaTracker.Timer` pacing driven by the
// `ServerTickRateManager` the `/tick` command controls, over a virtual
// millisecond clock built from the frame times it is fed. The integrated
// simulation is one loop, so the tick rate paces it directly (the vanilla
// client timer only ever slows down, because its server ticks separately).
FixedStep :: struct {
    timer: Timer,
    manager: ServerTickRateManager,
    now: std::time::Duration,
    pause: bool,
    sprint_checked: bool,
    sprint_report: Maybe(SprintReport),
    tick_times: [i64,
    aggregated: i64,
    tick_count: i64,
    // A server's client: its level's tick rate only slows the timer down
    // (`Minecraft.getTickTargetMillis`), since the server runs the ticks.
    client: bool,
    // How many times `/tick step` started or stopped a step
    // (`ServerTickRateManager.updateStepTicks` broadcasts each one).
    step_changes: u32,
    step_requested: i32,
    // `HORIZON_STILL=1`, a dev switch for screenshots that come out the same every run: the
    // world starts frozen, and while it is, the camera's partial tick is held at 1 as the
    // level's is. With the frame's other time (`Game::visual_ticks`) following the world's
    // ticks, a frozen scene draws the same frame every time, and `/tick step` moves it on by
    // whole ticks.
    still: bool,
}

    // rust: impl Default for FixedStep {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::new(still_requested())
}
}

    // rust: impl FixedStep {
new :: proc(still: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut clock = Self {
    // rust: timer: Timer::new(20.0, 0),
    // rust: manager: ServerTickRateManager::default(),
    // rust: now: std::time::Duration::ZERO,
    // rust: pause: false,
    // rust: sprint_checked: false,
    // rust: sprint_report: None,
    // rust: tick_times: [0; SAMPLES],
    // rust: aggregated: 0,
    // rust: tick_count: 0,
    // rust: client: false,
    // rust: step_changes: 0,
    // rust: step_requested: 0,
    // rust: still,
}
        // Frozen before any tick: how many run while the world loads differs between runs.
    // rust: clock.manager.base.set_frozen(still);
    // rust: clock
}
    // `HORIZON_STILL` (`still`).
still :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.still
}
    // The clock of a client connected to a server: the `ClientLevel`'s
    // `TickRateManager`, set by the server's ticking packets.
client :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: client: true,
    // rust: ..Self::default()
}
}
now_ms :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.now.as_millis() as i64
}
now_ns :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.now.as_nanos() as i64
}
    // The length of one tick at the current rate.
tick_duration :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: std::time::Duration::from_nanos(self.manager.base.nanoseconds_per_tick().max(1) as u64)
}
    // Feed one frame's elapsed time; returns the ticks to run (at most ten,
    // or a sprint frame's worth).
advance :: proc(self: ^Self, elapsed: std::time::Duration) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.now += elapsed;
    // rust: let now_ms = self.now_ms();
    // rust: if self.manager.is_sprinting() {
            // Keep the timer current so leaving the sprint does not replay it.
    // rust: self.timer.advance_game_time(now_ms, |d| d);
    // rust: let remaining = self.manager.remaining_sprint_ticks();
            // One extra pass lets the sprint finish and report.
    // rust: return (remaining + 1).min(SPRINT_PER_FRAME) as u32;
}
    // rust: let runs = self.manager.base.runs_normally();
    // rust: let mspt = self.manager.base.milliseconds_per_tick();
    // rust: let client = self.client;
    // rust: let ticks = self
    // rust: .timer
    // rust: .advance_game_time(now_ms, |default| match (runs, client) {
    // rust: (true, true) => default.max(mspt),
    // rust: (true, false) => mspt,
    // rust: (false, _) => default,
    // rust: });
    // rust: ticks.clamp(0, 10) as u32
}
    // Restart pacing from now (after loading, so no backlog replays).
reset :: proc(self: ^Self) {
}
    // rust: self.timer = Timer::new(20.0, self.now_ms());
    // rust: self.timer.update_pause_state(self.pause);
}
    // The partial tick for interpolation (`getGameTimeDeltaPartialTick(false)`).
fraction :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(self.timer.game_time_delta_partial_tick(false))
}
    // The camera entity's partial tick (`Camera.getCameraEntityPartialTicks`
    // for a player, who is never frozen): `getGameTimeDeltaPartialTick(true)`,
    // so the view and the hand stay smooth in a frozen level. Under `still`, held at 1 there
    // like the level's, so a frame doesn't depend on when it's drawn.
camera_fraction :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.still && !self.runs_normally() {
    // rust: return 1.0;
}
    // rust: f64::from(self.timer.game_time_delta_partial_tick(true))
}
    // After a frame: whether the game is paused by a screen (the residual
    // stops accumulating) and whether the level is frozen.
end_frame :: proc(self: ^Self, pause: bool) {
}
    // rust: self.pause = pause;
    // rust: self.timer.update_pause_state(pause);
    // rust: self.timer
    // rust: .update_frozen_state(!self.manager.base.runs_normally());
}
paused :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.pause
}
    // `TickRateManager.tick` for one tick, then whether the world runs
    // (`runsNormally`). Also the sprint check that opens a sprint tick.
world_runs :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.manager.base.tick();
    // rust: self.sprint_checked = false;
    // rust: if self.manager.is_sprinting() {
    // rust: let (_, report) = self.manager.check_should_sprint_this_tick(self.now_ns());
    // rust: self.sprint_checked = report.is_none();
    // rust: if report.is_some() {
    // rust: self.sprint_report = report;
}
}
    // rust: self.manager.base.runs_normally()
}
    // The report of a sprint that just finished, once.
take_sprint_report :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.sprint_report.take()
}
rate :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.manager.base.tickrate()
}
set_rate :: proc(self: ^Self, rate: f32) {
}
    // rust: self.manager.set_tick_rate(rate);
}
frozen :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.manager.base.is_frozen()
}
    // `runsNormally` as of the last `world_runs`.
runs_normally :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.manager.base.runs_normally()
}
set_frozen :: proc(self: ^Self, frozen: bool) {
}
    // rust: self.manager.base.set_frozen(frozen);
}
    // `TickRateManager.setFrozenTicksToRun` (ClientboundTickingStepPacket).
set_frozen_ticks_to_run :: proc(self: ^Self, ticks: i32) {
}
    // rust: self.manager.base.set_frozen_ticks_to_run(ticks);
}
sprinting :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.manager.is_sprinting()
}
    // `requestGameToSprint`: true when a sprint was already running.
start_sprint :: proc(self: ^Self, ticks: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.manager
    // rust: .request_game_to_sprint(ticks.min(i32::MAX as u32) as i32)
}
    // `stopSprinting`: the report when a sprint was running.
stop_sprint :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.manager.stop_sprinting()
}
stepping :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.manager.base.is_stepping_forward()
}
    // `stepGameIfPaused`: only works while frozen.
start_step :: proc(self: ^Self, ticks: u32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let started = self
    // rust: .manager
    // rust: .step_game_if_paused(ticks.min(i32::MAX as u32) as i32);
    // rust: if started {
    // rust: self.step_changes += 1;
    // rust: self.step_requested = self.manager.base.frozen_ticks_to_run();
}
    // rust: started
}
stop_step :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let stopped = self.manager.stop_stepping();
    // rust: if stopped {
    // rust: self.step_changes += 1;
    // rust: self.step_requested = 0;
}
    // rust: stopped
}
    // Preserve the command's count until the network pass, even if a world
    // tick has already consumed it.
    // New arrivals instead receive the current remaining ticks.
step_state :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: StepState {
    // rust: revision: self.step_changes,
    // rust: requested: self.step_requested,
    // rust: remaining: self.manager.base.frozen_ticks_to_run(),
}
}
    // Record how long a tick took (`MinecraftServer.tickServer` bookkeeping
    // and `endTickWork`).
record :: proc(self: ^Self, took: std::time::Duration) {
}
    // rust: let took = took.as_nanos() as i64;
    // rust: let index = (self.tick_count % SAMPLES as i64) as usize;
    // rust: self.aggregated -= self.tick_times[index];
    // rust: self.aggregated += took;
    // rust: self.tick_times[index] = took;
    // rust: self.tick_count += 1;
    // rust: if self.sprint_checked {
    // rust: let end = self.now_ns() + took;
    // rust: self.manager.end_tick_work(end);
}
}
    // `getAverageTickTimeNanos`.
average_nanos :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (self.aggregated / SAMPLES.min(self.tick_count.max(1) as usize) as i64).max(0) as u64
}
    // The sorted `getTickTimesNanos` array (always 100 entries).
sorted_samples :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut v: Vec<u64> = self.tick_times.iter().map(|&t| t.max(0) as u64).collect();
    // rust: v.sort_unstable();
    // rust: v
}
}

    // rust: mod tests {
//     use super::*;

timer_carries_fractions_and_caps_nothing_itself :: proc() {
}
    // rust: let mut t = Timer::new(20.0, 0);
    // rust: assert_eq!(t.advance_game_time(49, |d| d), 0);
    // rust: assert_eq!(t.advance_game_time(50, |d| d), 1);
    // rust: assert_eq!(t.advance_game_time(1050, |d| d), 20);
}
pause_restores_the_residual :: proc() {
}
    // rust: let mut t = Timer::new(20.0, 0);
    // rust: t.advance_game_time(25, |d| d);
    // rust: t.update_pause_state(true);
    // rust: t.advance_game_time(1000, |d| d);
    // rust: assert_eq!(t.game_time_delta_partial_tick(false), 0.5);
    // rust: t.update_pause_state(false);
    // rust: assert_eq!(t.game_time_delta_partial_tick(false), 0.5);
}
frozen_step_runs_exactly_the_requested_ticks :: proc() {
}
    // rust: let mut m = ServerTickRateManager::default();
    // rust: m.base.set_frozen(true);
    // rust: m.base.tick();
    // rust: assert!(!m.base.runs_normally());
    // rust: assert!(m.step_game_if_paused(2));
    // rust: for _ in 0..2 {
    // rust: m.base.tick();
    // rust: assert!(m.base.runs_normally());
}
    // rust: m.base.tick();
    // rust: assert!(!m.base.runs_normally());
}
the_camera_keeps_interpolating_in_a_frozen_level :: proc() {
}
    // rust: let mut clock = FixedStep::default();
    // rust: clock.set_frozen(true);
    // rust: clock.world_runs();
    // rust: clock.advance(std::time::Duration::from_millis(25));
    // rust: clock.end_frame(false);
    // rust: assert_eq!(clock.fraction(), 1.0, "frozen entities stay put");
    // rust: assert_eq!(clock.camera_fraction(), 0.5, "the player does not");
}
a_still_clock_starts_frozen_and_holds_the_camera_too :: proc() {
}
    // rust: let mut clock = FixedStep::new(true);
    // rust: clock.world_runs();
    // rust: assert!(!clock.runs_normally(), "frozen before the first tick");
    // rust: clock.advance(std::time::Duration::from_millis(25));
    // rust: clock.end_frame(false);
    // rust: assert_eq!(clock.fraction(), 1.0);
    // rust: assert_eq!(clock.camera_fraction(), 1.0);
        // `/tick unfreeze`: the world runs as without the switch.
    // rust: clock.set_frozen(false);
    // rust: assert!(clock.world_runs());
    // rust: assert!(
    // rust: FixedStep::new(false).world_runs(),
    // rust: "without the switch, unfrozen"
    // rust: );
}
only_a_started_or_stopped_step_is_broadcast :: proc() {
}
    // rust: let mut clock = FixedStep::default();
    // rust: assert!(!clock.start_step(5), "not frozen");
    // rust: assert_eq!(clock.step_state(), StepState::default());
    // rust: clock.set_frozen(true);
    // rust: assert!(clock.start_step(5));
    // rust: assert_eq!(
    // rust: clock.step_state(),
    // rust: StepState {
    // rust: revision: 1,
    // rust: requested: 5,
    // rust: remaining: 5
}
    // rust: );
    // rust: clock.world_runs();
    // rust: assert_eq!(
    // rust: clock.step_state(),
    // rust: StepState {
    // rust: revision: 1,
    // rust: requested: 5,
    // rust: remaining: 4
    // rust: },
    // rust: "consuming a tick preserves the command broadcast"
    // rust: );
    // rust: assert!(clock.stop_step());
    // rust: assert!(!clock.stop_step());
    // rust: assert_eq!(
    // rust: clock.step_state(),
    // rust: StepState {
    // rust: revision: 2,
    // rust: requested: 0,
    // rust: remaining: 0
}
    // rust: );
}
a_consumed_single_step_still_advances_the_client_once :: proc() {
}
    // rust: let mut server = FixedStep::default();
    // rust: server.set_frozen(true);
    // rust: assert!(server.start_step(1));
    // rust: assert!(server.world_runs());
    // rust: assert!(!server.world_runs());
    // rust: let state = server.step_state();
    // rust: assert_eq!(state.remaining, 0, "a late join has no pending ticks");
    // rust: let mut client = FixedStep::client();
    // rust: client.set_frozen(true);
    // rust: client.set_frozen_ticks_to_run(state.requested);
    // rust: assert!(
    // rust: client.world_runs(),
    // rust: "the connected client runs the command's tick"
    // rust: );
    // rust: assert!(!client.world_runs(), "then remains frozen");
}
a_servers_tick_rate_only_slows_its_client_down :: proc() {
}
    // rust: let quarter = std::time::Duration::from_millis(250);
    // rust: let mut client = FixedStep::client();
    // rust: client.set_rate(40.0);
    // rust: assert_eq!(client.advance(quarter), 5, "still 20 a second");
    // rust: let mut slow = FixedStep::client();
    // rust: slow.set_rate(10.0);
    // rust: assert_eq!(slow.advance(quarter * 2), 5, "10 a second");
    // rust: let mut local = FixedStep::default();
    // rust: local.set_rate(40.0);
    // rust: assert_eq!(
    // rust: local.advance(quarter),
    // rust: 10,
    // rust: "the integrated loop runs at the rate"
    // rust: );
}
}
