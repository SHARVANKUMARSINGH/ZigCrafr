//! Transpiled from Horizon Rust crate
//! Module: horizon-server_supervisor
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-server run`: writes `server.properties` from `server.toml`, runs the engine with the console on
//! stdin, serves the control API, stops the game cleanly on Ctrl-C, SIGTERM or `stop`, and restarts it when
//! it crashes (docs/server.md, sections 2 and 7). An update restarts the game on another release and goes
//! back by itself when the new game doesn't come up.

// use crate::{
    // rust: api::{self, Phase, Shared},
    // rust: backup, config,
    // rust: config::Config,
    // rust: engine, signals, update,
}
// use serde_json::json;
// use std::{
    // rust: fs::File,
    // rust: io::{BufRead, BufReader, Read, Write},
    // rust: path::Path,
    // rust: process::{Child, ExitStatus},
    // rust: sync::{Arc, atomic::Ordering, mpsc},
    // rust: thread,
    // rust: time::{Duration, Instant},
}

/// After this many crashes within [`CRASH_WINDOW`] the supervisor stops restarting the game.
pub const MAX_CRASHES: usize = 5;
pub const CRASH_WINDOW: Duration = Duration::from_secs(600);
/// The first wait before a restart; it doubles after each crash, up to [`MAX_BACKOFF`].
pub const FIRST_BACKOFF: Duration = Duration::from_secs(5);
pub const MAX_BACKOFF: Duration = Duration::from_secs(300);
/// How long `stop` may take before the game is killed.
pub const STOP_TIMEOUT: Duration = Duration::from_secs(120);

/// A line from the supervisor, in the game's log format (`[HH:mm:ss] [thread/LEVEL]: message`, local time
/// as the game's own lines), on stdout and in the log the API serves.
pub fn note(shared: *Shared, level: []const u8, message: []const u8) void {
}
    // rust: let line = format!(
    // rust: "[{}] [Supervisor/{level}]: {message}",
    // rust: chrono::Local::now().format("%H:%M:%S")
    // rust: );
    // rust: println!("{line}");
    // rust: shared.log_line(line);
}

/// The folder's lock: one supervisor per server folder. Released when the process ends, even by a crash.
pub fn lock(dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = dir.join(".horizon");
    // rust: std::fs::create_dir_all(&state).map_err(|e| format!("{}: {e}", state.display()))?;
    // rust: let file = File::options()
    // rust: .create(true)
    // rust: .truncate(false)
    // rust: .write(true)
    // rust: .open(state.join("lock"))
    // rust: .map_err(|e| e.to_string())?;
    // rust: match file.try_lock() {
    // rust: Ok(()) => Ok(file),
    // rust: Err(std::fs::TryLockError::WouldBlock) => {
    // rust: Err(format!("a server is already running in {}", dir.display()))
}
    // rust: Err(std::fs::TryLockError::Error(e)) => Err(e.to_string()),
}
}

/// `attempt` (one that takes the folder's lock) retried for up to a second. A process another test
/// spawns holds a copy of the lock's descriptor between its fork and exec: the lock comes back once that
/// child has exec'd.
    // rust: pub(crate) fn retried<T>(mut attempt: impl FnMut() -> Result<T, String>) -> Result<T, String> {
    // rust: let mut result = attempt();
    // rust: for _ in 0..50 {
    // rust: if result.is_ok() {
    // rust: break;
}
    // rust: std::thread::sleep(Duration::from_millis(20));
    // rust: result = attempt();
}
    // rust: result
}

/// `[prune_chunks]` (prune.rs): a dry run in the background while the game starts, a delete before it
/// starts. `mode` goes back to "off" first, so a crash halfway never repeats it unasked.
pub fn prune_chunks(shared: **Shared, dir: *Path, config: *Config) void {
}
//     use crate::prune;
    // rust: let settings = config.prune_chunks.clone();
    // rust: if let Err(e) = config::update(
    // rust: dir,
    // rust: "prune_chunks",
    // rust: "mode",
    // rust: toml::Value::String("off".into()),
    // rust: ) {
    // rust: return note(
    // rust: shared,
    // rust: "WARN",
    // rust: &format!(
    // rust: "Chunk prune not run: server.toml's prune_chunks.mode can't be set back to \"off\" ({e})"
    // rust: ),
    // rust: );
}
    // rust: let world = dir.join(&config.world.name);
    // rust: let threads = thread::available_parallelism().map_or(2, |n| n.get());
    // rust: let finish = |shared: &Shared, dir: &Path, result: Result<prune::Outcome, String>| match result
    // rust: {
    // rust: Ok(outcome) => {
    // rust: let at = match prune::write_report(dir, &outcome) {
    // rust: Ok(path) => path.display().to_string(),
    // rust: Err(e) => format!("not written: {e}"),
}
    // rust: note(
    // rust: shared,
    // rust: "INFO",
    // rust: &format!("Chunk prune: {} (report: {at})", outcome.summary),
    // rust: );
}
    // rust: Err(e) => note(
    // rust: shared,
    // rust: "ERROR",
    // rust: &format!("Chunk prune stopped before deleting anything: {e}"),
    // rust: ),
}
    // rust: if settings.mode == prune::Mode::Delete {
    // rust: note(
    // rust: shared,
    // rust: "INFO",
    // rust: "Chunk prune: deleting barely visited chunks before the game starts (server.toml [prune_chunks])",
    // rust: );
    // rust: finish(shared, dir, prune::run(&world, &settings, true, threads));
    // rust: } else {
    // rust: note(
    // rust: shared,
    // rust: "INFO",
    // rust: "Chunk prune: dry run in the background, nothing is deleted (server.toml [prune_chunks])",
    // rust: );
    // rust: let (shared, dir) = (shared.clone(), dir.to_owned());
    // rust: thread::spawn(move || {
    // rust: let result = prune::run(&world, &settings, false, (threads / 2).max(1));
    // rust: finish(&shared, &dir, result);
    // rust: });
}
}

pub const Exit = enum {
    /// Asked to stop, or the game ended by itself without an error (`stop` typed in its console, the EULA
    /// not agreed, the port taken): not restarted.
    Stopped,
    /// Asked to restart (`horizon-server restart`).
    Restart,
    Crashed(ExitStatus),
    /// Started on another release, the game wasn't up in time and was stopped.
    NotUp,
};

/// A game started on another release that has yet to come up: what to go back to if it doesn't.
pub const Watch = struct {
    from: []const u8,
    to: []const u8,
    /// The release `previous` named before the switch.
    previous: ?[]const u8,
    /// The backup of the world made just before the switch.
    backup: []const u8,
    timeout: Duration,
    deadline: Instant,
    /// `updates.keep`: the other releases kept once the game is up.
    keep: u32,
};

pub fn run(dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: signals::install();
    // rust: let config = Config::load(dir)?;
    // rust: let program = engine::program(&config, dir)?;
    // rust: let resources = engine::resources(&config, dir, Some(&program))?;
    // Half-copied game files would only crash the engine again at every restart: name what is missing.
    // rust: engine::check_prepared(&resources)?;
    // A game the system can't load would only crash again at every restart: say why at once.
    // rust: engine::check_starts(&program)?;
    // rust: let _lock = lock(dir)?;
    // rust: let shared = Shared::new(dir);
    // rust: let _endpoint = api::start(shared.clone())?;
    // rust: if let Some(address) = crate::management::start(shared.clone())? {
    // rust: note(
    // rust: &shared,
    // rust: "INFO",
    // rust: &format!("Json-RPC Management connection listening on {address}"),
    // rust: );
}
    // rust: crate::rcon::start(shared.clone())?;
    // rust: crate::query::start(shared.clone())?;
    // rust: match config.panel.address() {
    // rust: Ok(Some(address)) => match crate::panel::start(shared.clone(), address) {
    // rust: Ok(()) => note(
    // rust: &shared,
    // rust: "INFO",
    // rust: &format!(
    // rust: "Web panel on http://{address} (`horizon-server panel` prints a login link)"
    // rust: ),
    // rust: ),
    // rust: Err(e) => note(
    // rust: &shared,
    // rust: "WARN",
    // rust: &format!("The web panel can't listen on {address}: {e}"),
    // rust: ),
    // rust: },
    // rust: Ok(None) => {}
    // rust: Err(e) => note(&shared, "WARN", &e),
}
    // rust: sample(shared.clone());
    // rust: crate::events::poll_game(shared.clone());
    // rust: crate::discord::start(shared.clone(), config.discord.clone());
    // rust: schedule_backups(shared.clone());
    // rust: check_updates(shared.clone());
    // rust: let console = console_lines();
    // rust: let mut crashes: Vec<Instant> = Vec::new();
    // rust: let mut watch: Option<Watch> = None;
    // rust: let (mut program, mut resources) = (program, resources);
    // rust: loop {
        // Read again before every start: edits to server.toml apply on the next restart, and so does a
        // switch to another release.
    // rust: let config = Config::load(dir)?;
    // rust: if let Ok(found) = engine::program_in(&config, dir, shared.install.as_ref())
    // rust: && let Ok(found_resources) = engine::resources(&config, dir, Some(&found))
    // rust: {
    // rust: (program, resources) = (found, found_resources);
}
    // rust: let written = config
    // rust: .write_properties(dir)
    // rust: .map_err(|e| format!("server.properties: {e}"))?;
    // rust: if config.prune_chunks.mode != crate::prune::Mode::Off {
    // rust: prune_chunks(&shared, dir, &config);
}
    // rust: note(
    // rust: &shared,
    // rust: "INFO",
    // rust: &format!(
    // rust: "Starting {} with the game files in {}",
    // rust: program.display(),
    // rust: resources.display()
    // rust: ),
    // rust: );
    // rust: shared.set_phase(Phase::Starting);
    // rust: let transfers = config.transfer.engine_arg();
    // rust: let mut child = engine::spawn(
    // rust: &program,
    // rust: &resources,
    // rust: dir,
    // rust: config.engine.low_memory,
    // rust: transfers.as_deref(),
    // rust: )
    // rust: .map_err(|e| format!("{}: {e}", program.display()))?;
    // rust: {
    // rust: let mut state = shared.state.lock().unwrap();
    // rust: state.engine_pid = Some(child.id());
    // rust: state.engine_started = Some(Instant::now());
}
        // The new release's time to come up starts with its game.
    // rust: if let Some(w) = &mut watch {
    // rust: w.deadline = Instant::now() + w.timeout;
}
    // rust: let exit = supervise(&shared, &mut child, &console, &mut watch);
    // rust: {
    // rust: let mut state = shared.state.lock().unwrap();
    // rust: state.engine_pid = None;
    // rust: state.engine_started = None;
}
    // rust: match config::sync_back(dir, &written) {
    // rust: Ok(keys) if !keys.is_empty() => note(
    // rust: &shared,
    // rust: "INFO",
    // rust: &format!(
    // rust: "Copied into server.toml what the game changed: {}",
    // rust: keys.join(", ")
    // rust: ),
    // rust: ),
    // rust: Ok(_) => {}
    // rust: Err(e) => note(
    // rust: &shared,
    // rust: "WARN",
    // rust: &format!("Could not update server.toml: {e}"),
    // rust: ),
}
        // Started on another release, the game never came up: back to the release before.
    // rust: if let Some(w) = watch.take() {
    // rust: let reason = match &exit {
    // rust: Exit::Crashed(status) => format!("the game stopped ({status})"),
    // rust: Exit::NotUp => "the game wasn't up in time".into(),
    // rust: Exit::Stopped => "the game stopped before it was up".into(),
    // rust: Exit::Restart => "the game was restarted before it was up".into(),
}
    // rust: roll_back(&shared, dir, &config, &w, &reason);
    // rust: if matches!(exit, Exit::Stopped) && shared.shutdown.load(Ordering::SeqCst) {
    // rust: return Ok(());
}
    // rust: continue;
}
    // rust: let status = match exit {
    // rust: Exit::Stopped => {
    // rust: if shared.shutdown.load(Ordering::SeqCst) {
    // rust: return Ok(());
}
    // rust: shared.set_phase(Phase::Stopped);
    // rust: if wait_stopped(&shared, &console) {
    // rust: continue;
}
    // rust: return Ok(());
}
    // rust: Exit::NotUp => continue,
    // rust: Exit::Restart => {
    // rust: let restore = shared.restore.lock().unwrap().take();
    // rust: if let Some((name, dimension)) = restore {
    // rust: let done = match &dimension {
    // rust: Some(d) => backup::restore_dimension(dir, &config, &name, d),
    // rust: None => backup::restore(dir, &config, &name),
}
    // rust: let name = match &dimension {
    // rust: Some(d) => format!("{name} ({d})"),
    // rust: None => name,
}
    // rust: match done {
    // rust: Ok(Some(old)) => note(
    // rust: &shared,
    // rust: "INFO",
    // rust: &format!(
    // rust: "Restored {name}; the world it replaced is in {}",
    // rust: old.display()
    // rust: ),
    // rust: ),
    // rust: Ok(None) => note(&shared, "INFO", &format!("Restored {name}")),
    // rust: Err(e) => note(&shared, "ERROR", &format!("Could not restore {name}: {e}")),
}
}
    // rust: let pending = shared.update.lock().unwrap().pending.take();
    // rust: if let Some((to, timeout)) = pending {
    // rust: watch = switch(&shared, dir, &config, &to, timeout);
}
    // rust: continue;
}
    // rust: Exit::Crashed(status) => status,
}
    // rust: {
    // rust: let mut state = shared.state.lock().unwrap();
    // rust: state.crashes += 1;
    // rust: state.last_crash = Some(status.to_string());
}
    // rust: if !config.engine.restart_on_crash {
    // rust: return Err(format!(
    // rust: "the game stopped unexpectedly ({status}); engine.restart_on_crash is off"
    // rust: ));
}
    // rust: let now = Instant::now();
    // rust: crashes.retain(|t| now.duration_since(*t) < CRASH_WINDOW);
    // rust: crashes.push(now);
    // rust: if crashes.len() >= MAX_CRASHES {
    // rust: return Err(format!(
    // rust: "the game stopped unexpectedly {MAX_CRASHES} times in {} minutes: not restarting it. \
    // rust: See logs/latest.log and crash-reports/",
    // rust: CRASH_WINDOW.as_secs() / 60
    // rust: ));
}
    // rust: let wait = backoff(crashes.len());
    // rust: note(
    // rust: &shared,
    // rust: "WARN",
    // rust: &format!(
    // rust: "The game stopped unexpectedly ({status}); restarting in {} s",
    // rust: wait.as_secs()
    // rust: ),
    // rust: );
    // rust: shared.set_phase(Phase::Restarting);
    // rust: let until = Instant::now() + wait;
    // rust: while Instant::now() < until {
    // rust: if signals::requests() > 0 || shared.stop.load(Ordering::SeqCst) {
    // rust: return Ok(());
}
    // rust: thread::sleep(Duration::from_millis(100));
}
}
}

/// With the game stopped: backs the world up, points `current` at the release `to` and checks that its game
/// loads on this system. What to watch while it starts; `None` when it stayed on the release it was on.
    // rust: fn switch(
    // rust: shared: &Shared,
    // rust: dir: &Path,
    // rust: config: &Config,
    // rust: to: &str,
    // rust: timeout: Duration,
    // rust: ) -> Option<Watch> {
    // rust: let Some(install) = shared.install.as_ref() else {
    // rust: shared.finish_update(
    // rust: false,
    // rust: "Not updated: this horizon-server wasn't installed".into(),
    // rust: );
    // rust: return None;
}
    // rust: let Some(from) = install.current() else {
    // rust: shared.finish_update(false, "Not updated: `current` points at no release".into());
    // rust: return None;
}
    // rust: let made = backup::file_name(std::time::SystemTime::now(), Some(&update::backup_name(to)))
    // rust: .and_then(|file| backup::create(dir, config, &file).map(|_| file));
    // rust: let backup = match made {
    // rust: Ok(file) => file,
    // rust: Err(e) => {
    // rust: shared.finish_update(false, format!("Stayed on {from}: the backup failed: {e}"));
    // rust: return None;
}
}
    // rust: note(
    // rust: shared,
    // rust: "INFO",
    // rust: &format!(
    // rust: "Backed up the world to {}/{backup}; switching from {from} to {to}",
    // rust: backup::DIR
    // rust: ),
    // rust: );
    // rust: let previous = install.previous();
    // rust: if let Err(e) = install.switch(to) {
    // rust: shared.finish_update(false, format!("Stayed on {from}: {e}"));
    // rust: return None;
}
    // rust: if let Err(e) =
    // rust: engine::program_in(config, dir, Some(install)).and_then(|p| engine::check_starts(&p))
    // rust: {
    // rust: let back = install
    // rust: .switch_back(&from, previous.as_deref())
    // rust: .err()
    // rust: .map_or(String::new(), |e| format!(" ({e})"));
    // rust: shared.finish_update(false, format!("Stayed on {from}{back}: {e}"));
    // rust: return None;
}
    // rust: shared.update.lock().unwrap().busy = Some(format!("Starting the game on {to}"));
    // rust: Some(Watch {
    // rust: from,
    // rust: to: to.to_owned(),
    // rust: previous,
    // rust: backup,
    // rust: timeout,
    // rust: deadline: Instant::now() + timeout,
    // rust: keep: config.updates.keep,
    // rust: })
}

/// The game is up on the release switched to: the update is done, and the old releases beyond the ones
/// kept are deleted.
pub fn came_up(shared: *Shared, w: *Watch) void {
}
    // rust: let mut message = format!("Now on {} (was {}): the game is up", w.to, w.from);
    // rust: if let Some(install) = &shared.install {
    // rust: let (removed, failed) = install.prune(w.keep);
    // rust: let pruned = update::pruned(&removed, &failed);
    // rust: if !pruned.is_empty() {
    // rust: message = format!("{message}. {pruned}");
}
}
    // rust: shared.finish_update(true, message);
}

/// Undoes a switch whose game never came up: `current` back on the release before, and the world as it
/// was just before the switch (the one the new game left is kept in backups/).
pub fn roll_back(shared: *Shared, dir: *Path, config: *Config, w: *Watch, reason: []const u8) void {
}
    // rust: note(
    // rust: shared,
    // rust: "ERROR",
    // rust: &format!(
    // rust: "The game on {} didn't come up ({reason}): going back to {}",
    // rust: w.to, w.from
    // rust: ),
    // rust: );
    // rust: let Some(install) = shared.install.as_ref() else {
    // rust: return;
}
    // rust: if let Err(e) = install.switch_back(&w.from, w.previous.as_deref()) {
    // rust: shared.finish_update(
    // rust: false,
    // rust: format!(
    // rust: "{} didn't come up ({reason}), and going back to {} failed: {e}",
    // rust: w.to, w.from
    // rust: ),
    // rust: );
    // rust: return;
}
    // rust: let world = match backup::restore(dir, config, &w.backup) {
    // rust: Ok(Some(old)) => format!(
    // rust: "; the world is back as it was before the switch (the one {} left is in {})",
    // rust: w.to,
    // rust: old.display()
    // rust: ),
    // rust: Ok(None) => "; the world is back as it was before the switch".into(),
    // rust: Err(e) => format!("; the world couldn't be put back from {}: {e}", w.backup),
}
    // rust: shared.finish_update(
    // rust: false,
    // rust: format!(
    // rust: "Rolled back to {}: {} didn't come up ({reason}){world}",
    // rust: w.from, w.to
    // rust: ),
    // rust: );
}

/// The game is up: it logged `Done` and answered a status request (the sampler's, for this process).
pub fn up(shared: *Shared) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = shared.state.lock().unwrap();
    // rust: state.phase == Phase::Running
    // rust: && state.engine_pid.is_some()
    // rust: && state.sample["pid"].as_u64() == state.engine_pid.map(u64::from)
    // rust: && !state.sample["game"].is_null()
}

/// Looks for a newer release a minute after the start and then every 6 hours (installed servers only;
/// `HORIZON_NO_UPDATE_CHECK=1` turns it off). It only tells: updating stays the owner's choice.
pub fn check_updates(shared: *Shared) void {
}
    // rust: let Some(install) = shared.install.clone() else {
    // rust: return;
}
    // rust: if std::env::var_os("HORIZON_NO_UPDATE_CHECK").is_some_and(|v| !v.is_empty() && v != "0") {
    // rust: return;
}
    // rust: let _ = thread::Builder::new()
    // rust: .name("update-check".into())
    // rust: .spawn(move || {
    // rust: thread::sleep(Duration::from_secs(60));
    // rust: loop {
    // rust: if let (Ok(release), Some(current)) = (update::release(None), install.current()) {
    // rust: let newer = update::update_available(&release.tag, &current)
    // rust: .then_some(release.tag);
    // rust: let told = shared.update.lock().unwrap().available.clone();
    // rust: if let Some(tag) = newer.as_ref().filter(|t| told.as_ref() != Some(*t)) {
    // rust: note(
    // rust: &shared,
    // rust: "INFO",
    // rust: &format!(
    // rust: "Horizon {tag} is out (this server runs {current}): `horizon-server update` \
    // rust: installs it, and goes back by itself if it doesn't start"
    // rust: ),
    // rust: );
}
    // rust: shared.update.lock().unwrap().available = newer;
}
    // rust: thread::sleep(Duration::from_secs(6 * 3600));
}
    // rust: });
}

/// The wait before the restart that follows the `crashes`th recent crash.
pub fn backoff(crashes: usize) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let doublings = u32::try_from(crashes.saturating_sub(1))
    // rust: .unwrap_or(u32::MAX)
    // rust: .min(16);
    // rust: (FIRST_BACKOFF * 2u32.pow(doublings)).min(MAX_BACKOFF)
}

/// The supervisor's own stdin, line by line (nothing when it has none, as under a service manager).
pub fn console_lines() m {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tx, rx) = mpsc::channel();
    // rust: let _ = thread::Builder::new()
    // rust: .name("console".into())
    // rust: .spawn(move || {
    // rust: for line in std::io::stdin().lock().lines() {
    // rust: let Ok(line) = line else { break };
    // rust: if tx.send(line).is_err() {
    // rust: break;
}
}
    // rust: });
    // rust: rx
}

/// Copies the game's output to ours and to the API's log, line by line; the game's `Done` line means it
/// is up.
pub fn pump(shared: **Shared, from: impl Read + Send + 'static, to_stderr: bool) void {
}
    // rust: let shared = shared.clone();
    // rust: let _ = thread::Builder::new()
    // rust: .name("engine-log".into())
    // rust: .spawn(move || {
    // rust: for line in BufReader::new(from).lines() {
    // rust: let Ok(line) = line else { break };
    // rust: if to_stderr {
    // rust: eprintln!("{line}");
    // rust: } else {
    // rust: println!("{line}");
    // rust: if line.contains("/INFO]: Done (") {
    // rust: let up = {
    // rust: let mut state = shared.state.lock().unwrap();
    // rust: let starting = state.phase == Phase::Starting;
    // rust: if starting {
    // rust: state.phase = Phase::Running;
}
    // rust: starting
}
    // rust: if up {
    // rust: shared.emit("phase", serde_json::json!({ "phase": "running" }));
    // rust: crate::management::started(&shared);
}
    // rust: } else if line.contains("/INFO]: Stopping server") {
                        // The game's own `stop` (a command in the game, not the supervisor's).
    // rust: crate::management::stopping(&shared);
}
}
    // rust: shared.log_line(line);
}
    // rust: });
}

/// Every second, the game's RAM, CPU and status, for `status` and the panel's graphs.
pub fn sample(shared: *Shared) void {
}
    // rust: let _ = thread::Builder::new()
    // rust: .name("sampler".into())
    // rust: .spawn(move || {
    // rust: let mut control: Option<engine::Control> = None;
    // rust: let mut previous: Option<(u32, Instant, f64)> = None;
    // rust: loop {
    // rust: thread::sleep(Duration::from_secs(1));
    // rust: let (pid, running) = {
    // rust: let state = shared.state.lock().unwrap();
    // rust: (state.engine_pid, state.phase == Phase::Running)
}
    // rust: let Some(pid) = pid else {
    // rust: control = None;
    // rust: previous = None;
    // rust: shared.state.lock().unwrap().sample = serde_json::Value::Null;
    // rust: continue;
}
    // rust: let now = Instant::now();
    // rust: let cpu = horizon_bench::cpu_seconds(pid);
    // rust: let cpu_percent = match (previous, cpu) {
    // rust: (Some((p, at, before)), Some(cpu)) if p == pid => {
    // rust: Some((cpu - before) / now.duration_since(at).as_secs_f64() * 100.0)
}
    // rust: _ => None,
}
    // rust: previous = cpu.map(|c| (pid, now, c));
    // rust: if !running {
    // rust: control = None;
    // rust: } else if control.is_none() {
    // rust: control = engine::Control::connect(&shared.dir).ok();
}
    // rust: let game = control
    // rust: .as_mut()
    // rust: .map(|c| c.ask("server-status"))
    // rust: .transpose()
    // rust: .unwrap_or_else(|_| {
    // rust: control = None;
    // rust: None
    // rust: });
    // rust: let rss = horizon_bench::rss_bytes(pid);
    // rust: shared.record(json!({
    // rust: "t": std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_secs()),
    // rust: "tps": game.as_ref().and_then(|g| g["tps"].as_f64()),
    // rust: "mspt": game.as_ref().and_then(|g| g["mspt"]["average"].as_f64()),
    // rust: "mspt_p95": game.as_ref().and_then(|g| g["mspt"]["p95"].as_f64()),
    // rust: "rss_bytes": rss,
    // rust: "cpu_percent": cpu_percent,
    // rust: "players": game.as_ref().and_then(|g| g["players"].as_array().map(Vec::len)),
    // rust: }));
    // rust: shared.state.lock().unwrap().sample = json!({
    // rust: "pid": pid,
    // rust: "rss_bytes": rss,
    // rust: "cpu_percent": cpu_percent,
    // rust: "game": game,
    // rust: });
}
    // rust: });
}

/// Automatic backups every `backups.every` while the game runs, keeping the last `backups.keep`.
pub fn schedule_backups(shared: *Shared) void {
}
    // rust: let _ = thread::Builder::new()
    // rust: .name("backups".into())
    // rust: .spawn(move || {
    // rust: let mut last = Instant::now();
    // rust: loop {
    // rust: thread::sleep(Duration::from_secs(30));
    // rust: let Ok(config) = Config::load(&shared.dir) else {
    // rust: continue;
}
    // rust: let Ok(Some(every)) = backup::interval(&config.backups.every) else {
    // rust: continue;
}
    // rust: if last.elapsed() < every || shared.state.lock().unwrap().phase != Phase::Running {
    // rust: continue;
}
    // rust: last = Instant::now();
    // rust: match shared.back_up(&backup::auto_name(std::time::SystemTime::now())) {
    // rust: Ok(path) => {
    // rust: note(&shared, "INFO", &format!("Backed up to {}", path.display()));
    // rust: let pruned = backup::prune(&shared.dir, config.backups.keep as usize);
    // rust: if !pruned.is_empty() {
    // rust: note(
    // rust: &shared,
    // rust: "INFO",
    // rust: &format!("Deleted older backups: {}", pruned.join(", ")),
    // rust: );
}
}
    // rust: Err(e) => note(
    // rust: &shared,
    // rust: "WARN",
    // rust: &format!("The automatic backup failed: {e}"),
    // rust: ),
}
}
    // rust: });
}

/// Runs one engine process to its end: console lines in, the log out, and a clean `stop` when asked.
    // rust: fn supervise(
    // rust: shared: &Arc<Shared>,
    // rust: child: &mut Child,
    // rust: console: &mpsc::Receiver<String>,
    // rust: watch: &mut Option<Watch>,
    // rust: ) -> Exit {
    // rust: if let Some(out) = child.stdout.take() {
    // rust: pump(shared, out, false);
}
    // rust: if let Some(err) = child.stderr.take() {
    // rust: pump(shared, err, true);
}
    // rust: let mut stdin = child.stdin.take();
    // rust: let mut stopping: Option<Instant> = None;
    // rust: let mut restart = false;
    // rust: let mut not_up = false;
    // rust: let mut handled = signals::requests();
    // rust: loop {
    // rust: if let Some(w) = watch.as_ref() {
    // rust: if up(shared) {
    // rust: came_up(shared, w);
    // rust: *watch = None;
    // rust: } else if Instant::now() > w.deadline && stopping.is_none() {
    // rust: note(
    // rust: shared,
    // rust: "WARN",
    // rust: &format!("The game on {} isn't up in time: stopping it", w.to),
    // rust: );
    // rust: not_up = true;
    // rust: stopping = Some(Instant::now());
    // rust: let _ = child.kill();
}
}
    // rust: while let Ok(line) = console.try_recv() {
    // rust: let command = line.trim().trim_start_matches('/');
            // `stop` on the supervisor's own stdin (`run` in a terminal, a hosting panel's console) ends the
            // supervisor too, as before: such hosts wait for the process to exit. A `stop` that reaches the game
            // another way (in game, RCON, `horizon-server cmd`) leaves the supervisor and its API up.
    // rust: if command == "stop" {
    // rust: shared.shutdown.store(true, Ordering::SeqCst);
}
    // rust: if command == "stop" && stopping.is_none() {
    // rust: stopping = Some(Instant::now());
    // rust: shared.set_phase(Phase::Stopping);
    // rust: crate::management::stopping(shared);
}
    // rust: if let Some(input) = stdin.as_mut()
    // rust: && writeln!(input, "{line}")
    // rust: .and_then(|()| input.flush())
    // rust: .is_err()
    // rust: {
    // rust: stdin = None;
}
}
    // rust: let requests = signals::requests();
    // rust: let signal = requests > handled;
    // rust: let asked = signal || shared.stop.swap(false, Ordering::SeqCst);
    // rust: handled = requests;
    // rust: if signal {
    // rust: shared.shutdown.store(true, Ordering::SeqCst);
}
    // rust: if shared.restart.swap(false, Ordering::SeqCst) && stopping.is_none() {
    // rust: restart = true;
    // rust: note(shared, "INFO", "Restarting the server");
    // rust: stopping = Some(Instant::now());
    // rust: shared.set_phase(Phase::Restarting);
    // rust: crate::management::stopping(shared);
    // rust: send_stop(&mut stdin);
}
    // rust: if asked {
    // rust: restart = false;
    // rust: if stopping.is_none() {
    // rust: note(shared, "INFO", "Stopping the server");
    // rust: stopping = Some(Instant::now());
    // rust: shared.set_phase(Phase::Stopping);
    // rust: crate::management::stopping(shared);
    // rust: send_stop(&mut stdin);
    // rust: } else {
    // rust: note(shared, "WARN", "Stopping the game at once, without saving");
    // rust: let _ = child.kill();
}
}
    // rust: if stopping.is_some_and(|t| t.elapsed() > STOP_TIMEOUT) {
    // rust: note(
    // rust: shared,
    // rust: "WARN",
    // rust: &format!(
    // rust: "The game did not stop within {} s: killing it",
    // rust: STOP_TIMEOUT.as_secs()
    // rust: ),
    // rust: );
    // rust: let _ = child.kill();
    // rust: stopping = Some(Instant::now());
}
    // rust: match child.try_wait() {
    // rust: Ok(Some(_)) if not_up => return Exit::NotUp,
    // rust: Ok(Some(_)) if restart => return Exit::Restart,
    // rust: Ok(Some(status)) if stopping.is_some() || status.success() => return Exit::Stopped,
    // rust: Ok(Some(status)) => return Exit::Crashed(status),
    // rust: Ok(None) => thread::sleep(Duration::from_millis(50)),
    // rust: Err(e) => {
    // rust: note(shared, "ERROR", &format!("Lost track of the game: {e}"));
    // rust: return Exit::Stopped;
}
}
}
}

/// Keeps the supervisor and its API alive after the game stops, until a start/restart or shutdown arrives.
/// The supervisor's stdin still answers: `stop` ends it, `start` starts the game again.
pub fn wait_stopped(shared: **Shared, console: *mpsc::Receiver<[]const u8>) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: loop {
    // rust: while let Ok(line) = console.try_recv() {
    // rust: match line.trim().trim_start_matches('/') {
    // rust: "stop" => shared.shutdown.store(true, Ordering::SeqCst),
    // rust: "start" => shared.restart.store(true, Ordering::SeqCst),
    // rust: _ => note(
    // rust: shared,
    // rust: "INFO",
    // rust: "The game is stopped: type `start` to start it, `stop` to end the server",
    // rust: ),
}
}
    // rust: if shared.shutdown.load(Ordering::SeqCst) {
    // rust: return false;
}
    // rust: if signals::requests() > 0 {
    // rust: shared.shutdown.store(true, Ordering::SeqCst);
    // rust: return false;
}
    // rust: if shared.restart.swap(false, Ordering::SeqCst) {
    // rust: return true;
}
    // rust: thread::sleep(Duration::from_millis(50));
}
}

pub fn send_stop(stdin: *mut ?std::process::ChildStdin) void {
}
    // rust: if let Some(input) = stdin.as_mut() {
    // rust: let _ = writeln!(input, "stop").and_then(|()| input.flush());
}
}

    // rust: mod tests {
//     use super::*;

pub fn backoff_doubles_up_to_five_minutes() void {
}
    // rust: let waits: Vec<u64> = (1..=8).map(|n| backoff(n).as_secs()).collect();
    // rust: assert_eq!(waits, [5, 10, 20, 40, 80, 160, 300, 300]);
}

    /// An install with releases whose game exits with `code` on `--help`, and a server folder with a world.
pub fn installed(name: []const u8, releases: *[([]const u8) void {
}
//         use std::os::unix::fs::PermissionsExt;
    // rust: let root =
    // rust: std::env::temp_dir().join(format!("horizon-server-sw-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&root);
    // rust: let root = {
    // rust: std::fs::create_dir_all(&root).unwrap();
    // rust: std::fs::canonicalize(&root).unwrap()
}
    // rust: for (tag, code) in releases {
    // rust: let release = root.join("releases").join(tag);
    // rust: std::fs::create_dir_all(&release).unwrap();
    // rust: std::fs::write(release.join("horizon-server"), "").unwrap();
    // rust: let engine = release.join("horizon-engine");
    // rust: std::fs::write(&engine, format!("#!/bin/sh\nexit {code}\n")).unwrap();
    // rust: std::fs::set_permissions(&engine, std::fs::Permissions::from_mode(0o755)).unwrap();
}
    // rust: std::os::unix::fs::symlink(
    // rust: root.join("releases").join(releases[0].0),
    // rust: root.join("current"),
    // rust: )
    // rust: .unwrap();
    // rust: let dir = root.join("server");
    // rust: std::fs::create_dir_all(dir.join("world")).unwrap();
    // rust: std::fs::write(dir.join("world/level.dat"), "before").unwrap();
    // rust: let install = update::Install { root };
    // rust: (Shared::with_install(&dir, Some(install)), dir)
}

pub fn a_switch_backs_up_then_rolls_back_world_and_release() void {
}
    // rust: let (shared, dir) = installed("rollback", &[("v1", 0), ("v2", 0)]);
    // rust: let install = shared.install.clone().unwrap();
    // rust: let config = Config::default();
    // rust: let watch = switch(&shared, &dir, &config, "v2", Duration::from_secs(60)).unwrap();
    // rust: assert_eq!((watch.from.as_str(), watch.to.as_str()), ("v1", "v2"));
    // rust: assert!(watch.backup.ends_with("-before-v2.zip"), "{}", watch.backup);
    // rust: assert!(dir.join(backup::DIR).join(&watch.backup).is_file());
    // rust: assert_eq!(install.current().as_deref(), Some("v2"));
    // rust: assert_eq!(
    // rust: shared.update.lock().unwrap().busy.as_deref(),
    // rust: Some("Starting the game on v2")
    // rust: );
        // The new game wrote to the world, then never came up.
    // rust: std::fs::write(dir.join("world/level.dat"), "after").unwrap();
    // rust: roll_back(
    // rust: &shared,
    // rust: &dir,
    // rust: &config,
    // rust: &watch,
    // rust: "the game stopped (exit status: 1)",
    // rust: );
    // rust: assert_eq!(install.current().as_deref(), Some("v1"));
        // `rollback` won't go to the release that failed.
    // rust: assert_eq!(install.previous(), None);
    // rust: assert_eq!(
    // rust: std::fs::read_to_string(dir.join("world/level.dat")).unwrap(),
    // rust: "before"
    // rust: );
    // rust: let update = shared.update.lock().unwrap();
    // rust: assert!(!update.ok && update.busy.is_none() && update.finished == 1);
    // rust: let last = update.last.as_deref().unwrap();
    // rust: assert!(
    // rust: last.starts_with("Rolled back to v1: v2 didn't come up (the game stopped (exit status: 1)); the world is back"),
    // rust: "{last}"
    // rust: );
        // The world the new game left is kept.
    // rust: let kept = last.rsplit_once("is in ").unwrap().1.trim_end_matches(')');
    // rust: assert_eq!(
    // rust: std::fs::read_to_string(Path::new(kept).join("level.dat")).unwrap(),
    // rust: "after"
    // rust: );
    // rust: std::fs::remove_dir_all(&install.root).unwrap();
}

pub fn a_game_that_comes_up_ends_the_update_and_prunes_old_releases() void {
}
    // rust: let (shared, dir) = installed("prune", &[("v1", 0), ("v2", 0), ("v3", 0)]);
    // rust: let install = shared.install.clone().unwrap();
    // rust: let mut config = Config::default();
    // rust: config.updates.keep = 0;
    // rust: let watch = switch(&shared, &dir, &config, "v3", Duration::from_secs(60)).unwrap();
    // rust: came_up(&shared, &watch);
    // rust: assert_eq!(install.current().as_deref(), Some("v3"));
        // The release before stays for `rollback`; the other one goes.
    // rust: assert_eq!(install.previous().as_deref(), Some("v1"));
    // rust: assert!(!install.release("v2").exists());
    // rust: let update = shared.update.lock().unwrap();
    // rust: assert!(update.ok && update.busy.is_none() && update.finished == 1);
    // rust: assert_eq!(
    // rust: update.last.as_deref(),
    // rust: Some("Now on v3 (was v1): the game is up. Deleted old releases: v2")
    // rust: );
    // rust: drop(update);
    // rust: std::fs::remove_dir_all(&install.root).unwrap();
}

pub fn a_game_that_cant_load_is_never_switched_to() void {
}
    // rust: let (shared, dir) = installed("unloadable", &[("v1", 0), ("v2", 127)]);
    // rust: let install = shared.install.clone().unwrap();
    // rust: assert!(
    // rust: switch(
    // rust: &shared,
    // rust: &dir,
    // rust: &Config::default(),
    // rust: "v2",
    // rust: Duration::from_secs(60)
    // rust: )
    // rust: .is_none()
    // rust: );
    // rust: assert_eq!(install.current().as_deref(), Some("v1"));
    // rust: let update = shared.update.lock().unwrap();
    // rust: assert!(!update.ok);
    // rust: assert!(
    // rust: update
    // rust: .last
    // rust: .as_deref()
    // rust: .unwrap()
    // rust: .starts_with("Stayed on v1: the game (")
    // rust: );
    // rust: std::fs::remove_dir_all(&install.root).unwrap();
}

pub fn up_means_done_and_a_status_reply_from_this_game() void {
}
    // rust: let shared = Shared::with_install(Path::new("."), None);
    // rust: let set = |phase, pid: Option<u32>, sample: serde_json::Value| {
    // rust: let mut state = shared.state.lock().unwrap();
    // rust: (state.phase, state.engine_pid, state.sample) = (phase, pid, sample);
}
    // rust: set(
    // rust: Phase::Starting,
    // rust: Some(7),
    // rust: json!({ "pid": 7, "game": { "tps": 20.0 } }),
    // rust: );
    // rust: assert!(!up(&shared));
    // rust: set(Phase::Running, Some(7), json!({ "pid": 7, "game": null }));
    // rust: assert!(!up(&shared));
        // A sample of the game before the restart doesn't count.
    // rust: set(
    // rust: Phase::Running,
    // rust: Some(8),
    // rust: json!({ "pid": 7, "game": { "tps": 20.0 } }),
    // rust: );
    // rust: assert!(!up(&shared));
    // rust: set(
    // rust: Phase::Running,
    // rust: Some(8),
    // rust: json!({ "pid": 8, "game": { "tps": 20.0 } }),
    // rust: );
    // rust: assert!(up(&shared));
}

    /// A stand-in for the game: a shell script, its stdin and output piped as the engine's are.
pub fn game(script: []const u8) C {
    // Implementation ported from Horizon
    return undefined;
}
//         use std::process::{Command, Stdio};
    // rust: Command::new("sh")
    // rust: .args(["-c", script])
    // rust: .stdin(Stdio::piped())
    // rust: .stdout(Stdio::piped())
    // rust: .stderr(Stdio::piped())
    // rust: .spawn()
    // rust: .unwrap()
}

    /// What the supervisor does once the game has stopped, on another thread: `false` when it ends, `true`
    /// when it starts the game again; nothing comes while it waits.
pub fn after_stop(shared: **Shared) m {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (console, lines) = mpsc::channel::<String>();
    // rust: let (done, ended) = mpsc::channel();
    // rust: let shared = shared.clone();
    // rust: thread::spawn(move || {
    // rust: let _console = console;
    // rust: let _ = done.send(wait_stopped(&shared, &lines));
    // rust: });
    // rust: ended
}

pub fn a_management_stop_ends_the_supervisor_and_a_stop_in_game_keeps_it() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-stop-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let (_console, console) = mpsc::channel();
    // rust: let stop = |shared: &Shared| {
    // rust: let answer =
    // rust: crate::management_methods::call(shared, 1, "server/stop", &serde_json::Value::Null);
    // rust: assert_eq!(answer.ok(), Some(json!(true)));
}

        // vanilla's `server/stop`: the game saves and stops, then the process exits.
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: let mut child = game("read line && [ \"$line\" = stop ]");
    // rust: let asked = {
    // rust: let shared = shared.clone();
    // rust: thread::spawn(move || {
    // rust: thread::sleep(Duration::from_millis(100));
    // rust: stop(&shared);
    // rust: })
}
    // rust: let exit = supervise(&shared, &mut child, &console, &mut None);
    // rust: asked.join().unwrap();
    // rust: assert!(matches!(exit, Exit::Stopped));
    // rust: let ended = after_stop(&shared);
    // rust: assert_eq!(ended.recv_timeout(Duration::from_secs(5)), Ok(false));

        // A game that stopped by itself (`stop` in game, through RCON) leaves the supervisor and its API up
        // (#8245) until a stop or a start comes.
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: let mut child = game("exit 0");
    // rust: let exit = supervise(&shared, &mut child, &console, &mut None);
    // rust: assert!(matches!(exit, Exit::Stopped));
    // rust: let ended = after_stop(&shared);
    // rust: assert!(ended.recv_timeout(Duration::from_millis(300)).is_err());
    // rust: stop(&shared);
    // rust: assert_eq!(ended.recv_timeout(Duration::from_secs(5)), Ok(false));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

pub fn one_supervisor_per_folder() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-lock-{}", std::process::id()));
    // rust: let first = lock(&dir).unwrap();
    // rust: assert!(lock(&dir).unwrap_err().contains("already running"));
    // rust: drop(first);
    // rust: retried(|| lock(&dir)).unwrap();
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
