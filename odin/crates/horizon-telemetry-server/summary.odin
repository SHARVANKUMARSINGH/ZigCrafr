//! Transpiled from Horizon Rust crate
package horizon_telemetry_server_summary

import "core:fmt"
import "core:mem"
import "core:math"

// `GET /v1/benchmarks/summary`: players' benchmark uploads, grouped for the website's Benchmarks page.
//
// The same rules as the website's `scripts/benchmarks.mjs` (horizon-rust/horizon-site; it builds the page's baked
// copy), checked against the same fixtures (`tests/fixtures/benchmarks/`, which the site's test keeps a copy of):
//
// - Only reports that compare: `horizon-benchmark-report` version 1, kind `game`, Horizon or plain vanilla, the
//   standard flight over the four scenes, VSync off, no frame cap, drawn on a screen, with a GPU and CPU name.
// - Groups by GPU, CPU, render distance and game. A group is published only with at least `min_installs`
//   different installs, so no one can be picked out.
// - Each install counts once: the median of its runs first, then the median across installs.
// - Out go the group's names, its counts, the newest three versions and the medians. Never the install ID, the
//   day, the OS version, the driver, the memory size or the screen.
// use std::collections::{BTreeMap, BTreeSet, HashMap};

// use serde_json::{Value, json};

FORMAT :: "horizon-benchmark-summary"
MIN_INSTALLS :: 3
SCENES :: ["village", "forest", "ocean", "mountain"]
    // rust: pub const FIELDS: [&str; 7] = [
    // rust: "avg_fps",
    // rust: "low_1pct_fps",
    // rust: "p95_ms",
    // rust: "world_ms",
    // rust: "chunk_load_ms",
    // rust: "rss_peak_mb",
    // rust: "rss_steady_mb",
    // rust: ];

// One stored upload: who sent it (only to count installs), the release, and the report.
Upload :: struct {
    install: [dynamic]u8,
    version: string,
    report: Value,
}

// "Intel(R) Core(TM) i7" -> "Intel Core i7", spaces collapsed.
trim :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: s.replace("(R)", "")
    // rust: .replace("(TM)", "")
    // rust: .replace("(tm)", "")
    // rust: .split_whitespace()
    // rust: .collect::<Vec<_>>()
    // rust: .join(" ")
}

game :: proc(app: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match app.get("name").and_then(Value::as_str) {
    // rust: Some("horizon-client") => Some("horizon"),
    // rust: Some("minecraft") => {
    // rust: let mods = app.get("mods").and_then(Value::as_array);
    // rust: let plain = mods.is_none_or(|m| {
    // rust: m.iter()
    // rust: .all(|m| m.get("name").and_then(Value::as_str) == Some("fabric-loader"))
    // rust: });
    // rust: plain.then_some("vanilla")
}
    // rust: _ => None,
}
}

// Why a report can't be compared with the others, or `None` when it can.
rejection :: proc(report: ^Value) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if report.get("format").and_then(Value::as_str) != Some("horizon-benchmark-report")
    // rust: || report.get("version").and_then(Value::as_u64) != Some(1)
    // rust: {
    // rust: return Some("not a version 1 benchmark report");
}
    // rust: if report.get("kind").and_then(Value::as_str) != Some("game") {
    // rust: return Some("not a game run");
}
    // rust: if game(&report["app"]).is_none() {
    // rust: return Some("not Horizon or plain vanilla");
}
    // rust: let c = &report["conditions"];
    // rust: let scenario = c.get("scenario").and_then(Value::as_str).unwrap_or("");
    // rust: if !(scenario == "standard" || scenario == "flight" || scenario.starts_with("perf_bench:")) {
    // rust: return Some("not the standard flight");
}
    // rust: if c.get("vsync") != Some(&Value::Bool(false)) {
    // rust: return Some("VSync on or unknown");
}
    // rust: if c.get("fps_cap").is_some_and(|v| !v.is_null()) {
    // rust: return Some("frame rate capped");
}
    // rust: if c.get("offscreen") == Some(&Value::Bool(true)) {
    // rust: return Some("offscreen");
}
    // rust: if !c.get("render_distance").is_some_and(Value::is_number) {
    // rust: return Some("no render distance");
}
    // rust: let phases: BTreeSet<&str> = report["frames"]
    // rust: .as_array()
    // rust: .map(|f| f.iter().filter_map(|f| f["phase"].as_str()).collect())
    // rust: .unwrap_or_default();
    // rust: if !SCENES.iter().all(|s| phases.contains(s)) {
    // rust: return Some("not every scene");
}
    // rust: let named = |v: &Value| v.as_str().is_some_and(|s| !trim(s).is_empty());
    // rust: if !named(&report["hardware"]["gpu"]["name"]) || !named(&report["hardware"]["cpu"]) {
    // rust: return Some("no GPU or CPU name");
}
    // rust: None
}

mean :: proc(xs: ^[f64]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (!xs.is_empty()).then(|| xs.iter().sum::<f64>() / xs.len() as f64)
}

median :: proc(xs: ^[f64]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut v: Vec<f64> = xs.iter().copied().filter(|x| x.is_finite()).collect();
    // rust: if v.is_empty() {
    // rust: return None;
}
    // rust: v.sort_by(f64::total_cmp);
    // rust: let m = v.len() / 2;
    // rust: Some(if v.len() % 2 == 1 {
    // rust: v[m]
    // rust: } else {
    // rust: (v[m - 1] + v[m]) / 2.0
    // rust: })
}

// fps to integers, milliseconds to a tenth under 10 and to integers above, megabytes to integers.
round :: proc(field: string, x: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if field.ends_with("_ms") && x < 10.0 {
    // rust: (x * 10.0).round() / 10.0
    // rust: } else {
    // rust: x.round()
}
}

// Whole numbers as integers (`515`, not `515.0`), as JavaScript writes them.
number :: proc(x: f64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if x.fract() == 0.0 && x.abs() < 9e15 {
    // rust: json!(x as i64)
    // rust: } else {
    // rust: json!(x)
}
}

// A report's figures: frame figures averaged over every flight, the rest from its metrics.
figures :: proc(report: ^Value) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let frames = report["frames"]
    // rust: .as_array()
    // rust: .map(Vec::as_slice)
    // rust: .unwrap_or(&[]);
    // rust: let avg = |key: &str| {
    // rust: mean(
    // rust: &frames
    // rust: .iter()
    // rust: .filter_map(|f| f[key].as_f64())
    // rust: .collect::<Vec<_>>(),
    // rust: )
}
    // rust: let metrics = report["metrics"].as_object();
    // rust: let metric = |name: &str| metrics.and_then(|m| m.get(name)?.get("mean")?.as_f64());
    // rust: let loads: Vec<f64> = metrics
    // rust: .map(|m| {
    // rust: m.iter()
    // rust: .filter(|(k, _)| {
    // rust: k.strip_prefix("chunks.")
    // rust: .and_then(|k| k.strip_suffix(".load_ms"))
    // rust: .is_some_and(|scene| !scene.contains('.'))
    // rust: })
    // rust: .filter_map(|(_, v)| v.get("mean")?.as_f64())
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default();
    // rust: [
    // rust: avg("avg_fps"),
    // rust: avg("low_1pct_fps"),
    // rust: avg("p95_ms"),
    // rust: metric("startup.world_ms"),
    // rust: mean(&loads),
    // rust: metric("memory.rss_peak_mb"),
    // rust: metric("memory.rss_steady_mb"),
    // rust: ]
}

// "v0.2.10" after "v0.2.9", dated tags by their numbers: newest first.
newest_first :: proc(a: string, b: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let n = |v: &str| -> Vec<u64> {
    // rust: v.split(|c: char| !c.is_ascii_digit())
    // rust: .filter(|p| !p.is_empty())
    // rust: .filter_map(|p| p.parse().ok())
    // rust: .collect()
}
    // rust: n(b).cmp(&n(a))
}

Group :: struct {
    installs: HashMap<[dynamic]u8,
    // Per dimension and class, the installs in it.
    classes: [BTreeMap<^'static str,
    reports: uint,
    versions: BTreeSet<string>,
}

// Players' groups of at least `min_installs` installs, as the website's `scripts/benchmarks.mjs` makes them.
groups :: proc(uploads: ^[Upload], min_installs: uint) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut by: BTreeMap<(String, String, i64, &str), Group> = BTreeMap::new();
    // rust: for u in uploads {
    // rust: if u.install.is_empty() || rejection(&u.report).is_some() {
    // rust: continue;
}
    // rust: let r = &u.report;
    // rust: let key = (
    // rust: trim(r["hardware"]["gpu"]["name"].as_str().unwrap_or_default()),
    // rust: trim(r["hardware"]["cpu"].as_str().unwrap_or_default()),
    // rust: r["conditions"]["render_distance"]
    // rust: .as_f64()
    // rust: .unwrap_or_default() as i64,
    // rust: game(&r["app"]).unwrap_or_default(),
    // rust: );
    // rust: let g = by.entry(key).or_default();
    // rust: g.reports += 1;
    // rust: if !u.version.is_empty() {
    // rust: g.versions.insert(u.version.clone());
}
    // rust: g.installs
    // rust: .entry(u.install.clone())
    // rust: .or_default()
    // rust: .push(figures(r));
    // rust: for (dim, class) in crate::classes::of_report(r).into_iter().enumerate() {
    // rust: if let Some(class) = class {
    // rust: g.classes[dim]
    // rust: .entry(class)
    // rust: .or_default()
    // rust: .insert(u.install.clone());
}
}
}
    // rust: let mut out: Vec<(usize, Value)> = by
    // rust: .into_iter()
    // rust: .filter(|(_, g)| g.installs.len() >= min_installs)
    // rust: .map(|((gpu, cpu, rd, game), g)| {
    // rust: let per_install: Vec<[Option<f64>; 7]> = g
    // rust: .installs
    // rust: .values()
    // rust: .map(|runs| {
    // rust: std::array::from_fn(|i| median(&runs.iter().filter_map(|r| r[i]).collect::<Vec<_>>()))
    // rust: })
    // rust: .collect();
    // rust: let medians: serde_json::Map<String, Value> = FIELDS
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, f)| {
    // rust: let m = median(&per_install.iter().filter_map(|r| r[i]).collect::<Vec<_>>());
    // rust: (f.to_string(), m.map_or(Value::Null, |m| number(round(f, m))))
    // rust: })
    // rust: .collect();
    // rust: let mut versions: Vec<String> = g.versions.into_iter().collect();
    // rust: versions.sort_by(|a, b| newest_first(a, b));
    // rust: versions.truncate(3);
    // rust: let installs = g.installs.len();
    // rust: let breakdowns = breakdowns(&g.classes, min_installs);
    // rust: (
    // rust: installs,
    // rust: json!({
    // rust: "gpu": gpu, "cpu": cpu, "render_distance": rd, "game": game, "source": "players",
    // rust: "installs": installs, "reports": g.reports, "versions": versions, "medians": medians,
    // rust: "breakdowns": breakdowns,
    // rust: }),
    // rust: )
    // rust: })
    // rust: .collect();
    // Most installs first, then by GPU and render distance (the map's order).
    // rust: out.sort_by_key(|g| std::cmp::Reverse(g.0));
    // rust: out.into_iter().map(|(_, v)| v).collect()
}

// Per dimension, the classes with at least `min_installs` installs, most first:
// `{"ram": [{"class": "32 GB", "installs": 3}], …}`. A dimension with none is left out.
    // rust: pub fn breakdowns(
    // rust: classes: &[BTreeMap<&'static str, BTreeSet<Vec<u8>>>; 5],
    // rust: min_installs: usize,
    // rust: ) -> Value {
    // rust: let mut out = serde_json::Map::new();
    // rust: for (dim, by_class) in crate::classes::DIMENSIONS.iter().zip(classes) {
    // rust: let mut cells: Vec<(&str, usize)> = by_class
    // rust: .iter()
    // rust: .map(|(c, set)| (*c, set.len()))
    // rust: .filter(|(_, n)| *n >= min_installs)
    // rust: .collect();
    // rust: cells.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(b.0)));
    // rust: if !cells.is_empty() {
    // rust: out.insert(
    // rust: dim.to_string(),
    // rust: cells
    // rust: .into_iter()
    // rust: .map(|(class, installs)| json!({"class": class, "installs": installs}))
    // rust: .collect(),
    // rust: );
}
}
    // rust: Value::Object(out)
}

// The whole answer; `generated` is an RFC 3339 UTC time.
summary :: proc(uploads: ^[Upload], min_installs: uint, generated: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: json!({
    // rust: "format": FORMAT, "version": 1, "generated": generated, "min_installs": min_installs,
    // rust: "groups": groups(uploads, min_installs),
    // rust: })
}
