//! Transpiled from Horizon Rust crate
//! Module: horizon-dualsense_haptics
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! HD haptics: on USB the DualSense is also a four-channel 48 kHz audio device, whose channels 3
//! and 4 drive the left and right voice-coil actuators (1 and 2 are its speaker and headset).
//! Vibrations are synthesized as waveforms on those two channels; the first two stay silent.
//! Over Bluetooth there is no audio device, and the motors' emulation is used instead.
// use cpal::traits::{DeviceTrait, HostTrait, StreamTrait};
// use std::collections::VecDeque;
// use std::f32::consts::TAU;
// use std::sync::{Arc, Mutex};
// use std::time::Duration;

pub const RATE: u32 = 48_000;
/// The frequencies the heavy and light parts of a vibration play at.
pub const HEAVY_HZ: f32 = 80.0;
pub const LIGHT_HZ: f32 = 200.0;
/// Fades between steps, so a level change doesn't click.
pub const RAMP: f32 = 0.004;

/// The pad's audio output, playing the queued samples (left, right actuator).
pub const Haptics = struct {
    queue: Arc<Mutex<VecDeque<[f32,
    _stream: cpal::Stream,
};

    // rust: impl Haptics {
    /// The DualSense's audio device, if one is there with its four channels (USB).
pub fn open() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let host = cpal::default_host();
    // rust: let device = host.output_devices().ok()?.find(is_dualsense)?;
    // rust: let config = cpal::StreamConfig {
    // rust: channels: 4,
    // rust: sample_rate: cpal::SampleRate(RATE),
    // rust: buffer_size: cpal::BufferSize::Default,
}
    // rust: let queue = Arc::new(Mutex::new(VecDeque::new()));
    // rust: let source = queue.clone();
    // rust: let stream = device
    // rust: .build_output_stream(
    // rust: &config,
    // rust: move |data: &mut [f32], _| {
    // rust: let mut queue = source.lock().unwrap_or_else(|e| e.into_inner());
    // rust: for frame in data.chunks_mut(4) {
    // rust: let [left, right] = queue.pop_front().unwrap_or_default();
    // rust: frame.copy_from_slice(&[0.0, 0.0, left, right]);
}
    // rust: },
    // rust: |e| log::debug!("DualSense haptics: {e}"),
    // rust: None,
    // rust: )
    // rust: .map_err(|e| log::info!("Horizon: DualSense haptics unavailable: {e}"))
    // rust: .ok()?;
    // rust: stream.play().ok()?;
    // rust: log::info!("DualSense HD haptics through its audio device");
    // rust: Some(Haptics {
    // rust: queue,
    // rust: _stream: stream,
    // rust: })
}

    /// Play a vibration (heavy and light levels, 0..1, each for a while), replacing the one
    /// playing.
pub fn play(self: *Self, steps: *[(f32) void {
}
    // rust: let samples = waveform(steps);
    // rust: let mut queue = self.queue.lock().unwrap_or_else(|e| e.into_inner());
    // rust: queue.clear();
    // rust: queue.extend(samples.into_iter().map(|v| [v, v]));
}

    /// Stop at once.
pub fn stop(self: *Self) void {
}
    // rust: self.queue.lock().unwrap_or_else(|e| e.into_inner()).clear();
}
}

pub fn is_dualsense(device: *cpal::Device) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device.name().is_ok_and(|n| is_dualsense_name(&n))
    // rust: && device.supported_output_configs().is_ok_and(|mut configs| {
    // rust: configs.any(|c| {
    // rust: c.channels() >= 4
    // rust: && c.min_sample_rate().0 <= RATE
    // rust: && c.max_sample_rate().0 >= RATE
    // rust: && c.sample_format() == cpal::SampleFormat::F32
    // rust: })
    // rust: })
}

/// "DualSense Wireless Controller" on macOS; on Windows the endpoint is often just "Speakers
/// (Wireless Controller)" (DS5Windows' and dse-haptics' setup notes), a name the DualShock 4's
/// two-channel headset output shares, which the four channels rule out; ALSA names the card
/// "Controller".
pub fn is_dualsense_name(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: name.contains("DualSense")
    // rust: || name.contains("Wireless Controller")
    // rust: || name.contains("CARD=Controller")
}

/// The samples of a vibration: the heavy and light tones at each step's levels, with short
/// ramps between steps and to silence at the end.
pub fn waveform(steps: *[(f32) void {
}
    // rust: let ramp = (RAMP * RATE as f32) as usize;
    // rust: let mut out = Vec::new();
    // rust: let mut level = [0.0f32; 2];
    // rust: let mut t = 0usize;
    // rust: for &(heavy, light, length) in steps.iter().chain(&[(0.0, 0.0, Duration::ZERO)]) {
    // rust: let target = [heavy.clamp(0.0, 1.0), light.clamp(0.0, 1.0)];
    // rust: let from = level;
    // rust: let n = (length.as_secs_f32() * RATE as f32) as usize;
    // rust: for i in 0..n.max(ramp) {
    // rust: let k = (i as f32 / ramp as f32).min(1.0);
    // rust: level = [0, 1].map(|j| from[j] + (target[j] - from[j]) * k);
    // rust: let time = t as f32 / RATE as f32;
    // rust: let v =
    // rust: level[0] * (TAU * HEAVY_HZ * time).sin() + level[1] * (TAU * LIGHT_HZ * time).sin();
    // rust: out.push(v.clamp(-1.0, 1.0));
    // rust: t += 1;
}
}
    // rust: out
}

    // rust: mod tests {
//     use super::*;

pub fn device_names() void {
}
    // rust: assert!(is_dualsense_name("DualSense Wireless Controller"));
    // rust: assert!(is_dualsense_name("Speakers (Wireless Controller)"));
    // rust: assert!(is_dualsense_name(
    // rust: "Speakers (2- DualSense Wireless Controller)"
    // rust: ));
    // rust: assert!(is_dualsense_name("plughw:CARD=Controller,DEV=0"));
    // rust: assert!(!is_dualsense_name("MacBook Pro Speakers"));
    // rust: assert!(!is_dualsense_name("hw:CARD=PCH,DEV=0"));
}

pub fn waveform_follows_the_steps() void {
}
    // rust: let w = waveform(&[(1.0, 0.0, Duration::from_millis(100))]);
        // The step, then the ramp down.
    // rust: assert_eq!(w.len(), 4800 + 192);
        // Starts silent, reaches full strength, ends silent.
    // rust: assert_eq!(w[0], 0.0);
    // rust: let peak = w[1000..4800].iter().fold(0.0f32, |m, v| m.max(v.abs()));
    // rust: assert!(peak > 0.99, "{peak}");
    // rust: assert!(w.last().unwrap().abs() < 0.01);
    // rust: assert!(w.iter().all(|v| v.abs() <= 1.0));
    // rust: assert!(waveform(&[]).iter().all(|v| *v == 0.0));
}
}
