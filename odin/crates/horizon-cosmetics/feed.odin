//! Transpiled from Horizon Rust crate
package horizon_cosmetics_feed

import "core:fmt"
import "core:mem"
import "core:math"

// Which other players play an emote, from the cosmetics service: the game names the Horizon
// players in view each tick (`Feed::ask`, at most `BATCH`), a thread of its own asks
// `POST /v1/emotes` about them at most once a `POLL`, and the frame reads the answer
// (`Feed::playing`). Nobody in view, nothing is asked. A failure waits 15 s, doubling to 10
// minutes, and ends the emotes shown.
//
// `POST /v1/emotes {"players": ["<uuid hex>", …]}` answers
// `{"playing": {"<uuid hex>": {"id", "hash", "ms"}}}`: the emote each plays and how long ago it
// started. The item files come from `GET /v1/items/<id>?hash=`, kept in memory.

// use crate::{BATCH, Item, Slot, Transport};
// use std::collections::HashMap;
// use std::sync::{Arc, Condvar, Mutex, PoisonError};
// use std::time::{Duration, Instant};

// The shortest time between two requests.
POLL :: Duration::from_secs(1)
// A list of players in view counts this long after the game last named it.
FRESH :: Duration::from_secs(2)
BACKOFF :: (Duration::from_secs(15), Duration::from_secs(600))

// An emote another player plays: the item, and when it started on this machine's clock.
Seen :: struct {
    item: ^Item,
    started: Instant,
}

State :: struct {
    want: [dynamic]u128,
    asked_at: Maybe(Instant),
    playing: HashMap<u128,
    // By `id@hash`; `None`: unreadable or not an emote.
    items: HashMap<string,
    next: Maybe(Instant),
    wait: Maybe(Duration),
    stop: bool,
}

Shared :: struct {
    state: Mutex<State>,
    wake: Condvar,
}

// The game's handle; dropping it stops the thread.
Feed :: struct {
    shared: ^Shared,
}

    // rust: impl Feed {
new :: proc(transport: impl Transport) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let shared = Arc::new(Shared {
    // rust: state: Mutex::default(),
    // rust: wake: Condvar::new(),
    // rust: });
    // rust: let inner = shared.clone();
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("Cosmetics emotes".into())
    // rust: .spawn(move || {
    // rust: loop {
    // rust: let wait = {
    // rust: let s = inner.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: if s.stop {
    // rust: return;
}
    // rust: due(&s, Instant::now())
}
    // rust: match wait {
    // rust: Some(Duration::ZERO) => round(&inner, &transport, Instant::now()),
                        // Waiting for the next poll, or for the game to name anyone.
    // rust: Some(wait) => {
    // rust: let s = inner.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let (s, _) = inner
    // rust: .wake
    // rust: .wait_timeout_while(s, wait, |s| !s.stop)
    // rust: .unwrap_or_else(PoisonError::into_inner);
    // rust: drop(s);
}
    // rust: None => {
    // rust: let s = inner.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let s = inner
    // rust: .wake
    // rust: .wait_while(s, |s| !s.stop && due(s, Instant::now()).is_none())
    // rust: .unwrap_or_else(PoisonError::into_inner);
    // rust: drop(s);
}
}
}
    // rust: });
    // rust: Self { shared }
}

    // The Horizon players in view now; only the first `BATCH` are asked about.
ask :: proc(self: ^Self, players: impl IntoIterator<Item = u128>) {
}
    // rust: let mut want: Vec<u128> = players.into_iter().take(BATCH).collect();
    // rust: want.sort_unstable();
    // rust: want.dedup();
    // rust: let mut s = self
    // rust: .shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner);
    // rust: let was_idle = s.want.is_empty() || s.asked_at.is_none_or(|a| a.elapsed() > FRESH);
    // rust: s.asked_at = (!want.is_empty()).then(Instant::now);
    // rust: s.want = want;
    // rust: if was_idle {
    // rust: self.shared.wake.notify_all();
}
}

    // The emote `uuid` plays, as last answered.
playing :: proc(self: ^Self, uuid: u128) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let s = self
    // rust: .shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner);
    // rust: s.playing.get(&uuid).cloned()
}
}

    // rust: impl Drop for Feed {
drop :: proc(self: ^Self) {
}
    // rust: self.shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .stop = true;
    // rust: self.shared.wake.notify_all();
}
}

// How long until the next request: `ZERO` now, `None` while nobody is in view.
due :: proc(s: ^State, now: Instant) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let fresh = s.asked_at.is_some_and(|a| now.duration_since(a) <= FRESH);
    // rust: if s.want.is_empty() || !fresh {
    // rust: return None;
}
    // rust: Some(
    // rust: s.next
    // rust: .map_or(Duration::ZERO, |n| n.saturating_duration_since(now)),
    // rust: )
}

hex :: proc(uuid: u128) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("{uuid:032x}")
}

// One request about the players in view, then the item files it names.
round :: proc(shared: ^Shared, transport: ^dyn Transport, now: Instant) {
}
    // rust: let want = {
    // rust: let mut s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: s.next = Some(now + POLL);
    // rust: s.want.clone()
}
    // rust: let body = serde_json::json!({ "players": want.iter().map(|u| hex(*u)).collect::<Vec<_>>() });
    // rust: let answer = transport
    // rust: .post("/v1/emotes", body.to_string().as_bytes())
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok());
    // rust: let Some(answer) = answer else {
    // rust: let mut s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let wait = s.wait.map_or(BACKOFF.0, |w| (w * 2).min(BACKOFF.1));
    // rust: s.wait = Some(wait);
    // rust: s.next = Some(now + wait);
    // rust: s.playing.clear();
    // rust: return;
}
    // rust: let mut playing = HashMap::new();
    // rust: for uuid in &want {
    // rust: let Some(e) = answer["playing"].get(hex(*uuid)) else {
    // rust: continue;
}
    // rust: let (Some(id), Some(hash), Some(ms)) =
    // rust: (e["id"].as_str(), e["hash"].as_str(), e["ms"].as_u64())
    // rust: else {
    // rust: continue;
}
    // rust: let Some(item) = emote_item(shared, transport, id, hash) else {
    // rust: continue;
}
        // When it started here, keeping a start it already had (the answer's `ms` jitters with
        // the request's own time).
    // rust: let started = now.checked_sub(Duration::from_millis(ms)).unwrap_or(now);
    // rust: playing.insert(*uuid, (item, started));
}
    // rust: let mut s = shared.state.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: s.wait = None;
    // rust: let old = std::mem::take(&mut s.playing);
    // rust: for (uuid, (item, started)) in playing {
    // rust: let started = match old.get(&uuid) {
    // rust: Some(seen) if Arc::ptr_eq(&seen.item, &item) => seen.started,
    // rust: _ => started,
}
    // rust: s.playing.insert(uuid, Seen { item, started });
}
}

    // rust: fn emote_item(
    // rust: shared: &Shared,
    // rust: transport: &dyn Transport,
    // rust: id: &str,
    // rust: hash: &str,
    // rust: ) -> Option<Arc<Item>> {
    // rust: let safe = |t: &str| {
    // rust: !t.is_empty() && t.len() <= 64 && t.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_')
}
    // rust: if !safe(id) || !safe(hash) {
    // rust: return None;
}
    // rust: let key = format!("{id}@{hash}");
    // rust: if let Some(known) = shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .items
    // rust: .get(&key)
    // rust: {
    // rust: return known.clone();
}
    // A network failure is tried again at the next poll; a bad file never.
    // rust: let bytes = transport.get(&format!("/v1/items/{id}?hash={hash}")).ok()?;
    // rust: let item = Item::parse(&bytes)
    // rust: .ok()
    // rust: .filter(|i| i.id == id && i.slot == Slot::Emote)
    // rust: .map(Arc::new);
    // rust: shared
    // rust: .state
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .items
    // rust: .insert(key, item.clone());
    // rust: item
}

    // rust: mod tests {
//     use super::*;

    // rust: const NOD: &str = r#"{"format": 1, "id": "nod", "slot": "emote", "parts": [],
    // rust: "emote": {"length": 20, "tracks": [{"part": "head", "keys": [{"t": 10, "rotation": [20, 0, 0]}]}]}}"#;

    // The service: player 1 plays `nod` started 500 ms ago; logs each request.
Service :: struct {
    log: ^Mutex<[dynamic]string>,
    down: ^std::sync::atomic::AtomicBool,
}

    // rust: impl Transport for Service {
post :: proc(self: ^Self, path: string, body: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.log
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push(format!("POST {path} {}", String::from_utf8_lossy(body)));
    // rust: if self.down.load(std::sync::atomic::Ordering::SeqCst) {
    // rust: return Err("HTTP 503".into());
}
    // rust: Ok(br#"{"playing": {"00000000000000000000000000000001": {"id": "nod", "hash": "h1", "ms": 500}}}"#.to_vec())
}
get :: proc(self: ^Self, path: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.log.lock().unwrap().push(format!("GET {path}"));
    // rust: Ok(NOD.as_bytes().to_vec())
}
}

shared :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Shared {
    // rust: state: Mutex::default(),
    // rust: wake: Condvar::new(),
}
}

asks_only_about_the_players_in_view_and_only_once_a_poll :: proc() {
}
    // rust: let (service, shared) = (Service::default(), shared());
    // rust: let t0 = Instant::now();
        // Nobody named: nothing due.
    // rust: assert_eq!(due(&shared.state.lock().unwrap(), t0), None);
    // rust: {
    // rust: let mut s = shared.state.lock().unwrap();
    // rust: s.want = vec![1, 2];
    // rust: s.asked_at = Some(t0);
}
    // rust: assert_eq!(due(&shared.state.lock().unwrap(), t0), Some(Duration::ZERO));
    // rust: round(&shared, &service, t0);
    // rust: let log = service.log.lock().unwrap().clone();
    // rust: assert_eq!(
    // rust: log,
    // rust: [
    // rust: r#"POST /v1/emotes {"players":["00000000000000000000000000000001","00000000000000000000000000000002"]}"#,
    // rust: "GET /v1/items/nod?hash=h1"
    // rust: ]
    // rust: );
    // rust: let s = shared.state.lock().unwrap();
    // rust: let seen = s.playing.get(&1).unwrap();
    // rust: assert_eq!(seen.item.id, "nod");
    // rust: assert_eq!(t0.duration_since(seen.started), Duration::from_millis(500));
    // rust: assert!(!s.playing.contains_key(&2));
        // The next request waits a poll; a list the game stopped naming is not asked about.
    // rust: assert_eq!(due(&s, t0 + POLL / 2), Some(POLL / 2));
    // rust: assert_eq!(due(&s, t0 + FRESH + POLL), None);
}

the_same_emote_keeps_its_start_the_file_is_fetched_once_and_failures_back_off :: proc() {
}
    // rust: let (service, shared) = (Service::default(), shared());
    // rust: let t0 = Instant::now();
    // rust: {
    // rust: let mut s = shared.state.lock().unwrap();
    // rust: s.want = vec![1];
    // rust: s.asked_at = Some(t0);
}
    // rust: round(&shared, &service, t0);
    // rust: round(&shared, &service, t0 + POLL);
    // rust: let started = shared.state.lock().unwrap().playing[&1].started;
    // rust: assert_eq!(t0.duration_since(started), Duration::from_millis(500));
    // rust: let gets = service
    // rust: .log
    // rust: .lock()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .filter(|l| l.starts_with("GET"))
    // rust: .count();
    // rust: assert_eq!(gets, 1);
        // Down: nothing shown, and the next try waits 15 s, then 30 s.
    // rust: service
    // rust: .down
    // rust: .store(true, std::sync::atomic::Ordering::SeqCst);
    // rust: round(&shared, &service, t0 + POLL * 2);
    // rust: let s = shared.state.lock().unwrap();
    // rust: assert!(s.playing.is_empty());
    // rust: assert_eq!(s.next, Some(t0 + POLL * 2 + BACKOFF.0));
    // rust: drop(s);
    // rust: round(&shared, &service, t0 + POLL * 3);
    // rust: assert_eq!(
    // rust: shared.state.lock().unwrap().next,
    // rust: Some(t0 + POLL * 3 + BACKOFF.0 * 2)
    // rust: );
}

a_file_that_is_not_an_emote_is_never_played :: proc() {
}
Hat :: struct {
    // rust: impl Transport for Hat {
post :: proc(self: ^Self, _: string, _: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(br#"{"playing": {"00000000000000000000000000000001": {"id": "nod", "hash": "h1", "ms": 0}}}"#.to_vec())
}
get :: proc(self: ^Self, _: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(NOD
    // rust: .replace(r#""slot": "emote""#, r#""slot": "head""#)
    // rust: .into_bytes())
}
}
    // rust: let shared = shared();
    // rust: {
    // rust: let mut s = shared.state.lock().unwrap();
    // rust: s.want = vec![1];
    // rust: s.asked_at = Some(Instant::now());
}
    // rust: round(&shared, &Hat, Instant::now());
    // rust: assert!(shared.state.lock().unwrap().playing.is_empty());
}

the_thread_answers_the_game :: proc() {
}
    // rust: let feed = Feed::new(Service::default());
    // rust: let deadline = Instant::now() + Duration::from_secs(10);
    // rust: loop {
    // rust: feed.ask([1, 2]);
    // rust: if feed.playing(1).is_some() || Instant::now() > deadline {
    // rust: break;
}
    // rust: std::thread::sleep(Duration::from_millis(20));
}
    // rust: assert_eq!(
    // rust: feed.playing(1).map(|s| s.item.id.clone()).as_deref(),
    // rust: Some("nod")
    // rust: );
    // rust: assert!(feed.playing(2).is_none());
}
}
