//! Transpiled from Horizon Rust crate
//! Module: horizon-mcp_lib
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The Model Context Protocol, as Horizon's three servers speak it (`horizon-ctl mcp`,
//! `horizon-server mcp`, `horizon-launcher mcp`: docs/agent-control.md, docs/server.md section 8):
//! JSON-RPC 2.0 over stdin and stdout, one message per line.
//!
//! Two revisions, newest first. `2026-07-28` is stateless: every request carries its version,
//! its capabilities and who it is in `_meta`, servers answer `server/discover`, every result
//! says `resultType`, and the list results carry `ttlMs` and `cacheScope`. `2025-06-18` opens
//! with `initialize` and is kept for the clients that still do that (the launcher's `game_*`
//! tools talk to whichever `horizon-ctl` version the player has installed, which may be older
//! than this crate). A request carrying `_meta` is served statelessly whatever the process
//! answered before it, as the revision requires.
//!
//! Each server supplies its identity, its instructions and the two tool methods; the protocol
//! methods (`server/discover`, `initialize`), the framing and the line loop live here, so the
//! three cannot drift apart.

// use serde_json::{Map, Value, json};
// use std::io::{BufRead, Write};

/// The newest revision: no handshake, every request carries `_meta`.
pub const MODERN: []const u8 = "2026-07-28";
/// The handshake revision, still served for the clients that call `initialize`.
pub const LEGACY: []const u8 = "2025-06-18";
/// Every revision served here, newest first: what `server/discover` advertises.
pub const VERSIONS: *[[]const u8] = &[MODERN, LEGACY];
/// The revisions `initialize` may select: the stateless one has no handshake to open.
pub const LEGACY_VERSIONS: *[[]const u8] = &[LEGACY];

/// `_meta` key: the protocol version the request uses (required on every modern request).
pub const VERSION_KEY: []const u8 = "io.modelcontextprotocol/protocolVersion";
/// `_meta` key: the client's capabilities (required on every modern request).
pub const CLIENT_CAPABILITIES_KEY: []const u8 = "io.modelcontextprotocol/clientCapabilities";
/// `_meta` key: who the server is, in every modern result.
pub const SERVER_INFO_KEY: []const u8 = "io.modelcontextprotocol/serverInfo";

/// `UnsupportedProtocolVersion`: the request named a revision this server does not serve.
pub const UNSUPPORTED_PROTOCOL_VERSION: i64 = -32022;

/// `ttlMs` for `tools/list`: starting a game or a server adds tools to the launcher's list, and
/// no `notifications/tools/list_changed` follows it (that needs `subscriptions/listen`), so the
/// hint stays short rather than hiding the new tools until it expires.
pub const LIST_TTL_MS: i64 = 30_000;
/// `ttlMs` for `server/discover`: versions, capabilities and identity are fixed per process.
pub const DISCOVER_TTL_MS: i64 = 3_600_000;
/// Neither list holds anything specific to one caller.
pub const CACHE_SCOPE: []const u8 = "public";

/// One server: who it says it is, and what an agent reads before its first call.
pub const Server = struct {
    name: *'a str,
    version: *'a str,
    instructions: *'a str,
};

/// A failed request: the JSON-RPC code, its message, and the `data` some errors carry.
pub const Fault = struct {
    code: i64,
    message: []const u8,
    data: ?Value,
};

    // rust: impl Fault {
pub fn new(code: i64, message: impl Into<[]const u8>) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: code,
    // rust: message: message.into(),
    // rust: data: None,
}
}

pub fn with(data: Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data = Some(data);
    // rust: self
}
}

    // rust: impl From<(i64, String)> for Fault {
pub fn from() void {
}
    // rust: Self::new(code, message)
}
}

/// `initialize` (the handshake revision): the client's version when it is one we serve,
/// otherwise ours. The client has no fall-forward, so never claim one we do not implement.
pub fn negotiate_legacy(params: *Value) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let wanted = params.get("protocolVersion").and_then(Value::as_str);
    // rust: LEGACY_VERSIONS
    // rust: .iter()
    // rust: .copied()
    // rust: .find(|v| Some(*v) == wanted)
    // rust: .unwrap_or(LEGACY_VERSIONS[0])
}

    // rust: impl<'a> Server<'a> {
    // rust: pub const fn new(name: &'a str, version: &'a str, instructions: &'a str) -> Self {
    // rust: Server {
    // rust: name,
    // rust: version,
    // rust: instructions,
}
}

    /// Serve the process's stdin and stdout until the client closes them.
    ///
    /// `app` answers the two tool methods (`tools/list` and `tools/call`); the protocol
    /// methods and the framing are this module's.
    // rust: pub fn serve<F>(&self, mut app: F) -> Result<(), String>
    // rust: where
    // rust: F: FnMut(&str, &Value) -> Result<Value, (i64, String)>,
    // rust: {
    // rust: let stdin = std::io::stdin();
    // rust: let mut stdout = std::io::stdout();
    // rust: for line in stdin.lock().lines() {
    // rust: let Ok(line) = line else { break };
    // rust: if line.trim().is_empty() {
    // rust: continue;
}
    // rust: if let Some(reply) = self.handle_line(&line, &mut app) {
    // rust: writeln!(stdout, "{reply}")
    // rust: .and_then(|_| stdout.flush())
    // rust: .map_err(|e| e.to_string())?;
}
}
    // rust: Ok(())
}

    /// One line of stdin in, one line of stdout out; none for a notification.
    // rust: pub fn handle_line<F>(&self, line: &str, app: &mut F) -> Option<Value>
    // rust: where
    // rust: F: FnMut(&str, &Value) -> Result<Value, (i64, String)>,
    // rust: {
    // rust: match serde_json::from_str::<Value>(line) {
    // rust: Ok(message) => self.handle(&message, app),
    // rust: Err(e) => Some(error(Value::Null, -32700, e.to_string(), None)),
}
}

    // rust: fn handle<F>(&self, message: &Value, app: &mut F) -> Option<Value>
    // rust: where
    // rust: F: FnMut(&str, &Value) -> Result<Value, (i64, String)>,
    // rust: {
        // A request has an id, a notification has none and gets no reply.
    // rust: let id = match message.get("id") {
    // rust: None => return None,
    // rust: Some(Value::Null) => {
    // rust: return Some(error(
    // rust: Value::Null,
    // rust: -32600,
    // rust: "A request's id is a string or an integer, not null".into(),
    // rust: None,
    // rust: ));
}
    // rust: Some(id) => id.clone(),
}
    // rust: let method = message
    // rust: .get("method")
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or_default();
    // rust: let params = message.get("params").cloned().unwrap_or_else(|| json!({}));
    // rust: Some(match self.dispatch(method, &params, app) {
    // rust: Ok(result) => json!({ "jsonrpc": "2.0", "id": id, "result": result }),
    // rust: Err(Fault {
    // rust: code,
    // rust: message,
    // rust: data,
    // rust: }) => error(id, code, message, data),
    // rust: })
}

    // rust: fn dispatch<F>(&self, method: &str, params: &Value, app: &mut F) -> Result<Value, Fault>
    // rust: where
    // rust: F: FnMut(&str, &Value) -> Result<Value, (i64, String)>,
    // rust: {
        // `initialize` opens the handshake revision, whatever else the request carries.
    // rust: if method == "initialize" {
    // rust: return Ok(self.initialize(params));
}
        // `server/discover` is always answered modern: it is how a client learns the versions
        // this server serves, and the probe a client that speaks both revisions sends first.
    // rust: if method == "server/discover" {
    // rust: return Ok(self.discover());
}
        // The revision comes from the request itself. Without `_meta` the client is on the
        // handshake revision; with it, the version it names must be one we serve.
    // rust: let version = match meta(params, VERSION_KEY) {
    // rust: None => None,
    // rust: Some(requested) => match VERSIONS.iter().copied().find(|v| *v == requested) {
    // rust: Some(version) => Some(version),
    // rust: None => {
    // rust: return Err(Fault::new(
    // rust: UNSUPPORTED_PROTOCOL_VERSION,
    // rust: "Unsupported protocol version",
    // rust: )
    // rust: .with(json!({ "supported": VERSIONS, "requested": requested })));
}
    // rust: },
}
        // A modern request without the client's capabilities is malformed (-32602), and the
        // server must not rely on capabilities the client did not declare.
    // rust: if version == Some(MODERN) && meta_value(params, CLIENT_CAPABILITIES_KEY).is_none() {
    // rust: return Err(Fault::new(
    // rust: -32602,
    // rust: format!("_meta.{CLIENT_CAPABILITIES_KEY} is required"),
    // rust: ));
}
    // rust: let result = match method {
    // rust: "tools/list" | "tools/call" => app(method, params).map_err(Fault::from)?,
            // `ping` was removed in 2026-07-28: only the handshake revision still has it.
    // rust: "ping" if version != Some(MODERN) => json!({}),
    // rust: _ => return Err(Fault::new(-32601, format!("Method not found: {method}"))),
}
    // rust: Ok(self.frame(version, method, result))
}

    /// `initialize`: the handshake revision's answer, unchanged since 2025-06-18.
pub fn initialize(self: *Self, params: *Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "protocolVersion": negotiate_legacy(params),
    // rust: "capabilities": self.capabilities(),
    // rust: "serverInfo": self.info(),
    // rust: "instructions": self.instructions,
    // rust: })
}

    /// `server/discover`: the versions, capabilities and identity of this server.
pub fn discover(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({
    // rust: "resultType": "complete",
    // rust: "supportedVersions": VERSIONS,
    // rust: "capabilities": self.capabilities(),
    // rust: "_meta": meta_object(self.info()),
    // rust: "instructions": self.instructions,
    // rust: "ttlMs": DISCOVER_TTL_MS,
    // rust: "cacheScope": CACHE_SCOPE,
    // rust: })
}

    /// What every revision since 2026-07-28 puts around a result: its type, the cache hints on
    /// the cacheable ones, and who answered. The handshake revision's results carry none of it.
pub fn frame(self: *Self, version: ?*'static str, method: []const u8, mut result: Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if version != Some(MODERN) {
    // rust: return result;
}
    // rust: let Some(object) = result.as_object_mut() else {
    // rust: return result;
}
    // rust: object.insert("resultType".into(), json!("complete"));
    // rust: if method == "tools/list" {
    // rust: object.insert("ttlMs".into(), json!(LIST_TTL_MS));
    // rust: object.insert("cacheScope".into(), json!(CACHE_SCOPE));
}
    // rust: let meta = object.entry("_meta").or_insert_with(|| json!({}));
    // rust: if let Some(meta) = meta.as_object_mut() {
    // rust: meta.insert(SERVER_INFO_KEY.into(), self.info());
}
    // rust: result
}

pub fn info(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({ "name": self.name, "version": self.version })
}

    /// Only tools: no resources, prompts, sampling or logging to declare.
pub fn capabilities(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({ "tools": {} })
}
}

/// A header of the request's `params`, whatever its type.
    // rust: fn meta_value<'v>(params: &'v Value, key: &str) -> Option<&'v Value> {
    // rust: params.get("_meta")?.get(key)
}

/// A header of the request's `params`, when it is a string.
    // rust: fn meta<'v>(params: &'v Value, key: &str) -> Option<&'v str> {
    // rust: meta_value(params, key)?.as_str()
}

/// A result's `_meta`: who answered.
pub fn meta_object(info: Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut meta = Map::new();
    // rust: meta.insert(SERVER_INFO_KEY.to_owned(), info);
    // rust: Value::Object(meta)
}

pub fn error(id: Value, code: i64, message: []const u8, data: ?Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut error = json!({ "code": code, "message": message });
    // rust: if let Some(data) = data {
    // rust: error["data"] = data;
}
    // rust: json!({ "jsonrpc": "2.0", "id": id, "error": error })
}

    // rust: mod tests {
//     use super::*;

pub const SERVER: Server = Server::new("test-server", "1.2.3", "Do the thing.");

    /// The answer to one request, with a tool list and a tool result the way a server answers them.
pub fn answer(request: Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut app = |method: &str, _params: &Value| match method {
    // rust: "tools/list" => Ok(json!({ "tools": [{ "name": "state" }] })),
    // rust: "tools/call" => {
    // rust: Ok(json!({ "content": [{ "type": "text", "text": "ok" }], "isError": false }))
}
    // rust: other => Err((-32601, format!("Method not found: {other}"))),
}
    // rust: SERVER.handle_line(&request.to_string(), &mut app).unwrap()
}

    /// A modern request's `params`: the version and the capabilities `_meta` must carry.
pub fn modern(mut params: Value, version: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut meta = Map::new();
    // rust: meta.insert(VERSION_KEY.to_owned(), json!(version));
    // rust: meta.insert(CLIENT_CAPABILITIES_KEY.to_owned(), json!({}));
    // rust: params["_meta"] = Value::Object(meta);
    // rust: params
}

pub fn request(id: i64, method: []const u8, params: Value) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: json!({ "jsonrpc": "2.0", "id": id, "method": method, "params": params })
}

pub fn initialize_answers_a_version_we_serve() void {
}
    // rust: let reply = answer(request(
    // rust: 1,
    // rust: "initialize",
    // rust: json!({ "protocolVersion": "2025-06-18" }),
    // rust: ));
    // rust: assert_eq!(reply["result"]["protocolVersion"], LEGACY);
    // rust: assert_eq!(reply["result"]["serverInfo"]["name"], "test-server");
    // rust: assert_eq!(reply["result"]["serverInfo"]["version"], "1.2.3");
    // rust: assert_eq!(reply["result"]["instructions"], "Do the thing.");
    // rust: assert_eq!(reply["result"]["capabilities"]["tools"], json!({}));
        // The handshake revision's results carry no `resultType`.
    // rust: assert!(reply["result"].get("resultType").is_none());
}

pub fn initialize_never_claims_a_version_we_do_not_serve() void {
}
    // rust: for wanted in [
    // rust: json!({ "protocolVersion": MODERN }),
    // rust: json!({ "protocolVersion": "1999-01-01" }),
    // rust: json!({ "protocolVersion": 7 }),
    // rust: json!({}),
    // rust: ] {
    // rust: let reply = answer(request(1, "initialize", wanted));
    // rust: assert_eq!(reply["result"]["protocolVersion"], LEGACY);
}
}

pub fn discover_lists_what_this_server_serves() void {
}
        // No `_meta`: the stdio probe a client that speaks both revisions sends first.
    // rust: let reply = answer(request(1, "server/discover", json!({})));
    // rust: let result = &reply["result"];
    // rust: assert_eq!(result["resultType"], "complete");
    // rust: assert_eq!(result["supportedVersions"], json!(VERSIONS));
    // rust: assert_eq!(result["capabilities"]["tools"], json!({}));
    // rust: assert_eq!(result["_meta"][SERVER_INFO_KEY]["name"], "test-server");
    // rust: assert_eq!(result["instructions"], "Do the thing.");
    // rust: assert_eq!(result["ttlMs"], json!(DISCOVER_TTL_MS));
    // rust: assert_eq!(result["cacheScope"], CACHE_SCOPE);
}

pub fn an_unsupported_version_is_an_error_that_lists_ours() void {
}
    // rust: let reply = answer(request(1, "tools/list", modern(json!({}), "1900-01-01")));
    // rust: assert_eq!(
    // rust: reply["error"]["code"],
    // rust: json!(UNSUPPORTED_PROTOCOL_VERSION),
    // rust: "{reply}"
    // rust: );
    // rust: assert_eq!(reply["error"]["data"]["requested"], "1900-01-01");
    // rust: assert_eq!(reply["error"]["data"]["supported"], json!(VERSIONS));
}

pub fn a_modern_request_without_capabilities_is_malformed() void {
}
    // rust: let mut params = json!({});
    // rust: params["_meta"] = json!({ VERSION_KEY: MODERN });
    // rust: let reply = answer(request(1, "tools/list", params));
    // rust: assert_eq!(reply["error"]["code"], json!(-32602));
    // rust: assert!(
    // rust: reply["error"]["message"]
    // rust: .as_str()
    // rust: .unwrap()
    // rust: .contains(CLIENT_CAPABILITIES_KEY)
    // rust: );
}

pub fn tools_list_is_cacheable_and_identified() void {
}
    // rust: let reply = answer(request(1, "tools/list", modern(json!({}), MODERN)));
    // rust: let result = &reply["result"];
    // rust: assert_eq!(result["resultType"], "complete");
    // rust: assert_eq!(result["ttlMs"], json!(LIST_TTL_MS));
    // rust: assert_eq!(result["cacheScope"], CACHE_SCOPE);
    // rust: assert_eq!(result["_meta"][SERVER_INFO_KEY]["name"], "test-server");
    // rust: assert_eq!(result["tools"][0]["name"], "state");
}

pub fn tools_call_says_it_completed_but_is_not_cacheable() void {
}
    // rust: let reply = answer(request(
    // rust: 1,
    // rust: "tools/call",
    // rust: modern(json!({ "name": "state" }), MODERN),
    // rust: ));
    // rust: let result = &reply["result"];
    // rust: assert_eq!(result["resultType"], "complete");
    // rust: assert_eq!(result["isError"], false);
    // rust: assert_eq!(result["_meta"][SERVER_INFO_KEY]["version"], "1.2.3");
    // rust: assert!(result.get("ttlMs").is_none(), "{result}");
}

pub fn the_handshake_revisions_results_stay_as_they_were() void {
}
        // A legacy client sends no `_meta`, and its results carry no modern framing.
    // rust: let list = answer(request(1, "tools/list", json!({})));
    // rust: assert_eq!(list["result"], json!({ "tools": [{ "name": "state" }] }));
    // rust: let call = answer(request(2, "tools/call", json!({ "name": "state" })));
    // rust: assert_eq!(
    // rust: call["result"],
    // rust: json!({ "content": [{ "type": "text", "text": "ok" }], "isError": false })
    // rust: );
}

pub fn ping_belongs_to_the_handshake_revision_only() void {
}
    // rust: assert_eq!(answer(request(1, "ping", json!({})))["result"], json!({}));
    // rust: assert_eq!(
    // rust: answer(request(1, "ping", modern(json!({}), MODERN)))["error"]["code"],
    // rust: json!(-32601)
    // rust: );
}

pub fn unknown_methods_and_notifications() void {
}
    // rust: let reply = answer(request(1, "nope/nope", json!({})));
    // rust: assert_eq!(reply["error"]["code"], json!(-32601));
        // A notification (no id) gets no reply at all.
    // rust: let mut app = |_: &str, _: &Value| Ok(json!({}));
    // rust: let note = json!({ "jsonrpc": "2.0", "method": "notifications/initialized" });
    // rust: assert!(SERVER.handle_line(&note.to_string(), &mut app).is_none());
}

pub fn a_request_whose_id_is_null_is_invalid() void {
}
    // rust: let mut app = |_: &str, _: &Value| Ok(json!({}));
    // rust: let line = json!({ "jsonrpc": "2.0", "id": null, "method": "tools/list" });
    // rust: let reply = SERVER.handle_line(&line.to_string(), &mut app).unwrap();
    // rust: assert_eq!(reply["error"]["code"], json!(-32600));
}

pub fn a_broken_line_is_a_parse_error() void {
}
    // rust: let mut app = |_: &str, _: &Value| Ok(json!({}));
    // rust: let reply = SERVER.handle_line("{not json", &mut app).unwrap();
    // rust: assert_eq!(reply["error"]["code"], json!(-32700));
    // rust: assert_eq!(reply["id"], Value::Null);
}

pub fn an_app_error_stays_a_json_rpc_error() void {
}
    // rust: let mut app = |_: &str, _: &Value| Err((-32602, "name is required".to_string()));
    // rust: let reply = SERVER
    // rust: .handle_line(&request(1, "tools/call", json!({})).to_string(), &mut app)
    // rust: .unwrap();
    // rust: assert_eq!(reply["error"]["code"], json!(-32602));
    // rust: assert_eq!(reply["error"]["message"], "name is required");
}
}
