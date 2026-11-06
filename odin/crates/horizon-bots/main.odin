//! Transpiled from Horizon Rust crate
package horizon_bots_main

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-bots`: load-test bots for any Minecraft Java Edition 26.3 server, vanilla, Paper or Horizon
// (docs/server.md, section 9). Each bot logs in offline, goes through configuration as vanilla's client
// does, answers keep-alives and pings, accepts teleports, acknowledges chunk batches, and moves at 20 Hz.
//
// Bots fly a little above the ground, so the server must give them creative mode (`gamemode=creative`
// and `force-gamemode=true`): they never touch blocks, so they need no world of their own, and no server
// can refuse their moves for walking into terrain. Every behaviour is deterministic from `--seed`.
//
// `--behaviour fight` is the exception: the bots play in survival (`gamemode=survival`, `force-gamemode=true`,
// and `allow-flight=true` because they hold their spawn height instead of standing on terrain they cannot
// see). They track the entities the server sends, walk to the nearest living one and attack it at vanilla's
// bare-hand cooldown (every 5 ticks). With `--pvp true` (the default) the other bots are targets too, which
// hurts only when the server has `pvp=true`.
//
//   horizon-bots --server 127.0.0.1:25565 --bots 25 --behaviour mixed --seconds 360 --report bots.json
//
// It prints one JSON line a second (bots online, chunks received), one with the first bot's spawn position, and
// writes a summary with `--report`.
// A bot moves only while it holds the chunk it stands in: vanilla's client stops ticking its player in a chunk
// it hasn't received, so a player can't outrun the server's chunk sending, on any server.
// Each bot also keeps the chunks it holds, as a client's chunk cache does, so the report tells chunks that
// entered the view apart from chunks sent again while the bot still held them (`resent`), and counts the
// times the server pulled a bot back (`pulled_back`: a teleport after the first, as for "moved too quickly").

// The report also has wire bytes in and out (`bytes_in`, `bytes_out`, per bot and in total, after
// compression) and join-time percentiles (`join_time`: p50, p99 and max in milliseconds).

// use horizon_protocol::{
    // rust: PROTOCOL_VERSION,
    // rust: buf::{Reader, Writer},
    // rust: connection::{ConnWriter, Connection, Counters},
    // rust: crypto::offline_uuid,
    // rust: entity_data, ids,
    // rust: item::Stack,
    // rust: packets::{
    // rust: Empty, configuration,
    // rust: handshake::{self, Intention},
    // rust: login::{self, ServerHello},
    // rust: play, recipes,
    // rust: },
}
// use serde_json::json;
// use std::{
    // rust: collections::{BTreeMap, HashSet},
    // rust: sync::{
    // rust: Arc, LazyLock, Mutex, OnceLock,
    // rust: atomic::{AtomicBool, AtomicU64, Ordering},
    // rust: },
    // rust: thread,
    // rust: time::{Duration, Instant},
}

    // rust: const HELP: &str = "\
    // rust: horizon-bots: load-test bots for a Minecraft Java Edition 26.3 server (offline mode, creative)

    // rust: --server HOST:PORT     default 127.0.0.1:25565
    // rust: --bots N               default 10
    // rust: --behaviour B          idle, walk, explore, fight or mixed (60 % walk, 20 % explore, 20 % idle); default mixed.
    // rust: fight needs gamemode=survival, force-gamemode=true and allow-flight=true.
    // rust: stand: stays on the ground where the server puts it (/tp), for a survival test.
    // rust: One abusive client, to test a server's limits (run it beside a normal crowd):
    // rust: flood-move (--flood moves a tick, each 64 to 256 blocks away, ignoring chunks),
    // rust: flood-acks (--flood chunk batch acks asking for 64 chunks a tick, while exploring),
    // rust: flood-packets (--flood rotations a tick),
    // rust: flood-chunks (one move a tick, 9.9 blocks straight ahead: as fast as the
    // rust: moved-too-quickly check allows, never waiting for chunks),
    // rust: and --flood a tick of packets that cost the server work:
    // rust: flood-use (place and break stone around itself), flood-click (inventory
    // rust: clicks with a stale state), flood-suggest (command suggestions, every
    // rust: other one 30 000 characters long), flood-book (100 pages of 1024 characters
    // rust: into a writable book), flood-sign (four 384-character lines on the block
    // rust: below), flood-recipe (recipe book placements)
    // rust: --flood N              packets a tick for the flood behaviours; default 100
    // rust: --attack NAME          attack the player NAME twice a second, from wherever the bot is (a reach test),
    // rust: swinging after each attack as vanilla's client does. NAME,NAME...: each of them
    // rust: in the same tick (a multi-target kill aura, for the anticheat's tests);
    // rust: the report gives each bot's last health. A UUID instead of a NAME: the
    // rust: entity with that UUID (a boat summoned with it, say)
    // rust: --attack-after S       start attacking S seconds after joining; default 5
    // rust: --attack-rounds N      stop after N rounds of attacks (each hits every target seen so far once);
    // rust: default no limit
    // rust: --no-swing             attack without swinging (a kill aura hiding its swing, for the anticheat's tests)
    // rust: --no-loaded            never say the level is loaded (ServerboundPlayerLoadedPacket): a vanilla server
    // rust: ignores the player's moves and actions for its first 3 seconds
    // rust: --no-read              stop reading from the server once spawned (a client that lets the
    // rust: server's replies pile up)
    // rust: --join-every SECONDS   default 1
    // rust: --seconds N            how long to run after the first bot joins; default 60
    // rust: --view-distance N      what the bots ask for; default 10
    // rust: --seed N               default 12345
    // rust: --explore-speed B      blocks a second an explore bot flies; default 22 (as fast as chunks come)
    // rust: --pvp B                fight bots also attack each other (true or false); default true
    // rust: --name PREFIX          bot names: PREFIX0, PREFIX1...; default Bot
    // rust: --brand B              the client brand sent in configuration (minecraft:brand); default none
    // rust: --height H             blocks above spawn the bots fly at (walk, explore, idle); default 24
    // rust: --ground               claim the ground in every move (with --height 0 on a flat world: walking
    // rust: on it; higher, or over water: a no-fall or jesus cheat, to test an anticheat)
    // rust: --give SLOT:ID:COUNT,...  creative-slot packets sent once joined (inventory menu slot, item
    // rust: registry id, count), to test what a server takes
    // rust: --click X,Y,Z:SLOT:BUTTON:MODE  3 s after joining, open the block at X,Y,Z (a chest), then a second later
    // rust: click SLOT of its window (ServerboundContainerClickPacket), to test what a server takes
    // rust: --raw TICK:ID:HEX,...  raw serverbound play packets (id, body in hex) sent TICK ticks after joining,
    // rust: to test what a server takes
    // rust: --timer F              cheat, to test an anticheat: tick F times as fast as vanilla's client (1.5: 30 Hz)
    // rust: --report FILE          a JSON summary at the end (- prints it after the per-second lines)
    // rust: --capture FILE         record the first bot's play packets (milliseconds since it joined, id, body)
    // rust: for crates/horizon-protocol/examples/net_replay.rs
    // rust: ";

Behaviour :: enum {
    Idle,
    Stand,
    Walk,
    Explore,
    Fight,
    FloodMove,
    FloodAcks,
    FloodPackets,
    FloodChunks,
    FloodUse,
    FloodClick,
    FloodSuggest,
    FloodBook,
    FloodSign,
    FloodRecipe,
}

    // rust: impl Behaviour {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Idle => "idle",
    // rust: Self::Stand => "stand",
    // rust: Self::Walk => "walk",
    // rust: Self::Explore => "explore",
    // rust: Self::Fight => "fight",
    // rust: Self::FloodMove => "flood-move",
    // rust: Self::FloodAcks => "flood-acks",
    // rust: Self::FloodPackets => "flood-packets",
    // rust: Self::FloodChunks => "flood-chunks",
    // rust: Self::FloodUse => "flood-use",
    // rust: Self::FloodClick => "flood-click",
    // rust: Self::FloodSuggest => "flood-suggest",
    // rust: Self::FloodBook => "flood-book",
    // rust: Self::FloodSign => "flood-sign",
    // rust: Self::FloodRecipe => "flood-recipe",
}
}
}

Options :: struct {
    host: string,
    port: u16,
    bots: uint,
    behaviour: string,
    join_every: f64,
    seconds: u64,
    view_distance: i8,
    seed: u64,
    explore_speed: f64,
    pvp: bool,
    // The players or entity UUIDs to attack, how long after joining to start,
    // and how many rounds.
    attack: Maybe(string),
    attack_after: f64,
    attack_rounds: u32,
    no_swing: bool,
    flood: uint,
    no_read: bool,
    no_loaded: bool,
    height: f64,
    ground: bool,
    // --raw: (tick after joining, packet id, body).
    raw: Vec<(u64,
    // ServerboundSetCreativeModeSlotPackets to send once joined: (slot, item id, count).
    give: Vec<(i16,
    // --click: the block to open, then the slot, button and click type in its window.
    click: Option<([i32,
    name: string,
    // The `minecraft:brand` to send, if any.
    brand: Maybe(string),
    report: Maybe(string),
    // --capture: where the first bot's play packets go.
    capture: Maybe(string),
    // How many times as fast as vanilla's 20 Hz the bots tick (a timer cheat above 1).
    timer: f64,
}

options :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut o = Options {
    // rust: host: "127.0.0.1".into(),
    // rust: port: 25565,
    // rust: bots: 10,
    // rust: behaviour: "mixed".into(),
    // rust: join_every: 1.0,
    // rust: seconds: 60,
    // rust: view_distance: 10,
    // rust: seed: 12345,
    // rust: explore_speed: 22.0,
    // rust: pvp: true,
    // rust: attack: None,
    // rust: attack_after: 5.0,
    // rust: attack_rounds: u32::MAX,
    // rust: no_swing: false,
    // rust: flood: 100,
    // rust: no_read: false,
    // rust: no_loaded: false,
    // rust: height: 24.0,
    // rust: ground: false,
    // rust: raw: Vec::new(),
    // rust: give: Vec::new(),
    // rust: click: None,
    // rust: name: "Bot".into(),
    // rust: report: None,
    // rust: capture: None,
    // rust: brand: None,
    // rust: timer: 1.0,
}
    // rust: let mut args = std::env::args().skip(1);
    // rust: while let Some(arg) = args.next() {
    // rust: if arg == "-h" || arg == "--help" {
    // rust: print!("{HELP}");
    // rust: std::process::exit(0);
}
    // rust: if arg == "--no-read" {
    // rust: o.no_read = true;
    // rust: continue;
}
    // rust: if arg == "--no-swing" {
    // rust: o.no_swing = true;
    // rust: continue;
}
    // rust: if arg == "--no-loaded" {
    // rust: o.no_loaded = true;
    // rust: continue;
}
    // rust: if arg == "--ground" {
    // rust: o.ground = true;
    // rust: continue;
}
    // rust: let value = args.next().ok_or(format!("{arg} needs a value"))?;
    // rust: let number = |what: &str| format!("{arg} needs {what}, not {value:?}");
    // rust: match arg.as_str() {
    // rust: "--server" => {
    // rust: let (host, port) = value.rsplit_once(':').unwrap_or((&value, "25565"));
    // rust: o.host = host.into();
    // rust: o.port = port.parse().map_err(|_| number("a port"))?;
}
    // rust: "--bots" => o.bots = value.parse().map_err(|_| number("a number"))?,
    // rust: "--behaviour" => o.behaviour = value,
    // rust: "--join-every" => o.join_every = value.parse().map_err(|_| number("seconds"))?,
    // rust: "--seconds" => o.seconds = value.parse().map_err(|_| number("seconds"))?,
    // rust: "--view-distance" => o.view_distance = value.parse().map_err(|_| number("2 to 32"))?,
    // rust: "--seed" => o.seed = value.parse().map_err(|_| number("a number"))?,
    // rust: "--explore-speed" => {
    // rust: o.explore_speed = value.parse().map_err(|_| number("blocks a second"))?;
}
    // rust: "--pvp" => o.pvp = value.parse().map_err(|_| number("true or false"))?,
    // rust: "--flood" => o.flood = value.parse().map_err(|_| number("packets a tick"))?,
    // rust: "--attack" => o.attack = Some(value),
    // rust: "--attack-after" => o.attack_after = value.parse().map_err(|_| number("seconds"))?,
    // rust: "--attack-rounds" => o.attack_rounds = value.parse().map_err(|_| number("a number"))?,
    // rust: "--name" => o.name = value,
    // rust: "--report" => o.report = Some(value),
    // rust: "--capture" => o.capture = Some(value),
    // rust: "--brand" => o.brand = Some(value),
    // rust: "--give" => {
    // rust: for part in value.split(',') {
    // rust: let n: Vec<&str> = part.split(':').collect();
    // rust: let parsed = match n[..] {
    // rust: [s, i, c] => s.parse().ok().zip(i.parse().ok()).zip(c.parse().ok()),
    // rust: _ => None,
}
    // rust: let ((slot, item), count) = parsed.ok_or_else(|| number("SLOT:ID:COUNT"))?;
    // rust: o.give.push((slot, item, count));
}
}
    // rust: "--click" => {
    // rust: let bad = || number("X,Y,Z:SLOT:BUTTON:MODE");
    // rust: let n: Vec<&str> = value.split(':').collect();
    // rust: let [at, slot, button, mode] = n[..] else {
    // rust: return Err(bad());
}
    // rust: let at: Vec<i32> = at
    // rust: .split(',')
    // rust: .map(str::parse)
    // rust: .collect::<Result<_, _>>()
    // rust: .map_err(|_| bad())?;
    // rust: let at = <[i32; 3]>::try_from(at).map_err(|_| bad())?;
    // rust: let parse = |s: &str| s.parse::<i32>().map_err(|_| bad());
    // rust: o.click = Some((at, parse(slot)? as i16, parse(button)? as i8, parse(mode)?));
}
    // rust: "--raw" => {
    // rust: for part in value.split(',') {
    // rust: let bad = || number("TICK:ID:HEX");
    // rust: let [tick, id, hex] = part.split(':').collect::<Vec<_>>()[..] else {
    // rust: return Err(bad());
}
    // rust: let body = (0..hex.len())
    // rust: .step_by(2)
    // rust: .map(|i| {
    // rust: hex.get(i..i + 2)
    // rust: .and_then(|b| u8::from_str_radix(b, 16).ok())
    // rust: })
    // rust: .collect::<Option<Vec<u8>>>()
    // rust: .ok_or_else(bad)?;
    // rust: o.raw.push((
    // rust: tick.parse().map_err(|_| bad())?,
    // rust: id.parse().map_err(|_| bad())?,
    // rust: body,
    // rust: ));
}
}
    // rust: "--height" => o.height = value.parse().map_err(|_| number("blocks"))?,
    // rust: "--timer" => {
    // rust: o.timer = value.parse().map_err(|_| number("a speed, like 1.5"))?;
    // rust: if !(o.timer >= 0.1 && o.timer <= 20.0) {
    // rust: return Err(format!("--timer {value}: use 0.1 to 20"));
}
}
    // rust: _ => return Err(format!("unknown option {arg}; --help lists them")),
}
}
    // rust: const BEHAVIOURS: [&str; 16] = [
    // rust: "idle",
    // rust: "walk",
    // rust: "explore",
    // rust: "fight",
    // rust: "mixed",
    // rust: "stand",
    // rust: "flood-move",
    // rust: "flood-acks",
    // rust: "flood-packets",
    // rust: "flood-chunks",
    // rust: "flood-use",
    // rust: "flood-click",
    // rust: "flood-suggest",
    // rust: "flood-book",
    // rust: "flood-sign",
    // rust: "flood-recipe",
    // rust: ];
    // rust: if !BEHAVIOURS.contains(&o.behaviour.as_str()) {
    // rust: return Err(format!(
    // rust: "--behaviour {}: use idle, walk, explore, fight, mixed or a flood behaviour (--help lists them)",
    // rust: o.behaviour
    // rust: ));
}
    // rust: Ok(o)
}

// What one bot is doing, shared between its reader and its ticks.
Bot :: struct {
    online: AtomicBool,
    chunks: AtomicU64,
    // Chunks received while the bot already held them (no ForgetLevelChunk in between).
    resent: AtomicU64,
    // Different chunks received over the run.
    unique: AtomicU64,
    forgotten: AtomicU64,
    // Teleports after the spawn one: the server refused a move.
    pulled_back: AtomicU64,
    // Ticks the bot couldn't move because it didn't hold its chunk yet.
    waited: AtomicU64,
    // Attack packets sent (fight bots and --attack).
    attacks: AtomicU64,
    // The entities the server tells the bot about (fight bots only).
    entities: Mutex<Entities>,
    // The chunks the bot holds (ClientChunkCache).
    held: Mutex<HashSet<(i32,
    // Where the server last put the bot (a teleport), to start from.
    teleport: Mutex<Option<[f64,
    error: Mutex<Maybe(string)>,
    joined_after_ms: AtomicU64,
    // The connection's byte counters (wire bytes, after compression and encryption), set once it is open.
    counters: OnceLock<^Counters>,
    // The bot stopped reading (--no-read).
    deaf: AtomicBool,
    // `--attack`: each target's UUID and, once AddEntity showed it, its entity id.
    target: Mutex<Vec<(u128,
    // The last SetHealth.
    health: Mutex<Maybe(f32)>,
}

    // rust: impl Bot {
bytes_in :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.counters
    // rust: .get()
    // rust: .map_or(0, |c| c.bytes_in.load(Ordering::Relaxed).max(0) as u64)
}
bytes_out :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.counters
    // rust: .get()
    // rust: .map_or(0, |c| c.bytes_out.load(Ordering::Relaxed).max(0) as u64)
}
}

// Nearest-rank percentile (`p` in 0..=100) of an ascending-sorted slice; 0 when it is empty.
percentile :: proc(sorted: ^[u64], p: u64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: if sorted.is_empty() {
    // rust: return 0;
}
    // rust: let rank = (p * sorted.len() as u64).div_ceil(100).max(1) as usize;
    // rust: sorted[rank - 1]
}

// Join-time summary in milliseconds over the bots that got in: count, p50, p99 and max.
join_summary :: proc(mut times: [dynamic]u64) -> s {
    // Ported from Horizon
    return {}
}
    // rust: times.sort_unstable();
    // rust: json!({
    // rust: "count": times.len(),
    // rust: "p50_ms": percentile(&times, 50),
    // rust: "p99_ms": percentile(&times, 99),
    // rust: "max_ms": times.last().copied().unwrap_or(0),
    // rust: })
}

// An `--attack` target's UUID: a UUID as written (`8-4-4-4-12` hex), else
// the offline UUID of the player with that name (a name has no `-`).
target_uuid :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let hex: String = name.chars().filter(|&c| c != '-').collect();
    // rust: match u128::from_str_radix(&hex, 16) {
    // rust: Ok(uuid) if name.contains('-') && hex.len() == 32 => uuid,
    // rust: _ => offline_uuid(name),
}
}

// A small deterministic generator (SplitMix64), so every run moves the bots the same way.
Random :: struct {
    // rust: impl Random {
next :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
    // rust: let mut z = self.0;
    // rust: z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
    // rust: z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
    // rust: z ^ (z >> 31)
}
unit :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (self.next() >> 11) as f64 / (1u64 << 53) as f64
}
}

// Vanilla's bare-hand attack speed is 4 a second: a full-strength swing every 20 / 4 ticks.
ATTACK_COOLDOWN_TICKS :: 5
// How far, in blocks, a fight bot strikes (the survival entity interaction range is 3).
ATTACK_REACH :: 2.5
// A fight bot walks up to this horizontal distance, so it does not stand inside its target.
CLOSE_IN :: 1.5
// Walking speed in blocks a tick.
FIGHT_STEP :: 0.215
// `LivingEntity.DATA_HEALTH_ID`: only living entities carry it, and it is sent once it differs from 1.
HEALTH_DATA :: 9

// What a fight bot knows of one entity.
Tracked :: struct {
    uuid: u128,
    pos: [f64,
    // Set once the server sends the health of the entity, which only living entities have.
    health: Maybe(f32),
}

// The entities around a bot, from AddEntity, the move packets, SetEntityData and RemoveEntities.
// Ordered by id, so ties between equally near targets always go to the same entity.
Entities :: struct {

    // rust: impl Entities {
update :: proc(self: ^Self, id: i32, body: []u8) {
}
    // rust: let Ok(packet) = play::Clientbound::decode(id, body) else {
    // rust: return;
}
    // rust: match packet {
    // rust: play::Clientbound::AddEntity(p) => {
    // rust: self.0.insert(
    // rust: p.id,
    // rust: Tracked {
    // rust: uuid: p.uuid,
    // rust: pos: p.position,
    // rust: health: None,
    // rust: },
    // rust: );
}
    // rust: play::Clientbound::MoveEntityPos(play::MoveEntityPos(m))
    // rust: | play::Clientbound::MoveEntityPosRot(play::MoveEntityPosRot(m)) => {
    // rust: if let (Some(e), Some(delta)) = (self.0.get_mut(&m.id), &m.delta) {
    // rust: e.pos = delta.end(e.pos);
}
}
    // rust: play::Clientbound::EntityPositionSync(p) => {
    // rust: if let Some(e) = self.0.get_mut(&p.id) {
    // rust: e.pos = p.path.end();
}
}
    // rust: play::Clientbound::SetEntityData(p) => {
    // rust: if let Some(e) = self.0.get_mut(&p.id) {
    // rust: for (index, _, value) in &p.values {
    // rust: if *index == HEALTH_DATA
    // rust: && let entity_data::Value::Float(health) = value
    // rust: {
    // rust: e.health = Some(*health);
}
}
}
}
    // rust: play::Clientbound::RemoveEntities(p) => {
    // rust: for id in p.ids {
    // rust: self.0.remove(&id);
}
}
    // rust: _ => {}
}
}

    // The nearest living entity that is not dead; other bots only when `pvp`.
nearest :: proc(self: ^Self, from: [f64; 3], pvp: bool, bots: ^map[u128]struct{}) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut best: Option<(f64, i32, [f64; 3])> = None;
    // rust: for (id, e) in &self.0 {
    // rust: if !e.health.is_some_and(|h| h > 0.0) || (!pvp && bots.contains(&e.uuid)) {
    // rust: continue;
}
    // rust: let d = distance(from, e.pos);
    // rust: if best.is_none_or(|(b, ..)| d < b) {
    // rust: best = Some((d, *id, e.pos));
}
}
    // rust: best.map(|(_, id, pos)| (id, pos))
}
}

distance :: proc(a: [f64; 3], b: [f64; 3]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ((a[0] - b[0]).powi(2) + (a[1] - b[1]).powi(2) + (a[2] - b[2]).powi(2)).sqrt()
}

// One tick of a fighting bot with a target: walk up to it, and strike once the cooldown is over.
// Returns the entity to attack. `since_attack` counts ticks since the last swing.
fight_tick :: proc(pos: ^[f64; 3], target: (i32) {
}
    // rust: *since_attack = since_attack.saturating_add(1);
    // rust: let (id, at) = target;
    // rust: let (dx, dz) = (at[0] - pos[0], at[2] - pos[2]);
    // rust: let horizontal = dx.hypot(dz);
    // rust: if horizontal > CLOSE_IN {
    // rust: let step = FIGHT_STEP.min(horizontal - CLOSE_IN);
    // rust: pos[0] += dx / horizontal * step;
    // rust: pos[2] += dz / horizontal * step;
}
    // rust: if *since_attack >= ATTACK_COOLDOWN_TICKS && distance(*pos, at) <= ATTACK_REACH {
    // rust: *since_attack = 0;
    // rust: return Some(id);
}
    // rust: None
}

// One tick of walking to random points around the spawn, at sprint speed (5.6 blocks a second).
    // rust: fn walk_step(
    // rust: pos: &mut [f64; 3],
    // rust: target: &mut [f64; 3],
    // rust: spawn: [f64; 3],
    // rust: cruise: f64,
    // rust: random: &mut Random,
    // rust: ) {
    // rust: let (dx, dz) = (target[0] - pos[0], target[2] - pos[2]);
    // rust: let distance = dx.hypot(dz);
    // rust: if distance < 1.0 {
    // rust: let angle = random.unit() * std::f64::consts::TAU;
    // rust: let reach = 8.0 + random.unit() * 40.0;
    // rust: *target = [
    // rust: spawn[0] + angle.cos() * reach,
    // rust: cruise,
    // rust: spawn[2] + angle.sin() * reach,
    // rust: ];
    // rust: } else {
    // rust: let step = 0.28_f64.min(distance);
    // rust: pos[0] += dx / distance * step;
    // rust: pos[2] += dz / distance * step;
}
}

// One bot thread that panics poisons the locks it held; the others and the report go on.
    // rust: fn lock<T>(m: &Mutex<T>) -> std::sync::MutexGuard<'_, T> {
    // rust: m.lock().unwrap_or_else(std::sync::PoisonError::into_inner)
}

raw :: proc(id: i32, write: impl FnOnce(^Writer) {
}
    // rust: let mut w = Writer::new();
    // rust: w.varint(id);
    // rust: write(&mut w);
    // rust: w.data
}

// Item ids of the pinned version (26.3's item registry).
STONE :: 1
WRITABLE_BOOK :: 1371

// The `i`th packet of a costly flood this tick, the bot at `pos`; none for other behaviours.
    // rust: fn costly(
    // rust: behaviour: Behaviour,
    // rust: i: usize,
    // rust: sequence: i32,
    // rust: pos: [f64; 3],
    // rust: random: &mut Random,
    // rust: ) -> Option<Vec<u8>> {
//     use ids::play::serverbound as sb;
    // rust: static LONG_COMMAND: LazyLock<String> =
    // rust: LazyLock::new(|| format!("/msg {}", "x".repeat(30_000)));
    // rust: static BOOK: LazyLock<Vec<u8>> = LazyLock::new(|| {
    // rust: play::Serverbound::EditBook(play::EditBook {
    // rust: slot: 0,
    // rust: pages: vec!["a".repeat(1024); 100],
    // rust: title: None,
    // rust: })
    // rust: .encode()
    // rust: });
    // rust: let block = pos.map(|v| v.floor() as i32);
    // rust: let packet = match behaviour {
    // rust: Behaviour::FloodUse => {
            // A block within reach: place stone there, or break what is there.
    // rust: let at = [0, 1, 2].map(|k| block[k] + (random.unit() * 7.0) as i32 - 3);
    // rust: if i % 2 == 0 {
    // rust: play::Serverbound::UseItemOn(play::UseItemOn {
    // rust: hand: 0,
    // rust: pos: at,
    // rust: face: 1,
    // rust: cursor: [0.5, 1.0, 0.5],
    // rust: inside: false,
    // rust: world_border: false,
    // rust: sequence,
    // rust: })
    // rust: } else {
    // rust: play::Serverbound::PlayerAction(play::PlayerAction {
    // rust: action: 0,
    // rust: pos: at,
    // rust: direction: 1,
    // rust: sequence,
    // rust: })
}
}
    // rust: Behaviour::FloodClick => play::Serverbound::ContainerClick(play::ContainerClick {
    // rust: container: 0,
    // rust: state: 0,
    // rust: slot: 36 + (i % 9) as i16,
    // rust: button: 0,
    // rust: input: 0,
    // rust: changed: Vec::new(),
    // rust: carried: None,
    // rust: }),
    // rust: Behaviour::FloodSuggest => {
    // rust: let text = if i % 2 == 0 {
    // rust: "/"
    // rust: } else {
    // rust: LONG_COMMAND.as_str()
}
    // rust: return Some(raw(sb::COMMAND_SUGGESTION, |w| {
    // rust: w.varint(sequence);
    // rust: w.string(text);
    // rust: }));
}
    // rust: Behaviour::FloodBook => return Some(BOOK.clone()),
    // rust: Behaviour::FloodSign => play::Serverbound::SignUpdate(play::SignUpdate {
    // rust: pos: [block[0], block[1] - 1, block[2]],
    // rust: lines: std::array::from_fn(|_| "a".repeat(384)),
    // rust: front: true,
    // rust: }),
    // rust: Behaviour::FloodRecipe => play::Serverbound::PlaceRecipe(recipes::PlaceRecipe {
    // rust: container: 0,
    // rust: recipe: (i % 2042) as i32,
    // rust: use_max: true,
    // rust: }),
    // rust: _ => return None,
}
    // rust: Some(packet.encode())
}

err :: proc(e: impl std::fmt::Display) -> S {
    // Ported from Horizon
    return {}
}
    // rust: e.to_string()
}

// Handshake, offline login and configuration; returns the connection in the play state.
join :: proc(o: ^Options, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut c = Connection::connect(&o.host, o.port, Duration::from_secs(10)).map_err(err)?;
    // rust: c.send(
    // rust: &handshake::Serverbound::Intention(Intention {
    // rust: protocol: PROTOCOL_VERSION,
    // rust: host: o.host.clone(),
    // rust: port: o.port,
    // rust: intent: handshake::LOGIN,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(err)?;
    // rust: c.send(
    // rust: &login::Serverbound::Hello(ServerHello {
    // rust: name: name.into(),
    // rust: uuid: offline_uuid(name),
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(err)?;
    // rust: loop {
    // rust: let (id, body) = c.recv().map_err(err)?;
    // rust: match login::Clientbound::decode(id, &body).map_err(err)? {
    // rust: login::Clientbound::Compression(p) => c.set_compression(p.threshold),
    // rust: login::Clientbound::LoginFinished(_) => {
    // rust: c.send(&login::Serverbound::LoginAcknowledged(Empty).encode())
    // rust: .map_err(err)?;
    // rust: break;
}
    // rust: login::Clientbound::Disconnect(p) => return Err(format!("refused: {}", p.reason_json)),
    // rust: login::Clientbound::Hello(_) => {
    // rust: return Err("the server is in online mode; bots need online-mode=false".into());
}
    // rust: login::Clientbound::CustomQuery(p) => c
    // rust: .send(
    // rust: &login::Serverbound::CustomQueryAnswer(login::CustomQueryAnswer {
    // rust: transaction: p.transaction,
    // rust: payload: None,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(err)?,
    // rust: login::Clientbound::CookieRequest(p) => c
    // rust: .send(
    // rust: &login::Serverbound::CookieResponse(login::CookieResponse {
    // rust: key: p.key,
    // rust: payload: None,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(err)?,
    // rust: login::Clientbound::Unknown(..) => {}
}
}
//     use ids::configuration::clientbound as cb;
    // rust: c.send(
    // rust: &configuration::Serverbound::ClientInformation(configuration::ClientInformation::new(
    // rust: o.view_distance,
    // rust: ))
    // rust: .encode(),
    // rust: )
    // rust: .map_err(err)?;
    // ClientBrandRetriever: vanilla's client says "vanilla", Horizon's "horizon".
    // rust: if let Some(brand) = &o.brand {
    // rust: let mut w = Writer::new();
    // rust: w.string(brand);
    // rust: c.send(
    // rust: &configuration::Serverbound::CustomPayload(configuration::CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: w.data,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(err)?;
}
    // rust: loop {
    // rust: let (id, body) = c.recv().map_err(err)?;
    // rust: let reply = match id {
    // rust: cb::SELECT_KNOWN_PACKS
    // rust: | cb::KEEP_ALIVE
    // rust: | cb::PING
    // rust: | cb::CODE_OF_CONDUCT
    // rust: | cb::COOKIE_REQUEST
    // rust: | cb::DISCONNECT
    // rust: | cb::FINISH_CONFIGURATION => {
    // rust: match configuration::Clientbound::decode(id, &body).map_err(err)? {
    // rust: configuration::Clientbound::SelectKnownPacks(p) => {
    // rust: configuration::Serverbound::SelectKnownPacks(p)
}
    // rust: configuration::Clientbound::KeepAlive(p) => {
    // rust: configuration::Serverbound::KeepAlive(p)
}
    // rust: configuration::Clientbound::Ping(p) => configuration::Serverbound::Pong(p),
    // rust: configuration::Clientbound::CodeOfConduct(_) => {
    // rust: configuration::Serverbound::AcceptCodeOfConduct(Empty)
}
    // rust: configuration::Clientbound::CookieRequest(p) => {
    // rust: configuration::Serverbound::CookieResponse(configuration::CookieResponse {
    // rust: key: p.key,
    // rust: payload: None,
    // rust: })
}
    // rust: configuration::Clientbound::Disconnect(p) => {
    // rust: let reason = horizon_protocol::text::plain(&p.reason, &Default::default());
    // rust: return Err(format!("disconnected during configuration: {reason}"));
}
    // rust: configuration::Clientbound::FinishConfiguration(_) => {
    // rust: c.send(&configuration::Serverbound::FinishConfiguration(Empty).encode())
    // rust: .map_err(err)?;
    // rust: return Ok(c);
}
    // rust: _ => continue,
}
}
    // rust: _ => continue,
}
    // rust: c.send(&reply.encode()).map_err(err)?;
}
}

// ChunkBatchSizeCalculator: the chunks per tick a vanilla client asks for, from how long its batches take
// to arrive.
BatchSize :: struct {
    nanos_per_chunk: f64,
    old_samples_weight: u32,
    started: Instant,
}

    // rust: impl BatchSize {
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: nanos_per_chunk: 2_000_000.0,
    // rust: old_samples_weight: 1,
    // rust: started: Instant::now(),
}
}
finished :: proc(self: ^Self, size: i32) {
}
    // rust: if size > 0 {
    // rust: let per_chunk = self.started.elapsed().as_nanos() as f64 / f64::from(size);
    // rust: let clamped = per_chunk.clamp(self.nanos_per_chunk / 3.0, self.nanos_per_chunk * 3.0);
    // rust: let weight = f64::from(self.old_samples_weight);
    // rust: self.nanos_per_chunk = (self.nanos_per_chunk * weight + clamped) / (weight + 1.0);
    // rust: self.old_samples_weight = (self.old_samples_weight + 1).min(49);
}
}
desired_chunks_per_tick :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (7_000_000.0 / self.nanos_per_chunk) as f32
}
}

// `--capture`: one record per play packet, little-endian: u32 milliseconds since the
// bot joined, i32 packet id, u32 body length, then the body (without the id).
Capture :: struct {
    out: std::io::BufWriter<std::fs::File>,
    start: Instant,
    // The second last flushed: the process may end before the reader thread does.
    flushed: u32,
}
    // rust: impl Capture {
create :: proc(path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match std::fs::File::create(path) {
    // rust: Ok(file) => Some(Self {
    // rust: out: std::io::BufWriter::new(file),
    // rust: start: Instant::now(),
    // rust: flushed: 0,
    // rust: }),
    // rust: Err(e) => {
    // rust: eprintln!("--capture {path}: {e}");
    // rust: None
}
}
}
record :: proc(self: ^Self, id: i32, body: []u8) {
}
//         use std::io::Write;
    // rust: let ms = self.start.elapsed().as_millis() as u32;
    // rust: let mut head = [0u8; 12];
    // rust: head[..4].copy_from_slice(&ms.to_le_bytes());
    // rust: head[4..8].copy_from_slice(&id.to_le_bytes());
    // rust: head[8..].copy_from_slice(&(body.len() as u32).to_le_bytes());
    // rust: let _ = self
    // rust: .out
    // rust: .write_all(&head)
    // rust: .and_then(|()| self.out.write_all(body));
    // rust: if ms / 1000 != self.flushed {
    // rust: self.flushed = ms / 1000;
    // rust: let _ = self.out.flush();
}
}
}

// Reads the play state: answers what a client must answer, counts chunks, records teleports.
    // rust: fn read(
    // rust: mut reader: horizon_protocol::connection::ConnReader,
    // rust: writer: Arc<Mutex<ConnWriter>>,
    // rust: bot: Arc<Bot>,
    // rust: track: bool,
    // rust: mut capture: Option<Capture>,
    // rust: ) {
//     use ids::play::clientbound as cb;
//     use ids::play::serverbound as sb;
    // rust: let send = |body: Vec<u8>| lock(&writer).send(&body);
    // rust: let mut seen = HashSet::new();
    // rust: let mut batch = BatchSize::new();
    // rust: let mut teleports = 0u64;
    // rust: loop {
    // rust: if bot.deaf.load(Ordering::Relaxed) {
    // rust: while bot.online.load(Ordering::SeqCst) {
    // rust: thread::sleep(Duration::from_millis(100));
}
    // rust: return;
}
    // rust: let (id, body) = match reader.recv() {
    // rust: Ok(packet) => packet,
    // rust: Err(e) => {
    // rust: if bot.online.swap(false, Ordering::SeqCst) {
    // rust: *lock(&bot.error) = Some(e.to_string());
}
    // rust: return;
}
}
    // rust: if let Some(c) = &mut capture {
    // rust: c.record(id, &body);
}
    // rust: let mut r = Reader::new(&body);
    // rust: let sent = match id {
    // rust: cb::KEEP_ALIVE => match r.i64() {
    // rust: Ok(v) => send(raw(sb::KEEP_ALIVE, |w| w.i64(v))),
    // rust: Err(_) => Ok(()),
    // rust: },
    // rust: cb::PING => match r.i32() {
    // rust: Ok(v) => send(raw(sb::PONG, |w| w.i32(v))),
    // rust: Err(_) => Ok(()),
    // rust: },
    // rust: cb::LEVEL_CHUNK_WITH_LIGHT => {
    // rust: bot.chunks.fetch_add(1, Ordering::Relaxed);
    // rust: if let (Ok(x), Ok(z)) = (r.i32(), r.i32()) {
    // rust: if !lock(&bot.held).insert((x, z)) {
    // rust: bot.resent.fetch_add(1, Ordering::Relaxed);
}
    // rust: if seen.insert((x, z)) {
    // rust: bot.unique.fetch_add(1, Ordering::Relaxed);
}
}
    // rust: Ok(())
}
    // rust: cb::FORGET_LEVEL_CHUNK => {
    // rust: if let Ok(play::Clientbound::ForgetLevelChunk(p)) =
    // rust: play::Clientbound::decode(id, &body)
    // rust: && lock(&bot.held).remove(&(p.pos[0], p.pos[1]))
    // rust: {
    // rust: bot.forgotten.fetch_add(1, Ordering::Relaxed);
}
    // rust: Ok(())
}
    // rust: cb::ADD_ENTITY => {
    // rust: if let Ok(play::Clientbound::AddEntity(p)) = play::Clientbound::decode(id, &body) {
    // rust: for target in lock(&bot.target).iter_mut() {
    // rust: if target.0 == p.uuid {
    // rust: target.1 = Some(p.id);
}
}
}
    // rust: if track {
    // rust: lock(&bot.entities).update(id, &body);
}
    // rust: Ok(())
}
    // rust: cb::SET_HEALTH => {
    // rust: if let Ok(play::Clientbound::SetHealth(p)) = play::Clientbound::decode(id, &body) {
    // rust: *lock(&bot.health) = Some(p.health);
}
    // rust: Ok(())
}
    // rust: cb::CHUNK_BATCH_START => {
    // rust: batch.started = Instant::now();
    // rust: Ok(())
}
    // rust: cb::CHUNK_BATCH_FINISHED => {
    // rust: batch.finished(r.varint().unwrap_or(0));
    // rust: send(
    // rust: play::Serverbound::ChunkBatchReceived(play::ChunkBatchReceived {
    // rust: chunks_per_tick: batch.desired_chunks_per_tick(),
    // rust: })
    // rust: .encode(),
    // rust: )
}
    // rust: cb::PLAYER_POSITION => match play::Clientbound::decode(id, &body) {
    // rust: Ok(play::Clientbound::PlayerPosition(p)) => {
    // rust: let mut at = lock(&bot.teleport);
    // rust: let previous = at.unwrap_or([0.0; 3]);
                    // Relative flags: X 1, Y 2, Z 4.
    // rust: let pos: [f64; 3] = std::array::from_fn(|i| {
    // rust: if p.relatives & (1 << i) != 0 {
    // rust: previous[i] + p.position[i]
    // rust: } else {
    // rust: p.position[i]
}
    // rust: });
    // rust: *at = Some(pos);
    // rust: teleports += 1;
    // rust: if teleports > 1 {
    // rust: bot.pulled_back.fetch_add(1, Ordering::Relaxed);
}
    // rust: send(
    // rust: play::Serverbound::AcceptTeleportation(play::AcceptTeleportation {
    // rust: id: p.teleport,
    // rust: x: pos[0],
    // rust: y: pos[1],
    // rust: z: pos[2],
    // rust: yaw: p.yaw,
    // rust: pitch: p.pitch,
    // rust: })
    // rust: .encode(),
    // rust: )
}
    // rust: _ => Ok(()),
    // rust: },
    // rust: cb::MOVE_ENTITY_POS
    // rust: | cb::MOVE_ENTITY_POS_ROT
    // rust: | cb::ENTITY_POSITION_SYNC
    // rust: | cb::SET_ENTITY_DATA
    // rust: | cb::REMOVE_ENTITIES
    // rust: if track =>
    // rust: {
    // rust: lock(&bot.entities).update(id, &body);
    // rust: Ok(())
}
    // rust: cb::DISCONNECT | cb::START_CONFIGURATION => {
    // rust: bot.online.store(false, Ordering::SeqCst);
    // rust: *lock(&bot.error) = Some(if id == cb::DISCONNECT {
    // rust: format!(
    // rust: "disconnected: {}",
    // rust: String::from_utf8_lossy(&body)
    // rust: .chars()
    // rust: .filter(|c| !c.is_control())
    // rust: .collect::<String>()
    // rust: )
    // rust: } else {
    // rust: "sent back to configuration".into()
    // rust: });
    // rust: return;
}
    // rust: _ => Ok(()),
}
    // rust: if sent.is_err() {
    // rust: bot.online.store(false, Ordering::SeqCst);
    // rust: return;
}
}
}

// One bot: join, then move every 50 ms until `until`.
    // rust: fn run_bot(
    // rust: o: Arc<Options>,
    // rust: index: usize,
    // rust: behaviour: Behaviour,
    // rust: bots: Arc<HashSet<u128>>,
    // rust: bot: Arc<Bot>,
    // rust: until: Arc<Mutex<Option<Instant>>>,
    // rust: ) {
    // rust: let name = format!("{}{index}", o.name);
    // rust: let asked = Instant::now();
    // rust: let connection = match join(&o, &name) {
    // rust: Ok(c) => c,
    // rust: Err(e) => {
    // rust: *lock(&bot.error) = Some(e);
    // rust: return;
}
}
    // rust: let (reader, writer) = connection.split();
    // rust: let _ = bot.counters.set(reader.counters.clone());
    // rust: let writer = Arc::new(Mutex::new(writer));
    // rust: *lock(&bot.target) = o
    // rust: .attack
    // rust: .iter()
    // rust: .flat_map(|names| names.split(','))
    // rust: .map(|name| (target_uuid(name), None))
    // rust: .collect();
    // rust: bot.online.store(true, Ordering::SeqCst);
    // rust: {
    // rust: let (writer, bot) = (writer.clone(), bot.clone());
    // rust: let track = behaviour == Behaviour::Fight;
    // rust: let capture = (index == 0)
    // rust: .then(|| o.capture.as_deref().and_then(Capture::create))
    // rust: .flatten();
    // rust: thread::spawn(move || read(reader, writer, bot, track, capture));
}
//     use ids::play::serverbound as sb;
    // Wait for the spawn position.
    // rust: let spawn = loop {
    // rust: if let Some(at) = *lock(&bot.teleport) {
    // rust: break at;
}
    // rust: if !bot.online.load(Ordering::SeqCst) || asked.elapsed() > Duration::from_secs(60) {
    // rust: if lock(&bot.error).is_none() {
    // rust: *lock(&bot.error) = Some("no spawn position within 60 s".into());
}
    // rust: return;
}
    // rust: thread::sleep(Duration::from_millis(20));
}
    // rust: bot.joined_after_ms
    // rust: .store(asked.elapsed().as_millis() as u64, Ordering::SeqCst);
    // rust: if index == 0 {
        // Where the bots gather, for a client that comes to watch them (tools/perf_bench.py --server-bots).
    // rust: println!("{}", json!({ "spawn": spawn }));
}
    // rust: let send = |body: Vec<u8>| lock(&writer).send(&body).is_ok();
    // rust: if !o.no_loaded {
    // rust: send(raw(sb::PLAYER_LOADED, |_| {}));
}
    // rust: bot.deaf.store(o.no_read, Ordering::Relaxed);
    // What the costly floods need in hand (creative: the server takes the bot's word for it).
    // rust: let tool = match behaviour {
    // rust: Behaviour::FloodUse => Some(Stack::new(STONE, 64)),
    // rust: Behaviour::FloodBook => Some(Stack::new(WRITABLE_BOOK, 1)),
    // rust: _ => None,
}
    // rust: for &(slot, item, count) in &o.give {
    // rust: send(
    // rust: play::Serverbound::SetCreativeModeSlot(play::SetCreativeModeSlot {
    // rust: slot,
    // rust: item: Some(Stack::new(item, count)),
    // rust: })
    // rust: .encode(),
    // rust: );
}
    // rust: if tool.is_some() {
    // rust: send(
    // rust: play::Serverbound::SetCreativeModeSlot(play::SetCreativeModeSlot {
    // rust: slot: 36,
    // rust: item: tool,
    // rust: })
    // rust: .encode(),
    // rust: );
    // rust: send(play::Serverbound::SetCarriedItem(play::SetCarriedItem { slot: 0 }).encode());
}
    // rust: let mut sequence = 0;
    // rust: let mut rounds = 0;
    // rust: let mut random = Random(o.seed ^ (index as u64).wrapping_mul(0x2545_F491_4F6C_DD1D));
    // rust: let mut pos = spawn;
    // Fight bots stay at their spawn height; the others climb to fly above the terrain.
    // rust: let cruise = if behaviour == Behaviour::Fight {
    // rust: spawn[1]
    // rust: } else {
    // rust: spawn[1] + o.height
}
    // rust: let mut since_attack = ATTACK_COOLDOWN_TICKS;
    // rust: let heading = random.unit() * std::f64::consts::TAU;
    // rust: let mut target = pos;
    // rust: let mut next = Instant::now();
    // rust: let (joined, mut tick) = (Instant::now(), 0u64);
    // rust: loop {
    // rust: if lock(&until).is_some_and(|u| Instant::now() >= u) || !bot.online.load(Ordering::SeqCst) {
    // rust: break;
}
        // A teleport from the server wins over where the bot thought it was.
    // rust: if let Some(at) = lock(&bot.teleport).take() {
    // rust: pos = at;
}
    // rust: let here = ((pos[0].floor() as i32) >> 4, (pos[2].floor() as i32) >> 4);
        // The abusive client doesn't wait for its chunk, as a real client must.
    // rust: if behaviour == Behaviour::Stand {
            // Where the server put it, on the ground.
    // rust: } else if behaviour == Behaviour::FloodMove {
            // The last of these moves goes out below, with the tick's end.
    // rust: pos[1] = cruise;
    // rust: for _ in 1..o.flood.max(1) {
    // rust: let angle = random.unit() * std::f64::consts::TAU;
    // rust: let reach = 64.0 + random.unit() * 192.0;
    // rust: pos[0] += angle.cos() * reach;
    // rust: pos[2] += angle.sin() * reach;
    // rust: send(
    // rust: play::Serverbound::MovePlayerPos(play::MovePlayerPos {
    // rust: x: pos[0],
    // rust: y: pos[1],
    // rust: z: pos[2],
    // rust: flags: 0,
    // rust: })
    // rust: .encode(),
    // rust: );
}
    // rust: let angle = random.unit() * std::f64::consts::TAU;
    // rust: pos[0] += angle.cos() * 128.0;
    // rust: pos[2] += angle.sin() * 128.0;
    // rust: } else if behaviour == Behaviour::FloodChunks {
            // Up to cruising height first, then just under the server's 10 blocks a tick:
            // every tick asks for new chunks.
    // rust: if pos[1] < cruise {
    // rust: pos[1] = (pos[1] + 0.5).min(cruise);
    // rust: } else {
    // rust: pos[0] += heading.cos() * 9.9;
    // rust: pos[2] += heading.sin() * 9.9;
}
    // rust: } else if !lock(&bot.held).contains(&here) {
    // rust: bot.waited.fetch_add(1, Ordering::Relaxed);
    // rust: } else if pos[1] < cruise {
    // rust: pos[1] = (pos[1] + 0.5).min(cruise);
    // rust: } else {
    // rust: match behaviour {
    // rust: Behaviour::Idle | Behaviour::Stand => {}
    // rust: Behaviour::Walk => walk_step(&mut pos, &mut target, spawn, cruise, &mut random),
    // rust: Behaviour::Fight => {
    // rust: let near = lock(&bot.entities).nearest(pos, o.pvp, &bots);
    // rust: if let Some(near) = near {
    // rust: if let Some(victim) = fight_tick(&mut pos, near, &mut since_attack) {
                            // The client sends the attack, then swings the arm.
    // rust: let sent = send(
    // rust: play::Serverbound::Attack(play::Attack { id: victim }).encode(),
    // rust: ) && send(raw(sb::PUNCH, |w| w.varint(0)));
    // rust: if sent {
    // rust: bot.attacks.fetch_add(1, Ordering::Relaxed);
}
}
    // rust: } else {
    // rust: since_attack = since_attack.saturating_add(1);
    // rust: walk_step(&mut pos, &mut target, spawn, cruise, &mut random);
}
}
    // rust: Behaviour::FloodMove
    // rust: | Behaviour::FloodChunks
    // rust: | Behaviour::FloodUse
    // rust: | Behaviour::FloodClick
    // rust: | Behaviour::FloodSuggest
    // rust: | Behaviour::FloodBook
    // rust: | Behaviour::FloodSign
    // rust: | Behaviour::FloodRecipe => {}
    // rust: Behaviour::FloodPackets => {
    // rust: for i in 0..o.flood {
    // rust: send(
    // rust: play::Serverbound::MovePlayerRot(play::MovePlayerRot {
    // rust: yaw: (i % 360) as f32,
    // rust: pitch: 0.0,
    // rust: flags: 0,
    // rust: })
    // rust: .encode(),
    // rust: );
}
}
    // rust: Behaviour::FloodAcks | Behaviour::Explore => {
    // rust: if behaviour == Behaviour::FloodAcks {
    // rust: for _ in 0..o.flood {
    // rust: send(
    // rust: play::Serverbound::ChunkBatchReceived(play::ChunkBatchReceived {
    // rust: chunks_per_tick: 64.0,
    // rust: })
    // rust: .encode(),
    // rust: );
}
}
                    // Flying in creative, by default about 22 blocks a second, which keeps new
                    // chunks coming as fast as the server sends them.
    // rust: let step = o.explore_speed / 20.0;
    // rust: pos[0] += heading.cos() * step;
    // rust: pos[2] += heading.sin() * step;
}
}
}
    // rust: if let Some((at, slot, button, input)) = o.click {
            // Ticks of 50 ms: the block 3 s after joining, the click a second later.
    // rust: if tick == 60 {
    // rust: sequence += 1;
    // rust: send(
    // rust: play::Serverbound::UseItemOn(play::UseItemOn {
    // rust: hand: 0,
    // rust: pos: at,
    // rust: face: 1,
    // rust: cursor: [0.5, 1.0, 0.5],
    // rust: inside: false,
    // rust: world_border: false,
    // rust: sequence,
    // rust: })
    // rust: .encode(),
    // rust: );
    // rust: } else if tick == 80 {
                // The first window a player opens is 1.
    // rust: send(
    // rust: play::Serverbound::ContainerClick(play::ContainerClick {
    // rust: container: 1,
    // rust: state: 0,
    // rust: slot,
    // rust: button,
    // rust: input,
    // rust: changed: Vec::new(),
    // rust: carried: None,
    // rust: })
    // rust: .encode(),
    // rust: );
}
}
    // rust: for (at, id, body) in &o.raw {
    // rust: if *at == tick {
    // rust: send(raw(*id, |w| w.bytes(body)));
}
}
        // The costly floods go out wherever the bot is, chunks or not (--no-read gets none).
    // rust: for i in 0..o.flood {
    // rust: sequence += 1;
    // rust: if let Some(body) = costly(behaviour, i, sequence, pos, &mut random) {
    // rust: send(body);
}
}
    // rust: if joined.elapsed().as_secs_f64() >= o.attack_after
    // rust: && tick % 10 == 0
    // rust: && rounds < o.attack_rounds
    // rust: {
    // rust: let targets: Vec<i32> = lock(&bot.target).iter().filter_map(|t| t.1).collect();
            // A round counts once a target is known.
    // rust: rounds += u32::from(!targets.is_empty());
    // rust: for id in targets {
    // rust: send(play::Serverbound::Attack(play::Attack { id }).encode());
                // Minecraft.startAttack swings right after the attack.
    // rust: if !o.no_swing {
    // rust: send(play::Serverbound::Punch(Empty).encode());
}
    // rust: bot.attacks.fetch_add(1, Ordering::Relaxed);
}
}
    // rust: tick += 1;
    // rust: let ok = send(
    // rust: play::Serverbound::MovePlayerPos(play::MovePlayerPos {
    // rust: x: pos[0],
    // rust: y: pos[1],
    // rust: z: pos[2],
                // Fight bots stand on the ground; the others fly.
    // rust: flags: u8::from(
    // rust: matches!(behaviour, Behaviour::Fight | Behaviour::Stand) || o.ground,
    // rust: ),
    // rust: })
    // rust: .encode(),
    // rust: ) && send(raw(sb::CLIENT_TICK_END, |_| {}));
    // rust: if !ok {
    // rust: bot.online.store(false, Ordering::SeqCst);
    // rust: break;
}
    // rust: next += Duration::from_secs_f64(0.05 / o.timer);
    // rust: let now = Instant::now();
    // rust: if next > now {
    // rust: thread::sleep(next - now);
    // rust: } else if now - next > Duration::from_secs(1) {
    // rust: next = now;
}
}
    // Offline first, so the reader doesn't count the closed connection as a failure.
    // rust: bot.online.store(false, Ordering::SeqCst);
    // rust: lock(&writer).shutdown();
}

behaviour_of :: proc(mode: string, index: uint) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match mode {
    // rust: "idle" => Behaviour::Idle,
    // rust: "stand" => Behaviour::Stand,
    // rust: "walk" => Behaviour::Walk,
    // rust: "explore" => Behaviour::Explore,
    // rust: "fight" => Behaviour::Fight,
    // rust: "flood-move" => Behaviour::FloodMove,
    // rust: "flood-acks" => Behaviour::FloodAcks,
    // rust: "flood-packets" => Behaviour::FloodPackets,
    // rust: "flood-chunks" => Behaviour::FloodChunks,
    // rust: "flood-use" => Behaviour::FloodUse,
    // rust: "flood-click" => Behaviour::FloodClick,
    // rust: "flood-suggest" => Behaviour::FloodSuggest,
    // rust: "flood-book" => Behaviour::FloodBook,
    // rust: "flood-sign" => Behaviour::FloodSign,
    // rust: "flood-recipe" => Behaviour::FloodRecipe,
        // mixed: of every five bots, three walk, one explores, one stands.
    // rust: _ => match index % 5 {
    // rust: 0 | 2 | 4 => Behaviour::Walk,
    // rust: 1 => Behaviour::Explore,
    // rust: _ => Behaviour::Idle,
    // rust: },
}
}

main :: proc() {
}
    // rust: let o = match options() {
    // rust: Ok(o) => Arc::new(o),
    // rust: Err(e) => {
    // rust: eprintln!("horizon-bots: {e}");
    // rust: std::process::exit(2);
}
}
    // rust: let start = Instant::now();
    // rust: let until: Arc<Mutex<Option<Instant>>> = Arc::new(Mutex::new(None));
    // rust: let bots: Vec<Arc<Bot>> = (0..o.bots).map(|_| Arc::new(Bot::default())).collect();
    // The uuids of all bots, so that `--pvp false` leaves them alone.
    // rust: let bot_uuids: Arc<HashSet<u128>> = Arc::new(
    // rust: (0..o.bots)
    // rust: .map(|i| offline_uuid(&format!("{}{i}", o.name)))
    // rust: .collect(),
    // rust: );
    // rust: let launcher = {
    // rust: let (o, bots, until) = (o.clone(), bots.clone(), until.clone());
    // rust: let bot_uuids = bot_uuids.clone();
    // rust: thread::spawn(move || {
    // rust: let mut handles = Vec::new();
    // rust: for (i, bot) in bots.iter().enumerate() {
    // rust: let (o2, bot, until) = (o.clone(), bot.clone(), until.clone());
    // rust: let (behaviour, uuids) = (behaviour_of(&o.behaviour, i), bot_uuids.clone());
    // rust: handles.push(thread::spawn(move || {
    // rust: run_bot(o2, i, behaviour, uuids, bot, until);
    // rust: }));
    // rust: thread::sleep(Duration::from_secs_f64(o.join_every));
}
    // rust: handles
    // rust: })
}
    // The run lasts --seconds after the first bot is in.
    // rust: let mut previous_chunks = 0;
    // rust: let mut first = None;
    // rust: loop {
    // rust: thread::sleep(Duration::from_secs(1));
    // rust: let online = bots
    // rust: .iter()
    // rust: .filter(|b| b.online.load(Ordering::SeqCst))
    // rust: .count();
    // rust: let chunks: u64 = bots.iter().map(|b| b.chunks.load(Ordering::Relaxed)).sum();
    // rust: let total = |f: fn(&Bot) -> &AtomicU64| -> u64 {
    // rust: bots.iter().map(|b| f(b).load(Ordering::Relaxed)).sum()
}
    // rust: let failed = bots.iter().filter(|b| lock(&b.error).is_some()).count();
    // rust: if first.is_none() && online > 0 {
    // rust: first = Some(Instant::now());
    // rust: *lock(&until) = Some(Instant::now() + Duration::from_secs(o.seconds));
}
    // rust: println!(
    // rust: "{}",
    // rust: json!({
    // rust: "t": start.elapsed().as_secs(),
    // rust: "online": online,
    // rust: "failed": failed,
    // rust: "chunks": chunks,
    // rust: "chunks_per_second": chunks - previous_chunks,
    // rust: "unique": total(|b| &b.unique),
    // rust: "forgotten": total(|b| &b.forgotten),
    // rust: "resent": total(|b| &b.resent),
    // rust: "pulled_back": total(|b| &b.pulled_back),
    // rust: "waited_ticks": total(|b| &b.waited),
    // rust: "attacks": total(|b| &b.attacks),
    // rust: })
    // rust: );
    // rust: previous_chunks = chunks;
    // rust: let over = lock(&until).is_some_and(|u| Instant::now() >= u);
    // rust: let all_failed = failed == o.bots;
    // rust: if over || all_failed || (first.is_none() && start.elapsed() > Duration::from_secs(120)) {
    // rust: *lock(&until) = Some(Instant::now());
    // rust: break;
}
}
    // rust: for handle in launcher.join().unwrap_or_default() {
    // rust: let _ = handle.join();
}
    // rust: let summary = json!({
    // rust: "server": format!("{}:{}", o.host, o.port),
    // rust: "bots": o.bots,
    // rust: "behaviour": o.behaviour,
    // rust: "seed": o.seed,
    // rust: "explore_speed": o.explore_speed,
    // rust: "pvp": o.pvp,
    // rust: "view_distance": o.view_distance,
    // rust: "seconds": o.seconds,
    // rust: "joined": bots.iter().filter(|b| b.joined_after_ms.load(Ordering::SeqCst) > 0).count(),
    // rust: "chunks": bots.iter().map(|b| b.chunks.load(Ordering::Relaxed)).sum::<u64>(),
    // rust: "resent": bots.iter().map(|b| b.resent.load(Ordering::Relaxed)).sum::<u64>(),
    // rust: "pulled_back": bots.iter().map(|b| b.pulled_back.load(Ordering::Relaxed)).sum::<u64>(),
    // rust: "waited_ticks": bots.iter().map(|b| b.waited.load(Ordering::Relaxed)).sum::<u64>(),
    // rust: "attacks": bots.iter().map(|b| b.attacks.load(Ordering::Relaxed)).sum::<u64>(),
    // rust: "bytes_in": bots.iter().map(|b| b.bytes_in()).sum::<u64>(),
    // rust: "bytes_out": bots.iter().map(|b| b.bytes_out()).sum::<u64>(),
    // rust: "join_time": join_summary(
    // rust: bots.iter()
    // rust: .map(|b| b.joined_after_ms.load(Ordering::SeqCst))
    // rust: .filter(|&ms| ms > 0)
    // rust: .collect(),
    // rust: ),
    // rust: "per_bot": bots.iter().enumerate().map(|(i, b)| json!({
    // rust: "name": format!("{}{i}", o.name),
    // rust: "behaviour": behaviour_of(&o.behaviour, i).name(),
    // rust: "joined_after_ms": b.joined_after_ms.load(Ordering::SeqCst),
    // rust: "bytes_in": b.bytes_in(),
    // rust: "bytes_out": b.bytes_out(),
    // rust: "chunks": b.chunks.load(Ordering::Relaxed),
    // rust: "unique_chunks": b.unique.load(Ordering::Relaxed),
    // rust: "resent": b.resent.load(Ordering::Relaxed),
    // rust: "forgotten": b.forgotten.load(Ordering::Relaxed),
    // rust: "pulled_back": b.pulled_back.load(Ordering::Relaxed),
    // rust: "waited_ticks": b.waited.load(Ordering::Relaxed),
    // rust: "error": *lock(&b.error),
    // rust: "attacks": b.attacks.load(Ordering::Relaxed),
    // rust: "health": *lock(&b.health),
    // rust: })).collect::<Vec<_>>(),
    // rust: });
    // rust: if o.report.as_deref() == Some("-") {
    // rust: println!("{summary:#}");
    // rust: } else if let Some(path) = &o.report {
    // rust: if let Err(e) = std::fs::write(path, format!("{summary:#}\n")) {
    // rust: eprintln!("horizon-bots: {path}: {e}");
}
}
    // rust: let errors: Vec<String> = bots
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter_map(|(i, b)| {
    // rust: b.error
    // rust: .lock()
    // rust: .unwrap()
    // rust: .clone()
    // rust: .map(|e| format!("{}{i}: {e}", o.name))
    // rust: })
    // rust: .collect();
    // rust: for e in errors.iter().take(10) {
    // rust: eprintln!("horizon-bots: {e}");
}
    // rust: std::process::exit(if errors.is_empty() { 0 } else { 1 });
}

    // rust: mod tests {
//     use super::*;
//     use play::{
    // rust: AddEntity, Clientbound, MoveEntity, MoveEntityPos, RemoveEntities, SetEntityData, VecDelta,
}

feed :: proc(entities: ^Entities, packet: ^Clientbound) {
}
    // rust: let bytes = packet.encode();
    // rust: let mut r = Reader::new(&bytes);
    // rust: let id = r.varint().unwrap();
    // rust: entities.update(id, &bytes[bytes.len() - r.remaining()..]);
}

add :: proc(id: i32, uuid: u128, pos: [f64; 3]) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Clientbound::AddEntity(AddEntity {
    // rust: id,
    // rust: uuid,
    // rust: kind: 1,
    // rust: position: pos,
    // rust: velocity: [0.0; 3],
    // rust: pitch: 0,
    // rust: yaw: 0,
    // rust: head_yaw: 0,
    // rust: data: 0,
    // rust: })
}

health :: proc(id: i32, health: f32) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Clientbound::SetEntityData(SetEntityData {
    // rust: id,
    // rust: values: vec![(HEALTH_DATA, 3, entity_data::Value::Float(health))],
    // rust: })
}

    // `--attack`: a UUID names that entity, anything else a player.
attack_targets_a_uuid_or_a_player :: proc() {
}
    // rust: assert_eq!(target_uuid("00000000-0000-0000-0000-00000000000a"), 10);
    // rust: assert_eq!(
    // rust: target_uuid("0000000a-0000-0001-0000-000000000002"),
    // rust: 0x0000000a_0000_0001_0000_000000000002
    // rust: );
    // rust: assert_eq!(target_uuid("V0"), offline_uuid("V0"));
        // A name of 32 hex digits is a name: a UUID is written with dashes.
    // rust: let name = "0123456789abcdef0123456789abcdef";
    // rust: assert_eq!(target_uuid(name), offline_uuid(name));
}

tracks_living_entities_only :: proc() {
}
    // rust: let mut e = Entities::default();
    // rust: feed(&mut e, &add(1, 10, [3.0, 64.0, 0.0]));
    // rust: feed(&mut e, &add(2, 11, [5.0, 64.0, 0.0]));
    // rust: feed(&mut e, &health(2, 20.0));
        // Entity 1 never sent a health (an item, an arrow), so it is no target.
    // rust: assert_eq!(
    // rust: e.nearest([0.0, 64.0, 0.0], true, &HashSet::new()),
    // rust: Some((2, [5.0, 64.0, 0.0]))
    // rust: );
    // rust: feed(&mut e, &health(2, 0.0));
    // rust: assert_eq!(e.nearest([0.0, 64.0, 0.0], true, &HashSet::new()), None);
    // rust: feed(&mut e, &health(2, 4.0));
    // rust: feed(
    // rust: &mut e,
    // rust: &Clientbound::RemoveEntities(RemoveEntities { ids: vec![2] }),
    // rust: );
    // rust: assert_eq!(e.nearest([0.0, 64.0, 0.0], true, &HashSet::new()), None);
}

moves_follow_the_deltas :: proc() {
}
    // rust: let mut e = Entities::default();
    // rust: feed(&mut e, &add(7, 1, [0.0, 64.0, 0.0]));
    // rust: feed(&mut e, &health(7, 20.0));
    // rust: feed(
    // rust: &mut e,
    // rust: &Clientbound::MoveEntityPos(MoveEntityPos(MoveEntity {
    // rust: id: 7,
    // rust: delta: Some(VecDelta::Linear([4096, 0, -8192])),
    // rust: rotation: None,
    // rust: on_ground: true,
    // rust: })),
    // rust: );
    // rust: assert_eq!(e.0[&7].pos, [1.0, 64.0, -2.0]);
}

pvp_false_spares_the_bots_and_ties_go_to_the_lowest_id :: proc() {
}
    // rust: let mut e = Entities::default();
    // rust: feed(&mut e, &add(9, 100, [2.0, 64.0, 0.0]));
    // rust: feed(&mut e, &add(4, 101, [-2.0, 64.0, 0.0]));
    // rust: feed(&mut e, &add(5, 102, [0.0, 64.0, 6.0]));
    // rust: for id in [9, 4, 5] {
    // rust: feed(&mut e, &health(id, 20.0));
}
    // rust: let bots = HashSet::from([100, 101]);
    // rust: let from = [0.0, 64.0, 0.0];
    // rust: assert_eq!(e.nearest(from, true, &bots).map(|t| t.0), Some(4));
    // rust: assert_eq!(e.nearest(from, false, &bots).map(|t| t.0), Some(5));
}

attacks_at_the_vanilla_cooldown :: proc() {
}
    // rust: let mut pos = [0.0, 64.0, 0.0];
    // rust: let target = (3, [1.0, 64.0, 0.0]);
    // rust: let mut since = ATTACK_COOLDOWN_TICKS;
    // rust: let hits: Vec<u32> = (0..40)
    // rust: .filter_map(|tick| fight_tick(&mut pos, target, &mut since).map(|_| tick))
    // rust: .collect();
    // rust: assert_eq!(hits[0], 0, "a bot in reach strikes at once");
    // rust: assert!(
    // rust: hits.windows(2)
    // rust: .all(|w| w[1] - w[0] == ATTACK_COOLDOWN_TICKS)
    // rust: );
    // rust: assert_eq!(hits.len(), 8);
}

walks_into_reach_before_striking :: proc() {
}
    // rust: let mut pos = [0.0, 64.0, 0.0];
    // rust: let target = (3, [10.0, 64.0, 0.0]);
    // rust: let mut since = ATTACK_COOLDOWN_TICKS;
    // rust: let mut first = None;
    // rust: for tick in 0..100 {
    // rust: if fight_tick(&mut pos, target, &mut since).is_some() {
    // rust: first = Some(tick);
    // rust: break;
}
}
    // rust: assert!(first.is_some_and(|t| t > 30));
    // rust: assert!((target.1[0] - pos[0]).abs() <= ATTACK_REACH);
    // rust: assert!(pos[0] < 10.0 - CLOSE_IN + 1e-9);
}

percentiles_use_nearest_rank :: proc() {
}
    // rust: assert_eq!(percentile(&[], 50), 0);
    // rust: assert_eq!(percentile(&[7], 99), 7);
    // rust: let v: Vec<u64> = (1..=100).collect();
    // rust: assert_eq!(percentile(&v, 50), 50);
    // rust: assert_eq!(percentile(&v, 99), 99);
    // rust: assert_eq!(percentile(&[10, 20, 30, 40], 50), 20);
}

join_summary_sorts_and_reports_max :: proc() {
}
    // rust: let s = join_summary(vec![300, 100, 200]);
    // rust: assert_eq!(s["count"], 3);
    // rust: assert_eq!(s["p50_ms"], 200);
    // rust: assert_eq!(s["p99_ms"], 300);
    // rust: assert_eq!(s["max_ms"], 300);
    // rust: assert_eq!(join_summary(vec![])["count"], 0);
}

bot_bytes_come_from_the_connection_counters :: proc() {
}
    // rust: let bot = Bot::default();
    // rust: assert_eq!((bot.bytes_in(), bot.bytes_out()), (0, 0));
    // rust: let counters = Arc::new(Counters::default());
    // rust: counters.bytes_in.store(1234, Ordering::Relaxed);
    // rust: counters.bytes_out.store(56, Ordering::Relaxed);
    // rust: let _ = bot.counters.set(counters);
    // rust: assert_eq!((bot.bytes_in(), bot.bytes_out()), (1234, 56));
}
}
