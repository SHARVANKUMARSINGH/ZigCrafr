//! Transpiled from Horizon Rust crate
package horizon_server_main

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-server`: host a Horizon server (docs/server.md). It keeps the server's settings in `server.toml`,
// runs the game headless as the engine, and manages the vanilla files around it.

    // rust: mod admin;
    // rust: mod api;
    // rust: mod backup;
    // rust: mod cli;
    // rust: mod config;
    // rust: mod console;
    // rust: mod discord;
    // rust: mod engine;
    // rust: mod events;
    // rust: mod http;
    // rust: mod import_resources;
    // rust: mod init;
    // rust: mod lists;
    // rust: mod management;
    // rust: mod management_methods;
    // rust: mod management_schema;
    // rust: mod management_tls;
    // rust: mod mcp;
    // rust: mod panel;
    // rust: mod process;
    // rust: mod prune;
    // rust: mod query;
    // rust: mod rcon;
    // rust: mod reference;
    // rust: mod service;
    // rust: mod settings;
    // rust: mod signals;
    // rust: mod supervisor;
    // rust: mod update;
    // rust: mod websocket;

// use std::{path::PathBuf, process::ExitCode};

// This release's version: release.yml builds it with `HORIZON_VERSION` from the tag
// (docs/versioning.md); a build from source says Cargo.toml's.
    // rust: const VERSION: &str = match option_env!("HORIZON_VERSION") {
    // rust: Some(version) if !version.is_empty() => version,
    // rust: _ => env!("CARGO_PKG_VERSION"),
}

    // rust: const HELP: &str = "\
    // rust: horizon-server: host a Horizon (Minecraft Java Edition 26.3) server

    // rust: Usage: horizon-server [--dir DIR] <command>

    // rust: init        Set up a server here: the EULA, the world, the port, who may join (asks, or takes flags:
    // rust: --eula --world NAME --seed SEED --port N --whitelist/--no-whitelist --player NAME... --op NAME
    // rust: --offline --yes)
    // rust: run         Run the server in the foreground; type console commands, Ctrl-C stops it cleanly. It
    // rust: restarts the game if it crashes.
    // rust: start       Run the server in the background, or resume a stopped supervisor (output goes to logs/supervisor.log)
    // rust: stop, restart
    // rust: status [--json]
    // rust: Up or not, TPS, MSPT, players, RAM and CPU
    // rust: cmd COMMAND...
    // rust: Run a console command on the running server and print what it answers
    // rust: report [SECONDS]
    // rust: Record a performance report for SECONDS (default 60): where the ticks' time goes,
    // rust: entities, chunks, network, memory; saved in reports/ (JSON and text, no player data)
    // rust: logs [-f] [-n N]
    // rust: The last N lines of the log (default 50); -f follows it
    // rust: console     Attach to the running server: its log as it happens, TPS, MSPT, players and RAM at the
    // rust: top, and a command line for console commands; Ctrl-D detaches
    // rust: mcp         An MCP server on stdin and stdout, for an AI agent to run and moderate the server
    // rust: (players, kick, ban, whitelist, logs, events, backups, settings, restart...)
    // rust: backup [NAME]
    // rust: Zip the world and the settings into backups/ (a running server saves first and stays up)
    // rust: backups [--json]
    // rust: List the backups
    // rust: restore BACKUP [--dimension ID] [--yes]
    // rust: Put a backup's world in place (the current one is kept in backups/); a running
    // rust: server restarts with it. --dimension (like minecraft:the_nether) brings back only
    // rust: that dimension and leaves the rest of the world as it is
    // rust: service install|uninstall|print [--system]
    // rust: Start the server at boot or login: a systemd unit on Linux (--system: for every user,
    // rust: with sudo), a launchd agent on macOS, a task at logon on Windows
    // rust: panel       A one-time login link for the web panel ([panel] in server.toml; 127.0.0.1:8130 by
    // rust: default)
    // rust: update [--check [--json]] [--version TAG] [--timeout SECONDS]
    // rust: Install the newest release (checked against GitHub's SHA-256), back up the world and
    // rust: restart on it; goes back by itself if the game isn't up within the timeout (300 s).
    // rust: --archive FILE --version NAME installs an archive you have
    // rust: rollback    Back to the release used before the update
    // rust: config [--json]
    // rust: The settings in server.toml
    // rust: config set KEY=VALUE... [--json]
    // rust: Change settings (for example world.difficulty=hard server.max_players=10), checked first;
    // rust: a running server takes the difficulty, default game mode and whitelist at once, the rest
    // rust: at its next start
    // rust: import FILE Write server.toml from a vanilla server.properties
    // rust: import-resources DIR
    // rust: Copy game files prepared elsewhere (by the launcher or horizon-prepare) into place, after
    // rust: checking they are complete and for this Minecraft version; the old copy stays on failure
    // rust: op NAME, deop NAME
    // rust: whitelist on|off|list, whitelist add|remove NAME
    // rust: Who may join (on the running server, or in the files when it is stopped)
    // rust: players [--json]
    // rust: Who is online, the operators, the whitelist and the bans
    // rust: kick NAME [REASON], ban NAME [REASON], pardon NAME, ban-ip ADDRESS|NAME [REASON], pardon-ip ADDRESS
    // rust: Moderate the running server, or edit ban files while it is stopped

    // rust: --dir DIR   The server folder (default: the current folder)

    // rust: Settings live in server.toml; the server writes server.properties from it before every start.
    // rust: ";

main :: proc() -> E {
    // Ported from Horizon
    return {}
}
    // rust: let mut args: Vec<String> = std::env::args().skip(1).collect();
    // rust: let mut dir = PathBuf::from(".");
    // rust: if let Some(i) = args.iter().position(|a| a == "--dir") {
    // rust: if i + 1 >= args.len() {
    // rust: eprintln!("horizon-server: --dir needs a folder");
    // rust: return ExitCode::from(2);
}
    // rust: dir = PathBuf::from(args.remove(i + 1));
    // rust: args.remove(i);
}
    // rust: let result = match args.first().map(String::as_str) {
    // rust: None | Some("help" | "-h" | "--help") => {
    // rust: print!("{HELP}");
    // rust: Ok(())
}
    // rust: Some("version" | "-V" | "--version") => {
    // rust: println!("horizon-server {VERSION}");
    // rust: Ok(())
}
    // rust: Some("init") => init_answers(&args[1..]).and_then(|a| init::run(&dir, a)),
    // rust: Some("run") => supervisor::run(&dir),
    // rust: Some("start") => cli::start(&dir),
    // rust: Some("stop") => cli::stop(&dir, false),
    // rust: Some("restart") => cli::stop(&dir, true),
    // rust: Some("status") => cli::status(&dir, args[1..].iter().any(|a| a == "--json")),
    // rust: Some("cmd") => cli::command(&dir, &args[1..]),
    // rust: Some("report") => cli::report(&dir, &args[1..]),
    // rust: Some("logs") => logs(&dir, &args[1..]),
    // rust: Some("console") => console::run(&dir),
    // rust: Some("mcp") => mcp::serve(&dir),
    // rust: Some("panel") => cli::panel(&dir),
    // rust: Some("backup") => cli::backup(&dir, args.get(1).map(String::as_str)),
    // rust: Some("backups") => cli::backups(&dir, args[1..].iter().any(|a| a == "--json")),
    // rust: Some("service") => service::command(&dir, &args[1..]),
    // rust: Some("restore") => match args.get(1) {
    // rust: Some(name) => {
    // rust: let rest = &args[2..];
    // rust: match rest.iter().position(|a| a == "--dimension") {
    // rust: Some(i) if i + 1 >= rest.len() => {
    // rust: Err("--dimension needs an id (like minecraft:the_nether)".into())
}
    // rust: found => cli::restore(
    // rust: &dir,
    // rust: name,
    // rust: found.map(|i| rest[i + 1].as_str()),
    // rust: rest.iter().any(|a| a == "--yes"),
    // rust: ),
}
}
    // rust: None => Err("restore needs a backup (`horizon-server backups` lists them)".into()),
    // rust: },
    // rust: Some("import-resources") => import_resources::command(&dir, &args[1..]),
    // rust: Some("import") => import(&dir, &args[1..]),
    // rust: Some("config") => settings::command(&dir, &args[1..]),
    // rust: Some("update") => update::command(&dir, &args[1..]),
    // rust: Some("rollback") => update::rollback(&dir, &args[1..]),
    // rust: Some(command @ ("op" | "deop" | "whitelist")) => lists::run(&dir, command, &args[1..]),
    // rust: Some("players") => cli::players(&dir, args[1..].iter().any(|a| a == "--json")),
    // rust: Some(command @ ("kick" | "ban" | "pardon" | "ban-ip" | "pardon-ip")) => {
    // rust: cli::moderate(&dir, command, &args[1..])
}
    // rust: Some(other) => Err(format!(
    // rust: "unknown command {other}; `horizon-server help` lists them"
    // rust: )),
}
    // rust: match result {
    // rust: Ok(()) => ExitCode::SUCCESS,
    // rust: Err(e) => {
    // rust: eprintln!("horizon-server: {e}");
    // rust: ExitCode::FAILURE
}
}
}

logs :: proc(dir: ^std::path::Path, args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut follow = false;
    // rust: let mut count = 50;
    // rust: let mut it = args.iter();
    // rust: while let Some(arg) = it.next() {
    // rust: match arg.as_str() {
    // rust: "-f" | "--follow" => follow = true,
    // rust: "-n" => {
    // rust: count = it
    // rust: .next()
    // rust: .and_then(|n| n.parse().ok())
    // rust: .ok_or("-n needs a number of lines")?;
}
    // rust: other => return Err(format!("logs: unknown option {other}")),
}
}
    // rust: cli::logs(dir, follow, count)
}

init_answers :: proc(args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut answers = init::Answers::from_env()?;
    // rust: let mut it = args.iter();
    // rust: while let Some(arg) = it.next() {
    // rust: let mut value = |flag: &str| {
    // rust: it.next()
    // rust: .cloned()
    // rust: .ok_or_else(|| format!("{flag} needs a value"))
}
    // rust: match arg.as_str() {
    // rust: "--eula" => answers.eula = true,
    // rust: "--yes" | "-y" => answers.yes = true,
    // rust: "--world" => answers.world = Some(value(arg)?),
    // rust: "--seed" => answers.seed = Some(value(arg)?),
    // rust: "--port" => {
    // rust: answers.port = Some(
    // rust: value(arg)?
    // rust: .parse()
    // rust: .map_err(|_| "--port needs a number from 1 to 65535")?,
    // rust: );
}
    // rust: "--whitelist" => answers.whitelist = Some(true),
    // rust: "--no-whitelist" => answers.whitelist = Some(false),
    // rust: "--player" => answers.players.push(value(arg)?),
    // rust: "--op" => answers.op = Some(value(arg)?),
    // rust: "--offline" => answers.online = Some(false),
    // rust: other => return Err(format!("init: unknown option {other}")),
}
}
    // rust: Ok(answers)
}

import :: proc(dir: ^std::path::Path, args: ^[string]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let [source] = args else {
    // rust: return Err("import needs the server.properties to read".into());
}
    // rust: let target = dir.join(config::FILE);
    // rust: if target.exists() {
    // rust: return Err(format!(
    // rust: "{} already exists; move it away first",
    // rust: target.display()
    // rust: ));
}
    // rust: let cfg = config::Config::import(&config::read_properties(std::path::Path::new(source))?)?;
    // rust: std::fs::write(&target, config::render(&cfg)).map_err(|e| e.to_string())?;
    // rust: println!("Wrote {}", target.display());
    // rust: Ok(())
}
