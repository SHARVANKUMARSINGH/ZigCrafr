//! Transpiled from Horizon Rust crate
package horizon_server_console

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-server console` (docs/server.md, section 5): attach to the running server. The recent log, then
// every new line as it happens (the control API's event stream), a header with the TPS, MSPT, players and
// RAM refreshed every second, and a command line: each line typed runs as a console command. Ctrl-D
// detaches and leaves the server running. Plain ANSI, no TUI framework; when stdout isn't a terminal, plain
// lines without the header.

// use crate::api::Client;
// use serde_json::{Value, json};
// use std::{
    // rust: io::{BufRead, IsTerminal, Write},
    // rust: path::Path,
    // rust: sync::Arc,
    // rust: thread,
    // rust: time::Duration,
}

// The log lines shown on attaching.
RECENT :: 30

run :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let client = Arc::new(
    // rust: Client::open(dir)?.ok_or_else(|| format!("no server is running in {}", dir.display()))?,
    // rust: );
    // rust: let recent = client.call("GET", "/api/v1/events?since=0&types=log", None)?;
    // rust: let lines: Vec<&str> = recent["events"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| e["line"].as_str())
    // rust: .collect();
    // rust: let header = std::io::stdout()
    // rust: .is_terminal()
    // rust: .then(terminal_rows)
    // rust: .flatten();
    // rust: if let Some(rows) = header {
        // Line 1 is the header; the log scrolls below it.
    // rust: print!("\x1b[2J\x1b[2;{rows}r\x1b[{rows};1H");
}
    // rust: for line in &lines[lines.len().saturating_sub(RECENT)..] {
    // rust: println!("{line}");
}
    // rust: println!("Attached: type console commands (`list`, `say hi`, `ban NAME`...); Ctrl-D detaches.");
    // rust: let since = recent["next"].as_u64().unwrap_or(0);
    // rust: let follower = client.clone();
    // rust: thread::spawn(move || {
    // rust: let path = format!("/api/v1/events?since={since}&types=log");
    // rust: let ended = follower.follow(&path, |event| {
    // rust: if let Some(line) = event["line"].as_str() {
    // rust: println!("{line}");
}
    // rust: });
    // rust: detach(header.is_some());
    // rust: match ended {
    // rust: Ok(()) => println!("The server stopped."),
    // rust: Err(e) => println!("Lost the server: {e}"),
}
    // rust: std::process::exit(0);
    // rust: });
    // rust: if header.is_some() {
    // rust: let status = client.clone();
    // rust: thread::spawn(move || {
    // rust: loop {
    // rust: if let Ok(s) = status.call("GET", "/api/v1/status", None) {
                    // Save the cursor, write line 1, put the cursor back.
    // rust: print!(
    // rust: "\x1b7\x1b[1;1H\x1b[2K\x1b[7m{}\x1b[0m\x1b8",
    // rust: header_line(&s)
    // rust: );
    // rust: let _ = std::io::stdout().flush();
}
    // rust: thread::sleep(Duration::from_secs(1));
}
    // rust: });
}
    // rust: for line in std::io::stdin().lock().lines() {
    // rust: let Ok(line) = line else { break };
    // rust: let line = line.trim();
    // rust: if line.is_empty() {
    // rust: continue;
}
        // The game logs what the command says, so it shows in the log above.
    // rust: if let Err(e) = client.call("POST", "/api/v1/command", Some(&json!({ "line": line }))) {
    // rust: println!("{e}");
}
}
    // rust: detach(header.is_some());
    // rust: println!("Detached; the server keeps running.");
    // rust: Ok(())
}

// Gives the terminal its whole height back.
detach :: proc(header: bool) {
}
    // rust: if header {
    // rust: print!("\x1b[r\x1b[999;1H");
}
    // rust: let _ = std::io::stdout().flush();
}

// `running · 20.0 TPS · 3.2 ms · 2/20 players · 512 MB`.
header_line :: proc(status: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let sample = &status["sample"];
    // rust: let game = &sample["game"];
    // rust: let mut parts = vec![format!(
    // rust: "Horizon server {} · {}",
    // rust: status["version"].as_str().unwrap_or_default(),
    // rust: status["phase"].as_str().unwrap_or("?")
    // rust: )];
    // rust: if let Some(tps) = game["tps"].as_f64() {
    // rust: parts.push(format!("{tps:.1} TPS"));
}
    // rust: if let Some(mspt) = game["mspt"]["average"].as_f64() {
    // rust: parts.push(format!("{mspt:.1} ms/tick"));
}
    // rust: if let Some(players) = game["players"].as_array() {
    // rust: parts.push(format!(
    // rust: "{}/{} players",
    // rust: players.len(),
    // rust: game["max_players"].as_u64().unwrap_or(0)
    // rust: ));
}
    // rust: if let Some(rss) = sample["rss_bytes"].as_u64() {
    // rust: parts.push(format!("{} MB", rss >> 20));
}
    // rust: parts.join(" · ")
}

// The terminal's height, for the scroll region under the header.
terminal_rows :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // SAFETY: TIOCGWINSZ fills a winsize, which is zeroed plain data.
    // rust: let mut size: libc::winsize = unsafe { std::mem::zeroed() };
    // rust: let ok = unsafe { libc::ioctl(libc::STDOUT_FILENO, libc::TIOCGWINSZ, &mut size) } == 0;
    // rust: (ok && size.ws_row > 2).then_some(size.ws_row)
}

terminal_rows :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}

    // rust: mod tests {
//     use super::*;

the_header_says_how_the_server_does :: proc() {
}
    // rust: let status = json!({
    // rust: "version": "0.1.0", "phase": "running",
    // rust: "sample": { "rss_bytes": 536_870_912u64, "game": {
    // rust: "tps": 19.96, "mspt": { "average": 3.24 }, "players": [{}, {}], "max_players": 20,
    // rust: } },
    // rust: });
    // rust: assert_eq!(
    // rust: header_line(&status),
    // rust: "Horizon server 0.1.0 · running · 20.0 TPS · 3.2 ms/tick · 2/20 players · 512 MB"
    // rust: );
    // rust: assert_eq!(
    // rust: header_line(&json!({ "version": "0.1.0", "phase": "restarting", "sample": null })),
    // rust: "Horizon server 0.1.0 · restarting"
    // rust: );
}

console_requires_a_running_server :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-server-console-stopped-{}",
    // rust: std::process::id()
    // rust: ));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: assert_eq!(
    // rust: run(&dir).unwrap_err(),
    // rust: format!("no server is running in {}", dir.display())
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
