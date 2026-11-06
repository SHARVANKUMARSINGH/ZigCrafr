//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry_payload
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What an item holds. Summaries only: a session's frame times become a few percentiles and
//! [`BUCKET_EDGES_MS`] counts; benchmark reports are the documented report
//! (`docs/benchmark-report.md`) as it is.
// use serde::{Deserialize, Serialize};

/// The four kinds of data a player can allow, one switch each.
pub const Kind = enum {
    Perf,
    Crash,
    Bug,
    Benchmark,
};

    // rust: impl Kind {
pub const ALL: [Kind; 4] = [Kind::Perf, Kind::Crash, Kind::Bug, Kind::Benchmark];

pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Kind::Perf => "perf",
    // rust: Kind::Crash => "crash",
    // rust: Kind::Bug => "bug",
    // rust: Kind::Benchmark => "benchmark",
}
}

pub fn from_name(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Kind::ALL.into_iter().find(|k| k.name() == name)
}

    /// The largest an item of this kind may be, as JSON.
pub fn max_bytes(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Kind::Perf => 4 * 1024,
    // rust: Kind::Crash => 32 * 1024,
    // rust: Kind::Bug => 80 * 1024,
    // rust: Kind::Benchmark => 128 * 1024,
}
}

    /// How many items of this kind one install keeps a day; the rest are dropped.
pub fn daily_cap(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Kind::Perf => 12,
    // rust: Kind::Crash => 5,
    // rust: Kind::Bug => 5,
    // rust: Kind::Benchmark => 10,
}
}
}

/// What made the item.
pub const Source = enum {
    Launcher,
    Game,
};

pub const Item = struct {
    /// Days since 1970 (UTC): no finer time is kept.
    day: u32,
    source: Source,
    /// The Horizon release (`v0.4.2`), or the launcher's version.
    version: []const u8,
    payload: Payload,
};

pub const Payload = enum {
    Perf(Perf),
    Crash(Crash),
    Bug(Bug),
    /// A benchmark report as `docs/benchmark-report.md` defines it, with its own schema field.
    Benchmark(serde_json::Value),
};

    // rust: impl Item {
pub fn new(source: Source, version: impl Into<[]const u8>, payload: Payload) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: day: crate::today(),
    // rust: source,
    // rust: version: version.into(),
    // rust: payload,
}
}

pub fn kind(self: *Self) K {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.payload {
    // rust: Payload::Perf(_) => Kind::Perf,
    // rust: Payload::Crash(_) => Kind::Crash,
    // rust: Payload::Bug(_) => Kind::Bug,
    // rust: Payload::Benchmark(_) => Kind::Benchmark,
}
}

    /// Checks what the client and the server both refuse: an item over its kind's size, an
    /// overlong text, a benchmark report that is not an object.
pub fn validate(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let size = serde_json::to_vec(self).map_or(usize::MAX, |j| j.len());
    // rust: let kind = self.kind();
    // rust: if size > kind.max_bytes() {
    // rust: return Err(format!(
    // rust: "a {} item of {size} bytes is over its {} bytes",
    // rust: kind.name(),
    // rust: kind.max_bytes()
    // rust: ));
}
    // rust: if self.version.len() > 64 {
    // rust: return Err("the version is too long".into());
}
    // rust: match &self.payload {
    // rust: Payload::Bug(bug) if bug.text.trim().is_empty() => {
    // rust: Err("a bug report needs text".into())
}
    // rust: Payload::Bug(bug) if bug.text.chars().count() > Bug::MAX_TEXT => Err(format!(
    // rust: "a bug report is at most {} characters",
    // rust: Bug::MAX_TEXT
    // rust: )),
    // rust: Payload::Benchmark(report) if !report.is_object() => {
    // rust: Err("a benchmark report is a JSON object".into())
}
    // rust: Payload::Perf(perf)
    // rust: if perf.slow_frames.len() > SlowFrames::MAX_SPANS
    // rust: || perf
    // rust: .slow_frames
    // rust: .iter()
    // rust: .any(|s| s.span.len() > SlowFrames::MAX_NAME) =>
    // rust: {
    // rust: Err(format!(
    // rust: "at most {} slow-frame spans of {} bytes",
    // rust: SlowFrames::MAX_SPANS,
    // rust: SlowFrames::MAX_NAME
    // rust: ))
}
    // rust: _ => Ok(()),
}
}
}

/// The machine, as coarse as is useful: no serial numbers, names or exact memory. Every field
/// explains performance; `docs/telemetry.md` lists them. Empty or zero: not known.
pub const System = struct {
    /// `linux`, `macos` or `windows`.
    os: []const u8,
    /// The distribution or system version (`macOS 26.0`, `Fedora Linux 43`).
    os_version: []const u8,
    arch: []const u8,
    cpu: []const u8,
    threads: u16,
    /// Physical cores.
    cores: u16,
    /// The CPU's base and top boost clock, where the OS says.
    cpu_base_mhz: u32,
    cpu_boost_mhz: u32,
    /// Installed memory, rounded to the GiB.
    ram_gb: u16,
    gpu: []const u8,
    /// `nvidia`, `amd`, `intel`, `apple`…
    gpu_vendor: []const u8,
    /// `integrated`, `discrete`, `virtual` or `cpu`.
    gpu_kind: []const u8,
    /// The GPU's own memory, rounded to 256 MiB (0 for a GPU that shares the system's).
    vram_mb: u32,
    driver: []const u8,
    /// `Metal`, `Vulkan`, `Dx12`…
    backend: []const u8,
    /// The drive under the game folder: `nvme`, `ssd` or `hdd`.
    storage: []const u8,
    /// The screen the game's window is on.
    display: ?Display,
    /// `ac` or `battery`, when the game started.
    power: []const u8,
    /// `laptop` or `desktop`.
    form: []const u8,
};

/// A screen: its size in physical pixels, refresh rate and scale.
pub const Display = struct {
    width: u32,
    height: u32,
    refresh_hz: u32,
    scale: f32,
};

/// The settings that change performance.
pub const Settings = struct {
    render_distance: u8,
    simulation_distance: u8,
    /// 0: unlimited.
    max_fps: u16,
    vsync: bool,
    fullscreen: bool,
    /// `fast`, `fancy` or `fabulous`.
    graphics: []const u8,
};

/// One play session's performance.
pub const Perf = struct {
    system: System,
    settings: Settings,
    /// Seconds of play measured (menus and loading screens excluded).
    seconds: u32,
    frames: Summary,
    /// The integrated server's milliseconds per tick, in single player.
    ticks: ?Summary,
    /// The game's peak resident memory.
    peak_ram_mb: u32,
    /// From start to the title screen.
    to_title_ms: ?u32,
    to_core_ms: ?u32,
    to_rest_ms: ?u32,
    /// From choosing a world to playing in it, the first time this session.
    to_world_ms: ?u32,
    /// The frames of [`SLOW_FRAME_MS`] or more while playing, by what took longest in each:
    /// what froze. At most [`SlowFrames::MAX_SPANS`] entries.
    slow_frames: std.ArrayList(SlowFrames),
};

/// A frame this long or longer is a freeze worth explaining ([`Perf::slow_frames`]): the
/// edge of [`Summary::buckets`]' last bucket.
pub const SLOW_FRAME_MS: f32 = 250.0;

/// The slow frames whose longest step was one span: a named step of the render thread's frame
/// (`spans.rs` in the client: `render.upload`, `tick`, `world.stream`…), the same names in
/// every game of a release. `span` is empty when no step was timed in the frame (it waited
/// outside them).
pub const SlowFrames = struct {
    span: []const u8,
    frames: u32,
    /// The longest of these frames and the longest this span took in one of them.
    frame_max_ms: f32,
    span_max_ms: f32,
};

    // rust: impl SlowFrames {
    /// Distinct spans a session keeps; the later ones count under [`SlowFrames::OTHER`].
pub const MAX_SPANS: usize = 16;
pub const MAX_NAME: usize = 64;
pub const OTHER: *'static str = "other";

    /// Counts a slow frame of `frame_ms` whose longest span was `span` (`""`: none) for
    /// `span_ms`, in a session's list.
pub fn record(list: *mut std.ArrayList(Self), frame_ms: f32, span: []const u8, span_ms: f32) void {
}
    // rust: let span = if span.len() > Self::MAX_NAME {
    // rust: Self::OTHER
    // rust: } else {
    // rust: span
}
    // rust: let at = match list.iter().position(|s| s.span == span) {
    // rust: Some(at) => at,
    // rust: None if list.len() + 1 < Self::MAX_SPANS => {
    // rust: list.push(Self {
    // rust: span: span.to_owned(),
    // rust: ..Self::default()
    // rust: });
    // rust: list.len() - 1
}
    // rust: None => match list.iter().position(|s| s.span == Self::OTHER) {
    // rust: Some(at) => at,
    // rust: None => {
    // rust: list.push(Self {
    // rust: span: Self::OTHER.to_owned(),
    // rust: ..Self::default()
    // rust: });
    // rust: list.len() - 1
}
    // rust: },
}
    // rust: let entry = &mut list[at];
    // rust: entry.frames = entry.frames.saturating_add(1);
    // rust: entry.frame_max_ms = entry.frame_max_ms.max(frame_ms);
    // rust: entry.span_max_ms = entry.span_max_ms.max(span_ms);
}
}

/// A crash, scrubbed: the error and its stack, the thread, and the details that say what the
/// game was doing (graphics adapter, settings), never its log, world or server.
pub const Crash = struct {
    system: System,
    error: []const u8,
    /// One frame a line, `function (file:line:col)`.
    stack: []const u8,
    thread: []const u8,
    details: Vec<([]const u8,
};

/// A bug report the player wrote, with the log only if they chose to add it after reading it.
pub const Bug = struct {
    system: System,
    text: []const u8,
    log: ?[]const u8,
};

    // rust: impl Bug {
pub const MAX_TEXT: usize = 4000;
}

/// Durations at a glance: percentiles and how many fell in each of [`BUCKET_EDGES_MS`].
pub const Summary = struct {
    count: u64,
    p50_ms: f32,
    p95_ms: f32,
    p99_ms: f32,
    max_ms: f32,
    /// One count a bucket: under 4 ms, 4–6 ms, … 100–250 ms, 250 ms and more.
    buckets: std.ArrayList(u32),
};

/// The upper edges of [`Summary::buckets`] in milliseconds, around the usual refresh rates
/// (240, 165, 144, 120, 60, 30 Hz…); the last bucket has no edge.
    // rust: pub const BUCKET_EDGES_MS: [f32; 13] = [
    // rust: 4.0, 6.0, 8.0, 10.0, 12.0, 14.0, 16.7, 20.0, 25.0, 33.3, 50.0, 100.0, 250.0,
    // rust: ];

/// Records durations in tenths of a millisecond up to [`Timings::FINE_MS`] (beyond, they count
/// at the top) for percentiles finer than the buckets; 20 KB whatever the session's length.
pub const Timings = struct {
    tenths: std.ArrayList(u32),
    count: u64,
    max_ms: f32,
};

    // rust: impl Default for Timings {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::new()
}
}

    // rust: impl Timings {
pub const FINE_MS: usize = 500;

pub fn new() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: tenths: vec![0; Self::FINE_MS * 10 + 1],
    // rust: count: 0,
    // rust: max_ms: 0.0,
}
}

pub fn record(self: *Self, ms: f32) void {
}
    // rust: if !ms.is_finite() || ms < 0.0 {
    // rust: return;
}
    // rust: let bin = ((ms * 10.0) as usize).min(self.tenths.len() - 1);
    // rust: self.tenths[bin] = self.tenths[bin].saturating_add(1);
    // rust: self.count += 1;
    // rust: self.max_ms = self.max_ms.max(ms);
}

pub fn count(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.count
}

    /// The duration under which a fraction `p` of them fell, to the tenth of a millisecond.
pub fn percentile(self: *Self, p: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rank = ((self.count as f64 * p).ceil() as u64).max(1);
    // rust: let mut seen = 0u64;
    // rust: for (bin, &n) in self.tenths.iter().enumerate() {
    // rust: seen += u64::from(n);
    // rust: if seen >= rank {
    // rust: return if bin + 1 == self.tenths.len() {
    // rust: self.max_ms
    // rust: } else {
    // rust: ((bin + 1) as f32 / 10.0).min(self.max_ms)
}
}
}
    // rust: self.max_ms
}

pub fn summary(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut buckets = vec![0u32; BUCKET_EDGES_MS.len() + 1];
    // rust: for (bin, &n) in self.tenths.iter().enumerate() {
    // rust: let ms = bin as f32 / 10.0;
    // rust: let bucket = BUCKET_EDGES_MS
    // rust: .iter()
    // rust: .position(|&edge| ms < edge - 0.01)
    // rust: .unwrap_or(BUCKET_EDGES_MS.len());
    // rust: buckets[bucket] = buckets[bucket].saturating_add(n);
}
    // rust: let round = |ms: f32| (ms * 10.0).round() / 10.0;
    // rust: Summary {
    // rust: count: self.count,
    // rust: p50_ms: round(self.percentile(0.50)),
    // rust: p95_ms: round(self.percentile(0.95)),
    // rust: p99_ms: round(self.percentile(0.99)),
    // rust: max_ms: round(self.max_ms),
    // rust: buckets,
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn items_are_tagged_by_kind_and_read_back() void {
}
    // rust: let item = Item::new(
    // rust: Source::Game,
    // rust: "v0.4.2",
    // rust: Payload::Bug(Bug {
    // rust: text: "Water flickers".into(),
    // rust: ..Bug::default()
    // rust: }),
    // rust: );
    // rust: let json = serde_json::to_value(&item).unwrap();
    // rust: assert_eq!(json["kind"], "bug");
    // rust: assert_eq!(json["source"], "game");
    // rust: assert_eq!(json["data"]["text"], "Water flickers");
    // rust: assert_eq!(serde_json::from_value::<Item>(json).unwrap(), item);
}

pub fn a_benchmark_report_is_carried_as_it_is() void {
}
    // rust: let report = serde_json::json!({"schema": "horizon-benchmark-report/1", "scenes": []});
    // rust: let item = Item::new(
    // rust: Source::Launcher,
    // rust: "0.1.5",
    // rust: Payload::Benchmark(report.clone()),
    // rust: );
    // rust: let json = serde_json::to_value(&item).unwrap();
    // rust: assert_eq!(json["data"], report);
    // rust: assert!(item.validate().is_ok());
    // rust: let not_object = Item::new(Source::Launcher, "0.1.5", Payload::Benchmark(1.into()));
    // rust: assert!(not_object.validate().is_err());
}

pub fn oversized_items_are_refused() void {
}
    // rust: let bug = |text: String| {
    // rust: Item::new(
    // rust: Source::Game,
    // rust: "v1",
    // rust: Payload::Bug(Bug {
    // rust: text,
    // rust: ..Bug::default()
    // rust: }),
    // rust: )
}
    // rust: assert!(bug("x".repeat(Bug::MAX_TEXT)).validate().is_ok());
    // rust: assert!(bug("x".repeat(Bug::MAX_TEXT + 1)).validate().is_err());
    // rust: assert!(bug("  ".into()).validate().is_err());
    // rust: let huge = Item::new(
    // rust: Source::Game,
    // rust: "v1",
    // rust: Payload::Crash(Crash {
    // rust: stack: "frame\n".repeat(10_000),
    // rust: ..Crash::default()
    // rust: }),
    // rust: );
    // rust: assert!(huge.validate().unwrap_err().contains("over its"));
}

pub fn timings_give_percentiles_and_buckets() void {
}
    // rust: let mut t = Timings::new();
        // 90 frames at 16.6 ms (60 Hz), 9 at 30 ms, one 400 ms hitch.
    // rust: (0..90).for_each(|_| t.record(16.6));
    // rust: (0..9).for_each(|_| t.record(30.0));
    // rust: t.record(400.0);
    // rust: t.record(f32::NAN);
    // rust: let s = t.summary();
    // rust: assert_eq!(s.count, 100);
    // rust: assert_eq!(s.p50_ms, 16.7);
    // rust: assert_eq!(s.p95_ms, 30.1);
    // rust: assert_eq!(s.p99_ms, 30.1);
    // rust: assert_eq!(s.max_ms, 400.0);
    // rust: assert_eq!(s.buckets.len(), 14);
    // rust: assert_eq!(s.buckets[6], 90, "14–16.7 ms");
    // rust: assert_eq!(s.buckets[9], 9, "25–33.3 ms");
    // rust: assert_eq!(s.buckets[13], 1, "250 ms and more");
    // rust: assert_eq!(s.buckets.iter().sum::<u32>(), 100);
}

pub fn hitches_beyond_the_fine_range_keep_their_maximum() void {
}
    // rust: let mut t = Timings::new();
    // rust: t.record(2_000.0);
    // rust: let s = t.summary();
    // rust: assert_eq!((s.p50_ms, s.max_ms), (2_000.0, 2_000.0));
    // rust: assert_eq!(s.buckets[13], 1);
}

pub fn a_session_summary_is_small() void {
}
    // rust: let mut t = Timings::new();
    // rust: (0..200_000).for_each(|i| t.record(5.0 + (i % 300) as f32 / 10.0));
    // rust: let perf = Item::new(
    // rust: Source::Game,
    // rust: "v0.4.2",
    // rust: Payload::Perf(Perf {
    // rust: frames: t.summary(),
    // rust: ticks: Some(t.summary()),
    // rust: ..Perf::default()
    // rust: }),
    // rust: );
    // rust: let size = serde_json::to_vec(&perf).unwrap().len();
    // rust: assert!(size < 1024, "{size} bytes");
    // rust: assert!(perf.validate().is_ok());
}

    /// Slow frames count under their longest span; past the cap, new spans share one entry,
    /// so a session full of different freezes still fits its item.
pub fn slow_frames_are_counted_by_span_within_a_cap() void {
}
    // rust: let mut list = Vec::new();
    // rust: SlowFrames::record(&mut list, 300.0, "render.upload", 200.0);
    // rust: SlowFrames::record(&mut list, 900.0, "render.upload", 120.0);
    // rust: SlowFrames::record(&mut list, 260.0, "", 0.0);
    // rust: assert_eq!(
    // rust: list[0],
    // rust: SlowFrames {
    // rust: span: "render.upload".into(),
    // rust: frames: 2,
    // rust: frame_max_ms: 900.0,
    // rust: span_max_ms: 200.0,
}
    // rust: );
    // rust: assert_eq!((list[1].span.as_str(), list[1].frames), ("", 1));
    // rust: for i in 0..40 {
    // rust: SlowFrames::record(&mut list, 400.0, &format!("step.{i}"), 300.0);
}
    // rust: SlowFrames::record(&mut list, 400.0, &"x".repeat(200), 300.0);
    // rust: assert_eq!(list.len(), SlowFrames::MAX_SPANS);
    // rust: let other = list.iter().find(|s| s.span == SlowFrames::OTHER).unwrap();
        // 40 spans, 13 of which found room after the first two.
    // rust: assert_eq!(other.frames, 40 - 13 + 1);
    // rust: let perf = Item::new(
    // rust: Source::Game,
    // rust: "v0.4.2",
    // rust: Payload::Perf(Perf {
    // rust: slow_frames: list.clone(),
    // rust: ..Perf::default()
    // rust: }),
    // rust: );
    // rust: assert!(perf.validate().is_ok());
    // rust: let too_many = Item::new(
    // rust: Source::Game,
    // rust: "v0.4.2",
    // rust: Payload::Perf(Perf {
    // rust: slow_frames: [list.clone(), list].concat(),
    // rust: ..Perf::default()
    // rust: }),
    // rust: );
    // rust: assert!(too_many.validate().is_err());
}
}
