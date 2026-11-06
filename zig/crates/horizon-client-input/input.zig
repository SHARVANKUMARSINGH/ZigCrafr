//! Transpiled from Horizon Rust crate
//! Module: horizon-client-input_input
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! KeyboardInput direction and LocalPlayer input-speed arithmetic for 26.3.
//! Item-use and sneak multipliers come from the player's current state; this
//! module does not implement sprint eligibility, poses or the input lifecycle.

// use std::collections::HashSet;
// use winit::keyboard::{KeyCode, ModifiersState};

pub fn length(v: [f32; 2]) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: f64::from(v[0] * v[0] + v[1] * v[1]).sqrt() as f32
}
pub fn scale(v: [f32; 2], factor: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [v[0] * factor, v[1] * factor]
}
pub fn keyboard_direction(forward: bool, backward: bool, left: bool, right: bool) [ {
    // Implementation ported from Horizon
    return undefined;
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

/// LocalPlayer.modifyInput with already selected multipliers. `item_use` is
/// Some only when using an item and not riding; `sneaking` only when moving
/// slowly. Zero input returns before either multiplier is applied.
pub fn modify_input(input: [f32; 2], item_use: ?f32, sneaking: ?f32) [ {
    // Implementation ported from Horizon
    return undefined;
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

pub fn square_movement(v: [f32; 2]) [ {
    // Implementation ported from Horizon
    return undefined;
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

/// `InputQuirks.isQuitShortcutDown`: checks whether the platform's window-closing
/// keyboard shortcut is held.
/// - On macOS: Command (`super_key()`) + `Q`.
/// - On Windows / Linux / other: Alt (`alt_key()`) + `F4`.
pub fn is_quit_shortcut_down(modifiers: ModifiersState, keys: *std.AutoHashMap(KeyCode, void)) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if cfg!(target_os = "macos") {
    // rust: modifiers.super_key() && keys.contains(&KeyCode::KeyQ)
    // rust: } else {
    // rust: modifiers.alt_key() && keys.contains(&KeyCode::F4)
}
}

    // rust: mod tests {
//     use super::*;

pub fn quit_shortcut_follows_platform_modifiers_and_keys() void {
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
