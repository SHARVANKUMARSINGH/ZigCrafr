//! Transpiled from Horizon Rust crate
//! Module: horizon-client_repro
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Repro recordings (docs/agent-control.md): a session's input, tick-stamped
//! state and (single player) a copy of the world, so a bug report can carry a
//! reproducible run. `record-start`/`record-stop` write it, `repro-export`
//! zips it with the logs and crash report, and `record-replay` loads the
//! world and feeds the inputs back, best effort.
//!
//! The recording format (`horizon-repro/1`):
//!
//! ```text
//! recordings/<stamp>-<name>/
//!   session.json          format, mode, world, ticks, counts
//!   inputs.jsonl          one trace event a line (game/input_trace.rs)
//!   state.jsonl           `state_value()` every second, entities every ten
//!   events.jsonl          the agent event log (screens, chat, deaths, items)
//!   world/                single player only: the world when it started
//!   README.txt
//! ```
// use super::event_loop::EventLoopCtl;
// use super::input_trace::{InputOrigin, TraceEvent, TraceKind};
// use super::{Game, Screen};
// use horizon_client::{Result, gamepad::Button, keybinds, text::Text, title::world_management};
// use horizon_core::geometry::Vec3;
// use horizon_telemetry::scrub::Scrubber;
// use serde::Deserialize;
// use serde_json::{Value, json};
// use std::{
    // rust: fs,
    // rust: io::{self, BufWriter, Write},
    // rust: path::{Path, PathBuf},
    // rust: sync::mpsc::{self, Receiver, Sender, TryRecvError},
    // rust: thread,
    // rust: time::{Duration, Instant, SystemTime},
}
// use winit::{
    // rust: dpi::PhysicalPosition,
    // rust: event::{DeviceId, ElementState, MouseScrollDelta, TouchPhase, WindowEvent},
    // rust: window::WindowId,
}

    // rust: pub(super) const HELP: &[&str] = &[
    // rust: "record-start [NAME] [--no-world]  record input, state and the world for a bug repro",
    // rust: "record-stop [--export]            stop the recording (and write the repro zip)",
    // rust: "record-status                     the running recording and replay, if any",
    // rust: "record-list                       the recordings and bundles on disk",
    // rust: "record-replay NAME [--stop] [--in-place] [--keep-world] [--timeout S]  replay a recording, best effort",
    // rust: "repro-export [NAME] [PATH] [--no-world]  zip a recording with the logs, crash report and status",
    // rust: ];

/// What `session.json` says this is.
pub const FORMAT: []const u8 = "horizon-repro/1";
/// A keyframe every second: replay's state oracle.
pub const KEYFRAME_TICKS: u64 = 20;
/// Entities every ten seconds: bigger, so rarer.
pub const ENTITIES_TICKS: u64 = 200;
/// A recording stops itself at this many input events.
pub const MAX_INPUT_EVENTS: u64 = 1_000_000;
/// A recording stops itself after this long (two hours).
pub const MAX_RECORDING_SECS: u64 = 2 * 60 * 60;
/// How long a replay may take by default.
pub const REPLAY_TIMEOUT_SECS: u64 = 300;
/// Recordings and bundles kept; the oldest beyond these are pruned.
pub const KEPT_RECORDINGS: usize = 10;

/// What a replay may run. Bundles travel between machines, so a recording is
/// not allowed to run world, network or account commands on someone else's
/// game: only the input and movement lines a repro needs.
    // rust: const REPLAY_COMMANDS: &[&str] = &[
    // rust: "attack",
    // rust: "click",
    // rust: "click-at",
    // rust: "click-button",
    // rust: "click-slot",
    // rust: "close",
    // rust: "drag-at",
    // rust: "drop",
    // rust: "goto",
    // rust: "hold",
    // rust: "interact",
    // rust: "jump",
    // rust: "key",
    // rust: "look",
    // rust: "look-at",
    // rust: "mouse",
    // rust: "mouse-move",
    // rust: "move",
    // rust: "open-inventory",
    // rust: "pad",
    // rust: "release",
    // rust: "respawn",
    // rust: "scroll",
    // rust: "scroll-at",
    // rust: "select",
    // rust: "stop",
    // rust: "tp",
    // rust: "turn",
    // rust: "use-item",
    // rust: "wait",
    // rust: ];

/// A recording, an export and a replay in flight: the game's repro state.
    // rust: pub(super) struct Repro {
    // rust: recording: Option<Recording>,
    // rust: replay: Option<Replay>,
    /// A replay waits for its world to load.
    // rust: pending_replay: Option<PendingReplay>,
    /// Zip files being written off the game thread.
    // rust: exports: Vec<Export>,
}

pub const Recording = struct {
    name: []const u8,
    dir: PathBuf,
    start_tick: u64,
    started: Instant,
    /// Wall clock, for the crash report's freshness.
    started_at: SystemTime,
    /// `InputTrace`'s count when the recording started: the inputs in this run.
    input_base: u64,
    /// The player and world state when it started: a replay returns the player
    /// to where the recording was.
    start: Value,
    mode: *'static str,
    world: ?[]const u8,
    /// Joins `inputs.jsonl`'s writer once `InputTrace::stop_file` drops it.
    inputs: ?thread::JoinHandle<()>,
    events: ?Sender<[]const u8>,
    events_joined: ?thread::JoinHandle<()>,
    states: ?Sender<[]const u8>,
    states_joined: ?thread::JoinHandle<()>,
    inputs_written: u64,
    events_written: u64,
    states_written: u64,
};

pub const Replay = struct {
    name: []const u8,
    /// The recording's first tick, which becomes the replay's first tick.
    base_tick: u64,
    start_tick: u64,
    /// The replay's last tick: the recording's span, not just its last input.
    end_at: u64,
    deadline: Instant,
    events: std.ArrayList(TraceEvent),
    index: usize,
    sent: u64,
    skipped: u64,
    last_progress: u64,
    /// The `saves/` copy it opened, removed when it ends unless kept.
    world_folder: ?[]const u8,
    keep_world: bool,
};

pub const PendingReplay = struct {
    reply: ?Sender<[]const u8>,
    name: []const u8,
    /// The `saves/` folder to open; empty for `--in-place`.
    folder: []const u8,
    in_place: bool,
    opened: bool,
    keep_world: bool,
    /// When the replay was asked for, not when its world finally loaded.
    deadline: Instant,
    base_tick: u64,
    end_tick: u64,
    start: ?Value,
    events: std.ArrayList(TraceEvent),
};

pub const Export = struct {
    rx: Receiver<Value>,
    reply: ?Sender<[]const u8>,
    key: bool,
};

pub const SessionMeta = struct {
    start_tick: u64,
    mode: []const u8,
    /// Where the recording stopped: a replay keeps running until the same point.
    /// `None` when the process died before `record-stop`.
    end_tick: ?u64,
    /// The state the recording started from.
    start: ?Value,
};

pub fn home() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_client::logging::game_home()
}
pub fn recordings_dir() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: home().join("recordings")
}
pub fn bundles_dir() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: home().join("repro")
}
pub fn saves_dir() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::env::current_dir()
    // rust: .map(|dir| dir.join("saves"))
    // rust: .unwrap_or_else(|_| PathBuf::from("saves"))
}
pub fn stamp() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: chrono::Local::now().format("%Y-%m-%d_%H-%M-%S").to_string()
}
pub fn slug(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let slug: String = name
    // rust: .chars()
    // rust: .map(|c| {
    // rust: if c.is_ascii_alphanumeric() || c == '-' || c == '_' {
    // rust: c
    // rust: } else {
    // rust: '-'
}
    // rust: })
    // rust: .collect();
    // rust: let slug = slug.trim_matches('-').to_lowercase();
    // rust: if slug.is_empty() {
    // rust: "session".into()
    // rust: } else {
    // rust: slug
}
}

/// One buffered line writer per file, off the game thread.
pub fn spawn_lines(path: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = fs::File::create(path)?;
    // rust: let (tx, rx) = mpsc::channel::<String>();
    // rust: let handle = thread::spawn(move || {
    // rust: let mut out = BufWriter::new(file);
    // rust: let mut lines = 0u64;
    // rust: for line in rx {
    // rust: if writeln!(out, "{line}").is_err() {
    // rust: break;
}
    // rust: lines += 1;
            // A crash loses at most this many lines.
    // rust: if lines.is_multiple_of(64) && out.flush().is_err() {
    // rust: break;
}
}
    // rust: let _ = out.flush();
    // rust: });
    // rust: Ok((tx, handle))
}

/// Copy a world without its lock or symlinks; the recording's own snapshot.
pub fn copy_tree(src: *Path, dst: *Path) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: fs::create_dir_all(dst)?;
    // rust: for entry in fs::read_dir(src)? {
    // rust: let entry = entry?;
    // rust: let name = entry.file_name();
    // rust: if name == "session.lock" {
    // rust: continue;
}
    // rust: let path = entry.path();
    // rust: let kind = entry.file_type()?;
    // rust: if kind.is_symlink() {
    // rust: continue;
}
    // rust: let to = dst.join(&name);
    // rust: if kind.is_dir() {
    // rust: copy_tree(&path, &to)?;
    // rust: } else if kind.is_file() {
    // rust: fs::copy(&path, &to)?;
}
}
    // rust: Ok(())
}

/// The oldest recordings or bundles beyond `max`, leaving `keep` alone.
pub fn prune_dir(dir: *Path, keep: ?*Path, max: usize) void {
}
    // rust: let Ok(entries) = fs::read_dir(dir) else {
    // rust: return;
}
    // rust: let mut items: Vec<(SystemTime, PathBuf)> = entries
    // rust: .flatten()
    // rust: .filter_map(|entry| {
    // rust: let path = entry.path();
    // rust: let ours = if path.is_dir() {
    // rust: path.join("session.json").is_file()
    // rust: } else {
    // rust: path.extension().is_some_and(|extension| extension == "zip")
}
    // rust: if !ours || keep.is_some_and(|kept| kept == path.as_path()) {
    // rust: return None;
}
    // rust: let modified = entry.metadata().ok()?.modified().ok()?;
    // rust: Some((modified, path))
    // rust: })
    // rust: .collect();
    // rust: items.sort_by_key(|(modified, _)| std::cmp::Reverse(*modified));
    // rust: for (_, path) in items.into_iter().skip(max) {
    // rust: let result = if path.is_dir() {
    // rust: fs::remove_dir_all(&path)
    // rust: } else {
    // rust: fs::remove_file(&path)
}
    // rust: if let Err(e) = result {
    // rust: log::warn!("Horizon: pruning {}: {e}", path.display());
}
}
}

pub fn readme() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!(
    // rust: "Horizon repro recording ({FORMAT})\n\
    // rust: \n\
    // rust: inputs.jsonl   one input event a line: who caused it (user, agent, game),\n\
    // rust: \x20              the tick and the key/mouse/pad event or control command.\n\
    // rust: state.jsonl    the player and world state every second (tick and full state).\n\
    // rust: events.jsonl   what happened: screens, chat, deaths, items, dimensions.\n\
    // rust: session.json   the world, mode, game version and start tick.\n\
    // rust: world/         single player: the world as it was when the recording started.\n\
    // rust: \n\
    // rust: Replay it with: horizon-ctl record-replay <this folder's name>\n\
    // rust: or (from a zip) horizon-ctl record-replay <the zip's name>.\n\
    // rust: Attach the zip from `repro-export` to the bug report; the export scrubs\n\
    // rust: the user name, paths, IPs, UUIDs and the world/server names it knows.\n\
    // rust: Nothing is uploaded automatically and no network traffic is recorded.\n\
    // rust: A replay only runs input commands, never world, network or account ones.\n"
    // rust: )
}

pub fn recording_meta(rec: *Recording, ended: ?*Instant, ticks: u64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "format": FORMAT,
    // rust: "name": rec.name,
    // rust: "created": chrono::Local::now().to_rfc3339(),
    // rust: "game_version": env!("CARGO_PKG_VERSION"),
    // rust: "mode": rec.mode,
    // rust: "world": rec.world,
    // rust: "start_tick": rec.start_tick,
    // rust: "end_tick": (ended.is_some()).then_some(ticks),
    // rust: "seconds": ended.map(|_| rec.started.elapsed().as_secs_f64()),
    // rust: "start": rec.start,
    // rust: "inputs": rec.inputs_written,
    // rust: "events": rec.events_written,
    // rust: "state": rec.states_written,
    // rust: })
}

/// A keyframe without the absolute recording path (it holds the user name).
pub fn keyframe_state(mut state: Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some(recording) = state
    // rust: .pointer_mut("/input/recording")
    // rust: .and_then(Value::as_object_mut)
    // rust: {
    // rust: recording.remove("dir");
}
    // rust: if let Some(replay) = state
    // rust: .pointer_mut("/input/replay")
    // rust: .and_then(Value::as_object_mut)
    // rust: {
    // rust: replay.remove("name");
}
    // rust: state
}

    // rust: impl Game<'_> {
    /// `record-*` and `repro-export`; None for other commands, Some(None) when deferred.
    // rust: pub(super) fn repro_command(
    // rust: &mut self,
    // rust: words: &[&str],
    // rust: _line: &str,
    // rust: reply: &Sender<String>,
    // rust: ) -> Result<Option<Option<Value>>> {
    // rust: match words[0] {
    // rust: "record-start" => self.record_start_command(&words[1..], Some(reply.clone())),
    // rust: "record-stop" => self.record_stop_command(&words[1..], Some(reply.clone())),
    // rust: "record-status" => Ok(Some(Some(self.record_status(self.input_trace.events())))),
    // rust: "record-list" => Ok(Some(Some(self.record_list()))),
    // rust: "record-replay" => self.replay_command(&words[1..], Some(reply.clone())),
    // rust: "repro-export" => self.export_command(&words[1..], Some(reply.clone())),
    // rust: _ => Ok(None),
}
}

    /// Once per loop turn: a waiting replay, the inputs due, and finished exports.
    // rust: pub(super) fn poll_repro(&mut self, event_loop: &dyn EventLoopCtl) {
    // rust: self.poll_pending_replay();
    // rust: self.advance_replay(event_loop);
    // rust: self.poll_exports();
}

    /// Once per tick: the state keyframes. Stops a recording that outgrew its caps.
    // rust: pub(super) fn repro_tick(&mut self) {
    // rust: let Some((start_tick, started, start_inputs, inputs)) =
    // rust: self.repro.recording.as_ref().map(|rec| {
    // rust: (
    // rust: rec.start_tick,
    // rust: rec.started,
    // rust: rec.input_base,
    // rust: self.input_trace.events(),
    // rust: )
    // rust: })
    // rust: else {
    // rust: return;
}
    // rust: let ticking = self.title.is_none() && self.screen == Screen::Playing;
    // rust: let elapsed = self.ticks.saturating_sub(start_tick);
    // rust: if ticking && elapsed.is_multiple_of(KEYFRAME_TICKS) {
    // rust: let state = self.state_value();
    // rust: self.repro.record_state(self.ticks, state);
}
    // rust: if ticking && elapsed.is_multiple_of(ENTITIES_TICKS) {
    // rust: let entities = self.entities_value(48.0, None);
    // rust: self.repro.record_entities(self.ticks, entities);
}
    // rust: let too_many = inputs.saturating_sub(start_inputs) >= MAX_INPUT_EVENTS;
    // rust: let too_long = started.elapsed().as_secs() >= MAX_RECORDING_SECS;
    // rust: if too_many || too_long {
    // rust: log::warn!("Horizon: the recording reached its limit; stopping it");
    // rust: if let Err(e) = self.stop_recording(false, None) {
    // rust: log::warn!("Horizon: stopping the recording: {e}");
}
}
}

    /// A native exit: finish the recording and write its bundle, so a crash or a
    /// quit still leaves a repro.
    // rust: pub(super) fn repro_on_exit(&mut self) {
    // rust: if self.repro.recording.is_none() {
    // rust: return;
}
    // rust: if let Err(e) = self.stop_recording(true, None) {
    // rust: log::warn!("Horizon: the recording on exit: {e}");
}
    // rust: self.drain_exports(Duration::from_secs(10));
}

    /// The world is closing (quit to title, another world): a recording cannot
    /// cross it, and a replay feeding the title screen is nonsense.
    // rust: pub(super) fn repro_world_closed(&mut self) {
    // rust: if self.repro.recording.is_some()
    // rust: && let Err(e) = self.stop_recording(false, None)
    // rust: {
    // rust: log::warn!("Horizon: stopping the recording at the world close: {e}");
}
    // rust: if self.stop_replay() {
    // rust: log::info!("Horizon: replay stopped: the world closed");
}
}

    /// F3+R: start a recording, or stop the running one and write its bundle.
    // rust: pub(super) fn toggle_recording_key(&mut self) {
    // rust: if self.repro.replay.is_some() || self.repro.pending_replay.is_some() {
    // rust: return;
}
    // rust: if self.repro.recording.is_some() {
    // rust: if let Err(e) = self.stop_recording(true, None) {
    // rust: self.repro_say(
    // rust: "horizon.repro.error",
    // rust: &[Text::literal(format!("stopping the recording: {e}"))],
    // rust: );
}
    // rust: } else if let Err(e) = self.start_recording(None, false, true) {
    // rust: self.repro_say("horizon.repro.error", &[Text::literal(format!("{e}"))]);
}
}

    /// F3+E: write a bundle now, from the running or the newest recording.
    // rust: pub(super) fn export_repro_key(&mut self) {
    // rust: if self.repro.recording.is_some() {
    // rust: if let Err(e) = self.stop_recording(true, None) {
    // rust: self.repro_say(
    // rust: "horizon.repro.error",
    // rust: &[Text::literal(format!("exporting the recording: {e}"))],
    // rust: );
}
    // rust: return;
}
    // rust: match newest_recording() {
    // rust: Some(dir) => {
    // rust: if let Err(e) = self.spawn_export(dir, None, false, None, true) {
    // rust: self.repro_say(
    // rust: "horizon.repro.error",
    // rust: &[Text::literal(format!("exporting the recording: {e}"))],
    // rust: );
}
}
    // rust: None => self.repro_say("horizon.repro.no_recording", &[]),
}
}

pub fn repro_say(self: *Self, key: []const u8, args: *[Text]) void {
}
    // rust: self.system_message(Text::translate(key, args));
}

    // ---- start / stop -------------------------------------------------------

    // rust: fn record_start_command(
    // rust: &mut self,
    // rust: args: &[&str],
    // rust: reply: Option<Sender<String>>,
    // rust: ) -> Result<Option<Option<Value>>> {
    // rust: let mut name = None;
    // rust: let mut no_world = false;
    // rust: for arg in args {
    // rust: match *arg {
    // rust: "--no-world" => no_world = true,
    // rust: other if other.starts_with("--") => {
    // rust: return Err(format!("record-start: unknown flag {other}").into());
}
    // rust: other => name = Some(other.to_owned()),
}
}
    // rust: let key = reply.is_none();
    // rust: let value = self.start_recording(name, no_world, key)?;
    // rust: Ok(Some(Some(value)))
}

    /// Start a recording. The world copy is made here, with the world frozen, so
    /// a later stop never races a half-copied world.
    // rust: fn start_recording(
    // rust: &mut self,
    // rust: name: Option<String>,
    // rust: no_world: bool,
    // rust: key: bool,
    // rust: ) -> Result<Value> {
    // rust: if self.repro.recording.is_some() {
    // rust: return Err("a recording is already running; record-stop first".into());
}
    // rust: if self.repro.replay.is_some() || self.repro.pending_replay.is_some() {
    // rust: return Err("a replay is running; record-replay --stop first".into());
}
    // rust: if self.pending_save.is_some() {
    // rust: return Err("a world save is in progress".into());
}
        // Single player is a client of its own integrated server too: that is
        // still a local world with a folder to copy. The deprecated in-frame
        // mode is not one (CLAUDE.md: never use it).
    // rust: let mode = if self.integrated.is_some() {
    // rust: "local"
    // rust: } else if self.remote.is_some() {
    // rust: "remote"
    // rust: } else if self.title.is_some() {
    // rust: return Err("open a world first".into());
    // rust: } else {
    // rust: return Err(
    // rust: "recording needs the normal client: the in-frame mode is not supported".into(),
    // rust: );
}
    // rust: let name = slug(&name.unwrap_or_else(|| "session".into()));
    // rust: let dir = recordings_dir().join(format!("{}-{name}", stamp()));
    // rust: fs::create_dir_all(&dir)?;
        // Single player's world belongs to the integrated server thread: its
        // save folder is the one to copy, not the client's title-screen save.
    // rust: let world_root = if mode == "local" {
    // rust: match self.integrated.as_ref() {
    // rust: Some(server) => server.call(|game| game.world_root.clone()),
    // rust: None if !self.world_root.as_os_str().is_empty() => Some(self.world_root.clone()),
    // rust: None => None,
}
    // rust: } else {
    // rust: None
}
    // rust: let world = world_root
    // rust: .as_ref()
    // rust: .and_then(|root| root.file_name())
    // rust: .map(|n| n.to_string_lossy().into_owned());
    // rust: let include_world = mode == "local" && !no_world;
    // rust: if include_world
    // rust: && !world_root
    // rust: .as_ref()
    // rust: .is_some_and(|root| root.join("level.dat").is_file())
    // rust: {
    // rust: return Err(format!(
    // rust: "the world's save folder {} is not on disk yet",
    // rust: world_root
    // rust: .as_ref()
    // rust: .map_or_else(|| "(unknown)".into(), |root| root.display().to_string())
    // rust: )
    // rust: .into());
}
    // rust: let start_step = self.ticks;
    // rust: let start_state = keyframe_state(self.state_value());

        // Save, then copy with the world frozen: the integrated server keeps
        // ticking and autosaving otherwise, and a region file would tear.
    // rust: if include_world {
    // rust: let root = world_root.as_ref().expect("a local world's save folder");
    // rust: if let Some(server) = self.integrated.as_ref() {
    // rust: server.set_paused(true);
    // rust: let saved = server.call(|game| game.save_game().map_err(|e| e.to_string()));
    // rust: let copied = copy_tree(root, &dir.join("world"));
    // rust: server.set_paused(self.pause);
    // rust: match saved {
    // rust: Some(Ok(())) => {}
    // rust: Some(Err(e)) => {
    // rust: return Err(format!("saving the world for the recording: {e}").into());
}
    // rust: None => {
    // rust: log::warn!("Horizon: the integrated server did not save for the recording")
}
}
    // rust: copied.map_err(|e| format!("copying the world: {e}"))?;
    // rust: } else {
    // rust: self.save_game_with(true)?;
    // rust: copy_tree(root, &dir.join("world"))
    // rust: .map_err(|e| format!("copying the world: {e}"))?;
}
}

    // rust: let (inputs, inputs_joined) = spawn_lines(&dir.join("inputs.jsonl"))?;
    // rust: let (events, events_joined) = spawn_lines(&dir.join("events.jsonl"))?;
    // rust: let (states, states_joined) = spawn_lines(&dir.join("state.jsonl"))?;
    // rust: self.input_trace.start_file(inputs);
    // rust: fs::write(dir.join("README.txt"), readme())?;
    // rust: let rec = Recording {
    // rust: name: name.clone(),
    // rust: dir: dir.clone(),
    // rust: start_tick: start_step,
    // rust: started: Instant::now(),
    // rust: started_at: SystemTime::now(),
    // rust: input_base: self.input_trace.events(),
    // rust: start: start_state,
    // rust: mode,
    // rust: world: world.clone(),
    // rust: inputs: Some(inputs_joined),
    // rust: events: Some(events),
    // rust: events_joined: Some(events_joined),
    // rust: states: Some(states),
    // rust: states_joined: Some(states_joined),
    // rust: inputs_written: 0,
    // rust: events_written: 0,
    // rust: states_written: 0,
}
    // rust: fs::write(
    // rust: dir.join("session.json"),
    // rust: serde_json::to_vec_pretty(&recording_meta(&rec, None, start_step))?,
    // rust: )?;
    // rust: self.repro.recording = Some(rec);
    // rust: prune_dir(&recordings_dir(), Some(&dir), KEPT_RECORDINGS);
    // rust: if key {
    // rust: self.repro_say("horizon.repro.started", &[]);
}
    // rust: Ok(json!({
    // rust: "ok": true,
    // rust: "recording": name,
    // rust: "dir": dir.display().to_string(),
    // rust: "tick": start_step,
    // rust: "world": world,
    // rust: "mode": mode,
    // rust: }))
}

    // rust: fn record_stop_command(
    // rust: &mut self,
    // rust: args: &[&str],
    // rust: reply: Option<Sender<String>>,
    // rust: ) -> Result<Option<Option<Value>>> {
    // rust: let mut export = false;
    // rust: for arg in args {
    // rust: match *arg {
    // rust: "--export" => export = true,
    // rust: other => return Err(format!("record-stop: unknown argument {other}").into()),
}
}
    // rust: match self.stop_recording(export, reply)? {
    // rust: Some(value) => Ok(Some(Some(value))),
    // rust: None => Ok(Some(None)),
}
}

    /// Stop the recording. With `export`, its bundle is written off the game
    /// thread: None means the reply comes later.
    // rust: fn stop_recording(
    // rust: &mut self,
    // rust: export: bool,
    // rust: reply: Option<Sender<String>>,
    // rust: ) -> Result<Option<Value>> {
    // rust: let Some(mut rec) = self.repro.recording.take() else {
    // rust: return Err("no recording is running".into());
}
        // A last keyframe after the last input, so a replay's end is covered.
    // rust: if self.title.is_none() {
    // rust: let state = keyframe_state(self.state_value());
    // rust: let entities = self.entities_value(48.0, None);
    // rust: let tick = self.ticks;
    // rust: if let Some(states) = &rec.states {
    // rust: if states
    // rust: .send(json!({ "tick": tick, "kind": "state", "state": state }).to_string())
    // rust: .is_ok()
    // rust: {
    // rust: rec.states_written += 1;
}
    // rust: if states
    // rust: .send(
    // rust: json!({ "tick": tick, "kind": "entities", "entities": entities })
    // rust: .to_string(),
    // rust: )
    // rust: .is_ok()
    // rust: {
    // rust: rec.states_written += 1;
}
}
}
    // rust: rec.inputs_written = self.input_trace.stop_file();
    // rust: drop(rec.events.take());
    // rust: drop(rec.states.take());
    // rust: if let Some(handle) = rec.inputs.take() {
    // rust: let _ = handle.join();
}
    // rust: if let Some(handle) = rec.events_joined.take() {
    // rust: let _ = handle.join();
}
    // rust: if let Some(handle) = rec.states_joined.take() {
    // rust: let _ = handle.join();
}
    // rust: let meta = recording_meta(&rec, Some(&Instant::now()), self.ticks);
    // rust: let _ = fs::write(
    // rust: rec.dir.join("session.json"),
    // rust: serde_json::to_vec_pretty(&meta).unwrap_or_default(),
    // rust: );
    // rust: let summary = json!({
    // rust: "ok": true,
    // rust: "recording": rec.name,
    // rust: "dir": rec.dir.display().to_string(),
    // rust: "seconds": rec.started.elapsed().as_secs_f64(),
    // rust: "inputs": rec.inputs_written,
    // rust: "events": rec.events_written,
    // rust: "state": rec.states_written,
    // rust: "mode": rec.mode,
    // rust: "world": rec.world,
    // rust: });
    // rust: if export {
    // rust: let key = reply.is_none();
    // rust: self.spawn_export(rec.dir.clone(), None, false, reply, key)?;
    // rust: Ok(None)
    // rust: } else {
    // rust: if reply.is_none() {
    // rust: self.repro_say("horizon.repro.stopped", &[Text::literal(rec.name.clone())]);
}
    // rust: Ok(Some(summary))
}
}

    // ---- status / list -----------------------------------------------------

pub fn record_status(self: *Self, inputs: u64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "recording": self.repro.recording.as_ref().map(|r| json!({
    // rust: "name": r.name,
    // rust: "dir": r.dir.display().to_string(),
    // rust: "seconds": r.started.elapsed().as_secs_f64(),
    // rust: "start_tick": r.start_tick,
    // rust: "ticks": self.ticks.saturating_sub(r.start_tick),
    // rust: "inputs": inputs.saturating_sub(r.input_base),
    // rust: "events": r.events_written,
    // rust: "state": r.states_written,
    // rust: "mode": r.mode,
    // rust: "world": r.world,
    // rust: })),
    // rust: "replay": self.repro.replay.as_ref().map(|r| json!({
    // rust: "name": r.name,
    // rust: "sent": r.sent,
    // rust: "skipped": r.skipped,
    // rust: "total": r.events.len(),
    // rust: })),
    // rust: })
}

pub fn record_list(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut recordings = Vec::new();
    // rust: if let Ok(entries) = fs::read_dir(recordings_dir()) {
    // rust: for entry in entries.flatten() {
    // rust: if !entry.file_type().is_ok_and(|t| t.is_dir()) {
    // rust: continue;
}
    // rust: let dir = entry.path();
    // rust: let Ok(bytes) = fs::read(dir.join("session.json")) else {
    // rust: continue;
}
    // rust: let Ok(meta) = serde_json::from_slice::<Value>(&bytes) else {
    // rust: continue;
}
    // rust: recordings.push(json!({
    // rust: "name": meta.get("name").cloned().unwrap_or(Value::Null),
    // rust: "dir": dir.display().to_string(),
    // rust: "mode": meta.get("mode").cloned().unwrap_or(Value::Null),
    // rust: "world": meta.get("world").cloned().unwrap_or(Value::Null),
    // rust: "created": meta.get("created").cloned().unwrap_or(Value::Null),
    // rust: "inputs": meta.get("inputs").cloned().unwrap_or(Value::Null),
    // rust: "has_world": dir.join("world").is_dir(),
    // rust: }));
}
}
    // rust: recordings.sort_by(|a, b| b["created"].as_str().cmp(&a["created"].as_str()));
    // rust: let mut bundles = Vec::new();
    // rust: if let Ok(entries) = fs::read_dir(bundles_dir()) {
    // rust: for entry in entries.flatten() {
    // rust: let path = entry.path();
    // rust: if path.extension().is_some_and(|e| e == "zip") {
    // rust: bundles.push(json!({
    // rust: "name": path.file_stem().map(|n| n.to_string_lossy().into_owned()),
    // rust: "path": path.display().to_string(),
    // rust: }));
}
}
}
    // rust: json!({ "recordings": recordings, "bundles": bundles })
}

    // ---- export -------------------------------------------------------------

    // rust: fn export_command(
    // rust: &mut self,
    // rust: args: &[&str],
    // rust: reply: Option<Sender<String>>,
    // rust: ) -> Result<Option<Option<Value>>> {
    // rust: let mut name = None;
    // rust: let mut path = None;
    // rust: let mut no_world = false;
    // rust: for arg in args {
    // rust: match *arg {
    // rust: "--no-world" => no_world = true,
    // rust: other if other.starts_with("--") => {
    // rust: return Err(format!("repro-export: unknown flag {other}").into());
}
    // rust: other if path.is_none() && (other.contains('/') || other.ends_with(".zip")) => {
    // rust: path = Some(PathBuf::from(other));
}
    // rust: other if name.is_none() => name = Some(other.to_owned()),
    // rust: other => return Err(format!("repro-export: unexpected {other}").into()),
}
}
    // rust: if self.repro.recording.is_some() {
            // Exporting the run as it stands: stop it first so the files are closed.
    // rust: match self.stop_recording(false, None)? {
    // rust: Some(_) => {}
    // rust: None => return Err("the recording could not be stopped".into()),
}
}
    // rust: let dir = match name {
    // rust: Some(name) => resolve_recording(&name)?,
    // rust: None => newest_recording().ok_or("no recording to export yet")?,
}
    // rust: let key = reply.is_none();
    // rust: self.spawn_export(dir, path, no_world, reply, key)?;
    // rust: Ok(Some(None))
}

    // rust: fn spawn_export(
    // rust: &mut self,
    // rust: dir: PathBuf,
    // rust: dest: Option<PathBuf>,
    // rust: no_world: bool,
    // rust: reply: Option<Sender<String>>,
    // rust: key: bool,
    // rust: ) -> Result<()> {
    // rust: let status = self.control_status();
    // rust: let home = home();
    // rust: let dest = dest.unwrap_or_else(|| {
    // rust: let name = dir
    // rust: .file_name()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_else(|| "repro".into());
    // rust: bundles_dir().join(format!("{name}.zip"))
    // rust: });
    // rust: let started_at = self.repro.recording.as_ref().map_or_else(
    // rust: || {
    // rust: recording_started_at(&dir)
    // rust: .unwrap_or_else(|| SystemTime::now() - Duration::from_secs(MAX_RECORDING_SECS))
    // rust: },
    // rust: |rec| rec.started_at,
    // rust: );
    // rust: if let Some(parent) = dest.parent() {
    // rust: fs::create_dir_all(parent)?;
}
    // rust: let (tx, rx) = mpsc::channel();
    // rust: let dir_for_thread = dir.clone();
    // rust: thread::spawn(move || {
    // rust: let value =
    // rust: match write_bundle(&dir_for_thread, &dest, &status, &home, no_world, started_at) {
    // rust: Ok(bytes) => json!({
    // rust: "ok": true,
    // rust: "path": dest.display().to_string(),
    // rust: "bytes": bytes,
    // rust: }),
    // rust: Err(e) => json!({ "error": format!("repro export failed: {e}") }),
}
    // rust: let _ = tx.send(value);
    // rust: });
    // rust: self.repro.exports.push(Export { rx, reply, key });
    // rust: Ok(())
}

pub fn poll_exports(self: *Self) void {
}
    // rust: let mut done = Vec::new();
    // rust: for (i, export) in self.repro.exports.iter().enumerate() {
    // rust: match export.rx.try_recv() {
    // rust: Ok(value) => done.push((i, value)),
    // rust: Err(TryRecvError::Empty) => {}
    // rust: Err(TryRecvError::Disconnected) => done.push((
    // rust: i,
    // rust: json!({ "error": "the export thread stopped without a result" }),
    // rust: )),
}
}
    // rust: for (i, value) in done.into_iter().rev() {
    // rust: let export = self.repro.exports.remove(i);
    // rust: if let Some(path) = value.get("path").and_then(Value::as_str) {
    // rust: prune_dir(&bundles_dir(), Some(Path::new(path)), KEPT_RECORDINGS);
}
    // rust: if let Some(reply) = export.reply {
    // rust: let _ = reply.send(value.to_string());
    // rust: } else if export.key || value.get("error").is_some() {
    // rust: if let Some(error) = value.get("error").and_then(Value::as_str) {
    // rust: self.repro_say("horizon.repro.error", &[Text::literal(error.to_owned())]);
    // rust: } else {
    // rust: let path = value
    // rust: .get("path")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or_default();
    // rust: self.repro_say("horizon.repro.bundle", &[Text::literal(path.to_owned())]);
}
}
}
}

pub fn drain_exports(self: *Self, timeout: Duration) void {
}
    // rust: let deadline = Instant::now() + timeout;
    // rust: while !self.repro.exports.is_empty() && Instant::now() < deadline {
    // rust: self.poll_exports();
    // rust: if !self.repro.exports.is_empty() {
    // rust: std::thread::sleep(Duration::from_millis(5));
}
}
    // rust: self.poll_exports();
}

    // ---- replay -------------------------------------------------------------

    // rust: fn replay_command(
    // rust: &mut self,
    // rust: args: &[&str],
    // rust: reply: Option<Sender<String>>,
    // rust: ) -> Result<Option<Option<Value>>> {
    // rust: let mut name = None;
    // rust: let mut stop = false;
    // rust: let mut in_place = false;
    // rust: let mut keep_world = false;
    // rust: let mut timeout = REPLAY_TIMEOUT_SECS;
    // rust: let mut i = 0;
    // rust: while i < args.len() {
    // rust: match args[i] {
    // rust: "--stop" => stop = true,
    // rust: "--in-place" => in_place = true,
    // rust: "--keep-world" => keep_world = true,
    // rust: "--timeout" => {
    // rust: timeout = args
    // rust: .get(i + 1)
    // rust: .and_then(|t| t.parse().ok())
    // rust: .ok_or("--timeout takes whole seconds")?;
    // rust: i += 1;
}
    // rust: other if other.starts_with("--") => {
    // rust: return Err(format!("record-replay: unknown flag {other}").into());
}
    // rust: other => name = Some(other.to_owned()),
}
    // rust: i += 1;
}
    // rust: if stop {
    // rust: let stopped = self.stop_replay();
    // rust: if stopped {
    // rust: self.events
    // rust: .note(self.ticks, json!({ "event": "replay", "state": "stopped" }));
}
    // rust: return Ok(Some(Some(json!({ "ok": true, "stopped": stopped }))));
}
    // rust: let name = name.ok_or("record-replay NAME: a recording from record-list")?;
    // rust: if self.repro.recording.is_some() {
    // rust: return Err("a recording is running; record-stop first".into());
}
    // rust: if self.repro.replay.is_some() || self.repro.pending_replay.is_some() {
    // rust: return Err("a replay is already running; record-replay --stop first".into());
}
    // rust: let dir = resolve_recording(&name)?;
    // rust: let bytes = fs::read(dir.join("session.json"))?;
    // rust: let meta: SessionMeta = serde_json::from_slice(&bytes)?;
    // rust: if meta.mode == "remote" && !in_place {
    // rust: return Err(
    // rust: "this recording is a server session: replay it with --in-place in the same world"
    // rust: .into(),
    // rust: );
}
    // rust: let events = read_events(&dir.join("inputs.jsonl"))?;
    // rust: let base_tick = meta.start_tick;
        // A recording that never stopped cleanly has no end_tick: use its last input.
    // rust: let end_tick = meta
    // rust: .end_tick
    // rust: .unwrap_or_else(|| events.last().map_or(base_tick, |event| event.tick))
    // rust: .max(base_tick);
    // rust: let deadline = Instant::now() + Duration::from_secs(timeout);
    // rust: if in_place {
    // rust: if self.title.is_some() {
    // rust: return Err("--in-place needs an open world to feed the input into".into());
}
    // rust: let pending = PendingReplay {
    // rust: reply,
    // rust: name,
    // rust: folder: String::new(),
    // rust: in_place: true,
    // rust: opened: true,
    // rust: keep_world: true,
    // rust: deadline,
    // rust: base_tick,
    // rust: end_tick,
    // rust: start: meta.start,
    // rust: events,
}
    // rust: self.begin_replay(pending);
    // rust: return Ok(Some(None));
}
    // rust: let world = dir.join("world");
    // rust: if !world.is_dir() {
    // rust: return Err(
    // rust: "this recording has no world copy (it was made with --no-world or on a server)"
    // rust: .into(),
    // rust: );
}
    // rust: let folder = format!("{}-replay-{}", slug(&name), stamp());
    // rust: copy_tree(&world, &saves_dir().join(&folder))?;
    // rust: if self.title.is_none() {
    // rust: self.close_world()?;
}
    // rust: self.repro.pending_replay = Some(PendingReplay {
    // rust: reply,
    // rust: name,
    // rust: folder,
    // rust: in_place: false,
    // rust: opened: false,
    // rust: keep_world,
    // rust: deadline,
    // rust: base_tick,
    // rust: end_tick,
    // rust: start: meta.start,
    // rust: events,
    // rust: });
    // rust: Ok(Some(None))
}

pub fn poll_pending_replay(self: *Self) void {
}
    // rust: let Some((in_place, opened, folder, deadline)) = self
    // rust: .repro
    // rust: .pending_replay
    // rust: .as_ref()
    // rust: .map(|p| (p.in_place, p.opened, p.folder.clone(), p.deadline))
    // rust: else {
    // rust: return;
}
    // rust: if Instant::now() >= deadline {
    // rust: let pending = self.repro.pending_replay.take().unwrap();
    // rust: self.discard_replay_world(&pending);
    // rust: self.reply_error(pending.reply, "the replay's world did not load in time");
    // rust: return;
}
    // rust: if !in_place {
    // rust: if !opened {
    // rust: if self.pending_save.is_some() || self.title.is_none() {
    // rust: return;
}
    // rust: if let Err(e) = self.open_world(&folder, None, None, false, None) {
    // rust: let pending = self.repro.pending_replay.take().unwrap();
    // rust: self.discard_replay_world(&pending);
    // rust: self.reply_error(
    // rust: pending.reply,
    // rust: &format!("could not open the recording's world: {e}"),
    // rust: );
    // rust: return;
}
    // rust: if let Some(pending) = self.repro.pending_replay.as_mut() {
    // rust: pending.opened = true;
}
}
    // rust: if !self.loaded() || self.pending_entry.is_some() {
    // rust: return;
}
}
    // rust: let pending = self.repro.pending_replay.take().unwrap();
    // rust: self.begin_replay(pending);
}

pub fn begin_replay(self: *Self, pending: PendingReplay) void {
}
    // rust: let total = pending.events.len();
    // rust: let name = pending.name.clone();
        // The world copy's player data can be older than the recording: put the
        // player back where it was, facing the same way, and give it a few ticks
        // to land before the input starts.
    // rust: if let Some(start) = &pending.start {
    // rust: if let Some(position) = start.pointer("/player/position").and_then(Value::as_array)
    // rust: && let (Some(x), Some(y), Some(z)) = (
    // rust: position.first().and_then(Value::as_f64),
    // rust: position.get(1).and_then(Value::as_f64),
    // rust: position.get(2).and_then(Value::as_f64),
    // rust: )
    // rust: && let Some(player) = self.player.as_mut()
    // rust: {
    // rust: let to = Vec3::new(x, y, z);
    // rust: player.position = to;
    // rust: player.fall_distance = 0.0;
    // rust: self.previous_position = to;
}
            // A player still walking or falling when the recording started kept
            // its momentum into the bug; keep it here too.
    // rust: if let Some(velocity) = start.pointer("/player/velocity").and_then(Value::as_array)
    // rust: && let (Some(x), Some(y), Some(z)) = (
    // rust: velocity.first().and_then(Value::as_f64),
    // rust: velocity.get(1).and_then(Value::as_f64),
    // rust: velocity.get(2).and_then(Value::as_f64),
    // rust: )
    // rust: && let Some(player) = self.player.as_mut()
    // rust: {
    // rust: player.velocity = Vec3::new(x, y, z);
}
    // rust: if let Some(yaw) = start.pointer("/player/yaw").and_then(Value::as_f64) {
    // rust: self.yaw = yaw as f32;
}
    // rust: if let Some(pitch) = start.pointer("/player/pitch").and_then(Value::as_f64) {
    // rust: self.pitch = pitch as f32;
}
}
    // rust: let start_tick = self.ticks.saturating_add(3);
    // rust: let end_at = start_tick.saturating_add(pending.end_tick.saturating_sub(pending.base_tick));
    // rust: self.input_trace.set_suppress(true);
    // rust: self.repro.replay = Some(Replay {
    // rust: name: name.clone(),
    // rust: base_tick: pending.base_tick,
    // rust: start_tick,
    // rust: end_at,
    // rust: deadline: pending.deadline,
    // rust: events: pending.events,
    // rust: index: 0,
    // rust: sent: 0,
    // rust: skipped: 0,
    // rust: last_progress: 0,
    // rust: world_folder: (!pending.in_place).then_some(pending.folder),
    // rust: keep_world: pending.keep_world,
    // rust: });
    // rust: self.events.note(
    // rust: self.ticks,
    // rust: json!({ "event": "replay", "state": "started", "name": name }),
    // rust: );
    // rust: let value = json!({
    // rust: "ok": true,
    // rust: "replay": name,
    // rust: "tick": self.ticks,
    // rust: "events": total,
    // rust: });
    // rust: match pending.reply {
    // rust: Some(reply) => {
    // rust: let _ = reply.send(value.to_string());
}
    // rust: None => {
    // rust: self.repro_say("horizon.repro.replay_started", &[Text::literal(name)]);
}
}
}

pub fn advance_replay(self: *Self, event_loop: *dyn EventLoopCtl) void {
}
    // rust: let mut due = Vec::new();
    // rust: let mut timed_out = false;
    // rust: {
    // rust: let Some(replay) = self.repro.replay.as_mut() else {
    // rust: return;
}
    // rust: if Instant::now() >= replay.deadline {
    // rust: timed_out = true;
    // rust: } else {
    // rust: while replay.index < replay.events.len() {
    // rust: let event = &replay.events[replay.index];
    // rust: let at = replay
    // rust: .start_tick
    // rust: .saturating_add(event.tick.saturating_sub(replay.base_tick));
    // rust: if at > self.ticks {
    // rust: break;
}
    // rust: due.push(event.clone());
    // rust: replay.index += 1;
}
}
}
    // rust: for event in due {
    // rust: let outcome = self.replay_event(event, event_loop);
    // rust: if let Some(replay) = self.repro.replay.as_mut() {
    // rust: if outcome {
    // rust: replay.sent += 1;
    // rust: } else {
    // rust: replay.skipped += 1;
}
}
}
    // rust: let mut finished = timed_out;
    // rust: if let Some(replay) = &self.repro.replay {
            // The recording's span, not just its last input: its trailing wait
            // and deceleration are part of what the bug needed.
    // rust: if replay.index >= replay.events.len() && self.ticks >= replay.end_at {
    // rust: finished = true;
}
    // rust: if !finished && replay.sent.saturating_sub(replay.last_progress) >= 400 {
    // rust: let value = json!({
    // rust: "event": "replay",
    // rust: "state": "progress",
    // rust: "name": replay.name,
    // rust: "sent": replay.sent,
    // rust: "total": replay.events.len(),
    // rust: });
    // rust: self.repro.note_event(self.ticks, &value);
    // rust: self.events.note(self.ticks, value);
    // rust: if let Some(replay) = self.repro.replay.as_mut() {
    // rust: replay.last_progress = replay.sent;
}
}
}
    // rust: if finished {
    // rust: self.finish_replay(timed_out);
}
}

    /// One recorded event, fed back. False when it is not replayed.
pub fn replay_event(self: *Self, event: TraceEvent, event_loop: *dyn EventLoopCtl) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = match &self.window {
    // rust: Some(window) => window.id(),
    // rust: None => WindowId::dummy(),
}
    // rust: let device_id = DeviceId::dummy();
    // rust: match event.kind {
    // rust: TraceKind::Command { line } => {
    // rust: let name = line.split_whitespace().next().unwrap_or("");
                // A recording travels between machines: only input and movement
                // lines may run on someone else's game.
    // rust: if !REPLAY_COMMANDS.contains(&name) {
    // rust: log::debug!("Horizon: replay skips `{line}`");
    // rust: return false;
}
    // rust: self.replay_line(&line, event_loop);
    // rust: true
}
    // rust: TraceKind::Key { key, action } => {
                // Through the control line, so its release guard runs too.
    // rust: self.replay_line(&format!("key {key} {action}"), event_loop);
    // rust: true
}
    // rust: TraceKind::Mouse { button, action } => {
    // rust: let Some(button) = keybinds::mouse_button(&button) else {
    // rust: return false;
}
    // rust: let state = if action == "down" {
    // rust: ElementState::Pressed
    // rust: } else {
    // rust: ElementState::Released
}
    // rust: self.handle_window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::MouseInput {
    // rust: device_id,
    // rust: state,
    // rust: button,
    // rust: },
    // rust: InputOrigin::Game,
    // rust: );
    // rust: true
}
    // rust: TraceKind::Wheel { x, y, lines } => {
    // rust: let delta = if lines {
    // rust: MouseScrollDelta::LineDelta(x as f32, y as f32)
    // rust: } else {
    // rust: MouseScrollDelta::PixelDelta(PhysicalPosition::new(x, y))
}
    // rust: self.handle_window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::MouseWheel {
    // rust: device_id,
    // rust: delta,
    // rust: phase: TouchPhase::Moved,
    // rust: },
    // rust: InputOrigin::Game,
    // rust: );
    // rust: true
}
    // rust: TraceKind::Cursor { x, y } => {
    // rust: self.handle_window_event(
    // rust: event_loop,
    // rust: id,
    // rust: WindowEvent::CursorMoved {
    // rust: device_id,
    // rust: position: PhysicalPosition::new(x, y),
    // rust: },
    // rust: InputOrigin::Game,
    // rust: );
    // rust: true
}
    // rust: TraceKind::Motion { x, y } => {
    // rust: self.mouse.on_move(0.0, 0.0, x, y, true, true);
    // rust: self.last_input = Instant::now();
    // rust: true
}
    // rust: TraceKind::Pad { button, action } => {
    // rust: let Some(button) = Button::ALL.into_iter().find(|b| b.name() == button) else {
    // rust: return false;
}
    // rust: self.pad.inject_button(button, action == "down");
    // rust: true
}
}
}

    /// Let go of everything a replay (or a person) held.
pub fn release_replay_inputs(self: *Self) void {
}
    // rust: self.keys.clear();
    // rust: self.physical_keys.clear();
    // rust: self.physical_buttons.clear();
    // rust: self.left = false;
    // rust: self.right = false;
    // rust: self.modifiers = winit::keyboard::ModifiersState::empty();
    // rust: self.debug_keys.modifier_down = false;
    // rust: self.pad.clear_injected();
}

pub fn finish_replay(self: *Self, timed_out: bool) void {
}
    // rust: let Some(replay) = self.repro.replay.take() else {
    // rust: return;
}
    // rust: self.input_trace.set_suppress(false);
    // rust: self.release_replay_inputs();
    // rust: if !replay.keep_world
    // rust: && let Some(folder) = &replay.world_folder
    // rust: {
    // rust: let _ = fs::remove_dir_all(saves_dir().join(folder));
}
    // rust: let value = json!({
    // rust: "event": "replay",
    // rust: "state": if timed_out { "timeout" } else { "done" },
    // rust: "name": replay.name,
    // rust: "sent": replay.sent,
    // rust: "skipped": replay.skipped,
    // rust: "total": replay.events.len(),
    // rust: });
    // rust: self.events.note(self.ticks, value.clone());
    // rust: log::info!(
    // rust: "Horizon: replay {}: {} of {} events{}",
    // rust: replay.name,
    // rust: replay.sent,
    // rust: replay.events.len(),
    // rust: if timed_out { " (timed out)" } else { "" }
    // rust: );
}

    /// Stop a running or waiting replay; whether there was one.
pub fn stop_replay(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut stopped = false;
    // rust: if let Some(pending) = self.repro.pending_replay.take() {
    // rust: self.discard_replay_world(&pending);
    // rust: self.reply_error(pending.reply, "the replay was stopped before it started");
    // rust: self.input_trace.set_suppress(false);
    // rust: self.release_replay_inputs();
    // rust: stopped = true;
}
    // rust: if self.repro.replay.is_some() {
    // rust: self.finish_replay(false);
    // rust: stopped = true;
}
    // rust: stopped
}

pub fn discard_replay_world(self: *Self, pending: *PendingReplay) void {
}
    // rust: if !pending.in_place && !pending.keep_world {
    // rust: let _ = fs::remove_dir_all(saves_dir().join(&pending.folder));
}
}

pub fn reply_error(self: *Self, reply: ?Sender<[]const u8>, error: []const u8) void {
}
    // rust: match reply {
    // rust: Some(reply) => {
    // rust: let _ = reply.send(json!({ "error": error }).to_string());
}
    // rust: None => self.repro_say("horizon.repro.error", &[Text::literal(error.to_owned())]),
}
}
}

    // rust: impl Repro {
    /// An agent event while recording joins `events.jsonl`.
    // rust: pub(super) fn note_event(&mut self, tick: u64, event: &Value) {
    // rust: let Some(rec) = self.recording.as_mut() else {
    // rust: return;
}
    // rust: let mut event = event.clone();
    // rust: event["tick"] = tick.into();
    // rust: if let Some(events) = &rec.events
    // rust: && events.send(event.to_string()).is_ok()
    // rust: {
    // rust: rec.events_written += 1;
}
}

    /// A `state.jsonl` keyframe: the state at this tick.
pub fn record_state(self: *Self, tick: u64, state: Value) void {
}
    // rust: self.record_keyframe(
    // rust: tick,
    // rust: json!({ "kind": "state", "state": keyframe_state(state) }),
    // rust: );
}

    /// An `state.jsonl` keyframe of the nearby entities, rarer than the state.
pub fn record_entities(self: *Self, tick: u64, entities: Value) void {
}
    // rust: self.record_keyframe(tick, json!({ "kind": "entities", "entities": entities }));
}

pub fn record_keyframe(self: *Self, tick: u64, mut value: Value) void {
}
    // rust: let Some(rec) = self.recording.as_mut() else {
    // rust: return;
}
    // rust: value["tick"] = tick.into();
    // rust: if let Some(states) = &rec.states
    // rust: && states.send(value.to_string()).is_ok()
    // rust: {
    // rust: rec.states_written += 1;
}
}

    /// Whether a recording is running (the AI Agent page's button label).
    // rust: pub(super) fn recording_active(&self) -> bool {
    // rust: self.recording.is_some()
}

    /// The AI Agent page's line while a recording or replay runs.
    // rust: pub(super) fn agent_line(&self, inputs: u64) -> Option<String> {
    // rust: if let Some(rec) = &self.recording {
    // rust: Some(format!(
    // rust: "Recording {}: {} s, {} input events.",
    // rust: rec.name,
    // rust: rec.started.elapsed().as_secs(),
    // rust: inputs.saturating_sub(rec.input_base)
    // rust: ))
    // rust: } else {
    // rust: let replay = self.replay.as_ref()?;
    // rust: Some(format!(
    // rust: "Replaying {}: {} of {} events.",
    // rust: replay.name,
    // rust: replay.sent,
    // rust: replay.events.len()
    // rust: ))
}
}

    /// The recording and replay parts of `state`'s and `status`'s `input`.
    // rust: pub(super) fn fill_summary(&self, out: &mut Value, inputs: u64) {
    // rust: out["recording"] = self.summary(inputs)["recording"].clone();
    // rust: out["replay"] = self.summary(inputs)["replay"].clone();
}

pub fn summary(self: *Self, inputs: u64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "recording": self.recording.as_ref().map(|r| json!({
    // rust: "name": r.name,
    // rust: "dir": r.dir.display().to_string(),
    // rust: "seconds": r.started.elapsed().as_secs_f64(),
    // rust: "inputs": inputs.saturating_sub(r.input_base),
    // rust: "events": r.events_written,
    // rust: "state": r.states_written,
    // rust: "mode": r.mode,
    // rust: "world": r.world,
    // rust: })),
    // rust: "replay": self.replay.as_ref().map(|r| json!({
    // rust: "name": r.name,
    // rust: "sent": r.sent,
    // rust: "skipped": r.skipped,
    // rust: "total": r.events.len(),
    // rust: })),
    // rust: })
}
}

/// When a recording on disk started, from its `session.json`.
pub fn recording_started_at(dir: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = fs::read_to_string(dir.join("session.json")).ok()?;
    // rust: let meta: Value = serde_json::from_str(&text).ok()?;
    // rust: let created = meta.get("created")?.as_str()?;
    // rust: let time = chrono::DateTime::parse_from_rfc3339(created).ok()?;
    // rust: Some(SystemTime::from(time))
}

pub fn newest_recording() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut newest: Option<(SystemTime, PathBuf)> = None;
    // rust: let entries = fs::read_dir(recordings_dir()).ok()?;
    // rust: for entry in entries.flatten() {
    // rust: let path = entry.path();
    // rust: if !path.is_dir() || !path.join("session.json").is_file() {
    // rust: continue;
}
    // rust: let modified = match entry.metadata().and_then(|m| m.modified()) {
    // rust: Ok(modified) => modified,
    // rust: Err(_) => continue,
}
    // rust: if newest.as_ref().is_none_or(|(t, _)| modified > *t) {
    // rust: newest = Some((modified, path));
}
}
    // rust: newest.map(|(_, path)| path)
}

/// A recording by name: an exact folder, the newest folder ending in it, or a
/// bundle (which is unpacked into `recordings/` first).
pub fn resolve_recording(name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let recordings = recordings_dir();
    // rust: let exact = recordings.join(name);
    // rust: if exact.join("session.json").is_file() {
    // rust: return Ok(exact);
}
    // rust: let mut newest: Option<(SystemTime, PathBuf)> = None;
    // rust: if let Ok(entries) = fs::read_dir(&recordings) {
    // rust: for entry in entries.flatten() {
    // rust: let path = entry.path();
    // rust: let file_name = entry.file_name().to_string_lossy().into_owned();
    // rust: if !path.is_dir() || !file_name.ends_with(&format!("-{name}")) {
    // rust: continue;
}
    // rust: if !path.join("session.json").is_file() {
    // rust: continue;
}
    // rust: if let Ok(modified) = entry.metadata().and_then(|m| m.modified())
    // rust: && newest.as_ref().is_none_or(|(t, _)| modified > *t)
    // rust: {
    // rust: newest = Some((modified, path));
}
}
}
    // rust: if let Some((_, path)) = newest {
    // rust: return Ok(path);
}
    // An exported bundle: unpack it and take the folder with session.json.
    // rust: if let Ok(entries) = fs::read_dir(bundles_dir()) {
    // rust: let mut bundle = None;
    // rust: for entry in entries.flatten() {
    // rust: let path = entry.path();
    // rust: let file_name = path.file_name().map(|n| n.to_string_lossy().into_owned());
    // rust: if file_name
    // rust: .as_deref()
    // rust: .is_some_and(|n| n.contains(name) && n.ends_with(".zip"))
    // rust: {
    // rust: bundle = Some(path);
}
}
    // rust: if let Some(bundle) = bundle {
    // rust: let dest = recordings.join(format!("replay-{}", stamp()));
    // rust: extract_zip(&bundle, &dest)?;
    // rust: if dest.join("session.json").is_file() {
    // rust: return Ok(dest);
}
    // rust: if let Ok(entries) = fs::read_dir(&dest) {
    // rust: for entry in entries.flatten() {
    // rust: let path = entry.path();
    // rust: if path.is_dir() && path.join("session.json").is_file() {
    // rust: return Ok(path);
}
}
}
    // rust: return Err(format!("the bundle {} has no session.json", bundle.display()).into());
}
}
    // rust: Err(format!("no recording or bundle named {name}; record-list lists them").into())
}

pub fn read_events(path: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = fs::read_to_string(path)?;
    // rust: let mut events = Vec::new();
    // rust: let mut skipped = 0;
    // rust: for (number, line) in text.lines().enumerate() {
    // rust: let line = line.trim();
    // rust: if line.is_empty() {
    // rust: continue;
}
    // rust: match serde_json::from_str::<TraceEvent>(line) {
    // rust: Ok(event) => events.push(event),
            // A killed process leaves a half-written last line; one bad line
            // must not lose a whole crash recording.
    // rust: Err(e) => {
    // rust: skipped += 1;
    // rust: log::warn!(
    // rust: "Horizon: replay: {} line {}: {e}",
    // rust: path.display(),
    // rust: number + 1
    // rust: );
}
}
}
    // rust: if skipped > 0 {
    // rust: log::warn!("Horizon: replay: skipped {skipped} unreadable input line(s)");
}
    // rust: Ok(events)
}

pub fn extract_zip(path: *Path, dest: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = fs::File::open(path)?;
    // rust: let mut archive = zip::ZipArchive::new(file)?;
    // rust: fs::create_dir_all(dest)?;
    // A bundle travels between machines: cap what it may unpack.
pub const MAX_BYTES: u64 = 2 * 1024 * 1024 * 1024;
pub const MAX_ENTRIES: usize = 200_000;
    // rust: let mut total = 0u64;
    // rust: for i in 0..archive.len() {
    // rust: if i >= MAX_ENTRIES {
    // rust: return Err(format!("the bundle has more than {MAX_ENTRIES} entries").into());
}
    // rust: let mut entry = archive.by_index(i)?;
    // rust: let Some(name) = entry.enclosed_name() else {
    // rust: continue;
}
    // rust: let out = dest.join(name);
    // rust: if entry.is_dir() {
    // rust: fs::create_dir_all(&out)?;
    // rust: } else {
    // rust: if let Some(parent) = out.parent() {
    // rust: fs::create_dir_all(parent)?;
}
    // rust: let mut file = fs::File::create(&out)?;
    // rust: total = total.saturating_add(io::copy(&mut entry, &mut file)?);
    // rust: if total > MAX_BYTES {
    // rust: return Err(format!(
    // rust: "the bundle unpacks to more than {} GiB",
    // rust: MAX_BYTES / (1024 * 1024 * 1024)
    // rust: )
    // rust: .into());
}
}
}
    // rust: Ok(())
}

/// The status the bundle carries: no server address, players, name tags or
/// clipboard (an invite code lives there).
pub fn bundle_status(status: *Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut status = status.clone();
    // rust: if let Some(obj) = status.as_object_mut() {
    // rust: obj.remove("server");
    // rust: obj.remove("name_tags");
    // rust: obj.remove("sidebar");
    // rust: obj.remove("input");
    // rust: if let Some(debug) = obj.get_mut("debug").and_then(Value::as_object_mut) {
    // rust: debug.remove("clipboard");
    // rust: debug.remove("clipboard_text");
}
}
    // rust: status
}

/// The places and names the bundle's text must not say: the user folder, the
/// world and the server it was played on, and the other players' names.
pub fn bundle_scrubber(dir: *Path, status: *Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut terms = vec![dir.display().to_string()];
    // rust: for path in ["/server/address", "/server/name", "/input/recording/world"] {
    // rust: if let Some(value) = status.pointer(path).and_then(Value::as_str) {
    // rust: terms.push(value.to_owned());
}
}
    // rust: if let Some(players) = status.pointer("/server/players").and_then(Value::as_array) {
    // rust: for player in players {
    // rust: if let Some(name) = player.get("name").and_then(Value::as_str) {
    // rust: terms.push(name.to_owned());
}
}
}
    // A stopped recording's status no longer carries these.
    // rust: if let Ok(text) = fs::read_to_string(dir.join("session.json"))
    // rust: && let Ok(meta) = serde_json::from_str::<Value>(&text)
    // rust: {
    // rust: for path in [
    // rust: "/world",
    // rust: "/start/world",
    // rust: "/start/server/name",
    // rust: "/start/server/address",
    // rust: ] {
    // rust: if let Some(value) = meta.pointer(path).and_then(Value::as_str) {
    // rust: terms.push(value.to_owned());
}
}
}
    // rust: let mut scrubber = Scrubber::new();
    // rust: for term in terms {
    // rust: scrubber = scrubber.term(term);
}
    // rust: scrubber
}

pub fn unique_dest(path: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !path.exists() {
    // rust: return path.to_path_buf();
}
    // rust: let stem = path
    // rust: .file_stem()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_else(|| "repro".into());
    // rust: let extension = path
    // rust: .extension()
    // rust: .map(|e| e.to_string_lossy().into_owned())
    // rust: .unwrap_or_else(|| "zip".into());
    // rust: for index in 1.. {
    // rust: let candidate = path.with_file_name(format!("{stem} ({index}).{extension}"));
    // rust: if !candidate.exists() {
    // rust: return candidate;
}
}
    // rust: path.to_path_buf()
}

    // rust: fn write_bundle(
    // rust: dir: &Path,
    // rust: dest: &Path,
    // rust: status: &Value,
    // rust: home: &Path,
    // rust: no_world: bool,
    // rust: started_at: SystemTime,
    // rust: ) -> Result<u64> {
    // rust: let prefix = dir
    // rust: .file_name()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_else(|| "recording".into());
    // rust: let dest = unique_dest(dest);
    // rust: if let Some(parent) = dest.parent() {
    // rust: fs::create_dir_all(parent)?;
}
    // rust: let tmp = dest.with_file_name(format!(
    // rust: "{}.tmp",
    // rust: dest.file_name()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_else(|| "repro.zip".into())
    // rust: ));
    // rust: let scrubber = bundle_scrubber(dir, status);
    // rust: let mut file = fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .create_new(true)
    // rust: .open(&tmp)?;
    // rust: let result = (|| -> Result<u64> {
    // rust: let mut zip = zip::ZipWriter::new(&mut file);
        // The recording's own files: text, so they are scrubbed as they go in.
    // rust: for name in [
    // rust: "session.json",
    // rust: "inputs.jsonl",
    // rust: "state.jsonl",
    // rust: "events.jsonl",
    // rust: ] {
    // rust: let path = dir.join(name);
    // rust: let Ok(text) = fs::read_to_string(&path) else {
    // rust: continue;
}
    // rust: add_bytes(
    // rust: &mut zip,
    // rust: &format!("{prefix}/{name}"),
    // rust: scrubber.scrub(&text).as_bytes(),
    // rust: )?;
}
    // rust: add_bytes(
    // rust: &mut zip,
    // rust: &format!("{prefix}/README.txt"),
    // rust: readme().as_bytes(),
    // rust: )?;
        // The world is binary and stays as it is.
    // rust: let world = dir.join("world");
    // rust: if !no_world && world.is_dir() {
    // rust: world_management::write_tree_skipping(
    // rust: &mut zip,
    // rust: &world,
    // rust: &world,
    // rust: &format!("{prefix}/world"),
    // rust: &[],
    // rust: )?;
}
    // rust: let log = horizon_client::logging::logs_dir(home).join("latest.log");
    // rust: if log.is_file() {
    // rust: add_text_file(&mut zip, &log, "logs/latest.log", &scrubber)?;
}
        // Only a crash from this recording is evidence for this repro.
    // rust: if let Some(crash) = horizon_client::logging::newest_crash_report(home)
    // rust: && crash
    // rust: .metadata()
    // rust: .and_then(|m| m.modified())
    // rust: .is_ok_and(|modified| modified >= started_at - Duration::from_secs(60))
    // rust: {
    // rust: let name = crash
    // rust: .file_name()
    // rust: .map(|n| n.to_string_lossy().into_owned())
    // rust: .unwrap_or_else(|| "crash.txt".into());
    // rust: add_text_file(
    // rust: &mut zip,
    // rust: &crash,
    // rust: &format!("crash-reports/{name}"),
    // rust: &scrubber,
    // rust: )?;
}
    // rust: add_bytes(
    // rust: &mut zip,
    // rust: "status.json",
    // rust: scrubber
    // rust: .scrub(&serde_json::to_string_pretty(&bundle_status(status))?)
    // rust: .as_bytes(),
    // rust: )?;
    // rust: Ok(zip.finish()?.metadata()?.len())
    // rust: })();
    // rust: if result.is_err() {
    // rust: let _ = fs::remove_file(&tmp);
    // rust: return result;
}
    // rust: fs::rename(&tmp, &dest)?;
    // rust: result
}

    // rust: fn add_text_file<W: Write + io::Seek>(
    // rust: zip: &mut zip::ZipWriter<W>,
    // rust: path: &Path,
    // rust: name: &str,
    // rust: scrubber: &Scrubber,
    // rust: ) -> Result<()> {
    // rust: let text = String::from_utf8_lossy(&fs::read(path)?).into_owned();
    // rust: add_bytes(zip, name, scrubber.scrub(&text).as_bytes())
}

    // rust: fn add_bytes<W: Write + io::Seek>(
    // rust: zip: &mut zip::ZipWriter<W>,
    // rust: name: &str,
    // rust: bytes: &[u8],
    // rust: ) -> Result<()> {
    // rust: zip.start_file(
    // rust: name,
    // rust: zip::write::SimpleFileOptions::default()
    // rust: .compression_method(zip::CompressionMethod::Deflated),
    // rust: )?;
    // rust: zip.write_all(bytes)?;
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;

pub fn names_become_folder_slugs() void {
}
    // rust: assert_eq!(slug("My Bug!"), "my-bug");
    // rust: assert_eq!(slug("  "), "session");
    // rust: assert_eq!(slug("a/b"), "a-b");
}

pub fn a_world_copy_skips_the_lock_and_symlinks() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-repro-test-{}", std::process::id()));
    // rust: let src = root.join("src");
    // rust: let dst = root.join("dst");
    // rust: fs::create_dir_all(src.join("region")).unwrap();
    // rust: fs::write(src.join("level.dat"), b"level").unwrap();
    // rust: fs::write(src.join("session.lock"), b"lock").unwrap();
    // rust: fs::write(src.join("region/world.mca"), b"region").unwrap();
    // rust: copy_tree(&src, &dst).unwrap();
    // rust: assert!(dst.join("level.dat").is_file());
    // rust: assert!(dst.join("region/world.mca").is_file());
    // rust: assert!(!dst.join("session.lock").exists());
    // rust: let _ = fs::remove_dir_all(&root);
}

pub fn a_trace_event_round_trips_through_an_inputs_line() void {
}
    // rust: let event = TraceEvent {
    // rust: seq: 3,
    // rust: tick: 42,
    // rust: ms: 137,
    // rust: origin: InputOrigin::User,
    // rust: kind: TraceKind::Key {
    // rust: key: "key.keyboard.w".into(),
    // rust: action: "down".into(),
    // rust: },
}
    // rust: let line = serde_json::to_string(&event).unwrap();
    // rust: let back: TraceEvent = serde_json::from_str(&line).unwrap();
    // rust: assert_eq!(back.seq, 3);
    // rust: assert_eq!(back.origin, InputOrigin::User);
    // rust: assert!(matches!(back.kind, TraceKind::Key { ref key, .. } if key == "key.keyboard.w"));
}

pub fn every_trace_kind_survives_a_hand_written_line() void {
}
    // rust: let lines = [
    // rust: r#"{"seq":1,"tick":1,"ms":0,"origin":"user","kind":"key","key":"key.keyboard.w","action":"down"}"#,
    // rust: r#"{"seq":2,"tick":2,"ms":10,"origin":"user","kind":"mouse","button":"key.mouse.left","action":"down"}"#,
    // rust: r#"{"seq":3,"tick":3,"ms":20,"origin":"user","kind":"wheel","x":0.0,"y":1.0,"lines":true}"#,
    // rust: r#"{"seq":4,"tick":4,"ms":30,"origin":"user","kind":"cursor","x":1.5,"y":2.5}"#,
    // rust: r#"{"seq":5,"tick":5,"ms":40,"origin":"user","kind":"motion","x":10.0,"y":-2.0}"#,
    // rust: r#"{"seq":6,"tick":6,"ms":50,"origin":"agent","kind":"pad","button":"south","action":"down"}"#,
    // rust: r#"{"seq":7,"tick":7,"ms":60,"origin":"agent","kind":"command","line":"key w down"}"#,
    // rust: ];
    // rust: let events: Vec<TraceEvent> = lines
    // rust: .iter()
    // rust: .map(|line| serde_json::from_str(line).unwrap())
    // rust: .collect();
    // rust: assert_eq!(events.len(), 7);
        // Each kind keeps what the replay needs.
    // rust: assert!(matches!(events[0].kind, TraceKind::Key { .. }));
    // rust: assert!(matches!(events[1].kind, TraceKind::Mouse { .. }));
    // rust: assert!(matches!(
    // rust: events[2].kind,
    // rust: TraceKind::Wheel { lines: true, .. }
    // rust: ));
    // rust: assert!(matches!(events[3].kind, TraceKind::Cursor { .. }));
    // rust: assert!(matches!(events[4].kind, TraceKind::Motion { .. }));
    // rust: assert!(matches!(events[5].kind, TraceKind::Pad { .. }));
    // rust: assert!(matches!(events[6].kind, TraceKind::Command { .. }));
}

pub fn only_input_commands_replay() void {
}
    // rust: for name in ["key", "mouse", "look", "click-slot", "goto", "pad"] {
    // rust: assert!(REPLAY_COMMANDS.contains(&name), "{name}");
}
    // rust: for name in [
    // rust: "world-delete",
    // rust: "world-rename",
    // rust: "connect",
    // rust: "chat",
    // rust: "command",
    // rust: "quit",
    // rust: ] {
    // rust: assert!(!REPLAY_COMMANDS.contains(&name), "{name}");
}
}

pub fn the_bundle_status_loses_the_server_and_clipboard() void {
}
    // rust: let status = json!({
    // rust: "server": { "address": "mc.example.net", "players": [{"name": "Alice"}] },
    // rust: "name_tags": ["Alice"],
    // rust: "sidebar": "scores",
    // rust: "input": { "recording": { "dir": "/home/alice/recordings/x" } },
    // rust: "debug": { "clipboard": "invite-code", "fps": 60 },
    // rust: "fps": 60,
    // rust: });
    // rust: let reduced = bundle_status(&status);
    // rust: assert!(reduced.get("server").is_none());
    // rust: assert!(reduced.get("name_tags").is_none());
    // rust: assert!(reduced.get("sidebar").is_none());
    // rust: assert!(reduced.get("input").is_none());
    // rust: assert!(reduced.pointer("/debug/clipboard").is_none());
    // rust: assert_eq!(reduced["fps"], 60);
}

pub fn the_scrubber_hides_the_world_and_the_user() void {
}
    // rust: let status = json!({
    // rust: "server": { "address": "mc.example.net", "name": "Example" },
    // rust: "input": { "recording": { "world": "Secret World" } },
    // rust: });
    // rust: let scrubber = bundle_scrubber(Path::new("/home/alice/recordings/x"), &status);
    // rust: let text = scrubber.scrub("play on Example at mc.example.net in Secret World, /home/alice");
    // rust: assert!(!text.contains("Example"), "{text}");
    // rust: assert!(!text.contains("mc.example.net"), "{text}");
    // rust: assert!(!text.contains("Secret World"), "{text}");
    // rust: assert!(!text.contains("/home/alice"), "{text}");
}

pub fn an_export_name_that_is_taken_gets_a_number() void {
}
    // rust: let root = std::env::temp_dir().join(format!("horizon-repro-dest-{}", std::process::id()));
    // rust: fs::create_dir_all(&root).unwrap();
    // rust: let first = root.join("repro.zip");
    // rust: fs::write(&first, b"x").unwrap();
    // rust: assert_eq!(unique_dest(&first), root.join("repro (1).zip"));
    // rust: let _ = fs::remove_dir_all(&root);
}
}
