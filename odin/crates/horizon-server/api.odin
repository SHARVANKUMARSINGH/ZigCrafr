//! Transpiled from Horizon Rust crate
package horizon_server_api

import "core:fmt"
import "core:mem"
import "core:math"

// The control API (docs/server.md, section 8): HTTP and JSON on 127.0.0.1, with a random token in
// `.horizon/api.json` that only the server's own user can read. The CLI manages a running server through
// it, and so does the web panel. The admin endpoints (players, moderation, text metrics) are in admin.rs.
//
// Its routes are [`ROUTES`], listed in docs/api/server-reference.md.

// use crate::{
    // rust: admin::{self, Action},
    // rust: backup,
    // rust: config::Config,
    // rust: engine,
    // rust: http::{self, Request, Response},
    // rust: panel, settings,
    // rust: update::{self, Install},
}
// use serde_json::{Value, json};
// use std::{
    // rust: collections::VecDeque,
    // rust: io::Write,
    // rust: net::{SocketAddr, TcpListener},
    // rust: path::{Path, PathBuf},
    // rust: sync::{
    // rust: Arc, Mutex,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: },
    // rust: time::{Duration, Instant},
}

ENDPOINT :: ".horizon/api.json"
// The log lines kept for `logs` and the panel's console.
LOG_LINES :: 2000
// The samples kept for the panel's graphs: 10 minutes, one a second.
METRICS :: 600

// One endpoint of the control API: what the reference (docs/api/server-reference.md) says about it.
    // rust: not(test),
    // rust: expect(dead_code, reason = "only the reference reads all of it")
    // rust: )]
Route :: struct {
    method: ^'static str,
    path: ^'static str,
    // The JSON body or query it takes, "" for none.
    takes: ^'static str,
    // The JSON it answers with.
    answers: ^'static str,
    what: ^'static str,
}

// Every endpoint `start` and [`route`] answer; a test checks the two agree.
    // rust: pub const ROUTES: [Route; 32] = [
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/status",
    // rust: takes: "",
    // rust: answers: "`phase`, `version`, `pid`, `uptime_seconds`, `engine_pid`, `engine_uptime_seconds`, `crashes`, `last_crash`, `sample` (TPS, MSPT, players, RAM, CPU), `update`",
    // rust: what: "How the server does",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/metrics",
    // rust: takes: "`?since=T` (seconds since 1970)",
    // rust: answers: "`{\"samples\": [...]}`: one a second, the last 10 minutes",
    // rust: what: "The samples taken after T, for graphs",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/logs",
    // rust: takes: "`?since=N`",
    // rust: answers: "`{\"next\": N, \"lines\": [...]}`",
    // rust: what: "The log lines after the Nth (the last 2000 are kept)",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/events",
    // rust: takes: "`?since=N` (or `Last-Event-ID`), `?types=join,leave,kick,chat,chat_filtered,death,log,phase` (all by default)",
    // rust: answers: "with `Accept: text/event-stream`, server-sent events as they happen (`id`, `event`: the type, `data`: JSON); otherwise `{\"next\": N, \"events\": [...]}`",
    // rust: what: "Log lines, the supervisor's phase, and the game's joins, leaves, kicks, chat, messages the chat filter refused (`chat_filtered`, without their text) and deaths (the last 2000 kept)",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/command",
    // rust: takes: "`{\"line\": \"<one command>\"}`",
    // rust: answers: "the lines the command logged",
    // rust: what: "Run a console command on the running game",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/stop",
    // rust: takes: "",
    // rust: answers: "`{\"ok\": true}`",
    // rust: what: "Stop the game and the supervisor",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/start",
    // rust: takes: "",
    // rust: answers: "`{\"ok\": true}`",
    // rust: what: "Start the game while keeping the supervisor and API running",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/restart",
    // rust: takes: "",
    // rust: answers: "`{\"ok\": true}`",
    // rust: what: "Restart the game",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/backups",
    // rust: takes: "",
    // rust: answers: "`{\"backups\": [{\"name\", \"bytes\"}]}`",
    // rust: what: "List the backups",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/backups",
    // rust: takes: "`{\"name\": \"...\"}` (optional)",
    // rust: answers: "`{\"name\": \"<file>\"}`",
    // rust: what: "Back up now (a running game saves first and stays up)",
    // rust: },
    // rust: Route {
    // rust: method: "DELETE",
    // rust: path: "/api/v1/backups",
    // rust: takes: "`?name=<file>` (the full name `backups` lists)",
    // rust: answers: "`{\"name\": \"<file>\"}`",
    // rust: what: "Delete a backup",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/backups/download",
    // rust: takes: "`?name=<file>`",
    // rust: answers: "the zip",
    // rust: what: "Download a backup",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/crash-reports",
    // rust: takes: "",
    // rust: answers: "`{\"reports\": [{\"name\", \"bytes\"}]}`, newest first (the `.txt` files in `crash-reports/`)",
    // rust: what: "List the game's crash reports",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/crash-reports/read",
    // rust: takes: "`?name=<file>` (a name `crash-reports` lists)",
    // rust: answers: "the report's text (`text/plain`)",
    // rust: what: "Read one crash report",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/restore",
    // rust: takes: "`{\"name\": \"<backup>\", \"dimension\": \"minecraft:the_nether\"}` (`dimension` optional)",
    // rust: answers: "`{\"name\": \"<backup>\", \"dimension\": \"<id>\" or null}`",
    // rust: what: "Restart the game with that backup's world, or only one dimension of it (what it replaces is kept in backups/)",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/update",
    // rust: takes: "`{\"tag\": \"...\", \"timeout\": seconds}` (both optional)",
    // rust: answers: "`{\"ok\": true}`; `status` says how it went (`update`)",
    // rust: what: "Restart on that installed release, or download the newest first; goes back if the game isn't up within the timeout",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/metrics/prometheus",
    // rust: takes: "",
    // rust: answers: "the latest sample as Prometheus text: `horizon_up`, `horizon_tps`, `horizon_mspt{stat}`, `horizon_players_online`, `horizon_memory_rss_bytes`, `horizon_loaded_chunks{dimension}` and `horizon_entities{dimension}` (players and block entities apart)...",
    // rust: what: "Metrics for a monitoring tool to scrape",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/players",
    // rust: takes: "",
    // rust: answers: "`online` (name, uuid, address, ping_ms, dimension, position, op_level), `max_players`, `ops`, `whitelist` (`enabled`, `players`), `bans`, `ip_bans` (with reason, source, created, expires)",
    // rust: what: "Who is online, and vanilla's lists",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/mods",
    // rust: takes: "",
    // rust: answers: "`engine` (`found`, `target`, `base`, `horizon`, `hooks`) and `native` (id, version, sha256), from the `native-mods.json` the launcher wrote beside the game program",
    // rust: what: "The native mods the server's game program was built with",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/players/kick",
    // rust: takes: "`{\"name\", \"reason\"}` (reason optional)",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Kick an online player",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/players/ban",
    // rust: takes: "`{\"name\", \"reason\"}` (reason optional)",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Ban a player (kicked if online)",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/players/pardon",
    // rust: takes: "`{\"name\"}`",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Lift a player's ban",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/players/ban-ip",
    // rust: takes: "`{\"ip\", \"reason\"}`, or `{\"name\"}` of an online player",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Ban an address (its players are kicked)",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/players/pardon-ip",
    // rust: takes: "`{\"ip\"}`",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Lift an address's ban",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/players/op",
    // rust: takes: "`{\"name\"}`",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Make a player an operator (op-permission-level)",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/players/deop",
    // rust: takes: "`{\"name\"}`",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Make a player no longer an operator",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/whitelist",
    // rust: takes: "`{\"enabled\": bool}`",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Turn the whitelist on or off",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/whitelist/add",
    // rust: takes: "`{\"name\"}`",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Whitelist a player",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/whitelist/remove",
    // rust: takes: "`{\"name\"}`",
    // rust: answers: "`{\"changed\": bool, \"output\": [...]}`: whether the list (or who is online) changed, and the console's lines",
    // rust: what: "Take a player off the whitelist (kicked if enforce-whitelist)",
    // rust: },
    // rust: Route {
    // rust: method: "GET",
    // rust: path: "/api/v1/config",
    // rust: takes: "",
    // rust: answers: "`{\"config\": {...}}`: server.toml's settings by section (`api.token` hidden)",
    // rust: what: "The settings",
    // rust: },
    // rust: Route {
    // rust: method: "PATCH",
    // rust: path: "/api/v1/config",
    // rust: takes: "`{\"changes\": {\"world.difficulty\": \"hard\", ...}}`",
    // rust: answers: "`saved`, `applied` (taken by the running game at once), `restart` (from the next start), `running`",
    // rust: what: "Change settings as `config set` does; not `engine.*`, `panel.*`, `api.*`, nor RCON, query or management keys",
    // rust: },
    // rust: Route {
    // rust: method: "POST",
    // rust: path: "/api/v1/panel/login",
    // rust: takes: "",
    // rust: answers: "`{\"url\": \"...\"}`",
    // rust: what: "A one-time login link for the web panel (with the token only, not from the panel)",
    // rust: },
    // rust: ];

// What the supervisor is doing.
Phase :: enum {
    Starting,
    Running,
    // The supervisor stays alive after the game stops so local management can edit its files.
    Stopped,
    Stopping,
    // Stopping the game to start it again (`restart`), or waiting to after a crash.
    Restarting,
}

    // rust: impl Phase {
name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Starting => "starting",
    // rust: Self::Running => "running",
    // rust: Self::Stopped => "stopped",
    // rust: Self::Stopping => "stopping",
    // rust: Self::Restarting => "restarting",
}
}
}

State :: struct {
    phase: Phase,
    engine_pid: Maybe(u32),
    engine_started: Maybe(Instant),
    crashes: u32,
    last_crash: Maybe(string),
    // The latest sample (`sample`): the game's status, RAM and CPU.
    sample: Value,
}

// The log, numbered from the first line since the supervisor started.
Log :: struct {
    lines: VecDeque<string>,
    first: u64,
}

    // rust: impl Log {
push :: proc(self: ^Self, line: string) {
}
    // rust: if self.lines.len() == LOG_LINES {
    // rust: self.lines.pop_front();
    // rust: self.first += 1;
}
    // rust: self.lines.push_back(line);
}
    // The lines after the `since`th, and the number to ask from next.
since :: proc(self: ^Self, since: u64) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let skip = since.saturating_sub(self.first) as usize;
    // rust: let next = self.first + self.lines.len() as u64;
    // rust: (next, self.lines.iter().skip(skip).cloned().collect())
}
}

// How long a game started on another release has to come up before the switch is undone.
UPDATE_TIMEOUT :: Duration::from_secs(300)

// Updates and rollbacks (update.rs): what the check found, what is under way, how the last one ended.
Updates :: struct {
    // A release newer than the one in use, from the last check.
    available: Maybe(string),
    // What is happening now, or nothing.
    busy: Maybe(string),
    // How the last update or rollback ended, and whether it went well.
    last: Maybe(string),
    ok: bool,
    // Counts the updates that ended, so a client can wait for the one it asked for.
    finished: u64,
    // The release to restart the game on, and how long it has to come up.
    pending: Option<(string,
}

// What the supervisor and the API threads share.
Shared :: struct {
    dir: PathBuf,
    state: Mutex<State>,
    log: Mutex<Log>,
    stop: AtomicBool,
    restart: AtomicBool,
    // Stop the supervisor after the engine exits; a game-issued stop leaves the API available.
    shutdown: AtomicBool,
    // The backup (and, when only one dimension comes back, its id) to put in place before the game starts
    // again (`restore`).
    restore: Mutex<Option<(string,
    // Held while a backup is written: one at a time.
    backing_up: Mutex<()>,
    started: Instant,
    // The last samples, oldest first, for the panel's graphs.
    metrics: Mutex<VecDeque<Value>>,
    // The panel's address, login links and sessions.
    panel: Mutex<panel::Auth>,
    // The installer's folder this program runs from (none for a build of your own: no updates).
    install: Maybe(Install),
    update: Mutex<Updates>,
    // The event stream's events (events.rs), and the streams' wake-up.
    events: Mutex<crate::events::Events>,
    event_added: std::sync::Condvar,
    // The management protocol's connections, which its notifications go to (management.rs).
    management: crate::management::Clients,
}

    // rust: impl Shared {
new :: proc(dir: ^Path) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Self::with_install(dir, Install::find())
}

with_install :: proc(dir: ^Path, install: Maybe(Install)) -> A {
    // Ported from Horizon
    return {}
}
    // rust: Arc::new(Self {
    // rust: dir: dir.to_owned(),
    // rust: state: Mutex::new(State {
    // rust: phase: Phase::Starting,
    // rust: engine_pid: None,
    // rust: engine_started: None,
    // rust: crashes: 0,
    // rust: last_crash: None,
    // rust: sample: Value::Null,
    // rust: }),
    // rust: log: Mutex::new(Log::default()),
    // rust: stop: AtomicBool::new(false),
    // rust: restart: AtomicBool::new(false),
    // rust: shutdown: AtomicBool::new(false),
    // rust: restore: Mutex::new(None),
    // rust: backing_up: Mutex::new(()),
    // rust: started: Instant::now(),
    // rust: metrics: Mutex::new(VecDeque::new()),
    // rust: panel: Mutex::new(panel::Auth::default()),
    // rust: install,
    // rust: update: Mutex::new(Updates::default()),
    // rust: events: Mutex::default(),
    // rust: event_added: std::sync::Condvar::new(),
    // rust: management: crate::management::Clients::default(),
    // rust: })
}

    // Ends an update or rollback: its outcome, in the log and in `status`.
finish_update :: proc(self: ^Self, ok: bool, message: string) {
}
    // rust: {
    // rust: let mut update = self.update.lock().unwrap();
    // rust: update.busy = None;
    // rust: update.ok = ok;
    // rust: update.finished += 1;
    // rust: if ok {
    // rust: update.available = None;
}
    // rust: update.last = Some(message.clone());
}
    // rust: crate::supervisor::note(self, if ok { "INFO" } else { "ERROR" }, &message);
}

    // Asks for a restart on the installed release `tag` (the supervisor switches when the game stops).
switch_to :: proc(self: ^Self, tag: string, timeout: Duration) {
}
    // rust: self.update.lock().unwrap().busy = Some(format!("Restarting the game on {tag}"));
    // rust: self.update.lock().unwrap().pending = Some((tag, timeout));
    // rust: self.restart.store(true, Ordering::SeqCst);
}

    // `POST /api/v1/update`: switches to `tag`, or downloads the newest release first.
    // rust: fn start_update(
    // rust: self: &Arc<Self>,
    // rust: tag: Option<String>,
    // rust: timeout: Duration,
    // rust: ) -> Result<(), String> {
    // rust: let install = self.install.clone().ok_or(
    // rust: "this horizon-server wasn't installed by install.sh or install.ps1: no updates",
    // rust: )?;
    // rust: {
    // rust: let mut update = self.update.lock().unwrap();
    // rust: if let Some(busy) = &update.busy {
    // rust: return Err(format!("an update is under way: {busy}"));
}
    // rust: update.busy = Some("Looking for the newest release".into());
}
    // rust: if let Some(tag) = tag {
    // rust: if !install.release(&tag).is_dir() || tag.contains(['/', '\\']) {
    // rust: self.update.lock().unwrap().busy = None;
    // rust: return Err(format!(
    // rust: "{tag} isn't installed (`horizon-server update` downloads it)"
    // rust: ));
}
    // rust: self.switch_to(tag, timeout);
    // rust: return Ok(());
}
    // rust: let shared = self.clone();
    // rust: std::thread::Builder::new()
    // rust: .name("update".into())
    // rust: .spawn(move || {
    // rust: let fetched = (|| {
    // rust: let current = install.current().unwrap_or_default();
    // rust: let release = update::release(None)?;
    // rust: if !update::update_available(&release.tag, &current) {
    // rust: return Ok(None);
}
    // rust: shared.update.lock().unwrap().busy =
    // rust: Some(format!("Downloading {} ({})", release.tag, release.asset));
    // rust: let archive = update::download(&install, &release)?;
    // rust: let unpacked = update::unpack(&install, &archive, &release.tag);
    // rust: let _ = std::fs::remove_file(&archive);
    // rust: unpacked.map(|_| Some(release.tag))
    // rust: })();
    // rust: match fetched {
    // rust: Ok(Some(tag)) => shared.switch_to(tag, timeout),
    // rust: Ok(None) => shared.finish_update(true, "Already on the newest release".into()),
    // rust: Err(e) => shared.finish_update(false, format!("Not updated: {e}")),
}
    // rust: })
    // rust: .map_err(|e| e.to_string())?;
    // rust: Ok(())
}
    // Keeps one sample for the graphs.
record :: proc(self: ^Self, sample: Value) {
}
    // rust: let mut metrics = self.metrics.lock().unwrap();
    // rust: if metrics.len() == METRICS {
    // rust: metrics.pop_front();
}
    // rust: metrics.push_back(sample);
}
set_phase :: proc(self: ^Self, phase: Phase) {
}
    // rust: self.state.lock().unwrap().phase = phase;
    // rust: self.emit("phase", json!({ "phase": phase.name() }));
}
    // rust: pub(crate) fn phase(&self) -> Phase {
    // rust: self.state.lock().unwrap().phase
}
    // Stops the game and then the supervisor itself (`POST /api/v1/stop`, the management `server/stop`): the
    // process exits, as vanilla's does. Only a `stop` that reaches the game some other way leaves the supervisor
    // in [`Phase::Stopped`].
shut_down :: proc(self: ^Self) {
}
    // rust: self.shutdown.store(true, Ordering::SeqCst);
    // rust: self.stop.store(true, Ordering::SeqCst);
}

    // A backup while the server runs: the game saves everything and stops writing while the zip is made.
back_up :: proc(self: ^Self, file_name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let _one = self.backing_up.lock().unwrap();
    // rust: let config = Config::load(&self.dir)?;
    // rust: let mut game = match self.phase() {
    // rust: Phase::Running => Some(
    // rust: engine::Control::connect(&self.dir)
    // rust: .map_err(|e| format!("the game didn't answer: {e}"))?,
    // rust: ),
            // Between game runs nothing writes the world.
    // rust: Phase::Stopped | Phase::Restarting => None,
    // rust: Phase::Starting | Phase::Stopping => {
    // rust: return Err("the game is starting or stopping: try again in a moment".into());
}
}
    // rust: if let Some(game) = game.as_mut() {
    // rust: for command in ["console save-off", "console save-all flush"] {
    // rust: game.ask(command)
    // rust: .map_err(|e| format!("the game didn't save: {e}"))?;
}
}
    // rust: let result = backup::create(&self.dir, &config, file_name);
    // rust: if let Some(game) = game.as_mut() {
    // rust: let _ = game.ask("console save-on");
}
    // rust: result
}
}

status :: proc(shared: ^Shared) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let state = shared.state.lock().unwrap();
    // rust: json!({
    // rust: "phase": state.phase.name(),
    // rust: "version": crate::VERSION,
    // rust: "pid": std::process::id(),
    // rust: "uptime_seconds": shared.started.elapsed().as_secs(),
    // rust: "engine_pid": state.engine_pid,
    // rust: "engine_uptime_seconds": state.engine_started.map(|t| t.elapsed().as_secs()),
    // rust: "crashes": state.crashes,
    // rust: "last_crash": state.last_crash,
    // rust: "sample": state.sample,
    // rust: "update": updates(shared),
    // rust: })
}

updates :: proc(shared: ^Shared) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let Some(install) = &shared.install else {
    // rust: return Value::Null;
}
    // rust: let update = shared.update.lock().unwrap();
    // rust: json!({
    // rust: "installed": install.current(),
    // rust: "previous": install.previous(),
    // rust: "available": update.available,
    // rust: "busy": update.busy,
    // rust: "last": update.last,
    // rust: "ok": update.ok,
    // rust: "finished": update.finished,
    // rust: })
}

// A random token: 128 bits from the OS's random generator, as 32 hex digits.
random_token :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut bytes = [0u8; 16];
    // rust: getrandom::fill(&mut bytes).expect("OS random generator");
    // rust: bytes.iter().map(|b| format!("{b:02x}")).collect()
}

same_token :: proc(a: string, b: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: a.len() == b.len() && a.bytes().zip(b.bytes()).fold(0u8, |d, (x, y)| d | (x ^ y)) == 0
}

// Writes a file only its owner can read: through a private temporary file renamed over it
// (`horizon_server_files::private_file`), so an older, wider-readable file never keeps the token.
    // rust: pub use horizon_server_files::private_file::write_private;

// Removes the endpoint file when the supervisor ends.
Endpoint :: struct {
    // rust: impl Drop for Endpoint {
drop :: proc(self: ^Self) {
}
    // rust: let _ = std::fs::remove_file(&self.0);
}
}

// Starts the API where `[api]` says (a free port of 127.0.0.1 by default) and writes where it is and its
// token (`[api] token`, or a random one).
start :: proc(shared: ^Shared) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let settings = Config::load(&shared.dir)?.api;
    // rust: let listener =
    // rust: TcpListener::bind(settings.address()?).map_err(|e| format!("control API: {e}"))?;
    // rust: let address = listener.local_addr().map_err(|e| e.to_string())?;
    // rust: let token = match settings.token.trim() {
    // rust: "" => random_token(),
    // rust: token => token.to_owned(),
}
    // rust: let public = !crate::config::private(address.ip());
    // rust: if public {
    // rust: crate::supervisor::note(
    // rust: &shared,
    // rust: "WARN",
    // rust: &format!(
    // rust: "The control API listens on {address}, beyond this computer and the tailnet (api.allow_public): \
    // rust: only its token guards the server"
    // rust: ),
    // rust: );
}
    // rust: let path = shared.dir.join(ENDPOINT);
    // rust: write_private(
    // rust: &path,
    // rust: json!({ "address": address.to_string(), "token": token, "pid": std::process::id() })
    // rust: .to_string(),
    // rust: )
    // rust: .map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: http::serve(listener, move |request| {
        // A page in a browser can't send the token, and a rebound DNS name can't pass as this address.
    // rust: let authorised = request
    // rust: .header("authorization")
    // rust: .and_then(|h| h.strip_prefix("Bearer "))
    // rust: .is_some_and(|t| same_token(t.trim(), &token));
    // rust: if !authorised {
    // rust: return Response::error(401, "missing or wrong token (see .horizon/api.json)");
}
    // rust: if !public
    // rust: && !request
    // rust: .header("host")
    // rust: .is_some_and(|h| panel::host_allowed(h, address))
    // rust: {
    // rust: return Response::error(403, "wrong Host");
}
    // rust: if (request.method.as_str(), request.path.as_str()) == ("POST", "/api/v1/panel/login") {
    // rust: return match shared.panel.lock().unwrap().login_link() {
    // rust: Some(url) => Response::json(200, &json!({ "url": url })),
    // rust: None => Response::error(
    // rust: 409,
    // rust: "the panel is off: set [panel] bind in server.toml and restart",
    // rust: ),
}
}
    // rust: route(&shared, request)
    // rust: })
    // rust: .map_err(|e| e.to_string())?;
    // rust: Ok(Endpoint(path))
}

// The API's routes, for the CLI (with the token) and the panel (with a session).
route :: proc(shared: ^^Shared, request: ^Request) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match (request.method.as_str(), request.path.as_str()) {
    // rust: ("GET", "/api/v1/status") => Response::json(200, &status(shared)),
    // rust: ("GET", "/api/v1/metrics") => {
    // rust: let since: u64 = request
    // rust: .param("since")
    // rust: .and_then(|s| s.parse().ok())
    // rust: .unwrap_or(0);
    // rust: let samples: Vec<Value> = shared
    // rust: .metrics
    // rust: .lock()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .filter(|m| m["t"].as_u64().is_some_and(|t| t > since))
    // rust: .cloned()
    // rust: .collect();
    // rust: Response::json(200, &json!({ "samples": samples }))
}
    // rust: ("GET", "/api/v1/logs") => {
    // rust: let since = request
    // rust: .param("since")
    // rust: .and_then(|s| s.parse().ok())
    // rust: .unwrap_or(0);
    // rust: let (next, lines) = shared.log.lock().unwrap().since(since);
    // rust: Response::json(200, &json!({ "next": next, "lines": lines }))
}
    // rust: ("GET", "/api/v1/events") => crate::events::route(shared, request),
    // rust: ("POST", "/api/v1/command") => {
    // rust: let line = serde_json::from_slice::<Value>(&request.body)
    // rust: .ok()
    // rust: .and_then(|v| v["line"].as_str().map(str::to_owned));
    // rust: let Some(line) = line.filter(|l| !l.trim().is_empty() && !l.contains('\n')) else {
    // rust: return Response::error(400, "the body must be {\"line\": \"<one command>\"}");
}
    // rust: if shared.state.lock().unwrap().phase != Phase::Running {
    // rust: return Response::error(409, "the game isn't running right now");
}
    // rust: match engine::Control::connect(&shared.dir)
    // rust: .and_then(|mut c| c.ask(&format!("console {}", line.trim_start_matches('/'))))
    // rust: {
    // rust: Ok(reply) => Response::json(200, &reply),
    // rust: Err(e) => Response::error(409, &format!("the game didn't answer: {e}")),
}
}
    // rust: ("POST", "/api/v1/stop") => {
    // rust: shared.shut_down();
    // rust: Response::json(200, &json!({ "ok": true }))
}
    // rust: ("POST", "/api/v1/start") => {
    // rust: if shared.phase() != Phase::Stopped {
    // rust: return Response::error(409, "the game isn't stopped right now");
}
    // rust: shared.restart.store(true, Ordering::SeqCst);
    // rust: Response::json(200, &json!({ "ok": true }))
}
    // rust: ("POST", "/api/v1/restart") => {
    // rust: shared.restart.store(true, Ordering::SeqCst);
    // rust: Response::json(200, &json!({ "ok": true }))
}
    // rust: ("GET", "/api/v1/backups") => {
    // rust: let list: Vec<Value> = backup::list(&shared.dir)
    // rust: .into_iter()
    // rust: .map(|b| json!({ "name": b.name, "bytes": b.bytes }))
    // rust: .collect();
    // rust: Response::json(200, &json!({ "backups": list }))
}
    // rust: ("POST", "/api/v1/backups") => {
    // rust: let body: Value = serde_json::from_slice(&request.body).unwrap_or(Value::Null);
    // rust: let made = backup::file_name(std::time::SystemTime::now(), body["name"].as_str())
    // rust: .and_then(|name| shared.back_up(&name));
    // rust: match made {
    // rust: Ok(path) => Response::json(
    // rust: 200,
    // rust: &json!({ "name": path.file_name().map(|n| n.to_string_lossy()) }),
    // rust: ),
    // rust: Err(e) => Response::error(409, &e),
}
}
    // rust: ("POST", "/api/v1/restore") => {
    // rust: let body: Value = serde_json::from_slice(&request.body).unwrap_or(Value::Null);
    // rust: match backup::find(&shared.dir, body["name"].as_str().unwrap_or_default()) {
    // rust: Ok(name) => {
    // rust: let dimension = match body["dimension"].as_str() {
    // rust: None => None,
    // rust: Some(d) => match backup::dimension_folder(d) {
    // rust: Ok((id, _)) => Some(id),
    // rust: Err(e) => return Response::error(400, &e),
    // rust: },
}
    // rust: *shared.restore.lock().unwrap() = Some((name.clone(), dimension.clone()));
    // rust: shared.restart.store(true, Ordering::SeqCst);
    // rust: Response::json(200, &json!({ "name": name, "dimension": dimension }))
}
    // rust: Err(e) => Response::error(404, &e),
}
}
    // rust: ("POST", "/api/v1/update") => {
    // rust: let body: Value = serde_json::from_slice(&request.body).unwrap_or(Value::Null);
    // rust: let timeout = body["timeout"]
    // rust: .as_u64()
    // rust: .map_or(UPDATE_TIMEOUT, Duration::from_secs);
    // rust: match shared.start_update(body["tag"].as_str().map(str::to_owned), timeout) {
    // rust: Ok(()) => Response::json(200, &json!({ "ok": true })),
    // rust: Err(e) => Response::error(409, &e),
}
}
    // rust: ("GET", "/api/v1/metrics/prometheus") => admin::prometheus(shared),
    // rust: ("GET", "/api/v1/players") => admin::players(shared),
    // rust: ("GET", "/api/v1/mods") => admin::mods(shared),
    // rust: ("POST", "/api/v1/players/kick") => admin::act(shared, Action::Kick, &request.body),
    // rust: ("POST", "/api/v1/players/ban") => admin::act(shared, Action::Ban, &request.body),
    // rust: ("POST", "/api/v1/players/pardon") => admin::act(shared, Action::Pardon, &request.body),
    // rust: ("POST", "/api/v1/players/ban-ip") => admin::act(shared, Action::BanIp, &request.body),
    // rust: ("POST", "/api/v1/players/pardon-ip") => {
    // rust: admin::act(shared, Action::PardonIp, &request.body)
}
    // rust: ("POST", "/api/v1/players/op") => admin::act(shared, Action::Op, &request.body),
    // rust: ("POST", "/api/v1/players/deop") => admin::act(shared, Action::Deop, &request.body),
    // rust: ("POST", "/api/v1/whitelist") => admin::act(shared, Action::Whitelist, &request.body),
    // rust: ("POST", "/api/v1/whitelist/add") => {
    // rust: admin::act(shared, Action::WhitelistAdd, &request.body)
}
    // rust: ("POST", "/api/v1/whitelist/remove") => {
    // rust: admin::act(shared, Action::WhitelistRemove, &request.body)
}
    // rust: ("DELETE", "/api/v1/backups") => {
    // rust: let name = request.param("name").unwrap_or_default();
    // rust: if !backup::list(&shared.dir).iter().any(|b| b.name == name) {
    // rust: return Response::error(404, "no such backup (`GET /api/v1/backups` lists them)");
}
    // rust: match std::fs::remove_file(shared.dir.join(backup::DIR).join(name)) {
    // rust: Ok(()) => {
    // rust: crate::supervisor::note(
    // rust: shared,
    // rust: "INFO",
    // rust: &format!("Control API: deleted the backup {name}"),
    // rust: );
    // rust: Response::json(200, &json!({ "name": name }))
}
    // rust: Err(e) => Response::error(409, &e.to_string()),
}
}
    // rust: ("GET", "/api/v1/backups/download") => {
    // rust: let name = request.param("name").unwrap_or_default();
    // rust: if !backup::list(&shared.dir).iter().any(|b| b.name == name) {
    // rust: return Response::error(404, "no such backup (`GET /api/v1/backups` lists them)");
}
    // rust: Response::file(shared.dir.join(backup::DIR).join(name), name)
}
    // rust: ("GET", "/api/v1/crash-reports") => {
    // rust: let list: Vec<Value> = crash_reports(&shared.dir)
    // rust: .into_iter()
    // rust: .map(|(name, bytes)| json!({ "name": name, "bytes": bytes }))
    // rust: .collect();
    // rust: Response::json(200, &json!({ "reports": list }))
}
    // rust: ("GET", "/api/v1/crash-reports/read") => {
            // Only a name the listing holds is read, so a path (`../`, `/`) matches nothing.
    // rust: let name = request.param("name").unwrap_or_default();
    // rust: if !crash_reports(&shared.dir).iter().any(|(n, _)| n == name) {
    // rust: return Response::error(
    // rust: 404,
    // rust: "no such crash report (`GET /api/v1/crash-reports` lists them)",
    // rust: );
}
    // rust: match std::fs::read(shared.dir.join(CRASH_DIR).join(name)) {
    // rust: Ok(bytes) => Response::text(
    // rust: 200,
    // rust: "text/plain; charset=utf-8",
    // rust: String::from_utf8_lossy(&bytes).into_owned(),
    // rust: ),
    // rust: Err(e) => Response::error(409, &e.to_string()),
}
}
    // rust: ("GET", "/api/v1/config") => match settings::shown(&shared.dir) {
    // rust: Ok(config) => Response::json(200, &json!({ "config": config })),
    // rust: Err(e) => Response::error(409, &e),
    // rust: },
    // rust: ("PATCH", "/api/v1/config") => patch_config(shared, &request.body),
    // rust: (_, path) if ROUTES.iter().any(|r| r.path == path) => Response::error(405, "wrong method"),
    // rust: _ => Response::error(404, "no such endpoint"),
}
}

// Where the game writes its crash reports, under the server folder.
CRASH_DIR :: "crash-reports"

// The crash reports (`*.txt` files directly in `crash-reports/`) with their sizes, newest name first.
crash_reports :: proc(dir: ^std::path::Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out: Vec<(String, u64)> = std::fs::read_dir(dir.join(CRASH_DIR))
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: let meta = e.metadata().ok().filter(|m| m.is_file())?;
    // rust: let name = e.file_name().to_string_lossy().into_owned();
    // rust: name.ends_with(".txt").then_some((name, meta.len()))
    // rust: })
    // rust: .collect();
    // rust: out.sort_by(|a, b| b.0.cmp(&a.0));
    // rust: out
}

// `PATCH /api/v1/config`: `config set` for a program, without the settings that change who can reach the
// server or what program it runs.
patch_config :: proc(shared: ^Shared, body: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let body: Value = serde_json::from_slice(body).unwrap_or(Value::Null);
    // rust: let Some(changes) = body["changes"].as_object().filter(|c| !c.is_empty()) else {
    // rust: return Response::error(
    // rust: 400,
    // rust: "the body must be {\"changes\": {\"section.name\": value, ...}}",
    // rust: );
}
    // rust: let mut lines = Vec::new();
    // rust: for (key, value) in changes {
    // rust: if !settings::changeable_remotely(key) {
    // rust: return Response::error(403, &format!("{key} can only be changed in server.toml"));
}
    // rust: let text = match value {
    // rust: Value::String(s) if !s.contains(['\n', '\r']) => s.clone(),
    // rust: Value::Bool(_) | Value::Number(_) => value.to_string(),
    // rust: _ => {
    // rust: return Response::error(
    // rust: 400,
    // rust: &format!("{key}: a value is one line of text, a number or true/false"),
    // rust: );
}
}
    // rust: lines.push(format!("{key}={text}"));
}
    // rust: let lines: Vec<&str> = lines.iter().map(String::as_str).collect();
    // rust: let live =
    // rust: |line: &str| shared.phase() == Phase::Running && settings::ask_game(&shared.dir, line);
    // rust: let running = matches!(shared.phase(), Phase::Running | Phase::Restarting);
    // rust: match settings::apply(
    // rust: &shared.dir,
    // rust: &lines,
    // rust: running.then_some(&live as &dyn Fn(&str) -> bool),
    // rust: ) {
    // rust: Ok(outcome) => {
    // rust: crate::supervisor::note(
    // rust: shared,
    // rust: "INFO",
    // rust: &format!("Control API: config set {}", lines.join(" ")),
    // rust: );
    // rust: Response::json(200, &outcome.to_json())
}
    // rust: Err(e) => Response::error(400, &e),
}
}

// The API of the server running in a folder, for the CLI.
Client :: struct {
    address: SocketAddr,
    token: string,
}

    // rust: impl Client {
    // The running server's API; `None` when no server runs in `dir`.
open :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if crate::supervisor::lock(dir).is_ok() {
    // rust: return Ok(None);
}
        // The supervisor writes the endpoint just after taking the lock: give it a moment.
    // rust: let path = dir.join(ENDPOINT);
    // rust: let deadline = Instant::now() + Duration::from_secs(5);
    // rust: let text = loop {
    // rust: match std::fs::read_to_string(&path) {
    // rust: Ok(text) => break text,
    // rust: Err(_) if Instant::now() < deadline => {
    // rust: std::thread::sleep(Duration::from_millis(100))
}
    // rust: Err(e) => return Err(format!("{}: {e}", path.display())),
}
}
    // rust: let v: Value =
    // rust: serde_json::from_str(&text).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let address = v["address"]
    // rust: .as_str()
    // rust: .and_then(|a| a.parse().ok())
    // rust: .ok_or_else(|| format!("{}: no address", path.display()))?;
    // rust: let token = v["token"].as_str().unwrap_or_default().to_owned();
    // rust: Ok(Some(Self { address, token }))
}

call :: proc(self: ^Self, method: string, path: string, body: Maybe(^Value)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.call_within(method, path, body, Duration::from_secs(60))
}

    // Reads a server-sent event stream (`GET /api/v1/events`), one event at a time, until the server ends
    // it (`Ok`) or stops answering.
follow :: proc(self: ^Self, path: string, mut each: impl FnMut(^Value) {
}
//         use std::io::BufRead;
    // rust: let mut stream =
    // rust: std::net::TcpStream::connect_timeout(&self.address, Duration::from_secs(5))
    // rust: .map_err(|e| e.to_string())?;
        // The stream sends a comment every 15 s: a minute of silence is a server gone.
    // rust: stream
    // rust: .set_read_timeout(Some(Duration::from_secs(60)))
    // rust: .map_err(|e| e.to_string())?;
    // rust: write!(
    // rust: stream,
    // rust: "GET {path} HTTP/1.1\r\nHost: {}\r\nAuthorization: Bearer {}\r\nAccept: text/event-stream\r\nConnection: close\r\n\r\n",
    // rust: self.address, self.token
    // rust: )
    // rust: .map_err(|e| e.to_string())?;
    // rust: let mut lines = std::io::BufReader::new(stream).lines();
    // rust: let status = lines.next().and_then(Result::ok).unwrap_or_default();
    // rust: if status.split_whitespace().nth(1) != Some("200") {
    // rust: return Err(format!("the server answered {status:?}"));
}
    // rust: for line in lines {
    // rust: let line = line.map_err(|e| e.to_string())?;
    // rust: if let Some(event) = line
    // rust: .strip_prefix("data: ")
    // rust: .and_then(|d| serde_json::from_str(d).ok())
    // rust: {
    // rust: each(&event);
}
}
    // rust: Ok(())
}

    // A call that may take long (a backup of a big world).
    // rust: pub fn call_within(
    // rust: &self,
    // rust: method: &str,
    // rust: path: &str,
    // rust: body: Option<&Value>,
    // rust: timeout: Duration,
    // rust: ) -> Result<Value, String> {
    // rust: let (status, text) = http::request(self.address, &self.token, method, path, body, timeout)
    // rust: .map_err(|e| format!("the server didn't answer: {e}"))?;
    // rust: let value: Value = serde_json::from_str(&text).unwrap_or(Value::Null);
    // rust: if status == 200 {
    // rust: Ok(value)
    // rust: } else {
    // rust: Err(value["error"].as_str().unwrap_or(&text).to_owned())
}
}
}

    // rust: mod tests {
//     use super::*;

    // rust: fn wire_reply(
    // rust: address: SocketAddr,
    // rust: method: &str,
    // rust: path: &str,
    // rust: host: &str,
    // rust: token: Option<&str>,
    // rust: body: &str,
    // rust: ) -> Value {
//         use std::io::{Read, Write};
    // rust: let mut stream = std::net::TcpStream::connect(address).unwrap();
    // rust: let authorization = token
    // rust: .map(|token| format!("Authorization: Bearer {token}\r\n"))
    // rust: .unwrap_or_default();
    // rust: write!(
    // rust: stream,
    // rust: "{method} {path} HTTP/1.1\r\nHost: {host}\r\n{authorization}Content-Type: application/json\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
    // rust: body.len()
    // rust: )
    // rust: .unwrap();
    // rust: stream.flush().unwrap();
    // rust: let mut text = String::new();
    // rust: stream.read_to_string(&mut text).unwrap();
    // rust: let (head, body) = text.split_once("\r\n\r\n").unwrap();
    // rust: let mut lines = head.lines();
    // rust: let status = lines
    // rust: .next()
    // rust: .and_then(|line| line.split_whitespace().nth(1))
    // rust: .and_then(|status| status.parse::<u16>().ok())
    // rust: .unwrap();
    // rust: let headers: Vec<Value> = lines
    // rust: .filter_map(|line| {
    // rust: let (name, value) = line.split_once(": ")?;
    // rust: Some(json!([name, value]))
    // rust: })
    // rust: .collect();
    // rust: json!({
    // rust: "status": status,
    // rust: "headers": headers,
    // rust: "body": serde_json::from_str::<Value>(body).unwrap(),
    // rust: })
}

auth_and_command_replies_match_api_v1_goldens :: proc() {
}
    // rust: let golden: Value =
    // rust: serde_json::from_str(include_str!("../testdata/api-v1-auth-command.json")).unwrap();
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-api-auth-command-goldens-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(dir.join(".horizon")).unwrap();
    // rust: let toml =
    // rust: crate::config::TEMPLATE.replace("token = \"\"", "token = \"test-token-for-api\"");
    // rust: std::fs::write(dir.join(crate::config::FILE), toml).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Stopped);
    // rust: let endpoint = start(shared).unwrap();
    // rust: let endpoint_info: Value =
    // rust: serde_json::from_str(&std::fs::read_to_string(dir.join(ENDPOINT)).unwrap()).unwrap();
    // rust: let address: SocketAddr = endpoint_info["address"].as_str().unwrap().parse().unwrap();
    // rust: let token = endpoint_info["token"].as_str().unwrap();
    // rust: let host = address.to_string();
    // rust: let call =
    // rust: |case: &str, method: &str, path: &str, request_token: Option<&str>, body: &str| {
    // rust: let actual = wire_reply(address, method, path, &host, request_token, body);
    // rust: assert_eq!(actual, golden[case], "{case}");
}
    // rust: let call_host = |case: &str, host: &str| {
    // rust: let actual = wire_reply(address, "GET", "/api/v1/status", host, Some(token), "");
    // rust: assert_eq!(actual, golden[case], "{case}");
}
    // rust: call("missing_token", "GET", "/api/v1/status", None, "");
    // rust: call("wrong_token", "GET", "/api/v1/status", Some("wrong"), "");
    // rust: call_host("wrong_host", "example.invalid");
    // rust: call(
    // rust: "command_malformed",
    // rust: "POST",
    // rust: "/api/v1/command",
    // rust: Some(token),
    // rust: "not json",
    // rust: );
    // rust: call(
    // rust: "command_missing_line",
    // rust: "POST",
    // rust: "/api/v1/command",
    // rust: Some(token),
    // rust: "{}",
    // rust: );
    // rust: call(
    // rust: "command_newline",
    // rust: "POST",
    // rust: "/api/v1/command",
    // rust: Some(token),
    // rust: r#"{"line":"say hi\nthere"}"#,
    // rust: );
    // rust: call(
    // rust: "command_blank",
    // rust: "POST",
    // rust: "/api/v1/command",
    // rust: Some(token),
    // rust: r#"{"line":"   "}"#,
    // rust: );
    // rust: call(
    // rust: "command_stopped",
    // rust: "POST",
    // rust: "/api/v1/command",
    // rust: Some(token),
    // rust: r#"{"line":"list"}"#,
    // rust: );
    // rust: call("unknown_endpoint", "GET", "/api/v1/nope", Some(token), "");
    // rust: call("wrong_method", "GET", "/api/v1/command", Some(token), "");
    // rust: drop(endpoint);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

observability_reply :: proc(mut response: Response, dynamic: ^[string]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: assert!(response.stream.is_none());
    // rust: let mut body = serde_json::from_str::<Value>(&response.body)
    // rust: .unwrap_or_else(|_| Value::String(response.body.clone()));
    // rust: for field in dynamic {
    // rust: if let Some(value) = body.get_mut(*field) {
    // rust: *value = json!("<dynamic>");
}
}
    // rust: if let Some(text) = body.as_str() {
    // rust: let text = text
    // rust: .lines()
    // rust: .map(|line| {
    // rust: if line.starts_with("horizon_supervisor_uptime_seconds ") {
    // rust: "horizon_supervisor_uptime_seconds <dynamic>"
    // rust: } else {
    // rust: line
}
    // rust: })
    // rust: .collect::<Vec<_>>()
    // rust: .join("\n");
    // rust: body = Value::String(if response.body.ends_with('\n') {
    // rust: format!("{text}\n")
    // rust: } else {
    // rust: text
    // rust: });
}
    // rust: json!({
    // rust: "status": response.status,
    // rust: "content_type": response.content_type,
    // rust: "headers": std::mem::take(&mut response.headers),
    // rust: "body": body,
    // rust: })
}

observability_replies_match_api_v1_goldens :: proc() {
}
    // rust: let golden: Value =
    // rust: serde_json::from_str(include_str!("../testdata/api-v1-observability.json")).unwrap();
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-api-observability-goldens-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Stopped);
    // rust: {
    // rust: let mut state = shared.state.lock().unwrap();
    // rust: state.crashes = 2;
    // rust: state.last_crash = Some("exit status: 1".into());
    // rust: state.sample = json!({
    // rust: "t": 200,
    // rust: "rss_bytes": 536_870_912u64,
    // rust: "cpu_percent": 12.5,
    // rust: "game": {
    // rust: "tps": 19.9,
    // rust: "target_tps": 20.0,
    // rust: "mspt": { "average": 8.25, "p50": 7.0, "p95": 12.5, "p99": 18.0 },
    // rust: "players": [{ "name": "Alex" }, { "name": "Steve" }],
    // rust: "max_players": 20,
    // rust: "chunks": 321,
    // rust: },
    // rust: });
}
    // rust: shared.record(json!({ "t": 100, "game": { "tps": 20.0 } }));
    // rust: shared.record(shared.state.lock().unwrap().sample.clone());
    // rust: shared.log.lock().unwrap().push("first line".into());
    // rust: shared.log.lock().unwrap().push("second line".into());

    // rust: let call = |path: &str, query: &str, dynamic: &[&str]| {
    // rust: observability_reply(
    // rust: route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: "GET".into(),
    // rust: path: path.into(),
    // rust: query: query.into(),
    // rust: headers: Vec::new(),
    // rust: body: Vec::new(),
    // rust: },
    // rust: ),
    // rust: dynamic,
    // rust: )
}
    // rust: let cases = [
    // rust: (
    // rust: "status_stopped",
    // rust: "/api/v1/status",
    // rust: "",
    // rust: &["pid", "uptime_seconds"][..],
    // rust: ),
    // rust: ("logs_all", "/api/v1/logs", "", &[][..]),
    // rust: ("logs_since", "/api/v1/logs", "since=1", &[][..]),
    // rust: ("logs_invalid_since", "/api/v1/logs", "since=nope", &[][..]),
    // rust: ("metrics_all", "/api/v1/metrics", "", &[][..]),
    // rust: ("metrics_since", "/api/v1/metrics", "since=100", &[][..]),
    // rust: (
    // rust: "metrics_invalid_since",
    // rust: "/api/v1/metrics",
    // rust: "since=nope",
    // rust: &[][..],
    // rust: ),
    // rust: (
    // rust: "prometheus_stopped",
    // rust: "/api/v1/metrics/prometheus",
    // rust: "",
    // rust: &[][..],
    // rust: ),
    // rust: ];
    // rust: for (case, path, query, dynamic) in cases {
    // rust: assert_eq!(call(path, query, dynamic), golden[case], "{case}");
}
    // rust: shared.set_phase(Phase::Running);
    // rust: assert_eq!(
    // rust: call("/api/v1/metrics/prometheus", "", &[]),
    // rust: golden["prometheus_running"],
    // rust: "prometheus_running"
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

LIFECYCLE_GOLDENS :: include_str!("../testdata/api-v1-lifecycle.json")

golden_phase :: proc(name: string) -> P {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: "starting" => Phase::Starting,
    // rust: "running" => Phase::Running,
    // rust: "stopped" => Phase::Stopped,
    // rust: "stopping" => Phase::Stopping,
    // rust: "restarting" => Phase::Restarting,
    // rust: _ => panic!("unknown golden phase {name:?}"),
}
}

normalize_lifecycle_reply :: proc(path: string, body: ^Value) {
}
    // rust: if path == "/api/v1/status" {
    // rust: assert!(body["version"].is_string());
    // rust: assert!(body["pid"].is_u64());
    // rust: assert!(body["uptime_seconds"].is_u64());
    // rust: assert!(body["engine_uptime_seconds"].is_u64());
    // rust: body["version"] = json!("$VERSION");
    // rust: body["pid"] = json!("$PID");
    // rust: body["uptime_seconds"] = json!("$TIME");
    // rust: body["engine_uptime_seconds"] = json!("$TIME");
}
}

lifecycle_replies_match_api_v1_goldens :: proc() {
}
    // rust: let cases: Value = serde_json::from_str(LIFECYCLE_GOLDENS).unwrap();
    // rust: for case in cases.as_array().unwrap() {
    // rust: let shared = Shared::with_install(Path::new("unused"), None);
    // rust: let sample = json!({ "t": 200, "tps": 20, "players": 2 });
    // rust: {
    // rust: let mut state = shared.state.lock().unwrap();
    // rust: state.phase = golden_phase(case["phase"].as_str().unwrap());
    // rust: state.engine_pid = Some(4242);
    // rust: state.engine_started = Some(Instant::now());
    // rust: state.crashes = 2;
    // rust: state.last_crash = Some("exit status: 1".into());
    // rust: state.sample = sample.clone();
}
    // rust: shared.record(json!({ "t": 100, "tps": 19, "players": 1 }));
    // rust: shared.record(sample);
    // rust: shared.log.lock().unwrap().push("first".into());
    // rust: shared.log.lock().unwrap().push("second".into());

    // rust: let raw_path = case["path"].as_str().unwrap();
    // rust: let (path, query) = raw_path.split_once('?').unwrap_or((raw_path, ""));
    // rust: let response = route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: case["method"].as_str().unwrap().into(),
    // rust: path: path.into(),
    // rust: query: query.into(),
    // rust: headers: Vec::new(),
    // rust: body: Vec::new(),
    // rust: },
    // rust: );
    // rust: let mut body: Value = serde_json::from_str(&response.body).unwrap();
    // rust: normalize_lifecycle_reply(path, &mut body);
    // rust: assert_eq!(response.status, case["status"], "{}", case["name"]);
    // rust: assert_eq!(body, case["body"], "{}", case["name"]);
}
}

log_keeps_the_last_lines_numbered :: proc() {
}
    // rust: let mut log = Log::default();
    // rust: for i in 0..LOG_LINES + 10 {
    // rust: log.push(i.to_string());
}
    // rust: let (next, lines) = log.since(0);
    // rust: assert_eq!(next, (LOG_LINES + 10) as u64);
    // rust: assert_eq!(lines.len(), LOG_LINES);
    // rust: assert_eq!(lines[0], "10");
    // rust: let (next2, tail) = log.since(next - 2);
    // rust: assert_eq!(
    // rust: (next2, tail),
    // rust: (
    // rust: next,
    // rust: vec![(LOG_LINES + 8).to_string(), (LOG_LINES + 9).to_string()]
    // rust: )
    // rust: );
}

tokens_are_32_hex_digits_and_differ :: proc() {
}
    // rust: let (a, b) = (random_token(), random_token());
    // rust: assert_eq!(a.len(), 32);
    // rust: assert!(a.bytes().all(|c| c.is_ascii_hexdigit()));
    // rust: assert_ne!(a, b);
}

the_api_wants_its_token :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-api-{}", std::process::id()));
    // rust: std::fs::create_dir_all(dir.join(".horizon")).unwrap();
    // rust: std::fs::write(dir.join(crate::config::FILE), crate::config::TEMPLATE).unwrap();
    // rust: let shared = Shared::new(&dir);
    // rust: let _endpoint = start(shared.clone()).unwrap();
    // rust: let v: Value =
    // rust: serde_json::from_str(&std::fs::read_to_string(dir.join(ENDPOINT)).unwrap()).unwrap();
    // rust: let address: SocketAddr = v["address"].as_str().unwrap().parse().unwrap();
    // rust: let token = v["token"].as_str().unwrap();
    // rust: let get = |token: &str| {
    // rust: http::request(
    // rust: address,
    // rust: token,
    // rust: "GET",
    // rust: "/api/v1/status",
    // rust: None,
    // rust: Duration::from_secs(5),
    // rust: )
    // rust: .unwrap()
}
    // rust: assert_eq!(get("nope").0, 401);
    // rust: let (status, body) = get(token);
    // rust: assert_eq!(status, 200);
    // rust: let status: Value = serde_json::from_str(&body).unwrap();
    // rust: assert_eq!(status["phase"], "starting");
    // rust: let (code, _) = http::request(
    // rust: address,
    // rust: token,
    // rust: "POST",
    // rust: "/api/v1/stop",
    // rust: None,
    // rust: Duration::from_secs(5),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(code, 200);
    // rust: assert!(shared.stop.load(Ordering::SeqCst));
    // rust: {
//             use std::os::unix::fs::PermissionsExt;
    // rust: let mode = std::fs::metadata(dir.join(ENDPOINT))
    // rust: .unwrap()
    // rust: .permissions()
    // rust: .mode();
    // rust: assert_eq!(mode & 0o777, 0o600);
}
    // rust: drop(_endpoint);
    // rust: assert!(!dir.join(ENDPOINT).exists());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

a_token_and_a_port_from_server_toml :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-api-fixed-{}", std::process::id()));
    // rust: std::fs::create_dir_all(dir.join(".horizon")).unwrap();
    // rust: let port = TcpListener::bind("127.0.0.1:0")
    // rust: .unwrap()
    // rust: .local_addr()
    // rust: .unwrap()
    // rust: .port();
    // rust: let token = "a-token-for-the-discord-bot";
    // rust: let toml = crate::config::TEMPLATE
    // rust: .replace(
    // rust: "[api]\nbind = \"\"",
    // rust: &format!("[api]\nbind = \"127.0.0.1:{port}\""),
    // rust: )
    // rust: .replace("token = \"\"", &format!("token = \"{token}\""));
    // rust: std::fs::write(dir.join(crate::config::FILE), toml).unwrap();
    // rust: let _endpoint = start(Shared::new(&dir)).unwrap();
    // rust: let address: SocketAddr = format!("127.0.0.1:{port}").parse().unwrap();
    // rust: let get = |token: &str| {
    // rust: http::request(
    // rust: address,
    // rust: token,
    // rust: "GET",
    // rust: "/api/v1/status",
    // rust: None,
    // rust: Duration::from_secs(5),
    // rust: )
    // rust: .unwrap()
    // rust: .0
}
    // rust: assert_eq!((get(token), get("a-token-for-the-discord-bo")), (200, 401));
    // rust: drop(_endpoint);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

crash_reports_over_the_api :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-api-crash-{}", std::process::id()));
    // rust: std::fs::create_dir_all(dir.join("crash-reports")).unwrap();
    // rust: std::fs::write(dir.join("secret.txt"), "not a report").unwrap();
    // rust: std::fs::write(
    // rust: dir.join("crash-reports/crash-2026-11-01_10.00.00-server.txt"),
    // rust: "old",
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: dir.join("crash-reports/crash-2026-11-02_10.00.00-server.txt"),
    // rust: "---- Horizon Crash Report ----\nOutOfMemory",
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(dir.join("crash-reports/notes.log"), "skipped").unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: let get = |path: &str, query: &str| {
    // rust: let r = route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: "GET".into(),
    // rust: path: path.into(),
    // rust: query: query.into(),
    // rust: headers: Vec::new(),
    // rust: body: Vec::new(),
    // rust: },
    // rust: );
    // rust: (r.status, r.body)
}
    // rust: let (status, body) = get("/api/v1/crash-reports", "");
    // rust: let list: Value = serde_json::from_str(&body).unwrap();
    // rust: assert_eq!(status, 200);
    // rust: assert_eq!(list["reports"].as_array().unwrap().len(), 2);
    // rust: assert_eq!(
    // rust: list["reports"][0]["name"],
    // rust: "crash-2026-11-02_10.00.00-server.txt"
    // rust: );
    // rust: let (status, text) = get(
    // rust: "/api/v1/crash-reports/read",
    // rust: "name=crash-2026-11-02_10.00.00-server.txt",
    // rust: );
    // rust: assert_eq!(status, 200);
    // rust: assert!(text.contains("OutOfMemory"));
    // rust: for name in [
    // rust: "../secret.txt",
    // rust: "..%2Fsecret.txt",
    // rust: "/etc/passwd",
    // rust: "notes.log",
    // rust: "",
    // rust: ] {
    // rust: let (status, body) = get("/api/v1/crash-reports/read", &format!("name={name}"));
    // rust: assert_eq!(status, 404, "{name}");
    // rust: assert!(!body.contains("not a report"), "{name}");
}
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

config_and_backups_over_the_api :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-api-admin-{}", std::process::id()));
    // rust: std::fs::create_dir_all(dir.join("backups")).unwrap();
    // rust: let toml = crate::config::TEMPLATE
    // rust: .replace("token = \"\"", "token = \"a-token-for-the-discord-bot\"");
    // rust: std::fs::write(dir.join(crate::config::FILE), toml).unwrap();
    // rust: std::fs::write(
    // rust: dir.join("backups/2026-10-31T12-00-00Z-manual.zip"),
    // rust: b"PK\x05\x06zip",
    // rust: )
    // rust: .unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Restarting);
    // rust: let call = |method: &str, path: &str, query: &str, body: Value| {
    // rust: let response = route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: method.into(),
    // rust: path: path.into(),
    // rust: query: query.into(),
    // rust: headers: Vec::new(),
    // rust: body: body.to_string().into_bytes(),
    // rust: },
    // rust: );
    // rust: (
    // rust: response.status,
    // rust: serde_json::from_str::<Value>(&response.body).unwrap_or(Value::Null),
    // rust: )
}
    // rust: let (status, config) = call("GET", "/api/v1/config", "", Value::Null);
    // rust: assert_eq!(
    // rust: (status, &config["config"]["api"]["token"]),
    // rust: (200, &json!("(set)"))
    // rust: );
    // rust: assert_eq!(config["config"]["world"]["difficulty"], "easy");
    // rust: let (status, outcome) = call(
    // rust: "PATCH",
    // rust: "/api/v1/config",
    // rust: "",
    // rust: json!({ "changes": { "world.difficulty": "hard", "server.max_players": 50 } }),
    // rust: );
    // rust: assert_eq!(status, 200, "{outcome}");
        // The game is down between a crash and its restart: both wait for its start.
    // rust: assert_eq!(
    // rust: outcome["restart"],
    // rust: json!(["server.max_players", "world.difficulty"])
    // rust: );
    // rust: let saved = crate::config::Config::load(&dir).unwrap();
    // rust: assert_eq!(
    // rust: (saved.world.difficulty.as_str(), saved.server.max_players),
    // rust: ("hard", 50)
    // rust: );
    // rust: for key in [
    // rust: "engine.path",
    // rust: "api.allow_public",
    // rust: "panel.bind",
    // rust: "properties.enable-rcon",
    // rust: ] {
    // rust: let (status, _) = call(
    // rust: "PATCH",
    // rust: "/api/v1/config",
    // rust: "",
    // rust: json!({ "changes": { key: "x" } }),
    // rust: );
    // rust: assert_eq!(status, 403, "{key}");
}
    // rust: let (status, _) = call(
    // rust: "PATCH",
    // rust: "/api/v1/config",
    // rust: "",
    // rust: json!({ "changes": { "world.difficulty": "brutal" } }),
    // rust: );
    // rust: assert_eq!(status, 400);
    // rust: assert_eq!(
    // rust: crate::config::Config::load(&dir).unwrap().world.difficulty,
    // rust: "hard"
    // rust: );

    // rust: let name = "2026-10-31T12-00-00Z-manual.zip";
    // rust: let response = route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: "GET".into(),
    // rust: path: "/api/v1/backups/download".into(),
    // rust: query: format!("name={name}"),
    // rust: headers: Vec::new(),
    // rust: body: Vec::new(),
    // rust: },
    // rust: );
    // rust: assert!(response.stream.is_some());
    // rust: assert!(response.headers.contains(&("Content-Length", "7".into())));
    // rust: let (status, _) = call(
    // rust: "DELETE",
    // rust: "/api/v1/backups",
    // rust: "name=../server.toml",
    // rust: Value::Null,
    // rust: );
    // rust: assert_eq!(status, 404);
    // rust: assert_eq!(
    // rust: call(
    // rust: "DELETE",
    // rust: "/api/v1/backups",
    // rust: &format!("name={name}"),
    // rust: Value::Null
    // rust: )
    // rust: .0,
    // rust: 200
    // rust: );
    // rust: assert!(backup::list(&dir).is_empty());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

backup_reply :: proc(mut response: Response) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let body = if let Some(write) = response.stream.take() {
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let mut client = std::net::TcpStream::connect(listener.local_addr().unwrap()).unwrap();
    // rust: let (server, _) = listener.accept().unwrap();
    // rust: write(&server);
    // rust: server.shutdown(std::net::Shutdown::Write).unwrap();
    // rust: let mut bytes = Vec::new();
    // rust: std::io::Read::read_to_end(&mut client, &mut bytes).unwrap();
    // rust: Value::String(
    // rust: bytes
    // rust: .iter()
    // rust: .map(|byte| format!("{byte:02x}"))
    // rust: .collect::<Vec<_>>()
    // rust: .join(""),
    // rust: )
    // rust: } else {
    // rust: serde_json::from_str(&response.body).unwrap()
}
    // rust: json!({
    // rust: "status": response.status,
    // rust: "content_type": response.content_type,
    // rust: "headers": response.headers,
    // rust: "body": body,
    // rust: })
}

backup_replies_match_api_v1_goldens :: proc() {
}
    // rust: let golden: Value =
    // rust: serde_json::from_str(include_str!("../testdata/api-v1-backups.json")).unwrap();
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-api-backup-goldens-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(dir.join("backups")).unwrap();
    // rust: std::fs::create_dir_all(dir.join("world/dimensions/minecraft/the_end")).unwrap();
    // rust: std::fs::write(dir.join(crate::config::FILE), crate::config::TEMPLATE).unwrap();
    // rust: std::fs::write(dir.join("world/level.dat"), b"level").unwrap();
    // rust: std::fs::write(
    // rust: dir.join("world/dimensions/minecraft/the_end/region.mca"),
    // rust: b"end",
    // rust: )
    // rust: .unwrap();
    // rust: let name = "2026-11-04_00-00-00-golden.zip";
    // rust: std::fs::write(dir.join("backups").join(name), b"PK\x05\x06zip").unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Stopped);
    // rust: let call = |method: &str, target: &str, body: Value| {
    // rust: let (path, query) = target.split_once('?').unwrap_or((target, ""));
    // rust: route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: method.into(),
    // rust: path: path.into(),
    // rust: query: query.into(),
    // rust: headers: Vec::new(),
    // rust: body: body.to_string().into_bytes(),
    // rust: },
    // rust: )
}
    // rust: let check = |case: &str, response: Response| {
    // rust: assert_eq!(backup_reply(response), golden[case], "{case}");
}
    // rust: check("list", call("GET", "/api/v1/backups", Value::Null));
    // rust: check(
    // rust: "download",
    // rust: call(
    // rust: "GET",
    // rust: &format!("/api/v1/backups/download?name={name}"),
    // rust: Value::Null,
    // rust: ),
    // rust: );
    // rust: check(
    // rust: "restore",
    // rust: call("POST", "/api/v1/restore", json!({ "name": name })),
    // rust: );
    // rust: check(
    // rust: "restore_dimension",
    // rust: call(
    // rust: "POST",
    // rust: "/api/v1/restore",
    // rust: json!({ "name": name, "dimension": "the_end" }),
    // rust: ),
    // rust: );
    // rust: check(
    // rust: "bad_dimension",
    // rust: call(
    // rust: "POST",
    // rust: "/api/v1/restore",
    // rust: json!({ "name": name, "dimension": "../end" }),
    // rust: ),
    // rust: );
    // rust: check(
    // rust: "restore_missing",
    // rust: call("POST", "/api/v1/restore", json!({ "name": "missing" })),
    // rust: );
    // rust: check(
    // rust: "delete_missing",
    // rust: call("DELETE", "/api/v1/backups?name=../server.toml", Value::Null),
    // rust: );
    // rust: check(
    // rust: "delete",
    // rust: call(
    // rust: "DELETE",
    // rust: &format!("/api/v1/backups?name={name}"),
    // rust: Value::Null,
    // rust: ),
    // rust: );
    // rust: check("list_empty", call("GET", "/api/v1/backups", Value::Null));

    // rust: let mut created = backup_reply(call(
    // rust: "POST",
    // rust: "/api/v1/backups",
    // rust: json!({ "name": "created" }),
    // rust: ));
    // rust: let created_name = created["body"]["name"].as_str().unwrap();
    // rust: assert!(created_name.ends_with("-created.zip"));
    // rust: assert!(dir.join("backups").join(created_name).is_file());
    // rust: created["body"]["name"] = json!("$BACKUP");
    // rust: assert_eq!(created, golden["create"]);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

stopped_supervisor_can_edit_lists_and_start_again :: proc() {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-api-stopped-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(crate::config::FILE), crate::config::TEMPLATE).unwrap();
    // rust: crate::config::update(&dir, "server", "online_mode", toml::Value::Boolean(false)).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Stopped);
    // rust: let request = |method: &str, path: &str, body: &[u8]| {
    // rust: route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: method.into(),
    // rust: path: path.into(),
    // rust: query: String::new(),
    // rust: headers: Vec::new(),
    // rust: body: body.to_vec(),
    // rust: },
    // rust: )
}
    // rust: let response = request("POST", "/api/v1/players/op", br#"{"name":"Alex"}"#);
    // rust: assert_eq!(response.status, 200, "{}", response.body);
    // rust: assert!(response.body.contains("Made Alex a server operator"));
    // rust: let response = request("POST", "/api/v1/start", b"");
    // rust: assert_eq!(response.status, 200, "{}", response.body);
    // rust: assert!(shared.restart.load(Ordering::SeqCst));
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

config_reply :: proc(response: Response) -> V {
    // Ported from Horizon
    return {}
}
    // rust: assert!(response.stream.is_none());
    // rust: json!({
    // rust: "status": response.status,
    // rust: "content_type": response.content_type,
    // rust: "headers": response.headers,
    // rust: "body": serde_json::from_str::<Value>(&response.body).unwrap(),
    // rust: })
}

config_replies_match_api_v1_goldens :: proc() {
}
    // rust: let golden: Value =
    // rust: serde_json::from_str(include_str!("../testdata/api-v1-config.json")).unwrap();
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-api-config-goldens-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let toml = crate::config::TEMPLATE
    // rust: .replace("token = \"\"", "token = \"a-token-for-the-config-test\"")
    // rust: .replace(
    // rust: "webhook = \"\"",
    // rust: "webhook = \"https://discord.com/api/webhooks/123/config-test\"",
    // rust: );
    // rust: std::fs::write(dir.join(crate::config::FILE), toml).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Stopped);
    // rust: let call = |method: &str, body: &[u8]| {
    // rust: config_reply(route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: method.into(),
    // rust: path: "/api/v1/config".into(),
    // rust: query: String::new(),
    // rust: headers: Vec::new(),
    // rust: body: body.to_vec(),
    // rust: },
    // rust: ))
}
    // rust: let check = |case: &str, method: &str, body: &[u8]| {
    // rust: assert_eq!(call(method, body), golden[case], "{case}");
}

    // rust: check("get", "GET", b"");
    // rust: check("malformed", "PATCH", b"not json");
    // rust: check(
    // rust: "protected",
    // rust: "PATCH",
    // rust: br#"{"changes":{"api.token":"replacement"}}"#,
    // rust: );
    // rust: check(
    // rust: "invalid_range",
    // rust: "PATCH",
    // rust: br#"{"changes":{"server.max_players":0}}"#,
    // rust: );
    // rust: check(
    // rust: "invalid_shape",
    // rust: "PATCH",
    // rust: br#"{"changes":{"world.seed":[1,2]}}"#,
    // rust: );
    // rust: check(
    // rust: "unknown",
    // rust: "PATCH",
    // rust: br#"{"changes":{"server.unknown":true}}"#,
    // rust: );
    // rust: check(
    // rust: "patch_stopped",
    // rust: "PATCH",
    // rust: br#"{"changes":{"world.difficulty":"hard","server.max_players":50}}"#,
    // rust: );

    // rust: shared.set_phase(Phase::Running);
    // rust: check(
    // rust: "patch_running",
    // rust: "PATCH",
    // rust: br#"{"changes":{"server.port":25566,"backups.keep":7}}"#,
    // rust: );
    // rust: let saved = crate::config::Config::load(&dir).unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: saved.world.difficulty.as_str(),
    // rust: saved.server.max_players,
    // rust: saved.server.port,
    // rust: saved.backups.keep,
    // rust: ),
    // rust: ("hard", 50, 25566, 7)
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
