//! Transpiled from Horizon Rust crate
//! Module: horizon-client_event_loop
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What the game asks of the loop that runs it.
//!
//! A window's game runs inside winit's event loop, and its methods used to take winit's
//! `ActiveEventLoop` only to stop the loop or to say when to wake next. A headless client
//! (#4951) has no display, so it cannot have that loop: it runs its own, and hands the same
//! methods this trait instead. winit's loop implements it, so a window's game is unchanged.

// use std::time::{Duration, Instant};
// use winit::event_loop::{ActiveEventLoop, ControlFlow};

/// A successful frame only permits polling until the next idle iteration. If
/// the compositor stops delivering redraws, the old result must not keep the
/// loop spinning indefinitely. Offscreen frames are driven by the loop itself.
    // rust: pub(super) fn redraw_flow(frame_drawn: &mut bool, offscreen: bool, now: Instant) -> ControlFlow {
    // rust: let drew_frame = std::mem::take(frame_drawn);
    // rust: if offscreen || drew_frame {
    // rust: ControlFlow::Poll
    // rust: } else {
    // rust: ControlFlow::WaitUntil(now + Duration::from_millis(16))
}
}

    // rust: pub(super) trait EventLoopCtl {
    /// Ends the loop after the current iteration (`ActiveEventLoop::exit`).
pub fn exit(self: *Self) void;
    /// When the loop wakes next (`ActiveEventLoop::set_control_flow`).
pub fn set_control_flow(self: *Self, flow: ControlFlow) void;
}

    // rust: impl EventLoopCtl for ActiveEventLoop {
pub fn exit(self: *Self) void {
}
    // rust: ActiveEventLoop::exit(self);
}
pub fn set_control_flow(self: *Self, flow: ControlFlow) void {
}
    // rust: ActiveEventLoop::set_control_flow(self, flow);
}
}

    // rust: mod tests {
//     use super::*;

pub fn missing_redraw_waits_and_a_new_frame_resumes_polling() void {
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

pub fn offscreen_keeps_polling_without_a_presented_frame() void {
}
    // rust: let mut frame_drawn = false;
    // rust: assert_eq!(
    // rust: redraw_flow(&mut frame_drawn, true, Instant::now()),
    // rust: ControlFlow::Poll
    // rust: );
}
}
