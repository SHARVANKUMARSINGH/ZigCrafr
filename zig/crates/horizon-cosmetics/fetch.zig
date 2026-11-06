//! Transpiled from Horizon Rust crate
//! Module: horizon-cosmetics_fetch
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What players wear, from Horizon's cosmetics service: one batched request
//! for the players in view, answers cached for the service's TTL, item files
//! cached on disk by their hash. The work runs on a thread of its own; the
//! frame only reads the cache, and a service that doesn't answer leaves the
//! last answers in place and is asked again later, less and less often.
//! The last answers are also kept on disk (`worn.json`, beside the item
//! files), so a game started while the service is down still shows what
//! players last wore.
//!
//! Protocol (JSON over HTTPS):
//! - `POST /v1/worn` `{"players": ["<uuid hex>", …]}` (at most `BATCH`) answers
//!   `{"ttl": seconds, "players": {"<uuid hex>": [{"id", "hash"}, …]}, "horizon": ["<uuid hex>", …]}`;
//!   a player who wears nothing is left out of `players`, and `horizon` lists the batch's players
//!   who play Horizon (and let it say so).
//! - `GET /v1/items/<id>?hash=<hash>` answers the item file, which never
//!   changes for a hash.

// use crate::Item;
// use std::collections::{HashMap, HashSet};
// use std::path::PathBuf;
// use std::sync::{Arc, Condvar, Mutex, PoisonError};
// use std::time::{Duration, Instant};

/// Players per request.
pub const BATCH: usize = 64;
/// Players remembered; the least recently seen go first.
pub const REMEMBERED: usize = 4096;
/// The service's TTL is kept within these.
pub const TTL: (u64, u64) = (60, 3600);
/// The wait after a failure doubles from the first to the second.
pub const BACKOFF: (Duration, Duration) = (Duration::from_secs(15), Duration::from_secs(600));

/// What a player wears, in slot order of the service's answer.
    // rust: pub type Worn = Arc<[Arc<Item>]>;

/// How the service is reached; `Http` in the game, a fake in tests.
    // rust: pub trait Transport: Send + 'static {
pub fn post(self: *Self, path: []const u8, body: []const u8) R;
pub fn get(self: *Self, path: []const u8) R;
}

    // rust: pub type Clock = Arc<dyn Fn() -> Instant + Send + Sync>;

pub const State = struct {
    players: HashMap<u128,
    /// Seen without a fresh answer, not yet asked.
    pending: std.AutoHashMap(u128, void),
    /// Items by `id@hash`: `None` for a file that can't be read or was refused.
    items: HashMap<[]const u8,
    failures: u32,
    retry_at: ?Instant,
    stop: bool,
};

pub const Entry = struct {
    worn: ?Worn,
    /// Plays Horizon, as the service last said.
    horizon: bool,
    expires: Instant,
    seen: Instant,
};

pub const Shared = struct {
    state: Mutex<State>,
    wake: Condvar,
    clock: Clock,
};

/// The game's handle. Dropping it stops the thread.
pub const Cosmetics = struct {
    shared: *Shared,
    worker: ?*dyn FnMut() + Send,
};

    // rust: impl Cosmetics {
    /// Asks `transport` on a thread of its own; item files are kept in
    /// `cache` when given.
pub fn new(transport: impl Transport, cache: ?PathBuf) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut c = Self::manual(transport, cache, Arc::new(Instant::now));
    // rust: let mut work = c.worker.take().expect("worker");
    // rust: let shared = c.shared.clone();
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("Cosmetics".into())
    // rust: .spawn(move || {
    // rust: loop {
    // rust: {
    // rust: let state = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let state = shared
    // rust: .wake
    // rust: .wait_while(state, |s| !s.stop && !ready(s, (shared.clock)()))
    // rust: .unwrap_or_else(PoisonError::into_inner);
    // rust: if state.stop {
    // rust: return;
}
}
    // rust: work();
                    // A failure sets retry_at: sleep until then.
    // rust: let wait = {
    // rust: let s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: s.retry_at
    // rust: .map(|t| t.saturating_duration_since((shared.clock)()))
}
    // rust: if let Some(wait) = wait {
    // rust: let s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let _ = shared.wake.wait_timeout_while(s, wait, |s| !s.stop);
}
}
    // rust: });
    // rust: c
}

    /// No thread: `work` runs one round where called (tests).
pub fn manual(transport: impl Transport, cache: ?PathBuf, clock: Clock) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shared = Arc::new(Shared {
    // rust: state: Mutex::default(),
    // rust: wake: Condvar::new(),
    // rust: clock,
    // rust: });
    // rust: let inner = shared.clone();
    // rust: let mut saved = None;
    // rust: let worker: Box<dyn FnMut() + Send> = Box::new(move || {
    // rust: let saved = saved.get_or_insert_with(|| Saved::load(&cache));
    // rust: work(&inner, &transport, &cache, saved);
    // rust: });
    // rust: Self {
    // rust: shared,
    // rust: worker: Some(worker),
}
}

    /// One frame's reads: lock once, ask `worn` for each player in view.
pub fn frame(self: *Self) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Frame {
    // rust: now: (self.shared.clock)(),
    // rust: state: self
    // rust: .shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner),
    // rust: wake: &self.shared.wake,
    // rust: asked: false,
}
}
}

    // rust: impl Drop for Cosmetics {
pub fn drop(self: *Self) void {
}
    // rust: self.shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .stop = true;
    // rust: self.shared.wake.notify_all();
}
}

pub const Frame = struct {
    now: Instant,
    state: std::sync::MutexGuard<'a,
    wake: *'a Condvar,
    asked: bool,
};

    // rust: impl Frame<'_> {
    /// What `uuid` wears as last known (`None`: nothing, or not known yet).
    /// A player not known, or known for longer than the TTL, is asked for.
pub fn worn(self: *Self, uuid: u128) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.look(uuid).and_then(|e| e.worn.clone())
}

    /// Whether `uuid` plays Horizon, as last known (false until known); asked for as `worn`.
pub fn horizon(self: *Self, uuid: u128) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.look(uuid).is_some_and(|e| e.horizon)
}

pub fn look(self: *Self, uuid: u128) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let now = self.now;
    // rust: let state = &mut *self.state;
    // rust: match state.players.get_mut(&uuid) {
    // rust: Some(entry) => {
    // rust: entry.seen = now;
    // rust: if entry.expires <= now && state.pending.insert(uuid) {
    // rust: self.asked = true;
}
    // rust: Some(entry)
}
    // rust: None => {
    // rust: self.asked |= state.pending.insert(uuid);
    // rust: None
}
}
}
}

    // rust: impl Drop for Frame<'_> {
pub fn drop(self: *Self) void {
}
    // rust: if self.asked {
    // rust: self.wake.notify_all();
}
}
}

pub fn ready(s: *State, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: !s.pending.is_empty() && s.retry_at.is_none_or(|t| t <= now)
}

pub const Answer = struct {
    ttl: u64,
    players: HashMap<[]const u8,
    /// Missing from services before it.
    horizon: std.ArrayList([]const u8),
};

pub const ItemRef = struct {
    id: []const u8,
    hash: []const u8,
};

/// The last answers on disk: what each player wore whose items all read.
pub const Saved = struct {
    players: HashMap<[]const u8,
};

    // rust: impl Saved {
pub const FILE: []const u8 = "worn.json";

pub fn load(cache: *?PathBuf) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: cache
    // rust: .as_ref()
    // rust: .and_then(|d| std::fs::read(d.join(Self::FILE)).ok())
    // rust: .and_then(|b| serde_json::from_slice(&b).ok())
    // rust: .unwrap_or_default()
}

pub fn save(self: *Self, cache: *?PathBuf) void {
}
    // rust: let Some(dir) = cache else { return };
    // rust: let (Ok(text), Ok(())) = (serde_json::to_vec(self), std::fs::create_dir_all(dir)) else {
    // rust: return;
}
    // rust: let part = dir.join("worn.part");
    // rust: if std::fs::write(&part, text).is_ok() {
    // rust: let _ = std::fs::rename(&part, dir.join(Self::FILE));
}
}
}

/// No service: items are read from memory or the disk cache only.
pub const Offline = struct {};

    // rust: impl Transport for Offline {
pub fn post(self: *Self, _: []const u8, _: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err("offline".into())
}
pub fn get(self: *Self, _: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err("offline".into())
}
}

/// One round: asks for up to `BATCH` pending players, then reads the items
/// they wear (memory, disk, then the service). When the service doesn't
/// answer, players not known yet get what `saved` says they last wore.
pub fn work(shared: *Shared, transport: *dyn Transport, cache: *?PathBuf, saved: *mut Saved) void {
}
    // rust: let batch: Vec<u128> = {
    // rust: let mut s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: if !ready(&s, (shared.clock)()) {
    // rust: return;
}
    // rust: let batch: Vec<u128> = s.pending.iter().copied().take(BATCH).collect();
    // rust: for uuid in &batch {
    // rust: s.pending.remove(uuid);
}
    // rust: batch
}
    // rust: let body = serde_json::json!({
    // rust: "players": batch.iter().map(|u| format!("{u:032x}")).collect::<Vec<_>>()
    // rust: });
    // rust: let answer = transport
    // rust: .post("/v1/worn", body.to_string().as_bytes())
    // rust: .and_then(|b| serde_json::from_slice::<Answer>(&b).map_err(|e| e.to_string()));
    // rust: let answer = match answer {
    // rust: Ok(a) => a,
    // rust: Err(_) => {
    // rust: let restored = restore(shared, cache, saved, &batch);
    // rust: let mut s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let now = (shared.clock)();
    // rust: for (uuid, worn) in restored {
                // Shown until the service answers: asked again with the others.
    // rust: s.players.entry(uuid).or_insert(Entry {
    // rust: worn: Some(worn),
    // rust: horizon: false,
    // rust: expires: now,
    // rust: seen: now,
    // rust: });
}
    // rust: s.failures += 1;
    // rust: let wait = BACKOFF.0 * 2u32.saturating_pow(s.failures - 1).min(64);
    // rust: s.retry_at = Some((shared.clock)() + wait.min(BACKOFF.1));
    // rust: s.pending.extend(batch);
    // rust: return;
}
}
    // rust: let horizon: HashSet<u128> = answer
    // rust: .horizon
    // rust: .iter()
    // rust: .filter_map(|hex| u128::from_str_radix(hex, 16).ok())
    // rust: .collect();
    // rust: let mut worn: HashMap<u128, Worn> = HashMap::new();
    // Players with an item the service didn't send: asked again soon.
    // rust: let mut short = HashSet::new();
    // rust: let mut changed = false;
    // rust: for (hex, refs) in answer.players {
    // rust: let Ok(uuid) = u128::from_str_radix(&hex, 16) else {
    // rust: continue;
}
    // rust: let mut items = Vec::new();
    // rust: let mut kept = Vec::new();
    // rust: for r in &refs {
    // rust: match item(shared, transport, cache, r) {
    // rust: Ok(Some(i)) => {
    // rust: items.push(i);
    // rust: kept.push(r.clone());
}
    // rust: Ok(None) => {}
    // rust: Err(()) => {
    // rust: short.insert(uuid);
}
}
}
    // rust: if !short.contains(&uuid) && saved.players.get(&hex) != Some(&kept) {
    // rust: changed = true;
    // rust: if kept.is_empty() {
    // rust: saved.players.remove(&hex);
    // rust: } else {
    // rust: saved.players.insert(hex, kept);
}
}
    // rust: if !items.is_empty() {
    // rust: worn.insert(uuid, items.into());
}
}
    // Answered without anything: wears nothing now.
    // rust: for uuid in &batch {
    // rust: if !worn.contains_key(uuid) && !short.contains(uuid) {
    // rust: changed |= saved.players.remove(&format!("{uuid:032x}")).is_some();
}
}
    // rust: let now = (shared.clock)();
    // rust: let ttl = Duration::from_secs(answer.ttl.clamp(TTL.0, TTL.1));
    // rust: let mut s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: s.failures = 0;
    // rust: s.retry_at = None;
    // rust: for uuid in batch {
    // rust: let seen = s.players.get(&uuid).map_or(now, |e| e.seen);
    // rust: let ttl = if short.contains(&uuid) {
    // rust: BACKOFF.0
    // rust: } else {
    // rust: ttl
}
    // rust: s.players.insert(
    // rust: uuid,
    // rust: Entry {
    // rust: worn: worn.remove(&uuid),
    // rust: horizon: horizon.contains(&uuid),
    // rust: expires: now + ttl,
    // rust: seen,
    // rust: },
    // rust: );
}
    // rust: if s.players.len() > REMEMBERED {
    // rust: let mut seen: Vec<Instant> = s.players.values().map(|e| e.seen).collect();
    // rust: seen.sort_unstable();
    // rust: let cut = seen[s.players.len() - REMEMBERED];
    // rust: s.players.retain(|_, e| e.seen >= cut);
}
    // rust: if saved.players.len() > REMEMBERED {
    // rust: saved.players.retain(|hex, _| {
    // rust: u128::from_str_radix(hex, 16).is_ok_and(|u| s.players.contains_key(&u))
    // rust: });
    // rust: changed = true;
}
    // rust: drop(s);
    // rust: if changed {
    // rust: saved.save(cache);
}
}

/// What the players of `batch` not known yet last wore, by `saved` and the
/// item files on disk.
    // rust: fn restore(
    // rust: shared: &Shared,
    // rust: cache: &Option<PathBuf>,
    // rust: saved: &Saved,
    // rust: batch: &[u128],
    // rust: ) -> Vec<(u128, Worn)> {
    // rust: let unknown: Vec<u128> = {
    // rust: let s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: batch
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|u| !s.players.contains_key(u))
    // rust: .collect()
}
    // rust: let mut restored = Vec::new();
    // rust: for uuid in unknown {
    // rust: let Some(refs) = saved.players.get(&format!("{uuid:032x}")) else {
    // rust: continue;
}
    // rust: let items: Vec<Arc<Item>> = refs
    // rust: .iter()
    // rust: .filter_map(|r| item(shared, &Offline, cache, r).ok().flatten())
    // rust: .collect();
    // rust: if !items.is_empty() {
    // rust: restored.push((uuid, items.into()));
}
}
    // rust: restored
}

/// An item file: from memory, the disk cache, else the service (then kept
/// on disk). A file that doesn't read is remembered as such (`Ok(None)`);
/// `Err` when the service didn't send it.
    // rust: fn item(
    // rust: shared: &Shared,
    // rust: transport: &dyn Transport,
    // rust: cache: &Option<PathBuf>,
    // rust: r: &ItemRef,
    // rust: ) -> Result<Option<Arc<Item>>, ()> {
    // rust: let safe = |t: &str| {
    // rust: !t.is_empty() && t.len() <= 64 && t.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_')
}
    // rust: if !safe(&r.id) || !safe(&r.hash) {
    // rust: return Ok(None);
}
    // rust: let key = format!("{}@{}", r.id, r.hash);
    // rust: if let Some(known) = shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .items
    // rust: .get(&key)
    // rust: {
    // rust: return Ok(known.clone());
}
    // rust: let file = cache
    // rust: .as_ref()
    // rust: .map(|d| d.join(format!("{}-{}.json", r.id, r.hash)));
    // rust: let from_disk = file.as_ref().and_then(|f| std::fs::read(f).ok());
    // rust: let bytes = match from_disk {
    // rust: Some(b) => Some(b),
    // rust: None => {
    // rust: let fetched = transport
    // rust: .get(&format!("/v1/items/{}?hash={}", r.id, r.hash))
    // rust: .map_err(|_| ())?;
    // rust: if let Some(f) = &file
    // rust: && Item::parse(&fetched).is_ok()
    // rust: && let Some(dir) = f.parent()
    // rust: && std::fs::create_dir_all(dir).is_ok()
    // rust: {
    // rust: let part = f.with_extension("part");
    // rust: if std::fs::write(&part, &fetched).is_ok() {
    // rust: let _ = std::fs::rename(&part, f);
}
}
    // rust: Some(fetched)
}
}
    // rust: let parsed = bytes
    // rust: .and_then(|b| Item::parse(&b).ok())
    // rust: .filter(|i| i.id == r.id)
    // rust: .map(Arc::new);
    // rust: shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .items
    // rust: .insert(key, parsed.clone());
    // rust: Ok(parsed)
}

/// The service over HTTPS.
pub const Http = struct {
    agent: ureq::Agent,
    base: []const u8,
};

/// Answers are small; anything longer is refused.
pub const MAX_ANSWER: u64 = 1 << 20;

    // rust: impl Http {
    /// `base` without a trailing slash, e.g. `https://cosmetics.example`.
pub fn new(base: []const u8, user_agent: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: agent: ureq::AgentBuilder::new()
    // rust: .timeout(Duration::from_secs(10))
    // rust: .user_agent(user_agent)
    // rust: .build(),
    // rust: base: base.trim_end_matches('/').to_owned(),
}
}

    // rust: pub(crate) fn agent(&self) -> &ureq::Agent {
    // rust: &self.agent
}

    // rust: pub(crate) fn base(&self) -> &str {
    // rust: &self.base
}

    // rust: pub(crate) fn read(answer: Result<ureq::Response, ureq::Error>) -> Result<Vec<u8>, String> {
//         use std::io::Read;
    // rust: let answer = answer.map_err(|e| match e {
    // rust: ureq::Error::Status(code, _) => format!("HTTP {code}"),
    // rust: ureq::Error::Transport(t) => t.kind().to_string(),
    // rust: })?;
    // rust: let mut bytes = Vec::new();
    // rust: answer
    // rust: .into_reader()
    // rust: .take(MAX_ANSWER + 1)
    // rust: .read_to_end(&mut bytes)
    // rust: .map_err(|e| e.to_string())?;
    // rust: if bytes.len() as u64 > MAX_ANSWER {
    // rust: return Err("answer too long".into());
}
    // rust: Ok(bytes)
}
}

    // rust: impl Transport for Http {
pub fn post(self: *Self, path: []const u8, body: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let url = format!("{}{path}", self.base);
    // rust: Self::read(
    // rust: self.agent
    // rust: .post(&url)
    // rust: .set("Content-Type", "application/json")
    // rust: .send_bytes(body),
    // rust: )
}

pub fn get(self: *Self, path: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::read(self.agent.get(&format!("{}{path}", self.base)).call())
}
}

/// Item files in a folder instead of the service (`HORIZON_COSMETICS_LOCAL`): every player asked
/// for wears the first item of each slot found there, by file name, and plays Horizon. For artists
/// and the bench.
pub const Local = struct {
    dir: PathBuf,
};

    // rust: impl Local {
pub fn new(dir: PathBuf) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self { dir }
}

    /// The first item file of each slot, by file name.
pub fn worn(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut files: Vec<PathBuf> = std::fs::read_dir(&self.dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .filter(|p| p.extension().is_some_and(|e| e == "json"))
    // rust: .collect();
    // rust: files.sort();
    // rust: let mut slots = Vec::new();
    // rust: let mut ids = Vec::new();
    // rust: for file in files {
    // rust: if let Some(item) = std::fs::read(&file).ok().and_then(|b| Item::parse(&b).ok())
    // rust: && !slots.contains(&item.slot)
    // rust: && item.slot != crate::Slot::Emote
    // rust: && file.file_stem().is_some_and(|s| *s == *item.id)
    // rust: {
    // rust: slots.push(item.slot);
    // rust: ids.push(item.id);
}
}
    // rust: ids
}
}

    // rust: impl Transport for Local {
pub fn post(self: *Self, _: []const u8, body: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
pub const Asked = struct {
    players: std.ArrayList([]const u8),
};
    // rust: let asked: Asked = serde_json::from_slice(body).map_err(|e| e.to_string())?;
    // rust: let refs: Vec<_> = self
    // rust: .worn()
    // rust: .into_iter()
    // rust: .map(|id| serde_json::json!({"id": id, "hash": "local"}))
    // rust: .collect();
    // rust: let players: serde_json::Map<String, serde_json::Value> = asked
    // rust: .players
    // rust: .into_iter()
    // rust: .map(|p| (p, serde_json::Value::Array(refs.clone())))
    // rust: .collect();
    // rust: let horizon: Vec<&String> = players.keys().collect();
    // rust: Ok(
    // rust: serde_json::json!({"ttl": 60, "players": players, "horizon": horizon})
    // rust: .to_string()
    // rust: .into_bytes(),
    // rust: )
}

pub fn get(self: *Self, path: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = path
    // rust: .trim_start_matches("/v1/items/")
    // rust: .split('?')
    // rust: .next()
    // rust: .unwrap_or_default();
    // rust: std::fs::read(self.dir.join(format!("{id}.json"))).map_err(|e| e.to_string())
}
}

    // rust: mod tests;
