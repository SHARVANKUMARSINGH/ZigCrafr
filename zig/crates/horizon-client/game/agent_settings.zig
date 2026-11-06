//! Transpiled from Horizon Rust crate
//! Module: horizon-client_agent_settings
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Agent control as a setting (Horizon Settings > AI Agent): when the control socket is open, who
//! is connected, and the details an agent needs. The socket opens when the game was started for
//! an agent (`--control`, `--control-socket`: horizon-ctl launch, the launcher's MCP `play`) or
//! when the player turned Agent Control on, and never under No AI (`horizon_core::no_ai`).
//! Turning either switch in the game opens or closes it at once.
// use super::Game;
// use horizon_client::{Result, control};
// use std::path::PathBuf;

    // rust: impl Game<'_> {
    /// The endpoint: the one the command line gave, else the default horizon-ctl looks for.
pub fn agent_socket_path(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.options
    // rust: .control
    // rust: .clone()
    // rust: .unwrap_or_else(control::default_path)
}

    /// At startup: open the socket if the game was started for an agent or Agent Control is on.
    // rust: pub(super) fn start_agent_control(&mut self) -> Result<()> {
    // rust: self.agent_control_on = self.settings.extras.agent_control;
    // rust: if self.options.benchmark.is_some() && self.options.control.is_none() {
    // rust: return Ok(());
}
    // rust: if self.settings.extras.no_ai {
    // rust: if self.options.control.is_some() {
    // rust: log::warn!(
    // rust: "Horizon: control socket not opened: {}",
    // rust: horizon_core::no_ai::REFUSAL
    // rust: );
}
    // rust: return Ok(());
}
    // rust: if let Some(path) = &self.options.control {
            // Asked for on the command line: failing to listen is an error.
    // rust: let server = control::Server::start(path)
    // rust: .map_err(|e| format!("control socket {}: {e}", path.display()))?;
    // rust: log::info!("Horizon: control socket {}", server.path().display());
    // rust: self.control = Some(server);
    // rust: } else if self.agent_control_on {
    // rust: self.open_agent_socket();
}
    // rust: Ok(())
}

    /// The setting's socket: a failure (another game holds the default endpoint) is logged and
    /// shown on the AI Agent page, not fatal.
pub fn open_agent_socket(self: *Self) void {
}
    // rust: let path = self.agent_socket_path();
    // rust: match control::Server::start(&path) {
    // rust: Ok(server) => {
    // rust: log::info!("Horizon: control socket {}", server.path().display());
    // rust: self.control = Some(server);
}
    // rust: Err(e) => log::warn!("Horizon: control socket {}: {e}", path.display()),
}
}

    /// After a settings change: No AI closes the socket; Agent Control turned on or off opens or
    /// closes it.
    // rust: pub(super) fn sync_agent_control(&mut self) {
    // rust: let wanted = self.settings.extras.agent_control;
    // rust: let changed = wanted != self.agent_control_on;
    // rust: self.agent_control_on = wanted;
    // rust: let open = self
    // rust: .control
    // rust: .as_ref()
    // rust: .is_some_and(|c| !c.path().as_os_str().is_empty());
    // rust: if self.settings.extras.no_ai || (changed && !wanted) {
    // rust: if open {
    // rust: log::info!("Horizon: control socket closed");
    // rust: self.control = None;
}
    // rust: } else if changed && wanted && self.control.is_none() {
    // rust: self.open_agent_socket();
}
}

    /// An agent's command arrived.
    // rust: pub(super) fn agent_command_seen(&mut self) {
    // rust: self.agent_last = Some(std::time::Instant::now());
}

    /// The AI Agent page's lines: the state, then where agents connect.
    // rust: pub(super) fn agent_status_lines(&self) -> Vec<String> {
    // rust: let server = self
    // rust: .control
    // rust: .as_ref()
    // rust: .filter(|c| !c.path().as_os_str().is_empty())
    // rust: .map(|s| Socket {
    // rust: clients: s.clients(),
    // rust: name: s
    // rust: .path()
    // rust: .file_name()
    // rust: .unwrap_or_default()
    // rust: .to_string_lossy()
    // rust: .into_owned(),
    // rust: });
    // rust: let mut lines = status_lines(
    // rust: server,
    // rust: self.agent_last.map(|t| t.elapsed().as_secs()),
    // rust: self.options.control.is_some() && !self.agent_control_on,
    // rust: );
    // rust: if let Some(line) = self.repro.agent_line(self.input_trace.events()) {
    // rust: lines.push(line);
}
    // rust: lines
}

    /// What Copy Connection Details puts on the clipboard: the socket, a horizon-ctl line to try,
    /// and an MCP client's config for this game.
    // rust: pub(super) fn agent_details(&self) -> String {
    // rust: let socket = self.agent_socket_path();
    // rust: let ctl = std::env::current_exe()
    // rust: .unwrap_or_default()
    // rust: .with_file_name(if cfg!(windows) {
    // rust: "horizon-ctl.exe"
    // rust: } else {
    // rust: "horizon-ctl"
    // rust: });
    // rust: let config = serde_json::json!({ "mcpServers": { "horizon-game": {
    // rust: "command": ctl, "args": ["--socket", socket, "mcp"] } } });
    // rust: format!(
    // rust: "Horizon agent control (this computer only)\nSocket: {}\nTry it: \"{}\" --socket \"{}\" state\nMCP config:\n{}\n",
    // rust: socket.display(),
    // rust: ctl.display(),
    // rust: socket.display(),
    // rust: serde_json::to_string_pretty(&config).unwrap_or_default()
    // rust: )
}
}

/// The control socket as the AI Agent page tells of it.
pub const Socket = struct {
    /// Agents connected now.
    clients: usize,
    /// The socket's file name; the full path is too wide for the page (Copy Connection Details
    /// has it).
    name: []const u8,
};

/// The AI Agent page's lines in the selected language: the state, then where agents connect.
/// `last_command` is the seconds since an agent's last command, `session_only` whether the
/// program that started the game opened the socket and the player's switch did not.
    // rust: fn status_lines(
    // rust: server: Option<Socket>,
    // rust: last_command: Option<u64>,
    // rust: session_only: bool,
    // rust: ) -> Vec<String> {
//     use horizon_client::lang::{get, tr};
    // rust: let mut lines = vec![match &server {
    // rust: Some(s) if s.clients > 0 => {
    // rust: let (one, many) = match last_command {
    // rust: Some(_) => ("one_ago", "many_ago"),
    // rust: None => ("one", "many"),
}
    // rust: let key = format!(
    // rust: "horizon.agent.connected.{}",
    // rust: if s.clients == 1 { one } else { many }
    // rust: );
    // rust: let mut args: Vec<&dyn std::fmt::Display> = Vec::new();
    // rust: if s.clients != 1 {
    // rust: args.push(&s.clients);
}
    // rust: if let Some(ago) = &last_command {
    // rust: args.push(ago);
}
    // rust: tr(&key, &args)
}
    // rust: Some(_) => get("horizon.agent.waiting"),
    // rust: None => get("horizon.agent.off"),
    // rust: }];
    // rust: if let Some(s) = &server {
    // rust: if session_only {
    // rust: lines.push(get("horizon.agent.session_opened"));
}
    // rust: lines.push(tr("horizon.agent.socket", &[&s.name]));
}
    // rust: lines.push(get("horizon.agent.local_only"));
    // rust: lines
}

    // rust: mod tests {
//     use super::{Socket, status_lines};
//     use horizon_client::lang::{Language, scoped};

pub fn lines(code: []const u8, clients: usize, ago: ?u64, session_only: bool) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let socket = Socket {
    // rust: clients,
    // rust: name: "ctl.sock".into(),
}
    // rust: let (lines, missed) = scoped(Language::load(&[], code), || {
    // rust: status_lines(Some(socket), ago, session_only)
    // rust: });
    // rust: assert!(missed.is_empty(), "{code}: {missed:?}");
    // rust: lines
}

    /// The AI Agent page told its state in English in every language (#1927).
pub fn agent_page_lines_follow_the_language() void {
}
    // rust: assert_eq!(
    // rust: lines("de_de", 2, Some(5), false),
    // rust: [
    // rust: "Verbunden: 2 Agentenverbindungen, letzter Befehl vor 5 s",
    // rust: "Socket: ctl.sock (Verbindungsdaten kopieren für den vollständigen Pfad)",
    // rust: "Nur lokal: Agenten auf diesem Computer, nie über das Netzwerk.",
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: lines("pl_pl", 1, None, true),
    // rust: [
    // rust: "Połączono: 1 połączenie agenta",
    // rust: "Otwarte na tę sesję przez program, który uruchomił grę.",
    // rust: "Gniazdo: ctl.sock (skopiuj dane, aby poznać pełną ścieżkę)",
    // rust: "Tylko lokalnie: agenci na tym komputerze, nigdy przez sieć.",
    // rust: ]
    // rust: );
    // rust: let (off, missed) = scoped(Language::load(&[], "fr_fr"), || {
    // rust: status_lines(None, None, false)
    // rust: });
    // rust: assert!(missed.is_empty(), "{missed:?}");
    // rust: assert_eq!(
    // rust: off,
    // rust: [
    // rust: "Désactivé : les agents ne peuvent pas joindre ce jeu.",
    // rust: "Local uniquement : agents sur cet ordinateur, jamais via le réseau.",
    // rust: ]
    // rust: );
}

    /// English keeps the sentences it always had: the count, its plural, the time since the last
    /// command, and the wait for a first agent.
pub fn agent_page_lines_in_english() void {
}
    // rust: assert_eq!(
    // rust: lines("en_us", 2, Some(5), false)[0],
    // rust: "Connected: 2 agent connections, last command 5 s ago"
    // rust: );
    // rust: assert_eq!(
    // rust: lines("en_us", 1, None, false)[0],
    // rust: "Connected: 1 agent connection"
    // rust: );
    // rust: assert_eq!(
    // rust: lines("en_us", 1, Some(0), false)[0],
    // rust: "Connected: 1 agent connection, last command 0 s ago"
    // rust: );
    // rust: assert_eq!(
    // rust: lines("en_us", 3, None, false)[0],
    // rust: "Connected: 3 agent connections"
    // rust: );
    // rust: assert_eq!(lines("en_us", 0, None, true)[0], "Waiting for an agent.");
}
}
