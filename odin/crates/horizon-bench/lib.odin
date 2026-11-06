//! Transpiled from Horizon Rust crate
package horizon_bench_lib

import "core:fmt"
import "core:mem"
import "core:math"

// The benchmark report format, version 1 (docs/benchmark-report.md).
//
// One JSON file per run, the same for the game, the launcher and `tools/perf_bench.py`: the local log
// a player can attach, and, with consent, what the telemetry upload sends ([`Report::for_upload`]).
// It holds summaries and fixed-edge histogram counts, never raw frame streams.

// use std::collections::BTreeMap;
// use std::io;
// use std::path::{Path, PathBuf};
// use std::time::{SystemTime, UNIX_EPOCH};

// use serde::{Deserialize, Serialize};

    // rust: mod hardware;

    // rust: pub use hardware::{cpu_seconds, load_average, power_source, rss_bytes, Display, Gpu, Hardware};

FORMAT :: "horizon-benchmark-report"
VERSION :: 1

// Lower edges of the frame-time histogram buckets, in milliseconds; the last bucket is 1000 ms and
// over. Fixed by the format version so histograms from any number of reports add up.
    // rust: pub const HISTOGRAM_EDGES_MS: [f64; 24] = [
    // rust: 0.0, 1.0, 2.0, 3.0, 4.17, 5.0, 6.0, 7.0, 8.33, 10.0, 12.0, 14.0, 16.67, 20.0, 25.0, 33.33,
    // rust: 40.0, 50.0, 66.67, 100.0, 150.0, 250.0, 500.0, 1000.0,
    // rust: ];

Kind :: enum {
    Game,
    Launcher,
}

App :: struct {
    name: string,
    version: string,
    commit: Maybe(string),
    mods: [dynamic]Mod,
}

Mod :: struct {
    name: string,
    version: string,
}

// What has to match for two reports to be compared. Every field is optional.
Conditions :: struct {
    scenario: Maybe(string),
    seed: Maybe(string),
    render_distance: Maybe(u32),
    simulation_distance: Maybe(u32),
    window: Option<[u32,
    vsync: Maybe(bool),
    // Absent: unlimited.
    fps_cap: Maybe(u32),
    offscreen: Maybe(bool),
    repeats: Maybe(u32),
    warmup_s: Maybe(f64),
    power: Maybe(string),
    load_avg_1m: Maybe(f64),
    backend: Maybe(string),
}

// A measurement over a run's repeats.
Summary :: struct {
    n: uint,
    mean: f64,
    // Sample standard deviation; `None` for a single value.
    stdev: Maybe(f64),
    min: f64,
    max: f64,
    // Half-width of the 95% confidence interval of the mean (Student's t); `None` for a single value.
    ci95: Maybe(f64),
}

    // rust: impl Summary {
    // `None` for no values.
of :: proc(values: ^[f64]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let n = values.len();
    // rust: if n == 0 {
    // rust: return None;
}
    // rust: let mean = values.iter().sum::<f64>() / n as f64;
    // rust: let (stdev, ci95) = if n > 1 {
    // rust: let var = values.iter().map(|v| (v - mean).powi(2)).sum::<f64>() / (n - 1) as f64;
    // rust: let sd = var.sqrt();
    // rust: (Some(sd), Some(t95(n - 1) * sd / (n as f64).sqrt()))
    // rust: } else {
    // rust: (None, None)
}
    // rust: Some(Summary {
    // rust: n,
    // rust: mean: round(mean),
    // rust: stdev: stdev.map(round),
    // rust: min: round(values.iter().copied().fold(f64::INFINITY, f64::min)),
    // rust: max: round(values.iter().copied().fold(f64::NEG_INFINITY, f64::max)),
    // rust: ci95: ci95.map(round),
    // rust: })
}
}

// Two-sided 95% critical value of Student's t for `df` degrees of freedom.
t95 :: proc(df: uint) -> f {
    // Ported from Horizon
    return {}
}
    // rust: const TABLE: [f64; 30] = [
    // rust: 12.706, 4.303, 3.182, 2.776, 2.571, 2.447, 2.365, 2.306, 2.262, 2.228, 2.201, 2.179, 2.160,
    // rust: 2.145, 2.131, 2.120, 2.110, 2.101, 2.093, 2.086, 2.080, 2.074, 2.069, 2.064, 2.060, 2.056,
    // rust: 2.052, 2.048, 2.045, 2.042,
    // rust: ];
    // rust: TABLE.get(df.wrapping_sub(1)).copied().unwrap_or(1.96)
}

// One measured phase of one repeat.
Frames :: struct {
    phase: string,
    repeat: u32,
    frames: uint,
    seconds: f64,
    avg_fps: f64,
    low_1pct_fps: f64,
    low_01pct_fps: f64,
    p50_ms: f64,
    p95_ms: f64,
    p99_ms: f64,
    p999_ms: f64,
    max_ms: f64,
    cpu_p50_ms: Maybe(f64),
    gpu_p50_ms: Maybe(f64),
    // Frame counts per bucket of [`HISTOGRAM_EDGES_MS`].
    histogram: [dynamic]u64,
}

    // rust: impl Frames {
    // The figures of a phase from its frame times in milliseconds (time between the starts of
    // consecutive frames); `None` for no frames. CPU and GPU times are per frame too, when measured.
    // rust: pub fn of(
    // rust: phase: &str,
    // rust: repeat: u32,
    // rust: frame_ms: &[f32],
    // rust: cpu_ms: &[f32],
    // rust: gpu_ms: &[f32],
    // rust: ) -> Option<Frames> {
    // rust: let times = sorted(frame_ms);
    // rust: let n = times.len();
    // rust: if n == 0 {
    // rust: return None;
}
    // rust: let total: f64 = times.iter().sum();
        // The average frame time of the slowest `share` of frames, as frames per second.
    // rust: let low = |share: f64| {
    // rust: let slowest = &times[n - ((n as f64 * share).ceil() as usize).max(1)..];
    // rust: 1000.0 * slowest.len() as f64 / slowest.iter().sum::<f64>()
}
    // rust: let mut histogram = vec![0; HISTOGRAM_EDGES_MS.len()];
    // rust: for &t in &times {
    // rust: histogram[HISTOGRAM_EDGES_MS.partition_point(|&edge| edge <= t).max(1) - 1] += 1;
}
    // rust: Some(Frames {
    // rust: phase: phase.to_owned(),
    // rust: repeat,
    // rust: frames: n,
    // rust: seconds: round(total / 1000.0),
    // rust: avg_fps: round(n as f64 * 1000.0 / total),
    // rust: low_1pct_fps: round(low(0.01)),
    // rust: low_01pct_fps: round(low(0.001)),
    // rust: p50_ms: round(percentile(&times, 0.5)),
    // rust: p95_ms: round(percentile(&times, 0.95)),
    // rust: p99_ms: round(percentile(&times, 0.99)),
    // rust: p999_ms: round(percentile(&times, 0.999)),
    // rust: max_ms: round(times[n - 1]),
    // rust: cpu_p50_ms: (!cpu_ms.is_empty()).then(|| round(percentile(&sorted(cpu_ms), 0.5))),
    // rust: gpu_p50_ms: (!gpu_ms.is_empty()).then(|| round(percentile(&sorted(gpu_ms), 0.5))),
    // rust: histogram,
    // rust: })
}
}

sorted :: proc(ms: ^[f32]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut v: Vec<f64> = ms
    // rust: .iter()
    // rust: .map(|&m| f64::from(m))
    // rust: .filter(|m| m.is_finite())
    // rust: .collect();
    // rust: v.sort_by(f64::total_cmp);
    // rust: v
}

// Three decimals: plenty for milliseconds and FPS, short in JSON, and parsed back exactly.
round :: proc(v: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (v * 1000.0).round() / 1000.0
}

// Nearest-rank percentile of sorted, non-empty values.
percentile :: proc(sorted: ^[f64], p: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let n = sorted.len();
    // rust: sorted[((n as f64 * p).ceil() as usize).clamp(1, n) - 1]
}

Report :: struct {
    format: string,
    version: u32,
    kind: Kind,
    // When the run ended, UTC, `YYYY-MM-DDTHH:MM:SSZ`.
    created: string,
    app: App,
    hardware: Hardware,
    conditions: Conditions,
    // Scalar measurements by name; the unit is the name's suffix (`_ms`, `_mb`...).
    metrics: BTreeMap<string,
    frames: [dynamic]Frames,
    // Local only: a name the person running it chose.
    label: Maybe(string),
    // Local only: logs the run wrote next to the report.
    local: [dynamic]PathBuf,
}

    // rust: impl Report {
    // An empty report for this machine, created now.
new :: proc(kind: Kind, app: App) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::with_hardware(kind, app, Hardware::detect())
}

    // Starts a report using supplied hardware, without running system probes.
    // Interactive apps can collect the remaining machine details after their first frame.
with_hardware :: proc(kind: Kind, app: App, hardware: Hardware) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Report {
    // rust: format: FORMAT.to_owned(),
    // rust: version: VERSION,
    // rust: kind,
    // rust: created: utc_now(),
    // rust: app,
    // rust: hardware,
    // rust: conditions: Conditions::default(),
    // rust: metrics: BTreeMap::new(),
    // rust: frames: Vec::new(),
    // rust: label: None,
    // rust: local: Vec::new(),
}
}

    // Records a measurement over the repeats; no values records nothing.
metric :: proc(self: ^Self, name: string, values: ^[f64]) {
}
    // rust: if let Some(summary) = Summary::of(values) {
    // rust: self.metrics.insert(name.to_owned(), summary);
}
}

    // Reads a report, rejecting other formats and newer versions.
parse :: proc(json: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let report: Report = serde_json::from_str(json).map_err(|e| e.to_string())?;
    // rust: if report.format != FORMAT {
    // rust: return Err(format!(
    // rust: "not a benchmark report: format {:?}",
    // rust: report.format
    // rust: ));
}
    // rust: if report.version > VERSION {
    // rust: return Err(format!(
    // rust: "report version {} is newer than {VERSION}",
    // rust: report.version
    // rust: ));
}
    // rust: Ok(report)
}

    // The report without its local-only fields, dated to the day: what an upload sends.
for_upload :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let day = self.created.get(..10).unwrap_or_default();
    // rust: Report {
    // rust: label: None,
    // rust: local: Vec::new(),
    // rust: created: format!("{day}T00:00:00Z"),
    // rust: ..self.clone()
}
}

to_json :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: serde_json::to_string_pretty(self).expect("a report always serializes")
}

    // Writes `<dir>/<kind>-<created>-<scenario>.json` and returns its path.
write_to :: proc(self: ^Self, dir: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: std::fs::create_dir_all(dir)?;
    // rust: let kind = match self.kind {
    // rust: Kind::Game => "game",
    // rust: Kind::Launcher => "launcher",
}
    // rust: let stamp: String = self.created.chars().filter(char::is_ascii_digit).collect();
    // rust: let scenario: String = self
    // rust: .conditions
    // rust: .scenario
    // rust: .as_deref()
    // rust: .unwrap_or("run")
    // rust: .chars()
    // rust: .map(|c| {
    // rust: if c.is_ascii_alphanumeric() || c == '-' {
    // rust: c
    // rust: } else {
    // rust: '_'
}
    // rust: })
    // rust: .collect();
    // rust: let path = dir.join(format!("{kind}-{stamp}-{scenario}.json"));
    // rust: std::fs::write(&path, self.to_json() + "\n")?;
    // rust: Ok(path)
}
}

// The current time, UTC, `YYYY-MM-DDTHH:MM:SSZ`.
utc_now :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let secs = SystemTime::now()
    // rust: .duration_since(UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs());
    // rust: utc(secs)
}

utc :: proc(secs: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (days, rem) = (secs / 86_400, secs % 86_400);
    // Civil date from days since 1970-01-01 (Howard Hinnant's algorithm).
    // rust: let z = days as i64 + 719_468;
    // rust: let era = z.div_euclid(146_097);
    // rust: let doe = z - era * 146_097;
    // rust: let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365;
    // rust: let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    // rust: let mp = (5 * doy + 2) / 153;
    // rust: let day = doy - (153 * mp + 2) / 5 + 1;
    // rust: let month = if mp < 10 { mp + 3 } else { mp - 9 };
    // rust: let year = yoe + era * 400 + i64::from(month <= 2);
    // rust: format!(
    // rust: "{year:04}-{month:02}-{day:02}T{:02}:{:02}:{:02}Z",
    // rust: rem / 3600,
    // rust: rem / 60 % 60,
    // rust: rem % 60
    // rust: )
}

    // rust: mod tests {
//     use super::*;

utc_dates :: proc() {
}
    // rust: assert_eq!(utc(0), "1970-01-01T00:00:00Z");
    // rust: assert_eq!(utc(951_782_400), "2000-02-29T00:00:00Z");
    // rust: assert_eq!(utc(1_791_983_007), "2026-10-14T13:03:27Z");
}

summary_of_repeats :: proc() {
}
    // rust: assert_eq!(Summary::of(&[]), None);
    // rust: let one = Summary::of(&[5.0]).unwrap();
    // rust: assert_eq!((one.n, one.mean, one.stdev, one.ci95), (1, 5.0, None, None));
    // rust: let s = Summary::of(&[2.0, 4.0, 6.0]).unwrap();
    // rust: assert_eq!((s.mean, s.min, s.max), (4.0, 2.0, 6.0));
    // rust: assert_eq!(s.stdev, Some(2.0));
    // rust: assert_eq!(s.ci95, Some(4.969), "4.303 * 2 / sqrt(3)");
}

frame_figures_and_histogram :: proc() {
}
        // 998 frames of 2 ms, one of 20 ms, one of 1500 ms.
    // rust: let mut ms = vec![2.0f32; 998];
    // rust: ms.extend([20.0, 1500.0]);
    // rust: let f = Frames::of("flight", 0, &ms, &[], &[]).unwrap();
    // rust: assert_eq!(f.frames, 1000);
    // rust: assert_eq!(f.seconds, 3.516);
    // rust: assert_eq!((f.p50_ms, f.p999_ms, f.max_ms), (2.0, 20.0, 1500.0));
        // Slowest 1% = 10 frames: 8 of 2 ms, 20 ms, 1500 ms.
    // rust: assert_eq!(f.low_1pct_fps, 6.51, "1000 * 10 / 1536");
        // Slowest 0.1% = the 1500 ms frame.
    // rust: assert_eq!(f.low_01pct_fps, 0.667);
    // rust: assert_eq!(f.histogram.len(), HISTOGRAM_EDGES_MS.len());
    // rust: assert_eq!(f.histogram[2], 998, "2 ms falls in [2, 3)");
    // rust: assert_eq!(f.histogram[13], 1, "20 ms falls in [20, 25)");
    // rust: assert_eq!(f.histogram[23], 1, "1500 ms falls in [1000, inf)");
    // rust: assert_eq!(f.histogram.iter().sum::<u64>(), 1000);
    // rust: assert_eq!((f.cpu_p50_ms, f.gpu_p50_ms), (None, None));
    // rust: assert_eq!(Frames::of("x", 0, &[], &[], &[]), None);
}

round_trip_and_upload_strips_local_fields :: proc() {
}
    // rust: let mut r = Report::new(
    // rust: Kind::Game,
    // rust: App {
    // rust: name: "horizon-client".into(),
    // rust: version: "0.1.0".into(),
    // rust: ..App::default()
    // rust: },
    // rust: );
    // rust: r.conditions.scenario = Some("flight".into());
    // rust: r.metric("startup.title_ms", &[800.0, 820.0]);
    // rust: r.frames
    // rust: .extend(Frames::of("village", 0, &[2.0, 3.0], &[1.0], &[]));
    // rust: r.label = Some("my run".into());
    // rust: r.local.push("/home/someone/logs/latest.log".into());
    // rust: let back = Report::parse(&r.to_json()).unwrap();
    // rust: assert_eq!(back, r);
    // rust: r.created = "2026-10-15T14:03:27Z".into();
    // rust: let upload = r.for_upload();
    // rust: assert_eq!(upload.created, "2026-10-15T00:00:00Z", "the day only");
    // rust: let upload = upload.to_json();
    // rust: assert!(
    // rust: !upload.contains("my run") && !upload.contains("someone"),
    // rust: "{upload}"
    // rust: );
}

rejects_other_formats_and_newer_versions :: proc() {
}
    // rust: let r = Report::new(Kind::Launcher, App::default());
    // rust: let newer = r.to_json().replace("\"version\": 1", "\"version\": 2");
    // rust: assert!(Report::parse(&newer).unwrap_err().contains("newer"));
    // rust: let other = r.to_json().replace(FORMAT, "something-else");
    // rust: assert!(Report::parse(&other).is_err());
}

writes_into_a_folder :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-bench-test-{}", std::process::id()));
    // rust: let mut r = Report::new(Kind::Launcher, App::default());
    // rust: r.created = "2026-10-15T14:03:27Z".into();
    // rust: r.conditions.scenario = Some("cold start".into());
    // rust: let path = r.write_to(&dir).unwrap();
    // rust: assert_eq!(
    // rust: path.file_name().unwrap(),
    // rust: "launcher-20261015140327-cold_start.json"
    // rust: );
    // rust: assert_eq!(
    // rust: Report::parse(&std::fs::read_to_string(&path).unwrap()).unwrap(),
    // rust: r
    // rust: );
    // rust: std::fs::remove_dir_all(dir).unwrap();
}
}
