//! Transpiled from Horizon Rust crate
package horizon_dualsense_haptics_stub

import "core:fmt"
import "core:mem"
import "core:math"

// No HD haptics on iOS: they play through the pad's own four-channel audio device over USB,
// which needs cpal, and cpal is left out there with hidapi (see Cargo.toml).

// The pad's audio output, playing the queued samples (left, right actuator).
Haptics :: struct {

    // rust: impl Haptics {
    // The DualSense's audio device, if one is there with its four channels (USB). A phone
    // has none.
open :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}

    // Play a vibration (heavy and light levels, 0..1, each for a while), replacing the one
    // playing. Nothing plays on iOS.
play :: proc(self: ^Self, _steps: ^[(f32, std: :time::Duration) {
}

    // Stop at once. Nothing plays on iOS.
stop :: proc(self: ^Self) {
}
}
