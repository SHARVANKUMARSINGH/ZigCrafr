//! Transpiled from Horizon Rust crate
//! Module: horizon-client_headless
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `--headless` (#4951): a client with no display, no window and no renderer.
//!
//! winit's event loop needs a display server even when no window is shown, so a headless game
//! runs this loop instead. Each step is what winit's `about_to_wait` does (`Game::idle`: stop
//! requests, the closing save, world entry, the control socket), and `idle` runs the frame
//! (the client tick, nothing drawn) through the same `RedrawRequested` path a window's game
//! takes. Input comes only from the control socket (`horizon-ctl`), as synthetic window events.

// use super::Game;
// use super::event_loop::EventLoopCtl;
// use std::{
    // rust: cell::Cell,
    // rust: time::{Duration, Instant},
}
// use winit::event_loop::ControlFlow;

/// Time between headless frames. The client ticks at 20 Hz whatever the frame rate (a frame
/// runs the ticks its elapsed time owes), so one frame per tick does all the work there is
/// without spending a core on frames nobody sees.
pub const FRAME: Duration = Duration::from_millis(50);

/// The loop's side of `EventLoopCtl`: what the game asked for during a step.
pub const HeadlessLoop = struct {
    exit: Cell<bool>,
    flow: Cell<ControlFlow>,
};

    // rust: impl EventLoopCtl for HeadlessLoop {
pub fn exit(self: *Self) void {
}
    // rust: self.exit.set(true);
}
pub fn set_control_flow(self: *Self, flow: ControlFlow) void {
}
    // rust: self.flow.set(flow);
}
}

    // rust: impl HeadlessLoop {
    /// When the step that started at `started` wants the next one: at the time the game asked
    /// for (`WaitUntil`, as the closing save's polls do), else one frame later.
pub fn next_step(self: *Self, started: Instant) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.flow.get() {
    // rust: ControlFlow::WaitUntil(at) => at,
    // rust: ControlFlow::Poll | ControlFlow::Wait => started + FRAME,
}
}
}

    // rust: impl Game<'_> {
    /// Runs the game until it asks to stop (`horizon-ctl quit`, a signal, an error), then
    /// saves as a window's game does when its loop ends.
    // rust: pub(super) fn run_headless(&mut self) {
    // rust: let ctl = HeadlessLoop {
    // rust: exit: Cell::new(false),
    // rust: flow: Cell::new(ControlFlow::Poll),
}
    // rust: self.previous = Instant::now();
    // rust: while !ctl.exit.get() {
    // rust: let started = Instant::now();
    // rust: ctl.flow.set(ControlFlow::Poll);
    // rust: self.idle(&ctl);
    // rust: if let Some(wait) = ctl
    // rust: .next_step(started)
    // rust: .checked_duration_since(Instant::now())
    // rust: {
    // rust: std::thread::sleep(wait);
}
}
    // rust: self.shut_down();
}
}

    // rust: mod tests {
//     use super::*;

pub fn ctl(flow: ControlFlow) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HeadlessLoop {
    // rust: exit: Cell::new(false),
    // rust: flow: Cell::new(flow),
}
}

pub fn steps_come_a_frame_apart_unless_the_game_asks_for_sooner() void {
}
    // rust: let started = Instant::now();
    // rust: assert_eq!(ctl(ControlFlow::Poll).next_step(started), started + FRAME);
    // rust: let soon = started + Duration::from_millis(4);
    // rust: assert_eq!(ctl(ControlFlow::WaitUntil(soon)).next_step(started), soon);
}

pub fn exit_is_remembered_for_the_loop() void {
}
    // rust: let c = ctl(ControlFlow::Poll);
    // rust: assert!(!c.exit.get());
    // rust: EventLoopCtl::exit(&c);
    // rust: assert!(c.exit.get());
}
}
