//! Transpiled from Horizon Rust crate
package horizon_client_conn

import "core:fmt"
import "core:mem"
import "core:math"

// One accepted connection: handshake, status ping, login (offline, or online
// with encryption and the session service's verdict) and the
// configuration phase (ServerStatusPacketListenerImpl,
// ServerLoginPacketListenerImpl, ServerConfigurationPacketListenerImpl). A
// player that completes configuration continues in the play state on the
// network threads ([`io_pool`]): they forward decoded packets to the game
// thread, frame, compress and encrypt what the game queues, and keep the
// keep-alive schedule on their own so a long tick never times a client out.
// use super::{
    // rust: Joined, NetEvent, Out, Shared,
    // rust: data::{CORE_PACK, SyncData},
    // rust: forwarding,
    // rust: io_pool::{self, Session as _},
}
// use horizon_protocol::{
    // rust: PROTOCOL_VERSION,
    // rust: connection::{ConnWriter, Connection, Counters},
    // rust: crypto::{offline_uuid, server_hash, uuid_string},
    // rust: packets::{
    // rust: Empty,
    // rust: configuration::{self as cfg, ClientInformation, KnownPack},
    // rust: handshake, login, play, status,
    // rust: },
    // rust: text::translatable,
}
// use std::{
    // rust: cell::Cell,
    // rust: net::TcpStream,
    // rust: sync::{
    // rust: Arc, Mutex, PoisonError,
    // rust: atomic::{AtomicI32, AtomicI64, AtomicU32, AtomicUsize, Ordering},
    // rust: mpsc::{RecvTimeoutError, Sender, channel},
    // rust: },
    // rust: time::{Duration, Instant},
}

// ServerCommonPacketListenerImpl.keepConnectionAlive: a keep-alive every 15 s,
// and a client that has not answered the last one by the next is dropped.
KEEP_ALIVE_EVERY :: Duration::from_secs(15)
// ReadTimeoutHandler(30) in ServerConnectionListener: a connection that sends
// nothing for 30 s.
READ_TIMEOUT :: Duration::from_secs(30)

// How long the handshake, a status request and the login may wait for the client's next packet,
// where vanilla waits 30 s: a client answers these at once, and each connection holds a thread
// and one of the places the server keeps for connections, which a crowd of silent or slow
// sockets would otherwise take for 30 s each. Configuration and play keep [`READ_TIMEOUT`] (a
// resource pack downloads in configuration).
LOGIN_TIMEOUT :: Duration::from_secs(10)
// Vanilla's server-side disconnect during login is a JSON component.
login_disconnect :: proc(c: ^Connection, reason: ^horizon_world::nbt::Tag) {
}
    // rust: let json = component_json(reason);
    // rust: let _ =
    // rust: c.send(&login::Clientbound::Disconnect(login::Disconnect { reason_json: json }).encode());
}

// A component as ComponentSerialization.CODEC writes it with JsonOps (and
// Gson without HTML escaping): plain text collapses to a string, the
// content fields come first, then `extra`, then the style.
component_json :: proc(tag: ^horizon_world::nbt::Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: component_value(tag).compact()
}
component_value :: proc(tag: ^horizon_world::nbt::Tag) -> c {
    // Ported from Horizon
    return {}
}
//     use crate::server::json::Json;
//     use horizon_world::nbt::Tag;
    // rust: const ORDER: &[&str] = &[
    // rust: "type",
    // rust: "text",
    // rust: "translate",
    // rust: "fallback",
    // rust: "with",
    // rust: "score",
    // rust: "selector",
    // rust: "separator",
    // rust: "keybind",
    // rust: "nbt",
    // rust: "interpret",
    // rust: "block",
    // rust: "entity",
    // rust: "storage",
    // rust: "source",
    // rust: "object",
    // rust: "sprite",
    // rust: "atlas",
    // rust: "player",
    // rust: "hat",
    // rust: "extra",
    // rust: "color",
    // rust: "shadow_color",
    // rust: "bold",
    // rust: "italic",
    // rust: "underlined",
    // rust: "strikethrough",
    // rust: "obfuscated",
    // rust: "click_event",
    // rust: "hover_event",
    // rust: "insertion",
    // rust: "font",
    // rust: ];
    // rust: match tag {
    // rust: Tag::String(s) => Json::String(s.to_string_lossy()),
    // rust: Tag::List(items) => Json::Array(items.iter().map(component_value).collect()),
    // rust: Tag::Compound(map) => {
    // rust: if map.len() == 1
    // rust: && let Some(Tag::String(t)) = map.get(&horizon_world::nbt::JavaString::from("text"))
    // rust: {
    // rust: return Json::String(t.to_string_lossy());
}
    // rust: let mut keys: Vec<String> = map.keys().map(|k| k.to_string_lossy()).collect();
    // rust: keys.sort_by_key(|k| ORDER.iter().position(|o| o == k).unwrap_or(ORDER.len()));
    // rust: Json::Object(
    // rust: keys.into_iter()
    // rust: .map(|k| {
    // rust: let v = &map[&horizon_world::nbt::JavaString::from(k.as_str())];
    // rust: let value = match v {
    // rust: Tag::Byte(b) => Json::Bool(*b != 0),
    // rust: Tag::Int(i) => Json::Number(i.to_string()),
    // rust: other => component_value(other),
}
    // rust: (k, value)
    // rust: })
    // rust: .collect(),
    // rust: )
}
    // rust: Tag::Byte(b) => Json::Bool(*b != 0),
    // rust: Tag::Int(i) => Json::Number(i.to_string()),
    // rust: Tag::Long(i) => Json::Number(i.to_string()),
    // rust: _ => Json::Null,
}
}

// The inverse of [`component_value`]: a JSON component (a server.properties
// prompt) as ComponentSerialization.CODEC writes it with NbtOps. An array is
// its first component with the rest appended (`createFromList`); a list of
// components mixing plain strings and objects has the strings as `{text}`.
component_tag :: proc(v: ^crate::server::json::Json) -> h {
    // Ported from Horizon
    return {}
}
//     use crate::server::json::Json;
//     use horizon_world::nbt::{JavaString, Tag};
list :: proc(items: ^[Json]) -> T {
    // Ported from Horizon
    return {}
}
    // rust: same_kind(items.iter().map(component_tag).collect())
}
same_kind :: proc(mut tags: [dynamic]Tag) -> T {
    // Ported from Horizon
    return {}
}
    // rust: if tags.iter().any(|t| matches!(t, Tag::Compound(_))) {
    // rust: for t in &mut tags {
    // rust: if let Tag::String(s) = t {
    // rust: *t = Tag::compound([("text", Tag::String(s.clone()))]);
}
}
}
    // rust: Tag::List(tags)
}
value :: proc(v: ^Json) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match v {
    // rust: Json::Bool(b) => Tag::Byte(i8::from(*b)),
    // rust: Json::Number(n) => n.parse().map_or_else(
    // rust: |_| Tag::Double(n.parse::<f64>().unwrap_or(0.0).to_bits()),
    // rust: Tag::Int,
    // rust: ),
    // rust: Json::String(s) => Tag::String(JavaString::from(s.as_str())),
    // rust: Json::Array(items) => list(items),
    // rust: Json::Object(members) => Tag::compound(
    // rust: members
    // rust: .iter()
    // rust: .map(|(k, v)| (k.as_str(), value(v)))
    // rust: .collect::<Vec<_>>(),
    // rust: ),
    // rust: Json::Null => Tag::String(JavaString::from("")),
}
}
    // rust: match v {
    // rust: Json::Array(items) if !items.is_empty() => {
    // rust: let mut first = component_tag(&items[0]);
    // rust: if let Tag::String(s) = &first {
    // rust: first = Tag::compound([("text", Tag::String(s.clone()))]);
}
    // rust: if let Tag::Compound(map) = &mut first {
    // rust: let mut extra = match map.remove(&JavaString::from("extra")) {
    // rust: Some(Tag::List(e)) => e,
    // rust: _ => Vec::new(),
}
    // rust: extra.extend(items[1..].iter().map(component_tag));
    // rust: map.insert(JavaString::from("extra"), same_kind(extra));
}
    // rust: first
}
    // rust: Json::Object(members) => {
    // rust: if let [(key, Json::String(text))] = members.as_slice()
    // rust: && key == "text"
    // rust: {
    // rust: return Tag::String(JavaString::from(text.as_str()));
}
    // rust: Tag::compound(
    // rust: members
    // rust: .iter()
    // rust: .map(|(k, v)| {
    // rust: let tag = match k.as_str() {
    // rust: "extra" | "with" => match v {
    // rust: Json::Array(items) => list(items),
    // rust: other => value(other),
    // rust: },
    // rust: _ => value(v),
}
    // rust: (k.as_str(), tag)
    // rust: })
    // rust: .collect::<Vec<_>>(),
    // rust: )
}
    // rust: Json::String(s) | Json::Number(s) => Tag::String(JavaString::from(s.as_str())),
    // rust: Json::Bool(b) => Tag::String(JavaString::from(b.to_string().as_str())),
    // rust: _ => Tag::String(JavaString::from("")),
}
}

// StringUtil.isValidPlayerName.
valid_name :: proc(name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (1..=16).contains(&name.len()) && name.chars().all(|c| c as u32 > 32 && (c as u32) < 127)
}

    // rust: thread_local! {
HOLDING :: const { Cell::new(false) }
}

// While one is alive, the packets this thread sends to each player are held
// and handed to the player's network thread together by
// [`PlayerSender::flush`] or [`flush_all`]: one hand-over per player per tick
// rather than one per packet. The bytes and their order don't change.
Holding :: struct {
    // rust: impl Holding {
start :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(HOLDING.replace(true))
}
}
    // rust: impl Drop for Holding {
drop :: proc(self: ^Self) {
}
    // rust: HOLDING.set(self.0);
}
}

// The sending half given to the game thread.
PlayerSender :: struct {
    // The bytes of the bodies sent and not framed yet.
    pending: ^AtomicUsize,
    held: ^Mutex<[dynamic]Vec<u8>>,
    to: To,
    // The connection's bytes on the wire (after compression and encryption), counted by its
    // network thread: `horizon-report`'s network use per player. None for a test's channel.
    wire: Maybe(^Counters),
}
To :: enum {
    // A test's channel.
    Channel(Sender<Out>),
    // A connection on the network threads, and its keep-alive clock.
    Pool(Arc<io_pool::Outbox>, Arc<KeepAliveWatch>),
}
    // rust: impl PlayerSender {
    // A sender whose packets go to `tx` (a test's).
new :: proc(tx: Sender<Out>, pending: ^AtomicUsize) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: pending,
    // rust: held: Arc::default(),
    // rust: to: To::Channel(tx),
    // rust: wire: None,
}
}
    // The bytes received from and sent to the client on the wire so far, where the
    // connection counts them.
wire_bytes :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.wire.as_ref().map(|c| {
    // rust: (
    // rust: c.bytes_in.load(Ordering::Relaxed).max(0) as u64,
    // rust: c.bytes_out.load(Ordering::Relaxed).max(0) as u64,
    // rust: )
    // rust: })
}
    // Whether the client has answered no keep-alive for too long.
timed_out :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(&self.to, To::Pool(_, watch) if watch.timed_out())
}
    // Close the connection now, dropping what is still queued for it.
close :: proc(self: ^Self) {
}
    // rust: if let To::Pool(outbox, _) = &self.to {
    // rust: outbox.send(Vec::new(), Some(io_pool::End::Close));
}
}
held :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.held.lock().unwrap_or_else(PoisonError::into_inner)
}
send :: proc(self: ^Self, body: [dynamic]u8) {
}
    // rust: self.pending.fetch_add(body.len(), Ordering::Relaxed);
    // rust: if HOLDING.get() {
    // rust: self.held().push(body);
    // rust: } else {
    // rust: self.flush();
    // rust: match &self.to {
    // rust: To::Channel(tx) => drop(tx.send(Out::Packet(body))),
    // rust: To::Pool(outbox, _) => outbox.send(vec![body], None),
}
}
}
    // Several packets in order, as [`Self::send`] each: under one lock
    // while the tick holds them.
send_many :: proc(self: ^Self, bodies: impl IntoIterator<Item = [dynamic]u8>) {
}
    // rust: if !HOLDING.get() {
    // rust: bodies.into_iter().for_each(|body| self.send(body));
    // rust: return;
}
    // rust: let mut held = self.held();
    // rust: for body in bodies {
    // rust: self.pending.fetch_add(body.len(), Ordering::Relaxed);
    // rust: held.push(body);
}
}
    // Hand the held packets to the network thread.
flush :: proc(self: ^Self) {
}
    // rust: let held = std::mem::take(&mut *self.held());
    // rust: if !held.is_empty() {
    // rust: match &self.to {
    // rust: To::Channel(tx) => drop(tx.send(Out::Packets(held))),
    // rust: To::Pool(outbox, _) => outbox.send(held, None),
}
}
}
    // Send a play disconnect with this reason after what was sent before,
    // then close.
disconnect :: proc(self: ^Self, reason: horizon_world::nbt::Tag) {
}
    // rust: self.flush();
    // rust: match &self.to {
    // rust: To::Channel(tx) => drop(tx.send(Out::Disconnect(reason))),
    // rust: To::Pool(outbox, _) => {
    // rust: let body = play::Clientbound::Disconnect(cfg::Disconnect { reason }).encode();
    // rust: self.pending.fetch_add(body.len(), Ordering::Relaxed);
    // rust: outbox.send(vec![body], Some(io_pool::End::Disconnect));
}
}
}
}

// Hand every player's held packets to their network threads, waking each
// thread once: a wake-up costs a system call, and on a busy machine often
// the rest of the core's time slice. Each player's packets keep their order,
// also with what is sent to it next.
    // rust: pub fn flush_all<'a>(senders: impl IntoIterator<Item = &'a PlayerSender>) {
    // rust: let mut wake: Vec<&Arc<io_pool::Worker>> = Vec::new();
    // rust: for s in senders {
    // rust: let held = std::mem::take(&mut *s.held());
    // rust: if held.is_empty() {
    // rust: continue;
}
    // rust: match &s.to {
    // rust: To::Channel(tx) => drop(tx.send(Out::Packets(held))),
    // rust: To::Pool(outbox, _) => {
    // rust: if let Some(worker) = outbox.push(held, None)
    // rust: && !wake.iter().any(|w| Arc::ptr_eq(w, worker))
    // rust: {
    // rust: wake.push(worker);
}
}
}
}
    // rust: wake.into_iter().for_each(|w| w.wake());
}

// LegacyQueryHandler: the pre-1.7 server list ping. What the first read
// holds decides the reply (1.3 and older: no more bytes; 1.4 and 1.5: 0x01;
// 1.6: 0x01 then the MC|PingHost payload); anything else gets no reply.
serve_legacy :: proc(mut stream: TcpStream, shared: ^Shared) -> R {
    // Ported from Horizon
    return {}
}
//     use std::io::{Read, Write};
    // rust: let _ = stream.set_read_timeout(Some(Duration::from_millis(100)));
    // rust: let mut data = Vec::new();
    // rust: let mut chunk = [0u8; 1024];
    // The bytes of the first read: what arrived together.
    // rust: if let Ok(n) = stream.read(&mut chunk) {
    // rust: data.extend_from_slice(&chunk[..n]);
}
    // rust: let in_string = |d: &[u8], at: &mut usize| -> Option<String> {
    // rust: let len = usize::from(u16::from_be_bytes([*d.get(*at)?, *d.get(*at + 1)?]));
    // rust: let bytes = d.get(*at + 2..*at + 2 + len * 2)?;
    // rust: *at += 2 + len * 2;
    // rust: Some(String::from_utf16_lossy(
    // rust: &bytes
    // rust: .chunks(2)
    // rust: .map(|c| u16::from_be_bytes([c[0], c[1]]))
    // rust: .collect::<Vec<_>>(),
    // rust: ))
}
    // rust: let motd = shared.motd();
    // rust: let (online, max) = (shared.online(), shared.max_players());
    // rust: let body = if data.len() == 1 {
    // rust: format!("{motd}\u{a7}{online}\u{a7}{max}")
    // rust: } else {
    // rust: if data.get(1) != Some(&1) {
    // rust: return Ok(());
}
    // rust: if data.len() > 2 {
            // readCustomPayloadPacket.
    // rust: let mut at = 3;
    // rust: let valid = data[2] == 0xFA
    // rust: && in_string(&data, &mut at).as_deref() == Some("MC|PingHost")
    // rust: && data
    // rust: .get(at..at + 2)
    // rust: .map(|b| usize::from(u16::from_be_bytes([b[0], b[1]])))
    // rust: == Some(data.len().saturating_sub(at + 2))
    // rust: && {
    // rust: at += 2;
    // rust: data.get(at).is_some_and(|v| *v >= 73)
}
    // rust: && {
    // rust: at += 1;
    // rust: in_string(&data, &mut at).is_some()
}
    // rust: && data
    // rust: .get(at..at + 4)
    // rust: .is_some_and(|b| i32::from_be_bytes([b[0], b[1], b[2], b[3]]) <= 65535);
    // rust: if !valid {
    // rust: return Ok(());
}
}
    // rust: format!(
    // rust: "\u{a7}1\0127\0{}\0{motd}\0{online}\0{max}",
    // rust: horizon_core::VANILLA_VERSION
    // rust: )
}
    // rust: let units: Vec<u16> = body.encode_utf16().collect();
    // rust: let mut out = vec![0xFF];
    // rust: out.extend_from_slice(&(units.len() as u16).to_be_bytes());
    // rust: for u in units {
    // rust: out.extend_from_slice(&u.to_be_bytes());
}
    // rust: stream.write_all(&out).map_err(|e| e.to_string())?;
    // rust: let _ = stream.shutdown(std::net::Shutdown::Both);
    // rust: Ok(())
}

// Serve an accepted connection, which holds `counted`'s place among the
// server's until it closes.
    // rust: pub(super) fn serve(
    // rust: stream: TcpStream,
    // rust: address: std::net::SocketAddr,
    // rust: shared: Arc<Shared>,
    // rust: counted: super::Counted,
    // rust: ) -> Result<(), String> {
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // LegacyQueryHandler, ahead of the frame decoder while status is on.
    // rust: let mut first = [0u8; 1];
    // rust: if shared.enable_status() && stream.peek(&mut first).is_ok_and(|n| n == 1) && first[0] == 0xFE {
    // rust: return serve_legacy(stream, &shared);
}
    // A peer that stops reading (a frozen game, a dropped network) would otherwise hold
    // its writer in a full send buffer for good, or until TCP gives up minutes later, and
    // its thread and its place among the server's connections with it.
    // rust: let _ = stream.set_write_timeout(Some(WRITE_TIMEOUT));
    // rust: let c = Connection::from_stream(stream).map_err(e)?;
    // rust: serve_connection(c, address, shared, Some(counted))
}

// How long one write may wait on a peer that reads nothing: as long as a read may wait.
WRITE_TIMEOUT :: READ_TIMEOUT

// The address a memory connection logs in from: no network peer has port 0.
    // rust: pub const MEMORY_ADDRESS: std::net::SocketAddr = std::net::SocketAddr::V4(
    // rust: std::net::SocketAddrV4::new(std::net::Ipv4Addr::LOCALHOST, 0),
    // rust: );

// `ServerConnectionListener.startMemoryChannel`: an integrated server's
// own player, over one end of an in-memory pipe.
    // rust: pub fn serve_local(
    // rust: pipe: horizon_protocol::connection::Pipe,
    // rust: shared: Arc<Shared>,
    // rust: ) -> Result<(), String> {
    // rust: serve_connection(Connection::local(pipe), MEMORY_ADDRESS, shared, None)
}

    // rust: fn serve_connection(
    // rust: mut c: Connection,
    // rust: address: std::net::SocketAddr,
    // rust: shared: Arc<Shared>,
    // rust: counted: Option<super::Counted>,
    // rust: ) -> Result<(), String> {
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: c.reader.set_read_timeout(Some(LOGIN_TIMEOUT)).map_err(e)?;
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: let intention = match handshake::Serverbound::decode(id, &payload).map_err(e)? {
    // rust: handshake::Serverbound::Intention(i) => i,
    // rust: _ => return Err("expected a handshake".into()),
}
    // rust: match intention.intent {
        // ServerHandshakePacketListenerImpl: a server that does not reply
        // to status requests closes the connection.
    // rust: handshake::STATUS if !shared.enable_status() => Ok(()),
    // rust: handshake::STATUS => serve_status(&mut c, &shared, intention.protocol),
    // rust: handshake::TRANSFER if !shared.accepts_transfers() => {
    // rust: login_disconnect(
    // rust: &mut c,
    // rust: &translatable("multiplayer.disconnect.transfers_disabled", &[]),
    // rust: );
    // rust: Ok(())
}
    // rust: handshake::LOGIN | handshake::TRANSFER => {
    // rust: if let Some(version) = older_client(&shared, intention.protocol) {
    // rust: c.serve_older(version);
    // rust: } else if intention.protocol != PROTOCOL_VERSION {
    // rust: let key = if intention.protocol < 754 {
    // rust: "multiplayer.disconnect.outdated_client"
    // rust: } else {
    // rust: "multiplayer.disconnect.incompatible"
}
    // rust: let json = format!(
    // rust: "{{\"translate\":\"{key}\",\"with\":[\"{}\"]}}",
    // rust: horizon_protocol::GAME_VERSION
    // rust: );
    // rust: let _ = c.send(
    // rust: &login::Clientbound::Disconnect(login::Disconnect { reason_json: json })
    // rust: .encode(),
    // rust: );
    // rust: return Ok(());
}
    // rust: serve_login(c, address, &shared, counted)
}
    // rust: other => Err(format!("unknown intent {other}")),
}
}

// The older release a client's handshake states, when this server lets it join
// (`horizon-accept-older-clients`): 26.2 only, for now.
    // rust: fn older_client(
    // rust: shared: &Shared,
    // rust: protocol: i32,
    // rust: ) -> Option<horizon_protocol::adapter::ServerVersion> {
//     use horizon_protocol::adapter::ServerVersion;
    // rust: let version = ServerVersion::from_protocol(protocol)?;
    // rust: (shared.config.accept_older_clients && version == ServerVersion::V26_2).then_some(version)
}

serve_status :: proc(c: ^Connection, shared: ^Shared, protocol: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: let mut requested = false;
    // rust: loop {
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: match status::Serverbound::decode(id, &payload).map_err(e)? {
            // ServerStatusPacketListenerImpl: a second request disconnects.
    // rust: status::Serverbound::StatusRequest(_) if requested => return Ok(()),
    // rust: status::Serverbound::StatusRequest(_) => {
    // rust: requested = true;
                // A client this server lets join is told its own protocol, so its list shows it joinable.
    // rust: let json = match older_client(shared, protocol) {
    // rust: Some(_) => shared.status_json_for(protocol),
    // rust: None => shared.status_json(),
}
    // rust: c.send(
    // rust: &status::Clientbound::StatusResponse(status::StatusResponse { json }).encode(),
    // rust: )
    // rust: .map_err(e)?;
}
    // rust: status::Serverbound::PingRequest(p) => {
    // rust: c.send(&status::Clientbound::PongResponse(p).encode())
    // rust: .map_err(e)?;
    // rust: return Ok(());
}
    // rust: status::Serverbound::Unknown(..) => return Ok(()),
}
}
}

// ServerLoginPacketListenerImpl.getUserName: the name and the address
// (Connection.getLoggableAddress, `/ip:port` as InetSocketAddress prints it).
user_name :: proc(name: string, address: std::net::SocketAddr, log: ^super::NetLog) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if log.log_ips {
    // rust: format!("{name} (/{address})")
    // rust: } else {
    // rust: format!("{name} (<ip address withheld>)")
}
}

// ServerLoginPacketListenerImpl.disconnect: log the reason's text and send
// it. Returns the text, for the "lost connection" line that follows.
    // rust: fn refuse(
    // rust: c: &mut Connection,
    // rust: shared: &Shared,
    // rust: thread: &str,
    // rust: user: &str,
    // rust: reason: &horizon_world::nbt::Tag,
    // rust: ) -> String {
    // rust: let text = shared
    // rust: .config
    // rust: .log
    // rust: .as_ref()
    // rust: .map(|log| horizon_protocol::text::plain(reason, &log.lang))
    // rust: .unwrap_or_default();
    // rust: if let Some(log) = &shared.config.log {
    // rust: (log.write)(thread, "INFO", &format!("Disconnecting {user}: {text}"));
}
    // rust: login_disconnect(c, reason);
    // rust: text
}

// ServerLoginPacketListenerImpl.onDisconnect, once the server thread sees
// the connection closed: by a refusal, or by the client ("Disconnected").
lost :: proc(shared: ^Shared, user: string, text: string) {
}
    // rust: if let Some(log) = &shared.config.log {
    // rust: (log.write)(
    // rust: "Server thread",
    // rust: "INFO",
    // rust: &format!("{user} lost connection: {text}"),
    // rust: );
}
}

// UNIQUE_THREAD_ID: the User Authenticator threads are numbered from 1.
AUTHENTICATORS :: AtomicU32::new(0)

// ServerLoginPacketListenerImpl.handleKey and the User Authenticator
// thread: check the client's answer to the encryption request, encrypt the
// connection, and ask the session service whether the player joined with
// this server's hash. The profile, or the text of the refusal.
    // rust: fn authenticate(
    // rust: c: &mut Connection,
    // rust: shared: &Shared,
    // rust: online: &super::OnlineMode,
    // rust: name: &str,
    // rust: address: std::net::SocketAddr,
    // rust: user: &str,
    // rust: ) -> Result<Result<(u128, Vec<login::Property>), String>, String> {
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: let mut challenge = [0u8; 4];
    // rust: horizon_protocol::crypto::random_bytes(&mut challenge).map_err(e)?;
    // rust: c.send(
    // rust: &login::Clientbound::Hello(login::Hello {
    // rust: server_id: String::new(),
    // rust: public_key: online.public_der.clone(),
    // rust: challenge: challenge.to_vec(),
    // rust: should_authenticate: true,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: let key = match login::Serverbound::decode(id, &payload).map_err(e)? {
    // rust: login::Serverbound::Key(k) => k,
    // rust: _ => return Err("Unexpected packet during login".into()),
}
    // ServerboundKeyPacket.isChallengeValid and getSecretKey.
    // rust: let protocol_error = || "Protocol error".to_owned();
    // rust: if online.key.decrypt(&key.challenge).ok().as_deref() != Some(&challenge[..]) {
    // rust: return Err(protocol_error());
}
    // rust: let secret: [u8; 16] = online
    // rust: .key
    // rust: .decrypt(&key.key)
    // rust: .ok()
    // rust: .and_then(|s| s.try_into().ok())
    // rust: .ok_or_else(protocol_error)?;
    // rust: let digest = server_hash("", &secret, &online.public_der);
    // rust: c.enable_encryption(&secret);
    // rust: let thread = format!(
    // rust: "User Authenticator #{}",
    // rust: AUTHENTICATORS.fetch_add(1, Ordering::Relaxed) + 1
    // rust: );
    // rust: let log = |level: &str, line: &str| {
    // rust: if let Some(log) = &shared.config.log {
    // rust: (log.write)(&thread, level, line);
}
}
    // rust: let ip = online.prevent_proxy.then(|| address.ip());
    // rust: match crate::auth::has_joined(name, &digest, ip) {
    // rust: Ok(Some(profile)) => {
    // rust: log(
    // rust: "INFO",
    // rust: &format!("UUID of player {name} is {}", uuid_string(profile.uuid)),
    // rust: );
    // rust: Ok(Ok((profile.uuid, profile.properties)))
}
    // rust: Ok(None) => {
    // rust: let text = refuse(
    // rust: c,
    // rust: shared,
    // rust: &thread,
    // rust: user,
    // rust: &translatable("multiplayer.disconnect.unverified_username", &[]),
    // rust: );
    // rust: log(
    // rust: "ERROR",
    // rust: &format!("Username '{name}' tried to join with an invalid session"),
    // rust: );
    // rust: Ok(Err(text))
}
    // rust: Err(_) => {
    // rust: let text = refuse(
    // rust: c,
    // rust: shared,
    // rust: &thread,
    // rust: user,
    // rust: &translatable("multiplayer.disconnect.authservers_down", &[]),
    // rust: );
    // rust: log(
    // rust: "ERROR",
    // rust: "Couldn't verify username because servers are unavailable",
    // rust: );
    // rust: Ok(Err(text))
}
}
}

    // rust: fn serve_login(
    // rust: mut c: Connection,
    // rust: address: std::net::SocketAddr,
    // rust: shared: &Arc<Shared>,
    // rust: counted: Option<super::Counted>,
    // rust: ) -> Result<(), String> {
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: let hello = match login::Serverbound::decode(id, &payload).map_err(e)? {
    // rust: login::Serverbound::Hello(h) => h,
    // rust: _ => return Err("expected a login hello".into()),
}
    // rust: if !valid_name(&hello.name) {
        // handleHello's validState throws; Connection.exceptionCaught sends the
        // exception as the login disconnect.
    // rust: login_disconnect(
    // rust: &mut c,
    // rust: &translatable(
    // rust: "disconnect.genericReason",
    // rust: &[
    // rust: "Internal Exception: java.lang.IllegalStateException: Invalid characters in username",
    // rust: ],
    // rust: ),
    // rust: );
    // rust: return Ok(());
}
    // rust: let (mut name, mut address) = (hello.name.clone(), address);
    // rust: let user_of = |name: &str, address| {
    // rust: shared
    // rust: .config
    // rust: .log
    // rust: .as_ref()
    // rust: .map(|log| user_name(name, address, log))
    // rust: .unwrap_or_default()
}
    // rust: let mut user = user_of(&name, address);
    // handleHello: online mode authenticates first; offline mode, and the
    // integrated server's own player through memory, derive the profile
    // from the name. Behind a Velocity proxy (forwarding.secret) the proxy has
    // authenticated the player and the profile is the one it forwards.
    // rust: let online = shared.config.online.as_ref().filter(|_| !c.is_memory());
    // rust: let forwarding = shared
    // rust: .config
    // rust: .forwarding_secret
    // rust: .as_deref()
    // rust: .filter(|_| online.is_none() && !c.is_memory());
    // rust: let (uuid, properties) = match (online, forwarding) {
    // rust: (Some(online), _) => {
    // rust: match authenticate(&mut c, shared, online, &hello.name, address, &user) {
    // rust: Ok(Ok(profile)) => profile,
    // rust: Ok(Err(refused)) => {
    // rust: lost(shared, &user, &refused);
    // rust: return Ok(());
}
    // rust: Err(err) => {
    // rust: lost(shared, &user, "Disconnected");
    // rust: return Err(err);
}
}
}
    // rust: (None, Some(secret)) => match forward(&mut c, secret) {
    // rust: Ok(Ok(forwarded)) => {
    // rust: (name, address) = (
    // rust: forwarded.name,
    // rust: std::net::SocketAddr::new(forwarded.address, address.port()),
    // rust: );
    // rust: user = user_of(&name, address);
    // rust: (forwarded.uuid, forwarded.properties)
}
    // rust: Ok(Err(reason)) => {
    // rust: let text = "This server is behind a proxy: join through the proxy.";
    // rust: let json = format!("{{\"text\":\"{text}\"}}");
    // rust: let _ = c.send(
    // rust: &login::Clientbound::Disconnect(login::Disconnect { reason_json: json })
    // rust: .encode(),
    // rust: );
    // rust: if let Some(log) = &shared.config.log {
    // rust: (log.write)(
    // rust: "Server thread",
    // rust: "WARN",
    // rust: &format!("Refused {user}: {reason}"),
    // rust: );
}
    // rust: lost(shared, &user, text);
    // rust: return Ok(());
}
    // rust: Err(err) => {
    // rust: lost(shared, &user, "Disconnected");
    // rust: return Err(err);
}
    // rust: },
    // rust: (None, None) => (offline_uuid(&hello.name), Vec::new()),
}
    // verifyLoginAndFinishConnectionSetup: PlayerList.canPlayerLogin, then
    // duplicates and a full server.
    // rust: if let Some(reason) = shared.try_admit(address, uuid, &name) {
    // rust: let text = refuse(&mut c, shared, "Server thread", &user, &reason);
    // rust: lost(shared, &user, &text);
    // rust: return Ok(());
}
    // A player a proxy said would arrive (`player-expect`) uses the expectation up
    // here, as the login starts: one that ran out while the player was still in
    // configuration (a resource pack prompt) would otherwise make it an ordinary
    // login from this server's own file.
    // rust: let expected = shared.config.arrivals.as_ref().and_then(|table| {
    // rust: table
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .take_until(uuid, std::time::Instant::now())
    // rust: });
    // A login that does not reach play (it failed in configuration) gives the
    // expectation back, so the proxy's next attempt is still expected.
    // rust: let put_back = || {
    // rust: if let (Some(deadline), Some(table)) = (expected, shared.config.arrivals.as_ref()) {
    // rust: table.lock().unwrap_or_else(|e| e.into_inner()).put_back(
    // rust: uuid,
    // rust: deadline,
    // rust: std::time::Instant::now(),
    // rust: );
}
}
    // rust: let result = login_and_configure(&mut c, shared, uuid, &name, properties);
    // rust: match result {
    // rust: Ok(Some(parts)) => {
    // rust: play(c, shared, parts, address, counted, expected.is_some());
    // rust: Ok(())
}
    // rust: Ok(None) => {
    // rust: put_back();
    // rust: shared.release(uuid);
    // rust: Ok(())
}
    // rust: Err(err) => {
    // rust: put_back();
    // rust: shared.release(uuid);
            // ServerConfigurationPacketListenerImpl.onDisconnect.
    // rust: let profile = format!("{name} ({})", uuid_string(uuid));
    // rust: lost(shared, &profile, "Disconnected");
    // rust: Err(err)
}
}
}

// Asks the proxy for the player's forwarded information (login plugin channel `velocity:player_info`) and
// checks it against the shared secret. The outer error is the connection failing; the inner one is a refusal
// (the client isn't a proxy, or signed with another secret), with the reason for the log.
    // rust: fn forward(
    // rust: c: &mut Connection,
    // rust: secret: &[u8],
    // rust: ) -> Result<Result<forwarding::Forwarded, String>, String> {
TRANSACTION :: 1
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: c.send(
    // rust: &login::Clientbound::CustomQuery(login::CustomQuery {
    // rust: transaction: TRANSACTION,
    // rust: channel: forwarding::CHANNEL.into(),
    // rust: data: forwarding::request(),
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: match login::Serverbound::decode(id, &payload).map_err(e)? {
    // rust: login::Serverbound::CustomQueryAnswer(answer) if answer.transaction == TRANSACTION => {
    // rust: Ok(match answer.payload {
    // rust: Some(data) => forwarding::verify(secret, &data),
    // rust: None => Err("the client didn't answer the forwarding request".into()),
    // rust: })
}
    // rust: _ => Err("unexpected packet during login".into()),
}
}

Parts :: struct {
    uuid: u128,
    name: string,
    properties: [dynamic]login::Property,
    info: ClientInformation,
    brand: string,
}

    // rust: fn login_and_configure(
    // rust: c: &mut Connection,
    // rust: shared: &Arc<Shared>,
    // rust: uuid: u128,
    // rust: name: &str,
    // rust: properties: Vec<login::Property>,
    // rust: ) -> Result<Option<Parts>, String> {
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // ServerLoginPacketListenerImpl: memory connections are not compressed.
    // rust: let threshold = shared.config.compression_threshold;
    // rust: if threshold >= 0 && !c.is_memory() {
    // rust: c.send(&login::Clientbound::Compression(login::Compression { threshold }).encode())
    // rust: .map_err(e)?;
    // rust: c.set_compression(threshold);
}
    // rust: c.send(
    // rust: &login::Clientbound::LoginFinished(login::LoginFinished {
    // rust: profile: login::GameProfile {
    // rust: uuid,
    // rust: name: name.to_owned(),
    // rust: properties: properties.clone(),
    // rust: },
    // rust: session: uuid,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .map_err(e)?;
    // The client may send its settings before acknowledging the login.
    // rust: loop {
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: match login::Serverbound::decode(id, &payload).map_err(e)? {
    // rust: login::Serverbound::LoginAcknowledged(_) => break,
    // rust: login::Serverbound::CustomQueryAnswer(_) | login::Serverbound::CookieResponse(_) => {}
    // rust: _ => return Err("unexpected packet during login".into()),
}
}
    // rust: c.reader.set_read_timeout(Some(READ_TIMEOUT)).map_err(e)?;
    // Configuration.
    // rust: let sync_data = shared.sync();
    // rust: let sync: &SyncData = &sync_data;
    // rust: let send = |c: &mut Connection, p: cfg::Clientbound| c.send(&p.encode()).map_err(e);
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: "minecraft:brand".into(),
    // rust: data: {
    // rust: let mut w = horizon_protocol::buf::Writer::new();
                // MinecraftServer.getServerModName: "vanilla" there; a modded
                // server names itself, and Horizon's says "horizon", as its client does.
    // rust: w.string("horizon");
    // rust: w.data
    // rust: },
    // rust: }),
    // rust: )?;
    // ServerConfigurationPacketListenerImpl.startConfiguration: links, only
    // when there are any (MinecraftServer.serverLinks is empty elsewhere).
    // rust: if !shared.config.server_links.is_empty() {
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::ServerLinks(cfg::ServerLinks {
    // rust: links: shared.config.server_links.clone(),
    // rust: }),
    // rust: )?;
}
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::UpdateEnabledFeatures(cfg::UpdateEnabledFeatures {
    // rust: features: sync.features.clone(),
    // rust: }),
    // rust: )?;
    // rust: let core = KnownPack {
    // rust: namespace: CORE_PACK.0.into(),
    // rust: id: CORE_PACK.1.into(),
    // rust: version: CORE_PACK.2.into(),
}
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::SelectKnownPacks(cfg::SelectKnownPacks {
    // rust: packs: vec![core.clone()],
    // rust: }),
    // rust: )?;
    // rust: let mut info = ClientInformation::new(10);
    // rust: let mut brand = String::from("vanilla");
    // rust: let known_pack = loop {
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: match decode_config(id, &payload).map_err(e)? {
    // rust: cfg::Serverbound::ClientInformation(i) => info = i,
    // rust: cfg::Serverbound::CustomPayload(p) if p.channel == "minecraft:brand" => {
    // rust: brand = horizon_protocol::buf::Reader::new(&p.data)
    // rust: .string(32767)
    // rust: .unwrap_or(brand);
}
    // rust: cfg::Serverbound::SelectKnownPacks(p) => break p.packs == vec![core.clone()],
    // rust: _ => {}
}
}
    // An older client's packet ids are translated, not yet what is inside them (#10404): the registry data,
    // tags and play packets would reach it in 26.3's ids and layouts, so it is turned away before them.
    // rust: if let Some(version) = c.older_client()
    // rust: && !shared.config.older_clients_play
    // rust: {
    // rust: let text = super::OLDER_CLIENTS_UNFINISHED;
    // rust: let reason = horizon_world::nbt::Tag::String(horizon_world::nbt::JavaString::from(text));
    // rust: let _ = send(c, cfg::Clientbound::Disconnect(cfg::Disconnect { reason }));
    // rust: if let Some(log) = &shared.config.log {
    // rust: let line = format!(
    // rust: "Disconnecting {name}: its client is on protocol {} ({text})",
    // rust: version.protocol()
    // rust: );
    // rust: (log.write)("Server thread", "INFO", &line);
}
    // rust: lost(shared, &format!("{name} ({})", uuid_string(uuid)), text);
    // rust: return Ok(None);
}
    // Custom component IDs need Horizon's registry check. The server may also
    // require Horizon clients even when it has no custom components.
    // rust: if brand != "horizon"
    // rust: && (shared.config.horizon_clients_only
    // rust: || horizon_protocol::item::custom::entries().next().is_some())
    // rust: {
    // rust: let text = if shared.config.horizon_clients_only {
    // rust: super::HORIZON_CLIENTS_ONLY_REASON
    // rust: } else {
    // rust: crate::content_identity::MISMATCH
}
    // rust: let reason = horizon_world::nbt::Tag::String(horizon_world::nbt::JavaString::from(text));
    // rust: let _ = send(c, cfg::Clientbound::Disconnect(cfg::Disconnect { reason }));
    // rust: if let Some(log) = &shared.config.log {
    // rust: let line =
    // rust: format!("Disconnecting {name}: its client is \"{brand}\", not Horizon ({text})");
    // rust: (log.write)("Server thread", "INFO", &line);
}
    // rust: lost(shared, &format!("{name} ({})", uuid_string(uuid)), text);
    // rust: return Ok(None);
}
    // A Horizon client hears that this server runs its mods' quiet commands
    // (horizon_protocol::quiet); a vanilla one is told nothing.
    // rust: if brand == "horizon" {
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: horizon_protocol::quiet::CHANNEL.into(),
    // rust: data: Vec::new(),
    // rust: }),
    // rust: )?;
        // And that it carries native mods' messages (horizon_protocol::mod_net).
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: horizon_protocol::mod_net::CHANNEL.into(),
    // rust: data: Vec::new(),
    // rust: }),
    // rust: )?;
}
    // And how far it samples far terrain for it (crate::lod_net).
    // rust: if brand == "horizon" && shared.config.lod_distance > 0 {
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: crate::lod_net::CHANNEL.into(),
    // rust: data: crate::lod_net::Offer::new(shared.config.lod_distance).encode(),
    // rust: }),
    // rust: )?;
}
    // The mods that must be the same on both sides, named when they are not
    // (horizon_protocol::mod_list); the registry hash below only sees ids.
    // rust: let server_mods = horizon_protocol::mod_list::local();
    // rust: if brand == "horizon" && !server_mods.is_empty() {
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: horizon_protocol::mod_list::CHANNEL.into(),
    // rust: data: horizon_protocol::mod_list::encode(&horizon_protocol::mod_list::shared(
    // rust: &server_mods,
    // rust: )),
    // rust: }),
    // rust: )?;
    // rust: send(c, cfg::Clientbound::Ping(cfg::Ping { id: 1 }))?;
        // A client that does not answer has no mods to offer.
    // rust: let mut client_mods = Vec::new();
    // rust: loop {
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: match decode_config(id, &payload).map_err(e)? {
    // rust: cfg::Serverbound::CustomPayload(p)
    // rust: if p.channel == horizon_protocol::mod_list::CHANNEL =>
    // rust: {
    // rust: client_mods = horizon_protocol::mod_list::decode(&p.data).unwrap_or_default();
}
    // rust: cfg::Serverbound::Pong(p) if p.id == 1 => break,
    // rust: cfg::Serverbound::ClientInformation(i) => info = i,
    // rust: _ => {}
}
}
    // rust: let difference = horizon_protocol::mod_list::compare(&server_mods, &client_mods);
    // rust: if !difference.is_empty() {
    // rust: let text = difference.reason();
    // rust: let reason = horizon_world::nbt::Tag::String(horizon_world::nbt::JavaString::from(
    // rust: text.as_str(),
    // rust: ));
    // rust: let _ = send(c, cfg::Clientbound::Disconnect(cfg::Disconnect { reason }));
    // rust: lost(shared, &format!("{name} ({})", uuid_string(uuid)), &text);
    // rust: return Ok(None);
}
}
    // rust: if brand == "horizon"
    // rust: && let Some(hash) = sync.content_identity
    // rust: {
    // rust: send(
    // rust: c,
    // rust: cfg::Clientbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: crate::content_identity::CHANNEL.into(),
    // rust: data: hash.to_vec(),
    // rust: }),
    // rust: )?;
    // rust: send(c, cfg::Clientbound::Ping(cfg::Ping { id: 0 }))?;
    // rust: let mut content_match = false;
    // rust: loop {
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: match decode_config(id, &payload).map_err(e)? {
    // rust: cfg::Serverbound::CustomPayload(p)
    // rust: if p.channel == crate::content_identity::CHANNEL =>
    // rust: {
    // rust: content_match = p.data == hash;
}
    // rust: cfg::Serverbound::Pong(p) if p.id == 0 => break,
    // rust: cfg::Serverbound::ClientInformation(i) => info = i,
    // rust: _ => {}
}
}
    // rust: if !content_match {
    // rust: let reason = horizon_world::nbt::Tag::String(horizon_world::nbt::JavaString::from(
    // rust: crate::content_identity::MISMATCH,
    // rust: ));
    // rust: let _ = send(c, cfg::Clientbound::Disconnect(cfg::Disconnect { reason }));
    // rust: lost(
    // rust: shared,
    // rust: &format!("{name} ({})", uuid_string(uuid)),
    // rust: crate::content_identity::MISMATCH,
    // rust: );
    // rust: return Ok(None);
}
}
    // rust: for packet in sync.registry_packets(known_pack, &shared.config.levels) {
    // rust: send(c, cfg::Clientbound::RegistryData(packet))?;
}
    // rust: send(c, cfg::Clientbound::UpdateTags(sync.tags.clone()))?;
    // addOptionalTasks: the code of conduct task comes first.
    // rust: if let Some(text) =
    // rust: super::code_of_conduct::pick(&shared.config.code_of_conducts, &info.language)
    // rust: {
    // rust: accept_code_of_conduct(c, text, &mut info)?;
}
    // rust: if let Some(pack) = &shared.config.resource_pack
    // rust: && let Some(rejected) = offer_pack(c, pack, &mut info)?
    // rust: {
    // rust: let (reason, text) = pack_rejected(shared, name, rejected);
    // rust: let _ = send(c, cfg::Clientbound::Disconnect(cfg::Disconnect { reason }));
    // rust: lost(shared, &format!("{name} ({})", uuid_string(uuid)), &text);
    // rust: return Ok(None);
}
    // rust: send(c, cfg::Clientbound::FinishConfiguration(Empty))?;
    // rust: loop {
    // rust: let (id, payload) = c.recv().map_err(e)?;
    // rust: match decode_config(id, &payload).map_err(e)? {
    // rust: cfg::Serverbound::FinishConfiguration(_) => break,
    // rust: cfg::Serverbound::ClientInformation(i) => info = i,
    // rust: _ => {}
}
}
    // rust: Ok(Some(Parts {
    // rust: uuid,
    // rust: name: name.to_owned(),
    // rust: properties,
    // rust: info,
    // rust: brand,
    // rust: }))
}

// ServerboundResourcePackPacket.Action.DECLINED.
PACK_DECLINED :: 1

// ServerCommonPacketListenerImpl.handleResourcePackResponse: a player who
// declined the required pack is disconnected. The reason and its text.
pack_rejected :: proc(shared: ^Shared, name: string, pack: u128) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let reason = translatable("multiplayer.requiredTexturePrompt.disconnect", &[]);
    // rust: let Some(log) = &shared.config.log else {
    // rust: return (reason, String::new());
}
    // rust: let line = format!(
    // rust: "Disconnecting {name} due to resource pack {} rejection",
    // rust: uuid_string(pack)
    // rust: );
    // rust: (log.write)("Server thread", "INFO", &line);
    // rust: let text = horizon_protocol::text::plain(&reason, &log.lang);
    // rust: (reason, text)
}

// RateKickingConnection: a player whose packets a second passed rate-limit
// is disconnected ("disconnect.exceeded_packet_rate") with a WARN, as
// vanilla's kick logs it.
rate_exceeded :: proc(shared: ^Shared, average: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let reason = translatable("disconnect.exceeded_packet_rate", &[]);
    // rust: let Some(log) = &shared.config.log else {
    // rust: return (reason, String::new());
}
    // rust: let line = format!(
    // rust: "Player exceeded rate-limit (sent {} packets per second)",
    // rust: crate::java_text::float_to_string(average)
    // rust: );
    // rust: (log.write)("Server thread", "WARN", &line);
    // rust: let text = horizon_protocol::text::plain(&reason, &log.lang);
    // rust: (reason, text)
}

// ServerResourcePackConfigurationTask: offer the server's pack, then wait
// for the client's final answer (`Action.isTerminal`: anything but
// ACCEPTED or DOWNLOADED). The player may take a while to answer the
// prompt, so the connection is kept alive meanwhile, as
// ServerConfigurationPacketListenerImpl.tick does. The id of a required
// pack the client declined, which disconnects it.
    // rust: fn offer_pack(
    // rust: c: &mut Connection,
    // rust: pack: &crate::server::properties::ResourcePackInfo,
    // rust: info: &mut ClientInformation,
    // rust: ) -> Result<Option<u128>, String> {
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: let push = cfg::ResourcePackPush {
    // rust: id: pack.id,
    // rust: url: pack.url.clone(),
    // rust: hash: pack.hash.clone(),
    // rust: required: pack.required,
    // rust: prompt: pack.prompt.as_ref().map(component_tag),
}
    // rust: c.send(&cfg::Clientbound::ResourcePackPush(push).encode())
    // rust: .map_err(e)?;
    // rust: wait_alive(c, |packet| match packet {
    // rust: Ok(cfg::Serverbound::ResourcePack(r)) if !matches!(r.action, 3 | 4) => {
    // rust: let rejected = r.action == PACK_DECLINED && pack.required;
    // rust: Some(Ok(rejected.then_some(r.id)))
}
    // rust: Ok(cfg::Serverbound::ClientInformation(i)) => {
    // rust: *info = i;
    // rust: None
}
    // rust: Ok(_) => None,
    // rust: Err(err) => Some(Err(err)),
    // rust: })
}

// ServerCodeOfConductConfigurationTask: send the text, then wait for
// ServerboundAcceptCodeOfConductPacket (`handleAcceptCodeOfConduct`),
// keeping the connection alive while the player reads. Finishing the
// configuration first is `finishCurrentTask` of the wrong task type, an
// error that drops the connection.
    // rust: fn accept_code_of_conduct(
    // rust: c: &mut Connection,
    // rust: text: &str,
    // rust: info: &mut ClientInformation,
    // rust: ) -> Result<(), String> {
    // rust: let e = |e: horizon_protocol::Error| e.to_string();
    // rust: c.send(&cfg::Clientbound::CodeOfConduct(cfg::CodeOfConduct { text: text.into() }).encode())
    // rust: .map_err(e)?;
    // rust: wait_alive(c, |packet| match packet {
    // rust: Ok(cfg::Serverbound::AcceptCodeOfConduct(_)) => Some(Ok(())),
    // rust: Ok(cfg::Serverbound::FinishConfiguration(_)) => {
    // rust: Some(Err("Unexpected configuration task".to_owned()))
}
    // rust: Ok(cfg::Serverbound::ClientInformation(i)) => {
    // rust: *info = i;
    // rust: None
}
    // rust: Ok(_) => None,
    // rust: Err(err) => Some(Err(err)),
    // rust: })
}

// Read configuration packets until `answer` has a result, sending a
// keep-alive every `KEEP_ALIVE_EVERY` meanwhile
// (ServerConfigurationPacketListenerImpl.tick).
    // rust: fn wait_alive<T>(
    // rust: c: &mut Connection,
    // rust: mut answer: impl FnMut(Result<cfg::Serverbound, String>) -> Option<Result<T, String>>,
    // rust: ) -> Result<T, String> {
    // rust: std::thread::scope(|scope| {
    // rust: let (stop, stopped) = channel::<()>();
    // rust: let writer = &mut c.writer;
    // rust: scope.spawn(move || {
    // rust: let start = Instant::now();
    // rust: while stopped.recv_timeout(KEEP_ALIVE_EVERY) == Err(RecvTimeoutError::Timeout) {
    // rust: let id = i64::try_from(start.elapsed().as_millis()).unwrap_or(0);
    // rust: let keep_alive = cfg::Clientbound::KeepAlive(cfg::KeepAlive { id });
    // rust: if writer.send(&keep_alive.encode()).is_err() {
    // rust: break;
}
}
    // rust: });
    // rust: let result = loop {
    // rust: let packet = match c.reader.recv() {
    // rust: Ok((id, payload)) => decode_config(id, &payload).map_err(|e| e.to_string()),
    // rust: Err(err) => break Err(err.to_string()),
}
    // rust: if let Some(result) = answer(packet) {
    // rust: break result;
}
}
    // rust: drop(stop);
    // rust: result
    // rust: })
}

    // rust: fn play(
    // rust: c: Connection,
    // rust: shared: &Arc<Shared>,
    // rust: parts: Parts,
    // rust: address: std::net::SocketAddr,
    // rust: counted: Option<super::Counted>,
    // rust: expected: bool,
    // rust: ) {
    // rust: shared.entered_play();
    // rust: let conn = shared.next_id();
    // rust: let pending = Arc::new(AtomicUsize::new(0));
    // rust: let outbox = match io_pool::Outbox::new(pending.clone()) {
    // rust: Ok(outbox) => outbox,
    // rust: Err(e) => {
    // rust: log::warn!("[lan] {e}");
    // rust: shared.release(parts.uuid);
    // rust: return;
}
}
    // rust: let latency = Arc::new(AtomicI32::new(0));
    // rust: let watch = Arc::new(KeepAliveWatch {
    // rust: start: Instant::now(),
    // rust: alive: Arc::new(AtomicI64::new(-1)),
    // rust: });
    // rust: let sender = PlayerSender {
    // rust: pending,
    // rust: held: Arc::default(),
    // rust: to: To::Pool(outbox.clone(), watch.clone()),
    // rust: wire: Some(c.reader.counters.clone()),
}
    // rust: let required_pack = shared
    // rust: .config
    // rust: .resource_pack
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.required);
    // rust: let session = PlayConn {
    // rust: conn,
    // rust: shared: shared.clone(),
    // rust: uuid: parts.uuid,
    // rust: name: parts.name.clone(),
    // rust: required_pack,
    // rust: rate: PacketRate::new(shared.config.rate_limit, Instant::now()),
    // rust: latency: latency.clone(),
    // rust: sent_at: None,
    // rust: next_keep_alive: watch.start + KEEP_ALIVE_EVERY,
    // rust: watch,
    // rust: counted,
}
    // rust: let joined = Joined {
    // rust: conn,
    // rust: uuid: parts.uuid,
    // rust: name: parts.name,
    // rust: properties: parts.properties,
    // rust: info: parts.info,
    // rust: brand: parts.brand,
    // rust: sender,
    // rust: latency,
    // rust: address,
    // rust: expected,
}
    // rust: let mut session = Box::new(session);
    // rust: if shared
    // rust: .events
    // rust: .send(NetEvent::Joined(Box::new(joined)))
    // rust: .is_err()
    // rust: {
    // rust: session.left("server closed".to_owned());
    // rust: session.closed();
    // rust: return;
}
    // rust: let (socket, reader, writer) = c.detach();
    // rust: io_pool::adopt(socket, (reader, writer), outbox, session, READ_TIMEOUT);
}

// A player's play state on its network thread.
PlayConn :: struct {
    conn: u32,
    shared: ^Shared,
    uuid: u128,
    name: string,
    required_pack: bool,
    rate: Maybe(PacketRate),
    watch: ^KeepAliveWatch,
    // Smoothed keep-alive round trip in milliseconds.
    latency: ^AtomicI32,
    // The keep-alive waiting for its answer, and when it was sent.
    sent_at: Option<(i64,
    next_keep_alive: Instant,
    // The connection's place among the server's, given back once closed.
    counted: Maybe(super::Counted),
}
    // rust: impl io_pool::Session for PlayConn {
    // Forward the player's packet, or say why it ends the connection: a
    // required resource pack declined, a rate-limit excess, a malformed packet.
packet :: proc(self: ^Self, id: i32, payload: [dynamic]u8) -> i {
    // Ported from Horizon
    return {}
}
//         use io_pool::Verdict;
    // rust: let kick = |(reason, text): (horizon_world::nbt::Tag, String)| {
    // rust: let body = play::Clientbound::Disconnect(cfg::Disconnect { reason }).encode();
    // rust: Verdict::Kick(text, body)
}
    // rust: let now = Instant::now();
    // rust: if let Some(average) = self.rate.as_mut().and_then(|r| r.received(now)) {
    // rust: return kick(rate_exceeded(&self.shared, average));
}
    // rust: match play::Serverbound::decode(id, &payload).and_then(checked_play) {
    // rust: Ok(play::Serverbound::KeepAlive(k)) => {
    // rust: self.watch.alive.store(k.id, Ordering::Relaxed);
    // rust: if let Some((sent, at)) = self.sent_at
    // rust: && k.id == sent
    // rust: {
    // rust: let ms = i32::try_from(at.elapsed().as_millis()).unwrap_or(i32::MAX);
    // rust: let old = self.latency.load(Ordering::Relaxed);
    // rust: self.latency.store((old * 3 + ms) / 4, Ordering::Relaxed);
    // rust: self.sent_at = None;
}
    // rust: Verdict::Go
}
    // rust: Ok(play::Serverbound::ResourcePack(r))
    // rust: if r.action == PACK_DECLINED && self.required_pack =>
    // rust: {
    // rust: kick(pack_rejected(&self.shared, &self.name, r.id))
}
    // rust: Ok(p) => {
    // rust: let event = NetEvent::Packet(self.conn, Box::new(p), payload.len());
    // rust: match self.shared.events.send(event) {
    // rust: Ok(()) => Verdict::Go,
    // rust: Err(_) => Verdict::Close("server closed".to_owned()),
}
}
            // A malformed packet disconnects like vanilla's decoder exception.
    // rust: Err(e) => Verdict::Close(format!("Invalid packet {id}: {e}")),
}
}
    // ServerCommonPacketListenerImpl.keepConnectionAlive: a keep-alive 15 s
    // after the last was answered. The game thread times a client out
    // ([`PlayerSender::timed_out`]).
tick :: proc(self: ^Self, now: Instant) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.sent_at.is_some() || now < self.next_keep_alive {
    // rust: return None;
}
    // rust: let id = i64::try_from(self.watch.start.elapsed().as_millis()).unwrap_or(0);
    // rust: self.sent_at = Some((id, now));
    // rust: self.next_keep_alive = now + KEEP_ALIVE_EVERY;
    // rust: Some(play::Clientbound::KeepAlive(cfg::KeepAlive { id }).encode())
}
left :: proc(self: ^Self, reason: string) {
}
    // rust: let _ = self.shared.events.send(NetEvent::Left(self.conn, reason));
    // rust: self.shared.closing.fetch_add(1, Ordering::AcqRel);
}
closed :: proc(self: ^Self) {
}
    // rust: self.shared.closing.fetch_sub(1, Ordering::AcqRel);
    // rust: self.shared.release(self.uuid);
    // rust: self.counted = None;
}
}

// RateKickingConnection: the packets a second a connection averages, as
// Connection.tickSecond keeps it, against server.properties' rate-limit.
PacketRate :: struct {
    limit: f32,
    received: u32,
    average: f32,
    next: Instant,
}
    // rust: impl PacketRate {
    // The tracker of a connection, or none when the limit is off (0 or less).
new :: proc(limit: i32, now: Instant) -> O {
    // Ported from Horizon
    return {}
}
    // rust: (limit > 0).then(|| Self {
    // rust: limit: limit as f32,
    // rust: received: 0,
    // rust: average: 0.0,
    // rust: next: now + Duration::from_secs(1),
    // rust: })
}
    // A packet arrived. Every whole second the average updates
    // (Mth.lerp(0.75F, received, average)): over the limit, Some of it.
received :: proc(self: ^Self, now: Instant) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let exceeded = if now >= self.next {
            // One tick with the count, then a packetless tick's 0.75 decay
            // for each further whole second already gone.
    // rust: let first = self.received as f32 + 0.75 * (self.average - self.received as f32);
    // rust: self.average = first;
    // rust: self.received = 0;
    // rust: let elapsed = (now - self.next).as_secs() + 1;
    // rust: if elapsed > 1 {
    // rust: self.average *= 0.75f32.powi((elapsed - 1) as i32);
}
    // rust: self.next += Duration::from_secs(elapsed);
    // rust: (first > self.limit).then_some(first)
    // rust: } else {
    // rust: None
}
    // rust: self.received = self.received.saturating_add(1);
    // rust: exceeded
}
}

// ServerboundCustomPayloadPacket's codec (DiscardedPayload): a payload of at most
// 32767 bytes, in configuration and in play.
MAX_PAYLOAD :: horizon_protocol::quiet::MAX_PAYLOAD
COMMAND_SUGGESTION :: horizon_protocol::ids::play::serverbound::COMMAND_SUGGESTION

too_large :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("Payload may not be larger than {MAX_PAYLOAD} bytes")
}

// A play packet as vanilla's decoders read it.
checked_play :: proc(packet: play::Serverbound) -> h {
    // Ported from Horizon
    return {}
}
    // rust: match &packet {
    // rust: play::Serverbound::CustomPayload(p) if p.data.len() > MAX_PAYLOAD => {
    // rust: Err(horizon_protocol::Error::new(too_large()))
}
        // ServerboundCommandSuggestionPacket: a VarInt id, then the command, at most
        // 32500 chars. The game reads it later; its codec's limits apply here.
    // rust: play::Serverbound::Unknown(COMMAND_SUGGESTION, body) => {
    // rust: let mut r = horizon_protocol::buf::Reader::new(body);
    // rust: r.varint()?;
    // rust: r.string(32500)?;
    // rust: Ok(packet)
}
    // rust: _ => Ok(packet),
}
}

// A configuration packet as vanilla's decoders read it.
decode_config :: proc(id: i32, payload: []u8) -> h {
    // Ported from Horizon
    return {}
}
    // rust: match cfg::Serverbound::decode(id, payload)? {
    // rust: cfg::Serverbound::CustomPayload(p) if p.data.len() > MAX_PAYLOAD => {
    // rust: Err(horizon_protocol::Error::new(too_large()))
}
    // rust: packet => Ok(packet),
}
}

// Packet bodies at least this large are compressed once for every
// connection: chunk columns, mostly, which every player near them receives.
SHARED_FRAME_MIN :: 8 << 10
// The compressed frames kept, in bytes; the oldest go first.
SHARED_FRAME_BYTES :: 32 << 20

// Compressed frame contents by the body they were made from: its length,
// one 128-bit hash of it keyed by a random secret, and the threshold.
SharedFrames :: struct {
    // XXH3's secret, random for each run, so that no body can be made to
    // share its hash with another.
    secret: ^[u8],
    frames: Mutex<FrameCache>,
    // [`SHARED_FRAME_BYTES`].
    limit: uint,
}
    // rust: type FrameKey = (usize, u128, usize);
// A frame's contents, made once: whoever asks while another thread
// compresses the same body waits for it rather than compressing it again.
    // rust: type Frame = Arc<std::sync::OnceLock<Result<Arc<[u8]>, String>>>;
FrameCache :: struct {
    frames: crate::fast_hash::FxHashMap<FrameKey,
    order: std::collections::VecDeque<FrameKey>,
    // The bytes of the frames made and still here.
    bytes: uint,
}
    // rust: impl SharedFrames {
get :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
FRAMES :: std::sync::OnceLock::new()
    // rust: FRAMES.get_or_init(|| Self::new(SHARED_FRAME_BYTES))
}
new :: proc(limit: uint) -> S {
    // Ported from Horizon
    return {}
}
//         use std::hash::{BuildHasher, Hasher};
        // 192 bytes, as XXH3's default secret.
    // rust: let secret = (0..24)
    // rust: .flat_map(|i: usize| {
    // rust: let mut h = std::hash::RandomState::new().build_hasher();
    // rust: h.write_usize(i);
    // rust: h.finish().to_le_bytes()
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: secret,
    // rust: frames: Mutex::default(),
    // rust: limit,
}
}
cache :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.frames.lock().unwrap_or_else(PoisonError::into_inner)
}
    // `frame::contents(body, Some(threshold))`, compressed only when no
    // connection has sent the same body lately or compresses it now.
contents :: proc(self: ^Self, body: []u8, threshold: uint) -> h {
    // Ported from Horizon
    return {}
}
    // rust: let hash = xxhash_rust::xxh3::xxh3_128_with_secret(body, &self.secret);
    // rust: let key = (body.len(), hash, threshold);
    // rust: let (frame, made_here) = {
    // rust: let mut cache = self.cache();
    // rust: match cache.frames.get(&key) {
    // rust: Some(frame) => (frame.clone(), false),
    // rust: None => {
    // rust: let frame = Frame::default();
    // rust: cache.frames.insert(key, frame.clone());
    // rust: cache.order.push_back(key);
    // rust: (frame, true)
}
}
}
    // rust: let contents = frame
    // rust: .get_or_init(|| {
    // rust: horizon_protocol::frame::contents(body, Some(threshold))
    // rust: .map(Arc::from)
    // rust: .map_err(|e| e.to_string())
    // rust: })
    // rust: .clone()
    // rust: .map_err(horizon_protocol::Error::new)?;
    // rust: if made_here {
    // rust: let mut cache = self.cache();
            // Unless pushed out while it was being made.
    // rust: if cache
    // rust: .frames
    // rust: .get(&key)
    // rust: .is_some_and(|f| Arc::ptr_eq(f, &frame))
    // rust: {
    // rust: cache.bytes += contents.len();
}
    // rust: while cache.bytes > self.limit
    // rust: && let Some(old) = cache.order.pop_front()
    // rust: {
    // rust: let made = cache.frames.remove(&old);
    // rust: cache.bytes -= made
    // rust: .and_then(|f| f.get()?.as_ref().ok().map(|c| c.len()))
    // rust: .unwrap_or(0);
}
}
    // rust: Ok(contents)
}
}

// Frame one packet body into `out`: a large one compressed through
// [`SharedFrames`], so a chunk column sent to fifty players is compressed
// once, not fifty times. The bytes on the wire are the same.
    // rust: pub(super) fn frame_body(
    // rust: writer: &mut ConnWriter,
    // rust: body: &[u8],
    // rust: out: &mut Vec<u8>,
    // rust: ) -> horizon_protocol::Result<()> {
    // Renumbered first for a client of an older release; one with no such packet gets nothing.
    // rust: let Some(body) = writer.for_client(body)? else {
    // rust: return Ok(());
}
    // rust: let body = &body[..];
    // rust: match writer.threshold {
    // rust: Some(t) if body.len() >= t.max(SHARED_FRAME_MIN) => {
    // rust: writer.frame_into(&SharedFrames::get().contents(body, t)?, out);
}
    // rust: threshold => writer.frame_into(&horizon_protocol::frame::contents(body, threshold)?, out),
}
    // rust: Ok(())
}

// The keep-alive clock of a play connection, shared by its network thread
// (which sends the keep-alives) and the game thread (which watches them).
KeepAliveWatch :: struct {
    // What keep-alive ids count from: an id is its sending time in ms.
    start: Instant,
    // The id of the last keep-alive the client answered (-1: none yet).
    alive: ^AtomicI64,
}
    // rust: impl KeepAliveWatch {
    // keepConnectionAlive sends a keep-alive 15 s after the last and drops
    // a client that has not answered it 15 s later: nothing answered of
    // what was sent in the last 30 s.
timed_out :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let answered = u64::try_from(self.alive.load(Ordering::Relaxed)).unwrap_or(0);
    // rust: self.start.elapsed() > Duration::from_millis(answered) + 2 * KEEP_ALIVE_EVERY
}
}

    // rust: mod tests {
//     use super::*;

    // Logs in through `c` and answers the `LoginFinished` profile.
login_profile :: proc(mut c: Connection, name: string) -> l {
    // Ported from Horizon
    return {}
}
    // rust: c.send(
    // rust: &handshake::Serverbound::Intention(handshake::Intention {
    // rust: protocol: horizon_protocol::PROTOCOL_VERSION,
    // rust: host: "127.0.0.1".into(),
    // rust: port: 0,
    // rust: intent: handshake::LOGIN,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
    // rust: c.send(
    // rust: &login::Serverbound::Hello(login::ServerHello {
    // rust: name: name.into(),
    // rust: uuid: offline_uuid(name),
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
    // rust: loop {
    // rust: let (id, payload) = c.recv().unwrap();
    // rust: match login::Clientbound::decode(id, &payload).unwrap() {
    // rust: login::Clientbound::Compression(p) => c.set_compression(p.threshold),
    // rust: login::Clientbound::LoginFinished(p) => return p.profile,
    // rust: other => panic!("unexpected login packet {other:?}"),
}
}
}

    // A login by transfer: `Ok` once the profile is told, the reason's JSON when it is turned away.
transfer_login :: proc(mut c: Connection, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: c.send(
    // rust: &handshake::Serverbound::Intention(handshake::Intention {
    // rust: protocol: horizon_protocol::PROTOCOL_VERSION,
    // rust: host: "127.0.0.1".into(),
    // rust: port: 0,
    // rust: intent: handshake::TRANSFER,
    // rust: })
    // rust: .encode(),
    // rust: )
    // rust: .unwrap();
        // A server that does not accept transfers turns one away at the handshake and closes
        // (ServerHandshakePacketListenerImpl.handleIntention), so the hello may find the connection
        // gone: its disconnect is still there to read.
    // rust: let _ = c.send(
    // rust: &login::Serverbound::Hello(login::ServerHello {
    // rust: name: name.into(),
    // rust: uuid: offline_uuid(name),
    // rust: })
    // rust: .encode(),
    // rust: );
    // rust: loop {
    // rust: let (id, payload) = c.recv().unwrap();
    // rust: match login::Clientbound::decode(id, &payload).unwrap() {
    // rust: login::Clientbound::Compression(p) => c.set_compression(p.threshold),
    // rust: login::Clientbound::LoginFinished(_) => return Ok(()),
    // rust: login::Clientbound::Disconnect(d) => return Err(d.reason_json),
    // rust: other => panic!("unexpected login packet {other:?}"),
}
}
}

    // `serversettings/accept_transfers/set` changes what the next transfer finds, with no restart:
    // a server that does not accept transfers turns one away, and takes it once it does.
accepting_transfers_can_be_turned_on_and_off_live :: proc() {
}
    // rust: let config = crate::lan::NetConfig {
    // rust: announce: false,
    // rust: listen: false,
    // rust: accepts_transfers: false,
    // rust: ..crate::lan::NetConfig::loopback(0, "Transfers".into(), 8)
}
    // rust: let lan =
    // rust: crate::lan::Lan::start_with(Arc::new(crate::lan::data::SyncData::empty()), config)
    // rust: .unwrap();
    // rust: let refused = transfer_login(Connection::local(lan.connect_local().unwrap()), "Alex")
    // rust: .expect_err("a transfer is turned away while transfers are off");
    // rust: assert!(
    // rust: refused.contains("multiplayer.disconnect.transfers_disabled"),
    // rust: "{refused}"
    // rust: );
    // rust: lan.shared.set_accepts_transfers(true);
    // rust: transfer_login(Connection::local(lan.connect_local().unwrap()), "Alex")
    // rust: .expect("a transfer is taken once transfers are on");
    // rust: lan.shared.set_accepts_transfers(false);
        // The player of the last login is still here: a second profile tries.
    // rust: let again = transfer_login(Connection::local(lan.connect_local().unwrap()), "Steve")
    // rust: .expect_err("and turned away again once they are off");
    // rust: assert!(
    // rust: again.contains("multiplayer.disconnect.transfers_disabled"),
    // rust: "{again}"
    // rust: );
}

payloads_and_suggestions_past_vanillas_limits_are_malformed :: proc() {
}
    // rust: let payload = |len: usize| {
    // rust: play::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: "a:b".into(),
    // rust: data: vec![0; len],
    // rust: })
}
    // rust: assert!(checked_play(payload(MAX_PAYLOAD)).is_ok());
    // rust: assert!(checked_play(payload(MAX_PAYLOAD + 1)).is_err());
    // rust: let config = |len: usize| {
    // rust: cfg::Serverbound::CustomPayload(cfg::CustomPayload {
    // rust: channel: "a:b".into(),
    // rust: data: vec![0; len],
    // rust: })
    // rust: .encode()
}
        // The body after the packet's one-byte VarInt id.
    // rust: let id = horizon_protocol::ids::configuration::serverbound::CUSTOM_PAYLOAD;
    // rust: assert!(decode_config(id, &config(MAX_PAYLOAD)[1..]).is_ok());
    // rust: assert!(decode_config(id, &config(MAX_PAYLOAD + 1)[1..]).is_err());
    // rust: let suggestion = |len: usize| {
    // rust: let mut w = horizon_protocol::buf::Writer::new();
    // rust: w.varint(7);
    // rust: w.string(&"a".repeat(len));
    // rust: play::Serverbound::Unknown(COMMAND_SUGGESTION, w.data)
}
    // rust: assert!(checked_play(suggestion(32500)).is_ok());
    // rust: assert!(checked_play(suggestion(32501)).is_err());
}

prompts_become_the_components_vanilla_sends :: proc() {
}
    // rust: let tag = |json: &str| {
    // rust: let tag = component_tag(&crate::server::json::parse(json, true).unwrap());
    // rust: component_json(&tag)
}
    // rust: assert_eq!(tag(r#"{"text":"Hi"}"#), r#""Hi""#);
    // rust: assert_eq!(tag(r#""Hi""#), r#""Hi""#);
    // rust: assert_eq!(
    // rust: tag(r#"["Hi ",{"text":"there","bold":true}]"#),
    // rust: r#"{"text":"Hi ","extra":[{"text":"there","bold":true}]}"#
    // rust: );
    // rust: assert_eq!(
    // rust: tag(r#"{"translate":"a","with":["b",{"text":"c","color":"red"}]}"#),
    // rust: r#"{"translate":"a","with":["b",{"text":"c","color":"red"}]}"#
    // rust: );
}

    // The owner's login never waits on the profile fetch, even one that
    // never answers, and carries no properties.
the_owners_login_never_waits_on_the_profile_fetch :: proc() {
}
    // rust: let (_hold, never) = channel::<()>();
    // rust: let config = crate::lan::NetConfig {
    // rust: announce: false,
    // rust: listen: false,
    // rust: owner_profile: Some(Arc::new(crate::lan::OwnerProfile::new(move || {
    // rust: let _ = never.recv();
    // rust: Vec::new()
    // rust: }))),
    // rust: ..crate::lan::NetConfig::loopback(0, "Owner - World".into(), 8)
}
    // rust: let lan =
    // rust: crate::lan::Lan::start_with(Arc::new(crate::lan::data::SyncData::empty()), config)
    // rust: .unwrap();
    // rust: let start = Instant::now();
    // rust: let owner = login_profile(Connection::local(lan.connect_local().unwrap()), "Owner");
    // rust: assert!(
    // rust: start.elapsed() < Duration::from_secs(1),
    // rust: "{:?}",
    // rust: start.elapsed()
    // rust: );
    // rust: assert_eq!(owner.uuid, offline_uuid("Owner"));
    // rust: assert!(owner.properties.is_empty());
}

unpack :: proc(out: Out) -> V {
    // Ported from Horizon
    return {}
}
    // rust: match out {
    // rust: Out::Packet(body) => vec![body],
    // rust: Out::Packets(bodies) => bodies,
    // rust: Out::Disconnect(_) => vec![b"disconnect".to_vec()],
}
}

bodies :: proc(rx: ^std::sync::mpsc::Receiver<Out>) -> V {
    // Ported from Horizon
    return {}
}
    // rust: rx.try_iter().map(unpack).collect()
}

packets_sent_after_a_posted_tick_follow_it :: proc() {
}
    // rust: let (tx, rx) = channel();
    // rust: let (tx2, rx2) = channel();
    // rust: let sender = PlayerSender::new(tx, Arc::default());
    // rust: let other = PlayerSender::new(tx2, Arc::default());
    // rust: for round in 0..50u8 {
    // rust: let holding = Holding::start();
    // rust: sender.send(vec![round, 1]);
    // rust: sender.send(vec![round, 2]);
    // rust: other.send(vec![round]);
    // rust: drop(holding);
    // rust: flush_all([&sender, &other]);
    // rust: sender.send(vec![round, 3]);
    // rust: let next = || unpack(rx.recv_timeout(Duration::from_secs(10)).unwrap());
    // rust: assert_eq!(next(), [vec![round, 1], vec![round, 2]]);
    // rust: assert_eq!(next(), [vec![round, 3]]);
    // rust: let got = unpack(rx2.recv_timeout(Duration::from_secs(10)).unwrap());
    // rust: assert_eq!(got, [vec![round]]);
}
    // rust: let holding = Holding::start();
    // rust: sender.send(vec![9]);
    // rust: drop(holding);
    // rust: flush_all([&sender]);
    // rust: sender.disconnect(horizon_world::nbt::Tag::Byte(0));
    // rust: let next = || unpack(rx.recv_timeout(Duration::from_secs(10)).unwrap());
    // rust: assert_eq!(next(), [vec![9]]);
    // rust: assert_eq!(next(), [b"disconnect".to_vec()]);
        // Nothing sent twice.
    // rust: assert!(rx.try_recv().is_err());
}

shared_frames_are_the_frames_compressed_here :: proc() {
}
//         use horizon_protocol::frame;
    // rust: let frames = SharedFrames::new(usize::MAX);
    // rust: let a: Vec<u8> = (0..40_000u32).map(|i| (i * 7 % 13) as u8).collect();
    // rust: let mut b = a.clone();
    // rust: b[20_000] ^= 1;
    // rust: for (body, threshold) in [(&a, 256), (&b, 256), (&a, 256), (&a, 64), (&b, 256)] {
    // rust: let shared = frames.contents(body, threshold).unwrap();
    // rust: assert_eq!(*shared, *frame::contents(body, Some(threshold)).unwrap());
}
        // One frame per body and threshold.
    // rust: assert_eq!(frames.frames.lock().unwrap().frames.len(), 3);
}

    // Senders asking for the same body at once share one compression: they
    // all get the frame the first made.
a_body_compressed_now_is_not_compressed_again :: proc() {
}
    // rust: let frames = SharedFrames::new(usize::MAX);
    // rust: let body: Vec<u8> = (0..400_000u32).map(|i| (i * 7 % 251) as u8).collect();
    // rust: let start = std::sync::Barrier::new(8);
    // rust: let made: Vec<Arc<[u8]>> = std::thread::scope(|scope| {
    // rust: let threads: Vec<_> = (0..8)
    // rust: .map(|_| {
    // rust: scope.spawn(|| {
    // rust: start.wait();
    // rust: frames.contents(&body, 256).unwrap()
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: threads.into_iter().map(|t| t.join().unwrap()).collect()
    // rust: });
    // rust: assert!(made.iter().all(|m| Arc::ptr_eq(m, &made[0])));
    // rust: let cache = frames.frames.lock().unwrap();
    // rust: assert_eq!(cache.frames.len(), 1);
    // rust: assert_eq!(cache.bytes, made[0].len());
}

shared_frames_keep_the_newest_within_their_limit :: proc() {
}
    // rust: let first = SharedFrames::new(0)
    // rust: .contents(&[1; 9000], 256)
    // rust: .unwrap()
    // rust: .len();
    // rust: let frames = SharedFrames::new(first * 2);
    // rust: for n in 0..5u8 {
    // rust: frames.contents(&[n; 9000], 256).unwrap();
}
    // rust: let cache = frames.frames.lock().unwrap();
    // rust: assert!((1..=2).contains(&cache.frames.len()));
    // rust: assert_eq!(cache.order.len(), cache.frames.len());
    // rust: assert_eq!(
    // rust: cache.bytes,
    // rust: cache
    // rust: .frames
    // rust: .values()
    // rust: .map(|f| f.get().unwrap().as_ref().unwrap().len())
    // rust: .sum::<usize>()
    // rust: );
    // rust: assert!(cache.bytes <= first * 2);
}

held_packets_go_together_and_in_order :: proc() {
}
    // rust: let (tx, rx) = channel();
    // rust: let sender = PlayerSender::new(tx, Arc::default());
    // rust: sender.send(vec![1]);
    // rust: assert_eq!(bodies(&rx), [vec![vec![1]]]);
    // rust: let holding = Holding::start();
    // rust: sender.send(vec![2]);
    // rust: sender.send(vec![3]);
    // rust: assert!(bodies(&rx).is_empty());
    // rust: drop(holding);
        // A packet sent after the tick still follows the held ones.
    // rust: sender.send(vec![4]);
    // rust: assert_eq!(bodies(&rx), [vec![vec![2], vec![3]], vec![vec![4]]]);
    // rust: let holding = Holding::start();
    // rust: sender.send(vec![5]);
    // rust: sender.disconnect(horizon_world::nbt::Tag::Byte(0));
    // rust: drop(holding);
    // rust: sender.flush();
    // rust: assert_eq!(bodies(&rx), [vec![vec![5]], vec![b"disconnect".to_vec()]]);
    // rust: assert_eq!(sender.pending.load(Ordering::Relaxed), 5);
}

    // A client that answers no keep-alive is timed out 30 s after the last
    // one it answered was sent (or after joining).
a_silent_client_times_out :: proc() {
}
    // rust: let ago = |s| Instant::now().checked_sub(Duration::from_secs(s)).unwrap();
    // rust: let watch = |start, answered| KeepAliveWatch {
    // rust: start,
    // rust: alive: Arc::new(AtomicI64::new(answered)),
}
    // rust: assert!(!watch(ago(29), -1).timed_out());
    // rust: assert!(watch(ago(31), -1).timed_out());
        // Answered the keep-alive sent 15 s in: fine until 45 s.
    // rust: assert!(!watch(ago(44), 15_000).timed_out());
    // rust: assert!(watch(ago(46), 15_000).timed_out());
}

a_rate_over_the_limit_kicks :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let second = Duration::from_secs(1);
        // Off at 0 (and below).
    // rust: assert!(PacketRate::new(0, t0).is_none());
    // rust: assert!(PacketRate::new(-1, t0).is_none());
    // rust: let mut rate = PacketRate::new(10, t0).unwrap();
        // 15 packets inside the first second average 3.75 at the tick.
    // rust: for _ in 0..15 {
    // rust: assert_eq!(rate.received(t0), None);
}
    // rust: assert_eq!(rate.received(t0 + second), None);
        // 50 a second averages 12.5: over a limit of 10 at the first tick.
    // rust: let mut rate = PacketRate::new(10, t0).unwrap();
    // rust: for _ in 0..50 {
    // rust: rate.received(t0);
}
    // rust: assert_eq!(rate.received(t0 + second), Some(12.5));
}

an_idle_gap_decays_without_a_loop :: proc() {
}
    // rust: let t0 = Instant::now();
    // rust: let mut rate = PacketRate {
    // rust: limit: 100.0,
    // rust: received: 0,
    // rust: average: 40.0,
    // rust: next: t0,
}
        // Ten seconds later: one tick (0 packets: 40 * 0.75 = 30), then ten
        // more packetless decays — ~1.69 — with `next` past now.
    // rust: assert_eq!(rate.received(t0 + Duration::from_secs(10)), None);
    // rust: assert!(rate.average > 1.5 && rate.average < 2.0, "{}", rate.average);
    // rust: assert!(rate.next > t0 + Duration::from_secs(10));
}
}
