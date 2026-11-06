//! Transpiled from Horizon Rust crate
//! Module: horizon-client_report
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-report [SECONDS]` on the dedicated server's console (and `horizon-server report`): records every
//! tick's time and spans for a window (60 s unless told; `horizon-report stop` ends it early, `horizon-report
//! status` says how far it is), then writes a performance report to share, `reports/perf-<time>.json` and a
//! short `.txt` beside it in the server's folder. It says where the ticks' time went (the spans of
//! `HORIZON_SPIKES`, each level's share), what each mob type costs (sampled, tick_profile.rs), what the chunk
//! workers spent their CPU on (load, generate, decorate, light...), the network bytes per player, and what
//! recording all this cost the tick. It shows the worst ticks with their spans, counts the entities by type and
//! the chunks of each level, and gives the memory, the CPU and the view settings. It holds no player names,
//! UUIDs or addresses, no seed and no world name. It runs beside the game: nothing restarts.
// use super::super::{Dim, Game, tick_profile};
// use horizon_client::{
    // rust: spans::{self, Span},
    // rust: streaming::job_stats,
}
// use serde_json::{Value, json};
// use std::{
    // rust: collections::BTreeMap,
    // rust: path::{Path, PathBuf},
    // rust: time::{Duration, Instant},
}

/// The longest window a report records.
    // rust: pub(super) const MAX_SECONDS: u32 = 600;
/// The worst ticks a report lists with their spans.
pub const WORST: usize = 10;
/// The mob types (per level) a report lists with their cost.
pub const MOB_TYPES: usize = 40;

pub const Tick = struct {
    wall_ms: f32,
    cpu_ms: ?f32,
    spans: std.ArrayList(Span),
};

/// A report being recorded.
    // rust: pub(super) struct Recording {
    // rust: seconds: u32,
    // rust: started: Instant,
    // rust: cpu_s: Option<f64>,
    /// Whether spans were on before (`HORIZON_SPIKES`): they stay on after.
    // rust: spans_were_on: bool,
    // rust: ticks: Vec<Tick>,
    /// The ticks whose mobs were timed one by one ([`tick_profile::SAMPLE_EVERY`]).
    // rust: sampled_ticks: u64,
    /// The spans recorded, before they are summed by name: what timing them cost.
    // rust: spans_recorded: u64,
    /// Each player's wire bytes (in, out) by connection when the recording started.
    // rust: wire_start: BTreeMap<u32, (u64, u64)>,
}

    // rust: impl Recording {
    // rust: pub(super) fn start(seconds: u32, wire: Vec<(u32, (u64, u64))>) -> Self {
    // rust: let spans_were_on = spans::enabled();
    // rust: spans::enable(true);
    // rust: job_stats::enable(true);
    // rust: job_stats::take();
    // rust: tick_profile::take();
    // rust: Self {
    // rust: seconds,
    // rust: started: Instant::now(),
    // rust: cpu_s: horizon_bench::cpu_seconds(std::process::id()),
    // rust: spans_were_on,
    // rust: ticks: Vec::with_capacity(seconds as usize * 20),
    // rust: sampled_ticks: 0,
    // rust: spans_recorded: 0,
    // rust: wire_start: wire.into_iter().collect(),
}
}
    /// Whether the next tick's mobs are timed one by one.
    // rust: pub(super) fn sample_next(&self) -> bool {
    // rust: self.ticks.len().is_multiple_of(tick_profile::SAMPLE_EVERY)
}
    // rust: pub(super) fn add(
    // rust: &mut self,
    // rust: wall_ms: f32,
    // rust: cpu_ms: Option<f32>,
    // rust: spans: Vec<Span>,
    // rust: recorded: usize,
    // rust: sampled: bool,
    // rust: ) {
    // rust: self.ticks.push(Tick {
    // rust: wall_ms,
    // rust: cpu_ms,
    // rust: spans,
    // rust: });
    // rust: self.sampled_ticks += u64::from(sampled);
    // rust: self.spans_recorded += recorded as u64;
}
    // rust: pub(super) fn done(&self) -> bool {
    // rust: self.started.elapsed() >= Duration::from_secs(u64::from(self.seconds))
}
    /// `horizon-report status`: how far the recording is.
    // rust: pub(super) fn status(&self) -> String {
    // rust: format!(
    // rust: "Recording a performance report: {} of {} s, {} ticks (horizon-report stop writes it now)",
    // rust: self.started.elapsed().as_secs(),
    // rust: self.seconds,
    // rust: self.ticks.len()
    // rust: )
}
}

pub fn pct(sorted: *[f32], q: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let i = ((sorted.len() as f64 * q) as usize).min(sorted.len().saturating_sub(1));
    // rust: sorted.get(i).map_or(0.0, |&v| f64::from(v))
}
pub fn round(v: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (v * 100.0).round() / 100.0
}

/// The tick times and spans of a recording, as the report's `ticks` and `spans`.
pub fn tick_summary(r: *Recording, window_s: f64) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut walls: Vec<f32> = r.ticks.iter().map(|t| t.wall_ms).collect();
    // rust: walls.sort_by(f32::total_cmp);
    // rust: let n = r.ticks.len().max(1) as f64;
    // rust: let mean = |f: &dyn Fn(&Tick) -> f64| r.ticks.iter().map(f).sum::<f64>() / n;
    // rust: let ticks = json!({
    // rust: "count": r.ticks.len(),
    // rust: "tps": round(r.ticks.len() as f64 / window_s.max(1e-9)),
    // rust: "mspt": {
    // rust: "average": round(mean(&|t| f64::from(t.wall_ms))),
    // rust: "p50": round(pct(&walls, 0.5)),
    // rust: "p95": round(pct(&walls, 0.95)),
    // rust: "p99": round(pct(&walls, 0.99)),
    // rust: "max": round(walls.last().copied().map_or(0.0, f64::from)),
    // rust: },
    // rust: "cpu_ms_average": round(mean(&|t| f64::from(t.cpu_ms.unwrap_or(t.wall_ms)))),
    // rust: "over_50_ms": walls.iter().filter(|&&w| w > 50.0).count(),
    // rust: "over_100_ms": walls.iter().filter(|&&w| w > 100.0).count(),
    // rust: });
    // rust: let mut totals: BTreeMap<&str, (f64, f64, usize)> = BTreeMap::new();
    // rust: for t in &r.ticks {
    // rust: for s in &t.spans {
    // rust: let e = totals.entry(s.name).or_default();
    // rust: e.0 += f64::from(s.ms);
    // rust: e.1 += f64::from(s.cpu_ms);
    // rust: e.2 += 1;
}
}
    // rust: let mut by_time: Vec<_> = totals.into_iter().collect();
    // rust: by_time.sort_by(|a, b| b.1.0.total_cmp(&a.1.0));
    // rust: let tick_ms = mean(&|t| f64::from(t.wall_ms)).max(1e-9);
    // rust: let spans = Value::Array(
    // rust: by_time
    // rust: .iter()
    // rust: .map(|(name, (ms, cpu, seen))| {
    // rust: json!({
    // rust: "name": name,
    // rust: "ms_per_tick": round(ms / n),
    // rust: "cpu_ms_per_tick": round(cpu / n),
    // rust: "share_of_tick": round(ms / n / tick_ms),
    // rust: "ticks_seen": seen,
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: );
    // rust: let mut worst: Vec<&Tick> = r.ticks.iter().collect();
    // rust: worst.sort_by(|a, b| b.wall_ms.total_cmp(&a.wall_ms));
    // rust: let worst = Value::Array(
    // rust: worst
    // rust: .into_iter()
    // rust: .take(WORST)
    // rust: .map(|t| {
    // rust: json!({
    // rust: "ms": round(f64::from(t.wall_ms)),
    // rust: "cpu_ms": t.cpu_ms.map(|c| round(f64::from(c))),
    // rust: "spans": t.spans.iter().take(8).map(|s| json!([s.name, round(f64::from(s.ms))])).collect::<Vec<_>>(),
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: );
    // rust: (ticks, spans, worst)
}

/// The sampled mob costs: per level and type, the milliseconds a tick, the mobs ticking, and the
/// microseconds one mob costs. Costliest first, the first [`MOB_TYPES`].
pub fn mob_costs(costs: *[tick_profile::MobCost], sampled_ticks: u64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let ticks = sampled_ticks.max(1) as f64;
    // rust: Value::Array(
    // rust: costs
    // rust: .iter()
    // rust: .take(MOB_TYPES)
    // rust: .map(|c| {
    // rust: json!({
    // rust: "dimension": c.dimension,
    // rust: "type": c.kind,
    // rust: "ms_per_tick": round(c.nanos as f64 / ticks / 1e6),
    // rust: "mobs_ticked": round(c.mob_ticks as f64 / ticks),
    // rust: "us_per_mob": round(c.nanos as f64 / c.mob_ticks.max(1) as f64 / 1e3),
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: )
}

/// The chunk workers' CPU time by job kind (`streaming::job_stats`): cores used, jobs, ms a job.
pub fn worker_jobs(jobs: *[(*'static str) void {
}
    // rust: Value::Array(
    // rust: jobs.iter()
    // rust: .filter(|(_, _, count)| *count > 0)
    // rust: .map(|&(kind, nanos, count)| {
    // rust: json!({
    // rust: "kind": kind,
    // rust: "jobs": count,
    // rust: "jobs_per_second": round(count as f64 / window_s.max(1e-9)),
    // rust: "cpu_cores": round(nanos as f64 / 1e9 / window_s.max(1e-9)),
    // rust: "ms_per_job": round(nanos as f64 / count as f64 / 1e6),
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: )
}

/// The players' network use over the window, from the wire bytes of the players on at both ends
/// (in KiB a second: average, P50, P95, max), and what all players on at the end sent since the
/// start (or since they joined).
pub fn network(start: *BTreeMap<u32) void {
}
    // rust: let kib_s = |bytes: u64| bytes as f64 / 1024.0 / window_s.max(1e-9);
    // rust: let mut out = Vec::new();
    // rust: let mut inn = Vec::new();
    // rust: let (mut total_out, mut total_in) = (0u64, 0u64);
    // rust: for (conn, (now_in, now_out)) in end {
    // rust: let (was_in, was_out) = start.get(conn).copied().unwrap_or((0, 0));
    // rust: let (d_in, d_out) = (
    // rust: now_in.saturating_sub(was_in),
    // rust: now_out.saturating_sub(was_out),
    // rust: );
    // rust: total_in += d_in;
    // rust: total_out += d_out;
    // rust: if start.contains_key(conn) {
    // rust: out.push(kib_s(d_out) as f32);
    // rust: inn.push(kib_s(d_in) as f32);
}
}
    // rust: let stats = |v: &mut Vec<f32>| {
    // rust: v.sort_by(f32::total_cmp);
    // rust: let avg = v.iter().fold(0.0, |sum, &x| sum + f64::from(x)) / v.len().max(1) as f64;
    // rust: json!({
    // rust: "average": round(avg),
    // rust: "p50": round(pct(v, 0.5)),
    // rust: "p95": round(pct(v, 0.95)),
    // rust: "max": round(v.last().copied().map_or(0.0, f64::from)),
    // rust: })
}
    // rust: json!({
    // rust: "players_whole_window": out.len(),
    // rust: "out_kib_per_s_per_player": stats(&mut out),
    // rust: "in_kib_per_s_per_player": stats(&mut inn),
    // rust: "total_out_kib_per_s": round(kib_s(total_out)),
    // rust: "total_in_kib_per_s": round(kib_s(total_in)),
    // rust: })
}

/// What recording cost the tick, priced on this machine at the end of the recording: every
/// sampled mob two clock reads, every span inside the tick two clocks and two thread-CPU clocks.
/// A dedicated server records spans whenever `HORIZON_SPIKES` is on (by default, for its slow-tick
/// line): then they are not the report's cost, and `ms_per_tick` leaves them out.
pub fn overhead(r: *Recording, mob_samples: u64, span_ns: f64, mob_ns: f64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let n = r.ticks.len().max(1) as f64;
    // rust: let mspt = r.ticks.iter().map(|t| f64::from(t.wall_ms)).sum::<f64>() / n;
    // rust: let spans_per_tick = r.spans_recorded as f64 / n;
    // rust: let mobs_per_tick = mob_samples as f64 / n;
    // rust: let spans_ms = spans_per_tick * span_ns / 1e6;
    // rust: let mobs_ms = mobs_per_tick * mob_ns / 1e6;
    // rust: let ms = mobs_ms + if r.spans_were_on { 0.0 } else { spans_ms };
    // rust: let small = |v: f64| (v * 1e4).round() / 1e4;
    // rust: json!({
    // rust: "span_ns": round(span_ns),
    // rust: "spans_per_tick": round(spans_per_tick),
    // rust: "spans_ms_per_tick": small(spans_ms),
    // rust: "spans_on_without_report": r.spans_were_on,
    // rust: "mob_sample_ns": round(mob_ns),
    // rust: "mob_samples_per_tick": round(mobs_per_tick),
    // rust: "mob_samples_ms_per_tick": small(mobs_ms),
    // rust: "ms_per_tick": small(ms),
    // rust: "share_of_mspt": small(ms / mspt.max(1e-9)),
    // rust: })
}

/// What one span costs on this thread with spans on: the report's own overhead. The spans it
/// records are thrown away.
pub fn span_cost_nanos() f {
    // Implementation ported from Horizon
    return undefined;
}
pub const N: u32 = 5_000;
    // rust: let kept = spans::take_raw();
    // rust: let timer = Instant::now();
    // rust: for _ in 0..N {
    // rust: drop(spans::guard("calibration"));
}
    // rust: let per = timer.elapsed().as_nanos() as f64 / f64::from(N);
    // rust: spans::take_raw();
    // rust: debug_assert!(kept.is_empty(), "the tick takes its spans");
    // rust: per
}

    // rust: impl Game<'_> {
    /// The level in place and the parked ones: their chunks and their entities by type.
pub fn report_levels(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut levels = Vec::new();
    // rust: let here = |dim: Dim,
    // rust: world: &horizon_client::world::World,
    // rust: mobs: &[horizon_client::mobs::Mob]| {
    // rust: let mut by_type: BTreeMap<&str, usize> = BTreeMap::new();
    // rust: for m in mobs.iter().filter(|m| !m.removed) {
    // rust: *by_type.entry(&m.kind.id).or_default() += 1;
}
    // rust: let mut by_type: Vec<_> = by_type.into_iter().collect();
    // rust: by_type.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(b.0)));
    // rust: json!({
    // rust: "dimension": dim.id(),
    // rust: "chunks": world.chunks.len(),
    // rust: "block_entities": world.block_entities.len(),
    // rust: "mobs": mobs.iter().filter(|m| !m.removed).count(),
    // rust: "mobs_by_type": by_type.into_iter().map(|(k, v)| json!([k, v])).collect::<Vec<_>>(),
    // rust: })
}
    // rust: let mut current = here(self.dim, &self.world, &self.mobs);
    // rust: current["item_entities"] = json!(self.dropped.len());
    // rust: current["experience_orbs"] = json!(self.orbs.len());
    // rust: current["projectiles"] = json!(self.creatures.projectiles.len());
    // rust: current["minecarts"] = json!(self.carts.len());
    // rust: current["boats"] = json!(self.boats.len());
    // rust: levels.push(current);
    // rust: for dim in self.levels.parked_dims() {
    // rust: if let (Some(world), Some(mobs)) =
    // rust: (self.levels.parked_world(dim), self.levels.parked_mobs(dim))
    // rust: {
    // rust: let mut level = here(dim, world, mobs);
    // rust: if let Some([items, orbs, projectiles, carts, boats]) =
    // rust: self.levels.parked_entity_counts(dim)
    // rust: {
    // rust: level["item_entities"] = json!(items);
    // rust: level["experience_orbs"] = json!(orbs);
    // rust: level["projectiles"] = json!(projectiles);
    // rust: level["minecarts"] = json!(carts);
    // rust: level["boats"] = json!(boats);
}
    // rust: levels.push(level);
}
}
    // rust: Value::Array(levels)
}

    /// Each player's wire bytes (in, out) by connection.
    // rust: pub(super) fn wire_bytes(&self) -> Vec<(u32, (u64, u64))> {
    // rust: self.lan.as_ref().map_or_else(Vec::new, |h| {
    // rust: h.hub
    // rust: .guests
    // rust: .iter()
    // rust: .filter_map(|g| Some((g.conn, g.sender.wire_bytes()?)))
    // rust: .collect()
    // rust: })
}

    /// The report of a finished recording: written to `reports/` in the server's folder, its summary logged.
    // rust: pub(super) fn finish_report(&mut self, r: Recording, view: (u32, u32), max_players: usize) {
    // rust: let span_ns = span_cost_nanos();
    // rust: let mob_ns = tick_profile::sample_cost_nanos();
    // rust: if !r.spans_were_on {
    // rust: spans::enable(false);
}
    // rust: job_stats::enable(false);
    // rust: let window_s = r.started.elapsed().as_secs_f64();
    // rust: let (ticks, spans, worst) = tick_summary(&r, window_s);
    // rust: let costs = tick_profile::take();
    // rust: let mob_samples = costs.iter().map(|c| c.mob_ticks).sum();
    // rust: let jobs = job_stats::take();
    // rust: let cpu = horizon_bench::cpu_seconds(std::process::id())
    // rust: .zip(r.cpu_s)
    // rust: .map(|(end, start)| round((end - start) / window_s.max(1e-9)));
    // rust: let players = self.lan.as_ref().map_or(0, |h| h.hub.guests.len());
    // rust: let report = json!({
    // rust: "format": 2,
    // rust: "horizon": horizon_client::crash::version(),
    // rust: "minecraft": horizon_core::VANILLA_VERSION,
    // rust: "window_s": round(window_s),
    // rust: "ticks": ticks,
    // rust: "spans": spans,
    // rust: "worst_ticks": worst,
    // rust: "mob_costs": mob_costs(&costs, r.sampled_ticks),
    // rust: "mob_sampled_ticks": r.sampled_ticks,
    // rust: "chunk_workers": worker_jobs(&jobs, window_s),
    // rust: "network": network(&r.wire_start, &self.wire_bytes(), window_s),
    // rust: "overhead": overhead(&r, mob_samples, span_ns, mob_ns),
    // rust: "players": players,
    // rust: "levels": self.report_levels(),
    // rust: "memory": { "rss_mb": horizon_bench::rss_bytes(std::process::id()).map(|b| b >> 20) },
    // rust: "process": process_limits(),
    // rust: "cpu_cores_used": cpu,
    // rust: "config": {
    // rust: "view_distance": view.0,
    // rust: "simulation_distance": view.1,
    // rust: "max_players": max_players,
    // rust: },
    // rust: });
    // rust: let text = summary(&report);
        // The machine's description runs commands: off the tick.
    // rust: std::thread::spawn(move || {
    // rust: let mut report = report;
    // rust: let hw = horizon_bench::Hardware::detect();
    // rust: report["machine"] = json!({
    // rust: "os": hw.os, "arch": hw.arch, "cpu": hw.cpu, "cpu_threads": hw.cpu_threads, "ram_mb": hw.ram_mb,
    // rust: });
    // rust: match write_report(Path::new("reports"), &report, &text) {
    // rust: Ok(path) => log::info!(
    // rust: "Horizon: performance report written to {}\n{text}",
    // rust: path.display()
    // rust: ),
    // rust: Err(e) => log::error!("Horizon: could not write the performance report: {e}"),
}
    // rust: });
}
}

/// A few lines for the console: the tick rate and times, the five costliest spans, the worst tick.
pub fn summary(r: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = &r["ticks"];
    // rust: let m = &t["mspt"];
    // rust: let mut out = format!(
    // rust: "{} players, TPS {}, MSPT average {} ms, P50 {}, P95 {}, P99 {}, max {} ({} ticks over 50 ms, {} over 100 ms)\n",
    // rust: r["players"],
    // rust: t["tps"],
    // rust: m["average"],
    // rust: m["p50"],
    // rust: m["p95"],
    // rust: m["p99"],
    // rust: m["max"],
    // rust: t["over_50_ms"],
    // rust: t["over_100_ms"],
    // rust: );
    // rust: let span_list = |levels: bool, n: usize| -> Vec<String> {
    // rust: r["spans"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|s| s["name"].as_str().unwrap_or("").starts_with("level_") == levels)
    // rust: .take(n)
    // rust: .map(|s| {
    // rust: format!(
    // rust: "{} {} ms",
    // rust: s["name"].as_str().unwrap_or(""),
    // rust: s["ms_per_tick"]
    // rust: )
    // rust: })
    // rust: .collect()
}
    // rust: out += &format!("per tick: {}\n", span_list(false, 5).join(", "));
    // rust: let levels = span_list(true, 3);
    // rust: if !levels.is_empty() {
    // rust: out += &format!("levels: {}\n", levels.join(", "));
}
    // rust: if let Some(w) = r["worst_ticks"].get(0) {
    // rust: out += &format!("worst tick {} ms: {}\n", w["ms"], w["spans"]);
}
    // rust: let costs: Vec<String> = r["mob_costs"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .take(5)
    // rust: .map(|c| {
    // rust: format!(
    // rust: "{} {} ms ({} x {} us)",
    // rust: c["type"].as_str().unwrap_or(""),
    // rust: c["ms_per_tick"],
    // rust: c["mobs_ticked"],
    // rust: c["us_per_mob"]
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: if !costs.is_empty() {
    // rust: out += &format!("mobs: {}\n", costs.join(", "));
}
    // rust: let workers: Vec<String> = r["chunk_workers"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|w| {
    // rust: format!(
    // rust: "{} {}/s {} cores",
    // rust: w["kind"].as_str().unwrap_or(""),
    // rust: w["jobs_per_second"],
    // rust: w["cpu_cores"]
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: if !workers.is_empty() {
    // rust: out += &format!("chunk workers: {}\n", workers.join(", "));
}
    // rust: let net = &r["network"];
    // rust: if net.is_object() {
    // rust: out += &format!(
    // rust: "network: {} KiB/s out in all, {} KiB/s a player (P95 {}, max {})\n",
    // rust: net["total_out_kib_per_s"],
    // rust: net["out_kib_per_s_per_player"]["average"],
    // rust: net["out_kib_per_s_per_player"]["p95"],
    // rust: net["out_kib_per_s_per_player"]["max"]
    // rust: );
}
    // rust: if let Some(o) = r["overhead"].as_object() {
    // rust: out += &format!(
    // rust: "recording cost {} ms a tick ({} of MSPT)\n",
    // rust: o["ms_per_tick"], o["share_of_mspt"]
    // rust: );
}
    // rust: let mobs: u64 = r["levels"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|l| l["mobs"].as_u64())
    // rust: .sum();
    // rust: let chunks: u64 = r["levels"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|l| l["chunks"].as_u64())
    // rust: .sum();
    // rust: out += &format!(
    // rust: "{mobs} mobs, {chunks} chunks, {} MB resident, {} cores of CPU",
    // rust: r["memory"]["rss_mb"], r["cpu_cores_used"]
    // rust: );
    // rust: let process = &r["process"];
    // rust: if let Some(threads) = process["threads"].as_u64() {
    // rust: out += &format!("\n{threads} threads");
    // rust: for (key, name) in [
    // rust: ("cgroup_pids_current", "container tasks"),
    // rust: ("cgroup_pids_max", "container task limit"),
    // rust: ("max_processes", "max processes (soft / hard)"),
    // rust: ] {
    // rust: if let Some(value) = process[key].as_str() {
    // rust: out += &format!(", {name} {value}");
}
}
}
    // rust: out
}

/// What the system lets this process start: its threads now, and the limits
/// a container puts on them and on memory. A server out of threads fails to
/// start the ones it needs (EAGAIN). Read on Linux; null elsewhere.
pub fn process_limits() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let read = |path: &str| std::fs::read_to_string(path).ok();
    // rust: let threads = read("/proc/self/status").and_then(|s| {
    // rust: s.lines()
    // rust: .find_map(|l| l.strip_prefix("Threads:"))
    // rust: .and_then(|v| v.trim().parse::<u64>().ok())
    // rust: });
    // "Max processes   <soft>   <hard>   processes"
    // rust: let max_processes = read("/proc/self/limits").and_then(|s| {
    // rust: let line = s.lines().find(|l| l.starts_with("Max processes"))?;
    // rust: let words: Vec<&str> = line.split_whitespace().skip(2).take(2).collect();
    // rust: Some(words.join(" / "))
    // rust: });
    // rust: let cgroup = |name: &str| read(&format!("/sys/fs/cgroup/{name}")).map(|s| s.trim().to_owned());
    // rust: json!({
    // rust: "threads": threads,
    // rust: "max_processes": max_processes,
    // rust: "cgroup_pids_current": cgroup("pids.current"),
    // rust: "cgroup_pids_max": cgroup("pids.max"),
    // rust: "cgroup_memory_current": cgroup("memory.current"),
    // rust: "cgroup_memory_max": cgroup("memory.max"),
    // rust: })
}

/// The longest `horizon-trace` writes for.
    // rust: pub(super) const TRACE_MAX_SECONDS: u32 = 300;

/// `horizon-trace SECONDS`: every thread's spans for `seconds`, to `reports/trace-<time>.json`
/// (Perfetto opens it).
    // rust: pub(super) fn start_trace(seconds: u32) -> std::io::Result<PathBuf> {
    // rust: let dir = Path::new("reports");
    // rust: std::fs::create_dir_all(dir)?;
    // rust: let stamp = chrono::Utc::now().format("%Y-%m-%d_%H-%M-%SZ");
    // rust: let path = dir.join(format!("trace-{stamp}.json"));
    // rust: spans::trace::start(&path, Some(seconds))?;
    // rust: Ok(path)
}

pub fn write_report(dir: *Path, report: *Value, text: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::create_dir_all(dir)?;
    // rust: let stamp = chrono::Utc::now().format("%Y-%m-%d_%H-%M-%SZ");
    // rust: let path = dir.join(format!("perf-{stamp}.json"));
    // rust: std::fs::write(&path, serde_json::to_string_pretty(report)? + "\n")?;
    // rust: std::fs::write(path.with_extension("txt"), format!("{text}\n"))?;
    // rust: Ok(path)
}

    // rust: mod tests {
//     use super::*;

pub fn span(name: *'static str, ms: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Span {
    // rust: name,
    // rust: ms,
    // rust: cpu_ms: ms,
    // rust: depth: 0,
}
}

pub fn ticks_and_spans_are_summed_per_tick() void {
}
    // rust: let mut r = Recording {
    // rust: seconds: 1,
    // rust: started: Instant::now(),
    // rust: cpu_s: None,
    // rust: spans_were_on: true,
    // rust: ticks: Vec::new(),
    // rust: sampled_ticks: 0,
    // rust: spans_recorded: 0,
    // rust: wire_start: BTreeMap::new(),
}
    // rust: for i in 0..20 {
    // rust: let wall = if i == 7 { 120.0 } else { 10.0 };
    // rust: let sampled = r.sample_next();
    // rust: r.add(
    // rust: wall,
    // rust: Some(wall - 1.0),
    // rust: vec![span("tick_mobs", wall / 2.0), span("tick_lan", 2.0)],
    // rust: 2,
    // rust: sampled,
    // rust: );
}
    // rust: assert_eq!(r.sampled_ticks, 5, "one tick in four");
    // rust: assert_eq!(r.spans_recorded, 40);
    // rust: let (ticks, spans, worst) = tick_summary(&r, 1.0);
    // rust: assert_eq!(ticks["count"], 20);
    // rust: assert_eq!(ticks["tps"], 20.0);
    // rust: assert_eq!(ticks["over_100_ms"], 1);
    // rust: assert_eq!(ticks["mspt"]["max"], 120.0);
    // rust: assert_eq!(spans[0]["name"], "tick_mobs");
    // rust: assert_eq!(spans[0]["ms_per_tick"], 7.75);
    // rust: assert_eq!(spans[1]["ms_per_tick"], 2.0);
    // rust: assert_eq!(worst[0]["ms"], 120.0);
    // rust: assert_eq!(worst[0]["spans"][0], json!(["tick_mobs", 60.0]));
    // rust: let text = summary(
    // rust: &json!({"ticks": ticks, "spans": spans, "worst_ticks": worst, "players": 3,
    // rust: "levels": [{"mobs": 5, "chunks": 9}], "memory": {"rss_mb": 300}, "cpu_cores_used": 1.5}),
    // rust: );
    // rust: assert!(text.starts_with("3 players, TPS 20.0"), "{text}");
    // rust: assert!(
    // rust: text.contains("per tick: tick_mobs 7.75 ms, tick_lan 2.0 ms"),
    // rust: "{text}"
    // rust: );
    // rust: assert!(
    // rust: text.ends_with("5 mobs, 9 chunks, 300 MB resident, 1.5 cores of CPU"),
    // rust: "{text}"
    // rust: );
    // rust: let text = summary(
    // rust: &json!({"ticks": ticks, "spans": spans, "worst_ticks": worst,
    // rust: "players": 3, "levels": [], "memory": {"rss_mb": 300}, "cpu_cores_used": 1.5,
    // rust: "process": {"threads": 140, "cgroup_pids_current": "160", "cgroup_pids_max": "512",
    // rust: "max_processes": "unlimited / unlimited"}}),
    // rust: );
    // rust: assert!(
    // rust: text.ends_with(
    // rust: "140 threads, container tasks 160, container task limit 512, \
    // rust: max processes (soft / hard) unlimited / unlimited"
    // rust: ),
    // rust: "{text}"
    // rust: );
}

    /// A mob type's sampled time is spread over the sampled ticks; one mob's cost over its ticks.
pub fn mob_costs_are_per_sampled_tick_and_per_mob() void {
}
    // rust: let costs = [
    // rust: tick_profile::MobCost {
    // rust: dimension: "minecraft:overworld",
    // rust: kind: "minecraft:villager".into(),
                // 10 sampled ticks of 200 villagers at 25 us each.
    // rust: nanos: 10 * 200 * 25_000,
    // rust: mob_ticks: 10 * 200,
    // rust: },
    // rust: tick_profile::MobCost {
    // rust: dimension: "minecraft:the_end",
    // rust: kind: "minecraft:enderman".into(),
    // rust: nanos: 10 * 40 * 2_000,
    // rust: mob_ticks: 10 * 40,
    // rust: },
    // rust: ];
    // rust: let v = mob_costs(&costs, 10);
    // rust: assert_eq!(v[0]["type"], "minecraft:villager");
    // rust: assert_eq!(v[0]["ms_per_tick"], 5.0);
    // rust: assert_eq!(v[0]["mobs_ticked"], 200.0);
    // rust: assert_eq!(v[0]["us_per_mob"], 25.0);
    // rust: assert_eq!(v[1]["dimension"], "minecraft:the_end");
    // rust: assert_eq!(v[1]["ms_per_tick"], 0.08);
    // rust: assert_eq!(mob_costs(&[], 0), json!([]));
}

    /// Per-player rates count only the players on for the whole window; the total also counts
    /// those who joined during it, from zero.
pub fn network_rates_per_player_and_in_all() void {
}
    // rust: let start = BTreeMap::from([(1, (0, 0)), (2, (5_000, 50_000)), (9, (1, 1))]);
    // rust: let end = [
    // rust: (1, (10 * 1024, 100 * 1024 * 10)),
    // rust: (2, (5_000 + 20 * 1024, 50_000 + 300 * 1024 * 10)),
            // Joined during the window.
    // rust: (3, (0, 600 * 1024 * 10)),
    // rust: ];
    // rust: let v = network(&start, &end, 10.0);
    // rust: assert_eq!(v["players_whole_window"], 2);
    // rust: assert_eq!(v["out_kib_per_s_per_player"]["average"], 200.0);
    // rust: assert_eq!(v["out_kib_per_s_per_player"]["max"], 300.0);
    // rust: assert_eq!(v["in_kib_per_s_per_player"]["average"], 1.5);
    // rust: assert_eq!(v["total_out_kib_per_s"], 1000.0);
}

    /// Worker kinds that ran no job are left out; CPU time over the window is cores.
pub fn worker_jobs_give_cores_and_job_times() void {
}
    // rust: let jobs = [
    // rust: ("load", 0, 0),
    // rust: ("generate", 30_000_000_000, 6_000),
    // rust: ("light", 2_000_000_000, 4_000),
    // rust: ];
    // rust: let v = worker_jobs(&jobs, 60.0);
    // rust: assert_eq!(v.as_array().unwrap().len(), 2);
    // rust: assert_eq!(v[0]["kind"], "generate");
    // rust: assert_eq!(v[0]["cpu_cores"], 0.5);
    // rust: assert_eq!(v[0]["jobs_per_second"], 100.0);
    // rust: assert_eq!(v[0]["ms_per_job"], 5.0);
    // rust: assert_eq!(v[1]["ms_per_job"], 0.5);
}

    /// The recording's cost: spans and mob samples a tick at their measured price, against MSPT.
pub fn overhead_is_measured_against_the_tick() void {
}
    // rust: let mut r = Recording {
    // rust: seconds: 1,
    // rust: started: Instant::now(),
    // rust: cpu_s: None,
    // rust: spans_were_on: true,
    // rust: ticks: Vec::new(),
    // rust: sampled_ticks: 0,
    // rust: spans_recorded: 0,
    // rust: wire_start: BTreeMap::new(),
}
    // rust: for _ in 0..4 {
    // rust: r.add(50.0, None, Vec::new(), 100, false);
}
        // Spans were off before: 100 spans at 200 ns + 1,000 mob samples a tick at 50 ns = 0.07 ms
        // of 50.
    // rust: r.spans_were_on = false;
    // rust: let v = overhead(&r, 4_000, 200.0, 50.0);
    // rust: assert_eq!(v["spans_ms_per_tick"], 0.02);
    // rust: assert_eq!(v["ms_per_tick"], 0.07);
    // rust: assert_eq!(v["share_of_mspt"], 0.0014);
        // Spans on anyway (a dedicated server's slow-tick line): only the mob samples are the report's.
    // rust: r.spans_were_on = true;
    // rust: let v = overhead(&r, 4_000, 200.0, 50.0);
    // rust: assert_eq!(v["ms_per_tick"], 0.05);
    // rust: assert_eq!(v["share_of_mspt"], 0.001);
        // On this machine, both prices are well under a microsecond's order.
    // rust: let (span_ns, mob_ns) = (span_cost_nanos(), tick_profile::sample_cost_nanos());
    // rust: assert!(span_ns > 0.0 && span_ns < 50_000.0, "{span_ns}");
    // rust: assert!(mob_ns > 0.0 && mob_ns < 50_000.0, "{mob_ns}");
}

    /// The summary lists the levels apart from the systems, and the new sections when present.
pub fn summary_lists_levels_mobs_workers_network_and_cost() void {
}
    // rust: let r = json!({
    // rust: "ticks": {"tps": 20.0, "mspt": {"average": 40.0, "p50": 39.0, "p95": 45.0, "p99": 50.0, "max": 60.0},
    // rust: "over_50_ms": 1, "over_100_ms": 0},
    // rust: "spans": [{"name": "level_overworld", "ms_per_tick": 30.0}, {"name": "tick_mobs", "ms_per_tick": 20.0},
    // rust: {"name": "level_the_end", "ms_per_tick": 9.0}],
    // rust: "worst_ticks": [],
    // rust: "mob_costs": [{"type": "minecraft:villager", "ms_per_tick": 5.0, "mobs_ticked": 200.0, "us_per_mob": 25.0}],
    // rust: "chunk_workers": [{"kind": "generate", "jobs_per_second": 100.0, "cpu_cores": 0.5}],
    // rust: "network": {"total_out_kib_per_s": 1000.0, "out_kib_per_s_per_player": {"average": 200.0, "p95": 300.0, "max": 300.0}},
    // rust: "overhead": {"ms_per_tick": 0.07, "share_of_mspt": 0.0014},
    // rust: "players": 2, "levels": [], "memory": {"rss_mb": 1}, "cpu_cores_used": 1.0,
    // rust: });
    // rust: let text = summary(&r);
    // rust: assert!(text.contains("per tick: tick_mobs 20.0 ms\n"), "{text}");
    // rust: assert!(
    // rust: text.contains("levels: level_overworld 30.0 ms, level_the_end 9.0 ms\n"),
    // rust: "{text}"
    // rust: );
    // rust: assert!(
    // rust: text.contains("mobs: minecraft:villager 5.0 ms (200.0 x 25.0 us)\n"),
    // rust: "{text}"
    // rust: );
    // rust: assert!(
    // rust: text.contains("chunk workers: generate 100.0/s 0.5 cores\n"),
    // rust: "{text}"
    // rust: );
    // rust: assert!(
    // rust: text.contains(
    // rust: "network: 1000.0 KiB/s out in all, 200.0 KiB/s a player (P95 300.0, max 300.0)"
    // rust: ),
    // rust: "{text}"
    // rust: );
    // rust: assert!(
    // rust: text.contains("recording cost 0.07 ms a tick (0.0014 of MSPT)"),
    // rust: "{text}"
    // rust: );
}
}
