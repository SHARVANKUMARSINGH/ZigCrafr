//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry-server_export
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The protected, read-only export for the people who tune performance: the raw benchmark
//! reports and the per-hardware totals, with no minimum number of installs (the public
//! `/v1/aggregate` and `/v1/benchmarks/summary` hide small groups).
//!
//! - `GET /v1/export/benchmarks?after=<id>&limit=100`: `{"reports": [{"id", "day", "version",
//!   "report"}], "next": <id>|null}`, oldest first. Pass `next` as `after` for the next page.
//! - `GET /v1/export/hardware?days=30&offset=0&limit=200`: `{"machines": [...], "next_offset"}`:
//!   one entry per distinct machine description (CPU threads and cores, RAM, GPU, drive, OS…),
//!   with its installs, sessions, hours and frame-time numbers, busiest first.
//!
//! Both need `Authorization: Bearer <TELEMETRY_EXPORT_TOKEN>`, are off (404) while the server has
//! no such token, answer gzip to a client that accepts it, and are never cached. Install IDs
//! never leave the database: a report has no owner here, and a machine only a count of them.
// use std::collections::{HashMap, HashSet};
// use std::io::Write;
// use std::sync::Arc;

// use axum::extract::{Query, Request, State};
// use axum::http::{HeaderMap, HeaderValue, StatusCode, header};
// use axum::response::{IntoResponse, Response};
// use horizon_telemetry::payload::BUCKET_EDGES_MS;
// use serde::Deserialize;
// use serde_json::{Value, json};

// use crate::store::{Extra, Store, unpack};
// use crate::{App, peer, status};

/// Equal, in a time that depends on the token's length only, not on where they differ.
    // rust: pub(crate) fn same(sent: &[u8], token: &[u8]) -> bool {
    // rust: let mut diff = sent.len() ^ token.len();
    // rust: for (i, t) in token.iter().enumerate() {
    // rust: diff |= usize::from(sent.get(i).copied().unwrap_or(0) ^ t);
}
    // rust: diff == 0
}

/// The answer to send instead when the request's `Bearer` token doesn't check out: 404 while the
/// export is off, 401 for a missing or wrong token, 429 once an address has failed too often.
/// None: go ahead.
    // rust: fn refuse(
    // rust: app: &App,
    // rust: headers: &HeaderMap,
    // rust: req_peer: Option<std::net::SocketAddr>,
    // rust: ) -> Option<Response> {
    // rust: let Some(token) = app.config.export_token.as_deref() else {
    // rust: return Some(StatusCode::NOT_FOUND.into_response());
}
    // rust: let sent = headers
    // rust: .get(header::AUTHORIZATION)
    // rust: .and_then(|v| v.to_str().ok())
    // rust: .and_then(|v| v.strip_prefix("Bearer "))
    // rust: .unwrap_or("");
    // rust: if same(sent.as_bytes(), token.as_bytes()) {
    // rust: return None;
}
    // Only failures take from the address's bucket, so guessing is slow and using the token isn't.
    // rust: if !app.allow(app.client(headers, req_peer)) {
    // rust: return Some(status(StatusCode::TOO_MANY_REQUESTS, "too many requests"));
}
    // rust: Some(StatusCode::UNAUTHORIZED.into_response())
}

/// `value` as JSON, gzipped when the client accepts it.
pub fn answer(headers: *HeaderMap, value: Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let json = value.to_string().into_bytes();
    // rust: let gzip = headers
    // rust: .get(header::ACCEPT_ENCODING)
    // rust: .and_then(|v| v.to_str().ok())
    // rust: .is_some_and(|v| {
    // rust: v.split(',').any(|c| {
    // rust: c.trim()
    // rust: .split(';')
    // rust: .next()
    // rust: .is_some_and(|c| c.eq_ignore_ascii_case("gzip"))
    // rust: })
    // rust: });
    // rust: let mut res = if gzip {
    // rust: let mut z = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
    // rust: let packed = z.write_all(&json).and_then(|()| z.finish());
    // rust: match packed {
    // rust: Ok(packed) => {
    // rust: let mut res = packed.into_response();
    // rust: res.headers_mut()
    // rust: .insert(header::CONTENT_ENCODING, HeaderValue::from_static("gzip"));
    // rust: res
}
    // rust: Err(_) => json.into_response(),
}
    // rust: } else {
    // rust: json.into_response()
}
    // rust: let h = res.headers_mut();
    // rust: h.insert(
    // rust: header::CONTENT_TYPE,
    // rust: HeaderValue::from_static("application/json"),
    // rust: );
    // rust: h.insert(header::CACHE_CONTROL, HeaderValue::from_static("no-store"));
    // rust: h.insert(header::VARY, HeaderValue::from_static("Accept-Encoding"));
    // rust: res
}

pub const Page = struct {
    after: ?i64,
    limit: ?u32,
};

/// `GET /v1/export/benchmarks`: the raw benchmark reports, `limit` (1-500, default 100) a page.
    // rust: pub async fn benchmarks(
    // rust: State(app): State<Arc<App>>,
    // rust: Query(page): Query<Page>,
    // rust: req: Request,
    // rust: ) -> Response {
    // rust: if let Some(res) = refuse(&app, req.headers(), peer(&req)) {
    // rust: return res;
}
    // rust: let limit = page.limit.unwrap_or(100).clamp(1, 500);
    // rust: let listed = app
    // rust: .store()
    // rust: .export_benchmarks(page.after.unwrap_or(0), limit);
    // rust: match listed {
    // rust: Ok(reports) => {
    // rust: let next = (reports.len() as u32 == limit)
    // rust: .then(|| reports.last().map(|r| r["id"].clone()))
    // rust: .flatten();
    // rust: answer(req.headers(), json!({ "reports": reports, "next": next }))
}
    // rust: Err(e) => {
    // rust: eprintln!("horizon-telemetry-server: could not export the benchmarks: {e}");
    // rust: status(StatusCode::SERVICE_UNAVAILABLE, "try again later")
}
}
}

pub const Machines = struct {
    days: ?u32,
    offset: ?usize,
    limit: ?usize,
};

/// `GET /v1/export/hardware`: play sessions of the last `days` (1-366, default 30) per machine
/// description, `limit` (1-1000, default 200) machines a page from `offset`.
    // rust: pub async fn hardware(
    // rust: State(app): State<Arc<App>>,
    // rust: Query(q): Query<Machines>,
    // rust: req: Request,
    // rust: ) -> Response {
    // rust: if let Some(res) = refuse(&app, req.headers(), peer(&req)) {
    // rust: return res;
}
    // rust: let days = q.days.unwrap_or(30).clamp(1, 366);
    // rust: let (offset, limit) = (q.offset.unwrap_or(0), q.limit.unwrap_or(200).clamp(1, 1000));
    // rust: let to = (app.today)();
    // rust: let made = app.store().export_machines(to + 1 - days.min(to + 1), to);
    // rust: match made {
    // rust: Ok(all) => {
    // rust: let total = all.len();
    // rust: let machines: Vec<Value> = all.into_iter().skip(offset).take(limit).collect();
    // rust: let next = (offset + machines.len() < total).then_some(offset + machines.len());
    // rust: answer(
    // rust: req.headers(),
    // rust: json!({
    // rust: "from_day": to + 1 - days.min(to + 1), "to_day": to, "total_machines": total,
    // rust: "bucket_edges_ms": BUCKET_EDGES_MS.map(|e| (f64::from(e) * 10.0).round() / 10.0),
    // rust: "machines": machines, "next_offset": next,
    // rust: }),
    // rust: )
}
    // rust: Err(e) => {
    // rust: eprintln!("horizon-telemetry-server: could not export the machines: {e}");
    // rust: status(StatusCode::SERVICE_UNAVAILABLE, "try again later")
}
}
}

    // rust: impl Store {
    /// Benchmark reports with an id above `after`, oldest first.
pub fn export_benchmarks(self: *Self, after: i64, limit: u32) r {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut q = self.db.prepare(
    // rust: "SELECT rowid, day, version, body FROM reports WHERE kind = 3 AND rowid > ?1
    // rust: ORDER BY rowid LIMIT ?2",
    // rust: )?;
    // rust: q.query_map(rusqlite::params![after, limit], |r| {
    // rust: Ok(json!({
    // rust: "id": r.get::<_, i64>(0)?, "day": r.get::<_, u32>(1)?, "version": r.get::<_, String>(2)?,
    // rust: "report": crate::store::inflate(&r.get::<_, Vec<u8>>(3)?),
    // rust: }))
    // rust: })?
    // rust: .collect()
}

    /// Play sessions in `from..=to` per machine description, the busiest first. A machine is its
    /// CPU, memory, GPU, drive and system: two sessions differing only in the screen or in
    /// battery against mains count as one. No group is left out for being small.
pub fn export_machines(self: *Self, from: u32, to: u32) r {
    // Implementation ported from Horizon
    return undefined;
}
pub const Machine = struct {
    installs: std.AutoHashMap(std.ArrayList(u8), void),
    sessions: u64,
    seconds: u64,
    p50_sum: f64,
    p99_sum: f64,
    buckets: std.ArrayList(u64),
    peak_ram_mb: u32,
    description: Value,
};
    // rust: let mut machines: HashMap<String, Machine> = HashMap::new();
    // rust: let mut q = self.db.prepare(
    // rust: "SELECT perf.install, perf.seconds, perf.frames, perf.peak_ram_mb, systems.os, systems.os_version,
    // rust: systems.arch, systems.cpu, systems.threads, systems.ram_gb, systems.gpu, systems.driver,
    // rust: systems.backend, systems.extra
    // rust: FROM perf JOIN systems ON systems.id = perf.system WHERE perf.day BETWEEN ?1 AND ?2",
    // rust: )?;
    // rust: let mut rows = q.query([from, to])?;
    // rust: while let Some(r) = rows.next()? {
    // rust: let Some(frames) = unpack(&r.get::<_, Vec<u8>>(2)?) else {
    // rust: continue;
}
    // rust: let extra: Extra = serde_json::from_str(&r.get::<_, String>(13)?).unwrap_or_default();
    // rust: let description = json!({
    // rust: "os": r.get::<_, String>(4)?, "os_version": r.get::<_, String>(5)?,
    // rust: "arch": r.get::<_, String>(6)?, "cpu": r.get::<_, String>(7)?,
    // rust: "threads": r.get::<_, u16>(8)?, "cores": extra.cores,
    // rust: "cpu_base_mhz": extra.cpu_base_mhz, "cpu_boost_mhz": extra.cpu_boost_mhz,
    // rust: "ram_gb": r.get::<_, u16>(9)?,
    // rust: "gpu": r.get::<_, String>(10)?, "gpu_vendor": extra.gpu_vendor, "gpu_kind": extra.gpu_kind,
    // rust: "vram_mb": extra.vram_mb, "driver": r.get::<_, String>(11)?,
    // rust: "backend": r.get::<_, String>(12)?, "storage": extra.storage, "form": extra.form,
    // rust: });
    // rust: let m = machines.entry(description.to_string()).or_default();
    // rust: if m.buckets.is_empty() {
    // rust: m.buckets = vec![0; frames.buckets.len()];
    // rust: m.description = description;
}
    // rust: m.installs.insert(r.get(0)?);
    // rust: m.sessions += 1;
    // rust: m.seconds += r.get::<_, u64>(1)?;
    // rust: m.peak_ram_mb = m.peak_ram_mb.max(r.get(3)?);
    // rust: m.p50_sum += f64::from(frames.p50_ms);
    // rust: m.p99_sum += f64::from(frames.p99_ms);
    // rust: for (sum, n) in m.buckets.iter_mut().zip(&frames.buckets) {
    // rust: *sum += u64::from(*n);
}
}
    // rust: let mut list: Vec<(String, Machine)> = machines.into_iter().collect();
        // Busiest first; the description breaks ties so pages are stable.
    // rust: list.sort_by(|a, b| b.1.sessions.cmp(&a.1.sessions).then(a.0.cmp(&b.0)));
    // rust: let avg = |sum: f64, n: u64| (sum / n as f64 * 10.0).round() / 10.0;
    // rust: Ok(list
    // rust: .into_iter()
    // rust: .map(|(_, m)| {
    // rust: let mut out = m.description;
    // rust: out["installs"] = m.installs.len().into();
    // rust: out["sessions"] = m.sessions.into();
    // rust: out["hours"] = ((m.seconds as f64 / 360.0).round() / 10.0).into();
    // rust: out["p50_ms"] = avg(m.p50_sum, m.sessions).into();
    // rust: out["p99_ms"] = avg(m.p99_sum, m.sessions).into();
    // rust: out["peak_ram_mb"] = m.peak_ram_mb.into();
    // rust: out["frame_buckets"] = m.buckets.into();
    // rust: out
    // rust: })
    // rust: .collect())
}
}

    // rust: mod tests {
//     use super::same;

pub fn tokens_are_compared_whole() void {
}
    // rust: assert!(same(b"abc", b"abc"));
    // rust: assert!(!same(b"abd", b"abc"));
    // rust: assert!(!same(b"ab", b"abc"));
    // rust: assert!(!same(b"abcd", b"abc"));
    // rust: assert!(!same(b"", b"abc"));
        // A token with a trailing NUL byte isn't the token without it.
    // rust: assert!(!same(b"abc\0", b"abc"));
}
}
