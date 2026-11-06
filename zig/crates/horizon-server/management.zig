//! Transpiled from Horizon Rust crate
//! Module: horizon-server_management
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla's server management protocol (docs/server.md, section 8): JSON-RPC 2.0 over a WebSocket, which
//! `management-server-*` in server.properties (`[properties]` in server.toml) turns on, as vanilla 26.3's
//! `net.minecraft.server.jsonrpc` serves it: the same authentication (`AuthenticationHandler`), the same
//! errors and parameter checks (`Connection`, `IncomingRpcMethod`, `JsonRPCErrors`). The supervisor serves it,
//! so it answers while the game restarts. TLS, on by default as in vanilla, is `management_tls.rs`. What
//! `rpc.discover` lists is in `management_schema.rs`, the methods that answer in `management_methods.rs`.

// use crate::{
    // rust: api::{Phase, Shared},
    // rust: http::{self, Request, Response},
    // rust: management_schema as schema, management_tls,
    // rust: websocket::{Link, Socket},
}
// use horizon_server_files::properties::{ServerProperties, SystemEntropy, generate_secret_key};
// use serde_json::{Value, json};
// use std::{
    // rust: net::{SocketAddr, TcpListener, TcpStream, ToSocketAddrs},
    // rust: path::Path,
    // rust: sync::{
    // rust: Arc, Mutex,
    // rust: atomic::{AtomicBool, AtomicI32, AtomicU64, Ordering},
    // rust: mpsc,
    // rust: },
    // rust: time::{Duration, Instant},
}

/// The connections that have upgraded, and the queue that carries notifications to them, which
/// `JsonRpcNotificationService.broadcastNotification` does to every `Connection` of the `ManagementServer`.
/// A queue and a thread, so that a caller (the game's output pump, the supervisor) never waits on a slow client.
pub const Clients = struct {
    sockets: Mutex<Vec<(u32,
    outbox: Mutex<?mpsc::Sender<[]const u8>>,
    /// `server/stopping` went out for this run of the game: a stop comes from the supervisor and from the
    /// game's own `stop`, and one run says it once.
    stopping_told: AtomicBool,
    /// When `server/activity` last went out.
    activity_told: Mutex<?Instant>,
    /// `status-heartbeat-interval` as the server reports it, in seconds: no heartbeat at 0 or less.
    heartbeat_seconds: AtomicI32,
    /// How many times it was set. Each set restarts the countdown, as vanilla cancels the heartbeat and
    /// schedules a new one (`ManagementServer.scheduleHeartbeat`).
    heartbeat_set: AtomicU64,
    /// A set to 0 or less cancelled a running heartbeat and scheduled none: vanilla's
    /// `ManagementServer.heartbeat` keeps the cancelled future, and `cancel(true)` on it returns false, so
    /// every later set is refused until the server restarts.
    heartbeat_cancelled: Mutex<bool>,
};

/// `DedicatedServer.getStatusHeartbeatInterval`: the seconds between the status notifications, 0 or less for
/// none.
pub fn heartbeat_seconds(shared: *Shared) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: shared.management.heartbeat_seconds.load(Ordering::Relaxed)
}

/// `DedicatedServer.setStatusHeartbeatInterval`: from now on, a status notification every `seconds`, the first
/// after as many; none for 0 or less. The countdown starts again even when the value is the one it had.
/// False, with nothing changed, once a set to 0 or less stopped a running heartbeat
/// (`ManagementServer.scheduleHeartbeat` cannot cancel the cancelled one again).
pub fn set_heartbeat_seconds(shared: *Shared, seconds: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m = &shared.management;
    // rust: let mut cancelled = m.heartbeat_cancelled.lock().unwrap();
    // rust: if *cancelled {
    // rust: return false;
}
    // rust: let was_running = m.heartbeat_seconds.load(Ordering::Relaxed) > 0;
    // rust: *cancelled = was_running && seconds <= 0;
    // rust: m.heartbeat_seconds.store(seconds, Ordering::Relaxed);
    // rust: m.heartbeat_set.fetch_add(1, Ordering::Relaxed);
    // rust: true
}

/// `MinecraftServer.SERVER_ACTIVITY_MONITOR_SECONDS_BETWEEN_NOTIFICATIONS`.
pub const ACTIVITY_EVERY: Duration = Duration::from_secs(30);

/// A connection in `Clients` for as long as this lives.
pub const Registered = struct {};

    // rust: impl Drop for Registered<'_> {
pub fn drop(self: *Self) void {
}
    // rust: let id = self.1;
    // rust: self.0
    // rust: .management
    // rust: .sockets
    // rust: .lock()
    // rust: .unwrap()
    // rust: .retain(|(client, _)| *client != id);
}
}

/// A notification to every connected client: `short` is the method without `minecraft:` and `params` its one
/// parameter, as `JsonRPCUtils.createRequest` writes a request without an `id`.
pub fn notify(shared: *Shared, short: []const u8, params: ?Value) void {
}
    // rust: let mut message = json!({ "jsonrpc": "2.0", "method": format!("minecraft:{short}") });
    // rust: if let Some(params) = params {
    // rust: message["params"] = json!([params]);
}
    // rust: if let Some(outbox) = shared.management.outbox.lock().unwrap().as_ref() {
    // rust: let _ = outbox.send(message.to_string());
}
}

/// `NotificationService.serverStarted`, after the game's `Done`: a new run of the game.
pub fn started(shared: *Shared) void {
}
    // rust: shared
    // rust: .management
    // rust: .stopping_told
    // rust: .store(false, Ordering::SeqCst);
    // rust: notify(shared, "notification/server/started", None);
}

/// The notification a typed event of the game is, if vanilla sends one for it: a player who joined or left
/// (`playerJoined`, `playerLeft`, with the player as a `PlayerDto`), a world save that began or ended
/// (`serverSaveStarted`, `serverSaveCompleted`), and a change of the operators, the allowlist, the bans or the
/// IP bans.
pub fn game_event(shared: *Shared, kind: []const u8, event: *Value) void {
}
    // rust: let player = || Some(json!({ "id": event["uuid"], "name": event["name"] }));
    // rust: let (method, params) = match kind {
    // rust: "join" => ("notification/players/joined", player()),
    // rust: "leave" => ("notification/players/left", player()),
    // rust: "saving" => ("notification/server/saving", None),
    // rust: "saved" => ("notification/server/saved", None),
        // `ServerActivityMonitor.reportLoginActivity`: a login attempt, told at most once in thirty seconds.
    // rust: "login_activity" => {
    // rust: if activity_due(shared, Instant::now()) {
    // rust: notify(shared, "notification/server/activity", None);
}
    // rust: return;
}
        // A change of a list, whoever made it: the console, a command in the game, the protocol's own methods.
    // rust: _ => match crate::management_methods::list_notification(kind, event) {
    // rust: Some((method, params)) => (method, Some(params)),
    // rust: None => return,
    // rust: },
}
    // rust: notify(shared, method, params);
}

/// `ServerActivityMonitor.processWithRateLimit`: an activity is told when thirty seconds have gone by since the
/// last one told, and is lost otherwise (the monitor clears its flag whatever it did).
pub fn activity_due(shared: *Shared, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut told = shared.management.activity_told.lock().unwrap();
    // rust: let due = told.is_none_or(|last| now.saturating_duration_since(last) >= ACTIVITY_EVERY);
    // rust: if due {
    // rust: *told = Some(now);
}
    // rust: due
}

/// `ManagementServer.scheduleHeartbeat`: `NotificationService.statusHeartbeat` every `heartbeat_seconds` (the
/// first after as many), with the server's status as `server/status` answers it, up or not. The interval can
/// change while the server runs (`serversettings/status_heartbeat_interval/set`), so the thread is always
/// there and counts the seconds itself, from the start again at each set. Nothing is computed while no client
/// is connected.
pub fn heartbeat(shared: *Shared) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::thread::Builder::new()
    // rust: .name("management-heartbeat".into())
    // rust: .spawn(move || {
    // rust: let mut generation = shared.management.heartbeat_set.load(Ordering::Relaxed);
    // rust: let mut waited = 0i64;
    // rust: loop {
    // rust: std::thread::sleep(Duration::from_secs(1));
    // rust: let set = shared.management.heartbeat_set.load(Ordering::Relaxed);
    // rust: if set != generation {
    // rust: generation = set;
    // rust: waited = 0;
}
    // rust: let seconds = i64::from(heartbeat_seconds(&shared));
    // rust: if seconds <= 0 {
    // rust: waited = 0;
    // rust: continue;
}
    // rust: waited += 1;
    // rust: if waited >= seconds {
    // rust: waited = 0;
    // rust: if !shared.management.sockets.lock().unwrap().is_empty() {
    // rust: let status = crate::management_methods::status(&shared);
    // rust: notify(&shared, "notification/server/status", Some(status));
}
}
}
    // rust: })
    // rust: .map(drop)
}

/// `NotificationService.serverShuttingDown`, which `DedicatedServer.stopServer` sends first of all.
pub fn stopping(shared: *Shared) void {
}
    // rust: if !shared.management.stopping_told.swap(true, Ordering::SeqCst) {
    // rust: notify(shared, "notification/server/stopping", None);
}
}

/// The management server's settings, read from server.properties as vanilla's `JsonRpc.create` reads them.
pub const Settings = struct {
    host: []const u8,
    port: i32,
    secret: []const u8,
    allowed_origins: std.ArrayList([]const u8),
    /// TLS, unless `management-server-tls-enabled=false`.
    tls: ?management_tls::Tls,
    /// `status-heartbeat-interval`: seconds between the status notifications, none when 0 or less.
    heartbeat: i32,
};

/// `SecurityConfig.isValid`: 40 letters and digits.
pub fn valid_secret(secret: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: secret.len() == 40 && secret.bytes().all(|b| b.is_ascii_alphanumeric())
}

/// The settings when the server is on. Vanilla writes the secret it generates into server.properties; here
/// it goes into server.toml's `[properties]` too, which writes server.properties.
pub fn settings(dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let config = crate::config::Config::load(dir)?;
    // rust: config
    // rust: .write_properties(dir)
    // rust: .map_err(|e| format!("server.properties: {e}"))?;
    // rust: let file = crate::config::read_properties(&dir.join(crate::config::PROPERTIES))?;
    // rust: let generated = file.get("management-server-secret").is_none();
    // rust: let p = ServerProperties::new(file, &mut SystemEntropy::default())?;
    // rust: if !p.management_server_enabled {
    // rust: return Ok(None);
}
    // rust: let heartbeat = p.status_heartbeat_interval;
    // rust: let mut secret = p.management_server_secret;
    // rust: if generated {
    // rust: secret = generate_secret_key(&mut SystemEntropy::default());
    // rust: crate::config::update_all(
    // rust: dir,
    // rust: &[(
    // rust: "properties".into(),
    // rust: "management-server-secret".into(),
    // rust: toml::Value::String(secret.clone()),
    // rust: )],
    // rust: )?;
}
    // rust: if !valid_secret(&secret) {
    // rust: return Err("Invalid management server secret, must be 40 alphanumeric characters".into());
}
    // rust: let tls = if p.management_server_tls_enabled {
    // rust: let (keystore, password) = if p.management_server_tls_keystore.is_empty() {
            // Where vanilla stops, Horizon makes a keystore and writes where it is, as it writes the secret.
    // rust: let password = management_tls::generate(dir, &p.management_server_host)?;
    // rust: let key = |name: &str, value: &str| {
    // rust: (
    // rust: "properties".into(),
    // rust: name.into(),
    // rust: toml::Value::String(value.into()),
    // rust: )
}
    // rust: crate::config::update_all(
    // rust: dir,
    // rust: &[
    // rust: key("management-server-tls-keystore", management_tls::GENERATED),
    // rust: key("management-server-tls-keystore-password", &password),
    // rust: ],
    // rust: )?;
    // rust: (management_tls::GENERATED.to_owned(), password)
    // rust: } else {
    // rust: (
    // rust: p.management_server_tls_keystore,
    // rust: management_tls::password(&p.management_server_tls_keystore_password),
    // rust: )
}
    // rust: Some(
    // rust: management_tls::load(dir, &keystore, &password)
    // rust: .map_err(|e| format!("{TLS_FAILED}: {e}"))?,
    // rust: )
    // rust: } else {
    // rust: None
}
    // rust: Ok(Some(Settings {
    // rust: host: p.management_server_host,
    // rust: port: p.management_server_port,
    // rust: secret,
    // rust: allowed_origins: p
    // rust: .management_server_allowed_origins
    // rust: .split(',')
    // rust: .map(str::to_owned)
    // rust: .collect(),
    // rust: tls,
    // rust: heartbeat,
    // rust: }))
}

pub const TLS_FAILED: []const u8 = "Failed to configure TLS for the server management protocol";

/// Starts the management server if server.properties turns it on. A wrong secret or TLS setting stops the
/// server from starting, as it stops vanilla's.
pub fn start(shared: *Shared) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let note = |line: &str| crate::supervisor::note(&shared, "INFO", line);
    // rust: let settings = match settings(&shared.dir) {
    // rust: Ok(Some(settings)) => settings,
    // rust: Ok(None) => return Ok(None),
    // rust: Err(e) => {
    // rust: if e.starts_with(TLS_FAILED) {
    // rust: management_tls::INSTRUCTIONS
    // rust: .iter()
    // rust: .for_each(|line| note(line));
}
    // rust: return Err(e);
}
}
    // rust: if let Some(tls) = &settings.tls {
    // rust: note(&format!(
    // rust: "Management server TLS certificate SHA-256: {}",
    // rust: tls.fingerprint
    // rust: ));
}
    // rust: let address = (settings.host.as_str(), settings.port as u16)
    // rust: .to_socket_addrs()
    // rust: .ok()
    // rust: .and_then(|mut a| a.next())
    // rust: .ok_or_else(|| format!("management-server-host: can't resolve {}", settings.host))?;
    // rust: let listener = TcpListener::bind(address)
    // rust: .map_err(|e| format!("the management server can't listen on {address}: {e}"))?;
    // rust: let address = listener.local_addr().map_err(|e| e.to_string())?;
    // rust: serve(shared, Arc::new(settings), listener).map_err(|e| e.to_string())?;
    // rust: Ok(Some(address))
}

/// A thread per connection: the HTTP upgrade (over TLS when it's on), then the WebSocket's messages.
    // rust: fn serve(
    // rust: shared: Arc<Shared>,
    // rust: settings: Arc<Settings>,
    // rust: listener: TcpListener,
    // rust: ) -> std::io::Result<()> {
    // rust: let (outbox, queue) = mpsc::channel::<String>();
    // rust: *shared.management.outbox.lock().unwrap() = Some(outbox);
    // rust: shared
    // rust: .management
    // rust: .heartbeat_seconds
    // rust: .store(settings.heartbeat, Ordering::Relaxed);
    // rust: heartbeat(shared.clone())?;
    // rust: let carrier = shared.clone();
    // rust: std::thread::Builder::new()
    // rust: .name("management-notify".into())
    // rust: .spawn(move || {
    // rust: for text in queue {
    // rust: let sockets: Vec<_> = carrier
    // rust: .management
    // rust: .sockets
    // rust: .lock()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|(_, socket)| socket.clone())
    // rust: .collect();
    // rust: for socket in sockets {
    // rust: let _ = socket.send_text(&text);
}
}
    // rust: })?;
    // rust: std::thread::Builder::new()
    // rust: .name("management".into())
    // rust: .spawn(move || {
    // rust: for stream in listener.incoming().flatten() {
    // rust: let (shared, settings) = (shared.clone(), settings.clone());
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("management-client".into())
    // rust: .spawn(move || connection(&shared, &settings, &stream));
}
    // rust: })?;
    // rust: Ok(())
}

pub const CONNECTIONS: std::sync::atomic::AtomicU32 = std::sync::atomic::AtomicU32::new(0);

pub fn connection(shared: **Shared, settings: *Settings, stream: *TcpStream) void {
}
    // rust: let link = match &settings.tls {
    // rust: Some(tls) => Link::tls(stream, tls.config.clone()),
    // rust: None => Link::plain(stream),
}
    // rust: let Ok(link) = link else {
    // rust: return;
}
    // The upgrade request (and the TLS handshake before it) must come within 10 s.
    // rust: if link
    // rust: .set_read_timeout(Some(Duration::from_secs(10)))
    // rust: .is_err()
    // rust: {
    // rust: return;
}
    // rust: let response = http::read_request(&link).and_then(|request| handshake(settings, &request));
    // rust: let upgraded = response.is_ok();
    // rust: let response = response.unwrap_or_else(|refused| refused);
    // rust: if http::write_head(&link, &response).is_err() || !upgraded {
    // rust: link.shutdown();
    // rust: return;
}
    // rust: let Ok(socket) = Socket::new(link) else {
    // rust: return;
}
    // `Connection`'s `ClientInfo`: the connections are numbered from 1, as the log lines show them.
    // rust: let client = CONNECTIONS.fetch_add(1, Ordering::Relaxed) + 1;
    // rust: let socket = Arc::new(socket);
    // rust: shared
    // rust: .management
    // rust: .sockets
    // rust: .lock()
    // rust: .unwrap()
    // rust: .push((client, socket.clone()));
    // rust: let _registered = Registered(shared, client);
    // rust: while let Ok(Some(text)) = socket.read_text() {
    // rust: match receive(shared, client, &text) {
    // rust: Some(Ok(reply)) => {
    // rust: if socket.send_text(&reply.to_string()).is_err() {
    // rust: return;
}
}
    // rust: Some(Err(())) => break,
    // rust: None => {}
}
}
    // rust: socket.close(1000);
}

/// `AuthenticationHandler.performSecurityChecks`: the secret as a bearer token, or in the WebSocket
/// subprotocol from an allowed origin. `Ok(true)` when it came in the subprotocol.
pub fn authenticate(settings: *Settings, request: *Request) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let valid = |key: &str| !key.is_empty() && crate::api::same_token(key, &settings.secret);
    // rust: if let Some(token) = request
    // rust: .header("authorization")
    // rust: .and_then(|h| h.strip_prefix("Bearer "))
    // rust: {
    // rust: return if valid(token.trim()) {
    // rust: Ok(false)
    // rust: } else {
    // rust: Err("Invalid API key")
}
}
    // rust: let Some(token) = request
    // rust: .header("sec-websocket-protocol")
    // rust: .and_then(|h| h.strip_prefix("minecraft-v1,"))
    // rust: else {
    // rust: return Err("Missing API key");
}
    // rust: let origin = request.header("origin").unwrap_or_default();
    // rust: if origin.is_empty() || !settings.allowed_origins.iter().any(|o| o == origin) {
    // rust: return Err("Origin Not Allowed");
}
    // rust: if valid(token.trim()) {
    // rust: Ok(true)
    // rust: } else {
    // rust: Err("Invalid API key")
}
}

/// The upgrade's 101, or the answer that refuses it.
pub fn handshake(settings: *Settings, request: *Request) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let in_protocol = match authenticate(settings, request) {
    // rust: Ok(in_protocol) => in_protocol,
    // rust: Err(reason) => {
    // rust: let body = format!("{{\"error\":\"Unauthorized\",\"message\":\"{reason}\"}}");
    // rust: return Err(Response::text(401, "application/json", body));
}
}
    // rust: if request.path != "/" {
    // rust: return Err(Response::error(
    // rust: 404,
    // rust: "the management protocol is served on /",
    // rust: ));
}
    // rust: let upgrade = request
    // rust: .header("upgrade")
    // rust: .is_some_and(|u| u.eq_ignore_ascii_case("websocket"));
    // rust: let (true, Some(key)) = (upgrade, request.header("sec-websocket-key")) else {
    // rust: return Err(Response::error(400, "not a WebSocket upgrade"));
}
    // rust: let mut response = Response::text(101, "", "")
    // rust: .with("Upgrade", "websocket")
    // rust: .with("Connection", "Upgrade")
    // rust: .with("Sec-WebSocket-Accept", crate::websocket::accept_key(key));
    // rust: if in_protocol {
    // rust: response = response.with("Sec-WebSocket-Protocol", "minecraft-v1");
}
    // rust: Ok(response)
}

pub const PARSE_ERROR: i32 = -32700;
pub const INVALID_REQUEST: i32 = -32600;
pub const METHOD_NOT_FOUND: i32 = -32601;
    // rust: pub(crate) const INVALID_PARAMS: i32 = -32602;
    // rust: pub(crate) const INTERNAL_ERROR: i32 = -32603;

/// `JsonRPCUtils.createError`.
pub fn error(id: Value, code: i32, data: ?[]const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let message = match code {
    // rust: PARSE_ERROR => "Parse error",
    // rust: INVALID_REQUEST => "Invalid Request",
    // rust: METHOD_NOT_FOUND => "Method not found",
    // rust: INVALID_PARAMS => "Invalid params",
    // rust: _ => "Internal error",
}
    // rust: let mut error = json!({ "code": code, "message": message });
    // rust: if let Some(data) = data.filter(|d| !d.trim().is_empty()) {
    // rust: error["data"] = json!(data);
}
    // rust: json!({ "jsonrpc": "2.0", "id": id, "error": error })
}

/// `Connection.channelRead0`: the reply to one message, if any. `Err` closes the connection, as vanilla's
/// does when a batch holds something other than an object.
pub fn receive(shared: *Shared, client: u32, text: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let message: Value = match serde_json::from_str(text) {
    // rust: Ok(message) => message,
    // rust: Err(e) => return Some(Ok(error(Value::Null, PARSE_ERROR, Some(&e.to_string())))),
}
    // rust: Some(Ok(match message {
    // rust: Value::Object(object) => return handle(shared, client, &object).map(Ok),
    // rust: Value::Array(batch) => {
    // rust: let mut replies = Vec::new();
    // rust: for request in batch {
    // rust: let Value::Object(object) = request else {
    // rust: return Some(Err(()));
}
    // rust: replies.extend(handle(shared, client, &object));
}
    // rust: Value::Array(replies)
}
    // rust: _ => error(Value::Null, INVALID_REQUEST, None),
    // rust: }))
}

    // rust: type Object = serde_json::Map<String, Value>;

/// `Connection.handleJsonObject`.
pub fn handle(shared: *Shared, client: u32, object: *Object) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = object.get("id");
    // rust: let method = match object.get("method") {
    // rust: None | Some(Value::Null) => None,
    // rust: Some(Value::String(s)) => Some(s.clone()),
    // rust: Some(n @ (Value::Number(_) | Value::Bool(_))) => Some(n.to_string()),
    // rust: Some(_) => {
    // rust: let data = "Unknown error handling request - check server logs for stack trace";
    // rust: return Some(error(Value::Null, INTERNAL_ERROR, Some(data)));
}
}
    // rust: let result = object.get("result");
    // rust: let failed = object.get("error").filter(|e| e.is_object());
    // rust: match (method, result, failed) {
    // rust: (Some(method), None, None) => {
    // rust: if id.is_some_and(|id| !(id.is_null() || id.is_number() || id.is_string())) {
    // rust: let data = "Invalid request id - only String, Number and NULL supported";
    // rust: return Some(error(Value::Null, INVALID_REQUEST, Some(data)));
}
    // rust: let reply = dispatch(shared, client, &method, object.get("params"));
    // rust: let id = id?.clone();
    // rust: Some(match reply {
    // rust: Ok(result) => json!({ "jsonrpc": "2.0", "id": id, "result": result }),
    // rust: Err((code, data)) => error(id, code, data.as_deref()),
    // rust: })
}
        // Answers to requests: the server sends none yet.
    // rust: (None, Some(_), None) if id.is_some() => None,
    // rust: (None, None, Some(_)) => None,
    // rust: _ => Some(error(
    // rust: id.cloned().unwrap_or(Value::Null),
    // rust: INVALID_REQUEST,
    // rust: None,
    // rust: )),
}
}

    // rust: pub(crate) type Failure = (i32, Option<String>);

    // rust: pub(crate) fn invalid_params(data: impl Into<String>) -> Failure {
    // rust: (INVALID_PARAMS, Some(data.into()))
}

/// `Identifier.tryParse`: `namespace:path`, `minecraft` when there is no namespace.
pub fn identifier(name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (namespace, path) = name.split_once(':').unwrap_or(("minecraft", name));
    // rust: let ok = |s: &str, extra: &[u8]| {
    // rust: s.bytes().all(|b| {
    // rust: matches!(b, b'a'..=b'z' | b'0'..=b'9' | b'_' | b'-' | b'.') || extra.contains(&b)
    // rust: })
}
    // rust: (ok(namespace, b"") && ok(path, b"/")).then(|| format!("{namespace}:{path}"))
}

/// `Connection.dispatchIncomingRequest` and `IncomingRpcMethod.apply`.
    // rust: fn dispatch(
    // rust: shared: &Shared,
    // rust: client: u32,
    // rust: method: &str,
    // rust: params: Option<&Value>,
    // rust: ) -> Result<Value, Failure> {
    // rust: let Some(name) = identifier(method) else {
    // rust: return Err((
    // rust: INVALID_REQUEST,
    // rust: Some(format!("Failed to parse method value: {method}")),
    // rust: ));
}
    // rust: let not_found = || {
    // rust: (
    // rust: METHOD_NOT_FOUND,
    // rust: Some(format!("Method not found: {method}")),
    // rust: )
}
    // rust: let (short, param) = if name == "minecraft:rpc.discover" {
    // rust: ("rpc.discover", None)
    // rust: } else {
    // rust: let found = name
    // rust: .strip_prefix("minecraft:")
    // rust: .and_then(schema::incoming)
    // rust: .ok_or_else(not_found)?;
    // rust: (found.0, found.2)
}
    // Only `rpc.discover` answers before vanilla's server is up. The game restarts under this server, so
    // `server/status` answers then too: `started` false, as vanilla's heartbeat says before it is up.
    // rust: if !matches!(short, "rpc.discover" | "server/status")
    // rust: && shared.state.lock().unwrap().phase != Phase::Running
    // rust: {
    // rust: return Err((
    // rust: INVALID_REQUEST,
    // rust: Some(format!(
    // rust: "Method cannot be dispatched pre server initialization: {method}"
    // rust: )),
    // rust: ));
}
    // rust: let argument = match (param, params) {
    // rust: (None, None) => Value::Null,
    // rust: (None, Some(Value::Array(a))) if a.is_empty() => Value::Null,
    // rust: (None, Some(_)) => return Err(invalid_params("Expected no params, or an empty array")),
    // rust: (Some((name, _)), Some(Value::Object(by_name))) => {
    // rust: by_name.get(name).cloned().ok_or_else(|| {
    // rust: invalid_params(format!(
    // rust: "Params passed by-name, but expected param [{name}] does not exist"
    // rust: ))
    // rust: })?
}
    // rust: (Some(_), Some(Value::Array(a))) if a.len() == 1 => a[0].clone(),
    // rust: (Some(_), Some(Value::Array(_))) => {
    // rust: return Err(invalid_params(
    // rust: "Expected exactly one element in the params array",
    // rust: ));
}
    // rust: (Some(_), _) => return Err(invalid_params("Expected params as array or named")),
}
    // rust: if short == "rpc.discover" {
    // rust: return Ok(schema::discover());
}
    // rust: crate::management_methods::call(shared, client, short, &argument)
}

    // rust: mod tests {
//     use super::*;
//     use std::io::{Read, Write};

pub const SECRET: []const u8 = "abcdefghijABCDEFGHIJ0123456789abcdefghij";

pub fn settings() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Settings {
    // rust: host: "127.0.0.1".into(),
    // rust: port: 0,
    // rust: secret: SECRET.into(),
    // rust: allowed_origins: vec!["http://localhost:3000".into()],
    // rust: tls: None,
    // rust: heartbeat: 0,
}
}

pub fn request(headers: *[([]const u8) void {
}
    // rust: Request {
    // rust: method: "GET".into(),
    // rust: path: "/".into(),
    // rust: query: String::new(),
    // rust: headers: headers
    // rust: .iter()
    // rust: .map(|(k, v)| ((*k).to_owned(), (*v).to_owned()))
    // rust: .collect(),
    // rust: body: Vec::new(),
}
}

pub fn the_secret_comes_as_vanillas_authentication_handler_takes_it() void {
}
    // rust: let s = settings();
    // rust: let bearer = format!("Bearer {SECRET}");
    // rust: let protocol = format!("minecraft-v1, {SECRET}");
    // rust: let cases: [(&[(&str, &str)], Result<bool, &str>); 6] = [
    // rust: (&[], Err("Missing API key")),
    // rust: (&[("Authorization", "Bearer nope")], Err("Invalid API key")),
    // rust: (&[("authorization", &bearer)], Ok(false)),
    // rust: (
    // rust: &[("Sec-WebSocket-Protocol", &protocol)],
    // rust: Err("Origin Not Allowed"),
    // rust: ),
    // rust: (
    // rust: &[
    // rust: ("Sec-WebSocket-Protocol", &protocol),
    // rust: ("Origin", "http://evil"),
    // rust: ],
    // rust: Err("Origin Not Allowed"),
    // rust: ),
    // rust: (
    // rust: &[
    // rust: ("Sec-WebSocket-Protocol", &protocol),
    // rust: ("Origin", "http://localhost:3000"),
    // rust: ],
    // rust: Ok(true),
    // rust: ),
    // rust: ];
    // rust: for (headers, expected) in cases {
    // rust: assert_eq!(authenticate(&s, &request(headers)), expected, "{headers:?}");
}
    // rust: assert!(valid_secret(SECRET) && !valid_secret("short") && !valid_secret(&"é".repeat(20)));
}

pub fn rpc_discover_lists_what_vanilla_registers() void {
}
    // rust: let d = schema::discover();
    // rust: let methods = d["methods"].as_array().unwrap();
    // rust: assert_eq!(methods.len(), 89);
    // rust: assert_eq!(methods[0]["name"], "minecraft:allowlist");
    // rust: assert_eq!(
    // rust: methods[1]["params"],
    // rust: json!([{ "name": "players", "required": true,
    // rust: "schema": { "type": "array", "items": { "$ref": "#/components/schemas/player" } } }])
    // rust: );
    // rust: assert!(
    // rust: methods
    // rust: .iter()
    // rust: .all(|m| m["name"] != "minecraft:rpc.discover")
    // rust: );
    // rust: assert!(schema::incoming("minecraft:server/status").is_some());
    // rust: assert!(schema::incoming("notification/server/started").is_none());
    // rust: assert_eq!(d["components"]["schemas"].as_object().unwrap().len(), 14);
}

pub fn shared() A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let dir = std::env::temp_dir().join(format!(
    // rust: "horizon-management-{}-{:?}",
    // rust: std::process::id(),
    // rust: std::thread::current().id()
    // rust: ));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: Shared::with_install(&dir, None)
}

pub fn requests_fail_as_vanillas_connection_says() void {
}
    // rust: let shared = shared();
    // rust: let reply = |text: &str| receive(&shared, 1, text);
    // rust: let error = |text: &str| reply(text).unwrap().unwrap()["error"].clone();
    // rust: assert_eq!(error("{nope")["code"], PARSE_ERROR);
    // rust: assert_eq!(
    // rust: error("5"),
    // rust: json!({ "code": -32600, "message": "Invalid Request" })
    // rust: );
    // rust: assert_eq!(
    // rust: error(r#"{"id":1,"method":"minecraft:nope"}"#),
    // rust: json!({ "code": -32601, "message": "Method not found", "data": "Method not found: minecraft:nope" })
    // rust: );
    // rust: assert_eq!(
    // rust: error(r#"{"id":1,"method":"Bad Name"}"#)["data"],
    // rust: "Failed to parse method value: Bad Name"
    // rust: );
    // rust: let bad_id = reply(r#"{"id":{"a":1},"method":"players"}"#)
    // rust: .unwrap()
    // rust: .unwrap();
    // rust: assert_eq!(bad_id["id"], Value::Null);
    // rust: assert_eq!(
    // rust: bad_id["error"]["data"],
    // rust: "Invalid request id - only String, Number and NULL supported"
    // rust: );
    // rust: assert_eq!(
    // rust: error(r#"{"id":"x","method":"players"}"#)["data"],
    // rust: "Method cannot be dispatched pre server initialization: players"
    // rust: );
    // rust: assert_eq!(
    // rust: error(r#"{"id":3,"method":"rpc.discover","params":{}}"#)["data"],
    // rust: "Expected no params, or an empty array"
    // rust: );
    // rust: assert_eq!(
    // rust: error(r#"{"id":6}"#),
    // rust: json!({ "code": -32600, "message": "Invalid Request" })
    // rust: );
        // Notifications and answers get no reply; a batch gets one per request.
    // rust: assert!(reply(r#"{"method":"rpc.discover"}"#).is_none());
    // rust: assert!(reply(r#"{"id":7,"result":1}"#).is_none());
    // rust: assert_eq!(reply("[]").unwrap().unwrap(), json!([]));
    // rust: let batch = reply(r#"[{"id":4,"method":"rpc.discover","params":[]},{"method":"x"}]"#);
    // rust: let batch = batch.unwrap().unwrap();
    // rust: assert_eq!(batch.as_array().unwrap().len(), 1);
    // rust: assert_eq!(batch[0]["id"], 4);
    // rust: assert_eq!(batch[0]["result"]["openrpc"], "1.3.2");
    // rust: assert!(reply("[1]").unwrap().is_err());
}

    /// A client's text frame, masked.
pub fn frame(text: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut f = vec![0x81, 0x80 | 126];
    // rust: f.extend_from_slice(&(text.len() as u16).to_be_bytes());
    // rust: f.extend_from_slice(&[0, 0, 0, 0]);
    // rust: f.extend_from_slice(text.as_bytes());
    // rust: f
}

    /// The upgrade, then `rpc.discover`, over `stream`: the reply's head and the discovered document.
pub fn discover(mut stream: impl Read + Write) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: write!(
    // rust: stream,
    // rust: "GET / HTTP/1.1\r\nHost: x\r\nUpgrade: websocket\r\nConnection: Upgrade\r\n\
    // rust: Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==\r\nSec-WebSocket-Version: 13\r\n\
    // rust: Authorization: Bearer {SECRET}\r\n\r\n"
    // rust: )
    // rust: .unwrap();
    // rust: stream.flush().unwrap();
    // rust: let mut head = Vec::new();
    // rust: let mut line = Vec::new();
    // rust: while head.last().is_none_or(|l: &String| !l.is_empty()) {
    // rust: let mut b = [0u8];
    // rust: stream.read_exact(&mut b).unwrap();
    // rust: if b[0] == b'\n' {
    // rust: head.push(
    // rust: String::from_utf8(std::mem::take(&mut line))
    // rust: .unwrap()
    // rust: .trim_end()
    // rust: .to_owned(),
    // rust: );
    // rust: } else {
    // rust: line.push(b[0]);
}
}
    // rust: stream
    // rust: .write_all(&frame(
    // rust: r#"{"jsonrpc":"2.0","id":1,"method":"rpc.discover"}"#,
    // rust: ))
    // rust: .unwrap();
    // rust: stream.flush().unwrap();
    // rust: let mut b = [0u8; 2];
    // rust: stream.read_exact(&mut b).unwrap();
    // rust: assert_eq!(b[0], 0x81);
    // rust: let length = match b[1] {
    // rust: 126 => {
    // rust: let mut l = [0u8; 2];
    // rust: stream.read_exact(&mut l).unwrap();
    // rust: u16::from_be_bytes(l) as usize
}
    // rust: 127 => {
    // rust: let mut l = [0u8; 8];
    // rust: stream.read_exact(&mut l).unwrap();
    // rust: u64::from_be_bytes(l) as usize
}
    // rust: n => n as usize,
}
    // rust: let mut payload = vec![0u8; length];
    // rust: stream.read_exact(&mut payload).unwrap();
    // rust: let reply: Value = serde_json::from_slice(&payload).unwrap();
    // rust: assert_eq!(reply["id"], 1);
    // rust: (head, reply["result"].clone())
}

pub fn listen(settings: Settings) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: listen_on(shared(), settings)
}

pub fn listen_on(shared: *Shared, settings: Settings) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let address = listener.local_addr().unwrap();
    // rust: serve(shared, Arc::new(settings), listener).unwrap();
    // rust: address
}

    /// The upgrade over a plain socket, without the `rpc.discover` that follows it in `discover`.
pub fn upgrade(address: SocketAddr) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut stream = TcpStream::connect(address).unwrap();
    // rust: stream
    // rust: .set_read_timeout(Some(Duration::from_secs(10)))
    // rust: .unwrap();
    // rust: write!(
    // rust: stream,
    // rust: "GET / HTTP/1.1\r\nHost: x\r\nUpgrade: websocket\r\nConnection: Upgrade\r\n\
    // rust: Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==\r\nSec-WebSocket-Version: 13\r\n\
    // rust: Authorization: Bearer {SECRET}\r\n\r\n"
    // rust: )
    // rust: .unwrap();
    // rust: let mut head = Vec::new();
    // rust: while !head.ends_with(b"\r\n\r\n") {
    // rust: let mut b = [0u8];
    // rust: stream.read_exact(&mut b).unwrap();
    // rust: head.push(b[0]);
}
    // rust: assert!(head.starts_with(b"HTTP/1.1 101 "));
    // rust: stream
}

    /// The text of the next frame the server sends (unmasked, shorter than 65536 bytes).
pub fn next_text(stream: *mut TcpStream) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut head = [0u8; 2];
    // rust: stream.read_exact(&mut head).unwrap();
    // rust: assert_eq!(head[0], 0x81);
    // rust: let length = match head[1] {
    // rust: 126 => {
    // rust: let mut b = [0u8; 2];
    // rust: stream.read_exact(&mut b).unwrap();
    // rust: usize::from(u16::from_be_bytes(b))
}
    // rust: n => usize::from(n),
}
    // rust: let mut payload = vec![0u8; length];
    // rust: stream.read_exact(&mut payload).unwrap();
    // rust: String::from_utf8(payload).unwrap()
}

    /// Waits until `count` connections are in the registry, which the upgrade's reply doesn't guarantee yet.
pub fn registered(shared: *Shared, count: usize) void {
}
    // rust: for _ in 0..500 {
    // rust: if shared.management.sockets.lock().unwrap().len() == count {
    // rust: return;
}
    // rust: std::thread::sleep(Duration::from_millis(10));
}
    // rust: panic!("{count} connections never registered");
}

pub fn notifications_go_to_every_client_as_vanilla_writes_them() void {
}
    // rust: let shared = shared();
    // rust: let address = listen_on(shared.clone(), settings());
    // rust: let mut first = upgrade(address);
    // rust: let mut second = upgrade(address);
    // rust: registered(&shared, 2);
    // rust: started(&shared);
    // rust: let expected = r#"{"jsonrpc":"2.0","method":"minecraft:notification/server/started"}"#;
    // rust: assert_eq!(next_text(&mut first), expected);
    // rust: assert_eq!(next_text(&mut second), expected);
        // One stop is told once per run of the game, whoever asks for it first; the next run says it again.
    // rust: stopping(&shared);
    // rust: stopping(&shared);
    // rust: started(&shared);
    // rust: stopping(&shared);
    // rust: let stopping_frame =
    // rust: r#"{"jsonrpc":"2.0","method":"minecraft:notification/server/stopping"}"#;
    // rust: for client in [&mut first, &mut second] {
    // rust: assert_eq!(next_text(client), stopping_frame);
    // rust: assert_eq!(next_text(client), expected);
    // rust: assert_eq!(next_text(client), stopping_frame);
}
        // A parameter goes in an array of one, and a client that left is dropped from the registry.
    // rust: drop(second);
    // rust: notify(
    // rust: &shared,
    // rust: "notification/players/left",
    // rust: Some(json!({ "name": "A" })),
    // rust: );
    // rust: assert_eq!(
    // rust: next_text(&mut first),
    // rust: r#"{"jsonrpc":"2.0","method":"minecraft:notification/players/left","params":[{"name":"A"}]}"#
    // rust: );
    // rust: for _ in 0..500 {
    // rust: if shared.management.sockets.lock().unwrap().len() == 1 {
    // rust: break;
}
    // rust: std::thread::sleep(Duration::from_millis(10));
}
    // rust: assert_eq!(shared.management.sockets.lock().unwrap().len(), 1);
}

pub fn the_games_events_become_the_notifications_vanilla_sends() void {
}
    // rust: let shared = shared();
    // rust: let address = listen_on(shared.clone(), settings());
    // rust: let mut client = upgrade(address);
    // rust: registered(&shared, 1);
    // rust: let id = "0123abcd-0000-4000-8000-00000000000a";
    // rust: let joined = json!({ "type": "join", "name": "Kim0", "uuid": id });
    // rust: game_event(&shared, "join", &joined);
    // rust: game_event(
    // rust: &shared,
    // rust: "chat",
    // rust: &json!({ "name": "Kim0", "uuid": id, "message": "hi" }),
    // rust: );
    // rust: game_event(&shared, "saving", &json!({ "type": "saving" }));
    // rust: game_event(&shared, "saved", &json!({ "type": "saved" }));
    // rust: game_event(&shared, "leave", &json!({ "name": "Kim0", "uuid": id }));
        // The chat is not a notification; the rest come in order, the player as a `PlayerDto`.
    // rust: let player = format!(r#"[{{"id":"{id}","name":"Kim0"}}]"#);
    // rust: assert_eq!(
    // rust: next_text(&mut client),
    // rust: format!(
    // rust: r#"{{"jsonrpc":"2.0","method":"minecraft:notification/players/joined","params":{player}}}"#
    // rust: )
    // rust: );
    // rust: assert_eq!(
    // rust: next_text(&mut client),
    // rust: r#"{"jsonrpc":"2.0","method":"minecraft:notification/server/saving"}"#
    // rust: );
    // rust: assert_eq!(
    // rust: next_text(&mut client),
    // rust: r#"{"jsonrpc":"2.0","method":"minecraft:notification/server/saved"}"#
    // rust: );
    // rust: assert_eq!(
    // rust: next_text(&mut client),
    // rust: format!(
    // rust: r#"{{"jsonrpc":"2.0","method":"minecraft:notification/players/left","params":{player}}}"#
    // rust: )
    // rust: );
        // A change of a list reaches the client with its one parameter (the player, for an allowlist).
    // rust: game_event(
    // rust: &shared,
    // rust: "allowlist_removed",
    // rust: &json!({ "name": "Kim0", "uuid": id }),
    // rust: );
    // rust: assert_eq!(
    // rust: next_text(&mut client),
    // rust: format!(
    // rust: r#"{{"jsonrpc":"2.0","method":"minecraft:notification/allowlist/removed","params":{player}}}"#
    // rust: )
    // rust: );
}

pub fn an_activity_is_told_once_in_thirty_seconds_and_otherwise_lost() void {
}
    // rust: let shared = shared();
    // rust: let start = Instant::now();
    // rust: assert!(activity_due(&shared, start));
    // rust: assert!(!activity_due(&shared, start + Duration::from_secs(29)));
        // The one lost at 29 s is not told later: the next login after thirty seconds is.
    // rust: assert!(!activity_due(&shared, start + Duration::from_secs(29)));
    // rust: assert!(activity_due(&shared, start + Duration::from_secs(30)));
    // rust: assert!(!activity_due(&shared, start + Duration::from_secs(59)));
    // rust: assert!(activity_due(&shared, start + Duration::from_secs(60)));
}

pub fn a_login_is_an_activity_notification_and_the_heartbeat_carries_the_status() void {
}
    // rust: let shared = shared();
    // rust: let address = listen_on(
    // rust: shared.clone(),
    // rust: Settings {
    // rust: heartbeat: 1,
    // rust: ..settings()
    // rust: },
    // rust: );
    // rust: let mut client = upgrade(address);
    // rust: registered(&shared, 1);
    // rust: game_event(
    // rust: &shared,
    // rust: "login_activity",
    // rust: &json!({ "type": "login_activity" }),
    // rust: );
    // rust: game_event(
    // rust: &shared,
    // rust: "login_activity",
    // rust: &json!({ "type": "login_activity" }),
    // rust: );
    // rust: assert_eq!(
    // rust: next_text(&mut client),
    // rust: r#"{"jsonrpc":"2.0","method":"minecraft:notification/server/activity"}"#
    // rust: );
        // The second login came inside the thirty seconds, so the next frame is the heartbeat, a second
        // after the start: the status of a game that isn't up.
    // rust: let beat: Value = serde_json::from_str(&next_text(&mut client)).unwrap();
    // rust: assert_eq!(beat["method"], "minecraft:notification/server/status");
    // rust: assert_eq!(beat["params"][0]["started"], false);
    // rust: assert!(beat["params"][0]["version"]["name"].is_string());
}

    /// `serversettings/status_heartbeat_interval/set`: the heartbeat of a server that started with none begins
    /// at once, and one that was on stops, with no restart; the interval the server reports follows.
pub fn the_heartbeat_interval_can_change_while_the_server_runs() void {
}
    // rust: let shared = shared();
    // rust: let address = listen_on(shared.clone(), settings());
    // rust: let mut client = upgrade(address);
    // rust: registered(&shared, 1);
    // rust: assert_eq!(heartbeat_seconds(&shared), 0);
        // Started with none: nothing comes in the 1.2 s that follow (the thread counts in whole seconds).
    // rust: client
    // rust: .set_read_timeout(Some(Duration::from_millis(1200)))
    // rust: .unwrap();
    // rust: let mut byte = [0u8];
    // rust: assert!(client.read(&mut byte).is_err(), "a heartbeat with none set");
    // rust: client
    // rust: .set_read_timeout(Some(Duration::from_secs(10)))
    // rust: .unwrap();
    // rust: assert!(set_heartbeat_seconds(&shared, 1));
    // rust: assert_eq!(heartbeat_seconds(&shared), 1);
    // rust: let beat: Value = serde_json::from_str(&next_text(&mut client)).unwrap();
    // rust: assert_eq!(beat["method"], "minecraft:notification/server/status");
        // Set to 0 (or below) it stops again.
    // rust: assert!(set_heartbeat_seconds(&shared, 0));
    // rust: client
    // rust: .set_read_timeout(Some(Duration::from_millis(1200)))
    // rust: .unwrap();
        // One that was already due as the value changed may still be in flight: read it, then expect silence.
    // rust: let mut late = [0u8; 1];
    // rust: let _ = client.read(&mut late);
    // rust: let mut quiet = [0u8; 1];
    // rust: assert!(client.read(&mut quiet).is_err(), "a heartbeat after 0");
}

pub fn every_notification_sent_is_one_discover_lists() void {
}
    // rust: let listed = schema::discover();
    // rust: let names: Vec<&str> = listed["methods"]
    // rust: .as_array()
    // rust: .unwrap()
    // rust: .iter()
    // rust: .map(|m| m["name"].as_str().unwrap())
    // rust: .collect();
    // rust: for sent in [
    // rust: "notification/server/started",
    // rust: "notification/server/stopping",
    // rust: "notification/server/saving",
    // rust: "notification/server/saved",
    // rust: "notification/players/joined",
    // rust: "notification/players/left",
    // rust: "notification/operators/added",
    // rust: "notification/operators/removed",
    // rust: "notification/allowlist/added",
    // rust: "notification/allowlist/removed",
    // rust: "notification/bans/added",
    // rust: "notification/bans/removed",
    // rust: "notification/ip_bans/added",
    // rust: "notification/ip_bans/removed",
    // rust: "notification/gamerules/updated",
    // rust: "notification/server/activity",
    // rust: "notification/server/status",
    // rust: ] {
    // rust: assert!(
    // rust: names.contains(&format!("minecraft:{sent}").as_str()),
    // rust: "{sent}"
    // rust: );
}
}

pub fn without_a_management_server_a_notification_goes_nowhere() void {
}
    // rust: let shared = shared();
    // rust: started(&shared);
    // rust: stopping(&shared);
    // rust: assert!(shared.management.outbox.lock().unwrap().is_none());
}

pub fn a_websocket_client_discovers_the_methods() void {
}
    // rust: let address = listen(settings());
    // rust: let mut refused = std::net::TcpStream::connect(address).unwrap();
    // rust: write!(
    // rust: refused,
    // rust: "GET / HTTP/1.1\r\nAuthorization: Bearer wrong\r\n\r\n"
    // rust: )
    // rust: .unwrap();
    // rust: let mut text = String::new();
    // rust: refused.read_to_string(&mut text).unwrap();
    // rust: assert!(text.starts_with("HTTP/1.1 401 "), "{text}");
    // rust: assert!(
    // rust: text.ends_with("\r\n\r\n{\"error\":\"Unauthorized\",\"message\":\"Invalid API key\"}")
    // rust: );
    // rust: let (head, discovered) = discover(std::net::TcpStream::connect(address).unwrap());
    // rust: assert_eq!(head[0], "HTTP/1.1 101 Switching Protocols");
    // rust: assert!(head.contains(&"Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=".to_owned()));
    // rust: assert_eq!(discovered, schema::discover());
}

pub fn over_tls_with_a_generated_keystore() void {
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-management-wss-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: let password = management_tls::generate(&dir, "").unwrap();
    // rust: let tls = management_tls::load(&dir, management_tls::GENERATED, &password).unwrap();
        // The client trusts the generated certificate, as one pins it from the fingerprint the log shows.
    // rust: let store = p12_keystore::KeyStore::from_pkcs12(
    // rust: &std::fs::read(dir.join(management_tls::GENERATED)).unwrap(),
    // rust: &password,
    // rust: )
    // rust: .unwrap();
    // rust: let certificate = store.private_key_chain().unwrap().1.chain()[0]
    // rust: .as_der()
    // rust: .to_vec();
    // rust: let mut roots = rustls::RootCertStore::empty();
    // rust: roots.add(certificate.into()).unwrap();
    // rust: let client = rustls::ClientConfig::builder_with_provider(Arc::new(
    // rust: rustls::crypto::ring::default_provider(),
    // rust: ))
    // rust: .with_safe_default_protocol_versions()
    // rust: .unwrap()
    // rust: .with_root_certificates(roots)
    // rust: .with_no_client_auth();
    // rust: let address = listen(Settings {
    // rust: tls: Some(tls),
    // rust: ..settings()
    // rust: });
    // rust: let connection =
    // rust: rustls::ClientConnection::new(Arc::new(client), "localhost".try_into().unwrap())
    // rust: .unwrap();
    // rust: let stream = rustls::StreamOwned::new(connection, TcpStream::connect(address).unwrap());
    // rust: let (head, discovered) = discover(stream);
    // rust: assert_eq!(head[0], "HTTP/1.1 101 Switching Protocols");
    // rust: assert_eq!(discovered, schema::discover());
        // Plain text to the TLS port gets no answer.
    // rust: let mut plain = TcpStream::connect(address).unwrap();
    // rust: plain
    // rust: .set_read_timeout(Some(Duration::from_secs(5)))
    // rust: .unwrap();
    // rust: let _ = write!(
    // rust: plain,
    // rust: "GET / HTTP/1.1\r\nAuthorization: Bearer {SECRET}\r\n\r\n"
    // rust: );
    // rust: let mut text = Vec::new();
    // rust: let _ = plain.read_to_end(&mut text);
    // rust: assert!(!text.starts_with(b"HTTP"));
    // rust: let _ = std::fs::remove_dir_all(&dir);
}
}
