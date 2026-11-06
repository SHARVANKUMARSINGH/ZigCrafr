//! Transpiled from Horizon Rust crate
package horizon_server_cli

import "core:fmt"
import "core:mem"
import "core:math"

// The commands that manage a server in the background (docs/server.md, section 5): `start`, `stop`,
// `restart`, `status`, `cmd`, `report` and `logs`. They talk to the running supervisor through the control API.

// use crate::{api::Client, backup, signals, supervisor};
// use serde_json::{Value, json};
// use std::{
    // rust: path::{Path, PathBuf},
    // rust: process::{Command, Stdio},
    // rust: time::{Duration, Instant},
}

// How long `start` waits for the game's `Done`, and `stop` for the server to end.
START_TIMEOUT :: Duration::from_secs(300)
STOP_TIMEOUT :: Duration::from_secs(180)

running :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Client::open(dir)?.ok_or_else(|| format!("no server is running in {}", dir.display()))
}

// `start`: `run` in the background, its output in logs/supervisor.log; returns once the game is up.
start :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(client) = Client::open(dir)? {
    // rust: let status = client.call("GET", "/api/v1/status", None)?;
    // rust: if status["phase"] != "stopped" {
    // rust: return Err(format!("a server is already running in {}", dir.display()));
}
    // rust: client.call("POST", "/api/v1/start", None)?;
    // rust: wait_running(&client, None)?;
    // rust: println!("The server is running.");
    // rust: return Ok(());
}
    // rust: crate::config::Config::load(dir)?;
    // Left by a supervisor that was killed: the new one writes its own.
    // rust: let endpoint = dir.join(".horizon/api.json");
    // rust: let _ = std::fs::remove_file(&endpoint);
    // rust: let logs = dir.join("logs");
    // rust: std::fs::create_dir_all(&logs).map_err(|e| e.to_string())?;
    // rust: let log_path = logs.join("supervisor.log");
    // rust: let log = std::fs::OpenOptions::new()
    // rust: .create(true)
    // rust: .append(true)
    // rust: .open(&log_path)
    // rust: .map_err(|e| format!("{}: {e}", log_path.display()))?;
    // rust: let exe = std::env::current_exe().map_err(|e| e.to_string())?;
    // rust: let mut command = Command::new(exe);
    // rust: command
    // rust: .arg("--dir")
    // rust: .arg(dir)
    // rust: .arg("run")
    // rust: .stdin(Stdio::null())
    // rust: .stdout(log.try_clone().map_err(|e| e.to_string())?)
    // rust: .stderr(log);
    // Its own process group: closing this terminal doesn't stop the server.
    // rust: std::os::unix::process::CommandExt::process_group(&mut command, 0);
    // rust: std::os::windows::process::CommandExt::creation_flags(
    // rust: &mut command,
    // rust: windows_sys::Win32::System::Threading::DETACHED_PROCESS
    // rust: | windows_sys::Win32::System::Threading::CREATE_NEW_PROCESS_GROUP,
    // rust: );
    // rust: let mut child = command.spawn().map_err(|e| e.to_string())?;
    // rust: let deadline = Instant::now() + START_TIMEOUT;
    // rust: print!("Starting");
    // rust: loop {
    // rust: if let Ok(Some(status)) = child.try_wait() {
    // rust: println!();
    // rust: return Err(format!(
    // rust: "the server stopped ({status}); see {}",
    // rust: log_path.display()
    // rust: ));
}
        // Only once the new supervisor holds the folder (its endpoint is there) may we look: probing the
        // lock any earlier could take it from under it.
    // rust: if endpoint.exists()
    // rust: && let Ok(Some(client)) = Client::open(dir)
    // rust: && let Ok(status) = client.call("GET", "/api/v1/status", None)
    // rust: && status["phase"] == "running"
    // rust: {
    // rust: println!(
    // rust: "\nThe server is running (pid {}). `horizon-server status` shows how it does, \
    // rust: `horizon-server stop` stops it.",
    // rust: child.id()
    // rust: );
    // rust: return Ok(());
}
    // rust: if Instant::now() > deadline {
    // rust: println!();
    // rust: return Err(format!(
    // rust: "the game isn't up after {} s; it may still be starting: see {}",
    // rust: START_TIMEOUT.as_secs(),
    // rust: log_path.display()
    // rust: ));
}
    // rust: print!(".");
    // rust: let _ = std::io::Write::flush(&mut std::io::stdout());
    // rust: std::thread::sleep(Duration::from_millis(500));
}
}

// `stop` and `restart`.
stop :: proc(dir: ^Path, restart: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let client = running(dir)?;
    // rust: if restart {
    // rust: let before = client.call("GET", "/api/v1/status", None)?["engine_pid"].as_u64();
    // rust: client.call("POST", "/api/v1/restart", None)?;
    // rust: print!("Restarting");
    // rust: wait_running(&client, before)?;
    // rust: println!("\nThe game is running again.");
    // rust: return Ok(());
}
    // rust: client.call("POST", "/api/v1/stop", None)?;
    // rust: let deadline = Instant::now() + STOP_TIMEOUT;
    // rust: while supervisor::lock(dir).is_err() {
    // rust: if Instant::now() > deadline {
    // rust: return Err("the server is still stopping".into());
}
    // rust: std::thread::sleep(Duration::from_millis(200));
}
    // rust: println!("Stopped.");
    // rust: Ok(())
}

// Waits until the game is up: a new one when `replaced` is the engine's pid before a restart.
wait_running :: proc(client: ^Client, replaced: Maybe(u64)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let deadline = Instant::now() + START_TIMEOUT;
    // rust: loop {
    // rust: let status = client.call("GET", "/api/v1/status", None)?;
    // rust: if status["phase"] == "running" && status["engine_pid"].as_u64() != replaced {
    // rust: return Ok(());
}
    // rust: if status["phase"] == "stopping" || (status["phase"] == "stopped" && replaced.is_some()) {
    // rust: return Err("the server is stopping".into());
}
    // rust: if Instant::now() > deadline {
    // rust: return Err(format!(
    // rust: "the game isn't up after {} s; `horizon-server logs` shows why",
    // rust: START_TIMEOUT.as_secs()
    // rust: ));
}
    // rust: if replaced.is_some() {
    // rust: print!(".");
    // rust: let _ = std::io::Write::flush(&mut std::io::stdout());
}
    // rust: std::thread::sleep(Duration::from_millis(500));
}
}

// `cmd`: one console command, and what it printed.
command :: proc(dir: ^Path, words: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if words.is_empty() {
    // rust: return Err("cmd needs a console command, for example: horizon-server cmd list".into());
}
    // rust: let client = running(dir)?;
    // A game that is starting or restarting takes the command once it is up.
    // rust: wait_running(&client, None)?;
    // rust: let reply = client.call(
    // rust: "POST",
    // rust: "/api/v1/command",
    // rust: Some(&json!({ "line": words.join(" ") })),
    // rust: )?;
    // rust: for line in reply["output"].as_array().into_iter().flatten() {
    // rust: println!("{}", line.as_str().unwrap_or_default());
}
    // rust: Ok(())
}

// `players [--json]`: who is online, the operators, the whitelist and the bans; a stopped server's lists
// are read from its files.
players :: proc(dir: ^Path, as_json: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let v = match Client::open(dir)? {
    // rust: Some(client) => client.call("GET", "/api/v1/players", None)?,
    // rust: None => serde_json::from_str(
    // rust: &crate::admin::players(&crate::api::Shared::with_install(dir, None)).body,
    // rust: )
    // rust: .map_err(|e| e.to_string())?,
}
    // rust: if as_json {
    // rust: println!("{v}");
    // rust: return Ok(());
}
    // rust: let list = |key: &str, describe: &dyn Fn(&Value) -> String| -> String {
    // rust: let items: Vec<String> = v[key]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(describe)
    // rust: .collect();
    // rust: if items.is_empty() {
    // rust: "none".into()
    // rust: } else {
    // rust: items.join(", ")
}
}
    // rust: let name = |p: &Value| p["name"].as_str().unwrap_or_default().to_owned();
    // rust: let because = |b: &Value| match b["reason"].as_str() {
    // rust: Some(reason) => format!(" ({reason})"),
    // rust: None => String::new(),
}
    // rust: let online = list("online", &|p| match p["op_level"].as_i64() {
    // rust: Some(level) if level > 0 => format!("{} (op {level}, {} ms)", name(p), p["ping_ms"]),
    // rust: _ => format!("{} ({} ms)", name(p), p["ping_ms"]),
    // rust: });
    // rust: match v["max_players"].as_u64() {
    // rust: Some(max) => println!(
    // rust: "Online ({}/{max}): {online}",
    // rust: v["online"].as_array().map_or(0, Vec::len)
    // rust: ),
    // rust: None => println!("Online: the game isn't running"),
}
    // rust: println!(
    // rust: "Operators: {}",
    // rust: list("ops", &|o| format!("{} ({})", name(o), o["level"]))
    // rust: );
    // rust: let white: Vec<String> = v["whitelist"]["players"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(name)
    // rust: .collect();
    // rust: println!(
    // rust: "Whitelist ({}): {}",
    // rust: if v["whitelist"]["enabled"] == true {
    // rust: "on"
    // rust: } else {
    // rust: "off"
    // rust: },
    // rust: if white.is_empty() {
    // rust: "none".into()
    // rust: } else {
    // rust: white.join(", ")
}
    // rust: );
    // rust: println!(
    // rust: "Banned: {}",
    // rust: list("bans", &|b| format!("{}{}", name(b), because(b)))
    // rust: );
    // rust: println!(
    // rust: "Banned addresses: {}",
    // rust: list("ip_bans", &|b| format!(
    // rust: "{}{}",
    // rust: b["ip"].as_str().unwrap_or_default(),
    // rust: because(b)
    // rust: ))
    // rust: );
    // rust: Ok(())
}

// `kick NAME [REASON]`, `ban NAME [REASON]`, `pardon NAME`, `ban-ip ADDRESS|NAME [REASON]`, `pardon-ip
// ADDRESS`: the vanilla command on a running server, or a file-backed edit while it is stopped.
moderate :: proc(dir: ^Path, command: string, words: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(target) = words.first() else {
    // rust: return Err(format!(
    // rust: "{command} needs a player's name{}",
    // rust: if command.ends_with("-ip") {
    // rust: " or an address"
    // rust: } else {
    // rust: ""
}
    // rust: ));
}
    // File-backed moderation uses the same stopped-server path as `op` and `whitelist`; while a
    // supervisor is running, lists::run falls through to the game's vanilla console command.
    // rust: if command != "kick" {
    // rust: return crate::lists::run(dir, command, words);
}
    // rust: let mut body = json!({});
    // rust: let key = if target.parse::<std::net::IpAddr>().is_ok() {
    // rust: "ip"
    // rust: } else {
    // rust: "name"
}
    // rust: body[key] = json!(target);
    // rust: if words.len() > 1 {
    // rust: body["reason"] = json!(words[1..].join(" "));
}
    // rust: let client = running(dir)?;
    // rust: wait_running(&client, None)?;
    // rust: let reply = client.call("POST", &format!("/api/v1/players/{command}"), Some(&body))?;
    // rust: for line in reply["output"].as_array().into_iter().flatten() {
    // rust: println!("{}", line.as_str().unwrap_or_default());
}
    // rust: Ok(())
}

// `report [SECONDS]`: the running game records a performance report for that long (60 s by default,
// at most 600), writes it to `reports/` (a JSON file and a short text summary, nothing about who
// plays) and this prints the summary.
report :: proc(dir: ^Path, words: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let seconds = match words.first() {
    // rust: None => 60,
    // rust: Some(word) => word
    // rust: .parse::<u64>()
    // rust: .ok()
    // rust: .filter(|s| (1..=600).contains(s))
    // rust: .ok_or("report takes the seconds to record, 1 to 600 (60 by default)")?,
}
    // rust: let client = running(dir)?;
    // rust: wait_running(&client, None)?;
    // rust: let reports = dir.join("reports");
    // rust: let before = report_files(&reports);
    // rust: let reply = client.call(
    // rust: "POST",
    // rust: "/api/v1/command",
    // rust: Some(&json!({ "line": format!("horizon-report {seconds}") })),
    // rust: )?;
    // rust: for line in reply["output"].as_array().into_iter().flatten() {
    // rust: println!("{}", line.as_str().unwrap_or_default());
}
    // rust: println!("Recording for {seconds} s...");
    // The report is written a moment after the last recorded tick; a slow server gets a minute more.
    // rust: let deadline = Instant::now() + Duration::from_secs(seconds + 60);
    // rust: while Instant::now() < deadline {
    // rust: std::thread::sleep(Duration::from_millis(500));
    // rust: if let Some(text) = report_files(&reports)
    // rust: .into_iter()
    // rust: .find(|p| !before.contains(p))
    // rust: {
    // rust: let summary =
    // rust: std::fs::read_to_string(&text).map_err(|e| format!("{}: {e}", text.display()))?;
    // rust: print!("{summary}");
    // rust: println!("Saved: {} (and the .json beside it)", text.display());
    // rust: return Ok(());
}
}
    // rust: Err(format!(
    // rust: "no report in {} after {} s: is the game on a release with `horizon-report`?",
    // rust: reports.display(),
    // rust: seconds + 60
    // rust: ))
}

// The text summaries in `reports/`.
report_files :: proc(dir: ^Path) -> V {
    // Ported from Horizon
    return {}
}
    // rust: std::fs::read_dir(dir)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .flatten()
    // rust: .map(|e| e.path())
    // rust: .filter(|p| {
    // rust: p.extension().is_some_and(|e| e == "txt")
    // rust: && p.file_name()
    // rust: .and_then(|n| n.to_str())
    // rust: .is_some_and(|n| n.starts_with("perf-"))
    // rust: })
    // rust: .collect()
}

// `panel`: a one-time login link for the web panel.
panel :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let reply = running(dir)?.call("POST", "/api/v1/panel/login", None)?;
    // rust: let url = reply["url"].as_str().unwrap_or_default();
    // rust: println!(
    // rust: "Open this link in your browser (it works once, for 10 minutes):\n  {url}\n\
    // rust: From another computer: put a tailnet address in [panel] bind, or forward the port first:\n  \
    // rust: ssh -L {port}:{target} <this server>",
    // rust: port = url
    // rust: .split('/')
    // rust: .nth(2)
    // rust: .and_then(|h| h.rsplit_once(':'))
    // rust: .map_or("8130", |(_, p)| p),
    // rust: target = url.split('/').nth(2).unwrap_or("127.0.0.1:8130"),
    // rust: );
    // rust: Ok(())
}

// `status [--json]`.
status :: proc(dir: ^Path, as_json: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(client) = Client::open(dir)? else {
    // rust: if as_json {
    // rust: println!("{}", json!({ "phase": "stopped" }));
    // rust: } else {
    // rust: println!("Stopped.");
}
    // rust: return Ok(());
}
    // rust: let status = client.call("GET", "/api/v1/status", None)?;
    // rust: if as_json {
    // rust: println!("{status}");
    // rust: } else {
    // rust: print!("{}", describe(&status));
}
    // rust: Ok(())
}

// The status for people: three short lines.
describe :: proc(status: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::new();
    // rust: let phase = status["phase"].as_str().unwrap_or("?");
    // rust: let uptime = status["engine_uptime_seconds"]
    // rust: .as_u64()
    // rust: .or(status["uptime_seconds"].as_u64())
    // rust: .map_or_else(String::new, |s| format!(", up {}", duration(s)));
    // rust: let crashes = match status["crashes"].as_u64() {
    // rust: Some(0) | None => String::new(),
    // rust: Some(n) => format!(
    // rust: ", {n} crash{} (last: {})",
    // rust: if n == 1 { "" } else { "es" },
    // rust: status["last_crash"].as_str().unwrap_or("?")
    // rust: ),
}
    // rust: out += &format!("{}{uptime}{crashes}\n", capitalised(phase));
    // rust: let sample = &status["sample"];
    // rust: let game = &sample["game"];
    // rust: if let Some(tps) = game["tps"].as_f64() {
    // rust: let mspt = &game["mspt"];
    // rust: out += &format!(
    // rust: "TPS {tps:.1}, MSPT {:.1} ms average, {:.1} ms P95{}\n",
    // rust: mspt["average"].as_f64().unwrap_or(0.0),
    // rust: mspt["p95"].as_f64().unwrap_or(0.0),
    // rust: if game["paused"] == true {
    // rust: " (paused: nobody online)"
    // rust: } else {
    // rust: ""
}
    // rust: );
    // rust: let names: Vec<&str> = game["players"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|p| p["name"].as_str())
    // rust: .collect();
    // rust: out += &format!(
    // rust: "{} of {} players{}{}, {} chunks loaded\n",
    // rust: names.len(),
    // rust: game["max_players"].as_u64().unwrap_or(0),
    // rust: if names.is_empty() { "" } else { ": " },
    // rust: names.join(", "),
    // rust: game["chunks"].as_u64().unwrap_or(0)
    // rust: );
}
    // rust: let ram = sample["rss_bytes"]
    // rust: .as_f64()
    // rust: .map(|b| format!("RAM {:.2} GB", b / 1e9));
    // rust: let cpu = sample["cpu_percent"]
    // rust: .as_f64()
    // rust: .map(|c| format!("CPU {c:.0} % of a core"));
    // rust: let usage: Vec<String> = ram.into_iter().chain(cpu).collect();
    // rust: if !usage.is_empty() {
    // rust: out += &format!("{}\n", usage.join(", "));
}
    // rust: let update = &status["update"];
    // rust: if let Some(busy) = update["busy"].as_str() {
    // rust: out += &format!("Updating: {busy}\n");
    // rust: } else if let Some(tag) = update["available"].as_str() {
    // rust: out += &format!(
    // rust: "Horizon {tag} is out (this server runs {}): `horizon-server update` installs it\n",
    // rust: update["installed"].as_str().unwrap_or("?")
    // rust: );
}
    // rust: out
}

capitalised :: proc(s: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut c = s.chars();
    // rust: c.next()
    // rust: .map(|f| f.to_uppercase().chain(c).collect())
    // rust: .unwrap_or_default()
}

duration :: proc(secs: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match secs {
    // rust: 0..60 => format!("{secs} s"),
    // rust: 60..3600 => format!("{} min", secs / 60),
    // rust: 3600..86_400 => format!("{} h {:02} min", secs / 3600, secs / 60 % 60),
    // rust: _ => format!("{} d {} h", secs / 86_400, secs / 3600 % 24),
}
}

// `backup [NAME]`: through the running server (it saves first), or straight from the files.
backup :: proc(dir: ^Path, name: Maybe(string)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let made = match Client::open(dir)? {
    // rust: Some(client) => client.call_within(
    // rust: "POST",
    // rust: "/api/v1/backups",
    // rust: Some(&json!({ "name": name })),
    // rust: Duration::from_secs(3600),
    // rust: )?["name"]
    // rust: .as_str()
    // rust: .unwrap_or_default()
    // rust: .to_owned(),
    // rust: None => {
    // rust: let _lock = supervisor::lock(dir)?;
    // rust: let config = crate::config::Config::load(dir)?;
    // rust: let file = backup::file_name(std::time::SystemTime::now(), name)?;
    // rust: backup::create(dir, &config, &file)?;
    // rust: file
}
}
    // rust: println!("Backed up to {}/{made}", backup::DIR);
    // rust: Ok(())
}

// `backups [--json]`: the backups, newest first.
backups :: proc(dir: ^Path, as_json: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let all = backup::list(dir);
    // rust: if as_json {
    // rust: let list: Vec<Value> = all
    // rust: .iter()
    // rust: .map(|b| {
    // rust: let modified = std::fs::metadata(dir.join(backup::DIR).join(&b.name))
    // rust: .and_then(|m| m.modified())
    // rust: .ok()
    // rust: .and_then(|t| t.duration_since(std::time::UNIX_EPOCH).ok())
    // rust: .map(|d| d.as_secs());
    // rust: json!({ "name": b.name, "bytes": b.bytes, "modified": modified })
    // rust: })
    // rust: .collect();
    // rust: println!("{}", Value::Array(list));
    // rust: return Ok(());
}
    // rust: if all.is_empty() {
    // rust: println!("No backups yet: `horizon-server backup` makes one.");
}
    // rust: for b in all {
    // rust: println!("{:>10}  {}", size(b.bytes), b.name);
}
    // rust: Ok(())
}

size :: proc(bytes: u64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match bytes {
    // rust: 0..1_000_000 => format!("{} kB", bytes.div_ceil(1000)),
    // rust: 1_000_000..1_000_000_000 => format!("{:.1} MB", bytes as f64 / 1e6),
    // rust: _ => format!("{:.2} GB", bytes as f64 / 1e9),
}
}

// `restore NAME [--yes]`: the backup's world in place of the current one (moved aside, not deleted). A
// running server restarts with it. With a dimension, only that one comes back and the rest of the world stays.
restore :: proc(dir: ^Path, name: string, dimension: Maybe(string), yes: bool) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let name = backup::find(dir, name)?;
    // rust: let dimension = dimension
    // rust: .map(backup::dimension_folder)
    // rust: .transpose()?
    // rust: .map(|d| d.0);
    // rust: let what = match &dimension {
    // rust: Some(d) => format!("the dimension {d} with {name}'s"),
    // rust: None => format!("the world with {name}"),
}
    // rust: if !yes {
    // rust: if !std::io::IsTerminal::is_terminal(&std::io::stdin()) {
    // rust: return Err("restore replaces the world: pass --yes to confirm".into());
}
    // rust: print!(
    // rust: "Replace {what}? What it replaces is kept in {}/. [y/N] ",
    // rust: backup::DIR
    // rust: );
    // rust: let _ = std::io::Write::flush(&mut std::io::stdout());
    // rust: let mut answer = String::new();
    // rust: let _ = std::io::stdin().read_line(&mut answer);
    // rust: if !answer.trim().eq_ignore_ascii_case("y") && !answer.trim().eq_ignore_ascii_case("yes") {
    // rust: println!("Nothing changed.");
    // rust: return Ok(());
}
}
    // rust: if let Some(client) = Client::open(dir)? {
    // rust: let before = client.call("GET", "/api/v1/status", None)?["engine_pid"].as_u64();
    // rust: client.call(
    // rust: "POST",
    // rust: "/api/v1/restore",
    // rust: Some(&json!({ "name": name, "dimension": dimension })),
    // rust: )?;
    // rust: print!("Restoring {name}: restarting the game with it");
    // rust: wait_running(&client, before)?;
    // rust: println!(
    // rust: "\nThe game is running on the restored world; `horizon-server logs` has the details."
    // rust: );
    // rust: return Ok(());
}
    // rust: let _lock = supervisor::lock(dir)?;
    // rust: let config = crate::config::Config::load(dir)?;
    // rust: let done = match &dimension {
    // rust: Some(d) => backup::restore_dimension(dir, &config, &name, d)?,
    // rust: None => backup::restore(dir, &config, &name)?,
}
    // rust: match done {
    // rust: Some(old) => println!(
    // rust: "Restored {name}; the world it replaced is in {}",
    // rust: old.display()
    // rust: ),
    // rust: None => println!("Restored {name}"),
}
    // rust: Ok(())
}

// `logs [-f] [-n N]`: the last lines, from the running server or else from logs/latest.log.
logs :: proc(dir: ^Path, follow: bool, count: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(client) = Client::open(dir)? else {
    // rust: if follow {
    // rust: return Err("no server is running to follow".into());
}
    // rust: let path = dir.join("logs/latest.log");
    // rust: let text =
    // rust: std::fs::read_to_string(&path).map_err(|e| format!("{}: {e}", path.display()))?;
    // rust: let lines: Vec<&str> = text.lines().collect();
    // rust: for line in &lines[lines.len().saturating_sub(count)..] {
    // rust: println!("{line}");
}
    // rust: return Ok(());
}
    // rust: let reply = client.call("GET", "/api/v1/logs?since=0", None)?;
    // rust: let lines = reply["lines"].as_array().cloned().unwrap_or_default();
    // rust: for line in &lines[lines.len().saturating_sub(count)..] {
    // rust: println!("{}", line.as_str().unwrap_or_default());
}
    // rust: if !follow {
    // rust: return Ok(());
}
    // rust: signals::install();
    // rust: let mut next = reply["next"].as_u64().unwrap_or(0);
    // rust: while signals::requests() == 0 {
    // rust: std::thread::sleep(Duration::from_millis(500));
    // rust: let Ok(reply) = client.call("GET", &format!("/api/v1/logs?since={next}"), None) else {
    // rust: break;
}
    // rust: for line in reply["lines"].as_array().into_iter().flatten() {
    // rust: println!("{}", line.as_str().unwrap_or_default());
}
    // rust: next = reply["next"].as_u64().unwrap_or(next);
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;

status_reads_well :: proc() {
}
    // rust: let status = json!({
    // rust: "phase": "running",
    // rust: "engine_uptime_seconds": 7380,
    // rust: "crashes": 1,
    // rust: "last_crash": "signal: 9 (SIGKILL)",
    // rust: "sample": {
    // rust: "rss_bytes": 1_420_000_000u64,
    // rust: "cpu_percent": 12.4,
    // rust: "game": {
    // rust: "tps": 20.0,
    // rust: "mspt": { "average": 3.12, "p95": 7.9 },
    // rust: "players": [{ "name": "Alex" }, { "name": "Steve" }],
    // rust: "max_players": 20,
    // rust: "chunks": 1234,
    // rust: "paused": false
}
}
    // rust: });
    // rust: assert_eq!(
    // rust: describe(&status),
    // rust: "Running, up 2 h 03 min, 1 crash (last: signal: 9 (SIGKILL))\n\
    // rust: TPS 20.0, MSPT 3.1 ms average, 7.9 ms P95\n\
    // rust: 2 of 20 players: Alex, Steve, 1234 chunks loaded\n\
    // rust: RAM 1.42 GB, CPU 12 % of a core\n"
    // rust: );
    // rust: assert_eq!(
    // rust: describe(&json!({ "phase": "starting", "uptime_seconds": 4 })),
    // rust: "Starting, up 4 s\n"
    // rust: );
    // rust: assert_eq!(
    // rust: describe(&json!({
    // rust: "phase": "running",
    // rust: "update": { "installed": "v2026.10.18", "available": "v2026.10.19" }
    // rust: })),
    // rust: "Running\nHorizon v2026.10.19 is out (this server runs v2026.10.18): `horizon-server update` installs it\n"
    // rust: );
    // rust: assert_eq!(
    // rust: describe(
    // rust: &json!({ "phase": "restarting", "update": { "busy": "Starting the game on v2" } })
    // rust: ),
    // rust: "Restarting\nUpdating: Starting the game on v2\n"
    // rust: );
}
}
