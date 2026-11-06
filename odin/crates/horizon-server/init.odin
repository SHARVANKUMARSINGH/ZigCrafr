//! Transpiled from Horizon Rust crate
package horizon_server_init

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-server init`: the first run (docs/server.md, section 3). It asks about the EULA, the world, the
// port and who may join, imports an existing `server.properties`, finds the game, and writes `server.toml`.
// Every question has a flag, so it also runs unattended (Docker, scripts).

// use crate::{config, config::Config, engine};
// use horizon_server_files::{
    // rust: eula,
    // rust: java_properties::now_millis,
    // rust: user_lists::{OpEntry, OpList, WhiteEntry, WhiteList},
}
// use std::{
    // rust: io::{BufRead, IsTerminal, Write},
    // rust: path::Path,
}

// The answers given as flags; what is missing is asked, or defaulted with `yes`.
Answers :: struct {
    eula: bool,
    world: Maybe(string),
    seed: Maybe(string),
    port: Maybe(u16),
    whitelist: Maybe(bool),
    players: [dynamic]string,
    op: Maybe(string),
    // online-mode (true unless set): players' Minecraft accounts are checked.
    online: Maybe(bool),
    // Take the default for every question not answered by a flag.
    yes: bool,
}

    // rust: impl Answers {
    // The answers in the environment, for containers: `HORIZON_EULA=true`, `HORIZON_WORLD`,
    // `HORIZON_SEED`, `HORIZON_PORT`, `HORIZON_WHITELIST=true|false`, `HORIZON_PLAYERS` (names separated by
    // commas), `HORIZON_OP` and `HORIZON_ONLINE=true|false`. Flags given on the command line win.
from_env :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: let var = |name: &str| std::env::var(name).ok().filter(|v| !v.is_empty());
    // rust: let flag = |name: &str| var(name).map(|v| v.eq_ignore_ascii_case("true"));
    // rust: Ok(Self {
    // rust: eula: flag("HORIZON_EULA").unwrap_or(false),
    // rust: world: var("HORIZON_WORLD"),
    // rust: seed: var("HORIZON_SEED"),
    // rust: port: var("HORIZON_PORT")
    // rust: .map(|p| {
    // rust: p.parse()
    // rust: .map_err(|_| format!("HORIZON_PORT is {p:?}: use a port number"))
    // rust: })
    // rust: .transpose()?,
    // rust: whitelist: flag("HORIZON_WHITELIST"),
    // rust: players: var("HORIZON_PLAYERS")
    // rust: .map(|p| {
    // rust: p.split([',', ' '])
    // rust: .filter(|n| !n.is_empty())
    // rust: .map(str::to_owned)
    // rust: .collect()
    // rust: })
    // rust: .unwrap_or_default(),
    // rust: op: var("HORIZON_OP"),
    // rust: online: flag("HORIZON_ONLINE"),
    // rust: yes: false,
    // rust: })
}
}

Prompt :: struct {
    interactive: bool,
}

    // rust: impl Prompt {
ask :: proc(self: ^Self, question: string, default: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if !self.interactive {
    // rust: return default.to_owned();
}
    // rust: if default.is_empty() {
    // rust: print!("{question}: ");
    // rust: } else {
    // rust: print!("{question} [{default}]: ");
}
    // rust: let _ = std::io::stdout().flush();
    // rust: let mut line = String::new();
    // rust: if std::io::stdin().lock().read_line(&mut line).unwrap_or(0) == 0 {
    // rust: return default.to_owned();
}
    // rust: match line.trim() {
    // rust: "" => default.to_owned(),
    // rust: answer => answer.to_owned(),
}
}
yes :: proc(self: ^Self, question: string, default: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let answer = self.ask(
    // rust: &format!("{question} ({})", if default { "Y/n" } else { "y/N" }),
    // rust: "",
    // rust: );
    // rust: match answer.to_ascii_lowercase().as_str() {
    // rust: "" => default,
    // rust: a => a.starts_with('y'),
}
}
}

run :: proc(dir: ^Path, answers: Answers) -> R {
    // Ported from Horizon
    return {}
}
    // rust: std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
    // rust: let toml_path = dir.join(config::FILE);
    // rust: if toml_path.exists() {
    // rust: return Err(format!(
    // rust: "{} already exists: this server is set up. Edit it, or start the server with `horizon-server run`",
    // rust: toml_path.display()
    // rust: ));
}
    // rust: let prompt = Prompt {
    // rust: interactive: !answers.yes && std::io::stdin().is_terminal(),
}

    // An existing vanilla server folder: its settings become server.toml.
    // rust: let properties = dir.join(config::PROPERTIES);
    // rust: let mut cfg = if properties.exists() {
    // rust: let source = config::read_properties(&properties)?;
    // rust: let cfg = Config::import(&source)?;
    // rust: let kept = dir.join("server.properties.imported");
    // rust: std::fs::copy(&properties, &kept).map_err(|e| e.to_string())?;
    // rust: println!(
    // rust: "Imported server.properties into server.toml (the original is kept as {}).",
    // rust: kept.display()
    // rust: );
    // rust: cfg
    // rust: } else {
    // rust: Config::default()
}

    // 1. The EULA: only a yes writes eula=true.
    // rust: let eula_path = dir.join("eula.txt");
    // rust: let agreed = eula::agreed(&eula_path).unwrap_or(false);
    // rust: if !agreed {
    // rust: println!(
    // rust: "Minecraft's End User License Agreement applies to running a server: {}",
    // rust: eula::EULA_LINK
    // rust: );
    // rust: let yes = answers.eula || (prompt.interactive && prompt.yes("Do you agree to it?", false));
    // rust: if !yes {
    // rust: let _ = std::fs::write(&eula_path, eula::file(now_millis(), false));
    // rust: return Err(
    // rust: "the server can't run until you agree to the EULA: run init again and answer yes, \
    // rust: or pass --eula"
    // rust: .into(),
    // rust: );
}
    // rust: std::fs::write(&eula_path, eula::file(now_millis(), true)).map_err(|e| e.to_string())?;
}

    // 2. The world: an existing one keeps its seed.
    // rust: cfg.world.name = answers
    // rust: .world
    // rust: .unwrap_or_else(|| prompt.ask("World name", &cfg.world.name));
    // rust: if dir.join(&cfg.world.name).join("level.dat").exists() {
    // rust: println!("Using the existing world in {}.", cfg.world.name);
    // rust: } else {
    // rust: cfg.world.seed = answers
    // rust: .seed
    // rust: .unwrap_or_else(|| prompt.ask("Seed (empty for a random one)", &cfg.world.seed));
}

    // 3. The port, checked free now rather than at the first start.
    // rust: cfg.server.port = match answers.port {
    // rust: Some(port) => port,
    // rust: None => prompt
    // rust: .ask("Port", &cfg.server.port.to_string())
    // rust: .parse()
    // rust: .map_err(|_| "the port must be a number from 1 to 65535".to_owned())?,
}
    // rust: if std::net::TcpListener::bind(("0.0.0.0", cfg.server.port)).is_err() {
    // rust: println!(
    // rust: "Port {} is in use right now: stop what uses it, or change server.port in server.toml.",
    // rust: cfg.server.port
    // rust: );
}

    // 4. Who may join.
    // rust: if let Some(online) = answers.online {
    // rust: cfg.server.online_mode = online;
}
    // rust: cfg.server.whitelist = answers.whitelist.unwrap_or_else(|| {
    // rust: prompt.yes(
    // rust: "Only let in players you list (whitelist)?",
    // rust: cfg.server.whitelist,
    // rust: )
    // rust: });
    // rust: let mut players = answers.players;
    // rust: if players.is_empty() && cfg.server.whitelist {
    // rust: players = prompt
    // rust: .ask("Players to let in (names, separated by commas)", "")
    // rust: .split([',', ' '])
    // rust: .filter(|n| !n.is_empty())
    // rust: .map(str::to_owned)
    // rust: .collect();
}
    // rust: let op = answers.op.or_else(|| {
    // rust: let first = players.first()?;
    // rust: prompt
    // rust: .yes(&format!("Make {first} an operator?"), true)
    // rust: .then(|| first.clone())
    // rust: });
    // rust: add_players(dir, &players, op.as_deref(), cfg.server.online_mode)?;

    // 5. The game and its files.
    // rust: match engine::program(&cfg, dir) {
    // rust: Ok(program) => {
    // rust: println!("Game: {}", program.display());
    // rust: if let Err(e) = engine::check_starts(&program) {
    // rust: println!("Warning: {e}");
}
    // rust: match engine::resources(&cfg, dir, Some(&program)) {
    // rust: Ok(resources) => {
    // rust: println!("Game files: {}", resources.display());
    // rust: if let Err(e) = engine::check_prepared(&resources) {
    // rust: println!("Warning: {e}");
}
}
    // rust: Err(e) => println!("{e}"),
}
}
    // rust: Err(e) => println!("{e}"),
}

    // rust: std::fs::write(&toml_path, config::render(&cfg)).map_err(|e| e.to_string())?;
    // rust: println!(
    // rust: "Wrote {}. Start the server with: horizon-server run --dir {}",
    // rust: toml_path.display(),
    // rust: dir.display()
    // rust: );
    // rust: if !cfg.server.online_mode {
    // rust: println!(
    // rust: "Note: online mode is off, so anyone can join under any name: keep the whitelist on, or play on a \
    // rust: LAN or a tailnet."
    // rust: );
}
    // rust: Ok(())
}

// Adds players to the whitelist (and one as an operator) in vanilla's files, with the profiles the server
// will see: offline ones, or in online mode their accounts.
    // rust: fn add_players(
    // rust: dir: &Path,
    // rust: players: &[String],
    // rust: op: Option<&str>,
    // rust: online: bool,
    // rust: ) -> Result<(), String> {
    // rust: if !players.is_empty() {
    // rust: let mut white = WhiteList::new(dir.join("whitelist.json"));
    // rust: let _ = white.load();
    // rust: for name in players {
    // rust: white.add(WhiteEntry {
    // rust: user: crate::lists::account(name, online)?,
    // rust: });
}
    // rust: println!("Whitelisted: {}", players.join(", "));
}
    // rust: if let Some(name) = op {
    // rust: let mut ops = OpList::new(dir.join("ops.json"));
    // rust: let _ = ops.load();
    // rust: ops.add(OpEntry {
    // rust: user: crate::lists::account(name, online)?,
    // rust: level: 4,
    // rust: bypasses_player_limit: false,
    // rust: });
    // rust: println!("Operator: {name}");
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;

unattended_init_writes_everything :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-init-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let answers = Answers {
    // rust: eula: true,
    // rust: world: Some("survival".into()),
    // rust: seed: Some("12345".into()),
    // rust: port: Some(25599),
    // rust: whitelist: Some(true),
    // rust: players: vec!["Alex".into(), "Steve".into()],
    // rust: op: Some("Alex".into()),
            // Offline: no account lookups in a test.
    // rust: online: Some(false),
    // rust: yes: true,
}
    // rust: run(&dir, answers).unwrap();
    // rust: let cfg = Config::load(&dir).unwrap();
    // rust: assert_eq!(
    // rust: (
    // rust: cfg.world.name.as_str(),
    // rust: cfg.world.seed.as_str(),
    // rust: cfg.server.port
    // rust: ),
    // rust: ("survival", "12345", 25599)
    // rust: );
    // rust: assert!(eula::agreed(&dir.join("eula.txt")).unwrap());
    // rust: assert!(!cfg.server.online_mode);
    // rust: let white = std::fs::read_to_string(dir.join("whitelist.json")).unwrap();
    // rust: assert!(
    // rust: white.contains("\"Alex\"") && white.contains("\"Steve\""),
    // rust: "{white}"
    // rust: );
    // rust: let ops = std::fs::read_to_string(dir.join("ops.json")).unwrap();
    // rust: assert!(
    // rust: ops.contains("\"Alex\"") && ops.contains("\"level\": 4"),
    // rust: "{ops}"
    // rust: );
        // A second init refuses to overwrite the configuration.
    // rust: assert!(run(&dir, Answers::default()).is_err());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

no_eula_no_server :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-eula-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let answers = Answers {
    // rust: yes: true,
    // rust: ..Answers::default()
}
    // rust: assert!(run(&dir, answers).unwrap_err().contains("EULA"));
    // rust: assert!(!dir.join(config::FILE).exists());
    // rust: assert!(!eula::agreed(&dir.join("eula.txt")).unwrap());
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
