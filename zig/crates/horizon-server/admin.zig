//! Transpiled from Horizon Rust crate
//! Module: horizon-server_admin
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The control API's admin endpoints (docs/api/server.md): who is online and on vanilla's lists, the
//! moderation actions, and the metrics as text for a monitoring tool.
//!
//! An action runs the vanilla console command on the running game (kick, ban, ban-ip, pardon, pardon-ip,
//! op, deop, whitelist), so it does exactly what an operator's command does, kicks included. The reply has
//! the console's lines and `changed`: whether the list file (or, for a kick, who is online) changed.

// use crate::{
    // rust: api::{Phase, Shared},
    // rust: engine,
    // rust: http::Response,
}
// use horizon_server_files::user_lists::{
    // rust: BanList, IpBanList, OpList, UserList, WhiteList, format_date,
}
// use serde_json::{Value, json};
// use std::{fmt::Write, path::Path, sync::Mutex};

/// One action at a time, so `changed` compares the files around this action only.
pub const ACTING: Mutex<()> = Mutex::new(());

/// The longest reason taken (vanilla's chat line is 256).
pub const MAX_REASON: usize = 256;

/// A moderation action: its console command and the file it changes.
pub const Action = enum {
    Kick,
    Ban,
    Pardon,
    BanIp,
    PardonIp,
    Op,
    Deop,
    WhitelistAdd,
    WhitelistRemove,
    Whitelist,
};

    // rust: impl Action {
    /// The file whose change says the action did something (none for a kick).
pub fn file(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Kick => None,
    // rust: Self::Ban | Self::Pardon => Some("banned-players.json"),
    // rust: Self::BanIp | Self::PardonIp => Some("banned-ips.json"),
    // rust: Self::Op | Self::Deop => Some("ops.json"),
    // rust: Self::WhitelistAdd | Self::WhitelistRemove => Some("whitelist.json"),
    // rust: Self::Whitelist => Some("server.properties"),
}
}

    /// The console line for a request body, or what is wrong with it.
pub fn line(self: *Self, body: *Value) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = || {
    // rust: let name = body["name"].as_str().unwrap_or_default();
    // rust: if (1..=16).contains(&name.chars().count())
    // rust: && name.chars().all(|c| !c.is_whitespace() && !c.is_control())
    // rust: {
    // rust: Ok(name)
    // rust: } else {
    // rust: Err(
    // rust: "the body needs \"name\": a player's name (1 to 16 characters, no spaces)"
    // rust: .to_owned(),
    // rust: )
}
}
    // rust: let ip = || {
    // rust: body["ip"]
    // rust: .as_str()
    // rust: .filter(|ip| ip.parse::<std::net::IpAddr>().is_ok())
    // rust: .ok_or_else(|| "the body needs \"ip\": an IPv4 or IPv6 address".to_owned())
}
    // rust: let reason = || match body["reason"].as_str().map(str::trim) {
    // rust: None | Some("") => Ok(String::new()),
    // rust: Some(r) if r.chars().count() <= MAX_REASON && !r.chars().any(char::is_control) => {
    // rust: Ok(format!(" {r}"))
}
    // rust: Some(_) => Err(format!(
    // rust: "\"reason\" is one line of at most {MAX_REASON} characters"
    // rust: )),
}
    // rust: Ok(match self {
    // rust: Self::Kick => format!("kick {}{}", name()?, reason()?),
    // rust: Self::Ban => format!("ban {}{}", name()?, reason()?),
    // rust: Self::Pardon => format!("pardon {}", name()?),
            // An online player's name bans the address they play from, as vanilla's /ban-ip does.
    // rust: Self::BanIp => format!("ban-ip {}{}", ip().or_else(|_| name())?, reason()?),
    // rust: Self::PardonIp => format!("pardon-ip {}", ip()?),
    // rust: Self::Op => format!("op {}", name()?),
    // rust: Self::Deop => format!("deop {}", name()?),
    // rust: Self::WhitelistAdd => format!("whitelist add {}", name()?),
    // rust: Self::WhitelistRemove => format!("whitelist remove {}", name()?),
    // rust: Self::Whitelist => match body["enabled"].as_bool() {
    // rust: Some(true) => "whitelist on".into(),
    // rust: Some(false) => "whitelist off".into(),
    // rust: None => return Err("the body needs \"enabled\": true or false".into()),
    // rust: },
    // rust: })
}
}

pub fn running(shared: *Shared) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if shared.state.lock().unwrap().phase != Phase::Running {
    // rust: return Err(Response::error(409, "the game isn't running right now"));
}
    // rust: engine::Control::connect(&shared.dir)
    // rust: .map_err(|e| Response::error(409, &format!("the game didn't answer: {e}")))
}

/// The online players the game reports (`server-status`).
pub fn online(game: *mut engine::Control) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: game.ask("server-status")
    // rust: .map_err(|e| Response::error(409, &format!("the game didn't answer: {e}")))
}

/// `POST /api/v1/players/<action>` and `/api/v1/whitelist[/...]`.
pub fn act(shared: *Shared, action: Action, body: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let body: Value = serde_json::from_slice(body).unwrap_or(Value::Null);
    // rust: let line = match action.line(&body) {
    // rust: Ok(line) => line,
    // rust: Err(e) => return Response::error(400, &e),
}
    // rust: if shared.phase() == Phase::Stopped
    // rust: && let Some((command, args)) = stopped_command(action, &body)
    // rust: {
    // rust: return match crate::lists::edit_stopped(&shared.dir, command, &args) {
    // rust: Ok(edit) => Response::json(
    // rust: 200,
    // rust: &json!({ "changed": edit.changed, "output": [edit.message] }),
    // rust: ),
    // rust: Err(e) => Response::error(409, &e),
}
}
    // rust: let mut game = match running(shared) {
    // rust: Ok(game) => game,
    // rust: Err(response) => return response,
}
    // rust: let _one = ACTING.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let read = |file: &str| std::fs::read(shared.dir.join(file)).ok();
    // rust: let before = match action.file() {
    // rust: Some(file) => read(file),
    // rust: None => {
    // rust: let status = match online(&mut game) {
    // rust: Ok(status) => status,
    // rust: Err(response) => return response,
}
    // rust: let name = body["name"].as_str().unwrap_or_default();
    // rust: let here = status["players"].as_array().into_iter().flatten().any(|p| {
    // rust: p["name"]
    // rust: .as_str()
    // rust: .is_some_and(|n| n.eq_ignore_ascii_case(name))
    // rust: });
    // rust: Some(vec![u8::from(here)])
}
}
    // rust: let reply = match game.ask(&format!("console {line}")) {
    // rust: Ok(reply) => reply,
    // rust: Err(e) => return Response::error(409, &format!("the game didn't answer: {e}")),
}
    // rust: let changed = match action.file() {
    // rust: Some(file) => read(file) != before,
    // rust: None => before == Some(vec![1]),
}
    // rust: crate::supervisor::note(shared, "INFO", &format!("Control API: {line}"));
    // rust: Response::json(
    // rust: 200,
    // rust: &json!({ "changed": changed, "output": reply["output"] }),
    // rust: )
}

/// The actions that can edit files without a game process.
pub fn stopped_command(action: Action, body: *Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match action {
    // rust: Action::Op => Some(("op", vec![body["name"].as_str()?])),
    // rust: Action::Deop => Some(("deop", vec![body["name"].as_str()?])),
    // rust: Action::WhitelistAdd => Some(("whitelist", vec!["add", body["name"].as_str()?])),
    // rust: Action::WhitelistRemove => Some(("whitelist", vec!["remove", body["name"].as_str()?])),
    // rust: Action::Whitelist => Some((
    // rust: "whitelist",
    // rust: vec![if body["enabled"].as_bool()? {
    // rust: "on"
    // rust: } else {
    // rust: "off"
    // rust: }],
    // rust: )),
    // rust: _ => None,
}
}

/// A list from its file in the server folder; missing or broken reads as empty, as the game would start.
    // rust: fn load<E: horizon_server_files::user_lists::Entry>(dir: &Path, file: &str) -> UserList<E> {
    // rust: let mut list = UserList::new(dir.join(file));
    // rust: let _ = list.load();
    // rust: list
}

/// `GET /api/v1/mods`: the native mods the game program was built with. The launcher writes them to
/// `native-mods.json` beside a build it makes; a release or Nightly has none, so the list is empty.
pub fn mods(shared: *Shared) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let built = crate::config::Config::load(&shared.dir)
    // rust: .ok()
    // rust: .and_then(|c| engine::program_in(&c, &shared.dir, shared.install.as_ref()).ok())
    // rust: .and_then(|p| std::fs::read_to_string(p.with_file_name("native-mods.json")).ok());
    // rust: Response::json(200, &built_with(built.as_deref()))
}

/// [`mods`]' answer for the text of a `native-mods.json` (None: no program, or no such file).
pub fn built_with(built: ?[]const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let info: Value = built
    // rust: .and_then(|b| serde_json::from_str(b).ok())
    // rust: .unwrap_or(Value::Null);
    // rust: let native: Vec<Value> = info["mods"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|m| json!({ "id": m["id"], "version": m["version"], "sha256": m["sha256"] }))
    // rust: .collect();
    // rust: json!({
    // rust: "engine": {
    // rust: "found": built.is_some(),
    // rust: "target": info["target"],
    // rust: "base": info["base"],
    // rust: "horizon": info["horizon"],
    // rust: "hooks": info["hooks"],
    // rust: },
    // rust: "native": native,
    // rust: })
}

/// `GET /api/v1/players`: who is online, and vanilla's lists.
pub fn players(shared: *Shared) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = &shared.dir;
    // rust: let game = match running(shared) {
    // rust: Ok(mut game) => online(&mut game).ok(),
    // rust: Err(_) => None,
}
    // rust: let ops: OpList = load(dir, "ops.json");
    // rust: let ops: Vec<Value> = ops
    // rust: .entries()
    // rust: .iter()
    // rust: .map(|e| json!({ "name": e.user.name, "uuid": uuid(e.user.id), "level": e.level }))
    // rust: .collect();
    // rust: let op_level = |id: &str| {
    // rust: ops.iter()
    // rust: .find(|o| o["uuid"] == id)
    // rust: .map(|o| o["level"].clone())
}
    // rust: let online: Vec<Value> = game
    // rust: .as_ref()
    // rust: .and_then(|g| g["players"].as_array())
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|p| {
    // rust: let mut p = p.clone();
    // rust: p["op_level"] = op_level(p["uuid"].as_str().unwrap_or_default()).unwrap_or(json!(0));
    // rust: p
    // rust: })
    // rust: .collect();
    // rust: let white: WhiteList = load(dir, "whitelist.json");
    // rust: let bans: BanList = load(dir, "banned-players.json");
    // rust: let ip_bans: IpBanList = load(dir, "banned-ips.json");
    // rust: let ban = |created: i64, source: &str, expires: Option<i64>, reason: &Option<String>| {
    // rust: json!({
    // rust: "created": format_date(created),
    // rust: "source": source,
    // rust: "expires": expires.map(format_date),
    // rust: "reason": reason,
    // rust: })
}
    // rust: Response::json(
    // rust: 200,
    // rust: &json!({
    // rust: "online": online,
    // rust: "max_players": game.as_ref().map(|g| g["max_players"].clone()),
    // rust: "ops": ops,
    // rust: "whitelist": {
    // rust: "enabled": whitelist_on(dir),
    // rust: "players": white.entries().iter()
    // rust: .map(|e| json!({ "name": e.user.name, "uuid": uuid(e.user.id) }))
    // rust: .collect::<Vec<_>>(),
    // rust: },
    // rust: "bans": bans.entries().iter().map(|b| {
    // rust: let mut v = ban(b.created, &b.source, b.expires, &b.reason);
    // rust: v["name"] = json!(b.user.name);
    // rust: v["uuid"] = json!(uuid(b.user.id));
    // rust: v
    // rust: }).collect::<Vec<_>>(),
    // rust: "ip_bans": ip_bans.entries().iter().map(|b| {
    // rust: let mut v = ban(b.created, &b.source, b.expires, &b.reason);
    // rust: v["ip"] = json!(b.user);
    // rust: v
    // rust: }).collect::<Vec<_>>(),
    // rust: }),
    // rust: )
}

/// A UUID as the lists and the game write it (8-4-4-4-12 hex digits).
pub fn uuid(id: u128) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let h = format!("{id:032x}");
    // rust: format!(
    // rust: "{}-{}-{}-{}-{}",
    // rust: &h[..8],
    // rust: &h[8..12],
    // rust: &h[12..16],
    // rust: &h[16..20],
    // rust: &h[20..]
    // rust: )
}

/// Whether the whitelist is on: the game writes `white-list` to server.properties when `/whitelist on|off`
/// changes it; server.toml catches up when it stops.
pub fn whitelist_on(dir: *Path) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::fs::read(dir.join(crate::config::PROPERTIES))
    // rust: .ok()
    // rust: .and_then(|b| horizon_server_files::java_properties::Properties::load_file(&b).ok())
    // rust: .and_then(|p| p.get("white-list").map(|v| v == "true"))
    // rust: .or_else(|| {
    // rust: crate::config::Config::load(dir)
    // rust: .ok()
    // rust: .map(|c| c.server.whitelist)
    // rust: })
    // rust: .unwrap_or(false)
}

/// `GET /api/v1/metrics/prometheus`: the latest sample in Prometheus's text format, for any monitoring
/// tool that scrapes it.
pub fn prometheus(shared: *Shared) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (phase, crashes, sample) = {
    // rust: let state = shared.state.lock().unwrap();
    // rust: (state.phase, state.crashes, state.sample.clone())
}
    // rust: let game = &sample["game"];
    // rust: let mut out = String::new();
    // rust: let mut gauge = |name: &str, help: &str, values: &[(&str, Option<f64>)]| {
    // rust: if values.iter().all(|(_, v)| v.is_none()) {
    // rust: return;
}
    // rust: let _ = writeln!(
    // rust: out,
    // rust: "# HELP horizon_{name} {help}\n# TYPE horizon_{name} gauge"
    // rust: );
    // rust: for (labels, value) in values {
    // rust: if let Some(value) = value {
    // rust: let _ = writeln!(out, "horizon_{name}{labels} {value}");
}
}
}
    // rust: let f = |v: &Value| v.as_f64();
    // rust: gauge(
    // rust: "up",
    // rust: "1 while the game runs and answers",
    // rust: &[(
    // rust: "",
    // rust: Some(f64::from(u8::from(
    // rust: phase == Phase::Running && !game.is_null(),
    // rust: ))),
    // rust: )],
    // rust: );
    // rust: gauge(
    // rust: "supervisor_uptime_seconds",
    // rust: "Seconds since horizon-server started",
    // rust: &[("", Some(shared.started.elapsed().as_secs() as f64))],
    // rust: );
    // rust: gauge(
    // rust: "crashes",
    // rust: "Game crashes since horizon-server started",
    // rust: &[("", Some(f64::from(crashes)))],
    // rust: );
    // rust: gauge(
    // rust: "tps",
    // rust: "Ticks per second over the last 5 seconds",
    // rust: &[("", f(&game["tps"]))],
    // rust: );
    // rust: gauge(
    // rust: "tps_target",
    // rust: "The tick rate the game aims for (/tick rate)",
    // rust: &[("", f(&game["target_tps"]))],
    // rust: );
    // rust: gauge(
    // rust: "mspt",
    // rust: "Milliseconds per tick: the average and the percentiles /tick query reports",
    // rust: &[
    // rust: ("{stat=\"average\"}", f(&game["mspt"]["average"])),
    // rust: ("{stat=\"p50\"}", f(&game["mspt"]["p50"])),
    // rust: ("{stat=\"p95\"}", f(&game["mspt"]["p95"])),
    // rust: ("{stat=\"p99\"}", f(&game["mspt"]["p99"])),
    // rust: ],
    // rust: );
    // rust: gauge(
    // rust: "players_online",
    // rust: "Players online",
    // rust: &[("", game["players"].as_array().map(|p| p.len() as f64))],
    // rust: );
    // rust: gauge(
    // rust: "players_max",
    // rust: "max-players",
    // rust: &[("", f(&game["max_players"]))],
    // rust: );
    // rust: gauge(
    // rust: "chunks_loaded",
    // rust: "Chunks loaded",
    // rust: &[("", f(&game["chunks"]))],
    // rust: );
    // By dimension, from the game's `levels`; a level the game does not count is left out, not
    // reported as 0.
    // rust: let by_dimension = |key: &str| -> Vec<(String, Option<f64>)> {
    // rust: game["levels"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|level| {
    // rust: let dimension = level["dimension"].as_str()?;
    // rust: Some((format!("{{dimension=\"{dimension}\"}}"), f(&level[key])))
    // rust: })
    // rust: .collect()
}
    // rust: for (name, help, key) in [
    // rust: ("loaded_chunks", "Chunks loaded, by dimension", "chunks"),
    // rust: (
    // rust: "entities",
    // rust: "Entities (players and block entities apart), by dimension",
    // rust: "entities",
    // rust: ),
    // rust: ] {
    // rust: let values = by_dimension(key);
    // rust: let values: Vec<(&str, Option<f64>)> =
    // rust: values.iter().map(|(l, v)| (l.as_str(), *v)).collect();
    // rust: gauge(name, help, &values);
}
    // rust: gauge(
    // rust: "memory_rss_bytes",
    // rust: "The game process's resident memory",
    // rust: &[("", f(&sample["rss_bytes"]))],
    // rust: );
    // rust: gauge(
    // rust: "cpu_percent",
    // rust: "The game process's CPU use (100 = one core)",
    // rust: &[("", f(&sample["cpu_percent"]))],
    // rust: );
    // rust: Response::text(200, "text/plain; version=0.0.4", out)
}

    // rust: mod tests {
//     use super::*;

pub fn actions_become_console_lines() void {
}
    // rust: let line = |a: Action, body: Value| a.line(&body);
    // rust: assert_eq!(
    // rust: line(Action::Kick, json!({ "name": "Kim0" })).unwrap(),
    // rust: "kick Kim0"
    // rust: );
    // rust: assert_eq!(
    // rust: line(
    // rust: Action::Ban,
    // rust: json!({ "name": "Lou0", "reason": " cheating " })
    // rust: )
    // rust: .unwrap(),
    // rust: "ban Lou0 cheating"
    // rust: );
    // rust: assert_eq!(
    // rust: line(
    // rust: Action::BanIp,
    // rust: json!({ "ip": "203.0.113.7", "reason": "spam bots" })
    // rust: )
    // rust: .unwrap(),
    // rust: "ban-ip 203.0.113.7 spam bots"
    // rust: );
    // rust: assert_eq!(
    // rust: line(Action::BanIp, json!({ "name": "Kim0" })).unwrap(),
    // rust: "ban-ip Kim0"
    // rust: );
    // rust: assert_eq!(
    // rust: line(Action::PardonIp, json!({ "ip": "::1" })).unwrap(),
    // rust: "pardon-ip ::1"
    // rust: );
    // rust: assert_eq!(
    // rust: line(Action::WhitelistAdd, json!({ "name": "Opal" })).unwrap(),
    // rust: "whitelist add Opal"
    // rust: );
    // rust: assert_eq!(
    // rust: line(Action::Whitelist, json!({ "enabled": false })).unwrap(),
    // rust: "whitelist off"
    // rust: );
        // Nothing can add a word or a second line to the command.
    // rust: assert!(line(Action::Ban, json!({ "name": "a b" })).is_err());
    // rust: assert!(line(Action::Op, json!({ "name": "" })).is_err());
    // rust: assert!(line(Action::Op, json!({ "name": "seventeen_letters" })).is_err());
    // rust: assert!(line(Action::Kick, json!({ "name": "Kim0", "reason": "a\nstop" })).is_err());
    // rust: assert!(line(Action::PardonIp, json!({ "ip": "Kim0" })).is_err());
    // rust: assert!(line(Action::Whitelist, json!({})).is_err());
}

pub fn stopped_actions_edit_file_backed_lists() void {
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-admin-stopped-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(crate::config::FILE), crate::config::TEMPLATE).unwrap();
    // rust: crate::config::update(&dir, "server", "online_mode", toml::Value::Boolean(false)).unwrap();
    // rust: crate::config::update(&dir, "server", "whitelist", toml::Value::Boolean(false)).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Stopped);

    // rust: let call = |action, body| {
    // rust: let response = act(&shared, action, body);
    // rust: assert_eq!(response.status, 200, "{}", response.body);
    // rust: serde_json::from_str::<Value>(&response.body).unwrap()
}
    // rust: assert_eq!(
    // rust: call(Action::Op, br#"{"name":"Alex"}"#),
    // rust: json!({ "changed": true, "output": ["Made Alex a server operator"] })
    // rust: );
    // rust: assert_eq!(
    // rust: call(Action::WhitelistAdd, br#"{"name":"Alex"}"#),
    // rust: json!({ "changed": true, "output": ["Added Alex to the whitelist"] })
    // rust: );
    // rust: assert_eq!(
    // rust: call(Action::Whitelist, br#"{"enabled":true}"#),
    // rust: json!({ "changed": true, "output": ["Whitelist is now turned on"] })
    // rust: );
    // rust: assert_eq!(
    // rust: call(Action::Deop, br#"{"name":"Alex"}"#),
    // rust: json!({ "changed": true, "output": ["Made Alex no longer a server operator"] })
    // rust: );
    // rust: assert_eq!(
    // rust: call(Action::WhitelistRemove, br#"{"name":"Alex"}"#),
    // rust: json!({ "changed": true, "output": ["Removed Alex from the whitelist"] })
    // rust: );
    // rust: assert!(
    // rust: !std::fs::read_to_string(dir.join("ops.json"))
    // rust: .unwrap()
    // rust: .contains("Alex")
    // rust: );
    // rust: assert!(
    // rust: !std::fs::read_to_string(dir.join("whitelist.json"))
    // rust: .unwrap()
    // rust: .contains("Alex")
    // rust: );
    // rust: assert!(crate::config::Config::load(&dir).unwrap().server.whitelist);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn moderation_reply(response: Response) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert!(response.stream.is_none());
    // rust: json!({
    // rust: "status": response.status,
    // rust: "content_type": response.content_type,
    // rust: "headers": response.headers,
    // rust: "body": serde_json::from_str::<Value>(&response.body).unwrap(),
    // rust: })
}

pub fn moderation_replies_match_api_v1_goldens() void {
}
    // rust: let golden: Value =
    // rust: serde_json::from_str(include_str!("../testdata/api-v1-moderation.json")).unwrap();
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-api-moderation-goldens-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(crate::config::FILE), crate::config::TEMPLATE).unwrap();
    // rust: crate::config::update(&dir, "server", "online_mode", toml::Value::Boolean(false)).unwrap();
    // rust: crate::config::update(&dir, "server", "whitelist", toml::Value::Boolean(false)).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Stopped);
    // rust: let call = |path: &str, body: &[u8]| {
    // rust: moderation_reply(crate::api::route(
    // rust: &shared,
    // rust: &crate::http::Request {
    // rust: method: "POST".into(),
    // rust: path: path.into(),
    // rust: query: String::new(),
    // rust: headers: Vec::new(),
    // rust: body: body.to_vec(),
    // rust: },
    // rust: ))
}
    // rust: let check = |case: &str, path: &str, body: &[u8]| {
    // rust: assert_eq!(call(path, body), golden[case], "{case}");
}

    // rust: check("op", "/api/v1/players/op", br#"{"name":"Alex"}"#);
    // rust: check("op_again", "/api/v1/players/op", br#"{"name":"Alex"}"#);
    // rust: check("deop", "/api/v1/players/deop", br#"{"name":"Alex"}"#);
    // rust: check("deop_again", "/api/v1/players/deop", br#"{"name":"Alex"}"#);
    // rust: check(
    // rust: "whitelist_add",
    // rust: "/api/v1/whitelist/add",
    // rust: br#"{"name":"Alex"}"#,
    // rust: );
    // rust: check(
    // rust: "whitelist_add_again",
    // rust: "/api/v1/whitelist/add",
    // rust: br#"{"name":"Alex"}"#,
    // rust: );
    // rust: check("whitelist_on", "/api/v1/whitelist", br#"{"enabled":true}"#);
    // rust: check(
    // rust: "whitelist_on_again",
    // rust: "/api/v1/whitelist",
    // rust: br#"{"enabled":true}"#,
    // rust: );
    // rust: check(
    // rust: "whitelist_remove",
    // rust: "/api/v1/whitelist/remove",
    // rust: br#"{"name":"Alex"}"#,
    // rust: );
    // rust: check(
    // rust: "whitelist_remove_again",
    // rust: "/api/v1/whitelist/remove",
    // rust: br#"{"name":"Alex"}"#,
    // rust: );
    // rust: for (case, path, body) in [
    // rust: (
    // rust: "kick_stopped",
    // rust: "/api/v1/players/kick",
    // rust: br#"{"name":"Alex"}"#.as_slice(),
    // rust: ),
    // rust: (
    // rust: "ban_stopped",
    // rust: "/api/v1/players/ban",
    // rust: br#"{"name":"Alex"}"#.as_slice(),
    // rust: ),
    // rust: (
    // rust: "pardon_stopped",
    // rust: "/api/v1/players/pardon",
    // rust: br#"{"name":"Alex"}"#.as_slice(),
    // rust: ),
    // rust: (
    // rust: "ban_ip_stopped",
    // rust: "/api/v1/players/ban-ip",
    // rust: br#"{"ip":"203.0.113.7"}"#.as_slice(),
    // rust: ),
    // rust: (
    // rust: "pardon_ip_stopped",
    // rust: "/api/v1/players/pardon-ip",
    // rust: br#"{"ip":"203.0.113.7"}"#.as_slice(),
    // rust: ),
    // rust: ] {
    // rust: check(case, path, body);
}
    // rust: check("malformed", "/api/v1/players/op", b"not json");
    // rust: check("bad_name", "/api/v1/players/op", br#"{"name":"a b"}"#);
    // rust: check(
    // rust: "bad_reason",
    // rust: "/api/v1/players/kick",
    // rust: br#"{"name":"Alex","reason":"first\nsecond"}"#,
    // rust: );
    // rust: check("bad_ip", "/api/v1/players/pardon-ip", br#"{"ip":"Alex"}"#);
    // rust: check("bad_whitelist", "/api/v1/whitelist", br#"{}"#);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn mods_come_from_the_build_record() void {
}
    // rust: let none = built_with(None);
    // rust: assert_eq!(
    // rust: (none["engine"]["found"].clone(), none["native"].clone()),
    // rust: (json!(false), json!([]))
    // rust: );
    // rust: let record = r#"{"base":"v1","horizon":"abc","target":"server","hooks":326,"mods":[{"id":"m","version":"1.0","sha256":"ff"}]}"#;
    // rust: let some = built_with(Some(record));
    // rust: assert_eq!(some["engine"]["target"], "server");
    // rust: assert_eq!(some["engine"]["found"], true);
    // rust: assert_eq!(
    // rust: some["native"],
    // rust: json!([{ "id": "m", "version": "1.0", "sha256": "ff" }])
    // rust: );
        // A release has no record's mods; a broken file is no mods.
    // rust: assert_eq!(built_with(Some("{}"))["native"], json!([]));
    // rust: assert_eq!(built_with(Some("nope"))["native"], json!([]));
}

pub fn players_and_metrics_without_a_game() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-admin-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(
    // rust: dir.join("banned-players.json"),
    // rust: r#"[{"uuid":"00000000-0000-0000-0000-000000000001","name":"Lou0","created":"2026-10-31 12:00:00 +0000","source":"Server","expires":"forever","reason":"cheating"}]"#,
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(dir.join("server.properties"), "white-list=true\n").unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: let players: Value = serde_json::from_str(&players(&shared).body).unwrap();
    // rust: assert_eq!(players["online"], json!([]));
    // rust: assert_eq!(players["whitelist"]["enabled"], true);
    // rust: assert_eq!(players["bans"][0]["name"], "Lou0");
    // rust: assert_eq!(players["bans"][0]["reason"], "cheating");
    // rust: assert_eq!(players["bans"][0]["expires"], Value::Null);
    // rust: let text = prometheus(&shared).body;
    // rust: assert!(
    // rust: text.contains("# TYPE horizon_up gauge\nhorizon_up 0\n"),
    // rust: "{text}"
    // rust: );
    // rust: assert!(!text.contains("horizon_tps "), "no game, no TPS: {text}");
    // rust: shared.state.lock().unwrap().sample = json!({
    // rust: "rss_bytes": 1000, "cpu_percent": 12.5,
    // rust: "game": { "tps": 20.0, "mspt": { "average": 3.5, "p50": 3.0, "p95": 6.0, "p99": 9.0 },
    // rust: "players": [{ "name": "Kim0" }], "max_players": 20, "chunks": 441 },
    // rust: });
    // rust: let text = prometheus(&shared).body;
    // rust: for line in [
    // rust: "horizon_tps 20\n",
    // rust: "horizon_mspt{stat=\"p95\"} 6\n",
    // rust: "horizon_players_online 1\n",
    // rust: "horizon_memory_rss_bytes 1000\n",
    // rust: ] {
    // rust: assert!(text.contains(line), "{line} in {text}");
}
    // rust: assert!(
    // rust: !text.contains("horizon_entities"),
    // rust: "no levels, no counts: {text}"
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn chunks_and_entities_are_reported_by_dimension() void {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-levels-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.state.lock().unwrap().sample = json!({
    // rust: "game": { "tps": 20.0, "chunks": 441, "levels": [
    // rust: { "dimension": "minecraft:overworld", "chunks": 441, "entities": 37 },
    // rust: { "dimension": "minecraft:the_nether", "chunks": 25, "entities": 0 },
    // rust: { "dimension": "minecraft:the_end" },
    // rust: ] },
    // rust: });
    // rust: let text = prometheus(&shared).body;
    // rust: for line in [
    // rust: "# TYPE horizon_loaded_chunks gauge
    // rust: ",
    // rust: "horizon_loaded_chunks{dimension=\"minecraft:overworld\"} 441
    // rust: ",
    // rust: "horizon_loaded_chunks{dimension=\"minecraft:the_nether\"} 25
    // rust: ",
    // rust: "# TYPE horizon_entities gauge
    // rust: ",
    // rust: "horizon_entities{dimension=\"minecraft:overworld\"} 37
    // rust: ",
    // rust: "horizon_entities{dimension=\"minecraft:the_nether\"} 0
    // rust: ",
    // rust: ] {
    // rust: assert!(text.contains(line), "{line} in {text}");
}
        // A level the game gave no count for has no line, rather than a 0.
    // rust: assert!(!text.contains("the_end"), "{text}");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
