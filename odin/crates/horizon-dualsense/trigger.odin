//! Transpiled from Horizon Rust crate
package horizon_dualsense_trigger

import "core:fmt"
import "core:mem"
import "core:math"

// The adaptive triggers' effects in the pad's own encoding. A trigger's travel is cut into ten
// zones (0 at rest, 9 fully pulled); an effect names the zones it acts in and a strength, 1..8,
// for each, three bits per zone. Modes and packing as in Nielk1's TriggerEffectGenerator
// (gist.github.com/Nielk1/6d54cc2c00d2201ccb8c2720ad7538db, rev. f73a299) and dualsensectl;
// only the modes it calls official, which later firmware keeps. [`crate::TRIGGER_OFF`] frees
// the trigger.
// use crate::{TRIGGER_OFF, TriggerEffect};

FEEDBACK :: 0x21
WEAPON :: 0x25
VIBRATION :: 0x26

// Zone bits and three-bit levels (`level - 1`) for the zones whose level isn't 0.
zones :: proc(levels: [u8; 10]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut active = 0;
    // rust: let mut values = 0;
    // rust: for (i, level) in levels.into_iter().enumerate() {
    // rust: if level > 0 {
    // rust: active |= 1 << i;
    // rust: values |= u32::from(level.min(8) - 1) << (3 * i);
}
}
    // rust: (active, values)
}

zoned :: proc(mode: u8, levels: [u8; 10]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let (active, values) = zones(levels);
    // rust: let mut e = [0; 11];
    // rust: e[0] = mode;
    // rust: e[1..3].copy_from_slice(&active.to_le_bytes());
    // rust: e[3..7].copy_from_slice(&values.to_le_bytes());
    // rust: e
}

// Resistance in each zone, 0 (none) to 8; it holds wherever the trigger is.
resistance :: proc(levels: [u8; 10]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: zoned(FEEDBACK, levels)
}

// Even resistance from zone `start` (0..9) to the end of the travel, at `strength` (1..8).
feedback :: proc(start: u8, strength: u8) -> T {
    // Ported from Horizon
    return {}
}
    // rust: resistance(std::array::from_fn(|i| {
    // rust: if i >= usize::from(start) {
    // rust: strength.clamp(1, 8)
    // rust: } else {
    // rust: 0
}
    // rust: }))
}

// A gun trigger: resistance from zone `start` that gives way with a click at zone `end`
// (`2 <= start < end <= 8`), at `strength` (1..8).
weapon :: proc(start: u8, end: u8, strength: u8) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let start = start.clamp(2, 7);
    // rust: let end = end.clamp(start + 1, 8);
    // rust: let mut e = [0; 11];
    // rust: e[0] = WEAPON;
    // rust: e[1..3].copy_from_slice(&((1u16 << start) | (1u16 << end)).to_le_bytes());
    // rust: e[3] = strength.clamp(1, 8) - 1;
    // rust: e
}

// A buzz from zone `start` (0..9) on, at `amplitude` (1..8) and `frequency` Hz; at 0 Hz,
// nothing (as Nielk1's factory).
vibration :: proc(start: u8, amplitude: u8, frequency: u8) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if frequency == 0 {
    // rust: return TRIGGER_OFF;
}
    // rust: let mut e = zoned(
    // rust: VIBRATION,
    // rust: std::array::from_fn(|i| {
    // rust: if i >= usize::from(start) {
    // rust: amplitude.clamp(1, 8)
    // rust: } else {
    // rust: 0
}
    // rust: }),
    // rust: );
    // rust: e[9] = frequency;
    // rust: e
}

    // rust: mod tests {
//     use super::*;

feedback_bytes :: proc() {
}
        // Zones 3..9 at strength 6 (stored as 5, three bits each).
    // rust: assert_eq!(
    // rust: feedback(3, 6),
    // rust: [0x21, 0xf8, 0x03, 0x00, 0xda, 0xb6, 0x2d, 0, 0, 0, 0]
    // rust: );
    // rust: assert_eq!(feedback(0, 1), [0x21, 0xff, 0x03, 0, 0, 0, 0, 0, 0, 0, 0]);
        // Out-of-range strengths are clamped.
    // rust: assert_eq!(feedback(0, 0), feedback(0, 1));
    // rust: assert_eq!(feedback(0, 9), feedback(0, 8));
}

resistance_per_zone :: proc() {
}
    // rust: let e = resistance([0, 0, 1, 2, 3, 4, 5, 6, 7, 8]);
    // rust: assert_eq!(u16::from_le_bytes([e[1], e[2]]), 0b11_1111_1100);
    // rust: let values = u32::from_le_bytes([e[3], e[4], e[5], e[6]]);
    // rust: for zone in 2..10 {
    // rust: assert_eq!((values >> (3 * zone)) & 7, zone - 2);
}
}

weapon_bytes :: proc() {
}
    // rust: assert_eq!(
    // rust: weapon(2, 6, 6),
    // rust: [0x25, 0x44, 0x00, 0x05, 0, 0, 0, 0, 0, 0, 0]
    // rust: );
        // The click is always past the start.
    // rust: assert_eq!(weapon(7, 3, 8)[1..3], [0x80, 0x01]);
}

vibration_bytes :: proc() {
}
    // rust: let e = vibration(8, 2, 30);
    // rust: assert_eq!(e[..3], [0x26, 0x00, 0x03]);
    // rust: assert_eq!(
    // rust: u32::from_le_bytes([e[3], e[4], e[5], e[6]]),
    // rust: 1 << 24 | 1 << 27
    // rust: );
    // rust: assert_eq!(e[9], 30);
}

reference_examples :: proc() {
}
        // DSX++'s README, Weapon {2, 6, 8}: zones 2 and 6, strength 8 stored as 7.
    // rust: assert_eq!(
    // rust: weapon(2, 6, 8),
    // rust: [0x25, 0x44, 0x00, 0x07, 0, 0, 0, 0, 0, 0, 0]
    // rust: );
        // dualsensectl's wiki, `weapon 2 3 8`.
    // rust: assert_eq!(weapon(2, 3, 8)[1..4], [0x0c, 0x00, 0x07]);
        // DSX++'s README, Vibration {2, 8, 20}: zones 2..9, amplitude 8 (stored 7) in each
        // zone's three bits, the frequency in byte 9.
    // rust: assert_eq!(
    // rust: vibration(2, 8, 20),
    // rust: [0x26, 0xfc, 0x03, 0xc0, 0xff, 0xff, 0x3f, 0, 0, 20, 0]
    // rust: );
    // rust: assert_eq!(vibration(2, 8, 0), TRIGGER_OFF);
}
}
