//! Transpiled from Horizon Rust crate
package horizon_telemetry_server_store

import "core:fmt"
import "core:mem"
import "core:math"

// The database: one SQLite file, kept small.
//
// - `systems`: each distinct machine description once. Rows point at it, so a CPU and GPU
//   name isn't stored again with every session. `extra` holds the later hardware fields
//   (cores, clocks, GPU maker and kind, VRAM, drive, screen, power, form) as JSON.
// - `perf`: one row per play session, in columns. A frame or tick summary is an 80-byte blob
//   ([`pack`]), not JSON; `slow_frames` (the frames of 250 ms or more by the step they spent
//   their time in) is JSON, empty for most sessions.
// - `reports`: crash and bug reports and benchmark uploads, their `data` zstd-compressed.
// - `perf_daily`: the anonymous totals per day, version, OS, GPU vendor and render distance
//   that `/v1/aggregate` reads. Rebuilt from `perf` when a day changes (new sessions, a
//   deletion), and kept after the raw rows expire.
//
// - `live_minute`, `live_hour`, `live_day`: the live count over time (`history`).
//
// Dates are the day the server received an item (days since 1970, UTC). The sender's IP
// address is never stored.
// use std::collections::{HashMap, HashSet};

// use horizon_telemetry::Kind;
// use horizon_telemetry::batch::Batch;
// use horizon_telemetry::payload::{BUCKET_EDGES_MS, Payload, Summary, System};
// use rusqlite::{Connection, OptionalExtension, params};
// use serde::{Deserialize, Serialize};

BUCKETS :: BUCKET_EDGES_MS.len() + 1

    // rust: const SCHEMA: &str = "
    // rust: PRAGMA journal_mode = WAL;
    // rust: PRAGMA synchronous = NORMAL;
    // rust: CREATE TABLE IF NOT EXISTS systems (
    // rust: id INTEGER PRIMARY KEY,
    // rust: os TEXT NOT NULL, os_version TEXT NOT NULL, arch TEXT NOT NULL, cpu TEXT NOT NULL,
    // rust: threads INTEGER NOT NULL, ram_gb INTEGER NOT NULL,
    // rust: gpu TEXT NOT NULL, driver TEXT NOT NULL, backend TEXT NOT NULL, extra TEXT NOT NULL DEFAULT '{}',
    // rust: UNIQUE (os, os_version, arch, cpu, threads, ram_gb, gpu, driver, backend, extra)
    // rust: );
    // rust: CREATE TABLE IF NOT EXISTS perf (
    // rust: install BLOB NOT NULL, day INTEGER NOT NULL, version TEXT NOT NULL, system INTEGER NOT NULL,
    // rust: render_distance INTEGER NOT NULL, simulation_distance INTEGER NOT NULL, max_fps INTEGER NOT NULL,
    // rust: vsync INTEGER NOT NULL, fullscreen INTEGER NOT NULL, graphics TEXT NOT NULL,
    // rust: seconds INTEGER NOT NULL, frames BLOB NOT NULL, ticks BLOB,
    // rust: peak_ram_mb INTEGER NOT NULL, to_title_ms INTEGER, to_world_ms INTEGER, slow_frames TEXT
    // rust: );
    // rust: CREATE INDEX IF NOT EXISTS perf_install ON perf (install);
    // rust: CREATE INDEX IF NOT EXISTS perf_day ON perf (day);
    // rust: CREATE TABLE IF NOT EXISTS reports (
    // rust: install BLOB NOT NULL, day INTEGER NOT NULL, kind INTEGER NOT NULL, version TEXT NOT NULL,
    // rust: system INTEGER, body BLOB NOT NULL
    // rust: );
    // rust: CREATE INDEX IF NOT EXISTS reports_install ON reports (install);
    // rust: CREATE INDEX IF NOT EXISTS reports_kind_day ON reports (kind, day);
    // rust: CREATE TABLE IF NOT EXISTS perf_daily (
    // rust: day INTEGER NOT NULL, version TEXT NOT NULL, os TEXT NOT NULL, gpu_vendor TEXT NOT NULL,
    // rust: render_distance INTEGER NOT NULL,
    // rust: sessions INTEGER NOT NULL, installs INTEGER NOT NULL, seconds INTEGER NOT NULL,
    // rust: buckets TEXT NOT NULL, p50_sum REAL NOT NULL, p99_sum REAL NOT NULL,
    // rust: PRIMARY KEY (day, version, os, gpu_vendor, render_distance)
    // rust: ) WITHOUT ROWID;
    // rust: CREATE TABLE IF NOT EXISTS dirty (day INTEGER PRIMARY KEY) WITHOUT ROWID;
    // rust: ";

kind_code :: proc(kind: Kind) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match kind {
    // rust: Kind::Perf => 0,
    // rust: Kind::Crash => 1,
    // rust: Kind::Bug => 2,
    // rust: Kind::Benchmark => 3,
}
}

// An install ID as 16 bytes.
install_key :: proc(id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: horizon_telemetry::consent::is_install_id(id).then(|| {
    // rust: (0..16)
    // rust: .map(|i| u8::from_str_radix(&id[2 * i..2 * i + 2], 16).unwrap_or(0))
    // rust: .collect()
    // rust: })
}

// A summary as 80 bytes: the count, four percentiles, then the 14 buckets, little-endian.
pack :: proc(s: ^Summary) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity(8 + 16 + 4 * BUCKETS);
    // rust: out.extend(s.count.to_le_bytes());
    // rust: for ms in [s.p50_ms, s.p95_ms, s.p99_ms, s.max_ms] {
    // rust: out.extend(ms.to_le_bytes());
}
    // rust: for i in 0..BUCKETS {
    // rust: out.extend(s.buckets.get(i).copied().unwrap_or(0).to_le_bytes());
}
    // rust: out
}

unpack :: proc(bytes: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if bytes.len() != 8 + 16 + 4 * BUCKETS {
    // rust: return None;
}
    // rust: let u32_at = |i: usize| u32::from_le_bytes(bytes[i..i + 4].try_into().unwrap_or_default());
    // rust: let f32_at = |i: usize| f32::from_bits(u32_at(i));
    // rust: Some(Summary {
    // rust: count: u64::from_le_bytes(bytes[..8].try_into().ok()?),
    // rust: p50_ms: f32_at(8),
    // rust: p95_ms: f32_at(12),
    // rust: p99_ms: f32_at(16),
    // rust: max_ms: f32_at(20),
    // rust: buckets: (0..BUCKETS).map(|i| u32_at(24 + 4 * i)).collect(),
    // rust: })
}

// The GPU's maker, the one GPU detail the public totals group by.
gpu_vendor :: proc(gpu: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: let gpu = gpu.to_ascii_lowercase();
    // rust: [
    // rust: ("apple", "apple"),
    // rust: ("nvidia", "nvidia"),
    // rust: ("geforce", "nvidia"),
    // rust: ("radeon", "amd"),
    // rust: ("amd", "amd"),
    // rust: ("intel", "intel"),
    // rust: ("adreno", "qualcomm"),
    // rust: ("llvmpipe", "software"),
    // rust: ]
    // rust: .into_iter()
    // rust: .find(|(needle, _)| gpu.contains(needle))
    // rust: .map_or(if gpu.is_empty() { "unknown" } else { "other" }, |(_, v)| v)
}

Store :: struct {
    // rust: pub(crate) db: Connection,
}

    // rust: impl Store {
open :: proc(path: string) -> r {
    // Ported from Horizon
    return {}
}
    // rust: let mut db = Connection::open(path)?;
    // rust: db.execute_batch(SCHEMA)?;
    // rust: db.execute_batch(crate::hub::SCHEMA)?;
    // rust: db.execute_batch(crate::intake::SCHEMA)?;
    // rust: db.execute_batch(crate::history::SCHEMA)?;
    // rust: migrate(&mut db)?;
    // rust: Ok(Self { db })
}

    // How many items an install has sent on `day`.
count_on :: proc(self: ^Self, install: []u8, day: u32) -> r {
    // Ported from Horizon
    return {}
}
    // rust: self.db.query_row(
    // rust: "SELECT (SELECT count(*) FROM perf WHERE install = ?1 AND day = ?2)
    // rust: + (SELECT count(*) FROM reports WHERE install = ?1 AND day = ?2)",
    // rust: params![install, day],
    // rust: |r| r.get(0),
    // rust: )
}

    // Keeps a decoded batch, received on `day`.
insert :: proc(self: ^Self, batch: ^Batch, day: u32) -> r {
    // Ported from Horizon
    return {}
}
    // rust: let install = install_key(&batch.install_id).unwrap_or_default();
    // rust: let tx = self.db.transaction()?;
    // rust: for item in &batch.items {
    // rust: match &item.payload {
    // rust: Payload::Perf(p) => {
    // rust: let system = system_id(&tx, &p.system)?;
    // rust: tx.execute(
    // rust: "INSERT INTO perf (install, day, version, system, render_distance, simulation_distance,
    // rust: max_fps, vsync, fullscreen, graphics, seconds, frames, ticks, peak_ram_mb,
    // rust: to_title_ms, to_world_ms, slow_frames) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14, ?15, ?16, ?17)",
    // rust: params![
    // rust: install, day, item.version, system,
    // rust: p.settings.render_distance, p.settings.simulation_distance, p.settings.max_fps,
    // rust: p.settings.vsync, p.settings.fullscreen, p.settings.graphics,
    // rust: p.seconds, pack(&p.frames), p.ticks.as_ref().map(pack), p.peak_ram_mb,
    // rust: p.to_title_ms, p.to_world_ms,
    // rust: (!p.slow_frames.is_empty())
    // rust: .then(|| serde_json::to_string(&p.slow_frames).ok())
    // rust: .flatten(),
    // rust: ],
    // rust: )?;
}
    // rust: payload => {
    // rust: let system = match payload {
    // rust: Payload::Crash(c) => Some(system_id(&tx, &c.system)?),
    // rust: Payload::Bug(b) => Some(system_id(&tx, &b.system)?),
    // rust: _ => None,
}
    // rust: let data = match payload {
    // rust: Payload::Crash(c) => serde_json::to_vec(c),
    // rust: Payload::Bug(b) => serde_json::to_vec(b),
    // rust: Payload::Benchmark(r) => serde_json::to_vec(r),
    // rust: Payload::Perf(_) => unreachable!("handled above"),
}
    // rust: .unwrap_or_default();
    // rust: let body = ruzstd::encoding::compress_to_vec(
    // rust: data.as_slice(),
    // rust: ruzstd::encoding::CompressionLevel::Fastest,
    // rust: );
    // rust: tx.execute(
    // rust: "INSERT INTO reports (install, day, kind, version, system, body) VALUES (?1, ?2, ?3, ?4, ?5, ?6)",
    // rust: params![install, day, kind_code(item.kind()), item.version, system, body],
    // rust: )?;
}
}
}
    // rust: tx.execute("INSERT OR IGNORE INTO dirty (day) VALUES (?1)", [day])?;
    // rust: tx.commit()
}

    // Deletes everything an install sent; the days it touched get their totals rebuilt.
delete_install :: proc(self: ^Self, install: []u8) -> r {
    // Ported from Horizon
    return {}
}
    // rust: let tx = self.db.transaction()?;
    // rust: tx.execute(
    // rust: "INSERT OR IGNORE INTO dirty (day) SELECT DISTINCT day FROM perf WHERE install = ?1",
    // rust: [install],
    // rust: )?;
    // rust: let mut deleted = tx.execute("DELETE FROM perf WHERE install = ?1", [install])?;
    // rust: deleted += tx.execute("DELETE FROM reports WHERE install = ?1", [install])?;
    // rust: tx.commit()?;
    // rust: self.rebuild_dirty()?;
    // rust: Ok(deleted)
}

    // Removes raw rows received before `oldest_day`; the daily totals stay.
expire :: proc(self: ^Self, oldest_day: u32) -> r {
    // Ported from Horizon
    return {}
}
        // A day's totals are final before its rows go.
    // rust: self.rebuild_dirty()?;
    // rust: let mut n = self
    // rust: .db
    // rust: .execute("DELETE FROM perf WHERE day < ?1", [oldest_day])?;
    // rust: n += self
    // rust: .db
    // rust: .execute("DELETE FROM reports WHERE day < ?1", [oldest_day])?;
    // rust: self.db.execute(
    // rust: "DELETE FROM systems WHERE id NOT IN (SELECT system FROM perf)
    // rust: AND id NOT IN (SELECT system FROM reports WHERE system IS NOT NULL)",
    // rust: [],
    // rust: )?;
    // rust: Ok(n)
}

    // Rebuilds the daily totals of every day marked changed.
rebuild_dirty :: proc(self: ^Self) -> r {
    // Ported from Horizon
    return {}
}
    // rust: let days: Vec<u32> = {
    // rust: let mut q = self.db.prepare("SELECT day FROM dirty")?;
    // rust: q.query_map([], |r| r.get(0))?.collect::<Result<_, _>>()?
}
    // rust: for day in days {
    // rust: self.rebuild_day(day)?;
}
    // rust: Ok(())
}

rebuild_day :: proc(self: ^Self, day: u32) -> r {
    // Ported from Horizon
    return {}
}
Group :: struct {
    sessions: u64,
    installs: map[[dynamic]u8]struct{},
    seconds: u64,
    buckets: [u64,
    p50_sum: f64,
    p99_sum: f64,
}
    // rust: let tx = self.db.transaction()?;
    // rust: let mut groups: HashMap<(String, String, &'static str, u8), Group> = HashMap::new();
    // rust: {
    // rust: let mut q = tx.prepare(
    // rust: "SELECT perf.install, perf.version, systems.os, systems.gpu, perf.render_distance,
    // rust: perf.seconds, perf.frames FROM perf JOIN systems ON systems.id = perf.system
    // rust: WHERE perf.day = ?1",
    // rust: )?;
    // rust: let mut rows = q.query([day])?;
    // rust: while let Some(r) = rows.next()? {
    // rust: let gpu: String = r.get(3)?;
    // rust: let key = (r.get(1)?, r.get(2)?, gpu_vendor(&gpu), r.get(4)?);
    // rust: let Some(frames) = unpack(&r.get::<_, Vec<u8>>(6)?) else {
    // rust: continue;
}
    // rust: let g = groups.entry(key).or_default();
    // rust: g.sessions += 1;
    // rust: g.installs.insert(r.get(0)?);
    // rust: g.seconds += r.get::<_, u64>(5)?;
    // rust: for (sum, n) in g.buckets.iter_mut().zip(&frames.buckets) {
    // rust: *sum += u64::from(*n);
}
    // rust: g.p50_sum += f64::from(frames.p50_ms);
    // rust: g.p99_sum += f64::from(frames.p99_ms);
}
}
    // rust: tx.execute("DELETE FROM perf_daily WHERE day = ?1", [day])?;
    // rust: for ((version, os, vendor, distance), g) in groups {
    // rust: tx.execute(
    // rust: "INSERT INTO perf_daily VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11)",
    // rust: params![
    // rust: day,
    // rust: version,
    // rust: os,
    // rust: vendor,
    // rust: distance,
    // rust: g.sessions,
    // rust: g.installs.len(),
    // rust: g.seconds,
    // rust: serde_json::to_string(&g.buckets.to_vec()).unwrap_or_default(),
    // rust: g.p50_sum,
    // rust: g.p99_sum,
    // rust: ],
    // rust: )?;
}
    // rust: tx.execute("DELETE FROM dirty WHERE day = ?1", [day])?;
    // rust: tx.commit()
}

    // The anonymous totals for the days `from..=to`, groups with fewer than `k` install-days
    // left out, and the newest benchmark uploads.
aggregate :: proc(self: ^Self, from: u32, to: u32, k: u64) -> r {
    // Ported from Horizon
    return {}
}
    // rust: self.rebuild_dirty()?;
        // One group's sums over the window.
Totals :: struct {
    sessions: u64,
    install_days: u64,
    seconds: u64,
    buckets: [u64,
    p50_sum: f64,
    p99_sum: f64,
}
    // rust: let mut groups: HashMap<(String, String, String, u8), Totals> = HashMap::new();
    // rust: {
    // rust: let mut q = self.db.prepare(
    // rust: "SELECT version, os, gpu_vendor, render_distance, sessions, installs, seconds, buckets,
    // rust: p50_sum, p99_sum FROM perf_daily WHERE day BETWEEN ?1 AND ?2",
    // rust: )?;
    // rust: let mut rows = q.query([from, to])?;
    // rust: while let Some(r) = rows.next()? {
    // rust: let g = groups
    // rust: .entry((r.get(0)?, r.get(1)?, r.get(2)?, r.get(3)?))
    // rust: .or_default();
    // rust: g.sessions += r.get::<_, u64>(4)?;
    // rust: g.install_days += r.get::<_, u64>(5)?;
    // rust: g.seconds += r.get::<_, u64>(6)?;
    // rust: let buckets: Vec<u64> =
    // rust: serde_json::from_str(&r.get::<_, String>(7)?).unwrap_or_default();
    // rust: for (sum, n) in g.buckets.iter_mut().zip(buckets) {
    // rust: *sum += n;
}
    // rust: g.p50_sum += r.get::<_, f64>(8)?;
    // rust: g.p99_sum += r.get::<_, f64>(9)?;
}
}
    // rust: let (mut sessions, mut hours) = (0, 0.0);
    // rust: let mut out: Vec<serde_json::Value> = groups
    // rust: .into_iter()
    // rust: .filter(|(_, g)| g.install_days >= k)
    // rust: .map(|((version, os, vendor, distance), g)| {
    // rust: sessions += g.sessions;
    // rust: hours += g.seconds as f64 / 3600.0;
    // rust: let avg = |sum: f64| (sum / g.sessions as f64 * 10.0).round() / 10.0;
    // rust: serde_json::json!({
    // rust: "version": version, "os": os, "gpu_vendor": vendor, "render_distance": distance,
    // rust: "sessions": g.sessions, "install_days": g.install_days,
    // rust: "hours": (g.seconds as f64 / 360.0).round() / 10.0,
    // rust: "frame_buckets": g.buckets.to_vec(), "p50_ms": avg(g.p50_sum), "p99_ms": avg(g.p99_sum),
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: out.sort_by(|a, b| b["sessions"].as_u64().cmp(&a["sessions"].as_u64()));
    // rust: let crashes: Vec<serde_json::Value> = {
    // rust: let mut q = self.db.prepare(
    // rust: "SELECT version, count(*) FROM reports WHERE kind = ?1 AND day BETWEEN ?2 AND ?3
    // rust: GROUP BY version ORDER BY 2 DESC LIMIT 20",
    // rust: )?;
    // rust: q.query_map(params![kind_code(Kind::Crash), from, to], |r| {
    // rust: Ok(serde_json::json!({ "version": r.get::<_, String>(0)?, "crashes": r.get::<_, u64>(1)? }))
    // rust: })?
    // rust: .collect::<Result<_, _>>()?
}
    // rust: let breakdowns = self.breakdowns(from, to)?;
    // rust: let slow_frames = self.slow_frames(from, to, k)?;
    // rust: Ok(serde_json::json!({
    // rust: "from_day": from, "to_day": to, "min_install_days": k,
    // rust: "bucket_edges_ms": BUCKET_EDGES_MS.map(|e| (f64::from(e) * 10.0).round() / 10.0),
    // rust: "totals": { "sessions": sessions, "hours": (hours * 10.0).round() / 10.0 },
    // rust: "groups": out, "crashes_by_version": crashes, "breakdowns": breakdowns,
    // rust: "slow_frames": slow_frames,
    // rust: }))
}

    // What froze in `from..=to`: per release and step (`span`, `""` when no step was timed),
    // the frames of 250 ms or more spent mostly in it, the sessions and installs that had one,
    // and the longest frame and step. Only steps seen by at least `k` installs. From the raw
    // rows, so only within the retention period.
slow_frames :: proc(self: ^Self, from: u32, to: u32, k: u64) -> r {
    // Ported from Horizon
    return {}
}
Step :: struct {
    frames: u64,
    sessions: u64,
    installs: map[[dynamic]u8]struct{},
    frame_max_ms: f32,
    span_max_ms: f32,
}
    // rust: let mut steps: HashMap<(String, String), Step> = HashMap::new();
    // rust: let mut q = self.db.prepare(
    // rust: "SELECT install, version, slow_frames FROM perf
    // rust: WHERE day BETWEEN ?1 AND ?2 AND slow_frames IS NOT NULL",
    // rust: )?;
    // rust: let mut rows = q.query([from, to])?;
    // rust: while let Some(r) = rows.next()? {
    // rust: let install: Vec<u8> = r.get(0)?;
    // rust: let version: String = r.get(1)?;
    // rust: let list: Vec<horizon_telemetry::payload::SlowFrames> =
    // rust: serde_json::from_str(&r.get::<_, String>(2)?).unwrap_or_default();
    // rust: for entry in list {
    // rust: let step = steps.entry((version.clone(), entry.span)).or_default();
    // rust: step.frames += u64::from(entry.frames);
    // rust: step.sessions += 1;
    // rust: step.installs.insert(install.clone());
    // rust: step.frame_max_ms = step.frame_max_ms.max(entry.frame_max_ms);
    // rust: step.span_max_ms = step.span_max_ms.max(entry.span_max_ms);
}
}
    // rust: let mut out: Vec<((String, String), Step)> = steps
    // rust: .into_iter()
    // rust: .filter(|(_, s)| s.installs.len() as u64 >= k)
    // rust: .collect();
    // rust: out.sort_by(|a, b| b.1.frames.cmp(&a.1.frames).then(a.0.cmp(&b.0)));
    // rust: let round = |ms: f32| (f64::from(ms) * 10.0).round() / 10.0;
    // rust: Ok(out
    // rust: .into_iter()
    // rust: .map(|((version, span), s)| {
    // rust: serde_json::json!({
    // rust: "version": version, "span": span, "frames": s.frames, "sessions": s.sessions,
    // rust: "installs": s.installs.len(), "frame_max_ms": round(s.frame_max_ms),
    // rust: "span_max_ms": round(s.span_max_ms),
    // rust: })
    // rust: })
    // rust: .collect())
}

    // Play sessions in `from..=to` per hardware class (`classes`): for each RAM, VRAM, drive,
    // OS and GPU kind class with at least `MIN_INSTALLS` different installs, its installs,
    // sessions, hours and mean p50 and p99 frame times. From the raw rows, so only within the
    // retention period.
breakdowns :: proc(self: ^Self, from: u32, to: u32) -> r {
    // Ported from Horizon
    return {}
}
Cell :: struct {
    installs: map[[dynamic]u8]struct{},
    sessions: u64,
    seconds: u64,
    p50_sum: f64,
    p99_sum: f64,
}
    // rust: let mut cells: [HashMap<&'static str, Cell>; 5] = Default::default();
    // rust: let mut q = self.db.prepare(
    // rust: "SELECT perf.install, perf.seconds, perf.frames, systems.os, systems.ram_gb, systems.extra
    // rust: FROM perf JOIN systems ON systems.id = perf.system WHERE perf.day BETWEEN ?1 AND ?2",
    // rust: )?;
    // rust: let mut rows = q.query([from, to])?;
    // rust: while let Some(r) = rows.next()? {
    // rust: let Some(frames) = unpack(&r.get::<_, Vec<u8>>(2)?) else {
    // rust: continue;
}
    // rust: let extra: Extra = serde_json::from_str(&r.get::<_, String>(5)?).unwrap_or_default();
    // rust: let system = System {
    // rust: os: r.get(3)?,
    // rust: ram_gb: r.get(4)?,
    // rust: gpu_kind: extra.gpu_kind,
    // rust: vram_mb: extra.vram_mb,
    // rust: storage: extra.storage,
    // rust: ..System::default()
}
    // rust: let install: Vec<u8> = r.get(0)?;
    // rust: let seconds: u64 = r.get(1)?;
    // rust: for (dim, class) in crate::classes::of_system(&system).into_iter().enumerate() {
    // rust: let Some(class) = class else { continue };
    // rust: let c = cells[dim].entry(class).or_default();
    // rust: c.installs.insert(install.clone());
    // rust: c.sessions += 1;
    // rust: c.seconds += seconds;
    // rust: c.p50_sum += f64::from(frames.p50_ms);
    // rust: c.p99_sum += f64::from(frames.p99_ms);
}
}
    // rust: let mut out = serde_json::Map::new();
    // rust: for (dim, by_class) in crate::classes::DIMENSIONS.iter().zip(cells) {
    // rust: let mut list: Vec<(&str, Cell)> = by_class
    // rust: .into_iter()
    // rust: .filter(|(_, c)| c.installs.len() >= crate::summary::MIN_INSTALLS)
    // rust: .collect();
    // rust: list.sort_by(|a, b| {
    // rust: b.1.installs
    // rust: .len()
    // rust: .cmp(&a.1.installs.len())
    // rust: .then(a.0.cmp(b.0))
    // rust: });
    // rust: if list.is_empty() {
    // rust: continue;
}
    // rust: let avg = |sum: f64, n: u64| (sum / n as f64 * 10.0).round() / 10.0;
    // rust: out.insert(
    // rust: dim.to_string(),
    // rust: list.into_iter()
    // rust: .map(|(class, c)| {
    // rust: serde_json::json!({
    // rust: "class": class, "installs": c.installs.len(), "sessions": c.sessions,
    // rust: "hours": (c.seconds as f64 / 360.0).round() / 10.0,
    // rust: "p50_ms": avg(c.p50_sum, c.sessions), "p99_ms": avg(c.p99_sum, c.sessions),
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: );
}
    // rust: Ok(serde_json::Value::Object(out))
}

    // Every benchmark upload received since `from_day`, with its install (to count installs, never shown)
    // and release, for `summary`.
    // rust: pub fn benchmark_uploads(
    // rust: &self,
    // rust: from_day: u32,
    // rust: ) -> rusqlite::Result<Vec<crate::summary::Upload>> {
    // rust: let mut q = self
    // rust: .db
    // rust: .prepare("SELECT install, version, body FROM reports WHERE kind = ?1 AND day >= ?2")?;
    // rust: q.query_map(params![kind_code(Kind::Benchmark), from_day], |r| {
    // rust: Ok(crate::summary::Upload {
    // rust: install: r.get(0)?,
    // rust: version: r.get(1)?,
    // rust: report: inflate(&r.get::<_, Vec<u8>>(2)?),
    // rust: })
    // rust: })?
    // rust: .collect()
}

    // The day an install's newest row came in, if any (tests, and checking a deletion).
newest_day :: proc(self: ^Self, install: []u8) -> r {
    // Ported from Horizon
    return {}
}
    // rust: self.db
    // rust: .query_row(
    // rust: "SELECT max(day) FROM (SELECT day FROM perf WHERE install = ?1
    // rust: UNION ALL SELECT day FROM reports WHERE install = ?1)",
    // rust: [install],
    // rust: |r| r.get(0),
    // rust: )
    // rust: .optional()
    // rust: .map(Option::flatten)
}
}

// The hardware fields after the first nine, as `systems.extra` keeps them.
Extra :: struct {
    cores: u16,
    cpu_base_mhz: u32,
    cpu_boost_mhz: u32,
    gpu_vendor: string,
    gpu_kind: string,
    vram_mb: u32,
    storage: string,
    display: Maybe(horizon_telemetry::payload::Display),
    power: string,
    form: string,
}

    // rust: impl Extra {
of :: proc(s: ^System) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: cores: s.cores,
    // rust: cpu_base_mhz: s.cpu_base_mhz,
    // rust: cpu_boost_mhz: s.cpu_boost_mhz,
    // rust: gpu_vendor: s.gpu_vendor.clone(),
    // rust: gpu_kind: s.gpu_kind.clone(),
    // rust: vram_mb: s.vram_mb,
    // rust: storage: s.storage.clone(),
    // rust: display: s.display.clone(),
    // rust: power: s.power.clone(),
    // rust: form: s.form.clone(),
}
}
}

// Databases from before a column: `perf.slow_frames` added, and `systems` rebuilt with
// `extra` (ids kept), once each.
migrate :: proc(db: ^Connection) -> r {
    // Ported from Horizon
    return {}
}
    // rust: let has = |db: &Connection, table: &str, column: &str| {
    // rust: db.prepare("SELECT 1 FROM pragma_table_info(?1) WHERE name = ?2")?
    // rust: .exists([table, column])
}
    // rust: if !has(db, "perf", "slow_frames")? {
    // rust: db.execute_batch("ALTER TABLE perf ADD COLUMN slow_frames TEXT")?;
}
    // rust: if has(db, "systems", "extra")? {
    // rust: return Ok(());
}
    // rust: let tx = db.transaction()?;
    // rust: tx.execute_batch(
    // rust: "CREATE TABLE systems_new (
    // rust: id INTEGER PRIMARY KEY,
    // rust: os TEXT NOT NULL, os_version TEXT NOT NULL, arch TEXT NOT NULL, cpu TEXT NOT NULL,
    // rust: threads INTEGER NOT NULL, ram_gb INTEGER NOT NULL,
    // rust: gpu TEXT NOT NULL, driver TEXT NOT NULL, backend TEXT NOT NULL, extra TEXT NOT NULL DEFAULT '{}',
    // rust: UNIQUE (os, os_version, arch, cpu, threads, ram_gb, gpu, driver, backend, extra)
    // rust: );
    // rust: INSERT INTO systems_new (id, os, os_version, arch, cpu, threads, ram_gb, gpu, driver, backend)
    // rust: SELECT id, os, os_version, arch, cpu, threads, ram_gb, gpu, driver, backend FROM systems;
    // rust: DROP TABLE systems;
    // rust: ALTER TABLE systems_new RENAME TO systems;",
    // rust: )?;
    // rust: tx.commit()
}

system_id :: proc(tx: ^rusqlite::Transaction, s: ^System) -> r {
    // Ported from Horizon
    return {}
}
    // rust: let extra = serde_json::to_string(&Extra::of(s)).unwrap_or_else(|_| "{}".into());
    // rust: tx.execute(
    // rust: "INSERT OR IGNORE INTO systems (os, os_version, arch, cpu, threads, ram_gb, gpu, driver, backend, extra)
    // rust: VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10)",
    // rust: params![s.os, s.os_version, s.arch, s.cpu, s.threads, s.ram_gb, s.gpu, s.driver, s.backend, extra],
    // rust: )?;
    // rust: tx.query_row(
    // rust: "SELECT id FROM systems WHERE os = ?1 AND os_version = ?2 AND arch = ?3 AND cpu = ?4
    // rust: AND threads = ?5 AND ram_gb = ?6 AND gpu = ?7 AND driver = ?8 AND backend = ?9 AND extra = ?10",
    // rust: params![
    // rust: s.os,
    // rust: s.os_version,
    // rust: s.arch,
    // rust: s.cpu,
    // rust: s.threads,
    // rust: s.ram_gb,
    // rust: s.gpu,
    // rust: s.driver,
    // rust: s.backend,
    // rust: extra
    // rust: ],
    // rust: |r| r.get(0),
    // rust: )
}

// A stored body back as JSON.
inflate :: proc(body: []u8) -> s {
    // Ported from Horizon
    return {}
}
//     use std::io::Read;
    // rust: let mut json = Vec::new();
    // rust: ruzstd::decoding::StreamingDecoder::new(body)
    // rust: .ok()
    // rust: .and_then(|d| d.take(1 << 20).read_to_end(&mut json).ok())
    // rust: .and_then(|_| serde_json::from_slice(&json).ok())
    // rust: .unwrap_or(serde_json::Value::Null)
}

    // rust: mod tests {
//     use super::*;

    // A database from before `perf.slow_frames` gains the column and keeps its sessions.
perf_from_before_slow_frames_gains_the_column :: proc() {
}
    // rust: let path = std::env::temp_dir().join(format!(
    // rust: "horizon-telemetry-slow-{}.sqlite",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_file(&path);
    // rust: {
    // rust: let db = Connection::open(&path).unwrap();
    // rust: db.execute_batch(
    // rust: "CREATE TABLE perf (
    // rust: install BLOB NOT NULL, day INTEGER NOT NULL, version TEXT NOT NULL, system INTEGER NOT NULL,
    // rust: render_distance INTEGER NOT NULL, simulation_distance INTEGER NOT NULL, max_fps INTEGER NOT NULL,
    // rust: vsync INTEGER NOT NULL, fullscreen INTEGER NOT NULL, graphics TEXT NOT NULL,
    // rust: seconds INTEGER NOT NULL, frames BLOB NOT NULL, ticks BLOB,
    // rust: peak_ram_mb INTEGER NOT NULL, to_title_ms INTEGER, to_world_ms INTEGER
    // rust: );
    // rust: INSERT INTO perf VALUES (x'00', 1, 'v1', 1, 12, 12, 0, 0, 0, 'fancy', 60, x'00', NULL, 1, NULL, NULL);",
    // rust: )
    // rust: .unwrap();
}
    // rust: let path_str = path.to_str().unwrap();
    // rust: let store = Store::open(path_str).unwrap();
    // rust: let old: Option<String> = store
    // rust: .db
    // rust: .query_row("SELECT slow_frames FROM perf", [], |r| r.get(0))
    // rust: .unwrap();
    // rust: assert_eq!(old, None, "the old session is kept, with none");
    // rust: drop(store);
    // rust: Store::open(path_str).unwrap(); // a second open adds nothing
    // rust: for suffix in ["", "-wal", "-shm"] {
    // rust: let _ = std::fs::remove_file(format!("{path_str}{suffix}"));
}
}

    // A database from before `systems.extra` opens, keeps its machines' ids and takes new ones.
systems_from_before_extra_are_kept :: proc() {
}
    // rust: let path = std::env::temp_dir().join(format!(
    // rust: "horizon-telemetry-migrate-{}.sqlite",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_file(&path);
    // rust: {
    // rust: let db = Connection::open(&path).unwrap();
    // rust: db.execute_batch(
    // rust: "CREATE TABLE systems (
    // rust: id INTEGER PRIMARY KEY,
    // rust: os TEXT NOT NULL, os_version TEXT NOT NULL, arch TEXT NOT NULL, cpu TEXT NOT NULL,
    // rust: threads INTEGER NOT NULL, ram_gb INTEGER NOT NULL,
    // rust: gpu TEXT NOT NULL, driver TEXT NOT NULL, backend TEXT NOT NULL,
    // rust: UNIQUE (os, os_version, arch, cpu, threads, ram_gb, gpu, driver, backend)
    // rust: );
    // rust: INSERT INTO systems VALUES (7, 'linux', 'Fedora 43', 'x86_64', 'Ryzen', 32, 32, 'RTX 4070', '570', 'Vulkan');",
    // rust: )
    // rust: .unwrap();
}
    // rust: let path_str = path.to_str().unwrap();
    // rust: let mut store = Store::open(path_str).unwrap();
    // rust: let old: (String, String) = store
    // rust: .db
    // rust: .query_row("SELECT gpu, extra FROM systems WHERE id = 7", [], |r| {
    // rust: Ok((r.get(0)?, r.get(1)?))
    // rust: })
    // rust: .unwrap();
    // rust: assert_eq!(old, ("RTX 4070".to_owned(), "{}".to_owned()));
    // rust: let s = System {
    // rust: os: "linux".into(),
    // rust: gpu: "RTX 4070".into(),
    // rust: vram_mb: 12288,
    // rust: gpu_kind: "discrete".into(),
    // rust: storage: "nvme".into(),
    // rust: ..System::default()
}
    // rust: let tx = store.db.transaction().unwrap();
    // rust: let id = system_id(&tx, &s).unwrap();
    // rust: assert_eq!(system_id(&tx, &s).unwrap(), id, "the same machine once");
    // rust: let extra: String = tx
    // rust: .query_row("SELECT extra FROM systems WHERE id = ?1", [id], |r| {
    // rust: r.get(0)
    // rust: })
    // rust: .unwrap();
    // rust: tx.commit().unwrap();
    // rust: let back: Extra = serde_json::from_str(&extra).unwrap();
    // rust: assert_eq!((back.vram_mb, back.storage.as_str()), (12288, "nvme"));
    // rust: drop(store);
    // rust: Store::open(path_str).unwrap(); // a second open doesn't rebuild again
    // rust: for suffix in ["", "-wal", "-shm"] {
    // rust: let _ = std::fs::remove_file(format!("{path_str}{suffix}"));
}
}
}
