//! Transpiled from Horizon Rust crate
package horizon_client_benchmark

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-client --benchmark SCENARIO`: the run `tools/perf_bench.py` drives from outside, driven
// from inside, so anyone can measure their machine with nothing but the game. A thread sends the
// same control commands `horizon-ctl` would, through the game's own command queue, and writes a
// report (docs/benchmark-report.md) to `benchmarks/` in the game folder.
//
// The scenes, the world (seed 1234, creative) and every step and figure match `tools/perf_bench.py`,
// so reports from the two can be compared.

// use std::path::{Path, PathBuf};
// use std::sync::mpsc::{self, Sender};
// use std::thread;
// use std::time::{Duration, Instant};

// use horizon_bench::{App, Frames, Kind, Report};
// use serde_json::Value;

// use crate::control::Request;

SEED :: 1234
// The world the benchmark creates under `saves/`, replaced on every run.
WORLD :: "horizon-benchmark"
// Written into the world so a later run only ever replaces its own world.
MARKER :: "horizon-benchmark.txt"

// A straight flight over terrain: name, start, end, pitch (`tools/graphics_bench.py`'s paths).
    // rust: type Scene = (&'static str, [f64; 3], [f64; 3], f64);
    // rust: pub const SCENES: [Scene; 4] = [
    // rust: (
    // rust: "village",
    // rust: [-960.0, 125.0, 80.0],
    // rust: [-960.0, 125.0, 272.0],
    // rust: 35.0,
    // rust: ),
    // rust: (
    // rust: "forest",
    // rust: [-1100.0, 120.0, -560.0],
    // rust: [-1100.0, 120.0, -368.0],
    // rust: 25.0,
    // rust: ),
    // rust: (
    // rust: "ocean",
    // rust: [-300.0, 85.0, -420.0],
    // rust: [-300.0, 85.0, -228.0],
    // rust: 10.0,
    // rust: ),
    // rust: (
    // rust: "mountain",
    // rust: [560.0, 260.0, 860.0],
    // rust: [752.0, 260.0, 860.0],
    // rust: 30.0,
    // rust: ),
    // rust: ];
FLIGHT_SECONDS :: 12.0
SETTLE :: Duration::from_secs(2)
LOAD_LIMIT :: Duration::from_secs(600)

// `standard` flies every scene; a scene's name flies only that one.
scenes :: proc(scenario: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match scenario {
    // rust: "standard" => Some(SCENES.to_vec()),
    // rust: name => SCENES.iter().find(|s| s.0 == name).map(|s| vec![*s]),
}
}

// What the game knows about the run before it starts.
Setup :: struct {
    scenario: string,
    started: Instant,
    app: App,
    simulation_distance: u32,
    vsync: bool,
    // `None`: unlimited.
    fps_cap: Maybe(u32),
    offscreen: bool,
    game_dir: PathBuf,
}

// Starts the driver; the game quits when it is done, and the report's path is printed.
start :: proc(requests: Sender<Request>, setup: Setup) {
}
    // rust: thread::Builder::new()
    // rust: .name("horizon-benchmark".into())
    // rust: .spawn(move || {
    // rust: let control = Control(requests);
    // rust: match run(&control, setup) {
    // rust: Ok(path) => println!("Horizon: benchmark report {}", path.display()),
    // rust: Err(e) => eprintln!("Horizon: benchmark failed: {e}"),
}
    // rust: let _ = control.call("quit");
    // rust: })
    // rust: .expect("spawn the benchmark thread");
}

Control :: struct {

    // rust: impl Control {
call :: proc(self: ^Self, line: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (reply, response) = mpsc::channel();
    // rust: self.0
    // rust: .send(Request {
    line: line.to_owned(),
    // rust: reply,
    // rust: })
    // rust: .map_err(|_| "the game has exited".to_owned())?;
        // Flights and loads reply when they finish.
    // rust: let text = response
    // rust: .recv_timeout(LOAD_LIMIT)
    // rust: .map_err(|_| format!("{line}: no reply"))?;
    // rust: let value: Value = serde_json::from_str(&text).map_err(|e| e.to_string())?;
    // rust: match value.get("error").and_then(Value::as_str) {
    // rust: Some(e) => Err(format!("{line}: {e}")),
    // rust: None => Ok(value),
}
}
status :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.call("status").unwrap_or(Value::Null)
}
}

// The wait before a scene's flight, spent timing Horizon's own render passes on the GPU:
// `gpu_pass.<scene>.<pass>_ms`, where a slow GPU spends its frame. The timing is off again for
// the flight, whose frames it would slow. False, having waited for nothing, on Metal: its passes
// overlap on the GPU, so their times add up to more than the frame.
time_passes :: proc(control: ^Control, scene: string, report: ^Report) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if report
    // rust: .hardware
    // rust: .gpu
    // rust: .as_ref()
    // rust: .is_some_and(|g| g.backend == "metal")
    // rust: {
    // rust: return Ok(false);
}
    // rust: control.call("gpu-passes on")?;
    // rust: let held = control.call(&format!("bench {}", SETTLE.as_secs_f64()));
    // rust: control.call("gpu-passes off")?;
    // rust: for (pass, ms) in held?["gpu_passes"].as_object().into_iter().flatten() {
    // rust: let pass: String = pass
    // rust: .trim()
    // rust: .chars()
    // rust: .map(|c| match c {
    // rust: 'a'..='z' | '0'..='9' => c,
    // rust: 'A'..='Z' => c.to_ascii_lowercase(),
    // rust: _ => '_',
    // rust: })
    // rust: .collect();
    // rust: if let Some(ms) = ms.as_f64() {
    // rust: report.metric(&format!("gpu_pass.{scene}.{pass}_ms"), &[ms]);
}
}
    // rust: Ok(true)
}

run :: proc(control: ^Control, setup: Setup) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let scenes =
    // rust: scenes(&setup.scenario).ok_or_else(|| format!("unknown scenario {}", setup.scenario))?;
    // rust: let mut report = Report::new(Kind::Game, setup.app.clone());
    // rust: let pid = std::process::id();
    // rust: report.conditions.load_avg_1m = horizon_bench::load_average();
    // rust: report.conditions.power = horizon_bench::power_source().map(str::to_owned);
    // rust: let rss = RssSampler::start(pid);

    // rust: let title = poll(control, LOAD_LIMIT, |s| {
    // rust: s["screen"] == "title" && !s["renderer"].is_null()
    // rust: })?;
    // rust: report.metric("startup.title_ms", &[ms(setup.started.elapsed())]);
    // rust: let renderer = &title["renderer"];
    // rust: report.hardware.gpu = Some(horizon_bench::Gpu {
    // rust: name: text(&renderer["gpu"]),
    // rust: vendor: match text(&renderer["vendor"]) {
            // Metal reports no vendor ID.
    // rust: v if v.is_empty() && text(&renderer["gpu"]).starts_with("Apple") => "apple".into(),
    // rust: v => v,
    // rust: },
    // rust: driver: text(&renderer["driver"]),
    // rust: backend: text(&renderer["backend"]).to_lowercase(),
    // rust: kind: text(&renderer["device_type"]),
    // rust: vram_mb: None,
    // rust: });
    // rust: if let Some(gpu) = report.hardware.gpu.as_mut() {
    // rust: let vendor = horizon_telemetry::system::gpu_vendor(&gpu.name, 0);
    // rust: let vendor = if gpu.vendor.is_empty() {
    // rust: vendor
    // rust: } else {
    // rust: gpu.vendor.as_str()
}
    // rust: .to_owned();
    // rust: if gpu.kind.contains("iscrete") {
    // rust: gpu.vram_mb = horizon_telemetry::system::vram_mb(&vendor);
}
}
    // rust: report.hardware.storage =
    // rust: horizon_telemetry::system::storage(&setup.game_dir).map(str::to_owned);
    // rust: report.hardware.display = serde_json::from_value(title["display"].clone()).ok();

    // rust: replace_world(&setup.game_dir)?;
    // rust: control.call(&format!("open {WORLD} {SEED} creative"))?;
    // The world opens on a worker: its folder may not exist yet when `open` replies.
    // rust: std::fs::create_dir_all(setup.game_dir.join("saves").join(WORLD)).map_err(|e| e.to_string())?;
    // rust: std::fs::write(
    // rust: setup.game_dir.join("saves").join(WORLD).join(MARKER),
    // rust: "Created by horizon-client --benchmark; replaced by the next run.\n",
    // rust: )
    // rust: .map_err(|e| e.to_string())?;
    // rust: let loaded = wait_loaded(control, |_| true)?;
    // rust: report.metric("startup.world_ms", &[ms(loaded - setup.started)]);

    // rust: let mut steady = Vec::new();
    // rust: for (name, start, end, pitch) in scenes {
    // rust: control.call("time 6000")?;
    // rust: let meshed = control.status()["meshed_sections"].as_f64().unwrap_or(0.0);
    // rust: let generated = control.status()["generated_chunks"].as_f64().unwrap_or(0.0);
    // rust: let [x, y, z] = start;
    // rust: control.call(&format!("tp {x} {y} {z}"))?;
    // rust: let teleported = Instant::now();
        // A zero-length flight holds the player at the start, flying.
    // rust: control.call(&format!("fly {x} {y} {z} {x} {y} {z} 0.1 {pitch}"))?;
    // rust: control.call(&format!("look {:.3} {pitch}", yaw(start, end)))?;
    // rust: let near = |p: &Value| {
    // rust: let p: Vec<f64> = p
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_f64)
    // rust: .collect();
    // rust: p.len() == 3 && (0..3).map(|i| (p[i] - start[i]).powi(2)).sum::<f64>() < 4.0
}
    // rust: let loaded = wait_loaded(control, near)?;
    // rust: let load = loaded - teleported;
    // rust: report.metric(&format!("chunks.{name}.load_ms"), &[ms(load)]);
    // rust: let status = control.status();
    // rust: let meshes = status["meshed_sections"].as_f64().unwrap_or(0.0) - meshed;
    // rust: let chunks = status["generated_chunks"].as_f64().unwrap_or(0.0) - generated;
    // rust: report.metric(&format!("chunks.{name}.meshed_count"), &[meshes]);
    // rust: report.metric(&format!("chunks.{name}.generated_count"), &[chunks]);
    // rust: if load.as_secs_f64() > 0.0 {
    // rust: report.metric(
    // rust: &format!("chunks.{name}.generated_per_s"),
    // rust: &[chunks / load.as_secs_f64()],
    // rust: );
}
    // rust: if !time_passes(control, name, &mut report)? {
    // rust: thread::sleep(SETTLE);
}
    // rust: let [ex, ey, ez] = end;
    // rust: let begin = Instant::now();
    // rust: let flight = control.call(&format!(
    // rust: "fly {x} {y} {z} {ex} {ey} {ez} {FLIGHT_SECONDS} {pitch} raw"
    // rust: ))?;
    // rust: steady.push((begin, Instant::now()));
    // rust: let series = |key: &str| -> Vec<f32> {
    // rust: flight[key]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_f64)
    // rust: .map(|v| v as f32)
    // rust: .collect()
}
    // rust: let frames = Frames::of(
    // rust: name,
    // rust: 0,
    // rust: &series("frame_ms"),
    // rust: &series("cpu_ms"),
    // rust: &series("gpu_ms"),
    // rust: )
    // rust: .ok_or("the flight drew no frames")?;
    // rust: report.metric(&format!("fps.{name}.avg_fps"), &[frames.avg_fps]);
    // rust: report.metric(&format!("fps.{name}.low_1pct_fps"), &[frames.low_1pct_fps]);
    // rust: report.metric(
    // rust: &format!("fps.{name}.low_01pct_fps"),
    // rust: &[frames.low_01pct_fps],
    // rust: );
    // rust: report.frames.push(frames);
}

    // rust: let status = control.status();
    // rust: let renderer = &status["renderer"];
    // On Wayland the window is on a screen only once it has been shown: ask again.
    // rust: if report.hardware.display.is_none() {
    // rust: report.hardware.display = serde_json::from_value(status["display"].clone()).ok();
}
    // rust: let c = &mut report.conditions;
    // rust: c.scenario = Some(setup.scenario.clone());
    // rust: c.seed = Some(SEED.to_string());
    // rust: c.render_distance = status["render_distance"].as_u64().map(|d| d as u32);
    // rust: c.simulation_distance = Some(setup.simulation_distance);
    // rust: c.window = serde_json::from_value(renderer["size"].clone()).ok();
    // rust: c.vsync = Some(setup.vsync);
    // rust: c.fps_cap = setup.fps_cap;
    // rust: c.offscreen = Some(setup.offscreen);
    // rust: c.repeats = Some(1);
    // rust: c.warmup_s = Some(SETTLE.as_secs_f64());
    // rust: if let Some(bytes) = renderer["gpu_allocated_bytes"].as_f64() {
    // rust: report.metric("memory.gpu_mb", &[bytes / f64::from(1 << 20)]);
}
    // rust: let samples = rss.stop();
    // rust: if let Some(peak) = samples.iter().map(|s| s.1).max() {
    // rust: report.metric("memory.rss_peak_mb", &[peak as f64 / f64::from(1 << 20)]);
}
    // rust: let mut during: Vec<u64> = samples
    // rust: .iter()
    // rust: .filter(|(t, _)| steady.iter().any(|(a, b)| a <= t && t <= b))
    // rust: .map(|s| s.1)
    // rust: .collect();
    // rust: during.sort_unstable();
    // rust: if let Some(&median) = during.get(during.len() / 2) {
    // rust: report.metric(
    // rust: "memory.rss_steady_mb",
    // rust: &[median as f64 / f64::from(1 << 20)],
    // rust: );
}
    // rust: if let Ok(meta) = std::env::current_exe().and_then(std::fs::metadata) {
    // rust: report.metric("game.binary_bytes", &[meta.len() as f64]);
}
    // rust: crate::telemetry::keep_benchmark(&crate::logging::game_home(), &report);
    // rust: report
    // rust: .write_to(&setup.game_dir.join("benchmarks"))
    // rust: .map_err(|e| e.to_string())
}

// Removes the previous run's world, never one the benchmark didn't create.
replace_world :: proc(game_dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let world = game_dir.join("saves").join(WORLD);
    // rust: if !world.exists() {
    // rust: return Ok(());
}
    // rust: if !world.join(MARKER).exists() {
    // rust: return Err(format!(
    // rust: "{} exists and was not created by the benchmark: rename it",
    // rust: world.display()
    // rust: ));
}
    // rust: std::fs::remove_dir_all(&world).map_err(|e| e.to_string())
}

    // rust: fn poll(
    // rust: control: &Control,
    // rust: limit: Duration,
    // rust: ready: impl Fn(&Value) -> bool,
    // rust: ) -> Result<Value, String> {
    // rust: let deadline = Instant::now() + limit;
    // rust: while Instant::now() < deadline {
    // rust: let status = control.status();
    // rust: if ready(&status) {
    // rust: return Ok(status);
}
    // rust: thread::sleep(Duration::from_millis(50));
}
    // rust: Err(format!("not ready after {} s", limit.as_secs()))
}

// Fewer section meshes than this in a second is the game remeshing blocks that change (random
// ticks), not loading.
QUIET_MESHES_PER_S :: 100.0

// Waits until the player is spawned where `near` says, nothing is queued, the resident and
// generated chunk counts have not changed for a second and the last sections are drawn (they wait
// for their neighbours' light, so after the counts settle); returns when the last of these
// happened (`tools/perf_bench.py`'s `wait_loaded`). With `status.streaming`, the sections are
// drawn once no stage has held work for half a second: blocks changing after the load (fluids
// settling, random ticks) only remesh in bursts. Without it, meshing has to go quiet.
//
// Right after a teleport (and at spawn) the game reports nothing queued and steady counts for over
// a second before it starts loading: the counts must change once, or stay full for 5 s, and the
// resident chunks reach [`view_chunks`], before "steady" means loaded.
wait_loaded :: proc(control: ^Control, near: impl Fn(^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let deadline = Instant::now() + LOAD_LIMIT;
    // rust: let (mut last, mut changed, mut meshing) = (None, Instant::now(), Instant::now());
    // rust: let mut previous: Option<(Instant, f64)> = None;
    // rust: let (mut first, mut moved, began) = (None, false, Instant::now());
    // rust: while Instant::now() < deadline {
    // rust: let s = control.status();
    // rust: let now = Instant::now();
    // rust: let position = &s["player"]["position"];
    // rust: if position.is_null()
    // rust: || !near(position)
    // rust: || s["pending_chunks"] != 0
    // rust: || s["screen"] == "title"
    // rust: {
    // rust: (last, changed, previous, meshing) = (None, now, None, now);
    // rust: } else {
    // rust: let counts = (s["chunks"].as_u64(), s["generated_chunks"].as_u64());
    // rust: let resident = counts.0.unwrap_or(0);
    // rust: let min_chunks = view_chunks(s["render_distance"].as_u64().unwrap_or(0));
    // rust: let first = *first.get_or_insert(counts);
    // rust: moved = moved
    // rust: || counts != first
    // rust: || (min_chunks > 0
    // rust: && resident >= min_chunks
    // rust: && now - began > Duration::from_secs(5));
    // rust: if min_chunks > 0 && (!moved || resident < min_chunks) {
    // rust: (last, changed, previous, meshing) = (None, now, None, now);
    // rust: thread::sleep(Duration::from_millis(50));
    // rust: continue;
}
    // rust: if last != Some(counts) {
    // rust: (last, changed) = (Some(counts), now);
}
    // rust: let meshed = s["meshed_sections"].as_f64().unwrap_or(0.0);
    // rust: let quiet = if let Some(stages) = s["streaming"].as_object() {
                // Protos outside the view distance wait for neighbours that are never generated.
    // rust: if stages
    // rust: .iter()
    // rust: .any(|(k, v)| k != "protos" && v.as_u64().unwrap_or(0) > 0)
    // rust: {
    // rust: meshing = now;
}
    // rust: Duration::from_millis(500)
    // rust: } else {
    // rust: if let Some((at, before)) = previous
    // rust: && meshed - before > QUIET_MESHES_PER_S * (now - at).as_secs_f64()
    // rust: {
    // rust: meshing = now;
}
    // rust: Duration::from_secs(1)
}
    // rust: previous = Some((now, meshed));
    // rust: if now - changed >= Duration::from_secs(1) && now - meshing >= quiet {
    // rust: return Ok(changed.max(meshing));
}
}
    // rust: thread::sleep(Duration::from_millis(50));
}
    // rust: Err(format!("not loaded after {} s", LOAD_LIMIT.as_secs()))
}

// 80% of the view circle (pi x RD^2): the game keeps 637 columns at RD 12 and 3725 at RD 32
// (`tools/perf_bench.py`'s `view_chunks`).
view_chunks :: proc(distance: u64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (0.8 * std::f64::consts::PI * (distance * distance) as f64) as u64
}

// Vanilla's yaw facing from `start` to `end`.
yaw :: proc(start: [f64; 3], end: [f64; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (-(end[0] - start[0])).atan2(end[2] - start[2]).to_degrees()
}

ms :: proc(d: Duration) -> f {
    // Ported from Horizon
    return {}
}
    // rust: d.as_secs_f64() * 1000.0
}

text :: proc(v: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: v.as_str().unwrap_or_default().to_owned()
}

// Samples the process's resident memory four times a second, as `tools/perf_bench.py` does.
RssSampler :: struct {
    stop: Sender<()>,
    thread: thread::JoinHandle<Vec<(Instant,
}

    // rust: impl RssSampler {
start :: proc(pid: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (stop, stopped) = mpsc::channel();
    // rust: let thread = thread::spawn(move || {
    // rust: let mut samples = Vec::new();
    // rust: while let Err(mpsc::RecvTimeoutError::Timeout) =
    // rust: stopped.recv_timeout(Duration::from_millis(250))
    // rust: {
    // rust: samples.extend(horizon_bench::rss_bytes(pid).map(|b| (Instant::now(), b)));
}
    // rust: samples
    // rust: });
    // rust: Self { stop, thread }
}
stop :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let _ = self.stop.send(());
    // rust: self.thread.join().unwrap_or_default()
}
}

    // rust: mod tests {
//     use super::*;

scenarios :: proc() {
}
    // rust: assert_eq!(scenes("standard").unwrap().len(), 4);
    // rust: assert_eq!(scenes("ocean").unwrap()[0].0, "ocean");
    // rust: assert!(scenes("nether").is_none());
}

view_chunks_matches_perf_bench :: proc() {
}
    // rust: assert_eq!(view_chunks(12), 361);
    // rust: assert_eq!(view_chunks(32), 2573);
    // rust: assert_eq!(view_chunks(0), 0);
}
    // The status a fake control answers with: the player is where it should
    // be, nothing is queued, and the world holds `chunks` resident chunks.
status :: proc(chunks: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: serde_json::json!({
    // rust: "player": {"position": [0.0, 64.0, 0.0]},
    // rust: "pending_chunks": 0,
    // rust: "screen": "playing",
    // rust: "render_distance": 12,
    // rust: "chunks": chunks,
    // rust: "generated_chunks": chunks,
    // rust: "meshed_sections": 0,
    // rust: "streaming": {},
    // rust: })
    // rust: .to_string()
}

the_load_waits_for_the_chunks_a_teleport_starts :: proc() {
}
        // Right after a teleport the game reports steady counts and nothing
        // queued for over a second, before the integrated server has sent the
        // first chunk: the quiet rule alone would call that loaded, and the
        // scene would be measured over an empty view (#1749).
LATE :: 30
    // rust: let (tx, rx) = mpsc::channel::<Request>();
    // rust: let polls = std::sync::Arc::new(std::sync::atomic::AtomicUsize::new(0));
    // rust: let counted = std::sync::Arc::clone(&polls);
    // rust: let server = thread::spawn(move || {
    // rust: let mut seen = 0;
    // rust: while let Ok(request) = rx.recv() {
    // rust: if request.line == "status" {
    // rust: let chunks = if seen < LATE { 0 } else { 400 };
    // rust: seen += 1;
    // rust: counted.store(seen, std::sync::atomic::Ordering::SeqCst);
    // rust: let _ = request.reply.send(status(chunks));
    // rust: } else {
    // rust: let _ = request.reply.send("{}".to_owned());
}
}
    // rust: });
    // rust: let control = Control(tx);
    // rust: wait_loaded(&control, |_| true).expect("the scene loads");
    // rust: assert!(
    // rust: polls.load(std::sync::atomic::Ordering::SeqCst) > LATE,
    // rust: "the load finished before the chunks arrived"
    // rust: );
    // rust: drop(control);
    // rust: let _ = server.join();
}

    // The wait before a flight times the passes and turns the timing off again before the
    // flight; the report gets one metric per pass. Not on Metal.
the_wait_times_the_passes_but_not_the_flight :: proc() {
}
    // rust: let time_on = |backend: &str| {
    // rust: let (tx, rx) = mpsc::channel::<Request>();
    // rust: let server = thread::spawn(move || {
    // rust: let mut lines = Vec::new();
    // rust: while let Ok(request) = rx.recv() {
    // rust: let reply = if request.line.starts_with("bench ") {
    // rust: serde_json::json!({
    // rust: "frames": 120,
    // rust: "gpu_passes": {"World": 1.5, "World after culling": 0.25, "HUD": 0.01},
    // rust: })
    // rust: } else {
    // rust: serde_json::json!({ "ok": true })
}
    // rust: let _ = request.reply.send(reply.to_string());
    // rust: lines.push(request.line);
}
    // rust: lines
    // rust: });
    // rust: let hardware = horizon_bench::Hardware {
    // rust: gpu: Some(horizon_bench::Gpu {
    // rust: backend: backend.into(),
    // rust: ..Default::default()
    // rust: }),
    // rust: ..Default::default()
}
    // rust: let mut report = Report::with_hardware(Kind::Game, App::default(), hardware);
    // rust: let control = Control(tx);
    // rust: let timed = time_passes(&control, "forest", &mut report).expect("the wait runs");
    // rust: drop(control);
    // rust: (timed, server.join().unwrap(), report.metrics)
}

    // rust: let (timed, lines, metrics) = time_on("vulkan");
    // rust: assert!(timed);
    // rust: assert_eq!(lines, ["gpu-passes on", "bench 2", "gpu-passes off"]);
    // rust: let mean = |name: &str| metrics.get(name).map(|s| s.mean);
    // rust: assert_eq!(mean("gpu_pass.forest.world_ms"), Some(1.5));
    // rust: assert_eq!(mean("gpu_pass.forest.world_after_culling_ms"), Some(0.25));
    // rust: assert_eq!(mean("gpu_pass.forest.hud_ms"), Some(0.01));
    // rust: assert_eq!(metrics.len(), 3);

    // rust: let (timed, lines, metrics) = time_on("metal");
    // rust: assert!(!timed);
    // rust: assert!(
    // rust: lines.is_empty(),
    // rust: "Metal's overlapping passes are not timed: {lines:?}"
    // rust: );
    // rust: assert!(metrics.is_empty());
}

yaw_matches_vanilla :: proc() {
}
        // South (+Z) is 0, west (-X) 90, east (+X) -90.
    // rust: assert!((yaw([0.0; 3], [0.0, 0.0, 10.0])).abs() < 1e-9);
    // rust: assert!((yaw([0.0; 3], [-10.0, 0.0, 0.0]) - 90.0).abs() < 1e-9);
    // rust: assert!((yaw([0.0; 3], [10.0, 0.0, 0.0]) + 90.0).abs() < 1e-9);
}

only_replaces_its_own_world :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-benchmark-test-{}", std::process::id()));
    // rust: let world = dir.join("saves").join(WORLD);
    // rust: std::fs::create_dir_all(&world).unwrap();
    // rust: assert!(
    // rust: replace_world(&dir).is_err(),
    // rust: "a player's world of that name stays"
    // rust: );
    // rust: assert!(world.exists());
    // rust: std::fs::write(world.join(MARKER), "").unwrap();
    // rust: replace_world(&dir).unwrap();
    // rust: assert!(!world.exists());
    // rust: replace_world(&dir).unwrap();
    // rust: std::fs::remove_dir_all(dir).unwrap();
}
}
