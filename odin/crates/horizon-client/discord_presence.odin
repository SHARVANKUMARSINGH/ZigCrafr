//! Transpiled from Horizon Rust crate
package horizon_client_discord_presence

import "core:fmt"
import "core:mem"
import "core:math"

// Discord Rich Presence: "Playing Horizon" on the player's Discord profile, with what they are
// doing (docs/native-client.md). A thread of its own talks to the Discord app on this computer
// through its local IPC socket (Discord's RPC docs: `discord-ipc-N`, frames of opcode u32 LE +
// length u32 LE + JSON). The game only calls [`set`] each frame: a change wakes the thread,
// which connects when Discord runs, retries every 15 s when it doesn't, keeps under Discord's
// update limit and clears the activity on quit. Nothing is sent with the setting off,
// or with `HORIZON_NO_DISCORD=1`.
// use std::collections::VecDeque;
// use std::io::{self, Read, Write};
// use std::path::PathBuf;
// use std::sync::{Condvar, Mutex, OnceLock};
// use std::thread::Thread;
// use std::time::{Duration, Instant, SystemTime, UNIX_EPOCH};

// use serde_json::{Value, json};

// use crate::command::args::GameMode;

// The "Horizon" application on Discord's developer portal (public: it names the game). Its
// Rich Presence assets: `horizon`, the logo.
DISCORD_APP_ID :: "1563857609738690560"
// Whether the application has the game-mode images (`survival`, `creative`, `adventure`,
// `spectator`) beside the logo; it doesn't yet.
MODE_IMAGES :: false
// Points the game at a test's fake Discord (a folder holding `discord-ipc-0`).
IPC_DIR_ENV :: "HORIZON_DISCORD_IPC_DIR"

// Discord drops activity updates beyond 5 in 20 seconds.
BURST :: 5
WINDOW :: Duration::from_secs(20)
// Between two tries to reach Discord while it isn't running.
RETRY :: Duration::from_secs(15)
// The activity is sent again this often, so a Discord restarted meanwhile gets it back.
REFRESH :: Duration::from_secs(60)

HANDSHAKE :: 0
FRAME :: 1
CLOSE :: 2
PING :: 3
PONG :: 4

Dimension :: enum {
    Overworld,
    Nether,
    End,
}

Play :: enum {
    Singleplayer,
    // A server or someone else's LAN world. Its address and name are never shown.
    Multiplayer,
    // This world is open to LAN or friends; `players` counts the host.
    Hosting {,
    players: usize,
    // rust: },
}

Status :: enum {
    // The player turned Rich Presence off: the activity is cleared.
    Off,
    Menus,
    World {,
    play: Play,
    dimension: Dimension,
    mode: GameMode,
    // rust: },
}

// What the game wants shown, and since when it has been in a world.
Wanted :: struct {
    status: Status,
    // Unix seconds: when the player entered the world (dimension changes keep it).
    since: Maybe(u64),
}
    // rust: impl Wanted {
    // A new status at `now`; false if it is the one already wanted.
update :: proc(self: ^Self, status: Status, now: u64) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if self.status == status {
    // rust: return false;
}
    // rust: let in_world = |s: Status| matches!(s, Status::World { .. });
    // rust: if !in_world(status) {
    // rust: self.since = None;
    // rust: } else if !in_world(self.status) {
    // rust: self.since = Some(now);
}
    // rust: self.status = status;
    // rust: true
}
}

Shared :: struct {
    wanted: Wanted,
    stop: bool,
    stopped: bool,
}
    // rust: static SHARED: Mutex<Shared> = Mutex::new(Shared {
    // rust: wanted: Wanted {
    // rust: status: Status::Menus,
    // rust: since: None,
    // rust: },
    // rust: stop: false,
    // rust: stopped: false,
    // rust: });
STOPPED :: Condvar::new()
THREAD :: OnceLock::new()

// Starts the presence thread, once: when the game starts, never for a dedicated server.
// `automated` runs (offscreen, benchmarks) only talk to a test's fake Discord.
start :: proc(enabled: bool, automated: bool) {
}
    // rust: let fake_discord = std::env::var_os(IPC_DIR_ENV).is_some();
    // rust: if THREAD.get().is_some()
    // rust: || std::env::var_os("HORIZON_NO_DISCORD").is_some_and(|v| v != "0")
    // rust: || (automated && !fake_discord)
    // rust: {
    // rust: return;
}
    // rust: if !enabled {
    // rust: lock().wanted.status = Status::Off;
}
    // rust: match std::thread::Builder::new()
    // rust: .name("Discord presence".into())
    // rust: .spawn(run)
    // rust: {
    // rust: Ok(handle) => {
    // rust: let _ = THREAD.set(handle.thread().clone());
}
    // rust: Err(e) => log::warn!("Horizon: no Discord presence: {e}"),
}
}

// What the player does now; only a change wakes the thread. Free without [`start`].
set :: proc(status: Status) {
}
    // rust: let Some(thread) = THREAD.get() else {
    // rust: return;
}
    // rust: if lock().wanted.update(status, unix_now()) {
    // rust: thread.unpark();
}
}

// On quit: clears the activity, waiting at most a moment for Discord.
stop :: proc() {
}
    // rust: let Some(thread) = THREAD.get() else {
    // rust: return;
}
    // rust: let mut shared = lock();
    // rust: shared.stop = true;
    // rust: thread.unpark();
    // rust: let _ = STOPPED.wait_timeout_while(shared, Duration::from_millis(300), |s| !s.stopped);
}

lock :: proc() -> s {
    // Ported from Horizon
    return {}
}
    // rust: SHARED.lock().unwrap_or_else(|e| e.into_inner())
}

unix_now :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: SystemTime::now()
    // rust: .duration_since(UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs())
}

run :: proc() {
}
    // rust: let mut client: Option<Client> = None;
    // rust: let mut sent: Option<(Wanted, Instant)> = None;
    // rust: let mut last_try: Option<Instant> = None;
    // rust: let mut limit = RateLimit::default();
    // rust: loop {
    // rust: let (wanted, stop) = {
    // rust: let s = lock();
    // rust: (s.wanted, s.stop)
}
    // rust: if stop || wanted.status == Status::Off {
    // rust: if let Some(mut c) = client.take() {
    // rust: let _ = c.set_activity(None);
    // rust: c.close();
}
    // rust: sent = None;
    // rust: if stop {
    // rust: lock().stopped = true;
    // rust: STOPPED.notify_all();
    // rust: return;
}
    // rust: std::thread::park();
    // rust: continue;
}
    // rust: let now = Instant::now();
    // rust: if client.is_none() {
    // rust: if let Some(wait) = last_try.and_then(|t| RETRY.checked_sub(now - t)) {
    // rust: std::thread::park_timeout(wait);
    // rust: continue;
}
    // rust: last_try = Some(now);
    // rust: client = Client::connect();
    // rust: if client.is_none() {
    // rust: continue;
}
}
    // rust: let due = sent.is_none_or(|(w, at)| w != wanted || now - at >= REFRESH);
    // rust: if !due {
    // rust: let (_, at) = sent.expect("sent");
    // rust: std::thread::park_timeout(REFRESH - (now - at));
    // rust: continue;
}
    // rust: let wait = limit.wait(now);
    // rust: if !wait.is_zero() {
    // rust: std::thread::park_timeout(wait);
    // rust: continue;
}
    // rust: limit.record(now);
    // rust: let c = client.as_mut().expect("connected");
    // rust: match c.set_activity(activity(wanted.status, wanted.since)) {
    // rust: Ok(()) => sent = Some((wanted, now)),
    // rust: Err(e) => {
    // rust: log::info!("Horizon: Discord presence disconnected ({e})");
    // rust: client = None;
    // rust: sent = None;
}
}
}
}

// The activity Discord shows for `status`; `None` clears it.
activity :: proc(status: Status, since: Maybe(u64)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut assets = json!({"large_image": "horizon", "large_text": "Horizon"});
    // rust: let (details, state, party) = match status {
    // rust: Status::Off => return None,
    // rust: Status::Menus => ("In the menus", None, None),
    // rust: Status::World {
    // rust: play,
    // rust: dimension,
    // rust: mode,
    // rust: } => {
    // rust: if MODE_IMAGES {
    // rust: let (key, text) = match mode {
    // rust: GameMode::Survival => ("survival", "Survival"),
    // rust: GameMode::Creative => ("creative", "Creative"),
    // rust: GameMode::Adventure => ("adventure", "Adventure"),
    // rust: GameMode::Spectator => ("spectator", "Spectator"),
}
    // rust: assets["small_image"] = key.into();
    // rust: assets["small_text"] = text.into();
}
    // rust: let place = match dimension {
    // rust: Dimension::Overworld => "In the Overworld",
    // rust: Dimension::Nether => "In the Nether",
    // rust: Dimension::End => "In the End",
}
    // rust: let (details, party) = match play {
    // rust: Play::Singleplayer => ("Singleplayer", None),
    // rust: Play::Multiplayer => ("Multiplayer", None),
    // rust: Play::Hosting { players } => ("Hosting a world", Some(players)),
}
    // rust: (details, Some(place), party)
}
}
    // rust: let mut a = json!({"details": details, "assets": assets});
    // rust: if let Some(state) = state {
    // rust: a["state"] = state.into();
}
    // rust: if let Some(start) = since {
    // rust: a["timestamps"] = json!({"start": start});
}
    // rust: if let Some(players) = party {
    // rust: let max = crate::lan::MAX_PLAYERS;
    // rust: a["party"] = json!({
    // rust: "id": format!("horizon-{}", std::process::id()),
    // rust: "size": [players.clamp(1, max), max],
    // rust: });
}
    // rust: Some(a)
}

// At most [`BURST`] updates in any [`WINDOW`].
RateLimit :: struct {
    sent: VecDeque<Instant>,
}
    // rust: impl RateLimit {
    // How long until the next update may go.
wait :: proc(self: ^Self, now: Instant) -> D {
    // Ported from Horizon
    return {}
}
    // rust: if self.sent.len() < BURST {
    // rust: return Duration::ZERO;
}
    // rust: (self.sent[0] + WINDOW).saturating_duration_since(now)
}
record :: proc(self: ^Self, now: Instant) {
}
    // rust: if self.sent.len() == BURST {
    // rust: self.sent.pop_front();
}
    // rust: self.sent.push_back(now);
}
}

encode :: proc(op: u32, payload: ^Value) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let body = payload.to_string();
    // rust: let mut frame = Vec::with_capacity(8 + body.len());
    // rust: frame.extend_from_slice(&op.to_le_bytes());
    // rust: frame.extend_from_slice(&(body.len() as u32).to_le_bytes());
    // rust: frame.extend_from_slice(body.as_bytes());
    // rust: frame
}

read_frame :: proc(r: ^impl Read) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut header = [0; 8];
    // rust: r.read_exact(&mut header)?;
    // rust: let op = u32::from_le_bytes(header[..4].try_into().expect("4 bytes"));
    // rust: let len = u32::from_le_bytes(header[4..].try_into().expect("4 bytes")) as usize;
    // rust: if len > 1 << 20 {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "frame too large",
    // rust: ));
}
    // rust: let mut body = vec![0; len];
    // rust: r.read_exact(&mut body)?;
    // rust: Ok((op, serde_json::from_slice(&body)?))
}

    // rust: trait Pipe: Read + Write + Send {}
    // rust: impl<T: Read + Write + Send> Pipe for T {}

Client :: struct {
    pipe: ^dyn Pipe,
    nonce: u64,
}
    // rust: impl Client {
    // The first Discord socket that answers the handshake with READY.
connect :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: sockets().into_iter().find_map(|path| {
    // rust: let mut client = Client {
    // rust: pipe: open(&path).ok()?,
    // rust: nonce: 0,
}
    // rust: match client.handshake() {
    // rust: Ok(()) => {
    // rust: log::info!("Horizon: connected to Discord for Rich Presence");
    // rust: Some(client)
}
    // rust: Err(e) => {
    // rust: log::debug!("Horizon: Discord at {} refused: {e}", path.display());
    // rust: None
}
}
    // rust: })
}
handshake :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let hello = json!({"v": 1, "client_id": DISCORD_APP_ID});
    // rust: self.pipe.write_all(&encode(HANDSHAKE, &hello))?;
    // rust: self.reply(|frame| frame["evt"] == "READY")
}
set_activity :: proc(self: ^Self, activity: Maybe(Value)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.nonce += 1;
    // rust: let nonce = self.nonce.to_string();
    // rust: let command = json!({
    // rust: "cmd": "SET_ACTIVITY",
    // rust: "args": {"pid": std::process::id(), "activity": activity},
    // rust: "nonce": nonce,
    // rust: });
    // rust: self.pipe.write_all(&encode(FRAME, &command))?;
    // rust: self.reply(|frame| frame["nonce"] == nonce.as_str())
}
    // Reads until the frame `ours` picks, answering pings; an ERROR is logged, not fatal.
reply :: proc(self: ^Self, ours: impl Fn(^Value) -> b {
    // Ported from Horizon
    return {}
}
    // rust: loop {
    // rust: match read_frame(&mut self.pipe)? {
    // rust: (FRAME, frame) if ours(&frame) => {
    // rust: if frame["evt"] == "ERROR" {
    // rust: log::info!("Horizon: Discord presence: {}", frame["data"]["message"]);
}
    // rust: return Ok(());
}
    // rust: (PING, frame) => self.pipe.write_all(&encode(PONG, &frame))?,
    // rust: (CLOSE, frame) => {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::ConnectionAborted,
    // rust: frame["message"].as_str().unwrap_or("closed").to_owned(),
    // rust: ));
}
    // rust: _ => {}
}
}
}
close :: proc() {
}
    // rust: let _ = self.pipe.write_all(&encode(CLOSE, &json!({})));
}
}

// Where Discord listens: `discord-ipc-0..9` in the temporary folders (and Flatpak's and
// Snap's subfolders) on Linux and macOS, named pipes on Windows.
sockets :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: sockets_with(|key| std::env::var_os(key), cfg!(windows))
}

sockets_with :: proc(var: impl Fn(string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let names = (0..10).map(|n| format!("discord-ipc-{n}"));
    // rust: if let Some(dir) = var(IPC_DIR_ENV) {
    // rust: return names.map(|n| PathBuf::from(&dir).join(n)).collect();
}
    // rust: if windows {
    // rust: return names.map(|n| PathBuf::from(r"\\?\pipe\").join(n)).collect();
}
    // rust: let mut dirs: Vec<PathBuf> = ["XDG_RUNTIME_DIR", "TMPDIR", "TMP", "TEMP"]
    // rust: .into_iter()
    // rust: .filter_map(&var)
    // rust: .map(PathBuf::from)
    // rust: .collect();
    // rust: dirs.push("/tmp".into());
    // rust: dirs.dedup();
    // rust: let mut paths = Vec::new();
    // rust: for dir in dirs {
    // rust: for sub in ["", "app/com.discordapp.Discord", "snap.discord"] {
    // rust: paths.extend(names.clone().map(|n| dir.join(sub).join(n)));
}
}
    // rust: paths
}

open :: proc(path: ^std::path::Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let stream = std::os::unix::net::UnixStream::connect(path)?;
    // A Discord that stops answering costs this thread a few seconds, never the game.
    // rust: stream.set_read_timeout(Some(Duration::from_secs(5)))?;
    // rust: Ok(Box::new(stream))
}

open :: proc(path: ^std::path::Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let pipe = std::fs::OpenOptions::new()
    // rust: .read(true)
    // rust: .write(true)
    // rust: .open(path)?;
    // rust: Ok(Box::new(pipe))
}

    // rust: mod tests {
//     use super::*;

world :: proc(play: Play, dimension: Dimension) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Status::World {
    // rust: play,
    // rust: dimension,
    // rust: mode: GameMode::Survival,
}
}

    // The folders a real Discord listens in: `$TMPDIR` on macOS, `$XDG_RUNTIME_DIR` on Linux (and its
    // Flatpak and Snap subfolders), named pipes on Windows.
sockets_cover_where_discord_listens :: proc() {
}
    // rust: let env = |pairs: &'static [(&'static str, &'static str)]| {
    // rust: move |key: &str| {
    // rust: pairs
    // rust: .iter()
    // rust: .find(|(k, _)| *k == key)
    // rust: .map(|(_, v)| std::ffi::OsString::from(v))
}
}
    // rust: let macos = sockets_with(env(&[("TMPDIR", "/var/folders/xy/abc/T/")]), false);
    // rust: assert_eq!(
    // rust: macos[0],
    // rust: PathBuf::from("/var/folders/xy/abc/T/discord-ipc-0")
    // rust: );
    // rust: assert!(macos.contains(&PathBuf::from("/var/folders/xy/abc/T/discord-ipc-9")));
    // rust: assert!(macos.contains(&PathBuf::from("/tmp/discord-ipc-0")));

    // rust: let linux = sockets_with(
    // rust: env(&[("XDG_RUNTIME_DIR", "/run/user/1000"), ("TMPDIR", "/tmp")]),
    // rust: false,
    // rust: );
    // rust: assert_eq!(linux[0], PathBuf::from("/run/user/1000/discord-ipc-0"));
    // rust: for path in [
    // rust: "/run/user/1000/app/com.discordapp.Discord/discord-ipc-0",
    // rust: "/run/user/1000/snap.discord/discord-ipc-0",
    // rust: "/tmp/discord-ipc-0",
    // rust: ] {
    // rust: assert!(linux.contains(&PathBuf::from(path)), "{path}");
}
    // rust: assert_eq!(linux.len(), 2 * 3 * 10, "/tmp is listed once");

    // rust: let bare = sockets_with(env(&[]), false);
    // rust: assert_eq!(bare[0], PathBuf::from("/tmp/discord-ipc-0"));

    // rust: let windows = sockets_with(env(&[("TEMP", r"C:\Temp")]), true);
    // rust: assert_eq!(windows.len(), 10);
        // `Path::join` only uses `\` as the separator on Windows itself.
    // rust: assert_eq!(windows[0], PathBuf::from(r"\\?\pipe\discord-ipc-0"));

    // rust: let fake = sockets_with(
    // rust: env(&[("HORIZON_DISCORD_IPC_DIR", "/tmp/hz"), ("TMPDIR", "/x")]),
    // rust: false,
    // rust: );
    // rust: assert_eq!(fake.len(), 10);
    // rust: assert_eq!(fake[0], PathBuf::from("/tmp/hz/discord-ipc-0"));
}

frames_round_trip :: proc() {
}
    // rust: let frame = encode(FRAME, &json!({"cmd": "SET_ACTIVITY"}));
    // rust: assert_eq!(&frame[..4], &[1, 0, 0, 0]);
    // rust: assert_eq!(frame[4..8], (frame.len() as u32 - 8).to_le_bytes());
    // rust: let (op, value) = read_frame(&mut frame.as_slice()).unwrap();
    // rust: assert_eq!((op, value), (FRAME, json!({"cmd": "SET_ACTIVITY"})));
    // rust: assert!(read_frame(&mut &frame[..6]).is_err());
    // rust: let huge = [1, 0, 0, 0, 0, 0, 0, 2];
    // rust: assert!(read_frame(&mut huge.as_slice()).is_err());
}

activities_say_what_the_player_does_and_nothing_private :: proc() {
}
    // rust: assert_eq!(activity(Status::Off, None), None);
    // rust: let menus = activity(Status::Menus, None).unwrap();
    // rust: assert_eq!(menus["details"], "In the menus");
    // rust: assert!(menus.get("state").is_none() && menus.get("timestamps").is_none());
    // rust: assert_eq!(menus["assets"]["large_image"], "horizon");

    // rust: let single = activity(world(Play::Singleplayer, Dimension::Nether), Some(1000)).unwrap();
    // rust: assert_eq!(single["details"], "Singleplayer");
    // rust: assert_eq!(single["state"], "In the Nether");
    // rust: assert_eq!(single["timestamps"]["start"], 1000);
    // rust: assert!(single.get("party").is_none());
    // rust: assert!(single["assets"].get("small_image").is_none());

    // rust: let multi = activity(world(Play::Multiplayer, Dimension::End), Some(5)).unwrap();
    // rust: assert_eq!(multi["details"], "Multiplayer");
    // rust: assert_eq!(multi["state"], "In the End");

    // rust: let host = world(Play::Hosting { players: 3 }, Dimension::Overworld);
    // rust: let host = activity(host, Some(5)).unwrap();
    // rust: assert_eq!(host["details"], "Hosting a world");
    // rust: assert_eq!(host["state"], "In the Overworld");
    // rust: assert_eq!(host["party"]["size"], json!([3, 8]));
}

time_counts_from_entering_the_world :: proc() {
}
    // rust: let mut w = Wanted {
    // rust: status: Status::Menus,
    // rust: since: None,
}
    // rust: assert!(!w.update(Status::Menus, 10));
    // rust: assert!(w.update(world(Play::Singleplayer, Dimension::Overworld), 20));
    // rust: assert_eq!(w.since, Some(20));
        // Another dimension, opening to LAN: the same visit.
    // rust: assert!(w.update(world(Play::Singleplayer, Dimension::Nether), 30));
    // rust: assert!(w.update(world(Play::Hosting { players: 1 }, Dimension::Nether), 40));
    // rust: assert_eq!(w.since, Some(20));
    // rust: assert!(w.update(Status::Menus, 50));
    // rust: assert_eq!(w.since, None);
    // rust: assert!(w.update(world(Play::Multiplayer, Dimension::Overworld), 60));
    // rust: assert_eq!(w.since, Some(60));
    // rust: assert!(w.update(Status::Off, 70));
    // rust: assert_eq!(w.since, None);
}

at_most_five_updates_in_twenty_seconds :: proc() {
}
    // rust: let t = Instant::now();
    // rust: let mut limit = RateLimit::default();
    // rust: for i in 0..5 {
    // rust: let now = t + Duration::from_secs(i);
    // rust: assert_eq!(limit.wait(now), Duration::ZERO);
    // rust: limit.record(now);
}
    // rust: assert_eq!(
    // rust: limit.wait(t + Duration::from_secs(5)),
    // rust: Duration::from_secs(15)
    // rust: );
    // rust: assert_eq!(limit.wait(t + WINDOW), Duration::ZERO);
    // rust: limit.record(t + WINDOW);
    // rust: assert_eq!(limit.wait(t + WINDOW), Duration::from_secs(1));
}

    // A fake Discord: answers the handshake with READY, each command with its nonce, after a ping.
talks_to_discord_over_its_socket :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-discord-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let path = dir.join("discord-ipc-0");
    // rust: let _ = std::fs::remove_file(&path);
    // rust: let listener = std::os::unix::net::UnixListener::bind(&path).unwrap();
    // rust: let server = std::thread::spawn(move || {
    // rust: let (mut s, _) = listener.accept().unwrap();
    // rust: let (op, hello) = read_frame(&mut s).unwrap();
    // rust: assert_eq!((op, &hello["v"]), (HANDSHAKE, &json!(1)));
    // rust: let ready = json!({"cmd": "DISPATCH", "evt": "READY", "data": {"v": 1}});
    // rust: s.write_all(&encode(FRAME, &ready)).unwrap();
    // rust: let mut got = Vec::new();
    // rust: for _ in 0..2 {
    // rust: let (op, cmd) = read_frame(&mut s).unwrap();
    // rust: assert_eq!(op, FRAME);
    // rust: s.write_all(&encode(PING, &json!({"n": 1}))).unwrap();
    // rust: assert_eq!(read_frame(&mut s).unwrap(), (PONG, json!({"n": 1})));
    // rust: let reply = json!({"cmd": "SET_ACTIVITY", "nonce": cmd["nonce"], "data": null});
    // rust: s.write_all(&encode(FRAME, &reply)).unwrap();
    // rust: got.push(cmd);
}
    // rust: got
    // rust: });
    // rust: let mut client = Client {
    // rust: pipe: open(&path).unwrap(),
    // rust: nonce: 0,
}
    // rust: client.handshake().unwrap();
    // rust: let shown = activity(world(Play::Singleplayer, Dimension::End), Some(7));
    // rust: client.set_activity(shown.clone()).unwrap();
    // rust: client.set_activity(None).unwrap();
    // rust: let got = server.join().unwrap();
    // rust: assert_eq!(got[0]["cmd"], "SET_ACTIVITY");
    // rust: assert_eq!(got[0]["args"]["pid"], std::process::id());
    // rust: assert_eq!(got[0]["args"]["activity"], shown.unwrap());
    // rust: assert_eq!(got[1]["args"]["activity"], Value::Null);
    // rust: assert_ne!(got[0]["nonce"], got[1]["nonce"]);
    // rust: let _ = std::fs::remove_dir_all(dir);
}
}
