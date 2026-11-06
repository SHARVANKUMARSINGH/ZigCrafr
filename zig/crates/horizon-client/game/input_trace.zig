//! Transpiled from Horizon Rust crate
//! Module: horizon-client_input_trace
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Who caused an input event: a person at the keyboard (`user`), an agent on the
//! control socket (`agent`), or the game itself (`game`, made-up input no one
//! asked for). Agents read this with `input-log` and the `input` section of
//! `state` and `status`, so a script can tell that a person took over instead of
//! mistaking their keystrokes for its own. A `user-input` event also lands in
//! `events` (and so in `wait-for event user-input`) when a person steps in
//! while an agent was driving.
//!
//! The events are also what a repro recording writes to `inputs.jsonl`
//! (game/repro.rs).
// use super::{Game, Screen};
// use horizon_client::{Result, keybinds};
// use serde::{Deserialize, Serialize};
// use serde_json::{Value, json};
// use std::{
    // rust: collections::VecDeque,
    // rust: sync::mpsc::Sender,
    // rust: time::{Duration, Instant},
}
// use winit::{
    // rust: event::{ElementState, MouseScrollDelta, WindowEvent},
    // rust: keyboard::PhysicalKey,
}

    // rust: pub(super) const HELP: &[&str] = &[
    // rust: "input-log [--since SEQ] [--limit N] [--origin user|agent|game]  recent input and who caused it",
    // rust: ];

/// Input events kept for `input-log`.
pub const KEPT: usize = 512;
/// A person's input this soon after an agent command is an intrusion.
pub const INTRUSION_GAP: Duration = Duration::from_secs(5);
/// At most one `user-input` event per this long, so holding a key does not flood.
pub const INTRUSION_QUIET: Duration = Duration::from_secs(2);

/// Who caused an input event.
    // rust: pub(super) enum InputOrigin {
    /// The window's own events: someone at this computer's keyboard, mouse or pad.
    // rust: User,
    /// The control socket: `horizon-ctl`, an MCP client, or a script.
    // rust: Agent,
    /// Neither: input the game made up itself (pad menus, UI tasks).
    // rust: Game,
}

    // rust: impl InputOrigin {
    // rust: pub(super) fn name(self) -> &'static str {
    // rust: match self {
    // rust: InputOrigin::User => "user",
    // rust: InputOrigin::Agent => "agent",
    // rust: InputOrigin::Game => "game",
}
}
pub fn index(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as usize
}
pub fn parse(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "user" => Some(InputOrigin::User),
    // rust: "agent" => Some(InputOrigin::Agent),
    // rust: "game" => Some(InputOrigin::Game),
    // rust: _ => None,
}
}
}

/// One input event, as `input-log` shows it and the recording writes it.
    // rust: pub(super) struct TraceEvent {
    // rust: pub seq: u64,
    // rust: pub tick: u64,
    /// Milliseconds since the first event this run; the clock a replay keeps.
    // rust: pub ms: u64,
    // rust: pub origin: InputOrigin,
    // rust: pub kind: TraceKind,
}

/// What was pressed, clicked or typed. Key and button names are the game's own
/// (`key.keyboard.w`, `key.mouse.left`), so a recording can feed them back.
    // rust: pub(super) enum TraceKind {
    // rust: Key {
    // rust: key: String,
        /// `down`, `up` or `repeat` (the system's auto-repeat).
    // rust: action: String,
    // rust: },
    // rust: Mouse {
    // rust: button: String,
    // rust: action: String,
    // rust: },
    // rust: Wheel {
    // rust: x: f64,
    // rust: y: f64,
        /// The window gave lines (a notched wheel) rather than pixels.
    // rust: lines: bool,
    // rust: },
    /// The pointer's screen position, kept while a screen is open: GUI clicks
    /// are replayed at it.
    // rust: Cursor {
    // rust: x: f64,
    // rust: y: f64,
    // rust: },
    /// Relative mouse motion, which turns the view.
    // rust: Motion {
    // rust: x: f64,
    // rust: y: f64,
    // rust: },
    // rust: Pad {
    // rust: button: String,
    // rust: action: String,
    // rust: },
    /// A control-socket line: `key`, `mouse`, `goto`, anything an agent ran.
    // rust: Command {
    // rust: line: String,
    // rust: },
}

    // rust: impl TraceKind {
    // rust: pub(super) fn name(&self) -> &'static str {
    // rust: match self {
    // rust: TraceKind::Key { .. } => "key",
    // rust: TraceKind::Mouse { .. } => "mouse",
    // rust: TraceKind::Wheel { .. } => "wheel",
    // rust: TraceKind::Cursor { .. } => "cursor",
    // rust: TraceKind::Motion { .. } => "motion",
    // rust: TraceKind::Pad { .. } => "pad",
    // rust: TraceKind::Command { .. } => "command",
}
}
}

/// Commands that only read. Polling them must not flood the ring or make an
/// agent that is merely watching look like it acted.
    // rust: const READ_ONLY: &[&str] = &[
    // rust: "state",
    // rust: "status",
    // rust: "events",
    // rust: "wait-for",
    // rust: "input-log",
    // rust: "record-status",
    // rust: "record-list",
    // rust: "looking-at",
    // rust: "entities",
    // rust: "block",
    // rust: "blocks",
    // rust: "light",
    // rust: "inventory",
    // rust: "screen",
    // rust: "menu",
    // rust: "messages",
    // rust: "worlds",
    // rust: "servers",
    // rust: "options-get",
    // rust: "stats",
    // rust: "logs",
    // rust: "ui",
    // rust: ];

/// Commands that steer the session rather than the game: recording them as
/// input would put `record-stop` in a replay it must not run.
    // rust: const SESSION: &[&str] = &[
    // rust: "record-start",
    // rust: "record-stop",
    // rust: "record-replay",
    // rust: "repro-export",
    // rust: "quit",
    // rust: "launch",
    // rust: "mcp",
    // rust: "bench",
    // rust: "sleep",
    // rust: ];

/// Lines whose arguments can carry someone's data: the trace keeps the command
/// name and drops the rest.
    // rust: const PRIVATE_ARGUMENTS: &[&str] = &[
    // rust: "chat", "command", "type", "signedit", "connect", "book", "publish",
    // rust: ];

/// Whether `line` only reads.
pub fn is_read_only(line: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: line.split_whitespace()
    // rust: .next()
    // rust: .is_some_and(|name| READ_ONLY.contains(&name))
}

/// Whether `line` steers the session, not the game.
pub fn is_session_command(line: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: line.split_whitespace()
    // rust: .next()
    // rust: .is_some_and(|name| SESSION.contains(&name))
}

/// The line as the trace keeps it: a command whose arguments are private loses
/// them (`chat <redacted>`).
pub fn redact_command(line: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match line.split_whitespace().next() {
    // rust: Some(name) if PRIVATE_ARGUMENTS.contains(&name) => format!("{name} <redacted>"),
    // rust: _ => line.to_owned(),
}
}

/// The recent input, the counters and the recording's line writer.
    // rust: pub(super) struct InputTrace {
    // rust: seq: u64,
    // rust: log: VecDeque<TraceEvent>,
    // rust: counts: [u64; 3],
    // rust: last: Option<InputOrigin>,
    // rust: last_user: Option<Instant>,
    // rust: last_agent: Option<Instant>,
    /// The person's events since the last agent command.
    // rust: user_since_agent: u64,
    // rust: quiet_until: Option<Instant>,
    /// The first event's wall clock and tick.
    // rust: started: Option<(Instant, u64)>,
    /// The recording's `inputs.jsonl` writer; `None` when nothing records.
    // rust: writer: Option<Sender<String>>,
    // rust: written: u64,
    /// A replay feeds events back: they are not new input and are not recorded.
    // rust: suppress: bool,
}

    // rust: impl InputTrace {
    /// Record one event; whether it is a person intruding on an agent's run.
    /// `agent_active`: an agent is watching or waiting, not only recently heard.
    // rust: fn record(
    // rust: &mut self,
    // rust: tick: u64,
    // rust: origin: InputOrigin,
    // rust: kind: TraceKind,
    // rust: agent_active: bool,
    // rust: ) -> bool {
    // rust: if self.suppress {
    // rust: return false;
}
    // rust: let now = Instant::now();
    // rust: let started = self.started.get_or_insert((now, tick)).0;
    // rust: let ms = now.duration_since(started).as_millis() as u64;

    // rust: let intrusion = origin == InputOrigin::User
    // rust: && (agent_active
    // rust: || self
    // rust: .last_agent
    // rust: .is_some_and(|t| now.duration_since(t) < INTRUSION_GAP))
    // rust: && self.quiet_until.is_none_or(|t| now >= t);
    // rust: if intrusion {
    // rust: self.quiet_until = Some(now + INTRUSION_QUIET);
}

    // rust: self.seq += 1;
    // rust: let event = TraceEvent {
    // rust: seq: self.seq,
    // rust: tick,
    // rust: ms,
    // rust: origin,
    // rust: kind,
}
    // rust: if self.writer.is_some() {
    // rust: let mut failed = false;
    // rust: match serde_json::to_string(&event) {
    // rust: Ok(line) => {
    // rust: if let Some(writer) = &self.writer {
    // rust: failed = writer.send(line).is_err();
}
}
    // rust: Err(e) => log::warn!("Horizon: input trace: {e}"),
}
    // rust: if failed {
    // rust: self.writer = None;
    // rust: log::warn!("Horizon: input trace stopped: its writer is gone");
    // rust: } else {
    // rust: self.written += 1;
}
}
    // rust: if self.log.len() == KEPT {
    // rust: self.log.pop_front();
}
    // rust: self.log.push_back(event);
    // rust: self.counts[origin.index()] += 1;
    // rust: self.last = Some(origin);
    // rust: match origin {
    // rust: InputOrigin::User => {
    // rust: self.last_user = Some(now);
    // rust: self.user_since_agent += 1;
}
    // rust: InputOrigin::Agent => {
    // rust: self.last_agent = Some(now);
    // rust: self.user_since_agent = 0;
}
    // rust: InputOrigin::Game => {}
}
    // rust: intrusion
}

    /// An agent line that is not input (a poll, a wait): it still means an
    /// agent is watching, so a person's next key is an intrusion.
    // rust: pub(super) fn agent_activity(&mut self) {
    // rust: if self.suppress {
    // rust: return;
}
    // rust: self.last_agent = Some(Instant::now());
    // rust: self.user_since_agent = 0;
}

    /// The `input` section of `state` and `status`.
    // rust: pub(super) fn summary(&self) -> Value {
    // rust: json!({
    // rust: "last_origin": self.last.map(InputOrigin::name),
    // rust: "counts": {
    // rust: "user": self.counts[InputOrigin::User.index()],
    // rust: "agent": self.counts[InputOrigin::Agent.index()],
    // rust: "game": self.counts[InputOrigin::Game.index()],
    // rust: },
    // rust: "user_since_agent": self.user_since_agent,
    // rust: "last_user_age_s": self
    // rust: .last_user
    // rust: .map(|t| (t.elapsed().as_secs_f64() * 10.0).round() / 10.0),
    // rust: "events": self.seq,
    // rust: })
}

    /// Start writing the events to a recording.
    // rust: pub(super) fn start_file(&mut self, writer: Sender<String>) {
    // rust: self.writer = Some(writer);
    // rust: self.written = 0;
}
    /// Stop writing; how many events the recording received.
    // rust: pub(super) fn stop_file(&mut self) -> u64 {
    // rust: self.writer = None;
    // rust: std::mem::take(&mut self.written)
}
    /// How many events this run has seen.
    // rust: pub(super) fn events(&self) -> u64 {
    // rust: self.seq
}
    /// A replay's own events are not new input.
    // rust: pub(super) fn set_suppress(&mut self, suppress: bool) {
    // rust: self.suppress = suppress;
}

    /// `input-log`.
    // rust: pub(super) fn command(&self, words: &[&str]) -> Result<Option<Value>> {
    // rust: if words[0] != "input-log" {
    // rust: return Ok(None);
}
    // rust: let mut since = 0;
    // rust: let mut limit = usize::MAX;
    // rust: let mut origin = None;
    // rust: let mut i = 1;
    // rust: while i < words.len() {
    // rust: let value = words
    // rust: .get(i + 1)
    // rust: .ok_or_else(|| format!("{} takes a value", words[i]))?;
    // rust: match words[i] {
    // rust: "--since" => since = value.parse().map_err(|_| "--since takes a number")?,
    // rust: "--limit" => limit = value.parse().map_err(|_| "--limit takes a number")?,
    // rust: "--origin" => {
    // rust: origin = Some(
    // rust: InputOrigin::parse(value).ok_or("--origin takes user, agent or game")?,
    // rust: )
}
    // rust: other => return Err(format!("input-log: unknown argument {other}").into()),
}
    // rust: i += 2;
}
    // rust: let mut events: Vec<&TraceEvent> = self
    // rust: .log
    // rust: .iter()
    // rust: .filter(|e| e.seq > since && origin.is_none_or(|o| e.origin == o))
    // rust: .collect();
    // rust: if events.len() > limit {
    // rust: events.drain(..events.len() - limit);
}
    // rust: Ok(Some(json!({
    // rust: "events": events,
    // rust: "last": self.seq,
    // rust: "input": self.summary(),
    // rust: })))
}
}

    // rust: impl Game<'_> {
    /// An agent's control line: input unless it only reads, which still counts
    /// as the agent watching.
    // rust: pub(super) fn note_socket_line(&mut self, line: &str) {
    // rust: if is_read_only(line) || is_session_command(line) {
    // rust: self.input_trace.agent_activity();
    // rust: return;
}
    // rust: self.note_input(
    // rust: InputOrigin::Agent,
    // rust: TraceKind::Command {
    // rust: line: redact_command(line),
    // rust: },
    // rust: );
}

    /// Whether anything can read the trace: the control socket (agent control
    /// on), the repro shortcuts, or a recording under way. Otherwise every key
    /// and mouse motion skips it, so a player who uses none of them pays
    /// nothing per input event.
pub fn tracing_input(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.control.is_some() || self.settings.extras.repro_keys || self.repro.recording_active()
}

    /// Record an input event and, when a person steps into an agent's run, tell
    /// every watcher once.
    // rust: pub(super) fn note_input(&mut self, origin: InputOrigin, kind: TraceKind) {
    // rust: if !self.tracing_input() {
    // rust: return;
}
    // rust: let kind_name = kind.name();
        // An agent waiting on a task or a wait, or a client still connected, is
        // watching even when its last line was minutes ago.
    // rust: let agent_active = self.control.as_ref().is_some_and(|c| c.clients() > 0)
    // rust: || self.agent_busy()
    // rust: || self.events.has_waits();
    // rust: if self
    // rust: .input_trace
    // rust: .record(self.ticks, origin, kind, agent_active)
    // rust: {
    // rust: let event = json!({ "event": "user-input", "input": kind_name });
    // rust: self.repro.note_event(self.ticks, &event);
    // rust: self.events.note(self.ticks, event);
    // rust: log::info!(
    // rust: "Horizon: {kind_name} input from a person while an agent was driving \
    // rust: (input-log has the run)"
    // rust: );
}
}

    /// Keep the window events that are input. Agent-made window events are left
    /// out: the control-socket line that caused them is recorded instead.
    // rust: pub(super) fn trace_window_event(&mut self, origin: InputOrigin, event: &WindowEvent) {
    // rust: if origin == InputOrigin::Agent || !self.tracing_input() {
    // rust: return;
}
    // rust: match event {
    // rust: WindowEvent::KeyboardInput {
    // rust: event,
    // rust: is_synthetic,
    // rust: ..
    // rust: } => {
    // rust: let PhysicalKey::Code(code) = event.physical_key else {
    // rust: return;
}
    // rust: let Some(name) = keybinds::key_name(code) else {
    // rust: return;
}
    // rust: let action = match (event.state, event.repeat) {
    // rust: (ElementState::Released, _) => "up",
    // rust: (_, true) => "repeat",
    // rust: (ElementState::Pressed, false) => "down",
}
                // The platform made this one up (an IME's dead key): not a person.
    // rust: let origin = if *is_synthetic {
    // rust: InputOrigin::Game
    // rust: } else {
    // rust: origin
}
    // rust: self.note_input(
    // rust: origin,
    // rust: TraceKind::Key {
    // rust: key: name.to_owned(),
    // rust: action: action.to_owned(),
    // rust: },
    // rust: );
}
    // rust: WindowEvent::MouseInput { state, button, .. } => self.note_input(
    // rust: origin,
    // rust: TraceKind::Mouse {
    // rust: button: keybinds::mouse_name(*button),
    // rust: action: match state {
    // rust: ElementState::Pressed => "down".to_owned(),
    // rust: ElementState::Released => "up".to_owned(),
    // rust: },
    // rust: },
    // rust: ),
    // rust: WindowEvent::MouseWheel { delta, .. } => {
    // rust: let (x, y, lines) = match delta {
    // rust: MouseScrollDelta::LineDelta(x, y) => (f64::from(*x), f64::from(*y), true),
    // rust: MouseScrollDelta::PixelDelta(p) => (p.x, p.y, false),
}
    // rust: self.note_input(origin, TraceKind::Wheel { x, y, lines });
}
            // GUI clicks land where the pointer is; in the world the pointer is
            // grabbed and turns the view through `device_event` instead.
    // rust: WindowEvent::CursorMoved { position, .. } if self.screen != Screen::Playing => {
    // rust: self.note_input(
    // rust: origin,
    // rust: TraceKind::Cursor {
    // rust: x: position.x,
    // rust: y: position.y,
    // rust: },
    // rust: );
}
    // rust: _ => {}
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn key(name: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TraceKind::Key {
    // rust: key: name.to_owned(),
    // rust: action: "down".to_owned(),
}
}

pub fn origins_round_trip() void {
}
    // rust: for origin in [InputOrigin::User, InputOrigin::Agent, InputOrigin::Game] {
    // rust: assert_eq!(InputOrigin::parse(origin.name()), Some(origin));
}
    // rust: assert_eq!(InputOrigin::parse("nobody"), None);
}

pub fn the_ring_keeps_the_newest_and_counts_every_origin() void {
}
    // rust: let mut trace = InputTrace::default();
    // rust: for i in 0..=(KEPT as u64 + 10) {
    // rust: trace.record(i, InputOrigin::User, key("key.keyboard.w"), false);
}
    // rust: assert_eq!(trace.log.len(), KEPT);
    // rust: assert_eq!(trace.seq, KEPT as u64 + 11);
    // rust: assert_eq!(trace.log.front().unwrap().seq, 12);
    // rust: assert_eq!(trace.counts[InputOrigin::User.index()], KEPT as u64 + 11);
}

pub fn a_person_after_an_agent_is_an_intrusion_once() void {
}
    // rust: let mut trace = InputTrace::default();
    // rust: trace.record(1, InputOrigin::Agent, key("key.keyboard.w"), false);
    // rust: assert!(trace.record(2, InputOrigin::User, key("key.keyboard.a"), false));
        // The quiet period keeps a held key from flooding the event log.
    // rust: assert!(!trace.record(3, InputOrigin::User, key("key.keyboard.a"), false));
    // rust: assert_eq!(trace.user_since_agent, 2);
        // An agent command resets the count.
    // rust: trace.record(4, InputOrigin::Agent, key("key.keyboard.w"), false);
    // rust: assert_eq!(trace.user_since_agent, 0);
}

pub fn no_intrusion_without_an_agent() void {
}
    // rust: let mut trace = InputTrace::default();
    // rust: assert!(!trace.record(1, InputOrigin::User, key("key.keyboard.w"), false));
        // The game's own input is not a person either.
    // rust: trace.record(2, InputOrigin::Agent, key("key"), false);
    // rust: assert!(!trace.record(3, InputOrigin::Game, key("key.keyboard.w"), false));
}

pub fn input_log_filters_since_origin_and_limit() void {
}
    // rust: let mut trace = InputTrace::default();
    // rust: for (i, origin) in [
    // rust: InputOrigin::Agent,
    // rust: InputOrigin::User,
    // rust: InputOrigin::Game,
    // rust: InputOrigin::User,
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: trace.record(i as u64, origin, key("key.keyboard.w"), false);
}
    // rust: let all = trace.command(&["input-log"]).unwrap().unwrap();
    // rust: assert_eq!(all["events"].as_array().unwrap().len(), 4);
    // rust: assert_eq!(all["last"], 4);

    // rust: let users = trace
    // rust: .command(&["input-log", "--origin", "user"])
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(users["events"].as_array().unwrap().len(), 2);
    // rust: assert!(
    // rust: users["events"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .all(|e| e["origin"] == "user")
    // rust: );

    // rust: let newest = trace
    // rust: .command(&["input-log", "--since", "2", "--limit", "1"])
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: let events = newest["events"].as_array().unwrap();
    // rust: assert_eq!(events.len(), 1);
    // rust: assert_eq!(events[0]["seq"], 4);
}

pub fn the_recording_writer_gets_one_json_line_per_event() void {
}
    // rust: let (tx, rx) = std::sync::mpsc::channel();
    // rust: let mut trace = InputTrace::default();
    // rust: trace.start_file(tx);
    // rust: trace.record(7, InputOrigin::User, key("key.keyboard.w"), false);
    // rust: trace.record(8, InputOrigin::Agent, key("key.keyboard.s"), false);
    // rust: assert_eq!(trace.stop_file(), 2);
    // rust: let lines: Vec<String> = rx.try_iter().collect();
    // rust: assert_eq!(lines.len(), 2);
    // rust: let first: Value = serde_json::from_str(&lines[0]).unwrap();
    // rust: assert_eq!(first["tick"], 7);
    // rust: assert_eq!(first["origin"], "user");
    // rust: assert_eq!(first["kind"], "key");
    // rust: assert_eq!(first["key"], "key.keyboard.w");
}

pub fn private_arguments_are_dropped() void {
}
    // rust: assert_eq!(redact_command("chat /login hunter2"), "chat <redacted>");
    // rust: assert_eq!(
    // rust: redact_command("connect friend:ABCD-1234"),
    // rust: "connect <redacted>"
    // rust: );
    // rust: assert_eq!(
    // rust: redact_command("key key.keyboard.w down"),
    // rust: "key key.keyboard.w down"
    // rust: );
}

pub fn polls_are_read_only() void {
}
    // rust: for line in [
    // rust: "state",
    // rust: "wait-for event death",
    // rust: "record-status",
    // rust: "input-log --origin user",
    // rust: "ui",
    // rust: ] {
    // rust: assert!(is_read_only(line), "{line}");
}
    // rust: for line in ["key w down", "record-start x", "mouse left click"] {
    // rust: assert!(!is_read_only(line), "{line}");
}
}

pub fn session_commands_are_not_input() void {
}
    // rust: for line in [
    // rust: "record-start x",
    // rust: "record-stop --export",
    // rust: "record-replay x",
    // rust: "repro-export x",
    // rust: "quit",
    // rust: ] {
    // rust: assert!(is_session_command(line), "{line}");
}
    // rust: assert!(!is_session_command("key w down"));
}

pub fn an_agent_still_watching_makes_a_later_person_an_intrusion() void {
}
    // rust: let mut trace = InputTrace::default();
    // rust: trace.record(1, InputOrigin::Agent, key("key"), false);
        // The agent is waiting on a task or a wait: no five-second window.
    // rust: assert!(trace.record(2, InputOrigin::User, key("key.keyboard.a"), true));
}

pub fn a_suppressed_replay_records_nothing() void {
}
    // rust: let mut trace = InputTrace::default();
    // rust: trace.set_suppress(true);
    // rust: assert!(!trace.record(1, InputOrigin::User, key("key.keyboard.w"), false));
    // rust: assert_eq!(trace.seq, 0);
    // rust: assert!(trace.summary()["last_origin"].is_null());
}
}
