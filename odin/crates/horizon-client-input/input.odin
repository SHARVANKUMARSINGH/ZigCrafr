//! Transpiled from Horizon Rust crate
package horizon_client_input_input

import "core:fmt"
import "core:mem"
import "core:math"

// KeyboardInput direction and LocalPlayer input-speed arithmetic for 26.3.
// Item-use and sneak multipliers come from the player's current state; this
// module does not implement sprint eligibility, poses or the input lifecycle.

// use std::collections::HashSet;
// use winit::keyboard::{KeyCode, ModifiersState};

length :: proc(v: [f32; 2]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(v[0] * v[0] + v[1] * v[1]).sqrt() as f32
}
scale :: proc(v: [f32; 2], factor: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [v[0] * factor, v[1] * factor]
}
keyboard_direction :: proc(forward: bool, backward: bool, left: bool, right: bool) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let impulse = |positive: bool, negative: bool| {
    // rust: if positive == negative {
    // rust: 0.0
    // rust: } else if positive {
    // rust: 1.0
    // rust: } else {
    // rust: -1.0
}
}
    // rust: let v = [impulse(left, right), impulse(forward, backward)];
    // rust: let magnitude = length(v);
    // rust: if magnitude < 1.0e-4 {
    // rust: [0.0, 0.0]
    // rust: } else {
    // rust: [v[0] / magnitude, v[1] / magnitude]
}
}

// LocalPlayer.modifyInput with already selected multipliers. `item_use` is
// Some only when using an item and not riding; `sneaking` only when moving
// slowly. Zero input returns before either multiplier is applied.
modify_input :: proc(input: [f32; 2], item_use: Maybe(f32), sneaking: Maybe(f32)) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if input[0] * input[0] + input[1] * input[1] == 0.0 {
    // rust: return input;
}
    // rust: let mut v = scale(input, 0.98);
    // rust: if let Some(multiplier) = item_use {
    // rust: v = scale(v, multiplier);
}
    // rust: if let Some(multiplier) = sneaking {
    // rust: v = scale(v, multiplier);
}
    // rust: square_movement(v)
}

square_movement :: proc(v: [f32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let magnitude = length(v);
    // rust: if magnitude <= 0.0 {
    // rust: return v;
}
    // rust: let unit = scale(v, 1.0 / magnitude);
    // rust: let x = unit[0].abs();
    // rust: let y = unit[1].abs();
    // rust: let ratio = if y > x { x / y } else { y / x };
    // rust: let distance = f64::from(1.0 + ratio * ratio).sqrt() as f32;
    // rust: let speed = magnitude * distance;
    // Java Math.min propagates NaN, unlike Rust's f32::min.
    // rust: scale(
    // rust: unit,
    // rust: if speed.is_nan() || speed < 1.0 {
    // rust: speed
    // rust: } else {
    // rust: 1.0
    // rust: },
    // rust: )
}

// `InputQuirks.isQuitShortcutDown`: checks whether the platform's window-closing
// keyboard shortcut is held.
// - On macOS: Command (`super_key()`) + `Q`.
// - On Windows / Linux / other: Alt (`alt_key()`) + `F4`.
is_quit_shortcut_down :: proc(modifiers: ModifiersState, keys: ^map[KeyCode]struct{}) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if cfg!(target_os = "macos") {
    // rust: modifiers.super_key() && keys.contains(&KeyCode::KeyQ)
    // rust: } else {
    // rust: modifiers.alt_key() && keys.contains(&KeyCode::F4)
}
}

    // rust: mod tests {
//     use super::*;

quit_shortcut_follows_platform_modifiers_and_keys :: proc() {
}
    // rust: let mut keys = HashSet::new();
    // rust: let alt = ModifiersState::ALT;
    // rust: let super_key = ModifiersState::SUPER;

    // rust: assert!(!is_quit_shortcut_down(ModifiersState::empty(), &keys));

    // rust: keys.insert(KeyCode::F4);
    // rust: if cfg!(target_os = "macos") {
    // rust: assert!(!is_quit_shortcut_down(alt, &keys));
    // rust: keys.remove(&KeyCode::F4);
    // rust: keys.insert(KeyCode::KeyQ);
    // rust: assert!(is_quit_shortcut_down(super_key, &keys));
    // rust: assert!(!is_quit_shortcut_down(alt, &keys));
    // rust: } else {
    // rust: assert!(is_quit_shortcut_down(alt, &keys));
    // rust: assert!(!is_quit_shortcut_down(super_key, &keys));
    // rust: keys.remove(&KeyCode::F4);
    // rust: keys.insert(KeyCode::KeyQ);
    // rust: assert!(!is_quit_shortcut_down(alt, &keys));
    // rust: assert!(!is_quit_shortcut_down(super_key, &keys));
}
}
}
