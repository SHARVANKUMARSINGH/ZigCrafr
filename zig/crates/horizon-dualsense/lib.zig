//! Transpiled from Horizon Rust crate
//! Module: horizon-dualsense_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The DualSense's output report, built by hand (docs/controllers.md "DualSense output"): the
//! compatible-vibration motors, the adaptive triggers, the lightbar and the player LEDs. Gilrs
//! keeps reading the pad; this crate only writes to it, over hidapi ([`device`]).
//! On iOS the crate builds without hidapi, which has no backend there: [`Link`] never opens.
//!
//! The byte layout is the one documented by the Linux kernel's `hid-playstation.c` and SDL's
//! `SDL_hidapi_ps5.c`: a 47-byte block shared by both transports, sent as report 0x02 over USB
//! and as report 0x31 over Bluetooth, where a sequence tag leads it and a CRC-32 (seeded with
//! the byte 0xA2) closes it.
    // rust: pub mod device;
    // rust: pub mod haptics;
    // rust: pub mod haptics;
    // rust: pub mod trigger;

    // rust: pub use device::{Link, Transport};

/// Sony's vendor ID and the DualSense's product IDs (the plain pad and the Edge).
pub const SONY: u16 = 0x054c;
pub const DUALSENSE: u16 = 0x0ce6;
pub const DUALSENSE_EDGE: u16 = 0x0df2;

/// Whether a USB vendor / product pair is a DualSense.
pub fn is_dualsense(vendor: u16, product: u16) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: vendor == SONY && matches!(product, DUALSENSE | DUALSENSE_EDGE)
}

pub const USB_REPORT_ID: u8 = 0x02;
/// The report ID and the common block; Windows pads a short write to the report's length.
pub const USB_REPORT_LEN: usize = 1 + COMMON_LEN;
pub const BT_REPORT_ID: u8 = 0x31;
pub const BT_REPORT_LEN: usize = 78;
pub const BT_TAG: u8 = 0x10;
pub const BT_CRC_SEED: u8 = 0xa2;
pub const COMMON_LEN: usize = 47;

// Offsets in the common block.
pub const FLAGS0: usize = 0;
pub const FLAGS1: usize = 1;
pub const MOTOR_RIGHT: usize = 2;
pub const MOTOR_LEFT: usize = 3;
pub const RIGHT_TRIGGER: usize = 10;
pub const LEFT_TRIGGER: usize = 21;
/// `reduce_motor_power` (dualsensectl): the motors' attenuation in bits 0..2, the triggers' in
/// bits 4..6, 0 (none) to 7.
pub const ATTENUATION: usize = 36;
pub const FLAGS2: usize = 38;
pub const LIGHTBAR_SETUP: usize = 41;
pub const PLAYER_LEDS: usize = 43;
pub const LIGHTBAR: usize = 44;

// Which parts of the block the pad applies.
pub const FLAG0_COMPATIBLE_VIBRATION: u8 = 1 << 0;
pub const FLAG0_HAPTICS_SELECT: u8 = 1 << 1;
pub const FLAG0_RIGHT_TRIGGER: u8 = 1 << 2;
pub const FLAG0_LEFT_TRIGGER: u8 = 1 << 3;
pub const FLAG1_LIGHTBAR: u8 = 1 << 2;
pub const FLAG1_RELEASE_LEDS: u8 = 1 << 3;
pub const FLAG1_PLAYER_LEDS: u8 = 1 << 4;
pub const FLAG1_ATTENUATION: u8 = 1 << 6;
pub const FLAG2_LIGHTBAR_SETUP: u8 = 1 << 1;
pub const FLAG2_VIBRATION_V2: u8 = 1 << 2;
/// `lightbar_setup`: fade the firmware's own blue light out, so the host's colour shows.
pub const LIGHTBAR_LIGHT_OUT: u8 = 1 << 1;
/// Player LEDs: switch at once instead of fading.
pub const PLAYER_LEDS_INSTANT: u8 = 1 << 5;
/// The middle LED: player 1.
pub const PLAYER_1: u8 = 1 << 2;
/// The blue a host gives a first pad (`hid-playstation.c`), restored when Horizon lets go.
pub const DEFAULT_LIGHTBAR: [u8; 3] = [0, 0, 128];

/// An adaptive trigger's effect: a mode byte and ten parameters.
    // rust: pub type TriggerEffect = [u8; 11];
/// The effect that frees a trigger.
pub const TRIGGER_OFF: TriggerEffect = [0x05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

/// What an output report changes; `None` leaves that part of the pad as it is.
pub const Output = struct {
    /// The vibration motors, 0..255: the left (heavy, low) and the right (light, high) one.
    /// Every report carries them: one without the rumble flags ends the motors' emulation and
    /// hands the actuators back to the audio haptics (SDL_hidapi_ps5.c: "Leaving emulated
    /// rumble bits off will restore audio haptics"), so stopping sends no flags at all.
    rumble: [u8,
    left_trigger: ?TriggerEffect,
    right_trigger: ?TriggerEffect,
    /// Red, green, blue.
    lightbar: Option<[u8,
    /// The five LEDs under the touchpad, left to right in bits 0..4.
    player_leds: ?u8,
    /// Hand the lightbar to the host: the firmware's blue light fades out. Sent alone, before
    /// any colour (hid-playstation.c's `dualsense_reset_leds`).
    release_leds: bool,
    /// Undo the motor and trigger attenuation another host (a PS5's intensity settings) left in
    /// the pad, which would otherwise scale every effect down.
    full_power: bool,
};

/// How the pad takes vibration: newer firmware has a better rumble emulation, picked with its
/// own flag (`hid-playstation.c`'s `use_vibration_v2`, SDL's `enhanced_rumble`); the legacy one
/// still works on every firmware.
pub const Vibration = enum {
    Legacy,
    V2,
};

    // rust: impl Vibration {
    /// From the product and the firmware's update version (feature report 0x20, bytes 44..46;
    /// `None` when it can't be read). The Edge always has it. SDL picks it from 0x0224, the
    /// kernel from 0x0215 (`DS_FEATURE_VERSION(2, 21)`): we take SDL's, as both agree from
    /// there, and legacy below it and when the version is unknown, as it works everywhere.
pub fn of(product: u16, update_version: ?u16) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if product == DUALSENSE_EDGE || update_version.is_some_and(|v| v >= 0x0224) {
    // rust: Vibration::V2
    // rust: } else {
    // rust: Vibration::Legacy
}
}
}

    // rust: impl Output {
    /// Everything off: triggers free, motors still.
pub fn release() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Output {
    // rust: rumble: [0, 0],
    // rust: left_trigger: Some(TRIGGER_OFF),
    // rust: right_trigger: Some(TRIGGER_OFF),
    // rust: ..Output::default()
}
}

    /// The block both transports carry.
pub fn common(self: *Self, vibration: Vibration) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut c = [0; COMMON_LEN];
    // rust: if self.rumble != [0, 0] {
            // Classic rumble rather than the audio-driven haptics.
    // rust: c[FLAGS0] |= FLAG0_HAPTICS_SELECT;
    // rust: let [left, right] = match vibration {
    // rust: Vibration::V2 => {
    // rust: c[FLAGS2] |= FLAG2_VIBRATION_V2;
    // rust: self.rumble
}
    // rust: Vibration::Legacy => {
    // rust: c[FLAGS0] |= FLAG0_COMPATIBLE_VIBRATION;
                    // The old emulation shakes about twice as hard: SDL halves it.
    // rust: self.rumble.map(|m| m >> 1)
}
}
    // rust: c[MOTOR_LEFT] = left;
    // rust: c[MOTOR_RIGHT] = right;
}
    // rust: if self.full_power {
    // rust: c[FLAGS1] |= FLAG1_ATTENUATION;
    // rust: c[ATTENUATION] = 0;
}
    // rust: if let Some(effect) = self.right_trigger {
    // rust: c[FLAGS0] |= FLAG0_RIGHT_TRIGGER;
    // rust: c[RIGHT_TRIGGER..RIGHT_TRIGGER + 11].copy_from_slice(&effect);
}
    // rust: if let Some(effect) = self.left_trigger {
    // rust: c[FLAGS0] |= FLAG0_LEFT_TRIGGER;
    // rust: c[LEFT_TRIGGER..LEFT_TRIGGER + 11].copy_from_slice(&effect);
}
    // rust: if self.release_leds {
    // rust: c[FLAGS1] |= FLAG1_RELEASE_LEDS;
    // rust: c[FLAGS2] |= FLAG2_LIGHTBAR_SETUP;
    // rust: c[LIGHTBAR_SETUP] = LIGHTBAR_LIGHT_OUT;
}
    // rust: if let Some(rgb) = self.lightbar {
    // rust: c[FLAGS1] |= FLAG1_LIGHTBAR;
    // rust: c[LIGHTBAR..LIGHTBAR + 3].copy_from_slice(&rgb);
}
    // rust: if let Some(leds) = self.player_leds {
    // rust: c[FLAGS1] |= FLAG1_PLAYER_LEDS;
    // rust: c[PLAYER_LEDS] = leds;
}
    // rust: c
}

    /// Report 0x02, for a pad on USB.
pub fn usb(self: *Self, vibration: Vibration) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = [0; USB_REPORT_LEN];
    // rust: r[0] = USB_REPORT_ID;
    // rust: r[1..].copy_from_slice(&self.common(vibration));
    // rust: r
}

    /// Report 0x31, for a pad on Bluetooth: `seq` (0..15, wrapping) in the high nibble of the
    /// second byte, then the tag, the block, and the CRC-32 of the seed byte and everything
    /// before it, little-endian.
pub fn bluetooth(self: *Self, vibration: Vibration, seq: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut r = [0; BT_REPORT_LEN];
    // rust: r[0] = BT_REPORT_ID;
    // rust: r[1] = (seq & 0x0f) << 4;
    // rust: r[2] = BT_TAG;
    // rust: r[3..3 + COMMON_LEN].copy_from_slice(&self.common(vibration));
    // rust: let crc = bt_crc(&r[..BT_REPORT_LEN - 4]);
    // rust: r[BT_REPORT_LEN - 4..].copy_from_slice(&crc.to_le_bytes());
    // rust: r
}
}

/// The CRC a Bluetooth output report ends with: CRC-32 over the seed byte 0xA2 and the report.
pub fn bt_crc(report: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !report.iter().fold(crc32_update(!0, BT_CRC_SEED), |crc, b| {
    // rust: crc32_update(crc, *b)
    // rust: })
}

/// One byte of the reflected CRC-32 (zlib's, polynomial 0xEDB88320).
pub fn crc32_update(crc: u32, byte: u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut crc = crc ^ u32::from(byte);
    // rust: for _ in 0..8 {
    // rust: crc = (crc >> 1) ^ (0xedb8_8320 & (crc & 1).wrapping_neg());
}
    // rust: crc
}

    // rust: mod tests {
//     use super::*;

pub fn crc32(data: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !data.iter().fold(!0, |crc, b| crc32_update(crc, *b))
}

pub fn crc_is_zlibs() void {
}
        // The standard check value.
    // rust: assert_eq!(crc32(b"123456789"), 0xcbf4_3926);
    // rust: assert_eq!(bt_crc(b"123456789"), crc32(b"\xa2123456789"));
}

pub fn usb_report_layout() void {
}
    // rust: let out = Output {
    // rust: rumble: [200, 40],
    // rust: right_trigger: Some([0x25, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
    // rust: lightbar: Some([255, 128, 0]),
    // rust: player_leds: Some(0b00100),
    // rust: ..Output::default()
}
    // rust: let r = out.usb(Vibration::V2);
    // rust: assert_eq!(r.len(), 48);
    // rust: assert_eq!(r[0], 0x02);
        // Classic rumble and the right trigger in flags 0, lightbar and player LEDs in flags 1,
        // the newer rumble emulation in flags 2.
    // rust: assert_eq!(r[1], 0b0000_0110);
    // rust: assert_eq!(r[2], 0b0001_0100);
        // Right motor, then left.
    // rust: assert_eq!(r[3..5], [40, 200]);
    // rust: assert_eq!(r[11..22], [0x25, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        // The left trigger is untouched.
    // rust: assert_eq!(r[22..33], [0; 11]);
    // rust: assert_eq!(r[39], FLAG2_VIBRATION_V2);
    // rust: assert_eq!(r[44], 0b00100);
    // rust: assert_eq!(r[45..48], [255, 128, 0]);
}

pub fn legacy_vibration() void {
}
        // SDL's pre-2.24 path: rumble emulation (0x01) and audio haptics off (0x02), the
        // motors halved, nothing in flags 2.
    // rust: let c = Output {
    // rust: rumble: [200, 41],
    // rust: ..Output::default()
}
    // rust: .common(Vibration::Legacy);
    // rust: assert_eq!(c[FLAGS0], 0x03);
    // rust: assert_eq!(c[MOTOR_RIGHT..=MOTOR_LEFT], [20, 100]);
    // rust: assert_eq!(c[FLAGS2], 0);
}

pub fn vibration_mode_of_the_firmware() void {
}
    // rust: assert_eq!(Vibration::of(DUALSENSE, Some(0x0223)), Vibration::Legacy);
    // rust: assert_eq!(Vibration::of(DUALSENSE, Some(0x0224)), Vibration::V2);
    // rust: assert_eq!(Vibration::of(DUALSENSE, Some(0x0641)), Vibration::V2);
    // rust: assert_eq!(Vibration::of(DUALSENSE, None), Vibration::Legacy);
    // rust: assert_eq!(Vibration::of(DUALSENSE_EDGE, None), Vibration::V2);
}

pub fn still_motors_send_no_rumble_flags() void {
}
        // The all-zero report, which also re-arms the audio haptics (nondebug/dualsense).
    // rust: assert_eq!(Output::default().common(Vibration::V2), [0; COMMON_LEN]);
    // rust: assert_eq!(Output::default().common(Vibration::Legacy), [0; COMMON_LEN]);
}

pub fn release_frees_both_triggers_and_stops_the_motors() void {
}
    // rust: let c = Output::release().common(Vibration::V2);
    // rust: assert_eq!(c[FLAGS0], FLAG0_LEFT_TRIGGER | FLAG0_RIGHT_TRIGGER);
    // rust: assert_eq!(c[FLAGS0], 0b1100);
    // rust: assert_eq!(c[MOTOR_RIGHT..=MOTOR_LEFT], [0, 0]);
    // rust: assert_eq!(c[RIGHT_TRIGGER..RIGHT_TRIGGER + 11], TRIGGER_OFF);
    // rust: assert_eq!(c[LEFT_TRIGGER..LEFT_TRIGGER + 11], TRIGGER_OFF);
        // Nothing else changes.
    // rust: assert_eq!(c[FLAGS1], 0);
    // rust: assert_eq!(c[FLAGS2], 0);
}

pub fn full_power_clears_the_attenuation() void {
}
    // rust: let c = Output {
    // rust: full_power: true,
    // rust: ..Output::default()
}
    // rust: .common(Vibration::V2);
        // dualsensectl's VIBRATION_ATTENUATION_ENABLE and `reduce_motor_power`.
    // rust: assert_eq!(c[FLAGS1], 0x40);
    // rust: assert_eq!(c[36], 0);
}

pub fn release_leds_resets_the_lights() void {
}
        // hid-playstation.c's dualsense_reset_leds (lightbar setup: light out) and SDL's
        // "Reset LED state" bit, over Bluetooth with sequence number 5; the CRC is
        // zlib.crc32(b"\xa2" + report[:74]).
    // rust: let mut expected = [0; BT_REPORT_LEN];
    // rust: expected[..5].copy_from_slice(&[0x31, 0x50, 0x10, 0x00, 0x08]);
    // rust: expected[3 + 38] = 0x02;
    // rust: expected[3 + 41] = 0x02;
    // rust: expected[74..].copy_from_slice(&0xc72d_0f94u32.to_le_bytes());
    // rust: let out = Output {
    // rust: release_leds: true,
    // rust: ..Output::default()
}
    // rust: assert_eq!(out.bluetooth(Vibration::V2, 5), expected);
}

pub fn bluetooth_report_layout() void {
}
    // rust: let out = Output {
    // rust: lightbar: Some([1, 2, 3]),
    // rust: ..Output::default()
}
    // rust: let r = out.bluetooth(Vibration::V2, 0x13);
    // rust: assert_eq!(r.len(), 78);
        // The sequence number in the high nibble, the tag 0x10 (hid-playstation.c).
    // rust: assert_eq!(r[..3], [0x31, 0x30, 0x10]);
    // rust: assert_eq!(r[3..50], out.common(Vibration::V2));
    // rust: assert_eq!(r[50..74], [0; 24]);
    // rust: let crc = u32::from_le_bytes(r[74..].try_into().unwrap());
    // rust: assert_eq!(crc, crc32(&[&[0xa2], &r[..74]].concat()));
        // The sequence number changes the CRC.
    // rust: assert_ne!(out.bluetooth(Vibration::V2, 1)[74..], r[74..]);
}

pub fn host_defaults() void {
}
        // hid-playstation.c: player 1 is BIT(2) ("--x--"), as SDL's first pattern 0x04; the
        // blue it gives a pad; SDL's 0x20 switches LEDs without fading.
    // rust: assert_eq!(PLAYER_1, 0x04);
    // rust: assert_eq!(DEFAULT_LIGHTBAR, [0, 0, 128]);
    // rust: assert_eq!(PLAYER_LEDS_INSTANT, 0x20);
}

pub fn dualsense_ids() void {
}
    // rust: assert!(is_dualsense(0x054c, 0x0ce6));
    // rust: assert!(is_dualsense(0x054c, 0x0df2));
        // A DualShock 4.
    // rust: assert!(!is_dualsense(0x054c, 0x09cc));
}
}
