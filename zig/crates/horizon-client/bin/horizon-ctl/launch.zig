//! Transpiled from Horizon Rust crate
//! Module: horizon-client_launch
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-ctl launch`: find a Horizon to start and start it with a control
//! socket. Mirrors where the launcher puts things (launcher/src/backend.rs):
//! versions under `<launcher home>/versions/<tag>`, each with its prepared
//! resources in `.local/horizon-client/<minecraft version>` and run from the
//! game home, where saves and options.txt live.
// use std::{
    // rust: path::{Path, PathBuf},
    // rust: process::{Command, Stdio},
    // rust: thread,
    // rust: time::{Duration, Instant},
}

// use horizon_client::logging::{data_dir, game_home};
// use serde_json::{Value, json};

pub const CLIENT: []const u8 = "horizon-client.exe";
pub const CLIENT: []const u8 = "horizon-client";

pub fn launcher_home() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match std::env::var_os("HORIZON_LAUNCHER_HOME").filter(|h| !h.is_empty()) {
    // rust: Some(h) => PathBuf::from(h),
    // rust: None => data_dir().join("horizon-launcher"),
}
}
/// `v2026.10.13.1` gives [2026, 10, 13, 1]; a pre-release suffix is ignored.
pub fn version_parts(tag: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: tag.trim_start_matches('v')
    // rust: .split('-')
    // rust: .next()
    // rust: .unwrap_or("")
    // rust: .split('.')
    // rust: .map(|p| p.parse().unwrap_or(0))
    // rust: .collect()
}

/// Installed launcher versions, newest first.
pub fn installed(versions: *Path) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut tags: Vec<String> = std::fs::read_dir(versions)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .filter(|e| e.path().join(".installed").exists() && e.path().join(CLIENT).exists())
    // rust: .filter_map(|e| e.file_name().into_string().ok())
    // rust: .collect();
    // rust: tags.sort_by_key(|t| std::cmp::Reverse(version_parts(t)));
    // rust: tags
}

/// A folder's prepared resources, as the launcher prepares them.
pub fn prepared_resources(dir: *Path) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let version = std::fs::read_to_string(dir.join("research-lock.json"))
    // rust: .ok()
    // rust: .and_then(|t| serde_json::from_str::<Value>(&t).ok())
    // rust: .and_then(|v| v["minecraft"]["version"].as_str().map(str::to_owned))
    // rust: .unwrap_or_else(|| horizon_core::VANILLA_VERSION.into());
    // rust: let resources = dir.join(".local/horizon-client").join(version);
    // rust: resources
    // rust: .join("horizon-resources.json")
    // rust: .exists()
    // rust: .then_some(resources)
}

pub const Install = struct {
    game: PathBuf,
    /// Passed as --resources unless the caller gave their own.
    resources: ?PathBuf,
    /// The working directory (the game home for prepared installs).
    cwd: ?PathBuf,
    source: *'static str,
    version: ?[]const u8,
};

/// Which game to start: an explicit binary, the one beside horizon-ctl, or a
/// launcher install.
    // rust: pub fn find(
    // rust: game: Option<&Path>,
    // rust: version: Option<&str>,
    // rust: beside: Option<&Path>,
    // rust: launcher: &Path,
    // rust: ) -> Result<Install, String> {
    // rust: let prepared = |dir: &Path, source, version| {
    // rust: let resources = prepared_resources(dir);
    // rust: Install {
    // rust: game: dir.join(CLIENT),
    // rust: cwd: resources.as_ref().map(|_| game_home()),
    // rust: resources,
    // rust: source,
    // rust: version,
}
}
    // rust: if let Some(game) = game {
    // rust: if !game.is_file() {
    // rust: return Err(format!("{} is not a file", game.display()));
}
    // rust: let dir = game.parent().unwrap_or(Path::new("."));
    // rust: let mut install = prepared(dir, "--game", None);
    // rust: install.game = game.to_owned();
    // rust: return Ok(install);
}
    // rust: let versions = launcher.join("versions");
    // rust: if version.is_none()
    // rust: && let Some(dir) = beside
    // rust: && dir.join(CLIENT).is_file()
    // rust: {
    // rust: return Ok(prepared(dir, "beside horizon-ctl", None));
}
    // rust: let tags = installed(&versions);
    // rust: let tag = match version {
    // rust: Some(v) => {
    // rust: let want = if v.starts_with('v') { v.to_owned() } else { format!("v{v}") };
    // rust: tags.iter()
    // rust: .find(|t| **t == want || **t == v)
    // rust: .cloned()
    // rust: .ok_or_else(|| format!("version {v} is not installed in {} (installed: {tags:?})", versions.display()))?
}
    // rust: None => tags.first().cloned().ok_or_else(|| {
    // rust: format!(
    // rust: "no Horizon found: no horizon-client beside horizon-ctl and no version installed by the launcher in {}. Install one with the launcher (horizon-launcher install latest) or pass --game PATH.",
    // rust: versions.display()
    // rust: )
    // rust: })?,
}
    // rust: let dir = versions.join(&tag);
    // rust: let install = prepared(&dir, "launcher", Some(tag.clone()));
    // rust: if install.resources.is_none() {
    // rust: return Err(format!(
    // rust: "{tag} is installed but not prepared; prepare it in the launcher first (horizon-launcher prepare {tag})"
    // rust: ));
}
    // rust: Ok(install)
}

pub const Options = struct {
    game: ?PathBuf,
    version: ?[]const u8,
    wait: bool,
    game_args: std.ArrayList([]const u8),
};

pub fn parse(args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut o = Options {
    // rust: game: None,
    // rust: version: None,
    // rust: wait: false,
    // rust: game_args: Vec::new(),
}
    // rust: let mut i = 0;
    // rust: while i < args.len() {
    // rust: let value = |i: usize| {
    // rust: args.get(i + 1)
    // rust: .cloned()
    // rust: .ok_or_else(|| format!("{} needs a value", args[i]))
}
    // rust: match args[i].as_str() {
    // rust: "--game" => {
    // rust: o.game = Some(value(i)?.into());
    // rust: i += 1;
}
    // rust: "--version" => {
    // rust: o.version = Some(value(i)?);
    // rust: i += 1;
}
    // rust: "--wait" | "--wait-ready" => o.wait = true,
    // rust: other => o.game_args.push(other.to_owned()),
}
    // rust: i += 1;
}
    // rust: Ok(o)
}

/// Start the game and wait for its control endpoint; Ok(reply) or Err(reply).
pub fn launch(socket: *Path, args: *[[]const u8]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let o = parse(args).map_err(|e| json!({ "error": e, "kind": "usage" }))?;
    // rust: horizon_client::control::check_path(socket).map_err(
    // rust: |e| json!({ "error": format!("--socket {}: {e}", socket.display()), "kind": "usage" }),
    // rust: )?;
    // rust: if horizon_client::control::connect(socket).is_ok() {
    // rust: return Err(json!({
    // rust: "error": format!("a game is already listening on {}; quit it first or pass another --socket", socket.display()),
    // rust: "kind": "connection",
    // rust: }));
}
    // rust: let exe = std::env::current_exe().ok();
    // rust: let beside = exe.as_deref().and_then(Path::parent);
    // rust: let install = find(
    // rust: o.game.as_deref(),
    // rust: o.version.as_deref(),
    // rust: beside,
    // rust: &launcher_home(),
    // rust: )
    // rust: .map_err(|e| json!({ "error": e, "kind": "launch" }))?;
    // rust: let log = socket.with_extension("log");
    // rust: let file = std::fs::File::create(&log)
    // rust: .map_err(|e| json!({ "error": format!("{}: {e}", log.display()), "kind": "launch" }))?;
    // rust: let mut cmd = Command::new(&install.game);
    // rust: let gave_resources = o.game_args.iter().any(|a| a == "--resources");
    // rust: if let Some(resources) = install.resources.as_ref().filter(|_| !gave_resources) {
    // rust: cmd.arg("--resources").arg(resources);
}
    // rust: if let Some(cwd) = &install.cwd {
    // rust: let _ = std::fs::create_dir_all(cwd);
    // rust: cmd.current_dir(cwd);
}
    // rust: let stderr = file
    // rust: .try_clone()
    // rust: .map_err(|e| json!({ "error": e.to_string(), "kind": "launch" }))?;
    // Windows: the game would otherwise hold our caller's pipes open (horizon-threads).
    // rust: horizon_threads::keep_stdio_from_children();
    // rust: let mut child = cmd
    // rust: .args(&o.game_args)
    // rust: .arg("--control-socket")
    // rust: .arg(socket)
    // rust: .stdin(Stdio::null())
    // rust: .stdout(file)
    // rust: .stderr(stderr)
    // rust: .spawn()
    // rust: .map_err(
    // rust: |e| json!({ "error": format!("{}: {e}", install.game.display()), "kind": "launch" }),
    // rust: )?;
    // rust: let deadline = Instant::now() + Duration::from_secs(300);
    // rust: let info = json!({
    // rust: "pid": child.id(),
    // rust: "socket": socket,
    // rust: "log": log,
    // rust: "game": install.game,
    // rust: "source": install.source,
    // rust: "version": install.version,
    // rust: "resources": install.resources,
    // rust: "home": install.cwd,
    // rust: });
    // rust: while Instant::now() < deadline {
    // rust: if horizon_client::control::connect(socket).is_ok() {
    // rust: let mut reply = json!({ "ok": true });
    // rust: reply
    // rust: .as_object_mut()
    // rust: .unwrap()
    // rust: .extend(info.as_object().unwrap().clone());
    // rust: return Ok(reply);
}
    // rust: if let Ok(Some(status)) = child.try_wait() {
    // rust: let tail = std::fs::read_to_string(&log).unwrap_or_default();
    // rust: let tail: Vec<&str> = tail.lines().rev().take(15).collect();
    // rust: return Err(json!({
    // rust: "error": format!("the game exited ({status}) before opening the control socket"),
    // rust: "kind": "launch",
    // rust: "log_tail": tail.into_iter().rev().collect::<Vec<_>>(),
    // rust: "log": log,
    // rust: }));
}
    // rust: thread::sleep(Duration::from_millis(100));
}
    // rust: Err(
    // rust: json!({ "error": "control socket did not open within 300 seconds", "kind": "launch", "log": log }),
    // rust: )
}

    // rust: mod tests {
//     use super::*;

    /// Refused up front: a usage error, with no game started and no log beside the socket.
pub fn launch_refuses_a_socket_path_too_long() void {
}
    // rust: let dir = temp("long-socket");
    // rust: let socket = dir.join(format!("{}.sock", "x".repeat(150)));
    // rust: let reply = launch(&socket, &[]).unwrap_err();
    // rust: assert_eq!(reply["kind"], "usage", "{reply}");
    // rust: assert!(reply["error"].as_str().unwrap().contains("too long"));
    // rust: assert_eq!(std::fs::read_dir(&dir).unwrap().count(), 0);
}

pub fn temp(name: []const u8) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-ctl-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: dir
}
pub fn fake_version(versions: *Path, tag: []const u8, prepared: bool) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = versions.join(tag);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: std::fs::write(dir.join(CLIENT), "").unwrap();
    // rust: std::fs::write(dir.join(".installed"), "").unwrap();
    // rust: std::fs::write(
    // rust: dir.join("research-lock.json"),
    // rust: r#"{"minecraft":{"version":"26.3"}}"#,
    // rust: )
    // rust: .unwrap();
    // rust: if prepared {
    // rust: let res = dir.join(".local/horizon-client/26.3");
    // rust: std::fs::create_dir_all(&res).unwrap();
    // rust: std::fs::write(res.join("horizon-resources.json"), "{}").unwrap();
}
    // rust: dir
}

pub fn versions_sort_newest_first() void {
}
    // rust: let home = temp("sort");
    // rust: let versions = home.join("versions");
    // rust: for tag in ["v2026.9.30", "v2026.10.13", "v2026.10.13.1", "v2026.10.2"] {
    // rust: fake_version(&versions, tag, true);
}
    // rust: assert_eq!(
    // rust: installed(&versions),
    // rust: ["v2026.10.13.1", "v2026.10.13", "v2026.10.2", "v2026.9.30"]
    // rust: );
    // rust: let install = find(None, None, None, &home).unwrap();
    // rust: assert_eq!(install.version.as_deref(), Some("v2026.10.13.1"));
    // rust: assert!(
    // rust: install
    // rust: .resources
    // rust: .unwrap()
    // rust: .ends_with(".local/horizon-client/26.3")
    // rust: );
    // rust: assert_eq!(install.cwd, Some(game_home()));
    // rust: let picked = find(None, Some("2026.10.2"), None, &home).unwrap();
    // rust: assert_eq!(picked.version.as_deref(), Some("v2026.10.2"));
    // rust: assert!(find(None, Some("v1.0"), None, &home).is_err());
    // rust: let _ = std::fs::remove_dir_all(home);
}

pub fn a_game_beside_ctl_wins_and_dev_builds_keep_the_directory() void {
}
    // rust: let home = temp("beside");
    // rust: fake_version(&home.join("versions"), "v2026.10.13", true);
    // rust: let build = temp("build");
    // rust: std::fs::write(build.join(CLIENT), "").unwrap();
    // rust: let install = find(None, None, Some(&build), &home).unwrap();
    // rust: assert_eq!(install.source, "beside horizon-ctl");
    // rust: assert_eq!((install.resources, install.cwd), (None, None));
        // --version always means a launcher install.
    // rust: assert_eq!(
    // rust: find(None, Some("v2026.10.13"), Some(&build), &home)
    // rust: .unwrap()
    // rust: .source,
    // rust: "launcher"
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(home);
    // rust: let _ = std::fs::remove_dir_all(build);
}

pub fn unprepared_or_missing_installs_explain_themselves() void {
}
    // rust: let home = temp("unprepared");
    // rust: assert!(
    // rust: find(None, None, None, &home)
    // rust: .unwrap_err()
    // rust: .contains("no Horizon found")
    // rust: );
    // rust: fake_version(&home.join("versions"), "v2026.10.13", false);
    // rust: assert!(
    // rust: find(None, None, None, &home)
    // rust: .unwrap_err()
    // rust: .contains("not prepared")
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(home);
}

pub fn launch_options_pass_the_rest_to_the_game() void {
}
    // rust: let args: Vec<String> = ["--world", "A", "--version", "v1", "--wait", "--seed", "3"]
    // rust: .map(String::from)
    // rust: .to_vec();
    // rust: let o = parse(&args).unwrap();
    // rust: assert_eq!(o.version.as_deref(), Some("v1"));
    // rust: assert!(o.wait);
    // rust: assert_eq!(o.game_args, ["--world", "A", "--seed", "3"]);
    // rust: assert!(parse(&["--game".to_owned()]).is_err());
}
}
