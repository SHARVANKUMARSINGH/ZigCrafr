//! Transpiled from Horizon Rust crate
//! Module: horizon-client_main
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! horizon-ctl: play and script a running Horizon client through its control
//! socket, from a shell, a script or an AI agent (`horizon-ctl mcp`).
    // rust: extern crate horizon_client_lib as horizon_client;
    // rust: mod commands;
    // rust: mod launch;
    // rust: mod mcp;

// use std::{
    // rust: io::{BufRead, BufReader, Write},
    // rust: path::{Path, PathBuf},
    // rust: process::ExitCode,
    // rust: thread,
    // rust: time::{Duration, Instant},
}

// use horizon_client::control::Stream;
// use serde_json::{Value, json};

/// Exit statuses.
pub const GAME_ERROR: u8 = 1;
pub const USAGE: u8 = 2;
pub const UNREACHABLE: u8 = 3;
/// No AI is on (`horizon_core::no_ai`): agent control is off.
pub const DENIED: u8 = 4;
/// `--api LINE`: the game speaks another protocol line.
pub const API_MISMATCH: u8 = 5;

/// A failure, with the exit status it maps to.
pub const Failure = struct {
    reply: Value,
    status: u8,
};
    // rust: impl Failure {
pub fn usage(message: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: reply: json!({ "error": message.into(), "kind": "usage" }),
    // rust: status: USAGE,
}
}
    /// No AI is on in the game's home.
pub fn denied() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: reply: json!({ "error": horizon_core::no_ai::REFUSAL, "kind": "denied" }),
    // rust: status: DENIED,
}
}
pub fn unreachable(message: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: reply: json!({ "error": message.into(), "kind": "connection" }),
    // rust: status: UNREACHABLE,
}
}
}

pub const Client = struct {
    writer: Stream,
    reader: BufReader<Stream>,
};

    // rust: impl Client {
pub fn connect(path: *Path, timeout: ?Duration) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let stream = horizon_client::control::connect(path).map_err(|e| {
    // rust: Failure::unreachable(format!(
    // rust: "cannot connect to {} ({e}); is the game running with --control? Start one with: horizon-ctl launch --world NAME",
    // rust: path.display()
    // rust: ))
    // rust: })?;
    // rust: stream
    // rust: .set_read_timeout(timeout)
    // rust: .map_err(|e| Failure::unreachable(e.to_string()))?;
    // rust: let reader = BufReader::new(
    // rust: stream
    // rust: .try_clone()
    // rust: .map_err(|e| Failure::unreachable(e.to_string()))?,
    // rust: );
    // rust: Ok(Self {
    // rust: writer: stream,
    // rust: reader,
    // rust: })
}
    /// Send one line and read its JSON reply.
pub fn send(self: *Self, line: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: writeln!(self.writer, "{line}").map_err(|e| Failure::unreachable(e.to_string()))?;
    // rust: let mut reply = String::new();
    // rust: let n = self.reader.read_line(&mut reply).map_err(|e| {
    // rust: Failure::unreachable(
    // rust: if matches!(
    // rust: e.kind(),
    // rust: std::io::ErrorKind::WouldBlock | std::io::ErrorKind::TimedOut
    // rust: ) {
    // rust: "timed out waiting for the game's reply (--timeout)".to_owned()
    // rust: } else {
    // rust: e.to_string()
    // rust: },
    // rust: )
    // rust: })?;
    // rust: if n == 0 {
    // rust: return Err(Failure::unreachable("the game closed the connection"));
}
    // rust: serde_json::from_str(reply.trim_end()).map_err(|_| Failure {
    // rust: reply: json!({ "error": "the game sent a reply that is not JSON", "reply": reply.trim_end() }),
    // rust: status: GAME_ERROR,
    // rust: })
}
}

/// Whether a game's protocol (`MAJOR.MINOR.PATCH`) is on the requested line (`MAJOR.MINOR`, or a full version):
/// every part the line names must match. Before 1.0 a patch only adds, so `0.1` takes `0.1.0` and `0.1.4`.
pub fn on_line(protocol: []const u8, line: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let game: Vec<&str> = protocol.split('.').collect();
    // rust: let want: Vec<&str> = line.split('.').collect();
    // rust: want.len() <= game.len() && want.iter().zip(&game).all(|(w, g)| w == g)
}

/// Ask the game `hello` and refuse it unless it speaks `line`. A game without the command
/// (older than protocol 0.1.0) has no protocol line and is refused too.
pub fn check_api(client: *mut Client, line: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let refuse = |why: String| Failure {
    // rust: reply: json!({ "error": format!("horizon-ctl --api {line}: {why}"), "kind": "api", "wanted": line }),
    // rust: status: API_MISMATCH,
}
    // rust: let reply = client.send("hello")?;
    // rust: match reply.get("protocol").and_then(Value::as_str) {
    // rust: Some(p) if on_line(p, line) => Ok(()),
    // rust: Some(p) => Err(refuse(format!(
    // rust: "the game speaks control protocol {p}, not the {line} line; use a horizon-ctl built for it (docs/api/agent-control.md)"
    // rust: ))),
    // rust: None => Err(refuse(
    // rust: "the game does not report a control protocol (it predates hello); update the game or drop --api".to_owned(),
    // rust: )),
}
}

/// Global options and the connection, opened on first use.
pub const Session = struct {
    socket: PathBuf,
    timeout: ?Duration,
    /// The game's home, where No AI is read (`horizon_core::no_ai`).
    home: PathBuf,
    /// `--api LINE`: the protocol line this run speaks; a game on another line is refused.
    api: ?[]const u8,
    client: ?Client,
};

    // rust: impl Session {
pub fn new(socket: PathBuf, timeout: ?Duration) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: socket,
    // rust: timeout,
    // rust: home: horizon_client::logging::game_home(),
    // rust: api: None,
    // rust: client: None,
}
}
    /// A failure while No AI is on: every command refuses (help aside).
pub fn allowed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_core::no_ai::check(&self.home).map_err(|_| Failure::denied())
}
pub fn client(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.client.is_none() {
    // rust: let mut client = Client::connect(&self.socket, self.timeout)?;
    // rust: if let Some(line) = &self.api {
    // rust: check_api(&mut client, line)?;
}
    // rust: self.client = Some(client);
}
    // rust: Ok(self.client.as_mut().unwrap())
}
    /// Send a line to the game; a reply with "error" is a failure.
pub fn game(self: *Self, line: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let result = self.client()?.send(line);
    // rust: if result.as_ref().is_err_and(|f| f.status == UNREACHABLE) {
            // Reconnect next time (the game may have restarted).
    // rust: self.client = None;
}
    // rust: let reply = result?;
    // rust: if reply.get("error").is_some() {
    // rust: return Err(Failure {
    // rust: reply,
    // rust: status: GAME_ERROR,
    // rust: });
}
    // rust: Ok(reply)
}

    /// Run one command (CLI words); Ok(reply) or a failure.
pub fn run(self: *Self, words: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(name) = words.first().map(String::as_str) else {
    // rust: return Err(Failure::usage("no command; try horizon-ctl help"));
}
    // rust: self.allowed()?;
    // rust: if words.iter().skip(1).any(|w| w == "--help" || w == "-h") {
    // rust: return Err(Failure::usage(
    // rust: "use horizon-ctl COMMAND --help outside scripts",
    // rust: ));
}
    // rust: let number = |i: usize, what: &str| -> Result<f64, Failure> {
    // rust: words
    // rust: .get(i)
    // rust: .ok_or_else(|| Failure::usage(format!("missing {what}; usage: {}", usage(name))))?
    // rust: .parse::<f64>()
    // rust: .map_err(|_| {
    // rust: Failure::usage(format!("{what} must be a number; usage: {}", usage(name)))
    // rust: })
}
    // rust: match name {
    // rust: "sleep" => {
    // rust: thread::sleep(Duration::from_secs_f64(number(1, "SECONDS")?.max(0.0)));
    // rust: Ok(json!({ "ok": true }))
}
    // rust: "launch" => {
    // rust: let socket = self.socket.clone();
    // rust: let wait = words.iter().any(|w| w == "--wait" || w == "--wait-ready");
    // rust: let reply = launch::launch(&socket, &words[1..]).map_err(|reply| Failure {
    // rust: status: if reply["kind"] == "usage" {
    // rust: USAGE
    // rust: } else {
    // rust: UNREACHABLE
    // rust: },
    // rust: reply,
    // rust: })?;
    // rust: if !wait {
    // rust: return Ok(reply);
}
    // rust: let mut ready = self.wait_ready(300.0)?;
    // rust: ready["launch"] = reply;
    // rust: Ok(ready)
}
    // rust: "interact-entity" => {
    // rust: let id = match words {
    // rust: [_, id] if id.parse::<i64>().is_ok() => id,
    // rust: _ => return Err(Failure::usage(format!("usage: {}", usage(name)))),
}
    // rust: self.game(&format!("look-at entity {id}"))?;
    // rust: self.game("mouse right click")?;
    // rust: self.game("wait 2")?;
    // rust: let mut screen = self.game("screen")?;
    // rust: screen["ok"] = json!(true);
    // rust: Ok(screen)
}
    // rust: "hold" => {
    // rust: let (key, seconds) = match words {
    // rust: [_, key, _] => (key.clone(), number(2, "SECONDS")?),
    // rust: _ => return Err(Failure::usage(format!("usage: {}", usage(name)))),
}
    // rust: self.game(&format!("key {key} down"))?;
    // rust: thread::sleep(Duration::from_secs_f64(seconds.max(0.0)));
    // rust: self.game(&format!("key {key} up"))
}
    // rust: "logs" => logs(&self.home, &words[1..]),
    // rust: "wait-ready" => {
    // rust: let limit = if words.len() > 1 {
    // rust: number(1, "SECONDS")?
    // rust: } else {
    // rust: 120.0
}
    // rust: self.wait_ready(limit)
}
    // rust: "help" if words.get(1).is_some_and(|w| w == "--game") => self.game("help"),
    // rust: _ => {
    // rust: let mut words = words.to_vec();
    // rust: if let Some(cmd) = commands::find(name) {
    // rust: if cmd.local {
    // rust: return Err(Failure::usage(format!(
    // rust: "{name} runs only as horizon-ctl {name}, not inside a script"
    // rust: )));
}
    // rust: if let Some(wire) = cmd.wire {
    // rust: words.splice(0..1, wire.split(' ').map(str::to_owned));
}
}
    // rust: absolute_paths(&mut words);
    // rust: self.game(&words.join(" "))
}
}
}

pub fn wait_ready(self: *Self, limit: f64) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let deadline = Instant::now() + Duration::from_secs_f64(limit.max(0.0));
    // rust: loop {
    // rust: let status = self.game("status")?;
            // On a server (single player's server thread too), also the
            // level around the player.
    // rust: if !status["player"].is_null()
    // rust: && status["pending_chunks"] == 0
    // rust: && status["server"]["loaded"] != false
    // rust: {
    // rust: return Ok(status);
}
    // rust: if Instant::now() > deadline {
    // rust: return Err(Failure {
    // rust: reply: json!({ "error": format!("not ready after {limit} seconds"), "status": status }),
    // rust: status: GAME_ERROR,
    // rust: });
}
    // rust: thread::sleep(Duration::from_millis(250));
}
}
}

/// `logs [--lines N] [--crash]` for the game in `home`: the reply's `text` is the log's last
/// lines or the report.
pub fn logs(home: *Path, words: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
//     use horizon_client::logging;
    // rust: let mut lines = 100;
    // rust: let mut crash = false;
    // rust: let mut it = words.iter();
    // rust: while let Some(word) = it.next() {
    // rust: match word.as_str() {
    // rust: "--crash" => crash = true,
    // rust: "--lines" => {
    // rust: lines = it
    // rust: .next()
    // rust: .and_then(|n| n.parse::<usize>().ok())
    // rust: .filter(|&n| n > 0)
    // rust: .ok_or_else(|| Failure::usage("--lines takes a number above 0"))?;
}
    // rust: other => {
    // rust: return Err(Failure::usage(format!(
    // rust: "unknown argument {other}; usage: {}",
    // rust: usage("logs")
    // rust: )));
}
}
}
    // rust: let missing = |what: String| Failure {
    // rust: reply: json!({ "error": what }),
    // rust: status: GAME_ERROR,
}
    // rust: if crash {
    // rust: let path = logging::newest_crash_report(home).ok_or_else(|| {
    // rust: missing(format!(
    // rust: "no crash report in {}",
    // rust: logging::crash_reports_dir(home).display()
    // rust: ))
    // rust: })?;
    // rust: let text = std::fs::read_to_string(&path)
    // rust: .map_err(|e| missing(format!("{}: {e}", path.display())))?;
    // rust: return Ok(json!({ "path": path, "text": text }));
}
    // rust: let path = logging::logs_dir(home).join("latest.log");
    // rust: let tail =
    // rust: logging::tail(&path, lines).map_err(|e| missing(format!("{}: {e}", path.display())))?;
    // rust: Ok(json!({ "path": path, "text": tail.join("\n") + "\n" }))
}

pub fn usage(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: commands::find(name).map_or_else(|| name.to_owned(), |c| format!("horizon-ctl {}", c.usage))
}

/// Paths are written by the game process: make them absolute here.
pub fn absolute_paths(words: *mut [[]const u8]) void {
}
    // rust: let Ok(cwd) = std::env::current_dir() else {
    // rust: return;
}
    // rust: match words.first().map(String::as_str) {
    // rust: Some("screenshot") => {
    // rust: if let Some(path) = words.get_mut(1) {
    // rust: *path = cwd.join(&*path).display().to_string();
}
}
        // `repro-export [NAME] [PATH]`: the second positional is the zip.
    // rust: Some("repro-export") => {
    // rust: if let Some(path) = words.get_mut(2)
    // rust: && (path.contains('/') || path.ends_with(".zip"))
    // rust: {
    // rust: *path = cwd.join(&*path).display().to_string();
}
}
    // rust: _ => {}
}
}

/// Split a script line like a shell: quotes keep spaces, backslash escapes.
pub fn split_line(line: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut words = Vec::new();
    // rust: let mut word = String::new();
    // rust: let mut in_word = false;
    // rust: let mut quote: Option<char> = None;
    // rust: let mut chars = line.chars();
    // rust: while let Some(c) = chars.next() {
    // rust: match (quote, c) {
    // rust: (Some(q), c) if c == q => quote = None,
    // rust: (Some('"'), '\\') => word.push(chars.next().unwrap_or('\\')),
    // rust: (Some(_), c) => word.push(c),
    // rust: (None, '"' | '\'') => {
    // rust: quote = Some(c);
    // rust: in_word = true;
}
    // rust: (None, '\\') => {
    // rust: word.push(chars.next().unwrap_or('\\'));
    // rust: in_word = true;
}
    // rust: (None, '#') if !in_word => break,
    // rust: (None, c) if c.is_whitespace() => {
    // rust: if in_word {
    // rust: words.push(std::mem::take(&mut word));
    // rust: in_word = false;
}
}
    // rust: (None, c) => {
    // rust: word.push(c);
    // rust: in_word = true;
}
}
}
    // rust: if quote.is_some() {
    // rust: return Err("unterminated quote".into());
}
    // rust: if in_word {
    // rust: words.push(word);
}
    // rust: Ok(words)
}

pub fn print(value: *Value, pretty: bool) void {
}
    // rust: let text = if pretty {
    // rust: serde_json::to_string_pretty(value).unwrap_or_default()
    // rust: } else {
    // rust: value.to_string()
}
    // rust: println!("{text}");
}

/// Run a script; the exit status of the first failure (or the last one with --keep-going).
pub fn script(session: *mut Session, reader: impl BufRead, keep_going: bool, pretty: bool) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut status = 0;
    // rust: for (n, line) in reader.lines().enumerate() {
    // rust: let Ok(line) = line else { break };
    // rust: let words = match split_line(&line) {
    // rust: Ok(w) if w.is_empty() => continue,
    // rust: Ok(w) => w,
    // rust: Err(e) => {
    // rust: print(
    // rust: &json!({ "error": e, "kind": "usage", "line": n + 1 }),
    // rust: pretty,
    // rust: );
    // rust: status = USAGE;
    // rust: if keep_going {
    // rust: continue;
}
    // rust: break;
}
}
    // rust: match session.run(&words) {
    // rust: Ok(reply) => print(&reply, pretty),
    // rust: Err(mut f) => {
    // rust: f.reply["line"] = json!(n + 1);
    // rust: print(&f.reply, pretty);
    // rust: status = f.status;
    // rust: if !keep_going || f.status == UNREACHABLE {
    // rust: break;
}
}
}
}
    // rust: status
}

pub fn main() E {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut args: Vec<String> = std::env::args().skip(1).collect();
    // rust: let mut socket = horizon_client::control::default_path();
    // rust: let mut timeout = None;
    // rust: let mut pretty = false;
    // rust: let mut api: Option<String> = None;
    // Global options before the command.
    // rust: loop {
    // rust: match args.first().map(String::as_str) {
    // rust: Some("--socket") if args.len() >= 2 => {
    // rust: socket = PathBuf::from(args.remove(1));
    // rust: args.remove(0);
}
    // rust: Some("--timeout") if args.len() >= 2 => {
    // rust: let Ok(s) = args[1].parse::<f64>() else {
    // rust: print(
    // rust: &json!({ "error": "--timeout takes seconds", "kind": "usage" }),
    // rust: false,
    // rust: );
    // rust: return ExitCode::from(USAGE);
}
    // rust: timeout = Some(Duration::from_secs_f64(s.max(0.001)));
    // rust: args.drain(0..2);
}
    // rust: Some("--api") if args.len() >= 2 => {
    // rust: api = Some(args[1].clone());
    // rust: args.drain(0..2);
}
    // rust: Some("--pretty") => {
    // rust: pretty = true;
    // rust: args.remove(0);
}
    // rust: _ => break,
}
}
    // rust: if let Some(line) = &api {
    // rust: let valid = !line.is_empty()
    // rust: && line.split('.').count() <= 3
    // rust: && line
    // rust: .split('.')
    // rust: .all(|p| !p.is_empty() && p.bytes().all(|b| b.is_ascii_digit()));
    // rust: if !valid {
    // rust: print(
    // rust: &json!({ "error": "--api takes a protocol line such as 0.1", "kind": "usage" }),
    // rust: false,
    // rust: );
    // rust: return ExitCode::from(USAGE);
}
}
    // rust: let mut session = Session::new(socket, timeout);
    // rust: session.api = api;
    // rust: let name = args.first().cloned();
    // rust: let status = match name.as_deref() {
    // rust: None | Some("-h" | "--help") => {
    // rust: print!("{}", commands::overview());
    // rust: 0
}
    // rust: Some("help") if args.get(1).is_some_and(|a| a == "--markdown") => {
    // rust: print!("{}", commands::markdown());
    // rust: 0
}
    // rust: Some("help") if args.get(1).is_none_or(|a| a != "--game") => match args.get(1) {
    // rust: None => {
    // rust: print!("{}", commands::overview());
    // rust: 0
}
    // rust: Some(c) => match commands::find(c) {
    // rust: Some(cmd) => {
    // rust: print!("{}", commands::detail(cmd));
    // rust: 0
}
    // rust: None => {
    // rust: print(
    // rust: &json!({ "error": format!("unknown command {c}; horizon-ctl help lists them, horizon-ctl help --game lists the game's own"), "kind": "usage" }),
    // rust: pretty,
    // rust: );
    // rust: USAGE
}
    // rust: },
    // rust: },
    // rust: Some(c) if args.len() == 2 && matches!(args[1].as_str(), "--help" | "-h") => {
    // rust: match commands::find(c) {
    // rust: Some(cmd) => {
    // rust: print!("{}", commands::detail(cmd));
    // rust: 0
}
    // rust: None => {
    // rust: print(
    // rust: &json!({ "error": format!("no help for {c}; horizon-ctl help --game lists the game's own commands"), "kind": "usage" }),
    // rust: pretty,
    // rust: );
    // rust: USAGE
}
}
}
    // rust: Some("mcp") if session.allowed().is_err() => {
    // rust: eprintln!("horizon-ctl mcp: {}", horizon_core::no_ai::REFUSAL);
    // rust: DENIED
}
    // rust: Some("mcp") => match mcp::serve(&mut session) {
    // rust: Ok(()) => 0,
    // rust: Err(e) => {
    // rust: eprintln!("horizon-ctl mcp: {e}");
    // rust: UNREACHABLE
}
    // rust: },
        // The original form: stdin, keep going after errors.
    // rust: Some("-") => script(&mut session, std::io::stdin().lock(), true, pretty),
    // rust: Some("script") => {
    // rust: let keep_going = args.iter().any(|a| a == "--keep-going");
    // rust: match args.iter().skip(1).find(|a| !a.starts_with("--")) {
    // rust: Some(file) if file != "-" => match std::fs::File::open(file) {
    // rust: Ok(f) => script(&mut session, BufReader::new(f), keep_going, pretty),
    // rust: Err(e) => {
    // rust: print(
    // rust: &json!({ "error": format!("{file}: {e}"), "kind": "usage" }),
    // rust: pretty,
    // rust: );
    // rust: USAGE
}
    // rust: },
    // rust: _ => script(&mut session, std::io::stdin().lock(), keep_going, pretty),
}
}
        // Text for people; scripts and MCP get the JSON reply.
    // rust: Some("logs") => match session.run(&args) {
    // rust: Ok(reply) => {
    // rust: print!("{}", reply["text"].as_str().unwrap_or_default());
    // rust: 0
}
    // rust: Err(f) => {
    // rust: print(&f.reply, pretty);
    // rust: f.status
}
    // rust: },
    // rust: Some(_) => match session.run(&args) {
    // rust: Ok(reply) => {
    // rust: print(&reply, pretty);
    // rust: 0
}
    // rust: Err(f) => {
    // rust: print(&f.reply, pretty);
    // rust: f.status
}
    // rust: },
}
    // rust: ExitCode::from(status)
}

    // rust: mod tests {
//     use super::*;

pub fn logs_reads_the_end_of_latest_log_and_the_newest_crash_report() void {
}
    // rust: let home = std::env::temp_dir().join(format!("horizon-ctl-logs-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&home);
    // rust: let words = |s: &str| -> Vec<String> { s.split_whitespace().map(String::from).collect() };
    // rust: let failure = logs(&home, &words("")).unwrap_err();
    // rust: assert!(
    // rust: failure.reply["error"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains("latest.log")
    // rust: );
    // rust: std::fs::create_dir_all(home.join("logs")).unwrap();
    // rust: let text: String = (1..=150)
    // rust: .map(|i| format!("[10:00:00] [Render thread/INFO]: line {i}\n"))
    // rust: .collect();
    // rust: std::fs::write(home.join("logs/latest.log"), text).unwrap();
    // rust: let reply = logs(&home, &words("")).unwrap();
    // rust: let tail = reply["text"].as_str().unwrap();
    // rust: assert_eq!(tail.lines().count(), 100);
    // rust: assert!(tail.starts_with("[10:00:00] [Render thread/INFO]: line 51\n"));
    // rust: assert!(tail.ends_with("line 150\n"));
    // rust: let reply = logs(&home, &words("--lines 2")).unwrap();
    // rust: assert_eq!(
    // rust: reply["text"],
    // rust: "[10:00:00] [Render thread/INFO]: line 149\n[10:00:00] [Render thread/INFO]: line 150\n"
    // rust: );
    // rust: assert_eq!(logs(&home, &words("--lines 0")).unwrap_err().status, USAGE);
    // rust: assert_eq!(logs(&home, &words("--tail")).unwrap_err().status, USAGE);
    // rust: assert!(logs(&home, &words("--crash")).is_err());
    // rust: std::fs::create_dir_all(home.join("crash-reports")).unwrap();
    // rust: std::fs::write(
    // rust: home.join("crash-reports/crash-2026-10-13_10.00.00-client.txt"),
    // rust: "old",
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: home.join("crash-reports/crash-2026-10-14_10.00.00-client.txt"),
    // rust: "new",
    // rust: )
    // rust: .unwrap();
    // rust: let reply = logs(&home, &words("--crash")).unwrap();
    // rust: assert_eq!(reply["text"], "new");
    // rust: let _ = std::fs::remove_dir_all(&home);
}

pub fn script_lines_split_like_a_shell() void {
}
    // rust: assert_eq!(
    // rust: split_line("goto 1 2 3 --near 2").unwrap(),
    // rust: ["goto", "1", "2", "3", "--near", "2"]
    // rust: );
    // rust: assert_eq!(
    // rust: split_line("click-button \"Create New World\"").unwrap(),
    // rust: ["click-button", "Create New World"]
    // rust: );
    // rust: assert_eq!(
    // rust: split_line("type 'it''s'  # comment").unwrap(),
    // rust: ["type", "its"]
    // rust: );
    // rust: assert_eq!(split_line("chat a\\ b").unwrap(), ["chat", "a b"]);
    // rust: assert_eq!(split_line("chat issue#4").unwrap(), ["chat", "issue#4"]);
    // rust: assert!(split_line("   # only a comment").unwrap().is_empty());
    // rust: assert!(split_line("type \"open").is_err());
}

    /// A fake game on a Unix socket: answers every line with `reply`, records the lines it got.
    // rust: fn fake_game(
    // rust: name: &str,
    // rust: reply: &'static str,
    // rust: ) -> (PathBuf, std::thread::JoinHandle<Vec<String>>) {
    // rust: let path = std::env::temp_dir().join(format!("hctl-{name}-{}.sock", std::process::id()));
    // rust: let _ = std::fs::remove_file(&path);
    // rust: let listener = std::os::unix::net::UnixListener::bind(&path).unwrap();
    // rust: let handle = std::thread::spawn(move || {
    // rust: let (stream, _) = listener.accept().unwrap();
    // rust: let mut lines = Vec::new();
    // rust: let mut reader = BufReader::new(stream.try_clone().unwrap());
    // rust: let mut out = stream;
    // rust: let mut line = String::new();
    // rust: while reader.read_line(&mut line).unwrap_or(0) > 0 {
    // rust: lines.push(line.trim_end().to_owned());
    // rust: line.clear();
    // rust: writeln!(out, "{reply}").unwrap();
}
    // rust: lines
    // rust: });
    // rust: (path, handle)
}

pub fn api_session(path: *Path, api: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Session::new(path.to_owned(), Some(Duration::from_secs(5)));
    // rust: s.home = std::env::temp_dir().join("horizon-ctl-api-no-home");
    // rust: s.api = Some(api.to_owned());
    // rust: s
}

pub fn api_line_matches_whole_parts() void {
}
    // rust: assert!(on_line("0.1.0", "0.1"));
    // rust: assert!(on_line("0.1.4", "0.1"));
    // rust: assert!(on_line("0.1.0", "0.1.0"));
    // rust: assert!(!on_line("0.1.0", "0.1.1"));
    // rust: assert!(!on_line("0.2.0", "0.1"));
    // rust: assert!(!on_line("0.10.0", "0.1"));
    // rust: assert!(!on_line("1.0.0", "0"));
    // rust: assert!(!on_line("0.1", "0.1.0"));
}

pub fn api_accepts_a_game_on_the_line() void {
}
    // rust: let (path, game) = fake_game(
    // rust: "match",
    // rust: r#"{"protocol":"0.1.0","release":"x","features":[]}"#,
    // rust: );
    // rust: let mut s = api_session(&path, "0.1");
    // rust: let reply = s.game("hello").unwrap();
    // rust: assert_eq!(reply["protocol"], "0.1.0");
    // rust: drop(s);
        // hello for the check, then the caller's own line.
    // rust: assert_eq!(game.join().unwrap(), ["hello", "hello"]);
    // rust: let _ = std::fs::remove_file(path);
}

pub fn api_refuses_a_game_on_another_line() void {
}
    // rust: let (path, game) = fake_game(
    // rust: "mismatch",
    // rust: r#"{"protocol":"0.2.0","release":"x","features":[]}"#,
    // rust: );
    // rust: let mut s = api_session(&path, "0.1");
    // rust: let f = s.game("state").unwrap_err();
    // rust: assert_eq!(f.status, API_MISMATCH);
    // rust: assert_eq!(f.reply["kind"], "api");
    // rust: let message = f.reply["error"].as_str().unwrap();
    // rust: assert!(
    // rust: message.contains("0.2.0") && message.contains("0.1"),
    // rust: "{message}"
    // rust: );
    // rust: drop(s);
        // The refused command never reached the game.
    // rust: assert_eq!(game.join().unwrap(), ["hello"]);
    // rust: let _ = std::fs::remove_file(path);
}

pub fn api_refuses_a_game_with_no_protocol_line() void {
}
    // rust: let (path, game) = fake_game("old", r#"{"error":"unknown command hello"}"#);
    // rust: let mut s = api_session(&path, "0.1");
    // rust: let f = s.game("state").unwrap_err();
    // rust: assert_eq!(f.status, API_MISMATCH);
    // rust: assert!(
    // rust: f.reply["error"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains("predates hello")
    // rust: );
    // rust: drop(s);
    // rust: assert_eq!(game.join().unwrap(), ["hello"]);
    // rust: let _ = std::fs::remove_file(path);
}

pub fn without_api_the_game_is_not_asked_hello() void {
}
    // rust: let (path, game) = fake_game("noapi", r#"{"ok":true}"#);
    // rust: let mut s = Session::new(path.clone(), Some(Duration::from_secs(5)));
    // rust: s.game("state").unwrap();
    // rust: drop(s);
    // rust: assert_eq!(game.join().unwrap(), ["state"]);
    // rust: let _ = std::fs::remove_file(path);
}

pub fn unreachable_games_fail_with_status_3() void {
}
    // rust: let home =
    // rust: std::env::temp_dir().join(format!("horizon-ctl-unreachable-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&home).unwrap();
    // rust: let mut s = Session::new(home.join("nobody.sock"), None);
    // rust: s.home = home.clone();
    // rust: let f = s.run(&["state".to_owned()]).unwrap_err();
    // rust: assert_eq!(f.status, UNREACHABLE);
    // rust: assert_eq!(f.reply["kind"], "connection");
    // rust: let f = s.run(&["sleep".to_owned(), "x".to_owned()]).unwrap_err();
    // rust: assert_eq!(f.status, USAGE);
    // rust: std::fs::remove_dir_all(home).unwrap();
}

pub fn no_ai_refuses_every_command() void {
}
    // rust: let home = std::env::temp_dir().join(format!("horizon-ctl-no-ai-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&home);
    // rust: let mut s = Session::new(std::env::temp_dir().join("horizon-ctl-nobody.sock"), None);
    // rust: s.home = home.clone();
    // rust: assert_eq!(
    // rust: s.run(&["state".to_owned()]).unwrap_err().status,
    // rust: UNREACHABLE
    // rust: );
    // rust: horizon_core::no_ai::set(&home, true).unwrap();
    // rust: for words in [vec!["state"], vec!["logs"], vec!["launch", "--world", "A"]] {
    // rust: let words: Vec<String> = words.into_iter().map(str::to_owned).collect();
    // rust: let f = s.run(&words).unwrap_err();
    // rust: assert_eq!(f.status, DENIED, "{words:?}");
    // rust: assert_eq!(f.reply["kind"], "denied");
    // rust: assert_eq!(f.reply["error"], horizon_core::no_ai::REFUSAL);
}
    // rust: let _ = std::fs::remove_dir_all(&home);
}

pub fn screenshot_paths_become_absolute() void {
}
    // rust: let mut words = vec!["screenshot".to_owned(), "a.png".to_owned()];
    // rust: absolute_paths(&mut words);
    // rust: assert!(Path::new(&words[1]).is_absolute());
}
}
