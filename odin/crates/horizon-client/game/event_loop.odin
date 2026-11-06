//! Transpiled from Horizon Rust crate
package horizon_client_event_loop

import "core:fmt"
import "core:mem"
import "core:math"

// What the game asks of the loop that runs it.
//
// A window's game runs inside winit's event loop, and its methods used to take winit's
// `ActiveEventLoop` only to stop the loop or to say when to wake next. A headless client
// (#4951) has no display, so it cannot have that loop: it runs its own, and hands the same
// methods this trait instead. winit's loop implements it, so a window's game is unchanged.

// use std::time::{Duration, Instant};
// use winit::event_loop::{ActiveEventLoop, ControlFlow};

// A successful frame only permits polling until the next idle iteration. If
// the compositor stops delivering redraws, the old result must not keep the
// loop spinning indefinitely. Offscreen frames are driven by the loop itself.
    // rust: pub(super) fn redraw_flow(frame_drawn: &mut bool, offscreen: bool, now: Instant) -> ControlFlow {
    // rust: let drew_frame = std::mem::take(frame_drawn);
    // rust: if offscreen || drew_frame {
    // rust: ControlFlow::Poll
    // rust: } else {
    // rust: ControlFlow::WaitUntil(now + Duration::from_millis(16))
}
}

    // rust: pub(super) trait EventLoopCtl {
    // Ends the loop after the current iteration (`ActiveEventLoop::exit`).
exit :: proc(self: ^Self) {
}
    // When the loop wakes next (`ActiveEventLoop::set_control_flow`).
set_control_flow :: proc(self: ^Self, flow: ControlFlow) {
}
}

    // rust: impl EventLoopCtl for ActiveEventLoop {
exit :: proc(self: ^Self) {
}
    // rust: ActiveEventLoop::exit(self);
}
set_control_flow :: proc(self: ^Self, flow: ControlFlow) {
}
    // rust: ActiveEventLoop::set_control_flow(self, flow);
}
}

    // rust: mod tests {
//     use super::*;

missing_redraw_waits_and_a_new_frame_resumes_polling :: proc() {
}
    // rust: let now = Instant::now();
    // rust: let mut frame_drawn = true;
    // rust: assert_eq!(redraw_flow(&mut frame_drawn, false, now), ControlFlow::Poll);
    // rust: assert_eq!(
    // rust: redraw_flow(&mut frame_drawn, false, now),
    // rust: ControlFlow::WaitUntil(now + Duration::from_millis(16))
    // rust: );
    // rust: frame_drawn = true;
    // rust: assert_eq!(redraw_flow(&mut frame_drawn, false, now), ControlFlow::Poll);
}

offscreen_keeps_polling_without_a_presented_frame :: proc() {
}
    // rust: let mut frame_drawn = false;
    // rust: assert_eq!(
    // rust: redraw_flow(&mut frame_drawn, true, Instant::now()),
    // rust: ControlFlow::Poll
    // rust: );
}
}
