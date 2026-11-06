//! Transpiled from Horizon Rust crate
//! Module: horizon-cosmetics_fetch_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};

/// The service: who wears what, every request logged.
pub const Fake = struct {
    log: *Mutex<std.ArrayList([]const u8)>,
    offline: *AtomicBool,
    wearing: Arc<Mutex<HashMap<u128,
    /// Who plays Horizon; `None`: a service from before the field.
    horizon: *Mutex<?std.AutoHashMap(u128, void)>,
};

    // rust: impl Fake {
pub fn log(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.log.lock().unwrap())
}
}

/// An item with one box (24 vertices), or `huge`: past the budget.
pub fn item_file(id: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cube = r#"{"origin": [-1, -1, -1], "size": [2, 2, 2], "uv": [0, 0]}"#;
    // rust: let cubes = vec![cube; if id == "huge" { 30 } else { 1 }].join(",");
    // rust: format!(
    // rust: r#"{{"format": 1, "id": "{id}", "slot": "head", "bone": "head",
    // rust: "texture": {{"png": "{}"}}, "parts": [{{"name": "a", "cubes": [{cubes}]}}]}}"#,
    // rust: crate::pose::tests::png(16, 16)
    // rust: )
}

    // rust: impl Transport for Fake {
pub fn post(self: *Self, path: []const u8, body: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let body: serde_json::Value = serde_json::from_slice(body).unwrap();
    // rust: let asked = body["players"].as_array().unwrap();
    // rust: self.log
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push(format!("POST {path} {}", asked.len()));
    // rust: if self.offline.load(Ordering::SeqCst) {
    // rust: return Err("offline".into());
}
    // rust: let wearing = self.wearing.lock().unwrap();
    // rust: let mut players = serde_json::Map::new();
    // rust: for uuid in asked {
    // rust: let uuid = uuid.as_str().unwrap();
    // rust: if let Some(items) = wearing.get(&u128::from_str_radix(uuid, 16).unwrap()) {
    // rust: let refs = items
    // rust: .iter()
    // rust: .map(|id| serde_json::json!({"id": id, "hash": "h1"}))
    // rust: .collect();
    // rust: players.insert(uuid.to_owned(), serde_json::Value::Array(refs));
}
}
    // rust: let mut answer = serde_json::json!({"ttl": 300, "players": players});
    // rust: if let Some(horizon) = &*self.horizon.lock().unwrap() {
    // rust: let listed: Vec<&str> = asked
    // rust: .iter()
    // rust: .filter_map(|u| u.as_str())
    // rust: .filter(|u| horizon.contains(&u128::from_str_radix(u, 16).unwrap()))
    // rust: .collect();
    // rust: answer["horizon"] = serde_json::json!(listed);
}
    // rust: Ok(answer.to_string().into_bytes())
}

pub fn get(self: *Self, path: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.log.lock().unwrap().push(format!("GET {path}"));
    // rust: if self.offline.load(Ordering::SeqCst) {
    // rust: return Err("offline".into());
}
    // rust: let id = path
    // rust: .trim_start_matches("/v1/items/")
    // rust: .split('?')
    // rust: .next()
    // rust: .unwrap();
    // rust: Ok(item_file(id).into_bytes())
}
}

/// A clock the test moves by whole seconds.
pub fn clock() ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let start = Instant::now();
    // rust: let seconds = Arc::new(AtomicU64::new(0));
    // rust: let s = seconds.clone();
    // rust: let clock: Clock = Arc::new(move || start + Duration::from_secs(s.load(Ordering::SeqCst)));
    // rust: (clock, seconds)
}

pub fn run(c: *mut Cosmetics) void {
}
    // rust: (c.worker.as_mut().unwrap())();
}

pub fn ids(worn: ?Worn) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: worn.into_iter()
    // rust: .flat_map(|w| w.iter().map(|i| i.id.clone()).collect::<Vec<_>>())
    // rust: .collect()
}

pub fn setup(cache: ?PathBuf) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let fake = Fake::default();
    // rust: {
    // rust: let mut wearing = fake.wearing.lock().unwrap();
    // rust: for uuid in 0..10 {
    // rust: wearing.insert(uuid, vec!["hat"]);
}
    // rust: wearing.insert(5, vec!["hat", "pet"]);
}
    // rust: let (clock, time) = clock();
    // rust: let c = Cosmetics::manual(fake.clone(), cache, clock);
    // rust: (fake, c, time)
}

pub fn asks_once_for_the_players_in_view_in_batches() void {
}
    // rust: let (fake, mut c, _) = setup(None);
    // rust: {
    // rust: let mut frame = c.frame();
    // rust: assert!((0..100).all(|uuid| frame.worn(uuid).is_none()));
}
    // rust: run(&mut c);
    // rust: run(&mut c);
    // rust: let log = fake.log();
    // rust: let posts: Vec<_> = log.iter().filter(|l| l.starts_with("POST")).collect();
    // rust: assert_eq!(posts, ["POST /v1/worn 64", "POST /v1/worn 36"]);
    // Each item once, however many wear it.
    // rust: let mut gets: Vec<_> = log.iter().filter(|l| l.starts_with("GET")).collect();
    // rust: gets.sort();
    // rust: assert_eq!(
    // rust: gets,
    // rust: ["GET /v1/items/hat?hash=h1", "GET /v1/items/pet?hash=h1"]
    // rust: );
    // rust: let mut frame = c.frame();
    // rust: assert_eq!(ids(frame.worn(0)), ["hat"]);
    // rust: assert_eq!(ids(frame.worn(5)), ["hat", "pet"]);
    // rust: assert!(frame.worn(50).is_none());
    // rust: drop(frame);
    // Everyone is known: nothing more to ask.
    // rust: run(&mut c);
    // rust: assert!(fake.log().is_empty());
}

pub fn nothing_in_view_asks_nothing() void {
}
    // rust: let (fake, mut c, _) = setup(None);
    // rust: drop(c.frame());
    // rust: run(&mut c);
    // rust: assert!(fake.log().is_empty());
}

pub fn asks_again_after_the_ttl_keeping_the_answer_meanwhile() void {
}
    // rust: let (fake, mut c, time) = setup(None);
    // rust: let _ = c.frame().worn(5);
    // rust: run(&mut c);
    // rust: fake.log();
    // rust: fake.wearing.lock().unwrap().insert(5, vec!["pet"]);
    // rust: time.store(299, Ordering::SeqCst);
    // rust: assert_eq!(ids(c.frame().worn(5)), ["hat", "pet"]);
    // rust: run(&mut c);
    // rust: assert!(fake.log().is_empty());
    // rust: time.store(300, Ordering::SeqCst);
    // Expired: still drawn as known while asked again.
    // rust: assert_eq!(ids(c.frame().worn(5)), ["hat", "pet"]);
    // rust: run(&mut c);
    // rust: assert_eq!(fake.log(), ["POST /v1/worn 1"]);
    // rust: assert_eq!(ids(c.frame().worn(5)), ["pet"]);
}

pub fn offline_keeps_the_last_answers_and_backs_off() void {
}
    // rust: let (fake, mut c, time) = setup(None);
    // rust: let _ = c.frame().worn(1);
    // rust: run(&mut c);
    // rust: fake.log();
    // rust: fake.offline.store(true, Ordering::SeqCst);
    // rust: time.store(400, Ordering::SeqCst);
    // rust: let _ = c.frame().worn(1);
    // rust: let _ = c.frame().worn(42);
    // rust: run(&mut c);
    // rust: assert_eq!(fake.log(), ["POST /v1/worn 2"]);
    // rust: assert_eq!(ids(c.frame().worn(1)), ["hat"]);
    // 15 s, then 30 s, before asking again.
    // rust: for (at, asks) in [(414, false), (415, true), (444, false), (445, true)] {
    // rust: time.store(at, Ordering::SeqCst);
    // rust: run(&mut c);
    // rust: assert_eq!(!fake.log().is_empty(), asks, "at {at}");
}
    // rust: fake.offline.store(false, Ordering::SeqCst);
    // rust: time.store(505, Ordering::SeqCst);
    // rust: run(&mut c);
    // rust: assert_eq!(fake.log(), ["POST /v1/worn 2"]);
    // rust: assert_eq!(ids(c.frame().worn(1)), ["hat"]);
    // rust: assert!(c.frame().worn(42).is_none());
}

pub fn item_files_are_kept_on_disk() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-cosmetics-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let (fake, mut c, _) = setup(Some(dir.clone()));
    // rust: let _ = c.frame().worn(5);
    // rust: run(&mut c);
    // rust: assert_eq!(fake.log().len(), 3);
    // rust: assert!(dir.join("hat-h1.json").is_file());
    // A new game: the items read from disk, not asked for.
    // rust: let (fake, mut c, _) = setup(Some(dir.clone()));
    // rust: let _ = c.frame().worn(5);
    // rust: run(&mut c);
    // rust: assert_eq!(fake.log(), ["POST /v1/worn 1"]);
    // rust: assert_eq!(ids(c.frame().worn(5)), ["hat", "pet"]);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

pub fn an_item_past_the_limits_is_left_out_and_not_asked_again() void {
}
    // rust: let (fake, mut c, time) = setup(None);
    // rust: fake.wearing.lock().unwrap().insert(7, vec!["huge", "hat"]);
    // rust: let _ = c.frame().worn(7);
    // rust: run(&mut c);
    // rust: assert_eq!(fake.log().len(), 3);
    // rust: assert_eq!(ids(c.frame().worn(7)), ["hat"]);
    // rust: time.store(300, Ordering::SeqCst);
    // rust: let _ = c.frame().worn(7);
    // rust: run(&mut c);
    // rust: assert_eq!(fake.log(), ["POST /v1/worn 1"]);
}

pub fn an_item_not_sent_is_asked_for_again_soon() void {
}
    // rust: let (fake, mut c, time) = setup(None);
    // rust: let _ = c.frame().worn(3);
    // The answer arrives, the item doesn't.
pub const ItemsDown = struct {};
    // rust: impl Transport for ItemsDown {
pub fn post(self: *Self, path: []const u8, body: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.post(path, body)
}
pub fn get(self: *Self, _: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err("down".into())
}
}
    // rust: let shared = c.shared.clone();
    // rust: work(
    // rust: &shared,
    // rust: &ItemsDown(fake.clone()),
    // rust: &None,
    // rust: &mut Saved::default(),
    // rust: );
    // rust: assert!(c.frame().worn(3).is_none());
    // rust: time.store(BACKOFF.0.as_secs(), Ordering::SeqCst);
    // rust: let _ = c.frame().worn(3);
    // rust: run(&mut c);
    // rust: assert_eq!(ids(c.frame().worn(3)), ["hat"]);
}

pub fn the_thread_answers_a_frame() void {
}
    // rust: let fake = Fake::default();
    // rust: fake.wearing.lock().unwrap().insert(9, vec!["hat"]);
    // rust: let c = Cosmetics::new(fake, None);
    // rust: let _ = c.frame().worn(9);
    // rust: let deadline = Instant::now() + Duration::from_secs(10);
    // rust: while c.frame().worn(9).is_none() {
    // rust: assert!(Instant::now() < deadline, "no answer");
    // rust: std::thread::sleep(Duration::from_millis(5));
}
    // rust: assert_eq!(ids(c.frame().worn(9)), ["hat"]);
}

pub fn a_new_game_shows_the_last_outfits_while_the_service_is_down() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-cosmetics-worn-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let (fake, mut c, _) = setup(Some(dir.clone()));
    // rust: let _ = c.frame().worn(5);
    // rust: let _ = c.frame().worn(42);
    // rust: run(&mut c);
    // rust: drop(c);
    // The next game starts with the service down: what 5 last wore, from disk only.
    // rust: let (fake2, mut c, time) = setup(Some(dir.clone()));
    // rust: fake2.offline.store(true, Ordering::SeqCst);
    // rust: let _ = c.frame().worn(5);
    // rust: let _ = c.frame().worn(3);
    // rust: let _ = c.frame().worn(42);
    // rust: run(&mut c);
    // rust: assert_eq!(fake2.log(), ["POST /v1/worn 3"]);
    // rust: assert_eq!(ids(c.frame().worn(5)), ["hat", "pet"]);
    // Never seen before, or wore nothing: plain.
    // rust: assert!(c.frame().worn(3).is_none());
    // rust: assert!(c.frame().worn(42).is_none());
    // Back online, 5 took everything off: the fresh answer wins, and is kept.
    // rust: fake2.offline.store(false, Ordering::SeqCst);
    // rust: fake2.wearing.lock().unwrap().remove(&5);
    // rust: time.store(15, Ordering::SeqCst);
    // rust: run(&mut c);
    // rust: assert!(c.frame().worn(5).is_none());
    // rust: drop(c);
    // rust: let (fake3, mut c, _) = setup(Some(dir.clone()));
    // rust: fake3.offline.store(true, Ordering::SeqCst);
    // rust: let _ = c.frame().worn(5);
    // rust: run(&mut c);
    // rust: assert!(c.frame().worn(5).is_none());
    // rust: drop(fake);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

pub fn horizon_players_come_with_the_same_request_as_what_they_wear() void {
}
    // rust: let (fake, mut c, time) = setup(None);
    // 3 wears a hat and plays Horizon, 50 plays Horizon in nothing, 7 wears a hat elsewhere.
    // rust: *fake.horizon.lock().unwrap() = Some(HashSet::from([3, 50]));
    // rust: {
    // rust: let mut frame = c.frame();
    // rust: assert!(!frame.horizon(3) && !frame.horizon(50));
    // rust: let _ = frame.worn(7);
}
    // rust: run(&mut c);
    // rust: assert_eq!(
    // rust: fake.log().iter().filter(|l| l.starts_with("POST")).count(),
    // rust: 1
    // rust: );
    // rust: let mut frame = c.frame();
    // rust: assert!(frame.horizon(3) && frame.horizon(50) && !frame.horizon(7));
    // rust: assert_eq!(ids(frame.worn(3)), ["hat"]);
    // rust: assert!(frame.worn(50).is_none());
    // rust: drop(frame);
    // rust: run(&mut c);
    // rust: assert!(fake.log().is_empty());
    // Stopped playing (or turned it off): gone after the TTL. An older service never says.
    // rust: *fake.horizon.lock().unwrap() = None;
    // rust: time.store(300, Ordering::SeqCst);
    // rust: let _ = c.frame().horizon(3);
    // rust: run(&mut c);
    // rust: let mut frame = c.frame();
    // rust: assert!(!frame.horizon(3));
    // rust: assert_eq!(ids(frame.worn(3)), ["hat"]);
}
