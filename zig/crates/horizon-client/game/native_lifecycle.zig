//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_lifecycle
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Read-only lifecycle observations for native mods on authoritative servers.
//! A paused pass
//! observes nothing; a frozen world reports `world_running: false` except during a step.

// use std::sync::atomic::{AtomicU64, Ordering};

// use super::{Game, execution_role::ExecutionRole};
// Their old home, for mixin code that names them here.
    // rust: pub(super) use horizon_client::mod_api::{
    // rust: NativeAuthority, NativeLifecycleContext, NativeTickId, NativeWorldEpoch, ServerTickPhase,
    // rust: WorldPhase,
}

/// Epoch allocation spans `Game` instances (a new server `Game` per
/// launch), so the counter is process-wide.
pub const NEXT_EPOCH: AtomicU64 = AtomicU64::new(1);

/// A process-wide epoch no handle has carried yet: a server open's, or a
/// client level's (`native_entity_refs.rs`), so a handle never crosses sides.
    // rust: pub(super) fn fresh_epoch() -> NativeWorldEpoch {
    // rust: NativeWorldEpoch::new(NEXT_EPOCH.fetch_add(1, Ordering::Relaxed))
}

/// Internal state for deciding which events can fire.
pub const OpenState = enum {
    Opening,
    Ready,
    Closing,
};

pub const OpenAttempt = struct {
    authority: NativeAuthority,
    epoch: u64,
    session: OpenState,
    ticks: u64,
    /// A tick started and its end has not fired (or the tick errored).
    tick_open: bool,
    tick_world_running: bool,
};

    // rust: impl OpenAttempt {
pub fn context(self: *Self) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: NativeLifecycleContext {
    // rust: authority: self.authority,
    // rust: epoch: NativeWorldEpoch::new(self.epoch),
    // rust: tick: NativeTickId::new(self.ticks),
}
}
}

/// The lifecycle bookkeeping: the current attempt's epoch, session phase
/// and non-paused tick count. It only decides whether a phase fires; every
/// hook body is empty, so with no native mods nothing changes.
    // rust: pub(super) struct NativeLifecycle {
    // rust: attempt: Option<OpenAttempt>,
    // rust: read_scope: bool,
}

    // rust: impl NativeLifecycle {
    /// A read is valid only during a tick hook with its current tick context.
    // rust: pub(super) fn permits_read(&self, context: &NativeLifecycleContext) -> bool {
    // rust: self.read_scope
    // rust: && self
    // rust: .attempt
    // rust: .as_ref()
    // rust: .is_some_and(|a| a.session == OpenState::Ready && a.context() == *context)
}

    /// The epoch of the world open now, from the start of its open to the end
    /// of its close: what a mod's entity and level handles carry.
    // rust: pub(super) fn epoch(&self) -> Option<NativeWorldEpoch> {
    // rust: self.attempt.map(|a| NativeWorldEpoch::new(a.epoch))
}

    /// The open starts: a fresh process-wide epoch, never reused.
    // rust: pub(super) fn begin_open(&mut self, authority: NativeAuthority) {
    // rust: let epoch = fresh_epoch().get();
    // rust: self.attempt = Some(OpenAttempt {
    // rust: authority,
    // rust: epoch,
    // rust: session: OpenState::Opening,
    // rust: ticks: 0,
    // rust: tick_open: false,
    // rust: tick_world_running: false,
    // rust: });
}

    // rust: pub(super) fn world_open_ready(&mut self) -> Option<NativeLifecycleContext> {
    // rust: let attempt = self.attempt.as_mut()?;
    // rust: if attempt.session != OpenState::Opening {
    // rust: return None;
}
    // rust: attempt.session = OpenState::Ready;
    // rust: Some(attempt.context())
}

    /// `WorldOpenFailed`: only while opening; the attempt is invalidated.
    // rust: pub(super) fn world_open_failed(&mut self) -> Option<NativeLifecycleContext> {
    // rust: let attempt = self.attempt.as_mut()?;
    // rust: if attempt.session != OpenState::Opening {
    // rust: return None;
}
    // rust: let context = attempt.context();
    // rust: self.attempt = None;
    // rust: Some(context)
}

    // rust: pub(super) fn begin_close(&mut self) {
    // rust: if let Some(attempt) = self.attempt.as_mut() {
    // rust: attempt.session = OpenState::Closing;
}
}

    /// A failure after readiness retires the epoch, including during shutdown.
    // rust: pub(super) fn world_close_failed(&mut self) -> Option<NativeLifecycleContext> {
    // rust: let attempt = self.attempt.as_ref()?;
    // rust: if attempt.session == OpenState::Opening {
    // rust: return None;
}
    // rust: let context = attempt.context();
    // rust: self.attempt = None;
    // rust: Some(context)
}

    /// `WorldCloseFinal`: at most once per epoch; the epoch retires.
    // rust: pub(super) fn world_close_final(&mut self) -> Option<NativeLifecycleContext> {
    // rust: let attempt = self.attempt.as_mut()?;
    // rust: if attempt.session != OpenState::Closing {
    // rust: return None;
}
    // rust: let context = attempt.context();
    // rust: self.attempt = None;
    // rust: Some(context)
}

    /// Non-paused ready ticks only; a paused pass observes nothing, does not count.
    // rust: pub(super) fn server_tick_start(
    // rust: &mut self,
    // rust: world_running: bool,
    // rust: ) -> Option<(NativeLifecycleContext, ServerTickPhase)> {
    // rust: let attempt = self.attempt.as_mut()?;
    // rust: if attempt.session != OpenState::Ready {
    // rust: return None;
}
    // rust: attempt.ticks += 1;
    // rust: attempt.tick_open = true;
    // rust: attempt.tick_world_running = world_running;
    // rust: Some((
    // rust: attempt.context(),
    // rust: ServerTickPhase::ServerTickStart { world_running },
    // rust: ))
}

    /// Discard the pending end when a tick fails.
    // rust: pub(super) fn cancel_server_tick(&mut self) {
    // rust: if let Some(attempt) = &mut self.attempt {
    // rust: attempt.tick_open = false;
}
}

    /// Pairs the last start; an errored tick never reaches it.
    // rust: pub(super) fn server_tick_end(
    // rust: &mut self,
    // rust: paused: bool,
    // rust: ) -> Option<(NativeLifecycleContext, ServerTickPhase)> {
    // rust: let attempt = self.attempt.as_mut()?;
    // rust: if paused || attempt.session != OpenState::Ready || !attempt.tick_open {
    // rust: return None;
}
    // rust: attempt.tick_open = false;
    // rust: Some((
    // rust: attempt.context(),
    // rust: ServerTickPhase::ServerTickEnd {
    // rust: world_running: attempt.tick_world_running,
    // rust: },
    // rust: ))
}
}

    // rust: impl Game<'_> {
    /// The role is fixed at construction; a mirror `Game` is remote whatever it is.
pub fn native_lifecycle_authority(self: *Self) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.remote.is_some() {
    // rust: return NativeAuthority::RemoteClient;
}
    // rust: match self.options.execution_role {
    // rust: ExecutionRole::Client => NativeAuthority::LocalAuthoritative,
    // rust: ExecutionRole::IntegratedServer => NativeAuthority::IntegratedServer,
    // rust: ExecutionRole::DedicatedServer => NativeAuthority::DedicatedServer,
}
}

    // rust: pub(super) fn native_lifecycle_open_started(&mut self) {
    // rust: self.native_lifecycle
    // rust: .begin_open(self.native_lifecycle_authority());
}

    // rust: pub(super) fn native_lifecycle_world_ready(&mut self) {
    // rust: if let Some(context) = self.native_lifecycle.world_open_ready() {
    // rust: self.native_world_lifecycle(&context, WorldPhase::WorldOpenReady, "");
}
}

    /// `error_text` is the engine's own error text, unchanged.
    // rust: pub(super) fn native_lifecycle_world_failed(&mut self, error_text: &str) {
        // The levels that opened before the failure close first.
    // rust: self.native_levels_closing();
    // rust: if let Some(context) = self.native_lifecycle.world_open_failed() {
    // rust: self.native_world_lifecycle(&context, WorldPhase::WorldOpenFailed, error_text);
}
}

    /// Report a server-loop or shutdown failure once and retire its epoch.
    // rust: pub(super) fn native_lifecycle_close_failed(&mut self, error_text: &str) {
    // rust: self.native_levels_closing();
    // rust: if let Some(context) = self.native_lifecycle.world_close_failed() {
    // rust: self.native_world_lifecycle(&context, WorldPhase::WorldCloseFailed, error_text);
}
}

    /// After the final save, before the lock release. Mirrors never fire.
    // rust: pub(super) fn native_lifecycle_world_closed(&mut self) {
    // rust: if self.remote.is_some() {
    // rust: return;
}
        // Each level closes after the final save (`LevelEvent.Unload`).
    // rust: self.native_levels_closing();
    // rust: if let Some(context) = self.native_lifecycle.world_close_final() {
    // rust: self.native_world_lifecycle(&context, WorldPhase::WorldCloseFinal, "");
}
}

    // rust: pub(super) fn native_lifecycle_server_tick_start(&mut self, world_running: bool) {
    // rust: if let Some((context, phase)) = self.native_lifecycle.server_tick_start(world_running) {
    // rust: self.native_lifecycle.read_scope = true;
    // rust: self.native_server_tick(&context, phase);
    // rust: self.native_lifecycle.read_scope = false;
}
}

    /// An errored tick returned at `result?` before this site.
    // rust: pub(super) fn native_lifecycle_server_tick_end(&mut self, paused: bool) {
    // rust: if let Some((context, phase)) = self.native_lifecycle.server_tick_end(paused) {
    // rust: self.native_lifecycle.read_scope = true;
    // rust: self.native_server_tick(&context, phase);
    // rust: self.native_lifecycle.read_scope = false;
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn frozen_steps_are_observed_without_consuming_them() void {
}
    // rust: let mut lifecycle = opening();
    // rust: lifecycle.world_open_ready();
    // rust: let mut clock = horizon_client::clock::FixedStep::default();
    // rust: clock.set_frozen(true);
    // rust: clock.set_frozen_ticks_to_run(4);
    // rust: let mut observed = 0;
    // rust: for _ in 0..6 {
    // rust: let running = clock.world_runs();
    // rust: let (_, start) = lifecycle.server_tick_start(running).unwrap();
    // rust: let (_, end) = lifecycle.server_tick_end(false).unwrap();
    // rust: assert_eq!(
    // rust: start,
    // rust: ServerTickPhase::ServerTickStart {
    // rust: world_running: running
}
    // rust: );
    // rust: assert_eq!(
    // rust: end,
    // rust: ServerTickPhase::ServerTickEnd {
    // rust: world_running: running
}
    // rust: );
    // rust: observed += usize::from(running);
}
    // rust: assert_eq!(observed, 4);
}

    /// A lifecycle mid-open on the server thread.
pub fn opening() N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut lifecycle = NativeLifecycle::default();
    // rust: lifecycle.begin_open(NativeAuthority::IntegratedServer);
    // rust: lifecycle
}

pub fn block_reads_require_the_current_hook_scope() void {
}
    // rust: let mut life = NativeLifecycle::default();
    // rust: life.begin_open(NativeAuthority::IntegratedServer);
    // rust: let ready = life.world_open_ready().unwrap();
    // rust: assert!(!life.permits_read(&ready));
    // rust: let (tick, _) = life.server_tick_start(true).unwrap();
    // rust: life.read_scope = true;
    // rust: assert!(life.permits_read(&tick));
    // rust: assert!(!life.permits_read(&ready));
    // rust: life.read_scope = false;
    // rust: assert!(!life.permits_read(&tick));
    // rust: life.server_tick_end(false).unwrap();
    // rust: life.begin_close();
    // rust: life.world_close_final().unwrap();
    // rust: life.begin_open(NativeAuthority::IntegratedServer);
    // rust: life.world_open_ready().unwrap();
    // rust: life.read_scope = true;
    // rust: assert!(!life.permits_read(&tick));
}

pub fn world_ready_fires_once_per_epoch() void {
}
    // rust: let mut lifecycle = opening();
    // rust: let context = lifecycle.world_open_ready().expect("the first ready fires");
    // rust: assert_eq!(context.authority, NativeAuthority::IntegratedServer);
    // rust: assert!(context.epoch.get() >= 1, "the epoch is globally allocated");
    // rust: assert!(lifecycle.world_open_ready().is_none(), "at most once");
}

pub fn a_failed_open_invalidates_and_a_retry_is_fresh() void {
}
    // rust: let mut lifecycle = opening();
    // rust: let context = lifecycle.world_open_failed().expect("the failure fires");
    // rust: let failed_epoch = context.epoch;
    // rust: assert!(lifecycle.world_open_ready().is_none(), "the epoch is gone");
    // rust: assert!(lifecycle.server_tick_start(true).is_none());
    // rust: lifecycle.begin_open(NativeAuthority::IntegratedServer);
    // rust: let context = lifecycle.world_open_ready().expect("the retry opens fresh");
    // rust: assert!(context.epoch.get() > failed_epoch.get(), "a fresh epoch");
}

pub fn close_final_fires_once_and_retires_the_epoch() void {
}
    // rust: let mut lifecycle = opening();
    // rust: lifecycle.world_open_ready();
    // rust: lifecycle.begin_close();
    // rust: let context = lifecycle.world_close_final().expect("the close fires");
    // rust: assert!(context.epoch.get() >= 1);
    // rust: assert!(
    // rust: lifecycle.world_close_final().is_none(),
    // rust: "a repeated close request is a no-op"
    // rust: );
    // rust: assert!(lifecycle.server_tick_start(true).is_none());
    // rust: assert!(lifecycle.world_open_ready().is_none());
}

pub fn a_close_during_opening_still_closes_once() void {
}
    // rust: let mut lifecycle = opening();
    // rust: lifecycle.begin_close();
    // rust: assert!(lifecycle.world_close_final().is_some());
}

pub fn close_failure_retires_only_ready_epochs() void {
}
    // rust: let mut lifecycle = opening();
    // rust: assert!(lifecycle.world_close_failed().is_none());
    // rust: lifecycle.world_open_ready();
    // rust: lifecycle.begin_close();
    // rust: assert!(lifecycle.world_close_failed().is_some());
    // rust: assert!(lifecycle.world_close_failed().is_none());
    // rust: assert!(lifecycle.world_close_final().is_none());
}
}
