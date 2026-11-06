//! Transpiled from Horizon Rust crate
package horizon_server_mcp

import "core:fmt"
import "core:mem"
import "core:math"

// `horizon-server mcp` (docs/server.md, section 8): the Model Context Protocol over stdin and stdout
// (JSON-RPC 2.0, one message per line, as `horizon-ctl mcp`), so an AI agent can run and moderate a server.
// Each tool is one control API call on the server running in the folder, with the token it reads itself;
// every action shows in the server's log as any other API call does.

// use crate::api::Client;
// use serde_json::{Map, Value, json};
// use std::path::Path;

// What an agent reads before its first call.
INSTRUCTIONS :: "Run and moderate a Horizon (Minecraft Java Edition 26.3) server. Start with status and players. Moderation tools (kick, ban, pardon, ban_ip, op, whitelist...) run vanilla's console commands and answer `changed` and the console's lines; events and logs read what happened since a number they return. Destructive tools that can't be undone need confirm: true."

// The revisions this server advertises: `horizon_mcp` serves them (`2026-07-28` stateless,
// `2025-06-18` for the clients that still open with `initialize`).
server :: proc() -> h {
    // Ported from Horizon
    return {}
}
    // rust: horizon_mcp::Server::new("horizon-server", crate::VERSION, INSTRUCTIONS)
}

// One tool: its name, what it does, its arguments (name, JSON type, what it is, required), and whether it
// destroys or sends someone away.
Tool :: struct {
    name: ^'static str,
    what: ^'static str,
    args: ^'static [(^'static str,
    destructive: bool,
}

NAME :: ("name", "string", "The player's name", true)
REASON :: ("reason", "string", "Why (shown to the player)", false)
CONFIRM :: ("confirm", "boolean", "Must be true", true)

    // rust: const TOOLS: &[Tool] = &[
    // rust: Tool {
    // rust: name: "status",
    // rust: what: "How the server does: phase, uptime, crashes, TPS, MSPT, players, RAM, CPU, updates",
    // rust: args: &[],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "players",
    // rust: what: "Who is online (address, ping, position, op level), the operators, the whitelist and the bans",
    // rust: args: &[],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "run_command",
    // rust: what: "Run a console command (as vanilla's server console) and return what it logged",
    // rust: args: &[("command", "string", "One command, without the slash", true)],
    // rust: destructive: true,
    // rust: },
    // rust: Tool {
    // rust: name: "logs",
    // rust: what: "The log lines after the since-th (the last 2000 are kept); returns next to ask from",
    // rust: args: &[(
    // rust: "since",
    // rust: "integer",
    // rust: "Line number to read after (0: all kept)",
    // rust: false,
    // rust: )],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "events",
    // rust: what: "What happened after event number since: joins, leaves, kicks, chat, deaths, log lines, phase changes; returns next",
    // rust: args: &[
    // rust: (
    // rust: "since",
    // rust: "integer",
    // rust: "Event number to read after (0: all kept)",
    // rust: false,
    // rust: ),
    // rust: (
    // rust: "types",
    // rust: "string",
    // rust: "Comma-separated types, e.g. chat,death (default: all)",
    // rust: false,
    // rust: ),
    // rust: ],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "kick",
    // rust: what: "Kick an online player",
    // rust: args: &[NAME, REASON],
    // rust: destructive: true,
    // rust: },
    // rust: Tool {
    // rust: name: "ban",
    // rust: what: "Ban a player (kicked if online)",
    // rust: args: &[NAME, REASON],
    // rust: destructive: true,
    // rust: },
    // rust: Tool {
    // rust: name: "pardon",
    // rust: what: "Lift a player's ban",
    // rust: args: &[NAME],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "ban_ip",
    // rust: what: "Ban an address, or the address an online player plays from (its players are kicked)",
    // rust: args: &[
    // rust: ("ip", "string", "An IPv4 or IPv6 address", false),
    // rust: ("name", "string", "Or an online player's name", false),
    // rust: REASON,
    // rust: ],
    // rust: destructive: true,
    // rust: },
    // rust: Tool {
    // rust: name: "pardon_ip",
    // rust: what: "Lift an address's ban",
    // rust: args: &[("ip", "string", "The address", true)],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "op",
    // rust: what: "Make a player an operator",
    // rust: args: &[NAME],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "deop",
    // rust: what: "Make a player no longer an operator",
    // rust: args: &[NAME],
    // rust: destructive: true,
    // rust: },
    // rust: Tool {
    // rust: name: "whitelist",
    // rust: what: "Change the whitelist: add or remove a player, or turn it on or off",
    // rust: args: &[
    // rust: ("action", "string", "add, remove, on or off", true),
    // rust: ("name", "string", "The player, for add and remove", false),
    // rust: ],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "list_backups",
    // rust: what: "The backups, newest first",
    // rust: args: &[],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "backup",
    // rust: what: "Back up the world and settings now (a running server saves first and stays up)",
    // rust: args: &[("name", "string", "A label: letters, digits, - and _", false)],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "delete_backup",
    // rust: what: "Delete a backup",
    // rust: args: &[
    // rust: (
    // rust: "name",
    // rust: "string",
    // rust: "Its file name, as list_backups gives it",
    // rust: true,
    // rust: ),
    // rust: CONFIRM,
    // rust: ],
    // rust: destructive: true,
    // rust: },
    // rust: Tool {
    // rust: name: "restore",
    // rust: what: "Restart the server with a backup's world, or with one dimension of it (what it replaces is kept in backups/)",
    // rust: args: &[
    // rust: (
    // rust: "name",
    // rust: "string",
    // rust: "The backup: file name, unique prefix or label",
    // rust: true,
    // rust: ),
    // rust: (
    // rust: "dimension",
    // rust: "string",
    // rust: "Bring back only this dimension, like minecraft:the_nether; the rest of the world stays",
    // rust: false,
    // rust: ),
    // rust: CONFIRM,
    // rust: ],
    // rust: destructive: true,
    // rust: },
    // rust: Tool {
    // rust: name: "get_config",
    // rust: what: "The settings in server.toml",
    // rust: args: &[],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "set_config",
    // rust: what: "Change settings, e.g. {\"world.difficulty\": \"hard\"}; says which apply now and which at the next start",
    // rust: args: &[("changes", "object", "section.name to value", true)],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "start",
    // rust: what: "Start the server in the background and wait until the game is up",
    // rust: args: &[],
    // rust: destructive: false,
    // rust: },
    // rust: Tool {
    // rust: name: "restart",
    // rust: what: "Restart the game (players are disconnected for a moment)",
    // rust: args: &[],
    // rust: destructive: true,
    // rust: },
    // rust: Tool {
    // rust: name: "stop",
    // rust: what: "Stop the game and horizon-server",
    // rust: args: &[CONFIRM],
    // rust: destructive: true,
    // rust: },
    // rust: ];

tools :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: TOOLS
    // rust: .iter()
    // rust: .map(|t| {
    // rust: let properties: Map<String, Value> = t
    // rust: .args
    // rust: .iter()
    // rust: .map(|(name, kind, what, _)| ((*name).to_owned(), json!({ "type": kind, "description": what })))
    // rust: .collect();
    // rust: let required: Vec<&str> = t.args.iter().filter(|a| a.3).map(|a| a.0).collect();
    // rust: json!({
    // rust: "name": t.name,
    // rust: "description": t.what,
    // rust: "inputSchema": { "type": "object", "properties": properties, "required": required },
    // rust: "annotations": {
    // rust: "destructiveHint": t.destructive,
    // rust: "readOnlyHint": matches!(t.name, "status" | "players" | "logs" | "events" | "list_backups" | "get_config"),
    // rust: },
    // rust: })
    // rust: })
    // rust: .collect()
}

// The control API call a tool makes: method, path and body.
request :: proc(name: string, args: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let text = |key: &str| args[key].as_str().map(str::to_owned);
    // rust: let need = |key: &str| text(key).ok_or_else(|| format!("{name} needs {key}"));
    // rust: let confirmed = || {
    // rust: (args["confirm"] == true)
    // rust: .then_some(())
    // rust: .ok_or_else(|| format!("{name} needs confirm: true"))
}
    // rust: let some = |v: Value| -> Value {
    // rust: Value::Object(
    // rust: v.as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|(_, v)| !v.is_null())
    // rust: .map(|(k, v)| (k.clone(), v.clone()))
    // rust: .collect(),
    // rust: )
}
    // rust: let since = args["since"].as_u64().unwrap_or(0);
    // rust: Ok(match name {
    // rust: "status" => ("GET", "/api/v1/status".into(), None),
    // rust: "players" => ("GET", "/api/v1/players".into(), None),
    // rust: "run_command" => (
    // rust: "POST",
    // rust: "/api/v1/command".into(),
    // rust: Some(json!({ "line": need("command")? })),
    // rust: ),
    // rust: "logs" => ("GET", format!("/api/v1/logs?since={since}"), None),
    // rust: "events" => {
    // rust: let types = text("types").unwrap_or_default();
    // rust: if !types.chars().all(|c| c.is_ascii_lowercase() || c == ',') {
    // rust: return Err("types are words like chat,death, separated by commas".into());
}
    // rust: (
    // rust: "GET",
    // rust: format!("/api/v1/events?since={since}&types={types}"),
    // rust: None,
    // rust: )
}
    // rust: "kick" | "ban" => (
    // rust: "POST",
    // rust: format!("/api/v1/players/{name}"),
    // rust: Some(some(
    // rust: json!({ "name": need("name")?, "reason": args["reason"] }),
    // rust: )),
    // rust: ),
    // rust: "pardon" | "op" | "deop" => (
    // rust: "POST",
    // rust: format!("/api/v1/players/{name}"),
    // rust: Some(json!({ "name": need("name")? })),
    // rust: ),
    // rust: "ban_ip" => (
    // rust: "POST",
    // rust: "/api/v1/players/ban-ip".into(),
    // rust: Some(some(
    // rust: json!({ "ip": args["ip"], "name": args["name"], "reason": args["reason"] }),
    // rust: )),
    // rust: ),
    // rust: "pardon_ip" => (
    // rust: "POST",
    // rust: "/api/v1/players/pardon-ip".into(),
    // rust: Some(json!({ "ip": need("ip")? })),
    // rust: ),
    // rust: "whitelist" => match need("action")?.as_str() {
    // rust: action @ ("add" | "remove") => (
    // rust: "POST",
    // rust: format!("/api/v1/whitelist/{action}"),
    // rust: Some(json!({ "name": need("name")? })),
    // rust: ),
    // rust: "on" => (
    // rust: "POST",
    // rust: "/api/v1/whitelist".into(),
    // rust: Some(json!({ "enabled": true })),
    // rust: ),
    // rust: "off" => (
    // rust: "POST",
    // rust: "/api/v1/whitelist".into(),
    // rust: Some(json!({ "enabled": false })),
    // rust: ),
    // rust: other => {
    // rust: return Err(format!(
    // rust: "whitelist's action is add, remove, on or off, not {other:?}"
    // rust: ));
}
    // rust: },
    // rust: "list_backups" => ("GET", "/api/v1/backups".into(), None),
    // rust: "backup" => (
    // rust: "POST",
    // rust: "/api/v1/backups".into(),
    // rust: Some(some(json!({ "name": args["name"] }))),
    // rust: ),
    // rust: "delete_backup" => {
    // rust: confirmed()?;
    // rust: let file = need("name")?;
    // rust: if !file
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_alphanumeric() || "-_.".contains(c))
    // rust: {
    // rust: return Err("a backup's file name has letters, digits, -, _ and . only".into());
}
    // rust: ("DELETE", format!("/api/v1/backups?name={file}"), None)
}
    // rust: "restore" => {
    // rust: confirmed()?;
    // rust: (
    // rust: "POST",
    // rust: "/api/v1/restore".into(),
    // rust: Some(some(
    // rust: json!({ "name": need("name")?, "dimension": args["dimension"] }),
    // rust: )),
    // rust: )
}
    // rust: "get_config" => ("GET", "/api/v1/config".into(), None),
    // rust: "set_config" => (
    // rust: "PATCH",
    // rust: "/api/v1/config".into(),
    // rust: Some(json!({ "changes": args["changes"] })),
    // rust: ),
    // rust: "restart" => ("POST", "/api/v1/restart".into(), None),
    // rust: "stop" => {
    // rust: confirmed()?;
    // rust: ("POST", "/api/v1/stop".into(), None)
}
    // rust: other => return Err(format!("unknown tool {other}")),
    // rust: })
}

// One tool call: its result, and whether it failed.
call :: proc(dir: ^Path, name: string, args: ^Value) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: if name == "start" {
        // `start` prints as it waits: its output goes in the result, not on the protocol's stdout.
    // rust: let started = std::env::current_exe().and_then(|exe| {
    // rust: std::process::Command::new(exe)
    // rust: .arg("--dir")
    // rust: .arg(dir)
    // rust: .arg("start")
    // rust: .stdin(std::process::Stdio::null())
    // rust: .output()
    // rust: });
    // rust: return match started {
    // rust: Ok(out) => (
    // rust: json!({ "output": format!("{}{}", String::from_utf8_lossy(&out.stdout), String::from_utf8_lossy(&out.stderr)) }),
    // rust: !out.status.success(),
    // rust: ),
    // rust: Err(e) => (json!({ "error": e.to_string() }), true),
}
}
    // rust: let result = request(name, args).and_then(|(method, path, body)| {
    // rust: let client = Client::open(dir)?.ok_or_else(|| {
    // rust: format!(
    // rust: "no server is running in {} (the start tool starts it)",
    // rust: dir.display()
    // rust: )
    // rust: })?;
    // rust: client.call(method, &path, body.as_ref())
    // rust: });
    // rust: match result {
    // rust: Ok(value) => (value, false),
    // rust: Err(e) => (json!({ "error": e }), true),
}
}

// The two tool methods; `horizon_mcp` answers the protocol's own (`initialize`,
// `server/discover`) and frames these results for the revision the request speaks.
handle :: proc(dir: ^Path, method: string, params: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match method {
    // rust: "tools/list" => Ok(json!({ "tools": tools() })),
    // rust: "tools/call" => {
    // rust: let name = params
    // rust: .get("name")
    // rust: .and_then(Value::as_str)
    // rust: .ok_or((-32602, "name is required".to_owned()))?;
    // rust: if !TOOLS.iter().any(|t| t.name == name) {
    // rust: return Err((-32602, format!("Unknown tool {name}")));
}
    // rust: let args = params.get("arguments").cloned().unwrap_or(json!({}));
    // rust: let (result, error) = call(dir, name, &args);
    // rust: let text = serde_json::to_string_pretty(&result).unwrap_or_default();
    // rust: Ok(json!({ "content": [{ "type": "text", "text": text }], "isError": error }))
}
    // rust: _ => Err((-32601, format!("Method not found: {method}"))),
}
}

serve :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: server().serve(|method, params| handle(dir, method, params))
}

    // rust: mod tests {

//     use super::*;

MCP_GOLDENS :: include_str!("../testdata/mcp-contract.json")

protocol_line :: proc(method: string, params: Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: json!({ "jsonrpc": "2.0", "id": 1, "method": method, "params": params }).to_string()
}

protocol_and_tool_contracts_match_goldens :: proc() {
}
    // rust: let golden: Value = serde_json::from_str(MCP_GOLDENS).unwrap();
    // rust: let dir = Path::new("mcp-golden-no-server");
    // rust: let mut app = |method: &str, params: &Value| handle(dir, method, params);
    // rust: let initialize = server()
    // rust: .handle_line(
    // rust: &protocol_line("initialize", json!({ "protocolVersion": "2025-06-18" })),
    // rust: &mut app,
    // rust: )
    // rust: .unwrap();
    // rust: let mut meta = serde_json::Map::new();
    // rust: meta.insert(
    // rust: horizon_mcp::VERSION_KEY.to_owned(),
    // rust: json!(horizon_mcp::MODERN),
    // rust: );
    // rust: meta.insert(horizon_mcp::CLIENT_CAPABILITIES_KEY.to_owned(), json!({}));
    // rust: let tools_list = server()
    // rust: .handle_line(
    // rust: &protocol_line("tools/list", json!({ "_meta": Value::Object(meta) })),
    // rust: &mut app,
    // rust: )
    // rust: .unwrap();
    // rust: let calls = [
    // rust: ("status", json!({})),
    // rust: ("stop", json!({})),
    // rust: ("restore", json!({ "name": "backup", "confirm": false })),
    // rust: (
    // rust: "delete_backup",
    // rust: json!({ "name": "bad&name", "confirm": true }),
    // rust: ),
    // rust: ("events", json!({ "types": "chat&since=0" })),
    // rust: ("whitelist", json!({ "action": "clear" })),
    // rust: ];
    // rust: let replies: Vec<Value> = calls
    // rust: .iter()
    // rust: .map(|(name, args)| {
    // rust: let reply = handle(
    // rust: dir,
    // rust: "tools/call",
    // rust: &json!({ "name": name, "arguments": args }),
    // rust: )
    // rust: .unwrap();
    // rust: json!({
    // rust: "name": name,
    // rust: "arguments": args,
    // rust: "isError": reply["isError"],
    // rust: "text": reply["content"][0]["text"],
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let unknown_tool = handle(dir, "tools/call", &json!({ "name": "nope" })).unwrap_err();
    // rust: let unknown_method = handle(dir, "ping", &json!({})).unwrap_err();
    // rust: let tool_contracts: Vec<Value> = tools_list["result"]["tools"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|tool| {
    // rust: let properties = tool["inputSchema"]["properties"]
    // rust: .as_object()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|(name, property)| (name.clone(), property["type"].clone()))
    // rust: .collect::<Map<String, Value>>();
    // rust: json!({
    // rust: "name": tool["name"],
    // rust: "description": tool["description"],
    // rust: "properties": properties,
    // rust: "required": tool["inputSchema"]["required"],
    // rust: "annotations": tool["annotations"],
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let actual = json!({
    // rust: "initialize": initialize["result"],
    // rust: "tools_list": {
    // rust: "resultType": tools_list["result"]["resultType"],
    // rust: "tool_count": tool_contracts.len(),
    // rust: "tools": tool_contracts,
    // rust: },
    // rust: "calls": replies,
    // rust: "unknown_tool": { "code": unknown_tool.0, "message": unknown_tool.1 },
    // rust: "unknown_method": { "code": unknown_method.0, "message": unknown_method.1 },
    // rust: });
    // rust: let _ = std::fs::remove_dir_all(dir);
    // rust: if golden.is_null() {
    // rust: println!("{}", serde_json::to_string_pretty(&actual).unwrap());
    // rust: return;
}
    // rust: assert_eq!(actual, golden);
}

every_tool_has_a_schema_and_a_call :: proc() {
}
    // rust: let list = tools();
    // rust: assert_eq!(list.len(), TOOLS.len());
    // rust: for (tool, t) in list.iter().zip(TOOLS) {
    // rust: assert_eq!(tool["inputSchema"]["type"], "object");
    // rust: if t.name == "start" {
    // rust: continue;
}
            // With every argument given, each tool makes a call (confirm included).
    // rust: let mut args = json!({ "confirm": true, "changes": {} });
    // rust: for (name, kind, _, _) in t.args {
    // rust: if args.get(*name).is_none() {
    // rust: args[*name] = match *kind {
    // rust: "integer" => json!(0),
    // rust: _ if *name == "action" => json!("add"),
    // rust: _ if *name == "ip" => json!("203.0.113.7"),
    // rust: _ if *name == "types" => json!("chat"),
    // rust: _ => json!("Kim0"),
}
}
}
    // rust: assert!(request(t.name, &args).is_ok(), "{}", t.name);
}
}

calls_map_onto_the_api :: proc() {
}
    // rust: let (method, path, body) =
    // rust: request("ban", &json!({ "name": "Lou0", "reason": "cheating" })).unwrap();
    // rust: assert_eq!((method, path.as_str()), ("POST", "/api/v1/players/ban"));
    // rust: assert_eq!(body, Some(json!({ "name": "Lou0", "reason": "cheating" })));
    // rust: let (_, _, body) = request("kick", &json!({ "name": "Kim0" })).unwrap();
    // rust: assert_eq!(body, Some(json!({ "name": "Kim0" })));
    // rust: let (_, path, _) =
    // rust: request("whitelist", &json!({ "action": "remove", "name": "Kim0" })).unwrap();
    // rust: assert_eq!(path, "/api/v1/whitelist/remove");
    // rust: let (_, path, _) =
    // rust: request("events", &json!({ "since": 41, "types": "chat,death" })).unwrap();
    // rust: assert_eq!(path, "/api/v1/events?since=41&types=chat,death");
        // What can't be undone needs confirm: true; nothing reaches the query unchecked.
    // rust: assert!(request("stop", &json!({})).is_err());
    // rust: assert!(request("restore", &json!({ "name": "x", "confirm": false })).is_err());
    // rust: assert!(request("delete_backup", &json!({ "name": "a&b", "confirm": true })).is_err());
    // rust: assert!(request("events", &json!({ "types": "chat&since=0" })).is_err());
    // rust: assert!(request("whitelist", &json!({ "action": "clear" })).is_err());
}

the_protocol_answers_without_a_server :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-mcp-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
        // A client that opens with the handshake revision, as the launcher's game_* tools do.
    // rust: let mut app = |method: &str, params: &Value| handle(&dir, method, params);
    // rust: let line = |method: &str, params: Value| {
    // rust: json!({ "jsonrpc": "2.0", "id": 1, "method": method, "params": params }).to_string()
}
    // rust: let init = server()
    // rust: .handle_line(
    // rust: &line("initialize", json!({ "protocolVersion": "2025-06-18" })),
    // rust: &mut app,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(init["result"]["protocolVersion"], "2025-06-18");
    // rust: assert_eq!(init["result"]["serverInfo"]["name"], "horizon-server");
        // A modern client gets the same tools with the framing that revision requires.
    // rust: let mut meta = serde_json::Map::new();
    // rust: meta.insert(
    // rust: horizon_mcp::VERSION_KEY.to_owned(),
    // rust: json!(horizon_mcp::MODERN),
    // rust: );
    // rust: meta.insert(horizon_mcp::CLIENT_CAPABILITIES_KEY.to_owned(), json!({}));
    // rust: let list = server()
    // rust: .handle_line(
    // rust: &line("tools/list", json!({ "_meta": Value::Object(meta) })),
    // rust: &mut app,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(list["result"]["resultType"], "complete");
    // rust: assert!(list["result"]["tools"].as_array().unwrap().len() > 20);
    // rust: let reply = handle(
    // rust: &dir,
    // rust: "tools/call",
    // rust: &json!({ "name": "players", "arguments": {} }),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(reply["isError"], true);
    // rust: assert!(
    // rust: reply["content"][0]["text"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains("no server is running")
    // rust: );
    // rust: assert_eq!(
    // rust: handle(&dir, "tools/call", &json!({ "name": "nope" }))
    // rust: .unwrap_err()
    // rust: .0,
    // rust: -32602
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
