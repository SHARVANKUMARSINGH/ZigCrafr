//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry-server_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The ingest server for opt-in data collection (docs/telemetry.md).
//!
//! - `POST /v1/batch`: a zstd batch from the launcher, checked by `horizon_telemetry::batch`.
//! - `DELETE /v1/installs/<id>`: everything an install sent goes.
//! - `GET /v1/aggregate?days=30`: the anonymous totals the website reads, cached.
//! - `GET /v1/benchmarks/summary`: players' benchmark results grouped by GPU and CPU, groups of at
//!   least 3 installs only (`summary`), cached; the website's Benchmarks page reads it.
//! - `GET /v1/export/benchmarks` and `/v1/export/hardware`: raw benchmark reports and per-machine
//!   totals for the perf work, behind a bearer token (`export`); off without one.
//! - `POST /v1/live`: a game's anonymous "I'm playing" ping (`live`, in memory only).
//! - `GET /v1/live`: how many play now, exactly, cached briefly.
//! - `GET /v1/live/history?range=24h|7d|30d|all&series=players|official`: that count, or the
//!   official server's (its status ping), over time, written down once a minute (`history`:
//!   totals only), cached a minute.
//! - `/hub/…`: the hub's votes (`hub`) and bug reports (`intake`).
//! - `GET /healthz`.
//!
//! Abuse limits: a token bucket per IP address (kept in memory for an hour, never stored), a
//! daily item cap per install, and the batch size limits. The live count has its own, larger
//! bucket per address (several players can share one) and a cap on the sessions it holds. Raw
//! rows expire after `retention_days`; the daily totals stay. One small process and one SQLite
//! file: see `README.md` for running it.
// use std::collections::HashMap;
// use std::hash::{Hash, RandomState};
// use std::net::{IpAddr, SocketAddr};
// use std::sync::{Arc, Mutex};
// use std::time::{Duration, Instant};

// use axum::Router;
// use axum::extract::{ConnectInfo, Path, Query, Request, State};
// use axum::http::{HeaderMap, HeaderValue, StatusCode, header};
// use axum::response::{IntoResponse, Response};
// use axum::routing::{delete, get, post};
// use horizon_telemetry::batch;

    // rust: pub mod classes;
    // rust: pub mod export;
    // rust: pub mod github;
    // rust: pub mod history;
    // rust: pub mod hub;
    // rust: pub mod intake;
    // rust: pub mod live;
    // rust: pub mod store;
    // rust: pub mod summary;

// use github::Filer;
// use horizon_telemetry::live::{MAX_PING_BYTES, Ping};
// use live::Live;
// use store::Store;

pub const Config = struct {
    /// Days raw rows are kept.
    retention_days: u32,
    /// Groups in the public totals need at least this many install-days.
    min_install_days: u64,
    /// Requests an IP address may make an hour (with a burst of a tenth of it).
    requests_per_hour: f64,
    /// Items one install may send a day.
    items_per_day: u32,
    /// Behind a proxy (Railway, Fly…): the client's address is read from `client_ip_header`.
    trust_proxy: bool,
    /// The one header the proxy in front sets to the client's address, overwriting whatever the
    /// client sent (`HORIZON_TELEMETRY_CLIENT_IP_HEADER`, e.g. `x-real-ip` on Railway). Its last
    /// comma-separated entry is used. Read only with `trust_proxy`; without it the TCP peer counts,
    /// which behind a proxy is the proxy, so every client shares one bucket (the server warns at
    /// start).
    client_ip_header: ?[]const u8,
    /// The website allowed to read the totals from a browser.
    allow_origin: []const u8,
    /// Live count requests (pings and reads) an IP address may make an hour, with a burst of a
    /// tenth of it. A game pings once a minute, so the default lets ten play behind one address.
    live_per_hour: f64,
    /// How long a session counts after its last ping.
    live_window: Duration,
    /// Sessions the live count holds at most; a new one past that is refused.
    live_max_sessions: usize,
    /// Days the live count's minute samples are kept (`history`).
    live_minute_days: u32,
    /// Days its hourly totals are kept; at least 31, for the 30-day view. Daily ones stay.
    live_hour_days: u32,
    /// The official server, asked for its player count every minute (`history`'s `official`
    /// series); None asks nothing.
    official_server: ?[]const u8,
    /// The hub's votes and reads of their counts an IP address may make an hour.
    hub_per_hour: f64,
    /// Bug reports an IP address may send an hour.
    hub_posts_per_hour: f64,
    /// Bug reports taken a day, from everyone: each one opens a GitHub issue.
    hub_reports_per_day: u32,
    /// Days reports are kept (opened as issues long before).
    hub_keep_days: u32,
    /// The bearer token the protected export (`export`) wants; unset, it answers 404.
    export_token: ?[]const u8,
    /// Opens the website's bug reports as issues; unset, `POST /hub/report` answers 503.
    github_token: ?[]const u8,
    /// Where those issues go, `owner/name`.
    github_repo: []const u8,
    /// `GET /v1/aggregate` and `/v1/benchmarks/summary` requests an IP address may make an hour (with a
    /// burst of a tenth of it): website visitors' browsers read them.
    reads_per_hour: f64,
    /// Totals built (cache misses of `/v1/aggregate`) an hour, from everyone: each one scans the window's
    /// daily totals on the blocking pool. Past it, a miss answers 503 until the bucket refills.
    aggregate_builds_per_hour: f64,
    /// The `days` values `/v1/aggregate` answers (`HORIZON_TELEMETRY_AGGREGATE_DAYS=7,30,90,366`); others
    /// get 400. None (unset) takes any value from 1 to 366, as before.
    aggregate_days: ?std.ArrayList(u32),
};

    // rust: impl Default for Config {
pub fn default() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: retention_days: 180,
    // rust: min_install_days: 5,
    // rust: requests_per_hour: 60.0,
    // rust: items_per_day: 100,
    // rust: trust_proxy: false,
    // rust: client_ip_header: None,
    // rust: allow_origin: "https://playhorizon.dev".into(),
    // rust: live_per_hour: 600.0,
    // rust: live_window: horizon_telemetry::live::WINDOW,
    // rust: live_max_sessions: 200_000,
    // rust: live_minute_days: 7,
    // rust: live_hour_days: 90,
    // rust: official_server: Some(horizon_telemetry::server_status::OFFICIAL_STATUS_ADDRESS.into()),
    // rust: hub_per_hour: 600.0,
    // rust: hub_posts_per_hour: 20.0,
    // rust: hub_reports_per_day: 30,
    // rust: hub_keep_days: 90,
    // rust: export_token: None,
    // rust: github_token: None,
    // rust: github_repo: "horizon-rust/horizon".into(),
    // rust: reads_per_hour: 600.0,
    // rust: aggregate_builds_per_hour: 600.0,
    // rust: aggregate_days: None,
}
}
}

    // rust: impl Config {
    /// The defaults, with `HORIZON_TELEMETRY_RETENTION_DAYS`, `…_MIN_INSTALL_DAYS`,
    /// `…_REQUESTS_PER_HOUR`, `…_ITEMS_PER_DAY`, `…_TRUST_PROXY` (1), `…_ALLOW_ORIGIN`,
    /// `…_LIVE_PER_HOUR`, `…_LIVE_WINDOW_SECONDS`, `…_LIVE_MAX_SESSIONS`, `…_LIVE_MINUTE_DAYS`,
    /// `…_LIVE_HOUR_DAYS`, `…_OFFICIAL_SERVER` (`off` for none), `…_HUB_PER_HOUR`,
    /// `…_HUB_POSTS_PER_HOUR`, `…_HUB_REPORTS_PER_DAY`, `…_HUB_KEEP_DAYS`, `…_GITHUB_TOKEN`,
    /// `…_GITHUB_REPO`, `…_READS_PER_HOUR`, `…_AGGREGATE_BUILDS_PER_HOUR` and `…_AGGREGATE_DAYS`, plus `TELEMETRY_EXPORT_TOKEN` (or `HORIZON_TELEMETRY_EXPORT_TOKEN`) for the
    /// protected export. An empty token counts as unset.
pub fn from_env() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let var = |k: &str| std::env::var(format!("HORIZON_TELEMETRY_{k}")).ok();
    // rust: let secret = |k: &str| {
    // rust: var(k)
    // rust: .map(|v| v.trim().to_owned())
    // rust: .filter(|v| !v.is_empty())
}
    // rust: let d = Self::default();
    // rust: Self {
    // rust: retention_days: var("RETENTION_DAYS")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.retention_days),
    // rust: min_install_days: var("MIN_INSTALL_DAYS")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.min_install_days),
    // rust: requests_per_hour: var("REQUESTS_PER_HOUR")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.requests_per_hour),
    // rust: items_per_day: var("ITEMS_PER_DAY")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.items_per_day),
    // rust: trust_proxy: var("TRUST_PROXY").is_some_and(|v| v == "1"),
    // rust: client_ip_header: var("CLIENT_IP_HEADER").and_then(|v| header_name(&v)),
    // rust: allow_origin: var("ALLOW_ORIGIN").unwrap_or(d.allow_origin),
    // rust: live_per_hour: var("LIVE_PER_HOUR")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.live_per_hour),
    // rust: live_window: var("LIVE_WINDOW_SECONDS")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .map_or(d.live_window, Duration::from_secs),
    // rust: live_max_sessions: var("LIVE_MAX_SESSIONS")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.live_max_sessions),
    // rust: live_minute_days: var("LIVE_MINUTE_DAYS")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.live_minute_days),
    // rust: live_hour_days: var("LIVE_HOUR_DAYS")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.live_hour_days),
    // rust: official_server: match var("OFFICIAL_SERVER").as_deref().map(str::trim) {
    // rust: Some("" | "off") => None,
    // rust: Some(address) => Some(address.to_owned()),
    // rust: None => d.official_server,
    // rust: },
    // rust: hub_per_hour: var("HUB_PER_HOUR")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.hub_per_hour),
    // rust: hub_posts_per_hour: var("HUB_POSTS_PER_HOUR")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.hub_posts_per_hour),
    // rust: hub_reports_per_day: var("HUB_REPORTS_PER_DAY")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.hub_reports_per_day),
    // rust: hub_keep_days: var("HUB_KEEP_DAYS")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.hub_keep_days),
    // rust: export_token: std::env::var("TELEMETRY_EXPORT_TOKEN")
    // rust: .ok()
    // rust: .map(|v| v.trim().to_owned())
    // rust: .filter(|v| !v.is_empty())
    // rust: .or_else(|| secret("EXPORT_TOKEN")),
    // rust: github_token: secret("GITHUB_TOKEN"),
    // rust: github_repo: var("GITHUB_REPO").unwrap_or(d.github_repo),
    // rust: reads_per_hour: var("READS_PER_HOUR")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.reads_per_hour),
    // rust: aggregate_builds_per_hour: var("AGGREGATE_BUILDS_PER_HOUR")
    // rust: .and_then(|v| v.parse().ok())
    // rust: .unwrap_or(d.aggregate_builds_per_hour),
    // rust: aggregate_days: var("AGGREGATE_DAYS").and_then(|v| parse_days(&v)),
}
}
}

/// A header name as `HORIZON_TELEMETRY_CLIENT_IP_HEADER` gives it, lowercase; None when empty or not
/// a header name.
pub fn header_name(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = text.trim().to_ascii_lowercase();
    // rust: (!name.is_empty() && axum::http::HeaderName::from_bytes(name.as_bytes()).is_ok())
    // rust: .then_some(name)
}

    // rust: impl Config {
    /// Why the client-address settings can't run, when they can't: `TRUST_PROXY=1` without the header
    /// would count every client as the proxy, one shared bucket, which stops intake and refuses
    /// players' deletion requests. `main.rs` refuses to start then, as the relay does without
    /// `RELAY_PROXY_FROM`, so a deployment missing the setting fails its health check instead of
    /// going live.
pub fn client_ip_refusal(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.trust_proxy && self.client_ip_header.is_none()).then(|| {
    // rust: "HORIZON_TELEMETRY_TRUST_PROXY=1 needs HORIZON_TELEMETRY_CLIENT_IP_HEADER, the header your proxy \
    // rust: overwrites with the client's address (x-real-ip on Railway, as the Dockerfile sets): without it \
    // rust: every client would count as the proxy and share one rate-limit bucket. Not starting."
    // rust: .into()
    // rust: })
}

    /// What the client-address settings will do, when it isn't what they seem to ask for: printed at
    /// start (`main.rs`).
pub fn client_ip_warning(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (self.trust_proxy, &self.client_ip_header) {
    // rust: (false, Some(name)) => Some(format!(
    // rust: "HORIZON_TELEMETRY_CLIENT_IP_HEADER={name} is ignored without HORIZON_TELEMETRY_TRUST_PROXY=1: \
    // rust: rate limits count the TCP peer"
    // rust: )),
    // rust: _ => None,
}
}
}

/// `7,30,90,366` as the `days` `/v1/aggregate` answers: None when empty or when any value isn't a
/// number from 1 to 366 (then every value is taken, and the server says so at start).
pub fn parse_days(text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let days: Option<Vec<u32>> = text
    // rust: .split(',')
    // rust: .map(str::trim)
    // rust: .filter(|d| !d.is_empty())
    // rust: .map(|d| d.parse().ok().filter(|d| (1..=366).contains(d)))
    // rust: .collect();
    // rust: days.filter(|d| !d.is_empty())
}

pub const App = struct {
    store: Mutex<Store>,
    config: Config,
    /// Tokens left and when they were counted, per client address.
    buckets: Mutex<Buckets>,
    /// The same for the live count's requests.
    live_buckets: Mutex<Buckets>,
    /// The same for the website's reads of the totals.
    read_buckets: Mutex<Buckets>,
    /// Totals built from the database, from everyone (`aggregate_builds_per_hour`).
    builds: Mutex<HashMap<(),
    /// Who is playing now (`live`).
    live: Mutex<Live>,
    /// `GET /v1/live`'s answer and when it was made.
    live_cache: Mutex<Option<(Instant,
    /// `GET /v1/live/history`'s answers by range, with when they were made.
    history_cache: Mutex<HashMap<(history::Series,
    /// When the server started: the live count is whole only a window later.
    started: Instant,
    /// `/v1/aggregate` answers by `days`, with when they were made.
    cache: Mutex<HashMap<u32,
    /// `/v1/benchmarks/summary`'s answer and when it was made.
    summary_cache: Mutex<Option<(Instant,
    /// Today, in days since 1970 (a test moves it).
    today: *dyn Fn() - u32 + Send + Sync>,
    /// The key the hub's buckets hash addresses with, drawn at start and never stored.
    hub_key: RandomState,
    /// The hub's votes and vote counts, per hashed address.
    hub_buckets: Mutex<hub::HashedBuckets>,
    /// The hub's bug reports, per hashed address.
    hub_post_buckets: Mutex<hub::HashedBuckets>,
    /// `GET /hub/votes`'s answer and when it was made.
    votes_cache: Mutex<Option<(Instant,
    /// Opens bug reports as GitHub issues; None without a token.
    filer: ?*Filer,
};

    // rust: type Buckets = HashMap<IpAddr, (f64, Instant)>;

pub const CACHE_FOR: Duration = Duration::from_secs(600);

pub fn status(code: StatusCode, message: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (code, message.to_owned()).into_response()
}

    // rust: impl App {
pub fn new(store: Store, config: Config) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_clock(store, config, Box::new(horizon_telemetry::today))
}

    // rust: pub fn with_clock(
    // rust: store: Store,
    // rust: config: Config,
    // rust: today: Box<dyn Fn() -> u32 + Send + Sync>,
    // rust: ) -> Arc<Self> {
    // rust: let filer = config
    // rust: .github_token
    // rust: .clone()
    // rust: .map(|token| Arc::from(github::github(config.github_repo.clone(), token)));
    // rust: Self::with_filer(store, config, today, filer)
}

    /// [`Self::with_clock`] with the hub's bug reports opened by `filer` (tests give their own).
    // rust: pub fn with_filer(
    // rust: store: Store,
    // rust: config: Config,
    // rust: today: Box<dyn Fn() -> u32 + Send + Sync>,
    // rust: filer: Option<Arc<Filer>>,
    // rust: ) -> Arc<Self> {
    // rust: let live = Live::new(config.live_window, config.live_max_sessions);
    // rust: Arc::new(Self {
    // rust: store: Mutex::new(store),
    // rust: config,
    // rust: buckets: Mutex::default(),
    // rust: live_buckets: Mutex::default(),
    // rust: read_buckets: Mutex::default(),
    // rust: builds: Mutex::default(),
    // rust: live: Mutex::new(live),
    // rust: live_cache: Mutex::default(),
    // rust: history_cache: Mutex::default(),
    // rust: started: Instant::now(),
    // rust: cache: Mutex::default(),
    // rust: summary_cache: Mutex::default(),
    // rust: today,
    // rust: hub_key: RandomState::new(),
    // rust: hub_buckets: Mutex::default(),
    // rust: hub_post_buckets: Mutex::default(),
    // rust: votes_cache: Mutex::default(),
    // rust: filer,
    // rust: })
}

pub fn store(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.store.lock().unwrap_or_else(|e| e.into_inner())
}

    /// Takes a token for `ip`; false when it has none left.
pub fn allow(self: *Self, ip: IpAddr) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: take(&self.buckets, self.config.requests_per_hour, ip)
}

    /// [`Self::allow`] for the live count's requests.
pub fn allow_live(self: *Self, ip: IpAddr) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: take(&self.live_buckets, self.config.live_per_hour, ip)
}

    /// [`Self::allow`] for the website's reads of the totals.
pub fn allow_read(self: *Self, ip: IpAddr) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: take(&self.read_buckets, self.config.reads_per_hour, ip)
}

    /// One more totals build from the database, from everyone; false past the hour's budget.
pub fn allow_build(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: take(&self.builds, self.config.aggregate_builds_per_hour, ())
}

    /// Checks and stores one batch's body (inflating it, then SQLite): blocking, so it runs on the
    /// blocking pool ([`blocking`]).
pub fn store_batch(self: *Self, body: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let batch = match batch::decode(body) {
    // rust: Ok(batch) => batch,
    // rust: Err(e) => return status(StatusCode::BAD_REQUEST, &e),
}
    // rust: let today = (self.today)();
    // rust: let install = store::install_key(&batch.install_id).unwrap_or_default();
    // rust: let mut store = self.store();
    // rust: let sent = store.count_on(&install, today).unwrap_or(u32::MAX);
    // rust: if sent.saturating_add(batch.items.len() as u32) > self.config.items_per_day {
    // rust: return status(
    // rust: StatusCode::TOO_MANY_REQUESTS,
    // rust: "this install's daily limit is reached",
    // rust: );
}
    // rust: match store.insert(&batch, today) {
    // rust: Ok(()) => StatusCode::NO_CONTENT.into_response(),
    // rust: Err(e) => {
    // rust: eprintln!("horizon-telemetry-server: could not store a batch: {e}");
    // rust: status(StatusCode::SERVICE_UNAVAILABLE, "try again later")
}
}
}

pub fn live(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.live.lock().unwrap_or_else(|e| e.into_inner())
}

    /// The address requests are counted under, for the rate limits only: kept in memory, never
    /// stored or logged. Behind a proxy (Railway) the TCP peer is the proxy, so with `trust_proxy`
    /// it is the last entry of the one configured header (`client_ip_header`), which the proxy
    /// overwrites. No other header is read: which one a client can't forge depends on the platform.
    /// An IPv6 client counts by its /64.
pub fn client(self: *Self, headers: *HeaderMap, peer: ?SocketAddr) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let forwarded = self
    // rust: .config
    // rust: .client_ip_header
    // rust: .as_deref()
    // rust: .filter(|_| self.config.trust_proxy)
    // rust: .and_then(|name| headers.get(name)?.to_str().ok())
    // rust: .and_then(|value| value.rsplit(',').next()?.trim().parse().ok());
    // rust: rate_key(
    // rust: forwarded
    // rust: .or(peer.map(|p| p.ip()))
    // rust: .unwrap_or(IpAddr::from([0, 0, 0, 0])),
    // rust: )
}

    /// The day an install's newest row came in, if it has any left.
pub fn newest_day(self: *Self, install: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.store().newest_day(install).ok().flatten()
}

    /// Drops the cached public answers (after a deletion or expiry).
pub fn forget_cached(self: *Self) void {
}
    // rust: self.cache.lock().unwrap_or_else(|e| e.into_inner()).clear();
    // rust: *self.summary_cache.lock().unwrap_or_else(|e| e.into_inner()) = None;
}

    /// Writes down the live count as this minute's (`history`), once the server has run a whole
    /// window: before that, games that play haven't all pinged it yet. True when it did.
pub fn record_live(self: *Self) r {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.started.elapsed() < self.config.live_window {
    // rust: return Ok(false);
}
    // rust: let count = self.live().count(Instant::now());
    // rust: self.record_sample(
    // rust: history::Series::Players,
    // rust: unix_now(),
    // rust: &history::Sample::of(&count),
    // rust: )
}

    /// Asks the official server for its player count (a status ping, blocking, at most 5 seconds
    /// a step) and writes it down as this minute's. False when there is no official server or it
    /// didn't answer: that minute stays empty.
pub fn record_official(self: *Self) r {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(address) = &self.config.official_server else {
    // rust: return Ok(false);
}
    // rust: let unix = unix_now();
    // rust: match horizon_telemetry::server_status::players(address, Duration::from_secs(5)) {
    // rust: Ok(players) => {
    // rust: let sample = history::Sample {
    // rust: playing: players.online,
    // rust: ..history::Sample::default()
}
    // rust: self.record_sample(history::Series::Official, unix, &sample)
}
    // rust: Err(_) => Ok(false),
}
}

    /// Writes down `sample` as `series`' count of the minute holding `unix` (seconds). False when
    /// that minute has one already.
    // rust: pub fn record_sample(
    // rust: &self,
    // rust: series: history::Series,
    // rust: unix: i64,
    // rust: sample: &history::Sample,
    // rust: ) -> rusqlite::Result<bool> {
    // rust: self.store().record_live(series, unix, sample)
}

    /// Daily upkeep: totals rebuilt, expired rows removed, idle rate-limit entries and live
    /// sessions forgotten, the hub's old reports removed. Reports still waiting for
    /// their issue are [`Self::file_pending`]'s.
pub fn maintain(self: *Self) r {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let oldest = (self.today)().saturating_sub(self.config.retention_days);
    // rust: let removed = self.store().expire(oldest)?;
    // rust: self.expire_intake()?;
    // rust: self.forget_hub_buckets();
    // rust: for buckets in [&self.buckets, &self.live_buckets, &self.read_buckets] {
    // rust: buckets
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .retain(|_, (_, at)| at.elapsed() < Duration::from_secs(3600));
}
    // rust: self.live().forget_expired(Instant::now());
    // rust: self.store().prune_live(
    // rust: unix_now(),
    // rust: self.config.live_minute_days,
    // rust: self.config.live_hour_days.max(31),
    // rust: )?;
    // rust: if removed > 0 {
    // rust: self.forget_cached();
}
    // rust: Ok(removed)
}
}

/// Takes a token for `key` from its bucket in `buckets` (`per_hour`, bursts of a tenth of it);
/// false when it has none left.
    // rust: fn take<K: Hash + Eq>(buckets: &Mutex<HashMap<K, (f64, Instant)>>, per_hour: f64, key: K) -> bool {
    // rust: let rate = per_hour / 3600.0;
    // rust: let burst = (per_hour / 10.0).max(1.0);
    // rust: let mut buckets = buckets.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let now = Instant::now();
    // rust: let (tokens, at) = buckets.entry(key).or_insert((burst, now));
    // rust: *tokens = (*tokens + now.duration_since(*at).as_secs_f64() * rate).min(burst);
    // rust: *at = now;
    // rust: if *tokens < 1.0 {
    // rust: return false;
}
    // rust: *tokens -= 1.0;
    // rust: true
}

/// The address a client's requests count under: IPv4 (an IPv4-mapped IPv6 address as IPv4 too),
/// or an IPv6 address's /64, which one home or host holds whole, so addresses rotated inside it
/// don't get fresh buckets.
pub fn rate_key(ip: IpAddr) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match ip {
    // rust: IpAddr::V6(v6) => match v6.to_ipv4_mapped() {
    // rust: Some(v4) => IpAddr::V4(v4),
    // rust: None => {
    // rust: let s = v6.segments();
    // rust: IpAddr::V6(std::net::Ipv6Addr::new(s[0], s[1], s[2], s[3], 0, 0, 0, 0))
}
    // rust: },
    // rust: v4 => v4,
}
}

/// Runs `f` on tokio's blocking pool: SQLite calls (and the work around them) block, and the server
/// has two async workers, so two slow calls on them would stall every handler, `/healthz` included.
/// A task that panicked answers 503.
    // rust: pub async fn blocking<T: Send + 'static>(
    // rust: app: &Arc<App>,
    // rust: f: impl FnOnce(&App) -> T + Send + 'static,
    // rust: ) -> Result<T, Box<Response>> {
    // rust: let app = app.clone();
    // rust: tokio::task::spawn_blocking(move || f(&app))
    // rust: .await
    // rust: .map_err(|e| {
    // rust: eprintln!("horizon-telemetry-server: a blocking task failed: {e}");
    // rust: Box::new(status(StatusCode::SERVICE_UNAVAILABLE, "try again later"))
    // rust: })
}

pub fn peer(req: *Request) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: req.extensions()
    // rust: .get::<ConnectInfo<SocketAddr>>()
    // rust: .map(|c| c.0)
}

pub fn receive() void {
}
    // rust: let ip = app.client(req.headers(), peer(&req));
    // rust: if !app.allow(ip) {
    // rust: return status(StatusCode::TOO_MANY_REQUESTS, "too many requests");
}
    // rust: let zstd = req
    // rust: .headers()
    // rust: .get(header::CONTENT_ENCODING)
    // rust: .is_some_and(|v| v.as_bytes().eq_ignore_ascii_case(b"zstd"));
    // rust: if !zstd {
    // rust: return status(
    // rust: StatusCode::UNSUPPORTED_MEDIA_TYPE,
    // rust: "send zstd (Content-Encoding: zstd)",
    // rust: );
}
    // rust: let Ok(body) = axum::body::to_bytes(req.into_body(), batch::MAX_COMPRESSED).await else {
    // rust: return status(StatusCode::PAYLOAD_TOO_LARGE, "a batch is at most 256 KiB");
}
    // rust: blocking(&app, move |app| app.store_batch(&body))
    // rust: .await
    // rust: .unwrap_or_else(|r| *r)
}

pub fn forget() void {
}
    // rust: if !app.allow(app.client(req.headers(), peer(&req))) {
    // rust: return status(StatusCode::TOO_MANY_REQUESTS, "too many requests");
}
    // rust: let Some(install) = store::install_key(&id) else {
    // rust: return status(StatusCode::BAD_REQUEST, "not an install ID");
}
    // rust: let deleted = match blocking(&app, move |app| app.store().delete_install(&install)).await {
    // rust: Ok(deleted) => deleted,
    // rust: Err(response) => return *response,
}
    // rust: match deleted {
        // Nothing of that install: the cached totals still hold, so a made-up ID costs no rebuild.
    // rust: Ok(0) => StatusCode::NO_CONTENT.into_response(),
    // rust: Ok(_) => {
    // rust: app.forget_cached();
    // rust: StatusCode::NO_CONTENT.into_response()
}
    // rust: Err(e) => {
    // rust: eprintln!("horizon-telemetry-server: could not delete an install: {e}");
    // rust: status(StatusCode::SERVICE_UNAVAILABLE, "try again later")
}
}
}

pub const Window = struct {
    days: ?u32,
};

    // rust: async fn aggregate(
    // rust: State(app): State<Arc<App>>,
    // rust: Query(window): Query<Window>,
    // rust: req: Request,
    // rust: ) -> Response {
    // rust: if !app.allow_read(app.client(req.headers(), peer(&req))) {
    // rust: return status(StatusCode::TOO_MANY_REQUESTS, "too many requests");
}
    // rust: let asked = window.days.unwrap_or(30);
    // rust: let days = match &app.config.aggregate_days {
    // rust: Some(allowed) if allowed.contains(&asked) => asked,
    // rust: Some(allowed) => {
    // rust: let list: Vec<String> = allowed.iter().map(u32::to_string).collect();
    // rust: return status(
    // rust: StatusCode::BAD_REQUEST,
    // rust: &format!("days: one of {}", list.join(", ")),
    // rust: );
}
    // rust: None => asked.clamp(1, 366),
}
    // rust: let cached = app
    // rust: .cache
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .get(&days)
    // rust: .filter(|(at, _)| at.elapsed() < CACHE_FOR)
    // rust: .map(|(_, json)| json.clone());
    // rust: let json = match cached {
    // rust: Some(json) => json,
    // rust: None => {
    // rust: if !app.allow_build() {
    // rust: return status(StatusCode::SERVICE_UNAVAILABLE, "try again in a minute");
}
    // rust: let made = blocking(&app, move |app| {
    // rust: let to = (app.today)();
    // rust: app.store()
    // rust: .aggregate(to + 1 - days.min(to + 1), to, app.config.min_install_days)
    // rust: .map(|value| value.to_string())
    // rust: })
    // rust: .await;
    // rust: match made {
    // rust: Ok(Ok(json)) => {
    // rust: app.cache
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .insert(days, (Instant::now(), json.clone()));
    // rust: json
}
    // rust: Ok(Err(e)) => {
    // rust: eprintln!("horizon-telemetry-server: could not build the totals: {e}");
    // rust: return status(StatusCode::SERVICE_UNAVAILABLE, "try again later");
}
    // rust: Err(response) => return *response,
}
}
}
    // rust: json_response(&app, json, CACHE_FOR.as_secs())
}

/// `GET /v1/benchmarks/summary`: players' benchmark groups (`summary`), made again at most every
/// ten minutes.
pub fn benchmarks() void {
}
    // rust: if !app.allow_read(app.client(req.headers(), peer(&req))) {
    // rust: return status(StatusCode::TOO_MANY_REQUESTS, "too many requests");
}
    // rust: let cached = app
    // rust: .summary_cache
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .as_ref()
    // rust: .filter(|(at, _)| at.elapsed() < CACHE_FOR)
    // rust: .map(|(_, json)| json.clone());
    // rust: let json = match cached {
    // rust: Some(json) => json,
    // rust: None => {
    // rust: let made = blocking(&app, |app| {
    // rust: let oldest = (app.today)().saturating_sub(app.config.retention_days);
    // rust: app.store().benchmark_uploads(oldest).map(|uploads| {
    // rust: summary::summary(&uploads, summary::MIN_INSTALLS, &utc_now()).to_string()
    // rust: })
    // rust: })
    // rust: .await;
    // rust: let json = match made {
    // rust: Ok(Ok(json)) => json,
    // rust: Ok(Err(e)) => {
    // rust: eprintln!("horizon-telemetry-server: could not read the benchmarks: {e}");
    // rust: return status(StatusCode::SERVICE_UNAVAILABLE, "try again later");
}
    // rust: Err(response) => return *response,
}
    // rust: *app.summary_cache.lock().unwrap_or_else(|e| e.into_inner()) =
    // rust: Some((Instant::now(), json.clone()));
    // rust: json
}
}
    // rust: json_response(&app, json, CACHE_FOR.as_secs())
}

/// Now in seconds since 1970.
pub fn unix_now() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs() as i64)
}

/// Now as `YYYY-MM-DDTHH:MM:SSZ`.
pub fn utc_now() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let secs = unix_now() as u64;
    // rust: let (days, rest) = (secs / 86_400, secs % 86_400);
    // Days since 1970 to a civil date (Howard Hinnant's algorithm).
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
    // rust: rest / 3600,
    // rust: rest / 60 % 60,
    // rust: rest % 60
    // rust: )
}

/// `POST /v1/live`: one "I'm playing". 204, or 400 for a bad ping, 413 for one too large, 429
/// over the address's limit, 503 when the table is full.
pub fn ping() void {
}
    // rust: if !app.allow_live(app.client(req.headers(), peer(&req))) {
    // rust: return status(StatusCode::TOO_MANY_REQUESTS, "too many requests");
}
    // rust: let Ok(body) = axum::body::to_bytes(req.into_body(), MAX_PING_BYTES).await else {
    // rust: return status(StatusCode::PAYLOAD_TOO_LARGE, "a ping is at most 512 bytes");
}
    // rust: let ping: Ping = match serde_json::from_slice(&body) {
    // rust: Ok(ping) => ping,
    // rust: Err(e) => return status(StatusCode::BAD_REQUEST, &e.to_string()),
}
    // rust: if let Err(e) = ping.check() {
    // rust: return status(StatusCode::BAD_REQUEST, e);
}
    // rust: match app.live().ping(&ping, Instant::now()) {
    // rust: Ok(()) => StatusCode::NO_CONTENT.into_response(),
    // rust: Err(live::Full) => status(StatusCode::SERVICE_UNAVAILABLE, "try again later"),
}
}

/// `GET /v1/live`: the exact live count (`horizon_telemetry::live::Count`), made again at
/// most every eighth of the window.
pub fn playing() void {
}
    // rust: if !app.allow_live(app.client(req.headers(), peer(&req))) {
    // rust: return status(StatusCode::TOO_MANY_REQUESTS, "too many requests");
}
    // rust: let fresh_for = app.config.live_window / 8;
    // rust: let json = {
    // rust: let mut cache = app.live_cache.lock().unwrap_or_else(|e| e.into_inner());
    // rust: match &*cache {
    // rust: Some((at, json)) if at.elapsed() < fresh_for => json.clone(),
    // rust: _ => {
    // rust: let json =
    // rust: serde_json::to_string(&app.live().count(Instant::now())).unwrap_or_default();
    // rust: *cache = Some((Instant::now(), json.clone()));
    // rust: json
}
}
}
    // rust: json_response(&app, json, fresh_for.as_secs())
}

pub const HistoryQuery = struct {
    range: ?[]const u8,
    series: ?[]const u8,
};

/// How long a history answer is reused: a new sample comes each minute.
pub const HISTORY_FOR: Duration = Duration::from_secs(60);

/// `GET /v1/live/history?range=24h|7d|30d|all&series=players|official` (default 24h, players):
/// the live count, or the official server's, over time (`history::History`), made again at most
/// every minute. 400 for another range or series.
    // rust: async fn live_history(
    // rust: State(app): State<Arc<App>>,
    // rust: Query(query): Query<HistoryQuery>,
    // rust: req: Request,
    // rust: ) -> Response {
    // rust: if !app.allow_live(app.client(req.headers(), peer(&req))) {
    // rust: return status(StatusCode::TOO_MANY_REQUESTS, "too many requests");
}
    // rust: let Some(range) = history::Range::parse(query.range.as_deref().unwrap_or("24h")) else {
    // rust: return status(StatusCode::BAD_REQUEST, "range: 24h, 7d, 30d or all");
}
    // rust: let Some(series) = history::Series::parse(query.series.as_deref().unwrap_or("players")) else {
    // rust: return status(StatusCode::BAD_REQUEST, "series: players or official");
}
    // rust: let cached = app
    // rust: .history_cache
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .get(&(series, range))
    // rust: .filter(|(at, _)| at.elapsed() < HISTORY_FOR)
    // rust: .map(|(_, json)| json.clone());
    // rust: let json = match cached {
    // rust: Some(json) => json,
    // rust: None => match blocking(&app, move |app| {
    // rust: app.store()
    // rust: .live_history(series, range, unix_now())
    // rust: .map(|history| serde_json::to_string(&history).unwrap_or_default())
    // rust: })
    // rust: .await
    // rust: {
    // rust: Ok(Ok(json)) => {
    // rust: app.history_cache
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .insert((series, range), (Instant::now(), json.clone()));
    // rust: json
}
    // rust: Ok(Err(e)) => {
    // rust: eprintln!("horizon-telemetry-server: could not read the live history: {e}");
    // rust: return status(StatusCode::SERVICE_UNAVAILABLE, "try again later");
}
    // rust: Err(response) => return *response,
    // rust: },
}
    // rust: json_response(&app, json, HISTORY_FOR.as_secs())
}

pub fn json_response(app: *App, json: []const u8, max_age: u64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let origin =
    // rust: HeaderValue::from_str(&app.config.allow_origin).unwrap_or(HeaderValue::from_static("*"));
    // rust: let cache = HeaderValue::from_str(&format!("public, max-age={max_age}"))
    // rust: .unwrap_or(HeaderValue::from_static("no-cache"));
    // rust: (
    // rust: [
    // rust: (
    // rust: header::CONTENT_TYPE,
    // rust: HeaderValue::from_static("application/json"),
    // rust: ),
    // rust: (header::CACHE_CONTROL, cache),
    // rust: (header::ACCESS_CONTROL_ALLOW_ORIGIN, origin),
    // rust: ],
    // rust: json,
    // rust: )
    // rust: .into_response()
}

pub fn router(app: *App) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Router::new()
    // rust: .route("/v1/batch", post(receive))
    // rust: .route("/v1/live", post(ping).get(playing))
    // rust: .route("/v1/live/history", get(live_history))
    // rust: .route("/v1/installs/{id}", delete(forget))
    // rust: .route("/v1/aggregate", get(aggregate))
    // rust: .route("/v1/benchmarks/summary", get(benchmarks))
    // rust: .route("/v1/export/benchmarks", get(export::benchmarks))
    // rust: .route("/v1/export/hardware", get(export::hardware))
    // rust: .route("/hub/vote", post(hub::vote).options(hub::preflight))
    // rust: .route("/hub/votes", get(hub::votes))
    // rust: .route("/hub/report", post(intake::report).options(hub::preflight))
    // rust: .route("/healthz", get(|| async { "ok" }))
    // rust: .with_state(app)
}

    // rust: mod tests {
//     use super::*;

pub fn ipv6_rates_count_by_64() void {
}
    // rust: let ip = |s: &str| s.parse::<IpAddr>().unwrap();
        // Rotated inside a /64: one key. Another /64: another key.
    // rust: assert_eq!(rate_key(ip("2001:db8::1")), rate_key(ip("2001:db8::99")));
    // rust: assert_ne!(rate_key(ip("2001:db8::1")), rate_key(ip("2001:db8:1::1")));
        // IPv4-mapped counts as the IPv4 it is.
    // rust: assert_eq!(
    // rust: rate_key(ip("::ffff:203.0.113.7")),
    // rust: IpAddr::from([203, 0, 113, 7])
    // rust: );
        // Plain IPv4 unchanged.
    // rust: assert_eq!(rate_key(ip("203.0.113.8")), IpAddr::from([203, 0, 113, 8]));
}
}
