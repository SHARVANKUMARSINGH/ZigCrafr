//! Transpiled from Horizon Rust crate
package horizon_client_far

import "core:fmt"
import "core:mem"
import "core:math"

// Horizon's far ring (docs/hosting.md), off by default: past a dedicated server's view distance, up to
// its `max_view_distance`, each player is sent the chunks the world has saved. They are read on threads
// of their own and dropped once sent: nothing is generated, loaded or ticked for them, and only their
// positions stay (the player's `sent_chunks`). Bodies sent are kept a while for players walking back. A
// brake pulls the ring in while ticks run long and lets it out slowly once they are short again.

// use super::chunks::ChunkEncoder;
// use crate::{biome::Biomes, fast_hash::FxHashMap, save::SaveDir};
// use horizon_world::registry::BlockRegistry;
// use std::{
    // rust: collections::VecDeque,
    // rust: sync::{Arc, Mutex, mpsc},
    // rust: time::{Duration, Instant},
}

// Saved chunks being read at once, all players together.
ASKED :: 32
// Far chunks a player's batch looks at, closest first: a ring waiting on its reads is not scanned
// to the end each tick.
LOOKS :: 2 * ASKED
// The bodies kept for players coming back: this many bytes, this long.
KEPT_BYTES :: 96 << 20
KEPT_FOR :: Duration::from_secs(300)
// How long a chunk the save doesn't have (or not as a full chunk with its light) is not looked for again.
MISSING_FOR :: Duration::from_secs(30)
// Chunks waiting for the save's writer past which nothing is read: gameplay's saves go first.
WRITE_BACKLOG :: 512
// The brake: the average tick above which the ring pulls in, the one below which it may grow, the
// seconds of short ticks before it does, and then the seconds between its steps out.
HOT_MS :: 40.0
CALM_MS :: 25.0
CALM_SECONDS :: 30
GROW_EVERY :: 5
READERS :: 2

// A level's place in `Far::levels`, and a chunk of it.
    // rust: type Key = (usize, i32, i32);

// What the readers read a level from.
Source :: struct {
    save: ^SaveDir,
    // The hub's encoder for the level, with caches of its own (`ChunkEncoder::detached`).
    encoder: ChunkEncoder,
}

// Reads a saved chunk's body: the game's reads it with `SaveDir::load_far`, encoded by
// `ChunkEncoder::body_alone`.
    // rust: type Reader = Arc<dyn Fn(&Source, i32, i32) -> Option<Vec<u8>> + Send + Sync>;

Level :: struct {
    name: string,
    source: ^Source,
    // Bodies read of the level, with when.
    bodies: FxHashMap<(i32,
}

// A far chunk as [`Far::saved`] finds it.
Saved :: enum {
    Body(Arc<[u8]>),
    // The save has none to send: not sent.
    Missing,
    // Being read, or to be asked for once there is room.
    Waiting,
}

Far :: struct {
    // `max_view_distance`.
    max: i32,
    brake: Brake,
    levels: [dynamic]Level,
    // The level in place (`set_level`).
    here: Maybe(uint),
    // Every body kept, oldest first, with when it was read (a later read of the column leaves its
    // entry behind, skipped once it comes up).
    order: VecDeque<(Key,
    bytes: uint,
    // The reads asked for, true once what they read is out of date.
    asked: FxHashMap<Key,
    missing: FxHashMap<Key,
    jobs: mpsc::Sender<(Key,
    done: mpsc::Receiver<(Key,
}

    // rust: impl Far {
    // A far ring out to `max`, its readers decoding with the game's blocks and biomes.
new :: proc(max: i32, registry: ^'static BlockRegistry, biomes: ^Biomes) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::reading(
    // rust: max,
    // rust: Arc::new(move |source: &Source, x, z| {
    // rust: let chunk = source.save.load_far(x, z, registry, &biomes)?;
    // rust: Some(source.encoder.body_alone(&chunk))
    // rust: }),
    // rust: )
}

reading :: proc(max: i32, read_one: Reader) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (jobs, asked) = mpsc::channel::<(Key, Arc<Source>)>();
    // rust: let (read, done) = mpsc::channel();
    // rust: let asked = Arc::new(Mutex::new(asked));
    // rust: for n in 0..READERS {
    // rust: let (asked, read, read_one) = (asked.clone(), read.clone(), read_one.clone());
    // rust: let _ = std::thread::Builder::new()
    // rust: .name(format!("Far chunk reader #{n}"))
    // rust: .spawn(move || {
    // rust: loop {
                        // The far ring is gone once its sender is.
    // rust: let Ok(((level, x, z), source)) = asked.lock().unwrap().recv() else {
    // rust: return;
}
    // rust: let body = read_one(&source, x, z);
    // rust: if read.send(((level, x, z), body)).is_err() {
    // rust: return;
}
}
    // rust: });
}
    // rust: Self {
    // rust: max,
    // rust: brake: Brake {
    // rust: limit: max,
    // rust: calm: 0,
    // rust: },
    // rust: levels: Vec::new(),
    // rust: here: None,
    // rust: order: VecDeque::new(),
    // rust: bytes: 0,
    // rust: asked: Default::default(),
    // rust: missing: Default::default(),
    // rust: jobs,
    // rust: done,
}
}

    // How far the ring reaches now, the brake's: from the view distance up to `max`.
limit :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.brake.limit
}

    // The level the hub has in place, its saves, and the hub's encoder as set for it.
set_level :: proc(self: ^Self, name: string, save: ^^SaveDir, encoder: ^ChunkEncoder) {
}
    // rust: let source = || {
    // rust: Arc::new(Source {
    // rust: save: save.clone(),
    // rust: encoder: encoder.detached(),
    // rust: })
}
    // rust: let i = match self.levels.iter().position(|l| l.name == name) {
    // rust: Some(i) if Arc::ptr_eq(&self.levels[i].source.save, save) => i,
    // rust: Some(i) => {
                // Another world's level of the same name.
    // rust: self.here = Some(i);
    // rust: self.forget_level();
    // rust: self.levels[i].source = source();
    // rust: i
}
    // rust: None => {
    // rust: self.levels.push(Level {
    // rust: name: name.to_owned(),
    // rust: source: source(),
    // rust: bodies: Default::default(),
    // rust: });
    // rust: self.levels.len() - 1
}
}
    // rust: self.here = Some(i);
}

    // A saved chunk of the level in place, asking for it to be read when there is room.
saved :: proc(self: ^Self, x: i32, z: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Some(level) = self.here else {
    // rust: return Saved::Missing;
}
    // rust: let key = (level, x, z);
    // rust: let bodies = &mut self.levels[level].bodies;
    // rust: match bodies.get(&(x, z)) {
    // rust: Some((at, body)) if at.elapsed() < KEPT_FOR => return Saved::Body(body.clone()),
    // rust: Some(_) => self.bytes -= bodies.remove(&(x, z)).map_or(0, |(_, b)| b.len()),
    // rust: None => {}
}
    // rust: match self.missing.get(&key) {
    // rust: Some(at) if at.elapsed() < MISSING_FOR => return Saved::Missing,
    // rust: Some(_) => {
    // rust: self.missing.remove(&key);
}
    // rust: None => {}
}
    // rust: if self.asked.contains_key(&key) || self.asked.len() >= ASKED {
    // rust: return Saved::Waiting;
}
    // rust: let source = self.levels[level].source.clone();
    // rust: if source.save.pending_writes() <= WRITE_BACKLOG && self.jobs.send((key, source)).is_ok() {
    // rust: self.asked.insert(key, false);
}
    // rust: Saved::Waiting
}

    // Takes in what the readers have read.
poll :: proc(self: ^Self) {
}
    // rust: while let Ok((key, body)) = self.done.try_recv() {
    // rust: match body {
    // rust: _ if self.asked.remove(&key).is_none_or(|stale| stale) => {}
    // rust: Some(body) => self.keep(key, body.into()),
    // rust: None => {
    // rust: self.missing.insert(key, Instant::now());
}
}
}
}

keep :: proc(self: ^Self, key: Key, body: ^[u8]) {
}
    // rust: let (level, x, z) = key;
    // rust: let now = Instant::now();
    // rust: self.bytes += body.len();
    // rust: if let Some((_, old)) = self.levels[level].bodies.insert((x, z), (now, body)) {
    // rust: self.bytes -= old.len();
}
    // rust: self.order.push_back((key, now));
    // rust: while self.bytes > KEPT_BYTES {
    // rust: self.drop_oldest();
}
    // rust: if self.order.len() > 2 * self.bodies() + 1024 {
    // rust: let levels = &self.levels;
    // rust: self.order.retain(|((level, x, z), at)| {
    // rust: levels[*level]
    // rust: .bodies
    // rust: .get(&(*x, *z))
    // rust: .is_some_and(|(t, _)| t == at)
    // rust: });
}
}

bodies :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.levels.iter().map(|l| l.bodies.len()).sum()
}

    // Lets go of the oldest body kept (none when there is none).
drop_oldest :: proc(self: ^Self) {
}
    // rust: let Some(((level, x, z), at)) = self.order.pop_front() else {
    // rust: self.bytes = 0;
    // rust: return;
}
    // rust: let bodies = &mut self.levels[level].bodies;
    // rust: if bodies.get(&(x, z)).is_some_and(|(t, _)| *t == at) {
    // rust: self.bytes -= bodies.remove(&(x, z)).map_or(0, |(_, b)| b.len());
}
}

    // A column of the level in place changed: what was read of it is out of date.
changed :: proc(self: ^Self, x: i32, z: i32) {
}
    // rust: let Some(level) = self.here else {
    // rust: return;
}
    // rust: if let Some((_, body)) = self.levels[level].bodies.remove(&(x, z)) {
    // rust: self.bytes -= body.len();
}
    // rust: if let Some(stale) = self.asked.get_mut(&(level, x, z)) {
    // rust: *stale = true;
}
}

    // The level in place has no players: what changes in it goes unlogged (`tick_level`), so nothing
    // read of it is kept.
forget_level :: proc(self: ^Self) {
}
    // rust: let Some(level) = self.here else {
    // rust: return;
}
    // rust: let bodies = &mut self.levels[level].bodies;
    // rust: if !bodies.is_empty() {
    // rust: self.bytes -= bodies.drain().map(|(_, (_, b))| b.len()).sum::<usize>();
}
    // rust: for (_, stale) in self.asked.iter_mut().filter(|((l, ..), _)| *l == level) {
    // rust: *stale = true;
}
}

    // Once a second, with the average tick (`Brake::step`); what was kept too long is let go.
brake :: proc(self: ^Self, mspt: f64, view: i32) {
}
    // rust: self.brake.step(mspt, view, self.max);
    // rust: while self
    // rust: .order
    // rust: .front()
    // rust: .is_some_and(|(_, at)| at.elapsed() >= KEPT_FOR)
    // rust: {
    // rust: self.drop_oldest();
}
    // rust: self.missing.retain(|_, at| at.elapsed() < MISSING_FOR);
}
}

// How far the ring reaches, and the seconds of short ticks in a row.
Brake :: struct {
    limit: i32,
    calm: u32,
}

    // rust: impl Brake {
    // While ticks take over `HOT_MS` the ring pulls in by two chunks, never inside `view`; after
    // `CALM_SECONDS` of ticks under `CALM_MS` it grows back by one every `GROW_EVERY` seconds.
step :: proc(self: ^Self, mspt: f64, view: i32, max: i32) {
}
    // rust: if mspt > HOT_MS {
    // rust: self.calm = 0;
    // rust: self.limit -= 2;
    // rust: } else if mspt < CALM_MS {
    // rust: self.calm = self.calm.saturating_add(1);
    // rust: if self.calm >= CALM_SECONDS && (self.calm - CALM_SECONDS).is_multiple_of(GROW_EVERY) {
    // rust: self.limit += 1;
}
    // rust: } else {
    // rust: self.calm = 0;
}
    // rust: self.limit = self.limit.min(max).max(view);
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::save::LevelShape;
//     use horizon_protocol::registry::Builtin;

the_brake_pulls_in_fast_and_lets_out_slowly :: proc() {
}
    // rust: let mut b = Brake { limit: 24, calm: 0 };
    // rust: let step = |b: &mut Brake, mspt| {
    // rust: b.step(mspt, 10, 24);
    // rust: b.limit
}
    // rust: assert_eq!(step(&mut b, 60.0), 22);
    // rust: for _ in 0..10 {
    // rust: step(&mut b, 60.0);
}
        // Never inside the view distance.
    // rust: assert_eq!(b.limit, 10);
        // Between the two marks it holds.
    // rust: for _ in 0..100 {
    // rust: assert_eq!(step(&mut b, 30.0), 10);
}
    // rust: for _ in 0..CALM_SECONDS - 1 {
    // rust: assert_eq!(step(&mut b, 5.0), 10);
}
    // rust: assert_eq!(step(&mut b, 5.0), 11);
    // rust: for _ in 0..GROW_EVERY - 1 {
    // rust: assert_eq!(step(&mut b, 5.0), 11);
}
    // rust: assert_eq!(step(&mut b, 5.0), 12);
        // One long second starts the wait again.
    // rust: assert_eq!(step(&mut b, 45.0), 10);
    // rust: for _ in 0..CALM_SECONDS + 100 * GROW_EVERY {
    // rust: step(&mut b, 5.0);
}
    // rust: assert_eq!(b.limit, 24);
}

    // Reads (x, z) as a body of x when x is even, none otherwise; counts them.
far :: proc(reads: ^std::sync::atomic::AtomicUsize) -> F {
    // Ported from Horizon
    return {}
}
    // rust: let mut far = Far::reading(
    // rust: 16,
    // rust: Arc::new(move |_: &Source, x, _| {
    // rust: reads.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    // rust: (x % 2 == 0).then(|| vec![x as u8])
    // rust: }),
    // rust: );
    // rust: let save = Arc::new(SaveDir::new(
    // rust: std::env::temp_dir().join("horizon-far-ring-test"),
    // rust: LevelShape::OVERWORLD,
    // rust: ));
    // rust: let encoder = ChunkEncoder::new(
    // rust: [(Arc::<str>::from("minecraft:air"), false)],
    // rust: &Builtin::default(),
    // rust: &[],
    // rust: &[],
    // rust: );
    // rust: far.set_level("overworld", &save, &encoder);
    // rust: far
}

    // `saved` until the read is in.
read :: proc(far: ^Far, x: i32, z: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: for _ in 0..1000 {
    // rust: far.poll();
    // rust: match far.saved(x, z) {
    // rust: Saved::Waiting => std::thread::sleep(Duration::from_millis(1)),
    // rust: done => return done,
}
}
    // rust: panic!("({x}, {z}) was never read");
}

reads_are_kept_until_their_column_changes :: proc() {
}
    // rust: let reads = Arc::new(std::sync::atomic::AtomicUsize::new(0));
    // rust: let mut far = far(reads.clone());
    // rust: let count = || reads.load(std::sync::atomic::Ordering::Relaxed);
    // rust: assert!(matches!(read(&mut far, 4, 1), Saved::Body(b) if *b == [4]));
    // rust: assert!(matches!(read(&mut far, 3, 1), Saved::Missing));
    // rust: assert_eq!(count(), 2);
        // Walking back: neither is read again.
    // rust: assert!(matches!(far.saved(4, 1), Saved::Body(_)));
    // rust: assert!(matches!(far.saved(3, 1), Saved::Missing));
    // rust: assert_eq!(count(), 2);
        // A block placed in it: read again.
    // rust: far.changed(4, 1);
    // rust: assert!(matches!(far.saved(4, 1), Saved::Waiting));
    // rust: assert!(matches!(read(&mut far, 4, 1), Saved::Body(_)));
    // rust: assert_eq!(count(), 3);
        // Nobody left in the level: nothing kept.
    // rust: far.forget_level();
    // rust: assert!(matches!(far.saved(4, 1), Saved::Waiting));
    // rust: assert_eq!(far.bytes, 0);
}

    // A read that a change overtook is not kept.
a_read_overtaken_by_a_change_is_dropped :: proc() {
}
    // rust: let mut far = far(Arc::default());
    // rust: assert!(matches!(far.saved(6, 0), Saved::Waiting));
    // rust: far.changed(6, 0);
        // Its answer comes back stale and is let go: asked again.
    // rust: for _ in 0..1000 {
    // rust: far.poll();
    // rust: if far.asked.is_empty() {
    // rust: break;
}
    // rust: std::thread::sleep(Duration::from_millis(1));
}
    // rust: assert!(far.levels[0].bodies.is_empty());
    // rust: assert!(matches!(read(&mut far, 6, 0), Saved::Body(_)));
}
}
