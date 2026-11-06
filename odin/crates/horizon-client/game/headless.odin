//! Transpiled from Horizon Rust crate
package horizon_client_headless

import "core:fmt"
import "core:mem"
import "core:math"

// `--headless` (#4951): a client with no display, no window and no renderer.
//
// winit's event loop needs a display server even when no window is shown, so a headless game
// runs this loop instead. Each step is what winit's `about_to_wait` does (`Game::idle`: stop
// requests, the closing save, world entry, the control socket), and `idle` runs the frame
// (the client tick, nothing drawn) through the same `RedrawRequested` path a window's game
// takes. Input comes only from the control socket (`horizon-ctl`), as synthetic window events.

// use super::Game;
// use super::event_loop::EventLoopCtl;
// use std::{
    // rust: cell::Cell,
    // rust: time::{Duration, Instant},
}
// use winit::event_loop::ControlFlow;

// Time between headless frames. The client ticks at 20 Hz whatever the frame rate (a frame
// runs the ticks its elapsed time owes), so one frame per tick does all the work there is
// without spending a core on frames nobody sees.
FRAME :: Duration::from_millis(50)

// The loop's side of `EventLoopCtl`: what the game asked for during a step.
HeadlessLoop :: struct {
    exit: Cell<bool>,
    flow: Cell<ControlFlow>,
}

    // rust: impl EventLoopCtl for HeadlessLoop {
exit :: proc(self: ^Self) {
}
    // rust: self.exit.set(true);
}
set_control_flow :: proc(self: ^Self, flow: ControlFlow) {
}
    // rust: self.flow.set(flow);
}
}

    // rust: impl HeadlessLoop {
    // When the step that started at `started` wants the next one: at the time the game asked
    // for (`WaitUntil`, as the closing save's polls do), else one frame later.
next_step :: proc(self: ^Self, started: Instant) -> I {
    // Ported from Horizon
    return {}
}
    // rust: match self.flow.get() {
    // rust: ControlFlow::WaitUntil(at) => at,
    // rust: ControlFlow::Poll | ControlFlow::Wait => started + FRAME,
}
}
}

    // rust: impl Game<'_> {
    // Runs the game until it asks to stop (`horizon-ctl quit`, a signal, an error), then
    // saves as a window's game does when its loop ends.
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

ctl :: proc(flow: ControlFlow) -> H {
    // Ported from Horizon
    return {}
}
    // rust: HeadlessLoop {
    // rust: exit: Cell::new(false),
    // rust: flow: Cell::new(flow),
}
}

steps_come_a_frame_apart_unless_the_game_asks_for_sooner :: proc() {
}
    // rust: let started = Instant::now();
    // rust: assert_eq!(ctl(ControlFlow::Poll).next_step(started), started + FRAME);
    // rust: let soon = started + Duration::from_millis(4);
    // rust: assert_eq!(ctl(ControlFlow::WaitUntil(soon)).next_step(started), soon);
}

exit_is_remembered_for_the_loop :: proc() {
}
    // rust: let c = ctl(ControlFlow::Poll);
    // rust: assert!(!c.exit.get());
    // rust: EventLoopCtl::exit(&c);
    // rust: assert!(c.exit.get());
}
}
