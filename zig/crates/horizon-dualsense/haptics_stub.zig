//! Transpiled from Horizon Rust crate
//! Module: horizon-dualsense_haptics_stub
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! No HD haptics on iOS: they play through the pad's own four-channel audio device over USB,
//! which needs cpal, and cpal is left out there with hidapi (see Cargo.toml).

/// The pad's audio output, playing the queued samples (left, right actuator).
pub const Haptics = struct {};

    // rust: impl Haptics {
    /// The DualSense's audio device, if one is there with its four channels (USB). A phone
    /// has none.
pub fn open() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}

    /// Play a vibration (heavy and light levels, 0..1, each for a while), replacing the one
    /// playing. Nothing plays on iOS.
pub fn play(self: *Self, _steps: *[(f32, std: :time::Duration) void {
}

    /// Stop at once. Nothing plays on iOS.
pub fn stop(self: *Self) void {
}
}
