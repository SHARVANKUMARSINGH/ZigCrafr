//! Transpiled from Horizon Rust crate
//! Module: horizon-server_settings
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-server config`: read server.toml's settings, and change them the way the server checks them
//! (docs/server.md, section 4). A running server takes what vanilla can change live through its console
//! (difficulty, the default game mode, the whitelist) and through its management settings (the message of the
//! day, the player limit) at once; the rest applies at the next start.

// use crate::{api::Client, config, engine};
// use serde_json::{Value, json};
// use std::path::Path;

/// `config [--json]` and `config set KEY=VALUE... [--json]`.
pub fn command(dir: *Path, args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let as_json = args.iter().any(|a| a == "--json");
    // rust: let args: Vec<&str> = args
    // rust: .iter()
    // rust: .map(String::as_str)
    // rust: .filter(|a| *a != "--json")
    // rust: .collect();
    // rust: match args.as_slice() {
    // rust: [] => show(dir, as_json),
    // rust: ["set", changes @ ..] if !changes.is_empty() => {
    // rust: let outcome = set(dir, changes)?;
    // rust: if as_json {
    // rust: println!("{}", outcome.to_json());
    // rust: } else {
    // rust: print!("{}", outcome.describe());
}
    // rust: Ok(())
}
    // rust: _ => Err(
    // rust: "config takes no arguments, or `set KEY=VALUE...` (for example: config set world.difficulty=hard)"
    // rust: .into(),
    // rust: ),
}
}

pub fn show(dir: *Path, as_json: bool) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let table = shown(dir)?;
    // rust: if as_json {
    // rust: println!("{table}");
    // rust: return Ok(());
}
    // rust: for (section, values) in table.as_object().into_iter().flatten() {
    // rust: for (key, value) in values.as_object().into_iter().flatten() {
    // rust: println!("{section}.{key} = {value}");
}
}
    // rust: Ok(())
}

/// What `config set` did.
pub const Outcome = struct {
    /// Every setting written to server.toml.
    saved: std.ArrayList([]const u8),
    /// Those the running server took at once.
    applied: std.ArrayList([]const u8),
    /// Those that wait for the game's next start, while it runs.
    restart: std.ArrayList([]const u8),
    running: bool,
};

    // rust: impl Outcome {
pub fn to_json(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "saved": self.saved,
    // rust: "applied": self.applied,
    // rust: "restart": self.restart,
    // rust: "running": self.running,
    // rust: })
}

pub fn describe(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.running {
    // rust: return format!(
    // rust: "Saved {}: the server uses them from its next start.\n",
    // rust: self.saved.join(", ")
    // rust: );
}
    // rust: let mut out = String::new();
    // rust: if !self.applied.is_empty() {
    // rust: out += &format!("Applied now: {}\n", self.applied.join(", "));
}
    // rust: if !self.restart.is_empty() {
    // rust: out += &format!(
    // rust: "Saved; restart the server to apply: {} (`horizon-server restart`)\n",
    // rust: self.restart.join(", ")
    // rust: );
}
    // rust: out
}
}

/// One `KEY=VALUE`: the section, the field and the value as server.toml types it.
    // rust: pub fn parse_change(
    // rust: current: &toml::Table,
    // rust: change: &str,
    // rust: ) -> Result<(String, String, toml::Value), String> {
    // rust: let (key, text) = change
    // rust: .split_once('=')
    // rust: .ok_or_else(|| format!("{change:?}: write KEY=VALUE, like world.difficulty=hard"))?;
    // rust: let (section, field) = key
    // rust: .trim()
    // rust: .split_once('.')
    // rust: .ok_or_else(|| format!("{key:?}: name a setting as section.name, like server.port"))?;
    // rust: let text = text.trim();
    // rust: let value = if section == "properties" {
    // rust: config::loose_value(text)
    // rust: } else {
    // rust: let like = current
    // rust: .get(section)
    // rust: .and_then(|s| s.get(field))
    // rust: .ok_or_else(|| {
    // rust: format!("{key} is not a setting (`horizon-server config` lists them)")
    // rust: })?;
    // rust: match like {
    // rust: toml::Value::Boolean(_) => toml::Value::Boolean(match text {
    // rust: "true" | "on" | "yes" => true,
    // rust: "false" | "off" | "no" => false,
    // rust: _ => return Err(format!("{key} is on or off: use true or false")),
    // rust: }),
    // rust: toml::Value::Integer(_) => toml::Value::Integer(
    // rust: text.parse()
    // rust: .map_err(|_| format!("{key} is a number, not {text:?}"))?,
    // rust: ),
    // rust: _ => toml::Value::String(text.to_owned()),
}
}
    // rust: if let (Some(range), toml::Value::Integer(n)) = (range(section, field), &value)
    // rust: && !range.contains(n)
    // rust: {
    // rust: return Err(format!(
    // rust: "{key} is {n}: use {} to {}",
    // rust: range.start(),
    // rust: range.end()
    // rust: ));
}
    // rust: Ok((section.to_owned(), field.to_owned(), value))
}

/// The values vanilla uses for the numbers it clamps (`ChunkMap` keeps both distances within 2 to 32).
pub fn range(section: []const u8, field: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match (section, field) {
    // rust: ("server", "view_distance" | "simulation_distance") => Some(2..=32),
    // rust: ("server", "max_view_distance") => Some(0..=32),
    // rust: ("server", "max_players") => Some(1..=1000),
    // rust: ("backups", "keep") => Some(1..=1000),
    // rust: _ => None,
}
}

/// The control line that applies a setting to a running game, if there is a way to: a console command, or the
/// management setting (`serversettings/motd/set`, `serversettings/max_players/set`) that the management
/// protocol uses; `Some("")` for the settings the supervisor itself reads every time (backups, updates).
pub fn live_line(section: []const u8, field: []const u8, value: *toml::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let setting = |name: &str, value: Value| {
    // rust: let request = json!({ "method": format!("serversettings/{name}/set"), "value": value });
        // Connection 0: no RPC client made this change, the command line did.
    // rust: Some(format!("management 0 {request}"))
}
    // rust: match (section, field, value) {
    // rust: ("server", "motd", toml::Value::String(text)) => setting("motd", json!(text)),
    // rust: ("server", "max_players", toml::Value::Integer(n)) => setting("max_players", json!(n)),
    // rust: _ => live_command(section, field, value).map(|line| {
    // rust: if line.is_empty() {
    // rust: line
    // rust: } else {
    // rust: format!("console {line}")
}
    // rust: }),
}
}

/// Sends the running game one control line on its endpoint, and says whether it took it.
pub fn ask_game(dir: *Path, line: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: engine::Control::connect(dir)
    // rust: .and_then(|mut game| game.ask(line))
    // rust: .is_ok_and(|reply| reply.get("error").is_none())
}

/// The console command that applies a setting to a running game, if vanilla has one; `Some("")` for the
/// settings the supervisor itself reads every time (backups, updates).
pub fn live_command(section: []const u8, field: []const u8, value: *toml::Value) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let text = match value {
    // rust: toml::Value::String(s) => s.clone(),
    // rust: other => other.to_string(),
}
    // rust: match (section, field) {
    // rust: ("world", "difficulty") => Some(format!("difficulty {text}")),
    // rust: ("world", "game_mode") => Some(format!("defaultgamemode {text}")),
    // rust: ("server", "whitelist") => Some(format!(
    // rust: "whitelist {}",
    // rust: if value.as_bool() == Some(true) {
    // rust: "on"
    // rust: } else {
    // rust: "off"
}
    // rust: )),
    // rust: ("backups" | "updates", _) => Some(String::new()),
    // rust: _ => None,
}
}

pub fn set(dir: *Path, changes: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let client = Client::open(dir)?;
    // rust: let up = client.as_ref().is_some_and(|c| {
    // rust: c.call("GET", "/api/v1/status", None)
    // rust: .is_ok_and(|s| s["phase"] == "running")
    // rust: });
    // rust: let run = |line: &str| up && ask_game(dir, line);
    // rust: apply(dir, changes, client.is_some().then_some(&run))
}

/// Writes the changes to server.toml, then sends a running server (`live` sends the game a control line and
/// says whether it took it) what it can take at once.
    // rust: pub fn apply(
    // rust: dir: &Path,
    // rust: changes: &[&str],
    // rust: live: Option<&dyn Fn(&str) -> bool>,
    // rust: ) -> Result<Outcome, String> {
    // rust: let current = toml::Table::try_from(config::Config::load(dir)?).map_err(|e| e.to_string())?;
    // rust: let parsed = changes
    // rust: .iter()
    // rust: .map(|c| parse_change(&current, c))
    // rust: .collect::<Result<Vec<_>, _>>()?;
    // rust: config::update_all(dir, &parsed)?;
    // rust: let mut outcome = Outcome {
    // rust: saved: parsed.iter().map(|(s, f, _)| format!("{s}.{f}")).collect(),
    // rust: ..Outcome::default()
}
    // rust: let Some(live) = live else {
    // rust: return Ok(outcome);
}
    // rust: outcome.running = true;
    // rust: for (section, field, value) in &parsed {
    // rust: let key = format!("{section}.{field}");
    // rust: let unchanged = current.get(section).and_then(|s| s.get(field)) == Some(value);
    // rust: match live_line(section, field, value) {
    // rust: _ if unchanged => {}
    // rust: Some(line) if line.is_empty() => outcome.applied.push(key),
    // rust: Some(line) if live(&line) => outcome.applied.push(key),
    // rust: _ => outcome.restart.push(key),
}
}
    // rust: Ok(outcome)
}

/// The settings the control API may change: none of `[engine]` (which program runs), `[panel]` and `[api]`
/// (who can reach the server), `[discord]` (its webhook is a secret), nor the vanilla keys that open another remote console.
pub fn changeable_remotely(key: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (section, field) = key.split_once('.').unwrap_or((key, ""));
    // rust: !matches!(section, "engine" | "panel" | "api" | "discord")
    // rust: && !(section == "properties"
    // rust: && (field.starts_with("rcon.")
    // rust: || field.starts_with("management-server-")
    // rust: || matches!(field, "enable-rcon" | "enable-query" | "query.port")))
}

/// The settings as JSON, the API's token and the Discord webhook hidden.
pub fn shown(dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut table = toml::Table::try_from(config::Config::load(dir)?).map_err(|e| e.to_string())?;
    // rust: for (section, field) in [("api", "token"), ("discord", "webhook")] {
    // rust: if let Some(secret) = table
    // rust: .get_mut(section)
    // rust: .and_then(|a| a.get_mut(field))
    // rust: .filter(|t| t.as_str() != Some(""))
    // rust: {
    // rust: *secret = toml::Value::String("(set)".into());
}
}
    // rust: serde_json::to_value(&table).map_err(|e| e.to_string())
}

    // rust: mod tests {
//     use super::*;

pub fn table() t {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: toml::Table::try_from(config::Config::default()).unwrap()
}

pub fn changes_take_the_settings_types() void {
}
    // rust: let t = table();
    // rust: assert_eq!(
    // rust: parse_change(&t, "server.max_players=8").unwrap(),
    // rust: (
    // rust: "server".into(),
    // rust: "max_players".into(),
    // rust: toml::Value::Integer(8)
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: parse_change(&t, "server.whitelist=off").unwrap().2,
    // rust: toml::Value::Boolean(false)
    // rust: );
    // rust: assert_eq!(
    // rust: parse_change(&t, "server.motd= Friends only ").unwrap().2,
    // rust: toml::Value::String("Friends only".into())
    // rust: );
    // rust: assert_eq!(
    // rust: parse_change(&t, "properties.spawn-protection=0").unwrap(),
    // rust: (
    // rust: "properties".into(),
    // rust: "spawn-protection".into(),
    // rust: toml::Value::Integer(0)
    // rust: )
    // rust: );
    // rust: for (bad, says) in [
    // rust: ("server.view_distance=40", "use 2 to 32"),
    // rust: ("server.max_players=many", "is a number"),
    // rust: ("server.online_mode=maybe", "use true or false"),
    // rust: ("server.colour=red", "is not a setting"),
    // rust: ("difficulty=hard", "section.name"),
    // rust: ("world.difficulty", "KEY=VALUE"),
    // rust: ] {
    // rust: let e = parse_change(&t, bad).unwrap_err();
    // rust: assert!(e.contains(says), "{bad}: {e}");
}
}

pub fn vanilla_changes_these_live() void {
}
    // rust: let s = |v: &str| toml::Value::String(v.into());
    // rust: assert_eq!(
    // rust: live_command("world", "difficulty", &s("hard")).as_deref(),
    // rust: Some("difficulty hard")
    // rust: );
    // rust: assert_eq!(
    // rust: live_command("world", "game_mode", &s("creative")).as_deref(),
    // rust: Some("defaultgamemode creative")
    // rust: );
    // rust: assert_eq!(
    // rust: live_command("server", "whitelist", &toml::Value::Boolean(false)).as_deref(),
    // rust: Some("whitelist off")
    // rust: );
    // rust: assert_eq!(
    // rust: live_command("backups", "every", &s("1h")).as_deref(),
    // rust: Some("")
    // rust: );
    // rust: assert_eq!(
    // rust: live_command("server", "view_distance", &toml::Value::Integer(8)),
    // rust: None
    // rust: );
}

pub fn the_message_and_the_player_limit_go_to_the_management_settings() void {
}
    // rust: let s = |v: &str| toml::Value::String(v.into());
    // rust: assert_eq!(
    // rust: live_line("server", "motd", &s("Friends \"only\"")).as_deref(),
    // rust: Some(r#"management 0 {"method":"serversettings/motd/set","value":"Friends \"only\""}"#)
    // rust: );
    // rust: assert_eq!(
    // rust: live_line("server", "max_players", &toml::Value::Integer(8)).as_deref(),
    // rust: Some(r#"management 0 {"method":"serversettings/max_players/set","value":8}"#)
    // rust: );
        // The console ones keep their command, the supervisor's own settings need none.
    // rust: assert_eq!(
    // rust: live_line("world", "difficulty", &s("hard")).as_deref(),
    // rust: Some("console difficulty hard")
    // rust: );
    // rust: assert_eq!(live_line("backups", "every", &s("1h")).as_deref(), Some(""));
    // rust: assert_eq!(
    // rust: live_line("server", "view_distance", &toml::Value::Integer(8)),
    // rust: None
    // rust: );
}

pub fn a_running_server_is_sent_only_what_changed() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-live-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(config::FILE), config::TEMPLATE).unwrap();
    // rust: let sent = std::cell::RefCell::new(Vec::new());
    // rust: let game = |line: &str| {
    // rust: sent.borrow_mut().push(line.to_owned());
    // rust: true
}
    // rust: let outcome = apply(
    // rust: &dir,
    // rust: &[
    // rust: "server.motd=Back at noon",
    // rust: "server.max_players=5",
    // rust: "server.view_distance=9",
    // rust: ],
    // rust: Some(&game),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(outcome.applied, ["server.motd", "server.max_players"]);
    // rust: assert_eq!(outcome.restart, ["server.view_distance"]);
    // rust: assert_eq!(
    // rust: *sent.borrow(),
    // rust: [
    // rust: r#"management 0 {"method":"serversettings/motd/set","value":"Back at noon"}"#,
    // rust: r#"management 0 {"method":"serversettings/max_players/set","value":5}"#,
    // rust: ]
    // rust: );
        // The same values again change nothing, so nothing is sent.
    // rust: sent.borrow_mut().clear();
    // rust: let outcome = apply(
    // rust: &dir,
    // rust: &["server.motd=Back at noon", "server.max_players=5"],
    // rust: Some(&game),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(outcome.applied.is_empty() && outcome.restart.is_empty());
    // rust: assert!(sent.borrow().is_empty());
        // A game that refuses leaves the setting for the next start.
    // rust: let refuses = |_: &str| false;
    // rust: let outcome = apply(&dir, &["server.motd=Closed"], Some(&refuses)).unwrap();
    // rust: assert_eq!(outcome.restart, ["server.motd"]);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

pub fn a_stopped_server_saves_and_keeps_comments() void {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-settings-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(config::FILE), config::TEMPLATE).unwrap();
    // rust: let outcome = set(
    // rust: &dir,
    // rust: &[
    // rust: "world.difficulty=hard",
    // rust: "server.max_players=5",
    // rust: "backups.every=0",
    // rust: ],
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: outcome,
    // rust: Outcome {
    // rust: saved: vec![
    // rust: "world.difficulty".into(),
    // rust: "server.max_players".into(),
    // rust: "backups.every".into()
    // rust: ],
    // rust: ..Outcome::default()
}
    // rust: );
    // rust: let text = std::fs::read_to_string(dir.join(config::FILE)).unwrap();
    // rust: assert!(
    // rust: text.contains("difficulty = \"hard\"          # peaceful, easy, normal or hard"),
    // rust: "{text}"
    // rust: );
    // rust: let cfg = config::Config::load(&dir).unwrap();
    // rust: assert_eq!(
    // rust: (cfg.server.max_players, cfg.backups.every.as_str()),
    // rust: (5, "0")
    // rust: );
        // Checked as the server checks it: nothing is written.
    // rust: assert!(set(&dir, &["world.difficulty=impossible"]).is_err());
    // rust: assert!(set(&dir, &["world.name=a/b", "server.port=1"]).is_err());
    // rust: assert_eq!(config::Config::load(&dir).unwrap(), cfg);
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
