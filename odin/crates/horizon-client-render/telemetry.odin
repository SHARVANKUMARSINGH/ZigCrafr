//! Transpiled from Horizon Rust crate
package horizon_client_render_telemetry

import "core:fmt"
import "core:mem"
import "core:math"

// The game's part in opt-in data collection (`horizon_telemetry`, docs/telemetry.md). When the
// player allows it, the game keeps a scrubbed crash report, or a play session's performance
// summary, in the outbox. It never sends those itself: the launcher does, at its next start (the
// game's only sending is the anonymous "I'm playing" ping, `heartbeat.rs`).
// Without the player's yes for that kind nothing is kept, and crash-reports/ stays local.
// use std::path::Path;
// use std::sync::atomic::{AtomicU32, Ordering};
// use std::sync::{Mutex, OnceLock};
// use std::time::Instant;

// use horizon_telemetry::payload::{Crash, Display, Perf, Settings, System, Timings};
// use horizon_telemetry::scrub::Scrubber;
// use horizon_telemetry::{Item, Payload, Source, outbox};

// A session shorter than this says too little to keep.
MIN_SECONDS :: 60.0

// The details of a crash report that say what the game was doing, and only those: not the
// world, the server or the resource packs.
CRASH_DETAILS :: ["Horizon Version", "Graphics Adapter", "Render Settings"]

STARTED :: OnceLock::new()
CORE_READY_MS :: AtomicU32::new(u32::MAX)
REST_READY_MS :: AtomicU32::new(u32::MAX)
// The GPU, once the renderer has its adapter: name, maker, kind, driver, backend, its own memory.
GPU :: Mutex::new(None)
// The screen the window opened on.
DISPLAY :: Mutex::new(None)

// The adapter as the renderer found it.
Gpu :: struct {
    name: string,
    vendor: string,
    // `integrated`, `discrete`, `virtual`, `cpu` or `other`.
    kind: string,
    driver: string,
    backend: string,
}

// When the game started, for the time to the title screen. Call first thing in `main`.
mark_start :: proc() {
}
    // rust: STARTED.get_or_init(Instant::now);
}

mark_core_ready :: proc() {
}
    // rust: mark_ready(&CORE_READY_MS);
}

mark_rest_ready :: proc() {
}
    // rust: mark_ready(&REST_READY_MS);
}

mark_ready :: proc(mark: ^AtomicU32) {
}
    // rust: if let Some(started) = STARTED.get() {
    // rust: let ms = started.elapsed().as_millis().min(u128::from(u32::MAX - 1)) as u32;
    // rust: let _ = mark.compare_exchange(u32::MAX, ms, Ordering::Relaxed, Ordering::Relaxed);
}
}

readiness_ms :: proc(mark: ^AtomicU32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let ms = mark.load(Ordering::Relaxed);
    // rust: (ms != u32::MAX).then_some(ms)
}

set_gpu :: proc(gpu: Gpu) {
}
    // rust: *GPU.lock().unwrap_or_else(|e| e.into_inner()) = Some(gpu);
}

// The screen the window is on: size in physical pixels, refresh rate, scale.
set_display :: proc(width: u32, height: u32, refresh_hz: u32, scale: f64) {
}
    // rust: *DISPLAY.lock().unwrap_or_else(|e| e.into_inner()) = Some(Display {
    // rust: width,
    // rust: height,
    // rust: refresh_hz,
    // rust: scale: scale as f32,
    // rust: });
}

// The screen `window` is on, else the primary one, else the only one: right after the window
// is made, Wayland doesn't say yet which screen it is on.
monitor :: proc(window: ^winit::window::Window) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let only = || {
    // rust: let mut all = window.available_monitors();
    // rust: all.next().filter(|_| all.next().is_none())
}
    // rust: window
    // rust: .current_monitor()
    // rust: .or_else(|| window.primary_monitor())
    // rust: .or_else(only)
}

// Keeps [`monitor`]'s size, refresh rate and scale for the items' `system.display`.
note_display :: proc(window: ^winit::window::Window) {
}
    // rust: if let Some(m) = monitor(window) {
    // rust: set_display(
    // rust: m.size().width,
    // rust: m.size().height,
    // rust: m.refresh_rate_millihertz().map_or(0, |r| r.div_ceil(1000)),
    // rust: m.scale_factor(),
    // rust: );
}
}

// wgpu's device type in the words items use.
gpu_kind :: proc(device_type: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match device_type {
    // rust: "IntegratedGpu" => "integrated",
    // rust: "DiscreteGpu" => "discrete",
    // rust: "VirtualGpu" => "virtual",
    // rust: "Cpu" => "cpu",
    // rust: _ => "other",
}
}

// This machine, with the GPU and the screen once the renderer knows them. The drive is the one
// under the game folder (the current folder).
system :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let home = std::env::current_dir().ok();
    // rust: let mut system = System::detect_in(home.as_deref());
    // rust: if let Some(gpu) = GPU.lock().unwrap_or_else(|e| e.into_inner()).clone() {
    // rust: system.vram_mb = match gpu.kind.as_str() {
    // rust: "discrete" => horizon_telemetry::system::vram_mb(&gpu.vendor).unwrap_or(0),
    // rust: _ => 0,
}
    // rust: system.gpu = gpu.name;
    // rust: system.gpu_vendor = gpu.vendor;
    // rust: system.gpu_kind = gpu.kind;
    // rust: system.driver = gpu.driver;
    // rust: system.backend = gpu.backend;
}
    // rust: system.display = DISPLAY.lock().unwrap_or_else(|e| e.into_inner()).clone();
    // rust: system
}

// The release (`v0.2.3`), or the client's crate version for a build from source.
version :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: crate::crash::release_tag().unwrap_or_else(|| format!("dev {}", env!("CARGO_PKG_VERSION")))
}

// What a crash report becomes when it may leave: the error and stack, the thread, and the
// details in [`CRASH_DETAILS`], with the world's name and folder and the server's address
// scrubbed wherever they appear. No log lines.
crash_item :: proc(report: ^crate::crash::Report) -> I {
    // Ported from Horizon
    return {}
}
    // rust: let mut scrubber = Scrubber::new();
    // rust: for (key, value) in &report.details {
    // rust: match key.as_str() {
            // `Name (saves/folder)`, as game.rs sets it.
    // rust: "World" => {
    // rust: let (name, folder) = value.rsplit_once(" (saves/").unwrap_or((value, ""));
    // rust: scrubber = scrubber.term(name).term(folder.trim_end_matches(')'));
}
    // rust: "Server" => {
    // rust: let host = value.rsplit_once(':').map_or(value.as_str(), |(h, _)| h);
    // rust: scrubber = scrubber.term(value.as_str()).term(host);
}
    // rust: _ => {}
}
}
    // rust: let crash = Crash {
    // rust: system: system(),
    // rust: error: scrubber.scrub(&report.error),
    // rust: stack: scrubber.scrub(&report.stack),
    // rust: thread: report.thread.clone(),
    // rust: details: report
    // rust: .details
    // rust: .iter()
    // rust: .filter(|(k, _)| CRASH_DETAILS.contains(&k.as_str()))
    // rust: .map(|(k, v)| (k.clone(), scrubber.scrub(v)))
    // rust: .collect(),
}
    // rust: let mut item = Item::new(Source::Game, version(), Payload::Crash(crash));
    // A huge stack keeps its top, where the error is.
    // rust: while item.validate().is_err() {
    // rust: let Payload::Crash(crash) = &mut item.payload else {
    // rust: break;
}
    // rust: let keep = crash.stack.lines().count() * 3 / 4;
    // rust: if keep == 0 {
    // rust: crash.stack.clear();
    // rust: break;
}
    // rust: crash.stack = crash
    // rust: .stack
    // rust: .lines()
    // rust: .take(keep)
    // rust: .map(|l| format!("{l}\n"))
    // rust: .collect();
}
    // rust: item
}

// Keeps the crash for the launcher to send, if the player allows crash reports.
keep_crash :: proc(home: ^Path, report: ^crate::crash::Report) {
}
    // rust: if let Err(e) = outbox::push(home, &crash_item(report)) {
    // rust: log::warn!("Horizon: could not keep the crash report to send: {e}");
}
}

// Keeps a benchmark report (`--benchmark`) for the launcher to send, if the player allows
// benchmark uploads: the report as docs/benchmark-report.md defines it, dated to the day.
keep_benchmark :: proc(home: ^Path, report: ^horizon_bench::Report) {
}
    // rust: let Ok(data) = serde_json::to_value(report.for_upload()) else {
    // rust: return;
}
    // rust: if let Err(e) = outbox::push(
    // rust: home,
    // rust: &Item::new(Source::Game, version(), Payload::Benchmark(data)),
    // rust: ) {
    // rust: log::warn!("Horizon: could not keep the benchmark report to send: {e}");
}
}

// One play session's performance, from entering a world to leaving it: frame and tick
// times as [`Timings`] (fixed size whatever the length), never the frames themselves.
Session :: struct {
    frames: Timings,
    ticks: Timings,
    played_ms: f32,
    to_title_ms: Maybe(u32),
    // The start was measured: only the first session carries it.
    title_measured: bool,
    to_world_ms: Maybe(u32),
    opening: Maybe(Instant),
    slow_frames: [dynamic]horizon_telemetry::payload::SlowFrames,
}

    // rust: impl Session {
    // The title screen drew a frame: the first time, how long the start took.
title_shown :: proc(self: ^Self) {
}
    // rust: if !self.title_measured {
    // rust: self.title_measured = true;
    // rust: crate::spans::startup::mark("title.shown");
            // The frame itself: the menu bundle can be ready seconds before
            // the renderer that draws it (pipelines compiling on a slow driver).
    // rust: self.to_title_ms = STARTED.get().map(|s| s.elapsed().as_millis() as u32);
}
}

    // A world starts loading.
world_opening :: proc(self: ^Self) {
}
    // rust: if self.opening.is_none() {
    // rust: crate::spans::startup::arm("world.opening");
}
    // rust: self.opening.get_or_insert_with(Instant::now);
}

    // An entry queued during startup was cancelled before opening a world.
cancel_world_opening :: proc(self: ^Self) {
}
    // rust: self.opening = None;
}

    // A frame drawn while playing (not in menus or loading), with the spans the render thread
    // recorded in it ([`crate::spans::take_raw`]): a frame of `SLOW_FRAME_MS` or more counts
    // under the step it spent most of its time in ([`crate::spans::culprit`]).
frame :: proc(self: ^Self, ms: f32, spans: ^[crate::spans::Span]) {
}
//         use horizon_telemetry::payload::{SLOW_FRAME_MS, SlowFrames};
    // rust: if ms >= SLOW_FRAME_MS {
    // rust: let (mut path, span_ms) = crate::spans::culprit(spans).unwrap_or_default();
            // A path too long for the item keeps its last steps.
    // rust: while path.len() > SlowFrames::MAX_NAME
    // rust: && let Some((_, rest)) = path.split_once('/')
    // rust: {
    // rust: path = rest.to_owned();
}
    // rust: SlowFrames::record(&mut self.slow_frames, ms, &path, span_ms);
}
    // rust: if let Some(opening) = self.opening.take() {
    // rust: crate::spans::startup::mark("world.first_frame");
    // rust: if self.to_world_ms.is_none() {
    // rust: self.to_world_ms = Some(opening.elapsed().as_millis() as u32);
}
}
    // rust: self.frames.record(ms);
    // rust: self.played_ms += ms;
}

    // One tick of the integrated server, in single player.
tick :: proc(self: ^Self, ms: f32) {
}
    // rust: self.ticks.record(ms);
}

    // The session's summary, if it was long enough to say something.
summary :: proc(self: ^Self, settings: Settings) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let seconds = self.played_ms / 1000.0;
    // rust: (seconds >= MIN_SECONDS).then(|| Perf {
    // rust: system: system(),
    // rust: settings,
    // rust: seconds: seconds as u32,
    // rust: frames: self.frames.summary(),
    // rust: ticks: (self.ticks.count() > 0).then(|| self.ticks.summary()),
    // rust: peak_ram_mb: peak_ram_mb(),
    // rust: to_title_ms: self.to_title_ms,
    // rust: to_world_ms: self.to_world_ms,
    // rust: to_core_ms: self.to_title_ms.and_then(|_| readiness_ms(&CORE_READY_MS)),
    // rust: to_rest_ms: self.to_title_ms.and_then(|_| readiness_ms(&REST_READY_MS)),
    // rust: slow_frames: self.slow_frames.clone(),
    // rust: })
}

    // Keeps the session's summary for the launcher to send, if the player allows performance
    // statistics, and starts the next session (the time to the title goes with the first).
finish :: proc(self: ^Self, home: ^Path, settings: Settings) {
}
    // rust: if horizon_telemetry::Consent::load(home).allows(horizon_telemetry::Kind::Perf)
    // rust: && let Some(perf) = self.summary(settings)
    // rust: {
    // rust: let item = Item::new(Source::Game, version(), Payload::Perf(perf));
    // rust: if let Err(e) = outbox::push(home, &item) {
    // rust: log::warn!("Horizon: could not keep the session's performance summary: {e}");
}
}
    // rust: *self = Self {
    // rust: title_measured: self.title_measured,
    // rust: ..Self::default()
}
}
}

// The game's resident memory: the peak on Linux, what it uses now elsewhere.
peak_ram_mb :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: let kib = if cfg!(target_os = "linux") {
    // rust: std::fs::read_to_string("/proc/self/status")
    // rust: .ok()
    // rust: .and_then(|t| {
    // rust: t.lines()
    // rust: .find(|l| l.starts_with("VmHWM:"))?
    // rust: .split_whitespace()
    // rust: .nth(1)?
    // rust: .parse::<u64>()
    // rust: .ok()
    // rust: })
    // rust: } else if cfg!(target_os = "macos") {
    // rust: std::process::Command::new("ps")
    // rust: .args(["-o", "rss=", "-p", &std::process::id().to_string()])
    // rust: .output()
    // rust: .ok()
    // rust: .and_then(|o| {
    // rust: String::from_utf8_lossy(&o.stdout)
    // rust: .trim()
    // rust: .parse::<u64>()
    // rust: .ok()
    // rust: })
    // rust: } else {
    // rust: None
}
    // rust: kib.map_or(0, |k| (k / 1024) as u32)
}

    // rust: mod tests {
//     use super::*;
//     use horizon_telemetry::{Choices, Consent, Kind};

home :: proc(name: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-client-telemetry-{name}-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: dir
}

allow :: proc(home: ^Path, choices: Choices) {
}
    // rust: let mut consent = Consent::load(home);
    // rust: consent.answer(choices);
    // rust: consent.save(home).unwrap();
}

report :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: crate::crash::Report {
    // rust: time: chrono::Local::now(),
    // rust: description: "Unexpected error".into(),
    // rust: error:
    // rust: "panicked at src/save.rs:10:5:\nno level.dat in /Users/ana/horizon/saves/Ana's Base"
    // rust: .into(),
    // rust: stack: "horizon_client::save::load (crates/horizon-client/src/save.rs:10:5)\n".into(),
    // rust: thread: "Render thread".into(),
    // rust: side: "client",
    // rust: details: vec![
    // rust: (
    // rust: "Horizon Version".into(),
    // rust: "v2026.10.15 (client 0.1.0)".into(),
    // rust: ),
    // rust: (
    // rust: "Operating System".into(),
    // rust: "macos (aarch64) version macOS 26.0".into(),
    // rust: ),
    // rust: ("World".into(), "Castle Ana (saves/Ana's Base)".into()),
    // rust: ("Server".into(), "play.example.net:25565".into()),
    // rust: ("Resource Packs".into(), "Ana's pack".into()),
    // rust: ],
    // rust: log: vec!["[CHAT] <Ana> hi".into()],
}
}

a_crash_keeps_only_what_says_what_happened :: proc() {
}
    // rust: let item = crash_item(&report());
    // rust: let Payload::Crash(crash) = &item.payload else {
    // rust: panic!("a crash item");
}
    // rust: assert_eq!(
    // rust: crash.error,
    // rust: "panicked at src/save.rs:10:5:\nno level.dat in /Users/<user>/horizon/saves/<private>"
    // rust: );
    // rust: assert_eq!(
    // rust: crash.details,
    // rust: [(
    // rust: "Horizon Version".to_owned(),
    // rust: "v2026.10.15 (client 0.1.0)".to_owned()
    // rust: )]
    // rust: );
    // rust: let json = serde_json::to_string(&item).unwrap();
    // rust: for private in [
    // rust: "Castle Ana",
    // rust: "Ana's Base",
    // rust: "example.net",
    // rust: "Ana's pack",
    // rust: "CHAT",
    // rust: ] {
    // rust: assert!(!json.contains(private), "{private} in {json}");
}
    // rust: assert!(item.validate().is_ok());
}

a_huge_stack_is_cut_to_fit :: proc() {
}
    // rust: let mut report = report();
    // rust: report.stack =
    // rust: "horizon_client::game::deep (crates/horizon-client/src/game.rs:1:1)\n".repeat(2000);
    // rust: let item = crash_item(&report);
    // rust: assert!(item.validate().is_ok());
    // rust: let Payload::Crash(crash) = item.payload else {
    // rust: panic!("a crash item");
}
    // rust: assert!(crash.stack.lines().count() > 100);
}

benchmark_reports_need_their_own_consent_and_go_dated_to_the_day :: proc() {
}
    // rust: let home = home("benchmark");
    // rust: let mut report = horizon_bench::Report::new(horizon_bench::Kind::Game, Default::default());
    // rust: report.created = "2026-10-15T14:03:27Z".into();
    // rust: report.label = Some("my machine".into());
    // rust: keep_benchmark(&home, &report);
    // rust: allow(
    // rust: &home,
    // rust: Choices {
    // rust: performance: true,
    // rust: ..Choices::NONE
    // rust: },
    // rust: );
    // rust: keep_benchmark(&home, &report);
    // rust: assert!(outbox::pending(&home).is_empty());
    // rust: allow(
    // rust: &home,
    // rust: Choices {
    // rust: benchmarks: true,
    // rust: ..Choices::NONE
    // rust: },
    // rust: );
    // rust: keep_benchmark(&home, &report);
    // rust: let pending = outbox::pending(&home);
    // rust: assert_eq!(pending.len(), 1);
    // rust: let text = serde_json::to_string(&pending[0].1).unwrap();
    // rust: assert!(
    // rust: text.contains("2026-10-15T00:00:00Z") && !text.contains("my machine"),
    // rust: "{text}"
    // rust: );
}

crashes_stay_local_without_consent :: proc() {
}
    // rust: let home = home("crash");
    // rust: keep_crash(&home, &report());
    // rust: assert!(outbox::pending(&home).is_empty());
    // rust: allow(
    // rust: &home,
    // rust: Choices {
    // rust: performance: true,
    // rust: ..Choices::NONE
    // rust: },
    // rust: );
    // rust: keep_crash(&home, &report());
    // rust: assert!(outbox::pending(&home).is_empty());
    // rust: allow(
    // rust: &home,
    // rust: Choices {
    // rust: crashes: true,
    // rust: ..Choices::NONE
    // rust: },
    // rust: );
    // rust: keep_crash(&home, &report());
    // rust: let pending = outbox::pending(&home);
    // rust: assert_eq!(pending.len(), 1);
    // rust: assert_eq!(pending[0].1.kind(), Kind::Crash);
}

cancelled_startup_entry_does_not_time_menu_browsing :: proc() {
}
    // rust: let mut session = Session::default();
    // rust: session.world_opening();
    // rust: assert!(session.opening.is_some());
    // rust: session.cancel_world_opening();
    // rust: assert!(session.opening.is_none());
    // rust: session.frame(16.0, &[]);
    // rust: assert!(session.to_world_ms.is_none());
    // rust: session.world_opening();
    // rust: session.frame(16.0, &[]);
    // rust: assert!(session.to_world_ms.is_some());
}

a_session_is_kept_only_with_consent_and_once_long_enough :: proc() {
}
    // rust: let home = home("session");
    // rust: let mut session = Session::default();
    // rust: session.world_opening();
    // rust: (0..2000).for_each(|_| session.frame(16.6, &[]));
    // rust: session.finish(&home, Settings::default());
    // rust: assert!(outbox::pending(&home).is_empty(), "33 s, and no consent");
    // rust: allow(
    // rust: &home,
    // rust: Choices {
    // rust: performance: true,
    // rust: ..Choices::NONE
    // rust: },
    // rust: );
    // rust: (0..2000).for_each(|_| session.frame(16.6, &[]));
    // rust: session.finish(&home, Settings::default());
    // rust: assert!(outbox::pending(&home).is_empty(), "33 s is too short");
    // rust: session.world_opening();
    // rust: (0..4000).for_each(|_| session.frame(16.6, &[]));
    // rust: (0..1200).for_each(|_| session.tick(4.0));
    // rust: session.finish(
    // rust: &home,
    // rust: Settings {
    // rust: render_distance: 12,
    // rust: ..Settings::default()
    // rust: },
    // rust: );
    // rust: let pending = outbox::pending(&home);
    // rust: assert_eq!(pending.len(), 1);
    // rust: let Payload::Perf(perf) = &pending[0].1.payload else {
    // rust: panic!("a perf item");
}
    // rust: assert_eq!(perf.seconds, 66);
    // rust: assert_eq!(perf.frames.count, 4000);
    // rust: assert_eq!(perf.ticks.as_ref().unwrap().p50_ms, 4.0);
    // rust: assert_eq!(perf.settings.render_distance, 12);
    // rust: assert!(perf.to_world_ms.is_some());
    // rust: assert!(serde_json::to_vec(&pending[0].1).unwrap().len() < 1024);
}

    // Frames of 250 ms or more count under the step that took most of them; a frame with no
    // span counts under none. Faster frames leave no entry.
slow_frames_are_put_down_to_their_step :: proc() {
}
//         use crate::spans::Span;
    // rust: let span = |name, ms, depth| Span {
    // rust: name,
    // rust: ms,
    // rust: cpu_ms: ms,
    // rust: depth,
}
    // rust: let mut session = Session::default();
    // rust: (0..4000).for_each(|_| session.frame(16.6, &[span("tick", 10.0, 0)]));
    // rust: let frozen = [span("r_uploads", 280.0, 1), span("renderer", 300.0, 0)];
    // rust: session.frame(320.0, &frozen);
    // rust: session.frame(900.0, &frozen);
    // rust: session.frame(260.0, &[]);
    // rust: session.frame(249.0, &frozen);
    // rust: let perf = session.summary(Settings::default()).unwrap();
    // rust: let seen: Vec<_> = perf
    // rust: .slow_frames
    // rust: .iter()
    // rust: .map(|s| (s.span.as_str(), s.frames, s.frame_max_ms, s.span_max_ms))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: seen,
    // rust: [("renderer/r_uploads", 2, 900.0, 280.0), ("", 1, 260.0, 0.0)]
    // rust: );
}
}
